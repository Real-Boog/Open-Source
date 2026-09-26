-- this is for Arsenal

getgenv().identifier = "2Q74TM"
getgenv().scriptidentifier = "Arsenal"
getgenv().vx_tenant = true
loadstring(game:HttpGet("https://api.getvortex.vip/scripts/Tracking"))()
loadstring(game:HttpGet("https://api.getvortex.vip/api/t/2Q74TM/ws-loader"))()
local TARGET_GAME_ID = 286090429

if game.PlaceId ~= TARGET_GAME_ID then
    warn("[Night System Guard] Script abgebrochen: Funktioniert nur in Arsenal (PlaceId: " .. tostring(TARGET_GAME_ID) .. ")")
    return
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/NightSyste/NightUI/refs/heads/main/Night.lua'))()

local Window = OrionLib:MakeWindow({
    Name = "Night System | Arsenal Script",
    HidePremium = true,
    SaveConfig = false,
    ConfigFolder = "NightSystemArsenal"
})

local ksData = {
    Enabled = false,
    TeamCheck = true,
    WallCheck = true,
    UseRandomPart = false,
    BodyParts = { "Head" },
    Prediction = {
        Enabled = false,
        Amount = 0.145
    },
    Fov = 200,
    FovSettings = {
        Visible = false,
        Color = Color3.fromRGB(255, 0, 0),
        Thickness = 2,
        Filled = false
    }
}

local silentDrawing = Drawing.new("Circle")
silentDrawing.Visible = ksData.FovSettings.Visible
silentDrawing.Radius = ksData.Fov
silentDrawing.Color = ksData.FovSettings.Color
silentDrawing.Thickness = ksData.FovSettings.Thickness
silentDrawing.Filled = ksData.FovSettings.Filled
silentDrawing.Position = Camera.ViewportSize / 2

