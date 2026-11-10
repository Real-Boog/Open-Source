-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf

local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local workspaceService = game:GetService("Workspace")
local httpService = game:GetService("HttpService")
local coreGui = game:GetService("CoreGui")
local localPlayer = players.LocalPlayer
local currentCamera = workspaceService.CurrentCamera
local color = Color3.fromRGB(200, 32, 52)
local color2 = Color3.fromRGB(255, 255, 255)
local color3 = Color3.fromRGB(70, 160, 100)
local color4 = Color3.fromRGB(140, 140, 150)
local color5 = Color3.fromRGB(58, 58, 66)
local color6 = Color3.fromRGB(22, 22, 26)
local font = Enum.Font

if getgenv().ScriptWorksJailbirdLoaded then
  pcall(getgenv().ScriptWorksJailbirdLoaded)
end

pcall(function()
  if isfolder and not isfolder("MeteorConfigs") and makefolder then
    makefolder("MeteorConfigs")
  end
end)

local aimSettings = {
  Enabled = false,
  ToggleMode = false,
  AimKey = Enum.UserInputType.MouseButton2,
  BodyPart = "Head",
  Radius = 150,
  Smoothness = 2,
  TeamCheck = false,
  WallCheck = false,
}

local v1 = {
  WalkSpeedEnabled = false,
  WalkSpeedValue = 16,
  WalkSpeedKey = Enum.KeyCode.V,
  FlyEnabled = false,
  FlyKey = Enum.KeyCode.F,
  NoclipEnabled = false,
  NoclipKey = Enum.KeyCode.N,
}

local esp = {
  Enabled = false,
  Box = true,
  Tracer = true,
  Name = true,
  Skeleton = true,
  TeamCheck = false,
  _cache = {},
}

local v2 = {
  { "Head", "Torso" }, { "Torso", "Left Arm" }, { "Torso", "Right Arm" },
  { "Torso", "Left Leg" }, { "Torso", "Right Leg" },
}

local v3 = {
  { "Head", "UpperTorso" }, { "UpperTorso", "LowerTorso" }, { "UpperTorso", "LeftUpperArm" },
  { "LeftUpperArm", "LeftLowerArm" }, { "LeftLowerArm", "LeftHand" },
  { "UpperTorso", "RightUpperArm" }, { "RightUpperArm", "RightLowerArm" },
  { "RightLowerArm", "RightHand" }, { "LowerTorso", "LeftUpperLeg" },
  { "LeftUpperLeg", "LeftLowerLeg" }, { "LeftLowerLeg", "LeftFoot" },
  { "LowerTorso", "RightUpperLeg" }, { "RightUpperLeg", "RightLowerLeg" },
  { "RightLowerLeg", "RightFoot" },
}

local bodyVelocity
local bodyGyro

local function f1()
  if bodyGyro then
    pcall(function() bodyGyro:Destroy() end)
    bodyGyro = nil
  end

  if bodyVelocity then
    pcall(function() bodyVelocity:Destroy() end)
    bodyVelocity = nil
  end

  pcall(function()
    local character = localPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    if humanoid then
      humanoid.PlatformStand = false
    end
  end)
end

local function f2(p1, map)
  local ok, result = pcall(function()
    local drawing = Drawing.new(p1)

    for key, value in pairs(map) do
      drawing[key] = value
    end

    return drawing
  end)

  return ok and result or nil
end

function esp:AddPlayer(key2)
  if not key2 or key2 == localPlayer or self._cache[key2] then
    return
  end

  local v4 = {
    Box = f2("Square", { Thickness = 1.5, Filled = false, Visible = false }),
    Tracer = f2("Line", { Thickness = 1.5, Visible = false }),
    Name = f2("Text", {
      Size = 13,
      Center = true,
      Outline = true,
      Visible = false,
    }),
    Skeleton = {},
  }

  for i = 1, 15 do
    v4.Skeleton[i] = f2("Line", { Thickness = 1.5, Visible = false })
  end

  self._cache[key2] = v4
end

function esp:RemovePlayer(key3)
  local v5 = self._cache[key3]

  if not v5 then
    return
  end

  pcall(function()
    if v5.Box then
      v5.Box:Remove()
    end
  end)

  pcall(function()
    if v5.Tracer then
      v5.Tracer:Remove()
    end
  end)

  pcall(function()
    if v5.Name then
      v5.Name:Remove()
    end
  end)

  if v5.Skeleton then
    for _, value2 in ipairs(v5.Skeleton) do
      pcall(function()
        if value2 then
          value2:Remove()
        end
      end)
    end
  end

  self._cache[key3] = nil
end

function esp:Hide(p2)
  if not p2 then
    return
  end

  pcall(function()
    if p2.Box then
      p2.Box.Visible = false
    end

    if p2.Tracer then
      p2.Tracer.Visible = false
    end

    if p2.Name then
      p2.Name.Visible = false
    end

    if p2.Skeleton then
      for _, value3 in ipairs(p2.Skeleton) do
        if value3 then
          value3.Visible = false
        end
      end
    end
  end)
end

function esp:Update(color7)
  if not currentCamera or not currentCamera.Parent then
    currentCamera = workspaceService.CurrentCamera

    if not currentCamera then
      return
    end
  end

  for key4, value4 in pairs(self._cache) do
    if not key4 or not key4.Parent then
      self:RemovePlayer(key4)
    else
      local character2 = key4.Character
      local humanoidRootPart = character2 and character2:FindFirstChild("HumanoidRootPart")
      local humanoid2 = character2 and character2:FindFirstChildOfClass("Humanoid")

      if not (self.Enabled and character2 and humanoidRootPart and humanoid2 and humanoid2.Health > 0) then
        self:Hide(value4)
      elseif self.TeamCheck and key4.Team and localPlayer.Team
        and key4.Team == localPlayer.Team then
        self:Hide(value4)
      else
        local screenPoint, onScreen = currentCamera:WorldToViewportPoint(humanoidRootPart.Position)

        if not onScreen or screenPoint.Z <= 0 then
          self:Hide(value4)
        else
          local head = character2:FindFirstChild("Head")

          local v6 = head and head.Position + Vector3.new(0, 1.2, 0)
            or humanoidRootPart.Position + Vector3.new(0, 3, 0)

          local position = humanoidRootPart.Position
          local vector = Vector3.new(0, 3.2, 0)
          local worldToViewportPoint = currentCamera:WorldToViewportPoint(v6)
          local worldToViewportPoint2 = currentCamera:WorldToViewportPoint(position - vector)
          local distance = math.abs(worldToViewportPoint.Y - worldToViewportPoint2.Y)
          local v7 = distance * 0.65
          local vector2 = Vector2.new(worldToViewportPoint.X - v7 / 2, worldToViewportPoint.Y)

          if self.Box and value4.Box then
            value4.Box.Size = Vector2.new(v7, distance)
            value4.Box.Position = vector2
            value4.Box.Color = color7
            value4.Box.Visible = true
          elseif value4.Box then
            value4.Box.Visible = false
          end

          if self.Tracer and value4.Tracer then
            value4.Tracer.From = Vector2.new(
              currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y
            )

            value4.Tracer.To = Vector2.new(screenPoint.X, screenPoint.Y)
            value4.Tracer.Color = color7
            value4.Tracer.Visible = true
          elseif value4.Tracer then
            value4.Tracer.Visible = false
          end

          if self.Name and value4.Name then
            value4.Name.Position = Vector2.new(
              worldToViewportPoint.X, worldToViewportPoint.Y - 16
            )

            value4.Name.Text = key4.Name
            value4.Name.Color = color7
            value4.Name.Visible = true
          elseif value4.Name then
            value4.Name.Visible = false
          end

          if self.Skeleton and value4.Skeleton then
            local v8 = humanoid2.RigType == Enum.HumanoidRigType.R15 and v3 or v2

            for index, value5 in ipairs(value4.Skeleton) do
              local v9 = v8[index]
              local flag = false

              if v9 then
                local findFirstChild = character2:FindFirstChild(v9[1])
                local findFirstChild2 = character2:FindFirstChild(v9[2])
                local flag2 = false

                if findFirstChild and findFirstChild2 then
                  local screenPoint2, onScreen2 = currentCamera:WorldToViewportPoint(findFirstChild.Position)
                  local screenPoint3, onScreen3 = currentCamera:WorldToViewportPoint(findFirstChild2.Position)

                  if onScreen2 and onScreen3 then
                    value5.From = Vector2.new(screenPoint2.X, screenPoint2.Y)
                    value5.To = Vector2.new(screenPoint3.X, screenPoint3.Y)
                    value5.Color = color7
                    value5.Visible = true
                  else
                    flag2 = true
                  end
                else
                  flag2 = true
                end

                if flag2 then
                  flag = true
                end
              else
                flag = true
              end

              if flag then
                value5.Visible = false
              end
            end
          elseif value4.Skeleton then
            for _, value6 in ipairs(value4.Skeleton) do
              value6.Visible = false
            end
          end
        end
      end
    end
  end
