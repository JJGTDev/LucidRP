ESX = nil

local Dropped = false
local PlayerData = {}
local isDead = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

local radioMenu = false

function PrintChatMessage(text)
    TriggerEvent('chatMessage', "system", { 255, 0, 0 }, text)
end

function enableRadio(enable)

    SetNuiFocus(true, true)
    radioMenu = enable

    SendNUIMessage({

        type = "enableui",
        enable = enable

    })


end

---
Citizen.CreateThread(function()

    while true do
        Citizen.Wait(1)
        while ESX ~= nil do
            Citizen.Wait(0)
            while xPlayer ~= nil do
                Citizen.Wait(500)

                local inventory = xPlayer.inventory
                local count = 0

                if inventory ~= nil then
                    for i = 1, #inventory, 1 do
                        if inventory[i].name == 'radio' then
                            count = inventory[i].count
                            if count >= 1 then
                                Dropped = false
                            else
                                if Dropped == false then
                                    Dropped = true
                                    TriggerEvent('ls-radio:onRadioDrop', _source)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        while ESX ~= nil do
            Citizen.Wait(5000)
            xPlayer = ESX.GetPlayerData()
        end

    end
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/radio', 'Choose a radio channel 1-100 (Channels 1-7 are Restricted)', {{ name="radioChannels", help="Available types: 1-100 (Channels 1-3 are Restricted)" }})
end)

RegisterCommand('radio', function(source, args)
    local str = args[1]

    if str == nil then
        exports['mythic_notify']:SendAlert('error', 'You need to provide a channel for the radio!')
        return
    end

    ESX.TriggerServerCallback('ls-radio:checkRadio', function (hasRadio)
        if hasRadio == true then
            if str == 'off' then
                leaveRadio()
            else
                local data = {
                    channel = str
                }
                joinRadio(source, data)
            end
        end
    end, str)

end, false)

-- RegisterCommand('radiotest', function(source, args)
--     local playerName = GetPlayerName(PlayerId())
--     local data = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")

--     print(tonumber(data))

--     if data == "nil" then
--         exports['mythic_notify']:DoHudText('inform', Config.messages['not_on_radio'])
--     else
--         exports['mythic_notify']:DoHudText('inform', Config.messages['on_radio'] .. data .. '.00 MHz </b>')
--     end

-- end, false)

RegisterNUICallback('joinRadio', function(data, cb)
    joinRadio(source, data)
    --[[
  exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
  exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
  exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
  PrintChatMessage("radio: " .. data.channel)
  print('radiook')
    ]]--
    cb('ok')
end)

-- opuszczanie radia

RegisterNUICallback('leaveRadio', function(data, cb)
    leaveRadio()
    cb('ok')
end)

function leaveRadio()
    local playerName = GetPlayerName(PlayerId())
    local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")
    --print(getPlayerRadioChannel)
    if getPlayerRadioChannel == "nil" then
        --exports['mythic_notify']:DoHudText('inform', Config.messages['not_on_radio'])
    else
        --print('suppose to remove')
        exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
        exports.tokovoip_script:setPlayerData(playerName, "radio:channel", "nil", true)
        exports.tokovoip_script:refreshAllPlayerData(true);
        --exports['mythic_notify']:DoHudText('inform', Config.messages['you_leave'] .. getPlayerRadioChannel .. '.00 MHz </b>')
    end
end

function joinRadio(source, data)
    local _source = source
    local PlayerData = ESX.GetPlayerData(_source)
    local playerName = GetPlayerName(PlayerId())
    local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel")

    if tonumber(data.channel) ~= tonumber(getPlayerRadioChannel) then
        if tonumber(data.channel) <= Config.RestrictedChannels then
            if tonumber(data.channel) <= Config.RestrictedChannels and tonumber(data.channel) > Config.RestrictedRTOChannels and not (PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'rescue') then
                if PlayerData.job.name == 'mechanic' or PlayerData.job.name == 'bennys' or PlayerData.job.name == 'lscustoms' then
                    exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
                    exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
                    exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
                    exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
                elseif not PlayerData.job.name == 'mechanic' or not PlayerData.job.name == 'bennys' or not PlayerData.job.name == 'lscustoms' then
                    exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
                end
            elseif (PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'rescue') then
                exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
                exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
                exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
                exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
            elseif not (PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'rescue') then
                exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
            end
        end

        if tonumber(data.channel) > Config.RestrictedChannels then
            ESX.TriggerServerCallback('TokoVoip:checkPlayersOnRadio', function (playerCount)
                if playerCount > Config.MaxNumberUsers then
                    exports['mythic_notify']:DoHudText('error', 'Failed to join channel due to the max number of users</b>')
                    return
                end
                exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
                exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
                exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
                exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
            end, data.channel)
        end
    else
        exports['mythic_notify']:DoHudText('error', Config.messages['you_on_radio'] .. data.channel .. '.00 MHz </b>')
    end
end

AddEventHandler('playerSpawned', function(spawn)
    isDead = false
    leaveRadio()
end)

RegisterNetEvent('ls-radio:onRadioDrop')
AddEventHandler('ls-radio:onRadioDrop', function(source)
    leaveRadio()
end)

RegisterNUICallback('escape', function(data, cb)

    enableRadio(false)
    SetNuiFocus(false, false)

    cb('ok')
end)


RegisterNetEvent('ls-radio:use')
AddEventHandler('ls-radio:use', function()
    enableRadio(true)
end)

Citizen.CreateThread(function()
    while true do
        if radioMenu then
            DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
            DisableControlAction(0, 2, guiEnabled) -- LookUpDown

            DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate

            DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride

            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({
                    type = "click"
                })
            end
        end
        Citizen.Wait(0)
    end
end)