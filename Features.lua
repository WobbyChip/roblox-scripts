local _UUID = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/UUID.lua"))()
local _Flight = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Flight.lua"))()
local _Clicker = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Clicker.lua"))()
local _Xray = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Xray.lua"))()
local _Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Teleport.lua"))()
local _GUIData = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/frameworks/GUIFramework.lua"))()

--GUI Container
local FeaturesGUI = _GUIData[1]:create("Container", {
    Name = "Features - V 1.33",
})


--Features
local Features = FeaturesGUI.self:create("Box", {
    Name = "Features",
})


--Flight
local Flight = Features.self:create("Toggle", {
    Name = "Flight",
    Default = false,
    Hotkey = tostring(Enum.KeyCode.X),
    Hint = "Toggle player flight",
    Callback = function(enabled)
        _Flight.toggleFly(enabled)
    end,
})

local FlightSpeed = Flight.self:create("Number", {
    Name = "Speed",
    Default = 15,
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


--Clicker
local Clicker = Features.self:create("Toggle", {
    Name = "Clicker",
    Default = false,
    Hint = "Toggle clicker",
    Callback = function(enabled)
        _Clicker.toggleClicker(enabled)
    end,
})

local ClickerInterval = Clicker.self:create("Number", {
    Name = "Interval",
    Default = 1,
    Min = 0.01,
    Max = 2,
    Round = 0.01,
    Hint = "Clicker interval",
    Callback = function(value)
        _Clicker.Options.Interval = value
    end,
})


--Xray
local Xray = Features.self:create("Toggle", {
    Name = "Xray",
    Default = false,
    Hotkey = tostring(Enum.KeyCode.Z),
    Callback = function(enabled)
        _Xray.toggleXray(enabled)
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
        _Xray.updateXray()
    end,
})


--Suicide
local Suicide = Features.self:create("Button", {
    Name = "Suicide",
    Default = false,
    Callback = function()
        game:GetService("Players").LocalPlayer.Character.Humanoid.Health = 0
    end,
})


--GUI
local GUI = FeaturesGUI.self:create("Box", {
    Name = "GUI",
})

local GUIVisibility = GUI.self:create("Toggle", {
    Name = "Enabled",
    Default = true,
    Hotkey = tostring(Enum.KeyCode.RightControl),
    Hint = "The GUI visibility",
    Callback = function(enabled)
        for _, frame in pairs(_GUIData[3]:GetChildren()) do
            if frame:IsA("Frame") then
                frame.Visible = enabled
            end
        end
        _GUIData[3].Modal.Visible = enabled
        _GUIData[3].Hint.Visible = false
    end,
})


--Teleports
local Teleports = FeaturesGUI.self:create("Box", {
    Name = "Teleports",
})

local TeleportsList = Teleports.self:create("HolderBox", {
    Name = "Teleports",
    FolderName = "Teleports",
    FileName = game.PlaceId .. ".json",
    TextColor = Color3.fromRGB(0, 255, 255),
    Callback = function(value)
        local enabled = _Flight.Options.Enabled
        _Flight.toggleFly(false)
        _Teleport.teleportTo(_Teleport.decodeCFrame(value))
        _Flight.toggleFly(enabled)
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