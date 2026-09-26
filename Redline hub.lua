-- this is for Ghost Driver

local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local workspace = game:GetService("Workspace")
local virtualInputManager = game:GetService("VirtualInputManager")
local runService = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local httpService = game:GetService("HttpService")
local localPlayer = players.LocalPlayer
local trafficFolder = workspace:WaitForChild("TrafficFolder")
local humanoid = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild("Humanoid")
local seatPart = humanoid.SeatPart

localPlayer.CharacterAdded:Connect(function(character)
  humanoid = character:WaitForChild("Humanoid")

  humanoid.Seated:Connect(function(p1, p2)
    if p1 and p2:IsA("VehicleSeat") then
      seatPart = p2
    else
      seatPart = nil
    end
  end)
end)

humanoid.Seated:Connect(function(p3, p4)
  if p3 and p4:IsA("VehicleSeat") then
    seatPart = p4
  else
    seatPart = nil
  end
end)

local v1 = false

trafficFolder.ChildAdded:Connect(function(child)
  if not v1 then
    return
  else
    local coreHitbox = child:FindFirstChild("CoreHitbox") or child:FindFirstChild("coreHitbox")

    if coreHitbox then
      coreHitbox.Size = Vector3.new(0.05, 0.05, 0.05)
    end

    return
  end
end)

task.spawn(function()
  while true do
    task.wait()

    if seatPart == nil and humanoid and humanoid.SeatPart then
      seatPart = humanoid.SeatPart
    end

    if v1 and seatPart and seatPart.Parent then
      for key, value in pairs(seatPart.Parent:GetDescendants()) do
        if value:IsA("BasePart") then
          if value.Name == "TrafficCollisionFront" or value.Name == "TrafficCollisionRear"
            or value.Name == "TrafficCollisionLeft" or value.Name == "TrafficCollisionRight" then
            value.Size = Vector3.new(0.05, 0.05, 0.05)
          elseif value.Name == "TrafficHitboxLeft" or value.Name == "TrafficHitboxRight" then
            value.Size = Vector3.new(30, 30, 30)
          end
        end
      end
    end
  end
end)

local v2 = false
local v3 = 470
local v4 = 500
local v5

local function f1(p5, p6)
  local huge = math.huge
  local v6, position, cframe

  for key2, value2 in pairs(trafficFolder:GetChildren()) do
    if value2 ~= p5 and not v5[value2] then
      local coreHitbox2 = value2:FindFirstChild("CoreHitbox")

      local coreHitbox3 = coreHitbox2
      coreHitbox3 = coreHitbox2 or value2:FindFirstChild("coreHitbox") or value2.PrimaryPart

      if coreHitbox3 then
        local v7 = coreHitbox3.Position - p6.Position

        if p6.CFrame.LookVector:Dot(v7.Unit) > 0 then
          local magnitude = v7.Magnitude

          if magnitude < huge and magnitude <= v4 then
            v6 = value2
            huge = magnitude
            position = coreHitbox3.Position
            cframe = coreHitbox3.CFrame
          end
        end
      end
    end
  end

  return v6, position, cframe
end

local v8 = 120
local v9 = 10
local v10 = tick()
local autoFlyVelocity = nil
local autoTurnAttachment, autoTurnConstraint

local function f2()
  if autoTurnConstraint then
    autoTurnConstraint:Destroy()
    autoTurnConstraint = nil
  end

  if autoFlyVelocity then
    autoFlyVelocity:Destroy()
    autoFlyVelocity = nil
  end

  if autoTurnAttachment then
    autoTurnAttachment:Destroy()
    autoTurnAttachment = nil
  end
end

v5 = {}

