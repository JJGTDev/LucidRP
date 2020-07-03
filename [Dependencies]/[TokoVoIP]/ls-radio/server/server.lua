ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('ls-radio:checkRadio', function(source, cb, str)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local radioItem = 'radio'
	local radio = xPlayer.getInventoryItem(radioItem).count
	local hasRadio = false

	if radio > 0 and radioItem == 'radio' then
		hasRadio = true
		cb(hasRadio)
		return
	end

	TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'You must have a radio to join a channel.', })

	cb(hasRadio)
end)

ESX.RegisterUsableItem('radio', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('ls-radio:use', source)

end)
