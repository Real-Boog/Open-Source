local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local virtualInputManager = game:GetService("VirtualInputManager")
local lighting = game:GetService("Lighting")
local collectionService = game:GetService("CollectionService")
getgenv().OverdoseUnloaded = false
local v1 = {}
local currentCamera = workspace.CurrentCamera
local localPlayer = players.LocalPlayer

local v2 = {
  MainBg = Color3.fromRGB(15, 15, 15),
  SectionBg = Color3.fromRGB(20, 20, 20),
  ElementBg = Color3.fromRGB(25, 25, 25),
  Border = Color3.fromRGB(0, 0, 0),
  Accent = Color3.fromRGB(255, 105, 180),
  Text = Color3.fromRGB(210, 210, 210),
  TextDark = Color3.fromRGB(110, 110, 110),
}

local code = Enum.Font.Code

local v3 = {
  Bg = {},
  Text = {},
  Image = {},
  Stroke = {},
}

local function f1(p1)
  table.insert(v3.Bg, p1)
  return p1
end

local function f2(p2)
  table.insert(v3.Image, p2)
  return p2
end

local function f3(p3)
  table.insert(v3.Text, p3)
  return p3
end

local function f4(p4)
  table.insert(v3.Stroke, p4)
  return p4
end

v1.MenuKeybinds = {}
v1.MenuDropdowns = {}

function v1:ChangeAccent(p5)
  v2.Accent = p5

  for key, value in pairs(v3.Bg) do
    if value and value.Parent then
      value.BackgroundColor3 = p5
    end
  end

  for key2, value2 in pairs(v3.Text) do
    if value2 and value2.Parent then
      value2.TextColor3 = p5
    end
  end

  for key3, value3 in pairs(v3.Image) do
    if value3 and value3.Parent then
      value3.ImageColor3 = p5
    end
  end

  for key4, value4 in pairs(v3.Stroke) do
    if value4 and value4.Parent then
      value4.Color = p5
    end
  end

  v1:UpdateKeybindList()

  for index, value5 in ipairs(v1.MenuKeybinds) do
    if value5.state then
      value5.btn.TextColor3 = p5
      value5.txt.TextColor3 = p5
    end
  end

  for index2, value6 in ipairs(v1.MenuDropdowns) do
    if value6.isOpen then
      for index3, value7 in ipairs(value6.options) do
        if value7.name == value6.current then
          value7.btn.TextColor3 = p5
        end
      end
    end
  end
end

local function f5(p6, p7)
  local instance = Instance.new(p6)

  for key5, value8 in pairs(p7) do
    instance[key5] = value8
  end

  return instance
end

local function f6(p8, p9)
  local v4 = false
  local inputBegan = p8.InputBegan
  local position, absolutePosition

  inputBegan:Connect(function(p10)
    if p10.UserInputType == Enum.UserInputType.MouseButton1 then
      v4 = true
      position = p10.Position
      absolutePosition = p9.AbsolutePosition
    end
  end)

  userInputService.InputChanged:Connect(function(input)
    if v4 and input.UserInputType == Enum.UserInputType.MouseMovement then
      local v5 = input.Position - position

      p9.Position = UDim2.new(0, math.clamp(
        absolutePosition.X + v5.X, 0, currentCamera.ViewportSize.X - p9.AbsoluteSize.X
      ), 0, math.clamp(
        absolutePosition.Y + v5.Y, 0, currentCamera.ViewportSize.Y - p9.AbsoluteSize.Y
      ))
    end
  end)

  userInputService.InputEnded:Connect(function(input2)
    if input2.UserInputType == Enum.UserInputType.MouseButton1 then
      v4 = false
    end
  end)
end

local function f7(parent)
  local uiStroke = Instance.new("UIStroke")
  uiStroke.Color = Color3.new(0, 0, 0)
  uiStroke.Thickness = 1
  uiStroke.Transparency = 0
  uiStroke.Parent = parent
end

local function f8(parent2, p11)
  local glowEffect = f2(Instance.new("ImageLabel"))
  glowEffect.Name = "GlowEffect"
  glowEffect.BackgroundTransparency = 1
  glowEffect.Position = UDim2.new(0, -5, 0, -5)
  glowEffect.Size = UDim2.new(1, 10, 1, 10)
  glowEffect.ZIndex = 0
  glowEffect.Image = "rbxassetid://1316045217"
  glowEffect.ImageColor3 = p11 or v2.Accent
  glowEffect.ImageTransparency = 0.05
  glowEffect.ScaleType = Enum.ScaleType.Slice
  glowEffect.SliceCenter = Rect.new(10, 10, 118, 118)
  glowEffect.Parent = parent2

  local uiGradient = Instance.new("UIGradient")
  uiGradient.Rotation = 90

  uiGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3, 0.5),
    NumberSequenceKeypoint.new(0.7, 1), NumberSequenceKeypoint.new(1, 1),
  })

  uiGradient.Parent = glowEffect

  return glowEffect
end

local function f9(p12, p13)
  local glowEffect2 = f2(Instance.new("ImageLabel"))
  glowEffect2.Name = "GlowEffect"
  glowEffect2.BackgroundTransparency = 1
  glowEffect2.Position = UDim2.new(0, -8, 0, -8)
  glowEffect2.Size = UDim2.new(1, 16, 1, 16)
  glowEffect2.ZIndex = p12.ZIndex - 1
  glowEffect2.Image = "rbxassetid://1316045217"
  glowEffect2.ImageColor3 = p13 or v2.Accent
  glowEffect2.ImageTransparency = 0.05
  glowEffect2.ScaleType = Enum.ScaleType.Slice
  glowEffect2.SliceCenter = Rect.new(10, 10, 118, 118)
  glowEffect2.Parent = p12

  return glowEffect2
end

local function f10()
  local text = ""

  for i = 1, 16 do
    text = text .. string.char(math.random(97, 122))
  end

  return text
end

local v6 = f5("ScreenGui", {
  Name = f10(),
  ResetOnSpawn = false,
  DisplayOrder = 99999,
  ZIndexBehavior = Enum.ZIndexBehavior.Global,
})

if not v6.Parent then
  v6.Parent = players.LocalPlayer:WaitForChild("PlayerGui")
end

local v7 = f5("Frame", {
  Parent = v6,
  Size = UDim2.new(0, 360, 0, 100),
  AnchorPoint = Vector2.new(0.5, 0.5),
  Position = UDim2.new(0.5, 0, 0.5, 0),
  BackgroundColor3 = v2.MainBg,
  BorderColor3 = v2.Border,
  BorderSizePixel = 1,
})

f1(f5("Frame", {
  Parent = v7,
  Size = UDim2.new(1, 0, 0, 1),
  BackgroundColor3 = v2.Accent,
  BorderSizePixel = 0,
}))

f8(v7, v2.Accent)

f7((f5("TextLabel", {
  Parent = v7,
  Size = UDim2.new(1, 0, 0, 30),
  BackgroundTransparency = 1,
  Text = "OVERDOSE.GG - KEY SYSTEM",
  TextColor3 = v2.Text,
  Font = code,
  TextSize = 13,
  TextXAlignment = Enum.TextXAlignment.Center,
})))

local v8 = f5("TextBox", {
  Parent = v7,
  Size = UDim2.new(1, -20, 0, 25),
  Position = UDim2.new(0, 10, 0, 35),
  BackgroundColor3 = v2.ElementBg,
  BorderColor3 = v2.Border,
  BorderSizePixel = 1,
  Text = "",
  PlaceholderText = " Enter key here...",
  TextColor3 = v2.Text,
  Font = code,
  TextSize = 12,
  TextXAlignment = Enum.TextXAlignment.Left,
  ClearTextOnFocus = false,
})

f7(v8)

f1(f5("Frame", {
  Parent = v8,
  Size = UDim2.new(0, 2, 1, 0),
  BackgroundColor3 = v2.Accent,
  BorderSizePixel = 0,
}))

local v9 = f5("TextButton", {
  Parent = v7,
  Size = UDim2.new(0.5, -15, 0, 25),
  Position = UDim2.new(0, 10, 0, 65),
  BackgroundColor3 = v2.ElementBg,
  BorderColor3 = v2.Border,
  BorderSizePixel = 1,
  Text = " SUBMIT",
  TextColor3 = v2.Text,
  Font = code,
  TextSize = 12,
})

f7(v9)

f1(f5("Frame", {
  Parent = v9,
  Size = UDim2.new(0, 2, 1, 0),
  BackgroundColor3 = v2.Accent,
  BorderSizePixel = 0,
}))

local v10 = f5("TextButton", {
  Parent = v7,
  Size = UDim2.new(0.5, -15, 0, 25),
  Position = UDim2.new(0.5, 5, 0, 65),
  BackgroundColor3 = v2.ElementBg,
  BorderColor3 = v2.Border,
  BorderSizePixel = 1,
  Text = " DISCORD CHANNEL",
  TextColor3 = v2.Text,
  Font = code,
  TextSize = 12,
})

f7(v10)

f1(f5("Frame", {
  Parent = v10,
  Size = UDim2.new(0, 2, 1, 0),
  BackgroundColor3 = v2.Accent,
  BorderSizePixel = 0,
}))

local bindableEvent = Instance.new("BindableEvent")

v9.MouseButton1Click:Connect(function()
  if v8.Text == "32d53b5c75f" then
    v7:Destroy()
    bindableEvent:Fire()
  else
    v8.Text = ""
    v8.PlaceholderText = " INVALID KEY!"
  end
end)

v10.MouseButton1Click:Connect(function()
  if setclipboard then
    setclipboard("https://discord.gg/kG2EhsgpKM")
  end
end)

bindableEvent.Event:Wait()
getgenv().ToggleUIKey = Enum.KeyCode.Home

local connect

connect = userInputService.InputBegan:Connect(function(input3, p14)
  if getgenv().OverdoseUnloaded then
    connect:Disconnect()
    return
  end

  if not p14 and input3.KeyCode == getgenv().ToggleUIKey and getgenv().MainGuiFrame then
    getgenv().MainGuiFrame.Visible = not getgenv().MainGuiFrame.Visible
  end
end)

local v11 = f5("Frame", {
  Parent = v6,
  Size = UDim2.new(0, 200, 0, 24),
  Position = UDim2.new(0, 20, 0, 60),
  BackgroundColor3 = v2.MainBg,
  BorderColor3 = v2.Border,
  BorderSizePixel = 1,
  Visible = false,
})

f1(f5("Frame", {
  Parent = v11,
  Size = UDim2.new(1, 0, 0, 1),
  BackgroundColor3 = v2.Accent,
  BorderSizePixel = 0,
}))

f6(v11, v11)
f8(v11, v2.Accent)

f7((f5("TextLabel", {
  Parent = v11,
  Size = UDim2.new(1, 0, 1, 0),
  BackgroundTransparency = 1,
  Text = "KEYBINDS",
  TextColor3 = v2.Text,
  Font = code,
  TextSize = 12,
  TextXAlignment = Enum.TextXAlignment.Center,
})))

local v12 = f5("Frame", {
  Parent = v11,
  Size = UDim2.new(1, 0, 0, 0),
  Position = UDim2.new(0, 0, 0, 25),
  BackgroundTransparency = 1,
  AutomaticSize = Enum.AutomaticSize.Y,
})

f5("UIListLayout", {
  Parent = v12,
  Padding = UDim.new(0, 2),
  SortOrder = Enum.SortOrder.LayoutOrder,
})

f5("UIPadding", {
  Parent = v12,
  PaddingTop = UDim.new(0, 4),
  PaddingLeft = UDim.new(0, 10),
  PaddingBottom = UDim.new(0, 10),
  PaddingRight = UDim.new(0, 10),
})

v1.RegisteredKeybinds = {}