local function f3(parent)
  f2()

  autoTurnAttachment = Instance.new("Attachment")
  autoTurnAttachment.Name = "AutoTurnAttachment"
  autoTurnAttachment.Parent = parent

  autoTurnConstraint = Instance.new("AngularVelocity")
  autoTurnConstraint.Name = "AutoTurnConstraint"
  autoTurnConstraint.Attachment0 = autoTurnAttachment
  autoTurnConstraint.RelativeTo = Enum.ActuatorRelativeTo.World
  autoTurnConstraint.MaxTorque = math.huge
  autoTurnConstraint.AngularVelocity = Vector3.zero
  autoTurnConstraint.Enabled = true
  autoTurnConstraint.Parent = parent

  autoFlyVelocity = Instance.new("LinearVelocity")
  autoFlyVelocity.Name = "AutoFlyVelocity"
  autoFlyVelocity.Attachment0 = autoTurnAttachment
  autoFlyVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
  autoFlyVelocity.MaxForce = math.huge
  autoFlyVelocity.VectorVelocity = Vector3.zero
  autoFlyVelocity.Enabled = true
  autoFlyVelocity.Parent = parent
end

task.spawn(function()
  local y = 0
  local unit

  while true do
    task.wait()

    if v2 and seatPart and seatPart.Parent then
      local parent2 = seatPart.Parent
      local primaryPart = parent2.PrimaryPart or parent2:FindFirstChildWhichIsA("BasePart")

      if primaryPart then
        primaryPart.Anchored = false

        if not autoTurnAttachment or autoTurnAttachment.Parent ~= primaryPart then
          f3(primaryPart)
          y = primaryPart.Position.Y

          for index, value3 in ipairs(parent2:GetDescendants()) do
            if value3:IsA("BasePart") then
              value3.CanCollide = false
            end
          end
        end

        if tick() - v10 >= v8 then
          autoTurnConstraint.AngularVelocity = Vector3.zero
          autoFlyVelocity.VectorVelocity = Vector3.zero

          primaryPart.AssemblyLinearVelocity = Vector3.zero
          primaryPart.AssemblyAngularVelocity = Vector3.zero

          local v11 = tick()

          while tick() - v11 < v9 and v2 do
            autoFlyVelocity.VectorVelocity = Vector3.zero

            primaryPart.AssemblyLinearVelocity = Vector3.zero
            primaryPart.AssemblyAngularVelocity = Vector3.zero

            task.wait()
          end

          v10 = tick()
          table.clear(v5)
        else
          local v12, v13, v14 = f1(parent2, primaryPart)

          if not v12 or not v13 or not v14 then
            table.clear(v5)
            autoTurnConstraint.AngularVelocity = Vector3.zero
            autoFlyVelocity.VectorVelocity = Vector3.new(0, (y - primaryPart.Position.Y) * 5, 0)
          else
            local v15 = v13 - primaryPart.Position
            local vector = Vector3.new(v15.X, 0, v15.Z)

            if vector.Magnitude > 0 then
              unit = vector.Unit
            else
              unit = primaryPart.CFrame.LookVector
            end

            primaryPart.CFrame = CFrame.new(primaryPart.Position, primaryPart.Position + unit)

            autoFlyVelocity.VectorVelocity = unit * v3
              + Vector3.new(0, (y - primaryPart.Position.Y) * 5, 0)

            y = v13.Y

            if (v13 - primaryPart.Position).Magnitude < 25 then
              v5[v12] = true
            end
          end
        end
      end
    else
      if seatPart and seatPart.Parent then
        local parent3 = seatPart.Parent
        local primaryPart2 = parent3.PrimaryPart

        local basePart = primaryPart2
        basePart = primaryPart2 or parent3:FindFirstChildWhichIsA("BasePart")

        if basePart then
          basePart.Anchored = false
        end
      end

      f2()
    end
  end
end)

local v16 = false
local v17 = 20
local v18 = tick()

task.spawn(function()
  while true do
    task.wait(1)

    if v16 then
      if tick() - v18 >= v17 then
        virtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        print("YouAreAnIdiot!")
        task.wait(0.05)
        virtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
        print("HA HA HAHA HAHAHA!")
        v18 = tick()
      end
    else
      v18 = tick()
    end
  end
end)

