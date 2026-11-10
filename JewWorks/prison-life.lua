-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf

local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local workspaceService = game:GetService("Workspace")
local lighting = game:GetService("Lighting")
local teleportService = game:GetService("TeleportService")
local contentProvider = game:GetService("ContentProvider")
local coreGui = game:GetService("CoreGui")
local virtualUser = game:GetService("VirtualUser")
local statsService = game:GetService("Stats")
local localPlayer = players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

local function makeFolder()
  if gethui then
    local ok, hui = pcall(gethui)

    if ok and hui then
      return hui
    end
  end

  local ok2, result = pcall(function() return coreGui end)

  if ok2 and result then
    if pcall(function() Instance.new("Folder", result):Destroy() end) then
      return result
    end
  end

  return playerGui
end

local parent = makeFolder()

for _, value in ipairs({ parent, playerGui }) do
  for _, value2 in ipairs({ "JewWorks", "JewWorksLoader", "JewWorksDiscordPrompt" }) do
    local findFirstChild = value:FindFirstChild(value2)

    if findFirstChild then
      findFirstChild:Destroy()
    end
  end
end

local count = 0
count = count + 1

local v1 = count <= 2

local v2 = {
  Name = "JEWORKS",
  Version = "1.4.3",
  Build = "2026.11.07",
  Font = Enum.Font.GothamMedium,
  FontBold = Enum.Font.GothamBold,
  Bg = Color3.fromRGB(8, 8, 8),
  Panel = Color3.fromRGB(16, 16, 16),
  Raised = Color3.fromRGB(25, 25, 25),
  Hover = Color3.fromRGB(36, 36, 36),
  Border = Color3.fromRGB(46, 46, 46),
  BorderLit = Color3.fromRGB(112, 112, 112),
  Text = Color3.fromRGB(240, 240, 240),
  SubText = Color3.fromRGB(152, 152, 152),
  Dim = Color3.fromRGB(96, 96, 96),
  Accent = Color3.fromRGB(255, 255, 255),
  AccentInk = Color3.fromRGB(8, 8, 8),
}

local v3 = {
  Animations = true,
  Notifications = true,
  Tooltips = true,
  UIScale = 1,
  ToggleKey = Enum.KeyCode.M,
  F_Aimlock = false,
  F_AimSmoothing = 3,
  F_AimFOV = 120,
}

local v4 = {}
local v5 = setmetatable({}, { __mode = "k" })

function v4.to(key, key2, p1, map, p2, p3)
  local v6 = v5[key]

  if not v6 then
    v6 = {}
    v5[key] = v6
  end

  local v7 = v6[key2]

  if v7 then
    v7:Cancel()
    v6[key2] = nil
  end

  if not v3.Animations or p1 <= 0 then
    for key3, value3 in pairs(map) do
      key[key3] = value3
    end

    return nil
  end

  local create = tweenService:Create(key, TweenInfo.new(
    p1, p2 or Enum.EasingStyle.Quint, p3 or Enum.EasingDirection.Out
  ), map)

  v6[key2] = create

  create.Completed:Connect(function()
    if v6[key2] == create then
      v6[key2] = nil
    end
  end)

  create:Play()

  return create
end

local f1

local function f2(p4, p5)
  return f1("UIStroke", {
    Color = p4 or v2.Border,
    Thickness = p5 or 1,
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
  })
end

local function f3(map2)
  local v8 = {
    BackgroundTransparency = 1,
    TextColor3 = v2.Text,
    Font = v2.Font,
    TextSize = 13,
    Text = "",
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center,
  }

  for key4, value4 in pairs(map2) do
    v8[key4] = value4
  end

  return f1("TextLabel", v8)
end

local function f4(p6, p7, p8, p9)
  return f1("UIPadding", {
    PaddingLeft = UDim.new(0, p6),
    PaddingTop = UDim.new(0, p7),
    PaddingRight = UDim.new(0, p8),
    PaddingBottom = UDim.new(0, p9),
  })
end

function f1(p10, p11, p12)
  local instance = Instance.new(p10)
  local v9 = pairs
  local parent2

  for v10, v11 in v9(p11 or {}) do
    if v10 == "Parent" then
      parent2 = v11
    else
      instance[v10] = v11
    end
  end

  for _, value5 in ipairs(p12 or {}) do
    value5.Parent = instance
  end

  instance.Parent = parent2
  return instance
end

local function f5(p13)
  return f1("UICorner", { CornerRadius = UDim.new(0, p13) })
end

local parent3 = f1("ScreenGui", {
  Name = "JewWorks",
  ResetOnSpawn = false,
  IgnoreGuiInset = false,
  DisplayOrder = 100,
  ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
  Parent = parent,
})

local function getParent(parent4, clamped, highest, accent)
  local parent5 = f1("Frame", {
    Parent = parent4,
    BackgroundTransparency = 1,
    Size = UDim2.fromOffset(clamped, clamped),
  })

  local vector = Vector2.new(clamped / 2, clamped / 2)
  local v12 = clamped / 2 * 0.9

  local function f6(p14)
    local radians = math.rad(p14)
    return Vector2.new(math.cos(radians), -math.sin(radians)) * v12
  end

  local list = {}
  local list2 = {}

  local function f7(p15)
    for index, value6 in ipairs(list) do
      local new = Vector2.new
      local x = value6[1].X
      local y = value6[1].Y
      local v13 = new(x * p15, y)
      local v14 = vector + Vector2.new(value6[2].X * p15, value6[2].Y)
      local v15 = vector + v13
      local v16 = v14 - v15

      local v17 = list2[index]
      v17.Size = UDim2.fromOffset(v16.Magnitude + highest * 0.8, highest)
      v17.Position = UDim2.fromOffset((v15.X + v14.X) / 2, (v15.Y + v14.Y) / 2)
      v17.Rotation = math.deg(math.atan2(v16.Y, v16.X))
    end
  end

  for _, value7 in ipairs({ { 90, 210, 330 }, { 270, 30, 150 } }) do
    for i = 1, 3 do
      table.insert(list, { f6(value7[i]), f6(value7[i % 3 + 1]) })

      table.insert(list2, f1("Frame", {
        Parent = parent5,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BorderSizePixel = 0,
        BackgroundColor3 = accent,
      }))
    end
  end

  f7(1)
  return parent5, list2, f7
end

local list3 = {}

local function getConnect(connect)
  table.insert(list3, connect)
  return connect
end

local v18

getConnect(userInputService.InputChanged:Connect(function(input)
  if not v18 then
    return
  end

  local userInputType = input.UserInputType

  if userInputType == Enum.UserInputType.MouseMovement
    or userInputType == Enum.UserInputType.Touch then
    if v18.touch and userInputType == Enum.UserInputType.Touch and input ~= v18.touch then
      return
    end

    v18.update(input.Position)
  end
end))

getConnect(userInputService.InputEnded:Connect(function(input2)
  if v18
    and (input2.UserInputType == Enum.UserInputType.MouseButton1
      or input2.UserInputType == Enum.UserInputType.Touch) then
    local v19 = v18
    v18 = nil

    if v19.finish then
      v19.finish()
    end
  end
end))

local instance2 = f1("Frame", {
  Parent = parent3,
  Visible = false,
  BackgroundColor3 = v2.Raised,
  Size = UDim2.fromOffset(0, 24),
  AutomaticSize = Enum.AutomaticSize.X,
  ZIndex = 50,
}, { f5(6), f2(v2.BorderLit), f4(9, 0, 9, 0) })

local uiStroke = instance2:FindFirstChildOfClass("UIStroke")
local fromOffset = UDim2.fromOffset
local map3

local function makePointLight(key5)
  if not key5:IsA("Tool") or map3[key5] then
    return
  end

  local backpack = localPlayer:FindFirstChildOfClass("Backpack")
  local character = localPlayer.Character

  if backpack and key5.Parent ~= backpack and (not character or key5.Parent ~= character) then
    return
  end

  map3[key5] = {}

  for _, value8 in ipairs(key5:GetDescendants()) do
    if value8:IsA("MeshPart") and value8.Transparency < 1 then
      map3[key5][value8] = {
        Color = value8.Color,
        Material = value8.Material,
        TextureID = value8.TextureID,
      }

      value8.TextureID = ""

      if not value8:FindFirstChild("RGBWeaponLight") then
        local rgbWeaponLight = Instance.new("PointLight")
        rgbWeaponLight.Name = "RGBWeaponLight"
        rgbWeaponLight.Brightness = 2
        rgbWeaponLight.Range = 10
        rgbWeaponLight.Shadows = false
        rgbWeaponLight.Parent = value8
      end
    elseif value8:IsA("BasePart") and value8.Transparency < 1 then
      map3[key5][value8] = { Color = value8.Color, Material = value8.Material }

      if not value8:FindFirstChild("RGBWeaponLight") then
        local rgbWeaponLight2 = Instance.new("PointLight")
        rgbWeaponLight2.Name = "RGBWeaponLight"
        rgbWeaponLight2.Brightness = 2
        rgbWeaponLight2.Range = 10
        rgbWeaponLight2.Shadows = false
        rgbWeaponLight2.Parent = value8
      end
    elseif value8:IsA("SpecialMesh") then
      value8.TextureId = ""
    end
  end
end

local v20 = f3({
  Parent = instance2,
  TextSize = 11,
  Size = fromOffset(0, 24),
  AutomaticSize = Enum.AutomaticSize.X,
  ZIndex = 51,
})

local count2 = 0

local function f8(p16, tooltip)
  if not tooltip then
    return
  end

  p16.MouseEnter:Connect(function()
    if not v3.Tooltips then
      return
    end

    count2 = count2 + 1
    local v21 = count2

    task.delay(0.45, function()
      if v21 ~= count2 then
        return
      end

      v20.Text = tooltip
      local v22 = p16.AbsolutePosition - parent3.AbsolutePosition
      local v23 = #tooltip

      local clamped2 = math.clamp(
        v22.X, 6, math.max(6, parent3.AbsoluteSize.X - (v23 * 6.5 + 20) - 6)
      )

      instance2.Position = UDim2.fromOffset(clamped2, v22.Y + p16.AbsoluteSize.Y + 6)
      instance2.BackgroundTransparency = 1

      v20.TextTransparency = 1
      uiStroke.Transparency = 1
      instance2.Visible = true

      v4.to(instance2, "f", 0.15, { BackgroundTransparency = 0 })
      v4.to(v20, "f", 0.15, { TextTransparency = 0 })
      v4.to(uiStroke, "f", 0.15, { Transparency = 0 })
    end)
  end)

  p16.MouseLeave:Connect(function()
    count2 = count2 + 1
    local v24 = count2

    v4.to(instance2, "f", 0.1, { BackgroundTransparency = 1 })
    v4.to(v20, "f", 0.1, { TextTransparency = 1 })
    v4.to(uiStroke, "f", 0.1, { Transparency = 1 })

    task.delay(0.12, function()
      if v24 == count2 then
        instance2.Visible = false
      end
    end)
  end)
end

local parent6 = f1("Frame", {
  Parent = parent3,
  BackgroundTransparency = 1,
  AnchorPoint = Vector2.new(1, 1),
  Position = UDim2.new(1, -16, 1, -16),
  Size = UDim2.new(0, 290, 1, -32),
  ZIndex = 40,
}, {
  f1("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Bottom,
    HorizontalAlignment = Enum.HorizontalAlignment.Right,
  }),
})

local raised = v2.Raised
local subText = v2.SubText
local border = v2.Border
local map4

local function f9(player)
  local v25 = map4[player]

  if not v25 then
    return
  end

  if v25.hl then
    v25.hl:Destroy()
  end

  if v25.bb then
    v25.bb:Destroy()
  end

  map4[player] = nil
end

local v26 = {
  info = {
    badgeBg = raised,
    badgeFg = subText,
    glyph = "i",
    border = border,
  },
  success = {
    badgeBg = v2.Accent,
    badgeFg = v2.AccentInk,
    glyph = "+",
    border = v2.BorderLit,
  },
  warning = {
    badgeBg = v2.Raised,
    badgeFg = v2.Accent,
    glyph = "!",
    border = v2.Accent,
  },
}

local layoutOrder = 0

local function f10(p17)
  if not v3.Notifications and not p17.Force then
    return
  end

  local info = v26[p17.Style or "info"] or v26.info
  local duration = p17.Duration or 4
  layoutOrder = layoutOrder + 1

  local instance3 = f1("Frame", {
    Parent = parent6,
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 68),
    LayoutOrder = layoutOrder,
  })

  local parent7 = f1("TextButton", {
    Parent = instance3,
    Text = "",
    AutoButtonColor = false,
    BackgroundColor3 = v2.Panel,
    ClipsDescendants = true,
    Position = UDim2.new(1, 320, 0, 0),
    Size = UDim2.fromScale(1, 1),
  }, { f5(10), f2(info.border) })

  f3({
    Parent = f1("Frame", {
      Parent = parent7,
      Position = UDim2.fromOffset(14, 10),
      Size = UDim2.fromOffset(24, 24),
      BackgroundColor3 = info.badgeBg,
    }, { f5(12), f2(v2.Border) }),
    Text = p17.Icon or info.glyph,
    TextColor3 = info.badgeFg,
    Font = v2.FontBold,
    TextXAlignment = Enum.TextXAlignment.Center,
    Size = UDim2.fromScale(1, 1),
  })

  f3({
    Parent = parent7,
    Text = p17.Title or "Notification",
    Font = v2.FontBold,
    Position = UDim2.fromOffset(48, 9),
    Size = UDim2.new(1, -60, 0, 16),
  })

  f3({
    Parent = parent7,
    Text = p17.Text or "",
    TextSize = 12,
    TextColor3 = v2.SubText,
    TextWrapped = true,
    TextTruncate = Enum.TextTruncate.AtEnd,
    TextYAlignment = Enum.TextYAlignment.Top,
    Position = UDim2.fromOffset(48, 27),
    Size = UDim2.new(1, -60, 0, 30),
  })

  local v27 = f1("Frame", {
    Parent = parent7,
    AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.fromScale(0, 1),
    Size = UDim2.new(1, 0, 0, 2),
    BackgroundColor3 = v2.BorderLit,
    BorderSizePixel = 0,
  })

  local flag = false

  local function f11()
    if flag then
      return
    end

    flag = true

    v4.to(
      parent7, "x", 0.26, { Position = UDim2.new(1, 320, 0, 0) }, Enum.EasingStyle.Quint,
      Enum.EasingDirection.In
    )

    task.delay(v3.Animations and 0.26 or 0, function()
      v4.to(instance3, "h", 0.18, { Size = UDim2.new(1, 0, 0, 0) })
      task.delay(v3.Animations and 0.18 or 0, function() instance3:Destroy() end)
    end)
  end

  parent7.Activated:Connect(f11)

  v4.to(parent7, "x", 0.38, { Position = UDim2.new() })
  v4.to(v27, "w", duration, { Size = UDim2.new(0, 0, 0, 2) }, Enum.EasingStyle.Linear)

  task.delay(duration, f11)
