local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local httpService = game:GetService("HttpService")
getgenv().OverdoseUnloaded = false
local new = Vector2.new
local new2 = Vector3.new
local new3 = Color3.new
local fromRGB = Color3.fromRGB
local floor = math.floor
local clamp = math.clamp
local abs = math.abs
local sin = math.sin
local cos = math.cos
local max = math.max

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

local v2 = {
  MainBg = fromRGB(26, 26, 26),
  SectionBg = fromRGB(22, 22, 22),
  ElementBg = fromRGB(38, 38, 38),
  BorderOuter = fromRGB(8, 8, 8),
  BorderInner = fromRGB(57, 57, 57),
  Accent = fromRGB(100, 100, 255),
  Text = fromRGB(170, 170, 170),
  TextDark = fromRGB(90, 90, 90),
}

local v3 = {
  Bg = {},
  Text = {},
  Image = {},
  Gradient = {},
}

local function f1(p1)
  table.insert(v3.Bg, p1)
  return p1
end

local function f2(p2)
  table.insert(v3.Text, p2)
  return p2
end

local function f3(p3)
  if not p3 then
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
  })[p3] or p3.Name
end

local function f4(p4, p5)
  local inputBegan = p4.InputBegan
  local v4, position, position2

  inputBegan:Connect(function(p6)
    if p6.UserInputType == Enum.UserInputType.MouseButton1 then
      v4 = true
      position = p6.Position
      position2 = p5.Position

      p6.Changed:Connect(function()
        if p6.UserInputState == Enum.UserInputState.End then
          v4 = false
        end
      end)
    end
  end)

  local v5

  p4.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
      v5 = input
    end
  end)

  userInputService.InputChanged:Connect(function(input2)
    if input2 == v5 and v4 then
      local v6 = input2.Position - position

      p5.Position = UDim2.new(
        position2.X.Scale, position2.X.Offset + v6.X, position2.Y.Scale,
        position2.Y.Offset + v6.Y
      )
    end
  end)
end

local code = Enum.Font.Code

local function f5(p7)
  for index, value in ipairs(v1.popups) do
    if value ~= p7 and value.Visible then
      value.Visible = false
    end
  end
end

local v7

local function f6(p8)
  if v7 then
    pcall(function() p8.FontFace = v7 end)
  else
    p8.Font = code
  end
end

local function f7(p9, p10)
  local instance = Instance.new(p9)

  for key, value2 in pairs(p10) do
    instance[key] = value2
  end

  table.insert(v1.instances, instance)
  return instance
end

local function f8(parent, p11, p12, p13)
  local v8 = f7("ImageLabel", {
    Name = "GlowEffect",
    Image = "http://www.roblox.com/asset/?id=18245826428",
    ImageColor3 = p11 or v2.Accent,
    ImageTransparency = 0.85,
    BackgroundTransparency = 1,
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(21, 21, 79, 79),
    ZIndex = 0,
    BorderSizePixel = 0,
    Parent = parent,
  })

  if p12 then
    v8.Position = UDim2.new(0, -20, 0, -20)
    v8.Size = UDim2.new(1, 40, 0, 42)
  else
    v8.Position = UDim2.new(0, -12, 0, -12)
    v8.Size = UDim2.new(1, 24, 1, 24)
  end

  if not p13 then
    table.insert(v3.Image, v8)
  end

  return v8
end

local function f9(parent2)
  local uiStroke = Instance.new("UIStroke")
  uiStroke.Color = new3(0, 0, 0)
  uiStroke.Thickness = 1
  uiStroke.Transparency = 0.5
  uiStroke.Parent = parent2
end

local v9 = f7("ScreenGui", {
  Name = "OverdoseUI",
  ResetOnSpawn = false,
  DisplayOrder = 99999,
  ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
})

if not pcall(function()
  if gethui then
    v9.Parent = gethui()
  elseif syn and syn.protect_gui then
    syn.protect_gui(v9)
    v9.Parent = coreGui
  else
    v9.Parent = coreGui
  end
end) or not v9.Parent then
  v9.Parent = players.LocalPlayer:WaitForChild("PlayerGui")
end

runService.RenderStepped:Connect(function() v1.sin = abs(sin(os.clock() * 1.5)) end)
getgenv().ToggleUIKey = Enum.KeyCode.Insert

userInputService.InputBegan:Connect(function(input3, p14)
  if input3.KeyCode == getgenv().ToggleUIKey then
    if getgenv().MainGuiFrame then
      getgenv().MainGuiFrame.Visible = not getgenv().MainGuiFrame.Visible
    end
  end
end)

function v1:ChangeAccent(p15)
  v2.Accent = p15

  for key2, value3 in pairs(v3.Bg) do
    if value3 and value3.Parent then
      value3.BackgroundColor3 = p15
    end
  end

  for key3, value4 in pairs(v3.Text) do
    if value4 and value4.Parent then
      value4.TextColor3 = p15
    end
  end

  for key4, value5 in pairs(v3.Image) do
    if value5 and value5.Parent then
      value5.ImageColor3 = p15
    end
  end

  if self.UpdateKeybindList then
    self:UpdateKeybindList()
  end
end

local v10 = f7("Frame", {
  Parent = v9,
  Position = UDim2.new(0, 20, 0, 60),
  Size = UDim2.new(0, 180, 0, 24),
  BackgroundColor3 = v2.BorderOuter,
  BorderSizePixel = 0,
  Active = true,
  Visible = false,
})

f4(v10, v10)

local parent3 = f7("Frame", {
  Parent = f7("Frame", {
    Parent = v10,
    Position = UDim2.new(0, 1, 0, 1),
    Size = UDim2.new(1, -2, 1, -2),
    BackgroundColor3 = v2.MainBg,
    BorderSizePixel = 0,
  }),
  Position = UDim2.new(0, 1, 0, 1),
  Size = UDim2.new(1, -2, 1, -2),
  BackgroundColor3 = v2.MainBg,
  BorderColor3 = v2.BorderInner,
  BorderSizePixel = 1,
})

f8(f1(f7("Frame", {
  Parent = parent3,
  Size = UDim2.new(1, 0, 0, 2),
  BackgroundColor3 = v2.Accent,
  BorderSizePixel = 0,
  ZIndex = 3,
})), v2.Accent, true)

local v11 = f7("TextLabel", {
  Parent = parent3,
  Size = UDim2.new(1, 0, 0, 20),
  Position = UDim2.new(0, 0, 0, 2),
  BackgroundTransparency = 1,
  Text = "keybinds",
  TextColor3 = v2.Text,
  TextSize = 12,
  TextXAlignment = Enum.TextXAlignment.Center,
  ZIndex = 4,
})

f6(v11)
f9(v11)

local v12 = f7("Frame", {
  Parent = parent3,
  Position = UDim2.new(0, 0, 0, 24),
  Size = UDim2.new(1, 0, 1, -24),
  BackgroundTransparency = 1,
})

f7("UIListLayout", {
  Parent = v12,
  Padding = UDim.new(0, 2),
  HorizontalAlignment = Enum.HorizontalAlignment.Center,
})

