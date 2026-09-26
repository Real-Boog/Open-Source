

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")

local lp = Players.LocalPlayer
local cam = workspace.CurrentCamera
local RS = game:GetService("ReplicatedStorage")
local wkspc = RS:FindFirstChild("wkspc")
local Lighting = game:GetService("Lighting")

local Options = Library.Options
local Toggles = Library.Toggles

local DrawingLib = Drawing

------------------------------------------------------------------
-- Helpers
------------------------------------------------------------------
local function Notify(title, desc, time)
    Library:Notify({ Title = title, Description = desc, Time = time or 4 })
end

local function wkspcVal(name)
    local v = wkspc and wkspc:FindFirstChild(name)
    return v and v.Value or nil
end

local function getModel(p)
    if not p then return nil end
    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then return p.Character end
    local m = workspace:FindFirstChild(p.Name)
    if m and m:FindFirstChild("HumanoidRootPart") then return m end
    return nil
end

local function getHealth(p)
    local nr = p and p:FindFirstChild("NRPBS")
    local h = nr and nr:FindFirstChild("Health")
    return h and h.Value or 0
end

local function teamOf(p)
    local st = p and p:FindFirstChild("Status")
    local t = st and st:FindFirstChild("Team")
    if t then return tostring(t.Value) end
    return tostring(p and p.Team and p.Team.Name or "?")
end

-- robust enemy check: auto-detects FFA, falls back to TeamColor, treats unknown as enemy
local function isEnemyAuto(p)
    if p == lp or not p then return false end
    if wkspcVal("FFA") then return true end
    local my, their = teamOf(lp), teamOf(p)
    if their == "Spectator" then return false end
    if my ~= "?" and their ~= "?" then return my ~= their end
    local ok, mc, tc = pcall(function() return lp.TeamColor, p.TeamColor end)
    if ok and mc and tc then return mc ~= tc end
    return true
end

-- team check modes: "Auto" / "FFA" / "Team" / "Everyone"
local function isEnemyMode(p, mode)
    if p == lp or not p then return false end
    if mode == "FFA" or mode == "Everyone" then return true end
    if mode == "Auto" then return isEnemyAuto(p) end
    local my, their = teamOf(lp), teamOf(p)
    if their == "Spectator" then return false end
    if my == "?" or their == "?" then return true end
    return my ~= their
end

local function isAliveP(p)
    local m = getModel(p)
    if not m then return false end
    local nr = p and p:FindFirstChild("NRPBS")
    local h = nr and nr:FindFirstChild("Health")
    if h then return h.Value > 0 end
    local hum = m:FindFirstChildOfClass("Humanoid")
    return hum and hum.Health > 0
end

-- click helper: mouse1press if available, else VirtualInputManager
local function setMouse(down)
    local ok1, ok2 = pcall(mouse1press), pcall(mouse1release)
    if ok1 or ok2 then
        if down then pcall(mouse1press) else pcall(mouse1release) end
        return
    end
    pcall(function() VIM:SendMouseButtonEvent(0, 0, 0, down, "", 1) end)
end

local function keyState(idx)
    local o = Options[idx]
    if not o or not o.GetState then return false end
    local ok, st = pcall(function() return o:GetState() end)
    return ok and st or false
end

local function isActive(toggleIdx, keyIdx)
    local t = Toggles[toggleIdx]
    return (t and t.Value) or keyState(keyIdx)
end

------------------------------------------------------------------
-- Window & tabs
------------------------------------------------------------------
local Window = Library:CreateWindow({
    Title = "HackSense",
    Footer = "v0.3.1",
    Icon = 7733765307,
    NotifySide = "Right",
    ShowCustomCursor = true,
})