end

local v28 = {}

local function getOrder(p18)
  p18.order = p18.order + 1
  return p18.order
end

local f12

local function f13(p19, description, name)
  local v29 = f1("Frame", {
    Parent = p19.Scroll,
    BackgroundColor3 = v2.Raised,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, description),
    LayoutOrder = getOrder(p19),
    ClipsDescendants = true,
  })

  f12(p19, v29, name)
  return v29
end

local function f14(p20, p21, p22)
  local flag2 = false

  local function f15(p23)
    local v30 = p22 and p22() or 1

    v4.to(p20, "bg", p23 or 0.12, {
      BackgroundTransparency = flag2 and math.min(v30, 0.35) or v30,
    })
  end

  p21.MouseEnter:Connect(function()
    flag2 = true
    f15()
  end)

  p21.MouseLeave:Connect(function()
    flag2 = false
    f15()
  end)

  return f15
end

local function f16(p24, parent8)
  local v31 = f1("Frame", {
    Parent = parent8,
    Name = p24,
    BackgroundColor3 = v2.Bg,
    BackgroundTransparency = 0.05,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Size = UDim2.fromOffset(210, 30),
  })

  local scale = f1("UIScale", { Parent = v31 })

  local v32 = f1("TextButton", {
    Parent = v31,
    Text = "",
    AutoButtonColor = false,
    BackgroundColor3 = v2.Raised,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 30),
    ZIndex = 3,
  })

  f3({
    Parent = v32,
    Text = p24,
    Font = v2.FontBold,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Center,
    Size = UDim2.fromScale(1, 1),
    ZIndex = 4,
  })

  f1("Frame", {
    Parent = v32,
    BackgroundColor3 = v2.BorderLit,
    BorderSizePixel = 0,
    AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.fromScale(0, 1),
    Size = UDim2.new(1, 0, 0, 1),
    ZIndex = 4,
  })

  local v33 = f1("ScrollingFrame", {
    Parent = v31,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(0, 30),
    Size = UDim2.new(1, 0, 0, 0),
    CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollBarThickness = 2,
    ScrollBarImageColor3 = v2.BorderLit,
    ScrollBarImageTransparency = 0.25,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    ElasticBehavior = Enum.ElasticBehavior.Never,
  })

  local v34 = f1("UIListLayout", {
    Parent = v33,
    Padding = UDim.new(0, 1),
    SortOrder = Enum.SortOrder.LayoutOrder,
  })

  f4(0, 2, 0, 4).Parent = v33

  f1("Frame", {
    Parent = v31,
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(1, 1),
    Size = UDim2.new(1, -2, 1, -2),
    ZIndex = 50,
  }, { f2(v2.Border) })

  local v35 = {
    Name = p24,
    Frame = v31,
    Header = v32,
    Scroll = v33,
    Scale = scale,
    Items = {},
    order = 0,
    collapsed = false,
    x = 0,
    y = 0,
    moved = false,
  }

  function v35.refresh(p25)
    local highest2 = math.max(0.01, scale.Scale)
    local y2 = v34.AbsoluteContentSize.Y
    local highest3 = math.max(60, (parent3.AbsoluteSize.Y - 8 - 16) / highest2 - 30)
    local lowest = math.min(y2 / highest2 + 6, highest3)
    v33.Size = UDim2.new(1, 0, 0, lowest)

    v4.to(v31, "h", p25 and 0.2 or 0, {
      Size = UDim2.fromOffset(210, 30 + (v35.collapsed and 0 or lowest)),
    })
  end

  v34:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() v35.refresh(false) end)

  function v35.toggleCollapse()
    v35.collapsed = not v35.collapsed
    v35.refresh(true)
  end

  v35.refresh(false)

  return v35
end

function f12(p26, frame, p27)
  table.insert(p26.Items, { Frame = frame, Text = string.lower(p27 or "") })
end

function v28.Heading(p28, _, text)
  f3({
    Parent = f1("Frame", {
      Parent = p28.Scroll,
      BackgroundTransparency = 1,
      Size = UDim2.new(1, 0, 0, 0),
      AutomaticSize = Enum.AutomaticSize.Y,
      LayoutOrder = getOrder(p28),
    }, { f4(10, 6, 10, 6) }),
    Text = text,
    TextSize = 11,
    TextColor3 = v2.SubText,
    TextWrapped = true,
    TextYAlignment = Enum.TextYAlignment.Top,
    Size = UDim2.new(1, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,
  })
end

function v28.Section(p29, p30)
  local parent9 = f1("Frame", {
    Parent = p29.Scroll,
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 24),
    LayoutOrder = getOrder(p29),
  })

  f3({
    Parent = parent9,
    Text = string.upper(p30),
    Font = v2.FontBold,
    TextSize = 10,
    TextColor3 = v2.SubText,
    Position = UDim2.fromOffset(10, 4),
    Size = UDim2.new(1, -20, 0, 16),
  })

  f1("Frame", {
    Parent = parent9,
    BackgroundColor3 = v2.Border,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 10, 1, -3),
    Size = UDim2.new(1, -20, 0, 1),
  })

  f12(p29, parent9, "")
end

function v28.Toggle(p31, p32)
  local key6 = p32.Key or p32.Name

  if v3[key6] == nil then
    v3[key6] = p32.Default or false
  end

  local v36 = v3[key6]

  local parent10 = f13(
    p31, p32.Description and 40 or 26, p32.Name .. " " .. (p32.Description or "")
  )

  local v37 = f3({
    Parent = parent10,
    Text = p32.Name,
    TextSize = 12,
    Position = UDim2.fromOffset(10, p32.Description and 4 or 0),
    Size = UDim2.new(1, -16, 0, p32.Description and 18 or 26),
  })

  if p32.Description then
    f3({
      Parent = parent10,
      Text = p32.Description,
      TextSize = 10,
      TextColor3 = v2.Dim,
      Position = UDim2.fromOffset(10, 21),
      Size = UDim2.new(1, -16, 0, 14),
    })
  end

  local v38 = f1("Frame", {
    Parent = parent10,
    BackgroundColor3 = v2.Accent,
    BorderSizePixel = 0,
    Size = UDim2.new(0, 2, 1, 0),
    BackgroundTransparency = 1,
  })

  local v39 = f1("TextButton", {
    Parent = parent10,
    BackgroundTransparency = 1,
    Text = "",
    AutoButtonColor = false,
    Size = UDim2.fromScale(1, 1),
  })

  local v40 = f14(parent10, v39, function() return v36 and 0.55 or 1 end)

  local function f17(p33)
    v4.to(v37, "c", p33, { TextColor3 = v36 and v2.Accent or v2.SubText })
    v4.to(v38, "c", p33, { BackgroundTransparency = v36 and 0 or 1 })
    v40(p33)
  end

  f17(0)

  local v41 = {}

  function v41.Set(p34, p35)
    v36 = p34
    v3[key6] = p34
    f17(0.18)

    if not p35 and p32.Callback then
      task.spawn(p32.Callback, p34)
    end
  end

  function v41.Get()
    return v36
  end

  v39.Activated:Connect(function() v41.Set(not v36) end)
  f8(v39, p32.Tooltip)
  return v41
end

function v28.Slider(p36, p37)
  local key7 = p37.Key or p37.Name
  local increment = p37.Increment or 1

  if v3[key7] == nil then
    v3[key7] = p37.Default or p37.Min
  end

  local parent11 = f13(p36, 42, p37.Name)

  f3({
    Parent = parent11,
    Text = p37.Name,
    TextSize = 12,
    Position = UDim2.fromOffset(10, 4),
    Size = UDim2.new(0.6, -10, 0, 18),
  })

  local v42 = f3({
    Parent = parent11,
    TextXAlignment = Enum.TextXAlignment.Right,
    TextColor3 = v2.SubText,
    TextSize = 11,
    Position = UDim2.new(0.6, 0, 0, 4),
    Size = UDim2.new(0.4, -10, 0, 18),
  })

  local parent12 = f1("Frame", {
    Parent = parent11,
    BackgroundColor3 = v2.Raised,
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(10, 30),
    Size = UDim2.new(1, -20, 0, 3),
  }, { f5(2) })

  local v43 = f1("Frame", {
    Parent = parent12,
    BackgroundColor3 = v2.Accent,
    BorderSizePixel = 0,
    Size = UDim2.new(0, 0, 1, 0),
  }, { f5(2) })

  local v44 = f1("Frame", {
    Parent = parent12,
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = v2.Accent,
    Size = UDim2.fromOffset(10, 10),
    Position = UDim2.new(0, 0, 0.5, 0),
  }, { f5(5), f2(v2.Bg, 2) })

  local v45 = f1("TextButton", {
    Parent = parent11,
    BackgroundTransparency = 1,
    Text = "",
    AutoButtonColor = false,
    Position = UDim2.fromOffset(4, 20),
    Size = UDim2.new(1, -8, 0, 22),
  })

  local function f18(p38)
    return (increment % 1 ~= 0 and string.format("%.2f", p38) or tostring(math.floor(p38 + 0.5)))
      .. (p37.Suffix or "")
  end

  local function f19(clamped3, p39)
    local v46 = (clamped3 - p37.Min) / (p37.Max - p37.Min)
    v42.Text = f18(clamped3)

    v4.to(v43, "w", p39, { Size = UDim2.new(v46, 0, 1, 0) })
    v4.to(v44, "x", p39, { Position = UDim2.new(v46, 0, 0.5, 0) })
  end

  local v47 = {}

  function v47.Set(p40, p41)
    local clamped4 = math.clamp(p40, p37.Min, p37.Max)
    local v48 = clamped4 ~= v3[key7]
    v3[key7] = clamped4
    f19(clamped4, 0.06)

    if v48 and not p41 and p37.Callback then
      task.spawn(p37.Callback, clamped4)
    end
  end

  function v47.Get()
    return v3[key7]
  end

  local function f20(x2)
    local clamp = math.clamp
    local x3 = parent12.AbsolutePosition.X
    local highest4 = math.max(1, parent12.AbsoluteSize.X)
    local v49 = clamp((x2 - x3) / highest4, 0, 1)
    local min = p37.Min
    local rounded = math.floor((p37.Max - p37.Min) * v49 / increment + 0.5)

    v47.Set(tonumber(string.format(
      "%.4f", math.clamp(min + rounded * increment, p37.Min, p37.Max)
    )))
  end

  v45.InputBegan:Connect(function(input3)
    local userInputType2 = input3.UserInputType

    if userInputType2 == Enum.UserInputType.MouseButton1
      or userInputType2 == Enum.UserInputType.Touch then
      v18 = {
        touch = userInputType2 == Enum.UserInputType.Touch and input3 or nil,
        update = function(p42) f20(p42.X) end,
        finish = function() v4.to(v44, "s", 0.12, { Size = UDim2.fromOffset(10, 10) }) end,
      }

      v4.to(v44, "s", 0.12, { Size = UDim2.fromOffset(13, 13) })
      f20(input3.Position.X)
    end
  end)

  f14(parent11, v45)
  f8(v45, p37.Tooltip)
  f19(v3[key7], 0)
  return v47
end

function v28.Button(p43, p44)
  local parent13 = f13(
    p43, p44.Description and 40 or 28, p44.Name .. " " .. (p44.Description or "")
  )

  f3({
    Parent = parent13,
    Text = p44.Name,
    TextSize = 12,
    Position = UDim2.fromOffset(10, p44.Description and 4 or 0),
    Size = UDim2.new(1, -92, 0, p44.Description and 18 or 28),
  })

  if p44.Description then
    f3({
      Parent = parent13,
      Text = p44.Description,
      TextSize = 10,
      TextColor3 = v2.Dim,
      Position = UDim2.fromOffset(10, 21),
      Size = UDim2.new(1, -92, 0, 14),
    })
  end

  local disabled = p44.Disabled or false

  local instance4 = f1("TextButton", {
    Parent = parent13,
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -8, 0.5, 0),
    Size = UDim2.fromOffset(68, 20),
    BackgroundColor3 = v2.Raised,
    AutoButtonColor = false,
    Text = p44.Text or "Run",
    Font = v2.Font,
    TextSize = 11,
    TextColor3 = disabled and v2.Dim or v2.Text,
  }, { f2(v2.Border) })

  local uiStroke2 = instance4:FindFirstChildOfClass("UIStroke")
  local flag3 = false

  local function f21()
    v4.to(instance4, "bg", 0.12, {
      BackgroundColor3 = flag3 and not disabled and v2.Hover or v2.Raised,
      TextColor3 = disabled and v2.Dim or v2.Text,
    })

    v4.to(uiStroke2, "c", 0.12, { Color = flag3 and not disabled and v2.BorderLit or v2.Border })
  end

  instance4.MouseEnter:Connect(function()
    flag3 = true
    f21()
  end)

  instance4.MouseLeave:Connect(function()
    flag3 = false
    f21()
  end)

  instance4.MouseButton1Down:Connect(function()
    if disabled then
      return
    end

    v4.to(instance4, "bg", 0.06, { BackgroundColor3 = v2.Accent, TextColor3 = v2.AccentInk })
  end)

  instance4.MouseButton1Up:Connect(f21)

  instance4.Activated:Connect(function()
    if not disabled and p44.Callback then
      task.spawn(p44.Callback)
    end
  end)

  f8(instance4, p44.Tooltip)

  return {
    SetDisabled = function(disabled2)
      disabled = disabled2
      f21()
    end,
    SetText = function(text2) instance4.Text = text2 end,
  }
