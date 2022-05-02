local _Xray = (function()
	local module = {
        Options = {
            Transparency = 0.5,
        }
    }

	local function xray(obj, transparency)
        for _, c in pairs(obj:GetChildren()) do
            if c:IsA("BasePart") and not c.Parent:FindFirstChild("Humanoid") and not c.Parent.Parent:FindFirstChild("Humanoid") then
                c.LocalTransparencyModifier = transparency
            end

            xray(c, transparency)
        end
	end

	module.xrayToggle = function(enabled)
        if enabled then xray(workspace, module.Options.Transparency) else xray(workspace, 0) end
    end

	return module
end)()

return _Xray