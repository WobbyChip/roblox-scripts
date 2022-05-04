print("Features - V 1.25")

local _UUID = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/UUID.lua"))()
local _Flight = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Flight.lua"))()
local _Xray = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Xray.lua"))()
local _Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Teleport.lua"))()

local GUIData = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/frameworks/GUIFramework.lua"))()
local gui = GUIData[1]

--GUI - Features
local FeaturesGUI = gui:create("Container", {
    Name = "Features",
})

local Features = FeaturesGUI.self:create("Box", {
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
        _Xray.xrayUpdate()
    end,
})


--Teleports
local Teleports = Features.self:create("Box", {
    Name = "Teleports",
})

local TeleportsList = Teleports.self:create("HolderBox", {
    Name = "Teleports",
    FolderName = "Teleports",
    FileName = game.PlaceId .. ".json",
    Callback = function(value)
        _Teleport.teleportTo(_Teleport.decodeCFrame(value))
    end,
})

local TeleportsNew = Teleports.self:create("Input", {
    Name = "Create New",
    Default = "Location 1",
    Callback = function(value)
        TeleportsList.self:create("Holder", {
            UUID = _UUID.generateUUID(),
            Name = value,
            Holding = _Teleport.encodeCFrame(_Teleport.getLocation()),
            Config = TeleportsList.Data.Config,
            Callback = TeleportsList.Data.Callback,
        })
    end,
})