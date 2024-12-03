local QBCore = exports['qb-core']:GetCoreObject()

local players = {}
local searchMeter = {}

local function hasCooldownPassed(src)
    local last = players[src]
    if last then
        local now = GetGameTimer()
        if now - last < Config.General.SearchCooldown then
            return false
        end
    end
    return true
end

local function hasBeenSearched(MeterId)
    local last = searchMeter[MeterId]
    if last then
        local now = GetGameTimer()
        if now - last < Config.General.RefillTime then
            return true
        end
    end
    return false
end

RegisterNetEvent('fr-meterrobbery:server:searchMeter', function(data)
    local src = source

    -- If cooldown didn't pass, display error message to the player with remaining time to wait
    if not hasCooldownPassed(src) then
        local timeLeft = ((players[src] + Config.General.SearchCooldown - GetGameTimer()) / 1000)

        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.cooldown", { time = math.floor(timeLeft) }), "error")
        return
    end

    local MeterId = data.entity
    if hasBeenSearched(MeterId) then
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.hasBeenSearched"), "error")
        return
    end

    TriggerClientEvent('fr-meterrobbery:client:searchMeter', src, MeterId)
end)

RegisterNetEvent('fr-meterrobbery:server:searchedMeter', function(MeterId)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if not player then
        print("Player not found!")
        return
    end

    print("Player found: "..src)

    players[src] = GetGameTimer()
    searchMeter[MeterId] = GetGameTimer()

    local moneyReward = math.random(Config.LootMoney.MinLoot, Config.LootMoney.MaxLoot)
    print("Money Reward Calculated: "..moneyReward)

    local success = player.Functions.AddMoney("cash", moneyReward)
    if success then
        print("Money added successfully to "..src)
        TriggerClientEvent('QBCore:Notify', src, Lang:t("reward.money", { amount = moneyReward }), "success")
    else
        print("Failed to add money for player "..src)
    end
end)


local lockpickitem = Config.General.LockPickItem

RegisterNetEvent('fr-meterrobbery:server:removelockpick', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        if Player.Functions.GetItemByName(lockpickitem) then
            Player.Functions.RemoveItem(lockpickitem, 1)
            TriggerClientEvent('ps-inventory:client:ItemBox', src, QBCore.Shared.Items[lockpickitem], "remove")
        else
            print("W")
        end
    else
        print("Error: Player not found!")
    end
end)
