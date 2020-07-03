local dbReady = false
local tableQuery = "CREATE TABLE IF NOT EXISTS `ea_bans`( `banid` int(11) NOT NULL UNIQUE AUTO_INCREMENT, `expire` double NOT NULL DEFAULT '10444633200', `identifiers` text NOT NULL, `reason` text NOT NULL, PRIMARY KEY(`banid`)) "

updateScripts = {
	"ALTER TABLE `ea_bans` ADD COLUMN `discord` text NOT NULL",
	"Truncate table `ea_bans`; ALTER TABLE `ea_bans` DROP COLUMN `discord`, DROP `steam`, DROP `identifier`, ADD COLUMN `identifiers` text NOT NULL"
}


local cachedBans = {} -- DO NOT TOUCH

AddEventHandler('onMySQLReady', function ()
	MySQL.Async.execute(tableQuery, {}, function() end)
	print("executed table query")

	-- perform upgrades if necesarry

	MySQL.Async.execute("SELECT count(*) FROM information_schema.COLUMNS WHERE COLUMN_NAME = 'identifiers' and TABLE_NAME = 'ea_bans'", {}, function(count)
		if count == 0 then
			Citizen.Trace("Performin Database Upgrade...")
			local fetchedAllBans = false
			MySQL.Async.fetchAll('SELECT * FROM ea_bans', {}, function(bans)
				cachedBans = bans
				fetchedAllBans = true
				print("retrieved banlist")
			end)
			repeat
				Wait(500)
			until fetchedAllBans
			MySQL.Async.execute(updateScripts[2], {}, function() end)
			for i, ban in ipairs(cachedBans) do
				ban.identifiers = {}
				if ban.identifier then
					table.insert(ban.identifiers, ban.identifier)
					ban.identifier = nil
				end
				if ban.steam then
					table.insert(ban.identifiers, ban.steam)
					ban.steam = nil
				end
				if ban.discord then
					table.insert(ban.identifiers, ban.discord)
					ban.discord = nil
				end
				TriggerEvent("ea_data:addBan", ban)
			end
			print("Performed ea_bans Database Upgrade, no further action is necesarry.")
		end
	end)
	
	
	Wait(100)
	dbReady = true
end)

AddEventHandler('ea_data:retrieveBanlist', function(callback)
	local callback = callback
	while not dbReady do
		Wait(1000)
	end
	MySQL.Async.fetchAll('SELECT * FROM ea_bans', {}, function(bans)
		for i, ban in ipairs(bans) do
			ban.identifiers = json.decode(ban.identifiers)
		end
		callback(bans)
		cachedBans = bans
		print("retrieved banlist")
	end)
end)

AddEventHandler('ea_data:addBan', function(data)
	while not dbReady do
		Wait(1000)
	end
	MySQL.Async.execute("INSERT INTO ea_bans (`banid`, `expire`, `identifiers`, `reason`) VALUES (NULL, @expire, @identifiers, @reason);", {expire = data.expire, identifiers = json.encode(data.identifiers), reason = data.reason }, function() end)
	print("added new ban")
end)

AddEventHandler('ea_data:removeBan', function(data)
	while not dbReady do
		Wait(1000)
	end
	for i,theBan in ipairs(cachedBans) do
		for index,identifier in ipairs(theBan.identifiers) do
			for d, dataidentifier in ipairs(data.identifiers) do
				if dataidentifier == identifier then
					MySQL.Async.execute("DELETE FROM ea_bans WHERE banid = @banid;", {banid = theBan.banid }, function() end)
					print("deleted ban")
					break
				end
			end
		end
	end
end)