end

for _, value7 in ipairs(players:GetPlayers()) do
  esp:AddPlayer(value7)
end

local list = {}

table.insert(list, players.PlayerAdded:Connect(function(player) esp:AddPlayer(player) end))

table.insert(
  list, players.PlayerRemoving:Connect(function(player2) esp:RemovePlayer(player2) end)
)

local genv = getgenv()

local function f3(f, p3, p4, p5, p6)
  tweenService:Create(f, TweenInfo.new(
    p3, p5 or Enum.EasingStyle.Quart, p6 or Enum.EasingDirection.Out
  ), p4):Play()
end

function genv.ScriptWorksJailbirdLoaded()
  f1()

  for key5, _ in pairs(esp._cache) do
    esp:RemovePlayer(key5)
  end

  for _, value8 in pairs(list) do
    if value8 and value8.Connected then
      pcall(function() value8:Disconnect() end)
    end
  end

  table.clear(list)
end

local function getInstance(p7, p8, parent)
  local instance = Instance.new(p7)

  for key6, value9 in pairs(p8 or {}) do
    instance[key6] = value9
  end

  if parent then
    instance.Parent = parent
  end

  return instance
end

local function f4(p9, p10)
  return getInstance("UICorner", { CornerRadius = UDim.new(0, p10) }, p9)
end

local function f5(p11, color8, p12, p13)
  return getInstance("UIStroke", {
    Color = color8,
    Thickness = p12 or 1,
    Transparency = p13 or 0,
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
  }, p11)
end

local function f6(instance2)
  instance2.ResetOnSpawn = false
  instance2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

  pcall(function() instance2.Parent = gethui and gethui() or coreGui end)

  if not instance2.Parent then
    instance2.Parent = players.LocalPlayer:WaitForChild("PlayerGui")
  end
end

local list2 = {}

