-- LMAO HORRIBLE SECURITY

--[[
    ██╗██╗     ██╗     ██╗   ██╗███████╗██╗ ██████╗ ███╗   ██╗
    ██║██║     ██║     ██║   ██║██╔════╝██║██╔═══██╗████╗  ██║
    ██║██║     ██║     ██║   ██║███████╗██║██║   ██║██╔██╗ ██║
    ██║██║     ██║     ██║   ██║╚════██║██║██║   ██║██║╚██╗██║
    ██║███████╗███████╗╚██████╔╝███████║██║╚██████╔╝██║ ╚████║
    ╚═╝╚══════╝╚══════╝ ╚═════╝ ╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝
    HUB  |  Blade Ball  |  BEST Script |  v1.00.04
--]]

if shared._EndlessRunning then
    shared._EndlessRunning = false
    task.wait(0.3)
end
shared._EndlessRunning = true

--==========================================================
-- SERVICES
--==========================================================
cloneref           = cloneref or function(x) return x end
local RS           = cloneref(game:GetService("ReplicatedStorage"))
local Players      = cloneref(game:GetService("Players"))
local RunService   = cloneref(game:GetService("RunService"))
local UIS          = cloneref(game:GetService("UserInputService"))
local TweenService = cloneref(game:GetService("TweenService"))
local StatsService = cloneref(game:GetService("Stats"))
local CoreGui      = cloneref(game:GetService("CoreGui"))

local LP           = Players.LocalPlayer
local Mouse        = LP:GetMouse()

--==========================================================
-- CONFIG
--==========================================================
Config = {
    AutoParry         = false,
    ParryMode         = "Pro",   -- Pro | Advance | Normal | Noob
    Accuracy          = 100,
    ParryCooldownValue= 0.07,
    AutoCooldownParry = false,
    ParryCurveMode    = "Camera",
    ClashTarget       = true,
    RandomTarget      = false,
    DistanceTiming    = 100,
    TargetLockMode    = "Normal",
    AutoSpam          = false,
    AutoSpamSpeed     = 0.005,
    SpamThreshold     = 3,
    AutoAbility       = false,
    AutoPlay          = false,
    ImmortalGodMode   = false,
    virexImmortalGodMode = false,
    ImmortalModeType  = "Auto",
    ImmortalCustomAngle  = 145,
    ImmortalCustomRadius = 10,
    ImmortalHeightMin = -8,
    ImmortalHeightMax = 35,
    CharOrbitEnabled  = false,
    CharOrbitDistance = 12,
    CharOrbitSpeed    = 5,
    CharOrbitAxis     = "Y",
    WalkSpeedEnabled  = false,
    WalkSpeedValue    = 16,
    JumpPowerEnabled  = false,
    JumpPowerValue    = 50,
    FlyEnabled        = false,
    FlySpeed          = 50,
    SkinChanger       = false,
    SoundEnabled      = false,
    AnimFix           = false,
    PreClickEnabled = false,
    PreClickDistance = 25,
    PreClickMultiTimer = 30, -- ค่าเริ่มต้น 0.3 วินาที (หาร 100 ในโค้ด)
    PreClick1v1Timer = 50,   -- ค่าเริ่มต้น 0.5 วินาที (หาร 100 ในโค้ด)
    PreClickVisualRing = false,
}

-- เพิ่มตัวตั้งค่าระบบ Illusion Spam แยกอิสระ
Config.IllusionSpamEnabled = false
Config.IllusionSpamSpeed = 0.001 -- ค่าเริ่มต้นความเร็วสูงสุดสัมพัทธ์ (0.001 วินาที)
Config.IllusionSpamBurst = 3     -- จำนวน Burst Packet ต่อรอบเฟรม (1-10)

shared.IllusionSpamActive = false
local lastIllusionSpamTime = 0

Config.OldAutoSpamEnabled = false
Config.OldAutoSpamSpeed = 0.005
shared.OldAutoSpamDetected = false

Config.OASpamShow = false
Config.OASpamActive = false
Config.OASpamSpeed = 0.005

Config.TriggerbotShow = false
Config.TriggerbotActive = false

--==========================================================
-- SHARED STATE
--==========================================================
shared.ManualSpamActive = false
shared.LastSpamTime     = 0
shared.Clicked_Target_Name = nil
parryLocked   = parryLocked   or {}
lockTime      = lockTime      or {}
lastHitTicks  = lastHitTicks  or {}
activeParryTasks = {}
local lastParryTime = 0
local pingSeconds   = 0.03
local activeTargetPlayer = nil
local TargetBillboardGui = nil
local LastClickTime = 0

-- Ping tracker
task.spawn(function()
    while shared._EndlessRunning do
        pcall(function()
            local net = StatsService:FindFirstChild("Network")
            local ss  = net and net:FindFirstChild("ServerStatsItem")
            local dp  = ss  and ss:FindFirstChild("Data Ping")
            if dp then pingSeconds = math.clamp(dp:GetValue() / 1000, 0.01, 0.3) end
        end)
        task.wait(0.5)
    end
end)

--==========================================================
-- BYPASS & EVENT CAPTURE (OXY ORIGINAL METHOD 100%)
--==========================================================
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local Workspace = cloneref(game:GetService("Workspace"))

_reverted = _reverted or {}

local eventCapture = {
    captured = {},
    hooked = {},
    originals = {},
    token_fn = nil,
}

-- ค้นหาฟังก์ชัน Tokenizer ในระบบ PRY (ดั้งเดิมของ Oxy)
for _, primaryValue in getgc(true) do
    if type(primaryValue) == "function" and debug.info(primaryValue, "s"):find("PRY", 1, true) then
        for _, secondaryValue in debug.getupvalues(primaryValue) do
            if type(secondaryValue) == "function" then
                eventCapture.token_fn = secondaryValue
                break
            end
        end
        if eventCapture.token_fn then
            break
        end
    end
end

