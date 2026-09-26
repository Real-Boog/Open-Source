-- this is for BloxStrike

local runService = game:GetService("RunService")
local workspaceService = game:GetService("Workspace")
local userInputService = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local tweenService = game:GetService("TweenService")
local contextActionService = game:GetService("ContextActionService")
local lighting = game:GetService("Lighting")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local currentCamera = workspaceService.CurrentCamera
localPlayer:GetMouse()
local weapons = replicatedStorage:WaitForChild("Database"):WaitForChild("Custom"):WaitForChild("Weapons")

local v1 = {
  AWP = true,
  ["SSG 08"] = true,
  G3SG1 = true,
  ["SCAR-20"] = true,
}

local v2 = {}

for index, value in ipairs(weapons:GetChildren()) do
  if value:IsA("ModuleScript") then
    local v3, v4 = pcall(require, value)

    if v3 and type(v4) == "table" then
      setreadonly(v4, false)

      local v5 = {
        WalkSpeed = v4.WalkSpeed,
        Spread = v4.Spread and {
          Range = v4.Spread.Range,
          PerShot = v4.Spread.PerShot,
          MovementMultiplier = v4.Spread.MovementMultiplier,
          JumpShotMinimum = v4.Spread.JumpShotMinimum,
        } or nil,
        FireModes = {},
      }

      if v4.FireModes then
        for key, value2 in pairs(v4.FireModes) do
          if value2.Spread then
            v5.FireModes[key] = {
              Spread = {
                Range = value2.Spread.Range,
                PerShot = value2.Spread.PerShot,
                MovementMultiplier = value2.Spread.MovementMultiplier,
                JumpShotMinimum = value2.Spread.JumpShotMinimum,
              },
            }
          end
        end
      end

      v2[value.Name] = { Data = v4, Original = v5, IsSniper = v1[value.Name] or false }
      setreadonly(v4, true)
    end
  end
end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"))()
local themeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua"))()
local saveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/SaveManager.lua"))()
local options = library.Options
local toggles = library.Toggles

local thegxxHubWindow = library:CreateWindow({
  Title = "ThegxxHub",
  Center = true,
  AutoShow = true,
  Resizable = true,
  ShowCustomCursor = true,
})

thegxxHubWindow:SetCornerRadius(8)

local v6 = {
  Combat = thegxxHubWindow:AddTab("Combat", "swords"),
  ESP = thegxxHubWindow:AddTab("ESP", "eye"),
  Skins = thegxxHubWindow:AddTab("Skins", "palette"),
  Viewmodel = thegxxHubWindow:AddTab("Viewmodel", "camera"),
  Misc = thegxxHubWindow:AddTab("Misc", "zap"),
  Settings = thegxxHubWindow:AddTab("Settings", "settings"),
}

local values = {
  "Plastic", "SmoothPlastic", "Neon", "ForceField", "Glass", "Foil", "Metal", "Wood", "Marble",
  "Fabric",
}

local aimbotAssistSmooth = v6.Combat:AddLeftGroupbox("Aimbot Assist (Smooth)")
aimbotAssistSmooth:AddToggle("AimbotEnabled", { Text = "Enable Smooth Aim", Default = false })

aimbotAssistSmooth:AddLabel("Aim Key"):AddKeyPicker("AimbotKey", {
  Default = "E",
  Mode = "Hold",
  Text = "Aim",
})

aimbotAssistSmooth:AddDropdown("AimbotTargetPart", {
  Values = { "Head", "HumanoidRootPart" },
  Default = 1,
  Text = "Target",
})

aimbotAssistSmooth:AddSlider("AimbotSmoothing", {
  Text = "Smoothing",
  Default = 3,
  Min = 1,
  Max = 10,
  Rounding = 1,
})

v6.Combat:AddLeftGroupbox("Aimbot Checkers"):AddToggle("AimbotWallCheck", {
  Text = "Wall Check (Visibility)",
  Default = true,
})

local fieldOfViewFOV = v6.Combat:AddLeftGroupbox("Field of View (FOV)")

fieldOfViewFOV:AddToggle("ShowFOV", { Text = "Show FOV Circle", Default = false }):AddColorPicker("ColorFOV", {
  Default = Color3.fromRGB(220, 20, 60),
  Title = "FOV Color",
})

fieldOfViewFOV:AddSlider("FOVRadius", {
  Text = "FOV Radius",
  Default = 100,
  Min = 10,
  Max = 500,
  Rounding = 1,
})

local antiAimSystem = v6.Combat:AddLeftGroupbox("Anti-Aim System")
antiAimSystem:AddToggle("AAEnabled", { Text = "Enable Anti-Aim", Default = false })

antiAimSystem:AddDropdown("AAYaw", {
  Text = "Yaw Angle (X/Z)",
  Values = { "Spinbot", "Jitter", "Backward", "Sideways" },
  Default = 1,
})

antiAimSystem:AddSlider("AASpeed", {
  Text = "Spin Speed",
  Default = 50,
  Min = 10,
  Max = 150,
  Rounding = 0,
})

local triggerBot = v6.Combat:AddRightGroupbox("TriggerBot")
triggerBot:AddToggle("TriggerBotEnabled", { Text = "Enable TriggerBot", Default = false })

triggerBot:AddSlider("TriggerBotDelay", {
  Text = "Shot Delay (ms)",
  Default = 0,
  Min = 0,
  Max = 500,
  Rounding = 0,
  Suffix = "ms",
})

local combatExploits = v6.Combat:AddRightGroupbox("Combat Exploits")
combatExploits:AddToggle("HitboxEnabled", { Text = "Expand Hitboxes", Default = false })

combatExploits:AddSlider("HitboxSize", {
  Text = "Hitbox Size",
  Default = 3,
  Min = 1,
  Max = 3,
  Rounding = 1,
})

combatExploits:AddSlider("HitboxTransparency", {
  Text = "Hitbox Transparency",
  Default = 100,
  Min = 0,
  Max = 100,
  Rounding = 0,
  Suffix = "%",
})

v6.Combat:AddRightGroupbox("Gun Mechanics"):AddToggle("NoSpreadNonSnipers", {
  Text = "No Spread (Except Snipers)",
  Default = false,
  Tooltip = "Activates Laser Mode on everything except AWP/Scout.",
})

local visualSettings = v6.ESP:AddLeftGroupbox("Visual Settings")
visualSettings:AddToggle("EnableESP", { Text = "Enable Master ESP", Default = false })

