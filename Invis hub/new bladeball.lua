-- yes this was the actual source. It is fully vibecoded.

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
local RunService        = game:GetService("RunService")
local Players           = game:GetService("Players")
local LocalPlayer       = Players.LocalPlayer
local Player            = Players.LocalPlayer
local UserInputService  = game:GetService("UserInputService")
local TweenService      = game:GetService("TweenService")
local CoreGui           = game:GetService("CoreGui")
local StarterGui        = game:GetService("StarterGui")
local StatsService      = game:GetService("Stats")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris            = game:GetService("Debris")
local Lighting          = game:GetService("Lighting")
local TeleportService   = game:GetService("TeleportService")
local HttpService       = game:GetService("HttpService")

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
    ManualSpam = false,
    ManualSpamSpeed = 0.015,
    SuperSpam = false,
    SuperSpamClicks = 1,
    AutoAbility = false, 
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
    huh = 1
}

local BackgroundColors = {
    "DARK",
    "RED",
    "BLUE",
    "PURPLE",
    "GREEN",
    "ORANGE"
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

-- สั่งเริ่มสร้าง Instance ScreenGui เมื่อตรวจสอบแล้วว่าโฟลเดอร์ปลายทางพร้อมใช้งาน
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "InvisHub_Horizontal_" .. math.random(100, 999)
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

-- ═══ CUSTOM STACK-SAFE NOTIFICATION GUI QUEUE ═══
local NotificationHolder = Instance.new("Frame", ScreenGui)
NotificationHolder.Size = UDim2.new(0, 240, 0, 450)
NotificationHolder.Position = UDim2.new(1, -255, 0, 30)
NotificationHolder.BackgroundTransparency = 1
local notifyList = Instance.new("UIListLayout", NotificationHolder)
notifyList.Padding = UDim.new(0, 6)
notifyList.SortOrder = Enum.SortOrder.LayoutOrder

-- 🎨 ULTIMATE CYBERPUNK DYNAMIC NOTIFICATION SYSTEM (WITH CLOSE BUTTON & AUTO-WRAP)
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")

local function CustomNotify(text, duration)
    duration = duration or 4
    local timeLeft = duration

    -- 📦 1. สร้างกรอบการ์ดแจ้งเตือนหลัก (Main Card Container)
    local card = Instance.new("Frame", NotificationHolder)
    card.Size = UDim2.new(1, 0, 0, 40) -- ขนาดเริ่มต้น 1 บรรทัด
    card.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
    card.BackgroundTransparency = 0.1
    card.BorderSizePixel = 0
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)

    -- ✨ เอฟเฟกต์ขอบเรืองแสงไล่เฉดสี (Modern Neon Stroke)
    local stroke = Instance.new("UIStroke", card)
    stroke.Thickness = 1.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local strokeGradient = Instance.new("UIGradient", stroke)
    strokeGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 60, 90)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(152, 181, 255))
    })

    -- 🏷️ 2. ไอคอนและข้อความแจ้งเตือน (Icon & Dynamic Text Label)
    local txt = Instance.new("TextLabel", card)
    txt.Position = UDim2.new(0, 10, 0, 0)
    txt.Size = UDim2.new(1, -65, 1, -4) -- เว้นพื้นที่ด้านขวาให้ปุ่ม X และเวลานับถอยหลัง
    txt.Text = "🔔 " .. text
    txt.TextColor3 = Color3.fromRGB(245, 245, 250)
    txt.FontFace = Font.fromEnum(Enum.Font.GothamBold)
    txt.TextSize = 11
    txt.BackgroundTransparency = 1
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.TextYAlignment = Enum.TextYAlignment.Center
    txt.TextWrapped = true -- เปิดใช้งานระบบขึ้นบรรทัดใหม่อัตโนมัติ

    -- 📐 [DYNAMIC RESIZING]: คำนวณความยาวข้อความ หากยาวเกินหน้าจอให้ขยายกรอบเป็น 2 บรรทัด
    task.spawn(function()
        local maxTextWidth = NotificationHolder.AbsoluteSize.X - 75
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
    timeLabel.TextColor3 = Color3.fromRGB(140, 140, 160)
    timeLabel.Font = Enum.Font.GothamSemibold
    timeLabel.TextSize = 10
    timeLabel.TextXAlignment = Enum.TextXAlignment.Right

    -- 🔘 4. ปุ่มกดปิดแบบเร่งด่วน (X Close Button)
    local closeBtn = Instance.new("TextButton", card)
    closeBtn.Size = UDim2.new(0, 20, 0, 20)
    closeBtn.Position = UDim2.new(1, -26, 0.5, -10)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 75, 75)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 12
    closeBtn.AutoButtonColor = false

    -- ⏳ 5. หลอดความคืบหน้าเวลาด้านล่างการ์ด (Neon Progress Timeline Bar)
    local progressBar = Instance.new("Frame", card)
    progressBar.Size = UDim2.new(1, -16, 0, 2)
    progressBar.Position = UDim2.new(0, 8, 1, -4)
    progressBar.BackgroundColor3 = Color3.fromRGB(255, 60, 90)
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

    TweenService:Create(card, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {BackgroundTransparency = 0.1}):Play()
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
        -- แก้ไขโหมดสุ่มพิกัด: กระจายทิศทางแบบ 360 องศารอบตัวศัตรู ทั้งแกนระนาบและมุมสูง (เดาทางยากที่สุด)
        local randomAngle = math.rad(math.random(0, 360))
        local randomX = math.cos(randomAngle) * math.random(300, 600)
        local randomZ = math.sin(randomAngle) * math.random(300, 600)
        local randomY = math.random(100, 500)
        return targetPos + Vector3.new(randomX, randomY, randomZ)
    elseif parryCurveMode == "Straight" then
        return targetPos
    end
    
    return targetPos
end

Auto_Parry.CalculateParryCframe = Auto_Parry.CalculateParryCFrame

local replicated_storage = cloneref(game:GetService('ReplicatedStorage'))
local workspace = cloneref(game:GetService('Workspace'))

local _token
for _, Function in getgc(true) do
    if type(Function) ~= 'function' or not debug.info(Function, 's'):find('PRY', 1, true) then
        continue
    end

    for _, value in debug.getupvalues(Function) do
        if type(value) == 'function' then
            print('found.')
            _token = value
            break
        end
    end

    if _token then
        break
    end
end

function _tokenize(_remote_uid)
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

local _reverted = {}
local _original = {}
local _captured = nil

function _is_valid(args)
    return #args == 8 and type(args[2]) == "string" and type(args[3]) == "string" and type(args[4]) == "number" and typeof(args[5]) == "CFrame" and type(args[6]) == "table" and type(args[7]) == "table" and type(args[8]) == "boolean"
end

function _hook(remote)
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

for _iterator, _remote in pairs(replicated_storage:GetDescendants()) do
    if _remote:IsA('RemoteEvent') or _remote:IsA('RemoteFunction') then
        _hook(_remote)
    end
end

task.wait(1)

-- ===== SAFE INPUT FOR PC BYPASS FALLBACK =====
local function fireParryInput()
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

local isPCUser = not game:GetService("UserInputService").TouchEnabled
local hasNotifiedBypassFail = false

-- 🔍 [EXECUTOR CAPABILITY DETECTOR] ตรวจสอบว่าตัวรันรองรับฟังก์ชันสำหรับใช้รัน Bypass รีโมทหรือไม่
local isBypassSupported = false
pcall(function()
    -- เช็คการมีอยู่ของฟังก์ชันที่ Invis Hub และ PRY จำเป็นต้องใช้ในการสกัดโทเค็นและดักจับเครือข่าย
    if getgc and debug.getupvalues and (getrawmetatable or debug.getrawmetatable) then
        isBypassSupported = true
    end
end)

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

        return (dot < 0.75 and dot > -0.6)
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

-- =======================================================================
-- 🎮 SMART AUTO ABILITY v3 (FIXED & FULLY FUNCTIONAL VERSION)
-- =======================================================================
local AbilityRemote = nil
local AbilityRawFunc = nil
local abilityHooked = false

local AutoAbilityData = {
    Enabled = false,
    LastAbilityName = nil,
}
getgenv().ZX_AutoAbility = AutoAbilityData

-- [FIXED]: ปรับปรุงคีย์เวิร์ดชื่อสกิลให้ครอบคลุมทั้งชื่อสั้นและชื่อเต็มของระบบเกม
local ABILITY_TIMINGS = {
    ["Raging Deflection"] = { cooldown = 15, fireAt = 0.2, trigger = "target" },
    ["Raging"]            = { cooldown = 15, fireAt = 0.2, trigger = "target" },
    ["Calming Deflection"] = { cooldown = 15, fireAt = 0.4, trigger = "target" },
    ["Calming"]            = { cooldown = 15, fireAt = 0.4, trigger = "target" },
    ["Rapture"]            = { cooldown = 20, fireAt = 0.1, trigger = "proximity" },
    ["Aerodynamic Slash"]  = { cooldown = 12, fireAt = 0.3, trigger = "target" },
    ["Windpass"]           = { cooldown = 12, fireAt = 0.3, trigger = "target" },
    ["Fracture"]           = { cooldown = 18, fireAt = 0.2, trigger = "proximity" },
    ["Death Slash"]        = { cooldown = 25, fireAt = 0.1, trigger = "clash" },
}
getgenv().ZX_AbilityTimings = ABILITY_TIMINGS

local _abilityLastFire = {}

-- Hook Remote สำหรับกดใช้ Ability
task.spawn(function()
    task.wait(2)
    pcall(function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local abilRemote = ReplicatedStorage:WaitForChild("Remotes", 5):FindFirstChild("AbilityButtonPress") or ReplicatedStorage:WaitForChild("Remotes", 5):FindFirstChild("AbilityAttempt")
        if abilRemote then
            if abilRemote:IsA("RemoteEvent") then
                AbilityRemote = abilRemote
                AbilityRawFunc = abilRemote.FireServer
                abilityHooked = true
            elseif abilRemote:IsA("RemoteFunction") then
                AbilityRemote = abilRemote
                AbilityRawFunc = abilRemote.InvokeServer
                abilityHooked = true
            end
        end
    end)
end)

local function fireAbilityRemote()
    if not AbilityRemote or not AbilityRawFunc then
        pcall(function()
            game:GetService("ReplicatedStorage").Remotes.AbilityButtonPress:FireServer()
        end)
        return true
    end
    pcall(function()
        if AbilityRemote:IsA("RemoteEvent") then
            AbilityRawFunc(AbilityRemote)
        else
            AbilityRemote:InvokeServer()
        end
    end)
    return true
end

-- [FIXED]: ปรับตรรกะเช็คปุ่มให้เสถียรขึ้น ถ้าหา UI ไม่เจอให้ข้ามไปทำงานเลยเพื่อป้องกันระบบค้าง
local function isAbilityReady()
    local success, ready = pcall(function()
        local PlayerGui = game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui")
        if not PlayerGui then return true end
        
        local screenGui = PlayerGui:FindFirstChild("ScreenGui") or PlayerGui:FindFirstChild("MainGui") or PlayerGui:FindFirstChild("HotbarGui")
        if screenGui then
            local hotbar = screenGui:FindFirstChild("Hotbar") or screenGui:FindFirstChild("AbilityFrame") or screenGui:FindFirstChild("Actions")
            local abilityBtn = hotbar and (hotbar:FindFirstChild("AbilityButton") or hotbar:FindFirstChild("Ability") or hotbar:FindFirstChildOfClass("ImageButton"))
            
            if abilityBtn then
                local cdFrame = abilityBtn:FindFirstChild("Cooldown") or abilityBtn:FindFirstChild("Darken")
                if cdFrame and cdFrame.Visible and cdFrame.Transparency < 0.1 then
                    return false
                end
            end
        end
        return true
    end)
    return success and ready
end

local function isAbilityOffCooldown(abilityName)
    local timing = ABILITY_TIMINGS[abilityName]
    if not timing then return true end
    local lastFire = _abilityLastFire[abilityName] or 0
    return (tick() - lastFire) >= timing.cooldown
end

local function getEquippedAbility()
    local char = game:GetService("Players").LocalPlayer.Character
    if not char then return nil end
    
    -- ดึงจาก Attribute ของผู้เล่นโดยตรง (เสถียรที่สุด ตามแบบแผน source: 5)
    local plrAttr = game:GetService("Players").LocalPlayer:GetAttribute("EquippedAbility") or game:GetService("Players").LocalPlayer:GetAttribute("Ability")
    if plrAttr and plrAttr ~= "" and plrAttr ~= "None" then
        return plrAttr
    end

    local abilities = char:FindFirstChild("Abilities")
    if not abilities then return nil end
    for name, _ in pairs(ABILITY_TIMINGS) do
        local abil = abilities:FindFirstChild(name)
        if abil and (abil:GetAttribute("Equipped") or abil.Enabled == true) then
            return name
        end
    end
    for _, abil in ipairs(abilities:GetChildren()) do
        if abil:GetAttribute("Equipped") or abil.Enabled == true then
            return abil.Name
        end
    end
    local first = abilities:GetChildren()[1]
    return first and first.Name or nil
end
getgenv().ZX_GetEquippedAbility = getEquippedAbility

local _lastBallTargetTime = 0
local _lastClashTime = 0
local _isTrackingTarget = false

local function smartAutoAbility()
    if not Config.AutoAbility then return false end
    if not isAbilityReady() then return false end

    local abilityName = getEquippedAbility()
    if not abilityName then return false end

    local timing = ABILITY_TIMINGS[abilityName]
    
    -- [SAFE FALLBACK]: ถ้าไม่เจอชื่อสกิลในตารางตรรกะ ให้บังคับยิงรีโมทออกไปทันทีเพื่อแก้ขัด ป้องกันสคริปต์ค้าง
    if not timing then
        task.spawn(function()
            local fired = fireAbilityRemote()
            if fired then
                AutoAbilityData.LastAbilityName = abilityName
                _abilityLastFire[abilityName] = tick()
            end
        end)
        return false  
    end

    if not isAbilityOffCooldown(abilityName) then return false end

    local ball = Auto_Parry.Get_Ball()
    if not ball then return false end

    local target = ball:GetAttribute("target") or ball:GetAttribute("Target")
    local isTargetingMe = (tostring(target or "") == game:GetService("Players").LocalPlayer.Name)

    local char = game:GetService("Players").LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local ballDist = 999
    if hrp and ball.Parent then
        ballDist = (ball.Position - hrp.Position).Magnitude
    end

    local velocity = ball.AssemblyLinearVelocity
    local zoomies = ball:FindFirstChild("zoomies")
    if zoomies then pcall(function() velocity = zoomies.VectorVelocity end) end
    local speed = velocity.Magnitude
    local reachTime = ballDist / math.max(speed, 1)

    local shouldFire = false
    if timing.trigger == "target" then
        if isTargetingMe then
            -- [FIXED]: เปลี่ยนจาก <= มาเป็นช่วงเรนจ์ดักจับ เพื่อป้องกันเฟรมเรตข้ามจังหวะจนปุ่มไม่ทำงาน
            if reachTime <= (timing.fireAt + 0.05) or ballDist <= 45 then
                shouldFire = true
            end
            -- [EXTENSION]: หากบอลวิ่งเร็วเกิน 500 ให้ขยายเกณฑ์การหลบหลีกฉุกเฉินกว้างขึ้นเป็นระยะ 35 สตัดทันที
            if speed > 500 and ballDist <= 35 then
                shouldFire = true
            end
        end
    elseif timing.trigger == "proximity" then
        if isTargetingMe and ballDist <= 35 then
            shouldFire = true
        end
    elseif timing.trigger == "clash" then
        if shared.ManualSpamActive or (tick() - _lastClashTime) <= 0.5 then
            shouldFire = true
        end
    end

    if not shouldFire then return false end

    task.spawn(function()
        local fired = fireAbilityRemote()
        if fired then
            AutoAbilityData.LastAbilityName = abilityName
            _abilityLastFire[abilityName] = tick()
            pcall(function() CustomNotify("⚡ Smart Ability Activated: " .. abilityName, 2.5) end)
        end
    end)
    return false  
end

getgenv().ZX_SmartAutoAbility = smartAutoAbility

-- ดักจับเหตุการณ์ปะทะกันในสนามเพื่อเก็บสถิติสกิลสาย Clash
pcall(function()
    game:GetService("ReplicatedStorage").Remotes.ParrySuccessAll.OnClientEvent:Connect(function(_, root)
        if root and root.Parent and root.Parent ~= game:GetService("Players").LocalPlayer.Character then
            _lastClashTime = tick()
        end
    end)
end)

