local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local httpService = game:GetService("HttpService")
local virtualInputManager = game:GetService("VirtualInputManager")
local lighting = game:GetService("Lighting")
local collectionService = game:GetService("CollectionService")
getgenv().OverdoseUnloaded = false

local v1 = {
  font = nil,
  sin = 0,
  instances = {},
  notifications = {},
  popups = {},
  RegisteredKeybinds = {},
}

local currentCamera = workspace.CurrentCamera
local localPlayer = players.LocalPlayer
local v2 = {}

local v3 = {
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
  TargetMarkerStyle = "Corners",
  TargetColor = Color3.fromRGB(255, 50, 50),
  MarkerSize = 12,
  MarkerLength = 6,
  RotationSpeed = 3,
  ESPEnabled = false,
  ESPTeamCheck = false,
  DrawBoxes = false,
  DrawNames = true,
  DrawDistance = false,
  DrawHealthBar = false,
  DrawSkeletons = false,
  MaxDistance = 1500,
  ESPColor = Color3.fromRGB(255, 255, 255),
  Crosshair = false,
  CrosshairCenter = true,
  CrosshairRotate = false,
  CrosshairRotSpeed = 3,
  CrosshairLength = 10,
  CrosshairGap = 5,
  CrosshairThickness = 1,
  CrosshairColor1 = Color3.fromRGB(255, 255, 255),
  CrosshairColor2 = Color3.fromRGB(255, 255, 255),
  CrosshairColor3 = Color3.fromRGB(255, 255, 255),
  CrosshairColor4 = Color3.fromRGB(255, 255, 255),
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
  PanicMod = false,
  ColorEnemy = Color3.fromRGB(255, 50, 50),
  ColorFriendly = Color3.fromRGB(50, 255, 50),
  ColorWarning = Color3.fromRGB(255, 200, 50),
}

local v4 = { Galaxy = "rbxassetid://1084996976", Smoke = "rbxassetid://120733349948660" }
local v5 = { "Smoke", "Galaxy" }
local v6 = { "ForceField", "Neon" }

local v7 = {
  MainBg = Color3.fromRGB(26, 26, 26),
  SectionBg = Color3.fromRGB(22, 22, 22),
  ElementBg = Color3.fromRGB(38, 38, 38),
  BorderOuter = Color3.fromRGB(8, 8, 8),
  BorderInner = Color3.fromRGB(57, 57, 57),
  Accent = Color3.fromRGB(100, 100, 255),
  Text = Color3.fromRGB(170, 170, 170),
  TextDark = Color3.fromRGB(90, 90, 90),
}

local v8 = {
  Bg = {},
  Text = {},
  Image = {},
  Gradient = {},
}

local function f1(p1)
  table.insert(v8.Bg, p1)
  return p1
end

local function f2(p2)
  table.insert(v8.Text, p2)
  return p2
end

function v1:ChangeAccent(p3)
  v7.Accent = p3

  for key, value in pairs(v8.Bg) do
    if value and value.Parent then
      value.BackgroundColor3 = p3
    end
  end

  for key2, value2 in pairs(v8.Text) do
    if value2 and value2.Parent then
      value2.TextColor3 = p3
    end
  end

  for key3, value3 in pairs(v8.Image) do
    if value3 and value3.Parent then
      value3.ImageColor3 = p3
    end
  end

  for key4, value4 in pairs(v8.Gradient) do
    if value4 and value4.Parent then
      value4.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(0.5, p3),
        ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)),
      })
    end
  end

  if self.UpdateKeybindList then
    self:UpdateKeybindList()
  end
end

local function f3(p4)
  if not p4 then
    return "None"
  end

  return ({
    [Enum.KeyCode.LeftShift] = "LShift",
    [Enum.KeyCode.RightShift] = "RShift",
    [Enum.KeyCode.LeftControl] = "LCtrl",
    [Enum.KeyCode.RightControl] = "RCtrl",
    [Enum.KeyCode.LeftAlt] = "LAlt",
    [Enum.KeyCode.RightAlt] = "RAlt",
    [Enum.UserInputType.MouseButton1] = "MB1",
    [Enum.UserInputType.MouseButton2] = "MB2",
    [Enum.UserInputType.MouseButton3] = "MB3",
  })[p4] or p4.Name
end

local code = Enum.Font.Code

local function f4(parent)
  local uiStroke = Instance.new("UIStroke")
  uiStroke.Color = Color3.new(0, 0, 0)
  uiStroke.Thickness = 1
  uiStroke.Transparency = 0.5
  uiStroke.Parent = parent
end

local v9

local function f5(p5)
  if v9 then
    pcall(function() p5.FontFace = v9 end)
  else
    p5.Font = code
  end
end

local function f6(p6, p7)
  local instance = Instance.new(p6)

  for key5, value5 in pairs(p7) do
    instance[key5] = value5
  end

  table.insert(v1.instances, instance)
  return instance
end

local function f7(parent2, p8, p9, p10)
  local v10 = f6("ImageLabel", {
    Name = "GlowEffect",
    Image = "http://www.roblox.com/asset/?id=18245826428",
    ImageColor3 = p8 or v7.Accent,
    ImageTransparency = 0.85,
    BackgroundTransparency = 1,
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(21, 21, 79, 79),
    ZIndex = 0,
    BorderSizePixel = 0,
    Parent = parent2,
  })

  if p9 then
    v10.Position = UDim2.new(0, -20, 0, -20)
    v10.Size = UDim2.new(1, 40, 0, 42)
  else
    v10.Position = UDim2.new(0, -12, 0, -12)
    v10.Size = UDim2.new(1, 24, 1, 24)
  end

  if not p10 then
    table.insert(v8.Image, v10)
  end

  return v10
end

local function f8(p11, p12)
  local inputBegan = p11.InputBegan
  local v11, position, position2

  inputBegan:Connect(function(p13)
    if p13.UserInputType == Enum.UserInputType.MouseButton1 then
      v11 = true
      position = p13.Position
      position2 = p12.Position

      p13.Changed:Connect(function()
        if p13.UserInputState == Enum.UserInputState.End then
          v11 = false
        end
      end)
    end
  end)

  local v12

  p11.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
      v12 = input
    end
  end)

  userInputService.InputChanged:Connect(function(input2)
    if input2 == v12 and v11 then
      local v13 = input2.Position - position

      p12.Position = UDim2.new(
        position2.X.Scale, position2.X.Offset + v13.X, position2.Y.Scale,
        position2.Y.Offset + v13.Y
      )
    end
  end)
end

local v14 = f6("ScreenGui", {
  Name = "OverdoseUI",
  ResetOnSpawn = false,
  DisplayOrder = 99999,
  ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
})

pcall(function()
  if gethui then
    v14.Parent = gethui()
  elseif syn and syn.protect_gui then
    syn.protect_gui(v14)
    v14.Parent = coreGui
  else
    v14.Parent = coreGui
  end
end)

if not v14.Parent then
  v14.Parent = players.LocalPlayer:WaitForChild("PlayerGui")
end

v2.SinRender = runService.RenderStepped:Connect(function()
  v1.sin = math.abs(math.sin(tick() * 1.5))
end)

getgenv().ToggleUIKey = Enum.KeyCode.Home

v2.UI = userInputService.InputBegan:Connect(function(input3, p14)
  if getgenv().OverdoseUnloaded then
    return
  end

  if not p14 and input3.KeyCode == getgenv().ToggleUIKey then
    if getgenv().MainGuiFrame then
      getgenv().MainGuiFrame.Visible = not getgenv().MainGuiFrame.Visible
    end
  end
end)

local v15 = f6("Frame", {
  Parent = v14,
  Position = UDim2.new(0, 20, 0, 60),
  Size = UDim2.new(0, 180, 0, 24),
  BackgroundColor3 = v7.BorderOuter,
  BorderSizePixel = 0,
  Active = true,
  Visible = false,
})

f8(v15, v15)

local parent3 = f6("Frame", {
  Parent = f6("Frame", {
    Parent = v15,
    Position = UDim2.new(0, 1, 0, 1),
    Size = UDim2.new(1, -2, 1, -2),
    BackgroundColor3 = v7.MainBg,
    BorderSizePixel = 0,
  }),
  Position = UDim2.new(0, 1, 0, 1),
  Size = UDim2.new(1, -2, 1, -2),
  BackgroundColor3 = v7.MainBg,
  BorderColor3 = v7.BorderInner,
  BorderSizePixel = 1,
})

f7(f1(f6("Frame", {
  Parent = parent3,
  Size = UDim2.new(1, 0, 0, 2),
  BackgroundColor3 = v7.Accent,
  BorderSizePixel = 0,
  ZIndex = 3,
})), v7.Accent, true)

local v16 = f6("TextLabel", {
  Parent = parent3,
  Size = UDim2.new(1, 0, 0, 20),
  Position = UDim2.new(0, 0, 0, 2),
  BackgroundTransparency = 1,
  Text = "keybinds",
  TextColor3 = v7.Text,
  TextSize = 12,
  TextXAlignment = Enum.TextXAlignment.Center,
  ZIndex = 4,
})

f5(v16)
f4(v16)

local v17 = f6("Frame", {
  Parent = parent3,
  Position = UDim2.new(0, 0, 0, 24),
  Size = UDim2.new(1, 0, 1, -24),
  BackgroundTransparency = 1,
})

f6("UIListLayout", {
  Parent = v17,
  Padding = UDim.new(0, 2),
  HorizontalAlignment = Enum.HorizontalAlignment.Center,
})

f6("UIPadding", {
  Parent = v17,
  PaddingTop = UDim.new(0, 4),
  PaddingBottom = UDim.new(0, 6),
  PaddingLeft = UDim.new(0, 8),
  PaddingRight = UDim.new(0, 8),
})