visualSettings:AddToggle("ESP_WallCheck", { Text = "Change Color if Visible", Default = false }):AddColorPicker("Color_ESP_Visible", {
  Default = Color3.fromRGB(0, 255, 0),
  Title = "Visible Color",
})

visualSettings:AddDivider()

visualSettings:AddToggle("ESP_Box", { Text = "Show Box", Default = true }):AddColorPicker("Color_ESP_Box", {
  Default = Color3.fromRGB(220, 20, 60),
  Title = "Hidden Color",
})

visualSettings:AddToggle("ESP_Name", { Text = "Show Name", Default = true }):AddColorPicker("Color_ESP_Name", {
  Default = Color3.fromRGB(255, 255, 255),
  Title = "Name Color",
})

visualSettings:AddToggle("ESP_Skeleton", { Text = "Show Skeleton", Default = false }):AddColorPicker("Color_ESP_Skeleton", {
  Default = Color3.fromRGB(255, 255, 255),
  Title = "Skeleton Color",
})

visualSettings:AddToggle("ESP_Chams", { Text = "Show Chams", Default = false }):AddColorPicker("Color_ESP_Chams", {
  Default = Color3.fromRGB(220, 20, 60),
  Title = "Chams Color",
})

visualSettings:AddToggle("ESP_Bar", { Text = "Show Health Bar", Default = true })
visualSettings:AddToggle("ESP_Text", { Text = "Show Health (Text)", Default = true })

v6.Viewmodel:AddLeftGroupbox("Master"):AddToggle("EnableVM", {
  Text = "Enable Viewmodel Colors",
  Default = false,
})

local weapon = v6.Viewmodel:AddLeftGroupbox("Weapon")

weapon:AddLabel("Color"):AddColorPicker("Color_Weapon", {
  Default = Color3.fromRGB(220, 20, 60),
})

weapon:AddDropdown("Mat_Weapon", { Values = values, Default = 3 })

local arms = v6.Viewmodel:AddLeftGroupbox("Arms")
arms:AddLabel("Color"):AddColorPicker("Color_Arms", { Default = Color3.fromRGB(255, 255, 255) })
arms:AddDropdown("Mat_Arms", { Values = values, Default = 2 })

local gloves = v6.Viewmodel:AddRightGroupbox("Gloves")
gloves:AddLabel("Color"):AddColorPicker("Color_Gloves", { Default = Color3.fromRGB(20, 20, 20) })
gloves:AddDropdown("Mat_Gloves", { Values = values, Default = 2 })

local sleeves = v6.Viewmodel:AddRightGroupbox("Sleeves")

sleeves:AddLabel("Color"):AddColorPicker("Color_Sleeves", {
  Default = Color3.fromRGB(40, 40, 40),
})

sleeves:AddDropdown("Mat_Sleeves", { Values = values, Default = 2 })

v6.Misc:AddLeftGroupbox("Utilities"):AddToggle("BunnyHop", {
  Text = "Perfect Bunny Hop",
  Default = false,
})

local worldEffects = v6.Misc:AddLeftGroupbox("World & Effects")
worldEffects:AddToggle("AntiFlashToggle", { Text = "Anti-Flashbang", Default = false })
worldEffects:AddToggle("AntiSmokeToggle", { Text = "Anti-Smoke", Default = false })

local movementMods = v6.Misc:AddRightGroupbox("Movement Mods")
movementMods:AddToggle("WalkSpeedMod", { Text = "Enable Super Speed", Default = false })

movementMods:AddSlider("SpeedSlider", {
  Text = "Target Speed",
  Default = 60,
  Min = 16,
  Max = 150,
  Rounding = 1,
  Suffix = " studs",
})

local cameraModsThirdPerson = v6.Misc:AddRightGroupbox("Camera Mods (Third Person)")

cameraModsThirdPerson:AddToggle("TPEnabled", { Text = "Enable Third Person", Default = false }):AddKeyPicker("TPKey", {
  Default = "V",
  SyncToggleState = true,
  Mode = "Toggle",
  Text = "Third Person",
})

cameraModsThirdPerson:AddToggle("TPHideVM", { Text = "Hide Viewmodel in TP", Default = true })

cameraModsThirdPerson:AddSlider("TPDistance", {
  Text = "Camera Distance",
  Default = 10,
  Min = 5,
  Max = 30,
  Rounding = 1,
})

cameraModsThirdPerson:AddSlider("TPOffsetX", {
  Text = "Shoulder Offset",
  Default = 2,
  Min = -5,
  Max = 5,
  Rounding = 1,
})

local function f1(p1, p2, p3)
  if not p1 or not p2 then
    return
  end

  pcall(setreadonly, p1, false)

  if p3 then
    if p1.Range then
      p1.Range = NumberRange.new(0, 0)
    end

    if p1.PerShot then
      p1.PerShot = 0
    end

    if p1.MovementMultiplier then
      p1.MovementMultiplier = 0
    end

    if p1.JumpShotMinimum then
      p1.JumpShotMinimum = 0
    end
  else
    if p1.Range then
      p1.Range = p2.Range
    end

    if p1.PerShot then
      p1.PerShot = p2.PerShot
    end

    if p1.MovementMultiplier then
      p1.MovementMultiplier = p2.MovementMultiplier
    end

    if p1.JumpShotMinimum then
      p1.JumpShotMinimum = p2.JumpShotMinimum
    end
  end

  pcall(setreadonly, p1, true)
end

toggles.NoSpreadNonSnipers:OnChanged(function(p4)
  for key2, value3 in pairs(v2) do
    if not value3.IsSniper then
      setreadonly(value3.Data, false)

      if value3.Data.Spread and value3.Original.Spread then
        f1(value3.Data.Spread, value3.Original.Spread, p4)
      end

      if value3.Data.FireModes then
        for key3, value4 in pairs(value3.Data.FireModes) do
          if value4.Spread and value3.Original.FireModes[key3]
            and value3.Original.FireModes[key3].Spread then
            f1(value4.Spread, value3.Original.FireModes[key3].Spread, p4)
          end
        end
      end

      setreadonly(value3.Data, true)
    end
  end
end)

local function f2()
  local value5 = toggles.WalkSpeedMod.Value
  local value6 = options.SpeedSlider.Value

  for key4, value7 in pairs(v2) do
    if value7.Original.WalkSpeed then
      setreadonly(value7.Data, false)

      local data = value7.Data
      data.WalkSpeed = value5 and value6 or value7.Original.WalkSpeed

      setreadonly(value7.Data, true)
    end
  end
end

toggles.WalkSpeedMod:OnChanged(f2)