local function f7(p14, p15, p16, p17, p18)
  local list3 = {}

  for j = 1, p15 do
    local roll = math.random(p16, p17)
    local roll2 = math.random()
    local udim = UDim2.fromOffset(16, 16)
    local vector3 = Vector2.new(0.5, 0.5)

    local v10 = {
      f = getInstance("TextLabel", {
        BackgroundTransparency = 1,
        Text = "❄",
        TextColor3 = color2,
        TextSize = roll,
        TextTransparency = p18 + roll2 * 0.25,
        Size = udim,
        AnchorPoint = vector3,
      }, p14),
      x = math.random(),
      y = math.random(),
      v = 0.05 + math.random() * 0.07,
      ph = math.random() * 6.28,
      amp = 0.008 + math.random() * 0.02,
      sp = 0.5 + math.random(),
    }

    list2[#list2 + 1] = v10
    list3[#list3 + 1] = v10
  end

  return list3
end

local connect = runService.RenderStepped:Connect(function(delta)
  for k = #list2, 1, -1 do
    local v11 = list2[k]

    if not v11.f.Parent then
      table.remove(list2, k)
    else
      v11.y = v11.y + v11.v * delta
      v11.ph = v11.ph + v11.sp * delta

      if v11.y > 1.05 then
        v11.y = -0.05
        v11.x = math.random()
      end

      v11.f.Position = UDim2.fromScale(v11.x + math.sin(v11.ph) * v11.amp, v11.y)
    end
  end
end)

local function f8(p19)
  local ok2, result2 = pcall(function()
    local instance3 = game:GetObjects("rbxassetid://" .. p19)[1]

    if instance3 and (instance3:IsA("Decal") or instance3:IsA("Texture")) then
      return instance3.Texture
    end

    if instance3 and instance3:IsA("ImageLabel") then
      return instance3.Image
    end
  end)

  if ok2 and result2 and result2 ~= "" then
    return result2
  end

  return "rbxthumb://type=Asset&id=" .. p19 .. "&w=420&h=420"
end

local instance4 = getInstance("ScreenGui", {
  Name = "ScriptWorksLoading",
  IgnoreGuiInset = true,
  DisplayOrder = 1000,
})

f6(instance4)

local instance5 = getInstance("ImageLabel", {
  Size = UDim2.fromScale(1, 1),
  BackgroundColor3 = Color3.new(0, 0, 0),
  BorderSizePixel = 0,
  Image = "rbxthumb://type=Asset&id=11585140568&w=420&h=420",
  ScaleType = Enum.ScaleType.Crop,
}, instance4)

task.spawn(function() instance5.Image = f8(11585140568) end)

local instance6 = getInstance("TextLabel", {
  AnchorPoint = Vector2.new(0.5, 0.5),
  Position = UDim2.fromScale(0.5, 0.3),
  Size = UDim2.fromOffset(500, 80),
  BackgroundTransparency = 1,
  RichText = true,
  Font = font.FredokaOne,
  TextSize = 64,
  TextTransparency = 1,
  Text = '<font color="#C82034">Script</font><font color="#FFFFFF">Works</font>',
}, instance5)

local instance7 = getInstance(
  "UIStroke", { Color = color, Thickness = 2, Transparency = 1 }, instance6
)

local instance8 = getInstance("TextLabel", {
  AnchorPoint = Vector2.new(0.5, 0.5),
  Position = UDim2.fromScale(0.5, 0.5),
  Size = UDim2.fromOffset(420, 52),
  BackgroundTransparency = 1,
  Text = "Loading",
  Font = font.FredokaOne,
  TextSize = 42,
  TextColor3 = color2,
  TextTransparency = 1,
}, instance5)

local instance9 = getInstance("Frame", {
  AnchorPoint = Vector2.new(0.5, 0.5),
  Position = UDim2.fromScale(0.5, 0.57),
  Size = UDim2.fromOffset(380, 12),
  BackgroundColor3 = color6,
  BackgroundTransparency = 1,
  BorderSizePixel = 0,
}, instance5)

f4(instance9, 99)

local instance10 = getInstance("Frame", {
  Size = UDim2.fromScale(0, 1),
  BackgroundColor3 = color,
  BorderSizePixel = 0,
}, instance9)

f4(instance10, 99)

local list4 = f7(getInstance("Frame", {
  Size = UDim2.fromScale(1, 1),
  BackgroundTransparency = 1,
  ClipsDescendants = true,
}, instance5), 40, 10, 22, 0.15)

f3(instance6, 1.2, { TextTransparency = 0 })
f3(instance7, 1.2, { Transparency = 0.55 })

task.delay(1.3, function()
  if loading then
    tweenService:Create(instance7, TweenInfo.new(
      1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true
    ), { Transparency = 0.2 }):Play()
  end
end)

f3(instance8, 1, { TextTransparency = 0 })
f3(instance9, 1, { BackgroundTransparency = 0.2 })

local flag3 = true

task.spawn(function()
  local v12 = 0

  while flag3 do
    v12 = v12 % 3 + 1
    instance8.Text = "Loading" .. string.rep(".", v12)
    task.wait(0.4)
  end
end)

local instance11 = getInstance("ScreenGui", { Name = "ScriptWorks", Enabled = false })
f6(instance11)
local flag4 = true

local instance12 = getInstance("Frame", {
  AnchorPoint = Vector2.new(0.5, 0.5),
  Position = UDim2.fromScale(0.5, 0.5),
  Size = UDim2.fromOffset(760, 460),
  BackgroundTransparency = 1,
}, instance11)

local instance13 = getInstance("UIScale", { Scale = 0.9 }, instance12)

local instance14 = getInstance("Frame", {
  AnchorPoint = Vector2.new(0.5, 0),
  Position = UDim2.fromScale(0.5, 0),
  Size = UDim2.fromScale(1, 1),
  BackgroundTransparency = 1,
}, instance12)

local list5 = {}

for _, value10 in ipairs({ { 24, 22, 0.6 }, { 54, 36, 0.82 } }) do
  local instance15 = getInstance("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 6),
    Size = UDim2.new(1, value10[1], 1, value10[1]),
    BackgroundColor3 = Color3.new(0, 0, 0),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
  }, instance14)

  instance15:SetAttribute("a", value10[3])

  f4(instance15, value10[2])
  list5[#list5 + 1] = instance15
end

local function f9(p20, p21, sine)
  for _, value11 in ipairs(list5) do
    f3(value11, p21, { BackgroundTransparency = p20 and value11:GetAttribute("a") or 1 }, sine)
  end
end

local instance16 = getInstance("CanvasGroup", {
  Size = UDim2.fromScale(1, 1),
  BackgroundColor3 = Color3.fromRGB(24, 24, 28),
  BorderSizePixel = 0,
  GroupTransparency = 1,
}, instance14)

f4(instance16, 14)
f5(instance16, color2, 1, 0.85)

local instance17 = getInstance("ImageLabel", {
  Size = UDim2.fromScale(1, 1),
  BackgroundTransparency = 1,
  ScaleType = Enum.ScaleType.Crop,
}, instance16)

task.spawn(function() instance17.Image = f8(5954377206) end)

getInstance("Frame", {
  Size = UDim2.fromScale(1, 1),
  BackgroundColor3 = Color3.fromRGB(14, 14, 18),
  BackgroundTransparency = 0.35,
  BorderSizePixel = 0,
}, instance16)

f7(getInstance("Frame", {
  Size = UDim2.fromScale(1, 1),
  BackgroundTransparency = 1,
  ClipsDescendants = true,
}, instance16), 22, 8, 14, 0.55)

local instance18 = getInstance("Frame", {
  Size = UDim2.fromScale(0.25, 1),
  BackgroundColor3 = Color3.fromRGB(16, 16, 20),
  BackgroundTransparency = 0.25,
  BorderSizePixel = 0,
}, instance16)

getInstance("Frame", {
  AnchorPoint = Vector2.new(1, 0),
  Position = UDim2.fromScale(1, 0),
  Size = UDim2.new(0, 1, 1, 0),
  BackgroundColor3 = color2,
  BackgroundTransparency = 0.9,
  BorderSizePixel = 0,
}, instance18)

local instance19 = getInstance("ImageLabel", {
  Position = UDim2.fromOffset(14, 8),
  Size = UDim2.fromOffset(30, 30),
  BackgroundColor3 = color,
  ScaleType = Enum.ScaleType.Crop,
}, instance18)

f4(instance19, 8)
task.spawn(function() instance19.Image = f8(8150835488) end)

getInstance("TextLabel", {
  Position = UDim2.fromOffset(52, 6),
  Size = UDim2.new(1, -56, 0, 18),
  BackgroundTransparency = 1,
  Text = "ScriptWorks",
  Font = font.GothamBold,
  TextSize = 14,
  TextColor3 = color2,
  TextXAlignment = Enum.TextXAlignment.Left,
}, instance18)

getInstance("TextLabel", {
  Position = UDim2.fromOffset(52, 23),
  Size = UDim2.new(1, -56, 0, 14),
  BackgroundTransparency = 1,
  Text = "Jailbird Edition",
  Font = font.Gotham,
  TextSize = 10,
  TextColor3 = color3,
  TextXAlignment = Enum.TextXAlignment.Left,
}, instance18)

local instance20 = getInstance("Frame", {
  Position = UDim2.fromOffset(10, 60),
  Size = UDim2.new(1, -20, 1, -130),
  BackgroundTransparency = 1,
}, instance18)

getInstance("UIListLayout", { Padding = UDim.new(0, 4) }, instance20)

local instance21 = getInstance("Frame", {
  AnchorPoint = Vector2.new(0, 1),
  Position = UDim2.fromScale(0, 1),
  Size = UDim2.new(1, 0, 0, 62),
  BackgroundTransparency = 1,
}, instance18)

getInstance("Frame", {
  Position = UDim2.fromOffset(12, 0),
  Size = UDim2.new(1, -24, 0, 1),
  BackgroundColor3 = color2,
  BackgroundTransparency = 0.9,
  BorderSizePixel = 0,
}, instance21)

local instance22 = getInstance("ImageLabel", {
  AnchorPoint = Vector2.new(0, 0.5),
  Position = UDim2.new(0, 14, 0.5, 0),
  Size = UDim2.fromOffset(32, 32),
  BackgroundColor3 = color,
}, instance21)

f4(instance22, 16)

task.spawn(function()
  local ok3, image = pcall(function()
    return players:GetUserThumbnailAsync(
      players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100
    )
  end)

  if ok3 then
    instance22.Image = image
  end
end)

getInstance("TextLabel", {
  Position = UDim2.new(0, 54, 0.5, -16),
  Size = UDim2.new(1, -58, 0, 16),
  BackgroundTransparency = 1,
  Text = players.LocalPlayer.DisplayName,
  Font = font.GothamBold,
  TextSize = 12,
  TextColor3 = color2,
  TextXAlignment = Enum.TextXAlignment.Left,
  TextTruncate = Enum.TextTruncate.AtEnd,
}, instance21)

getInstance("TextLabel", {
  Position = UDim2.new(0, 54, 0.5, 1),
  Size = UDim2.new(1, -58, 0, 14),
  BackgroundTransparency = 1,
  Text = "● Online",
  Font = font.Gotham,
  TextSize = 10,
  TextColor3 = color3,
  TextXAlignment = Enum.TextXAlignment.Left,
}, instance21)

local instance23 = getInstance("Frame", {
  Position = UDim2.fromScale(0.25, 0),
  Size = UDim2.fromScale(0.75, 1),
  BackgroundTransparency = 1,
}, instance16)

local instance24 = getInstance("Frame", {
  Size = UDim2.new(1, 0, 0, 46),
  BackgroundColor3 = Color3.fromRGB(14, 14, 18),
  BackgroundTransparency = 0.3,
  BorderSizePixel = 0,
}, instance23)

getInstance("Frame", {
  AnchorPoint = Vector2.new(0, 1),
  Position = UDim2.fromScale(0, 1),
  Size = UDim2.new(1, 0, 0, 1),
  BackgroundColor3 = color2,
  BackgroundTransparency = 0.9,
  BorderSizePixel = 0,
}, instance24)

local instance25 = getInstance("Frame", {
  Position = UDim2.fromOffset(0, 46),
  Size = UDim2.new(1, 0, 1, -46),
  BackgroundTransparency = 1,
  ClipsDescendants = true,
}, instance23)

local function f10(p22, text)
  local instance26 = getInstance("Frame", {
    Size = UDim2.new(1, 0, 0, 32),
    BackgroundColor3 = Color3.fromRGB(16, 16, 20),
    BackgroundTransparency = 0.2,
    BorderSizePixel = 0,
  }, p22)

  f4(instance26, 8)

  getInstance("TextLabel", {
    Position = UDim2.fromOffset(10, 0),
    Size = UDim2.new(0.5, -10, 1, 0),
    BackgroundTransparency = 1,
    Text = text,
    Font = font.Gotham,
    TextSize = 12,
    TextColor3 = Color3.fromRGB(230, 230, 235),
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd,
  }, instance26)

  return instance26
end

local function f11(p23)
  local instance27 = getInstance("ScrollingFrame", {
    Position = UDim2.new(0, 10, 0, 8),
    Size = UDim2.new(1, -20, 1, -16),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = color,
    CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
  }, p23)

  getInstance(
    "UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder },
    instance27
  )

  getInstance("UIPadding", { PaddingRight = UDim.new(0, 6) }, instance27)

  return instance27
end

local function f12(p24, p25, p26, p27, p28, p29)
  local v13 = f10(p24, p25)

  local instance28 = getInstance("TextLabel", {
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -10, 0.5, 0),
    Size = UDim2.fromOffset(38, 20),
    BackgroundColor3 = color6,
    Text = tostring(p28),
    Font = font.Gotham,
    TextSize = 11,
    TextColor3 = color2,
  }, v13)

  f4(instance28, 6)

  local instance29 = getInstance("TextButton", {
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -56, 0.5, 0),
    Size = UDim2.fromOffset(64, 16),
    BackgroundTransparency = 1,
    Text = "",
  }, v13)

  local instance30 = getInstance("Frame", {
    AnchorPoint = Vector2.new(0, 0.5),
    Position = UDim2.fromScale(0, 0.5),
    Size = UDim2.new(1, 0, 0, 3),
    BackgroundColor3 = color5,
    BorderSizePixel = 0,
  }, instance29)

  f4(instance30, 2)
  local v14 = (p28 - p26) / (p27 - p26)

  local instance31 = getInstance("Frame", {
    Size = UDim2.fromScale(v14, 1),
    BackgroundColor3 = color,
    BorderSizePixel = 0,
  }, instance30)

  f4(instance31, 2)

  local instance32 = getInstance("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(v14, 0.5),
    Size = UDim2.fromOffset(10, 10),
    BackgroundColor3 = color2,
  }, instance29)

  f4(instance32, 5)

  local function f13(p30)
    local clamped = math.clamp(p30, 0, 1)
    instance31.Size = UDim2.fromScale(clamped, 1)
    instance32.Position = UDim2.fromScale(clamped, 0.5)
    local v15 = p27 - p26 >= 9

    local rounded = v15
    rounded = v15 and math.floor(p26 + (p27 - p26) * clamped + 0.5)

    local v16 = rounded
    v16 = rounded or math.floor((p26 + (p27 - p26) * clamped) * 100) / 100

    instance28.Text = tostring(v16)

    if p29 then
      p29(v16)
    end
  end

  local flag5 = false

  local function f14(input)
    return input.UserInputType == Enum.UserInputType.MouseButton1
      or input.UserInputType == Enum.UserInputType.Touch
  end

  instance29.InputBegan:Connect(function(input2)
    if f14(input2) then
      flag5 = true
      f13((input2.Position.X - instance29.AbsolutePosition.X) / instance29.AbsoluteSize.X)
    end
  end)

  table.insert(list, userInputService.InputChanged:Connect(function(input3)
    if flag5
      and (input3.UserInputType == Enum.UserInputType.MouseMovement
        or input3.UserInputType == Enum.UserInputType.Touch) then
      f13((input3.Position.X - instance29.AbsolutePosition.X) / instance29.AbsoluteSize.X)
    end
  end))

  table.insert(list, userInputService.InputEnded:Connect(function(input4)
    if f14(input4) then
      flag5 = false
    end
  end))

  return {
    SetValue = function(p31)
      local clamped2 = math.clamp(p31, p26, p27)
      local v17 = (clamped2 - p26) / (p27 - p26)
      instance31.Size = UDim2.fromScale(v17, 1)
      instance32.Position = UDim2.fromScale(v17, 0.5)
      instance28.Text = tostring(clamped2)

      if p29 then
        p29(clamped2)
      end
    end,
  }
