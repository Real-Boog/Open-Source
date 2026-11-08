-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf

local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local workspaceService = game:GetService("Workspace")
local localPlayer = players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

local bicycleKeySystem = Instance.new("ScreenGui")
bicycleKeySystem.Name = "BicycleKeySystem"
bicycleKeySystem.ResetOnSpawn = false
bicycleKeySystem.IgnoreGuiInset = true
bicycleKeySystem.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 380, 0, 280)
frame.Position = UDim2.new(0.5, -190, 0.5, -140)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = bicycleKeySystem

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = frame

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 0, 50)
textLabel.BackgroundTransparency = 1
textLabel.Text = "Bicycle Hub Key System"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.Font = Enum.Font.GothamBold
textLabel.TextSize = 24
textLabel.Parent = frame

local textLabel2 = Instance.new("TextLabel")
textLabel2.Size = UDim2.new(0.85, 0, 0, 30)
textLabel2.Position = UDim2.new(0.075, 0, 0.22, 0)
textLabel2.BackgroundTransparency = 1
textLabel2.Text = "Join Discord for key"
textLabel2.TextColor3 = Color3.fromRGB(100, 200, 255)
textLabel2.Font = Enum.Font.GothamSemibold
textLabel2.TextSize = 16
textLabel2.Parent = frame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.85, 0, 0, 45)
textBox.Position = UDim2.new(0.075, 0, 0.34, 0)
textBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
textBox.PlaceholderText = "Enter Key..."
textBox.Text = ""
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 16
textBox.ClearTextOnFocus = false
textBox.Parent = frame

local uiCorner2 = Instance.new("UICorner")
uiCorner2.CornerRadius = UDim.new(0, 8)
uiCorner2.Parent = textBox

local textButton = Instance.new("TextButton")
textButton.Size = UDim2.new(0.85, 0, 0, 45)
textButton.Position = UDim2.new(0.075, 0, 0.52, 0)
textButton.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
textButton.Text = "VERIFY"
textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton.Font = Enum.Font.GothamBold
textButton.TextSize = 16
textButton.Parent = frame

local uiCorner3 = Instance.new("UICorner")
uiCorner3.CornerRadius = UDim.new(0, 8)
uiCorner3.Parent = textButton

local textButton2 = Instance.new("TextButton")
textButton2.Size = UDim2.new(0.85, 0, 0, 45)
textButton2.Position = UDim2.new(0.075, 0, 0.7, 0)
textButton2.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
textButton2.Text = "Discord Link"
textButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton2.Font = Enum.Font.GothamBold
textButton2.TextSize = 16
textButton2.Parent = frame

local uiCorner4 = Instance.new("UICorner")
uiCorner4.CornerRadius = UDim.new(0, 8)
uiCorner4.Parent = textButton2

local textLabel3 = Instance.new("TextLabel")
textLabel3.Size = UDim2.new(1, 0, 0, 30)
textLabel3.Position = UDim2.new(0, 0, 0.88, 0)
textLabel3.BackgroundTransparency = 1
textLabel3.Text = "Enter your key (CRACKED) to continue"
textLabel3.TextColor3 = Color3.fromRGB(180, 180, 180)
textLabel3.Font = Enum.Font.Gotham
textLabel3.TextSize = 14
textLabel3.TextXAlignment = Enum.TextXAlignment.Center
textLabel3.Parent = frame

local function f1(p1)
  if setclipboard then
    setclipboard(p1)
  end

  if toclipboard then
    toclipboard(p1)
  end

  if syn and syn.toast then
    syn.toast("Copied to clipboard!")
    setclipboard(p1)
  end
end