local redlinesHub = Instance.new("ScreenGui")
redlinesHub.Name = "RedlinesHub"
redlinesHub.ResetOnSpawn = false
redlinesHub.IgnoreGuiInset = true
redlinesHub.Parent = coreGui:FindFirstChild("RobloxGui") or coreGui

local splashFrame = Instance.new("Frame")
splashFrame.Name = "SplashFrame"
splashFrame.Size = UDim2.new(1, 0, 1, 0)
splashFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
splashFrame.ZIndex = 100
splashFrame.Parent = redlinesHub

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 250)
frame.Position = UDim2.new(0.5, -200, 0.5, -125)
frame.BackgroundTransparency = 1
frame.ZIndex = 101
frame.Parent = splashFrame

local imageLabel = Instance.new("ImageLabel")
imageLabel.Size = UDim2.new(0, 120, 0, 120)
imageLabel.Position = UDim2.new(0.5, -60, 0.2, -60)
imageLabel.BackgroundTransparency = 1
imageLabel.Image = "rbxassetid://252246910"
imageLabel.ImageColor3 = Color3.fromRGB(255, 30, 60)
imageLabel.ImageTransparency = 0.2
imageLabel.ZIndex = 102
imageLabel.Parent = frame

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 0, 50)
textLabel.Position = UDim2.new(0, 0, 0.45, 0)
textLabel.Text = "<font color=\"#FF1E3C\">REDLINES</font> HUB"
textLabel.RichText = true
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextSize = 38
textLabel.Font = Enum.Font.GothamBold
textLabel.BackgroundTransparency = 1
textLabel.ZIndex = 103
textLabel.Parent = frame

local textLabel2 = Instance.new("TextLabel")
textLabel2.Size = UDim2.new(1, 0, 0, 24)
textLabel2.Position = UDim2.new(0, 0, 0.45, 45)
textLabel2.Text = "@rizzxshivam"
textLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel2.TextSize = 16
textLabel2.Font = Enum.Font.GothamBold
textLabel2.BackgroundTransparency = 1
textLabel2.ZIndex = 103
textLabel2.Parent = frame

local uiGradient = Instance.new("UIGradient")

uiGradient.Color = ColorSequence.new({
  ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 45)),
  ColorSequenceKeypoint.new(0.45, Color3.fromRGB(120, 120, 130)),
  ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
  ColorSequenceKeypoint.new(0.55, Color3.fromRGB(120, 120, 130)),
  ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 45)),
})

uiGradient.Offset = Vector2.new(-1, 0)
uiGradient.Rotation = 15
uiGradient.Parent = textLabel2

local frame2 = Instance.new("Frame")
frame2.Size = UDim2.new(0, 260, 0, 4)
frame2.Position = UDim2.new(0.5, -130, 0.85, 0)
frame2.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
frame2.BorderSizePixel = 0
frame2.ZIndex = 103
frame2.Parent = frame

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(1, 0)
uiCorner.Parent = frame2

local frame3 = Instance.new("Frame")
frame3.Size = UDim2.new(0, 0, 1, 0)
frame3.BackgroundColor3 = Color3.fromRGB(255, 30, 60)
frame3.BorderSizePixel = 0
frame3.ZIndex = 104
frame3.Parent = frame2

local uiCorner2 = Instance.new("UICorner")
uiCorner2.CornerRadius = UDim.new(1, 0)
uiCorner2.Parent = frame3