end

local function f15(p32, text2)
  local instance33 = getInstance(
    "Frame", { Size = UDim2.new(1, 0, 0, 24), BackgroundTransparency = 1 }, p32
  )

  local instance34 = getInstance("TextLabel", {
    AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.fromScale(0, 1),
    Size = UDim2.fromOffset(0, 16),
    AutomaticSize = Enum.AutomaticSize.X,
    BackgroundColor3 = Color3.fromRGB(14, 14, 18),
    BackgroundTransparency = 0.25,
    Text = text2,
    Font = font.GothamBold,
    TextSize = 10,
    TextColor3 = Color3.fromRGB(205, 205, 212),
  }, instance33)

  f4(instance34, 5)

  getInstance(
    "UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) }, instance34
  )
end

local function f16(p33, p34, p35, fn)
  local v18 = f10(p33, p34)
  local keyCode = p35
  local flag6 = false

  local instance35 = getInstance("TextButton", {
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -10, 0.5, 0),
    Size = UDim2.fromOffset(70, 20),
    BackgroundColor3 = color6,
    Text = p35 and p35.Name or "None",
    Font = font.GothamBold,
    TextSize = 11,
    TextColor3 = color2,
  }, v18)

  f4(instance35, 6)

  instance35.MouseButton1Click:Connect(function()
    if flag6 then
      return
    end

    flag6 = true

    instance35.Text = "[...]"
    instance35.TextColor3 = color3

    local connect2

    connect2 = userInputService.InputBegan:Connect(function(input5, p36)
      if input5.UserInputType == Enum.UserInputType.Keyboard then
        keyCode = input5.KeyCode == Enum.KeyCode.Escape and nil or input5.KeyCode

        instance35.Text = keyCode and keyCode.Name or "None"
        instance35.TextColor3 = color2

        flag6 = false
        connect2:Disconnect()
        fn(keyCode)
      end
    end)
  end)

  return {
    SetKey = function(keyCode2)
      keyCode = keyCode2
      instance35.Text = keyCode and keyCode.Name or "None"
      fn(keyCode)
    end,
  }
end