end

function v28.Dropdown(p45, p46)
  local key8 = p46.Key or p46.Name

  if v3[key8] == nil then
    v3[key8] = p46.Default or p46.Options[1]
  end

  local v50 = 26 + #p46.Options * 24 + 6
  local parent14 = f13(p45, 26, p46.Name)

  local parent15 = f1("TextButton", {
    Parent = parent14,
    BackgroundTransparency = 1,
    Text = "",
    AutoButtonColor = false,
    Size = UDim2.new(1, 0, 0, 26),
  })

  f3({
    Parent = parent15,
    Text = p46.Name,
    TextSize = 12,
    Position = UDim2.fromOffset(10, 0),
    Size = UDim2.new(0.5, -10, 1, 0),
  })

  local v51 = f3({
    Parent = parent15,
    TextColor3 = v2.SubText,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Right,
    Position = UDim2.new(0.5, 0, 0, 0),
    Size = UDim2.new(0.5, -28, 1, 0),
  })

  local v52 = f3({
    Parent = parent15,
    Text = ">",
    Font = v2.FontBold,
    TextSize = 11,
    TextColor3 = v2.SubText,
    TextXAlignment = Enum.TextXAlignment.Center,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(1, -14, 0.5, 0),
    Size = UDim2.fromOffset(14, 14),
    Rotation = 90,
  })

  local parent16 = f1("Frame", {
    Parent = parent14,
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(6, 26),
    Size = UDim2.new(1, -12, 0, #p46.Options * 24),
  }, { f1("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }) })

  local map5 = {}
  local v53 = false

  local function f22(p47)
    v53 = p47
    v4.to(parent14, "h", 0.22, { Size = UDim2.new(1, 0, 0, p47 and v50 or 26) })
    v4.to(v52, "r", 0.22, { Rotation = p47 and -90 or 90 })
  end

  local function f23()
    v51.Text = tostring(v3[key8])

    for key9, value9 in pairs(map5) do
      v4.to(value9, "c", 0.12, { TextColor3 = key9 == v3[key8] and v2.Accent or v2.SubText })
    end
  end

  for index2, value10 in ipairs(p46.Options) do
    local v54 = f1("TextButton", {
      Parent = parent16,
      LayoutOrder = index2,
      Size = UDim2.new(1, 0, 0, 24),
      BackgroundColor3 = v2.Hover,
      BackgroundTransparency = 1,
      AutoButtonColor = false,
      Text = value10,
      Font = v2.Font,
      TextSize = 11,
      TextColor3 = v2.SubText,
      TextXAlignment = Enum.TextXAlignment.Left,
    }, { f4(8, 0, 0, 0) })

    map5[value10] = v54

    v54.MouseEnter:Connect(function() v4.to(v54, "bg", 0.1, { BackgroundTransparency = 0.4 }) end)
    v54.MouseLeave:Connect(function() v4.to(v54, "bg", 0.1, { BackgroundTransparency = 1 }) end)

    v54.Activated:Connect(function()
      v3[key8] = value10
      f23()
      f22(false)

      if p46.Callback then
        task.spawn(p46.Callback, value10)
      end
    end)
  end

  parent15.Activated:Connect(function() f22(not v53) end)
  f14(parent14, parent15)
  f8(parent15, p46.Tooltip)
  f23()
end

local v55

function v28.Keybind(p48, p49)
  local key10 = p49.Key or p49.Name

  if v3[key10] == nil then
    v3[key10] = p49.Default or Enum.KeyCode.F
  end

  local parent17 = f13(p48, 28, p49.Name)

  f3({
    Parent = parent17,
    Text = p49.Name,
    TextSize = 12,
    Position = UDim2.fromOffset(10, 0),
    Size = UDim2.new(1, -100, 1, 0),
  })

  local instance5 = f1("TextButton", {
    Parent = parent17,
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -8, 0.5, 0),
    Size = UDim2.fromOffset(84, 20),
    BackgroundColor3 = v2.Raised,
    AutoButtonColor = false,
    Font = v2.Font,
    TextSize = 11,
    TextColor3 = v2.Text,
    Text = v3[key10].Name,
  }, { f2(v2.Border) })

  local uiStroke3 = instance5:FindFirstChildOfClass("UIStroke")
  local v56

  local function f24()
    if v55 == v56 then
      v55 = nil
    end

    instance5.Text = v3[key10].Name
    v4.to(uiStroke3, "c", 0.15, { Color = v2.Border })
  end

  v56 = {
    cancel = f24,
    onKey = function(p50)
      if p50 == Enum.KeyCode.Escape then
        f24()
        return
      end

      v3[key10] = p50
      f24()

      if p49.Callback then
        task.spawn(p49.Callback, p50)
      end
    end,
  }

  instance5.Activated:Connect(function()
    if v55 == v56 then
      f24()
      return
    end

    if v55 then
      v55.cancel()
    end

    v55 = v56
    instance5.Text = "Press key..."
    v4.to(uiStroke3, "c", 0.15, { Color = v2.Accent })
  end)
end

function v28.TextBox(p51, p52)
  local key11 = p52.Key or p52.Name

  if v3[key11] == nil then
    v3[key11] = p52.Default or ""
  end

  local parent18 = f13(p51, 28, p52.Name)

  f3({
    Parent = parent18,
    Text = p52.Name,
    TextSize = 12,
    Position = UDim2.fromOffset(10, 0),
    Size = UDim2.new(1, -120, 1, 0),
  })

  local vector2 = Vector2.new(1, 0.5)

  local instance6 = f1("TextBox", {
    Parent = parent18,
    AnchorPoint = vector2,
    Position = UDim2.new(1, -8, 0.5, 0),
    Size = UDim2.fromOffset(104, 20),
    BackgroundColor3 = v2.Raised,
    TextColor3 = v2.Text,
    Font = v2.Font,
    TextSize = 11,
    ClearTextOnFocus = false,
    Text = v3[key11],
    PlaceholderText = p52.Placeholder or "",
    PlaceholderColor3 = v2.Dim,
    TextXAlignment = Enum.TextXAlignment.Left,
    ClipsDescendants = true,
  }, { f2(v2.Border), f4(6, 0, 6, 0) })

  local uiStroke4 = instance6:FindFirstChildOfClass("UIStroke")

  instance6.Focused:Connect(function() v4.to(uiStroke4, "c", 0.15, { Color = v2.Accent }) end)

  instance6.FocusLost:Connect(function()
    v4.to(uiStroke4, "c", 0.2, { Color = v2.Border })
    local replaced = string.gsub(instance6.Text, "^%s*(.-)%s*$", "%1")

    if p52.Validate and not p52.Validate(replaced) then
      instance6.Text = v3[key11]

      f10({
        Title = "Invalid value",
        Text = p52.ErrorText or "That input was not accepted.",
        Style = "warning",
        Duration = 3,
      })

      return
    end

    instance6.Text = replaced
    v3[key11] = replaced

    if p52.Callback then
      task.spawn(p52.Callback, replaced)
    end
  end)
end

function v28.Search(p53, p54, p55)
  local parent19 = f1("Frame", {
    Parent = p53.Scroll,
    BackgroundColor3 = v2.Raised,
    BackgroundTransparency = 0.4,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 28),
    LayoutOrder = getOrder(p53),
  }, { f2(v2.Border) })

  local uiStroke5 = parent19:FindFirstChildOfClass("UIStroke")

  f1("Frame", {
    Parent = parent19,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromOffset(17, 13),
    Size = UDim2.fromOffset(9, 9),
    BackgroundTransparency = 1,
  }, { f5(5), f2(v2.Dim, 1.5) })

  f1("Frame", {
    Parent = parent19,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(22, 19),
    Size = UDim2.fromOffset(5, 1.5),
    BackgroundColor3 = v2.Dim,
    BorderSizePixel = 0,
    Rotation = 45,
  })

  local v57 = f1("TextBox", {
    Parent = parent19,
    BackgroundTransparency = 1,
    Position = UDim2.fromOffset(32, 0),
    Size = UDim2.new(1, -40, 1, 0),
    ClearTextOnFocus = false,
    Text = "",
    PlaceholderText = p54 or "Search controls...",
    PlaceholderColor3 = v2.Dim,
    TextColor3 = v2.Text,
    Font = v2.Font,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
    ClipsDescendants = true,
  })

  local v58 = f3({
    Parent = p53.Scroll,
    Text = "No matching controls",
    TextSize = 11,
    TextColor3 = v2.Dim,
    TextXAlignment = Enum.TextXAlignment.Center,
    Size = UDim2.new(1, 0, 0, 36),
    LayoutOrder = 9999,
    Visible = false,
  })

  v57.Focused:Connect(function() v4.to(uiStroke5, "c", 0.15, { Color = v2.Accent }) end)
  v57.FocusLost:Connect(function() v4.to(uiStroke5, "c", 0.2, { Color = v2.Border }) end)

  v57:GetPropertyChangedSignal("Text"):Connect(function()
    local flag4 = false
    local lower = string.lower(v57.Text)

    for _, value11 in ipairs(p55 or { p53 }) do
      for _, value12 in ipairs(value11.Items) do
        local visible = lower == ""
          or value12.Text ~= "" and string.find(value12.Text, lower, 1, true) ~= nil

        value12.Frame.Visible = visible

        if visible and lower ~= "" then
          flag4 = true
        end
      end
    end

    v58.Visible = lower ~= "" and not flag4
  end)
end

local f25

local function f26()
  local parent20 = f1("ScreenGui", {
    Name = "JewWorksLoader",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 1000,
    Parent = parent,
  })

  local currentCamera = workspace.CurrentCamera
  local viewportSize = currentCamera and currentCamera.ViewportSize or Vector2.new(1280, 720)
  local v59 = viewportSize.X / 2

  local clamped5 = math.clamp(
    math.floor(math.min(viewportSize.X, viewportSize.Y) * 0.34), 120, 280
  )

  local rounded2 = math.floor(viewportSize.Y * 0.39)

  local v60 = f1("Frame", {
    Parent = parent20,
    BackgroundColor3 = Color3.new(0, 0, 0),
    BorderSizePixel = 0,
    Size = UDim2.fromScale(1, 1),
  })

  local v61 = f1("CanvasGroup", {
    Parent = parent20,
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 1),
  })

  local parent21 = f1("CanvasGroup", {
    Parent = parent20,
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 1),
  })

  local list4 = {}
  f25(v61, 18, list4)

  local parent22 = f1("Frame", {
    Parent = v61,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromOffset(v59, rounded2),
    Size = UDim2.new(0, 0, 0, 1),
    BackgroundColor3 = v2.Accent,
    BackgroundTransparency = 0.75,
    BorderSizePixel = 0,
  })

  f1("UIGradient", {
    Parent = parent22,
    Transparency = NumberSequence.new({
      NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0),
      NumberSequenceKeypoint.new(1, 1),
    }),
  })

  local parent23, _, v62 = getParent(parent21, clamped5, math.max(2, clamped5 / 70), v2.Accent)
  parent23.AnchorPoint = Vector2.new(0.5, 0.5)
  parent23.Position = UDim2.fromOffset(-clamped5, rounded2)

  local v63 = f1("UIScale", { Parent = parent23, Scale = 0.9 })
  local radians2 = math.rad(82)
  v62(math.cos(radians2))
  local center = Enum.TextXAlignment.Center
  local highest5 = math.max(26, math.floor(clamped5 * 0.2))
  local v64 = rounded2 + clamped5 / 2 + 24

  local v65 = f3({
    Parent = parent21,
    Text = v2.Name,
    Font = v2.FontBold,
    TextSize = highest5,
    TextTransparency = 1,
    TextXAlignment = center,
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.fromOffset(v59, v64 + 12),
    Size = UDim2.fromOffset(500, highest5 + 6),
  })

  local v66 = v64 + highest5 + 22

  local v67 = f3({
    Parent = parent21,
    Text = "Loading.",
    TextSize = 13,
    TextColor3 = v2.SubText,
    TextTransparency = 1,
    TextXAlignment = center,
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.fromOffset(v59, v66),
    Size = UDim2.fromOffset(200, 18),
  })

  local clamped6 = math.clamp(math.floor(viewportSize.X * 0.32), 200, 380)
  local v68 = v66 + 26

  local parent24 = f1("Frame", {
    Parent = parent21,
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.fromOffset(v59, v68),
    Size = UDim2.fromOffset(clamped6, 2),
    BackgroundColor3 = v2.Raised,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
  }, { f5(1) })

  local parent25 = f1("Frame", {
    Parent = parent24,
    Size = UDim2.new(0, 0, 1, 0),
    BackgroundColor3 = v2.Accent,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
  }, { f5(1) })

  f1("UIGradient", {
    Parent = parent25,
    Color = ColorSequence.new(Color3.fromRGB(110, 110, 110), Color3.new(1, 1, 1)),
  })

  local v69 = f1("Frame", {
    Parent = parent25,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(1, 0, 0.5, 0),
    Size = UDim2.fromOffset(26, 9),
    BackgroundColor3 = Color3.new(1, 1, 1),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
  }, { f5(4) })

  local v70 = f3({
    Parent = parent21,
    Text = "0%",
    TextSize = 11,
    TextColor3 = v2.SubText,
    TextTransparency = 1,
    TextXAlignment = Enum.TextXAlignment.Right,
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.fromOffset(v59 + clamped6 / 2, v68 + 10),
    Size = UDim2.fromOffset(60, 16),
  })

  local v71 = {}

  function v71.run(fn)
    v4.to(
      parent23, "x", 1.5, { Position = UDim2.fromOffset(v59, rounded2) },
      Enum.EasingStyle.Quint, Enum.EasingDirection.InOut
    )

    task.wait(1.15)
    local now = os.clock()

    while true do
      local clamped7 = math.clamp((os.clock() - now) / 1.5, 0, 1)
      local v72 = 1 - (1 - clamped7) ^ 4
      v62(math.cos(radians2 * (1 - v72)))
      v63.Scale = 0.9 + 0.1 * v72

      if clamped7 >= 1 then
        break
      end

      runService.RenderStepped:Wait()
    end

    v62(1)

    v4.to(parent22, "w", 1.4, { Size = UDim2.new(0.8, 0, 0, 1) })
    v4.to(v65, "t", 0.6, { TextTransparency = 0 })
    v4.to(v65, "p", 0.7, { Position = UDim2.fromOffset(v59, v64) })

    task.wait(0.35)

    v4.to(v67, "t", 0.4, { TextTransparency = 0 })
    v4.to(v70, "t", 0.4, { TextTransparency = 0 })
    v4.to(parent24, "t", 0.4, { BackgroundTransparency = 0 })
    v4.to(parent25, "t", 0.4, { BackgroundTransparency = 0 })
    v4.to(v69, "t", 0.4, { BackgroundTransparency = 0.7 })

    local flag5 = true

    task.spawn(function()
      local v73 = 1

      while flag5 do
        v67.Text = "Loading" .. string.rep(".", v73)
        v73 = v73 % 3 + 1
        task.wait(0.35)
      end
    end)

    local now2 = os.clock()

    while true do
      local clamped8 = math.clamp((os.clock() - now2) / 3.4, 0, 1)
      local v74 = clamped8 < 0.5 and 2 * clamped8 * clamped8 or 1 - (-2 * clamped8 + 2) ^ 2 / 2
      parent25.Size = UDim2.new(v74, 0, 1, 0)
      v70.Text = string.format("%d%%", math.floor(v74 * 100))

      if clamped8 >= 1 then
        break
      end

      runService.RenderStepped:Wait()
    end

    flag5 = false
    v67.Text = "Ready."
    v4.to(v69, "t", 0.4, { BackgroundTransparency = 1 })
    task.wait(0.45)
    v4.to(v63, "s", 0.6, { Scale = 0.82 }, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut)
    task.wait(0.45)
    fn()

    v4.to(parent21, "f", 0.5, { GroupTransparency = 1 })
    v4.to(v61, "f", 0.5, { GroupTransparency = 1 })
    v4.to(v60, "b", 0.6, { BackgroundTransparency = 1 })

    task.wait(v3.Animations and 0.65 or 0)

    for _, value13 in ipairs(list4) do
      value13:Cancel()
    end

    parent20:Destroy()
  end

  return v71
