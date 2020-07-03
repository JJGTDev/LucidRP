ESX = nil
local bancache = {} -- id,sender,sender_name,receiver,reason,length
local open_assists,active_assists = {},{}
local toggle = false
Citizen.CreateThread(function() -- startup
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    while ESX==nil do Wait(0) end

    MySQL.ready(function()
        refreshBanCache()
    end)

    sendToDiscord("Starting logger...")

    ESX.RegisterServerCallback("frenzy_admin:ban", function(source,cb,target,reason,length,offline)
        if not target or not reason then return end
        local xPlayer = ESX.GetPlayerFromId(source)
        local xTarget = ESX.GetPlayerFromId(target)
        if not xPlayer or (not xTarget and not offline) then cb(nil); return end
        if isAdmin(xPlayer) then
            local success, reason = banPlayer(xPlayer,offline and target or xTarget,reason,length,offline)
            cb(success, reason)
        else logUnfairUse(xPlayer); cb(false) end
    end)

    ESX.RegisterServerCallback("frenzy_admin:getBanList",function(source,cb)
        local xPlayer = ESX.GetPlayerFromId(source)
        if isAdmin(xPlayer) then
            local banlist,namecache = {},{}
            for k,v in ipairs(MySQL.Sync.fetchAll("SELECT * FROM frenzy_bans")) do
                if namecache[v.sender]==nil then namecache[v.sender] = MySQL.Sync.fetchScalar("SELECT name FROM users WHERE identifier=@id",{["@id"]=v.sender}) end -- my shot at optimalization of db queries
                v["sender_name"]=namecache[v.sender]
                table.insert(banlist,v)
            end
            cb(json.encode(banlist))
        else logUnfairUse(xPlayer); cb(false) end
    end)

    ESX.RegisterServerCallback("frenzy_admin:unban",function(source,cb,id)
        local xPlayer = ESX.GetPlayerFromId(source)
        if isAdmin(xPlayer) then
            MySQL.Async.execute("DELETE FROM frenzy_bans WHERE id=@id",{["@id"]=id},function(rc)
                local bannedidentifier = "N/A"
                for k,v in ipairs(bancache) do
                    if v.id==id then
                        bannedidentifier = v.receiver[1]
                        table.remove(bancache,k)
                        break
                    end
                end
                logAdmin(("Admin ^1%s^7 unbanned ^1%s^7 (%s)"):format(xPlayer.getName(),bannedidentifier~="N/A" and MySQL.Sync.fetchScalar("SELECT name FROM users WHERE identifier=@id",{["@id"]=bannedidentifier}) or "N/A",bannedidentifier))
                cb(rc>0)
            end)
        else logUnfairUse(xPlayer); cb(false) end
    end)
end)

RegisterServerEvent("frenzy_admin:kickAll")
AddEventHandler("frenzy_admin:kickAll", function()
    print('suppose to kick')
    DropPlayer(source, "Server restarting")
end)

AddEventHandler("playerConnecting",function(name, setKick, def)
    local banned, data = isBanned(GetPlayerIdentifiers(source))
    if banned then
        print(("Banned player %s (%s) tried to join, their ban expires on %s (Ban ID: #%s)"):format(GetPlayerName(source),data.receiver[1],data.length and os.date("%Y-%m-%d %H:%M",data.length) or "PERMANENT",data.id))
        local kickmsg = Config.banformat:format(data.reason,data.length and os.date("%Y-%m-%d %H:%M",data.length) or "PERMANENT",data.sender_name,data.id)
        if Config.backup_kick_method then DropPlayer(source,kickmsg) else def.done(kickmsg) end
    end
end)

AddEventHandler("playerDropped",function(reason)
    if open_assists[source] then open_assists[source]=nil end
    for k,v in ipairs(active_assists) do
        if v==source then
            active_assists[k]=nil
            -- TriggerClientEvent("chat:addMessage",k,{color={255,0,0},multiline=false,args={"SYSTEM","The admin that was helping you dropped from the server"}})
            return
        elseif k==source then
            TriggerClientEvent("frenzy_admin:assistDone",v)
            -- TriggerClientEvent("chat:addMessage",v,{color={255,0,0},multiline=false,args={"SYSTEM","The player you were helping dropped from the server, teleporting back..."}})
            active_assists[k]=nil
            return
        end
    end
end)

