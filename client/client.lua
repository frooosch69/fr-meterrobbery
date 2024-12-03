local QBCore = exports['qb-core']:GetCoreObject()
local lockpickitem = Config.General.LockPickItem

CreateThread(function()
    exports['qb-target']:AddTargetModel(Config.ParkingMeters, {
        options = {
            {
                event = 'fr-meterrobbery:server:searchMeter',
                type = 'server',
                icon = "fa-solid fa-screwdriver",
                label = 'Break In',
                item = Config.General.LockPickItem,
            },
        },
        distance = Config.General.SearchDistance,
    })
end)

local function LockPickBreakingSuccess()
    local chance = Config.General.LockPickBreakingSuccess
    local randomNumber = math.random(1, 100)
    if randomNumber <= chance then
        TriggerServerEvent('fr-meterrobbery:server:removelockpick')
    else
        return false
    end
end

local function LockPickBreakingFail()
    local chance = Config.General.LockPickBreakingFail
    local randomNumber = math.random(1, 100) -- Generate a random number between 1 and 100
    if randomNumber <= chance then
        TriggerServerEvent('fr-mailrobbery:server:removelockpick')
    else
        return false
    end
end

RegisterNetEvent('fr-meterrobbery:client:searchMeter', function(MeterId)
    if math.random(1, 100) <= Config.General.CallCops then
        exports['ps-dispatch']:SuspiciousActivity()
    end

    if Config.SkillCheck == "SN" then -- Corrected comparison operator
        local success = exports['SN-Hacking']:SkillBar({2000, 3000}, 10, 1) -- SkillBar(duration, width%, rounds)
        if success then
            if math.random(1, 100) <= 50 and not QBCore.Functions.IsWearingGloves() then
                local pos = GetEntityCoords(PlayerPedId())
                TriggerServerEvent('evidence:server:CreateFingerDrop', pos)
            end

            QBCore.Functions.Progressbar('fr-meterrobbery:searchingMeter', Lang:t("progressbar.searching"), Config.General.DurationOfSearch, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = Config.Animations.AnimationDictionary,
                anim = Config.Animations.Animation,
                flags = 16,
            }, {}, {}, function()
                ClearPedTasks(PlayerPedId())
                LockPickBreakingSuccess()
                TriggerServerEvent('fr-meterrobbery:server:searchedMeter', MeterId)
                if Config.Stress.AddStress then
                    TriggerServerEvent('hud:server:GainStress', math.random(Config.Stress.MinStress, Config.Stress.MaxStress))
                end
            end, function()
                ClearPedTasks(PlayerPedId())
            end)
        else
            LockPickBreakingFail()
        end
    elseif Config.SkillCheck == "PS" then -- Corrected comparison operator
        exports['ps-ui']:Circle(function(success)
            if success then
                print("success") -- Added print for success
                if math.random(1, 100) <= 50 and not QBCore.Functions.IsWearingGloves() then
                    local pos = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('evidence:server:CreateFingerDrop', pos)
                end

                QBCore.Functions.Progressbar('fr-meterrobbery:searchingMeter', Lang:t("progressbar.searching"), Config.General.DurationOfSearch, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.AnimationDictionary,
                    anim = Config.Animations.Animation,
                    flags = 16,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    LockPickBreakingSuccess()
                    TriggerServerEvent('fr-meterrobbery:server:searchedMeter', MeterId)
                    if Config.Stress.AddStress then
                        TriggerServerEvent('hud:server:GainStress', math.random(Config.Stress.MinStress, Config.Stress.MaxStress))
                    end
                end, function()
                    ClearPedTasks(PlayerPedId())
                end)
            else
                print("fail") -- Added print for failure
                LockPickBreakingFail()
            end
        end, 1, 5000) -- Number of Circles = 3, Time in milliseconds = 5000
    end
end)