-- ระบบคำนวณปั๊ม Token เรียลไทม์แปรผันตามวินาทีเซิร์ฟเวอร์ (Oxy Formula)
_tokenize = function(inputValue)
    if not eventCapture.token_fn then return "" end
    local secondaryValue = tostring(math.floor(Workspace:GetServerTimeNow() * 100))
    local tertiaryValue = eventCapture.token_fn(inputValue, "TIME")
    local quaternaryValue = table.create(#secondaryValue)
    for i = 1, #secondaryValue do
        quaternaryValue[i] = string.char(bit32.bxor((string.byte(secondaryValue, i) + i) % 256, string.byte(tertiaryValue, (i - 1) % #tertiaryValue + 1)))
    end
    return table.concat(quaternaryValue)
end

-- ฟังก์ชันเคลียร์ค่า Metatable ชั่วคราวสไตล์ Oxy
eventCapture.unhook = function()
    for k, primaryValue in pairs(eventCapture.originals) do
        pcall(function()
            setreadonly(k, false)
            k.__index = primaryValue
            setreadonly(k, true)
        end)
    end
    table.clear(eventCapture.hooked)
    table.clear(eventCapture.originals)
end

-- ระบบตรวจสอบความถูกต้องอาร์กิวเมนต์ที่สมบูรณ์แบบ (เริ่มเช็คจากช่องที่ 2 เป็นต้นไป)
eventCapture.valid_args = function(inputValue)
    return #inputValue == 8 
        and type(inputValue[2]) == "string" 
        and type(inputValue[3]) == "string" 
        and type(inputValue[4]) == "number" 
        and typeof(inputValue[5]) == "CFrame" 
        and type(inputValue[6]) == "table" 
        and type(inputValue[7]) == "table" 
        and type(inputValue[8]) == "boolean"
end

-- ตัวเกี่ยว Hook หลักที่จะดักจับและอัปเดตค่า args ใหม่ๆ ตลอดเวลา
eventCapture.hook = function(inputValue)
    if next(eventCapture.captured) ~= nil then
        return 
    end
    local primaryValue = getrawmetatable(inputValue)
    if eventCapture.hooked[primaryValue] then
        return 
    end
    eventCapture.hooked[primaryValue] = true
    setreadonly(primaryValue, false)
    local index = primaryValue.__index
    eventCapture.originals[primaryValue] = index
    
    primaryValue.__index = function(secondaryInput, tertiaryInput)
        if (tertiaryInput == "FireServer" and secondaryInput:IsA("RemoteEvent")) or (tertiaryInput == "InvokeServer" and secondaryInput:IsA("RemoteFunction")) then
            return function(quaternaryInput, ...)
                local temporaryList = {...}
                if eventCapture.valid_args(temporaryList) then
                    -- 🌟 บันทึกข้อมูลสดใหม่ลงแชร์ให้สคริปต์ส่ง Remote ตลอดเวลา
                    eventCapture.captured[secondaryInput] = temporaryList
                    _reverted = eventCapture.captured
                    
                    -- Oxy สั่งสลัดเคลียร์ Metatable รอบเก่าทิ้งเพื่อป้องกันระบบหน่วงจนโดนเตะ
                    eventCapture.unhook()
                end
                return index(secondaryInput, tertiaryInput)(quaternaryInput, unpack(temporaryList))
            end
        end
        return index(secondaryInput, tertiaryInput)
    end
    setreadonly(primaryValue, true)
end

-- สั่งรันเรดาร์สแกนหาระบบพาร์รี่หลักของเกมทันที
for _, primaryValue in ReplicatedStorage:GetDescendants() do
    if primaryValue:IsA("RemoteEvent") or primaryValue:IsA("RemoteFunction") then
        eventCapture.hook(primaryValue)
    end
end

-- ตั้งสัญญาณ First Signal สำรองของ Oxy
_firstSignal = nil
pcall(function()
    local packages = ReplicatedStorage:WaitForChild("Packages", 10)
    local controllers = ReplicatedStorage:WaitForChild("Controllers", 10)
    if packages and controllers then
        _firstSignal = require(packages.Signal).new()
        _firstSignal:Connect(require(controllers["SwordsController \12"].PRY))
    end
end)

--==========================================================
-- AUTO_PARRY MODULE
--==========================================================
local Auto_Parry = {}

function Auto_Parry.Get_Ball()
    local bc = workspace:FindFirstChild("Balls") or workspace:FindFirstChild("TrainingBalls")
    if bc then
        for _, b in pairs(bc:GetChildren()) do
            if b:IsA("BasePart") and (b:GetAttribute("realBall") or b:GetAttribute("target") or b.Name:find("Ball")) then
                return b
            end
        end
    end
    return nil
end

function Auto_Parry.Get_Balls()
    local out = {}
    for _, folder in pairs({ "Balls", "TrainingBalls" }) do
        local f = workspace:FindFirstChild(folder)
        if f then
            for _, b in ipairs(f:GetChildren()) do
                if b:IsA("BasePart") then
                    b.CanCollide = false
                    table.insert(out, b)
                end
            end
        end
    end
    return out
end

-- ==========================================================
-- ฟังก์ชันปรับปรุงใหม่: Auto_Parry.GetTargetPlayer() ทำงานสมบูรณ์ทุกโหมด
-- ==========================================================
function Auto_Parry.GetTargetPlayer()
    local alive = workspace:FindFirstChild("Alive")
    local myChar = LP.Character
    local cam = workspace.CurrentCamera
    if not alive or not myChar or not cam then return nil end
    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return nil end

    -- [1] MODE: DOUBLE CLICK (ตรวจสอบการล็อกเป้าหมายจากการดับเบิ้ลคลิกหน้าจอ)
    if Config.TargetLockMode == "Double Click" and shared.Clicked_Target_Name then
        local t = alive:FindFirstChild(shared.Clicked_Target_Name)
        if t and t ~= myChar and t:FindFirstChild("HumanoidRootPart") and t:FindFirstChildOfClass("Humanoid") and t:FindFirstChildOfClass("Humanoid").Health > 0 then 
            return t.Name -- 🌟 คืนค่าเป็นชื่อโดยตรง
        else
            if TargetBillboardGui then TargetBillboardGui:Destroy(); TargetBillboardGui = nil end
            shared.Clicked_Target_Name = nil
        end
    end

    -- รวบรวมผู้เล่นทุกคนใน Alive ที่ยังมีชีวิตอยู่เข้าตารางสแกนหลัก
    local targetsList = {}
    for _, target in ipairs(alive:GetChildren()) do
        if target:IsA("Model") and target ~= myChar then
            local hrp = target:FindFirstChild("HumanoidRootPart")
            local hum = target:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local dist = (myHRP.Position - hrp.Position).Magnitude
                local sp, onScreen = cam:WorldToViewportPoint(hrp.Position)
                local vp = cam.ViewportSize
                local center = Vector2.new(vp.X * 0.5, vp.Y * 0.5)
                local screenDist = onScreen and (Vector2.new(sp.X, sp.Y) - center).Magnitude or math.huge
                
                table.insert(targetsList, {
                    model = target,
                    distance = dist,
                    screenDistance = screenDist,
                    onScreen = onScreen
                })
            end
        end
    end

    if #targetsList == 0 then return nil end

    -- [2] CONDITION: RANDOM TARGET (ถ้าเปิดระบบสุ่มเป้าหมาย)
    if Config.RandomTarget then
        local switchTime = tonumber(Config.RandomTargetTime) or 3
        if not shared._EndlessLastRandomTime or (os.clock() - shared._EndlessLastRandomTime) >= switchTime or not shared._EndlessCurrentRandomTarget or not shared._EndlessCurrentRandomTarget.Parent then
            local randomIndex = math.random(1, #targetsList)
            shared._EndlessCurrentRandomTarget = targetsList[randomIndex].model
            shared._EndlessLastRandomTime = os.clock()
        end
        return shared._EndlessCurrentRandomTarget and shared._EndlessCurrentRandomTarget.Name or nil -- 🌟 คืนค่าเป็นชื่อ
    end

    -- [3] MODE SELECTION LOGIC (คัดกรองตามเงื่อนไข UI Lock Mode ทั้งหมด)
    if Config.TargetLockMode == "Nearest" then
        -- เรียงลำดับหาตัวละครที่ยืนอยู่ใกล้ตัวเราที่สุด
        table.sort(targetsList, function(a, b) return a.distance < b.distance end)
        return targetsList[1] and targetsList[1].model.Name or nil -- 🌟 คืนค่าเป็นชื่อ

    elseif Config.TargetLockMode == "Farthest" then
        -- เรียงลำดับหาตัวละครที่ยืนอยู่ไกลตัวเราที่สุด
        table.sort(targetsList, function(a, b) return a.distance > b.distance end)
        return targetsList[1] and targetsList[1].model.Name or nil -- 🌟 คืนค่าเป็นชื่อ

    else
        -- DEFAULT / MODE: NORMAL (หาตัวละครที่อยู่ใกล้จุดกึ่งกลางเป้าเล็งหน้าจอมากที่สุด)
        local bestTarget = nil
        local minScreenDist = math.huge
        local fallbackTarget = nil
        local minDistance = math.huge

        for _, tData in ipairs(targetsList) do
            if tData.onScreen and tData.screenDistance < minScreenDist then
                minScreenDist = tData.screenDistance
                bestTarget = tData.model
            end
            if tData.distance < minDistance then
                minDistance = tData.distance
                fallbackTarget = tData.model
            end
        end

        local finalTargetModel = bestTarget or fallbackTarget
        return finalTargetModel and finalTargetModel.Name or nil -- 🌟 คืนค่าเป็นชื่อ
    end
end

function Auto_Parry.Is_Curved(ball)
    local ok, v = pcall(function()
        local char = LP.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return false end
        local hrp  = char.HumanoidRootPart
        local vel  = ball.AssemblyLinearVelocity
        if vel.Magnitude < 1 then return false end
        local dot = vel.Unit:Dot((hrp.Position - ball.Position).Unit)
        return dot < 0.79 and dot > -0.77
    end)
    return ok and v or false
end

function Auto_Parry.IsTargetingMe(ball)
    if not ball then return false end
    local t = tostring(ball:GetAttribute("target") or ball:GetAttribute("Target") or "")
    return t == LP.Name
end

local CachedParryTracks = {}
LP.CharacterAdded:Connect(function() table.clear(CachedParryTracks) end)

function Auto_Parry.Parry_Animation()
    if not Config.AnimFix then return end
    pcall(function()
        local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        local anim = hum and hum:FindFirstChildOfClass("Animator")
        if not anim then return end
        local sword = LP.Character:GetAttribute("CurrentlyEquippedSword") or "Default"
        local track = CachedParryTracks[sword]
        if not track or not track.Animation or not track.Parent then
            local pa = RS.Shared.SwordAPI.Collection.Default:FindFirstChild("GrabParry")
            if pa then track = anim:LoadAnimation(pa); track.Priority = Enum.AnimationPriority.Action; CachedParryTracks[sword] = track end
        end
        if track then track:Stop(0); track.TimePosition = 0; track:Play(0, 0.65, 1.35) end
    end)
end

function Auto_Parry.CalculateParryCFrame(ball, targetPlayer)
    local cam = workspace.CurrentCamera
    if not targetPlayer or not targetPlayer.PrimaryPart or not cam then
        return targetPlayer and targetPlayer.PrimaryPart and targetPlayer.PrimaryPart.Position or Vector3.zero
    end
    local tp  = targetPlayer.PrimaryPart.Position
    local tHRP= targetPlayer.PrimaryPart
    local myHRP = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    local mode = Config.ParryCurveMode or "Camera"

    if mode == "Camera"  then return cam.CFrame.Position + cam.CFrame.LookVector * 1000
    elseif mode == "Left"  then return tp + tHRP.CFrame.RightVector * -500
    elseif mode == "Right" then return tp + tHRP.CFrame.RightVector *  500
    elseif mode == "Up"    then return tp + Vector3.new(0, 1000, 0)
    elseif mode == "Down"  then
        if myHRP then
            local dir = (tp - myHRP.Position).Unit
            return myHRP.Position + (-dir * 800)
        end
        return cam.CFrame.Position + cam.CFrame.LookVector * -800
    elseif mode == "Random" then
        local ang = math.rad(math.random(0, 360))
        return tp + Vector3.new(math.cos(ang)*math.random(350,700), math.random(-400,500), math.sin(ang)*math.random(350,700))
    elseif mode == "Straight" then return tp
    elseif mode == "Super Curve Random" then
        _G._SCDir = _G._SCDir or "Left"
        _G._SCTick = _G._SCTick or 0
        if os.clock() ~= _G._SCTick then
            _G._SCTick = os.clock()
            local dirs = {"Left","Right","Up","Down"}
            _G._SCDir = dirs[math.random(1,4)]
        end
        if _G._SCDir == "Left"  then return tp + tHRP.CFrame.RightVector * -600
        elseif _G._SCDir == "Right" then return tp + tHRP.CFrame.RightVector * 600
        elseif _G._SCDir == "Up"    then return tp + Vector3.new(0, 800, 0)
        else
            local dir = myHRP and (tp - myHRP.Position).Unit or cam.CFrame.LookVector
            return (myHRP or cam.CFrame.Position) + (-dir * 700)
        end
    end
    return tp
end

function Auto_Parry.FireParryRemote(isSpam)
    -- เล่นเสียง parry (ระบบเดิมของคุณ)
    if Config.SoundEnabled then
        pcall(function()
            local ss = game:GetService("SoundService")
            local s  = ss:FindFirstChild("EH_ParrySound")
            if not s then
                s = Instance.new("Sound")
                s.Name    = "EH_ParrySound"
                s.SoundId = "rbxassetid://8394620892"
                s.Volume  = 3
                s.Parent  = ss
            end
            local c = s:Clone()
            c.Parent = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") or ss
            c:Play()
            c.Ended:Connect(function() c:Destroy() end)
        end)
    end
    pcall(Auto_Parry.Parry_Animation)

    -- หากยังดัก Remote สดไม่ได้ ให้ยิง first_signal ค้างไว้เพื่อเปิดแผลให้ระบบดักจับ (ระบบดั้งเดิมของ Oxy)
    if not _reverted or next(_reverted) == nil then
        if _firstSignal then
            pcall(function()
                local cam  = workspace.CurrentCamera
                local snap = {}
                local alive = workspace:FindFirstChild("Alive")
                if alive and cam then
                    for _, c in ipairs(alive:GetChildren()) do
                        if c:IsA("Model") and c.PrimaryPart then
                            local sp = cam:WorldToScreenPoint(c.PrimaryPart.Position)
                            if sp.Z > 0 then snap[c.Name] = sp end
                        end
                    end
                end
                _firstSignal:Fire(
                    0.5,
                    cam and cam.CFrame or CFrame.new(),
                    snap,
                    { cam and cam.ViewportSize.X / 2 or 0, cam and cam.ViewportSize.Y / 2 or 0 },
                    false
                )
            end)
        else
            pcall(function()
                if mouse1press then mouse1press(); task.wait(0.03); mouse1release() end
                if mouse1click then mouse1click() end
            end)
        end
        return
    end

    local cam = workspace.CurrentCamera
    if not cam then return end

    -- ดึงชื่อเป้าหมายจากระบบคัดกรอง
    local targetName = Auto_Parry.GetTargetPlayer()
    local char   = LP.Character
    local myHRP  = char and char:FindFirstChild("HumanoidRootPart")
    local alive  = workspace:FindFirstChild("Alive")

    -- คำนวณหา CFrame ทิศทางหลอกสาดโค้ง (finalCamCFrame)
    local finalCamCFrame = cam.CFrame
    if targetName and alive and myHRP then
        local targetModel = alive:FindFirstChild(targetName)
        if targetModel and targetModel.PrimaryPart then
            local d = (myHRP.Position - targetModel.PrimaryPart.Position).Magnitude
            if not (Config.ClashTarget and d <= 37) then
                local dest = Auto_Parry.CalculateParryCFrame(Auto_Parry.Get_Ball(), targetModel)
                if dest then
                    local v3 = typeof(dest) == "CFrame" and dest.Position or dest
                    finalCamCFrame = CFrame.lookAt(cam.CFrame.Position, v3)
                end
            end
        end
    end

    -- พิกัดหน้าจอกึ่งกลางตรงตัว (finalCoordinates)
    local viewportSize = cam.ViewportSize
    local finalCoordinates = { viewportSize.X * 0.5, viewportSize.Y * 0.5 }

    -- 🌟 ลูปยิง Remote ควบคู่ไปกับตารางแชร์สด _reverted ของ Oxy ดั้งเดิม
    for _remote, _originalArgs in pairs(_reverted) do
        if type(_originalArgs) ~= "table" then continue end
        
        -- ใช้ชื่อผู้เล่นปลายทางจริง ถ้าหาไม่เจอให้ Fallback ไปใช้ชื่อเดิมติดมากับแพ็กเกจ
        local activeTarget = targetName or _originalArgs[2]

local cam = workspace.CurrentCamera
local gamePositionsSnapshot = {}

if cam and alive then
    currentTargetValue = Auto_Parry.GetTargetPlayer()
    for _, character in ipairs(alive:GetChildren()) do
        if character:IsA("Model") and character.PrimaryPart then
            isTargetSelected = false
            
            if type(currentTargetValue) == "string" then
                if character.Name == currentTargetValue then
                    isTargetSelected = true
                end
            elseif type(currentTargetValue) == "table" then
                for _, targetName in pairs(currentTargetValue) do
                    if character.Name == targetName or (typeof(targetName) == "Instance" and targetName.Name == character.Name) then
                        isTargetSelected = true
                        break
                    end
                end
            elseif typeof(currentTargetValue) == "Instance" and currentTargetValue:IsA("Model") then
                if character == currentTargetValue or character.Name == currentTargetValue.Name then
                    isTargetSelected = true
                end
            end
            
            if isTargetSelected then
                screenPos, onScreen = cam:WorldToScreenPoint(character.PrimaryPart.Position)
                gamePositionsSnapshot[character.Name] = screenPos
            end
        end
    end
end

        task.spawn(function()
            xpcall(function()
                if _remote:IsA("RemoteEvent") then
                    _remote:FireServer(
                        _originalArgs[1],            -- เลขคูลดาวน์/Timestamp ดิบประจำวินาที
                        _originalArgs[2],            -- ล็อคส่งค่าคีย์สุ่มดั้งเดิมจากเซิร์ฟเวอร์ (เช่น "Ws_yZ6")
                        _tokenize(_originalArgs[2]), -- ปั๊ม Token จากตัวคีย์สุ่มจริงตามสูตร Oxy
                        isSpam and 0 or 0.5,         -- ดีเลย์สแปม
                        finalCamCFrame,              -- CFrame ทิศทางหลอก (องศาเลี้ยวโค้ง)
                        gamePositionsSnapshot,       -- ตารางตำแหน่ง Vector3 ของทุกคน { [Name] = Vector3 }
                        finalCoordinates,            -- พิกัดกึ่งกลางหน้าจอ
                        false                        -- Security Flag ปิดท้าย
                    )
                elseif _remote:IsA("RemoteFunction") then
                    _remote:InvokeServer(
                        _originalArgs[1],
                        _originalArgs[2],
                        _tokenize(_originalArgs[2]),
                        isSpam and 0 or 0.5,
                        finalCamCFrame,
                        gamePositionsSnapshot,
                        finalCoordinates,
                        false
                    )
                end
            end, function(err)
                print("Endless FireParryRemote Execution Error: " .. tostring(err))
            end)
        end)
    end    
end

--==========================================================
-- DOUBLE-CLICK TARGET LOCK
--==========================================================
UIS.InputBegan:Connect(function(inp, gp)
    if gp then return end
    local t = inp.UserInputType
    if t ~= Enum.UserInputType.MouseButton1 and t ~= Enum.UserInputType.Touch then return end
    local now = os.clock()
    local tgt = Mouse.Target
    local alive = workspace:FindFirstChild("Alive")
    if tgt and alive then
        local ch = tgt.Parent
        if ch and ch.Parent == alive then
            local hum = ch:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                if now - LastClickTime < 0.25 then
                    if TargetBillboardGui then TargetBillboardGui:Destroy() end
                    shared.Clicked_Target_Name = ch.Name
                    activeTargetPlayer = ch
                    TargetBillboardGui = Instance.new("BillboardGui")
                    TargetBillboardGui.Size = UDim2.fromOffset(80, 24)
                    TargetBillboardGui.StudsOffset = Vector3.new(0, 3.2, 0)
                    TargetBillboardGui.AlwaysOnTop = true
                    TargetBillboardGui.Parent = CoreGui
                    TargetBillboardGui.Adornee = ch:FindFirstChild("Head")
                    local lbl = Instance.new("TextLabel")
                    lbl.BackgroundTransparency = 1
                    lbl.Size = UDim2.fromScale(1,1)
                    lbl.Text = "◉ TARGET"
                    lbl.TextColor3 = Color3.fromRGB(255,255,255)
                    lbl.TextSize = 13
                    lbl.Font = Enum.Font.GothamBold
                    lbl.TextStrokeTransparency = 0
                    lbl.Parent = TargetBillboardGui
                end
            end
        end
    end
    LastClickTime = now
end)

AbilityReadyToCast = false

if shared._EndlessAbilityCheckThread then 
    task.cancel(shared._EndlessAbilityCheckThread) 
end

shared._EndlessAbilityCheckThread = task.spawn(function()
    while shared._EndlessRunning do
        xpcall(function()
            if not Config.AutoAbility then
                AbilityReadyToCast = false
                task.wait(0.1)
                return
            end

            local char = LP.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then
                AbilityReadyToCast = false
                task.wait(0.1)
                return
            end

            local ballsFolder = workspace:FindFirstChild("Balls") or workspace:FindFirstChild("TrainingBalls")
            if not ballsFolder then
                AbilityReadyToCast = false
                task.wait(0.1)
                return
            end

            local targetBall = nil
            for _, b in pairs(ballsFolder:GetChildren()) do
                if b:IsA("BasePart") and (b:GetAttribute("realBall") or b:GetAttribute("target") or b.Name:find("Ball")) then
                    if tostring(b:GetAttribute("target") or b:GetAttribute("Target") or "") == LP.Name then
                        targetBall = b
                        break
                    end
                end
            end

            -- ถ้าไม่มีบอลเล็งมา หรือบอลลูกนั้นเพิ่งกดพารี่ไป/โดนล็อกอยู่ ไม่ต้องใช้สกิล
            if not targetBall or parryLocked[targetBall] then
                AbilityReadyToCast = false
                task.wait(0.01)
                return
            end

            -- [FIXED] เช็คสถานะสกิลจากหน้าจอ UI Hotbar จริงๆ ตามหลักสคริปต์ชั้นนำ
            local abilityReady = false
            pcall(function()
                local hotbar = LP:FindFirstChild("PlayerGui") and LP.PlayerGui:FindFirstChild("Hotbar")
                local abilityBtn = hotbar and hotbar:FindFirstChild("Ability")
                local gradient = abilityBtn and abilityBtn:FindFirstChildOfClass("UIGradient")
                
                if gradient then
                    -- ถ้าระดับคูลดาวน์ขยับมาเต็มหลอด (ค่าปกติของเกมคือ 0.5 หรือขยับสุด)
                    abilityReady = (gradient.Offset.Y == 0.5 or gradient.Offset.Y == 0)
                else
                    abilityReady = false
                end
            end)

            if not abilityReady then
                AbilityReadyToCast = false
                task.wait(0.01)
                return
            end

            -- คำนวณระยะทางความเร็วเพื่อหา Kill Zone
            local ballPos = targetBall.Position
            local distance = (hrp.Position - ballPos).Magnitude
            local velocity = Vector3.zero
            local zoomies = targetBall:FindFirstChild("zoomies")
            
            if zoomies then 
                pcall(function() velocity = zoomies.VectorVelocity end) 
            end
            if velocity == Vector3.zero and targetBall:IsA("BasePart") then 
                velocity = targetBall.AssemblyLinearVelocity 
            end
            
            local speed = velocity.Magnitude
            pingSeconds = pingSeconds or 0.03
            local pingMs = pingSeconds * 1000
            local pingThresh = math.clamp(pingMs / 100, 5, 17)
            
            local uScale = Config.DistanceTiming / 100
            local cap = math.min(math.max(speed - 9.5, 0), 2500)
            local div = (2.4 + cap * 0.002) * 1.02
            local zone = pingThresh + math.max(speed / div, 9.5)
            local skyBuf = velocity.Y < -5 and math.max(math.abs(velocity.Y) * 0.42, 12) or 0
            local vBuf = math.max(math.abs(velocity.Y) * 0.22, 0)
            local killZone = (zone * uScale) + vBuf + skyBuf

            -- บอลต้องเข้าสู่ระยะอันตรายถึงจะอนุญาตให้สคริปต์ยิงสกิล
            if distance <= killZone or (distance / math.max(speed, 1)) <= 0.048 then
                AbilityReadyToCast = true
            else
                AbilityReadyToCast = false
            end
        end, function(err)
            print("Endless Ability Condition Check Loop Error: " .. tostring(err))
        end)
        task.wait()
    end
end)

--==========================================================
-- MAIN PHYSICS PARRY LOOP
--==========================================================
local BallFirstTargetDistanceMap = {}
local WasTargetingMeLastFrame    = {}
local LastSingularityActiveTime  = 0
LastFrameTarget = {}

if shared._EndlessPhysicsBind then shared._EndlessPhysicsBind:Disconnect() end

shared._EndlessPhysicsBind = RunService.RenderStepped:Connect(function()
    xpcall(function()
        if not shared._EndlessRunning then return end
        local char    = LP.Character
        local hrp     = char and char:FindFirstChild("HumanoidRootPart")
        local hum     = char and char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum or hum.Health <= 0 then return end

pcall(function()
    local hotbar = LP:FindFirstChild("PlayerGui") and LP.PlayerGui:FindFirstChild("Hotbar")
    local blockBtn = hotbar and hotbar:FindFirstChild("Block")
    local uiGradient = blockBtn and blockBtn:FindFirstChildWhichIsA("UIGradient")
    if uiGradient and uiGradient.Offset.Y >= 0.5 then
        for _, Ball in pairs(balls) do
            parryLocked[Ball] = false
            lockTime[Ball] = 0
        end
    end
end)

        local balls = Auto_Parry.Get_Balls()
        if #balls == 0 then return end

        local playerPos = hrp.Position
        local now       = os.clock()
        local autoOn    = Config.AutoParry

        for _, Ball in pairs(balls) do
            if not Ball or not Ball.Parent then continue end

            local ballPos  = Ball.Position
            local Distance = (playerPos - ballPos).Magnitude
            local Velocity = Vector3.zero
            local zoomies  = Ball:FindFirstChild("zoomies")
            if zoomies then pcall(function() Velocity = zoomies.VectorVelocity end) end
            if Velocity == Vector3.zero and Ball:IsA("BasePart") then Velocity = Ball.AssemblyLinearVelocity end
            local Speed        = Velocity.Magnitude
            local toPlayer     = Distance > 0.1 and (playerPos - ballPos).Unit or Vector3.zero
            local dotProduct   = Speed > 0.1 and Velocity.Unit:Dot(toPlayer) or 0
            local targetAttr   = tostring(Ball:GetAttribute("target") or Ball:GetAttribute("Target") or "")
            local isTargetingMe= (targetAttr == LP.Name)

            if isTargetingMe then
                if not WasTargetingMeLastFrame[Ball] then
                    BallFirstTargetDistanceMap[Ball] = Distance
                    WasTargetingMeLastFrame[Ball]    = true
                end
            else
                BallFirstTargetDistanceMap[Ball] = nil
                WasTargetingMeLastFrame[Ball]    = nil
                parryLocked[Ball]  = false
                lockTime[Ball]     = 0
                lastHitTicks[Ball] = 0
            end
            
            if isTargetingMe then
                if lastHitTicks[Ball] and lastHitTicks[Ball] > 0 then
                    if (now - lastHitTicks[Ball]) > 0.75 then
                        parryLocked[Ball] = false
                        lockTime[Ball] = 0
                        lastHitTicks[Ball] = now 
                    end
                end
            end
            

            if parryLocked[Ball] then continue end
            
-- ==========================================================
-- SYSTEM: ADVANCED PRE-CLICK V1 (FULLY CUSTOMIZABLE + ESP RING)
-- ==========================================================
local preClickTriggered = false

-- [VISUAL SYSTEM] ระบบวาดวงแหวนแสงตรวจจับระยะ Pre-click รอบตัวผู้เล่น
local function UpdatePreClickVisualRing(myHrp, maxDist)
    if not Config.PreClickVisualRing or not Config.PreClickEnabled then
        if shared._PreClickVisualPart then 
            shared._PreClickVisualPart:Destroy() 
            shared._PreClickVisualPart = nil 
        end
        return
    end

    if myHrp then
        if not shared._PreClickVisualPart or not shared._PreClickVisualPart.Parent then
            shared._PreClickVisualPart = Instance.new("Part")
            shared._PreClickVisualPart.Name = "_PreClickRing"
            shared._PreClickVisualPart.Shape = Enum.PartType.Cylinder
            shared._PreClickVisualPart.Material = Enum.Material.ForceField
            shared._PreClickVisualPart.CastShadow = false
            shared._PreClickVisualPart.CanCollide = false
            shared._PreClickVisualPart.CanQuery = false
            shared._PreClickVisualPart.CanTouch = false
            shared._PreClickVisualPart.Anchored = true
            shared._PreClickVisualPart.Parent = workspace
        end
        
        local ringDiameter = maxDist * 2
        shared._PreClickVisualPart.Size = Vector3.new(0.5, ringDiameter, ringDiameter)
        shared._PreClickVisualPart.CFrame = CFrame.new(myHrp.Position - Vector3.new(0, 2.8, 0)) * CFrame.Angles(0, 0, math.rad(90))
        shared._PreClickVisualPart.Color = Color3.fromRGB(0, 235, 255)
    end
end

if Config.PreClickEnabled then
    local aliveFolder = workspace:FindFirstChild("Alive")
    local myChar = LP.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    
    if myHrp and aliveFolder and Ball then
        local myPos = myHrp.Position
        local ballPos = Ball.Position
        
        -- ดึงระยะทางสูงสุดที่ผู้เล่นกำหนดจาก GUI
        local maxCustomDistance = tonumber(Config.PreClickDistance) or 25
        
        -- เรียกใช้งานระบบวาดวงแหวนรอบตัว
        pcall(UpdatePreClickVisualRing, myHrp, maxCustomDistance)
        
        -- ประมวลผลความเร็วบอล
        local ballVel = Vector3.zero
        local zoomies = Ball:FindFirstChild("zoomies")
        if zoomies then pcall(function() ballVel = zoomies.VectorVelocity end) end
        if ballVel == Vector3.zero and Ball:IsA("BasePart") then ballVel = Ball.AssemblyLinearVelocity end
        local ballSpeed = ballVel.Magnitude
        
        -- คัดแยกผู้เล่นในสนาม
        local alivePlayers = {}
        local currentTargetPlayer = nil
        local currentTargetAttr = tostring(Ball:GetAttribute("target") or Ball:GetAttribute("Target") or "")
        
        for _, p in ipairs(aliveFolder:GetChildren()) do
            if p:IsA("Model") and p:FindFirstChild("HumanoidRootPart") and p:FindFirstChildOfClass("Humanoid") and p:FindFirstChildOfClass("Humanoid").Health > 0 then
                if p.Name ~= LP.Name then
                    table.insert(alivePlayers, p)
                end
                if p.Name == currentTargetAttr then
                    currentTargetPlayer = p
                end
            end
        end
        
        local totalAlive = #alivePlayers + 1
        
        -- [DYNAMIC DISTANCE GUARD] ตรวจรัศมีรอบตัวตามที่ผู้เล่นปรับในสไลด์ UI
        local isAnyoneInZone = false
        for _, enemy in ipairs(alivePlayers) do
            if (myPos - enemy.HumanoidRootPart.Position).Magnitude <= maxCustomDistance then
                isAnyoneInZone = true
                break
            end
        end
        
        if isAnyoneInZone and currentTargetPlayer and currentTargetPlayer.Name ~= LP.Name then
            
            local targetHrp = currentTargetPlayer.HumanoidRootPart
            local distToTarget = (myPos - targetHrp.Position).Magnitude
            local ballDistToTarget = (targetHrp.Position - ballPos).Magnitude
            local timeToTarget = ballDistToTarget / math.max(ballSpeed, 1)
            
            local myDirFromTarget = (myPos - targetHrp.Position).Unit
            local camLookDir = workspace.CurrentCamera.CFrame.LookVector
            local facingTrend = targetHrp.CFrame.LookVector:Dot(-myDirFromTarget) > 0.4 or camLookDir:Dot(myDirFromTarget) > 0.4
            
            -- ดึงเวลาหน้าต่างพารี่แปรผันตรงที่ผู้เล่นเซ็ตมาจาก GUI (หาร 100 เพื่อแปลงเป็นหน่วยวินาที)
            local userMultiTimeThreshold = (tonumber(Config.PreClickMultiTimer) or 30) / 100
            local user1v1TimeThreshold = (tonumber(Config.PreClick1v1Timer) or 50) / 100
            
            -- [CASE 1] มีผู้เล่นเหลือมากกว่าหรือเท่ากับ 2 คน (2+ Players Alive)
            if totalAlive >= 2 then
                local targetVel = targetHrp.AssemblyLinearVelocity
                local myVel = myHrp.AssemblyLinearVelocity
                local isMovingTowards = (myPos - targetHrp.Position).Unit:Dot(targetVel - myVel) > 2
                
                if (isMovingTowards or distToTarget <= 15) and timeToTarget < userMultiTimeThreshold then
                    preClickTriggered = true
                end
            end
            
            -- [CASE 2] สถานการณ์ 1v1 Duel คลุกวงในระยะประชิด
            if totalAlive == 2 then
                local lowerBound = math.max(10, maxCustomDistance - 5)
                if distToTarget >= lowerBound and distToTarget <= maxCustomDistance and timeToTarget < user1v1TimeThreshold then
                    preClickTriggered = true
                elseif distToTarget < lowerBound and timeToTarget < (user1v1TimeThreshold - 0.1) then 
                    -- ประชิดจูบหน้าไม้ บีบเวลาลงป้องกันการกดเร็วไป
                    preClickTriggered = true
                end
            end
            
            -- [CASE 3] จังหวะดักรอบศัตรูในระยะ 15 Studs (Circle Aggro Strategy)
            if distToTarget <= 15 and (facingTrend or ballSpeed > 250) then
                local serverPingOffset = math.clamp(pingSeconds, 0.01, 0.15)
                if timeToTarget <= (0.05 + serverPingOffset) then
                    preClickTriggered = true
                end
            end
            
            -- [CASE 4] ANTI-SPAM FEINT (แก้ทางบอลโดนหน่วงสกิล)
            if ballDistToTarget <= 5 and ballSpeed < 30 and distToTarget <= 12 then
                preClickTriggered = true
            end
        end
    else
        -- ซ่อนวงแหวนเมื่อตัวละครตายหรือบอลไม่อยู่ในฉาก
        if shared._PreClickVisualPart then shared._PreClickVisualPart:Destroy(); shared._PreClickVisualPart = nil end
    end
else
    -- ซ่อนวงแหวนเมื่อปิดฟังก์ชันจาก GUI
    if shared._PreClickVisualPart then shared._PreClickVisualPart:Destroy(); shared._PreClickVisualPart = nil end
end

-- สั่งยิง Remote พารี่ทันทีเมื่อเงื่อนไขผ่านเกณฑ์
if preClickTriggered then
    if (os.clock() - lastParryTime) >= 0.005 then
        pcall(Auto_Parry.FireParryRemote, false)
        lastParryTime = os.clock()
    end
    if Ball then
        parryLocked[Ball] = true
        lockTime[Ball] = os.clock()
        lastHitTicks[Ball] = os.clock()
    end
end
-- ==========================================================
            local triggerParry = false
            
            if isTargetingMe then
                if AbilityReadyToCast then
                    local tornado = workspace:FindFirstChild("Runtime") and workspace.Runtime:FindFirstChild("Tornado")
                    local tornadoTime = tornado and (tornado:GetAttribute("TornadoTime") or 1)
                    
                    if tornado and (os.clock() - (Ball:GetAttribute("AerodynamicTime") or 0)) < (tornadoTime + 0.314159) then
                        triggerParry = false
                    else
                        pcall(function() 
                            game:GetService("ReplicatedStorage").Remotes.AbilityButtonPress:Fire() 
                        end)
                        parryLocked[Ball] = true
                        lockTime[Ball] = now
                        lastHitTicks[Ball] = now
                        AbilityReadyToCast = false
                    end
                elseif autoOn then     
                    ping_ms = pingSeconds * 1000
                    ping_thresh = math.clamp(ping_ms / 100, 5, 17)
                    distanceA = BallFirstTargetDistanceMap[Ball] or Distance
                    skyBuf = Velocity.Y < -5 and math.max(math.abs(Velocity.Y) * 0.42, 12) or 0
                    uScale = Config.DistanceTiming / 100
                    mode = Config.ParryMode or "Pro"
                    tti = Distance / math.max(Speed, 1)
                    
                if Distance <= 9.5 then
                    triggerParry = true
                elseif tti > 0.15 and Distance <= 15 then
                    triggerParry = true
                elseif mode == "Pro" then
                        local ping_thresh_oxy = math.clamp((pingSeconds * 1000) / 10 / 10, 5, 17)
                        local acc_multiplier = (math.clamp(Config.Accuracy or 100, 1, 100) - 1) * 0.015151515151515152                
                        local oxy_div = (2.4 + math.min(math.max(Speed - 9.5, 0), 650) * 0.002) * acc_multiplier
        
                        if Distance <= (ping_thresh_oxy + math.max(Speed / oxy_div, 9.5)) and (acc_multiplier * 0.8) then
                            triggerParry = true
                        end
                elseif mode == "Advance" then
                    -- VIREX GOD CURVE
                    local cap  = math.min(math.max(Speed - 9.5, 0), 650)
                    local div  = (2.4 + cap * 0.002) * (Config.Accuracy and (0.7 + (Config.Accuracy-1)*(0.9/99)) or 1.1)
                    local zone = (math.clamp(ping_ms/10, 5, 17)) + math.max(Speed / div, 9.5)
                    local reach = Distance / math.max(Speed, 1) - pingSeconds
                    local dot_t = math.clamp(0.55 - pingSeconds * 0.75, -1, 0.45)
                    local curved= dotProduct < dot_t or Distance < (15 - math.min(Distance/1000,15) + math.min(Speed/100,45)) * 0.85
                    if (Distance <= zone or distanceA and Distance <= zone) and not curved then triggerParry = true end
                    if Distance <= 15 and dotProduct > -0.25 then triggerParry = true end

                elseif mode == "Noob" then
                    -- INVIS CURVE
                    local acc  = Config.Accuracy ~= 100 and 0.715 * (Config.Accuracy/100) or 0.715
                    local cap  = math.min(math.max(Speed - 9.5, 0), 2500)
                    local div  = (2.4 + cap * 0.012) * acc
                    local zone = ping_thresh + math.max(Speed / div, 9.5)
                    local vBuf = Velocity.Y < -5 and math.clamp(math.abs(Velocity.Y)*0.28 + Speed*0.03, 5, 32) or math.max(math.abs(Velocity.Y)*0.22, 0)
                    local kill = math.clamp((zone * uScale) + vBuf + skyBuf, 14, Speed > 600 and 130 or 95)
                    if Speed < 95 and Speed > 25 then
                        kill = Velocity.Y < -15 and math.clamp(kill, 16, 24) or math.clamp(kill, 22, 32)
                    end
                    local tti = Distance / math.max(Speed, 1)
                    local opt = 0.045 + pingSeconds * 0.6
                    if (Distance <= kill or tti <= opt) and (dotProduct > -0.22 or Distance <= 16) then triggerParry = true end

                else -- Normal (God Curve default)
                    local cap  = math.min(math.max(Speed - 9.5, 0), 2500)
                    local div  = (2.4 + cap * 0.002) * 1.02
                    local zone = ping_thresh + math.max(Speed / div, 9.5)
                    local vBuf = math.max(math.abs(Velocity.Y) * 0.22, 0)
                    local kill = (zone * uScale) + vBuf + skyBuf
                    if (Distance <= kill or distanceA and Distance <= kill) or (Distance/math.max(Speed,1)) <= 0.048 then
                        if dotProduct > -0.35 or Distance <= 15 + skyBuf then triggerParry = true end
                    end
                end

                    if Speed >= 795 then
                        if (Distance <= ((ping_thresh + math.max(Speed/(2.4+math.min(math.max(Speed-9.5,0),650)*0.002),9.5)) * uScale * 1.18) + skyBuf or
                            (Distance / math.max(Speed,1)) <= 0.065) and (dotProduct > 0.35 or Distance <= 35 + skyBuf) then
                            triggerParry = true
                        end
                    end
                end
            end

targetAttr = Ball:GetAttribute("target") or Ball:GetAttribute("Target")
currentBallTarget = tostring(targetAttr or "")
isTargetingMe = (currentBallTarget == LP.Name)

tornado = workspace:FindFirstChild("Runtime") and workspace.Runtime:FindFirstChild("Tornado")
tornadoTime = tornado and (tornado:GetAttribute("TornadoTime") or 1)
isAerodynamic = Ball:GetAttribute("AerodynamicTime") or 0

if isTargetingMe then
    if LastFrameTarget[Ball] == LP.Name and tornado and (os.clock() - isAerodynamic) < (tornadoTime + 0.314159) then
        triggerParry = false
        parryLocked[Ball] = true
        
        task.delay(0.12, function()
            xpcall(function()
                if Ball and Ball.Parent then
                    if tostring(Ball:GetAttribute("target") or Ball:GetAttribute("Target") or "") == LP.Name then
                        parryLocked[Ball] = false
                        Auto_Parry.FireParryRemote(false)
                    end
                end
            end, function(err)
                print("Illusion Advanced Tornado Counter Error: " .. tostring(err))
            end)
        end)
    end
end

LastFrameTarget[Ball] = currentBallTarget

            if triggerParry then
                if (now - lastParryTime) >= 0.003 then
                    burst = Speed > 1800 and 3 or 1
                    for _ = 1, burst do pcall(Auto_Parry.FireParryRemote, false) end
                    lastParryTime = now
                end
                parryLocked[Ball]  = true
                lockTime[Ball]     = now
                lastHitTicks[Ball] = now
            end
        end
    end, function(e) print("[Endless Parry]", e) end)
end)


-- ParrySuccessAll unlock
RS.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(_, ballPart, _, playerName)
    xpcall(function()
        local me = LP.Name
        if tostring(playerName) ~= me then
            if ballPart then parryLocked[ballPart] = false; lockTime[ballPart] = 0 end
            return
        end
        if ballPart then
            if activeParryTasks[ballPart] then task.cancel(activeParryTasks[ballPart]) end
            parryLocked[ballPart] = true
            local cd = tonumber(Config.ParryCooldownValue) or 0.07
            activeParryTasks[ballPart] = task.delay(cd, function()
                parryLocked[ballPart] = false
                lockTime[ballPart] = 0
                activeParryTasks[ballPart] = nil
            end)
        end
    end, function(e) print("[Endless PSA]", e) end)
end)

--==========================================================
-- AUTO SPAM LOOP (แก้ไขให้ Manual Spam ทำงานอิสระ)
--==========================================================
if shared._EndlessSpamThread then task.cancel(shared._EndlessSpamThread) end
shared._EndlessSpamThread = task.spawn(function()
    while shared._EndlessRunning do
        local delay = tonumber(Config.AutoSpamSpeed) or 0.005
        if shared.ManualSpamActive then
            pcall(Auto_Parry.FireParryRemote, true)
            pcall(Auto_Parry.FireParryRemote, true)
        end
        task.wait(delay)
    end
end)

--==========================================================
-- AUTO PLAY
--==========================================================
if shared._EndlessAutoPlayThread then task.cancel(shared._EndlessAutoPlayThread) end
shared._EndlessAutoPlayThread = task.spawn(function()
    while shared._EndlessRunning do
        task.wait(math.random() * 4 + 1)
        if not Config.AutoPlay then continue end
        local char  = LP.Character
        local alive = workspace:FindFirstChild("Alive")
        if not char or not alive or not char:IsDescendantOf(alive) then continue end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hum or not hrp then continue end
        pcall(function()
            local angle = math.random() * math.pi * 2
            local dist  = math.random(8, 22)
            hum:MoveTo(hrp.Position + Vector3.new(math.cos(angle)*dist, 0, math.sin(angle)*dist))
        end)
        if math.random() < 0.25 then
            pcall(function() hum.Jump = true end)
        end
        if math.random() < 0.3 then
            pcall(function()
                local cam = workspace.CurrentCamera
                cam.CFrame = cam.CFrame * CFrame.Angles(0, math.rad(math.random(-45,45)), 0)
            end)
        end
    end
end)

--==========================================================
-- IMMORTAL V1 + V2 + ORBIT
--==========================================================
local ImmortalCamAnchor = workspace:FindFirstChild("EH_CamAnchor") or Instance.new("Part")
if not ImmortalCamAnchor.Parent then
    ImmortalCamAnchor.Size = Vector3.new(0.1,0.1,0.1)
    ImmortalCamAnchor.Transparency = 1
    ImmortalCamAnchor.CanCollide   = false
    ImmortalCamAnchor.Anchored     = true
    ImmortalCamAnchor.Name         = "EH_CamAnchor"
    ImmortalCamAnchor.Parent       = workspace
end
_G.EHOrbitAngle = 0

if shared._EndlessImmortalBind then shared._EndlessImmortalBind:Disconnect() end
shared._EndlessImmortalBind = RunService.Heartbeat:Connect(function()
    if not shared._EndlessRunning then return end
    local char = LP.Character
    local hrp  = char and char:FindFirstChild("HumanoidRootPart")
    local hum  = char and char:FindFirstChildOfClass("Humanoid")
    local cam  = workspace.CurrentCamera
    if not hrp or not hum or hum.Health <= 0 or not cam then return end

    if Config.virexImmortalGodMode or Config.ImmortalGodMode then
        ImmortalCamAnchor.CFrame = ImmortalCamAnchor.CFrame:Lerp(CFrame.new(hrp.Position), 0.3)
        if cam.CameraSubject ~= ImmortalCamAnchor then cam.CameraSubject = ImmortalCamAnchor end
        pcall(function() setfflag("S2PhysicsSenderRate", "15") end)
    else
        if cam.CameraSubject == ImmortalCamAnchor then cam.CameraSubject = hum end
    end

    if Config.virexImmortalGodMode then
        local t  = tick()
        local sp = math.floor(t * 95) % 3
        local r  = 14
        pcall(function() setfflag("S2PhysicsSenderRate", "1333335") end)
        hrp.CFrame = hrp.CFrame + Vector3.new(0, 0.01, 0)
        local lv = hrp.CFrame.LookVector
        local rv = hrp.CFrame.RightVector
        local tri, vel = Vector3.zero, Vector3.zero
        if sp == 0 then tri = (-rv*r) + (lv*(r*0.5)); vel = -rv*350
        elseif sp == 1 then tri = (rv*r) + (lv*(r*0.5)); vel = rv*350
        else tri = -lv*r; vel = -lv*350 end
        local oldCF  = hrp.CFrame
        local oldVel = hrp.AssemblyLinearVelocity
        hrp.CFrame = oldCF * CFrame.new(tri)
        hrp.AssemblyLinearVelocity = vel
        RunService.RenderStepped:Wait()
        if hrp and hrp.Parent then hrp.CFrame = oldCF; hrp.AssemblyLinearVelocity = oldVel end

    elseif Config.ImmortalGodMode then
        local ang  = Config.ImmortalModeType == "Auto" and (145 + (0) * 2) or tonumber(Config.ImmortalCustomAngle) or 145
        local t    = tick()
        pcall(function() setfflag("S2PhysicsSenderRate", "1333335") end)
        hrp.CFrame = hrp.CFrame + Vector3.new(0, 0.01, 0)
        local ca   = t * math.pi * 2 * ang / 5
        local y    = (math.floor(t*135) % 2 == 0) and (Config.ImmortalHeightMin or -8) or (Config.ImmortalHeightMax or 35)
        local rad  = Config.ImmortalCustomRadius or 10
        local off  = Vector3.new(math.cos(ca)*rad, y, math.sin(ca)*rad)
        local oldCF = hrp.CFrame; local oldVel = hrp.AssemblyLinearVelocity
        hrp.CFrame = oldCF + off
        hrp.AssemblyLinearVelocity = Vector3.new(math.sin(ca)*250, y == (Config.ImmortalHeightMax or 35) and 280 or -280, math.cos(ca)*250)
        RunService.RenderStepped:Wait()
        if hrp and hrp.Parent then hrp.CFrame = oldCF; hrp.AssemblyLinearVelocity = oldVel end
    end
end)

if shared._EndlessOrbitBind then shared._EndlessOrbitBind:Disconnect() end
shared._EndlessOrbitBind = RunService.Heartbeat:Connect(function()
    if not Config.CharOrbitEnabled then return end
    pcall(function()
        local char = LP.Character
        local hrp  = char and char:FindFirstChild("HumanoidRootPart")
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum or hum.Health <= 0 then return end
        local ball = Auto_Parry.Get_Ball()
        if not ball or not ball.Parent then return end
        hrp.AssemblyLinearVelocity = Vector3.zero
        local speed = Config.CharOrbitSpeed   or 5
        local dist  = Config.CharOrbitDistance or 12
        _G.EHOrbitAngle = _G.EHOrbitAngle + speed * 0.02
        local co = math.cos(_G.EHOrbitAngle) * dist
        local si = math.sin(_G.EHOrbitAngle) * dist
        local axis = (Config.CharOrbitAxis or "Y"):upper()
        local off = axis == "X" and Vector3.new(0, co, si)
                 or axis == "Z" and Vector3.new(co, si, 0)
                 or axis == "XY" and Vector3.new(co, co, si)
                 or Vector3.new(co, 0, si)
        hrp.CFrame = CFrame.lookAt(ball.Position + off, ball.Position)
    end)
end)

--==========================================================
-- WALK SPEED / JUMP / FLY
--==========================================================
local _defaultWalkSpeed = 35
local _defaultJumpPower = 50
local _flyBodyVelocity  = nil
local _flyConn          = nil

local function GetHum()
    local c = LP.Character
    return c and c:FindFirstChildOfClass("Humanoid")
end

LP.CharacterAdded:Connect(function(char)
    task.wait(1)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    _defaultWalkSpeed = hum.WalkSpeed
    _defaultJumpPower = hum.JumpPower
    if Config.WalkSpeedEnabled then hum.WalkSpeed = Config.WalkSpeedValue end
    if Config.JumpPowerEnabled  then hum.JumpPower = Config.JumpPowerValue  end
end)

if shared._EndlessStatBind then shared._EndlessStatBind:Disconnect() end
shared._EndlessStatBind = RunService.Heartbeat:Connect(function()
    local hum = GetHum(); if not hum then return end
    if Config.WalkSpeedEnabled and hum.WalkSpeed ~= Config.WalkSpeedValue then hum.WalkSpeed = Config.WalkSpeedValue end
    if Config.JumpPowerEnabled  and hum.JumpPower ~= Config.JumpPowerValue  then hum.JumpPower = Config.JumpPowerValue  end
end)

local function StartFly()
    Config.FlyEnabled = true
    local char = LP.Character or LP.CharacterAdded:Wait()
    local hrp  = char:WaitForChild("HumanoidRootPart", 10); if not hrp then return end
    local hum  = char:FindFirstChildOfClass("Humanoid"); if not hum then return end
    
    hum.PlatformStand = true
    
    -- เคลียร์ของเก่าก่อนสร้างใหม่เพื่อป้องกันบั๊ก
    if _flyBodyVelocity then _flyBodyVelocity:Destroy() end
    if _flyGyroInstance then _flyGyroInstance:Destroy() end
    if _flyConn then _flyConn:Disconnect() end
    
    -- สร้างแรงขับเคลื่อน (Velocity)
    _flyBodyVelocity = Instance.new("BodyVelocity")
    _flyBodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    _flyBodyVelocity.Velocity = Vector3.zero
    _flyBodyVelocity.Parent   = hrp
    
    -- สร้าง Gyro เพื่อล็อกมุมมองตัวละครตามมุมกล้อง
    _flyGyroInstance = Instance.new("BodyGyro")
    _flyGyroInstance.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    _flyGyroInstance.P = 9e4
    _flyGyroInstance.Parent = hrp
    
    _flyConn = RunService.RenderStepped:Connect(function()
        if not Config.FlyEnabled or not hrp or not hum or not _flyBodyVelocity then return end
        
        hum.PlatformStand = true
        local cam = workspace.CurrentCamera
        _flyGyroInstance.CFrame = cam.CFrame
        
        local moveVector = Vector3.zero
        local controlModule = nil
        
        -- พยายามดึงค่าทิศทางจากการกดปุ่มเดิน/จอยสติ๊กบนมือถือ
        pcall(function()
            controlModule = require(LP.PlayerScripts:FindFirstChild("PlayerModule"):FindFirstChild("ControlModule"))
        end)
        
        if controlModule and controlModule.GetMoveVector then
            local rawVector = controlModule:GetMoveVector()
            moveVector = Vector3.new(rawVector.X, 0, rawVector.Z)
        else
            moveVector = hum.MoveDirection
        end
        
        -- หากไม่มีการเคลื่อนไหวบนหน้าจอ ให้เช็คปุ่มจากคีย์บอร์ดสำรองไว้ (Cross-Platform)
        if moveVector.Magnitude == 0 then
            if UIS:IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + Vector3.new(0, 0, -1) end
            if UIS:IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector + Vector3.new(0, 0, 1) end
            if UIS:IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector + Vector3.new(-1, 0, 0) end
            if UIS:IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + Vector3.new(1, 0, 0) end
        end
        
        local sp = Config.FlySpeed or 50
        local direction = cam.CFrame:VectorToWorldSpace(moveVector)
        local verticalVel = 0
        
        -- เพิ่มระบบเช็คปุ่มลอยขึ้น-ลงสำหรับคีย์บอร์ด
        if UIS:IsKeyDown(Enum.KeyCode.Space) then verticalVel = sp end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then verticalVel = -sp end
        
        -- คำนวณความเร็วและทิศทางบินตามมุมกล้องที่หันไป
        _flyBodyVelocity.Velocity = (direction * sp) + Vector3.new(0, verticalVel, 0)
    end)
end

local function StopFly()
    Config.FlyEnabled = false
    if _flyConn then _flyConn:Disconnect(); _flyConn = nil end
    if _flyBodyVelocity then _flyBodyVelocity:Destroy(); _flyBodyVelocity = nil end
    if _flyGyroInstance then _flyGyroInstance:Destroy(); _flyGyroInstance = nil end
    
    -- คืนค่าให้ผู้เล่นกลับมายืนและเดินได้ตามปกติ
    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then 
        hum.PlatformStand = false 
    end
end

--==========================================================
-- PERFORMANCE ANTI-LAG SYSTEM (FIXED & ENHANCED)
--==========================================================
local Debris = cloneref(game:GetService("Debris")) -- 🌟 ดึง Service มาให้ถูกต้อง
Config.AntiLagEnabled = false
Config.AntiLagFPSThreshold = 30
shared.AntiLagApplied = false
shared.FpsTimeCounter = 0
shared.FpsFrameCounter = 0
shared.CurrentFpsValue = 60

if shared._EndlessAntiLagBind then 
    shared._EndlessAntiLagBind:Disconnect() 
end

shared._EndlessAntiLagBind = RunService.RenderStepped:Connect(function(dt)
    xpcall(function()
        if not shared._EndlessRunning or not Config.AntiLagEnabled then
            if shared.AntiLagApplied then
                shared.AntiLagApplied = false
                local effectScript = LP.PlayerScripts:FindFirstChild("EffectScripts") and LP.PlayerScripts.EffectScripts:FindFirstChild("ClientFX")
                if effectScript then effectScript.Disabled = false end
            end
            return
        end

        shared.FpsFrameCounter = shared.FpsFrameCounter + 1
        shared.FpsTimeCounter = shared.FpsTimeCounter + dt

        -- อัปเดตเช็คทุก ๆ 0.5 วินาที (ลดโหลดของ CPU)
        if shared.FpsTimeCounter >= 0.5 then
            shared.CurrentFpsValue = shared.FpsFrameCounter / shared.FpsTimeCounter
            shared.FpsFrameCounter = 0
            shared.FpsTimeCounter = 0

            local fpsTargetLimit = tonumber(Config.AntiLagFPSThreshold) or 30

            if not shared.AntiLagApplied then
                if shared.CurrentFpsValue < fpsTargetLimit then
                    shared.AntiLagApplied = true
                    
                    -- 1. ปิดสคริปต์เอฟเฟกต์ (ตรวจเช็คแบบปลอดภัย)
                    local effectScript = LP.PlayerScripts:FindFirstChild("EffectScripts") and LP.PlayerScripts.EffectScripts:FindFirstChild("ClientFX")
                    if effectScript then effectScript.Disabled = true end
                    
                    -- 2. ลบโมเดลขยะในโฟลเดอร์ Runtime ออกจริง ๆ
                    local bcFolder = workspace:FindFirstChild("Runtime")
                    if bcFolder then
                        for _, child in pairs(bcFolder:GetChildren()) do
                            if child.Name ~= "FinisherCameraRig" then
                                Debris:AddItem(child, 0)
                            end
                        end
                    end
                    
                    -- 3. 🌟 [เพิ่มระบบเด็ด] ค้นหาและสั่งปิดอนิเมชั่นพาร์ติเคิล/แสงแฟลชทั้งหมดในฉากชั่วคราว
                    for _, v in ipairs(workspace:GetDescendants()) do
                        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                            v.Enabled = false
                        end
                    end
                    
                    print("Anti-Lag System: FPS dropped below threshold. Visual effects completely disabled.")
                end
            else
                -- เมื่อ FPS กลับมาเสถียร (สูงกว่าเกณฑ์ + 15) ให้เปิดเอฟเฟกต์กลับมาเหมือนเดิม
                if shared.CurrentFpsValue > (fpsTargetLimit + 15) then
                    shared.AntiLagApplied = false
                    
                    local effectScript = LP.PlayerScripts:FindFirstChild("EffectScripts") and LP.PlayerScripts.EffectScripts:FindFirstChild("ClientFX")
                    if effectScript then effectScript.Disabled = false end
                    
                    for _, v in ipairs(workspace:GetDescendants()) do
                        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                            v.Enabled = true
                        end
                    end
                    
                    print("Anti-Lag System: FPS restored. Normal graphics settings re-enabled.")
                end
            end
        end
    end, function(err)
        print("Endless Anti-Lag Core Bind Error: " .. tostring(err))
    end)
end)

--==========================================================
-- HEADLESS / KORBLOX
--==========================================================
local function ApplyHeadless(on)
    xpcall(function()
        local char = LP.Character; if not char then return end
        local head = char:FindFirstChild("Head")
        if head then
            head.Transparency = on and 1 or 0
            for _, d in pairs(head:GetChildren()) do
                if d:IsA("Decal") then d.Transparency = on and 1 or 0 end
            end
        end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        for _, acc in pairs(char:GetChildren()) do
            if acc:IsA("Accessory") then
                local h = acc:FindFirstChild("Handle")
                if h and hrp then
                    local relY = (h.Position - hrp.Position).Y
                    if relY > 0.8 then h.Transparency = on and 1 or 0 end
                end
            end
        end
    end, function() end)
end

local function ApplyKorblox(on)
    xpcall(function()
        local char = LP.Character; if not char then return end
        for _, p in pairs(char:GetChildren()) do
            local n = p.Name:lower()
            if p:IsA("BasePart") and (n == "leftleg" or n == "left leg" or n:find("leftlower") or n:find("leftfoot") or n:find("leftupper")) then
                p.Transparency = on and 1 or 0
            end
        end
    end, function() end)
end

LP.CharacterAdded:Connect(function()
    task.wait(0.8)
    if Config.HeadlessOn  then ApplyHeadless(true) end
    if Config.KorbloxOn   then ApplyKorblox(true)  end
    if Config.FlyEnabled  then StartFly()            end
end)

--==========================================================
-- SKIN CHANGER (from gui.txt — full implementation)
--==========================================================
getgenv().skinChanger    = false
getgenv().swordModel     = ""
getgenv().swordAnimations= ""
getgenv().swordFX        = ""

task.spawn(function()
    local swordInstancesModule = RS:WaitForChild("Shared",9e9):WaitForChild("ReplicatedInstances",9e9):WaitForChild("Swords",9e9)
    local swordInstances = require(swordInstancesModule)
    local swordsController = nil
    local hookedFuncs = {}

    task.spawn(function()
        while task.wait() and not swordsController do
            local ok, conns = pcall(getconnections, RS.Remotes.FireSwordInfo.OnClientEvent)
            if ok and conns then
                for _, v in ipairs(conns) do
                    if v.Function and islclosure and islclosure(v.Function) then
                        local ok2, up = pcall(getupvalues, v.Function)
                        if ok2 and #up == 1 and type(up[1]) == "table" then
                            swordsController = up[1]; break
                        end
                    end
                end
            end
        end
    end)

    local function getSlashName(n)
        local ok, r = pcall(function() return swordInstances:GetSword(n) end)
        return (ok and r and r.SlashName) or "SlashEffect"
    end

    local function refreshSlash()
        local fx = getgenv().swordFX ~= "" and getgenv().swordFX or getgenv().swordModel
        getgenv().slashName = fx ~= "" and getSlashName(fx) or "SlashEffect"
    end

    local function setSword()
        if not getgenv().skinChanger then return end
        local char = LP.Character; if not char then return end
        pcall(function()
            local f = rawget(swordInstances, "EquipSwordTo")
            if type(f) == "function" then
                local ups = getupvalues(f)
                for i = 1, #ups do if type(ups[i]) == "boolean" then setupvalue(f,i,false); break end end
            end
        end)
        pcall(function() swordInstances:EquipSwordTo(char, getgenv().swordModel) end)
        task.spawn(function()
            local tries = 0
            while not swordsController and tries < 20 do task.wait(0.5); tries = tries + 1 end
            if not swordsController then return end
            pcall(function()
                if swordsController.SetSword then swordsController:SetSword(getgenv().swordAnimations ~= "" and getgenv().swordAnimations or getgenv().swordModel) end
            end)
            pcall(function()
                local fx = getgenv().swordFX ~= "" and getgenv().swordFX or getgenv().swordModel
                if RS.Remotes:FindFirstChild("FireSwordInfo") then RS.Remotes.FireSwordInfo:FireServer(fx) end
                if swordsController.currentSword ~= nil then swordsController.currentSword = fx end
                if swordsController.SwordFX ~= nil then swordsController.SwordFX = fx end
            end)
        end)
    end

    -- Hook ParrySuccessAll for FX
    task.spawn(function()
        while task.wait(1) do
            local ok, conns = pcall(getconnections, RS.Remotes.ParrySuccessAll.OnClientEvent)
            if ok and type(conns) == "table" then
                for _, v in ipairs(conns) do
                    local fn = v.Function
                    if fn and not hookedFuncs[fn] then
                        hookedFuncs[fn] = true
                        if not (isourclosure and isourclosure(fn)) then
                            v:Disable()
                            local orig = fn
                            RS.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(...)
                                local args = {...}
                                if tostring(args[4]) == LP.Name and getgenv().skinChanger then
                                    refreshSlash()
                                    args[1] = getgenv().slashName
                                    args[3] = getgenv().swordFX ~= "" and getgenv().swordFX or getgenv().swordModel
                                end
                                if setthreadidentity then pcall(setthreadidentity, 2) end
                                pcall(orig, unpack(args))
                            end)
                        end
                    end
                end
            end
        end
    end)

    -- Persistent sync
    task.spawn(function()
        while task.wait(1) do
            if getgenv().skinChanger and getgenv().swordModel ~= "" then
                local char = LP.Character
                if char then
                    if LP:GetAttribute("CurrentlyEquippedSword") ~= getgenv().swordModel then setSword() end
                    if not char:FindFirstChild(getgenv().swordModel) then setSword() end
                    for _, v in ipairs(char:GetChildren()) do
                        if v:IsA("Model") and v.Name ~= getgenv().swordModel then v:Destroy() end
                        task.wait()
                    end
                end
            end
        end
    end)

    getgenv().updateSword = function() refreshSlash(); setSword() end

    LP.CharacterAdded:Connect(function()
        if not getgenv().skinChanger then return end
        getgenv().skinChanger = false; task.wait(1.5)
        getgenv().skinChanger = true;  task.wait(0.5)
        pcall(getgenv().updateSword)
    end)
end)

if shared._TriggerbotOverdriveThread then task.cancel(shared._TriggerbotOverdriveThread) end

shared._TriggerbotOverdriveThread = task.spawn(function()
    while shared._EndlessRunning do
        xpcall(function()
            if Config.TriggerbotShow and Config.TriggerbotActive then
                ball = type(Auto_Parry) == "table" and type(Auto_Parry.Get_Ball) == "function" and Auto_Parry.Get_Ball()
                
                if ball and ball.Parent then
                    targetAttr = ball:GetAttribute("target") or ball:GetAttribute("Target") or ""
                    isTargetingMe = (tostring(targetAttr) == LP.Name)
                    
                    if isTargetingMe and not parryLocked[ball] then
                        parryLocked[ball] = true
                        lockTime[ball] = os.clock()
                        lastHitTicks[ball] = os.clock()
                        
                        if type(Auto_Parry.FireParryRemote) == "function" then
                            pcall(Auto_Parry.FireParryRemote, false)
                        end
                    end
                end
            end
            task.wait()
        end, function(err)
            print("Triggerbot Independent Core Logic Error: " .. tostring(err))
        end)
    end
end)

--==========================================================
-- GUI LIBRARY  —  Roblox Backpack Slot × White/Black
--==========================================================
local GuiParent = (gethui and gethui()) or LP:WaitForChild("PlayerGui")
local OldGui    = GuiParent:FindFirstChild("EndlessHub_GUI")
if OldGui then OldGui:Destroy() end

-- ── Colors
local CW  = Color3.fromRGB(248, 248, 252)   -- near-white
local CB  = Color3.fromRGB(6,   6,  10)     -- near-black
local CG1 = Color3.fromRGB(10,  10,  15)    -- slot off bg
local CG2 = Color3.fromRGB(20,  20,  28)    -- panel bg
local CG3 = Color3.fromRGB(30,  30,  40)    -- hover
local CBR = Color3.fromRGB(50,  50,  62)    -- border off
local CGR = Color3.fromRGB(38,  38,  50)    -- sub-border

-- ── Util
local function Tw(obj, t, props)
    TweenService:Create(obj, TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end
local function Rnd(obj, r) local u=Instance.new("UICorner") u.CornerRadius=UDim.new(0,r or 8) u.Parent=obj end
local function Str(obj, col, th)
    local s=Instance.new("UIStroke") s.Color=col or CBR s.Thickness=th or 1
    s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border s.Parent=obj return s
end
local function Lbl(par, txt, sz, col, ax)
    local l=Instance.new("TextLabel") l.BackgroundTransparency=1 l.Text=txt l.TextSize=sz or 13
    l.TextColor3=col or CW l.Font=Enum.Font.GothamSemibold l.TextXAlignment=ax or Enum.TextXAlignment.Left l.Parent=par return l
end

-- ── ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name="EndlessHub_GUI" ScreenGui.ResetOnSpawn=false
ScreenGui.IgnoreGuiInset=true ScreenGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
ScreenGui.Parent=GuiParent

-- ── Main Frame  (gradient black → slightly lighter)
local Main = Instance.new("Frame")
Main.Name="Main" Main.Size=UDim2.fromOffset(570, 420)
Main.Position=UDim2.fromScale(0.5,0.5) Main.AnchorPoint=Vector2.new(0.5,0.5)
Main.BackgroundColor3=CG1 Main.ClipsDescendants=true Main.Parent=ScreenGui
Rnd(Main,10) Str(Main,CBR,1.5)

-- gradient
local grad=Instance.new("UIGradient")
grad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,CB),ColorSequenceKeypoint.new(1,CG2)})
grad.Rotation=90 grad.Parent=Main

-- ── Drag
do
    local d,ds,sp=false
    Main.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            d=true ds=i.Position sp=Main.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if d then
            local dl=i.Position-ds
            Main.Position=UDim2.new(sp.X.Scale,sp.X.Offset+dl.X,sp.Y.Scale,sp.Y.Offset+dl.Y)
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then d=false end
    end)
