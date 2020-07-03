TriggerEvent("es:addGroup", "mod", "user", function(group) end)

-- Modify if you want, btw the _admin_ needs to be able to target the group and it will work
local groupsRequired = {
	slay = "mod",
	noclip = "admin",
	crash = "superadmin",
	freeze = "mod",
	bring = "mod",
	["goto"] = "mod",
	slap = "mod",
	slay = "mod",
	kick = "mod",
	ban = "admin"
}

local banned = ""
local bannedTable = {}

function loadBans()
	banned = LoadResourceFile(GetCurrentResourceName(), "bans.json") or ""
	if banned ~= "" then
		bannedTable = json.decode(banned)
	else
		bannedTable = {}
	end
end

RegisterCommand("refresh_bans", function()
	loadBans()
end, true)

function loadExistingPlayers()
	TriggerEvent("es:getPlayers", function(curPlayers)
		for k,v in pairs(curPlayers)do
			TriggerClientEvent("es_admin:setGroup", v.get('source'), v.get('group'))
		end
	end)
end

loadExistingPlayers()

function removeBan(id)
	bannedTable[id] = nil
	SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(bannedTable), -1)
end

function isBanned(id)
	if bannedTable[id] ~= nil then
		if bannedTable[id].expire < os.time() then
			removeBan(id)
			return false
		else
			return bannedTable[id]
		end
	else
		return false
	end
end

function permBanUser(bannedBy, id)
	bannedTable[id] = {
		banner = bannedBy,
		reason = "Permanently banned from this server",
		expire = 0
	}

	SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(bannedTable), -1)
end

function banUser(expireSeconds, bannedBy, id, re)
	bannedTable[id] = {
		banner = bannedBy,
		reason = re,
		expire = (os.time() + expireSeconds)
	}

	SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(bannedTable), -1)
end

AddEventHandler('playerConnecting', function(user, set)
	for k,v in ipairs(GetPlayerIdentifiers(source))do
		local banData = isBanned(v)
		if banData ~= false then
			set("Banned for: " .. banData.reason .. "\nExpires: " .. (os.date("%c", banData.expire)))
			CancelEvent()
			break
		end
	end
end)

AddEventHandler('es:incorrectAmountOfArguments', function(source, wantedArguments, passedArguments, user, command)
	if(source == 0)then
		print("Argument count mismatch (passed " .. passedArguments .. ", wanted " .. wantedArguments .. ")")
	else
		TriggerClientEvent('chat:addMessage', source, {
			args = {"System", "Incorrect amount of arguments! (" .. passedArguments .. " passed, " .. requiredArguments .. " wanted)"},
			template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',
		})
	end
end)

RegisterServerEvent('es_admin:all')
AddEventHandler('es_admin:all', function(type)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:canGroupTarget', user.getGroup(), "admin", function(available)
			if available or user.getGroup() == "superadmin" then
				if type == "slay_all" then TriggerClientEvent('es_admin:quick', -1, 'slay') end
				if type == "bring_all" then TriggerClientEvent('es_admin:quick', -1, 'bring', Source) end
				if type == "slap_all" then TriggerClientEvent('es_admin:quick', -1, 'slap') end
			else
				TriggerClientEvent('chat:addMessage', Source, {
					template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "You do not have permission to do this"}
				})
			end
		end)
	end)
end)

RegisterServerEvent('es_admin:quick')
AddEventHandler('es_admin:quick', function(id, type)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:getPlayerFromId', id, function(target)
			TriggerEvent('es:canGroupTarget', user.getGroup(), groupsRequired[type], function(available)
				TriggerEvent('es:canGroupTarget', user.getGroup(), target.getGroup(), function(canTarget)
					if canTarget and available then
						if type == "slay" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "noclip" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "freeze" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "crash" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "bring" then TriggerClientEvent('es_admin:quick', id, type, Source) end
						if type == "goto" then TriggerClientEvent('es_admin:quick', Source, type, id) end
						if type == "slap" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "slay" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "kick" then DropPlayer(id, 'Kicked by es_admin GUI') end

						if type == "ban" then
							local id
							local ip
							for k,v in ipairs(GetPlayerIdentifiers(source))do
								if string.sub(v, 1, string.len("steam:")) == "steam:" then
									permBanUser(user.identifier, v)
								-- elseif string.sub(v, 1, string.len("license:")) == "license:" then
								-- 	permBanUser(user.identifier, v) 
								elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
									permBanUser(user.identifier, v)
								end
							end

							DropPlayer(id, GetConvar("es_admin_banreason", "You were banned from this server"))
						end
					else
						if not available then
							TriggerClientEvent('chat:addMessage', Source, {
								template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "You do not have permission to do this"}
							})
						else
							TriggerClientEvent('chat:addMessage', Source, {
								template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "You do not have permission to do this"}
							})
						end
					end
				end)
			end)
		end)
	end)