end

function f25(parent26, p56, list5)
  local random = Random.new(os.time())

  for j = 1, p56 do
    local nextInteger = random:NextInteger(1, 3)
    local nextNumber = random:NextNumber()
    local nextNumber2 = random:NextNumber(10, 20)

    local create2 = tweenService:Create(f1("Frame", {
      Parent = parent26,
      BorderSizePixel = 0,
      BackgroundColor3 = v2.Accent,
      BackgroundTransparency = random:NextNumber(0.8, 0.94),
      Size = UDim2.fromOffset(nextInteger, nextInteger),
      Position = UDim2.new(nextNumber, 0, 1, 8),
    }, { f5(2) }), TweenInfo.new(
      nextNumber2, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1, false,
      random:NextNumber(0, nextNumber2)
    ), {
      Position = UDim2.new(nextNumber + random:NextNumber(-0.04, 0.04), 0, 0, -8),
    })

    create2:Play()

    table.insert(list5, create2)
  end
end

local v75 = {}

local v76 = {
  Brightness = lighting.Brightness,
  ClockTime = lighting.ClockTime,
  FogEnd = lighting.FogEnd,
  GlobalShadows = lighting.GlobalShadows,
  Ambient = lighting.Ambient,
  OutdoorAmbient = lighting.OutdoorAmbient,
  Gravity = workspaceService.Gravity,
  Zoom = localPlayer.CameraMaxZoomDistance,
}

local function getHumanoidRootPart()
  local character2 = localPlayer.Character
  return character2 and character2:FindFirstChild("HumanoidRootPart")
end

local function getHumanoid()
  local character3 = localPlayer.Character
  return character3 and character3:FindFirstChildOfClass("Humanoid")
end

local v77 = { bv = nil, bg = nil }

local function f27()
  if v77.bv then
    v77.bv:Destroy()
    v77.bv = nil
  end

  if v77.bg then
    v77.bg:Destroy()
    v77.bg = nil
  end

  local humanoid = getHumanoid()

  if humanoid then
    humanoid.PlatformStand = false
  end
end

local function makeBodyVelocity()
  local parent27 = getHumanoidRootPart()
  local v78 = not parent27
  local humanoid2 = getHumanoid()

  if v78 or not humanoid2 then
    return
  end

  f27()

  v77.bv = Instance.new("BodyVelocity")
  v77.bv.MaxForce = Vector3.new(1000000000, 1000000000, 1000000000)
  v77.bv.Velocity = Vector3.zero
  v77.bv.Parent = parent27
  v77.bg = Instance.new("BodyGyro")
  v77.bg.MaxTorque = Vector3.new(1000000000, 1000000000, 1000000000)
  v77.bg.P = 90000
  v77.bg.CFrame = parent27.CFrame
  v77.bg.Parent = parent27

  humanoid2.PlatformStand = true
end

local function f28()
  for _, value14 in ipairs(players:GetPlayers()) do
    if value14 ~= localPlayer then
      local character4 = value14.Character

      local head = character4
      head = character4 and character4:FindFirstChild("Head")

      if head and head:FindFirstChild("JewWorksUserTagMarker") then
        local humanoidRootPart = character4:FindFirstChild("HumanoidRootPart")
        local humanoidRootPart2 = getHumanoidRootPart()

        if humanoidRootPart and humanoidRootPart2 then
          humanoidRootPart2.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 3, 2)

          f10({
            Title = "JW Teleport",
            Text = "Teleported to JW user: " .. value14.DisplayName,
            Style = "success",
            Duration = 3,
          })

          return
        end
      end
    end
  end

  f10({
    Title = "JW Teleport",
    Text = "No active JW users found in server.",
    Style = "warning",
    Duration = 3,
  })
end

local instance7

local function makeFolder2(p57)
  local character5 = localPlayer.Character

  if p57 then
    if character5 then
      local head2 = character5:FindFirstChild("Head")

      if head2 and not head2:FindFirstChild("JewWorksUserTagMarker") then
        local jewWorksUserTagMarker = Instance.new("Folder")
        jewWorksUserTagMarker.Name = "JewWorksUserTagMarker"
        jewWorksUserTagMarker.Parent = head2

        instance7 = jewWorksUserTagMarker
      end
    end
  elseif instance7 and instance7.Parent then
    instance7:Destroy()
    instance7 = nil
  end
end

local instance8, connect2

local function makeImageLabel(p58)
  local customCursor

  if p58 then
    if instance8 then
      instance8:Destroy()
    end

    local customCrosshair = Instance.new("ScreenGui")
    customCrosshair.Name = "CustomCrosshair"
    customCrosshair.IgnoreGuiInset = true
    customCrosshair.ResetOnSpawn = false
    customCrosshair.DisplayOrder = 999999
    customCrosshair.Parent = parent3

    customCursor = Instance.new("ImageLabel")
    customCursor.Name = "CustomCursor"
    customCursor.BackgroundTransparency = 1
    customCursor.Size = UDim2.fromOffset(32, 32)
    customCursor.AnchorPoint = Vector2.new(0.5, 0.5)
    customCursor.Image = "rbxthumb://type=Asset&id=1407578508&w=420&h=420"
    customCursor.Visible = true
    customCursor.Parent = customCrosshair

    pcall(function() contentProvider:PreloadAsync({ customCursor }) end)
    userInputService.MouseIconEnabled = false
    instance8 = customCrosshair

    connect2 = runService.RenderStepped:Connect(function()
      if not v3.F_Crosshair then
        return
      end

      local getMouseLocation = userInputService:GetMouseLocation()
      customCursor.Position = UDim2.fromOffset(getMouseLocation.X, getMouseLocation.Y)
    end)
  else
    userInputService.MouseIconEnabled = true

    if connect2 then
      connect2:Disconnect()
      connect2 = nil
    end

    if instance8 then
      instance8:Destroy()
      instance8 = nil
    end
  end
end

local map6 = {}
local v79