task.spawn(function()
  local create = tweenService:Create(uiGradient, TweenInfo.new(
    2.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true
  ), { Offset = Vector2.new(1, 0) })

  create:Play()

  tweenService:Create(imageLabel, TweenInfo.new(
    1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true
  ), {
    Size = UDim2.new(0, 150, 0, 150),
    Position = UDim2.new(0.5, -75, 0.2, -75),
    ImageTransparency = 0.5,
  }):Play()

  tweenService:Create(
    frame3, TweenInfo.new(2.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    { Size = UDim2.new(1, 0, 1, 0) }
  ):Play()

  task.wait(2.4)

  tweenService:Create(textLabel, TweenInfo.new(0.6), { TextTransparency = 1 }):Play()
  tweenService:Create(textLabel2, TweenInfo.new(0.6), { TextTransparency = 1 }):Play()
  tweenService:Create(imageLabel, TweenInfo.new(0.6), { ImageTransparency = 1 }):Play()
  tweenService:Create(frame2, TweenInfo.new(0.6), { BackgroundTransparency = 1 }):Play()
  tweenService:Create(frame3, TweenInfo.new(0.6), { BackgroundTransparency = 1 }):Play()

  task.wait(0.6)

  local create2 = tweenService:Create(splashFrame, TweenInfo.new(0.6), {
    BackgroundTransparency = 1,
  })

  create2:Play()

  create2.Completed:Connect(function()
    create:Cancel()
    splashFrame:Destroy()
  end)
end)

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 360, 0, 480)
mainFrame.Position = UDim2.new(0.5, -180, 0.5, -240)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = redlinesHub

local uiCorner3 = Instance.new("UICorner")
uiCorner3.CornerRadius = UDim.new(0, 10)
uiCorner3.Parent = mainFrame

local shadowGlow = Instance.new("ImageLabel")
shadowGlow.Name = "ShadowGlow"
shadowGlow.BackgroundTransparency = 1
shadowGlow.Position = UDim2.new(0, -15, 0, -15)
shadowGlow.Size = UDim2.new(1, 30, 1, 30)
shadowGlow.Image = "rbxassetid://252246910"
shadowGlow.ImageColor3 = Color3.fromRGB(255, 30, 60)
shadowGlow.ImageTransparency = 0.4
shadowGlow.ScaleType = Enum.ScaleType.Slice
shadowGlow.SliceCenter = Rect.new(24, 24, 276, 276)
shadowGlow.ZIndex = 0
shadowGlow.Parent = mainFrame

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 55)
header.BackgroundTransparency = 1
header.Parent = mainFrame

local textLabel3 = Instance.new("TextLabel")
textLabel3.Size = UDim2.new(0.5, 0, 0, 25)
textLabel3.Position = UDim2.new(0, 15, 0, 10)
textLabel3.Text = "<font color=\"#FF1E3C\">REDLINES</font> HUB"
textLabel3.RichText = true
textLabel3.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel3.TextSize = 20
textLabel3.Font = Enum.Font.GothamBold
textLabel3.TextXAlignment = Enum.TextXAlignment.Left
textLabel3.BackgroundTransparency = 1
textLabel3.Parent = header

local textLabel4 = Instance.new("TextLabel")
textLabel4.Size = UDim2.new(0.5, 0, 0, 15)
textLabel4.Position = UDim2.new(0, 15, 0, 34)
textLabel4.Text = "discord: @rizzxshivam"
textLabel4.TextColor3 = Color3.fromRGB(150, 150, 150)
textLabel4.TextSize = 12
textLabel4.Font = Enum.Font.GothamMedium
textLabel4.TextXAlignment = Enum.TextXAlignment.Left
textLabel4.BackgroundTransparency = 1
textLabel4.Parent = header

local textButton = Instance.new("TextButton")
textButton.Size = UDim2.new(0, 30, 0, 30)
textButton.Position = UDim2.new(1, -40, 0, 12)
textButton.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
textButton.Text = "-"
textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton.Font = Enum.Font.GothamBold
textButton.TextSize = 18
textButton.Parent = header

local uiCorner4 = Instance.new("UICorner")
uiCorner4.CornerRadius = UDim.new(0, 6)
uiCorner4.Parent = textButton

local textButton2 = Instance.new("TextButton")
textButton2.Size = UDim2.new(0, 56, 0, 30)
textButton2.Position = UDim2.new(1, -102, 0, 12)
textButton2.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
textButton2.Text = "Insert"
textButton2.TextColor3 = Color3.fromRGB(200, 200, 200)
textButton2.Font = Enum.Font.GothamSemibold
textButton2.TextSize = 12
textButton2.Parent = header

local uiCorner5 = Instance.new("UICorner")
uiCorner5.CornerRadius = UDim.new(0, 6)
uiCorner5.Parent = textButton2

