-- Obsidian UI Library
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

local Window = Library:CreateWindow({
    Title = "HackSense",
    Footer = "version: 1.0",
    Icon = 95816097006870,
    NotifySide = "Right",
    ShowCustomCursor = true,
})

local Tabs = {
    Hitbox    = Window:AddTab("Hitbox", "box"),
    Aimbot    = Window:AddTab("Aimbot", "crosshair"),
    Player    = Window:AddTab("Player", "user"),
    Spinbot   = Window:AddTab("Spinbot", "rotate-cw"),
    Visuals   = Window:AddTab("Visuals", "eye"),
    Teleport  = Window:AddTab("Teleport", "map-pin"),
    Crosshair = Window:AddTab("Crosshair", "plus"),
    Credits   = Window:AddTab("Credits", "heart"),
    ["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}

------------------------------------------------------------
-- State variables
------------------------------------------------------------
local hitbox_on = false
local no_collide = false
local og_props = {}
local hitbox_size = 21
local hitbox_alpha = 0.6
local team_check = "Everyone"
local body_parts = {"UpperTorso", "Head", "HumanoidRootPart"}

local ws_on = false
local walk_methods = {"Vector", "CFrame"}
local walk_method = walk_methods[1]
local settings = {WalkSpeed = 16, JumpPower = 50}
local IJ = false
local jp_on = false

local fly_on = false
local fly_speed = 100
local fly_smooth = 0.3

local spin_on = false
local spin_speed = 30
local spin_angle = 0
local last_spin = tick()

local character = player.Character or player.CharacterAdded:Wait()
local humanoid_root_part = character:WaitForChild("HumanoidRootPart")

local locations = {
    ["Safezone"] = Vector3.new(141.2, 142.1, -311.8),
    ["Refill Ammo Safezone"] = Vector3.new(141.3, 144.7, -294.6),
    ["Safezone Vest"] = Vector3.new(134.7, 145.1, -297.7),
    ["Gas Station Refill Ammo"] = Vector3.new(125.2, 142.5, -11.6)
}

local function teleport(pos)
    if humanoid_root_part then
        humanoid_root_part.CFrame = CFrame.new(pos)
    end
end

player.CharacterAdded:Connect(function(new_char)
    character = new_char
    humanoid_root_part = character:WaitForChild("HumanoidRootPart")
    setclipboard("https://discord.gg/efrvtA2HAx")
end)

local function start_fly()
    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    local root = char:WaitForChild("HumanoidRootPart")
    local cam = Workspace.CurrentCamera
    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    hum:ChangeState(Enum.HumanoidStateType.Swimming)
    local pos = root.Position
    local conn
    conn = RunService.RenderStepped:Connect(function(dt)
        if not fly_on then
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            conn:Disconnect()
            return
        end
        root.Velocity = Vector3.new(root.Velocity.X, 0, root.Velocity.Z)
        local dir = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.new(0, 1, 0) end
        if dir.Magnitude > 0 then dir = dir.Unit end
        local target = pos + (dir * fly_speed * dt)
        root.CFrame = root.CFrame:Lerp(CFrame.new(target, target + cam.CFrame.LookVector), fly_smooth)
        pos = root.Position
    end)
end

local function save_props(plr, part)
    if not og_props[plr] then og_props[plr] = {} end
    if not og_props[plr][part.Name] then
        og_props[plr][part.Name] = {
            CanCollide = part.CanCollide,
            Transparency = part.Transparency,
            Size = part.Size
        }
    end
end

local function restore_props(plr)
    if og_props[plr] then
        for name, props in pairs(og_props[plr]) do
            local part = plr.Character and plr.Character:FindFirstChild(name)
            if part and part:IsA("BasePart") then
                part.CanCollide = props.CanCollide
                part.Transparency = props.Transparency
                part.Size = props.Size
            end
        end
    end
end

local function extend_hitbox(plr)
    for _, name in ipairs(body_parts) do
        local part = plr.Character and plr.Character:FindFirstChild(name)
        if part and part:IsA("BasePart") then
            save_props(plr, part)
            part.CanCollide = not no_collide
            part.Transparency = math.clamp(hitbox_alpha, 0, 1)
            part.Size = Vector3.new(hitbox_size, hitbox_size, hitbox_size)
        end
    end
end

local function is_enemy(plr)
    if team_check == "FFA" or team_check == "Everyone" then return true end
    return plr.Team ~= player.Team
end

local function should_extend(plr)
    if team_check == "Everyone" or team_check == "FFA" then return true end
    return is_enemy(plr)
end

local function update_hitboxes()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            if should_extend(plr) then
                extend_hitbox(plr)
            else
                restore_props(plr)
            end
        end
    end
end

local function cleanup_props()
    for plr in pairs(og_props) do
        if not plr.Parent or not plr.Character or not plr.Character:IsDescendantOf(game) then
            restore_props(plr)
            og_props[plr] = nil
        end
    end
end

local function handle_move(dt)
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not hum or not root then return end
    if ws_on then
        local dir = hum.MoveDirection
        if dir.Magnitude > 0 then
            local amt = dir.Unit * settings.WalkSpeed * dt
            if walk_method == "Vector" then
                root.CFrame = root.CFrame + amt
            else
                root.CFrame = root.CFrame:Lerp(root.CFrame + amt, 0.5)
            end
        end
    end
    if (IJ or jp_on) and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        local h = settings.JumpPower / 3 * dt * 60
        local target = root.Position + Vector3.new(0, h, 0)
        root.CFrame = root.CFrame:Lerp(CFrame.new(target, target + root.CFrame.LookVector), 0.2)
    end
end
RunService.RenderStepped:Connect(handle_move)

local function find_rot_part(char)
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart")
        or char:FindFirstChild("RootPart")
        or char:FindFirstChild("UpperTorso")
        or char:FindFirstChild("Torso")
        or char:FindFirstChild("LowerTorso")
end

local function do_spin(char, dt)
    if not spin_on then return end
    local now = tick()
    local real_dt = now - last_spin
    last_spin = now
    real_dt = math.min(real_dt, 1 / 30)
    spin_angle = spin_angle + math.rad(spin_speed) * real_dt * 60
    local part = find_rot_part(char)
    if part then
        part.CFrame = CFrame.new(part.Position) * CFrame.Angles(0, spin_angle, 0)
    end
end

local function reset_spin(char)
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            repeat task.wait() until hum.Health > 0
            spin_angle = 0
            last_spin = tick()
        end
    end
end

if player.Character then
    reset_spin(player.Character)
end
player.CharacterAdded:Connect(reset_spin)

RunService.RenderStepped:Connect(function(dt)
    if not spin_on then return end
    local char = player.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health > 0 then
            do_spin(char, dt)
        end
    end
end)

------------------------------------------------------------
-- HITBOX TAB
------------------------------------------------------------
local HitboxSection = Tabs.Hitbox:AddLeftGroupbox("Hitbox", "box")

HitboxSection:AddToggle("HitboxEnabled", {
    Text = "Enable Hitbox",
    Default = false,
    Callback = function(value)
        hitbox_on = value
        if not value then
            for _, plr in ipairs(Players:GetPlayers()) do restore_props(plr) end
            og_props = {}
        else
            update_hitboxes()
        end
    end,
})

HitboxSection:AddSlider("HitboxSize", {
    Text = "Hitbox Size",
    Default = hitbox_size,
    Min = 1,
    Max = 50,
    Rounding = 0,
    Callback = function(value)
        hitbox_size = value
        if hitbox_on then update_hitboxes() end
    end,
})

HitboxSection:AddSlider("HitboxAlpha", {
    Text = "Hitbox Transparency",
    Default = math.clamp(hitbox_alpha * 10, 1, 10),
    Min = 1,
    Max = 10,
    Rounding = 0,
    Callback = function(value)
        hitbox_alpha = math.clamp(value / 10, 0, 1)
        if hitbox_on then update_hitboxes() end
    end,
})

HitboxSection:AddDropdown("TeamCheck", {
    Values = {"FFA", "Team-Based", "Everyone"},
    Default = "Everyone",
    Text = "Team Check",
    Callback = function(option)
        team_check = option
        if hitbox_on then update_hitboxes() end
    end,
})

HitboxSection:AddToggle("NoCollision", {
    Text = "No Collision",
    Default = false,
    Callback = function(value)
        no_collide = value
        if hitbox_on then update_hitboxes() end
    end,
})

------------------------------------------------------------
-- AIMBOT TAB
------------------------------------------------------------
local aimbot_on = false
local aim_fov = 100
local aim_smooth = 0.2
local aim_part = "Head"
local aim_threshold = 30
local wallcheck_on = false
local fov_circle = Drawing.new("Circle")
local show_fov = false
fov_circle.Radius = aim_fov
fov_circle.Thickness = 2
fov_circle.Color = Color3.fromRGB(255, 255, 255)
fov_circle.Filled = false
fov_circle.Transparency = 0.8
fov_circle.Visible = false

local ray_params = RaycastParams.new()
ray_params.FilterType = Enum.RaycastFilterType.Exclude
ray_params.IgnoreWater = true

local function is_visible(part)
    local cam = Workspace.CurrentCamera
    local origin = cam.CFrame.Position
    local dir = part.Position - origin
    ray_params.FilterDescendantsInstances = {player.Character}
    local result = Workspace:Raycast(origin, dir, ray_params)
    if result then
        local hit = result.Instance
        local char = hit:FindFirstAncestorWhichIsA("Model")
        if char and char:FindFirstChild("Humanoid") then
            return char == part.Parent
        end
        return false
    end
    return true
end

local function find_closest()
    local closest = nil
    local best = math.huge
    local mouse = UserInputService:GetMouseLocation()
    local cam = Workspace.CurrentCamera
    local spos_out = nil
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild(aim_part) then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local part = p.Character[aim_part]
                local spos, on = cam:WorldToViewportPoint(part.Position)
                if on then
                    local dist = (Vector2.new(spos.X, spos.Y) - mouse).Magnitude
                    if dist <= aim_fov and dist < best then
                        if not wallcheck_on or is_visible(part) then
                            best = dist
                            closest = p
                            spos_out = Vector2.new(spos.X, spos.Y)
                        end
                    end
                end
            end
        end
    end
    return closest, best, spos_out
end

RunService.RenderStepped:Connect(function()
    fov_circle.Visible = aimbot_on and show_fov
    if fov_circle.Visible then
        local center = Workspace.CurrentCamera.ViewportSize / 2
        fov_circle.Position = Vector2.new(center.X, center.Y)
        fov_circle.Radius = aim_fov
    end
    local holding = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
    if aimbot_on and holding then
        local _, dist, screen_pos = find_closest()
        if dist and dist <= aim_threshold and screen_pos then
            local mouse = UserInputService:GetMouseLocation()
            local dir = screen_pos - mouse
            local mdist = dir.Magnitude
            if mdist > 0 then
                local move = dir.Unit * (mdist * aim_smooth)
                mousemoverel(move.X, move.Y)
            end
        end
    end
end)

local lockon_sec = Tabs.Aimbot:AddLeftGroupbox("Aimbot", "crosshair")

lockon_sec:AddToggle("AimbotEnabled", {
    Text = "Enabled",
    Default = false,
    Callback = function(on) aimbot_on = on end,
})

lockon_sec:AddToggle("WallCheck", {
    Text = "Wall Check",
    Default = false,
    Callback = function(on) wallcheck_on = on end,
})

lockon_sec:AddDropdown("TargetPart", {
    Values = {"Head", "UpperTorso", "HumanoidRootPart"},
    Default = "Head",
    Text = "Target Part",
    Callback = function(part) aim_part = part end,
})

lockon_sec:AddSlider("AimThreshold", {
    Text = "Lock On Sensitivity",
    Default = aim_threshold,
    Min = 5,
    Max = 100,
    Rounding = 0,
    Callback = function(val) aim_threshold = val end,
})

lockon_sec:AddSlider("AimSmooth", {
    Text = "Smoothness",
    Default = aim_smooth * 10,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Callback = function(val) aim_smooth = val / 10 end,
})

lockon_sec:AddToggle("ShowFOV", {
    Text = "Show FOV Circle",
    Default = false,
    Callback = function(on) show_fov = on end,
})

lockon_sec:AddSlider("FOVRadius", {
    Text = "FOV Radius",
    Default = aim_fov,
    Min = 20,
    Max = 500,
    Rounding = 0,
    Callback = function(val) aim_fov = val end,
})

-- Color picker must be chained off AddLabel in Obsidian
lockon_sec:AddLabel("FOV Circle Color"):AddColorPicker("FOVColor", {
    Default = fov_circle.Color,
    Title = "FOV Circle Color",
    Callback = function(col) fov_circle.Color = col end,
})

------------------------------------------------------------
-- PLAYER TAB
------------------------------------------------------------
local PlayerSection = Tabs.Player:AddLeftGroupbox("Player", "user")

PlayerSection:AddToggle("Fly", {
    Text = "Fly",
    Default = false,
    Callback = function(value)
        fly_on = value
        if value then spawn(start_fly) end
    end,
})

PlayerSection:AddSlider("FlySpeed", {
    Text = "Fly Speed",
    Default = fly_speed,
    Min = 25,
    Max = 500,
    Rounding = 0,
    Callback = function(value) fly_speed = value end,
})

PlayerSection:AddSlider("FlySmooth", {
    Text = "Fly Smoothness",
    Default = fly_smooth,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(value) fly_smooth = value end,
})

PlayerSection:AddToggle("WalkSpeedEnabled", {
    Text = "Enable WalkSpeed",
    Default = false,
    Callback = function(value) ws_on = value end,
})

PlayerSection:AddDropdown("WalkMethod", {
    Values = walk_methods,
    Default = walk_methods[1],
    Text = "Walk Method",
    Callback = function(option) walk_method = option end,
})

PlayerSection:AddSlider("WalkSpeedPower", {
    Text = "WalkSpeed Power",
    Default = settings.WalkSpeed,
    Min = 16,
    Max = 500,
    Rounding = 0,
    Callback = function(value) settings.WalkSpeed = value end,
})

PlayerSection:AddToggle("JumpEnabled", {
    Text = "Enable Jump",
    Default = false,
    Callback = function(value) IJ = value end,
})

PlayerSection:AddSlider("JumpPower", {
    Text = "Jump Power",
    Default = settings.JumpPower,
    Min = 50,
    Max = 200,
    Rounding = 0,
    Callback = function(value) settings.JumpPower = value end,
})

local noclip_on = false
PlayerSection:AddToggle("NoClip", {
    Text = "NoClip",
    Default = false,
    Callback = function(enabled)
        noclip_on = enabled
        local function toggle()
            while noclip_on do
                local char = player.Character
                if char then
                    for _, p in pairs(char:GetDescendants()) do
                        if p:IsA("BasePart") then p.CanCollide = false end
                    end
                end
                RunService.Stepped:Wait()
            end
            local char = player.Character
            if char then
                for _, p in pairs(char:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide = true end
                end
            end
        end
        if noclip_on then spawn(toggle) end
    end,
})

------------------------------------------------------------
-- SPINBOT TAB
------------------------------------------------------------
local SpinbotSection = Tabs.Spinbot:AddLeftGroupbox("Spinbot", "rotate-cw")

SpinbotSection:AddToggle("SpinbotEnabled", {
    Text = "Enable Spinbot",
    Default = false,
    Callback = function(state) spin_on = state end,
})

SpinbotSection:AddSlider("SpinSpeed", {
    Text = "Spin Speed (deg/s)",
    Default = spin_speed,
    Min = 10,
    Max = 360,
    Rounding = 0,
    Callback = function(val) spin_speed = val end,
})

------------------------------------------------------------
-- VISUALS TAB
------------------------------------------------------------
local VisualsSection = Tabs.Visuals:AddLeftGroupbox("Visuals", "eye")

local espScript = loadstring(game:HttpGet("https://rawscript.vercel.app/api/raw/esp_1"))()

VisualsSection:AddToggle("ESPEnabled", {
    Text = "Enable ESP",
    Default = false,
    Callback = function(value)
        espScript:Toggle(value)
        espScript.Players = value
    end,
})

VisualsSection:AddToggle("ESPTeammates", {
    Text = "Teammates",
    Default = false,
    Callback = function(value) espScript.TeamMates = value end,
})

VisualsSection:AddToggle("ESPTracers", {
    Text = "Tracers ESP",
    Default = false,
    Callback = function(value) espScript.Tracers = value end,
})

VisualsSection:AddToggle("ESPNames", {
    Text = "Name ESP",
    Default = false,
    Callback = function(value) espScript.Names = value end,
})

VisualsSection:AddToggle("ESPBoxes", {
    Text = "Boxes ESP",
    Default = false,
    Callback = function(value) espScript.Boxes = value end,
})

VisualsSection:AddToggle("ESPTeamColor", {
    Text = "TeamColor",
    Default = false,
    Callback = function(value) espScript.TeamColor = value end,
})

------------------------------------------------------------
-- TELEPORT TAB
------------------------------------------------------------
local TeleportSection = Tabs.Teleport:AddLeftGroupbox("Teleport", "map-pin")

local location_names = {}
for name in pairs(locations) do
    table.insert(location_names, name)
end

TeleportSection:AddDropdown("TeleportLocation", {
    Values = location_names,
    Default = location_names[1],
    Text = "Teleport Location",
    Callback = function(selectedName)
        local pos = locations[selectedName]
        if pos then teleport(pos) end
    end,
})

------------------------------------------------------------
-- CROSSHAIR / TRIGGERBOT TAB
------------------------------------------------------------
getgenv().triggerb = false
local ch_on = false
local ch_color = Color3.fromRGB(255, 255, 255)
local ch_size = 10
local dot_size = 2
local ch_gap = 10
local trigger_delay = 0.2

local ch_lines = {
    top = Drawing.new("Line"),
    bottom = Drawing.new("Line"),
    left = Drawing.new("Line"),
    right = Drawing.new("Line")
}
local ch_dot = Drawing.new("Circle")

local function draw_ch()
    if ch_on then
        local ss = Workspace.CurrentCamera.ViewportSize
        local cx, cy = ss.X / 2, ss.Y / 2
        ch_lines.top.From = Vector2.new(cx, cy - ch_gap)
        ch_lines.top.To = Vector2.new(cx, cy - ch_gap - ch_size)
        ch_lines.top.Color = ch_color
        ch_lines.top.Thickness = 2
        ch_lines.top.Visible = true
        ch_lines.bottom.From = Vector2.new(cx, cy + ch_gap)
        ch_lines.bottom.To = Vector2.new(cx, cy + ch_gap + ch_size)
        ch_lines.bottom.Color = ch_color
        ch_lines.bottom.Thickness = 2
        ch_lines.bottom.Visible = true
        ch_lines.left.From = Vector2.new(cx - ch_gap, cy)
        ch_lines.left.To = Vector2.new(cx - ch_gap - ch_size, cy)
        ch_lines.left.Color = ch_color
        ch_lines.left.Thickness = 2
        ch_lines.left.Visible = true
        ch_lines.right.From = Vector2.new(cx + ch_gap, cy)
        ch_lines.right.To = Vector2.new(cx + ch_gap + ch_size, cy)
        ch_lines.right.Color = ch_color
        ch_lines.right.Thickness = 2
        ch_lines.right.Visible = true
        ch_dot.Position = Vector2.new(cx, cy)
        ch_dot.Radius = dot_size
        ch_dot.Color = ch_color
        ch_dot.Filled = true
        ch_dot.Visible = true
    else
        for _, line in pairs(ch_lines) do line.Visible = false end
        ch_dot.Visible = false
    end
end

RunService.RenderStepped:Connect(function()
    draw_ch()
    if getgenv().triggerb then
        local mouse = player:GetMouse()
        local target = mouse.Target
        if target and target.Parent and target.Parent.Parent == Workspace.PLAYERS then
            local model = target.Parent
            if model:FindFirstChild("Humanoid") and model.Name ~= player.Name then
                local plr = Players:FindFirstChild(model.Name)
                if plr and (team_check == "FFA" or team_check == "Everyone" or (team_check == "Team-Based" and plr.Team ~= player.Team)) then
                    mouse1press()
                    task.wait(trigger_delay)
                    mouse1release()
                end
            end
        end
    end
end)

local crosshairFolder = Tabs.Crosshair:AddLeftGroupbox("Crosshair", "plus")

crosshairFolder:AddToggle("Triggerbot", {
    Text = "Enable Triggerbot",
    Default = false,
    Callback = function(state) getgenv().triggerb = state end,
})

crosshairFolder:AddSlider("TriggerDelay", {
    Text = "Triggerbot Delay",
    Default = trigger_delay * 10,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Callback = function(value) trigger_delay = value / 10 end,
})

crosshairFolder:AddToggle("CustomCrosshair", {
    Text = "Custom Crosshair",
    Default = false,
    Callback = function(state)
        ch_on = state
        draw_ch()
    end,
})

crosshairFolder:AddSlider("CrosshairSize", {
    Text = "Crosshair Size",
    Default = ch_size,
    Min = 4,
    Max = 20,
    Rounding = 0,
    Callback = function(size)
        ch_size = size
        draw_ch()
    end,
})

crosshairFolder:AddSlider("DotSize", {
    Text = "Dot Size",
    Default = dot_size,
    Min = 2,
    Max = 10,
    Rounding = 0,
    Callback = function(size)
        dot_size = size
        draw_ch()
    end,
})

crosshairFolder:AddSlider("CrosshairGap", {
    Text = "Crosshair Gap",
    Default = ch_gap,
    Min = 6,
    Max = 20,
    Rounding = 0,
    Callback = function(size)
        ch_gap = size
        draw_ch()
    end,
})

-- Color picker chained off a Label
crosshairFolder:AddLabel("Crosshair Color"):AddColorPicker("CrosshairColor", {
    Default = ch_color,
    Title = "Crosshair Color",
    Callback = function(color)
        ch_color = color
        draw_ch()
    end,
})

------------------------------------------------------------
-- CREDITS TAB
------------------------------------------------------------
local CreditsSection = Tabs.Credits:AddLeftGroupbox("Credits", "heart")

local devs = {"Rusty", "Starry"}
local roles = {
    Rusty = "Owner",
    Starry = "Head Developer",
}
for _, dev in ipairs(devs) do
    CreditsSection:AddButton("Credit_" .. dev, {
        Text = dev,
        Func = function()
            print(dev .. " created " .. roles[dev])
        end,
    })
end

CreditsSection:AddButton("CopyDiscord", {
    Text = "Copy Discord Link",
    Func = function()
        setclipboard("https://discord.gg/efrvtA2HAx")
    end,
})

RunService.Heartbeat:Connect(function()
    if hitbox_on then
        update_hitboxes()
        cleanup_props()
    end
end)

------------------------------------------------------------
-- UI SETTINGS TAB (Theme / Config managers)
------------------------------------------------------------
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
ThemeManager:SetFolder("HackSense")
SaveManager:SetFolder("HackSense/configs")
SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])

SaveManager:LoadAutoloadConfig()

local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu", "wrench")

-- Key picker chained off a Label
MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {
    Default = "RightShift",
    NoUI = true,
    Text = "Menu keybind",
})

Library.ToggleKeybind = Options.MenuKeybind

Library:OnUnload(function()
    print("HackSense unloaded!")
end)
