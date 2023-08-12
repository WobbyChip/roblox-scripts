local _Flight = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Flight.lua"))()
local _Clicker = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Clicker.lua"))()
local _Xray = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Xray.lua"))()
local _Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Teleport.lua"))()
local _GUIData = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/frameworks/GUIFramework.lua"))()

local Players = game:GetService("Players")

--GUI Container
local FeaturesGUI = _GUIData[1]:create("Container", {
    Name = "Features - V 1.37",
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
    Hotkey = tostring(Enum.KeyCode.P),
    Callback = function(enabled)
        _Clicker.toggleClicker(enabled)
    end,
})

local ClickerInterval = Clicker.self:create("Number", {
    Name = "Interval",
    Default = 0.2,
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
    Hint = "Toggle Xray",
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
local GUIEnabled = Features.self:create("Toggle", {
    Name = "GUI Enabled",
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


--Drop All Items
Features.self:create("Button", {
    Name = "Drop All Items",
    Callback = function()
        for i, v in pairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do
            if v:IsA("Tool")  then
                wait(0.1)
                v.Parent = game.Players.LocalPlayer.Character
                wait(0.1)
                v.Parent = game.Workspace
            end
        end
    end,
})


--Suicide
Features.self:create("Button", {
    Name = "Suicide",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
    end,
})


--Join Emptiest Server
Features.self:create("Button", {
    Name = "Join Emptiest Server",
    Callback = function()
        local servers = {}
        for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
            if ((type(v) == "table") and v.playing and (v.maxPlayers > v.playing) and (v.id ~= game.JobId)) then servers[#servers + 1] = v.id end
        end
        if (#servers > 0) then game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)]) end
    end,
})


--Join Fullest Server
Features.self:create("Button", {
    Name = "Join Fullest Server",
    Callback = function()
        local servers = {}
        for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100")).data) do
            if ((type(v) == "table") and v.playing and (v.maxPlayers > v.playing) and (v.id ~= game.JobId)) then servers[#servers + 1] = v.id end
        end
        if (#servers > 0) then game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)]) end
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
                Name = string.sub(value, 2),
                Holding = string.sub(value, 2),
            })
        else
            TeleportsList.self:create("Holder", {
                Name = value,
                Holding = _Teleport.encodeCFrame(_Teleport.getLocation()),
            })
        end
    end,
})

local players = {}

for _, player in pairs(Players:GetPlayers()) do
    if player.UserId ~= Players.LocalPlayer.UserId then
        players[player.UserId] = AllPlayersList.self:create("Holder", {
            Name = player.Name .. " (" .. player.DisplayName .. ")",
            Holding = player.Name,
        })
    end
end

Players.PlayerAdded:Connect(function(player)
    if (players[player.UserId]) then
        if players[player.UserId].self[1].Object.Visible then return end
        players[player.UserId].self[1].Object.Visible = true
        players[player.UserId].self[1].Data.Parent.Data.Update(1)
        return
    end

    players[player.UserId] = AllPlayersList.self:create("Holder", {
        Name = player.Name .. " (" .. player.DisplayName .. ")",
        Holding = player.Name,
    })
end)
 
Players.PlayerRemoving:Connect(function(player)
	if (players[player.UserId]) then
        if not players[player.UserId].self[1].Object.Visible then return end
        players[player.UserId].self[1].Object.Visible = false
        players[player.UserId].self[1].Data.Parent.Data.Update(-1)
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
            Name = value,
            Holding = value,
        })
    end,
})

return FeaturesGUI