end)

AddEventHandler('es:playerLoaded', function(Source, user)
	TriggerClientEvent('es_admin:setGroup', Source, user.getGroup())
end)

RegisterServerEvent('es_admin:set')
AddEventHandler('es_admin:set', function(t, USER, GROUP)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:canGroupTarget', user.getGroup(), "admin", function(available)
			if available then
			if t == "group" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chat:addMessage', source, {
						template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Player not found"}
					})
				else
					TriggerEvent("es:getAllGroups", function(groups)
						if(groups[GROUP])then
							TriggerEvent("es:setPlayerData", USER, "group", GROUP, function(response, success)
								TriggerClientEvent('es_admin:setGroup', USER, GROUP)
								TriggerClientEvent('chat:addMessage', -1, {
									template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',
									args = {"Console", "Group of ^2^*" .. GetPlayerName(tonumber(USER)) .. "^r^0 has been set to ^2^*" .. GROUP}
								})
							end)
						else
							TriggerClientEvent('chat:addMessage', Source, {
								template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Group not found"}
							})
						end
					end)
				end
			elseif t == "level" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chat:addMessage', Source, {
						template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Player not found"}
					})
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent("es:setPlayerData", USER, "permission_level", GROUP, function(response, success)
							if(true)then
								TriggerClientEvent('chat:addMessage', -1, {
									args = {"^1CONSOLE", "Permission level of ^2" .. GetPlayerName(tonumber(USER)) .. "^0 has been set to ^2 " .. tostring(GROUP)}
								})
							end
						end)

						TriggerClientEvent('chat:addMessage', Source, {
							template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Permission level of ^2" .. GetPlayerName(tonumber(USER)) .. "^0 has been set to ^2 " .. tostring(GROUP)}
						})
					else
						TriggerClientEvent('chat:addMessage', Source, {
							template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Invalid integer entered"}
						})
					end
				end
			elseif t == "money" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chat:addMessage', Source, {
						template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Player not found"}
					})
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent('es:getPlayerFromId', USER, function(target)
							target.setMoney(GROUP)
						end)
					else
						TriggerClientEvent('chat:addMessage', Source, {
							template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Invalid integer entered"}
						})
					end
				end
			elseif t == "bank" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chat:addMessage', Source, {
						template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Player not found"}
					})
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent('es:getPlayerFromId', USER, function(target)
							target.setBankBalance(GROUP)
						end)
					else
						TriggerClientEvent('chat:addMessage', Source, {
							template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Invalid integer entered"}
						})
					end
				end
			end
			else
				TriggerClientEvent('chat:addMessage', Source, {
					template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Superadmin required to do this"}
				})
			end
		end)
	end)
end)

RegisterCommand('setadmin', function(source, args, raw)
	local player = tonumber(args[1])
	local level = tonumber(args[2])
	if args[1] then
		if (player and GetPlayerName(player)) then
			if level then
				TriggerEvent("es:setPlayerData", tonumber(args[1]), "permission_level", tonumber(args[2]), function(response, success)
					RconPrint(response)
		
					TriggerClientEvent('es:setPlayerDecorator', tonumber(args[1]), 'rank', tonumber(args[2]), true)
					TriggerClientEvent('chat:addMessage', -1, {
						args = {"^1CONSOLE", "Permission level of ^2" .. GetPlayerName(tonumber(args[1])) .. "^0 has been set to ^2 " .. args[2]}
					})
				end)
			else
				RconPrint("Invalid integer\n")
			end
		else
			RconPrint("Player not ingame\n")
		end
	else
		RconPrint("Usage: setadmin [user-id] [permission-level]\n")
	end
end, true)

-- Default commands
TriggerEvent('es:addCommand', 'admin', function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, {
		template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Level: ^*^2 " .. tostring(user.get('permission_level'))}
	})
	TriggerClientEvent('chat:addMessage', source, {
		template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Group: ^*^2 " .. user.getGroup()}
	})
