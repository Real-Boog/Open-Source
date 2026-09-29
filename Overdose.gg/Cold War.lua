local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local lighting = game:GetService("Lighting")
getgenv().OverdoseUnloaded = false
local new = Vector3.new
local new2 = Vector2.new
local fromRGB = Color3.fromRGB
local clamp = math.clamp
local max = math.max
local abs = math.abs
local floor = math.floor
local sin = math.sin
local cos = math.cos
local v1 = task.wait
local v2 = task.delay
local v3 = task.spawn
local v4 = {}
local currentCamera = workspace.CurrentCamera
local localPlayer = players.LocalPlayer

local v5 = {
  MainBg = fromRGB(15, 15, 15),
  SectionBg = fromRGB(20, 20, 20),
  ElementBg = fromRGB(25, 25, 25),
  Border = fromRGB(0, 0, 0),
  Accent = fromRGB(255, 65, 65),
  Text = fromRGB(210, 210, 210),
  TextDark = fromRGB(110, 110, 110),
}

local code = Enum.Font.Code

local v6 = {
  Bg = {},
  Text = {},
  Image = {},
  Stroke = {},
}

local function f1(p1)
  table.insert(v6.Bg, p1)
  return p1
end

local function f2(p2)
  table.insert(v6.Text, p2)
  return p2
end

local function f3(p3)
  table.insert(v6.Image, p3)
  return p3
end

v4.MenuKeybinds = {}
v4.MenuDropdowns = {}

local function f4(parent, p4)
  local glowEffect = f3(Instance.new("ImageLabel"))
  glowEffect.Name = "GlowEffect"
  glowEffect.BackgroundTransparency = 1
  glowEffect.Position = UDim2.new(0, -5, 0, -5)
  glowEffect.Size = UDim2.new(1, 10, 1, 10)
  glowEffect.ZIndex = 0
  glowEffect.Image = "rbxassetid://1316045217"
  glowEffect.ImageColor3 = p4 or v5.Accent
  glowEffect.ImageTransparency = 0.05
  glowEffect.ScaleType = Enum.ScaleType.Slice
  glowEffect.SliceCenter = Rect.new(10, 10, 118, 118)
  glowEffect.Parent = parent

  local uiGradient = Instance.new("UIGradient")
  uiGradient.Rotation = 90

  uiGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3, 0.5),
    NumberSequenceKeypoint.new(0.7, 1), NumberSequenceKeypoint.new(1, 1),
  })

  uiGradient.Parent = glowEffect

  return glowEffect
end

function v4:ChangeAccent(p5)
  v5.Accent = p5

  for key, value in pairs(v6.Bg) do
    if value and value.Parent then
      value.BackgroundColor3 = p5
    end
  end

  for key2, value2 in pairs(v6.Text) do
    if value2 and value2.Parent then
      value2.TextColor3 = p5
    end
  end

  for key3, value3 in pairs(v6.Image) do
    if value3 and value3.Parent then
      value3.ImageColor3 = p5
    end
  end

  for key4, value4 in pairs(v6.Stroke) do
    if value4 and value4.Parent then
      value4.Color = p5
    end
  end

  v4:UpdateKeybindList()

  for index, value5 in ipairs(v4.MenuKeybinds) do
    if value5.state then
      value5.btn.TextColor3 = p5
      value5.txt.TextColor3 = p5
    end
  end

  for index2, value6 in ipairs(v4.MenuDropdowns) do
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

local function f6(parent2)
  local uiStroke = Instance.new("UIStroke")
  uiStroke.Color = Color3.new(0, 0, 0)
  uiStroke.Thickness = 1
  uiStroke.Transparency = 0
  uiStroke.Parent = parent2
end

local function f7(p8, p9)
  local glowEffect2 = f3(Instance.new("ImageLabel"))
  glowEffect2.Name = "GlowEffect"
  glowEffect2.BackgroundTransparency = 1
  glowEffect2.Position = UDim2.new(0, -8, 0, -8)
  glowEffect2.Size = UDim2.new(1, 16, 1, 16)
  glowEffect2.ZIndex = p8.ZIndex - 1
  glowEffect2.Image = "rbxassetid://1316045217"
  glowEffect2.ImageColor3 = p9 or v5.Accent
  glowEffect2.ImageTransparency = 0.05
  glowEffect2.ScaleType = Enum.ScaleType.Slice
  glowEffect2.SliceCenter = Rect.new(10, 10, 118, 118)
  glowEffect2.Parent = p8

  return glowEffect2
end

local function f8(p10, p11)
  local v7 = false
  local inputBegan = p10.InputBegan
  local position, absolutePosition

  inputBegan:Connect(function(p12)
    if p12.UserInputType == Enum.UserInputType.MouseButton1 then
      v7 = true
      position = p12.Position
      absolutePosition = p11.AbsolutePosition
    end
  end)

  userInputService.InputChanged:Connect(function(input)
    if v7 and input.UserInputType == Enum.UserInputType.MouseMovement then
      local v8 = input.Position - position

      p11.Position = UDim2.new(0, clamp(
        absolutePosition.X + v8.X, 0, currentCamera.ViewportSize.X - p11.AbsoluteSize.X
      ), 0, clamp(
        absolutePosition.Y + v8.Y, 0, currentCamera.ViewportSize.Y - p11.AbsoluteSize.Y
      ))
    end
  end)

  userInputService.InputEnded:Connect(function(input2)
    if input2.UserInputType == Enum.UserInputType.MouseButton1 then
      v7 = false
    end
  end)
end

local function f9()
  local text = ""

  for i = 1, 16 do
    text = text .. string.char(math.random(97, 122))
  end

  return text
end

local v9 = f5("ScreenGui", {
  Name = f9(),
  ResetOnSpawn = false,
  DisplayOrder = 99999,
  ZIndexBehavior = Enum.ZIndexBehavior.Global,
})

if not v9.Parent then
  v9.Parent = players.LocalPlayer:WaitForChild("PlayerGui")
end

getgenv().ToggleUIKey = Enum.KeyCode.Home

local connect = userInputService.InputBegan:Connect(function(input3, p13)
  if getgenv().OverdoseUnloaded then
    UIConn:Disconnect()
    return
  end

  if not p13 and input3.KeyCode == getgenv().ToggleUIKey and getgenv().MainGuiFrame then
    getgenv().MainGuiFrame.Visible = not getgenv().MainGuiFrame.Visible
  end
end)

local v10 = f5("Frame", {
  Parent = v9,
  Size = UDim2.new(0, 200, 0, 24),
  Position = UDim2.new(0, 20, 0, 60),
  BackgroundColor3 = v5.MainBg,
  BorderColor3 = v5.Border,
  BorderSizePixel = 1,
  Visible = false,
})

f1(f5("Frame", {
  Parent = v10,
  Size = UDim2.new(1, 0, 0, 1),
  BackgroundColor3 = v5.Accent,
  BorderSizePixel = 0,
}))

