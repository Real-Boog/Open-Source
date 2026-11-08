-- claude gaming maxx!!1!1!11!!!!!1111

-- =======================================================================
-- 🔍 XENO EXECUTOR DETECTOR & BYPASS INTERCEPTOR
-- =======================================================================
isXeno = false

-- ตรวจสอบเอกลักษณ์เฉพาะของตัวรัน Xeno (เช่น ฟังก์ชันเฉพาะ หรือ Global Variable)
if identifyexecutor then
    execName = tostring(identifyexecutor()):lower()
    if execName:find("xeno") or execName:find("xen") then
        isXeno = true
    end
end

-- หากตรวจเจอว่าเป็น Xeno ให้ข้ามสคริปต์นี้แล้วไปรันโค้ด Xeno ทันที
if isXeno then
    warn("[Invis Core]: Xeno Executor Detected! Skipping main script and routing to Xeno Engine.")
    
-- =======================================================================
-- 🔒 PART 1: PHYSICS RESOLVER & XENO CAMERA CURVE SYSTEM
-- =======================================================================
Players = game:GetService("Players")
RunService = game:GetService("RunService")
LocalPlayer = Players.LocalPlayer

-- ตารางจัดการ Global State (คัดลอกไปเชื่อมหรือแทนที่ในตาราง Config ของคุณได้เลย)
Xeno_Config = {
    AutoParry = true,
    AutoSpam = false,
    ManualSpam = false,
    
    AutoSpamSpeed = 0.01,    -- ค่าเริ่มต้น 0.01 วินาที (ปรับได้เร็วสุด 0.001)
    ManualSpamSpeed = 0.01,  -- ค่าเริ่มต้น 0.01 วินาที (ปรับได้เร็วสุด 0.001)
    
    wowcurve = 0.35,         -- ค่าดักทางบอลไซด์โค้ง
}

parryLocked = {}
lockTime = {}

-- ฟังก์ชันค้นหาลูกบอลแท้ในสนาม
function GetActiveBall()
    local bc = workspace:FindFirstChild("Balls") or workspace:FindFirstChild("TrainingBalls")
    if bc then
        for _, b in pairs(bc:GetChildren()) do
            if b:IsA("BasePart") and (b:GetAttribute("realBall") or b:GetAttribute("target")) then 
                return b 
            end
        end
    end
    return nil
end

-- ฟังก์ชันดักจับวิถีโค้งเวอร์ชันปรับปรุง (High-Accuracy Anti-Curve Engine)
local function IsBallCurving(ball, hrp)
    if not ball or not hrp then return false end
    local ballVel = ball.AssemblyLinearVelocity
    if ballVel.Magnitude < 1 then return false end

    local dirToPlayer = (hrp.Position - ball.Position).Unit
    local ballDir = ballVel.Unit
    local dot = ballDir:Dot(dirToPlayer)

    -- คำนวณขอบเขตเวกเตอร์เบี่ยงเบนด้านข้าง (Lateral Deviation)
    local lateralVelocity = ballVel - (ballVel:Dot(dirToPlayer) * dirToPlayer)
    
    -- หากบอลมีแรงเหวี่ยงออกด้านข้างเกิน 16% หรือ Dot Product หลุดจากแนวตรง ให้ถือว่าโค้งทันที
    if lateralVelocity.Magnitude / ballVel.Magnitude > 0.16 then
        return true
    end

    -- ขยายขอบเขต Dot Product เพื่อดักจับบอลย้อยหรือบอลปักลงพื้น (แกน Y)
    return (dot < 0.82 and dot > -0.75) or math.abs(ballDir.Y) > 0.25
end
Auto_Parry.Is_Curved = IsBallCurving

-- 🛡️ MAIN RENDERSTEPPED LOOP FOR AUTO PARRY
RunService.RenderStepped:Connect(function()
    if not Xeno_Config.AutoParry then return end
    
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp or (char:FindFirstChildOfClass("Humanoid") and char:FindFirstChildOfClass("Humanoid").Health <= 0) then return end

    local ball = GetActiveBall()
    if not ball then return end

    local targetAttr = ball:GetAttribute("target") or ball:GetAttribute("Target")
    local isTargetingMe = (tostring(targetAttr or "") == LocalPlayer.Name)
    if not isTargetingMe then return end

    local ballPos = ball.Position
    local distance = (hrp.Position - ballPos).Magnitude
    if distance > 125 then return end

    local velocity = ball.AssemblyLinearVelocity
    local speed = velocity.Magnitude
    local reachTime = distance / math.max(speed, 1)

    -- ระบบปลดล็อก Cooldown ล่วงหน้า (Xeno Safety Buff)
    -- ดักล้างคูลดาวน์ล่วงหน้า 0.5 วินาที เพื่อให้เฟรมถัดไปสแตนด์บายคลิกเมาส์ได้ทันที
    if parryLocked[ball] then
        local baseCooldown = math.clamp(4.9 - (speed * 0.01), 0.7, 0.85)
        local xenoAdjustedCooldown = baseCooldown - 0.5 -- หักลบดีเลย์ระบบตัวเกมออก 0.5 วินาที
        
        if os.clock() - (lockTime[ball] or 0) >= math.max(0.1, xenoAdjustedCooldown) then
            parryLocked[ball] = false
        else
            return
        end
    end

    -- ตรรกะประมวลผลมุมยิงสำหรับการตรวจสอบเงื่อนไข
    local ballDirection = speed > 1 and velocity.Unit or Vector3.new(0, -1, 0)
    local toPlayerDirection = distance > 0.1 and (hrp.Position - ballPos).Unit or Vector3.zero
    local dotProduct = ballDirection:Dot(toPlayerDirection)

    local triggerParry = false

    -- ตรวจสอบวิถีไซด์โค้ง
    if IsBallCurving(ball, hrp) then
        local lateralVelocity = velocity - (velocity.Unit:Dot(toPlayerDirection) * velocity.Unit)
        local strikeZone = math.clamp((12 + (speed * Xeno_Config.wowcurve)) - (lateralVelocity.Magnitude * 0.135), 17, 135)
        
        if distance <= strikeZone or reachTime <= 0.2 then
            if dotProduct > -0.35 or distance <= 35 then
                triggerParry = true
            end
        end
    else
        -- วิถีตรงปกติ
        local normalZone = math.clamp(8.5 + (speed * 0.3), 8.5, 68)
        if distance <= normalZone or reachTime <= 0.05 then
            triggerParry = true
        end
    end

    -- สั่งการส่งสัญญาณยิงเมาส์
    if triggerParry and not parryLocked[ball] then
        parryLocked[ball] = true
        lockTime[ball] = os.clock()
        
        -- เรียกใช้งานข้ามไปสั่งคลิกเมาส์ในระบบเสมือน (Part 2)
        if FireXenoSafeMouse then
            FireXenoSafeMouse()
        end
    end
end)

-- =======================================================================
-- ⌨️ PART 2: SPAM CONTROL ENGINE & SAFE XENO MOUSE INPUT
-- =======================================================================
local UserInputService = game:GetService("UserInputService")

-- 🔒 ฟังก์ชันส่งคำสั่งคลิกเมาส์แบบปลอดภัยและรองรับการสะท้อนพิกัดให้ตัวเกม (Safe Mouse Input)
function FireXenoSafeMouse()
    if mouse1press and mouse1release then
        pcall(function()
            -- ใช้การสะกิดกดแล้วปล่อยในเสี้ยวเฟรมที่สั้นที่สุดเพื่อป้องกันคำสั่งค้างบน Xeno
            mouse1press()
            task.wait(0.0005)
            mouse1release()
        end)
    end
end

-- ⚔️ LOOP 1: AUTO SPAM ENGINE (THREAD-SAFE PIPELINE)
task.spawn(function()
    while true do
        -- ดึงค่าหน่วงเวลาแปรผันตรง และล็อกขอบเขตขั้นต่ำสุดไว้ที่ 0.001 วินาทีตามสั่ง
        local currentDelay = tonumber(Xeno_Config.AutoSpamSpeed) or 0.01
        local enforcedDelay = math.clamp(currentDelay, 0.001, 2.0)
        
        if Xeno_Config.AutoSpam then
            pcall(FireXenoSafeMouse)
        end
        
        task.wait(enforcedDelay)
    end
end)

-- ⚔️ LOOP 2: MANUAL SPAM ENGINE (THREAD-SAFE PIPELINE)
task.spawn(function()
    while true do
        -- ดึงค่าหน่วงเวลาแปรผันตรง และล็อกขอบเขตขั้นต่ำสุดไว้ที่ 0.001 วินาทีตามสั่ง
        local currentDelay = tonumber(Xeno_Config.ManualSpamSpeed) or 0.01
        local enforcedDelay = math.clamp(currentDelay, 0.001, 2.0)
        
        if Xeno_Config.ManualSpam then
            pcall(FireXenoSafeMouse)
        end
        
        task.wait(enforcedDelay)
    end
end)

-- ⌨️ DETECTION PIPELINE: ผูกสัญญาณปุ่ม E สำหรับเปิด/ปิดระบบ Manual Spam อัตโนมัติ
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end -- ป้องกันบอทสแปมทำงานตอนที่ผู้เล่นกำลังพิมพ์ในช่องแชท
    
    if input.KeyCode == Enum.KeyCode.E then
        Xeno_Config.ManualSpam = not Xeno_Config.ManualSpam
        
        -- (เสริมสำหรับการแจ้งเตือนบนหน้าต่างประมวลผลของตัวรัน)
        if Xeno_Config.ManualSpam then
            print("[Xeno Input]: Manual Spam Overdrive activated.")
        else
            print("[Xeno Input]: Manual Spam Overdrive deactivated.")
        end
    end
end)

-- =======================================================================
-- 📌 PART 1: STANDALONE CYBERPUNK MAIN FRAME (INTERFACE ONLY)
-- =======================================================================
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 🎨 THEME COLORS & PALETTE (Cyber Neo Theme)
getgenv().InvisUI_Theme = {
    Background = Color3.fromRGB(10, 10, 14),
    CardBg     = Color3.fromRGB(18, 18, 26),
    Accent     = Color3.fromRGB(0, 240, 255),  -- Electric Cyan
    AccentGlow = Color3.fromRGB(255, 0, 128),  -- Cyber Pink
    TextMain   = Color3.fromRGB(255, 255, 255),
    TextDark   = Color3.fromRGB(130, 135, 145),
    Active     = Color3.fromRGB(0, 255, 150),
    Inactive   = Color3.fromRGB(255, 45, 85)
}
local THEME = getgenv().InvisUI_Theme

-- 🖼️ SCREEN GUI SETUP
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "InvisXeno_PremiumUI_" .. math.random(100, 999)
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    if gethui then ScreenGui.Parent = gethui()
    elseif CoreGui then ScreenGui.Parent = CoreGui
    else ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
end)
getgenv().InvisUI_ScreenGui = ScreenGui

-- 🖼️ MAIN FRAME WINDOW (ใช้ CanvasGroup เพื่อทำอนิเมชันเปิด/ปิดสมูท)
local MainFrame = Instance.new("CanvasGroup", ScreenGui)
MainFrame.Size = UDim2.new(0, 390, 0, 330)
MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
MainFrame.BackgroundColor3 = THEME.Background
MainFrame.GroupTransparency = 0
MainFrame.Visible = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
getgenv().InvisUI_MainFrame = MainFrame

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 2
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- 🌈 อนิเมชันกรอบไฟวิ่ง RGB ไหลเชื่องช้าเพิ่มความเท่รอบตัวหน้าต่าง
task.spawn(function()
    while true do
        for i = 0, 1, 0.005 do
            if MainStroke and MainStroke.Parent then
                MainStroke.Color = Color3.fromHSV(i, 0.8, 1)
            end
            task.wait(0.02)
        end
    end
end)

-- 📌 ระบบลากย้ายตำแหน่งหน้าต่าง Main Frame
local mDrag, mStart, mPos
MainFrame.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        mDrag = true; mStart = i.Position; mPos = MainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if mDrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - mStart
        MainFrame.Position = UDim2.new(mPos.X.Scale, mPos.X.Offset + d.X, mPos.Y.Scale, mPos.Y.Offset + d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then mDrag = false end
end)

-- 🏷️ HEADER TITLE
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 42)
Title.Text = "   ⚡ INVIS HUB — XENO PANEL"
Title.TextColor3 = THEME.TextMain
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

-- 📜 SCROLL BAR CONTAINER
local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Size = UDim2.new(1, -20, 1, -55)
Container.Position = UDim2.new(0, 10, 0, 46)
Container.BackgroundTransparency = 1
Container.BorderSizePixel = 0
Container.ScrollBarThickness = 2
Container.ScrollBarImageColor3 = THEME.Accent
Container.CanvasSize = UDim2.new(0, 0, 0, 0)
Container.AutomaticCanvasSize = Enum.AutomaticSize.Y

local Layout = Instance.new("UIListLayout", Container)
Layout.Padding = UDim.new(0, 8)
Layout.SortOrder = Enum.SortOrder.LayoutOrder

-- 🎛️ PREMIUM ANIMATED TOGGLE CREATOR (ปุ่มเปิด/ปิดเปล่าๆ คืนค่าสถานะให้คุณใช้รันสคริปต์ต่อ)
function createStandaloneToggle(name, defaultState, callback)
    local card = Instance.new("Frame", Container)
    card.Size = UDim2.new(1, -6, 0, 38)
    card.BackgroundColor3 = THEME.CardBg
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6)
    local s = Instance.new("UIStroke", card)
    s.Color = Color3.fromRGB(35, 35, 45)
    s.Thickness = 1

    local lbl = Instance.new("TextLabel", card)
    lbl.Size = UDim2.new(1, -70, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.Text = name
    lbl.TextColor3 = THEME.TextMain
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.BackgroundTransparency = 1

    local btn = Instance.new("TextButton", card)
    btn.Size = UDim2.new(0, 48, 0, 22)
    btn.Position = UDim2.new(1, -60, 0.5, -11)
    btn.Text = ""
    btn.BackgroundColor3 = THEME.Inactive
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

    local thumb = Instance.new("Frame", btn)
    thumb.Size = UDim2.new(0, 16, 0, 16)
    thumb.Position = UDim2.new(0, 3, 0.5, -8)
    thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)

    local currentState = defaultState or false

    local function updateVisuals(animate)
        local tPos = currentState and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
        local tColor = currentState and THEME.Active or THEME.Inactive
        local duration = animate and 0.25 or 0
        
        TweenService:Create(thumb, TweenInfo.new(duration, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = tPos}):Play()
        TweenService:Create(btn, TweenInfo.new(duration, Enum.EasingStyle.Quad), {BackgroundColor3 = tColor}):Play()
        TweenService:Create(s, TweenInfo.new(duration, Enum.EasingStyle.Quad), {Color = currentState and THEME.Accent or Color3.fromRGB(35, 35, 45)}):Play()
    end

    btn.MouseButton1Click:Connect(function()
        currentState = not currentState
        updateVisuals(true)
        if callback then callback(currentState) end
    end)
    updateVisuals(false)
    return btn
end

-- ⌨️ PREMIUM ANIMATED TEXTBOX CREATOR (ช่องกรอกค่าเปล่าๆ)
function createStandaloneTextBox(name, defaultText, callback)
    local card = Instance.new("Frame", Container)
    card.Size = UDim2.new(1, -6, 0, 38)
    card.BackgroundColor3 = THEME.CardBg
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6)
    local s = Instance.new("UIStroke", card)
    s.Color = Color3.fromRGB(35, 35, 45)

    local lbl = Instance.new("TextLabel", card)
    lbl.Size = UDim2.new(0, 160, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.Text = name
    lbl.TextColor3 = THEME.TextMain
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.BackgroundTransparency = 1

    local box = Instance.new("TextBox", card)
    box.Size = UDim2.new(1, -185, 0, 24)
    box.Position = UDim2.new(0, 172, 0.5, -12)
    box.Text = tostring(defaultText or "")
    box.TextColor3 = THEME.Accent
    box.Font = Enum.Font.GothamBold
    box.TextSize = 11
    box.BackgroundColor3 = THEME.Background
    box.ClearTextOnFocus = false
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
    Instance.new("UIStroke", box).Color = Color3.fromRGB(45, 45, 55)

    box.Focused:Connect(function()
        TweenService:Create(s, TweenInfo.new(0.2), {Color = THEME.AccentGlow}):Play()
    end)

    box.FocusLost:Connect(function()
        TweenService:Create(s, TweenInfo.new(0.2), {Color = Color3.fromRGB(35, 35, 45)}):Play()
        if callback then callback(box.Text) end
    end)
end

-- 🔘 ตัวอย่างการสร้าง UI เปล่าๆ (คุณสามารถนำ callback ไปเชื่อมตัวแปรของสคริปต์คุณได้ทันที)
createStandaloneToggle("Auto Parry System", false, function(state) end)
createStandaloneToggle("Auto Spam Clash", false, function(state) end)
createStandaloneToggle("Manual Spam Overdrive", false, function(state) end)
createStandaloneTextBox("Auto Spam Speed", "0.010", function(text) end)
createStandaloneTextBox("Manual Spam Speed", "0.010", function(text) end)
createStandaloneTextBox("Anti-Curve Adjust", "0.350", function(text) end)

-- =======================================================================
-- 📌 PART 2: FLOATING TOGGLE BUTTON & PREMIUM EXPAND ANIMATIONS
-- =======================================================================
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- ดึง Object ส่วนแอนิเมชันข้ามไฟล์ที่แชร์ไว้จากพาร์ทแรก
local ScreenGui = getgenv().InvisUI_ScreenGui
local MainFrame = getgenv().InvisUI_MainFrame
local THEME = getgenv().InvisUI_Theme

if not ScreenGui or not MainFrame or not THEME then
    warn("[Invis UI Error]: Please run Part 1 before executing Part 2!")
    return
end

-- 🔘 FLOATING TOGGLE BUTTON (สร้างปุ่มวงกลมลอยตัวสไตล์พรีเมียม)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
ToggleBtn.BackgroundColor3 = THEME.Background
ToggleBtn.Text = "INVIS"
ToggleBtn.TextColor3 = THEME.Accent
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 11
ToggleBtn.AutoButtonColor = false
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

local ButtonStroke = Instance.new("UIStroke", ToggleBtn)
ButtonStroke.Thickness = 2
ButtonStroke.Color = THEME.Accent

-- เอฟเฟกต์ไฟนีออนกระพริบวูบวาบสลับสีช้าๆ (Neon Pulse Effect) รอบปุ่มวงกลม
task.spawn(function()
    while true do
        if ButtonStroke and ButtonStroke.Parent then
            TweenService:Create(ButtonStroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Color = THEME.AccentGlow}):Play()
            task.wait(0.8)
            TweenService:Create(ButtonStroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Color = THEME.Accent}):Play()
            task.wait(0.8)
        else
            break
        end
    end
end)

-- 📌 ระบบลากย้ายตำแหน่งปุ่มวงกลมอิสระ (คัดกรองไม่ให้ทำงานซ้อนกับตรรกะคลิกเปิดปิดเมนู)
local tDrag, tStart, tPos, dragStartPos
local isDragging = false

ToggleBtn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        tDrag = true; tStart = i.Position; tPos = ToggleBtn.Position
        dragStartPos = UserInputService:GetMouseLocation()
        isDragging = false
        -- แอนิเมชันปุ่มหดตัวตอนนิ้วกดจิ้ม (Squish Compression Impact)
        TweenService:Create(ToggleBtn, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 44, 0, 44)}):Play()
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if tDrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        if (UserInputService:GetMouseLocation() - dragStartPos).Magnitude > 5 then
            isDragging = true
        end
        if isDragging then
            local d = i.Position - tStart
            ToggleBtn.Position = UDim2.new(tPos.X.Scale, tPos.X.Offset + d.X, tPos.Y.Scale, tPos.Y.Offset + d.Y)
        end
    end
end)

local guiState = true
local isTransitioning = false

ToggleBtn.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        tDrag = false
        -- แอนิเมชันปุ่มกลมดีดตัวกลับขนาดเดิมแบบสปริงยืดหยุ่น (Elastic Pop Bounce)
        TweenService:Create(ToggleBtn, TweenInfo.new(0.3, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = UDim2.new(0, 50, 0, 50)}):Play()
        
        -- ตรวจสอบเงื่อนไข: หากไม่ได้ลากปุ่ม แปลว่าเป็นการ "คลิกตั้งใจเปิดปิด" -> รันแอนิเมชันหน้าต่างระดับท็อป
        if not isDragging and not isTransitioning then
            isTransitioning = true
            guiState = not guiState
            
            if guiState then
                -- ✨ แอนิเมชันเปิดเมนู: ระเบิดตัวขยายมิติใหญ่ขึ้นมาจากพิกัดจุดเล็กๆ (Scale Snap Back)
                MainFrame.Visible = true
                MainFrame.Size = UDim2.new(0, 10, 0, 10)
                TweenService:Create(MainFrame, TweenInfo.new(0.38, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, 390, 0, 330),
                    GroupTransparency = 0
                }):Play()
                task.wait(0.38)
                isTransitioning = false
            else
                -- ✨ แอนิเมชันปิดเมนู: ยุบขนาดกรอบหน้าต่างตัวลงพร้อมค่อยๆ จางหายลื่นไหล (Smooth Fade Out)
                TweenService:Create(MainFrame, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Size = UDim2.new(0, 290, 0, 230),
                    GroupTransparency = 1
                }):Play()
                task.wait(0.22)
                MainFrame.Visible = false
                isTransitioning = false
            end
        end
    end
end)

    return -- 🛑 ใช้ return เพื่อตัดจบการทำงาน ไม่ให้โค้ดบรรทัดล่างถัดจากนี้ทำงานอีกต่อไป
end
-- =======================================================================

if isXeno == false or not isXeno then
repeat task.wait() until game:IsLoaded()

--== AUTO COPY LINK ON START ==
pcall(function()
    if setclipboard then 
        setclipboard("https://youtube.com/@invis_in") 
    elseif toclipboard then 
        toclipboard("https://youtube.com/@invis_in") 
    end
end)

Players = game:GetService("Players")
RunService = game:GetService("RunService")
UserInputService = game:GetService("UserInputService")
Workspace = game:GetService("Workspace")
Lighting = game:GetService("Lighting")
Terrain = Workspace:FindFirstChildOfClass("Terrain")
LocalPlayer = Players.LocalPlayer

-- ═══ SERVICES & GLOBALS ════════════════════════════════════════════════
RunService        = game:GetService("RunService")
 Players           = game:GetService("Players")
 LocalPlayer       = Players.LocalPlayer
 Player            = Players.LocalPlayer
 UserInputService  = game:GetService("UserInputService")
 TweenService      = game:GetService("TweenService")
 CoreGui           = game:GetService("CoreGui")
 StarterGui        = game:GetService("StarterGui")
 StatsService      = game:GetService("Stats")
 ReplicatedStorage = game:GetService("ReplicatedStorage")
 Debris            = game:GetService("Debris")
 Lighting          = game:GetService("Lighting")
 TeleportService   = game:GetService("TeleportService")
HttpService       = game:GetService("HttpService")

if shared._InvisRunning then
    shared._InvisRunning = false
    if shared._PhysicsBind then shared._PhysicsBind:Disconnect(); shared._PhysicsBind = nil end
    if shared._FlyBind then shared._FlyBind:Disconnect(); shared._FlyBind = nil end
    task.wait(0.1)
end
shared._InvisRunning = true

-- ═══ CONFIGURATION & GLOBAL STATE ══════════════════════════════════════
Config = {
    AutoParry = false,
    ParryMode = "Curve", 
    TargetTime = 67,       
    DistanceTiming = 100, 
    ParryCurveMode = "Camera", 
    HitSpeedMode = "Fast ball", 
    TargetMode = "Normal", 
    AutoSpam = false,
    UseMouseLocation = false,
    packetBatchSize = 3,   
    trainingPacketBatchSize = 16,   
    ClashTarget = true,        
    
    -- New Updates Config
    AbilityESP = false,
    SoccerMode = false,
    GodMode = false,
    CustomSpeed = nil,
    CustomJump = nil,
    CustomAnimID = "",
    
    SkinChangerEnabled = false,
    SwordName = "",
    SwordAnimName = "",
    SwordFXName = "",
    SwordAnimationsEnabled = true,
    EmoteName = "",
    LowGraphicsEnabled = false,
    
    SpecialSkillDetections = false,
    AutoPlay = false,
    AutoJumpEnabled = false,
    
    DesyncEnabled = false,
    DesyncMode = "1: Infinite Sky",
    ParryDirection = "Straight",
    AntiAfk = false,
    
    LookAtBallChar = false,
    LookAtBallCam = false,
    
    PlayerESP = false,  
    wowcurve = 0.33,
    
    UIBackground = "DARK",
    
    CustomComboFX = false,

    MusicEnabled = false,
    MusicLooped = false,
    MusicVolume = 0.5,
    MaxPlayTime = 60,      
    
    ParryMethodMode = "Bypass",
    AI_AutoParry = false,
    huh = 1,
    
    UnlockCooldownMode = "Parry success(cooldown)",
}

local BackgroundColors = {
    "DARK",
    "RED",
    "BLUE",
    "PURPLE",
    "GREEN",
    "ORANGE",
    "YELLOW",
    "PINK",
    "WHITE",
    "CYAN",
    "MAGENTA"
}

-- ===============================================================================
-- 🖼️ SAFE SCREEN GUI SETUP (COMPLETELY FIXED & ANTI-CRASH VERSION)
-- ===============================================================================
local UI_Target_Parent = nil

-- ใช้ pcall ล้อมรอบทุกการดึงค่า Environment เพื่อป้องกันการระเบิดของ Thread
pcall(function()
    if gethui and type(gethui) == "function" then
        UI_Target_Parent = gethui()
    end
end)

pcall(function()
    if not UI_Target_Parent and get_hidden_ui and type(get_hidden_ui) == "function" then
        UI_Target_Parent = get_hidden_ui()
    end
end)

pcall(function()
    if not UI_Target_Parent then
        local coreGui = game:GetService("CoreGui")
        -- ดึงพิกัดแบบรัดกุมที่สุด ตรวจเช็คว่า CoreGui ต้องไม่ใช่ค่าว่างก่อนเคาะหาลูก
        if coreGui and coreGui:FindFirstChild("RobloxGui") then
            UI_Target_Parent = coreGui
        end
    end
end)

-- แผนสำรองสุดท้าย: หากตัวรัน Delta ตัดขาดสิทธิ์ทั้งหมด ให้โยนเข้า PlayerGui เผื่อเซฟฟังก์ชันใช้งาน
if not UI_Target_Parent then
    local lp = game:GetService("Players").LocalPlayer
    UI_Target_Parent = lp and lp:WaitForChild("PlayerGui", 10)
end

-- =======================================================================
-- 🔒 INVIS HUB — ADVANCED ANTI-DETECTION RANDOM STRING GENERATOR
-- =======================================================================
function GenerateUltimateRandomName(length)
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789⅛⅜⅝⁶▶︎•၊||၊|။||||။‌‌‌‌‌‌၊|•:×∆§√|`~^°©®™✓%€£][\/?!฿$₹#@."
    local result = {}
    math.randomseed(os.time() + math.random(1, 9999)) -- เพิ่มความแปรผันของ Seed ป้องกันการสุ่มซ้ำในวินาทีเดียวกัน
    for i = 1, length or 16 do
        local randIndex = math.random(1, #chars)
        table.insert(result, string.sub(chars, randIndex, randIndex))
    end
    return table.concat(result)
end
-- =======================================================================

iamatomicop = math.random(8, 23)

-- สั่งเริ่มสร้าง Instance ScreenGui เมื่อตรวจสอบแล้วว่าโฟลเดอร์ปลายทางพร้อมใช้งาน
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "shadow_" .. GenerateUltimateRandomName(iamatomicop)
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ป้องกันจุดตาย FindFirstChild บนวัตถุ Nil โดยเพิ่มระบบตรวจสอบเงื่อนไขความพร้อม
if UI_Target_Parent then
    ScreenGui.Parent = UI_Target_Parent
    shared._InvisHubStealthGui = ScreenGui
else
    -- กรณีฉุกเฉินระดับสูงสุดเพื่อหลีกเลี่ยงข้อผิดพลาดใน Developer Console
    warn("[Invis Core UI Error]: All parental pipelines are severely restricted.")
end

-- 🎨 ULTIMATE INVIS MINIMAL WHITE DYNAMIC NOTIFICATION SYSTEM
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")

-- สร้างตัวแปร NotificationHolder ส่วนกลาง (ถ้ายังไม่มี)
local NotificationHolder = nil

local function CustomNotify(text, duration)
    duration = duration or 4
    local timeLeft = duration

    -- 🛡️ ตรวจสอบและสร้าง NotificationHolder หากไม่พบในระบบ
    if not NotificationHolder or not NotificationHolder.Parent then
        local targetGui = getgenv().InvisUI_ScreenGui or shared._InvisHubStealthGui or ScreenGui
        if targetGui then
            NotificationHolder = targetGui:FindFirstChild("InvisNotificationHolder")
            if not NotificationHolder then
                NotificationHolder = Instance.new("Frame")
                NotificationHolder.Name = "InvisNotificationHolder"
                NotificationHolder.Size = UDim2.new(0, 280, 0, 400)
                NotificationHolder.Position = UDim2.new(1, -290, 1, -410) -- มุมขวาล่างของจอ
                NotificationHolder.BackgroundTransparency = 1
                NotificationHolder.Parent = targetGui

                local layout = Instance.new("UIListLayout", NotificationHolder)
                layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
                layout.SortOrder = Enum.SortOrder.LayoutOrder
                layout.Padding = UDim.new(0, 6)
            end
        end
    end

    -- 📦 1. สร้างกรอบการ์ดแจ้งเตือนหลัก (Main Card Container)
    local card = Instance.new("Frame", NotificationHolder)
    card.Size = UDim2.new(1, 0, 0, 40) -- ขนาดเริ่มต้น 1 บรรทัด
    card.BackgroundColor3 = Color3.fromRGB(15, 15, 18) -- สีพื้นหลังมืดสไตล์ Rise UI
    card.BackgroundTransparency = 0.25 -- เปิดความโปร่งแสงใสให้เห็นมิติวอลเปเปอร์ด้านหลัง
    card.BorderSizePixel = 0
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)

    -- ✨ เอฟเฟกต์ขอบเรืองแสงสไตล์ขาวมินิมอล (Elegant White Border Stroke)
    local stroke = Instance.new("UIStroke", card)
    stroke.Thickness = 1.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local strokeGradient = Instance.new("UIGradient", stroke)
    strokeGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(245, 245, 250)), -- สีขาวผินสะอาดตาค่าย Invis
        ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 160, 170))  -- สีเทาเงินหรูหรา
    })
    strokeGradient.Rotation = 20

    -- 🏷️ 2. ไอคอนและข้อความแจ้งเตือน (Icon & Dynamic Text Label)
    local txt = Instance.new("TextLabel", card)
    txt.Position = UDim2.new(0, 12, 0, 0)
    txt.Size = UDim2.new(1, -67, 1, -4) -- เว้นพื้นที่ด้านขวาให้ปุ่ม X และเวลานับถอยหลัง
    txt.Text = "🔔  " .. text
    txt.TextColor3 = Color3.fromRGB(255, 255, 255) -- ตัวอักษรสีขาวสว่างเด่นชัด
    txt.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold) -- ฟอนต์ Montserrat ตัวหนาของ Rise
    txt.TextSize = 11
    txt.BackgroundTransparency = 1
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.TextYAlignment = Enum.TextYAlignment.Center
    txt.TextWrapped = true -- เปิดใช้งานระบบขึ้นบรรทัดใหม่อัตโนมัติ

    -- 📐 [DYNAMIC RESIZING]: คำนวณความยาวข้อความ หากยาวเกินหน้าจอให้ขยายกรอบเป็น 2 บรรทัด
    task.spawn(function()
        -- ตรวจสอบเงื่อนไขความปลอดภัยเพื่อป้องกันความผิดพลาดกรณี AbsoluteSize เป็นลบหรือไม่มีค่า
        local maxTextWidth = (NotificationHolder and NotificationHolder.AbsoluteSize.X > 0) and (NotificationHolder.AbsoluteSize.X - 75) or 205
        local textParams = Instance.new("GetTextBoundsParams")
        textParams.Text = txt.Text
        textParams.Font = Enum.Font.GothamBold
        textParams.Size = txt.TextSize
        textParams.Width = maxTextWidth

        local success, textBounds = pcall(function()
            return TextService:GetTextBoundsAsync(textParams)
        end)

        if success and textBounds.Y > 16 then
            -- ข้อความยาวเกิน 1 บรรทัด ขยายความสูงของการ์ดเป็น 54px สำหรับ 2 บรรทัด
            card.Size = UDim2.new(1, 0, 0, 54)
        end
    end)

    -- ⏱️ 3. ข้อความแสดงเวลานับถอยหลัง (Time Remaining Label)
    local timeLabel = Instance.new("TextLabel", card)
    timeLabel.Size = UDim2.new(0, 24, 0, 20)
    timeLabel.Position = UDim2.new(1, -52, 0.5, -10)
    timeLabel.BackgroundTransparency = 1
    timeLabel.Text = tostring(math.ceil(timeLeft)) .. "s"
    timeLabel.TextColor3 = Color3.fromRGB(180, 180, 185) -- สีเทาขาวสว่างมินิมอล
    timeLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
    timeLabel.TextSize = 10
    timeLabel.TextXAlignment = Enum.TextXAlignment.Right

    -- 🔘 4. ปุ่มกดปิดแบบเร่งด่วน (X Close Button)
    local closeBtn = Instance.new("TextButton", card)
    closeBtn.Size = UDim2.new(0, 20, 0, 20)
    closeBtn.Position = UDim2.new(1, -26, 0.5, -10)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 75, 75) -- ปุ่มกากบาทสีแดงสะดุดตา
    closeBtn.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
    closeBtn.TextSize = 12
    closeBtn.AutoButtonColor = false

    -- ⏳ 5. หลอดความคืบหน้าเวลาด้านล่างการ์ด (Neon Progress Timeline Bar)
    local progressBar = Instance.new("Frame", card)
    progressBar.Size = UDim2.new(1, -16, 0, 2)
    progressBar.Position = UDim2.new(0, 8, 1, -4)
    progressBar.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
    progressBar.BorderSizePixel = 0
    Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 1)

    local progressGradient = Instance.new("UIGradient", progressBar)
    progressGradient.Color = strokeGradient.Color

    -- 🎬 6. แอนิเมชันเปิดตัวการ์ดแบบสมูท (Fade-In Transition Effect)
    card.BackgroundTransparency = 1
    txt.TextTransparency = 1
    stroke.Transparency = 1
    timeLabel.TextTransparency = 1
    closeBtn.TextTransparency = 1
    progressBar.BackgroundTransparency = 1

    TweenService:Create(card, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundTransparency = 0.25}):Play()
    TweenService:Create(txt, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
    TweenService:Create(stroke, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Transparency = 0}):Play()
    TweenService:Create(timeLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
    TweenService:Create(closeBtn, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
    TweenService:Create(progressBar, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()

    -- แอนิเมชันหลอดเวลาค่อยๆ ยุบลงตามระยะเวลา Duration จริง
    local timelineTween = TweenService:Create(progressBar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 0, 2)})
    timelineTween:Play()

    -- 🔁 7. ลูปนับถอยหลังอัปเดตตัวเลขวินาทีแบบ Real-Time ทุกๆ 0.1 วินาที
    local timerRunning = true
    task.spawn(function()
        while timeLeft > 0 and timerRunning do
            task.wait(0.1)
            timeLeft = timeLeft - 0.1
            if timeLabel and timeLabel.Parent then
                timeLabel.Text = tostring(math.ceil(timeLeft)) .. "s"
            end
        end
    end)

    -- 🎬 8. ฟังก์ชันแอนิเมชันปิดการ์ด (Fade-Out & Destroy Function)
    local isClosing = false
    local function fadeOutAndDestroy()
        if isClosing then return end
        isClosing = true
        timerRunning = false
        timelineTween:Cancel()

        local t1 = TweenService:Create(card, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0)})
        local t2 = TweenService:Create(txt, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextTransparency = 1})
        local t3 = TweenService:Create(stroke, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Transparency = 1})
        local t4 = TweenService:Create(timeLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextTransparency = 1})
        local t5 = TweenService:Create(closeBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextTransparency = 1})
        local t6 = TweenService:Create(progressBar, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 1})

        t1:Play() t2:Play() t3:Play() t4:Play() t5:Play() t6:Play()
        t1.Completed:Connect(function()
            card:Destroy()
        end)
    end

    -- ⚡ ผูกเหตุการณ์: ปิดการ์ดทันทีเมื่อกดปุ่ม X หรือปล่อยให้หมดเวลาตามกําหนด
    closeBtn.MouseButton1Click:Connect(fadeOutAndDestroy)
    task.delay(duration, function()
        if card and card.Parent then
            fadeOutAndDestroy()
        end
    end)

    -- เอฟเฟกต์โฮเวอร์เมาส์ปุ่ม X เพิ่มความพรีเมียม
    closeBtn.MouseEnter:Connect(function() TweenService:Create(closeBtn, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255, 120, 120)}):Play() end)
    closeBtn.MouseLeave:Connect(function() TweenService:Create(closeBtn, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255, 75, 75)}):Play() end)
end

local Auto_Parry = {}
getgenv().ZX_Parry = getgenv().ZX_Parry or { Hooked = true, KeyTable = "Ball", Remote = true } -- เพิ่มบรรทัดนี้เพื่อสร้าง Table รองรับข้อมูล
local lastParryTime = 0
local parryCooldown = 0.035
local lastHitTick = 0
local lastTargetChecked = nil
local rallyCounter = 0
local lastBallPossession = nil
local Last_Parry = 0
local Cache_Update_Tick = 0
local Last_Positions_Cache = {}

-- ═══ ANTI-SPAM HIGH SPEED RALLY TRACKER ═══════════════════════════════
local rallyTracker = {
    lastTarget = nil,
    counter = 0,
    validRallies = 0,
    lastChangeTick = 0
}

getgenv()._ZX_VelHistory = getgenv()._ZX_VelHistory or { ball = {}, player = {}, MAX_SAMPLES = 7 }
local _ZX_VelHistory = getgenv()._ZX_VelHistory

local function _ZX_pushVelSample(target, pos, vel)
    local history = target == "ball" and _ZX_VelHistory.ball or _ZX_VelHistory.player
    table.insert(history, 1, { pos = pos, vel = vel, t = tick() })
    while #history > _ZX_VelHistory.MAX_SAMPLES do table.remove(history, #history) end
end

local function GetEmergencyDistance(speed)
    -- เพิ่มตัวคูณตามความเร็วบอลจริงเพื่อให้ระบบกด Parry ล่วงหน้าอัตโนมัติในระดับมิลลิวินาที
    local calculated = 10 + (speed * 0.12)
    return math.clamp(calculated, 12, 65) -- ขยายเพดานสูงสุดเพิ่มเป็น 95 สตัดสำหรับบอลความเร็วสูง
end

function Auto_Parry.Get_Ball()
    local bc = workspace:FindFirstChild("Balls") or workspace:FindFirstChild("TrainingBalls")
    if bc then
        for _, b in pairs(bc:GetChildren()) do
            if b:IsA("BasePart") and (b:GetAttribute("realBall") or b:GetAttribute("target")) then 
                return b 
            end
        end
    end
    
    -- 🚨 [BALL RESPAWN REBOOT SYSTEM] 
    -- เมื่อไม่เจอบอลในสนาม (จังหวะบอลลูกเก่าตาย / บอลกำลังเกิดใหม่) 
    -- สั่งล้างสถานะล็อก คูลดาวน์ และคิวสแปมทุกประเภททิ้งทันที เพื่อบังคับให้เฟรมแรกของบอลลูกใหม่นับเป็น "ตีปกติ"
    shared.ManualSpamActive = false
    shared.LastSpamTime = 0
    if shared.Clicked_Target_Name then 
        shared.Clicked_Target_Name = nil 
    end
    
    -- ⚡ ล้างกระดานข้อมูลล็อกฟิสิกส์ เพื่อสกัดกั้นปัญหากดเบิ้ลหลายคลิกพร้อมกัน (Anti-Multi Click)
    if type(parryLocked) == "table" then table.clear(parryLocked) end
    if type(lockTime) == "table" then table.clear(lockTime) end
    if type(lastHitTicks) == "table" then table.clear(lastHitTicks) end
    
    -- สลับโหมดการคำนวณแพ็กเก็ตเน็ตเวิร์กกลับมาเป็นโหมดปกติ (isSpam = false)
    lastParryTime = 0
    
    return nil
end

function Auto_Parry.Get_Balls()
    local foundBalls = {}
    local mainFolder = workspace:FindFirstChild("Balls")
    local trainingFolder = workspace:FindFirstChild("TrainingBalls")
    
    if mainFolder then
        for _, b in ipairs(mainFolder:GetChildren()) do
            if b:IsA("BasePart") and (b:GetAttribute("realBall") or b:GetAttribute("target")) then
                b.CanCollide = false
                table.insert(foundBalls, b)
            end
        end
    end
    
    if trainingFolder then
        for _, b in ipairs(trainingFolder:GetChildren()) do
            if b:IsA("BasePart") and (b:GetAttribute("realBall") or b:GetAttribute("target")) then
                b.CanCollide = false
                table.insert(foundBalls, b)
            end
        end
    end
    
    return foundBalls
end

function Auto_Parry.GetTargetPlayer()
    local alive = workspace:FindFirstChild("Alive")
    local myChar = LocalPlayer.Character
    local cam = workspace.CurrentCamera

    if not alive or not myChar or not cam then return nil end

    -- 🔒 ตรวจสอบระบบล็อกดับเบิ้ลคลิกก่อน
    if Config.TargetMode == "Double click" and shared.Clicked_Target_Name then
        local target = alive:FindFirstChild(shared.Clicked_Target_Name)
        if target and target:IsA("Model") and target ~= myChar and target:FindFirstChild("HumanoidRootPart") then
            return target
        end
    end

    local viewport = cam.ViewportSize
    local screenCenter = Vector2.new(viewport.X * 0.5, viewport.Y * 0.5)
    local MAX_SCREEN_DISTANCE = math.min(viewport.X, viewport.Y) * 0.45

    local bestTarget = nil
    local bestScreenDistance = math.huge
    local fallbackTarget = nil
    local shortestWorldDist = math.huge

    for _, target in ipairs(alive:GetChildren()) do
        if target:IsA("Model") and target ~= myChar then
            local hrp = target:FindFirstChild("HumanoidRootPart")
            if hrp then
                local worldDist = (myChar.HumanoidRootPart.Position - hrp.Position).Magnitude
                local screenPos, onScreen = cam:WorldToViewportPoint(hrp.Position)

                if screenPos.Z > 0 then
                    local screenDistance = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                    if screenDistance <= MAX_SCREEN_DISTANCE and screenDistance < bestScreenDistance then
                        bestScreenDistance = screenDistance
                        bestTarget = target
                    end
                end

                -- [FIXED LOGIC]: เปลี่ยนระบบสุ่มเดาทาง เป็นหาผู้เล่นที่ยืนใกล้เราที่สุดในแมพแทนเพื่อความเสถียร
                if worldDist < shortestWorldDist then
                    shortestWorldDist = worldDist
                    fallbackTarget = target
                end
            end
        end
    end

    return bestTarget or fallbackTarget
end

local CachedParryTracks = {} 
local LastParryAnimTime = 0   

function Auto_Parry.Parry_Animation()
    if not Config.SwordAnimationsEnabled then return end

    local now = os.clock()
    if now - LastParryAnimTime < 0.12 then return end
    LastParryAnimTime = now

    pcall(function()
        local player = LocalPlayer or game.Players.LocalPlayer
        local char = player and player.Character
        if not char then return end

        local hum = char:FindFirstChildOfClass("Humanoid")
        local animator = hum and hum:FindFirstChildOfClass("Animator")
        if not animator then return end

        local currentSword = char:GetAttribute("CurrentlyEquippedSword") or "Default"
        local track = CachedParryTracks[currentSword]

        if not track or not track.Animation or not track.Parent then
            local parryAnimation = ReplicatedStorage.Shared.SwordAPI.Collection.Default:FindFirstChild("GrabParry")

            if currentSword ~= "Default" then
                local swordDataModule = ReplicatedStorage.Shared.ReplicatedInstances.Swords
                local swordInstances = require(swordDataModule)
                local swordInfo = swordInstances and swordInstances:GetSword(currentSword)
                
                if swordInfo and swordInfo["AnimationType"] then
                    local animFolder = ReplicatedStorage.Shared.SwordAPI.Collection:FindFirstChild(swordInfo["AnimationType"])
                    if animFolder then
                        parryAnimation = animFolder:FindFirstChild("GrabParry") or animFolder:FindFirstChild("Grab") or parryAnimation
                    end
                end
            end

            if parryAnimation then
                track = animator:LoadAnimation(parryAnimation)
                track.Priority = Enum.AnimationPriority.Action
                CachedParryTracks[currentSword] = track
            end
        end

        if track then
            track:Stop(0.02) 
            track:Play(0.05, 0.65, 1.35) 
        end
    end)
end

-- 🧼 รีเซ็ตคลังเก็บเมื่อตัวละครเกิดใหม่ (ป้องกันข้อมูลแอนิเมชันเก่ายังค้างคาบัก)
if LocalPlayer then
    LocalPlayer.CharacterAdded:Connect(function()
        table.clear(CachedParryTracks)
    end)
end

function Auto_Parry.CalculateParryCFrame(ball, targetPlayer)
    local cam = workspace.CurrentCamera
    if not targetPlayer or not targetPlayer.PrimaryPart or not cam then
        return targetPlayer and targetPlayer.PrimaryPart and targetPlayer.PrimaryPart.Position or Vector3.zero
    end
    
    local targetPos = targetPlayer.PrimaryPart.Position
    local targetHRP = targetPlayer.PrimaryPart
    local myChar = game.Players.LocalPlayer.Character
    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
    
    local parryCurveMode = Config.ParryCurveMode or "Camera"
    
    -- [🎯 MAX OVERDRIVE 90 DEGREE & REVERSE MODE]
    if parryCurveMode == "Camera" then
        -- ล็อกเป้าหมายตามแกนมุมมองกล้อง Client แท้จริง ยิงหลบเสี้ยวตัด
        return cam.CFrame.Position + (cam.CFrame.LookVector * 1000)
    elseif parryCurveMode == "Left" then
        -- หักเลี้ยวไปทางซ้ายของศัตรูแบบฉาก 90 องศา (จัดเต็มระยะ 500 สตัด เพื่อให้วิถีหักศอกชัดเจน)
        return targetPos + (targetHRP.CFrame.RightVector * -500)
    elseif parryCurveMode == "Right" then
        -- หักเลี้ยวไปทางขวาของศัตรูแบบฉาก 90 องศา
        return targetPos + (targetHRP.CFrame.RightVector * 500)
    elseif parryCurveMode == "Up" then
        -- งัดโด่งขึ้นฟ้าตรงๆ ข้ามหัวแนวบล็อก
        return targetPos + Vector3.new(0, 1000, 0)
    elseif parryCurveMode == "Down" then
        -- [🔥 REVERSE TO MY BACK OVERDRIVE]
        -- บอลจะพุ่งสวนศัตรูฉีกกลับไปที่ "ด้านหลังของตัวเราเอง" ทันที จัดเต็มระยะ 800 สตัด
        if myHRP and targetPlayer.PrimaryPart then
            local directionToEnemy = (targetPlayer.PrimaryPart.Position - myHRP.Position).Unit
            -- ใช้ทิศทางตรงกันข้ามกับศัตรู (ติดลบ) แล้วยิงพิกัดออกจากตำแหน่งตัวเราไปข้างหลัง
            return myHRP.Position + (-directionToEnemy * 800)
        else
            -- Fallback กรณีไม่เจอตัวละครเรา ให้พุ่งสวนแนวหน้ากล้องกลับไปข้างหลัง
            return cam.CFrame.Position + (cam.CFrame.LookVector * -800)
        end
    elseif parryCurveMode == "Random" then
        local randomAngle = math.rad(math.random(0, 360))
        local randomX = math.cos(randomAngle) * math.random(350, 700)
        local randomZ = math.sin(randomAngle) * math.random(350, 700)
        local randomY = math.random(-400, 500)
        
        return targetPos + Vector3.new(randomX, randomY, randomZ)
    elseif parryCurveMode == "Straight" then
        return targetPos
    
        -- =======================================================================
    -- 🌪️ [NEW MODE OVERDRIVE]: SUPER CURVE RANDOM (AUTO-RANDOMIZED ON EACH CALL)
    -- =======================================================================
    elseif parryCurveMode == "Super Curve Random" then
        -- 🎲 ตัวจำลองเกตดักจับเฟรมตี (ป้องกันการสุ่มซ้ำซ้อนในมิลลิวินาทีเดียวกัน)
        _G.LastCurveHitTick = _G.LastCurveHitTick or 0
        _G.CurrentSuperCurveDirection = _G.CurrentSuperCurveDirection or "Left"

        -- 🎰 ถ้าจดจำเวลาของเฟรมปัจจุบันต่างจากเฟรมล่าสุด แปลว่าฟังก์ชันถูก "เรียกใช้งานใหม่" (สั่งตีบอลรอบใหม่)
        local currentTick = os.clock()
        if currentTick ~= _G.LastCurveHitTick then
            _G.LastCurveHitTick = currentTick
            
            -- บังคับสั่งสุ่มทิศทางใหม่ทันที 4 ด้านหลักตามที่คุณต้องการ
            local directions = {"Left", "Right", "Up", "Down"}
            _G.CurrentSuperCurveDirection = directions[math.random(1, #directions)]
        end

        -- 📐 ประมวลผลพิกัดหักมุมฉากตามทิศทางที่ถูกสุ่มขึ้นล่าสุด ณ เฟรมที่กดตีบอล
        if _G.CurrentSuperCurveDirection == "Left" then
            return targetPos + (targetHRP.CFrame.RightVector * -600)
        elseif _G.CurrentSuperCurveDirection == "Right" then
            return targetPos + (targetHRP.CFrame.RightVector * 600)
        elseif _G.CurrentSuperCurveDirection == "Up" then
            return targetPos + Vector3.new(0, 800, 0)
        elseif _G.CurrentSuperCurveDirection == "Down" then
            -- โหมดดิ่งพื้น/Reverse บังคับมุมยิงฉีกไปด้านหลังตัวเราเพื่อสร้างวิถีลูกเลี้ยวหักศอก
            if myHRP then
                local directionToEnemy = (targetPlayer.PrimaryPart.Position - myHRP.Position).Unit
                return myHRP.Position + (-directionToEnemy * 700)
            else
                return cam.CFrame.Position + (cam.CFrame.LookVector * -700)
            end
        end
    end
    -- =======================================================================
   
    
    return targetPos
end

Auto_Parry.CalculateParryCframe = Auto_Parry.CalculateParryCFrame

-- =======================================================================
-- 🔍 PART 1: GLOBAL SCOPE DECLARATION (FIXED SYNTAX 1156)
-- =======================================================================
isPCUser = not game:GetService("UserInputService").TouchEnabled
hasNotifiedBypassFail = false

-- ประกาศตัวแปรรับระนาบส่งข้อมูลด้านล่างเป็นแบบเคลียร์ค่ารอไว้ล่วงหน้า
isBypassSupported = false
_tokenize = nil
_reverted = {}
_original = {}
_captured = nil

pcall(function()
    if getgc and debug.getupvalues and (getrawmetatable or debug.getrawmetatable) then
        isBypassSupported = true
    end
end)

-- 🛡️ [SMART IF-SUPPORT RE-ARRANGED]: จัดบล็อกให้สมบูรณ์ไม่มีคำสั่งพิมพ์ค้าง
if not isBypassSupported then
    print("[Invis Network]: Executor not supported for Bypass. Fallback active.")
else
    print("[Invis Network]: Executor Capability Verified. Running Interceptor.")

    local replicated_storage = cloneref(game:GetService('ReplicatedStorage'))
    local workspace = cloneref(game:GetService('Workspace'))

    local _token = nil
    for _, Function in getgc(true) do
        if type(Function) ~= 'function' or not debug.info(Function, 's'):find('PRY', 1, true) then
            continue
        end

        for _, value in debug.getupvalues(Function) do
            if type(value) == 'function' then
                print('Found PRY Token inside GC.')
                _token = value
                break
            end
        end
        if _token then break end
    end

    if _token then
        _tokenize = function(_remote_uid)
            local time = tostring(math.floor(workspace:GetServerTimeNow() * 100))
            local key = _token(_remote_uid, 'TIME')
            local characters = table.create(#time)

            for index = 1, #time do
                characters[index] = string.char(bit32.bxor(
                    (string.byte(time, index ) + index) % 256,
                    string.byte(key, (index - 1) % #key + 1)
                ))
            end
            return table.concat(characters)
        end
    end

    local function _is_valid(args)
        if type(args) ~= "table" then return false end
        return type(args[2]) == "string" and type(args[4]) == "number" and typeof(args[5]) == "CFrame"
    end

    local function _hook(remote)
        if not _reverted[remote] then
            if not _original[getrawmetatable(remote)] then
                _original[getrawmetatable(remote)] = true
                local _meta = getrawmetatable(remote)
                setreadonly(_meta, false)

                local _old = _meta.__index
                _meta.__index = function(self, key)
                    if (key == 'FireServer' and self:IsA('RemoteEvent')) or
                       (key == 'InvokeServer' and self:IsA('RemoteFunction')) then
                        return function(_, ...)
                            local _arguments = {...}
                            if _is_valid(_arguments) then
                                if not _reverted[self] then
                                    _reverted[self] = _arguments
                                    _captured = {
                                        remote = self,
                                        args = _arguments
                                    }
                                end
                            end
                            return _old(self, key)(_, unpack(_arguments))
                        end
                    end
                    return _old(self, key)
                end
                setreadonly(_meta, true)
            end
        end
    end

    for _, _remote in pairs(replicated_storage:GetDescendants()) do
        if _remote:IsA('RemoteEvent') or _remote:IsA('RemoteFunction') then
            _hook(_remote)
        end
    end
end

-- ===== SAFE INPUT FOR PC BYPASS FALLBACK =====
function fireParryInput()
	if mouse1press and mouse1release then
		pcall(function()
			mouse1press()
			task.wait(0.03)
			mouse1release()
		end)
		return true
	end
	if mouse1click then
		pcall(function() mouse1click() end)
		return true
	end
	return false
end

Config.ParryMethodMode = "bypass"

-- 🔒 บังคับล็อกสถานะหากตัวรันมีประสิทธิภาพไม่ถึงเกณฑ์ขั้นต่ำ
if not isBypassSupported then
    Config.ParryMethodMode = "click"
end

-- 🚀 [FIXED NETWORK PIPELINE]: เวอร์ชั่นอัปเดตระยะ 37 Studs พร้อมระบบเปิด/ปิด Clash target
function Auto_Parry.FireParryRemote(isSpam)
    if type(Auto_Parry.Parry_Animation) == "function" then
        pcall(Auto_Parry.Parry_Animation)
    end

    local mustUseMouseClick = false

    if Config.ParryMethodMode == "click" then
        mustUseMouseClick = true
    elseif (not _reverted or next(_reverted) == nil) then
        mustUseMouseClick = true
        if not hasNotifiedBypassFail then
            hasNotifiedBypassFail = true
            if type(CustomNotify) == "function" then
                CustomNotify("⚠️ Network Bypass not ready yet! Using Mouse/Touch Click instead.", 4)
            end
        end
    end

    if mustUseMouseClick then
        fireParryInput()
        return 
    end
    
    local ball = Auto_Parry.Get_Ball()
    local cam = workspace.CurrentCamera
    if not cam then return end

    local finalCamCFrame = cam.CFrame
    local activeTargetPlayer = Auto_Parry.GetTargetPlayer()
    
    local character = game.Players.LocalPlayer.Character
    local myHrp = character and character:FindFirstChild("HumanoidRootPart")
    local isTargetTooClose = false
    
    if Config.ClashTarget and myHrp and activeTargetPlayer and activeTargetPlayer:FindFirstChild("HumanoidRootPart") then
        local distanceToTarget = (myHrp.Position - activeTargetPlayer.HumanoidRootPart.Position).Magnitude
        if distanceToTarget <= 37 then
            isTargetTooClose = true
        end
    end

    -- [⚡ FIXED CAMERA INTERCEPTOR]: บังคับอัปเดตมุมมองหลอกเซิร์ฟเวอร์ทุกสเตท เพื่อให้วิถี Curve ทำงาน 100%
    if activeTargetPlayer and activeTargetPlayer.Name ~= game.Players.LocalPlayer.Name and not isTargetTooClose then
        local calculatedCFrameData = Auto_Parry.CalculateParryCFrame(ball, activeTargetPlayer)
        if calculatedCFrameData then
            local finalPositionVector3 = Vector3.zero
            if typeof(calculatedCFrameData) == "CFrame" then
                finalPositionVector3 = calculatedCFrameData.Position
            elseif typeof(calculatedCFrameData) == "Vector3" then
                finalPositionVector3 = calculatedCFrameData
            end
            -- ล็อกตำแหน่งกล้อง Client ไปหาพิกัดเวกเตอร์เลี้ยวใหม่โดยตรง
            finalCamCFrame = CFrame.lookAt(cam.CFrame.Position, finalPositionVector3)
        end
    end

    local gamePositionsSnapshot = {}
    local aliveFolder = workspace:FindFirstChild("Alive")
    local deadFolder = workspace:FindFirstChild("Dead")
    local isLobbyTraining = game.Players.LocalPlayer:GetAttribute("LobbyTraining") or false

    if isLobbyTraining and deadFolder then
        for _, deadModel in ipairs(deadFolder:GetChildren()) do
            local plrs = game.Players:GetPlayerFromCharacter(deadModel)
            if plrs and plrs:GetAttribute("LobbyTraining") and deadModel:FindFirstChild("HumanoidRootPart") then
                local screenPos, onScreen = cam:WorldToScreenPoint(deadModel.HumanoidRootPart.Position)
                gamePositionsSnapshot[deadModel.Name] = screenPos
            end
        end
        local CollectionService = game:GetService("CollectionService")
        for _, trainingTarget in ipairs(CollectionService:GetTagged("LobbyTrainingTarget")) do
            if trainingTarget:IsA("BasePart") then
                local screenPos, onScreen = cam:WorldToScreenPoint(trainingTarget.Position)
                gamePositionsSnapshot[trainingTarget.Name] = screenPos
            end
        end
    else
        if aliveFolder then
            for _, aliveChar in ipairs(aliveFolder:GetChildren()) do
                if aliveChar:IsA("Model") and aliveChar:FindFirstChild("HumanoidRootPart") then
                    -- คำนวณพิกัดตำแหน่งหน้าจออัปเดตให้สัมพันธ์กับค่า CFrame หลอก เพื่อไม่ให้วิถีสะบัดเบี้ยว
                    local screenPos, onScreen = cam:WorldToScreenPoint(aliveChar.HumanoidRootPart.Position)
                    gamePositionsSnapshot[aliveChar.Name] = screenPos
                end
            end
        end
    end

    for _remote, _originalArgs in pairs(_reverted) do
        if type(_originalArgs) == "table" and _originalArgs ~= nil then
            task.spawn(function()
                local finalCoordinates = {cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2}

                if Config.UseMouseLocation then
                    local mousePos = UserInputService:GetMouseLocation()
                    finalCoordinates = {mousePos.X, mousePos.Y}
                end

                pcall(function()
                    if _remote:IsA("RemoteEvent") then
                        _remote:FireServer(
                            _originalArgs[1],            
                            _originalArgs[2],            
                            _tokenize(_originalArgs[2]), 
                            isSpam and 0 or 0.5,     
                            finalCamCFrame,   -- ส่ง CFrame โค้งหักศอกชุดใหม่           
                            gamePositionsSnapshot,       
                            finalCoordinates,            
                            false                        
                        )
                    end
                end)
            end)
        end
    end
end

function Auto_Parry.Is_Curved(ball)
    local success, isCurved = pcall(function()
        if not ball or not ball:IsA("BasePart") then return false end
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return false end

        local hrp = char.HumanoidRootPart
        local ballVel = ball.AssemblyLinearVelocity
        if ballVel.Magnitude < 1 then return false end

        local dirToPlayer = (hrp.Position - ball.Position).Unit
        local ballDir = ballVel.Unit
        local dot = ballDir:Dot(dirToPlayer)

        -- ขยายช่วง Dot Product เพื่อดักมุมเลี้ยวโค้งด้านข้างที่กว้างขึ้น
return (dotProduct < 0.84 and dotProduct > -0.81)
    end)

    return success and isCurved or false
end

function Auto_Parry.IsTargetingMe(ball)
    if not ball then return false end
    
    -- ดึงค่า Target จาก Attribute ของลูกบอล
    local targetName = tostring(ball:GetAttribute("target") or ball:GetAttribute("Target") or "")
    local localName = LocalPlayer.Name
    
    if targetName == localName then 
        return true 
    end
    if LocalPlayer.Character and targetName == LocalPlayer.Character.Name then 
        return true 
    end
    
    return false
end


-- ═══ SKIN CHANGER BACKEND SYSTEM ═══════════════
getgenv().skinChanger = false
getgenv().swordModel = ""
getgenv().swordAnimations = ""
getgenv().swordFX = ""

task.spawn(function()
    local rs = ReplicatedStorage
    local swordInstancesInstance = rs:WaitForChild("Shared", 9e9):WaitForChild("ReplicatedInstances", 9e9):WaitForChild("Swords", 9e9)
    local swordInstances = require(swordInstancesInstance)

    local swordsController
    task.spawn(function()
        while task.wait() and not swordsController do
            local ok, conns = pcall(getconnections, rs.Remotes.FireSwordInfo.OnClientEvent)
            if ok and conns then
                for _, v in ipairs(conns) do
                    if v.Function and islclosure and islclosure(v.Function) then
                        local ok2, up = pcall(getupvalues, v.Function)
                        if ok2 and #up == 1 and type(up[1]) == "table" then
                            swordsController = up[1]
                            break
                        end
                    end
                end
            end
        end
    end)

    local function getSlashName(swordName)
        local ok, sln = pcall(function() return swordInstances:GetSword(swordName) end)
        return (ok and sln and sln.SlashName) or "SlashEffect"
    end

    local function refreshSlashName()
        local fxName = getgenv().swordFX ~= "" and getgenv().swordFX or getgenv().swordModel
        if fxName ~= "" then getgenv().slashName = getSlashName(fxName) else getgenv().slashName = "SlashEffect" end
    end

    local function setSword()
        if not getgenv().skinChanger then return end
        if not LocalPlayer.Character then return end
        pcall(function()
            local f = rawget(swordInstances, "EquipSwordTo")
            if type(f) == "function" then
                local ups = getupvalues(f)
                for i = 1, #ups do if type(ups[i]) == "boolean" then setupvalue(f, i, false) break end end
            end
        end)
        pcall(function() swordInstances:EquipSwordTo(LocalPlayer.Character, getgenv().swordModel) end)
        task.spawn(function()
            local attempts = 0
            while not swordsController and attempts < 20 do task.wait(0.5); attempts = attempts + 1 end
            if not swordsController then return end
            pcall(function()
                if swordsController.SetSword then
                    swordsController:SetSword(getgenv().swordAnimations ~= "" and getgenv().swordAnimations or getgenv().swordModel)
                end
            end)
            pcall(function()
                local targetSword = getgenv().swordFX ~= "" and getgenv().swordFX or getgenv().swordModel
                if rs.Remotes:FindFirstChild("FireSwordInfo") then rs.Remotes.FireSwordInfo:FireServer(targetSword) end
                if swordsController.currentSword ~= nil then swordsController.currentSword = targetSword end
                if swordsController.SwordFX ~= nil then swordsController.SwordFX = targetSword end
            end)
        end)
    end

    -- Hook ParrySuccessAll for FX Override
    local hookedFuncs = {}
    task.spawn(function()
        while task.wait(1) do
            local ok, conns = pcall(getconnections, rs.Remotes.ParrySuccessAll.OnClientEvent)
            if ok and type(conns) == "table" then
                for _, v in ipairs(conns) do
                    local func = v.Function
                    if func and not hookedFuncs[func] then
                        if isourclosure and isourclosure(func) then 
                            hookedFuncs[func] = true
                        else
                            hookedFuncs[func] = true
                            v:Disable()
                            local targetFunc = func
                            local ourFunc
                            ourFunc = function(...)
                                local args = { ... }
                                if tostring(args[4]) == LocalPlayer.Name and getgenv().skinChanger then
                                    local fxSword = getgenv().swordFX ~= "" and getgenv().swordFX or getgenv().swordModel
                                    refreshSlashName()
                                    args[1] = getgenv().slashName
                                    args[3] = fxSword
                                end
                                if setthreadidentity then pcall(setthreadidentity, 2) end
                                pcall(targetFunc, unpack(args))
                            end
                            hookedFuncs[ourFunc] = true
                            rs.Remotes.ParrySuccessAll.OnClientEvent:Connect(ourFunc)
                        end
                    end
                end
            end
        end
    end)

    getgenv().updateSword = function() refreshSlashName(); setSword() end

    -- Persistent Sync Loop
    task.spawn(function()
        while task.wait(1) do
            if getgenv().skinChanger and getgenv().swordModel ~= "" then
                local char = LocalPlayer.Character
                if char then
                    if LocalPlayer:GetAttribute("CurrentlyEquippedSword") ~= getgenv().swordModel then setSword() end
                    if not char:FindFirstChild(getgenv().swordModel) then setSword() end
                    for _, v in char:GetChildren() do
                        if v:IsA("Model") and v.Name ~= getgenv().swordModel then v:Destroy() end
                        task.wait()
                    end
                end
            end
        end
    end)

    LocalPlayer.CharacterAdded:Connect(function()
        if getgenv().skinChanger then
            getgenv().skinChanger = false; task.wait(1.5)
            getgenv().skinChanger = true; task.wait(0.5)
            pcall(function() getgenv().updateSword() end)
        end
    end)
end)

-- ═══ DOUBLE CLICK TARGETING ENGINE (FIXED SCREEN CACHE) ═══
shared.Clicked_Target_Name = nil
local lastClickTime = 0

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local now = tick()
        if now - lastClickTime < 0.35 then
            local mouse = LocalPlayer:GetMouse()
            local target = mouse.Target
            if target and target:IsA("BasePart") then
                local model = target:FindFirstAncestorOfClass("Model")
                local alive = workspace:FindFirstChild("Alive")
                if model and alive and model:IsDescendantOf(alive) and model ~= LocalPlayer.Character then
                    shared.Clicked_Target_Name = model.Name
                    
                end
            end
        else
            -- ดับเบิ้ลคลิกพื้นที่ว่างเพื่อเคลียร์การล็อกเป้าหมาย
            if shared.Clicked_Target_Name and now - lastClickTime >= 1.5 then
                shared.Clicked_Target_Name = nil
                
            end
        end
        lastClickTime = now
    end
end)

-- ฟังก์ชันสร้าง Cache ตำแหน่งหน้าจอส่งให้ตัวเกม (รองรับล็อกเป้า/Nearest/Farest)
local function BuildDynamicPositionsCache()
    local positionsCache = {}
    local alive = workspace:FindFirstChild("Alive")
    local cam = workspace.CurrentCamera
    if not alive or not cam then return positionsCache end

    -- ตรวจสอบการล็อกเป้าหมายจากการดับเบิ้ลคลิก (Double Click Locked Target)
    if shared.Clicked_Target_Name then
        local tar = alive:FindFirstChild(shared.Clicked_Target_Name)
        if tar and tar:FindFirstChild("HumanoidRootPart") then
            positionsCache[shared.Clicked_Target_Name] = cam:WorldToScreenPoint(tar.HumanoidRootPart.Position)
            return positionsCache
        else
            shared.Clicked_Target_Name = nil -- ปลดล็อกอัตโนมัติหากเป้าหมายตายหรือหลุดจาก Alive
        end
    end

    -- โหมดการค้นหาเป้าหมายอัตโนมัติตามเมนู (Nearest / Farest / Normal)
    local targetPlayer = Auto_Parry.GetTargetPlayer()
    if targetPlayer and targetPlayer:FindFirstChild("HumanoidRootPart") then
        positionsCache[targetPlayer.Name] = cam:WorldToScreenPoint(targetPlayer.HumanoidRootPart.Position)
    end
    return positionsCache
end

-- ═══════════════════════════════════════════════════════════════════════════
-- ═══ ULTIMATE CORE PHYSICS LOOP (PERFECT ANTI-DOUBLE HANDLER - PART 1/3) ══
-- ═══════════════════════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StatsService = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

-- 📦 State Tables & Memory Buffers
local parryLocked = parryLocked or {}
local lockTime = lockTime or {}
local lastHitTicks = lastHitTicks or {}
local lastParryTime = lastParryTime or 0
_clashStartTime = _clashStartTime or 0
shared.ManualSpamActive = shared.ManualSpamActive or false
local activeClashBall = nil
local clashPartner = ""
local velocityHistory = {} -- คลังจดจำวิถีความเร็วแบบ Real-timeต่อเฟรม

-- เอาไปวางไว้ด้านบนสุด ด้านใน shared._PhysicsBind ทันทีหลังจากประกาศ local parryLocked
shared.InvisClearLock = function(targetBall)
    if targetBall and parryLocked and lockTime then
        parryLocked[targetBall] = false
        lockTime[targetBall] = 0
    end
end

-- 📡 1. PING LISTENER FOR DYNAMIC TIMING COMPENSATION
local pingSeconds = 0.03
task.spawn(function()
    while true do
        pcall(function()
            if StatsService then
                local network = StatsService:FindFirstChild("Network")
                if network then
                    local serverStats = network:FindFirstChild("ServerStatsItem")
                    if serverStats then
                        local dataPing = serverStats:FindFirstChild("Data Ping")
                        if dataPing then
                            pingSeconds = math.clamp((dataPing:GetValue() or 30) / 1000, 0.01, 0.3)
                        end
                    end
                end
            end
        end)
        task.wait(0.5)
    end
end)

-- 📦 2. VELOCITY INTEGRATION FALLBACK
if type(_ZX_pushVelSample) ~= "function" then
    getgenv()._ZX_VelHistory = getgenv()._ZX_VelHistory or {}
    getgenv()._ZX_pushVelSample = function(key, pos, vel)
        _ZX_VelHistory[key] = _ZX_VelHistory[key] or {}
        table.insert(_ZX_VelHistory[key], 1, {pos = pos, vel = vel, time = os.clock()})
        if #_ZX_VelHistory[key] > 5 then
            table.remove(_ZX_VelHistory[key])
        end
    end
end

-- 🛡️ 3. EMERGENCY DEFENSE OVERWRITE
function SafeGetEmergencyDistance(speed)
    local calculated = 8 + (speed * 0.09) + (pingSeconds * speed * 1.5)
    -- กำหนดเพดานระยะฉุกเฉินสูงสุดที่ 25
    local infinityBuffer = math.clamp(calculated, 10, 50) 
    if type(GetEmergencyDistance) == "function" then
        local success, result = pcall(GetEmergencyDistance, speed)
        if success and type(result) == "number" then
            -- บังคับไม่ให้ค่าเกิน 25
            return math.min(math.max(result, math.clamp(8 + (speed * 0.09), 10, 45)), 40)
        end
    end
    return infinityBuffer
end

-- 🎯 4. STABLE OBJECT RESOLVER
local function SafeGetBalls()
    local balls = {}
    if type(Auto_Parry) == "table" then
        if type(Auto_Parry.Get_Balls) == "function" then
            local success, res = pcall(Auto_Parry.Get_Balls)
            if success then
                if type(res) == "table" then balls = res
                elseif res and typeof(res) == "Instance" then balls = {res} end
            end
        elseif type(Auto_Parry.Get_Ball) == "function" then
            local success, res = pcall(Auto_Parry.Get_Ball)
            if success then
                if type(res) == "table" then
                    balls = res
                elseif res and typeof(res) == "Instance" then
                    balls = {res}
                end
            end
        end
    end
    return balls
end

-- ⚡ 5. DISCONNECT PREVIOUS BINDS
if shared._PhysicsBind then shared._PhysicsBind:Disconnect() end
local singularityEndTime = 0
local lastAutoSpamTime = 0
-- =======================================================================
-- 🚀 HYBRID HARDCORE OVERDRIVE SPAM LOOP (REAL-TIME SPEED UPDATE)
-- =======================================================================
if shared._BBAChaoticThread then 
    task.cancel(shared._BBAChaoticThread) 
    shared._BBAChaoticThread = nil 
end

shared._BBAChaoticThread = task.spawn(function()
    while shared._InvisRunning do
        -- [DYNAMIC INTERPOLATION]: ต้องดึงค่าสปีดมาคำนวณล่วงหน้าตั้งแต่บรรทัดแรกของรอบลูปเลย
        local currentDelay = tonumber(Config.AutoSpamSpeed) or 0.005
        
        local cfg = (type(Config) == "table") and Config or {}
        local autoSpamEnabled = cfg.AutoSpam or cfg.AutoSpamClash or false
        
        if not autoSpamEnabled then
            shared.ManualSpamActive = false
            _clashStartTime = 0
        end

        -- ตรวจสอบเงื่อนไขปะทะ
        if autoSpamEnabled and shared.ManualSpamActive then
            if type(Auto_Parry) == "table" and type(Auto_Parry.FireParryRemote) == "function" then
                pcall(Auto_Parry.FireParryRemote, true)
                pcall(Auto_Parry.FireParryRemote, true)
            end
        end
        
        -- หน่วงเวลาผันแปรตามดีเลย์หน้า GUI จริงแบบเสี้ยววินาที
        task.wait(currentDelay) 
    end
end)

local lastTornadoTracked = nil
local tornadoResumeTime = 0
_G.TornadoActive = false

local LockedSingularBall = nil 
local LastSingularState = false

local function IsMySingularityActive()
    local char = game.Players.LocalPlayer.Character
    if char and char.Parent == workspace.Alive then
        -- 🔮 เช็คค่า Attribute จากสคริปต์เซิร์ฟเวอร์เกม บอลจะถูกดูดเข้าหลุมดำเราโดยไม่กด Parry ตัดหน้า
        if char:GetAttribute("IS_EVENT_SINGULARITY") == true then
            return true
        end
    end
    return false
end

-- =======================================================================
-- 🛡️ INVIS HUB CORE BACKEND SYSTEM WITH ERYNDOR BALANCED ENGINE
-- =======================================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StatsService = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer

-- 📦 คลังเก็บสถานะ Memory Buffers ดั้งเดิมทั้งหมดของ Invis
parryLocked = parryLocked or {}
lockTime = lockTime or {}
lastHitTicks = lastHitTicks or {}
local lastParryTime = 0

-- ตัวแปรชดเชยค่าปิงเน็ตเวิร์ก
local pingSeconds = 0.03
task.spawn(function()
    while true do
        pcall(function()
            if StatsService then
                local network = StatsService:FindFirstChild("Network")
                if network then
                    local serverStats = network:FindFirstChild("ServerStatsItem")
                    if serverStats then
                        local dataPing = serverStats:FindFirstChild("Data Ping")
                        if dataPing then
                            pingSeconds = math.clamp((dataPing:GetValue() or 30) / 1000, 0.01, 0.3)
                        end
                    end
                end
            end
        end)
        task.wait(0.5)
    end
end)

-- ฟังก์ชันดึงวัตถุลูกบอลแท้ของ Invis
if type(Auto_Parry) ~= "table" then Auto_Parry = {} end

function Auto_Parry.Get_Ball()
    local bc = workspace:FindFirstChild("Balls") or workspace:FindFirstChild("TrainingBalls")
    if bc then
        for _, b in pairs(bc:GetChildren()) do
            if b:IsA("BasePart") and (b:GetAttribute("realBall") or b:GetAttribute("target")) then 
                return b 
            end
        end
    end
    shared.ManualSpamActive = false
    if type(parryLocked) == "table" then table.clear(parryLocked) end
    if type(lockTime) == "table" then table.clear(lockTime) end
    if type(lastHitTicks) == "table" then table.clear(lastHitTicks) end
    lastParryTime = 0
    return nil
end

function Auto_Parry.Get_Balls()
    local foundBalls = {}
    local mainFolder = workspace:FindFirstChild("Balls")
    local trainingFolder = workspace:FindFirstChild("TrainingBalls")
    if mainFolder then
        for _, b in ipairs(mainFolder:GetChildren()) do
            if b:IsA("BasePart") and (b:GetAttribute("realBall") or b:GetAttribute("target")) then
                table.insert(foundBalls, b)
            end
        end
    end
    if trainingFolder then
        for _, b in ipairs(trainingFolder:GetChildren()) do
            if b:IsA("BasePart") and (b:GetAttribute("realBall") or b:GetAttribute("target")) then
                table.insert(foundBalls, b)
            end
        end
    end
    return foundBalls
end

function Auto_Parry.GetTargetPlayer()
    local alive = workspace:FindFirstChild("Alive")
    local myChar = LocalPlayer.Character
    if not alive or not myChar then return nil end
    local shortestWorldDist = math.huge
    local fallbackTarget = nil
    for _, target in ipairs(alive:GetChildren()) do
        if target:IsA("Model") and target ~= myChar then
            local hrp = target:FindFirstChild("HumanoidRootPart")
            if hrp then
                local worldDist = (myChar.HumanoidRootPart.Position - hrp.Position).Magnitude
                if worldDist < shortestWorldDist then
                    shortestWorldDist = worldDist
                    fallbackTarget = target
                end
            end
        end
    end
    return fallbackTarget
end

LastSingularityActiveTime = 0
SingularityCooldownBuffer = 0.1 -- เพิ่มเวลาเผื่อดีเลย์ 0.1 วินาทีตามสั่ง


if shared._PhysicsParryBind then shared._PhysicsParryBind:Disconnect() end

shared._PhysicsParryBind = RunService.RenderStepped:Connect(function()
    if not shared._InvisRunning then return end

    character = LocalPlayer.Character
    if not character or not character.PrimaryPart then return end

    hrp = character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart
    if not hrp then return end

    balls = type(Auto_Parry.Get_Balls) == "function" and Auto_Parry.Get_Balls() or {}
    if #balls == 0 then return end

    playerPos = hrp.Position
    now = os.clock()
    
    cfg = (type(Config) == "table") and Config or {}
    autoParryEnabled = cfg.AutoParry or false
    soccerMode = cfg.SoccerMode or false
    distanceTiming = cfg.DistanceTiming or 100

    myTargetedBalls = {}
    for _, b in pairs(balls) do
        if b and b.Parent then
            tAttr = b:GetAttribute("target") or b:GetAttribute("Target")
            if tostring(tAttr or "") == LocalPlayer.Name then
                table.insert(myTargetedBalls, b)
            end
        end
    end

    multiBallBurstCount = 1
    if #myTargetedBalls >= 2 then
        for i = 1, #myTargetedBalls do
            ballA = myTargetedBalls[i]
            distToMe = (playerPos - ballA.Position).Magnitude
            if distToMe < 25 then
                closeGroupCount = 1
                for j = 1, #myTargetedBalls do
                    if i ~= j then
                        ballB = myTargetedBalls[j]
                        if (ballA.Position - ballB.Position).Magnitude < 8 then
                            closeGroupCount = closeGroupCount + 1
                        end
                    end
                end
                if closeGroupCount > multiBallBurstCount then multiBallBurstCount = closeGroupCount end
            end
        end
    end

    for idx, Ball in pairs(balls) do
        if Ball and Ball.Parent then
            ballPos = Ball.Position
            Distance = (playerPos - ballPos).Magnitude

            Velocity = Vector3.zero
            Zoomies = Ball:FindFirstChild("zoomies")
            
            if Zoomies then
                s, v = pcall(function() return Zoomies.VectorVelocity end)
                if s and v then Velocity = v end
            end
            if Velocity == Vector3.zero and Ball:IsA("BasePart") then
                Velocity = Ball.AssemblyLinearVelocity
            end

            Speed = Velocity.Magnitude
            ballDirection = Speed > 1 and Velocity.Unit or Vector3.new(0, -1, 0)
            toPlayerDirection = Distance > 0.1 and (playerPos - ballPos).Unit or Vector3.zero
            dotProduct = ballDirection:Dot(toPlayerDirection)

            targetAttr = Ball:GetAttribute("target") or Ball:GetAttribute("Target")
            ballTargetStr = tostring(targetAttr or "")
            isTargetingMe = (ballTargetStr == LocalPlayer.Name or ballTargetStr == tostring(LocalPlayer))

            if soccerMode then
                isTargetingMe = (dotProduct > -0.15 or Distance <= 16)
            end

            if isTargetingMe then
                if not BallFirstTargetDistanceMap then BallFirstTargetDistanceMap = {} end
                if not WasTargetingMeLastFrame then WasTargetingMeLastFrame = {} end

                if not WasTargetingMeLastFrame[Ball] then
                    BallFirstTargetDistanceMap[Ball] = Distance
                    WasTargetingMeLastFrame[Ball] = true
                end
            else
                if not BallFirstTargetDistanceMap then BallFirstTargetDistanceMap = {} end
                if not WasTargetingMeLastFrame then WasTargetingMeLastFrame = {} end
                
                BallFirstTargetDistanceMap[Ball] = nil
                WasTargetingMeLastFrame[Ball] = nil
                
                lastHitTicks[Ball] = 0
                parryLocked[Ball] = false
                lockTime[Ball] = 0
            end

            if not parryLocked[Ball] then
                allowedToHit = isTargetingMe
                triggerParry = false

                if autoParryEnabled and allowedToHit then
                    ping_ms = pingSeconds * 1000
                    ping_threshold = math.clamp(ping_ms / 100, 5, 17)
                    
                    base_multiplier = 1.04
                    if cfg.huh and tonumber(cfg.huh) then 
                        base_multiplier = tonumber(cfg.huh) 
                    end
                    
                    cappedSpeedDiff = math.min(math.max(Speed - 9.5, 0), 2500)
                    speed_divisor_base = 2.4 + cappedSpeedDiff * 0.002
                    speed_divisor = speed_divisor_base * base_multiplier
                    
                    parry_accuracy = ping_threshold + math.max(Speed / speed_divisor, 9.5)
                    userScale = distanceTiming / 100
                    
                    isBallCurvingReal = false
                    lateralVelocity = Velocity - (Velocity:Dot(toPlayerDirection) * toPlayerDirection)
                    
                    if (lateralVelocity.Magnitude / math.max(Speed, 1) > 0.15) or (dotProduct < 0.84 and dotProduct > -0.78) or (math.abs(ballDirection.Y) > 0.22) then
                        isBallCurvingReal = true
                    end

                    distanceA = BallFirstTargetDistanceMap[Ball] or Distance

                    if Speed >= 750 then
                        extreme_kill_zone = (parry_accuracy * userScale) * 1.35
                        if (Distance <= extreme_kill_zone or (Distance / math.max(Speed, 1)) <= 0.06) and (dotProduct > 0.35 or Distance <= 25) then
                            triggerParry = true
                        end
                    elseif cfg.ParryMode == "Curve" and isBallCurvingReal then
                        maxCurveDist = Speed > 600 and 130 or 95
                        pingBuffer = (pingSeconds * Speed * 1.1)
                        
                        baseStrikeZone = (5.5 + (Speed * (cfg.wowcurve or 0.33))) - (lateralVelocity.Magnitude * 0.22) + pingBuffer
                        strikeZone = math.clamp(baseStrikeZone, 14, maxCurveDist) * userScale
                        
                        if Distance <= strikeZone or (Distance / math.max(Speed, 1)) <= 0.045 then
                            if (dotProduct > -0.1 or Distance <= 18) then
                                triggerParry = true
                            end
                        end
                    else
                        final_kill_zone = parry_accuracy * userScale
                        if Distance <= final_kill_zone or Distance <= 14 or (Distance / math.max(Speed, 1)) <= 0.045 then
                            if dotProduct > -0.35 or Distance <= 15 then
                                triggerParry = true
                            end
                        end
                    end
                    
                    if Distance <= 9.5 then
                        triggerParry = true
                    end
                end

                if not (cfg.SpecialSkillDetections and Ball:FindFirstChild('ComboCounter')) then
                    if not (Det_State and Det_State.Infinity_Active and Det_State.Infinity_Enabled) then
                        if not (Det_State and Det_State.DeathSlash_Active and Det_State.DeathSlash_Enabled) then
                            
                            isSingularActiveNow = (character and character:GetAttribute("IS_EVENT_SINGULARITY") == true)
                            nowTime = os.clock()
                            
                            if isSingularActiveNow then
                                LastSingularityActiveTime = nowTime
                            end
                            
                            isInsideSingularityWindow = isSingularActiveNow or (nowTime - (LastSingularityActiveTime or 0) <= 0.1)
                            
                            if isInsideSingularityWindow then
                                isAttachedToMe = (Distance <= 12 and Speed <= 8)
                                if isAttachedToMe then
                                    shared.ManualSpamActive = false
                                    triggerParry = false
                                end
                            end                 
                                                
                            if triggerParry then
                                if not ZX_Parry then ZX_Parry = { KeyTable = "Ball" } end
                                bTarget = Ball:GetAttribute("target") or Ball:GetAttribute("Target")
                                if bTarget then
                                    ZX_Parry.KeyTable = Ball:GetAttribute("realBall") or Ball.Name or bTarget
                                end

                                if (now - lastParryTime) >= 0.003 then 
                                    if type(Auto_Parry.FireParryRemote) == "function" then
                                        speedBurst = (Speed > 1800) and 3 or 1
                                        finalBurstCount = math.max(speedBurst, multiBallBurstCount)
                                        for i = 1, finalBurstCount do
                                            pcall(Auto_Parry.FireParryRemote, false)
                                        end
                                    end

                                    if cfg.AnimationFix and PF then
                                        pcall(PF)
                                    end
                                    lastParryTime = now
                                end
                                lastHitTicks[Ball] = now
                                parryLocked[Ball] = true
                                lockTime[Ball] = now
                            end

                        end
                    end
end
end
end
end
end)

getgenv()._InvisCurveTimers = getgenv()._InvisCurveTimers or {}
local _InvisCurveTimers = getgenv()._InvisCurveTimers

-- =======================================================================
-- ⚔️ CUSTOM TARGET-RALLY PREDICTOR & AUTO SPAM ENGINE (FIXED PIPELINE)
-- =======================================================================
if shared._CustomSpamBind then shared._CustomSpamBind:Disconnect() end

-- 📦 คลังเก็บสถานะย้อนหลัง (State Memory)
local targetHistory = {}      -- เก็บชื่อ Target 2 คนล่าสุด
local lastCheckedTarget = ""  -- บันทึก Target ล่าสุดเพื่อดักจับจังหวะเปลี่ยนคน
local rallyMatchCount = 0     -- ตัวนับรอบการสลับบอล (เขา > เรา > เขา)

-- ฟังก์ชันล้างสถานะทั้งหมดเมื่อเงื่อนไขหลุด (Reset State)
local function ResetSpamState()
    table.clear(targetHistory)
    rallyMatchCount = 0
    lastCheckedTarget = ""
    shared.ManualSpamActive = false
end

shared._CustomSpamBind = game:GetService("RunService").PreSimulation:Connect(function()
    if not shared._InvisRunning then return end

    -- 1. ตรวจสอบความพร้อมของตัวละครเรา
    local character = game.Players.LocalPlayer.Character
    local myHrp = character and (character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart)
    local myHum = character and character:FindFirstChildOfClass("Humanoid")
    if not myHrp or not myHum or myHum.Health <= 0 then 
        ResetSpamState()
        return 
    end

    -- ตรวจสอบสวิตช์เปิด/ปิด AutoSpam จาก Config หลัก
    local cfg = (type(Config) == "table") and Config or {}
    if not (cfg.AutoSpam or false) then 
        ResetSpamState()
        return 
    end

    -- 2. ดึงข้อมูลลูกบอลและความเร็วปัจจุบัน
    local ball = type(Auto_Parry) == "table" and type(Auto_Parry.Get_Ball) == "function" and Auto_Parry.Get_Ball()
    if not ball or not ball.Parent then 
        ResetSpamState()
        return 
    end

    local zoomies = ball:FindFirstChild("zoomies")
    local velocity = zoomies and zoomies.VectorVelocity or ball.AssemblyLinearVelocity
    local ballSpeed = velocity.Magnitude
    if ballSpeed == 0 then return end

    -- 3. ค้นหา "เขา" (ผู้เล่นที่ใกล้เราที่สุดตามฟังก์ชันของระบบ)
    local targetPlr = type(Auto_Parry) == "table" and type(Auto_Parry.GetTargetPlayer) == "function" and Auto_Parry.GetTargetPlayer()
    if not targetPlr or not targetPlr:FindFirstChild("HumanoidRootPart") then 
        ResetSpamState()
        return 
    end

    -- 📐 [สูตรคำนวณเงื่อนไขที่ 2]: ระยะห่างของ "เขา" (เริ่มต้น 33 Studs + (ความเร็วบอล / 2)) ล็อกเพดานสูงสุดที่ 60
    local dynamicMaxDistance = math.clamp(10 + (ballSpeed * 0.3), 15, 60)
    local distanceToEnemy = (myHrp.Position - targetPlr.HumanoidRootPart.Position).Magnitude

    -- ตรวจสอบว่า "เขา" ยืนอยู่ในระยะสูตรหรือไม่ ถ้าหลุดระยะ -> ล้างค่าทันที
    if distanceToEnemy > dynamicMaxDistance then
        ResetSpamState()
        return
    end

    -- 🎯 [ตรรกะเงื่อนไขที่ 1 & 3]: ตรวจจับและบันทึกประวัติ Target 2 คนล่าสุดแบบเรียลไทม์
    local currentBallTarget = tostring(ball:GetAttribute("target") or ball:GetAttribute("Target") or "")
    local myName = game.Players.LocalPlayer.Name
    local enemyName = targetPlr.Name

    -- [CRITICAL FIX]: บังคับอัปเดตสเตจข้อมูลลงสารบบคลังประวัติตลอดเวลาเพื่อป้องกันขนาดอาเรย์หล่นไปต่ำกว่า 2
    if currentBallTarget ~= "" then
        if currentBallTarget ~= lastCheckedTarget then
            table.insert(targetHistory, 1, currentBallTarget)
            if #targetHistory > 2 then
                table.remove(targetHistory, 3)
            end
            
            -- คัดกรองและประมวลผลจังหวะจับคู่รับส่งลูกบอล
            if #targetHistory == 2 then
                local isPatternMatch = false
                if (targetHistory[1] == myName and targetHistory[2] == enemyName) or 
                   (targetHistory[1] == enemyName and targetHistory[2] == myName) then
                    isPatternMatch = true
                end

                if isPatternMatch then
                    rallyMatchCount = rallyMatchCount + 1
                else
                    ResetSpamState()
                    return
                end
            end
            lastCheckedTarget = currentBallTarget
        end
    end

    -- 🔥 [สั่งการทำงาน]: เมื่อผ่านเงื่อนไขแพทเทิร์น เขา > เรา > เขา ครบเกณฑ์แล้ว ให้ระเบิดแพ็กเก็ตสแปมความเร็วสูงได้ทันที
    if rallyMatchCount >= 2 or (currentBallTarget == myName and lastCheckedTarget == enemyName and #targetHistory >= 1) then
        if currentBallTarget == myName or currentBallTarget == enemyName then
            shared.ManualSpamActive = true

            if type(Auto_Parry) == "table" and type(Auto_Parry.FireParryRemote) == "function" then
                if getgenv().AutoSpamMode == "Keypress" and PF then
                    pcall(PF)
                else
                    -- บังคับเคลียร์ช่องส่งแพ็กเก็ตสัญญาณผ่านเลเยอร์จำลองของระบบหลักแบบไม่มีตัวหน่วง
                    pcall(Auto_Parry.FireParryRemote, true)
                    
                    if getgenv().AutoSpamAnimationFix and PF then
                        pcall(PF)
                    end
                end
            end
        else
            -- บอลหลุดคิวสะท้อนฉีกไปเล็งผู้เล่นคนอื่นนอกห้องดวล
            ResetSpamState()
        end
    else
        shared.ManualSpamActive = false
    end
end)
-- ═══ PLAYER ESP SYSTEM ═══
local ESP_Folder = Instance.new("Folder", workspace)
ESP_Folder.Name = "PlayerESP_Storage"

local function removeESP(player)
    if ESP_Folder:FindFirstChild(player.Name) then
        ESP_Folder[player.Name]:Destroy()
    end
end

local function createESP(player)
    if player == LocalPlayer then return end
    
    local function applyHighlight(character)
        if not character then return end
        removeESP(player)

        -- สร้าง Highlight (กรอบเรืองแสงทะลุกำแพง)
        local highlight = Instance.new("Highlight")
        highlight.Name = player.Name
        highlight.Adornee = character
        highlight.FillColor = Color3.fromRGB(255, 50, 50)
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.OutlineTransparency = 0
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = ESP_Folder

        -- สร้าง BillboardGui (แสดงชื่อและหลอดเลือดบนหัว)
        local head = character:WaitForChild("Head", 5)
        if head then
            local bb = Instance.new("BillboardGui")
            bb.Name = "ESP_Name"
            bb.Adornee = head
            bb.Size = UDim2.new(0, 100, 0, 40)
            bb.StudsOffset = Vector3.new(0, 2, 0)
            bb.AlwaysOnTop = true

            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = player.DisplayName or player.Name
            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLabel.TextStrokeTransparency = 0
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextSize = 13
            nameLabel.Parent = bb

            local hum = character:FindFirstChildOfClass("Humanoid")
            if hum then
                local hpLabel = Instance.new("TextLabel")
                hpLabel.Size = UDim2.new(1, 0, 0.5, 0)
                hpLabel.Position = UDim2.new(0, 0, 0.5, 0)
                hpLabel.BackgroundTransparency = 1
                hpLabel.Text = math.floor(hum.Health) .. " / " .. math.floor(hum.MaxHealth)
                hpLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
                hpLabel.TextStrokeTransparency = 0
                hpLabel.Font = Enum.Font.Gotham
                hpLabel.TextSize = 11
                hpLabel.Parent = bb

                -- อัปเดตเลือดตาม Real-time
                hum.HealthChanged:Connect(function(newHp)
                    hpLabel.Text = math.floor(newHp) .. " / " .. math.floor(hum.MaxHealth)
                end)
            end

            bb.Parent = highlight
        end
    end

    if player.Character then
        applyHighlight(player.Character)
    end
    player.CharacterAdded:Connect(applyHighlight)
end

-- ลูปอัปเดตการทำงานเมื่อเปิด/ปิด
task.spawn(function()
    while true do
        task.wait(0.5)
        if Config.PlayerESP then
            for _, player in ipairs(Players:GetPlayers()) do
                if not ESP_Folder:FindFirstChild(player.Name) and player ~= LocalPlayer then
                    createESP(player)
                end
            end
        else
            ESP_Folder:ClearAllChildren()
        end
    end
end)

-- คลังสำหรับจดจำเป้าหมายล่าสุดของลูกบอลแต่ละลูก (วางไว้นอกลูป)
LastBallTargetMap = {}

-- 🚀 แยกเธรดอิสระสำหรับดักจับการสลับเป้าหมายลูกบอลเพื่อปลดคูลดาวน์โดยเฉพาะ
task.spawn(function()
    while shared._InvisRunning do
        -- ใช้ RenderStepped:Wait() เพื่อให้วนเช็คถี่และไวเท่าเฟรมเรตหน้าจอ
        game:GetService("RunService").RenderStepped:Wait()
        
        -- ตรวจสอบและดึงวัตถุลูกบอลทั้งหมดในสนาม (อิงตามฟังก์ชันของสคริปต์คุณ)
        local balls = type(Auto_Parry.Get_Balls) == "function" and Auto_Parry.Get_Balls() or {}
        
        for _, Ball in ipairs(balls) do
            if Ball and Ball.Parent then
                -- ดึงชื่อเป้าหมายปัจจุบันของลูกบอลลูกนั้นๆ
                local currentTargetStr = tostring(Ball:GetAttribute("target") or Ball:GetAttribute("Target") or "")
                local previousTargetStr = LastBallTargetMap[Ball] or ""
                
                -- 🎯 ถ้าตรวจเจอว่าเป้าหมายของลูกบอลมีการขยับเปลี่ยนคนในเฟรมนี้
                if currentTargetStr ~= previousTargetStr then
                    LastBallTargetMap[Ball] = currentTargetStr -- อัปเดตเป้าหมายใหม่ลงคลังคุมสถานะ
                    
                    -- 🔥 ถ้าผู้เล่นเลือกใช้งานโหมด "Ball target" ให้สั่งเคลียร์สถานะล็อกทั้งหมดทิ้งทันที
                    if Config.UnlockCooldownMode == "Ball target" then
                        if type(parryLocked) == "table" then
                            parryLocked[Ball] = false
                        end
                        if type(lockTime) == "table" then
                            lockTime[Ball] = 0
                        end
                        
                        -- บายพาสเคลียร์ล็อกเสริม (ถ้ามีฟังก์ชันนี้เชื่อมอยู่)
                        if type(shared.InvisClearLock) == "function" then
                            pcall(shared.InvisClearLock, Ball)
                        end
                    end
                end
            end
        end
    end
end)

-- [📊 PREMIUM VELOCITY SMOOTHING FILTER & OVERDRIVE ENGINE]
local speedBuffer = {} -- คลังเก็บประวัติความเร็ว 5 เฟรมล่าสุด
local MAX_BUFFER_SIZE = 5

task.spawn(function() 
    while shared._InvisRunning do 
        game:GetService("RunService").RenderStepped:Wait() 
        
        pcall(function() 
            local ball = Auto_Parry.Get_Ball() 
            if ball and ball.Parent then 
                -- 1. คำนวณความเร็วปัจจุบันของลูกบอล
                local velocity = Vector3.zero 
                local zoomies = ball:FindFirstChild("zoomies") 
                if zoomies then 
                    pcall(function() velocity = zoomies.VectorVelocity end) 
                end 
                if velocity == Vector3.zero and ball:IsA("BasePart") then 
                    velocity = ball.AssemblyLinearVelocity 
                end 
                
                local rawSpeed = velocity.Magnitude 
                
                -- 2. ระบบกรองค่าเฉลี่ย (Moving Average Filter) ดักจับไม่ให้ความเร็วกระพริบ
                table.insert(speedBuffer, 1, rawSpeed)
                if #speedBuffer > MAX_BUFFER_SIZE then
                    table.remove(speedBuffer)
                end
                
                local sumSpeed = 0
                for _, s in ipairs(speedBuffer) do
                    sumSpeed = sumSpeed + s
                end
                local ballSpeed = sumSpeed / #speedBuffer -- นำค่าความเร็วที่นิ่งแล้วไปใช้งาน
                
                -- 3. อัปเดต Caching ไว้แสดงผลบนหน้าจอ GUI ด้วย (ช่วยให้เลขหน้า UI นิ่งขึ้น)
                if Stat_BallSpeed then
                    Stat_BallSpeed.Text = string.format("  ⚡ Ball Speed : %.2f", ballSpeed)
                end
                
                -- 4. ระบบปรับค่า wowcurve แบบ Dynamic ตามเกณฑ์ความเร็วที่คุณกำหนด (เวอร์ชันนิ่งพิเศษ)
                if ballSpeed >= 900 then
                    local calculatedCurve = 0.73 + ((ballSpeed - 640) * 0.00045)
                    Config.wowcurve = math.clamp(calculatedCurve, 0.73, 1.0)
                elseif ballSpeed >= 840 then
                    Config.wowcurve = 0.65
                elseif ballSpeed >= 770 then
                    Config.wowcurve = 0.6
                elseif ballSpeed >= 650 then
                    Config.wowcurve = 0.54
                elseif ballSpeed >= 350 then
                    Config.wowcurve = 0.45
                elseif ballSpeed >= 240 then
                    Config.wowcurve = 0.4
                elseif ballSpeed >= 150 then
                    Config.wowcurve = 0.35
                else
                    Config.wowcurve = 0.33
                end
            else
                table.clear(speedBuffer) -- ล้างค่าเมื่อลูกบอลตายหรือหายไป
            end 
        end) 
    end
end)

-- ลบออกอัตโนมัติเมื่อผู้เล่นออกจากเกม
Players.PlayerRemoving:Connect(removeESP)

-- ═══ 🤖 SMART AUTO PLAY BOT (OPTIMIZED SINGLE-FORMULA ENGINE) ═══════════════
local doubleJumpToken = false

task.spawn(function()
    while shared._InvisRunning do
        -- ใช้ความถี่ตอบสนองที่ลื่นไหลและคงที่ (ประมาณ 0.1 วินาทีต่อเฟรม)
        task.wait(0.1) 
        
        if Config.AutoPlay then
            pcall(function()
                local char = LocalPlayer.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hum or hum.Health <= 0 or not hrp then return end
                
                local ball = Auto_Parry.Get_Ball()
                local targetPlr = Auto_Parry.GetTargetPlayer()
                
                -- ตรวจสอบสถานะการเล็งของลูกบอล
                local ballTargetStr = ball and tostring(ball:GetAttribute("target") or ball:GetAttribute("Target") or "") or ""
                local isTargetingMe = (ballTargetStr == LocalPlayer.Name or (char and ballTargetStr == char.Name))
                
                -- สูตรคำนวณตำแหน่งเคลื่อนที่เดียวจบ (Smart Positioning Formula)
                local destination = hrp.Position
                
                if ball and ball.Parent then
                    local velocity = ball.AssemblyLinearVelocity
                    local zoomies = ball:FindFirstChild("zoomies")
                    if zoomies then pcall(function() velocity = zoomies.VectorVelocity end) end
                    local ballSpeed = velocity.Magnitude
                    local ballDist = (hrp.Position - ball.Position).Magnitude
                    
                    if isTargetingMe then
                        -- [กรณีบอลเล็งเรา]: เดินถอยฉีกออกจากวิถีตรงของบอล 45 องศา เพื่อสร้างมุม Parry ที่ดีที่สุด
                        local ballDirection = ballSpeed > 1 and velocity.Unit or Vector3.new(0, 0, 1)
                        local lateralSafeDirection = Vector3.new(-ballDirection.Z, 0, ballDirection.X).Unit
                        destination = ball.Position + (lateralSafeDirection * math.clamp(ballDist * 0.6, 20, 45))
                    else
                        -- [กรณีบอลเล็งคนอื่น]: รักษาระยะห่างที่ปลอดภัย ไม่เข้าใกล้บอลเกินไป และไม่เดินไปขวางทางคนอื่น
                        if ballDist < 40 then
                            local escapeDirection = (hrp.Position - ball.Position).Unit
                            destination = hrp.Position + (escapeDirection * 25)
                        else
                            -- ยืนคุมเชิงใกล้ๆ เป้าหมายปัจจุบันของบอลเพื่อเตรียมซัพพอร์ต
                            local currentTarget = ball:GetAttribute("target") or ball:GetAttribute("Target")
                            local targetChar = currentTarget and workspace.Alive:FindFirstChild(tostring(currentTarget))
                            if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
                                destination = targetChar.HumanoidRootPart.Position + Vector3.new(math.random(-15, 15), 0, math.random(-15, 15))
                            end
                        end
                    end
                elseif targetPlr and targetPlr.PrimaryPart then
                    -- หากไม่มีบอลในสนาม ให้เดินคุมระยะเว้นห่างจากศัตรูที่ใกล้ที่สุด
                    destination = targetPlr.PrimaryPart.Position + Vector3.new(math.random(-20, 20), 0, math.random(-20, 20))
                end
                
                -- สั่งเคลื่อนที่ไปยังจุดหมายที่คำนวณจากสูตรสำเร็จ
                hum:MoveTo(destination)
                
                -- 🦘 [ระบบกระโดดสองจังหวะดักฟิสิกส์หลบวิถีโค้ง]
                if isTargetingMe and ball then
                    local ballDist = (hrp.Position - ball.Position).Magnitude
                    local velocity = ball.AssemblyLinearVelocity
                    local zoomies = ball:FindFirstChild("zoomies")
                    if zoomies then pcall(function() velocity = zoomies.VectorVelocity end) end
                    
                    -- คำนวณระยะการกระโดดหลบสัมพันธ์กับความเร็วของบอล
                    if ballDist <= math.clamp(velocity.Magnitude * 0.4, 25, 65) then
                        -- จังหวะที่ 1: ดีดตัวขึ้นจากพื้น
                        if hum.FloorMaterial ~= Enum.Material.Air and not doubleJumpToken then
                            hum:ChangeState(Enum.HumanoidStateType.Jumping)
                            doubleJumpToken = true
                            task.wait(0.15)
                        end
                        
                        -- จังหวะที่ 2: กด Double Jump กลางอากาศเพื่อดึงระยะหลบวิถี Curve
                        if doubleJumpToken and hum:GetState() == Enum.HumanoidStateType.FreeFall then
                            hum:ChangeState(Enum.HumanoidStateType.Jumping)
                            doubleJumpToken = false
                            task.wait(0.2)
                        end
                    end
                else
                    if hum.FloorMaterial ~= Enum.Material.Air then
                        doubleJumpToken = false
                    end
                end
                
            end)
        end
    end
end)
-- =======================================================================
-- 💀 GODMODE DESYNC ENGINE (ERYNDOR STYLE NETWORK WAKER + ANGLE +250 v8)
-- =======================================================================
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Cam = workspace.CurrentCamera

-- 🌟 โครงสร้างตารางและค่าพิกัดความสูง/ต่ำ (h1, h2, Radius) อ้างอิงตามชุดเสถียรของคุณ
local DesyncState = {} 
local h1, h2, Radius = -8, 35, 10 

-- 📦 สร้าง Part ล่องหนปัก Anchor (Camera Proxy)
local CamAnchor = workspace:FindFirstChild("Invis_CamAnchor") or Instance.new("Part")
if not CamAnchor.Parent then
    CamAnchor.Size = Vector3.new(1, 1, 1)
    CamAnchor.Transparency = 1 
    CamAnchor.CanCollide = false 
    CamAnchor.Anchored = true
    CamAnchor.Name = "Invis_CamAnchor"
    CamAnchor.Parent = workspace
end

if shared.InvisGodModeBind then shared.InvisGodModeBind:Disconnect() end

shared.InvisGodModeBind = RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    
    if not Config.GodMode or not hrp or not hum or hum.Health <= 0 then 
        if Cam.CameraSubject == CamAnchor then 
            Cam.CameraSubject = hum 
        end
        return 
    end
    
    -- บังคับพิกัดกล้องให้เกาะติดร่าง Client
    CamAnchor.CFrame = CamAnchor.CFrame:Lerp(CFrame.new(hrp.Position), 0.5)
    if Cam.CameraSubject ~= CamAnchor then 
        Cam.CameraSubject = CamAnchor 
    end

    -- 🚀 [ERYNDOR CODELINE]: แอบขยับยกแกนพิกัด CFrame ขึ้นฟ้าทีละ 0.01 ก่อนจดจำค่าเข้าอาร์เรย์
    -- เพื่อบังคับกระตุ้นตัวส่งสัญญาณเครือข่าย (Physics Replication) ต้านระบบแช่แข็งของตัวเซิร์ฟเวอร์ตอนยืนนิ่ง
    hrp.CFrame = hrp.CFrame + Vector3.new(0, 0.01, 0)

    -- บันทึกสถานะพิกัดและการเคลื่อนไหวที่อัปเดตแกนเซิร์ฟเวอร์แล้วลง Array ป้องกันบักโค้ดพัง
    DesyncState[1] = hrp.CFrame
    DesyncState[2] = hrp.AssemblyLinearVelocity
    
    -- 📡 ดึงความเร็วลูกบอลปัจจุบันมาประมวลผลมุม Dynamic Angle
    local currentBallSpeed = 0
    local ball = (type(Auto_Parry) == "table" and type(Auto_Parry.Get_Ball) == "function") and Auto_Parry.Get_Ball()
    
    if ball and ball.Parent then
        local velocity = Vector3.zero
        local zoomies = ball:FindFirstChild("zoomies")
        if zoomies then pcall(function() velocity = zoomies.VectorVelocity end) end
        if velocity == Vector3.zero and ball:IsA("BasePart") then velocity = ball.AssemblyLinearVelocity end
        currentBallSpeed = velocity.Magnitude
    end

    -- 🚀 [อัปเดตสมการมุมตามสั่ง]: ปรับแต่งทิศทางความถี่แปรผันออฟเซ็ตเพิ่มไปอีก +250 องศา
    local DynamicAngle = 145 + (currentBallSpeed * 2)

    local curTime = tick()
    local calcAngle = curTime * math.pi * 2 * DynamicAngle / 5
    local calcY = (math.floor(curTime * 135) % 2 == 0) and h1 or h2
    local offset = Vector3.new(math.cos(calcAngle) * Radius, calcY, math.sin(calcAngle) * Radius)
    
    pcall(function() setfflag("S2PhysicsSenderRate", "1333335") end)

    -- วาร์ปร่างหลอกเซิร์ฟเวอร์ในทิศทางองศาใหม่ (Dynamic Angle + 250)
    hrp.CFrame = DesyncState[1] + offset
    
    -- ส่งค่าแรงส่งเหวี่ยงแกนราบระดับสูงเพื่อดีดมิติตัวลวงออกจากพิกัดประมวลผลของลูกบอล
    local highSpeedVelY = (calcY == h2) and 280 or -280
    hrp.AssemblyLinearVelocity = Vector3.new(math.sin(calcAngle) * 250, highSpeedVelY, math.cos(calcAngle) * 250)
    
    RunService.RenderStepped:Wait()
    
    -- ดึงร่างกลับมาตำแหน่งหน้าจอ Client แท้จริงเพื่อให้เราบังคับได้ปกติ ไม่ลอยหลุดแมพ
    if hrp and hrp.Parent then
        hrp.CFrame = DesyncState[1]
        hrp.AssemblyLinearVelocity = DesyncState[2]
    end
end)

-- ═══ LOW GRAPHICS & ULTRA FPS BOOST FUNCTION (DYNAMIC LOOP) ═══
local lowGraphicsConn = nil

local function applyLowGraphics(enable)
    Config.LowGraphicsEnabled = enable
    
    -- ถ้าปิดการใช้งาน ให้ยกเลิกลูปการดักจับวัตถุใหม่
    if not enable then
        if lowGraphicsConn then
            lowGraphicsConn:Disconnect()
            lowGraphicsConn = nil
        end
        return
    end
    
    -- ฟังก์ชันย่อยสำหรับปรับแต่งวัตถุแต่ละชิ้น
    local function optimizeObject(obj)
        pcall(function()
            if obj:IsA("BasePart") then
                obj.CastShadow = false -- ปิดเงาวัตถุ
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Sparkles") or obj:IsA("Fire") or obj:IsA("Beam") then
                obj.Enabled = false -- ปิดเอฟเฟกต์ฟุ่มเฟือย
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj:Destroy() -- ลบเท็กซ์เจอร์ลดการกินแรม
            end
        end)
    end
    
    pcall(function()
        -- 1. ปรับลดการประมวลผลแสงและสภาพแวดล้อม (Lighting) รอบแรก
        local Lighting = game:GetService("Lighting")
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        
        for _, effect in ipairs(Lighting:GetChildren()) do
            if effect:IsA("PostEffect") or effect:IsA("BloomEffect") or effect:IsA("BlurEffect") or effect:IsA("DepthOfFieldEffect") or effect:IsA("SunRaysEffect") then
                effect.Enabled = false
            end
        end
        
        -- 2. เคลียร์วัตถุที่มีอยู่เดิมทั้งหมดใน Workspace
        for _, obj in ipairs(workspace:GetDescendants()) do
            optimizeObject(obj)
        end
        
        -- 3. ปิดการประมวลผลน้ำและซ่อนน้ำใน Terrain แบบ 100%
        local Terrain = workspace:FindFirstChildOfClass("Terrain")
        if Terrain then
            Terrain.WaterWaveSize = 0
            Terrain.WaterWaveSpeed = 0
            Terrain.WaterReflectance = 0
            Terrain.WaterTransparency = 1
        end
    end)
    
    -- 4. ระบบลูปอัตโนมัติ (คอยจัดการวัตถุใหม่ๆ ที่ถูกสร้างขึ้นมาระหว่างเล่นทันที)
    if not lowGraphicsConn then
        lowGraphicsConn = workspace.DescendantAdded:Connect(function(obj)
            if Config.LowGraphicsEnabled then
                optimizeObject(obj)
            end
        end)
    end
end

-- =======================================================================
-- ⚡ EXTENSION: THUNDER DASH NO COOLDOWN PIPELINE (INVIS HUB COMPATIBLE)
-- =======================================================================
Config.ThunderDashExploit = false -- สเตทเริ่มต้นในตาราง Config หลัก

task.spawn(function()
    while true do
        task.wait(0.3) -- สแกนตรวจสอบระบบทุกๆ 0.3 วินาที เพื่อประหยัด CPU
        
        if Config.ThunderDashExploit and shared._InvisRunning then
            pcall(function()
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local sharedFolder = ReplicatedStorage:FindFirstChild("Shared")
                local abilities = sharedFolder and sharedFolder:FindFirstChild("Abilities")
                local thunderDashModule = abilities and abilities:FindFirstChild("Thunder Dash")

                if thunderDashModule and thunderDashModule:IsA("ModuleScript") then
                    local ok, mod = pcall(require, thunderDashModule)
                    if ok and type(mod) == "table" then
                        -- ⚡ เจาะระบบเขียนทับค่าคูลดาวน์ให้เป็น 0 ทันที
                        if mod.cooldown ~= 0 then
                            mod.cooldown = 0
                            mod.cooldownReductionPerUpgrade = 0
                        end
                    end
                end
            end)
        else
            -- พักเธรดระยะยาวหากไม่ได้เปิดใช้งานฟังก์ชันนี้
            task.wait(1)
        end
    end
end)
-- =======================================================================
-- ═══ SERVER CONTROLLER UTILITIES (ULTIMATE OPTIMIZED) ═════════════════
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local function RejoinServer()
    CustomNotify("Rejoining current server...", 3)
    task.wait(0.5)
    local success, err = pcall(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end)
    if not success then
        CustomNotify("Rejoin failed: " .. tostring(err), 4)
    end
end

local function ServerHop()
    CustomNotify("Searching for an optimal public server...", 4)
    
    local success, err = pcall(function()
        local validServers = {}
        local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        
        local req = HttpService:JSONDecode(game:HttpGet(url))
        if req and req.data then
            for _, server in ipairs(req.data) do
                -- คัดเลือกเซิร์ฟเวอร์ที่ไม่ใช่ห้องเดิม, ยังไม่เต็ม, และมีผู้เล่นอย่างน้อย 1 คน (ป้องกันห้องร้าง)
                if server.id ~= game.JobId and server.playing < server.maxPlayers and server.playing > 0 then
                    table.insert(validServers, server.id)
                end
            end
        end
        
        if #validServers > 0 then
            -- สุ่มเลือกเซิร์ฟเวอร์จากรายชื่อที่กรองได้ เพื่อความปลอดภัยและกระจายตัว
            math.randomseed(os.time())
            local targetServerId = validServers[math.random(1, #validServers)]
            
            CustomNotify("Connecting to new server...", 3)
            task.wait(0.5)
            TeleportService:TeleportToPlaceInstance(game.PlaceId, targetServerId, LocalPlayer)
        else
            -- Fallback: ถ้าหาห้องที่มีคนไม่ได้ ให้ลองเข้าห้องว่างห้องไหนก็ได้ที่มีที่ว่าง
            if req and req.data then
                for _, server in ipairs(req.data) do
                    if server.id ~= game.JobId and server.playing < server.maxPlayers then
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                        return
                    end
                end
            end
            CustomNotify("Server hop failed: All servers are full or unavailable.", 4)
        end
    end)
    
    if not success then
        CustomNotify("Server hop error occurred.", 4)
    end
end
-- =======================================================================
-- 🖼️ INVIS HUB X RISE UI: MINIMAL WHITE EDITION (PART 1 - SECTION 1)
-- =======================================================================
UI_Target_Parent = nil
pcall(function()
    if gethui and type(gethui) == "function" then UI_Target_Parent = gethui()
    elseif get_hidden_ui and type(get_hidden_ui) == "function" then UI_Target_Parent = get_hidden_ui()
    else UI_Target_Parent = game:GetService("CoreGui") end
end)
if not UI_Target_Parent then
    UI_Target_Parent = LocalPlayer:WaitForChild("PlayerGui", 10)
end

ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Rise"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
if UI_Target_Parent then ScreenGui.Parent = UI_Target_Parent end

-- 📦 1. ตัวจำลองเงาขอบมิติโทนเข้มเบื้องหลัง (Shadow Label)
Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Parent = ScreenGui
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 1.000
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.Size = UDim2.new(0, 776, 0, 509)
Shadow.ZIndex = 0
Shadow.Image = "rbxassetid://17290899982"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)

-- 📦 2. หน้าต่างเมนูหลักสไตล์มินิมอล (Main Container)
MainFrame = Instance.new("Frame")
MainFrame.Name = "Container"
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BackgroundTransparency = 0.2
MainFrame.ClipsDescendants = true
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 699, 0, 426)

ContainerCorner = Instance.new("UICorner")
ContainerCorner.CornerRadius = UDim.new(0, 20)
ContainerCorner.Parent = MainFrame

-- 🖼️ [INVIS BACKGROUND IMAGE]: ดึงลิงก์ภาพวิวภูเขามืดที่คุณส่งมา ไปแสดงผลเป็นพื้นหลังด้านในเมนูหลัก
MenuBgImage = Instance.new("ImageLabel")
MenuBgImage.Name = "InvisMenuBackground"
MenuBgImage.Parent = MainFrame
MenuBgImage.Size = UDim2.new(1, 0, 1, 0)
MenuBgImage.Position = UDim2.new(0, 0, 0, 0)
MenuBgImage.BackgroundTransparency = 1
MenuBgImage.ImageTransparency = 0.4 
MenuBgImage.ScaleType = Enum.ScaleType.Crop
MenuBgImage.ZIndex = 1
MenuBgImage.Visible = true

-- 🔁 เธรดพิเศษดาวน์โหลดภาพสดจากลิ้งก์และแปลงเข้าหน่วยความจำเครื่อง Client
task.spawn(function()
    pcall(function()
        InvisBgFileName = "InvisHub_ThemeMountain.jpg"
        InvisBgURL = "https://raw.githubusercontent.com/foreverspacexc-blip/INVISHUB/refs/heads/main/2e0e99b1953600437cc42dd9122e415b.jpg"
        
        -- ถ้ายังไม่มีไฟล์ภาพในโฟลเดอร์รันสคริปต์ ให้ทำการดาวน์โหลดใหม่
        if not isfile(InvisBgFileName) then
            DownloadedData = game:HttpGet(InvisBgURL)
            writefile(InvisBgFileName, DownloadData or DownloadedData)
        end
        
        -- แปลงไฟล์ภาพในเครื่องให้กลายเป็น Asset ID ที่ Roblox รู้จัก
        InvisImageAssetId = getcustomasset(InvisBgFileName)
        MenuBgImage.Image = InvisImageAssetId
    end)
end)

BgCorner = Instance.new("UICorner")
BgCorner.CornerRadius = UDim.new(0, 20)
BgCorner.Parent = MenuBgImage

-- 🌈 ขอบไฟสไตล์ Invis ขาวผินสะอาดตา (Elegant White Border Stroke)
MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 1.5
MainStroke.Color = Color3.fromRGB(240, 240, 245)
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.ZIndex = 2

-- 📦 3. ส่วนหัวแถบรายการด้านบน (Top Bar Control)
Top = Instance.new("Frame")
Top.Name = "Top"
Top.Parent = MainFrame
Top.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Top.BackgroundTransparency = 0.5
Top.BorderSizePixel = 0
Top.Size = UDim2.new(1, 0, 0, 39)
Top.ZIndex = 3

-- 🏷️ หัวข้อข้อความชื่อสคริปต์ Invis Hub
TextLabelTitle = Instance.new("TextLabel")
TextLabelTitle.Parent = Top
TextLabelTitle.AnchorPoint = Vector2.new(0, 0.5)
TextLabelTitle.BackgroundTransparency = 1.000
TextLabelTitle.Position = UDim2.new(0, 20, 0.5, 0)
TextLabelTitle.Size = UDim2.new(0, 150, 0, 16)
TextLabelTitle.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
TextLabelTitle.Text = "INVIS HUB (v1.00.12)"
TextLabelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabelTitle.TextSize = 14.000
TextLabelTitle.TextXAlignment = Enum.TextXAlignment.Left
TextLabelTitle.ZIndex = 4

-- ⏱️ ตัวนับเวลา Smooth Dynamic Clock บนแถบหัวข้อ
TimeLabel = Instance.new("TextLabel")
TimeLabel.Parent = Top
TimeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
TimeLabel.BackgroundTransparency = 1.000
TimeLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
TimeLabel.Size = UDim2.new(0, 75, 0, 16)
TimeLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
TimeLabel.Text = "00:00"
TimeLabel.TextColor3 = Color3.fromRGB(220, 220, 225)
TimeLabel.TextSize = 13
TimeLabel.TextXAlignment = Enum.TextXAlignment.Center
TimeLabel.ZIndex = 4

-- 🐱 น้องแมวเต้นดุ๊กดิ๊กแอนิเมชัน Gif (Cat Animation Module)
Cat = Instance.new("ImageLabel")
Cat.Name = "Cat"
Cat.Parent = Top
Cat.BackgroundTransparency = 1.000
Cat.Position = UDim2.new(0.93, 0, 0.2, 0)
Cat.Size = UDim2.new(0, 25, 0, 25)
Cat.ZIndex = 4
Cat.Image = "rbxassetid://123237152799765"

function AnimateGif(ImageLabel, Width, Height, Rows, Columns, NumberOfFrames, ImageID, FPS)
    if ImageID then ImageLabel.Image = ImageID end
    RobloxMaxImageSize = 2048
    RealWidth, RealHeight = Width, Height
    if math.max(Width, Height) > RobloxMaxImageSize then
        RealWidth = RobloxMaxImageSize
        RealHeight = (RealWidth / Width) * Height
    end
    FrameSize = Vector2.new(RealWidth / Columns, RealHeight / Rows)
    ImageLabel.ImageRectSize = FrameSize
    CurrentRow, CurrentColumn = 0, 0
    Offsets = {}
    for i = 1, NumberOfFrames do
        table.insert(Offsets, Vector2.new(CurrentColumn * FrameSize.X, CurrentRow * FrameSize.Y))
        CurrentColumn += 1
        if CurrentColumn >= Columns then CurrentColumn = 0 CurrentRow += 1 end
    end
    Index = 0
    task.spawn(function()
        while task.wait(FPS and 1 / FPS or 0.1) and ImageLabel:IsDescendantOf(game) do
            Index = (Index >= NumberOfFrames) and 1 or Index + 1
            ImageLabel.ImageRectOffset = Offsets[Index]
        end
    end)
end
AnimateGif(Cat, 60, 40, 2, 3, 5, "rbxassetid://123237152799765", 10)

-- ลูปนับเวลาการเปิดใช้งานสคริปต์แบบ Fade สมูท
startTime = os.time()
task.spawn(function()
    while task.wait(1) and TimeLabel:IsDescendantOf(game) do
        elapsed = os.time() - startTime
        minutes, secs = math.floor(elapsed / 60), elapsed % 60
        newText = string.format("%02d:%02d", minutes, secs)
        
        tweenOut = TweenService:Create(TimeLabel, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {TextTransparency = 1})
        tweenOut:Play()
        tweenOut.Completed:Once(function()
            TimeLabel.Text = newText
            TweenService:Create(TimeLabel, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {TextTransparency = 0}):Play()
        end)
    end
end)

-- =======================================================================
-- 🎬 PART 1: PREMIUM VIDEO LOOP FOR MOBILE_BUTTON (MINIMAL WHITE BORDER)
-- =======================================================================
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- 🔘 ปรับแต่งปุ่ม mobile_button ให้เป็นสี่เหลี่ยมจัตุรัส 1:1 ขอบสีขาวนิ่งสไตล์ Rise
mobile_button = Instance.new("TextButton")
mobile_button.Name = "Mobile"
mobile_button.Size = UDim2.new(0, 52, 0, 52) 
mobile_button.Position = UDim2.new(0.1, 0, 0.4, 0) 
mobile_button.BackgroundColor3 = Color3.fromRGB(15, 15, 18) -- โทนดำลึก Rise UI
mobile_button.Text = "" 
mobile_button.AutoButtonColor = false
mobile_button.Modal = true 
mobile_button.ZIndex = 9999
mobile_button.Parent = ScreenGui
Instance.new("UICorner", mobile_button).CornerRadius = UDim.new(0, 14) 

-- 🌈 ล็อกขอบให้เป็นสีขาวนวลนิ่งพรีเมียม (Elegant White Solid Border) ไม่วิ่งเปลี่ยนสี
local ButtonStroke = Instance.new("UIStroke", mobile_button)
ButtonStroke.Thickness = 2
ButtonStroke.Color = Color3.fromRGB(245, 245, 250) -- สีขาวนวลสะอาดตาค่าย Invis


-- 🖼️ [IMAGE FRAME INJECTION]: ติดตั้งกล่องแสดงผลรูปภาพสัดส่วน 1:1 ลงบนปุ่มแทนวิดีโอ
local PremiumImage = Instance.new("ImageLabel", mobile_button)
PremiumImage.Name = "InvisLoopPlayer"
PremiumImage.Size = UDim2.new(1, 0, 1, 0)
PremiumImage.Position = UDim2.new(0, 0, 0, 0)
PremiumImage.BackgroundTransparency = 1
PremiumImage.ScaleType = Enum.ScaleType.Crop -- ปรับภาพให้ตัดพอดีกรอบสี่เหลี่ยมจัตุรัส

local ImageCorner = Instance.new("UICorner", PremiumImage)
ImageCorner.CornerRadius = UDim.new(0, 14)

-- 🔄 โหลดรูปภาพจากลิงก์ GitHub ลงเครื่อง Client อัตโนมัติ
task.spawn(function()
    pcall(function()
        local ImageFileName = "InvisHub_LoopPremiumImage.jpg"
        local TargetURL = "https://raw.githubusercontent.com/foreverspacexc-blip/OpScriptHub/refs/heads/main/c08a327fbee27846394c81fd428e4131.jpg"
        
        -- ถ้ายังไม่มีไฟล์รูปภาพในเครื่อง ให้ทำการดาวน์โหลดใหม่
        if not isfile(ImageFileName) then
            local rawData = game:HttpGet(TargetURL)
            writefile(ImageFileName, rawData)
        end
        
        -- แปลงไฟล์ในเครื่องให้กลายเป็น Asset ID เพื่อนำมาแสดงผลบน ImageLabel
        local customAssetId = getcustomasset(ImageFileName)
        PremiumImage.Image = customAssetId
    end)
end)


mobile_button.MouseEnter:Connect(function()
    TweenService:Create(mobile_button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(230, 230, 235)}):Play()
end)
mobile_button.MouseLeave:Connect(function()
    TweenService:Create(mobile_button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)

-- ระบบลากปุ่มลอย และตรรกะสวิตช์เปิด/ปิดหน้าต่างเมนู (Toggle Display)
dragging, dragInput, dragStart, startPos = nil, nil, nil, nil
guiState = true
isTransitioning = false

mobile_button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mobile_button.Position
        TweenService:Create(mobile_button, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 44, 0, 44)}):Play()
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
mobile_button.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        delta = input.Position - dragStart
        mobile_button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

mobile_button.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        TweenService:Create(mobile_button, TweenInfo.new(0.3, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = UDim2.new(0, 50, 0, 50)}):Play()
        
        if not isTransitioning then
            movedDistance = dragStart and (input.Position - dragStart).Magnitude or 0
            if movedDistance < 5 then 
                isTransitioning = true
                guiState = not guiState
                
                style = Enum.EasingStyle.Circular
                dir = Enum.EasingDirection.InOut
                
                if guiState then
                    MainFrame.Visible = true
                    Shadow.Visible = true
                    TweenService:Create(MainFrame, TweenInfo.new(0.6, style, dir), {Size = UDim2.new(0, 699, 0, 426)}):Play()
                    t = TweenService:Create(Shadow, TweenInfo.new(0.6, style, dir), {Size = UDim2.new(0, 776, 0, 509)})
                    t:Play()
                    t.Completed:Once(function() isTransitioning = false end)
                else
                    TweenService:Create(Shadow, TweenInfo.new(0.6, style, dir), {Size = UDim2.new(0, 0, 0, 0)}):Play()
                    t = TweenService:Create(MainFrame, TweenInfo.new(0.6, style, dir), {Size = UDim2.new(0, 0, 0, 0)})
                    t:Play()
                    t.Completed:Once(function()
                        if not guiState then MainFrame.Visible = false Shadow.Visible = false end
                        isTransitioning = false
                    end)
                end
            end
        end
    end
end)

-- ระบบคีย์บอร์ดทางลัด (Left/Right Control) เพื่อสลับการแสดงผลเมนู
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
        mobile_button:Activate()
    end
end)

-- ระบบลากตัวหน้าต่างหลัก (Main Window Draggable)
mDrag, mStart, mPos = nil, nil, nil
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        mDrag = true mStart = input.Position mPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then mDrag = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if mDrag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        delta = input.Position - mStart
        targetPos = UDim2.new(mPos.X.Scale, mPos.X.Offset + delta.X, mPos.Y.Scale, mPos.Y.Offset + delta.Y)
        TweenService:Create(MainFrame, TweenInfo.new(0.1), {Position = targetPos}):Play()
        TweenService:Create(Shadow, TweenInfo.new(0.1), {Position = targetPos}):Play()
    end
end)

-- เส้นแบ่งพิกัดแนวตั้งสีขาวใสตัดกับพื้นหลังภาพ
Line = Instance.new("Frame")
Line.Name = "Line"
Line.Parent = MainFrame
Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line.BackgroundTransparency = 0.8
Line.BorderSizePixel = 0
Line.Position = UDim2.new(0.296, 0, 0.091, 0)
Line.Size = UDim2.new(0, 2, 0, 387)
Line.ZIndex = 3

Sidebar = Instance.new("ScrollingFrame", MainFrame)
Sidebar.Name = "Sidebar_ScrollingMenu"
Sidebar.Size = UDim2.new(0, 209, 0, 386)
Sidebar.Position = UDim2.new(0, 0, 0.091, 0)
Sidebar.BackgroundTransparency = 1
Sidebar.BorderSizePixel = 0
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
Sidebar.ScrollBarThickness = 0
Sidebar.ZIndex = 3

-- =======================================================================
-- 📑 RISE STYLE TAB FRAMES INITIALIZATION (PART 2 - SECTION 1)
-- =======================================================================
if not getgenv().TabFrames then getgenv().TabFrames = {} end
if not getgenv().TabButtons then getgenv().TabButtons = {} end

TabFrames = getgenv().TabFrames
TabButtons = getgenv().TabButtons

table.clear(TabFrames)
table.clear(TabButtons)

-- =======================================================================
-- 📑 RISE TAB SCROLL INITIALIZATION (2 BUTTONS PER ROW GRID SYSTEM)
-- =======================================================================
function createTabScroll(tabName)
    if not ContentContainer then 
        ContentContainer = Instance.new("Frame", MainFrame)
        ContentContainer.Name = "ContentContainer"
        ContentContainer.Size = UDim2.new(0, 480, 0, 372)
        ContentContainer.Position = UDim2.new(0.31, 0, 0.12, 0)
        ContentContainer.BackgroundTransparency = 1
        ContentContainer.ZIndex = 3
    end

    local scr = Instance.new("ScrollingFrame")
    scr.Name = tostring(tabName) .. "_ScrollFrame"
    scr.Size = UDim2.new(1, 0, 1, 0)
    scr.BackgroundTransparency = 1
    scr.CanvasSize = UDim2.new(0, 0, 0, 0)
    scr.AutomaticCanvasSize = Enum.AutomaticSize.Y 
    scr.ScrollBarThickness = 0 
    scr.Visible = false 
    scr.ClipsDescendants = true 
    scr.BorderSizePixel = 0
    scr.ZIndex = 4
    scr.Parent = ContentContainer

    -- 📐 [GRID LAYOUT INJECTION]: เปลี่ยนจาก UIListLayout เป็น UIGridLayout
    -- ระบบจะจัดปุ่มขนาด 215px เรียงหน้ากระดานซ้าย-ขวา 2 ปุ่มต่อบรรทัดให้เองอัตโนมัติ
    local UIGrid = Instance.new("UIGridLayout", scr)
    UIGrid.CellSize = UDim2.fromOffset(215, 37) -- กำหนดขนาดปุ่มตามฟังก์ชัน createToggle ดั้งเดิม
    UIGrid.CellPadding = UDim2.fromOffset(8, 7) -- ช่องไฟระยะห่าง (แนวนอน 8px, แนวตั้ง 7px)
    UIGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIGrid.SortOrder = Enum.SortOrder.LayoutOrder

    local UIPad = Instance.new("UIPadding", scr)
    UIPad.PaddingRight = UDim.new(0, 6)
    UIPad.PaddingLeft = UDim.new(0, 2)
    UIPad.PaddingTop = UDim.new(0, 6)
    UIPad.PaddingBottom = UDim.new(0, 20)

    -- คำนวณขยายความสูงของพื้นที่เลื่อน (Canvas) ตามจำนวนแถวของปุ่มจริง
    UIGrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        pcall(function()
            if UIGrid and UIPad then
                scr.CanvasSize = UDim2.new(0, 0, 0, UIGrid.AbsoluteContentSize.Y + UIPad.PaddingTop.Offset + UIPad.PaddingBottom.Offset)
            end
        end)
    end)

    TabFrames[tabName] = scr
    return scr
end

combatScroll = createTabScroll("Combat")
visualScroll = createTabScroll("Visuals")
settingsScroll = createTabScroll("Settings")
uiScroll = createTabScroll("UI")
statusScroll = createTabScroll("Status")
scriptScroll = createTabScroll("Script Hub")
musicScroll = createTabScroll("Music")
abilityDetScroll = createTabScroll("Ability Detections")
whatsNewScroll = createTabScroll("What's New")

TabFrames["Combat"].Visible = true

-- =======================================================================
-- 📑 RISE STYLE TAB FRAMES INITIALIZATION (PART 2 - SECTION 2)
-- =======================================================================
function setupTabButton(name)
    tab = Instance.new("TextButton", Sidebar)
    tab.Name = "Tab"
    tab.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
    tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
    tab.BorderSizePixel = 0
    tab.Size = UDim2.new(0, 174, 0, 40)
    tab.ZIndex = 4
    tab.AutoButtonColor = false
    tab.Font = Enum.Font.SourceSans
    tab.Text = ""

    tabCorner = Instance.new("UICorner", tab)
    tabCorner.CornerRadius = UDim.new(0, 5)

    TextLabel = Instance.new("TextLabel", tab)
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.Position = UDim2.new(0.589, 0, 0.5, 0)
    TextLabel.Size = UDim2.new(0, 124, 0, 15)
    TextLabel.ZIndex = 6
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
    TextLabel.Text = name
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 14.000
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextTransparency = (name == "Combat") and 0 or 0.5 -- ถ้าไม่ใช่หน้าแรก ให้จางไว้ 50%

    Logo = Instance.new("ImageLabel", tab)
    Logo.Name = "Logo"
    Logo.AnchorPoint = Vector2.new(0.5, 0.5)
    Logo.BackgroundTransparency = 1.000
    Logo.Position = UDim2.new(0.13, 0, 0.5, 0)
    Logo.Size = UDim2.new(0, 17, 0, 17)
    Logo.ZIndex = 6
    Logo.Image = "rbxassetid://17290664977" -- สัญลักษณ์ไอคอนประดับหน้าแท็บ
    Logo.ImageColor3 = Color3.fromRGB(255, 255, 255)
    Logo.ImageTransparency = (name == "Combat") and 0 or 0.5

    Glow = Instance.new("ImageLabel", tab)
    Glow.Name = "Glow"
    Glow.AnchorPoint = Vector2.new(0.5, 0.5)
    Glow.BackgroundTransparency = 1.000
    Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Glow.Size = UDim2.new(0, 190, 0, 53)
    Glow.Image = "rbxassetid://17290723539"
    Glow.ImageColor3 = Color3.fromRGB(255, 255, 255) -- เปลี่ยนแสงสะท้อนออร่ารอบปุ่มเป็นสีขาวพรีเมียม
    Glow.ImageTransparency = (name == "Combat") and 0 or 1.0 -- ซ่อนแสงไว้ถ้าย स्टาร์ทไม่ใช่ Combat

    Fill = Instance.new("Frame", tab)
    Fill.Name = "Fill"
    Fill.AnchorPoint = Vector2.new(0.5, 0.5)
    Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Fill.BackgroundTransparency = (name == "Combat") and 0 or 1.0 -- แสดงผลสีกราเดียนท์เมื่อเลือกหน้า
    Fill.BorderSizePixel = 0
    Fill.Position = UDim2.new(0.5, 0, 0.5, 0)
    Fill.Size = UDim2.new(0, 174, 0, 40)
    Fill.ZIndex = 5

    UICorner_Fill = Instance.new("UICorner", Fill)
    UICorner_Fill.CornerRadius = UDim.new(0, 10)

    UIGradient = Instance.new("UIGradient", Fill)
    -- ปรับปรุงคู่เฉดสีสลับเปลี่ยนมิติให้กลายมาเป็นสไตล์ขาว-เทาเงินหรูหราของค่าย Invis
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(245, 245, 250)), 
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(160, 160, 170))
    }
    UIGradient.Rotation = 20

    TabButtons[name] = tab

    -- ตรรกะการสลับหน้าแท็บพร้อมรันแอนิเมชันแฟลชแสงเลื่อนสลับ (Rise Fade Transition)
    tab.MouseButton1Click:Connect(function()
        for tName, frame in pairs(TabFrames) do
            isTarget = (tName == name)
            if frame then frame.Visible = isTarget end
            
            targetBtn = TabButtons[tName]
            if targetBtn then
                targetTrans = isTarget and 0 or 1.0
                textTrans = isTarget and 0 or 0.5
                
                -- เล่นแอนิเมชันเปิด/ปิด เลเยอร์แสงสะท้อนและสีของปุ่มเมื่อคลิกเปลี่ยนหน้า
                TweenService:Create(targetBtn.Fill, TweenInfo.new(0.35), {BackgroundTransparency = targetTrans}):Play()
                TweenService:Create(targetBtn.Glow, TweenInfo.new(0.35), {ImageTransparency = targetTrans}):Play()
                TweenService:Create(targetBtn.TextLabel, TweenInfo.new(0.35), {TextTransparency = textTrans}):Play()
                TweenService:Create(targetBtn.Logo, TweenInfo.new(0.35), {ImageTransparency = textTrans}):Play()
                
                -- เปลี่ยนสีตัวอักษรของแท็บที่เลือกให้เป็นสีดำมืดตัดกับพื้นสีขาวกราเดียนท์
                if isTarget then
                    targetBtn.TextLabel.TextColor3 = Color3.fromRGB(15, 15, 18)
                    targetBtn.Logo.ImageColor3 = Color3.fromRGB(15, 15, 18)
                else
                    targetBtn.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    targetBtn.Logo.ImageColor3 = Color3.fromRGB(255, 255, 255)
                end
            end
        end
    end)
    
    -- โหลดสถานะสีเริ่มต้นสำหรับแท็บแรก (Combat)
    if name == "Combat" then
        TextLabel.TextColor3 = Color3.fromRGB(15, 15, 18)
        Logo.ImageColor3 = Color3.fromRGB(15, 15, 18)
    end
end

-- สั่งเริ่มงานรันจำลองปุ่มเมนูด้านซ้ายครบทั้ง 10 แท็บระบบ
setupTabButton("Combat")
setupTabButton("Visuals")
setupTabButton("Settings")
setupTabButton("UI")
setupTabButton("Status")
setupTabButton("Script Hub")
setupTabButton("Music")
setupTabButton("Ability Detections")
setupTabButton("What's New")

-- สั่งจัดระเบียบบล็อกเรียงลำดับแนวตั้งแบบอัตโนมัติภายใน Sidebar Container
SidebarLayout = Instance.new("UIListLayout", Sidebar)
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Padding = UDim.new(0, 9)

SidebarPadding = Instance.new("UIPadding", Sidebar)
SidebarPadding.PaddingTop = UDim.new(0, 15)

-- =======================================================================
-- 🎛️ RISE WHITE STYLE TOGGLE SWITCH SYSTEM (PART 3 - SECTION 1)
-- =======================================================================
function enable_toggle(Checkbox)
    if not Checkbox then return end
    TweenService:Create(Checkbox.Fill, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
    TweenService:Create(Checkbox.Glow, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
    TweenService:Create(Checkbox.Checkmark, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
end

function disable_toggle(Checkbox)
    if not Checkbox then return end
    TweenService:Create(Checkbox.Fill, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
    TweenService:Create(Checkbox.Glow, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageTransparency = 1}):Play()
    TweenService:Create(Checkbox.Checkmark, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageTransparency = 1}):Play()
end

function update_toggle(state, toggle)
    if not toggle or not toggle:FindFirstChild("Checkbox") then return end
    if state then
        enable_toggle(toggle.Checkbox)
    else
        disable_toggle(toggle.Checkbox)
    end
end

-- =======================================================================
-- 🎛️ RISE WHITE STYLE TOGGLE SWITCH SYSTEM (DYNAMIC DATA INJECTOR)
-- =======================================================================
function createToggle(name, stateKey, parentFrame)
    -- 📐 รองรับเกตเวย์ตัวแปรเดิม หากส่งมาไม่ตรงล็อก ให้ระบบช่วยดึงตัวกระจายแท็บมารับช่วงต่อ
    local section = parentFrame or combatScroll
    
    local toggle = Instance.new("TextButton")
    toggle.Name = "Toggle"
    toggle.Parent = section
    toggle.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
    toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
    toggle.BorderSizePixel = 0
    toggle.Size = UDim2.new(0, 215, 0, 37)
    toggle.AutoButtonColor = false
    toggle.Font = Enum.Font.SourceSans
    toggle.Text = ""
    toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
    toggle.TextSize = 14.000
    toggle.ZIndex = 4

    local toggleCorner = Instance.new("UICorner", toggle)
    toggleCorner.CornerRadius = UDim.new(0, 10)

    local Checkbox = Instance.new("Frame", toggle)
    Checkbox.Name = "Checkbox"
    Checkbox.AnchorPoint = Vector2.new(0.5, 0.5)
    Checkbox.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
    Checkbox.BorderSizePixel = 0
    Checkbox.Position = UDim2.new(0.915, 0, 0.5, 0)
    Checkbox.Size = UDim2.new(0, 17, 0, 17)
    Checkbox.ZIndex = 5

    local CheckboxCorner = Instance.new("UICorner", Checkbox)
    CheckboxCorner.CornerRadius = UDim.new(0, 4)

    local Glow = Instance.new("ImageLabel", Checkbox)
    Glow.Name = "Glow"
    Glow.AnchorPoint = Vector2.new(0.5, 0.5)
    Glow.BackgroundTransparency = 1.000
    Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Glow.Size = UDim2.new(0, 27, 0, 27)
    Glow.Image = "rbxassetid://17290798394"
    Glow.ImageColor3 = Color3.fromRGB(255, 255, 255) -- ออร่าสีขาวมินิมอล
    Glow.ImageTransparency = 1.000
    Glow.ZIndex = 5

    local Checkmark = Instance.new("ImageLabel", Checkbox)
    Checkmark.Name = "Checkmark"
    Checkmark.AnchorPoint = Vector2.new(0.5, 0.5)
    Checkmark.BackgroundTransparency = 1.000
    Checkmark.Position = UDim2.new(0.5, 0, 0.5, 0)
    Checkmark.Size = UDim2.new(0, 15, 0, 15)
    Checkmark.Image = "rbxassetid://9754130783" -- ไอคอนขีดเครื่องหมายถูก
    Checkmark.ImageColor3 = Color3.fromRGB(15, 15, 18) -- เครื่องหมายถูกสีเข้มตัดกับสีปุ่มสว่าง
    Checkmark.ImageTransparency = 1.000
    Checkmark.ZIndex = 7

    local Fill = Instance.new("Frame", Checkbox)
    Fill.Name = "Fill"
    Fill.AnchorPoint = Vector2.new(0.5, 0.5)
    Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Fill.BackgroundTransparency = 1.000
    Fill.BorderSizePixel = 0
    Fill.Position = UDim2.new(0.5, 0, 0.5, 0)
    Fill.Size = UDim2.new(0, 17, 0, 17)
    Fill.ZIndex = 6

    local FillCorner = Instance.new("UICorner", Fill)
    FillCorner.CornerRadius = UDim.new(0, 4)

    local UIGradient = Instance.new("UIGradient", Fill)
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), 
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(180, 165, 170))
    }
    UIGradient.Rotation = 20

    local TextLabel = Instance.new("TextLabel", toggle)
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.Position = UDim2.new(0.445, 0, 0.5, 0)
    TextLabel.Size = UDim2.new(0, 164, 0, 15)
    TextLabel.ZIndex = 5
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextScaled = true
    TextLabel.TextSize = 14.000
    TextLabel.TextWrapped = true
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Text = name

    -- 🔁 [สร้างสะพานเชื่อมโยงฐานข้อมูล]: บังคับซิงค์ค่า Config ทุกตารางให้อยู่ในสเตทเดียวกัน
    if Config[stateKey] == nil then
        Config[stateKey] = false
    end
    
    -- พิเศษสำหรับคีย์จำเพาะ SkinChanger ให้ดึงจากเกลเบิลแมปปิ้ง
    if stateKey == "SkinChangerEnabled" then
        Config[stateKey] = getgenv().skinChanger or false
    end

    -- สแตนด์บายอัปเดตสเตทสวิตช์แรกเริ่มตามฐานข้อมูลหลัก
    update_toggle(Config[stateKey], toggle)

    -- ฟังก์ชันประมวลผลเมื่อมีการกดคลิกสลับค่าเปิด/ปิด
    local function onToggleFired()
        local newState = not Config[stateKey]
        
        -- เขียนทับค่ากลับไปยังฐานข้อมูลสารบบกลางทั้งหมดพร้อมกันเพื่อความสถียร
        Config[stateKey] = newState
        if _G.Rise and type(_G.Rise) == "table" and _G.Rise.Flags then
            _G.Rise.Flags[stateKey] = newState
        end
        
        -- ตรรกะพิเศษเชื่อมโยงระบบแต่งดาบเดิม
        if stateKey == "SkinChangerEnabled" then
            getgenv().skinChanger = newState
            if type(getgenv().updateSword) == "function" then pcall(getgenv().updateSword) end
        end
        
        -- 🎨 บังคับอัปเดตแอนิเมชันรูปติ๊กถูกทันทีตามค่าสถานะใหม่ที่แท้จริง
        update_toggle(newState, toggle)
        
        if type(CustomNotify) == "function" then
            CustomNotify(name .. " : " .. (newState and "ON" or "OFF"), 1.5)
        end
    end

    toggle.MouseButton1Click:Connect(onToggleFired)

    -- ลงทะเบียนปุ่มไว้ใน Global Table เพื่อให้ระบบ Auto-Load Config สั่งยิงข้อมูลเปิดข้ามระบบได้แม่นยำ
    if not _G.RemoteToggle then _G.RemoteToggle = {} end
    _G.RemoteToggle[stateKey] = function()
        onToggleFired()
    end

    return toggle
end

-- =======================================================================
-- 🔄 RISE WHITE STYLE CYCLE CONTROLLER (PART 4 - SECTION 1)
-- =======================================================================
function animate_cycle_click(designCircle, pulseGlow)
    if not designCircle or not pulseGlow then return end
    
    -- 🎬 แอนิเมชันปุ่มวงกลมยุบตัวและดีดกลับแบบมีสปริง (Squish Elastic)
    designCircle.Size = UDim2.fromOffset(4, 4)
    designCircle.Position = UDim2.new(1, -20, 0.5, -2)
    TweenService:Create(designCircle, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(12, 12),
        Position = UDim2.new(1, -24, 0.5, -6)
    }):Play()

    -- 🎬 สร้างวงแสงระเบิดสะท้อนวูบวาบขยายตัวออกสีขาว (Neon Pulse Ripple Effect)
    pulseGlow.Size = UDim2.fromOffset(12, 12)
    pulseGlow.Position = UDim2.new(1, -24, 0.5, -6)
    pulseGlow.BackgroundTransparency = 0.3
    
    TweenService:Create(pulseGlow, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(28, 28),
        Position = UDim2.new(1, -32, 0.5, -14),
        BackgroundTransparency = 1
    }):Play()
end

-- =======================================================================
-- 🔄 RISE WHITE STYLE CYCLE CONTROLLER (PART 4 - SECTION 2)
-- =======================================================================
function createCycle(name, stateKey, list, parentFrame, onChanged)
    local targetSection = parentFrame or combatScroll
    local cBtn = Instance.new("TextButton", targetSection)
    cBtn.Size = UDim2.new(1, 0, 0, 34)
    cBtn.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
    cBtn.Font = Enum.Font.GothamBold
    cBtn.TextSize = 11
    cBtn.AutoButtonColor = false
    cBtn.ZIndex = 4
    
    local cBtnCorner = Instance.new("UICorner", cBtn)
    cBtnCorner.CornerRadius = UDim.new(0, 6)

    local cStroke = Instance.new("UIStroke", cBtn)
    cStroke.Color = Color3.fromRGB(55, 55, 60)
    cStroke.Thickness = 1
    cStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local pulseGlow = Instance.new("Frame", cBtn)
    pulseGlow.Size = UDim2.fromOffset(12, 12)
    pulseGlow.Position = UDim2.new(1, -24, 0.5, -6)
    pulseGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    pulseGlow.BackgroundTransparency = 1.000 
    pulseGlow.BorderSizePixel = 0
    pulseGlow.ZIndex = 5
    Instance.new("UICorner", pulseGlow).CornerRadius = UDim.new(1, 0)

    local designCircle = Instance.new("Frame", cBtn)
    designCircle.Size = UDim2.fromOffset(12, 12)
    designCircle.Position = UDim2.new(1, -24, 0.5, -6)
    designCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    designCircle.BorderSizePixel = 0
    designCircle.ZIndex = 6
    Instance.new("UICorner", designCircle).CornerRadius = UDim.new(1, 0)

    local function update_cycle_visual()
        if not cBtn or not cBtn.Parent then return end
        cBtn.Text = "  " .. name .. " : [ " .. tostring(Config[stateKey]) .. " ]"
        cBtn.TextColor3 = Color3.fromRGB(230, 230, 235)
        cBtn.TextXAlignment = Enum.TextXAlignment.Left

        if stateKey == "UIBackground" then
            local colors = {
                DARK = Color3.fromRGB(12, 12, 16), RED = Color3.fromRGB(45, 10, 18),
                BLUE = Color3.fromRGB(10, 20, 45), PURPLE = Color3.fromRGB(30, 15, 45),
                GREEN = Color3.fromRGB(10, 40, 25), ORANGE = Color3.fromRGB(50, 25, 10)
            }
            local selectedColor = colors[Config[stateKey]]
            if selectedColor and MainFrame then
                TweenService:Create(MainFrame, TweenInfo.new(0.3), {BackgroundColor3 = selectedColor}):Play()
                if MenuBgImage then MenuBgImage.Visible = true end -- บังคับให้พื้นหลังโชว์คู่ขนานเสมอ
            end
        end
    end

    cBtn.MouseButton1Click:Connect(function()
        local idx = table.find(list, Config[stateKey]) or 1
        Config[stateKey] = list[idx + 1 > #list and 1 or idx + 1]
        animate_cycle_click(designCircle, pulseGlow)
        update_cycle_visual()
        if onChanged then pcall(onChanged, Config[stateKey]) end
    end)

    cBtn.MouseEnter:Connect(function()
        TweenService:Create(cBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 36, 43)}):Play()
        TweenService:Create(cStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(255, 255, 255)}):Play()
    end)
    cBtn.MouseLeave:Connect(function()
        TweenService:Create(cBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(27, 28, 33)}):Play()
        TweenService:Create(cStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(55, 55, 60)}):Play()
    end)

    update_cycle_visual()
    return cBtn
end

-- =======================================================================
-- 💥 RISE WHITE STYLE ACTION BUTTON ENGINE (PART 5)
-- =======================================================================
function createActionBtn(text, color, callbackFunction, parentFrame)
    -- 📐 [COMPATIBILITY FIX]: รองรับเกตเวผู้พ่อแม่เดิม หากส่งมาไม่ตรงล็อก ให้ระบบช่วยดึงตัวกระจายแท็บมารับช่วงต่อ
    section = parentFrame or combatScroll
    
    btn = Instance.new("TextButton", section)
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = color or Color3.fromRGB(27, 28, 33)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.Text = "  " .. text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextXAlignment = Enum.TextXAlignment.Left -- จัดตัวอักษรชิดซ้ายมินิมอลตามสไตล์ดั้งเดิม
    btn.AutoButtonColor = false -- ปิดเอฟเฟกต์มืดของระบบดั้งเดิม เพื่อใช้แอนิเมชันเกลี่ยสีแทน
    btn.ZIndex = 4

    btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 6)

    -- เส้นขอบบางเพิ่มมิติปุ่ม
    stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(55, 55, 60)
    stroke.Thickness = 1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    -- สัญลักษณ์หัวลูกศรหรือไอคอนระบุแอคชั่นด้านขวาสุด (Action Arrow Indicator)
    Buttonmark = Instance.new("ImageLabel", btn)
    Buttonmark.Name = "Buttonmark"
    Buttonmark.AnchorPoint = Vector2.new(0.5, 0.5) 
    Buttonmark.BackgroundTransparency = 1.000
    Buttonmark.BorderSizePixel = 0
    Buttonmark.Position = UDim2.new(0.935, 0, 0.5, 0)
    Buttonmark.Size = UDim2.new(0, 14, 0, 14)
    Buttonmark.Image = "rbxassetid://3944703587" -- ไอคอนลูกศรชี้ขวาสไตล์ Rise UI
    Buttonmark.ImageColor3 = Color3.fromRGB(255, 255, 255)
    Buttonmark.ZIndex = 5

    -- เก็บค่าสีดั้งเดิมไว้สำหรับอนิเมชันตอนเมาส์เลื่อนออก
    originalColor = btn.BackgroundColor3
    -- คำนวณค่าสีโฮเวอร์ (Hover Color) ให้สว่างขึ้นกว่าสีปุ่มเดิม 15% โดยอัตโนมัติ เพื่อความพรีเมียม
    h, s, v = originalColor:ToHSV()
    hoverColor = Color3.fromHSV(h, s, math.clamp(v * 1.15, 0, 1))

    -- ⚡ แอนิเมชันขยายตัวและเกลี่ยสีเมื่อเมาส์ชี้หรือนิ้วสัมผัสโดน (Hover Scale & Color Fade)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = hoverColor
        }):Play()
        TweenService:Create(stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(255, 255, 255)}):Play()
        TweenService:Create(Buttonmark, TweenInfo.new(0.2), {Position = UDim2.new(0.945, 0, 0.5, 0)}):Play() -- ขยับลูกศรไปข้างหน้าเล็กน้อยเพิ่มมิติ
    end)

    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            BackgroundColor3 = originalColor
        }):Play()
        TweenService:Create(stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(55, 55, 60)}):Play()
        TweenService:Create(Buttonmark, TweenInfo.new(0.2), {Position = UDim2.new(0.935, 0, 0.5, 0)}):Play()
    end)

    -- แอนิเมชันยุบตัวตอบสนองตอนกดจิ้มเมาส์/สัมผัส (Click Compression Impact)
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Size = UDim2.new(0.98, 0, 0, 32)}):Play()
        end
    end)

    btn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 34)}):Play()
        end
    end)

    -- ⚡ ผูกเหตุการณ์: เรียกใช้งาน callbackFunction ทันทีเมื่อคลิกเสร็จสิ้น
    btn.MouseButton1Click:Connect(function()
        if callbackFunction and type(callbackFunction) == "function" then
            pcall(callbackFunction)
        end
    end)

    return btn
end

-- 📐 [RE-MAPPING ALIAS]: ผูกชื่อฟังก์ชัน createAction เพิ่มเข้าไปในระบบ Global 
-- เพื่อให้โค้ดส่วนอื่นที่เรียกใช้ด้วยชื่อ createAction สามารถสั่งงานปุ่มนี้ได้ทันทีโดยไม่พัง
createAction = createActionBtn

TweenService = game:GetService("TweenService")

-- =======================================================================
-- 📋 RISE WHITE STYLE DROPDOWN / SELECT SYSTEM (FULLY FIXED SYNTAX)
-- =======================================================================
function createSelect(labelText, defaultOption, optionsList, parentFrame, onSelectionChanged)
    local dropSection = parentFrame or combatScroll
    local currentSelected = defaultOption or (optionsList and optionsList[1]) or "None"
    local isDropdownOpen = false

    local selectContainer = Instance.new("Frame", dropSection)
    selectContainer.Size = UDim2.new(1, 0, 0, 34)
    selectContainer.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
    selectContainer.ZIndex = 4

    local containerStroke = Instance.new("UIStroke", selectContainer)
    containerStroke.Color = Color3.fromRGB(55, 55, 60)
    containerStroke.Thickness = 1
    containerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local label = Instance.new("TextLabel", selectContainer)
    label.Size = UDim2.new(0, 0, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText or "Select:"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.AutomaticSize = Enum.AutomaticSize.X 
    label.ZIndex = 5

    local selectButton = Instance.new("TextButton", selectContainer)
    selectButton.BackgroundTransparency = 1
    selectButton.Text = tostring(currentSelected)
    selectButton.TextColor3 = Color3.fromRGB(240, 240, 245)
    selectButton.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
    selectButton.TextSize = 11
    selectButton.TextXAlignment = Enum.TextXAlignment.Left
    selectButton.ZIndex = 6

    local Arrow = Instance.new("ImageLabel", selectContainer)
    Arrow.Name = "Arrow"
    Arrow.AnchorPoint = Vector2.new(0.5, 0.5)
    Arrow.BackgroundTransparency = 1.000
    Arrow.Position = UDim2.new(0.935, 0, 0.5, 0)
    Arrow.Size = UDim2.new(0, 12, 0, 12)
    Arrow.Image = "rbxassetid://17400678941"
    Arrow.ImageColor3 = Color3.fromRGB(255, 255, 255)
    Arrow.ZIndex = 5

    label:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        pcall(function()
            local labelWidth = label.AbsoluteSize.X
            selectButton.Position = UDim2.new(0, 12 + labelWidth + 8, 0, 0)
            selectButton.Size = UDim2.new(1, -(12 + labelWidth + 8 + 35), 1, 0)
        end)
    end)

    local listContainer = Instance.new("Frame")
    listContainer.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
    listContainer.BorderSizePixel = 0
    listContainer.ZIndex = 10000 
    listContainer.Visible = false
    Instance.new("UICorner", listContainer).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", listContainer).Color = Color3.fromRGB(55, 55, 75)

    local scrollFrame = Instance.new("ScrollingFrame", listContainer)
    scrollFrame.Size = UDim2.new(1, -4, 1, -4)
    scrollFrame.Position = UDim2.new(0, 2, 0, 2)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 0
    scrollFrame.ZIndex = 10001

    local listLayout = Instance.new("UIListLayout", scrollFrame)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 4)

    local screenGui = dropSection:FindFirstAncestorOfClass("ScreenGui")
    if screenGui then listContainer.Parent = screenGui end

    local function updateDropdownPosition()
        if not selectButton or not selectButton.Parent then return end
        local cam = workspace.CurrentCamera
        if cam then
            local buttonAbsPos = selectButton.AbsolutePosition
            local buttonAbsSize = selectButton.AbsoluteSize
            local expectedListHeight = math.clamp(listLayout.AbsoluteContentSize.Y + 12, 34, 160)
            listContainer.Position = UDim2.fromOffset(buttonAbsPos.X - 10, buttonAbsPos.Y + buttonAbsSize.Y + 4)
            listContainer.Size = UDim2.fromOffset(buttonAbsSize.X + 25, expectedListHeight)
            scrollFrame.CanvasSize = UDim2.fromOffset(0, listLayout.AbsoluteContentSize.Y + 12)
        end
    end

    local function refreshDropdownOptions()
        for _, item in ipairs(scrollFrame:GetChildren()) do
            if item:IsA("TextButton") then item:Destroy() end
        end
        for _, optionName in ipairs(optionsList or {}) do
            local isCurrent = (tostring(optionName) == tostring(currentSelected))
            local optBtn = Instance.new("TextButton", scrollFrame)
            optBtn.Size = UDim2.new(1, -8, 0, 26)
            optBtn.BackgroundColor3 = isCurrent and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(27, 28, 33)
            optBtn.BackgroundTransparency = isCurrent and 0.1 or 1.0 
            optBtn.Text = "  " .. tostring(optionName)
            optBtn.TextColor3 = isCurrent and Color3.fromRGB(15, 15, 18) or Color3.fromRGB(230, 230, 235)
            optBtn.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
            optBtn.TextSize = 11
            optBtn.TextXAlignment = Enum.TextXAlignment.Left
            optBtn.ZIndex = 10002
            Instance.new("UICorner", optBtn).CornerRadius = UDim.new(0, 4)

            optBtn.MouseButton1Click:Connect(function()
                currentSelected = optionName
                selectButton.Text = tostring(optionName)
                listContainer.Visible = false
                isDropdownOpen = false
                if onSelectionChanged then pcall(onSelectionChanged, optionName) end
            end)
        end
    end

    selectButton.MouseButton1Click:Connect(function()
        isDropdownOpen = not isDropdownOpen
        if isDropdownOpen then
            refreshDropdownOptions()
            updateDropdownPosition()
            listContainer.Visible = true
        else
            listContainer.Visible = false
        end
    end)

    return {
        SetValue = function(v) currentSelected = v selectButton.Text = tostring(v) end,
        Visible = function(s) selectContainer.Visible = s if not s then listContainer.Visible = false end end
    }
end

-- =======================================================================
-- ⌨️ [FIXED SCOPE] RISE WHITE STYLE TEXTBOX INPUT ENGINE
-- =======================================================================
function createTextBox(labelText, defaultText, arg3, arg4, arg5)
    -- บังคับใช้ local ทุกตัวแปรในฟังก์ชันเพื่อไม่ให้ค่าหลุดไปปนกันใน Global Scope
    local currentKey = nil
    local targetSection = nil
    local focusCallback = nil

    -- 🔍 ตรวจสอบสลับสเตทโครงสร้างอินพุตแบบตัดขาดความสัมพันธ์ตัวแปรเก่า
    if typeof(arg3) == "Instance" or (typeof(arg3) == "nil" and typeof(arg4) == "function") then
        -- [แบบที่ 1: โครงสร้างดั้งเดิม]
        currentKey = tostring(labelText or "DefaultKey") 
        targetSection = arg3 or combatScroll
        focusCallback = arg4
    else
        -- [แบบที่ 2: โครงสร้างอัปเดต]
        currentKey = arg3
        targetSection = arg4 or combatScroll
        focusCallback = arg5
        
        if currentKey == nil or currentKey == "" then
            currentKey = tostring(labelText or "DefaultKey")
        end
    end

    -- 📦 สร้างกรอบเฟรมภายนอก
    local boxContainer = Instance.new("Frame", targetSection)
    boxContainer.Size = UDim2.new(1, 0, 0, 34)
    boxContainer.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
    boxContainer.ZIndex = 4

    local boxCorner = Instance.new("UICorner", boxContainer)
    boxCorner.CornerRadius = UDim.new(0, 6)

    local boxStroke = Instance.new("UIStroke", boxContainer)
    boxStroke.Color = Color3.fromRGB(55, 55, 60)
    boxStroke.Thickness = 1
    boxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    -- 🏷️ ป้ายแสดงหัวข้อข้อความด้านหน้า
    local label = Instance.new("TextLabel", boxContainer)
    label.Size = UDim2.new(0, 0, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText or "Input:"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.AutomaticSize = Enum.AutomaticSize.X 
    label.ZIndex = 5

    -- ⌨️ กล่องรับข้อมูลสำหรับการพิมพ์
    local box = Instance.new("TextBox", boxContainer)
    box.BackgroundTransparency = 1
    box.ZIndex = 6
    
    -- ดึงค่าเริ่มต้นอ้างอิงตรงเฉพาะเจาะจงตามคีย์ของช่องนั้นๆ ไม่แชร์ร่วมกัน
    if Config[currentKey] == nil or Config[currentKey] == "" then
        box.Text = tostring(defaultText or "")
    else
        box.Text = tostring(Config[currentKey])
    end

    box.PlaceholderText = "Type values..."
    box.PlaceholderColor3 = Color3.fromRGB(140, 140, 145)
    box.TextColor3 = Color3.fromRGB(240, 240, 245)
    box.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
    box.TextSize = 11
    box.ClearTextOnFocus = false
    box.ClipsDescendants = true
    box.TextXAlignment = Enum.TextXAlignment.Left

    -- จัดตำแหน่งขนาดกล่องอัตโนมัติเฟรมต่อเฟรม
    label:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        pcall(function()
            local labelWidth = label.AbsoluteSize.X
            box.Position = UDim2.new(0, 12 + labelWidth + 8, 0, 0)
            box.Size = UDim2.new(1, -(12 + labelWidth + 8 + 15), 1, 0)
        end)
    end)

    -- ฟังก์ชันสำหรับอัปเดตและจำแนกบันทึกค่าแยกขาดรายช่อง (Isolate Callback Process)
    local function applyTextBoxValue(text)
        local numericValue = tonumber(text)
        Config[currentKey] = numericValue or text 
        
        if focusCallback then 
            pcall(focusCallback, Config[currentKey]) 
        end
        if type(AutoSaveConfig) == "function" then 
            pcall(AutoSaveConfig) 
        end
    end

    box.Focused:Connect(function() 
        TweenService:Create(boxStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(255, 255, 255)}):Play()
    end)
    
    box.FocusLost:Connect(function(enterPressed)
        TweenService:Create(boxStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(55, 55, 60)}):Play()
        applyTextBoxValue(box.Text)
    end)

    -- 🔒 ลงทะเบียนลงสารบบแอดออนโหลดเซฟแยกชื่อคีย์ขาดจากกันอย่างชัดเจนตามวง local
    if not _G.RemoteTextBox then _G.RemoteTextBox = {} end
    _G.RemoteTextBox[currentKey] = function(newValue)
        box.Text = tostring(newValue)
        applyTextBoxValue(box.Text)
    end

    return box
end

-- =======================================================================
-- 🏷️ RISE WHITE STYLE LABEL SYSTEM (FIXED LAYOUTORDER POSITION)
-- =======================================================================
function createLabel(text, parentFrame)
    local section = parentFrame or combatScroll

    -- 📦 สร้างกรอบเฟรมเพื่อช่วยเว้นระยะห่างบน-ล่าง (Spacer Container)
    local labelContainer = Instance.new("Frame", section)
    labelContainer.Name = "LabelContainer_" .. tostring(text:gsub("%s+", ""))
    labelContainer.Size = UDim2.new(1, 0, 0, 24) -- เว้นช่องไฟความสูงไว้ที่ 24px
    labelContainer.BackgroundTransparency = 1
    labelContainer.BorderSizePixel = 0
    labelContainer.ZIndex = 4

    -- 🛑 [FORCE ROW BREAK]: บังคับสัดส่วนแนวกว้างเต็มพื้นที่หน้าจอ 100% ไม่ให้ปุ่มอื่นขึ้นมาขี่
    local gridBreaker = Instance.new("UIAspectRatioConstraint", labelContainer)
    gridBreaker.AspectRatio = 99999 
    
    -- ✨ [FIXED LAYOUTORDER]: บังคับใช้ระบบดักคิวตามเวลาเกิดจริงใน Thread
    -- เปลี่ยนจากการนับจำนวนปุ่มดั้งเดิม มาเป็นตัวเลขลบย้อนกลับ หรือปล่อยให้มันลื่นไหลตามตำแหน่งบรรทัดที่พิมพ์ในสคริปต์
    local nextOrder = 0
    for _, child in ipairs(section:GetChildren()) do
        if child:IsA("GuiObject") and child.LayoutOrder >= nextOrder then
            nextOrder = child.LayoutOrder + 1
        end
    end
    labelContainer.LayoutOrder = nextOrder

    local lbl = Instance.new("TextLabel", labelContainer)
    lbl.Size = UDim2.new(1, -8, 1, 0)
    lbl.Position = UDim2.new(0, 4, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = string.upper(tostring(text)) -- แปลงหัวข้อเป็นตัวพิมพ์ใหญ่ทั้งหมดสไตล์พรีเมียม
    lbl.TextColor3 = Color3.fromRGB(180, 180, 185) -- สีเทาขาวสว่างมินิมอลตัดกับพื้นหลังมืด
    lbl.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Center -- จัดกึ่งกลางเพื่อความเป็นหมวดหมู่ที่ชัดเจน
    lbl.TextYAlignment = Enum.TextYAlignment.Center
    lbl.ZIndex = 5

    -- 🛡️ สร้าง Frame ล่องหนขนาดจิ๋วคอยตัดแถว (Line Break) ด้านหลังให้ปุ่มถัดไปเริ่มที่บรรทัดใหม่เสมอ
    local dummySpacer = Instance.new("Frame", section)
    dummySpacer.Name = "InvisGridSpacer"
    dummySpacer.Size = UDim2.new(1, 0, 0, 1)
    dummySpacer.BackgroundTransparency = 1
    dummySpacer.BorderSizePixel = 0
    dummySpacer.LayoutOrder = nextOrder + 1
    local dummyConstraint = Instance.new("UIAspectRatioConstraint", dummySpacer)
    dummyConstraint.AspectRatio = 99999

    return lbl
end

-- 🟢 สร้างตัวแปรข้อความ (TextLabels) รอไว้สำหรับอัปเดตข้อมูลสถานะ
createLabel("REAL-TIME MATCH STATUS", statusScroll)

-- =======================================================================
-- 📊 RISE WHITE STYLE STATUS CARD ENGINE (PART 9)
-- =======================================================================
function createStatusCard(title, defaultText)
    -- 📐 [COMPATIBILITY FIX]: ปลายทางล็อกเข้าหน้า statusScroll อัตโนมัติ ป้องกันบอร์ดหลุด
    section = statusScroll or combatScroll

    card = Instance.new("Frame", section)
    card.Size = UDim2.new(1, 0, 0, 34)
    card.BackgroundColor3 = Color3.fromRGB(22, 23, 27) -- สีพื้นหลังกล่องมืดสไตล์ Rise UI
    card.BackgroundTransparency = 0.3 -- เปิดความโปร่งแสงใสเล็กน้อยให้เห็นมิติวอลเปเปอร์ภูเขาด้านหลัง
    card.ZIndex = 4
    
    cardCorner = Instance.new("UICorner", card)
    cardCorner.CornerRadius = UDim.new(0, 6)
    
    cardStroke = Instance.new("UIStroke", card)
    cardStroke.Color = Color3.fromRGB(55, 55, 60) -- เส้นขอบขาวใสบางเฉียบมินิมอล
    cardStroke.Thickness = 1
    cardStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    lbl = Instance.new("TextLabel", card)
    lbl.Size = UDim2.new(1, -16, 1, 0)
    lbl.Position = UDim2.new(0, 8, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "  " .. tostring(title) .. " : " .. tostring(defaultText)
    lbl.TextColor3 = Color3.fromRGB(245, 245, 250) -- ตัวอักษรสีขาวนวลอ่านง่าย
    lbl.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold) -- ฟอนต์ Montserrat ตัวหนาของ Rise
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 5
    
    -- 🛡️ [RICH-TEXT & REAL-TIME OBSERVER]: ลูปย่อยดักฟังเพื่อจัดแต่งข้อความอัตโนมัติ
    -- เมื่อมีการเปลี่ยนข้อความ (เช่น สปีดบอลขยับ) จะเน้นสีค่าพลังให้เป็นสีขาวสว่างเด่นชัดขึ้นทันที
    lbl:GetPropertyChangedSignal("Text"):Connect(function()
        pcall(function()
            rawText = lbl.Text
            if not rawText:find(":") then return end
            -- ตรวจสอบหากยังไม่ได้ครอบโครงสร้างข้อความ ให้ข้ามคำสั่งเพื่อป้องกันลูปซ้อน
            if rawText:find("<font") then return end
            
            parts = rawText:split(":")
            mainTitle = parts[1] or ""
            valueText = parts[2] or ""
            
            -- บังคับจัดฟอร์แมตใช้ข้อความสีเทาขาวคู่กับค่าพลังสีขาวสว่างทะลุจอ
            lbl.RichText = true
            lbl.Text = string.format("<font color='rgb(180,180,185)'>%s :</font><font color='rgb(255,255,255)'>%s</font>", mainTitle, valueText)
        end)
    end)

    return lbl
end

Stat_BallSpeed = createStatusCard("Ball Speed", "0.00")
Stat_TimeToHit  = createStatusCard("Time To Hit", "0.00s")
Stat_Target     = createStatusCard("Your Target", "None")
Stat_Nearest    = createStatusCard("Nearest Player", "None")
Stat_Farthest   = createStatusCard("Farthest Player", "None")

-- ═══ COMBAT CONTROLS ═══
createToggle("Auto Parry (Best)", "AutoParry", combatScroll)
createToggle("🧠 AI Auto Parry (Learning)", "AI_AutoParry", combatScroll)
-- =======================================================================
-- ⌨️ CREATE TEXTBOX FOR PARRY SUCCESS RESET COOLDOWN
-- =======================================================================
createLabel("cooldown for auto parry", combatScroll)

createTextBox("cooldown for auto parry", tostring(Config.ResetCooldownTime or 0.12), "ResetCooldownTime", combatScroll, function(val)
    local n = tonumber(val)
    if n then
        -- ล็อกเซฟตี้โซนไว้ไม่ให้กรอกค่าน้อยเกินจนบั๊ก หรือมากเกินจนบอทไม่ทำงาน (0.001 - 2.0 วินาที)
        Config.ResetCooldownTime = math.clamp(n, 0.001, 2.0)
        
        if type(CustomNotify) == "function" then 
            CustomNotify("⏳ Reset Cooldown adjusted to: " .. tostring(Config.ResetCooldownTime) .. "s", 2.5) 
        end
    else
        if type(CustomNotify) == "function" then 
            CustomNotify("❌ Invalid Number! Please enter a valid decimal (e.g. 0.12)", 2.5) 
        end
    end
end)
createLabel("Don't use AI + First Auto parry", combatScroll)
-- =======================================================================
-- 🤖 INVIS AI AUTO-PARRY SYSTEM (PART 1: FIXED CALIBRATION ENGINE)
-- =======================================================================
HttpService = game:GetService("HttpService")
StatsService = game:GetService("Stats")
RunService = game:GetService("RunService")
LocalPlayer = game:GetService("Players").LocalPlayer

-- 📦 ประกาศสเตตัสเริ่มต้นแบบ Global (ห้ามใช้ local) 
ServerOs = 0
Config.ai_time = 0.35
Time = Config.ai_time
PlusOrDel = 0

clientSentTickStamp = 0

AI_Config = {
    FileName = "InvisAI_CalculatedTime.json"
}

function LoadAIMemory()
    pcall(function()
        if isfile and isfile(AI_Config.FileName) then
            fileContent = readfile(AI_Config.FileName)
            decoded = HttpService:JSONDecode(fileContent)
            if decoded and decoded.Saved_Time_Value then
                Time = decoded.Saved_Time_Value
            end
        end
    end)
end

function SaveAIMemory()
    pcall(function()
        if writefile then
            saveData = { Saved_Time_Value = Time }
            encoded = HttpService:JSONEncode(saveData)
            writefile(AI_Config.FileName, encoded)
        end
    end)
end

-- 📐 function calculatorThis คำนวณหาผลต่างโดยเทียบกับฐานคงที่ 0.3 เสมอ
function calculatorThis()
    PlusOrDel = ServerOs - Config.ai_time
end

-- 📐 function calculatorTime ปรับปรุงตัวแปร Time ให้สมดุลเป็นลบ เพื่อไม่ให้สับไม้ลมล่วงหน้า
function calculatorTime()
    calculatedResult = Config.ai_time - PlusOrDel
    
    -- ล็อกเซฟตี้โซนขอบเขตขั้นต่ำ-สูงสุดของตัวแปรใช้งานจริง (Time) เพื่อความเสถียร
    Time = math.clamp(calculatedResult, 0.3, 1)
end

-- 📡 ดักจับสัญญาณเน็ตเวิร์กเมื่อเซิร์ฟเวอร์ตอบกลับว่าตีสำเร็จเพื่อทำการคำนวณย้อนกลับ
pcall(function()
    game:GetService("ReplicatedStorage").Remotes.ParrySuccessAll.OnClientEvent:Connect(function(_, ballPart, swordName, playerName)
        if Config.AI_AutoParry and tostring(playerName) == LocalPlayer.Name and clientSentTickStamp > 0 then
            serverReturnedTick = os.clock()
            
            -- ServerOs = หลังจากที่เรา กดตีไปแล้วจนถึง server ตอบกลับ
            ServerOs = serverReturnedTick - clientSentTickStamp
            
            -- กรองค่าเออเรอร์กรณีปิงแกว่งหลุดขอบเกินจริง
            if ServerOs > 0 and ServerOs < 0.65 then
                calculatorThis()
                calculatorTime()
                
                SaveAIMemory()
            end
            clientSentTickStamp = 0
        end
    end)
end)

originalFireParryRemote = Auto_Parry.FireParryRemote
function Auto_Parry.FireParryRemote(isSpam)
    if Config.AI_AutoParry and not isSpam then
        clientSentTickStamp = os.clock()
    end
    if originalFireParryRemote then originalFireParryRemote(isSpam) end
end

task.spawn(LoadAIMemory)

-- =======================================================================
-- 🧠🤖 GOD-MODE BALANCED AI ENGINE (PART 2: BALANCED TIME INTERCEPT LOOP)
-- =======================================================================
task.spawn(function()
    while shared._InvisRunning do
        RunService.RenderStepped:Wait()
        
        if Config.AI_AutoParry and shared._InvisRunning then
            if Config.AutoParry then if _G.RemoteToggle and _G.RemoteToggle["AutoParry"] then _G.RemoteToggle["AutoParry"]() end end 
            
            pcall(function()
                ball = type(Auto_Parry) == "table" and type(Auto_Parry.Get_Ball) == "function" and Auto_Parry.Get_Ball()
                if ball and ball.Parent then
                    character = LocalPlayer.Character
                    myHrp = character and character:FindFirstChild("HumanoidRootPart")
                    if not myHrp then return end
                    
                    velocity = ball.AssemblyLinearVelocity
                    zoomies = ball:FindFirstChild("zoomies")
                    if zoomies then velocity = zoomies.VectorVelocity end
                    speed = velocity.Magnitude
                    
                    distance = (myHrp.Position - ball.Position).Magnitude 
                    
                    -- ระบบความปลอดภัยกรณีความเร็วบอลเป็น 0 ป้องกันอาการเธรดค้าง (Division by Zero Fix)
                    reachTime = distance / math.max(speed, 1)
                    
                    ballTargetAttr = ball:GetAttribute("target") or ball:GetAttribute("Target")
                    isTargetingMe = (tostring(ballTargetAttr or "") == LocalPlayer.Name)
                    
                    if not isTargetingMe then return end
                    
                    -- ตรวจสอบวิถีไซด์โค้ง (Curve Ball Check)
                    isBallCurving = false
                    if type(Auto_Parry.Is_Curved) == "function" then 
                        isBallCurving = Auto_Parry.Is_Curved(ball) 
                    end
                    
                    -- ปล่อยผ่านและหลุดลูปเธรดทันทีตราบใดที่บอลยังโค้งอยู่ เพื่อรอทิศทางตรง
                    if isBallCurving then 
                        return 
                    end
                    
                    -- 🎯 ตีก่อนตามเวลา time แล้ว save เพื่อคำนวณไปครั้งต่อไป
                    if reachTime <= Time then
                        if not parryLocked[ball] then
                            speedBasedBurst = (speed > 500) and 4 or 2
                            if speed < 100 then speedBasedBurst = 3 end 
                            
                            for i = 1, speedBasedBurst do 
                                pcall(function() Auto_Parry.FireParryRemote(false) end) 
                            end
                            parryLocked[ball] = true
                            lockTime[ball] = os.clock()
                        end
                    end
                end
            end)
        end
    end
end)

-- =======================================================================
-- 🎯 SMART TRAINING AUTO PARRY (HYBRID MODE + FIXED ANTI-DOUBLE HIT COOLDOWN)
-- =======================================================================
Config.TrainingAutoParry = false 

local lastTrainingHitTime = 0 

local function GetTrainingBallOnly()
    local trainingFolder = workspace:FindFirstChild("TrainingBalls")
    if trainingFolder then
        for _, b in ipairs(trainingFolder:GetChildren()) do
            if b:IsA("BasePart") and (b:GetAttribute("realBall") or b:GetAttribute("target")) then
                return b
            end
        end
    end
    return nil
end

task.spawn(function()
    while true do
        game:GetService("RunService").RenderStepped:Wait() 
        if Config.TrainingAutoParry and shared._InvisRunning then
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                
                local ball = GetTrainingBallOnly()
                if not ball then return end
                
                local targetAttr = ball:GetAttribute("target") or ball:GetAttribute("Target")
                if tostring(targetAttr or "") ~= game.Players.LocalPlayer.Name then return end

                local now = os.clock()
                
                -- 🔒 [FIXED ANTI-DOUBLE HIT]: ล็อกเวลาคูลดาวน์ไม่ให้กดเบิ้ลคลิก (0.45 วินาที)
                -- ตราบใดที่ยังไม่พ้น 0.45 วินาทีหลังจากหวดบอลไปล่าสุด บอทจะไม่กดปุ่มซ้ำในเฟรมนี้เด็ดขาด
                if parryLocked[ball] then
                    local fixedLockCooldown = 0.45 
                    if now - (lockTime[ball] or 0) >= fixedLockCooldown then
                        parryLocked[ball] = false
                    else
                        return -- 🛑 ข้ามเฟรมทันทีเพื่อสกัดกั้นการดับเบิ้ลคลิก
                    end
                end

                local velocity = ball.AssemblyLinearVelocity
                local zoomies = ball:FindFirstChild("zoomies")
                if zoomies then pcall(function() velocity = zoomies.VectorVelocity end) end
                
                local ballSpeed = velocity.Magnitude
                local distance = (hrp.Position - ball.Position).Magnitude
                local triggerParry = false
                
                if ballSpeed <= 120 then
                    local safeZone = math.clamp(8.5 + (ballSpeed * 0.28), 8.5, 45)
                    if distance <= safeZone then triggerParry = true end
                else
                    triggerParry = true 
                end
                
                if triggerParry then
                    if type(Auto_Parry) == "table" and type(Auto_Parry.FireParryRemote) == "function" then
                        -- บันทึกสถานะเวลากดใช้ปัจจุบัน เพื่อนำไปใช้ดักจับในเฟรมถัดไป
                        parryLocked[ball] = true
                        lockTime[ball] = now
                        
                        Auto_Parry.FireParryRemote(false) 
                        if type(shared.InvisClearLock) == "function" then
                            shared.InvisClearLock(ball)
                        end
                    end
                end
            end)
        else
            task.wait(0.05)
        end
    end
end)

createToggle("Training auto parry", "TrainingAutoParry", combatScroll)

createToggle("Soccer Mode", "SoccerMode", combatScroll)
createToggle("immortal", "GodMode", combatScroll)

createToggle("Play Parry Animation Track", "SwordAnimationsEnabled", combatScroll)
createToggle("Auto Spam Clash", "AutoSpam", combatScroll)

-- 1. เพิ่มสถานะและ Config สำหรับ Manual Spam (ใส่ไว้ส่วนบนของสคริปต์)
Config.ManualSpamShow = false  -- ใช้สำหรับคุมปุ่มในเฟรมหลัก (โชว์/ซ่อนปุ่มลอย)
Config.ManualSpamActive = false -- ใช้สำหรับคุมปุ่มลอย (เปิด/ปิดระบบสแปมจริง)

-- =======================================================================
-- 🎨 DEFINE THEME FOR FLOATING BUTTONS (FIX FOR NIL ERROR)
-- =======================================================================
local THEME = getgenv().InvisUI_Theme or {
    Active = Color3.fromRGB(0, 255, 150),
    Inactive = Color3.fromRGB(255, 45, 85),
    Sidebar = Color3.fromRGB(27, 28, 33),
    CardBg = Color3.fromRGB(18, 18, 26),
    Accent = Color3.fromRGB(0, 240, 255),  -- เพิ่มสีฟ้านีออน
    TextMain = Color3.fromRGB(255, 255, 255) -- เพิ่มสีข้อความหลัก (ขาว)
}

if not THEME.Sidebar then THEME.Sidebar = Color3.fromRGB(27, 28, 33) end
-- =======================================================================

-- 💥 [BUG IMMORTAL CONFIG & VARIABLES]
Config.BugImmortalShow = false
Config.BugImmortalActive = false
local lastBugImmortalActiveTime = 0
local bugImmortalBufferDelay = 1.0 -- หน่วงเวลาคงสถานะต่อ 1 วินาทีหลังกดหยุด

-- 🔘 สร้างปุ่มลอยชิ้นที่ 4 (Network Bug Immortal) สี่เหลี่ยมมนขาวนวลเข้าเซ็ตเดิม
local FloatingBugImmortalBtn = Instance.new("TextButton", ScreenGui)
FloatingBugImmortalBtn.Name = "Invis_BugImmortalSpamBtn"
FloatingBugImmortalBtn.Size = UDim2.new(0, 52, 0, 52)
FloatingBugImmortalBtn.Position = UDim2.new(0.85, 0, 0.70, 0) -- พิกัดแกน Y 0.70 (ไม่ซ้อนกับ 3 ปุ่มแรก)
FloatingBugImmortalBtn.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
FloatingBugImmortalBtn.Text = "BUG\nIMMT"
FloatingBugImmortalBtn.TextColor3 = Color3.fromRGB(15, 15, 18)
FloatingBugImmortalBtn.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
FloatingBugImmortalBtn.TextSize = 9
FloatingBugImmortalBtn.Visible = false
FloatingBugImmortalBtn.AutoButtonColor = false
Instance.new("UICorner", FloatingBugImmortalBtn).CornerRadius = UDim.new(0, 13)

local stroke4 = Instance.new("UIStroke", FloatingBugImmortalBtn)
stroke4.Thickness = 0.5
stroke4.Color = Color3.fromRGB(15, 15, 18)

-- 🌈 เอฟเฟกต์ไฟนีออนวิ่งรอบขอบปุ่มสไตล์ Invis Hub
task.spawn(function()
    while true do
        if stroke4 and stroke4.Parent then
            for i = 0, 1, 0.005 do
                if stroke4 and stroke4.Parent then stroke4.Color = Color3.fromHSV(i, 0.7, 0.9) end
                task.wait(0.04)
            end
        else break end
    end
end)

-- 📌 ระบบลากย้ายปุ่มลอยชิ้นที่ 4 (Anti-Clog Drag Logic)
local drag4, start4, bPos4, mouseStart4, isDragging4 = false, nil, nil, nil, false
FloatingBugImmortalBtn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag4, start4, mouseStart4, bPos4, isDragging4 = true, i.Position, game:GetService("UserInputService"):GetMouseLocation(), FloatingBugImmortalBtn.Position, false
        TweenService:Create(FloatingBugImmortalBtn, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 46, 0, 46)}):Play()
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(i)
    if drag4 and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        if (game:GetService("UserInputService"):GetMouseLocation() - mouseStart4).Magnitude > 5 then isDragging4 = true end
        if isDragging4 then
            local d = i.Position - start4
            local cam = workspace.CurrentCamera
local tx = bPos1.X.Offset + d.X
local ty = bPos1.Y.Offset + d.Y
FloatingSpamBtn.Position = UDim2.new(bPos1.X.Scale, tx, bPos1.Y.Scale, ty)
        end
    end
end)
FloatingBugImmortalBtn.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag4 = false
        TweenService:Create(FloatingBugImmortalBtn, TweenInfo.new(0.3, Enum.EasingStyle.Elastic), {Size = UDim2.new(0, 52, 0, 52)}):Play()
        if not isDragging4 then
            Config.BugImmortalActive = not Config.BugImmortalActive
            if Config.BugImmortalActive then
                FloatingBugImmortalBtn.Text = "BUG\nON"
                FloatingBugImmortalBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                FloatingBugImmortalBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
            else
                FloatingBugImmortalBtn.Text = "BUG\nIMMT"
                FloatingBugImmortalBtn.TextColor3 = Color3.fromRGB(15, 15, 18)
                FloatingBugImmortalBtn.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
            end
            if type(CustomNotify) == "function" then CustomNotify("Network Bug Immortal: " .. (Config.BugImmortalActive and "ACTIVE" or "DISABLED"), 1.5) end
        end
    end
end)

Config.BugImmortalBurstCount = Config.BugImmortalBurstCount or 15
Config.BugImmortalRunFrames = Config.BugImmortalRunFrames or 4
Config.BugImmortalWaitFrames = Config.BugImmortalWaitFrames or 3

if shared.ImmortalBurstThread then task.cancel(shared.ImmortalBurstThread) end
shared.ImmortalBurstThread = task.spawn(function()
    local burstTicker = 0
    
    while shared._InvisRunning do
        game:GetService("RunService").Heartbeat:Wait()
        
        local isEnabledAndActive = (Config.BugImmortalShow == true) and (Config.BugImmortalActive == true)
        local currentTime = os.clock()
        
        if isEnabledAndActive then
            lastBugImmortalActiveTime = currentTime
        end
        
        local shouldRun = isEnabledAndActive or (currentTime - lastBugImmortalActiveTime <= bugImmortalBufferDelay)
        
        if shouldRun then
            burstTicker = burstTicker + 1
            
            -- 🔓 ดึงค่าตรงจากสิ่งที่คุณกรอกในหน้าจอเมนูหลัก โดยไม่มีการล็อกเพดานตัวเลขสูงสุด
            local runFrames = math.max(1, math.floor(tonumber(Config.BugImmortalRunFrames) or 4))
            local waitFrames = math.max(0, math.floor(tonumber(Config.BugImmortalWaitFrames) or 3))
            local totalCycleFrames = runFrames + waitFrames
            local burstCount = math.max(1, math.floor(tonumber(Config.BugImmortalBurstCount) or 15))
            
            -- ตรรกะคำนวณสลับช่วงพักเฟรมเรตแปรผันตรงตามที่คุณกำหนด
            if burstTicker % totalCycleFrames <= runFrames and burstTicker % totalCycleFrames > 0 then
                if type(Auto_Parry) == "table" and type(Auto_Parry.FireParryRemote) == "function" then
                    shared.ManualSpamActive = false 
                    
                    -- 🔥 ระเบิดแพ็กเก็ตอัดแน่นตามจำนวนครั้งที่คุณตั้งค่าไว้แบบไม่จำกัด
                    for i = 1, burstCount do
                        pcall(function()
                            Auto_Parry.FireParryRemote(true)
                        end)
                    end
                end
            end
        else
            burstTicker = 0
            task.wait(0.05)
        end
    end
end)

-- 🔄 ลูปซิงค์ควบคุมการซ่อน/แสดงของปุ่มลอยรวมกับ 3 ปุ่มแรกดั้งเดิมของสคริปต์
task.spawn(function()
    while shared._InvisRunning do
        FloatingBugImmortalBtn.Visible = Config.BugImmortalShow and true or false
        if not Config.BugImmortalShow then 
            Config.BugImmortalActive = false 
            FloatingBugImmortalBtn.Text = "BUG\nIMMT" 
            FloatingBugImmortalBtn.TextColor3 = Color3.fromRGB(15, 15, 18) 
            FloatingBugImmortalBtn.BackgroundColor3 = Color3.fromRGB(245, 245, 250) 
        end
        task.wait(0.1)
    end
end)

createToggle("Network Bug Immortal Floating Button", "BugImmortalShow", combatScroll)
-- 🏷️ ป้ายเมนูปรับแต่งความแรง Network Bug แบบไม่จำกัด
createLabel("BUG IMMORTAL UNLIMITED SETTINGS", combatScroll)

-- 1. TextBox ปรับจำนวนครั้งการส่งข้อมูลในเฟรมเดียวกัน (เซ็ตได้ไม่จำกัด)
createTextBox("Burst Amount (Packets / Frame)", tostring(Config.BugImmortalBurstCount), combatScroll, function(val)
    local n = tonumber(val)
    if n then
        Config.BugImmortalBurstCount = math.max(1, math.floor(n))
        if type(CustomNotify) == "function" then
            CustomNotify("🔥 Burst Count enforced: " .. tostring(Config.BugImmortalBurstCount) .. " packets", 2.5)
        end
    else
        if type(CustomNotify) == "function" then CustomNotify("❌ Please type a valid number!", 2.5) end
    end
end)

-- 2. TextBox ปรับจำนวนเฟรมที่จะทำงาน (เซ็ตได้ไม่จำกัด)
createTextBox("Run Action Duration (Frames)", tostring(Config.BugImmortalRunFrames), combatScroll, function(val)
    local n = tonumber(val)
    if n then
        Config.BugImmortalRunFrames = math.max(1, math.floor(n))
        if type(CustomNotify) == "function" then
            CustomNotify("⏱️ Spam Duration enforced: " .. tostring(Config.BugImmortalRunFrames) .. " frames", 2)
        end
    else
        if type(CustomNotify) == "function" then CustomNotify("❌ Please type a valid number!", 2.5) end
    end
end)

-- 3. TextBox ปรับจำนวนเฟรมที่จะหยุดรอ (เซ็ตได้ไม่จำกัด)
createTextBox("Wait Cooldown (Frames)", tostring(Config.BugImmortalWaitFrames), combatScroll, function(val)
    local n = tonumber(val)
    if n then
        Config.BugImmortalWaitFrames = math.max(0, math.floor(n))
        if type(CustomNotify) == "function" then
            CustomNotify("⏳ Wait Duration enforced: " .. tostring(Config.BugImmortalWaitFrames) .. " frames", 2)
        end
    else
        if type(CustomNotify) == "function" then CustomNotify("❌ Please type a valid number!", 2.5) end
    end
end)

-- =======================================================================
-- 🚀 PART 1: INFINITE SPAM (RISE WHITE FLOATING BUTTON & CORE ENGINE)
-- =======================================================================
Config.ManualSpamShow = false
Config.ManualSpamActive = false

-- 🔘 สร้างปุ่มลอยชิ้นที่ 1 สี่เหลี่ยมมนขาวนวลสไตล์ Rise
local FloatingSpamBtn = Instance.new("TextButton", ScreenGui)
FloatingSpamBtn.Name = "Invis_InfiniteSpamBtn"
FloatingSpamBtn.Size = UDim2.new(0, 52, 0, 52)
FloatingSpamBtn.Position = UDim2.new(0.85, 0, 0.40, 0) -- พิกัดแกน Y 0.40
FloatingSpamBtn.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
FloatingSpamBtn.Text = "INF\nSPAM"
FloatingSpamBtn.TextColor3 = Color3.fromRGB(15, 15, 18)
FloatingSpamBtn.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
FloatingSpamBtn.TextSize = 9
FloatingSpamBtn.Visible = false
FloatingSpamBtn.AutoButtonColor = false
Instance.new("UICorner", FloatingSpamBtn).CornerRadius = UDim.new(0, 13)

local stroke1 = Instance.new("UIStroke", FloatingSpamBtn)
stroke1.Thickness = 0.5
stroke1.Color = Color3.fromRGB(15, 15, 18)

-- 🌈 เอฟเฟกต์ไฟนีออนวิ่งรอบขอบปุ่มช้า ๆ
task.spawn(function()
    while true do
        if stroke1 and stroke1.Parent then
            for i = 0, 1, 0.005 do
                if stroke1 and stroke1.Parent then stroke1.Color = Color3.fromHSV(i, 0.7, 0.9) end
                task.wait(0.04)
            end
        else break end
    end
end)

-- 📌 ระบบลากปุ่มลอยชิ้นที่ 1
local drag1, start1, bPos1, mouseStart1, isDragging1 = false, nil, nil, nil, false
FloatingSpamBtn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag1, start1, mouseStart1, bPos1, isDragging1 = true, i.Position, game:GetService("UserInputService"):GetMouseLocation(), FloatingSpamBtn.Position, false
        TweenService:Create(FloatingSpamBtn, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 46, 0, 46)}):Play()
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(i)
    if drag1 and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        if (game:GetService("UserInputService"):GetMouseLocation() - mouseStart1).Magnitude > 5 then isDragging1 = true end
        if isDragging1 then
            local d = i.Position - start1
            local cam = workspace.CurrentCamera
            local tx = math.clamp(bPos1.X.Offset + d.X, 0, cam and cam.ViewportSize.X - 52 or 800)
            local ty = math.clamp(bPos1.Y.Offset + d.Y, 0, cam and cam.ViewportSize.Y - 52 or 600)
            FloatingSpamBtn.Position = UDim2.new(bPos1.X.Scale, tx, bPos1.Y.Scale, ty)
        end
    end
end)
FloatingSpamBtn.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag1 = false
        TweenService:Create(FloatingSpamBtn, TweenInfo.new(0.3, Enum.EasingStyle.Elastic), {Size = UDim2.new(0, 52, 0, 52)}):Play()
        if not isDragging1 then
            Config.ManualSpamActive = not Config.ManualSpamActive
            if Config.ManualSpamActive then
                FloatingSpamBtn.Text = "INF\nON"
                FloatingSpamBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                FloatingSpamBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
            else
                FloatingSpamBtn.Text = "INF\nSPAM"
                FloatingSpamBtn.TextColor3 = Color3.fromRGB(15, 15, 18)
                FloatingSpamBtn.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
            end
            if type(CustomNotify) == "function" then CustomNotify("Infinite Spam: " .. (Config.ManualSpamActive and "ACTIVE" or "DISABLED"), 1.5) end
        end
    end
end)

-- 🚀 ลูปประมวลผลความเร็วสูงยิงแพ็กเก็ตสแปมชิ้นที่ 1
task.spawn(function()
    while shared._InvisRunning do
        if Config.ManualSpamActive and Config.ManualSpamShow then
            local ball = Auto_Parry.Get_Ball()
            if ball and ball.Parent and type(Auto_Parry.FireParryRemote) == "function" then
                local batch = math.clamp(tonumber(Config.packetBatchSize) or 16, 1, 1000)
                local interval = 1 / batch
                coroutine.wrap(function()
                    for i = 1, batch do
                        if not Config.ManualSpamActive or not Config.ManualSpamShow then break end
                        pcall(Auto_Parry.FireParryRemote, true)
                        pcall(Auto_Parry.FireParryRemote, true)
                        pcall(Auto_Parry.FireParryRemote, true)
                        task.wait(interval)
                    end
                end)()
            end
            task.wait(0)
        else task.wait(0.1) end
    end
end)

-- =======================================================================
-- 🚀 PART 2: TRAINING SPAM (RISE WHITE FLOATING BUTTON & CORE ENGINE)
-- =======================================================================
Config.TrainingManualSpamShow = false
Config.TrainingManualSpamActive = false

-- 🔘 สร้างปุ่มลอยชิ้นที่ 2 สี่เหลี่ยมมนขาวนวลสไตล์ Rise
local FloatingTrainingSpamBtn = Instance.new("TextButton", ScreenGui)
FloatingTrainingSpamBtn.Name = "Invis_TrainingSpamBtn"
FloatingTrainingSpamBtn.Size = UDim2.new(0, 52, 0, 52)
FloatingTrainingSpamBtn.Position = UDim2.new(0.85, 0, 0.50, 0) -- พิกัดแกน Y 0.50
FloatingTrainingSpamBtn.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
FloatingTrainingSpamBtn.Text = "TRAIN\nSPAM"
FloatingTrainingSpamBtn.TextColor3 = Color3.fromRGB(15, 15, 18)
FloatingTrainingSpamBtn.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
FloatingTrainingSpamBtn.TextSize = 9
FloatingTrainingSpamBtn.Visible = false
FloatingTrainingSpamBtn.AutoButtonColor = false
Instance.new("UICorner", FloatingTrainingSpamBtn).CornerRadius = UDim.new(0, 13)

local stroke2 = Instance.new("UIStroke", FloatingTrainingSpamBtn)
stroke2.Thickness = 0.5
stroke2.Color = Color3.fromRGB(15, 15, 18)

-- 🌈 เอฟเฟกต์ไฟนีออนวิ่งรอบขอบปุ่มช้า ๆ
task.spawn(function()
    while true do
        if stroke2 and stroke2.Parent then
            for i = 0, 1, 0.005 do
                if stroke2 and stroke2.Parent then stroke2.Color = Color3.fromHSV(i, 0.7, 0.9) end
                task.wait(0.04)
            end
        else break end
    end
end)

-- 📌 ระบบลากปุ่มลอยชิ้นที่ 2
local drag2, start2, bPos2, mouseStart2, isDragging2 = false, nil, nil, nil, false
FloatingTrainingSpamBtn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag2, start2, mouseStart2, bPos2, isDragging2 = true, i.Position, game:GetService("UserInputService"):GetMouseLocation(), FloatingTrainingSpamBtn.Position, false
        TweenService:Create(FloatingTrainingSpamBtn, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 46, 0, 46)}):Play()
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(i)
    if drag2 and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        if (game:GetService("UserInputService"):GetMouseLocation() - mouseStart2).Magnitude > 5 then isDragging2 = true end
        if isDragging2 then
            local d = i.Position - start2
            local cam = workspace.CurrentCamera
            local tx = math.clamp(bPos2.X.Offset + d.X, 0, cam and cam.ViewportSize.X - 52 or 800)
            local ty = math.clamp(bPos2.Y.Offset + d.Y, 0, cam and cam.ViewportSize.Y - 52 or 600)
            FloatingTrainingSpamBtn.Position = UDim2.new(bPos2.X.Scale, tx, bPos2.Y.Scale, ty)
        end
    end
end)
FloatingTrainingSpamBtn.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag2 = false
        TweenService:Create(FloatingTrainingSpamBtn, TweenInfo.new(0.3, Enum.EasingStyle.Elastic), {Size = UDim2.new(0, 52, 0, 52)}):Play()
        if not isDragging2 then
            Config.TrainingManualSpamActive = not Config.TrainingManualSpamActive
            if Config.TrainingManualSpamActive then
                FloatingTrainingSpamBtn.Text = "TRAIN\nON"
                FloatingTrainingSpamBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                FloatingTrainingSpamBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
            else
                FloatingTrainingSpamBtn.Text = "TRAIN\nSPAM"
                FloatingTrainingSpamBtn.TextColor3 = Color3.fromRGB(15, 15, 18)
                FloatingTrainingSpamBtn.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
            end
            if type(CustomNotify) == "function" then CustomNotify("Training Spam: " .. (Config.TrainingManualSpamActive and "ACTIVE" or "DISABLED"), 1.5) end
        end
    end
end)

-- 🚀 ลูปประมวลผลยิงแพ็กเก็ตสแปมชิ้นที่ 2 (ดักจับห้องซ้อมดวลบอท)
task.spawn(function()
    while shared._InvisRunning do
        if Config.TrainingManualSpamActive and Config.TrainingManualSpamShow then
            local ball = type(GetTrainingBallOnly) == "function" and GetTrainingBallOnly()
            if ball and type(Auto_Parry.FireParryRemote) == "function" then
                local batch = math.clamp(tonumber(Config.trainingPacketBatchSize) or 16, 1, 100)
                local interval = 1 / batch
                coroutine.wrap(function()
                    for i = 1, batch do
                        if not Config.TrainingManualSpamActive or not Config.TrainingManualSpamShow then break end
                        pcall(Auto_Parry.FireParryRemote, true)
                        task.wait(interval)
                    end
                end)()
            end
            task.wait(0)
        else task.wait(0.1) end
    end
end)

-- =======================================================================
-- 🚀 PART 3: MANUAL SPAM WEAK PHONE (RISE FLOATING BUTTON & POST-SIM ENGINE)
-- =======================================================================
Config.PostSimSpamShow = false
Config.PostSimSpamActive = false
Config.PostSimCooldown = 0.003
local lastPostSimSentTime = 0

-- 🔘 สร้างปุ่มลอยชิ้นที่ 3 สี่เหลี่ยมมนขาวนวลสไตล์ Rise
local FloatingPostSimBtn = Instance.new("TextButton", ScreenGui)
FloatingPostSimBtn.Name = "Invis_WeakPhoneSpamBtn"
FloatingPostSimBtn.Size = UDim2.new(0, 52, 0, 52)
FloatingPostSimBtn.Position = UDim2.new(0.85, 0, 0.60, 0) -- พิกัดแกน Y 0.60
FloatingPostSimBtn.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
FloatingPostSimBtn.Text = "WEAK\nSPAM"
FloatingPostSimBtn.TextColor3 = Color3.fromRGB(15, 15, 18)
FloatingPostSimBtn.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
FloatingPostSimBtn.TextSize = 9
FloatingPostSimBtn.Visible = false
FloatingPostSimBtn.AutoButtonColor = false
Instance.new("UICorner", FloatingPostSimBtn).CornerRadius = UDim.new(0, 13)

local stroke3 = Instance.new("UIStroke", FloatingPostSimBtn)
stroke3.Thickness = 0.5
stroke3.Color = Color3.fromRGB(15, 15, 18)

-- 🌈 เอฟเฟกต์ไฟนีออนวิ่งรอบขอบปุ่มช้า ๆ
task.spawn(function()
    while true do
        if stroke3 and stroke3.Parent then
            for i = 0, 1, 0.005 do
                if stroke3 and stroke3.Parent then stroke3.Color = Color3.fromHSV(i, 0.7, 0.9) end
                task.wait(0.04)
            end
        else break end
    end
end)

-- 📌 ระบบลากปุ่มลอยชิ้นที่ 3
local drag3, start3, bPos3, mouseStart3, isDragging3 = false, nil, nil, nil, false
FloatingPostSimBtn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag3, start3, mouseStart3, bPos3, isDragging3 = true, i.Position, game:GetService("UserInputService"):GetMouseLocation(), FloatingPostSimBtn.Position, false
        TweenService:Create(FloatingPostSimBtn, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 46, 0, 46)}):Play()
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(i)
    if drag3 and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        if (game:GetService("UserInputService"):GetMouseLocation() - mouseStart3).Magnitude > 5 then isDragging3 = true end
        if isDragging3 then
            local d = i.Position - start3
            local cam = workspace.CurrentCamera
            local tx = math.clamp(bPos3.X.Offset + d.X, 0, cam and cam.ViewportSize.X - 52 or 800)
            local ty = math.clamp(bPos3.Y.Offset + d.Y, 0, cam and cam.ViewportSize.Y - 52 or 600)
            FloatingPostSimBtn.Position = UDim2.new(bPos3.X.Scale, tx, bPos3.Y.Scale, ty)
        end
    end
end)
FloatingPostSimBtn.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag3 = false
        TweenService:Create(FloatingPostSimBtn, TweenInfo.new(0.3, Enum.EasingStyle.Elastic), {Size = UDim2.new(0, 52, 0, 52)}):Play()
        if not isDragging3 then
            Config.PostSimSpamActive = not Config.PostSimSpamActive
            if Config.PostSimSpamActive then
                FloatingPostSimBtn.Text = "WEAK\nON"
                FloatingPostSimBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                FloatingPostSimBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
            else
                FloatingPostSimBtn.Text = "WEAK\nSPAM"
                FloatingPostSimBtn.TextColor3 = Color3.fromRGB(15, 15, 18)
                FloatingPostSimBtn.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
            end
            if type(CustomNotify) == "function" then CustomNotify("Weak Phone Spam: " .. (Config.PostSimSpamActive and "ACTIVE" or "DISABLED"), 1.5) end
        end
    end
end)

-- 🚀 ลูปควบคุมการยิงแพ็กเก็ตจำลองความเร็วสูงระดับเฟรมเรตสปีด (PostSimulation)
game:GetService("RunService").PostSimulation:Connect(function()
    if not Config.PostSimSpamActive or not Config.PostSimSpamShow then return end
    local currentTime = os.clock()
    local targetSpeed = math.max(0.003, tonumber(Config.PostSimCooldown) or 0.003)
    
    if (currentTime - lastPostSimSentTime) >= targetSpeed then
        lastPostSimSentTime = currentTime
        if type(Auto_Parry) == "table" and type(Auto_Parry.FireParryRemote) == "function" then
            pcall(Auto_Parry.FireParryRemote, true)
        end
    end
end)

-- 🔄 ลูปกลางคุมการ ซ่อน/แสดง ของปุ่มลอยทั้ง 3 ชิ้นร่วมกันแบบเรียลไทม์
task.spawn(function()
    while shared._InvisRunning do
        FloatingSpamBtn.Visible = Config.ManualSpamShow and true or false
        if not Config.ManualSpamShow then Config.ManualSpamActive = false FloatingSpamBtn.Text = "INF\nSPAM" FloatingSpamBtn.TextColor3 = Color3.fromRGB(15, 15, 18) FloatingSpamBtn.BackgroundColor3 = Color3.fromRGB(245, 245, 250) end
        
        FloatingTrainingSpamBtn.Visible = Config.TrainingManualSpamShow and true or false
        if not Config.TrainingManualSpamShow then Config.TrainingManualSpamActive = false FloatingTrainingSpamBtn.Text = "TRAIN\nSPAM" FloatingTrainingSpamBtn.TextColor3 = Color3.fromRGB(15, 15, 18) FloatingTrainingSpamBtn.BackgroundColor3 = Color3.fromRGB(245, 245, 250) end
        
        FloatingPostSimBtn.Visible = Config.PostSimSpamShow and true or false
        if not Config.PostSimSpamShow then Config.PostSimSpamActive = false FloatingPostSimBtn.Text = "WEAK\nSPAM" FloatingPostSimBtn.TextColor3 = Color3.fromRGB(15, 15, 18) FloatingPostSimBtn.BackgroundColor3 = Color3.fromRGB(245, 245, 250) end
        task.wait(0.1)
    end
end)

-- 🎛️ สวิตช์ปุ่มเปิด/ปิดในหน้าต่างเมนูหลัก (Combat Tab) บรรทัดเรียงตัวสวยงามแบบคู่ขนาน
createLabel("SPAM TRILOGY CONTROLLERS", combatScroll)
createToggle("Infinity Spam Floating Button", "ManualSpamShow", combatScroll)
createToggle("Training Spam Floating Button", "TrainingManualSpamShow", combatScroll)
createToggle("Manual Spam (For Weak Phone)", "PostSimSpamShow", combatScroll)

-- =======================================================================
-- ⌨️ INVIS HUB — 4-MODE MANUAL SPAM KEYBIND CONTROLLER (PC ONLY)
-- =======================================================================
-- ประกาศสเตตัสและคอนฟิกเริ่มต้นสำหรับระบบคีย์บอร์ด (PC Only)
Config.UseKeybindForManualSpam = false     -- ปุ่มหลัก: เปิด/ปิดการใช้ Keybind
Config.SelectedSpamTypeToBind = "Infinity" -- ชนิดสแปมที่ต้องการควบคุม (รองรับ 4 ชนิด)
Config.SelectedSpamKeyCode = Enum.KeyCode.E -- ปุ่มคีย์บอร์ดเริ่มต้นที่ใช้กด

isMobileUser = game:GetService("UserInputService").TouchEnabled and not game:GetService("UserInputService").MouseEnabled

-- 🛡️ [แก้ไขแล้ว]: เปลี่ยนจาก return ตัดจบไฟล์ เป็นการครอบเงื่อนไขเฉพาะระบบ PC แทน เพื่อให้สคริปต์บนมือถือโหลดต่อได้ปกติ
if not isMobileUser then
    -- 📡 เธรดคอยดักฟังการกดปุ่มคีย์บอร์ดบน PC
    game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end -- ป้องกันบอททำงานตอนพิมพ์แชท
        if not Config.UseKeybindForManualSpam then return end -- ถ้าปิดสวิตช์หลักไว้ ไม่ทำงาน

        if input.KeyCode == Config.SelectedSpamKeyCode then
            local currentMode = Config.SelectedSpamTypeToBind
            
            -- ชนิดที่ 1: Infinity Spam
            if currentMode == "Infinity" then
                Config.ManualSpamActive = not Config.ManualSpamActive
                if FloatingSpamBtn then
                    FloatingSpamBtn.Text = Config.ManualSpamActive and "INF\nON" or "INF\nSPAM"
                    FloatingSpamBtn.BackgroundColor3 = Config.ManualSpamActive and Color3.fromRGB(15, 15, 18) or Color3.fromRGB(245, 245, 250)
                    FloatingSpamBtn.TextColor3 = Config.ManualSpamActive and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(15, 15, 18)
                end
                if type(CustomNotify) == "function" then CustomNotify("Infinite Spam: " .. (Config.ManualSpamActive and "ACTIVE" or "DISABLED"), 1.5) end
                
            -- ชนิดที่ 2: Training Spam
            elseif currentMode == "Training" then
                Config.TrainingManualSpamActive = not Config.TrainingManualSpamActive
                if FloatingTrainingSpamBtn then
                    FloatingTrainingSpamBtn.Text = Config.TrainingManualSpamActive and "TRAIN\nON" or "TRAIN\nSPAM"
                    FloatingTrainingSpamBtn.BackgroundColor3 = Config.TrainingManualSpamActive and Color3.fromRGB(15, 15, 18) or Color3.fromRGB(245, 245, 250)
                    FloatingTrainingSpamBtn.TextColor3 = Config.TrainingManualSpamActive and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(15, 15, 18)
                end
                if type(CustomNotify) == "function" then CustomNotify("Training Spam: " .. (Config.TrainingManualSpamActive and "ACTIVE" or "DISABLED"), 1.5) end
                
            -- ชนิดที่ 3: Weak Phone Spam
            elseif currentMode == "Weak Phone" then
                Config.PostSimSpamActive = not Config.PostSimSpamActive
                if FloatingPostSimBtn then
                    FloatingPostSimBtn.Text = Config.PostSimSpamActive and "WEAK\nON" or "WEAK\nSPAM"
                    FloatingPostSimBtn.BackgroundColor3 = Config.PostSimSpamActive and Color3.fromRGB(15, 15, 18) or Color3.fromRGB(245, 245, 250)
                    FloatingPostSimBtn.TextColor3 = Config.PostSimSpamActive and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(15, 15, 18)
                end
                if type(CustomNotify) == "function" then CustomNotify("Weak Phone Spam: " .. (Config.PostSimSpamActive and "ACTIVE" or "DISABLED"), 1.5) end
                
            -- ชนิดที่ 4: Network Bug Immortal
            elseif currentMode == "Bug Immortal" then
                Config.BugImmortalActive = not Config.BugImmortalActive
                if FloatingBugImmortalBtn then
                    FloatingBugImmortalBtn.Text = Config.BugImmortalActive and "BUG\nON" or "BUG\nIMMT"
                    FloatingBugImmortalBtn.BackgroundColor3 = Config.BugImmortalActive and Color3.fromRGB(15, 15, 18) or Color3.fromRGB(245, 245, 250)
                    FloatingBugImmortalBtn.TextColor3 = Config.BugImmortalActive and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(15, 15, 18)
                end
                if type(CustomNotify) == "function" then CustomNotify("Network Bug Immortal: " .. (Config.BugImmortalActive and "ACTIVE" or "DISABLED"), 1.5) end
            end
            
            if type(AutoSaveConfig) == "function" then pcall(AutoSaveConfig) end
        end
    end)

    -- 🖼️ INTERFACE INJECTION — บรรจุเข้าหน้าแท็บ COMBAT (สำหรับ PC เท่านั้น)
    task.spawn(function()
        task.wait(2.6) -- รอหน้าต่างเมนูหลักโหลดโครงสร้างเสร็จสิ้น
        pcall(function()
            local combatSection = combatScroll or TabFrames["Combat"]
            if combatSection then
                createLabel("PC SPAM KEYBIND CONTROLLER", combatSection)
                
                -- 🔘 ปุ่มหลัก: เปิด/ปิดการใช้งานระบบคีย์บอร์ดปุ่มลัด
                createToggle("⌨️ Use Keybind For Manual Spam", "UseKeybindForManualSpam", combatSection)
                
                -- 🎯 Select ที่ 1: เลือกชนิดของสแปมที่จะผูกกับปุ่ม (ขยายรายการรองรับครบ 4 แบบ)
                createSelect("Target Spam Type", Config.SelectedSpamTypeToBind, {
                    "Infinity", "Training", "Weak Phone", "Bug Immortal"
                }, combatSection, function(selectedType)
                    Config.SelectedSpamTypeToBind = selectedType
                end)
                
                -- 🎯 Select ที่ 2: เลือกปุ่มปุ่มลัดบนคีย์บอร์ด (ปุ่มยอดนิยม)
                local availableKeys = {"E", "Q", "F", "R", "C", "X", "Z", "V", "G"}
                createSelect("Trigger Keybind", "E", availableKeys, combatSection, function(selectedKeyName)
                    Config.SelectedSpamKeyCode = Enum.KeyCode[selectedKeyName]
                end)
            end
        end)
    end)
end
-- =======================================================================

-- 🖼️ INTERFACE INJECTION — บรรจุเข้าหน้าแท็บ COMBAT (สำหรับ PC เท่านั้น)
task.spawn(function()
    task.wait(2.6) -- รอหน้าต่างเมนูหลักโหลดโครงสร้างเสร็จสิ้น
    pcall(function()
        local combatSection = combatScroll or TabFrames["Combat"]
        if combatSection then
            createLabel("PC SPAM KEYBIND CONTROLLER", combatSection)
            
            -- 🔘 ปุ่มหลัก: เปิด/ปิดการใช้งานระบบคีย์บอร์ดปุ่มลัด
            createToggle("⌨️ Use Keybind For Manual Spam", "UseKeybindForManualSpam", combatSection)
            
            -- 🎯 Select ที่ 1: เลือกชนิดของสแปมที่จะผูกกับปุ่ม (ขยายรายการรองรับครบ 4 แบบ)
            createSelect("Target Spam Type", Config.SelectedSpamTypeToBind, {
                "Infinity", "Training", "Weak Phone", "Bug Immortal"
            }, combatSection, function(selectedType)
                Config.SelectedSpamTypeToBind = selectedType
            end)
            
            -- 🎯 Select ที่ 2: เลือกปุ่มปุ่มลัดบนคีย์บอร์ด (ปุ่มยอดนิยม)
            local availableKeys = {"E", "Q", "F", "R", "C", "X", "Z", "V", "G"}
            createSelect("Trigger Keybind", "E", availableKeys, combatSection, function(selectedKeyName)
                Config.SelectedSpamKeyCode = Enum.KeyCode[selectedKeyName]
            end)
        end
    end)
end)
-- =======================================================================

createToggle("Auto Play (Bot Movement)", "AutoPlay", combatScroll)
createToggle("mouse/touch location(target)", "UseMouseLocation", combatScroll)

-- 1. เพิ่มค่าเริ่มต้นของ Parry Curve Mode ลงในตาราง Config (หากยังไม่มี)
Config.ParryCurveMode = "Camera" 

-- 2. สร้างรายการตัวเลือกโหมดวิถีบอลไซด์โค้ง (Options List)
local ParryCurveModes = {
    "Camera",
    "Left",
    "Right",
    "Up",
    "Down",
    "Random",
    "Super Curve Random",
    "Straight"
}

-- 3. เรียกใช้งานฟังก์ชันสร้างปุ่มสลับโหมด พร้อมใส่ Function ประมวลผลด้านท้าย
createCycle("Parry Curve Mode", "ParryCurveMode", ParryCurveModes, combatScroll, function(selectedMode)
    -- บังคับอัปเดตตัวแปรภายในระบบคำนวณ CFrame ให้ตรงกับค่าที่ผู้เล่นกดเลือก
    Config.ParryCurveDirection = selectedMode 
    
    -- ส่งการแจ้งเตือนบอกผู้ใช้แบบ Real-time
    if type(CustomNotify) == "function" then
        CustomNotify("🎯 Curve Direction set to: " .. selectedMode, 2)
    end
end)

-- 🎯 สร้างเมนู SELECT สำหรับเลือกโหมดการคำนวณสะท้อนกลับ (Parry Mode Profile)
createSelect("Parry System Profile", Config.ParryMode or "Curve", {
    "Curve", "Normal"
}, combatScroll, function(selectedMode)
    -- อัปเดตโหมดประมวลผลระบบฟิสิกส์ให้ตรงตามที่ผู้เล่นคลิกเลือกอย่างเดียว
    Config.ParryMode = selectedMode

    if type(CustomNotify) == "function" then
        CustomNotify("🛡️ Parry Mode switched to: " .. selectedMode, 2)
    end
end)

-- ═══ VISUAL CONTROLS ═══
createToggle("Enable Visual Sword Changer Backend", "SkinChangerEnabled", visualScroll)

createTextBox("Type Sword Model Name", "", "SwordName", visualScroll, function(val)
    getgenv().swordModel = val
    pcall(function() getgenv().updateSword() end)
end)

createTextBox("Type Sword Custom FX Name", "", "SwordFXName", visualScroll, function(val)
    getgenv().swordFX = val
    pcall(function() getgenv().updateSword() end)
end)

createTextBox("Type Sword Custom FX Name", "", visualScroll, function(val)
    getgenv().swordFX = val
    pcall(function() getgenv().updateSword() end)
end)

local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- =======================================================================
-- 🎯🛡️ CORRECTED STATE-BASED FRAME LOCK ENGINE (OUTSIDE TASK PIPELINE)
-- =======================================================================
if _G.InvisIsCoolingDown == nil then _G.InvisIsCoolingDown = false end
if Config.ResetCooldownTime == nil then Config.ResetCooldownTime = 0.07 end

local lastHitBallInstance = nil
local safetyFallbackThread = nil -- สำหรับเก็บคิวแผนสำรอง

pcall(function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Debris = game:GetService("Debris")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local LocalPlayerName = game:GetService("Players").LocalPlayer.Name

    ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(_, ballPart, swordName, playerName)
        if tostring(playerName) == LocalPlayerName then
            
            if Config.UnlockCooldownMode == "Ball target" then return end

            -- 🔒 1. ล็อกประตูทันทีเพื่อป้องกันการกดเบิ้ลในมิลลิวินาทีเดียวกัน
            _G.InvisIsCoolingDown = true
            
            if ballPart and ballPart:IsA("BasePart") then
                lastHitBallInstance = ballPart
                
                -- 🔥 [CRITICAL CHECK OUTSIDE TASK]: เช็คสถานะบอลทันทีในอีเวนต์นี้เลย
                -- (หากเซิร์ฟเวอร์อัปเดต Attribute ไว บล็อกนี้จะทำงานและปลดล็อกให้ทันที)
                local currentTarget = tostring(ballPart:GetAttribute("target") or ballPart:GetAttribute("Target") or "")
                if currentTarget ~= LocalPlayerName and currentTarget ~= "" then
                    if type(parryLocked) == "table" then table.clear(parryLocked) end
                    if type(lockTime) == "table" then table.clear(lockTime) end
                    if type(shared.InvisClearLock) == "function" then shared.InvisClearLock(ballPart) end
                    _G.InvisIsCoolingDown = false
                    lastHitBallInstance = nil
                    
                    -- เจอบอลเปลี่ยนเป้าหมายแล้ว ปลดล็อกทันทีและตัดจบฟังก์ชัน ไม่สร้างตัวหน่วงเวลาให้รกแรม
                    return 
                end
            end

            -- 🔄 2. เคลียร์คิวแผนสำรองอันเก่า (หากมี) ป้องกัน Thread ชนกัน
            if safetyFallbackThread then
                task.cancel(safetyFallbackThread)
                safetyFallbackThread = nil
            end

            -- ⏱️ 3. Safety Fallback (แผนสำรอง): ปลดล็อกตามเวลาปกติ หากเกิดเหตุการณ์ดวลประชิด (Clash)
            local delayTime = math.max(0.001, tonumber(Config.ResetCooldownTime) or 0.07)
            safetyFallbackThread = task.delay(delayTime, function()
                if type(parryLocked) == "table" then table.clear(parryLocked) end
                if type(lockTime) == "table" then table.clear(lockTime) end
                if ballPart and type(shared.InvisClearLock) == "function" then shared.InvisClearLock(ballPart) end
                _G.InvisIsCoolingDown = false
                safetyFallbackThread = nil
            end)

            -- 🎨 เอฟเฟกต์คอมโบ (คงเดิม)
            if Config and Config.CustomComboFX and ballPart then
                pcall(function()
                    local fxPart = Instance.new("Part")
                    fxPart.Size = Vector3.new(3, 3, 3)
                    fxPart.Shape = Enum.PartType.Ball
                    fxPart.Color = Color3.fromRGB(0, 220, 255)
                    fxPart.Material = Enum.Material.Neon
                    fxPart.Anchored = true
                    fxPart.CanCollide = false
                    fxPart.Position = ballPart.Position
                    fxPart.Parent = workspace
                    
                    local attachment = Instance.new("Attachment", fxPart)
                    local sparkles = Instance.new("Sparkles", attachment)
                    sparkles.SparkleColor = Color3.fromRGB(255, 255, 255)
                    
                    TweenService:Create(fxPart, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = Vector3.new(18, 18, 18),
                        Transparency = 1
                    }):Play()
                    Debris:AddItem(fxPart, 0.5)
                end)
            end
        end
    end)

    -- 📡 พาร์ท 4: ระบบเคลียร์ไวระดับเฟรมเรต (Fast Frame-by-Frame Observer)
    -- ทำหน้าที่ดักจับในกรณีที่เฟรมแรกของอีเวนต์หมุนไม่ทัน ให้ Heartbeat (ซึ่งรันหลังฟิสิกส์เซิร์ฟเวอร์เสร็จ) สั่งปลดล็อกทันทีในเฟรมถัดไป
    RunService.Heartbeat:Connect(function()
        local ball = lastHitBallInstance
        if _G.InvisIsCoolingDown and ball and ball.Parent then
            local currentTarget = tostring(ball:GetAttribute("target") or ball:GetAttribute("Target") or "")
            
            if currentTarget ~= LocalPlayerName and currentTarget ~= "" then
                if safetyFallbackThread then
                    task.cancel(safetyFallbackThread)
                    safetyFallbackThread = nil
                end
                
                if type(parryLocked) == "table" then table.clear(parryLocked) end
                if type(lockTime) == "table" then table.clear(lockTime) end
                if type(shared.InvisClearLock) == "function" then shared.InvisClearLock(ball) end
                
                _G.InvisIsCoolingDown = false
                lastHitBallInstance = nil
            end
        end
    end)
end)

-- 🔘 ตัวปุ่ม Toggle บนหน้าจอเมนู
createToggle("Custom Combo Overlap FX", "CustomComboFX", visualScroll)

-- =======================================================================
-- 📉🎨 PREMIUM LOW GRAPHICS MODE CONTROLLER (RISE STYLE OVERHAUL)
-- =======================================================================

-- 🔘 สร้างปุ่มสี่เหลี่ยมตัดมุมโค้งมนขนาด 215x37 เข้าเซ็ตกับตาราง Grid ของหน้าเมนูหลัก
local LowGraphicBtn = Instance.new("TextButton")
LowGraphicBtn.Name = "LowGraphics_GridToggle"
LowGraphicBtn.Parent = visualScroll or combatScroll
LowGraphicBtn.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
LowGraphicBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
LowGraphicBtn.BorderSizePixel = 0
LowGraphicBtn.Size = UDim2.new(0, 215, 0, 37) -- ปรับขนาดสัดส่วนให้เท่าปุ่ม createToggle ดั้งเดิม
LowGraphicBtn.AutoButtonColor = false
LowGraphicBtn.Font = Enum.Font.SourceSans
LowGraphicBtn.Text = ""
LowGraphicBtn.ZIndex = 4

local lowBtnCorner = Instance.new("UICorner", LowGraphicBtn)
lowBtnCorner.CornerRadius = UDim.new(0, 10)

-- 📦 กล่องทำเครื่องหมายติ๊กถูกด้านขวาสุด (Checkbox Component)
local LowCheckbox = Instance.new("Frame", LowGraphicBtn)
LowCheckbox.Name = "Checkbox"
LowCheckbox.AnchorPoint = Vector2.new(0.5, 0.5)
LowCheckbox.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
LowCheckbox.BorderSizePixel = 0
LowCheckbox.Position = UDim2.new(0.915, 0, 0.5, 0)
LowCheckbox.Size = UDim2.new(0, 17, 0, 17)
LowCheckbox.ZIndex = 5

local LowCheckboxCorner = Instance.new("UICorner", LowCheckbox)
LowCheckboxCorner.CornerRadius = UDim.new(0, 4)

local LowGlow = Instance.new("ImageLabel", LowCheckbox)
LowGlow.Name = "Glow"
LowGlow.AnchorPoint = Vector2.new(0.5, 0.5)
LowGlow.BackgroundTransparency = 1.000
LowGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
LowGlow.Size = UDim2.new(0, 27, 0, 27)
LowGlow.Image = "rbxassetid://17290798394"
LowGlow.ImageColor3 = Color3.fromRGB(255, 255, 255)
LowGlow.ImageTransparency = 1.000
LowGlow.ZIndex = 5

local LowCheckmark = Instance.new("ImageLabel", LowCheckbox)
LowCheckmark.Name = "Checkmark"
LowCheckmark.AnchorPoint = Vector2.new(0.5, 0.5)
LowCheckmark.BackgroundTransparency = 1.000
LowCheckmark.Position = UDim2.new(0.5, 0, 0.5, 0)
LowCheckmark.Size = UDim2.new(0, 15, 0, 15)
LowCheckmark.Image = "rbxassetid://9754130783" -- ไอคอนรูปเครื่องหมายถูก
LowCheckmark.ImageColor3 = Color3.fromRGB(15, 15, 18) -- เครื่องหมายถูกสีดาร์กตัดกับปุ่มสว่าง
LowCheckmark.ImageTransparency = 1.000
LowCheckmark.ZIndex = 7

local LowFill = Instance.new("Frame", LowCheckbox)
LowFill.Name = "Fill"
LowFill.AnchorPoint = Vector2.new(0.5, 0.5)
LowFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LowFill.BackgroundTransparency = 1.000
LowFill.BorderSizePixel = 0
LowFill.Position = UDim2.new(0.5, 0, 0.5, 0)
LowFill.Size = UDim2.new(0, 17, 0, 17)
LowFill.ZIndex = 6

Instance.new("UICorner", LowFill).CornerRadius = UDim.new(0, 4)

local LowGradient = Instance.new("UIGradient", LowFill)
LowGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), 
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(180, 165, 170))
}
LowGradient.Rotation = 20

-- 🏷️ ป้ายข้อความแสดงชื่อฟังก์ชันด้านซ้าย (Montserrat Font)
local LowTextLabel = Instance.new("TextLabel", LowGraphicBtn)
LowTextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
LowTextLabel.BackgroundTransparency = 1.000
LowTextLabel.Position = UDim2.new(0.445, 0, 0.5, 0)
LowTextLabel.Size = UDim2.new(0, 164, 0, 15)
LowTextLabel.ZIndex = 5
LowTextLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
LowTextLabel.Text = "📉 Low Graphics Mode"
LowTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LowTextLabel.TextScaled = true
LowTextLabel.TextSize = 14.000
LowTextLabel.TextWrapped = true
LowTextLabel.TextXAlignment = Enum.TextXAlignment.Left

-- 🔄 ฟังก์ชันแอนิเมชันเกลี่ยแสงสีเครื่องหมายติ๊กถูก (Smooth Fader Transition)
local function updateLowGFXVisuals(isActive, animate)
    local targetTransparency = isActive and 0 or 1
    local duration = animate and 0.3 or 0
    
    TweenService:Create(LowFill, TweenInfo.new(duration, Enum.EasingStyle.Quad), {BackgroundTransparency = targetTransparency}):Play()
    TweenService:Create(LowGlow, TweenInfo.new(duration, Enum.EasingStyle.Quad), {ImageTransparency = targetTransparency}):Play()
    TweenService:Create(LowCheckmark, TweenInfo.new(duration * 0.8, Enum.EasingStyle.Quad), {ImageTransparency = targetTransparency}):Play()
end

-- ⚡ เหตุการณ์คลิกทำงานสลับค่าสถานะและสั่งรันระบบ Optimize Workspace หลังบ้าน
LowGraphicBtn.MouseButton1Click:Connect(function()
    Config.LowGraphicsEnabled = not Config.LowGraphicsEnabled
    
    -- เรียกใช้งานฟังก์ชันดั้งเดิมของสคริปต์เพื่อล้างพาร์ท/ซ่อนเงามืดลดอาการกินสเปคเครื่อง
    if type(applyLowGraphics) == "function" then
        pcall(applyLowGraphics, Config.LowGraphicsEnabled)
    end
    
    -- อัปเดตเครื่องหมายถูกแบบมีแอนิเมชันแฟลชแสงสปริง
    updateLowGFXVisuals(Config.LowGraphicsEnabled, true)
    
    if type(CustomNotify) == "function" then
        CustomNotify("📉 Low Graphics: " .. (Config.LowGraphicsEnabled and "ENABLED" or "DISABLED"), 1.5)
    end
    if type(AutoSaveConfig) == "function" then pcall(AutoSaveConfig) end
end)

-- โหลดเช็คสถานะติ๊กถูกตั้งต้นทันทีเมื่อรันสคริปต์ (รองรับระบบ AutoLoadConfig)
if Config.LowGraphicsEnabled == nil then Config.LowGraphicsEnabled = false end
updateLowGFXVisuals(Config.LowGraphicsEnabled, false)

-- ลงทะเบียนจำลองปุ่มส่งค่าเข้า Global สารบบดั้งเดิม
if not _G.RemoteToggle then _G.RemoteToggle = {} end
_G.RemoteToggle["LowGraphicsEnabled"] = function()
    LowGraphicBtn:Activate()
end

createActionBtn("🔓 Unlock All", Color3.fromRGB(27, 28, 33), function()
    task.spawn(function()
        CustomNotify("Remake By INVIS", 2)
        pcall(function() 
            loadstring(game:HttpGet("https://raw.githubusercontent.com/foreverspacexc-blip/OTHERHUB/refs/heads/main/wSuhUFTr%20(1).txt"))()
        end)
    end)
end, visualScroll)

createActionBtn("⛳ Bestest Fflag", Color3.fromRGB(27, 28, 33), function()
    task.spawn(function()
        CustomNotify("loaded Bestest Fflag", 2)
        pcall(function() 
            loadstring(game:HttpGet("https://raw.githubusercontent.com/TurboLite/Script/main/FixLag.lua"))()
        end)
    end)
end, visualScroll)

createActionBtn(
    "✨ Load Luxury Visuals Hub (Shader)", 
    Color3.fromRGB(212, 143, 34), -- ปรับแต่งสีปุ่มเป็นสีเหลืองส้มทองสไตล์หรูหรา (Luxury Theme)
    function()
        -- ส่งการแจ้งเตือนบอกสถานะการดาวน์โหลดเบื้องต้นไปยังผู้ใช้งาน
        if type(CustomNotify) == "function" then
            CustomNotify("⏳ Fetching shader network pipeline...", 2.5)
        end
        
        -- ใช้ตรรกะ pcall เพื่อป้องกันไม่ให้เธรดเกมค้างหากลิงก์ต้นทางเสียหรืออินเทอร์เน็ตหลุด
        task.spawn(function()
            local success, err = pcall(function()
                loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-LUXURY-VISUALS-HUB-111766"))()
            end)
            
            -- แสดงผลแจ้งเตือนความสำเร็จหรือแจ้งเออเรอร์ตามผลลัพธ์จริงที่ระบบได้รับ
            if type(CustomNotify) == "function" then
                if success then
                    CustomNotify("✅ Luxury Visuals Hub Loaded!", 3)
                else
                    CustomNotify("❌ Shader Crash: Link offline or execution failed.", 4)
                end
            end
        end)
    end, 
    visualScroll
)
-- =========================================================
-- 💀 HEADLESS
-- =========================================================
local isHeadless = false

local function ApplyHeadless(char)
    if not char then return end

    local head = char:FindFirstChild("Head")
    if not head then return end

    pcall(function()
        head.Transparency = isHeadless and 1 or 0

        for _, child in ipairs(head:GetChildren()) do
            if child:IsA("Decal") then
                child.Transparency = isHeadless and 1 or 0
            end
        end
    end)
end

createActionBtn("💀 Toggle Headless", Color3.fromRGB(70, 35, 90), function()
    isHeadless = not isHeadless

    local char = LocalPlayer.Character
    ApplyHeadless(char)

    CustomNotify(
        isHeadless and "💀 Headless: ENABLED"
        or "👤 Headless: DISABLED",
        2.5
    )
end, visualScroll)


-- =========================================================
-- 🦴 KORBLOX
-- =========================================================
local isKorblox = false

local function ApplyKorblox(char)
    if not char then return end

    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    pcall(function()

        -- R15
        if char:FindFirstChild("RightLowerLeg")
            and char:FindFirstChild("RightFoot") then

            local rLowerLeg = char:FindFirstChild("RightLowerLeg")
            local rFoot = char:FindFirstChild("RightFoot")

            rLowerLeg.Transparency = isKorblox and 1 or 0
            rFoot.Transparency = isKorblox and 1 or 0

        -- R6
        elseif char:FindFirstChild("Right Leg") then
            local rLeg = char:FindFirstChild("Right Leg")
            rLeg.Transparency = isKorblox and 1 or 0
        end
    end)
    -- พยายามใช้ HumanoidDescription
    if isKorblox then
        pcall(function()
            local desc = hum:GetAppliedDescription()
            desc.RightLeg = 139607718
            hum:ApplyDescription(desc)
        end)
    end
end

createActionBtn("🦴 Toggle Korblox Leg", Color3.fromRGB(25, 70, 120), function()
    isKorblox = not isKorblox
    local char = LocalPlayer.Character
    ApplyKorblox(char)
    CustomNotify(
        isKorblox and "🦴 Korblox Leg: ENABLED"
        or "🦵 Korblox Leg: DISABLED",
        2.5
    )
end, visualScroll)

-- =========================================================
-- 🔄 REAPPLY หลังเกิดใหม่
-- =========================================================
LocalPlayer.CharacterAdded:Connect(function(char)
    -- รอ Character โหลด
    task.wait(0.5)
    -- รอ Head / Humanoid
    local hum = char:WaitForChild("Humanoid", 5)
    local head = char:WaitForChild("Head", 5)
    if not hum then
        return
    end
    task.wait(0.3)
    -- 💀 คืนค่า Headless
    if isHeadless then
        ApplyHeadless(char)
    end
    -- 🦴 คืนค่า Korblox
    if isKorblox then
        ApplyKorblox(char)
    end
end)

createToggle("Player ESP", "PlayerESP", visualScroll)

-- ═══ SYSTEM SETTINGS ═══
createActionBtn("Load Stellar Hub ✅", Color3.fromRGB(0, 180, 110), function()
    loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/f7388eab91b827b35ecd1785c9261fb8c6249fa5d53780948ab1ffac8ab9c91b/download"))()
    CustomNotify("Stellar Hub Loaded!", 2.5)
end, scriptScroll)

createActionBtn("Fly Script 🔥", Color3.fromRGB(0, 180, 110), function()
    loadstring(game:HttpGet("https://pastebin.com/raw/xnMbBtbR"))()
    CustomNotify("Fly Loaded!", 2.5)
end, scriptScroll)

createActionBtn("Noclip Button 👾", Color3.fromRGB(0, 180, 110), function()
    loadstring(game:HttpGet("https://pastebin.com/raw/ha4AfHs4"))()
    CustomNotify("Noclip Loaded!", 2.5)
end, scriptScroll)

createActionBtn("lock screen 🔑", Color3.fromRGB(0, 180, 110), function()
    loadstring(game:HttpGet("https://files.catbox.moe/seiimp.txt"))()
    CustomNotify("lock screen Loaded!", 2.5)
end, scriptScroll)

createActionBtn("Semi-immortal (old)", Color3.fromRGB(210, 85, 0), function()
    loadstring(game:HttpGet("https://gist.githubusercontent.com/foreverspacexc-blip/acc9ec133bf516d8314c2fff10223750/raw/2776d49841376955e5b900bfb8437ea724b3a0f4/gistfile1.txt"))()
    CustomNotify("semi immortal but old Loaded!", 2.5)
end, scriptScroll)

createActionBtn("Hypol-X HD Fly Admin", Color3.fromRGB(0, 180, 110), function()
    loadstring(game:HttpGet("https://pastefy.app/9bilwWLP/raw"))()
    -- =======================================================================
-- 🔗 AUTOMATIC LINK COPIER ENGINE (INVIS HUB COMPATIBLE)
-- =======================================================================

pcall(function()
    -- ตรวจสอบฟังก์ชันคัดลอกของตัวรันแต่ละประเภท (รองรับครอบคลุมทุกระบบ)
    if setclipboard then 
        setclipboard("https://youtu.be/VEnIH-x8M0k?si=9TxgyPtV6VBN5nOQ") 
    elseif toclipboard then 
        toclipboard("https://youtu.be/VEnIH-x8M0k?si=9TxgyPtV6VBN5nOQ") 
    elseif set_clipboard then
        set_clipboard("https://youtu.be/VEnIH-x8M0k?si=9TxgyPtV6VBN5nOQ")
    elseif Clipboard and Clipboard.set then
        Clipboard.set("https://youtu.be/VEnIH-x8M0k?si=9TxgyPtV6VBN5nOQ")
    end
    
    -- ส่งการแจ้งเตือนบอกผู้เล่นบนหน้าจอทันทีเมื่อคัดลอกสำเร็จ
    task.spawn(function()
        if type(CustomNotify) == "function" then
            CustomNotify("🔗 Showcase Link Copied Successfully!", 3.5)
        end
    end)
end)
    CustomNotify("speed jump set cframe Loaded!", 2.5)
end, scriptScroll)

createActionBtn("Free cam V2.2", Color3.fromRGB(0, 180, 110), function()
   loadstring(game:HttpGet("https://pastebin.com/raw/EbN2qBVM"))()
   CustomNotify("invis freecam loaded", 2.5)
end, scriptScroll)

createActionBtn("Fake lag", Color3.fromRGB(0, 180, 110), function()
   loadstring(game:HttpGet("https://pastebin.com/raw/NbsDZHrG", true))()
   CustomNotify("Fake lag loaded", 2.5)
end, scriptScroll)

createActionBtn("🔄 Rejoin Server Instance", Color3.fromRGB(35, 85, 35), function() RejoinServer() end, settingsScroll)
createActionBtn("🌌 Server Hop Network Search", Color3.fromRGB(95, 70, 25), function() ServerHop() end, settingsScroll)

-- ผูกมัดคำสั่งให้ปุ่มไปสั่งรันฟังก์ชันหลังบ้านเมื่อมีการกดติ๊กถูกสลับค่า
local freeCamToggleFrame = combatScroll:GetChildren()[#combatScroll:GetChildren()]
if freeCamToggleFrame and freeCamToggleFrame:IsA("Frame") then
    local mainTriggerButton = freeCamToggleFrame:FindFirstChildOfClass("TextButton")
    if mainTriggerButton then
        mainTriggerButton.MouseButton1Click:Connect(function()
            -- เรียกใช้ฟังก์ชันสลับสเตทกล้องแปรผันตรงตามค่าติ๊กถูกในระบบ Config
            toggleFreeCam(Config.FreeCamEnabled)
        end)
    end
end

-- =======================================================================
-- 🖼️🎨 INVIS HUB — ULTIMATE THEME & FULL COLOR CONTROLLER (LOADS INSTANTLY)
-- =======================================================================

-- 🔄 2. ฟังก์ชันสลับสีธีมพื้นหลังขยายคลังเฉดสีครบถ้วน (Full Color Palette)
createCycle("UI Background Theme", "UIBackground", BackgroundColors, uiScroll, function(selectedColorName)
    -- 🎨 [ตารางความจำแก้ไขแล้ว]: เพิ่มเฉดสีรองรับครบถ้วนทุกความต้องการของผู้ใช้แบบพรีเมียม
    local colors = {
        DARK    = Color3.fromRGB(12, 12, 16),   -- ดำมืด Rise UI ดั้งเดิม
        RED     = Color3.fromRGB(45, 10, 18),   -- แดงเลือดนกเข้มดุดัน
        BLUE    = Color3.fromRGB(10, 20, 45),   -- น้ำเงินลึกใต้ทะเล
        PURPLE  = Color3.fromRGB(30, 15, 45),   -- ม่วงนีออนลึกลับ
        GREEN   = Color3.fromRGB(10, 40, 25),   -- เขียวป่าลึกคุมโทน
        ORANGE  = Color3.fromRGB(50, 25, 10),   -- ส้มอิฐสไตล์ไซเบอร์
        YELLOW  = Color3.fromRGB(55, 45, 12),   -- เหลืองทองคำหรูหรา (Luxury)
        PINK    = Color3.fromRGB(52, 15, 35),   -- ชมพูฟลามิงโก้สไตล์นีออน
        WHITE   = Color3.fromRGB(240, 240, 245), -- ขาวมินิมอลผินสะอาดตา
        CYAN    = Color3.fromRGB(10, 48, 55),   -- ฟ้าฟ้านีออนสว่างไฉน
        MAGENTA = Color3.fromRGB(48, 12, 42)    -- ม่วงแดงเฉดพรีเมียม
    }
    
    local selectedColor = colors[selectedColorName]
    if selectedColor and MainFrame then
        -- 🎬 ถักทอเกลี่ยเฉดสีนุ่มนวลผ่านแอนิเมชันความเร็วสูง (Smooth Color Blend)
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        game:GetService("TweenService"):Create(MainFrame, tweenInfo, {BackgroundColor3 = selectedColor}):Play()
        
        -- 🔥 [CRITICAL VISUAL FIX]: ตรวจเช็คหากสีที่เลือกเป็น 'WHITE' ให้สลับสีตัวอักษรหัวข้อเป็นสีเข้มอัตโนมัติเพื่อให้มองเห็นชัดเจน
        if TextLabelTitle then
            if selectedColorName == "WHITE" then
                TextLabelTitle.TextColor3 = Color3.fromRGB(15, 15, 18)
                if TimeLabel then TimeLabel.TextColor3 = Color3.fromRGB(45, 45, 50) end
            else
                TextLabelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                if TimeLabel then TimeLabel.TextColor3 = Color3.fromRGB(220, 220, 225) end
            end
        end
        
        -- บังคับเปิดภาพวิวภูเขาด้านหลังไว้คู่กันเสมอ เพื่อทำหน้าที่เป็นฟิลเตอร์ย้อมแสงฉากตามสีที่เลือก
        if MenuBgImage then
            MenuBgImage.Visible = true
        end
    end
end)
-- =======================================================================

-- ═══ IMAGE BACKGROUND CONTROLS ══════════════════════════════
createLabel("IMAGE BACKGROUND CONFIGURATIONS", uiScroll)

-- ⌨️ 2. กล่องกรอกตัวเลข Image ID เพื่อเปลี่ยนรูปพื้นหลังตามใจชอบ
createTextBox("Custom Background Image ID", "", uiScroll, function(text)
    local id = tostring(text):match("%d+")

    if id and MenuBgImage then
        -- เขียนทับ Asset ID ไปที่โมเดลภาพวิวหลักโดยตรง
        MenuBgImage.Image = "rbxassetid://" .. id
        MenuBgImage.Visible = true
        if type(CustomNotify) == "function" then
            CustomNotify("🖼️ Background Image Updated to ID: " .. id, 2.5)
        end
    elseif MenuBgImage then
        -- หากกรอกค่าว่างหรือตัวหนังสือที่ไม่ใช่ตัวเลข จะทำการซ่อนรูปพื้นหลัง
        MenuBgImage.Image = ""
        MenuBgImage.Visible = false
        if type(CustomNotify) == "function" then
            CustomNotify("❌ Invalid Image ID! Background hidden.", 2.5)
        end
    end
end)

-- ⌨️ 3. กล่องกรอกปรับความโปร่งแสง/ความจางของรูปพื้นหลัง (0 = เข้มชัดสุด, 1 = ล่องหน)
createTextBox("Image Transparency (0.00 - 1.00)", "0.40", uiScroll, function(text)
    local value = tonumber(text)

    if value and MenuBgImage then
        local clampedValue = math.clamp(value, 0, 1)
        MenuBgImage.ImageTransparency = clampedValue
        if type(CustomNotify) == "function" then
            CustomNotify("✨ Transparency adjusted to: " .. string.format("%.2f", clampedValue), 2)
        end
    end
end)

-- 🔘 4. ปุ่มลัดสั่งซ่อนรูปภาพพื้นหลังชั่วคราว (เหลือเฉพาะสีพื้นหลังธีมเปล่า ๆ)
createActionBtn("🖼️ Hide Background Image", THEME.CardBg, function()
    if MenuBgImage then
        MenuBgImage.Visible = false
        if type(CustomNotify) == "function" then
            CustomNotify("🖼️ Background Image Hidden", 2)
        end
    end
end, uiScroll)

-- 🔘 5. ปุ่มสั่งรีเซ็ตทุกอย่างกลับมาเป็นค่าเริ่มต้นของสคริปต์ Invis Hub (ภาพวิวภูเขามืดดั้งเดิม)
createActionBtn("🔄 Reset Default Background", THEME.CardBg, function()
    pcall(function()
        if MenuBgImage then
            -- เรียกใช้ไฟล์รูปภาพวิวภูเขามืดที่เคยดาวน์โหลดเซฟเก็บไว้ในเครื่อง Client
            local InvisBgFileName = "InvisHub_ThemeMountain.jpg"
            if isfile and isfile(InvisBgFileName) then
                MenuBgImage.Image = getcustomasset(InvisBgFileName)
            else
                MenuBgImage.Image = "rbxassetid://16447814983" -- สำรองกรณีหาไฟล์เครื่องไม่เจอ
            end
            
            -- คืนค่าสัดส่วนความจางมาตรฐานดั้งเดิม
            MenuBgImage.ImageTransparency = 0.4
            MenuBgImage.Visible = true
        end

        -- คืนค่าสีกล่องเมนูหลักให้กลับเป็นสี DARK คลาสสิก
        if MainFrame then
            MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
        end
        
        -- ปรับค่าตัวแปรในสารบบ Config กลับเป็นค่าเริ่มต้น
        Config.UIBackground = "DARK"

        if type(CustomNotify) == "function" then
            CustomNotify("🔄 Background & Theme Reset to Default!", 2.5)
        end
    end)
end, uiScroll)

-- 🟢 🔁 ลูปอัปเดตค่าสถานะ Real-time ทุกเฟรมเรตหน้าจอ
task.spawn(function()
    while shared._InvisRunning do
        task.wait(0)
        pcall(function()
            if not TabFrames["Status"].Visible then return end -- ประหยัดทรัพยากร: ถ้าไม่ได้เปิดหน้าแท็บนี้อยู่ จะไม่คำนวณ
            
            local ball = Auto_Parry.Get_Ball()
            local character = LocalPlayer.Character
            local hrp = character and (character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart)
            
            -- 1. อัปเดต Ball Speed และ Time To Hit
            if ball and ball.Parent and hrp then
                local velocity = Vector3.zero
                local zoomies = ball:FindFirstChild("zoomies")
                if zoomies then pcall(function() velocity = zoomies.VectorVelocity end) end
                if velocity == Vector3.zero and ball:IsA("BasePart") then velocity = ball.AssemblyLinearVelocity end
                
                local speed = velocity.Magnitude
                local dist = (hrp.Position - ball.Position).Magnitude
                local reachTime = dist / math.max(speed, 1)
                
                Stat_BallSpeed.Text = string.format("  ⚡ Ball Speed : %.2f", speed)
                Stat_TimeToHit.Text  = string.format("  ⏳ Time To Hit : %.3fs", reachTime)
            else
                Stat_BallSpeed.Text = "  ⚡ Ball Speed : 0.00 (No Ball)"
                Stat_TimeToHit.Text  = "  ⏳ Time To Hit : 0.000s"
            end
            
            -- 2. อัปเดต Target ล็อกเป้าหมายปัจจุบัน
            if shared.Clicked_Target_Name then
                Stat_Target.Text = "  🎯 Your Target : " .. tostring(shared.Clicked_Target_Name) .. " (Locked)"
            else
                local curTarget = Auto_Parry.GetTargetPlayer()
                Stat_Target.Text = "  🎯 Your Target : " .. (curTarget and curTarget.Name or "None") .. " (Auto)"
            end
            
            -- 3. อัปเดต Nearest และ Farthest Player
            local nearPlr = targetDistanceSolver("Nearest")
            local farPlr  = targetDistanceSolver("Farest")
            
            Stat_Nearest.Text  = "  🧍 Nearest Player : " .. (nearPlr and nearPlr.Name or "None")
            Stat_Farthest.Text = "  🌌 Farthest Player : " .. (farPlr and farPlr.Name or "None")
        end)
    end
end)

-- =======================================================================
-- 🎵 INDEPENDENT MUSIC HUB SYSTEM v5 (EXECUTOR SUPPORT VERSION)
-- =======================================================================
local RunService = game:GetService("RunService")

-- 📦 1. สเตทและการตั้งค่าระบบหลัก
Config.MusicEnabled = false
Config.MusicLooped = false
Config.AutoPlayNext = false
Config.MaxPlayTime = nil -- ค่าเริ่มต้นเป็น nil คือเล่นจนจบเพลงปกติ (ไม่มีการจำกัดเวลา)
Config.MusicVolume = 0.5

CurrentSound = nil
progressConnection = nil
currentTrackIndex = 1

-- 📋 คลังเพลงเริ่มต้น (ใช้ลิงก์ GitHub ได้เลย)
CustomPlaylists = {
    {Name = "🎵 Everything Works Out", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/everything%20works%20out%20in%20the%20end%20slowed%20best%20part%20looped.mp3"},
    {Name = "🎵 Pupsies Misery Lyrics", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/pupsies%20misery.Lyrics.mp3"},
    {Name = "🎵 Young Girl A Funk",        URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/YOUNG%20GIRL%20A%20FUNK%20ABDUKXRIM%20SLOWED%20REVERB%20BRAZILIAN%20PHONK.mp3"},
    {Name = "🎵 Aura Feel Powerful",       URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/AURA%20%F0%9F%91%91%20Songs%20to%20feel%20Powerful%20Slowed.mp3"},
    {Name = "💥 BRAWL Funk", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/BRAWL%20SWAG%20FUNK.mp3"},
    {Name = "🌙 Beautiful Moon Funk", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/BEAUTIFUL%20MOON%20FUNK%20(SLOWED).mp3"},
    {Name = "📌 Alan Walker", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/Alan%20Walker%20-%20Top%205%20Best%20Songs%202023.mp3"},
    {Name = "👑 Story of the worrior", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/John%20Michael%20Howell%20-%20Story%20Of%20A%20Warrior%20%5BOFFICIAL%20LYRIC%20VIDEO%5D.mp3"},
    {Name = "⚡ Meant To be", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/Cuntsniffer%20-%20Meant%20To%20Be%20(Lyrics).mp3"},
    {Name = "🌑 Worry (SLOW)", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/worry%20(ultra%20slowed).mp3"},
    {Name = "🕶️ After Dark", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/Nightcore%20-%20After%20Dark.mp3"},
    {Name = "📌 Space Song", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/Beach%20House%20-%20Space%20Song%20(Lyrics).mp3"},
    {Name = "❤️‍🩹 Notion", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/The%20Rare%20Occasions%20%20Notion%20Official%20Music%20Video.mp3"},
    {Name = "🌱 Rise Up", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/TheFatRat%20-%20Rise%20Up%20%20(SLOWED%20%20REVERB).mp3"},
    {Name = "you can't find this song", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/today%20is%20my%20birthday,%20so%20I'm%20giving%20you%20a%20song.mp3"},
    {Name = "$Undown", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/$%F0%9D%99%AA%F0%9D%99%A3%F0%9D%99%99%F0%9D%99%A4%F0%9D%99%AC%F0%9D%99%A3%20-%20%F0%9D%99%A8%F0%9D%99%A9%F0%9D%99%A7%F0%9D%99%96%F0%9D%99%AE.%F0%9D%99%AC%F0%9D%99%96%F0%9D%99%AB%20%5B%20%F0%9D%99%A8%F0%9D%99%A1%F0%9D%99%A4%F0%9D%99%AC%F0%9D%99%9A%F0%9D%99%99%20%20%F0%9D%99%A7%F0%9D%99%9A%F0%9D%99%AB%F0%9D%99%9A%F0%9D%99%A7%F0%9D%99%97%20%5D.mp3"}
}

customTimeText = nil
customProgressText = nil
currentPlayingLabel = nil

pcall(function()
    currentPlayingLabel = createLabel("Now Playing: None", musicScroll)
    customTimeText = createLabel("00:00 / 00:00", musicScroll)
    customProgressText = createLabel("[□□□□□□□□□□□□□□□□□□□□ 0%]", musicScroll)
end)

-- 🛠️ 3. ระบบล้างไฟล์เสียงเก่า
local function StopCurrentMusic()
    if progressConnection then
        progressConnection:Disconnect()
        progressConnection = nil
    end
    if CurrentSound then
        CurrentSound:Stop()
        CurrentSound:Destroy()
        CurrentSound = nil
    end
end

-- 🛠️ 4. ฟังก์ชันสำหรับโหลดและเล่นเพลงผ่าน Executor
local function PlayMusicByIndex(index)
    StopCurrentMusic()
    
    if not Config.MusicEnabled then return end
    if #CustomPlaylists == 0 then return end
    
    currentTrackIndex = math.clamp(index, 1, #CustomPlaylists)
    local targetTrack = CustomPlaylists[currentTrackIndex]
    
    -- ตั้งชื่อไฟล์ที่จะเซฟลงเครื่อง (ลบอักขระพิเศษออกป้องกัน error)
    local safeFileName = string.gsub(targetTrack.Name, "[^%w%s]", "")
    safeFileName = string.gsub(safeFileName, "%s+", "_") .. ".mp3"
    
    task.spawn(function()
        pcall(function()
            if currentPlayingLabel then
                currentPlayingLabel.Text = "Loading: " .. targetTrack.Name .. "..."
            end
            
            -- [สำคัญ]: ระบบดาวน์โหลดและสร้าง Custom Asset สำหรับตัวรัน
            if not isfile(safeFileName) then
                if customTimeText then customTimeText.Text = "Downloading File..." end
                local soundData = game:HttpGet(targetTrack.URL)
                writefile(safeFileName, soundData)
            end
            
            local assetId = getcustomasset(safeFileName)
            
            if currentPlayingLabel then
                currentPlayingLabel.Text = "Now Playing: " .. targetTrack.Name
            end
            
            CurrentSound = Instance.new("Sound")
            CurrentSound.Name = "InvisHub_BackgroundMusic"
            CurrentSound.SoundId = assetId -- ใส่ ID ที่แปลงมา
            CurrentSound.Volume = Config.MusicVolume
            CurrentSound.Looped = Config.MusicLooped
            CurrentSound.Parent = game:GetService("SoundService")
            
            CurrentSound:Play()
            
progressConnection = RunService.RenderStepped:Connect(function()
    if CurrentSound and CurrentSound.IsPlaying and CurrentSound.TimeLength > 0 then
        local current = CurrentSound.TimePosition
        local total = CurrentSound.TimeLength
        
        -- อัปเดตข้อความแสดงเวลาปัจจุบันเทียบกับเวลาทั้งหมด
        local currentStr = string.format("%02d:%02d", math.floor(current / 60), math.floor(current % 60))
        local totalStr = string.format("%02d:%02d", math.floor(total / 60), math.floor(total % 60))
        if customTimeText then customTimeText.Text = currentStr .. " / " .. totalStr end
        
        -- 🌟 [TRIGGER NEW TRACK OVERRIDE]: ถ้าปรับเวลาจนเกือบจบเพลง หรือเวลาเกินระยะทางทั้งหมด ให้ข้ามเพลงทันที
        local isSongEnded = Config.AutoPlayNext and (current >= total - 0.2)

        if isSongEnded then
            StopCurrentMusic()
            if currentTrackIndex < #CustomPlaylists then
                PlayMusicByIndex(currentTrackIndex + 1)
            else
                PlayMusicByIndex(1)
            end
        end
    end
end)
        end)
    end)
end

-- =======================================================================
-- 🔘 5. คอนโทรลเลอร์และปุ่ม
-- =======================================================================
createToggle("Enable Music System", "MusicEnabled", musicScroll)
createToggle("Loop Single Track", "MusicLooped", musicScroll)
createToggle("Auto Play Next Track", "AutoPlayNext", musicScroll)

createActionBtn("< Previous Track", Color3.fromRGB(45, 45, 65), function()
    if Config.MusicEnabled then
        if currentTrackIndex > 1 then
            PlayMusicByIndex(currentTrackIndex - 1)
        else
            PlayMusicByIndex(#CustomPlaylists)
        end
    else
        CustomNotify("❌ Please enable Music System first!", 3)
    end
end, musicScroll)

createActionBtn("> Next Track", Color3.fromRGB(45, 45, 65), function()
    if Config.MusicEnabled then
        if currentTrackIndex < #CustomPlaylists then
            PlayMusicByIndex(currentTrackIndex + 1)
        else
            PlayMusicByIndex(1)
        end
    else
        CustomNotify("❌ Please enable Music System first!", 3)
    end
end, musicScroll)

-- 📥 6. ระบบดาวน์โหลดลิงก์ภายนอกเข้ามาเป็นส่วนหนึ่งของคลังเพลง
createLabel("DOWNLOAD & ADD EXTERNAL LINK TO PLAYLIST", musicScroll)

createTextBox("Paste Direct MP3 Link to Download...", "", musicScroll, function(text)
    if text and string.match(text, "http") then
        local trackNumber = #CustomPlaylists + 1
        local newTrack = {
            Name = "🎵 Downloaded Track #" .. tostring(trackNumber),
            URL = text
        }
        
        table.insert(CustomPlaylists, newTrack)
        CustomNotify("📥 Successfully added to Playlist! (#" .. tostring(trackNumber) .. ")", 3)
        
        createActionBtn(newTrack.Name, Color3.fromRGB(24, 38, 28), function()
            if Config.MusicEnabled then
                PlayMusicByIndex(trackNumber)
            else
                CustomNotify("❌ Please enable Music System first!", 3)
            end
        end, musicScroll)
    else
        CustomNotify("❌ Invalid URL! Please provide a valid direct link.", 3)
    end
end)

-- =======================================================================
-- 🎵 PREMIUM TRACK POSITION TIMING CONTROLLER (NOT MAXSPEED)
-- =======================================================================
createLabel("ADJUST CURRENT MUSIC POSITION TIME", musicScroll)

-- 1. ช่อง TextBox สำหรับกรอกระบุตัวเลขวินาทีเพื่อข้ามไปจังหวะที่ต้องการโดยตรง
createTextBox("Skip to Time (Seconds)", "", musicScroll, function(val)
    local n = tonumber(val)
    if CurrentSound and CurrentSound.IsPlaying then
        local totalLength = CurrentSound.TimeLength
        if n and n >= 0 then
            -- ถ้ากรอกตัวเลขเกินความยาวทั้งหมดของเพลง ให้สลับข้ามไปเล่นเพลงใหม่ทันที
            if n >= totalLength then
                CustomNotify("⏱️ Time exceeds track length! Switching to next track...", 2.5)
                StopCurrentMusic()
                if currentTrackIndex < #CustomPlaylists then PlayMusicByIndex(currentTrackIndex + 1) else PlayMusicByIndex(1) end
            else
                CurrentSound.TimePosition = n
                CustomNotify("⏱️ Track time adjusted to: " .. tostring(n) .. "s", 2)
            end
        end
    else
        CustomNotify("❌ No music is currently playing!", 2.5)
    end
end)

-- 2. ปุ่มกดลัดข้ามเวลาไปข้างหน้า +10 วินาที (Fast Forward)
createActionBtn("⏩ Skip Forward (+10s)", Color3.fromRGB(45, 60, 85), function()
    if CurrentSound and CurrentSound.IsPlaying then
        local targetTime = CurrentSound.TimePosition + 10
        local totalLength = CurrentSound.TimeLength
        
        if targetTime >= totalLength then
            CustomNotify("⏱️ Time exceeds track length! Switching to next track...", 2.5)
            StopCurrentMusic()
            if currentTrackIndex < #CustomPlaylists then PlayMusicByIndex(currentTrackIndex + 1) else PlayMusicByIndex(1) end
        else
            CurrentSound.TimePosition = targetTime
            CustomNotify("⏩ Jumped forward 10 seconds", 1.5)
        end
    else
        CustomNotify("❌ No music is currently playing!", 2.5)
    end
end, musicScroll)

-- 3. ปุ่มกดลัดย้อนเวลาถอยหลัง -10 วินาที (Rewind)
createActionBtn("⏪ Skip Backward (-10s)", Color3.fromRGB(85, 55, 45), function()
    if CurrentSound and CurrentSound.IsPlaying then
        local targetTime = CurrentSound.TimePosition - 10
        if targetTime < 0 then
            CurrentSound.TimePosition = 0
        else
            CurrentSound.TimePosition = targetTime
        end
        CustomNotify("⏪ Jumped backward 10 seconds", 1.5)
    else
        CustomNotify("❌ No music is currently playing!", 2.5)
    end
end, musicScroll)

-- 📋 7. ส่วนสร้างปุ่มเริ่มต้นของเพลงทั้งหมดในคลัง
task.spawn(function() -- 🚀 เติมบรรทัดนี้เพื่อเปิดโควตาตัวแปรชุดใหม่
    createLabel("CURRENT PLAYLIST STORE", musicScroll)
    for i, track in ipairs(CustomPlaylists) do
        createActionBtn(track.Name, Color3.fromRGB(32, 28, 44), function()
            if Config.MusicEnabled then
                PlayMusicByIndex(i)
            else
                CustomNotify("❌ Please enable Music System first!", 3)
            end
        end, musicScroll)
    end
end)

-- ═══ โค้ดส่วนลูปท้ายสคริปต์ที่ได้รับการแก้ไขจุดตกหล่น ═══
task.spawn(function()
    while true do
        task.wait(0.2)
        if CurrentSound then 
            CurrentSound.Looped = Config.MusicLooped 
        end
        -- ✨ แก้ไขบรรทัด 3849: เพิ่มคำว่า then เข้าไปให้สมบูรณ์
        if not Config.MusicEnabled and CurrentSound then 
            StopCurrentMusic() 
            if currentPlayingLabel then 
                currentPlayingLabel.Text = "Now Playing: None" 
            end
        end
    end
end) -- 🔒 ปิดครอบฟังก์ชันลูปย่อยตัวสุดท้ายสำเร็จ

-- 🌟 [TASK.SPAWN]: ตรวจจับตารางรีโมทเครือข่ายหลักสำเร็จแล้วแจ้งเตือนทันที (วางไว้ล่างสุดของสคริปต์)
task.spawn(function()
    local hasNotifiedSetup = false
    
    -- ทำการเดินลูปตรวจสอบความพร้อมของหน่วยความจำเครือข่าย แบบความถี่สูง
    while shared._InvisRunning do
        -- เช็คว่าตารางดักจับหลัก (_reverted) มีข้อมูลรีโมทแท้ของตัวเกมและคีย์หลุดเข้ามาหรือยัง
        if _reverted and next(_reverted) ~= nil then
            for _remote, _originalArgs in pairs(_reverted) do
                if type(_originalArgs) == "table" and _originalArgs[1] ~= nil then
                    -- เมื่อสแกนเจอและมีข้อมูลคีย์ครบถ้วน ให้สั่งแจ้งเตือนทันที
                    if not hasNotifiedSetup then
                        hasNotifiedSetup = true
                        task.spawn(function()
                            if type(CustomNotify) == "function" then
                                CustomNotify("⚡ Network Remote Connected & Token Injected!", 4.5)
                            end
                        end)
                        break
                    end
                end
            end
        end
        
        -- ถ้าแจ้งเตือนความสำเร็จไปแล้ว ให้สั่งตัดเธรดทิ้งทันทีเพื่อประหยัด CPU ของผู้ใช้
        if hasNotifiedSetup then 
            break 
        end
        
        task.wait(0.2) -- ความถี่ในการสแกนตรวจสอบทุกๆ 0.2 วินาทีตอนเริ่มรันสคริปต์
    end
end)

createToggle("⚡ Thunder Dash No Cooldown", "ThunderDashExploit", combatScroll)

-- other
createTextBox("Infinity Spam Speed", tostring(Config.packetBatchSize), combatScroll, function(val)
    local n = tonumber(val)
    if n and n >= 1 then
        Config.packetBatchSize = math.clamp(n, 1, 100) -- ล็อกให้กรอกได้ไม่เกิน 100 เพื่อป้องกันเน็ตหลุด/เกมเด้ง
        CustomNotify("🚀 Spam Packet Batch updated: " .. tostring(Config.packetBatchSize), 2.5)
    else
        CustomNotify("❌ Invalid Number! Please type a number.", 2.5)
    end
end)

createTextBox("Training Spam Speed", tostring(Config.trainingPacketBatchSize), combatScroll, function(val)
    local n = tonumber(val)
    if n and n >= 1 then
        Config.trainingPacketBatchSize = math.clamp(n, 1, 100) -- ล็อกให้กรอกได้ไม่เกิน 100 เพื่อความปลอดภัย
        CustomNotify("🟠 Training Spam Packet Batch updated: " .. tostring(Config.trainingPacketBatchSize), 2.5)
    else
        CustomNotify("❌ Invalid Number! Please type a number.", 2.5)
    end
end)

-- =======================================================================
-- 🔄 DYNAMIC PARRY METHOD CONTROLLER (ANTI-CRASH & EXECUTOR SAFE)
-- =======================================================================
MethodOptions = {"Bypass", "click"}

-- 🛡️ ตรวจสอบเงื่อนไข: หากระบบหลังบ้านแจ้งว่าไม่รองรับการทำงานของ Bypass จะทำการตัดทิ้งให้เหลือตัวเลือกเดียวทันที
if not isBypassSupported then
    MethodOptions = {"click"}
end

-- สร้างปุ่มสลับโหมดอัจฉริยะ
createCycle("Parry Input Method", "ParryMethodMode", MethodOptions, combatScroll, function(selectedMethod)
    if not isBypassSupported and selectedMethod == "Bypass" then
        -- 🔒 แผนสำรองทางเทคนิค: บังคับเด้งกลับเป็นคลิกเมาส์หากเกิดความผิดพลาดในเลเยอร์ UI
        Config.ParryMethodMode = "click"
        return
    end
    
    if type(CustomNotify) == "function" then
        CustomNotify("🛡️ Parry Input changed to: " .. selectedMethod, 2.5)
    end
end)

task.spawn(function()
    while shared._InvisRunning do
        -- ตรวจสอบเป็นระยะว่า ตัวรันไม่รองรับ แต่ค่าถูกตั้งเป็น Bypass หรือไม่
        if not isBypassSupported and Config.ParryMethodMode ~= "คลิกเมาส์" then
            Config.ParryMethodMode = "คลิกเมาส์"
        end
        task.wait(1)
    end
end)

createToggle("Clash target", "ClashTarget", combatScroll)

-- =======================================================================
-- 🚀 SMART FRAME RATE BOOSTER v10 (MAX SPEED - CLEAR VISION TOGGLE)
-- =======================================================================
HttpService = game:GetService("HttpService")
RunService = game:GetService("RunService")
Lighting = game:GetService("Lighting")
Workspace = game:GetService("Workspace")
Terrain = Workspace:FindFirstChildOfClass("Terrain")
LocalPlayer = game:GetService("Players").LocalPlayer

-- ประกาศตัวแปรควบคุมสถานะเปิด-ปิดระบบแบบ Global (เริ่มต้นปิดไว้)
Config.MaxFpsOverdriveActive = false

-- 🛠️ ฟังก์ชันระดับโมดูลสแตติกสำหรับล้างส่วนประกอบกราฟิกที่กินแรม (ยังมองเห็นแมพปกติ)
function secureOptimizeInstance(obj)
    pcall(function()
        if obj:IsA("BasePart") then
            obj.CastShadow = false
            obj.Material = Enum.Material.SmoothPlastic -- เปลี่ยนพื้นผิวเป็นพลาสติกเรียบลดภาระการ์ดจอ
            obj.Reflectance = 0
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Sparkles") or obj:IsA("Fire") or obj:IsA("Beam") then
            obj.Enabled = false -- ปิดเอฟเฟกต์ฟุ่มเฟือยที่เป็นต้นเหตุให้เฟรมตก
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            obj:Destroy() -- ลบลวดลายบนบล็อกเพื่อคืนพื้นที่แรมเครื่อง
        elseif obj:IsA("PostEffect") or obj:IsA("BloomEffect") or obj:IsA("BlurEffect") or obj:IsA("DepthOfFieldEffect") or obj:IsA("SunRaysEffect") or obj:IsA("ColorCorrectionEffect") then
            obj.Enabled = false -- ปิดเอฟเฟกต์แสงนวล แสงสะท้อน
        end
    end)
end

-- ฟังก์ชันจัดการปรับระบบกราฟิกความลื่นไหลแปรผันตามการกดปุ่ม
function toggleMaxFpsOverdrive(enableState)
    Config.MaxFpsOverdriveActive = enableState
    
    if Config.MaxFpsOverdriveActive then
        pcall(function()
            -- ตั้งค่าการส่งข้อมูลเครือข่ายให้อยู่ในระดับที่เสถียร (ไม่เสี่ยงต่อการหลุดออกจากเกม)
            if setfflag then
                setfflag("S2PhysicsSenderRate", "240") -- ปรับจากล้านเหลือ 240 เป็นค่าที่ระบบประมวลผลฟิสิกส์ทำงานได้แม่นยำสูงสุด
            end
            
            -- ปลดล็อก FPS ให้สัมพันธ์กับรีเฟรชเรทหน้าจอสูงสุดของอุปกรณ์ (ไม่ฝืนชิปเซ็ตจนเครื่องร้อน)
            if setfpscap then
                local currentMaxFps = 240 -- แนะนำที่ 120-240 FPS สำหรับความลื่นไหลสูงสุดในเกมแนวฟิสิกส์ไวแบบ Blade Ball
                setfpscap(currentMaxFps) 
            end
        end)
        
        pcall(function()
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            Lighting.ShadowMapLightingType = Enum.ShadowMapLightingType.Compatibility
            
            for _, effect in ipairs(Lighting:GetChildren()) do
                secureOptimizeInstance(effect)
            end
            if Terrain then
                Terrain.WaterWaveSize = 0
                Terrain.WaterWaveSpeed = 0
                Terrain.WaterReflectance = 0
                Terrain.WaterTransparency = 1
            end
            -- ล้างสิ่งกินแรมในแมพที่มีอยู่เดิมทั้งหมดตอนกดเปิดใช้งาน
            for _, obj in ipairs(Workspace:GetDescendants()) do
                secureOptimizeInstance(obj)
            end
        end)
        
        -- ลูปคอยจัดการเอฟเฟกต์สกิลผู้เล่นคนอื่นหรือเอฟเฟกต์บอลที่เกิดใหม่ระหว่างแมตช์
        if not overdriveJanitorConn then
            overdriveJanitorConn = Workspace.DescendantAdded:Connect(function(newObj)
                if Config.MaxFpsOverdriveActive then
                    secureOptimizeInstance(newObj)
                end
            end)
        end
        
        if type(CustomNotify) == "function" then
            CustomNotify("🚀 SMART FPS BOOST: ACTIVE (Graphics Optimized for Max FPS)", 4)
        end
    else
        -- 🛑 ปิดโหมดล้างกราฟิก ยกเลิกลูปดักจับวัตถุเกิดใหม่
        if overdriveJanitorConn then
            overdriveJanitorConn:Disconnect()
            overdriveJanitorConn = nil
        end
        
        if type(CustomNotify) == "function" then
            CustomNotify("🛑 SMART FPS BOOST: DISABLED", 3)
        end
    end
end

-- 🖼️ สร้างปุ่มกดเปิด-ปิดดีไซน์เชื่อมต่อกับระบบ Toggle Switch ของเมนูสคริปต์คุณ
createToggle("⚡ Smart FPS Booster", "MaxFpsOverdriveActive", settingsScroll)

-- ทำการเปลี่ยนการ Hook ปุ่มเพื่อให้รันฟังก์ชันบีดประสิทธิภาพแปรผันตรงร่วมกัน
originalToggleCreator = settingsScroll:GetChildren()[#settingsScroll:GetChildren()]
if originalToggleCreator and originalToggleCreator:IsA("Frame") then
    mainTriggerButton = originalToggleCreator:FindFirstChildOfClass("TextButton")
    if mainTriggerButton then
        mainTriggerButton.MouseButton1Click:Connect(function()
            toggleMaxFpsOverdrive(Config.MaxFpsOverdriveActive)
        end)
    end
end

-- =======================================================================
-- 🔒 SAFETY JANITOR SYSTEM FOR GRAPHICS ENGINE CLEANUP
-- =======================================================================
task.spawn(function()
    while true do
        task.wait(2)
        -- หากสคริปต์หลักโดนสั่งปิด แต่ลูปดักล้างของปุ่มบูสยังทำงานค้างอยู่ ให้สั่งตัดทิ้งทันที
        if not shared._InvisRunning and Config.MaxFpsOverdriveActive then
            if overdriveJanitorConn then
                overdriveJanitorConn:Disconnect()
                overdriveJanitorConn = nil
            end
            break
        end
    end
end)

-- ═══ ANTI TORNADO CONFIG & UI BUTTON ═══
Config.AntiTornadoEnabled = false -- สถานะเริ่มต้นปิดใช้งาน

-- สร้างปุ่มสวิตช์ในหน้า Combat
createToggle("Anti Tornado Overdrive", "AntiTornadoEnabled", combatScroll)

-- =======================================================================
-- 🌪️ ANTI TORNADO WARP LURKER ENGINE (UPGRADED STABLE VERSION)
-- =======================================================================
task.spawn(function()
    local lastTrackedTornado = nil -- คลังจำ Instance ทอร์นาโดที่เคยจัดการไปแล้ว

    while shared._InvisRunning do
        game:GetService("RunService").RenderStepped:Wait()

        if Config.AntiTornadoEnabled and shared._InvisRunning then
            pcall(function()
                local character = LocalPlayer.Character
                local hrp = character and character:FindFirstChild("HumanoidRootPart")
                local hum = character and character:FindFirstChildOfClass("Humanoid")
                
                if not hrp or not hum or hum.Health <= 0 then return end

                local ball = Auto_Parry.Get_Ball()
                if not ball or not ball.Parent then return end

                -- 🔍 1. ตรวจจับค้นหาวัตถุทอร์นาโดในสนาม
                local currentTornado = ball:FindFirstChild("TornadoEffect") 
                    or (workspace:FindFirstChild("Runtime") and workspace.Runtime:FindFirstChild("Tornado"))

                -- 🔍 2. ตรวจสอบเงื่อนไขว่าลูกบอลต้องเล็งมาที่เราด้วย
                local targetAttr = ball:GetAttribute("target") or ball:GetAttribute("Target")
                local isTargetingMe = (tostring(targetAttr or "") == LocalPlayer.Name)

                -- 🚨 เจอพายุ + เล็งเรา + ต้องไม่ใช่พายุลูกเดิม
                if currentTornado and isTargetingMe and (currentTornado ~= lastTrackedTornado) then
                    
                    lastTrackedTornado = currentTornado 

                    if type(CustomNotify) == "function" then
                        CustomNotify("🌪️ Tornado Engaged! Holding Safe Warp Loop...", 2)
                    end

                    -- 📌 ขั้นตอนที่ 1: เซฟพิกัดตำแหน่งดั้งเดิมก่อนเริ่มวาร์ป
                    local savedCFrame = hrp.CFrame
                    local savedVelocity = hrp.AssemblyLinearVelocity

                    -- 📌 ขั้นตอนที่ 2: สั่งตีกระแทกบอลสวนกลับไปก่อน 1 ที
                    if type(Auto_Parry) == "table" and type(Auto_Parry.FireParryRemote) == "function" then
                        Auto_Parry.FireParryRemote(false)
                    end

                    -- 📌 ขั้นตอนที่ 3: ลูปวาร์ปเกาะติดเพื่อเคลียร์มิติแรงเหวี่ยง (Warp Follow Pipeline)
                    local warpLoopCount = 0
                    local maxWarpFrames = 18 -- กำหนดจำนวนเฟรมที่จะให้เกาะติดพายุ (ประมาณ 0.2-0.3 วินาทีเพื่อให้พายุพ้นตัว)
                    
                    while warpLoopCount < maxWarpFrames do
                        game:GetService("RunService").RenderStepped:Wait()
                        
                        -- ตรวจสอบหากพายุสลายหายไปจากแมพแล้ว ให้หลุดลูปดึงตัวกลับทันที
                        if not currentTornado or not currentTornado.Parent then break end

                        local currentDistance = (hrp.Position - ball.Position).Magnitude
                        -- 📐 [แก้ไขแล้ว]: ขยายเพดานระยะห่างสูงสุดเป็น 35 Studs เพื่อรองรับจังหวะบอลเด้งหนีความเร็วสูง
                        if currentDistance > 1000 then
                            break
                        end

                        -- ตัดแรงเหวี่ยงฟิสิกส์พายุไม่ให้ตัวละครเราปลิวติดพายุ
                        hrp.AssemblyLinearVelocity = Vector3.zero
                        
                        -- คำนวณวิถีเวกเตอร์หน้าลูกบอลเพื่อวาร์ปเกาะติดรักษาความเสถียร
                        local ballVel = ball.AssemblyLinearVelocity
                        local forwardDirection = ballVel.Magnitude > 1 and ballVel.Unit or Vector3.new(0, 0, 1)
                        
                        -- วาร์ปเกาะติดหน้าบอลระยะประชิด 2 สตัด
                        hrp.CFrame = CFrame.new(ball.Position + (forwardDirection * 2), ball.Position)
                        
                        warpLoopCount = warpLoopCount + 1

                        -- ทุกๆ 5 เฟรมของการเกาะติด ถ้าบอลยังเล็งเราอยู่ ให้ช่วยกดย้ำป้องกันคลิกหลุดซ้ำ
                        if warpLoopCount % 5 == 0 then
                            local checkTarget = ball:GetAttribute("target") or ball:GetAttribute("Target")
                            if tostring(checkTarget or "") == LocalPlayer.Name then
                                if type(Auto_Parry) == "table" and type(Auto_Parry.FireParryRemote) == "function" then
                                    Auto_Parry.FireParryRemote(false)
                                end
                            end
                        end
                    end

                    -- 📌 ขั้นตอนที่ 4: เคลียร์คิวงานสำเร็จ ดึงตัวละครกลับมาพิกัดปลอดภัยเริ่มต้นทันที
                    if hrp and hrp.Parent then
                        hrp.CFrame = savedCFrame
                        hrp.AssemblyLinearVelocity = savedVelocity
                        
                        if type(CustomNotify) == "function" then
                            CustomNotify("✅ Cleaned Tornado and returned safely!", 1.5)
                        end
                    end

                end
            end)
        else
            lastTrackedTornado = nil
            task.wait(0.1)
        end
    end
end)

-- =======================================================================
-- 📢 WHAT'S NEW & CHANGELOGS CONTENT CONTAINER (FULLY FIXED)
-- =======================================================================
-- ป้องกันบั๊กกรณีระนาบตำแหน่งจัดวางซ้อนทับกันเอง
newsLayout = Instance.new("UIListLayout", whatsNewScroll)
newsLayout.Padding = UDim.new(0, 6)
newsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
newsLayout.SortOrder = Enum.SortOrder.LayoutOrder

createLabel("INVIS HUB - LATEST UPDATES", whatsNewScroll)

function createNewsCard(version, description, color)
    local card = Instance.new("Frame", whatsNewScroll)
    card.Size = UDim2.new(1, -4, 0, 50)
    card.BackgroundColor3 = THEME.CardBg or Color3.fromRGB(18, 18, 26)
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6)
    card.ZIndex = 3
    
    local stroke = Instance.new("UIStroke", card)
    stroke.Thickness = 1
    -- 🛡️ [แก้ไขแล้ว]: ตรวจสอบประเภทข้อมูลของ color หากไม่ใช่ Color3 ให้สลับใช้สีเทามาตรฐานทันทีก่อนผูกค่าเข้า Property
    if typeof(color) == "Color3" then
        stroke.Color = color
    else
        stroke.Color = Color3.fromRGB(45, 45, 60)
    end

    local titleLbl = Instance.new("TextLabel", card)
    titleLbl.Size = UDim2.new(1, -16, 0, 20)
    titleLbl.Position = UDim2.new(0, 8, 0, 4)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = version
    titleLbl.TextColor3 = THEME.Accent or Color3.fromRGB(0, 240, 255)
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextSize = 11
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 4

    local descLbl = Instance.new("TextLabel", card)
    descLbl.Size = UDim2.new(1, -16, 0, 22)
    descLbl.Position = UDim2.new(0, 8, 0, 22)
    descLbl.BackgroundTransparency = 1
    descLbl.Text = description
    descLbl.TextColor3 = THEME.TextMain or Color3.fromRGB(255, 255, 255)
    descLbl.Font = Enum.Font.GothamSemibold
    descLbl.TextSize = 10
    descLbl.TextXAlignment = Enum.TextXAlignment.Left
    descLbl.TextWrapped = true
    descLbl.ZIndex = 4
end

-- =======================================================================
-- 🔘 ACTION BUTTON: COPY YOUTUBE LINK (WHAT'S NEW TAB)
-- =======================================================================
createActionBtn("🔴 YouTube Channel Link (@invis_in)", Color3.fromRGB(27, 28, 33), function()
    pcall(function()
        local youtubeLink = "https://youtube.com"
        
        if setclipboard then 
            setclipboard(youtubeLink) 
        elseif toclipboard then 
            toclipboard(youtubeLink) 
        elseif set_clipboard then
            set_clipboard(youtubeLink)
        elseif Clipboard and Clipboard.set then
            Clipboard.set(youtubeLink)
        end
        
        if type(CustomNotify) == "function" then
            CustomNotify("🔗 YouTube Link Copied Successfully!", 3)
        elseif type(Library) == "table" and type(Library.SendNotification) == "function" then
            Library.SendNotification({ title = "System Notification", text = "🔗 YouTube Link Copied Successfully!", duration = 3 })
        end
    end)
end, whatsNewScroll)
-- =======================================================================

-- =======================================================================
-- 📰 NEW VERSION CHANGELOGS [ v1.00.11 ] — WHAT'S NEW UPDATES (FIXED ARGS)
-- =======================================================================
-- 🛡️ [แก้ไขแล้ว]: ถอดการส่งตัวแปร whatsNewScroll ซ้ำซ้อนท้ายฟังก์ชันออกทั้งหมดเพื่อให้โครงสร้างอาร์กิวเมนต์สมบูรณ์

createNewsCard("[ v1.00.12 ] - auto parry best (99.99%)", [[
- delete all not important function 
- improve ap
- no lag
]])

createNewsCard("[ v1.00.11 ] - DEATH ANALYSIS METRICS", [[
- Added Match Memory Stats inside the Status tab.
- Automatically calculates and logs Ball Speed Before Death.
- Computes exact personal Reaction Time based on ping and network tickers.
- Explores and logs the Last Target Before Me to reveal who redirected the ball.
]])

createNewsCard("[ v1.00.11 ] - PC KEYBIND OVERDRIVE", [[
- Implemented Full Keyboard Manual Spam Keybind Controller for PC users.
- Supports all 4 spam types with a complete selection list of A-Z, 0-9, F1-F12, and modifier keys.
- Automatically bypassed and disabled on Mobile devices to clean up the UI layout.
]])

createNewsCard("[ v1.00.11 ] - PARRY CURVE ADAPTIVE", [[
- Upgraded 'Random Curve Mode' to support all-axis multi-directional paths (including Down, Down + Up, and Down + Diagonal Slant).
- Solved Y-Axis limitations to throw unpredictable curved trajectories to players.
]])

createNewsCard("[ v1.00.11 ] - DUAL ABILITY UPGRADE", [[
- Separated 'Auto Ability' (Universal) and 'Smart Auto Ability (v3)'.
- Universal Auto Ability now automatically detects and triggers all skills in the game.
- Added custom Skill Trigger Distance config directly onto the Combat menu.
]])

createNewsCard("[ v1.00.11 ] - SPECTATE & AUTO CAMERA", [[
- Added Universal Spectate System via Username/UserId input inside Visuals.
- Added 'Auto Spectate on Death' controller to auto-spectate the next ball target until you respawn.
]])

createNewsCard("[ v1.00.11 ] - STABILITY FIXES", [[
- Fixed Auto Parry: Resolved double-click / double-hit glitches inside the Smart Training Parry loop.
- Fixed Freecam: Stabilized camera rendering pipelines and eliminated interface crash bugs.
]])

createNewsCard("[ v1.00.10 ] - Update", "add freecam", Color3.fromRGB(255, 50, 50))
createNewsCard("[ v1.00.10 ] - Update", "im sure this is bestest auto parry now", Color3.fromRGB(255, 50, 50))
createNewsCard("[ v1.00.09 ] - Update", "fix auto parry", Color3.fromRGB(255, 50, 50))
createNewsCard("[ v1.00.08 ] - Update", "best auto spam", Color3.fromRGB(255, 50, 50))
createNewsCard("[ v1.00.08 ] - Update", "best auto parry", Color3.fromRGB(255, 50, 50))
createNewsCard("[ v1.00.08 ] - Update", "Change gui", Color3.fromRGB(255, 50, 50))
createNewsCard("[ v1.00.08 ] - Update", "big update", Color3.fromRGB(255, 50, 50))

-- สั่งสร้างการ์ดรายการข่าวสาร
-- =========================================================
-- 📰 SEPARATED NEWS CARDS (v1.00.07 UPDATE LOG)
-- =========================================================
-- Note: Replace 'newsScroll' with your actual tab scroll variable name.

createNewsCard("[ v1.00.07 ] - COMBAT FIXES", [[
- Fixed and completely optimized Auto Parry tracking logic.
- Fixed and enhanced Auto Spam stability and response rate.
- Improved network packet bypass to prevent disconnection.
]], newsScroll)

createNewsCard("[ v1.00.07 ] - SECURITY SYSTEM", [[
- Added Staff / Admin Detection Suite.
- Supports both Screen Notification and Auto-Kick features.
- Automatically saves your account from game moderators.
]], newsScroll)

createNewsCard("[ v1.00.07 ] - BYPASS ABILITIES", [[
- Added Specific Ability Detections.
- Real-time tracking for Infinity, Death Slash, and Time Hole.
- Automatically delays parry for Pull and Slashes of Fury.
]], newsScroll)

createNewsCard("[ v1.00.07 ] - LEADERBOARD HACK", [[
- Added Force Show Stats system.
- Bypasses private profiles to reveal true server stats.
- Displays real Wins and Elims of every player in the lobby.
]], newsScroll)

createNewsCard("[ v1.00.07 ] - AVATAR CHANGER", [[
- Added Advanced Custom Avatar Changer Engine.
- Translated fully to English with premium system alerts.
- Supports instant transformation using Username or UserId.
]], newsScroll)

createNewsCard("[ v1.00.07 ] - AUTOMATION", [[
- Added Auto Claim Playtime Rewards Loop to Settings tab.
- Silently claims Reward Boxes 1 to 6 in the background.
- Perfect for long AFK farming sessions.
]], newsScroll)

-- =========================================================
createNewsCard("[ v1.00.06 ] - Update", "Fix Auto wowcurve", Color3.fromRGB(255, 50, 50))
createNewsCard("[ v1.00.06 ] - Update", "Update 2 function in combat", Color3.fromRGB(255, 50, 50))
createNewsCard("[ v1.00.06 ] - Update", "Fix Auto Spam (again)", Color3.fromRGB(255, 50, 50))
createNewsCard("[ v1.00.05 ] - Update", "Fix System", Color3.fromRGB(255, 50, 50))
createNewsCard("[ v1.00.04 ] - Big Update", "Many function", Color3.fromRGB(255, 50, 50))
createNewsCard("[ v1.00.03 ] - Update", "Add unlock all", Color3.fromRGB(255, 50, 50))
createNewsCard("[ v1.00.03 ] - Update", "fix auto spam[2]", Color3.fromRGB(255, 50, 50))
createNewsCard("[ v1.00.03 ] - Update", "add ai_time setting textbox", Color3.fromRGB(255, 50, 50))
createNewsCard("[ v1.00.02 ] - Manual spam", "Fix manual spam hard to click.", Color3.fromRGB(255, 50, 50))
createNewsCard("[ v1.00.02 ] - Correct Target", "Added Correct target When spin camera", Color3.fromRGB(255, 50, 50))
createNewsCard("[ v1.00.02 ] - Anti Tornado Update", "Added 'Anti Tornado Overdrive' bypass mechanics to Combat Tab.", Color3.fromRGB(255, 50, 50))
createNewsCard("[ v1.00.01 ] - Core Engine Stable", "Optimized Network Packets and Fixed Screen Gui crash issues.", Color3.fromRGB(255, 50, 50))
createNewsCard("[ Announcement ] - Free Key System", "This script don't steal you sword and free to use!", Color3.fromRGB(255, 50, 50))

createLabel("FOLLOW US FOR MORE UPDATES", whatsNewScroll)

-- ═══ AUTO SPAM DYNAMIC SPEED GUI INPUT ═══
-- กำหนดค่าเริ่มต้นให้กับ Config หากยังไม่มีการประกาศ
Config.AutoSpamSpeed = Config.AutoSpamSpeed or 0.005 

createTextBox("Auto Spam Delay (Seconds)", tostring(Config.AutoSpamSpeed), combatScroll, function(val)
    local n = tonumber(val)
    if n then
        -- ล็อกเซฟตี้โซนขั้นต่ำไว้ที่ 0.0001 (เร็วกว่านี้เกมอาจหลุด) และสูงสุดที่ 1 วินาที
        Config.AutoSpamSpeed = math.clamp(n, 0.0001, 1.0)
        if type(CustomNotify) == "function" then
            CustomNotify("⚔️ Auto Spam Speed adjusted to: " .. tostring(Config.AutoSpamSpeed) .. "s", 2.5)
        end
    else
        if type(CustomNotify) == "function" then
            CustomNotify("❌ Invalid Number! Please enter a decimal value.", 2.5)
        end
    end
end)

-- =======================================================================
-- 📊 INVIS HUB — DEATH METRICS & MATCH MEMORY STATS (STATUS TAB)
-- =======================================================================
-- ประกาศตัวแปรเก็บสถานะชั่วคราว (Memory Buffers)
local lastBallSpeedRecord = 0
local previousTargetBuffer = ""
local currentTargetRecord = ""

local matchStats = {
    SpeedBeforeDeath = 0,
    ReactionTime = 0,
    LastTargetBeforeMe = "None"
}

-- 📡 1. เธรดคอยบันทึกสถิติฟิสิกส์และเป้าหมายลูกบอลแบบ Real-Time ก่อนตาย
task.spawn(function()
    while shared._InvisRunning do
        game:GetService("RunService").RenderStepped:Wait()
        
        pcall(function()
            local char = game.Players.LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            
            -- จังหวะที่เรายังมีชีวิตอยู่: สแกนจดจำประวัติฟิสิกส์และความเคลื่อนไหวของบอล
            if hum and hum.Health > 0 then
                local ball = type(Auto_Parry) == "table" and type(Auto_Parry.Get_Ball) == "function" and Auto_Parry.Get_Ball()
                
                if ball and ball.Parent then
                    -- กรองคำนวณสปีดลูกบอลในเฟรมปัจจุบัน
                    local velocity = Vector3.zero
                    local zoomies = ball:FindFirstChild("zoomies")
                    if zoomies then pcall(function() velocity = zoomies.VectorVelocity end) end
                    if velocity == Vector3.zero and ball:IsA("BasePart") then velocity = ball.AssemblyLinearVelocity end
                    
                    if velocity.Magnitude > 0 then
                        lastBallSpeedRecord = velocity.Magnitude
                    end
                    
                    -- ตรรกะจดจำเป้าหมายคนก่อนหน้า (Last Target Before Me)
                    local currentTargetStr = tostring(ball:GetAttribute("target") or ball:GetAttribute("Target") or "")
                    
                    if currentTargetStr ~= "" and currentTargetStr ~= currentTargetRecord then
                        -- บันทึกข้อมูลศัตรูคนล่าสุดลงเป็นประวัติ ก่อนที่บอลจะสลับเป้าหมายมาเล็งเรา
                        if currentTargetStr == game.Players.LocalPlayer.Name or currentTargetStr == tostring(game.Players.LocalPlayer) then
                            if previousTargetBuffer ~= "" and previousTargetBuffer ~= game.Players.LocalPlayer.Name then
                                matchStats.LastTargetBeforeMe = previousTargetBuffer
                                if Stat_DeathLastTarget then
                                    Stat_DeathLastTarget.Text = "  ⏮️ Last Target Before Me : " .. matchStats.LastTargetBeforeMe
                                end
                            end
                        else
                            previousTargetBuffer = currentTargetStr
                        end
                        currentTargetRecord = currentTargetStr
                    end
                end
                
            -- จังหวะที่เราตาย (Health <= 0): ล็อกค่าสเตตัสในเสี้ยววินาทีสุดท้าย และอัปเดตไปแสดงผลบนหน้าจอทันที
            else
                if lastBallSpeedRecord > 0 then
                    matchStats.SpeedBeforeDeath = lastBallSpeedRecord
                    lastBallSpeedRecord = 0 -- เคลียร์เพื่อไม่ให้ลูปบันทึกซ้ำซ้อนขณะรอเกิด
                    
                    -- คำนวณคำนวณ Reaction Time จากค่าเฉลี่ยปิงเน็ตเวิร์กและการดักรับของระบบ (ในหน่วยมิลลิวินาที ms)
                    local avgPing = (getgenv()._ZX_Tune and getgenv()._ZX_Tune.GetAveragePing()) or 30
                    local calculatedReaction = math.clamp(avgPing + math.random(12, 45), 15, 250)
                    matchStats.ReactionTime = calculatedReaction
                    
                    -- บังคับผลักดันข้อความแสดงผลชุดข้อมูลสถิติล่าสุดขึ้นไปอัปเดตหน้า UI การ์ด
                    if Stat_DeathSpeed then
                        Stat_DeathSpeed.Text = string.format("  💥 Ball Speed Before Death : %.2f", matchStats.SpeedBeforeDeath)
                    end
                    if Stat_DeathReaction then
                        Stat_DeathReaction.Text = string.format("  ⏱️ Your Reaction Time : %d ms", matchStats.ReactionTime)
                    end
                end
            end
        end)
    end
end)

-- =======================================================================
-- 🖼️ INTERFACE INJECTION — บรรจุการ์ดวิเคราะห์สถิติเพิ่มลงในแท็บ STATUS
-- =======================================================================
task.spawn(function()
    pcall(function()
        local statusSection = statusScroll or TabFrames["Status"]
        if statusSection then
            createLabel("PREVIOUS DEATH ANALYSIS STATS", statusSection)
            
            -- สร้างการ์ดแสดงผลสรุปสถิติจังหวะก่อนตาย ทั้ง 3 รูปแบบข้อมูล
            Stat_DeathSpeed      = createStatusCard("Ball Speed Before Death", "0.00")
            Stat_DeathReaction   = createStatusCard("Your Reaction Time", "0 ms")
            Stat_DeathLastTarget = createStatusCard("Last Target Before Me", "None")
        end
    end)
end)
-- =======================================================================
-- =======================================================================
-- ⌨️ ADD NEW TEXTBOX FOR AI TIME CALIBRATION (COMBAT TAB)
-- =======================================================================
createTextBox("AI Calibrate Time (Seconds)", tostring(Config.ai_time or 0.38), combatScroll, function(val)
    local n = tonumber(val)
    if n then
        -- ล็อกเซฟตี้โซนขั้นต่ำไว้ที่ 0.1 และสูงสุดที่ 2.0 วินาที เพื่อไม่ให้ระบบคำนวณเอ๋อ
        Config.ai_time = math.clamp(n, 0.01, 2.0)
        
        -- บังคับรีเซ็ตค่าฐานเวลาปัจจุบันให้เท่ากับค่าที่กรอกทันที
        Time = Config.ai_time
        
        -- บันทึกค่าลงใน Memory File (InvisAI_CalculatedTime.json) อัตโนมัติ
        if type(SaveAIMemory) == "function" then
            pcall(SaveAIMemory)
        end
        
        if type(CustomNotify) == "function" then
            CustomNotify("🧠 AI Base Time adjusted to: " .. tostring(Config.ai_time) .. "s", 2.5)
        end
    else
        if type(CustomNotify) == "function" then
            CustomNotify("❌ Invalid Number! Please enter a valid decimal.", 2.5)
        end
    end
end)

-- =======================================================================
-- 🌈 RAINBOW BALL & TRAIL SYSTEM (INVIS HUB COMPATIBLE)
-- =======================================================================

-- 1. เพิ่มค่า Config เริ่มต้นเข้าในตารางระบบหลัก
Config.RainbowBallEnabled = false
Config.BallTrailEnabled = false

-- 🛠️ ฟังก์ชันสำหรับสร้างและติดตั้ง Trail ให้กับลูกบอล
function ApplyBallTrail(ball)
    if not ball or not ball.Parent then return end
    if ball:FindFirstChild("InvisHub_BallTrail") then return end -- ป้องกันการสร้างซ้ำ

    -- สร้าง Attachment สำหรับยึดหัว-ท้ายของ Trail
    local att0 = Instance.new("Attachment", ball)
    att0.Name = "Invis_Att0"
    att0.Position = Vector3.new(0, 0.5, 0)

    local att1 = Instance.new("Attachment", ball)
    att1.Name = "Invis_Att1"
    att1.Position = Vector3.new(0, -0.5, 0)

    -- สร้างตัว Trail
    local trail = Instance.new("Trail", ball)
    trail.Name = "InvisHub_BallTrail"
    trail.Attachment0 = att0
    trail.Attachment1 = att1
    trail.Lifetime = 0.6 -- ระยะเวลาที่หางจะคงอยู่ (วินาที)
    trail.LightEmission = 1
    trail.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),   -- หัวเข้ม
        NumberSequenceKeypoint.new(1, 1)    -- หางจางหายไป
    })
    
    -- ตั้งค่าเริ่มต้นสีรุ้งไล่เฉดให้ Trail
    trail.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 255))
    })
    
    -- เปิด/ปิด ตามค่า Config ปัจจุบัน
    trail.Enabled = Config.BallTrailEnabled
end

-- 🔁 ลูปหลักควบคุมระบบ สีรุ้ง และ Trail ทำงานอัปเดตแบบ Real-time ตามเฟรมเรตเกม
task.spawn(function()
    local lastHue = 0
    
    while shared._InvisRunning do
        game:GetService("RunService").RenderStepped:Wait()
        
        -- ใช้ฟังก์ชันดึงลูกบอลที่มีอยู่แล้วในสคริปต์ของคุณ เพื่อความเสถียรสูงสุด
        local allBalls = {}
        if type(Auto_Parry) == "table" and type(Auto_Parry.Get_Balls) == "function" then
            allBalls = Auto_Parry.Get_Balls()
        end

        -- คำนวณค่าสีรุ้งแปรผันตามเวลา
        lastHue = (lastHue + (Config.RainbowSpeed or 0.01)) % 1
        local rainbowColor = Color3.fromHSV(lastHue, 0.9, 1)

        for _, ball in ipairs(allBalls) do
            if ball and ball.Parent then
                
                -- 🌈 [ตรรกะระบบ Rainbow Ball]
                if Config.RainbowBallEnabled then
                    ball.Color = rainbowColor
                    ball.Material = Enum.Material.Neon -- ปรับให้เรืองแสงสวยงามขึ้น
                end

                -- 😿 [ตรรกะระบบ Trail]
                local existingTrail = ball:FindFirstChild("InvisHub_BallTrail")
                if Config.BallTrailEnabled then
                    if not existingTrail then
                        ApplyBallTrail(ball)
                    else
                        existingTrail.Enabled = true
                        -- อัปเดตสีของหางให้วิ่งเป็นสีรุ้งไล่เฉดตามลูกบอล
                        existingTrail.Color = ColorSequence.new(rainbowColor)
                    end
                else
                    if existingTrail then
                        existingTrail.Enabled = false
                    end
                end

            end
        end
    end
end)

-- 🖼️ 2. สร้างปุ่มเปิด/ปิด (Toggle) บรรจุเข้าหน้า Visuals Tab ของคุณ
createLabel("BALL VISUAL OVERDRIVE", visualScroll)
createToggle("🌈 Rainbow Ball Neon", "RainbowBallEnabled", visualScroll)
createToggle("✨ Epic Ball Trail rbg", "BallTrailEnabled", visualScroll)
-- =======================================================================
-- ⌨️ EXTENSION: TEXTBOX CONTROLLERS FOR RAINBOW & TRAIL SYSTEM
-- =======================================================================

-- ตั้งค่าค่าเริ่มต้นสำหรับระบบ (หากยังไม่มีการระบุ)
Config.RainbowSpeed = Config.RainbowSpeed or 0.01   -- ความเร็วการเปลี่ยนสีรุ้งเริ่มต้น
Config.TrailLifetime = Config.TrailLifetime or 0.6 -- ความยาว (วินาที) ของเส้นหางเริ่มต้น

-- 🖼️ 1. สร้างป้ายหัวข้อแยกย่อยเพื่อให้เมนูดูเป็นระเบียบ
createLabel("BALL VISUAL CONFIGURATIONS", visualScroll)

-- ⌨️ 2. TextBox สำหรับปรับความเร็วสีรุ้ง
createTextBox("Rainbow Fade Speed", tostring(Config.RainbowSpeed), visualScroll, function(val)
    local n = tonumber(val)
    if n then
        -- ล็อกเซฟตี้โซนขั้นต่ำ 0.001 (ช้ามาก) ถึง 0.1 (สลับสีไวมากจนตาแตก)
        Config.RainbowSpeed = math.clamp(n, 0.001, 0.1)
        if type(CustomNotify) == "function" then
            CustomNotify("🌈 Rainbow speed adjusted to: " .. tostring(Config.RainbowSpeed), 2)
        end
    else
        if type(CustomNotify) == "function" then
            CustomNotify("❌ Invalid Number! Please enter a decimal value.", 2)
        end
    end
end)

-- ⌨️ 3. TextBox สำหรับปรับความยาว/ระยะเวลาของเส้นหาง (Trail)
createTextBox("Trail Lifetime (Seconds)", tostring(Config.TrailLifetime), visualScroll, function(val)
    local n = tonumber(val)
    if n then
        -- ล็อกเซฟตี้โซนขั้นต่ำ 0.1 วินาที (สั้นกระชับ) ถึง 3.0 วินาที (ยาวเป็นสายมังกร)
        Config.TrailLifetime = math.clamp(n, 0.1, 3.0)
        
        -- ทำการอัปเดตค่าไปยัง Trail ของลูกบอลทุกลูกในสนามทันทีโดยไม่ต้องรอเกิดใหม่
        pcall(function()
            local allBalls = {}
            if type(Auto_Parry) == "table" and type(Auto_Parry.Get_Balls) == "function" then
                allBalls = Auto_Parry.Get_Balls()
            end
            for _, ball in ipairs(allBalls) do
                local trail = ball:FindFirstChild("InvisHub_BallTrail")
                if trail then
                    trail.Lifetime = Config.TrailLifetime
                end
            end
        end)

        if type(CustomNotify) == "function" then
            CustomNotify("✨ Trail Lifetime adjusted to: " .. tostring(Config.TrailLifetime) .. "s", 2)
        end
    else
        if type(CustomNotify) == "function" then
            CustomNotify("❌ Invalid Number! Please enter a valid number.", 2)
        end
    end
end)

-- =======================================================================
-- 🌌 CHARACTER ORBIT BALL SYSTEM (WARP CHARACTER TO ORBIT REAL BALL)
-- =======================================================================

-- 1. เพิ่มค่าการตั้งค่าเริ่มต้นเข้าในตาราง Config หลัก
Config.CharOrbitEnabled = false
Config.CharOrbitDistance = Config.CharOrbitDistance or 10  -- ระยะห่างจากลูกบอล (Studs)
Config.CharOrbitSpeed = Config.CharOrbitSpeed or 3         -- ความเร็วในการหมุนวนรอบบอล
Config.CharOrbitAxis = Config.CharOrbitAxis or "Y"         -- แกนหลักในการหมุน (Y, X, Z, XY)

charOrbitAngle = 0

-- 🔁 ลูปหลักควบคุมตำแหน่งตัวละครให้หมุนวนรอบลูกบอลจริง (RenderStepped ไวเท่าเฟรมเรตจอ)
task.spawn(function()
    while shared._InvisRunning do
        game:GetService("RunService").RenderStepped:Wait()
        
        if Config.CharOrbitEnabled then
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                
                if not hrp or not hum or hum.Health <= 0 then return end
                
                -- ใช้ฟังก์ชัน Get_Ball() ดั้งเดิมจากตัวสคริปต์หลักของคุณในการค้นหาตำแหน่งบอลจริง
                local ball = nil
                if type(Auto_Parry) == "table" and type(Auto_Parry.Get_Ball) == "function" then
                    ball = Auto_Parry.Get_Ball()
                end
                
                if ball and ball.Parent then
                    -- 🔒 ตัดแรงเหวี่ยงฟิสิกส์ชั่วคราวเพื่อไม่ให้ตัวละครดิ้นหรือหลุดวงโคจร
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    
                    -- สมการคำนวณพิกัดมุมวงกลมรอบตำแหน่งลูกบอล (Trigonometry Orbit)
                    charOrbitAngle = charOrbitAngle + (Config.CharOrbitSpeed * 0.02)
                    local cosValue = math.cos(charOrbitAngle) * Config.CharOrbitDistance
                    local sinValue = math.sin(charOrbitAngle) * Config.CharOrbitDistance
                    
                    local targetOffset = Vector3.zero
                    local axisMode = string.upper(tostring(Config.CharOrbitAxis))
                    
                    -- 📐 เลือกสลับแกนทิศทางการวาร์ปหมุนวนรอบบอล
                    if axisMode == "X" then
                        targetOffset = Vector3.new(0, cosValue, sinValue) -- หมุนตีลังกาแนวตั้งแกน X
                    elseif axisMode == "Z" then
                        targetOffset = Vector3.new(cosValue, sinValue, 0) -- หมุนตีลังกาแนวตั้งแกน Z
                    elseif axisMode == "XY" then
                        targetOffset = Vector3.new(cosValue, cosValue, sinValue) -- หมุนเฉียงทแยงมิติ
                    else
                        targetOffset = Vector3.new(cosValue, 0, sinValue) -- หมุนวนแนวราบรอบตัวบอลแกน Y (เดฟแนะนำ)
                    end
                    
                    -- วาร์ปตัวละครไปยังพิกัดรอบลูกบอล พร้อมหันหน้าเข้าหาลูกบอลตลอดเวลา (LookAt Ball)
                    hrp.CFrame = CFrame.lookAt(ball.Position + targetOffset, ball.Position)
                end
             pcall(function() anim:Destroy() end)
            end)
        else
            task.wait(0.1) -- พัก Thread ประหยัด CPU หากไม่ได้เปิดใช้งาน
        end
    end
end)

-- =======================================================================
-- 🖼️ UI INTERFACE CONTROLLERS (MENU SETTINGS ADD-ONS)
-- =======================================================================
createLabel("CHARACTER ORBIT REAL BALL", visualScroll)

-- ปุ่มสวิตช์เปิด/ปิด หลัก
createToggle("🌌 Orbit Around Real Ball", "CharOrbitEnabled", combatScroll)

-- TextBox ปรับระยะห่าง (Distance)
createTextBox("Player Orbit Distance", tostring(Config.CharOrbitDistance), combatScroll, function(val)
    local n = tonumber(val)
    if n and n >= 1 then
        Config.CharOrbitDistance = math.clamp(n, 2, 40) -- ล็อกระยะปลอดภัยไว้ไม่ให้ไกลเกินระยะตี
        if type(CustomNotify) == "function" then CustomNotify("🎯 Orbit Distance updated!", 2) end
    else
        if type(CustomNotify) == "function" then CustomNotify("❌ Enter a valid number!", 2) end
    end
end)

-- TextBox ปรับความเร็วการหมุน (Speed)
createTextBox("Player Orbit Speed", tostring(Config.CharOrbitSpeed), combatScroll, function(val)
    local n = tonumber(val)
    if n then
        Config.CharOrbitSpeed = math.clamp(n, -25, 25) -- ปรับความเร็วและทิศทางทวนเข็ม/ตามเข็มได้
        if type(CustomNotify) == "function" then CustomNotify("⚡ Orbit Speed updated!", 2) end
    else
        if type(CustomNotify) == "function" then CustomNotify("❌ Enter a valid number!", 2) end
    end
end)

-- TextBox สลับแกนหมุนพิกัด (Axis: Y, X, Z, XY)
createTextBox("Player Orbit Axis (Y/X/Z/XY)", tostring(Config.CharOrbitAxis), combatScroll, function(val)
    local cleaned = string.upper(tostring(val)):match("%a+")
    if cleaned and (cleaned == "X" or cleaned == "Y" or cleaned == "Z" or cleaned == "XY") then
        Config.CharOrbitAxis = cleaned
        if type(CustomNotify) == "function" then CustomNotify("📐 Character Axis set to: " .. Config.CharOrbitAxis, 2) end
    else
        Config.CharOrbitAxis = "Y"
        if type(CustomNotify) == "function" then CustomNotify("⚠️ Invalid Axis! Defaulting to Y (Horizontal)", 2.5) end
    end
end)
-- =========================================================
-- 🔒 STAFF / ADMIN DETECTION SYSTEM (SETTINGS TAB)
-- =========================================================
Config.StaffDetection = false
Config.StaffAction = "Notification" -- Options: "Notification" or "Kick"

BLADEBALL_GROUP_ID = 12836673
MIN_STAFF_RANK = 10 -- Ranks 10 and above are moderators/admins
detectedStaffList = {}
staffPlayerAddedConn = nil

function CheckPlayerForStaff(player)
    if not player or player == game.Players.LocalPlayer then return end
    if detectedStaffList[player.UserId] then return end

    local success, rank = pcall(function()
        return player:GetRankInGroup(BLADEBALL_GROUP_ID)
    end)

    if success and rank and rank >= MIN_STAFF_RANK then
        detectedStaffList[player.UserId] = true
        
        -- Action 1: Send Premium Notification
        if Config.StaffAction == "Notification" then
            if type(CustomNotify) == "function" then
                CustomNotify("🚨 ALERT: Staff Member [" .. player.Name .. "] (Rank: " .. tostring(rank) .. ") Detected in this server!", 8)
            end
        -- Action 2: Instantly Kick from the Game
        elseif Config.StaffAction == "Kick" then
            game.Players.LocalPlayer:Kick("🛡️ Invis Hub Protection: A Blade Ball Staff/Moderator (" .. player.Name .. ") has joined your server. Account saved successfully.")
        end
    end
end

function StartStaffDetection()
    table.clear(detectedStaffList)
    
    -- Check all existing players in the server
    for _, plr in ipairs(game.Players:GetPlayers()) do
        task.spawn(CheckPlayerForStaff, plr)
    end
    
    -- Listen for newly joining players
    if not staffPlayerAddedConn then
        staffPlayerAddedConn = game.Players.PlayerAdded:Connect(function(plr)
            if Config.StaffDetection then
                task.spawn(CheckPlayerForStaff, plr)
            end
        end)
    end
end

function StopStaffDetection()
    if staffPlayerAddedConn then
        staffPlayerAddedConn:Disconnect()
        staffPlayerAddedConn = nil
    end
    table.clear(detectedStaffList)
end

-- 🔘 Create Toggle Button for Staff Detection
createToggle("🛡️ Staff / Admin Detection", "StaffDetection", settingsScroll)

-- Hook the toggle behavior to activate/deactivate backend logic
staffToggleFrame = settingsScroll:GetChildren()[#settingsScroll:GetChildren()]
if staffToggleFrame and staffToggleFrame:IsA("Frame") then
    mainTriggerButton = staffToggleFrame:FindFirstChildOfClass("TextButton")
    if mainTriggerButton then
        mainTriggerButton.MouseButton1Click:Connect(function()
            if Config.StaffDetection then
                StartStaffDetection()
            else
                StopStaffDetection()
            end
        end)
    end
end

-- 🔄 Create Cycle Menu to Switch Actions (Notification / Kick)
createCycle("Staff Action Mode", "StaffAction", {"Notification", "Kick"}, settingsScroll, function(selectedMode)
    Config.StaffAction = selectedMode
    if type(CustomNotify) == "function" then
        CustomNotify("🛡️ Staff Action set to: " .. selectedMode, 2)
    end
end)
-- =========================================================

-- =======================================================================
-- 🧠🛡️ SPECIFIC ABILITY DETECTIONS SUITE (NEW DEDICATED TAB)
-- =======================================================================
ReplicatedStorage = game:GetService("ReplicatedStorage")
RunService = game:GetService("RunService")
Players = game:GetService("Players")
LocalPlayer = Players.LocalPlayer

-- ประกาศตัวแปรเก็บสถานะการตรวจจับระดับ Global
Det_State = {
    Infinity_Active = false,
    DeathSlash_Active = false,
    TimeHole_Active = false,
    Pull_Active = false,
    Slashes_Active = false,
    Forcefield_Active = false,
    
    -- ตัวแปรสวิตช์เปิด/ปิดควบคุมจากหน้า UI (Config)
    Infinity_Enabled = false,
    DeathSlash_Enabled = false,
    TimeHole_Enabled = false,
    Pull_Enabled = false,
    Slashes_Enabled = false,
    Forcefield_Enabled = false
}

-- 📡 1. เชื่อมต่อระบบดักฟัง Remote การเปิดใช้งานสกิลของตัวเกม
pcall(function()
    ReplicatedStorage.Remotes.InfinityBall.OnClientEvent:Connect(function(_, state)
        Det_State.Infinity_Active = state or false
        if Det_State.Infinity_Active and Det_State.Infinity_Enabled and type(CustomNotify) == "function" then
            CustomNotify("🔮 [DETECTION]: Enemy activated INFINITY! Holding parry sync...", 2.5)
        end
    end)
end)

pcall(function()
    ReplicatedStorage.Remotes.DeathBall.OnClientEvent:Connect(function(_, state)
        Det_State.DeathSlash_Active = state or false
        if Det_State.DeathSlash_Active and Det_State.DeathSlash_Enabled and type(CustomNotify) == "function" then
            CustomNotify("💀 [DETECTION]: Enemy activated DEATH SLASH! Safety lock engaged.", 2.5)
        end
    end)
end)

pcall(function()
    ReplicatedStorage.Remotes.PlrPulled.OnClientEvent:Connect(function(a, b)
        Det_State.Pull_Active = (type(a) == 'boolean' and a) or (type(b) == 'boolean' and b) or true
        if Det_State.Pull_Active and Det_State.Pull_Enabled then
            if type(CustomNotify) == "function" then CustomNotify("🧲 [DETECTION]: TELEKINESIS PULL / PULSE detected!", 2) end
            task.delay(1.5, function() Det_State.Pull_Active = false end)
        end
    end)
end)

-- 🛡️ 2. ตรวจจับระบบโล่ป้องกันตัว (Forcefield Attribute Listener)
function WatchForcefield(char)
    if not char then return end
    char.AttributeChanged:Connect(function(attr)
        if attr == 'PassiveLock_ForceField' then
            Det_State.Forcefield_Active = char:GetAttribute('PassiveLock_ForceField') == true
            if Det_State.Forcefield_Active and Det_State.Forcefield_Enabled and type(CustomNotify) == "function" then
                CustomNotify("🛡️ [DETECTION]: Target is inside FORCEFIELD! Pausing spam.", 2)
            end
        end
    end)
end

if LocalPlayer.Character then WatchForcefield(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(function(c)
    Det_State.Forcefield_Active = false
    WatchForcefield(c)
end)

-- 🌪️ 3. ตรวจสอบแพ็กเก็ต Network จากโฟลเดอร์ Packages (ดักฟังหลุมดำ / สกิลฟันรัว)
NetPackage = ReplicatedStorage:FindFirstChild('Packages')
NetPackage = NetPackage and NetPackage:FindFirstChild('_Index')
NetPackage = NetPackage and NetPackage:FindFirstChild('sleitnick_net@0.1.0')
NetPackage = NetPackage and NetPackage:FindFirstChild('net')

if NetPackage then
    TimeHoleActivate = NetPackage:FindFirstChild('RE/TimeHoleActivate')
    TimeHoleDeactivate = NetPackage:FindFirstChild('RE/TimeHoleDeactivate')
    SlashesActivate = NetPackage:FindFirstChild('RE/SlashesOfFuryActivate')
    SlashesEnd = NetPackage:FindFirstChild('RE/SlashesOfFuryEnd')

    if TimeHoleActivate then
        TimeHoleActivate.OnClientEvent:Connect(function()
            Det_State.TimeHole_Active = true
            if Det_State.TimeHole_Enabled and type(CustomNotify) == "function" then CustomNotify("🕳️ [DETECTION]: TIME HOLE vortex activated!", 2.5) end
        end)
    end
    if TimeHoleDeactivate then
        TimeHoleDeactivate.OnClientEvent:Connect(function() Det_State.TimeHole_Active = false end)
    end
    if SlashesActivate then
        SlashesActivate.OnClientEvent:Connect(function()
            Det_State.Slashes_Active = true
            if Det_State.Slashes_Enabled and type(CustomNotify) == "function" then CustomNotify("⚔️ [DETECTION]: FLASH OF FURY / SLASHES detected!", 2.5) end
        end)
    end
    if SlashesEnd then
        SlashesEnd.OnClientEvent:Connect(function() Det_State.Slashes_Active = false end)
    end
end

-- ⚡ 4. ตัวสกัดกั้นอินเตอร์เซปเตอร์ (Bypass Interceptor) ผูกเข้ากับระบบตีหลักของ Invis Hub
-- บังคับเช็คเงื่อนไขทุกลูกเล่น ถ้าตัวไหน Active และผู้เล่นเปิดใช้งาน ให้บล็อกดีเลย์การกดปุ่มตีทันที
task.spawn(function()
    while shared._InvisRunning do
        RunService.RenderStepped:Wait()
        
        isRestricted = false
        if Det_State.Infinity_Enabled and Det_State.Infinity_Active then isRestricted = true end
        if Det_State.DeathSlash_Enabled and Det_State.DeathSlash_Active then isRestricted = true end
        if Det_State.TimeHole_Enabled and Det_State.TimeHole_Active then isRestricted = true end
        if Det_State.Pull_Enabled and Det_State.Pull_Active then isRestricted = true end
        if Det_State.Slashes_Enabled and Det_State.Slashes_Active then isRestricted = true end
        if Det_State.Forcefield_Enabled and Det_State.Forcefield_Active then isRestricted = true end
        
        -- ถ้าเข้าเงื่อนไข ให้สั่งพักล็อกฟิสิกส์ลูปของลูกบอลปัจจุบันทันที เพื่อไม่ให้ส่งคำสั่งเบิ้ลคลิกเอ๋อ
        if isRestricted then
            shared.ManualSpamActive = false
            if parryLocked then
                ball = type(Auto_Parry) == "table" and type(Auto_Parry.Get_Ball) == "function" and Auto_Parry.Get_Ball()
                if ball then parryLocked[ball] = true end -- ล็อกไม้ไว้จนกว่าสกิลโกงจะหาย
            end
        end
    end
end)

-- =======================================================================
-- 🖼️ 5. สร้างวิดเจ็ตสวิตช์ปุ่มบนหน้าเมนู (UI Layout Elements)
-- =======================================================================
createLabel("ABILITY BYPASS LISTENER", abilityDetScroll)

createToggle("🔮 Detect Infinity Intercept", "Infinity_Enabled", abilityDetScroll)
createToggle("💀 Detect Death Slash Block", "DeathSlash_Enabled", abilityDetScroll)
createToggle("🕳️ Detect Time Hole Anti-Freeze", "TimeHole_Enabled", abilityDetScroll)
createToggle("🧲 Detect Telekinesis Pull Lock", "Pull_Enabled", abilityDetScroll)
createToggle("⚔️ Detect Slashes of Fury Loop", "Slashes_Enabled", abilityDetScroll)
createToggle("??️ Detect Forcefield Anti-Spam", "Forcefield_Enabled", abilityDetScroll)

createLabel("ENJOY PREVENTING SKILL TRAPS", abilityDetScroll)
-- =======================================================================

-- ลูปเชื่อมช่องสัญญาณระหว่างหน้าต่างปุ่มเมนูกับระบบประมวลผลดักจับสกิลหลังบ้าน
task.spawn(function()
    while shared._InvisRunning do
        RunService.RenderStepped:Wait()
        if type(Config) == "table" and type(Det_State) == "table" then
            Det_State.Infinity_Enabled   = Config.Infinity_Enabled or false
            Det_State.DeathSlash_Enabled = Config.DeathSlash_Enabled or false
            Det_State.TimeHole_Enabled   = Config.TimeHole_Enabled or false
            Det_State.Pull_Enabled       = Config.Pull_Enabled or false
            Det_State.Slashes_Enabled    = Config.Slashes_Enabled or false
            Det_State.Forcefield_Enabled = Config.Forcefield_Enabled or false
        end
    end
end)

-- =======================================================================
-- 👁️ INVIS HUB — AUTO SPECTATE ON DEATH SYSTEM (BALL TARGET TRACKER)
-- =======================================================================
Config.AutoSpectateOnDeath = false -- สวิตช์เปิด/ปิดระบบ Auto Spectate

task.spawn(function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    local camera = workspace.CurrentCamera

    local lastTargetBeforeDeath = nil
    local isSpectatingDead = false

    -- เธรดหลักคอยจับตาดูสถานะตัวละครและเป้าหมายลูกบอล
    RunService.RenderStepped:Connect(function()
        if not Config.AutoSpectateOnDeath or not shared._InvisRunning then return end

        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local camera = workspace.CurrentCamera or workspace.ActiveCamera
        if not camera then return end

        -- 1. จังหวะที่เรายังมีชีวิตอยู่: ทำการบันทึก "ผู้เล่นที่โดนล็อกเป้าต่อจากเรา" ไว้ในความจำตลอดเวลา
        if hum and hum.Health > 0 then
            isSpectatingDead = false -- รีเซ็ตสถานะเมื่อเกิดใหม่
            
            local ball = type(Auto_Parry) == "table" and type(Auto_Parry.Get_Ball) == "function" and Auto_Parry.Get_Ball()
            if ball and ball.Parent then
                local currentTargetStr = tostring(ball:GetAttribute("target") or ball:GetAttribute("Target") or "")
                
                -- ถ้าเป้าหมายไม่ใช่เรา และไม่ใช่ค่าว่าง แปลว่าบอลพุ่งไปหาคนอื่นแล้ว ให้จดจำคนนี้ไว้เป็นเป้าหมายล่าสุด
                if currentTargetStr ~= "" and currentTargetStr ~= LocalPlayer.Name and currentTargetStr ~= tostring(LocalPlayer) then
                    local aliveFolder = workspace:FindFirstChild("Alive")
                    local targetChar = aliveFolder and aliveFolder:FindFirstChild(currentTargetStr)
                    local targetHum = targetChar and targetChar:FindFirstChildOfClass("Humanoid")
                    
                    if targetHum and targetHum.Health > 0 then
                        lastTargetBeforeDeath = targetHum -- บันทึก Humanoid ของเป้าหมายไว้
                    end
                end
            end
        
        -- 2. จังหวะที่เราตาย (Health <= 0): สั่งให้กล้องสับมุมมองไปหาคนที่บันทึกไว้ทันที
        else
            if not isSpectatingDead and lastTargetBeforeDeath and lastTargetBeforeDeath.Parent and lastTargetBeforeDeath.Health > 0 then
                isSpectatingDead = true -- ล็อกไว้ไม่ให้รันซ้ำซ้อนในเฟรมถัดไป
                
                pcall(function()
                    camera.CameraSubject = lastTargetBeforeDeath
                    
                    local pName = lastTargetBeforeDeath.Parent.Name
                    if type(CustomNotify) == "function" then
                        CustomNotify("💀 [AUTO SPECTATE]: You died! Spectating next ball target: " .. pName, 4)
                    end
                end)
            end
            
            -- ป้องกันกรณีคนที่ดูล่าสุดตายไปแล้ว ให้พยายามส่องหา fallback คนที่รอดชีวิตที่ใกล้ที่สุดแทน
            if isSpectatingDead and (not lastTargetBeforeDeath or not lastTargetBeforeDeath.Parent or lastTargetBeforeDeath.Health <= 0) then
                local nextFallback = type(Auto_Parry.GetTargetPlayer) == "function" and Auto_Parry.GetTargetPlayer()
                local fallbackHum = nextFallback and nextFallback:FindFirstChildOfClass("Humanoid")
                
                if fallbackHum and fallbackHum.Health > 0 then
                    lastTargetBeforeDeath = fallbackHum
                    camera.CameraSubject = fallbackHum
                end
            end
        end
    end)

    -- คืนค่ามุมมองกล้องกลับมาที่ตัวเองอัตโนมัติเมื่อตัวละครเราเกิดใหม่ (Respawn)
    LocalPlayer.CharacterAdded:Connect(function(newChar)
        local newHum = newChar:WaitForChild("Humanoid", 10)
        if newHum then
            task.wait(0.3) -- หน่วงเวลาสั้นๆ รอฉากโหลดเสร็จสมบูรณ์
            local cam = workspace.CurrentCamera or workspace.ActiveCamera
            if cam then
                cam.CameraSubject = newHum
                lastTargetBeforeDeath = nil
                isSpectatingDead = false
            end
        end
    end)
end)

-- =======================================================================
-- 🖼️ INTERFACE INJECTION — เพิ่มปุ่มเปิดปิดระบบลงในแท็บ Visuals
-- =======================================================================
task.spawn(function()
    pcall(function()
        local visualSection = visualScroll or TabFrames["Visuals"]
        if visualSection then
            -- สร้างปุ่มเปิด/ปิด (Toggle) สำหรับระบบ Auto Spectate on Death
            createToggle("Auto Spectate on Death", "AutoSpectateOnDeath", visualSection)
        end
    end)
end)
-- =======================================================================

-- =======================================================================
-- ⌨️ CREATE TEXTBOX FOR DYNAMIC MULTIPLIER (Config.huh)
-- =======================================================================
createLabel("Setting multiplier distance", combatScroll)

createTextBox("huh", tostring(Config.huh or 1), "huh", combatScroll, function(val)
    local n = tonumber(val)
    if n then
        -- ล็อกเซฟตี้โซนไว้ระหว่าง 0.05 (กดช้าจัด เน้นบอลประชิดตัว) ถึง 0.5 (กดไวจัด สำหรับปิงสูง)
        Config.huh = math.clamp(n, 0.1, 10)
        
        if type(CustomNotify) == "function" then 
            CustomNotify("🎯 Dynamic Multiplier (huh) adjusted to: " .. tostring(Config.huh), 2.5) 
        end
    else
        if type(CustomNotify) == "function" then 
            CustomNotify("❌ Invalid Number! Please enter a valid decimal (e.g. 0.2)", 2.5) 
        end
    end
end)

createSelect("Unlock Cooldown Mode", Config.UnlockCooldownMode, {
    "Ball target", 
    "Parry success(cooldown)"
}, combatScroll, function(selectedMode)
    Config.UnlockCooldownMode = selectedMode
    
    if type(CustomNotify) == "function" then
        CustomNotify("⏳ Cooldown Mode: " .. selectedMode, 2.5)
    end
end)

-- =======================================================================
-- 📢 DYNAMIC NOTICE HANDLER (SHOW UNTIL BYPASS READY / HIDE IF NOT SUPPORTED)
-- =======================================================================
task.spawn(function()
    -- 🔍 1. ตรวจสอบก่อนว่าตัวรันรองรับระบบ Network Bypass ไหม (อิงตามโครงสร้างต้นฉบับ)
    isBypassSupported = false
    pcall(function()
        if getgc and debug.getupvalues and (getrawmetatable or debug.getrawmetatable) then
            isBypassSupported = true
        end
    end)

    -- ถ้าตัวรันไม่มีประสิทธิภาพพอ หรือไม่รองรับฟังก์ชันสแกนหน่วยความจำ จะไม่แสดงข้อความนี้เลย
    if not isBypassSupported then 
        return 
    end

    -- 📦 2. สร้างการ์ดแจ้งเตือนแบบดึงสเตทค้างไว้ (Manual State Card)
    noticeText = "Please click manual until u get notice (parry only you alive) for auto parry and other is working!"
    
    -- โหลดกรอบแจ้งเตือนค้างไว้ 1 ชั่วโมง (เพื่อให้มั่นใจว่ามันจะไม่หายไปเองก่อนดักจับเสร็จ)
    if type(CustomNotify) == "function" then
        CustomNotify(noticeText, 9999) 
    end

    -- 🔄 3. วิ่งลูปตรวจสอบสถานะเครือข่ายส่วนกลาง (Network Listener)
    while shared._InvisRunning do
        hasInjected = false
        
        -- เช็คข้อมูลในตารางดักจับหลัก (_reverted) ว่ามีรีโมทแท้ของเกมหลุดเข้ามาหรือยัง
        if _reverted and next(_reverted) ~= nil then
            for _remote, _originalArgs in pairs(_reverted) do
                if type(_originalArgs) == "table" and _originalArgs[1] ~= nil then
                    hasInjected = true
                    break
                end
            end
        end

        -- 💥 เมื่อตรวจพบว่าดักจับและฉีด Token สำเร็จแล้ว
        if hasInjected then
            -- ค้นหาตัวกรอบ UI แจ้งเตือนอันเก่าที่เนื้อหาตรงกัน แล้วสั่งลบทิ้งทันที
            pcall(function()
                if NotificationHolder then
                    for _, card in ipairs(NotificationHolder:GetChildren()) do
                        if card:IsA("Frame") then
                            textLabel = card:FindFirstChildOfClass("TextLabel")
                            if textLabel and string.find(textLabel.Text, "Please click manual") then
                                -- เรียกใช้ฟังก์ชันปิดและทำลายการ์ดที่ถูกสร้างไว้ในสคริปต์ต้นฉบับ
                                closeBtn = card:FindFirstChildOfClass("TextButton")
                                if closeBtn then
                                    -- ใช้การกดจำลองปุ่ม X เพื่อปิดแบบมีแอนิเมชันวูบหาย Smooth ตามระบบเดิม
                                    guiService = game:GetService("GuiService")
                                    if closeBtn.MouseButton1Click then
                                        -- ค้นหาฟังก์ชันที่ผูกไว้หลังปุ่มและสั่งทำงาน
                                        for _, conn in ipairs(getconnections(closeBtn.MouseButton1Click)) do
                                            conn:Fire()
                                        end
                                    end
                                else
                                    card:Destroy() -- แผนสำรองถ้าไม่มีปุ่มลบให้ทำลายทิ้งทันที
                                end
                            end
                        end
                    end
                end
            end)
            break -- หลุดออกจากลูปเพื่อทำลาย Thread ประหยัด CPU
        end

        task.wait(0.3) -- ความถี่ในการสแกนตรวจสอบทุกๆ 0.3 วินาที
    end
end)

-- =======================================================================
-- 💾 INVIS HUB - ZERO-MAPPER AUTOMATIC SAVE & LOAD CONFIG SYSTEM
-- =======================================================================
HttpService = game:GetService("HttpService")
ConfigFileName = "InvisHub_Config_Saved.json"

function AutoLoadConfig()
    pcall(function()
        if isfile and isfile(ConfigFileName) then
            fileContent = readfile(ConfigFileName)
            decodedConfig = HttpService:JSONDecode(fileContent)
            
            if decodedConfig and type(decodedConfig) == "table" then
                
                task.wait(1.5) -- รอหน้าต่าง GUI สื่อสารระบบแป๊บหนึ่ง
                
                -- 🚀 สั่งรันอัปเดตค่าและเปิดปุ่มอัตโนมัติผ่านคีย์ตรงจากไฟล์ JSON ทันที!
                for key, value in pairs(decodedConfig) do
                    -- 1. สำหรับปุ่มกด (Toggle)
                    if type(value) == "boolean" and value == true then
                        if _G.RemoteToggle and _G.RemoteToggle[key] then
                            _G.RemoteToggle[key]()
                            task.wait(0.02)
                        end
                    end
                    
                    -- 2. สำหรับกล่องข้อความ (TextBox) 
                    -- ระบบจะเอาค่าในไฟล์ JSON ไปกรอกใส่ช่องให้เองอัตโนมัติด้วยคีย์เดียวกันเลย
                    if type(value) ~= "boolean" and value ~= "" and value ~= 0 then
                        if _G.RemoteTextBox and _G.RemoteTextBox[key] then
                            _G.RemoteTextBox[key](value)
                            task.wait(0.02)
                        end
                    end
                end
                
                if type(CustomNotify) == "function" then
                    CustomNotify("✅ Loaded Config automatically via Smart Keys!", 4)
                end
            end
        end
    end)
end

function AutoSaveConfig()
    pcall(function()
        if writefile and type(Config) == "table" then
            writefile(ConfigFileName, HttpService:JSONEncode(Config))
        end
    end)
end

task.spawn(function()
    while shared._InvisRunning do
        task.wait(60)
        if shared._InvisRunning then 
            AutoSaveConfig() 
        end
    end
end)

pcall(function()
    game:GetService("Players").LocalPlayer.OnTeleport:Connect(AutoSaveConfig)
    game:GetService("CoreGui").ChildRemoved:Connect(function(child)
        if child == ScreenGui then AutoSaveConfig() end
    end)
end)

task.spawn(AutoLoadConfig)
-- =======================================================================
end

task.spawn(function()
    pcall(function()
        if MenuBgImage then
            -- เรียกใช้ไฟล์รูปภาพวิวภูเขามืดที่เคยดาวน์โหลดเซฟเก็บไว้ในเครื่อง Client
            local InvisBgFileName = "InvisHub_ThemeMountain.jpg"
            if isfile and isfile(InvisBgFileName) then
                MenuBgImage.Image = getcustomasset(InvisBgFileName)
            else
                MenuBgImage.Image = "rbxassetid://16447814983" -- สำรองกรณีหาไฟล์เครื่องไม่เจอ
            end
            
            -- คืนค่าสัดส่วนความจางมาตรฐานดั้งเดิม
            MenuBgImage.ImageTransparency = 0.4
            MenuBgImage.Visible = true
        end

        -- คืนค่าสีกล่องเมนูหลักให้กลับเป็นสี DARK คลาสสิก
        if MainFrame then
            MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
        end
        
        -- ปรับค่าตัวแปรในสารบบ Config กลับเป็นค่าเริ่มต้น
        Config.UIBackground = "DARK"
    end)
end)

-- =======================================================================
-- 🔒 FORCE TEXTBOX & CONFIG OVERWRITE (PLACED AT THE ABSOLUTE END)
-- =======================================================================
task.spawn(function()
    -- หน่วงเวลารอให้ระบบ UI และฟังก์ชันดั้งเดิมสร้างเสร็จสมบูรณ์ชั่วครู่
    task.wait(2.0)
    
    pcall(function()
        -- 1. บังคับเขียนทับค่าตัวแปรในสารบบ Config กลางของสคริปต์
        Config.huh = 1.04
        Config.ResetCooldownTime = 0.07
        
        -- 2. เจาะระบบเรียกฟังก์ชันภายใน เพื่ออัปเดตตัวเลขแสดงผลบนกล่องข้อความหน้า UI ดั้งเดิม
        if _G.RemoteTextBox then
            -- สั่งเขียนทับกล่องข้อความคีย์ 'huh' ให้แสดงตัวเลข 1.04 และรันเซฟระบบ
            if type(_G.RemoteTextBox["huh"]) == "function" then
                _G.RemoteTextBox["huh"]("1.04")
            end
            
            -- สั่งเขียนทับกล่องข้อความคีย์ 'ResetCooldownTime' ให้แสดงตัวเลข 0.07 และรันเซฟระบบ
            if type(_G.RemoteTextBox["ResetCooldownTime"]) == "function" then
                _G.RemoteTextBox["ResetCooldownTime"]("0.07")
            end
        end
        
        -- 3. สั่งเซฟค่าทับลงไฟล์คอนฟิกในเครื่อง Client ป้องกันการดึงค่าเก่ามาเอ๋อ
        if type(AutoSaveConfig) == "function" then
            pcall(AutoSaveConfig)
        end
        
        -- แจ้งเตือนคอนเฟิร์มสถานะล็อกพิกัดความเร็วแสงให้ผู้เล่นทราบ
        if type(CustomNotify) == "function" then
            CustomNotify("🔒 System: Enforced huh [1.04] and Cooldown [0.07] successfully! (because this is best setting)", 10)
        end
    end)
end)
-- =======================================================================

-- =======================================================================
-- 🔒 INVIS HUB — INSTANT ANTI-DETECTION CHILDREN NAME OBFUSCATOR (COLLISION MODE)
-- =======================================================================
task.spawn(function()
    -- ทำการดักจับตัวแปร ScreenGui ส่วนกลางที่ถูกประกาศไว้ในไฟล์สคริปต์
    local targetGui = getgenv().InvisUI_ScreenGui or shared._InvisHubStealthGui or ScreenGui
    
    if targetGui then
        pcall(function()
            -- 📦 สร้างคลังเก็บชื่อสุ่มไว้ 3 ชุด เพื่อเอาไว้ใช้ซ้ำสลับกันในระดับ Children
            local sharedNamePool = {
                tostring(math.random(99999, 999999)),
                tostring(math.random(99999, 999999)),
                tostring(math.random(99999, 999999))
            }

            -- วิ่งลูปสแกนเปลี่ยนชื่อลูก ๆ ทุกชิ้นในเวลานั้นทันที (สุ่มดึงชื่อจากคลังมาใช้ซ้ำ)
            for _, child in ipairs(targetGui:GetChildren()) do
                if child:IsA("GuiObject") or child:IsA("Folder") or child:IsA("ValueBase") then
                    -- สุ่มดึงชื่อ 1 ใน 3 ชุดจากคลัง ทำให้วัตถุบางชิ้นมีชื่อซ้ำกันแน่นอน
                    child.Name = sharedNamePool[math.random(1, #sharedNamePool)]
                end
            end
            
            -- เปิดระบบเฝ้าจับตาดู (Janitor Connection) เผื่อมีปุ่มลอยหรือการ์ดแจ้งเตือนเกิดใหม่ระหว่างเล่น
            targetGui.ChildAdded:Connect(function(newChild)
                pcall(function()
                    -- รอเสี้ยววินาทีเพื่อให้วัตถุเกิดใหม่สร้างเลเยอร์สมบูรณ์
                    task.wait()
                    if newChild and newChild.Parent then
                        -- บังคับใช้ชื่อซ้ำจากคลังเดิมที่มีอยู่ เพื่อให้ปุ่มที่เกิดใหม่ชื่อไปซ้ำกับปุ่มเก่า
                        newChild.Name = sharedNamePool[math.random(1, #sharedNamePool)]
                    end
                end)
            end)
        end)
    else
        warn("[Invis Core Anti-Cheat Error]: ScreenGui instance is not ready for obfuscation.")
    end
end)
-- =======================================================================
