-- yes this was the actual source. It is fully vibecoded.

--== AUTO COPY LINK ON START ==
pcall(function()
    if setclipboard then 
        setclipboard("https://youtube.com/@invis_in") 
    elseif toclipboard then 
        toclipboard("https://youtube.com/@invis_in") 
    end
end)



local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
local LocalPlayer = Players.LocalPlayer

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

-- ═══ DEEP BAC BYPASS HOOKS (INVISIBLE SCRIPT BYPASS) ════════════════════════════
local hookfunction = hookfunction or (getgenv and getgenv().hookfunction)
if hookfunction and getrenv then
    pcall(function()
        local _BAC_oldDebugInfo
        _BAC_oldDebugInfo = hookfunction(getrenv().debug.info, function(f, t)
            if type(f) == "function" then return "[C]"
            -- ส่งสภาพแวดล้อมจำลองหลอกตัวแอนตี้ชีต BAC ไม่ให้เตะ
            elseif f == 4 and t == "s" then return "ReplicatedStorage.Controllers.SwordsController " end
            return _BAC_oldDebugInfo(f, t)
        end)

        local _BAC_oldGetfenv
        _BAC_oldGetfenv = hookfunction(getrenv().getfenv, function(l)
            if l ~= nil and type(l) == "number" and l >= 1 and l <= 10 then return _BAC_oldGetfenv(10) end
            return _BAC_oldGetfenv(l)
        end)
    end)
end

-- ═══ CONFIGURATION & GLOBAL STATE ══════════════════════════════════════
local Config = {
    AutoParry = false,
    ParryMode = "Curve", 
    TargetTime = 0.3,       
    DistanceTiming = 100, 
    ParryCurveMode = "Front", 
    HitSpeedMode = "Fast ball", 
    TargetMode = "Nearest", 
    AutoSpam = false,
    ManualSpam = false,
    ManualSpamSpeed = 0.015,
    SuperSpam = false,
    SuperSpamClicks = 1,
    AutoAbility = false, 
    
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
    FlyEnabled = false,
    DesyncEnabled = false,
    DesyncMode = "1: Infinite Sky",
    ParryDirection = "Straight",
    AntiAfk = false,
    
    LookAtBallChar = false,
    LookAtBallCam = false,
    
    PlayerESP = false,  
}

local Auto_Parry = {}
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

-- ═══ EMERGENCY DISTANCE CALCULATOR (OPTIMIZED FORMULA) ═════════════════
local function GetEmergencyDistance(speed)
    local calculated = 8 + (speed * 0.09)
    return math.clamp(calculated, 10, 75)
end

-- ═══ UPVALUE EVENT RESOLVER (INVISIBLE SCRIPT) ═════════════════════════
ZX_Parry = { Remote = nil, Function = nil, KeyTable = nil, TransformFn = nil, NetModule = nil, RemoteId = nil, ParryHash = nil, Hooked = false }
task.spawn(function()
    pcall(function()
        local getupvals = debug.getupvalues or getupvalues
        local SC = ReplicatedStorage:WaitForChild("Controllers", 10):FindFirstChild("SwordsController \12")
        local PRY = SC and SC:WaitForChild("PRY", 10)
        if not PRY then return end
        ZX_Parry.Function = require(PRY)
        local ups = getupvals(ZX_Parry.Function)
        ZX_Parry.KeyTable = ups[3]
        ZX_Parry.TransformFn = ups[4]
        ZX_Parry.NetModule = ups[6]
        ZX_Parry.RemoteId = ups[7]
        ZX_Parry.ParryHash = ups[8]
        if ZX_Parry.KeyTable and ZX_Parry.TransformFn and ZX_Parry.NetModule and ZX_Parry.RemoteId then
            ZX_Parry.Remote = ZX_Parry.NetModule:RemoteEvent(ZX_Parry.RemoteId)
            ZX_Parry.Hooked = true
        end
    end)
end)


local cachedToken = nil
local lastTokenTick = 0
local function generateToken(currentKey)
    if not currentKey or not ZX_Parry.TransformFn then return nil end
    if tick() - lastTokenTick < 0.01 and cachedToken then return cachedToken end
    local tok, transformed = pcall(ZX_Parry.TransformFn, currentKey, "TIME")
    if not tok or not transformed then return nil end
    local serverTime = workspace:GetServerTimeNow() * 100
    local timeStr = tostring(math.floor(serverTime))
    local tokenChars = {}
    for i = 1, #timeStr do
        local ki = (i - 1) % #transformed + 1
        local xb = bit32.bxor((string.byte(timeStr, i) + i) % 256, string.byte(transformed, ki))
        tokenChars[i] = string.char(xb)
    end
    cachedToken = table.concat(tokenChars)
    lastTokenTick = tick()
    return cachedToken
end

shared.InvisGenerateToken = generateToken

function Auto_Parry.Get_Balls()
    local balls = {}
    local ballsFolder = Workspace:FindFirstChild("Balls") or Workspace:FindFirstChild("TrainingBalls")
    if ballsFolder then
        for _, ball in ipairs(ballsFolder:GetChildren()) do
            if ball:IsA("BasePart") or ball:IsA("Model") then
                table.insert(balls, ball)
            end
        end
    end
    return balls
end

function Auto_Parry.Get_Ball()
    local bc = workspace:FindFirstChild("Balls") or workspace:FindFirstChild("TrainingBalls")
    if bc then
        for _, b in pairs(bc:GetChildren()) do
            if b:IsA("BasePart") and (b:GetAttribute("realBall") or b:GetAttribute("target")) then return b end
        end
    end
    return nil
end

function Auto_Parry.GetTargetPlayer()
    local alive = workspace:FindFirstChild("Alive")
    local myChar = LocalPlayer.Character
    if not alive or not myChar then return nil end
    
    local myRoot = myChar.PrimaryPart or myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    
    local targetMode = Config.TargetMode
    local myPos = myRoot.Position
    
    if targetMode == "Double click" then
        if shared.Clicked_Target_Name then
            local targetModel = alive:FindFirstChild(shared.Clicked_Target_Name)
            if targetModel and targetModel:FindFirstChild("HumanoidRootPart") then
                return targetModel
            end
        end
        return nil
    elseif targetMode == "Normal" then
        for _, p in ipairs(alive:GetChildren()) do
            if p ~= myChar and p:IsA("Model") and p:FindFirstChild("HumanoidRootPart") then 
                return p 
            end
        end
    elseif targetMode == "Nearest" then
        local minDist, chosen = math.huge, nil
        for _, p in ipairs(alive:GetChildren()) do
            local hrp = p:FindFirstChild("HumanoidRootPart")
            if p ~= myChar and p:IsA("Model") and hrp then
                local d = (hrp.Position - myPos).Magnitude
                if d < minDist then 
                    minDist = d 
                    chosen = p 
                end
            end
        end
        return chosen
    elseif targetMode == "Farest" or targetMode == "Farthest" then
        local maxDist, chosen = -1, nil
        for _, p in ipairs(alive:GetChildren()) do
            local hrp = p:FindFirstChild("HumanoidRootPart")
            if p ~= myChar and p:IsA("Model") and hrp then
                local d = (hrp.Position - myPos).Magnitude
                if d > maxDist then 
                    maxDist = d 
                    chosen = p 
                end
            end
        end
        return chosen
    end
    return nil
end

function Auto_Parry.Parry_Animation()
    if not Config.SwordAnimationsEnabled then return end
    pcall(function()
        local Parry_Animation = ReplicatedStorage.Shared.SwordAPI.Collection.Default:FindFirstChild("GrabParry")
        local Current_Sword = Player.Character:GetAttribute("CurrentlyEquippedSword")
        if not Current_Sword or not Parry_Animation then return end
        local Sword_Data = ReplicatedStorage.Shared.ReplicatedInstances.Swords.GetSword:Invoke(Current_Sword)
        if not Sword_Data or not Sword_Data["AnimationType"] then return end
        for _, object in pairs(ReplicatedStorage.Shared.SwordAPI.Collection:GetChildren()) do
            if object.Name == Sword_Data["AnimationType"] then
                local animType = object:FindFirstChild("GrabParry") and "GrabParry" or (object:FindFirstChild("Grab") and "Grab")
                if animType then Parry_Animation = object[animType] end
            end
        end
        local track = Player.Character.Humanoid.Animator:LoadAnimation(Parry_Animation)
        track:Play()
    end)
