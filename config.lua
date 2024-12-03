Config = {}

Config.ParkingMeters = {
    "prop_parknmeter_01", "prop_parknmeter_02",
}

Config.General = {
    CallCops = 10, -- In Percentage (20 = 20%) ]]
    SearchDistance = 1.5,
    DurationOfSearch = 12500, -- In miliseconds
    SearchCooldown = 60000, -- In miliseconds
    RefillTime = 600000, -- In miliseconds
    LockPickBreakingSuccess = 10, -- Chance of Lockpick Breaking when succeding
    LockPickBreakingFail = 50, -- Chance of Lockpick Breaking when Failing
    LockPickItem = 'lockpick', -- Item used to lockpick the Parking Meters
}

Config.SkillCheck = 'SN' -- Supported are SN-Hacking [SN] and ps-ui [PS]

Config.Stress = {
    AddStress = true,
    MinStress = 3,
    MaxStress = 5
}

Config.LootMoney = {
    MinLoot = 3,
    MaxLoot = 90,
}

Config.Animations = {
    AnimationDictionary = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
    Animation = "weed_crouch_checkingleaves_idle_01_inspector"
}