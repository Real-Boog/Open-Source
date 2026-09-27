local players = game:GetService("Players")
local workspaceService = game:GetService("Workspace")
local runService = game:GetService("RunService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local userInputService = game:GetService("UserInputService")
local localPlayer = players.LocalPlayer
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()
local themeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/addons/ThemeManager.lua"))()
local saveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/addons/SaveManager.lua"))()
local options = library.Options
local toggles = library.Toggles

local window = library:CreateWindow({
  Title = "Bloxstrike By Bright696",
  Center = true,
  AutoShow = true,
  TabPadding = 8,
  MenuFadeTime = 0.2,
  Footer = "made by Bright696",
})

local v1 = {
  Combat = window:AddTab("Combat", "swords"),
  Visuals = window:AddTab("Visuals", "eye"),
  Weapons = window:AddTab("Weapons", "crosshair"),
  StyleChanger = window:AddTab("StyleChanger", "paintbrush"),
  Settings = window:AddTab("Settings", "settings"),
}

local addLeftGroupbox = v1.StyleChanger:AddLeftGroupbox("Skins", "palette")
local addRightGroupbox = v1.StyleChanger:AddRightGroupbox("Skins 2", "brush")
local v2 = filtergc("function", { Name = "getPlayersOnTeam" }, true)

local function f1(p1)
  local counterTerrorists = v2("Counter-Terrorists")
  local terrorists = v2("Terrorists")

  if table.find(terrorists, players.LocalPlayer) and table.find(terrorists, p1) then
    return true
  end

  if table.find(counterTerrorists, players.LocalPlayer) and table.find(counterTerrorists, p1) then
    return true
  end

  return false
end

local v3 = next
local v4, v5 = getgc()
local v6

for v7, v8 in v3, v4, v5 do
  if type(v8) == "function" and debug.getinfo(v8).name == "ApplySkinTextures" then
    v6 = v8
    break
  end
end

local function f2()
  return workspaceService.Camera:FindFirstChildOfClass("Model")
end

local skins = replicatedStorage:WaitForChild("Assets"):WaitForChild("Skins")
local v9 = next
local v10 = {}
local v11, v12 = skins:GetChildren()

for v13, v14 in v9, v11, v12 do
  if #v14:GetChildren() > 1 then
    table.insert(v10, v14)
  end
end

local v15 = math.ceil(#v10 / 2)

for i = 1, v15 do
  local v16 = v10[i]

  addLeftGroupbox:AddDropdown(tostring(v16), {
    Text = tostring(v16),
    Values = v16:GetChildren(),
    Default = 1,
    Multi = false,
  })
end

for j = v15 + 1, #v10 do
  local v17 = v10[j]

  addRightGroupbox:AddDropdown(tostring(v17), {
    Text = tostring(v17),
    Values = v17:GetChildren(),
    Default = 1,
    Multi = false,
  })
end

local v18, v19

task.spawn(function()
  while task.wait(0.1) do
    local v20 = f2()

    if v20 then
      local v21 = options[tostring(v20)]
      local value = v21 and v21.Value

      if v20 ~= v18 or value ~= v19 then
        pcall(function()
          if value then
            v6(v20, value.Camera["Factory New"])
          end
        end)

        v18 = v20
        v19 = value
      end
    else
      v18 = nil
      v19 = nil
    end
  end
end)

local addLeftGroupbox2 = v1.Weapons:AddLeftGroupbox("Weapon Mods", "wrench")

local addRightGroupbox2 = v1.Weapons:AddRightGroupbox("Gernades", "bomb")

addRightGroupbox2:AddToggle("Antiflashbang", {
  Text = "Enable No Flashbang",
  Default = false,
  Disabled = typeof(hookfunction) ~= "function",
  DisabledTooltip = "This feature is not available on your executor.",
})

addRightGroupbox2:AddToggle("Antismoke", {
  Text = "Enable No Smoke",
  Default = false,
  Disabled = typeof(hookfunction) ~= "function",
  DisabledTooltip = "This feature is not available on your executor.",
})

addLeftGroupbox2:AddToggle("Firerate", {
  Text = "Enable Firerate Changer",
  Default = false,
  Disabled = typeof(hookfunction) ~= "function",
  DisabledTooltip = "This feature is not available on your executor.",
})

addLeftGroupbox2:AddSlider("FirerateSlider", {
  Text = "Firerate",
  Default = 0.01,
  Min = 0,
  Max = 1,
  Rounding = 3,
})

addLeftGroupbox2:AddToggle("NoRecoil", {
  Text = "Enable No Recoil",
  Default = false,
  Disabled = typeof(hookfunction) ~= "function",
  DisabledTooltip = "This feature is not available on your executor.",
})

addLeftGroupbox2:AddToggle("NoSpread", {
  Text = "Enable No Spread",
  Default = false,
  Disabled = typeof(hookfunction) ~= "function",
  DisabledTooltip = "This feature is not available on your executor.",
})

local addLeftGroupbox3 = v1.Combat:AddLeftGroupbox("Legit", "target")

addLeftGroupbox3:AddToggle("Aimbot", {
  Text = "Enable Aimbot",
  Default = false,
  Disabled = typeof(hookfunction) ~= "function",
  DisabledTooltip = "This feature is not available on your executor.",
})

toggles.Aimbot:AddKeyPicker("AimbotHoldkey", {
  Text = "Hold Key",
  Default = "MB2",
  Mode = "Hold",
})

local addDependencyBox = addLeftGroupbox3:AddDependencyBox()
addDependencyBox:AddToggle("AimbotUseFovCircle", { Text = "Use FOV Circle", Default = false })

addDependencyBox:AddSlider("AimbotFovCircleRadius", {
  Text = "FOV Radius",
  Default = 50,
  Min = 0,
  Max = 300,
  Rounding = 0,
})

addDependencyBox:AddDropdown("AimbotHitPart", {
  Text = "Hit Selection",
  Values = {
    "HumanoidRootPart", "Head", "LeftLowerArm", "LowerTorso", "RightHand", "RightLowerArm",
    "LeftFoot", "LeftHand", "RightFoot", "RightLowerLeg", "LeftLowerLeg", "RightUpperArm",
    "LeftUpperArm", "UpperTorso", "RightUpperLeg", "LeftUpperLeg",
  },
  Default = "Head",
  Multi = false,
})

addDependencyBox:AddToggle("AimbotTeamCheck", { Text = "Enable Team Check", Default = true })
addDependencyBox:AddToggle("AimbotWallCheck", { Text = "Enable Wall Check", Default = true })

addLeftGroupbox3:AddDivider()
addLeftGroupbox3:AddToggle("Triggerbot", { Text = "Enable Triggerbot", Default = false })

local addDependencyBox2 = addLeftGroupbox3:AddDependencyBox()

addDependencyBox2:AddSlider("TriggerbotDelay", {
  Text = "Delay",
  Default = 0.01,
  Min = 0,
  Max = 1,
  Rounding = 3,
})

addDependencyBox:SetupDependencies({ { toggles.Aimbot, true } })
addDependencyBox2:SetupDependencies({ { toggles.Triggerbot, true } })

local addLeftGroupbox4 = v1.Combat:AddLeftGroupbox("Hitbox Expander", "maximize")

addLeftGroupbox4:AddToggle("Hitbox", {
  Text = "Enable Hitbox Expander",
  Default = false,
  Disabled = typeof(hookmetamethod) ~= "function",
  DisabledTooltip = "This feature is not available on your executor.",
})

local addDependencyBox3 = addLeftGroupbox4:AddDependencyBox()

addDependencyBox3:AddSlider("HitboxSize", {
  Text = "Hitbox Size",
  Default = 7,
  Min = 1,
  Max = 28,
  Rounding = 0,
})

addDependencyBox3:AddSlider("HitboxTransparency", {
  Text = "Hitbox Transparency",
  Default = 0,
  Min = 0,
  Max = 1,
  Rounding = 2,
})

addDependencyBox3:SetupDependencies({ { toggles.Hitbox, true } })

local addRightGroupbox3 = v1.Combat:AddRightGroupbox("Blatant", "zap")
local addRightGroupbox4 = v1.Combat:AddRightGroupbox("Rage", "flame")

addRightGroupbox3:AddToggle("SilentAim", {
  Text = "Enable Silent Aim",
  Default = false,
  Disabled = typeof(hookfunction) ~= "function",
  DisabledTooltip = "This feature is not available on your executor.",
})

local addDependencyBox4 = addRightGroupbox3:AddDependencyBox()
addDependencyBox4:AddToggle("SilentWallbang", { Text = "Wallbang", Default = false })
addDependencyBox4:AddToggle("SilentUseFovCircle", { Text = "Use FOV Circle", Default = false })

addDependencyBox4:AddSlider("SilentFovCircleRadius", {
  Text = "FOV Radius",
  Default = 50,
  Min = 0,
  Max = 300,
  Rounding = 0,
})

addDependencyBox4:AddDropdown("SilentHitPart", {
  Text = "Hit Selection",
  Values = {
    "HumanoidRootPart", "Head", "LeftLowerArm", "LowerTorso", "RightHand", "RightLowerArm",
    "LeftFoot", "LeftHand", "RightFoot", "RightLowerLeg", "LeftLowerLeg", "RightUpperArm",
    "LeftUpperArm", "UpperTorso", "RightUpperLeg", "LeftUpperLeg",
  },
  Default = "Head",
  Multi = false,
})

addDependencyBox4:AddToggle("SilentTeamCheck", { Text = "Enable Team Check", Default = true })
addDependencyBox4:SetupDependencies({ { toggles.SilentAim, true } })

addRightGroupbox4:AddToggle("Ragebot", {
  Text = "Enable Ragebot",
  Default = false,
  Disabled = typeof(hookfunction) ~= "function",
  DisabledTooltip = "This feature is not available on your executor.",
})

local addDependencyBox5 = addRightGroupbox4:AddDependencyBox()

addDependencyBox5:AddSlider("RageDelay", {
  Text = "Delay",
  Default = 0.01,
  Min = 0,
  Max = 1,
  Rounding = 3,
})

addDependencyBox5:AddDropdown("RageHitPart", {
  Text = "Hit Selection",
  Values = {
    "HumanoidRootPart", "Head", "LeftLowerArm", "LowerTorso", "RightHand", "RightLowerArm",
    "LeftFoot", "LeftHand", "RightFoot", "RightLowerLeg", "LeftLowerLeg", "RightUpperArm",
    "LeftUpperArm", "UpperTorso", "RightUpperLeg", "LeftUpperLeg",
  },
  Default = "Head",
  Multi = false,
})

addDependencyBox5:AddToggle("RagebotVisibleCheck", {
  Text = "Enable Visible Check",
  Default = true,
})

addDependencyBox5:AddToggle("RagebotTeamCheck", { Text = "Enable Team Check", Default = true })
addDependencyBox5:AddToggle("RagebotWallCheck", { Text = "Enable Wall Check", Default = false })
addDependencyBox5:SetupDependencies({ { toggles.Ragebot, true } })

local addLeftGroupbox5 = v1.Visuals:AddLeftGroupbox("ESP", "eye")
addLeftGroupbox5:AddToggle("ESPEnabled", { Text = "ESP Enabled", Default = false })

addLeftGroupbox5:AddDropdown("ESPBoxType", {
  Text = "Box ESP",
  Values = { "2D Box", "3D Box", "Corner Box", "Disabled" },
  Default = "2D Box",
})

addLeftGroupbox5:AddToggle("ESPName", { Text = "Name ESP", Default = false })

addLeftGroupbox5:AddLabel("Name Color"):AddColorPicker("ESPNameColor", {
  Default = Color3.new(1, 1, 1),
  Title = "Name Color",
})

addLeftGroupbox5:AddToggle("ESPHealth", { Text = "Health Bar", Default = false })
addLeftGroupbox5:AddToggle("ESPDistance", { Text = "Distance ESP", Default = false })
addLeftGroupbox5:AddToggle("ESPTracer", { Text = "Tracer ESP", Default = false })

addLeftGroupbox5:AddDropdown("ESPTracerOrigin", {
  Text = "Tracer Origin",
  Values = { "Bottom", "Top", "Center", "Mouse" },
  Default = "Bottom",
})

addLeftGroupbox5:AddToggle("ESPSkeleton", { Text = "Skeleton ESP", Default = false })

Color3.fromRGB(204, 170, 80)
Color3.fromRGB(100, 149, 200)
Color3.new(1, 1, 1)

getgenv().esplib = {
  box = {
    enabled = false,
    type = "2D",
    padding = 1.15,
    fill = Color3.new(1, 1, 1),
    outline = Color3.new(0, 0, 0),
    color = Color3.new(1, 1, 1),
  },
  healthbar = {
    enabled = false,
    fill = Color3.new(0, 1, 0),
    outline = Color3.new(0, 0, 0),
    position = "Top",
  },
  name = { enabled = false, fill = Color3.new(1, 1, 1), size = 13 },
  distance = { enabled = false, fill = Color3.new(1, 1, 1), size = 13 },
  tracer = {
    enabled = false,
    fill = Color3.new(1, 1, 1),
    outline = Color3.new(0, 0, 0),
    from = "bottom",
  },
  skeleton = {
    enabled = false,
    color = Color3.new(1, 1, 1),
    thickness = 2,
    transparency = 1,
  },
}

local esplib = getgenv().esplib

if not esplib then
  esplib = {
    box = {
      enabled = true,
      type = "2D",
      padding = 1.15,
      fill = Color3.new(1, 1, 1),
      outline = Color3.new(0, 0, 0),
      color = Color3.new(1, 1, 1),
    },
    healthbar = {
      enabled = true,
      fill = Color3.new(0, 1, 0),
      outline = Color3.new(0, 0, 0),
      position = "Left",
    },
    name = { enabled = true, fill = Color3.new(1, 1, 1), size = 13 },
    distance = { enabled = true, fill = Color3.new(1, 1, 1), size = 13 },
    tracer = {
      enabled = true,
      fill = Color3.new(1, 1, 1),
      outline = Color3.new(0, 0, 0),
      from = "bottom",
    },
    skeleton = {
      enabled = false,
      color = Color3.new(0, 1, 1),
      thickness = 2,
      transparency = 1,
    },
    headcircle = {
      enabled = false,
      fill = Color3.new(1, 1, 1),
      outline = Color3.new(0, 0, 0),
      radius = 20,
      thickness = 2,
    },
  }

  getgenv().esplib = esplib
end

local v22 = {}
getgenv().esplib_instances = v22
local v23 = {}
local currentCamera = workspace.CurrentCamera
local abs = math.abs
local huge = math.huge
local min = math.min
local floor = math.floor
local clamp = math.clamp

local v24 = {
  { "Head", "Torso" }, { "Torso", "Left Arm" }, { "Torso", "Right Arm" },
  { "Torso", "Left Leg" }, { "Torso", "Right Leg" },
}

local v25 = {
  { "Head", "UpperTorso" }, { "UpperTorso", "LowerTorso" }, { "UpperTorso", "LeftUpperArm" },
  { "LeftUpperArm", "LeftLowerArm" }, { "LeftLowerArm", "LeftHand" },
  { "UpperTorso", "RightUpperArm" }, { "RightUpperArm", "RightLowerArm" },
  { "RightLowerArm", "RightHand" }, { "LowerTorso", "LeftUpperLeg" },
  { "LeftUpperLeg", "LeftLowerLeg" }, { "LeftLowerLeg", "LeftFoot" },
  { "LowerTorso", "RightUpperLeg" }, { "RightUpperLeg", "RightLowerLeg" },
  { "RightLowerLeg", "RightFoot" },
}

local v26 = {
  { 0, 0, 0 }, { 1, 0, 0 }, { 0, 1, 0 }, { 1, 1, 0 }, { 0, 0, 1 }, { 1, 0, 1 }, { 0, 1, 1 },
  { 1, 1, 1 },
}

local v27 = {
  { 1, 2 }, { 2, 4 }, { 4, 3 }, { 3, 1 }, { 5, 6 }, { 6, 8 }, { 8, 7 }, { 7, 5 }, { 1, 5 },
  { 2, 6 }, { 3, 7 }, { 4, 8 },
}

local worldToViewportPoint = currentCamera.WorldToViewportPoint
local box = esplib.box
local healthbar = esplib.healthbar
local name = esplib.name
local distance = esplib.distance
local tracer = esplib.tracer
local skeleton = esplib.skeleton
local headcircle = esplib.headcircle

local function f3(p2, p3)
  if p3 then
    return p3(p2)
  end

  return box.fill
end

local v28 = setmetatable({}, { __mode = "k" })

local function f4(p4, p5, p6, p7, p8, p9)
  local v29 = {}
  local v30 = false
  local count = 0

  while true do
    count = 1 + count

    if not (8 >= count) then
      break
    end

    local v31 = count
    local v32 = v26[v31]
    local v33 = v32[1] == 0 and p4 or p7
    local v34 = v32[2] == 0 and p5 or p8
    local v35 = v32[3] == 0 and p6 or p9
    local v36, v37 = worldToViewportPoint(currentCamera, Vector3.new(v33, v34, v35))
    v29[v31] = Vector2.new(v36.X, v36.Y)

    if v37 then
      v30 = true
    end
  end

  return v29, v30
end

local function f5(p10, p11, p12, p13, p14, p15)
  local v38 = huge
  local v39 = huge
  local v40 = -huge
  local v41 = -huge
  local v42 = false

  for k = 1, 8 do
    local v43 = v26[k]
    local v44 = v43[1] == 0 and p10 or p13
    local v45 = v43[2] == 0 and p11 or p14
    local v46 = v43[3] == 0 and p12 or p15
    local v47, v48 = worldToViewportPoint(currentCamera, Vector3.new(v44, v45, v46))

    if v48 then
      v42 = true
      local y = v47.Y
      local x = v47.X

      if x < v38 then
        v38 = x
      end

      if y < v39 then
        v39 = y
      end

      if x > v40 then
        v40 = x
      end

      if y > v41 then
        v41 = y
      end
    end
  end

  if not v42 then
    return nil, nil, false
  end

  return Vector2.new(v38, v39), Vector2.new(v40, v41), true
end

local f6

local function f7(p16)
  local v49 = huge
  local v50 = huge
  local v51 = huge
  local v52 = -huge
  local v53 = -huge
  local v54 = -huge
  local v55 = #p16
  local count2 = 0

  while true do
    count2 = 1 + count2

    if not (count2 <= v55) then
      break
    end

    local v56 = p16[count2]
    local v57, v58, v59 = f6(v56)
    local v60 = { v56.CFrame:GetComponents() }
    local v61 = v60[2]
    local v62 = v60[3]
    local v63 = v60[1]
    local v64 = abs(v60[4]) * v57 + abs(v60[5]) * v58 + abs(v60[6]) * v59
    local v65 = abs(v60[7]) * v57 + abs(v60[8]) * v58 + abs(v60[9]) * v59
    local v66 = abs(v60[10]) * v57 + abs(v60[11]) * v58 + abs(v60[12]) * v59
    local v67 = v63 - v64
    local v68 = v63 + v64
    local v69 = v61 - v65
    local v70 = v61 + v65
    local v71 = v62 - v66
    local v72 = v62 + v66

    if v67 < v50 then
      v50 = v67
    end

    if v69 < v51 then
      v51 = v69
    end

    if v71 < v49 then
      v49 = v71
    end

    if v68 > v54 then
      v54 = v68
    end

    if v70 > v52 then
      v52 = v70
    end

    if v72 > v53 then
      v53 = v72
    end
  end

  if v50 == huge then
    return nil
  end

  return v50, v51, v49, v54, v52, v53
end

function f6(p17)
  local padding = box.padding
  local v73 = v28[p17]

  if not v73 or v73.padding ~= padding then
    local size = p17.Size

    v73 = {
      hx = size.X * 0.5 * padding,
      hy = size.Y * 0.5 * padding,
      hz = size.Z * 0.5 * padding,
      padding = padding,
    }

    v28[p17] = v73
  end

  return v73.hx, v73.hy, v73.hz
end

local function f8(p18, p19)
  local v74, v75

  if p19.partlist then
    return p19.partlist
  else
    v74 = {}
    v75 = setmetatable({}, { __mode = "k" })

    local function f9(p20)
      if p20:IsA("BasePart") and not v75[p20] then
        v74[#v74 + 1] = p20
        v75[p20] = #v74

        local connect = p20:GetPropertyChangedSignal("Size"):Connect(function()
          v28[p20] = nil
        end)

        p19.sizeConns = p19.sizeConns or {}
        p19.sizeConns[p20] = connect
      end
    end

    local function f10(p21)
      local v76 = v75[p21]

      if v76 then
        local v77 = #v74
        local v78 = v74[v77]
        v74[v76] = v78
        v75[v78] = v76
        v74[v77] = nil
        v75[p21] = nil

        if p19.sizeConns and p19.sizeConns[p21] then
          p19.sizeConns[p21]:Disconnect()
          p19.sizeConns[p21] = nil
        end
      end
    end

    if p18:IsA("Model") then
      local v79, v80 = p18:GetDescendants()

      for key, value2 in next, v79, v80 do
        f9(value2)
      end

      p19.partConnAdd = p18.DescendantAdded:Connect(f9)
      p19.partConnRemove = p18.DescendantRemoving:Connect(f10)
    elseif p18:IsA("BasePart") then
      f9(p18)
    end

    p19.partlist = v74
    return v74
  end
end

local function f11(p22, p23)
  local v81 = p22[p23]

  if v81 then
    return v81[1], v81[2]
  else
    local v82, v83 = worldToViewportPoint(currentCamera, p23.Position)
    local vector = Vector2.new(v82.X, v82.Y)
    p22[p23] = { vector, v83 }
    return vector, v83
  end
end

function v23.add_box(p24)
  if not p24 or v22[p24] and v22[p24].box then
    return
  else
    local v84 = {}

    local square = Drawing.new("Square")
    square.Thickness = 3
    square.Filled = false
    square.Transparency = 1
    square.Visible = false

    local square2 = Drawing.new("Square")
    square2.Thickness = 1
    square2.Filled = false
    square2.Transparency = 1
    square2.Visible = false

    v84.outline = square
    v84.fill = square2
    v84.corner_fill = {}
    v84.corner_outline = {}

    for m = 1, 8 do
      local line = Drawing.new("Line")
      line.Thickness = 3
      line.Transparency = 1
      line.Visible = false

      local line2 = Drawing.new("Line")
      line2.Thickness = 1
      line2.Transparency = 1
      line2.Visible = false

      v84.corner_fill[m] = line2
      v84.corner_outline[m] = line
    end

    v84.box_3d_lines = {}
    local count3 = 0

    while true do
      count3 = 1 + count3

      if not (count3 <= 12) then
        break
      end

      local line3 = Drawing.new("Line")
      line3.Thickness = 2
      line3.Transparency = 1
      line3.Visible = false

      v84.box_3d_lines[count3] = line3
    end

    v22[p24] = v22[p24] or {}
    v22[p24].box = v84

    return
  end
end

function v23.add_healthbar(p25)
  if not p25 or v22[p25] and v22[p25].healthbar then
    return
  else
    local square3 = Drawing.new("Square")
    square3.Thickness = 1
    square3.Filled = true
    square3.Transparency = 1

    local square4 = Drawing.new("Square")
    square4.Filled = true
    square4.Transparency = 1

    v22[p25] = v22[p25] or {}
    v22[p25].healthbar = { outline = square3, fill = square4 }

    return
  end
end

local function f12(p26, p27)
  if p27.box then
    p27.box.outline:Remove()
    p27.box.fill:Remove()

    for key2, value3 in next, p27.box.corner_fill, nil do
      value3:Remove()
    end

    for key3, value4 in next, p27.box.corner_outline, nil do
      value4:Remove()
    end

    for key4, value5 in next, p27.box.box_3d_lines, nil do
      value5:Remove()
    end
  end

  if p27.healthbar then
    p27.healthbar.outline:Remove()
    p27.healthbar.fill:Remove()
  end

  if p27.name then
    p27.name:Remove()
  end

  if p27.distance then
    p27.distance:Remove()
  end

  if p27.tracer then
    p27.tracer.outline:Remove()
    p27.tracer.fill:Remove()
  end

  if p27.skeleton then
    for key5, value6 in next, p27.skeleton.lines, nil do
      value6:Remove()
    end
  end

  if p27.headcircle then
    p27.headcircle:Remove()
  end

  if p27.partConnAdd then
    p27.partConnAdd:Disconnect()
  end

  if p27.partConnRemove then
    p27.partConnRemove:Disconnect()
  end

  if p27.sizeConns then
    for key6, value7 in next, p27.sizeConns, nil do
      value7:Disconnect()
    end
  end
end

function v23.add_name(p28)
  if not p28 or v22[p28] and v22[p28].name then
    return
  else
    local text = Drawing.new("Text")
    text.Center = true
    text.Outline = true
    text.Font = 1
    text.Transparency = 1

    v22[p28] = v22[p28] or {}
    v22[p28].name = text

    return
  end
end

function v23.add_distance(p29)
  if not p29 or v22[p29] and v22[p29].distance then
    return
  else
    local text2 = Drawing.new("Text")
    text2.Center = true
    text2.Outline = true
    text2.Font = 1
    text2.Transparency = 1

    v22[p29] = v22[p29] or {}
    v22[p29].distance = text2

    return
  end
end

function v23.add_tracer(p30)
  if not p30 or v22[p30] and v22[p30].tracer then
    return
  else
    local line4 = Drawing.new("Line")
    line4.Thickness = 3
    line4.Transparency = 1

    local line5 = Drawing.new("Line")
    line5.Thickness = 1
    line5.Transparency = 1

    v22[p30] = v22[p30] or {}
    v22[p30].tracer = { outline = line4, fill = line5 }

    return
  end
end

function v23.add_skeleton(p31, p32)
  if not p31 or v22[p31] and v22[p31].skeleton then
    return
  else
    local thickness = (p32 or {}).thickness or skeleton.thickness
    local v85 = p31:FindFirstChild("UpperTorso") ~= nil and v25 or v24
    local v86 = {}
    local v87 = #v85
    local v88 = {}
    local count4 = 0

    while true do
      count4 = 1 + count4

      if not (v87 >= count4) then
        break
      end

      local v89 = count4

      local line6 = Drawing.new("Line")
      line6.Thickness = thickness
      line6.Transparency = 1
      line6.Visible = false

      v86[v89] = line6
      v88[v89] = { p31:FindFirstChild(v85[v89][1]), (p31:FindFirstChild(v85[v89][2])) }
    end

    v22[p31] = v22[p31] or {}
    v22[p31].skeleton = { lines = v86, bone_parts = v88, screenCache = {} }

    return
  end
end

function v23.add_headcircle(p33)
  if not p33 or v22[p33] and v22[p33].headcircle then
    return
  else
    local circle = Drawing.new("Circle")
    circle.Thickness = headcircle and headcircle.thickness or 2
    circle.Filled = false
    circle.Transparency = 1
    circle.Visible = false
    circle.NumSides = 32

    v22[p33] = v22[p33] or {}
    v22[p33].headcircle = circle

    return
  end
end

local function f13(p34)
  if p34.box then
    p34.box.outline.Visible = false
    p34.box.fill.Visible = false

    local box3dLines = p34.box.box_3d_lines
    local cornerOutline = p34.box.corner_outline
    local cornerFill = p34.box.corner_fill
    local v90 = #cornerFill
    local count5 = 0

    while true do
      count5 = 1 + count5

      if not (count5 <= v90) then
        break
      end

      cornerFill[count5].Visible = false
    end

    local v91 = #cornerOutline
    local count6 = 0

    while true do
      count6 = 1 + count6

      if not (v91 >= count6) then
        break
      end

      cornerOutline[count6].Visible = false
    end

    for n = 1, #box3dLines do
      box3dLines[n].Visible = false
    end
  end

  if p34.healthbar then
    p34.healthbar.outline.Visible = false
    p34.healthbar.fill.Visible = false
  end

  if p34.name then
    p34.name.Visible = false
  end

  if p34.distance then
    p34.distance.Visible = false
  end

  if p34.tracer then
    p34.tracer.outline.Visible = false
    p34.tracer.fill.Visible = false
  end

  if p34.skeleton then
    local lines = p34.skeleton.lines

    for i6 = 1, #lines do
      lines[i6].Visible = false
    end
  end

  if p34.headcircle then
    p34.headcircle.Visible = false
  end
end

runService.RenderStepped:Connect(function()
  local position = currentCamera.CFrame.Position
  local esplibGetColor = getgenv().esplib_get_color
  local viewportSize = currentCamera.ViewportSize
  local enabled = box.enabled
  local v92 = box.type
  local enabled2 = healthbar.enabled
  local enabled3 = name.enabled
  local enabled4 = distance.enabled
  local enabled5 = tracer.enabled
  local enabled6 = skeleton.enabled
  local enabled7 = headcircle and headcircle.enabled
  local from = tracer.from
  local vector2

  for key7, value8 in next, v22, nil do
    if not key7 or not key7.Parent then
      f12(key7, value8)
      v22[key7] = nil
    elseif key7:IsA("Model") and not key7.PrimaryPart then
      f13(value8)
    else
      if not value8.humanoid or not value8.humanoid.Parent then
        value8.humanoid = key7:FindFirstChildOfClass("Humanoid")
      end

      local humanoid = value8.humanoid

      if humanoid and humanoid.Health <= 0 then
        f13(value8)
      else
        local v93 = enabled and value8.box ~= nil
        local v94 = enabled2 and value8.healthbar ~= nil
        local v95 = enabled3 and value8.name ~= nil
        local v96 = enabled4 and value8.distance ~= nil
        local v97 = enabled5 and value8.tracer ~= nil
        local v98 = enabled6 and value8.skeleton ~= nil
        local v99 = enabled7 and value8.headcircle ~= nil

        if value8.box and not v93 then
          value8.box.outline.Visible = false
          value8.box.fill.Visible = false

          local cornerFill2 = value8.box.corner_fill
          local cornerOutline2 = value8.box.corner_outline
          local box3dLines2 = value8.box.box_3d_lines

          for i7 = 1, 8 do
            cornerFill2[i7].Visible = false
            cornerOutline2[i7].Visible = false
          end

          for i8 = 1, 12 do
            box3dLines2[i8].Visible = false
          end
        end

        if value8.healthbar and not v94 then
          value8.healthbar.outline.Visible = false
          value8.healthbar.fill.Visible = false
        end

        if value8.name and not v95 then
          value8.name.Visible = false
        end

        if value8.distance and not v96 then
          value8.distance.Visible = false
        end

        if value8.tracer and not v97 then
          value8.tracer.outline.Visible = false
          value8.tracer.fill.Visible = false
        end

        if value8.skeleton and not v98 then
          local lines2 = value8.skeleton.lines
          local v100 = #lines2
          local count7 = 0

          while true do
            count7 = 1 + count7

            if not (count7 <= v100) then
              break
            end

            lines2[count7].Visible = false
          end
        end

        if value8.headcircle and not v99 then
          value8.headcircle.Visible = false
        end

        if not (v93 or v94 or v95 or v96 or v97 or v98 or v99) then
        else
          local color = f3(key7, esplibGetColor)
          local v101 = f8(key7, value8)
          local v102 = nil
          local v103 = false
          local v104 = nil
          local v105 = nil
          local v106 = v93
          local visible = false

          if not v93 then
            v106 = v94 or v95 or v96 or v97
          end

          if v106 then
            local v107, v108, v109, v110, v111, v112 = f7(v101)

            if v107 then
              v104, v102, v103 = f5(v107, v108, v109, v110, v111, v112)

              if v93 and v92 == "3D" then
                v105, visible = f4(v107, v108, v109, v110, v111, v112)
              end
            end
          end

          if value8.box then
            local box2 = value8.box

            if v93 and v103 then
              local x2 = v104.X
              local y2 = v104.Y
              local x3 = (v102 - v104).X
              local y3 = (v102 - v104).Y
              local v113 = min(x3, y3) * 0.25

              if v92 == "2D" then
                box2.outline.Position = v104
                box2.outline.Size = v102 - v104
                box2.outline.Color = box.outline
                box2.outline.Visible = true
                box2.fill.Position = v104
                box2.fill.Size = v102 - v104
                box2.fill.Color = color
                box2.fill.Visible = true

                local cornerFill3 = box2.corner_fill
                local cornerOutline3 = box2.corner_outline
                local box3dLines3 = box2.box_3d_lines

                for i9 = 1, 8 do
                  cornerFill3[i9].Visible = false
                  cornerOutline3[i9].Visible = false
                end

                local count8 = 0

                while true do
                  count8 = 1 + count8

                  if not (count8 <= 12) then
                    break
                  end

                  box3dLines3[count8].Visible = false
                end
              elseif v92 == "Corner" then
                local v114 = {
                  { Vector2.new(x2, y2), Vector2.new(x2 + v113, y2) },
                  { Vector2.new(x2, y2), Vector2.new(x2, y2 + v113) },
                  { Vector2.new(x2 + x3 - v113, y2), Vector2.new(x2 + x3, y2) },
                  { Vector2.new(x2 + x3, y2), Vector2.new(x2 + x3, y2 + v113) },
                  { Vector2.new(x2, y2 + y3), Vector2.new(x2 + v113, y2 + y3) },
                  { Vector2.new(x2, y2 + y3 - v113), Vector2.new(x2, y2 + y3) },
                  { Vector2.new(x2 + x3 - v113, y2 + y3), Vector2.new(x2 + x3, y2 + y3) },
                  { Vector2.new(x2 + x3, y2 + y3 - v113), Vector2.new(x2 + x3, y2 + y3) },
                }

                local count9 = 0

                while true do
                  count9 = 1 + count9

                  if not (8 >= count9) then
                    break
                  end

                  local v115 = count9
                  local v116 = v114[v115][1]
                  local v117 = v114[v115][2]
                  local unit = (v117 - v116).Unit

                  box2.corner_outline[v115].From = v116 - unit
                  box2.corner_outline[v115].To = v117 + unit
                  box2.corner_outline[v115].Color = box.outline
                  box2.corner_outline[v115].Visible = true
                  box2.corner_fill[v115].From = v116
                  box2.corner_fill[v115].To = v117
                  box2.corner_fill[v115].Color = color
                  box2.corner_fill[v115].Visible = true
                end

                box2.outline.Visible = false
                box2.fill.Visible = false

                for i10 = 1, 12 do
                  box2.box_3d_lines[i10].Visible = false
                end
              elseif v92 == "3D" then
                if v105 and #v105 == 8 then
                  local count10 = 0

                  while true do
                    count10 = 1 + count10

                    if not (count10 <= 12) then
                      break
                    end

                    local v118 = count10
                    local v119 = v27[v118]

                    box2.box_3d_lines[v118].From = v105[v119[1]]
                    box2.box_3d_lines[v118].To = v105[v119[2]]
                    box2.box_3d_lines[v118].Color = color
                    box2.box_3d_lines[v118].Visible = visible
                  end
                else
                  for i11 = 1, 12 do
                    box2.box_3d_lines[i11].Visible = false
                  end
                end

                box2.outline.Visible = false
                box2.fill.Visible = false

                for i12 = 1, 8 do
                  box2.corner_fill[i12].Visible = false
                  box2.corner_outline[i12].Visible = false
                end
              end
            else
              box2.outline.Visible = false
              box2.fill.Visible = false

              for i13 = 1, 8 do
                box2.corner_fill[i13].Visible = false
                box2.corner_outline[i13].Visible = false
              end

              for i14 = 1, 12 do
                box2.box_3d_lines[i14].Visible = false
              end
            end
          end

          if value8.healthbar then
            local outline = value8.healthbar.outline
            local fill = value8.healthbar.fill

            if not v94 or not v103 then
              outline.Visible = false
              fill.Visible = false
            elseif humanoid then
              local v120 = v102.Y - v104.Y
              local v121 = v104.X - 3 - 1 - 1
              local v122 = v104.Y - 1
              local v123 = v120 * clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)

              outline.Color = healthbar.outline
              outline.Position = Vector2.new(v121, v122)
              outline.Size = Vector2.new(3, v120 + 2)
              outline.Visible = true

              fill.Color = healthbar.fill
              fill.Position = Vector2.new(v121 + 1, v122 + (v120 + 1) - v123)
              fill.Size = Vector2.new(1, v123)
              fill.Visible = true
            else
              outline.Visible = false
              fill.Visible = false
            end
          end

          if value8.name then
            if v95 and v103 then
              local name2 = value8.name
              local v124 = (v104.X + v102.X) / 2
              local v125 = v104.Y - 15
              local name3 = key7.Name

              if humanoid then
                if not value8.player then
                  value8.player = players:GetPlayerFromCharacter(key7)
                end

                if value8.player then
                  name3 = value8.player.Name
                end
              end

              name2.Text = name3
              name2.Size = name.size
              name2.Color = name.fill
              name2.Position = Vector2.new(v124, v125)
              name2.Visible = true
            else
              value8.name.Visible = false
            end
          end

          if value8.distance then
            if v96 and v103 then
              local distance2 = value8.distance
              local v126 = (v104.X + v102.X) / 2
              local v127 = v102.Y + 5
              local magnitude = 999

              if key7:IsA("Model") and key7.PrimaryPart then
                magnitude = (position - key7.PrimaryPart.Position).Magnitude
              elseif key7:IsA("BasePart") then
                magnitude = (position - key7.Position).Magnitude
              end

              distance2.Text = tostring(floor(magnitude)) .. "m"
              distance2.Size = distance.size
              distance2.Color = distance.fill
              distance2.Position = Vector2.new(v126, v127)
              distance2.Visible = true
            else
              value8.distance.Visible = false
            end
          end

          if value8.tracer then
            if v97 and v103 then
              local outline2 = value8.tracer.outline
              local fill2 = value8.tracer.fill

              if from == "mouse" then
                local getMouseLocation = userInputService:GetMouseLocation()
                vector2 = Vector2.new(getMouseLocation.X, getMouseLocation.Y)
              elseif from == "top" then
                vector2 = Vector2.new(viewportSize.X / 2, 0)
              elseif from == "center" then
                vector2 = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
              else
                vector2 = Vector2.new(viewportSize.X / 2, viewportSize.Y)
              end

              local to = (v104 + v102) / 2

              outline2.From = vector2
              outline2.To = to
              outline2.Color = tracer.outline
              outline2.Visible = true

              fill2.From = vector2
              fill2.To = to
              fill2.Color = color
              fill2.Visible = true
            else
              value8.tracer.outline.Visible = false
              value8.tracer.fill.Visible = false
            end
          end

          if value8.skeleton then
            if v98 and v103 then
              local boneParts = value8.skeleton.bone_parts
              local lines3 = value8.skeleton.lines
              local screenCache = value8.skeleton.screenCache

              for key8 in next, screenCache, nil do
                screenCache[key8] = nil
              end

              local v128 = #boneParts
              local count11 = 0

              while true do
                count11 = 1 + count11

                if not (v128 >= count11) then
                  break
                end

                local v129 = count11
                local v130 = boneParts[v129]
                local v131 = v130[1]
                local v132 = v130[2]
                local v133 = lines3[v129]

                if v131 and v132 and v131.Parent and v132.Parent then
                  local from2, v134 = f11(screenCache, v131)
                  local to2, v135 = f11(screenCache, v132)

                  if v134 and v135 then
                    v133.From = from2
                    v133.To = to2
                    v133.Color = color
                    v133.Thickness = skeleton.thickness
                    v133.Visible = true
                  else
                    v133.Visible = false
                  end
                else
                  v133.Visible = false
                end
              end
            else
              local lines4 = value8.skeleton.lines
              local v136 = #lines4
              local count12 = 0

              while true do
                count12 = 1 + count12

                if not (count12 <= v136) then
                  break
                end

                lines4[count12].Visible = false
              end
            end
          end

          if value8.headcircle then
            if v99 and v103 then
              local headcircle2 = value8.headcircle

              if not value8.head or not value8.head.Parent then
                value8.head = key7:FindFirstChild("Head")
              end

              local head = value8.head

              if head then
                local v137, v138 = worldToViewportPoint(currentCamera, head.Position)

                if v138 then
                  headcircle2.Position = Vector2.new(v137.X, v137.Y)
                  headcircle2.Radius = headcircle.radius or 20
                  headcircle2.Color = headcircle.fill
                  headcircle2.Thickness = headcircle.thickness or 2
                  headcircle2.Visible = true
                else
                  headcircle2.Visible = false
                end
              else
                headcircle2.Visible = false
              end
            else
              value8.headcircle.Visible = false
            end
          end
        end
      end
    end
  end
end)

for key9, value9 in next, v23, nil do
  esplib[key9] = value9
end

local v139 = {}

local function f14(p35, player)
  if not p35 then
    return
  end

  if v139[p35] then
    return
  end

  esplib.add_box(p35)
  esplib.add_name(p35)
  esplib.add_healthbar(p35)
  esplib.add_distance(p35)
  esplib.add_tracer(p35)
  esplib.add_skeleton(p35, { thickness = 2, transparency = 1 })

  v139[p35] = { player = player }
end

local function f15(p36)
  if not p36 then
    return
  end

  v139[p36] = nil
end

local function f16()
  local value10 = options.ESPBoxType.Value

  if value10 == "Disabled" then
    esplib.box.enabled = false
  else
    esplib.box.enabled = toggles.ESPEnabled.Value
    esplib.box.type = value10:gsub(" Box", "")
  end

  local name4 = esplib.name
  name4.enabled = toggles.ESPEnabled.Value and toggles.ESPName.Value

  esplib.name.fill = options.ESPNameColor.Value

  local healthbar2 = esplib.healthbar
  healthbar2.enabled = toggles.ESPEnabled.Value and toggles.ESPHealth.Value

  local distance3 = esplib.distance
  distance3.enabled = toggles.ESPEnabled.Value and toggles.ESPDistance.Value

  local tracer2 = esplib.tracer
  tracer2.enabled = toggles.ESPEnabled.Value and toggles.ESPTracer.Value

  local value11 = options.ESPTracerOrigin.Value
  esplib.tracer.from = value11:lower()

  local skeleton2 = esplib.skeleton
  skeleton2.enabled = toggles.ESPEnabled.Value and toggles.ESPSkeleton.Value
end

local v140 = true

local function f17(p37)
  if p37 == players.LocalPlayer then
    return
  end

  if p37.Character and v140 then
    f14(p37.Character, p37)
  end

  p37.CharacterAdded:Connect(function(character)
    task.wait(0.1)

    if v140 then
      f14(character, p37)
    end
  end)

  p37.CharacterRemoving:Connect(function(character2) f15(character2) end)
end

local function f18()
  for key10, value12 in next, v139, nil do
    f15(key10)
  end

  local v141 = next
  local v142, v143 = players:GetPlayers()

  for v145, v146 in v141, v142, v143 do
    if v146 ~= players.LocalPlayer and v146.Character then
      f14(v146.Character, v146)
    end
  end
end

toggles.ESPEnabled:OnChanged(function()
  f16()
  f18()
end)

options.ESPBoxType:OnChanged(function() f16() end)
toggles.ESPName:OnChanged(function() f16() end)
options.ESPNameColor:OnChanged(function() f16() end)

toggles.ESPHealth:OnChanged(function() f16() end)
toggles.ESPDistance:OnChanged(function() f16() end)
toggles.ESPTracer:OnChanged(function() f16() end)

options.ESPTracerOrigin:OnChanged(function() f16() end)
toggles.ESPSkeleton:OnChanged(function() f16() end)
local v147 = next
local v148, v149 = players:GetPlayers()

for v150, v151 in v147, v148, v149 do
  f17(v151)
end

players.PlayerAdded:Connect(function(player2) f17(player2) end)
f16()

local function f19()
  for key11, value13 in next, v139, nil do
    f15(key11)
  end
end

local function f20()
  local v152, v153 = players:GetPlayers()

  for key12, value14 in next, v152, v153 do
    if value14 ~= players.LocalPlayer and value14.Character then
      f14(value14.Character, value14)
    end
  end
end

localPlayer.CharacterRemoving:Connect(function()
  v140 = false
  f19()
end)

localPlayer.CharacterAdded:Connect(function()
  task.wait(0.5)
  v140 = true
  f20()
end)

if localPlayer.Character then
  local humanoid2 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

  if humanoid2 then
    humanoid2.Died:Connect(function()
      v140 = false
      f19()
    end)
  end
end

localPlayer.CharacterAdded:Connect(function(character3)
  local waitForChild = character3:WaitForChild("Humanoid", 5)

  if waitForChild then
    waitForChild.Died:Connect(function()
      v140 = false
      f19()
    end)
  end
end)

local circle2 = Drawing.new("Circle")
circle2.Position = workspaceService.CurrentCamera.ViewportSize / 2
circle2.Radius = 70
circle2.Color = Color3.fromRGB(255, 0, 0)
circle2.Filled = false
circle2.NumSides = 128
circle2.Thickness = 1
circle2.Visible = false

local circle3 = Drawing.new("Circle")
circle3.Position = workspaceService.CurrentCamera.ViewportSize / 2
circle3.Radius = 70
circle3.Color = Color3.fromRGB(0, 255, 0)
circle3.Filled = false
circle3.NumSides = 128
circle3.Thickness = 1
circle3.Visible = false

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.IgnoreWater = true

local count13 = 0
local v154, v155, f21

local function f22()
  local currentCamera2 = workspaceService.CurrentCamera
  local character4 = players.LocalPlayer.Character

  if not character4 or not character4:FindFirstChild("Head") then
    return
  else
    local position2 = character4.Head.Position
    local v156 = currentCamera2.ViewportSize / 2
    local huge2 = math.huge
    local v157 = nil
    local huge3 = math.huge
    local v158 = nil
    local v159, v160 = players:GetPlayers()

    for key13, value15 in next, v159, v160 do
      if value15 == localPlayer then
      else
        local character5 = value15.Character

        if not character5 then
        elseif character5:GetAttribute("Dead") then
        elseif character5:GetAttribute("Invincible") then
        else
          local head2 = character5:FindFirstChild("Head")
            or character5:FindFirstChild("HumanoidRootPart")

          if not head2 then
          else
            local v161, v162 = currentCamera2:WorldToViewportPoint(head2.Position)
            local v163 = f1(value15)

            if toggles.Ragebot.Value and v163 == false then
              local findFirstChild = character5:FindFirstChild(options.RageHitPart.Value)
                or head2

              local v164 = true

              if toggles.RagebotVisibleCheck.Value and not v162 then
                v164 = false
              end

              if v164 and toggles.RagebotWallCheck.Value and not f21(findFirstChild) then
                v164 = false
              end

              if v164 then
                local magnitude2 = (position2 - findFirstChild.Position).Magnitude

                if magnitude2 < huge3 then
                  v158 = findFirstChild
                  huge3 = magnitude2
                end
              end
            end

            if toggles.SilentAim.Value and v162 then
              if not toggles.SilentTeamCheck.Value or not v163 then
                local magnitude3 = (Vector2.new(v161.X, v161.Y) - v156).Magnitude

                if magnitude3 <= (toggles.SilentUseFovCircle.Value and circle2.Radius or 999999) then
                  if magnitude3 < huge2 then
                    if not toggles.SilentWallbang.Value then
                      if not f21(head2) then
                      else
                        ::L6073241::
                        v157 = head2
                        huge2 = magnitude3
                        ::L2565175::
                        ::L2170075::
                        ::L1255586::
                        ::L13162153::

                        if toggles.Aimbot.Value and v162 then
                          if not toggles.AimbotTeamCheck.Value or not v163 then
                            if (Vector2.new(v161.X, v161.Y) - v156).Magnitude
                              <= (toggles.AimbotUseFovCircle.Value and circle3.Radius or 999999) then
                              v671 = not toggles.AimbotWallCheck.Value or f21(head2)
                            end
                          end
                        end
                      end
                    else
                      goto L6073241
                    end
                  else
                    goto L2565175
                  end
                else
                  goto L2170075
                end
              else
                goto L1255586
              end
            else
              goto L13162153
            end
          end
        end
      end
    end

    v154 = v157
    v155 = v158
    return
  end
end

function f21(p38)
  raycastParams.FilterDescendantsInstances = { players.LocalPlayer.Character }

  local raycast = workspaceService:Raycast(workspaceService.CurrentCamera.CFrame.Position, p38.Position
    - workspaceService.CurrentCamera.CFrame.Position, raycastParams)

  if raycast then
    return players:GetPlayerFromCharacter(raycast.Instance:FindFirstAncestorOfClass("Model"))
      ~= nil
  end

  return true
end

runService.RenderStepped:Connect(function()
  count13 = count13 + 1
  circle2.Position = workspaceService.CurrentCamera.ViewportSize / 2
  circle3.Position = workspaceService.CurrentCamera.ViewportSize / 2
  circle2.Visible = toggles.SilentAim.Value and toggles.SilentUseFovCircle.Value
  circle3.Visible = toggles.Aimbot.Value and toggles.AimbotUseFovCircle.Value
  circle2.Radius = options.SilentFovCircleRadius.Value
  circle3.Radius = options.AimbotFovCircleRadius.Value

  if count13 % 3 == 0 then
    f22()
  end

  local v165, v166 = players:GetPlayers()

  for key14, value16 in next, v165, v166 do
    if value16 ~= localPlayer and value16.Character
      and value16.Character:FindFirstChild("HumanoidRootPart") then
      local humanoidRootPart = value16.Character:FindFirstChild("HumanoidRootPart")

      if toggles.Hitbox.Value and not f1(value16) and true then
        humanoidRootPart.Size = Vector3.new(
          options.HitboxSize.Value, options.HitboxSize.Value, options.HitboxSize.Value
        )

        humanoidRootPart.Transparency = options.HitboxTransparency.Value
      elseif humanoidRootPart.Size.X ~= Vector3.new(2, 2, 2) then
        humanoidRootPart.Size = Vector3.new(2, 2, 2)
        humanoidRootPart.Transparency = 1
      end
    end
  end
end)

local v167 = {}
local v168 = {}

pcall(function(...)
  v144 = filtergc("table", { Keys = { "updateCamera" } }, true).updateCamera
end)

local v169

local function f23()
  local v170, v171 = pcall(function() return debug.getupvalue(v169, 1).CurrentEquipped end)

  if not v170 then
    return nil
  end

  return v171
end

local v172

task.spawn(function()
  while task.wait(1) do
    pcall(function()
      if f23 then
        v172 = f23()
      end
    end)
  end
end)

task.spawn(function()
  while true do
    wait()
    break
  end

  library:Notify({ Title = "Success", Description = "Hitbox will now work", Time = 4 })
end)

task.spawn(function()
  while true do
    task.wait(options.RageDelay.Value or 0.02)

    if toggles.Ragebot.Value and v155 and v172 and v172.IsEquipped and v172.Rounds > 0 then
      v172:shoot()
    end
  end
end)

task.spawn(function()
  while true do
    task.wait(options.TriggerbotDelay.Value or 0)

    if toggles.Triggerbot.Value then
      local getMouse = localPlayer:GetMouse()

      if getMouse and getMouse.Target then
        local model = getMouse.Target:FindFirstAncestorOfClass("Model")

        if not model then
        else
          local getPlayerFromCharacter = players:GetPlayerFromCharacter(model)

          if not getPlayerFromCharacter then
          elseif model:GetAttribute("Dead") then
          elseif model:GetAttribute("Invincible") then
          elseif f1(getPlayerFromCharacter) then
            if v172 and v172.IsEquipped and v172.Rounds > 0 then
              v172:shoot()
            end
          end
        end
      end
    end
  end
end)

local v173, v174

pcall(function(...)
  v174 = hookfunction(v173, function(...)
    local v175 = { ... }

    if v175[1].Bullets[1].Hits[1] then
      if toggles.Ragebot.Value and v155 then
        v175[1].Bullets[1].Hits[1].Instance = v155
        v175[1].Bullets[1].Hits[1].Position = v155.Position
      end

      if toggles.SilentAim.Value and v154 then
        v175[1].Bullets[1].Hits[1].Instance = v154
        v175[1].Bullets[1].Hits[1].Position = v154.Position
      end
    end

    return v174(unpack(v175))
  end)
end)

task.spawn(function()
  while task.wait(0.05) do
    pcall(function()
      if toggles.Firerate.Value then
        for key15, value17 in next, v168, nil do
          local v176 = value17

          pcall(function()
            setreadonly(v176, false)
            rawset(v176, "FireRate", math.max(options.FirerateSlider.Value, 0.01))
            setreadonly(v176, true)
          end)
        end
      else
        for key16, value18 in next, v168, nil do
          local v177 = key16
          local v178 = value18

          pcall(function()
            setreadonly(v178, false)
            rawset(v178, "FireRate", v167[v177].FireRate)
            setreadonly(v178, true)
          end)
        end
      end
    end)
  end
end)

themeManager:SetLibrary(library)

saveManager:SetLibrary(library)
saveManager:IgnoreThemeSettings()
saveManager:SetIgnoreIndexes({ "MenuKeybind" })

themeManager:SetFolder("l10hub")

saveManager:SetFolder("l10hub/bloxstrike")
saveManager:SetSubFolder("bloxstrike")
saveManager:BuildConfigSection(v1.Settings)

themeManager:ApplyToTab(v1.Settings)
saveManager:LoadAutoloadConfig()
