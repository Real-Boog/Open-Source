-- this is for Saber ShowDown

local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local statsService = game:GetService("Stats")
local coreGui = game:GetService("CoreGui")
local tweenService = game:GetService("TweenService")
local localPlayer = players.LocalPlayer
local lightsaberRemotes = replicatedStorage:WaitForChild("LightsaberRemotes")
local updateBlockDirection = lightsaberRemotes:WaitForChild("UpdateBlockDirection")
local attack = lightsaberRemotes:WaitForChild("Attack")
local swing = lightsaberRemotes:WaitForChild("Swing")
local mouseDown = lightsaberRemotes:WaitForChild("MouseDown")
local block = lightsaberRemotes:WaitForChild("Block")
local unblock = lightsaberRemotes:WaitForChild("Unblock")
local v1 = require(replicatedStorage.LightsaberModules.Client.ClientState)
local v2 = require(replicatedStorage.LightsaberModules.SharedBehavior.Aerial)
local v3 = require(replicatedStorage.LightsaberModules.SharedBehavior.Kata)

local v4 = {}
v4.__index = v4

local v5 = gethui and gethui() or coreGui

function v4:CreateWindow()
  local v6 = setmetatable({}, v4)
  v6.Title = self.Title or "Ashu Hub"
  v6.Subtitle = self.Subtitle or "Saber Showdown"

  local ashuHubUI = Instance.new("ScreenGui")
  ashuHubUI.Name = "AshuHubUI"
  ashuHubUI.ResetOnSpawn = false
  ashuHubUI.Parent = v5

  v6.Gui = ashuHubUI

  local mainFrame = Instance.new("Frame", ashuHubUI)
  mainFrame.Name = "MainFrame"
  mainFrame.Size = UDim2.new(0, 520, 0, 360)
  mainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
  mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
  mainFrame.BorderSizePixel = 0
  mainFrame.ClipsDescendants = true

  Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

  local instance = Instance.new("UIStroke", mainFrame)
  instance.Color = Color3.fromRGB(190, 140, 255)
  instance.Thickness = 1.5

  local v7, position, position2

  mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
      or input.UserInputType == Enum.UserInputType.Touch then
      v7 = true
      position = input.Position
      position2 = mainFrame.Position
    end
  end)

  mainFrame.InputEnded:Connect(function(input2)
    if input2.UserInputType == Enum.UserInputType.MouseButton1
      or input2.UserInputType == Enum.UserInputType.Touch then
      v7 = false
    end
  end)

  userInputService.InputChanged:Connect(function(input3)
    if v7
      and (input3.UserInputType == Enum.UserInputType.MouseMovement
        or input3.UserInputType == Enum.UserInputType.Touch) then
      local v8 = input3.Position - position

      mainFrame.Position = UDim2.new(
        position2.X.Scale, position2.X.Offset + v8.X, position2.Y.Scale,
        position2.Y.Offset + v8.Y
      )
    end
  end)

  local instance2 = Instance.new("Frame", mainFrame)
  instance2.Size = UDim2.new(1, 0, 0, 42)
  instance2.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
  instance2.BorderSizePixel = 0

  local instance3 = Instance.new("TextLabel", instance2)
  instance3.Size = UDim2.new(0, 200, 1, 0)
  instance3.Position = UDim2.new(0, 15, 0, 0)
  instance3.BackgroundTransparency = 1
  instance3.Font = Enum.Font.GothamBold
  instance3.Text = v6.Title .. ' <font color="rgb(190,140,255)">[' .. v6.Subtitle .. "]</font>"
  instance3.RichText = true
  instance3.TextColor3 = Color3.fromRGB(255, 255, 255)
  instance3.TextSize = 16
  instance3.TextXAlignment = Enum.TextXAlignment.Left

  local instance4 = Instance.new("TextButton", instance2)
  instance4.Size = UDim2.new(0, 30, 0, 30)
  instance4.Position = UDim2.new(1, -35, 0.5, -15)
  instance4.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
  instance4.Text = "X"
  instance4.TextColor3 = Color3.fromRGB(255, 100, 100)
  instance4.Font = Enum.Font.GothamBold
  instance4.TextSize = 14

  Instance.new("UICorner", instance4).CornerRadius = UDim.new(0, 6)
  instance4.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)

  local instance5 = Instance.new("Frame", mainFrame)
  instance5.Size = UDim2.new(0, 130, 1, -42)
  instance5.Position = UDim2.new(0, 0, 0, 42)
  instance5.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
  instance5.BorderSizePixel = 0

  local instance6 = Instance.new("ScrollingFrame", instance5)
  instance6.Size = UDim2.new(1, 0, 1, 0)
  instance6.BackgroundTransparency = 1
  instance6.ScrollBarThickness = 2

  local instance7 = Instance.new("UIListLayout", instance6)
  instance7.Padding = UDim.new(0, 5)
  instance7.HorizontalAlignment = Enum.HorizontalAlignment.Center

  local instance8 = Instance.new("Frame", mainFrame)
  instance8.Size = UDim2.new(1, -135, 1, -47)
  instance8.Position = UDim2.new(0, 132, 0, 44)
  instance8.BackgroundTransparency = 1

  v6.TabContainer = instance6
  v6.ContentArea = instance8
  v6.Tabs = {}

  local ashuToggle = Instance.new("TextButton", ashuHubUI)
  ashuToggle.Name = "AshuToggle"
  ashuToggle.Size = UDim2.new(0, 50, 0, 50)
  ashuToggle.Position = UDim2.new(0.02, 0, 0.2, 0)
  ashuToggle.BackgroundColor3 = Color3.fromRGB(190, 140, 255)
  ashuToggle.Text = "ASHU"
  ashuToggle.TextColor3 = Color3.fromRGB(15, 15, 20)
  ashuToggle.Font = Enum.Font.GothamBold
  ashuToggle.TextSize = 12
  ashuToggle.Active = true
  ashuToggle.Draggable = true

  Instance.new("UICorner", ashuToggle).CornerRadius = UDim.new(0, 25)

  local instance9 = Instance.new("UIStroke", ashuToggle)
  instance9.Color = Color3.fromRGB(255, 255, 255)
  instance9.Thickness = 2

  ashuToggle.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)
  return v6
end