function v1:UpdateKeybindList()
  for index4, value9 in ipairs(v12:GetChildren()) do
    if value9:IsA("Frame") then
      value9:Destroy()
    end
  end

  for key6, value10 in pairs(self.RegisteredKeybinds) do
    if value10.key then
      local parent3 = f5("Frame", {
        Parent = v12,
        Size = UDim2.new(1, 0, 0, 15),
        BackgroundTransparency = 1,
      })

      local v13 = f5("TextLabel", {
        Parent = parent3,
        Size = UDim2.new(0.5, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = key6,
        TextColor3 = v2.Text,
        Font = code,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2,
      })

      local v14 = f5("TextLabel", {
        Parent = parent3,
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = value10.state and "[ON]" or "[OFF]",
        TextColor3 = value10.state and v2.Accent or v2.TextDark,
        Font = code,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Right,
        ZIndex = 2,
      })

      f7(v13)
      f7(v14)

      if value10.state then
        f2((f5("ImageLabel", {
          Parent = f5("Frame", {
            Parent = v14,
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, 0, 0.5, 0),
            Size = UDim2.new(0, 28, 0, 14),
          }),
          BackgroundTransparency = 1,
          Position = UDim2.new(0, -6, 0, -6),
          Size = UDim2.new(1, 12, 1, 12),
          ZIndex = 0,
          Image = "rbxassetid://1316045217",
          ImageColor3 = v2.Accent,
          ImageTransparency = 0.45,
          ScaleType = Enum.ScaleType.Slice,
          SliceCenter = Rect.new(10, 10, 118, 118),
        })))
      end
    end
  end
end

function v1:SetKeybindsUIVisible(visible)
  v11.Visible = visible
end

local v15 = f5("Frame", {
  Parent = v6,
  Size = UDim2.new(0, 220, 0, 24),
  Position = UDim2.new(0, 20, 0, 300),
  BackgroundColor3 = v2.MainBg,
  BorderColor3 = v2.Border,
  BorderSizePixel = 1,
  Visible = false,
})

f1(f5("Frame", {
  Parent = v15,
  Size = UDim2.new(1, 0, 0, 1),
  BackgroundColor3 = v2.Accent,
  BorderSizePixel = 0,
}))

f6(v15, v15)
f8(v15, v2.Accent)

f7((f5("TextLabel", {
  Parent = v15,
  Size = UDim2.new(1, 0, 1, 0),
  BackgroundTransparency = 1,
  Text = "CI Hack",
  TextColor3 = v2.Text,
  Font = code,
  TextSize = 12,
  TextXAlignment = Enum.TextXAlignment.Center,
})))

local v16 = f5("Frame", {
  Parent = v15,
  Size = UDim2.new(1, 0, 0, 0),
  Position = UDim2.new(0, 0, 0, 25),
  BackgroundTransparency = 1,
  AutomaticSize = Enum.AutomaticSize.Y,
})

f5("UIListLayout", {
  Parent = v16,
  Padding = UDim.new(0, 2),
  SortOrder = Enum.SortOrder.LayoutOrder,
})

f5("UIPadding", {
  Parent = v16,
  PaddingTop = UDim.new(0, 4),
  PaddingLeft = UDim.new(0, 10),
  PaddingBottom = UDim.new(0, 10),
  PaddingRight = UDim.new(0, 10),
})

function v1:SetCIHacksUIVisible(visible2)
  v15.Visible = visible2
end

local v17 = {
  SilentAim = false,
  TargetPart = "Head",
  SmartTargeting = true,
  TeamCheck = true,
  WallCheck = true,
  AutoReload = false,
  ShowFOV = false,
  FOVType = "Circle",
  FOVCenter = false,
  FOVRadius = 150,
  FOVColor = Color3.fromRGB(255, 255, 255),
  ShowTarget = false,
  TargetColor = Color3.fromRGB(255, 50, 50),
  MarkerSize = 12,
  MarkerLength = 6,
  RotationSpeed = 3,
  ESPEnabled = false,
  ESPTeamCheck = false,
  ESPBoxType = "Default",
  DrawBoxes = false,
  DrawSkeletons = false,
  DrawGlow = false,
  DrawHealthBar = false,
  MaxDistance = 1500,
  ESPColor = Color3.fromRGB(255, 50, 50),
  CustomWeapon = false,
  WeaponColor = Color3.fromRGB(200, 0, 255),
  WeaponMaterial = "ForceField",
  WeaponParticles = true,
  ParticleTexture = "rbxassetid://120733349948660",
  WeaponParticleColor = Color3.fromRGB(200, 0, 255),
  Fullbright = false,
  WorldColorEnabled = false,
  WorldColor = Color3.fromRGB(255, 255, 255),
  CIDevicesESP = false,
  CIFastInteract = false,
  FastClickVents = false,
  ColorEnemy = Color3.fromRGB(255, 50, 50),
  ColorFriendly = Color3.fromRGB(50, 255, 50),
  ColorWarning = Color3.fromRGB(255, 200, 50),
}

local v18 = { Galaxy = "rbxassetid://1084996976", Smoke = "rbxassetid://120733349948660" }
local v19 = { "Smoke", "Galaxy" }
local v20 = { "ForceField", "Neon" }

local overdoseWorldColor = Instance.new("ColorCorrectionEffect")
overdoseWorldColor.Name = "OverdoseWorldColor"
overdoseWorldColor.Parent = lighting

local v21 = {}
local v22 = false

task.spawn(function()
  while task.wait(0.2) do
    if getgenv().OverdoseUnloaded then
      break
    end

    if v17.WorldColorEnabled then
      overdoseWorldColor.Enabled = true
      overdoseWorldColor.TintColor = v17.WorldColor
    else
      overdoseWorldColor.Enabled = false
    end

    if v17.Fullbright then
      if not v22 then
        v22 = true

        v21.Ambient = lighting.Ambient
        v21.OutdoorAmbient = lighting.OutdoorAmbient
        v21.Brightness = lighting.Brightness
        v21.ClockTime = lighting.ClockTime
        v21.FogEnd = lighting.FogEnd
        v21.GlobalShadows = lighting.GlobalShadows
      end

      lighting.Ambient = Color3.new(1, 1, 1)
      lighting.OutdoorAmbient = Color3.new(1, 1, 1)
      lighting.Brightness = 2
      lighting.ClockTime = 14
      lighting.FogEnd = 100000
      lighting.GlobalShadows = false
    elseif v22 then
      v22 = false

      lighting.Ambient = v21.Ambient
      lighting.OutdoorAmbient = v21.OutdoorAmbient
      lighting.Brightness = v21.Brightness
      lighting.ClockTime = v21.ClockTime
      lighting.FogEnd = v21.FogEnd
      lighting.GlobalShadows = v21.GlobalShadows
    end
  end
end)

local function f11(p15)
  if not (p15:IsA("Tool") or p15:IsA("Model")) then
    return
  end

  if p15:FindFirstChild("WeaponCustomChams") then
    p15:FindFirstChild("WeaponCustomChams"):Destroy()
  end

  for index5, value11 in ipairs(p15:GetDescendants()) do
    local v23 = value11

    if v23:IsA("BasePart") then
      local weaponCustomChams = v23:FindFirstChild("WeaponCustomChams")

      if weaponCustomChams then
        weaponCustomChams:Destroy()
      end

      local v24 = tostring(v17.WeaponColor) .. v17.WeaponMaterial
        .. tostring(v17.WeaponParticles)

      if v17.CustomWeapon and v23:GetAttribute("OD_WepCache") == v24 then
      else
        local weaponInnerPoints = v23:FindFirstChild("WeaponInnerPoints")

        if not v17.CustomWeapon then
          if weaponInnerPoints then
            weaponInnerPoints:Destroy()
          end

          v23:SetAttribute("OD_WepCache", nil)
        else
          for index6, value12 in ipairs(v23:GetChildren()) do
            if value12:IsA("Decal") or value12:IsA("Texture") then
              value12:Destroy()
            elseif value12:IsA("SpecialMesh") then
              value12.TextureId = ""
            end
          end

          pcall(function() v23.Material = Enum.Material[v17.WeaponMaterial] end)

          v23.Transparency = 0.25
          v23.CastShadow = false
          v23.Color = v17.WeaponColor

          if v17.WeaponParticles then
            local weaponInnerPoints2 = v23:FindFirstChild("WeaponInnerPoints")

            if not weaponInnerPoints2 then
              weaponInnerPoints2 = Instance.new("ParticleEmitter")
              weaponInnerPoints2.Name = "WeaponInnerPoints"
              weaponInnerPoints2.LockedToPart = true
              weaponInnerPoints2.LightEmission = 1
              weaponInnerPoints2.Brightness = 10
              weaponInnerPoints2.Parent = v23
            end

            weaponInnerPoints2.Texture = v17.ParticleTexture

            weaponInnerPoints2.Color = ColorSequence.new({
              ColorSequenceKeypoint.new(0, v17.WeaponParticleColor),
              ColorSequenceKeypoint.new(0.5, v17.WeaponParticleColor),
              ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)),
            })

            weaponInnerPoints2.Lifetime = NumberRange.new(1, 2)
            weaponInnerPoints2.SpreadAngle = Vector2.new(180, 180)
            weaponInnerPoints2.Speed = NumberRange.new(0.00005, 0.0002)

            weaponInnerPoints2.Size = NumberSequence.new({
              NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 0.08),
              NumberSequenceKeypoint.new(1, 0),
            })

            weaponInnerPoints2.Rate = v23.Size.X * v23.Size.Y * v23.Size.Z < 0.5 and 5 or 25
          elseif weaponInnerPoints then
            weaponInnerPoints:Destroy()
          end

          v23:SetAttribute("OD_WepCache", v24)
        end
      end
    end
  end
end

task.spawn(function()
  while task.wait(0.5) do
    if getgenv().OverdoseUnloaded then
      break
    else
      if localPlayer.Character then
        for index7, value13 in ipairs(localPlayer.Character:GetChildren()) do
          if value13:IsA("Tool") then
            f11(value13)
          end
        end
      end

      for index8, value14 in ipairs(currentCamera:GetChildren()) do
        if value14:IsA("Model") and not players:GetPlayerFromCharacter(value14) then
          f11(value14)
        end
      end

      local backpack = localPlayer:FindFirstChild("Backpack")

      if backpack then
        for index9, value15 in ipairs(backpack:GetChildren()) do
          if value15:IsA("Tool") then
            f11(value15)
          end
        end
      end
    end
  end
end)

task.spawn(function()
  while task.wait(0.1) do
    if getgenv().OverdoseUnloaded then
      break
    elseif v17.AutoReload then
      pcall(function()
        local character = localPlayer.Character

        if character then
          local tool = character:FindFirstChildOfClass("Tool")

          if tool then
            local currentAmmo = tool:FindFirstChild("CurrentAmmo")
              or tool:FindFirstChild("Ammo")

            if currentAmmo and (currentAmmo:IsA("IntValue") or currentAmmo:IsA("NumberValue"))
              and currentAmmo.Value <= 0 then
              virtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)
              task.wait(0.05)
              virtualInputManager:SendKeyEvent(false, Enum.KeyCode.R, false, game)
              task.wait(0.5)
            end
          end
        end
      end)
    end
  end
end)

local v25 = false

local connect2

connect2 = userInputService.InputBegan:Connect(function(input4, p16)
  if getgenv().OverdoseUnloaded then
    connect2:Disconnect()
    return
  end

  if not p16 and input4.UserInputType == Enum.UserInputType.MouseButton1 then
    v25 = true
  end
end)

local connect3

connect3 = userInputService.InputEnded:Connect(function(input5, p17)
  if getgenv().OverdoseUnloaded then
    connect3:Disconnect()
    return
  end

  if input5.UserInputType == Enum.UserInputType.MouseButton1 then
    v25 = false
  end
end)