local container = Instance.new("ScrollingFrame")
container.Name = "Container"
container.Size = UDim2.new(1, -30, 0, 410)
container.Position = UDim2.new(0, 15, 0, 58)
container.BackgroundTransparency = 1
container.BorderSizePixel = 0
container.ClipsDescendants = true
container.ScrollBarThickness = 4
container.ScrollBarImageColor3 = Color3.fromRGB(255, 30, 60)
container.Parent = mainFrame

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0, 10)
uiListLayout.Parent = container

uiListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
  container.CanvasSize = UDim2.new(0, 0, 0, uiListLayout.AbsoluteContentSize.Y + 10)
end)

local keyContainer = Instance.new("Frame")
keyContainer.Name = "KeyContainer"
keyContainer.Size = UDim2.new(1, -30, 0, 410)
keyContainer.Position = UDim2.new(0, 15, 0, 58)
keyContainer.BackgroundTransparency = 1
keyContainer.ClipsDescendants = true
keyContainer.Parent = mainFrame

local uiListLayout2 = Instance.new("UIListLayout")
uiListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout2.Padding = UDim.new(0, 12)
uiListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiListLayout2.Parent = keyContainer

container.Visible = false
local v19 = false

textButton.MouseButton1Click:Connect(function()
  v19 = not v19
  local udim = v19 and UDim2.new(0, 360, 0, 55) or UDim2.new(0, 360, 0, 480)
  textButton.Text = v19 and "+" or "-"

  tweenService:Create(
    mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    { Size = udim }
  ):Play()
end)

local v20 = {}

local function f4(p7)
  if v20[p7] then
    return
  end

  local v21 = {
    bgTransparency = nil,
    textTransparency = nil,
    imageTransparency = nil,
    scrollbarTransparency = nil,
  }

  pcall(function() v21.bgTransparency = p7.BackgroundTransparency end)
  pcall(function() v21.textTransparency = p7.TextTransparency end)
  pcall(function() v21.imageTransparency = p7.ImageTransparency end)
  pcall(function() v21.scrollbarTransparency = p7.ScrollBarImageTransparency end)

  v20[p7] = v21
end

local v22 = true
local v23 = false
local f5

local function f6()
  if v23 then
    return
  end

  v23 = true
  v22 = not v22

  if v22 then
    mainFrame.Visible = true
  end

  f5(mainFrame, not v22, 0.35)

  for index2, value4 in ipairs(mainFrame:GetDescendants()) do
    local v24 = value4
    local visible = true

    if not pcall(function() visible = v24.Visible end) or visible then
      f5(v24, not v22, 0.35)
    end
  end

  task.wait(0.35)

  if not v22 then
    mainFrame.Visible = false
  end

  v23 = false
end

function f5(p8, p9, p10)
  f4(p8)
  local v25 = v20[p8]
  local v26 = {}

  pcall(function()
    if v25.textTransparency then
      v26.TextTransparency = p9 and 1 or v25.textTransparency
    end
  end)

  pcall(function()
    if v25.imageTransparency then
      v26.ImageTransparency = p9 and 1 or v25.imageTransparency
    end
  end)

  pcall(function()
    if v25.scrollbarTransparency then
      v26.ScrollBarImageTransparency = p9 and 1 or v25.scrollbarTransparency
    end
  end)

  if next(v26) then
    tweenService:Create(
      p8, TweenInfo.new(p10, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), v26
    ):Play()
  end
end

textButton2.MouseButton1Click:Connect(f6)

local textLabel5 = Instance.new("TextLabel")
textLabel5.Size = UDim2.new(1, 0, 0, 40)
textLabel5.Text = "KEY SYSTEM"
textLabel5.TextColor3 = Color3.fromRGB(255, 30, 60)
textLabel5.Font = Enum.Font.GothamBold
textLabel5.TextSize = 18
textLabel5.BackgroundTransparency = 1
textLabel5.Parent = keyContainer