function v1:UpdateKeybindList()
  for index, value6 in ipairs(v17:GetChildren()) do
    if value6:IsA("Frame") then
      value6:Destroy()
    end
  end

  local count = 0
  local text

  for key6, value7 in pairs(self.RegisteredKeybinds) do
    if value7.key and not value7.hide then
      count = count + 1

      local parent4 = f6("Frame", {
        Parent = v17,
        Size = UDim2.new(1, 0, 0, 14),
        BackgroundTransparency = 1,
      })

      local v18 = f6("TextLabel", {
        Parent = parent4,
        Size = UDim2.new(0.5, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = key6,
        TextColor3 = v7.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
      })

      f5(v18)
      f4(v18)
      local textDark = v7.TextDark

      if value7.mode == "always" then
        text = "[always]"
        textDark = v7.Accent
      elseif value7.state then
        text = value7.mode == "hold" and "[hold]" or "[toggled]"
        textDark = v7.Accent
      else
        text = "[none]"
      end

      local v19 = f6("TextLabel", {
        Parent = parent4,
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = textDark,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Right,
      })

      f5(v19)
      f4(v19)

      if textDark == v7.Accent then
        f2(v19)
      end
    end
  end

  v15.Size = UDim2.new(0, 180, 0, 24 + (count > 0 and count * 14 + (count - 1) * 2 + 10 or 0))
end

function v1:SetKeybindsVisible(visible)
  v15.Visible = visible
end

local v20 = f6("Frame", {
  Parent = v14,
  Position = UDim2.new(0, 20, 0, 300),
  Size = UDim2.new(0, 220, 0, 24),
  BackgroundColor3 = v7.BorderOuter,
  BorderSizePixel = 0,
  Active = true,
  Visible = false,
})

f8(v20, v20)

local parent5 = f6("Frame", {
  Parent = f6("Frame", {
    Parent = v20,
    Position = UDim2.new(0, 1, 0, 1),
    Size = UDim2.new(1, -2, 1, -2),
    BackgroundColor3 = v7.MainBg,
    BorderSizePixel = 0,
  }),
  Position = UDim2.new(0, 1, 0, 1),
  Size = UDim2.new(1, -2, 1, -2),
  BackgroundColor3 = v7.MainBg,
  BorderColor3 = v7.BorderInner,
  BorderSizePixel = 1,
})

f7(f1(f6("Frame", {
  Parent = parent5,
  Size = UDim2.new(1, 0, 0, 2),
  BackgroundColor3 = v7.Accent,
  BorderSizePixel = 0,
  ZIndex = 3,
})), v7.Accent, true)

local v21 = f6("TextLabel", {
  Parent = parent5,
  Size = UDim2.new(1, 0, 0, 20),
  Position = UDim2.new(0, 0, 0, 2),
  BackgroundTransparency = 1,
  Text = "CI Hack",
  TextColor3 = v7.Text,
  TextSize = 12,
  TextXAlignment = Enum.TextXAlignment.Center,
  ZIndex = 4,
})

f5(v21)
f4(v21)

local v22 = f6("Frame", {
  Parent = parent5,
  Position = UDim2.new(0, 0, 0, 24),
  Size = UDim2.new(1, 0, 1, -24),
  BackgroundTransparency = 1,
})

f6("UIListLayout", {
  Parent = v22,
  Padding = UDim.new(0, 2),
  HorizontalAlignment = Enum.HorizontalAlignment.Center,
})

f6("UIPadding", {
  Parent = v22,
  PaddingTop = UDim.new(0, 4),
  PaddingBottom = UDim.new(0, 6),
  PaddingLeft = UDim.new(0, 8),
  PaddingRight = UDim.new(0, 8),
})

function v1:SetCIHacksVisible(visible2)
  v20.Visible = visible2
end

local v23 = f6("Frame", {
  Parent = v14,
  Position = UDim2.new(0, 20, 0, 20),
  Size = UDim2.new(0, 200, 0, 24),
  BackgroundColor3 = v7.BorderOuter,
  BorderSizePixel = 0,
  Active = true,
})

f8(v23, v23)

local parent6 = f6("Frame", {
  Parent = f6("Frame", {
    Parent = v23,
    Position = UDim2.new(0, 1, 0, 1),
    Size = UDim2.new(1, -2, 1, -2),
    BackgroundColor3 = v7.MainBg,
    BorderSizePixel = 0,
  }),
  Position = UDim2.new(0, 1, 0, 1),
  Size = UDim2.new(1, -2, 1, -2),
  BackgroundColor3 = v7.MainBg,
  BorderColor3 = v7.BorderInner,
  BorderSizePixel = 1,
})

f7(f1(f6("Frame", {
  Parent = parent6,
  Size = UDim2.new(1, 0, 0, 2),
  BackgroundColor3 = v7.Accent,
  BorderSizePixel = 0,
  ZIndex = 3,
})), v7.Accent, true)

local v24 = f6("TextLabel", {
  Parent = parent6,
  Size = UDim2.new(1, 0, 1, 0),
  Position = UDim2.new(0, 8, 0, 0),
  BackgroundTransparency = 1,
  Text = "Overdose.gg | FPS: 0",
  TextColor3 = v7.Text,
  TextSize = 12,
  TextXAlignment = Enum.TextXAlignment.Left,
  ZIndex = 4,
})

f5(v24)
f4(v24)

local v25 = f6("UIGradient", {
  Parent = v24,
  Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
    ColorSequenceKeypoint.new(0.5, v7.Accent),
    ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)),
  }),
})

table.insert(v8.Gradient, v25)
local v26 = tick()
local v27 = 0
local v28 = v26

v2.Watermark = runService.RenderStepped:Connect(function()
  if getgenv().OverdoseUnloaded then
    return
  end

  v27 = v27 + 1

  if tick() - v28 >= 1 then
    v24.Text = string.format("Overdose.gg | FPS: %d", v27)
    v23.Size = UDim2.new(0, v24.TextBounds.X + 16, 0, 24)
    v27 = 0
    v28 = tick()
  end

  v25.Offset = Vector2.new(math.sin(tick() * 2), 0)
end)

local v29 = {}

local function f9(p15)
  for index2, value8 in ipairs(v29) do
    if value8 ~= p15 and value8.Visible then
      value8.Visible = false
    end
  end
end