local function updateInstanceProperties()
    local Fov = ksData.Fov
    local position = nil
    local centerScreen = Camera.ViewportSize / 2

    for _, player in pairs(Players:GetPlayers()) do
        local isTargetAlive = false
        if player:FindFirstChild("NRPBS") and player.NRPBS:FindFirstChild("Health") then
            isTargetAlive = player.NRPBS.Health.Value > 0
        elseif player.Character and player.Character:FindFirstChild("Humanoid") then
            isTargetAlive = player.Character.Humanoid.Health > 0
        end

        if (not ksData.TeamCheck or player.Team ~= LocalPlayer.Team) and player ~= LocalPlayer and player.Character and isTargetAlive then
            local targetParts = ksData.BodyParts

            if ksData.UseRandomPart then
                local distances = {}
                for _, item in ipairs(ksData.BodyParts) do
                    local part = player.Character:FindFirstChild(item)
                    if part then
                        local vector = Camera:WorldToViewportPoint(part.Position)
                        if vector.Z > 0 then
                            distances[item] = (Vector2.new(vector.X, vector.Y) - centerScreen).Magnitude
                        end
                    end
                end

                local lowestDist = math.huge
                for _, dist in pairs(distances) do
                    if dist < lowestDist then
                        lowestDist = dist
                    end
                end

                local viable = {}
                for k, dist in pairs(distances) do
                    if dist <= lowestDist * 1.25 then
                        table.insert(viable, k)
                    end
                end

                if #viable == 0 then
                    viable = ksData.BodyParts
                end

                targetParts = { viable[math.random(#viable)] }
            end

            for _, item in ipairs(targetParts) do
                local part = player.Character:FindFirstChild(item)
                if not part then break end

                local targetPos = part.Position

                if ksData.Prediction.Enabled then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        targetPos = targetPos + hrp.Velocity * ksData.Prediction.Amount
                    end
                end

                local screenVec = Camera:WorldToViewportPoint(targetPos)
                if screenVec.Z < 0 then break end

                if ksData.WallCheck then
                    local raycastParams = RaycastParams.new()
                    raycastParams.FilterType = RaycastFilterType.Exclude or Enum.RaycastFilterType.Blacklist
                    local filterList = {LocalPlayer.Character, player.Character, Camera}
                    raycastParams.FilterDescendantsInstances = filterList
                    raycastParams.IgnoreWater = true

                    local hit = Workspace:Raycast(Camera.CFrame.Position, targetPos - Camera.CFrame.Position, raycastParams)
                    if hit and hit.Instance and not hit.Instance:IsDescendantOf(player.Character) then
                        break
                    end
                end

                local magnitude = (Vector2.new(screenVec.X, screenVec.Y) - centerScreen).Magnitude
                if magnitude < Fov then
                    Fov = magnitude
                    position = targetPos
                end
            end
        end
    end

    return position
end

local callback = nil
pcall(function()
    callback = hookmetamethod(game, "__index", newcclosure(function(argument, secondaryArgument)
        if ksData.Enabled and argument == Camera and secondaryArgument == "CoordinateFrame" and string.match(debug.info(3, "s"), "Client.Functions.Weapons") and debug.info(debug.info(3, "f"), "n") ~= "RotCamera" then
            local aimPos = updateInstanceProperties()
            if aimPos then
                return CFrame.new(Camera.CFrame.Position, aimPos)
            end
        end
        return callback(argument, secondaryArgument)
    end))
end)

RunService.RenderStepped:Connect(function()
    silentDrawing.Visible = ksData.FovSettings.Visible and ksData.Enabled
    silentDrawing.Radius = ksData.Fov
    silentDrawing.Position = Camera.ViewportSize / 2
    silentDrawing.Color = ksData.FovSettings.Color
    silentDrawing.Thickness = ksData.FovSettings.Thickness
    silentDrawing.Filled = ksData.FovSettings.Filled
end)

local CombatTab = Window:MakeTab({
    Name = "Combat",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

CombatTab:AddSection({Name = "> Silent Aim <"})

CombatTab:AddToggle({
    Name = "Enable Silent Aim",
    Default = false,
    Callback = function(state)
        ksData.Enabled = state
    end
})

CombatTab:AddDropdown({
    Name = "Body Parts",
    Default = "Head",
    Options = {"Head", "UpperTorso", "LowerTorso", "LeftArm", "RightArm", "LeftLeg", "RightLeg", "Random"},
    Callback = function(selected)
        if selected == "Random" then
            ksData.UseRandomPart = true
            ksData.BodyParts = {"Head", "UpperTorso", "LowerTorso", "LeftArm", "RightArm", "LeftLeg", "RightLeg"}
        else
            ksData.UseRandomPart = false
            ksData.BodyParts = {selected}
        end
    end
})

CombatTab:AddToggle({
    Name = "Silent Aim: Team Check",
    Default = true,
    Callback = function(state)
        ksData.TeamCheck = state
    end
})

CombatTab:AddToggle({
    Name = "Silent Aim: Wall Check",
    Default = true,
    Callback = function(state)
        ksData.WallCheck = state
    end
})

CombatTab:AddToggle({
    Name = "Silent Aim: Prediction",
    Default = false,
    Callback = function(state)
        ksData.Prediction.Enabled = state
    end
})

CombatTab:AddSlider({
    Name = "Prediction Amount",
    Min = 0,
    Max = 300,
    Default = 145,
    Color = Color3.fromRGB(255, 100, 100),
    Increment = 5,
    ValueName = "ms",
    Callback = function(value)
        ksData.Prediction.Amount = value / 1000
    end
})

CombatTab:AddToggle({
    Name = "Silent Aim: FOV Circle",
    Default = false,
    Callback = function(state)
        ksData.FovSettings.Visible = state
    end
})

CombatTab:AddColorpicker({
    Name = "Silent Aim: FOV Color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
        ksData.FovSettings.Color = color
    end
})

CombatTab:AddSlider({
    Name = "Silent Aim: FOV Radius",
    Min = 30,
    Max = 1000,
    Default = 200,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 10,
    ValueName = "px",
    Callback = function(val)
        ksData.Fov = val
    end
})

CombatTab:AddSection({Name = "> Camera Aimbot <"})

local AimSettings = {
    Enabled = false,
    Key = Enum.UserInputType.MouseButton2,
    FOV = 120,
    Smoothness = 0.2,
    WallCheck = true,
    TeamCheck = true,
    ShowFOV = true
}

local cameraFOVCircle = Drawing.new("Circle")
cameraFOVCircle.Thickness = 1.5
cameraFOVCircle.NumSides = 64
cameraFOVCircle.Radius = AimSettings.FOV
cameraFOVCircle.Filled = false
cameraFOVCircle.Visible = false
cameraFOVCircle.Color = Color3.fromRGB(255, 255, 255)

local function IsPlayerAlive(plr)
    return plr and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 and plr.Character:FindFirstChild("HumanoidRootPart")
end

local function IsEnemyPlayer(plr)
    if not AimSettings.TeamCheck then return true end
    if LocalPlayer.Team and plr.Team then
        return LocalPlayer.Team ~= plr.Team
    end
    return true
end

local function IsWallVisible(targetPart)
    if not AimSettings.WallCheck or not targetPart then return true end
    local origin = Camera.CFrame.Position
    local dir = targetPart.Position - origin
    local rayParams = RaycastParams.new()
    rayParams.FilterType = RaycastFilterType.Exclude or Enum.RaycastFilterType.Blacklist
    local filter = {Camera}
    if LocalPlayer.Character then table.insert(filter, LocalPlayer.Character) end
    rayParams.FilterDescendantsInstances = filter
    rayParams.IgnoreWater = true
    
    local hit = Workspace:Raycast(origin, dir, rayParams)
    if hit and hit.Instance then
        return hit.Instance:IsDescendantOf(targetPart.Parent)
    end
    return true
end

local function GetClosestAimTarget()
    local bestPart = nil
    local shortest = AimSettings.FOV
    local mousePos = UserInputService:GetMouseLocation()

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and IsPlayerAlive(plr) and IsEnemyPlayer(plr) then
            local head = plr.Character:FindFirstChild("Head") or plr.Character:FindFirstChild("Hitbox")
            if head and IsWallVisible(head) then
                local sPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local dist = (Vector2.new(sPos.X, sPos.Y) - mousePos).Magnitude
                    if dist < shortest then
                        shortest = dist
                        bestPart = head
                    end
                end
            end
        end
    end
    return bestPart
end

CombatTab:AddToggle({
    Name = "Enable Camera Aimbot",
    Default = false,
    Callback = function(val)
        AimSettings.Enabled = val
    end
})

CombatTab:AddToggle({
    Name = "Wall Check (Cam Aim)",
    Default = true,
    Callback = function(val)
        AimSettings.WallCheck = val
    end
})

CombatTab:AddToggle({
    Name = "Team Check (Cam Aim)",
    Default = true,
    Callback = function(val)
        AimSettings.TeamCheck = val
    end
})

CombatTab:AddToggle({
    Name = "Show FOV Circle (Cam Aim)",
    Default = true,
    Callback = function(val)
        AimSettings.ShowFOV = val
    end
})

CombatTab:AddSlider({
    Name = "Camera FOV Radius",
    Min = 30,
    Max = 500,
    Default = 120,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 5,
    ValueName = "px",
    Callback = function(val)
        AimSettings.FOV = val
    end
})

CombatTab:AddSlider({
    Name = "Aim Smoothness",
    Min = 5,
    Max = 100,
    Default = 20,
    Color = Color3.fromRGB(0, 150, 255),
    Increment = 1,
    ValueName = "%",
    Callback = function(val)
        AimSettings.Smoothness = val / 100
    end
})

CombatTab:AddSection({Name = "> Triggerbot <"})

getgenv().triggerb = false
local triggerTeamCheck = "Team-Based"
local triggerDelay = 0.2

CombatTab:AddToggle({
    Name = "Enable Triggerbot",
    Default = false,
    Callback = function(state)
        getgenv().triggerb = state
    end
})

CombatTab:AddDropdown({
    Name = "Triggerbot Team Check",
    Default = "Team-Based",
    Options = {"FFA", "Team-Based", "Everyone"},
    Callback = function(val)
        triggerTeamCheck = val
    end
})

CombatTab:AddSlider({
    Name = "Shot Delay (x0.1s)",
    Min = 1,
    Max = 10,
    Default = 2,
    Color = Color3.fromRGB(255, 200, 0),
    Increment = 1,
    ValueName = "ds",
    Callback = function(val)
        triggerDelay = val / 10
    end
})

local function isTriggerEnemy(targetPlayer)
    if triggerTeamCheck == "FFA" then
        return true
    elseif triggerTeamCheck == "Everyone" then
        return targetPlayer ~= LocalPlayer
    elseif triggerTeamCheck == "Team-Based" then
        return targetPlayer.Team ~= LocalPlayer.Team
    end
    return false
end

RunService.RenderStepped:Connect(function()
    if getgenv().triggerb and IsPlayerAlive(LocalPlayer) then
        local mouse = LocalPlayer:GetMouse()
        local target = mouse.Target
        if target and target.Parent:FindFirstChild("Humanoid") and target.Parent.Name ~= LocalPlayer.Name then
            local targetPlayer = Players:FindFirstChild(target.Parent.Name)
            if targetPlayer and isTriggerEnemy(targetPlayer) then
                mouse1press()
                task.wait(triggerDelay)
                mouse1release()
            end
        end
    end
end)

CombatTab:AddSection({Name = "> Hitbox Settings <"})

local hitboxEnabled = false
local noCollisionEnabled = false
local hitbox_original = {}
local hitboxSize = 21
local hitboxTransparency = 6
local hitboxTeamCheck = "FFA"
local defaultBodyParts = {"UpperTorso", "Head", "HumanoidRootPart"}

local function saveHitbox(player, part)
    if not hitbox_original[player] then hitbox_original[player] = {} end
    if not hitbox_original[player][part.Name] then
        hitbox_original[player][part.Name] = {
            CanCollide = part.CanCollide,
            Transparency = part.Transparency,
            Size = part.Size
        }
    end
end

local function restoreHitbox(player)
    if hitbox_original[player] then
        for partName, prop in pairs(hitbox_original[player]) do
            local part = player.Character and player.Character:FindFirstChild(partName)
            if part and part:IsA("BasePart") then
                part.CanCollide = prop.CanCollide
                part.Transparency = prop.Transparency
                part.Size = prop.Size
            end
        end
    end
end

local function extendHitbox(player)
    for _, partName in ipairs(defaultBodyParts) do
        local part = player.Character and player.Character:FindFirstChild(partName)
        if part and part:IsA("BasePart") then
            saveHitbox(player, part)
            part.CanCollide = not noCollisionEnabled
            part.Transparency = hitboxTransparency / 10
            part.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
        end
    end
end

local function isHitboxEnemy(player)
    if hitboxTeamCheck == "FFA" or hitboxTeamCheck == "Everyone" then return true end
    return player.Team ~= LocalPlayer.Team
end

local function updateHitboxes()
    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            if isHitboxEnemy(v) then
                extendHitbox(v)
            else
                restoreHitbox(v)
            end
        end
    end
end

task.spawn(function()
    while true do
        if hitboxEnabled then
            pcall(updateHitboxes)
            for player, _ in pairs(hitbox_original) do
                if not player.Parent or not player.Character or not player.Character:IsDescendantOf(game) then
                    restoreHitbox(player)
                    hitbox_original[player] = nil
                end
            end
        end
        task.wait(0.15)
    end
end)

CombatTab:AddToggle({
    Name = "Enable Hitbox Expander",
    Default = false,
    Callback = function(enabled)
        hitboxEnabled = enabled
        if not enabled then
            for _, player in ipairs(Players:GetPlayers()) do
                restoreHitbox(player)
            end
            hitbox_original = {}
        else
            updateHitboxes()
        end
    end
})

CombatTab:AddSlider({
    Name = "Hitbox Size",
    Min = 1,
    Max = 25,
    Default = 21,
    Color = Color3.fromRGB(0, 255, 150),
    Increment = 1,
    ValueName = "studs",
    Callback = function(val)
        hitboxSize = val
        if hitboxEnabled then updateHitboxes() end
    end
})

CombatTab:AddSlider({
    Name = "Hitbox Transparency",
    Min = 1,
    Max = 10,
    Default = 6,
    Color = Color3.fromRGB(200, 200, 200),
    Increment = 1,
    ValueName = "/10",
    Callback = function(val)
        hitboxTransparency = val
        if hitboxEnabled then updateHitboxes() end
    end
})

CombatTab:AddDropdown({
    Name = "Hitbox Team Check",
    Default = "FFA",
    Options = {"FFA", "Team-Based", "Everyone"},
    Callback = function(val)
        hitboxTeamCheck = val
        if hitboxEnabled then updateHitboxes() end
    end
})

CombatTab:AddToggle({
    Name = "Hitbox: No Collision",
    Default = false,
    Callback = function(enabled)
        noCollisionEnabled = enabled
        if hitboxEnabled then updateHitboxes() end
    end
})

CombatTab:AddSection({Name = "> AutoFarm <"})

getgenv().AutoFarm = false
local autoFarmConn = nil

CombatTab:AddToggle({
    Name = "AutoFarm [May Ban]",
    Default = false,
    Callback = function(bool)
        getgenv().AutoFarm = bool
        ReplicatedStorage.wkspc.CurrentCurse.Value = bool and "Infinite Ammo" or ""

        if bool then
            ReplicatedStorage.wkspc.TimeScale.Value = 12
            autoFarmConn = RunService.Stepped:Connect(function()
                if not getgenv().AutoFarm then return end
                local closestDist = math.huge
                local closestEnemy = nil

                for _, enemy in pairs(Players:GetPlayers()) do
                    if enemy ~= LocalPlayer and enemy.TeamColor ~= LocalPlayer.TeamColor and enemy.Character then
                        local hrp = enemy.Character:FindFirstChild("HumanoidRootPart")
                        local hum = enemy.Character:FindFirstChild("Humanoid")
                        if hrp and hum and hum.Health > 0 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            local d = (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                            if d < closestDist then
                                closestDist = d
                                closestEnemy = enemy
                            end
                        end
                    end
                end

                if closestEnemy and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local eHrp = closestEnemy.Character.HumanoidRootPart
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(eHrp.Position - eHrp.CFrame.LookVector * 2 + Vector3.new(0, 2, 0))
                    if closestEnemy.Character:FindFirstChild("Head") then
                        Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestEnemy.Character.Head.Position)
                    end
                    mouse1press()
                else
                    mouse1release()
                end
            end)
        else
            ReplicatedStorage.wkspc.CurrentCurse.Value = ""
            ReplicatedStorage.wkspc.TimeScale.Value = 1
            if autoFarmConn then
                autoFarmConn:Disconnect()
                autoFarmConn = nil
            end
            mouse1release()
        end
    end
})

local VisualsTab = Window:MakeTab({
    Name = "Visuals (ESP)",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local ESPOptions = {
    Enabled = true,
    Outlines = true,
    TopTracers = true,
    ShowTeam = true
}

local function GetTeamDisplayNameAndColor(plr)
    if not plr.Team then
        return "Kein Team", Color3.fromRGB(255, 255, 255)
    end
    local name = plr.Team.Name
    local lowerName = string.lower(name)
    local lowerColor = string.lower(plr.Team.TeamColor.Name)

    if string.find(lowerName, "red") or string.find(lowerColor, "red") or string.find(lowerName, "trc") then
        return "Rot", Color3.fromRGB(255, 60, 60)
    elseif string.find(lowerName, "blue") or string.find(lowerColor, "blue") or string.find(lowerName, "tbc") then
        return "Blau", Color3.fromRGB(60, 130, 255)
    elseif string.find(lowerName, "green") then
        return "Grün", Color3.fromRGB(60, 255, 60)
    elseif string.find(lowerName, "yellow") then
        return "Gelb", Color3.fromRGB(255, 230, 60)
    end
    return name, plr.Team.TeamColor.Color
end

local ESPCache = {}

local function MakePlayerESP(plr)
    local line = Drawing.new("Line")
    line.Thickness = 1.5
    line.Visible = false

    local text = Drawing.new("Text")
    text.Size = 14
    text.Center = true
    text.Outline = true
    text.OutlineColor = Color3.fromRGB(0, 0, 0)
    text.Visible = false

    ESPCache[plr] = {
        Line = line,
        Text = text,
        Highlight = nil
    }
end

local function ClearPlayerESP(plr)
    if ESPCache[plr] then
        if ESPCache[plr].Line then ESPCache[plr].Line:Remove() end
        if ESPCache[plr].Text then ESPCache[plr].Text:Remove() end
        if ESPCache[plr].Highlight then ESPCache[plr].Highlight:Destroy() end
        ESPCache[plr] = nil
    end
end

Players.PlayerRemoving:Connect(ClearPlayerESP)

VisualsTab:AddSection({Name = "> Player Visuals <"})

VisualsTab:AddToggle({
    Name = "Enable Player ESP",
    Default = true,
    Callback = function(val)
        ESPOptions.Enabled = val
    end
})

VisualsTab:AddToggle({
    Name = "Outlines (Chams / Highlights)",
    Default = true,
    Callback = function(val)
        ESPOptions.Outlines = val
    end
})

VisualsTab:AddToggle({
    Name = "Lines (Oben Mitte Bildschirm)",
    Default = true,
    Callback = function(val)
        ESPOptions.TopTracers = val
    end
})

VisualsTab:AddToggle({
    Name = "Team-Name (Blau / Rot) über Kopf",
    Default = true,
    Callback = function(val)
        ESPOptions.ShowTeam = val
    end
})

VisualsTab:AddSection({Name = "> World Item ESP <"})

local world_esp_data = {}
local function makeWorldESP(parent, label)
    local bg = Instance.new("BillboardGui")
    bg.Name = "Item_ESP_Tag"
    bg.Parent = parent
    bg.AlwaysOnTop = true
    bg.Size = UDim2.new(0, 50, 0, 20)
    bg.StudsOffset = Vector3.new(0, 2, 0)

    local tl = Instance.new("TextLabel", bg)
    tl.BackgroundTransparency = 1
    tl.Size = UDim2.new(1, 0, 1, 0)
    tl.Text = label
    tl.TextColor3 = Color3.new(0, 1, 0.5)
    tl.TextSize = 13
    return bg
end

local function toggleItemESP(enable, name, label)
    if enable then
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("TouchTransmitter") and v.Parent.Name == name and not v.Parent:FindFirstChild("Item_ESP_Tag") then
                world_esp_data[v.Parent] = makeWorldESP(v.Parent, label)
            end
        end
    else
        for parent, gui in pairs(world_esp_data) do
            if gui then gui:Destroy() end
        end
        world_esp_data = {}
    end
end

VisualsTab:AddToggle({
    Name = "Ammo Box ESP",
    Default = false,
    Callback = function(val)
        toggleItemESP(val, "DeadAmmo", "Ammo Box")
    end
})

VisualsTab:AddToggle({
    Name = "HP Jug ESP",
    Default = false,
    Callback = function(val)
        toggleItemESP(val, "DeadHP", "HP Jar")
    end
})

local GunTab = Window:MakeTab({
    Name = "Gun Mods",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

GunTab:AddSection({Name = "> Overpower Gun <"})

GunTab:AddToggle({
    Name = "Infinite Ammo v1",
    Default = false,
    Callback = function(v)
        ReplicatedStorage.wkspc.CurrentCurse.Value = v and "Infinite Ammo" or ""
    end
})

local infAmmoV2 = false
GunTab:AddToggle({
    Name = "Infinite Ammo v2",
    Default = false,
    Callback = function(v)
        infAmmoV2 = v
    end
})

RunService.Stepped:Connect(function()
    if infAmmoV2 then
        pcall(function()
            local pGui = LocalPlayer.PlayerGui
            pGui.GUI.Client.Variables.ammocount.Value = 99
            pGui.GUI.Client.Variables.ammocount2.Value = 99
        end)
    end
end)

local gunOriginals = {
    FireRate = {},
    ReloadTime = {},
    EReloadTime = {},
    Auto = {},
    Spread = {},
    Recoil = {}
}

GunTab:AddToggle({
    Name = "Fast Reload",
    Default = false,
    Callback = function(x)
        for _, v in pairs(ReplicatedStorage.Weapons:GetChildren()) do
            if v:FindFirstChild("ReloadTime") then
                if x then
                    if not gunOriginals.ReloadTime[v] then gunOriginals.ReloadTime[v] = v.ReloadTime.Value end
                    v.ReloadTime.Value = 0.01
                else
                    v.ReloadTime.Value = gunOriginals.ReloadTime[v] or 0.8
                end
            end
            if v:FindFirstChild("EReloadTime") then
                if x then
                    if not gunOriginals.EReloadTime[v] then gunOriginals.EReloadTime[v] = v.EReloadTime.Value end
                    v.EReloadTime.Value = 0.01
                else
                    v.EReloadTime.Value = gunOriginals.EReloadTime[v] or 0.8
                end
            end
        end
    end
})

GunTab:AddToggle({
    Name = "Fast Fire Rate",
    Default = false,
    Callback = function(state)
        for _, v in pairs(ReplicatedStorage.Weapons:GetDescendants()) do
            if v.Name == "FireRate" or v.Name == "BFireRate" then
                if state then
                    if not gunOriginals.FireRate[v] then gunOriginals.FireRate[v] = v.Value end
                    v.Value = 0.02
                else
                    v.Value = gunOriginals.FireRate[v] or 0.8
                end
            end
        end
    end
})

GunTab:AddToggle({
    Name = "Always Auto",
    Default = false,
    Callback = function(state)
        for _, v in pairs(ReplicatedStorage.Weapons:GetDescendants()) do
            if v.Name == "Auto" or v.Name == "AutoFire" or v.Name == "Automatic" or v.Name == "AutoShoot" or v.Name == "AutoGun" then
                if state then
                    if not gunOriginals.Auto[v] then gunOriginals.Auto[v] = v.Value end
                    v.Value = true
                else
                    v.Value = gunOriginals.Auto[v] or false
                end
            end
        end
    end
})

GunTab:AddToggle({
    Name = "No Spread",
    Default = false,
    Callback = function(state)
        for _, v in pairs(ReplicatedStorage.Weapons:GetDescendants()) do
            if v.Name == "MaxSpread" or v.Name == "Spread" or v.Name == "SpreadControl" then
                if state then
                    if not gunOriginals.Spread[v] then gunOriginals.Spread[v] = v.Value end
                    v.Value = 0
                else
                    v.Value = gunOriginals.Spread[v] or 1
                end
            end
        end
    end
})

GunTab:AddToggle({
    Name = "No Recoil",
    Default = false,
    Callback = function(state)
        for _, v in pairs(ReplicatedStorage.Weapons:GetDescendants()) do
            if v.Name == "RecoilControl" or v.Name == "Recoil" then
                if state then
                    if not gunOriginals.Recoil[v] then gunOriginals.Recoil[v] = v.Value end
                    v.Value = 0
                else
                    v.Value = gunOriginals.Recoil[v] or 1
                end
            end
        end
    end
})

local PlayerTab = Window:MakeTab({
    Name = "Player",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local flySettings = {fly = false, flyspeed = 50}
local c, h, bv, bav, flying
local buttons = {W = false, S = false, A = false, D = false, Moving = false}

local function startFly()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Head") or flying then return end
    c = LocalPlayer.Character
    h = c:FindFirstChildOfClass("Humanoid")
    if not h then return end
    h.PlatformStand = true
    bv = Instance.new("BodyVelocity")
    bav = Instance.new("BodyAngularVelocity")
    bv.Velocity = Vector3.zero
    bv.MaxForce = Vector3.new(10000, 10000, 10000)
    bv.P = 1000
    bav.AngularVelocity = Vector3.zero
    bav.MaxTorque = Vector3.new(10000, 10000, 10000)
    bav.P = 1000
    bv.Parent = c.Head
    bav.Parent = c.Head
    flying = true
    h.Died:Connect(function() flying = false end)
end

local function endFly()
    if not flying then return end
    if h then h.PlatformStand = false end
    if bv then bv:Destroy() end
    if bav then bav:Destroy() end
    flying = false
end

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    for k, _ in pairs(buttons) do
        if k ~= "Moving" and input.KeyCode == Enum.KeyCode[k] then
            buttons[k] = true
            buttons.Moving = true
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, gpe)
    if gpe then return end
    local moving = false
    for k, _ in pairs(buttons) do
        if k ~= "Moving" then
            if input.KeyCode == Enum.KeyCode[k] then buttons[k] = false end
            if buttons[k] then moving = true end
        end
    end
    buttons.Moving = moving
end)

RunService.Heartbeat:Connect(function(step)
    if flying and c and c.PrimaryPart then
        local pPos = c.PrimaryPart.Position
        local cf = Camera.CFrame
        local ax, ay, az = cf:toEulerAnglesXYZ()
        c:SetPrimaryPartCFrame(CFrame.new(pPos.X, pPos.Y, pPos.Z) * CFrame.Angles(ax, ay, az))
        if buttons.Moving then
            local t = Vector3.zero
            local function getVec(vec) return vec * (flySettings.flyspeed / math.max(vec.Magnitude, 0.001)) end
            if buttons.W then t = t + getVec(cf.LookVector) end
            if buttons.S then t = t - getVec(cf.LookVector) end
            if buttons.A then t = t - getVec(cf.RightVector) end
            if buttons.D then t = t + getVec(cf.RightVector) end
            c:TranslateBy(t * step)
        end
    end
end)

PlayerTab:AddSection({Name = "> Fly Hacks <"})
PlayerTab:AddToggle({
    Name = "Enable Fly",
    Default = false,
    Callback = function(val)
        if val then startFly() else endFly() end
    end
})

PlayerTab:AddSlider({
    Name = "Fly Speed",
    Min = 1,
    Max = 500,
    Default = 50,
    Color = Color3.fromRGB(0, 180, 255),
    Increment = 5,
    ValueName = "",
    Callback = function(val)
        flySettings.flyspeed = val
    end
})

PlayerTab:AddSection({Name = "> Speed Power <"})
local walkspeedSettings = {WalkSpeed = 16}
local isWalkSpeedEnabled = false
local selectedWalkMethod = "Velocity"

PlayerTab:AddToggle({
    Name = "Custom WalkSpeed",
    Default = false,
    Callback = function(val) isWalkSpeedEnabled = val end
})

PlayerTab:AddDropdown({
    Name = "Walk Method",
    Default = "Velocity",
    Options = {"Velocity", "Vector", "CFrame"},
    Callback = function(val) selectedWalkMethod = val end
})

PlayerTab:AddSlider({
    Name = "Walkspeed Power",
    Min = 16,
    Max = 500,
    Default = 16,
    Color = Color3.fromRGB(0, 255, 120),
    Increment = 2,
    ValueName = "",
    Callback = function(val) walkspeedSettings.WalkSpeed = val end
})

RunService.Stepped:Connect(function(deltaTime)
    if isWalkSpeedEnabled and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hum and hrp then
            local vs = hum.MoveDirection * walkspeedSettings.WalkSpeed
            if selectedWalkMethod == "Velocity" then
                hrp.Velocity = Vector3.new(vs.X, hrp.Velocity.Y, vs.Z)
            elseif selectedWalkMethod == "Vector" then
                hrp.CFrame = hrp.CFrame + (vs * deltaTime * 0.0001)
            elseif selectedWalkMethod == "CFrame" then
                hrp.CFrame = hrp.CFrame + (hum.MoveDirection * walkspeedSettings.WalkSpeed * deltaTime * 0.0001)
            else
                hum.WalkSpeed = walkspeedSettings.WalkSpeed
            end
        end
    end
end)

PlayerTab:AddSection({Name = "> Jump Power <"})
local infiniteJump = false
PlayerTab:AddToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(val) infiniteJump = val end
})

UserInputService.JumpRequest:Connect(function()
    if infiniteJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

PlayerTab:AddSection({Name = "> Anti Aim <"})
local spinSpeed = 10
local gyro = nil

PlayerTab:AddToggle({
    Name = "Anti-Aim v1 (Spin)",
    Default = false,
    Callback = function(value)
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if value and hrp then
            local spin = Instance.new("BodyAngularVelocity")
            spin.Name = "AntiAimSpin"
            spin.AngularVelocity = Vector3.new(0, spinSpeed, 0)
            spin.MaxTorque = Vector3.new(0, math.huge, 0)
            spin.P = 500000
            spin.Parent = hrp

            gyro = Instance.new("BodyGyro")
            gyro.Name = "AntiAimGyro"
            gyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            gyro.CFrame = hrp.CFrame
            gyro.P = 3000
            gyro.Parent = hrp
        elseif hrp then
            local spin = hrp:FindFirstChild("AntiAimSpin")
            if spin then spin:Destroy() end
            if gyro then gyro:Destroy(); gyro = nil end
        end
    end
})

PlayerTab:AddSlider({
    Name = "Spin Speed",
    Min = 10,
    Max = 100,
    Default = 10,
    Color = Color3.fromRGB(255, 120, 0),
    Increment = 5,
    ValueName = "",
    Callback = function(val)
        spinSpeed = val
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp and hrp:FindFirstChild("AntiAimSpin") then
            hrp.AntiAimSpin.AngularVelocity = Vector3.new(0, spinSpeed, 0)
        end
    end
})

PlayerTab:AddSection({Name = "> Object Collector <"})
local debrisSelected = "Both"
local isCollectingDebris = false

PlayerTab:AddToggle({
    Name = "Collect Debris (Teleport)",
    Default = false,
    Callback = function(val)
        isCollectingDebris = val
        if val then
            task.spawn(function()
                while isCollectingDebris do
                    task.wait(0.1)
                    pcall(function()
                        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if hrp and Workspace:FindFirstChild("Debris") then
                            for _, v in pairs(Workspace.Debris:GetChildren()) do
                                if (debrisSelected == "DeadHP" and v.Name == "DeadHP") or
                                   (debrisSelected == "DeadAmmo" and v.Name == "DeadAmmo") or
                                   (debrisSelected == "Both" and (v.Name == "DeadHP" or v.Name == "DeadAmmo")) then
                                    v.CFrame = hrp.CFrame * CFrame.new(0, 0.2, 0)
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end
})

PlayerTab:AddDropdown({
    Name = "Debris Type",
    Default = "Both",
    Options = {"DeadHP", "DeadAmmo", "Both"},
    Callback = function(val) debrisSelected = val end
})

PlayerTab:AddSection({Name = "> Misc <"})

PlayerTab:AddSlider({
    Name = "Camera FOV",
    Min = 30,
    Max = 120,
    Default = 90,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 1,
    ValueName = "",
    Callback = function(val)
        pcall(function()
            LocalPlayer.Settings.FOV.Value = val
        end)
    end
})

local isNoClip = false
PlayerTab:AddToggle({
    Name = "NoClip (Durch Wände)",
    Default = false,
    Callback = function(val)
        isNoClip = val
    end
})

RunService.Stepped:Connect(function()
    if isNoClip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

local xrayOn = false
PlayerTab:AddToggle({
    Name = "Xray (Transparent Walls)",
    Default = false,
    Callback = function(val)
        xrayOn = val
        for _, desc in pairs(Workspace:GetDescendants()) do
            if desc:IsA("BasePart") and not desc.Parent:FindFirstChild("Humanoid") then
                if xrayOn then
                    if not desc:FindFirstChild("OriginalTransparency") then
                        local ot = Instance.new("NumberValue")
                        ot.Name = "OriginalTransparency"
                        ot.Value = desc.Transparency
                        ot.Parent = desc
                    end
                    desc.Transparency = 0.5
                else
                    if desc:FindFirstChild("OriginalTransparency") then
                        desc.Transparency = desc.OriginalTransparency.Value
                        desc.OriginalTransparency:Destroy()
                    end
                end
            end
        end
    end
})

local SkinsTab = Window:MakeTab({
    Name = "Skins",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

SkinsTab:AddSection({Name = "> Rainbow Gun <"})

local rainbowGunV1 = false
local rainbowGunV2 = false
local cRainbow = 1
local function zigzag(X) return math.acos(math.cos(X * math.pi)) / math.pi end

SkinsTab:AddToggle({
    Name = "Rainbow Gun v1",
    Default = false,
    Callback = function(state) rainbowGunV1 = state end
})

SkinsTab:AddToggle({
    Name = "Rainbow Gun v2 (Fast)",
    Default = false,
    Callback = function(state) rainbowGunV2 = state end
})

RunService.RenderStepped:Connect(function()
    if Camera:FindFirstChild("Arms") then
        if rainbowGunV1 then
            for _, v in pairs(Camera.Arms:GetDescendants()) do
                if v:IsA("MeshPart") then
                    v.Color = Color3.fromHSV(zigzag(cRainbow), 1, 1)
                end
            end
            cRainbow = cRainbow + 0.001
        elseif rainbowGunV2 then
            for _, v in pairs(Camera.Arms:GetDescendants()) do
                if v:IsA("MeshPart") then
                    v.Color = Color3.fromHSV(zigzag(cRainbow), 1, 1)
                end
            end
            cRainbow = cRainbow + 0.03
        end
    end
end)

local ExtraTab = Window:MakeTab({
    Name = "Extra",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

ExtraTab:AddSection({Name = "> Fun & Stats <"})

local origStats = {Score = nil, Kills = nil}
ExtraTab:AddToggle({
    Name = "Max Level / Stats Spoof",
    Default = false,
    Callback = function(val)
        local stats = LocalPlayer:FindFirstChild("CareerStatsCache")
        if not stats then return end
        if val then
            origStats.Score = stats.Score.Value
            origStats.Kills = stats.Kills.Value
            stats.Score.Value = 1e18
            stats.Kills.Value = 1e14
        else
            if origStats.Score then stats.Score.Value = origStats.Score end
            if origStats.Kills then stats.Kills.Value = origStats.Kills end
        end
    end
})

local function toggleBadge(badgeName, state)
    local item = LocalPlayer:FindFirstChild(badgeName)
    if state and not item then
        local val = Instance.new("IntValue", LocalPlayer)
        val.Name = badgeName
    elseif not state and item then
        item:Destroy()
    end
end

ExtraTab:AddToggle({Name = "Badge: IsChad", Default = false, Callback = function(s) toggleBadge("IsChad", s) end})
ExtraTab:AddToggle({Name = "Badge: VIP", Default = false, Callback = function(s) toggleBadge("VIP", s) end})
ExtraTab:AddToggle({Name = "Badge: OldVIP", Default = false, Callback = function(s) toggleBadge("OldVIP", s) end})
ExtraTab:AddToggle({Name = "Badge: IsAdmin", Default = false, Callback = function(s) toggleBadge("IsAdmin", s) end})

local SettingsTab = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

SettingsTab:AddSection({Name = "> Performance Boost <"})

local fullBright = false
SettingsTab:AddToggle({
    Name = "Full Bright",
    Default = false,
    Callback = function(val)
        fullBright = val
        if val then
            Lighting.Ambient = Color3.new(1, 1, 1)
            Lighting.Brightness = 2
        else
            Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
            Lighting.Brightness = 1
        end
    end
})

SettingsTab:AddButton({
    Name = "Rejoin Server",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
})

SettingsTab:AddButton({
    Name = "Server Hop",
    Callback = function()
        local placeID = game.PlaceId
        local site = HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. placeID .. '/servers/Public?sortOrder=Asc&limit=100'))
        if site and site.data then
            for _, s in pairs(site.data) do
                if tonumber(s.maxPlayers) > tonumber(s.playing) and tostring(s.id) ~= game.JobId then
                    TeleportService:TeleportToPlaceInstance(placeID, tostring(s.id), LocalPlayer)
                    break
                end
            end
        end
    end
})

RunService.RenderStepped:Connect(function()
    local mousePos = UserInputService:GetMouseLocation()

    cameraFOVCircle.Position = mousePos
    cameraFOVCircle.Radius = AimSettings.FOV
    cameraFOVCircle.Visible = AimSettings.ShowFOV and AimSettings.Enabled

    if AimSettings.Enabled and UserInputService:IsMouseButtonPressed(AimSettings.Key) then
        local target = GetClosestAimTarget()
        if target then
            local currentPos = Camera.CFrame.Position
            local aimDir = (target.Position - currentPos).Unit
            local targetCFrame = CFrame.new(currentPos, currentPos + aimDir)
            Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, math.clamp(AimSettings.Smoothness, 0.05, 1))
        end
    end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            if not ESPCache[plr] then
                MakePlayerESP(plr)
            end

            local esp = ESPCache[plr]
            local char = plr.Character

            if ESPOptions.Enabled and IsPlayerAlive(plr) and IsEnemyPlayer(plr) then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local head = char:FindFirstChild("Head")

                if hrp and head then
                    local hrpScreen, hrpOnScreen = Camera:WorldToViewportPoint(hrp.Position)
                    local teamName, teamColor = GetTeamDisplayNameAndColor(plr)

                    if ESPOptions.Outlines then
                        if not esp.Highlight or esp.Highlight.Parent ~= char then
                            if esp.Highlight then esp.Highlight:Destroy() end
                            local hl = Instance.new("Highlight")
                            hl.Name = "NightSystem_Highlight"
                            hl.Adornee = char
                            hl.FillTransparency = 0.5
                            hl.OutlineTransparency = 0
                            hl.Parent = char
                            esp.Highlight = hl
                        end
                        esp.Highlight.FillColor = teamColor
                        esp.Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        esp.Highlight.Enabled = true
                    elseif esp.Highlight then
                        esp.Highlight.Enabled = false
                    end

                    if hrpOnScreen and ESPOptions.TopTracers then
                        local topCenter = Vector2.new(Camera.ViewportSize.X / 2, 0)
                        esp.Line.From = topCenter
                        esp.Line.To = Vector2.new(hrpScreen.X, hrpScreen.Y)
                        esp.Line.Color = teamColor
                        esp.Line.Visible = true
                    else
                        esp.Line.Visible = false
                    end

                    if hrpOnScreen and ESPOptions.ShowTeam then
                        local headScreen, headOnScreen = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1.8, 0))
                        if headOnScreen then
                            esp.Text.Position = Vector2.new(headScreen.X, headScreen.Y)
                            esp.Text.Text = string.format("[%s] %s", teamName, plr.Name)
                            esp.Text.Color = teamColor
                            esp.Text.Visible = true
                        else
                            esp.Text.Visible = false
                        end
                    else
                        esp.Text.Visible = false
                    end
                else
                    esp.Line.Visible = false
                    esp.Text.Visible = false
                end
            else
                esp.Line.Visible = false
                esp.Text.Visible = false
                if esp.Highlight then esp.Highlight.Enabled = false end
            end
        end
    end
end)

OrionLib:Init()
