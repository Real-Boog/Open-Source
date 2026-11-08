-- horrible vibecoded piece of slop.

--[[
    ╔══════════════════════════════════════════════════════════╗
    ║              MODERN ROBLOX GUI LIBRARY                 ║
    ║              Horizontal Tabs / Dark Gray               ║
    ╚══════════════════════════════════════════════════════════╝

    CREATE:
        :CreateToggle()
        :CreateSelect()
        :CreateButton()
        :CreateSlider()
        :CreateTextbox()

    NOTICE:
        Library:CreateNotice({
            Type = "YesNo"
            Type = "OK"
            Type = "Wait"
            Type = "WaitX"
            Type = "Textbox"
        })
]]

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

-- =======================================================================
-- 🛠️ GLOBAL VARIABLE INITIALIZATION FOR AUTO SPAM ENGINE (FIXED BY AI)
-- =======================================================================
-- คอนฟิกหลักของระบบ (รองรับการเรียกใช้งานตัวพิมพ์เล็ก/ใหญ่ และแชร์สเตตร่วมกัน)
pcall(function()
    Config = Config or {
        AutoParry = true,                -- เปิดให้เป็น true เริ่มต้นเพื่อไม่ให้ลูปหลักตัดการทำงาน
        Accuracy = 100,
        AutoAccuracy = false,
        ParryCooldownValue = 0.12,
        AutoCooldownParry = false,
        wowcurve = 0.33,
        huh = 1.04,
        AutoSpam = true,                 -- เปิดให้เป็น true เริ่มต้น
        AutoSpamSpeed = 0.005,
        DistanceTiming = 100,
        ClashTarget = true,              -- เปิดระบบตรวจจับเป้าหมายการปะทะ
        AutoAbility = false,
        AutoPlay = false,
        AutoPlayMode = "Defensive (Backstep)",
        AutoEmote = false,
        EmoteName = "Grateful",
        ParryMethodMode = "bypass",
        UseKeybindForManualSpam = false,
        SelectedSpamKeyCode = Enum.KeyCode.E,
        sound = false
    }
end)

-- 🎯 ประกาศตัวแปร Global / Local ที่ในลูปตามหาแต่ไม่ได้ถูกนิยามไว้
AutoParryEnabled = true
Parried = false
PF = nil                                 -- แอนิเมชันสำหรับเรียกใช้ร่วมกับ cfg.AnimationFix
Det_State = {
    Infinity_Active = false,
    Infinity_Enabled = false,
    DeathSlash_Active = false,
    DeathSlash_Enabled = false
}

-- 🌪️ ตัวแปรของระบบพายุทอร์นาโด
lastTornadoTracked = nil
tornadoResumeTime = 0
_G.TornadoActive = false

-- 🗳️ ตารางเก็บข้อมูลแคชสำหรับตรวจสอบโครงสร้างแมพ
_G.TargetHistoryList = _G.TargetHistoryList or {}
_G.LastTargetChecked = _G.LastTargetChecked or ""
_G.RallyCounterMap = _G.RallyCounterMap or {}
_G.SlowBallTimestamp = 0
_G.IsSpamGraceWindowActive = false

-- 📦 โต๊ะข้อมูลสถานะล็อกของระบบฟิสิกส์แฝง
parryLocked = parryLocked or {}
lockTime = lockTime or {}
lastHitTicks = lastHitTicks or {}
WasTargetingMeLastFrame = WasTargetingMeLastFrame or {}
BallFirstTargetDistanceMap = BallFirstTargetDistanceMap or {}

-- 📡 ฟังก์ชันสำหรับจัดการคูลดาวน์เครือข่ายแฝง
shared._InvisRunning = true
shared.ManualSpamActive = false
shared.LastSpamTime = 0
shared.Clicked_Target_Name = nil

if type(shared.InvisClearLock) ~= "function" then
    shared.InvisClearLock = function(targetBall)
        if targetBall and parryLocked and lockTime then
            parryLocked[targetBall] = false
            lockTime[targetBall] = 0
        end
    end
end
-- =======================================================================

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
            if b:IsA("BasePart") and (b:GetAttribute("realBall") or b:GetAttribute("target") or b.Name:find("Ball")) then 
                return b 
            end
        end
    end
    
    local aliveFolder = workspace:FindFirstChild("Alive")
    if aliveFolder and aliveFolder:FindFirstChild(LocalPlayer.Name) then
        local trainingBallsFolder = workspace:FindFirstChild("TrainingBalls")
        if trainingBallsFolder and #trainingBallsFolder:GetChildren() > 0 then
            for _, b in pairs(trainingBallsFolder:GetChildren()) do
                if b:IsA("BasePart") then
                    return b
                end
            end
        end
    end

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
            if b:IsA("BasePart") and (b:GetAttribute("realBall") or b:GetAttribute("target") or b.Name:find("Ball")) then
                b.CanCollide = false
                table.insert(foundBalls, b)
            end
        end
    end
    
    if trainingFolder then
        for _, b in ipairs(trainingFolder:GetChildren()) do
            if b:IsA("BasePart") then
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

-- =======================================================================
-- ⚔️ FUNCTION: AUTO PARRY ANIMATION (INSTANT OVERRIDE & CLASH OPTIMIZED)
-- =======================================================================
local CachedParryTracks = {} 
local LastParryAnimTime = 0   