local Tabs = {
    Main = Window:AddTab("Main", "user"),
    Combat = Window:AddTab("Combat", "crosshair"),
    Gun = Window:AddTab("Gun Mods", "wrench"),
    Player = Window:AddTab("Player", "user"),
    Skins = Window:AddTab("Skins", "palette"),
    Visual = Window:AddTab("Visuals", "eye"),
    Ambience = Window:AddTab("Ambience", "music"),
    Extra = Window:AddTab("Extra", "zap"),
    Settings = Window:AddTab("Settings", "settings"),
    ["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}

------------------------------------------------------------------
-- Main
------------------------------------------------------------------
local MainBox = Tabs.Main:AddGroupbox({ Side = "Left", Name = "Status", IconName = "activity" })
MainBox:AddToggle("Enabled", { Text = "Enabled", Default = true })
MainBox:AddLabel("TargetStatus", { Text = "Target: none", DoesWrap = true })
MainBox:AddLabel("GameInfo", { Text = "Game: " .. tostring(game.Name) .. " | Place: " .. tostring(game.PlaceId), DoesWrap = true })
MainBox:AddDivider()
MainBox:AddButton({ Text = "Unload", Func = function() Library:Unload() end })

local AboutBox = Tabs.Main:AddGroupbox({ Side = "Right", Name = "About", IconName = "info" })
AboutBox:AddLabel("enjoy!.", true)

------------------------------------------------------------------
-- Combat
------------------------------------------------------------------
local AimBox = Tabs.Combat:AddGroupbox({ Side = "Left", Name = "Aimlock", IconName = "crosshair" })
AimBox:AddToggle("Aimlock", { Text = "Aimlock", Default = false })
    :AddKeyPicker("AimlockKey", { Default = "L", Mode = "Hold", SyncToggleState = true, Text = "Aimlock (hold)" })
AimBox:AddToggle("AimlockLock", { Text = "Lock target", Default = true })
AimBox:AddSlider("AimFOV", { Text = "FOV", Default = 200, Min = 0, Max = 500, Rounding = 0, Suffix = "px" })
AimBox:AddSlider("AimSmooth", { Text = "Smoothing", Default = 0.35, Min = 0.01, Max = 1, Rounding = 2 })
AimBox:AddDropdown("AimHitbox", { Text = "Hitbox", Values = { "Head", "Body" }, Default = "Head" })
AimBox:AddDropdown("TargetMode", { Text = "Target mode", Values = { "FOV", "Distance", "Health" }, Default = "FOV" })
AimBox:AddDropdown("AimTeam", { Text = "Team check", Values = { "Auto", "FFA", "Team", "Everyone" }, Default = "Auto" })
AimBox:AddDropdown("AimMethod", { Text = "Aim method", Values = { "Direct", "CamPart" }, Default = "Direct", Tooltip = "Direct sets Camera.CFrame at the last render step; CamPart drives the Arms camera part Arsenal reads" })
AimBox:AddSlider("MaxDist", { Text = "Max distance", Default = 300, Min = 10, Max = 500, Rounding = 0, Suffix = " studs" })
AimBox:AddToggle("AimPrediction", { Text = "Prediction", Default = false })
AimBox:AddSlider("BulletSpeed", { Text = "Projectile speed", Default = 800, Min = 100, Max = 2000, Rounding = 0 })
AimBox:AddToggle("FOVCircle", { Text = "Show FOV circle", Default = true })

local SilentBox = Tabs.Combat:AddGroupbox({ Side = "Right", Name = "Silent Aim", IconName = "target" })
SilentBox:AddToggle("SilentAim", { Text = "Silent aim", Default = false })
    :AddKeyPicker("SilentAimKey", { Default = "V", Mode = "Hold", SyncToggleState = true, Text = "Silent aim (hold)" })
SilentBox:AddSlider("SilentFOV", { Text = "FOV", Default = 120, Min = 0, Max = 360, Rounding = 0, Suffix = "px" })
SilentBox:AddLabel("Feeds PlayerGui.Look. Server validates it — keep FOV small.", true)

local TbotBox = Tabs.Combat:AddGroupbox({ Side = "Right", Name = "Triggerbot", IconName = "zap" })
TbotBox:AddToggle("TBot", { Text = "Triggerbot", Default = false })
    :AddKeyPicker("TBotKey", { Default = "T", Mode = "Toggle", SyncToggleState = true, Text = "Triggerbot" })
TbotBox:AddDropdown("TBotTeam", { Text = "Team check", Values = { "Auto", "FFA", "Team", "Everyone" }, Default = "Auto" })
TbotBox:AddSlider("ShotDelay", { Text = "Shot delay", Default = 2, Min = 1, Max = 10, Rounding = 0 })
TbotBox:AddToggle("AutoFire", { Text = "Autofire zone", Default = false })

local HitboxBox = Tabs.Combat:AddGroupbox({ Side = "Left", Name = "Hitbox Expander", IconName = "box" })
HitboxBox:AddToggle("Hitbox", { Text = "Enable hitbox", Default = false })
HitboxBox:AddSlider("HitboxSize", { Text = "Hitbox size", Default = 21, Min = 1, Max = 25, Rounding = 0 })
HitboxBox:AddSlider("HitboxTransp", { Text = "Transparency", Default = 6, Min = 1, Max = 10, Rounding = 0 })
HitboxBox:AddDropdown("HitboxTeam", { Text = "Team check", Values = { "Auto", "FFA", "Team", "Everyone" }, Default = "Auto" })
HitboxBox:AddToggle("HitboxNoCollide", { Text = "No collision", Default = false })
HitboxBox:AddLabel("Enlarges Head / UpperTorso / HumanoidRootPart hitboxes so client-side hit tests land easier.", true)

local FarmBox = Tabs.Combat:AddGroupbox({ Side = "Left", Name = "AutoFarm", IconName = "flame" })
FarmBox:AddToggle("AutoFarm", { Text = "AutoFarm [ban risk]", Default = false })
FarmBox:AddLabel("Teleports you to the closest enemy, aims, and holds fire. Touches server-visible state (wkspc).", true)

------------------------------------------------------------------
-- Combat implementation
------------------------------------------------------------------
local currentTarget = nil
local mouseDown = false
local fireHoldUntil = 0
local nextFireAt = 0

local function headOf(p)
    local m = getModel(p)
    return m and (m:FindFirstChild("Head") or m:FindFirstChild("HeadHB"))
end

local function hitOf(p)
    local m = getModel(p)
    return m and (m:FindFirstChild("Hitbox") or m:FindFirstChild("HumanoidRootPart"))
end

local function aimPosition(p, hitbox)
    local part = (hitbox == "Body") and hitOf(p) or headOf(p)
    return part and part.Position or nil
end

local function predictedPosition(p, pos)
    if not Toggles.AimPrediction.Value then return pos end
    local m = getModel(p)
    local vel = m and m:FindFirstChild("InitVelocity")
    if not vel then return pos end
    local speed = Options.BulletSpeed.Value
    if speed <= 0 then return pos end
    return pos + vel.Value * ((pos - cam.CFrame.Position).Magnitude / speed)
end

local function acquireTarget(fovPx, hitbox, maxDist)
    local cx, cy = cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2
    local camPos = cam.CFrame.Position
    local best, bestScore = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lp and isEnemyMode(p, Options.AimTeam.Value) and isAliveP(p) then
            local pos = aimPosition(p, hitbox)
            if pos then
                local dist = (pos - camPos).Magnitude
                if dist <= maxDist then
                    local scr = cam:WorldToViewportPoint(pos)
                    if scr.Z > 0 then
                        local sd = (Vector2.new(scr.X, scr.Y) - Vector2.new(cx, cy)).Magnitude
                        if sd <= fovPx then
                            local score = sd
                            local mode = Options.TargetMode.Value
                            if mode == "Distance" then score = dist
                            elseif mode == "Health" then score = getHealth(p) end
                            if score < bestScore then best, bestScore = p, score end
                        end
                    end
                end
            end
        end
    end
    return best
end

local function updateTarget()
    local active = isActive("Aimlock", "AimlockKey") or Toggles.SilentAim.Value or keyState("SilentAimKey")
    if not active or not Toggles.Enabled.Value then currentTarget = nil; return end
    local hitbox = Options.AimHitbox.Value
    local fov = (Toggles.SilentAim.Value or keyState("SilentAimKey")) and Options.SilentFOV.Value or Options.AimFOV.Value
    if currentTarget and Toggles.AimlockLock.Value and isEnemyMode(currentTarget, Options.AimTeam.Value) and isAliveP(currentTarget) then
        local pos = aimPosition(currentTarget, hitbox)
        if pos then
            local scr = cam:WorldToViewportPoint(pos)
            local cx, cy = cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2
            if scr.Z > 0 and (Vector2.new(scr.X, scr.Y) - Vector2.new(cx, cy)).Magnitude <= fov * 2.5 then return end
        end
    end
    currentTarget = acquireTarget(fov, hitbox, Options.MaxDist.Value)
end

local desiredCamCF = nil

local function computeAim()
    if not Toggles.Enabled.Value or not isActive("Aimlock", "AimlockKey") then desiredCamCF = nil; return end
    local p = currentTarget
    local pos = p and aimPosition(p, Options.AimHitbox.Value)
    if not pos then desiredCamCF = nil; return end
    pos = predictedPosition(p, pos)
    local camPos = cam.CFrame.Position
    local dir = pos - camPos
    if dir.Magnitude < 0.1 then desiredCamCF = nil; return end
    desiredCamCF = cam.CFrame:Lerp(CFrame.lookAt(camPos, camPos + dir), Options.AimSmooth.Value)
end

-- apply the camera at the LAST render step so Arsenal's own camera controller
-- (which runs at Camera priority) can't overwrite it afterwards
RunService:BindToRenderStep("HackSenseAim", Enum.RenderPriority.Last.Value + 1, function()
    if not desiredCamCF then return end
    if Options.AimMethod.Value == "CamPart" then
        local a = workspace.CurrentCamera and workspace.CurrentCamera:FindFirstChild("Arms")
        local part = a and a:FindFirstChild("Camera")
        if part then
            pcall(function() part.CFrame = desiredCamCF end)
            return
        end
    end
    pcall(function() cam.CFrame = desiredCamCF end)
end)

local function doSilentAim()
    if not Toggles.Enabled.Value or not (Toggles.SilentAim.Value or keyState("SilentAimKey")) then return end
    local p = currentTarget
    local pos = p and aimPosition(p, Options.AimHitbox.Value)
    if not pos then return end
    pos = predictedPosition(p, pos)
    local dir = (pos - cam.CFrame.Position).Unit
    local lookVal = lp:FindFirstChild("PlayerGui") and lp.PlayerGui:FindFirstChild("Look")
    if lookVal then pcall(function() lookVal.Value = dir end) end
end

-- triggerbot: crosshair raycast via mouse.Target (AdvanceTech style)
local function doTriggerbot()
    if not Toggles.Enabled.Value or not (Toggles.TBot.Value or keyState("TBotKey")) then return end
    local mouse = lp:GetMouse()
    local target = mouse and mouse.Target
    if target and target.Parent then
        local hitParent = target.Parent
        local hasHumanoid = hitParent:FindFirstChild("Humanoid") ~= nil
        local tp = hasHumanoid and Players:FindFirstChild(hitParent.Name) or nil
        if tp and tp ~= lp and isEnemyMode(tp, Options.TBotTeam.Value) and isAliveP(tp) then
            if not mouseDown then
                setMouse(true)
                mouseDown = true
                task.delay(Options.ShotDelay.Value / 10, function()
                    if mouseDown then setMouse(false); mouseDown = false end
                end)
            end
            return
        end
    end
    if mouseDown then setMouse(false); mouseDown = false end
end

-- autofire zone: fire while enemy head is inside FOV circle
local function doAutoFire()
    if not Toggles.Enabled.Value or not Toggles.AutoFire.Value then return end
    local now = tick()
    local cx, cy = cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2
    local zone = Options.AimFOV.Value
    local onEnemy = false
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lp and isEnemyAuto(p) and isAliveP(p) then
            local pos = aimPosition(p, "Head")
            if pos then
                local scr = cam:WorldToViewportPoint(pos)
                if scr.Z > 0 and (Vector2.new(scr.X, scr.Y) - Vector2.new(cx, cy)).Magnitude <= zone then
                    onEnemy = true
                    break
                end
            end
        end
    end
    if onEnemy and now >= nextFireAt then
        if not mouseDown then
            setMouse(true); mouseDown = true
            fireHoldUntil = now + 0.06
            nextFireAt = now + 0.09
        end
    end
    if mouseDown and now >= fireHoldUntil then setMouse(false); mouseDown = false end
end

-- hitbox expander (AdvanceTech style)
local hitboxOriginals = {}
local hitboxDefaultParts = { "UpperTorso", "Head", "HumanoidRootPart" }

local function findClosestPart(player, partName)
    local char = getModel(player)
    if not char then return nil end
    for _, part in ipairs(char:GetChildren()) do
        if part:IsA("BasePart") and part.Name:lower():find(partName:lower(), 1, true) then
            return part
        end
    end
    return nil
end

local function savePartProps(player, part)
    hitboxOriginals[player] = hitboxOriginals[player] or {}
    hitboxOriginals[player][part.Name] = {
        CanCollide = part.CanCollide,
        Transparency = part.Transparency,
        Size = part.Size,
    }
end

local function restorePartProps(player)
    local tbl = hitboxOriginals[player]
    if not tbl then return end
    local char = getModel(player)
    if char then
        for partName, props in pairs(tbl) do
            local part = char:FindFirstChild(partName)
            if part and part:IsA("BasePart") then
                part.CanCollide = props.CanCollide
                part.Transparency = props.Transparency
                part.Size = props.Size
            end
        end
    end
    hitboxOriginals[player] = nil
end

local function extendHitboxFor(player)
    local char = getModel(player)
    if not char then return end
    for _, partName in ipairs(hitboxDefaultParts) do
        local part = char:FindFirstChild(partName) or findClosestPart(player, partName)
        if part and part:IsA("BasePart") then
            savePartProps(player, part)
            part.CanCollide = not Toggles.HitboxNoCollide.Value
            part.Transparency = Options.HitboxTransp.Value / 10
            part.Size = Vector3.new(Options.HitboxSize.Value, Options.HitboxSize.Value, Options.HitboxSize.Value)
        end
    end
end

local function updateHitboxes()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lp and getModel(p) then
            if isEnemyMode(p, Options.HitboxTeam.Value) then
                extendHitboxFor(p)
            else
                restorePartProps(p)
            end
        end
    end
end

Toggles.Hitbox:OnChanged(function()
    if Toggles.Hitbox.Value then
        updateHitboxes()
    else
        for _, p in ipairs(Players:GetPlayers()) do restorePartProps(p) end
    end
end)

-- autofarm (AdvanceTech style, reworked)
local autofarmConn = nil
local autofarmMouseDown = false

local function closestEnemy()
    local best, bestDist = nil, math.huge
    local myChar = getModel(lp)
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lp and isEnemyAuto(p) and isAliveP(p) then
            local char = getModel(p)
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                local d = (myRoot.Position - root.Position).Magnitude
                if d < bestDist then best, bestDist = p, d end
            end
        end
    end
    return best
end

local function startAutoFarm()
    stopAutoFarm()
    local curse = wkspc and wkspc:FindFirstChild("CurrentCurse")
    local ts = wkspc and wkspc:FindFirstChild("TimeScale")
    if curse then pcall(function() curse.Value = "Infinite Ammo" end) end
    if ts then pcall(function() ts.Value = 12 end) end
    autofarmConn = RunService.Stepped:Connect(function()
        if not Toggles.AutoFarm.Value then return end
        local enemy = closestEnemy()
        local myChar = getModel(lp)
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if enemy and myRoot then
            local char = getModel(enemy)
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                myRoot.CFrame = CFrame.new(root.Position - root.CFrame.LookVector * 2 + Vector3.new(0, 2, 0))
                local head = char:FindFirstChild("Head")
                if head then cam.CFrame = CFrame.new(cam.CFrame.Position, head.Position) end
                if not autofarmMouseDown then setMouse(true); autofarmMouseDown = true end
                return
            end
        end
        if autofarmMouseDown then setMouse(false); autofarmMouseDown = false end
    end)
end

local function stopAutoFarm()
    if autofarmConn then autofarmConn:Disconnect(); autofarmConn = nil end
    if autofarmMouseDown then setMouse(false); autofarmMouseDown = false end
    local curse = wkspc and wkspc:FindFirstChild("CurrentCurse")
    local ts = wkspc and wkspc:FindFirstChild("TimeScale")
    if curse then pcall(function() curse.Value = "" end) end
    if ts then pcall(function() ts.Value = 1 end) end
end

Toggles.AutoFarm:OnChanged(function()
    if Toggles.AutoFarm.Value then startAutoFarm() else stopAutoFarm() end
end)

------------------------------------------------------------------
-- Gun Modded
------------------------------------------------------------------
local GunBox = Tabs.Gun:AddGroupbox({ Side = "Left", Name = "Ammo", IconName = "database" })
GunBox:AddToggle("InfAmmoV1", { Text = "Infinite ammo v1 (curse)", Default = false })
GunBox:AddToggle("InfAmmoV2", { Text = "Infinite ammo v2 (HUD)", Default = false })

local GunModsBox = Tabs.Gun:AddGroupbox({ Side = "Right", Name = "Weapon stats", IconName = "wrench" })
GunModsBox:AddToggle("FastReload", { Text = "Fast reload", Default = false })
GunModsBox:AddToggle("FastFireRate", { Text = "Fast fire rate", Default = false })
GunModsBox:AddToggle("AlwaysAuto", { Text = "Always auto", Default = false })
GunModsBox:AddToggle("NoSpread", { Text = "No spread", Default = false })
GunModsBox:AddToggle("NoRecoil", { Text = "No recoil", Default = false })
GunModsBox:AddLabel("Edits the replicated weapon stat Values (Restore on disable).", true)

local gunOriginal = {}
local gunValueNames = {
    FastReload = { "ReloadTime", "EReloadTime" },
    FastFireRate = { "FireRate", "BFireRate" },
    AlwaysAuto = { "Auto", "AutoFire", "Automatic", "AutoShoot", "AutoGun" },
    NoSpread = { "MaxSpread", "Spread", "SpreadControl" },
    NoRecoil = { "RecoilControl", "Recoil" },
}
local gunSetValues = {
    FastReload = 0.01,
    FastFireRate = 0.02,
    AlwaysAuto = true,
    NoSpread = 0,
    NoRecoil = 0,
}
local gunDefaults = {
    FastReload = 0.8,
    FastFireRate = 0.8,
    AlwaysAuto = false,
    NoSpread = 1,
    NoRecoil = 1,
}

local function applyGunMod(name)
    for _, v in ipairs(RS.Weapons:GetDescendants()) do
        local matched = false
        for _, key in ipairs(gunValueNames[name]) do
            if v.Name == key then matched = true; break end
        end
        if matched and v:IsA("ValueBase") then
            gunOriginal[v] = gunOriginal[v] or v.Value
            v.Value = gunSetValues[name]
        end
    end
end

local function restoreGunMods()
    for v, original in pairs(gunOriginal) do
        pcall(function() v.Value = original end)
    end
    gunOriginal = {}
end

for _, name in ipairs({ "FastReload", "FastFireRate", "AlwaysAuto", "NoSpread", "NoRecoil" }) do
    Toggles[name]:OnChanged(function()
        if Toggles[name].Value then applyGunMod(name) else restoreGunMods() end
    end)
end

Toggles.InfAmmoV1:OnChanged(function()
    local curse = wkspc and wkspc:FindFirstChild("CurrentCurse")
    if curse then pcall(function() curse.Value = Toggles.InfAmmoV1.Value and "Infinite Ammo" or "" end) end
end)

-- infinite ammo v2: keeps the HUD ammo counters topped up
RunService.Stepped:Connect(function()
    if not Toggles.InfAmmoV2.Value then return end
    pcall(function()
        local vars = lp.PlayerGui.GUI.Client.Variables
        local a1, a2 = vars:FindFirstChild("ammocount"), vars:FindFirstChild("ammocount2")
        if a1 then a1.Value = 99 end
        if a2 then a2.Value = 99 end
    end)
end)

------------------------------------------------------------------
-- Player
------------------------------------------------------------------
local PlayerBox = Tabs.Player:AddGroupbox({ Side = "Left", Name = "Fly", IconName = "cloud" })
PlayerBox:AddToggle("Fly", { Text = "Fly", Default = false })
PlayerBox:AddSlider("FlySpeed", { Text = "Fly speed", Default = 50, Min = 1, Max = 500, Rounding = 0 })

local MoveBox = Tabs.Player:AddGroupbox({ Side = "Right", Name = "Movement", IconName = "activity" })
MoveBox:AddToggle("WalkSpeed", { Text = "Custom walkspeed", Default = false })
MoveBox:AddDropdown("WalkMethod", { Text = "Walk method", Values = { "Velocity", "Vector", "CFrame", "Humanoid" }, Default = "Velocity" })
MoveBox:AddSlider("WalkPower", { Text = "Walkspeed power", Default = 16, Min = 16, Max = 500, Rounding = 0 })
MoveBox:AddToggle("InfJump", { Text = "Infinite jump", Default = false })
MoveBox:AddToggle("JumpPower", { Text = "Custom jumppower", Default = false })
MoveBox:AddDropdown("JumpMethod", { Text = "Jump method", Values = { "Velocity", "Vector", "CFrame" }, Default = "Velocity" })
MoveBox:AddSlider("JumpPowerAmt", { Text = "Jump power", Default = 30, Min = 1, Max = 500, Rounding = 0 })

local MiscPBox = Tabs.Player:AddGroupbox({ Side = "Left", Name = "Utility", IconName = "zap" })
MiscPBox:AddToggle("AntiAim", { Text = "Anti-aim (spin)", Default = false })
MiscPBox:AddSlider("SpinSpeed", { Text = "Spin speed", Default = 10, Min = 1, Max = 100, Rounding = 0 })
MiscPBox:AddToggle("NoClip", { Text = "NoClip", Default = false })
MiscPBox:AddToggle("Xray", { Text = "Xray (walls 50%)", Default = false })
MiscPBox:AddToggle("CollectDebris", { Text = "Collect debris", Default = false })
MiscPBox:AddDropdown("DebrisType", { Text = "Object", Values = { "Both", "DeadHP", "DeadAmmo" }, Default = "Both" })
MiscPBox:AddInput("TimeScaleInput", { Default = "1", Numeric = true, Text = "TimeScale", Placeholder = "1" })
MiscPBox:AddSlider("ArsenalFOV", { Text = "Arsenal FOV", Default = 70, Min = 0, Max = 120, Rounding = 0 })

------------------------------------------------------------------
-- Player implementation
------------------------------------------------------------------
-- Fly
local flyState = { flying = false }
local flyButtons = { W = false, S = false, A = false, D = false }

local function startFly()
    if flyState.flying then return end
    local char = getModel(lp)
    local head = char and char:FindFirstChild("Head")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not head or not hum then return end
    hum.PlatformStand = true
    local bv = Instance.new("BodyVelocity")
    local bav = Instance.new("BodyAngularVelocity")
    bv.Velocity = Vector3.new(0, 0, 0); bv.MaxForce = Vector3.new(10000, 10000, 10000); bv.P = 1000
    bav.AngularVelocity = Vector3.new(0, 0, 0); bav.MaxTorque = Vector3.new(10000, 10000, 10000); bav.P = 1000
    bv.Parent = head; bav.Parent = head
    flyState = { flying = true, hum = hum, bv = bv, bav = bav }
    hum.Died:Connect(function() flyState.flying = false end)
end

local function stopFly()
    if not flyState.flying then return end
    pcall(function()
        flyState.hum.PlatformStand = false
        flyState.bv:Destroy()
        flyState.bav:Destroy()
    end)
    flyState = { flying = false }
end

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    for k in pairs(flyButtons) do
        if input.KeyCode == Enum.KeyCode[k] then flyButtons[k] = true end
    end
end)
UserInputService.InputEnded:Connect(function(input, gpe)
    if gpe then return end
    for k in pairs(flyButtons) do
        if input.KeyCode == Enum.KeyCode[k] then flyButtons[k] = false end
    end
end)

Toggles.Fly:OnChanged(function()
    if Toggles.Fly.Value then startFly() else stopFly() end
end)

RunService.Heartbeat:Connect(function(step)
    if flyState.flying then
        local char = getModel(lp)
        local primary = char and char.PrimaryPart
        local head = char and char:FindFirstChild("Head")
        if primary and head then
            char:SetPrimaryPartCFrame(CFrame.new(primary.Position) * CFrame.Angles(cam.CFrame:ToEulerAnglesXYZ()))
            if flyButtons.W or flyButtons.S or flyButtons.A or flyButtons.D then
                local speed = Options.FlySpeed.Value
                local t = Vector3.new()
                local function sv(v) return v * (speed / v.Magnitude) end
                if flyButtons.W then t = t + sv(cam.CFrame.LookVector) end
                if flyButtons.S then t = t - sv(cam.CFrame.LookVector) end
                if flyButtons.A then t = t - sv(cam.CFrame.RightVector) end
                if flyButtons.D then t = t + sv(cam.CFrame.RightVector) end
                primary.CFrame = primary.CFrame + t * step
            end
        end
    end
end)

-- WalkSpeed
RunService.Stepped:Connect(function(deltaTime)
    if not Toggles.WalkSpeed.Value then return end
    local char = getModel(lp)
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end
    local VS = hum.MoveDirection * Options.WalkPower.Value
    local method = Options.WalkMethod.Value
    if method == "Velocity" then
        root.Velocity = Vector3.new(VS.X, root.Velocity.Y, VS.Z)
    elseif method == "Vector" then
        root.CFrame = root.CFrame + VS * deltaTime * 0.0001
    elseif method == "CFrame" then
        root.CFrame = root.CFrame + hum.MoveDirection * Options.WalkPower.Value * deltaTime * 0.0001
    else
        hum.WalkSpeed = Options.WalkPower.Value
    end
end)

-- Infinite jump
UserInputService.JumpRequest:Connect(function()
    if Toggles.InfJump.Value then
        local char = getModel(lp)
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end) end
    end
end)

