Config = {}

-- priority list can be any identifier. (hex steamid, steamid32, ip) Integer = power over other people with priority
-- a lot of the steamid converting websites are broken rn and give you the wrong steamid. I use https://steamid.xyz/ with no problems.
-- you can also give priority through the API, read the examples/readme.
--
-- 5 server admins
-- 4 staff
-- 3 support/influencers
-- 2 streamer queue
-- 1 priority queue
Config.Priority = {
    ["steam:110000109d87e9d"] = 5, -- ReUp
    ["steam:110000104431360"] = 5, -- Felix

    ["steam:110000100e6f8c3"] = 4, -- CrypticError
    ["steam:1100001344db918"] = 4, -- Narcissus 
    ["steam:1100001346e52e4"] = 4, -- bacon/Star
    ["steam:11000010e734833"] = 4, -- aquadevida
    ["steam:110000106c1535d"] = 4, -- pook
    ["steam:110000103a8d972"] = 4, -- nixcluster
    ["steam:1100001075f3066"] = 4, -- Dennrick
    ["steam:11000010bffe8d1"] = 4, -- AquaDeVida
    ["steam:11000013e2ffc93"] = 4, -- Kate
    ["steam:110000117adcc0a"] = 4, -- Fuzzy No Knees

    ["steam:110000101b753a8"] = 3, -- Kubie
    ["steam:11000010a24396a"] = 3, -- polarcola
    ["steam:11000010739f161"] = 3, -- Adnap
    ["steam:11000010acbe8b7"] = 3, -- Strict
    ["steam:110000103a8d972"] = 3, -- Nixcluster
    ["steam:11000013dac3263"] = 3, -- Sw1ffer
    ["steam:110000134850fe1"] = 3, -- Cloroxia
    ["steam:11000013d68d1d1"] = 3, -- KurlieDino
    ["steam:110000134b051e1"] = 3, -- Axci
    ["steam:110000115d7dde6"] = 3, -- Crixicus
    ["steam:1100001003106b7"] = 3, -- SheriffStrafe
    ["steam:11000013b6da959"] = 3, -- ChiefFox
    ["steam:110000119e5e475"] = 3, -- Birexsie
    ["steam:110000106369860"] = 3, -- MrSendIt
    ["steam:11000013d49f183"] = 3, -- ItsMe
    ["steam:11000013d49f183"] = 3, -- Deezy
    ["steam:110000105baa2e5"] = 3, -- TangoCheese
    ["steam:11000014002e0f9"] = 3, -- DrizzleDee89
    ["steam:11000010d8f8307"] = 3, -- GraceWolf
    ["steam:11000013dba7b4b"] = 3, -- FaadedAngels
    ["steam:11000013e98a7bf"] = 3, -- TaRdid
    ["steam:110000104345511"] = 3, -- Nyx
}

-- require people to run steam
Config.RequireSteam = true

-- "whitelist" only server
Config.PriorityOnly = false

-- disables hardcap, should keep this true
Config.DisableHardCap = true

-- will remove players from connecting if they don't load within: __ seconds; May need to increase this if you have a lot of downloads.
-- i have yet to find an easy way to determine whether they are still connecting and downloading content or are hanging in the loadscreen.
-- This may cause session provider errors if it is too low because the removed player may still be connecting, and will let the next person through...
-- even if the server is full. 10 minutes should be enough
Config.ConnectTimeOut = 600

-- will remove players from queue if the server doesn't recieve a message from them within: __ seconds
Config.QueueTimeOut = 90

-- will give players temporary priority when they disconnect and when they start loading in
Config.EnableGrace = true

-- how much priority power grace time will give
Config.GracePower = 4

-- how long grace time lasts in seconds
Config.GraceTime = 180

-- on resource start, players can join the queue but will not let them join for __ milliseconds
-- this will let the queue settle and lets other resources finish initializing
Config.JoinDelay = 60000

-- will show how many people have temporary priority in the connection message
Config.ShowTemp = false

-- simple localization
Config.Language = {
    joining = "\xF0\x9F\x8E\x89Joining...",
    connecting = "\xE2\x8F\xB3Connecting...",
    idrr = "\xE2\x9D\x97[Queue] Error: Couldn't retrieve any of your id's, try restarting.",
    err = "\xE2\x9D\x97[Queue] There was an error",
    pos = "\xF0\x9F\x90\x8CYou are %d/%d in queue \xF0\x9F\x95\x9C%s",
    connectingerr = "\xE2\x9D\x97[Queue] Error: Error adding you to connecting list",
    timedout = "\xE2\x9D\x97[Queue] Error: Timed out?",
    wlonly = "\xE2\x9D\x97[Queue] You must be whitelisted to join this server",
    steam = "\xE2\x9D\x97 [Queue] Error: Steam must be running"
}