end

function Auto_Parry.CalculateParryCFrame(ball, targetPlayer)
    --========================================================
    -- SAFE CHARACTER
    --========================================================
    local player = LocalPlayer or Players.LocalPlayer
    local char = player and player.Character

    if not char then
        return CFrame.new()
    end

    local hrp = char:FindFirstChild("HumanoidRootPart")
        or char.PrimaryPart

    if not hrp then
        return CFrame.new()
    end

    --========================================================
    -- SAFE CONFIG
    --========================================================
    local cfg = (type(Config) == "table") and Config or {}

    -- FireParryRemote ใช้ ParryCurveMode เป็นตัวเลือกหลัก
    local mode = cfg.ParryDirection
        or cfg.ParryCurveMode
        or "Front"

    mode = tostring(mode)

    --========================================================
    -- SAFE CAMERA
    --========================================================
    local cam = workspace.CurrentCamera

    --========================================================
    -- SAFE TARGET
    -- targetPlayer ในสคริปต์นี้จริง ๆ คือ Model
    -- ที่อยู่ใน workspace.Alive
    --========================================================
    local targetRoot = nil

    if targetPlayer then

        -- กรณีส่ง Character Model มาโดยตรง
        if typeof(targetPlayer) == "Instance"
            and targetPlayer:IsA("Model") then

            targetRoot =
                targetPlayer:FindFirstChild("HumanoidRootPart")
                or targetPlayer.PrimaryPart

        -- กรณีเผื่อมีการส่ง Player มา
        elseif typeof(targetPlayer) == "Instance"
            and targetPlayer:IsA("Player") then

            local targetChar = targetPlayer.Character

            if targetChar then
                targetRoot =
                    targetChar:FindFirstChild("HumanoidRootPart")
                    or targetChar.PrimaryPart
            end
        end
    end

    --========================================================
    -- SAFE BALL
    --========================================================
    local ballPart = nil

    if ball and typeof(ball) == "Instance" then

        if ball:IsA("BasePart") then
            ballPart = ball

        elseif ball:IsA("Model") then
            ballPart =
                ball.PrimaryPart
                or ball:FindFirstChild("HumanoidRootPart")
                or ball:FindFirstChildWhichIsA("BasePart")
        end
    end

    --========================================================
    -- HELPER
    --========================================================
    local function makeDirection(direction)
        if typeof(direction) ~= "Vector3" then
            return hrp.CFrame
        end

        if direction.Magnitude < 0.001 then
            return hrp.CFrame
        end

        return CFrame.lookAt(
            hrp.Position,
            hrp.Position + direction.Unit
        )
    end

    --========================================================
    -- CHARACTER DIRECTIONS
    --========================================================
    local look = hrp.CFrame.LookVector
    local right = hrp.CFrame.RightVector

    --========================================================
    -- 1. FRONT
    --========================================================
    if mode == "Front"
        or mode == "Forward"
        or mode == "Normal" then

        return makeDirection(look)

    --========================================================
    -- 2. BACK
    --========================================================
    elseif mode == "Back"
        or mode == "Backward" then

        return makeDirection(-look)

    --========================================================
    -- 3. LEFT
    --========================================================
    elseif mode == "Left" then

        return makeDirection(-right)

    --========================================================
    -- 4. RIGHT
    --========================================================
    elseif mode == "Right" then

        return makeDirection(right)

    --========================================================
    -- 5. UP
    --========================================================
    elseif mode == "Up"
        or mode == "Sky" then

        return makeDirection(Vector3.new(0, 1, 0))

    --========================================================
    -- 6. CHARACTER
    --========================================================
    elseif mode == "Character" then

        return hrp.CFrame

    --========================================================
    -- 7. RANDOM LEFT / RIGHT
    --========================================================
    elseif mode == "LeftRightRandom" then

        local direction

        if math.random(1, 2) == 1 then
            direction = right
        else
            direction = -right
        end

        return makeDirection(direction)

    --========================================================
    -- 8. RANDOM FRONT / BACK
    --========================================================
    elseif mode == "BackStraightRandom" then

        local direction

        if math.random(1, 2) == 1 then
            direction = look
        else
            direction = -look
        end

        return makeDirection(direction)

    --========================================================
    -- 9. FASTBALL
    --========================================================
    elseif mode == "Fastball"
        or mode == "Fast Ball" then

        return makeDirection(look)

    --========================================================
    -- 10. SLOWBALL
    --========================================================
    elseif mode == "Slowball"
        or mode == "Slow Ball" then

        return makeDirection(look)

    --========================================================
    -- 11. CAMERA
    --========================================================
    elseif mode == "Camera"
        or mode == "CameraLook" then

        if cam then
            return makeDirection(cam.CFrame.LookVector)
        end

        return hrp.CFrame

    --========================================================
    -- 12. CAMERA SKY
    --========================================================
    elseif mode == "CameraSky" then

        if cam then
            local direction =
                cam.CFrame.LookVector
                + Vector3.new(0, 0.75, 0)

            return makeDirection(direction)
        end

        return makeDirection(look)

    --========================================================
    -- 13. CAMERA LEFT
    --========================================================
    elseif mode == "CameraLeft" then

        if cam then
            return makeDirection(-cam.CFrame.RightVector)
        end

        return makeDirection(-right)

    --========================================================
    -- 14. CAMERA RIGHT
    --========================================================
    elseif mode == "CameraRight" then

        if cam then
            return makeDirection(cam.CFrame.RightVector)
        end

        return makeDirection(right)

    --========================================================
    -- 15. AIM AT BALL
    --========================================================
    elseif mode == "Ball"
        or mode == "BallDirection" then

        if ballPart then
            local direction =
                ballPart.Position - hrp.Position

            if direction.Magnitude > 0.001 then
                return makeDirection(direction)
            end
        end

        return hrp.CFrame

    --========================================================
    -- 16. VELOCITY CURVE
    --========================================================
    elseif mode == "VelocityCurve" then

        if ballPart then

            local velocity =
                ballPart.AssemblyLinearVelocity

            if velocity.Magnitude > 1 then

                local velocityUnit =
                    velocity.Unit

                local side =
                    velocityUnit:Cross(Vector3.new(0, 1, 0))

                -- บอลวิ่งเกือบตรงขึ้น/ลง
                if side.Magnitude < 0.001 then
                    side = right
                else
                    side = side.Unit
                end

                local sideSign =
                    math.random(1, 2) == 1
                    and 1
                    or -1

                local finalDirection =
                    (look * 0.65)
                    + (side * sideSign * 0.75)

                return makeDirection(finalDirection)
            end
        end

        return hrp.CFrame

    --========================================================
    -- 17. INVERSE
    --========================================================
    elseif mode == "Inverse" then

        if ballPart then

            local velocity =
                ballPart.AssemblyLinearVelocity

            if velocity.Magnitude > 1 then
                return makeDirection(-velocity.Unit)
            end
        end

        return makeDirection(-look)

    --========================================================
    -- 18. CURVE SWERVE
    --========================================================
    elseif mode == "CurveSwerve" then

        local direction =
            (look * 0.65)
            - (right * 0.75)
            + Vector3.new(0, 0.25, 0)

        return makeDirection(direction)
    end

    --========================================================
    -- DEFAULT TARGET
    --========================================================

    if targetRoot and targetRoot.Parent then

        local targetDirection =
            targetRoot.Position - hrp.Position

        if targetDirection.Magnitude > 0.001 then
            return makeDirection(targetDirection)
        end
    end

    --========================================================
    -- FINAL FALLBACK
    --========================================================
    return hrp.CFrame
end

Auto_Parry.CalculateParryCframe = Auto_Parry.CalculateParryCFrame

