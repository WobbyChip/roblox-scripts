local _Speed = (function()
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local character = Player.Character
    local Heartbeat = nil

    local module = {}
    module.Options = {
        Speed = 16,
        Saved = 0,
    }

    local function speedEnd()
        if Heartbeat then Heartbeat:Disconnect() end
        if Heartbeat then setSpeed(module.Options.Saved) end
    end

    module.setSpeed = function(value)
        module.Options.Speed = value
        if not character or not character.Parent or not character:FindFirstChild("HumanoidRootPart") then return end
        character.Humanoid.WalkSpeed = value
    end

    module.toggleSpeed = function(enabled)
        if not enabled then speedEnd() return end
        if enabled then module.Options.Saved = character.Humanoid.WalkSpeed

        Heartbeat = RunService.Heartbeat:Connect(function()
            if not character or not character.Parent or not character:FindFirstChild("HumanoidRootPart") then return end
            module.setSpeed(module.Options.Speed)
        end)
    end

    Player.CharacterAdded:Connect(function(char)
        character = char
    end)

    return module
end)()

return _Speed