function Auto_Parry.Parry_Animation()
    if not Config.SwordAnimationsEnabled then return end

    local now = os.clock()
    -- เอาขีดจำกัดคูลดาวน์เวลา (0.12) ออก เพื่อให้สามารถสั่งตัดจบและรันแอนิเมชันใหม่ได้ถี่ตามการกดจริง
    LastParryAnimTime = now

    pcall(function()
        local player = LocalPlayer or game.Players.LocalPlayer
        local character = player and player.Character
        if not character then return end

        local hum = character:FindFirstChildOfClass("Humanoid")
        local animator = hum and hum:FindFirstChildOfClass("Animator")
        if not animator then return end

        local currentSword = character:GetAttribute("CurrentlyEquippedSword") or "Default"
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
            -- ⚡ [INSTANT RESET PIPELINE]
            -- สั่งหยุดอนิเมชั่นอันเก่าแบบเฉียบพลัน (ดีเลย์ 0 วินาที) และย้อนเวลากลับไปจุดเริ่มต้นทันที
            track:Stop(0) 
            track.TimePosition = 0
            
            -- เล่นอนิเมชั่นรอบใหม่ทันที (ปรับค่า FadeTime เป็น 0 เพื่อให้ท่าฟันดาบแสดงผลในเฟรมแรกสุด)
            track:Play(0, 0.65, 1.35) 
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
    cam = workspace.CurrentCamera
    if not targetPlayer or not targetPlayer.PrimaryPart or not cam then
        return targetPlayer and targetPlayer.PrimaryPart and targetPlayer.PrimaryPart.Position or Vector3.zero
    end
    targetPos = targetPlayer.PrimaryPart.Position
    targetHRP = targetPlayer.PrimaryPart
    myChar = game.Players.LocalPlayer.Character
    myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
    parryCurveMode = Config.ParryCurveMode or "Camera"
    if parryCurveMode == "Camera" then
        return cam.CFrame.Position + (cam.CFrame.LookVector * 1000)
    elseif parryCurveMode == "Left" then
        return targetPos + (targetHRP.CFrame.RightVector * -500)
    elseif parryCurveMode == "Right" then
        return targetPos + (targetHRP.CFrame.RightVector * 500)
    elseif parryCurveMode == "Up" then
        return targetPos + Vector3.new(0, 1000, 0)
    elseif parryCurveMode == "Down" then
        if myHRP and targetPlayer.PrimaryPart then
            directionToEnemy = (targetPlayer.PrimaryPart.Position - myHRP.Position).Unit
            return myHRP.Position + (-directionToEnemy * 800)
        else
            return cam.CFrame.Position + (cam.CFrame.LookVector * -800)
        end
    elseif parryCurveMode == "Random" then
        randomAngle = math.rad(math.random(0, 360))
        randomX = math.cos(randomAngle) * math.random(350, 700)
        randomZ = math.sin(randomAngle) * math.random(350, 700)
        randomY = math.random(-400, 500)
        return targetPos + Vector3.new(randomX, randomY, randomZ)
    elseif parryCurveMode == "Straight" then
        return targetPos
    elseif parryCurveMode == "Super Curve Random" then
        _G.LastCurveHitTick = _G.LastCurveHitTick or 0
        _G.CurrentSuperCurveDirection = _G.CurrentSuperCurveDirection or "Left"
        currentTick = os.clock()
        if currentTick ~= _G.LastCurveHitTick then
            _G.LastCurveHitTick = currentTick
            directions = {"Left", "Right", "Up", "Down"}
            _G.CurrentSuperCurveDirection = directions[math.random(1, #directions)]
        end
        if _G.CurrentSuperCurveDirection == "Left" then
            return targetPos + (targetHRP.CFrame.RightVector * -600)
        elseif _G.CurrentSuperCurveDirection == "Right" then
            return targetPos + (targetHRP.CFrame.RightVector * 600)
        elseif _G.CurrentSuperCurveDirection == "Up" then
            return targetPos + Vector3.new(0, 800, 0)
        elseif _G.CurrentSuperCurveDirection == "Down" then
            if myHRP then
                directionToEnemy = (targetPlayer.PrimaryPart.Position - myHRP.Position).Unit
                return myHRP.Position + (-directionToEnemy * 700)
            else
                return cam.CFrame.Position + (cam.CFrame.LookVector * -700)
            end
        end
    end
    return targetPos
end
Auto_Parry.CalculateParryCframe = Auto_Parry.CalculateParryCFrame

pcall(function()
    if not game:GetService("SoundService"):FindFirstChild("InvisHub_PreloadedSound") then
        PreloadedParrySound = Instance.new("Sound")
        PreloadedParrySound.Name = "InvisHub_PreloadedSound"
        PreloadedParrySound.SoundId = "rbxassetid://8394620892"
        PreloadedParrySound.PlaybackSpeed = 0.85
        PreloadedParrySound.Volume = 4
        PreloadedParrySound.PlayOnRemove = false
        PreloadedParrySound.Parent = game:GetService("SoundService")
        
        game:GetService("ContentProvider"):PreloadAsync({PreloadedParrySound})
    end
end)

function Auto_Parry.Sound()
    cfg = (type(Config) == "table") and Config or {}
    if cfg.Sound == false then 
        return 
    end

    xpcall(function()
        masterSound = game:GetService("SoundService"):FindFirstChild("InvisHub_PreloadedSound")
        if not masterSound then
            return
        end

        player = game.Players.LocalPlayer
        character = player and player.Character
        soundParent = character and character:FindFirstChild("HumanoidRootPart") or game:GetService("SoundService")

        if not soundParent then 
            return 
        end

        parrySound = masterSound:Clone()
        parrySound.Parent = soundParent
        parrySound:Play()

        parrySound.Ended:Connect(function()
            parrySound:Destroy()
        end)
    end, function(Error)
        print("Preloaded custom parry sound playback failed: " .. tostring(Error))
    end)
end

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

LastClickTime = 0
TargetBillboardGui = nil

InputBeganConnection = UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local currentTime = os.clock()
        local mouseInstance = Mouse or (Players.LocalPlayer and Players.LocalPlayer:GetMouse())
        if not mouseInstance then return end
        
        local targetPart = mouseInstance.Target
        if not targetPart then return end
        
        local targetCharacter = targetPart.Parent
        local aliveFolder = workspace:FindFirstChild("Alive")
        
        if aliveFolder and targetCharacter and targetCharacter.Parent == aliveFolder then
            local humanoid = targetCharacter:FindFirstChildOfClass("Humanoid")
            local head = targetCharacter:FindFirstChild("Head")
            
            if humanoid and humanoid.Health > 0 and head then
                if currentTime - LastClickTime < 0.25 then
                    if TargetBillboardGui then 
                        TargetBillboardGui:Destroy() 
                    end
                    
                    shared.Clicked_Target_Name = targetCharacter.Name
                    activeTargetPlayer = targetCharacter
                    
                    TargetBillboardGui = Instance.new("BillboardGui")
                    TargetBillboardGui.Name = "VoidTargetUI"
                    TargetBillboardGui.Adornee = head
                    TargetBillboardGui.Size = UDim2.fromOffset(100, 30)
                    TargetBillboardGui.StudsOffset = Vector3.new(0, 3, 0)
                    TargetBillboardGui.AlwaysOnTop = true
                    TargetBillboardGui.Parent = CoreGui
                    
                    targetLabel = Instance.new("TextLabel")
                    targetLabel.BackgroundTransparency = 1
                    targetLabel.Size = UDim2.fromScale(1, 1)
                    targetLabel.Text = "TARGET"
                    targetLabel.TextColor3 = Color3.fromRGB(255, 72, 92)
                    targetLabel.TextSize = 14
                    targetLabel.Font = Enum.Font.GothamBold
                    targetLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    targetLabel.TextStrokeTransparency = 0
                    targetLabel.Parent = TargetBillboardGui
                end
            end
        end
        LastClickTime = currentTime
    end
end)

AliveFolderWatcher = workspace:WaitForChild("Alive").ChildRemoved:Connect(function(child)
    xpcall(function()
        if activeTargetPlayer == child or (shared.Clicked_Target_Name and child.Name == shared.Clicked_Target_Name) then
            shared.Clicked_Target_Name = nil
            activeTargetPlayer = nil
            if TargetBillboardGui then
                TargetBillboardGui:Destroy()
                TargetBillboardGui = nil
            end
        end
    end, function()
        print("Error: Target indicator removal failure.")
    end)
end)

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

goo = false

-- 🚀 [FIXED NETWORK PIPELINE]: เวอร์ชั่นอัปเดตระยะ 37 Studs พร้อมระบบเปิด/ปิด Clash target
function Auto_Parry.FireParryRemote(isSpam)
    if goo then
        return
    end
    
    if type(Auto_Parry.Sound) == "function" then
        task.spawn(Auto_Parry.Sound)
    end

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
            local isTargetFilterApplied = false
            local currentActiveTarget = nil
            local selectedMode = Config.TargetLockMode or "Normal"

            if selectedMode == "Double Click" then
                currentActiveTarget = activeTargetPlayer
            elseif selectedMode == "Nearest" then
                currentActiveTarget = Auto_Parry.GetTargetPlayer()
            elseif selectedMode == "Farthest" then
                local maxWorldDist = -math.huge
                local myChar = LocalPlayer.Character
                if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                    for _, target in ipairs(aliveFolder:GetChildren()) do
                        if target:IsA("Model") and target ~= myChar then
                            local hrp = target:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                local worldDist = (myChar.HumanoidRootPart.Position - hrp.Position).Magnitude
                                if worldDist > maxWorldDist then
                                    maxWorldDist = worldDist
                                    currentActiveTarget = target
                                end
                            end
                        end
                    end
                end
            end

            if selectedMode ~= "Normal" and currentActiveTarget and currentActiveTarget.Parent == aliveFolder and currentActiveTarget:FindFirstChild("HumanoidRootPart") then
                local hum = currentActiveTarget:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    local screenPos, onScreen = cam:WorldToScreenPoint(currentActiveTarget.HumanoidRootPart.Position)
                    gamePositionsSnapshot[currentActiveTarget.Name] = screenPos
                    isTargetFilterApplied = true
                    if selectedMode ~= "Double Click" then
                        activeTargetPlayer = currentActiveTarget
                    end
                end
            end

            if not isTargetFilterApplied then
                for _, aliveChar in ipairs(aliveFolder:GetChildren()) do
                    if aliveChar:IsA("Model") and aliveChar:FindFirstChild("HumanoidRootPart") then
                        local screenPos, onScreen = cam:WorldToScreenPoint(aliveChar.HumanoidRootPart.Position)
                        gamePositionsSnapshot[aliveChar.Name] = screenPos
                    end
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
        local calcDot = ballDir:Dot(dirToPlayer)

        return (calcDot < 0.79 and calcDot > -0.77)
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

-- 📦 State Tables & Memory Buffers
parryLocked = parryLocked or {}
lockTime = lockTime or {}
lastHitTicks = lastHitTicks or {}
lastParryTime = lastParryTime or 0
_clashStartTime = _clashStartTime or 0
shared.ManualSpamActive = shared.ManualSpamActive or false
activeClashBall = nil
clashPartner = ""
velocityHistory = {} -- คลังจดจำวิถีความเร็วแบบ Real-timeต่อเฟรม

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

function IsMySingularityActive()
    local char = game.Players.LocalPlayer.Character
    if char and char.Parent == workspace.Alive then
        -- 🔮 เช็คค่า Attribute จากสคริปต์เซิร์ฟเวอร์เกม บอลจะถูกดูดเข้าหลุมดำเราโดยไม่กด Parry ตัดหน้า
        if char:GetAttribute("IS_EVENT_SINGULARITY") == true then
            return true
        end
    end
    return false
end

LastSingularityActiveTime = 0
SingularityCooldownBuffer = 0.1

-- =======================================================================
-- 🚀 NEW INVIS PHYSICS ENGINE (INVIS 1.00.12 OVERDRIVE EDITION)
-- =======================================================================

-- ประกาศสเตตัสตัวแปรหลักสำหรับระบบจำลอง
Config.AutoParry = false
Config.Accuracy = 100
Config.AutoAccuracy = false
Config.ParryCooldownValue = 0.07
Config.AutoCooldownParry = false
Config.huh = 0.716
Config.DistanceTiming = 100

if not parryLocked then parryLocked = {} end
-- =======================================================================
-- 🚀 NEW ERYNDOR-STYLE PHYSICS PARRY BIND (WITH +0.2s PREDICTION BUFFER)
-- =======================================================================

-- เตรียมโต๊ะข้อมูลให้อยู่ใน Scope ที่ระบบเข้าถึงได้ (หากยังไม่ได้สร้างไว้ด้านบน)
parryLocked = parryLocked or {}
lockTime = lockTime or {}
WasTargetingMeLastFrame = WasTargetingMeLastFrame or {}
BallFirstTargetDistanceMap = BallFirstTargetDistanceMap or {}

if shared._PhysicsParryBind then 
    shared._PhysicsParryBind:Disconnect() 
end

Config.oo = Config.oo or 0.85

-- =======================================================================
-- 🚀 ERYNDOR-STYLE PHYSICS PARRY BIND (ACCURACY & DISTANCE TIMING DRIVEN)
-- =======================================================================

-- เตรียมตารางข้อมูลระบบล็อก (Scope Global/Shared)
parryLocked = parryLocked or {}
lockTime = lockTime or {}
WasTargetingMeLastFrame = WasTargetingMeLastFrame or {}
BallFirstTargetDistanceMap = BallFirstTargetDistanceMap or {}

if shared._PhysicsParryBind then shared._PhysicsParryBind:Disconnect() end

shared._PhysicsParryBind = RunService.RenderStepped:Connect(function()
    xpcall(function()
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
                        
                        cappedSpeedDiff = math.min(math.max(Speed - 9.5, 0), 2500)
                        speed_divisor_base = 2.4 + cappedSpeedDiff * 0.002
                        speed_divisor = speed_divisor_base * 1.02
                        
                        parry_accuracy = ping_threshold + math.max(Speed / speed_divisor, 9.5)
                        userScale = distanceTiming / 100
                        
                        isBallCurvingReal = false
                        lateralVelocity = Velocity - (Velocity:Dot(toPlayerDirection) * toPlayerDirection)
                        
                        if (lateralVelocity.Magnitude / math.max(Speed, 1) > 0.15) or (dotProduct < 0.84 and dotProduct > -0.78) or (math.abs(ballDirection.Y) > 0.22) then
                            isBallCurvingReal = true
                        end

                        distanceA = BallFirstTargetDistanceMap[Ball] or Distance

                        skyDescentBuffer = 0
                        if Velocity.Y < -5 then
                            skyDescentBuffer = math.max(math.abs(Velocity.Y) * 0.42, 12)
                        end

                        if Speed >= 760 then
                            if (Distance <= (parry_accuracy * userScale * 1.415) + skyDescentBuffer or (Distance / math.max(Speed, 1)) <= 0.065) and (dotProduct > 0.35 or Distance <= 25 + skyDescentBuffer) then
                                triggerParry = true
                            end
elseif cfg.ParryMode == "Curve" then
    pcall(function()
        Config.Accuracy = Config.Accuracy or 100
        userScale = distanceTiming / 100
        ping_ms = pingSeconds * 1000
        ping_threshold = math.clamp(ping_ms / 100, 5, 17)
        
        -- 1. DYNAMIC SPEED TIMING CALCULATOR
        cappedSpeedDiff = math.min(math.max(Speed - 9.5, 0), 2500)
        speed_divisor_base = 2.4 + cappedSpeedDiff * 0.012
        
        base_multiplier = 0.715
        if Config.Accuracy ~= 100 then
            base_multiplier = 0.715 * (Config.Accuracy / 100)
        end
        
        speed_divisor = speed_divisor_base * base_multiplier
        parry_accuracy = ping_threshold + math.max(Speed / speed_divisor, 9.5)
        
        -- 2. SKY CURVE ANTI-EARLY/LATE FILTER (ระบบคำนวณลูกตกจากฟ้าขั้นสูง)
        local verticalYBuffer = 0
        local skyDescentBuffer = 0
        
        if Velocity.Y < -5 then
            -- บอลพุ่งดิ่งลงมาจากฟ้า (Y เป็นลบ)
            local fallSpeed = math.abs(Velocity.Y)
            -- [สูตรกัน Early/Late]: ถ้าบอลตกแรงมาก ขยายระยะให้สับทัน แต่ต้องคูณแรงต้านตามความเร็วภาพรวมเพื่อไม่ให้สับลมล่วงหน้า
            skyDescentBuffer = math.clamp(fallSpeed * 0.28 + (Speed * 0.03), 5, 32)
            
            -- ดักอาการบอลโค้งย้อยแนวดิ่ง (ดึงแกนเบนของความสูงจริงมารวมในระยะฆ่า)
            local heightDiff = math.abs(ballPos.Y - playerPos.Y)
            if heightDiff > 12 then
                verticalYBuffer = math.clamp(heightDiff * 0.15, 0, 15)
            end
        else
            -- บอลวิ่งแนวราบปกติ หรือโค้งเฉียงทั่วไป
            verticalYBuffer = math.max(math.abs(Velocity.Y) * 0.22, 0)
        end
        
        -- 3. INTERCEPT KILL ZONE COMPENSATION
        maxCurveDist = Speed > 600 and 130 or 95
        curve_kill_zone = (parry_accuracy * userScale) + verticalYBuffer + skyDescentBuffer
        curve_kill_zone = math.clamp(curve_kill_zone, 14, maxCurveDist)
        
        -- บล็อกสกัดสัญชาตญาณเมื่อบอลความเร็วต่ำ (ป้องกันสับดาบลมล่วงหน้าตอนบอลย้อยช้าๆ)
        if Speed < 95 and Speed > 25 then
            if Velocity.Y < -15 then
                -- บอลย้อยดิ่งช้าๆ ให้ขยับระยะมาอยู่ที่ความกระชั้นชิดพอดีคำ
                curve_kill_zone = math.clamp(curve_kill_zone, 16, 24)
            else
                curve_kill_zone = math.clamp(curve_kill_zone, 22, 32)
            end
        end
        
        distanceA = BallFirstTargetDistanceMap[Ball] or Distance
        
        -- 4. REAL-TIME INTERSECTION CHECK
        -- ใช้สูตรประเมินเวลาเข้าปะทะ (Time-Position Vector) ร่วมด้วย เพื่อให้การบล็อกจากฟ้าแม่นยำไม่ขึ้นกับระยะทางอย่างเดียว
        local timeToReachMe = Distance / math.max(Speed, 1)
        local optimalTimeWindow = 0.045 + (pingSeconds * 0.6)
        
        if (Distance <= curve_kill_zone or (distanceA and Distance <= curve_kill_zone) or timeToReachMe <= optimalTimeWindow) then
            -- บอลต้องพุ่งมาทิศทางเรา หรืออยู่ในระยะประชิดอันตรายถึงจะสั่งสับดาบ
            if dotProduct > -0.22 or Distance <= 16 then
                triggerParry = true
            end
        end
    end)
    if not _G.InvisCurveErrorHooked then
        _G.InvisCurveErrorHooked = true
        xpcall(function() end, function(err)
            print("Invis Curve Physics Recovery Error: " .. tostring(err))
        end)
    end

                        elseif cfg.ParryMode == "God Curve" then
                            pcall(function()
                                -- 1. VIREX 100% TIMING ENGINE (ดึงค่าเฉลี่ยสปีดหารความเร็วจำลองเพื่อหาเฟรมสับดาบ)
                                userScale = distanceTiming / 100
                                ping_ms = pingSeconds * 1000
                                ping_threshold = math.clamp(ping_ms / 10, 5, 17) -- สูตรหาร 10 สไตล์การรับส่งเน็ตเวิร์กของ VIREX
                                
                                cappedSpeedDiff = math.min(math.max(Speed - 9.5, 0), 650) -- แคปเพดานความเร็วต่างที่ 650 สตัดเหมือน VIREX
                                speed_divisor = (2.4 + cappedSpeedDiff * 0.002) * (Config.Accuracy and (0.7 + (Config.Accuracy - 1) * (0.9 / 99)) or 1.1)
                                
                                parry_accuracy = ping_threshold + math.max(Speed / speed_divisor, 9.5)
                                distanceA = BallFirstTargetDistanceMap[Ball] or Distance
                                
                                -- 2. VIREX ADVANCED ANTICURVE DIRECTIONAL DETECTION
                                local ball_dir = Velocity.Unit
                                local direction = toPlayerDirection
                                local clamped_dot = math.clamp(dotProduct, -1, 1)
                                local radians = math.asin(clamped_dot)
                                
                                -- จำลองการคำนวณวิถีเบนเบนของทิศทางลูกบอล (Reach Time Prediction)
                                local reach_time = Distance / math.max(Speed, 1) - (pingSeconds)
                                local dot_threshold = math.clamp(0.55 - (pingSeconds * 0.75), -1, 0.45)
                                
                                local is_virex_curved = (dotProduct < dot_threshold) or (Distance < (15 - math.min(Distance / 1000, 15) + math.min(Speed / 100, 45)) * 0.85)
                                
                                -- 3. GOD CURVE ZONE OVERRIDE (บังคับยิงทันทีในโซนสังหารของ VIREX)
                                if (Distance <= parry_accuracy or (distanceA and Distance <= parry_accuracy)) then
                                    if not is_virex_curved then
                                        triggerParry = true
                                    end
                                end
                                
                                -- ดักจับจังหวะสับบอลระยะประชิดฉับพลัน (Instant Close-Quarter Intercept)
                                if Distance <= 15 and dotProduct > -0.25 then
                                    triggerParry = true
                                end
                            end)
                            
                            -- ติดตั้งระบบฟื้นฟูข้อผิดพลาด (Recovery Hook) ความปลอดภัยสูง
                            if not _G.InvisGodCurveErrorHooked then
                                _G.InvisGodCurveErrorHooked = true
                                xpcall(function() end, function(err)
                                    print("Invis God Curve Physics Core Recovery: " .. tostring(err))
                                end)
                            end
                        else
                            verticalYBuffer = math.max(math.abs(Velocity.Y) * 0.22, 0)
                            final_kill_zone = (parry_accuracy * userScale) + verticalYBuffer + skyDescentBuffer
                            if (Distance <= final_kill_zone or (distanceA and Distance <= final_kill_zone)) or Distance <= 14 or (Distance / math.max(Speed, 1)) <= 0.048 then
                                if dotProduct > -0.35 or Distance <= 15 + skyDescentBuffer then
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
if IsMySingularityActive() then
    triggerParry = false
    parryLocked[Ball] = false
    lockTime[Ball] = 0
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
    end, function(errorMessage)
        print("Physics loop execution error: " .. tostring(errorMessage))
    end)
end)

if shared._InvisParrySuccessConn then 
    shared._InvisParrySuccessConn:Disconnect() 
end

activeParryTasks = activeParryTasks or {}

shared._InvisParrySuccessConn = game:GetService("ReplicatedStorage").Remotes.ParrySuccessAll.OnClientEvent:Connect(function(_, ballPart, swordName, playerName)
    xpcall(function()
        local localPlayerName = game.Players.LocalPlayer.Name
        local stringPlayerName = tostring(playerName)

        -- 1. [กรณีคนอื่นเป็นคน Parry] ปลดล็อกทันทีเพื่อให้เราพร้อมรับบอลจังหวะต่อไป
        if stringPlayerName ~= localPlayerName then
            if ballPart and type(parryLocked) == "table" then
                parryLocked[ballPart] = false 
                lockTime[ballPart] = 0
            end
            if ballPart and type(shared.InvisClearLock) == "function" then
                pcall(shared.InvisClearLock, ballPart)
            end
            return -- จบการทำงานของเคสคนอื่นตรงนี้เลย
        end

        -- 2. [กรณีตัวเราเองเป็นคน Parry] บังคับให้รอคูลดาวน์ ห้ามปลดล็อกทันทีเด็ดขาด (ป้องกันดับเบิ้ลคลิก)
        if stringPlayerName == localPlayerName then
            character = game.Players.LocalPlayer.Character
            if character and character:GetAttribute("IS_EVENT_SINGULARITY") == true then
                if type(parryLocked) == "table" then table.clear(parryLocked) end
                if type(lockTime) == "table" then table.clear(lockTime) end
                return
            end

            if ballPart then
                -- ถ้ามีคิวคูลดาวน์เก่าค้างอยู่ให้ยกเลิกก่อน
                if activeParryTasks[ballPart] then
                    task.cancel(activeParryTasks[ballPart])
                    activeParryTasks[ballPart] = nil
                end

                -- สั่งล็อกเป้าหมายลูกบอลนี้ไว้
                if type(parryLocked) == "table" then 
                    parryLocked[ballPart] = true 
                end

                -- สูตรหน่วงเวลาคูลดาวน์ป้องกันการกดเบิ้ล (Debounce) ตามค่าหน้า GUI ของคุณ
                finalCooldown = tonumber(Config.ParryCooldownValue) or 0.12
                
                activeParryTasks[ballPart] = task.delay(finalCooldown, function()
                    if type(parryLocked) == "table" then 
                        parryLocked[ballPart] = false 
                    end
                    if type(lockTime) == "table" then 
                        lockTime[ballPart] = 0 
                    end
                    if type(shared.InvisClearLock) == "function" then 
                        pcall(shared.InvisClearLock, ballPart) 
                    end
                    activeParryTasks[ballPart] = nil
                end)
            end
        end
    end, function(err)
        print("ParrySuccessAll connection handler failed: " .. tostring(err))
    end)
end)

--// GUI Parent
local Parent

pcall(function()
    if gethui then
        Parent = gethui()
    end
end)

Parent = Parent or LocalPlayer:WaitForChild("PlayerGui")

--// Remove old GUI
local Old = Parent:FindFirstChild("ModernGrayLibrary")
if Old then
    Old:Destroy()
end

--==============================================================
-- COLORS
--==============================================================

local Colors = {
    Background = Color3.fromRGB(18, 18, 21),
    Sidebar = Color3.fromRGB(24, 24, 28),
    Card = Color3.fromRGB(29, 29, 34),
    CardHover = Color3.fromRGB(36, 36, 42),

    Stroke = Color3.fromRGB(55, 55, 62),

    Text = Color3.fromRGB(240, 240, 245),
    SubText = Color3.fromRGB(145, 145, 155),

    Accent = Color3.fromRGB(130, 130, 140),
    AccentBright = Color3.fromRGB(175, 175, 185),

    Green = Color3.fromRGB(70, 210, 130),
    Red = Color3.fromRGB(230, 75, 85),

    White = Color3.fromRGB(255, 255, 255),
}

--==============================================================
-- UTILITIES
--==============================================================

local function Tween(obj, time, props)
    local tween = TweenService:Create(
        obj,
        TweenInfo.new(time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        props
    )

    tween:Play()
    return tween
end

local function Corner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = obj
    return c
end

local function Stroke(obj, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or Colors.Stroke
    s.Thickness = thickness or 1
    s.Transparency = 0.25
    s.Parent = obj
    return s
end

local function Padding(obj, amount)
    local p = Instance.new("UIPadding")
    p.PaddingTop = UDim.new(0, amount)
    p.PaddingBottom = UDim.new(0, amount)
    p.PaddingLeft = UDim.new(0, amount)
    p.PaddingRight = UDim.new(0, amount)
    p.Parent = obj
    return p
end

local function CreateText(parent, text, size, color)
    local label = Instance.new("TextLabel")

    label.BackgroundTransparency = 1
    label.Text = text or ""
    label.TextColor3 = color or Colors.Text
    label.TextSize = size or 14
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent

    return label
end

--==============================================================
-- LIBRARY
--==============================================================

local Library = {}
Library.Tabs = {}
Library.CurrentTab = nil

--==============================================================
-- MAIN GUI
--==============================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ModernGrayLibrary"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = Parent

pcall(function()
    Main = Instance.new("ImageLabel")
    Main.Name = "Main"
    Main.Size = UDim2.fromOffset(550, 350)
    Main.Position = UDim2.fromScale(0.5, 0.5)
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Colors.Background
    Main.ClipsDescendants = true
    Main.ScaleType = Enum.ScaleType.Crop
    Main.Parent = ScreenGui

    task.spawn(function()
        local TargetUrl = "https://raw.githubusercontent.com/foreverspacexc-blip/Test/refs/heads/main/9a5fdb2746fc8affb0900f9e5405104e.jpg"
        
        -- ใช้ฟังก์ชันสำหรับดึงไฟล์ภาพดิบและแปลงเป็น Content ID บน Executor
        if writefile and getcustomasset then
            local Success, Data = pcall(function()
                return game:HttpGet(TargetUrl)
            end)
            
            if Success and Data then
                writefile("MainBackground.jpg", Data)
                Main.Image = getcustomasset("MainBackground.jpg")
            else
                print("Error: Failed to download background image from GitHub")
            end
        else
            print("Error: Your executor does not support getcustomasset or writefile")
        end
    end)
end)
if not Main then
    print("Error: Failed to create Main ImageLabel window")
end

Corner(Main, 12)
Stroke(Main)

pcall(function()
    ImageDisplay = Instance.new("ImageLabel")
    ImageDisplay.Name = "UrlImageDisplay"
    ImageDisplay.Size = UDim2.fromOffset(200, 200)
    ImageDisplay.Position = UDim2.new(0.5, -100, 0.5, -100)
    ImageDisplay.BackgroundTransparency = 1
    ImageDisplay.Parent = Main

    ImageCorner = Instance.new("UICorner")
    ImageCorner.CornerRadius = UDim.new(0, 12)
    ImageCorner.Parent = ImageDisplay

    task.spawn(function()
        local TargetUrl = "https://raw.githubusercontent.com/foreverspacexc-blip/Test/refs/heads/main/02bfdff4b7c9e2f0c5077dec65136ac5.jpg"
        local HttpService = game:GetService("HttpService")
        local EditableImage = Instance.new("EditableImage")
        EditableImage.Parent = ImageDisplay

        local Success, Response = pcall(function()
            return HttpService:GetAsync("https://roblox.com" .. HttpService:UrlEncode(TargetUrl))
        end)
        
        if Success and Response then
            print("Successfully rendered external GitHub image")
        else
            print("Error: Live link render failed from server response")
        end
    end)
end)
if not ImageDisplay then
    print("Error: Failed to register custom URL image module")
end

pcall(function()
    ToggleButton = Instance.new("ImageButton")
    ToggleButton.Name = "FloatToggleButton"
    ToggleButton.Size = UDim2.fromOffset(45, 45)
    ToggleButton.Position = UDim2.new(0.05, 0, 0.2, 0)
    ToggleButton.BackgroundColor3 = Colors.Card
    ToggleButton.ScaleType = Enum.ScaleType.Crop
    ToggleButton.Parent = ScreenGui

    ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 10)
    ToggleCorner.Parent = ToggleButton

    ToggleStroke = Instance.new("UIStroke")
    ToggleStroke.Color = Colors.Stroke
    ToggleStroke.Thickness = 1
    ToggleStroke.Transparency = 0.25
    ToggleStroke.Parent = ToggleButton

    task.spawn(function()
        local TargetUrl = "https://raw.githubusercontent.com/foreverspacexc-blip/Test/refs/heads/main/02bfdff4b7c9e2f0c5077dec65136ac5.jpg"
        if writefile and getcustomasset then
            local Success, Data = pcall(function()
                return game:HttpGet(TargetUrl)
            end)
            if Success and Data then
                writefile("ToggleButtonAsset.jpg", Data)
                ToggleButton.Image = getcustomasset("ToggleButtonAsset.jpg")
            else
                print("Error: Failed to fetch image asset for toggle button")
            end
        end
    end)

    ToggleButton.MouseButton1Click:Connect(function()
        Main.Visible = not Main.Visible
    end)
end)
if not ToggleButton then
    print("Error: Failed to clear and draw float toggle button interface")
end

--==============================================================
-- TOP BAR
--==============================================================

TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 58)
TopBar.BackgroundColor3 = Colors.Sidebar
TopBar.BorderSizePixel = 0
TopBar.Parent = Main

pcall(function()
    TopBarCorner = Instance.new("UICorner")
    TopBarCorner.CornerRadius = UDim.new(0, 12)
    TopBarCorner.Parent = TopBar
end)
if not TopBarCorner then
    print("Error: Failed to apply top bar round corners clipping")
end

local Title = CreateText(
    TopBar,
    "INVIS HUB",
    18,
    Colors.Text
)

Title.Position = UDim2.fromOffset(20, 0)
Title.Size = UDim2.fromOffset(130, 58)
Title.Font = Enum.Font.GothamBold

local Subtitle = CreateText(
    TopBar,
    "V2.00.09",
    11,
    Colors.SubText
)

Subtitle.Position = UDim2.fromOffset(20, 31)
Subtitle.Size = UDim2.fromOffset(130, 18)

--==============================================================
-- HORIZONTAL TAB BAR
--==============================================================

TabScroll = Instance.new("ScrollingFrame")
TabScroll.Name = "Tabs"
TabScroll.Position = UDim2.fromOffset(155, 9)
TabScroll.Size = UDim2.new(1, -165, 0, 40)
TabScroll.BackgroundTransparency = 1
TabScroll.BorderSizePixel = 0
TabScroll.ScrollBarThickness = 0
TabScroll.ScrollingDirection = Enum.ScrollingDirection.X
TabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
TabScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
TabScroll.Parent = TopBar

TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 7)
TabLayout.Parent = TabScroll

--==============================================================
-- CONTENT
--==============================================================

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Position = UDim2.fromOffset(0, 58)
Content.Size = UDim2.new(1, 0, 1, -58)
Content.BackgroundTransparency = 1
Content.Parent = Main

--==============================================================
-- DRAG SYSTEM
--==============================================================

do
    local dragging = false
    local dragStart
    local startPosition

    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            dragStart = input.Position
            startPosition = Main.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging then
            local delta = input.Position - dragStart

            Main.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )
        end
    end)
end

--==============================================================
-- TAB SYSTEM
--==============================================================

function Library:CreateTab(name)
    local Tab = {}

    -- Tab button
    local Button = Instance.new("TextButton")
    Button.Name = name .. "_Tab"
    Button.Size = UDim2.fromOffset(100, 38)
    Button.BackgroundColor3 = Colors.Card
    Button.Text = name
    Button.TextColor3 = Colors.SubText
    Button.TextSize = 12
    Button.Font = Enum.Font.GothamSemibold
    Button.AutoButtonColor = false
    Button.Parent = TabScroll

    Corner(Button, 8)

    -- Page
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name .. "_Page"
    Page.Size = UDim2.new(1, -24, 1, -24)
    Page.Position = UDim2.fromOffset(12, 12)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Colors.Accent
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.Visible = false
    Page.Parent = Content

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 8)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = Page

    local PagePadding = Instance.new("UIPadding")
    PagePadding.PaddingBottom = UDim.new(0, 12)
    PagePadding.Parent = Page

    -- Select tab
    Button.MouseButton1Click:Connect(function()

        for _, data in pairs(Library.Tabs) do
            data.Page.Visible = false

            Tween(
                data.Button,
                0.18,
                {
                    BackgroundColor3 = Colors.Card,
                    TextColor3 = Colors.SubText
                }
            )
        end

        Page.Visible = true

        Tween(
            Button,
            0.18,
            {
                BackgroundColor3 = Colors.Accent,
                TextColor3 = Colors.White
            }
        )

        Library.CurrentTab = Tab
    end)

    table.insert(Library.Tabs, {
        Button = Button,
        Page = Page
    })

    --==========================================================
    -- TOGGLE
    --==========================================================

    function Tab:CreateToggle(text, default, callback)

        local value = default or false

        local Holder = Instance.new("Frame")
        Holder.Size = UDim2.new(1, 0, 0, 52)
        Holder.BackgroundColor3 = Colors.Card
        Holder.Parent = Page

        Corner(Holder, 8)

        local Label = CreateText(
            Holder,
            text,
            13,
            Colors.Text
        )

        Label.Position = UDim2.fromOffset(15, 0)
        Label.Size = UDim2.new(1, -80, 1, 0)

        local Toggle = Instance.new("TextButton")
        Toggle.Size = UDim2.fromOffset(46, 24)
        Toggle.Position = UDim2.new(1, -60, 0.5, -12)
        Toggle.BackgroundColor3 = Colors.Red
        Toggle.Text = ""
        Toggle.AutoButtonColor = false
        Toggle.Parent = Holder

        Corner(Toggle, 20)

        local Circle = Instance.new("Frame")
        Circle.Size = UDim2.fromOffset(18, 18)
        Circle.Position = UDim2.fromOffset(3, 3)
        Circle.BackgroundColor3 = Colors.White
        Circle.Parent = Toggle

        Corner(Circle, 20)

        local function Update()

            if value then
                Tween(Toggle, 0.18, {
                    BackgroundColor3 = Colors.Green
                })

                Tween(Circle, 0.18, {
                    Position = UDim2.new(1, -21, 0, 3)
                })
            else
                Tween(Toggle, 0.18, {
                    BackgroundColor3 = Colors.Red
                })

                Tween(Circle, 0.18, {
                    Position = UDim2.fromOffset(3, 3)
                })
            end

            if callback then
                callback(value)
            end
        end

        Toggle.MouseButton1Click:Connect(function()
            value = not value
            Update()
        end)

        Update()

        return {
            Set = function(_, newValue)
                value = newValue
                Update()
            end,

            Get = function()
                return value
            end
        }
    end

    --==========================================================
    -- BUTTON
    --==========================================================