-- ลูปหลักในการสั่งการให้ระบบทำงานอย่างต่อเนื่อง
task.spawn(function()
    while true do
        task.wait(0.03) -- เร่งความถี่ให้ตอบสนองไวขึ้นต่อเฟรมเกม
        if Config.AutoAbility and shared._InvisRunning then
            smartAutoAbility()
        end
    end
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
                    CustomNotify("🎯 Locked Double Click Target: " .. model.Name, 2.5)
                end
            end
        else
            -- ดับเบิ้ลคลิกพื้นที่ว่างเพื่อเคลียร์การล็อกเป้าหมาย
            if shared.Clicked_Target_Name and now - lastClickTime >= 1.5 then
                shared.Clicked_Target_Name = nil
                CustomNotify("🔓 Target Unlocked (Auto Mode)", 2)
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

-- =======================================================================
-- 🛡️ [CORE FIX] INVIS HUB AUTO PARRY PREDATOR — ANTI DRIFTING OUTSIDE GATE
-- =======================================================================
if shared._PhysicsParryBind then shared._PhysicsParryBind:Disconnect() end

shared._PhysicsParryBind = RunService.RenderStepped:Connect(function()
    if not shared._InvisRunning then return end

    local character = LocalPlayer.Character
    if not character or not character.PrimaryPart then return end

    local hrp = character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart
    if not hrp then return end

    local balls = SafeGetBalls()
    if #balls == 0 then return end

    local playerPos = hrp.Position
    local now = os.clock()
    
    local cfg = (type(Config) == "table") and Config or {}
    local autoParryEnabled = cfg.AutoParry or false
    local soccerMode = cfg.SoccerMode or false
    local parryMode = cfg.ParryMode or "Curve"
    local distanceTiming = cfg.DistanceTiming or 100

    -- Scanner กลุ่มลูกบอลซ้อนประชิดตัวสำหรับโหมดพ่วง Burst
    local myTargetedBalls = {}
    for _, b in ipairs(balls) do
        if b and b.Parent then
            local tAttr = b:GetAttribute("target") or b:GetAttribute("Target")
            if tostring(tAttr or "") == LocalPlayer.Name then
                table.insert(myTargetedBalls, b)
            end
        end
    end

    local multiBallBurstCount = 1
    if #myTargetedBalls >= 2 then
        for i = 1, #myTargetedBalls do
            local ballA = myTargetedBalls[i]
            local distToMe = (playerPos - ballA.Position).Magnitude
            if distToMe < 25 then
                local closeGroupCount = 1
                for j = 1, #myTargetedBalls do
                    if i ~= j then
                        local ballB = myTargetedBalls[j]
                        if (ballA.Position - ballB.Position).Magnitude < 8 then
                            closeGroupCount = closeGroupCount + 1
                        end
                    end
                end
                if closeGroupCount > multiBallBurstCount then multiBallBurstCount = closeGroupCount end
            end
        end
    end

    for idx, Ball in ipairs(balls) do
        if not Ball or typeof(Ball) ~= "Instance" or not Ball.Parent then continue end

        local ballPos = Ball.Position
        local Distance = (playerPos - ballPos).Magnitude

        local Velocity = Vector3.zero
        local Zoomies = Ball:FindFirstChild("zoomies")
        
        if Zoomies then
            local s, v = pcall(function() return Zoomies.VectorVelocity end)
            if s and v then Velocity = v end
        end
        if Velocity == Vector3.zero and Ball:IsA("BasePart") then
            Velocity = Ball.AssemblyLinearVelocity
        end

        local Speed = Velocity.Magnitude
        local ballDirection = Speed > 1 and Velocity.Unit or Vector3.new(0, -1, 0)
        local toPlayerDirection = Distance > 0.1 and (playerPos - ballPos).Unit or Vector3.zero
        local dotProduct = ballDirection:Dot(toPlayerDirection)

        local targetAttr = Ball:GetAttribute("target") or Ball:GetAttribute("Target")
        local ballTargetStr = tostring(targetAttr or "")
        local isTargetingMe = (ballTargetStr == LocalPlayer.Name or ballTargetStr == tostring(LocalPlayer))

        if soccerMode then
            isTargetingMe = (dotProduct > -0.15 or Distance <= 16)
        end

        if not isTargetingMe then
            lastHitTicks[Ball] = 0
            parryLocked[Ball] = false
            lockTime[Ball] = 0
            continue
        end

        -- HARD LOCK COOLDOWN BYPASS
        if parryLocked[Ball] then
            local safeLockCooldown = math.clamp(4.9 - (Speed * 0.01), 0.7, 0.85)
            if multiBallBurstCount > 1 then safeLockCooldown = 0.46 end
            
            if now - (lockTime[Ball] or 0) >= safeLockCooldown then
                parryLocked[Ball] = false
            else
                continue
            end
        end        

        local reachTime = Distance / math.max(Speed, 1)
        local allowedToHit = isTargetingMe and not parryLocked[Ball]
        
        if autoParryEnabled and allowedToHit then
            local triggerParry = false
            local userScale = distanceTiming / 100
            local emergencyDist = SafeGetEmergencyDistance(Speed) + 2.5

            if reachTime <= 0.05 and isTargetingMe then
                triggerParry = true
            end
            
            if Speed > 490 then
                local triggerTimeThreshold = pingSeconds + 0.34
                if (reachTime <= triggerTimeThreshold or Distance <= emergencyDist) and isTargetingMe then
                    triggerParry = true
                end
            else
                -- 🎯 คำนวณสถานะหลบข้าง (Anti-Drift): ถ้าบอลไม่ได้โค้งเอียงแกน Y แต่ด็อทโปรดักส์ต่ำกว่า 0.45 
                -- แปลว่าลูกบอลพุ่งขนานฉีกหนีทิศตัวเราออกไปข้าง ๆ (ล็อกประตูห้ามตีก่อนเด็ดขาดเพื่อเซฟคูลดาวน์)
                local isBallCurvingReal = (dotProduct < 0.75 and dotProduct > -0.6)
                local isBallDriftingOutside = (not isBallCurvingReal) and (dotProduct < 0.45)

                if parryMode == "Curve" then
                    local maxCurveDist = (Speed > 400) and 43 or 23
                    local bypassAntiCurve = (Distance <= emergencyDist and Distance <= maxCurveDist)

                    if bypassAntiCurve then
                        triggerParry = true
                    else
                        local lateralVelocity = Velocity - (Velocity.Unit:Dot(toPlayerDirection) * Velocity.Unit)
                        local isDroppingDown = ballDirection.Y < -0.15
                        
                        local pingBuffer = (pingSeconds * Speed * 1.18)
                        local baseStrikeZone = (12.5 + (Speed * (Config.wowcurve or 0.35))) - (lateralVelocity.Magnitude * 0.13) + pingBuffer
                        
                        local currentHuh = tonumber(Config.huh) or 1
                        -- =======================================================================
                        -- DYNAMIC STRIKE ZONE ACCORDING TO SPEED (ระบบขยายขอบเขตการปล่อยไม้ตามความเร็วบอล)
                        -- =======================================================================
                        local maxStrikeLimit = 92 -- ค่าเริ่มต้นปกติ (กรณีความเร็วบอลไม่เกิน 800)

                        if Speed > 1450 then
                            maxStrikeLimit = 300 -- ถ้าความเร็วบอลเกิน 1450 จะปลดล็อกขอบเขตไปถึง 300 สตัด
                        elseif Speed > 800 then
                            maxStrikeLimit = 145 -- ถ้าความเร็วบอลเกิน 800 จะขยายขอบเขตไปสูงสุดที่ 145 สตัด
                        end

                        local strikeZone = math.clamp(baseStrikeZone, 18, maxStrikeLimit) * userScale * currentHuh
                        -- =======================================================================
                        
-- =======================================================================
-- 🎯 [CORE FIX] ANTI-DRIFT IN CURVE MODE (ดักบอลฉีกออกข้างในโหมดไซด์โค้ง)
-- =======================================================================
-- เช็คว่าถ้าบอลไม่ได้โค้งดิ่งลง (แกน Y) แต่ด็อทต่ำกว่า 0.45 แปลว่าบอลกำลังวิ่งฉีกหนีออกไปข้าง ๆ 
local isCurveDriftingOutside = (not isDroppingDown) and (dotProduct < 0.45)

if Distance <= strikeZone or reachTime <= 0.08 then
    -- บอทจะยอมตีในโหมด Curve ก็ต่อเมื่อ บอลไม่ได้พุ่งฉีกออกข้าง หรือหลุดเข้าระยะประชิดตัวเผาขน 15 Studs ทันที
    if (dotProduct > -0.15 or Distance <= 22) and (not isCurveDriftingOutside or Distance <= 15) then
        triggerParry = true
    end
end
-- =======================================================================

                    end
                elseif parryMode == "Normal" then
                    -- โหมดตรงปกติ: เพิ่มเงื่อนไขดักจับ Anti-Drift (จะตีต่อเมื่อไม่ฉีกออกข้าง หรือลูกบอลจี้หลุดเข้าเผาขน 13 Studs)
                    local customNormalZone = math.clamp(8.5 + (Speed * 0.3), 8.5, 68) * userScale
                    if (Distance <= customNormalZone or reachTime <= 0.05) and (not isBallDriftingOutside or Distance <= 13) then
                        triggerParry = true
                    end
                end
            end

            if triggerParry then
                local bTarget = Ball:GetAttribute("target") or Ball:GetAttribute("Target")
                if bTarget then
                    ZX_Parry.KeyTable = Ball:GetAttribute("realBall") or Ball.Name or bTarget
                end

                if (now - lastParryTime) >= 0.003 then 
                    if type(Auto_Parry) == "table" and type(Auto_Parry.FireParryRemote) == "function" then
                        local speedBurst = (Speed > 2000) and 3 or 1
                        local finalBurstCount = math.max(speedBurst, multiBallBurstCount)
                        
                        for i = 1, finalBurstCount do
                            pcall(Auto_Parry.FireParryRemote, false)
                        end
                    end
                    lastParryTime = now
                end
                lastHitTicks[Ball] = now
                parryLocked[Ball] = true
                lockTime[Ball] = now
            end
        end
    end
end)

getgenv()._InvisCurveTimers = getgenv()._InvisCurveTimers or {}
local _InvisCurveTimers = getgenv()._InvisCurveTimers

-- =======================================================================
-- ⚔️ POST-SIMULATION / RENDERSTEPPED FALLEN-ENGINE ACCUMULATOR SPAM LOOP
-- =======================================================================
if shared._PhysicsSpamBind then shared._PhysicsSpamBind:Disconnect() end

local timeAccumulator = 0
local Fallen_Spam = {
    In_Close_Contact = false,
    Last_Close_Contact = 0
}

shared._PhysicsSpamBind = RunService.RenderStepped:Connect(function(deltaTime)
    if not shared._InvisRunning then return end

    local character = LocalPlayer.Character
    local hrp = character and (character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart)
    local hum = character and character:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum or hum.Health <= 0 then return end

    local cfg = (type(Config) == "table") and Config or {}
    local autoSpamEnabled = cfg.AutoSpam or false
    if not autoSpamEnabled then 
        shared.ManualSpamActive = false
        timeAccumulator = 0
        return 
    end

    -- 🔍 1. GET BALL & CLOSEST TARGET (ดึงลูกบอลและศัตรูที่ใกล้ที่สุด)
    local ball = type(Auto_Parry) == "table" and type(Auto_Parry.Get_Ball) == "function" and Auto_Parry.Get_Ball()
    local targetPlr = type(Auto_Parry) == "table" and type(Auto_Parry.GetTargetPlayer) == "function" and Auto_Parry.GetTargetPlayer()
    
    if not ball or not ball.Parent or not targetPlr or not targetPlr:FindFirstChild("HumanoidRootPart") then
        shared.ManualSpamActive = false
        timeAccumulator = 0
        return
    end

    -- ป้องกันกรณีเข้าสถานะสกิลพิเศษของระบบเกม
    if ball:FindFirstChild("ComboCounter") then return end

    -- 📐 2. FALLEN MATH CORE ENGINE (คำนวณฟิสิกส์สแปมรูปแบบเดียวกับ Fallen)
    local Velocity = ball.AssemblyLinearVelocity
    local Zoomies = ball:FindFirstChild("zoomies")
    if Zoomies and pcall(function() return Zoomies.VectorVelocity end) then
        Velocity = Zoomies.VectorVelocity
    end
    local Speed = Velocity.Magnitude
    if Speed == 0 then return end

    local To_Ball = hrp.Position - ball.Position
    if To_Ball.Magnitude == 0 then return end

    local Ball_Dot = To_Ball.Unit:Dot(Velocity.Unit)
    local Target_Position = targetPlr.HumanoidRootPart.Position
    local Target_Distance = (hrp.Position - Target_Position).Magnitude
    
    local Retreat_Factor = 1
    local Move_Direction = hum.MoveDirection

    local Target_Offset = Target_Position - hrp.Position
    local Target_Direction = Target_Offset.Magnitude > 0 and Target_Offset.Unit or Vector3.zero
    
    local Entity_Move_Direction = Vector3.zero
    local Entity_Humanoid = targetPlr:FindFirstChildOfClass("Humanoid")
    if Entity_Humanoid then
        Entity_Move_Direction = Entity_Humanoid.MoveDirection
    end

    -- 🏃‍♂️ 3. CLOSE CONTACT & RETREAT DETECTION (เช็คระยะประชิดและการวิ่งฉีกหลบ)
    local Now = tick()
    if Target_Distance <= 3 then
        Fallen_Spam.In_Close_Contact = true
    end
    if Fallen_Spam.In_Close_Contact and Target_Distance > 3.3 then
        Fallen_Spam.In_Close_Contact = false
        Fallen_Spam.Last_Close_Contact = Now
    end
    
    local Separated = not Fallen_Spam.In_Close_Contact and (Now - Fallen_Spam.Last_Close_Contact >= 1.5)
    if Separated and Move_Direction.Magnitude > 0.2 and Move_Direction:Dot(Target_Direction) < -0.4 then
        Retreat_Factor = 10
    end
    if Separated and Entity_Move_Direction.Magnitude > 0.2 and Entity_Move_Direction:Dot(-Target_Direction) < -0.4 then
        Retreat_Factor = 10
    end

    -- ⚡ 4. PING STUDY COMPENSATE (คำนวณค่าปิงที่ถูกดักจับไว้แล้วในสคริปต์หลัก)
    local currentPing = tonumber(pingSeconds and pingSeconds * 1000) or 50
    local Ping_Threshold = math.clamp(currentPing / 10, 1, 16)

    -- 🎯 5. MAXIMUM SPAM ACCURACY THRESHOLD (คำนวณระยะปล่อยไม้ดวลจุดพีคตามฟิสิกส์ Fallen)
    local Maximum_Spam_Distance = (Ping_Threshold * 0.7 + math.min(Speed / (Retreat_Factor * 1.2), 80)) * 0.3 
    
    local Approach = math.clamp(-Ball_Dot, 0, 1)
    local Dot_Penalty = math.clamp(Approach * (Speed / 40), 0, 4)
    local Spam_Accuracy = Maximum_Spam_Distance - Dot_Penalty

    local Distance_To_Ball = (hrp.Position - ball.Position).Magnitude
    local Ball_Target = ball:GetAttribute("target") or ball:GetAttribute("Target")

    -- 🛡️ 6. VERIFY & EXECUTE PIPELINE (เช็คเงื่อนไขความปลอดภัยและจำลองคลิก)
    local isAllowedToSpam = true
    
    -- บล็อกสแปมระยะไกลถ้าบอลไม่ได้เล็งเรา (เซฟคูลดาวน์สแปม)
    if tostring(Ball_Target) == LocalPlayer.Name and Target_Distance > 30 and Distance_To_Ball > 30 then
        isAllowedToSpam = false
    end

    -- ตรวจเช็คสถานะการเปิดใช้สกิลอมตะ/สกิลล็อกเป้าจาก Attribute ตัวละครฝั่งศัตรูโดยตรง (ใช้ตรรกะกลางของเกม)
    if targetPlr:GetAttribute("AbilityActive") == true or targetPlr:GetAttribute("PassiveLock_ForceField") == true then
        isAllowedToSpam = false
    end

    -- สั่งเริ่มงานสแปมความเร็วสูงเมื่อระยะของ (ตัวเรา -> ศัตรู) และ (ตัวเรา -> บอล) ผ่านเกณฑ์ทดระยะ
    if isAllowedToSpam and Target_Distance <= Spam_Accuracy and Distance_To_Ball <= Spam_Accuracy then
        shared.ManualSpamActive = true
        
        -- ใช้ความเร็วการส่ง Packet (RPS) จากตัวสไลเดอร์หน้าเมนูของ Invis
        local TargetSpeed = cfg.ParrySettings and cfg.ParrySettings.SpammingRPS or 180
        timeAccumulator = timeAccumulator + deltaTime

        local packetsToFire = math.floor(timeAccumulator * TargetSpeed)
        if packetsToFire > 0 then
            timeAccumulator = timeAccumulator - (packetsToFire / TargetSpeed)
            for _ = 1, math.min(packetsToFire, 8) do
                pcall(function()
                    Auto_Parry.FireParryRemote(true) -- ยิงผ่านระบบเครือข่ายจำลองคลิกของ Invis Hub
                end)
            end
        end
    else
        timeAccumulator = 0
        shared.ManualSpamActive = false
    end
end)

-- auto jump (Fixed Floor & Solid Ground Detection)
task.spawn(function()
    while true do
        task.wait(0.05) -- ปรับเป็นตรวจจับความถี่สูง เพื่อเช็คจังหวะเท้าแตะพื้นได้ทันท่วงที
        if Config.AutoJumpEnabled then
            pcall(function()
                local char = LocalPlayer.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                
                if hum and hum.Health > 0 then
                    -- 1. เช็คว่าวัสดุใต้เท้าต้องไม่ใช่ "Air" (ต้องมีวัตถุรองรับ)
                    local onSolidGround = hum.FloorMaterial ~= Enum.Material.Air
                    
                    -- 2. เช็คสถานะทางฟิสิกส์ว่าอยู่ในโหมด ยืนนิ่ง, วิ่ง หรือกำลังแลนดิ้งถึงพื้นแล้ว
                    local state = hum:GetState()
                    local isReadyState = (state == Enum.HumanoidStateType.Running or state == Enum.HumanoidStateType.Landed or state == Enum.HumanoidStateType.None)
                    
                    -- ทำการกระโดดทันทีเมื่อเงื่อนไขครบถ้วน (เท้าแตะพื้นแข็งจริง ไม่ใช่ลอยอยู่กลางอากาศ)
                    if onSolidGround and isReadyState then
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                        task.wait(0.2) -- คูลดาวน์สั้น ๆ หลังกระโดด เพื่อป้องกันการส่งคำสั่งซ้ำซ้อนในเฟรมเดียวกัน
                    end
                end
            end)
        else
            task.wait(0.4)
        end
    end
end)

-- ═══ ANTI-AFK SYSTEM (JUMP & DROP -Y EVERY 5 MINS) ═══
local afkTimer = 0
task.spawn(function()
    while true do
        task.wait(1)
        if Config.AntiAfk then
            afkTimer = afkTimer + 1
            if afkTimer >= 10 then
                afkTimer = 0 -- รีเซ็ตเวลาเพื่อเริ่มนับใหม่
                pcall(function()
                    local char = game.Players.LocalPlayer.Character
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    
                    if hum and hrp then
                        -- 1. สั่งกระโดด
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                        task.wait(0.15) -- รอจังหวะตัวลอยนิดนึง
                        
                        -- 2. ดึงแกน Y ลงมาทันที (ป้องกันเดินค้าง)
                        hrp.CFrame = hrp.CFrame - Vector3.new(0, 5, 0)
                        hrp.AssemblyLinearVelocity = Vector3.new(0, -50, 0) 
                    end
                end)
            end
        else
            afkTimer = 0 -- ถ้าปิดสวิตช์ ให้รีเซ็ตเวลา
        end
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
                    Config.wowcurve = 0.7
                elseif ballSpeed >= 770 then
                    Config.wowcurve = 0.65
                elseif ballSpeed >= 650 then
                    Config.wowcurve = 0.6
                elseif ballSpeed >= 350 then
                    Config.wowcurve = 0.54
                elseif ballSpeed >= 240 then
                    Config.wowcurve = 0.48
                elseif ballSpeed >= 150 then
                    Config.wowcurve = 0.44
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

-- ═══ 🤖 ADVANCED HUMAN EMULATION AUTO PLAY BOT (10-MODE ENGINE) ═══════════════
local currentMode = 1
local modeTimer = 0
local doubleJumpToken = false

task.spawn(function()
    while shared._InvisRunning do
        task.wait(math.random(15, 30) / 100) -- สุ่มดีเลย์ตอบสนองของบอทให้มีความเป็นมนุษย์ (0.15 - 0.3 วินาที)
        
        if Config.AutoPlay then
            pcall(function()
                local char = LocalPlayer.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hum or hum.Health <= 0 or not hrp then return end
                
                local ball = Auto_Parry.Get_Ball()
                local targetPlr = Auto_Parry.GetTargetPlayer()
                
                -- ตรวจสอบว่าใครเป็นเป้าหมายของลูกบอลปัจจุบัน
                local ballTargetStr = ball and tostring(ball:GetAttribute("target") or ball:GetAttribute("Target") or "") or ""
                local isTargetingMe = (ballTargetStr == LocalPlayer.Name or (char and ballTargetStr == char.Name))
                
                -- ระบบสลับโหมดการเล่นอัตโนมัติทุก ๆ 4-8 วินาที เพื่อสร้างรูปแบบเคลื่อนที่แบบไม่ซ้ำซาก
                if tick() - modeTimer > math.random(4, 8) then
                    currentMode = math.random(1, 10)
                    modeTimer = tick()
                end
                
                -- 🛡️ ระบบรักษาระยะห่างเพื่อความปลอดภัย (ถ้าบอลไม่ได้เล็งมาห้ามเข้าใกล้บอลเกินไป)
                local safeDestination = nil
                
                if ball and not isTargetingMe then
                    local ballDist = (hrp.Position - ball.Position).Magnitude
                    -- หากอยู่ใกล้ลูกบอลเกิน 35 สตัดตอนที่ไม่ได้โดนเล็ง ให้บังคับเดินฉีกถอยห่างออกมาทันที
                    if ballDist < 35 then
                        local escapeDirection = (hrp.Position - ball.Position).Unit
                        safeDestination = hrp.Position + (escapeDirection * math.random(20, 35))
                    end
                end
                
                -- หากเข้าสูตรการรักษาระยะห่างให้เดินไปจุดปลอดภัยก่อน ไม่งั้นให้เข้าสู่ระบบสุ่ม 10 โหมดด้านล่าง
                if safeDestination then
                    hum:MoveTo(safeDestination + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5)))
                else
                    -- 🎯 ระบบจำลองการเล่นอัจฉริยะสุ่ม 10 โหมดพฤติกรรมมนุษย์
                    if currentMode == 1 then
                        -- โหมดที่ 1: วิ่งอ้อมเป็นวงกลมรอบแผนที่ (Circle Strafe) เพื่อหลบวิถีตรง
                        local center = targetPlr and targetPlr.PrimaryPart and targetPlr.PrimaryPart.Position or Vector3.new(0,0,0)
                        local offset = (hrp.Position - center).Unit * math.random(25, 45)
                        local rotatedOffset = Vector3.new(-offset.Z, 0, offset.X) -- เลี้ยวฉาก 90 องศาเพื่อวิ่งวน
                        hum:MoveTo(center + rotatedOffset)
                        
                    elseif currentMode == 2 then
                        -- โหมดที่ 2: วิ่งสไลด์เข้าหาขอบแผนที่ชั่วคราว (Wall Hugger) ลดมุมอับ
                        hum:MoveTo(hrp.Position + Vector3.new(math.random(-40, 40), 0, math.random(-40, 40)))
                        
                    elseif currentMode == 3 then
                        -- โหมดที่ 3: เดินสลับฟันปลาซ้าย-ขวาอย่างรวดเร็ว (Zig-Zag Movement) สับขาหลอกศัตรู
                        local forward = targetPlr and targetPlr.PrimaryPart and (targetPlr.PrimaryPart.Position - hrp.Position).Unit or Vector3.new(0,0,1)
                        local side = Vector3.new(-forward.Z, 0, forward.X)
                        local sideStep = (tick() % 1 > 0.5) and 1 or -1
                        hum:MoveTo(hrp.Position + (forward * 10) + (side * (sideStep * 20)))
                        
                    elseif currentMode == 4 then
                        -- โหมดที่ 4: ยืนนิ่ง ๆ คุมเชิงคอยจังหวะสวนกลับ (Passive Baiting)
                        hum:MoveTo(hrp.Position)
                        
                    elseif currentMode == 5 then
                        -- โหมดที่ 5: เดินตามผู้เล่นคนอื่นที่อยู่ใกล้ที่สุดแต่อยู่ข้างหลังเขาเอาไว้บังกระสุน (Meatshield Mode)
                        if targetPlr and targetPlr.PrimaryPart then
                            hum:MoveTo(targetPlr.PrimaryPart.Position + Vector3.new(math.random(15, 25), 0, math.random(15, 25)))
                        end
                        
                    elseif currentMode == 6 then
                        -- โหมดที่ 6: วิ่งถอยหลังสลับกระโดดมองความเคลื่อนไหว (Backward Jumper)
                        if ball then
                            local awayDir = (hrp.Position - ball.Position).Unit
                            hum:MoveTo(hrp.Position + (awayDir * 25))
                            if hum.FloorMaterial ~= Enum.Material.Air and math.random(1, 3) == 1 then
                                hum:ChangeState(Enum.HumanoidStateType.Jumping)
                            end
                        end
                        
                    elseif currentMode == 7 then
                        -- โหมดที่ 7: วิ่งกดดันเข้าหาพิกัดผู้เล่นเป้าหมายตรง ๆ (Aggressive Rush) ตอนบอลวิ่งเร็ว
                        if targetPlr and targetPlr.PrimaryPart then
                            hum:MoveTo(targetPlr.PrimaryPart.Position + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5)))
                        end
                        
                    elseif currentMode == 8 then
                        -- โหมดที่ 8: วิ่งพุ่งมั่วไร้ทิศทางระยะสั้นสลับหยุด (Twitchy Movement) บอทสแกนตรวจจับทิศทางยาก
                        hum:MoveTo(hrp.Position + Vector3.new(math.random(-15, 15), 0, math.random(-15, 15)))
                        
                    elseif currentMode == 9 then
                        -- โค๊ตที่ 9: เดินยึกยัก เดินหน้าถอยหลังสั้นๆ คุมโซนกลางแมพ (Mid-Zone Control)
                        hum:MoveTo(Vector3.new(0, hrp.Position.Y, 0) + Vector3.new(math.random(-20, 20), 0, math.random(-20, 20)))
                        
                    elseif currentMode == 10 then
                        -- โหมดที่ 10: วิ่งหลบไปซ่อนหลังเสาหรือสิ่งปลูกสร้างหากมีพิกัดวัตถุในระบบ
                        hum:MoveTo(hrp.Position + (hrp.CFrame.RightVector * math.random(-30, 30)))
                    end
                end
                
                -- 🦘 🔊 [ระบบจัดการกระโดดสองจังหวะดักฟิสิกส์ลอยตัว - DOUBLE JUMP ENGINE]
                if isTargetingMe and ball then
                    local ballDist = (hrp.Position - ball.Position).Magnitude
                    -- ถ้าโดนเล็งอยู่ และบอลเข้ามาใกล้ในระยะกระโดดหลบ (ประมาณ 25-50 สตัด)
                    if ballDist <= math.clamp(ball.AssemblyLinearVelocity.Magnitude * 0.4, 25, 65) then
                        -- จังหวะที่ 1: กระโดดขึ้นจากพื้นปกติ
                        if hum.FloorMaterial ~= Enum.Material.Air and not doubleJumpToken then
                            hum:ChangeState(Enum.HumanoidStateType.Jumping)
                            doubleJumpToken = true
                            task.wait(0.18) -- ดีเลย์หน่วงจังหวะลอยตัวของมนุษย์ก่อนกดเบิ้ล
                        end
                        
                        -- จังหวะที่ 2: สั่งเบิ้ล Double Jump กลางอากาศเพื่อดึงระยะหลบวิถีโค้ง
                        if doubleJumpToken and hum:GetState() == Enum.HumanoidStateType.FreeFall then
                            hum:ChangeState(Enum.HumanoidStateType.Jumping)
                            doubleJumpToken = false -- รีเซ็ตคีย์หลังใช้งานเสร็จสิ้น
                            task.wait(0.3)
                        end
                    end
                else
                    -- ปลดล็อก Token เสมอเมื่อเท้าแตะพื้นแข็งเรียบร้อยแล้ว
                    if hum.FloorMaterial ~= Enum.Material.Air then
                        doubleJumpToken = false
                    end
                end
                
            end)
        end
    end
