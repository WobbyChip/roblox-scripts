local xrayEnabled = false


local function xray(ws, xrayEnabled)
    for _, c in pairs(ws:GetChildren()) do
        if c:IsA("BasePart") and not c.Parent:FindFirstChild("Humanoid") and not c.Parent.Parent:FindFirstChild("Humanoid") then
            c.LocalTransparencyModifier = xrayEnabled
        end

        xray(c, xrayEnabled)
    end
end


game:GetService("UserInputService").InputBegan:connect(function (input)
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Z then
        xrayEnabled = not xrayEnabled
        if xrayEnabled then xray(workspace, 0.5) else xray(workspace, 0) end
    end
end)