-- JumpPower
RunService.Stepped:Connect(function()
    if not Toggles.JumpPower.Value then return end
    local char = getModel(lp)
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if root and hum and hum:GetState() == Enum.HumanoidStateType.Jumping then
        local p = Options.JumpPowerAmt.Value
        local method = Options.JumpMethod.Value
        if method == "Velocity" then
            root.Velocity = Vector3.new(root.Velocity.X, p, root.Velocity.Z)
        elseif method == "Vector" then
            root.Velocity = Vector3.new(0, p, 0)
        else
            pcall(function() char:SetPrimaryPartCFrame(char:GetPrimaryPartCFrame() + Vector3.new(0, p, 0)) end)
        end
    end
end)

-- Anti-aim spin
local spinInstances = {}
Toggles.AntiAim:OnChanged(function()
    if Toggles.AntiAim.Value then
        local char = getModel(lp)
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            local spin = Instance.new("BodyAngularVelocity")
            spin.Name = "HackSenseSpin"
            spin.AngularVelocity = Vector3.new(0, Options.SpinSpeed.Value, 0)
            spin.MaxTorque = Vector3.new(0, math.huge, 0)
            spin.P = 500000
            spin.Parent = root
            local gyro = Instance.new("BodyGyro")
            gyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            gyro.CFrame = root.CFrame
            gyro.P = 3000
            gyro.Parent = root
            spinInstances = { spin, gyro }
        end
    else
        for _, obj in ipairs(spinInstances) do pcall(function() obj:Destroy() end) end
        spinInstances = {}
    end
end)