end, {help = "Shows what admin level you are and what group you're in"})

-- Ban a person
-- TriggerEvent("es:addGroupCommand", 'ban', "admin", function(source, args, user)
-- 	local Source = source
-- 	if args[1] then
-- 		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
-- 			local player = tonumber(args[1])

-- 			-- User permission check
-- 			TriggerEvent("es:getPlayerFromId", player, function(target)
-- 				TriggerEvent('es:canGroupTarget', user.getGroup(), target.getGroup(), function(canTarget)
-- 					if canTarget then
-- 						local reason = args
-- 						table.remove(reason, 1)
-- 						local time = args[1]
-- 						table.remove(reason, 1)
-- 						if(#reason == 0)then
-- 							reason = "You have been banned from the server"
-- 						else
-- 							reason = "" .. table.concat(reason, " ")
-- 						end

-- 						-- Awful shit logic but eh, it works?
-- 						-- Days
-- 						if string.find(time, "m")then
-- 							time = math.floor(time:gsub("%m", "") * 60)
-- 						elseif string.find(time, "h") then
-- 							time = math.floor(time:gsub("%h", "") * 60 * 60)
-- 						elseif string.find(time, "d") then
-- 							time = math.floor(time:gsub("%d", "") * 60 * 60 * 24)
-- 						elseif string.find(time, "y") then
-- 							time = math.floor(time:gsub("%y", "") * 60 * 60 * 24 * 365)
-- 						end

-- 						TriggerClientEvent('chat:addMessage', -1, {
-- 							template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Player ^2" .. GetPlayerName(player) .. "^0 has been kicked(^2" .. reason .. "^0)"}
-- 						})
-- 						banUser(time, user.getIdentifier(), target.getIdentifier(), reason)
-- 						DropPlayer(player, "Banned for: " .. reason .. "\nExpires: " .. (os.date("%c", os.time() + time)))
-- 					else
-- 						TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "You can not target this person"}})
-- 					end
-- 				end)
-- 			end)
-- 		else
-- 			TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Incorrect player ID"}})
-- 		end
-- 	else
-- 		TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Incorrect player ID"}})
-- 	end
-- end)

function GetTime()

    local timestamp = os.time()
    local day	= os.date('*t', timestamp).wday			-- 0 = Everyday, 1 = Sunday, 2 = Monday and so on.
    local hour	= tonumber(os.date('%I', timestamp))		-- 12 hour time [01-12] (Use %H for 24 hour time [00-23])
    local minute	= tonumber(os.date('%M', timestamp))		-- Minutes. [00-59]

    return {day = day, hour = hour, minute = minute}

end

-- Report to admins
TriggerEvent('es:addCommand', 'report', function(source, args, user)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Please use the city website or Discordia for issues', length = 5000 })
	-- TriggerClientEvent('chat:addMessage', source, {
	-- 	template = '<div class="chat-message-report"><b>{0}:</b> {1}</div>',
	-- 	args = {"Report", " (^2" .. GetPlayerName(source) .. " | " .. source .. "^0) " .. table.concat(args, " ")}
	-- })
	-- TriggerEvent("es:getPlayers", function(pl)
	-- 	for k,v in pairs(pl) do
	-- 		TriggerEvent("es:getPlayerFromId", k, function(user)
	-- 			if((user.getGroup() == 'superadmin' or user.getGroup() == 'admin') and k ~= source) then
	-- 				TriggerClientEvent('chat:addMessage', k, {
	-- 					args = {"Report", " (^2" .. GetPlayerName(source) .." | ^1" .. source .. " ^2| "..user.getIdentifier().."^0) " .. table.concat(args, " ")},
	-- 					template = '<div class="chat-message-report"><b>{0}:</b> {1}</div>',
	-- 				})
	-- 			end
	-- 		end)
	-- 	end
	-- end)
	-- TriggerEvent('DiscordBot:ToDiscord', 'reports', GetPlayerName(source) .." | "..source, table.concat(args, " "), 'IMAGE_URL', true)
end, {help = "Report a player or an issue", params = {{name = "report", help = "What you want to report"}}})

