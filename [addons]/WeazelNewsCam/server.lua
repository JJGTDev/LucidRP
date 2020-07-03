ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("cam", function(source, args, raw)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.job.name ~= nil and xPlayer.job.name == 'weazelnews' then
        TriggerClientEvent("Cam:ToggleCam", src)
    end
end)

RegisterCommand("bmic", function(source, args, raw)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.job.name ~= nil and xPlayer.job.name == 'weazelnews' then
        TriggerClientEvent("Mic:ToggleBMic", src)
    end
end)

RegisterCommand("mic", function(source, args, raw)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.job.name ~= nil and xPlayer.job.name == 'weazelnews' then
        TriggerClientEvent("Mic:ToggleMic", src)
    end
end)