Options.SpinSpeed:OnChanged(function()
    for _, obj in ipairs(spinInstances) do
        if obj:IsA("BodyAngularVelocity") then pcall(function() obj.AngularVelocity = Vector3.new(0, Options.SpinSpeed.Value, 0) end) end
    end
end)

-- NoClip
RunService.Stepped:Connect(function()
    if not Toggles.NoClip.Value then return end
    local char = getModel(lp)
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then pcall(function() part.CanCollide = false end) end
        end
    end
end)

-- Xray
local xrayMarked = false
Toggles.Xray:OnChanged(function()
    if Toggles.Xray.Value then
        xrayMarked = true
        for _, d in ipairs(workspace:GetDescendants()) do
            if d:IsA("BasePart") then
                if not d:FindFirstChild("HackSenseOrigTransp") then
                    local nv = Instance.new("NumberValue")
                    nv.Name = "HackSenseOrigTransp"
                    nv.Value = d.Transparency
                    nv.Parent = d
                end
                d.Transparency = 0.5
            end
        end
    else
        xrayMarked = false
        for _, d in ipairs(workspace:GetDescendants()) do
            if d:IsA("BasePart") then
                local nv = d:FindFirstChild("HackSenseOrigTransp")
                if nv then
                    d.Transparency = nv.Value
                    nv:Destroy()
                end
            end
        end
    end
end)