options.SpeedSlider:OnChanged(function()
  if toggles.WalkSpeedMod.Value then
    f2()
  end
end)

local function f3(p5, p6)
  local position = currentCamera.CFrame.Position
  local v7 = p5.Position - position
  local v8 = { currentCamera }

  if localPlayer.Character then
    table.insert(v8, localPlayer.Character)
  end

  if p6 then
    table.insert(v8, p6)
  end

  local raycastParams = RaycastParams.new()
  raycastParams.FilterType = Enum.RaycastFilterType.Exclude
  raycastParams.FilterDescendantsInstances = v8

  return workspaceService:Raycast(position, v7, raycastParams) == nil
end

local waitForChild = workspaceService:WaitForChild("Characters", 10)

local function f4()
  return waitForChild and waitForChild:FindFirstChild("Terrorists")
end

local function f5()
  return waitForChild and waitForChild:FindFirstChild("Counter-Terrorists")
end

local f6

local function f7()
  if not f6() then
    return nil
  else
    local v9 = f4()
    local v10 = f5()

    if v9 and v9:FindFirstChild(localPlayer.Name) then
      return v10
    end

    if v10 and v10:FindFirstChild(localPlayer.Name) then
      return v9
    end

    return nil
  end
end

function f6()
  local v11 = f4()
  local v12 = f5()

  return v11 and v11:FindFirstChild(localPlayer.Name)
    or v12 and v12:FindFirstChild(localPlayer.Name)
end

local function f8(p7)
  local humanoid = p7:FindFirstChildOfClass("Humanoid")

  if humanoid then
    return humanoid.Health, humanoid.MaxHealth
  end

  return 100, 100
end

local v13 = {}
local v14 = {}

task.spawn(function()
  while task.wait(0.2) do
    local v15 = f7()

    if v15 then
      for index2, value8 in ipairs(v15:GetChildren()) do
        local head = value8:FindFirstChild("Head")
        local humanoid2 = value8:FindFirstChildOfClass("Humanoid")

        if head and humanoid2 and humanoid2.Health > 0 then
          if not v13[head] then
            v13[head] = head.Size
          end

          if toggles.HitboxEnabled and toggles.HitboxEnabled.Value then
            local value9 = options.HitboxSize.Value
            local transparency = options.HitboxTransparency.Value / 100

            if not v14[head] or not v14[head].Parent then
              local thegxxFakeHead = Instance.new("Part")
              thegxxFakeHead.Name = "ThegxxFakeHead"
              thegxxFakeHead.Size = v13[head]
              thegxxFakeHead.CFrame = head.CFrame
              thegxxFakeHead.Color = head.Color
              thegxxFakeHead.Material = head.Material
              thegxxFakeHead.Transparency = 0
              thegxxFakeHead.CanCollide = false
              thegxxFakeHead.Massless = true
              thegxxFakeHead.CastShadow = false

              local face = head:FindFirstChild("face")

              local decal = face
              decal = face or head:FindFirstChildOfClass("Decal")

              if decal then
                decal:Clone().Parent = thegxxFakeHead
              end

              local weldConstraint = Instance.new("WeldConstraint")
              weldConstraint.Part0 = head
              weldConstraint.Part1 = thegxxFakeHead
              weldConstraint.Parent = thegxxFakeHead

              thegxxFakeHead.Parent = value8
              v14[head] = thegxxFakeHead
            end

            head.Size = Vector3.new(value9, value9, value9)
            head.CanCollide = false
            head.Transparency = transparency

            for index3, value10 in ipairs(head:GetChildren()) do
              if value10:IsA("Decal") then
                value10.Transparency = 1
              end
            end
          else
            if v13[head] and head.Size ~= v13[head] then
              head.Size = v13[head]
              head.Transparency = 0

              for index4, value11 in ipairs(head:GetChildren()) do
                if value11:IsA("Decal") then
                  value11.Transparency = 0
                end
              end
            end

            if v14[head] then
              v14[head]:Destroy()
              v14[head] = nil
            end
          end
        end
      end
    end
  end
end)

task.spawn(function()
  while task.wait(0.01) do
    if toggles.TriggerBotEnabled and toggles.TriggerBotEnabled.Value and f6() then
      local viewportSize = currentCamera.ViewportSize

      local viewportPointToRay = currentCamera:ViewportPointToRay(
        viewportSize.X / 2, viewportSize.Y / 2
      )

      local raycastParams2 = RaycastParams.new()
      raycastParams2.FilterType = Enum.RaycastFilterType.Exclude

      local v16 = { currentCamera }

      if localPlayer.Character then
        table.insert(v16, localPlayer.Character)
      end

      raycastParams2.FilterDescendantsInstances = v16

      local raycast = workspaceService:Raycast(
        viewportPointToRay.Origin, viewportPointToRay.Direction * 1000, raycastParams2
      )

      if raycast and raycast.Instance then
        local model = raycast.Instance:FindFirstAncestorOfClass("Model")

        if model and model:FindFirstChildOfClass("Humanoid") then
          local v17 = f7()

          if v17 and model.Parent == v17 then
            local humanoid3 = model:FindFirstChildOfClass("Humanoid")

            if humanoid3 and humanoid3.Health > 0 then
              local value12 = options.TriggerBotDelay.Value

              if value12 > 0 then
                task.wait(value12 / 1000)
              end

              if currentCamera:FindFirstChild("R8 Revolver") then
                if not toggles.NoSpreadNonSnipers.Value then
                  toggles.NoSpreadNonSnipers:SetValue(true)
                end

                if mouse2click then
                  mouse2click()
                end
              elseif mouse1click then
                mouse1click()
              end

              task.wait(0.05)
            end
          end
        end
      end
    end
  end
end)

local circle = Drawing.new("Circle")
circle.Filled = false
circle.Thickness = 1
circle.Visible = false

local function f9()
  local value13 = options.FOVRadius.Value
  local v18 = f7()
  local v19 = not v18 or not toggles.AimbotEnabled.Value
  local v20

  if v19 then
    return nil
  else
    local getMouseLocation = userInputService:GetMouseLocation()
    local value14 = options.AimbotTargetPart.Value

    for index5, value15 in ipairs(v18:GetChildren()) do
      local humanoid4 = value15:FindFirstChildOfClass("Humanoid")
      local findFirstChild = value15:FindFirstChild(value14)

      local head2 = findFirstChild
      head2 = findFirstChild or value15:FindFirstChild("Head")

      if humanoid4 and humanoid4.Health > 0 and head2 then
        if toggles.AimbotWallCheck.Value and not f3(head2, value15) then
        else
          local v21, v22 = currentCamera:WorldToViewportPoint(head2.Position)

          if v22 then
            local magnitude = (Vector2.new(v21.X, v21.Y) - getMouseLocation).Magnitude

            if magnitude < value13 then
              v20 = head2
              value13 = magnitude
            end
          end
        end
      end
    end

    return v20
  end
