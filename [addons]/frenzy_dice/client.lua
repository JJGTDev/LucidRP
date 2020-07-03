Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end
end)

RegisterCommand('rolldie', function(source, args)
    local max = args[1]
    if max == "" or max == nil then
        max = 100
    end
    local number = math.random(1,max)
    local nearbyPlayers = ESX.Game.GetPlayersInArea(GetEntityCoords(GetPlayerPed(-1)), 10, true)
    if #nearbyPlayers <= 0 then
        exports['mythic_notify']:SendAlert('error', 'Noone to participate with')
        return
    end
    local nearbyServerIds = {}
    for k,v in pairs(nearbyPlayers) do
        table.insert(nearbyServerIds, GetPlayerServerId(v))
    end
    local payload = {
        players = nearbyServerIds,
        sender = ESX.GetPlayerData().firstname .. " " .. ESX.GetPlayerData().lastname,
        number = number
    }
    TriggerServerEvent('frenzy_rolldie:sync', payload)
end)

RegisterNetEvent('frenzy_rolldie:number')
AddEventHandler('frenzy_rolldie:number', function(payload)
    exports['mythic_notify']:SendAlert('success', payload.sender .. " just rolled " .. " " .. payload.number, 5000)
end)