function v1:CreateWindow(text2)
  local v30 = {}

  local v31 = f6("Frame", {
    Parent = v14,
    Size = UDim2.new(0, 700, 0, 480),
    Position = UDim2.new(0.5, -350, 0.5, -240),
    BackgroundColor3 = v7.BorderOuter,
    BorderSizePixel = 0,
    ZIndex = 2,
    Active = true,
  })

  getgenv().MainGuiFrame = v31

  local parent7 = f6("Frame", {
    Parent = f6("Frame", {
      Parent = v31,
      Position = UDim2.new(0, 1, 0, 1),
      Size = UDim2.new(1, -2, 1, -2),
      BackgroundColor3 = v7.MainBg,
      BorderSizePixel = 0,
    }),
    Position = UDim2.new(0, 1, 0, 1),
    Size = UDim2.new(1, -2, 1, -2),
    BackgroundColor3 = v7.MainBg,
    BorderColor3 = v7.BorderInner,
    BorderSizePixel = 1,
  })

  f7(f1(f6("Frame", {
    Parent = parent7,
    Size = UDim2.new(1, 0, 0, 2),
    BackgroundColor3 = v7.Accent,
    BorderSizePixel = 0,
    ZIndex = 3,
  })), v7.Accent, true)

  local v32 = f6("Frame", {
    Parent = parent7,
    Size = UDim2.new(1, 0, 0, 25),
    BackgroundTransparency = 1,
    ZIndex = 5,
  })

  f8(v32, v31)

  local v33 = f6("TextLabel", {
    Parent = v32,
    Size = UDim2.new(1, -10, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1,
    Text = text2,
    TextColor3 = v7.Text,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
  })

  f5(v33)
  f4(v33)

  local v34 = f6("Frame", {
    Parent = parent7,
    Size = UDim2.new(1, -32, 0, 30),
    Position = UDim2.new(0, 16, 0, 4),
    BackgroundTransparency = 1,
  })

  f6("UIListLayout", {
    Parent = v34,
    FillDirection = Enum.FillDirection.Horizontal,
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder,
  })

  local v35 = f6("Frame", {
    Parent = f6("Frame", {
      Parent = parent7,
      Position = UDim2.new(0, 15, 0, 33),
      Size = UDim2.new(1, -30, 1, -48),
      BackgroundColor3 = Color3.fromRGB(19, 19, 19),
      BorderSizePixel = 0,
    }),
    Position = UDim2.new(0, 2, 0, 2),
    Size = UDim2.new(1, -4, 1, -4),
    BackgroundColor3 = v7.SectionBg,
    BorderColor3 = Color3.fromRGB(56, 56, 56),
    BorderSizePixel = 1,
    ClipsDescendants = true,
  })

  local v36 = true

  function v30:CreateTab(text3)
    local v37 = {}

    local v38 = f6("TextButton", {
      Parent = v34,
      Size = UDim2.new(0, 0, 0, 22),
      AutomaticSize = Enum.AutomaticSize.X,
      BackgroundTransparency = 1,
      Text = text3,
      TextColor3 = v36 and v7.Text or v7.TextDark,
      TextSize = 12,
    })

    f6("UIPadding", {
      Parent = v38,
      PaddingLeft = UDim.new(0, 16),
      PaddingRight = UDim.new(0, 16),
    })

    f5(v38)
    f4(v38)

    local v39 = f6("Frame", {
      Parent = v38,
      Position = UDim2.new(0, 0, 1, 0),
      Size = UDim2.new(1, 0, 0, 2),
      BackgroundColor3 = v36 and v7.Accent or v7.BorderInner,
      BorderSizePixel = 0,
    })

    if v36 then
      f1(v39)
      f2(v38)
    end

    local v40 = f6("Frame", {
      Parent = v35,
      Size = UDim2.new(1, -12, 1, -12),
      Position = UDim2.new(0, 6, 0, 6),
      BackgroundTransparency = 1,
      Visible = v36,
      ClipsDescendants = true,
    })

    local v41 = f6("ScrollingFrame", {
      Parent = v40,
      Size = UDim2.new(0.5, -4, 1, 0),
      Position = UDim2.new(0, 0, 0, 0),
      BackgroundTransparency = 1,
      ScrollBarThickness = 0,
      AutomaticCanvasSize = Enum.AutomaticSize.Y,
      CanvasSize = UDim2.new(0, 0, 0, 0),
      ClipsDescendants = true,
    })

    f6("UIListLayout", { Parent = v41, Padding = UDim.new(0, 6) })

    local v42 = f6("ScrollingFrame", {
      Parent = v40,
      Size = UDim2.new(0.5, -4, 1, 0),
      Position = UDim2.new(0.5, 4, 0, 0),
      BackgroundTransparency = 1,
      ScrollBarThickness = 0,
      AutomaticCanvasSize = Enum.AutomaticSize.Y,
      CanvasSize = UDim2.new(0, 0, 0, 0),
      ClipsDescendants = true,
    })

    f6("UIListLayout", { Parent = v42, Padding = UDim.new(0, 6) })

    v38.MouseButton1Click:Connect(function()
      for key7, value9 in pairs(v35:GetChildren()) do
        if value9:IsA("Frame") then
          value9.Visible = false
        end
      end

      for key8, value10 in pairs(v34:GetChildren()) do
        if value10:IsA("TextButton") then
          value10.TextColor3 = v7.TextDark
          value10:FindFirstChildOfClass("Frame").BackgroundColor3 = v7.BorderInner
        end
      end

      v40.Visible = true
      v38.TextColor3 = v7.Text
      v39.BackgroundColor3 = v7.Accent
      f9()
    end)

    v36 = false

    function v37:CreateSection(text4, p16)
      local v43 = {}

      local parent8 = f6("Frame", {
        Parent = f6("Frame", {
          Parent = p16:lower() == "left" and v41 or v42,
          Size = UDim2.new(1, 0, 0, 0),
          BackgroundTransparency = 1,
          AutomaticSize = Enum.AutomaticSize.Y,
        }),
        Position = UDim2.new(0, 0, 0, 4),
        Size = UDim2.new(1, 0, 1, -4),
        BackgroundColor3 = v7.BorderOuter,
        BorderSizePixel = 0,
      })

      local udim = UDim2.new(0, 2, 0, 2)
      local udim2 = UDim2.new(1, -4, 1, -4)
      local color = Color3.fromRGB(56, 56, 56)

      local parent9 = f6("Frame", {
        Parent = parent8,
        Position = udim,
        Size = udim2,
        BackgroundColor3 = v7.SectionBg,
        BorderColor3 = color,
        BorderSizePixel = 1,
      })

      local v44 = f6("TextLabel", {
        Parent = parent8,
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 8, 0, 0),
        BackgroundTransparency = 1,
        Text = text4,
        TextColor3 = v7.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2,
      })

      f5(v44)
      f4(v44)

      local parent10 = f6("Frame", {
        Parent = parent9,
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 16),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
      })

      f6("UIListLayout", { Parent = parent10, Padding = UDim.new(0, 2) })

      f6("UIPadding", {
        Parent = parent10,
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8),
        PaddingTop = UDim.new(0, 2),
        PaddingBottom = UDim.new(0, 8),
      })

      function v43:CreateToggle(text5, p17, p18)
        local v45 = p17 or false

        local v46 = f6("TextButton", {
          Parent = parent10,
          Size = UDim2.new(1, 0, 0, 12),
          BackgroundTransparency = 1,
          Text = "",
          AutoButtonColor = false,
        })

        local v47 = f6("Frame", {
          Parent = v46,
          Size = UDim2.new(0, 10, 0, 10),
          Position = UDim2.new(0, 0, 0, 1),
          BackgroundColor3 = v7.BorderOuter,
          BorderSizePixel = 0,
        })

        local udim3 = UDim2.new(1, -4, 1, -4)
        local udim4 = UDim2.new(0, 2, 0, 2)
        local color2 = Color3.fromRGB(56, 56, 56)

        local v48 = f1(f6("Frame", {
          Parent = f6("Frame", {
            Parent = v47,
            Size = udim3,
            Position = udim4,
            BackgroundColor3 = v7.SectionBg,
            BorderColor3 = color2,
            BorderSizePixel = 1,
          }),
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundColor3 = v7.Accent,
          BorderSizePixel = 0,
          Visible = v45,
        }))

        local v49 = f7(v47, v7.Accent)
        v49.Visible = v45

        local v50 = f6("TextLabel", {
          Parent = v46,
          Size = UDim2.new(1, -16, 1, 0),
          Position = UDim2.new(0, 16, 0, 0),
          BackgroundTransparency = 1,
          Text = text5,
          TextColor3 = v7.Text,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
          RichText = true,
        })

        f5(v50)
        f4(v50)

        v46.MouseButton1Click:Connect(function()
          v45 = not v45
          v48.Visible = v45
          v49.Visible = v45

          if p18 then
            p18(v45)
          end
        end)

        return v46
      end

      function v43:CreateButton(text6, p19)
        local v51 = f6("TextButton", {
          Parent = f6("Frame", {
            Parent = parent10,
            Size = UDim2.new(1, 0, 0, 18),
            BackgroundColor3 = v7.BorderOuter,
            BorderSizePixel = 0,
          }),
          TextColor3 = v7.Text,
          Text = text6,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = v7.ElementBg,
          BorderColor3 = Color3.fromRGB(56, 56, 56),
          TextSize = 12,
        })

        f5(v51)
        f4(v51)

        v51.MouseButton1Click:Connect(function()
          if p19 then
            p19()
          end
        end)
      end

      function v43:CreateKeybind(p20, p21, p22, p23, p24)
        local v52 = p22
        v52 = p22 or "toggle"

        local keyCode = p21
        local v53 = v52
        local v54 = false
        local v55 = false

        if not p23 then
          v1.RegisteredKeybinds[p20] = { key = keyCode, state = v55, mode = v53 }
          v1:UpdateKeybindList()
        end

        local parent11 = f6("Frame", {
          Parent = parent10,
          Size = UDim2.new(1, 0, 0, 12),
          BackgroundTransparency = 1,
        })

        local v56 = f6("TextLabel", {
          Parent = parent11,
          Size = UDim2.new(1, -50, 1, 0),
          BackgroundTransparency = 1,
          Text = p20,
          TextColor3 = v7.Text,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f5(v56)
        f4(v56)

        local v57 = f6("TextButton", {
          Parent = parent11,
          Position = UDim2.new(1, -60, 0, 0),
          Size = UDim2.new(0, 60, 1, 0),
          BackgroundTransparency = 1,
          Text = "[" .. f3(keyCode) .. "]",
          TextColor3 = v7.TextDark,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Right,
        })

        f5(v57)
        f4(v57)

        local v58 = f6("Frame", {
          Parent = v14,
          BackgroundColor3 = v7.BorderOuter,
          BorderSizePixel = 0,
          ZIndex = 100,
          Visible = false,
        })

        local parent12 = f6("Frame", {
          Parent = v58,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = v7.ElementBg,
          BorderColor3 = Color3.fromRGB(56, 56, 56),
          BorderSizePixel = 1,
        })

        f6("UIListLayout", { Parent = parent12, Padding = UDim.new(0, 2) })

        f6("UIPadding", {
          Parent = parent12,
          PaddingBottom = UDim.new(0, 4),
          PaddingTop = UDim.new(0, 2),
        })

        table.insert(v29, v58)
        local v59 = 6

        for index3, value11 in ipairs({ "toggle", "hold", "always" }) do
          local v60 = value11

          local v61 = f6("TextButton", {
            Parent = parent12,
            Size = UDim2.new(1, -4, 0, 14),
            Position = UDim2.new(0, 2, 0, 0),
            Text = v60,
            TextColor3 = v7.Text,
            BackgroundTransparency = 1,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
          })

          f6("UIPadding", { Parent = v61, PaddingLeft = UDim.new(0, 5) })
          f5(v61)
          f4(v61)
          v59 = v59 + 16

          v61.MouseButton1Click:Connect(function()
            v53 = v60
            v58.Visible = false

            if v53 == "always" then
              v55 = true

              if p24 then
                p24(v55, keyCode)
              end
            end

            if not p23 then
              v1.RegisteredKeybinds[p20].mode = v53
              v1.RegisteredKeybinds[p20].state = v55
              v1:UpdateKeybindList()
            end
          end)
        end

        v58.Size = UDim2.new(0, 60, 0, v59)

        v57.MouseButton1Click:Connect(function()
          v54 = true
          v57.Text = "[...]"
        end)

        v57.MouseButton2Click:Connect(function()
          f9(v58)
          v58.Visible = not v58.Visible

          if v58.Visible then
            v58.Position = UDim2.new(0, v57.AbsolutePosition.X, 0, v57.AbsolutePosition.Y + 16)
          end
        end)

        userInputService.InputBegan:Connect(function(input4, p25)
          if v54 then
            if input4.UserInputType == Enum.UserInputType.Keyboard
              and input4.KeyCode ~= Enum.KeyCode.Unknown then
              keyCode = input4.KeyCode
              v57.Text = "[" .. f3(keyCode) .. "]"
              v54 = false
            elseif input4.UserInputType == Enum.UserInputType.MouseButton1
              or input4.UserInputType == Enum.UserInputType.MouseButton2
              or input4.UserInputType == Enum.UserInputType.MouseButton3 then
              keyCode = input4.UserInputType
              v57.Text = "[" .. f3(keyCode) .. "]"
              v54 = false
            end

            if input4.KeyCode == Enum.KeyCode.Escape then
              keyCode = nil
              v57.Text = "[None]"
              v54 = false
            end

            if not p23 then
              v1.RegisteredKeybinds[p20].key = keyCode
              v1:UpdateKeybindList()
            end

            if p23 and p24 then
              p24(v55, keyCode)
            end
          elseif keyCode and not p25 then
            if input4.KeyCode == keyCode or input4.UserInputType == keyCode then
              if v53 == "toggle" then
                v55 = not v55

                if p24 then
                  p24(v55, keyCode)
                end
              elseif v53 == "hold" then
                v55 = true

                if p24 then
                  p24(v55, keyCode)
                end
              end

              if not p23 then
                v1.RegisteredKeybinds[p20].state = v55
                v1:UpdateKeybindList()
              end
            end
          end
        end)

        userInputService.InputEnded:Connect(function(input5, p26)
          if keyCode and not p26 and not v54
            and (input5.KeyCode == keyCode or input5.UserInputType == keyCode) and v53 == "hold" then
            v55 = false

            if p24 then
              p24(v55, keyCode)
            end

            if not p23 then
              v1.RegisteredKeybinds[p20].state = v55
              v1:UpdateKeybindList()
            end
          end
        end)
      end

      function v43:CreateSlider(text7, p27, p28, p29, p30, p31)
        local v62 = p30
        local v63 = p29 or p27
        local v64 = p28 % 1 == 0 and p27 % 1 == 0 and 1 or 0.1
        v62 = v62 or ""

        local parent13 = f6("Frame", {
          Parent = parent10,
          Size = UDim2.new(1, 0, 0, 26),
          BackgroundTransparency = 1,
        })

        local v65 = f6("TextLabel", {
          Parent = parent13,
          Size = UDim2.new(1, 0, 0, 12),
          BackgroundTransparency = 1,
          Text = text7,
          TextColor3 = v7.Text,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f5(v65)
        f4(v65)

        local v66 = f6("TextButton", {
          Parent = parent13,
          Position = UDim2.new(0, 0, 0, 14),
          Size = UDim2.new(0, 12, 0, 12),
          BackgroundTransparency = 1,
          Text = "-",
          TextColor3 = v7.Text,
          TextSize = 12,
        })

        local v67 = f6("TextButton", {
          Parent = parent13,
          Position = UDim2.new(1, -12, 0, 14),
          Size = UDim2.new(0, 12, 0, 12),
          BackgroundTransparency = 1,
          Text = "+",
          TextColor3 = v7.Text,
          TextSize = 12,
        })

        f5(v66)
        f4(v66)
        f5(v67)
        f4(v67)

        local v68 = f6("TextButton", {
          Parent = parent13,
          Position = UDim2.new(0, 16, 0, 16),
          Size = UDim2.new(1, -32, 0, 8),
          BackgroundColor3 = v7.BorderOuter,
          BorderSizePixel = 0,
          Text = "",
          AutoButtonColor = false,
        })

        local v69 = f6("Frame", {
          Parent = v68,
          Size = UDim2.new((v63 - p27) / (p28 - p27), 0, 1, 0),
          BackgroundColor3 = Color3.fromRGB(19, 19, 19),
          BorderSizePixel = 0,
          ZIndex = 2,
        })

        f1(f6("Frame", {
          Parent = v69,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, 0, 1, -4),
          BackgroundColor3 = v7.Accent,
          BorderSizePixel = 0,
        }))

        local v70 = v64 == 1

        local v71 = v70
        v71 = v70 and tostring(math.floor(v63 + 0.5))

        local v72 = v71
        v72 = v71 or string.format("%.1f", v63)

        local v73 = f6("TextLabel", {
          Parent = v69,
          FontFace = v9,
          TextColor3 = v7.Text,
          Text = v72 .. v62,
          TextStrokeTransparency = 0.5,
          BackgroundTransparency = 1,
          Position = UDim2.new(1, 0, 0, 1),
          Size = UDim2.new(0, 1, 0, 11),
          TextSize = 12,
        })

        f5(v73)
        f4(v73)
        f7(v69, v7.Accent)

        local function f10(p32)
          v63 = math.clamp(p32, p27, p28)

          if v64 == 1 then
            v63 = math.floor(v63 + 0.5)
          else
            v63 = math.floor(v63 * 10 + 0.5) / 10
          end

          v69.Size = UDim2.new((v63 - p27) / (p28 - p27), 0, 1, 0)
          v73.Text = (v64 == 1 and tostring(v63) or string.format("%.1f", v63)) .. v62

          if p31 then
            p31(v63)
          end
        end

        v66.MouseButton1Click:Connect(function() f10(v63 - v64) end)
        v67.MouseButton1Click:Connect(function() f10(v63 + v64) end)
        local v74 = false
        v68.MouseButton1Down:Connect(function() v74 = true end)

        userInputService.InputEnded:Connect(function(input6)
          if input6.UserInputType == Enum.UserInputType.MouseButton1 then
            v74 = false
          end
        end)

        userInputService.InputChanged:Connect(function(input7)
          if v74 and input7.UserInputType == Enum.UserInputType.MouseMovement then
            f10(p27 + (p28 - p27) * math.clamp(
              (input7.Position.X - v68.AbsolutePosition.X) / v68.AbsoluteSize.X, 0, 1
            ))
          end
        end)
      end

      function v43:CreateColorPicker(text8, p33, p34)
        local color3 = p33 or Color3.new(1, 1, 1)
        local v75, v76, v77 = color3:ToHSV()
        local v78 = v76
        local v79 = v77

        local parent14 = f6("Frame", {
          Parent = parent10,
          Size = UDim2.new(1, 0, 0, 16),
          BackgroundTransparency = 1,
        })

        local v80 = f6("TextLabel", {
          Parent = parent14,
          Size = UDim2.new(1, -26, 1, 0),
          BackgroundTransparency = 1,
          Text = text8,
          TextColor3 = v7.Text,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f5(v80)
        f4(v80)

        local v81 = f6("TextButton", {
          Parent = parent14,
          Position = UDim2.new(1, -16, 0, 2),
          Size = UDim2.new(0, 16, 0, 10),
          BackgroundColor3 = v7.BorderOuter,
          BorderSizePixel = 0,
          AutoButtonColor = false,
          Text = "",
        })

        local v82 = f6("Frame", {
          Parent = v81,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = color3,
          BorderColor3 = Color3.fromRGB(56, 56, 56),
          BorderSizePixel = 1,
        })

        local v83 = f7(v81, color3, false, true)

        local v84 = f6("Frame", {
          Parent = v14,
          Size = UDim2.new(0, 142, 0, 146),
          BackgroundColor3 = v7.BorderOuter,
          BorderSizePixel = 0,
          ZIndex = 100,
          Visible = false,
        })

        local parent15 = f6("Frame", {
          Parent = v84,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = v7.ElementBg,
          BorderColor3 = Color3.fromRGB(56, 56, 56),
          BorderSizePixel = 1,
        })

        table.insert(v29, v84)

        local v85 = f6("TextButton", {
          Parent = parent15,
          Position = UDim2.new(0, 4, 0, 4),
          Size = UDim2.new(1, -24, 1, -24),
          BackgroundColor3 = v7.BorderOuter,
          BorderSizePixel = 0,
          Text = "",
          AutoButtonColor = false,
        })

        local v86 = f6("Frame", {
          Parent = v85,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = Color3.fromHSV(v75, 1, 1),
          BorderSizePixel = 0,
        })

        local parent16 = f6("Frame", {
          Parent = v86,
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundColor3 = Color3.new(1, 1, 1),
          BorderSizePixel = 0,
          ZIndex = 2,
        })

        f6("UIGradient", {
          Parent = parent16,
          Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1),
          }),
        })

        local parent17 = f6("Frame", {
          Parent = parent16,
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundColor3 = Color3.new(1, 1, 1),
          BorderSizePixel = 0,
        })

        f6("UIGradient", {
          Parent = parent17,
          Rotation = 90,
          Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
            ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0)),
          }),
          Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0),
          }),
        })

        local v87 = f6("Frame", {
          Parent = parent17,
          Size = UDim2.new(0, 2, 0, 2),
          BackgroundColor3 = Color3.new(1, 1, 1),
          BorderColor3 = Color3.new(0, 0, 0),
          BorderSizePixel = 1,
          AnchorPoint = Vector2.new(0.5, 0.5),
        })

        local v88 = f6("TextButton", {
          Parent = parent15,
          Position = UDim2.new(1, -16, 0, 4),
          Size = UDim2.new(0, 12, 1, -24),
          BackgroundColor3 = v7.BorderOuter,
          BorderSizePixel = 0,
          Text = "",
          AutoButtonColor = false,
        })

        local v89 = f6("Frame", {
          Parent = v88,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BorderSizePixel = 0,
          BackgroundColor3 = Color3.new(1, 1, 1),
        })

        f6("UIGradient", {
          Parent = v89,
          Rotation = 90,
          Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 0, 255)),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
          }),
        })

        local v90 = f6("Frame", {
          Parent = v89,
          Size = UDim2.new(1, 0, 0, 2),
          BackgroundColor3 = Color3.new(1, 1, 1),
          BorderColor3 = Color3.new(0, 0, 0),
          BorderSizePixel = 1,
          AnchorPoint = Vector2.new(0, 0.5),
        })

        local function f11(p35)
          color3 = Color3.fromHSV(v75, v78, v79)
          v82.BackgroundColor3 = color3
          v83.ImageColor3 = color3
          v86.BackgroundColor3 = Color3.fromHSV(v75, 1, 1)

          if p35 then
            v87.Position = UDim2.new(v78, 0, 1 - v79, 0)
            v90.Position = UDim2.new(0, 0, 1 - v75, 0)
          end

          if p34 then
            p34(color3)
          end
        end

        f11(true)

        local v91 = false
        local v92 = false
        v85.MouseButton1Down:Connect(function() v91 = true end)
        v88.MouseButton1Down:Connect(function() v92 = true end)

        userInputService.InputEnded:Connect(function(input8)
          if input8.UserInputType == Enum.UserInputType.MouseButton1 then
            v91 = false
            v92 = false
          end
        end)

        userInputService.InputChanged:Connect(function(input9)
          if v91 and input9.UserInputType == Enum.UserInputType.MouseMovement then
            v78 = math.clamp(
              (input9.Position.X - v86.AbsolutePosition.X) / v86.AbsoluteSize.X, 0, 1
            )

            v79 = 1 - math.clamp(
              (input9.Position.Y - v86.AbsolutePosition.Y) / v86.AbsoluteSize.Y, 0, 1
            )

            f11(true)
          elseif v92 and input9.UserInputType == Enum.UserInputType.MouseMovement then
            v75 = 1 - math.clamp(
              (input9.Position.Y - v89.AbsolutePosition.Y) / v89.AbsoluteSize.Y, 0, 1
            )

            f11(true)
          end
        end)

        v81.MouseButton1Click:Connect(function()
          f9(v84)
          v84.Visible = not v84.Visible

          if v84.Visible then
            v84.Position = UDim2.new(
              0, v81.AbsolutePosition.X - 126, 0, v81.AbsolutePosition.Y + 16
            )
          end
        end)
      end

      function v43.CreateTextbox(p36, text9, placeholderText, p37)
        local parent18 = f6("Frame", {
          Parent = parent10,
          Size = UDim2.new(1, 0, 0, 32),
          BackgroundTransparency = 1,
        })

        local v93 = f6("TextLabel", {
          Parent = parent18,
          Size = UDim2.new(1, 0, 0, 12),
          BackgroundTransparency = 1,
          Text = text9,
          TextColor3 = v7.Text,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f5(v93)
        f4(v93)

        local v94 = f6("TextBox", {
          Parent = f6("Frame", {
            Parent = parent18,
            Position = UDim2.new(0, 0, 0, 15),
            Size = UDim2.new(1, 0, 0, 16),
            BackgroundColor3 = v7.BorderOuter,
            BorderSizePixel = 0,
          }),
          TextColor3 = v7.Text,
          Text = "",
          PlaceholderText = placeholderText,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = v7.ElementBg,
          BorderColor3 = Color3.fromRGB(56, 56, 56),
          TextSize = 12,
          ClearTextOnFocus = false,
        })

        f5(v94)
        f4(v94)

        v94.FocusLost:Connect(function()
          if p37 then
            p37(v94.Text)
          end
        end)
      end

      function v43:CreateDropdown(text10, p38, p39, p40)
        local v95 = p39 or p38[1]

        local parent19 = f6("Frame", {
          Parent = parent10,
          Size = UDim2.new(1, 0, 0, 32),
          BackgroundTransparency = 1,
        })

        local v96 = f6("TextLabel", {
          Parent = parent19,
          Size = UDim2.new(1, 0, 0, 12),
          BackgroundTransparency = 1,
          Text = text10,
          TextColor3 = v7.Text,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f5(v96)
        f4(v96)

        local v97 = f6("Frame", {
          Parent = parent19,
          Position = UDim2.new(0, 0, 0, 15),
          Size = UDim2.new(1, 0, 0, 16),
          BackgroundColor3 = v7.BorderOuter,
          BorderSizePixel = 0,
        })

        local v98 = f6("TextButton", {
          Parent = v97,
          TextColor3 = v7.Text,
          Text = v95,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = v7.ElementBg,
          BorderColor3 = Color3.fromRGB(56, 56, 56),
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f6("UIPadding", { Parent = v98, PaddingLeft = UDim.new(0, 5) })
        f5(v98)
        f4(v98)

        local v99 = f6("TextLabel", {
          Parent = v98,
          Text = "+",
          TextColor3 = v7.Text,
          Size = UDim2.new(0, 10, 1, 0),
          Position = UDim2.new(1, -15, 0, -1),
          BackgroundTransparency = 1,
          TextSize = 12,
        })

        f5(v99)
        f4(v99)

        local v100 = f6("Frame", {
          Parent = v14,
          BackgroundColor3 = v7.BorderOuter,
          BorderSizePixel = 0,
          ZIndex = 100,
          Visible = false,
        })

        local v101 = f6("Frame", {
          Parent = v100,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = v7.ElementBg,
          BorderColor3 = Color3.fromRGB(56, 56, 56),
          BorderSizePixel = 1,
        })

        f6("UIListLayout", { Parent = v101, Padding = UDim.new(0, 2) })

        f6("UIPadding", {
          Parent = v101,
          PaddingBottom = UDim.new(0, 4),
          PaddingTop = UDim.new(0, 2),
        })

        table.insert(v29, v100)

        local function f12()
          for index4, value12 in ipairs(v101:GetChildren()) do
            if value12:IsA("TextButton") then
              value12:Destroy()
            end
          end

          local v102 = 6

          for index5, value13 in ipairs(p38) do
            local v103 = value13

            local v104 = f6("TextButton", {
              Parent = v101,
              Size = UDim2.new(1, -4, 0, 14),
              Position = UDim2.new(0, 2, 0, 0),
              Text = v103,
              TextColor3 = v7.Text,
              BackgroundTransparency = 1,
              TextSize = 12,
              TextXAlignment = Enum.TextXAlignment.Left,
            })

            f6("UIPadding", { Parent = v104, PaddingLeft = UDim.new(0, 5) })
            f5(v104)
            f4(v104)
            v102 = v102 + 16

            v104.MouseButton1Click:Connect(function()
              v95 = v103
              v98.Text = v95
              v100.Visible = false
              v99.Text = "+"

              if p40 then
                p40(v95)
              end
            end)
          end

          v100.Size = UDim2.new(0, v97.AbsoluteSize.X, 0, v102)
        end

        v98.MouseButton1Click:Connect(function()
          f9(v100)
          v100.Visible = not v100.Visible
          v99.Text = v100.Visible and "-" or "+"

          if v100.Visible then
            f12()

            v100.Position = UDim2.new(
              0, v97.AbsolutePosition.X, 0, v97.AbsolutePosition.Y + v97.AbsoluteSize.Y + 2
            )
          end
        end)
      end

      function v43:CreateLabel(text11)
        local v105 = f6("TextLabel", {
          Parent = f6("Frame", {
            Parent = parent10,
            Size = UDim2.new(1, 0, 0, 15),
            BackgroundTransparency = 1,
          }),
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundTransparency = 1,
          Text = text11,
          TextColor3 = v7.TextDark,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
          RichText = true,
        })

        f5(v105)
        f4(v105)
      end

      return v43
    end

    return v37
  end

  return v30
end

local v106 = {}
local count2 = 0

while true do
  count2 = 1 + count2

  if not (count2 <= 4) then
    break
  end

  local v107 = count2

  v106[v107] = Drawing.new("Line")
  v106[v107].Thickness = 1
  v106[v107].Visible = false
  v106[v107].ZIndex = 100
end

local v108 = 0

local overdoseWorldColor = Instance.new("ColorCorrectionEffect")
overdoseWorldColor.Name = "OverdoseWorldColor"
overdoseWorldColor.Parent = lighting

local v109 = {}
local v110 = false

task.spawn(function()
  while task.wait(0.5) do
    if getgenv().OverdoseUnloaded then
      break
    end

    if v3.WorldColorEnabled then
      overdoseWorldColor.Enabled = true
      overdoseWorldColor.TintColor = v3.WorldColor
    else
      overdoseWorldColor.Enabled = false
    end

    if v3.Fullbright then
      if not v110 then
        v110 = true

        v109.Ambient = lighting.Ambient
        v109.OutdoorAmbient = lighting.OutdoorAmbient
        v109.Brightness = lighting.Brightness
        v109.ClockTime = lighting.ClockTime
        v109.FogEnd = lighting.FogEnd
        v109.GlobalShadows = lighting.GlobalShadows
      end

      lighting.Ambient = Color3.new(1, 1, 1)
      lighting.OutdoorAmbient = Color3.new(1, 1, 1)
      lighting.Brightness = 2
      lighting.ClockTime = 14
      lighting.FogEnd = 100000
      lighting.GlobalShadows = false
    elseif v110 then
      v110 = false

      lighting.Ambient = v109.Ambient
      lighting.OutdoorAmbient = v109.OutdoorAmbient
      lighting.Brightness = v109.Brightness
      lighting.ClockTime = v109.ClockTime
      lighting.FogEnd = v109.FogEnd
      lighting.GlobalShadows = v109.GlobalShadows
    end
  end
end)

local function f13(p41)
  if not (p41:IsA("Tool") or p41:IsA("Model")) then
    return
  else
    local v111 = tostring(v3.WeaponColor) .. v3.WeaponMaterial .. tostring(v3.WeaponParticles)
      .. tostring(v3.CustomWeapon)

    if p41:GetAttribute("OD_WepCache") == v111 then
      return
    else
      p41:SetAttribute("OD_WepCache", v111)
      local weaponCustomChams = p41:FindFirstChild("WeaponCustomChams")

      if weaponCustomChams then
        weaponCustomChams:Destroy()
      end

      for index6, value14 in ipairs(p41:GetDescendants()) do
        local v112 = value14

        if v112:IsA("BasePart") then
          local weaponInnerPoints = v112:FindFirstChild("WeaponInnerPoints")

          if not v3.CustomWeapon then
            if weaponInnerPoints then
              weaponInnerPoints:Destroy()
            end
          else
            for index7, value15 in ipairs(v112:GetChildren()) do
              if value15:IsA("Decal") or value15:IsA("Texture") then
                value15:Destroy()
              elseif value15:IsA("SpecialMesh") then
                value15.TextureId = ""
              end
            end

            pcall(function() v112.Material = Enum.Material[v3.WeaponMaterial] end)

            v112.Transparency = 0.25
            v112.CastShadow = false
            v112.Color = v3.WeaponColor

            if v3.WeaponParticles then
              local weaponInnerPoints2 = v112:FindFirstChild("WeaponInnerPoints")

              if not weaponInnerPoints2 then
                weaponInnerPoints2 = Instance.new("ParticleEmitter")
                weaponInnerPoints2.Name = "WeaponInnerPoints"
                weaponInnerPoints2.LockedToPart = true
                weaponInnerPoints2.LightEmission = 1
                weaponInnerPoints2.Brightness = 10
                weaponInnerPoints2.Parent = v112
              end

              weaponInnerPoints2.Texture = v3.ParticleTexture

              weaponInnerPoints2.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, v3.WeaponParticleColor),
                ColorSequenceKeypoint.new(0.5, v3.WeaponParticleColor),
                ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)),
              })

              weaponInnerPoints2.Lifetime = NumberRange.new(1, 2)
              weaponInnerPoints2.SpreadAngle = Vector2.new(180, 180)
              weaponInnerPoints2.Speed = NumberRange.new(0.00005, 0.0002)

              weaponInnerPoints2.Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 0.08),
                NumberSequenceKeypoint.new(1, 0),
              })

              weaponInnerPoints2.Rate = v112.Size.X * v112.Size.Y * v112.Size.Z < 0.5 and 5
                or 25
            elseif weaponInnerPoints then
              weaponInnerPoints:Destroy()
            end
          end
        end
      end

      return
    end
  end
