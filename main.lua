--[[
    ================================================================
    [ SAIRO SYSTEM | BORDER NEON EDITION V69.9 ]
    • Developer: 1sairo_
    • Description: Cleaned Key System & Fixed Nil Value Errors.
    ================================================================
]]

-- 🔑 نظام التحقق من المفتاح الآمن
local CorrectKey = "SAIRO2026"
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("SairoKeySystem") then
    CoreGui.SairoKeySystem:Destroy()
end

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
KeyBox.PlaceholderText = "اكتب المفتاح هنا (SAIRO2026)..."
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
-- [ تشغيل الخدمات الأساسية ]
-- ================================================================
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Stats = game:GetService("Stats")
local TeleportService = game:GetService("TeleportService")
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
    T1 = Color3.fromRGB(150, 160, 175),
    T2 = Color3.fromRGB(70, 160, 95),
    T3 = Color3.fromRGB(65, 130, 195),
    T4 = Color3.fromRGB(130, 90, 175),
    T5 = Color3.fromRGB(255, 180, 50),
    T6 = Color3.fromRGB(255, 50, 70)
}

local SpecialDhabsList = {
    ["gl_jamr_pen"] = "ضب الحمم", ["gl_iamr"] = "ضب الحمم", ["gl_jamr"] = "ضب الحمم",
    ["m_almas_pen"] = "ضب الألماس", ["m_almas"] = "ضب الألماس",
    ["m_tibr_pen"] = "ضب النبر", ["m_tibr"] = "ضب النبر",
    ["thurayya"] = "ضب الثريا",
    ["gm_farqad_pen"] = "ضب الفرقد", ["gm_farqad"] = "ضب الفرقد",
    ["m_kahraman_pen"] = "ضب الكهرمان", ["m_kahraman"] = "ضب الكهرمان",
    ["gm_jalmood_957f62"] = "ضب الجلمود", ["gm_jalmood"] = "ضب الجلمود",
    ["jalmood"] = "ضب الجلمود", ["gl_jalmood"] = "ضب الجلمود",
    ["gm_abusakhr_pen"] = "ضب أبو صخر", ["gm_abusakhr"] = "ضب أبو صخر",
    ["g_zumurrud_pen"] = "ضب الزمرد", ["g_zumurrud"] = "ضب الزمرد",
    ["m_yaqoot_b0f651"] = "ضب الياقوت", ["m_yaqoot"] = "ضب الياقوت"
}

local CachedDhabs = {}
local NotifiedRareDhabs = {}
local LastKnownStates = {}
local ActiveESP = {}

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.5
FOVCircle.Color = RedTheme.Accent
FOVCircle.Filled = false
FOVCircle.Transparency = 0.7
FOVCircle.Visible = false

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Sairo"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

local NotifySound = Instance.new("Sound", ScreenGui)
NotifySound.SoundId = "rbxassetid://4590657391"
NotifySound.Volume = 0.4

local RareHud = Instance.new("Frame", ScreenGui)
RareHud.Name = "RareHud"
RareHud.Size = UDim2.new(0, 260, 0, 90)
RareHud.Position = UDim2.new(Settings.HudPosX, 0, Settings.HudPosY, 0)
RareHud.BackgroundColor3 = RedTheme.Panel
RareHud.BorderSizePixel = 0
RareHud.Visible = Settings.RareHudActive
RareHud.Active = true
Instance.new("UICorner", RareHud).CornerRadius = UDim.new(0, 12)

local RareHudStroke = Instance.new("UIStroke", RareHud)
RareHudStroke.Color = RedTheme.Accent
RareHudStroke.Thickness = 2.2

local RareHudTitle = Instance.new("TextLabel", RareHud)
RareHudTitle.Size = UDim2.new(1, 0, 0, 28)
RareHudTitle.BackgroundTransparency = 1
RareHudTitle.Text = "👑 رادار الضبان النادرة (T5 & T6)"
RareHudTitle.TextColor3 = RedTheme.Accent
RareHudTitle.TextSize = 12
RareHudTitle.Font = Enum.Font.GothamBold

local RareHudContent = Instance.new("TextLabel", RareHud)
RareHudContent.Size = UDim2.new(1, -16, 1, -34)
RareHudContent.Position = UDim2.new(0, 8, 0, 30)
RareHudContent.BackgroundTransparency = 1
RareHudContent.Text = "جاري البحث عن ضب أسطوري أو خرافي قريب..."
RareHudContent.TextColor3 = Colors.White
RareHudContent.TextSize = 11
RareHudContent.Font = Enum.Font.GothamMedium
RareHudContent.TextWrapped = true
RareHudContent.TextXAlignment = Enum.TextXAlignment.Right
RareHudContent.TextYAlignment = Enum.TextYAlignment.Top

local HudDragging, HudDragStart, HudStartPosition = false, nil, nil
RareHud.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
        HudDragging = true
        HudDragStart = Input.Position
        HudStartPosition = RareHud.Position
        Input.Changed:Connect(function()
            if Input.UserInputState == Enum.UserInputState.End then 
                HudDragging = false 
                Settings.HudPosX = RareHud.Position.X.Scale
                Settings.HudPosY = RareHud.Position.Y.Scale
                SaveSettings()
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if HudDragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
        local Delta = Input.Position - HudDragStart
        RareHud.Position = UDim2.new(HudStartPosition.X.Scale, HudStartPosition.X.Offset + Delta.X, HudStartPosition.Y.Scale, HudStartPosition.Y.Offset + Delta.Y)
    end
end)

local Main = Instance.new("Frame", ScreenGui)
Main.Name = "Main"
Main.Size = UDim2.new(0, 560, 0, 380)
Main.Position = UDim2.new(0.5, -280, 0.5, -190)
Main.BackgroundColor3 = RedTheme.Background
Main.BorderSizePixel = 0
Main.Visible = true
Main.Active = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 18)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = RedTheme.Accent
MainStroke.Thickness = 3

local Header = Instance.new("Frame", Main)
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 52)
Header.BackgroundColor3 = RedTheme.Panel
Header.BorderSizePixel = 0
Header.Active = true
Header.ZIndex = 2
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 18)

local OverlapLogoBg = Instance.new("Frame", Main)
OverlapLogoBg.Name = "OverlapLogoBg"
OverlapLogoBg.Size = UDim2.new(0, 70, 0, 70)
OverlapLogoBg.Position = UDim2.new(0, -12, 0, -14)
OverlapLogoBg.BackgroundColor3 = RedTheme.Background
OverlapLogoBg.ZIndex = 10
Instance.new("UICorner", OverlapLogoBg).CornerRadius = UDim.new(1, 0)

local OverlapLogoStroke = Instance.new("UIStroke", OverlapLogoBg)
OverlapLogoStroke.Thickness = 3.5
OverlapLogoStroke.Color = RedTheme.Accent

local HeaderLogo = Instance.new("ImageLabel", OverlapLogoBg)
HeaderLogo.Size = UDim2.new(1, -6, 1, -6)
HeaderLogo.Position = UDim2.new(0, 3, 0, 3)
HeaderLogo.BackgroundTransparency = 1
HeaderLogo.Image = "rbxassetid://98971861944581"
HeaderLogo.ZIndex = 11
Instance.new("UICorner", HeaderLogo).CornerRadius = UDim.new(1, 0)

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 72, 0, 0)
Title.BackgroundTransparency = 1
Title.RichText = true
Title.Text = 'SAIRO SYSTEM <font color="#FF0A2D">V69.9</font>'
Title.TextColor3 = Colors.White
Title.Text
