local RSGCore = exports['rsg-core']:GetCoreObject()

-- Variables
local PlayerStatus = {}

-- Functions
local UpdateBlips = function()
    local dutyPlayers = {}
    local players = RSGCore.Functions.GetRSGPlayers()

    for _, v in pairs(players) do
        if v and (v.PlayerData.job.name == "prison" or v.PlayerData.job.name == "ambulance") and v.PlayerData.job.onduty then
            local coords = GetEntityCoords(GetPlayerPed(v.PlayerData.source))
            local heading = GetEntityHeading(GetPlayerPed(v.PlayerData.source))

            dutyPlayers[#dutyPlayers + 1] =
            {
                source = v.PlayerData.source,
                label = v.PlayerData.metadata["callsign"],
                job = v.PlayerData.job.name,
                location =
                {
                    x = coords.x,
                    y = coords.y,
                    z = coords.z,
                    w = heading
                }
            }
        end
    end

    TriggerClientEvent("prison:client:UpdateBlips", -1, dutyPlayers)
end

local GetCurrentCops = function()
    local amount = 0
    local players = RSGCore.Functions.GetRSGPlayers()

    for _, v in pairs(players) do
        if v.PlayerData.job.name == "prison" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end

    return amount
end

-- Commands
RSGCore.Commands.Add("cuff", Lang:t("commands.cuff_player"), {}, false, function(source, args)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)

    if Player.PlayerData.job.name == "prison" and Player.PlayerData.job.onduty then
        TriggerClientEvent("prison:client:CuffPlayer", src)
    else
        TriggerClientEvent('RSGCore:Notify', src, Lang:t("error.on_duty_prison_only"), 'error')
    end
end)

RSGCore.Commands.Add("escort", Lang:t("commands.escort"), {}, false, function(source, args)
    local src = source

    TriggerClientEvent("prison:client:EscortPlayer", src)
end)

RSGCore.Commands.Add("callsign", Lang:t("commands.callsign"), {{name = "name", help = Lang:t('info.callsign_name')}}, false, function(source, args)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)

    Player.Functions.SetMetaData("callsign", table.concat(args, " "))
end)

RSGCore.Commands.Add("jail", Lang:t("commands.jail_player"), {{name = "id", help = Lang:t('info.player_id')}, {name = "time", help = Lang:t('info.jail_time')}}, true, function(source, args)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)

    if Player.PlayerData.job.name == "prison" and Player.PlayerData.job.onduty then
        local playerId = tonumber(args[1])
        local time = tonumber(args[2])

        if time > 0 then
            TriggerClientEvent("prison:client:JailCommand", src, playerId, time)
        else
            TriggerClientEvent('RSGCore:Notify', src, Lang:t('info.jail_time_no'), 'primary')
        end
    else
        TriggerClientEvent('RSGCore:Notify', src, Lang:t("error.on_duty_prison_only"), 'error')
    end
end)

RSGCore.Commands.Add("unjail", Lang:t("commands.unjail_player"), {{name = "id", help = Lang:t('info.player_id')}}, true, function(source, args)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)

    if Player.PlayerData.job.name == "prison" and Player.PlayerData.job.onduty then
        local playerId = tonumber(args[1])

        TriggerClientEvent("prison:client:UnjailPerson", playerId)
    else
        TriggerClientEvent('RSGCore:Notify', src, Lang:t("error.on_duty_prison_only"), 'error')
    end
end)

RSGCore.Commands.Add("seizecash", Lang:t("commands.seizecash"), {}, false, function(source)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)

    if Player.PlayerData.job.name == "prison" and Player.PlayerData.job.onduty then
        TriggerClientEvent("prison:client:SeizeCash", src)
    else
        TriggerClientEvent('RSGCore:Notify', src, Lang:t("error.on_duty_prison_only"), 'error')
    end
end)