end

task.spawn(function()
  while task.wait(1) do
    if getgenv().OverdoseUnloaded then
      break
    else
      if localPlayer.Character then
        for index8, value16 in ipairs(localPlayer.Character:GetChildren()) do
          f13(value16)
        end
      end

      for index9, value17 in ipairs(currentCamera:GetChildren()) do
        if value17:IsA("Model") and not players:GetPlayerFromCharacter(value17) then
          f13(value17)
        end
      end

      local backpack = localPlayer:FindFirstChild("Backpack")

      if backpack then
        for index10, value18 in ipairs(backpack:GetChildren()) do
          f13(value18)
        end
      end
    end
  end
end)

task.spawn(function()
  while task.wait(0.25) do
    if getgenv().OverdoseUnloaded then
      break
    elseif v3.AutoReload then
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
            end
          end
        end
      end)
    end
  end
end)

local v113 = false

v2.VentClick1 = userInputService.InputBegan:Connect(function(input10, p42)
  if getgenv().OverdoseUnloaded then
    return
  end

  if not p42 and input10.UserInputType == Enum.UserInputType.MouseButton1 then
    v113 = true
  end
end)

v2.VentClick2 = userInputService.InputEnded:Connect(function(input11, p43)
  if getgenv().OverdoseUnloaded then
    return
  end

  if input11.UserInputType == Enum.UserInputType.MouseButton1 then
    v113 = false
  end
end)

