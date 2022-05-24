local _UUID = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/UUID.lua"))()
local _Flight = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Flight.lua"))()
local _Clicker = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Clicker.lua"))()
local _Xray = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Xray.lua"))()
local _Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Teleport.lua"))()
local _GUIData = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/frameworks/GUIFramework.lua"))()

local Players = game:GetService("Players")

--GUI Container
local FeaturesGUI = _GUIData[1]:create("Container", {
    Name = "Features - V 1.34",
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
    FileName = "Teleports/" .. game.PlaceId .. ".json",
    TextColor = Color3.fromRGB(0, 255, 255),
    Callback = function(value)
        local enabled = _Flight.Options.Enabled
        _Flight.toggleFly(false)
        _Teleport.tpToLocation(_Teleport.decodeCFrame(value))
        _Flight.toggleFly(enabled)
    end,
})

local PlayersList = Teleports.self:create("HolderBox", {
    Name = "Players",
    FileName = "Teleports/Players.json",
    TextColor = Color3.fromRGB(0, 255, 255),
    Callback = function(value)
        local enabled = _Flight.Options.Enabled
        _Flight.toggleFly(false)
        _Teleport.tpToPlayer(value)
        _Flight.toggleFly(enabled)
    end,
})

local AllPlayersList = Teleports.self:create("HolderBox", {
    Name = "Players All",
    DontSave = true,
    TextColor = Color3.fromRGB(0, 255, 255),
    Callback = function(value)
        local enabled = _Flight.Options.Enabled
        _Flight.toggleFly(false)
        _Teleport.tpToPlayer(value)
        _Flight.toggleFly(enabled)
    end,
})

local TeleportsNew = Teleports.self:create("Input", {
    Name = "Create New",
    Default = "Location 1",
    Callback = function(value)
        if string.sub(value, 1, 1) == "@" then
            PlayersList.self:create("Holder", {
                UUID = _UUID.generateUUID(),
                Name = string.sub(value, 2),
                Holding = string.sub(value, 2),
            })
        else
            TeleportsList.self:create("Holder", {
                UUID = _UUID.generateUUID(),
                Name = value,
                Holding = _Teleport.encodeCFrame(_Teleport.getLocation()),
            })
        end
    end,
})

local players = {}

Players.PlayerAdded:Connect(function(player)
    if (players[player.UserId]) then
        players[player.UserId].self:hide(false)
        return
    end

    players[player.UserId] = AllPlayersList.self:create("Holder", {
        UUID = _UUID.generateUUID(),
        Name = player.Name .. " (" .. player.DisplayName .. ")"
        Holding = player.Name,
    })
end)
 
Players.PlayerRemoving:Connect(function(player)
	if (players[player.UserId]) then
        players[player.UserId].self:hide(true)
    end
end)


--Messages
local Messages = FeaturesGUI.self:create("Box", {
    Name = "Messages",
})

local MessagesList = Messages.self:create("HolderBox", {
    Name = "Messages",
    FileName = "Messages/Messages.json",
    TextColor = Color3.fromRGB(0, 255, 255),
    Callback = function(value)
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(value, "All")
    end,
})

local MessagesNew = Messages.self:create("Input", {
    Name = "Create New",
    Default = "L Bozo",
    Callback = function(value)
        MessagesList.self:create("Holder", {
            UUID = _UUID.generateUUID(),
            Name = value,
            Holding = value,
        })
    end,
})