end

-- ── Header bar
local Header=Instance.new("Frame")
Header.Size=UDim2.new(1,0,0,46) Header.BackgroundTransparency=1 Header.Parent=Main

local TitleLbl=Lbl(Header,"ILLUSION",16,CW)
TitleLbl.Font=Enum.Font.GothamBlack
TitleLbl.Position=UDim2.fromOffset(14,0) TitleLbl.Size=UDim2.fromOffset(170,46)

-- subtle white underline accent on title
local TitleAccent=Instance.new("Frame")
TitleAccent.Size=UDim2.fromOffset(110,1.5) TitleAccent.Position=UDim2.fromOffset(14,42)
TitleAccent.BackgroundColor3=CW TitleAccent.BorderSizePixel=0 TitleAccent.Parent=Header

-- close
local CloseBtn=Instance.new("TextButton")
CloseBtn.Size=UDim2.fromOffset(26,26) CloseBtn.Position=UDim2.new(1,-36,0.5,-13)
CloseBtn.BackgroundColor3=CG3 CloseBtn.Text="×" CloseBtn.TextColor3=CW
CloseBtn.TextSize=16 CloseBtn.Font=Enum.Font.GothamBold CloseBtn.AutoButtonColor=false CloseBtn.Parent=Header
Rnd(CloseBtn,5) Str(CloseBtn,CBR,1)
CloseBtn.MouseButton1Click:Connect(function() Main.Visible=false end)

