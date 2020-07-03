RegisterServerEvent("AFKKickEvent")
AddEventHandler("AFKKickEvent", function()
	DropPlayer(source, "You were AFK for too long.")
end)