-- Noclip
TriggerEvent('es:addGroupCommand', 'noclip', "admin", function(source, args, user)
	TriggerClientEvent("es_admin:noclip", source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Insufficienct permissions!"} })
end, {help = "Enable or disable noclip"})

-- Kicking
TriggerEvent('es:addGroupCommand', 'kick', "mod", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				local reason = args
				table.remove(reason, 1)
				if(#reason == 0)then
					reason = "Kicked: You have been kicked from the server"
				else
					reason = "Kicked: " .. table.concat(reason, " ")
				end

				TriggerClientEvent('chat:addMessage', source, {
					template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Player ^2" .. GetPlayerName(player) .. "^0 has been kicked(^2" .. reason .. "^0)"}
				})
				DropPlayer(player, reason)
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Incorrect player ID"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Incorrect player ID"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Insufficienct permissions!"} })
end, {help = "Kick a user with the specified reason or no reason", params = {{name = "userid", help = "The ID of the player"}, {name = "reason", help = "The reason as to why you kick this player"}}})

-- Announcing
TriggerEvent('es:addGroupCommand', 'announce', "admin", function(source, args, user)
	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',
		args = {"Announcement", table.concat(args, " ")}
	})
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Insufficienct permissions!"} })
end, {help = "Announce a message to the entire server", params = {{name = "announcement", help = "The message to announce"}}})

-- Freezing
local frozen = {}
TriggerEvent('es:addGroupCommand', 'freeze', "mod", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				if(frozen[player])then
					frozen[player] = false
				else
					frozen[player] = true
				end

				TriggerClientEvent('es_admin:freezePlayer', player, frozen[player])

				local state = "unfrozen"
				if(frozen[player])then
					state = "frozen"
				end

				TriggerClientEvent('chat:addMessage', player, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "You have been " .. state .. " by ^2" .. GetPlayerName(source)} })
				TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Player ^2" .. GetPlayerName(player) .. "^0 has been " .. state} })
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Incorrect player ID"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Incorrect player ID"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Insufficienct permissions!"} })
end, {help = "Freeze or unfreeze a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Bring
TriggerEvent('es:addGroupCommand', 'bring', "mod", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:teleportUser', target.get('source'), user.getCoords().x, user.getCoords().y, user.getCoords().z)

				TriggerClientEvent('chat:addMessage', player, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "You have brought by ^2" .. GetPlayerName(source)} })
				TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Player ^2" .. GetPlayerName(player) .. "^0 has been brought"} })
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Incorrect player ID"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Incorrect player ID"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Insufficienct permissions!"} })
end, {help = "Teleport a user to you", params = {{name = "userid", help = "The ID of the player"}}})

-- Slap
TriggerEvent('es:addGroupCommand', 'slap', "admin", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:slap', player)

				TriggerClientEvent('chat:addMessage', player, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "You have slapped by ^2" .. GetPlayerName(source)} })
				TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Player ^2" .. GetPlayerName(player) .. "^0 has been slapped"} })
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Incorrect player ID"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Incorrect player ID"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Insufficienct permissions!"} })
end, {help = "Slap a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Goto
TriggerEvent('es:addGroupCommand', 'goto', "mod", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)
				if(target)then

					TriggerClientEvent('es_admin:teleportUser', source, target.getCoords().x, target.getCoords().y, target.getCoords().z)

					TriggerClientEvent('chat:addMessage', player, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "You have been teleported to by ^2" .. GetPlayerName(source)} })
					TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Teleported to player ^2" .. GetPlayerName(player) .. ""} })
				end
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Incorrect player ID"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Incorrect player ID"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Insufficienct permissions!"} })
end, {help = "Teleport to a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Kill yourself
TriggerEvent('es:addGroupCommand', 'die',  "admin", function(source, args, user)
	TriggerClientEvent('es_admin:kill', source)
	TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "You killed yourself"} })
end, {help = "Suicide"})

-- Slay a player
TriggerEvent('es:addGroupCommand', 'slay', "admin", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:kill', player)

				TriggerClientEvent('chat:addMessage', player, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "You have been killed by ^2" .. GetPlayerName(source)} })
				TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Player ^2" .. GetPlayerName(player) .. "^0 has been killed."} })
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Incorrect player ID"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Incorrect player ID"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Insufficienct permissions!"} })
end, {help = "Slay a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Crashing
TriggerEvent('es:addGroupCommand', 'crash', "superadmin", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:crash', player)

				TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Player ^2" .. GetPlayerName(player) .. "^0 has been crashed."} })
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Incorrect player ID"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Incorrect player ID"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args = {"System", "Insufficienct permissions!"} })
end, {help = "Crash a user, no idea why this still exists", params = {{name = "userid", help = "The ID of the player"}}})

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

loadBans()
