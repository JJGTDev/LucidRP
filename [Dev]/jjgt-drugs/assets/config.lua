Config = {}

Config.Weed = {
    sellPriceMin = 10,
    sellPriceMax = 100,
    sellItem = 'weed_bag',
    seedItem = 'weed_seed',
    harvestItem = 'weed',
    props = {
        'bkr_prop_weed_01_small_01b',
        'bkr_prop_weed_01_small_01a',
        'bkr_prop_weed_med_01a', 
        'bkr_prop_weed_med_01b',
        'bkr_prop_weed_lrg_01a',
        'bkr_prop_weed_lrg_01b'
    },
    -- Table = make the pot and weed to plant the shit
    table = {
        empty = 'bkr_prop_weed_table_01b',
        ready = 'bkr_prop_weed_table_01a',
        timeToMake = 20, -- Seconds
        items = { -- items to turn table from empty to ready
            {name = 'pot', amount = 1}
        }
    }
}