task.spawn(function()
  local getMouse = localPlayer:GetMouse()

  while task.wait(0.1) do
    if getgenv().OverdoseUnloaded then
      break
    end

    if v17.FastClickVents and v25 then
      local target = getMouse.Target

      if target then
        local clickDetector = target:FindFirstChildOfClass("ClickDetector")

        if not clickDetector and target.Parent then
          clickDetector = target.Parent:FindFirstChildOfClass("ClickDetector")
        end

        if clickDetector then
          pcall(function()
            clickDetector.MaxActivationDistance = math.huge
            fireclickdetector(clickDetector)
          end)
        end
      end
    end
  end
end)

local v26 = {
  { Name = "HackDevice016", Label = "SCP-016" }, { Name = "HackDevice079", Label = "SCP-079" },
  { Name = "ModelCI002", Label = "SCP-002" }, { Name = "ModelCI008", Label = "SCP-008" },
  { Name = "ModelCI106", Label = "SCP-106" }, { Name = "ModelCI299", Label = "SCP-299" },
  { Name = "ModelCI457", Label = "SCP-457" },
}

local v27 = {}
local v28 = {}
local v29 = {}
local v30 = {}
local v31 = #v26
local count = 0

while true do
  count = 1 + count

  if not (count <= v31) then
    break
  end

  local v32 = count

  v28[v32] = Drawing.new("Line")
  v28[v32].Thickness = 3
  v28[v32].Color = Color3.new(0, 0, 0)
  v28[v32].Visible = false
  v28[v32].ZIndex = 1

  v27[v32] = Drawing.new("Line")
  v27[v32].Thickness = 1
  v27[v32].Color = v2.Accent
  v27[v32].Visible = false
  v27[v32].ZIndex = 2

  f4(v27[v32])
end

local function f12(p18)
  for index10, value16 in ipairs(v26) do
    if p18.Name == value16.Name then
      local findFirstChildWhichIsA = p18:FindFirstChildWhichIsA("ProximityPrompt", true)
      local textLabel = nil

      for index11, value17 in ipairs(p18:GetDescendants()) do
        if value17:IsA("TextLabel") and value17.Parent and value17.Parent:IsA("BillboardGui")
          and value17.Text ~= "Label" then
          textLabel = value17
          break
        end
      end

      v29[value16.Name] = {
        Model = p18,
        Prompt = findFirstChildWhichIsA,
        TextLabel = textLabel,
      }

      break
    end
  end
end

for index12, value18 in ipairs(workspace:GetDescendants()) do
  f12(value18)
end

local connect4 = workspace.DescendantAdded:Connect(f12)

local connect5 = workspace.DescendantRemoving:Connect(function(descendant)
  if v29[descendant.Name] and v29[descendant.Name].Model == descendant then
    v29[descendant.Name] = nil
  end
end)

task.spawn(function()
  while task.wait(0.2) do
    if getgenv().OverdoseUnloaded then
      break
    else
      local v33 = {}

      if v15.Visible then
        for index13, value19 in ipairs(v16:GetChildren()) do
          if value19:IsA("Frame") then
            value19:Destroy()
          end
        end
      end

      for index14, value20 in ipairs(v26) do
        local textDark = v2.TextDark
        local text2 = "NONE"
        local v34 = false
        local v35 = v29[value20.Name]

        if v35 and v35.Model and v35.Model.Parent then
          text2 = "IDLE"

          if v35.TextLabel and v35.TextLabel.Parent then
            text2 = v35.TextLabel.Text
          end

          local prompt = v35.Prompt

          if prompt and prompt.Parent and prompt.Enabled then
            text2 = "ON"
            local accent = v2.Accent
            v33[index14] = prompt
            textDark = accent
            v34 = true

            if v17.CIFastInteract then
              prompt.HoldDuration = 1
            end
          elseif text2 ~= "IDLE" then
            textDark = v2.Text
          end
        end

        if v15.Visible then
          local parent4 = f5("Frame", {
            Parent = v16,
            Size = UDim2.new(1, 0, 0, 15),
            BackgroundTransparency = 1,
          })

          local v36 = f5("TextLabel", {
            Parent = parent4,
            Size = UDim2.new(0.5, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = value20.Label,
            TextColor3 = v2.Text,
            Font = code,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 2,
          })

          local v37 = f5("TextLabel", {
            Parent = parent4,
            Size = UDim2.new(0.5, 0, 1, 0),
            Position = UDim2.new(0.5, 0, 0, 0),
            BackgroundTransparency = 1,
            Text = "[" .. text2 .. "]",
            TextColor3 = textDark,
            Font = code,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Right,
            ZIndex = 2,
          })

          f7(v36)
          f7(v37)

          if v34 then
            f3(v37)

            f2((f5("ImageLabel", {
              Parent = f5("Frame", {
                Parent = v37,
                BackgroundTransparency = 1,
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, 0, 0.5, 0),
                Size = UDim2.new(0, 28, 0, 14),
              }),
              BackgroundTransparency = 1,
              Position = UDim2.new(0, -6, 0, -6),
              Size = UDim2.new(1, 12, 1, 12),
              ZIndex = 0,
              Image = "rbxassetid://1316045217",
              ImageColor3 = v2.Accent,
              ImageTransparency = 0.45,
              ScaleType = Enum.ScaleType.Slice,
              SliceCenter = Rect.new(10, 10, 118, 118),
            })))
          end
        end
      end

      v30 = v33
    end
  end
end)

local v38 = {
  ["Security Department"] = true,
  ["Scientific Department"] = true,
  ["Medical Department"] = true,
  ["Administrative Department"] = true,
  ["Intelligence Agency"] = true,
  ["Internal Security Department"] = true,
  ["Mobile Task Force"] = true,
  ["Rapid Response Team"] = true,
  ["Nu-7"] = true,
  ["Beta-7"] = true,
  ["Epsilon-11"] = true,
  ["Alpha-1"] = true,
}

local v39 = {
  ["Scientific Department"] = true,
  ["Medical Department"] = true,
  ["Administrative Department"] = true,
}

local function f13(p19)
  if not p19.Character then
    return false
  end

  if collectionService:HasTag(p19.Character, "EquippedGun")
    or collectionService:HasTag(p19.Character, "Hostile") then
    return true
  end

  for index15, value21 in ipairs(p19.Character:GetChildren()) do
    if value21:IsA("Tool")
      and (value21:FindFirstChild("GunServer") or value21:FindFirstChild("Damage")
        or value21:FindFirstChild("KnifeServer")) then
      return true
    end
  end

  return false
end

local function f14(p20)
  if not v17.SmartTargeting then
    if not v17.TeamCheck then
      return "Enemy", v17.ColorEnemy
    end

    if p20.Team ~= localPlayer.Team then
      return "Enemy", v17.ColorEnemy
    end

    return "Friendly", v17.ColorFriendly
  end

  if p20 == localPlayer or not p20.Team or not localPlayer.Team then
    return "Friendly", v17.ColorFriendly
  else
    local name = p20.Team.Name
    local name2 = localPlayer.Team.Name
    local hasTag = p20.Character and collectionService:HasTag(p20.Character, "Rogue")
    local v40 = f13(p20)

    if hasTag then
      return "Enemy", v17.ColorEnemy
    end

    if v39[name] and not v40 then
      return "Friendly", v17.ColorFriendly
    elseif v38[name2] then
      if name == "Chaos Insurgency" then
        return "Enemy", v17.ColorEnemy
      end

      if name == "Class - D" then
        return v40 and "Enemy" or "Warning", v40 and v17.ColorEnemy or v17.ColorWarning
      end

      if v40 and v39[name] then
        return "Friendly", v17.ColorFriendly
      end

      return "Friendly", v17.ColorFriendly
    elseif name2 == "Chaos Insurgency" or name2 == "Class - D" then
      if v38[name] then
        return "Enemy", v17.ColorEnemy
      end

      if name == "Chaos Insurgency" or name == "Class - D" then
        return "Friendly", v17.ColorFriendly
      end

      if name2 ~= name then
        return "Enemy", v17.ColorEnemy
      end

      return "Friendly", v17.ColorFriendly
    else
      if name2 ~= name then
        return "Enemy", v17.ColorEnemy
      end

      return "Friendly", v17.ColorFriendly
    end
  end
end

local v41 = {}

task.spawn(function()
  while task.wait(0.25) do
    if getgenv().OverdoseUnloaded then
      break
    end

    for index16, value22 in ipairs(players:GetPlayers()) do
      if value22 ~= localPlayer then
        local status, color = f14(value22)
        v41[value22] = { Status = status, Color = color }
      end
    end
  end
end)

local circle = Drawing.new("Circle")
circle.Thickness = 1
circle.Filled = false

local v42 = {}
local count2 = 0

while true do
  count2 = 1 + count2

  if not (30 >= count2) then
    break
  end

  local circle2 = Drawing.new("Circle")
  circle2.Radius = 2
  circle2.Filled = true
  circle2.Visible = false

  v42[count2] = circle2
end

local v43 = {}

for j = 1, 8 do
  local line = Drawing.new("Line")
  line.Thickness = 2
  line.Visible = false

  v43[j] = line
end

local v44 = {}

local function f15(p21)
  if p21 == localPlayer then
    return
  else
    local v45 = {}
    local count3 = 0

    while true do
      count3 = 1 + count3

      if not (count3 <= 14) then
        break
      end

      local v46 = count3

      v45[v46] = Drawing.new("Line")
      v45[v46].Thickness = 1
      v45[v46].Visible = false
      v45[v46].ZIndex = 2
    end

    local v47 = {}
    local v48 = {}
    local v49 = {}
    local count4 = 0

    while true do
      count4 = 1 + count4

      if not (count4 <= 8) then
        break
      end

      local v50 = count4

      v47[v50] = Drawing.new("Line")
      v47[v50].Thickness = 1
      v47[v50].Visible = false
      v47[v50].ZIndex = 2

      v49[v50] = Drawing.new("Line")
      v49[v50].Thickness = 3
      v49[v50].Transparency = 0.3
      v49[v50].Visible = false
      v49[v50].ZIndex = 1

      v48[v50] = Drawing.new("Line")
      v48[v50].Thickness = 5
      v48[v50].Transparency = 0.1
      v48[v50].Visible = false
      v48[v50].ZIndex = 0
    end

    v44[p21] = {
      BoxOutline = Drawing.new("Square"),
      Box = Drawing.new("Square"),
      Corners = v47,
      CornersGlow1 = v49,
      CornersGlow2 = v48,
      Glow1 = Drawing.new("Square"),
      Glow2 = Drawing.new("Square"),
      Glow3 = Drawing.new("Square"),
      Glow4 = Drawing.new("Square"),
      HealthOutline = Drawing.new("Square"),
      HealthBar = Drawing.new("Square"),
      Skeleton = v45,
    }

    v44[p21].BoxOutline.Thickness = 1
    v44[p21].BoxOutline.Filled = false
    v44[p21].BoxOutline.Color = Color3.new(0, 0, 0)
    v44[p21].BoxOutline.ZIndex = 1
    v44[p21].Box.Thickness = 1
    v44[p21].Box.Filled = false
    v44[p21].Box.ZIndex = 2
    v44[p21].Glow1.Thickness = 1
    v44[p21].Glow1.Filled = false
    v44[p21].Glow1.Transparency = 0.2
    v44[p21].Glow1.ZIndex = 0
    v44[p21].Glow2.Thickness = 1
    v44[p21].Glow2.Filled = false
    v44[p21].Glow2.Transparency = 0.1
    v44[p21].Glow2.ZIndex = 0
    v44[p21].Glow3.Thickness = 1
    v44[p21].Glow3.Filled = false
    v44[p21].Glow3.Transparency = 0.05
    v44[p21].Glow3.ZIndex = 0
    v44[p21].Glow4.Thickness = 1
    v44[p21].Glow4.Filled = false
    v44[p21].Glow4.Transparency = 0.02
    v44[p21].Glow4.ZIndex = 0
    v44[p21].HealthOutline.Thickness = 1
    v44[p21].HealthOutline.Filled = false
    v44[p21].HealthOutline.Color = Color3.new(0, 0, 0)
    v44[p21].HealthOutline.ZIndex = 1
    v44[p21].HealthBar.Thickness = 1
    v44[p21].HealthBar.Filled = true
    v44[p21].HealthBar.ZIndex = 2

    return
  end