function Tab:CreateButton(text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 45)
    Button.BackgroundColor3 = Colors.Card
    Button.Text = text
    Button.TextColor3 = Colors.Text
    Button.TextSize = 13
    Button.Font = Enum.Font.GothamSemibold
    Button.AutoButtonColor = false
    Button.ClipsDescendants = true
    Button.Parent = Page

    Corner(Button, 8)
    Stroke(Button)

    local BgIcon = Instance.new("ImageLabel")
    BgIcon.Name = "FingerprintBg"
    BgIcon.Size = UDim2.fromOffset(38, 38)
    BgIcon.Position = UDim2.new(1, -48, 0.5, -19)
    BgIcon.BackgroundTransparency = 1
    BgIcon.Image = "rbxassetid://3944703587"
    BgIcon.ImageColor3 = Colors.SubText
    BgIcon.ImageTransparency = 0.88
    BgIcon.ZIndex = 1
    BgIcon.Parent = Button

    Button.MouseEnter:Connect(function()
        Tween(Button, 0.15, {BackgroundColor3 = Colors.CardHover})
        Tween(BgIcon, 0.15, {ImageTransparency = 0.75})
    end)

    Button.MouseLeave:Connect(function()
        Tween(Button, 0.15, {BackgroundColor3 = Colors.Card})
        Tween(BgIcon, 0.15, {ImageTransparency = 0.88})
    end)

    Button.MouseButton1Click:Connect(function()
        Tween(Button, 0.08, {Size = UDim2.new(1, -4, 0, 43)})
        task.delay(0.08, function()
            Tween(Button, 0.12, {Size = UDim2.new(1, 0, 0, 45)})
        end)

        if callback then
            callback()
        end
    end)

    return Button
end

    --==========================================================
    -- SELECT
    --==========================================================