task.spawn(function()
  local getMouse = localPlayer:GetMouse()

  while task.wait(0.1) do
    if getgenv().OverdoseUnloaded then
      break
    end

    if v3.FastClickVents and v113 then
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

local v114 = {
  { Name = "HackDevice016", Label = "SCP-016" }, { Name = "HackDevice079", Label = "SCP-079" },
  { Name = "ModelCI002", Label = "SCP-002" }, { Name = "ModelCI008", Label = "SCP-008" },
  { Name = "ModelCI106", Label = "SCP-106" }, { Name = "ModelCI299", Label = "SCP-299" },
  { Name = "ModelCI457", Label = "SCP-457" },
}

local v115 = {}
local v116 = {}
local v117 = {}
local v118 = {}

for i = 1, #v114 do
  v116[i] = Drawing.new("Line")
  v116[i].Thickness = 3
  v116[i].Color = Color3.new(0, 0, 0)
  v116[i].Visible = false
  v116[i].ZIndex = 1

  v115[i] = Drawing.new("Line")
  v115[i].Thickness = 1
  v115[i].Color = v7.Accent
  v115[i].Visible = false
  v115[i].ZIndex = 2
end

local function f14(p44)
  for index11, value19 in ipairs(v114) do
    if p44.Name == value19.Name then
      local findFirstChildWhichIsA = p44:FindFirstChildWhichIsA("ProximityPrompt", true)
      local textLabel = nil

      for index12, value20 in ipairs(p44:GetDescendants()) do
        if value20:IsA("TextLabel") and value20.Parent and value20.Parent:IsA("BillboardGui")
          and value20.Text ~= "Label" then
          textLabel = value20
          break
        end
      end

      v117[value19.Name] = {
        Model = p44,
        Prompt = findFirstChildWhichIsA,
        TextLabel = textLabel,
      }

      break
    end
  end
end

for index13, value21 in ipairs(workspace:GetDescendants()) do
  f14(value21)
end

v2.DAConn = workspace.DescendantAdded:Connect(function(descendant)
  if descendant:IsA("Model") then
    f14(descendant)
  end
end)

v2.DRConn = workspace.DescendantRemoving:Connect(function(descendant2)
  if v117[descendant2.Name] and v117[descendant2.Name].Model == descendant2 then
    v117[descendant2.Name] = nil
  end
end)

task.spawn(function()
  while task.wait(0.5) do
    if getgenv().OverdoseUnloaded then
      break
    else
      local v119 = {}

      if v20.Visible then
        for index14, value22 in ipairs(v22:GetChildren()) do
          if value22:IsA("Frame") then
            value22:Destroy()
          end
        end
      end

      local count3 = 0

      for index15, value23 in ipairs(v114) do
        local textDark2 = v7.TextDark
        local text12 = "NONE"
        local v120 = false
        local v121 = v117[value23.Name]

        if v121 and v121.Model and v121.Model.Parent then
          text12 = "IDLE"

          if v121.TextLabel and v121.TextLabel.Parent then
            text12 = v121.TextLabel.Text
          end

          local prompt = v121.Prompt

          if prompt and prompt.Parent and prompt.Enabled then
            text12 = "ON"
            textDark2 = v7.Accent
            v119[index15] = prompt
            v120 = true

            if v3.CIFastInteract then
              prompt.HoldDuration = 1
            end
          elseif text12 ~= "IDLE" then
            textDark2 = v7.Text
          end
        end

        if v20.Visible then
          count3 = count3 + 1

          local parent20 = f6("Frame", {
            Parent = v22,
            Size = UDim2.new(1, 0, 0, 14),
            BackgroundTransparency = 1,
          })

          local v122 = f6("TextLabel", {
            Parent = parent20,
            Size = UDim2.new(0.5, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = value23.Label,
            TextColor3 = v7.Text,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
          })

          local v123 = f6("TextLabel", {
            Parent = parent20,
            Size = UDim2.new(0.5, 0, 1, 0),
            Position = UDim2.new(0.5, 0, 0, 0),
            BackgroundTransparency = 1,
            Text = "[" .. text12 .. "]",
            TextColor3 = textDark2,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Right,
          })

          f5(v122)
          f4(v122)
          f5(v123)
          f4(v123)

          if v120 then
            f2(v123)
          end
        end
      end

      if v20.Visible then
        v20.Size = UDim2.new(
          0, 220, 0, 24 + (count3 > 0 and count3 * 14 + (count3 - 1) * 2 + 10 or 0)
        )
      end

      v118 = v119
    end
  end
end)

local v124 = {
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

local v125 = {
  ["Scientific Department"] = true,
  ["Medical Department"] = true,
  ["Administrative Department"] = true,
}

local f15

local function f16(p45)
  if not v3.SmartTargeting then
    if not v3.TeamCheck then
      return "Enemy", v3.ColorEnemy
    end

    if p45.Team ~= localPlayer.Team then
      return "Enemy", v3.ColorEnemy
    end

    return "Friendly", v3.ColorFriendly
  end

  if p45 == localPlayer or not p45.Team or not localPlayer.Team then
    return "Friendly", v3.ColorFriendly
  else
    local name = p45.Team.Name
    local name2 = localPlayer.Team.Name
    local hasTag = p45.Character and collectionService:HasTag(p45.Character, "Rogue")
    local v126 = f15(p45)

    if hasTag then
      return "Enemy", v3.ColorEnemy
    end

    if v125[name] and not v126 then
      return "Friendly", v3.ColorFriendly
    elseif v124[name2] then
      if name == "Chaos Insurgency" then
        return "Enemy", v3.ColorEnemy
      end

      if name == "Class - D" then
        return v126 and "Enemy" or "Warning", v126 and v3.ColorEnemy or v3.ColorWarning
      end

      if v126 and v125[name] then
        return "Friendly", v3.ColorFriendly
      end

      return "Friendly", v3.ColorFriendly
    elseif name2 == "Chaos Insurgency" or name2 == "Class - D" then
      if v124[name] then
        return "Enemy", v3.ColorEnemy
      end

      if name == "Chaos Insurgency" or name == "Class - D" then
        return "Friendly", v3.ColorFriendly
      end

      if name2 ~= name then
        return "Enemy", v3.ColorEnemy
      end

      return "Friendly", v3.ColorFriendly
    else
      if name2 ~= name then
        return "Enemy", v3.ColorEnemy
      end

      return "Friendly", v3.ColorFriendly
    end
  end
end

function f15(p46)
  if not p46.Character then
    return false
  end

  if collectionService:HasTag(p46.Character, "EquippedGun")
    or collectionService:HasTag(p46.Character, "Hostile") then
    return true
  end

  for index16, value24 in ipairs(p46.Character:GetChildren()) do
    if value24:IsA("Tool")
      and (value24:FindFirstChild("GunServer", true) or value24:FindFirstChild("Damage", true)
        or value24:FindFirstChild("KnifeServer", true)) then
      return true
    end
  end

  return false
end

local v127 = {}

task.spawn(function()
  while task.wait(0.25) do
    if getgenv().OverdoseUnloaded then
      break
    end

    for index17, value25 in ipairs(players:GetPlayers()) do
      if value25 ~= localPlayer then
        v127[value25] = { Status = f16(value25), Color = select(2, f16(value25)) }
      end
    end
  end
end)

local circle = Drawing.new("Circle")
circle.Thickness = 1
circle.Filled = false

local v128 = {}

for j = 1, 30 do
  local circle2 = Drawing.new("Circle")
  circle2.Radius = 2
  circle2.Filled = true
  circle2.Visible = false

  v128[j] = circle2
end

local v129 = {}

for k = 1, 8 do
  local line = Drawing.new("Line")
  line.Thickness = 2
  line.Visible = false

  v129[k] = line
end

local v130 = {}
local count4 = 0

while true do
  count4 = 1 + count4

  if not (3 >= count4) then
    break
  end

  local circle3 = Drawing.new("Circle")
  circle3.Thickness = 1
  circle3.Filled = true
  circle3.Visible = false

  v130[count4] = circle3
end

local v131 = {}

local function f17(p47)
  if p47 == localPlayer then
    return
  else
    local v132 = {}
    local count5 = 0

    while true do
      count5 = 1 + count5

      if not (14 >= count5) then
        break
      end

      local v133 = count5

      v132[v133] = Drawing.new("Line")
      v132[v133].Thickness = 1
      v132[v133].Visible = false
      v132[v133].ZIndex = 2
    end

    v131[p47] = {
      BoxOutline = Drawing.new("Square"),
      Box = Drawing.new("Square"),
      HealthOutline = Drawing.new("Line"),
      HealthBar = Drawing.new("Line"),
      NameText = Drawing.new("Text"),
      DistText = Drawing.new("Text"),
      Skeleton = v132,
    }

    v131[p47].BoxOutline.Thickness = 3
    v131[p47].BoxOutline.Filled = false
    v131[p47].BoxOutline.Color = Color3.new(0, 0, 0)
    v131[p47].BoxOutline.ZIndex = 1
    v131[p47].Box.Thickness = 1
    v131[p47].Box.Filled = false
    v131[p47].Box.ZIndex = 2
    v131[p47].HealthOutline.Thickness = 3
    v131[p47].HealthOutline.Color = Color3.new(0, 0, 0)
    v131[p47].HealthOutline.ZIndex = 1
    v131[p47].HealthBar.Thickness = 1
    v131[p47].HealthBar.ZIndex = 2
    v131[p47].NameText.Center = true
    v131[p47].NameText.Outline = true
    v131[p47].NameText.Color = Color3.new(1, 1, 1)
    v131[p47].NameText.Font = 2
    v131[p47].NameText.Size = 13
    v131[p47].NameText.ZIndex = 3
    v131[p47].DistText.Center = true
    v131[p47].DistText.Outline = true
    v131[p47].DistText.Color = Color3.fromRGB(200, 200, 200)
    v131[p47].DistText.Font = 2
    v131[p47].DistText.Size = 13
    v131[p47].DistText.ZIndex = 3

    return
  end
end

for index18, value26 in ipairs(players:GetPlayers()) do
  f17(value26)
end

local v134 = {}

local function f18(p48)
  if p48 == localPlayer or v134[p48] then
    return
  end

  v134[p48] = true

  task.spawn(function()
    local v135, v136 = pcall(function() return p48:GetRoleInGroup(5479038) end)

    if v135 and v136 ~= "Guest" and v136 ~= "Roleplayer" and v3.PanicMod then
      localPlayer:Kick("PANIC MOD: Угроза обнаружена! Зашел " .. p48.Name
        .. " с рангом " .. v136)
    end
  end)
end

v2.PlayerAddedConn = players.PlayerAdded:Connect(function(player)
  f17(player)

  if v3.PanicMod then
    f18(player)
  end
end)

v2.PlayerRemConn = players.PlayerRemoving:Connect(function(player2)
  if v131[player2] then
    for key9, value27 in pairs(v131[player2]) do
      local v137 = value27

      if type(v137) == "table" then
        for index19, value28 in ipairs(v137) do
          local v138 = value28
          pcall(function() v138:Remove() end)
        end
      else
        pcall(function() v137:Remove() end)
      end
    end

    v131[player2] = nil
  end

  v127[player2] = nil
  v134[player2] = nil
end)

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.IgnoreWater = true

local v139 = { nil, nil }

local function f19(p49)
  if not v3.WallCheck or not localPlayer.Character then
    return true
  else
    local position3 = currentCamera.CFrame.Position

    v139[1] = localPlayer.Character
    v139[2] = p49.Parent

    raycastParams.FilterDescendantsInstances = v139
    return workspace:Raycast(position3, p49.Position - position3, raycastParams) == nil
  end
end

local function f20()
  local v140 = {}

  local fovCenter = v3.FOVCenter and currentCamera.ViewportSize / 2
    or userInputService:GetMouseLocation()

  for index20, value29 in ipairs(players:GetPlayers()) do
    if value29 ~= localPlayer and value29.Character then
      local findFirstChild = value29.Character:FindFirstChild(v3.TargetPart)
      local humanoid = value29.Character:FindFirstChild("Humanoid")

      if findFirstChild and findFirstChild.Parent and humanoid and humanoid.Health > 0 then
        local v141 = v127[value29]

        if v3.SmartTargeting and v141 and v141.Status ~= "Enemy" then
        else
          local v142, v143 = currentCamera:WorldToViewportPoint(findFirstChild.Position)

          if v143 then
            local magnitude = (Vector2.new(v142.X, v142.Y) - fovCenter).Magnitude

            if magnitude <= v3.FOVRadius then
              table.insert(v140, { part = findFirstChild, dist = magnitude })
            end
          end
        end
      end
    end
  end

  table.sort(v140, function(p50, p51) return p50.dist < p51.dist end)

  for index21, value30 in ipairs(v140) do
    if not v3.WallCheck or f19(value30.part) then
      return value30.part
    end
  end

  return nil
end

local v144 = {
  { "Head", "UpperTorso" }, { "UpperTorso", "LowerTorso" }, { "UpperTorso", "LeftUpperArm" },
  { "LeftUpperArm", "LeftLowerArm" }, { "LeftLowerArm", "LeftHand" },
  { "UpperTorso", "RightUpperArm" }, { "RightUpperArm", "RightLowerArm" },
  { "RightLowerArm", "RightHand" }, { "LowerTorso", "LeftUpperLeg" },
  { "LeftUpperLeg", "LeftLowerLeg" }, { "LeftLowerLeg", "LeftFoot" },
  { "LowerTorso", "RightUpperLeg" }, { "RightUpperLeg", "RightLowerLeg" },
  { "RightLowerLeg", "RightFoot" },
}

local silentAim

v2.RenderConn = runService.RenderStepped:Connect(function(delta)
  local v145, v146, v147, v148, position4, v149

  if getgenv().OverdoseUnloaded then
    return
  else
    if v3.Crosshair then
      local crosshairCenter = v3.CrosshairCenter and currentCamera.ViewportSize / 2
        or userInputService:GetMouseLocation()

      local crosshairThickness = v3.CrosshairThickness
      local crosshairGap = v3.CrosshairGap
      local crosshairLength = v3.CrosshairLength

      if v3.CrosshairRotate then
        v108 = v108 + v3.CrosshairRotSpeed * delta * 60

        if v108 >= 360 then
          v108 = 0
        end
      else
        v108 = 0
      end

      local v150 = math.rad(v108)
      v146 = math.cos(v150)
      v145 = math.sin(v150)

      local function f21(p52, p53)
        return Vector2.new(
          crosshairCenter.X + (p52 * v146 - p53 * v145),
          crosshairCenter.Y + (p52 * v145 + p53 * v146)
        )
      end

      v106[1].From = f21(0, -crosshairGap)
      v106[1].To = f21(0, -crosshairGap - crosshairLength)
      v106[1].Color = v3.CrosshairColor3
      v106[2].From = f21(0, crosshairGap)
      v106[2].To = f21(0, crosshairGap + crosshairLength)
      v106[2].Color = v3.CrosshairColor4
      v106[3].From = f21(-crosshairGap, 0)
      v106[3].To = f21(-crosshairGap - crosshairLength, 0)
      v106[3].Color = v3.CrosshairColor1
      v106[4].From = f21(crosshairGap, 0)
      v106[4].To = f21(crosshairGap + crosshairLength, 0)
      v106[4].Color = v3.CrosshairColor2

      for m = 1, 4 do
        v106[m].Thickness = crosshairThickness
        v106[m].Visible = true
        v106[m].Transparency = 0.8
      end
    else
      for n = 1, 4 do
        v106[n].Visible = false
      end
    end

    position4 = currentCamera.CFrame.Position
    local viewportSize = currentCamera.ViewportSize
    local vector = Vector2.new(viewportSize.X / 2, viewportSize.Y)
    local character2 = localPlayer.Character

    local humanoidRootPart = character2
    humanoidRootPart = character2 and localPlayer.Character:FindFirstChild("HumanoidRootPart")

    if v3.ShowFOV then
      local fovCenter2 = v3.FOVCenter and viewportSize / 2
        or userInputService:GetMouseLocation()

      if v3.FOVType == "Circle" then
        circle.Position = fovCenter2
        circle.Radius = v3.FOVRadius
        circle.Color = v3.FOVColor
        circle.Visible = true

        local count6 = 0

        while true do
          count6 = 1 + count6

          if not (30 >= count6) then
            break
          end

          v128[count6].Visible = false
        end
      elseif v3.FOVType == "Dots" then
        circle.Visible = false
        local count7 = 0

        while true do
          count7 = 1 + count7

          if not (count7 <= 30) then
            break
          end

          local v151 = count7
          local v152 = v151 / 30 * math.pi * 2

          v128[v151].Position = Vector2.new(
            fovCenter2.X + math.cos(v152) * v3.FOVRadius,
            fovCenter2.Y + math.sin(v152) * v3.FOVRadius
          )

          v128[v151].Color = v3.FOVColor
          v128[v151].Visible = true
        end
      end
    else
      circle.Visible = false
      local count8 = 0

      while true do
        count8 = 1 + count8

        if not (30 >= count8) then
          break
        end

        v128[count8].Visible = false
      end
    end

    silentAim = v3.SilentAim and f20() or nil

    if v3.ShowTarget and silentAim and silentAim.Parent then
      local v153
      v149, v153 = currentCamera:WorldToViewportPoint(silentAim.Position)

      if v153 then
        if v3.TargetMarkerStyle == "Corners" then
          local markerSize = v3.MarkerSize
          local markerLength = v3.MarkerLength
          local v154 = tick() * v3.RotationSpeed
          v148 = math.cos(v154)
          v147 = math.sin(v154)

          local function f22(p54, p55)
            return Vector2.new(
              v149.X + (p54 * v148 - p55 * v147), v149.Y + (p54 * v147 + p55 * v148)
            )
          end

          local from = f22(-markerSize, -markerSize)
          local from2 = f22(markerSize, -markerSize)
          local from3 = f22(markerSize, markerSize)
          local from4 = f22(-markerSize, markerSize)

          v129[1].From = from
          v129[1].To = f22(-markerSize + markerLength, -markerSize)
          v129[2].From = from
          v129[2].To = f22(-markerSize, -markerSize + markerLength)
          v129[3].From = from2
          v129[3].To = f22(markerSize - markerLength, -markerSize)
          v129[4].From = from2
          v129[4].To = f22(markerSize, -markerSize + markerLength)
          v129[5].From = from3
          v129[5].To = f22(markerSize - markerLength, markerSize)
          v129[6].From = from3
          v129[6].To = f22(markerSize, markerSize - markerLength)
          v129[7].From = from4
          v129[7].To = f22(-markerSize + markerLength, markerSize)
          v129[8].From = from4
          v129[8].To = f22(-markerSize, markerSize - markerLength)

          local count9 = 0

          while true do
            count9 = 1 + count9

            if not (8 >= count9) then
              break
            end

            local v155 = count9

            v129[v155].Visible = true
            v129[v155].Color = v3.TargetColor
          end

          for i6 = 1, 3 do
            v130[i6].Visible = false
          end
        elseif v3.TargetMarkerStyle == "Orbit" then
          local v156 = v3.MarkerSize + math.sin(tick() * 5) * 5

          for i7 = 1, 3 do
            local v157 = tick() * v3.RotationSpeed + i7 * (math.pi * 2 / 3)

            v130[i7].Position = Vector2.new(v149.X, v149.Y)
              + Vector2.new(math.cos(v157), math.sin(v157)) * v156

            v130[i7].Radius = 3
            v130[i7].Color = v3.TargetColor
            v130[i7].Visible = true
          end

          local count10 = 0

          while true do
            count10 = 1 + count10

            if not (8 >= count10) then
              break
            end

            v129[count10].Visible = false
          end
        end
      else
        for i8 = 1, 8 do
          v129[i8].Visible = false
        end

        for i9 = 1, 3 do
          v130[i9].Visible = false
        end
      end
    else
      for i10 = 1, 8 do
        v129[i10].Visible = false
      end

      for i11 = 1, 3 do
        v130[i11].Visible = false
      end
    end

    if v3.CIDevicesESP then
      local v158 = #v114
      local count11 = 0

      while true do
        count11 = 1 + count11

        if not (v158 >= count11) then
          break
        end

        local v159 = count11
        local v160 = v115[v159]
        local v161 = v116[v159]
        local v162 = v118[v159]
        v160.Color = v7.Accent

        if v162 and v162.Parent and v162.Parent:IsA("BasePart") then
          local v163, v164 = currentCamera:WorldToViewportPoint(v162.Parent.Position)

          if v164 then
            local vector2 = Vector2.new(v163.X, v163.Y)

            v161.From = vector
            v161.To = vector2
            v161.Visible = true

            v160.From = vector
            v160.To = vector2
            v160.Visible = true
          else
            v161.Visible = false
            v160.Visible = false
          end
        else
          v161.Visible = false
          v160.Visible = false
        end
      end
    else
      local v165 = #v114
      local count12 = 0

      while true do
        count12 = 1 + count12

        if not (v165 >= count12) then
          break
        end

        local v166 = count12
        v115[v166].Visible = false
        v116[v166].Visible = false
      end
    end

    for key10, value31 in pairs(v131) do
      local v167 = key10
      local v168 = value31
      local character3 = v167.Character
      local v169 = true

      if v3.ESPEnabled and humanoidRootPart and v167.Parent and character3 and character3.Parent then
        local humanoid2 = character3:FindFirstChild("Humanoid")
        local humanoidRootPart2 = character3:FindFirstChild("HumanoidRootPart")
        local head = character3:FindFirstChild("Head")

        if humanoid2 and humanoidRootPart2 and head and humanoid2.Health > 0 then
          if (humanoidRootPart2.Position - position4).Magnitude <= v3.MaxDistance then
            if not v3.ESPTeamCheck or v167.Team ~= localPlayer.Team then
              local v170 = v127[v167]
              local status = v170 and v170.Status or "Enemy"

              if not (v3.SmartTargeting and status == "Friendly") then
                if not pcall(function()
                  local v171, v172 = currentCamera:WorldToViewportPoint(humanoidRootPart2.Position)

                  if v172 then
                    v169 = false

                    local worldToViewportPoint = currentCamera:WorldToViewportPoint(head.Position + Vector3.new(
                      0, 0.5, 0
                    ))

                    local vector3 = Vector3.new(0, 3, 0)

                    local worldToViewportPoint2 = currentCamera:WorldToViewportPoint(humanoidRootPart2.Position
                      - vector3)

                    local v173 = math.abs(worldToViewportPoint.Y - worldToViewportPoint2.Y)
                    local v174 = v173 / 2
                    local vector4 = Vector2.new(v171.X - v174 / 2, worldToViewportPoint.Y)
                    local vector5 = Vector2.new(v174, v173)

                    if v3.DrawBoxes then
                      v168.BoxOutline.Size = vector5
                      v168.BoxOutline.Position = vector4
                      v168.BoxOutline.Visible = true
                      v168.Box.Size = vector5
                      v168.Box.Position = vector4
                      v168.Box.Color = v3.ESPColor
                      v168.Box.Visible = true
                    else
                      v168.BoxOutline.Visible = false
                      v168.Box.Visible = false
                    end

                    if v3.DrawHealthBar then
                      local v175 = math.max(humanoid2.MaxHealth, 1)
                      local v176 = math.clamp(humanoid2.Health, 0, v175)
                      local v177 = math.floor(v173 * (v176 / v175))

                      v168.HealthOutline.From = Vector2.new(vector4.X - 5, vector4.Y - 1)
                      v168.HealthOutline.To = Vector2.new(vector4.X - 5, vector4.Y + v173 + 1)
                      v168.HealthOutline.Visible = true
                      v168.HealthBar.From = Vector2.new(vector4.X - 5, vector4.Y + v173)
                      v168.HealthBar.To = Vector2.new(vector4.X - 5, vector4.Y + v173 - v177)

                      v168.HealthBar.Color = Color3.fromRGB(
                        255 - v176 / v175 * 255, v176 / v175 * 255, 0
                      )

                      v168.HealthBar.Visible = true
                    else
                      v168.HealthOutline.Visible = false
                      v168.HealthBar.Visible = false
                    end

                    if v3.DrawNames then
                      v168.NameText.Text = v167.Name
                      v168.NameText.Position = Vector2.new(vector4.X + v174 / 2, vector4.Y - 14)
                      v168.NameText.Color = v3.ESPColor
                      v168.NameText.Visible = true
                    else
                      v168.NameText.Visible = false
                    end

                    if v3.DrawDistance then
                      v168.DistText.Text = tostring(math.floor((humanoidRootPart2.Position
                          - position4).Magnitude))
                        .. " st"

                      v168.DistText.Position = Vector2.new(
                        vector4.X + v174 / 2, vector4.Y + v173 + 2
                      )

                      v168.DistText.Visible = true
                    else
                      v168.DistText.Visible = false
                    end

                    if v3.DrawSkeletons then
                      for index22, value32 in ipairs(v144) do
                        local findFirstChild2 = character3:FindFirstChild(value32[1])
                        local findFirstChild3 = character3:FindFirstChild(value32[2])

                        if findFirstChild2 and findFirstChild3 then
                          local v178, v179 = currentCamera:WorldToViewportPoint(findFirstChild2.Position)
                          local v180, v181 = currentCamera:WorldToViewportPoint(findFirstChild3.Position)

                          if v179 or v181 then
                            v168.Skeleton[index22].From = Vector2.new(v178.X, v178.Y)
                            v168.Skeleton[index22].To = Vector2.new(v180.X, v180.Y)
                            v168.Skeleton[index22].Color = v3.ESPColor
                            v168.Skeleton[index22].Visible = true
                          else
                            v168.Skeleton[index22].Visible = false
                          end
                        else
                          v168.Skeleton[index22].Visible = false
                        end
                      end
                    else
                      for i12 = 1, 14 do
                        v168.Skeleton[i12].Visible = false
                      end
                    end
                  end
                end) then
                  v169 = true
                end
              end
            end
          end
        end
      end

      if v169 then
        v168.BoxOutline.Visible = false
        v168.Box.Visible = false
        v168.HealthOutline.Visible = false
        v168.HealthBar.Visible = false
        v168.NameText.Visible = false
        v168.DistText.Visible = false

        for i13 = 1, 14 do
          v168.Skeleton[i13].Visible = false
        end
      end
    end

    return
  end
end)

local v182

v182 = hookmetamethod(game, "__namecall", function(p56, ...)
  if getgenv().OverdoseUnloaded then
    return v182(p56, ...)
  else
    local v183 = getnamecallmethod()

    if not checkcaller() then
      if v183 == "Raycast" and v3.SilentAim and silentAim and silentAim.Parent then
        local v184 = { ... }
        local v185 = v184[2]
        local v186 = v184[1]

        if typeof(v186) == "Vector3" and typeof(v185) == "Vector3"
          and v186 ~= currentCamera.CFrame.Position and v185.Magnitude > 20 then
          v184[2] = (silentAim.Position - v186).Unit * v185.Magnitude
          return v182(p56, unpack(v184))
        end

        return v182(p56, ...)
      end

      if v183 == "FireServer" and p56.ClassName == "RemoteEvent" then
        local v187 = { ... }

        if type(v187[1]) == "table" and type(v187[1][1]) == "table" and #v187[1][1] == 3 then
          if v3.SilentAim and silentAim and silentAim.Parent then
            v187[1][1] = { silentAim.Position.X, silentAim.Position.Y, silentAim.Position.Z }
            v187[1][2] = true
            v187[3] = silentAim

            return v182(p56, unpack(v187))
          end
        end

        return v182(p56, ...)
      end

      return v182(p56, ...)
    end

    return v182(p56, ...)
  end
end)

local window = v1:CreateWindow("Overdose.gg | FREE")
local combatTab = window:CreateTab("Combat")

local aimbotSection = combatTab:CreateSection("Aimbot", "Left")

aimbotSection:CreateToggle("Silent Aim", v3.SilentAim, function(silentAim2)
  v3.SilentAim = silentAim2
end)

aimbotSection:CreateToggle("Smart Target", v3.SmartTargeting, function(smartTargeting)
  v3.SmartTargeting = smartTargeting
end)

aimbotSection:CreateToggle("Team Check", v3.TeamCheck, function(teamCheck)
  v3.TeamCheck = teamCheck
end)

aimbotSection:CreateToggle("Wall Check", v3.WallCheck, function(wallCheck)
  v3.WallCheck = wallCheck
end)

aimbotSection:CreateDropdown(
  "Target Part", { "Head", "Torso", "HumanoidRootPart" }, v3.TargetPart,
  function(targetPart) v3.TargetPart = targetPart end
)

aimbotSection:CreateToggle("Auto Reload", v3.AutoReload, function(autoReload)
  v3.AutoReload = autoReload
end)

local targetVisualsSection = combatTab:CreateSection("Target Visuals", "Right")

targetVisualsSection:CreateToggle("Show FOV", v3.ShowFOV, function(showFOV)
  v3.ShowFOV = showFOV
end)

targetVisualsSection:CreateDropdown("FOV Type", { "Circle", "Dots" }, v3.FOVType, function(fovType)
  v3.FOVType = fovType
end)

targetVisualsSection:CreateToggle("Center FOV", v3.FOVCenter, function(fovCenter3)
  v3.FOVCenter = fovCenter3
end)

targetVisualsSection:CreateColorPicker("FOV Color", v3.FOVColor, function(fovColor)
  v3.FOVColor = fovColor
end)

targetVisualsSection:CreateSlider("FOV Radius", 10, 500, v3.FOVRadius, " px", function(fovRadius)
  v3.FOVRadius = fovRadius
end)

targetVisualsSection:CreateToggle("Target Marker", v3.ShowTarget, function(showTarget)
  v3.ShowTarget = showTarget
end)

targetVisualsSection:CreateDropdown("Marker Style", { "Corners", "Orbit" }, v3.TargetMarkerStyle, function(targetMarkerStyle)
  v3.TargetMarkerStyle = targetMarkerStyle
end)

targetVisualsSection:CreateColorPicker("Marker Color", v3.TargetColor, function(targetColor)
  v3.TargetColor = targetColor
end)

local weaponTab = window:CreateTab("Weapon")

local customSection = weaponTab:CreateSection("Custom", "Left")

customSection:CreateToggle("Enable", v3.CustomWeapon, function(customWeapon)
  v3.CustomWeapon = customWeapon
end)

customSection:CreateDropdown("Material", v6, v3.WeaponMaterial, function(weaponMaterial)
  v3.WeaponMaterial = weaponMaterial
end)

customSection:CreateColorPicker("Core Color", v3.WeaponColor, function(weaponColor)
  v3.WeaponColor = weaponColor
end)

local particlesSection = weaponTab:CreateSection("Particles", "Right")

particlesSection:CreateToggle("Enable Particles", v3.WeaponParticles, function(weaponParticles)
  v3.WeaponParticles = weaponParticles
end)

particlesSection:CreateDropdown("Texture", v5, "Smoke", function(p57)
  v3.ParticleTexture = v4[p57]
end)

particlesSection:CreateColorPicker("Color", v3.WeaponParticleColor, function(weaponParticleColor)
  v3.WeaponParticleColor = weaponParticleColor
end)

local lightingSection = window:CreateTab("World"):CreateSection("Lighting", "Left")

lightingSection:CreateToggle("Fullbright", v3.Fullbright, function(fullbright)
  v3.Fullbright = fullbright
end)

lightingSection:CreateToggle("Custom Color", v3.WorldColorEnabled, function(worldColorEnabled)
  v3.WorldColorEnabled = worldColorEnabled
end)

lightingSection:CreateColorPicker("Color", v3.WorldColor, function(worldColor)
  v3.WorldColor = worldColor
end)

local visualsTab = window:CreateTab("Visuals")

local espSection = visualsTab:CreateSection("ESP", "Left")

espSection:CreateToggle("Enable ESP", v3.ESPEnabled, function(espEnabled)
  v3.ESPEnabled = espEnabled
end)

espSection:CreateToggle("Team Check", v3.ESPTeamCheck, function(espTeamCheck)
  v3.ESPTeamCheck = espTeamCheck
end)

espSection:CreateToggle("Draw Boxes", v3.DrawBoxes, function(drawBoxes)
  v3.DrawBoxes = drawBoxes
end)

espSection:CreateToggle("Draw Names", v3.DrawNames, function(drawNames)
  v3.DrawNames = drawNames
end)

espSection:CreateToggle("Draw Distance", v3.DrawDistance, function(drawDistance)
  v3.DrawDistance = drawDistance
end)

espSection:CreateToggle("Skeletons", v3.DrawSkeletons, function(drawSkeletons)
  v3.DrawSkeletons = drawSkeletons
end)

espSection:CreateToggle("Health Bar", v3.DrawHealthBar, function(drawHealthBar)
  v3.DrawHealthBar = drawHealthBar
end)

espSection:CreateSlider("Max Distance", 100, 5000, v3.MaxDistance, " st", function(maxDistance)
  v3.MaxDistance = maxDistance
end)

espSection:CreateColorPicker("ESP Color", v3.ESPColor, function(espColor)
  v3.ESPColor = espColor
end)

local customCrosshairSection = visualsTab:CreateSection("Custom Crosshair", "Right")

customCrosshairSection:CreateToggle("Enable Crosshair", v3.Crosshair, function(crosshair)
  v3.Crosshair = crosshair
end)

customCrosshairSection:CreateToggle("Center Crosshair", v3.CrosshairCenter, function(crosshairCenter2)
  v3.CrosshairCenter = crosshairCenter2
end)

customCrosshairSection:CreateToggle("Rotate", v3.CrosshairRotate, function(crosshairRotate)
  v3.CrosshairRotate = crosshairRotate
end)

customCrosshairSection:CreateSlider("Rotate Speed", 1, 10, v3.CrosshairRotSpeed, "", function(crosshairRotSpeed)
  v3.CrosshairRotSpeed = crosshairRotSpeed
end)

customCrosshairSection:CreateSlider("Thickness", 1, 10, v3.CrosshairThickness, " px", function(crosshairThickness2)
  v3.CrosshairThickness = crosshairThickness2
end)

customCrosshairSection:CreateSlider("Length", 1, 100, v3.CrosshairLength, " px", function(crosshairLength2)
  v3.CrosshairLength = crosshairLength2
end)

customCrosshairSection:CreateSlider("Gap", 0, 50, v3.CrosshairGap, " px", function(crosshairGap2)
  v3.CrosshairGap = crosshairGap2
end)

customCrosshairSection:CreateColorPicker("Color Left", v3.CrosshairColor1, function(crosshairColor1)
  v3.CrosshairColor1 = crosshairColor1
end)

customCrosshairSection:CreateColorPicker("Color Right", v3.CrosshairColor2, function(crosshairColor2)
  v3.CrosshairColor2 = crosshairColor2
end)

customCrosshairSection:CreateColorPicker("Color Top", v3.CrosshairColor3, function(crosshairColor3)
  v3.CrosshairColor3 = crosshairColor3
end)

customCrosshairSection:CreateColorPicker("Color Bottom", v3.CrosshairColor4, function(crosshairColor4)
  v3.CrosshairColor4 = crosshairColor4
end)

local ciHelperTab = window:CreateTab("CI Helper")

local hacksSection = ciHelperTab:CreateSection("Hacks", "Left")
hacksSection:CreateToggle("Hacks Menu", false, function(p58) v1:SetCIHacksVisible(p58) end)

hacksSection:CreateToggle("Tracers", v3.CIDevicesESP, function(ciDevicesESP)
  v3.CIDevicesESP = ciDevicesESP
end)

hacksSection:CreateToggle("Fast Disarm", v3.CIFastInteract, function(ciFastInteract)
  v3.CIFastInteract = ciFastInteract
end)

local miscSection = ciHelperTab:CreateSection("Misc", "Right")

miscSection:CreateToggle("Fast Vents", v3.FastClickVents, function(fastClickVents)
  v3.FastClickVents = fastClickVents
end)

miscSection:CreateLabel("Hold LMB on vent")

local settingsTab = window:CreateTab("Settings")

local uiSection = settingsTab:CreateSection("UI", "Left")
uiSection:CreateColorPicker("Accent", v7.Accent, function(p59) v1:ChangeAccent(p59) end)
uiSection:CreateToggle("Keybinds List", false, function(p60) v1:SetKeybindsVisible(p60) end)

uiSection:CreateToggle("Panic Mod (Staff Kick)", v3.PanicMod, function(panicMod)
  v3.PanicMod = panicMod
end)

uiSection:CreateKeybind("Toggle Bind", Enum.KeyCode.Home, "toggle", true, function(p61, p62)
  if p62 then
    getgenv().ToggleUIKey = p62
  end
end)

local informationSection = settingsTab:CreateSection("Information", "Right")

informationSection:CreateButton("Copy Discord Link", function()
  if setclipboard then
    setclipboard("https://discord.gg/kG2EhsgpKM")
  end
end)

informationSection:CreateButton("Unload Script", function()
  getgenv().OverdoseUnloaded = true

  if v14 then
    v14:Destroy()
  end

  if lighting:FindFirstChild("OverdoseWorldColor") then
    lighting.OverdoseWorldColor:Destroy()
  end

  if v110 then
    lighting.Ambient = v109.Ambient
    lighting.OutdoorAmbient = v109.OutdoorAmbient
    lighting.Brightness = v109.Brightness
    lighting.ClockTime = v109.ClockTime
    lighting.FogEnd = v109.FogEnd
    lighting.GlobalShadows = v109.GlobalShadows
  end

  for key11, value33 in pairs(v2) do
    if value33 and typeof(value33) == "RBXScriptConnection" then
      value33:Disconnect()
    end
  end

  for key12, value34 in pairs(v131) do
    value34.BoxOutline:Remove()
    value34.Box:Remove()
    value34.HealthOutline:Remove()
    value34.HealthBar:Remove()
    value34.NameText:Remove()
    value34.DistText:Remove()

    for i14 = 1, 14 do
      value34.Skeleton[i14]:Remove()
    end
  end

  v131 = {}

  if circle then
    circle:Remove()
  end

  for i15 = 1, 30 do
    if v128[i15] then
      v128[i15]:Remove()
    end
  end

  local count13 = 0

  while true do
    count13 = 1 + count13

    if not (count13 <= 8) then
      break
    end

    local v188 = count13

    if v129[v188] then
      v129[v188]:Remove()
    end
  end

  for i16 = 1, 3 do
    if v130[i16] then
      v130[i16]:Remove()
    end
  end

  local v189 = #v114
  local count14 = 0

  while true do
    count14 = 1 + count14

    if not (count14 <= v189) then
      break
    end

    local v190 = count14

    if v116[v190] then
      v116[v190]:Remove()
    end

    if v115[v190] then
      v115[v190]:Remove()
    end
  end

  for index23, value35 in ipairs(workspace:GetDescendants()) do
    if value35:IsA("ParticleEmitter") and value35.Name == "WeaponInnerPoints" then
      value35:Destroy()
    end
  end

  local count15 = 0

  while true do
    count15 = 1 + count15

    if not (count15 <= 4) then
      break
    end

    local v191 = count15

    if v106[v191] then
      v106[v191]:Remove()
    end
  end
end)
