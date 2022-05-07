local _UUID = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/UUID.lua"))()
local _Flight = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Flight.lua"))()
local _Speed = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Speed.lua"))()
local _Xray = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Xray.lua"))()
local _Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Teleport.lua"))()
local _GUIData = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/frameworks/GUIFramework.lua"))()

--GUI
local GUI = _GUIData[1]:create("Container", {
    Name = "Features - V 1.31",
})


--Features
local Features = GUI.self:create("Box", {
    Name = "Features",
})


--Flight
local Flight = Features.self:create("Toggle", {
    Name = "Flight",
    Default = false,
    Hint = "Toggle player flight",
    Callback = function(enabled)
        _Flight.toggleFly(enabled)
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


--[[--Speed
local Speed = Features.self:create("Toggle", {
    Name = "Speed",
    Default = false,
    Hint = "Toggle player speed",
    Callback = function(enabled)
        _Speed.toggleSpeed(enabled)
    end,
})

local SpeedSpeed = Speed.self:create("Number", {
    Name = "Speed",
    Default = 16,
    Min = 0.1,
    Max = 300,
    Round = 0.1,
    Hint = "Movement speed",
    Callback = function(value)
        _Speed.setSpeed(value)
    end,
})]]--


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
local Teleports = GUI.self:create("Box", {
    Name = "Teleports",
})

local TeleportsList = Teleports.self:create("HolderBox", {
    Name = "Teleports",
    FolderName = "Teleports",
    FileName = game.PlaceId .. ".json",
    TextColor = Color3.fromRGB(0, 255, 255),
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
        })
    end,
})