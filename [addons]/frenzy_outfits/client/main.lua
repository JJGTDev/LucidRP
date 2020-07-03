local HasAlreadyEnteredMarker, CurrentAction, CurrentActionMsg
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function OpenClosetMenu()
	local elements = {}

	table.insert(elements, {label = _U('player_clothes'), value = 'player_dressing'})
	table.insert(elements, {label = _U('remove_cloth'), value = 'remove_cloth'})

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'closet', {
		title    = _U('closet'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		local currentLabel, currentValue = data.current.label, data.current.value

		if data.current.value == 'player_dressing' then

			ESX.TriggerServerCallback('frenzy_outfits:getPlayerDressing', function(dressing)
				local elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing', {
					title    = _U('player_clothes'),
					align    = 'bottom-right',
					elements = elements
				}, function(data2, menu2)
					TriggerEvent('skinchanger:getSkin', function(skin)
						ESX.TriggerServerCallback('frenzy_outfits:getPlayerOutfit', function(clothes)
							TriggerEvent('skinchanger:loadClothes', skin, clothes)
							TriggerEvent('esx_skin:setLastSkin', skin)
							TriggerEvent('skinchanger:getSkin', function(skin)
								TriggerServerEvent('esx_skin:save', skin)
							end)
						end, data2.current.value)
					end)
				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		elseif data.current.value == 'remove_cloth' then

			ESX.TriggerServerCallback('frenzy_outfits:getPlayerDressing', function(dressing)
				local elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_cloth', {
					title    = _U('remove_cloth'),
					align    = 'bottom-right',
					elements = elements
				}, function(data2, menu2)
					menu2.close()
					TriggerServerEvent('frenzy_outfits:removeOutfit', data2.current.value)
					ESX.ShowNotification(_U('removed_cloth'))
				end, function(data2, menu2)
					menu2.close()
				end)
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords, letSleep = GetEntityCoords(PlayerPedId()), true

		for k,v in pairs(Config.Zones) do
			if (Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v, true) < Config.DrawDistance) then
				DrawMarker(Config.Type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
				letSleep = false
			end
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)

		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker = false
		local currentZone, LastZone

		for k,v in pairs(Config.Zones) do
			if GetDistanceBetweenCoords(coords, v, true) < Config.Size.x then
				isInMarker  = true
				currentZone = 'Closet'
				LastZone    = 'Closet'
			end
		end

		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('frenzy_outfits:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('frenzy_outfits:hasExitedMarker', LastZone)
		end
	end
end)

AddEventHandler('frenzy_outfits:hasEnteredMarker', function(zone)
	if zone == 'Closet' then
		CurrentAction     = 'closet'
		CurrentActionMsg  = _U('closet_prompt')
		CurrentActionData = {zone = zone}
	end
end)

AddEventHandler('frenzy_outfits:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'closet' then
					OpenClosetMenu()
				end
				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)