end

for index17, value23 in ipairs(players:GetPlayers()) do
  f15(value23)
end

local connect6 = players.PlayerAdded:Connect(f15)

local connect7 = players.PlayerRemoving:Connect(function(player)
  if v44[player] then
    for key7, value24 in pairs(v44[player]) do
      local v51 = value24

      if type(v51) == "table" then
        for index18, value25 in ipairs(v51) do
          local v52 = value25
          pcall(function() v52:Remove() end)
        end
      else
        pcall(function() v51:Remove() end)
      end
    end

    v44[player] = nil
  end

  v41[player] = nil
end)

local function f16(p22)
  if not v17.WallCheck or not localPlayer.Character then
    return true
  else
    local position2 = currentCamera.CFrame.Position

    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = { localPlayer.Character, p22.Parent }
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.IgnoreWater = true

    return workspace:Raycast(position2, p22.Position - position2, raycastParams) == nil
  end
end

local function f17()
  local v53 = {}

  local fovCenter = v17.FOVCenter and currentCamera.ViewportSize / 2
    or userInputService:GetMouseLocation()

  for index19, value26 in ipairs(players:GetPlayers()) do
    if value26 ~= localPlayer and value26.Character then
      local findFirstChild = value26.Character:FindFirstChild(v17.TargetPart)
      local humanoid = value26.Character:FindFirstChild("Humanoid")

      if findFirstChild and findFirstChild.Parent and humanoid and humanoid.Health > 0 then
        local v54 = v41[value26]

        if v17.SmartTargeting and v54 and v54.Status ~= "Enemy" then
        else
          local v55, v56 = currentCamera:WorldToViewportPoint(findFirstChild.Position)

          if v56 then
            local magnitude = (Vector2.new(v55.X, v55.Y) - fovCenter).Magnitude

            if magnitude <= v17.FOVRadius then
              table.insert(v53, { part = findFirstChild, dist = magnitude })
            end
          end
        end
      end
    end
  end

  table.sort(v53, function(p23, p24) return p23.dist < p24.dist end)

  for index20, value27 in ipairs(v53) do
    if not v17.WallCheck or f16(value27.part) then
      return value27.part
    end
  end

  return nil
end

local v57 = {
  { "Head", "UpperTorso" }, { "UpperTorso", "LowerTorso" }, { "UpperTorso", "LeftUpperArm" },
  { "LeftUpperArm", "LeftLowerArm" }, { "LeftLowerArm", "LeftHand" },
  { "UpperTorso", "RightUpperArm" }, { "RightUpperArm", "RightLowerArm" },
  { "RightLowerArm", "RightHand" }, { "LowerTorso", "LeftUpperLeg" },
  { "LeftUpperLeg", "LeftLowerLeg" }, { "LeftLowerLeg", "LeftFoot" },
  { "LowerTorso", "RightUpperLeg" }, { "RightUpperLeg", "RightLowerLeg" },
  { "RightLowerLeg", "RightFoot" },
}

local silentAim, connect8

connect8 = runService.RenderStepped:Connect(function()
  local v58, v59, v60

  if getgenv().OverdoseUnloaded then
    connect8:Disconnect()
    return
  else
    local position3 = currentCamera.CFrame.Position
    local viewportSize = currentCamera.ViewportSize
    local vector = Vector2.new(viewportSize.X / 2, viewportSize.Y)

    local humanoidRootPart = localPlayer.Character
      and localPlayer.Character:FindFirstChild("HumanoidRootPart")

    if v17.ShowFOV then
      local fovCenter2 = v17.FOVCenter and viewportSize / 2
        or userInputService:GetMouseLocation()

      if v17.FOVType == "Circle" then
        circle.Position = fovCenter2
        circle.Radius = v17.FOVRadius
        circle.Color = v17.FOVColor
        circle.Visible = true

        local count5 = 0

        while true do
          count5 = 1 + count5

          if not (count5 <= 30) then
            break
          end

          v42[count5].Visible = false
        end
      elseif v17.FOVType == "Dots" then
        circle.Visible = false
        local count6 = 0

        while true do
          count6 = 1 + count6

          if not (30 >= count6) then
            break
          end

          local v61 = count6
          local v62 = v61 / 30 * math.pi * 2

          v42[v61].Position = Vector2.new(
            fovCenter2.X + math.cos(v62) * v17.FOVRadius,
            fovCenter2.Y + math.sin(v62) * v17.FOVRadius
          )

          v42[v61].Color = v17.FOVColor
          v42[v61].Visible = true
        end
      end
    else
      circle.Visible = false
      local count7 = 0

      while true do
        count7 = 1 + count7

        if not (30 >= count7) then
          break
        end

        v42[count7].Visible = false
      end
    end

    silentAim = v17.SilentAim and f17() or nil

    if v17.ShowTarget and silentAim and silentAim.Parent then
      local v63
      v60, v63 = currentCamera:WorldToViewportPoint(silentAim.Position)

      if v63 then
        local markerSize = v17.MarkerSize
        local markerLength = v17.MarkerLength
        local v64 = tick() * v17.RotationSpeed
        v59 = math.cos(v64)
        v58 = math.sin(v64)

        local function f18(p25, p26)
          return Vector2.new(v60.X + (p25 * v59 - p26 * v58), v60.Y + (p25 * v58 + p26 * v59))
        end

        local from = f18(-markerSize, -markerSize)
        local from2 = f18(markerSize, -markerSize)
        local from3 = f18(markerSize, markerSize)
        local from4 = f18(-markerSize, markerSize)

        v43[1].From = from
        v43[1].To = f18(-markerSize + markerLength, -markerSize)
        v43[2].From = from
        v43[2].To = f18(-markerSize, -markerSize + markerLength)
        v43[3].From = from2
        v43[3].To = f18(markerSize - markerLength, -markerSize)
        v43[4].From = from2
        v43[4].To = f18(markerSize, -markerSize + markerLength)
        v43[5].From = from3
        v43[5].To = f18(markerSize - markerLength, markerSize)
        v43[6].From = from3
        v43[6].To = f18(markerSize, markerSize - markerLength)
        v43[7].From = from4
        v43[7].To = f18(-markerSize + markerLength, markerSize)
        v43[8].From = from4
        v43[8].To = f18(-markerSize, markerSize - markerLength)

        for k = 1, 8 do
          v43[k].Visible = true
          v43[k].Color = v17.TargetColor
        end
      else
        for m = 1, 8 do
          v43[m].Visible = false
        end
      end
    else
      local count8 = 0

      while true do
        count8 = 1 + count8

        if not (count8 <= 8) then
          break
        end

        v43[count8].Visible = false
      end
    end

    if v17.CIDevicesESP then
      for n = 1, #v26 do
        local v65 = v27[n]
        local v66 = v28[n]
        local v67 = v30[n]
        v65.Color = v2.Accent

        if v67 and v67.Parent and v67.Parent:IsA("BasePart") then
          local v68, v69 = currentCamera:WorldToViewportPoint(v67.Parent.Position)

          if v69 then
            local vector2 = Vector2.new(v68.X, v68.Y)

            v66.From = vector
            v66.To = vector2
            v66.Visible = true

            v65.From = vector
            v65.To = vector2
            v65.Visible = true
          else
            v66.Visible = false
            v65.Visible = false
          end
        else
          v66.Visible = false
          v65.Visible = false
        end
      end
    else
      local v70 = #v26
      local count9 = 0

      while true do
        count9 = 1 + count9

        if not (count9 <= v70) then
          break
        end

        local v71 = count9
        v27[v71].Visible = false
        v28[v71].Visible = false
      end
    end

    for key8, value28 in pairs(v44) do
      local v72 = value28
      local character2 = key8.Character
      local v73 = true

      if v17.ESPEnabled and humanoidRootPart and key8.Parent and character2
        and character2.Parent then
        local humanoid2 = character2:FindFirstChild("Humanoid")
        local humanoidRootPart2 = character2:FindFirstChild("HumanoidRootPart")
        local head = character2:FindFirstChild("Head")

        if humanoid2 and humanoidRootPart2 and head and humanoid2.Parent
          and humanoidRootPart2.Parent and head.Parent and humanoid2.Health > 0 then
          if (humanoidRootPart2.Position - position3).Magnitude <= v17.MaxDistance then
            if not v17.ESPTeamCheck or key8.Team ~= localPlayer.Team then
              local v74 = v41[key8]
              local status2 = v74 and v74.Status or "Enemy"

              if not (v17.SmartTargeting and status2 == "Friendly") then
                if not pcall(function()
                  local v75, v76 = currentCamera:WorldToViewportPoint(humanoidRootPart2.Position)

                  if v76 then
                    v73 = false

                    local worldToViewportPoint = currentCamera:WorldToViewportPoint(head.Position + Vector3.new(
                      0, 0.5, 0
                    ))

                    local vector3 = Vector3.new(0, 3, 0)

                    local worldToViewportPoint2 = currentCamera:WorldToViewportPoint(humanoidRootPart2.Position
                      - vector3)

                    local v77 = math.abs(worldToViewportPoint.Y - worldToViewportPoint2.Y)
                    local v78 = v77 / 2
                    local vector4 = Vector2.new(v75.X - v78 / 2, worldToViewportPoint.Y)
                    local vector5 = Vector2.new(v78, v77)

                    if v17.DrawBoxes then
                      if v17.ESPBoxType == "Default" then
                        v72.BoxOutline.Size = vector5
                        v72.BoxOutline.Position = vector4
                        v72.BoxOutline.Visible = true
                        v72.Box.Size = vector5
                        v72.Box.Position = vector4
                        v72.Box.Color = v17.ESPColor
                        v72.Box.Visible = true

                        for i6 = 1, 8 do
                          v72.Corners[i6].Visible = false
                          v72.CornersGlow1[i6].Visible = false
                          v72.CornersGlow2[i6].Visible = false
                        end

                        if v17.DrawGlow then
                          v72.Glow1.Size = Vector2.new(vector5.X + 2, vector5.Y + 2)
                          v72.Glow1.Position = Vector2.new(vector4.X - 1, vector4.Y - 1)
                          v72.Glow1.Color = v17.ESPColor
                          v72.Glow1.Visible = true
                          v72.Glow2.Size = Vector2.new(vector5.X + 4, vector5.Y + 4)
                          v72.Glow2.Position = Vector2.new(vector4.X - 2, vector4.Y - 2)
                          v72.Glow2.Color = v17.ESPColor
                          v72.Glow2.Visible = true
                          v72.Glow3.Size = Vector2.new(vector5.X + 6, vector5.Y + 6)
                          v72.Glow3.Position = Vector2.new(vector4.X - 3, vector4.Y - 3)
                          v72.Glow3.Color = v17.ESPColor
                          v72.Glow3.Visible = true
                          v72.Glow4.Size = Vector2.new(vector5.X + 8, vector5.Y + 8)
                          v72.Glow4.Position = Vector2.new(vector4.X - 4, vector4.Y - 4)
                          v72.Glow4.Color = v17.ESPColor
                          v72.Glow4.Visible = true
                        else
                          v72.Glow1.Visible = false
                          v72.Glow2.Visible = false
                          v72.Glow3.Visible = false
                          v72.Glow4.Visible = false
                        end
                      elseif v17.ESPBoxType == "Corners" then
                        v72.BoxOutline.Visible = false
                        v72.Box.Visible = false
                        v72.Glow1.Visible = false
                        v72.Glow2.Visible = false
                        v72.Glow3.Visible = false
                        v72.Glow4.Visible = false

                        local v79 = math.min(v78 / 3, v77 / 4)
                        local vector6 = Vector2.new(vector4.X + v78, vector4.Y)
                        local vector7 = Vector2.new(vector4.X, vector4.Y + v77)
                        local vector8 = Vector2.new(vector4.X + v78, vector4.Y + v77)

                        local function f19(p27, from5, to)
                          v72.Corners[p27].From = from5
                          v72.Corners[p27].To = to
                          v72.Corners[p27].Color = v17.ESPColor
                          v72.Corners[p27].Visible = true

                          if v17.DrawGlow then
                            v72.CornersGlow1[p27].From = from5
                            v72.CornersGlow1[p27].To = to
                            v72.CornersGlow1[p27].Color = v17.ESPColor
                            v72.CornersGlow1[p27].Visible = true
                            v72.CornersGlow2[p27].From = from5
                            v72.CornersGlow2[p27].To = to
                            v72.CornersGlow2[p27].Color = v17.ESPColor
                            v72.CornersGlow2[p27].Visible = true
                          else
                            v72.CornersGlow1[p27].Visible = false
                            v72.CornersGlow2[p27].Visible = false
                          end
                        end

                        f19(1, vector4, vector4 + Vector2.new(v79, 0))
                        f19(2, vector4, vector4 + Vector2.new(0, v79))
                        f19(3, vector6, vector6 - Vector2.new(v79, 0))
                        f19(4, vector6, vector6 + Vector2.new(0, v79))
                        f19(5, vector7, vector7 + Vector2.new(v79, 0))
                        f19(6, vector7, vector7 - Vector2.new(0, v79))
                        f19(7, vector8, vector8 - Vector2.new(v79, 0))
                        f19(8, vector8, vector8 - Vector2.new(0, v79))
                      end
                    else
                      v72.BoxOutline.Visible = false
                      v72.Box.Visible = false
                      v72.Glow1.Visible = false
                      v72.Glow2.Visible = false
                      v72.Glow3.Visible = false
                      v72.Glow4.Visible = false

                      for i7 = 1, 8 do
                        v72.Corners[i7].Visible = false
                        v72.CornersGlow1[i7].Visible = false
                        v72.CornersGlow2[i7].Visible = false
                      end
                    end

                    if v17.DrawHealthBar then
                      local v80 = math.max(humanoid2.MaxHealth, 1)
                      local v81 = math.clamp(humanoid2.Health, 0, v80)
                      local v82 = math.floor(v77 * (v81 / v80))

                      v72.HealthOutline.Size = Vector2.new(3, v77 + 2)
                      v72.HealthOutline.Position = Vector2.new(vector4.X - 5, vector4.Y - 1)
                      v72.HealthOutline.Visible = true
                      v72.HealthBar.Size = Vector2.new(1, v82)
                      v72.HealthBar.Position = Vector2.new(vector4.X - 4, vector4.Y + v77 - v82)

                      v72.HealthBar.Color = Color3.fromRGB(
                        255 - v81 / v80 * 255, v81 / v80 * 255, 0
                      )

                      v72.HealthBar.Visible = true
                    else
                      v72.HealthOutline.Visible = false
                      v72.HealthBar.Visible = false
                    end

                    if v17.DrawSkeletons then
                      for index21, value29 in ipairs(v57) do
                        local findFirstChild2 = character2:FindFirstChild(value29[1])
                        local findFirstChild3 = character2:FindFirstChild(value29[2])

                        if findFirstChild2 and findFirstChild3 then
                          local v83, v84 = currentCamera:WorldToViewportPoint(findFirstChild2.Position)
                          local v85, v86 = currentCamera:WorldToViewportPoint(findFirstChild3.Position)

                          if v84 or v86 then
                            v72.Skeleton[index21].From = Vector2.new(v83.X, v83.Y)
                            v72.Skeleton[index21].To = Vector2.new(v85.X, v85.Y)
                            v72.Skeleton[index21].Color = v17.ESPColor
                            v72.Skeleton[index21].Visible = true
                          else
                            v72.Skeleton[index21].Visible = false
                          end
                        else
                          v72.Skeleton[index21].Visible = false
                        end
                      end
                    else
                      for i8 = 1, 14 do
                        v72.Skeleton[i8].Visible = false
                      end
                    end
                  end
                end) then
                  v73 = true
                end
              end
            end
          end
        end
      end

      if v73 then
        v72.BoxOutline.Visible = false
        v72.Box.Visible = false
        v72.Glow1.Visible = false
        v72.Glow2.Visible = false
        v72.Glow3.Visible = false
        v72.Glow4.Visible = false
        v72.HealthOutline.Visible = false
        v72.HealthBar.Visible = false

        local count10 = 0

        while true do
          count10 = 1 + count10

          if not (count10 <= 14) then
            break
          end

          v72.Skeleton[count10].Visible = false
        end

        local count11 = 0

        while true do
          count11 = 1 + count11

          if not (8 >= count11) then
            break
          end

          local v87 = count11

          v72.Corners[v87].Visible = false
          v72.CornersGlow1[v87].Visible = false
          v72.CornersGlow2[v87].Visible = false
        end
      end
    end

    return
  end
end)