function refreshBanCache()
    bancache={}
    local namecache = {}
    for k,v in ipairs(MySQL.Sync.fetchAll("SELECT id,receiver,sender,reason,UNIX_TIMESTAMP(length) AS length FROM frenzy_bans")) do
        if namecache[v.sender]==nil then namecache[v.sender] = MySQL.Sync.fetchScalar("SELECT name FROM users WHERE identifier=@id",{["@id"]=v.sender}) end -- my shot at optimalization of db queries
        table.insert(bancache,{id=v.id,sender=v.sender,sender_name=namecache[v.sender],receiver=json.decode(v.receiver),reason=v.reason,length=v.length})
    end
end

function sendToDiscord(msg)
    if Config.discord_webhook~=nil then
        PerformHttpRequest(Config.discord_webhook, function(a,b,c)end, "POST", json.encode({embeds={{title="BWH Action Log",description=msg,color=65280,}}}), {["Content-Type"]="application/json"})
    end
end

function logAdmin(msg)
    for k,v in ipairs(ESX.GetPlayers()) do
        if isAdmin(ESX.GetPlayerFromId(v)) then
            --TriggerClientEvent("chat:addMessage",v,{color={255,0,0},multiline=false,args={"BWH",msg}})
            sendToDiscord(msg:gsub("%^%d",""))
        end
    end
end

function isBanned(identifiers)
    for _,ban in ipairs(bancache) do
        if ban.length==nil or ban.length>os.time() then
            for _,bid in ipairs(ban.receiver) do
                for _,pid in ipairs(identifiers) do
                    if bid==pid then return true, ban end
                end
            end
        end
    end
    return false, nil
end

function isAdmin(xPlayer)
    local admin = false
    for k,v in ipairs(Config.admin_groups) do
        if xPlayer.getGroup()==v then 
            return true 
        end
    end
    return false
end

function execOnAdmins(func)
    local ac = 0
    for k,v in ipairs(ESX.GetPlayers()) do
        if isAdmin(ESX.GetPlayerFromId(v)) then
            ac = ac + 1
            func(v)
        end
    end
    return ac
end

function logUnfairUse(xPlayer)
    if not xPlayer then return end
    print((GetCurrentResourceName()..": Player %s (%s) tried to use an admin feature"):format(xPlayer.getName(),xPlayer.identifier))
    logAdmin(("Player %s (%s) tried to use an admin feature"):format(xPlayer.getName(),xPlayer.identifier))
end

function banPlayer(xPlayer,xTarget,reason,length,offline)
    local targetidentifiers,offlinename,timestring = nil,nil,nil
    if offline then
        data = MySQL.Sync.fetchAll("SELECT license,name FROM users WHERE identifier=@identifier",{["@identifier"]=xTarget})
        if #data<1 then
            return false, "~r~Identifier is not in users database!"
        end
        targetidentifiers = {xTarget,data[1].license} -- in this case xTarget is an identifier
        offlinename = data[1].name
    else
        targetidentifiers = GetPlayerIdentifiers(xTarget.source)
    end
    MySQL.Async.execute("INSERT INTO frenzy_bans(id,receiver,sender,length,reason) VALUES(NULL,@receiver,@sender,@length,@reason)",{["@receiver"]=json.encode(targetidentifiers),["@sender"]=xPlayer.identifier,["@length"]=length,["@reason"]=reason},function(_)
        local banid = MySQL.Sync.fetchScalar("SELECT MAX(id) FROM frenzy_bans")
        logAdmin(("Player ^1%s^7 (%s) got banned by ^1%s^7, expiration: %s, reason: '%s'"..(offline and " (OFFLINE BAN)" or "")):format(offline and offlinename or xTarget.getName(),offline and targetidentifiers[1] or xTarget.identifier,xPlayer.getName(),length~=nil and length or "PERMANENT",reason))
        if length~=nil then
            timestring=length
            local year,month,day,hour,minute = string.match(length,"(%d+)/(%d+)/(%d+) (%d+):(%d+)")
            length = os.time({year=year,month=month,day=day,hour=hour,min=minute})
        end
        table.insert(bancache,{id=banid==nil and "1" or banid,sender=xPlayer.identifier,reason=reason,sender_name=xPlayer.getName(),receiver=targetidentifiers,length=length})
        if offline then xTarget = ESX.GetPlayerFromIdentifier(xTarget) end -- just in case the player is on the server, you never know
        if xTarget then DropPlayer(xTarget.source,Config.banformat:format(reason,length~=nil and timestring or "PERMANENT",xPlayer.getName(),banid==nil and "1" or banid)) else return false, "~r~Unknown error (MySQL?)" end
        return true
    end)