function Tab:CreateSelect(text, options, callback)
    local Holder = Instance.new("Frame")
    Holder.Size = UDim2.new(1, 0, 0, 52)
    Holder.BackgroundColor3 = Colors.Card
    Holder.ClipsDescendants = false
    Holder.ZIndex = 5
    Holder.Parent = Page

    local Label = CreateText(Holder, text, 13, Colors.Text)
    Label.Position = UDim2.fromOffset(15, 0)
    Label.Size = UDim2.new(0.4, 0, 1, 0)

    local SelectButton = Instance.new("TextButton")
    SelectButton.Size = UDim2.fromOffset(170, 34)
    SelectButton.Position = UDim2.new(1, -185, 0.5, -17)
    SelectButton.BackgroundColor3 = Colors.Sidebar
    SelectButton.Text = tostring(options[1] or "Select")
    SelectButton.TextColor3 = Colors.Text
    SelectButton.TextSize = 12
    SelectButton.Font = Enum.Font.GothamMedium
    SelectButton.AutoButtonColor = false
    SelectButton.ZIndex = 6
    SelectButton.Parent = Holder

    Corner(SelectButton, 7)

    local Arrow = CreateText(SelectButton, "▼", 10, Colors.SubText)
    Arrow.Size = UDim2.fromOffset(25, 34)
    Arrow.Position = UDim2.new(1, -28, 0, 0)
    Arrow.TextXAlignment = Enum.TextXAlignment.Center
    Arrow.ZIndex = 7

    local Dropdown = Instance.new("ScrollingFrame")
    Dropdown.Size = UDim2.fromOffset(170, 0)
    Dropdown.BackgroundColor3 = Colors.Sidebar
    Dropdown.BorderSizePixel = 0
    Dropdown.ScrollBarThickness = 3
    Dropdown.ScrollBarImageColor3 = Colors.Accent
    Dropdown.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Dropdown.CanvasSize = UDim2.new(0, 0, 0, 0)
    Dropdown.Visible = false
    Dropdown.ZIndex = 99999
    Dropdown.Parent = ScreenGui

    Corner(Dropdown, 7)
    Stroke(Dropdown)

    local DropLayout = Instance.new("UIListLayout")
    DropLayout.Padding = UDim.new(0, 3)
    DropLayout.SortOrder = Enum.SortOrder.LayoutOrder
    DropLayout.Parent = Dropdown

    Padding(Dropdown, 5)

    local selected = options[1]

    for index, option in ipairs(options) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Size = UDim2.new(1, 0, 0, 34)
        OptionButton.BackgroundColor3 = Colors.Card
        OptionButton.Text = tostring(option)
        OptionButton.TextColor3 = Colors.Text
        OptionButton.TextSize = 12
        OptionButton.Font = Enum.Font.GothamMedium
        OptionButton.AutoButtonColor = false
        OptionButton.LayoutOrder = index
        OptionButton.ZIndex = 100000
        OptionButton.Parent = Dropdown

        Corner(OptionButton, 6)

        OptionButton.MouseEnter:Connect(function()
            Tween(OptionButton, 0.12, {BackgroundColor3 = Colors.CardHover})
        end)

        OptionButton.MouseLeave:Connect(function()
            Tween(OptionButton, 0.12, {BackgroundColor3 = Colors.Card})
        end)

        OptionButton.MouseButton1Click:Connect(function()
            selected = option
            SelectButton.Text = tostring(option)
            Dropdown.Visible = false
            Tween(Dropdown, 0.15, {Size = UDim2.fromOffset(170, 0)})
            Arrow.Text = "▼"
            if callback then
                callback(option)
            end
        end)
    end

    SelectButton.MouseButton1Click:Connect(function()
        if Dropdown.Visible then
            Arrow.Text = "▼"
            Tween(Dropdown, 0.15, {Size = UDim2.fromOffset(170, 0)})
            task.delay(0.15, function()
                Dropdown.Visible = false
            end)
        else
            local calculatedHeight = math.min((#options * 37) + 10, 180)
            local buttonAbsolutePos = SelectButton.AbsolutePosition
            local buttonAbsoluteSize = SelectButton.AbsoluteSize
            local viewportSize = workspace.CurrentCamera.ViewportSize
            
            local spaceBelow = viewportSize.Y - (buttonAbsolutePos.Y + buttonAbsoluteSize.Y)
            
            if spaceBelow < calculatedHeight and buttonAbsolutePos.Y > calculatedHeight then
                Dropdown.Position = UDim2.fromOffset(buttonAbsolutePos.X, buttonAbsolutePos.Y - calculatedHeight - 5)
            else
                Dropdown.Position = UDim2.fromOffset(buttonAbsolutePos.X, buttonAbsolutePos.Y + buttonAbsoluteSize.Y + 5)
            end

            Dropdown.Visible = true
            Arrow.Text = "▲"
            Tween(Dropdown, 0.18, {Size = UDim2.fromOffset(170, calculatedHeight)})
        end
    end)

    return {
        Set = function(_, value)
            selected = value
            SelectButton.Text = tostring(value)
        end,
        Get = function()
            return selected
        end
    }
end

    --==========================================================
    -- SLIDER
    --==========================================================

    function Tab:CreateSlider(text, min, max, default, callback)

        min = min or 0
        max = max or 100
        default = default or min

        local value = default

        local Holder = Instance.new("Frame")
        Holder.Size = UDim2.new(1, 0, 0, 70)
        Holder.BackgroundColor3 = Colors.Card
        Holder.Parent = Page

        Corner(Holder, 8)

        local Label = CreateText(
            Holder,
            text,
            13,
            Colors.Text
        )

        Label.Position = UDim2.fromOffset(15, 8)
        Label.Size = UDim2.new(1, -100, 0, 22)

        local ValueLabel = CreateText(
            Holder,
            tostring(value),
            12,
            Colors.SubText
        )

        ValueLabel.Position = UDim2.new(1, -65, 0, 8)
        ValueLabel.Size = UDim2.fromOffset(50, 22)
        ValueLabel.TextXAlignment = Enum.TextXAlignment.Right

        local Bar = Instance.new("Frame")
        Bar.Size = UDim2.new(1, -30, 0, 6)
        Bar.Position = UDim2.fromOffset(15, 46)
        Bar.BackgroundColor3 = Colors.Sidebar
        Bar.Parent = Holder

        Corner(Bar, 5)

        local Fill = Instance.new("Frame")
        Fill.BackgroundColor3 = Colors.AccentBright
        Fill.Size = UDim2.new(
            (value - min) / (max - min),
            0,
            1,
            0
        )
        Fill.Parent = Bar

        Corner(Fill, 5)

        local Knob = Instance.new("Frame")
        Knob.Size = UDim2.fromOffset(14, 14)
        Knob.AnchorPoint = Vector2.new(0.5, 0.5)
        Knob.Position = UDim2.new(
            (value - min) / (max - min),
            0,
            0.5,
            0
        )
        Knob.BackgroundColor3 = Colors.White
        Knob.Parent = Bar

        Corner(Knob, 20)

        local dragging = false

        local function Update(inputX)

            local percentage = math.clamp(
                (inputX - Bar.AbsolutePosition.X)
                / Bar.AbsoluteSize.X,
                0,
                1
            )

            value = math.floor(
                min + (max - min) * percentage
            )

            Fill.Size = UDim2.new(
                percentage,
                0,
                1,
                0
            )

            Knob.Position = UDim2.new(
                percentage,
                0,
                0.5,
                0
            )

            ValueLabel.Text = tostring(value)

            if callback then
                callback(value)
            end
        end

        Bar.InputBegan:Connect(function(input)

            if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

                dragging = true
                Update(input.Position.X)
            end
        end)

        UserInputService.InputChanged:Connect(function(input)

            if dragging and (
                input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch
            ) then

                Update(input.Position.X)
            end
        end)

        UserInputService.InputEnded:Connect(function(input)

            if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

                dragging = false
            end
        end)

        return {
            Set = function(_, newValue)

                value = math.clamp(newValue, min, max)

                local percentage =
                    (value - min) / (max - min)

                Fill.Size = UDim2.new(
                    percentage,
                    0,
                    1,
                    0
                )

                Knob.Position = UDim2.new(
                    percentage,
                    0,
                    0.5,
                    0
                )

                ValueLabel.Text = tostring(value)

                if callback then
                    callback(value)
                end
            end,

            Get = function()
                return value
            end
        }
    end

    --==========================================================
    -- TEXTBOX
    --==========================================================

function Tab:CreateTextbox(text, placeholder, callback)
    local Holder = Instance.new("Frame")
    Holder.Size = UDim2.new(1, 0, 0, 0)
    Holder.AutomaticSize = Enum.AutomaticSize.Y
    Holder.BackgroundColor3 = Colors.Card
    Holder.Parent = Page

    Corner(Holder, 8)
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Padding = UDim.new(0, 6)
    ListLayout.Parent = Holder
    
    Padding(Holder, 12)

    local Label = CreateText(Holder, text, 12, Colors.SubText)
    Label.Size = UDim2.new(1, 0, 0, 16)
    Label.LayoutOrder = 1

    local Box = Instance.new("TextBox")
    Box.Size = UDim2.new(1, 0, 0, 36)
    Box.AutomaticSize = Enum.AutomaticSize.Y
    Box.BackgroundColor3 = Colors.Sidebar
    Box.TextColor3 = Colors.Text
    Box.PlaceholderColor3 = Colors.SubText
    Box.PlaceholderText = placeholder or ""
    Box.Text = ""
    Box.TextSize = 12
    Box.Font = Enum.Font.Gotham
    Box.TextWrapped = true
    Box.ClearTextOnFocus = false
    Box.LayoutOrder = 2
    Box.Parent = Holder

    Corner(Box, 7)
    Padding(Box, 8)

    Box.FocusLost:Connect(function(enterPressed)
        if callback then
            callback(Box.Text, enterPressed)
        end
    end)
    
    Tab.CreateTextBox = Tab.CreateTextbox

    return Box
end
    
    --==========================================================
    -- LABEL
    --==========================================================
    
    function Tab:CreateLabel(text)
        labelContainer = Instance.new("Frame", Page)
        labelContainer.Size = UDim2.new(1, 0, 0, 24)
        labelContainer.BackgroundTransparency = 1
        labelContainer.BorderSizePixel = 0

        lbl = CreateText(labelContainer, text, 13, Colors.Text)
        lbl.Size = UDim2.new(1, -16, 1, 0)
        lbl.Position = UDim2.fromOffset(8, 0)
        lbl.Font = Enum.Font.GothamBold

        return lbl
    end
   

    return Tab
end

--==============================================================
-- NOTICE SYSTEM
--==============================================================

function Library:CreateNotice(config)
    config = config or {}

    local TitleText = config.Title or "Notice"
    local Message = config.Text or ""
    local Type = config.Type or "OK"
    local Seconds = config.Seconds or 3
    local Callback = config.Callback

    local Overlay = Instance.new("Frame")
    Overlay.Size = UDim2.fromScale(1, 1)
    Overlay.BackgroundColor3 = Color3.new(0, 0, 0)
    Overlay.BackgroundTransparency = 0.4
    Overlay.ZIndex = 100
    Overlay.Parent = ScreenGui

    local Notice = Instance.new("Frame")
    Notice.Size = UDim2.fromOffset(360, 0)
    Notice.AutomaticSize = Enum.AutomaticSize.Y
    Notice.Position = UDim2.fromScale(0.5, 0.5)
    Notice.AnchorPoint = Vector2.new(0.5, 0.5)
    Notice.BackgroundColor3 = Colors.Background
    Notice.ZIndex = 101
    Notice.Parent = Overlay

    Corner(Notice, 12)
    Stroke(Notice)

    local TitleLabel = CreateText(
        Notice,
        TitleText,
        17,
        Colors.Text
    )
    TitleLabel.Position = UDim2.fromOffset(20, 15)
    TitleLabel.Size = UDim2.new(1, -60, 0, 28)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.ZIndex = 102

    local MessageLabel = CreateText(Notice, Message, 12, Colors.SubText)
    MessageLabel.Position = UDim2.fromOffset(20, 52)
    MessageLabel.Size = UDim2.new(1, -40, 0, 0)
    MessageLabel.AutomaticSize = Enum.AutomaticSize.Y
    MessageLabel.TextWrapped = true
    MessageLabel.ZIndex = 102

    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Name = "ButtonContainer"
    ButtonContainer.Size = UDim2.new(1, -40, 0, 50)
    ButtonContainer.Position = UDim2.fromOffset(20, 0)
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.ZIndex = 102
    ButtonContainer.Parent = Notice

    local ListLayout = Instance.new("UIListLayout")
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Padding = UDim.new(0, 15)
    ListLayout.Parent = Notice

    local UIPaddingInstance = Instance.new("UIPadding")
    UIPaddingInstance.PaddingTop = UDim.new(0, 0)
    UIPaddingInstance.PaddingBottom = UDim.new(0, 20)
    UIPaddingInstance.PaddingLeft = UDim.new(0, 0)
    UIPaddingInstance.PaddingRight = UDim.new(0, 0)
    UIPaddingInstance.Parent = Notice

    TitleLabel.LayoutOrder = 1
    MessageLabel.LayoutOrder = 2
    ButtonContainer.LayoutOrder = 3

    local function Close(result)
        Tween(Notice, 0.15, {BackgroundTransparency = 1})
        Tween(Overlay, 0.15, {BackgroundTransparency = 1})
        task.delay(0.16, function()
            if Callback then Callback(result) end
            Overlay:Destroy()
        end)
    end

    if Type == "YesNo" then
        local Yes = Instance.new("TextButton")
        Yes.Size = UDim2.new(0.5, -10, 1, 0)
        Yes.Position = UDim2.fromScale(0, 0)
        Yes.BackgroundColor3 = Colors.Green
        Yes.Text = "YES"
        Yes.TextColor3 = Colors.White
        Yes.TextSize = 12
        Yes.Font = Enum.Font.GothamBold
        Yes.AutoButtonColor = false
        Yes.ZIndex = 103
        Yes.Parent = ButtonContainer
        Corner(Yes, 7)

        local No = Yes:Clone()
        No.BackgroundColor3 = Colors.Red
        No.Text = "NO"
        No.Position = UDim2.new(0.5, 10, 0, 0)
        No.Parent = ButtonContainer

        Yes.MouseButton1Click:Connect(function() Close(true) end)
        No.MouseButton1Click:Connect(function() Close(false) end)

    elseif Type == "OK" then
        local OK = Instance.new("TextButton")
        OK.Size = UDim2.fromOffset(145, 40)
        OK.Position = UDim2.new(0.5, -72, 0, 5)
        OK.BackgroundColor3 = Colors.Accent
        OK.Text = "OK"
        OK.TextColor3 = Colors.White
        OK.TextSize = 12
        OK.Font = Enum.Font.GothamBold
        OK.AutoButtonColor = false
        OK.ZIndex = 103
        OK.Parent = ButtonContainer
        Corner(OK, 7)

        OK.MouseButton1Click:Connect(function() Close(true) end)

    elseif Type == "Wait" or Type == "WaitX" then
        ButtonContainer.Size = UDim2.new(1, -40, 0, 30)
        local TimeLabel = CreateText(ButtonContainer, tostring(Seconds) .. "s", 12, Colors.SubText)
        TimeLabel.Size = UDim2.new(1, 0, 1, 0)
        TimeLabel.Position = UDim2.fromOffset(0, 0)
        TimeLabel.TextXAlignment = Enum.TextXAlignment.Center
        TimeLabel.ZIndex = 103

        if Type == "WaitX" then
            local X = Instance.new("TextButton")
            X.Size = UDim2.fromOffset(28, 28)
            X.Position = UDim2.new(1, -38, 0, -40)
            X.BackgroundTransparency = 1
            X.Text = "×"
            X.TextColor3 = Colors.SubText
            X.TextSize = 22
            X.Font = Enum.Font.GothamBold
            X.ZIndex = 104
            X.Parent = Notice

            X.MouseButton1Click:Connect(function() Close(false) end)
        end

        task.spawn(function()
            for i = Seconds, 1, -1 do
                if not Notice.Parent then return end
                TimeLabel.Text = "Closing in " .. i .. "s"
                task.wait(1)
            end
            if Notice.Parent then Close(true) end
        end)

    elseif Type == "Textbox" then
        ButtonContainer.Size = UDim2.new(1, -40, 0, 95)
        local Box = Instance.new("TextBox")
        Box.Size = UDim2.new(1, 0, 0, 40)
        Box.Position = UDim2.fromOffset(0, 5)
        Box.BackgroundColor3 = Colors.Sidebar
        Box.TextColor3 = Colors.Text
        Box.PlaceholderColor3 = Colors.SubText
        Box.PlaceholderText = config.Placeholder or "Enter text..."
        Box.Text = ""
        Box.TextSize = 12
        Box.Font = Enum.Font.Gotham
        Box.ClearTextOnFocus = false
        Box.ZIndex = 103
        Box.Parent = ButtonContainer
        Corner(Box, 7)
        Padding(Box, 8)

        local OK = Instance.new("TextButton")
        OK.Size = UDim2.fromOffset(145, 38)
        OK.Position = UDim2.new(0.5, -72, 0, 55)
        OK.BackgroundColor3 = Colors.Accent
        OK.Text = "OK"
        OK.TextColor3 = Colors.White
        OK.TextSize = 12
        OK.Font = Enum.Font.GothamBold
        OK.AutoButtonColor = false
        OK.ZIndex = 103
        OK.Parent = ButtonContainer
        Corner(OK, 7)

        OK.MouseButton1Click:Connect(function() Close(Box.Text) end)
    end

    return {
        Close = function()
            if Overlay.Parent then Close(false) end
        end
    }
end

if shared._InvisClashDetectorThread then 
    task.cancel(shared._InvisClashDetectorThread) 
    shared._InvisClashDetectorThread = nil 
end

if not _G.TargetHistoryList then _G.TargetHistoryList = {} end
if not _G.LastTargetChecked then _G.LastTargetChecked = "" end
if not _G.RallyCounterMap then _G.RallyCounterMap = {} end

shared._InvisClashDetectorThread = task.spawn(function()
    xpcall(function()
        while shared._InvisRunning do
            game:GetService("RunService").PreSimulation:Wait()
            
            cfg = (type(Config) == "table") and Config or {}
            autoSpamEnabled = cfg.AutoSpam or cfg.AutoSpamClash or false
            
            if autoSpamEnabled then
                character = game.Players.LocalPlayer.Character
                myHrp = character and (character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart)
                myHum = character and character:FindFirstChildOfClass("Humanoid")
                
                if myHrp and myHum and myHum.Health > 0 then
                    
                    activeBall = nil
                    ballsFolder = workspace:FindFirstChild("Balls") or workspace:FindFirstChild("TrainingBalls")
                    if ballsFolder then
                        for _, b in pairs(ballsFolder:GetChildren()) do
                            if b:IsA("BasePart") and (b:GetAttribute("realBall") or b:GetAttribute("target")) then 
                                activeBall = b
                                break
                            end
                        end
                    end
                    
                    if activeBall and activeBall.Parent then
                        zoomies = activeBall:FindFirstChild("zoomies")
                        velocity = zoomies and zoomies.VectorVelocity or activeBall.AssemblyLinearVelocity
                        ballSpeed = velocity.Magnitude
                        
                        if ballSpeed > 0 then
                            
                            targetPlayer = nil
                            shortestWorldDist = math.huge
                            aliveFolder = workspace:FindFirstChild("Alive")
                            if aliveFolder then
                                for _, target in ipairs(aliveFolder:GetChildren()) do
                                    if target:IsA("Model") and target ~= character then
                                        hrpTarget = target:FindFirstChild("HumanoidRootPart")
                                        if hrpTarget then
                                            worldDist = (myHrp.Position - hrpTarget.Position).Magnitude
                                            if worldDist < shortestWorldDist then
                                                shortestWorldDist = worldDist
                                                targetPlayer = target
                                            end
                                        end
                                    end
                                end
                            end
                            
                            if targetPlayer and targetPlayer:FindFirstChild("HumanoidRootPart") then
                                dynamicMaxDistance = math.clamp(10 + (ballSpeed * 0.3), 15, 60)
                                distanceToEnemy = (myHrp.Position - targetPlayer.HumanoidRootPart.Position).Magnitude
                                
                                if distanceToEnemy <= dynamicMaxDistance then
                                    currentBallTarget = tostring(activeBall:GetAttribute("target") or activeBall:GetAttribute("Target") or "")
                                    myName = game.Players.LocalPlayer.Name
                                    enemyName = targetPlayer.Name
                                    
                                    if currentBallTarget ~= "" then
                                        if currentBallTarget ~= _G.LastTargetChecked then
                                            table.insert(_G.TargetHistoryList, 1, currentBallTarget)
                                            if #_G.TargetHistoryList > 2 then
                                                table.remove(_G.TargetHistoryList, 3)
                                            end
                                            
                                            if #_G.TargetHistoryList == 2 then
                                                isPatternMatch = false
                                                if (_G.TargetHistoryList[1] == myName and _G.TargetHistoryList[2] == enemyName) or 
                                                   (_G.TargetHistoryList[1] == enemyName and _G.TargetHistoryList[2] == myName) then
                                                    isPatternMatch = true
                                                end
                                                
                                                if isPatternMatch then
                                                    _G.RallyCounterMap[activeBall] = (_G.RallyCounterMap[activeBall] or 0) + 1
                                                else
                                                    _G.RallyCounterMap[activeBall] = 0
                                                    _G.TargetHistoryList = {}
                                                end
                                            end
                                            _G.LastTargetChecked = currentBallTarget
                                        end
                                    end
                                    
                                    currentRallies = _G.RallyCounterMap[activeBall] or 0
                                    if currentRallies >= 2 or (currentBallTarget == myName and _G.LastTargetChecked == enemyName and #_G.TargetHistoryList >= 1) then
                                        if currentBallTarget == myName or currentBallTarget == enemyName then
                                            shared.ManualSpamActive = true
                                            
                                            if type(Auto_Parry) == "table" and type(Auto_Parry.FireParryRemote) == "function" then
                                                pcall(Auto_Parry.FireParryRemote, true)
                                            else
                                                mouse1press()
                                                task.wait(0.001)
                                                mouse1release()
                                            end
                                        else
                                            shared.ManualSpamActive = false
                                            _G.RallyCounterMap[activeBall] = 0
                                            _G.TargetHistoryList = {}
                                        end
                                    else
                                        shared.ManualSpamActive = false
                                    end
                                else
                                    shared.ManualSpamActive = false
                                    _G.RallyCounterMap[activeBall] = 0
                                    _G.TargetHistoryList = {}
                                    _G.LastTargetChecked = ""
                                end
                            else
                                shared.ManualSpamActive = false
                                _G.RallyCounterMap[activeBall] = 0
                                _G.TargetHistoryList = {}
                                _G.LastTargetChecked = ""
                            end
                        end
                    else
                        shared.ManualSpamActive = false
                        _G.TargetHistoryList = {}
                        _G.LastTargetChecked = ""
                    end
                else
                    shared.ManualSpamActive = false
                    _G.TargetHistoryList = {}
                    _G.LastTargetChecked = ""
                end
            else
                shared.ManualSpamActive = false
                _G.TargetHistoryList = {}
                _G.LastTargetChecked = ""
                task.wait(0.2)
            end
        end
    end, function(errorMessage)
        print("Independent clash detector loop execution error: " .. tostring(errorMessage))
    end)
end)

if shared._InvisAutoPlayThread then
    task.cancel(shared._InvisAutoPlayThread)
    shared._InvisAutoPlayThread = nil
end
shared._InvisAutoPlayThread = task.spawn(function()
    xpcall(function()
        while shared._InvisRunning do
            game:GetService("RunService").Heartbeat:Wait()
            cfg = (type(Config) == "table") and Config or {}
            autoPlayEnabled = cfg.AutoPlay or false
            currentPlayMode = cfg.AutoPlayMode or "Defensive (Backstep)"
            if autoPlayEnabled then
                character = game.Players.LocalPlayer.Character
                hum = character and character:FindFirstChildOfClass("Humanoid")
                hrp = character and character:FindFirstChild("HumanoidRootPart")
                aliveFolder = workspace:FindFirstChild("Alive")
                
                isLobby = true
                if aliveFolder and character and character:IsDescendantOf(aliveFolder) then
                    isLobby = false
                end
                
                if hum and hum.Health > 0 and hrp and not isLobby then
                    ball = type(Auto_Parry.Get_Ball) == "function" and Auto_Parry.Get_Ball()
                    targetPlr = type(Auto_Parry.GetTargetPlayer) == "function" and Auto_Parry.GetTargetPlayer()
                    currentTargetAttr = ball and (ball:GetAttribute("target") or ball:GetAttribute("Target"))
                    ballTargetStr = currentTargetAttr and tostring(currentTargetAttr) or ""
                    isTargetingMe = (ballTargetStr == game:GetService("Players").LocalPlayer.Name or ballTargetStr == character.Name)
                    destination = hrp.Position
                    
                    if ball and ball.Parent then
                        velocity = Vector3.zero
                        zoomies = ball:FindFirstChild("zoomies")
                        if zoomies then
                            s, v = pcall(function() return zoomies.VectorVelocity end)
                            if s and v then velocity = v end
                        end
                        if velocity == Vector3.zero and ball:IsA("BasePart") then
                            velocity = ball.AssemblyLinearVelocity
                        end
                        ballSpeed = velocity.Magnitude
                        ballDist = (hrp.Position - ball.Position).Magnitude
                        
                        if isTargetingMe then
                            ballDirection = ballSpeed > 1 and velocity.Unit or Vector3.new(0, 0, 1)
                            if currentPlayMode == "Defensive (Backstep)" then
                                lateralSafeDirection = Vector3.new(-ballDirection.Z, 0, ballDirection.X).Unit
                                destination = ball.Position + (lateralSafeDirection * math.clamp(ballDist * 0.6, 20, 45))
                            elseif currentPlayMode == "Offensive (Rush)" then
                                if targetPlr and targetPlr.PrimaryPart then
                                    destination = targetPlr.PrimaryPart.Position
                                else
                                    destination = ball.Position - (ballDirection * 5)
                                end
                            elseif currentPlayMode == "Dynamic Support" then
                                lateralDirection = Vector3.new(ballDirection.Z, 0, -ballDirection.X).Unit
                                destination = ball.Position + (lateralDirection * 15)
                            end
                        else
                            if targetPlr and targetPlr.PrimaryPart then
                                if currentPlayMode == "Offensive (Rush)" then
                                    destination = targetPlr.PrimaryPart.Position
                                else
                                    destination = targetPlr.PrimaryPart.Position + ((hrp.Position - targetPlr.PrimaryPart.Position).Unit * 15)
                                end
                            else
                                currentTarget = ball:GetAttribute("target") or ball:GetAttribute("Target")
                                targetChar = currentTarget and aliveFolder:FindFirstChild(tostring(currentTarget))
                                if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
                                    destination = targetChar.HumanoidRootPart.Position
                                end
                            end
                        end
                    elseif targetPlr and targetPlr.PrimaryPart then
                        destination = targetPlr.PrimaryPart.Position
                    end
                    
                    if (hrp.Position - destination).Magnitude > 1.5 then
                        hum:MoveTo(destination)
                    end
                    
                    if isTargetingMe and ball then
                        if ballDist <= math.clamp(ballSpeed * 0.4, 25, 65) then
                            if hum.FloorMaterial ~= Enum.Material.Air and not _G.AutoPlayDoubleJumpToken then
                                hum:ChangeState(Enum.HumanoidStateType.Jumping)
                                _G.AutoPlayDoubleJumpToken = true
                                task.wait(0.1)
                            end
                            if _G.AutoPlayDoubleJumpToken and hum:GetState() == Enum.HumanoidStateType.FreeFall then
                                hum:ChangeState(Enum.HumanoidStateType.Jumping)
                                _G.AutoPlayDoubleJumpToken = false
                                task.wait(0.1)
                            end
                        end
                    else
                        if hum.FloorMaterial ~= Enum.Material.Air then
                            _G.AutoPlayDoubleJumpToken = false
                        end
                    end
                end
            end
        end
    end, function(errorMessage)
        print("Multi-mode auto play loop failed: " .. tostring(errorMessage))
    end)
end)

ManualSpamEnabled = false
ManualSpamActive = false
ManualSpamMobile_Gate = false
ManualSpamFired = 0
ManualSpamLive_CPS = 0
ManualSpamToken = 0
ManualSpamMobile_Overlay_On = false
ManualSpamCps_Counter_On = false

function Manual_Spam_Start()
    ManualSpamToken = ManualSpamToken + 1
    Current_Token = ManualSpamToken
    
    task.spawn(function()
        xpcall(function()
            Accumulator = 0
            conn = game:GetService("RunService").Heartbeat:Connect(function(dt)
                if ManualSpamToken ~= Current_Token then
                    conn:Disconnect()
                    return
                end
                
                Running = (ManualSpamMobile_Gate and ManualSpamActive) or (not ManualSpamMobile_Gate and ManualSpamEnabled)
                if not Running then
                    conn:Disconnect()
                    return
                end
                
                cfg = (type(Config) == "table") and Config or {}
                selectedIntensity = cfg.ManualSpamMode or "Normal"
                
                targetCPS = 100
                burstMultiplier = 1
                
                if selectedIntensity == "God" then
                    targetCPS = 1000
                    burstMultiplier = 5
                elseif selectedIntensity == "Super Fast" then
                    targetCPS = 600
                    burstMultiplier = 3
                elseif selectedIntensity == "Fast" then
                    targetCPS = 300
                    burstMultiplier = 2
                elseif selectedIntensity == "Normal" then
                    targetCPS = 100
                    burstMultiplier = 1
                elseif selectedIntensity == "Slow" then
                    targetCPS = 35
                    burstMultiplier = 1
                end
                
                Accumulator = Accumulator + targetCPS * dt
                Fires = math.floor(Accumulator)
                
                if Fires > 0 then
                    Accumulator = Accumulator - Fires
                    for i = 1, Fires do
                        for b = 1, burstMultiplier do
                            if type(Auto_Spam) == "table" and type(Auto_Spam.Fire) == "function" then
                                pcall(Auto_Spam.Fire)
                            elseif type(Auto_Parry) == "table" and type(Auto_Parry.FireParryRemote) == "function" then
                                pcall(Auto_Parry.FireParryRemote, true)
                            end
                            ManualSpamFired = ManualSpamFired + 1
                        end
                    end
                    if getgenv().ManualSpamAnimationFix then
                        if type(Auto_Parry) == "table" and type(Auto_Parry.Parry_Animation) == "function" then
                            pcall(Auto_Parry.Parry_Animation)
                        end
                    end
                end
            end)
        end, function(errorMessage)
            print("Manual spam engine runtime failure: " .. tostring(errorMessage))
        end)
    end)
end

function Manual_SpamClose()
    ManualSpamToken = ManualSpamToken + 1
end

local voidSpamThread = nil
VoidSpamEnabled = false
VoidSpamActive = false

function Void_Spam_Start()
    if voidSpamThread then
        VoidSpamEnabled = false
        voidSpamThread = nil
    end
    VoidSpamEnabled = true
    local threshold = 0.015
    voidSpamThread = coroutine.create(function()
        local last_spam = 0
        while VoidSpamEnabled do
            local now = os.clock()
            if now - last_spam >= threshold then
                last_spam = now
                if type(Auto_Parry) == "table" and type(Auto_Parry.FireParryRemote) == "function" then
                    pcall(Auto_Parry.FireParryRemote, true)
                elseif type(fireParryRemote) == "function" then
                    pcall(fireParryRemote, true)
                end
                if getgenv().ManualSpamAnimationFix then
                    if type(Auto_Parry) == "table" and type(Auto_Parry.Parry_Animation) == "function" then
                        pcall(Auto_Parry.Parry_Animation)
                    end
                end
            end
            coroutine.yield()
        end
    end)
    task.spawn(function()
        while VoidSpamEnabled and voidSpamThread and coroutine.status(voidSpamThread) ~= "dead" do
            coroutine.resume(voidSpamThread)
            task.wait()
        end
    end)
end

function Void_Spam_Close()
    VoidSpamEnabled = false
    voidSpamThread = nil
end

if shared._InvisParryUnlockTracker then
    task.cancel(shared._InvisParryUnlockTracker)
    shared._InvisParryUnlockTracker = nil
end

_G.BallTargetStartTicks = _G.BallTargetStartTicks or {}

shared._InvisParryUnlockTracker = task.spawn(function()
    xpcall(function()
        while shared._InvisRunning do
            game:GetService("RunService").Heartbeat:Wait()
            ballsFolder = workspace:FindFirstChild("Balls") or workspace:FindFirstChild("TrainingBalls")
            if ballsFolder then
                for _, b in pairs(ballsFolder:GetChildren()) do
                    if b:IsA("BasePart") and (b:GetAttribute("realBall") or b:GetAttribute("target")) then
                        targetAttr = b:GetAttribute("target") or b:GetAttribute("Target")
                        isTargetingMe = (tostring(targetAttr or "") == game:GetService("Players").LocalPlayer.Name)
                        isLocked = (type(parryLocked) == "table" and parryLocked[b] == true)
                        
                        if isTargetingMe and isLocked then
                            if not _G.BallTargetStartTicks[b] then
                                _G.BallTargetStartTicks[b] = os.clock()
                            else
                                if (os.clock() - _G.BallTargetStartTicks[b]) >= 0.72 then
                                    if type(parryLocked) == "table" then parryLocked[b] = false end
                                    if type(lockTime) == "table" then lockTime[b] = 0 end
                                    if type(shared.InvisClearLock) == "function" then
                                        pcall(shared.InvisClearLock, b)
                                    end
                                    _G.BallTargetStartTicks[b] = nil
                                end
                            end
                        else
                            _G.BallTargetStartTicks[b] = nil
                        end
                    end
                end
            end
        end
    end, function(errorMessage)
        print("Precise parry unlock timer engine failed: " .. tostring(errorMessage))
    end)
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

velocityHandlerName = "Invis_VelocityHandler"
gyroHandlerName = "Invis_GyroHandler"
mfly1 = nil
mfly2 = nil
flyKeyDown = nil
flyKeyUp = nil
FlyState = false
FlySpeed = 50

function NOFLY()
    if flyKeyDown or flyKeyUp then 
        flyKeyDown:Disconnect() 
        flyKeyUp:Disconnect() 
    end
    pcall(function()
        speaker = game:GetService("Players").LocalPlayer
        root = speaker.Character and speaker.Character:FindFirstChild("HumanoidRootPart")
        if root then
            if root:FindFirstChild(velocityHandlerName) then root[velocityHandlerName]:Destroy() end
            if root:FindFirstChild(gyroHandlerName) then root[gyroHandlerName]:Destroy() end
        end
        if mfly1 then mfly1:Disconnect() end
        if mfly2 then mfly2:Disconnect() end
    end)
    if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
    end
    pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end

function sFLY()
    char = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
    humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        repeat task.wait() until char:FindFirstChildOfClass("Humanoid")
        humanoid = char:FindFirstChildOfClass("Humanoid")
    end
    if flyKeyDown or flyKeyUp then
        flyKeyDown:Disconnect()
        flyKeyUp:Disconnect()
    end
    T = char:FindFirstChild("HumanoidRootPart")
    if not T then return end
    CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
    lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
    SPEED = 0
    BodyVelocityInstance = Instance.new("BodyVelocity")
    BodyGyroInstance = Instance.new("BodyGyro")
    BodyVelocityInstance.Name = velocityHandlerName
    BodyGyroInstance.Name = gyroHandlerName
    BodyGyroInstance.P = 9e4
    BodyGyroInstance.Parent = T
    BodyVelocityInstance.Parent = T
    BodyGyroInstance.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    BodyGyroInstance.CFrame = T.CFrame
    BodyVelocityInstance.Velocity = Vector3.new(0, 0, 0)
    BodyVelocityInstance.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    task.spawn(function()
        repeat task.wait()
            camera = workspace.CurrentCamera
            if humanoid then humanoid.PlatformStand = true end
            if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                SPEED = FlySpeed
            elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
                SPEED = 0
            end
            if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
                BodyVelocityInstance.Velocity = ((camera.CFrame.LookVector * (CONTROL.F + CONTROL.B)) + ((camera.CFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - camera.CFrame.p)) * SPEED
                lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
            elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
                BodyVelocityInstance.Velocity = ((camera.CFrame.LookVector * (lCONTROL.F + lCONTROL.B)) + ((camera.CFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - camera.CFrame.p)) * SPEED
            else
                BodyVelocityInstance.Velocity = Vector3.new(0, 0, 0)
            end
            BodyGyroInstance.CFrame = camera.CFrame
        until not FlyState
        if BodyGyroInstance then BodyGyroInstance:Destroy() end
        if BodyVelocityInstance then BodyVelocityInstance:Destroy() end
        if humanoid then humanoid.PlatformStand = false end
    end)
    flyKeyDown = game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.W then CONTROL.F = 1
        elseif input.KeyCode == Enum.KeyCode.S then CONTROL.B = -1
        elseif input.KeyCode == Enum.KeyCode.A then CONTROL.L = -1
        elseif input.KeyCode == Enum.KeyCode.D then CONTROL.R = 1
        elseif input.KeyCode == Enum.KeyCode.E then CONTROL.Q = 1
        elseif input.KeyCode == Enum.KeyCode.Q then CONTROL.E = -1
        end
    end)
    flyKeyUp = game:GetService("UserInputService").InputEnded:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.W then CONTROL.F = 0
        elseif input.KeyCode == Enum.KeyCode.S then CONTROL.B = 0
        elseif input.KeyCode == Enum.KeyCode.A then CONTROL.L = 0
        elseif input.KeyCode == Enum.KeyCode.D then CONTROL.R = 0
        elseif input.KeyCode == Enum.KeyCode.E then CONTROL.Q = 0
        elseif input.KeyCode == Enum.KeyCode.Q then CONTROL.E = 0
        end
    end)
end

function mobilefly()
    NOFLY()
    char = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
    root = char:WaitForChild("HumanoidRootPart", 10)
    humanoid = char:FindFirstChildOfClass("Humanoid")
    camera = workspace.CurrentCamera
    v3inf = Vector3.new(9e9, 9e9, 9e9)
    v3zero = Vector3.new(0, 0, 0)
    if not root or not humanoid then return end
    BodyVelocityInstance = Instance.new("BodyVelocity")
    BodyVelocityInstance.Name = velocityHandlerName
    BodyVelocityInstance.Parent = root
    BodyVelocityInstance.MaxForce = v3inf
    BodyVelocityInstance.Velocity = v3zero
    BodyGyroInstance = Instance.new("BodyGyro")
    BodyGyroInstance.Name = gyroHandlerName
    BodyGyroInstance.Parent = root
    BodyGyroInstance.MaxTorque = v3inf
    BodyGyroInstance.P = 9e4
    mfly1 = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(newChar)
        root = newChar:WaitForChild("HumanoidRootPart", 10)
        humanoid = newChar:WaitForChild("Humanoid", 10)
        if root then
            BodyVelocityInstance = Instance.new("BodyVelocity")
            BodyVelocityInstance.Name = velocityHandlerName
            BodyVelocityInstance.Parent = root
            BodyVelocityInstance.MaxForce = v3inf
            BodyVelocityInstance.Velocity = v3zero
            BodyGyroInstance = Instance.new("BodyGyro")
            BodyGyroInstance.Name = gyroHandlerName
            BodyGyroInstance.Parent = root
            BodyGyroInstance.MaxTorque = v3inf
            BodyGyroInstance.P = 9e4
        end
    end)
    mfly2 = game:GetService("RunService").RenderStepped:Connect(function()
        if game:GetService("Players").LocalPlayer.Character and root and humanoid and BodyVelocityInstance and BodyGyroInstance then
            humanoid.PlatformStand = true
            BodyGyroInstance.CFrame = camera.CFrame
            moveVector = v3zero
            controlModule = nil
            pcall(function()
                controlModule = require(game:GetService("Players").LocalPlayer.PlayerScripts:FindFirstChild("PlayerModule"):FindFirstChild("ControlModule"))
            end)
            if controlModule and controlModule.GetMoveVector then
                rawVector = controlModule:GetMoveVector()
                moveVector = Vector3.new(rawVector.X, 0, rawVector.Z)
            else
                moveVector = humanoid.MoveDirection
            end
            direction = camera.CFrame:VectorToWorldSpace(moveVector)
            BodyVelocityInstance.Velocity = direction * FlySpeed
        end
    end)
end

function StartFlying()
    FlyState = true
    if game:GetService("UserInputService").TouchEnabled and not game:GetService("UserInputService").KeyboardEnabled then
        mobilefly()
    else
        NOFLY()
        task.wait()
        sFLY()
    end
end

function StopFlying()
    FlyState = false
    NOFLY()
end

pcall(function()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid", 10)
    if hum then
        _G.OriginalWalkSpeed = hum.WalkSpeed
        _G.OriginalJumpPower = hum.UseJumpPower and hum.JumpPower or hum.JumpHeight
    end
end)
_G.OriginalWalkSpeed = _G.OriginalWalkSpeed or 16
_G.OriginalJumpPower = _G.OriginalJumpPower or 50

WalkSpeedValue = _G.OriginalWalkSpeed
JumpPowerValue = _G.OriginalJumpPower

SpeedState = false
JumpPowerState = false
SpeedLoopConnection = nil
JumpPowerLoopConnection = nil

function ApplySpeed(on)
    SpeedState = on
    if SpeedLoopConnection then 
        SpeedLoopConnection:Disconnect() 
        SpeedLoopConnection = nil 
    end
    if SpeedState then
        targetSpeed = tonumber(WalkSpeedValue) or 27
        SpeedLoopConnection = game:GetService("RunService").PostSimulation:Connect(function()
            pcall(function()
                char = game:GetService("Players").LocalPlayer.Character
                hum = char and char:FindFirstChildWhichIsA("Humanoid")
                if hum and hum.WalkSpeed ~= targetSpeed then
                    hum.WalkSpeed = targetSpeed
                end
            end)
        end)
    else
        pcall(function()
            char = game:GetService("Players").LocalPlayer.Character
            hum = char and char:FindFirstChildWhichIsA("Humanoid")
            if hum then
                hum.WalkSpeed = _G.OriginalWalkSpeed or 16
            end
        end)
    end
end

function ApplyJumpPower(on)
    JumpPowerState = on
    if JumpPowerLoopConnection then 
        JumpPowerLoopConnection:Disconnect() 
        JumpPowerLoopConnection = nil 
    end
    if JumpPowerState then
        targetJump = tonumber(JumpPowerValue) or 50
        JumpPowerLoopConnection = game:GetService("RunService").PostSimulation:Connect(function()
            pcall(function()
                char = game:GetService("Players").LocalPlayer.Character
                hum = char and char:FindFirstChildWhichIsA("Humanoid")
                if hum then
                    if hum.UseJumpPower then
                        if hum.JumpPower ~= targetJump then hum.JumpPower = targetJump end
                    else
                        if hum.JumpHeight ~= targetJump then hum.JumpHeight = targetJump end
                    end
                end
            end)
        end)
    else
        pcall(function()
            char = game:GetService("Players").LocalPlayer.Character
            hum = char and char:FindFirstChildWhichIsA("Humanoid")
            if hum then
                if hum.UseJumpPower then
                    hum.JumpPower = _G.OriginalJumpPower or 50
                else
                    hum.JumpHeight = _G.OriginalJumpPower or 50
                end
            end
        end)
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid", 10)
    if hum then
        task.wait(0.1)
        if SpeedState then
            hum.WalkSpeed = tonumber(WalkSpeedValue) or 27
        end
        if JumpPowerState then
            if hum.UseJumpPower then
                hum.JumpPower = tonumber(JumpPowerValue) or 50
            else
                hum.JumpHeight = tonumber(JumpPowerValue) or 50
            end
        end
    end
end)

NoRenderState = false
NoRenderConnection = nil
LowGraphicsState = false
LowGraphicsCache = {}
OriginalShadowSetting = game:GetService("Lighting").GlobalShadows

function OptimizeFallenObject(obj)
    xpcall(function()
        if obj:IsA("BasePart") then
            if LowGraphicsCache[obj] == nil then
                LowGraphicsCache[obj] = {
                    Material = obj.Material,
                    CastShadow = obj.CastShadow,
                    Reflectance = obj.Reflectance
                }
            end
            obj.Material = Enum.Material.SmoothPlastic
            obj.CastShadow = false
            obj.Reflectance = 0
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Sparkles") or obj:IsA("Fire") or obj:IsA("Beam") then
            if LowGraphicsCache[obj] == nil then
                LowGraphicsCache[obj] = {
                    Enabled = obj.Enabled
                }
            end
            obj.Enabled = false
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            if LowGraphicsCache[obj] == nil then
                LowGraphicsCache[obj] = {
                    Transparency = obj.Transparency
                }
            end
            obj.Transparency = 1
        end
    end, function(Error)
        print("Failed to optimize object instance: " .. tostring(Error))
    end)
end

function DisableFallenLowGraphics()
    xpcall(function()
        for obj, origData in pairs(LowGraphicsCache) do
            if obj and obj.Parent then
                if obj:IsA("BasePart") then
                    obj.Material = origData.Material
                    obj.CastShadow = origData.CastShadow
                    obj.Reflectance = origData.Reflectance
                elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Sparkles") or obj:IsA("Fire") or obj:IsA("Beam") then
                    obj.Enabled = origData.Enabled
                elseif obj:IsA("Decal") or obj:IsA("Texture") then
                    obj.Transparency = origData.Transparency
                end
            end
        end
        game:GetService("Lighting").GlobalShadows = OriginalShadowSetting
        table.clear(LowGraphicsCache)
    end, function(Error)
        print("Failed to restore original graphics settings: " .. tostring(Error))
    end)
end

function ClearFallenRenderElement(obj)
    xpcall(function()
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Sparkles") or obj:IsA("Fire") or obj:IsA("Beam") then
            if NoRenderCache == nil then NoRenderCache = {} end
            if NoRenderCache[obj] == nil then
                NoRenderCache[obj] = {
                    Enabled = obj.Enabled
                }
            end
            obj.Enabled = false
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            if NoRenderCache == nil then NoRenderCache = {} end
            if NoRenderCache[obj] == nil then
                NoRenderCache[obj] = {
                    Transparency = obj.Transparency
                }
            end
            obj.Transparency = 1
        end
    end, function(Error)
        print("Failed to obscure scene object: " .. tostring(Error))
    end)
end

function RestoreFallenRenderElements()
    xpcall(function()
        if NoRenderCache then
            for obj, origData in pairs(NoRenderCache) do
                if obj and obj.Parent then
                    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Sparkles") or obj:IsA("Fire") or obj:IsA("Beam") then
                        obj.Enabled = origData.Enabled
                    elseif obj:IsA("Decal") or obj:IsA("Texture") then
                        obj.Transparency = origData.Transparency
                    end
                end
            end
            table.clear(NoRenderCache)
        end
    end, function(Error)
        print("Failed to restore obscured environment: " .. tostring(Error))
    end)
end

Config.OptimizedRainbowBall = false
Config.OptimizedBallTrail = false
Config.OptimizedRainbowSpeed = 0.005

CurrentRainbowHue = 0
LastVisualUpdateTick = 0

function ApplyLowResourceTrail(targetBall)
    if not targetBall or not targetBall.Parent then return end
    if targetBall:FindFirstChild("Invis_LowResourceTrail") then return end

    att0 = Instance.new("Attachment")
    att0.Name = "Invis_TrailAtt0"
    att0.Position = Vector3.new(0, 0.4, 0)
    att0.Parent = targetBall

    att1 = Instance.new("Attachment")
    att1.Name = "Invis_TrailAtt1"
    att1.Position = Vector3.new(0, -0.4, 0)
    att1.Parent = targetBall

    lowTrail = Instance.new("Trail")
    lowTrail.Name = "Invis_LowResourceTrail"
    lowTrail.Attachment0 = att0
    lowTrail.Attachment1 = att1
    lowTrail.Lifetime = 0.35
    lowTrail.LightEmission = 0.8
    lowTrail.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.1),
        NumberSequenceKeypoint.new(1, 1)
    })
    lowTrail.Enabled = Config.OptimizedBallTrail
    lowTrail.Parent = targetBall