f8(v10, v10)
f4(v10, v5.Accent)

f6((f5("TextLabel", {
  Parent = v10,
  Size = UDim2.new(1, 0, 1, 0),
  BackgroundTransparency = 1,
  Text = "KEYBINDS",
  TextColor3 = v5.Text,
  Font = code,
  TextSize = 12,
  TextXAlignment = Enum.TextXAlignment.Center,
})))

local v11 = f5("Frame", {
  Parent = v10,
  Size = UDim2.new(1, 0, 0, 0),
  Position = UDim2.new(0, 0, 0, 25),
  BackgroundTransparency = 1,
  AutomaticSize = Enum.AutomaticSize.Y,
})

f5("UIListLayout", {
  Parent = v11,
  Padding = UDim.new(0, 2),
  SortOrder = Enum.SortOrder.LayoutOrder,
})

f5("UIPadding", {
  Parent = v11,
  PaddingTop = UDim.new(0, 4),
  PaddingLeft = UDim.new(0, 10),
  PaddingBottom = UDim.new(0, 10),
  PaddingRight = UDim.new(0, 10),
})

v4.RegisteredKeybinds = {}

function v4:UpdateKeybindList()
  for index4, value9 in ipairs(v11:GetChildren()) do
    if value9:IsA("Frame") then
      value9:Destroy()
    end
  end

  for key6, value10 in pairs(self.RegisteredKeybinds) do
    if value10.key then
      local parent3 = f5("Frame", {
        Parent = v11,
        Size = UDim2.new(1, 0, 0, 15),
        BackgroundTransparency = 1,
      })

      local v12 = f5("TextLabel", {
        Parent = parent3,
        Size = UDim2.new(0.5, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = key6,
        TextColor3 = v5.Text,
        Font = code,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2,
      })

      local v13 = f5("TextLabel", {
        Parent = parent3,
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = value10.state and "[ON]" or "[OFF]",
        TextColor3 = value10.state and v5.Accent or v5.TextDark,
        Font = code,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Right,
        ZIndex = 2,
      })

      f6(v12)
      f6(v13)

      if value10.state then
        f3((f5("ImageLabel", {
          Parent = f5("Frame", {
            Parent = v13,
            BackgroundTransparency = 1,
            AnchorPoint = new2(1, 0.5),
            Position = UDim2.new(1, 0, 0.5, 0),
            Size = UDim2.new(0, 28, 0, 14),
          }),
          BackgroundTransparency = 1,
          Position = UDim2.new(0, -6, 0, -6),
          Size = UDim2.new(1, 12, 1, 12),
          ZIndex = 0,
          Image = "rbxassetid://1316045217",
          ImageColor3 = v5.Accent,
          ImageTransparency = 0.45,
          ScaleType = Enum.ScaleType.Slice,
          SliceCenter = Rect.new(10, 10, 118, 118),
        })))
      end
    end
  end
end

function v4:SetKeybindsUIVisible(visible)
  v10.Visible = visible
end

local v14 = f5("Frame", {
  Parent = v9,
  Size = UDim2.new(0, 220, 0, 24),
  Position = UDim2.new(0, 20, 0, 20),
  BackgroundColor3 = v5.MainBg,
  BorderColor3 = v5.Border,
  BorderSizePixel = 1,
  Visible = false,
})

f1(f5("Frame", {
  Parent = v14,
  Size = UDim2.new(1, 0, 0, 1),
  BackgroundColor3 = v5.Accent,
  BorderSizePixel = 0,
}))

f8(v14, v14)
f4(v14, v5.Accent)

local v15 = f5("Frame", {
  Parent = f5("Frame", {
    Parent = v14,
    Size = UDim2.new(0, 16, 0, 16),
    Position = UDim2.new(0, 5, 0.5, -8),
    BackgroundTransparency = 1,
  }),
  Size = UDim2.new(1, 0, 1, 0),
  AnchorPoint = new2(0.5, 0.5),
  Position = UDim2.new(0.5, 0, 0.5, 0),
  BackgroundTransparency = 1,
})

local function f10(p14, p15, p16, p17)
  local parent4 = f5("Frame", {
    Parent = v15,
    Size = UDim2.new(0, 4, 0, 4),
    Position = UDim2.new(p17 and 0 or 1, p17 and 0 or -4, p16 and 0 or 1, p16 and 0 or -4),
    BackgroundTransparency = 1,
  })

  f1(f5("Frame", {
    Parent = parent4,
    Size = UDim2.new(1, 0, 0, 1),
    Position = UDim2.new(0, 0, p16 and 0 or 1, p16 and 0 or -1),
    BackgroundColor3 = v5.Accent,
    BorderSizePixel = 0,
  }))

  f1(f5("Frame", {
    Parent = parent4,
    Size = UDim2.new(0, 1, 1, 0),
    Position = UDim2.new(p17 and 0 or 1, p17 and 0 or -1, 0, 0),
    BackgroundColor3 = v5.Accent,
    BorderSizePixel = 0,
  }))
end

f10(0, 0, true, true)
f10(1, 0, true, false)
f10(0, 1, false, true)
f10(1, 1, false, false)

local v16 = f5("TextLabel", {
  Parent = v14,
  Size = UDim2.new(1, -30, 1, 0),
  Position = UDim2.new(0, 28, 0, 0),
  BackgroundTransparency = 1,
  Text = "Overdoze.gg | FPS: 0",
  TextColor3 = v5.Text,
  Font = code,
  TextSize = 12,
  TextXAlignment = Enum.TextXAlignment.Left,
})

f6(v16)
local v17 = tick()
local v18 = 0
local v19 = v17

local connect2 = runService.RenderStepped:Connect(function()
  if getgenv().OverdoseUnloaded then
    WmConn:Disconnect()
    return
  end

  v18 = v18 + 1
  v15.Rotation = v15.Rotation + 0.15

  if tick() - v19 >= 1 then
    v16.Text = string.format("Overdoze.gg | FPS: %d", v18)
    v18 = 0
    v19 = tick()
  end
end)

function v4:CreateWindow(text2)
  local v20 = {}

  local v21 = f5("Frame", {
    Parent = v9,
    Size = UDim2.new(0, 300, 0, 60),
    AnchorPoint = new2(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    BackgroundColor3 = v5.MainBg,
    BorderColor3 = v5.Border,
    BorderSizePixel = 1,
  })

  f1(f5("Frame", {
    Parent = v21,
    Size = UDim2.new(1, 0, 0, 1),
    BackgroundColor3 = v5.Accent,
    BorderSizePixel = 0,
  }))

  f4(v21, v5.Accent)

  f6((f5("TextLabel", {
    Parent = v21,
    Size = UDim2.new(1, 0, 0, 30),
    BackgroundTransparency = 1,
    Text = "Loading Overdoze.gg...",
    TextColor3 = v5.Text,
    Font = code,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Center,
  })))

  local v22 = f1(f5("Frame", {
    Parent = f5("Frame", {
      Parent = v21,
      Size = UDim2.new(1, -20, 0, 4),
      Position = UDim2.new(0, 10, 0, 35),
      BackgroundColor3 = v5.SectionBg,
      BorderColor3 = v5.Border,
      BorderSizePixel = 1,
    }),
    Size = UDim2.new(0, 0, 1, 0),
    BackgroundColor3 = v5.Accent,
    BorderSizePixel = 0,
  }))

  f7(v22, v5.Accent)

  local v23 = f5("Frame", {
    Parent = v9,
    Size = UDim2.new(0, 800, 0, 500),
    Position = UDim2.new(0.5, -400, 0.5, -250),
    BackgroundColor3 = v5.MainBg,
    BorderColor3 = v5.Border,
    BorderSizePixel = 1,
    Visible = false,
  })

  getgenv().MainGuiFrame = v23

  tweenService:Create(v22, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Size = UDim2.new(1, 0, 1, 0),
  }):Play()

  v2(1.7, function()
    if v21 then
      v21:Destroy()
    end

    if v23 then
      v23.Visible = true
    end

    if v14 then
      v14.Visible = true
    end
  end)

  local v24 = f5("Frame", {
    Parent = v23,
    Size = UDim2.new(1, 0, 0, 25),
    BackgroundColor3 = v5.MainBg,
    BorderColor3 = v5.Border,
    BorderSizePixel = 1,
  })

  f8(v24, v23)

  f6((f5("TextLabel", {
    Parent = v24,
    Size = UDim2.new(1, -10, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1,
    Text = text2,
    TextColor3 = v5.Text,
    Font = code,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
  })))

  local v25 = f5("Frame", {
    Parent = v23,
    Size = UDim2.new(1, 0, 0, 30),
    Position = UDim2.new(0, 0, 0, 25),
    BackgroundColor3 = v5.MainBg,
    BorderColor3 = v5.Border,
    BorderSizePixel = 1,
  })

  f5("UIListLayout", {
    Parent = v25,
    FillDirection = Enum.FillDirection.Horizontal,
    SortOrder = Enum.SortOrder.LayoutOrder,
  })

  local v26 = f5("Folder", { Parent = v23, Name = "Pages" })
  local v27 = true

  function v20:CreateTab(text3)
    local v28 = {}

    local v29 = f5("TextButton", {
      Parent = v25,
      Size = UDim2.new(0, 100, 1, 0),
      BackgroundTransparency = 1,
      Text = text3,
      TextColor3 = v27 and v5.Text or v5.TextDark,
      Font = code,
      TextSize = 13,
    })

    f6(v29)

    if v27 then
      f2(v29)
    end

    local v30 = f5("Frame", {
      Parent = v26,
      Size = UDim2.new(1, 0, 1, -55),
      Position = UDim2.new(0, 0, 0, 55),
      BackgroundTransparency = 1,
      Visible = v27,
    })

    local v31 = f5("ScrollingFrame", {
      Parent = v30,
      Size = UDim2.new(0.5, -15, 1, -20),
      Position = UDim2.new(0, 10, 0, 10),
      BackgroundTransparency = 1,
      ScrollBarThickness = 2,
      CanvasSize = UDim2.new(0, 0, 0, 0),
      AutomaticCanvasSize = Enum.AutomaticSize.Y,
    })

    f5("UIListLayout", {
      Parent = v31,
      Padding = UDim.new(0, 10),
      SortOrder = Enum.SortOrder.LayoutOrder,
    })

    local v32 = f5("ScrollingFrame", {
      Parent = v30,
      Size = UDim2.new(0.5, -15, 1, -20),
      Position = UDim2.new(0.5, 5, 0, 10),
      BackgroundTransparency = 1,
      ScrollBarThickness = 2,
      CanvasSize = UDim2.new(0, 0, 0, 0),
      AutomaticCanvasSize = Enum.AutomaticSize.Y,
    })

    f5("UIListLayout", {
      Parent = v32,
      Padding = UDim.new(0, 10),
      SortOrder = Enum.SortOrder.LayoutOrder,
    })

    v29.MouseButton1Click:Connect(function()
      for key7, value11 in pairs(v26:GetChildren()) do
        value11.Visible = false
      end

      for key8, value12 in pairs(v25:GetChildren()) do
        if value12:IsA("TextButton") then
          value12.TextColor3 = v5.TextDark
        end
      end

      v30.Visible = true
      v29.TextColor3 = v5.Accent
    end)

    v27 = false

    function v28:CreateSection(p18, p19)
      local v33 = {}

      local parent5 = f5("Frame", {
        Parent = p19:lower() == "left" and v31 or v32,
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundColor3 = v5.SectionBg,
        BorderColor3 = v5.Border,
        BorderSizePixel = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
      })

      f1(f5("Frame", {
        Parent = parent5,
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = v5.Accent,
        BorderSizePixel = 0,
      }))

      f6((f5("TextLabel", {
        Parent = parent5,
        Size = UDim2.new(1, -10, 0, 20),
        Position = UDim2.new(0, 10, 0, 2),
        BackgroundTransparency = 1,
        Text = "- " .. p18 .. " -",
        TextColor3 = v5.Text,
        Font = code,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
      })))

      local parent6 = f5("Frame", {
        Parent = parent5,
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 25),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
      })

      f5("UIListLayout", {
        Parent = parent6,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
      })

      f5("UIPadding", {
        Parent = parent6,
        PaddingTop = UDim.new(0, 2),
        PaddingLeft = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
      })

      function v33:CreateToggle(p20, p21, p22)
        local v34 = p21 or false

        local parent7 = f5("Frame", {
          Parent = parent6,
          Size = UDim2.new(1, 0, 0, 15),
          BackgroundTransparency = 1,
        })

        local v35 = f5("Frame", {
          Parent = parent7,
          Size = UDim2.new(0, 10, 0, 10),
          Position = UDim2.new(0, 0, 0.5, -5),
          BackgroundColor3 = v5.ElementBg,
          BorderColor3 = v5.Border,
          BorderSizePixel = 1,
        })

        local v36 = f1(f5("Frame", {
          Parent = v35,
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundColor3 = v5.Accent,
          BorderSizePixel = 0,
          Visible = v34,
        }))

        local v37 = f7(v35, v5.Accent)
        v37.Visible = v34

        local v38 = f5("TextLabel", {
          Parent = parent7,
          Size = UDim2.new(1, -20, 1, 0),
          Position = UDim2.new(0, 15, 0, 0),
          BackgroundTransparency = 1,
          Text = p20,
          TextColor3 = v34 and v5.Text or v5.TextDark,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
          RichText = true,
        })

        f6(v38)

        f5("TextButton", {
          Parent = parent7,
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundTransparency = 1,
          Text = "",
        }).MouseButton1Click:Connect(function()
          v34 = not v34
          v36.Visible = v34
          v37.Visible = v34

          if not string.find(p20, "<font") then
            v38.TextColor3 = v34 and v5.Text or v5.TextDark
          end

          if p22 then
            p22(v34)
          end
        end)
      end

      function v33:CreateSlider(text4, p23, p24, p25, p26)
        local v39 = p25 or p23

        local parent8 = f5("Frame", {
          Parent = parent6,
          Size = UDim2.new(1, 0, 0, 30),
          BackgroundTransparency = 1,
        })

        local v40 = f5("TextLabel", {
          Parent = parent8,
          Size = UDim2.new(1, 0, 0, 15),
          BackgroundTransparency = 1,
          Text = text4,
          TextColor3 = v5.Text,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        local v41 = f5("TextLabel", {
          Parent = parent8,
          Size = UDim2.new(1, 0, 0, 15),
          BackgroundTransparency = 1,
          Text = tostring(v39),
          TextColor3 = v5.Text,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Right,
        })

        f6(v40)
        f6(v41)

        local v42 = f5("Frame", {
          Parent = parent8,
          Size = UDim2.new(1, 0, 0, 4),
          Position = UDim2.new(0, 0, 0, 20),
          BackgroundColor3 = v5.ElementBg,
          BorderColor3 = v5.Border,
          BorderSizePixel = 1,
        })

        local v43 = f1(f5("Frame", {
          Parent = v42,
          Size = UDim2.new((v39 - p23) / (p24 - p23), 0, 1, 0),
          BackgroundColor3 = v5.Accent,
          BorderSizePixel = 0,
        }))

        f7(v43, v5.Accent)

        local v44 = f5("TextButton", {
          Parent = v42,
          Size = UDim2.new(1, 0, 1, 20),
          Position = UDim2.new(0, 0, 0.5, -10),
          BackgroundTransparency = 1,
          Text = "",
        })

        local v45 = false
        v44.MouseButton1Down:Connect(function() v45 = true end)

        userInputService.InputEnded:Connect(function(input4)
          if input4.UserInputType == Enum.UserInputType.MouseButton1 then
            v45 = false
          end
        end)

        userInputService.InputChanged:Connect(function(input5)
          if v45 and input5.UserInputType == Enum.UserInputType.MouseMovement then
            local v46 = clamp(
              (input5.Position.X - v42.AbsolutePosition.X) / v42.AbsoluteSize.X, 0, 1
            )

            v39 = floor(p23 + (p24 - p23) * v46)
            v43.Size = UDim2.new(v46, 0, 1, 0)
            v41.Text = tostring(v39)

            if p26 then
              p26(v39)
            end
          end
        end)
      end

      function v33.CreateDropdown(p27, text5, p28, p29)
        local parent9 = f5("Frame", {
          Parent = parent6,
          Size = UDim2.new(1, 0, 0, 0),
          BackgroundTransparency = 1,
          AutomaticSize = Enum.AutomaticSize.Y,
        })

        f5("UIListLayout", {
          Parent = parent9,
          Padding = UDim.new(0, 2),
          SortOrder = Enum.SortOrder.LayoutOrder,
        })

        f6((f5("TextLabel", {
          Parent = parent9,
          Size = UDim2.new(1, 0, 0, 15),
          BackgroundTransparency = 1,
          Text = text5,
          TextColor3 = v5.Text,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })))

        local v47 = f5("TextButton", {
          Parent = parent9,
          Size = UDim2.new(1, 0, 0, 20),
          BackgroundColor3 = v5.ElementBg,
          BorderColor3 = v5.Border,
          BorderSizePixel = 1,
          Text = "  " .. p28[1],
          TextColor3 = v5.Text,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f1(f5("Frame", {
          Parent = v47,
          Size = UDim2.new(0, 2, 1, 0),
          BackgroundColor3 = v5.Accent,
          BorderSizePixel = 0,
        }))

        f6(v47)

        local v48 = f5("TextLabel", {
          Parent = v47,
          Size = UDim2.new(0, 20, 1, 0),
          Position = UDim2.new(1, -20, 0, 0),
          BackgroundTransparency = 1,
          Text = "▼",
          TextColor3 = v5.TextDark,
          Font = code,
          TextSize = 12,
        })

        f6(v48)

        local v49 = f5("Frame", {
          Parent = parent9,
          Size = UDim2.new(1, 0, 0, 0),
          BackgroundColor3 = v5.ElementBg,
          BorderColor3 = v5.Border,
          BorderSizePixel = 1,
          Visible = false,
          AutomaticSize = Enum.AutomaticSize.Y,
        })

        f5("UIListLayout", { Parent = v49, SortOrder = Enum.SortOrder.LayoutOrder })
        local v50 = { isOpen = false, current = p28[1], options = {} }
        table.insert(v4.MenuDropdowns, v50)

        for index5, value13 in ipairs(p28) do
          local v51 = value13

          local v52 = f5("TextButton", {
            Parent = v49,
            Size = UDim2.new(1, 0, 0, 20),
            BackgroundTransparency = 1,
            Text = "  " .. v51,
            TextColor3 = v5.TextDark,
            Font = code,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
          })

          f6(v52)
          table.insert(v50.options, { btn = v52, name = v51 })

          v52.MouseButton1Click:Connect(function()
            v50.current = v51
            v47.Text = "  " .. v51
            v49.Visible = false
            v50.isOpen = false
            v48.Text = "▼"

            if p29 then
              p29(v51)
            end
          end)

          v52.MouseEnter:Connect(function()
            if v50.current ~= v51 then
              v52.TextColor3 = v5.Text
            end
          end)

          v52.MouseLeave:Connect(function()
            if v50.current ~= v51 then
              v52.TextColor3 = v5.TextDark
            end
          end)
        end

        v47.MouseButton1Click:Connect(function()
          v49.Visible = not v49.Visible
          v50.isOpen = v49.Visible
          v48.Text = v49.Visible and "▲" or "▼"

          if v49.Visible then
            for index6, value14 in ipairs(v50.options) do
              local btn = value14.btn
              btn.TextColor3 = value14.name == v50.current and v5.Accent or v5.TextDark
            end
          end
        end)
      end

      function v33:CreateKeybind(p30, p31, p32, p33)
        local keyCode = p31
        local v53 = false
        local v54 = false

        if not p33 then
          v4.RegisteredKeybinds[p30] = { key = keyCode, state = v54 }
          v4:UpdateKeybindList()
        end

        local parent10 = f5("Frame", {
          Parent = parent6,
          Size = UDim2.new(1, 0, 0, 15),
          BackgroundTransparency = 1,
        })

        local v55 = f5("TextLabel", {
          Parent = parent10,
          Size = UDim2.new(0.5, 0, 1, 0),
          BackgroundTransparency = 1,
          Text = p30,
          TextColor3 = v5.Text,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f6(v55)

        local v56 = f5("TextButton", {
          Parent = parent10,
          Size = UDim2.new(0.5, 0, 1, 0),
          Position = UDim2.new(0.5, 0, 0, 0),
          BackgroundTransparency = 1,
          Text = keyCode and "[ " .. keyCode.Name .. " ]" or "[ NONE ]",
          TextColor3 = v5.TextDark,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Right,
        })

        f6(v56)
        local v57 = { btn = v56, txt = v55, state = false }
        table.insert(v4.MenuKeybinds, v57)

        v56.MouseButton1Click:Connect(function()
          v53 = true
          v56.Text = "[ ... ]"
          v56.TextColor3 = v5.Accent
        end)

        userInputService.InputBegan:Connect(function(input6, p34)
          if v53 and input6.UserInputType == Enum.UserInputType.Keyboard then
            if input6.KeyCode == Enum.KeyCode.Escape then
              keyCode = nil
              v56.Text = "[ NONE ]"
            else
              keyCode = input6.KeyCode
              v56.Text = "[ " .. keyCode.Name .. " ]"
            end

            v56.TextColor3 = v5.TextDark
            v55.TextColor3 = v5.Text
            v53 = false

            if not p33 then
              v4.RegisteredKeybinds[p30].key = keyCode
              v4:UpdateKeybindList()
            end

            if p33 and p32 then
              p32(v54, keyCode)
            end
          elseif not v53 and keyCode and input6.KeyCode == keyCode and not p34 then
            v54 = not v54
            v57.state = v54

            if v54 then
              v56.TextColor3 = v5.Accent
              v55.TextColor3 = v5.Accent
            else
              v56.TextColor3 = v5.TextDark
              v55.TextColor3 = v5.Text
            end

            if not p33 then
              v4.RegisteredKeybinds[p30].state = v54
              v4:UpdateKeybindList()
            end

            if p32 then
              p32(v54, keyCode)
            end
          end
        end)
      end

      function v33:CreateColorPicker(text6, p35, p36, p37)
        local color = p35 or Color3.new(1, 1, 1)
        local v58, v59, v60 = Color3.toHSV(color)
        local v61 = v59
        local v62 = v60

        local parent11 = f5("Frame", {
          Parent = parent6,
          Size = UDim2.new(1, 0, 0, 0),
          BackgroundTransparency = 1,
          AutomaticSize = Enum.AutomaticSize.Y,
        })

        f5("UIListLayout", {
          Parent = parent11,
          Padding = UDim.new(0, 4),
          SortOrder = Enum.SortOrder.LayoutOrder,
        })

        local parent12 = f5("Frame", {
          Parent = parent11,
          Size = UDim2.new(1, 0, 0, 15),
          BackgroundTransparency = 1,
        })

        f6((f5("TextLabel", {
          Parent = parent12,
          Size = UDim2.new(1, -20, 1, 0),
          BackgroundTransparency = 1,
          Text = text6,
          TextColor3 = v5.Text,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })))

        local v63 = f5("TextButton", {
          Parent = parent12,
          Size = UDim2.new(0, 20, 0, 10),
          Position = UDim2.new(1, -20, 0.5, -5),
          BackgroundColor3 = color,
          BorderColor3 = v5.Border,
          BorderSizePixel = 1,
          Text = "",
        })

        local v64 = f5("Frame", {
          Parent = parent11,
          Size = UDim2.new(1, 0, 0, 110),
          BackgroundColor3 = v5.ElementBg,
          BorderColor3 = v5.Border,
          BorderSizePixel = 1,
          Visible = false,
        })

        local parent13 = f5("Frame", {
          Parent = v64,
          Size = UDim2.new(1, -10, 1, -10),
          Position = UDim2.new(0, 5, 0, 5),
          BackgroundTransparency = 1,
        })

        local v65 = f5("TextButton", {
          Parent = parent13,
          Size = UDim2.new(1, -20, 1, 0),
          Position = UDim2.new(0, 0, 0, 0),
          BackgroundColor3 = Color3.fromHSV(v58, 1, 1),
          BorderColor3 = v5.Border,
          BorderSizePixel = 1,
          Text = "",
          AutoButtonColor = false,
        })

        f5("UIGradient", {
          Parent = f5("Frame", {
            Parent = v65,
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
            Parent = v65,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = Color3.new(0, 0, 0),
            BorderSizePixel = 0,
          }),
          Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0),
          }),
          Rotation = 90,
        })

        local v66 = f5("Frame", {
          Parent = v65,
          Size = UDim2.new(0, 4, 0, 4),
          AnchorPoint = new2(0.5, 0.5),
          Position = UDim2.new(v61, 0, 1 - v62, 0),
          BackgroundColor3 = Color3.new(1, 1, 1),
          BorderColor3 = Color3.new(0, 0, 0),
          BorderSizePixel = 1,
        })

        local v67 = f5("TextButton", {
          Parent = parent13,
          Size = UDim2.new(0, 15, 1, 0),
          Position = UDim2.new(1, -15, 0, 0),
          BackgroundColor3 = Color3.new(1, 1, 1),
          BorderColor3 = v5.Border,
          BorderSizePixel = 1,
          Text = "",
          AutoButtonColor = false,
        })

        f5("UIGradient", {
          Parent = v67,
          Rotation = 90,
          Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.166, fromRGB(255, 0, 255)),
            ColorSequenceKeypoint.new(0.333, fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.5, fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.666, fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.833, fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(1, fromRGB(255, 0, 0)),
          }),
        })

        local v68 = f5("Frame", {
          Parent = v67,
          Size = UDim2.new(1, 2, 0, 2),
          AnchorPoint = new2(0.5, 0.5),
          Position = UDim2.new(0.5, 0, 1 - v58, 0),
          BackgroundColor3 = Color3.new(1, 1, 1),
          BorderColor3 = Color3.new(0, 0, 0),
          BorderSizePixel = 1,
        })

        local function f11()
          color = Color3.fromHSV(v58, v61, v62)
          v65.BackgroundColor3 = Color3.fromHSV(v58, 1, 1)
          v63.BackgroundColor3 = color

          if p37 then
            p37(color)
          end
        end

        local v69 = false
        local v70 = false
        v67.MouseButton1Down:Connect(function() v69 = true end)
        v65.MouseButton1Down:Connect(function() v70 = true end)

        userInputService.InputEnded:Connect(function(input7)
          if input7.UserInputType == Enum.UserInputType.MouseButton1 then
            v69 = false
            v70 = false
          end
        end)

        userInputService.InputChanged:Connect(function(input8)
          if v69 and input8.UserInputType == Enum.UserInputType.MouseMovement then
            v58 = 1
              - clamp((input8.Position.Y - v67.AbsolutePosition.Y) / v67.AbsoluteSize.Y, 0, 1)

            v68.Position = UDim2.new(0.5, 0, 1 - v58, 0)
            f11()
          elseif v70 and input8.UserInputType == Enum.UserInputType.MouseMovement then
            v61 = clamp((input8.Position.X - v65.AbsolutePosition.X) / v65.AbsoluteSize.X, 0, 1)

            v62 = 1
              - clamp((input8.Position.Y - v65.AbsolutePosition.Y) / v65.AbsoluteSize.Y, 0, 1)

            v66.Position = UDim2.new(v61, 0, 1 - v62, 0)
            f11()
          end
        end)

        v63.MouseButton1Click:Connect(function() v64.Visible = not v64.Visible end)
      end

      function v33:CreateButton(p38, p39)
        local v71 = f5("TextButton", {
          Parent = f5("Frame", {
            Parent = parent6,
            Size = UDim2.new(1, 0, 0, 20),
            BackgroundTransparency = 1,
          }),
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundColor3 = v5.ElementBg,
          BorderColor3 = v5.Border,
          BorderSizePixel = 1,
          Text = "  " .. p38,
          TextColor3 = v5.Text,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f1(f5("Frame", {
          Parent = v71,
          Size = UDim2.new(0, 2, 1, 0),
          BackgroundColor3 = v5.Accent,
          BorderSizePixel = 0,
        }))

        f6(v71)

        local v72 = f7(v71, v5.Accent)
        v72.Visible = false

        v71.MouseButton1Click:Connect(function()
          tweenService:Create(v71, TweenInfo.new(0.1), { BackgroundColor3 = v5.Accent }):Play()

          v2(0.1, function()
            tweenService:Create(v71, TweenInfo.new(0.1), { BackgroundColor3 = v5.ElementBg }):Play()
          end)

          if p39 then
            p39()
          end
        end)

        v71.MouseEnter:Connect(function()
          f2(v71)
          v72.Visible = true
        end)

        v71.MouseLeave:Connect(function()
          v71.TextColor3 = v5.Text
          v72.Visible = false
        end)
      end

      function v33:CreateLabel(text7)
        f6((f5("TextLabel", {
          Parent = f5("Frame", {
            Parent = parent6,
            Size = UDim2.new(1, 0, 0, 15),
            BackgroundTransparency = 1,
          }),
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundTransparency = 1,
          Text = text7,
          TextColor3 = v5.TextDark,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
          RichText = true,
        })))
      end

      return v33
    end

    return v28
  end

  return v20
end

local v73 = {
  ESPEnabled = false,
  Boxes = false,
  HealthBar = false,
  Names = false,
  Tracers = false,
  TeamCheck = true,
  FadeESP = false,
  MaxDistance = 800,
  VisibleCheck = true,
  ESPColor = fromRGB(255, 65, 65),
  VisibleColor = fromRGB(0, 255, 0),
  SilentAim = false,
  AimVisibleCheck = false,
  FOVRadius = 150,
  ShowFOV = false,
  NoRecoil = false,
}

local circle = Drawing.new("Circle")
circle.Thickness = 1
circle.Color = fromRGB(255, 255, 255)
circle.Filled = false
circle.Visible = false

local v74 = {}
local count = 0

while true do
  count = 1 + count

  if not (count <= 8) then
    break
  end

  local line = Drawing.new("Line")
  line.Thickness = 2
  line.Color = fromRGB(255, 50, 50)
  line.Visible = false

  v74[count] = line
end

local function f12(p40)
  if not v73.TeamCheck then
    return true
  end

  if p40.Team == nil then
    return true
  end

  return p40.Team ~= localPlayer.Team
end

local f13

local function f14()
  local fovRadius = v73.FOVRadius
  local v75

  for index7, value15 in ipairs(players:GetPlayers()) do
    if value15 ~= localPlayer and f12(value15) and value15.Character
      and value15.Character:FindFirstChild("Head")
      and value15.Character:FindFirstChild("Humanoid") and value15.Character.Humanoid.Health > 0 then
      local head = value15.Character.Head

      if v73.AimVisibleCheck and not f13(head) then
      else
        local v76, v77 = currentCamera:WorldToViewportPoint(head.Position)

        if v77 then
          local getMouseLocation = userInputService:GetMouseLocation()
          local magnitude = (new2(v76.X, v76.Y) - getMouseLocation).Magnitude

          if magnitude < fovRadius then
            fovRadius = magnitude
            v75 = head
          end
        end
      end
    end
  end

  return v75
end

function f13(p41)
  if not localPlayer.Character then
    return false
  else
    local position2 = currentCamera.CFrame.Position
    local position3 = p41.Position

    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = { localPlayer.Character, p41.Parent }
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.IgnoreWater = true

    return workspace:Raycast(position2, position3 - position2, raycastParams) == nil
  end
end

local silentAim, v78

v78 = hookmetamethod(game, "__namecall", newcclosure(function(p42, ...)
  if getgenv().OverdoseUnloaded then
    return v78(p42, ...)
  else
    local v79 = getnamecallmethod()
    local v80 = { ... }

    if not checkcaller() and v73.SilentAim and silentAim and silentAim.Parent then
      if v79 == "Raycast" or v79 == "raycast" then
        local v81 = v80[1]
        local v82 = v80[2]

        if typeof(v81) == "Vector3" and typeof(v82) == "Vector3" and v82.Magnitude > 20 then
          v80[2] = (silentAim.Position - v81).Unit * v82.Magnitude
          return v78(p42, unpack(v80))
        end
      end

      return v78(p42, ...)
    end

    return v78(p42, ...)
  end
end))

local v83 = {}

local function f15(p43)
  local v84 = {
    BoxOutline = Drawing.new("Square"),
    Box = Drawing.new("Square"),
    HealthOutline = Drawing.new("Square"),
    Health = Drawing.new("Square"),
    HealthText = Drawing.new("Text"),
    Name = Drawing.new("Text"),
    TracerOutline = Drawing.new("Line"),
    Tracer = Drawing.new("Line"),
  }

  v84.BoxOutline.Thickness = 3
  v84.BoxOutline.Filled = false
  v84.BoxOutline.Color = Color3.new(0, 0, 0)
  v84.BoxOutline.ZIndex = 1
  v84.Box.Thickness = 1
  v84.Box.Filled = false
  v84.Box.ZIndex = 2
  v84.HealthOutline.Thickness = 1
  v84.HealthOutline.Filled = true
  v84.HealthOutline.Color = Color3.new(0, 0, 0)
  v84.HealthOutline.ZIndex = 1
  v84.Health.Thickness = 1
  v84.Health.Filled = true
  v84.Health.ZIndex = 2
  v84.HealthText.Size = 13
  v84.HealthText.Center = true
  v84.HealthText.Outline = true
  v84.HealthText.OutlineColor = Color3.new(0, 0, 0)
  v84.HealthText.ZIndex = 3
  v84.Name.Size = 16
  v84.Name.Center = true
  v84.Name.Outline = true
  v84.Name.OutlineColor = Color3.new(0, 0, 0)
  v84.Name.ZIndex = 3
  v84.TracerOutline.Thickness = 3
  v84.TracerOutline.Color = Color3.new(0, 0, 0)
  v84.TracerOutline.ZIndex = 1
  v84.Tracer.Thickness = 1
  v84.Tracer.ZIndex = 2

  v83[p43] = v84
end

for index8, value16 in ipairs(players:GetPlayers()) do
  if value16 ~= localPlayer then
    f15(value16)
  end
end

local connect3 = players.PlayerAdded:Connect(function(player) f15(player) end)

local connect4 = players.PlayerRemoving:Connect(function(player2)
  if v83[player2] then
    for key9, value17 in pairs(v83[player2]) do
      value17:Remove()
    end

    v83[player2] = nil
  end
end)

local connect5 = runService.RenderStepped:Connect(function()
  local v85, v86

  if getgenv().OverdoseUnloaded then
    return
  else
    circle.Position = userInputService:GetMouseLocation()
    circle.Radius = v73.FOVRadius
    circle.Visible = v73.ShowFOV and v73.SilentAim

    local v87 = f14()
    silentAim = v73.SilentAim and v87 or nil

    if silentAim then
      local v88, v89 = currentCamera:WorldToViewportPoint(silentAim.Position)

      if v89 then
        local v90 = tick() * 3
        v86 = cos(v90)
        v85 = sin(v90)

        local function f16(p44, p45)
          return new2(v88.X + (p44 * v86 - p45 * v85), v88.Y + (p44 * v85 + p45 * v86))
        end

        local from = f16(-12, -12)
        local from2 = f16(12, -12)
        local from3 = f16(12, 12)
        local from4 = f16(-12, 12)

        v74[1].From = from
        v74[1].To = f16(-6, -12)
        v74[2].From = from
        v74[2].To = f16(-12, -6)
        v74[3].From = from2
        v74[3].To = f16(6, -12)
        v74[4].From = from2
        v74[4].To = f16(12, -6)
        v74[5].From = from3
        v74[5].To = f16(6, 12)
        v74[6].From = from3
        v74[6].To = f16(12, 6)
        v74[7].From = from4
        v74[7].To = f16(-6, 12)
        v74[8].From = from4
        v74[8].To = f16(-12, 6)

        for j = 1, 8 do
          v74[j].Visible = true
        end
      else
        for k = 1, 8 do
          v74[k].Visible = false
        end
      end
    else
      local count2 = 0

      while true do
        count2 = 1 + count2

        if not (8 >= count2) then
          break
        end

        v74[count2].Visible = false
      end
    end

    local character = localPlayer.Character

    local humanoidRootPart = character
    humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

    if character then
      character:FindFirstChild("Humanoid")
    end

    for key10, value18 in pairs(v83) do
      local v91 = false

      if v73.ESPEnabled and humanoidRootPart and f12(key10) and key10.Character
        and key10.Character:FindFirstChild("HumanoidRootPart")
        and key10.Character:FindFirstChild("Humanoid") then
        local humanoidRootPart2 = key10.Character.HumanoidRootPart
        local head2 = key10.Character:FindFirstChild("Head")
        local humanoid = key10.Character.Humanoid
        local magnitude2 = (humanoidRootPart2.Position - humanoidRootPart.Position).Magnitude

        if head2 and humanoid.Health > 0 and magnitude2 <= v73.MaxDistance then
          local v92, v93 = currentCamera:WorldToViewportPoint(humanoidRootPart2.Position)

          local worldToViewportPoint = currentCamera:WorldToViewportPoint(head2.Position
            + new(0, 0.5, 0))

          local worldToViewportPoint2 = currentCamera:WorldToViewportPoint(humanoidRootPart2.Position
            - new(0, 3, 0))

          if v93 then
            v91 = true
            local espColor = v73.ESPColor

            if v73.VisibleCheck and f13(head2) then
              espColor = v73.VisibleColor
            end

            local transparency = 1

            if v73.FadeESP then
              transparency = clamp(1 - magnitude2 / v73.MaxDistance, 0.1, 1)
            end

            local v94 = abs(worldToViewportPoint.Y - worldToViewportPoint2.Y)
            local v95 = v94 / 2
            local v96 = new2(v92.X - v95 / 2, worldToViewportPoint.Y)
            local size = new2(v95, v94)

            if v73.Boxes then
              value18.BoxOutline.Size = size
              value18.BoxOutline.Position = v96
              value18.BoxOutline.Transparency = transparency
              value18.BoxOutline.Visible = true
              value18.Box.Size = size
              value18.Box.Position = v96
              value18.Box.Color = espColor
              value18.Box.Transparency = transparency
              value18.Box.Visible = true
            else
              value18.BoxOutline.Visible = false
              value18.Box.Visible = false
            end

            if v73.HealthBar then
              local v97 = max(humanoid.MaxHealth, 1)
              local v98 = clamp(humanoid.Health / v97, 0, 1)
              local v99 = max(floor(v94 * v98), 1)

              value18.HealthOutline.Size = new2(4, v94 + 2)
              value18.HealthOutline.Position = new2(v96.X - 6, v96.Y - 1)
              value18.HealthOutline.Transparency = transparency
              value18.HealthOutline.Visible = true
              value18.Health.Size = new2(2, v99)
              value18.Health.Position = new2(v96.X - 5, v96.Y + v94 - v99)

              local color2 = fromRGB(255 - v98 * 255, v98 * 255, 0)

              value18.Health.Color = color2
              value18.Health.Transparency = transparency
              value18.Health.Visible = true
              value18.HealthText.Text = tostring(floor(humanoid.Health)) .. " HP"
              value18.HealthText.Position = new2(v96.X - 25, v96.Y + v94 - v99 - 6)
              value18.HealthText.Color = color2
              value18.HealthText.Transparency = transparency
              value18.HealthText.Visible = true
            else
              value18.HealthOutline.Visible = false
              value18.Health.Visible = false
              value18.HealthText.Visible = false
            end

            if v73.Names then
              value18.Name.Text = string.format(
                "%s [%dm]", key10.DisplayName, floor(magnitude2)
              )

              value18.Name.Position = new2(v96.X + v95 / 2, v96.Y - 18)
              value18.Name.Color = espColor
              value18.Name.Transparency = transparency
              value18.Name.Visible = true
            else
              value18.Name.Visible = false
            end

            if v73.Tracers then
              local from5 = new2(currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y)

              value18.TracerOutline.From = from5
              value18.TracerOutline.To = new2(v92.X, v92.Y)
              value18.TracerOutline.Transparency = transparency
              value18.TracerOutline.Visible = true
              value18.Tracer.From = from5
              value18.Tracer.To = new2(v92.X, v92.Y)
              value18.Tracer.Color = espColor
              value18.Tracer.Transparency = transparency
              value18.Tracer.Visible = true
            else
              value18.TracerOutline.Visible = false
              value18.Tracer.Visible = false
            end
          end
        end
      end

      if not v91 then
        value18.BoxOutline.Visible = false
        value18.Box.Visible = false
        value18.HealthOutline.Visible = false
        value18.Health.Visible = false
        value18.HealthText.Visible = false
        value18.Name.Visible = false
        value18.TracerOutline.Visible = false
        value18.Tracer.Visible = false
      end
    end

    return
  end
end)

v3(function()
  while v1(0.5) do
    if getgenv().OverdoseUnloaded then
      break
    elseif v73.NoRecoil then
      pcall(function()
        local playerScripts = localPlayer:WaitForChild("PlayerScripts")
        local ballisticsClient = playerScripts:FindFirstChild("BallisticsClient")

        if not ballisticsClient then
          ballisticsClient = Instance.new("Folder")
          ballisticsClient.Name = "BallisticsClient"
          ballisticsClient.Parent = playerScripts
        end

        local debugShotsGui = ballisticsClient:FindFirstChild("DebugShotsGui")

        if not debugShotsGui then
          debugShotsGui = Instance.new("BoolValue")
          debugShotsGui.Name = "DebugShotsGui"
          debugShotsGui.Parent = ballisticsClient
        end

        debugShotsGui.Value = true
        local playerGui = localPlayer:FindFirstChild("PlayerGui")

        if playerGui then
          local debugShotsGui2 = playerGui:FindFirstChild("DebugShotsGui")

          if debugShotsGui2 and debugShotsGui2:IsA("ScreenGui") and debugShotsGui2.Enabled then
            debugShotsGui2.Enabled = false
          end

          for index9, value19 in ipairs(playerGui:GetChildren()) do
            if value19:IsA("ScreenGui") and string.match(string.lower(value19.Name), "debug") then
              value19.Enabled = false
            end
          end
        end
      end)
    end
  end
end)

local connect6 = workspace.DescendantAdded:Connect(function(descendant)
  if getgenv().OverdoseUnloaded or not v73.NoRecoil then
    return
  end

  if descendant:IsA("BasePart") then
    v3(function()
      runService.RenderStepped:Wait()

      pcall(function()
        local v100 = string.lower(descendant.Name)

        if v100:match("debug") or v100:match("shot") or v100:match("bullet")
          or v100:match("tracer") or v100:match("ray") or v100:match("line")
          or v100:match("trajectory") or v100:match("laser") then
          descendant.Transparency = 1
        elseif descendant.Size.X < 0.25 and descendant.Size.Y < 0.25
          or descendant.Size.Z < 0.25 and descendant.Size.X < 0.25 then
          descendant.Transparency = 1
        end
      end)
    end)
  elseif descendant:IsA("LineHandleAdornment") or descendant:IsA("CylinderHandleAdornment") then
    pcall(function()
      descendant.Visible = false
      descendant:Destroy()
    end)
  elseif descendant:IsA("Trail") or descendant:IsA("Beam") then
    pcall(function() descendant.Enabled = false end)
  end
end)

local window = v4:CreateWindow("Overdoze.gg | Shooter Hub")
local visualTab = window:CreateTab("Visual")
local combatTab = window:CreateTab("Combat")
local playerTab = window:CreateTab("Player")
local settingsTab = window:CreateTab("Settings")

local espSettingsSection = visualTab:CreateSection("ESP Settings", "Left")

espSettingsSection:CreateToggle("ESP", false, function(espEnabled)
  v73.ESPEnabled = espEnabled
end)

espSettingsSection:CreateToggle("Team", true, function(teamCheck) v73.TeamCheck = teamCheck end)
espSettingsSection:CreateToggle("Fade", false, function(fadeESP) v73.FadeESP = fadeESP end)
espSettingsSection:CreateToggle("Boxes", false, function(boxes) v73.Boxes = boxes end)

espSettingsSection:CreateToggle("Health", false, function(healthBar)
  v73.HealthBar = healthBar
end)

espSettingsSection:CreateToggle("Names", false, function(names) v73.Names = names end)
espSettingsSection:CreateToggle("Tracers", false, function(tracers) v73.Tracers = tracers end)

local section = visualTab:CreateSection("ESP Colors & Limits", "Right")

section:CreateToggle("Vis Check", true, function(visibleCheck)
  v73.VisibleCheck = visibleCheck
end)

section:CreateColorPicker("Hidden Color", fromRGB(255, 65, 65), 0, function(espColor2)
  v73.ESPColor = espColor2
end)

section:CreateColorPicker("Visible Color", fromRGB(0, 255, 0), 0, function(visibleColor)
  v73.VisibleColor = visibleColor
end)

section:CreateSlider("Max Dist", 50, 3000, 800, function(maxDistance)
  v73.MaxDistance = maxDistance
end)

local aimbotSection = combatTab:CreateSection("Aimbot", "Left")

aimbotSection:CreateToggle("Silent Aim", false, function(silentAim2)
  v73.SilentAim = silentAim2
end)

aimbotSection:CreateToggle("Vis Check", false, function(aimVisibleCheck)
  v73.AimVisibleCheck = aimVisibleCheck
end)

aimbotSection:CreateToggle("FOV Circle", false, function(showFOV) v73.ShowFOV = showFOV end)

aimbotSection:CreateSlider("FOV Radius", 30, 500, 150, function(fovRadius2)
  v73.FOVRadius = fovRadius2
end)

combatTab:CreateSection("Weapon Modifications", "Right"):CreateToggle("No Recoil", false, function(noRecoil)
  v73.NoRecoil = noRecoil
end)

local worldOptimizationSection = playerTab:CreateSection("World Optimization", "Right")
worldOptimizationSection:CreateButton("FPS Boost", function() end)
worldOptimizationSection:CreateLabel("Removes vegetation and simplifies props")

local uiConfigurationSection = settingsTab:CreateSection("UI Configuration", "Left")

uiConfigurationSection:CreateColorPicker("Accent", v5.Accent, 0, function(p46)
  v4:ChangeAccent(p46)
end)

uiConfigurationSection:CreateToggle("Keybinds", false, function(p47)
  v4:SetKeybindsUIVisible(p47)
end)

uiConfigurationSection:CreateKeybind("Menu Key", Enum.KeyCode.Home, function(p48, p49)
  if p49 then
    getgenv().ToggleUIKey = p49
  end
end, true)

settingsTab:CreateSection("System Management", "Right"):CreateButton("Unload", function()
  getgenv().OverdoseUnloaded = true

  if v9 then
    v9:Destroy()
  end

  if v10 then
    v10:Destroy()
  end

  if v14 then
    v14.Destroy()
  end

  if connect then
    connect:Disconnect()
  end

  if connect2 then
    connect2:Disconnect()
  end

  if connect5 then
    connect5:Disconnect()
  end

  if connect3 then
    connect3:Disconnect()
  end

  if connect4 then
    connect4:Disconnect()
  end

  if connect6 then
    connect6:Disconnect()
  end

  for key11, value20 in pairs(v83) do
    for key12, value21 in pairs(value20) do
      local v101 = value21
      pcall(function() v101:Remove() end)
    end
  end

  v83 = {}

  if circle then
    circle:Remove()
  end

  for m = 1, 8 do
    if v74[m] then
      v74[m]:Remove()
    end
  end
end)
