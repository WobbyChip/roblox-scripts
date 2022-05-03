local _Teleport = (function()
    module.teleportTo = function(cframe)
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = cframe
    end

    module.getLocation = function()
        return game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
    end

    module.encodeCFrame = function(cframe)
        return tostring(cframe)
    end

    module.decodeCFrame = function(cframe)
        local s = string.split(sframe, ",")
        return CFrame.new(s[1], s[2], s[3], s[4], s[5], s[6], s[7], s[8], s[9], s[10], s[11], s[12])
    end

    return module
end)()

return _Teleport