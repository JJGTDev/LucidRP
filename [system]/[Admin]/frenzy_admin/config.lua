Config = {}

Config.admin_groups = {"admin","superadmin"} -- groups that can use admin commands
Config.admin_level = 0 -- min admin level that can use admin commands
Config.banformat = "BANNED!\nReason: %s\nExpires: %s\nBanned by: %s (Ban ID: #%s)" -- message shown when banned (1st %s = reason, 2nd %s = expire, 3rd %s = banner, 4th %s = ban id)
Config.enable_ban_json = false -- http://<server-ip>:<server-port>/el_bwh/bans.json
Config.enable_warning_json = false -- http://<server-ip>:<server-port>/el_bwh/warnings.json
Config.warning_screentime = 7.5 * 1000 -- warning display length (in ms)
Config.backup_kick_method = false -- set this to true if banned players don't get kicked
Config.discord_webhook = nil -- set to nil to disable, otherwise put "<your webhook url here>" <-- with the quotes!