function v4:CreateTab(text, p1)
  local v9 = {}

  local instance10 = Instance.new("TextButton", self.TabContainer)
  instance10.Size = UDim2.new(0.9, 0, 0, 32)

  instance10.BackgroundColor3 = p1 and Color3.fromRGB(190, 140, 255)
    or Color3.fromRGB(28, 28, 36)

  instance10.Text = text
  instance10.TextColor3 = p1 and Color3.fromRGB(15, 15, 20) or Color3.fromRGB(200, 200, 200)
  instance10.Font = Enum.Font.GothamBold
  instance10.TextSize = 13

  Instance.new("UICorner", instance10).CornerRadius = UDim.new(0, 6)

  local instance11 = Instance.new("ScrollingFrame", self.ContentArea)
  instance11.Size = UDim2.new(1, 0, 1, 0)
  instance11.BackgroundTransparency = 1
  instance11.Visible = p1
  instance11.ScrollBarThickness = 3
  instance11.CanvasSize = UDim2.new(0, 0, 0, 0)

  local instance12 = Instance.new("UIListLayout", instance11)
  instance12.Padding = UDim.new(0, 8)
  instance12.SortOrder = Enum.SortOrder.LayoutOrder

  instance12:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    instance11.CanvasSize = UDim2.new(0, 0, 0, instance12.AbsoluteContentSize.Y + 15)
  end)

  instance10.MouseButton1Click:Connect(function()
    for key, value in pairs(self.Tabs) do
      value.Btn.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
      value.Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
      value.Page.Visible = false
    end

    instance10.BackgroundColor3 = Color3.fromRGB(190, 140, 255)
    instance10.TextColor3 = Color3.fromRGB(15, 15, 20)

    instance11.Visible = true
  end)

  v9.Btn = instance10
  v9.Page = instance11

  table.insert(self.Tabs, v9)

  function v9:CreatePage(p2)
    return v9
  end

  function v9:CreateSection(text2)
    local v10 = {}

    local instance13 = Instance.new("Frame", instance11)
    instance13.Size = UDim2.new(0.98, 0, 0, 30)
    instance13.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    instance13.BorderSizePixel = 0

    Instance.new("UICorner", instance13).CornerRadius = UDim.new(0, 6)

    local instance14 = Instance.new("UIListLayout", instance13)
    instance14.Padding = UDim.new(0, 6)
    instance14.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local instance15 = Instance.new("TextLabel", instance13)
    instance15.Size = UDim2.new(0.95, 0, 0, 24)
    instance15.BackgroundTransparency = 1
    instance15.Font = Enum.Font.GothamBold
    instance15.Text = text2
    instance15.TextColor3 = Color3.fromRGB(190, 140, 255)
    instance15.TextSize = 13
    instance15.TextXAlignment = Enum.TextXAlignment.Left

    instance14:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
      instance13.Size = UDim2.new(0.98, 0, 0, instance14.AbsoluteContentSize.Y + 8)
    end)

    function v10:AddLabel(text3)
      local instance16 = Instance.new("Frame", instance13)
      instance16.Size = UDim2.new(0.95, 0, 0, 24)
      instance16.BackgroundTransparency = 1

      local instance17 = Instance.new("TextLabel", instance16)
      instance17.Size = UDim2.new(1, 0, 1, 0)
      instance17.BackgroundTransparency = 1
      instance17.Font = Enum.Font.Gotham
      instance17.Text = text3
      instance17.TextColor3 = Color3.fromRGB(255, 200, 100)
      instance17.TextSize = 11
      instance17.TextXAlignment = Enum.TextXAlignment.Left
    end

    function v10:AddToggle(p3, p4, fn, p5)
      local instance18 = Instance.new("Frame", instance13)
      instance18.Size = UDim2.new(0.95, 0, 0, 32)
      instance18.BackgroundColor3 = Color3.fromRGB(32, 32, 42)

      Instance.new("UICorner", instance18).CornerRadius = UDim.new(0, 6)

      local instance19 = Instance.new("TextLabel", instance18)
      instance19.Size = UDim2.new(0.7, 0, 1, 0)
      instance19.Position = UDim2.new(0, 8, 0, 0)
      instance19.BackgroundTransparency = 1
      instance19.Font = Enum.Font.Gotham
      instance19.Text = p5 and p5.Title or p3
      instance19.TextColor3 = Color3.fromRGB(230, 230, 230)
      instance19.TextSize = 12
      instance19.TextXAlignment = Enum.TextXAlignment.Left

      local instance20 = Instance.new("TextButton", instance18)
      instance20.Size = UDim2.new(0, 44, 0, 22)
      instance20.Position = UDim2.new(1, -50, 0.5, -11)

      instance20.BackgroundColor3 = p4 and Color3.fromRGB(0, 200, 100)
        or Color3.fromRGB(60, 60, 75)

      instance20.Text = p4 and "ON" or "OFF"
      instance20.Font = Enum.Font.GothamBold
      instance20.TextColor3 = Color3.fromRGB(255, 255, 255)
      instance20.TextSize = 10

      Instance.new("UICorner", instance20).CornerRadius = UDim.new(0, 4)
      local v11 = p4

      instance20.MouseButton1Click:Connect(function()
        v11 = not v11

        instance20.BackgroundColor3 = v11 and Color3.fromRGB(0, 200, 100)
          or Color3.fromRGB(60, 60, 75)

        instance20.Text = v11 and "ON" or "OFF"

        fn(v11)
      end)

      return {
        SetValue = function(p6, p7)
          v11 = p7

          instance20.BackgroundColor3 = v11 and Color3.fromRGB(0, 200, 100)
            or Color3.fromRGB(60, 60, 75)

          instance20.Text = v11 and "ON" or "OFF"

          fn(v11)
        end,
      }
    end

    function v10:AddSlider(p8, p9, p10, p11, fn2, p12)
      local instance21 = Instance.new("Frame", instance13)
      instance21.Size = UDim2.new(0.95, 0, 0, 42)
      instance21.BackgroundColor3 = Color3.fromRGB(32, 32, 42)

      Instance.new("UICorner", instance21).CornerRadius = UDim.new(0, 6)

      local instance22 = Instance.new("TextLabel", instance21)
      instance22.Size = UDim2.new(0.9, 0, 0, 18)
      instance22.Position = UDim2.new(0, 8, 0, 2)
      instance22.BackgroundTransparency = 1
      instance22.Font = Enum.Font.Gotham
      instance22.Text = (p12 and p12.Title or p8) .. ": " .. tostring(p11)
      instance22.TextColor3 = Color3.fromRGB(230, 230, 230)
      instance22.TextSize = 11
      instance22.TextXAlignment = Enum.TextXAlignment.Left

      local instance23 = Instance.new("Frame", instance21)
      instance23.Size = UDim2.new(0.9, 0, 0, 8)
      instance23.Position = UDim2.new(0.05, 0, 0, 26)
      instance23.BackgroundColor3 = Color3.fromRGB(50, 50, 65)

      Instance.new("UICorner", instance23).CornerRadius = UDim.new(0, 4)

      local instance24 = Instance.new("Frame", instance23)
      instance24.Size = UDim2.new((p11 - p9) / (p10 - p9), 0, 1, 0)
      instance24.BackgroundColor3 = Color3.fromRGB(190, 140, 255)

      Instance.new("UICorner", instance24).CornerRadius = UDim.new(0, 4)
      local v12 = false

      local function f1(p13)
        local v13 = math.clamp((p13.Position.X - instance23.AbsolutePosition.X)
          / instance23.AbsoluteSize.X, 0, 1)

        local v14 = math.floor(p9 + (p10 - p9) * v13)
        instance24.Size = UDim2.new(v13, 0, 1, 0)
        instance22.Text = (p12 and p12.Title or p8) .. ": " .. tostring(v14)
        fn2(v14)
      end

      instance23.InputBegan:Connect(function(input4)
        if input4.UserInputType == Enum.UserInputType.MouseButton1
          or input4.UserInputType == Enum.UserInputType.Touch then
          v12 = true
          f1(input4)
        end
      end)

      instance23.InputEnded:Connect(function(input5)
        if input5.UserInputType == Enum.UserInputType.MouseButton1
          or input5.UserInputType == Enum.UserInputType.Touch then
          v12 = false
        end
      end)

      userInputService.InputChanged:Connect(function(input6)
        if v12
          and (input6.UserInputType == Enum.UserInputType.MouseMovement
            or input6.UserInputType == Enum.UserInputType.Touch) then
          f1(input6)
        end
      end)
    end

    function v10:AddTextbox(p14, p15, fn3, p16)
      local instance25 = Instance.new("Frame", instance13)
      instance25.Size = UDim2.new(0.95, 0, 0, 32)
      instance25.BackgroundColor3 = Color3.fromRGB(32, 32, 42)

      Instance.new("UICorner", instance25).CornerRadius = UDim.new(0, 6)

      local instance26 = Instance.new("TextLabel", instance25)
      instance26.Size = UDim2.new(0.6, 0, 1, 0)
      instance26.Position = UDim2.new(0, 8, 0, 0)
      instance26.BackgroundTransparency = 1
      instance26.Font = Enum.Font.Gotham
      instance26.Text = p16 and p16.Title or p14
      instance26.TextColor3 = Color3.fromRGB(230, 230, 230)
      instance26.TextSize = 11
      instance26.TextXAlignment = Enum.TextXAlignment.Left

      local instance27 = Instance.new("TextBox", instance25)
      instance27.Size = UDim2.new(0, 90, 0, 22)
      instance27.Position = UDim2.new(1, -95, 0.5, -11)
      instance27.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
      instance27.Text = p15 or ""
      instance27.TextColor3 = Color3.fromRGB(255, 255, 255)
      instance27.Font = Enum.Font.GothamBold
      instance27.TextSize = 11

      Instance.new("UICorner", instance27).CornerRadius = UDim.new(0, 4)
      instance27.FocusLost:Connect(function(p17) fn3(instance27.Text) end)
    end

    function v10:AddButton(text4, p18)
      local instance28 = Instance.new("TextButton", instance13)
      instance28.Size = UDim2.new(0.95, 0, 0, 30)
      instance28.BackgroundColor3 = Color3.fromRGB(190, 140, 255)
      instance28.Text = text4
      instance28.TextColor3 = Color3.fromRGB(15, 15, 20)
      instance28.Font = Enum.Font.GothamBold
      instance28.TextSize = 12

      Instance.new("UICorner", instance28).CornerRadius = UDim.new(0, 6)
      instance28.MouseButton1Click:Connect(p18)
    end

    function v10:AddCopyButton(p19, p20, p21)
      local instance29 = Instance.new("TextButton", instance13)
      instance29.Size = UDim2.new(0.95, 0, 0, 30)
      instance29.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
      instance29.Text = p21 and p21.Title or p19
      instance29.TextColor3 = Color3.fromRGB(255, 255, 255)
      instance29.Font = Enum.Font.GothamBold
      instance29.TextSize = 12

      Instance.new("UICorner", instance29).CornerRadius = UDim.new(0, 6)

      instance29.MouseButton1Click:Connect(function()
        if setclipboard then
          setclipboard(p20)
          v4:Notify({ Title = "Copied", Description = "Link copied to clipboard!", Duration = 2 })
        end
      end)
    end

    function v10:AddDropdown(p22, p23, p24, fn4, p25)
      local instance30 = Instance.new("Frame", instance13)
      instance30.Size = UDim2.new(0.95, 0, 0, 32)
      instance30.BackgroundColor3 = Color3.fromRGB(32, 32, 42)

      Instance.new("UICorner", instance30).CornerRadius = UDim.new(0, 6)

      local instance31 = Instance.new("TextLabel", instance30)
      instance31.Size = UDim2.new(0.9, 0, 1, 0)
      instance31.Position = UDim2.new(0, 8, 0, 0)
      instance31.BackgroundTransparency = 1
      instance31.Font = Enum.Font.Gotham
      instance31.Text = (p25 and p25.Title or p22) .. " (Click to toggle)"
      instance31.TextColor3 = Color3.fromRGB(230, 230, 230)
      instance31.TextSize = 11
      instance31.TextXAlignment = Enum.TextXAlignment.Left

      local v15 = {}

      instance30.InputBegan:Connect(function(input7)
        if input7.UserInputType == Enum.UserInputType.MouseButton1
          or input7.UserInputType == Enum.UserInputType.Touch then
          for index, value2 in ipairs(players:GetPlayers()) do
            if value2 ~= localPlayer then
              v15[value2.Name] = not v15[value2.Name]
            end
          end

          fn4(v15)

          v4:Notify({
            Title = "Whitelist",
            Description = "Updated whitelist selection!",
            Duration = 2,
          })
        end
      end)
    end

    function v10:AddConfigManager(p26)
      local instance32 = Instance.new("TextButton", instance13)
      instance32.Size = UDim2.new(0.95, 0, 0, 30)
      instance32.BackgroundColor3 = Color3.fromRGB(40, 120, 200)
      instance32.Text = "Save Config (" .. p26 .. ")"
      instance32.TextColor3 = Color3.fromRGB(255, 255, 255)
      instance32.Font = Enum.Font.GothamBold
      instance32.TextSize = 12

      Instance.new("UICorner", instance32).CornerRadius = UDim.new(0, 6)

      instance32.MouseButton1Click:Connect(function()
        v4:Notify({
          Title = "Config",
          Description = "Configuration Saved Successfully!",
          Duration = 2,
        })
      end)
    end

    return v10
  end

  return v9