local function makeBillboardGui()
  local list6 = {}

  for _, value15 in ipairs(players:GetPlayers()) do
    if value15 ~= localPlayer then
      local character6 = value15.Character

      local head3 = character6
      head3 = character6 and character6:FindFirstChild("Head")

      if head3 and head3:FindFirstChild("JewWorksUserTagMarker") then
        table.insert(list6, value15)

        if not map6[value15] or not map6[value15].Parent then
          local jwUserBillboard = Instance.new("BillboardGui")
          jwUserBillboard.Name = "JWUserBillboard"
          jwUserBillboard.Size = UDim2.fromOffset(160, 32)
          jwUserBillboard.StudsOffset = Vector3.new(0, 3, 0)
          jwUserBillboard.AlwaysOnTop = true
          jwUserBillboard.Adornee = head3
          jwUserBillboard.Parent = parent3

          local parent28 = f1("Frame", {
            Parent = jwUserBillboard,
            BackgroundColor3 = Color3.fromRGB(15, 15, 15),
            Size = UDim2.fromScale(1, 1),
            BorderSizePixel = 0,
          }, { f5(6), f2(v2.BorderLit), f4(6, 4, 6, 4) })

          local parent29 = getParent(parent28, 20, 1.2, v2.Accent)
          parent29.Position = UDim2.fromOffset(2, 2)

          f3({
            Parent = parent28,
            RichText = true,
            TextSize = 12,
            Text = '<font color="rgb(60,130,255)">Jew</font><font color="rgb(255,255,255)">Works</font> user',
            Position = UDim2.fromOffset(26, 0),
            Size = UDim2.new(1, -26, 1, 0),
          })

          map6[value15] = jwUserBillboard
        end
      elseif map6[value15] then
        map6[value15]:Destroy()
        map6[value15] = nil
      end
    end
  end

  if v79 then
    if #list6 > 0 then
      v79.SetDisabled(false)
      v79.SetText("TP to (" .. #list6 .. ")")
    else
      v79.SetDisabled(true)
      v79.SetText("No JW Users")
    end
  end
end

local circle = Drawing.new("Circle")
circle.Visible = false
circle.Thickness = 1.5
circle.NumSides = 64
circle.Filled = false
circle.Transparency = 0.8

local text3 = Drawing.new("Text")
text3.Visible = false
text3.Size = 13
text3.Center = true
text3.Outline = true
text3.OutlineColor = Color3.fromRGB(0, 0, 0)
text3.Color = Color3.fromRGB(255, 255, 255)
text3.Font = Drawing.Fonts.UI

local function f29(p59)
  if p59 == localPlayer then
    return false
  end

  if v3.F_TeamCheck and p59.Team ~= nil and p59.Team == localPlayer.Team then
    return false
  end

  return true
end

local flag6 = false
local map7

local function f30()
  for _, value16 in pairs(map7) do
    if value16 and value16.Parent then
      value16:Destroy()
    end
  end

  map7 = {}
end

local connect3, connect4

local function f31()
  if connect3 then
    connect3:Disconnect()
  end

  if connect4 then
    connect4:Disconnect()
  end

  connect3 = userInputService.InputBegan:Connect(function(input4, p60)
    if v3.F_Aimlock and input4.UserInputType == Enum.UserInputType.MouseButton2 then
      flag6 = true
    end
  end)

  connect4 = userInputService.InputEnded:Connect(function(input5, p61)
    if input5.UserInputType == Enum.UserInputType.MouseButton2 then
      flag6 = false
    end
  end)
end

f31()

local function f32()
  local fAimFOV = v3.F_AimFOV
  local currentCamera2 = workspaceService.CurrentCamera

  local vector3 = Vector2.new(
    currentCamera2.ViewportSize.X / 2, currentCamera2.ViewportSize.Y / 2
  )

  local v80

  for _, value17 in ipairs(players:GetPlayers()) do
    if f29(value17) and value17.Character then
      local humanoid3 = value17.Character:FindFirstChildOfClass("Humanoid")
      local head4 = value17.Character:FindFirstChild("Head")

      if humanoid3 and humanoid3.Health > 0 and head4 then
        local screenPoint, onScreen = currentCamera2:WorldToViewportPoint(head4.Position)

        if onScreen then
          local magnitude = (Vector2.new(screenPoint.X, screenPoint.Y) - vector3).Magnitude

          if magnitude < fAimFOV then
            local raycastParams = RaycastParams.new()
            raycastParams.FilterType = Enum.RaycastFilterType.Exclude

            raycastParams.FilterDescendantsInstances = {
              localPlayer.Character, value17.Character,
            }

            if not workspaceService:Raycast(
              currentCamera2.CFrame.Position, head4.Position - currentCamera2.CFrame.Position,
              raycastParams
            ) then
              fAimFOV = magnitude
              v80 = head4
            end
          end
        end
      end
    end
  end

  return v80
end

local v81 = 0
local v82

local function f33(visible2)
  circle.Visible = visible2
  text3.Visible = visible2

  if visible2 then
    if v82 then
      v82:Disconnect()
    end

    v82 = getConnect(runService.RenderStepped:Connect(function(delta)
      if not v3.F_Aimlock then
        return
      end

      local currentCamera3 = workspaceService.CurrentCamera
      v81 = (v81 + delta * 0.5) % 1
      local color = Color3.fromHSV(v81, 1, 1)

      local vector4 = Vector2.new(
        currentCamera3.ViewportSize.X / 2, currentCamera3.ViewportSize.Y / 2
      )

      circle.Position = vector4
      circle.Radius = v3.F_AimFOV
      circle.Color = color

      text3.Position = Vector2.new(vector4.X, 30)
      text3.Text = "AURA // " .. (flag6 and "ACTIVE" or "IDLE")

      if flag6 then
        local v83 = f32()

        if v83 then
          local screenPoint2, onScreen2 = currentCamera3:WorldToViewportPoint(v83.Position)
          local v84 = Vector2.new(screenPoint2.X, screenPoint2.Y) - vector4
          local clamped9 = math.clamp(v3.F_AimSmoothing / 10, 0.05, 1)

          if v3.F_AimSmoothing >= 10 then
            currentCamera3.CFrame = CFrame.new(currentCamera3.CFrame.Position, v83.Position)
          else
            local v85 = v84 * clamped9
            local cframe = currentCamera3.CFrame
            local angles = CFrame.Angles
            local radians3 = math.rad(v85.Y * 0.1)
            local radians4 = math.rad(v85.X * 0.1)
            local v86 = angles(-radians3, -radians4, 0)

            currentCamera3.CFrame = CFrame.new(currentCamera3.CFrame.Position, currentCamera3.CFrame.Position
              + (cframe * v86).LookVector * 1000)
          end
        end
      end
    end))
  else
    if v82 then
      v82:Disconnect()
      v82 = nil
    end

    circle.Visible = false
    text3.Visible = false
  end
end

local function makePart()
  local seen = {}

  if v3.F_Hitbox then
    for _, value18 in ipairs(players:GetPlayers()) do
      local character7 = value18.Character

      local humanoidRootPart3 = character7
      humanoidRootPart3 = character7 and character7:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart3 and f29(value18) then
        seen[humanoidRootPart3] = true
        local instance9 = map7[humanoidRootPart3]
        local vector5 = Vector3.new(v3.F_HitboxSize, v3.F_HitboxSize, v3.F_HitboxSize)

        if not instance9 or not instance9.Parent then
          local jewWorksHitboxProxy = Instance.new("Part")
          jewWorksHitboxProxy.Name = "JewWorksHitboxProxy"
          jewWorksHitboxProxy.Size = vector5
          jewWorksHitboxProxy.Transparency = v3.F_HitboxTrans
          jewWorksHitboxProxy.Color = Color3.fromRGB(255, 0, 0)
          jewWorksHitboxProxy.Material = Enum.Material.Neon
          jewWorksHitboxProxy.CanCollide = false
          jewWorksHitboxProxy.CanQuery = true
          jewWorksHitboxProxy.Massless = true

          local weldConstraint = Instance.new("WeldConstraint")
          weldConstraint.Part0 = humanoidRootPart3
          weldConstraint.Part1 = jewWorksHitboxProxy
          weldConstraint.Parent = jewWorksHitboxProxy

          jewWorksHitboxProxy.CFrame = humanoidRootPart3.CFrame
          jewWorksHitboxProxy.Parent = character7

          map7[humanoidRootPart3] = jewWorksHitboxProxy
        else
          if instance9.Size ~= vector5 then
            instance9.Size = vector5
          end

          if instance9.Transparency ~= v3.F_HitboxTrans then
            instance9.Transparency = v3.F_HitboxTrans
          end

          if instance9.CFrame ~= humanoidRootPart3.CFrame then
            instance9.CFrame = humanoidRootPart3.CFrame
          end
        end
      end
    end
  end

  for key12, value19 in pairs(map7) do
    if not seen[key12] or not key12.Parent then
      if value19 and value19.Parent then
        value19:Destroy()
      end

      map7[key12] = nil
    end
  end
end

map7 = {}
local map8 = {}

local function makeFolder3(descendant)
  if not descendant:IsA("BasePart") then
    return
  end

  descendant.Material = Enum.Material.ForceField
  descendant.Color = Color3.fromRGB(235, 245, 255)
  descendant.Transparency = 0

  for _, value20 in ipairs({ "FFParticlePoints", "ForcefieldParticles" }) do
    local findFirstChild2 = descendant:FindFirstChild(value20)

    if findFirstChild2 then
      findFirstChild2:Destroy()
    end
  end

  local ffParticlePoints = Instance.new("Folder")
  ffParticlePoints.Name = "FFParticlePoints"
  ffParticlePoints.Parent = descendant

  local x4 = descendant.Size.X
  local y3 = descendant.Size.Y
  local z = descendant.Size.Z
  local count3 = 0

  local function makeAttachment(vector6)
    count3 = count3 + 1

    local attachment = Instance.new("Attachment")
    attachment.Name = "Sparkle" .. count3
    attachment.Position = vector6
    attachment.Parent = ffParticlePoints

    local particleEmitter = Instance.new("ParticleEmitter")
    particleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    particleEmitter.Rate = 0.7
    particleEmitter.Lifetime = NumberRange.new(0.7, 1.3)
    particleEmitter.Speed = NumberRange.new(0.02, 0.12)
    particleEmitter.SpreadAngle = Vector2.new(180, 180)
    particleEmitter.LightEmission = 1
    particleEmitter.LightInfluence = 0
    particleEmitter.LockedToPart = true
    particleEmitter.Rotation = NumberRange.new(0, 360)
    particleEmitter.RotSpeed = NumberRange.new(-30, 30)

    particleEmitter.Size = NumberSequence.new({
      NumberSequenceKeypoint.new(0, 0.12), NumberSequenceKeypoint.new(0.5, 0.2),
      NumberSequenceKeypoint.new(1, 0),
    })

    particleEmitter.Color = ColorSequence.new(Color3.new(1, 1, 1))
    particleEmitter.Parent = attachment
  end

  for _, value21 in ipairs({ -1, 1 }) do
    for _, value22 in ipairs({ -1, 1 }) do
      for _, value23 in ipairs({ -1, 1 }) do
        makeAttachment(Vector3.new(value21 * x4 / 2, value22 * y3 / 2, value23 * z / 2))
      end
    end
  end

  for _, value24 in ipairs({ -1, 1 }) do
    for k = 0, 2 do
      for m = 0, 2 do
        makeAttachment(Vector3.new(value24 * x4 / 2, (k - 1) * y3 / 2, (m - 1) * z / 2))
      end
    end
  end

  for _, value25 in ipairs({ -1, 1 }) do
    for n = 0, 2 do
      for i6 = 0, 2 do
        makeAttachment(Vector3.new((n - 1) * x4 / 2, value25 * y3 / 2, (i6 - 1) * z / 2))
      end
    end
  end

  for _, value26 in ipairs({ -1, 1 }) do
    for i7 = 0, 2 do
      for i8 = 0, 2 do
        makeAttachment(Vector3.new((i7 - 1) * x4 / 2, (i8 - 1) * y3 / 2, value26 * z / 2))
      end
    end
  end
end

local function f34(key13)
  if not key13:IsA("Tool") or map8[key13] then
    return
  end

  local backpack2 = localPlayer:FindFirstChildOfClass("Backpack")
  local character8 = localPlayer.Character

  if backpack2 and key13.Parent ~= backpack2 and (not character8 or key13.Parent ~= character8) then
    return
  end

  map8[key13] = {}

  for _, value27 in ipairs(key13:GetDescendants()) do
    if value27:IsA("BasePart") and value27.Transparency < 1 then
      map8[key13][value27] = {
        Color = value27.Color,
        Material = value27.Material,
        Transparency = value27.Transparency,
        TextureID = value27:IsA("MeshPart") and value27.TextureID or nil,
      }

      makeFolder3(value27)
    elseif value27:IsA("SpecialMesh") then
      value27.TextureId = ""
    end
  end

  if not key13:GetAttribute("FFConnected") then
    key13:SetAttribute("FFConnected", true)

    key13.DescendantAdded:Connect(function(descendant2)
      if descendant2:IsA("BasePart") and v3.F_ForcefieldGun then
        task.wait(0.2)

        map8[key13][descendant2] = {
          Color = descendant2.Color,
          Material = descendant2.Material,
          Transparency = descendant2.Transparency,
          TextureID = descendant2:IsA("MeshPart") and descendant2.TextureID or nil,
        }

        makeFolder3(descendant2)
      end
    end)
  end
end

local v87, v88, v89, f35

local function f36(p62)
  if p62 then
    map8 = {}
    f35()

    local backpack3 = localPlayer:FindFirstChildOfClass("Backpack")
      or localPlayer:WaitForChild("Backpack", 2)

    if backpack3 then
      v87 = getConnect(backpack3.ChildAdded:Connect(f34))
    end

    local function f37(character9)
      v88 = getConnect(character9.ChildAdded:Connect(f34))
      task.wait(0.5)
      f35()
    end

    if localPlayer.Character then
      f37(localPlayer.Character)
    end

    v89 = getConnect(localPlayer.CharacterAdded:Connect(f37))
  else
    if v87 then
      v87:Disconnect()
      v87 = nil
    end

    if v88 then
      v88:Disconnect()
      v88 = nil
    end

    if v89 then
      v89:Disconnect()
      v89 = nil
    end

    for key14, value28 in pairs(map8) do
      if key14 and key14.Parent then
        for key15, value29 in pairs(value28) do
          if key15 and key15.Parent then
            pcall(function()
              key15.Color = value29.Color
              key15.Material = value29.Material
              key15.Transparency = value29.Transparency

              if value29.TextureID then
                key15.TextureID = value29.TextureID
              end

              for _, value30 in ipairs({ "FFParticlePoints", "ForcefieldParticles" }) do
                local findFirstChild3 = key15:FindFirstChild(value30)

                if findFirstChild3 then
                  findFirstChild3:Destroy()
                end
              end
            end)
          end
        end
      end
    end

    map8 = {}
  end
end

function f35()
  local backpack4 = localPlayer:FindFirstChildOfClass("Backpack")

  if backpack4 then
    for _, value31 in ipairs(backpack4:GetChildren()) do
      f34(value31)
    end
  end

  local character10 = localPlayer.Character

  if character10 then
    for _, value32 in ipairs(character10:GetChildren()) do
      f34(value32)
    end
  end
end

map4 = {}

local function makeHighlight()
  for _, value33 in ipairs(players:GetPlayers()) do
    local character11 = value33.Character

    local head5 = character11
    head5 = character11 and character11:FindFirstChild("Head")

    if head5 and f29(value33) and (v3.F_ESP or v3.F_Names) then
      local v90 = map4[value33]

      if not v90 then
        v90 = {}
        map4[value33] = v90
      end

      if v3.F_ESP then
        if not v90.hl then
          v90.hl = Instance.new("Highlight")
          v90.hl.FillTransparency = 0.6
          v90.hl.OutlineColor = Color3.new(1, 1, 1)
          v90.hl.Parent = parent3
        end

        if v90.hl.Adornee ~= character11 then
          v90.hl.Adornee = character11
        end

        v90.hl.FillColor = value33.TeamColor.Color
      elseif v90.hl then
        v90.hl:Destroy()
        v90.hl = nil
      end

      if v3.F_Names then
        if not v90.bb then
          v90.bb = Instance.new("BillboardGui")
          v90.bb.Size = UDim2.fromOffset(140, 20)
          v90.bb.StudsOffset = Vector3.new(0, 2.4, 0)
          v90.bb.AlwaysOnTop = true
          v90.bb.Parent = parent3

          f3({
            Parent = v90.bb,
            Text = value33.DisplayName,
            Font = v2.FontBold,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextStrokeTransparency = 0.4,
            Size = UDim2.fromScale(1, 1),
          })
        end

        if v90.bb.Adornee ~= head5 then
          v90.bb.Adornee = head5
        end
      elseif v90.bb then
        v90.bb:Destroy()
        v90.bb = nil
      end
    else
      f9(value33)
    end
  end

  for key16 in pairs(map4) do
    if not key16.Parent then
      f9(key16)
    end
  end
end

local v91 = 0
map3 = {}

local function f38()
  local backpack5 = localPlayer:FindFirstChildOfClass("Backpack")

  if backpack5 then
    for _, value34 in ipairs(backpack5:GetChildren()) do
      makePointLight(value34)
    end
  end

  local character12 = localPlayer.Character

  if character12 then
    for _, value35 in ipairs(character12:GetChildren()) do
      makePointLight(value35)
    end
  end
end

local map9 = {}
local currentCamera4 = workspaceService.CurrentCamera

local function makePointLight2(instance10)
  if not instance10 then
    return
  end

  for _, value36 in ipairs(instance10:GetDescendants()) do
    if value36.Name == "RayPart" and value36:IsA("BasePart") then
      map9[value36] = { Color = value36.Color, Material = value36.Material }
      value36.Material = Enum.Material.Neon

      if not value36:FindFirstChild("RGBTracerLight") then
        local rgbTracerLight = Instance.new("PointLight")
        rgbTracerLight.Name = "RGBTracerLight"
        rgbTracerLight.Brightness = 2
        rgbTracerLight.Range = 12
        rgbTracerLight.Shadows = false
        rgbTracerLight.Parent = value36
      end
    end
  end
end

local function makePointLight3(currentCamera5)
  map9 = {}
  makePointLight2(currentCamera5)

  getConnect(currentCamera5.DescendantAdded:Connect(function(descendant3)
    if descendant3.Name == "RayPart" and descendant3:IsA("BasePart") then
      map9[descendant3] = { Color = descendant3.Color, Material = descendant3.Material }
      descendant3.Material = Enum.Material.Neon

      if not descendant3:FindFirstChild("RGBTracerLight") then
        local rgbTracerLight2 = Instance.new("PointLight")
        rgbTracerLight2.Name = "RGBTracerLight"
        rgbTracerLight2.Brightness = 2
        rgbTracerLight2.Range = 12
        rgbTracerLight2.Shadows = false
        rgbTracerLight2.Parent = descendant3
      end
    end
  end))
end

getConnect(workspaceService:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
  currentCamera4 = workspaceService.CurrentCamera

  if currentCamera4 then
    makePointLight3(currentCamera4)
  end
end))

if currentCamera4 then
  makePointLight3(currentCamera4)
end

local list7 = {}

