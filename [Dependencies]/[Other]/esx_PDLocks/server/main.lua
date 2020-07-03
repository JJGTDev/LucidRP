ESX = nil
local doorInfo = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_PDLocks:updateState')
AddEventHandler('esx_PDLocks:updateState', function(doorID, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	if type(doorID) ~= 'number' then
		print(('esx_PDLocks: %s didn\'t send a number!'):format(xPlayer.identifier))
		return
	end

	if type(state) ~= 'boolean' then
		print(('esx_PDLocks: %s attempted to update invalid state!'):format(xPlayer.identifier))
		return
	end

	if not Config.DoorList[doorID] then
		print(('esx_PDLocks: %s attempted to update invalid door!'):format(xPlayer.identifier))
		return
	end

	if not IsAuthorized(xPlayer.org.name, Config.DoorList[doorID]) then
		print(('esx_PDLocks: %s was not authorized to open a locked door!'):format(xPlayer.identifier))
		return
	end

	doorInfo[doorID] = state

	TriggerClientEvent('esx_PDLocks:setState', -1, doorID, state)
end)

ESX.RegisterServerCallback('esx_PDLocks:getDoorInfo', function(source, cb)
	cb(doorInfo)
end)

function IsAuthorized(orgName, doorID)
	for _,org in pairs(doorID.authorizedOrgs) do
		if org == orgName then
			return true
		end
	end

	return false
end