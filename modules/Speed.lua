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

    function PlayerAdded(player)
        local Heartbeat = nil

        player.CharacterAdded:Connect(function(char)
            character = char

            character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                if module.Options.Enabled then
                    module.Options.Saved = character.Humanoid.WalkSpeed
                    character.Humanoid.WalkSpeed = module.Options.Speed
                end
            end)

            Heartbeat = RunService.Heartbeat:Connect(function()
                if character:FindFirstChild("HumanoidRootPart") then
                    character.Humanoid.WalkSpeed = module.Options.Speed
                end
            end)
        end)

        player.CharacterRemoving:Connect(function()
            Heartbeat:Disconnect()
        end)
    end

    Players.PlayerAdded:Connect(PlayerAdded)
    return module
end)()

return _Speed