RSGCore.Commands.Add("sc", Lang:t("commands.softcuff"), {}, false, function(source)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)

    if Player.PlayerData.job.name == "prison" and Player.PlayerData.job.onduty then
        TriggerClientEvent("prison:client:CuffPlayerSoft", src)
    else
        TriggerClientEvent('RSGCore:Notify', src, Lang:t("error.on_duty_prison_only"), 'error')
    end
end)

-- Usable Items
RSGCore.Functions.CreateUseableItem("handcuffs", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)

    if Player.Functions.GetItemByName(item.name) then
        TriggerClientEvent("prison:client:CuffPlayerSoft", src)
    end
end)

-- Callbacks
RSGCore.Functions.CreateCallback('prison:GetPlayerStatus', function(source, cb, playerId)
    local Player = RSGCore.Functions.GetPlayer(playerId)
    local statList = {}

    if Player then
        if PlayerStatus[Player.PlayerData.source] and next(PlayerStatus[Player.PlayerData.source]) then
            for k, _ in pairs(PlayerStatus[Player.PlayerData.source]) do
                statList[#statList + 1] = PlayerStatus[Player.PlayerData.source][k].text
            end
        end
    end

    cb(statList)
end)

RSGCore.Functions.CreateCallback('prison:GetCops', function(source, cb)
    local amount = 0
    local players = RSGCore.Functions.GetRSGPlayers()

    for _, v in pairs(players) do
        if v.PlayerData.job.name == "prison" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end

    cb(amount)
end)

RSGCore.Functions.CreateCallback('prison:server:GetSuspectHorse', function(source, cb, id)
    local Player = RSGCore.Functions.GetPlayer(id)

    if not Player then return end

    local citizenid = Player.PlayerData.citizenid

    local result = MySQL.query.await('SELECT * FROM player_horses WHERE citizenid=@citizenid AND active=@active',
    {
        citizenid = citizenid,
        active = 1
    })

    if not result[1] then return end

    cb(result[1])
end)

-- Events
RegisterNetEvent('prison:server:prisonAlert', function(text)
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local players = RSGCore.Functions.GetRSGPlayers()

    for _, v in pairs(players) do
        if v.PlayerData.job.name == 'prison' and v.PlayerData.job.onduty then
            TriggerClientEvent('prison:client:prisonAlert', v.PlayerData.source, coords, text)
        end
    end
end)

RegisterNetEvent('prison:server:CuffPlayer', function(playerId, isSoftcuff)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local CuffedPlayer = RSGCore.Functions.GetPlayer(playerId)

    if not CuffedPlayer then return end

    if Player.Functions.GetItemByName("handcuffs") or Player.PlayerData.job.name == "prison" then
        TriggerClientEvent("prison:client:GetCuffed", CuffedPlayer.PlayerData.source, Player.PlayerData.source, isSoftcuff)
    end
end)

RegisterNetEvent('prison:server:EscortPlayer', function(playerId)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(source)
    local EscortPlayer = RSGCore.Functions.GetPlayer(playerId)

    if not EscortPlayer then return end

    if (Player.PlayerData.job.name == "prison" or Player.PlayerData.job.name == "ambulance")
    or (EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"]
    or EscortPlayer.PlayerData.metadata["inlaststand"])
    then
        TriggerClientEvent("prison:client:GetEscorted", EscortPlayer.PlayerData.source, Player.PlayerData.source)
    else
        TriggerClientEvent('RSGCore:Notify', src, Lang:t("error.not_cuffed_dead"), 'error')
    end
end)

RegisterNetEvent('prison:server:JailPlayer', function(playerId, time)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local OtherPlayer = RSGCore.Functions.GetPlayer(playerId)
    local currentDate = os.date("*t")

    if currentDate.day == 31 then
        currentDate.day = 30
    end

    if Player.PlayerData.job.name ~= "prison" or not OtherPlayer then return end
	local name = OtherPlayer.PlayerData.charinfo.firstname.." "..OtherPlayer.PlayerData.charinfo.lastname
exports['slrp-newspaper']:CreateJailStory(name, time)

    OtherPlayer.Functions.SetMetaData("injail", time)
    OtherPlayer.Functions.SetMetaData("criminalrecord",
    {
        ["hasRecord"] = true,
        ["date"] = currentDate
    })

    TriggerClientEvent("prison:client:SendToJail", OtherPlayer.PlayerData.source, time)
    TriggerClientEvent('RSGCore:Notify', src, Lang:t("info.sent_jail_for", {time = time}), 'primary')
end)

RegisterNetEvent('prison:server:SetHandcuffStatus', function(isHandcuffed)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)

    if not Player then return end

    Player.Functions.SetMetaData("ishandcuffed", isHandcuffed)
end)

