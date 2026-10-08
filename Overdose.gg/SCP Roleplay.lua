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
local v3 = {}

local v4 = {
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
  DrawBoxes = true,
  DrawFill = true,
  DrawNames = true,
  DrawDistance = false,
  DrawHealthBar = true,
  DrawTracers = false,
  MaxDistance = 1500,
  BoxColors = {
    Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255),
  },
  FillColors = {
    Color3.fromRGB(100, 100, 255), Color3.fromRGB(100, 100, 255), Color3.fromRGB(100, 100, 255),
  },
  HpColors = {
    Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 255, 0), Color3.fromRGB(0, 255, 0),
  },
  NameColor = Color3.fromRGB(255, 255, 255),
  DistColor = Color3.fromRGB(255, 255, 255),
  TracerColor = Color3.fromRGB(255, 255, 255),
  JumpCircleEnabled = false,
  JC_Color1 = Color3.fromRGB(0, 100, 255),
  JC_Color2 = Color3.fromRGB(255, 255, 255),
  JC_Thickness = 1.5,
  JC_Duration = 0.8,
  JC_MaxRadius = 12,
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
  Fullbright = false,
  WorldColorEnabled = false,
  WorldColor = Color3.fromRGB(255, 255, 255),
  WorldContrast = 0,
  WorldSaturation = 0,
  WorldBrightness = 0,
  CustomFog = false,
  FogColor = Color3.fromRGB(150, 150, 150),
  FogStart = 0,
  FogEnd = 1000,
  CustomAmbient = false,
  Ambient = Color3.fromRGB(128, 128, 128),
  OutdoorAmbient = Color3.fromRGB(128, 128, 128),
  EnableBloom = false,
  BloomIntensity = 1,
  BloomSize = 24,
  BloomThreshold = 2,
  EnableSunRays = false,
  SunRaysIntensity = 0.25,
  SunRaysSpread = 1,
  EnableBlur = false,
  BlurSize = 5,
  PanicMod = false,
  AccentColor = Color3.fromRGB(100, 100, 255),
  ColorEnemy = Color3.fromRGB(255, 50, 50),
  ColorFriendly = Color3.fromRGB(50, 255, 50),
  ColorWarning = Color3.fromRGB(255, 200, 50),
}

local v5 = {}

local v6 = {
  MainBg = Color3.fromRGB(26, 26, 26),
  SectionBg = Color3.fromRGB(22, 22, 22),
  ElementBg = Color3.fromRGB(38, 38, 38),
  BorderOuter = Color3.fromRGB(8, 8, 8),
  BorderInner = Color3.fromRGB(57, 57, 57),
  Accent = v4.AccentColor,
  Text = Color3.fromRGB(170, 170, 170),
  TextDark = Color3.fromRGB(90, 90, 90),
}

local function f1(p1)
  if not p1 then
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
  })[p1] or p1.Name
end

local v7 = {
  Bg = {},
  Text = {},
  Image = {},
  Gradient = {},
}

local function f2(p2)
  table.insert(v7.Bg, p2)
  return p2
end

local function f3(p3)
  table.insert(v7.Text, p3)
  return p3
end

function v1:ChangeAccent(p4)
  v6.Accent = p4
  v4.AccentColor = p4

  for key, value in pairs(v7.Bg) do
    if value and value.Parent then
      value.BackgroundColor3 = p4
    end
  end

  for key2, value2 in pairs(v7.Text) do
    if value2 and value2.Parent then
      value2.TextColor3 = p4
    end
  end

  for key3, value3 in pairs(v7.Image) do
    if value3 and value3.Parent then
      value3.ImageColor3 = p4
    end
  end

  for key4, value4 in pairs(v7.Gradient) do
    if value4 and value4.Parent then
      value4.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(0.5, p4),
        ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)),
      })
    end
  end

  if self.UpdateKeybindList then
    self:UpdateKeybindList()
  end
end

local function f4(p5)
  for index, value5 in ipairs(v1.popups) do
    if value5 ~= p5 and value5.Visible then
      value5.Visible = false
    end
  end
end

local function f5(parent)
  local uiStroke = Instance.new("UIStroke")
  uiStroke.Color = Color3.new(0, 0, 0)
  uiStroke.Thickness = 1
  uiStroke.Transparency = 0.5
  uiStroke.Parent = parent
end

local code = Enum.Font.Code

local function f6(p6, p7)
  local inputBegan = p6.InputBegan
  local v8, position, position2

  inputBegan:Connect(function(p8)
    if p8.UserInputType == Enum.UserInputType.MouseButton1 then
      v8 = true
      position = p8.Position
      position2 = p7.Position

      p8.Changed:Connect(function()
        if p8.UserInputState == Enum.UserInputState.End then
          v8 = false
        end
      end)
    end
  end)

  local v9

  p6.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
      v9 = input
    end
  end)

  userInputService.InputChanged:Connect(function(input2)
    if input2 == v9 and v8 then
      local v10 = input2.Position - position

      p7.Position = UDim2.new(
        position2.X.Scale, position2.X.Offset + v10.X, position2.Y.Scale,
        position2.Y.Offset + v10.Y
      )
    end
  end)
end

local font

pcall(function()
  if not isfolder("CustomLibFiles") then
    makefolder("CustomLibFiles")
  end

  if not isfile("CustomLibFiles/tahoma.ttf") then
    writefile(
      "CustomLibFiles/tahoma.ttf",
      game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/fs-tahoma-8px.ttf")
    )
  end

  local v11 = {
    name = "SmallestPixel7",
    faces = {
      {
        name = "Regular",
        weight = 400,
        style = "normal",
        assetId = getcustomasset("CustomLibFiles/tahoma.ttf"),
      },
    },
  }

  if not isfile("CustomLibFiles/tahoma.json") then
    writefile("CustomLibFiles/tahoma.json", httpService:JSONEncode(v11))
  end

  font = Font.new(getcustomasset("CustomLibFiles/tahoma.json"), Enum.FontWeight.Regular)
end)

local function f7(p9)
  if font then
    pcall(function() p9.FontFace = font end)
  else
    p9.Font = code
  end
end

local f8

local function f9(parent2, p10, p11, p12)
  local v12 = f8("ImageLabel", {
    Name = "GlowEffect",
    Image = "http://www.roblox.com/asset/?id=18245826428",
    ImageColor3 = p10 or v6.Accent,
    ImageTransparency = 0.85,
    BackgroundTransparency = 1,
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(21, 21, 79, 79),
    ZIndex = 0,
    BorderSizePixel = 0,
    Parent = parent2,
  })

  if p11 then
    v12.Position = UDim2.new(0, -20, 0, -20)
    v12.Size = UDim2.new(1, 40, 0, 42)
  else
    v12.Position = UDim2.new(0, -12, 0, -12)
    v12.Size = UDim2.new(1, 24, 1, 24)
  end

  if not p12 then
    table.insert(v7.Image, v12)
  end

  return v12
end

function f8(p13, p14)
  local instance = Instance.new(p13)

  for key5, value6 in pairs(p14) do
    instance[key5] = value6
  end

  table.insert(v1.instances, instance)
  return instance
end

local v13 = f8("ScreenGui", {
  Name = "OverdoseUI",
  ResetOnSpawn = false,
  DisplayOrder = 99999,
  ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
})

pcall(function()
  if gethui then
    v13.Parent = gethui()
  elseif syn and syn.protect_gui then
    syn.protect_gui(v13)
    v13.Parent = coreGui
  else
    v13.Parent = coreGui
  end
end)

if not v13.Parent then
  v13.Parent = players.LocalPlayer:WaitForChild("PlayerGui")
end

v2.SinRender = runService.RenderStepped:Connect(function()
  v1.sin = math.abs(math.sin(tick() * 1.5))
end)

getgenv().ToggleUIKey = Enum.KeyCode.Home

v2.UI = userInputService.InputBegan:Connect(function(input3, p15)
  if getgenv().OverdoseUnloaded then
    return
  end

  if not p15 and input3.KeyCode == getgenv().ToggleUIKey then
    if getgenv().MainGuiFrame then
      getgenv().MainGuiFrame.Visible = not getgenv().MainGuiFrame.Visible
    end
  end
end)

function v1:Notification(p16)
  local v14 = { time = p16.time or 3, text = p16.text or "Success" }

  local function f10()
    for index2, value7 in ipairs(v1.notifications) do
      TweenService:Create(value7, TweenInfo.new(
        0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut
      ), { Position = UDim2.new(0, 20, 0, 72 + (index2 - 1) * 32) }):Play()
    end
  end

  local v15 = f8("Frame", {
    Parent = v13,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, -250, 0, 72 + #v1.notifications * 32),
    Size = UDim2.new(0, 160, 0, 26),
    ZIndex = 10,
  })

  local parent3 = f8("Frame", {
    Parent = v15,
    BackgroundColor3 = v6.BorderOuter,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    Size = UDim2.new(1, 0, 1, 0),
  })

  local v16 = f8("TextLabel", {
    Parent = f8("Frame", {
      Parent = f8("Frame", {
        Parent = parent3,
        Position = UDim2.new(0, 1, 0, 1),
        Size = UDim2.new(1, -2, 1, -2),
        BackgroundColor3 = v6.MainBg,
        BorderSizePixel = 0,
      }),
      Position = UDim2.new(0, 1, 0, 1),
      Size = UDim2.new(1, -2, 1, -2),
      BackgroundColor3 = v6.MainBg,
      BorderColor3 = v6.BorderInner,
      BorderSizePixel = 1,
    }),
    FontFace = font,
    TextColor3 = v6.Text,
    Text = v14.text,
    Size = UDim2.new(1, -12, 1, 0),
    Position = UDim2.new(0, 6, 0, 0),
    BackgroundTransparency = 1,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextSize = 12,
  })

  f7(v16)
  f5(v16)

  f9(f2(f8("Frame", {
    Parent = parent3,
    Size = UDim2.new(0, 2, 1, 0),
    BackgroundColor3 = v6.Accent,
    BorderSizePixel = 0,
  })), v6.Accent, true)

  table.insert(v1.notifications, v15)

  TweenService:Create(
    v15, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
    { Position = UDim2.new(0, 20, 0, 72 + (#v1.notifications - 1) * 32) }
  ):Play()

  task.spawn(function()
    task.wait(v14.time)

    local create = TweenService:Create(v15, TweenInfo.new(
      0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.In
    ), {
      Position = UDim2.new(0, -250, 0, v15.Position.Y.Offset),
    })

    create:Play()
    create.Completed:Wait()

    table.remove(v1.notifications, table.find(v1.notifications, v15))
    f10()
    v15:Destroy()
  end)
end

local v17 = f8("Frame", {
  Parent = v13,
  Position = UDim2.new(0, 20, 0, 20),
  Size = UDim2.new(0, 200, 0, 24),
  BackgroundColor3 = v6.BorderOuter,
  BorderSizePixel = 0,
  Active = true,
})

f6(v17, v17)

local parent4 = f8("Frame", {
  Parent = f8("Frame", {
    Parent = v17,
    Position = UDim2.new(0, 1, 0, 1),
    Size = UDim2.new(1, -2, 1, -2),
    BackgroundColor3 = v6.MainBg,
    BorderSizePixel = 0,
  }),
  Position = UDim2.new(0, 1, 0, 1),
  Size = UDim2.new(1, -2, 1, -2),
  BackgroundColor3 = v6.MainBg,
  BorderColor3 = v6.BorderInner,
  BorderSizePixel = 1,
})

f9(f2(f8("Frame", {
  Parent = parent4,
  Size = UDim2.new(1, 0, 0, 2),
  BackgroundColor3 = v6.Accent,
  BorderSizePixel = 0,
  ZIndex = 3,
})), v6.Accent, true)

local v18 = f8("TextLabel", {
  Parent = parent4,
  Size = UDim2.new(1, 0, 1, 0),
  Position = UDim2.new(0, 8, 0, 0),
  BackgroundTransparency = 1,
  Text = "Overdose.gg | FPS: 0",
  TextColor3 = v6.Text,
  TextSize = 12,
  TextXAlignment = Enum.TextXAlignment.Left,
  ZIndex = 4,
})

f7(v18)
f5(v18)

local v19 = f8("UIGradient", {
  Parent = v18,
  Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
    ColorSequenceKeypoint.new(0.5, v6.Accent),
    ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)),
  }),
})

table.insert(v7.Gradient, v19)
local v20 = tick()
local v21 = 0
local v22 = v20

v2.Watermark = runService.RenderStepped:Connect(function()
  if getgenv().OverdoseUnloaded then
    return
  end

  v21 = v21 + 1

  if tick() - v22 >= 1 then
    v18.Text = string.format("Overdose.gg | FPS: %d", v21)
    v17.Size = UDim2.new(0, v18.TextBounds.X + 16, 0, 24)
    v21 = 0
    v22 = tick()
  end

  v19.Offset = Vector2.new(math.sin(tick() * 2), 0)
end)

local v23 = f8("Frame", {
  Parent = v13,
  Position = UDim2.new(0, 20, 0, 60),
  Size = UDim2.new(0, 180, 0, 24),
  BackgroundColor3 = v6.BorderOuter,
  BorderSizePixel = 0,
  Active = true,
  Visible = false,
})

f6(v23, v23)

local parent5 = f8("Frame", {
  Parent = f8("Frame", {
    Parent = v23,
    Position = UDim2.new(0, 1, 0, 1),
    Size = UDim2.new(1, -2, 1, -2),
    BackgroundColor3 = v6.MainBg,
    BorderSizePixel = 0,
  }),
  Position = UDim2.new(0, 1, 0, 1),
  Size = UDim2.new(1, -2, 1, -2),
  BackgroundColor3 = v6.MainBg,
  BorderColor3 = v6.BorderInner,
  BorderSizePixel = 1,
})

f9(f2(f8("Frame", {
  Parent = parent5,
  Size = UDim2.new(1, 0, 0, 2),
  BackgroundColor3 = v6.Accent,
  BorderSizePixel = 0,
  ZIndex = 3,
})), v6.Accent, true)

local v24 = f8("TextLabel", {
  Parent = parent5,
  Size = UDim2.new(1, 0, 0, 20),
  Position = UDim2.new(0, 0, 0, 2),
  BackgroundTransparency = 1,
  Text = "keybinds",
  TextColor3 = v6.Text,
  TextSize = 12,
  TextXAlignment = Enum.TextXAlignment.Center,
  ZIndex = 4,
})

f7(v24)
f5(v24)

local v25 = f8("Frame", {
  Parent = parent5,
  Position = UDim2.new(0, 0, 0, 24),
  Size = UDim2.new(1, 0, 1, -24),
  BackgroundTransparency = 1,
})

f8("UIListLayout", {
  Parent = v25,
  Padding = UDim.new(0, 2),
  HorizontalAlignment = Enum.HorizontalAlignment.Center,
})

f8("UIPadding", {
  Parent = v25,
  PaddingTop = UDim.new(0, 4),
  PaddingBottom = UDim.new(0, 6),
  PaddingLeft = UDim.new(0, 8),
  PaddingRight = UDim.new(0, 8),
})

