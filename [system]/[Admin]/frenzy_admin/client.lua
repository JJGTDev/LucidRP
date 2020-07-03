ESX = nil
local pos_before_assist,assisting,assist_target,last_assist = nil, false, nil, nil
local showIDs = false
local disPlayerNames = 10
local playerDistances = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
	SetNuiFocus(false, false)
end)

function GetIndexedPlayerList()
	local players = {}
	for k,v in ipairs(GetActivePlayers()) do
		players[tostring(GetPlayerServerId(v))]=GetPlayerName(v)..(v==PlayerId() and " (self)" or "")
	end
	return json.encode(players)
end

Citizen.CreateThread(function()
	--Wait(50)
	while true do
		for id = 0, 255 do
			if NetworkIsPlayerActive(id) then
				if GetPlayerPed(id) ~= GetPlayerPed(-1) then
					x1, y1, z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
					x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
					distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
					playerDistances[id] = distance
					if (playerDistances[id] < disPlayerNames and showIDs == true) then
						DrawText3D(x2, y2, z2+1, GetPlayerServerId(id) .. " " .. GetPlayerName(id), 255,255,255)
					end
				end
			end
		end
		Citizen.Wait(7)
	end
end)

function DrawText3D(x,y,z, text, r,g,b)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

	local scale = (1/dist)*2
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov

	if onScreen then
		SetTextScale(0.0*scale, 0.35*scale)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextColour(r, g, b, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

RegisterNUICallback("ban", function(data,cb)
	if not data.target or not data.reason then return end
	ESX.TriggerServerCallback("frenzy_admin:ban",function(success,reason)
		if success then ESX.ShowNotification("~g~Successfully banned player") else ESX.ShowNotification(reason) end
	end, data.target, data.reason, data.length, data.offline)
end)

RegisterNUICallback("unban", function(data,cb)
	if not data.id then return end
	ESX.TriggerServerCallback("frenzy_admin:unban",function(success)
		if success then ESX.ShowNotification("~g~Successfully unbanned player") else ESX.ShowNotification("~r~Something went wrong") end
	end, data.id)
end)

RegisterNUICallback("hidecursor", function(data,cb)
	SetNuiFocus(false, false)
end)

RegisterNetEvent("frenzy_admin:kickAllClient")
AddEventHandler("frenzy_admin:kickAllClient", function()
    TriggerServerEvent("frenzy_admin:kickAll")
end)

RegisterNetEvent("frenzy_admin:requestSpectate")
AddEventHandler('frenzy_admin:requestSpectate', function(id)
	local playerId = GetPlayerFromServerId(id)
	if playerId ~= nil and playerId ~= -1 then
		spectatePlayer(GetPlayerPed(playerId),playerId,GetPlayerName(playerId))
	else
		ESX.ShowNotification('Player does not exist')
	end
end)

RegisterNetEvent("frenzy_admin:showWindow")
AddEventHandler("frenzy_admin:showWindow",function(win)
	if win=="ban" then
		SendNUIMessage({show=true,window=win,players=GetIndexedPlayerList()})
	elseif win=="banlist"  then
		ESX.TriggerServerCallback(win=="banlist" and "frenzy_admin:getBanList",function(list)
			SendNUIMessage({show=true,window=win,list=list})
		end)
	end
	SetNuiFocus(true, true)
end)

RegisterNetEvent("frenzy_admin:vis")
AddEventHandler("frenzy_admin:vis", function(ci)
	ci = not ci
	if ci then
		SetEntityVisible(GetPlayerPed(-1),ci)
		exports['mythic_notify']:SendAlert('error', 'Visible')
	else
		SetEntityVisible(GetPlayerPed(-1),ci)
		exports['mythic_notify']:SendAlert('success', 'Invisible')
	end
end)

RegisterNetEvent("frenzy_admin:toggleIds")
AddEventHandler("frenzy_admin:toggleIds", function(ti)
	if ti then
		showIDs = true
		exports['mythic_notify']:SendAlert('success', 'IDs on')
	else
		showIDs = false
		exports['mythic_notify']:SendAlert('error', 'IDs off')
	end
end)
function DrawPlayerInfo(target)
	drawTarget = target
	drawInfo = true
end

function StopDrawPlayerInfo()
	drawInfo = false
	drawTarget = 0
end
function spectatePlayer(targetPed,target,name)
	local playerPed = PlayerPedId()
	local enable = true
	if targetPed == playerPed then enable = false end

	if(enable)then

			local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

			RequestCollisionAtCoord(targetx,targety,targetz)
			NetworkSetInSpectatorMode(true, targetPed)

			DrawPlayerInfo(target)
			exports['mythic_notify']:SendAlert('success', 'Spectating'..name)
	else

			local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

			RequestCollisionAtCoord(targetx,targety,targetz)
			NetworkSetInSpectatorMode(false, targetPed)

			StopDrawPlayerInfo()
			exports['mythic_notify']:SendAlert('error', 'Stopped spectating')
	end
end
Citizen.CreateThread( function()
	while true do
		Citizen.Wait(5)
		if drawInfo then
			local text = {}
			-- cheat checks
			local targetPed = GetPlayerPed(drawTarget)
			local targetGod = GetPlayerInvincible(drawTarget)
			if targetGod then
				table.insert(text,"godmodedetected")
			else
				table.insert(text,"godmodenotdetected")
			end
			if not CanPedRagdoll(targetPed) and not IsPedInAnyVehicle(targetPed, false) and (GetPedParachuteState(targetPed) == -1 or GetPedParachuteState(targetPed) == 0) and not IsPedInParachuteFreeFall(targetPed) then
				table.insert(text,"antiragdoll")
			end
			-- health info
			table.insert(text,"health"..": "..GetEntityHealth(targetPed).."/"..GetEntityMaxHealth(targetPed))
			table.insert(text,"armor"..": "..GetPedArmour(targetPed))
			-- misc info
			table.insert(text,"wantedlevel"..": "..GetPlayerWantedLevel(drawTarget))
			table.insert(text,"exitspectator")

			for i,theText in pairs(text) do
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.30)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				AddTextComponentString(theText)
				EndTextCommandDisplayText(0.3, 0.7+(i/30))
			end

			if IsControlJustPressed(0,103) then
				local targetPed = PlayerPedId()
				local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

				RequestCollisionAtCoord(targetx,targety,targetz)
				NetworkSetInSpectatorMode(false, targetPed)

				StopDrawPlayerInfo()
				ESX.ShowNotification('Stopped spectating.')
			end

		end
	end
end)