local v88

v88 = hookmetamethod(game, "__namecall", function(p28, ...)
  if getgenv().OverdoseUnloaded then
    return v88(p28, ...)
  else
    local v89 = getnamecallmethod()
    local v90 = { ... }

    if not checkcaller() and v89 == "Raycast" and v17.SilentAim and silentAim
      and silentAim.Parent then
      local v91 = v90[2]
      local v92 = v90[1]

      if v92 ~= currentCamera.CFrame.Position and v91.Magnitude > 20 then
        v90[2] = (silentAim.Position - v92).Unit * v91.Magnitude
        return v88(p28, unpack(v90))
      end

      return v88(p28, ...)
    end

    if not checkcaller() and v89 == "FireServer" and tostring(p28) == "RemoteEvent" then
      if type(v90[1]) == "table" and type(v90[1][1]) == "table" and #v90[1][1] == 3 then
        if v17.SilentAim and silentAim and silentAim.Parent then
          v90[1][1] = { silentAim.Position.X, silentAim.Position.Y, silentAim.Position.Z }
          v90[1][2] = true
          v90[3] = silentAim

          return v88(p28, unpack(v90))
        end

        return v88(p28, ...)
      end

      return v88(p28, ...)
    end

    return v88(p28, ...)
  end
end)

local v93 = f5("Frame", {
  Parent = v6,
  Size = UDim2.new(0, 220, 0, 24),
  Position = UDim2.new(0, 20, 0, 20),
  BackgroundColor3 = v2.MainBg,
  BorderColor3 = v2.Border,
  BorderSizePixel = 1,
  Visible = false,
})

f1(f5("Frame", {
  Parent = v93,
  Size = UDim2.new(1, 0, 0, 1),
  BackgroundColor3 = v2.Accent,
  BorderSizePixel = 0,
}))

f6(v93, v93)
f8(v93, v2.Accent)

local v94 = f5("Frame", {
  Parent = f5("Frame", {
    Parent = v93,
    Size = UDim2.new(0, 16, 0, 16),
    Position = UDim2.new(0, 5, 0.5, -8),
    BackgroundTransparency = 1,
  }),
  Size = UDim2.new(1, 0, 1, 0),
  AnchorPoint = Vector2.new(0.5, 0.5),
  Position = UDim2.new(0.5, 0, 0.5, 0),
  BackgroundTransparency = 1,
})

local function f20(p29, p30, p31, p32)
  local parent5 = f5("Frame", {
    Parent = v94,
    Size = UDim2.new(0, 4, 0, 4),
    Position = UDim2.new(p32 and 0 or 1, p32 and 0 or -4, p31 and 0 or 1, p31 and 0 or -4),
    BackgroundTransparency = 1,
  })

  f1(f5("Frame", {
    Parent = parent5,
    Size = UDim2.new(1, 0, 0, 1),
    Position = UDim2.new(0, 0, p31 and 0 or 1, p31 and 0 or -1),
    BackgroundColor3 = v2.Accent,
    BorderSizePixel = 0,
  }))

  f1(f5("Frame", {
    Parent = parent5,
    Size = UDim2.new(0, 1, 1, 0),
    Position = UDim2.new(p32 and 0 or 1, p32 and 0 or -1, 0, 0),
    BackgroundColor3 = v2.Accent,
    BorderSizePixel = 0,
  }))
end

f20(0, 0, true, true)
f20(1, 0, true, false)
f20(0, 1, false, true)
f20(1, 1, false, false)

local v95 = f5("TextLabel", {
  Parent = v93,
  Size = UDim2.new(1, -30, 1, 0),
  Position = UDim2.new(0, 28, 0, 0),
  BackgroundTransparency = 1,
  Text = "Overdose.gg | FPS: 0",
  TextColor3 = v2.Text,
  Font = code,
  TextSize = 12,
  TextXAlignment = Enum.TextXAlignment.Left,
})

f7(v95)
local v96 = tick()
local v97 = 0
local v98 = v96
local renderStepped = runService.RenderStepped

local connect9

connect9 = renderStepped:Connect(function()
  if getgenv().OverdoseUnloaded then
    connect9:Disconnect()
    return
  end

  v97 = v97 + 1
  v94.Rotation = v94.Rotation + 0.15

  if tick() - v98 >= 1 then
    v95.Text = string.format("Overdose.gg | FPS: %d", v97)
    v97 = 0
    v98 = tick()
  end
end)