local function makeFolder4(child)
  if not child:IsA("Tool") then
    return
  end

  for _, value37 in ipairs(child:GetDescendants()) do
    if value37:IsA("BasePart") and value37.Transparency < 1
      and not value37:FindFirstChild("RainbowSmokePoints") then
      local rainbowSmokePoints = Instance.new("Folder")
      rainbowSmokePoints.Name = "RainbowSmokePoints"
      rainbowSmokePoints.Parent = value37

      for _, value38 in ipairs({
        Vector3.new(-0.3, -0.3, 0), Vector3.new(-0.3, 0, 0), Vector3.new(-0.3, 0.3, 0),
        Vector3.new(0, -0.3, 0), Vector3.new(0, 0, 0), Vector3.new(0, 0.3, 0),
        Vector3.new(0.3, -0.3, 0), Vector3.new(0.3, 0, 0), Vector3.new(0.3, 0.3, 0),
      }) do
        local rainbowSmokeAtt = Instance.new("Attachment")
        rainbowSmokeAtt.Name = "RainbowSmokeAtt"

        rainbowSmokeAtt.Position = Vector3.new(
          value38.X * value37.Size.X, value38.Y * value37.Size.Y, value38.Z * value37.Size.Z
        )

        rainbowSmokeAtt.Parent = rainbowSmokePoints

        local rainbowSmoke = Instance.new("ParticleEmitter")
        rainbowSmoke.Name = "RainbowSmoke"
        rainbowSmoke.Texture = "rbxasset://textures/particles/smoke_main.dds"
        rainbowSmoke.Rate = 3
        rainbowSmoke.Lifetime = NumberRange.new(1.2, 1.8)
        rainbowSmoke.Speed = NumberRange.new(0.05, 0.2)
        rainbowSmoke.LockedToPart = true
        rainbowSmoke.SpreadAngle = Vector2.new(180, 180)

        rainbowSmoke.Size = NumberSequence.new({
          NumberSequenceKeypoint.new(0, 0.7), NumberSequenceKeypoint.new(1, 1.1),
        })

        rainbowSmoke.Transparency = NumberSequence.new({
          NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1),
        })

        rainbowSmoke.Drag = 1
        rainbowSmoke.LightEmission = 0.5
        rainbowSmoke.Parent = rainbowSmokeAtt

        table.insert(list7, {
          Emitter = rainbowSmoke,
          Attachment = rainbowSmokeAtt,
          Folder = rainbowSmokePoints,
        })
      end
    end
  end
end

local function f39(character13)
  for _, value39 in ipairs(character13:GetChildren()) do
    if value39:IsA("Tool") then
      makeFolder4(value39)
    end
  end

  local backpack6 = localPlayer:FindFirstChildOfClass("Backpack")

  if backpack6 then
    for _, value40 in ipairs(backpack6:GetChildren()) do
      if value40:IsA("Tool") then
        makeFolder4(value40)
      end
    end
  end
end

local v92, v93, v94, f40

local function f41(p63)
  if p63 then
    map3 = {}
    f38()
    f40()

    local backpack7 = localPlayer:FindFirstChildOfClass("Backpack")
      or localPlayer:WaitForChild("Backpack", 2)

    if backpack7 then
      v92 = getConnect(backpack7.ChildAdded:Connect(makePointLight))
    end

    local function f42(character14)
      v93 = getConnect(character14.ChildAdded:Connect(makePointLight))
      task.wait(0.5)
      f38()
    end

    if localPlayer.Character then
      f42(localPlayer.Character)
    end

    v94 = getConnect(localPlayer.CharacterAdded:Connect(f42))
  else
    if v92 then
      v92:Disconnect()
      v92 = nil
    end

    if v93 then
      v93:Disconnect()
      v93 = nil
    end

    if v94 then
      v94:Disconnect()
      v94 = nil
    end

    for key17, value41 in pairs(map3) do
      if key17 and key17.Parent then
        for key18, value42 in pairs(value41) do
          if key18 and key18.Parent then
            pcall(function()
              key18.Color = value42.Color
              key18.Material = value42.Material

              if value42.TextureID then
                key18.TextureID = value42.TextureID
              end

              local rgbWeaponLight3 = key18:FindFirstChild("RGBWeaponLight")

              if rgbWeaponLight3 then
                rgbWeaponLight3:Destroy()
              end
            end)
          end
        end
      end
    end

    map3 = {}
  end
end

local function f43(p64)
  if p64 then
    list7 = {}
    f40()

    if localPlayer.Character then
      f39(localPlayer.Character)
    end

    getConnect(localPlayer.CharacterAdded:Connect(function(character15)
      task.wait(1)

      if v3.F_GunParticles then
        f39(character15)
      end
    end))

    local backpack8 = localPlayer:FindFirstChildOfClass("Backpack")
      or localPlayer:WaitForChild("Backpack", 2)

    if backpack8 then
      getConnect(backpack8.ChildAdded:Connect(function(child2)
        if child2:IsA("Tool") and v3.F_GunParticles then
          task.wait(0.4)
          makeFolder4(child2)
        end
      end))
    end
  else
    for _, value43 in ipairs(list7) do
      if value43.Emitter and value43.Emitter.Parent then
        value43.Emitter:Destroy()
      end

      if value43.Attachment and value43.Attachment.Parent then
        value43.Attachment:Destroy()
      end

      if value43.Folder and value43.Folder.Parent then
        value43.Folder:Destroy()
      end
    end

    list7 = {}

    local function f44(instance11)
      for _, value44 in ipairs(instance11:GetDescendants()) do
        if value44.Name == "RainbowSmokePoints" or value44.Name == "RainbowSmoke"
          or value44.Name == "RainbowSmokeAtt" then
          value44:Destroy()
        end
      end
    end

    if localPlayer.Character then
      f44(localPlayer.Character)
    end

    local backpack9 = localPlayer:FindFirstChildOfClass("Backpack")

    if backpack9 then
      f44(backpack9)
    end
  end
end

local function f45(p65)
  if p65 then
    f40()
  else
    for key19, value45 in pairs(map9) do
      if key19 and key19.Parent then
        pcall(function()
          key19.Color = value45.Color
          key19.Material = value45.Material

          local rgbTracerLight3 = key19:FindFirstChild("RGBTracerLight")

          if rgbTracerLight3 then
            rgbTracerLight3:Destroy()
          end
        end)
      end
    end

    map9 = {}
  end
end

local v95

function f40()
  if v95 then
    return
  end

  v95 = getConnect(runService.RenderStepped:Connect(function(delta2)
    if not v3.F_RainbowGuns and not v3.F_RainbowBullets and not v3.F_GunParticles then
      return
    end

    v91 = (v91 + delta2 * 0.5) % 1
    local color2 = Color3.fromHSV(v91, 1, 1)

    if v3.F_RainbowGuns then
      f38()

      for key20, value46 in pairs(map3) do
        if not key20:IsDescendantOf(game) then
          map3[key20] = nil
        else
          for key21 in pairs(value46) do
            if key21 and key21.Parent and key21:IsDescendantOf(key20) then
              key21.Color = color2
              key21.Material = Enum.Material.Neon

              local rgbWeaponLight4 = key21:FindFirstChild("RGBWeaponLight")

              if rgbWeaponLight4 then
                rgbWeaponLight4.Color = color2
              end
            end
          end
        end
      end
    end

    if v3.F_RainbowBullets then
      for key22, _ in pairs(map9) do
        if key22 and key22.Parent then
          key22.Color = color2
          key22.Material = Enum.Material.Neon

          local rgbTracerLight4 = key22:FindFirstChild("RGBTracerLight")

          if rgbTracerLight4 then
            rgbTracerLight4.Color = color2
          end
        else
          map9[key22] = nil
        end
      end
    end

    if v3.F_GunParticles then
      for i9 = #list7, 1, -1 do
        local v96 = list7[i9]

        if v96 and v96.Emitter and v96.Emitter.Parent then
          v96.Emitter.Color = ColorSequence.new(color2)
        else
          table.remove(list7, i9)
        end
      end
    end
  end))
end

local function f46()
  if v3.F_Fullbright then
    lighting.Brightness = 2
    lighting.ClockTime = 14
    lighting.GlobalShadows = false

    local color3 = Color3.fromRGB(178, 178, 178)
    local color4 = Color3.fromRGB(178, 178, 178)

    lighting.Ambient = color3
    lighting.OutdoorAmbient = color4
  end

  if v3.F_NoFog then
    lighting.FogEnd = 1000000
  end
end

local function f47()
  for key23, value47 in pairs({
    Brightness = v76.Brightness,
    ClockTime = v76.ClockTime,
    GlobalShadows = v76.GlobalShadows,
    Ambient = v76.Ambient,
    OutdoorAmbient = v76.OutdoorAmbient,
    FogEnd = v76.FogEnd,
  }) do
    lighting[key23] = value47
  end
end

local function f48(character16)
  if not v3.F_Headless then
    return
  end

  local head6 = character16:FindFirstChild("Head")

  if head6 then
    head6.Transparency = 1

    for _, value48 in ipairs(head6:GetChildren()) do
      if value48:IsA("Decal") then
        value48.Transparency = 1
      end
    end
  end
end

local function f49()
  local humanoidRootPart4 = getHumanoidRootPart()

  if humanoidRootPart4 then
    humanoidRootPart4.CFrame = CFrame.new(-935.5, 93.1, 2058.8)

    f10({
      Title = "Auto Escape",
      Text = "Teleported outside prison walls!",
      Style = "success",
      Duration = 3,
    })
  end
end

local v97

local function f50(p66)
  if p66 then
    if localPlayer.Character then
      f48(localPlayer.Character)
    end

    v97 = getConnect(localPlayer.CharacterAdded:Connect(function(character17)
      task.wait(0.5)

      if v3.F_Headless then
        f48(character17)
      end
    end))
  else
    if v97 then
      v97:Disconnect()
      v97 = nil
    end

    local character18 = localPlayer.Character

    if character18 then
      local head7 = character18:FindFirstChild("Head")

      if head7 then
        head7.Transparency = 0

        for _, value49 in ipairs(head7:GetChildren()) do
          if value49:IsA("Decal") then
            value49.Transparency = 0
          end
        end
      end
    end
  end
end

local function f51()
  local humanoidRootPart5 = getHumanoidRootPart()

  if not humanoidRootPart5 then
    return
  end

  local list8 = {
    Vector3.new(812.49, 101.82, 2229.86), Vector3.new(820.84, 101.86, 2229.55),
    Vector3.new(-932.47, 95.31, 2039.76), Vector3.new(-939.2, 95.37, 2039.16),
  }

  task.spawn(function()
    local cframe2 = humanoidRootPart5.CFrame
    v3.F_Noclip = false

    for _, value50 in ipairs(list8) do
      humanoidRootPart5.CFrame = CFrame.new(value50)
      task.wait(0.5)
    end

    humanoidRootPart5.CFrame = cframe2

    f10({
      Title = "Prison Life",
      Text = "All guns collected successfully!",
      Style = "success",
      Duration = 3,
    })
  end)
end

local instance12
local v98, f52

local function f53(p67)
  if p67 then
    if localPlayer.Character then
      f52(localPlayer.Character)
    end

    v98 = getConnect(localPlayer.CharacterAdded:Connect(function(character19)
      task.wait(0.6)

      if v3.F_Korblox then
        f52(character19)
      end
    end))
  else
    if v98 then
      v98:Disconnect()
      v98 = nil
    end

    if instance12 and instance12.Parent then
      instance12:Destroy()
      instance12 = nil
    end

    local character20 = localPlayer.Character

    if character20 then
      for _, value51 in ipairs({ "Right Leg", "RightUpperLeg", "RightLowerLeg", "RightFoot" }) do
        local findFirstChild4 = character20:FindFirstChild(value51)

        if findFirstChild4 and findFirstChild4:IsA("BasePart") then
          findFirstChild4.Transparency = 0
          findFirstChild4.CanCollide = true

          for _, value52 in ipairs(findFirstChild4:GetChildren()) do
            if value52:IsA("Decal") or value52:IsA("SpecialMesh") then
              value52.Transparency = 0
            end
          end
        end
      end
    end
  end
end

function f52(instance13)
  if not v3.F_Korblox then
    return
  end

  if instance12 and instance12.Parent then
    instance12:Destroy()
    instance12 = nil
  end

  for _, value53 in ipairs({ "Right Leg", "RightUpperLeg", "RightLowerLeg", "RightFoot" }) do
    local findFirstChild5 = instance13:FindFirstChild(value53)

    if findFirstChild5 and findFirstChild5:IsA("BasePart") then
      findFirstChild5.Transparency = 1
      findFirstChild5.CanCollide = false

      for _, value54 in ipairs(findFirstChild5:GetChildren()) do
        if value54:IsA("Decal") or value54:IsA("SpecialMesh") then
          value54.Transparency = 1
        end
      end
    end
  end

  local rightUpperLeg = instance13:FindFirstChild("RightUpperLeg")
    or instance13:FindFirstChild("Right Leg") or instance13:FindFirstChild("Torso")
    or instance13:FindFirstChild("UpperTorso")

  if rightUpperLeg then
    local jewWorksKorbloxLeg = Instance.new("MeshPart")
    jewWorksKorbloxLeg.Name = "JewWorksKorbloxLeg"
    jewWorksKorbloxLeg.MeshId = "rbxassetid://902942093"
    jewWorksKorbloxLeg.TextureID = ""
    jewWorksKorbloxLeg.Size = Vector3.new(1, 2, 1)
    jewWorksKorbloxLeg.Color = Color3.fromRGB(30, 30, 30)
    jewWorksKorbloxLeg.Material = Enum.Material.SmoothPlastic
    jewWorksKorbloxLeg.CanCollide = false
    jewWorksKorbloxLeg.Massless = true

    local weld = Instance.new("Weld")
    weld.Part0 = rightUpperLeg
    weld.Part1 = jewWorksKorbloxLeg
    weld.C0 = CFrame.new(0, 0.7, 0)
    weld.Parent = jewWorksKorbloxLeg

    jewWorksKorbloxLeg.CFrame = rightUpperLeg.CFrame * CFrame.new(0, 0.7, 0)
    jewWorksKorbloxLeg.Parent = instance13

    instance12 = jewWorksKorbloxLeg
  end
end

local v99 = 0
local v100 = 0
local v101 = 0