function v1:UpdateKeybindList()
  for index3, value8 in ipairs(v25:GetChildren()) do
    if value8:IsA("Frame") then
      value8:Destroy()
    end
  end

  local count = 0
  local text

  for key6, value9 in pairs(self.RegisteredKeybinds) do
    if value9.key and not value9.hide then
      count = count + 1

      local parent6 = f8("Frame", {
        Parent = v25,
        Size = UDim2.new(1, 0, 0, 14),
        BackgroundTransparency = 1,
      })

      local v26 = f8("TextLabel", {
        Parent = parent6,
        Size = UDim2.new(0.5, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = key6,
        TextColor3 = v6.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
      })

      f7(v26)
      f5(v26)
      local textDark = v6.TextDark

      if value9.mode == "always" then
        text = "[always]"
        textDark = v6.Accent
      elseif value9.state then
        text = value9.mode == "hold" and "[hold]" or "[toggled]"
        textDark = v6.Accent
      else
        text = "[none]"
      end

      local v27 = f8("TextLabel", {
        Parent = parent6,
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = textDark,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Right,
      })

      f7(v27)
      f5(v27)

      if textDark == v6.Accent then
        f3(v27)
      end
    end
  end

  v23.Size = UDim2.new(0, 180, 0, 24 + (count > 0 and count * 14 + (count - 1) * 2 + 10 or 0))
end

function v1:SetKeybindsVisible(visible)
  v23.Visible = visible
end

function v1:CreateFloatingGraph(text2, p17, p18)
  local v28 = p17
  local v29 = p18
  v28 = v28 or 0
  v29 = v29 or 100

  local v30 = f8("Frame", {
    Parent = v13,
    Position = UDim2.new(0, 20, 0, 150),
    Size = UDim2.new(0, 200, 0, 90),
    BackgroundColor3 = v6.BorderOuter,
    BorderSizePixel = 0,
    Active = true,
    Visible = false,
  })

  f6(v30, v30)

  local parent7 = f8("Frame", {
    Parent = f8("Frame", {
      Parent = v30,
      Position = UDim2.new(0, 1, 0, 1),
      Size = UDim2.new(1, -2, 1, -2),
      BackgroundColor3 = v6.MainBg,
      BorderSizePixel = 0,
    }),
    Position = UDim2.new(0, 1, 0, 1),
    Size = UDim2.new(1, -2, 1, -2),
    BackgroundColor3 = v6.MainBg,
    BorderColor3 = v6.BorderInner,
    BorderSizePixel = 1,
  })

  f9(f2(f8("Frame", {
    Parent = parent7,
    Size = UDim2.new(1, 0, 0, 2),
    BackgroundColor3 = v6.Accent,
    BorderSizePixel = 0,
    ZIndex = 3,
  })), v6.Accent, true)

  local v31 = f8("TextLabel", {
    Parent = parent7,
    Size = UDim2.new(1, -10, 0, 20),
    Position = UDim2.new(0, 8, 0, 2),
    BackgroundTransparency = 1,
    Text = text2,
    TextColor3 = v6.Text,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 4,
  })

  f7(v31)
  f5(v31)

  local v32 = f8("TextLabel", {
    Parent = parent7,
    Size = UDim2.new(1, -10, 0, 20),
    Position = UDim2.new(0, 0, 0, 2),
    BackgroundTransparency = 1,
    Text = "0",
    TextColor3 = v6.Accent,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Right,
    ZIndex = 4,
  })

  f7(v32)
  f5(v32)
  f3(v32)

  local v33 = f8("Frame", {
    Parent = parent7,
    Position = UDim2.new(0, 6, 0, 24),
    Size = UDim2.new(1, -12, 1, -30),
    BackgroundColor3 = v6.ElementBg,
    BorderColor3 = Color3.fromRGB(56, 56, 56),
    BorderSizePixel = 1,
    ClipsDescendants = true,
  })

  local color = Color3.fromRGB(45, 45, 45)

  for i = 1, 9 do
    f8("Frame", {
      Parent = v33,
      BackgroundColor3 = color,
      BorderSizePixel = 0,
      Size = UDim2.new(0, 1, 1, 0),
      Position = UDim2.new(i / 10, 0, 0, 0),
      ZIndex = 0,
    })
  end

  for j = 1, 3 do
    f8("Frame", {
      Parent = v33,
      BackgroundColor3 = color,
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 0, 1),
      Position = UDim2.new(0, 0, j / 4, 0),
      ZIndex = 0,
    })
  end

  local parent8 = f8("Frame", {
    Parent = v33,
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    ZIndex = 1,
  })

  local v34 = {}
  local v35 = {}
  local v36 = {}
  local count2 = 0

  while true do
    count2 = 1 + count2

    if not (count2 <= 50) then
      break
    end

    local v37 = count2

    local v38 = f8("Frame", {
      Parent = parent8,
      BackgroundColor3 = v6.Accent,
      BackgroundTransparency = 0,
      BorderSizePixel = 0,
      AnchorPoint = Vector2.new(0, 1),
      ZIndex = 1,
      Visible = false,
    })

    f2(v38)
    v35[v37] = v38

    if v37 < 50 then
      local v39 = f8("Frame", {
        Parent = parent8,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = v6.Accent,
        BorderSizePixel = 0,
        ZIndex = 2,
        Visible = false,
      })

      f2(v39)
      v36[v37] = v39
    end
  end

  local v40 = {}

  function v40:SetVisible(visible2)
    v30.Visible = visible2
  end

  function v40:Update(p19)
    local v41 = math.clamp(p19, v28, v29)
    table.insert(v34, v41)

    if #v34 > 50 then
      table.remove(v34, 1)
    end

    v32.Text = string.format("%.2f", v41)
    local y = v33.AbsoluteSize.Y
    local x = v33.AbsoluteSize.X

    if x <= 0 then
      x = 186
      y = 54
    end

    local v42 = x / 49
    local count3 = 0

    while true do
      count3 = 1 + count3

      if not (50 >= count3) then
        break
      end

      local v43 = count3

      if v43 <= #v34 then
        local v44 = y - (v34[v43] - v28) / (v29 - v28) * y
        local v45 = v43 < #v34 and y - (v34[v43 + 1] - v28) / (v29 - v28) * y or v44
        local v46 = (v43 - 1) * v42

        v35[v43].Position = UDim2.new(0, v46, 1, 0)
        v35[v43].Size = UDim2.new(0, math.ceil(v42) + 1, 0, math.max(y - (v44 + v45) / 2, 0))
        v35[v43].Visible = true

        if v43 < #v34 then
          local v47 = v43 * v42
          local v48 = math.sqrt((v47 - v46) ^ 2 + (v45 - v44) ^ 2)
          local v49 = math.deg(math.atan2(v45 - v44, v47 - v46))

          v36[v43].Position = UDim2.new(0, (v46 + v47) / 2, 0, (v44 + v45) / 2)
          v36[v43].Size = UDim2.new(0, math.max(v48 + 1, 1), 0, 2)
          v36[v43].Rotation = v49
          v36[v43].Visible = true
        elseif v43 < 50 then
          v36[v43].Visible = false
        end
      else
        v35[v43].Visible = false

        if v43 < 50 then
          v36[v43].Visible = false
        end
      end
    end
  end

  return v40
end

function v1:CreateRadarWindow(text3)
  local v50 = f8("Frame", {
    Parent = v13,
    Position = UDim2.new(0, 425, 0, 150),
    Size = UDim2.new(0, 180, 0, 180),
    BackgroundColor3 = v6.BorderOuter,
    BorderSizePixel = 0,
    Active = true,
    Visible = false,
  })

  f6(v50, v50)

  local parent9 = f8("Frame", {
    Parent = f8("Frame", {
      Parent = v50,
      Position = UDim2.new(0, 1, 0, 1),
      Size = UDim2.new(1, -2, 1, -2),
      BackgroundColor3 = v6.MainBg,
      BorderSizePixel = 0,
    }),
    Position = UDim2.new(0, 1, 0, 1),
    Size = UDim2.new(1, -2, 1, -2),
    BackgroundColor3 = v6.MainBg,
    BorderColor3 = v6.BorderInner,
    BorderSizePixel = 1,
  })

  f9(f2(f8("Frame", {
    Parent = parent9,
    Size = UDim2.new(1, 0, 0, 2),
    BackgroundColor3 = v6.Accent,
    BorderSizePixel = 0,
    ZIndex = 3,
  })), v6.Accent, true)

  local v51 = f8("TextLabel", {
    Parent = parent9,
    Size = UDim2.new(1, 0, 0, 20),
    Position = UDim2.new(0, 0, 0, 2),
    BackgroundTransparency = 1,
    Text = text3,
    TextColor3 = v6.Text,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Center,
    ZIndex = 4,
  })

  f7(v51)
  f5(v51)

  local parent10 = f8("Frame", {
    Parent = parent9,
    Position = UDim2.new(0, 6, 0, 24),
    Size = UDim2.new(1, -12, 1, -30),
    BackgroundColor3 = v6.ElementBg,
    BorderColor3 = Color3.fromRGB(56, 56, 56),
    BorderSizePixel = 1,
    ClipsDescendants = true,
  })

  f8("Frame", {
    Parent = parent10,
    Position = UDim2.new(0.5, 0, 0, 0),
    Size = UDim2.new(0, 1, 1, 0),
    BackgroundColor3 = Color3.fromRGB(50, 50, 50),
    BorderSizePixel = 0,
  })

  f8("Frame", {
    Parent = parent10,
    Position = UDim2.new(0, 0, 0.5, 0),
    Size = UDim2.new(1, 0, 0, 1),
    BackgroundColor3 = Color3.fromRGB(50, 50, 50),
    BorderSizePixel = 0,
  })

  f9(f2(f8("Frame", {
    Parent = parent10,
    Position = UDim2.new(0.5, -3, 0.5, -3),
    Size = UDim2.new(0, 6, 0, 6),
    BackgroundColor3 = v6.Accent,
    BorderSizePixel = 0,
    ZIndex = 2,
  })), v6.Accent)

  local v52 = {}

  runService.RenderStepped:Connect(function()
    if not v50.Visible then
      return
    else
      local character = localPlayer.Character

      if not character or not character:FindFirstChild("HumanoidRootPart") then
        return
      else
        local position3 = character.HumanoidRootPart.Position
        local lookVector = currentCamera.CFrame.LookVector

        local cframe = CFrame.lookAt(
          position3, position3 + Vector3.new(lookVector.X, 0, lookVector.Z)
        )

        for index4, value10 in ipairs(players:GetPlayers()) do
          if value10 ~= localPlayer and value10.Character
            and value10.Character:FindFirstChild("HumanoidRootPart") then
            local v53 = v52[value10]

            if not v53 then
              local v54 = f8("Frame", {
                Parent = parent10,
                Size = UDim2.new(0, 6, 0, 6),
                BorderSizePixel = 0,
                ZIndex = 2,
              })

              v53 = { frame = v54, glow = f9(v54, Color3.fromRGB(255, 40, 40), false, true) }
              v52[value10] = v53
            end

            local accent = v5[value10.Name] == true and v6.Accent

            local color2 = accent
            color2 = accent or Color3.fromRGB(255, 40, 40)

            v53.frame.BackgroundColor3 = color2
            v53.glow.ImageColor3 = color2

            local pointToObjectSpace = cframe:PointToObjectSpace(value10.Character.HumanoidRootPart.Position)

            v53.frame.Position = UDim2.new(
              0, math.clamp(84 + pointToObjectSpace.X * 0.5, 0, 168), 0,
              math.clamp(84 + pointToObjectSpace.Z * 0.5, 0, 168)
            )

            v53.frame.Visible = true
          elseif v52[value10] then
            v52[value10].frame.Visible = false
          end
        end

        return
      end
    end
  end)

  local v55 = {}

  function v55:SetVisible(visible3)
    v50.Visible = visible3
  end

  return v55
end

function v1:CreateKeystrokesWindow(text4)
  local v56 = f8("Frame", {
    Parent = v13,
    Position = UDim2.new(0, 20, 0, 350),
    Size = UDim2.new(0, 116, 0, 114),
    BackgroundColor3 = v6.BorderOuter,
    BorderSizePixel = 0,
    Active = true,
    Visible = false,
  })

  f6(v56, v56)

  local parent11 = f8("Frame", {
    Parent = f8("Frame", {
      Parent = v56,
      Position = UDim2.new(0, 1, 0, 1),
      Size = UDim2.new(1, -2, 1, -2),
      BackgroundColor3 = v6.MainBg,
      BorderSizePixel = 0,
    }),
    Position = UDim2.new(0, 1, 0, 1),
    Size = UDim2.new(1, -2, 1, -2),
    BackgroundColor3 = v6.MainBg,
    BorderColor3 = v6.BorderInner,
    BorderSizePixel = 1,
  })

  f9(f2(f8("Frame", {
    Parent = parent11,
    Size = UDim2.new(1, 0, 0, 2),
    BackgroundColor3 = v6.Accent,
    BorderSizePixel = 0,
    ZIndex = 3,
  })), v6.Accent, true)

  local v57 = f8("TextLabel", {
    Parent = parent11,
    Size = UDim2.new(1, -10, 0, 20),
    Position = UDim2.new(0, 8, 0, 2),
    BackgroundTransparency = 1,
    Text = text4,
    TextColor3 = v6.Text,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 4,
  })

  f7(v57)
  f5(v57)

  local parent12 = f8("Frame", {
    Parent = parent11,
    Position = UDim2.new(0, 8, 0, 24),
    Size = UDim2.new(1, -16, 1, -24),
    BackgroundTransparency = 1,
  })

  local v58 = {}

  local function f11(p20, position4, p21, p22, p23)
    local v59 = f8("Frame", {
      Parent = parent12,
      Position = position4,
      Size = UDim2.new(0, p21, 0, p22),
      BackgroundColor3 = v6.ElementBg,
      BorderColor3 = Color3.fromRGB(56, 56, 56),
      BorderSizePixel = 1,
      ZIndex = 2,
    })

    local v60 = f8("TextLabel", {
      Parent = v59,
      Size = UDim2.new(1, 0, 1, 0),
      BackgroundTransparency = 1,
      Text = p23 or p20,
      TextColor3 = v6.Text,
      TextSize = 14,
      ZIndex = 3,
    })

    f7(v60)
    f5(v60)

    local v61 = f9(v59, v6.Accent, false, false)
    v61.ZIndex = 1
    v61.ImageTransparency = 0.4
    v61.Size = UDim2.new(1, 24, 1, 24)
    v61.Position = UDim2.new(0, -12, 0, -12)
    v61.Visible = false

    v58[p20] = { bg = v59, txt = v60, glow = v61 }
  end

  f11("W", UDim2.new(0, 34, 0, 4), 30, 30)
  f11("A", UDim2.new(0, 0, 0, 38), 30, 30)
  f11("S", UDim2.new(0, 34, 0, 38), 30, 30)
  f11("D", UDim2.new(0, 68, 0, 38), 30, 30)
  f11("Space", UDim2.new(0, 0, 0, 72), 98, 14, "—")

  local function f12(p24, p25)
    local v62 = v58[p24]

    if v62 then
      if p25 then
        v62.bg.BackgroundColor3 = v6.Accent
        v62.txt.TextColor3 = Color3.new(1, 1, 1)
        v62.glow.Visible = true
      else
        v62.bg.BackgroundColor3 = v6.ElementBg
        v62.txt.TextColor3 = v6.Text
        v62.glow.Visible = false
      end
    end
  end

  userInputService.InputBegan:Connect(function(input4, p26)
    if p26 then
      return
    end

    if input4.KeyCode == Enum.KeyCode.W then
      f12("W", true)
    elseif input4.KeyCode == Enum.KeyCode.A then
      f12("A", true)
    elseif input4.KeyCode == Enum.KeyCode.S then
      f12("S", true)
    elseif input4.KeyCode == Enum.KeyCode.D then
      f12("D", true)
    elseif input4.KeyCode == Enum.KeyCode.Space then
      f12("Space", true)
    end
  end)

  userInputService.InputEnded:Connect(function(input5, p27)
    if input5.KeyCode == Enum.KeyCode.W then
      f12("W", false)
    elseif input5.KeyCode == Enum.KeyCode.A then
      f12("A", false)
    elseif input5.KeyCode == Enum.KeyCode.S then
      f12("S", false)
    elseif input5.KeyCode == Enum.KeyCode.D then
      f12("D", false)
    elseif input5.KeyCode == Enum.KeyCode.Space then
      f12("Space", false)
    end
  end)

  local v63 = {}

  function v63:SetVisible(visible4)
    v56.Visible = visible4
  end

  return v63
end

local v64 = {}

