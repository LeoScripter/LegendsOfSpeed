--[[ 
  Script Roblox Legends of Speed Mobile - by @LeoScripter
  GUI com design bonito e ícone customizado!
  Funções: auto orbs, auto gems, auto rebirth, auto race, auto hoops, teleport, anti-AFK.
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")

-- CONFIGURAÇÕES
local AUTO_ORBS = true
local AUTO_GEMS = true
local AUTO_REBIRTH = false
local AUTO_RACE = false
local AUTO_HOOPS = true
local TELEPORTS = true
local ANTI_AFK = true

-- Locais de Teleporte
local locations = {
    ["Spawn"] = Vector3.new(-43, 24, 206),
    ["Desert"] = Vector3.new(1032, 24, 2338),
    ["Snow"] = Vector3.new(1318, 25, -2558),
    ["Magma"] = Vector3.new(-1331, 24, -2778),
    ["Electro"] = Vector3.new(-1520, 24, 2067),
}

-- Função Anti-AFK
if ANTI_AFK then
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

-- Teleporte rápido
local function TeleportTo(pos)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
    end
end

-- Auto Orbs
local function AutoOrbs()
    while AUTO_ORBS do
        for _, orb in pairs(Workspace:GetChildren()) do
            if orb.Name:find("Orb") and orb:IsA("Model") and orb:FindFirstChild("TouchInterest") then
                TeleportTo(orb.Position or orb.PrimaryPart.Position)
                wait(0.2)
            end
        end
        wait(1)
    end
end

-- Auto Gems
local function AutoGems()
    while AUTO_GEMS do
        for _, gem in pairs(Workspace:GetChildren()) do
            if gem.Name:find("Gem") and gem:IsA("Model") and gem:FindFirstChild("TouchInterest") then
                TeleportTo(gem.Position or gem.PrimaryPart.Position)
                wait(0.2)
            end
        end
        wait(1)
    end
end

-- Auto Hoops (anéis)
local function AutoHoops()
    while AUTO_HOOPS do
        for _, hoop in pairs(Workspace:FindFirstChild("Hoops") and Workspace.Hoops:GetChildren() or {}) do
            if hoop:IsA("Part") then
                TeleportTo(hoop.Position)
                wait(0.25)
            end
        end
        wait(2)
    end
end

-- Auto Rebirth
local function AutoRebirth()
    while AUTO_REBIRTH do
        ReplicatedStorage.rEvents.rebirthEvent:FireServer("rebirthRequest")
        wait(5)
    end
end

-- Auto Race
local function AutoRace()
    while AUTO_RACE do
        ReplicatedStorage.rEvents.joinRace:FireServer()
        wait(10)
    end
end

-- GUI BONITA COM ÍCONE
local function createBeautifulGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "LegendsSpeedGUI"
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0, 250, 0, 350)
    MainFrame.Position = UDim2.new(0, 40, 0, 90)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 40, 90)
    MainFrame.BorderSizePixel = 0
    MainFrame.BackgroundTransparency = 0.12
    MainFrame.AnchorPoint = Vector2.new(0,0)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.ZIndex = 2

    local Corner = Instance.new("UICorner", MainFrame)
    Corner.CornerRadius = UDim.new(0, 18)

    local Shadow = Instance.new("ImageLabel", MainFrame)
    Shadow.Image = "rbxassetid://6015897843"
    Shadow.Size = UDim2.new(1.2, 0, 1.2, 0)
    Shadow.Position = UDim2.new(-0.1, 0, -0.1, 0)
    Shadow.BackgroundTransparency = 1
    Shadow.ZIndex = 1

    -- Ícone bonito
    local Icon = Instance.new("ImageLabel", MainFrame)
    Icon.Image = "rbxassetid://12952481521" -- Ícone de raio estiloso
    Icon.Size = UDim2.new(0, 60, 0, 60)
    Icon.Position = UDim2.new(0.5, -30, 0, -40)
    Icon.BackgroundTransparency = 1
    Icon.ZIndex = 2

    -- Título estilizado
    local Title = Instance.new("TextLabel", MainFrame)
    Title.Text = "Legends of Speed\nMobile Script"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20
    Title.TextColor3 = Color3.fromRGB(255,255,255)
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1,0,0,60)
    Title.Position = UDim2.new(0,0,0,20)
    Title.ZIndex = 2

    -- Botões de teleporte
    local ButtonList = Instance.new("Frame", MainFrame)
    ButtonList.Size = UDim2.new(1,-30,0,170)
    ButtonList.Position = UDim2.new(0,15,0,90)
    ButtonList.BackgroundTransparency = 1
    ButtonList.ZIndex = 2

    local Layout = Instance.new("UIListLayout", ButtonList)
    Layout.Padding = UDim.new(0,8)
    Layout.FillDirection = Enum.FillDirection.Vertical
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    for loc, pos in pairs(locations) do
        local btn = Instance.new("TextButton", ButtonList)
        btn.Size = UDim2.new(1,0,0,32)
        btn.Text = "🌟 " .. loc
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 16
        btn.BackgroundColor3 = Color3.fromRGB(60,110,220)
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.BorderSizePixel = 0
        btn.ZIndex = 2
        local btnCorner = Instance.new("UICorner", btn)
        btnCorner.CornerRadius = UDim.new(0,14)
        btn.MouseButton1Click:Connect(function()
            TeleportTo(pos)
        end)
    end

    -- Créditos
    local credit = Instance.new("TextLabel", MainFrame)
    credit.Text = "By @LeoScripter"
    credit.Font = Enum.Font.Gotham
    credit.TextSize = 14
    credit.TextColor3 = Color3.fromRGB(190,190,250)
    credit.BackgroundTransparency = 1
    credit.Size = UDim2.new(1,0,0,18)
    credit.Position = UDim2.new(0,0,1,-22)
    credit.ZIndex = 2

    -- Ativar/desativar funções (opcional)
    -- Você pode adicionar botões para ativar/desativar funções aqui se quiser.
end

-- Inicialização das corrotinas
if AUTO_ORBS then coroutine.wrap(AutoOrbs)() end
if AUTO_GEMS then coroutine.wrap(AutoGems)() end
if AUTO_REBIRTH then coroutine.wrap(AutoRebirth)() end
if AUTO_RACE then coroutine.wrap(AutoRace)() end
if AUTO_HOOPS then coroutine.wrap(AutoHoops)() end

-- Cria a GUI Linda
createBeautifulGUI()

print("Script Legends of Speed Mobile com GUI ativada! Use com responsabilidade.")

-- Personalize as opções no início do script!