local function f17(p37, p38, p39, p40)
  local v19 = p39
  local v20 = f10(p37, p38)

  local instance36 = getInstance("TextButton", {
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -10, 0.5, 0),
    Size = UDim2.fromOffset(34, 18),
    Text = "",
    AutoButtonColor = false,
    BackgroundColor3 = v19 and color or color5,
  }, v20)

  f4(instance36, 9)

  local instance37 = getInstance("Frame", {
    AnchorPoint = Vector2.new(0, 0.5),
    Position = UDim2.new(0, v19 and 18 or 2, 0.5, 0),
    Size = UDim2.fromOffset(14, 14),
    BackgroundColor3 = color2,
  }, instance36)

  f4(instance37, 7)

  local v21 = {
    Button = instance36,
    Toggle = function(p41)
      v19 = p41 ~= nil and p41 or not v19

      f3(instance36, 0.2, { BackgroundColor3 = v19 and color or color5 })
      f3(instance37, 0.2, { Position = UDim2.new(0, v19 and 18 or 2, 0.5, 0) })

      if p40 then
        p40(v19)
      end
    end,
    GetState = function() return v19 end,
  }

  instance36.MouseButton1Click:Connect(function() v21.Toggle() end)
  return v21
end

local list6 = {}
local list7 = {}
local list8 = { { "Aimbot" }, { "Visuals" }, { "Movement" }, { "Configs" } }

local instance38 = getInstance(
  "Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1 }, instance25
)

list6[1] = instance38
local v22 = f11(instance38)
f15(v22, "AIMBOT SETTINGS")

f17(v22, "Aimlock Enabled", aimSettings.Enabled, function(enabled)
  aimSettings.Enabled = enabled
end)

f17(v22, "Wall Check", aimSettings.WallCheck, function(wallCheck)
  aimSettings.WallCheck = wallCheck
end)

local v23 = f12(v22, "Smoothness", 1, 10, aimSettings.Smoothness, function(smoothness)
  aimSettings.Smoothness = smoothness
end)

f17(v22, "Team Check", aimSettings.TeamCheck, function(teamCheck)
  aimSettings.TeamCheck = teamCheck
end)

f15(v22, "TARGET PART (EXPANDABLE)")
local v24 = f10(v22, "Target: " .. aimSettings.BodyPart)

local instance39 = getInstance("TextButton", {
  AnchorPoint = Vector2.new(1, 0.5),
  Position = UDim2.new(1, -10, 0.5, 0),
  Size = UDim2.fromOffset(26, 20),
  BackgroundColor3 = Color3.fromRGB(28, 28, 35),
  Text = "+",
  TextColor3 = color2,
  TextSize = 14,
  Font = font.GothamBold,
}, v24)

f4(instance39, 4)

local instance40 = getInstance("Frame", {
  Size = UDim2.new(1, 0, 0, 0),
  BackgroundTransparency = 1,
  ClipsDescendants = true,
}, v22)

getInstance(
  "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 3) },
  instance40
)

local list9 = {}
local flag7 = false

for _, value12 in ipairs({ "Head", "Torso", "Closest" }) do
  local instance41 = getInstance("TextButton", {
    Size = UDim2.new(1, 0, 0, 28),
    BackgroundColor3 = Color3.fromRGB(20, 20, 24),
    Text = "    > " .. value12,
    TextColor3 = value12 == aimSettings.BodyPart and color or color4,
    TextSize = 12,
    Font = font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
  }, instance40)

  f4(instance41, 6)
  table.insert(list9, instance41)

  instance41.MouseButton1Click:Connect(function()
    aimSettings.BodyPart = value12
    v24.TextLabel.Text = "Target: " .. value12

    for _, value13 in ipairs(list9) do
      value13.TextColor3 = value13.Text:find(aimSettings.BodyPart) and color or color4
    end

    flag7 = false
    instance39.Text = "+"

    f3(
      instance40, 0.25, { Size = UDim2.new(1, 0, 0, 0) }, Enum.EasingStyle.Quart,
      Enum.EasingDirection.Out
    )
  end)
end

instance39.MouseButton1Click:Connect(function()
  flag7 = not flag7
  instance39.Text = flag7 and "-" or "+"
  local v25 = flag7

  f3(
    instance40, 0.25, { Size = UDim2.new(1, 0, 0, v25 and 90 or 0) }, Enum.EasingStyle.Quart,
    Enum.EasingDirection.Out
  )
end)

local instance42 = getInstance("Frame", {
  Size = UDim2.fromScale(1, 1),
  BackgroundTransparency = 1,
  Visible = false,
}, instance25)

list6[2] = instance42
local v26 = f11(instance42)
f15(v26, "ESP SETTINGS")

f17(v26, "Master ESP", esp.Enabled, function(enabled2) esp.Enabled = enabled2 end)
f17(v26, "Box ESP", esp.Box, function(box) esp.Box = box end)
f17(v26, "Tracer ESP", esp.Tracer, function(tracer) esp.Tracer = tracer end)
f17(v26, "Name ESP", esp.Name, function(name) esp.Name = name end)
f17(v26, "Skeleton ESP", esp.Skeleton, function(skeleton) esp.Skeleton = skeleton end)
f17(v26, "ESP Team Check", esp.TeamCheck, function(teamCheck2) esp.TeamCheck = teamCheck2 end)

local instance43 = getInstance("Frame", {
  Size = UDim2.fromScale(1, 1),
  BackgroundTransparency = 1,
  Visible = false,
}, instance25)

list6[3] = instance43
local v27 = f11(instance43)
f15(v27, "WALKSPEED")

local v28 = f17(v27, "WalkSpeed Enabled", v1.WalkSpeedEnabled, function(walkSpeedEnabled)
  v1.WalkSpeedEnabled = walkSpeedEnabled

  pcall(function()
    local humanoid3 = localPlayer.Character
      and localPlayer.Character:FindFirstChildOfClass("Humanoid")

    if humanoid3 then
      humanoid3.WalkSpeed = walkSpeedEnabled and v1.WalkSpeedValue or 16
    end
  end)
end)

f12(v27, "Speed Value", 16, 250, v1.WalkSpeedValue, function(p42)
  v1.WalkSpeedValue = p42

  if v1.WalkSpeedEnabled then
    pcall(function()
      local humanoid4 = localPlayer.Character
        and localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid4 then
        humanoid4.WalkSpeed = p42
      end
    end)
  end
end)

local v29 = f16(v27, "WalkSpeed Keybind", v1.WalkSpeedKey, function(walkSpeedKey)
  v1.WalkSpeedKey = walkSpeedKey
end)

f15(v27, "FLY")

local v30 = f17(v27, "Fly Enabled", v1.FlyEnabled, function(flyEnabled)
  v1.FlyEnabled = flyEnabled

  if not flyEnabled then
    f1()
  end
end)

local v31 = f16(v27, "Fly Keybind", v1.FlyKey, function(flyKey) v1.FlyKey = flyKey end)
f15(v27, "NOCLIP")

local v32 = f17(v27, "Noclip Enabled", v1.NoclipEnabled, function(noclipEnabled)
  v1.NoclipEnabled = noclipEnabled

  if not noclipEnabled then
    pcall(function()
      local character3 = localPlayer.Character

      if character3 then
        for _, value14 in ipairs(character3:GetDescendants()) do
          if value14:IsA("BasePart") then
            value14.CanCollide = true
          end
        end
      end
    end)
  end
end)

local v33 = f16(v27, "Noclip Keybind", v1.NoclipKey, function(noclipKey)
  v1.NoclipKey = noclipKey
end)

local instance44 = getInstance("Frame", {
  Size = UDim2.fromScale(1, 1),
  BackgroundTransparency = 1,
  Visible = false,
}, instance25)

list6[4] = instance44
local v34 = f11(instance44)
f15(v34, "CONFIGURATIONS")

local instance45 = getInstance(
  "Frame", { Size = UDim2.new(1, 0, 0, 32), BackgroundTransparency = 1 }, v34
)