-- ── TAB BAR  (Roblox backpack slot style)
local TabBar=Instance.new("Frame")
TabBar.Size=UDim2.new(1,-14,0,34) TabBar.Position=UDim2.fromOffset(7,48)
TabBar.BackgroundTransparency=1 TabBar.Parent=Main

local TabBarLayout=Instance.new("UIListLayout")
TabBarLayout.FillDirection=Enum.FillDirection.Horizontal
TabBarLayout.HorizontalAlignment=Enum.HorizontalAlignment.Left
TabBarLayout.VerticalAlignment=Enum.VerticalAlignment.Center
TabBarLayout.Padding=UDim.new(0,4) TabBarLayout.Parent=TabBar

-- ── Content area
local Content=Instance.new("Frame")
Content.Size=UDim2.new(1,0,1,-86) Content.Position=UDim2.fromOffset(0,86)
Content.BackgroundTransparency=1 Content.Parent=Main

-- ── Tab system
local Tabs={} local TabPages={} local ActiveTab=nil

local function CreateTab(name, label)
    -- The tab button looks like a Roblox backpack slot
    local Btn=Instance.new("TextButton")
    Btn.Size=UDim2.fromOffset(84,30) Btn.BackgroundColor3=CG1
    Btn.Text=label Btn.TextColor3=Color3.fromRGB(160,160,175)
    Btn.TextSize=11 Btn.Font=Enum.Font.GothamBold
    Btn.AutoButtonColor=false Btn.Parent=TabBar
    Rnd(Btn,6)
    local st=Str(Btn,CBR,1.2)

    local Page=Instance.new("ScrollingFrame")
    Page.Size=UDim2.new(1,-14,1,0) Page.Position=UDim2.fromOffset(7,0)
    Page.BackgroundTransparency=1 Page.BorderSizePixel=0
    Page.ScrollBarThickness=3 Page.ScrollBarImageColor3=CW
    Page.CanvasSize=UDim2.new(0,0,0,0) Page.AutomaticCanvasSize=Enum.AutomaticSize.Y
    Page.Visible=false Page.Parent=Content

    local PL=Instance.new("UIListLayout")
    PL.Padding=UDim.new(0,5) PL.SortOrder=Enum.SortOrder.LayoutOrder PL.Parent=Page
    local PP=Instance.new("UIPadding")
    PP.PaddingTop=UDim.new(0,6) PP.PaddingBottom=UDim.new(0,10) PP.Parent=Page

    Tabs[name]={Btn=Btn,Stroke=st}
    TabPages[name]=Page

    Btn.MouseButton1Click:Connect(function()
        if ActiveTab then
            TabPages[ActiveTab].Visible=false
            Tw(Tabs[ActiveTab].Btn,0.1,{BackgroundColor3=CG1,TextColor3=Color3.fromRGB(160,160,175)})
            Tabs[ActiveTab].Stroke.Color=CBR
        end
        ActiveTab=name
        Page.Visible=true
        Tw(Btn,0.1,{BackgroundColor3=CW,TextColor3=CB})
        st.Color=CW
    end)

    return name
end

-- ── GUI COMPONENTS

local function Divider(page, text)
    local H=Instance.new("Frame") H.Size=UDim2.new(1,0,0,22) H.BackgroundTransparency=1 H.Parent=TabPages[page]
    local Line=Instance.new("Frame") Line.Size=UDim2.new(1,0,0,1) Line.Position=UDim2.fromOffset(0,11)
    Line.BackgroundColor3=CBR Line.BorderSizePixel=0 Line.Parent=H
    if text and text ~= "" then
        local bg=Instance.new("Frame") bg.Size=UDim2.fromOffset(#text*7+16,18) bg.Position=UDim2.new(0.5,-(#text*7+16)/2,0,2)
        bg.BackgroundColor3=CG1 bg.BorderSizePixel=0 bg.Parent=H
        local l=Lbl(bg," "..text.." ",10,Color3.fromRGB(140,140,160),Enum.TextXAlignment.Center)
        l.Size=UDim2.fromScale(1,1) l.Font=Enum.Font.GothamBold
    end
end

-- SLOT TOGGLE — the toggle itself IS the button (Roblox backpack style)
function SlotToggle(page, label, default, callback)
    local stateKey = label:gsub("%s+", "")
    if Config[stateKey] == nil then
        Config[stateKey] = default or false
    end
    local val = Config[stateKey]
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 40)
    Row.BackgroundColor3 = CG1
    Row.Parent = TabPages[page]
    Rnd(Row, 7)
    local st = Str(Row, CBR, 1.2)

    local L = Lbl(Row, label, 13, CW)
    L.Position = UDim2.fromOffset(12, 0)
    L.Size = UDim2.new(1, -80, 1, 0)

    local Slot = Instance.new("Frame")
    Slot.Size = UDim2.fromOffset(48, 26)
    Slot.Position = UDim2.new(1, -58, 0.5, -13)
    Slot.BackgroundColor3 = CG3
    Slot.Parent = Row
    Rnd(Slot, 5)
    local SlotStr = Str(Slot, CBR, 1)

    local SlotLbl = Lbl(Slot, "OFF", 10, Color3.fromRGB(110, 110, 125), Enum.TextXAlignment.Center)
    SlotLbl.Size = UDim2.fromScale(1, 1)
    SlotLbl.Font = Enum.Font.GothamBold

    local function Upd()
        if val then
            Tw(Row, 0.12, {BackgroundColor3 = CW})
            Tw(L, 0.12, {TextColor3 = CB})
            Tw(Slot, 0.12, {BackgroundColor3 = CB})
            Tw(SlotLbl, 0.12, {TextColor3 = CW})
            SlotLbl.Text = "ON"
            st.Color = CW
        else
            Tw(Row, 0.12, {BackgroundColor3 = CG1})
            Tw(L, 0.12, {TextColor3 = CW})
            Tw(Slot, 0.12, {BackgroundColor3 = CG3})
            Tw(SlotLbl, 0.12, {TextColor3 = Color3.fromRGB(110, 110, 125)})
            SlotLbl.Text = "OFF"
            st.Color = CBR
        end
        Config[stateKey] = val
        if callback then
            xpcall(function()
                callback(val)
            end, function(err)
                print("Illusion Toggle Callback Execution Error: " .. tostring(err))
            end)
        end
    end

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.fromScale(1, 1)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""
    Btn.Parent = Row
    Btn.MouseButton1Click:Connect(function()
        val = not val
        Upd()
    end)
    Upd()

    task.spawn(function()
        while shared._EndlessRunning do
            task.wait(1)
            if Config[stateKey] ~= nil and Config[stateKey] ~= val then
                val = Config[stateKey]
                Upd()
            end
        end
    end)

    return {
        Set = function(_, v)
            val = v
            Upd()
        end,
        Get = function()
            return val
        end,
    }