end

function warnPlayer(xPlayer,xTarget,message,anon)
    MySQL.Async.execute("INSERT INTO frenzy_warnings(id,receiver,sender,message) VALUES(NULL,@receiver,@sender,@message)",{["@receiver"]=xTarget.identifier,["@sender"]=xPlayer.identifier,["@message"]=message})
    TriggerClientEvent("frenzy_admin:receiveWarn",xTarget.source,anon and "" or xPlayer.getName(),message)
    logAdmin(("Admin ^1%s^7 warned ^1%s^7 (%s), Message: '%s'"):format(xPlayer.getName(),xTarget.getName(),xTarget.identifier,message))
end

TriggerEvent('es:addCommand', 'ban', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if isAdmin(xPlayer) then
        TriggerClientEvent("frenzy_admin:showWindow",source,"ban")
    -- else
    --     TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"SYSTEM","You don't have permissions to use this command!"}})
    end
end)

TriggerEvent('es:addCommand', 'banrefresh', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if isAdmin(xPlayer) then
        TriggerClientEvent("chat:addMessage",source,{template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args={"SYSTEM","Refreshing ban cache..."}})
        refreshBanCache()
    -- else
    --     TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"SYSTEM","You don't have permissions to use this command!"}})
    end
end)

TriggerEvent('es:addCommand', 'banlist', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if isAdmin(xPlayer) then
        TriggerClientEvent("frenzy_admin:showWindow",source,'banlist')
    -- else
    --     TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"SYSTEM","You don't have permissions to use this command!"}})
    end
end)

if Config.enable_ban_json or Config.enable_warning_json then
    SetHttpHandler(function(req,res)
        if req.path=="/bans.json" and Config.enable_ban_json then
            MySQL.Async.fetchAll("SELECT * FROM frenzy_bans",{},function(data)
                res.send(json.encode(data))
            end)
        elseif req.path=="/warnings.json" and Config.enable_warning_json then
            MySQL.Async.fetchAll("SELECT * FROM frenzy_warnings",{},function(data)
                res.send(json.encode(data))
            end)
        end
    end)
end

RegisterCommand('vis', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    toggle = not toggle
    if isAdmin(xPlayer) then
        TriggerClientEvent("frenzy_admin:vis", source, toggle)
    -- else
    --     TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"SYSTEM","You don't have permissions to use this command!"}})
    end
end, false)

RegisterCommand('toggleids', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    toggle = not toggle
    if isAdmin(xPlayer) then
        TriggerClientEvent("frenzy_admin:toggleIds", source, toggle)
    -- else
    --     TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"SYSTEM","You don't have permissions to use this command!"}})
    end
end, false)

RegisterCommand("spectate", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if isAdmin(xPlayer) then
        TriggerClientEvent("frenzy_admin:requestSpectate", source, tonumber(args[1]))
    -- else
    --     TriggerClientEvent("chat:addMessage",source,{color={255,0,0},multiline=false,args={"SYSTEM","You don't have permissions to use this command!"}})
    end
end, false)