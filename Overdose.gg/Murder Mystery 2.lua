local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local virtualInputManager = game:GetService("VirtualInputManager")
local v1 = {}
local currentCamera = workspace.CurrentCamera

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
  table.insert(v3.Image, p1)
  return p1
end

local function f2(p2)
  table.insert(v3.Text, p2)
  return p2
end

local function f3(p3)
  table.insert(v3.Bg, p3)
  return p3
end

v1.MenuDropdowns = {}

function v1:ChangeAccent(p4)
  v2.Accent = p4

  for key, value in pairs(v3.Bg) do
    if value and value.Parent then
      value.BackgroundColor3 = p4
    end
  end

  for key2, value2 in pairs(v3.Text) do
    if value2 and value2.Parent then
      value2.TextColor3 = p4
    end
  end

  for key3, value3 in pairs(v3.Image) do
    if value3 and value3.Parent then
      value3.ImageColor3 = p4
    end
  end

  for key4, value4 in pairs(v3.Stroke) do
    if value4 and value4.Parent then
      value4.Color = p4
    end
  end

  for index, value5 in ipairs(v1.MenuDropdowns) do
    if value5.isOpen then
      for index2, value6 in ipairs(value5.options) do
        if value6.name == value5.current then
          value6.btn.TextColor3 = p4
        end
      end
    end
  end
end

local function f4(parent, p5)
  local glowEffect = f1(Instance.new("ImageLabel"))
  glowEffect.Name = "GlowEffect"
  glowEffect.BackgroundTransparency = 1
  glowEffect.Position = UDim2.new(0, -5, 0, -5)
  glowEffect.Size = UDim2.new(1, 10, 1, 10)
  glowEffect.ZIndex = 0
  glowEffect.Image = "rbxassetid://1316045217"
  glowEffect.ImageColor3 = p5 or v2.Accent
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

local function f5(p6, p7)
  local instance = Instance.new(p6)

  for key5, value7 in pairs(p7) do
    instance[key5] = value7
  end

  return instance
end

local function f6(p8, p9)
  local glowEffect2 = f1(Instance.new("ImageLabel"))
  glowEffect2.Name = "GlowEffect"
  glowEffect2.BackgroundTransparency = 1
  glowEffect2.Position = UDim2.new(0, -8, 0, -8)
  glowEffect2.Size = UDim2.new(1, 16, 1, 16)
  glowEffect2.ZIndex = p8.ZIndex - 1
  glowEffect2.Image = "rbxassetid://1316045217"
  glowEffect2.ImageColor3 = p9 or v2.Accent
  glowEffect2.ImageTransparency = 0.05
  glowEffect2.ScaleType = Enum.ScaleType.Slice
  glowEffect2.SliceCenter = Rect.new(10, 10, 118, 118)
  glowEffect2.Parent = p8

  return glowEffect2
end

local function f7(p10, p11)
  local v4 = false
  local inputBegan = p10.InputBegan
  local position, absolutePosition

  inputBegan:Connect(function(p12)
    if p12.UserInputType == Enum.UserInputType.MouseButton1 then
      v4 = true
      position = p12.Position
      absolutePosition = p11.AbsolutePosition
    end
  end)

  userInputService.InputChanged:Connect(function(input)
    if v4 and input.UserInputType == Enum.UserInputType.MouseMovement then
      local v5 = input.Position - position

      p11.Position = UDim2.new(0, math.clamp(
        absolutePosition.X + v5.X, 0, currentCamera.ViewportSize.X - p11.AbsoluteSize.X
      ), 0, math.clamp(
        absolutePosition.Y + v5.Y, 0, currentCamera.ViewportSize.Y - p11.AbsoluteSize.Y
      ))
    end
  end)

  userInputService.InputEnded:Connect(function(input2)
    if input2.UserInputType == Enum.UserInputType.MouseButton1 then
      v4 = false
    end
  end)
end

local function f8(parent2)
  local uiStroke = Instance.new("UIStroke")
  uiStroke.Color = Color3.new(0, 0, 0)
  uiStroke.Thickness = 1
  uiStroke.Transparency = 0
  uiStroke.Parent = parent2
end

local function f9()
  local text = ""

  for i = 1, 16 do
    text = text .. string.char(math.random(97, 122))
  end

  return text
end

local v6 = f5("ScreenGui", {
  Name = f9(),
  ResetOnSpawn = false,
  DisplayOrder = 99999,
  ZIndexBehavior = Enum.ZIndexBehavior.Global,
})

if not pcall(function()
  if gethui then
    v6.Parent = gethui()
  elseif syn and syn.protect_gui then
    syn.protect_gui(v6)
    v6.Parent = coreGui
  else
    v6.Parent = coreGui
  end
end) or not v6.Parent then
  v6.Parent = players.LocalPlayer:WaitForChild("PlayerGui")
end

getgenv().ToggleUIKey = Enum.KeyCode.Home

userInputService.InputBegan:Connect(function(input3, p13)
  if not p13 and input3.KeyCode == getgenv().ToggleUIKey then
    if getgenv().MainGuiFrame then
      getgenv().MainGuiFrame.Visible = not getgenv().MainGuiFrame.Visible
    end
  end
end)

local v7 = f5("Frame", {
  Parent = v6,
  Size = UDim2.new(0, 220, 0, 24),
  Position = UDim2.new(0, 20, 0, 20),
  BackgroundColor3 = v2.MainBg,
  BorderColor3 = v2.Border,
  BorderSizePixel = 1,
  Visible = false,
})

f3(f5("Frame", {
  Parent = v7,
  Size = UDim2.new(1, 0, 0, 1),
  BackgroundColor3 = v2.Accent,
  BorderSizePixel = 0,
}))

f7(v7, v7)
f4(v7, v2.Accent)

local v8 = f5("Frame", {
  Parent = f5("Frame", {
    Parent = v7,
    Size = UDim2.new(0, 16, 0, 16),
    Position = UDim2.new(0, 5, 0.5, -8),
    BackgroundTransparency = 1,
  }),
  Size = UDim2.new(1, 0, 1, 0),
  AnchorPoint = Vector2.new(0.5, 0.5),
  Position = UDim2.new(0.5, 0, 0.5, 0),
  BackgroundTransparency = 1,
})

local function f10(p14, p15, p16, p17)
  local parent3 = f5("Frame", {
    Parent = v8,
    Size = UDim2.new(0, 4, 0, 4),
    Position = UDim2.new(p17 and 0 or 1, p17 and 0 or -4, p16 and 0 or 1, p16 and 0 or -4),
    BackgroundTransparency = 1,
  })

  f3(f5("Frame", {
    Parent = parent3,
    Size = UDim2.new(1, 0, 0, 1),
    Position = UDim2.new(0, 0, p16 and 0 or 1, p16 and 0 or -1),
    BackgroundColor3 = v2.Accent,
    BorderSizePixel = 0,
  }))

  f3(f5("Frame", {
    Parent = parent3,
    Size = UDim2.new(0, 1, 1, 0),
    Position = UDim2.new(p17 and 0 or 1, p17 and 0 or -1, 0, 0),
    BackgroundColor3 = v2.Accent,
    BorderSizePixel = 0,
  }))
