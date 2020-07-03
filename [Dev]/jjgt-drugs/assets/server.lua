
Framework = nil
TriggerEvent('esx:getSharedObject', function(result) Framework = result end)
Weed = {
    -- level 0 / 6
    {x = -754.03, y = -1433.93, z = 4.0, level = 0, weed = 0}
}
Tables = {
    {x = -755.37, y = -1436.45, z = 4.0, ready = false}
}

Framework.RegisterServerCallback('drugs:getTables', function(source, cb)
    cb(Tables)
end)
Framework.RegisterServerCallback('drugs:getWeed', function(source, cb)
    cb(Weed)
end)