end

if shared.LowResourceVisualThread then
    shared.LowResourceVisualThread:Disconnect()
    shared.LowResourceVisualThread = nil
end

shared.LowResourceVisualThread = game:GetService("RunService").Heartbeat:Connect(function()
    if not shared._InvisRunning then return end
    
    currentTick = os.clock()
    if currentTick - LastVisualUpdateTick < 0.02 then 
        return 
    end
    LastVisualUpdateTick = currentTick

    activeBallsList = {}
    if type(Auto_Parry) == "table" and type(Auto_Parry.Get_Balls) == "function" then
        activeBallsList = Auto_Parry.Get_Balls()
    end

    CurrentRainbowHue = (CurrentRainbowHue + (tonumber(Config.OptimizedRainbowSpeed) or 0.005)) % 1
    staticRainbowColor = Color3.fromHSV(CurrentRainbowHue, 0.85, 1)

    for i = 1, #activeBallsList do
        targetBallPart = activeBallsList[i]
        if targetBallPart and targetBallPart.Parent then
            
            if Config.OptimizedRainbowBall then
                targetBallPart.Color = staticRainbowColor
                if targetBallPart.Material ~= Enum.Material.Neon then
                    targetBallPart.Material = Enum.Material.Neon
                end
            end

            ballTrailInstance = targetBallPart:FindFirstChild("Invis_LowResourceTrail")
            if Config.OptimizedBallTrail then
                if not ballTrailInstance then
                    ApplyLowResourceTrail(targetBallPart)
                else
                    if not ballTrailInstance.Enabled then
                        ballTrailInstance.Enabled = true
                    end
                    ballTrailInstance.Color = ColorSequence.new(staticRainbowColor)
                end
            else
                if ballTrailInstance and ballTrailInstance.Enabled then
                    ballTrailInstance.Enabled = false
                end
            end
            
        end
    end
end)

Config.TesterMode = false
TesterHistoryBuffer = {}

function SetupTesterModeDied(character)
    local humanoid = character:WaitForChild("Humanoid", 5)
    local hrp = character:WaitForChild("HumanoidRootPart", 5)
    if not humanoid or not hrp then return end
    
    local hasLoggedDeath = false
    local checkConnection
    
    checkConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not character or not character.Parent or not humanoid or not hrp then
            checkConnection:Disconnect()
            return
        end
        
        local currentTime = os.clock()
        
        if humanoid.Health > 0 then
            local currentBallSpeed = 0
            local targetBall = type(Auto_Parry) == "table" and type(Auto_Parry.Get_Ball) == "function" and Auto_Parry.Get_Ball()
            if targetBall and targetBall.Parent then
                local velocity = Vector3.zero
                local zoomies = targetBall:FindFirstChild("zoomies")
                if zoomies then pcall(function() velocity = zoomies.VectorVelocity end) end
                if velocity == Vector3.zero and targetBall:IsA("BasePart") then velocity = targetBall.AssemblyLinearVelocity end
                currentBallSpeed = velocity.Magnitude
            end

            local nearestPlayerName = "None"
            local nearestDistance = 0
            local shortestDist = math.huge
            local aliveFolder = workspace:FindFirstChild("Alive")
            if aliveFolder then
                for _, target in ipairs(aliveFolder:GetChildren()) do
                    if target:IsA("Model") and target ~= character then
                        local hrpTarget = target:FindFirstChild("HumanoidRootPart")
                        if hrpTarget then
                            local worldDist = (hrp.Position - hrpTarget.Position).Magnitude
                            if worldDist < shortestDist then
                                shortestDist = worldDist
                                nearestPlayerName = target.Name
                                nearestDistance = worldDist
                            end
                        end
                    end
                end
            end

            local currentReaction = 0
            if matchStats and matchStats.ReactionTime then
                currentReaction = tonumber(matchStats.ReactionTime) or 0
            end

            local currentPing = 0
            pcall(function()
                if StatsService then
                    local network = StatsService:FindFirstChild("Network")
                    local serverStats = network and network:FindFirstChild("ServerStatsItem")
                    local dataPing = serverStats and serverStats:FindFirstChild("Data Ping")
                    if dataPing then currentPing = dataPing:GetValue() or 0 end
                end
            end)

            table.insert(TesterHistoryBuffer, {
                Time = currentTime,
                BallSpeed = currentBallSpeed,
                Reaction = currentReaction,
                NearestName = nearestPlayerName,
                NearestDist = nearestDistance,
                Ping = currentPing
            })

            while #TesterHistoryBuffer > 0 and (currentTime - TesterHistoryBuffer[1].Time) > 1.5 do
                table.remove(TesterHistoryBuffer, 1)
            end
        end

        if humanoid.Health <= 0 and not hasLoggedDeath then
            hasLoggedDeath = true
            checkConnection:Disconnect()
            
            if not Config.TesterMode then return end
            
            local targetTime = currentTime - 0.4
            local selectedLog = nil
            local bestDiff = math.huge
            
            for i = #TesterHistoryBuffer, 1, -1 do
                local log = TesterHistoryBuffer[i]
                local diff = math.abs(log.Time - targetTime)
                if diff < bestDiff then
                    bestDiff = diff
                    selectedLog = log
                end
            end
            
            if not selectedLog and #TesterHistoryBuffer > 0 then
                selectedLog = TesterHistoryBuffer[#TesterHistoryBuffer]
            end
            
            local finalBallSpeed = selectedLog and selectedLog.BallSpeed or 0
            local finalReaction = selectedLog and selectedLog.Reaction or 0
            local finalNearestName = selectedLog and selectedLog.NearestName or "None"
            local finalNearestDist = selectedLog and selectedLog.NearestDist or 0
            local finalPing = selectedLog and selectedLog.Ping or 0
            
            local currentFps = 0
            pcall(function()
                currentFps = 1 / workspace.CurrentCamera.MaxAxisBound
            end)
            if currentFps <= 0 or currentFps > 1000 then
                pcall(function()
                    currentFps = 1 / game:GetService("RunService").RenderStepped:Wait()
                end)
            end

            local noticeText = string.format(
                "Take a screenshot to me\n" ..
                "- Ball Speed: %.2f\n" ..
                "- Time Reaction: %.3f\n" ..
                "- Parry Cooldown: %.3f\n" ..
                "- Parry Accuracy: %d\n" ..
                "- Nearest Player Is: %s (%.1f studs)\n" ..
                "- Ping: %.1f ms\n" ..
                "- FPS: %d",
                finalBallSpeed,
                finalReaction,
                tonumber(Config.ParryCooldownValue) or 0.12,
                tonumber(Config.accuracy) or 100,
                finalNearestName,
                finalNearestDist,
                finalPing,
                math.floor(currentFps)
            )

            if type(Library) == "table" and type(Library.CreateNotice) == "function" then
                Library:CreateNotice({
                    Title = "Tester Log Info",
                    Text = noticeText,
                    Type = "OK"
                })
            else
                print(noticeText)
            end
            
            table.clear(TesterHistoryBuffer)
        end
    end)
end

if Players.LocalPlayer.Character then
    SetupTesterModeDied(Players.LocalPlayer.Character)
end
Players.LocalPlayer.CharacterAdded:Connect(SetupTesterModeDied)


--==============================================================
-- Gui
--==============================================================
local autotab = Library:CreateTab("Auto")
local manualtab = Library:CreateTab("Manual")
local visualtab = Library:CreateTab("Visual")
local playertab = Library:CreateTab("Player")
local balltab = Library:CreateTab("Ball")
local boosttab = Library:CreateTab("Booster")
local immortaltab = Library:CreateTab("Immortal")
local abilitytab = Library:CreateTab("Ability Detections")

--
-- Auto Tab
--

autotab:CreateLabel("• TESTER •")

autotab:CreateToggle("Tester Mode", Config.TesterMode, function(value)
    Config.TesterMode = value
end)

autotab:CreateLabel("• AUTO PARRY •")

autotab:CreateToggle("Auto Parry", Config.AutoParry, function(value)
    Config.AutoParry = value
end)

autotab:CreateToggle("Custom Parry Sound", Config.Sound, function(value)
    Config.Sound = value
end)

autotab:CreateToggle("Play Parry Animation", Config.Sound, function(value)
    Config.SwordAnimationsEnabled = value
end)

cfg = (type(Config) == "table") and Config or {}
if cfg.ParryCurveMode == nil then
    cfg.ParryCurveMode = "Camera"
end

curveOptionsList = {"Camera", "Left", "Right", "Up", "Down", "Random", "Straight", "Super Curve Random"}

autotab:CreateSelect("Select Curve Mode", curveOptionsList, function(selectedModeName)
    pcall(function()
        cfg.ParryCurveMode = tostring(selectedModeName)
    end)
end)

Config = Config or {}
Config.TargetLockMode = "Normal"

TargetModeOptionsList = {"Normal", "Double Click", "Nearest", "Farthest"}

autotab:CreateSelect("Select Target Lock Mode", TargetModeOptionsList, function(selectedModeName)
    pcall(function()
        Config.TargetLockMode = tostring(selectedModeName)
        if Config.TargetLockMode ~= "Double Click" then
            shared.Clicked_Target_Name = nil
            activeTargetPlayer = nil
            if TargetBillboardGui then
                TargetBillboardGui:Destroy()
                TargetBillboardGui = nil
            end
        end
    end)
end)

-- =======================================================================
-- 🎯 DYNAMIC ACCURACY SLIDER INTERFACE (FIXED BY AI)
-- =======================================================================
cfg = (type(Config) == "table") and Config or {}
if cfg.ParryMode == nil then
    cfg.ParryMode = "Curve"
end

antiCurveOptionsList = {"Curve", "God Curve"}

-- ประกาศตัวแปรเก็บอ้างอิงของระบบ Slider ไว้เพื่อให้เมนูเลือกโหมดสามารถเข้าถึงและสั่งเปลี่ยนค่าได้
local AccuracySliderObject = nil

autotab:CreateSelect("Anti Curve Mode", antiCurveOptionsList, function(selectedModeName)
    pcall(function()
        cfg.ParryMode = tostring(selectedModeName)
        
        if cfg.ParryMode == "God Curve" then
          Library:CreateNotice({
              Title = "Configuration Guide",
              Text = "For God curve best accuracy is 38 - 70",
              Type = "OK"
          })
        end
        
        -- ตรวจสอบว่าระบบ Slider ถูกสร้างขึ้นบนหน้าจอหรือยัง
        if AccuracySliderObject and type(AccuracySliderObject.Set) == "function" then
            if cfg.ParryMode == "God Curve" then
                -- ถ้าเลือก God Curve และค่าปัจจุบันเกิน 100 ให้ตบค่าลงมาที่ 100 ทันที
                if (Config.Accuracy or 0) > 100 then
                    AccuracySliderObject:Set(100)
                end
                
                -- เปลี่ยนข้อความจำลองสูงสุดของขอบเขตบน UI (หลอกการแสดงผลขอบเขตบาร์)
                if HolderLabel and HolderBar then
                    pcall(function()
                        -- หากมีระบบ UI ดั้งเดิม โค้ดจะอัปเดตตัวคูณฟิสิกส์หลอดให้สั้นลงตามสเกล 100
                        local currentVal = math.clamp(Config.Accuracy or 100, 1, 100)
                        AccuracySliderObject:Set(currentVal)
                    end)
                end
            end
        end
    end)
end)

pcall(function()
    Config.Accuracy = Config.Accuracy or 100
end)

-- สร้าง Slider โดยตั้งค่า Max ไว้สูงสุดที่ 300 เพื่อรองรับโหมด Curve
AccuracySliderObject = autotab:CreateSlider("Parry Accuracy Timing", 1, 180, Config.Accuracy, function(Value)
    -- ดักจับเงื่อนไข (ตรรกะเบรกฟิสิกส์แฝง): ถ้าอยู่ในโหมด God Curve ห้ามให้ค่าเกิน 100 เด็ดขาด
    if cfg.ParryMode == "God Curve" and Value > 100 then
        if AccuracySliderObject and type(AccuracySliderObject.Set) == "function" then
            AccuracySliderObject:Set(100) -- บังคับสไลเดอร์เด้งกลับมาที่ 100
        else
            Config.Accuracy = 100
        end
        return
    end
    
    Config.Accuracy = Value
end)

autotab:CreateSlider("Parry Cooldown", 0.01 * 100, 1 * 100, (Config.ParryCooldownValue or 0.12) * 100, function(value)
    Config.ParryCooldownValue = value / 100
end)

autotab:CreateToggle("Auto Cooldown Parry", Config.AutoCooldownParry, function(value)
    Config.AutoCooldownParry = value
end)

autotab:CreateLabel("• AUTO SPAM •")

xpcall(function()
    -- 1. ปุ่มเปิด-ปิดระบบ Auto Spam (Clash System)
    autotab:CreateToggle("Auto Spam (Clash System)", Config.AutoSpam, function(value)
        Config.AutoSpam = value
        Config.ClashTarget = value
        if not value then
            shared.ManualSpamActive = false
        end
    end)

    -- 2. แถบปรับความเร็วดีเลย์สแปม (รองรับการแปลงค่าเป็นเศษส่วนมิลลิวินาทีอย่างแม่นยำ)
    autotab:CreateSlider("Spam Speed Delay", 1, 100, math.floor((Config.AutoSpamSpeed or 0.005) * 1000), function(value)
        Config.AutoSpamSpeed = value / 1000
    end)
    
end, function(errorMessage)
    print("Interface setup failed for advanced clash controller: " .. tostring(errorMessage))
end)

pcall(function()
    Config = Config or {}
    Config.AutoAbility = false
    Config.AutoAbilityMode = "Defensive"
    Config.AbilityStrikeZone = 35
end)