f7("UIPadding", {
  Parent = v12,
  PaddingTop = UDim.new(0, 4),
  PaddingBottom = UDim.new(0, 6),
  PaddingLeft = UDim.new(0, 8),
  PaddingRight = UDim.new(0, 8),
})

function v1:UpdateKeybindList()
  for index2, value6 in ipairs(v12:GetChildren()) do
    if value6:IsA("Frame") then
      value6:Destroy()
    end
  end

  local count = 0
  local text

  for key5, value7 in pairs(self.RegisteredKeybinds) do
    if value7.key then
      count = count + 1

      local parent4 = f7("Frame", {
        Parent = v12,
        Size = UDim2.new(1, 0, 0, 14),
        BackgroundTransparency = 1,
      })

      local v13 = f7("TextLabel", {
        Parent = parent4,
        Size = UDim2.new(0.5, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = key5,
        TextColor3 = v2.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
      })

      f6(v13)
      f9(v13)
      local textDark = v2.TextDark

      if value7.mode == "always" then
        text = "[always]"
        textDark = v2.Accent
      elseif value7.state then
        text = value7.mode == "hold" and "[hold]"
        textDark = v2.Accent
      else
        text = "[none]"
      end

      local v14 = f7("TextLabel", {
        Parent = parent4,
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = textDark,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Right,
      })

      f6(v14)
      f9(v14)

      if textDark == v2.Accent then
        f2(v14)
      end
    end
  end

  v10.Size = UDim2.new(0, 180, 0, 24 + (count > 0 and count * 14 + (count - 1) * 2 + 10 or 0))
end

function v1:SetKeybindsVisible(visible)
  v10.Visible = visible
end

local v15 = f7("Frame", {
  Parent = v9,
  Position = UDim2.new(0, 20, 0, 20),
  Size = UDim2.new(0, 200, 0, 24),
  BackgroundColor3 = v2.BorderOuter,
  BorderSizePixel = 0,
  Active = true,
})

f4(v15, v15)

local parent5 = f7("Frame", {
  Parent = f7("Frame", {
    Parent = v15,
    Position = UDim2.new(0, 1, 0, 1),
    Size = UDim2.new(1, -2, 1, -2),
    BackgroundColor3 = v2.MainBg,
    BorderSizePixel = 0,
  }),
  Position = UDim2.new(0, 1, 0, 1),
  Size = UDim2.new(1, -2, 1, -2),
  BackgroundColor3 = v2.MainBg,
  BorderColor3 = v2.BorderInner,
  BorderSizePixel = 1,
})

f8(f1(f7("Frame", {
  Parent = parent5,
  Size = UDim2.new(1, 0, 0, 2),
  BackgroundColor3 = v2.Accent,
  BorderSizePixel = 0,
  ZIndex = 3,
})), v2.Accent, true)

local v16 = f7("TextLabel", {
  Parent = parent5,
  Size = UDim2.new(1, 0, 1, 0),
  Position = UDim2.new(0, 8, 0, 0),
  BackgroundTransparency = 1,
  Text = "Overdose.gg | FPS: 0",
  TextColor3 = v2.Text,
  TextSize = 12,
  TextXAlignment = Enum.TextXAlignment.Left,
  ZIndex = 4,
})

f6(v16)
f9(v16)
local v17 = os.clock()
local v18 = 0
local v19 = v17

runService.RenderStepped:Connect(function()
  v18 = v18 + 1
  local v20 = os.clock()

  if v20 - v19 >= 1 then
    v16.Text = string.format("Overdose.gg | FPS: %d", v18)
    v15.Size = UDim2.new(0, v16.TextBounds.X + 26, 0, 24)
    v18 = 0
    v19 = v20
  end
end)

function v1:CreateWindow(text2)
  local v21 = {}

  local v22 = f7("Frame", {
    Parent = v9,
    Size = UDim2.new(0, 700, 0, 480),
    Position = UDim2.new(0.5, -350, 0.5, -240),
    BackgroundColor3 = v2.BorderOuter,
    BorderSizePixel = 0,
    ZIndex = 2,
    Active = true,
  })

  getgenv().MainGuiFrame = v22

  local parent6 = f7("Frame", {
    Parent = f7("Frame", {
      Parent = v22,
      Position = UDim2.new(0, 1, 0, 1),
      Size = UDim2.new(1, -2, 1, -2),
      BackgroundColor3 = v2.MainBg,
      BorderSizePixel = 0,
    }),
    Position = UDim2.new(0, 1, 0, 1),
    Size = UDim2.new(1, -2, 1, -2),
    BackgroundColor3 = v2.MainBg,
    BorderColor3 = v2.BorderInner,
    BorderSizePixel = 1,
  })

  f8(f1(f7("Frame", {
    Parent = parent6,
    Size = UDim2.new(1, 0, 0, 2),
    BackgroundColor3 = v2.Accent,
    BorderSizePixel = 0,
    ZIndex = 3,
  })), v2.Accent, true)

  local v23 = f7("Frame", {
    Parent = parent6,
    Size = UDim2.new(1, 0, 0, 25),
    BackgroundTransparency = 1,
    ZIndex = 5,
  })

  f4(v23, v22)

  local v24 = f7("TextLabel", {
    Parent = v23,
    Size = UDim2.new(1, -10, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1,
    Text = text2,
    TextColor3 = v2.Text,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
  })

  f6(v24)
  f9(v24)

  local v25 = f7("Frame", {
    Parent = parent6,
    Size = UDim2.new(1, -32, 0, 30),
    Position = UDim2.new(0, 16, 0, 4),
    BackgroundTransparency = 1,
  })

  f7("UIListLayout", {
    Parent = v25,
    FillDirection = Enum.FillDirection.Horizontal,
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder,
  })

  local v26 = f7("Frame", {
    Parent = f7("Frame", {
      Parent = parent6,
      Position = UDim2.new(0, 15, 0, 33),
      Size = UDim2.new(1, -30, 1, -48),
      BackgroundColor3 = fromRGB(19, 19, 19),
      BorderSizePixel = 0,
    }),
    Position = UDim2.new(0, 2, 0, 2),
    Size = UDim2.new(1, -4, 1, -4),
    BackgroundColor3 = v2.SectionBg,
    BorderColor3 = fromRGB(56, 56, 56),
    BorderSizePixel = 1,
  })

  local v27 = true

  function v21:CreateTab(text3)
    local v28 = {}

    local v29 = f7("TextButton", {
      Parent = v25,
      Size = UDim2.new(0.333, -4, 0, 22),
      BackgroundTransparency = 1,
      Text = text3,
      TextColor3 = v27 and v2.Text or v2.TextDark,
      TextSize = 12,
    })

    f6(v29)
    f9(v29)

    local v30 = f7("Frame", {
      Parent = v29,
      Position = UDim2.new(0, 0, 1, 0),
      Size = UDim2.new(1, 0, 0, 2),
      BackgroundColor3 = v27 and v2.Accent or v2.BorderInner,
      BorderSizePixel = 0,
    })

    if v27 then
      f1(v30)
      f2(v29)
    end

    local v31 = f7("Frame", {
      Parent = v26,
      Size = UDim2.new(1, -12, 1, -12),
      Position = UDim2.new(0, 6, 0, 6),
      BackgroundTransparency = 1,
      Visible = v27,
    })

    local v32 = f7("ScrollingFrame", {
      Parent = v31,
      Size = UDim2.new(0.5, -4, 1, 0),
      Position = UDim2.new(0, 0, 0, 0),
      BackgroundTransparency = 1,
      ScrollBarThickness = 0,
      AutomaticCanvasSize = Enum.AutomaticSize.Y,
      CanvasSize = UDim2.new(0, 0, 0, 0),
    })

    f7("UIListLayout", { Parent = v32, Padding = UDim.new(0, 6) })

    local v33 = f7("ScrollingFrame", {
      Parent = v31,
      Size = UDim2.new(0.5, -4, 1, 0),
      Position = UDim2.new(0.5, 4, 0, 0),
      BackgroundTransparency = 1,
      ScrollBarThickness = 0,
      AutomaticCanvasSize = Enum.AutomaticSize.Y,
      CanvasSize = UDim2.new(0, 0, 0, 0),
    })

    f7("UIListLayout", { Parent = v33, Padding = UDim.new(0, 6) })

    v29.MouseButton1Click:Connect(function()
      for key6, value8 in pairs(v26:GetChildren()) do
        if value8:IsA("Frame") then
          value8.Visible = false
        end
      end

      for key7, value9 in pairs(v25:GetChildren()) do
        if value9:IsA("TextButton") then
          value9.TextColor3 = v2.TextDark
          value9:FindFirstChildOfClass("Frame").BackgroundColor3 = v2.BorderInner
        end
      end

      v31.Visible = true
      v29.TextColor3 = v2.Text
      v30.BackgroundColor3 = v2.Accent
      f5()
    end)

    v27 = false

    function v28:CreateSection(text4, p16)
      local v34 = {}

      local parent7 = f7("Frame", {
        Parent = f7("Frame", {
          Parent = p16:lower() == "left" and v32 or v33,
          Size = UDim2.new(1, 0, 0, 0),
          BackgroundTransparency = 1,
          AutomaticSize = Enum.AutomaticSize.Y,
        }),
        Position = UDim2.new(0, 0, 0, 4),
        Size = UDim2.new(1, 0, 1, -4),
        BackgroundColor3 = v2.BorderOuter,
        BorderSizePixel = 0,
      })

      local udim = UDim2.new(0, 2, 0, 2)
      local udim2 = UDim2.new(1, -4, 1, -4)
      local borderColor3 = fromRGB(56, 56, 56)

      local parent8 = f7("Frame", {
        Parent = parent7,
        Position = udim,
        Size = udim2,
        BackgroundColor3 = v2.SectionBg,
        BorderColor3 = borderColor3,
        BorderSizePixel = 1,
      })

      local v35 = f7("TextLabel", {
        Parent = parent7,
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 8, 0, 0),
        BackgroundTransparency = 1,
        Text = text4,
        TextColor3 = v2.Text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2,
      })

      f6(v35)
      f9(v35)

      local parent9 = f7("Frame", {
        Parent = parent8,
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 16),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
      })

      f7("UIListLayout", { Parent = parent9, Padding = UDim.new(0, 5) })

      f7("UIPadding", {
        Parent = parent9,
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8),
        PaddingTop = UDim.new(0, 2),
        PaddingBottom = UDim.new(0, 10),
      })

      function v34:CreateToggle(text5, p17, p18)
        local v36 = p17 or false

        local v37 = f7("TextButton", {
          Parent = parent9,
          Size = UDim2.new(1, 0, 0, 12),
          BackgroundTransparency = 1,
          Text = "",
          AutoButtonColor = false,
        })

        local v38 = f7("Frame", {
          Parent = v37,
          Size = UDim2.new(0, 10, 0, 10),
          Position = UDim2.new(0, 0, 0, 1),
          BackgroundColor3 = v2.BorderOuter,
          BorderSizePixel = 0,
        })

        local udim3 = UDim2.new(1, -4, 1, -4)
        local udim4 = UDim2.new(0, 2, 0, 2)
        local borderColor32 = fromRGB(56, 56, 56)

        local v39 = f1(f7("Frame", {
          Parent = f7("Frame", {
            Parent = v38,
            Size = udim3,
            Position = udim4,
            BackgroundColor3 = v2.SectionBg,
            BorderColor3 = borderColor32,
            BorderSizePixel = 1,
          }),
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundColor3 = v2.Accent,
          BorderSizePixel = 0,
          Visible = v36,
        }))

        local v40 = f8(v38, v2.Accent)
        v40.Visible = v36

        local v41 = f7("TextLabel", {
          Parent = v37,
          Size = UDim2.new(1, -16, 1, 0),
          Position = UDim2.new(0, 16, 0, 0),
          BackgroundTransparency = 1,
          Text = text5,
          TextColor3 = v2.Text,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f6(v41)
        f9(v41)

        v37.MouseButton1Click:Connect(function()
          v36 = not v36
          v39.Visible = v36
          v40.Visible = v36

          if p18 then
            p18(v36)
          end
        end)
      end

      function v34.CreateButton(p19, text6, p20)
        local v42 = f7("TextButton", {
          Parent = f7("Frame", {
            Parent = parent9,
            Size = UDim2.new(1, 0, 0, 18),
            BackgroundColor3 = v2.BorderOuter,
            BorderSizePixel = 0,
          }),
          TextColor3 = v2.Text,
          Text = text6,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = v2.ElementBg,
          BorderColor3 = fromRGB(56, 56, 56),
          TextSize = 12,
        })

        f6(v42)
        f9(v42)

        v42.MouseButton1Click:Connect(function()
          if p20 then
            p20()
          end
        end)
      end

      function v34:CreateKeybind(p21, p22, p23, p24)
        local keyCode = p22
        local v43 = p23 or "toggle"
        local v44 = false
        local v45 = false

        v1.RegisteredKeybinds[p21] = { key = keyCode, state = v45, mode = v43 }
        v1:UpdateKeybindList()

        local parent10 = f7("Frame", {
          Parent = parent9,
          Size = UDim2.new(1, 0, 0, 12),
          BackgroundTransparency = 1,
        })

        local v46 = f7("TextLabel", {
          Parent = parent10,
          Size = UDim2.new(1, -50, 1, 0),
          BackgroundTransparency = 1,
          Text = p21,
          TextColor3 = v2.Text,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f6(v46)
        f9(v46)

        local v47 = f7("TextButton", {
          Parent = parent10,
          Position = UDim2.new(1, -60, 0, 0),
          Size = UDim2.new(0, 60, 1, 0),
          BackgroundTransparency = 1,
          Text = "[" .. f3(keyCode) .. "]",
          TextColor3 = v2.TextDark,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Right,
        })

        f6(v47)
        f9(v47)

        local v48 = f7("Frame", {
          Parent = v9,
          BackgroundColor3 = v2.BorderOuter,
          BorderSizePixel = 0,
          ZIndex = 100,
          Visible = false,
        })

        local parent11 = f7("Frame", {
          Parent = v48,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = v2.ElementBg,
          BorderColor3 = fromRGB(56, 56, 56),
          BorderSizePixel = 1,
        })

        f7("UIListLayout", { Parent = parent11, Padding = UDim.new(0, 2) })

        f7("UIPadding", {
          Parent = parent11,
          PaddingBottom = UDim.new(0, 4),
          PaddingTop = UDim.new(0, 2),
        })

        table.insert(v1.popups, v48)
        local v49 = 6

        for index3, value10 in ipairs({ "toggle", "hold", "always" }) do
          local v50 = value10

          local v51 = f7("TextButton", {
            Parent = parent11,
            Size = UDim2.new(1, -4, 0, 14),
            Position = UDim2.new(0, 2, 0, 0),
            Text = v50,
            TextColor3 = v2.Text,
            BackgroundTransparency = 1,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
          })

          f7("UIPadding", { Parent = v51, PaddingLeft = UDim.new(0, 5) })
          f6(v51)
          f9(v51)
          v49 = v49 + 16

          v51.MouseButton1Click:Connect(function()
            v43 = v50
            v48.Visible = false

            if v43 == "always" then
              v45 = true

              if p24 then
                p24(v45)
              end
            end

            v1.RegisteredKeybinds[p21].mode = v43
            v1.RegisteredKeybinds[p21].state = v45
            v1:UpdateKeybindList()
          end)
        end

        v48.Size = UDim2.new(0, 60, 0, v49)

        v47.MouseButton1Click:Connect(function()
          v44 = true
          v47.Text = "[...]"
        end)

        v47.MouseButton2Click:Connect(function()
          f5(v48)
          v48.Visible = not v48.Visible

          if v48.Visible then
            v48.Position = UDim2.new(0, v47.AbsolutePosition.X, 0, v47.AbsolutePosition.Y + 16)
          end
        end)

        userInputService.InputBegan:Connect(function(input4, p25)
          if v44 then
            if input4.UserInputType == Enum.UserInputType.Keyboard
              and input4.KeyCode ~= Enum.KeyCode.Unknown then
              keyCode = input4.KeyCode
              v47.Text = "[" .. f3(keyCode) .. "]"
              v44 = false
            elseif input4.UserInputType == Enum.UserInputType.MouseButton1
              or input4.UserInputType == Enum.UserInputType.MouseButton2
              or input4.UserInputType == Enum.UserInputType.MouseButton3 then
              keyCode = input4.UserInputType
              v47.Text = "[" .. f3(keyCode) .. "]"
              v44 = false
            end

            if input4.KeyCode == Enum.KeyCode.Escape then
              keyCode = nil
              v47.Text = "[None]"
              v44 = false
            end

            v1.RegisteredKeybinds[p21].key = keyCode
            v1:UpdateKeybindList()
          elseif keyCode and not p25 then
            if input4.KeyCode == keyCode or input4.UserInputType == keyCode then
              if v43 == "toggle" then
                v45 = not v45

                if p24 then
                  p24(v45, keyCode)
                end
              elseif v43 == "hold" then
                v45 = true

                if p24 then
                  p24(v45, keyCode)
                end
              end

              v1.RegisteredKeybinds[p21].state = v45
              v1:UpdateKeybindList()
            end
          end
        end)

        userInputService.InputEnded:Connect(function(input5, p26)
          if keyCode and not p26 and not v44 then
            if input5.KeyCode == keyCode or input5.UserInputType == keyCode then
              if v43 == "hold" then
                v45 = false

                if p24 then
                  p24(v45, keyCode)
                end

                v1.RegisteredKeybinds[p21].state = v45
                v1:UpdateKeybindList()
              end
            end
          end
        end)
      end

      function v34:CreateSlider(text7, p27, p28, p29, p30, p31)
        local v52 = p30
        local v53 = p29 or p27
        local v54 = p28 % 1 == 0 and p27 % 1 == 0 and 1 or 0.1
        v52 = v52 or ""

        local parent12 = f7("Frame", {
          Parent = parent9,
          Size = UDim2.new(1, 0, 0, 26),
          BackgroundTransparency = 1,
        })

        local v55 = f7("TextLabel", {
          Parent = parent12,
          Size = UDim2.new(1, 0, 0, 12),
          BackgroundTransparency = 1,
          Text = text7,
          TextColor3 = v2.Text,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f6(v55)
        f9(v55)

        local v56 = f7("TextButton", {
          Parent = parent12,
          Position = UDim2.new(0, 0, 0, 14),
          Size = UDim2.new(0, 12, 0, 12),
          BackgroundTransparency = 1,
          Text = "-",
          TextColor3 = v2.Text,
          TextSize = 12,
        })

        local v57 = f7("TextButton", {
          Parent = parent12,
          Position = UDim2.new(1, -12, 0, 14),
          Size = UDim2.new(0, 12, 0, 12),
          BackgroundTransparency = 1,
          Text = "+",
          TextColor3 = v2.Text,
          TextSize = 12,
        })

        f6(v56)
        f9(v56)
        f6(v57)
        f9(v57)

        local v58 = f7("TextButton", {
          Parent = parent12,
          Position = UDim2.new(0, 16, 0, 16),
          Size = UDim2.new(1, -32, 0, 8),
          BackgroundColor3 = v2.BorderOuter,
          BorderSizePixel = 0,
          Text = "",
          AutoButtonColor = false,
        })

        local v59 = f7("Frame", {
          Parent = v58,
          Size = UDim2.new((v53 - p27) / (p28 - p27), 0, 1, 0),
          BackgroundColor3 = fromRGB(19, 19, 19),
          BorderSizePixel = 0,
          ZIndex = 2,
        })

        f1(f7("Frame", {
          Parent = v59,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, 0, 1, -4),
          BackgroundColor3 = v2.Accent,
          BorderSizePixel = 0,
        }))

        local v60 = v54 == 1

        local v61 = v60
        v61 = v60 and tostring(floor(v53 + 0.5))

        local v62 = v61
        v62 = v61 or string.format("%.1f", v53)

        local v63 = f7("TextLabel", {
          Parent = v59,
          FontFace = v7,
          TextColor3 = v2.Text,
          Text = v62 .. v52,
          TextStrokeTransparency = 0.5,
          BackgroundTransparency = 1,
          Position = UDim2.new(1, 0, 0, 1),
          Size = UDim2.new(0, 1, 0, 11),
          TextSize = 12,
        })

        f6(v63)
        f9(v63)
        f8(v59, v2.Accent)

        local function f10(p32)
          v53 = clamp(p32, p27, p28)

          if v54 == 1 then
            v53 = floor(v53 + 0.5)
          else
            v53 = floor(v53 * 10 + 0.5) / 10
          end

          v59.Size = UDim2.new((v53 - p27) / (p28 - p27), 0, 1, 0)
          v63.Text = (v54 == 1 and tostring(v53) or string.format("%.1f", v53)) .. v52

          if p31 then
            p31(v53)
          end
        end

        v56.MouseButton1Click:Connect(function() f10(v53 - v54) end)
        v57.MouseButton1Click:Connect(function() f10(v53 + v54) end)
        local v64 = false
        v58.MouseButton1Down:Connect(function() v64 = true end)

        userInputService.InputEnded:Connect(function(input6)
          if input6.UserInputType == Enum.UserInputType.MouseButton1 then
            v64 = false
          end
        end)

        userInputService.InputChanged:Connect(function(input7)
          if v64 and input7.UserInputType == Enum.UserInputType.MouseMovement then
            f10(p27
              + (p28 - p27)
                * clamp((input7.Position.X - v58.AbsolutePosition.X) / v58.AbsoluteSize.X, 0, 1))
          end
        end)
      end

      function v34:CreateColorPicker(text8, p33, p34)
        local color = p33 or new3(1, 1, 1)
        local v65, v66, v67 = color:ToHSV()
        local v68 = v66
        local v69 = v67

        local parent13 = f7("Frame", {
          Parent = parent9,
          Size = UDim2.new(1, 0, 0, 16),
          BackgroundTransparency = 1,
        })

        local v70 = f7("TextLabel", {
          Parent = parent13,
          Size = UDim2.new(1, -26, 1, 0),
          BackgroundTransparency = 1,
          Text = text8,
          TextColor3 = v2.Text,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f6(v70)
        f9(v70)

        local v71 = f7("TextButton", {
          Parent = parent13,
          Position = UDim2.new(1, -16, 0, 2),
          Size = UDim2.new(0, 16, 0, 10),
          BackgroundColor3 = v2.BorderOuter,
          BorderSizePixel = 0,
          AutoButtonColor = false,
          Text = "",
        })

        local v72 = f7("Frame", {
          Parent = v71,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = color,
          BorderColor3 = fromRGB(56, 56, 56),
          BorderSizePixel = 1,
        })

        local v73 = f8(v71, color, false, true)

        local v74 = f7("Frame", {
          Parent = v9,
          Size = UDim2.new(0, 142, 0, 146),
          BackgroundColor3 = v2.BorderOuter,
          BorderSizePixel = 0,
          ZIndex = 100,
          Visible = false,
        })

        local parent14 = f7("Frame", {
          Parent = v74,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = v2.ElementBg,
          BorderColor3 = fromRGB(56, 56, 56),
          BorderSizePixel = 1,
        })

        table.insert(v1.popups, v74)

        local v75 = f7("TextButton", {
          Parent = parent14,
          Position = UDim2.new(0, 4, 0, 4),
          Size = UDim2.new(1, -24, 1, -24),
          BackgroundColor3 = v2.BorderOuter,
          BorderSizePixel = 0,
          Text = "",
          AutoButtonColor = false,
        })

        local v76 = f7("Frame", {
          Parent = v75,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = Color3.fromHSV(v65, 1, 1),
          BorderSizePixel = 0,
        })

        local parent15 = f7("Frame", {
          Parent = v76,
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundColor3 = new3(1, 1, 1),
          BorderSizePixel = 0,
          ZIndex = 2,
        })

        f7("UIGradient", {
          Parent = parent15,
          Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1),
          }),
        })

        local parent16 = f7("Frame", {
          Parent = parent15,
          Size = UDim2.new(1, 0, 1, 0),
          BackgroundColor3 = new3(1, 1, 1),
          BorderSizePixel = 0,
        })

        f7("UIGradient", {
          Parent = parent16,
          Rotation = 90,
          Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, new3(0, 0, 0)),
            ColorSequenceKeypoint.new(1, new3(0, 0, 0)),
          }),
          Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0),
          }),
        })

        local v77 = f7("Frame", {
          Parent = parent16,
          Size = UDim2.new(0, 2, 0, 2),
          BackgroundColor3 = new3(1, 1, 1),
          BorderColor3 = new3(0, 0, 0),
          BorderSizePixel = 1,
          AnchorPoint = new(0.5, 0.5),
        })

        local v78 = f7("TextButton", {
          Parent = parent14,
          Position = UDim2.new(1, -16, 0, 4),
          Size = UDim2.new(0, 12, 1, -24),
          BackgroundColor3 = v2.BorderOuter,
          BorderSizePixel = 0,
          Text = "",
          AutoButtonColor = false,
        })

        local v79 = f7("Frame", {
          Parent = v78,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BorderSizePixel = 0,
          BackgroundColor3 = new3(1, 1, 1),
        })

        f7("UIGradient", {
          Parent = v79,
          Rotation = 90,
          Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.16, fromRGB(255, 0, 255)),
            ColorSequenceKeypoint.new(0.33, fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.5, fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.66, fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.83, fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(1, fromRGB(255, 0, 0)),
          }),
        })

        local v80 = f7("Frame", {
          Parent = v79,
          Size = UDim2.new(1, 0, 0, 2),
          BackgroundColor3 = new3(1, 1, 1),
          BorderColor3 = new3(0, 0, 0),
          BorderSizePixel = 1,
          AnchorPoint = new(0, 0.5),
        })

        local function f11(p35)
          color = Color3.fromHSV(v65, v68, v69)
          v72.BackgroundColor3 = color
          v73.ImageColor3 = color
          v76.BackgroundColor3 = Color3.fromHSV(v65, 1, 1)

          if p35 then
            v77.Position = UDim2.new(v68, 0, 1 - v69, 0)
            v80.Position = UDim2.new(0, 0, 1 - v65, 0)
          end

          if p34 then
            p34(color)
          end
        end

        f11(true)

        local v81 = false
        local v82 = false
        v75.MouseButton1Down:Connect(function() v81 = true end)
        v78.MouseButton1Down:Connect(function() v82 = true end)

        userInputService.InputEnded:Connect(function(input8)
          if input8.UserInputType == Enum.UserInputType.MouseButton1 then
            v81 = false
            v82 = false
          end
        end)

        userInputService.InputChanged:Connect(function(input9)
          if v81 and input9.UserInputType == Enum.UserInputType.MouseMovement then
            v68 = clamp((input9.Position.X - v76.AbsolutePosition.X) / v76.AbsoluteSize.X, 0, 1)

            v69 = 1
              - clamp((input9.Position.Y - v76.AbsolutePosition.Y) / v76.AbsoluteSize.Y, 0, 1)

            f11(true)
          elseif v82 and input9.UserInputType == Enum.UserInputType.MouseMovement then
            v65 = 1
              - clamp((input9.Position.Y - v79.AbsolutePosition.Y) / v79.AbsoluteSize.Y, 0, 1)

            f11(true)
          end
        end)

        v71.MouseButton1Click:Connect(function()
          f5(v74)
          v74.Visible = not v74.Visible

          if v74.Visible then
            v74.Position = UDim2.new(
              0, v71.AbsolutePosition.X - 126, 0, v71.AbsolutePosition.Y + 16
            )
          end
        end)
      end

      function v34.CreateDropdown(p36, text9, p37, p38, p39)
        local v83 = p38 or p37[1]

        local parent17 = f7("Frame", {
          Parent = parent9,
          Size = UDim2.new(1, 0, 0, 32),
          BackgroundTransparency = 1,
        })

        local v84 = f7("TextLabel", {
          Parent = parent17,
          Size = UDim2.new(1, 0, 0, 12),
          BackgroundTransparency = 1,
          Text = text9,
          TextColor3 = v2.Text,
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f6(v84)
        f9(v84)

        local v85 = f7("Frame", {
          Parent = parent17,
          Position = UDim2.new(0, 0, 0, 15),
          Size = UDim2.new(1, 0, 0, 16),
          BackgroundColor3 = v2.BorderOuter,
          BorderSizePixel = 0,
        })

        local v86 = f7("TextButton", {
          Parent = v85,
          TextColor3 = v2.Text,
          Text = v83,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = v2.ElementBg,
          BorderColor3 = fromRGB(56, 56, 56),
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
        })

        f7("UIPadding", { Parent = v86, PaddingLeft = UDim.new(0, 5) })
        f6(v86)
        f9(v86)

        local v87 = f7("TextLabel", {
          Parent = v86,
          Text = "+",
          TextColor3 = v2.Text,
          Size = UDim2.new(0, 10, 1, 0),
          Position = UDim2.new(1, -15, 0, -1),
          BackgroundTransparency = 1,
          TextSize = 12,
        })

        f6(v87)
        f9(v87)

        local v88 = f7("Frame", {
          Parent = v9,
          BackgroundColor3 = v2.BorderOuter,
          BorderSizePixel = 0,
          ZIndex = 100,
          Visible = false,
        })

        local v89 = f7("Frame", {
          Parent = v88,
          Position = UDim2.new(0, 2, 0, 2),
          Size = UDim2.new(1, -4, 1, -4),
          BackgroundColor3 = v2.ElementBg,
          BorderColor3 = fromRGB(56, 56, 56),
          BorderSizePixel = 1,
        })

        f7("UIListLayout", { Parent = v89, Padding = UDim.new(0, 2) })

        f7("UIPadding", {
          Parent = v89,
          PaddingBottom = UDim.new(0, 4),
          PaddingTop = UDim.new(0, 2),
        })

        table.insert(v1.popups, v88)

        local function f12()
          for index4, value11 in ipairs(v89:GetChildren()) do
            if value11:IsA("TextButton") then
              value11:Destroy()
            end
          end

          local v90 = 6

          for index5, value12 in ipairs(p37) do
            local v91 = value12

            local v92 = f7("TextButton", {
              Parent = v89,
              Size = UDim2.new(1, -4, 0, 14),
              Position = UDim2.new(0, 2, 0, 0),
              Text = v91,
              TextColor3 = v2.Text,
              BackgroundTransparency = 1,
              TextSize = 12,
              TextXAlignment = Enum.TextXAlignment.Left,
            })

            f7("UIPadding", { Parent = v92, PaddingLeft = UDim.new(0, 5) })
            f6(v92)
            f9(v92)
            v90 = v90 + 16

            v92.MouseButton1Click:Connect(function()
              v83 = v91
              v86.Text = v83
              v88.Visible = false
              v87.Text = "+"

              if p39 then
                p39(v83)
              end
            end)
          end

          v88.Size = UDim2.new(0, v85.AbsoluteSize.X, 0, v90)
        end

        v86.MouseButton1Click:Connect(function()
          f5(v88)
          v88.Visible = not v88.Visible
          v87.Text = v88.Visible and "-" or "+"

          if v88.Visible then
            f12()

            v88.Position = UDim2.new(
              0, v85.AbsolutePosition.X, 0, v85.AbsolutePosition.Y + v85.AbsoluteSize.Y + 2
            )
          end
        end)
      end

      return v34
    end

    return v28
  end

  return v21
end

local v93 = {
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
  ChamsEnabled = false,
  ChamsFillColor = fromRGB(255, 0, 0),
  ChamsOutlineColor = fromRGB(255, 255, 255),
  SilentAim = false,
  AimVisibleCheck = false,
  FOVRadius = 150,
  ShowFOV = false,
  NoRecoil = false,
}

local circle = Drawing.new("Circle")
circle.Thickness = 1
circle.Color = new3(1, 1, 1)
circle.Filled = false
circle.Visible = false

local v94 = {}
local count2 = 0

while true do
  count2 = 1 + count2

  if not (count2 <= 8) then
    break
  end

  local line = Drawing.new("Line")
  line.Thickness = 2
  line.Color = fromRGB(255, 50, 50)
  line.Visible = false

  v94[count2] = line
end

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.IgnoreWater = true

local function f13(p40)
  if not localPlayer.Character then
    return false
  else
    local position3 = currentCamera.CFrame.Position
    raycastParams.FilterDescendantsInstances = { localPlayer.Character, p40.Parent }
    return workspace:Raycast(position3, p40.Position - position3, raycastParams) == nil
  end
end

local function f14(p41)
  local fovRadius = v93.FOVRadius
  local v95

  for index6, value13 in ipairs(players:GetPlayers()) do
    if value13 ~= localPlayer and (not v93.TeamCheck or value13.Team ~= localPlayer.Team) then
      local character = value13.Character

      if character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
        local head = character:FindFirstChild("Head") or character:FindFirstChild("UpperTorso")
          or character:FindFirstChild("Torso")

        if head and (not v93.AimVisibleCheck or f13(head)) then
          local v96, v97 = currentCamera:WorldToViewportPoint(head.Position)

          if v97 then
            local magnitude = (new(v96.X, v96.Y) - p41).Magnitude

            if magnitude < fovRadius then
              v95 = head
              fovRadius = magnitude
            end
          end
        end
      end
    end
  end

  return v95
end

local silentAim

local function f15()
  if silentAim then
    local v98 = math.random(-15, 15)
    local v99 = math.random(-15, 15)
    local v100 = math.random(-15, 15)
    local v101 = new2(v98 / 100, v99 / 100, v100 / 100)
    return silentAim.Position + v101
  end

  return nil
end

local v102

v102 = hookmetamethod(game, "__namecall", newcclosure(function(p42, ...)
  local v103 = getnamecallmethod()
  local v104 = { ... }

  if not checkcaller() and v93.SilentAim and silentAim then
    local v105 = f15()

    if v103 == "Raycast" then
      v104[2] = (v105 - v104[1]).Unit * v104[2].Magnitude
      return v102(p42, unpack(v104))
    end

    if v103 == "FindPartOnRay" or v103 == "FindPartOnRayWithIgnoreList"
      or v103 == "FindPartOnRayWithWhitelist" then
      v104[1] = Ray.new(
        v104[1].Origin, (v105 - v104[1].Origin).Unit * v104[1].Direction.Magnitude
      )

      return v102(p42, unpack(v104))
    end

    return v102(p42, ...)
  end

  return v102(p42, ...)
end))

local getMouse = localPlayer:GetMouse()

local v106

v106 = hookmetamethod(game, "__index", newcclosure(function(p43, p44)
  if not checkcaller() and v93.SilentAim and silentAim and p43 == getMouse then
    if p44 == "Hit" then
      return CFrame.new(f15())
    end

    if p44 == "Target" then
      return silentAim
    end

    return v106(p43, p44)
  end

  return v106(p43, p44)
end))

local v107 = {}
local v108 = {}

local function f16(p45)
  local v109 = {
    BoxOutline = Drawing.new("Square"),
    Box = Drawing.new("Square"),
    HealthOutline = Drawing.new("Square"),
    Health = Drawing.new("Square"),
    HealthText = Drawing.new("Text"),
    Name = Drawing.new("Text"),
    TracerOutline = Drawing.new("Line"),
    Tracer = Drawing.new("Line"),
  }

  v109.BoxOutline.Thickness = 3
  v109.BoxOutline.Filled = false
  v109.BoxOutline.Color = new3(0, 0, 0)
  v109.BoxOutline.ZIndex = 1
  v109.Box.Thickness = 1
  v109.Box.Filled = false
  v109.Box.ZIndex = 2
  v109.HealthOutline.Thickness = 1
  v109.HealthOutline.Filled = true
  v109.HealthOutline.Color = new3(0, 0, 0)
  v109.HealthOutline.ZIndex = 1
  v109.Health.Thickness = 1
  v109.Health.Filled = true
  v109.Health.ZIndex = 2
  v109.HealthText.Size = 13
  v109.HealthText.Center = true
  v109.HealthText.Outline = true
  v109.HealthText.OutlineColor = new3(0, 0, 0)
  v109.HealthText.ZIndex = 3
  v109.Name.Size = 16
  v109.Name.Center = true
  v109.Name.Outline = true
  v109.Name.OutlineColor = new3(0, 0, 0)
  v109.Name.ZIndex = 3
  v109.TracerOutline.Thickness = 3
  v109.TracerOutline.Color = new3(0, 0, 0)
  v109.TracerOutline.ZIndex = 1
  v109.Tracer.Thickness = 1
  v109.Tracer.ZIndex = 2

  v107[p45] = v109

  local highlight = Instance.new("Highlight")
  highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
  highlight.Enabled = false
  highlight.Parent = coreGui

  v108[p45] = highlight
end

for index7, value14 in ipairs(players:GetPlayers()) do
  if value14 ~= localPlayer then
    f16(value14)
  end
end

players.PlayerAdded:Connect(function(player) f16(player) end)

players.PlayerRemoving:Connect(function(player2)
  if v107[player2] then
    for key8, value15 in pairs(v107[player2]) do
      value15:Remove()
    end

    v107[player2] = nil
  end

  if v108[player2] then
    v108[player2]:Destroy()
    v108[player2] = nil
  end
end)

runService.RenderStepped:Connect(function()
  local getMouseLocation = userInputService:GetMouseLocation()
  local viewportSize = currentCamera.ViewportSize

  circle.Position = getMouseLocation
  circle.Radius = v93.FOVRadius
  circle.Visible = v93.ShowFOV and v93.SilentAim

  silentAim = v93.SilentAim and f14(getMouseLocation) or nil
  local v110, v111, v112

  if silentAim then
    local v113
    v112, v113 = currentCamera:WorldToViewportPoint(silentAim.Position)

    if v113 then
      local v114 = os.clock() * 3
      v111 = cos(v114)
      v110 = sin(v114)

      local function f17(p46, p47)
        return new(v112.X + (p46 * v111 - p47 * v110), v112.Y + (p46 * v110 + p47 * v111))
      end

      local from = f17(-12, -12)
      local from2 = f17(12, -12)
      local from3 = f17(12, 12)
      local from4 = f17(-12, 12)

      v94[1].From = from
      v94[1].To = f17(-6, -12)
      v94[2].From = from
      v94[2].To = f17(-12, -6)
      v94[3].From = from2
      v94[3].To = f17(6, -12)
      v94[4].From = from2
      v94[4].To = f17(12, -6)
      v94[5].From = from3
      v94[5].To = f17(6, 12)
      v94[6].From = from3
      v94[6].To = f17(12, 6)
      v94[7].From = from4
      v94[7].To = f17(-6, 12)
      v94[8].From = from4
      v94[8].To = f17(-12, 6)

      for i = 1, 8 do
        v94[i].Visible = true
      end
    else
      local count3 = 0

      while true do
        count3 = 1 + count3

        if not (8 >= count3) then
          break
        end

        v94[count3].Visible = false
      end
    end
  else
    local count4 = 0

    while true do
      count4 = 1 + count4

      if not (count4 <= 8) then
        break
      end

      v94[count4].Visible = false
    end
  end

  local humanoidRootPart = localPlayer.Character
    and localPlayer.Character:FindFirstChild("HumanoidRootPart")

  local from5 = new(viewportSize.X / 2, viewportSize.Y)

  for key9, value16 in pairs(v107) do
    local v115 = false
    local v116 = v108[key9]

    if v93.ESPEnabled and humanoidRootPart
      and (not v93.TeamCheck or key9.Team ~= localPlayer.Team) then
      local character2 = key9.Character

      if character2 and character2:FindFirstChild("HumanoidRootPart")
        and character2:FindFirstChild("Humanoid") then
        local humanoidRootPart2 = character2.HumanoidRootPart
        local head2 = character2:FindFirstChild("Head")
        local humanoid = character2.Humanoid
        local magnitude2 = (humanoidRootPart2.Position - humanoidRootPart.Position).Magnitude

        if head2 and humanoid.Health > 0 and magnitude2 <= v93.MaxDistance then
          local v117, v118 = currentCamera:WorldToViewportPoint(humanoidRootPart2.Position)

          local worldToViewportPoint = currentCamera:WorldToViewportPoint(head2.Position
            + new2(0, 0.5, 0))

          local worldToViewportPoint2 = currentCamera:WorldToViewportPoint(humanoidRootPart2.Position
            - new2(0, 3, 0))

          if v93.ChamsEnabled then
            if v116 then
              v116.Adornee = character2
              v116.FillColor = v93.ChamsFillColor
              v116.OutlineColor = v93.ChamsOutlineColor
              v116.FillTransparency = 0.5
              v116.OutlineTransparency = 0
              v116.Enabled = true
            end
          elseif v116 then
            v116.Enabled = false
          end

          if v118 then
            v115 = true

            local visibleColor = v93.VisibleCheck and f13(head2) and v93.VisibleColor
              or v93.ESPColor

            local fadeESP = v93.FadeESP and clamp(1 - magnitude2 / v93.MaxDistance, 0.1, 1) or 1
            local v119 = abs(worldToViewportPoint.Y - worldToViewportPoint2.Y)
            local v120 = v119 / 2
            local v121 = new(v117.X - v120 / 2, worldToViewportPoint.Y)
            local size = new(v120, v119)

            if v93.Boxes then
              value16.BoxOutline.Size = size
              value16.BoxOutline.Position = v121
              value16.BoxOutline.Transparency = fadeESP
              value16.BoxOutline.Visible = true
              value16.Box.Size = size
              value16.Box.Position = v121
              value16.Box.Color = visibleColor
              value16.Box.Transparency = fadeESP
              value16.Box.Visible = true
            else
              value16.BoxOutline.Visible = false
              value16.Box.Visible = false
            end

            if v93.HealthBar then
              local v122 = clamp(humanoid.Health / max(humanoid.MaxHealth, 1), 0, 1)
              local v123 = max(floor(v119 * v122), 1)

              value16.HealthOutline.Size = new(4, v119 + 2)
              value16.HealthOutline.Position = new(v121.X - 6, v121.Y - 1)
              value16.HealthOutline.Transparency = fadeESP
              value16.HealthOutline.Visible = true
              value16.Health.Size = new(2, v123)
              value16.Health.Position = new(v121.X - 5, v121.Y + v119 - v123)

              local color2 = fromRGB(255 - v122 * 255, v122 * 255, 0)

              value16.Health.Color = color2
              value16.Health.Transparency = fadeESP
              value16.Health.Visible = true
              value16.HealthText.Text = floor(humanoid.Health) .. " HP"
              value16.HealthText.Position = new(v121.X - 25, v121.Y + v119 - v123 - 6)
              value16.HealthText.Color = color2
              value16.HealthText.Transparency = fadeESP
              value16.HealthText.Visible = true
            else
              value16.HealthOutline.Visible = false
              value16.Health.Visible = false
              value16.HealthText.Visible = false
            end

            if v93.Names then
              value16.Name.Text = string.format("%s [%dm]", key9.DisplayName, floor(magnitude2))
              value16.Name.Position = new(v121.X + v120 / 2, v121.Y - 18)
              value16.Name.Color = visibleColor
              value16.Name.Transparency = fadeESP
              value16.Name.Visible = true
            else
              value16.Name.Visible = false
            end

            if v93.Tracers then
              value16.TracerOutline.From = from5
              value16.TracerOutline.To = new(v117.X, v117.Y)
              value16.TracerOutline.Transparency = fadeESP
              value16.TracerOutline.Visible = true
              value16.Tracer.From = from5
              value16.Tracer.To = new(v117.X, v117.Y)
              value16.Tracer.Color = visibleColor
              value16.Tracer.Transparency = fadeESP
              value16.Tracer.Visible = true
            else
              value16.TracerOutline.Visible = false
              value16.Tracer.Visible = false
            end
          end
        end
      end
    end

    if not v115 then
      value16.BoxOutline.Visible = false
      value16.Box.Visible = false
      value16.HealthOutline.Visible = false
      value16.Health.Visible = false
      value16.HealthText.Visible = false
      value16.Name.Visible = false
      value16.TracerOutline.Visible = false
      value16.Tracer.Visible = false

      if v116 and not v93.ChamsEnabled then
        v116.Enabled = false
      end
    end
  end
end)

task.spawn(function()
  while task.wait(0.1) do
    if v93.NoRecoil then
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

      local debugShotsGui2 = playerGui
      debugShotsGui2 = playerGui and localPlayer.PlayerGui:FindFirstChild("DebugShotsGui")

      if debugShotsGui2 and debugShotsGui2:IsA("ScreenGui") and debugShotsGui2.Enabled then
        debugShotsGui2.Enabled = false
      end

      for index8, value17 in ipairs(localPlayer.PlayerGui:GetChildren()) do
        if value17:IsA("ScreenGui") and string.match(string.lower(value17.Name), "debug") then
          value17.Enabled = false
        end
      end
    end
  end
end)

workspace.DescendantAdded:Connect(function(descendant)
  if not v93.NoRecoil then
    return
  end

  task.spawn(function() runService.RenderStepped:Wait() end)
end)

local window = v1:CreateWindow("Overdose.gg | Shooter Hub")
local visualTab = window:CreateTab("Visual")
local combatTab = window:CreateTab("Combat")
local settingsTab = window:CreateTab("Settings")

local mainESPSection = visualTab:CreateSection("Main ESP", "Left")

mainESPSection:CreateToggle("Enable ESP", false, function(espEnabled)
  v93.ESPEnabled = espEnabled
end)

mainESPSection:CreateToggle("Team Check", true, function(teamCheck)
  v93.TeamCheck = teamCheck
end)

mainESPSection:CreateSlider("Max Distance", 50, 3000, 800, " st", function(maxDistance)
  v93.MaxDistance = maxDistance
end)

mainESPSection:CreateToggle("Fade by Distance", false, function(fadeESP2)
  v93.FadeESP = fadeESP2
end)

local drawingsSection = visualTab:CreateSection("Drawings", "Left")
drawingsSection:CreateToggle("Show Boxes", false, function(boxes) v93.Boxes = boxes end)

drawingsSection:CreateToggle("Show Health Bar & HP", false, function(healthBar)
  v93.HealthBar = healthBar
end)

drawingsSection:CreateToggle("Show Names & Distance", false, function(names)
  v93.Names = names
end)

drawingsSection:CreateToggle("Show Tracers", false, function(tracers) v93.Tracers = tracers end)

local chamsHighlightSection = visualTab:CreateSection("Chams (Highlight)", "Right")

chamsHighlightSection:CreateToggle("Enable Chams", false, function(chamsEnabled)
  v93.ChamsEnabled = chamsEnabled
end)

chamsHighlightSection:CreateColorPicker("Fill Color", fromRGB(255, 0, 0), function(chamsFillColor)
  v93.ChamsFillColor = chamsFillColor
end)

chamsHighlightSection:CreateColorPicker("Outline Color", fromRGB(255, 255, 255), function(chamsOutlineColor)
  v93.ChamsOutlineColor = chamsOutlineColor
end)

local drawingColorsSection = visualTab:CreateSection("Drawing Colors", "Right")

drawingColorsSection:CreateToggle("Visible Check Color", true, function(visibleCheck)
  v93.VisibleCheck = visibleCheck
end)

drawingColorsSection:CreateColorPicker("Enemy Color (Wall)", fromRGB(255, 65, 65), function(espColor)
  v93.ESPColor = espColor
end)

drawingColorsSection:CreateColorPicker("Visible Color", fromRGB(0, 255, 0), function(visibleColor2)
  v93.VisibleColor = visibleColor2
end)

local aimbotSection = combatTab:CreateSection("Aimbot", "Left")

aimbotSection:CreateToggle("Silent Aim", false, function(silentAim2)
  v93.SilentAim = silentAim2
end)

aimbotSection:CreateToggle("Visible Check (Smart Target)", false, function(aimVisibleCheck)
  v93.AimVisibleCheck = aimVisibleCheck
end)

aimbotSection:CreateToggle("Show FOV Circle", false, function(showFOV) v93.ShowFOV = showFOV end)

aimbotSection:CreateSlider("FOV Radius", 30, 500, 150, " px", function(fovRadius2)
  v93.FOVRadius = fovRadius2
end)

combatTab:CreateSection("Weapon Modifications", "Right"):CreateToggle("No Recoil", false, function(noRecoil)
  v93.NoRecoil = noRecoil
end)

local uiConfigurationSection = settingsTab:CreateSection("UI Configuration", "Left")

uiConfigurationSection:CreateKeybind("Toggle UI Key", Enum.KeyCode.Insert, "toggle", function(p48, p49)
  if p49 then
    getgenv().ToggleUIKey = p49
  end
end)

uiConfigurationSection:CreateColorPicker("Menu Accent Color", v2.Accent, function(p50)
  v1:ChangeAccent(p50)
end)

uiConfigurationSection:CreateToggle("Show Keybinds List", false, function(p51)
  v1:SetKeybindsVisible(p51)
end)