end)

-- ═══ SPECIAL SKILL DETECTIONS (TORNADO & SPECIAL BALLS) ═══
task.spawn(function()
    while shared._InvisRunning do
        task.wait(0.1)
        if Config.SpecialSkillDetections then
            pcall(function()
                local ball = Auto_Parry.Get_Ball()
                if ball then
                    -- ตรวจจับ Tornado / Singularities Effect
                    if ball:FindFirstChild("TornadoEffect") or ball:FindFirstChild("Vortex") then
                        parryCooldown = 0.8 -- เร่งความเร็วปุ่มป้องกันอัตโนมัติ
                    else
                        parryCooldown = 0.035
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

local function executeWarp(target)
    if target and target.PrimaryPart and LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then
        LocalPlayer.Character.PrimaryPart.CFrame = target.PrimaryPart.CFrame * CFrame.new(0, 0, 4)
    end
end

local function executeTween(target)
    if target and target.PrimaryPart and LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then
        local hrp = LocalPlayer.Character.PrimaryPart
        local dist = (target.PrimaryPart.Position - hrp.Position).Magnitude
        local duration = dist / 130 
        local tween = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = target.PrimaryPart.CFrame * CFrame.new(0, 0, 4)})
        tween:Play()
    end
end


local function PlayCustomAnimation(id)
    pcall(function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum and hum.Animator and id ~= "" then
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://" .. tostring(id)
            local track = hum.Animator:LoadAnimation(anim)
            track:Play()
            CustomNotify("Playing Anim ID: " .. id, 2.5)
            pcall(function() anim:Destroy() end) -- ✅ ย้ายเข้ามาไว้ตรงนี้
        else
            CustomNotify("Invalid Anim ID or missing Humanoid!", 2.5)
        end
    end)
end

-- ═══ LOOK AT BALL SYSTEM (TASK.SPAWN) ═══
task.spawn(function()
    while shared._InvisRunning do
        -- ใช้ RenderStepped:Wait() เพื่อให้อัปเดตมุมกล้องและตัวละครตามเฟรมเรตเกม (นุ่มนวล ไม่กระตุก)
        RunService.RenderStepped:Wait()
        
        pcall(function()
            local ball = Auto_Parry.Get_Ball()
            if ball then
                -- 1. Look at Ball (Character)
                if Config.LookAtBallChar then
                    local char = LocalPlayer.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local targetPos = Vector3.new(ball.Position.X, hrp.Position.Y, ball.Position.Z)
                        hrp.CFrame = CFrame.lookAt(hrp.Position, targetPos)
                    end
                end

                -- 2. Look at Ball (Camera)
                if Config.LookAtBallCam then
                    local cam = workspace.CurrentCamera
                    if cam then
                        cam.CFrame = CFrame.lookAt(cam.CFrame.Position, ball.Position)
                    end
                end
            end
        end)
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- ⚡ PLAYER ABILITY ESP — CLEAN / LOW CLUTTER VERSION
-- ═══════════════════════════════════════════════════════════════

local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local ESP_NAME = "AbilityESP_Gui"

local function removeESP(character)
    if not character then return end

    local head = character:FindFirstChild("Head")
    if head then
        local old = head:FindFirstChild(ESP_NAME)
        if old then
            old:Destroy()
        end
    end
end

local function createBillboardGui(player)
    if player == LocalPlayer then
        return
    end

    task.spawn(function()
        local character = player.Character
            or player.CharacterAdded:Wait()

        if not character then
            return
        end

        local head = character:WaitForChild("Head", 10)

        if not head or not head.Parent then
            return
        end

        -- ป้องกัน ESP ซ้ำ
        removeESP(character)

        -- ═══════════════════════════════════════════════════════
        -- BILLBOARD
        -- ═══════════════════════════════════════════════════════

        local bg = Instance.new("BillboardGui")
        bg.Name = ESP_NAME
        bg.Adornee = head
        bg.Parent = head

        -- เล็กลง ไม่กินพื้นที่หน้าจอ
        bg.Size = UDim2.fromOffset(125, 38)

        -- ขยับขึ้นเหนือหัว
        bg.StudsOffset = Vector3.new(0, 3.1, 0)

        -- แสดงแม้อยู่หลัง object
        bg.AlwaysOnTop = true

        -- จำกัดระยะ
        bg.MaxDistance = 150

        -- ไม่ scale ใหญ่เกินไปตามระยะ
        bg.ExtentsOffsetWorldSpace = Vector3.zero

        -- ═══════════════════════════════════════════════════════
        -- MAIN FRAME
        -- ═══════════════════════════════════════════════════════

        local frame = Instance.new("Frame")
        frame.Name = "Container"
        frame.Parent = bg

        frame.Size = UDim2.fromScale(1, 1)

        frame.BackgroundColor3 = Color3.fromRGB(12, 14, 18)
        frame.BackgroundTransparency = 0.28

        frame.BorderSizePixel = 0

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = frame

        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(80, 190, 255)
        stroke.Transparency = 0.45
        stroke.Thickness = 1
        stroke.Parent = frame

        -- ═══════════════════════════════════════════════════════
        -- PLAYER NAME
        -- ═══════════════════════════════════════════════════════

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "PlayerName"
        nameLabel.Parent = frame

        nameLabel.BackgroundTransparency = 1

        nameLabel.Position = UDim2.new(0, 5, 0, 2)
        nameLabel.Size = UDim2.new(1, -10, 0, 15)

        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextSize = 11

        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextStrokeTransparency = 0.6

        nameLabel.Text = player.DisplayName

        nameLabel.TextXAlignment = Enum.TextXAlignment.Center
        nameLabel.TextTruncate = Enum.TextTruncate.AtEnd

        -- ═══════════════════════════════════════════════════════
        -- ABILITY
        -- ═══════════════════════════════════════════════════════

        local abilityLabel = Instance.new("TextLabel")
        abilityLabel.Name = "Ability"
        abilityLabel.Parent = frame

        abilityLabel.BackgroundTransparency = 1

        abilityLabel.Position = UDim2.new(0, 5, 0, 18)
        abilityLabel.Size = UDim2.new(1, -10, 0, 15)

        abilityLabel.Font = Enum.Font.GothamSemibold
        abilityLabel.TextSize = 10

        abilityLabel.TextColor3 = Color3.fromRGB(100, 220, 255)
        abilityLabel.TextStrokeTransparency = 0.65

        abilityLabel.TextXAlignment = Enum.TextXAlignment.Center
        abilityLabel.TextTruncate = Enum.TextTruncate.AtEnd

        -- ═══════════════════════════════════════════════════════
        -- UPDATE
        -- ═══════════════════════════════════════════════════════

        local function update()
            if not bg.Parent then
                return false
            end

            bg.Enabled = Config.AbilityESP == true

            if not bg.Enabled then
                return true
            end

            local ability =
                player:GetAttribute("EquippedAbility")
                or player:GetAttribute("Ability")
                or "None"

            ability = tostring(ability)

            nameLabel.Text = player.DisplayName
            abilityLabel.Text = "⚡ " .. string.upper(ability)

            return true
        end

        update()

        -- Attribute เปลี่ยนค่อยอัปเดต
        local connections = {}

        table.insert(connections,
            player:GetAttributeChangedSignal("EquippedAbility"):Connect(update)
        )

        table.insert(connections,
            player:GetAttributeChangedSignal("Ability"):Connect(update)
        )

        -- ตรวจเฉพาะสถานะเปิด/ปิด ไม่ใช้ Heartbeat
        task.spawn(function()
            while bg.Parent and character.Parent do
                update()
                task.wait(0.25)
            end

            for _, connection in ipairs(connections) do
                connection:Disconnect()
            end
        end)
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- CHARACTER HANDLER
-- ═══════════════════════════════════════════════════════════════

local function setupPlayer(player)
    if player == LocalPlayer then
        return
    end

    player.CharacterAdded:Connect(function(character)
        task.wait(0.15)

        if character.Parent then
            createBillboardGui(player)
        end
    end)

    if player.Character then
        createBillboardGui(player)
    end
end

-- Existing players
for _, player in ipairs(Players:GetPlayers()) do
    setupPlayer(player)
end

-- New players
Players.PlayerAdded:Connect(setupPlayer)

-- Cleanup
Players.PlayerRemoving:Connect(function(player)
    if player.Character then
        removeESP(player.Character)
    end
end)

-- ═══ STABLE HUMANOID ENFORCER (ULTIMATE OPTIMIZED CONTROLLER) ═══
RunService.Heartbeat:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        
        if not hum or hum.Health <= 0 then return end
        
        -- ควบคุม WalkSpeed แบบเงียบและรวดเร็ว (เปลี่ยนเฉพาะตอนค่าไม่ตรง)
        if Config.CustomSpeed and hum.WalkSpeed ~= Config.CustomSpeed then
            hum.WalkSpeed = Config.CustomSpeed
        end
        
        -- ควบคุม JumpPower ให้เสถียรและบังคับเปิด UseJumpPower
        if Config.CustomJump then
            if not hum.UseJumpPower then
                hum.UseJumpPower = true
            end
            if hum.JumpPower ~= Config.CustomJump then
                hum.JumpPower = Config.CustomJump
            end
        end
    end)
end)

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

-- ═══ TELEPORT & TWEEN ENGINE UTILITIES ═══
local function targetDistanceSolver(mode)
    local alive = workspace:FindFirstChild("Alive")
    if not alive or not LocalPlayer.Character or not LocalPlayer.Character.PrimaryPart then return nil end
    local myPos = LocalPlayer.Character.PrimaryPart.Position
    local chosen, pivotDist = nil, (mode == "Nearest" and math.huge or -1)
    for _, p in pairs(alive:GetChildren()) do
        if p ~= LocalPlayer.Character and p:IsA("Model") and p.PrimaryPart then
            local d = (p.PrimaryPart.Position - myPos).Magnitude
            if mode == "Nearest" then if d < pivotDist then pivotDist = d; chosen = p end
            else if d > pivotDist then pivotDist = d; chosen = p end end
        end
    end
    return chosen
end
local function executeWarp(target)
    if target and target.PrimaryPart and LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then
        LocalPlayer.Character.PrimaryPart.CFrame = target.PrimaryPart.CFrame * CFrame.new(0, 0, 4)
        CustomNotify("Warped to: " .. target.Name, 2.5)
    else
        CustomNotify("Target player not found!", 2.5)
    end
end
local function executeTween(target)
    if target and target.PrimaryPart and LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then
        local hrp = LocalPlayer.Character.PrimaryPart
        local dist = (target.PrimaryPart.Position - hrp.Position).Magnitude
        local duration = dist / 130 
        local tween = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = target.PrimaryPart.CFrame * CFrame.new(0, 0, 4)})
        tween:Play()
        CustomNotify("Tweening to: " .. target.Name, 2.5)
    else
        CustomNotify("Target player not found!", 2.5)
    end
end
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

local function PlayCustomAnimation(id)
    pcall(function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum and hum.Animator and id ~= "" then
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://" .. tostring(id)
            local track = hum.Animator:LoadAnimation(anim)
            track:Play()
            CustomNotify("Playing Anim ID: " .. id, 2.5)
        else
            CustomNotify("Invalid Anim ID or missing Humanoid!", 2.5)
        end
     pcall(function() anim:Destroy() end)
    end)
end
-- ═══ GUI SETUP LAYOUTS ═══

-- 🎨 THEME COLORS & PALETTE
local THEME = {
    Background = Color3.fromRGB(12, 12, 16),
    Sidebar    = Color3.fromRGB(16, 16, 22),
    CardBg     = Color3.fromRGB(22, 22, 30),
    CardHover  = Color3.fromRGB(28, 28, 38),
    InputBg    = Color3.fromRGB(18, 18, 24),
    Accent     = Color3.fromRGB(255, 60, 90),
    AccentGlow = Color3.fromRGB(255, 90, 120),
    TextMain   = Color3.fromRGB(240, 240, 245),
    TextDark   = Color3.fromRGB(140, 140, 160),
    Active     = Color3.fromRGB(50, 220, 130),
    Inactive   = Color3.fromRGB(255, 70, 90)
}

-- ตัวแปรควบคุมสถานะเปิด-ปิดหน้าต่าง (ย้ายขึ้นมาไว้ด้านบนสุดเพื่อให้ระบบเรียกใช้งานได้ถูกต้อง)
local guiOpenState = true 
local isTweening = false
local fadeTweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- 🔘 TOGGLE MAIN HUB BUTTON
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 90, 0, 38)
ToggleBtn.Position = UDim2.new(0.03, 0, 0.15, 0)
ToggleBtn.BackgroundColor3 = THEME.Sidebar
ToggleBtn.Text = "INVIS📌"
ToggleBtn.TextColor3 = THEME.Accent
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 13
ToggleBtn.AutoButtonColor = false
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 8)

local tStroke = Instance.new("UIStroke", ToggleBtn)
tStroke.Color = THEME.Accent
tStroke.Thickness = 1.5

-- 📌 ระบบลากปุ่ม Toggle แบบแยกแยะคลิกกับการลาก (Fixed Dragging & Click Logic)
local tDrag, tStart, tPos, dragStartMousePos
local dragThreshold = 5
local isDragging = false

ToggleBtn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        tDrag = true
        tStart = i.Position
        dragStartMousePos = UserInputService:GetMouseLocation()
        tPos = ToggleBtn.Position
        isDragging = false -- รีเซ็ตค่าทุกครั้งที่เริ่มกดสแตนด์บาย
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if tDrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local currentMousePos = UserInputService:GetMouseLocation()
        local moveDistance = (currentMousePos - dragStartMousePos).Magnitude
        
        -- ตรวจสอบระยะห่างการลาก ถ้าเกิน Threshold ให้ถือว่าเป็นการ "ลากนิ้ว/ลากเมาส์" ไม่ใช่การคลิก
        if moveDistance > dragThreshold then
            isDragging = true
        end
        
        if isDragging then
            local d = i.Position - tStart
            local cam = workspace.CurrentCamera
            local targetX = tPos.X.Offset + d.X
            local targetY = tPos.Y.Offset + d.Y
            
            -- 🔒 ล็อกไม่ให้ปุ่มหลุดหายทะลุขอบหน้าจอ
            if cam then
                targetX = math.clamp(targetX, 0, cam.ViewportSize.X - ToggleBtn.Size.X.Offset)
                targetY = math.clamp(targetY, 0, cam.ViewportSize.Y - ToggleBtn.Size.Y.Offset)
            end
            
            ToggleBtn.Position = UDim2.new(tPos.X.Scale, targetX, tPos.Y.Scale, targetY)
        end
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        tDrag = false
        -- หน่วงเวลาเล็กน้อยก่อนล้างค่าสถานะการลาก เพื่อไม่ให้ตรรกะการคลิกทำงานทับซ้อนตอนปล่อยเมาส์
        task.defer(function()
            isDragging = false
        end)
    end
end)


-- 🖼️ MAIN FRAME WINDOW
local MainFrame = Instance.new("CanvasGroup", ScreenGui)
MainFrame.Size = UDim2.new(0, 580, 0, 350)
MainFrame.Position = UDim2.new(0.3, 0, 0.22, 0)
MainFrame.BackgroundColor3 = THEME.Background
MainFrame.Visible = true
MainFrame.GroupTransparency = 0
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 2
task.spawn(function()
    while shared._InvisRunning do
        MainStroke.Color = Color3.fromHSV((tick() % 4) / 4, 0.8, 1)
        task.wait()
    end
end)

-- Window Toggle Logic
local guiOpenState, isTweening = true, false
local fadeTweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Window Dragging Logic
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
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        mDrag = false
    end
end)

-- 📌 ตรรกะการคลิกปุ่มเพื่อเปิด/ปิด UI (Fixed Visibility Click Handler)
ToggleBtn.MouseButton1Click:Connect(function()
    if isDragging then return end -- หากตรวจพบว่าผู้เล่นกำลังลากปุ่มอยู่ จะไม่สั่งเปิด/ปิดหน้าต่างมั่วซั่ว
    if isTweening then return end
    
    isTweening = true
    guiOpenState = not guiOpenState
    
    if guiOpenState then
        MainFrame.Visible = true
        local tween = TweenService:Create(MainFrame, fadeTweenInfo, {GroupTransparency = 0})
        tween:Play()
        tween.Completed:Connect(function() 
            isTweening = false 
        end)
    else
        local tween = TweenService:Create(MainFrame, fadeTweenInfo, {GroupTransparency = 1})
        tween:Play()
        tween.Completed:Connect(function()
            if not guiOpenState then 
                MainFrame.Visible = false 
            end
            isTweening = false
        end)
    end
end)

-- 🏷️ TOP TITLE BAR
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 42)
Title.Text = "  ⭐ INVIS HUB (v1.00.07)"
Title.TextColor3 = THEME.TextMain
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.BackgroundColor3 = THEME.Sidebar
Title.TextXAlignment = Enum.TextXAlignment.Left

local Sidebar = Instance.new("ScrollingFrame", MainFrame)
Sidebar.Name = "Sidebar_ScrollingMenu"
Sidebar.Size = UDim2.new(0, 140, 1, -42)
Sidebar.Position = UDim2.new(0, 0, 0, 42)
Sidebar.BackgroundColor3 = THEME.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0) -- ขนาดเริ่มต้น
Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y -- ขยายความยาวอัตโนมัติตามจำนวนปุ่ม
Sidebar.ScrollBarThickness = 2 -- แถบเลื่อนขนาดเล็กพรีเมียม
Sidebar.ScrollBarImageColor3 = THEME.Accent
Sidebar.ClipsDescendants = true
Sidebar.ZIndex = 2

-- จัดการโครงสร้างตำแหน่งปุ่มภายใน Sidebar
local SideList = Instance.new("UIListLayout", Sidebar)
SideList.Padding = UDim.new(0, 6)
SideList.HorizontalAlignment = Enum.HorizontalAlignment.Center
SideList.SortOrder = Enum.SortOrder.LayoutOrder

local SidePadding = Instance.new("UIPadding", Sidebar)
SidePadding.PaddingTop = UDim.new(0, 8)
SidePadding.PaddingBottom = UDim.new(0, 8) -- เว้นระยะกันปุ่มจมด้านล่าง

-- 📑 CONTENT CONTAINER
local ContentContainer = Instance.new("Frame", MainFrame)
ContentContainer.Size = UDim2.new(1, -150, 1, -48)
ContentContainer.Position = UDim2.new(0, 145, 0, 44)
ContentContainer.BackgroundTransparency = 1

-- ═══ 🎨 UI BACKGROUND SYSTEM ═══════════════════════════════

local UIBackgroundImage = Instance.new("ImageLabel", MainFrame)
UIBackgroundImage.Name = "UIBackgroundImage"
UIBackgroundImage.Size = UDim2.new(1, 0, 1, 0)
UIBackgroundImage.Position = UDim2.new(0, 0, 0, 0)
UIBackgroundImage.BackgroundTransparency = 1
UIBackgroundImage.Image = ""
UIBackgroundImage.ImageTransparency = 0.15
UIBackgroundImage.ScaleType = Enum.ScaleType.Crop
UIBackgroundImage.ZIndex = 0

-- ทำให้มุมของรูปตาม MainFrame
local bgCorner = Instance.new("UICorner", UIBackgroundImage)
bgCorner.CornerRadius = UDim.new(0, 10)

-- เนื้อหา GUI ให้อยู่เหนือพื้นหลัง
Title.ZIndex = 2
Sidebar.ZIndex = 2
ContentContainer.ZIndex = 2

-- ═══ 🛠️ FIXED TAB FRAMES INITIALIZATION (ANTI-CRASH) ═══
-- ประกาศคลังหน่วยความจำให้ระบบสแกนอ่านค่าเจอแบบ Global/Shared ป้องกันบอร์ดหลุด
if not getgenv().TabFrames then getgenv().TabFrames = {} end
if not getgenv().TabButtons then getgenv().TabButtons = {} end