end

-- SELECT (dropdown)
function SlotSelect(page, label, options, callback)
    local stateKey = label:gsub("%s+", "")
    if Config[stateKey] == nil then
        Config[stateKey] = options[1]
    end
    local sel = Config[stateKey]
    
    local H = Instance.new("Frame")
    H.Size = UDim2.new(1, 0, 0, 40)
    H.BackgroundColor3 = CG1
    H.Parent = TabPages[page]
    Rnd(H, 7)
    Str(H, CBR, 1.2)

    local L = Lbl(H, label, 12, CW)
    L.Position = UDim2.fromOffset(12, 0)
    L.Size = UDim2.new(1, -160, 1, 0)

    local SelBtn = Instance.new("TextButton")
    SelBtn.Size = UDim2.fromOffset(138, 28)
    SelBtn.Position = UDim2.new(1, -148, 0.5, -14)
    SelBtn.BackgroundColor3 = CG3
    SelBtn.Text = tostring(sel) .. " ▾"
    SelBtn.TextColor3 = CW
    SelBtn.TextSize = 11
    SelBtn.Font = Enum.Font.GothamSemibold
    SelBtn.AutoButtonColor = false
    SelBtn.Parent = H
    Rnd(SelBtn, 5)
    Str(SelBtn, CBR, 1)

    local Drop = Instance.new("ScrollingFrame")
    Drop.Size = UDim2.fromOffset(138, 0)
    Drop.BackgroundColor3 = CG2
    Drop.Visible = false
    Drop.ZIndex = 50
    Drop.Parent = ScreenGui
    Rnd(Drop, 6)
    Str(Drop, CBR, 1)
    Drop.ScrollBarThickness = 3
    Drop.ScrollBarImageColor3 = CW
    Drop.BorderSizePixel = 0
    Drop.CanvasSize = UDim2.new(0, 0, 0, 0)
    Drop.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local DL = Instance.new("UIListLayout")
    DL.Padding = UDim.new(0, 2)
    DL.Parent = Drop

    local DP = Instance.new("UIPadding")
    DP.PaddingTop = UDim.new(0, 4)
    DP.PaddingLeft = UDim.new(0, 4)
    DP.PaddingRight = UDim.new(0, 4)
    DP.PaddingBottom = UDim.new(0, 4)
    DP.Parent = Drop

    for _, opt in ipairs(options) do
        local OBtn = Instance.new("TextButton")
        OBtn.Size = UDim2.new(1, 0, 0, 28)
        OBtn.BackgroundColor3 = CG1
        OBtn.Text = tostring(opt)
        OBtn.TextColor3 = CW
        OBtn.TextSize = 11
        OBtn.Font = Enum.Font.GothamSemibold
        OBtn.AutoButtonColor = false
        OBtn.ZIndex = 51
        OBtn.Parent = Drop
        Rnd(OBtn, 5)
        
        OBtn.MouseEnter:Connect(function() 
            Tw(OBtn, .08, {BackgroundColor3 = CG3}) 
        end)
        OBtn.MouseLeave:Connect(function() 
            Tw(OBtn, .08, {BackgroundColor3 = CG1}) 
        end)
        
        OBtn.MouseButton1Click:Connect(function()
            sel = opt
            Config[stateKey] = opt
            SelBtn.Text = tostring(opt) .. " ▾"
            Tw(Drop, .1, {Size = UDim2.fromOffset(138, 0)})
            task.delay(.1, function() 
                Drop.Visible = false 
            end)
            if callback then 
                xpcall(function()
                    callback(opt)
                end, function(err)
                    print("Illusion Dropdown Callback Execution Error: " .. tostring(err))
                end)
            end
        end)
    end

    SelBtn.MouseButton1Click:Connect(function()
        if Drop.Visible then
            Tw(Drop, .1, {Size = UDim2.fromOffset(138, 0)})
            task.delay(.1, function() 
                Drop.Visible = false 
            end)
        else
            absPos = SelBtn.AbsolutePosition
            absSize = SelBtn.AbsoluteSize
            Drop.Position = UDim2.fromOffset(absPos.X, absPos.Y + absSize.Y + 3)
            targetHeight = (#options * 30) + 8
            maxHeight = math.min(targetHeight, 150)
            Drop.Size = UDim2.fromOffset(138, 0)
            Drop.Visible = true
            Tw(Drop, .15, {Size = UDim2.fromOffset(138, maxHeight)})
        end
    end)

    task.spawn(function()
        while shared._EndlessRunning do
            task.wait(1)
            if Config[stateKey] ~= nil and Config[stateKey] ~= sel then
                sel = Config[stateKey]
                SelBtn.Text = tostring(sel) .. " ▾"
            end
        end
    end)

    return { 
        Get = function() return sel end, 
        Set = function(_, v) 
            sel = v 
            Config[stateKey] = v
            SelBtn.Text = tostring(v) .. " ▾" 
        end 
    }
end

-- SLIDER
function SlotSlider(page, label, min, max, default, onChange)
    local stateKey = label:gsub("%s+", "")
    if Config[stateKey] == nil then
        Config[stateKey] = default
    end
    local val = Config[stateKey]
    
    local H = Instance.new("Frame")
    H.Size = UDim2.new(1, 0, 0, 58)
    H.BackgroundColor3 = CG1
    H.Parent = TabPages[page]
    Rnd(H, 7)
    Str(H, CBR, 1.2)
    
    local L = Lbl(H, label, 12, CW)
    L.Position = UDim2.fromOffset(12, 6)
    L.Size = UDim2.new(1, -70, 0, 18)
    
    local VL = Lbl(H, tostring(val), 11, Color3.fromRGB(200, 200, 215), Enum.TextXAlignment.Right)
    VL.Position = UDim2.new(1, -58, 0, 6)
    VL.Size = UDim2.fromOffset(48, 18)
    
    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1, -24, 0, 5)
    Track.Position = UDim2.fromOffset(12, 36)
    Track.BackgroundColor3 = CG3
    Track.Parent = H
    Rnd(Track, 4)
    
    local Fill = Instance.new("Frame")
    Fill.BackgroundColor3 = CW
    Fill.Size = UDim2.new((val - min) / (max - min), 0, 1, 0)
    Fill.Parent = Track
    Rnd(Fill, 4)
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.fromOffset(12, 12)
    Knob.AnchorPoint = Vector2.new(0.5, 0.5)
    Knob.Position = UDim2.new((val - min) / (max - min), 0, 0.5, 0)
    Knob.BackgroundColor3 = CW
    Knob.Parent = Track
    Rnd(Knob, 20)
    
    local drg = false
    
    local function Upd(px)
        local pct = math.clamp((px - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
        val = math.floor(min + (max - min) * pct)
        Config[stateKey] = val
        Fill.Size = UDim2.new(pct, 0, 1, 0)
        Knob.Position = UDim2.new(pct, 0, 0.5, 0)
        VL.Text = tostring(val)
        if onChange then
            xpcall(function()
                onChange(val)
            end, function(err)
                print("Illusion Slider Callback Execution Error: " .. tostring(err))
            end)
        end
    end
    
    Track.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            drg = true
            Upd(i.Position.X)
        end
    end)
    
    UIS.InputChanged:Connect(function(i)
        if drg and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            Upd(i.Position.X)
        end
    end)
    
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            drg = false
        end
    end)
    
    task.spawn(function()
        while shared._EndlessRunning do
            task.wait(1)
            if Config[stateKey] ~= nil and Config[stateKey] ~= val then
                val = Config[stateKey]
                local pct = math.clamp((val - min) / (max - min), 0, 1)
                Fill.Size = UDim2.new(pct, 0, 1, 0)
                Knob.Position = UDim2.new(pct, 0, 0.5, 0)
                VL.Text = tostring(val)
            end
        end
    end)
    
    return {
        Get = function()
            return val
        end,
        Set = function(_, v)
            val = v
            Config[stateKey] = v
            local p = (v - min) / (max - min)
            Fill.Size = UDim2.new(p, 0, 1, 0)
            Knob.Position = UDim2.new(p, 0, 0.5, 0)
            VL.Text = tostring(v)
            if onChange then
                xpcall(function()
                    onChange(v)
                end, function(err)
                    print("Illusion Slider Set Execution Error: " .. tostring(err))
                end)
            end
        end
    }
end

-- TEXTBOX
function SlotTextbox(page, label, placeholder, callback)
    stateKey = label:gsub("%s+", "")
    if Config[stateKey] == nil then
        Config[stateKey] = ""
    end
    
    H = Instance.new("Frame")
    H.Size = UDim2.new(1, 0, 0, 0)
    H.AutomaticSize = Enum.AutomaticSize.Y
    H.BackgroundColor3 = CG1
    H.Parent = TabPages[page]
    Rnd(H, 7)
    Str(H, CBR, 1.2)
    
    HL = Instance.new("UIListLayout")
    HL.SortOrder = Enum.SortOrder.LayoutOrder
    HL.Padding = UDim.new(0, 4)
    HL.Parent = H
    
    HP = Instance.new("UIPadding")
    HP.PaddingTop = UDim.new(0, 8)
    HP.PaddingLeft = UDim.new(0, 10)
    HP.PaddingRight = UDim.new(0, 10)
    HP.PaddingBottom = UDim.new(0, 8)
    HP.Parent = H
    
    L = Lbl(H, label, 11, Color3.fromRGB(155, 155, 170))
    L.Size = UDim2.new(1, 0, 0, 14)
    L.LayoutOrder = 1
    
    Box = Instance.new("TextBox")
    Box.Size = UDim2.new(1, 0, 0, 30)
    Box.BackgroundColor3 = CG2
    Box.TextColor3 = CW
    Box.PlaceholderColor3 = Color3.fromRGB(80, 80, 95)
    Box.PlaceholderText = placeholder or ""
    Box.Text = tostring(Config[stateKey])
    Box.TextSize = 12
    Box.Font = Enum.Font.GothamSemibold
    Box.ClearTextOnFocus = false
    Box.LayoutOrder = 2
    Box.Parent = H
    Rnd(Box, 5)
    Str(Box, CBR, 1)
    
    BP2 = Instance.new("UIPadding")
    BP2.PaddingLeft = UDim.new(0, 8)
    BP2.Parent = Box
    
    Box.FocusLost:Connect(function(enter)
        Config[stateKey] = Box.Text
        if callback then
            xpcall(function()
                callback(Box.Text, enter)
            end, function(err)
                print("Illusion Textbox Callback Execution Error: " .. tostring(err))
            end)
        end
    end)
    
    task.spawn(function()
        while shared._EndlessRunning do
            task.wait(1)
            if not Box:IsFocused() then
                if Config[stateKey] ~= nil and Box.Text ~= tostring(Config[stateKey]) then
                    Box.Text = tostring(Config[stateKey])
                end
            end
        end
    end)
    
    return Box
end

-- ACTION BUTTON
local function SlotButton(page, label, callback)
    local Btn=Instance.new("TextButton")
    Btn.Size=UDim2.new(1,0,0,38) Btn.BackgroundColor3=CG3
    Btn.Text=label Btn.TextColor3=CW Btn.TextSize=12 Btn.Font=Enum.Font.GothamBold
    Btn.AutoButtonColor=false Btn.Parent=TabPages[page] Rnd(Btn,7)
    local st=Str(Btn,CBR,1.2)
    Btn.MouseEnter:Connect(function() Tw(Btn,.08,{BackgroundColor3=CW,TextColor3=CB}); st.Color=CW end)
    Btn.MouseLeave:Connect(function() Tw(Btn,.08,{BackgroundColor3=CG3,TextColor3=CW}); st.Color=CBR end)
    Btn.MouseButton1Click:Connect(function() if callback then pcall(callback) end end)
    return Btn
end

--==========================================================
-- FLOATING PARRY SPAM BUTTON (SINGLE PRESS TOGGLE SYSTEM)
--==========================================================
Config.FloatSpamDraggable = true -- 🌟 เพิ่มตัวตั้งค่า: true = ลากได้, false = ล็อกตำแหน่งลากไม่ได้

local SpamFloatBtn = Instance.new("ImageButton")
SpamFloatBtn.Size = UDim2.fromOffset(120, 40)
SpamFloatBtn.Position = UDim2.new(0, 8, 0.5, 0)
SpamFloatBtn.BackgroundColor3 = Color3.fromRGB(248, 248, 252) -- สีขาวเริ่มต้น (สถานะ OFF)
SpamFloatBtn.Image = ""
SpamFloatBtn.AutoButtonColor = false
SpamFloatBtn.ZIndex = 999
SpamFloatBtn.Visible = false 
SpamFloatBtn.Parent = ScreenGui

local SpamRnd = Instance.new("UICorner")
SpamRnd.CornerRadius = UDim.new(0, 9)
SpamRnd.Parent = SpamFloatBtn

local SpamFBS = Instance.new("UIStroke")
SpamFBS.Color = Color3.fromRGB(6, 6, 10)
SpamFBS.Thickness = 1.5
SpamFBS.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
SpamFBS.Parent = SpamFloatBtn

local SpamFBLabel = Instance.new("TextLabel")
SpamFBLabel.BackgroundTransparency = 1
SpamFBLabel.Text = "SPAM: 0"
SpamFBLabel.TextSize = 11
SpamFBLabel.TextColor3 = Color3.fromRGB(6, 6, 10)
SpamFBLabel.Font = Enum.Font.GothamBlack
SpamFBLabel.TextXAlignment = Enum.TextXAlignment.Center
SpamFBLabel.Size = UDim2.fromScale(1, 1)
SpamFBLabel.Parent = SpamFloatBtn

-- ── ฟังก์ชันอัปเดตสีสันของปุ่มตามสถานะเปิด/ปิดจริง
local function UpdateSpamButtonVisual(isActive)
    if isActive then
        Tw(SpamFloatBtn, 0.08, {BackgroundColor3 = Color3.fromRGB(30, 30, 40)})
        Tw(SpamFBLabel, 0.08, {TextColor3 = Color3.fromRGB(248, 248, 252)})
        SpamFBS.Color = Color3.fromRGB(248, 248, 252)
    else
        Tw(SpamFloatBtn, 0.08, {BackgroundColor3 = Color3.fromRGB(248, 248, 252)})
        Tw(SpamFBLabel, 0.08, {TextColor3 = Color3.fromRGB(6, 6, 10)})
        SpamFBS.Color = Color3.fromRGB(6, 6, 10)
    end
end

-- ── ระบบคำนวณค่า FPS × 5 เรียลไทม์
local fpsCount = 0
local lastFpsTick = os.clock()

Config.SpamFpsMultiplier = 5

if shared._EndlessSpamFPSBind then 
    shared._EndlessSpamFPSBind:Disconnect() 
end

shared._EndlessSpamFPSBind = RunService.RenderStepped:Connect(function()
    xpcall(function()
        fpsCount = fpsCount + 1
        now = os.clock()
        if now - lastFpsTick >= 0.5 then
            currentFps = math.floor(fpsCount / (now - lastFpsTick))
            currentMultiplier = tonumber(Config.SpamFpsMultiplier) or 5
            calculatedValue = currentFps * currentMultiplier
            if SpamFBLabel then
                SpamFBLabel.Text = "SPAM: " .. tostring(calculatedValue)
            end
            fpsCount = 0
            lastFpsTick = now
        end
    end, function(err)
        print("Endless Spam FPS Counter Display Error: " .. tostring(err))
    end)
end)

-- ── ระบบลากย้ายปุ่มด้วย Safe-Guard + สลับโหมดเปิด/ปิดจากการคลิกทีเดียว (แก้ไขให้เปิด-ปิดการลากได้)
do
    d = false
    ds = nil
    sp = nil
    moved = false
    
    SpamFloatBtn.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            d = true 
            moved = false 
            ds = inp.Position 
            sp = SpamFloatBtn.Position
        end
    end)
    
    UIS.InputChanged:Connect(function(inp)
        if not d then return end
        -- 🌟 ตรวจสอบเงื่อนไขเพิ่มเติม: จะลากได้เมื่อ Config.FloatSpamDraggable เป็น true เท่านั้น
        if Config.FloatSpamDraggable and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            dl = inp.Position - ds
            if dl.Magnitude > 5 then 
                moved = true 
            end
            if moved then
                vp = workspace.CurrentCamera.ViewportSize
                SpamFloatBtn.Position = UDim2.new(sp.X.Scale, math.clamp(sp.X.Offset+dl.X, 0, vp.X-130), sp.Y.Scale, math.clamp(sp.Y.Offset+dl.Y, 0, vp.Y-50))
            end
        end
    end)
    
    SpamFloatBtn.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            if d then
                d = false
                if not moved then 
                    targetState = not shared.ManualSpamActive
                    shared.ManualSpamActive = targetState                    
                    UpdateSpamButtonVisual(targetState)
                end
            end
        end
    end)
end

-- สลับสถานะปุ่มคีย์ลัด E ให้เปิดปิดสแปมและเปลี่ยนสี โดยไม่ไปซ่อนปุ่มลอยเช่นกัน
if shared._EndlessKeybindE_Spam then shared._EndlessKeybindE_Spam:Disconnect() end
shared._EndlessKeybindE_Spam = UIS.InputBegan:Connect(function(inp, gp)
    if gp then return end
    if inp.KeyCode == Enum.KeyCode.E and SpamFloatBtn.Visible then
        targetState = not shared.ManualSpamActive
        shared.ManualSpamActive = targetState
        UpdateSpamButtonVisual(targetState)
    end
end)

-- ฟังก์ชันโกลบอลรับคำสั่งจาก GUI หลัก (ใช้เปิด/ปิด และล้างสถานะสแปมทั้งหมดเมื่อสั่งปิดจากเมนูหลักเท่านั้น)
getgenv().ToggleFloatSpamButton = function(state)
    xpcall(function()
        if SpamFloatBtn then
            SpamFloatBtn.Visible = state
            if not state then
                shared.ManualSpamActive = false
                UpdateSpamButtonVisual(false)
            end
        end
    end, function(err)
        print("Global Float Button Toggle Signal Error: " .. tostring(err))
    end)
end

OASpamFloatBtn = Instance.new("TextButton", ScreenGui)
OASpamFloatBtn.Name = "Endless_OASpamBtn"
OASpamFloatBtn.Size = UDim2.fromOffset(120, 40)
OASpamFloatBtn.Position = UDim2.new(0, 8, 0.8, 0)
OASpamFloatBtn.BackgroundColor3 = Color3.fromRGB(248, 248, 252)
OASpamFloatBtn.Text = "OA SPAM: OFF"
OASpamFloatBtn.TextColor3 = Color3.fromRGB(6, 6, 10)
OASpamFloatBtn.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
OASpamFloatBtn.TextSize = 11
OASpamFloatBtn.Visible = false
OASpamFloatBtn.AutoButtonColor = false
Instance.new("UICorner", OASpamFloatBtn).CornerRadius = UDim.new(0, 9)