function v1:CreateWindow(text3)
  local v99 = {}

  local v100 = f5("Frame", {
    Parent = v6,
    Size = UDim2.new(0, 300, 0, 60),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    BackgroundColor3 = v2.MainBg,
    BorderColor3 = v2.Border,
    BorderSizePixel = 1,
  })

  f1(f5("Frame", {
    Parent = v100,
    Size = UDim2.new(1, 0, 0, 1),
    BackgroundColor3 = v2.Accent,
    BorderSizePixel = 0,
  }))

  f8(v100, v2.Accent)

  f7((f5("TextLabel", {
    Parent = v100,
    Size = UDim2.new(1, 0, 0, 30),
    BackgroundTransparency = 1,
    Text = "Loading Overdose.gg...",
    TextColor3 = v2.Text,
    Font = code,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Center,
  })))

  local v101 = f1(f5("Frame", {
    Parent = f5("Frame", {
      Parent = v100,
      Size = UDim2.new(1, -20, 0, 4),
      Position = UDim2.new(0, 10, 0, 35),
      BackgroundColor3 = v2.SectionBg,
      BorderColor3 = v2.Border,
      BorderSizePixel = 1,
    }),
    Size = UDim2.new(0, 0, 1, 0),
    BackgroundColor3 = v2.Accent,
    BorderSizePixel = 0,
  }))

  f9(v101, v2.Accent)

  local v102 = f5("Frame", {
    Parent = v6,
    Size = UDim2.new(0, 800, 0, 500),
    Position = UDim2.new(0.5, -400, 0.5, -250),
    BackgroundColor3 = v2.MainBg,
    BorderColor3 = v2.Border,
    BorderSizePixel = 1,
    Visible = false,
  })

  getgenv().MainGuiFrame = v102

  tweenService:Create(
    v101, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    { Size = UDim2.new(1, 0, 1, 0) }
  ):Play()

  task.delay(1.7, function()
    if v100 then
      v100:Destroy()
    end

    if v102 then
      v102.Visible = true
    end

    if v93 then
      v93.Visible = true
    end
  end)

  local v103 = f5("Frame", {
    Parent = v102,
    Size = UDim2.new(1, 0, 0, 25),
    BackgroundColor3 = v2.MainBg,
    BorderColor3 = v2.Border,
    BorderSizePixel = 1,
  })

  f6(v103, v102)

  f7((f5("TextLabel", {
    Parent = v103,
    Size = UDim2.new(1, -10, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1,
    Text = text3,
    TextColor3 = v2.Text,
    Font = code,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
  })))

  local v104 = f5("Frame", {
    Parent = v102,
    Size = UDim2.new(1, 0, 0, 30),
    Position = UDim2.new(0, 0, 0, 25),
    BackgroundColor3 = v2.MainBg,
    BorderColor3 = v2.Border,
    BorderSizePixel = 1,
  })

  f5("UIListLayout", {
    Parent = v104,
    FillDirection = Enum.FillDirection.Horizontal,
    SortOrder = Enum.SortOrder.LayoutOrder,
  })

  local v105 = f5("Folder", { Parent = v102, Name = "Pages" })
  local v106 = true

  function v99:CreateTab(text4)
    local v107 = {}

    local v108 = f5("TextButton", {
      Parent = v104,
      Size = UDim2.new(0, 100, 1, 0),
      BackgroundTransparency = 1,
      Text = text4,
      TextColor3 = v106 and v2.Text or v2.TextDark,
      Font = code,
      TextSize = 13,
    })

    f7(v108)

    if v106 then
      f3(v108)
    end

    local v109 = f5("Frame", {
      Parent = v105,
      Size = UDim2.new(1, 0, 1, -55),
      Position = UDim2.new(0, 0, 0, 55),
      BackgroundTransparency = 1,
      Visible = v106,
    })

    local v110 = f5("ScrollingFrame", {
      Parent = v109,
      Size = UDim2.new(0.5, -15, 1, -20),
      Position = UDim2.new(0, 10, 0, 10),
      BackgroundTransparency = 1,
      ScrollBarThickness = 2,
      CanvasSize = UDim2.new(0, 0, 0, 0),
      AutomaticCanvasSize = Enum.AutomaticSize.Y,
    })

    f5("UIListLayout", {
      Parent = v110,
      Padding = UDim.new(0, 10),
      SortOrder = Enum.SortOrder.LayoutOrder,
    })

    local v111 = f5("ScrollingFrame", {
      Parent = v109,
      Size = UDim2.new(0.5, -15, 1, -20),
      Position = UDim2.new(0.5, 5, 0, 10),
      BackgroundTransparency = 1,
      ScrollBarThickness = 2,
      CanvasSize = UDim2.new(0, 0, 0, 0),
      AutomaticCanvasSize = Enum.AutomaticSize.Y,
    })

    f5("UIListLayout", {
      Parent = v111,
      Padding = UDim.new(0, 10),
      SortOrder = Enum.SortOrder.LayoutOrder,
    })

    v108.MouseButton1Click:Connect(function()
      for key9, value30 in pairs(v105:GetChildren()) do
        value30.Visible = false
      end

      for key10, value31 in pairs(v104:GetChildren()) do
        if value31:IsA("TextButton") then
          value31.TextColor3 = v2.TextDark
        end
      end

      v109.Visible = true
      v108.TextColor3 = v2.Accent
    end)

    v106 = false

    function v107:CreateSection(p33, p34)
      local v112 = {}

      local parent6 = f5("Frame", {
        Parent = p34:lower() == "left" and v110 or v111,
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundColor3 = v2.SectionBg,
        BorderColor3 = v2.Border,
        BorderSizePixel = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
      })

      f1(f5("Frame", {
        Parent = parent6,
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = v2.Accent,
        BorderSizePixel = 0,
      }))

      f7((f5("TextLabel", {
        Parent = parent6,
        Size = UDim2.new(1, -10, 0, 20),
        Position = UDim2.new(0, 10, 0, 2),
        BackgroundTransparency = 1,
        Text = "- " .. p33 .. " -",
        TextColor3 = v2.Text,
        Font = code,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
      })))

      local parent7 = f5("Frame", {
        Parent = parent6,
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 25),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
      })

      f5("UIListLayout", {
        Parent = parent7,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
      })

      f5("UIPadding", {
        Parent = parent7,
        PaddingTop = UDim.new(0, 2),
        PaddingLeft = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
      })

      function v112:CreateToggle(p35, p36, p37)
        local v113 = p36 or false

        local parent8 = f5("Frame", {
          Parent = parent7,
          Size = UDim2.new(1, 0, 0, 15),
          BackgroundTransparency = 1,
        })

        local v114 = f5("Frame", {
          Parent = parent8,
          Size = UDim2.new(0, 10, 0, 10),
          Position = UDim2.new(0, 0, 0.5, -5),
          BackgroundColor3 = v2.ElementBg,
          BorderColor3 = v2.Border,
          BorderSizePixel = 1,
        })

        local v115 = f1(f5("Frame", {
          Parent = v114,
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundColor3 = v2.Accent,
          BorderSizePixel = 0,
          Visible = v113,
        }))

        local v116 = f9(v114, v2.Accent)
        v116.Visible = v113

        local v117 = f5("TextLabel", {
          Parent = parent8,
          Size = UDim2.new(1, -20, 1, 0),
          Position = UDim2.new(0, 15, 0, 0),
          BackgroundTransparency = 1,
          Text = p35,
          TextColor3 = v113 and v2.Text or v2.TextDark,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
          RichText = true,
        })

        f7(v117)

        f5("TextButton", {
          Parent = parent8,
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundTransparency = 1,
          Text = "",
        }).MouseButton1Click:Connect(function()
          v113 = not v113
          v115.Visible = v113
          v116.Visible = v113

          if not string.find(p35, "<font") then
            v117.TextColor3 = v113 and v2.Text or v2.TextDark
          end

          if p37 then
            p37(v113)
          end
        end)
      end

      function v112:CreateSlider(text5, p38, p39, p40, p41)
        local v118 = p40 or p38

        local parent9 = f5("Frame", {
          Parent = parent7,
          Size = UDim2.new(1, 0, 0, 30),
          BackgroundTransparency = 1,
        })

        local v119 = f5("TextLabel", {
          Parent = parent9,
          Size = UDim2.new(1, 0, 0, 15),
          BackgroundTransparency = 1,
          Text = text5,
          TextColor3 = v2.Text,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        local v120 = f5("TextLabel", {
          Parent = parent9,
          Size = UDim2.new(1, 0, 0, 15),
          BackgroundTransparency = 1,
          Text = tostring(v118),
          TextColor3 = v2.Text,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Right,
        })

        f7(v119)
        f7(v120)

        local v121 = f5("Frame", {
          Parent = parent9,
          Size = UDim2.new(1, 0, 0, 4),
          Position = UDim2.new(0, 0, 0, 20),
          BackgroundColor3 = v2.ElementBg,
          BorderColor3 = v2.Border,
          BorderSizePixel = 1,
        })

        local v122 = f1(f5("Frame", {
          Parent = v121,
          Size = UDim2.new((v118 - p38) / (p39 - p38), 0, 1, 0),
          BackgroundColor3 = v2.Accent,
          BorderSizePixel = 0,
        }))

        f9(v122, v2.Accent)

        local v123 = f5("TextButton", {
          Parent = v121,
          Size = UDim2.new(1, 0, 1, 20),
          Position = UDim2.new(0, 0, 0.5, -10),
          BackgroundTransparency = 1,
          Text = "",
        })

        local v124 = false
        v123.MouseButton1Down:Connect(function() v124 = true end)

        userInputService.InputEnded:Connect(function(input6)
          if input6.UserInputType == Enum.UserInputType.MouseButton1 then
            v124 = false
          end
        end)

        userInputService.InputChanged:Connect(function(input7)
          if v124 and input7.UserInputType == Enum.UserInputType.MouseMovement then
            local v125 = math.clamp((input7.Position.X - v121.AbsolutePosition.X)
              / v121.AbsoluteSize.X, 0, 1)

            v118 = math.floor(p38 + (p39 - p38) * v125)
            v122.Size = UDim2.new(v125, 0, 1, 0)
            v120.Text = tostring(v118)

            if p41 then
              p41(v118)
            end
          end
        end)
      end

      function v112:CreateDropdown(text6, p42, p43)
        local parent10 = f5("Frame", {
          Parent = parent7,
          Size = UDim2.new(1, 0, 0, 0),
          BackgroundTransparency = 1,
          AutomaticSize = Enum.AutomaticSize.Y,
        })

        f5("UIListLayout", {
          Parent = parent10,
          Padding = UDim.new(0, 2),
          SortOrder = Enum.SortOrder.LayoutOrder,
        })

        f7((f5("TextLabel", {
          Parent = parent10,
          Size = UDim2.new(1, 0, 0, 15),
          BackgroundTransparency = 1,
          Text = text6,
          TextColor3 = v2.Text,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })))

        local v126 = f5("TextButton", {
          Parent = parent10,
          Size = UDim2.new(1, 0, 0, 20),
          BackgroundColor3 = v2.ElementBg,
          BorderColor3 = v2.Border,
          BorderSizePixel = 1,
          Text = "  " .. p42[1],
          TextColor3 = v2.Text,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f1(f5("Frame", {
          Parent = v126,
          Size = UDim2.new(0, 2, 1, 0),
          BackgroundColor3 = v2.Accent,
          BorderSizePixel = 0,
        }))

        f7(v126)

        local v127 = f5("TextLabel", {
          Parent = v126,
          Size = UDim2.new(0, 20, 1, 0),
          Position = UDim2.new(1, -20, 0, 0),
          BackgroundTransparency = 1,
          Text = "▼",
          TextColor3 = v2.TextDark,
          Font = code,
          TextSize = 12,
        })

        f7(v127)

        local v128 = f5("Frame", {
          Parent = parent10,
          Size = UDim2.new(1, 0, 0, 0),
          BackgroundColor3 = v2.ElementBg,
          BorderColor3 = v2.Border,
          BorderSizePixel = 1,
          Visible = false,
          AutomaticSize = Enum.AutomaticSize.Y,
        })

        f5("UIListLayout", { Parent = v128, SortOrder = Enum.SortOrder.LayoutOrder })
        local v129 = { isOpen = false, current = p42[1], options = {} }
        table.insert(v1.MenuDropdowns, v129)

        for index22, value32 in ipairs(p42) do
          local v130 = value32

          local v131 = f5("TextButton", {
            Parent = v128,
            Size = UDim2.new(1, 0, 0, 20),
            BackgroundTransparency = 1,
            Text = "  " .. v130,
            TextColor3 = v2.TextDark,
            Font = code,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
          })

          f7(v131)
          table.insert(v129.options, { btn = v131, name = v130 })

          v131.MouseButton1Click:Connect(function()
            v129.current = v130
            v126.Text = "  " .. v130
            v128.Visible = false
            v129.isOpen = false
            v127.Text = "▼"

            if p43 then
              p43(v130)
            end
          end)

          v131.MouseEnter:Connect(function()
            if v129.current ~= v130 then
              v131.TextColor3 = v2.Text
            end
          end)

          v131.MouseLeave:Connect(function()
            if v129.current ~= v130 then
              v131.TextColor3 = v2.TextDark
            end
          end)
        end

        v126.MouseButton1Click:Connect(function()
          v128.Visible = not v128.Visible
          v129.isOpen = v128.Visible
          v127.Text = v128.Visible and "▲" or "▼"

          if v128.Visible then
            for index23, value33 in ipairs(v129.options) do
              local btn = value33.btn
              btn.TextColor3 = value33.name == v129.current and v2.Accent or v2.TextDark
            end
          end
        end)
      end

      function v112:CreateKeybind(p44, p45, p46, p47)
        local keyCode = p45
        local v132 = false
        local v133 = false

        if not p47 then
          v1.RegisteredKeybinds[p44] = { key = keyCode, state = v133 }
          v1:UpdateKeybindList()
        end

        local parent11 = f5("Frame", {
          Parent = parent7,
          Size = UDim2.new(1, 0, 0, 15),
          BackgroundTransparency = 1,
        })

        local v134 = f5("TextLabel", {
          Parent = parent11,
          Size = UDim2.new(0.5, 0, 1, 0),
          BackgroundTransparency = 1,
          Text = p44,
          TextColor3 = v2.Text,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f7(v134)

        local v135 = f5("TextButton", {
          Parent = parent11,
          Size = UDim2.new(0.5, 0, 1, 0),
          Position = UDim2.new(0.5, 0, 0, 0),
          BackgroundTransparency = 1,
          Text = keyCode and "[ " .. keyCode.Name .. " ]" or "[ NONE ]",
          TextColor3 = v2.TextDark,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Right,
        })

        f7(v135)
        local v136 = { btn = v135, txt = v134, state = false }
        table.insert(v1.MenuKeybinds, v136)

        v135.MouseButton1Click:Connect(function()
          v132 = true
          v135.Text = "[ ... ]"
          v135.TextColor3 = v2.Accent
        end)

        userInputService.InputBegan:Connect(function(input8, p48)
          if v132 and input8.UserInputType == Enum.UserInputType.Keyboard then
            if input8.KeyCode == Enum.KeyCode.Escape then
              keyCode = nil
              v135.Text = "[ NONE ]"
            else
              keyCode = input8.KeyCode
              v135.Text = "[ " .. keyCode.Name .. " ]"
            end

            v135.TextColor3 = v2.TextDark
            v134.TextColor3 = v2.Text
            v132 = false

            if not p47 then
              v1.RegisteredKeybinds[p44].key = keyCode
              v1:UpdateKeybindList()
            end

            if p47 and p46 then
              p46(v133, keyCode)
            end
          elseif not v132 and keyCode and input8.KeyCode == keyCode and not p48 then
            v133 = not v133
            v136.state = v133

            if v133 then
              v135.TextColor3 = v2.Accent
              v134.TextColor3 = v2.Accent
            else
              v135.TextColor3 = v2.TextDark
              v134.TextColor3 = v2.Text
            end

            if not p47 then
              v1.RegisteredKeybinds[p44].state = v133
              v1:UpdateKeybindList()
            end

            if p46 then
              p46(v133, keyCode)
            end
          end
        end)
      end

      function v112:CreateColorPicker(text7, p49, p50, p51)
        local color2 = p49 or Color3.new(1, 1, 1)
        local v137, v138, v139 = Color3.toHSV(color2)
        local v140 = v138
        local v141 = v139

        local parent12 = f5("Frame", {
          Parent = parent7,
          Size = UDim2.new(1, 0, 0, 0),
          BackgroundTransparency = 1,
          AutomaticSize = Enum.AutomaticSize.Y,
        })

        f5("UIListLayout", {
          Parent = parent12,
          Padding = UDim.new(0, 4),
          SortOrder = Enum.SortOrder.LayoutOrder,
        })

        local parent13 = f5("Frame", {
          Parent = parent12,
          Size = UDim2.new(1, 0, 0, 15),
          BackgroundTransparency = 1,
        })

        f7((f5("TextLabel", {
          Parent = parent13,
          Size = UDim2.new(1, -20, 1, 0),
          BackgroundTransparency = 1,
          Text = text7,
          TextColor3 = v2.Text,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })))

        local v142 = f5("TextButton", {
          Parent = parent13,
          Size = UDim2.new(0, 20, 0, 10),
          Position = UDim2.new(1, -20, 0.5, -5),
          BackgroundColor3 = color2,
          BorderColor3 = v2.Border,
          BorderSizePixel = 1,
          Text = "",
        })

        local v143 = f5("Frame", {
          Parent = parent12,
          Size = UDim2.new(1, 0, 0, 110),
          BackgroundColor3 = v2.ElementBg,
          BorderColor3 = v2.Border,
          BorderSizePixel = 1,
          Visible = false,
        })

        local parent14 = f5("Frame", {
          Parent = v143,
          Size = UDim2.new(1, -10, 1, -10),
          Position = UDim2.new(0, 5, 0, 5),
          BackgroundTransparency = 1,
        })

        local v144 = f5("TextButton", {
          Parent = parent14,
          Size = UDim2.new(1, -20, 1, 0),
          Position = UDim2.new(0, 0, 0, 0),
          BackgroundColor3 = Color3.fromHSV(v137, 1, 1),
          BorderColor3 = v2.Border,
          BorderSizePixel = 1,
          Text = "",
          AutoButtonColor = false,
        })

        f5("UIGradient", {
          Parent = f5("Frame", {
            Parent = v144,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = Color3.new(1, 1, 1),
            BorderSizePixel = 0,
          }),
          Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1),
          }),
        })

        f5("UIGradient", {
          Parent = f5("Frame", {
            Parent = v144,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = Color3.new(0, 0, 0),
            BorderSizePixel = 0,
          }),
          Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0),
          }),
          Rotation = 90,
        })

        local v145 = f5("Frame", {
          Parent = v144,
          Size = UDim2.new(0, 4, 0, 4),
          AnchorPoint = Vector2.new(0.5, 0.5),
          Position = UDim2.new(v140, 0, 1 - v141, 0),
          BackgroundColor3 = Color3.new(1, 1, 1),
          BorderColor3 = Color3.new(0, 0, 0),
          BorderSizePixel = 1,
        })

        local v146 = f5("TextButton", {
          Parent = parent14,
          Size = UDim2.new(0, 15, 1, 0),
          Position = UDim2.new(1, -15, 0, 0),
          BackgroundColor3 = Color3.new(1, 1, 1),
          BorderColor3 = v2.Border,
          BorderSizePixel = 1,
          Text = "",
          AutoButtonColor = false,
        })

        f5("UIGradient", {
          Parent = v146,
          Rotation = 90,
          Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.166, Color3.fromRGB(255, 0, 255)),
            ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.666, Color3.fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
          }),
        })

        local v147 = f5("Frame", {
          Parent = v146,
          Size = UDim2.new(1, 2, 0, 2),
          AnchorPoint = Vector2.new(0.5, 0.5),
          Position = UDim2.new(0.5, 0, 1 - v137, 0),
          BackgroundColor3 = Color3.new(1, 1, 1),
          BorderColor3 = Color3.new(0, 0, 0),
          BorderSizePixel = 1,
        })

        local function f21()
          color2 = Color3.fromHSV(v137, v140, v141)
          v144.BackgroundColor3 = Color3.fromHSV(v137, 1, 1)
          v142.BackgroundColor3 = color2

          if p51 then
            p51(color2)
          end
        end

        local v148 = false
        local v149 = false
        v146.MouseButton1Down:Connect(function() v148 = true end)
        v144.MouseButton1Down:Connect(function() v149 = true end)

        userInputService.InputEnded:Connect(function(input9)
          if input9.UserInputType == Enum.UserInputType.MouseButton1 then
            v148 = false
            v149 = false
          end
        end)

        userInputService.InputChanged:Connect(function(input10)
          if v148 and input10.UserInputType == Enum.UserInputType.MouseMovement then
            v137 = 1 - math.clamp(
              (input10.Position.Y - v146.AbsolutePosition.Y) / v146.AbsoluteSize.Y, 0, 1
            )

            v147.Position = UDim2.new(0.5, 0, 1 - v137, 0)
            f21()
          elseif v149 and input10.UserInputType == Enum.UserInputType.MouseMovement then
            v140 = math.clamp((input10.Position.X - v144.AbsolutePosition.X)
              / v144.AbsoluteSize.X, 0, 1)

            v141 = 1 - math.clamp(
              (input10.Position.Y - v144.AbsolutePosition.Y) / v144.AbsoluteSize.Y, 0, 1
            )

            v145.Position = UDim2.new(v140, 0, 1 - v141, 0)
            f21()
          end
        end)

        v142.MouseButton1Click:Connect(function() v143.Visible = not v143.Visible end)
      end

      function v112:CreateButton(p52, p53)
        local v150 = f5("TextButton", {
          Parent = f5("Frame", {
            Parent = parent7,
            Size = UDim2.new(1, 0, 0, 20),
            BackgroundTransparency = 1,
          }),
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundColor3 = v2.ElementBg,
          BorderColor3 = v2.Border,
          BorderSizePixel = 1,
          Text = "  " .. p52,
          TextColor3 = v2.Text,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f1(f5("Frame", {
          Parent = v150,
          Size = UDim2.new(0, 2, 1, 0),
          BackgroundColor3 = v2.Accent,
          BorderSizePixel = 0,
        }))

        f7(v150)

        local v151 = f9(v150, v2.Accent)
        v151.Visible = false

        v150.MouseButton1Click:Connect(function()
          tweenService:Create(v150, TweenInfo.new(0.1), { BackgroundColor3 = v2.Accent }):Play()

          task.delay(0.1, function()
            tweenService:Create(v150, TweenInfo.new(0.1), { BackgroundColor3 = v2.ElementBg }):Play()
          end)

          if p53 then
            p53()
          end
        end)

        v150.MouseEnter:Connect(function()
          f3(v150)
          v151.Visible = true
        end)

        v150.MouseLeave:Connect(function()
          v150.TextColor3 = v2.Text
          v151.Visible = false
        end)
      end

      function v112:CreateLabel(text8)
        f7((f5("TextLabel", {
          Parent = f5("Frame", {
            Parent = parent7,
            Size = UDim2.new(1, 0, 0, 15),
            BackgroundTransparency = 1,
          }),
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundTransparency = 1,
          Text = text8,
          TextColor3 = v2.TextDark,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
          RichText = true,
        })))
      end

      return v112
    end

    return v107
  end

  return v99
end

local window = v1:CreateWindow("Overdose.gg | Free Version")
local combatTab = window:CreateTab("Combat")

local aimbotSection = combatTab:CreateSection("Aimbot", "Left")

aimbotSection:CreateToggle("Silent Aim", v17.SilentAim, function(silentAim2)
  v17.SilentAim = silentAim2
end)

aimbotSection:CreateToggle("Smart Target", v17.SmartTargeting, function(smartTargeting)
  v17.SmartTargeting = smartTargeting
end)

aimbotSection:CreateToggle("Team Check", v17.TeamCheck, function(teamCheck)
  v17.TeamCheck = teamCheck
end)

aimbotSection:CreateToggle("Wall Check", v17.WallCheck, function(wallCheck)
  v17.WallCheck = wallCheck
end)

aimbotSection:CreateDropdown("Target Part", { "Head", "Torso", "HumanoidRootPart" }, function(targetPart)
  v17.TargetPart = targetPart
end)

aimbotSection:CreateToggle("Auto Reload", v17.AutoReload, function(autoReload)
  v17.AutoReload = autoReload
end)

local visualsSection = combatTab:CreateSection("Visuals", "Right")
visualsSection:CreateToggle("FOV", v17.ShowFOV, function(showFOV) v17.ShowFOV = showFOV end)

visualsSection:CreateDropdown("FOV Type", { "Circle", "Dots" }, function(fovType)
  v17.FOVType = fovType
end)

visualsSection:CreateToggle("Center FOV", v17.FOVCenter, function(fovCenter3)
  v17.FOVCenter = fovCenter3
end)

visualsSection:CreateColorPicker("FOV Color", v17.FOVColor, 0, function(fovColor)
  v17.FOVColor = fovColor
end)

visualsSection:CreateSlider("FOV Radius", 10, 500, v17.FOVRadius, function(fovRadius)
  v17.FOVRadius = fovRadius
end)

visualsSection:CreateToggle("Target Marker", v17.ShowTarget, function(showTarget)
  v17.ShowTarget = showTarget
end)

visualsSection:CreateColorPicker("Marker Color", v17.TargetColor, 0, function(targetColor)
  v17.TargetColor = targetColor
end)

local weaponTab = window:CreateTab("Weapon")

local customSection = weaponTab:CreateSection("Custom", "Left")

customSection:CreateToggle("Enable", v17.CustomWeapon, function(customWeapon)
  v17.CustomWeapon = customWeapon
end)

customSection:CreateDropdown("Material", v20, function(weaponMaterial)
  v17.WeaponMaterial = weaponMaterial
end)

customSection:CreateColorPicker("Core Color", v17.WeaponColor, 0, function(weaponColor)
  v17.WeaponColor = weaponColor
end)

local particlesSection = weaponTab:CreateSection("Particles", "Right")

particlesSection:CreateToggle("Enable Particles", v17.WeaponParticles, function(weaponParticles)
  v17.WeaponParticles = weaponParticles
end)

particlesSection:CreateDropdown("Texture", v19, function(p54) v17.ParticleTexture = v18[p54] end)

particlesSection:CreateColorPicker("Color", v17.WeaponParticleColor, 0, function(weaponParticleColor)
  v17.WeaponParticleColor = weaponParticleColor
end)

local settingsSection = window:CreateTab("World"):CreateSection("Settings", "Left")

settingsSection:CreateToggle("Fullbright", v17.Fullbright, function(fullbright)
  v17.Fullbright = fullbright
end)

settingsSection:CreateToggle("Custom Color", v17.WorldColorEnabled, function(worldColorEnabled)
  v17.WorldColorEnabled = worldColorEnabled
end)

settingsSection:CreateColorPicker("Color", v17.WorldColor, 0, function(worldColor)
  v17.WorldColor = worldColor
end)

local espSection = window:CreateTab("Visuals"):CreateSection("ESP", "Left")

espSection:CreateToggle("Enable", v17.ESPEnabled, function(espEnabled)
  v17.ESPEnabled = espEnabled
end)

espSection:CreateToggle("Team Check", v17.ESPTeamCheck, function(espTeamCheck)
  v17.ESPTeamCheck = espTeamCheck
end)

espSection:CreateToggle("Boxes", v17.DrawBoxes, function(drawBoxes)
  v17.DrawBoxes = drawBoxes
end)

espSection:CreateDropdown("Box Type", { "Default", "Corners" }, function(espBoxType)
  v17.ESPBoxType = espBoxType
end)

espSection:CreateToggle("Glow", v17.DrawGlow, function(drawGlow) v17.DrawGlow = drawGlow end)

espSection:CreateToggle("Skeletons", v17.DrawSkeletons, function(drawSkeletons)
  v17.DrawSkeletons = drawSkeletons
end)

espSection:CreateToggle("Health Bar", v17.DrawHealthBar, function(drawHealthBar)
  v17.DrawHealthBar = drawHealthBar
end)

espSection:CreateSlider("Distance", 100, 5000, v17.MaxDistance, function(maxDistance)
  v17.MaxDistance = maxDistance
end)

espSection:CreateColorPicker("Color", v17.ESPColor, 0, function(espColor)
  v17.ESPColor = espColor
end)

local ciHelperTab = window:CreateTab("CI Helper")

local hacksSection = ciHelperTab:CreateSection("Hacks", "Left")
hacksSection:CreateToggle("Hacks Menu", false, function(p55) v1:SetCIHacksUIVisible(p55) end)

hacksSection:CreateToggle("Tracers", v17.CIDevicesESP, function(ciDevicesESP)
  v17.CIDevicesESP = ciDevicesESP
end)

hacksSection:CreateToggle(
  '<font color="rgb(255, 50, 50)">Fast Disarm</font>', v17.CIFastInteract,
  function(ciFastInteract) v17.CIFastInteract = ciFastInteract end
)

local miscSection = ciHelperTab:CreateSection("Misc", "Right")

miscSection:CreateToggle("Fast Vents", v17.FastClickVents, function(fastClickVents)
  v17.FastClickVents = fastClickVents
end)

miscSection:CreateLabel("Hold LMB on vent")

local settingsTab = window:CreateTab("Settings")

local uiSection = settingsTab:CreateSection("UI", "Left")
uiSection:CreateColorPicker("Accent", v2.Accent, 0, function(p56) v1:ChangeAccent(p56) end)
uiSection:CreateToggle("Keybinds", false, function(p57) v1:SetKeybindsUIVisible(p57) end)

uiSection:CreateKeybind("Toggle Bind", Enum.KeyCode.Home, function(p58, p59)
  if p59 then
    getgenv().ToggleUIKey = p59
  end
end, true)

local informationSection = settingsTab:CreateSection("Information", "Right")

informationSection:CreateButton("Copy Discord Link", function()
  if setclipboard then
    setclipboard("https://discord.gg/kG2EhsgpKM")
  end
end)

informationSection:CreateButton("Unload Script", function()
  getgenv().OverdoseUnloaded = true

  if v6 then
    v6:Destroy()
  end

  if v11 then
    v11:Destroy()
  end

  if v15 then
    v15:Destroy()
  end

  if lighting:FindFirstChild("OverdoseWorldColor") then
    lighting.OverdoseWorldColor:Destroy()
  end

  if v22 then
    lighting.Ambient = v21.Ambient
    lighting.OutdoorAmbient = v21.OutdoorAmbient
    lighting.Brightness = v21.Brightness
    lighting.ClockTime = v21.ClockTime
    lighting.FogEnd = v21.FogEnd
    lighting.GlobalShadows = v21.GlobalShadows
  end

  if connect4 then
    connect4:Disconnect()
  end

  if connect5 then
    connect5:Disconnect()
  end

  if connect2 then
    connect2:Disconnect()
  end

  if connect3 then
    connect3:Disconnect()
  end

  if connect then
    connect:Disconnect()
  end

  if connect8 then
    connect8:Disconnect()
  end

  if connect6 then
    connect6:Disconnect()
  end

  if connect7 then
    connect7:Disconnect()
  end

  if connect9 then
    connect9:Disconnect()
  end

  for key11, value34 in pairs(v44) do
    value34.BoxOutline:Remove()
    value34.Box:Remove()
    value34.Glow1:Remove()
    value34.Glow2:Remove()
    value34.Glow3:Remove()
    value34.Glow4:Remove()
    value34.HealthOutline:Remove()
    value34.HealthBar:Remove()

    local count12 = 0

    while true do
      count12 = 1 + count12

      if not (count12 <= 14) then
        break
      end

      value34.Skeleton[count12]:Remove()
    end

    if value34.Corners then
      for i9 = 1, 8 do
        value34.Corners[i9]:Remove()
        value34.CornersGlow1[i9]:Remove()
        value34.CornersGlow2[i9]:Remove()
      end
    end
  end

  v44 = {}

  if circle then
    circle:Remove()
  end

  local count13 = 0

  while true do
    count13 = 1 + count13

    if not (30 >= count13) then
      break
    end

    local v152 = count13

    if v42[v152] then
      v42[v152]:Remove()
    end
  end

  for i10 = 1, 8 do
    if v43[i10] then
      v43[i10]:Remove()
    end
  end

  for i11 = 1, #v26 do
    if v28[i11] then
      v28[i11]:Remove()
    end

    if v27[i11] then
      v27[i11]:Remove()
    end
  end

  for index24, value35 in ipairs(workspace:GetDescendants()) do
    if value35:IsA("ParticleEmitter") and value35.Name == "WeaponInnerPoints" then
      value35:Destroy()
    end
  end
end)

local function f22()
  local playerGui = localPlayer:FindFirstChild("PlayerGui")

  if not playerGui then
    return nil
  else
    local leaderboard = playerGui:FindFirstChild("Leaderboard")

    if not leaderboard then
      return nil
    else
      local content = leaderboard:FindFirstChild("Content")

      if not content then
        return nil
      end

      return content:FindFirstChild(localPlayer.Name)
    end
  end
end

local v153 = {}
local overdoseIconAnchor, frame, connect10

connect10 = runService.Heartbeat:Connect(function()
  if getgenv().OverdoseUnloaded then
    connect10:Disconnect()

    if overdoseIconAnchor then
      overdoseIconAnchor:Destroy()
    end

    return
  else
    local v154 = f22()

    if v154 then
      if not overdoseIconAnchor or overdoseIconAnchor.Parent ~= v154 then
        if v154:FindFirstChild("OverdoseIconAnchor") then
          v154.OverdoseIconAnchor:Destroy()
        end

        v153 = {}

        overdoseIconAnchor = Instance.new("Frame")
        overdoseIconAnchor.Name = "OverdoseIconAnchor"
        overdoseIconAnchor.Size = UDim2.new(0, 14, 0, 14)
        overdoseIconAnchor.AnchorPoint = Vector2.new(0.5, 0.5)
        overdoseIconAnchor.Position = UDim2.new(0, 15, 0.5, 0)
        overdoseIconAnchor.BackgroundTransparency = 1
        overdoseIconAnchor.ZIndex = 9999
        overdoseIconAnchor.Parent = v154

        frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.AnchorPoint = Vector2.new(0.5, 0.5)
        frame.Position = UDim2.new(0.5, 0, 0.5, 0)
        frame.BackgroundTransparency = 1
        frame.ZIndex = 9999
        frame.Parent = overdoseIconAnchor

        local function f23(p60, p61, p62, p63)
          local frame2 = Instance.new("Frame")
          frame2.Size = UDim2.new(0, 4, 0, 4)

          frame2.Position = UDim2.new(
            p63 and 0 or 1, p63 and 0 or -4, p62 and 0 or 1, p62 and 0 or -4
          )

          frame2.BackgroundTransparency = 1
          frame2.ZIndex = 9999
          frame2.Parent = frame

          local frame3 = Instance.new("Frame")
          frame3.Size = UDim2.new(1, 0, 0, 1)
          frame3.Position = UDim2.new(0, 0, p62 and 0 or 1, p62 and 0 or -1)
          frame3.BorderSizePixel = 0
          frame3.ZIndex = 9999
          frame3.Parent = frame2

          table.insert(v153, frame3)

          local frame4 = Instance.new("Frame")
          frame4.Size = UDim2.new(0, 1, 1, 0)
          frame4.Position = UDim2.new(p63 and 0 or 1, p63 and 0 or -1, 0, 0)
          frame4.BorderSizePixel = 0
          frame4.ZIndex = 9999
          frame4.Parent = frame2

          table.insert(v153, frame4)
        end

        f23(0, 0, true, true)
        f23(1, 0, true, false)
        f23(0, 1, false, true)
        f23(1, 1, false, false)
      end

      if frame then
        frame.Rotation = frame.Rotation + 1.5
        local accent2 = typeof(v2) == "table" and v2.Accent or Color3.fromRGB(255, 105, 180)

        for index25, value36 in ipairs(v153) do
          value36.BackgroundColor3 = accent2
        end
      end

      local front = v154:FindFirstChild("Front")
      local icon = v154:FindFirstChild("Icon")

      if front and front.Position.X.Offset ~= 30 then
        front.Position = UDim2.new(0, 30, 0, 0)
        front.TextXAlignment = Enum.TextXAlignment.Left

        if front.Size.X.Offset == 0 then
          front.Size = UDim2.new(1, -30, 1, 0)
        end
      end

      if icon and icon.Visible then
        icon.Visible = false
      end
    end

    return
  end
end)