function v1:CreateWindow(text5)
  local v65 = {}

  local v66 = f8("Frame", {
    Parent = v13,
    Size = UDim2.new(0, 700, 0, 480),
    Position = UDim2.new(0.5, -350, 0.5, -240),
    BackgroundColor3 = v6.BorderOuter,
    BorderSizePixel = 0,
    ZIndex = 2,
    Active = true,
  })

  getgenv().MainGuiFrame = v66

  local parent13 = f8("Frame", {
    Parent = f8("Frame", {
      Parent = v66,
      Position = UDim2.new(0, 1, 0, 1),
      Size = UDim2.new(1, -2, 1, -2),
      BackgroundColor3 = v6.MainBg,
      BorderSizePixel = 0,
    }),
    Position = UDim2.new(0, 1, 0, 1),
    Size = UDim2.new(1, -2, 1, -2),
    BackgroundColor3 = v6.MainBg,
    BorderColor3 = v6.BorderInner,
    BorderSizePixel = 1,
  })

  f9(f2(f8("Frame", {
    Parent = parent13,
    Size = UDim2.new(1, 0, 0, 2),
    BackgroundColor3 = v6.Accent,
    BorderSizePixel = 0,
    ZIndex = 3,
  })), v6.Accent, true)

  local v67 = f8("Frame", {
    Parent = parent13,
    Size = UDim2.new(1, 0, 0, 25),
    BackgroundTransparency = 1,
    ZIndex = 5,
  })

  f6(v67, v66)

  local v68 = f8("TextLabel", {
    Parent = v67,
    Size = UDim2.new(1, -10, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1,
    Text = text5,
    TextColor3 = v6.Text,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
  })

  f7(v68)
  f5(v68)

  local v69 = f8("Frame", {
    Parent = parent13,
    Size = UDim2.new(1, -32, 0, 30),
    Position = UDim2.new(0, 16, 0, 4),
    BackgroundTransparency = 1,
  })

  f8("UIListLayout", {
    Parent = v69,
    FillDirection = Enum.FillDirection.Horizontal,
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder,
  })

  local v70 = f8("Frame", {
    Parent = f8("Frame", {
      Parent = parent13,
      Position = UDim2.new(0, 15, 0, 33),
      Size = UDim2.new(1, -30, 1, -48),
      BackgroundColor3 = Color3.fromRGB(19, 19, 19),
      BorderSizePixel = 0,
    }),
    Position = UDim2.new(0, 2, 0, 2),
    Size = UDim2.new(1, -4, 1, -4),
    BackgroundColor3 = v6.SectionBg,
    BorderColor3 = Color3.fromRGB(56, 56, 56),
    BorderSizePixel = 1,
    ClipsDescendants = true,
  })

  local v71 = true

  function v65:CreateTab(text6)
    local v72 = {}

    local v73 = f8("TextButton", {
      Parent = v69,
      Size = UDim2.new(0, 0, 0, 22),
      AutomaticSize = Enum.AutomaticSize.X,
      BackgroundTransparency = 1,
      Text = text6,
      TextColor3 = v71 and v6.Text or v6.TextDark,
      TextSize = 12,
    })

    f8("UIPadding", {
      Parent = v73,
      PaddingLeft = UDim.new(0, 16),
      PaddingRight = UDim.new(0, 16),
    })

    f7(v73)
    f5(v73)

    local v74 = f8("Frame", {
      Parent = v73,
      Position = UDim2.new(0, 0, 1, 0),
      Size = UDim2.new(1, 0, 0, 2),
      BackgroundColor3 = v71 and v6.Accent or v6.BorderInner,
      BorderSizePixel = 0,
    })

    if v71 then
      f2(v74)
      f3(v73)
    end

    local v75 = f8("Frame", {
      Parent = v70,
      Size = UDim2.new(1, -12, 1, -12),
      Position = UDim2.new(0, 6, 0, 6),
      BackgroundTransparency = 1,
      Visible = v71,
      ClipsDescendants = true,
    })

    local v76 = f8("ScrollingFrame", {
      Parent = v75,
      Size = UDim2.new(0.5, -4, 1, 0),
      Position = UDim2.new(0, 0, 0, 0),
      BackgroundTransparency = 1,
      ScrollBarThickness = 0,
      AutomaticCanvasSize = Enum.AutomaticSize.Y,
      CanvasSize = UDim2.new(0, 0, 0, 0),
      ClipsDescendants = true,
    })

    f8("UIListLayout", { Parent = v76, Padding = UDim.new(0, 6) })

    local v77 = f8("ScrollingFrame", {
      Parent = v75,
      Size = UDim2.new(0.5, -4, 1, 0),
      Position = UDim2.new(0.5, 4, 0, 0),
      BackgroundTransparency = 1,
      ScrollBarThickness = 0,
      AutomaticCanvasSize = Enum.AutomaticSize.Y,
      CanvasSize = UDim2.new(0, 0, 0, 0),
      ClipsDescendants = true,
    })

    f8("UIListLayout", { Parent = v77, Padding = UDim.new(0, 6) })

    v73.MouseButton1Click:Connect(function()
      for key7, value11 in pairs(v70:GetChildren()) do
        if value11:IsA("Frame") then
          value11.Visible = false
        end
      end

      for key8, value12 in pairs(v69:GetChildren()) do
        if value12:IsA("TextButton") then
          value12.TextColor3 = v6.TextDark
          value12:FindFirstChildOfClass("Frame").BackgroundColor3 = v6.BorderInner
        end
      end

      v75.Visible = true
      v73.TextColor3 = v6.Text
      v74.BackgroundColor3 = v6.Accent
      f4()
    end)

    v71 = false

    function v72:CreateSection(text7, p28)
      local v78 = {}

      local parent14 = f8("Frame", {
        Parent = f8("Frame", {
          Parent = p28:lower() == "left" and v76 or v77,
          Size = UDim2.new(1, 0, 0, 0),
          BackgroundTransparency = 1,
          AutomaticSize = Enum.AutomaticSize.Y,
        }),
        Position = UDim2.new(0, 0, 0, 4),
        Size = UDim2.new(1, 0, 1, -4),
        BackgroundColor3 = v6.BorderOuter,
        BorderSizePixel = 0,
      })

      local udim = UDim2.new(0, 2, 0, 2)
      local udim2 = UDim2.new(1, -4, 1, -4)
      local color3 = Color3.fromRGB(56, 56, 56)

      local parent15 = f8("Frame", {
        Parent = parent14,
        Position = udim,
        Size = udim2,
        BackgroundColor3 = v6.SectionBg,
        BorderColor3 = color3,
        BorderSizePixel = 1,
      })

      local v79 = f8("TextLabel", {
        Parent = parent14,
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 8, 0, 0),
        BackgroundTransparency = 1,
        Text = text7,
        TextColor3 = v6.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2,
      })

      f7(v79)
      f5(v79)

      local v80 = f8("Frame", {
        Parent = parent15,
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 16),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
      })

      f8("UIListLayout", { Parent = v80, Padding = UDim.new(0, 2) })

      f8("UIPadding", {
        Parent = v80,
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8),
        PaddingTop = UDim.new(0, 2),
        PaddingBottom = UDim.new(0, 8),
      })

      v78.Container = v80

      function v78:CreateToggle(text8, p29, p30)
        local v81 = p29 or false

        local v82 = f8("TextButton", {
          Parent = v80,
          Size = UDim2.new(1, 0, 0, 12),
          BackgroundTransparency = 1,
          Text = "",
          AutoButtonColor = false,
        })

        local v83 = f8("Frame", {
          Parent = v82,
          Size = UDim2.new(0, 10, 0, 10),
          Position = UDim2.new(0, 0, 0, 1),
          BackgroundColor3 = v6.BorderOuter,
          BorderSizePixel = 0,
        })

        local udim3 = UDim2.new(1, -4, 1, -4)
        local udim4 = UDim2.new(0, 2, 0, 2)
        local color4 = Color3.fromRGB(56, 56, 56)

        local v84 = f2(f8("Frame", {
          Parent = f8("Frame", {
            Parent = v83,
            Size = udim3,
            Position = udim4,
            BackgroundColor3 = v6.SectionBg,
            BorderColor3 = color4,
            BorderSizePixel = 1,
          }),
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundColor3 = v6.Accent,
          BorderSizePixel = 0,
          Visible = v81,
          BackgroundTransparency = v81 and 0 or 1,
        }))

        local v85 = f9(v83, v6.Accent)
        v85.Visible = v81

        local v86 = f8("TextLabel", {
          Parent = v82,
          Size = UDim2.new(1, -16, 1, 0),
          Position = UDim2.new(0, 16, 0, 0),
          BackgroundTransparency = 1,
          Text = text8,
          TextColor3 = v6.Text,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
          RichText = true,
        })

        f7(v86)
        f5(v86)

        local v87 = {}

        function v87:SetValue(p31)
          v81 = p31

          v84.Visible = v81
          v84.BackgroundTransparency = v81 and 0 or 1

          v85.Visible = v81

          if p30 then
            p30(v81)
          end
        end

        v82.MouseButton1Click:Connect(function() v87:SetValue(not v81) end)
        return v87
      end

      function v78:CreateButton(text9, p32)
        local v88 = f8("TextButton", {
          Parent = f8("Frame", {
            Parent = v80,
            Size = UDim2.new(1, 0, 0, 18),
            BackgroundColor3 = v6.BorderOuter,
            BorderSizePixel = 0,
          }),
          TextColor3 = v6.Text,
          Text = text9,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = v6.ElementBg,
          BorderColor3 = Color3.fromRGB(56, 56, 56),
          TextSize = 12,
        })

        f7(v88)
        f5(v88)

        v88.MouseButton1Click:Connect(function()
          if p32 then
            p32()
          end
        end)
      end

      function v78:CreateKeybind(p33, p34, p35, p36, p37)
        local v89 = p35
        v89 = p35 or "toggle"

        local keyCode = p34
        local v90 = v89
        local v91 = false
        local v92 = false

        if not p36 then
          v1.RegisteredKeybinds[p33] = { key = keyCode, state = v92, mode = v90 }
          v1:UpdateKeybindList()
        end

        local parent16 = f8("Frame", {
          Parent = v80,
          Size = UDim2.new(1, 0, 0, 12),
          BackgroundTransparency = 1,
        })

        local v93 = f8("TextLabel", {
          Parent = parent16,
          Size = UDim2.new(1, -50, 1, 0),
          BackgroundTransparency = 1,
          Text = p33,
          TextColor3 = v6.Text,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f7(v93)
        f5(v93)

        local v94 = f8("TextButton", {
          Parent = parent16,
          Position = UDim2.new(1, -60, 0, 0),
          Size = UDim2.new(0, 60, 1, 0),
          BackgroundTransparency = 1,
          Text = "[" .. f1(keyCode) .. "]",
          TextColor3 = v6.TextDark,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Right,
        })

        f7(v94)
        f5(v94)

        local v95 = f8("Frame", {
          Parent = v13,
          BackgroundColor3 = v6.BorderOuter,
          BorderSizePixel = 0,
          ZIndex = 100,
          Visible = false,
        })

        local parent17 = f8("Frame", {
          Parent = v95,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = v6.ElementBg,
          BorderColor3 = Color3.fromRGB(56, 56, 56),
          BorderSizePixel = 1,
        })

        f8("UIListLayout", { Parent = parent17, Padding = UDim.new(0, 2) })

        f8("UIPadding", {
          Parent = parent17,
          PaddingBottom = UDim.new(0, 4),
          PaddingTop = UDim.new(0, 2),
        })

        table.insert(v64, v95)
        local v96 = 6

        for index5, value13 in ipairs({ "toggle", "hold", "always" }) do
          local v97 = value13

          local v98 = f8("TextButton", {
            Parent = parent17,
            Size = UDim2.new(1, -4, 0, 14),
            Position = UDim2.new(0, 2, 0, 0),
            Text = v97,
            TextColor3 = v6.Text,
            BackgroundTransparency = 1,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
          })

          f8("UIPadding", { Parent = v98, PaddingLeft = UDim.new(0, 5) })
          f7(v98)
          f5(v98)
          v96 = v96 + 16

          v98.MouseButton1Click:Connect(function()
            v90 = v97
            v95.Visible = false

            if v90 == "always" then
              v92 = true

              if p37 then
                p37(v92, keyCode)
              end
            end

            if not p36 then
              v1.RegisteredKeybinds[p33].mode = v90
              v1.RegisteredKeybinds[p33].state = v92
              v1:UpdateKeybindList()
            end
          end)
        end

        v95.Size = UDim2.new(0, 60, 0, v96)

        v94.MouseButton1Click:Connect(function()
          v91 = true
          v94.Text = "[...]"
        end)

        v94.MouseButton2Click:Connect(function()
          f4(v95)
          v95.Visible = not v95.Visible

          if v95.Visible then
            v95.Position = UDim2.new(0, v94.AbsolutePosition.X, 0, v94.AbsolutePosition.Y + 16)
          end
        end)

        userInputService.InputBegan:Connect(function(input6, p38)
          if v91 then
            if input6.UserInputType == Enum.UserInputType.Keyboard
              and input6.KeyCode ~= Enum.KeyCode.Unknown then
              keyCode = input6.KeyCode
              v94.Text = "[" .. f1(keyCode) .. "]"
              v91 = false
            elseif input6.UserInputType == Enum.UserInputType.MouseButton1
              or input6.UserInputType == Enum.UserInputType.MouseButton2
              or input6.UserInputType == Enum.UserInputType.MouseButton3 then
              keyCode = input6.UserInputType
              v94.Text = "[" .. f1(keyCode) .. "]"
              v91 = false
            end

            if input6.KeyCode == Enum.KeyCode.Escape then
              keyCode = nil
              v94.Text = "[None]"
              v91 = false
            end

            if not p36 then
              v1.RegisteredKeybinds[p33].key = keyCode
              v1:UpdateKeybindList()
            end

            if p36 and p37 then
              p37(v92, keyCode)
            end
          elseif keyCode and not p38 then
            if input6.KeyCode == keyCode or input6.UserInputType == keyCode then
              if v90 == "toggle" then
                v92 = not v92

                if p37 then
                  p37(v92, keyCode)
                end
              elseif v90 == "hold" then
                v92 = true

                if p37 then
                  p37(v92, keyCode)
                end
              end

              if not p36 then
                v1.RegisteredKeybinds[p33].state = v92
                v1:UpdateKeybindList()
              end
            end
          end
        end)

        userInputService.InputEnded:Connect(function(input7, p39)
          if keyCode and not p39 and not v91
            and (input7.KeyCode == keyCode or input7.UserInputType == keyCode) and v90 == "hold" then
            v92 = false

            if p37 then
              p37(v92, keyCode)
            end

            if not p36 then
              v1.RegisteredKeybinds[p33].state = v92
              v1:UpdateKeybindList()
            end
          end
        end)

        local v99 = {}

        function v99:SetValue(p40, p41)
          keyCode = p40
          v90 = p41 or v90
          v94.Text = "[" .. f1(keyCode) .. "]"

          if not p36 then
            v1.RegisteredKeybinds[p33].key = keyCode
            v1.RegisteredKeybinds[p33].mode = v90
            v1:UpdateKeybindList()
          end
        end

        return v99
      end

      function v78:CreateSlider(text10, p42, p43, p44, p45, p46)
        local v100 = p45
        local v101 = p44 or p42
        local v102 = p43 % 1 == 0 and p42 % 1 == 0 and 1 or 0.1
        v100 = v100 or ""

        local parent18 = f8("Frame", {
          Parent = v80,
          Size = UDim2.new(1, 0, 0, 26),
          BackgroundTransparency = 1,
        })

        local v103 = f8("TextLabel", {
          Parent = parent18,
          Size = UDim2.new(1, 0, 0, 12),
          BackgroundTransparency = 1,
          Text = text10,
          TextColor3 = v6.Text,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f7(v103)
        f5(v103)

        local v104 = f8("TextButton", {
          Parent = parent18,
          Position = UDim2.new(0, 0, 0, 14),
          Size = UDim2.new(0, 12, 0, 12),
          BackgroundTransparency = 1,
          Text = "-",
          TextColor3 = v6.Text,
          TextSize = 12,
        })

        local v105 = f8("TextButton", {
          Parent = parent18,
          Position = UDim2.new(1, -12, 0, 14),
          Size = UDim2.new(0, 12, 0, 12),
          BackgroundTransparency = 1,
          Text = "+",
          TextColor3 = v6.Text,
          TextSize = 12,
        })

        f7(v104)
        f5(v104)
        f7(v105)
        f5(v105)

        local v106 = f8("TextButton", {
          Parent = parent18,
          Position = UDim2.new(0, 16, 0, 16),
          Size = UDim2.new(1, -32, 0, 8),
          BackgroundColor3 = v6.BorderOuter,
          BorderSizePixel = 0,
          Text = "",
          AutoButtonColor = false,
        })

        local v107 = f8("Frame", {
          Parent = v106,
          Size = UDim2.new((v101 - p42) / (p43 - p42), 0, 1, 0),
          BackgroundColor3 = Color3.fromRGB(19, 19, 19),
          BorderSizePixel = 0,
          ZIndex = 2,
        })

        f2(f8("Frame", {
          Parent = v107,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, 0, 1, -4),
          BackgroundColor3 = v6.Accent,
          BorderSizePixel = 0,
        }))

        local v108 = v102 == 1

        local v109 = v108
        v109 = v108 and tostring(math.floor(v101 + 0.5))

        local v110 = v109
        v110 = v109 or string.format("%.2f", v101)

        local v111 = f8("TextLabel", {
          Parent = v107,
          FontFace = font,
          TextColor3 = v6.Text,
          Text = v110 .. v100,
          TextStrokeTransparency = 0.5,
          BackgroundTransparency = 1,
          Position = UDim2.new(1, 0, 0, 1),
          Size = UDim2.new(0, 1, 0, 11),
          TextSize = 12,
        })

        f7(v111)
        f5(v111)
        f9(v107, v6.Accent)

        local v112 = {}

        function v112:SetValue(p47)
          v101 = math.clamp(p47, p42, p43)

          if v102 == 1 then
            v101 = math.floor(v101 + 0.5)
          else
            v101 = math.floor(v101 * 100 + 0.5) / 100
          end

          v107.Size = UDim2.new((v101 - p42) / (p43 - p42), 0, 1, 0)
          v111.Text = (v102 == 1 and tostring(v101) or string.format("%.2f", v101)) .. v100

          if p46 then
            p46(v101)
          end
        end

        v104.MouseButton1Click:Connect(function() v112:SetValue(v101 - v102) end)
        v105.MouseButton1Click:Connect(function() v112:SetValue(v101 + v102) end)
        local v113 = false
        v106.MouseButton1Down:Connect(function() v113 = true end)

        userInputService.InputEnded:Connect(function(input8)
          if input8.UserInputType == Enum.UserInputType.MouseButton1 then
            v113 = false
          end
        end)

        userInputService.InputChanged:Connect(function(input9)
          if v113 and input9.UserInputType == Enum.UserInputType.MouseMovement then
            v112:SetValue(p42 + (p43 - p42) * math.clamp(
              (input9.Position.X - v106.AbsolutePosition.X) / v106.AbsoluteSize.X, 0, 1
            ))
          end
        end)

        return v112
      end

      function v78:CreateColorPicker(text11, p48, p49)
        local color5 = p48 or Color3.new(1, 1, 1)
        local v114, v115, v116 = color5:ToHSV()
        local v117 = v115
        local v118 = v116

        local parent19 = f8("Frame", {
          Parent = v80,
          Size = UDim2.new(1, 0, 0, 16),
          BackgroundTransparency = 1,
        })

        local v119 = f8("TextLabel", {
          Parent = parent19,
          Size = UDim2.new(1, -26, 1, 0),
          BackgroundTransparency = 1,
          Text = text11,
          TextColor3 = v6.Text,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f7(v119)
        f5(v119)

        local v120 = f8("TextButton", {
          Parent = parent19,
          Position = UDim2.new(1, -16, 0, 2),
          Size = UDim2.new(0, 16, 0, 10),
          BackgroundColor3 = v6.BorderOuter,
          BorderSizePixel = 0,
          AutoButtonColor = false,
          Text = "",
        })

        local v121 = f8("Frame", {
          Parent = v120,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = color5,
          BorderColor3 = Color3.fromRGB(56, 56, 56),
          BorderSizePixel = 1,
        })

        local v122 = f9(v120, color5, false, true)

        local v123 = f8("Frame", {
          Parent = v13,
          Size = UDim2.new(0, 142, 0, 146),
          BackgroundColor3 = v6.BorderOuter,
          BorderSizePixel = 0,
          ZIndex = 100,
          Visible = false,
        })

        local parent20 = f8("Frame", {
          Parent = v123,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = v6.ElementBg,
          BorderColor3 = Color3.fromRGB(56, 56, 56),
          BorderSizePixel = 1,
        })

        table.insert(v64, v123)

        local v124 = f8("TextButton", {
          Parent = parent20,
          Position = UDim2.new(0, 4, 0, 4),
          Size = UDim2.new(1, -24, 1, -24),
          BackgroundColor3 = v6.BorderOuter,
          BorderSizePixel = 0,
          Text = "",
          AutoButtonColor = false,
        })

        local v125 = f8("Frame", {
          Parent = v124,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = Color3.fromHSV(v114, 1, 1),
          BorderSizePixel = 0,
        })

        local parent21 = f8("Frame", {
          Parent = v125,
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundColor3 = Color3.new(1, 1, 1),
          BorderSizePixel = 0,
          ZIndex = 2,
        })

        f8("UIGradient", {
          Parent = parent21,
          Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1),
          }),
        })

        local parent22 = f8("Frame", {
          Parent = parent21,
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundColor3 = Color3.new(1, 1, 1),
          BorderSizePixel = 0,
        })

        f8("UIGradient", {
          Parent = parent22,
          Rotation = 90,
          Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
            ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0)),
          }),
          Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0),
          }),
        })

        local v126 = f8("Frame", {
          Parent = parent22,
          Size = UDim2.new(0, 2, 0, 2),
          BackgroundColor3 = Color3.new(1, 1, 1),
          BorderColor3 = Color3.new(0, 0, 0),
          BorderSizePixel = 1,
          AnchorPoint = Vector2.new(0.5, 0.5),
        })

        local v127 = f8("TextButton", {
          Parent = parent20,
          Position = UDim2.new(1, -16, 0, 4),
          Size = UDim2.new(0, 12, 1, -24),
          BackgroundColor3 = v6.BorderOuter,
          BorderSizePixel = 0,
          Text = "",
          AutoButtonColor = false,
        })

        local v128 = f8("Frame", {
          Parent = v127,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BorderSizePixel = 0,
          BackgroundColor3 = Color3.new(1, 1, 1),
        })

        f8("UIGradient", {
          Parent = v128,
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

        local v129 = f8("Frame", {
          Parent = v128,
          Size = UDim2.new(1, 0, 0, 2),
          BackgroundColor3 = Color3.new(1, 1, 1),
          BorderColor3 = Color3.new(0, 0, 0),
          BorderSizePixel = 1,
          AnchorPoint = Vector2.new(0, 0.5),
        })

        local function f13(p50)
          color5 = Color3.fromHSV(v114, v117, v118)
          v121.BackgroundColor3 = color5
          v122.ImageColor3 = color5
          v125.BackgroundColor3 = Color3.fromHSV(v114, 1, 1)

          if p50 then
            v126.Position = UDim2.new(v117, 0, 1 - v118, 0)
            v129.Position = UDim2.new(0, 0, 1 - v114, 0)
          end

          if p49 then
            p49(color5)
          end
        end

        f13(true)

        local v130 = false
        local v131 = false
        v124.MouseButton1Down:Connect(function() v130 = true end)
        v127.MouseButton1Down:Connect(function() v131 = true end)

        userInputService.InputEnded:Connect(function(input10)
          if input10.UserInputType == Enum.UserInputType.MouseButton1 then
            v130 = false
            v131 = false
          end
        end)

        userInputService.InputChanged:Connect(function(input11)
          if v130 and input11.UserInputType == Enum.UserInputType.MouseMovement then
            v117 = math.clamp((input11.Position.X - v125.AbsolutePosition.X)
              / v125.AbsoluteSize.X, 0, 1)

            v118 = 1 - math.clamp(
              (input11.Position.Y - v125.AbsolutePosition.Y) / v125.AbsoluteSize.Y, 0, 1
            )

            f13(true)
          elseif v131 and input11.UserInputType == Enum.UserInputType.MouseMovement then
            v114 = 1 - math.clamp(
              (input11.Position.Y - v128.AbsolutePosition.Y) / v128.AbsoluteSize.Y, 0, 1
            )

            f13(true)
          end
        end)

        v120.MouseButton1Click:Connect(function()
          f4(v123)
          v123.Visible = not v123.Visible

          if v123.Visible then
            v123.Position = UDim2.new(
              0, v120.AbsolutePosition.X - 126, 0, v120.AbsolutePosition.Y + 16
            )
          end
        end)

        local v132 = {}

        function v132:SetValue(p51)
          local v133, v134
          v114, v134, v133 = p51:ToHSV()
          v117 = v134
          v118 = v133
          f13(true)
        end

        return v132
      end

      function v78:CreateDualColorPicker(text12, p52, p53, p54, p55)
        local parent23 = f8("Frame", {
          Parent = v80,
          Size = UDim2.new(1, 0, 0, 16),
          BackgroundTransparency = 1,
        })

        local v135 = f8("TextLabel", {
          Parent = parent23,
          Size = UDim2.new(1, -46, 1, 0),
          BackgroundTransparency = 1,
          Text = text12,
          TextColor3 = v6.Text,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f7(v135)
        f5(v135)

        local function f14(p56, p57, p58)
          local color6 = p57 or Color3.new(1, 1, 1)
          local v136, v137, v138 = color6:ToHSV()
          local v139 = v137
          local v140 = v138

          local v141 = f8("TextButton", {
            Parent = parent23,
            Position = UDim2.new(1, p56, 0, 2),
            Size = UDim2.new(0, 16, 0, 10),
            BackgroundColor3 = v6.BorderOuter,
            BorderSizePixel = 0,
            AutoButtonColor = false,
            Text = "",
          })

          local v142 = f8("Frame", {
            Parent = v141,
            Position = UDim2.new(0, 2, 0, 2),
            Size = UDim2.new(1, -4, 1, -4),
            BackgroundColor3 = color6,
            BorderColor3 = Color3.fromRGB(56, 56, 56),
            BorderSizePixel = 1,
          })

          local v143 = f9(v141, color6, false, true)

          local v144 = f8("Frame", {
            Parent = v13,
            Size = UDim2.new(0, 142, 0, 146),
            BackgroundColor3 = v6.BorderOuter,
            BorderSizePixel = 0,
            ZIndex = 100,
            Visible = false,
          })

          local parent24 = f8("Frame", {
            Parent = v144,
            Position = UDim2.new(0, 2, 0, 2),
            Size = UDim2.new(1, -4, 1, -4),
            BackgroundColor3 = v6.ElementBg,
            BorderColor3 = Color3.fromRGB(56, 56, 56),
            BorderSizePixel = 1,
          })

          table.insert(v64, v144)

          local v145 = f8("TextButton", {
            Parent = parent24,
            Position = UDim2.new(0, 4, 0, 4),
            Size = UDim2.new(1, -24, 1, -24),
            BackgroundColor3 = v6.BorderOuter,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
          })

          local v146 = f8("Frame", {
            Parent = v145,
            Position = UDim2.new(0, 2, 0, 2),
            Size = UDim2.new(1, -4, 1, -4),
            BackgroundColor3 = Color3.fromHSV(v136, 1, 1),
            BorderSizePixel = 0,
          })

          local parent25 = f8("Frame", {
            Parent = v146,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = Color3.new(1, 1, 1),
            BorderSizePixel = 0,
            ZIndex = 2,
          })

          f8("UIGradient", {
            Parent = parent25,
            Transparency = NumberSequence.new({
              NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1),
            }),
          })

          local parent26 = f8("Frame", {
            Parent = parent25,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = Color3.new(1, 1, 1),
            BorderSizePixel = 0,
          })

          f8("UIGradient", {
            Parent = parent26,
            Rotation = 90,
            Color = ColorSequence.new({
              ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
              ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0)),
            }),
            Transparency = NumberSequence.new({
              NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0),
            }),
          })

          local v147 = f8("Frame", {
            Parent = parent26,
            Size = UDim2.new(0, 2, 0, 2),
            BackgroundColor3 = Color3.new(1, 1, 1),
            BorderColor3 = Color3.new(0, 0, 0),
            BorderSizePixel = 1,
            AnchorPoint = Vector2.new(0.5, 0.5),
          })

          local v148 = f8("TextButton", {
            Parent = parent24,
            Position = UDim2.new(1, -16, 0, 4),
            Size = UDim2.new(0, 12, 1, -24),
            BackgroundColor3 = v6.BorderOuter,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
          })

          local v149 = f8("Frame", {
            Parent = v148,
            Position = UDim2.new(0, 2, 0, 2),
            Size = UDim2.new(1, -4, 1, -4),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.new(1, 1, 1),
          })

          f8("UIGradient", {
            Parent = v149,
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

          local v150 = f8("Frame", {
            Parent = v149,
            Size = UDim2.new(1, 0, 0, 2),
            BackgroundColor3 = Color3.new(1, 1, 1),
            BorderColor3 = Color3.new(0, 0, 0),
            BorderSizePixel = 1,
            AnchorPoint = Vector2.new(0, 0.5),
          })

          local function f15(p59)
            color6 = Color3.fromHSV(v136, v139, v140)
            v142.BackgroundColor3 = color6
            v143.ImageColor3 = color6
            v146.BackgroundColor3 = Color3.fromHSV(v136, 1, 1)

            if p59 then
              v147.Position = UDim2.new(v139, 0, 1 - v140, 0)
              v150.Position = UDim2.new(0, 0, 1 - v136, 0)
            end

            if p58 then
              p58(color6)
            end
          end

          f15(true)

          local v151 = false
          local v152 = false
          v145.MouseButton1Down:Connect(function() v151 = true end)
          v148.MouseButton1Down:Connect(function() v152 = true end)

          userInputService.InputEnded:Connect(function(input12)
            if input12.UserInputType == Enum.UserInputType.MouseButton1 then
              v151 = false
              v152 = false
            end
          end)

          userInputService.InputChanged:Connect(function(input13)
            if v151 and input13.UserInputType == Enum.UserInputType.MouseMovement then
              v139 = math.clamp((input13.Position.X - v146.AbsolutePosition.X)
                / v146.AbsoluteSize.X, 0, 1)

              v140 = 1 - math.clamp(
                (input13.Position.Y - v146.AbsolutePosition.Y) / v146.AbsoluteSize.Y, 0, 1
              )

              f15(true)
            elseif v152 and input13.UserInputType == Enum.UserInputType.MouseMovement then
              v136 = 1 - math.clamp(
                (input13.Position.Y - v149.AbsolutePosition.Y) / v149.AbsoluteSize.Y, 0, 1
              )

              f15(true)
            end
          end)

          v141.MouseButton1Click:Connect(function()
            f4(v144)
            v144.Visible = not v144.Visible

            if v144.Visible then
              v144.Position = UDim2.new(
                0, v141.AbsolutePosition.X - 126, 0, v141.AbsolutePosition.Y + 16
              )
            end
          end)

          local v153 = {}

          function v153:SetValue(p60)
            local v154, v155
            v136, v155, v154 = p60:ToHSV()
            v139 = v155
            v140 = v154
            f15(true)
          end

          return v153
        end

        local v156 = f14(-36, p52, p54)
        local v157 = f14(-16, p53, p55)

        return {
          SetValues = function(p61, p62, p63)
            v156:SetValue(p62)
            v157:SetValue(p63)
          end,
        }
      end

      function v78:CreateTripleColorPicker(text13, p64, p65, p66, p67, p68, p69)
        local parent27 = f8("Frame", {
          Parent = v80,
          Size = UDim2.new(1, 0, 0, 16),
          BackgroundTransparency = 1,
        })

        local v158 = f8("TextLabel", {
          Parent = parent27,
          Size = UDim2.new(1, -66, 1, 0),
          BackgroundTransparency = 1,
          Text = text13,
          TextColor3 = v6.Text,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f7(v158)
        f5(v158)

        local function f16(p70, p71, p72)
          local color7 = p71 or Color3.new(1, 1, 1)
          local v159, v160, v161 = color7:ToHSV()
          local v162 = v160
          local v163 = v161

          local v164 = f8("TextButton", {
            Parent = parent27,
            Position = UDim2.new(1, p70, 0, 2),
            Size = UDim2.new(0, 16, 0, 10),
            BackgroundColor3 = v6.BorderOuter,
            BorderSizePixel = 0,
            AutoButtonColor = false,
            Text = "",
          })

          local v165 = f8("Frame", {
            Parent = v164,
            Position = UDim2.new(0, 2, 0, 2),
            Size = UDim2.new(1, -4, 1, -4),
            BackgroundColor3 = color7,
            BorderColor3 = Color3.fromRGB(56, 56, 56),
            BorderSizePixel = 1,
          })

          local v166 = f9(v164, color7, false, true)

          local v167 = f8("Frame", {
            Parent = v13,
            Size = UDim2.new(0, 142, 0, 146),
            BackgroundColor3 = v6.BorderOuter,
            BorderSizePixel = 0,
            ZIndex = 100,
            Visible = false,
          })

          local parent28 = f8("Frame", {
            Parent = v167,
            Position = UDim2.new(0, 2, 0, 2),
            Size = UDim2.new(1, -4, 1, -4),
            BackgroundColor3 = v6.ElementBg,
            BorderColor3 = Color3.fromRGB(56, 56, 56),
            BorderSizePixel = 1,
          })

          table.insert(v64, v167)

          local v168 = f8("TextButton", {
            Parent = parent28,
            Position = UDim2.new(0, 4, 0, 4),
            Size = UDim2.new(1, -24, 1, -24),
            BackgroundColor3 = v6.BorderOuter,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
          })

          local v169 = f8("Frame", {
            Parent = v168,
            Position = UDim2.new(0, 2, 0, 2),
            Size = UDim2.new(1, -4, 1, -4),
            BackgroundColor3 = Color3.fromHSV(v159, 1, 1),
            BorderSizePixel = 0,
          })

          local parent29 = f8("Frame", {
            Parent = v169,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = Color3.new(1, 1, 1),
            BorderSizePixel = 0,
            ZIndex = 2,
          })

          f8("UIGradient", {
            Parent = parent29,
            Transparency = NumberSequence.new({
              NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1),
            }),
          })

          local parent30 = f8("Frame", {
            Parent = parent29,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = Color3.new(1, 1, 1),
            BorderSizePixel = 0,
          })

          f8("UIGradient", {
            Parent = parent30,
            Rotation = 90,
            Color = ColorSequence.new({
              ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
              ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0)),
            }),
            Transparency = NumberSequence.new({
              NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0),
            }),
          })

          local v170 = f8("Frame", {
            Parent = parent30,
            Size = UDim2.new(0, 2, 0, 2),
            BackgroundColor3 = Color3.new(1, 1, 1),
            BorderColor3 = Color3.new(0, 0, 0),
            BorderSizePixel = 1,
            AnchorPoint = Vector2.new(0.5, 0.5),
          })

          local v171 = f8("TextButton", {
            Parent = parent28,
            Position = UDim2.new(1, -16, 0, 4),
            Size = UDim2.new(0, 12, 1, -24),
            BackgroundColor3 = v6.BorderOuter,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
          })

          local v172 = f8("Frame", {
            Parent = v171,
            Position = UDim2.new(0, 2, 0, 2),
            Size = UDim2.new(1, -4, 1, -4),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.new(1, 1, 1),
          })

          f8("UIGradient", {
            Parent = v172,
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

          local v173 = f8("Frame", {
            Parent = v172,
            Size = UDim2.new(1, 0, 0, 2),
            BackgroundColor3 = Color3.new(1, 1, 1),
            BorderColor3 = Color3.new(0, 0, 0),
            BorderSizePixel = 1,
            AnchorPoint = Vector2.new(0, 0.5),
          })

          local function f17(p73)
            color7 = Color3.fromHSV(v159, v162, v163)
            v165.BackgroundColor3 = color7
            v166.ImageColor3 = color7
            v169.BackgroundColor3 = Color3.fromHSV(v159, 1, 1)

            if p73 then
              v170.Position = UDim2.new(v162, 0, 1 - v163, 0)
              v173.Position = UDim2.new(0, 0, 1 - v159, 0)
            end

            if p72 then
              p72(color7)
            end
          end

          f17(true)

          local v174 = false
          local v175 = false
          v168.MouseButton1Down:Connect(function() v174 = true end)
          v171.MouseButton1Down:Connect(function() v175 = true end)

          userInputService.InputEnded:Connect(function(input14)
            if input14.UserInputType == Enum.UserInputType.MouseButton1 then
              v174 = false
              v175 = false
            end
          end)

          userInputService.InputChanged:Connect(function(input15)
            if v174 and input15.UserInputType == Enum.UserInputType.MouseMovement then
              v162 = math.clamp((input15.Position.X - v169.AbsolutePosition.X)
                / v169.AbsoluteSize.X, 0, 1)

              v163 = 1 - math.clamp(
                (input15.Position.Y - v169.AbsolutePosition.Y) / v169.AbsoluteSize.Y, 0, 1
              )

              f17(true)
            elseif v175 and input15.UserInputType == Enum.UserInputType.MouseMovement then
              v159 = 1 - math.clamp(
                (input15.Position.Y - v172.AbsolutePosition.Y) / v172.AbsoluteSize.Y, 0, 1
              )

              f17(true)
            end
          end)

          v164.MouseButton1Click:Connect(function()
            f4(v167)
            v167.Visible = not v167.Visible

            if v167.Visible then
              v167.Position = UDim2.new(
                0, v164.AbsolutePosition.X - 126, 0, v164.AbsolutePosition.Y + 16
              )
            end
          end)

          local v176 = {}

          function v176:SetValue(p74)
            local v177
            v159, v162, v177 = p74:ToHSV()
            v163 = v177
            f17(true)
          end

          return v176
        end

        local v178 = f16(-56, p64, p67)
        local v179 = f16(-36, p65, p68)
        local v180 = f16(-16, p66, p69)

        return {
          SetValues = function(p75, p76, p77, p78)
            v178:SetValue(p76)
            v179:SetValue(p77)
            v180:SetValue(p78)
          end,
        }
      end

      function v78:CreateTextbox(text14, placeholderText, p79)
        local parent31 = f8("Frame", {
          Parent = v80,
          Size = UDim2.new(1, 0, 0, 32),
          BackgroundTransparency = 1,
        })

        local v181 = f8("TextLabel", {
          Parent = parent31,
          Size = UDim2.new(1, 0, 0, 12),
          BackgroundTransparency = 1,
          Text = text14,
          TextColor3 = v6.Text,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f7(v181)
        f5(v181)

        local v182 = f8("TextBox", {
          Parent = f8("Frame", {
            Parent = parent31,
            Position = UDim2.new(0, 0, 0, 15),
            Size = UDim2.new(1, 0, 0, 16),
            BackgroundColor3 = v6.BorderOuter,
            BorderSizePixel = 0,
          }),
          TextColor3 = v6.Text,
          Text = "",
          PlaceholderText = placeholderText,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = v6.ElementBg,
          BorderColor3 = Color3.fromRGB(56, 56, 56),
          TextSize = 12,
          ClearTextOnFocus = false,
        })

        f7(v182)
        f5(v182)

        v182.FocusLost:Connect(function()
          if p79 then
            p79(v182.Text)
          end
        end)

        local v183 = {}

        function v183:SetValue(p80)
          v182.Text = p80

          if p79 then
            p79(p80)
          end
        end

        function v183:GetText()
          return v182.Text
        end

        return v183
      end

      function v78:CreateDropdown(text15, p81, p82, p83)
        local v184 = p81
        local v185 = p82 or v184[1]

        local parent32 = f8("Frame", {
          Parent = v80,
          Size = UDim2.new(1, 0, 0, 32),
          BackgroundTransparency = 1,
        })

        local v186 = f8("TextLabel", {
          Parent = parent32,
          Size = UDim2.new(1, 0, 0, 12),
          BackgroundTransparency = 1,
          Text = text15,
          TextColor3 = v6.Text,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f7(v186)
        f5(v186)

        local v187 = f8("Frame", {
          Parent = parent32,
          Position = UDim2.new(0, 0, 0, 15),
          Size = UDim2.new(1, 0, 0, 16),
          BackgroundColor3 = v6.BorderOuter,
          BorderSizePixel = 0,
        })

        local v188 = f8("TextButton", {
          Parent = v187,
          TextColor3 = v6.Text,
          Text = v185 or "",
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = v6.ElementBg,
          BorderColor3 = Color3.fromRGB(56, 56, 56),
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f8("UIPadding", { Parent = v188, PaddingLeft = UDim.new(0, 5) })
        f7(v188)
        f5(v188)

        local v189 = f8("TextLabel", {
          Parent = v188,
          Text = "⌄",
          TextColor3 = v6.Text,
          Size = UDim2.new(0, 10, 1, 0),
          Position = UDim2.new(1, -15, 0, -1),
          BackgroundTransparency = 1,
          TextSize = 12,
        })

        f7(v189)
        f5(v189)

        local v190 = f8("Frame", {
          Parent = v13,
          BackgroundColor3 = v6.BorderOuter,
          BorderSizePixel = 0,
          ZIndex = 100,
          Visible = false,
        })

        local v191 = f8("Frame", {
          Parent = v190,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = v6.ElementBg,
          BorderColor3 = Color3.fromRGB(56, 56, 56),
          BorderSizePixel = 1,
        })

        f8("UIListLayout", { Parent = v191, Padding = UDim.new(0, 2) })

        f8("UIPadding", {
          Parent = v191,
          PaddingBottom = UDim.new(0, 4),
          PaddingTop = UDim.new(0, 2),
        })

        table.insert(v64, v190)

        local function f18()
          for index6, value14 in ipairs(v191:GetChildren()) do
            if value14:IsA("TextButton") then
              value14:Destroy()
            end
          end

          local v192 = 6

          for index7, value15 in ipairs(v184) do
            local v193 = value15

            local v194 = f8("TextButton", {
              Parent = v191,
              Size = UDim2.new(1, -4, 0, 14),
              Position = UDim2.new(0, 2, 0, 0),
              Text = v193,
              TextColor3 = v6.Text,
              BackgroundTransparency = 1,
              TextSize = 12,
              TextXAlignment = Enum.TextXAlignment.Left,
            })

            f8("UIPadding", { Parent = v194, PaddingLeft = UDim.new(0, 5) })
            f7(v194)
            f5(v194)
            v192 = v192 + 16

            v194.MouseButton1Click:Connect(function()
              v185 = v193
              v188.Text = v185
              v190.Visible = false
              v189.Text = "⌄"

              if p83 then
                p83(v185)
              end
            end)
          end

          v190.Size = UDim2.new(0, v187.AbsoluteSize.X, 0, v192)
        end

        v188.MouseButton1Click:Connect(function()
          f4(v190)
          v190.Visible = not v190.Visible
          v189.Text = v190.Visible and "^" or "⌄"

          if v190.Visible then
            f18()

            v190.Position = UDim2.new(
              0, v187.AbsolutePosition.X, 0, v187.AbsolutePosition.Y + v187.AbsoluteSize.Y + 2
            )
          end
        end)

        local v195 = {}

        function v195:SetValue(p84)
          v185 = p84
          v188.Text = v185 or ""

          if p83 then
            p83(v185)
          end
        end

        function v195:Refresh(p85)
          v184 = p85

          if not table.find(v184, v185) and #v184 > 0 then
            v185 = v184[1]
            v188.Text = v185
          elseif #v184 == 0 then
            v185 = nil
            v188.Text = ""
          end

          if v190.Visible then
            f18()
          end
        end

        function v195:GetValue()
          return v185
        end

        return v195
      end

      function v78:CreateLabel(text16)
        local v196 = f8("TextLabel", {
          Parent = f8("Frame", {
            Parent = v80,
            Size = UDim2.new(1, 0, 0, 15),
            BackgroundTransparency = 1,
          }),
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundTransparency = 1,
          Text = text16,
          TextColor3 = v6.TextDark,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
          RichText = true,
        })

        f7(v196)
        f5(v196)
      end

      return v78
    end

    return v72
  end

  return v65
end

local v197 = {}
local count4 = 0

while true do
  count4 = 1 + count4

  if not (4 >= count4) then
    break
  end

  local v198 = count4

  v197[v198] = Drawing.new("Line")
  v197[v198].Thickness = 1
  v197[v198].Visible = false
  v197[v198].ZIndex = 100
end

local v199 = 0

local overdoseWorldColor = lighting:FindFirstChild("OverdoseWorldColor")
  or Instance.new("ColorCorrectionEffect")

overdoseWorldColor.Name = "OverdoseWorldColor"
overdoseWorldColor.Parent = lighting

local overdoseBloom = lighting:FindFirstChild("OverdoseBloom") or Instance.new("BloomEffect")
overdoseBloom.Name = "OverdoseBloom"
overdoseBloom.Parent = lighting

local overdoseSunRays = lighting:FindFirstChild("OverdoseSunRays")
  or Instance.new("SunRaysEffect")

overdoseSunRays.Name = "OverdoseSunRays"
overdoseSunRays.Parent = lighting

local overdoseBlur = lighting:FindFirstChild("OverdoseBlur") or Instance.new("BlurEffect")
overdoseBlur.Name = "OverdoseBlur"
overdoseBlur.Parent = lighting

local v200 = {}
local v201 = false

task.spawn(function()
  while task.wait(0.25) do
    if getgenv().OverdoseUnloaded then
      break
    end

    if v4.WorldColorEnabled then
      overdoseWorldColor.Enabled = true
      overdoseWorldColor.TintColor = v4.WorldColor
      overdoseWorldColor.Contrast = v4.WorldContrast
      overdoseWorldColor.Saturation = v4.WorldSaturation
      overdoseWorldColor.Brightness = v4.WorldBrightness
    else
      overdoseWorldColor.Enabled = false
    end

    if v4.EnableBloom then
      overdoseBloom.Enabled = true
      overdoseBloom.Intensity = v4.BloomIntensity
      overdoseBloom.Size = v4.BloomSize
      overdoseBloom.Threshold = v4.BloomThreshold
    else
      overdoseBloom.Enabled = false
    end

    if v4.EnableSunRays then
      overdoseSunRays.Enabled = true
      overdoseSunRays.Intensity = v4.SunRaysIntensity
      overdoseSunRays.Spread = v4.SunRaysSpread
    else
      overdoseSunRays.Enabled = false
    end

    if v4.EnableBlur then
      overdoseBlur.Enabled = true
      overdoseBlur.Size = v4.BlurSize
    else
      overdoseBlur.Enabled = false
    end

    if v4.CustomFog then
      lighting.FogColor = v4.FogColor
      lighting.FogStart = v4.FogStart
      lighting.FogEnd = v4.FogEnd
    end

    if v4.CustomAmbient then
      lighting.Ambient = v4.Ambient
      lighting.OutdoorAmbient = v4.OutdoorAmbient
    end

    if v4.Fullbright then
      if not v201 then
        v201 = true

        v200.Ambient = lighting.Ambient
        v200.OutdoorAmbient = lighting.OutdoorAmbient
        v200.Brightness = lighting.Brightness
        v200.ClockTime = lighting.ClockTime
        v200.FogEnd = lighting.FogEnd
        v200.GlobalShadows = lighting.GlobalShadows
      end

      lighting.Ambient = Color3.new(1, 1, 1)
      lighting.OutdoorAmbient = Color3.new(1, 1, 1)
      lighting.Brightness = 2
      lighting.ClockTime = 14
      lighting.FogEnd = 100000
      lighting.GlobalShadows = false
    elseif v201 then
      v201 = false

      lighting.Ambient = v200.Ambient
      lighting.OutdoorAmbient = v200.OutdoorAmbient
      lighting.Brightness = v200.Brightness
      lighting.ClockTime = v200.ClockTime
      lighting.FogEnd = v200.FogEnd
      lighting.GlobalShadows = v200.GlobalShadows
    end
  end
end)

task.spawn(function()
  while task.wait(0.25) do
    if getgenv().OverdoseUnloaded then
      break
    elseif v4.AutoReload then
      pcall(function()
        local character2 = localPlayer.Character

        if character2 then
          local tool = character2:FindFirstChildOfClass("Tool")

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

local function f19(p86)
  if not v4.SmartTargeting then
    if not v4.TeamCheck then
      return "Enemy", v4.ColorEnemy
    end

    if p86.Team ~= localPlayer.Team then
      return "Enemy", v4.ColorEnemy
    end

    return "Friendly", v4.ColorFriendly
  end

  if p86 == localPlayer or not p86.Team or not localPlayer.Team then
    return "Friendly", v4.ColorFriendly
  end

  if p86.Team ~= localPlayer.Team then
    return "Enemy", v4.ColorEnemy
  end

  return "Friendly", v4.ColorFriendly
end

local function f20(p87)
  if not p87 then
    return false
  end

  if p87:FindFirstChildOfClass("ForceField") or p87:FindFirstChild("ForceField_TESTING") then
    return false
  elseif p87:FindFirstChild("GRABBING_CONSTRAINT") then
    return false
  else
    local bodyEffects = p87:FindFirstChild("BodyEffects")

    if bodyEffects then
      local kO = bodyEffects:FindFirstChild("K.O")
      local dead = bodyEffects:FindFirstChild("Dead") or bodyEffects:FindFirstChild("SDeath")

      if kO and kO.Value == true or dead and dead.Value == true then
        return false
      end

      return true
    end

    return true
  end
end

local v202 = {}

task.spawn(function()
  while task.wait(0.25) do
    if getgenv().OverdoseUnloaded then
      break
    end

    for index8, value16 in ipairs(players:GetPlayers()) do
      if value16 ~= localPlayer then
        v202[value16] = { Status = f19(value16), Color = select(2, f19(value16)) }
      end
    end
  end
end)

local circle = Drawing.new("Circle")
circle.Thickness = 1
circle.Filled = false

local v203 = {}
local count5 = 0

while true do
  count5 = 1 + count5

  if not (count5 <= 30) then
    break
  end

  local circle2 = Drawing.new("Circle")
  circle2.Radius = 2
  circle2.Filled = true
  circle2.Visible = false

  v203[count5] = circle2
end

local v204 = {}

for k = 1, 8 do
  local line = Drawing.new("Line")
  line.Thickness = 2
  line.Visible = false

  v204[k] = line
end

local v205 = {}
local count6 = 0

while true do
  count6 = 1 + count6

  if not (3 >= count6) then
    break
  end

  local circle3 = Drawing.new("Circle")
  circle3.Thickness = 1
  circle3.Filled = true
  circle3.Visible = false

  v205[count6] = circle3
end

local overdoseESP = Instance.new("ScreenGui")
overdoseESP.Name = "OverdoseESP"
overdoseESP.ResetOnSpawn = false
overdoseESP.IgnoreGuiInset = true

if not pcall(function()
  if gethui then
    overdoseESP.Parent = gethui()
  elseif syn and syn.protect_gui then
    syn.protect_gui(overdoseESP)
    overdoseESP.Parent = coreGui
  else
    overdoseESP.Parent = coreGui
  end
end) then
  overdoseESP.Parent = localPlayer:WaitForChild("PlayerGui")
end

local v206 = {}

local function f21(p88)
  if p88 == localPlayer then
    return
  else
    local v207 = {}
    v207.Container = Instance.new("Folder", overdoseESP)
    v207.Box = Instance.new("Frame", v207.Container)
    v207.Box.BackgroundTransparency = 1
    v207.Box.BorderSizePixel = 0
    v207.BoxLine = Instance.new("Frame", v207.Box)
    v207.BoxLine.Size = UDim2.new(1, 0, 1, 0)
    v207.BoxLine.BackgroundTransparency = 1
    v207.BoxLineStroke = Instance.new("UIStroke", v207.BoxLine)
    v207.BoxLineStroke.Thickness = 1
    v207.BoxLineStroke.Color = Color3.new(1, 1, 1)
    v207.BoxGrad = Instance.new("UIGradient", v207.BoxLineStroke)
    v207.BoxGrad.Rotation = 90
    v207.BoxOutLine = Instance.new("Frame", v207.Box)
    v207.BoxOutLine.Size = UDim2.new(1, 2, 1, 2)
    v207.BoxOutLine.Position = UDim2.new(0, -1, 0, -1)
    v207.BoxOutLine.BackgroundTransparency = 1
    v207.BoxOutLineStroke = Instance.new("UIStroke", v207.BoxOutLine)
    v207.BoxOutLineStroke.Thickness = 1
    v207.BoxOutLineStroke.Color = Color3.new(0, 0, 0)
    v207.BoxInLine = Instance.new("Frame", v207.Box)
    v207.BoxInLine.Size = UDim2.new(1, -2, 1, -2)
    v207.BoxInLine.Position = UDim2.new(0, 1, 0, 1)
    v207.BoxInLine.BackgroundTransparency = 1
    v207.BoxInLineStroke = Instance.new("UIStroke", v207.BoxInLine)
    v207.BoxInLineStroke.Thickness = 1
    v207.BoxInLineStroke.Color = Color3.new(0, 0, 0)
    v207.Fill = Instance.new("Frame", v207.Box)
    v207.Fill.Size = UDim2.new(1, 0, 1, 0)
    v207.Fill.BorderSizePixel = 0
    v207.Fill.BackgroundTransparency = 0.5
    v207.Fill.BackgroundColor3 = Color3.new(1, 1, 1)
    v207.FillGrad = Instance.new("UIGradient", v207.Fill)
    v207.FillGrad.Rotation = 90
    v207.HpBg = Instance.new("Frame", v207.Container)
    v207.HpBg.BackgroundColor3 = Color3.new(0, 0, 0)
    v207.HpBg.BorderSizePixel = 0
    v207.HpCrop = Instance.new("Frame", v207.HpBg)
    v207.HpCrop.BackgroundTransparency = 1
    v207.HpCrop.ClipsDescendants = true
    v207.HpCrop.AnchorPoint = Vector2.new(0, 1)
    v207.HpFill = Instance.new("Frame", v207.HpCrop)
    v207.HpFill.BackgroundColor3 = Color3.new(1, 1, 1)
    v207.HpFill.BorderSizePixel = 0
    v207.HpFill.AnchorPoint = Vector2.new(0, 1)
    v207.HpFill.Position = UDim2.new(0, 0, 1, 0)
    v207.HpGrad = Instance.new("UIGradient", v207.HpFill)
    v207.HpGrad.Rotation = -90
    v207.Name = Instance.new("TextLabel", v207.Container)
    v207.Name.BackgroundTransparency = 1
    v207.Name.TextColor3 = Color3.new(1, 1, 1)
    v207.Name.TextStrokeTransparency = 0
    v207.Name.TextSize = 10

    f7(v207.Name)
    f5(v207.Name)

    v207.Dist = Instance.new("TextLabel", v207.Container)
    v207.Dist.BackgroundTransparency = 1
    v207.Dist.TextColor3 = Color3.new(1, 1, 1)
    v207.Dist.TextStrokeTransparency = 0
    v207.Dist.TextSize = 10
    v207.Dist.TextXAlignment = Enum.TextXAlignment.Left

    f7(v207.Dist)
    f5(v207.Dist)

    v207.Tracer = Drawing.new("Line")
    v207.Tracer.Thickness = 1
    v207.Tracer.Transparency = 1
    v207.Tracer.Visible = false

    v206[p88] = v207
    return
  end
end

for index9, value17 in ipairs(players:GetPlayers()) do
  f21(value17)
end

v2.PlayerAddedConn = players.PlayerAdded:Connect(function(player) f21(player) end)

v2.PlayerRemConn = players.PlayerRemoving:Connect(function(player2)
  if v206[player2] then
    v206[player2].Container:Destroy()

    if v206[player2].Tracer then
      v206[player2].Tracer:Remove()
    end

    v206[player2] = nil
  end

  v202[player2] = nil
end)

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.IgnoreWater = true

local v208 = { nil, nil }

local function f22(p89)
  local humanoidRootPart = p89:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart then
    return nil
  else
    local cframe2 = humanoidRootPart.CFrame
    local cframe3 = CFrame.new(1.25, 3, 0.75)
    local cframe4 = CFrame.new(-1.25, 3, 0.75)
    local cframe5 = CFrame.new(1.25, -3, 0.75)
    local cframe6 = CFrame.new(-1.25, -3, 0.75)
    local cframe7 = CFrame.new(1.25, 3, -0.75)
    local cframe8 = CFrame.new(-1.25, 3, -0.75)
    local cframe9 = CFrame.new(1.25, -3, -0.75)
    local cframe10 = CFrame.new(-1.25, -3, -0.75)
    local x2 = -math.huge
    local y2 = -math.huge
    local huge = math.huge
    local huge2 = math.huge
    local v209 = false

    for index10, value18 in ipairs({
      cframe2 * cframe3, cframe2 * cframe4, cframe2 * cframe5, cframe2 * cframe6,
      cframe2 * cframe7, cframe2 * cframe8, cframe2 * cframe9, cframe2 * cframe10,
    }) do
      local v210, v211 = currentCamera:WorldToViewportPoint(value18.Position)

      if v211 then
        v209 = true
      end

      if v210.X < huge2 then
        huge2 = v210.X
      end

      if v210.X > x2 then
        x2 = v210.X
      end

      if v210.Y < huge then
        huge = v210.Y
      end

      if v210.Y > y2 then
        y2 = v210.Y
      end
    end

    if v209 then
      return Vector2.new(huge2, huge), Vector2.new(x2 - huge2, y2 - huge)
    end

    return nil
  end
end

local f23

local function f24()
  local v212 = {}

  local fovCenter = v4.FOVCenter and currentCamera.ViewportSize / 2
    or userInputService:GetMouseLocation()

  for index11, value19 in ipairs(players:GetPlayers()) do
    if value19 ~= localPlayer and value19.Character then
      if not f20(value19.Character) then
      else
        local findFirstChild = value19.Character:FindFirstChild(v4.TargetPart)
        local humanoid = value19.Character:FindFirstChild("Humanoid")

        if findFirstChild and findFirstChild.Parent and humanoid and humanoid.Health > 0 then
          local v213 = v202[value19]

          if v4.SmartTargeting and v213 and v213.Status ~= "Enemy" then
          else
            local v214, v215 = currentCamera:WorldToViewportPoint(findFirstChild.Position)

            if v215 then
              local magnitude = (Vector2.new(v214.X, v214.Y) - fovCenter).Magnitude

              if magnitude <= v4.FOVRadius then
                table.insert(v212, { part = findFirstChild, dist = magnitude })
              end
            end
          end
        end
      end
    end
  end

  table.sort(v212, function(p90, p91) return p90.dist < p91.dist end)

  for index12, value20 in ipairs(v212) do
    if not v4.WallCheck or f23(value20.part) then
      return value20.part
    end
  end

  return nil
end

function f23(p92)
  if not v4.WallCheck or not localPlayer.Character then
    return true
  else
    local position5 = currentCamera.CFrame.Position

    v208[1] = localPlayer.Character
    v208[2] = p92.Parent

    raycastParams.FilterDescendantsInstances = v208
    return workspace:Raycast(position5, p92.Position - position5, raycastParams) == nil
  end
end

local silentAim

v2.RenderConn = runService.RenderStepped:Connect(function(delta)
  local v216, v217, v218, v219, v220

  if getgenv().OverdoseUnloaded then
    return
  else
    if v4.Crosshair then
      local crosshairCenter = v4.CrosshairCenter and currentCamera.ViewportSize / 2
        or userInputService:GetMouseLocation()

      local crosshairThickness = v4.CrosshairThickness
      local crosshairLength = v4.CrosshairLength
      local crosshairGap = v4.CrosshairGap

      if v4.CrosshairRotate then
        v199 = v199 + v4.CrosshairRotSpeed * delta * 60

        if v199 >= 360 then
          v199 = 0
        end
      else
        v199 = 0
      end

      local v221 = math.rad(v199)
      v217 = math.cos(v221)
      v216 = math.sin(v221)

      local function f25(p93, p94)
        return Vector2.new(
          crosshairCenter.X + (p93 * v217 - p94 * v216),
          crosshairCenter.Y + (p93 * v216 + p94 * v217)
        )
      end

      v197[1].From = f25(0, -crosshairGap)
      v197[1].To = f25(0, -crosshairGap - crosshairLength)
      v197[1].Color = v4.CrosshairColor3
      v197[2].From = f25(0, crosshairGap)
      v197[2].To = f25(0, crosshairGap + crosshairLength)
      v197[2].Color = v4.CrosshairColor4
      v197[3].From = f25(-crosshairGap, 0)
      v197[3].To = f25(-crosshairGap - crosshairLength, 0)
      v197[3].Color = v4.CrosshairColor1
      v197[4].From = f25(crosshairGap, 0)
      v197[4].To = f25(crosshairGap + crosshairLength, 0)
      v197[4].Color = v4.CrosshairColor2

      for m = 1, 4 do
        v197[m].Thickness = crosshairThickness
        v197[m].Visible = true
        v197[m].Transparency = 0.8
      end
    else
      for n = 1, 4 do
        v197[n].Visible = false
      end
    end

    local viewportSize = currentCamera.ViewportSize
    Vector2.new(viewportSize.X / 2, viewportSize.Y)

    if v4.ShowFOV then
      local fovCenter2 = v4.FOVCenter and viewportSize / 2
        or userInputService:GetMouseLocation()

      if v4.FOVType == "Circle" then
        circle.Position = fovCenter2
        circle.Radius = v4.FOVRadius
        circle.Color = v4.FOVColor
        circle.Visible = true

        for i6 = 1, 30 do
          v203[i6].Visible = false
        end
      elseif v4.FOVType == "Dots" then
        circle.Visible = false
        local count7 = 0

        while true do
          count7 = 1 + count7

          if not (count7 <= 30) then
            break
          end

          local v222 = count7
          local v223 = v222 / 30 * math.pi * 2

          v203[v222].Position = Vector2.new(
            fovCenter2.X + math.cos(v223) * v4.FOVRadius,
            fovCenter2.Y + math.sin(v223) * v4.FOVRadius
          )

          v203[v222].Color = v4.FOVColor
          v203[v222].Visible = true
        end
      end
    else
      circle.Visible = false
      local count8 = 0

      while true do
        count8 = 1 + count8

        if not (count8 <= 30) then
          break
        end

        v203[count8].Visible = false
      end
    end

    silentAim = v4.SilentAim and f24() or nil

    if v4.ShowTarget and silentAim and silentAim.Parent then
      local v224
      v220, v224 = currentCamera:WorldToViewportPoint(silentAim.Position)

      if v224 then
        if v4.TargetMarkerStyle == "Corners" then
          local markerSize = v4.MarkerSize
          local markerLength = v4.MarkerLength
          local v225 = tick() * v4.RotationSpeed
          v219 = math.cos(v225)
          v218 = math.sin(v225)

          local function f26(p95, p96)
            return Vector2.new(
              v220.X + (p95 * v219 - p96 * v218), v220.Y + (p95 * v218 + p96 * v219)
            )
          end

          local from = f26(-markerSize, -markerSize)
          local from2 = f26(markerSize, -markerSize)
          local from3 = f26(markerSize, markerSize)
          local from4 = f26(-markerSize, markerSize)

          v204[1].From = from
          v204[1].To = f26(-markerSize + markerLength, -markerSize)
          v204[2].From = from
          v204[2].To = f26(-markerSize, -markerSize + markerLength)
          v204[3].From = from2
          v204[3].To = f26(markerSize - markerLength, -markerSize)
          v204[4].From = from2
          v204[4].To = f26(markerSize, -markerSize + markerLength)
          v204[5].From = from3
          v204[5].To = f26(markerSize - markerLength, markerSize)
          v204[6].From = from3
          v204[6].To = f26(markerSize, markerSize - markerLength)
          v204[7].From = from4
          v204[7].To = f26(-markerSize + markerLength, markerSize)
          v204[8].From = from4
          v204[8].To = f26(-markerSize, markerSize - markerLength)

          for i7 = 1, 8 do
            v204[i7].Visible = true
            v204[i7].Color = v4.TargetColor
          end

          local count9 = 0

          while true do
            count9 = 1 + count9

            if not (3 >= count9) then
              break
            end

            v205[count9].Visible = false
          end
        elseif v4.TargetMarkerStyle == "Orbit" then
          local v226 = v4.MarkerSize + math.sin(tick() * 5) * 5
          local count10 = 0

          while true do
            count10 = 1 + count10

            if not (count10 <= 3) then
              break
            end

            local v227 = count10
            local v228 = tick() * v4.RotationSpeed + v227 * (math.pi * 2 / 3)

            v205[v227].Position = Vector2.new(v220.X, v220.Y)
              + Vector2.new(math.cos(v228), math.sin(v228)) * v226

            v205[v227].Radius = 3
            v205[v227].Color = v4.TargetColor
            v205[v227].Visible = true
          end

          for i8 = 1, 8 do
            v204[i8].Visible = false
          end
        end
      else
        local count11 = 0

        while true do
          count11 = 1 + count11

          if not (8 >= count11) then
            break
          end

          v204[count11].Visible = false
        end

        local count12 = 0

        while true do
          count12 = 1 + count12

          if not (3 >= count12) then
            break
          end

          v205[count12].Visible = false
        end
      end
    else
      local count13 = 0

      while true do
        count13 = 1 + count13

        if not (8 >= count13) then
          break
        end

        v204[count13].Visible = false
      end

      for i9 = 1, 3 do
        v205[i9].Visible = false
      end
    end

    for key9, value21 in pairs(v206) do
      local character3 = key9.Character
      local v229 = true

      if v4.ESPEnabled and character3 and character3.Parent then
        local humanoidRootPart2 = character3:FindFirstChild("HumanoidRootPart")
        local humanoid2 = character3:FindFirstChild("Humanoid")

        if humanoidRootPart2 and humanoid2 and humanoid2.Health > 0 then
          local magnitude2 = (humanoidRootPart2.Position - currentCamera.CFrame.Position).Magnitude

          if magnitude2 <= v4.MaxDistance then
            local v230 = true
            local v231 = v202[key9]
            local status = v231 and v231.Status or "Enemy"
            local v232 = v5[key9.Name] == true

            if v4.ESPTeamCheck and status == "Friendly" and not v232 then
              v230 = false
            end

            if v230 then
              local v233, v234 = f22(character3)

              if v233 and v234 then
                v229 = false

                for index13, value22 in ipairs(value21.Container:GetChildren()) do
                  value22.Visible = true
                end

                value21.Box.Position = UDim2.new(0, v233.X, 0, v233.Y)
                value21.Box.Size = UDim2.new(0, v234.X, 0, v234.Y)

                local box = value21.Box
                box.Visible = v4.DrawBoxes or v4.DrawFill

                value21.BoxLineStroke.Transparency = v4.DrawBoxes and 0 or 1
                value21.BoxOutLineStroke.Transparency = v4.DrawBoxes and 0 or 1
                value21.BoxInLineStroke.Transparency = v4.DrawBoxes and 0 or 1
                value21.Fill.Visible = v4.DrawFill

                if v232 then
                  value21.BoxGrad.Color = ColorSequence.new(v6.Accent)
                  value21.FillGrad.Color = ColorSequence.new(v6.Accent)
                else
                  value21.BoxGrad.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, v4.BoxColors[1]),
                    ColorSequenceKeypoint.new(0.5, v4.BoxColors[2]),
                    ColorSequenceKeypoint.new(1, v4.BoxColors[3]),
                  })

                  value21.FillGrad.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, v4.FillColors[1]),
                    ColorSequenceKeypoint.new(0.5, v4.FillColors[2]),
                    ColorSequenceKeypoint.new(1, v4.FillColors[3]),
                  })
                end

                value21.HpBg.Visible = v4.DrawHealthBar

                if v4.DrawHealthBar then
                  local v235 = math.clamp(humanoid2.Health / humanoid2.MaxHealth, 0, 1)

                  value21.HpBg.Position = UDim2.new(0, v233.X - 5, 0, v233.Y - 1)
                  value21.HpBg.Size = UDim2.new(0, 3, 0, v234.Y + 2)
                  value21.HpCrop.Position = UDim2.new(0, 1, 1, -1)
                  value21.HpCrop.Size = UDim2.new(0, 1, 0, v234.Y * v235)
                  value21.HpFill.Size = UDim2.new(0, 1, 0, v234.Y)

                  value21.HpGrad.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, v4.HpColors[1]),
                    ColorSequenceKeypoint.new(0.5, v4.HpColors[2]),
                    ColorSequenceKeypoint.new(1, v4.HpColors[3]),
                  })
                end

                value21.Name.Visible = v4.DrawNames

                if v4.DrawNames then
                  value21.Name.Text = key9.Name

                  local name = value21.Name
                  name.TextColor3 = v232 and v6.Accent or v4.NameColor

                  value21.Name.Position = UDim2.new(0, v233.X + v234.X / 2, 0, v233.Y - 13)
                end

                value21.Dist.Visible = v4.DrawDistance

                if v4.DrawDistance then
                  value21.Dist.Text = "[" .. math.floor(magnitude2) .. "m]"

                  local dist = value21.Dist
                  dist.TextColor3 = v232 and v6.Accent or v4.DistColor

                  value21.Dist.Position = UDim2.new(
                    0, v233.X + v234.X + 2, 0, v233.Y + v234.Y - 12
                  )
                end

                if v4.DrawTracers then
                  value21.Tracer.Visible = true

                  local tracer = value21.Tracer
                  tracer.Color = v232 and v6.Accent or v4.TracerColor

                  local vector = Vector2.new(
                    currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y
                  )

                  value21.Tracer.From = vector
                  value21.Tracer.To = Vector2.new(v233.X + v234.X / 2, v233.Y + v234.Y)
                else
                  value21.Tracer.Visible = false
                end
              end
            end
          end
        end
      end

      if v229 then
        for index14, value23 in ipairs(value21.Container:GetChildren()) do
          value23.Visible = false
        end

        value21.Tracer.Visible = false
      end
    end

    return
  end
end)

local v236

v236 = hookmetamethod(game, "__namecall", function(p97, ...)
  if getgenv().OverdoseUnloaded then
    return v236(p97, ...)
  else
    local v237 = getnamecallmethod()

    if not checkcaller() then
      if v237 == "Raycast" and v4.SilentAim and silentAim and silentAim.Parent then
        local v238 = { ... }
        local v239 = v238[1]
        local v240 = v238[2]

        if typeof(v239) == "Vector3" and typeof(v240) == "Vector3"
          and v239 ~= currentCamera.CFrame.Position and v240.Magnitude > 20 then
          v238[2] = (silentAim.Position - v239).Unit * v240.Magnitude
          return v236(p97, unpack(v238))
        end

        return v236(p97, ...)
      end

      if v237 == "FireServer" and p97.ClassName == "RemoteEvent" then
        local v241 = { ... }

        if type(v241[1]) == "table" and type(v241[1][1]) == "table" and #v241[1][1] == 3 then
          if v4.SilentAim and silentAim and silentAim.Parent then
            v241[1][1] = { silentAim.Position.X, silentAim.Position.Y, silentAim.Position.Z }
            v241[1][2] = true
            v241[3] = silentAim

            return v236(p97, unpack(v241))
          end
        end

        return v236(p97, ...)
      end

      return v236(p97, ...)
    end

    return v236(p97, ...)
  end
end)

local v242 = {}

local function f27(p98)
  if not v4.JumpCircleEnabled then
    return
  end

  local v243 = {}

  for i10 = 1, 40 do
    local line2 = Drawing.new("Line")
    line2.Thickness = v4.JC_Thickness
    line2.Transparency = 1
    line2.Visible = false

    table.insert(v243, line2)
    table.insert(v242, line2)
  end

  local v244 = tick()

  local connect = nil

  connect = runService.RenderStepped:Connect(function()
    local v245 = tick() - v244
    local v246 = v245 / v4.JC_Duration

    if v246 >= 1 then
      for index15, value24 in ipairs(v243) do
        value24:Remove()
        local v247 = table.find(v242, value24)

        if v247 then
          table.remove(v242, v247)
        end
      end

      connect:Disconnect()
      return
    else
      local v248 = (1 - (1 - v246) ^ 3) * v4.JC_MaxRadius
      local transparency = 1 - v246

      for i11 = 1, 40 do
        local v249 = v243[i11]
        v249.Thickness = v4.JC_Thickness

        local v250 = (i11 - 1) / 40 * math.pi * 2
        local v251 = i11 / 40 * math.pi * 2
        local v252 = math.cos(v250)
        local v253 = math.sin(v250)
        local vector2 = Vector3.new(v252 * v248, 0, v253 * v248)
        local v254 = math.cos(v251)
        local v255 = math.sin(v251)
        local vector3 = Vector3.new(v254 * v248, 0, v255 * v248)
        local v256, v257 = currentCamera:WorldToViewportPoint(p98 + vector2)
        local v258, v259 = currentCamera:WorldToViewportPoint(p98 + vector3)

        if v257 and v259 then
          v249.Visible = true
          v249.From = Vector2.new(v256.X, v256.Y)
          v249.To = Vector2.new(v258.X, v258.Y)

          local v260 = math.sin(v250 + v245 * 6)

          v249.Color = v4.JC_Color1:Lerp(v4.JC_Color2, (v260 + 1) / 2)
          v249.Transparency = transparency
        else
          v249.Visible = false
        end
      end

      return
    end
  end)
end

local function f28(p99)
  local waitForChild = p99:WaitForChild("Humanoid", 5)
  local waitForChild2 = p99:WaitForChild("HumanoidRootPart", 5)

  if waitForChild and waitForChild2 then
    waitForChild.StateChanged:Connect(function(p100, p101)
      if p101 == Enum.HumanoidStateType.Jumping then
        f27(waitForChild2.Position
          - Vector3.new(0, waitForChild.HipHeight + waitForChild2.Size.Y / 2, 0))
      end
    end)
  end
end

if localPlayer.Character then
  f28(localPlayer.Character)
end

v2.CharAdded = localPlayer.CharacterAdded:Connect(f28)
local window = v1:CreateWindow("Overdose.gg | FREE")
local combatTab = window:CreateTab("Combat")
local aimbotSection = combatTab:CreateSection("Aimbot", "Left")

v3.SilentAim = aimbotSection:CreateToggle("Silent Aim", v4.SilentAim, function(silentAim2)
  v4.SilentAim = silentAim2
end)

v3.SmartTargeting = aimbotSection:CreateToggle("Smart Target", v4.SmartTargeting, function(smartTargeting)
  v4.SmartTargeting = smartTargeting
end)

v3.TeamCheck = aimbotSection:CreateToggle("Team Check", v4.TeamCheck, function(teamCheck)
  v4.TeamCheck = teamCheck
end)

v3.WallCheck = aimbotSection:CreateToggle("Wall Check", v4.WallCheck, function(wallCheck)
  v4.WallCheck = wallCheck
end)

v3.TargetPart = aimbotSection:CreateDropdown(
  "Target Part", { "Head", "Torso", "HumanoidRootPart" }, v4.TargetPart,
  function(targetPart) v4.TargetPart = targetPart end
)

v3.AutoReload = aimbotSection:CreateToggle("Auto Reload", v4.AutoReload, function(autoReload)
  v4.AutoReload = autoReload
end)

local targetVisualsSection = combatTab:CreateSection("Target Visuals", "Right")

v3.ShowFOV = targetVisualsSection:CreateToggle("Show FOV", v4.ShowFOV, function(showFOV)
  v4.ShowFOV = showFOV
end)

v3.FOVType = targetVisualsSection:CreateDropdown("FOV Type", { "Circle", "Dots" }, v4.FOVType, function(fovType)
  v4.FOVType = fovType
end)

v3.FOVCenter = targetVisualsSection:CreateToggle("Center FOV", v4.FOVCenter, function(fovCenter3)
  v4.FOVCenter = fovCenter3
end)

v3.FOVColor = targetVisualsSection:CreateColorPicker("FOV Color", v4.FOVColor, function(fovColor)
  v4.FOVColor = fovColor
end)

v3.FOVRadius = targetVisualsSection:CreateSlider("FOV Radius", 10, 500, v4.FOVRadius, " px", function(fovRadius)
  v4.FOVRadius = fovRadius
end)

v3.ShowTarget = targetVisualsSection:CreateToggle("Target Marker", v4.ShowTarget, function(showTarget)
  v4.ShowTarget = showTarget
end)

v3.TargetMarkerStyle = targetVisualsSection:CreateDropdown("Marker Style", { "Corners", "Orbit" }, v4.TargetMarkerStyle, function(targetMarkerStyle)
  v4.TargetMarkerStyle = targetMarkerStyle
end)

v3.TargetColor = targetVisualsSection:CreateColorPicker("Marker Color", v4.TargetColor, function(targetColor)
  v4.TargetColor = targetColor
end)

local worldTab = window:CreateTab("World")
local lightingCCSection = worldTab:CreateSection("Lighting CC", "Left")

v3.Fullbright = lightingCCSection:CreateToggle("Fullbright", v4.Fullbright, function(fullbright)
  v4.Fullbright = fullbright
end)

v3.WorldColorEnabled = lightingCCSection:CreateToggle("Custom CC", v4.WorldColorEnabled, function(worldColorEnabled)
  v4.WorldColorEnabled = worldColorEnabled
end)

v3.WorldColor = lightingCCSection:CreateColorPicker("CC Tint", v4.WorldColor, function(worldColor)
  v4.WorldColor = worldColor
end)

v3.WorldContrast = lightingCCSection:CreateSlider("CC Contrast", -1, 1, v4.WorldContrast, "", function(worldContrast)
  v4.WorldContrast = worldContrast
end)

v3.WorldSaturation = lightingCCSection:CreateSlider("CC Saturation", -1, 1, v4.WorldSaturation, "", function(worldSaturation)
  v4.WorldSaturation = worldSaturation
end)

v3.WorldBrightness = lightingCCSection:CreateSlider("CC Brightness", -1, 1, v4.WorldBrightness, "", function(worldBrightness)
  v4.WorldBrightness = worldBrightness
end)

local specialEffectsSection = worldTab:CreateSection("Special Effects", "Left")

v3.EnableBloom = specialEffectsSection:CreateToggle("Enable Bloom", v4.EnableBloom, function(enableBloom)
  v4.EnableBloom = enableBloom
end)

v3.BloomIntensity = specialEffectsSection:CreateSlider("Bloom Intensity", 0, 10, v4.BloomIntensity, "", function(bloomIntensity)
  v4.BloomIntensity = bloomIntensity
end)

v3.BloomSize = specialEffectsSection:CreateSlider("Bloom Size", 0, 56, v4.BloomSize, " px", function(bloomSize)
  v4.BloomSize = bloomSize
end)

v3.BloomThreshold = specialEffectsSection:CreateSlider("Bloom Threshold", 0, 4, v4.BloomThreshold, "", function(bloomThreshold)
  v4.BloomThreshold = bloomThreshold
end)

v3.EnableSunRays = specialEffectsSection:CreateToggle("Enable SunRays", v4.EnableSunRays, function(enableSunRays)
  v4.EnableSunRays = enableSunRays
end)

v3.SunRaysIntensity = specialEffectsSection:CreateSlider("SunRays Intensity", 0, 1, v4.SunRaysIntensity, "", function(sunRaysIntensity)
  v4.SunRaysIntensity = sunRaysIntensity
end)

v3.SunRaysSpread = specialEffectsSection:CreateSlider("SunRays Spread", 0, 1, v4.SunRaysSpread, "", function(sunRaysSpread)
  v4.SunRaysSpread = sunRaysSpread
end)

v3.EnableBlur = specialEffectsSection:CreateToggle("Enable Blur", v4.EnableBlur, function(enableBlur)
  v4.EnableBlur = enableBlur
end)

v3.BlurSize = specialEffectsSection:CreateSlider("Blur Size", 0, 56, v4.BlurSize, " px", function(blurSize)
  v4.BlurSize = blurSize
end)

local fogAmbientSection = worldTab:CreateSection("Fog & Ambient", "Right")

v3.CustomFog = fogAmbientSection:CreateToggle("Custom Fog", v4.CustomFog, function(customFog)
  v4.CustomFog = customFog
end)

v3.FogColor = fogAmbientSection:CreateColorPicker("Fog Color", v4.FogColor, function(fogColor)
  v4.FogColor = fogColor
end)

v3.FogStart = fogAmbientSection:CreateSlider("Fog Start", 0, 1000, v4.FogStart, " st", function(fogStart)
  v4.FogStart = fogStart
end)

v3.FogEnd = fogAmbientSection:CreateSlider("Fog End", 0, 10000, v4.FogEnd, " st", function(fogEnd)
  v4.FogEnd = fogEnd
end)

v3.CustomAmbient = fogAmbientSection:CreateToggle("Custom Ambient", v4.CustomAmbient, function(customAmbient)
  v4.CustomAmbient = customAmbient
end)

v3.DualAmbient = fogAmbientSection:CreateDualColorPicker("Ambient / Outdoor", v4.Ambient, v4.OutdoorAmbient, function(ambient)
  v4.Ambient = ambient
end, function(outdoorAmbient)
  v4.OutdoorAmbient = outdoorAmbient
end)

local visualsTab = window:CreateTab("Visuals")
local playersESPSection = visualsTab:CreateSection("Players ESP", "Left")

v3.ESPEnabled = playersESPSection:CreateToggle("Enable ESP", v4.ESPEnabled, function(espEnabled)
  v4.ESPEnabled = espEnabled
end)

v3.ESPTeamCheck = playersESPSection:CreateToggle("Hide Team", v4.ESPTeamCheck, function(espTeamCheck)
  v4.ESPTeamCheck = espTeamCheck
end)

v3.MaxDistance = playersESPSection:CreateSlider("Max Distance", 100, 5000, v4.MaxDistance, " st", function(maxDistance)
  v4.MaxDistance = maxDistance
end)

v3.DrawBoxes = playersESPSection:CreateToggle("Draw Boxes", v4.DrawBoxes, function(drawBoxes)
  v4.DrawBoxes = drawBoxes
end)

v3.BoxColors = playersESPSection:CreateTripleColorPicker("Box Colors", v4.BoxColors[1], v4.BoxColors[2], v4.BoxColors[3], function(p102)
  v4.BoxColors[1] = p102
end, function(p103)
  v4.BoxColors[2] = p103
end, function(p104)
  v4.BoxColors[3] = p104
end)

v3.DrawFill = playersESPSection:CreateToggle("Draw Fill", v4.DrawFill, function(drawFill)
  v4.DrawFill = drawFill
end)

v3.FillColors = playersESPSection:CreateTripleColorPicker("Fill Colors", v4.FillColors[1], v4.FillColors[2], v4.FillColors[3], function(p105)
  v4.FillColors[1] = p105
end, function(p106)
  v4.FillColors[2] = p106
end, function(p107)
  v4.FillColors[3] = p107
end)

v3.DrawHealthBar = playersESPSection:CreateToggle("Health Bar", v4.DrawHealthBar, function(drawHealthBar)
  v4.DrawHealthBar = drawHealthBar
end)

v3.HpColors = playersESPSection:CreateTripleColorPicker(
  "HP Colors", v4.HpColors[1], v4.HpColors[2], v4.HpColors[3],
  function(p108) v4.HpColors[1] = p108 end, function(p109) v4.HpColors[2] = p109 end,
  function(p110) v4.HpColors[3] = p110 end
)

v3.DrawNames = playersESPSection:CreateToggle("Draw Names", v4.DrawNames, function(drawNames)
  v4.DrawNames = drawNames
end)

v3.NameColor = playersESPSection:CreateColorPicker("Name Color", v4.NameColor, function(nameColor)
  v4.NameColor = nameColor
end)

v3.DrawDistance = playersESPSection:CreateToggle("Draw Distance", v4.DrawDistance, function(drawDistance)
  v4.DrawDistance = drawDistance
end)

v3.DistColor = playersESPSection:CreateColorPicker("Distance Color", v4.DistColor, function(distColor)
  v4.DistColor = distColor
end)

v3.DrawTracers = playersESPSection:CreateToggle("Tracers", v4.DrawTracers, function(drawTracers)
  v4.DrawTracers = drawTracers
end)

v3.TracerColor = playersESPSection:CreateColorPicker("Tracer Color", v4.TracerColor, function(tracerColor)
  v4.TracerColor = tracerColor
end)

local customCrosshairSection = visualsTab:CreateSection("Custom Crosshair", "Right")

v3.Crosshair = customCrosshairSection:CreateToggle("Enable Crosshair", v4.Crosshair, function(crosshair)
  v4.Crosshair = crosshair
end)

v3.CrosshairCenter = customCrosshairSection:CreateToggle("Center Crosshair", v4.CrosshairCenter, function(crosshairCenter2)
  v4.CrosshairCenter = crosshairCenter2
end)

v3.CrosshairRotate = customCrosshairSection:CreateToggle("Rotate", v4.CrosshairRotate, function(crosshairRotate)
  v4.CrosshairRotate = crosshairRotate
end)

v3.CrosshairRotSpeed = customCrosshairSection:CreateSlider("Rotate Speed", 1, 10, v4.CrosshairRotSpeed, "", function(crosshairRotSpeed)
  v4.CrosshairRotSpeed = crosshairRotSpeed
end)

v3.CrosshairThickness = customCrosshairSection:CreateSlider("Thickness", 1, 10, v4.CrosshairThickness, " px", function(crosshairThickness2)
  v4.CrosshairThickness = crosshairThickness2
end)

v3.CrosshairLength = customCrosshairSection:CreateSlider("Length", 1, 100, v4.CrosshairLength, " px", function(crosshairLength2)
  v4.CrosshairLength = crosshairLength2
end)

v3.CrosshairGap = customCrosshairSection:CreateSlider("Gap", 0, 50, v4.CrosshairGap, " px", function(crosshairGap2)
  v4.CrosshairGap = crosshairGap2
end)

v3.CrosshairColor1 = customCrosshairSection:CreateColorPicker("Color Left", v4.CrosshairColor1, function(crosshairColor1)
  v4.CrosshairColor1 = crosshairColor1
end)

v3.CrosshairColor2 = customCrosshairSection:CreateColorPicker("Color Right", v4.CrosshairColor2, function(crosshairColor2)
  v4.CrosshairColor2 = crosshairColor2
end)

v3.CrosshairColor3 = customCrosshairSection:CreateColorPicker("Color Top", v4.CrosshairColor3, function(crosshairColor3)
  v4.CrosshairColor3 = crosshairColor3
end)

v3.CrosshairColor4 = customCrosshairSection:CreateColorPicker("Color Bottom", v4.CrosshairColor4, function(crosshairColor4)
  v4.CrosshairColor4 = crosshairColor4
end)

local jumpCircleSection = visualsTab:CreateSection("Jump Circle", "Right")

v3.JumpCircleEnabled = jumpCircleSection:CreateToggle("Enable Effect", v4.JumpCircleEnabled, function(jumpCircleEnabled)
  v4.JumpCircleEnabled = jumpCircleEnabled
end)

v3.JC_Colors = jumpCircleSection:CreateDualColorPicker("Color", v4.JC_Color1, v4.JC_Color2, function(jcColor1)
  v4.JC_Color1 = jcColor1
end, function(jcColor2)
  v4.JC_Color2 = jcColor2
end)

v3.JC_Thickness = jumpCircleSection:CreateSlider("Thickness", 1, 5, v4.JC_Thickness, "°", function(jcThickness)
  v4.JC_Thickness = jcThickness
end)

v3.JC_Duration = jumpCircleSection:CreateSlider("Life Time", 0.1, 3, v4.JC_Duration, "°", function(jcDuration)
  v4.JC_Duration = jcDuration
end)

v3.JC_MaxRadius = jumpCircleSection:CreateSlider("Max Radius", 5, 30, v4.JC_MaxRadius, "°", function(jcMaxRadius)
  v4.JC_MaxRadius = jcMaxRadius
end)

window:CreateTab("Other"):CreateSection("Misc", "Left"):CreateLabel("SOON")
local settingsTab = window:CreateTab("Settings")
local movementTrackerFloatingGraph = v1:CreateFloatingGraph("Movement Tracker", 0, 2)
local keystrokesKeystrokesWindow = v1:CreateKeystrokesWindow("Keystrokes")
local radarRadarWindow = v1:CreateRadarWindow("Radar")
local uiElementsSection = settingsTab:CreateSection("UI Elements", "Left")

v3.AccentColor = uiElementsSection:CreateColorPicker("Accent", v4.AccentColor, function(p111)
  v1:ChangeAccent(p111)
end)

uiElementsSection:CreateToggle("Show Keybinds List", false, function(p112)
  v1:SetKeybindsVisible(p112)
end)

uiElementsSection:CreateToggle("Show Movement Graph", false, function(p113)
  movementTrackerFloatingGraph:SetVisible(p113)
end)

uiElementsSection:CreateToggle("Show Keystrokes", false, function(p114)
  keystrokesKeystrokesWindow:SetVisible(p114)
end)

uiElementsSection:CreateToggle("Show Radar", false, function(p115)
  radarRadarWindow:SetVisible(p115)
end)

v3.PanicMod = uiElementsSection:CreateToggle("Panic Mod (Staff Kick)", v4.PanicMod, function(panicMod)
  v4.PanicMod = panicMod
end)

uiElementsSection:CreateKeybind("Toggle Bind", Enum.KeyCode.Home, "toggle", true, function(p116, p117)
  if p117 then
    getgenv().ToggleUIKey = p117
  end
end)

local playerlistFriendsSection = settingsTab:CreateSection("Playerlist & Friends", "Right")
local v261 = {}
local udim5 = UDim2.new(1, 0, 0, 110)

local v262 = f8("ScrollingFrame", {
  Parent = f8("Frame", {
    Parent = playerlistFriendsSection.Container,
    Size = udim5,
    BackgroundTransparency = 1,
  }),
  Size = UDim2.new(1, 0, 1, 0),
  BackgroundTransparency = 1,
  ScrollBarThickness = 2,
  AutomaticCanvasSize = Enum.AutomaticSize.Y,
})

f8("UIListLayout", { Parent = v262, Padding = UDim.new(0, 2) })

f8("UIPadding", {
  Parent = v262,
  PaddingTop = UDim.new(0, 4),
  PaddingBottom = UDim.new(0, 4),
  PaddingLeft = UDim.new(0, 4),
})

local function f29()
  for index16, value25 in ipairs(v262:GetChildren()) do
    if value25:IsA("TextButton") then
      value25:Destroy()
    end
  end

  for index17, value26 in ipairs(players:GetPlayers()) do
    local v263 = value26

    if v263 ~= localPlayer then
      local v264 = v261[v263.Name] == true
      local v265 = v5[v263.Name] == true

      local v266 = f8("TextButton", {
        Parent = v262,
        Size = UDim2.new(1, -8, 0, 18),
        BackgroundColor3 = v264 and v6.Accent or v6.ElementBg,
        Text = " " .. v263.Name .. (v265 and " [FRIEND]" or ""),
        TextColor3 = v264 and Color3.new(1, 1, 1) or v6.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutoButtonColor = false,
        BorderSizePixel = 0,
      })

      f7(v266)

      v266.MouseButton1Click:Connect(function()
        v261[v263.Name] = not v261[v263.Name]
        f29()
      end)
    end
  end
end

v2.FriendAdd = players.PlayerAdded:Connect(f29)

v2.FriendRem = players.PlayerRemoving:Connect(function(player3)
  v261[player3.Name] = nil
  f29()
end)

f29()

playerlistFriendsSection:CreateButton("Make Friend", function()
  local count14 = 0

  for key10, value27 in pairs(v261) do
    v5[key10] = true
    count14 = count14 + 1
  end

  v261 = {}
  f29()
  v1:Notification({ text = "Added " .. count14 .. " to friends", time = 2 })
end)

playerlistFriendsSection:CreateButton("Delete Friend", function()
  local count15 = 0

  for key11, value28 in pairs(v261) do
    v5[key11] = nil
    count15 = count15 + 1
  end

  v261 = {}
  f29()
  v1:Notification({ text = "Removed " .. count15 .. " from friends", time = 2 })
end)

playerlistFriendsSection:CreateButton("Copy Discord Link", function()
  if setclipboard then
    setclipboard("https://discord.gg/kG2EhsgpKM")
  end
end)

if not isfolder("Overdose_Configs") then
  makefolder("Overdose_Configs")
end

local function f30()
  local v267 = {}

  for index18, value29 in ipairs((listfiles("Overdose_Configs"))) do
    local json = value29:match("([^/\\]+)%.json$")

    if json then
      table.insert(v267, json)
    end
  end

  return v267
end

local function f31(p118)
  local v268 = {}

  for key12, value30 in pairs(p118) do
    if typeof(value30) == "Color3" then
      v268[key12] = {
        type = "Color3",
        r = value30.R,
        g = value30.G,
        b = value30.B,
      }
    elseif type(value30) == "table" then
      v268[key12] = f31(value30)
    else
      v268[key12] = value30
    end
  end

  return v268
end

local function f32(p119, p120)
  for key13, value31 in pairs(p119) do
    if type(value31) == "table" and value31.type == "Color3" then
      p120[key13] = Color3.new(value31.r, value31.g, value31.b)
    elseif type(value31) == "table" and p120[key13] and type(p120[key13]) == "table" then
      f32(value31, p120[key13])
    elseif p120[key13] ~= nil then
      p120[key13] = value31
    end
  end
end

local function f33()
  v3.SilentAim:SetValue(v4.SilentAim)
  v3.SmartTargeting:SetValue(v4.SmartTargeting)
  v3.TeamCheck:SetValue(v4.TeamCheck)
  v3.WallCheck:SetValue(v4.WallCheck)
  v3.TargetPart:SetValue(v4.TargetPart)
  v3.AutoReload:SetValue(v4.AutoReload)
  v3.ShowFOV:SetValue(v4.ShowFOV)
  v3.FOVType:SetValue(v4.FOVType)
  v3.FOVCenter:SetValue(v4.FOVCenter)
  v3.FOVColor:SetValue(v4.FOVColor)
  v3.FOVRadius:SetValue(v4.FOVRadius)
  v3.ShowTarget:SetValue(v4.ShowTarget)
  v3.TargetMarkerStyle:SetValue(v4.TargetMarkerStyle)
  v3.TargetColor:SetValue(v4.TargetColor)
  v3.Fullbright:SetValue(v4.Fullbright)
  v3.WorldColorEnabled:SetValue(v4.WorldColorEnabled)
  v3.WorldColor:SetValue(v4.WorldColor)
  v3.WorldContrast:SetValue(v4.WorldContrast)
  v3.WorldSaturation:SetValue(v4.WorldSaturation)
  v3.WorldBrightness:SetValue(v4.WorldBrightness)
  v3.EnableBloom:SetValue(v4.EnableBloom)
  v3.BloomIntensity:SetValue(v4.BloomIntensity)
  v3.BloomSize:SetValue(v4.BloomSize)
  v3.BloomThreshold:SetValue(v4.BloomThreshold)
  v3.EnableSunRays:SetValue(v4.EnableSunRays)
  v3.SunRaysIntensity:SetValue(v4.SunRaysIntensity)
  v3.SunRaysSpread:SetValue(v4.SunRaysSpread)
  v3.EnableBlur:SetValue(v4.EnableBlur)
  v3.BlurSize:SetValue(v4.BlurSize)
  v3.CustomFog:SetValue(v4.CustomFog)
  v3.FogColor:SetValue(v4.FogColor)
  v3.FogStart:SetValue(v4.FogStart)
  v3.FogEnd:SetValue(v4.FogEnd)
  v3.CustomAmbient:SetValue(v4.CustomAmbient)
  v3.DualAmbient:SetValues(v4.Ambient, v4.OutdoorAmbient)
  v3.ESPEnabled:SetValue(v4.ESPEnabled)
  v3.ESPTeamCheck:SetValue(v4.ESPTeamCheck)
  v3.MaxDistance:SetValue(v4.MaxDistance)
  v3.DrawBoxes:SetValue(v4.DrawBoxes)
  v3.BoxColors:SetValues(v4.BoxColors[1], v4.BoxColors[2], v4.BoxColors[3])
  v3.DrawFill:SetValue(v4.DrawFill)
  v3.FillColors:SetValues(v4.FillColors[1], v4.FillColors[2], v4.FillColors[3])
  v3.DrawHealthBar:SetValue(v4.DrawHealthBar)
  v3.HpColors:SetValues(v4.HpColors[1], v4.HpColors[2], v4.HpColors[3])
  v3.DrawNames:SetValue(v4.DrawNames)
  v3.NameColor:SetValue(v4.NameColor)
  v3.DrawDistance:SetValue(v4.DrawDistance)
  v3.DistColor:SetValue(v4.DistColor)
  v3.DrawTracers:SetValue(v4.DrawTracers)
  v3.TracerColor:SetValue(v4.TracerColor)
  v3.Crosshair:SetValue(v4.Crosshair)
  v3.CrosshairCenter:SetValue(v4.CrosshairCenter)
  v3.CrosshairRotate:SetValue(v4.CrosshairRotate)
  v3.CrosshairRotSpeed:SetValue(v4.CrosshairRotSpeed)
  v3.CrosshairThickness:SetValue(v4.CrosshairThickness)
  v3.CrosshairLength:SetValue(v4.CrosshairLength)
  v3.CrosshairGap:SetValue(v4.CrosshairGap)
  v3.CrosshairColor1:SetValue(v4.CrosshairColor1)
  v3.CrosshairColor2:SetValue(v4.CrosshairColor2)
  v3.CrosshairColor3:SetValue(v4.CrosshairColor3)
  v3.CrosshairColor4:SetValue(v4.CrosshairColor4)
  v3.JumpCircleEnabled:SetValue(v4.JumpCircleEnabled)
  v3.JC_Colors:SetValues(v4.JC_Color1, v4.JC_Color2)
  v3.JC_Thickness:SetValue(v4.JC_Thickness)
  v3.JC_Duration:SetValue(v4.JC_Duration)
  v3.JC_MaxRadius:SetValue(v4.JC_MaxRadius)
  v3.AccentColor:SetValue(v4.AccentColor)
  v3.PanicMod:SetValue(v4.PanicMod)
end

local configurationSection = settingsTab:CreateSection("Configuration", "Right")

local configNameTextbox = configurationSection:CreateTextbox("Config Name", "Enter Name...", function()
end)

local selectConfigDropdown = configurationSection:CreateDropdown("Select Config", f30(), "", function()
end)

configurationSection:CreateButton("Create / Save Config", function()
  local getText = configNameTextbox:GetText()

  if getText == "" then
    v1:Notification({ text = "Enter a name first!", time = 2 })
    return
  else
    local jsonEncode = httpService:JSONEncode(f31(v4))
    writefile("Overdose_Configs" .. "/" .. getText .. ".json", jsonEncode)
    selectConfigDropdown:Refresh(f30())
    v1:Notification({ text = "Config saved: " .. getText, time = 2 })
    return
  end
end)

configurationSection:CreateButton("Load Config", function()
  local getValue = selectConfigDropdown:GetValue()

  if getValue and isfile("Overdose_Configs" .. "/" .. getValue .. ".json") then
    f32(httpService:JSONDecode(readfile("Overdose_Configs" .. "/" .. getValue .. ".json")), v4)
    f33()
    v1:Notification({ text = "Loaded config: " .. getValue, time = 2 })
  else
    v1:Notification({ text = "Config not found", time = 2 })
  end
end)

configurationSection:CreateButton("Delete Config", function()
  local getValue2 = selectConfigDropdown:GetValue()

  if getValue2 and isfile("Overdose_Configs" .. "/" .. getValue2 .. ".json") then
    delfile("Overdose_Configs" .. "/" .. getValue2 .. ".json")
    selectConfigDropdown:Refresh(f30())
    v1:Notification({ text = "Deleted config: " .. getValue2, time = 2 })
  end
end)

configurationSection:CreateButton("Refresh List", function()
  selectConfigDropdown:Refresh(f30())
  v1:Notification({ text = "Refreshed", time = 1 })
end)

playerlistFriendsSection:CreateButton("Unload Script", function()
  getgenv().OverdoseUnloaded = true

  if v13 then
    v13:Destroy()
  end

  if overdoseESP then
    overdoseESP:Destroy()
  end

  if overdoseWorldColor then
    overdoseWorldColor:Destroy()
  end

  if overdoseBloom then
    overdoseBloom:Destroy()
  end

  if overdoseSunRays then
    overdoseSunRays:Destroy()
  end

  if overdoseBlur then
    overdoseBlur:Destroy()
  end

  if v201 then
    lighting.Ambient = v200.Ambient
    lighting.OutdoorAmbient = v200.OutdoorAmbient
    lighting.Brightness = v200.Brightness
    lighting.ClockTime = v200.ClockTime
    lighting.FogEnd = v200.FogEnd
    lighting.GlobalShadows = v200.GlobalShadows
  end

  for key14, value32 in pairs(v2) do
    if value32 and typeof(value32) == "RBXScriptConnection" then
      value32:Disconnect()
    end
  end

  for key15, value33 in pairs(v206) do
    if value33.Tracer then
      value33.Tracer:Remove()
    end
  end

  v206 = {}

  if circle then
    circle:Remove()
  end

  local count16 = 0

  while true do
    count16 = 1 + count16

    if not (30 >= count16) then
      break
    end

    local v269 = count16

    if v203[v269] then
      v203[v269]:Remove()
    end
  end

  local count17 = 0

  while true do
    count17 = 1 + count17

    if not (8 >= count17) then
      break
    end

    local v270 = count17

    if v204[v270] then
      v204[v270]:Remove()
    end
  end

  for i12 = 1, 3 do
    if v205[i12] then
      v205[i12]:Remove()
    end
  end

  local count18 = 0

  while true do
    count18 = 1 + count18

    if not (count18 <= 4) then
      break
    end

    local v271 = count18

    if v197[v271] then
      v197[v271]:Remove()
    end
  end

  for index19, value34 in ipairs(v242) do
  end
end)

local total = 0

v2.MovementGraph = runService.RenderStepped:Connect(function(delta2)
  if getgenv().OverdoseUnloaded then
    return
  else
    local character4 = localPlayer.Character

    if character4 and character4:FindFirstChild("Humanoid") then
      local magnitude3 = character4.Humanoid.MoveDirection.Magnitude
      local getState = character4.Humanoid:GetState()

      if getState == Enum.HumanoidStateType.Jumping
        or getState == Enum.HumanoidStateType.Freefall then
        magnitude3 = 2
      end

      total = total + (magnitude3 - total) * math.min(delta2 * 6, 1)
      movementTrackerFloatingGraph:Update(total)
    else
      movementTrackerFloatingGraph:Update(0)
    end

    return
  end
end)
