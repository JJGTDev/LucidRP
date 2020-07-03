ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_carlock:getOwnedVehicles', function(source, cb)
    local identifier = GetPlayerIdentifier(source, 0)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {
        ['@owner'] = identifier,
    }, function(results)
        if #results > 0 then
            cb(results)
        else
            cb({})
        end
    end)
end)