local TabFrames = getgenv().TabFrames
local TabButtons = getgenv().TabButtons

-- ล้าง Cache โครงสร้างตารางอันเก่าออกเพื่อไม่ให้ซ้อนทับกันตอนรีสคริปต์
table.clear(TabFrames)
table.clear(TabButtons)

local function createTabScroll(tabName)
    -- ตรวจสอบความปลอดภัยพิกัดโครงสร้างหลัก
    if not ContentContainer then 
        warn("[Invis Hub Error]: ContentContainer missing!")
        return Instance.new("ScrollingFrame")
    end

    local scr = Instance.new("ScrollingFrame")
    scr.Name = tostring(tabName) .. "_ScrollFrame"
    scr.Size = UDim2.new(1, 0, 1, 0)
    scr.BackgroundTransparency = 1
    scr.CanvasSize = UDim2.new(0, 0, 0, 0)
    scr.AutomaticCanvasSize = Enum.AutomaticSize.Y 
    scr.ScrollBarThickness = 3 
    scr.ScrollBarImageColor3 = THEME.Accent 
    scr.Visible = false 
    scr.ClipsDescendants = true 
    scr.BorderSizePixel = 0
    scr.Parent = ContentContainer -- ผูกเข้ากับเมนูกลาง

    local UIList = Instance.new("UIListLayout", scr)
    UIList.Padding = UDim.new(0, 6)
    UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIList.SortOrder = Enum.SortOrder.LayoutOrder

    local UIPad = Instance.new("UIPadding", scr)
    UIPad.PaddingRight = UDim.new(0, 6)
    UIPad.PaddingLeft = UDim.new(0, 2)
    UIPad.PaddingTop = UDim.new(0, 4)
    UIPad.PaddingBottom = UDim.new(0, 15) -- เพิ่มระยะเผื่อลากลงล่างสุดสำหรับจอมือถือ

    -- ระบบคำนวณสเกลแบบไดนามิก ป้องกันการดึงค่า nil จาก AbsoluteContentSize
    UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        pcall(function()
            if UIList and UIPad then
                scr.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + UIPad.PaddingTop.Offset + UIPad.PaddingBottom.Offset)
            end
        end)
    end)

    -- บันทึกลงตารางหน่วยความจำ (Hotfix: จุดที่เคยเกิด Error)
    TabFrames[tabName] = scr
    return scr
end

local combatScroll = createTabScroll("Combat")
local visualScroll = createTabScroll("Visuals")
local settingsScroll = createTabScroll("Settings")
local uiScroll = createTabScroll("UI")
local statusScroll = createTabScroll("Status")
local scriptScroll = createTabScroll("Script Hub")
local musicScroll = createTabScroll("Music")
local abilityDetScroll = createTabScroll("Ability Detections")
local leaderHackScroll = createTabScroll("Leaderboard Hack")
local whatsNewScroll = createTabScroll("What's New")

-- บังคับเปิดหน้าแรกที่ Combat และซ่อนหน้า What's New ไว้ก่อนเริ่มทำงาน
if TabFrames["What's New"] then
    TabFrames["What's New"].Visible = false
end

TabFrames["Combat"].Visible = true

local function setupTabButton(name)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(1, -14, 0, 36)
    -- ตรวจเช็คสถานะเริ่มต้น ถ้าเป็นหน้า Combat ให้เปิดสีไฮไลท์ไว้ก่อน
    btn.BackgroundColor3 = (name == "Combat") and THEME.CardHover or THEME.CardBg
    btn.Text = name
    btn.TextColor3 = (name == "Combat") and THEME.Accent or THEME.TextDark
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.ZIndex = 5 -- ดันเลเยอร์ ZIndex ขึ้นมาเพื่อให้พ้นการบดบังของพื้นหลัง
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    -- ใส่เอฟเฟกต์เส้นขอบบางๆ ให้ปุ่มแท็บดูมีมิติ
    local bStroke = Instance.new("UIStroke", btn)
    bStroke.Thickness = 1
    bStroke.Color = (name == "Combat") and THEME.Accent or Color3.fromRGB(35, 35, 45)

    TabButtons[name] = btn

    -- ตรรกะการสลับแท็บเมื่อคลิกปุ่ม
    btn.MouseButton1Click:Connect(function()
        for tName, frame in pairs(TabFrames) do
            local isTarget = (tName == name)
            if frame and typeof(frame) == "Instance" then
                frame.Visible = isTarget
            end
            if TabButtons[tName] then
                -- เปลี่ยนสีปุ่มและเส้นขอบแบบ Real-time ตามแท็บที่เลือกปัจจุบัน
                TabButtons[tName].BackgroundColor3 = isTarget and THEME.CardHover or THEME.CardBg
                TabButtons[tName].TextColor3 = isTarget and THEME.Accent or THEME.TextDark
                
                local strokeTarget = TabButtons[tName]:FindFirstChildOfClass("UIStroke")
                if strokeTarget then
                    strokeTarget.Color = isTarget and THEME.Accent or Color3.fromRGB(35, 35, 45)
                end
            end
        end
    end)
end

setupTabButton("Combat")
setupTabButton("Visuals")
setupTabButton("Settings")
setupTabButton("UI")
setupTabButton("Status")
setupTabButton("Script Hub")
setupTabButton("Music")
setupTabButton("Ability Detections")
setupTabButton("Leaderboard Hack")
setupTabButton("What's New")

-- 🎚️ PREMIUM SMOOTH SLIDE SWITCH TOGGLE CREATOR (FIXED VECTOR2 -> UDIM2 ERROR)
local function createToggle(name, stateKey, parent)
    -- 📦 1. กรอบพื้นหลังหลักของการ์ดเมนู
    local container = Instance.new("Frame", parent)
    container.Size = UDim2.new(1, 0, 0, 34)
    container.BackgroundColor3 = THEME.CardBg
    container.BorderSizePixel = 0
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

    local stroke = Instance.new("UIStroke", container)
    stroke.Thickness = 1
    stroke.Color = Color3.fromRGB(35, 35, 45)

    -- 🏷️ 2. ข้อความหัวข้อด้านซ้าย (Text Label)
    local titleLabel = Instance.new("TextLabel", container)
    titleLabel.Size = UDim2.new(1, -65, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = name
    titleLabel.TextColor3 = THEME.TextMain
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 11
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextYAlignment = Enum.TextYAlignment.Center

    -- 🎛️ 3. ตัวกรอบสวิตช์รูปแคปซูลด้านขวา (Switch Slot)
    local switchTrack = Instance.new("TextButton", container)
    switchTrack.Size = UDim2.new(0, 36, 0, 16)
    switchTrack.Position = UDim2.new(1, -46, 0.5, -8) -- ล็อกพิกัดไว้ขวาสุดเสมอ
    switchTrack.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    switchTrack.Text = ""
    switchTrack.AutoButtonColor = false
    Instance.new("UICorner", switchTrack).CornerRadius = UDim.new(1, 0) -- ทำให้เป็นรูปแคปซูลทรงมน

    local trackStroke = Instance.new("UIStroke", switchTrack)
    trackStroke.Thickness = 1
    trackStroke.Color = Color3.fromRGB(50, 50, 60)

    -- 🟢 4. ปุ่มวงกลมด้านในสวิตช์ (Switch Knob)
    local switchThumb = Instance.new("Frame", switchTrack)
    -- 🌟 [CRITICAL FIX]: แก้จาก Vector2.new เป็น UDim2.fromOffset เพื่อป้องกันการขึ้น Error สีแดงบนหน้าจอ
    switchThumb.Size = UDim2.fromOffset(12, 12)
    switchThumb.Position = UDim2.new(0, 2, 0.5, -6) -- จุดเริ่มต้นฝั่งซ้าย
    switchThumb.BackgroundColor3 = Color3.fromRGB(150, 150, 160)
    switchThumb.BorderSizePixel = 0
    Instance.new("UICorner", switchThumb).CornerRadius = UDim.new(1, 0)

    -- 🔄 5. ฟังก์ชันอัปเดตแอนิเมชันสวิตช์แบบเคลื่อนที่ Smooth ด้วย Tween
    local function updateVisuals(animate)
        local isAct = false
        if stateKey == "SkinChangerEnabled" then
            isAct = getgenv().skinChanger
        else
            isAct = Config[stateKey]
        end

        -- คำนวณพิกัดและสีปลายทางตามสถานะ ON / OFF
        local targetPosition = isAct and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
        local targetTrackColor = isAct and Color3.fromRGB(24, 45, 32) or Color3.fromRGB(25, 25, 30)
        local targetThumbColor = isAct and THEME.Active or Color3.fromRGB(140, 140, 150)
        local targetStrokeColor = isAct and THEME.Active or Color3.fromRGB(35, 35, 45)
        local targetTrackStroke = isAct and THEME.Active or Color3.fromRGB(50, 50, 60)

        local speed = animate and 0.2 or 0 
        local tweenInfo = TweenInfo.new(speed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

        -- สั่งรันเล่นแอนิเมชันสไลด์ปรับสีสัน
        TweenService:Create(switchThumb, tweenInfo, {Position = targetPosition, BackgroundColor3 = targetThumbColor}):Play()
        TweenService:Create(switchTrack, tweenInfo, {BackgroundColor3 = targetTrackColor}):Play()
        TweenService:Create(stroke, tweenInfo, {Color = targetStrokeColor}):Play()
        TweenService:Create(trackStroke, tweenInfo, {Color = targetTrackStroke}):Play()
    end

    -- ⚡ 6. ตรรกะการทำงานเมื่อมีการคลิก (คลิกได้ทั้งแถวของการ์ดเพื่อความสะดวก)
    local function onToggleClicked()
        if stateKey == "SkinChangerEnabled" then
            getgenv().skinChanger = not getgenv().skinChanger
            pcall(function() getgenv().updateSword() end)
        else
            Config[stateKey] = not Config[stateKey]
        end
        
        if type(CustomNotify) == "function" then
            CustomNotify(name .. " Toggled!", 2)
        end
        updateVisuals(true) 
    end

    -- สร้างปุ่มล่องหนทับทั้งการ์ดเพื่อให้กดคลิกตรงไหนของแถวก็ได้
    local mainTrigger = Instance.new("TextButton", container)
    mainTrigger.Size = UDim2.new(1, 0, 1, 0)
    mainTrigger.BackgroundTransparency = 1
    mainTrigger.Text = ""
    mainTrigger.ZIndex = 5

    mainTrigger.MouseButton1Click:Connect(onToggleClicked)
    
    if not _G.RemoteToggle then
        _G.RemoteToggle = {}
    end

    -- ลงทะเบียนฟังก์ชันคลิกของปุ่มนี้ไว้ในระบบ Global โดยใช้ stateKey (ชื่อสวิตช์) เป็นตัวอ้างอิง
    _G.RemoteToggle[stateKey] = function()
        onToggleClicked()
    end

    updateVisuals(false) -- โหลดสถานะเริ่มต้นแบบทันที
end

-- 🔄 PREMIUM CYBERPUNK BLACK & RED CYCLE CONTROLLER (WITH PULSE EFFECT)
local function createCycle(name, stateKey, list, parent, onChanged)
    -- 📦 1. กรอบพื้นหลังการ์ดหลัก (Deep Dark Carbon Base)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = Color3.fromRGB(10, 10, 12) -- สีดำสนิทพรีเมียม
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    -- 🔴 เส้นขอบนีออนสีแดงเข้ม (Crimson Dark Outline)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(80, 15, 20)
    stroke.Thickness = 1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    -- 🔴 2. วงแหวนสะท้อนแสงด้านหลังปุ่มกลม (Pulse Ripple Glow Background)
    local pulseGlow = Instance.new("Frame", btn)
    pulseGlow.Size = UDim2.fromOffset(12, 12)
    pulseGlow.Position = UDim2.new(1, -24, 0.5, -6)
    pulseGlow.BackgroundColor3 = Color3.fromRGB(255, 40, 50) -- นีออนแดงสว่าง
    pulseGlow.BackgroundTransparency = 1 -- ซ่อนไว้เริ่มต้น
    pulseGlow.BorderSizePixel = 0
    Instance.new("UICorner", pulseGlow).CornerRadius = UDim.new(1, 0)

    -- 🔴 3. ปุ่มวงกลมนีออนหลักด้านขวาสุด (Core Neon Core)
    local designCircle = Instance.new("Frame", btn)
    designCircle.Size = UDim2.fromOffset(12, 12)
    designCircle.Position = UDim2.new(1, -24, 0.5, -6)
    designCircle.BackgroundColor3 = Color3.fromRGB(255, 40, 50) -- แดงนีออน
    designCircle.BorderSizePixel = 0
    Instance.new("UICorner", designCircle).CornerRadius = UDim.new(1, 0)

    -- เพิ่มเงาเรืองแสงให้ปุ่มวงกลม (Neon Stroke Core)
    local circleStroke = Instance.new("UIStroke", designCircle)
    circleStroke.Color = Color3.fromRGB(255, 100, 110)
    circleStroke.Thickness = 1

    -- 🔄 4. ฟังก์ชันอัปเดตข้อความและสีสันตามสเตทภายใน
    local function update()
        -- จัดข้อความเป็นสีขาวนวล และเน้นค่าในวงเล็บด้วยสีแดงสดผ่านระบบ RichText (ถ้าบอร์ดรองรับ)
        btn.Text = "  " .. name .. " : [ " .. tostring(Config[stateKey]) .. " ]"
        btn.TextColor3 = Color3.fromRGB(230, 230, 235)
        btn.TextXAlignment = Enum.TextXAlignment.Left

        -- จัดการระบบธีมพื้นหลังหน้าต่างหลัก
        if stateKey == "UIBackground" then
            local colors = {
                DARK = Color3.fromRGB(12, 12, 16),
                RED = Color3.fromRGB(45, 10, 18),
                BLUE = Color3.fromRGB(10, 20, 45),
                PURPLE = Color3.fromRGB(30, 15, 45),
                GREEN = Color3.fromRGB(10, 40, 25),
                ORANGE = Color3.fromRGB(50, 25, 10)
            }
            local selectedColor = colors[Config[stateKey]]
            if selectedColor then
                MainFrame.BackgroundColor3 = selectedColor
                UIBackgroundImage.Visible = false
            end
        end
    end

    -- ⚡ 5. แอนิเมชันลูกเล่นตอนกดคลิกปุ่ม (Pulse Ripple Action)
    btn.MouseButton1Click:Connect(function()
        local idx = table.find(list, Config[stateKey]) or 1
        Config[stateKey] = list[idx + 1 > #list and 1 or idx + 1]

        -- 🎬 [ลูกเล่นที่ 1]: สั่งให้ปุ่มวงกลมยุบตัวและดีดกลับแบบมีสปริง (Squish Elastic)
        designCircle.Size = UDim2.fromOffset(4, 4)
        designCircle.Position = UDim2.new(1, -20, 0.5, -2)
        TweenService:Create(designCircle, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(12, 12),
            Position = UDim2.new(1, -24, 0.5, -6)
        }):Play()

        -- 🎬 [ลูกเล่นที่ 2]: สร้างวงแสงระเบิดสะท้อนวูบวาบขยายตัวออก (Neon Pulse Ripple Effect)
        pulseGlow.Size = UDim2.fromOffset(12, 12)
        pulseGlow.Position = UDim2.new(1, -24, 0.5, -6)
        pulseGlow.BackgroundTransparency = 0.3
        
        TweenService:Create(pulseGlow, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(28, 28),
            Position = UDim2.new(1, -32, 0.5, -14),
            BackgroundTransparency = 1
        }):Play()

        update()
        if onChanged then onChanged(Config[stateKey]) end
    end)

    -- 🎬 [ลูกเล่นที่ 3]: แอนิเมชันตอนเมาส์ชี้/นิ้วแตะโดน (Hover Glow Effect)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(22, 14, 16)}):Play() -- เปลี่ยนเป็นดำอมแดง
        TweenService:Create(stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(255, 40, 50)}):Play() -- ขอบสว่างเป็นแดงนีออน
    end)

    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(10, 10, 12)}):Play() -- กลับเป็นดำสนิท
        TweenService:Create(stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(80, 15, 20)}):Play() -- ขอบกลับเป็นแดงมืด
    end)

    update()
end

local function createActionBtn(text, color, fn, parent)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.Text = text
    btn.AutoButtonColor = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    btn.MouseButton1Click:Connect(fn)
end

local TweenService = game:GetService("TweenService")

-- 🛠️ SMART DROPDOWN/SELECT CREATOR (FIXED VISIBILITY & LAYER CLIPPING)
local function createSelect(labelText, defaultOption, optionsList, parent, onSelectionChanged)
    local currentSelected = defaultOption or (optionsList and optionsList[1]) or "None"
    local isDropdownOpen = false

    -- 📦 1. กรอบหลักภายนอก
    local selectContainer = Instance.new("Frame", parent)
    selectContainer.Size = UDim2.new(1, 0, 0, 34)
    selectContainer.BackgroundColor3 = THEME.InputBg
    Instance.new("UICorner", selectContainer).CornerRadius = UDim.new(0, 6)

    local containerStroke = Instance.new("UIStroke", selectContainer)
    containerStroke.Color = Color3.fromRGB(45, 45, 60)
    containerStroke.Thickness = 1

    -- 🏷️ 2. TextLabel ด้านหน้า (ป้ายชื่อหัวข้อ)
    local label = Instance.new("TextLabel", selectContainer)
    label.Size = UDim2.new(0, 0, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText or "Select:"
    label.TextColor3 = THEME.TextMain
    label.Font = Enum.Font.GothamBold
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.AutomaticSize = Enum.AutomaticSize.X 

    -- 🔘 3. ปุ่มกดเลือกตัวเลือกด้านหลัง
    local selectButton = Instance.new("TextButton", selectContainer)
    selectButton.BackgroundTransparency = 1
    selectButton.Text = tostring(currentSelected)
    selectButton.TextColor3 = THEME.TextMain
    selectButton.Font = Enum.Font.GothamBold
    selectButton.TextSize = 11
    selectButton.TextXAlignment = Enum.TextXAlignment.Left
    selectButton.ZIndex = 10 -- เพิ่มลำดับให้กดติดง่ายขึ้น

    -- 📐 ระบบจัดตำแหน่งระยะอัตโนมัติ
    local function updateLayout()
        local labelWidth = label.AbsoluteSize.X
        selectButton.Position = UDim2.new(0, 10 + labelWidth + 6, 0, 0)
        selectButton.Size = UDim2.new(1, -(10 + labelWidth + 6 + 10), 1, 0)
    end
    label:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateLayout)
    task.spawn(updateLayout)

    -- 📋 4. หน้าต่างลอยแสดงรายการตัวเลือก (Dropdown List)
    local listContainer = Instance.new("Frame")
    listContainer.BackgroundColor3 = THEME.InputBg
    listContainer.BorderSizePixel = 0
    listContainer.ZIndex = 10000 -- 🌟 [FIXED ZINDEX]: ดันค่าเลเยอร์ให้สูงสุดเหนือ MainFrame เพื่อให้แสดงผลลอยขึ้นมาได้จริง
    listContainer.Visible = false
    Instance.new("UICorner", listContainer).CornerRadius = UDim.new(0, 6)
    
    local listStroke = Instance.new("UIStroke", listContainer)
    listStroke.Color = Color3.fromRGB(55, 55, 75)
    listStroke.Thickness = 1

    local scrollFrame = Instance.new("ScrollingFrame", listContainer)
    scrollFrame.Size = UDim2.new(1, -4, 1, -4)
    scrollFrame.Position = UDim2.new(0, 2, 0, 2)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 2
    scrollFrame.ScrollBarImageColor3 = THEME.Accent
    scrollFrame.ZIndex = 10001

    local listLayout = Instance.new("UIListLayout", scrollFrame)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 2)

    -- เชื่อม Dropdown เข้ากับ ScreenGui หลักเพื่อให้ไม่ถูกบดบังจากกรอบของ ScrollingFrame พ่อแม่
    local screenGui = parent:FindFirstAncestorOfClass("ScreenGui")
    if screenGui then listContainer.Parent = screenGui end

    -- 🌟 [SMART UP/DOWN FLIP LOGIC]: คํานวณจุดเปิดขึ้นด้านบนหากอยู่ใกล้ล่างจอภาพ
    local function updateDropdownPosition()
        local cam = workspace.CurrentCamera
        if selectButton and selectButton.Parent and cam then
            local buttonAbsPos = selectButton.AbsolutePosition
            local buttonAbsSize = selectButton.AbsoluteSize
            local screenSizeY = cam.ViewportSize.Y
            
            local expectedListHeight = math.clamp(listLayout.AbsoluteContentSize.Y + 6, 34, 150)
            -- เช็คเกณฑ์พิกัดแกน Y ถ้าล้นกรอบล่างจอภาพ
            local isCloseToBottom = (buttonAbsPos.Y + buttonAbsSize.Y + expectedListHeight) > (screenSizeY - 60)
            
            if isCloseToBottom then
                -- ⬆️ ดีดกล่องขึ้นด้านบนเหนือปุ่ม
                listContainer.Position = UDim2.fromOffset(buttonAbsPos.X, buttonAbsPos.Y - expectedListHeight - 4)
            else
                -- ⬇️ เปิดลงใต้ปุ่มตามปกติ
                listContainer.Position = UDim2.fromOffset(buttonAbsPos.X, buttonAbsPos.Y + buttonAbsSize.Y + 4)
            end
            
            listContainer.Size = UDim2.fromOffset(buttonAbsSize.X, expectedListHeight)
            scrollFrame.CanvasSize = UDim2.fromOffset(0, listLayout.AbsoluteContentSize.Y)
        end
    end
    listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateDropdownPosition)

    -- ➕ ฟังก์ชันสร้างปุ่มเมนูตัวเลือกภายใน Dropdown
    local function refreshOptions()
        for _, item in ipairs(scrollFrame:GetChildren()) do
            if item:IsA("TextButton") then item:Destroy() end
        end

        for idx, optionName in ipairs(optionsList or {}) do
            local optBtn = Instance.new("TextButton", scrollFrame)
            optBtn.Size = UDim2.new(1, 0, 0, 28)
            optBtn.BackgroundColor3 = (tostring(optionName) == tostring(currentSelected)) and THEME.Accent or Color3.fromRGB(25, 25, 35)
            optBtn.BackgroundTransparency = (tostring(optionName) == tostring(currentSelected)) and 0.3 or 0
            optBtn.Text = "  " .. tostring(optionName)
            optBtn.TextColor3 = THEME.TextMain
            optBtn.Font = Enum.Font.GothamBold
            optBtn.TextSize = 10
            optBtn.TextXAlignment = Enum.TextXAlignment.Left
            optBtn.ZIndex = 10002
            Instance.new("UICorner", optBtn).CornerRadius = UDim.new(0, 4)

            optBtn.MouseButton1Click:Connect(function()
                currentSelected = optionName
                selectButton.Text = tostring(optionName)
                isDropdownOpen = false
                listContainer.Visible = false
                containerStroke.Color = Color3.fromRGB(45, 45, 60)
                
                if onSelectionChanged then onSelectionChanged(optionName) end
            end)
        end
    end

    -- ⚡ เปิด/ปิด Dropdown เมื่อกดคลิกที่ปุ่ม
    selectButton.MouseButton1Click:Connect(function()
        isDropdownOpen = not isDropdownOpen
        if isDropdownOpen then
            refreshOptions()
            updateDropdownPosition()
            listContainer.Visible = true -- 🌟 เปิดความโปร่งแสงให้มองเห็นตัวเลือก
            containerStroke.Color = THEME.Accent
        else
            listContainer.Visible = false
            containerStroke.Color = Color3.fromRGB(45, 45, 60)
        end
    end)

    -- ดักจับการคลิกพื้นที่ด้านนอกเพื่อปิดเมนูอัตโนมัติ
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if isDropdownOpen and listContainer.Visible then
                local mLoc = UserInputService:GetMouseLocation()
                local pPos, pSize = listContainer.AbsolutePosition, listContainer.AbsoluteSize
                local bPos, bSize = selectButton.AbsolutePosition, selectButton.AbsoluteSize
                
                local inList = (mLoc.X >= pPos.X and mLoc.X <= pPos.X + pSize.X and mLoc.Y >= pPos.Y and mLoc.Y <= pPos.Y + pSize.Y)
                local inButton = (mLoc.X >= bPos.X and mLoc.X <= bPos.X + bSize.X and mLoc.Y >= bPos.Y and mLoc.Y <= bPos.Y + bSize.Y)
                
                if not inList and not inButton then
                    isDropdownOpen = false
                    listContainer.Visible = false
                    containerStroke.Color = Color3.fromRGB(45, 45, 60)
                end
            end
        end
    end)

    -- ซิงค์ตำแหน่งหน้าจอตลอดเวลาเพื่อป้องกันเฟรมหลุด
    RunService.RenderStepped:Connect(function()
        if isDropdownOpen and listContainer.Visible then updateDropdownPosition() end
    end)

    return {
        SetValue = function(newValue)
            currentSelected = newValue
            selectButton.Text = tostring(newValue)
        end,
        Visible = function(state)
            selectContainer.Visible = state
            if not state then listContainer.Visible = false isDropdownOpen = false end
        end
    }