local instance46 = getInstance("TextBox", {
  Size = UDim2.new(1, -100, 1, 0),
  BackgroundColor3 = color6,
  Text = "",
  PlaceholderText = "Config Name...",
  PlaceholderColor3 = Color3.fromRGB(120, 120, 120),
  TextColor3 = color2,
  TextSize = 13,
  Font = font.GothamBold,
}, instance45)

f4(instance46, 6)

local instance47 = getInstance("TextButton", {
  AnchorPoint = Vector2.new(1, 0),
  Position = UDim2.new(1, 0, 0, 0),
  Size = UDim2.new(0, 92, 1, 0),
  BackgroundColor3 = color,
  Text = "Save Config",
  TextColor3 = color2,
  TextSize = 13,
  Font = font.GothamBold,
}, instance45)

f4(instance47, 6)

local instance48 = getInstance("ScrollingFrame", {
  Size = UDim2.new(1, 0, 0, 180),
  BackgroundColor3 = color6,
  BackgroundTransparency = 0.5,
  BorderSizePixel = 0,
  ScrollBarThickness = 3,
  ScrollBarImageColor3 = color,
  CanvasSize = UDim2.new(),
  AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, v34)

f4(instance48, 6)

getInstance(
  "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 3) },
  instance48
)

local function f18(p43)
  for index2, value15 in ipairs(list7) do
    f3(value15, 0.2, { BackgroundTransparency = index2 == p43 and 0.7 or 1 })
  end

  for index3, value16 in ipairs(list6) do
    if index3 == p43 then
      value16.Position = UDim2.fromOffset(0, 12)
      value16.Visible = true
      f3(value16, 0.25, { Position = UDim2.fromOffset(0, 0) })
    else
      value16.Visible = false
    end
  end
end

for index4, value17 in ipairs(list8) do
  local instance49 = getInstance(
    "Frame", { Size = UDim2.new(1, 0, 0, 32), BackgroundTransparency = 1 }, instance20
  )

  local instance50 = getInstance("TextButton", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = color,
    BackgroundTransparency = 1,
    Text = "   " .. value17[1],
    Font = font.GothamMedium,
    TextSize = 12,
    TextColor3 = color2,
    TextXAlignment = Enum.TextXAlignment.Left,
    AutoButtonColor = false,
  }, instance49)

  f4(instance50, 8)
  instance50.MouseButton1Click:Connect(function() f18(index4) end)
  list7[index4] = instance50
end

f18(1)

local instance51 = getInstance("TextButton", {
  AnchorPoint = Vector2.new(0.5, 1),
  Position = UDim2.new(0.5, 0, 1, -30),
  Size = UDim2.fromOffset(140, 28),
  BackgroundColor3 = color,
  Text = "SW  ScriptWorks",
  Font = font.GothamBold,
  TextSize = 12,
  TextColor3 = color2,
  Visible = false,
  AutoButtonColor = false,
}, instance11)

f4(instance51, 14)

local function f19(p44, color9, text3, p45)
  local instance52 = getInstance("TextButton", {
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, p44, 0.5, 0),
    Size = UDim2.fromOffset(13, 13),
    BackgroundColor3 = color9,
    Text = "",
    AutoButtonColor = false,
    Font = font.GothamBold,
    TextSize = 11,
    TextColor3 = Color3.fromRGB(60, 20, 20),
  }, instance24)

  f4(instance52, 7)

  instance52.MouseEnter:Connect(function()
    instance52.Text = text3
    f3(instance52, 0.15, { Size = UDim2.fromOffset(15, 15) })
  end)

  instance52.MouseLeave:Connect(function()
    instance52.Text = ""
    f3(instance52, 0.15, { Size = UDim2.fromOffset(13, 13) })
  end)

  instance52.MouseButton1Click:Connect(p45)
end

local flag8 = false

f19(-14, Color3.fromRGB(255, 95, 87), "X", function()
  flag4 = false
  flag3 = false

  f3(instance13, 0.25, { Scale = 0.9 })
  f3(instance16, 0.25, { GroupTransparency = 1 })

  f9(false, 0.25)
  task.wait(0.3)

  pcall(function() connect:Disconnect() end)
  pcall(function() instance11:Destroy() end)
  pcall(function() instance4:Destroy() end)
end)

f19(-34, Color3.fromRGB(254, 188, 46), "-", function()
  f3(instance13, 0.2, { Scale = 0.85 })
  f3(instance16, 0.2, { GroupTransparency = 1 })

  f9(false, 0.2)
  task.wait(0.2)
  instance12.Visible = false
  instance51.Visible = true
end)

f19(-54, Color3.fromRGB(40, 200, 64), "+", function()
  flag8 = not flag8

  f3(instance12, 0.3, {
    Size = flag8 and UDim2.fromOffset(920, 520) or UDim2.fromOffset(760, 460),
  })
end)

instance51.MouseButton1Click:Connect(function()
  instance51.Visible = false
  instance12.Visible = true

  f3(instance13, 0.25, { Scale = 1 })
  f3(instance16, 0.25, { GroupTransparency = 0 })

  f9(true, 0.25)
end)

local v35, v36, v37

local function f20(p46)
  p46.InputBegan:Connect(function(input6)
    if input6.UserInputType == Enum.UserInputType.MouseButton1
      or input6.UserInputType == Enum.UserInputType.Touch then
      local position2 = input6.Position
      local position3 = instance12.Position
      v35 = true
      v36 = position2
      v37 = position3
    end
  end)
end

f20(instance24)
f20(instance18)

table.insert(list, userInputService.InputChanged:Connect(function(input7)
  if v35
    and (input7.UserInputType == Enum.UserInputType.MouseMovement
      or input7.UserInputType == Enum.UserInputType.Touch) then
    local v38 = input7.Position - v36

    instance12.Position = UDim2.new(
      v37.X.Scale, v37.X.Offset + v38.X, v37.Y.Scale, v37.Y.Offset + v38.Y
    )
  end
end))

table.insert(list, userInputService.InputEnded:Connect(function(input8)
  if input8.UserInputType == Enum.UserInputType.MouseButton1
    or input8.UserInputType == Enum.UserInputType.Touch then
    v35 = false
  end
end))

local offset = instance12.Position.X.Offset
local v39 = 0
local v40 = 0
local v41 = 0
local v42 = offset

table.insert(list, runService.RenderStepped:Connect(function(delta2)
  local clamped3 = math.clamp(delta2, 0.0041666666666667, 0.05)
  local offset2 = instance12.Position.X.Offset
  v41 = v41 + ((offset2 - v42) / clamped3 - v41) * math.min(1, clamped3 * 14)
  v42 = offset2
  v40 = v40 + ((math.clamp(v41 * 0.012, -9, 9) - v39) * 140 - v40 * 11) * clamped3
  v39 = v39 + v40 * clamped3

  if v39 ~= v39 or v40 ~= v40 or v41 ~= v41 then
    v39 = 0
    v40 = 0
    v41 = 0
  end

  instance14.Rotation = v39
end))

