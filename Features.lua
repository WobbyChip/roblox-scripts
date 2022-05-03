local _Flight = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Flight.lua"))()
local _Xray = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Xray.lua"))()

local GUIData = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/frameworks/GUIFramework.lua"))()
local gui = GUIData[1]

--GUI - Features
local Features = gui:create("Container", {
    Name = "Features",
})


--Flight
local Flight = Features.self:create("Toggle", {
    Name = "Flight",
    Default = false,
    Hint = "Toggle player flight",
    Callback = function(enabled)
        _Flight.flyStart(enabled)
    end,
})

local FlightSpeed = Flight.self:create("Number", {
    Name = "Speed",
    Default = 5,
    Min = 0.1,
    Max = 100,
    Round = 0.1,
    Hint = "Flight speed",
    Callback = function(value)
        _Flight.Options.Speed = value
    end,
})

local FlightSpeed = Flight.self:create("Number", {
    Name = "Smoothness",
    Default = 0.2,
    Min = 0.1,
    Max = 1,
    Round = 0.01,
    Hint = "Smoothness of the interpolation",
    Callback = function(value)
        _Flight.Options.Smoothness = value
    end,
})


--Xray
local Xray = Features.self:create("Toggle", {
    Name = "Xray",
    Default = false,
    Callback = function(enabled)
        _Xray.xrayToggle(enabled)
    end,
})

local XrayTransparency = Xray.self:create("Number", {
    Name = "Transparency",
    Default = 0.5,
    Min = 0,
    Max = 1,
    Round = 0.01,
    Hint = "Xray transparency",
    Callback = function(value)
        _Xray.Options.Transparency = value
        _Xray.update()
    end,
})