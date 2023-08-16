if (not game:IsLoaded()) then game.Loaded:Wait() end
if (_WobbyChip) then return _WobbyChip end

_WobbyChip = {}
_WobbyChip._Flight = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Flight.lua"))()
_WobbyChip._Clicker = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Clicker.lua"))()
_WobbyChip._Xray = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Xray.lua"))()
_WobbyChip._Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/modules/Teleport.lua"))()
_WobbyChip._GUIData = loadstring(game:HttpGet("https://raw.githubusercontent.com/WobbyChip/roblox-scripts/master/frameworks/GUIFramework.lua"))()

local Players = game:GetService("Players")

--GUI Container
local FeaturesGUI = _WobbyChip._GUIData[1]:create("Container", {
    Name = "Features - V 1.39",
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
        _WobbyChip._Flight.toggleFly(enabled)
    end,
})

Flight.self:create("Number", {
    Name = "Speed",
    Default = 15,
    Min = 0.1,
    Max = 100,
    Round = 0.1,
    Hint = "Flight speed",
    Callback = function(value)
        _WobbyChip._Flight.Options.Speed = value
    end,
})

Flight.self:create("Number", {
    Name = "Smoothness",
    Default = 0.2,
    Min = 0.1,
    Max = 1,
    Round = 0.01,
    Hint = "Smoothness of the interpolation",
    Callback = function(value)
        _WobbyChip._Flight.Options.Smoothness = value
    end,
})


--Clicker
local Clicker = Features.self:create("Toggle", {
    Name = "Clicker",
    Default = false,
    Hint = "Toggle clicker",
    Hotkey = tostring(Enum.KeyCode.P),
    Callback = function(enabled)
        _WobbyChip._Clicker.toggleClicker(enabled)
    end,
})

Clicker.self:create("Number", {
    Name = "Interval",
    Default = 0.2,
    Min = 0.01,
    Max = 2,
    Round = 0.01,
    Hint = "Clicker interval",
    Callback = function(value)
        _WobbyChip._Clicker.Options.Interval = value
    end,
})


--Xray
local Xray = Features.self:create("Toggle", {
    Name = "Xray",
    Default = false,
    Hint = "Toggle Xray",
    Hotkey = tostring(Enum.KeyCode.Z),
    Callback = function(enabled)
        _WobbyChip._Xray.toggleXray(enabled)
    end,
})

Xray.self:create("Number", {
    Name = "Transparency",
    Default = 0.5,
    Min = 0,
    Max = 1,
    Round = 0.01,
    Hint = "Xray transparency",
    Callback = function(value)
        _WobbyChip._Xray.Options.Transparency = value
        _WobbyChip._Xray.updateXray()
    end,
})