local frame4 = Instance.new("Frame")
frame4.Size = UDim2.new(1, 0, 0, 42)
frame4.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
frame4.Parent = keyContainer

local uiCorner6 = Instance.new("UICorner")
uiCorner6.CornerRadius = UDim.new(0, 8)
uiCorner6.Parent = frame4

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -20, 1, 0)
textBox.Position = UDim2.new(0, 10, 0, 0)
textBox.PlaceholderText = "Enter Key Here..."
textBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
textBox.Text = ""
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.Font = Enum.Font.GothamSemibold
textBox.TextSize = 13
textBox.BackgroundTransparency = 1
textBox.ClearTextOnFocus = false
textBox.Parent = frame4

local textLabel6 = Instance.new("TextLabel")
textLabel6.Size = UDim2.new(1, 0, 0, 20)
textLabel6.Text = "Ask @rizzxshivam on Discord for a key (ITS FREE and NO ADS!!!)"
textLabel6.TextColor3 = Color3.fromRGB(150, 150, 150)
textLabel6.Font = Enum.Font.GothamMedium
textLabel6.TextScaled = true
textLabel6.BackgroundTransparency = 1
textLabel6.Parent = keyContainer

local textLabel7 = Instance.new("TextLabel")
textLabel7.Size = UDim2.new(1, 0, 0, 20)
textLabel7.Text = "Its recommended to not change the sliders (except Forward Speed)"
textLabel7.TextColor3 = Color3.fromRGB(150, 150, 150)
textLabel7.Font = Enum.Font.GothamMedium
textLabel7.TextScaled = true
textLabel7.BackgroundTransparency = 1
textLabel7.Parent = keyContainer

local frame5 = Instance.new("Frame")
frame5.Size = UDim2.new(1, 0, 0, 40)
frame5.BackgroundColor3 = Color3.fromRGB(255, 30, 60)
frame5.Parent = keyContainer

local uiCorner7 = Instance.new("UICorner")
uiCorner7.CornerRadius = UDim.new(0, 8)
uiCorner7.Parent = frame5

local textButton3 = Instance.new("TextButton")
textButton3.Size = UDim2.new(1, 0, 1, 0)
textButton3.BackgroundTransparency = 1
textButton3.Text = "Submit Key"
textButton3.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton3.Font = Enum.Font.GothamBold
textButton3.TextSize = 14
textButton3.Parent = frame5

local textLabel8 = Instance.new("TextLabel")
textLabel8.Size = UDim2.new(1, 0, 0, 20)
textLabel8.Text = ""
textLabel8.TextColor3 = Color3.fromRGB(255, 50, 50)
textLabel8.Font = Enum.Font.GothamSemibold
textLabel8.TextSize = 12
textLabel8.BackgroundTransparency = 1
textLabel8.Parent = keyContainer

textButton3.MouseButton1Click:Connect(function()
  local v27 = string.gsub(textBox.Text, "^%s*(.-)%s*$", "%1")

  textLabel8.TextColor3 = Color3.fromRGB(255, 255, 255)
  textLabel8.Text = "Checking key..."

  task.wait(1)

  task.spawn(function()
    local v28, v29 = pcall(function()
      return game:HttpGet("https://pastebin.com/raw/mz5HQtbP")
    end)

    if v28 then
      local v30 = string.match(v29, localPlayer.Name .. "%s*=%s*([%w_]+)")

      if v30 and v27 == v30 then
        textLabel8.TextColor3 = Color3.fromRGB(50, 255, 50)
        textLabel8.Text = "Key Correct! Welcome " .. localPlayer.Name .. "!"

        task.wait(1)
        keyContainer.Visible = false
        container.Visible = true
      else
        textLabel8.TextColor3 = Color3.fromRGB(255, 50, 50)
        textLabel8.Text = "Invalid Key for " .. localPlayer.Name .. "!"
      end
    else
      textLabel8.TextColor3 = Color3.fromRGB(255, 50, 50)
      textLabel8.Text = "Failed to fetch key data!"
    end
  end)
end)