end

-- 🛠️ FIXED AUTOMATIC TEXTBOX CREATOR (CORRECTED ARGUMENTS)
local function createTextBox(labelText, defaultText, arg3, arg4, arg5)
    local stateKey
    local parent
    local onFocusLost

    -- 🔍 ตรวจสอบโครงสร้างอาร์กิวเมนต์แบบ Dynamic
    if typeof(arg3) == "Instance" or (typeof(arg3) == "nil" and typeof(arg4) == "function") then
        -- [แบบที่ 1: โครงสร้างเก่าเหมือน Tiger Bot] (ไม่มี stateKey ส่งมา)
        -- createTextBox(labelText, defaultText, parent, onFocusLost)
        stateKey = tostring(labelText or "DefaultKey") -- ใช้ชื่อหัวข้อเป็นคีย์อัตโนมัติ
        parent = arg3
        onFocusLost = arg4
    else
        -- [แบบที่ 2: โครงสร้างใหม่] (มี stateKey หรือส่ง "" คั่นกลางมา)
        -- createTextBox(labelText, defaultText, stateKey, parent, onFocusLost)
        stateKey = arg3
        parent = arg4
        onFocusLost = arg5
        
        -- ถ้าส่งมาเป็นค่าว่าง "" หรือลืมใส่ ให้เซฟเป็นชื่อหัวข้อแทน
        if stateKey == nil or stateKey == "" then
            stateKey = tostring(labelText or "DefaultKey")
        end
    end

    -- 📦 สร้างกรอบ UI
    local boxContainer = Instance.new("Frame", parent)
    boxContainer.Size = UDim2.new(1, 0, 0, 34)
    boxContainer.BackgroundColor3 = THEME.InputBg
    Instance.new("UICorner", boxContainer).CornerRadius = UDim.new(0, 6)

    local boxStroke = Instance.new("UIStroke", boxContainer)
    boxStroke.Color = Color3.fromRGB(45, 45, 60)
    boxStroke.Thickness = 1

    -- 🏷️ 1. TextLabel ด้านหน้า
    local label = Instance.new("TextLabel", boxContainer)
    label.Size = UDim2.new(0, 0, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText or "Input:"
    label.TextColor3 = THEME.TextMain
    label.Font = Enum.Font.GothamBold
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.AutomaticSize = Enum.AutomaticSize.X 

    -- ⌨️ 2. TextBox ช่องกรอกข้อมูลด้านหลัง
    local box = Instance.new("TextBox", boxContainer)
    box.BackgroundTransparency = 1
    
    -- ตรรกะผูกค่าข้อความเริ่มต้น (ถ้าใน Config ยังว่างอยู่ ให้ดึงชื่อหัวข้อมากรอกให้เองตามที่คุณต้องการ)
    local currentConfigValue = Config[stateKey]
    if currentConfigValue == nil or currentConfigValue == "" then
        box.Text = tostring(labelText or defaultText or "")
    else
        box.Text = tostring(currentConfigValue)
    end

    box.PlaceholderText = "Type here..."
    box.PlaceholderColor3 = THEME.TextDark
    box.TextColor3 = THEME.TextMain
    box.Font = Enum.Font.GothamBold
    box.TextSize = 11
    box.ClearTextOnFocus = false
    box.ClipsDescendants = true
    box.TextXAlignment = Enum.TextXAlignment.Left

    -- 📐 ระบบปรับขนาดอัตโนมัติ
    local function updateLayout()
        local labelWidth = label.AbsoluteSize.X
        box.Position = UDim2.new(0, 10 + labelWidth + 6, 0, 0)
        box.Size = UDim2.new(1, -(10 + labelWidth + 6 + 10), 1, 0)
    end
    label:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateLayout)
    task.spawn(updateLayout)

    -- ฟังก์ชันสำหรับอัปเดตค่าและสั่งรันระบบ
    local function applyValue(text)
        local numericValue = tonumber(text)
        Config[stateKey] = numericValue or text 
        if onFocusLost then onFocusLost(Config[stateKey]) end
    end

    -- ⚡ สัญญาณตรวจจับการกด/หลุดโฟกัส
    box.Focused:Connect(function() boxStroke.Color = THEME.Accent end)
    box.FocusLost:Connect(function(enterPressed)
        boxStroke.Color = Color3.fromRGB(45, 45, 60)
        applyValue(box.Text)
    end)

    -- 🌐 สแตนด์บายตารางสำหรับรับคำสั่งสั่งการจากภายนอก
    if not _G.RemoteTextBox then _G.RemoteTextBox = {} end
    
    _G.RemoteTextBox[stateKey] = function(newValue)
        box.Text = tostring(newValue)
        applyValue(box.Text)
    end

    return box
end

local function createLabel(text, parent)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Size = UDim2.new(1, 0, 0, 18)
    lbl.Text = "—— " .. text .. " ——"
    lbl.TextColor3 = THEME.TextDark
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 10
    lbl.BackgroundTransparency = 1
end

-- 🟢 สร้างตัวแปรข้อความ (TextLabels) รอไว้สำหรับอัปเดตข้อมูลสถานะ
createLabel("REAL-TIME MATCH STATUS", statusScroll)

local function createStatusCard(title, defaultText)
    local card = Instance.new("Frame", statusScroll)
    card.Size = UDim2.new(1, 0, 0, 34)
    card.BackgroundColor3 = THEME.CardBg
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", card).Color = Color3.fromRGB(45, 45, 60)
    
    local lbl = Instance.new("TextLabel", card)
    lbl.Size = UDim2.new(1, -16, 1, 0)
    lbl.Position = UDim2.new(0, 8, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "  " .. title .. " : " .. defaultText
    lbl.TextColor3 = THEME.TextMain
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
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
createLabel("SUCCESS PARRY COOLDOWN SYSTEM", combatScroll)

createTextBox("Success Reset Cooldown (Seconds)", tostring(Config.ResetCooldownTime or 0.12), "ResetCooldownTime", combatScroll, function(val)
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
-- 🎯 SMART TRAINING AUTO PARRY (HYBRID MODE + ANTI-DOUBLE HIT COOLDOWN)
-- =======================================================================
Config.TrainingAutoParry = false 

local lastTrainingHitTime = 0 -- ตัวนับเวลาป้องกันการตีเบิ้ลคลิก

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

-- ═══ แก้ไขลูป TRAINING PARRY ให้ใช้ระบบคูลดาวน์เดียวกับ PHYSICAL ลูป ═══
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
                
                -- 🔒 ดึงระบบคูลดาวน์แบบ Dynamic จากลูปฟิสิกส์หลักมาใช้โดยตรง (แก้บั๊กเบิ้ลคลิก 100%)
                if parryLocked[ball] then
                    local speed = ball.AssemblyLinearVelocity.Magnitude
                    local safeLockCooldown = math.clamp(0.45 - (speed * 0.0001), 0.70, 0.85) -- คูลดาวน์มาตรฐานฟิสิกส์ลูป
                    if now - (lockTime[ball] or 0) >= safeLockCooldown then
                        parryLocked[ball] = false
                    else
                        return -- ข้ามเฟรมเพื่อกันเบิ้ลคลิก
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
                        -- บันทึกสถานะลงตารางกลางของระบบฟิสิกส์หลัก
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

createToggle("⚡ Smart Training Parry (Hybrid)", "TrainingAutoParry", combatScroll)

createToggle("Soccer Mode", "SoccerMode", combatScroll)
createToggle("immortal", "GodMode", combatScroll)
createToggle("Smart Auto Ability", "AutoAbility", combatScroll)

createToggle("Play Parry Animation Track", "SwordAnimationsEnabled", combatScroll)
createToggle("Auto Spam Clash", "AutoSpam", combatScroll)

-- 1. เพิ่มสถานะและ Config สำหรับ Manual Spam (ใส่ไว้ส่วนบนของสคริปต์)
Config.ManualSpamShow = false  -- ใช้สำหรับคุมปุ่มในเฟรมหลัก (โชว์/ซ่อนปุ่มลอย)
Config.ManualSpamActive = false -- ใช้สำหรับคุมปุ่มลอย (เปิด/ปิดระบบสแปมจริง)

-- 2. สร้างปุ่มวงกลมลอยสำหรับควบคุม (Floating Toggle Control)
-- 🔘 สร้างปุ่มวงกลมลอยสำหรับควบคุม (Floating Spam Button)
local FloatingSpamBtn = Instance.new("TextButton", ScreenGui)
FloatingSpamBtn.Size = UDim2.new(0, 55, 0, 55)
FloatingSpamBtn.Position = UDim2.new(0.82, 0, 0.48, 0)
FloatingSpamBtn.BackgroundColor3 = THEME.Sidebar
FloatingSpamBtn.Text = "SPAM\nOFF"
FloatingSpamBtn.TextColor3 = THEME.Inactive
FloatingSpamBtn.Font = Enum.Font.GothamBold
FloatingSpamBtn.TextSize = 10
FloatingSpamBtn.Visible = false -- เริ่มต้นซ่อนไว้ (จะโชว์เมื่อเปิดปุ่มจากเฟรมหลัก)
Instance.new("UICorner", FloatingSpamBtn).CornerRadius = UDim.new(1, 0) -- บังคับเป็นวงกลมสมบูรณ์

fsStroke = Instance.new("UIStroke", FloatingSpamBtn)
fsStroke.Color = THEME.Inactive
fsStroke.Thickness = 2

-- =======================================================================
-- 🔒 [FIXED SYNTAX] FLOATING SPAM BUTTON (DYNAMIC HOLD & DRAG LOCK ENGINE)
-- =======================================================================
local fsDrag = false
local fsStartPos = nil
local fsButtonPos = nil
local fsTouchStartTick = 0
local fsHasTriggeredLock = false 

-- [CRITICAL FIX]: ปรับโครงสร้างบรรทัดนี้ใหม่ให้เป็นแบบแยกประกาศทีละบรรทัดเพื่อป้องกันคอมไพเลอร์ Lua สับสน
local fsMouseStart = nil
local fsThreshold = 5
local fsIsDragging = false

-- 🎨 ฟังก์ชันอัปเดตสีและข้อความของปุ่มลอย
local function updateFloatingButtonVisual()
    if Config.ManualSpamActive then
        FloatingSpamBtn.Text = "SPAM\nON"
        FloatingSpamBtn.TextColor3 = THEME.Active
        fsStroke.Color = THEME.Active
        FloatingSpamBtn.BackgroundColor3 = Color3.fromRGB(18, 32, 24)
    else
        FloatingSpamBtn.Text = "SPAM\nOFF"
        FloatingSpamBtn.TextColor3 = THEME.Inactive
        fsStroke.Color = THEME.Inactive
        FloatingSpamBtn.BackgroundColor3 = THEME.Sidebar
    end
end

-- ⚡ 1. จังหวะเริ่มเอาเมาส์กด หรือ เอานิ้วจิ้มปุ่ม (InputBegan)
FloatingSpamBtn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        fsTouchStartTick = os.clock() 
        fsStartPos = i.Position
        fsButtonPos = FloatingSpamBtn.Position
        fsHasTriggeredLock = false
        fsDrag = false

        task.spawn(function()
            task.wait(0.4) 
            if fsTouchStartTick > 0 and not fsHasTriggeredLock then
                fsDrag = true 
                fsHasTriggeredLock = true 
                
                pcall(function()
                    fsStroke.Color = Color3.fromRGB(255, 200, 50)
                    task.wait(0.15)
                    updateFloatingButtonVisual()
                end)
            end
        end)
    end
end)

-- ⚡ 2. จังหวะขยับเมาส์ หรือ ลากนิ้วบนจอ (InputChanged)
UserInputService.InputChanged:Connect(function(i)
    if (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        if fsDrag and fsStartPos and fsButtonPos then
            local d = i.Position - fsStartPos
            local cam = workspace.CurrentCamera
            local targetX = fsButtonPos.X.Offset + d.X
            local targetY = fsButtonPos.Y.Offset + d.Y
            
            if cam then
                targetX = math.clamp(targetX, 0, cam.ViewportSize.X - FloatingSpamBtn.Size.X.Offset)
                targetY = math.clamp(targetY, 0, cam.ViewportSize.Y - FloatingSpamBtn.Size.Y.Offset)
            end
            
            FloatingSpamBtn.Position = UDim2.new(fsButtonPos.X.Scale, targetX, fsButtonPos.Y.Scale, targetY)
        end
    end
end)

-- ⚡ 3. จังหวะปล่อยเมาส์ หรือ ยกนิ้วออกจากหน้าจอ (InputEnded)
FloatingSpamBtn.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        local holdDuration = os.clock() - fsTouchStartTick
        fsTouchStartTick = 0 
        fsDrag = false 

        if holdDuration < 0.4 and not fsHasTriggeredLock then
            Config.ManualSpamActive = not Config.ManualSpamActive
            updateFloatingButtonVisual()
            if type(CustomNotify) == "function" then
                CustomNotify("Spam Overdrive: " .. (Config.ManualSpamActive and "ON" or "OFF"), 1.5)
            end
        else
            updateFloatingButtonVisual() 
        end
        
        fsHasTriggeredLock = false
    end
end)

-- Training manual spammmmmmm
Config.TrainingManualSpamShow = false   -- คุมการ เปิด/ปิด แสดงปุ่มลอยบนจอ
Config.TrainingManualSpamActive = false -- สเตทการกดปุ่มลอยเพื่อเปิดระบบสแปมจริง

-- =======================================================================
-- 🟠 FLOATING BUTTON & OVERDRIVE ENGINE FOR TRAINING MANUAL SPAM
-- =======================================================================
local FloatingTrainingSpamBtn = Instance.new("TextButton", ScreenGui)
FloatingTrainingSpamBtn.Size = UDim2.new(0, 55, 0, 55)
FloatingTrainingSpamBtn.Position = UDim2.new(0.82, 0, 0.58, 0) -- แยกพิกัดไม่ให้ทับปุ่มโหมดปกติ
FloatingTrainingSpamBtn.BackgroundColor3 = Color3.fromRGB(20, 15, 10)
FloatingTrainingSpamBtn.Text = "T-SPAM\nOFF"
FloatingTrainingSpamBtn.TextColor3 = THEME.Inactive
FloatingTrainingSpamBtn.Font = Enum.Font.GothamBold
FloatingTrainingSpamBtn.TextSize = 9
FloatingTrainingSpamBtn.Visible = false
Instance.new("UICorner", FloatingTrainingSpamBtn).CornerRadius = UDim.new(1, 0)

local tFsStroke = Instance.new("UIStroke", FloatingTrainingSpamBtn)
tFsStroke.Color = THEME.Inactive
tFsStroke.Thickness = 2

-- 📌 ระบบลากปุ่มวงกลมสำหรับห้องซ้อม (Drag Logic)
local tFsDrag, tFsStart, tFsPos, tFsMouseStart
local tFsIsDragging = false

FloatingTrainingSpamBtn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        tFsDrag = true
        tFsStart = i.Position
        tFsMouseStart = UserInputService:GetMouseLocation()
        tFsPos = FloatingTrainingSpamBtn.Position
        tFsIsDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if tFsDrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        if (UserInputService:GetMouseLocation() - tFsMouseStart).Magnitude > 5 then
            tFsIsDragging = true
        end
        if tFsIsDragging then
            local d = i.Position - tFsStart
            local cam = workspace.CurrentCamera
            local targetX = tFsPos.X.Offset + d.X
            local targetY = tFsPos.Y.Offset + d.Y
            if cam then
                targetX = math.clamp(targetX, 0, cam.ViewportSize.X - FloatingTrainingSpamBtn.Size.X.Offset)
                targetY = math.clamp(targetY, 0, cam.ViewportSize.Y - FloatingTrainingSpamBtn.Size.Y.Offset)
            end
            FloatingTrainingSpamBtn.Position = UDim2.new(tFsPos.X.Scale, targetX, tFsPos.Y.Scale, targetY)
        end
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        tFsDrag = false
    end
end)

-- 🎨 ฟังก์ชันอัปเดตสถานะสีปุ่มลอยห้องซ้อม
local function updateTrainingFloatingVisual()
    if Config.TrainingManualSpamActive then
        FloatingTrainingSpamBtn.Text = "T-SPAM\nON"
        FloatingTrainingSpamBtn.TextColor3 = Color3.fromRGB(255, 130, 30) -- สีส้มสว่างสำหรับโหมดซ้อม
        tFsStroke.Color = Color3.fromRGB(255, 130, 30)
        FloatingTrainingSpamBtn.BackgroundColor3 = Color3.fromRGB(40, 25, 15)
    else
        FloatingTrainingSpamBtn.Text = "T-SPAM\nOFF"
        FloatingTrainingSpamBtn.TextColor3 = THEME.Inactive
        tFsStroke.Color = THEME.Inactive
        FloatingTrainingSpamBtn.BackgroundColor3 = Color3.fromRGB(20, 15, 10)
    end
end

FloatingTrainingSpamBtn.MouseButton1Click:Connect(function()
    if tFsIsDragging then return end
    Config.TrainingManualSpamActive = not Config.TrainingManualSpamActive
    updateTrainingFloatingVisual()
    if type(CustomNotify) == "function" then
        CustomNotify("Training Spam Overdrive: " .. (Config.TrainingManualSpamActive and "ON" or "OFF"), 1.5)
    end
end)

-- =======================================================================
-- 🟠 FLOATING BUTTON & OVERDRIVE ENGINE FOR TRAINING MANUAL SPAM (RATE LIMITER)
-- =======================================================================
task.spawn(function()
    getTrainingBall = GetTrainingBallOnly
    fireRemote = Auto_Parry.FireParryRemote

    while shared._InvisRunning do
        if Config.TrainingManualSpamActive and Config.TrainingManualSpamShow then
            currentBall = type(getTrainingBall) == "function" and getTrainingBall()
            if currentBall and type(fireRemote) == "function" then
                
                currentTrainingBatch = tonumber(Config.trainingPacketBatchSize) or 16
                currentTrainingBatch = math.clamp(currentTrainingBatch, 1, 100)

                -- 📐 กระจายแพ็กเก็ตสลับท่อในเศษเสี้ยววินาทีป้องกันเน็ตหลุด/เซิร์ฟเวอร์ดีดในห้องซ้อม
                trainingMicroInterval = 1 / currentTrainingBatch

                coroutine.wrap(function()
                    for i = 1, currentTrainingBatch do
                        if not Config.TrainingManualSpamActive or not Config.TrainingManualSpamShow then break end
                        
                        pcall(fireRemote, true)
                        
                        task.wait(trainingMicroInterval)
                    end
                end)()
            end
            task.wait(0) 
        else
            task.wait(0.1)
        end
    end
end)

