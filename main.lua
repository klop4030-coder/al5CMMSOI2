--[[
    ================================================================
    [ SAIRO SYSTEM | BORDER NEON EDITION V69.9 ]
    • Developer: 1sairo_
    • Description: Added Yaqoot Dhab & Fixed Rare Dhabs Jalmood/Yaqoot ESP with Key System.
    ================================================================
]]

-- 🔑 نظام التحقق من المفتاح
local CorrectKey = "SAIRO2026" -- تقدر تغير كلمة السر هذي لأي مفتاح تبيه
local EnteredKey = nil

pcall(function()
    if inputbox then
        EnteredKey = inputbox("نظام حماية Sairo", "الرجاء إدخال مفتاح التفعيل:")
    end
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

local KeyScreen = Instance.new("ScreenGui")
KeyScreen.Name = "SairoKeySystem"
KeyScreen.ResetOnSpawn = false
KeyScreen.Parent = CoreGui

local KeyFrame = Instance.new("Frame", KeyScreen)
KeyFrame.Size = UDim2.new(0, 320, 0, 160)
KeyFrame.Position = UDim2.new(0.5, -160, 0.5, -80)
KeyFrame.BackgroundColor3 = Color3.fromRGB(12, 7, 10)
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 14)

local KeyStroke = Instance.new("UIStroke", KeyFrame)
KeyStroke.Color = Color3.fromRGB(255, 10, 45)
KeyStroke.Thickness = 2.5

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "🔐 نظام حماية Sairo V69.9"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.TextSize = 13
KeyTitle.Font = Enum.Font.GothamBold

local KeyBox = Instance.new("TextBox", KeyFrame)
KeyBox.Size = UDim2.new(1, -40, 0, 38)
KeyBox.Position = UDim2.new(0, 20, 0, 50)
KeyBox.BackgroundColor3 = Color3.fromRGB(25, 15, 22)
KeyBox.PlaceholderText = "اكتب المفتاح هنا..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 12
KeyBox.Font = Enum.Font.GothamMedium
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 8)

local SubmitBtn = Instance.new("TextButton", KeyFrame)
SubmitBtn.Size = UDim2.new(1, -40, 0, 36)
SubmitBtn.Position = UDim2.new(0, 20, 0, 105)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(255, 15, 55)
SubmitBtn.Text = "تحقق ودخول 🚀"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.TextSize = 12
SubmitBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 8)

local KeyValidated = false

SubmitBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == CorrectKey then
        KeyValidated = true
        KeyScreen:Destroy()
    else
        SubmitBtn.Text = "❌ المفتاح غير صحيح!"
        task.wait(1.5)
        SubmitBtn.Text = "تحقق ودخول 🚀"
    end
end)

repeat task.wait() until KeyValidated

-- ================================================================
-- [ الكود الأصلي للسكربت ]
-- ================================================================

local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Stats = game:GetService("Stats")
local TeleportService = game:GetService("TeleportService")
local CoreGuiService = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

local Camera = Workspace.CurrentCamera

if CoreGui:FindFirstChild("Sairo") then
    CoreGui.Sairo:Destroy()
end

local SaveFileName = "SairoSettings_V699.json"
local Settings = {
    DhabAll = false,
    DhabRareOnly = false,
    DhabSpecialActive = false,
    SmartAlerts = true,
    Players = false,
    Vehicles = false,
    EspDistance = 500,
    Aimbot = false,
    AimbotDistance = 50,
    RequireWeapon = true,
    UseFOVCircle = true,
    FOVRadius = 120,
    HoldRightClick = false,
    RareHudActive = false,
    HudPosX = 0.75,
    HudPosY = 0.15,
    AntiAfkActive = true,      
    AutoRejoinActive = true,
    FogDisabled = false
}

pcall(function()
    if writefile and readfile and isfile and isfile(SaveFileName) then
        local decoded = HttpService:JSONDecode(readfile(SaveFileName))
        if type(decoded) == "table" then
            for k, v in pairs(decoded) do
                if Settings[k] ~= nil then Settings[k] = v end
            end
        end
    end
end)

local function SaveSettings()
    pcall(function()
        if writefile then
            writefile(SaveFileName, HttpService:JSONEncode(Settings))
        end
    end)
end

local RedTheme = {
    Background = Color3.fromRGB(12, 7, 10),
    Panel      = Color3.fromRGB(20, 10, 16),
    CardBg     = Color3.fromRGB(28, 14, 22),
    ButtonOff  = Color3.fromRGB(40, 18, 28),
    ButtonOn   = Color3.fromRGB(255, 15, 55),
    Accent     = Color3.fromRGB(255, 10, 45),
    ToggleBgOn = Color3.fromRGB(255, 15, 55),
    ToggleBgOff= Color3.fromRGB(45, 20, 32),
    SoftNeonRed= Color3.fromRGB(180, 20, 45)
}

local Colors = {
    White = Color3.fromRGB(255, 255, 255),
    Muted = Color3.fromRGB(175, 140, 160),
    PlayerColor = Color3.fromRGB(255, 60, 60),
    VehicleColor = Color3.fromRGB(255, 150, 0),
    SpecialDhabColor = Color3.fromRGB(255, 0, 255)
}

local RarityNames = {
    T1 = "عادي", T2 = "مميز", T3 = "نادر", T4 = "فاخر", T5 = "أسطوري", T6 = "خرافي"
}

local StateNames = {
    idle = "واقف 🧍", walk = "يمشي 🚶", flee = "يهرب 🏃", alert = "منتبه ⚠️", display = "يستعرض ✨", peek = "يتلصص 👀"
}

local RarityColors = {
    T1 = Color3.fromRGB(150, 1