OASpamFBS = Instance.new("UIStroke", OASpamFloatBtn)
OASpamFBS.Color = Color3.fromRGB(6, 6, 10)
OASpamFBS.Thickness = 1.5
OASpamFBS.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

function UpdateOASpamButtonVisual(isActive)
    xpcall(function()
        if isActive then
            TweenService:Create(OASpamFloatBtn, TweenInfo.new(0.08), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
            TweenService:Create(OASpamFloatBtn, TweenInfo.new(0.08), {TextColor3 = Color3.fromRGB(248, 248, 252)}):Play()
            OASpamFloatBtn.Text = "OA SPAM: ON"
            OASpamFBS.Color = Color3.fromRGB(248, 248, 252)
        else
            TweenService:Create(OASpamFloatBtn, TweenInfo.new(0.08), {BackgroundColor3 = Color3.fromRGB(248, 248, 252)}):Play()
            TweenService:Create(OASpamFloatBtn, TweenInfo.new(0.08), {TextColor3 = Color3.fromRGB(6, 6, 10)}):Play()
            OASpamFloatBtn.Text = "OA SPAM: OFF"
            OASpamFBS.Color = Color3.fromRGB(6, 6, 10)
        end
    end, function(err)
        print("Update OA Spam Visual Signal Error: " .. tostring(err))
    end)
end

do
    dragOA, dsOA, spOA, movedOA = false, nil, nil, false
    
    OASpamFloatBtn.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragOA = true movedOA = false dsOA = inp.Position spOA = OASpamFloatBtn.Position
        end
    end)
    
    UIS.InputChanged:Connect(function(inp)
        if not dragOA then return end
        if Config.FloatSpamDraggable and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            dlOA = inp.Position - dsOA
            if dlOA.Magnitude > 5 then movedOA = true end
            if movedOA then
                vpOA = workspace.CurrentCamera.ViewportSize
                OASpamFloatBtn.Position = UDim2.new(spOA.X.Scale, math.clamp(spOA.X.Offset+dlOA.X, 0, vpOA.X-130), spOA.Y.Scale, math.clamp(spOA.Y.Offset+dlOA.Y, 0, vpOA.Y-50))
            end
        end
    end)
    
    OASpamFloatBtn.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            if dragOA then
                dragOA = false
                if not movedOA then 
                    targetState = not Config.OASpamActive
                    Config.OASpamActive = targetState
                    UpdateOASpamButtonVisual(targetState)
                end
            end
        end
    end)
end

getgenv().ToggleOASpamButton = function(state)
    xpcall(function()
        if OASpamFloatBtn then
            OASpamFloatBtn.Visible = state
            if not state then
                Config.OASpamActive = false
                UpdateOASpamButtonVisual(false)
            end
        end
    end, function(err)
        print("Global OA Spam Button Signal Sync Error: " .. tostring(err))
    end)
end

TriggerbotFloatBtn = Instance.new("TextButton", ScreenGui)
TriggerbotFloatBtn.Name = "Endless_TriggerbotBtn"
TriggerbotFloatBtn.Size = UDim2.fromOffset(120, 40)
TriggerbotFloatBtn.Position = UDim2.new(0, 8, 0.9, 0)
TriggerbotFloatBtn.BackgroundColor3 = Color3.fromRGB(248, 248, 252)
TriggerbotFloatBtn.Text = "TRIGGERBOT: OFF"
TriggerbotFloatBtn.TextColor3 = Color3.fromRGB(6, 6, 10)
TriggerbotFloatBtn.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
TriggerbotFloatBtn.TextSize = 11
TriggerbotFloatBtn.Visible = false
TriggerbotFloatBtn.AutoButtonColor = false
Instance.new("UICorner", TriggerbotFloatBtn).CornerRadius = UDim.new(0, 9)

TriggerbotFBS = Instance.new("UIStroke", TriggerbotFloatBtn)
TriggerbotFBS.Color = Color3.fromRGB(6, 6, 10)
TriggerbotFBS.Thickness = 1.5
TriggerbotFBS.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

function UpdateTriggerbotButtonVisual(isActive)
    xpcall(function()
        if isActive then
            TweenService:Create(TriggerbotFloatBtn, TweenInfo.new(0.08), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
            TweenService:Create(TriggerbotFloatBtn, TweenInfo.new(0.08), {TextColor3 = Color3.fromRGB(248, 248, 252)}):Play()
            TriggerbotFloatBtn.Text = "TRIGGERBOT: ON"
            TriggerbotFBS.Color = Color3.fromRGB(248, 248, 252)
        else
            TweenService:Create(TriggerbotFloatBtn, TweenInfo.new(0.08), {BackgroundColor3 = Color3.fromRGB(248, 248, 252)}):Play()
            TweenService:Create(TriggerbotFloatBtn, TweenInfo.new(0.08), {TextColor3 = Color3.fromRGB(6, 6, 10)}):Play()
            TriggerbotFloatBtn.Text = "TRIGGERBOT: OFF"
            TriggerbotFBS.Color = Color3.fromRGB(6, 6, 10)
        end
    end, function(err)
        print("Update Triggerbot Visual Output Error: " .. tostring(err))
    end)
end

do
    dragTB, dsTB, spTB, movedTB = false, nil, nil, false
    
    TriggerbotFloatBtn.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragTB = true movedTB = false dsTB = inp.Position spTB = TriggerbotFloatBtn.Position
        end
    end)
    
    UIS.InputChanged:Connect(function(inp)
        if not dragTB then return end
        if Config.FloatSpamDraggable and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            dlTB = inp.Position - dsTB
            if dlTB.Magnitude > 5 then movedTB = true end
            if movedTB then
                TriggerbotFloatBtn.Position = UDim2.new(spTB.X.Scale, spTB.X.Offset + dlTB.X, spTB.Y.Scale, spTB.Y.Offset + dlTB.Y)
            end
        end
    end)
    
    TriggerbotFloatBtn.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            if dragTB then
                dragTB = false
                if not movedTB then 
                    targetState = not Config.TriggerbotActive
                    Config.TriggerbotActive = targetState
                    UpdateTriggerbotButtonVisual(targetState)
                end
            end
        end
    end)
end

getgenv().ToggleTriggerbotButton = function(state)
    xpcall(function()
        if TriggerbotFloatBtn then
            TriggerbotFloatBtn.Visible = state
            if not state then
                Config.TriggerbotActive = false
                UpdateTriggerbotButtonVisual(false)
            end
        end
    end, function(err)
        print("Global Triggerbot Button Toggle Interceptor Error: " .. tostring(err))
    end)
end

--==========================================================
-- AVATAR CHANGER MODULE (INTEGRATED FROM WIND HUB STYLE)
--==========================================================
local v98 = game:GetService("Players")
local localPlayer3 = v98.LocalPlayer
local flag21 = false
local str7 = ""

local function GetUserIdFromName(arg)
    local ok, result = pcall(function()
        return v98:GetUserIdFromNameAsync(arg)
    end)
    return ok and result or nil
end

local function ApplyAvatarMorph(lastMorphNameOrId)
    if not lastMorphNameOrId or lastMorphNameOrId == "" then return end
    local character = localPlayer3.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local head = character:FindFirstChild("Head")
    if not humanoid or not head then return end
    
    local num = tonumber(lastMorphNameOrId) or GetUserIdFromName(lastMorphNameOrId)
    if not num then return end

    local ok, result = pcall(function()
        return v98:CreateHumanoidModelFromUserId(num)
    end)

    if ok and result then
        local head2 = result:FindFirstChild("Head")
        local humanoid2 = result:FindFirstChildOfClass("Humanoid")

        if head2 then
            local decal = head:FindFirstChildOfClass("Decal")
            local decal2 = head2:FindFirstChildOfClass("Decal")
            if decal2 then
                if not decal then
                    decal = Instance.new("Decal")
                    decal.Name = "face"
                    decal.Parent = head
                end
                decal.Texture = decal2.Texture
            elseif decal then
                decal:Destroy()
            end

            local specialMesh = head:FindFirstChildOfClass("SpecialMesh")
            local specialMesh2 = head2:FindFirstChildOfClass("SpecialMesh")
            if specialMesh2 then
                if not specialMesh then
                    specialMesh = Instance.new("SpecialMesh")
                    specialMesh.Parent = head
                end
                specialMesh.MeshId = specialMesh2.MeshId
                specialMesh.TextureId = specialMesh2.TextureId
                specialMesh.Scale = specialMesh2.Scale
            end
        end

        for _, child in ipairs(character:GetChildren()) do
            if child:IsA("Accessory") or child:IsA("Clothing") or child:IsA("ShirtGraphic") or child:IsA("BodyColors") or child:IsA("CharacterMesh") then
                child:Destroy()
            end
        end

        local bodyColors = result:FindFirstChildOfClass("BodyColors")
        if bodyColors then bodyColors:Clone().Parent = character end

        if humanoid.RigType == Enum.HumanoidRigType.R15 and humanoid2 then
            for _, v90 in ipairs({ "BodyHeightScale", "BodyWidthScale", "BodyDepthScale", "HeadScale", "ProportionScale" }) do
                local v91 = humanoid2:FindFirstChild(v90)
                local v92 = humanoid:FindFirstChild(v90)
                if v91 and v92 then v92.Value = v91.Value end
            end
        end

        if humanoid.RigType == Enum.HumanoidRigType.R6 then
            for _, child in ipairs(result:GetChildren()) do
                if child:IsA("CharacterMesh") then child:Clone().Parent = character end
            end
        else
            for _, child in ipairs(result:GetChildren()) do
                if child:IsA("MeshPart") then
                    local v90 = character:FindFirstChild(child.Name)
                    if v90 and v90:IsA("MeshPart") then
                        v90.MeshId = child.MeshId
                        v90.TextureID = child.TextureID
                    end
                end
            end
        end

        for _, child in ipairs(result:GetChildren()) do
            if child:IsA("Accessory") then
                local clone = child:Clone()
                clone.Parent = character
                local handle = clone:FindFirstChild("Handle")
                if handle and handle:IsA("BasePart") then
                    handle.CanCollide = false
                    if not handle:FindFirstChildOfClass("WrapLayer") then
                        local attachment = handle:FindFirstChildOfClass("Attachment")
                        local v90 = nil
                        if attachment then
                            for _, child2 in ipairs(character:GetChildren()) do
                                if child2:IsA("BasePart") and child2:FindFirstChild(attachment.Name) then
                                    v90 = child2:FindFirstChild(attachment.Name)
                                    break
                                end
                            end
                        end

                        if v90 then
                            handle.CFrame = v90.WorldCFrame * attachment.CFrame:Inverse()
                            local weldConstraint = Instance.new("WeldConstraint")
                            weldConstraint.Part0 = handle
                            weldConstraint.Part1 = v90.Parent
                            weldConstraint.Parent = handle
                        else
                            local torso = head or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
                            if torso then
                                handle.CFrame = torso.CFrame
                                local weldConstraint = Instance.new("WeldConstraint")
                                weldConstraint.Part0 = handle
                                weldConstraint.Part1 = torso
                                weldConstraint.Parent = handle
                            end
                        end
                    end
                end
            elseif child:IsA("Clothing") or child:IsA("ShirtGraphic") then
                child:Clone().Parent = character
            end
        end

        result:Destroy()
        
        -- ควบคุมระบบสกินดาบหลักของสคริปต์ให้ซิงค์กันใหม่
        task.delay(0.5, function()
            if getgenv().skinChanger and getgenv().updateSword then
                pcall(getgenv().updateSword)
            end
        end)
    end
end

local RunService = game:GetService("RunService")

task.spawn(function()
    localPlayer3.CharacterAdded:Connect(function(character)
        if not flag21 or str7 == "" then return end
        if not character:WaitForChild("Humanoid", 8) then return end
        if not character:WaitForChild("Head", 8) then return end
        
        local now2 = os.clock()
        while character.Parent and not character:IsDescendantOf(workspace) and os.clock() - now2 < 5 do 
            task.wait() 
        end
        task.wait(0.5)
        
        if flag21 and str7 ~= "" and localPlayer3.Character == character then
            pcall(function() ApplyAvatarMorph(str7) end)
        end
    end)
end)

-- ฟังก์ชันสำหรับส่งคำสั่งจากปุ่มในเมนู UI หลัก
getgenv().SetAvatarChangerState = function(enabled)
    flag21 = enabled
    if enabled and str7 ~= "" then
        pcall(function() ApplyAvatarMorph(str7) end)
    end
end

getgenv().SetAvatarChangerUser = function(userText)
    str7 = tostring(userText or ""):match("^%s*(.-)%s*$") or ""
    if flag21 and str7 ~= "" then
        pcall(function() ApplyAvatarMorph(str7) end)
    end
end

if shared._OASpamOverdriveThread then task.cancel(shared._OASpamOverdriveThread) end

shared._OASpamOverdriveThread = task.spawn(function()
    while shared._EndlessRunning do
        xpcall(function()
            currentDelay = tonumber(Config.OASpamSpeed) or 0.005
            enforcedDelay = math.clamp(currentDelay, 0.001, 1.0)
            
            if Config.OASpamShow and Config.OASpamActive then
                shared.OldAutoSpamDetected = true
                
                if type(Auto_Parry) == "table" and type(Auto_Parry.FireParryRemote) == "function" then
                    pcall(Auto_Parry.FireParryRemote, true)
                    pcall(Auto_Parry.FireParryRemote, true)
                end
            else
                if not Config.OldAutoSpamEnabled then
                    shared.OldAutoSpamDetected = false
                end
            end
            
            task.wait(enforcedDelay)
        end, function(err)
            print("OA Spam Overdrive Engine Loop Error: " .. tostring(err))
        end)
    end
end)

if shared._OldAutoSpamOverdriveThread then task.cancel(shared._OldAutoSpamOverdriveThread) end

shared._OldAutoSpamOverdriveThread = task.spawn(function()
    while shared._EndlessRunning do
        xpcall(function()
            currentDelay = tonumber(Config.OldAutoSpamSpeed) or 0.005
            enforcedDelay = math.clamp(currentDelay, 0.001, 1.0)
            
            if Config.OldAutoSpamEnabled and shared.OldAutoSpamDetected then
                if type(Auto_Parry) == "table" and type(Auto_Parry.FireParryRemote) == "function" then
                    pcall(Auto_Parry.FireParryRemote, true)
                    pcall(Auto_Parry.FireParryRemote, true)
                    
                    if Config.AnimFix then
                        pcall(Auto_Parry.Parry_Animation)
                    end
                end
            end
            
            task.wait(enforcedDelay)
        end, function(err)
            print("Old AutoSpam Overdrive Loop Error: " .. tostring(err))
        end)
    end
end)

if shared._OldAutoSpamScanBind then shared._OldAutoSpamScanBind:Disconnect() end

shared._OldAutoSpamScanBind = RunService.PreSimulation:Connect(function()
    xpcall(function()
        if not shared._EndlessRunning or not Config.AutoParry or not Config.OldAutoSpamEnabled then 
            shared.OldAutoSpamDetected = false
            return 
        end
        
        myChar = LP.Character
        myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myHrp or myChar:GetAttribute("Pulsed") then 
            shared.OldAutoSpamDetected = false
            return 
        end
        
        myPos = myHrp.Position
        aliveFolder = workspace:FindFirstChild("Alive")
        bc = workspace:FindFirstChild("Balls") or workspace:FindFirstChild("TrainingBalls")
        if not aliveFolder or not bc then 
            shared.OldAutoSpamDetected = false
            return 
        end
        
        currentBall = nil
        for _, b in pairs(bc:GetChildren()) do
            if b:IsA("BasePart") and (b:GetAttribute("realBall") or b:GetAttribute("target") or b.Name:find("Ball")) then
                currentBall = b
                break
            end
        end
        if not currentBall then 
            shared.OldAutoSpamDetected = false
            return 
        end

        if currentBall:FindFirstChild("AeroDynamicSlashVFX") or myChar:GetAttribute("IsRagingDeflection") then
            shared.OldAutoSpamDetected = false
            return
        end
        
        closestEnemy = nil
        minEnemyDist = math.huge
        for _, enemy in pairs(aliveFolder:GetChildren()) do
            if enemy:IsA("Model") and enemy.Name ~= LP.Name and enemy.PrimaryPart and not enemy:GetAttribute("Dead") then
                enemyDist = (myPos - enemy.PrimaryPart.Position).Magnitude
                if enemyDist < minEnemyDist then
                    minEnemyDist = enemyDist
                    closestEnemy = enemy
                end
            end
        end
        if not closestEnemy or not closestEnemy.PrimaryPart then 
            shared.OldAutoSpamDetected = false
            return 
        end
        
        zoomies = currentBall:FindFirstChild("zoomies")
        ballVel = Vector3.zero
        if zoomies then pcall(function() ballVel = zoomies.VectorVelocity end) end
        if ballVel == Vector3.zero and currentBall:IsA("BasePart") then ballVel = currentBall.AssemblyLinearVelocity end
        
        ballSpeed = ballVel.Magnitude
        if ballSpeed == 0 then 
            shared.OldAutoSpamDetected = false
            return 
        end
        
        toPlayerVec = myPos - currentBall.Position
        ballDistance = toPlayerVec.Magnitude
        dotValue = toPlayerVec.Unit:Dot(ballVel.Unit)
        
        enemyDistance = (myPos - closestEnemy.PrimaryPart.Position).Magnitude
        currentPing = math.clamp((pingSeconds or 0.03) * 100, 10, 17)
        
        oldSpamReach = currentPing + math.min(ballSpeed / 6, 95)
        
        if enemyDistance > oldSpamReach or ballDistance > oldSpamReach then 
            shared.OldAutoSpamDetected = false
            return 
        end
        
        calculatedThreshold = oldSpamReach
        clampedDot = math.clamp(dotValue, -1, 0)
        speedReduction = 5 - math.min(ballSpeed / 5, 5)
        calculatedThreshold = oldSpamReach - (clampedDot * speedReduction)
        
        isTargetingMe = (tostring(currentBall:GetAttribute("target") or currentBall:GetAttribute("Target") or "") == LP.Name)
        if isTargetingMe and enemyDistance > 30 and ballDistance > 30 then
            shared.OldAutoSpamDetected = false
            return 
        end
        
        if ballDistance <= calculatedThreshold and parryLocked[currentBall] then
            shared.OldAutoSpamDetected = true
        else
            shared.OldAutoSpamDetected = false
        end
    end, function(err)
        print("Old AutoSpam Scanner Engine Error: " .. tostring(err))
    end)
end)

--==========================================================
-- AUTO SPAM LOOP (RISE STYLE ALGORITHM 100%)
--==========================================================
if shared._EndlessAutoSpamBind then 
    shared._EndlessAutoSpamBind:Disconnect() 
end