-- Debris collect
task.spawn(function()
    while task.wait(0.1) do
        if Toggles.CollectDebris.Value then
            local char = getModel(lp)
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local debris = workspace:FindFirstChild("Debris")
            if root and debris then
                local sel = Options.DebrisType.Value
                for _, v in ipairs(debris:GetChildren()) do
                    local isHP = v.Name == "DeadHP"
                    local isAmmo = v.Name == "DeadAmmo"
                    if (sel == "Both" and (isHP or isAmmo)) or sel == v.Name then
                        pcall(function() v.CFrame = root.CFrame * CFrame.new(0, 0.2, 0) end)
                    end
                end
            end
        end
    end
end)

-- TimeScale
Options.TimeScaleInput:OnChanged(function()
    local n = tonumber(Options.TimeScaleInput.Value)
    local ts = wkspc and wkspc:FindFirstChild("TimeScale")
    if n and ts then pcall(function() ts.Value = n end) end
end)

-- Arsenal FOV
Options.ArsenalFOV:OnChanged(function()
    pcall(function() lp.Settings.FOV.Value = Options.ArsenalFOV.Value end)
end)

------------------------------------------------------------------
-- Skins
------------------------------------------------------------------
local SkinBox = Tabs.Skins:AddGroupbox({ Side = "Left", Name = "Arms", IconName = "user" })
SkinBox:AddDropdown("ArmMaterial", { Text = "Arm material", Values = { "Plastic", "ForceField", "Wood", "Grass" }, Default = "Plastic" })
SkinBox:AddLabel("ArmColorPick"):AddColorPicker("ArmColor", { Default = Color3.fromRGB(50, 50, 50), Title = "Arm color" })
SkinBox:AddToggle("ArmCharms", { Text = "Arm charms", Default = false })

local GunSkinBox = Tabs.Skins:AddGroupbox({ Side = "Right", Name = "Gun", IconName = "crosshair" })
GunSkinBox:AddDropdown("GunMaterial", { Text = "Gun material", Values = { "Plastic", "ForceField", "Wood", "Grass" }, Default = "Plastic" })
GunSkinBox:AddLabel("GunColorPick"):AddColorPicker("GunColor", { Default = Color3.fromRGB(50, 50, 50), Title = "Gun color" })
GunSkinBox:AddToggle("GunCharms", { Text = "Gun charms", Default = false })

local RainbowBox = Tabs.Skins:AddGroupbox({ Side = "Right", Name = "Rainbow", IconName = "palette" })
RainbowBox:AddToggle("Rainbow1", { Text = "Rainbow gun v1", Default = false })
RainbowBox:AddToggle("Rainbow2", { Text = "Rainbow gun v2 (fast)", Default = false })

-- arms skin loop
task.spawn(function()
    local function arms()
        local a = workspace.CurrentCamera and workspace.CurrentCamera:FindFirstChild("Arms")
        if not a then return end
        local material = Enum.Material[Options.ArmMaterial.Value]
        local color = Options.ArmColor.Value
        for _, O in ipairs(a:GetDescendants()) do
            if O.Name == "Right Arm" or O.Name == "Left Arm" then
                if O:IsA("BasePart") then
                    O.Material = material
                    O.Color = color
                end
            elseif O:IsA("SpecialMesh") then
                if O.TextureId == "" then
                    pcall(function()
                        O.TextureId = "rbxassetid://0"
                        O.VertexColor = Vector3.new(color.R, color.G, color.B)
                    end)
                end
            elseif O.Name == "L" or O.Name == "R" then
                pcall(function() O:Destroy() end)
            end
        end
    end
    while task.wait(0.01) do
        if Toggles.ArmCharms.Value then pcall(arms) end
    end
end)

-- gun skin loop
task.spawn(function()
    local function guns()
        local a = workspace.CurrentCamera and workspace.CurrentCamera:FindFirstChild("Arms")
        if not a then return end
        local material = Enum.Material[Options.GunMaterial.Value]
        local color = Options.GunColor.Value
        for _, O in ipairs(a:GetDescendants()) do
            if O:IsA("MeshPart") then
                O.Material = material
                O.Color = color
            end
        end
    end
    while task.wait(0.01) do
        if Toggles.GunCharms.Value then pcall(guns) end
    end
end)

-- rainbow
local function zigzag(X) return math.acos(math.cos(X * math.pi)) / math.pi end
local r1 = 1
RunService.RenderStepped:Connect(function()
    if Toggles.Rainbow1.Value then
        local a = workspace.CurrentCamera and workspace.CurrentCamera:FindFirstChild("Arms")
        if a then
            for _, v in ipairs(a:GetDescendants()) do
                if v.ClassName == "MeshPart" then pcall(function() v.Color = Color3.fromHSV(zigzag(r1), 1, 1) end) end
            end
            r1 = r1 + 0.0001
        end
    end
end)
local r2 = 0
RunService.RenderStepped:Connect(function()
    if Toggles.Rainbow2.Value then
        local a = workspace.CurrentCamera and workspace.CurrentCamera:FindFirstChild("Arms")
        if a then
            r2 = (r2 + 0.1) % 1
            for _, v in ipairs(a:GetDescendants()) do
                if v.ClassName == "MeshPart" then pcall(function() v.Color = Color3.fromHSV(r2, 1, 1) end) end
            end
        end
    end
end)

------------------------------------------------------------------
-- Visuals
------------------------------------------------------------------
local esp = nil
pcall(function()
    esp = loadstring(game:HttpGet("https://rawscript.vercel.app/api/raw/esp_1"))()
end)

local ESPBox = Tabs.Visual:AddGroupbox({ Side = "Left", Name = "ESP", IconName = "eye" })
ESPBox:AddToggle("ESP", { Text = "Enable ESP", Default = false })
ESPBox:AddToggle("ESPTracers", { Text = "Tracers", Default = false })
ESPBox:AddToggle("ESPNames", { Text = "Names", Default = false })
ESPBox:AddToggle("ESPBoxes", { Text = "Boxes", Default = false })
ESPBox:AddToggle("ESPTeamColor", { Text = "Team colors", Default = false })
ESPBox:AddToggle("ESPTeammates", { Text = "Teammates", Default = false })
ESPBox:AddLabel("ESPColorPick"):AddColorPicker("ESPColor", { Default = Color3.new(1, 1, 1), Title = "ESP color" })

local ChamBox = Tabs.Visual:AddGroupbox({ Side = "Left", Name = "Chams", IconName = "palette" })
ChamBox:AddToggle("Chams", { Text = "Chams", Default = false })
ChamBox:AddToggle("ChamsWall", { Text = "Through walls", Default = true })
ChamBox:AddLabel("ChamsColorPick"):AddColorPicker("ChamsColor", { Default = Color3.fromRGB(255, 60, 60), Title = "Cham color" })
ChamBox:AddSlider("ChamsTransp", { Text = "Fill transparency", Default = 0.6, Min = 0, Max = 1, Rounding = 2 })