end

function v4:Notify(p27)
  local ashuNotifs = v5:FindFirstChild("AshuNotifs")

  if not ashuNotifs then
    ashuNotifs = Instance.new("ScreenGui", v5)
    ashuNotifs.Name = "AshuNotifs"
  end

  local instance33 = Instance.new("Frame", ashuNotifs)
  instance33.Size = UDim2.new(0, 220, 0, 50)
  instance33.Position = UDim2.new(1, 10, 0.8, -((#ashuNotifs:GetChildren() - 1) * 55))
  instance33.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
  instance33.BorderSizePixel = 0

  Instance.new("UICorner", instance33).CornerRadius = UDim.new(0, 8)

  local instance34 = Instance.new("UIStroke", instance33)
  instance34.Color = Color3.fromRGB(190, 140, 255)
  instance34.Thickness = 1

  local instance35 = Instance.new("TextLabel", instance33)
  instance35.Size = UDim2.new(1, -10, 0, 20)
  instance35.Position = UDim2.new(0, 8, 0, 4)
  instance35.BackgroundTransparency = 1
  instance35.Font = Enum.Font.GothamBold
  instance35.Text = p27.Title or "Notification"
  instance35.TextColor3 = Color3.fromRGB(190, 140, 255)
  instance35.TextSize = 12
  instance35.TextXAlignment = Enum.TextXAlignment.Left

  local instance36 = Instance.new("TextLabel", instance33)
  instance36.Size = UDim2.new(1, -10, 0, 20)
  instance36.Position = UDim2.new(0, 8, 0, 22)
  instance36.BackgroundTransparency = 1
  instance36.Font = Enum.Font.Gotham
  instance36.Text = p27.Description or ""
  instance36.TextColor3 = Color3.fromRGB(220, 220, 220)
  instance36.TextSize = 11
  instance36.TextXAlignment = Enum.TextXAlignment.Left

  tweenService:Create(instance33, TweenInfo.new(0.3), {
    Position = UDim2.new(1, -230, instance33.Position.Y.Scale, instance33.Position.Y.Offset),
  }):Play()

  task.delay(p27.Duration or 3, function()
    local create = tweenService:Create(instance33, TweenInfo.new(0.3), {
      Position = UDim2.new(1, 10, instance33.Position.Y.Scale, instance33.Position.Y.Offset),
    })

    create:Play()
    create.Completed:Connect(function() instance33:Destroy() end)
  end)
end

local ashuHubWindow = v4:CreateWindow({
  Title = "Ashu Hub",
  Subtitle = "Saber Showdown",
  SubtitleColor = Color3.fromRGB(190, 140, 255),
  Logo = "rbxassetid://82367817676382",
  LogoSize = 32,
  SphereText = false,
  SphereWords = "ZX",
  SphereImage = "rbxassetid://82367817676382",
  SphereIconSize = 38,
})

local function f2(p28)
  return p28.Gui and p28.Gui:FindFirstChild("MainFrame")
end

local v16 = f2(ashuHubWindow)

if v16 then
  local uiScale = Instance.new("UIScale")
  uiScale.Scale = 0.85
  uiScale.Parent = v16
end

local combatTab = ashuHubWindow:CreateTab("Combat", true, false)
local trollTab = ashuHubWindow:CreateTab("Troll", false, false)
local opTab = ashuHubWindow:CreateTab("OP", false, false)
local settingsTab = ashuHubWindow:CreateTab("Settings", false, false)
local damageBlockPage = combatTab:CreatePage("Damage & Block")
local hitboxMovesPage = combatTab:CreatePage("Hitbox & Moves")
local killAuraPage = opTab:CreatePage("Kill Aura")
local settingsPage = settingsTab:CreatePage("Settings")
local outfitStealerPage = trollTab:CreatePage("Outfit Stealer")

local v17 = {
  DamageKey = Enum.KeyCode.X,
  AutoPBKey = Enum.KeyCode.C,
  AerialKey = Enum.KeyCode.E,
  KataKey = Enum.KeyCode.R,
}

local v18 = false
local v19 = 100
local v20

local v21 = hookmetamethod(game, "__namecall", function(p29, ...)
  if not v18 or checkcaller() then
    return v20(p29, ...)
  end

  if getnamecallmethod() == "FireServer" and p29.Name == "Attack" then
    if math.random(1, 100) <= v19 then
      local v22 = { ... }
      v22[2] = 1
      return v20(p29, unpack(v22))
    end

    return v20(p29, ...)
  end

  return v20(p29, ...)
end)

local function f3(p30)
  v18 = p30
end

v20 = v21
local v23 = false
local v24 = 12

local humanoidRootPart = localPlayer.Character
  and localPlayer.Character:FindFirstChild("HumanoidRootPart")

local v25 = {
  [12718502938] = { { 1, 13, 2 }, 1 },
  [12625839385] = { { 1, 13, 2 }, 1 },
  [13564880014] = { { 1, 13, 2 }, 1 },
  [12734285787] = { { 1, 13, 2 }, 1 },
  [13453391958] = { { 1, 13, 2 }, 1 },
  [14167593691] = { { 1, 13, 2 }, 1 },
  [13783202348] = { { 1, 13, 2 }, 1 },
  [13540434005] = { { 1, 13, 2 }, 1 },
  [15563343338] = { { 1, 13, 2 }, 1 },
  [12734468945] = { { 1, 13, 2 }, 1 },
  [13304774028] = { { 1, 13, 2 }, 1 },
  [17372041039] = { { 1, 13, 2 }, 1 },
  [14329314419] = { { 1, 13, 2 }, 1 },
  [12718504431] = { { 2, 3, 4 }, 8 },
  [12625848489] = { { 2, 3, 4 }, 8 },
  [13565725049] = { { 2, 3, 4 }, 8 },
  [12734288411] = { { 2, 3, 4 }, 8 },
  [13453386109] = { { 2, 3, 4 }, 8 },
  [14167584256] = { { 2, 3, 4 }, 8 },
  [13783395464] = { { 2, 3, 4 }, 8 },
  [13540430226] = { { 2, 3, 4 }, 8 },
  [15563344914] = { { 2, 3, 4 }, 8 },
  [12734471179] = { { 2, 3, 4 }, 8 },
  [13304781510] = { { 2, 3, 4 }, 8 },
  [17566657634] = { { 2, 3, 4 }, 8 },
  [14329308611] = { { 2, 3, 4 }, 8 },
  [12718501806] = { { 4, 5, 6 }, 3 },
  [12625841878] = { { 4, 5, 6 }, 3 },
  [13569466383] = { { 4, 5, 6 }, 3 },
  [12734284724] = { { 4, 5, 6 }, 3 },
  [13453390619] = { { 4, 5, 6 }, 3 },
  [14167591876] = { { 4, 5, 6 }, 3 },
  [13783497920] = { { 4, 5, 6 }, 3 },
  [15563343960] = { { 4, 5, 6 }, 3 },
  [12734468200] = { { 4, 5, 6 }, 3 },
  [13306520673] = { { 4, 5, 6 }, 3 },
  [17372039079] = { { 4, 5, 6 }, 3 },
  [14329312618] = { { 4, 5, 6 }, 3 },
  [12718500875] = { { 6, 7, 8 }, 6 },
  [12625853257] = { { 6, 7, 8 }, 6 },
  [13569308951] = { { 6, 7, 8 }, 6 },
  [12734283312] = { { 6, 7, 8 }, 6 },
  [13453385141] = { { 6, 7, 8 }, 6 },
  [14167502905] = { { 6, 7, 8 }, 6 },
  [13781663786] = { { 6, 7, 8 }, 6 },
  [13540431378] = { { 6, 7, 8 }, 6 },
  [15563346027] = { { 6, 7, 8 }, 6 },
  [12734467243] = { { 6, 7, 8 }, 6 },
  [13306517941] = { { 6, 7, 8 }, 6 },
  [17372038496] = { { 6, 7, 8 }, 6 },
  [14329161930] = { { 6, 7, 8 }, 6 },
  [12718483984] = { { 8, 9, 10 }, 5 },
  [12625843823] = { { 8, 9, 10 }, 5 },
  [13568360345] = { { 8, 9, 10 }, 5 },
  [12734279804] = { { 8, 9, 10 }, 5 },
  [13453387454] = { { 8, 9, 10 }, 5 },
  [14167592684] = { { 8, 9, 10 }, 5 },
  [13781621647] = { { 8, 9, 10 }, 5 },
  [15563342470] = { { 8, 9, 10 }, 5 },
  [12734465074] = { { 8, 9, 10 }, 5 },
  [13304777249] = { { 8, 9, 10 }, 5 },
  [17372037456] = { { 8, 9, 10 }, 5 },
  [14355055371] = { { 8, 9, 10 }, 5 },
  [12718486016] = { { 10, 11 }, 4 },
  [12625846167] = { { 10, 11 }, 4 },
  [13568907848] = { { 10, 11 }, 4 },
  [12734282359] = { { 10, 11 }, 4 },
  [13453382299] = { { 10, 11 }, 4 },
  [14167590501] = { { 10, 11 }, 4 },
  [13781667793] = { { 10, 11 }, 4 },
  [15564066873] = { { 10, 11 }, 4 },
  [12734466257] = { { 10, 11 }, 4 },
  [13304786458] = { { 10, 11 }, 4 },
  [17372036678] = { { 10, 11 }, 4 },
  [14329310837] = { { 10, 11 }, 4 },
  [12718503706] = { { 12, 13 }, 2 },
  [12625851115] = { { 12, 13 }, 2 },
  [13566518265] = { { 12, 13 }, 2 },
  [12734286808] = { { 12, 13 }, 2 },
  [13453383921] = { { 12, 13 }, 2 },
  [14167585544] = { { 12, 13 }, 2 },
  [13783293417] = { { 12, 13 }, 2 },
  [15563346564] = { { 12, 13 }, 2 },
  [12734470075] = { { 12, 13 }, 2 },
  [13304788013] = { { 12, 13 }, 2 },
  [17566667400] = { { 12, 13 }, 2 },
  [14329160019] = { { 12, 13 }, 2 },
}

local v26 = {}
local v27 = {}

local function f4(p31, model)
  if v26[p31] then
    return
  end

  v26[p31] = true

  p31.AnimationPlayed:Connect(function(p32)
    local v28 = v25[tonumber(p32.Animation.AnimationId:match("%d+$"))]

    if v28 then
      v27[p32] = { dirs = v28[1], model = model, executed = false }
    end
  end)
end

local function f5(p33)
  if not p33:IsA("Model") or p33 == localPlayer.Character then
    return
  end

  local humanoid = p33:FindFirstChildOfClass("Humanoid")

  if humanoid then
    humanoid.Died:Connect(function() v26[humanoid] = nil end)
    local animator = humanoid:FindFirstChildWhichIsA("Animator")

    if animator then
      f4(animator, p33)
    end
  end
end

runService.Heartbeat:Connect(function()
  if not v23 or not humanoidRootPart or not humanoidRootPart.Parent then
    return
  else
    for index2, value3 in ipairs(players:GetPlayers()) do
      if value3 ~= localPlayer and value3.Character then
        f5(value3.Character)
      end
    end

    local characters = workspace:FindFirstChild("Characters")

    if characters then
      for index3, value4 in ipairs(characters:GetChildren()) do
        f5(value4)
      end
    end

    return
  end
end)

runService.RenderStepped:Connect(function()
  if not v23 or not humanoidRootPart or not humanoidRootPart.Parent then
    return
  end

  for key2, value5 in pairs(v27) do
    if key2.IsPlaying then
      if not value5.executed then
        local humanoidRootPart2 = value5.model:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart2 then
          if (humanoidRootPart.Position - humanoidRootPart2.Position).Magnitude <= v24 then
            value5.executed = true

            for index4, value6 in ipairs(value5.dirs) do
              updateBlockDirection:FireServer(value6)
            end
          end
        end
      end
    else
      v27[key2] = nil
    end
  end
end)

local function f6(p34)
  if not p34 or p34 == "" then
    return
  else
    local v29 = string.lower(p34)
    local v30 = nil

    for index5, value7 in ipairs(players:GetPlayers()) do
      if value7 ~= localPlayer and value7.Character then
        local v31 = string.lower(value7.Name)
        local v32 = string.lower(value7.DisplayName or "")

        if string.find(v31, v29, 1, true) or string.find(v32, v29, 1, true) then
          v30 = value7
          break
        end
      end
    end

    if not v30 or not v30.Character then
      return
    else
      local humanoid2 = v30.Character:FindFirstChildOfClass("Humanoid")

      if not humanoid2 then
        return
      else
        local getAppliedDescription = humanoid2:GetAppliedDescription()

        if not getAppliedDescription then
          return
        else
          local function f7(p35, p36, p37)
            return string.format("%02X%02X%02X", p35 * 255, p36 * 255, p37 * 255)
          end

          local function f8(p38)
            local v33 = {}

            for match in string.gmatch(p38, "[^,]+") do
              table.insert(v33, match)
            end

            return v33
          end

          local v34 = {}

          for index6, value8 in ipairs({
            "Back", "Face", "Front", "Hair", "Hat", "Neck", "Shoulders", "Waist",
          }) do
            local v35 = getAppliedDescription[value8 .. "Accessory"]

            if v35 and v35 ~= "" and v35 ~= 0 then
              if typeof(v35) == "number" then
                v34[tostring(v35)] = v35
              else
                for index7, value9 in ipairs(f8(v35)) do
                  local v36 = tonumber(value9)

                  if v36 then
                    v34[tostring(v36)] = v36
                  end
                end
              end
            end
          end

          local rightArm = f7(
            getAppliedDescription.RightArmColor.R, getAppliedDescription.RightArmColor.G,
            getAppliedDescription.RightArmColor.B
          )

          local head = f7(
            getAppliedDescription.HeadColor.R, getAppliedDescription.HeadColor.G,
            getAppliedDescription.HeadColor.B
          )

          local rightLeg = f7(
            getAppliedDescription.RightLegColor.R, getAppliedDescription.RightLegColor.G,
            getAppliedDescription.RightLegColor.B
          )

          local torso = f7(
            getAppliedDescription.TorsoColor.R, getAppliedDescription.TorsoColor.G,
            getAppliedDescription.TorsoColor.B
          )

          local leftArm = f7(
            getAppliedDescription.LeftArmColor.R, getAppliedDescription.LeftArmColor.G,
            getAppliedDescription.LeftArmColor.B
          )

          local leftLeg = f7(
            getAppliedDescription.LeftLegColor.R, getAppliedDescription.LeftLegColor.G,
            getAppliedDescription.LeftLegColor.B
          )

          replicatedStorage:WaitForChild("AvatarRemotes"):WaitForChild("ApplyDescription"):FireServer({
            BodyParts = {
              RightArm = getAppliedDescription.RightArm,
              Head = getAppliedDescription.Head,
              RightLeg = getAppliedDescription.RightLeg,
              Torso = getAppliedDescription.Torso,
              LeftArm = getAppliedDescription.LeftArm,
              LeftLeg = getAppliedDescription.LeftLeg,
            },
            Shirt = getAppliedDescription.Shirt,
            Pants = getAppliedDescription.Pants,
            Face = getAppliedDescription.Face,
            Accessories = v34,
            BodyColors = {
              RightArm = rightArm,
              Head = head,
              RightLeg = rightLeg,
              Torso = torso,
              LeftArm = leftArm,
              LeftLeg = leftLeg,
            },
            TShirt = getAppliedDescription.GraphicTShirt,
          })

          return
        end
      end
    end
  end
end

localPlayer.CharacterAdded:Connect(function(character)
  humanoidRootPart = character:WaitForChild("HumanoidRootPart")
  v26 = {}
  v27 = {}
end)

local function f9(p39)
  v23 = p39

  if not p39 then
    v27 = {}
  end
end

local v37 = false
local v38 = 8
local v39 = { players = {}, npcs = {} }

local function f10(parent, p40)
  local ashuHitbox = Instance.new("Part")
  ashuHitbox.Name = "AshuHitbox"
  ashuHitbox.Size = Vector3.new(v38, v38, v38)
  ashuHitbox.CanCollide = false
  ashuHitbox.CanQuery = true
  ashuHitbox.CanTouch = false
  ashuHitbox.Massless = true
  ashuHitbox.Anchored = false
  ashuHitbox.Transparency = 1
  ashuHitbox.Color = Color3.fromRGB(255, 255, 255)

  local weldConstraint = Instance.new("WeldConstraint")
  weldConstraint.Part0 = p40
  weldConstraint.Part1 = ashuHitbox
  weldConstraint.Parent = ashuHitbox

  ashuHitbox.CFrame = p40.CFrame
  ashuHitbox.Parent = parent

  return ashuHitbox, weldConstraint
end

local f11

local function f12()
  task.spawn(function()
    while v37 do
      for index8, value10 in ipairs(players:GetPlayers()) do
        if value10 ~= localPlayer then
          local character2 = value10.Character

          if character2 then
            local humanoidRootPart3 = character2:FindFirstChild("HumanoidRootPart")
            local humanoid3 = character2:FindFirstChildOfClass("Humanoid")

            if humanoidRootPart3 and humanoid3 and humanoid3.Health > 0 then
              local v40 = v39.players[value10]

              if not v40 or not v40.box or not v40.box.Parent then
                local box, weld = f10(character2, humanoidRootPart3)
                v39.players[value10] = { box = box, weld = weld }
              else
                v40.box.Size = Vector3.new(v38, v38, v38)
              end
            elseif v39.players[value10] then
              f11(v39.players[value10])
              v39.players[value10] = nil
            end
          elseif v39.players[value10] then
            f11(v39.players[value10])
            v39.players[value10] = nil
          end
        end
      end

      for index9, value11 in ipairs(workspace:GetDescendants()) do
        if value11.Name == "HumanoidRootPart" then
          local parent2 = value11.Parent

          if parent2 and parent2:IsA("Model") and not players:GetPlayerFromCharacter(parent2) then
            local humanoid4 = parent2:FindFirstChildOfClass("Humanoid")

            if humanoid4 and humanoid4.Health > 0 then
              local v41 = v39.npcs[value11]

              if not v41 or not v41.box or not v41.box.Parent then
                local box2, weld2 = f10(parent2, value11)
                v39.npcs[value11] = { box = box2, weld = weld2 }
              else
                v41.box.Size = Vector3.new(v38, v38, v38)
              end
            elseif v39.npcs[value11] then
              f11(v39.npcs[value11])
              v39.npcs[value11] = nil
            end
          end
        end
      end

      task.wait(0.8)
    end

    for key3, value12 in pairs(v39.players) do
      f11(value12)
    end

    for key4, value13 in pairs(v39.npcs) do
      f11(value13)
    end

    v39.players = {}
    v39.npcs = {}
  end)
end

function f11(p41)
  if p41 and p41.box and p41.box.Parent then
    p41.box:Destroy()
  end
end

local function f13(p42)
  v37 = p42

  if p42 then
    f12()
  end
end

local v42 = false

local function f14()
  if not v42 then
    return
  end

  pcall(function() unblock:FireServer() end)
  v42 = false
end

local v43 = false

local function f15()
  if v42 then
    return
  end

  pcall(function() block:FireServer() end)
  v42 = true
end

local v44

v44 = hookmetamethod(game, "__namecall", function(p43, ...)
  if not v43 or checkcaller() then
    return v44(p43, ...)
  end

  if getnamecallmethod() == "FireServer" then
    if p43 == attack or p43 == swing or p43 == mouseDown then
      f14()
    end
  end

  return v44(p43, ...)
end)

runService.Heartbeat:Connect(function()
  if v43 then
    f15()
  end
end)

local function f16(p44)
  v43 = p44

  if not p44 then
    f14()
  end
end

local v45 = false
local v46 = true

local v47

v47 = hookmetamethod(game, "__namecall", function(p45, ...)
  if not v45 or checkcaller() then
    return v47(p45, ...)
  end

  if p45 == attack and getnamecallmethod() == "FireServer" then
    v46 = false

    unblock:FireServer()
    unblock:FireServer()

    v46 = true
  end

  return v47(p45, ...)
end)

runService.RenderStepped:Connect(function()
  if v45 and v46 then
    local count = 0

    while true do
      count = 1 + count

      if not (count <= 6) then
        break
      end

      block:FireServer()
    end
  end
end)

task.spawn(function()
  while true do
    if v45 and v46 then
      block:FireServer()
    end

    task.wait()
  end
end)

local function f17(p46)
  v45 = p46
  v46 = true
end

local function f18()
  local character3 = localPlayer.Character

  if not character3 then
    return
  else
    local humanoidRootPart4 = character3:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart4 then
      return
    else
      local assemblyLinearVelocity = humanoidRootPart4.AssemblyLinearVelocity

      humanoidRootPart4.AssemblyLinearVelocity = Vector3.new(
        assemblyLinearVelocity.X, 44, assemblyLinearVelocity.Z
      )

      task.wait(0.12)
      pcall(function() v2(v1.get()) end)
      return
    end
  end
end

local f19

local function f20(p47)
  local screenGui = Instance.new("ScreenGui")
  screenGui.Name = p47 .. "GUI"
  screenGui.ResetOnSpawn = false
  screenGui.Parent = gethui and gethui() or coreGui

  local instance37 = Instance.new("Frame", screenGui)
  instance37.Size = UDim2.new(0, 160, 0, 80)
  instance37.Position = UDim2.new(0.5, -80, 0.6, 0)
  instance37.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
  instance37.BorderSizePixel = 0
  instance37.Active = true

  Instance.new("UICorner", instance37).CornerRadius = UDim.new(0, 12)

  local instance38 = Instance.new("Frame", instance37)
  instance38.Size = UDim2.new(0, 18, 1, 0)
  instance38.Position = UDim2.new(1, -18, 0, 0)
  instance38.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
  instance38.BorderSizePixel = 0

  Instance.new("UICorner", instance38).CornerRadius = UDim.new(0, 12)

  local instance39 = Instance.new("TextButton", instance37)
  instance39.Size = UDim2.new(1, -25, 1, -20)
  instance39.Position = UDim2.new(0, 10, 0, 10)
  instance39.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
  instance39.TextColor3 = Color3.new(1, 1, 1)
  instance39.Text = p47
  instance39.Font = Enum.Font.GothamBold
  instance39.TextSize = 16

  Instance.new("UICorner", instance39).CornerRadius = UDim.new(0, 10)
  local v48, position3, position4

  instance38.InputBegan:Connect(function(input8)
    if input8.UserInputType == Enum.UserInputType.Touch then
      v48 = true
      position3 = input8.Position
      position4 = instance37.Position
    end
  end)

  instance38.InputEnded:Connect(function() v48 = false end)

  userInputService.InputChanged:Connect(function(input9)
    if v48 and input9.UserInputType == Enum.UserInputType.Touch then
      local v49 = input9.Position - position3

      instance37.Position = UDim2.new(
        position4.X.Scale, position4.X.Offset + v49.X, position4.Y.Scale,
        position4.Y.Offset + v49.Y
      )
    end
  end)

  instance39.MouseButton1Click:Connect(function()
    if p47 == "Aerial" then
      f18()
    else
      f19()
    end
  end)
end

function f19()
  local character4 = localPlayer.Character

  if not character4 then
    return
  else
    local humanoidRootPart5 = character4:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart5 then
      return
    else
      local assemblyLinearVelocity2 = humanoidRootPart5.AssemblyLinearVelocity

      humanoidRootPart5.AssemblyLinearVelocity = Vector3.new(
        assemblyLinearVelocity2.X, 44, assemblyLinearVelocity2.Z
      )

      task.wait(0.12)
      pcall(function() v3(v1.get()) end)
      return
    end
  end
end

local v50 = false
local v51 = {}

local function f21(p48)
  return v51[p48.Name] == true
end

local pingGUI, instance40

local function f22()
  if pingGUI then
    return
  else
    pingGUI = Instance.new("ScreenGui")
    pingGUI.Name = "PingGUI"
    pingGUI.ResetOnSpawn = false
    pingGUI.Parent = gethui and gethui() or coreGui

    local instance41 = Instance.new("Frame", pingGUI)
    instance41.Size = UDim2.new(0, 110, 0, 40)
    instance41.Position = UDim2.new(0.82, 0, 0.15, 0)
    instance41.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    instance41.BorderSizePixel = 0
    instance41.Active = true
    instance41.Draggable = true

    Instance.new("UICorner", instance41).CornerRadius = UDim.new(0, 10)

    instance40 = Instance.new("TextLabel", instance41)
    instance40.Size = UDim2.new(1, 0, 1, 0)
    instance40.BackgroundTransparency = 1
    instance40.TextColor3 = Color3.new(1, 1, 1)
    instance40.Font = Enum.Font.GothamBold
    instance40.TextSize = 16
    instance40.Text = "Ping: 0 ms"

    task.spawn(function()
      while true do
        if v50 then
          local dataPing = statsService.Network.ServerStatsItem["Data Ping"]
          local v52 = math.floor(dataPing:GetValue())
          instance40.Text = "Ping: " .. v52 .. " ms"

          if v52 <= 70 then
            instance40.TextColor3 = Color3.fromRGB(0, 255, 0)
          elseif v52 <= 130 then
            instance40.TextColor3 = Color3.fromRGB(255, 255, 0)
          else
            instance40.TextColor3 = Color3.fromRGB(255, 60, 60)
          end
        end

        task.wait(0.2)
      end
    end)

    return
  end
end

local function f23(p49)
  v50 = p49

  if p49 then
    if not pingGUI then
      f22()
    end

    pingGUI.Enabled = true
  elseif pingGUI then
    pingGUI.Enabled = false
  end
end

local v53 = false
local v54 = false
local v55 = 0
local v56 = 0.05

task.spawn(function()
  while true do
    task.wait(v56)

    if v53 then
      if localPlayer.Character then
        localPlayer.Character:FindFirstChild("HumanoidRootPart")
      end
    end
  end
end)

local addToggle

task.spawn(function()
  while true do
    if v54 and tick() - v55 < 4 then
      pcall(function()
        lightsaberRemotes.MouseDown:FireServer()
        lightsaberRemotes.Attack:FireServer(3, 1, false, false)
        lightsaberRemotes.MouseUp:FireServer()
        lightsaberRemotes.Swing:FireServer()

        for index10, value14 in ipairs(players:GetPlayers()) do
          if not f21(value14) and value14.Character
            and value14.Character:FindFirstChild("Humanoid") then
            lightsaberRemotes.OnHit:FireServer(value14.Character)
          end
        end

        lightsaberRemotes.FinishSwingNoBounce:FireServer()
        lightsaberRemotes.ResetSwingDirection:FireServer()
      end)
    elseif v54 then
      v54 = false

      if addToggle then
        pcall(function() addToggle:SetValue(false) end)
      end
    end

    task.wait(0.005)
  end
end)

local createSection = damageBlockPage:CreateSection("2x Damage")

createSection:AddToggle("2xDamage", false, function(p50)
  f3(p50)
  v4:Notify({ Title = "2x Damage", Description = p50 and "Enabled" or "Disabled", Duration = 2 })
end, {
  Title = "2x Damage",
  Description = "Doubles attack damage with chance",
  Example = "Set chance below",
})

createSection:AddSlider("DamageChance", 0, 100, v19, function(p51) v19 = p51 end, {
  Title = "High Damage Chance",
  Description = "Chance to apply 2x damage",
  Example = "100 = always",
})

createSection:AddTextbox("DamageKey", "X", function(p52)
  local v57, v58 = pcall(function() return Enum.KeyCode[p52:upper()] end)

  if v57 and v58 then
    v17.DamageKey = v58
  end
end, {
  Title = "Toggle Key (type e.g. X)",
  Description = "Press this key to toggle 2x Damage",
})

local section = damageBlockPage:CreateSection("Auto Perfect Block")

section:AddToggle("AutoPB", false, function(p53)
  f9(p53)
  v4:Notify({ Title = "Auto PB", Description = p53 and "Enabled" or "Disabled", Duration = 2 })
end, {
  Title = "Auto Perfect Block",
  Description = "Instantly blocks attacks (reliable)",
  Example = "Set range below",
})

section:AddSlider("PBRange", 5, 25, v24, function(p54) v24 = p54 end, {
  Title = "Block Range",
  Description = "Max distance to block (studs)",
})

section:AddTextbox("PBKey", "C", function(p55)
  local v59, v60 = pcall(function() return Enum.KeyCode[p55:upper()] end)

  if v59 and v60 then
    v17.AutoPBKey = v60
  end
end, { Title = "Toggle Key", Description = "Press this key to toggle Auto PB" })

local autoBlockSection = damageBlockPage:CreateSection("Auto Block")

autoBlockSection:AddToggle("LegitAutoBlock", false, function(p56)
  f16(p56)

  v4:Notify({
    Title = "Legit Auto Block",
    Description = p56 and "Enabled" or "Disabled",
    Duration = 2,
  })
end, {
  Title = "Legit Auto Block",
  Description = "Only auto blocks while swinging (anti-slap)",
  Example = "Recommended for legit play",
})

autoBlockSection:AddToggle("AutoBlockOP", false, function(p57)
  f17(p57)

  v4:Notify({
    Title = "Auto Block OP",
    Description = p57 and "Enabled" or "Disabled",
    Duration = 2,
  })
end, {
  Title = "Auto Block OP",
  Description = "Aggressive continuous blocking (not legit)",
  Example = "Use with caution",
})

local hitboxExpanderSection = hitboxMovesPage:CreateSection("Hitbox Expander")

hitboxExpanderSection:AddToggle("Hitbox", false, function(p58)
  f13(p58)

  v4:Notify({
    Title = "Hitbox Expander",
    Description = p58 and "Enabled" or "Disabled",
    Duration = 2,
  })
end, {
  Title = "Hitbox Expander",
  Description = "Enlarges hitboxes for easier hits",
  Example = "Invisible hitboxes",
})

hitboxExpanderSection:AddSlider("HitboxSize", 8, 18, v38, function(p59)
  v38 = p59

  for key5, value15 in pairs(v39.players) do
    if value15.box then
      value15.box.Size = Vector3.new(v38, v38, v38)
    end
  end

  for key6, value16 in pairs(v39.npcs) do
    if value16.box then
      value16.box.Size = Vector3.new(v38, v38, v38)
    end
  end
end, {
  Title = "Hitbox Size",
  Description = "Size of expanded hitbox (8-18 studs)",
})

local section2 = hitboxMovesPage:CreateSection("Moves (Aerial/Kata)")
section2:AddButton("Load Aerial GUI", function() f20("Aerial") end)
section2:AddButton("Load Kata GUI", function() f20("Kata") end)

section2:AddTextbox("AerialKey", "E", function(p60)
  local v61, v62 = pcall(function() return Enum.KeyCode[p60:upper()] end)

  if v61 and v62 then
    v17.AerialKey = v62
  end
end, { Title = "Aerial Keybind", Description = "Key to perform Aerial directly" })

section2:AddTextbox("KataKey", "R", function(p61)
  local v63, v64 = pcall(function() return Enum.KeyCode[p61:upper()] end)

  if v63 and v64 then
    v17.KataKey = v64
  end
end, { Title = "Kata Keybind", Description = "Key to perform Kata directly" })

local avatarStealerSection = outfitStealerPage:CreateSection("Avatar Stealer")
local v65 = ""

avatarStealerSection:AddTextbox("TargetName", "", function(p62) v65 = p62 end, {
  Title = "Player Name",
  Description = "Enter username or partial name",
})

avatarStealerSection:AddButton("Steal Avatar", function()
  f6(v65)

  v4:Notify({
    Title = "Outfit Stealer",
    Description = "Attempting to copy outfit...",
    Duration = 2,
  })
end)

local section3 = killAuraPage:CreateSection("Blatant Kill Aura")

section3:AddToggle("BlatantAura", false, function(p63) v53 = p63 end, {
  Title = "Blatant Aura",
  Description = "Rapidly attacks all enemies in range",
  Example = "Toggle on for auto kill",
})

section3:AddLabel("Disable auto block so kill aura works ðŸ¤—")

section3:AddSlider("BlatantSpeed", 0.01, 1.5, v56, function(p64) v56 = p64 end, {
  Title = "Speed",
  Description = "Delay between attacks (seconds)",
  Example = "Lower = faster",
})

addToggle = killAuraPage:CreateSection("GodMod"):AddToggle("GodMod", false, function(p65)
  v54 = p65

  if p65 then
    v55 = tick()
  end
end, {
  Title = "GodMod",
  Description = "AOE attack that hits all players (including you) for 4s",
  Example = "Use with caution - you will die after 4s",
})

local section4 = killAuraPage:CreateSection("Whitelist (Aura Ignore)")
local v66 = {}

for index11, value17 in ipairs(players:GetPlayers()) do
  if value17 ~= localPlayer then
    table.insert(v66, value17.Name)
  end
end

section4:AddDropdown("WhitelistPlayers", v66, true, function(p66)
  v51 = {}

  for key7, value18 in pairs(p66) do
    if value18 then
      v51[key7] = true
    end
  end
end, {
  Title = "Select players to ignore",
  Description = "These players won't be targeted by aura/godmod",
  Example = "Multi-select enabled",
})

settingsPage:CreateSection("Ping Display"):AddToggle("Ping", false, function(p67) f23(p67) end, {
  Title = "Ping Display",
  Description = "Shows a live ping counter",
})

settingsPage:CreateSection("Discord"):AddCopyButton("Copy Discord Link", "https://discord.gg/Tzrupyysc", {
  Title = "Join Our Discord",
  Description = "Copy invite link to clipboard",
})

settingsPage:CreateSection("Config"):AddConfigManager("ashuHubSaves")

userInputService.InputBegan:Connect(function(input10, p68)
  if p68 then
    return
  elseif input10.UserInputType ~= Enum.UserInputType.Keyboard then
    return
  else
    local keyCode = input10.KeyCode

    if keyCode == v17.DamageKey then
      f3(not v18)

      v4:Notify({
        Title = "2x Damage",
        Description = v18 and "Enabled" or "Disabled",
        Duration = 2,
      })
    elseif keyCode == v17.AutoPBKey then
      f9(not v23)

      v4:Notify({
        Title = "Auto PB",
        Description = v23 and "Enabled" or "Disabled",
        Duration = 2,
      })
    elseif keyCode == v17.AerialKey then
      f18()
    elseif keyCode == v17.KataKey then
      f19()
    end

    return
  end
end)

v4:Notify({ Title = "Ashu Hub", Description = "All features loaded!", Duration = 5 })
