--BeeSwarmSimulator
local BeeSwarmSimulator = _WobbyChip.FeaturesGUI.self:create("Box", {
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

--Disable 3D Rendering
BeeSwarmSimulator.self:create("Toggle", {
    Name = "Disable 3D Rendering",
    Default = false,
    Hint = "Disable 3D rendering, for more fps and less power consumption",
    Callback = function(enabled)
        game:GetService("RunService"):Set3dRenderingEnabled(not enabled)
    end,
})