-- ลูปเฝ้าตรวจสถานะ Config เพื่อสลับการแสดงผลปุ่มลอยอัตโนมัติ
task.spawn(function()
    local lastShowState = false
    while shared._InvisRunning do
        if Config.TrainingManualSpamShow ~= lastShowState then
            lastShowState = Config.TrainingManualSpamShow
            if Config.TrainingManualSpamShow then
                FloatingTrainingSpamBtn.Visible = true
            else
                FloatingTrainingSpamBtn.Visible = false
                Config.TrainingManualSpamActive = false
                updateTrainingFloatingVisual()
            end
        end
        task.wait(0.1)
    end
end)

createToggle("Training Spam Floating Button", "TrainingManualSpamShow", combatScroll)


-- =======================================================================
-- 🚀 HIGH-ACCURACY FLOATING BUTTON SPAM LIMITER (TRAINING STYLE PRO)
-- =======================================================================
task.spawn(function()
    local getBall = Auto_Parry.Get_Ball
    local fireRemote = Auto_Parry.FireParryRemote

    while shared._InvisRunning do
        if Config.ManualSpamActive and Config.ManualSpamShow then
            local currentBall = type(getBall) == "function" and getBall()
            if currentBall and type(fireRemote) == "function" then
                
                -- ดึงค่า Batch Size มาคำนวณ (จำกัดเพดานความแรงไว้ที่ 64 แพ็กเก็ตสูงสุด)
                local currentBatch = tonumber(Config.packetBatchSize) or 16
                currentBatch = math.clamp(currentBatch, 1, 1000)

                -- 📐 กระจายแพ็กเก็ตสลับท่อในเศษเสี้ยววินาทีแบบเดียวกับ Training Spam
                local microInterval = 1 / currentBatch

                -- ครอบขยายสัญญาณโดยกระจายช่องว่างเพื่อป้องกันหน้าจอค้าง (Asynchronous Spreading)
                coroutine.wrap(function()
                    for i = 1, currentBatch do
                        if not Config.ManualSpamActive or not Config.ManualSpamShow then break end
                        
                        -- ยิงแพ็กเก็ตสแปมจริงแบบเบิ้ลตรรกะคู่ขนานเพื่อความไวที่เพิ่มขึ้น
                        pcall(fireRemote, true)
                        pcall(fireRemote, true)
                        pcall(fireRemote, true)
                        
                        -- ใช้ task.wait หน่วงจุลภาคเพื่อเคลียร์ช่องสัญญาณ ไม่ให้ตัวเกมกระตุกค้าง
                        task.wait(microInterval)
                    end
                end)()
            end
            task.wait(0) -- ทำงานซ้ำในรอบถัดไปทันทีอย่างต่อเนื่อง
        else
            task.wait(0.1)
        end
    end
end)

createToggle("Infinity Spam Floating Button", "ManualSpamShow", combatScroll)

-- ลูปตรวจสอบสถานะจากปุ่มเมนูหลักแบบ Real-time เพื่อสั่ง ซ่อน/แสดง ปุ่มลอย
task.spawn(function()
    local lastShowState = false
    while shared._InvisRunning do
        if Config.ManualSpamShow ~= lastShowState then
            lastShowState = Config.ManualSpamShow
            
            if Config.ManualSpamShow then
                FloatingSpamBtn.Visible = true -- แสดงปุ่มลอย
            else
                FloatingSpamBtn.Visible = false -- ซ่อนปุ่มลอย
                Config.ManualSpamActive = false -- ปิดระบบสแปมทันทีเพื่อความปลอดภัย
                if type(updateFloatingButtonVisual) == "function" then
                    updateFloatingButtonVisual() -- อัปเดตสีปุ่มลอยให้กลับเป็นสีแดง/OFF
                end
            end
        end
        task.wait(0.1) -- เช็คความถี่ทุกๆ 0.1 วินาทีเพื่อประหยัดทรัพยากรเครื่อง
    end
end)

