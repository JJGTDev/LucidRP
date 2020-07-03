
Framework = nil
local tablesPlaced = {}
local weedPlaced = {}
Citizen.CreateThread(function()
    while Framework == nil do
        TriggerEvent('esx:getSharedObject', function(result) Framework = result end)
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        Framework.TriggerServerCallback('drugs:getTables', function(result)
            print("Found "..#result.." tables")
            tablesPlaced = result
        end)
        Framework.TriggerServerCallback('drugs:getWeed', function(result)
            print("Found "..#result.." weed planted")
            weedPlaced = result
        end)
    end
end)

RegisterCommand('yolo', function()
    local model = 'bkr_prop_weed_01_small_01a'
    local coords = GetEntityCoords(PlayerPedId())

    for i=0, #tablesPlaced do
        local table = tablesPlaced[i]
        print("Test; "..tablesPlaced[i].x)
        local model = nil
        if table.ready then
            model = Config.Weed.table.ready
        else
            model = Config.Weed.table.empty
        end
        TriggerEvent('drugs:spawnObject', model, {x = table.x, y = table.y, z = table.z})
    end
end)

RegisterNetEvent('drugs:spawnObject')
AddEventHandler('drugs:spawnObject', function(model, coords)
    local hash = GetHashKey(model)
    local doesExist = DoesObjectOfTypeExistAtCoords(
		coords.x, 
		coords.y, 
		coords.z-1, 
		1.0, 
		hash ,
		0
    )
    print("Exist: "..tostring(doesExist))
    Citizen.CreateThread(function()
        if doesExist == false then
            RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
            end
            local obj = CreateObject(hash, coords.x, coords.y, coords.z, true, true, true)
            SetEntityHeading(obj, GetEntityHeading(PlayerPedId()))
            PlaceObjectOnGroundProperly(obj)
        end
    end)
end)