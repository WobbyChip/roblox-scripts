local _Teleport = (function()
    local Players = game:GetService("Players")

    local function getPlayerByName(playerName)
        for _, player in pairs(Players:GetPlayers()) do
            if player.Name == playerName then
                return player
            end
        end
    end

    local module = {}

    module.tpToLocation = function(cframe)
        Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframe
    end

    module.getLocation = function()
        return Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    end

    module.encodeCFrame = function(cframe)
        return tostring(cframe)
    end

    module.decodeCFrame = function(cframe)
        local s = string.split(cframe, ",")
        return CFrame.new(s[1], s[2], s[3], s[4], s[5], s[6], s[7], s[8], s[9], s[10], s[11], s[12])
    end

    module.tpToPlayer = function(playerName)
        local player = getPlayerByName(playerName)
        if not player then return end
        Players.LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
    end

    return module
end)()

return _Teleport