shared._EndlessAutoSpamBind = RunService.PreSimulation:Connect(function()
    xpcall(function()
        -- ตรวจสอบเงื่อนไขเปิดใช้งานหลักของเมนูสคริปต์
        if not shared._EndlessRunning or not Config.AutoParry or not Config.AutoSpam then 
            return 
        end
        
        local myChar = LP.Character
        local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myHrp or myChar:GetAttribute("Pulsed") then 
            return 
        end
        
        local myPos = myHrp.Position
        local aliveFolder = workspace:FindFirstChild("Alive")
        local bc = workspace:FindFirstChild("Balls") or workspace:FindFirstChild("TrainingBalls")
        if not aliveFolder or not bc then 
            return 
        end
        
        -- ค้นหาลูกบอลหลักในสนาม
        local currentBall = nil
        for _, b in pairs(bc:GetChildren()) do
            if b:IsA("BasePart") and (b:GetAttribute("realBall") or b:GetAttribute("target") or b.Name:find("Ball")) then
                currentBall = b
                break
            end
        end
        if not currentBall then 
            return 
        end

        -- ตรวจเช็คสถานะบล็อกแอนตี้พายุและสกิลสะท้อนชั่วคราวแบบ Rise
        if currentBall:FindFirstChild("AeroDynamicSlashVFX") or myChar:GetAttribute("IsRagingDeflection") then
            return
        end
        
        -- ค้นหาศัตรูที่อยู่ใกล้ตัวเรามากที่สุด (Target สำหรับวัดระยะปะทะสแปมแบบ Rise)
        local closestEnemy = nil
        local minEnemyDist = math.huge
        for _, enemy in pairs(aliveFolder:GetChildren()) do
            if enemy:IsA("Model") and enemy.Name ~= LP.Name and enemy.PrimaryPart and not enemy:GetAttribute("Dead") then
                local enemyDist = (myPos - enemy.PrimaryPart.Position).Magnitude
                if enemyDist < minEnemyDist then
                    minEnemyDist = enemyDist
                    closestEnemy = enemy
                end
            end
        end
        if not closestEnemy or not closestEnemy.PrimaryPart then 
            return 
        end
        
        -- ถอดสูตรถอดตรรกะความเร็วทิศทาง Vector ลูกบอลของ Rise
        local zoomies = currentBall:FindFirstChild("zoomies")
        local ballVel = Vector3.zero
        if zoomies then pcall(function() ballVel = zoomies.VectorVelocity end) end
        if ballVel == Vector3.zero and currentBall:IsA("BasePart") then ballVel = currentBall.AssemblyLinearVelocity end
        
        local ballSpeed = ballVel.Magnitude
        if ballSpeed == 0 then 
            return 
        end
        
        -- คำนวณความสัมพันธ์เชิงมุม Dot Product ระหว่างทิศทางบอลกับผู้เล่น
        local toPlayerVec = myPos - currentBall.Position
        local ballDistance = toPlayerVec.Magnitude
        local dotValue = toPlayerVec.Unit:Dot(ballVel.Unit)
        
        local enemyDistance = (myPos - closestEnemy.PrimaryPart.Position).Magnitude
        local currentPing = math.clamp((pingSeconds or 0.03) * 100, 10, 17)
        
        -- 1. [Rise Mathematical Formula] คำนวณหาระยะสแปมปลอดภัยสัมพัทธ์ (Spam Reach)
        local riseSpamReach = currentPing + math.min(ballSpeed / 6, 95)
        
        -- 2. คัดกรอง Gate ป้องกันสแปมเอ๋อระยะไกล (ระยะห่างห้ามเกินโซนปะทะจริง)
        if enemyDistance > riseSpamReach or ballDistance > riseSpamReach then 
            return 
        end
        
        -- 3. คำนวณค่า Threshold แปรผันตามทิศทางหน้าไม้ (หลบเลี่ยงอาการโดนแกงประชิด)
        local calculatedThreshold = riseSpamReach
        local clampedDot = math.clamp(dotValue, -1, 0)
        local speedReduction = 5 - math.min(ballSpeed / 5, 5)
        calculatedThreshold = riseSpamReach - (clampedDot * speedReduction)
        
        -- 4. ถอดตรรกะเงื่อนไขจำกัดเฟรมเรตและคูลดาวน์สแปมของ Rise
        local isTargetingMe = (tostring(currentBall:GetAttribute("target") or currentBall:GetAttribute("Target") or "") == LP.Name)
        if isTargetingMe and enemyDistance > 30 and ballDistance > 30 then
            return -- หากบอลเล็งเราแต่ทุกคนอยู่ไกลเกิน 30 Studs จะปล่อยให้ระบบ Auto Parry หลักจัดจังหวะแทน (ไม่สแปมทิ้งขว้าง)
        end
        
        -- ตรวจสอบเงื่อนไขข้อสุดท้าย หากผ่านเกณฑ์ทั้งหมด บอลเข้าโซนอันตรายประชิดตัว สั่งยิงสแปมทันที
        if ballDistance <= calculatedThreshold and parryLocked[currentBall] then
            local delayValue = tonumber(Config.AutoSpamSpeed) or 0.005
            if (os.clock() - lastParryTime) >= delayValue then
                pcall(Auto_Parry.FireParryRemote, true)
                lastParryTime = os.clock()
                
                -- สั่งเปิดแอนิเมชั่นพารี่สไตล์ Rise
                if Config.AnimFix then
                    pcall(Auto_Parry.Parry_Animation)
                end
            end
        end
    end, function(err)
        print("Endless Rise-Style AutoSpam Loop Error: " .. tostring(err))
    end)
end)

--==========================================================
-- HARDCORE ILLUSION SPAM OVERDRIVE ENGINE (MAX-SPEED PIPELINE)
--==========================================================
if shared._IllusionSpamThread then task.cancel(shared._InvisChao_Spam or shared._IllusionSpamThread) end

shared._IllusionSpamThread = task.spawn(function()
    while shared._EndlessRunning do
        -- ดึงค่าดีเลย์หน่วงวินาทีจริงจากหน้าจอ UI บีบขอบเขตเซฟตี้ต่ำสุดที่ 0.001 วินาที
        local currentDelay = tonumber(Config.IllusionSpamSpeed) or 0.001
        local enforcedDelay = math.clamp(currentDelay, 0.001, 1.0)
        
        -- ตรวจสอบเงื่อนไขปุ่มและสถานะการสลับสเตทเปิด/ปิด
        if Config.IllusionSpamEnabled and shared.IllusionSpamActive then
            if type(Auto_Parry) == "table" and type(Auto_Parry.FireParryRemote) == "function" then
                -- ดึงค่า Burst คูณความเร็วการสาด Remote ในเสี้ยววินาทีเดียวกันเพื่อให้เซิร์ฟเวอร์รับคิวได้แน่นที่สุด
                local burstCount = math.clamp(math.floor(tonumber(Config.IllusionSpamBurst) or 3), 1, 10)
                
                -- สาดแพ็กเก็ตจำลองความถี่ระดับ Overdrive คู่ขนาน
                for i = 1, burstCount do
                    pcall(Auto_Parry.FireParryRemote, true)
                end
            end
        end
        
        -- ใช้ task.wait เพื่อให้ดีเลย์นิ่งและแม่นยำที่สุดตามสเปคมือถือ/PC
        task.wait(enforcedDelay)
    end
end)

--==========================================================
-- FLOATING ILLUSION SPAM BUTTON (ROUND INDEPENDENT TOGGLE)
--==========================================================
local IllusionFloatBtn = Instance.new("ImageButton")
IllusionFloatBtn.Size = UDim2.fromOffset(120, 40)
IllusionFloatBtn.Position = UDim2.new(0, 8, 0.6, 0) -- พิกัดแกน Y 0.6 ป้องกันการซ้อนทับปุ่มเดิม
IllusionFloatBtn.BackgroundColor3 = Color3.fromRGB(248, 248, 252) -- สีขาวเริ่มต้น (OFF)
IllusionFloatBtn.Image = ""
IllusionFloatBtn.AutoButtonColor = false
IllusionFloatBtn.ZIndex = 999
IllusionFloatBtn.Visible = false 
IllusionFloatBtn.Parent = ScreenGui

local IllusionRnd = Instance.new("UICorner")
IllusionRnd.CornerRadius = UDim.new(0, 9)
IllusionRnd.Parent = IllusionFloatBtn

local IllusionFBS = Instance.new("UIStroke")
IllusionFBS.Color = Color3.fromRGB(6, 6, 10)
IllusionFBS.Thickness = 1.5
IllusionFBS.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
IllusionFBS.Parent = IllusionFloatBtn

local IllusionFBLabel = Instance.new("TextLabel")
IllusionFBLabel.BackgroundTransparency = 1
IllusionFBLabel.Text = "ILLUSION: OFF"
IllusionFBLabel.TextSize = 11
IllusionFBLabel.TextColor3 = Color3.fromRGB(6, 6, 10)
IllusionFBLabel.Font = Enum.Font.GothamBlack
IllusionFBLabel.TextXAlignment = Enum.TextXAlignment.Center
IllusionFBLabel.Size = UDim2.fromScale(1, 1)
IllusionFBLabel.Parent = IllusionFloatBtn

-- ฟังก์ชันเกลี่ยสีแอนิเมชันปุ่มเมื่อกดใช้งาน
local function UpdateIllusionVisual(isActive)
    if isActive then
        TweenService:Create(IllusionFloatBtn, TweenInfo.new(0.08), {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play() -- สลับเป็นสีแดงเร่งความเร็ว
        TweenService:Create(IllusionFBLabel, TweenInfo.new(0.08), {TextColor3 = Color3.fromRGB(248, 248, 252)}):Play()
        IllusionFBLabel.Text = "ILLUSION: OVER"
        IllusionFBS.Color = Color3.fromRGB(248, 248, 252)
    else
        TweenService:Create(IllusionFloatBtn, TweenInfo.new(0.08), {BackgroundColor3 = Color3.fromRGB(248, 248, 252)}):Play()
        TweenService:Create(IllusionFBLabel, TweenInfo.new(0.08), {TextColor3 = Color3.fromRGB(6, 6, 10)}):Play()
        IllusionFBLabel.Text = "ILLUSION: OFF"
        IllusionFBS.Color = Color3.fromRGB(6, 6, 10)
    end
end

-- ระบบดักจับลากย้ายปุ่มลอยและการกดคลิกตัวปุ่มลอยชิ้นใหม่
do
    local drag, ds, sp, moved = false, nil, nil, false
    
    IllusionFloatBtn.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            drag = true; moved = false; ds = inp.Position; sp = IllusionFloatBtn.Position
        end
    end)
    
    UIS.InputChanged:Connect(function(inp)
        if not drag then return end
        if Config.FloatSpamDraggable and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local dl = inp.Position - ds
            if dl.Magnitude > 5 then moved = true end
            if moved then
                local vp = workspace.CurrentCamera.ViewportSize
                IllusionFloatBtn.Position = UDim2.new(sp.X.Scale, math.clamp(sp.X.Offset+dl.X, 0, vp.X-130), sp.Y.Scale, math.clamp(sp.Y.Offset+dl.Y, 0, vp.Y-50))
            end
        end
    end)
    
    IllusionFloatBtn.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            if drag then
                drag = false
                if not moved then 
                    shared.IllusionSpamActive = not shared.IllusionSpamActive
                    UpdateIllusionVisual(shared.IllusionSpamActive)
                end
            end
        end
    end)
end

-- ผูกมัดคำสั่งให้ฟังก์ชันสลับโหมดเปิด/ปิดของปุ่มลอยถูกเรียกใช้งานผ่านหน้าเมนูกลางได้
getgenv().ToggleIllusionSpamButton = function(state)
    if IllusionFloatBtn then
        IllusionFloatBtn.Visible = state
        if not state then
            shared.IllusionSpamActive = false
            UpdateIllusionVisual(false)
        end
    end
end

--==========================================================
-- TABS
--==========================================================
local T_COMBAT  = CreateTab("combat",  "⚔ COMBAT")
local T_SPAM    = CreateTab("spam",    "◉ SPAM")
local T_AUTO    = CreateTab("auto",    "🤖 AUTO")
local T_PLAYER  = CreateTab("player",  "👤 PLAYER")
local T_MISC    = CreateTab("misc",    "⚙ MISC")

-- ── COMBAT TAB ────────────────────────────────────────────
Divider("combat", "AUTO PARRY")

SlotToggle("combat", "Auto Parry", false, function(v) Config.AutoParry = v end)

Divider("spam", "Auto Parry Setting")

SlotSelect("combat", "Parry Mode", {"Pro", "Advance", "Normal", "Noob"}, function(v)
    Config.ParryMode = v
end)

SlotSelect("combat", "Curve Direction", {"Camera","Left","Right","Up","Down","Random","Straight","Super Curve Random"}, function(v)
    Config.ParryCurveMode = v
end)

SlotSlider("combat", "Accuracy", 1, 180, 100, function(v) Config.Accuracy = v end)

SlotSlider("combat", "Cooldown ×100", 1, 100, math.floor((Config.ParryCooldownValue or 0.07)*100), function(v)
    Config.ParryCooldownValue = v/100
end)

SlotToggle("combat", "Auto Cooldown", false, function(v) Config.AutoCooldownParry = v end)

Divider("combat", "TARGET")

SlotSelect("combat", "Target Lock Mode", {"Normal","Nearest","Farthest","Double Click"}, function(v)
    Config.TargetLockMode = v
end)

SlotToggle("combat", "Parry Sound", false, function(v) Config.SoundEnabled = v end)
SlotToggle("combat", "Parry Animation Fix", false, function(v) Config.AnimFix = v end)
SlotSlider("combat", "Distance Timing", 50, 150, 100, function(v) Config.DistanceTiming = v end)

Divider("combat", "Distance Timing for distance when 795+ speed ball")

SlotToggle("combat", "Random Target", false, function(v) Config.RandomTarget = v end)
SlotToggle("combat", "Clash Target", true, function(v) Config.ClashTarget = v end)

Divider("combat", "PRE-CLICK V1")

SlotToggle("combat", "Enable Pre-Click V1", false, function(v)
    Config.PreClickEnabled = v
end)

SlotToggle("combat", "Show Pre-Click Range Ring (ESP)", false, function(v)
    Config.PreClickVisualRing = v
end)

SlotSlider("combat", "Pre-Click Distance (10-50 Studs)", 10, 50, 25, function(v)
    Config.PreClickDistance = v
end)

SlotSlider("combat", "Multiplayer Window (0.1s - 1.0s)", 10, 100, 30, function(v)
    Config.PreClickMultiTimer = v -- ยิ่งปรับเยอะยิ่งกดชิงพารี่ล่วงหน้าไวขึ้นตอนนัวหลายคน
end)

SlotSlider("combat", "1v1 Duel Window (0.1s - 1.0s)", 10, 100, 50, function(v)
    Config.PreClick1v1Timer = v   -- ยิ่งปรับเยอะยิ่งกดชิงพารี่ล่วงหน้าไวขึ้นตอนดวล 1v1
end)

-- ── SPAM TAB ──────────────────────────────────────────────
Divider("spam", "AUTO SPAM")

spamTogObj = SlotToggle("spam", "Auto Spam", false, function(v)
    Config.AutoSpam = v
end)

SlotSlider("spam", "Auto Spam Threshold", 1, 3, 3, function(v) 
    Config.SpamThreshold = v 
end)

Divider("spam", "OLD AUTO SPAM ENGINE")

SlotToggle("spam", "Old Auto Spam", false, function(v)
    xpcall(function()
        Config.OldAutoSpamEnabled = v
        if not v then
            shared.OldAutoSpamDetected = false
        end
    end, function(err)
        print("Old Auto Spam Toggle UI Function Error: " .. tostring(err))
    end)
end)

SlotSlider("spam", "Old Auto Spam Delay Speed (ms)", 1, 50, 5, function(v)
    xpcall(function()
        Config.OldAutoSpamSpeed = v / 1000
    end, function(err)
        print("Old Auto Spam Delay Speed Slider UI Error: " .. tostring(err))
    end)
end)

Divider("spam", "MANUAL SPAM")

manualSpamTogObj = SlotToggle("spam", "Enable Spam Button", false, function(v)
    xpcall(function()
        if getgenv().ToggleFloatSpamButton then
            getgenv().ToggleFloatSpamButton(v)
        end
    end, function(err)
        print("Manual Spam Toggle UI Error: " .. tostring(err))
    end)
end)

SlotToggle("spam", "Spam Button Draggable", true, function(v)
    Config.FloatSpamDraggable = v
end)

SlotSlider("spam", "Spam Speed (ms)", 1, 50, 5, function(v) 
    Config.AutoSpamSpeed = v / 1000 
end)

SlotSlider("spam", "FPS Multiplier", 1, 20, 5, function(v)
    xpcall(function()
        Config.SpamFpsMultiplier = v
    end, function(err)
        print("FPS Multiplier Slider Error: " .. tostring(err))
    end)
end)

Divider("spam", "ILLUSION SPAM (INDEPENDENT EXTREME FAST)")

SlotToggle("spam", "Enable Illusion Spam Button", false, function(v)
    Config.IllusionSpamEnabled = v
    if getgenv().ToggleIllusionSpamButton then
        getgenv().ToggleIllusionSpamButton(v)
    end
end)

SlotSlider("spam", "Illusion Delay Speed (ms)", 1, 50, 1, function(v) 
    Config.IllusionSpamSpeed = v / 1000 -- ยิ่งปรับเป็น 1ms จะยิ่งส่งพาร์รี่ได้เร็วทะลุขีดจำกัด
end)

SlotSlider("spam", "Illusion Burst Per Frame", 1, 10, 3, function(v)
    Config.IllusionSpamBurst = v -- จำนวนชุดแพ็กเก็ตที่ถูกส่งสะท้อนย้ำในเสี้ยวเฟรมเรตเดียวกัน (แนะนำตั้งไว้ที่ 3-5 สำหรับการปะทะ)
end)

Divider("spam", "OA MANUAL SPAM OVERDRIVE")

SlotToggle("spam", "Enable OA Spam Button", false, function(v)
    xpcall(function()
        Config.OASpamShow = v
        if getgenv().ToggleOASpamButton then
            getgenv().ToggleOASpamButton(v)
        end
    end, function(err)
        print("OA Spam Floating Main Switch Trigger Error: " .. tostring(err))
    end)
end)

SlotSlider("spam", "OA Spam Delay Speed (ms)", 1, 50, 5, function(v)
    xpcall(function()
        Config.OASpamSpeed = v / 1000
    end, function(err)
        print("OA Spam Speed Value Handler Slider Error: " .. tostring(err))
    end)
end)

Divider("spam", "TRIGGERBOT CONFIGURATION")

SlotToggle("spam", "Enable Triggerbot Button", false, function(v)
    xpcall(function()
        Config.TriggerbotShow = v
        if getgenv().ToggleTriggerbotButton then
            getgenv().ToggleTriggerbotButton(v)
        end
    end, function(err)
        print("Triggerbot Main UI Toggle Callback Error: " .. tostring(err))
    end)
end)

-- ── AUTO TAB ──────────────────────────────────────────────
Divider("auto", "AUTO ABILITY")
SlotToggle("auto", "Auto Ability (replaces parry when ready)", false, function(v) Config.AutoAbility = v end)

Divider("auto", "AUTO PLAY")
SlotToggle("auto", "Auto Play (random walk + camera)", false, function(v) Config.AutoPlay = v end)
SlotButton("auto", "ℹ  Only active when you alive", function() end)

-- ── PLAYER TAB ────────────────────────────────────────────
Divider("player", "AVATAR CHANGER")
SlotToggle("player", "Enable Avatar Changer", false, function(v)
    if getgenv().SetAvatarChangerState then getgenv().SetAvatarChangerState(v) end
end)
SlotTextbox("player", "Target Username / UserID", "e.g. ROBLOX", function(txt)
    if getgenv().SetAvatarChangerUser then getgenv().SetAvatarChangerUser(txt) end
end)
SlotButton("player", "Apply Avatar Now", function()
    if getgenv().SetAvatarChangerState then getgenv().SetAvatarChangerState(true) end
end)

Divider("player", "WALKSPEED")
SlotToggle("player", "Custom WalkSpeed", false, function(v)
    Config.WalkSpeedEnabled = v
    local hum = GetHum()
    if not v and hum then hum.WalkSpeed = _defaultWalkSpeed end
end)
SlotTextbox("player", "WalkSpeed Value", "e.g. 28", function(txt)
    local n = tonumber(txt); if n then Config.WalkSpeedValue = n end
end)

Divider("player", "JUMPPOWER")
SlotToggle("player", "Custom JumpPower", false, function(v)
    Config.JumpPowerEnabled = v
    local hum = GetHum()
    if not v and hum then hum.JumpPower = _defaultJumpPower end
end)
SlotTextbox("player", "JumpPower Value", "e.g. 80", function(txt)
    local n = tonumber(txt); if n then Config.JumpPowerValue = n end
end)

Divider("player", "FLY")
SlotToggle("player", "Fly", false, function(v) if v then StartFly() else StopFly() end end)
SlotSlider("player", "Fly Speed", 5, 200, 50, function(v) Config.FlySpeed = v end)

Divider("player", "ORBIT")
SlotToggle("player", "Ball Orbit", false, function(v) Config.CharOrbitEnabled = v end)
SlotSlider("player", "Orbit Distance", 2, 50, 12, function(v) Config.CharOrbitDistance = v end)
SlotSlider("player", "Orbit Speed (-25 → 25)", -25, 25, 5, function(v) Config.CharOrbitSpeed = v end)
SlotSelect("player", "Orbit Axis", {"Y","X","Z","XY"}, function(v) Config.CharOrbitAxis = v end)

