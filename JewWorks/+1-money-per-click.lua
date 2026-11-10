-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf

local coreGui = game:GetService("CoreGui")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local localPlayer = players.LocalPlayer
local vector = Vector3.new(3035.26, 7.62, -6015.3)

if getgenv().ScriptWorksAutoFarmerLoaded then
  pcall(getgenv().ScriptWorksAutoFarmerLoaded)
end

local scriptWorksAutoFarmer = Instance.new("ScreenGui")
scriptWorksAutoFarmer.Name = "ScriptWorksAutoFarmer"
scriptWorksAutoFarmer.ResetOnSpawn = false
scriptWorksAutoFarmer.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function() scriptWorksAutoFarmer.Parent = gethui and gethui() or coreGui end)

if not scriptWorksAutoFarmer.Parent then
  scriptWorksAutoFarmer.Parent = localPlayer:WaitForChild("PlayerGui")
end

local function f1()
end

getgenv().ScriptWorksAutoFarmerLoaded = function()
  f1()
  pcall(function() scriptWorksAutoFarmer:Destroy() end)
end

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.fromOffset(200, 110)
mainFrame.Position = UDim2.new(0.5, -100, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Parent = scriptWorksAutoFarmer

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local instance = Instance.new("UIStroke", mainFrame)
instance.Color = Color3.fromRGB(45, 45, 60)
instance.Thickness = 1.5

local instance2 = Instance.new("TextLabel", mainFrame)
instance2.Size = UDim2.new(1, 0, 0, 32)
instance2.BackgroundTransparency = 1
instance2.Text = "ScriptWorks Farmer"
instance2.TextColor3 = Color3.fromRGB(240, 240, 245)
instance2.TextSize = 13
instance2.Font = Enum.Font.GothamBold

local instance3 = Instance.new("TextButton", mainFrame)
instance3.Size = UDim2.new(1, -24, 0, 48)
instance3.Position = UDim2.fromOffset(12, 38)
instance3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
instance3.Text = "START"
instance3.TextColor3 = Color3.fromRGB(255, 255, 255)
instance3.TextSize = 16
instance3.Font = Enum.Font.GothamBold
instance3.AutoButtonColor = false

Instance.new("UICorner", instance3).CornerRadius = UDim.new(0, 8)

local instance4 = Instance.new("UIStroke", instance3)
instance4.Color = Color3.fromRGB(255, 255, 255)
instance4.Thickness = 2

local flag = false

runService.RenderStepped:Connect(function()
  if flag then
    local v1 = tick()
    local color = Color3.fromHSV(v1 * 3 % 1, 1, 1)
    instance3.BackgroundColor3 = color
    instance4.Color = color
  else
    instance3.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    instance4.Color = Color3.fromRGB(80, 80, 100)
  end
end)

local scriptWorksSafePlatform

local function makePart(vector2)
  if scriptWorksSafePlatform then
    pcall(function() scriptWorksSafePlatform:Destroy() end)
  end

  scriptWorksSafePlatform = Instance.new("Part")
  scriptWorksSafePlatform.Name = "ScriptWorksSafePlatform"
  scriptWorksSafePlatform.Size = Vector3.new(6000, 6, 6000)
  scriptWorksSafePlatform.Position = Vector3.new(vector2.X, vector2.Y - 10, vector2.Z)
  scriptWorksSafePlatform.Anchored = true
  scriptWorksSafePlatform.CanCollide = true
  scriptWorksSafePlatform.Transparency = 0.5
  scriptWorksSafePlatform.Color = Color3.fromRGB(30, 30, 40)
  scriptWorksSafePlatform.Parent = workspace
end

local flag2 = false
local connect

local function f2()
  flag2 = true
  makePart(vector)

  task.spawn(function()
    while flag2 do
      pcall(function()
        local findFirstChild = replicatedStorage:FindFirstChild("EvolveRemote", true)

        if findFirstChild and findFirstChild:IsA("RemoteEvent") then
          for i = 1, 15 do
            findFirstChild:FireServer(5)
          end
        end

        local findFirstChild2 = replicatedStorage:FindFirstChild("RebirthRemote", true)

        if findFirstChild2 and findFirstChild2:IsA("RemoteEvent") then
          for j = 1, 15 do
            findFirstChild2:FireServer(14)
          end
        end
      end)

      task.wait(0.05)
    end
  end)

  local v2 = tick()
  local v3 = 0

  connect = runService.RenderStepped:Connect(function()
    if not flag2 then
      return
    end

    pcall(function()
      local character = localPlayer.Character
      local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
      local humanoid = character and character:FindFirstChildOfClass("Humanoid")

      if humanoidRootPart and humanoid then
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
        humanoid.WalkSpeed = 1200

        if tick() - v3 >= 2 then
          v3 = tick()
          humanoidRootPart.CFrame = CFrame.new(vector)
        else
          local v4 = (tick() - v2) * 80
          local v5 = math.cos(v4)
          local v6 = math.sin(v4)
          humanoidRootPart.CFrame = CFrame.new(vector + Vector3.new(v5 * 2500, 0, v6 * 2500))
        end
      end
    end)
  end)
end

function f1()
  flag2 = false

  if connect then
    connect:Disconnect()
  end

  if scriptWorksSafePlatform then
    pcall(function() scriptWorksSafePlatform:Destroy() end)
    scriptWorksSafePlatform = nil
  end

  pcall(function()
    local humanoid2 = localPlayer.Character
      and localPlayer.Character:FindFirstChildOfClass("Humanoid")

    if humanoid2 then
      humanoid2.WalkSpeed = 16
    end
  end)
end

instance3.MouseButton1Click:Connect(function()
  flag = not flag

  if flag then
    instance3.Text = "STOP"
    f2()
  else
    instance3.Text = "START"
    f1()
  end
end)

userInputService.InputBegan:Connect(function(input, p1)
  if p1 then
    return
  end

  if input.KeyCode == Enum.KeyCode.C and flag then
    flag = false
    instance3.Text = "START"
    f1()
    print("🚨 [ScriptWorks] Safety Key 'C' pressed! Farmer stopped.")
  end
end)

local inputBegan = mainFrame.InputBegan
local v7, position, position2

inputBegan:Connect(function(p2)
  if p2.UserInputType == Enum.UserInputType.MouseButton1
    or p2.UserInputType == Enum.UserInputType.Touch then
    v7 = true
    position = p2.Position
    position2 = mainFrame.Position
  end
end)

local inputChanged = mainFrame.InputChanged
local v8

inputChanged:Connect(function(p3)
  if p3.UserInputType == Enum.UserInputType.MouseMovement
    or p3.UserInputType == Enum.UserInputType.Touch then
    v8 = p3
  end
end)

userInputService.InputChanged:Connect(function(input2)
  if input2 == v8 and v7 then
    local v9 = input2.Position - position

    mainFrame.Position = UDim2.new(
      position2.X.Scale, position2.X.Offset + v9.X, position2.Y.Scale, position2.Y.Offset + v9.Y
    )
  end
end)

mainFrame.InputEnded:Connect(function(input3)
  if input3.UserInputType == Enum.UserInputType.MouseButton1
    or input3.UserInputType == Enum.UserInputType.Touch then
    v7 = false
  end
end)