end

local skins = replicatedStorage:WaitForChild("Assets"):WaitForChild("Skins")
local v23 = false
local v24 = {}
local v25 = {}

local v26 = {
  ["USP-S"] = true,
  ["Five-SeveN"] = true,
  MP9 = true,
  FAMAS = true,
  ["M4A1-S"] = true,
  M4A4 = true,
  AUG = true,
  ["MAG-7"] = true,
  ["SCAR-20"] = true,
  MP7 = true,
}

local v27 = {
  ["Glock-18"] = true,
  ["Tec-9"] = true,
  ["MAC-10"] = true,
  ["Galil AR"] = true,
  ["AK-47"] = true,
  ["SG 553"] = true,
  ["Sawed-Off"] = true,
  G3SG1 = true,
}

local v28 = {
  P250 = true,
  ["Desert Eagle"] = true,
  ["Dual Berettas"] = true,
  ["R8 Revolver"] = true,
  Negev = true,
  M249 = true,
  P90 = true,
  ["UMP-45"] = true,
  ["PP-Bizon"] = true,
  Nova = true,
  XM1014 = true,
  AWP = true,
  ["SSG 08"] = true,
  ["Zeus x27"] = true,
}

local v29 = {
  Karambit = true,
  ["Butterfly Knife"] = true,
  ["M9 Bayonet"] = true,
  ["Flip Knife"] = true,
  ["Gut Knife"] = true,
  ["T Knife"] = true,
  ["CT Knife"] = true,
}

local v30 = { ["Sports Gloves"] = true }

local v31 = {
  ["HE Grenade"] = true,
  ["Incendiary Grenade"] = true,
  Molotov = true,
  ["Smoke Grenade"] = true,
  Flashbang = true,
  ["Decoy Grenade"] = true,
  C4 = true,
  ["CT Glove"] = true,
  ["T Glove"] = true,
}

local masterSkinChanger = v6.Skins:AddLeftGroupbox("Master Skin Changer")

masterSkinChanger:AddToggle("SkinChangerToggle", {
  Text = "Enable Skin Changer",
  Default = false,
  Callback = function(value16)
    v23 = value16

    if not value16 then
      for index6, value17 in ipairs(currentCamera:GetChildren()) do
        value17:SetAttribute("SkinApplied", nil)
      end
    end
  end,
})

