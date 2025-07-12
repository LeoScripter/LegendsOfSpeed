--[[
Legends of Speed - Auto Orb & Gems Script with Beautiful Floating Icon GUI
Author: LeoScripter
Features:
- Auto collect Orbs & Gems (teleport above and collect)
- Floating, animated GUI with stylish icon
- Toggle buttons for features
--]]

local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Floating GUI Variables
local TweenService = game:GetService("TweenService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LegendsAutoFarmGUI"
ScreenGui.Parent = game.CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Position = UDim2.new(0.8,0,0.2,0)
mainFrame.Size = UDim2.new(0, 180, 0, 215)
mainFrame.BackgroundTransparency = 0.35
mainFrame.BackgroundColor3 = Color3.fromRGB(43, 62, 120)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = ScreenGui

-- Floating Icon
local icon = Instance.new("ImageLabel")
icon.Size = UDim2.new(0, 64, 0, 64)
icon.Position = UDim2.new(0.5, -32, 0, -40)
icon.BackgroundTransparency = 1
icon.Image = "rbxassetid://15149456888" -- Replace with your beautiful icon asset ID!
icon.Parent = mainFrame

-- Floating Animation
spawn(function()
    while true do
        local t = tick()
        icon.Position = UDim2.new(0.5, -32, 0, -40 + math.sin(t * 2) * 10)
        icon.Rotation = math.sin(t * 1.7) * 5
        wait(0.03)
    end
end)

-- Title
local title = Instance.new("TextLabel")
title.Text = "Legends of Speed\nAutoFarm"
title.TextColor3 = Color3.fromRGB(240, 240, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 46)
title.Parent = mainFrame

-- Toggle Buttons
local autoOrbToggle = Instance.new("TextButton")
autoOrbToggle.Size = UDim2.new(0.9, 0, 0, 38)
autoOrbToggle.Position = UDim2.new(0.05, 0, 0, 56)
autoOrbToggle.Text = "Auto Orbs [OFF]"
autoOrbToggle.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
autoOrbToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
autoOrbToggle.Font = Enum.Font.GothamBlack
autoOrbToggle.TextSize = 16
autoOrbToggle.Parent = mainFrame

local autoGemsToggle = Instance.new("TextButton")
autoGemsToggle.Size = UDim2.new(0.9, 0, 0, 38)
autoGemsToggle.Position = UDim2.new(0.05, 0, 0, 104)
autoGemsToggle.Text = "Auto Gems [OFF]"
autoGemsToggle.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
autoGemsToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
autoGemsToggle.Font = Enum.Font.GothamBlack
autoGemsToggle.TextSize = 16
autoGemsToggle.Parent = mainFrame

local infoLabel = Instance.new("TextLabel")
infoLabel.Text = "By LeoScripter"
infoLabel.Font = Enum.Font.GothamSemibold
infoLabel.TextSize = 14
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.fromRGB(170,200,255)
infoLabel.Position = UDim2.new(0,0,1,-28)
infoLabel.Size = UDim2.new(1,0,0,24)
infoLabel.Parent = mainFrame

-- Function to teleport player above a part and collect
local function tpAboveAndCollect(part)
    if part and part.Position then
        local targetCFrame = part.CFrame + Vector3.new(0, 4.5, 0) -- 4.5 studs above
        player.Character.HumanoidRootPart.CFrame = targetCFrame
        wait(0.15)
    end
end

-- Auto Orbs Logic
local autoOrb = false
autoOrbToggle.MouseButton1Click:Connect(function()
    autoOrb = not autoOrb
    autoOrbToggle.Text = autoOrb and "Auto Orbs [ON]" or "Auto Orbs [OFF]"
    autoOrbToggle.BackgroundColor3 = autoOrb and Color3.fromRGB(120,200,90) or Color3.fromRGB(70,130,180)
end)

-- Auto Gems Logic
local autoGems = false
autoGemsToggle.MouseButton1Click:Connect(function()
    autoGems = not autoGems
    autoGemsToggle.Text = autoGems and "Auto Gems [ON]" or "Auto Gems [OFF]"
    autoGemsToggle.BackgroundColor3 = autoGems and Color3.fromRGB(120,200,90) or Color3.fromRGB(70,130,180)
end)

-- Main Farming Loop
spawn(function()
    while true do
        if autoOrb and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            for _, orbFolder in ipairs(workspace:GetChildren()) do
                if orbFolder.Name:match("Orbs") then
                    for _, orb in ipairs(orbFolder:GetChildren()) do
                        if orb:IsA("Part") then
                            tpAboveAndCollect(orb)
                        end
                    end
                end
            end
        end
        wait(1)
    end
end)

spawn(function()
    while true do
        if autoGems and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            for _, gemFolder in ipairs(workspace:GetChildren()) do
                if gemFolder.Name:match("Gems") then
                    for _, gem in ipairs(gemFolder:GetChildren()) do
                        if gem:IsA("Part") then
                            tpAboveAndCollect(gem)
                        end
                    end
                end
            end
        end
        wait(1)
    end
end)

-- Credits & GUI Notice
print("Legends of Speed AutoFarm loaded! GUI is draggable. Created by LeoScripter.")

-- Optional: Add a close button
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.Size = UDim2.new(0,32,0,32)
closeBtn.Position = UDim2.new(1,-36,0,4)
closeBtn.BackgroundTransparency = 0.7
closeBtn.BackgroundColor3 = Color3.fromRGB(220,70,70)
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.Parent = mainFrame
closeBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