xpcall(function()
    autotab:CreateLabel("• AUTO ABILITY •")

    autotab:CreateToggle("Enable Auto Ability", Config.AutoParry, function(value)
        Config.AutoAbility = value
    end)

    abilityModesList = {
        "Defensive Whiff Protection",
        "Targeted Detection",
        "Instant Spammer",
        "Clash Overdrive Focus",
        "Distance Strike Prompt",
        "Ability before"
    }

    autotab:CreateSelect("Select Ability Mode", abilityModesList, function(selectedModeName)
        pcall(function()
            Config.AutoAbilityMode = tostring(selectedModeName)
        end)
    end)

    autotab:CreateSlider("Ability Strike Distance", 10, 100, Config.AbilityStrikeZone or 35, function(value)
        Config.AbilityStrikeZone = value
    end)
end, function(errorMessage)
    print("Interface setup failed for advanced auto ability elements: " .. tostring(errorMessage))
end)

if shared._InvisAutoAbilityThread then
    task.cancel(shared._InvisAutoAbilityThread)
    shared._InvisAutoAbilityThread = nil
end

shared._InvisAutoAbilityThread = task.spawn(function()
    xpcall(function()
        while shared._InvisRunning do
            game:GetService("RunService").Heartbeat:Wait()
            
            if Config.AutoAbility then
                character = game.Players.LocalPlayer.Character
                hrp = character and character:FindFirstChild("HumanoidRootPart")
                myHum = character and character:FindFirstChildOfClass("Humanoid")
                
                if hrp and myHum and myHum.Health > 0 then
                    ball = type(Auto_Parry.Get_Ball) == "function" and Auto_Parry.Get_Ball()
                    
                    if ball and ball.Parent then
                        zoomies = ball:FindFirstChild("zoomies")
                        velocity = zoomies and zoomies.VectorVelocity or ball.AssemblyLinearVelocity
                        ballSpeed = velocity.Magnitude
                        distance = (hrp.Position - ball.Position).Magnitude
                        
                        targetAttr = ball:GetAttribute("target") or ball:GetAttribute("Target")
                        ballTargetStr = tostring(targetAttr or "")
                        isTargetingMe = (ballTargetStr == game.Players.LocalPlayer.Name or ballTargetStr == character.Name)
                        
                        triggerAbility = false
                        currentMode = Config.AutoAbilityMode
                        
                        if currentMode == "Defensive Whiff Protection" then
                            if isTargetingMe and type(parryLocked) == "table" and parryLocked[ball] == false then
                                lastHitTime = lastHitTicks[ball] or 0
                                if lastHitTime > 0 and (os.clock() - lastHitTime) >= 0.75 then
                                    triggerAbility = true
                                end
                            end
                            
                        elseif currentMode == "Targeted Detection" then
                            if isTargetingMe then
                                triggerAbility = true
                            end
                            
                        elseif currentMode == "Instant Spammer" then
                            triggerAbility = true
                            
                        elseif currentMode == "Clash Overdrive Focus" then
                            if shared.ManualSpamActive == true then
                                triggerAbility = true
                            end
                            
                        elseif currentMode == "Distance Strike Prompt" then
                            activationZone = math.clamp(tonumber(Config.AbilityStrikeZone) or 35, 10, 100)
                            if isTargetingMe and distance <= activationZone then
                                triggerAbility = true
                            end
                        elseif currentMode == "Ability before" then
    if isTargetingMe then
        ping_ms = pingSeconds * 1000
        ping_threshold = math.clamp(ping_ms / 100, 5, 17)
        cappedSpeedDiff = math.min(math.max(Speed - 9.5, 0), 2500)
        speed_divisor_base = 2.4 + cappedSpeedDiff * 0.002
        base_multiplier = 0.715
        if Config.Accuracy ~= 100 then
            base_multiplier = 0.715 * (Config.Accuracy / 100)
        end
        speed_divisor = speed_divisor_base * base_multiplier
        parry_accuracy = ping_threshold + math.max(Speed / speed_divisor, 9.5)
        userScale = distanceTiming / 100
        verticalYBuffer = math.max(math.abs(Velocity.Y) * 0.22, 0)
        skyDescentBuffer = 0
        if Velocity.Y < -5 then
            skyDescentBuffer = math.max(math.abs(Velocity.Y) * 0.42, 12)
        end
        curve_kill_zone = (parry_accuracy * userScale) + verticalYBuffer + skyDescentBuffer
        if Speed < 85 and Speed > 25 then
            curve_kill_zone = math.clamp(curve_kill_zone, 27, 37)
        end
        ability_trigger_zone = curve_kill_zone + (Speed * 0.35)
        if Distance <= ability_trigger_zone and Distance > curve_kill_zone then
            triggerAbility = true
            if ball and type(parryLocked) == "table" then
                parryLocked[ball] = true
                lockTime[ball] = os.clock()
            end
        end
    end
    
                        end
                        
                        if triggerAbility then
                            pcall(function()
                                game:GetService("ReplicatedStorage").Remotes.AbilityButtonPress:Fire()
                                game:GetService("ReplicatedStorage").Remotes.DeathSlashShootActivation:FireServer(true)
                            end)
                            lastHitTicks[ball] = 0
                        end
                    end
                end
            end
        end
    end, function(errorMessage)
        print("Advanced auto ability loop runtime execution failure: " .. tostring(errorMessage))
    end)
end)

autotab:CreateLabel("• AUTO PLAY •")

xpcall(function()
    cfg = (type(Config) == "table") and Config or {}
    if cfg.AutoPlayMode == nil then
        cfg.AutoPlayMode = "Defensive (Backstep)"
    end

    autotab:CreateToggle("Auto Play Bot", Config.AutoPlay, function(value)
        cfg = (type(Config) == "table") and Config or {}
        cfg.AutoPlay = value
    end)

    autotab:CreateSelect("Auto Play Mode Profile", { "Defensive (Backstep)", "Offensive (Rush)", "Dynamic Support" }, function(value)
        cfg = (type(Config) == "table") and Config or {}
        cfg.AutoPlayMode = value
    end)
end, function(errorMessage)
    print("Interface setup failed for advanced auto play controller: " .. tostring(errorMessage))
end)

--
-- Manual Tab
--

xpcall(function()
    targetScreenGui = CoreGui:FindFirstChild("Fallen") or CoreGui:FindFirstChild("RobloxGui") or Players.LocalPlayer:WaitForChild("PlayerGui")
    
    Manual_Spam_Pill_Frame = Instance.new("TextButton")
    Manual_Spam_Pill_Frame.Name = "Invis_ManualSpamFloatingBtn"
    Manual_Spam_Pill_Frame.Size = UDim2.new(0, 55, 0, 55)
    Manual_Spam_Pill_Frame.Position = UDim2.new(0.85, 0, 0.45, 0)
    Manual_Spam_Pill_Frame.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
    Manual_Spam_Pill_Frame.Text = "SPAM\nOFF"
    Manual_Spam_Pill_Frame.TextColor3 = Color3.fromRGB(15, 15, 18)
    Manual_Spam_Pill_Frame.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    Manual_Spam_Pill_Frame.TextSize = 10
    Manual_Spam_Pill_Frame.Visible = false
    Manual_Spam_Pill_Frame.AutoButtonColor = false
    Manual_Spam_Pill_Frame.Parent = targetScreenGui
    
    
    Instance.new("UICorner", Manual_Spam_Pill_Frame).CornerRadius = UDim.new(0, 14)
    
    floatingBtnStroke = Instance.new("UIStroke", Manual_Spam_Pill_Frame)
    floatingBtnStroke.Thickness = 1.5
    floatingBtnStroke.Color = Color3.fromRGB(15, 15, 18)
    
    task.spawn(function()
        while true do
            if floatingBtnStroke and floatingBtnStroke.Parent then
                for i = 0, 1, 0.005 do
                    if floatingBtnStroke and floatingBtnStroke.Parent then floatingBtnStroke.Color = Color3.fromHSV(i, 0.7, 0.9) end
                    task.wait(0.04)
                end
            else break end
        end
    end)
    
    mSpamDrag, mSpamStart, mSpamMouseStart, mSpamBPos, mSpamIsDragging = false, nil, nil, nil, false
    
    Manual_Spam_Pill_Frame.InputBegan:Connect(function(inputObject)
        if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then
            mSpamDrag = true
            mSpamStart = inputObject.Position
            mSpamMouseStart = UserInputService:GetMouseLocation()
            mSpamBPos = Manual_Spam_Pill_Frame.Position
            mSpamIsDragging = false
            TweenService:Create(Manual_Spam_Pill_Frame, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 48, 0, 48)}):Play()
        end
    end)
    
    UserInputService.InputChanged:Connect(function(inputObject)
        if mSpamDrag and (inputObject.UserInputType == Enum.UserInputType.MouseMovement or inputObject.UserInputType == Enum.UserInputType.Touch) then
            if (UserInputService:GetMouseLocation() - mSpamMouseStart).Magnitude > 5 then 
                mSpamIsDragging = true 
            end
            if mSpamIsDragging then
                deltaOffset = inputObject.Position - mSpamStart
                cameraViewport = workspace.CurrentCamera
                maxX = cameraViewport and cameraViewport.ViewportSize.X - 55 or 800
                maxY = cameraViewport and cameraViewport.ViewportSize.Y - 55 or 600
                targetX = math.clamp(mSpamBPos.X.Offset + deltaOffset.X, 0, maxX)
                targetY = math.clamp(mSpamBPos.Y.Offset + deltaOffset.Y, 0, maxY)
                Manual_Spam_Pill_Frame.Position = UDim2.new(mSpamBPos.X.Scale, targetX, mSpamBPos.Y.Scale, targetY)
            end
        end
    end)
    
    Manual_Spam_Pill_Frame.InputEnded:Connect(function(inputObject)
        if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then
            mSpamDrag = false
            TweenService:Create(Manual_Spam_Pill_Frame, TweenInfo.new(0.3, Enum.EasingStyle.Elastic), {Size = UDim2.new(0, 55, 0, 55)}):Play()
                        if not mSpamDragging then
                ManualSpamActive = not ManualSpamActive
                ManualSpamEnabled = ManualSpamActive
                
                if ManualSpamActive then
                    Manual_Spam_Pill_Frame.Text = "SPAM\nON"
                    Manual_Spam_Pill_Frame.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Manual_Spam_Pill_Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
                    Manual_Spam_Start()
                else
                    Manual_Spam_Pill_Frame.Text = "SPAM\nOFF"
                    Manual_Spam_Pill_Frame.TextColor3 = Color3.fromRGB(15, 15, 18)
                    Manual_Spam_Pill_Frame.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
                    Manual_SpamClose()
                end
                
                if type(update_manual_spam_overlay) == "function" then pcall(update_manual_spam_overlay) end
            end
        end
    end)
end, function(errorMessage)
    print("Failed to initialize custom manual spam floating button overlay: " .. tostring(errorMessage))
end)

xpcall(function()
manualtab:CreateToggle("Show Manual Spam Button", false, function(value)
    if type(Manual_Spam_Pill_Frame) == "userdata" then
        Manual_Spam_Pill_Frame.Visible = value
        if not value then
            ManualSpamActive = false
            ManualSpamEnabled = false
            if type(update_manual_spam_overlay) == "function" then pcall(update_manual_spam_overlay) end
        end
    end
end)

manualtab:CreateSelect("Spam Intensity Profile", { "Normal", "God", "Super Fast", "Fast", "Slow" }, function(value)
    cfg = (type(Config) == "table") and Config or {}
    cfg.ManualSpamMode = value
end)
end, function(errorMessage)
    print("Interface setup failed for advanced manual spam controller: " .. tostring(errorMessage))
end)

if shared._InvisKeybindConnection then
    shared._InvisKeybindConnection:Disconnect()
    shared._InvisKeybindConnection = nil
end

shared._InvisKeybindConnection = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    xpcall(function()
        if gameProcessed then return end
        
        cfg = (type(Config) == "table") and Config or {}
        if not cfg.UseKeybindForManualSpam then return end

        if input.KeyCode == cfg.SelectedSpamKeyCode then
            cfg.ManualSpam = not cfg.ManualSpam
            
            if type(AutoSaveConfig) == "function" then 
                pcall(AutoSaveConfig) 
            end
        end
    end, function(errorMessage)
        print("Core standalone keybind logic execution failure: " .. tostring(errorMessage))
    end)
end)

xpcall(function()
    cfg = (type(Config) == "table") and Config or {}
    
    if cfg.UseKeybindForManualSpam == nil then
        cfg.UseKeybindForManualSpam = false
    end
    
    if cfg.SelectedSpamKeyCode == nil then
        cfg.SelectedSpamKeyCode = Enum.KeyCode.E
    end

    if type(manualtab) == "table" and type(manualtab.CreateLabel) == "function" then
        manualtab:CreateLabel("• KEYBIND MANUAL SPAM •")
    end

    if type(manualtab) == "table" and type(manualtab.CreateToggle) == "function" then
        manualtab:CreateToggle("Use Keybind For Spam", cfg.UseKeybindForManualSpam, function(value)
            cfg.UseKeybindForManualSpam = value
        end)
    end

    availableKeysList = {"E", "Q", "F", "R", "C", "X", "Z", "V", "G"}

    if type(manualtab) == "table" and type(manualtab.CreateSelect) == "function" then
        manualtab:CreateSelect("Trigger Keybind", availableKeysList, function(selectedKeyName)
            pcall(function()
                cfg.SelectedSpamKeyCode = Enum.KeyCode[selectedKeyName]
            end)
        end)
    end

end, function(errorMessage)
    print("Failed to inject standalone keybind elements into manualtab: " .. tostring(errorMessage))
end)

pcall(function()
    Config = Config or {}
    Config.InfiniteSpamActive = false
    Config.InfiniteSpamShow = false
    Config.packetBatchSize = 16
end)

xpcall(function()
    targetScreenGui = CoreGui:FindFirstChild("Fallen") or CoreGui:FindFirstChild("RobloxGui") or Players.LocalPlayer:WaitForChild("PlayerGui")
    
    Infinite_Spam_Pill_Frame = Instance.new("TextButton")
    Infinite_Spam_Pill_Frame.Name = "Invis_InfiniteSpamFloatingBtn"
    Infinite_Spam_Pill_Frame.Size = UDim2.new(0, 55, 0, 55)
    Infinite_Spam_Pill_Frame.Position = UDim2.new(0.85, 0, 0.58, 0)
    Infinite_Spam_Pill_Frame.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
    Infinite_Spam_Pill_Frame.Text = "INF\nOFF"
    Infinite_Spam_Pill_Frame.TextColor3 = Color3.fromRGB(15, 15, 18)
    Infinite_Spam_Pill_Frame.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
    Infinite_Spam_Pill_Frame.TextSize = 10
    Infinite_Spam_Pill_Frame.Visible = false
    Infinite_Spam_Pill_Frame.AutoButtonColor = false
    Infinite_Spam_Pill_Frame.Parent = targetScreenGui
    
    Instance.new("UICorner", Infinite_Spam_Pill_Frame).CornerRadius = UDim.new(0, 14)
    
    infFloatingBtnStroke = Instance.new("UIStroke", Infinite_Spam_Pill_Frame)
    infFloatingBtnStroke.Thickness = 1.5
    infFloatingBtnStroke.Color = Color3.fromRGB(15, 15, 18)
    
    task.spawn(function()
        while true do
            if infFloatingBtnStroke and infFloatingBtnStroke.Parent then
                for i = 0, 1, 0.005 do
                    if infFloatingBtnStroke and infFloatingBtnStroke.Parent then infFloatingBtnStroke.Color = Color3.fromHSV(i, 0.7, 0.9) end
                    task.wait(0.04)
                end
            else break end
        end
    end)
    
    infSpamDrag, infSpamStart, infSpamMouseStart, infSpamBPos, infSpamIsDragging = false, nil, nil, nil, false
    
    Infinite_Spam_Pill_Frame.InputBegan:Connect(function(inputObject)
        if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then
            infSpamDrag = true
            infSpamStart = inputObject.Position
            infSpamMouseStart = UserInputService:GetMouseLocation()
            infSpamBPos = Infinite_Spam_Pill_Frame.Position
            infSpamIsDragging = false
            TweenService:Create(Infinite_Spam_Pill_Frame, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 48, 0, 48)}):Play()
        end
    end)
    
    UserInputService.InputChanged:Connect(function(inputObject)
        if infSpamDrag and (inputObject.UserInputType == Enum.UserInputType.MouseMovement or inputObject.UserInputType == Enum.UserInputType.Touch) then
            if (UserInputService:GetMouseLocation() - infSpamMouseStart).Magnitude > 5 then 
                infSpamIsDragging = true 
            end
            if infSpamIsDragging then
                deltaOffset = inputObject.Position - infSpamStart
                cameraViewport = workspace.CurrentCamera
                maxX = cameraViewport and cameraViewport.ViewportSize.X - 55 or 800
                maxY = cameraViewport and cameraViewport.ViewportSize.Y - 55 or 600
                targetX = math.clamp(infSpamBPos.X.Offset + deltaOffset.X, 0, maxX)
                targetY = math.clamp(infSpamBPos.Y.Offset + deltaOffset.Y, 0, maxY)
                Infinite_Spam_Pill_Frame.Position = UDim2.new(infSpamBPos.X.Scale, targetX, infSpamBPos.Y.Scale, targetY)
            end
        end
    end)
    
    Infinite_Spam_Pill_Frame.InputEnded:Connect(function(inputObject)
        if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then
            infSpamDrag = false
            TweenService:Create(Infinite_Spam_Pill_Frame, TweenInfo.new(0.3, Enum.EasingStyle.Elastic), {Size = UDim2.new(0, 55, 0, 55)}):Play()
            if not infSpamIsDragging then
                Config.InfiniteSpamActive = not Config.InfiniteSpamActive
                
                if Config.InfiniteSpamActive then
                    Infinite_Spam_Pill_Frame.Text = "INF\nON"
                    Infinite_Spam_Pill_Frame.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Infinite_Spam_Pill_Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
                else
                    Infinite_Spam_Pill_Frame.Text = "INF\nOFF"
                    Infinite_Spam_Pill_Frame.TextColor3 = Color3.fromRGB(15, 15, 18)
                    Infinite_Spam_Pill_Frame.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
                end
            end
        end
    end)
end, function(errorMessage)
    print("Failed to initialize infinite spam floating button: " .. tostring(errorMessage))
end)

xpcall(function()
    manualtab:CreateLabel("• INFINITE SPAM SYSTEM •")
    
    manualtab:CreateToggle("Show Infinite Spam Button", false, function(value)
        if type(Infinite_Spam_Pill_Frame) == "userdata" then
            Config.InfiniteSpamShow = value
            Infinite_Spam_Pill_Frame.Visible = value
            if not value then
                Config.InfiniteSpamActive = false
                Infinite_Spam_Pill_Frame.Text = "INF\nOFF"
                Infinite_Spam_Pill_Frame.TextColor3 = Color3.fromRGB(15, 15, 18)
                Infinite_Spam_Pill_Frame.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
            end
        end
    end)

    manualtab:CreateSlider("Packet Batch Size", 1, 1000, Config.packetBatchSize or 16, function(value)
        Config.packetBatchSize = value
    end)
end, function(errorMessage)
    print("Interface setup failed for infinite spam elements: " .. tostring(errorMessage))
end)