local function f21(jsonDecode)
  if not jsonDecode then
    return
  end

  if jsonDecode.AimSettings then
    aimSettings.Enabled = jsonDecode.AimSettings.Enabled or false
    aimSettings.ToggleMode = jsonDecode.AimSettings.ToggleMode or false
    aimSettings.TeamCheck = jsonDecode.AimSettings.TeamCheck or false
    aimSettings.WallCheck = jsonDecode.AimSettings.WallCheck or false

    if jsonDecode.AimSettings.BodyPart then
      aimSettings.BodyPart = jsonDecode.AimSettings.BodyPart
      v24.TextLabel.Text = "Target: " .. aimSettings.BodyPart

      for _, value18 in ipairs(list9) do
        value18.TextColor3 = value18.Text:find(aimSettings.BodyPart) and color or color4
      end
    end

    if jsonDecode.AimSettings.Smoothness then
      v23.SetValue(jsonDecode.AimSettings.Smoothness)
    end
  end

  if jsonDecode.MovementSettings then
    if jsonDecode.MovementSettings.WalkSpeedValue then
      v1.WalkSpeedValue = jsonDecode.MovementSettings.WalkSpeedValue
    end

    if jsonDecode.MovementSettings.WalkSpeedKey then
      local v43 = jsonDecode.MovementSettings.WalkSpeedKey ~= "None"
          and Enum.KeyCode[jsonDecode.MovementSettings.WalkSpeedKey]
        or nil

      v29.SetKey(v43)
    end

    if jsonDecode.MovementSettings.FlyKey then
      local v44 = jsonDecode.MovementSettings.FlyKey ~= "None"
          and Enum.KeyCode[jsonDecode.MovementSettings.FlyKey]
        or nil

      v31.SetKey(v44)
    end

    if jsonDecode.MovementSettings.NoclipKey then
      local v45 = jsonDecode.MovementSettings.NoclipKey ~= "None"
          and Enum.KeyCode[jsonDecode.MovementSettings.NoclipKey]
        or nil

      v33.SetKey(v45)
    end
  end

  if jsonDecode.ESP then
    esp.Enabled = jsonDecode.ESP.Enabled or false
    esp.Box = jsonDecode.ESP.Box or false
    esp.Tracer = jsonDecode.ESP.Tracer or false
    esp.Name = jsonDecode.ESP.Name or false
    esp.Skeleton = jsonDecode.ESP.Skeleton or false
    esp.TeamCheck = jsonDecode.ESP.TeamCheck or false
  end
end

local f22, f23

local function f24(text4)
  if not text4 or text4 == "" then
    return
  end

  pcall(function()
    local jsonEncode = httpService:JSONEncode(f23())

    if writefile then
      writefile("MeteorConfigs" .. "/" .. text4 .. ".json", jsonEncode)
      f22()
    end
  end)
end

function f23()
  return {
    AimSettings = aimSettings,
    MovementSettings = {
      WalkSpeedEnabled = v1.WalkSpeedEnabled,
      WalkSpeedValue = v1.WalkSpeedValue,
      WalkSpeedKey = v1.WalkSpeedKey and v1.WalkSpeedKey.Name or "None",
      FlyEnabled = v1.FlyEnabled,
      FlyKey = v1.FlyKey and v1.FlyKey.Name or "None",
      NoclipEnabled = v1.NoclipEnabled,
      NoclipKey = v1.NoclipKey and v1.NoclipKey.Name or "None",
    },
    ESP = esp,
  }
end

local function f25(json)
  if not json or json == "" then
    return
  end

  pcall(function()
    if readfile and isfile and isfile("MeteorConfigs" .. "/" .. json .. ".json") then
      f21((httpService:JSONDecode((readfile("MeteorConfigs" .. "/" .. json .. ".json")))))
    end
  end)
end

local function f26(json2)
  if not json2 or json2 == "" then
    return
  end

  pcall(function()
    if delfile and isfile and isfile("MeteorConfigs" .. "/" .. json2 .. ".json") then
      delfile("MeteorConfigs" .. "/" .. json2 .. ".json")
      f22()
    end
  end)
end

function f22()
  for _, value19 in ipairs(instance48:GetChildren()) do
    if value19:IsA("Frame") then
      value19:Destroy()
    end
  end

  pcall(function()
    if listfiles then
      for _, value20 in ipairs((listfiles("MeteorConfigs"))) do
        if value20:sub(-5) == ".json" then
          local json3 = value20:match("([^/%\\]+)%.json$")

          if json3 then
            local instance53 = getInstance("Frame", {
              Size = UDim2.new(1, -4, 0, 28),
              BackgroundColor3 = Color3.fromRGB(20, 20, 20),
            }, instance48)

            f4(instance53, 4)

            getInstance("TextLabel", {
              Size = UDim2.new(1, -70, 1, 0),
              Position = UDim2.fromOffset(6, 0),
              BackgroundTransparency = 1,
              Text = json3,
              TextColor3 = color2,
              TextSize = 12,
              Font = font.GothamBold,
              TextXAlignment = Enum.TextXAlignment.Left,
            }, instance53)

            local instance54 = getInstance("TextButton", {
              Position = UDim2.new(1, -64, 0, 4),
              Size = UDim2.new(0, 28, 0, 20),
              BackgroundColor3 = color,
              Text = "L",
              TextColor3 = color2,
              TextSize = 11,
              Font = font.GothamBold,
            }, instance53)

            f4(instance54, 4)

            local instance55 = getInstance("TextButton", {
              Position = UDim2.new(1, -32, 0, 4),
              Size = UDim2.new(0, 28, 0, 20),
              BackgroundColor3 = Color3.fromRGB(180, 40, 40),
              Text = "X",
              TextColor3 = color2,
              TextSize = 11,
              Font = font.GothamBold,
            }, instance53)

            f4(instance55, 4)

            table.insert(list, instance54.MouseButton1Click:Connect(function() f25(json3) end))
            table.insert(list, instance55.MouseButton1Click:Connect(function() f26(json3) end))
          end
        end
      end
    end
  end)
end

table.insert(list, instance47.MouseButton1Click:Connect(function()
  local text5 = instance46.Text

  if text5 and text5 ~= "" then
    f24(text5)
    instance46.Text = ""
  end
end))

f22()

local function f27(instance56)
  if not aimSettings.WallCheck then
    return true
  end

  if not instance56 then
    return false
  end

  local position4 = currentCamera.CFrame.Position
  local v46 = instance56.Position - position4

  local raycastParams = RaycastParams.new()
  raycastParams.FilterType = Enum.RaycastFilterType.Exclude

  local filterDescendantsInstances = { currentCamera }

  if localPlayer.Character then
    table.insert(filterDescendantsInstances, localPlayer.Character)
  end

  if instance56.Parent and instance56.Parent:IsA("Model") then
    table.insert(filterDescendantsInstances, instance56.Parent)
  end

  raycastParams.FilterDescendantsInstances = filterDescendantsInstances
  raycastParams.IgnoreWater = true
  raycastParams.RespectCanCollide = true

  local raycast = workspaceService:Raycast(position4, v46, raycastParams)

  if not raycast then
    return true
  end

  if raycast.Instance
    and (raycast.Instance:IsDescendantOf(instance56.Parent) or not raycast.Instance.CanCollide) then
    return true
  end

  return false
end