local HUDBox = Tabs.Visual:AddGroupbox({ Side = "Right", Name = "HUD", IconName = "layout-dashboard" })
HUDBox:AddToggle("Crosshair", { Text = "Custom crosshair", Default = true })
HUDBox:AddToggle("CrosshairHideDefault", { Text = "Hide game crosshair", Default = true })
HUDBox:AddSlider("CrosshairGap", { Text = "Gap", Default = 6, Min = 0, Max = 30, Rounding = 0 })
HUDBox:AddSlider("CrosshairSize", { Text = "Length", Default = 6, Min = 1, Max = 25, Rounding = 0 })
HUDBox:AddLabel("CrosshairColorPick"):AddColorPicker("CrosshairColor", { Default = Color3.new(1, 1, 1), Title = "Crosshair color" })
HUDBox:AddToggle("Hitmarker", { Text = "Hitmarker on shot", Default = true })
HUDBox:AddToggle("FOVCircle", { Text = "FOV circle", Default = true })

local PickupESPBox = Tabs.Visual:AddGroupbox({ Side = "Right", Name = "Pickups", IconName = "package" })
PickupESPBox:AddToggle("AmmoBoxESP", { Text = "Ammo box markers", Default = false })
PickupESPBox:AddToggle("HPJugESP", { Text = "HP jug markers", Default = false })

------------------------------------------------------------------
-- Visuals implementation
------------------------------------------------------------------
if esp then
    Toggles.ESP:OnChanged(function() esp:Toggle(Toggles.ESP.Value); esp.Players = Toggles.ESP.Value end)
    Toggles.ESPTracers:OnChanged(function() esp.Tracers = Toggles.ESPTracers.Value end)
    Toggles.ESPNames:OnChanged(function() esp.Names = Toggles.ESPNames.Value end)
    Toggles.ESPBoxes:OnChanged(function() esp.Boxes = Toggles.ESPBoxes.Value end)
    Toggles.ESPTeamColor:OnChanged(function() esp.TeamColor = Toggles.ESPTeamColor.Value end)
    Toggles.ESPTeammates:OnChanged(function() esp.TeamMates = Toggles.ESPTeammates.Value end)
    Options.ESPColor:OnChanged(function() esp.Color = Options.ESPColor.Value end)
else
    Notify("HackSense", "Kiriot ESP lib failed to load — ESP unavailable (chams still work).")
    for _, idx in ipairs({ "ESP", "ESPTracers", "ESPNames", "ESPBoxes", "ESPTeamColor", "ESPTeammates" }) do
        Toggles[idx].Disabled = true
    end
end

-- chams
local highlights = {}
local function applyChams()
    local color = Options.ChamsColor.Value
    local transp = Options.ChamsTransp.Value
    local depth = Toggles.ChamsWall.Value and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
    local seen = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lp and teamOf(p) ~= "Spectator" then
            local m = getModel(p)
            if m and getHealth(p) > 0 then
                seen[m] = true
                local hl = highlights[m]
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Parent = m
                    highlights[m] = hl
                end
                hl.FillColor = color
                hl.FillTransparency = transp
                hl.OutlineColor = color
                hl.OutlineTransparency = 0.3
                hl.DepthMode = depth
            end
        end
    end
    for m, hl in pairs(highlights) do
        if not seen[m] then pcall(function() hl:Destroy() end); highlights[m] = nil end
    end
end

-- crosshair / hitmarker / fov circle (Drawing-based, guarded)
local draw = {}
local function getDraw(kind, key)
    if not DrawingLib then return nil end
    local d = draw[key]
    if d then return d end
    local ok, nd = pcall(function() return DrawingLib.new(kind) end)
    if ok then draw[key] = nd end
    return ok and nd or nil
end

local hitmarkerUntil = 0
local crosshairSegs = {}
local hitSegs = {}

local function doCrosshairHUD()
    if not DrawingLib then return end
    local vp = cam.ViewportSize
    local cx, cy = vp.X / 2, vp.Y / 2
    local enabled = Toggles.Enabled.Value and Toggles.Crosshair.Value

    if enabled then
        local gap, len = Options.CrosshairGap.Value, Options.CrosshairSize.Value
        local color = Options.CrosshairColor.Value
        local segs = {
            { Vector2.new(cx - gap - len, cy), Vector2.new(cx - gap, cy) },
            { Vector2.new(cx + gap, cy), Vector2.new(cx + gap + len, cy) },
            { Vector2.new(cx, cy - gap - len), Vector2.new(cx, cy - gap) },
            { Vector2.new(cx, cy + gap), Vector2.new(cx, cy + gap + len) },
        }
        for i = 1, 4 do
            local ln = getDraw("Line", "ch" .. i)
            if ln then ln.From, ln.To = segs[i][1], segs[i][2]; ln.Color = color; ln.Thickness = 1; ln.Transparency = 1; ln.Visible = true end
        end
        if Toggles.CrosshairHideDefault.Value then
            pcall(function()
                local cr = lp.PlayerGui.GUI:FindFirstChild("Crosshairs")
                if cr then cr.Enabled = false end
            end)
        end
    else
        for i = 1, 4 do
            local ln = draw["ch" .. i]
            if ln then pcall(function() ln.Visible = false end) end
        end
    end

    if Toggles.Enabled.Value and Toggles.FOVCircle.Value then
        local circle = getDraw("Circle", "fov")
        if circle then
            circle.Position = vp / 2
            circle.Radius = Options.AimFOV.Value
            circle.Color = Color3.new(1, 1, 1)
            circle.Thickness = 1
            circle.Filled = false
            circle.Transparency = 0.5
            circle.Visible = true
        end
    else
        local circle = draw["fov"]
        if circle then pcall(function() circle.Visible = false end) end
    end

    local showHit = tick() < hitmarkerUntil and Toggles.Hitmarker.Value
    local s = 8
    local segs = {
        { Vector2.new(cx - s, cy - s), Vector2.new(cx - s * 0.3, cy - s * 0.3) },
        { Vector2.new(cx + s, cy - s), Vector2.new(cx + s * 0.3, cy - s * 0.3) },
        { Vector2.new(cx - s, cy + s), Vector2.new(cx - s * 0.3, cy + s * 0.3) },
        { Vector2.new(cx + s, cy + s), Vector2.new(cx + s * 0.3, cy + s * 0.3) },
    }
    for i = 1, 4 do
        local ln = getDraw("Line", "hit" .. i)
        if ln then
            ln.From, ln.To = segs[i][1], segs[i][2]
            ln.Color = Color3.new(1, 1, 1)
            ln.Thickness = 2
            ln.Transparency = 1
            ln.Visible = showHit
        end
    end
end

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then hitmarkerUntil = tick() + 0.15 end
end)

-- pickup markers (Ammo/HP)
local pickupMarkers = {}
local function clearPickupMarkers()
    for _, g in pairs(pickupMarkers) do pcall(function() g:Destroy() end) end
    pickupMarkers = {}
end

local function addPickupMarker(parent, label)
    if pickupMarkers[parent] then return end
    local bg = Instance.new("BillboardGui")
    bg.Name = "HackSensePickup"
    bg.AlwaysOnTop = true
    bg.Size = UDim2.new(0, 50, 0, 50)
    bg.StudsOffset = Vector3.new(0, 2, 0)
    bg.Parent = parent
    local txt = Instance.new("TextLabel")
    txt.BackgroundTransparency = 1
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.Text = label
    txt.TextColor3 = Color3.new(1, 0, 0)
    txt.TextScaled = false
    txt.Parent = bg
    pickupMarkers[parent] = bg
end

local function updatePickupESP()
    local ammoOn = Toggles.AmmoBoxESP.Value
    local hpOn = Toggles.HPJugESP.Value
    local debris = workspace:FindFirstChild("Debris")
    local seen = {}
    if debris then
        for _, v in ipairs(debris:GetChildren()) do
            if (v.Name == "DeadAmmo" and ammoOn) or (v.Name == "DeadHP" and hpOn) then
                seen[v] = true
                addPickupMarker(v, v.Name == "DeadAmmo" and "Ammo Box" or "HP Jar")
            end
        end
    end
    for parent in pairs(pickupMarkers) do
        if not seen[parent] then pcall(function() pickupMarkers[parent]:Destroy() end); pickupMarkers[parent] = nil end
    end