-- ── MISC TAB ──────────────────────────────────────────────
Divider("misc", "IMMORTAL")
SlotToggle("misc", "Immortal V1 (Virex Triangle)", false, function(v)
    Config.virexImmortalGodMode = v
    if v then Config.ImmortalGodMode = false end
end)
SlotToggle("misc", "Immortal V2 (Orbit Desync)", false, function(v)
    Config.ImmortalGodMode = v
    if v then Config.virexImmortalGodMode = false end
end)
SlotSelect("misc", "V2 Mode Type", {"Auto","Custom"}, function(v) Config.ImmortalModeType = v end)
SlotSlider("misc", "Custom Angle", 10, 360, 145, function(v) Config.ImmortalCustomAngle = v end)
SlotSlider("misc", "Desync Radius", 2, 50, 10, function(v) Config.ImmortalCustomRadius = v end)
SlotTextbox("misc", "Min Height (default -8)", "-8", function(txt) local n=tonumber(txt) if n then Config.ImmortalHeightMin=n end end)
SlotTextbox("misc", "Max Height (default 35)", "35", function(txt) local n=tonumber(txt) if n then Config.ImmortalHeightMax=n end end)

Divider("misc", "APPEARANCE")
SlotToggle("misc", "Headless", false, function(v) Config.HeadlessOn=v; ApplyHeadless(v) end)
SlotToggle("misc", "Korblox (Left Leg)", false, function(v) Config.KorbloxOn=v; ApplyKorblox(v) end)

Divider("misc", "UNLOCK ALL")
SlotToggle("misc", "Unlock All", false, function(v)
    if v then
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/foreverspacexc-blip/OTHERHUB/refs/heads/main/wSuhUFTr%20(1).txt"))()
        end)
    end
end)

Divider("misc", "PERFORMANCE ANTI-LAG")

SlotToggle("misc", "Auto Anti-Lag", false, function(v)
    Config.AntiLagEnabled = v
end)

SlotSlider("misc", "Anti-Lag Threshold", 10, 120, 30, function(v)
    Config.AntiLagFPSThreshold = v
end)

AbilityESP_Folder = workspace:FindFirstChild("Illusion_AbilityESP_Storage") or Instance.new("Folder", workspace)
AbilityESP_Folder.Name = "Illusion_AbilityESP_Storage"

local ESP_Connections = {}

function removeAbilityESP(player)
    if not player then return end
    if ESP_Connections[player.Name] then
        for _, connection in ipairs(ESP_Connections[player.Name]) do
            if connection then connection:Disconnect() end
        end
        ESP_Connections[player.Name] = nil
    end
    if player and AbilityESP_Folder:FindFirstChild(player.Name) then
        xpcall(function()
            AbilityESP_Folder[player.Name]:Destroy()
        end, function(err)
            print("Illusion ESP Removal Error: " .. tostring(err))
        end)
    end
end

function GetPlayerCurrentAbility(character)
    if not character then return "None" end
    currentAbility = character:GetAttribute("EquippedAbility") or character:GetAttribute("CurrentlyEquippedAbility") or character:GetAttribute("Ability") or "Default"
    return tostring(currentAbility)
end

function createAbilityESP(player)
    if not player or player == LP then return end
    removeAbilityESP(player)

    function applyAbilityTracker(character)
        if not character or not character.Parent then return end
        removeAbilityESP(player)
        ESP_Connections[player.Name] = {}
        local playerThreads = ESP_Connections[player.Name]

        local head = character:WaitForChild("Head", 8)
        local hrp = character:WaitForChild("HumanoidRootPart", 8)
        if head and hrp then
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "AbilityOverlay"
            billboard.Adornee = head
            billboard.Size = UDim2.fromOffset(120, 32)
            billboard.StudsOffset = Vector3.new(0, 3.5, 0)
            billboard.AlwaysOnTop = true
            billboard.MaxDistance = 140
            billboard.Parent = playerStorage

            local frame = Instance.new("Frame")
            frame.Name = "Container"
            frame.Size = UDim2.fromScale(1, 1)
            frame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
            frame.BackgroundTransparency = 0.25
            frame.BorderSizePixel = 0
            frame.Parent = billboard

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = frame

            local stroke = Instance.new("UIStroke")
            stroke.Color = Color3.fromRGB(245, 245, 250)
            stroke.Transparency = 0.4
            stroke.Thickness = 1
            stroke.Parent = frame

            local nameLabel = Instance.new("TextLabel")
            nameLabel.Name = "PlayerName"
            nameLabel.Size = UDim2.new(1, -12, 0, 13)
            nameLabel.Position = UDim2.new(0, 6, 0, 3)
            nameLabel.BackgroundTransparency = 1
            nameLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
            nameLabel.TextSize = 10
            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLabel.TextXAlignment = Enum.TextXAlignment.Center
            nameLabel.TextTruncate = Enum.TextTruncate.AtEnd
            nameLabel.Text = player.DisplayName or player.Name
            nameLabel.Parent = frame

            local abilityLabel = Instance.new("TextLabel")
            abilityLabel.Name = "Ability"
            abilityLabel.Size = UDim2.new(1, -12, 0, 11)
            abilityLabel.Position = UDim2.new(0, 6, 0, 16)
            abilityLabel.BackgroundTransparency = 1
            abilityLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
            abilityLabel.TextSize = 9
            abilityLabel.TextColor3 = Color3.fromRGB(248, 248, 252)
            abilityLabel.TextXAlignment = Enum.TextXAlignment.Center
            abilityLabel.TextTruncate = Enum.TextTruncate.AtEnd
            abilityLabel.Text = "⚡ LOADING..."
            abilityLabel.Parent = frame

            local playerStorage = Instance.new("Folder")
            playerStorage.Name = player.Name
            playerStorage.Parent = AbilityESP_Folder

            local lastRecordedAbility = ""
            function updateTextDisplay()
                if character and character.Parent then
                    activeAbilityName = GetPlayerCurrentAbility(character)
                    if activeAbilityName ~= lastRecordedAbility then
                        lastRecordedAbility = activeAbilityName
                        abilityLabel.Text = "⚡ " .. string.upper(activeAbilityName)
                        
                        if activeAbilityName:find("Infinity") or activeAbilityName:find("Death") then
                            abilityLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
                        elseif activeAbilityName:find("Pull") or activeAbilityName:find("Freeze") then
                            abilityLabel.TextColor3 = Color3.fromRGB(255, 150, 50)
                        else
                            abilityLabel.TextColor3 = Color3.fromRGB(248, 248, 252)
                        end
                    end
                end
            end

            table.insert(playerThreads, character.AttributeChanged:Connect(function(attr)
                if attr == "EquippedAbility" or attr == "CurrentlyEquippedAbility" or attr == "Ability" then
                    xpcall(updateTextDisplay, function(err)
                        print("Illusion ESP Attribute Update Error: " .. tostring(err))
                    end)
                end
            end))

            xpcall(updateTextDisplay, function(err)
                print("Illusion ESP First Update Error: " .. tostring(err))
            end)

            task.spawn(function()
                while billboard.Parent and character.Parent and hrp.Parent and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") do
                    if Config and Config.AbilityESP then
                        local myHrp = LP.Character.HumanoidRootPart
                        local distance = (myHrp.Position - hrp.Position).Magnitude

                        if distance < 25 then
                            local alpha = math.clamp((distance - 5) / 20, 0.05, 1)
                            frame.BackgroundTransparency = 1 - (0.75 * alpha)
                            stroke.Transparency = 1 - (0.6 * alpha)
                            nameLabel.TextTransparency = 1 - alpha
                            abilityLabel.TextTransparency = 1 - alpha
                            billboard.StudsOffset = Vector3.new(0, 3.5 + (1 - alpha) * 1.5, 0)
                        else
                            frame.BackgroundTransparency = 0.25
                            stroke.Transparency = 0.4
                            nameLabel.TextTransparency = 0
                            abilityLabel.TextTransparency = 0
                            billboard.StudsOffset = Vector3.new(0, 3.5, 0)
                        end
                    end
                    task.wait(0.1)
                end
            end)
         head = character:WaitForChild("Head", 8)
        end
    end

    if player.Character then
        task.spawn(applyAbilityTracker, player.Character)
    end
    local conn = player.CharacterAdded:Connect(function(char)
        task.spawn(applyAbilityTracker, char)
    end)
    table.insert(ESP_Connections[player.Name] or {}, conn)
end

task.spawn(function()
    if Config.AbilityESP == nil then Config.AbilityESP = false end

    while shared._EndlessRunning do
        task.wait(0.4)
        
        if Config.AbilityESP then
            for _, player in ipairs(Players:GetPlayers()) do
                if player and player ~= LP and player.Parent then
                    if not AbilityESP_Folder:FindFirstChild(player.Name) then
                        xpcall(function()
                            createAbilityESP(player)
                        end, function(err)
                            print("Illusion ESP Creation Loop Error: " .. tostring(err))
                        end)
                    end
                end
            end
        else
            AbilityESP_Folder:ClearAllChildren()
            for pName, _ in pairs(ESP_Connections) do
                if Players:FindFirstChild(pName) then
                    removeAbilityESP(Players[pName])
                end
            end
        end
    end
end)

Players.PlayerRemoving:Connect(removeAbilityESP)

task.spawn(function()
    xpcall(function()
        Divider("misc", "ABILITY ESP")
        SlotToggle("misc", "AbilityESP", false, function(v)
            Config.AbilityESP = v
        end)
    end, function(err)
        print("Illusion Menu Injection Error: " .. tostring(err))
    end)
end)

Divider("misc", "SKIN CHANGER")
SlotToggle("misc", "Enable Skin Changer", false, function(v)
    getgenv().skinChanger = v
    if v and getgenv().swordModel ~= "" then pcall(function() getgenv().updateSword() end) end
end)
SlotTextbox("misc", "Sword Model Name", "e.g. ShadowBlade", function(txt)
    getgenv().swordModel = txt:match("^%s*(.-)%s*$")
end)
SlotTextbox("misc", "Animation Override (blank = auto)", "", function(txt)
    getgenv().swordAnimations = txt:match("^%s*(.-)%s*$")
end)
SlotTextbox("misc", "FX Override (blank = auto)", "", function(txt)
    getgenv().swordFX = txt:match("^%s*(.-)%s*$")
end)
SlotButton("misc", "Apply Skin", function()
    if getgenv().swordModel == "" then return end
    getgenv().skinChanger = true
    pcall(function() getgenv().updateSword() end)
end)
SlotButton("misc", "Reset Skin", function()
    getgenv().skinChanger = false
    getgenv().swordModel = ""
    getgenv().swordAnimations = ""
    getgenv().swordFX = ""
end)

--==========================================================
-- FLOATING TOGGLE BUTTON
--==========================================================
local FloatBtn = Instance.new("ImageButton")
FloatBtn.Size = UDim2.fromOffset(40, 40)
FloatBtn.Position = UDim2.new(0, 8, 0.4, 0)
FloatBtn.BackgroundColor3 = CG1
FloatBtn.Image = ""
FloatBtn.AutoButtonColor = false
FloatBtn.ZIndex = 999
FloatBtn.Parent = ScreenGui
Rnd(FloatBtn, 9)
local FBS = Str(FloatBtn, Color3.fromRGB(70,70,85), 1.5)

local FBLabel = Lbl(FloatBtn, "?", 20, CW, Enum.TextXAlignment.Center)
FBLabel.Font = Enum.Font.GothamBlack
FBLabel.Size = UDim2.fromOffset(40,40) 
FBLabel.Position = UDim2.fromOffset(0,0)

-- pulse outline
task.spawn(function()
    local t = 0
    while FloatBtn and FloatBtn.Parent do
        t += 0.04
        FBS.Transparency = 0.4 + math.sin(t) * 0.4
        task.wait(0.033)
    end
end)

do
    local d, ds, sp, moved = false, nil, nil, false
    
    FloatBtn.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            d = true 
            moved = false 
            ds = inp.Position 
            sp = FloatBtn.Position
        end
    end)
    
    
    UIS.InputChanged:Connect(function(inp)
        if not d then return end
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
            local dl = inp.Position - ds
            
            if dl.Magnitude > 5 then 
                moved = true 
            end
            
            if moved then
                local vp = workspace.CurrentCamera.ViewportSize
                FloatBtn.Position = UDim2.new(sp.X.Scale, math.clamp(sp.X.Offset+dl.X, 0, vp.X-50), sp.Y.Scale, math.clamp(sp.Y.Offset+dl.Y, 0, vp.Y-50))
            end
        end
    end)
    
    
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            if d then 
                d = false
                if not moved then 
                    Main.Visible = not Main.Visible 
                end
            end
        end
    end)
end

if shared._EndlessKeybindBind then shared._EndlessKeybindBind:Disconnect() end
shared._EndlessKeybindBind = UIS.InputBegan:Connect(function(inp, gp)
    if gp then return end
    if inp.KeyCode == Enum.KeyCode.RightShift then Main.Visible = not Main.Visible end
end)

pcall(function()
    Det_State = Det_State or {
        Infinity_Active = false,
        Infinity_Enabled = false,
        DeathSlash_Active = false,
        DeathSlash_Enabled = false,
        TimeHole_Active = false,
        TimeHole_Enabled = false,
        Pull_Active = false,
        Pull_Enabled = false,
        Slashes_Active = false,
        Slashes_Enabled = false,
        Forcefield_Active = false,
        Forcefield_Enabled = false
    }
end)

pcall(function()
    ReplicatedStorage.Remotes.InfinityBall.OnClientEvent:Connect(function(Ball, Status)
        if Det_State then
            Det_State.Infinity_Active = Status or false
        end
        if Ball and type(parryLocked) == "table" then
            parryLocked[Ball] = Status or false
            if not Status and type(lockTime) == "table" then
                lockTime[Ball] = 0
            end
        end
    end)
end)

pcall(function()
    ReplicatedStorage.Remotes.DeathBall.OnClientEvent:Connect(function(Ball, Status)
        if Det_State then
            Det_State.DeathSlash_Active = Status or false
        end
        if Ball and type(parryLocked) == "table" then
            parryLocked[Ball] = Status or false
            if not Status and type(lockTime) == "table" then
                lockTime[Ball] = 0
            end
        end
    end)
end)

pcall(function()
    ReplicatedStorage.Remotes.PlrPulled.OnClientEvent:Connect(function(A, B)
        if Det_State then
            Det_State.Pull_Active = (type(A) == "boolean" and A) or (type(B) == "boolean" and B) or true
        end
        
        ball = type(Auto_Parry) == "table" and type(Auto_Parry.Get_Ball) == "function" and Auto_Parry.Get_Ball()
        
        if ball and type(parryLocked) == "table" then
            parryLocked[ball] = true
            
            task.delay(0.75, function()
                if Det_State then
                    Det_State.Pull_Active = false
                end
                if ball and type(parryLocked) == "table" then
                    parryLocked[ball] = false
                end
                if ball and type(lockTime) == "table" then
                    lockTime[ball] = 0
                end
                if ball and type(shared.InvisClearLock) == "function" then
                    pcall(shared.InvisClearLock, ball)
                end
            end)
        end
    end)
end)

pcall(function()
    LocalPlayer.CharacterAdded:Connect(function(Char)
        if Det_State then
            Det_State.Forcefield_Active = false
        end
        goo = false
        Char.AttributeChanged:Connect(function(Attr)
            if Attr == "PassiveLock_ForceField" then
                currentState = Char:GetAttribute("PassiveLock_ForceField") == true
                if Det_State then
                    Det_State.Forcefield_Active = currentState
                end
                goo = currentState
            end
        end)
    end)
    if LocalPlayer.Character then
        LocalPlayer.Character.AttributeChanged:Connect(function(Attr)
            if Attr == "PassiveLock_ForceField" then
                currentState = LocalPlayer.Character:GetAttribute("PassiveLock_ForceField") == true
                if Det_State then
                    Det_State.Forcefield_Active = currentState
                end
                goo = currentState
            end
        end)
    end
end)

pcall(function()
    NetPackage = ReplicatedStorage:FindFirstChild("Packages")
    NetPackage = NetPackage and NetPackage:FindFirstChild("_Index")
    NetPackage = NetPackage and NetPackage:FindFirstChild("sleitnick_net@0.1.0")
    NetPackage = NetPackage and NetPackage:FindFirstChild("net")
    if NetPackage then
        TimeHoleActivate = NetPackage:FindFirstChild("RE/TimeHoleActivate")
        TimeHoleDeactivate = NetPackage:FindFirstChild("RE/TimeHoleDeactivate")
        SlashesActivate = NetPackage:FindFirstChild("RE/SlashesOfFuryActivate")
        SlashesEnd = NetPackage:FindFirstChild("RE/SlashesOfFuryEnd")

        if TimeHoleActivate then
            TimeHoleActivate.OnClientEvent:Connect(function()
                Det_State.TimeHole_Active = true
            end)
        end
        if TimeHoleDeactivate then
            TimeHoleDeactivate.OnClientEvent:Connect(function()
                if Det_State then
                    Det_State.TimeHole_Active = false
                end
                
                ball = type(Auto_Parry) == "table" and type(Auto_Parry.Get_Ball) == "function" and Auto_Parry.Get_Ball()
                
                if ball then
                    if type(parryLocked) == "table" then
                        parryLocked[ball] = false
                    end
                    if type(lockTime) == "table" then
                        lockTime[ball] = 0
                    end
                    if activeParryTasks and activeParryTasks[ball] then
                        task.cancel(activeParryTasks[ball])
                        activeParryTasks[ball] = nil
                    end
                    if type(shared.InvisClearLock) == "function" then
                        pcall(shared.InvisClearLock, ball)
                    end
                end
            end)
        end
        if SlashesActivate then
            SlashesActivate.OnClientEvent:Connect(function()
                if Det_State then
                    Det_State.Slashes_Active = true
                end
                
                shared.ManualSpamActive = false
                
                ball = type(Auto_Parry) == "table" and type(Auto_Parry.Get_Ball) == "function" and Auto_Parry.Get_Ball()
                
                if ball and type(parryLocked) == "table" then
                    parryLocked[ball] = true
                end
            end)
        end
        if SlashesEnd then
            SlashesEnd.OnClientEvent:Connect(function()
                if Det_State then
                    Det_State.Slashes_Active = false
                end
                
                ball = type(Auto_Parry) == "table" and type(Auto_Parry.Get_Ball) == "function" and Auto_Parry.Get_Ball()
                
                if ball and ball.Parent then
                    targetAttr = ball:GetAttribute("target") or ball:GetAttribute("Target")
                    isTargetingMe = (tostring(targetAttr or "") == game.Players.LocalPlayer.Name)
                    
                    if isTargetingMe then
                        currentReaction = 0
                        if matchStats and matchStats.ReactionTime then
                            currentReaction = tonumber(matchStats.ReactionTime) or 0
                        end
                        
                        if currentReaction < 0.5 then
                            if type(Auto_Parry.FireParryRemote) == "function" then
                                pcall(function()
                                    Auto_Parry.FireParryRemote(false)
                                end)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

--==========================================================
-- OPEN DEFAULT TAB
--==========================================================
do
    local first = Tabs["combat"]
    if first then
        first.Btn.BackgroundColor3 = CW
        first.Btn.TextColor3 = CB
        first.Stroke.Color = CW
    end
    if TabPages["combat"] then TabPages["combat"].Visible = true end
    ActiveTab = "combat"
end

HttpService = game:GetService("HttpService")
Illusion_Config_File = "IllusionHub_Config.json"

function SaveIllusionConfig()
    xpcall(function()
        if writefile and type(Config) == "table" then
            writefile(Illusion_Config_File, HttpService:JSONEncode(Config))
        end
    end, function(err)
        print("Illusion Save Config Error: " .. tostring(err))
    end)
end

function LoadIllusionConfig()
    xpcall(function()
        if isfile and isfile(Illusion_Config_File) then
            decodedConfig = HttpService:JSONDecode(readfile(Illusion_Config_File))
            if decodedConfig and type(decodedConfig) == "table" then
                for key, value in pairs(decodedConfig) do
                    Config[key] = value
                end
            end
        end
    end, function(err)
        print("Illusion Load Config Error: " .. tostring(err))
    end)
end

task.spawn(function()
    LoadIllusionConfig()
    while shared._EndlessRunning do
        task.wait(5)
        SaveIllusionConfig()
    end
end)

game:GetService("Players").LocalPlayer.OnTeleport:Connect(SaveIllusionConfig)

loadstring(game:HttpGet("https://raw.githubusercontent.com/foreverspacexc-blip/Image/refs/heads/main/breakerr.txt"))()