local function makeBodyGyro()
  if not v1.FlyEnabled then
    f1()
    return
  end

  local character4 = localPlayer.Character
  local humanoidRootPart2 = character4 and character4:FindFirstChild("HumanoidRootPart")
  local humanoid5 = character4 and character4:FindFirstChildOfClass("Humanoid")

  if not humanoidRootPart2 or not humanoid5 or humanoid5.Health <= 0 then
    f1()
    return
  end

  if not bodyGyro or bodyGyro.Parent ~= humanoidRootPart2 then
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 90000
    bodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000)
    bodyGyro.CFrame = humanoidRootPart2.CFrame
    bodyGyro.Parent = humanoidRootPart2
  end

  if not bodyVelocity or bodyVelocity.Parent ~= humanoidRootPart2 then
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000)
    bodyVelocity.Parent = humanoidRootPart2
  end

  humanoid5.PlatformStand = true
  bodyGyro.CFrame = currentCamera.CFrame
  local zero = Vector3.zero

  if userInputService:IsKeyDown(Enum.KeyCode.W) then
    zero = zero + currentCamera.CFrame.LookVector
  end

  if userInputService:IsKeyDown(Enum.KeyCode.S) then
    zero = zero - currentCamera.CFrame.LookVector
  end

  if userInputService:IsKeyDown(Enum.KeyCode.A) then
    zero = zero - currentCamera.CFrame.RightVector
  end

  if userInputService:IsKeyDown(Enum.KeyCode.D) then
    zero = zero + currentCamera.CFrame.RightVector
  end

  if userInputService:IsKeyDown(Enum.KeyCode.Space) then
    zero = zero + Vector3.new(0, 1, 0)
  end

  if userInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
    zero = zero - Vector3.new(0, 1, 0)
  end

  bodyVelocity.Velocity = zero.Magnitude > 0 and zero.Unit * 26 or Vector3.zero
end

local function f28(character5, getMouseLocation)
  if not character5 then
    return nil
  elseif aimSettings.BodyPart == "Head" then
    return character5:FindFirstChild("Head")
  elseif aimSettings.BodyPart == "Torso" then
    return character5:FindFirstChild("UpperTorso") or character5:FindFirstChild("Torso")
      or character5:FindFirstChild("HumanoidRootPart")
  end

  if aimSettings.BodyPart == "Closest" then
    local v47
    local huge = math.huge

    for _, value21 in ipairs(character5:GetChildren()) do
      if value21:IsA("BasePart") and value21.Transparency < 1 then
        local ok4, result3, v48 = pcall(function()
          return currentCamera:WorldToViewportPoint(value21.Position)
        end)

        if ok4 and v48 then
          local magnitude = (Vector2.new(result3.X, result3.Y) - getMouseLocation).Magnitude

          if magnitude < huge then
            v47 = value21
            huge = magnitude
          end
        end
      end
    end

    return v47
  end

  return character5:FindFirstChild("Head")
end

local function f29()
  if not currentCamera then
    return nil, nil
  end

  local v49
  local v50
  local radius = aimSettings.Radius
  local getMouseLocation2 = userInputService:GetMouseLocation()

  for _, value22 in ipairs(players:GetPlayers()) do
    if value22 ~= localPlayer then
      local flag9 = true

      if aimSettings.TeamCheck then
        pcall(function()
          if value22.Team and localPlayer.Team and value22.Team == localPlayer.Team then
            flag9 = false
          end
        end)
      end

      if flag9 then
        local character6 = value22.Character

        if character6 and character6.Parent then
          local humanoid6 = character6:FindFirstChildOfClass("Humanoid")

          if humanoid6 and humanoid6.Health > 0 then
            local v51 = f28(character6, getMouseLocation2)

            if v51 and f27(v51) then
              local ok5, result4, v52 = pcall(function()
                return currentCamera:WorldToViewportPoint(v51.Position)
              end)

              if ok5 and v52 then
                local magnitude2 = (Vector2.new(result4.X, result4.Y)
                  - getMouseLocation2).Magnitude

                if magnitude2 < radius then
                  v49 = character6
                  radius = magnitude2
                  v50 = v51
                end
              end
            end
          end
        end
      end
    end
  end

  return v49, v50
end

local flag10 = false

table.insert(list, userInputService.InputBegan:Connect(function(input9, p47)
  if p47 then
    return
  end

  if input9.UserInputType == aimSettings.AimKey and aimSettings.Enabled then
    if aimSettings.ToggleMode then
      flag10 = not flag10
    else
      flag10 = true
    end
  end

  if input9.UserInputType == Enum.UserInputType.Keyboard then
    if v1.WalkSpeedKey and input9.KeyCode == v1.WalkSpeedKey then
      v28.Toggle()
    elseif v1.FlyKey and input9.KeyCode == v1.FlyKey then
      v30.Toggle()
    elseif v1.NoclipKey and input9.KeyCode == v1.NoclipKey then
      v32.Toggle()
    end
  end
end))

table.insert(list, userInputService.InputEnded:Connect(function(input10)
  if not aimSettings.ToggleMode and input10.UserInputType == aimSettings.AimKey then
    flag10 = false
  end
end))

table.insert(list, runService.RenderStepped:Connect(function()
  esp:Update((color:Lerp(color2, (math.sin(tick() * 6) + 1) / 2)))

  if v1.NoclipEnabled then
    pcall(function()
      local character7 = localPlayer.Character

      if character7 then
        for _, value23 in ipairs(character7:GetDescendants()) do
          if value23:IsA("BasePart") and value23.CanCollide then
            value23.CanCollide = false
          end
        end
      end
    end)
  end

  pcall(function()
    if v1.WalkSpeedEnabled then
      local humanoid7 = localPlayer.Character
        and localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid7 and humanoid7.WalkSpeed ~= v1.WalkSpeedValue then
        humanoid7.WalkSpeed = v1.WalkSpeedValue
      end
    end
  end)

  makeBodyGyro()

  if not currentCamera or not currentCamera.Parent then
    currentCamera = workspaceService.CurrentCamera

    if not currentCamera then
      return
    end
  end

  if aimSettings.Enabled and flag10 then
    local v53, instance57 = f29()

    if v53 and instance57 and instance57:IsA("BasePart") then
      pcall(function()
        local cframe = currentCamera.CFrame

        currentCamera.CFrame = cframe:Lerp(CFrame.new(cframe.Position, instance57.Position), aimSettings.Smoothness >= 10 and 1 or math.clamp(
          0.015 + ((aimSettings.Smoothness - 1) / 9) ^ 2 * 0.985, 0.015, 1
        ))
      end)
    end
  end
end))

local scriptWorksJailbirdLoaded = getgenv().ScriptWorksJailbirdLoaded
getgenv().ScriptWorksJailbirdLoaded = function() end

local function f30(enabled3)
  instance11.Enabled = enabled3
end

table.insert(list, localPlayer.Chatted:Connect(function(message)
  local lower = string.lower(message)

  if lower == "/.c" then
    f30(false)
  elseif lower == "/.o" then
    f30(true)
  end
end))

table.insert(list, userInputService.InputBegan:Connect(function(input11, p48)
  if p48 then
    return
  end

  if input11.KeyCode == Enum.KeyCode.M then
    f30(not instance11.Enabled)
  end
end))

f3(
  instance10, 4.5, { Size = UDim2.fromScale(1, 1) }, Enum.EasingStyle.Sine,
  Enum.EasingDirection.InOut
)

task.wait(4.7)
flag3 = false
f3(instance5, 0.9, { ImageTransparency = 1, BackgroundTransparency = 1 }, Enum.EasingStyle.Sine)

for _, value24 in ipairs(list4) do
  f3(value24.f, 0.7, { TextTransparency = 1 })
end

f3(instance6, 0.7, { TextTransparency = 1 })
f3(instance7, 0.7, { Transparency = 1 })
f3(instance8, 0.7, { TextTransparency = 1 })
f3(instance9, 0.7, { BackgroundTransparency = 1 })
f3(instance10, 0.7, { BackgroundTransparency = 1 })

task.wait(0.95)

if not flag4 then
  return
end

instance4:Destroy()
instance11.Enabled = true

f3(instance13, 0.6, { Scale = 1 }, Enum.EasingStyle.Quint)
f3(instance16, 0.6, { GroupTransparency = 0 }, Enum.EasingStyle.Sine)

f9(true, 0.6, Enum.EasingStyle.Sine)