end

f10(0, 0, true, true)
f10(1, 0, true, false)
f10(0, 1, false, true)
f10(1, 1, false, false)

local v9 = f5("TextLabel", {
  Parent = v7,
  Size = UDim2.new(1, -30, 1, 0),
  Position = UDim2.new(0, 28, 0, 0),
  BackgroundTransparency = 1,
  Text = "Overdose.gg | FPS: 0",
  TextColor3 = v2.Text,
  Font = code,
  TextSize = 12,
  TextXAlignment = Enum.TextXAlignment.Left,
})

f8(v9)
local v10 = tick()
local v11 = 0
local v12 = v10

runService.RenderStepped:Connect(function()
  v11 = v11 + 1
  v8.Rotation = v8.Rotation + 0.15

  if tick() - v12 >= 1 then
    v9.Text = string.format("Overdose.gg | FPS: %d", v11)
    v11 = 0
    v12 = tick()
  end
end)

function v1:CreateWindow(text2)
  local v13 = {}

  local v14 = f5("Frame", {
    Parent = v6,
    Size = UDim2.new(0, 300, 0, 60),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    BackgroundColor3 = v2.MainBg,
    BorderColor3 = v2.Border,
    BorderSizePixel = 1,
  })

  f3(f5("Frame", {
    Parent = v14,
    Size = UDim2.new(1, 0, 0, 1),
    BackgroundColor3 = v2.Accent,
    BorderSizePixel = 0,
  }))

  f4(v14, v2.Accent)

  f8((f5("TextLabel", {
    Parent = v14,
    Size = UDim2.new(1, 0, 0, 30),
    BackgroundTransparency = 1,
    Text = "Loading Overdose.gg...",
    TextColor3 = v2.Text,
    Font = code,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Center,
  })))

  local v15 = f3(f5("Frame", {
    Parent = f5("Frame", {
      Parent = v14,
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

  f6(v15, v2.Accent)

  local v16 = f5("Frame", {
    Parent = v6,
    Size = UDim2.new(0, 800, 0, 500),
    Position = UDim2.new(0.5, -400, 0.5, -250),
    BackgroundColor3 = v2.MainBg,
    BorderColor3 = v2.Border,
    BorderSizePixel = 1,
    Visible = false,
  })

  getgenv().MainGuiFrame = v16
  v15:TweenSize(UDim2.new(1, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 2)

  task.delay(2.2, function()
    v14:Destroy()
    v16.Visible = true
    v7.Visible = true
  end)

  local v17 = f5("Frame", {
    Parent = v16,
    Size = UDim2.new(1, 0, 0, 25),
    BackgroundColor3 = v2.MainBg,
    BorderColor3 = v2.Border,
    BorderSizePixel = 1,
  })

  f7(v17, v16)

  f8((f5("TextLabel", {
    Parent = v17,
    Size = UDim2.new(1, -10, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1,
    Text = text2,
    TextColor3 = v2.Text,
    Font = code,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
  })))

  local v18 = f5("Frame", {
    Parent = v16,
    Size = UDim2.new(1, 0, 0, 30),
    Position = UDim2.new(0, 0, 0, 25),
    BackgroundColor3 = v2.MainBg,
    BorderColor3 = v2.Border,
    BorderSizePixel = 1,
  })

  f5("UIListLayout", {
    Parent = v18,
    FillDirection = Enum.FillDirection.Horizontal,
    SortOrder = Enum.SortOrder.LayoutOrder,
  })

  local v19 = f5("Folder", { Parent = v16, Name = "Pages" })
  local v20 = true

  function v13:CreateTab(text3)
    local v21 = {}

    local v22 = f5("TextButton", {
      Parent = v18,
      Size = UDim2.new(0, 100, 1, 0),
      BackgroundTransparency = 1,
      Text = text3,
      TextColor3 = v20 and v2.Text or v2.TextDark,
      Font = code,
      TextSize = 13,
    })

    f8(v22)

    if v20 then
      f2(v22)
    end

    local v23 = f5("Frame", {
      Parent = v19,
      Size = UDim2.new(1, 0, 1, -55),
      Position = UDim2.new(0, 0, 0, 55),
      BackgroundTransparency = 1,
      Visible = v20,
    })

    local v24 = f5("ScrollingFrame", {
      Parent = v23,
      Size = UDim2.new(0.5, -15, 1, -20),
      Position = UDim2.new(0, 10, 0, 10),
      BackgroundTransparency = 1,
      ScrollBarThickness = 2,
      CanvasSize = UDim2.new(0, 0, 0, 0),
      AutomaticCanvasSize = Enum.AutomaticSize.Y,
    })

    f5("UIListLayout", {
      Parent = v24,
      Padding = UDim.new(0, 10),
      SortOrder = Enum.SortOrder.LayoutOrder,
    })

    local v25 = f5("ScrollingFrame", {
      Parent = v23,
      Size = UDim2.new(0.5, -15, 1, -20),
      Position = UDim2.new(0.5, 5, 0, 10),
      BackgroundTransparency = 1,
      ScrollBarThickness = 2,
      CanvasSize = UDim2.new(0, 0, 0, 0),
      AutomaticCanvasSize = Enum.AutomaticSize.Y,
    })

    f5("UIListLayout", {
      Parent = v25,
      Padding = UDim.new(0, 10),
      SortOrder = Enum.SortOrder.LayoutOrder,
    })

    v22.MouseButton1Click:Connect(function()
      for key6, value8 in pairs(v19:GetChildren()) do
        value8.Visible = false
      end

      for key7, value9 in pairs(v18:GetChildren()) do
        if value9:IsA("TextButton") then
          value9.TextColor3 = v2.TextDark
        end
      end

      v23.Visible = true
      v22.TextColor3 = v2.Accent
    end)

    v20 = false

    function v21:CreateSection(p18, p19)
      local v26 = {}

      local parent4 = f5("Frame", {
        Parent = p19:lower() == "left" and v24 or v25,
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundColor3 = v2.SectionBg,
        BorderColor3 = v2.Border,
        BorderSizePixel = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
      })

      f3(f5("Frame", {
        Parent = parent4,
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = v2.Accent,
        BorderSizePixel = 0,
      }))

      f8((f5("TextLabel", {
        Parent = parent4,
        Size = UDim2.new(1, -10, 0, 20),
        Position = UDim2.new(0, 10, 0, 2),
        BackgroundTransparency = 1,
        Text = "- " .. p18 .. " -",
        TextColor3 = v2.Text,
        Font = code,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
      })))

      local parent5 = f5("Frame", {
        Parent = parent4,
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 25),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
      })

      f5("UIListLayout", {
        Parent = parent5,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
      })

      f5("UIPadding", {
        Parent = parent5,
        PaddingTop = UDim.new(0, 2),
        PaddingLeft = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
      })

      function v26:CreateToggle(text4, p20, p21)
        local v27 = p20 or false

        local parent6 = f5("Frame", {
          Parent = parent5,
          Size = UDim2.new(1, 0, 0, 15),
          BackgroundTransparency = 1,
        })

        local v28 = f5("Frame", {
          Parent = parent6,
          Size = UDim2.new(0, 10, 0, 10),
          Position = UDim2.new(0, 0, 0.5, -5),
          BackgroundColor3 = v2.ElementBg,
          BorderColor3 = v2.Border,
          BorderSizePixel = 1,
        })

        local v29 = f3(f5("Frame", {
          Parent = v28,
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundColor3 = v2.Accent,
          BorderSizePixel = 0,
          Visible = v27,
        }))

        local v30 = f6(v28, v2.Accent)
        v30.Visible = v27

        local v31 = f5("TextLabel", {
          Parent = parent6,
          Size = UDim2.new(1, -20, 1, 0),
          Position = UDim2.new(0, 15, 0, 0),
          BackgroundTransparency = 1,
          Text = text4,
          TextColor3 = v27 and v2.Text or v2.TextDark,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f8(v31)

        f5("TextButton", {
          Parent = parent6,
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundTransparency = 1,
          Text = "",
        }).MouseButton1Click:Connect(function()
          v27 = not v27
          v29.Visible = v27
          v30.Visible = v27
          v31.TextColor3 = v27 and v2.Text or v2.TextDark

          if p21 then
            p21(v27)
          end
        end)
      end

      function v26:CreateKeybind(text5, p22, p23)
        local keyCode = p22
        local v32 = false
        local v33 = false

        local parent7 = f5("Frame", {
          Parent = parent5,
          Size = UDim2.new(1, 0, 0, 15),
          BackgroundTransparency = 1,
        })

        local v34 = f5("TextLabel", {
          Parent = parent7,
          Size = UDim2.new(0.5, 0, 1, 0),
          BackgroundTransparency = 1,
          Text = text5,
          TextColor3 = v2.Text,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f8(v34)

        local v35 = f5("TextButton", {
          Parent = parent7,
          Size = UDim2.new(0.5, 0, 1, 0),
          Position = UDim2.new(0.5, 0, 0, 0),
          BackgroundTransparency = 1,
          Text = keyCode and "[ " .. keyCode.Name .. " ]" or "[ NONE ]",
          TextColor3 = v2.TextDark,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Right,
        })

        f8(v35)

        v35.MouseButton1Click:Connect(function()
          v32 = true
          v35.Text = "[ ... ]"
          v35.TextColor3 = v2.Accent
        end)

        userInputService.InputBegan:Connect(function(input4, p24)
          if v32 and input4.UserInputType == Enum.UserInputType.Keyboard then
            if input4.KeyCode == Enum.KeyCode.Escape then
              keyCode = nil
              v35.Text = "[ NONE ]"
            else
              keyCode = input4.KeyCode
              v35.Text = "[ " .. keyCode.Name .. " ]"
            end

            v35.TextColor3 = v2.TextDark
            v34.TextColor3 = v2.Text
            v32 = false

            if p23 then
              p23(v33, keyCode)
            end
          elseif not v32 and keyCode and input4.KeyCode == keyCode and not p24 then
            v33 = not v33

            if v33 then
              v35.TextColor3 = v2.Accent
              v34.TextColor3 = v2.Accent
            else
              v35.TextColor3 = v2.TextDark
              v34.TextColor3 = v2.Text
            end

            if p23 then
              p23(v33, keyCode)
            end
          end
        end)
      end

      function v26:CreateSlider(text6, p25, p26, p27, p28)
        local v36 = p26 - p25 <= 2
        local v37 = p27 or p25

        local parent8 = f5("Frame", {
          Parent = parent5,
          Size = UDim2.new(1, 0, 0, 30),
          BackgroundTransparency = 1,
        })

        local v38 = f5("TextLabel", {
          Parent = parent8,
          Size = UDim2.new(1, 0, 0, 15),
          BackgroundTransparency = 1,
          Text = text6,
          TextColor3 = v2.Text,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        local v39 = v36 and string.format("%.2f", v37) or tostring(v37)

        local v40 = f5("TextLabel", {
          Parent = parent8,
          Size = UDim2.new(1, 0, 0, 15),
          BackgroundTransparency = 1,
          Text = v39,
          TextColor3 = v2.Text,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Right,
        })

        f8(v38)
        f8(v40)

        local v41 = f5("Frame", {
          Parent = parent8,
          Size = UDim2.new(1, 0, 0, 4),
          Position = UDim2.new(0, 0, 0, 20),
          BackgroundColor3 = v2.ElementBg,
          BorderColor3 = v2.Border,
          BorderSizePixel = 1,
        })

        local v42 = f3(f5("Frame", {
          Parent = v41,
          Size = UDim2.new((v37 - p25) / (p26 - p25), 0, 1, 0),
          BackgroundColor3 = v2.Accent,
          BorderSizePixel = 0,
        }))

        f6(v42, v2.Accent)

        local v43 = f5("TextButton", {
          Parent = v41,
          Size = UDim2.new(1, 0, 1, 20),
          Position = UDim2.new(0, 0, 0.5, -10),
          BackgroundTransparency = 1,
          Text = "",
        })

        local v44 = false
        v43.MouseButton1Down:Connect(function() v44 = true end)

        userInputService.InputEnded:Connect(function(input5)
          if input5.UserInputType == Enum.UserInputType.MouseButton1 then
            v44 = false
          end
        end)

        userInputService.InputChanged:Connect(function(input6)
          if v44 and input6.UserInputType == Enum.UserInputType.MouseMovement then
            local v45 = math.clamp((input6.Position.X - v41.AbsolutePosition.X)
              / v41.AbsoluteSize.X, 0, 1)

            local v46 = p25 + (p26 - p25) * v45

            if v36 then
              v37 = math.floor(v46 * 100) / 100
            else
              v37 = math.floor(v46)
            end

            v42.Size = UDim2.new(v45, 0, 1, 0)
            v40.Text = v36 and string.format("%.2f", v37) or tostring(v37)

            if p28 then
              p28(v37)
            end
          end
        end)
      end

      function v26.CreateDropdown(p29, text7, p30, p31)
        local parent9 = f5("Frame", {
          Parent = parent5,
          Size = UDim2.new(1, 0, 0, 0),
          BackgroundTransparency = 1,
          AutomaticSize = Enum.AutomaticSize.Y,
        })

        f5("UIListLayout", {
          Parent = parent9,
          Padding = UDim.new(0, 2),
          SortOrder = Enum.SortOrder.LayoutOrder,
        })

        f8((f5("TextLabel", {
          Parent = parent9,
          Size = UDim2.new(1, 0, 0, 15),
          BackgroundTransparency = 1,
          Text = text7,
          TextColor3 = v2.Text,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })))

        local v47 = f5("TextButton", {
          Parent = parent9,
          Size = UDim2.new(1, 0, 0, 20),
          BackgroundColor3 = v2.ElementBg,
          BorderColor3 = v2.Border,
          BorderSizePixel = 1,
          Text = "  " .. p30[1],
          TextColor3 = v2.Text,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f3(f5("Frame", {
          Parent = v47,
          Size = UDim2.new(0, 2, 1, 0),
          BackgroundColor3 = v2.Accent,
          BorderSizePixel = 0,
        }))

        f8(v47)

        local v48 = f5("TextLabel", {
          Parent = v47,
          Size = UDim2.new(0, 20, 1, 0),
          Position = UDim2.new(1, -20, 0, 0),
          BackgroundTransparency = 1,
          Text = "▼",
          TextColor3 = v2.TextDark,
          Font = code,
          TextSize = 12,
        })

        f8(v48)

        local v49 = f5("Frame", {
          Parent = parent9,
          Size = UDim2.new(1, 0, 0, 0),
          BackgroundColor3 = v2.ElementBg,
          BorderColor3 = v2.Border,
          BorderSizePixel = 1,
          Visible = false,
          AutomaticSize = Enum.AutomaticSize.Y,
        })

        f5("UIListLayout", { Parent = v49, SortOrder = Enum.SortOrder.LayoutOrder })
        local v50 = { isOpen = false, current = p30[1], options = {} }
        table.insert(v1.MenuDropdowns, v50)

        for index3, value10 in ipairs(p30) do
          local v51 = value10

          local v52 = f5("TextButton", {
            Parent = v49,
            Size = UDim2.new(1, 0, 0, 20),
            BackgroundTransparency = 1,
            Text = "  " .. v51,
            TextColor3 = v2.TextDark,
            Font = code,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
          })

          f8(v52)
          table.insert(v50.options, { btn = v52, name = v51 })

          v52.MouseButton1Click:Connect(function()
            v50.current = v51
            v47.Text = "  " .. v51
            v49.Visible = false
            v50.isOpen = false
            v48.Text = "▼"

            if p31 then
              p31(v51)
            end
          end)

          v52.MouseEnter:Connect(function()
            if v50.current ~= v51 then
              v52.TextColor3 = v2.Text
            end
          end)

          v52.MouseLeave:Connect(function()
            if v50.current ~= v51 then
              v52.TextColor3 = v2.TextDark
            end
          end)
        end

        local function f11()
          for index4, value11 in ipairs(v50.options) do
            if value11.name == v50.current then
              value11.btn.TextColor3 = v2.Accent
            else
              value11.btn.TextColor3 = v2.TextDark
            end
          end
        end

        v47.MouseButton1Click:Connect(function()
          v49.Visible = not v49.Visible
          v50.isOpen = v49.Visible
          v48.Text = v49.Visible and "▲" or "▼"

          if v49.Visible then
            f11()
          end
        end)
      end

      function v26:CreateColorPicker(text8, p32, p33, p34)
        local color = p32 or Color3.new(1, 1, 1)
        local v53, v54, v55 = Color3.toHSV(color)
        local v56 = v54
        local v57 = v55

        local parent10 = f5("Frame", {
          Parent = parent5,
          Size = UDim2.new(1, 0, 0, 0),
          BackgroundTransparency = 1,
          AutomaticSize = Enum.AutomaticSize.Y,
        })

        f5("UIListLayout", {
          Parent = parent10,
          Padding = UDim.new(0, 4),
          SortOrder = Enum.SortOrder.LayoutOrder,
        })

        local parent11 = f5("Frame", {
          Parent = parent10,
          Size = UDim2.new(1, 0, 0, 15),
          BackgroundTransparency = 1,
        })

        f8((f5("TextLabel", {
          Parent = parent11,
          Size = UDim2.new(1, -20, 1, 0),
          BackgroundTransparency = 1,
          Text = text8,
          TextColor3 = v2.Text,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })))

        local v58 = f5("TextButton", {
          Parent = parent11,
          Size = UDim2.new(0, 20, 0, 10),
          Position = UDim2.new(1, -20, 0.5, -5),
          BackgroundColor3 = color,
          BorderColor3 = v2.Border,
          BorderSizePixel = 1,
          Text = "",
        })

        local v59 = f5("Frame", {
          Parent = parent10,
          Size = UDim2.new(1, 0, 0, 110),
          BackgroundColor3 = v2.ElementBg,
          BorderColor3 = v2.Border,
          BorderSizePixel = 1,
          Visible = false,
        })

        local parent12 = f5("Frame", {
          Parent = v59,
          Size = UDim2.new(1, -10, 1, -10),
          Position = UDim2.new(0, 5, 0, 5),
          BackgroundTransparency = 1,
        })

        local v60 = f5("TextButton", {
          Parent = parent12,
          Size = UDim2.new(1, -20, 1, 0),
          Position = UDim2.new(0, 0, 0, 0),
          BackgroundColor3 = Color3.fromHSV(v53, 1, 1),
          BorderColor3 = v2.Border,
          BorderSizePixel = 1,
          Text = "",
          AutoButtonColor = false,
        })

        f5("UIGradient", {
          Parent = f5("Frame", {
            Parent = v60,
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
            Parent = v60,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = Color3.new(0, 0, 0),
            BorderSizePixel = 0,
          }),
          Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0),
          }),
          Rotation = 90,
        })

        local v61 = f5("Frame", {
          Parent = v60,
          Size = UDim2.new(0, 4, 0, 4),
          AnchorPoint = Vector2.new(0.5, 0.5),
          Position = UDim2.new(v56, 0, 1 - v57, 0),
          BackgroundColor3 = Color3.new(1, 1, 1),
          BorderColor3 = Color3.new(0, 0, 0),
          BorderSizePixel = 1,
        })

        local v62 = f5("TextButton", {
          Parent = parent12,
          Size = UDim2.new(0, 15, 1, 0),
          Position = UDim2.new(1, -15, 0, 0),
          BackgroundColor3 = Color3.new(1, 1, 1),
          BorderColor3 = v2.Border,
          BorderSizePixel = 1,
          Text = "",
          AutoButtonColor = false,
        })

        f5("UIGradient", {
          Parent = v62,
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

        local v63 = f5("Frame", {
          Parent = v62,
          Size = UDim2.new(1, 2, 0, 2),
          AnchorPoint = Vector2.new(0.5, 0.5),
          Position = UDim2.new(0.5, 0, 1 - v53, 0),
          BackgroundColor3 = Color3.new(1, 1, 1),
          BorderColor3 = Color3.new(0, 0, 0),
          BorderSizePixel = 1,
        })

        local function f12()
          color = Color3.fromHSV(v53, v56, v57)
          v60.BackgroundColor3 = Color3.fromHSV(v53, 1, 1)
          v58.BackgroundColor3 = color

          if p34 then
            p34(color)
          end
        end

        local v64 = false
        v62.MouseButton1Down:Connect(function() v64 = true end)

        userInputService.InputEnded:Connect(function(input7)
          if input7.UserInputType == Enum.UserInputType.MouseButton1 then
            v64 = false
          end
        end)

        userInputService.InputChanged:Connect(function(input8)
          if v64 and input8.UserInputType == Enum.UserInputType.MouseMovement then
            local v65 = math.clamp((input8.Position.Y - v62.AbsolutePosition.Y)
              / v62.AbsoluteSize.Y, 0, 1)

            v53 = 1 - v65
            v63.Position = UDim2.new(0.5, 0, v65, 0)
            f12()
          end
        end)

        local v66 = false
        v60.MouseButton1Down:Connect(function() v66 = true end)

        userInputService.InputEnded:Connect(function(input9)
          if input9.UserInputType == Enum.UserInputType.MouseButton1 then
            v66 = false
          end
        end)

        userInputService.InputChanged:Connect(function(input10)
          if v66 and input10.UserInputType == Enum.UserInputType.MouseMovement then
            local v67 = math.clamp((input10.Position.X - v60.AbsolutePosition.X)
              / v60.AbsoluteSize.X, 0, 1)

            local clamp = math.clamp
            local y = input10.Position.Y
            local y2 = v60.AbsolutePosition.Y
            local y3 = v60.AbsoluteSize.Y
            local v68 = clamp((y - y2) / y3, 0, 1)
            v56 = v67
            v57 = 1 - v68
            v61.Position = UDim2.new(v67, 0, v68, 0)
            f12()
          end
        end)

        v58.MouseButton1Click:Connect(function() v59.Visible = not v59.Visible end)
      end

      function v26.CreateButton(p35, p36, p37)
        local v69 = f5("TextButton", {
          Parent = f5("Frame", {
            Parent = parent5,
            Size = UDim2.new(1, 0, 0, 20),
            BackgroundTransparency = 1,
          }),
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundColor3 = v2.ElementBg,
          BorderColor3 = v2.Border,
          BorderSizePixel = 1,
          Text = "  " .. p36,
          TextColor3 = v2.Text,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f3(f5("Frame", {
          Parent = v69,
          Size = UDim2.new(0, 2, 1, 0),
          BackgroundColor3 = v2.Accent,
          BorderSizePixel = 0,
        }))

        f8(v69)

        local v70 = f6(v69, v2.Accent)
        v70.Visible = false

        v69.MouseButton1Click:Connect(function()
          tweenService:Create(v69, TweenInfo.new(0.1), { BackgroundColor3 = v2.Accent }):Play()

          task.delay(0.1, function()
            tweenService:Create(v69, TweenInfo.new(0.1), { BackgroundColor3 = v2.ElementBg }):Play()
          end)

          if p37 then
            p37()
          end
        end)

        v69.MouseEnter:Connect(function()
          f2(v69)
          v70.Visible = true
        end)

        v69.MouseLeave:Connect(function()
          v69.TextColor3 = v2.Text
          v70.Visible = false
        end)
      end

      function v26:CreateLabel(text9)
        f8((f5("TextLabel", {
          Parent = f5("Frame", {
            Parent = parent5,
            Size = UDim2.new(1, 0, 0, 15),
            BackgroundTransparency = 1,
          }),
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundTransparency = 1,
          Text = text9,
          TextColor3 = v2.TextDark,
          Font = code,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })))
      end

      return v26
    end

    return v21
  end

  return v13
end

local window = v1:CreateWindow("Overdose.gg | MM2")
local visualTab = window:CreateTab("Visual")
local combatTab = window:CreateTab("Combat")
local itemsTab = window:CreateTab("Items")
local autoFarmTab = window:CreateTab("AutoFarm")
local settingsTab = window:CreateTab("Settings")

local v71 = {
  Box = false,
  Tracers = false,
  Names = false,
  Alpha2D = 1,
  ProtectRolesAlpha = false,
  InnocentColor = Color3.fromRGB(0, 255, 0),
  SheriffColor = Color3.fromRGB(0, 0, 255),
  MurdererColor = Color3.fromRGB(255, 0, 0),
  GunESP = false,
  GunColor = Color3.fromRGB(255, 255, 0),
  GlowEnabled = false,
  FillTrans = 0.65,
  OutlineTrans = 0.55,
}

getgenv().SilentAimEnabled = true
getgenv().V2AimEnabled = false
getgenv().SmartGameEnabled = false
getgenv().IsWaitingForPerfectShot = false
getgenv().KnifeSilentAimEnabled = false
getgenv().KnifeAuraEnabled = false
getgenv().BetterUIEnabled = false
getgenv().StretchResEnabled = false
getgenv().Resolution = { [".gg/scripters"] = 0.8 }

local function f13(p38, p39, filterDescendantsInstances)
  local raycastParams = RaycastParams.new()
  raycastParams.FilterDescendantsInstances = filterDescendantsInstances
  raycastParams.FilterType = Enum.RaycastFilterType.Exclude
  raycastParams.IgnoreWater = true

  return workspace:Raycast(p38, p39 - p38, raycastParams) == nil
end

local v72 = {}
local v73 = {}

local function f14()
  if workspace:FindFirstChild("Mansion2") and workspace.Mansion2:FindFirstChild("GunDrop") then
    return workspace.Mansion2.GunDrop
  end

  if workspace:FindFirstChild("Normal") and workspace.Normal:FindFirstChild("GunDrop") then
    return workspace.Normal.GunDrop
  end

  for index5, value12 in ipairs(workspace:GetChildren()) do
    if value12.Name == "GunDrop" then
      return value12
    end

    if (value12:IsA("Model") or value12:IsA("Folder")) and value12:FindFirstChild("GunDrop") then
      return value12.GunDrop
    end
  end

  return nil
end

local function f15(p40)
  local v74 = "Innocent"
  local innocentColor = v71.InnocentColor

  local function f16(p41)
    if not p41 then
      return
    end

    for key8, value13 in pairs(p41:GetChildren()) do
      if value13:IsA("Tool") then
        if value13:FindFirstChild("GunServer") then
          v74 = "Sheriff"
          innocentColor = v71.SheriffColor
        elseif value13:FindFirstChild("KnifeServer") then
          v74 = "Murderer"
          innocentColor = v71.MurdererColor
        end
      end
    end
  end

  f16(p40:FindFirstChild("Backpack"))

  if p40.Character then
    f16(p40.Character)
  end

  return v74, innocentColor
end

local v75

task.spawn(function()
  while task.wait(0.25) do
    v75 = f14()

    for index6, value14 in ipairs(players:GetPlayers()) do
      if value14 ~= players.LocalPlayer then
        local v76, v77 = f15(value14)
        v72[value14] = v76
        v73[value14] = v77
      end
    end
  end
end)

local function f17()
  for key9, value15 in pairs(v72) do
    if value15 == "Murderer" and key9.Character
      and key9.Character:FindFirstChild("HumanoidRootPart") then
      local humanoid = key9.Character:FindFirstChild("Humanoid")

      if humanoid and humanoid.Health > 0 then
        return key9.Character.HumanoidRootPart
      end
    end
  end

  return nil
end

local function f18()
  local huge = math.huge

  local humanoidRootPart = players.LocalPlayer.Character
    and players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart then
    return nil
  end

  local v78

  for key10, value16 in pairs(v72) do
    if key10 ~= players.LocalPlayer and value16 ~= "Murderer" and key10.Character then
      local humanoidRootPart2 = key10.Character:FindFirstChild("HumanoidRootPart")
      local humanoid2 = key10.Character:FindFirstChild("Humanoid")

      if humanoidRootPart2 and humanoid2 and humanoid2.Health > 0 then
        local magnitude = (humanoidRootPart2.Position - humanoidRootPart.Position).Magnitude

        if magnitude < huge then
          huge = magnitude
          v78 = humanoidRootPart2
        end
      end
    end
  end

  return v78
end

local function f19(p42)
  if p42:IsA("Frame") or p42:IsA("ScrollingFrame") or p42:IsA("ImageLabel") then
    p42:GetPropertyChangedSignal("Visible"):Connect(function()
      if getgenv().BetterUIEnabled and p42.Visible then
        if p42.Size.X.Offset > 40 or p42.Size.Y.Offset > 40 or p42.Size.X.Scale > 0.1 then
          local smoothUIScale = p42:FindFirstChild("SmoothUIScale")

          if not smoothUIScale then
            smoothUIScale = Instance.new("UIScale")
            smoothUIScale.Name = "SmoothUIScale"
            smoothUIScale.Parent = p42
          end

          smoothUIScale.Scale = 0.85

          tweenService:Create(
            smoothUIScale, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            { Scale = 1 }
          ):Play()
        end
      end
    end)
  elseif p42:IsA("ScreenGui") then
    p42:GetPropertyChangedSignal("Enabled"):Connect(function()
      if getgenv().BetterUIEnabled and p42.Enabled then
        for index7, value17 in ipairs(p42:GetChildren()) do
          if value17:IsA("Frame") or value17:IsA("ScrollingFrame") then
            local smoothUIScale2 = value17:FindFirstChild("SmoothUIScale")

            if not smoothUIScale2 then
              smoothUIScale2 = Instance.new("UIScale")
              smoothUIScale2.Name = "SmoothUIScale"
              smoothUIScale2.Parent = value17
            end

            smoothUIScale2.Scale = 0.85

            tweenService:Create(smoothUIScale2, TweenInfo.new(
              0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out
            ), { Scale = 1 }):Play()
          end
        end
      end
    end)
  end
end

for key11, value18 in pairs(players.LocalPlayer:WaitForChild("PlayerGui"):GetDescendants()) do
  f19(value18)
end

players.LocalPlayer.PlayerGui.DescendantAdded:Connect(f19)

local function f20(p43)
  if getgenv().V2AimEnabled then
    return CFrame.new(p43.Position + p43.AssemblyLinearVelocity * 0.12)
  end

  return p43.CFrame
end

if not getgenv().WeaponServiceHooked then
  getgenv().WeaponServiceHooked = true

  task.spawn(function()
    local waitForChild = replicatedStorage:WaitForChild("ClientServices", 10)
    local waitForChild2 = waitForChild and waitForChild:WaitForChild("WeaponService", 10)
    local getMouseTargetCFrame, getTargetPosition

    if waitForChild2 then
      local v79 = require(waitForChild2)
      getMouseTargetCFrame = v79.GetMouseTargetCFrame

      function v79.GetMouseTargetCFrame(...)
        local tool = players.LocalPlayer.Character
          and players.LocalPlayer.Character:FindFirstChildOfClass("Tool")

        if tool then
          if tool:FindFirstChild("GunServer") and getgenv().SilentAimEnabled then
            local v80 = f17()

            if v80 then
              return f20(v80)
            end

            return getMouseTargetCFrame(...)
          end

          if tool:FindFirstChild("KnifeServer") and getgenv().KnifeSilentAimEnabled then
            local v81 = f18()

            if v81 then
              return f20(v81)
            end

            return getMouseTargetCFrame(...)
          end

          return getMouseTargetCFrame(...)
        end

        return getMouseTargetCFrame(...)
      end

      getTargetPosition = v79.GetTargetPosition

      function v79.GetTargetPosition(...)
        local tool2 = players.LocalPlayer.Character
          and players.LocalPlayer.Character:FindFirstChildOfClass("Tool")

        if tool2 then
          if tool2:FindFirstChild("GunServer") and getgenv().SilentAimEnabled then
            local v82 = f17()

            if v82 then
              return f20(v82)
            end

            return getTargetPosition(...)
          end

          if tool2:FindFirstChild("KnifeServer") and getgenv().KnifeSilentAimEnabled then
            local v83 = f18()

            if v83 then
              return f20(v83)
            end

            return getTargetPosition(...)
          end

          return getTargetPosition(...)
        end

        return getTargetPosition(...)
      end
    end
  end)
end

task.spawn(function()
  while task.wait(0.03) do
    if getgenv().IsWaitingForPerfectShot and getgenv().SmartGameEnabled
      and players.LocalPlayer.Character then
      local tool3 = players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
      local humanoidRootPart3 = players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

      if tool3 and tool3:FindFirstChild("GunServer") and humanoidRootPart3 then
        local v84 = f17()

        if v84 then
          if f13(humanoidRootPart3.Position, v84.Position, {
            players.LocalPlayer.Character, v84.Parent,
          }) then
            virtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
            task.wait(0.05)
            virtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
            getgenv().IsWaitingForPerfectShot = false
          end
        end
      end
    end
  end
end)

task.spawn(function()
  while task.wait(0.05) do
    if getgenv().KnifeAuraEnabled and players.LocalPlayer.Character then
      local tool4 = players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
      local humanoidRootPart4 = players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

      if tool4 and tool4:FindFirstChild("KnifeServer") and humanoidRootPart4 then
        local v85 = f18()

        if v85 then
          if (humanoidRootPart4.Position - v85.Position).Magnitude <= 400 then
            local handle = tool4:FindFirstChild("Handle")
            local events = tool4:FindFirstChild("Events")

            if events and events:FindFirstChild("HandleTouched") then
              events.HandleTouched:FireServer(v85)
            end

            if handle and firetouchinterest then
              firetouchinterest(handle, v85, 0)
              task.wait(0.01)
              firetouchinterest(handle, v85, 1)
            end
          end
        end
      end
    end
  end
end)

local colorsSection = visualTab:CreateSection("Colors", "Right")

colorsSection:CreateColorPicker("Innocent Color", Color3.fromRGB(0, 255, 0), 0, function(innocentColor2)
  v71.InnocentColor = innocentColor2
end)

colorsSection:CreateColorPicker("Sheriff Color", Color3.fromRGB(0, 0, 255), 0, function(sheriffColor)
  v71.SheriffColor = sheriffColor
end)

colorsSection:CreateColorPicker("Murderer Color", Color3.fromRGB(255, 0, 0), 0, function(murdererColor)
  v71.MurdererColor = murdererColor
end)

local glowSection = visualTab:CreateSection("Glow", "Left")
glowSection:CreateToggle("Glow", false, function(glowEnabled) v71.GlowEnabled = glowEnabled end)

glowSection:CreateSlider("Body Trans", 0, 1, 0.65, function(fillTrans)
  v71.FillTrans = fillTrans
end)

glowSection:CreateSlider("Out Trans", 0, 1, 0.55, function(outlineTrans)
  v71.OutlineTrans = outlineTrans
end)

local espSection = visualTab:CreateSection("ESP", "Right")
espSection:CreateSlider("Alpha", 0, 1, 1, function(alpha2D) v71.Alpha2D = alpha2D end)

espSection:CreateToggle("Prot Alpha", false, function(protectRolesAlpha)
  v71.ProtectRolesAlpha = protectRolesAlpha
end)

espSection:CreateToggle("Names", false, function(names) v71.Names = names end)
espSection:CreateToggle("Boxes", false, function(box) v71.Box = box end)
espSection:CreateToggle("Tracers", false, function(tracers) v71.Tracers = tracers end)

local gunSection = combatTab:CreateSection("Gun", "Left")

gunSection:CreateToggle("Silent", true, function(silentAimEnabled)
  getgenv().SilentAimEnabled = silentAimEnabled
end)

gunSection:CreateToggle("V2 Aim", false, function(v2AimEnabled)
  getgenv().V2AimEnabled = v2AimEnabled
end)

gunSection:CreateToggle("Smart", false, function(smartGameEnabled)
  getgenv().SmartGameEnabled = smartGameEnabled
end)

gunSection:CreateKeybind("Attack", Enum.KeyCode.Q, function(p44, p45)
  if getgenv().SmartGameEnabled then
    getgenv().IsWaitingForPerfectShot = true
    task.delay(3, function() getgenv().IsWaitingForPerfectShot = false end)
  elseif players.LocalPlayer.Character
    and players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
    virtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
    task.wait(0.05)
    virtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
  end
end)

local knifeSection = combatTab:CreateSection("Knife", "Right")

knifeSection:CreateToggle("Silent", false, function(knifeSilentAimEnabled)
  getgenv().KnifeSilentAimEnabled = knifeSilentAimEnabled
end)

knifeSection:CreateToggle("Aura", false, function(knifeAuraEnabled)
  getgenv().KnifeAuraEnabled = knifeAuraEnabled
end)

local gunSection2 = itemsTab:CreateSection("Gun", "Left")
gunSection2:CreateToggle("ESP", false, function(gunESP) v71.GunESP = gunESP end)

gunSection2:CreateColorPicker("Gun ESP Color", Color3.fromRGB(255, 255, 0), 0, function(gunColor)
  v71.GunColor = gunColor
end)

gunSection2:CreateToggle("Auto Pickup", false, function(p46) end)

gunSection2:CreateKeybind("Pickup", Enum.KeyCode.E, function(p47, p48)
  local v86 = v75 or f14()
  local character = players.LocalPlayer.Character

  if v86 and character and character:FindFirstChild("HumanoidRootPart") then
    if v72[players.LocalPlayer] == "Murderer" then
      return
    end

    local humanoidRootPart5 = character.HumanoidRootPart
    local v87 = getgenv and getgenv().firetouchinterest

    if v87 then
      v87(humanoidRootPart5, v86, 0)
      task.wait(0.01)
      v87(humanoidRootPart5, v86, 1)
    else
      local cframe = humanoidRootPart5.CFrame
      humanoidRootPart5.CFrame = v86.CFrame
      task.wait(0.1)
      humanoidRootPart5.CFrame = cframe
    end

    return
  end
end)

local uiSection = settingsTab:CreateSection("UI", "Left")
uiSection:CreateColorPicker("Accent Color", v2.Accent, 0, function(p49) v1:ChangeAccent(p49) end)

uiSection:CreateToggle("Smooth UI", false, function(betterUIEnabled)
  getgenv().BetterUIEnabled = betterUIEnabled
end)

uiSection:CreateKeybind("Menu Key", Enum.KeyCode.Home, function(p50, p51)
  if p51 then
    getgenv().ToggleUIKey = p51
  end
end)

local fovSection = settingsTab:CreateSection("FOV", "Right")

fovSection:CreateToggle("Stretch", false, function(stretchResEnabled)
  getgenv().StretchResEnabled = stretchResEnabled
end)

fovSection:CreateSlider("Amount", 0.1, 1.5, 0.8, function(ggScripters)
  getgenv().Resolution[".gg/scripters"] = ggScripters
end)

local v88 = {}

local function f21(p52)
  local v89 = {
    BoxOutline = Drawing.new("Square"),
    Box = Drawing.new("Square"),
    TracerOutline = Drawing.new("Line"),
    Tracer = Drawing.new("Line"),
    Name = Drawing.new("Text"),
    Highlight = Instance.new("Highlight"),
  }

  v89.Highlight.Parent = nil
  v89.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
  v89.BoxOutline.Thickness = 3
  v89.BoxOutline.Filled = false
  v89.BoxOutline.Color = Color3.new(0, 0, 0)
  v89.Box.Thickness = 1
  v89.Box.Filled = false
  v89.TracerOutline.Thickness = 3
  v89.TracerOutline.Color = Color3.new(0, 0, 0)
  v89.Tracer.Thickness = 1
  v89.Name.Size = 16
  v89.Name.Center = true
  v89.Name.Outline = true
  v89.Name.OutlineColor = Color3.new(0, 0, 0)

  v88[p52] = v89
end

for index8, value19 in ipairs(players:GetPlayers()) do
  if value19 ~= players.LocalPlayer then
    f21(value19)
  end
end

players.PlayerAdded:Connect(f21)

players.PlayerRemoving:Connect(function(player)
  if v88[player] then
    for key12, value20 in pairs(v88[player]) do
      if typeof(value20) == "Instance" then
        value20:Destroy()
      elseif value20.Remove then
        value20:Remove()
      end
    end

    v88[player] = nil
  end
end)

local viewportFrame = Instance.new("ViewportFrame")
viewportFrame.Size = UDim2.new(0, 90, 0, 60)
viewportFrame.AnchorPoint = Vector2.new(0.5, 0.5)
viewportFrame.BackgroundTransparency = 1
viewportFrame.ClipsDescendants = true
viewportFrame.Parent = v6
viewportFrame.Visible = false

local camera = Instance.new("Camera")
camera.CFrame = CFrame.new(Vector3.new(0, 3.5, 14), Vector3.new(0, 1.5, 0))

viewportFrame.CurrentCamera = camera
camera.Parent = viewportFrame

local part = Instance.new("Part")
part.Size = Vector3.new(1, 1, 1)
part.Position = Vector3.new(0, 0, 0)
part.Material = Enum.Material.SmoothPlastic
part.Parent = viewportFrame

local specialMesh = Instance.new("SpecialMesh")
specialMesh.MeshId = "rbxassetid://6600918074"
specialMesh.Scale = Vector3.new(0.35, 0.35, 0.35)
specialMesh.Parent = part

local v90 = {
  Text = Drawing.new("Text"),
  TracerOutline = Drawing.new("Line"),
  Tracer = Drawing.new("Line"),
}

v90.Text.Size = 16
v90.Text.Center = true
v90.Text.Outline = true
v90.Text.OutlineColor = Color3.new(0, 0, 0)
v90.TracerOutline.Thickness = 3
v90.TracerOutline.Color = Color3.new(0, 0, 0)
v90.Tracer.Thickness = 1

local total = 0

runService.RenderStepped:Connect(function(delta)
  if getgenv().StretchResEnabled then
    currentCamera.CFrame = currentCamera.CFrame * CFrame.new(
      0, 0, 0, 1, 0, 0, 0, getgenv().Resolution[".gg/scripters"], 0, 0, 0, 1
    )
  end

  for key13, value21 in pairs(v88) do
    local character2 = key13.Character
    local v91 = v72[key13]
    local v92 = false
    local v93 = v91 or "Innocent"
    local innocentColor3 = v73[key13] or v71.InnocentColor
    local alpha2D2 = v71.Alpha2D

    if v71.ProtectRolesAlpha and (v93 == "Sheriff" or v93 == "Murderer") then
      alpha2D2 = 1
    end

    if v71.GlowEnabled and character2 and character2:FindFirstChild("Humanoid")
      and character2.Humanoid.Health > 0 then
      value21.Highlight.Parent = character2
      value21.Highlight.Enabled = true
      value21.Highlight.FillColor = innocentColor3
      value21.Highlight.OutlineColor = innocentColor3

      if v71.ProtectRolesAlpha and v93 ~= "Innocent" then
        value21.Highlight.FillTransparency = 0.2
        value21.Highlight.OutlineTransparency = 0.1
      else
        value21.Highlight.FillTransparency = v71.FillTrans
        value21.Highlight.OutlineTransparency = v71.OutlineTrans
      end
    else
      value21.Highlight.Enabled = false
      value21.Highlight.Parent = nil
    end

    if character2 and character2:FindFirstChild("HumanoidRootPart")
      and character2:FindFirstChild("Humanoid") and character2.Humanoid.Health > 0 then
      local humanoidRootPart6 = character2.HumanoidRootPart
      local head = character2:FindFirstChild("Head")

      if head then
        local v94, v95 = currentCamera:WorldToViewportPoint(humanoidRootPart6.Position)

        local worldToViewportPoint = currentCamera:WorldToViewportPoint(head.Position
          + Vector3.new(0, 0.5, 0))

        local worldToViewportPoint2 = currentCamera:WorldToViewportPoint(humanoidRootPart6.Position
          - Vector3.new(0, 3, 0))

        if v95 then
          v92 = true
          local v96 = math.abs(worldToViewportPoint.Y - worldToViewportPoint2.Y)
          local v97 = v96 / 2
          local vector = Vector2.new(v97, v96)
          local vector2 = Vector2.new(v94.X - v97 / 2, worldToViewportPoint.Y)

          if v71.Box then
            value21.BoxOutline.Size = vector
            value21.BoxOutline.Position = vector2
            value21.BoxOutline.Visible = true
            value21.BoxOutline.Transparency = alpha2D2
            value21.Box.Size = vector
            value21.Box.Position = vector2
            value21.Box.Color = innocentColor3
            value21.Box.Visible = true
            value21.Box.Transparency = alpha2D2
          else
            value21.BoxOutline.Visible = false
            value21.Box.Visible = false
          end

          if v71.Tracers then
            local vector3 = Vector2.new(
              currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y
            )

            value21.TracerOutline.From = vector3
            value21.TracerOutline.To = Vector2.new(v94.X, v94.Y)
            value21.TracerOutline.Visible = true
            value21.TracerOutline.Transparency = alpha2D2
            value21.Tracer.From = vector3
            value21.Tracer.To = Vector2.new(v94.X, v94.Y)
            value21.Tracer.Color = innocentColor3
            value21.Tracer.Visible = true
            value21.Tracer.Transparency = alpha2D2
          else
            value21.TracerOutline.Visible = false
            value21.Tracer.Visible = false
          end

          if v71.Names then
            value21.Name.Text = key13.DisplayName
            value21.Name.Position = Vector2.new(vector2.X + v97 / 2, vector2.Y - 18)
            value21.Name.Color = innocentColor3
            value21.Name.Visible = true
            value21.Name.Transparency = 1
          else
            value21.Name.Visible = false
          end
        end
      end
    end

    if not v92 then
      value21.BoxOutline.Visible = false
      value21.Box.Visible = false
      value21.TracerOutline.Visible = false
      value21.Tracer.Visible = false
      value21.Name.Visible = false
    end
  end

  local v98 = v75
  local position2

  if v71.GunESP and v98 then
    if v98:IsA("BasePart") then
      position2 = v98.Position
    elseif v98:FindFirstChild("Handle") then
      position2 = v98.Handle.Position
    else
      position2 = v98:GetPivot().Position
    end

    if position2 then
      local v99, v100 = currentCamera:WorldToViewportPoint(position2)

      if v100 then
        total = total + delta * 100

        part.CFrame = CFrame.Angles(0, math.rad(total), 0)
        part.Color = v71.GunColor

        viewportFrame.Position = UDim2.new(0, v99.X, 0, v99.Y - 50)
        viewportFrame.Visible = true

        v90.Text.Text = "[GUN]"
        v90.Text.Position = Vector2.new(v99.X, v99.Y - 15)
        v90.Text.Color = v71.GunColor
        v90.Text.Visible = true

        local vector4 = Vector2.new(
          currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y
        )

        v90.TracerOutline.From = vector4
        v90.TracerOutline.To = Vector2.new(v99.X, v99.Y)
        v90.TracerOutline.Visible = true
        v90.Tracer.From = vector4
        v90.Tracer.To = Vector2.new(v99.X, v99.Y)
        v90.Tracer.Color = v71.GunColor
        v90.Tracer.Visible = true
      else
        v90.Text.Visible = false
        v90.TracerOutline.Visible = false
        v90.Tracer.Visible = false

        viewportFrame.Visible = false
      end
    end
  else
    v90.Text.Visible = false
    v90.TracerOutline.Visible = false
    v90.Tracer.Visible = false

    viewportFrame.Visible = false
  end
end)
