local xrayEnabled = false

local function xray(z, xrayEnabled)
    for _, i in pairs(z:GetChildren()) do
        if i:IsA("BasePart") and not i.Parent:FindFirstChild("Humanoid") and not i.Parent.Parent:FindFirstChild("Humanoid") then
            i.LocalTransparencyModifier = xrayEnabled
        end

        xray(i, xrayEnabled)
    end
end

game:GetService("UserInputService").InputBegan:connect(function (input)
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Z then
        xrayEnabled = not xrayEnabled
        if xrayEnabled then xray(workspace, 0.5) else xray(workspace, 0) end
    end
end)