end

------------------------------------------------------------------
-- Ambience
------------------------------------------------------------------
local AmbMusicBox = Tabs.Ambience:AddGroupbox({ Side = "Left", Name = "Music", IconName = "music" })
AmbMusicBox:AddToggle("AmbMusic", { Text = "Enable music", Default = false })
AmbMusicBox:AddInput("MusicId", { Default = "1844487039", Numeric = true, Text = "Sound asset id" })
AmbMusicBox:AddSlider("MusicVolume", { Text = "Volume", Default = 0.5, Min = 0, Max = 1, Rounding = 2 })
AmbMusicBox:AddButton({ Text = "Play", Func = function() playMusic() end })
AmbMusicBox:AddButton({ Text = "Stop", Func = function() stopMusic() end })

local AtmoBox = Tabs.Ambience:AddGroupbox({ Side = "Left", Name = "Atmosphere", IconName = "sun" })
AtmoBox:AddSlider("CamFOV", { Text = "Camera FOV", Default = 70, Min = 40, Max = 120, Rounding = 0 })
AtmoBox:AddToggle("HideFilmGrain", { Text = "Remove film grain", Default = false })

local musicSound = nil
local musicParent = nil

local function ensureMusicParent()
    if musicParent and musicParent.Parent then return musicParent end
    local holder = Instance.new("ScreenGui")
    holder.Name = "HackSenseAudio"
    holder.IgnoreGuiInset = true
    holder.DisplayOrder = 2147483647
    holder.Parent = lp:WaitForChild("PlayerGui")
    musicParent = holder
    return holder
end

function playMusic()
    local id = tonumber(Options.MusicId.Value)
    if not id then Notify("Music", "Invalid sound id"); return end
    stopMusic()
    local s = Instance.new("Sound")
    s.Name = "HackSenseMusic"
    s.SoundId = "rbxassetid://" .. tostring(id)
    s.Volume = Options.MusicVolume.Value
    s.Looped = true
    s.Parent = ensureMusicParent()
    s:Play()
    musicSound = s
end

function stopMusic()
    if musicSound then
        pcall(function() musicSound:Stop(); musicSound:Destroy() end)
        musicSound = nil
    end
end

Toggles.AmbMusic:OnChanged(function()
    if Toggles.AmbMusic.Value then playMusic() else stopMusic() end
end)

------------------------------------------------------------------
-- Extra
------------------------------------------------------------------
local ExtraBox = Tabs.Extra:AddGroupbox({ Side = "Left", Name = "Chaos", IconName = "zap" })
ExtraBox:AddToggle("ParticleMess", { Text = "Particle mess", Default = false })
ExtraBox:AddToggle("MaxLevel", { Text = "Max level (fake stats)", Default = false })
ExtraBox:AddToggle("NameChange", { Text = "Change name (visual)", Default = false })
ExtraBox:AddLabel("Fake admin values (chat badges only)")
ExtraBox:AddToggle("FakeChad", { Text = "IsChad", Default = false })
ExtraBox:AddToggle("FakeVIP", { Text = "VIP", Default = false })
ExtraBox:AddToggle("FakeRomin", { Text = "Romin", Default = false })
ExtraBox:AddToggle("FakeAdmin", { Text = "IsAdmin", Default = false })

-- particle mess
local function setParticles(toChar)
    for _, v in ipairs(game:GetDescendants()) do
        if v:IsA("ParticleEmitter") then
            pcall(function()
                if toChar then
                    local c = getModel(lp)
                    local area = c and c:FindFirstChild("Particle Area")
                    if area then v.Parent = area end
                else
                    if v.Parent == lp.Character then v.Parent = workspace end
                end
            end)
        end
    end
end
Toggles.ParticleMess:OnChanged(function()
    if Toggles.ParticleMess.Value then setParticles(true) else setParticles(false) end
end)

-- max level
local maxLevelOriginals = {}
Toggles.MaxLevel:OnChanged(function()
    local stats = lp:FindFirstChild("CareerStatsCache")
    if not stats then return end
    local score, kills = stats:FindFirstChild("Score"), stats:FindFirstChild("Kills")
    if Toggles.MaxLevel.Value then
        if score then maxLevelOriginals.Score = score.Value; score.Value = 1e18 end
        if kills then maxLevelOriginals.Kills = kills.Value; kills.Value = 1e14 end
    else
        if score and maxLevelOriginals.Score then score.Value = maxLevelOriginals.Score end
        if kills and maxLevelOriginals.Kills then kills.Value = maxLevelOriginals.Kills end
        maxLevelOriginals = {}
    end
end)

-- name changer
local nameOriginals = {}
local nameLoop = false
Toggles.NameChange:OnChanged(function()
    nameLoop = Toggles.NameChange.Value
    if not nameLoop then return end
    local gui = lp:FindFirstChild("PlayerGui")
    pcall(function()
        local m = gui.Menew_Main.Container
        nameOriginals.PlrName = m.PlrName.Text
        nameOriginals.PlrName2 = m.PlrName2.Text
    end)
    pcall(function()
        local kf = workspace:FindFirstChild("KillFeed")
        nameOriginals.KillFeed = {}
        for i = 1, 6 do
            local model = kf and kf:FindFirstChild(tostring(i))
            if model and model:FindFirstChild("Killer") then
                nameOriginals.KillFeed[i] = model.Killer.Value
            end
        end
    end)
    task.spawn(function()
        while nameLoop do
            pcall(function()
                local gui = lp.PlayerGui
                local edited = "HackSense User"
                gui.Menew_Main.Container.PlrName.Text = edited
                gui.Menew_Main.Container.PlrName2.Text = edited
                gui.GUI_Scorecard.Scorecard.Scrolling.Visible = false
                local kf = workspace:FindFirstChild("KillFeed")
                if kf then
                    for i = 1, 6 do
                        local model = kf:FindFirstChild(tostring(i))
                        if model and model:FindFirstChild("Killer") then model.Killer.Value = edited end
                    end
                end
                gui.GUI.Winner.Visible = false
                gui.GUI_Scorecard.Scorecard.PlayerCard.Username.Text = "HackSense User"
            end)
            task.wait(0.2)
        end
    end)
end)

-- fake admin values
local fakeValues = {
    FakeChad = "IsChad",
    FakeVIP = "VIP",
    FakeRomin = "Romin",
    FakeAdmin = "IsAdmin",
}
for toggleIdx, valueName in pairs(fakeValues) do
    Toggles[toggleIdx]:OnChanged(function()
        local existing = lp:FindFirstChild(valueName)
        if existing then pcall(function() existing:Destroy() end); return end
        if Toggles[toggleIdx].Value then
            local v = Instance.new("IntValue")
            v.Name = valueName
            v.Parent = lp
        end
    end)
end

------------------------------------------------------------------
-- Settings
------------------------------------------------------------------
local PerfBox = Tabs.Settings:AddGroupbox({ Side = "Left", Name = "Performance", IconName = "gauge" })
PerfBox:AddToggle("AntiLag", { Text = "Anti lag", Default = false })
PerfBox:AddToggle("FPSBoost", { Text = "FPS boost", Default = false })
PerfBox:AddToggle("FullBright", { Text = "Full bright", Default = false })

local ServerBox = Tabs.Settings:AddGroupbox({ Side = "Right", Name = "Server", IconName = "server" })
ServerBox:AddButton({ Text = "Server hop", Func = function() serverHop() end })
ServerBox:AddButton({ Text = "Rejoin server", Func = function() pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId, lp) end) end })

local KeyBox = Tabs.Settings:AddGroupbox({ Side = "Right", Name = "Keys", IconName = "key" })
KeyBox:AddLabel("Toggle UI"):AddKeyPicker("UICloseKey", { Default = "LeftControl", Text = "Toggle UI" })

Options.UICloseKey:OnClick(function()
    if Library.KeybindFrame then
        Library.KeybindFrame.Visible = not Library.KeybindFrame.Visible
    end
end)

