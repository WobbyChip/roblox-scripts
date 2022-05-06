local _Speed = (function()
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local character = Player.Character

    local module = {}
    module.Options = {
        Enabled = false,
        Speed = 16,
        Saved = 0,
    }

    module.toggleSpeed = function(enabled)
        if enabled then
            module.Options.Saved = character.Humanoid.WalkSpeed
            character.Humanoid.WalkSpeed = module.Options.Speed
        else
            character.Humanoid.WalkSpeed = module.Options.Saved
        end

        module.Options.Enabled = enabled
    end

    module.setSpeed = function()
        return game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
    end

    Player.CharacterAdded:Connect(function(char)
        character = char

        character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
            if module.Options.Enabled then
                module.Options.Saved = character.Humanoid.WalkSpeed
                character.Humanoid.WalkSpeed = module.Options.Speed
            end
        end)
    end)

    return module
end)()

return _Speed