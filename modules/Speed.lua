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
        elseif module.Options.Enabled then
            character.Humanoid.WalkSpeed = module.Options.Saved
        end

        module.Options.Enabled = enabled
    end

    module.setSpeed = function(value)
        local enabled = module.Options.Enabled
        module.Options.Enabled = false
        module.Options.Speed = value
        character.Humanoid.WalkSpeed = value
        module.Options.Enabled = enabled
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