RegisterNetEvent('prison:server:SearchPlayer', function(playerId)
    local src = source
    local SearchedPlayer = RSGCore.Functions.GetPlayer(playerId)

    if not SearchedPlayer then return end

    TriggerClientEvent('RSGCore:Notify', src, Lang:t("info.cash_found", {cash = SearchedPlayer.PlayerData.money["cash"]}), 'primary')
    TriggerClientEvent('RSGCore:Notify', SearchedPlayer.PlayerData.source, Lang:t("info.being_searched"), 'primary')
end)

RegisterNetEvent('prison:server:SeizeCash', function(playerId)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local SearchedPlayer = RSGCore.Functions.GetPlayer(playerId)

    if not SearchedPlayer then return end

    local moneyAmount = SearchedPlayer.PlayerData.money["cash"]
    local info = {cash = moneyAmount}

    if SearchedPlayer.Functions.RemoveMoney("cash", moneyAmount, "prison-cash-seized") then
        Player.Functions.AddItem("moneybag", 1, false, info)

        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items["moneybag"], "add")
        TriggerClientEvent('RSGCore:Notify', SearchedPlayer.PlayerData.source, Lang:t("info.cash_confiscated"), 5000, 0, 'blips', 'blip_radius_search', 'COLOR_WHITE')
    end
end)

RegisterNetEvent('prison:server:RobPlayer', function(playerId)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local SearchedPlayer = RSGCore.Functions.GetPlayer(playerId)

    if not SearchedPlayer then return end

    local money = SearchedPlayer.PlayerData.money["cash"]

    if SearchedPlayer.Functions.RemoveMoney("cash", money, "prison-player-robbed") then
        Player.Functions.AddMoney("cash", money, "prison-player-robbed")

        TriggerClientEvent('RSGCore:Notify', SearchedPlayer.PlayerData.source, Lang:t("info.cash_robbed", {money = money}), 5000, 0, 'blips', 'blip_radius_search', 'COLOR_WHITE')
        TriggerClientEvent('RSGCore:Notify', Player.PlayerData.source, Lang:t("info.stolen_money", {stolen = money}), 5000, 0, 'blips', 'blip_radius_search', 'COLOR_WHITE')
    end
end)

RegisterNetEvent('evidence:server:UpdateStatus', function(data)
    local src = source
    PlayerStatus[src] = data
end)

RegisterNetEvent('prison:server:UpdateCurrentCops', function()
    local amount = 0
    local players = RSGCore.Functions.GetRSGPlayers()

    for _, v in pairs(players) do
        if v.PlayerData.job.name == "prison" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end

    TriggerClientEvent("prison:SetCopCount", -1, amount)
end)

-- Threads
CreateThread(function()
    while true do
        Wait(1000 * 60 * 10)

        local curCops = GetCurrentCops()

        TriggerClientEvent("prison:SetCopCount", -1, curCops)
    end
end)

CreateThread(function()
    while true do
        Wait(5000)

        UpdateBlips()
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        CreateThread(function()
            MySQL.Async.execute("DELETE FROM stashitems WHERE stash='prisontrash'")
        end)
    end
end)