--GUI
local GUIEnabled = Features.self:create("Toggle", {
    Name = "GUI Enabled",
    Default = true,
    Hotkey = tostring(Enum.KeyCode.RightControl),
    Hint = "The GUI visibility",
    Callback = function(enabled)
        for _, frame in pairs(_WobbyChip._GUIData[3]:GetChildren()) do
            if frame:IsA("Frame") then
                frame.Visible = enabled
            end
        end
        _WobbyChip._GUIData[3].Modal.Visible = enabled
        _WobbyChip._GUIData[3].Hint.Visible = false
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


--Anti AFK Kick
Features.self:create("Toggle", {
    Name = "Anti AFK Kick",
    Default = false,
    Hint = "Disables Roblox 20m afk kick",
    Callback = function(enabled)
        _WobbyChip.AntiAfk = enabled;

        while (_WobbyChip.AntiAfk) do
            game:GetService('VirtualInputManager'):SendKeyEvent(true, Enum.KeyCode.Escape, false, x)
            wait(Random.new():NextNumber(0.7, 0.9))
            game:GetService('VirtualInputManager'):SendKeyEvent(true, Enum.KeyCode.Escape, false, x)
            wait(Random.new():NextNumber(5.2, 5.4))
        end
    end,
})


--Join Emptiest Server
Features.self:create("Button", {
    Name = "Join Emptiest Server",
    Callback = function()
        local servers = {}
        for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
            if ((type(v) == "table") and v.playing and (v.maxPlayers > v.playing) and (v.id ~= game.JobId)) then servers[#servers+1] = v.id end
        end
        if (#servers > 0) then game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)]) end
    end,
})


--Join Fullest Server
Features.self:create("Button", {
    Name = "Join Fullest Server",
    Callback = function()
        local cursor
        local servers = {}

        repeat
            local response = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100" .. (cursor and "&cursor=" .. cursor or "")))
            for _, v in pairs(response.data) do 
                if ((type(v) == "table") and v.playing and (v.maxPlayers > v.playing) and (v.id ~= game.JobId)) then servers[#servers+1] = v.id end
            end
            cursor = response.nextPageCursor
        until not cursor

        if (#servers > 0) then game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)]) end
    end,
})


--Rejoin Server
Features.self:create("Button", {
    Name = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
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
        local enabled = _WobbyChip._Flight.Options.Enabled
        _WobbyChip._Flight.toggleFly(false)
        _WobbyChip._Teleport.tpToLocation(_WobbyChip._Teleport.decodeCFrame(value))
        _WobbyChip._Flight.toggleFly(enabled)
    end,
})

local PlayersList = Teleports.self:create("HolderBox", {
    Name = "Players",
    FileName = "Teleports/Players.json",
    TextColor = Color3.fromRGB(0, 255, 255),
    Callback = function(value)
        local enabled = _WobbyChip._Flight.Options.Enabled
        _WobbyChip._Flight.toggleFly(false)
        _WobbyChip._Teleport.tpToPlayer(value)
        _WobbyChip._Flight.toggleFly(enabled)
    end,
})

local AllPlayersList = Teleports.self:create("HolderBox", {
    Name = "Players All",
    DontSave = true,
    TextColor = Color3.fromRGB(0, 255, 255),
    Callback = function(value)
        local enabled = _WobbyChip._Flight.Options.Enabled
        _WobbyChip._Flight.toggleFly(false)
        _WobbyChip._Teleport.tpToPlayer(value)
        _WobbyChip._Flight.toggleFly(enabled)
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
                Holding = _WobbyChip._Teleport.encodeCFrame(_WobbyChip._Teleport.getLocation()),
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



if (game.PlaceId == 1537690962) then
    --BeeSwarmSimulator
    local BeeSwarmSimulator = FeaturesGUI.self:create("Box", {
        Name = "Bee Swarm Simulator",
    })

    --Collects collectables
    BeeSwarmSimulator.self:create("Toggle", {
        Name = "TP Collect collectables",
        Default = false,
        Hint = "Collects collectables (Might kick you)",
        Callback = function(enabled)
            _WobbyChip.BeeSwarm_bloop = enabled;
            local enabled = _WobbyChip._Flight.Options.Enabled
            _WobbyChip._Flight.toggleFly(true)

            while (_WobbyChip.BeeSwarm_bloop) do
                for i, v in pairs(game.Workspace.Collectibles:GetChildren()) do
                    if ((v.Transparency <= 0.5) and ((v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100)) then
                        local scframe = tostring(v.CFrame)
                        while (v:IsDescendantOf(game.Workspace.Collectibles) and (tostring(v.CFrame) == scframe)) do
                            _WobbyChip._Flight.toggleFly(false)
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame * CFrame.new(0,0,0)
                            _WobbyChip._Flight.toggleFly(true)
                            wait(0.0010)
                        end
                    else
                        v:Destroy()
                    end

                    wait(0.0010)
                end
                wait(0.0010)
            end

            _WobbyChip._Flight.toggleFly(enabled)
        end,
    })
end



return _WobbyChip