local function f7(text, p11, fn)
  local frame6 = Instance.new("Frame")
  frame6.Size = UDim2.new(1, -8, 0, 40)
  frame6.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
  frame6.Parent = container

  local uiCorner8 = Instance.new("UICorner")
  uiCorner8.CornerRadius = UDim.new(0, 8)
  uiCorner8.Parent = frame6

  local textLabel9 = Instance.new("TextLabel")
  textLabel9.Size = UDim2.new(0.7, 0, 1, 0)
  textLabel9.Position = UDim2.new(0, 12, 0, 0)
  textLabel9.Text = text
  textLabel9.TextColor3 = Color3.fromRGB(220, 220, 220)
  textLabel9.Font = Enum.Font.GothamSemibold
  textLabel9.TextSize = 13
  textLabel9.TextXAlignment = Enum.TextXAlignment.Left
  textLabel9.BackgroundTransparency = 1
  textLabel9.Parent = frame6

  local textButton4 = Instance.new("TextButton")
  textButton4.Size = UDim2.new(0, 44, 0, 22)
  textButton4.Position = UDim2.new(1, -54, 0.5, -11)

  textButton4.BackgroundColor3 = p11 and Color3.fromRGB(255, 30, 60)
    or Color3.fromRGB(40, 40, 45)

  textButton4.Text = ""
  textButton4.AutoButtonColor = false
  textButton4.Parent = frame6

  local uiCorner9 = Instance.new("UICorner")
  uiCorner9.CornerRadius = UDim.new(1, 0)
  uiCorner9.Parent = textButton4

  local frame7 = Instance.new("Frame")
  frame7.Size = UDim2.new(0, 16, 0, 16)
  frame7.Position = p11 and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
  frame7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  frame7.Parent = textButton4

  local uiCorner10 = Instance.new("UICorner")
  uiCorner10.CornerRadius = UDim.new(1, 0)
  uiCorner10.Parent = frame7

  local v31 = p11

  textButton4.MouseButton1Click:Connect(function()
    v31 = not v31
    local color = v31 and Color3.fromRGB(255, 30, 60) or Color3.fromRGB(40, 40, 45)
    local udim2 = v31 and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)

    tweenService:Create(textButton4, TweenInfo.new(0.2), { BackgroundColor3 = color }):Play()
    tweenService:Create(frame7, TweenInfo.new(0.2), { Position = udim2 }):Play()

    fn(v31)
  end)
end

local v32 = false