-- ═══ 🚀 ULTIMATE RE-SYNCHRONIZED FIRE PARRY REMOTE (FIXED BAC DETECT) ═════════════════
function Auto_Parry.FireParryRemote(ignoreCooldown)
    local curTime = tick()
    if not ignoreCooldown and (curTime - lastParryTime < parryCooldown) then return end
    if ignoreCooldown and (curTime - lastParryTime < 0.003) then return end
    
    if not ZX_Parry.Hooked or not ZX_Parry.Remote then return end
    
    local currentKey = nil
    pcall(function()
        if type(ZX_Parry.KeyTable) == "table" then
            local keyIndex = ZX_Parry.KeyTable[3]
            currentKey = keyIndex and ZX_Parry.KeyTable[1][keyIndex]
        else
            currentKey = ZX_Parry.KeyTable
        end
    end)
    if not currentKey then return end
    
    local token = generateToken and generateToken(currentKey) or (shared.InvisGenerateToken and shared.InvisGenerateToken(currentKey))
    if not token or token == "" then return end

    lastParryTime = curTime
    lastHitTick = curTime
    
    -- 🔄 เพิ่ม 4 บรรทัดนี้เข้าไปแทนที่ เพื่อดึงค่าจากหน้าจอเมนู (UI) และส่งข้อมูลลูกบอล/คู่แข่งเข้าไปคำนวณจริง
    Config.ParryDirection = Config.ParryCurveMode 
    local activeBall = Auto_Parry.Get_Ball()
    local activeTargetPlr = Auto_Parry.GetTargetPlayer()
    local pCF = Auto_Parry.CalculateParryCFrame(activeBall, activeTargetPlr) 
    
    local alive = workspace:FindFirstChild("Alive")
    local cam = workspace.CurrentCamera
    if not cam then
        return
    end
    
    -- อัปเดตพิกัด Cache ให้เสถียรและปลอดภัยยิ่งขึ้น
    if tick() - Cache_Update_Tick > 0.1 then
        table.clear(Last_Positions_Cache)
        if alive and cam then
            for _, character in ipairs(alive:GetChildren()) do
                -- ใช้ HumanoidRootPart ป้องกันกรณี PrimaryPart เป็น nil
                local primary = character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart
                if primary and primary.Parent then 
                    Last_Positions_Cache[character.Name] = cam:WorldToScreenPoint(primary.Position)
                end
            end
        end
        Cache_Update_Tick = tick()
    end

    if Config.SwordAnimationsEnabled and (tick() - Last_Parry > 0.4) then 
        Auto_Parry.Parry_Animation() 
    end
    Last_Parry = tick()
    
    -- ✅ FIX 2: กำหนดตำแหน่งเมาส์ตรงกลางหน้าจอแบบคงที่ เพื่อให้ Signature Payload สมบูรณ์
    local exactMousePos = {
        cam.ViewportSize.X / 2, 
        cam.ViewportSize.Y / 2
    }
    
    -- ส่งข้อมูล Remote ไปยังเซิร์ฟเวอร์
    pcall(function() 
        ZX_Parry.Remote:FireServer(
            ZX_Parry.ParryHash, 
            currentKey, 
            token, 
            0.5, 
            pCF, 
            Last_Positions_Cache, 
            exactMousePos, 
            false
        ) 
    end)
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

-- ============================================================
-- SMART AUTO ABILITY v3 — Per-ability unique cooldowns
-- ============================================================
local AbilityRemote = nil
local AbilityRawFunc = nil
local abilityHooked = false

local AutoAbilityData = {
    Enabled = false,
    LastAbilityName = nil,
}
getgenv().ZX_AutoAbility = AutoAbilityData

-- กำหนดเวลา Cooldown และจังหวะการกดแยกตามแต่ละสกิล
local ABILITY_TIMINGS = {
    ["Raging Deflection"] = { cooldown = 15, fireAt = 0.5, trigger = "target" },
    ["Calming Deflection"] = { cooldown = 15, fireAt = 1.2, trigger = "target" },
    ["Rapture"]            = { cooldown = 20, fireAt = 2.0, trigger = "proximity" },
    ["Aerodynamic Slash"]  = { cooldown = 12, fireAt = 0.8, trigger = "target" },
    ["Fracture"]           = { cooldown = 18, fireAt = 1.5, trigger = "proximity" },
    ["Death Slash"]        = { cooldown = 25, fireAt = 3.0, trigger = "clash" },
}
getgenv().ZX_AbilityTimings = ABILITY_TIMINGS

local _abilityLastFire = {}

