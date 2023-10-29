Config = {}

Config.ShowBlips = true
Config.PromptKey = 0xE30CD707 -- R

Config.HandCuffItem = 'handcuffs'

Config.Locations =
{
    ["duty"] =
    {
        [1] = vector3(3391.32, -673.00, 49.48), -- sisika
        
    },
    ["stash"] =
    {
        [1] = vector3(3395.25, -670.45, 49.47), -- sisika
        
    },
    ["vehicle"] =
    {
        [1] = vector4(3351.55, -639.99, 45.29, 76.68), -- sisika
       
    },
    ["armory"] =
    {
        [1] = vector3(3393.43, -671.39, 49.46), -- sisika
        
    },
    ["evidence"] =
    {
        [1] = vector3(3399.75, -676.05, 49.48), --sisika
        
    },
    ["stations"] =
    {
        [1] = {label = "Guard", coords = vector3(3399.75, -676.05, 49.48)}, -- sisika
        
    },
}

Config.AuthorizedVehicles =
{
    -- Grade 0
    [0] =
    {
        ["policewagon01x"] = "Police Vagon",
    },
    -- Grade 1
    [1] =
    {
        ["policewagon01x"] = "Police Vagon",
    },
    -- Grade 2
    [2] =
    {
        ["policewagon01x"] = "Police Vagon",
    },
    -- Grade 3
    [3] =
    {
        ["policewagon01x"] = "Police Vagon",
    },
    -- Grade 4
    [4] =
    {
        ["policewagon01x"] = "Police Vagon",
    }
}

Config.WeaponHashes = {}

Config.Items =
{
    label = "Armory",
    slots = 6,
    items =
    {
        {
            name = "weapon_revolver_cattleman",
            price = 0,
            amount = 1,
            info =
            {
                serie = "",
            },
            type = "weapon",
            slot = 1,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        {
            name = "weapon_repeater_winchester",
            price = 0,
            amount = 1,
            info =
            {
                serie = "",
            },
            type = "weapon",
            slot = 2,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        {
            name = "weapon_melee_lantern",
            price = 0,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 3,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        {
            name = "weapon_lasso",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 4,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        {
            name = "ammo_revolver",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 5,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        {
            name = "ammo_repeater",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 6,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
		{
            name = "handcuffs",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 7,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        }
    }
}