-- ทำการ Hook ทับปุ่มกดเพื่อให้แสดงผลและควบคุมร่วมกับปุ่มวงกลมลอยได้สมบูรณ์
local originalToggleLogic = combatScroll:FindFirstChild("Manual Spam Overdrive_ScrollFrame") or combatScroll:GetChildren()[#combatScroll:GetChildren()]
-- 🌟 แก้ไขโค้ดตรรกะของปุ่มเดิมใน mainframe
if originalToggleLogic and originalToggleLogic:IsA("TextButton") then
    originalToggleLogic.MouseButton1Click:Connect(function()
        -- บังคับปิดระบบสแปมไว้ก่อนตอนกดสวิตช์ในเมนูหลัก ไม่ให้มันเปิดเอง
        Config.ManualSpam = false 
        updateFloatingButtonVisual()
        
        -- ควบคุมแค่การโชว์/ซ่อน ปุ่มวงกลมลอย (Floating Button) ตามค่าเปิดปิด
        FloatingSpamBtn.Visible = Config.ManualSpamEnabled -- (ใช้ตัวแปรเช็คสถานะการเปิดใช้งานเมนู)
    end)
end

createToggle("Auto Play (Bot Movement)", "AutoPlay", combatScroll)
createToggle("Special Skill Detections", "SpecialSkillDetections", combatScroll)
createToggle("Look at Ball (Character)", "LookAtBallChar", combatScroll)
createToggle("Look at Ball (Camera)", "LookAtBallCam", combatScroll)
createToggle("mouse/touch location(target)", "UseMouseLocation", combatScroll)

-- 1. เพิ่มค่าเริ่มต้นของ Parry Curve Mode ลงในตาราง Config (หากยังไม่มี)
Config.ParryCurveMode = "Camera" 

-- 2. สร้างรายการตัวเลือกโหมดวิถีบอลไซด์โค้ง (Options List)
local ParryCurveModes = {
    "Camera",    -- บอลไซด์โค้งเลี้ยวตามหน้ากล้องและมุมเงย
    "Left",      -- บอลหักไซด์เลี้ยวฉีกหนีไปทางซ้ายมือ
    "Right",     -- บอลหักไซด์เลี้ยวฉีกหนีไปทางขวามือ
    "Up",        -- บอลย้อยงัดขึ้นฟ้าข้ามหัวหลบแนวบล็อก
    "Down",      -- บอลปักหัวดิ่งลงพื้นเพื่อเร่งความเร็ว
    "Random",    -- สุ่มพิกัดรอบตัวศัตรูให้เดาทางยาก
    "Straight"   -- พุ่งตรงปกติ ไม่ออฟเซ็ตพิกัด
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

-- 🎯 3. ตัวเลือกโปรไฟล์การล็อกเป้าหมายผู้เล่น (Lock Target Profile)
createSelect("Lock Target Profile", Config.TargetMode or "Double click", {
    "Double click", "Normal", "Nearest", "Farest"
}, combatScroll, function(selected)
    Config.TargetMode = selected
    if type(CustomNotify) == "function" then
        CustomNotify("Target Profile: " .. selected, 2)
    end
end)

-- ═══ VISUAL CONTROLS ═══
createToggle("Player Ability ESP Tracker", "AbilityESP", visualScroll)
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
-- ⏳ LOCK-GATE COOLDOWN RESETTER (DYNAMIC TEXTBOX SETTING VERSION)
-- =======================================================================
-- ตั้งค่าสถานะเริ่มต้นของระบบล็อกประตูคิว
if _G.InvisIsCoolingDown == nil then _G.InvisIsCoolingDown = false end

-- 🔒 กำหนดค่าเริ่มต้นให้กับ Config หากในระบบยังไม่มีค่าบันทึกไว้ (Default 0.12)
if Config.ResetCooldownTime == nil then
    Config.ResetCooldownTime = 0.12
end

pcall(function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Debris = game:GetService("Debris")
    local TweenService = game:GetService("TweenService")
    local LocalPlayerName = game:GetService("Players").LocalPlayer.Name

    ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(_, ballPart, swordName, playerName)
        if tostring(playerName) == LocalPlayerName then
            
            -- 🛡️ [DEBOUNCE GATE] ถ้าอันเก่ายังนับไม่เสร็จ ให้ปัดสัญญาณใหม่ทิ้งทันที
            if _G.InvisIsCoolingDown then 
                return 
            end

            -- บล็อกประตูระบบทันที ป้องกันอันใหม่เข้ามาแทรกแซง
            _G.InvisIsCoolingDown = true

            -- ⏱️ ดึงค่าหน่วงเวลาแบบไดนามิกจากช่อง TextBox (Config.ResetCooldownTime) มาสั่งงานแทนตัวเลขคงที่
            local currentDelay = tonumber(Config.ResetCooldownTime) or 0.12
            
            task.delay(currentDelay, function()
                if type(parryLocked) == "table" then 
                    table.clear(parryLocked) 
                end
                if type(lockTime) == "table" then 
                    table.clear(lockTime) 
                end
                
                if ballPart and type(shared.InvisClearLock) == "function" then
                    shared.InvisClearLock(ballPart)
                end
                
                -- 🔓 ปลดล็อกประตูเปิดรับสัญญาณรอบถัดไป เมือนับอันเก่าจบครบเวลาแล้วจริง ๆ
                _G.InvisIsCoolingDown = false
            end)

            -- 🎨 เล่นเอฟเฟกต์คอมโบตามปกติ
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
end)

-- 3. สร้างตัวปุ่ม Toggle บนหน้าจอเมนู
createToggle("Custom Combo Overlap FX", "CustomComboFX", visualScroll)

local LowGraphicBtn = Instance.new("TextButton", visualScroll)
LowGraphicBtn.Size = UDim2.new(1, 0, 0, 34)
LowGraphicBtn.BackgroundColor3 = THEME.CardBg
LowGraphicBtn.Font = Enum.Font.GothamBold
LowGraphicBtn.TextSize = 11
Instance.new("UICorner", LowGraphicBtn).CornerRadius = UDim.new(0, 6)

local lowStroke = Instance.new("UIStroke", LowGraphicBtn)
lowStroke.Thickness = 1

local updateLowGFX = function()
    if Config.LowGraphicsEnabled then
        LowGraphicBtn.Text = "  Low Graphics Mode : ACTIVE"
        LowGraphicBtn.TextColor3 = THEME.Active
        lowStroke.Color = THEME.Active
    else
        LowGraphicBtn.Text = "  Low Graphics Mode : DISABLED"
        LowGraphicBtn.TextColor3 = THEME.Inactive
        lowStroke.Color = Color3.fromRGB(35, 35, 45)
    end
    LowGraphicBtn.TextXAlignment = Enum.TextXAlignment.Left
end

LowGraphicBtn.MouseButton1Click:Connect(function()
    applyLowGraphics(not Config.LowGraphicsEnabled)
    updateLowGFX()
end)
updateLowGFX()

createActionBtn("🔓 Unlock All", Color3.fromRGB(90, 40, 150), function()
    task.spawn(function()
        CustomNotify("Remake By INVIS", 2)
        pcall(function() 
            loadstring(game:HttpGet("https://raw.githubusercontent.com/foreverspacexc-blip/OTHERHUB/refs/heads/main/wSuhUFTr%20(1).txt"))()
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

local isCustomChar = false
local customModelInstance = nil
local syncConnection = nil

-- =========================================================
-- 👤 ADVANCED AVATAR CHANGER SYSTEM (ENGLISH VERSION)
-- =========================================================
Config.TargetAvatarInput = "" -- Stores the username or userid input

local function ExecuteAvatarChange(userInput)
    if userInput == nil or userInput == "" then
        if type(CustomNotify) == "function" then
            CustomNotify("⚠️ Please enter a Username or UserId first!", 3)
        end
        return
    end

    if type(CustomNotify) == "function" then
        CustomNotify("⏳ Fetching avatar data from Roblox...", 2.5)
    end

    task.spawn(function()
        local players = game:GetService("Players")
        local localPlayer = players.LocalPlayer
        local char = localPlayer.Character
        if not char then return end

        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then return end

        local targetUserId = tonumber(userInput)

        -- If the input is not a number, treat it as a Username and resolve the UserId
        if not targetUserId then
            local success, resolvedId = pcall(function()
                return players:GetUserIdFromNameAsync(userInput)
            end)
            if success and resolvedId then
                targetUserId = resolvedId
            else
                if type(CustomNotify) == "function" then
                    CustomNotify("❌ Username not found! Check your spelling.", 3)
                end
                return
            end
        end

        -- Fetch and apply the character description using the resolved UserId
        local success, err = pcall(function()
            local description = players:GetHumanoidDescriptionFromUserId(targetUserId)
            if description then
                hum:ApplyDescription(description)
                if type(CustomNotify) == "function" then
                    CustomNotify("✅ Avatar Transformed Successfully!", 3)
                end
            else
                if type(CustomNotify) == "function" then
                    CustomNotify("❌ Failed to load avatar description.", 3)
                end
            end
        end)

        if not success and type(CustomNotify) == "function" then
            CustomNotify("❌ An error occurred during transformation.", 3)
            warn("[Invis Avatar Error]: " .. tostring(err))
        end
    end)
end

-- ⌨️ Create TextBox in Visuals Tab (Supports both Username and UserId)
createTextBox("Type Target Username or UserId", "", "TargetAvatarInput", visualScroll, function(val)
    Config.TargetAvatarInput = tostring(val):match("^%s*(.-)%s*$") or "" -- Trims whitespaces
end)

-- 🔘 Create Action Button in Visuals Tab
createActionBtn("👤 Transform Avatar Body", Color3.fromRGB(0, 180, 120), function()
    ExecuteAvatarChange(Config.TargetAvatarInput)
end, visualScroll)
-- =========================================================

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
createTextBox("Speed", tostring(Config.CustomSpeed or ""), settingsScroll, function(val)
    local n = tonumber(val)
    Config.CustomSpeed = n
    CustomNotify("WalkSpeed Enforced: " .. tostring(n or "Default"), 2)
end)

createTextBox("JumpPower", tostring(Config.CustomJump or ""), settingsScroll, function(val)
    local n = tonumber(val)
    Config.CustomJump = n
    CustomNotify("JumpPower Enforced: " .. tostring(n or "Default"), 2)
end)

createToggle("Auto Jump Loop", "AutoJumpEnabled", settingsScroll)
createToggle("Anti-AFK (Jump & Drop)", "AntiAfk", settingsScroll)

createTextBox("Enter Roblox Animation ID", "", settingsScroll, function(val)
    Config.CustomAnimID = val
end)

createActionBtn("🎭 Execute Custom Anim Track", Color3.fromRGB(55, 25, 85), function()
    PlayCustomAnimation(Config.CustomAnimID)
end, settingsScroll)

createActionBtn("Load Stellar Hub ✅", Color3.fromRGB(200, 160, 0), function()
    loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/f7388eab91b827b35ecd1785c9261fb8c6249fa5d53780948ab1ffac8ab9c91b/download"))()
    CustomNotify("Stellar Hub Loaded!", 2.5)
end, scriptScroll)

createActionBtn("Fly Script 🔥", Color3.fromRGB(200, 160, 0), function()
    loadstring(game:HttpGet("https://pastebin.com/raw/xnMbBtbR"))()
    CustomNotify("Fly Loaded!", 2.5)
end, scriptScroll)

createActionBtn("Noclip Button 👾", Color3.fromRGB(200, 160, 0), function()
    loadstring(game:HttpGet("https://pastebin.com/raw/ha4AfHs4"))()
    CustomNotify("Noclip Loaded!", 2.5)
end, scriptScroll)

createActionBtn("lock screen 🔑", Color3.fromRGB(200, 160, 0), function()
    loadstring(game:HttpGet("https://files.catbox.moe/seiimp.txt"))()
    CustomNotify("lock screen Loaded!", 2.5)
end, scriptScroll)

createActionBtn("Semi-immortal (old)", Color3.fromRGB(200, 160, 0), function()
    loadstring(game:HttpGet("https://gist.githubusercontent.com/foreverspacexc-blip/acc9ec133bf516d8314c2fff10223750/raw/2776d49841376955e5b900bfb8437ea724b3a0f4/gistfile1.txt"))()
    CustomNotify("semi immortal but old Loaded!", 2.5)
end, scriptScroll)

createActionBtn("Hypol-X HD Fly Admin", Color3.fromRGB(200, 160, 0), function()
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

createActionBtn("💥 Warp to Nearest Player", Color3.fromRGB(70, 25, 25), function() executeWarp(targetDistanceSolver("Nearest")) end, settingsScroll)
createActionBtn("💥 Warp to Farthest Player", Color3.fromRGB(90, 30, 30), function() executeWarp(targetDistanceSolver("Farest")) end, settingsScroll)
createActionBtn("🚀 Tween to Nearest Player", Color3.fromRGB(25, 50, 75), function() executeTween(targetDistanceSolver("Nearest")) end, settingsScroll)
createActionBtn("🚀 Tween to Farthest Player", Color3.fromRGB(30, 60, 95), function() executeTween(targetDistanceSolver("Farest")) end, settingsScroll)

createActionBtn("🔄 Rejoin Server Instance", Color3.fromRGB(35, 85, 35), function() RejoinServer() end, settingsScroll)
createActionBtn("🌌 Server Hop Network Search", Color3.fromRGB(95, 70, 25), function() ServerHop() end, settingsScroll)

createCycle("UI Background Theme", "UIBackground", BackgroundColors, uiScroll)

-- ═══ IMAGE BACKGROUND ══════════════════════════════════════

createLabel("IMAGE BACKGROUND", uiScroll)

createTextBox(
    "Image ID",
    "",
    uiScroll,
    function(text)
        local id = tostring(text):match("%d+")

        if id then
            UIBackgroundImage.Image = "rbxassetid://" .. id
            UIBackgroundImage.Visible = true

            CustomNotify("🖼️ Background Image Updated!", 2)
        else
            UIBackgroundImage.Image = ""
            UIBackgroundImage.Visible = false

            CustomNotify("❌ Image ID", 2)
        end
    end
)

createTextBox(
    "Image Transparency 0 - 1",
    "0.15",
    uiScroll,
    function(text)
        local value = tonumber(text)

        if value then
            UIBackgroundImage.ImageTransparency = math.clamp(value, 0, 1)
        end
    end
)

createActionBtn(
    "🖼️ Hide Background Image",
    THEME.CardBg,
    function()
        UIBackgroundImage.Visible = false
    end,
    uiScroll
)

createActionBtn(
    "🔄 Reset Background",
    THEME.CardBg,
    function()
        BackgroundIndex = 1

        UIBackgroundImage.Visible = false
        UIBackgroundImage.Image = ""
        UIBackgroundImage.ImageTransparency = 0.15

        updateBackgroundCycle()

        CustomNotify("🔄 Background Reset!", 2)
    end,
    uiScroll
)

-- 🟢 🔁 ลูปอัปเดตค่าสถานะ Real-time ทุกเฟรมเรตหน้าจอ
task.spawn(function()
    while shared._InvisRunning do
        RunService.RenderStepped:Wait()
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
        -- 🔥 ปลดล็อก Fflag และดันเพดาน FPS เครื่องให้วิ่งสูงสุดเท่าที่ชิปจะไหว
        setfflag("S2PhysicsSenderRate", "1333335")
        pcall(function() setfpscap(999) end)
        
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
-- 🌪️ ANTI TORNADO WARP LURKER ENGINE (ONE-TIME HIT & IGNORE SAME INSTANCE)
-- =======================================================================
task.spawn(function()
    local lastTrackedTornado = nil -- ใช้สำหรับเก็บจำ Instance ทอร์นาโดที่เคยจัดการไปแล้ว

    while shared._InvisRunning do
        -- เช็คเฟรมเรตสม่ำเสมอด้วยเศษเสี้ยวเวลาที่สั้นที่สุด
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

                -- 🚨 เงื่อนไขหลัก: เจอพายุ + เล็งเรา + ต้องไม่ใช่ทอร์นาโดลูกเดิมที่เคยตีไปแล้ว
                if currentTornado and isTargetingMe and (currentTornado ~= lastTrackedTornado) then
                    
                    -- บันทึกทันทีว่าทอร์นาโดลูกนี้ถูกใช้งานไปแล้ว (เพื่อไม่ให้ลูปกลับมาทำซ้ำ)
                    lastTrackedTornado = currentTornado 

                    if type(CustomNotify) == "function" then
                        CustomNotify("🌪️ New Tornado Detected! Executing One-Time Counter.", 2)
                    end

                    -- 📌 ขั้นตอนที่ 1: เซฟพิกัดตำแหน่งดั้งเดิมก่อนวาร์ป
                    local savedCFrame = hrp.CFrame
                    local savedVelocity = hrp.AssemblyLinearVelocity

                    -- ตัดแรงเหวี่ยงฟิสิกส์ชั่วคราวเพื่อความแม่นยำในการล็อกพิกัด
                    hrp.AssemblyLinearVelocity = Vector3.zero

                    -- 📌 ขั้นตอนที่ 2: วาร์ปไปประชิดหน้าลูกบอลทันที 1 ครั้ง (เว้นระยะปลอดภัยด้านหน้า 3 สตัด)
                    local ballVel = ball.AssemblyLinearVelocity
                    local forwardDirection = ballVel.Magnitude > 1 and ballVel.Unit or Vector3.new(0, 0, 1)
                    
                    hrp.CFrame = CFrame.new(ball.Position + (forwardDirection * 3), ball.Position)
                    task.wait(0.02) -- หน่วงเสี้ยววินาทีให้ฟิสิกส์ตัวละครอัปเดตแกนเซิร์ฟเวอร์

                    -- สั่งยิงแพ็กเก็ตตีบอลสวนกลับทันที 1 ชุด (Bypass/Click)
                    if type(Auto_Parry) == "table" and type(Auto_Parry.FireParryRemote) == "function" then
                        pcall(Auto_Parry.FireParryRemote, false)
                    end

                    task.wait(0.03) -- รอจังหวะปุ่มทำงานเสร็จสมบูรณ์

                    -- 📌 ขั้นตอนที่ 3: ดึงตัวละครวาร์ปกลับมาจุดพิกัดเดิมที่เซฟไว้ทันที
                    if hrp and hrp.Parent then
                        hrp.CFrame = savedCFrame
                        hrp.AssemblyLinearVelocity = savedVelocity
                        
                        if type(CustomNotify) == "function" then
                            CustomNotify("✅ Hit Successful! Safely Returned.", 1.5)
                        end
                    end
                end
            end)
        else
            -- หากปิดสวิตช์ระบบ ให้ล้างค่าความจำพายุเก่าทิ้ง เพื่อสแตนด์บายรอเปิดครั้งต่อไป
            lastTrackedTornado = nil
            task.wait(0.1)
        end
    end
end)

-- =======================================================================
-- 📢 WHAT'S NEW & CHANGELOGS CONTENT CONTAINER (FIXED LAYOUT)
-- =======================================================================
-- [CRITICAL FIX]: ต้องสร้างระบบกรองตำแหน่งแนวตั้ง ไม่งั้นกล่องข่าวสารจะขี่ทับกันเอง
newsLayout = Instance.new("UIListLayout", whatsNewScroll)
newsLayout.Padding = UDim.new(0, 6)
newsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
newsLayout.SortOrder = Enum.SortOrder.LayoutOrder

createLabel("INVIS HUB - LATEST UPDATES", whatsNewScroll)

function createNewsCard(version, description, color)
    local card = Instance.new("Frame", whatsNewScroll)
    card.Size = UDim2.new(1, -4, 0, 50) -- บีบระยะไม่ให้เบียดขอบสโครล
    card.BackgroundColor3 = THEME.CardBg
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6)
    card.ZIndex = 3
    
    local stroke = Instance.new("UIStroke", card)
    stroke.Color = color or Color3.fromRGB(45, 45, 60)
    stroke.Thickness = 1

    local titleLbl = Instance.new("TextLabel", card)
    titleLbl.Size = UDim2.new(1, -16, 0, 20)
    titleLbl.Position = UDim2.new(0, 8, 0, 4)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = version
    titleLbl.TextColor3 = THEME.Accent
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextSize = 11
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 4

    local descLbl = Instance.new("TextLabel", card)
    descLbl.Size = UDim2.new(1, -16, 0, 22)
    descLbl.Position = UDim2.new(0, 8, 0, 22)
    descLbl.BackgroundTransparency = 1
    descLbl.Text = description
    descLbl.TextColor3 = THEME.TextMain
    descLbl.Font = Enum.Font.GothamSemibold
    descLbl.TextSize = 10
    descLbl.TextXAlignment = Enum.TextXAlignment.Left
    descLbl.TextWrapped = true
    descLbl.ZIndex = 4
end

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
local function ApplyBallTrail(ball)
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
-- 👻 INVISIBLE BALL OVERDRIVE SYSTEM (SIZE 0.001 MECHANICS)
-- =======================================================================

-- 1. เพิ่มค่า Config เริ่มต้นเข้าในตารางระบบหลัก
Config.InvisibleBallEnabled = false

-- คลังสำหรับจดจำขนาดดั้งเดิมของลูกบอลแต่ละลูก เพื่อคืนค่าตอนปิดระบบ
local OriginalBallSizes = {}

-- 🔁 ลูปหลักอัปเดตสถานะความล่องหนของลูกบอลแบบ Real-time ร่วมกับเฟรมเรตเกม
task.spawn(function()
    while shared._InvisRunning do
        game:GetService("RunService").RenderStepped:Wait()
        
        local allBalls = {}
        if type(Auto_Parry) == "table" and type(Auto_Parry.Get_Balls) == "function" then
            allBalls = Auto_Parry.Get_Balls()
        end

        for _, ball in ipairs(allBalls) do
            if ball and ball.Parent then
                
                if Config.InvisibleBallEnabled then
                    -- 👻 [ช่วงเปิดใช้งาน: ย่อลูกบอลให้เล็กลงจนมองไม่เห็น]
                    if not OriginalBallSizes[ball] then
                        -- จดจำขนาดเดิมไว้ก่อนปรับ เพื่อไม่ให้ข้อมูลหาย
                        OriginalBallSizes[ball] = ball.Size
                    end
                    
                    -- บังคับปรับขนาดให้เหลือ 0.001 ทุกแกน และเปิดความโปร่งแสงสูงสุด
                    ball.Size = Vector3.new(0.001, 0.001, 0.001)
                    ball.Transparency = 1
                    
                    -- ปิดเอฟเฟกต์แสงหรือเงาเดิมของตัวเกมที่อาจจะติดมากับลูกบอล
                    if ball:FindFirstChildOfClass("SelectionBox") then
                        ball:FindFirstChildOfClass("SelectionBox").Visible = false
                    end
                else
                    -- 🔄 [ช่วงปิดใช้งาน: คืนค่าขนาดเดิมของลูกบอลกลับมาปกติ]
                    if OriginalBallSizes[ball] then
                        ball.Size = OriginalBallSizes[ball]
                        -- คืนค่าความโปร่งแสงปกติ (หากคุณเปิดระบบ Rainbow Ball ค้างไว้ ระบบสีรุ้งจะเข้ามาควบคุมเรื่องสีและวัสดุต่อทันที)
                        ball.Transparency = 0 
                        OriginalBallSizes[ball] = nil
                    end
                end

            end
        end
    end
end)

-- 🖼️ 2. สร้างปุ่มเปิด/ปิด (Toggle) บรรจุเข้าหน้า Visuals Tab ของคุณ
createToggle("👻 Invisible Ball", "InvisibleBallEnabled", visualScroll)

-- ล้างหน่วยความจำขนาดลูกบอลที่บันทึกไว้เมื่อผู้เล่นจบการแข่งขันหรือลูกบอลถูกทำลาย
pcall(function()
    local mainFolder = workspace:FindFirstChild("Balls") or workspace:FindFirstChild("TrainingBalls")
    if mainFolder then
        mainFolder.DescendantRemoving:Connect(function(oldObj)
            if OriginalBallSizes[oldObj] then
                OriginalBallSizes[oldObj] = nil
            end
        end)
    end
end)

-- จัดการระบายคลังเมื่อมีลูกบอลเกิดใหม่ในสนามระหว่างเล่น
pcall(function()
    local mainFolder = workspace:FindFirstChild("Balls") or workspace:FindFirstChild("TrainingBalls")
    if mainFolder then
        mainFolder.DescendantAdded:Connect(function(newObj)
            task.wait(0.05) -- หน่วงเวลาเล็กน้อยรอให้ Instance พร้อมใช้งาน
            if Config.BallTrailEnabled and newObj:IsA("BasePart") then
                ApplyBallTrail(newObj)
            end
        end)
    end
end)

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

local charOrbitAngle = 0

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

-- =======================================================================
-- ❄️ CLIENT-SIDE CHARACTER FREEZE SYSTEM (COMBAT TAB CONTROLLERS)
-- =======================================================================

-- 1. เพิ่มค่าการตั้งค่าเริ่มต้นเข้าในตาราง Config หลัก
Config.FreezeSelfEnabled = false
Config.FreezeAllClientEnabled = false

-- 🔁 ลูปควบคุมการแช่แข็งตัวละครของเราเอง (Freeze Self)
task.spawn(function()
    while shared._InvisRunning do
        game:GetService("RunService").RenderStepped:Wait()
        
        pcall(function()
            local char = game.Players.LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            
            if hrp and hum and hum.Health > 0 then
                if Config.FreezeSelfEnabled then
                    -- ❄️ ทำการล็อกตำแหน่งฟิสิกส์ตัวละครให้อยู่กับที่
                    if not hrp.Anchored then
                        hrp.Anchored = true
                    end
                    -- สั่งตัดแรงเหวี่ยงเคลื่อนที่สะสม ป้องกันตัวละครกระตุกหลุด
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    hrp.AssemblyAngularVelocity = Vector3.zero
                else
                    -- 🔓 ปลดล็อกแช่แข็ง คืนค่าฟิสิกส์ให้ขยับได้ปกติ
                    if hrp.Anchored then
                        hrp.Anchored = false
                    end
                end
            end
        end)
    end
end)

-- 🔁 ลูปควบคุมการแช่แข็งผู้เล่นคนอื่นทุกคนบนหน้าจอของเรา (Freeze All Client-Side)
task.spawn(function()
    while shared._InvisRunning do
        game:GetService("RunService").RenderStepped:Wait()
        
        pcall(function()
            local aliveFolder = workspace:FindFirstChild("Alive")
            if not aliveFolder then return end
            
            for _, playerChar in ipairs(aliveFolder:GetChildren()) do
                if playerChar:IsA("Model") and playerChar.Name ~= game.Players.LocalPlayer.Name then
                    local targetHrp = playerChar:FindFirstChild("HumanoidRootPart")
                    
                    if targetHrp then
                        if Config.FreezeAllClientEnabled then
                            -- ❄️ สั่งแช่แข็งตัวละครผู้เล่นคนอื่นบนหน้าจอฝั่งเรา (ไม่มีผลต่อเซิร์ฟเวอร์จริง)
                            if not targetHrp.Anchored then
                                targetHrp.Anchored = true
                            end
                            targetHrp.AssemblyLinearVelocity = Vector3.zero
                        else
                            -- 🔓 ปลดล็อกแช่แข็งผู้เล่นทุกคนให้กลับมาเคลื่อนที่ปกติ
                            if targetHrp.Anchored then
                                targetHrp.Anchored = false
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- 🖼️ 2. สร้างปุ่มเปิด/ปิด (Toggle) บรรจุเข้าหน้า Combat Tab ของคุณ
createLabel("CLIENT FREEZE", combatScroll)
createToggle("❄️ Freeze My Character", "FreezeSelfEnabled", combatScroll)
createToggle("🥶 Freeze All Players (Client)", "FreezeAllClientEnabled", combatScroll)

-- 🧼 ระบบล้างสเตทความปลอดภัย: ปลดล็อกแช่แข็งอัตโนมัติเมื่อผู้เล่นปิดสคริปต์หลัก
pcall(function()
    game.Players.LocalPlayer.CharacterRemoving:Connect(function()
        Config.FreezeSelfEnabled = false
        Config.FreezeAllClientEnabled = false
    end)
end)

-- =======================================================================
-- 📍 TELEPORT & SMART PATHFINDER TRACKER ENGINE (SETTINGS CONTROLLERS)
-- =======================================================================
createLabel("other", combatScroll)

-- 1. เพิ่มค่าการตั้งค่าเริ่มต้นเข้าในตาราง Config หลัก
Config.ClickToTpEnabled = false
Config.WalkToPlayerEnabled = false
Config.TargetPlayerShortName = ""

-- ⚡ [ระบบที่ 1]: Click to Teleport (คลิกเมาส์/แตะจอเพื่อวาร์ปไปจุดที่ต้องการ)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if not Config.ClickToTpEnabled then return end
    
    -- ทำงานเมื่อกดคลิกเมาส์ซ้าย (PC) หรือแตะหน้าจอ (Mobile)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        pcall(function()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            
            -- ดึงพิกัดตำแหน่งที่เมาส์หรือนิ้วชี้ไปในโลก 3 มิติ
            local mouse = LocalPlayer:GetMouse()
            local targetPos = mouse.Hit.Position
            
            -- วาร์ปตัวละครหลักไปยังพิกัดนั้น โดยยกแกน Y ขึ้นเล็กน้อยเพื่อป้องกันการติดพื้นดิน
            hrp.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
            
            if type(CustomNotify) == "function" then
                CustomNotify("📍 Teleported to Clicked Location!", 1.5)
            end
        end)
    end
end)

-- 🏃‍♂️ [ระบบที่ 2]: Walk to Player (ระบุชื่อย่อแล้วบอทจะเดินตามผู้เล่นคนนั้น)
-- ฟังก์ชันช่วยค้นหาผู้เล่นด้วย "ชื่อย่อ" (พิมพ์พิมพ์ตัวเล็ก-ใหญ่ได้หมด และค้นหาผู้เล่นที่รอดชีวิตอยู่เท่านั้น)
local function FindAlivePlayerByShortName(shortName)
    if shortName == "" then return nil end
    local aliveFolder = workspace:FindFirstChild("Alive")
    if not aliveFolder then return nil end
    
    local matchedPlayers = {}
    
    for _, charModel in ipairs(aliveFolder:GetChildren()) do
        if charModel:IsA("Model") and charModel.Name ~= LocalPlayer.Name then
            -- ค้นหาทั้งจากชื่อจริง (Name) และชื่อที่แสดง (DisplayName) เพื่อความแม่นยำ
            local lowerName = string.lower(charModel.Name)
            local lowerDisplay = string.lower(charModel.DisplayName or "")
            local searchStr = string.lower(shortName)
            
            if string.find(lowerName, searchStr) or string.find(lowerDisplay, searchStr) then
                table.insert(matchedPlayers, charModel)
            end
        end
    end
    
    -- ข้อกำหนด: คืนค่ากลับมาเฉพาะเมื่อค้นเจอผู้เล่นที่ตรงเงื่อนไข "เพียงคนเดียวเท่านั้น" เพื่อป้องกันการเดินสลับไปมา
    if #matchedPlayers == 1 then
        return matchedPlayers[1]
    end
    
    return nil
end

-- ลูปเฝ้าสั่งการเคลื่อนที่ (MoveTo) วิ่งตามเป้าหมายแบบ Real-time
task.spawn(function()
    while shared._InvisRunning do
        task.wait(0.1) -- อัปเดตความถี่ทุกๆ 0.1 วินาทีเพื่อความเสถียรและประหยัด CPU
        
        if Config.WalkToPlayerEnabled then
            pcall(function()
                local char = LocalPlayer.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                
                if not hum or hum.Health <= 0 or not hrp then return end
                
                -- ค้นหาเป้าหมายจากชื่อย่อปัจจุบันที่กรอกไว้ใน Config
                local targetChar = FindAlivePlayerByShortName(Config.TargetPlayerShortName)
                
                if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
                    local targetHrp = targetChar.HumanoidRootPart
                    -- สั่งให้ตัวละครของเราเดินมุ่งตรงไปยังพิกัดของผู้เล่นเป้าหมายโดยอัตโนมัติ
                    hum:MoveTo(targetHrp.Position)
                else
                    -- หากไม่พบเป้าหมาย หรือมีคนชื่อซ้ำกันหลายคน สั่งให้หยุดเดินเพื่อความปลอดภัย
                    hum:Move(Vector3.zero)
                end
            end)
        end
    end
end)

-- =======================================================================
-- 🖼️ UI INTERFACE CONTROLLERS (SETTINGS TAB UTILITIES)
-- =======================================================================
createLabel("ADVANCED LOCOMOTION CONTROLS", settingsScroll)

-- 🔘 ปุ่มเปิด/ปิด ระบบ Click to Teleport
createToggle("📌 Click To Teleport", "ClickToTpEnabled", settingsScroll)

-- ⌨️ ช่องกรอกชื่อผู้เล่นแบบย่อ (Short Name Input)
createTextBox("Type Target Name (Short)", tostring(Config.TargetPlayerShortName), settingsScroll, function(val)
    Config.TargetPlayerShortName = val
    
    -- ทำการสแกนเช็คชื่อเบื้องต้นเพื่อแจ้งสถานะให้ผู้ใช้งานทราบทันที
    local target = FindAlivePlayerByShortName(val)
    if type(CustomNotify) == "function" then
        if target then
            CustomNotify("🎯 Target Verified: " .. target.Name, 2.5)
        elseif val ~= "" then
            CustomNotify("⚠️ Target not found or too many matches!", 2.5)
        end
    end
end)

-- 🔘 ปุ่มเปิด/ปิด ระบบเดินตามผู้เล่น (Walking to Player)
createToggle("🏃‍♂️ Auto Walk To Selected Player", "WalkToPlayerEnabled", settingsScroll)
-- =======================================================================
-- 🦘 INFINITE JUMP CONTROLLER OPERATIONAL SYSTEM (COMBAT TAB)
-- =======================================================================

-- 1. เพิ่มค่าการตั้งค่าเริ่มต้นเข้าในตาราง Config หลัก
Config.InfiniteJumpEnabled = false

-- ผูกสัญญาณตรวจจับความต้องการกดกระโดดของผู้เล่น (Jump Request)
UserInputService.JumpRequest:Connect(function()
    -- ตรวจสอบว่าระบบเปิดใช้งานอยู่ และสคริปต์หลักยังรันอยู่หรือไม่
    if Config.InfiniteJumpEnabled and shared._InvisRunning then
        pcall(function()
            local char = game.Players.LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            
            -- บังคับเปลี่ยนสถานะของ Humanoid ให้ทำการกระโดดทันที แม้จะลอยอยู่กลางอากาศ
            if hum and hum.Health > 0 then
                -- สั่งเปิดระบบฟิสิกส์เตรียมกระโดด และบังคับเปลี่ยนสเตทเป็น Jumping
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end)

createToggle("🦘 Infinite Jump Overdrive", "InfiniteJumpEnabled", combatScroll)
-- =======================================================================
-- 🎯 TRIGGER BOT OPERATIONAL ENGINE (CAMERA CROSSHAIR BASED PARRY)
-- =======================================================================

-- 1. เพิ่มค่าการตั้งค่าเริ่มต้นเข้าในตาราง Config หลัก
Config.TriggerBotEnabled = false
Config.TriggerBotDistance = Config.TriggerBotDistance or 45 -- ระยะห่างสูงสุดที่จะให้บอทเริ่มทำงาน
Config.TriggerBotDelay = Config.TriggerBotDelay or 0       -- ดีเลย์หน่วงเวลาก่อนกดตี (วินาที)

-- =======================================================================
-- 🐯 TIGER TRIGGER BOT OPERATIONAL ENGINE (DASH & LEAP INTERCEPTOR)
-- =======================================================================

-- 1. เพิ่มค่าการตั้งค่าเริ่มต้นเข้าในตาราง Config หลัก
Config.TriggerBotEnabled = false
Config.TriggerBotDistance = Config.TriggerBotDistance or 45 -- ระยะกระโจนสูงสุดของเสือ
Config.TriggerBotDelay = Config.TriggerBotDelay or 0       

local lastTigerHitTick = 0
local isTigerDashing = false -- ตัวแปรเช็คสถานะการพุ่งเพื่อป้องกันลูปซ้อน

task.spawn(function()
    while shared._InvisRunning do
        game:GetService("RunService").RenderStepped:Wait()
        
        if Config.TriggerBotEnabled then
            pcall(function()
                local cam = workspace.CurrentCamera
                if not cam then return end
                
                local ball = nil
                if type(Auto_Parry) == "table" and type(Auto_Parry.Get_Ball) == "function" then
                    ball = Auto_Parry.Get_Ball()
                end
                
                if ball and ball.Parent and not isTigerDashing then
                    local char = game.Players.LocalPlayer.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if not hrp then return end
                    
                    -- 📐 1. ตรวจสอบระยะทางที่เสือจะกระโจนใส่เหยื่อ
                    local currentDistance = (hrp.Position - ball.Position).Magnitude
                    if currentDistance > Config.TriggerBotDistance then return end
                    
                    -- ?? 2. ตรวจสอบมุมกล้อง (จ้องมองเหยื่อ)
                    local dirToBall = (ball.Position - cam.CFrame.Position).Unit
                    local camDirection = cam.CFrame.LookVector
                    local dotProduct = camDirection:Dot(dirToBall)
                    
                    -- ปรับเป้าเล็งดักจับให้กว้างและเสถียร (0.94)
                    if dotProduct >= 0.94 then
                        
                        -- 📐 3. ตรวจสอบสถานะเป้าหมายบอล
                        local targetAttr = ball:GetAttribute("target") or ball:GetAttribute("Target")
                        local isTargetingMe = (tostring(targetAttr or "") == game.Players.LocalPlayer.Name) or (char and tostring(targetAttr or "") == char.Name)
                        
                        local now = os.clock()
                        if isTargetingMe and (now - lastTigerHitTick >= 0.4) then
                            
                            -- เปิดฉากการจู่โจมแบบเสือ (Tiger Leap)
                            isTigerDashing = true
                            lastTigerHitTick = now
                            
                            if parryLocked then parryLocked[ball] = true end
                            if lockTime then lockTime[ball] = now end
                            
                            task.spawn(function()
                                if Config.TriggerBotDelay > 0 then
                                    task.wait(Config.TriggerBotDelay)
                                end
                                
                                -- 📌 [TIGER DASH]: บันทึกตำแหน่งจุดยืนเดิมไว้
                                local savedCFrame = hrp.CFrame
                                local savedVelocity = hrp.AssemblyLinearVelocity

                                -- 📌 [TIGER STRIKE]: สั่งตะปบ/ยิงรีโมทตีบอลสวนกลับทันที
                                if type(Auto_Parry) == "table" and type(Auto_Parry.FireParryRemote) == "function" then
                                    Auto_Parry.FireParryRemote(false)
                                    
                                    if type(shared.InvisClearLock) == "function" then
                                        shared.InvisClearLock(ball)
                                    end
                                end
                                
                                -- ล้างแรงเหวี่ยงฟิสิกส์เก่าออก
                                hrp.AssemblyLinearVelocity = Vector3.zero
                                
                                -- คำนวณทิศทางเพื่อวาร์ปพุ่งไปดักหน้าลูกบอล (เว้นระยะประชิด 3.5 สตัด)
                                local ballVel = ball.AssemblyLinearVelocity
                                local forwardDirection = ballVel.Magnitude > 1 and ballVel.Unit or Vector3.new(0, 0, 1)
                                
                                -- ตัวละครพุ่งกระโจนไปหน้าบอลทันที
                                hrp.CFrame = CFrame.new(ball.Position + (forwardDirection * 3.5), ball.Position)
                                task.wait(0.45) -- หน่วงเวลาเสี้ยวเฟรมให้รีโมทซิงค์กับพิกัดใหม่                              
                                
                                -- 📌 [TIGER RETURN]: ถอยฉากกลับมาที่จุดยืนเดิมอย่างรวดเร็ว
                                if hrp and hrp.Parent then
                                    hrp.CFrame = savedCFrame
                                    hrp.AssemblyLinearVelocity = savedVelocity
                                end
                                
                                isTigerDashing = false
                            end)
                        end
                        
                    end
                end
            end)
        else
            isTigerDashing = false
            task.wait(0.1) 
        end
    end
end)

-- =======================================================================
-- 🖼️ UI INTERFACE CONTROLLERS (COMBAT MENU ADD-ONS)
-- =======================================================================

-- ปุ่มสวิตช์เปิด/ปิด หลัก
createToggle("🎯 Trigger Bot", "TriggerBotEnabled", combatScroll)

-- TextBox สำหรับปรับระยะระยะห่างในการดักจับตี (Trigger Distance)
createTextBox("Trigger Distance Range", tostring(Config.TriggerBotDistance), combatScroll, function(val)
    local n = tonumber(val)
    if n and n >= 5 then
        Config.TriggerBotDistance = math.clamp(n, 5, 100) -- จำกัดระยะไม่ให้พิมพ์กว้างจนบั๊ก
        if type(CustomNotify) == "function" then 
            CustomNotify("🎯 Trigger Bot Range set to: " .. tostring(Config.TriggerBotDistance) .. " Studs", 2) 
        end
    else
        if type(CustomNotify) == "function" then CustomNotify("❌ Enter a valid range number!", 2) end
    end
end)

-- TextBox สำหรับปรับดีเลย์หน่วงเวลาเสี้ยววินาที (Humanize Delay)
createTextBox("Trigger Hit Delay (Seconds)", tostring(Config.TriggerBotDelay), combatScroll, function(val)
    local n = tonumber(val)
    if n and n >= 0 then
        Config.TriggerBotDelay = math.clamp(n, 0, 1.5) -- หน่วงได้สูงสุด 1.5 วินาที
        if type(CustomNotify) == "function" then 
            CustomNotify("⏱️ Trigger Bot Delay set to: " .. tostring(Config.TriggerBotDelay) .. "s", 2) 
        end
    else
        if type(CustomNotify) == "function" then CustomNotify("❌ Enter a valid delay number!", 2) end
    end
end)

-- =======================================================================
-- 🚀 NEW HIGH-SPEED MANUAL SPAM (POST-SIMULATION ENGINE) VIA CREATETOGGLE
-- =======================================================================
local RunService = game:GetService("RunService")

-- =======================================================================
-- 🚀 POST-SIMULATION FLOATING BUTTON SPAM ENGINE (INVIS STYLE)
-- =======================================================================
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- 📦 1. กำหนดค่าเริ่มต้นในตาราง Config หลัก
Config.PostSimSpamShow = false    -- ใช้คุมการเปิด/ปิดแสดงปุ่มลอยจากเมนูหลัก
Config.PostSimSpamActive = false  -- สเตทเปิด/ปิดระบบสแปมจริงจากการกดปุ่มลอย
Config.PostSimCooldown = 0.003    -- ความเร็วการส่งแพ็กเก็ต (0.003 - 0.005)
local lastPostSimSentTime = 0

-- 🔘 2. สร้างปุ่มวงกลมลอยสำหรับควบคุม (Floating PostSim Button)
local FloatingPostSimBtn = Instance.new("TextButton", ScreenGui)
FloatingPostSimBtn.Size = UDim2.new(0, 55, 0, 55)
FloatingPostSimBtn.Position = UDim2.new(0.82, 0, 0.38, 0) -- ขยับพิกัดไม่ให้ทับปุ่มเดิม
FloatingPostSimBtn.BackgroundColor3 = THEME.Sidebar
FloatingPostSimBtn.Text = "PS-SPAM\nOFF"
FloatingPostSimBtn.TextColor3 = THEME.Inactive
FloatingPostSimBtn.Font = Enum.Font.GothamBold
FloatingPostSimBtn.TextSize = 9
FloatingPostSimBtn.Visible = false -- เริ่มต้นซ่อนไว้
Instance.new("UICorner", FloatingPostSimBtn).CornerRadius = UDim.new(1, 0)

local psFsStroke = Instance.new("UIStroke", FloatingPostSimBtn)
psFsStroke.Color = THEME.Inactive
psFsStroke.Thickness = 2

-- 🎨 3. ฟังก์ชันอัปเดตสถานะสีและข้อความของปุ่มลอย
local function updatePostSimFloatingVisual()
    if Config.PostSimSpamActive then
        FloatingPostSimBtn.Text = "PS-SPAM\nON"
        FloatingPostSimBtn.TextColor3 = Color3.fromRGB(0, 220, 255) -- นีออนฟ้า Cyan สำหรับโหมดความเร็วสูง
        psFsStroke.Color = Color3.fromRGB(0, 220, 255)
        FloatingPostSimBtn.BackgroundColor3 = Color3.fromRGB(15, 30, 40)
    else
        FloatingPostSimBtn.Text = "PS-SPAM\nOFF"
        FloatingPostSimBtn.TextColor3 = THEME.Inactive
        psFsStroke.Color = THEME.Inactive
        FloatingPostSimBtn.BackgroundColor3 = THEME.Sidebar
    end
end

-- 📌 4. ระบบลากปุ่มวงกลมแบบแยกแยะคลิกกับการลาก (Drag Logic ตามแบบแผนเดิม)
local psFsDrag, psFsStart, psFsPos, psFsMouseStart
local psFsIsDragging = false

FloatingPostSimBtn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        psFsDrag = true
        psFsStart = i.Position
        psFsMouseStart = UserInputService:GetMouseLocation()
        psFsPos = FloatingPostSimBtn.Position
        psFsIsDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if psFsDrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        if (UserInputService:GetMouseLocation() - psFsMouseStart).Magnitude > 5 then
            psFsIsDragging = true
        end
        if psFsIsDragging then
            local d = i.Position - psFsStart
            local cam = workspace.CurrentCamera
            local targetX = psFsPos.X.Offset + d.X
            local targetY = psFsPos.Y.Offset + d.Y
            if cam then
                targetX = math.clamp(targetX, 0, cam.ViewportSize.X - FloatingPostSimBtn.Size.X.Offset)
                targetY = math.clamp(targetY, 0, cam.ViewportSize.Y - FloatingPostSimBtn.Size.Y.Offset)
            end
            FloatingPostSimBtn.Position = UDim2.new(psFsPos.X.Scale, targetX, psFsPos.Y.Scale, targetY)
        end
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        psFsDrag = false
    end
end)

-- คลิกเพื่อเปิด/ปิดระบบทำงาน
FloatingPostSimBtn.MouseButton1Click:Connect(function()
    if psFsIsDragging then return end
    Config.PostSimSpamActive = not Config.PostSimSpamActive
    updatePostSimFloatingVisual()
    if type(CustomNotify) == "function" then
        CustomNotify("PostSim Overdrive: " .. (Config.PostSimSpamActive and "ON" or "OFF"), 1.5)
    end
end)

-- 🚀 5. ระบบวนลูปประมวลผลความเร็วสูงระดับเฟรมเรตเกม (No Lag PostSimulation Engine)
RunService.PostSimulation:Connect(function()
    if not Config.PostSimSpamActive or not Config.PostSimSpamShow then return end
    
    local currentTime = os.clock()
    local targetSpeed = math.max(0.003, tonumber(Config.PostSimCooldown) or 0.003)
    
    if (currentTime - lastPostSimSentTime) >= targetSpeed then
        lastPostSimSentTime = currentTime
        
        -- ดักจับและยิงแพ็กเก็ตผ่านฟังก์ชันรีโมทหลักโดยตรง ไร้การสร้าง Coroutine ทับถมกัน
        if type(Auto_Parry) == "table" and type(Auto_Parry.FireParryRemote) == "function" then
            pcall(function()
                Auto_Parry.FireParryRemote(true) -- ส่งอาร์กิวเมนต์ True เป็นโหมดสแปมปะทะ
            end)
        end
    end
end)

-- 🖼️ 6. สร้างสวิตช์ Toggle เข้าไปในหน้าต่างเมนูหลัก (Combat Tab)
createToggle("Manual Spam (for weak phone)", "PostSimSpamShow", combatScroll)

-- ลูปคอยตรวจสเตทสวิตช์หลักเพื่อสั่ง ซ่อน/แสดง ปุ่มลอยตัวบนจอโดยอัตโนมัติ
task.spawn(function()
    local lastShowState = false
    while shared._InvisRunning do
        if Config.PostSimSpamShow ~= lastShowState then
            lastShowState = Config.PostSimSpamShow
            if Config.PostSimSpamShow then
                FloatingPostSimBtn.Visible = true
            else
                FloatingPostSimBtn.Visible = false
                Config.PostSimSpamActive = false
                updatePostSimFloatingVisual()
            end
        end
        task.wait(0.1)
    end
end)
-- =======================================================================

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

-- 🖼️ 5. สร้างการจัดวางหน้าตาปุ่มบนเมนู (UI Layout Elements)
createLabel("ABILITY BYPASS LISTENER", abilityDetScroll)

createToggle("🔮 Detect Infinity Intercept", "Infinity_Enabled", abilityDetScroll)
t1 = abilityDetScroll:GetChildren()[#abilityDetScroll:GetChildren()]
if t1 and t1:IsA("Frame") then t1:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function() Det_State.Infinity_Enabled = Config.Infinity_Enabled end) end

createToggle("💀 Detect Death Slash Block", "DeathSlash_Enabled", abilityDetScroll)
t2 = abilityDetScroll:GetChildren()[#abilityDetScroll:GetChildren()]
if t2 and t2:IsA("Frame") then t2:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function() Det_State.DeathSlash_Enabled = Config.DeathSlash_Enabled end) end

createToggle("🕳️ Detect Time Hole Anti-Freeze", "TimeHole_Enabled", abilityDetScroll)
t3 = abilityDetScroll:GetChildren()[#abilityDetScroll:GetChildren()]
if t3 and t3:IsA("Frame") then t3:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function() Det_State.TimeHole_Enabled = Config.TimeHole_Enabled end) end

createToggle("🧲 Detect Telekinesis Pull Lock", "Pull_Enabled", abilityDetScroll)
t4 = abilityDetScroll:GetChildren()[#abilityDetScroll:GetChildren()]
if t4 and t4:IsA("Frame") then t4:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function() Det_State.Pull_Enabled = Config.Pull_Enabled end) end

createToggle("⚔️ Detect Slashes of Fury Loop", "Slashes_Enabled", abilityDetScroll)
t5 = abilityDetScroll:GetChildren()[#abilityDetScroll:GetChildren()]
if t5 and t5:IsA("Frame") then t5:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function() Det_State.Slashes_Enabled = Config.Slashes_Enabled end) end

createToggle("🛡️ Detect Forcefield Anti-Spam", "Forcefield_Enabled", abilityDetScroll)
t6 = abilityDetScroll:GetChildren()[#abilityDetScroll:GetChildren()]
if t6 and t6:IsA("Frame") then t6:FindFirstChildOfClass("TextButton").MouseButton1Click:Connect(function() Det_State.Forcefield_Enabled = Config.Forcefield_Enabled end) end

createLabel("ENJOY PREVENTING SKILL TRAPS", abilityDetScroll)
-- =======================================================================

-- =======================================================================
-- 📊🏆 FORCE SHOW STATS / LEADERBOARD HACK SUITE (NEW TAB)
-- =======================================================================
Players = game:GetService("Players")
RunService = game:GetService("RunService")
CoreGui = game:GetService("CoreGui")

Config.ForceShowStats = false
leaderboardHackConn = nil
originalStatsCache = {}
watchedEntriesList = {}

-- ฟังก์ชันช่วยแปลงหน่วยตัวเลขให้มีคอมม่าคั่นสไตล์พรีเมียม (เช่น 1,000)
function FormatNumericStats(value)
    if type(value) ~= "number" then return tostring(value) end
    s = tostring(math.floor(value))
    return s:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
end

-- 📡 1. แกนคำนวณเขียนทับระนาบข้อมูล (Data Overlay Injector)
function ApplyStatPatchToEntry(entry, winsLabel, elimsLabel, targetPlayer)
    if not entry or not targetPlayer then return end
    
    -- ดึงค่าจริงตรงจาก Server Attribute ของผู้เล่น
    actualWins = targetPlayer:GetAttribute("PlayerWins") or 0
    actualElims = targetPlayer:GetAttribute("PlayerElims") or 0
    
    if winsLabel then winsLabel.Text = FormatNumericStats(actualWins) end
    if elimsLabel then elimsLabel.Text = FormatNumericStats(actualElims) end
end

-- 🛠️ 2. ฟังก์ชันจับตาตารางคะแนนมาตรฐานของ Roblox (Roblox Leaderboard Patcher)
function PatchPlayerListEntry(entry)
    if not entry or not entry.Name:find("PlayerEntry_") then return end
    userId = tonumber(entry.Name:match("PlayerEntry_(%d+)"))
    if not userId then return end
    
    targetPlayer = nil
    for _, p in ipairs(Players:GetPlayers()) do
        if p.UserId == userId then targetPlayer = p break end
    end
    if not targetPlayer then return end
    
    contentFrame = entry:FindFirstChild("PlayerEntryContentFrame")
    overlayFrame = contentFrame and contentFrame:FindFirstChild("OverlayFrame")
    if not overlayFrame then return end
    
    winsLabel = overlayFrame:FindFirstChild("GameStat_Wins") and overlayFrame.GameStat_Wins:FindFirstChild("PlayerStatDisplay")
    elimsLabel = overlayFrame:FindFirstChild("GameStat_Elims") and overlayFrame.GameStat_Elims:FindFirstChild("PlayerStatDisplay")
    
    -- เซฟค่าเดิมเก็บเข้า Cache เผื่อจังหวะผู้เล่นปิดฟังก์ชัน
    if not originalStatsCache[entry] then
        originalStatsCache[entry] = {
            wins = winsLabel and winsLabel.Text or "0",
            elims = elimsLabel and elimsLabel.Text or "0"
        }
    end
    
    -- ทำการบังคับเขียนทับข้อมูลจริงลงบนตารางทันที
    ApplyStatPatchToEntry(entry, winsLabel, elimsLabel, targetPlayer)
    
    -- วิ่งลูปตรวจสอบการเปลี่ยนแปลงแบบ Real-time กรณีเป้าหมายทำคะแนนเพิ่มขึ้นระหว่างเกม
    if watchedEntriesList[entry] then return end
    listeners = {}
    watchedEntriesList[entry] = listeners
    
    isUpdating = false
    function triggerRefresh()
        if isUpdating then return end
        isUpdating = true
        task.defer(function()
            isUpdating = false
            if not watchedEntriesList[entry] then return end
            ApplyStatPatchToEntry(entry, winsLabel, elimsLabel, targetPlayer)
        end)
    end
    
    if winsLabel then table.insert(listeners, winsLabel:GetPropertyChangedSignal("Text"):Connect(triggerRefresh)) end
    if elimsLabel then table.insert(listeners, elimsLabel:GetPropertyChangedSignal("Text"):Connect(triggerRefresh)) end
    table.insert(listeners, targetPlayer:GetAttributeChangedSignal("PlayerWins"):Connect(triggerRefresh))
    table.insert(listeners, targetPlayer:GetAttributeChangedSignal("PlayerElims"):Connect(triggerRefresh))
end

-- 🧼 3. ฟังก์ชันคืนค่าตารางปกติ (Data Restorer)
function RestoreOriginalLeaderboard()
    for entry, cache in pairs(originalStatsCache) do
        pcall(function()
            content = entry:FindFirstChild("PlayerEntryContentFrame")
            overlay = content and content:FindFirstChild("OverlayFrame")
            if overlay then
                w = overlay:FindFirstChild("GameStat_Wins") and overlay.GameStat_Wins:FindFirstChild("PlayerStatDisplay")
                e = overlay:FindFirstChild("GameStat_Elims") and overlay.GameStat_Elims:FindFirstChild("PlayerStatDisplay")
                if w and cache.wins then w.Text = cache.wins end
                if e and cache.elims then e.Text = cache.elims end
            end
        end)
    end
    for _, listeners in pairs(watchedEntriesList) do
        for _, connection in ipairs(listeners) do pcall(function() connection:Disconnect() end) end
    end
    table.clear(watchedEntriesList)
    table.clear(originalStatsCache)
end

-- 🚀 4. ระบบเปิดใช้งานลูปดักจับบอร์ด (Pipeline Core Lifecycle)
function StartLeaderboardHack()
    RestoreOriginalLeaderboard()
    
    task.spawn(function()
        robloxGui = CoreGui:WaitForChild("RobloxGui", 10)
        playerList = robloxGui and robloxGui:WaitForChild("PlayerList", 10)
        if not playerList then return end
        
        -- เคาะหาจุดโฟลเดอร์เก็บวัตถุตารางคะแนนของระบบ Roblox UI
        local ok, scrollingFrame = pcall(function()
            return playerList.Children.OffsetFrame.PlayerScrollList.SizeOffsetFrame.ScrollingFrameContainer.ScrollingFrameClippingFrame.ScrollingFrame
        end)
        if not ok or not scrollingFrame then return end
        
        function scanAndHookUndoFrame(undoFrame)
            if not undoFrame then return end
            for _, teamlist in ipairs(undoFrame:GetChildren()) do
                if teamlist.Name:find("TeamList_") then
                    for _, entry in ipairs(teamlist:GetChildren()) do
                        if entry.Name:find("PlayerEntry_") then
                            task.defer(PatchPlayerListEntry, entry)
                        end
                    end
                    -- ดักจับกรณีมีผู้เล่นใหม่จอยเซิร์ฟเวอร์เข้ามากลางคัน
                    local c = teamlist.ChildAdded:Connect(function(entry)
                        if entry.Name:find("PlayerEntry_") then
                            task.delay(0.2, PatchPlayerListEntry, entry)
                        end
                    end)
                    if not leaderboardHackConn then leaderboardHackConn = {} end
                    table.insert(leaderboardHackConn, c)
                end
            end
        end
        
        -- ตรวจเช็คกิ่งโครงสร้างตารางเดิมที่มีอยู่
        existingUndo = scrollingFrame:FindFirstChild("OffsetUndoFrame")
        if existingUndo then scanAndHookUndoFrame(existingUndo) end
        
        -- ตรวจเช็คกิ่งโครงสร้างใหม่ที่สร้างขึ้น
        mainConn = scrollingFrame.ChildAdded:Connect(function(child)
            if child.Name == "OffsetUndoFrame" then
                task.defer(scanAndHookUndoFrame, child)
            end
        end)
        if not leaderboardHackConn then leaderboardHackConn = {} end
        table.insert(leaderboardHackConn, mainConn)
    end)
end

function StopLeaderboardHack()
    if leaderboardHackConn then
        if type(leaderboardHackConn) == "table" then
            for _, c in ipairs(leaderboardHackConn) do pcall(function() c:Disconnect() end) end
        end
        leaderboardHackConn = nil
    end
    RestoreOriginalLeaderboard()
end

-- 🖼 "5. สร้างวิดเจ็ตสวิตช์ปุ่มบนหน้าเมนูแท็บใหม่"
createLabel("SERVER STATS LEADERBOARD HACK", leaderHackScroll)

createToggle("🏆 Force Show Real Stats", "ForceShowStats", leaderHackScroll)

-- ผูกมัดสวิตช์ปุ่มของสคริปต์ให้รัน Logic หลังบ้านอัตโนมัติ
hackToggleFrame = leaderHackScroll:GetChildren()[#leaderHackScroll:GetChildren()]
if hackToggleFrame and hackToggleFrame:IsA("Frame") then
    mainTriggerButton = hackToggleFrame:FindFirstChildOfClass("TextButton")
    if mainTriggerButton then
        mainTriggerButton.MouseButton1Click:Connect(function()
            if Config.ForceShowStats then
                StartLeaderboardHack()
                if type(CustomNotify) == "function" then
                    CustomNotify("✅ Leaderboard Hack Activated! Real stats are now enforced.", 4)
                end
            else
                StopLeaderboardHack()
                if type(CustomNotify) == "function" then
                    CustomNotify("🛑 Leaderboard Hack Disabled. Stats restored to default.", 3)
                end
            end
        end)
    end
end

createLabel("PRESS RE-TOGGLE IF PLAYERS JOIN", leaderHackScroll)

-- 🧼 เคลียร์พิกัดขยะป้องกันอาการหน่วยความจำรั่วไหล (Memory Leak Protection)
pcall(function()
    game:GetService("Players").LocalPlayer.CharacterRemoving:Connect(function()
        if not Config.ForceShowStats then RestoreOriginalLeaderboard() end
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
        Config.huh = math.clamp(n, 1, 10)
        
        if type(CustomNotify) == "function" then 
            CustomNotify("🎯 Dynamic Multiplier (huh) adjusted to: " .. tostring(Config.huh), 2.5) 
        end
    else
        if type(CustomNotify) == "function" then 
            CustomNotify("❌ Invalid Number! Please enter a valid decimal (e.g. 0.2)", 2.5) 
        end
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