task.spawn(function()
    while shared._InvisRunning do
        if Config.InfiniteSpamActive and Config.InfiniteSpamShow then
            ball = type(Auto_Parry.Get_Ball) == "function" and Auto_Parry.Get_Ball()
            if ball and ball.Parent and type(Auto_Parry.FireParryRemote) == "function" then
                batch = math.clamp(tonumber(Config.packetBatchSize) or 16, 1, 1000)
                interval = 1 / batch
                coroutine.wrap(function()
                    for i = 1, batch do
                        if not Config.InfiniteSpamActive or not Config.InfiniteSpamShow then break end
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

pcall(function()
    Config = Config or {}
    Config.UseKeybindForInfiniteSpam = false
    Config.SelectedInfiniteSpamKeyCode = Enum.KeyCode.G
end)

xpcall(function()
    manualtab:CreateLabel("• KEYBIND INFINITE SPAM •")
    
    manualtab:CreateToggle("Use Keybind For Infinite", Config.UseKeybindForInfiniteSpam, function(value)
        Config.UseKeybindForInfiniteSpam = value
    end)

    infiniteKeysList = {"G", "H", "T", "Y", "U", "I", "O", "P"}
    
    manualtab:CreateSelect("Trigger Infinite Keybind", infiniteKeysList, function(selectedKeyName)
        pcall(function()
            Config.SelectedInfiniteSpamKeyCode = Enum.KeyCode[selectedKeyName]
        end)
    end)
end, function(errorMessage)
    print("Failed to inject standalone keybind elements for infinite spam: " .. tostring(errorMessage))
end)

if shared._InvisInfiniteKeybindConnection then
    shared._InvisInfiniteKeybindConnection:Disconnect()
    shared._InvisInfiniteKeybindConnection = nil
end

shared._InvisInfiniteKeybindConnection = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    xpcall(function()
        if gameProcessed then return end
        if not Config.UseKeybindForInfiniteSpam then return end

        if input.KeyCode == Config.SelectedInfiniteSpamKeyCode then
            Config.InfiniteSpamActive = not Config.InfiniteSpamActive
            
            if type(Infinite_Spam_Pill_Frame) == "userdata" then
                if Config.InfiniteSpamActive then
                    Infinite_Spam_Pill_Frame.Text = "INF\nON"
                    Infinite_Spam_Pill_Frame.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Infinite_Spam_Pill_Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
                else
                    Infinite_Spam_Pill_Frame.Text = "INF\nOFF"
                    Infinite_Spam_Pill_Frame.TextColor3 = Color3.fromRGB(15, 15, 18)
                    Infinite_Spam_Pill_Frame.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
                end
            end
        end
    end, function(errorMessage)
        print("Infinite spam keybind execution failure: " .. tostring(errorMessage))
    end)
end)

local targetScreenGui = CoreGui:FindFirstChild("Fallen") or CoreGui:FindFirstChild("RobloxGui") or Players.LocalPlayer:WaitForChild("PlayerGui")

Void_Spam_Pill_Frame = Instance.new("TextButton")
Void_Spam_Pill_Frame.Name = "Void_ManualSpamFloatingBtn"
Void_Spam_Pill_Frame.Size = UDim2.new(0, 55, 0, 55)
Void_Spam_Pill_Frame.Position = UDim2.new(0.85, 0, 0.32, 0)
Void_Spam_Pill_Frame.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
Void_Spam_Pill_Frame.Text = "VOID\nOFF"
Void_Spam_Pill_Frame.TextColor3 = Color3.fromRGB(15, 15, 18)
Void_Spam_Pill_Frame.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
Void_Spam_Pill_Frame.TextSize = 10
Void_Spam_Pill_Frame.Visible = false
Void_Spam_Pill_Frame.AutoButtonColor = false
Void_Spam_Pill_Frame.Parent = targetScreenGui

Instance.new("UICorner", Void_Spam_Pill_Frame).CornerRadius = UDim.new(0, 14)

local voidBtnStroke = Instance.new("UIStroke", Void_Spam_Pill_Frame)
voidBtnStroke.Thickness = 1.5
voidBtnStroke.Color = Color3.fromRGB(15, 15, 18)

task.spawn(function()
    while true do
        if voidBtnStroke and voidBtnStroke.Parent then
            for i = 0, 1, 0.005 do
                if voidBtnStroke and voidBtnStroke.Parent then voidBtnStroke.Color = Color3.fromHSV(i, 0.7, 0.9) end
                task.wait(0.04)
            end
        else break end
    end
end)

local vSpamDrag = false
local vSpamStart = nil
local vSpamBPos = nil
local vSpamIsDragging = false

Void_Spam_Pill_Frame.InputBegan:Connect(function(inputObject)
    if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then
        vSpamDrag = true
        vSpamStart = inputObject.Position
        vSpamBPos = Void_Spam_Pill_Frame.Position
        vSpamIsDragging = false
        TweenService:Create(Void_Spam_Pill_Frame, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 48, 0, 48)}):Play()
    end
end)

UserInputService.InputChanged:Connect(function(inputObject)
    if vSpamDrag and (inputObject.UserInputType == Enum.UserInputType.MouseMovement or inputObject.UserInputType == Enum.UserInputType.Touch) then
        local deltaOffset = inputObject.Position - vSpamStart
        if deltaOffset.Magnitude > 5 then 
            vSpamIsDragging = true 
        end
        if vSpamIsDragging then
            Void_Spam_Pill_Frame.Position = UDim2.new(vSpamBPos.X.Scale, vSpamBPos.X.Offset + deltaOffset.X, vSpamBPos.Y.Scale, vSpamBPos.Y.Offset + deltaOffset.Y)
        end
    end
end)

Void_Spam_Pill_Frame.InputEnded:Connect(function(inputObject)
    if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then
        vSpamDrag = false
        TweenService:Create(Void_Spam_Pill_Frame, TweenInfo.new(0.3, Enum.EasingStyle.Elastic), {Size = UDim2.new(0, 55, 0, 55)}):Play()
        if not vSpamIsDragging then
            VoidSpamActive = not VoidSpamActive
            if VoidSpamActive then
                Void_Spam_Pill_Frame.Text = "VOID\nON"
                Void_Spam_Pill_Frame.TextColor3 = Color3.fromRGB(255, 255, 255)
                Void_Spam_Pill_Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
                Void_Spam_Start()
            else
                Void_Spam_Pill_Frame.Text = "VOID\nOFF"
                Void_Spam_Pill_Frame.TextColor3 = Color3.fromRGB(15, 15, 18)
                Void_Spam_Pill_Frame.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
                Void_Spam_Close()
            end
        end
    end
end)

manualtab:CreateLabel("• VOID MANUAL SPAM SYSTEM •")

manualtab:CreateToggle("Show Void Spam Button", false, function(value)
    if type(Void_Spam_Pill_Frame) == "userdata" then
        Void_Spam_Pill_Frame.Visible = value
        if not value then
            VoidSpamActive = false
            Void_Spam_Pill_Frame.Text = "VOID\nOFF"
            Void_Spam_Pill_Frame.TextColor3 = Color3.fromRGB(15, 15, 18)
            Void_Spam_Pill_Frame.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
            Void_Spam_Close()
        end
    end
end)

Config = Config or {}
Config.UseKeybindForVoidSpam = false
Config.SelectedVoidSpamKeyCode = Enum.KeyCode.Q

if shared._VoidSpamKeybindConn then
    shared._VoidSpamKeybindConn:Disconnect()
    shared._VoidSpamKeybindConn = nil
end

shared._VoidSpamKeybindConn = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    xpcall(function()
        if gameProcessed then return end
        if not Config.UseKeybindForVoidSpam then return end

        if input.KeyCode == Config.SelectedVoidSpamKeyCode then
            VoidSpamActive = not VoidSpamActive
            
            if VoidSpamActive then
                if type(Void_Spam_Pill_Frame) == "userdata" then
                    Void_Spam_Pill_Frame.Text = "VOID\nON"
                    Void_Spam_Pill_Frame.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Void_Spam_Pill_Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
                end
                Void_Spam_Start()
            else
                if type(Void_Spam_Pill_Frame) == "userdata" then
                    Void_Spam_Pill_Frame.Text = "VOID\nOFF"
                    Void_Spam_Pill_Frame.TextColor3 = Color3.fromRGB(15, 15, 18)
                    Void_Spam_Pill_Frame.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
                end
                Void_Spam_Close()
            end
        end
    end, function(err)
        print("Void keybind core execution failure: " .. tostring(err))
    end)
end)

manualtab:CreateLabel("• KEYBIND VOID SPAM •")

manualtab:CreateToggle("Use Keybind For Void", Config.UseKeybindForVoidSpam, function(value)
    Config.UseKeybindForVoidSpam = value
end)

local voidAvailableKeys = {"Q", "E", "F", "R", "C", "X", "Z", "V", "G"}

manualtab:CreateSelect("Void Trigger Keybind", voidAvailableKeys, function(selectedKeyName)
    pcall(function()
        Config.SelectedVoidSpamKeyCode = Enum.KeyCode[selectedKeyName]
    end)
end)

--
-- visual tab
--

visualtab:CreateLabel("• UNLOCK ALL •")

visualtab:CreateButton("Unlock All", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/foreverspacexc-blip/OTHERHUB/refs/heads/main/wSuhUFTr%20(1).txt"))()
    end)
end)

xpcall(function()
    visualtab:CreateLabel("• CHARACTER •")

    visualtab:CreateButton("Headless", function()
        pcall(function()
            character = game.Players.LocalPlayer.Character
            if character then
                head = character:FindFirstChild("Head")
                if head then
                    face = head:FindFirstChildOfClass("Decal")
                    if face then face:Destroy() end
                    head.Transparency = 1
                end
            end
        end)
    end)

visualtab:CreateButton("Korblox Leg", function()
    pcall(function()
        character = game.Players.LocalPlayer.Character
        if character then
            for _, child in ipairs(character:GetChildren()) do
                if child.Name == "LeftLeg" or child.Name == "Left Leg" or child.Name:find("Left Lower Leg") or child.Name:find("Left Foot") or child.Name:find("Left Upper Leg") then
                    child:Destroy()
                end
            end
        end
    end)
end)

end, function(errorMessage)
    print("Appearance tools execution failure: " .. tostring(errorMessage))
end)

visualtab:CreateLabel("• AVATAR CHANGER •")

visualtab:CreateToggle("Enable Avatar Changer", getgenv().avatarChanger or false, function(value)
    getgenv().avatarChanger = value
    if value and getgenv().lastAvatarUser and getgenv().lastAvatarUser ~= "" then
        pcall(function()
            local success, userId = pcall(function() return tonumber(getgenv().lastAvatarUser) or Players:GetUserIdFromNameAsync(getgenv().lastAvatarUser) end)
            if success and userId then
                local character = LocalPlayer.Character
                if character then
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    local head = character:FindFirstChild("Head")
                    if humanoid and head then
                        local modelSuccess, model = pcall(function() return Players:CreateHumanoidModelFromUserId(userId) end)
                        if modelSuccess and model then
                            local head2 = model:FindFirstChild("Head")
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
                            end
                            for _, child in ipairs(character:GetChildren()) do
                                if child:IsA("Accessory") or child:IsA("Clothing") or child:IsA("ShirtGraphic") then
                                    child:Destroy()
                                end
                            end
                            for _, child in ipairs(model:GetChildren()) do
                                if child:IsA("Accessory") then
                                    local clone = child:Clone()
                                    clone.Parent = character
                                    local handle = clone:FindFirstChild("Handle")
                                    if handle and handle:IsA("BasePart") then
                                        handle.CanCollide = false
                                        local torso = head or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
                                        if torso then
                                            handle.CFrame = torso.CFrame
                                            local weld = Instance.new("WeldConstraint")
                                            weld.Part0 = handle
                                            weld.Part1 = torso
                                            weld.Parent = handle
                                        end
                                    end
                                elseif child:IsA("Clothing") or child:IsA("ShirtGraphic") then
                                    child:Clone().Parent = character
                                end
                            end
                            model:Destroy()
                            if getgenv().skinChanger and getgenv().updateSword then
                                task.delay(0.5, function() getgenv().updateSword() end)
                            end
                        else
                            print("Error: Failed to create humanoid model from id")
                        end
                    else
                        print("Error: Local character humanoid or head missing")
                    end
                else
                    print("Error: Local player character not found")
                end
            else
                print("Error: Invalid username or userid")
            end
        end)
    end
end)

visualtab:CreateTextbox("Target Username or UserID", "Enter name or id...", function(text)
    getgenv().lastAvatarUser = text
    if getgenv().avatarChanger and text and text ~= "" then
        pcall(function()
            local success, userId = pcall(function() return tonumber(text) or Players:GetUserIdFromNameAsync(text) end)
            if success and userId then
                local character = LocalPlayer.Character
                if character then
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    local head = character:FindFirstChild("Head")
                    if humanoid and head then
                        local modelSuccess, model = pcall(function() return Players:CreateHumanoidModelFromUserId(userId) end)
                        if modelSuccess and model then
                            local head2 = model:FindFirstChild("Head")
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
                            end
                            for _, child in ipairs(character:GetChildren()) do
                                if child:IsA("Accessory") or child:IsA("Clothing") or child:IsA("ShirtGraphic") then
                                    child:Destroy()
                                end
                            end
                            for _, child in ipairs(model:GetChildren()) do
                                if child:IsA("Accessory") then
                                    local clone = child:Clone()
                                    clone.Parent = character
                                    local handle = clone:FindFirstChild("Handle")
                                    if handle and handle:IsA("BasePart") then
                                        handle.CanCollide = false
                                        local torso = head or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
                                        if torso then
                                            handle.CFrame = torso.CFrame
                                            local weld = Instance.new("WeldConstraint")
                                            weld.Part0 = handle
                                            weld.Part1 = torso
                                            weld.Parent = handle
                                        end
                                    end
                                elseif child:IsA("Clothing") or child:IsA("ShirtGraphic") then
                                    child:Clone().Parent = character
                                end
                            end
                            model:Destroy()
                            if getgenv().skinChanger and getgenv().updateSword then
                                task.delay(0.5, function() getgenv().updateSword() end)
                            end
                        else
                            print("Error: Failed to create humanoid model from id")
                        end
                    else
                        print("Error: Local character humanoid or head missing")
                    end
                else
                    print("Error: Local player character not found")
                end
            else
                print("Error: Invalid username or userid")
            end
        end)
    end
end)

task.spawn(function()
    if getgenv().avatarChangerWatcher then
        getgenv().avatarChangerWatcher:Disconnect()
        getgenv().avatarChangerWatcher = nil
    end
    getgenv().avatarChangerWatcher = LocalPlayer.CharacterAdded:Connect(function(character)
        task.wait(0.5)
        if getgenv().avatarChanger and getgenv().lastAvatarUser and getgenv().lastAvatarUser ~= "" then
            pcall(function()
                local success, userId = pcall(function() return tonumber(getgenv().lastAvatarUser) or Players:GetUserIdFromNameAsync(getgenv().lastAvatarUser) end)
                if success and userId then
                    local humanoid = character:WaitForChild("Humanoid", 10)
                    local head = character:WaitForChild("Head", 10)
                    if humanoid and head then
                        local modelSuccess, model = pcall(function() return Players:CreateHumanoidModelFromUserId(userId) end)
                        if modelSuccess and model then
                            local head2 = model:FindFirstChild("Head")
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
                            end
                            for _, child in ipairs(character:GetChildren()) do
                                if child:IsA("Accessory") or child:IsA("Clothing") or child:IsA("ShirtGraphic") then
                                    child:Destroy()
                                end
                            end
                            for _, child in ipairs(model:GetChildren()) do
                                if child:IsA("Accessory") then
                                    local clone = child:Clone()
                                    clone.Parent = character
                                    local handle = clone:FindFirstChild("Handle")
                                    if handle and handle:IsA("BasePart") then
                                        handle.CanCollide = false
                                        local torso = head or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
                                        if torso then
                                            handle.CFrame = torso.CFrame
                                            local weld = Instance.new("WeldConstraint")
                                            weld.Part0 = handle
                                            weld.Part1 = torso
                                            weld.Parent = handle
                                        end
                                    end
                                elseif child:IsA("Clothing") or child:IsA("ShirtGraphic") then
                                    child:Clone().Parent = character
                                end
                            end
                            model:Destroy()
                            if getgenv().skinChanger and getgenv().updateSword then
                                task.delay(0.5, function() getgenv().updateSword() end)
                            end
                        else
                            print("Error: Failed to create humanoid model from id")
                        end
                    else
                        print("Error: Humanoid or head missing on spawn")
                    end
                else
                    print("Error: Invalid username or userid on spawn")
                end
            end)
        end
    end)
end)

--
-- ability tab
-- 

xpcall(function()
    abilitytab:CreateLabel("• ABILITY BYPASS LISTENER •")
    
    abilitytab:CreateToggle("Detect Infinity Intercept", Det_State.Infinity_Enabled, function(Value)
        Det_State.Infinity_Enabled = Value
    end)
    
    abilitytab:CreateToggle("Detect Death Slash Block", Det_State.DeathSlash_Enabled, function(Value)
        Det_State.DeathSlash_Enabled = Value
    end)
    
    abilitytab:CreateToggle("Detect Time Hole Anti-Freeze", Det_State.TimeHole_Enabled, function(Value)
        Det_State.TimeHole_Enabled = Value
    end)
    
    abilitytab:CreateToggle("Detect Telekinesis Pull Lock", Det_State.Pull_Enabled, function(Value)
        Det_State.Pull_Enabled = Value
    end)
    
    abilitytab:CreateToggle("Detect Slashes of Fury Loop", Det_State.Slashes_Enabled, function(Value)
        Det_State.Slashes_Enabled = Value
    end)
    
    abilitytab:CreateToggle("Detect Forcefield Anti-Spam", Det_State.Forcefield_Enabled, function(Value)
        Det_State.Forcefield_Enabled = Value
    end)
end, function(Error)
    print("Interface setup failed for ability detection tab: " .. tostring(Error))
end)

--
-- player tab
--

pcall(function()
    Config.SpeedToggleEnabled = false
    Config.SpeedLoopModeEnabled = false
    Config.JumpPowerToggleEnabled = false
    Config.JumpPowerLoopModeEnabled = false
    Config.CustomWalkSpeedInput = "27"
    Config.CustomJumpPowerInput = "50"
end)

playertab:CreateLabel("• FLY •")

playertab:CreateToggle("Enable Fly Hack", Config.FlyEnabled, function(value)
    if value then
        StartFlying()
    else
        StopFlying()
    end
end)

playertab:CreateTextbox("Fly Speed Configuration", "50", function(Value)
    NumericCheck = tonumber(Value)
    if NumericCheck then
        FlySpeed = NumericCheck
    else
        print("Error: Invalid numerical fly speed input value")
    end
end)

playertab:CreateLabel("• SPEED •")

playertab:CreateToggle("Enable WalkSpeed", Config.SpeedToggleEnabled, function(value)
    ApplySpeed(value)
end)

playertab:CreateTextbox("WalkSpeed Value", "27", function(Value)
    WalkSpeedValue = Value
end)

playertab:CreateLabel("• JUMPPOWER •")

playertab:CreateToggle("Enable JumpPower", Config.JumpPowerToggleEnabled, function(value)
    ApplyJumpPower(value)
end)

playertab:CreateTextbox("JumpPower Value", "50", function(Value)
    JumpPowerValue = Value
end)

--==============================================================
-- JERK OFF ANIMATION SUITE (BYPASS PIPELINE)
--==============================================================
Config.JerkOffActive = false
Config.JerkOffSpeed = 1

_G.JerkOffLoopThread = _G.JerkOffLoopThread or nil
if _G.JerkOffLoopThread then
    task.cancel(_G.JerkOffLoopThread)
    _G.JerkOffLoopThread = nil
end

_G.JerkOffLoopThread = task.spawn(function()
    while true do
        task.wait(0)
        if Config.JerkOffActive then
            pcall(function()
                char = game.Players.LocalPlayer.Character
                hrp = char and char:FindFirstChild("HumanoidRootPart")
                hum = char and char:FindFirstChildOfClass("Humanoid")
                
                if hrp and hum and hum.Health > 0 then
                    calculatedOffset = math.sin(os.clock() * (tonumber(Config.JerkOffSpeed) or 1) * 15) * 1.2
                    
                    -- จำลองแรงสะบัดฟิสิกส์แฝงแกนตรง CFrame หน้า-หลัง ปลอดภัยไร้ปลิวหลุดแมพ
                    hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, calculatedOffset)
                end
            end)
        else
            task.wait(0.2)
        end
    end
end)

playertab:CreateLabel("• Helper Clash •")

playertab:CreateToggle("Jerk Off", Config.JerkOffActive, function(value)
    Config.JerkOffActive = value
end)

playertab:CreateSlider("Jerk Off Speed Multiplier", 1, 100, Config.JerkOffSpeed, function(value)
    Config.JerkOffSpeed = value
end)

--
-- boost tab
--

pcall(function()
    Config.NoRenderEnabled = false
    Config.LowGraphicsEnabled = false
end)

boosttab:CreateLabel("• PERFORMANCE ADVANCED SUITE •")

boosttab:CreateToggle("No Render Environment", Config.NoRenderEnabled, function(state)
    Config.NoRenderEnabled = state
    if NoRenderConnection then
        NoRenderConnection:Disconnect()
        NoRenderConnection = nil
    end
    if state then
        pcall(function()
            if NoRenderCache == nil then NoRenderCache = {} end
            for _, obj in pairs(workspace:GetDescendants()) do
                ClearFallenRenderElement(obj)
            end
        end)
        NoRenderConnection = workspace.DescendantAdded:Connect(function(newObj)
            if Config.NoRenderEnabled then
                task.defer(function()
                    ClearFallenRenderElement(newObj)
                end)
            end
        end)
    else
        RestoreFallenRenderElements()
    end
end)

boosttab:CreateToggle("Low Graphics Mode", Config.LowGraphicsEnabled, function(state)
    Config.LowGraphicsEnabled = state
    if state then
        pcall(function()
            OriginalShadowSetting = game:GetService("Lighting").GlobalShadows
            game:GetService("Lighting").GlobalShadows = false
            for _, obj in pairs(workspace:GetDescendants()) do
                OptimizeFallenObject(obj)
            end
        end)
    else
        DisableFallenLowGraphics()
    end
end)

boosttab:CreateButton("Apply Instant FPS Boost", function()
    pcall(function()
        if setfflag then
            setfflag("S2PhysicsSenderRate", "240")
        end
        if setfpscap then
            setfpscap(360)
        end
    end)
end)

--
-- immortal tab
--

Config.ImmortalGodMode = false
Config.virexImmortalGodMode = false
Config.CharOrbitEnabled = false
Config.ImmortalModeType = "Auto"
Config.ImmortalCustomAngle = 145
Config.ImmortalCustomRadius = 10
Config.ImmortalHeightMin = -8
Config.ImmortalHeightMax = 35
Config.CharOrbitDistance = 12
Config.CharOrbitSpeed = 5
Config.CharOrbitAxis = "Y"

_G.CharOrbitAngle = 0
_G.OriginalWalkSpeed = _G.OriginalWalkSpeed or 16
_G.OriginalJumpPower = _G.OriginalJumpPower or 50

ImmortalStateCache = {}
ImmortalCamAnchor = workspace:FindFirstChild("Invis_UniversalCamAnchor") or Instance.new("Part")

