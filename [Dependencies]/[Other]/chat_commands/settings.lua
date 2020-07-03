--[[
    Note:
     - When updating the resource (if ever needed), please keep a copy of your settings so you don't lose them
     - Only enable framework compatibility if your server is running said framework
]]

SETTINGS = {
    show_id = true, --  makes the name also include the players ID
    logging = true, -- enables print output to the console (and chat during commands)
    use_esx = true, -- enables ESX compatibility for admin commands, and for advanced commands
    use_vrp = false, -- enables vRP compatibility for admin commands, and for advanced commands
    use_framework_name = true, -- replaces the players name with their framework name, such as vRP identity
    cb = function(source, message, command, args, raw)
        -- You can do things after any command is executed (useful for logging)
        local identifier = GetPlayerIdentifiers(source)[1]
        local name = GetPlayerName(source)
        fal2 = name.." "..identifier
        TriggerEvent('DiscordBot:ToDiscord', 'system', fal2.." Chat command", raw, 'IMAGE_URL', true)
    end,
    check_updates = true, -- check for updates on startup (recommended)
}
