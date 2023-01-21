Config = {}

Config.ShowBlips = true
Config.PromptKey = 0xE30CD707 -- R

Config.Objects = {
    ["cone"] = {model = `prop_roadcone02a`, freeze = false},
    ["barrier"] = {model = `prop_barrier_work06a`, freeze = true},
    ["roadsign"] = {model = `prop_snow_sign_road_06g`, freeze = true},
    ["tent"] = {model = `prop_gazebo_03`, freeze = true},
    ["light"] = {model = `prop_worklight_03b`, freeze = true},
}

Config.MaxSpikes = 5

Config.HandCuffItem = 'handcuffs'

Config.LicenseRank = 2

Config.Locations = {
    ["duty"] = {
        [1] = vector3(3364.33, -701.58, 45.16) -- prison
       
    },
    ["stash"] = {
        [1] = vector3(3362.42, -657.73, 46.33) -- prison
        
    },
    ["vehicle"] = {
        [1] = vector4(-278.82, 826.41, 119.33, 7.5), -- Valentine Stable
        [2] = vector4(2493.22, -1321.87, 48.87, 271.06), -- Saint Denis
        [3] = vector4(1380.34, -1329.07, 77.64, 176.64), -- Rhodes
        [4] = vector4(-1801.48, -354.12, 164.13, 222.05), -- Strawberry
        [5] = vector4(-769.05, -1254.9, 43.4, 358.53) -- Blackwater
    },
    ["armory"] = {
        [1] = vector3(3371.19, -658.08, 46.33) -- Rhodes
    },
    ["evidence"] = {
        [1] = vector3(3380.94, -671.42, 46.3) -- Rhodes
        
    },
    ["stations"] = {
        [1] = {label = "guards", coords = vector3(3380.94, -671.42, 46.3)}, -- Rhodes
    },
}

Config.AuthorizedVehicles = {
	-- Grade 0
	[0] = {
		["policewagon01x"] = "Police Vagon",
	},
	-- Grade 1
	[1] = {
		["policewagon01x"] = "Police Vagon",
	},
	-- Grade 2
	[2] = {
		["policewagon01x"] = "Police Vagon",
	},
	-- Grade 3
	[3] = {
		["policewagon01x"] = "Police Vagon",
	},
	-- Grade 4
	[4] = {
		["policewagon01x"] = "Police Vagon",
	}
}

Config.WeaponHashes = {}

Config.ArmoryWhitelist = {}
Config.WhitelistedVehicles = {}

Config.Items = {
    label = "Guard Armory",
    slots = 6,
    items = {
        {
            name = "weapon_revolver_cattleman",
            price = 0,
            amount = 5,
            info = {
                serie = "",
            },
            type = "weapon",
            slot = 1,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        {
            name = "weapon_repeater_winchester",
            price = 0,
            amount = 5,
            info = {
                serie = "",
            },
            type = "weapon",
            slot = 2,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        {
            name = "weapon_melee_lantern",
            price = 0,
            amount = 5,
            info = {},
            type = "weapon",
            slot = 3,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        {
            name = "weapon_lasso",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 4,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        {
            name = "ammo_revolver",
            price = 0,
            amount = 500,
            info = {},
            type = "item",
            slot = 5,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        {
            name = "ammo_repeater",
            price = 0,
            amount = 500,
            info = {},
            type = "item",
            slot = 6,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
    }
}