-- Hook Remote สำหรับกดใช้ Ability อัตโนมัติ
task.spawn(function()
    task.wait(2)
    pcall(function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local abilRemote = ReplicatedStorage:WaitForChild("Remotes", 5):FindFirstChild("AbilityButtonPress")
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
            game:GetService("ReplicatedStorage").Remotes.AbilityButtonPress:Fire()
        end)
        return true
    end
    pcall(function()
        AbilityRawFunc(AbilityRemote)
    end)
    return true
end

local function isAbilityReady()
    if not AbilityCD then return true end
    local offset = AbilityCD.Offset.Y
    return offset >= 0.45 and offset <= 0.55
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

local function smartAutoAbility()
    if not AutoAbilityData.Enabled then return false end
    if not isAbilityReady() then return false end

    local abilityName = getEquippedAbility()
    if not abilityName then return false end

    local timing = ABILITY_TIMINGS[abilityName]
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

    local target = ball:GetAttribute("target")
    local isTargeting = (target == tostring(game:GetService("Players").LocalPlayer))

    local char = game:GetService("Players").LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local ballDist = 999
    if hrp and ball.Parent then
        ballDist = (ball.Position - hrp.Position).Magnitude
    end

    local shouldFire = false
    if timing.trigger == "target" then
        if isTargeting then
            if (tick() - _lastBallTargetTime) >= timing.fireAt then
                shouldFire = true
            end
        end
    elseif timing.trigger == "proximity" then
        if isTargeting and ballDist <= 40 then
            if (tick() - _lastBallTargetTime) >= timing.fireAt then
                shouldFire = true
            end
        end
    elseif timing.trigger == "clash" then
        if (tick() - _lastClashTime) <= 2 and (tick() - _lastClashTime) >= timing.fireAt then
            shouldFire = true
        end
    end

    if not shouldFire then return false end

    -- ทำงานแบบ Asynchronous เพื่อไม่ให้ขัดขวางจังหวะ Parry
    task.spawn(function()
        local fired = fireAbilityRemote()
        if fired then
            AutoAbilityData.LastAbilityName = abilityName
            _abilityLastFire[abilityName] = tick()
        end
    end)
    return false  
end
getgenv().ZX_SmartAutoAbility = smartAutoAbility

task.spawn(function()
    while true do
        task.wait(0.05)
        local ball = Auto_Parry.Get_Ball()
        if ball then
            local target = ball:GetAttribute("target")
            if target == tostring(game:GetService("Players").LocalPlayer) then
                _lastBallTargetTime = tick()
            end
        end
    end
end)

pcall(function()
    game:GetService("ReplicatedStorage").Remotes.ParrySuccessAll.OnClientEvent:Connect(function(_, root)
        if root and root.Parent and root.Parent ~= game:GetService("Players").LocalPlayer.Character then
            _lastClashTime = tick()
        end
    end)
end)

task.spawn(function()
    while true do
        task.wait(0.05)
        if AutoAbilityData.Enabled then
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

    -- ตรวจสอบว่าถ้าคนที่ล็อกไว้ ไม่อยู่ใน Folder Alive แล้ว ค่อยปลดล็อกออก
    if shared.Clicked_Target_Name then
        local tar = alive:FindFirstChild(shared.Clicked_Target_Name)
        if tar and tar:FindFirstChild("HumanoidRootPart") then
            positionsCache[shared.Clicked_Target_Name] = cam:WorldToScreenPoint(tar.HumanoidRootPart.Position)
            shared.Current_Active_Target_Model = tar
            shared.IsTargetLocked = true
            return positionsCache
        else
            -- ปลดล็อกอัตโนมัติก็ต่อเมื่อหลุดจาก Alive (ตาย / ออกเกม)
            shared.Clicked_Target_Name = nil
        end
    end

    local targetPlayer = Auto_Parry.GetTargetPlayer()
    if targetPlayer and targetPlayer:FindFirstChild("HumanoidRootPart") then
        positionsCache[targetPlayer.Name] = cam:WorldToScreenPoint(targetPlayer.HumanoidRootPart.Position)
        shared.Current_Active_Target_Model = targetPlayer
        shared.IsTargetLocked = false
    else
        shared.Current_Active_Target_Model = nil
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
local function SafeGetEmergencyDistance(speed)
    local calculated = 8 + (speed * 0.09) + (pingSeconds * speed * 1.5)
    local infinityBuffer = math.clamp(calculated, 10, 75)
    if type(GetEmergencyDistance) == "function" then
        local success, result = pcall(GetEmergencyDistance, speed)
        if success and type(result) == "number" then
            return math.max(result, math.clamp(8 + (speed * 0.09), 10, 75))
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
if shared._BBAChaoticThread then task.cancel(shared._BBAChaoticThread) shared._BBAChaoticThread = nil end

local singularityEndTime = 0

-- 🚀 Background Spam Core
shared._BBAChaoticThread = task.spawn(function()
    while true do
        local cfg = (type(Config) == "table") and Config or {}
        local autoSpamEnabled = cfg.AutoSpam or cfg.AutoSpamClash or false
        if autoSpamEnabled and shared.ManualSpamActive then
            if type(Auto_Parry) == "table" and type(Auto_Parry.FireParryRemote) == "function" then
                pcall(Auto_Parry.FireParryRemote, true)
            end
            task.wait(0)
        else
            task.wait(0.04)
        end
    end
end)
-- ⚡ UPDATED CORE PHYSICS LOOP (DYNAMIC CURVE HANDLER & FIX DOUBLE LOCK - PART 2/3)
shared._PhysicsBind = RunService.RenderStepped:Connect(function()
    if not shared._InvisRunning then return end

    local character = LocalPlayer.Character
    if not character or not character.PrimaryPart then 
        shared.ManualSpamActive = false
        _clashStartTime = 0
        return 
    end

    local hrp = character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart
    if not hrp then return end

    local balls = SafeGetBalls()
    if #balls == 0 then
        shared.ManualSpamActive = false
        _clashStartTime = 0
        return
    end

    local playerPos = hrp.Position
    local anyTargetingMe = false
    local shouldSpamAny = false
    local now = os.clock()
    
    local tempSpamBall = nil
    local tempSpamTarget = ""

    local cfg = (type(Config) == "table") and Config or {}
    local autoParryEnabled = cfg.AutoParry or false
    local autoSpamEnabled = cfg.AutoSpam or cfg.AutoSpamClash or false
    local soccerMode = cfg.SoccerMode or false
    local parryMode = cfg.ParryMode or "Distance"
    local distanceTiming = cfg.DistanceTiming or 100
    local targetTime = cfg.TargetTime or 0.2

    for idx, Ball in ipairs(balls) do
        if not Ball or typeof(Ball) ~= "Instance" or not Ball.Parent then continue end

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
        local ballPos = Ball.Position
        local Distance = (playerPos - ballPos).Magnitude

        local ballDirection = Speed > 1 and Velocity.Unit or Vector3.new(0, -1, 0)
        local toPlayerDirection = Distance > 0.1 and (playerPos - ballPos).Unit or Vector3.zero
        local dotProduct = ballDirection:Dot(toPlayerDirection)

        local targetAttr = Ball:GetAttribute("target") or Ball:GetAttribute("Target")
        local ballTargetStr = tostring(targetAttr or "")
        local isTargetingMe = (ballTargetStr == LocalPlayer.Name or ballTargetStr == tostring(LocalPlayer))

        if soccerMode then
            isTargetingMe = (dotProduct > -0.15 or Distance <= 16)
        end

        -- 🔓 1. เคลียร์ล๊อคทันทีเมื่อบอลเปลี่ยนไปหาคนอื่น
        if not isTargetingMe then
            lastHitTicks[Ball] = 0
            parryLocked[Ball] = false
            lockTime[Ball] = 0
            continue
        else
            anyTargetingMe = true
        end

        -- 🔒 2. HARD LOCK 0.7S PREVENT DOUBLE CLICK (ตรวจเช็คตัวจับสเตทรอบตีลมแบบเด็ดขาด)
        if parryLocked[Ball] then
            local elapsedSinceLock = now - (lockTime[Ball] or 0)
            if elapsedSinceLock < 0.7 then
                continue -- ตราบใดที่ยังไม่พ้น 0.7 วินาที บอลลูกนี้จะถูกเพิกเฉย ไม่มีการส่งรีโมทเด็ดขาด
            else
                parryLocked[Ball] = false
            end
        end

        -- 🛡️ 3. Event / Cloak Checks
        local isSingularity = character:GetAttribute("IS_EVENT_SINGULARITY")
        if isSingularity then
            singularityEndTime = now
            continue
        elseif (now - singularityEndTime) < 0.15 then
            continue
        end

        local isCloaked = Ball:FindFirstChild("Cloak")
        if isCloaked then continue end

        pcall(_ZX_pushVelSample, "ball_" .. tostring(idx), ballPos, Velocity)
        pcall(_ZX_pushVelSample, "player", playerPos, hrp.AssemblyLinearVelocity)

        local reachTime = Distance / math.max(Speed, 1)

        -- ⚔️ 4. AUTO SPAM SYSTEM
        local isRealClashZone = (Distance <= 15) or (reachTime <= 0.1 and Distance <= 23)
        if autoSpamEnabled and isTargetingMe and isRealClashZone then
            shouldSpamAny = true
            tempSpamBall = Ball
            tempSpamTarget = ballTargetStr
            continue
        end

        -- 🎯 5. AUTO PARRY CALCULATION
        local allowedToHit = isTargetingMe and not parryLocked[Ball]
        
        if autoParryEnabled and allowedToHit then
            local triggerParry = false
            local userScale = distanceTiming / 100
            
            if parryMode == "Curve" then
                -- 📊 บันทึกตำแหน่งลงประวัติตารางคำนวณเวกเตอร์วิถีโค้ง
                velocityHistory[Ball] = velocityHistory[Ball] or {}
                table.insert(velocityHistory[Ball], {vel = Velocity, speed = Speed, time = now})
                if #velocityHistory[Ball] > 10 then table.remove(velocityHistory[Ball], 1) end

                -- ตรวจสอบจุดชะลอตัวเพื่อแต่งวิถีเลี้ยวออกด้านข้าง (Curve Speed Drop)
                local isDeceleratingInCurve = false
                if #velocityHistory[Ball] >= 4 then
                    local prevSpeed = velocityHistory[Ball][#velocityHistory[Ball]-3].speed
                    if Speed < (prevSpeed * 0.85) and dotProduct < 0.85 then
                        isDeceleratingInCurve = true
                    end
                end

                -- ตรวจวัดค่าความเร็วในการเหวี่ยงออกด้านข้าง (Lateral Magnitude Velocity)
                local lateralVelocity = Velocity - (Velocity.Unit:Dot(toPlayerDirection) * Velocity.Unit)
                local lateralSpeed = lateralVelocity.Magnitude

                -- [FIXED]: ควบคุมด้วย Flag แทนการใช้ continue เพื่อป้องกันระบบจดจำล็อกหลุดทำงาน
                if isDeceleratingInCurve then
                    triggerParry = false -- สั่งไม่ให้ตีเด็ดขาด แต่ยังคงรักษาสถานะลูปเพื่อตรวจจับล็อกในเฟรมต่อไป
                else
                    -- จังหวะพ้นโค้งฉีกตัวและบอลเริ่มเร่งระดับความเร็วหันเป้าเข้าหาผู้เล่นโดยตรง
                    local pingCompensation = (pingSeconds * Speed * 1.3)
                    local perfectStrikeZone = math.clamp((12 + (Speed * 0.215)) - (lateralSpeed * 0.2) + pingCompensation, 14, 70) * userScale
                    local realReachTime = Distance / math.max(Speed, 1)

                    if Distance <= perfectStrikeZone or realReachTime <= 0.26 then
                        if dotProduct > -0.35 or Distance <= 18 then
                            triggerParry = true
                        end
                    end
                end
            elseif parryMode == "Distance" then
                local emergencyDist = SafeGetEmergencyDistance(Speed)
                if Distance <= emergencyDist or reachTime <= 0.25 then
                    triggerParry = true
                end
                if not triggerParry then
                    local pingBuffer = pingSeconds * Speed * 1.5
                    local earlyThreshold = math.clamp(((18 + Speed * 0.15) * userScale) + pingBuffer, 15, 100)
                    if Distance <= earlyThreshold or reachTime <= 0.3 then
                        triggerParry = true
                    end
                end
            elseif parryMode == "Time" then
                local emergencyDist = SafeGetEmergencyDistance(Speed)
                if Distance <= emergencyDist or reachTime <= 0.25 then
                    triggerParry = true
                end
                if not triggerParry then
                    local dynamicTime = targetTime + (pingSeconds * 1.2) + 0.15
                    local timeThreshold = math.clamp(((18 + Speed * 0.15) * userScale) + (pingSeconds * Speed * 1.5), 15, 100)
                    if reachTime <= dynamicTime or Distance <= timeThreshold then
                        triggerParry = true
                    end
                end
            else
                local emergencyDist = SafeGetEmergencyDistance(Speed)
                if Distance <= emergencyDist or reachTime <= 0.25 then
                    triggerParry = true
                end
                if not triggerParry then
                    local earlyTimeWindow = math.clamp(0.4 + (pingSeconds * 1.2), 0.35, 0.65)
                    local defaultThresh = math.clamp(((18 + Speed * 0.15) * userScale) + (pingSeconds * Speed * 1.5), 15, 100)
                    if reachTime <= earlyTimeWindow or Distance <= defaultThresh then
                        triggerParry = true
                    end
                end
            end

            -- 🚀 EXECUTING SIGNAL FIRE REMOTE & HARD RE-LOCK ENGAGED
            if triggerParry then
                if (now - lastParryTime) >= 0.05 then
                    if type(Auto_Parry) == "table" and type(Auto_Parry.FireParryRemote) == "function" then
                        pcall(Auto_Parry.FireParryRemote, false)
                    end
                    lastParryTime = now
                end
                
                -- ทำการบันทึกแสตมป์เวลาการตีทันที เพื่อล็อคคูลดาวน์ 0.7 วิอย่างถาวร
                lastHitTicks[Ball] = now
                parryLocked[Ball] = true
                lockTime[Ball] = now
            end
        end
    end
        -- ⚔️ 6. SYSTEM SPAM CONTROLLER & CLEANUP (PART 3/3)
    if not shared.ManualSpamActive then
        if shouldSpamAny and tempSpamBall then
            shared.ManualSpamActive = true
            activeClashBall = tempSpamBall
            clashPartner = tempSpamTarget
            _clashStartTime = now
        else
            _clashStartTime = 0
            shared.ManualSpamActive = false
        end
    else
        if not activeClashBall or not activeClashBall.Parent then
            shared.ManualSpamActive = false
        else
            local dist = (hrp.Position - activeClashBall.Position).Magnitude
            local currentTarget = tostring(activeClashBall:GetAttribute("target") or activeClashBall:GetAttribute("Target") or "")
            
            if dist > 50 or (currentTarget ~= LocalPlayer.Name and currentTarget ~= clashPartner) then
                shared.ManualSpamActive = false
                activeClashBall = nil
                clashPartner = ""
                _clashStartTime = 0
            end
        end
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
            if afkTimer >= 300 then -- 300 วินาที = 5 นาที
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

-- ═══ 2. & 3. ADVANCED ORBIT GOD MODE & CAMERA DESYNC FIX (SUPER FAST Y-AXIS) ═══
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local heightSwitchTimer = 0

RunService.Heartbeat:Connect(function(dt)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")

    if not hrp or not hum or hum.Health <= 0 then return end      
  
    if Config.GodMode then      
        -- ใช้ฟังก์ชันดึงลูกบอลจริงจากระบบหลัก      
        local ball = Auto_Parry.Get_Ball()      
              
        if ball then      
            heightSwitchTimer = heightSwitchTimer + dt      
                  
            -- ดึงความเร็วและทิศทางที่ถูกต้อง      
            local ballVelocity = ball:IsA("BasePart") and ball.AssemblyLinearVelocity or Vector3.new(0,0,0)      
            local ballSpeed = ballVelocity.Magnitude      
            local ballDirection = ballSpeed > 1 and ballVelocity.Unit or ball.CFrame.LookVector                  
      
            local sideVector = ballDirection:Cross(Vector3.new(0, 1, 0))      
            if sideVector.Magnitude > 0 then      
                sideVector = sideVector.Unit      
            else      
                sideVector = Vector3.new(1, 0, 0)      
            end      
                  
            -- สลับซ้าย-ขวาอย่างรวดเร็ว (ความเร็ว 15)
            local sideOffsetMultiplier = (math.floor(heightSwitchTimer * 15) % 2 == 0) and 12 or -12      
                  
            -- 🔴 จุดสำคัญ: วาร์ปแกน Y ขึ้น-ลง อย่างรวดเร็วมาก (ความเร็ว 45) 
            -- จะสลับตำแหน่งไปมาระหว่าง 30 กับ -30 ทำให้บอลโจมตีไม่โดน แต่ตัวละครยังอยู่ในขอบเขตที่กดตีได้
            local isHigh = (math.floor(heightSwitchTimer * 45) % 2 == 0)
            local chosenY = isHigh and 30 or -30 
      
            -- กำหนดตำแหน่ง Fake Position
            local fakePosition = ball.Position + (sideVector * sideOffsetMultiplier) + Vector3.new(0, chosenY, 0)      
                  
            -- ปรับระยะตรวจจับให้อยู่ที่ 150 เพื่อให้ระบบทำงานได้กว้างขึ้น
            if (hrp.Position - ball.Position).Magnitude < 150 then      
                hrp.CFrame = CFrame.new(fakePosition, ball.Position)      
            end      
        end      
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
-- ═══ GUI ENGINE DESIGN (HORIZONTAL TABS & SMOOTH FADE) ═══════════════════════
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "InvisHub_Horizontal_" .. math.random(100,999); ScreenGui.ResetOnSpawn = false
shared._InvisHubStealthGui = ScreenGui

-- ═══ CUSTOM STACK-SAFE NOTIFICATION GUI QUEUE ═══
local NotificationHolder = Instance.new("Frame", ScreenGui)
NotificationHolder.Size = UDim2.new(0, 240, 0, 450)
NotificationHolder.Position = UDim2.new(1, -255, 0, 30)
NotificationHolder.BackgroundTransparency = 1
local notifyList = Instance.new("UIListLayout", NotificationHolder)
notifyList.Padding = UDim.new(0, 6)
notifyList.SortOrder = Enum.SortOrder.LayoutOrder

local function CustomNotify(text, duration)
    duration = duration or 3.5
    local card = Instance.new("Frame", NotificationHolder)
    card.Size = UDim2.new(1, 0, 0, 38)
    card.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", card)
    stroke.Color = Color3.fromRGB(255, 60, 60)
    stroke.Thickness = 1.2
    
    local txt = Instance.new("TextLabel", card)
    txt.Size = UDim2.new(1, -12, 1, 0)
    txt.Position = UDim2.new(0, 8, 0, 0)
    txt.Text = "🔔 " .. text
    txt.TextColor3 = Color3.fromRGB(255, 255, 255)
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 11
    txt.BackgroundTransparency = 1
    txt.TextXAlignment = Enum.TextXAlignment.Left

    card.BackgroundTransparency = 1
    txt.TextTransparency = 1
    stroke.Transparency = 1
    
    TweenService:Create(card, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    TweenService:Create(txt, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
    TweenService:Create(stroke, TweenInfo.new(0.2), {Transparency = 0}):Play()

    task.delay(duration, function()
        local t1 = TweenService:Create(card, TweenInfo.new(0.25), {BackgroundTransparency = 1})
        local t2 = TweenService:Create(txt, TweenInfo.new(0.25), {TextTransparency = 1})
        local t3 = TweenService:Create(stroke, TweenInfo.new(0.25), {Transparency = 1})
        t1:Play() t2:Play() t3:Play()
        t1.Completed:Connect(function() card:Destroy() end)
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

-- ═══ PLAYER ABILITY ESP TRACKER MODULE (MODERN REDESIGN) ═══
local function createBillboardGui(p)
    if p == LocalPlayer then return end
    task.spawn(function()
        local character = p.Character or p.CharacterAdded:Wait()
        local head = character:WaitForChild("Head", 10)
        if not head then return end
        if head:FindFirstChild("AbilityESP_Gui") then head.AbilityESP_Gui:Destroy() end
        
        -- สร้าง BillboardGui หลัก
        local bg = Instance.new("BillboardGui", head)
        bg.Name = "AbilityESP_Gui"
        bg.Adornee = head
        bg.Size = UDim2.new(0, 220, 0, 50)
        bg.StudsOffset = Vector3.new(0, 3.2, 0)
        bg.AlwaysOnTop = true
        
        -- กรอบพื้นหลังแบบโปร่งใสแต่งขอบเรืองแสงเบาๆ
        local frame = Instance.new("Frame", bg)
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
        frame.BackgroundTransparency = 0.4
        frame.BorderSizePixel = 0
        
        local corner = Instance.new("UICorner", frame)
        corner.CornerRadius = UDim.new(0, 8)
        
        local stroke = Instance.new("UIStroke", frame)
        stroke.Color = Color3.fromRGB(255, 75, 75)
        stroke.Transparency = 0.3
        stroke.Thickness = 1.5

        -- ข้อความแสดงชื่อ (บรรทัดบน)
        local nameLabel = Instance.new("TextLabel", frame)
        nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
        nameLabel.Position = UDim2.new(0, 0, 0.05, 0)
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextSize = 12
        nameLabel.TextStrokeTransparency = 0.4
        nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.BackgroundTransparency = 1
        
        -- ข้อความแสดงสกิล (บรรทัดล่าง พร้อมไอคอน)
        local abilityLabel = Instance.new("TextLabel", frame)
        abilityLabel.Size = UDim2.new(1, 0, 0.5, 0)
        abilityLabel.Position = UDim2.new(0, 0, 0.45, 0)
        abilityLabel.TextColor3 = Color3.fromRGB(100, 220, 255)
        abilityLabel.TextSize = 11
        abilityLabel.TextStrokeTransparency = 0.4
        abilityLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        abilityLabel.Font = Enum.Font.GothamSemibold
        abilityLabel.BackgroundTransparency = 1
        
        local conn
        conn = RunService.Heartbeat:Connect(function()
            if not character or not character.Parent or not bg or not bg.Parent then 
                if conn then conn:Disconnect() end 
                return 
            end
            
            if Config.AbilityESP then
                bg.Enabled = true
                local currentAbil = p:GetAttribute("EquippedAbility") or p:GetAttribute("Ability") or "None"
                nameLabel.Text = p.DisplayName
                abilityLabel.Text = "⚡ ABILITY: " .. string.upper(tostring(currentAbil))
            else
                bg.Enabled = false
            end
        end)
    end)
end

for _, p in pairs(Players:GetPlayers()) do 
    p.CharacterAdded:Connect(function() createBillboardGui(p) end) 
    if p.Character then createBillboardGui(p) end 
end
Players.PlayerAdded:Connect(function(p) 
    p.CharacterAdded:Connect(function() createBillboardGui(p) end) 
end)
-- ═══ ULTIMATE UNIFIED FLY ENGINE (MOVE + CAMERA LOOK + LOCK) ════════
if shared._FlyBind then
    shared._FlyBind:Disconnect()
    shared._FlyBind = nil
end

shared._FlyBind = RunService.Heartbeat:Connect(function(dt)
    -- รองรับทั้ง Config.FlyMode หรือ Config.FlyEnabled
    if not shared._InvisRunning or (not Config.FlyMode and not Config.FlyEnabled) then return end
    
    pcall(function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local cam = workspace.CurrentCamera
        
        if hrp and hum and cam then
            -- 1. ล็อกแรงโน้มถ่วงและฟิสิกส์เดิมไม่ให้ดึงตกลงพื้น
            hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            
            local moveDir = Vector3.new(0, 0, 0)
            
            -- 2. รองรับการเคลื่อนที่ทั้งจอยสติ๊กมือถือ และ คีย์บอร์ด PC (WASD)
            if hum.MoveDirection.Magnitude > 0 then
                moveDir = hum.MoveDirection
            else
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
            end
            
            -- ควบคุมการขึ้น-ลง (Spacebar / ปุ่มกระโดด ขึ้นข้างบน, LeftShift ลงข้างล่าง)
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) or hum.Jump then
                moveDir = moveDir + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveDir = moveDir - Vector3.new(0, 1, 0)
            end
            
            -- 3. คำนวณตำแหน่งใหม่ตามความเร็วที่ตั้งไว้
            local currentPos = hrp.Position
            if moveDir.Magnitude > 0 then
                currentPos = currentPos + (moveDir.Unit * ((Config.FlySpeed or 50) * dt))
            end
            
            -- 4. บังคับอัปเดตตำแหน่ง พร้อมหันหน้าตามทิศทางกล้องแนวราบในลูปเดียว (ไม่ตีกัน ลื่นไหล 100%)
            local lookVector = cam.CFrame.LookVector
            hrp.CFrame = CFrame.new(currentPos, currentPos + Vector3.new(lookVector.X, 0, lookVector.Z))
        end
    end)
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

-- 🔘 TOGGLE MAIN HUB BUTTON
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 90, 0, 38)
ToggleBtn.Position = UDim2.new(0.03, 0, 0.15, 0)
ToggleBtn.BackgroundColor3 = THEME.Sidebar
ToggleBtn.Text = "❤️‍🔥 INVIS"
ToggleBtn.TextColor3 = THEME.Accent
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 13
ToggleBtn.AutoButtonColor = false
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 8)

local tStroke = Instance.new("UIStroke", ToggleBtn)
tStroke.Color = THEME.Accent
tStroke.Thickness = 1.5

-- Dragging Toggle Button
local tDrag, tStart, tPos
ToggleBtn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        tDrag = true; tStart = i.Position; tPos = ToggleBtn.Position
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if tDrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - tStart
        ToggleBtn.Position = UDim2.new(tPos.X.Scale, tPos.X.Offset + d.X, tPos.Y.Scale, tPos.Y.Offset + d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        tDrag = false
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

ToggleBtn.MouseButton1Click:Connect(function()
    if isTweening then return end
    isTweening = true
    guiOpenState = not guiOpenState
    if guiOpenState then
        MainFrame.Visible = true
        local tween = TweenService:Create(MainFrame, fadeTweenInfo, {GroupTransparency = 0})
        tween:Play()
        tween.Completed:Connect(function() isTweening = false end)
    else
        local tween = TweenService:Create(MainFrame, fadeTweenInfo, {GroupTransparency = 1})
        tween:Play()
        tween.Completed:Connect(function()
            if not guiOpenState then MainFrame.Visible = false end
            isTweening = false
        end)
    end
end)

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

-- 🏷️ TOP TITLE BAR
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 42)
Title.Text = "  ⚡ INVIS HUB PREMIUM  [ V4 OMNI EXPLOITS ]"
Title.TextColor3 = THEME.TextMain
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.BackgroundColor3 = THEME.Sidebar
Title.TextXAlignment = Enum.TextXAlignment.Left

-- 📌 SIDEBAR NAVIGATION
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 140, 1, -42)
Sidebar.Position = UDim2.new(0, 0, 0, 42)
Sidebar.BackgroundColor3 = THEME.Sidebar

local SideList = Instance.new("UIListLayout", Sidebar)
SideList.Padding = UDim.new(0, 6)
SideList.HorizontalAlignment = Enum.HorizontalAlignment.Center
local SidePadding = Instance.new("UIPadding", Sidebar)
SidePadding.PaddingTop = UDim.new(0, 8)

-- 📑 CONTENT CONTAINER
local ContentContainer = Instance.new("Frame", MainFrame)
ContentContainer.Size = UDim2.new(1, -150, 1, -48)
ContentContainer.Position = UDim2.new(0, 145, 0, 44)
ContentContainer.BackgroundTransparency = 1

local TabFrames = {}
local TabButtons = {}

local function createTabScroll(tabName)
    local scr = Instance.new("ScrollingFrame", ContentContainer)
    scr.Size = UDim2.new(1, 0, 1, 0)
    scr.BackgroundTransparency = 1
    scr.CanvasSize = UDim2.new(0, 0, 0, 0)
    scr.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scr.ScrollBarThickness = 3
    scr.ScrollBarImageColor3 = THEME.Accent
    scr.Visible = false

    local UIList = Instance.new("UIListLayout", scr)
    UIList.Padding = UDim.new(0, 6)
    UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

   local UIPad = Instance.new("UIPadding", scr)
    UIPad.PaddingRight = UDim.new(0, 6)
    UIPad.PaddingLeft = UDim.new(0, 2)
    UIPad.PaddingTop = UDim.new(0, 4)

    TabFrames[tabName] = scr
    return scr
end

local combatScroll = createTabScroll("Combat")
local visualScroll = createTabScroll("Visuals")
local settingsScroll = createTabScroll("Settings")
TabFrames["Combat"].Visible = true

local function setupTabButton(name)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(1, -14, 0, 36)
    btn.BackgroundColor3 = (name == "Combat") and THEME.CardHover or THEME.CardBg
    btn.Text = name
    btn.TextColor3 = (name == "Combat") and THEME.Accent or THEME.TextDark
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    TabButtons[name] = btn

    btn.MouseButton1Click:Connect(function()
        for tName, frame in pairs(TabFrames) do
            local isTarget = (tName == name)
            frame.Visible = isTarget
            if TabButtons[tName] then
                TabButtons[tName].BackgroundColor3 = isTarget and THEME.CardHover or THEME.CardBg
                TabButtons[tName].TextColor3 = isTarget and THEME.Accent or THEME.TextDark
            end
        end
    end)
end

setupTabButton("Combat")
setupTabButton("Visuals")
setupTabButton("Settings")

-- 🛠️ UI BUILDER UTILITIES (FIXED TEXTBOXES & MODERN UI)
local function createToggle(name, stateKey, parent)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = THEME.CardBg
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 1

    local update = function()
        local isAct = false
        if stateKey == "SkinChangerEnabled" then
            isAct = getgenv().skinChanger
        else
            isAct = Config[stateKey]
        end

        if isAct then
            btn.Text = "  " .. name .. " : ON"
            btn.TextColor3 = THEME.Active
            btn.BackgroundColor3 = Color3.fromRGB(18, 32, 24)
            stroke.Color = THEME.Active
        else
            btn.Text = "  " .. name .. " : OFF"
            btn.TextColor3 = THEME.Inactive
            btn.BackgroundColor3 = THEME.CardBg
            stroke.Color = Color3.fromRGB(35, 35, 45)
        end
        btn.TextXAlignment = Enum.TextXAlignment.Left
    end

    btn.MouseButton1Click:Connect(function()
        if stateKey == "SkinChangerEnabled" then
            getgenv().skinChanger = not getgenv().skinChanger
            pcall(function() getgenv().updateSword() end)
        else
            Config[stateKey] = not Config[stateKey]
        end
        CustomNotify(name .. " Toggled!", 2)
        update()
    end)
    update()
end

local function createCycle(name, stateKey, list, parent)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = THEME.CardBg
    btn.TextColor3 = Color3.fromRGB(100, 180, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(40, 60, 90)
    stroke.Thickness = 1

    local update = function()
        btn.Text = "  " .. name .. " : [ " .. tostring(Config[stateKey]) .. " ]"
        btn.TextXAlignment = Enum.TextXAlignment.Left
    end

    btn.MouseButton1Click:Connect(function()
        local idx = table.find(list, Config[stateKey]) or 1
        Config[stateKey] = list[idx + 1 > #list and 1 or idx + 1]
        update()
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

-- 🛠️ FIXED TEXTBOX CREATOR (NO BLANK SPACES BUG)
local function createTextBox(placeholder, defaultText, parent, onFocusLost)
    local boxContainer = Instance.new("Frame", parent)
    boxContainer.Size = UDim2.new(1, 0, 0, 34)
    boxContainer.BackgroundColor3 = THEME.InputBg
    Instance.new("UICorner", boxContainer).CornerRadius = UDim.new(0, 6)

    local boxStroke = Instance.new("UIStroke", boxContainer)
    boxStroke.Color = Color3.fromRGB(45, 45, 60)
    boxStroke.Thickness = 1

    local box = Instance.new("TextBox", boxContainer)
    box.Size = UDim2.new(1, -16, 1, 0)
    box.Position = UDim2.new(0, 8, 0, 0)
    box.BackgroundTransparency = 1
    box.Text = defaultText or ""
    box.PlaceholderText = placeholder or "Type here..."
    box.PlaceholderColor3 = THEME.TextDark
    box.TextColor3 = THEME.TextMain
    box.Font = Enum.Font.GothamBold
    box.TextSize = 11
    box.ClearTextOnFocus = false
    box.ClipsDescendants = true
    box.TextXAlignment = Enum.TextXAlignment.Left

    box.Focused:Connect(function() boxStroke.Color = THEME.Accent end)
    box.FocusLost:Connect(function(enterPressed)
        boxStroke.Color = Color3.fromRGB(45, 45, 60)
        if onFocusLost then onFocusLost(box.Text) end
    end)

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

-- ═══ COMBAT CONTROLS ═══
createToggle("Auto Parry System", "AutoParry", combatScroll)
createToggle("Soccer Mode (No Locked Target)", "SoccerMode", combatScroll)
createToggle("immortal (Beta)", "GodMode", combatScroll)
createToggle("Smart Auto Ability", "AutoAbility", combatScroll)
createCycle("Curve Vector Direction", "ParryCurveMode", {"Front", "Back", "Left", "Right", "Random", "Straight", "Slowball", "Fastball", "Camera", "CameraSky", "CameraLeft", "CameraRight", "VelocityCurve", "Inverse", "CurveSwerve"}, settingsScroll)

createLabel("Pre-Hit Time Input (Time Mode)", combatScroll)
createTextBox("Enter Time Target (e.g. 0.3)...", tostring(Config.TargetTime), combatScroll, function(val)
    local n = tonumber(val)
    if n then Config.TargetTime = n CustomNotify("Target Time: " .. tostring(n), 2) end
end)

createToggle("Play Parry Animation Track", "SwordAnimationsEnabled", combatScroll)
createToggle("Auto Spam Clash", "AutoSpam", combatScroll)

createActionBtn("🔥 Manual Spam", Color3.fromRGB(110, 25, 35), function()
    loadstring(game:HttpGet("https://gist.githubusercontent.com/foreverspacexc-blip/570db122f01f685727b3409adb314419/raw/dd3631412ec66ca86d22778a592f9a32abf45a5d/gistfile1.txt"))()
    CustomNotify("Ultra Spam Loaded!", 2.5)
end, combatScroll)

createToggle("Auto Play (Bot Movement)", "AutoPlay", combatScroll)
createToggle("Special Skill Detections", "SpecialSkillDetections", combatScroll)
createToggle("Look at Ball (Character)", "LookAtBallChar", combatScroll)
createToggle("Look at Ball (Camera)", "LookAtBallCam", combatScroll)

-- ═══ VISUAL CONTROLS ═══
createToggle("Player Ability ESP Tracker", "AbilityESP", visualScroll)
createToggle("Enable Visual Sword Changer Backend", "SkinChangerEnabled", visualScroll)

createTextBox("Type Sword Model Name...", "", visualScroll, function(val)
    getgenv().swordModel = val
    pcall(function() getgenv().updateSword() end)
end)

createTextBox("Type Custom Animations Name...", "", visualScroll, function(val)
    getgenv().swordAnimations = val
    pcall(function() getgenv().updateSword() end)
end)

createTextBox("Type Sword Custom FX Name...", "", visualScroll, function(val)
    getgenv().swordFX = val
    pcall(function() getgenv().updateSword() end)
end)

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

createActionBtn("🔓 Unlock All (Auto Enable)", Color3.fromRGB(90, 40, 150), function()
    task.spawn(function()
        CustomNotify("Loading Unlock All...", 2)
        pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/wSuhUFTr"))() end)
        task.wait(0.5)
        local standaloneGui = getgenv()._usStandaloneUnlockGui or LocalPlayer:FindFirstChildOfClass("PlayerGui"):FindFirstChild("UnlockSuiteUnlockAllEmotes")
        if standaloneGui then
            local enableBtn = standaloneGui:FindFirstChild("Enable", true)
            if enableBtn then
                pcall(function()
                    if getconnections then
                        for _, conn in ipairs(getconnections(enableBtn.Activated)) do conn:Fire() end
                        for _, conn in ipairs(getconnections(enableBtn.MouseButton1Click)) do conn:Fire() end
                    end
                end)
            end
            standaloneGui.Enabled = false
            CustomNotify("Unlock All Enabled", 3)
        end
    end)
end, visualScroll)

local TargetUsername = ""
createTextBox("Type Target Username (e.g. Roblox122)...", "", visualScroll, function(val)
    TargetUsername = val
end)

local isCustomChar = false
local customModelInstance = nil
local syncConnection = nil

createActionBtn("👤 Toggle Custom Character", Color3.fromRGB(35, 80, 140), function()
    isCustomChar = not isCustomChar
    
    if isCustomChar then
        -- === [เปิดใช้งาน] สร้างโมเดลและซิงค์ตำแหน่ง ===
        if TargetUsername == "" then 
            CustomNotify("❌ Enter a username first!", 3) 
            isCustomChar = false
            return 
        end
        
        task.spawn(function()
            CustomNotify("🔍 Loading model for: " .. TargetUsername, 2)
            local successId, targetUserId = pcall(function() return Players:GetUserIdFromNameAsync(TargetUsername) end)
            if not successId or not targetUserId then 
                CustomNotify("❌ User not found!", 3) 
                isCustomChar = false
                return 
            end
            
            -- ลบโมเดลเก่าทิ้งก่อน (ถ้ามีค้างอยู่)
            if customModelInstance then 
                customModelInstance:Destroy() 
                customModelInstance = nil 
            end
            
            local successModel, targetModel = pcall(function()
                return Players:CreateHumanoidModelFromUserId(targetUserId)
            end)
            
            if successModel and targetModel then
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local rootPart = char.HumanoidRootPart
                    
                    customModelInstance = targetModel
                    targetModel:SetPrimaryPartCFrame(rootPart.CFrame)
                    targetModel.Name = LocalPlayer.Name .. "_CustomModel"
                    targetModel.Parent = workspace
                    
                    -- เปลี่ยนมุมกล้องไปที่โมเดลใหม่
                    local newHum = targetModel:FindFirstChildOfClass("Humanoid")
                    if newHum then
                        workspace.CurrentCamera.CameraSubject = newHum
                    end
                    
                    -- ซ่อนตัวละครเดิม
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") or part:IsA("Decal") then
                            part.Transparency = 1
                        end
                    end
                    
                    -- ระบบซิงค์ตำแหน่งเดินตาม
                    local RunService = game:GetService("RunService")
                    if syncConnection then syncConnection:Disconnect() end
                    syncConnection = RunService.RenderStepped:Connect(function()
                        if not char or not char.Parent or not targetModel or not targetModel.Parent then
                            if syncConnection then syncConnection:Disconnect() end
                            return
                        end
                        if rootPart and targetModel.PrimaryPart then
                            targetModel:SetPrimaryPartCFrame(rootPart.CFrame)
                        end
                    end)
                    
                    CustomNotify("✅ Model Applied & Synced!", 3)
                else
                    CustomNotify("❌ Current character not found!", 3)
                    isCustomChar = false
                end
            else
                CustomNotify("❌ Failed to create model!", 3)
                isCustomChar = false
            end
        end)
    else
        -- === [ปิดใช้งาน] คืนค่ากลับเป็นตัวละครเดิม ===
        if syncConnection then
            syncConnection:Disconnect()
            syncConnection = nil
        end
        
        if customModelInstance then
            customModelInstance:Destroy()
            customModelInstance = nil
        end
        
        local char = LocalPlayer.Character
        if char then
            -- คืนค่าความโปร่งใสตัวละครเดิมให้มองเห็นปกติ
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    part.Transparency = 0
                end
            end
            
            -- ดึงกล้องกลับมาที่ตัวละครเดิม
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                workspace.CurrentCamera.CameraSubject = hum
            end
        end
        
        CustomNotify("👤 Character Reset to Default", 2.5)
    end
end, visualScroll)

local isHeadless = false
createActionBtn("💀 Toggle Headless", Color3.fromRGB(70, 35, 90), function()
    pcall(function()
        local char = LocalPlayer.Character
        local head = char and char:FindFirstChild("Head")
        if head then
            isHeadless = not isHeadless
            
            -- ปรับความโปร่งใสของหัวและหน้า (Decal)
            head.Transparency = isHeadless and 1 or 0
            for _, child in ipairs(head:GetChildren()) do
                if child:IsA("Decal") then
                    child.Transparency = isHeadless and 1 or 0
                end
            end
            
            CustomNotify(isHeadless and "💀 Headless: ENABLED" or "👤 Headless: DISABLED", 2.5)
        end
    end)
end, visualScroll)

local isKorblox = false
createActionBtn("🦴 Toggle Korblox Leg", Color3.fromRGB(25, 70, 120), function()
    pcall(function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            isKorblox = not isKorblox
            
            -- พยายามใช้ ApplyDescription ก่อน (สำหรับผู้เล่นที่มีไอเทมแท้)
            local success = pcall(function()
                local desc = hum:GetAppliedDescription()
                desc.RightLeg = isKorblox and 139607718 or 0
                hum:ApplyDescription(desc)
            end)
            
            -- หากใช้ ApplyDescription ไม่ผ่าน (ไม่ได้เป็นเจ้าของไอเทม) จะใช้ระบบซ่อนขาท่อนล่างแทน
            if not success then
                local rLowerLeg = char:FindFirstChild("RightLowerLeg")
                local rFoot = char:FindFirstChild("RightFoot")
                local rLeg = char:FindFirstChild("Right Leg") -- สำหรับตัวละครระบบ R6
                
                if rLowerLeg and rFoot then
                    rLowerLeg.Transparency = isKorblox and 1 or 0
                    rFoot.Transparency = isKorblox and 1 or 0
                elseif rLeg then
                    rLeg.Transparency = isKorblox and 1 or 0
                end
            end
            
            CustomNotify(isKorblox and "🦴 Korblox Leg: ENABLED" or "🦵 Korblox Leg: DISABLED", 2.5)
        end
    end)
end, visualScroll)

createToggle("Player ESP", "PlayerESP", visualScroll)

-- ═══ SYSTEM SETTINGS ═══
createLabel("Set WalkSpeed Modifier", settingsScroll)
createTextBox("Default Speed (16)...", tostring(Config.CustomSpeed or ""), settingsScroll, function(val)
    local n = tonumber(val)
    Config.CustomSpeed = n
    CustomNotify("WalkSpeed Enforced: " .. tostring(n or "Default"), 2)
end)

createToggle("Enable Fly", "FlyEnabled", settingsScroll)
createLabel("Fly Speed Controls", settingsScroll)
createTextBox("Fly Speed (e.g. 50)...", tostring(Config.FlySpeed or 50), settingsScroll, function(val)
    local n = tonumber(val)
    if n then Config.FlySpeed = n CustomNotify("Fly Speed: " .. tostring(n), 2) end
end)

createLabel("Set JumpPower Modifier", settingsScroll)
createTextBox("Default JumpPower (50)...", tostring(Config.CustomJump or ""), settingsScroll, function(val)
    local n = tonumber(val)
    Config.CustomJump = n
    CustomNotify("JumpPower Enforced: " .. tostring(n or "Default"), 2)
end)

createToggle("Auto Jump Loop", "AutoJumpEnabled", settingsScroll)
createToggle("Anti-AFK (Jump & Drop 5 Mins)", "AntiAfk", settingsScroll)

createTextBox("Enter Roblox Animation ID...", "", settingsScroll, function(val)
    Config.CustomAnimID = val
end)

createActionBtn("🎭 Execute Custom Anim Track", Color3.fromRGB(55, 25, 85), function()
    PlayCustomAnimation(Config.CustomAnimID)
end, settingsScroll)

createActionBtn("💥 Warp to Nearest Player", Color3.fromRGB(70, 25, 25), function() executeWarp(targetDistanceSolver("Nearest")) end, settingsScroll)
createActionBtn("💥 Warp to Farthest Player", Color3.fromRGB(90, 30, 30), function() executeWarp(targetDistanceSolver("Farest")) end, settingsScroll)
createActionBtn("🚀 Tween to Nearest Player", Color3.fromRGB(25, 50, 75), function() executeTween(targetDistanceSolver("Nearest")) end, settingsScroll)
createActionBtn("🚀 Tween to Farthest Player", Color3.fromRGB(30, 60, 95), function() executeTween(targetDistanceSolver("Farest")) end, settingsScroll)

createActionBtn("🔄 Rejoin Server Instance", Color3.fromRGB(35, 85, 35), function() RejoinServer() end, settingsScroll)
createActionBtn("🌌 Server Hop Network Search", Color3.fromRGB(95, 70, 25), function() ServerHop() end, settingsScroll)

createLabel("Distance Mode Timing", settingsScroll)
createTextBox("Timing Distance (e.g. 100)...", tostring(Config.DistanceTiming), settingsScroll, function(val)
    local n = tonumber(val)
    if n then Config.DistanceTiming = n else CustomNotify("Distance Timing Updated", 2) end
end)

createCycle("Parry Logic Mode", "ParryMode", {"Curve", "Distance", "Time"}, combatScroll)
createCycle("Lock Target Profile", "TargetMode", {"Double click", "Normal", "Nearest", "Farest"}, settingsScroll)
