--[[
Legends of Speed - Auto Orb & Gems Script com GUI e ícone flutuante bonito
Feito por LeoScripter
Funcionalidades:
- Auto collect Orbs & Gems (teleporta acima dos objetos)
- GUI flutuante com ícone animado
- Botões de toggle para cada função
- Debug print para diagnóstico
--]]

local player = game.Players.LocalPlayer
local workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

-- GUI
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

local icon = Instance.new("ImageLabel")
icon.Size = UDim2.new(0, 64, 0, 64)
icon.Position = UDim2.new(0.5, -32, 0, -40)
icon.BackgroundTransparency = 1
icon.Image = "rbxassetid://15149456888" -- Ícone bonito (troque pelo que quiser)!
icon.Parent = mainFrame

-- Floating Animation
spawn(function()
    while mainFrame.Parent do
        local t = tick()
        icon.Position = UDim2.new(0.5, -32, 0, -40 + math.sin(t * 2) * 10)
        icon.Rotation = math.sin(t * 1.7) * 5
        wait(0.03)
    end
end)

local title = Instance.new("TextLabel")
title.Text = "Legends of Speed\nAutoFarm"
title.TextColor3 = Color3.fromRGB(240, 240, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 46)
title.Parent = mainFrame

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

-- Função para teleportar acima da orb/gem
local function tpAbove(part)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and part and part.Position then
        print("DEBUG: Teleportando acima de", part.Name, "Posição:", tostring(part.Position))
        player.Character.HumanoidRootPart.CFrame = CFrame.new(part.Position + Vector3.new(0, 5, 0))
        wait(0.15)
    else
        print("DEBUG: Falha ao teleportar. HumanoidRootPart ou part inválido.")
    end
end

-- Toggles
local autoOrb = false
autoOrbToggle.MouseButton1Click:Connect(function()
    autoOrb = not autoOrb
    autoOrbToggle.Text = autoOrb and "Auto Orbs [ON]" or "Auto Orbs [OFF]"
    autoOrbToggle.BackgroundColor3 = autoOrb and Color3.fromRGB(120,200,90) or Color3.fromRGB(70,130,180)
    print("DEBUG: Auto Orbs agora", autoOrb and "ATIVADO" or "DESATIVADO")
end)

local autoGems = false
autoGemsToggle.MouseButton1Click:Connect(function()
    autoGems = not autoGems
    autoGemsToggle.Text = autoGems and "Auto Gems [ON]" or "Auto Gems [OFF]"
    autoGemsToggle.BackgroundColor3 = autoGems and Color3.fromRGB(120,200,90) or Color3.fromRGB(70,130,180)
    print("DEBUG: Auto Gems agora", autoGems and "ATIVADO" or "DESATIVADO")
end)

-- Loop para auto orb
spawn(function()
    while true do
        if autoOrb and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            for _, orbFolder in ipairs(workspace:GetChildren()) do
                if string.find(orbFolder.Name, "Orb") then -- Aceita Orbs/Orb
                    for _, orb in ipairs(orbFolder:GetChildren()) do
                        if orb:IsA("Part") and orb.Parent == orbFolder and orb.Position then
                            tpAbove(orb)
                        end
                    end
                end
            end
        end
        wait(1)
    end
end)

-- Loop para auto gems
spawn(function()
    while true do
        if autoGems and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            for _, gemFolder in ipairs(workspace:GetChildren()) do
                if string.find(gemFolder.Name, "Gem") then -- Aceita Gems/Gem
                    for _, gem in ipairs(gemFolder:GetChildren()) do
                        if gem:IsA("Part") and gem.Parent == gemFolder and gem.Position then
                            tpAbove(gem)
                        end
                    end
                end
            end
        end
        wait(1)
    end
end)

print("Legends of Speed AutoFarm loaded! GUI is draggable. Created by LeoScripter.")