local function f8(text2, p12, p13, p14, p15, fn2)
  local frame8 = Instance.new("Frame")
  frame8.Size = UDim2.new(1, -8, 0, 48)
  frame8.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
  frame8.Parent = container

  local uiCorner11 = Instance.new("UICorner")
  uiCorner11.CornerRadius = UDim.new(0, 8)
  uiCorner11.Parent = frame8

  local textLabel10 = Instance.new("TextLabel")
  textLabel10.Size = UDim2.new(0.6, 0, 0, 20)
  textLabel10.Position = UDim2.new(0, 12, 0, 4)
  textLabel10.Text = text2
  textLabel10.TextColor3 = Color3.fromRGB(220, 220, 220)
  textLabel10.Font = Enum.Font.GothamSemibold
  textLabel10.TextSize = 12
  textLabel10.TextXAlignment = Enum.TextXAlignment.Left
  textLabel10.BackgroundTransparency = 1
  textLabel10.Parent = frame8

  local textLabel11 = Instance.new("TextLabel")
  textLabel11.Size = UDim2.new(0.3, 0, 0, 20)
  textLabel11.Position = UDim2.new(0.7, -12, 0, 4)
  textLabel11.Text = tostring(p14)
  textLabel11.TextColor3 = Color3.fromRGB(255, 30, 60)
  textLabel11.Font = Enum.Font.GothamBold
  textLabel11.TextSize = 12
  textLabel11.TextXAlignment = Enum.TextXAlignment.Right
  textLabel11.BackgroundTransparency = 1
  textLabel11.Parent = frame8

  local frame9 = Instance.new("Frame")
  frame9.Size = UDim2.new(1, -24, 0, 5)
  frame9.Position = UDim2.new(0, 12, 0, 32)
  frame9.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
  frame9.Parent = frame8

  local uiCorner12 = Instance.new("UICorner")
  uiCorner12.CornerRadius = UDim.new(1, 0)
  uiCorner12.Parent = frame9

  local frame10 = Instance.new("Frame")
  frame10.Size = UDim2.new((p14 - p12) / (p13 - p12), 0, 1, 0)
  frame10.BackgroundColor3 = Color3.fromRGB(255, 30, 60)
  frame10.Parent = frame9

  local uiCorner13 = Instance.new("UICorner")
  uiCorner13.CornerRadius = UDim.new(1, 0)
  uiCorner13.Parent = frame10

  local v33 = false

  local function f9(p16)
    local v34 = math.clamp(
      (p16.Position.X - frame9.AbsolutePosition.X) / frame9.AbsoluteSize.X, 0, 1
    )

    local v35 = p15 or 1
    local v36 = math.clamp(math.round((p12 + (p13 - p12) * v34) / v35) * v35, p12, p13)
    frame10.Size = UDim2.new((v36 - p12) / (p13 - p12), 0, 1, 0)
    textLabel11.Text = tostring(v36)
    fn2(v36)
  end

  frame8.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
      or input.UserInputType == Enum.UserInputType.Touch then
      v33 = true
      v32 = true
      f9(input)
    end
  end)

  userInputService.InputEnded:Connect(function(input2)
    if input2.UserInputType == Enum.UserInputType.MouseButton1
      or input2.UserInputType == Enum.UserInputType.Touch then
      v33 = false
      v32 = false
    end
  end)

  userInputService.InputChanged:Connect(function(input3)
    if v33
      and (input3.UserInputType == Enum.UserInputType.MouseMovement
        or input3.UserInputType == Enum.UserInputType.Touch) then
      f9(input3)
    end
  end)
end

f7("Traffic Magic", false, function(p17) v1 = p17 end)

f7("AutoFarm Driving", false, function(p18)
  v2 = p18

  if p18 then
    v10 = tick()
  end
end)

f7("Anti AFK (Fixes Money Glitch)", false, function(p19) v16 = p19 end)
f7("3D Rendering", true, function(p20) runService:Set3dRenderingEnabled(p20) end)

f8("Forward Speed", 100, 470, 470, 5, function(p21) v3 = p21 end)
f8("Target Range", 50, 2000, 500, 25, function(p22) v4 = p22 end)
f8("AFK Delay (s)", 20, 1200, 20, 5, function(p23) v17 = p23 end)
f8("Pause Interval (s)", 10, 600, 120, 5, function(p24) v8 = p24 end)
f8("Pause Duration (s)", 5, 60, 10, 1, function(p25) v9 = p25 end)

local v37, position2, position3

header.InputBegan:Connect(function(input4)
  if input4.UserInputType == Enum.UserInputType.MouseButton1 and not v32 then
    v37 = true
    position2 = input4.Position
    position3 = mainFrame.Position
  end
end)

local v38

header.InputChanged:Connect(function(input5)
  if input5.UserInputType == Enum.UserInputType.MouseMovement then
    v38 = input5
  end
end)

userInputService.InputChanged:Connect(function(input6)
  if input6 == v38 and v37 and not v32 then
    local v39 = input6.Position - position2

    tweenService:Create(mainFrame, TweenInfo.new(0.05), {
      Position = UDim2.new(
        position3.X.Scale, position3.X.Offset + v39.X, position3.Y.Scale,
        position3.Y.Offset + v39.Y
      ),
    }):Play()
  end
end)

userInputService.InputEnded:Connect(function(input7)
  if input7.UserInputType == Enum.UserInputType.MouseButton1 then
    v37 = false
  end
end)

userInputService.InputBegan:Connect(function(input8, p26)
  if input8.KeyCode == Enum.KeyCode.Insert then
    f6()
  end
end)