textButton2.MouseButton1Click:Connect(function()
  f1("https://discord.gg/pAfq65sShf")

  textLabel3.Text = "Discord link copied!"
  textLabel3.TextColor3 = Color3.fromRGB(100, 255, 150)

  task.wait(2)

  textLabel3.Text = "Enter your key to continue"
  textLabel3.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

textButton.MouseButton1Click:Connect(function()
  local gsub = textBox.Text:gsub("%s+", "")

  local bicycleHubUI, frame2, frame3, f2, v1, v2, position, position2, v3, f3, f4, f5, list, v4,
    f6, textLabel4, textButton3, textBox2, textButton4, textBox3, textButton5, textBox4,
    textButton6, textButton7, textButton8, textButton9, v5, map, f7, f8, f9, f10, connect, v6,
    v7, connect2, v8, v9, v10, v11, list2, f11, f12, f13, f14, v12, v13, f15, f16, f17, v14,
    connect3, f18, f19, f20, list3, v15, waitForChild

  if gsub:upper() == "CRACKED" then
    textLabel3.Text = "Correct key! Loading..."
    textLabel3.TextColor3 = Color3.fromRGB(100, 255, 100)

    textButton.Text = "LOADING..."
    task.wait(1)

    tweenService:Create(frame, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
      Size = UDim2.new(0, 0, 0, 0),
      Position = UDim2.new(0.5, 0, 0.5, 0),
    }):Play()

    task.wait(0.8)
    bicycleKeySystem:Destroy()

    bicycleHubUI = Instance.new("ScreenGui")
    bicycleHubUI.Name = "BicycleHubUI"
    bicycleHubUI.ResetOnSpawn = false
    bicycleHubUI.IgnoreGuiInset = true
    bicycleHubUI.ZIndexBehavior = Enum.ZIndexBehavior.Global
    bicycleHubUI.Parent = playerGui

    frame2 = Instance.new("Frame")
    frame2.Size = UDim2.new(0, 60, 0, 60)
    frame2.Position = UDim2.new(0.05, 0, 0.4, 0)
    frame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    frame2.BackgroundTransparency = 0.15
    frame2.BorderSizePixel = 0
    frame2.Active = true
    frame2.Draggable = true
    frame2.Parent = bicycleHubUI

    local uiCorner5 = Instance.new("UICorner")
    uiCorner5.CornerRadius = UDim.new(1, 0)
    uiCorner5.Parent = frame2

    local textLabel5 = Instance.new("TextLabel")
    textLabel5.Size = UDim2.new(1, 0, 1, 0)
    textLabel5.BackgroundTransparency = 1
    textLabel5.Text = "🚴‍♂️"
    textLabel5.TextScaled = true
    textLabel5.Font = Enum.Font.GothamBold
    textLabel5.TextColor3 = Color3.fromRGB(0, 0, 0)
    textLabel5.Parent = frame2

    frame3 = Instance.new("Frame")
    frame3.Size = UDim2.new(0, 450, 0, 320)
    frame3.Position = UDim2.new(0.3, 0, 0.3, 0)
    frame3.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame3.BorderSizePixel = 0
    frame3.Visible = false
    frame3.Active = true
    frame3.Parent = bicycleHubUI

    local uiCorner6 = Instance.new("UICorner")
    uiCorner6.CornerRadius = UDim.new(0, 12)
    uiCorner6.Parent = frame3

    local frame4 = Instance.new("Frame")
    frame4.Size = UDim2.new(1, 0, 0, 36)
    frame4.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame4.BorderSizePixel = 0
    frame4.Parent = frame3

    local uiCorner7 = Instance.new("UICorner")
    uiCorner7.CornerRadius = UDim.new(0, 12)
    uiCorner7.Parent = frame4

    local textLabel6 = Instance.new("TextLabel")
    textLabel6.Size = UDim2.new(1, -70, 1, 0)
    textLabel6.Position = UDim2.new(0, 10, 0, 0)
    textLabel6.BackgroundTransparency = 1
    textLabel6.Text = "Bicycle Hub 🚴‍♂️"
    textLabel6.Font = Enum.Font.GothamBold
    textLabel6.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel6.TextSize = 20
    textLabel6.TextXAlignment = Enum.TextXAlignment.Left
    textLabel6.Parent = frame4

    local textButton10 = Instance.new("TextButton")
    textButton10.Size = UDim2.new(0, 24, 0, 24)
    textButton10.Position = UDim2.new(1, -50, 0.5, -12)
    textButton10.BackgroundTransparency = 1
    textButton10.Text = "-"
    textButton10.TextSize = 26
    textButton10.Font = Enum.Font.GothamBold
    textButton10.TextColor3 = Color3.fromRGB(255, 255, 255)
    textButton10.Parent = frame4

    local textButton11 = Instance.new("TextButton")
    textButton11.Size = UDim2.new(0, 24, 0, 24)
    textButton11.Position = UDim2.new(1, -25, 0.5, -12)
    textButton11.BackgroundTransparency = 1
    textButton11.Text = "×"
    textButton11.TextSize = 24
    textButton11.Font = Enum.Font.GothamBold
    textButton11.TextColor3 = Color3.fromRGB(255, 75, 75)
    textButton11.Parent = frame4

    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Size = UDim2.new(1, -20, 1, -50)
    scrollingFrame.Position = UDim2.new(0, 10, 0, 45)
    scrollingFrame.BackgroundTransparency = 1
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
    scrollingFrame.ScrollBarThickness = 6
    scrollingFrame.Parent = frame3

    local frame5 = Instance.new("Frame")
    frame5.Size = UDim2.new(1, 0, 1, 0)
    frame5.BackgroundTransparency = 1
    frame5.Parent = scrollingFrame

    function f2(p2, p3, p4)
      local new = TweenInfo.new
      local sine = Enum.EasingStyle.Sine
      tweenService:Create(p2, new(p4 or 0.3, sine, Enum.EasingDirection.Out), p3):Play()
    end

    v1 = nil
    v2 = nil
    position = nil
    position2 = nil

    frame4.InputBegan:Connect(function(input)
      if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        v1 = true
        position = input.Position
        position2 = frame3.Position

        input.Changed:Connect(function()
          if input.UserInputState == Enum.UserInputState.End then
            v1 = false
          end
        end)
      end
    end)

    frame4.InputChanged:Connect(function(input2)
      if input2.UserInputType == Enum.UserInputType.MouseMovement
        or input2.UserInputType == Enum.UserInputType.Touch then
        v2 = input2
      end
    end)

    userInputService.InputChanged:Connect(function(input3)
      if input3 == v2 and v1 then
        local v16 = input3.Position - position

        frame3.Position = UDim2.new(
          position2.X.Scale, position2.X.Offset + v16.X, position2.Y.Scale,
          position2.Y.Offset + v16.Y
        )
      end
    end)

    v3 = false

    function f3()
      v3 = true

      frame3.Visible = true
      frame3.Size = UDim2.new(0, 200, 0, 80)
      frame3.BackgroundTransparency = 1

      f2(frame3, { Size = UDim2.new(0, 450, 0, 320), BackgroundTransparency = 0 }, 0.35)
    end

    function f4()
      v3 = false
      f2(frame3, { Size = UDim2.new(0, 200, 0, 80), BackgroundTransparency = 1 }, 0.3)
      task.wait(0.3)
      frame3.Visible = false
    end

    textButton11.MouseButton1Click:Connect(function()
      f2(frame3, { BackgroundTransparency = 1 }, 0.2)
      f2(frame2, { BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0) }, 0.3)

      task.wait(0.3)
      bicycleHubUI:Destroy()
    end)

    textButton10.MouseButton1Click:Connect(f4)

    function f5()
      if not v3 then
        f3()
      else
        f4()
      end
    end

    frame2.InputBegan:Connect(function(input4)
      if input4.UserInputType == Enum.UserInputType.MouseButton1
        or input4.UserInputType == Enum.UserInputType.Touch then
        f5()
      end
    end)

    frame2.MouseEnter:Connect(function()
      f2(frame2, { BackgroundColor3 = Color3.fromRGB(230, 230, 230) }, 0.2)
    end)

    frame2.MouseLeave:Connect(function()
      f2(frame2, { BackgroundColor3 = Color3.fromRGB(255, 255, 255) }, 0.2)
    end)

    local mainTabFrame = Instance.new("Frame")
    mainTabFrame.Name = "MainTabFrame"
    mainTabFrame.Size = UDim2.new(1, 0, 1, -40)
    mainTabFrame.Position = UDim2.new(0, 0, 0, 40)
    mainTabFrame.BackgroundTransparency = 1
    mainTabFrame.Parent = frame5

    local playersTabFrame = Instance.new("Frame")
    playersTabFrame.Name = "PlayersTabFrame"
    playersTabFrame.Size = UDim2.new(1, 0, 1, -40)
    playersTabFrame.Position = UDim2.new(0, 0, 0, 40)
    playersTabFrame.BackgroundTransparency = 1
    playersTabFrame.Visible = false
    playersTabFrame.Parent = frame5

    local frame6 = Instance.new("Frame")
    frame6.Size = UDim2.new(1, -20, 0, 30)
    frame6.Position = UDim2.new(0, 10, 0, 0)
    frame6.BackgroundTransparency = 1
    frame6.Parent = frame5

    list = {
      { Name = "Main", Frame = mainTabFrame }, { Name = "Players", Frame = playersTabFrame },
    }

    v4 = {}

    function f6(p5)
      for _, value in ipairs(list) do
        local v17 = v4[value.Name]

        if v17 then
          v17.BackgroundColor3 = value.Name == p5 and Color3.fromRGB(70, 130, 255)
            or Color3.fromRGB(45, 45, 45)
        end

        if value.Frame then
          value.Frame.Visible = value.Name == p5
        end
      end
    end

    for index, value2 in ipairs(list) do
      local textButton12 = Instance.new("TextButton")
      textButton12.Size = UDim2.new(0, 100, 0, 30)
      textButton12.Position = UDim2.new(0, (index - 1) * 105, 0, 0)
      textButton12.Text = value2.Name
      textButton12.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
      textButton12.TextColor3 = Color3.fromRGB(255, 255, 255)
      textButton12.Font = Enum.Font.GothamBold
      textButton12.TextSize = 14
      textButton12.Parent = frame6

      local uiCorner8 = Instance.new("UICorner")
      uiCorner8.CornerRadius = UDim.new(0, 6)
      uiCorner8.Parent = textButton12

      v4[value2.Name] = textButton12
      textButton12.MouseButton1Click:Connect(function() f6(value2.Name) end)
    end

    f6("Main")

    textLabel4 = Instance.new("TextLabel")
    textLabel4.Size = UDim2.new(1, -20, 0, 20)
    textLabel4.Position = UDim2.new(0, 10, 0, 410)
    textLabel4.BackgroundTransparency = 1
    textLabel4.TextColor3 = Color3.fromRGB(200, 200, 200)
    textLabel4.Font = Enum.Font.Gotham
    textLabel4.TextSize = 12
    textLabel4.TextXAlignment = Enum.TextXAlignment.Left
    textLabel4.Parent = mainTabFrame

    local frame7 = Instance.new("Frame")
    frame7.Size = UDim2.new(1, -20, 0, 40)
    frame7.Position = UDim2.new(0, 10, 0, 10)
    frame7.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame7.Parent = mainTabFrame

    local uiCorner9 = Instance.new("UICorner")
    uiCorner9.CornerRadius = UDim.new(0, 8)
    uiCorner9.Parent = frame7

    local textLabel7 = Instance.new("TextLabel")
    textLabel7.Size = UDim2.new(0.7, 0, 1, 0)
    textLabel7.Position = UDim2.new(0, 10, 0, 0)
    textLabel7.BackgroundTransparency = 1
    textLabel7.Text = "Auto fast attack"
    textLabel7.Font = Enum.Font.Gotham
    textLabel7.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel7.TextSize = 16
    textLabel7.TextXAlignment = Enum.TextXAlignment.Left
    textLabel7.Parent = frame7

    textButton3 = Instance.new("TextButton")
    textButton3.Size = UDim2.new(0.25, 0, 0.8, 0)
    textButton3.Position = UDim2.new(0.7, 0, 0.1, 0)
    textButton3.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    textButton3.Text = "OFF"
    textButton3.Font = Enum.Font.GothamBold
    textButton3.TextColor3 = Color3.fromRGB(255, 255, 255)
    textButton3.TextSize = 14
    textButton3.Parent = frame7

    local uiCorner10 = Instance.new("UICorner")
    uiCorner10.CornerRadius = UDim.new(0, 6)
    uiCorner10.Parent = textButton3

    local frame8 = Instance.new("Frame")
    frame8.Size = UDim2.new(1, -20, 0, 40)
    frame8.Position = UDim2.new(0, 10, 0, 10)
    frame8.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame8.Parent = playersTabFrame

    local uiCorner11 = Instance.new("UICorner")
    uiCorner11.CornerRadius = UDim.new(0, 8)
    uiCorner11.Parent = frame8

    local textLabel8 = Instance.new("TextLabel")
    textLabel8.Size = UDim2.new(0.4, 0, 1, 0)
    textLabel8.Position = UDim2.new(0, 10, 0, 0)
    textLabel8.BackgroundTransparency = 1
    textLabel8.Text = "Jump Power:"
    textLabel8.Font = Enum.Font.Gotham
    textLabel8.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel8.TextSize = 16
    textLabel8.TextXAlignment = Enum.TextXAlignment.Left
    textLabel8.Parent = frame8

    textBox2 = Instance.new("TextBox")
    textBox2.Size = UDim2.new(0.55, 0, 0.8, 0)
    textBox2.Position = UDim2.new(0.4, 0, 0.1, 0)
    textBox2.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    textBox2.Text = ""
    textBox2.Font = Enum.Font.Gotham
    textBox2.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox2.TextSize = 14
    textBox2.Parent = frame8

    local uiCorner12 = Instance.new("UICorner")
    uiCorner12.CornerRadius = UDim.new(0, 6)
    uiCorner12.Parent = textBox2

    local frame9 = Instance.new("Frame")
    frame9.Size = UDim2.new(1, -20, 0, 40)
    frame9.Position = UDim2.new(0, 10, 0, 60)
    frame9.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame9.Parent = playersTabFrame

    local uiCorner13 = Instance.new("UICorner")
    uiCorner13.CornerRadius = UDim.new(0, 8)
    uiCorner13.Parent = frame9

    local textLabel9 = Instance.new("TextLabel")
    textLabel9.Size = UDim2.new(0.7, 0, 1, 0)
    textLabel9.Position = UDim2.new(0, 10, 0, 0)
    textLabel9.BackgroundTransparency = 1
    textLabel9.Text = "Loop Jump Power"
    textLabel9.Font = Enum.Font.Gotham
    textLabel9.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel9.TextSize = 16
    textLabel9.TextXAlignment = Enum.TextXAlignment.Left
    textLabel9.Parent = frame9

    textButton4 = Instance.new("TextButton")
    textButton4.Size = UDim2.new(0.25, 0, 0.8, 0)
    textButton4.Position = UDim2.new(0.7, 0, 0.1, 0)
    textButton4.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    textButton4.Text = "OFF"
    textButton4.Font = Enum.Font.GothamBold
    textButton4.TextColor3 = Color3.fromRGB(255, 255, 255)
    textButton4.TextSize = 14
    textButton4.Parent = frame9

    local uiCorner14 = Instance.new("UICorner")
    uiCorner14.CornerRadius = UDim.new(0, 6)
    uiCorner14.Parent = textButton4

    local frame10 = Instance.new("Frame")
    frame10.Size = UDim2.new(1, -20, 0, 40)
    frame10.Position = UDim2.new(0, 10, 0, 110)
    frame10.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame10.Parent = playersTabFrame

    local uiCorner15 = Instance.new("UICorner")
    uiCorner15.CornerRadius = UDim.new(0, 8)
    uiCorner15.Parent = frame10

    local textLabel10 = Instance.new("TextLabel")
    textLabel10.Size = UDim2.new(0.4, 0, 1, 0)
    textLabel10.Position = UDim2.new(0, 10, 0, 0)
    textLabel10.BackgroundTransparency = 1
    textLabel10.Text = "Loop Walkspeed:"
    textLabel10.Font = Enum.Font.Gotham
    textLabel10.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel10.TextSize = 16
    textLabel10.TextXAlignment = Enum.TextXAlignment.Left
    textLabel10.Parent = frame10

    textBox3 = Instance.new("TextBox")
    textBox3.Size = UDim2.new(0.55, 0, 0.8, 0)
    textBox3.Position = UDim2.new(0.4, 0, 0.1, 0)
    textBox3.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    textBox3.Text = ""
    textBox3.Font = Enum.Font.Gotham
    textBox3.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox3.TextSize = 14
    textBox3.Parent = frame10

    local uiCorner16 = Instance.new("UICorner")
    uiCorner16.CornerRadius = UDim.new(0, 6)
    uiCorner16.Parent = textBox3

    local frame11 = Instance.new("Frame")
    frame11.Size = UDim2.new(1, -20, 0, 40)
    frame11.Position = UDim2.new(0, 10, 0, 160)
    frame11.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame11.Parent = playersTabFrame

    local uiCorner17 = Instance.new("UICorner")
    uiCorner17.CornerRadius = UDim.new(0, 8)
    uiCorner17.Parent = frame11

    local textLabel11 = Instance.new("TextLabel")
    textLabel11.Size = UDim2.new(0.7, 0, 1, 0)
    textLabel11.Position = UDim2.new(0, 10, 0, 0)
    textLabel11.BackgroundTransparency = 1
    textLabel11.Text = "Loop Walkspeed"
    textLabel11.Font = Enum.Font.Gotham
    textLabel11.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel11.TextSize = 16
    textLabel11.TextXAlignment = Enum.TextXAlignment.Left
    textLabel11.Parent = frame11

    textButton5 = Instance.new("TextButton")
    textButton5.Size = UDim2.new(0.25, 0, 0.8, 0)
    textButton5.Position = UDim2.new(0.7, 0, 0.1, 0)
    textButton5.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    textButton5.Text = "OFF"
    textButton5.Font = Enum.Font.GothamBold
    textButton5.TextColor3 = Color3.fromRGB(255, 255, 255)
    textButton5.TextSize = 14
    textButton5.Parent = frame11

    local uiCorner18 = Instance.new("UICorner")
    uiCorner18.CornerRadius = UDim.new(0, 6)
    uiCorner18.Parent = textButton5

    local frame12 = Instance.new("Frame")
    frame12.Size = UDim2.new(1, -20, 0, 40)
    frame12.Position = UDim2.new(0, 10, 0, 210)
    frame12.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame12.Parent = playersTabFrame

    local uiCorner19 = Instance.new("UICorner")
    uiCorner19.CornerRadius = UDim.new(0, 8)
    uiCorner19.Parent = frame12

    local textLabel12 = Instance.new("TextLabel")
    textLabel12.Size = UDim2.new(0.4, 0, 1, 0)
    textLabel12.Position = UDim2.new(0, 10, 0, 0)
    textLabel12.BackgroundTransparency = 1
    textLabel12.Text = "Fly Speed:"
    textLabel12.Font = Enum.Font.Gotham
    textLabel12.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel12.TextSize = 16
    textLabel12.TextXAlignment = Enum.TextXAlignment.Left
    textLabel12.Parent = frame12

    textBox4 = Instance.new("TextBox")
    textBox4.Size = UDim2.new(0.55, 0, 0.8, 0)
    textBox4.Position = UDim2.new(0.4, 0, 0.1, 0)
    textBox4.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    textBox4.Text = "1"
    textBox4.Font = Enum.Font.Gotham
    textBox4.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox4.TextSize = 14
    textBox4.Parent = frame12

    local uiCorner20 = Instance.new("UICorner")
    uiCorner20.CornerRadius = UDim.new(0, 6)
    uiCorner20.Parent = textBox4

    local frame13 = Instance.new("Frame")
    frame13.Size = UDim2.new(1, -20, 0, 40)
    frame13.Position = UDim2.new(0, 10, 0, 260)
    frame13.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame13.Parent = playersTabFrame

    local uiCorner21 = Instance.new("UICorner")
    uiCorner21.CornerRadius = UDim.new(0, 8)
    uiCorner21.Parent = frame13

    local textLabel13 = Instance.new("TextLabel")
    textLabel13.Size = UDim2.new(0.7, 0, 1, 0)
    textLabel13.Position = UDim2.new(0, 10, 0, 0)
    textLabel13.BackgroundTransparency = 1
    textLabel13.Text = "Fly"
    textLabel13.Font = Enum.Font.Gotham
    textLabel13.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel13.TextSize = 16
    textLabel13.TextXAlignment = Enum.TextXAlignment.Left
    textLabel13.Parent = frame13

    textButton6 = Instance.new("TextButton")
    textButton6.Size = UDim2.new(0.25, 0, 0.8, 0)
    textButton6.Position = UDim2.new(0.7, 0, 0.1, 0)
    textButton6.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    textButton6.Text = "OFF"
    textButton6.Font = Enum.Font.GothamBold
    textButton6.TextColor3 = Color3.fromRGB(255, 255, 255)
    textButton6.TextSize = 14
    textButton6.Parent = frame13

    local uiCorner22 = Instance.new("UICorner")
    uiCorner22.CornerRadius = UDim.new(0, 6)
    uiCorner22.Parent = textButton6

    local frame14 = Instance.new("Frame")
    frame14.Size = UDim2.new(1, -20, 0, 40)
    frame14.Position = UDim2.new(0, 10, 0, 310)
    frame14.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame14.Parent = playersTabFrame

    local uiCorner23 = Instance.new("UICorner")
    uiCorner23.CornerRadius = UDim.new(0, 8)
    uiCorner23.Parent = frame14

    local textLabel14 = Instance.new("TextLabel")
    textLabel14.Size = UDim2.new(0.7, 0, 1, 0)
    textLabel14.Position = UDim2.new(0, 10, 0, 0)
    textLabel14.BackgroundTransparency = 1
    textLabel14.Text = "Walk Fling"
    textLabel14.Font = Enum.Font.Gotham
    textLabel14.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel14.TextSize = 16
    textLabel14.TextXAlignment = Enum.TextXAlignment.Left
    textLabel14.Parent = frame14

    textButton7 = Instance.new("TextButton")
    textButton7.Size = UDim2.new(0.25, 0, 0.8, 0)
    textButton7.Position = UDim2.new(0.7, 0, 0.1, 0)
    textButton7.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    textButton7.Text = "OFF"
    textButton7.Font = Enum.Font.GothamBold
    textButton7.TextColor3 = Color3.fromRGB(255, 255, 255)
    textButton7.TextSize = 14
    textButton7.Parent = frame14

    local uiCorner24 = Instance.new("UICorner")
    uiCorner24.CornerRadius = UDim.new(0, 6)
    uiCorner24.Parent = textButton7

    local frame15 = Instance.new("Frame")
    frame15.Size = UDim2.new(1, -20, 0, 40)
    frame15.Position = UDim2.new(0, 10, 0, 360)
    frame15.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame15.Parent = playersTabFrame

    local uiCorner25 = Instance.new("UICorner")
    uiCorner25.CornerRadius = UDim.new(0, 8)
    uiCorner25.Parent = frame15

    local textLabel15 = Instance.new("TextLabel")
    textLabel15.Size = UDim2.new(0.7, 0, 1, 0)
    textLabel15.Position = UDim2.new(0, 10, 0, 0)
    textLabel15.BackgroundTransparency = 1
    textLabel15.Text = "No Clip"
    textLabel15.Font = Enum.Font.Gotham
    textLabel15.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel15.TextSize = 16
    textLabel15.TextXAlignment = Enum.TextXAlignment.Left
    textLabel15.Parent = frame15

    textButton8 = Instance.new("TextButton")
    textButton8.Size = UDim2.new(0.25, 0, 0.8, 0)
    textButton8.Position = UDim2.new(0.7, 0, 0.1, 0)
    textButton8.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    textButton8.Text = "OFF"
    textButton8.Font = Enum.Font.GothamBold
    textButton8.TextColor3 = Color3.fromRGB(255, 255, 255)
    textButton8.TextSize = 14
    textButton8.Parent = frame15

    local uiCorner26 = Instance.new("UICorner")
    uiCorner26.CornerRadius = UDim.new(0, 6)
    uiCorner26.Parent = textButton8

    local frame16 = Instance.new("Frame")
    frame16.Size = UDim2.new(1, -20, 0, 40)
    frame16.Position = UDim2.new(0, 10, 0, 410)
    frame16.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame16.Parent = playersTabFrame

    local uiCorner27 = Instance.new("UICorner")
    uiCorner27.CornerRadius = UDim.new(0, 8)
    uiCorner27.Parent = frame16

    local textLabel16 = Instance.new("TextLabel")
    textLabel16.Size = UDim2.new(0.7, 0, 1, 0)
    textLabel16.Position = UDim2.new(0, 10, 0, 0)
    textLabel16.BackgroundTransparency = 1
    textLabel16.Text = "ESP"
    textLabel16.Font = Enum.Font.Gotham
    textLabel16.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel16.TextSize = 16
    textLabel16.TextXAlignment = Enum.TextXAlignment.Left
    textLabel16.Parent = frame16

    textButton9 = Instance.new("TextButton")
    textButton9.Size = UDim2.new(0.25, 0, 0.8, 0)
    textButton9.Position = UDim2.new(0.7, 0, 0.1, 0)
    textButton9.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    textButton9.Text = "OFF"
    textButton9.Font = Enum.Font.GothamBold
    textButton9.TextColor3 = Color3.fromRGB(255, 255, 255)
    textButton9.TextSize = 14
    textButton9.Parent = frame16

    local uiCorner28 = Instance.new("UICorner")
    uiCorner28.CornerRadius = UDim.new(0, 6)
    uiCorner28.Parent = textButton9

    v5 = false
    map = {}

    function f7(key)
      if map[key] then
        return
      end

      local character = key.Character

      if not character then
        return
      end

      local head = character:FindFirstChild("Head")

      if not head or not character:FindFirstChildOfClass("Humanoid") then
        return
      end

      local billboardGui = Instance.new("BillboardGui")
      billboardGui.Name = "ESP_" .. key.Name
      billboardGui.Adornee = head
      billboardGui.Size = UDim2.new(0, 200, 0, 50)
      billboardGui.StudsOffset = Vector3.new(0, 2, 0)
      billboardGui.AlwaysOnTop = true
      billboardGui.Parent = localPlayer:WaitForChild("PlayerGui")

      local textLabel17 = Instance.new("TextLabel")
      textLabel17.Parent = billboardGui
      textLabel17.Size = UDim2.new(1, 0, 1, 0)
      textLabel17.BackgroundTransparency = 1
      textLabel17.Font = Enum.Font.GothamBold
      textLabel17.TextSize = 16
      textLabel17.TextStrokeTransparency = 0.5
      textLabel17.TextColor3 = key.TeamColor.Color

      local connect4

      connect4 = runService.RenderStepped:Connect(function()
        if not (key.Character and key.Character.Parent)
          or not key.Character:FindFirstChild("Head")
          or not key.Character:FindFirstChildOfClass("Humanoid")
          or key.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then
          if connect4 and connect4.Connected then
            connect4:Disconnect()
          end

          if billboardGui and billboardGui.Parent then
            billboardGui:Destroy()
          end

          map[key] = nil
          return
        end

        local head2 = key.Character:FindFirstChild("Head")
        local character2 = key.Character
        local v18 = not head2
        local humanoid = character2:FindFirstChildOfClass("Humanoid")

        if v18 or not humanoid then
          if connect4 and connect4.Connected then
            connect4:Disconnect()
          end

          if billboardGui and billboardGui.Parent then
            billboardGui:Destroy()
          end

          map[key] = nil
          return
        end

        local humanoidRootPart = localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        local magnitude = humanoidRootPart
            and (humanoidRootPart.Position - head2.Position).Magnitude
          or 0

        textLabel17.Text = string.format(
          "%s | HP: %d | Dist: %.1f", key.Name, math.floor(humanoid.Health), magnitude
        )
      end)

      map[key] = { Billboard = billboardGui, Connection = connect4 }
    end

    function f8()
      for _, value3 in pairs(map) do
        if value3.Billboard and value3.Billboard.Parent then
          value3.Billboard:Destroy()
        end

        if value3.Connection and value3.Connection.Connected then
          value3.Connection:Disconnect()
        end
      end

      map = {}
    end

    function f9()
      for _, value4 in ipairs(players:GetPlayers()) do
        if value4 ~= localPlayer then
          if not map[value4] then
            f7(value4)
          end
        end
      end
    end

    task.spawn(function()
      while true do
        if v5 then
          f9()
        end

        task.wait(5)
      end
    end)

    function f10(p6)
      v5 = p6

      if v5 then
        textButton9.Text = "ON"
        f2(textButton9, { BackgroundColor3 = Color3.fromRGB(60, 200, 80) }, 0.2)
        f9()

        players.PlayerAdded:Connect(function(player)
          if v5 and player ~= localPlayer then
            player.CharacterAdded:Connect(function() f7(player) end)
          end
        end)
      else
        textButton9.Text = "OFF"
        f2(textButton9, { BackgroundColor3 = Color3.fromRGB(200, 60, 60) }, 0.2)
        f8()
      end
    end

    connect = nil
    v6 = nil
    v7 = false

    textBox2.FocusLost:Connect(function(p7)
      local v19 = tonumber(textBox2.Text)

      if v19 and v19 >= 0 then
        v6 = v19

        local humanoid2 = localPlayer.Character
          and localPlayer.Character:FindFirstChildOfClass("Humanoid")

        if humanoid2 then
          humanoid2.JumpPower = v19
        end
      end
    end)

    textButton4.MouseButton1Click:Connect(function()
      v7 = not v7

      if v7 then
        if not v6 or v6 < 0 then
          v7 = false
          textLabel4.Text = "Enter a valid jump power first!"
          return
        end

        if not connect or not connect.Connected then
          connect = runService.Heartbeat:Connect(function()
            local humanoid3 = localPlayer.Character
              and localPlayer.Character:FindFirstChildOfClass("Humanoid")

            if humanoid3 then
              humanoid3.JumpPower = v6
            end
          end)
        end

        textButton4.Text = "ON"
        f2(textButton4, { BackgroundColor3 = Color3.fromRGB(60, 200, 60) }, 0.2)
        textLabel4.Text = "JumpPower Loop: ON (" .. v6 .. ")"
      else
        if connect and connect.Connected then
          connect:Disconnect()
        end

        connect = nil
        textButton4.Text = "OFF"
        f2(textButton4, { BackgroundColor3 = Color3.fromRGB(200, 60, 60) }, 0.2)
        textLabel4.Text = "JumpPower Loop: OFF"
      end
    end)

    connect2 = nil
    v8 = nil
    v9 = false

    textBox3.FocusLost:Connect(function(p8)
      local v20 = tonumber(textBox3.Text)

      if v20 and v20 > 0 then
        v8 = v20
      end
    end)

    textButton5.MouseButton1Click:Connect(function()
      v9 = not v9

      if v9 then
        if not v8 or v8 <= 0 then
          v9 = false
          textLabel4.Text = "Enter a valid walkspeed first!"
          return
        end

        if not connect2 or not connect2.Connected then
          connect2 = runService.Heartbeat:Connect(function()
            local humanoid4 = localPlayer.Character
              and localPlayer.Character:FindFirstChildOfClass("Humanoid")

            if humanoid4 then
              humanoid4.WalkSpeed = v8
            end
          end)
        end

        textButton5.Text = "ON"
        f2(textButton5, { BackgroundColor3 = Color3.fromRGB(60, 200, 60) }, 0.2)
        textLabel4.Text = "Walkspeed Loop: ON (" .. v8 .. ")"
      else
        if connect2 and connect2.Connected then
          connect2:Disconnect()
        end

        connect2 = nil
        textButton5.Text = "OFF"
        f2(textButton5, { BackgroundColor3 = Color3.fromRGB(200, 60, 60) }, 0.2)
        textLabel4.Text = "Walkspeed Loop: OFF"
      end
    end)

    v10 = 80
    v11 = false
    list2 = {}

    function f11()
      for _, value5 in ipairs(list2) do
        if typeof(value5) == "RBXScriptConnection" then
          value5:Disconnect()
        end
      end

      table.clear(list2)
    end

    function f12(instance, canCollide)
      for _, value6 in ipairs(instance:GetDescendants()) do
        if value6:IsA("BasePart") then
          value6.CanCollide = canCollide
        end
      end
    end

    function f13()
      v11 = false
      f11()
      local character3 = localPlayer.Character

      if not character3 then
        return
      end

      local humanoid5 = character3:FindFirstChildOfClass("Humanoid")
      local humanoidRootPart2 = character3:FindFirstChild("HumanoidRootPart")

      if humanoid5 then
        humanoid5.PlatformStand = false
        humanoid5.AutoRotate = true
      end

      if humanoidRootPart2 then
        for _, value7 in ipairs(humanoidRootPart2:GetChildren()) do
          if value7:IsA("AlignOrientation") or value7:IsA("LinearVelocity")
            or value7:IsA("BodyGyro") or value7:IsA("BodyVelocity") then
            value7:Destroy()
          end
        end
      end

      f12(character3, true)
    end

    function f14()
      if v11 then
        return
      end

      local character4 = localPlayer.Character or localPlayer.CharacterAdded:Wait()
      local humanoid6 = character4:WaitForChild("Humanoid")
      local humanoidRootPart3 = character4:WaitForChild("HumanoidRootPart")
      v11 = true

      humanoid6.PlatformStand = true
      humanoid6.AutoRotate = false

      f12(character4, false)

      local attachment = Instance.new("Attachment")
      attachment.Parent = humanoidRootPart3

      local alignOrientation = Instance.new("AlignOrientation")
      alignOrientation.Attachment0 = attachment
      alignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
      alignOrientation.MaxTorque = math.huge
      alignOrientation.Responsiveness = 200
      alignOrientation.Parent = humanoidRootPart3

      local linearVelocity = Instance.new("LinearVelocity")
      linearVelocity.Attachment0 = attachment
      linearVelocity.MaxForce = math.huge
      linearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
      linearVelocity.VectorVelocity = Vector3.zero
      linearVelocity.Parent = humanoidRootPart3

      local ok, controlModule = pcall(
        require,
        (localPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
      )

      if not ok then
        warn("ControlModule failed - fly disabled")
        return
      end

      table.insert(list2, localPlayer.CharacterAdded:Connect(function()
        if v11 then
          task.wait(0.5)
          f13()
          f14()
        end
      end))

      table.insert(list2, runService.RenderStepped:Connect(function()
        if not v11 then
          return
        end

        local cframe = workspace.CurrentCamera.CFrame
        local getMoveVector = controlModule:GetMoveVector()
        local lookVector = cframe.LookVector
        local rightVector = cframe.RightVector
        local x = getMoveVector.X
        local z = getMoveVector.Z
        local v21 = v10
        linearVelocity.VectorVelocity = (rightVector * x + lookVector * -z) * v21
        alignOrientation.CFrame = cframe - cframe.Position
      end))
    end

    textBox4.FocusLost:Connect(function()
      local v22 = tonumber(textBox4.Text)

      if v22 then
        v10 = v22 * 50
        textLabel4.Text = "Fly speed set to " .. tostring(v22)
      else
        textLabel4.Text = "Fly: Invalid speed."
      end
    end)

    textButton6.MouseButton1Click:Connect(function()
      if textButton6.Text == "OFF" then
        textButton6.Text = "ON"
        textButton6.BackgroundColor3 = Color3.fromRGB(60, 200, 60)

        f14()
        textLabel4.Text = "Fly: ON"
      else
        textButton6.Text = "OFF"
        textButton6.BackgroundColor3 = Color3.fromRGB(200, 60, 60)

        f13()
        textLabel4.Text = "Fly: OFF"
      end
    end)

    v12 = false
    v13 = nil

    function f15(instance2)
      return instance2:FindFirstChild("HumanoidRootPart")
    end

    function f16()
      if v13 then
        return
      end

      v12 = true

      v13 = spawn(function()
        repeat
          runService.Heartbeat:Wait()
          local character5 = localPlayer.Character
          local instance3 = f15(character5)

          while not (character5 and character5.Parent and instance3 and instance3.Parent) do
            runService.Heartbeat:Wait()
            character5 = localPlayer.Character
            instance3 = f15(character5)
          end

          local velocity = instance3.Velocity
          instance3.Velocity = velocity * 10000 + Vector3.new(0, 10000, 0)
          runService.RenderStepped:Wait()

          if character5 and character5.Parent and instance3 and instance3.Parent then
            instance3.Velocity = velocity
          end

          runService.Stepped:Wait()

          if character5 and character5.Parent and instance3 and instance3.Parent then
            instance3.Velocity = velocity + Vector3.new(0, 0.1, 0)
          end
        until not v12
      end)
    end

    function f17()
      v12 = false
      v13 = nil
    end

    textButton7.MouseButton1Click:Connect(function()
      if textButton7.Text == "OFF" then
        textButton7.Text = "ON"
        textButton7.BackgroundColor3 = Color3.fromRGB(60, 200, 60)

        f16()
        textLabel4.Text = "Walk Fling: ON"
      else
        textButton7.Text = "OFF"
        textButton7.BackgroundColor3 = Color3.fromRGB(200, 60, 60)

        f17()
        textLabel4.Text = "Walk Fling: OFF"
      end
    end)

    v14 = true
    connect3 = nil

    function f18()
      if not v14 and localPlayer.Character then
        for _, value8 in pairs(localPlayer.Character:GetDescendants()) do
          if value8:IsA("BasePart") and value8.CanCollide then
            value8.CanCollide = false
          end
        end
      end
    end

    function f19()
      v14 = false

      if not connect3 then
        connect3 = runService.Stepped:Connect(f18)
      end
    end

    function f20()
      if connect3 then
        connect3:Disconnect()
        connect3 = nil
      end

      v14 = true
    end

    textButton8.MouseButton1Click:Connect(function()
      if textButton8.Text == "OFF" then
        textButton8.Text = "ON"
        textButton8.BackgroundColor3 = Color3.fromRGB(60, 200, 60)

        f19()
        textLabel4.Text = "No Clip: ON"
      else
        textButton8.Text = "OFF"
        textButton8.BackgroundColor3 = Color3.fromRGB(200, 60, 60)

        f20()
        textLabel4.Text = "No Clip: OFF"
      end
    end)

    textButton9.MouseButton1Click:Connect(function() f10(not v5) end)

    list3 = {
      { "Lc3Hitbox", 1.3166666030884 }, { "Lc2Hitbox", 1.3166666030884 },
      { "Lc1Hitbox", 0.3088379 }, { "Roar2", 0.80000019073486 },
      { "Attack1Hitbox", 1.3166666030884 }, { "Attack2Hitbox", 1.3166666030884 },
      { "Attack3Hitbox", 1.3166666030884 }, { "Attack4Hitbox", 1.3166666030884 },
      { "Attack5Hitbox", 1.3166666030884 }, { "Attack6Hitbox", 1.3166666030884 },
    }

    v15 = false
    waitForChild = nil

    local function f21(character6)
      task.spawn(function() waitForChild = character6:WaitForChild("RemoteEvent", 5) end)
    end

    if localPlayer.Character then
      f21(localPlayer.Character)
    end

    localPlayer.CharacterAdded:Connect(f21)
    localPlayer.CharacterRemoving:Connect(function() waitForChild = nil end)

    task.spawn(function()
      while true do
        task.wait(0.05)

        if v15 and waitForChild then
          for _, value9 in ipairs(list3) do
            if not v15 then
              break
            end

            if not pcall(function() waitForChild:FireServer(unpack(value9)) end) then
              waitForChild = nil
              break
            end

            task.wait(0.02)
          end
        end
      end
    end)

    textButton3.MouseButton1Click:Connect(function()
      v15 = not v15

      if v15 then
        textButton3.Text = "ON"
        f2(textButton3, { BackgroundColor3 = Color3.fromRGB(60, 200, 80) }, 0.2)
        textLabel4.Text = "Auto Fast Attack: ON"
      else
        textButton3.Text = "OFF"
        f2(textButton3, { BackgroundColor3 = Color3.fromRGB(200, 60, 60) }, 0.2)
        textLabel4.Text = "Auto Fast Attack: OFF"
      end
    end)
  else
    textLabel3.Text = "Wrong key!"
    textLabel3.TextColor3 = Color3.fromRGB(255, 80, 80)

    task.wait(2)

    textLabel3.Text = "Enter your key to continue"
    textLabel3.TextColor3 = Color3.fromRGB(180, 180, 180)
  end
end)

textBox.FocusLost:Connect(function(p9)
  if p9 then
    textButton.MouseButton1Click:Fire()
  end
end)
