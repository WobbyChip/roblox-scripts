local _Speed = (function()
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local character = Player.Character
    local Heartbeat = nil

    local module = {}
    module.Options = {
        Enabled = false,
        Speed = 16,
        Saved = 0,
    }

    local function speedEnd()
        if not Heartbeat then return end
        Heartbeat:Disconnect()

        if not character then return end
        character:WaitForChild("Humanoid").WalkSpeed = module.Options.Saved
    end

    module.setSpeed = function(value)
        if not module.Options.Enabled then return end
        module.Options.Speed = value
        if not character then return end
        character:WaitForChild("Humanoid").WalkSpeed = value
    end

    module.toggleSpeed = function(enabled)
        module.Options.Enabled = enabled
        if not enabled then speedEnd() return end
        module.Options.Saved = character.Humanoid.WalkSpeed

        Heartbeat = RunService.Heartbeat:Connect(function()
            module.setSpeed(module.Options.Speed)
        end)
    end

    Player.CharacterAdded:Connect(function(char)
        character = char
    end)

    return module
end)()

return _Speed