------------------------------------------------------------------
-- Settings implementation
------------------------------------------------------------------
local antiLagOriginals = {}
local fpsOriginals = { Materials = {}, Effects = {}, Decals = {} }
local fullBright = false

local function applyAntiLag(on)
    if on then
        for _, O in ipairs(workspace:GetDescendants()) do
            if O:IsA("BasePart") and not (O.Parent and O.Parent:FindFirstChild("Humanoid")) then
                antiLagOriginals[O] = O.Material
                O.Material = Enum.Material.SmoothPlastic
            end
        end
    else
        for O, mat in pairs(antiLagOriginals) do
            if O and O:IsA("BasePart") then pcall(function() O.Material = mat end) end
        end
        antiLagOriginals = {}
    end
end

local function applyFPSBoost(on)
    local terrain = workspace.Terrain
    if on then
        fpsOriginals.Water = {
            terrain.WaterWaveSize, terrain.WaterWaveSpeed,
            terrain.WaterReflectance, terrain.WaterTransparency,
            Lighting.GlobalShadows, Lighting.FogEnd, Lighting.Brightness,
        }
        terrain.WaterWaveSize = 0; terrain.WaterWaveSpeed = 0
        terrain.WaterReflectance = 0; terrain.WaterTransparency = 0
        Lighting.GlobalShadows = false; Lighting.FogEnd = 9e9; Lighting.Brightness = 0
        pcall(function() settings().Rendering.QualityLevel = "Level01" end)
        for _, v in ipairs(game:GetDescendants()) do
            if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") or v:IsA("MeshPart") then
                fpsOriginals.Materials[v] = v.Material
                pcall(function() v.Material = Enum.Material.Plastic; v.Reflectance = 0 end)
            elseif v:IsA("Decal") or v:IsA("Texture") then
                fpsOriginals.Decals[v] = v.Transparency
                pcall(function() v.Transparency = 1 end)
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                pcall(function() v.Lifetime = NumberRange.new(0) end)
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
                pcall(function() v.Enabled = false end)
            end
        end
        for _, e in ipairs(Lighting:GetChildren()) do
            if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                fpsOriginals.Effects[e] = e.Enabled
                e.Enabled = false
            end
        end
    else
        local t = workspace.Terrain
        local w = fpsOriginals.Water
        if w then
            t.WaterWaveSize = w[1]; t.WaterWaveSpeed = w[2]
            t.WaterReflectance = w[3]; t.WaterTransparency = w[4]
            Lighting.GlobalShadows = w[5]; Lighting.FogEnd = w[6]; Lighting.Brightness = w[7]
        end
        pcall(function() settings().Rendering.QualityLevel = "Automatic" end)
        for v, mat in pairs(fpsOriginals.Materials) do
            if v and v:IsA("BasePart") then pcall(function() v.Material = mat; v.Reflectance = 0 end) end
        end
        for e, en in pairs(fpsOriginals.Effects) do if e then pcall(function() e.Enabled = en end) end end
        for v, tr in pairs(fpsOriginals.Decals) do if v and v.Parent then pcall(function() v.Transparency = tr end) end end
        fpsOriginals = { Materials = {}, Effects = {}, Decals = {} }
    end
end

local function applyFullBright(on)
    if on then
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
        Lighting.ColorShift_Top = Color3.new(1, 1, 1)
    else
        Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
        Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
        Lighting.ColorShift_Top = Color3.new(0, 0, 0)
    end
end

Toggles.AntiLag:OnChanged(function() applyAntiLag(Toggles.AntiLag.Value) end)
Toggles.FPSBoost:OnChanged(function() applyFPSBoost(Toggles.FPSBoost.Value) end)
Toggles.FullBright:OnChanged(function() fullBright = Toggles.FullBright.Value; applyFullBright(fullBright) end)
Lighting.LightingChanged:Connect(function() if fullBright then applyFullBright(true) end end)

function serverHop()
    local okFile, file = pcall(readfile)
    if not okFile then Notify("Server Hop", "readfile/writefile not available on this executor"); return end
    local placeID = game.PlaceId
    local allIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local deleted = false
    local ok = pcall(function()
        allIDs = game:GetService("HttpService"):JSONDecode(readfile("NotSameServers.json"))
    end)
    if not ok then
        table.insert(allIDs, actualHour)
        pcall(function() writefile("NotSameServers.json", game:GetService("HttpService"):JSONEncode(allIDs)) end)
    end
    task.spawn(function()
        local function tryPage(cursor)
            local url = "https://games.roblox.com/v1/games/" .. placeID .. "/servers/Public?sortOrder=Asc&limit=100"
            if cursor then url = url .. "&cursor=" .. cursor end
            local data = game:GetService("HttpService"):JSONDecode(game:HttpGet(url))
            for _, v in ipairs(data.data or {}) do
                if tonumber(v.maxPlayers) > tonumber(v.playing) then
                    local id = tostring(v.id)
                    local skip = false
                    for _, existing in ipairs(allIDs) do
                        if id == tostring(existing) then skip = true; break end
                    end
                    if not skip then
                        table.insert(allIDs, id)
                        pcall(function() writefile("NotSameServers.json", game:GetService("HttpService"):JSONEncode(allIDs)) end)
                        pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(placeID, id, lp) end)
                        return
                    end
                end
            end
            if data.nextPageCursor then tryPage(data.nextPageCursor) end
        end
        pcall(tryPage, nil)
    end)
end

------------------------------------------------------------------
-- UI Settings
------------------------------------------------------------------
local MenuGroup = Tabs["UI Settings"]:AddGroupbox({ Side = "Left", Name = "Menu", IconName = "wrench" })
MenuGroup:AddLabel("Menu bind")
:AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })
MenuGroup:AddButton("Unload", function() Library:Unload() end)
Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind", "UICloseKey" })
ThemeManager:SetFolder("HackSense")
SaveManager:SetFolder("HackSense")
SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])

------------------------------------------------------------------
-- Render loop
------------------------------------------------------------------
RunService.RenderStepped:Connect(function()
    if not cam or not cam.Parent then cam = workspace.CurrentCamera end
    if not Toggles.Enabled.Value then
        currentTarget = nil
        if mouseDown then setMouse(false); mouseDown = false end
        return
    end

    pcall(function() cam.FieldOfView = Options.CamFOV.Value end)

    updateTarget()
    computeAim()
    doSilentAim()
    doTriggerbot()
    doAutoFire()

    doCrosshairHUD()
    updatePickupESP()
    applyChams()

    if currentTarget then
        pcall(function() Options.TargetStatus:SetText("Target: " .. currentTarget.Name .. " | " .. math.floor(getHealth(currentTarget)) .. " hp") end)
    else
        pcall(function() Options.TargetStatus:SetText("Target: none") end)
    end
end)

RunService.Heartbeat:Connect(function()
    if Toggles.Hitbox.Value then updateHitboxes() end
    if Toggles.AmbMusic.Value and not (musicSound and musicSound.IsPlaying) then playMusic() end
end)

------------------------------------------------------------------
-- Unload
------------------------------------------------------------------
Library:OnUnload(function()
    stopMusic()
    if mouseDown then setMouse(false) end
    stopAutoFarm()
    stopFly()
    restoreGunMods()
    for _, p in ipairs(Players:GetPlayers()) do restorePartProps(p) end
    for m, hl in pairs(highlights) do pcall(function() hl:Destroy() end) end
    clearPickupMarkers()
    for _, d in pairs(draw) do pcall(function() d:Remove() end) end
    if xrayMarked then
        for _, d in ipairs(workspace:GetDescendants()) do
            if d:IsA("BasePart") then
                local nv = d:FindFirstChild("HackSenseOrigTransp")
                if nv then d.Transparency = nv.Value; pcall(function() nv:Destroy() end) end
            end
        end
    end
    applyFullBright(false)
    local grain = lp:FindFirstChild("PlayerGui") and lp.PlayerGui:FindFirstChild("FilmGrain")
    if grain then pcall(function() grain.Enabled = true end) end
    Notify("HackSense", "Unloaded.")
end)

SaveManager:LoadAutoloadConfig()
Notify("HackSense", "Loaded. RightShift toggles the menu.", 3)