masterSkinChanger:AddButton({
  Text = "Randomize Skins",
  Func = function()
    for key5, value18 in pairs(v25) do
      local v32 = {}

      for index7, value19 in ipairs(value18) do
        if value19 ~= "Stock" and value19 ~= "Vanilla" then
          table.insert(v32, value19)
        end
      end

      if #v32 > 0 then
        local v33 = v32[math.random(1, #v32)]

        if options["Skin_" .. key5] then
          options["Skin_" .. key5]:SetValue(v33)
        end
      end
    end
  end,
})

local customKnivesAndGloves = v6.Skins:AddLeftGroupbox("Custom Knives and Gloves")
local ctWeapons = v6.Skins:AddRightGroupbox("CT Weapons")
local tWeapons = v6.Skins:AddRightGroupbox("T Weapons")
local sharedWeapons = v6.Skins:AddRightGroupbox("Shared Weapons")

local function f10(p8)
  if not p8 or not v23 or not f6() then
    return
  end

  local v34 = v24[p8.Name]

  if not v34 then
    return
  end

  pcall(function()
    local findFirstChild2 = skins:FindFirstChild(p8.Name)

    if not findFirstChild2 then
      return
    else
      local findFirstChild3 = findFirstChild2:FindFirstChild(v34)

      local factoryNew = findFirstChild3 and findFirstChild3:FindFirstChild("Camera")
        and findFirstChild3.Camera:FindFirstChild("Factory New")

      if not factoryNew then
        return
      end

      for index8, value20 in ipairs(currentCamera:GetChildren()) do
        if value20:FindFirstChild("Left Arm") or value20:FindFirstChild("Right Arm") then
          local sportsGloves = skins:FindFirstChild("Sports Gloves")

          local findFirstChild4 = sportsGloves

          findFirstChild4 = sportsGloves
            and sportsGloves:FindFirstChild(v24["Sports Gloves"] or "")

          local factoryNew2 = findFirstChild4 and findFirstChild4:FindFirstChild("Camera")
            and findFirstChild4.Camera:FindFirstChild("Factory New")

          if factoryNew2 then
            for index9, value21 in ipairs({ "Left Arm", "Right Arm" }) do
              local findFirstChild5 = value20:FindFirstChild(value21)
              local findFirstChild6 = factoryNew2:FindFirstChild(value21)

              if findFirstChild5 and findFirstChild6 then
                local glove = findFirstChild5:FindFirstChild("Glove")

                if glove then
                  local surfaceAppearance = glove:FindFirstChildOfClass("SurfaceAppearance")

                  if surfaceAppearance then
                    surfaceAppearance:Destroy()
                  end

                  local surfaceAppearance2 = findFirstChild6:Clone()
                  surfaceAppearance2.Name = "SurfaceAppearance"
                  surfaceAppearance2.Parent = glove
                end
              end
            end
          end
        end
      end

      if not v30[p8.Name] then
        local weapon2 = p8:FindFirstChild("Weapon")

        if weapon2 then
          for index10, value22 in ipairs(weapon2:GetDescendants()) do
            if value22:IsA("BasePart") then
              local findFirstChild7 = factoryNew:FindFirstChild(value22.Name)

              if findFirstChild7 then
                local surfaceAppearance3 = value22:FindFirstChildOfClass("SurfaceAppearance")

                if surfaceAppearance3 then
                  surfaceAppearance3:Destroy()
                end

                local surfaceAppearance4 = findFirstChild7:Clone()
                surfaceAppearance4.Name = "SurfaceAppearance"
                surfaceAppearance4.Parent = value22
              end
            end
          end
        end
      end

      p8:SetAttribute("SkinApplied", v34)
      return
    end
  end)
end

local function f11(p9, p10)
  local findFirstChild8 = skins:FindFirstChild(p10)

  if not findFirstChild8 then
    return
  else
    local v35 = {}

    for index11, value23 in ipairs(findFirstChild8:GetChildren()) do
      table.insert(v35, value23.Name)
    end

    v25[p10] = v35

    if not v24[p10] then
      v24[p10] = v35[1]
    end

    p9:AddDropdown("Skin_" .. p10, {
      Values = v35,
      Default = 1,
      Multi = false,
      Text = p10,
      Callback = function(value24)
        v24[p10] = value24

        for index12, value25 in ipairs(currentCamera:GetChildren()) do
          value25:SetAttribute("SkinApplied", nil)
          f10(value25)
        end
      end,
    })

    return
  end
end

for key6 in pairs(v29) do
  f11(customKnivesAndGloves, key6)
end

for key7 in pairs(v30) do
  f11(customKnivesAndGloves, key7)
end

for key8 in pairs(v26) do
  f11(ctWeapons, key8)
end

for key9 in pairs(v27) do
  f11(tWeapons, key9)
end

for key10 in pairs(v28) do
  f11(sharedWeapons, key10)
end

for index13, value26 in ipairs(skins:GetChildren()) do
  local name = value26.Name

  if not v31[name] and not v29[name] and not v30[name] and not v26[name] and not v27[name]
    and not v28[name] then
    f11(sharedWeapons, name)
  end
end

currentCamera.ChildAdded:Connect(function(child)
  if v23 and f6() then
    task.wait(0.1)
    f10(child)
  end
end)

local v36 = false
local v37 = "Butterfly Knife"
local v38 = false
local v39 = false
local v40 = false
local v41 = 0

local v42 = {
  Karambit = { Offset = CFrame.new(0, -1.5, 1.5) },
  ["Butterfly Knife"] = { Offset = CFrame.new(0, -1.5, 1.5) },
  ["M9 Bayonet"] = { Offset = CFrame.new(0, -1.5, 1) },
  ["Flip Knife"] = { Offset = CFrame.new(0, -1.5, 1.25) },
  ["Gut Knife"] = { Offset = CFrame.new(0, -1.5, 0.5) },
}

local function f12()
  return currentCamera:FindFirstChild("T Knife") or currentCamera:FindFirstChild("CT Knife")
end

local clone, animator

local function f13()
  v38 = false

  contextActionService:UnbindAction("InspectKnifeAction")
  contextActionService:UnbindAction("AttackKnifeAction")

  if clone then
    clone:Destroy()
    clone = nil
  end

  animator = nil
  v39 = false
  v40 = false
end

local function f14(p11)
  if not p11:IsA("BasePart") then
    return
  end

  p11.CanCollide = false
  p11.Anchored = false
  p11.CastShadow = false
  p11.CanTouch = false
  p11.CanQuery = false
end

local loadAnimation, loadAnimation2, loadAnimation3, loadAnimation4, loadAnimation5,
  loadAnimation6

local function f15(p12, p13)
  if p13 ~= Enum.UserInputState.Begin or not v38 or not animator or not f6() then
    return Enum.ContextActionResult.Pass
  elseif p12 == "InspectKnifeAction" then
    if loadAnimation and loadAnimation.IsPlaying or v39 or v40 then
      return Enum.ContextActionResult.Pass
    end

    v39 = true

    if loadAnimation2 then
      loadAnimation2:Stop()
    end

    loadAnimation3:Play()
    loadAnimation3.Stopped:Once(function() v39 = false end)

    return Enum.ContextActionResult.Pass
  elseif p12 == "AttackKnifeAction" then
    local v43 = os.clock()

    if loadAnimation and loadAnimation.IsPlaying or v43 - v41 < 1 then
      return Enum.ContextActionResult.Pass
    else
      v41 = v43

      if v39 then
        v39 = false

        if loadAnimation3 then
          loadAnimation3:Stop()
        end
      end

      v40 = true

      if loadAnimation2 then
        loadAnimation2:Stop()
      end

      local v44 = { loadAnimation4, loadAnimation5, loadAnimation6 }

      local v45 = v44[math.random(1, #v44)]
      v45:Play()
      v45.Stopped:Once(function() v40 = false end)

      return Enum.ContextActionResult.Pass
    end
  else
    return Enum.ContextActionResult.Pass
  end
end

local function f16(p14, p15, p16, name2, c0)
  local findFirstChild9 = clone:FindFirstChild(p15)

  if not findFirstChild9 then
    return
  else
    local clone2 = p14:WaitForChild(p16):Clone()
    f14(clone2)

    clone2.Name = name2
    clone2.Parent = findFirstChild9

    local motor6D = Instance.new("Motor6D")
    motor6D.Part0 = findFirstChild9
    motor6D.Part1 = clone2
    motor6D.C0 = c0
    motor6D.Parent = findFirstChild9

    return
  end
end

local function f17(p17)
  if v38 or not v36 then
    return
  else
    local v46 = f6()

    if not v46 then
      return
    else
      v38 = true
      clone = replicatedStorage.Assets.Weapons:WaitForChild(v37):WaitForChild("Camera"):Clone()
      local v47 = clone
      clone.Name = v37
      v47.Parent = currentCamera

      for index14, value27 in ipairs(clone:GetDescendants()) do
        f14(value27)
      end

      for index15, value28 in ipairs(p17:GetDescendants()) do
        if value28:IsA("BasePart") or value28:IsA("MeshPart") or value28:IsA("Texture") then
          value28.Transparency = 1
        end
      end

      if v46.Parent.Name == "Terrorists" then
        local tGlove = replicatedStorage.Assets.Weapons:WaitForChild("T Glove")
        f16(tGlove, "Left Arm", "Left Arm", "Glove", CFrame.new(0, 0, -1.5))
        f16(tGlove, "Right Arm", "Right Arm", "Glove", CFrame.new(0, 0, -1.5))
      else
        local idf = replicatedStorage.Assets.Sleeves:WaitForChild("IDF")
        local ctGlove = replicatedStorage.Assets.Weapons:WaitForChild("CT Glove")

        f16(idf, "Left Arm", "Left Arm", "Sleeve", CFrame.new(0, 0, 0.5))
        f16(ctGlove, "Left Arm", "Left Arm", "Glove", CFrame.new(0, 0, -1.5))
        f16(idf, "Right Arm", "Right Arm", "Sleeve", CFrame.new(0, 0, 0.5))
        f16(ctGlove, "Right Arm", "Right Arm", "Glove", CFrame.new(0, 0, -1.5))
      end

      local animationController = clone:FindFirstChildOfClass("AnimationController")
        or clone:FindFirstChildOfClass("Animator")

      animator = animationController:FindFirstChildWhichIsA("Animator") or animationController
      local cameraAnimations = replicatedStorage.Assets.WeaponAnimations:WaitForChild(v37):WaitForChild("CameraAnimations")
      loadAnimation = animator:LoadAnimation(cameraAnimations:WaitForChild("Equip"))
      loadAnimation2 = animator:LoadAnimation(cameraAnimations:WaitForChild("Idle"))
      loadAnimation3 = animator:LoadAnimation(cameraAnimations:WaitForChild("Inspect"))
      loadAnimation4 = animator:LoadAnimation(cameraAnimations:WaitForChild("Heavy Swing"))
      loadAnimation5 = animator:LoadAnimation(cameraAnimations:WaitForChild("Swing1"))
      loadAnimation6 = animator:LoadAnimation(cameraAnimations:WaitForChild("Swing2"))
      clone:SetPrimaryPartCFrame(currentCamera.CFrame * CFrame.new(0, -1.5, 5))

      tweenService:Create(
        clone.PrimaryPart, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { CFrame = currentCamera.CFrame * v42[v37].Offset }
      ):Play()

      loadAnimation:Play()

      contextActionService:BindAction("InspectKnifeAction", f15, false, Enum.KeyCode.F)

      contextActionService:BindAction(
        "AttackKnifeAction", f15, false, Enum.UserInputType.MouseButton1
      )

      return
    end
  end
end

customKnivesAndGloves:AddToggle("CustomKnifeToggle", {
  Text = "Enable Custom Knives",
  Default = false,
  Callback = function(value29)
    v36 = value29

    if not value29 then
      f13()
    end
  end,
})

customKnivesAndGloves:AddDropdown("SelectCustomKnife", {
  Values = { "Butterfly Knife", "Karambit", "M9 Bayonet", "Flip Knife", "Gut Knife" },
  Default = 1,
  Callback = function(value30)
    v37 = value30

    if v38 then
      f13()
    end
  end,
})

local function f18(p18, p19, p20)
  if not p18 or not p18:IsA("BasePart") or p18.Name == "Hitbox" then
    return
  end

  if p18.Color ~= p19 then
    p18.Color = p19
  end

  if p18.Material ~= p20 then
    p18.Material = p20
  end

  if p18:IsA("MeshPart") and p18.TextureID ~= "" then
    p18.TextureID = ""
  end

  for index16, value31 in ipairs(p18:GetChildren()) do
    if value31:IsA("SpecialMesh") and value31.TextureId ~= "" then
      value31.TextureId = ""
    elseif value31:IsA("SurfaceAppearance") or value31:IsA("Texture") or value31:IsA("Decal") then
      if not (value31:IsA("WeldConstraint") or value31:IsA("Weld") or value31:IsA("ManualWeld")) then
        value31:Destroy()
      end
    end
  end
end

customKnivesAndGloves:AddDivider()
local v48 = {}

local function f19(p21, p22, p23, p24, p25, p26, p27)
  if not p21 then
    return
  end

  f18(p21, p22, p23)

  for index17, value32 in ipairs(p21:GetDescendants()) do
    if value32:IsA("BasePart") then
      if value32.Name == "Glove" then
        f18(value32, p24, p25)
      elseif value32.Name == "Sleeve" then
        f18(value32, p26, p27)
      else
        f18(value32, p22, p23)
      end
    elseif value32:IsA("SpecialMesh") then
      value32.TextureId = ""
    elseif value32:IsA("SurfaceAppearance") or value32:IsA("Texture") or value32:IsA("Decal") then
      if not (value32:IsA("WeldConstraint") or value32:IsA("Weld") or value32:IsA("ManualWeld")) then
        value32:Destroy()
      end
    end
  end
end

local total = 0

runService.Heartbeat:Connect(function(delta)
  if f6() and toggles.AAEnabled and toggles.AAEnabled.Value then
    local character = localPlayer.Character
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart and character:FindFirstChildOfClass("Humanoid")
      and character:FindFirstChildOfClass("Humanoid").Health > 0 then
      local value33 = options.AAYaw.Value
      local v49 = 0

      if value33 == "Spinbot" then
        total = total + options.AASpeed.Value * delta * 10
        v49 = math.rad(total)
      elseif value33 == "Jitter" then
        v49 = math.rad(math.random(-180, 180))
      elseif value33 == "Backward" then
        local lookVector = currentCamera.CFrame.LookVector
        v49 = math.atan2(-lookVector.X, -lookVector.Z) + math.rad(180)
      elseif value33 == "Sideways" then
        local lookVector2 = currentCamera.CFrame.LookVector
        v49 = math.atan2(-lookVector2.X, -lookVector2.Z) + math.rad(90)
      end

      humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position) * CFrame.Angles(0, v49, 0)
    end
  end
end)

runService:BindToRenderStep("ThirdPersonOverride", Enum.RenderPriority.Camera.Value + 1, function()
  local v50 = f6()

  if toggles.TPEnabled and toggles.TPEnabled.Value and v50 then
    local character2 = localPlayer.Character

    local head3 = character2
      and (character2:FindFirstChild("Head") or character2:FindFirstChild("HumanoidRootPart"))

    if head3 then
      userInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
      local cframe = CFrame.new(options.TPOffsetX.Value, 1.5, options.TPDistance.Value)
      currentCamera.CFrame = CFrame.new(head3.Position) * currentCamera.CFrame.Rotation * cframe

      for index18, value34 in ipairs(character2:GetDescendants()) do
        if value34:IsA("BasePart") and value34.Name ~= "HumanoidRootPart" then
          if value34.LocalTransparencyModifier > 0.5 then
            value34.LocalTransparencyModifier = 0
          end
        end
      end

      if toggles.TPHideVM and toggles.TPHideVM.Value then
        if clone and clone.Parent then
          for index19, value35 in ipairs(clone:GetDescendants()) do
            if value35:IsA("BasePart") or value35:IsA("MeshPart") then
              value35.LocalTransparencyModifier = 1
            end
          end
        end

        for index20, value36 in ipairs(currentCamera:GetChildren()) do
          if value36:IsA("Model") and value36 ~= clone then
            for index21, value37 in ipairs(value36:GetDescendants()) do
              if value37:IsA("BasePart") or value37:IsA("MeshPart") then
                value37.LocalTransparencyModifier = 1
              end
            end
          end
        end
      end
    end
  elseif v50 then
    if clone and clone.Parent then
      for index22, value38 in ipairs(clone:GetDescendants()) do
        if value38:IsA("BasePart") or value38:IsA("MeshPart") then
          value38.LocalTransparencyModifier = 0
        end
      end
    end

    for index23, value39 in ipairs(currentCamera:GetChildren()) do
      if value39:IsA("Model") and value39 ~= clone then
        for index24, value40 in ipairs(value39:GetDescendants()) do
          if value40:IsA("BasePart") or value40:IsA("MeshPart") then
            value40.LocalTransparencyModifier = 0
          end
        end
      end
    end
  end
end)

local function f20()
  local v51 = {
    Box = Drawing.new("Square"),
    Name = Drawing.new("Text"),
    HBBg = Drawing.new("Square"),
    HB = Drawing.new("Square"),
    HText = Drawing.new("Text"),
    Lines = {},
  }

  v51.Box.Thickness = 1
  v51.Box.Filled = false
  v51.Name.Size = 14
  v51.Name.Center = true
  v51.Name.Outline = true
  v51.HBBg.Filled = true
  v51.HBBg.Color = Color3.new(0, 0, 0)
  v51.HB.Filled = true
  v51.HText.Size = 12
  v51.HText.Center = true
  v51.HText.Outline = true

  for i = 1, 15 do
    local line = Drawing.new("Line")
    line.Thickness = 1
    table.insert(v51.Lines, line)
  end

  return v51
end

local function f21(p28, fillColor)
  local thegxxChams = p28:FindFirstChild("ThegxxChams")

  if not thegxxChams then
    thegxxChams = Instance.new("Highlight", p28)
    thegxxChams.Name = "ThegxxChams"
  end

  thegxxChams.FillColor = fillColor
  thegxxChams.FillTransparency = 0.5
  thegxxChams.OutlineTransparency = 1
  thegxxChams.Enabled = true
end

local v52 = {}

runService.RenderStepped:Connect(function()
  if toggles.ShowFOV.Value then
    circle.Position = userInputService:GetMouseLocation()
    circle.Radius = options.FOVRadius.Value
    circle.Color = options.ColorFOV.Value
    circle.Visible = true
  else
    circle.Visible = false
  end

  if toggles.AimbotEnabled.Value and options.AimbotKey:GetState() and f6() then
    local v53 = f9()

    if v53 then
      local v54, v55 = currentCamera:WorldToViewportPoint(v53.Position)

      if v55 then
        local getMouseLocation2 = userInputService:GetMouseLocation()
        local value41 = options.AimbotSmoothing.Value
        local v56 = (v54.X - getMouseLocation2.X) / value41
        local v57 = (v54.Y - getMouseLocation2.Y) / value41

        if mousemoverel then
          mousemoverel(v56, v57)
        end
      end
    end
  end

  if toggles.BunnyHop.Value and userInputService:IsKeyDown(Enum.KeyCode.Space) then
    local v58 = f6()

    if v58 then
      local humanoid5 = v58:FindFirstChildOfClass("Humanoid")

      if humanoid5 and humanoid5.FloorMaterial ~= Enum.Material.Air then
        humanoid5.Jump = true
      end
    end
  end

  local v59 = f7()
  local v60 = {}

  if v59 and toggles.EnableESP.Value then
    for index25, value42 in ipairs(v59:GetChildren()) do
      if value42:IsA("Model") then
        v60[value42] = true
      end
    end
  end

  for key11, value43 in pairs(v52) do
    if not v60[key11] then
      value43.Box.Visible = false
      value43.Name.Visible = false
      value43.HBBg.Visible = false
      value43.HB.Visible = false
      value43.HText.Visible = false

      for index26, value44 in ipairs(value43.Lines) do
        value44.Visible = false
      end

      if key11:FindFirstChild("ThegxxChams") then
        key11.ThegxxChams:Destroy()
      end
    end
  end

  for key12, value45 in pairs(v60) do
    if not v52[key12] then
      v52[key12] = f20()
    end

    local v61 = v52[key12]
    local humanoidRootPart2 = key12:FindFirstChild("HumanoidRootPart")

    local torso = humanoidRootPart2
    torso = humanoidRootPart2 or key12:FindFirstChild("Torso") or key12.PrimaryPart

    local head4 = key12:FindFirstChild("Head") or torso
    local v62, v63 = f8(key12)

    if torso and head4 and v62 > 0 then
      local v64, v65 = currentCamera:WorldToViewportPoint(torso.Position)

      local worldToViewportPoint = currentCamera:WorldToViewportPoint(head4.Position
        + Vector3.new(0, 0.5, 0))

      local worldToViewportPoint2 = currentCamera:WorldToViewportPoint(torso.Position
        - Vector3.new(0, 3, 0))

      if v65 and v64.Z > 0 then
        local v66 = math.abs(worldToViewportPoint.Y - worldToViewportPoint2.Y)
        local v67 = v66 * 0.65
        local v68 = v64.X - v67 / 2
        local y = worldToViewportPoint.Y
        local value46 = options.Color_ESP_Box.Value

        if toggles.ESP_WallCheck.Value and f3(head4, key12) then
          value46 = options.Color_ESP_Visible.Value
        end

        if toggles.ESP_Box.Value then
          v61.Box.Color = value46
          v61.Box.Size = Vector2.new(v67, v66)
          v61.Box.Position = Vector2.new(v68, y)
          v61.Box.Visible = true
        else
          v61.Box.Visible = false
        end

        if toggles.ESP_Name.Value then
          v61.Name.Color = options.Color_ESP_Name.Value
          v61.Name.Text = key12.Name
          v61.Name.Position = Vector2.new(v64.X, y - 18)
          v61.Name.Visible = true
        else
          v61.Name.Visible = false
        end

        local v69 = math.clamp(v62 / v63, 0, 1)
        local v70 = v66 * v69

        if toggles.ESP_Bar.Value then
          v61.HBBg.Size = Vector2.new(2, v66)
          v61.HBBg.Position = Vector2.new(v68 - 6, y)
          v61.HBBg.Visible = true
          v61.HB.Color = Color3.new(1 - v69, v69, 0)
          v61.HB.Size = Vector2.new(2, v70)
          v61.HB.Position = Vector2.new(v68 - 6, y + (v66 - v70))
          v61.HB.Visible = true
        else
          v61.HBBg.Visible = false
          v61.HB.Visible = false
        end

        if toggles.ESP_Text.Value then
          v61.HText.Text = tostring(math.floor(v62))
          v61.HText.Color = Color3.new(1 - v69, v69, 0)
          v61.HText.Position = Vector2.new(v68 - 18, y + (v66 - v70) - 6)
          v61.HText.Visible = true
        else
          v61.HText.Visible = false
        end

        if toggles.ESP_Chams.Value then
          f21(key12, toggles.ESP_WallCheck.Value and f3(head4, key12)
              and options.Color_ESP_Visible.Value
            or options.Color_ESP_Chams.Value)
        elseif key12:FindFirstChild("ThegxxChams") then
          key12.ThegxxChams:Destroy()
        end
      else
        v61.Box.Visible = false
        v61.Name.Visible = false
        v61.HBBg.Visible = false
        v61.HB.Visible = false
        v61.HText.Visible = false

        if key12:FindFirstChild("ThegxxChams") then
          key12.ThegxxChams:Destroy()
        end
      end
    end
  end

  if toggles.EnableVM.Value then
    local value47 = options.Color_Weapon.Value
    local name3 = Enum.Material[options.Mat_Weapon.Value].Name
    local value48 = options.Color_Arms.Value
    local name4 = Enum.Material[options.Mat_Arms.Value].Name
    local value49 = options.Color_Gloves.Value
    local name5 = Enum.Material[options.Mat_Gloves.Value].Name
    local value50 = options.Color_Sleeves.Value
    local name6 = Enum.Material[options.Mat_Sleeves.Value].Name

    for index27, value51 in ipairs(currentCamera:GetChildren()) do
      if value51:IsA("Model") then
        local v71 = value51.Name .. name3 .. name4 .. tostring(value47)

        if v48[value51] ~= v71 then
          local weapon3 = value51:FindFirstChild("Weapon")

          local v72 = weapon3
          v72 = weapon3 or value51.Name == v37 and value51

          if v72 then
            for index28, value52 in ipairs(v72:GetDescendants()) do
              f18(value52, value47, Enum.Material[name3])
            end
          end

          local leftArm = value51:FindFirstChild("Left Arm")

          if leftArm then
            f19(
              leftArm, value48, Enum.Material[name4], value49, Enum.Material[name5], value50,
              Enum.Material[name6]
            )
          end

          local rightArm = value51:FindFirstChild("Right Arm")

          if rightArm then
            f19(
              rightArm, value48, Enum.Material[name4], value49, Enum.Material[name5], value50,
              Enum.Material[name6]
            )
          end

          v48[value51] = v71
        end
      end
    end
  else
    v48 = {}
  end

  if v36 and clone and clone.PrimaryPart then
    clone.PrimaryPart.CFrame = currentCamera.CFrame * v42[v37].Offset

    if not (loadAnimation and loadAnimation.IsPlaying) and not v39 and not v40 then
      if loadAnimation2 and not loadAnimation2.IsPlaying then
        loadAnimation2:Play()
      end
    end
  end
end)

task.spawn(function()
  while task.wait(0.1) do
    local v73 = f6()
    local v74 = v36
    local v75 = f12()

    if v74 and v73 and v75 and not v38 then
      f17(v75)
    elseif (not v36 or not v75 or not v73) and v38 then
      f13()
    end

    if v23 and v73 then
      for index29, value53 in ipairs(currentCamera:GetChildren()) do
        if v24[value53.Name] and value53:GetAttribute("SkinApplied") ~= v24[value53.Name] then
          f10(value53)
        end
      end
    end
  end
end)

task.spawn(function()
  while task.wait(0.2) do
    if toggles.AntiFlashToggle and toggles.AntiFlashToggle.Value then
      local playerGui = localPlayer:FindFirstChild("PlayerGui")

      if playerGui then
        local flashbangEffect = playerGui:FindFirstChild("FlashbangEffect")

        if flashbangEffect then
          flashbangEffect:Destroy()
        end
      end

      local flashbangColorCorrection = lighting:FindFirstChild("FlashbangColorCorrection")

      if flashbangColorCorrection then
        flashbangColorCorrection:Destroy()
      end
    end
  end
end)

task.spawn(function()
  while task.wait(0.5) do
    if toggles.AntiSmokeToggle and toggles.AntiSmokeToggle.Value then
      local debris = workspaceService:FindFirstChild("Debris")

      if debris then
        for index30, value54 in ipairs(debris:GetChildren()) do
          if string.match(value54.Name, "Voxel") then
            value54:ClearAllChildren()
            value54:Destroy()
          end
        end
      end
    end
  end
end)

v6.Settings:AddLeftGroupbox("Menu"):AddButton({
  Text = "Unload Script",
  Func = function() library:Unload() end,
})

themeManager:SetLibrary(library)

saveManager:SetLibrary(library)
saveManager:IgnoreThemeSettings()
saveManager:SetIgnoreIndexes({ "MenuKeybind" })

themeManager:SetFolder("ThegxxHub")

saveManager:SetFolder("ThegxxHub/Config")
saveManager:BuildConfigSection(v6.Settings)

themeManager:ApplyToTab(v6.Settings)
saveManager:LoadAutoloadConfig()

library.AccentColor = Color3.fromRGB(220, 20, 60)
library.MainColor = Color3.fromRGB(25, 25, 25)
library.BackgroundColor = Color3.fromRGB(15, 15, 15)
library.OutlineColor = Color3.fromRGB(50, 50, 50)
library:UpdateColorsUsingRegistry()

library:OnUnload(function()
  circle:Remove()
  runService:UnbindFromRenderStep("ThirdPersonOverride")

  if f6() then
    if clone and clone.Parent then
      for index31, value55 in ipairs(clone:GetDescendants()) do
        if value55:IsA("BasePart") or value55:IsA("MeshPart") then
          value55.LocalTransparencyModifier = 0
        end
      end
    end

    for index32, value56 in ipairs(currentCamera:GetChildren()) do
      if value56:IsA("Model") and value56 ~= clone then
        for index33, value57 in ipairs(value56:GetDescendants()) do
          if value57:IsA("BasePart") or value57:IsA("MeshPart") then
            value57.LocalTransparencyModifier = 0
          end
        end
      end
    end
  end

  for key13, value58 in pairs(v13) do
    if key13 and key13.Parent then
      key13.Size = value58
      key13.Transparency = 0

      for index34, value59 in ipairs(key13:GetChildren()) do
        if value59:IsA("Decal") then
          value59.Transparency = 0
        end
      end
    end
  end

  for key14, value60 in pairs(v14) do
    if value60 then
      value60:Destroy()
    end
  end

  for key15, value61 in pairs(v52) do
    value61.Box:Remove()
    value61.Name:Remove()
    value61.HBBg:Remove()
    value61.HB:Remove()
    value61.HText:Remove()

    for index35, value62 in ipairs(value61.Lines) do
      value62:Remove()
    end
  end

  table.clear(v52)
  table.clear(v48)
end)