getConnect(runService.Heartbeat:Connect(function(delta3)
  local humanoid4 = getHumanoid()
  local humanoidRootPart6 = getHumanoidRootPart()

  if humanoid4 then
    if v3.F_WalkSpeed then
      humanoid4.WalkSpeed = v3.F_WalkSpeedVal
    end

    if v3.F_JumpPower then
      humanoid4.UseJumpPower = true
      humanoid4.JumpPower = v3.F_JumpPowerVal
    end
  end

  if v3.F_Fly and humanoidRootPart6 and humanoid4 then
    if not v77.bv or v77.bv.Parent ~= humanoidRootPart6 then
      makeBodyVelocity()
    end

    local currentCamera6 = workspaceService.CurrentCamera
    local zero = Vector3.zero

    if not userInputService:GetFocusedTextBox() then
      local function getIsKeyDown(p68)
        return userInputService:IsKeyDown(p68)
      end

      if getIsKeyDown(Enum.KeyCode.W) then
        zero = zero + currentCamera6.CFrame.LookVector
      end

      if getIsKeyDown(Enum.KeyCode.S) then
        zero = zero - currentCamera6.CFrame.LookVector
      end

      if getIsKeyDown(Enum.KeyCode.D) then
        zero = zero + currentCamera6.CFrame.RightVector
      end

      if getIsKeyDown(Enum.KeyCode.A) then
        zero = zero - currentCamera6.CFrame.RightVector
      end

      if getIsKeyDown(Enum.KeyCode.Space) then
        zero = zero + Vector3.yAxis
      end

      if getIsKeyDown(Enum.KeyCode.LeftShift) or getIsKeyDown(Enum.KeyCode.LeftControl) then
        zero = zero - Vector3.yAxis
      end
    end

    if zero.Magnitude == 0 and humanoid4.MoveDirection.Magnitude > 0 then
      zero = humanoid4.MoveDirection
    end

    if v77.bv then
      v77.bv.Velocity = zero.Magnitude > 0 and zero.Unit * v3.F_FlySpeed or Vector3.zero
    end

    if v77.bg then
      v77.bg.CFrame = currentCamera6.CFrame
    end
  end

  if v3.F_Gravity then
    workspaceService.Gravity = v3.F_GravityVal
  end

  if v3.F_FOV and workspaceService.CurrentCamera then
    workspaceService.CurrentCamera.FieldOfView = v3.F_FOVVal
  end

  f46()
  v100 = v100 + delta3

  if v100 >= 0.15 then
    v100 = 0
    makePart()
  end

  v101 = v101 + delta3

  if v101 >= 1 then
    v101 = 0
    makeFolder2(true)
    makeBillboardGui()
  end

  v99 = v99 + delta3

  if v99 >= 0.2 then
    v99 = 0
    makeHighlight()
  end
end))

getConnect(runService.Stepped:Connect(function()
  if v3.F_Noclip then
    local humanoidRootPart7 = getHumanoidRootPart()
    local humanoid5 = getHumanoid()

    if humanoidRootPart7 and humanoid5 and humanoid5.MoveDirection.Magnitude > 0 then
      local raycastParams2 = RaycastParams.new()
      raycastParams2.FilterType = Enum.RaycastFilterType.Exclude
      raycastParams2.FilterDescendantsInstances = { localPlayer.Character }

      if workspaceService:Raycast(
        humanoidRootPart7.Position, humanoid5.MoveDirection * 4, raycastParams2
      ) then
        humanoidRootPart7.CFrame = humanoidRootPart7.CFrame + humanoid5.MoveDirection * 3.5
      end
    end
  end
end))

getConnect(userInputService.JumpRequest:Connect(function()
  if v3.F_InfJump then
    local humanoid6 = getHumanoid()

    if humanoid6 then
      humanoid6:ChangeState(Enum.HumanoidStateType.Jumping)
    end
  end
end))

pcall(function()
  getConnect(localPlayer.Idled:Connect(function()
    if v3.F_AntiAFK then
      virtualUser:CaptureController()
      virtualUser:ClickButton2(Vector2.new())
    end
  end))
end)

getConnect(players.PlayerRemoving:Connect(function(player2)
  f9(player2)

  if map6[player2] then
    map6[player2]:Destroy()
    map6[player2] = nil
  end
end))

function v75.cleanup()
  local fWalkSpeed = v3.F_WalkSpeed
  local fJumpPower = v3.F_JumpPower
  local fGravity = v3.F_Gravity
  local fFOV = v3.F_FOV
  local fZoom = v3.F_Zoom

  for _, value55 in ipairs({
    "F_Fly", "F_Noclip", "F_WalkSpeed", "F_JumpPower", "F_InfJump", "F_Hitbox", "F_ESP",
    "F_Names", "F_Fullbright", "F_NoFog", "F_Gravity", "F_FOV", "F_Zoom", "F_AntiAFK",
    "F_Crosshair", "F_RainbowGuns", "F_RainbowBullets", "F_GunParticles", "F_Headless",
    "F_Korblox", "F_Aimlock", "F_ForcefieldGun",
  }) do
    v3[value55] = false
  end

  f27()
  f30()
  makeImageLabel(false)
  f41(false)
  f45(false)
  f43(false)
  f36(false)
  f50(false)
  f53(false)
  f33(false)
  makeFolder2(false)
  circle:Remove()
  text3:Remove()

  if v95 then
    v95:Disconnect()
    v95 = nil
  end

  for key24 in pairs(map4) do
    f9(key24)
  end

  for _, value56 in pairs(map6) do
    value56:Destroy()
  end

  map6 = {}
  f47()
  local humanoid7 = getHumanoid()

  if humanoid7 then
    if fWalkSpeed then
      humanoid7.WalkSpeed = 16
    end

    if fJumpPower then
      humanoid7.JumpPower = 50
    end
  end

  if fGravity then
    workspaceService.Gravity = v76.Gravity
  end

  if fFOV and workspaceService.CurrentCamera then
    workspaceService.CurrentCamera.FieldOfView = 70
  end

  if fZoom then
    localPlayer.CameraMaxZoomDistance = v76.Zoom
  end

  local humanoidRootPart8 = getHumanoidRootPart()

  if humanoidRootPart8 then
    humanoidRootPart8.CanCollide = true
  end
end

local list9 = {}
local list10 = { "Movement", "Player", "Combat", "Prison", "Settings", "Search" }
local f54

local function f55()
  local list11 = {}
  local flag7 = false

  local parent30 = f1("Frame", {
    Name = "Root",
    Parent = parent3,
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 1),
    Visible = false,
  })

  local v102 = f1("Frame", {
    Parent = parent30,
    BackgroundColor3 = Color3.new(0, 0, 0),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.fromScale(1, 1),
  })

  local create3 = tweenService:Create(f1("UIGradient", {
    Parent = f1("Frame", {
      Parent = parent30,
      BackgroundColor3 = Color3.new(1, 1, 1),
      BorderSizePixel = 0,
      Size = UDim2.fromScale(1, 1),
    }),
    Transparency = NumberSequence.new({
      NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.97),
      NumberSequenceKeypoint.new(1, 1),
    }),
  }), TweenInfo.new(
    28, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1
  ), { Rotation = 360 })

  create3:Play()

  table.insert(list11, create3)
  f25(parent30, 16, list11)

  local v103 = f1("Frame", {
    Name = "Stage",
    Parent = parent30,
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 1),
  })

  local parent31 = f1("Frame", {
    Parent = parent3,
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -8, 0, 8),
    Size = UDim2.fromOffset(0, 28),
    AutomaticSize = Enum.AutomaticSize.X,
    BackgroundColor3 = Color3.new(0, 0, 0),
    BackgroundTransparency = 0.35,
    BorderSizePixel = 0,
    ZIndex = 100,
  }, {
    f2(v2.Border), f4(10, 0, 4, 0),
    f1("UIListLayout", {
      FillDirection = Enum.FillDirection.Horizontal,
      VerticalAlignment = Enum.VerticalAlignment.Center,
      Padding = UDim.new(0, 8),
      SortOrder = Enum.SortOrder.LayoutOrder,
    }),
  })

  local create4 = tweenService:Create(f1("Frame", {
    Parent = parent31,
    LayoutOrder = 1,
    Size = UDim2.fromOffset(6, 6),
    BackgroundColor3 = v2.Accent,
    BorderSizePixel = 0,
  }, { f5(3) }), TweenInfo.new(
    1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true
  ), { BackgroundTransparency = 0.8 })

  create4:Play()

  table.insert(list11, create4)

  local v104 = f3({
    Parent = parent31,
    LayoutOrder = 2,
    RichText = true,
    TextSize = 12,
    TextColor3 = v2.SubText,
    Text = "FPS 0   PING 0 ms",
    Size = UDim2.fromOffset(0, 28),
    AutomaticSize = Enum.AutomaticSize.X,
    ZIndex = 101,
  })

  local vector7 = Vector2.new(1, 0)
  local udim = UDim2.new(1, -8, 0, 42)
  local udim2 = UDim2.fromOffset(0, 28)

  local parent32 = f1("Frame", {
    Parent = parent30,
    AnchorPoint = vector7,
    Position = udim,
    Size = udim2,
    AutomaticSize = Enum.AutomaticSize.X,
    BackgroundColor3 = Color3.new(0, 0, 0),
    BackgroundTransparency = 0.35,
    BorderSizePixel = 0,
    ZIndex = 100,
  }, {
    f2(v2.Border), f4(4, 0, 4, 0),
    f1("UIListLayout", {
      FillDirection = Enum.FillDirection.Horizontal,
      VerticalAlignment = Enum.VerticalAlignment.Center,
      Padding = UDim.new(0, 4),
      SortOrder = Enum.SortOrder.LayoutOrder,
    }),
  })

  local function f56(text4, layoutOrder2)
    local v105 = f1("TextButton", {
      Parent = parent32,
      LayoutOrder = layoutOrder2,
      BackgroundColor3 = v2.Hover,
      BackgroundTransparency = 1,
      AutoButtonColor = false,
      Text = text4,
      Font = v2.FontBold,
      TextSize = 16,
      TextColor3 = v2.SubText,
      Size = UDim2.fromOffset(24, 24),
      ZIndex = 101,
    }, { f5(6) })

    v105.MouseEnter:Connect(function()
      v4.to(v105, "bg", 0.12, { BackgroundTransparency = 0 })
      v4.to(v105, "c", 0.12, { TextColor3 = v2.Accent })
    end)

    v105.MouseLeave:Connect(function()
      v4.to(v105, "bg", 0.12, { BackgroundTransparency = 1 })
      v4.to(v105, "c", 0.12, { TextColor3 = v2.SubText })
    end)

    return v105
  end

  local v106 = f56("-", 1)
  local v107 = f56("×", 2)

  local function getRounded()
    local ok3, result2 = pcall(function()
      return statsService.Network.ServerStatsItem["Data Ping"]:GetValue()
    end)

    return ok3 and result2 and math.floor(result2 + 0.5) or 0
  end

  local v108 = 0
  local v109 = 0

  getConnect(runService.RenderStepped:Connect(function(delta4)
    v108 = v108 + 1
    v109 = v109 + delta4

    if v109 >= 0.5 then
      v104.Text = string.format(
        'FPS <font color="#FFFFFF">%d</font>   PING <font color="#FFFFFF">%d ms</font>',
        math.floor(v108 / v109 + 0.5), getRounded()
      )

      v108 = 0
      v109 = 0
    end
  end))

  local parent33 = f1("Frame", {
    Parent = parent3,
    AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.new(0, 14, 1, -14),
    Size = UDim2.fromOffset(0, 44),
    AutomaticSize = Enum.AutomaticSize.X,
    BackgroundTransparency = 1,
    ZIndex = 100,
  }, {
    f1("UIListLayout", {
      FillDirection = Enum.FillDirection.Horizontal,
      VerticalAlignment = Enum.VerticalAlignment.Center,
      Padding = UDim.new(0, 8),
      SortOrder = Enum.SortOrder.LayoutOrder,
    }),
  })

  local instance14 = f1("ImageLabel", {
    Parent = parent33,
    LayoutOrder = 1,
    BackgroundTransparency = 1,
    Size = UDim2.fromOffset(44, 44),
    Image = "",
    ScaleType = Enum.ScaleType.Fit,
    ZIndex = 101,
  })

  f3({
    Parent = parent33,
    LayoutOrder = 2,
    RichText = true,
    Font = v2.FontBold,
    TextSize = 26,
    TextStrokeTransparency = 0.6,
    Text = '<font color="rgb(60,130,255)">Jew</font><font color="rgb(255,255,255)">Works</font>',
    Size = UDim2.fromOffset(0, 44),
    AutomaticSize = Enum.AutomaticSize.X,
    ZIndex = 101,
  })

  task.spawn(function()
    local image
    instance14.Image = image or "rbxassetid://17844710236"
    task.wait(5)

    if instance14.Parent and not instance14.IsLoaded then
      instance14:Destroy()
      getParent(parent33, 36, 2, v2.Accent).LayoutOrder = 1
    end
  end)

  local function getClamped()
    local absoluteSize = parent3.AbsoluteSize
    local v110 = #list10
    local x5 = absoluteSize.X

    return math.clamp(
      math.min(v3.UIScale * 1.25, (x5 - 16) / (v110 * 210 + (v110 - 1) * 8)), 0.35, 2
    )
  end

  local function f57(p69, p70)
    p69.Frame.Position = UDim2.fromOffset(
      math.floor(p69.x + 0.5), math.floor(p69.y + (p70 or 0) + 0.5)
    )
  end

  local function f58()
    local clamped10 = getClamped()
    local absoluteSize2 = parent3.AbsoluteSize

    for index3, value57 in ipairs(list9) do
      value57.Scale.Scale = clamped10

      if not value57.moved then
        value57.x = 8 + (index3 - 1) * 218 * clamped10
        value57.y = 8
      end

      value57.x = math.clamp(value57.x, 0, math.max(0, absoluteSize2.X - 210 * clamped10))
      value57.y = math.clamp(value57.y, 0, math.max(0, absoluteSize2.Y - 30 * clamped10))

      f57(value57)
      value57.refresh(false)
    end
  end

  getConnect(parent3:GetPropertyChangedSignal("AbsoluteSize"):Connect(f58))

  for index4, value58 in ipairs(list10) do
    local v111 = f16(value58, v103)
    list9[index4] = v111

    v111.Header.InputBegan:Connect(function(input6)
      if input6.UserInputType == Enum.UserInputType.MouseButton2 then
        v111.toggleCollapse()
      end
    end)
  end

  f54(list9, { Notify = f10, applyScale = f58 })
  f58()

  local v112 = f1("TextButton", {
    Parent = parent3,
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.new(0.5, 0, 0, -40),
    Size = UDim2.fromOffset(132, 32),
    BackgroundColor3 = v2.Panel,
    AutoButtonColor = false,
    Text = "",
    Visible = false,
  }, { f5(16), f2(v2.BorderLit) })

  getParent(v112, 16, 1.2, v2.Accent).Position = UDim2.fromOffset(12, 8)

  f3({
    Parent = v112,
    Text = v2.Name,
    Font = v2.FontBold,
    TextSize = 13,
    Position = UDim2.fromOffset(36, 0),
    Size = UDim2.new(1, -44, 1, 0),
  })

  local function f59(p71)
    if p71 then
      v112.Visible = true
      v4.to(v112, "y", 0.35, { Position = UDim2.new(0.5, 0, 0, 10) })
    else
      v4.to(v112, "y", 0.2, { Position = UDim2.new(0.5, 0, 0, -40) })

      task.delay(v3.Animations and 0.2 or 0, function()
        if not flag7 then
          return
        end

        v112.Visible = false
      end)
    end
  end

  local v113 = {}

  function v113.show()
    if flag7 then
      return
    end

    flag7 = true
    f59(false)
    parent30.Visible = true
    f58()
    v102.BackgroundTransparency = 1
    v4.to(v102, "f", 0.3, { BackgroundTransparency = 0.55 })

    for index5, value59 in ipairs(list9) do
      f57(value59, -22)

      v4.to(value59.Frame, "in", 0.25 + index5 * 0.05, {
        Position = UDim2.fromOffset(math.floor(value59.x + 0.5), math.floor(value59.y + 0.5)),
      })
    end
  end

  function v113.hide(p72)
    if not flag7 then
      return
    end

    flag7 = false
    parent30.Visible = false

    if p72 then
      f59(true)
    end
  end

  function v113.close()
    v75.cleanup()
    v113.hide(false)

    task.delay(0.3, function()
      v18 = nil
      v55 = nil

      for _, value60 in ipairs(list11) do
        value60:Cancel()
      end

      for _, value61 in ipairs(list3) do
        value61:Disconnect()
      end

      table.clear(list3)
      parent3:Destroy()
    end)
  end

  v106.Activated:Connect(function() v113.hide(true) end)
  v107.Activated:Connect(v113.close)
  v112.Activated:Connect(v113.show)

  getConnect(userInputService.InputBegan:Connect(function(input7, p73)
    if v55 and input7.UserInputType == Enum.UserInputType.Keyboard then
      v55.onKey(input7.KeyCode)
      return
    end

    if p73 then
      return
    end

    if input7.KeyCode == v3.ToggleKey then
      if flag7 then
        v113.hide(false)
      else
        v113.show()
      end
    end
  end))

  return v113
