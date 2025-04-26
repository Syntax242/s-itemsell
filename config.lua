Config = {}
-- s-itemsell: The ultimate item selling script to take your server to the next level! 
-- Developed by Syntax 
Config.Locale = {
    sell_menu_header = "Selling Menu",
    sell_menu_exit = "Exit",
    sell_menu_exit_desc = "Close the menu",
    selling_progress = "Selling in progress...",
    notify_no_item = "You don't have the item to sell!",
    notify_sell_success = "You sold %{count}x %{item} and earned $%{price}.",
    notify_sell_fail = "No sellable item found.",
    notify_sell_cancel = "Selling was cancelled.",
    notify_seller_inactive = "This seller is not active at the moment.",
    price_prefix = "Price: ",
    notify_no_access = "You don't have access to this seller!",
    notify_police_alert = "A suspicious sale has been reported!", 
    blip_police_alert = "Suspicious Activity",
}

Config.PoliceJobs = { "police", "bcso", "sheriff", "sasp" }

Config.PoliceBlip = {
    sprite = 161,  -- Blip sprite ID   (https://docs.fivem.net/docs/game-references/blips/#blips)
    color = 1,     -- Blip color ID   (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
    scale = 1.2,   -- Blip scale          
    time = 30000   -- Blip Time (in milliseconds)
}

Config.Sellers = {
    {
        name = "Drug Dealer", -- Name of the seller (for internal use)
        npcModel = "s_m_y_dealer_01", -- NPC model
        coords = vector4(1300.7, 4318.84, 38.16, 306.24), -- NPC spawn coordinates
        items = { -- Items that this seller will buy
            { item = "cocaine", name = "💊 Cocaine Package", price = 500 },  -- item = item code, name = displayed name, price = item price
            { item = "weed", name = "🌿 Weed Bundle", price = 300 },
            { item = "meth", name = "🧪 Methamphetamine Bottle", price = 700 },
        },
        progressTime = 5000, -- Time for progress bar during selling (in milliseconds)
        activeHours = { enable = false, start = 22, stop = 4 }, -- Enable active time? If true, seller spawns between set hours
        alertPolice = { enable = true, chance = 100 }, -- Alert police on sale? (chance in %)
        moneyType = "black_money", -- What type of money item to give? (cash / black_money)
        targetLabel = "Sell Drugs", -- Text shown on qb-target when interacting
        menuHeader = "Drug Trade Point", -- Title shown on the selling menu
        effect = true, -- Play visual/sound effect after selling?
        job = false, -- If false, everyone can access. If set to a job name, only that job can access. job = false, or job = "jobname"
        blip = { -- Map blip settings
            enable = true,
            sprite = 500, -- Blip sprite ID   (https://docs.fivem.net/docs/game-references/blips/#blips)
            color = 2, -- Blip color ID   (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
            scale = 0.7, -- Blip scale
            name = "Drug Dealer" -- Blip label
        }
    },
    {
        name = "Weapon Dealer", -- Name of the seller (for internal use)
        npcModel = "g_m_m_armboss_01", -- NPC model (Cartel Boss, looks tough)
        coords = vector4(247.45, -3315.65, 5.79, 182.0), -- NPC spawn coordinates
        items = { -- Items that this seller will buy
            { item = "weapon_parts", name = "🔧 Weapon Parts", price = 1200 }, -- item = item code, name = displayed name, price = item price
            { item = "pistol_ammo", name = "🔫 Pistol Ammo", price = 400 },
            { item = "rifle_ammo", name = "🎯 Rifle Ammo", price = 700 },
        },
        progressTime = 12000, -- Time for progress bar during selling (in milliseconds)
        activeHours = { enable = true, start = 21, stop = 5 }, -- Enable active time? If true, seller spawns between set hours
        alertPolice = { enable = true, chance = 30 }, -- Alert police on sale? (chance in %)
        moneyType = "black_money", -- What type of money item to give? (cash / black_money)
        targetLabel = "Sell Weapons", -- Text shown on qb-target when interacting
        menuHeader = "Weapon Trade Point", -- Title shown on the selling menu
        effect = true, -- Play visual/sound effect after selling?
        job = false, -- If false, everyone can access. If set to a job name, only that job can access   job = false, or job = "jobname",
        blip = { -- Map blip settings
            enable = true,
            sprite = 110, -- Blip sprite ID   (https://docs.fivem.net/docs/game-references/blips/#blips)
            color = 1, -- Blip color ID   (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
            scale = 0.7, -- Blip scale
            name = "Weapon Dealer"  -- Blip label
        }
    },
    {
        name = "Greengrocer", -- Name of the seller (for internal use)
        npcModel = "s_m_m_linecook", -- NPC model (looks like a market seller or worker)
        coords = vector4(1793.23, 4595.14, 37.68, 191.65), -- NPC spawn coordinates
        items = { -- Items that this seller will buy
            { item = "apple", name = "🍎 Fresh Apple", price = 10 },  -- item = item code, name = displayed name, price = item price
            { item = "banana", name = "🍌 Ripe Banana", price = 8 },
            { item = "carrot", name = "🥕 Organic Carrot", price = 6 },
        },
        progressTime = 8000, -- Time for progress bar during selling (in milliseconds)
        activeHours = { enable = false, start = 15, stop = 2 }, -- Enable active time? If true, seller spawns between set hours
        alertPolice = { enable = false, chance = 15 }, -- Alert police on sale? (chance in %)
        moneyType = "cash", -- Gives clean cash item
        targetLabel = "Sell Produce", -- Text shown on qb-target when interacting
        menuHeader = "Greengrocer Stall", -- Title shown on the selling menu
        effect = false, -- No special effect needed
        job = false, -- Everyone can access
        blip = { -- Map blip settings
            enable = true,
            sprite = 365, -- Blip sprite ID   (https://docs.fivem.net/docs/game-references/blips/#blips)
            color = 2,  -- Blip color ID   (https://docs.fivem.net/docs/game-references/blips/#blip-colors)    
            scale = 0.7, -- Blip scale
            name = "Greengrocer" -- Blip label
        }
    }
}