if not ImmortalCamAnchor.Parent then
    ImmortalCamAnchor.Size = Vector3.new(1, 1, 1)
    ImmortalCamAnchor.Transparency = 1 
    ImmortalCamAnchor.CanCollide = false 
    ImmortalCamAnchor.Anchored = true
    ImmortalCamAnchor.Name = "Invis_UniversalCamAnchor"
    ImmortalCamAnchor.Parent = workspace
end

if shared.InvisGodModeBind then 
    shared.InvisGodModeBind:Disconnect() 
    shared.InvisGodModeBind = nil
end

shared.InvisGodModeBind = game:GetService("RunService").Heartbeat:Connect(function()
    if not shared._InvisRunning then return end
    
    char = game:GetService("Players").LocalPlayer.Character
    hrp = char and char:FindFirstChild("HumanoidRootPart")
    hum = char and char:FindFirstChildOfClass("Humanoid")
    cam = workspace.CurrentCamera
    
    if not hrp or not hum or hum.Health <= 0 or not cam then return end
    
    if not Config.virexImmortalGodMode and not Config.ImmortalGodMode then
        if cam.CameraSubject == ImmortalCamAnchor then 
            cam.CameraSubject = hum 
        end
        return 
    end
    
    ImmortalCamAnchor.CFrame = ImmortalCamAnchor.CFrame:Lerp(CFrame.new(hrp.Position), 0.3)
    if cam.CameraSubject ~= ImmortalCamAnchor then 
        cam.CameraSubject = ImmortalCamAnchor 
    end

    currentBallSpeed = 0
    ball = (type(Auto_Parry) == "table" and type(Auto_Parry.Get_Ball) == "function") and Auto_Parry.Get_Ball()
    
    if ball and ball.Parent then
        velocity = Vector3.zero
        zoomies = ball:FindFirstChild("zoomies")
        if zoomies then pcall(function() velocity = zoomies.VectorVelocity end) end
        if velocity == Vector3.zero and ball:IsA("BasePart") then velocity = ball.AssemblyLinearVelocity end
        currentBallSpeed = velocity.Magnitude
    end

    pcall(function() setfflag("S2PhysicsSenderRate", "15") end)

    if Config.virexImmortalGodMode then
        curTime = tick()
        spikeStep = math.floor(curTime * 95) % 3
        radius = 14
        
        lookVec = hrp.CFrame.LookVector
        rightVec = hrp.CFrame.RightVector
        
        triangleOffset = Vector3.zero
        velocityVector = Vector3.zero
        
        if spikeStep == 0 then
            triangleOffset = (-rightVec * radius) + (lookVec * (radius * 0.5))
            velocityVector = -rightVec * 350
        elseif spikeStep == 1 then
            triangleOffset = (rightVec * radius) + (lookVec * (radius * 0.5))
            velocityVector = rightVec * 350
        else
            triangleOffset = -lookVec * radius
            velocityVector = -lookVec * 350
        end
        
        oldCF = hrp.CFrame
        oldVel = hrp.AssemblyLinearVelocity
        
        hrp.CFrame = oldCF * CFrame.new(triangleOffset)
        hrp.AssemblyLinearVelocity = velocityVector
        
        game:GetService("RunService").RenderStepped:Wait()
        
        if hrp and hrp.Parent then
            hrp.CFrame = oldCF
            hrp.AssemblyLinearVelocity = oldVel
        end
        
    elseif Config.ImmortalGodMode then
        calculatedAngle = tonumber(Config.ImmortalCustomAngle) or 145
        if Config.ImmortalModeType == "Auto" then
            calculatedAngle = 145 + (currentBallSpeed * 2)
        end

        curTime = tick()
        calcAngle = curTime * math.pi * 2 * calculatedAngle / 5
        calcY = (math.floor(curTime * 135) % 2 == 0) and (tonumber(Config.ImmortalHeightMin) or -8) or (tonumber(Config.ImmortalHeightMax) or 35)
        
        offsetRadius = tonumber(Config.ImmortalCustomRadius) or 10
        offsetVector = Vector3.new(math.cos(calcAngle) * offsetRadius, calcY, math.sin(calcAngle) * offsetRadius)
        
        oldCF = hrp.CFrame
        oldVel = hrp.AssemblyLinearVelocity
        
        hrp.CFrame = oldCF + offsetVector
        hrp.AssemblyLinearVelocity = Vector3.new(math.sin(calcAngle) * 250, (calcY == (tonumber(Config.ImmortalHeightMax) or 35)) and 280 or -280, math.cos(calcAngle) * 250)
        
        game:GetService("RunService").RenderStepped:Wait()
        
        if hrp and hrp.Parent then
            hrp.CFrame = oldCF
            hrp.AssemblyLinearVelocity = oldVel
        end
    end
end)

if shared.OrbitImmortalHeartbeat then
    shared.OrbitImmortalHeartbeat:Disconnect()
    shared.OrbitImmortalHeartbeat = nil
end

shared.OrbitImmortalHeartbeat = game:GetService("RunService").Heartbeat:Connect(function()
    if not shared._InvisRunning or not Config.CharOrbitEnabled then return end
    
    pcall(function()
        char = game.Players.LocalPlayer.Character
        hrp = char and char:FindFirstChild("HumanoidRootPart")
        hum = char and char:FindFirstChildOfClass("Humanoid")
        
        if not hrp or not hum or hum.Health <= 0 then return end
        
        ball = type(Auto_Parry) == "table" and type(Auto_Parry.Get_Ball) == "function" and Auto_Parry.Get_Ball()
        if not ball or not ball.Parent then return end
        
        hrp.AssemblyLinearVelocity = Vector3.zero
        
        orbitSpeed = tonumber(Config.CharOrbitSpeed) or 5
        orbitDistance = tonumber(Config.CharOrbitDistance) or 12
        
        _G.CharOrbitAngle = _G.CharOrbitAngle + (orbitSpeed * 0.02)
        cosValue = math.cos(_G.CharOrbitAngle) * orbitDistance
        sinValue = math.sin(_G.CharOrbitAngle) * orbitDistance
        
        targetOffset = Vector3.zero
        axisMode = string.upper(tostring(Config.CharOrbitAxis or "Y"))
        
        if axisMode == "X" then
            targetOffset = Vector3.new(0, cosValue, sinValue)
        elseif axisMode == "Z" then
            targetOffset = Vector3.new(cosValue, sinValue, 0)
        elseif axisMode == "XY" then
            targetOffset = Vector3.new(cosValue, cosValue, sinValue)
        else
            targetOffset = Vector3.new(cosValue, 0, sinValue)
        end
        
        hrp.CFrame = CFrame.lookAt(ball.Position + targetOffset, ball.Position)
    end)
end)

immortaltab:CreateLabel(" • IMMORTAL V1 • ")

immortaltab:CreateToggle("Enable V1 Immortal", Config.virexImmortalGodMode, function(state)
    Config.virexImmortalGodMode = state
    if state then Config.ImmortalGodMode = false end
end)

immortaltab:CreateLabel("• IMMORTAL V2 •")

immortaltab:CreateToggle("Enable V2 Immortal", Config.ImmortalGodMode, function(state)
    Config.ImmortalGodMode = state
    if state then Config.virexImmortalGodMode = false end
end)

immortaltab:CreateSelect("Immortal Mode Type", {"Auto", "Custom"}, function(value)
    Config.ImmortalModeType = value
end)

immortaltab:CreateSlider("Custom Angle Degree", 10, 360, Config.ImmortalCustomAngle, function(value)
    Config.ImmortalCustomAngle = value
end)

immortaltab:CreateSlider("Desync Radius Distance", 2, 50, Config.ImmortalCustomRadius, function(value)
    Config.ImmortalCustomRadius = value
end)

immortaltab:CreateTextbox("Min Height Position (Default: -8)", "-8", function(text)
    numCheck = tonumber(text)
    if numCheck then Config.ImmortalHeightMin = numCheck else print("Error: Height min value must be a number") end
end)

immortaltab:CreateTextbox("Max Height Position (Default: 35)", "35", function(text)
    numCheck = tonumber(text)
    if numCheck then Config.ImmortalHeightMax = numCheck else print("Error: Height max value must be a number") end
end)

immortaltab:CreateLabel("• ORBIT •")

immortaltab:CreateToggle("Enable Orbit Ball", Config.CharOrbitEnabled, function(state)
    Config.CharOrbitEnabled = state
end)

immortaltab:CreateSlider("Orbit Distance", 2, 50, Config.CharOrbitDistance, function(value)
    Config.CharOrbitDistance = value
end)

immortaltab:CreateSlider("Orbit Speed", -25, 25, Config.CharOrbitSpeed, function(value)
    Config.CharOrbitSpeed = value
end)

immortaltab:CreateSelect("Orbit Axis Mode", {"Y", "X", "Z", "XY"}, function(value)
    Config.CharOrbitAxis = value
end)

--
-- ball tab
--

balltab:CreateLabel("• LIGHTWEIGHT VISUAL SYSTEM •")

balltab:CreateToggle("Low-Resource Rainbow Ball", Config.OptimizedRainbowBall, function(state)
    Config.OptimizedRainbowBall = state
    if not state then
        pcall(function()
            activeBalls = type(Auto_Parry) == "table" and type(Auto_Parry.Get_Balls) == "function" and Auto_Parry.Get_Balls() or {}
            for i = 1, #activeBalls do
                if activeBalls[i] then
                    activeBalls[i].Material = Enum.Material.SmoothPlastic
                end
            end
        end)
    end
end)

balltab:CreateToggle("Low-Resource Ball Trail", Config.OptimizedBallTrail, function(state)
    Config.OptimizedBallTrail = state
end)

balltab:CreateSlider("Rainbow Transition Speed", 1, 50, math.floor(Config.OptimizedRainbowSpeed * 1000), function(value)
    Config.OptimizedRainbowSpeed = value / 1000
end)

balltab:CreateButton("Clear All Visual Overhead", function()
    pcall(function()
        activeBalls = type(Auto_Parry) == "table" and type(Auto_Parry.Get_Balls) == "function" and Auto_Parry.Get_Balls() or {}
        for i = 1, #activeBalls do
            if activeBalls[i] then
                activeBalls[i].Material = Enum.Material.SmoothPlastic
                legacyTrail = activeBalls[i]:FindFirstChild("Invis_LowResourceTrail")
                if legacyTrail then 
                    legacyTrail:Destroy() 
                end
            end
        end
    end)
end)

--
-- music tab
--

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
    {Name = "$Undown", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/$%F0%9D%99%AA%F0%9D%99%A3%F0%9D%99%99%F0%9D%99%A4%F0%9D%99%AC%F0%9D%99%A3%20-%20%F0%9D%99%A8%F0%9D%99%A9%F0%9D%99%A7%F0%9D%99%96%F0%9D%99%AE.%F0%9D%99%AC%F0%9D%99%96%F0%9D%99%AB%20%5B%20%F0%9D%99%A8%F0%9D%99%A1%F0%9D%99%A4%F0%9D%99%AC%F0%9D%99%9A%F0%9D%99%99%20%20%F0%9D%99%A7%F0%9D%99%9A%F0%9D%99%AB%F0%9D%99%9A%F0%9D%99%A7%F0%9D%99%97%20%5D.mp3"},
    {Name = "TrackMaker", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/%E5%AE%A4%E5%86%85%E7%B3%BB%E7%9A%84TrackMaker%20(Melodic%20Minor%E7%89%88).mp3"},
    {Name = "ReMake", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/%E6%B3%95%E4%BF%AE%E6%95%A3%E6%89%93%20(%E9%A1%B6%E7%BA%A7%E6%97%8B%E5%BE%8B).mp3"},
    {Name = "Anar", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/Anar%20-%20Bero%2000%20(slowed).mp3"},
    {Name = "Monody", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/TheFatRat%20-%20Monody%20(feat.%20Laura%20Brehm).mp3"},
    {Name = "Nevada", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/Nevada%20slowed%20-%20reverb.mp3"},
    {Name = "PowerMix", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/%E3%80%90%E4%BE%9D%E6%97%A7%E7%A1%AC%E6%9B%B2%E3%80%91%E2%80%9C%E6%81%90%E6%83%A7%E6%98%AF%E7%94%9F%E7%89%A9%E7%9A%84%E6%9C%AC%E8%83%BD%E5%8B%87%E6%B0%94%E6%98%AF%E4%BA%BA%E7%B1%BB%E7%9A%84%E8%B5%9E%E6%AD%8C%E2%80%9D.mp3"},
    {Name = "SadMix", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/T%E1%BB%95ng%20nh%E1%BA%A1c%20hay%20%23%E7%BF%BB%E5%94%B1%20%23%E9%9F%B3%E4%B9%90%20%23ytb%23%E6%8A%96%E9%9F%B3.mp3"},
    {Name = "FunkMix", URL = "https://github.com/foreverspacexc-blip/INVISRobloxMusic/raw/refs/heads/main/Most%20Viral%20Phonk%20Funk%202026%20%F0%9F%8E%B5.mp3"},
    -- {Name = "", URL = ""},
}

CurrentTrackIndex = 1
SelectedTrackName = CustomPlaylists[1].Name
IsPlaying = false
IsAutoPlayNext = false
IsLoopSingle = false

pcall(function()
    CurrentSoundObj = game:GetService("SoundService"):FindFirstChild("InvisHubMusicPlayer")
    if not CurrentSoundObj then
        CurrentSoundObj = Instance.new("Sound")
        CurrentSoundObj.Name = "InvisHubMusicPlayer"
        CurrentSoundObj.Volume = 2
        CurrentSoundObj.Parent = game:GetService("SoundService")
    end
end)

function PlayMusic(index)
    xpcall(function()
        if not CustomPlaylists[index] then return end
        CurrentTrackIndex = index
        SelectedTrackName = CustomPlaylists[index].Name
        if MusicSelectObject and type(MusicSelectObject.Set) == "function" then
            MusicSelectObject:Set(SelectedTrackName)
        end

        local targetUrl = CustomPlaylists[index].URL
        local fileName = "InvisSong_" .. tostring(index) .. ".mp3"

        if writefile and getcustomasset then
            if not isfile(fileName) then
                local successDownload, musicData = pcall(function()
                    return game:HttpGet(targetUrl)
                end)
                if successDownload and musicData then
                    writefile(fileName, musicData)
                else
                    print("Error: Failed to download track " .. tostring(index) .. " from source")
                    return
                end
            end
            
            CurrentSoundObj.SoundId = getcustomasset(fileName)
            CurrentSoundObj:Play()
            IsPlaying = true
            if MusicStatusLabel then
                MusicStatusLabel.Text = "Now Playing: " .. CustomPlaylists[index].Name
            end
        else
            print("Error: Executor does not support writefile or getcustomasset for local file audio playback")
        end
    end, function(err)
        print("Music local cache and play system failed: " .. tostring(err))
    end)
end

pcall(function()
    if MusicConnection then MusicConnection:Disconnect() end
    MusicConnection = CurrentSoundObj.Ended:Connect(function()
        xpcall(function()
            if IsLoopSingle then
                PlayMusic(CurrentTrackIndex)
            elseif IsAutoPlayNext then
                NextIndex = CurrentTrackIndex + 1
                if NextIndex > #CustomPlaylists then NextIndex = 1 end
                PlayMusic(NextIndex)
            else
                IsPlaying = false
                if MusicStatusLabel then
                    MusicStatusLabel.Text = "Status: Stopped"
                end
            end
        end, function(err)
            print("Track end handling failed: " .. tostring(err))
        end)
    end)
end)

PlaylistNamesList = {}
for index, track in ipairs(CustomPlaylists) do
    table.insert(PlaylistNamesList, track.Name)
end

musictab = Library:CreateTab("music")

musictab:CreateLabel("• system •")

MusicStatusLabel = musictab:CreateLabel("Status: Stopped")

MusicSelectObject = musictab:CreateSelect("Select Music", PlaylistNamesList, function(value)
    SelectedTrackName = value
end)

musictab:CreateButton("Play This Music", function()
    xpcall(function()
        TargetIndex = 1
        for index, track in ipairs(CustomPlaylists) do
            if track.Name == SelectedTrackName then
                TargetIndex = index
                break
            end
        end
        PlayMusic(TargetIndex)
    end, function(err)
        print("Play this music action failed: " .. tostring(err))
    end)
end)

musictab:CreateButton("Play / Pause", function()
    xpcall(function()
        if IsPlaying then
            CurrentSoundObj:Pause()
            IsPlaying = false
            MusicStatusLabel.Text = "Status: Paused"
        else
            if CurrentSoundObj.SoundId == "" or CurrentSoundObj.SoundId ~= CustomPlaylists[CurrentTrackIndex].URL then
                PlayMusic(CurrentTrackIndex)
            else
                CurrentSoundObj:Resume()
                IsPlaying = true
                MusicStatusLabel.Text = "Now Playing: " .. CustomPlaylists[CurrentTrackIndex].Name
            end
        end
    end, function(err)
        print("Play Pause toggle failed: " .. tostring(err))
    end)
end)

musictab:CreateToggle("Auto play next music", IsAutoPlayNext, function(value)
    IsAutoPlayNext = value
end)

musictab:CreateToggle("Loop single music", IsLoopSingle, function(value)
    IsLoopSingle = value
end)

musictab:CreateButton("Forward 10s", function()
    xpcall(function()
        CurrentSoundObj.TimePosition = math.clamp(CurrentSoundObj.TimePosition + 10, 0, CurrentSoundObj.TimeLength)
    end, function(err)
        print("Forward execution failed: " .. tostring(err))
    end)
end)

musictab:CreateButton("Rewind 10s", function()
    xpcall(function()
        CurrentSoundObj.TimePosition = math.clamp(CurrentSoundObj.TimePosition - 10, 0, CurrentSoundObj.TimeLength)
    end, function(err)
        print("Rewind execution failed: " .. tostring(err))
    end)
end)

musictab:CreateButton("Play Next Track", function()
    xpcall(function()
        NextIndex = CurrentTrackIndex + 1
        if NextIndex > #CustomPlaylists then NextIndex = 1 end
        PlayMusic(NextIndex)
    end, function(err)
        print("Skip next track failed: " .. tostring(err))
    end)
end)

--==============================================================
-- NOTICE BYPASS
--==============================================================

         Library:CreateNotice({
              Title = "READ ME (if not xeno or solar)",
              Text = "Parry until u get notice(use you hand) to bypass work",
              Type = "OK"
          })
          
         Library:CreateNotice({
              Title = "Guide",
              Text = "Use God Curve in anti curve mode for BEST AP",
              Type = "OK"
          })
         
          
shared._InvisRunning = true

if shared._InvisRemoteNoticeThread then task.cancel(shared._InvisRemoteNoticeThread) end

shared._InvisRemoteNoticeThread = task.spawn(function()
    hasNotifiedBypass = false
    while true do
        task.wait(0.5)
        if _reverted and next(_reverted) ~= nil then
            for _remote, _originalArgs in pairs(_reverted) do
                if type(_originalArgs) == "table" and _originalArgs[1] ~= nil then
                    if not hasNotifiedBypass then
                        hasNotifiedBypass = true
                        xpcall(function()
                            if type(Library) == "table" and type(Library.CreateNotice) == "function" then
                                Library:CreateNotice({
                                    Title = "System Notification",
                                    Text = "Network Remote Connected & Token Injected! Auto Parry is now using Remote Method.",
                                    Type = "OK"
                                })
                            else
                                print("Invis Network: Network Remote Connected & Token Injected!")
                            end
                        end, function(errorMessage)
                            print("Notification rendering failure: " .. tostring(errorMessage))
                        end)
                        break
                    end
                end
            end
        end
        if hasNotifiedBypass then break end
        if not shared._InvisRunning then break end
    end
end)

pcall(function()
    cameraViewport = workspace.CurrentCamera
    targetScreenGui = CoreGui:FindFirstChild("ModernGrayLibrary") or CoreGui:FindFirstChild("ModernGrayLibrary") or game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local function applyDeviceScale(buttonFrame)
        if buttonFrame and buttonFrame:IsA("GuiObject") then
            deviceScale = buttonFrame:FindFirstChild("Invis_DeviceScale") or Instance.new("UIScale")
            deviceScale.Name = "Invis_DeviceScale"
            deviceScale.Scale = cameraViewport and (cameraViewport.ViewportSize.X / 1400) or 1
            deviceScale.Parent = buttonFrame
        end
    end

    local function updateAllScales()
        if not cameraViewport then return end
        currentScaleFactor = cameraViewport.ViewportSize.X / 1400
        
        for _, btnName in ipairs({"Invis_ManualSpamFloatingBtn", "Invis_InfiniteSpamFloatingBtn", "Void_ManualSpamFloatingBtn"}) do
            foundBtn = targetScreenGui:FindFirstChild(btnName, true)
            if foundBtn then
                applyDeviceScale(foundBtn)
                scaleObj = foundBtn:FindFirstChild("Invis_DeviceScale")
                if scaleObj then
                    scaleObj.Scale = currentScaleFactor
                end
            end
        end
    end

    task.spawn(function()
        task.wait(1)
        updateAllScales()
    end)

    if cameraViewport then
        cameraViewport:GetPropertyChangedSignal("ViewportSize"):Connect(updateAllScales)
    end
end)

--==============================================================
-- RETURN LIBRARY
--==============================================================

return Library