end

local function f60()
  local v114 = f26()
  local v115 = f55()

  task.spawn(function()
    v114.run(function()
      v115.show()

      task.delay(0.6, function()
        f10({
          Title = "Welcome to " + v2.Name,
          Text = "Press " .. v3.ToggleKey.Name .. " to open/close the menu.",
          Style = "info",
          Duration = 4,
        })
      end)
    end)
  end)
end

function f54(p74, p75)
  local v116 = p74[1]

  v28.Toggle(v116, {
    Name = "Fly",
    Key = "F_Fly",
    Tooltip = "WASD to move, Space up, Shift / Ctrl down",
    Callback = function(value62)
      if not value62 then
        f27()
      end
    end,
  })

  v28.Slider(v116, {
    Name = "Fly speed",
    Min = 10,
    Max = 250,
    Default = 60,
    Increment = 5,
    Key = "F_FlySpeed",
  })

  v28.Toggle(v116, {
    Name = "Noclip",
    Key = "F_Noclip",
    Tooltip = "Walk into walls to phase right through them",
  })

  v28.Toggle(v116, {
    Name = "Walk speed",
    Key = "F_WalkSpeed",
    Callback = function(value63)
      local humanoid8 = getHumanoid()

      if humanoid8 and not value63 then
        humanoid8.WalkSpeed = 16
      end
    end,
  })

  v28.Slider(v116, {
    Name = "Speed value",
    Min = 16,
    Max = 150,
    Default = 32,
    Increment = 1,
    Key = "F_WalkSpeedVal",
  })

  v28.Toggle(v116, {
    Name = "Jump power",
    Key = "F_JumpPower",
    Callback = function(value64)
      local humanoid9 = getHumanoid()

      if humanoid9 and not value64 then
        humanoid9.JumpPower = 50
      end
    end,
  })

  v28.Slider(v116, {
    Name = "Jump value",
    Min = 50,
    Max = 250,
    Default = 100,
    Increment = 5,
    Key = "F_JumpPowerVal",
  })

  v28.Toggle(v116, { Name = "Infinite jump", Key = "F_InfJump" })

  local v117 = p74[2]

  v28.Toggle(v117, { Name = "Anti AFK", Key = "F_AntiAFK" })

  v28.Toggle(v117, {
    Name = "Fullbright",
    Key = "F_Fullbright",
    Callback = function(value65)
      if not value65 then
        f47()
      end
    end,
  })

  v28.Toggle(v117, {
    Name = "No fog",
    Key = "F_NoFog",
    Callback = function(value66)
      if not value66 then
        f47()
      end
    end,
  })

  v28.Toggle(v117, {
    Name = "Field of view",
    Key = "F_FOV",
    Callback = function(value67)
      if not value67 and workspaceService.CurrentCamera then
        workspaceService.CurrentCamera.FieldOfView = 70
      end
    end,
  })

  v28.Slider(v117, {
    Name = "FOV value",
    Min = 30,
    Max = 120,
    Default = 90,
    Increment = 1,
    Key = "F_FOVVal",
  })

  v28.Toggle(v117, {
    Name = "Headless",
    Key = "F_Headless",
    Tooltip = "Hides your character's head",
    Callback = function(value68) f50(value68) end,
  })

  v28.Toggle(v117, {
    Name = "Korblox",
    Key = "F_Korblox",
    Tooltip = "Forces Korblox deathspeaker right leg replacement",
    Callback = function(value69) f53(value69) end,
  })

  v28.Button(v117, {
    Name = "Rejoin server",
    Text = "Rejoin",
    Callback = function()
      pcall(function() teleportService:Teleport(game.PlaceId, localPlayer) end)
    end,
  })

  local v118 = p74[3]

  v28.Toggle(v118, {
    Name = "Aimlock",
    Key = "F_Aimlock",
    Tooltip = "Hold Right Mouse Button to lock onto targets inside FOV",
    Callback = function(value70) f33(value70) end,
  })

  v28.Slider(v118, {
    Name = "Aim smoothness",
    Min = 1,
    Max = 10,
    Default = 3,
    Increment = 0.5,
    Key = "F_AimSmoothing",
  })

  v28.Slider(v118, {
    Name = "Aim FOV size",
    Min = 30,
    Max = 400,
    Default = 120,
    Increment = 5,
    Key = "F_AimFOV",
  })

  v28.Toggle(v118, {
    Name = "Hitboxes",
    Key = "F_Hitbox",
    Description = "Only works with handcuffs",
    Tooltip = "Enlarges other players' hitboxes on your client continuously",
    Callback = function(value71)
      if not value71 then
        f30()
      end
    end,
  })

  v28.Slider(v118, {
    Name = "Hitbox size",
    Min = 2,
    Max = 30,
    Default = 12,
    Increment = 1,
    Key = "F_HitboxSize",
  })

  v28.Slider(v118, {
    Name = "Hitbox opacity",
    Min = 0,
    Max = 1,
    Default = 0.7,
    Increment = 0.05,
    Key = "F_HitboxTrans",
  })

  v28.Toggle(v118, {
    Name = "Team check",
    Key = "F_TeamCheck",
    Default = true,
    Tooltip = "Skip players on your team",
  })

  v28.Toggle(v118, { Name = "ESP", Key = "F_ESP", Callback = function() makeHighlight() end })

  v28.Toggle(v118, {
    Name = "Show names",
    Key = "F_Names",
    Callback = function() makeHighlight() end,
  })

  v28.Toggle(v118, {
    Name = "Crosshair changer",
    Key = "F_Crosshair",
    Tooltip = "Enables custom crosshair cursor",
    Callback = function(value72) makeImageLabel(value72) end,
  })

  v28.Toggle(v118, {
    Name = "Rainbow guns",
    Key = "F_RainbowGuns",
    Tooltip = "Wraps your weapons in synchronized neon RGB colors with glowing light emission",
    Callback = function(value73) f41(value73) end,
  })

  v28.Toggle(v118, {
    Name = "Rainbow bullets",
    Key = "F_RainbowBullets",
    Tooltip = "Colors camera raypart bullet tracers in synchronized neon RGB",
    Callback = function(value74) f45(value74) end,
  })

  v28.Toggle(v118, {
    Name = "Gun particles",
    Key = "F_GunParticles",
    Tooltip = "Emits synchronized rainbow smoke particles from your weapons",
    Callback = function(value75) f43(value75) end,
  })

  v28.Toggle(v118, {
    Name = "Forcefield gun",
    Key = "F_ForcefieldGun",
    Tooltip = "Applies ForceField material and sparkling particle effects to your weapons",
    Callback = function(value76) f36(value76) end,
  })

  local v119 = p74[4]

  v28.Heading(v119, "Prison Life", "Dedicated server tools and automated features.")
  v28.Section(v119, "JW Community")

  v79 = v28.Button(v119, {
    Name = "TP to other JW user",
    Text = "No JW Users",
    Disabled = true,
    Tooltip = "Teleports to another player running JewWorks in this server",
    Callback = f28,
  })

  v28.Section(v119, "Automation")

  v28.Button(v119, {
    Name = "Get all guns",
    Text = "Get Guns",
    Tooltip = "Teleports 1 stud above gun coordinates to fall onto the pad",
    Callback = f51,
  })

  v28.Button(v119, {
    Name = "Auto escape",
    Text = "Escape",
    Tooltip = "Teleports you out of cells / prison block",
    Callback = f49,
  })

  v28.Section(v119, "Team Switcher")

  v28.Button(v119, {
    Name = "Join Guards",
    Text = "Guards",
    Callback = function()
      pcall(function() workspaceService.Remote.TeamEvent:FireServer("Guards") end)
    end,
  })

  v28.Button(v119, {
    Name = "Join Inmates",
    Text = "Inmates",
    Callback = function()
      pcall(function() workspaceService.Remote.TeamEvent:FireServer("Inmates") end)
    end,
  })

  v28.Button(v119, {
    Name = "Join Criminals",
    Text = "Criminals",
    Callback = function()
      pcall(function() workspaceService.Remote.TeamEvent:FireServer("Criminal") end)
    end,
  })

  local v120 = p74[5]

  v28.Heading(v120, "Settings", "Tune interface appearance and options.")
  v28.Section(v120, "Interface")

  v28.Slider(v120, {
    Name = "UI scale",
    Min = 0.8,
    Max = 1.3,
    Default = 1,
    Increment = 0.05,
    Key = "UIScale",
    Callback = function() p75.applyScale() end,
  })

  v28.Toggle(v120, {
    Name = "Animations",
    Description = "Disable for instant transitions",
    Key = "Animations",
    Default = true,
  })

  v28.Toggle(v120, {
    Name = "Notifications",
    Description = "Show toast notifications",
    Key = "Notifications",
    Default = true,
  })

  v28.Toggle(v120, {
    Name = "Tooltips",
    Description = "Show hints on hover",
    Key = "Tooltips",
    Default = true,
  })

  v28.Section(v120, "Keybinds")
  v28.Keybind(v120, { Name = "Toggle interface", Key = "ToggleKey", Default = Enum.KeyCode.M })
  v28.Search(p74[6], "Search controls...", { p74[1], p74[2], p74[3], p74[4], p74[5] })
end

local parent34, instance15, uiStroke6, v121

if v1 then
  parent34 = f1("ScreenGui", {
    Name = "JewWorksDiscordPrompt",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 2000,
    Parent = parent,
  })

  f1("Frame", {
    Parent = parent34,
    BackgroundColor3 = Color3.new(0, 0, 0),
    BackgroundTransparency = 0.4,
    BorderSizePixel = 0,
    Size = UDim2.fromScale(1, 1),
  })

  local parent35 = f1("Frame", {
    Parent = parent34,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(360, 190),
    BackgroundColor3 = Color3.fromRGB(12, 12, 12),
  }, { f5(10), f2(v2.BorderLit) })

  f3({
    Parent = parent35,
    Text = "join the discord for more premium scripts!!",
    Font = v2.FontBold,
    TextSize = 13,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Center,
    Position = UDim2.fromOffset(20, 24),
    Size = UDim2.new(1, -40, 0, 40),
  })

  f1("TextBox", {
    Parent = parent35,
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.new(0.5, 0, 0, 74),
    Size = UDim2.fromOffset(310, 32),
    BackgroundColor3 = v2.Raised,
    TextColor3 = v2.SubText,
    Font = v2.Font,
    TextSize = 12,
    Text = "https://discord.gg/pAfq65sShf",
    ClearTextOnFocus = false,
    TextEditable = false,
    TextXAlignment = Enum.TextXAlignment.Center,
  }, { f5(6), f2(v2.Border) })

  instance15 = f1("TextButton", {
    Parent = parent35,
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.new(0.5, 0, 0, 122),
    Size = UDim2.fromOffset(310, 36),
    BackgroundColor3 = v2.Raised,
    AutoButtonColor = false,
    Text = "Copy Invite",
    Font = v2.FontBold,
    TextSize = 13,
    TextColor3 = v2.Text,
  }, { f5(6), f2(v2.Border) })

  uiStroke6 = instance15:FindFirstChildOfClass("UIStroke")
  v121 = false

  instance15.Activated:Connect(function()
    if v121 then
      return
    end

    v121 = true

    pcall(function()
      if setclipboard then
        setclipboard("https://discord.gg/pAfq65sShf")
      end
    end)

    v4.to(instance15, "bg", 0.15, {
      BackgroundColor3 = Color3.fromRGB(40, 180, 80),
      TextColor3 = Color3.new(1, 1, 1),
    })

    v4.to(uiStroke6, "c", 0.15, { Color = Color3.fromRGB(80, 220, 120) })

    instance15.Text = "Copied!"
    task.wait(0.8)
    parent34:Destroy()
    f60()
  end)
else
  f60()
end
