-- Dependencies:
-- https://forum.fivem.net/t/release-fivem-to-discord/62618
-- A command that sends a report to your Discord using @flatracer’s FiveM to Discord resource:
function GetTime()

    local timestamp = os.time()
    local day	= os.date('*t', timestamp).wday			-- 0 = Everyday, 1 = Sunday, 2 = Monday and so on.
    local hour	= tonumber(os.date('%I', timestamp))		-- 12 hour time [01-12] (Use %H for 24 hour time [00-23])
    local minute	= tonumber(os.date('%M', timestamp))		-- Minutes. [00-59]

    return {day = day, hour = hour, minute = minute}

end
CommandPack("Report Pack", "glitchdetector", {
    -- Add commands here
    -- Report command, sends a message to Discord
    {
        command = "report",
        format = "#message#",
        help = "Report an issue to the staff team",
        usage = "/report [issue]",
        args = {{name = "issue", help = "Your issue"}},
        hidden = true, -- Prevents the message from being shown in chat
        cb = function(source, message)
            -- Sends a message to discord using the FiveM to Discord resource
            local identifier = GetPlayerIdentifiers(source)[1]
            local time = GetTime()
            print(os.time())
            TriggerEvent('DiscordBot:ToDiscord', 'reports', ('%s (%s) reports an issue '..time.hour..":"..time.minute.." ("..identifier..")"):format(GetPlayerName(source), source), message, 'https://wiki.fivem.net/w/images/d/db/FiveM-Wiki.png', true)
        end,
    },
}, {
    -- Default values
})
