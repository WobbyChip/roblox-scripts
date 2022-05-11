local _Clicker = (function()
    local VirtualInputManager = game:GetService("VirtualInputManager")

    local module = {
        Options = {
            Enabled = false,
            Interval = 1,
            X = 0, Y = 0,
        }
    }

    module.toggleClicker = function(enabled)
        module.Options.Enabled = enabled

        while module.Options.Enabled do
            VirtualInputManager:SendMouseButtonEvent(module.Options.X, module.Options.Y, 0, true, game, 1)
            VirtualInputManager:SendMouseButtonEvent(module.Options.X, module.Options.Y, 0, false, game, 1)
            wait(module.Options.Interval)
        end
    end

    module.updateMouse = function()
        local Player = Players.LocalPlayer
        local Mouse = Player:GetMouse()
        module.Options.X, module.Options.Y = Mouse.X, Mouse.Y + 10
    end

    module.getMouse = function()
        local Player = Players.LocalPlayer
        local Mouse = Player:GetMouse()
        return { Mouse.X, Mouse.Y + 10 }
    end

    return module
end)()

return _Clicker