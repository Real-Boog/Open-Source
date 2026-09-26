-- this is for Arsenal

local players = game:GetService("Players")
local workspaceService = game:GetService("Workspace")
local replicatedStorage = game:GetService("ReplicatedStorage")
local lighting = game:GetService("Lighting")
local httpService = game:GetService("HttpService")
local starterGui = game:GetService("StarterGui")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local teleportService = game:GetService("TeleportService")

starterGui:SetCore("SendNotification", {
  Title = "TITANIC HUB",
  Text = "Working for Mobile and PC Executor",
  Duration = 8,
})

starterGui:SetCore("SendNotification", { Title = "Made By:", Text = "L", Duration = 8 })

local localPlayer = players.LocalPlayer
local character, humanoid, bodyVelocity, bodyAngularVelocity, camera, v1

local function f1()
  if not localPlayer.Character or not localPlayer.Character.Head or v1 then
    return
  else
    character = localPlayer.Character

    humanoid = character.Humanoid
    humanoid.PlatformStand = true

    camera = workspace:WaitForChild("Camera")
    bodyVelocity = Instance.new("BodyVelocity")
    bodyAngularVelocity = Instance.new("BodyAngularVelocity")
    local vector = Vector3.new(0, 0, 0)
    local vector2 = Vector3.new(10000, 10000, 10000)

    bodyVelocity.Velocity = vector
    bodyVelocity.MaxForce = vector2
    bodyVelocity.P = 1000

    local vector3 = Vector3.new(0, 0, 0)
    local vector4 = Vector3.new(10000, 10000, 10000)

    bodyAngularVelocity.AngularVelocity = vector3
    bodyAngularVelocity.MaxTorque = vector4
    bodyAngularVelocity.P = 1000

    bodyVelocity.Parent = character.Head
    bodyAngularVelocity.Parent = character.Head
    v1 = true
    humanoid.Died:Connect(function() v1 = false end)
    return
  end
end

local function f2()
  if not localPlayer.Character or not v1 then
    return
  end

  humanoid.PlatformStand = false
  bodyVelocity:Destroy()
  bodyAngularVelocity:Destroy()
  v1 = false
end

userInputService.InputBegan:Connect(function(input, p1)
  if p1 then
    return
  end
end)

userInputService.InputEnded:Connect(function(input2, p2)
  if p2 then
    return
  end
end)

runService.Heartbeat:Connect(function(delta)
  if v1 and character and character.PrimaryPart then
    local position = character.PrimaryPart.Position
    local v2, v3, v4 = camera.CFrame:toEulerAnglesXYZ()

    character:SetPrimaryPartCFrame(CFrame.new(position.x, position.y, position.z)
      * CFrame.Angles(v2, v3, v4))
  end
end)

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"))()
local themeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua"))()
local saveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/SaveManager.lua"))()
local options = library.Options
local toggles = library.Toggles

task.spawn(function()
  task.wait(1)
  pcall(function() library:SetFont(Enum.Font.Gotham) end)
end)

local titanicHUBWindow = library:CreateWindow({
  Title = "TITANIC HUB",
  Footer = "Arsenal | Freemium",
  Center = true,
  AutoShow = true,
  Resizable = true,
  ShowCustomCursor = true,
})

local v5 = {
  Info = titanicHUBWindow:AddTab("Info", "info"),
  Main = titanicHUBWindow:AddTab("Main", "house"),
  Gun = titanicHUBWindow:AddTab("Gun Modded", "bolt"),
  Player = titanicHUBWindow:AddTab("Player", "user"),
  Skins = titanicHUBWindow:AddTab("Color Skins", "star"),
  Extra = titanicHUBWindow:AddTab("Extra", "sparkles"),
  Visuals = titanicHUBWindow:AddTab("Visuals", "eye"),
  Setting = titanicHUBWindow:AddTab("Setting", "settings"),
  Credits = titanicHUBWindow:AddTab("Credits", "info"),
}

local addLeftGroupbox = v5.Info:AddLeftGroupbox("Account Info", "user")
local addRightGroupbox = v5.Info:AddRightGroupbox("Links", "link")
local v6 = "Unknown"

pcall(function()
  if identifyexecutor then
    v6 = identifyexecutor()
  elseif getexecutorname then
    v6 = getexecutorname()
  end
end)

local localPlayer2 = players.LocalPlayer

addLeftGroupbox:AddLabel("Username: " .. localPlayer2.Name)
addLeftGroupbox:AddLabel("Display Name: " .. localPlayer2.DisplayName)
addLeftGroupbox:AddLabel("User ID: " .. tostring(localPlayer2.UserId))
addLeftGroupbox:AddLabel("Executor: " .. tostring(v6))
addLeftGroupbox:AddLabel('Script: <font color="#FF0000">Arsenal v2</font>', false)
addLeftGroupbox:AddLabel('Team: <font color="#00FF00">TITANIC HUB Team</font>', false)

addRightGroupbox:AddButton({
  Text = "Join Discord",
  Func = function()
    setclipboard("https://discord.gg/AGzuCsXtnp")
    library:Notify({ Title = "Discord", Description = "Invite link copied!", Time = 5 })
  end,
})

addRightGroupbox:AddLabel("discord.gg/AGzuCsXtnp")

local addLeftGroupbox2 = v5.Main:AddLeftGroupbox("Hitbox Settings", "square")
local addLeftGroupbox3 = v5.Main:AddLeftGroupbox("AutoFarm", "compass")
local addRightGroupbox2 = v5.Main:AddRightGroupbox("Triggerbot", "bolt")
local value = false
local value2 = false
local v7 = {}
local value3 = 21
local value4 = 6
local value5 = "FFA"
local v8 = { "UpperTorso", "Head", "HumanoidRootPart" }

local function f3(p3, p4)
  if not v7[p3] then
    v7[p3] = {}
  end

  if not v7[p3][p4.Name] then
    v7[p3][p4.Name] = {
      CanCollide = p4.CanCollide,
      Transparency = p4.Transparency,
      Size = p4.Size,
    }
  end
end

local localPlayer3 = players.LocalPlayer

local function f4(p5)
  if v7[p5] then
    for key, value6 in pairs(v7[p5]) do
      local character2 = p5.Character

      local findFirstChild = character2
      findFirstChild = character2 and p5.Character:FindFirstChild(key)

      if findFirstChild and findFirstChild:IsA("BasePart") then
        findFirstChild.CanCollide = value6.CanCollide
        findFirstChild.Transparency = value6.Transparency
        findFirstChild.Size = value6.Size
      end
    end
  end
end

local function f5(p6)
  if value5 == "FFA" or value5 == "Everyone" then
    return true
  end

  return p6.Team ~= localPlayer3.Team
end

local f6

local function f7(p7)
  for index, value7 in ipairs(v8) do
    local findFirstChild2 = p7.Character
      and (p7.Character:FindFirstChild(value7) or f6(p7, value7))

    if findFirstChild2 and findFirstChild2:IsA("BasePart") then
      f3(p7, findFirstChild2)

      findFirstChild2.CanCollide = not value2
      findFirstChild2.Transparency = value4 / 10
      findFirstChild2.Size = Vector3.new(value3, value3, value3)
    end
  end
end

function f6(p8, p9)
  if not p8.Character then
    return nil
  end

  for index2, value8 in ipairs(p8.Character:GetChildren()) do
    if value8:IsA("BasePart") and value8.Name:lower():match(p9:lower()) then
      return value8
    end
  end

  return nil
end

local function f8()
  for key2, value9 in pairs(v7) do
    if not key2.Parent or not key2.Character or not key2.Character:IsDescendantOf(game) then
      f4(key2)
      v7[key2] = nil
    end
  end
end

local function f9()
  for index3, value10 in ipairs(players:GetPlayers()) do
    if value10 ~= localPlayer3 and value10.Character
      and value10.Character:FindFirstChild("HumanoidRootPart") then
      if f5(value10) then
        f7(value10)
      else
        f4(value10)
      end
    end
  end
end

local function f10(p10)
  task.wait(0.1)

  if value then
    f9()
  end
end

local function f11(p11)
  p11.CharacterAdded:Connect(f10)

  p11.CharacterRemoving:Connect(function()
    f4(p11)
    v7[p11] = nil
  end)
end

players.PlayerAdded:Connect(f11)

for index4, value11 in ipairs(players:GetPlayers()) do
  f11(value11)
end

addLeftGroupbox2:AddButton({
  Text = "[CLICK THIS FIRST] Enable Hitbox",
  Func = function()
    coroutine.wrap(function()
      while true do
        if value then
          f9()
          f8()
        end

        task.wait(0.1)
      end
    end)()
  end,
})

addLeftGroupbox2:AddToggle("HitboxEnabled", { Text = "Enable Hitbox", Default = false })

toggles.HitboxEnabled:OnChanged(function()
  value = toggles.HitboxEnabled.Value

  if not value then
    for index5, value12 in ipairs(players:GetPlayers()) do
      f4(value12)
    end

    v7 = {}
  else
    f9()
  end
end)

addLeftGroupbox2:AddSlider("HitboxSize", {
  Text = "Hitbox Size",
  Min = 1,
  Max = 25,
  Default = 21,
  Rounding = 0,
})

options.HitboxSize:OnChanged(function()
  value3 = options.HitboxSize.Value

  if value then
    f9()
  end
end)

addLeftGroupbox2:AddSlider("HitboxTransparency", {
  Text = "Hitbox Transparency",
  Min = 1,
  Max = 10,
  Default = 6,
  Rounding = 0,
})

options.HitboxTransparency:OnChanged(function()
  value4 = options.HitboxTransparency.Value

  if value then
    f9()
  end
end)

addLeftGroupbox2:AddDropdown("HitboxTeamCheck", {
  Text = "Team Check",
  Values = { "FFA", "Team-Based", "Everyone" },
  Default = "FFA",
  Multi = false,
})

options.HitboxTeamCheck:OnChanged(function()
  value5 = options.HitboxTeamCheck.Value

  if value then
    f9()
  end
end)

addLeftGroupbox2:AddToggle("NoCollision", { Text = "No Collision", Default = false })

toggles.NoCollision:OnChanged(function()
  value2 = toggles.NoCollision.Value

  coroutine.wrap(function()
    while value2 do
      if value then
        f9()
      end

      task.wait(0.01)
    end

    if value then
      f9()
    end
  end)()
end)

addLeftGroupbox3:AddToggle("AutoFarm", { Text = "AutoFarm", Default = false })

toggles.AutoFarm:OnChanged(function()
  local value13 = toggles.AutoFarm.Value
  getgenv().AutoFarm = value13
  local v9 = false
  local localPlayer4 = players.LocalPlayer
  local currentCamera = workspaceService.CurrentCamera

  local currentCurse = replicatedStorage.wkspc.CurrentCurse
  currentCurse.Value = value13 and "Infinite Ammo" or ""

  local function f12()
    local huge = math.huge
    local v10

    for key3, value14 in pairs(players:GetPlayers()) do
      if value14 ~= localPlayer4 and value14.TeamColor ~= localPlayer4.TeamColor
        and value14.Character then
        local character3 = value14.Character
        local humanoidRootPart = character3:FindFirstChild("HumanoidRootPart")
        local humanoid2 = character3:FindFirstChild("Humanoid")

        if humanoidRootPart and humanoid2 and humanoid2.Health > 0 then
          local magnitude = (localPlayer4.Character.HumanoidRootPart.Position
            - humanoidRootPart.Position).Magnitude

          if magnitude < huge then
            huge = magnitude
            v10 = value14
          end
        end
      end
    end

    return v10
  end

  local connect

  local function f13()
    local v11 = game
    v11:GetService("ReplicatedStorage").wkspc.TimeScale.Value = 12

    connect = runService.Stepped:Connect(function()
      if getgenv().AutoFarm then
        local v12 = f12()

        if v12 and localPlayer4.Character
          and localPlayer4.Character:FindFirstChild("HumanoidRootPart") then
          local humanoidRootPart2 = v12.Character.HumanoidRootPart
          local vector5 = Vector3.new(0, 2, 0)

          localPlayer4.Character.HumanoidRootPart.CFrame = CFrame.new(humanoidRootPart2.Position
              - humanoidRootPart2.CFrame.LookVector * 2
            + vector5)

          if v12.Character:FindFirstChild("Head") then
            currentCamera.CFrame = CFrame.new(
              currentCamera.CFrame.Position, v12.Character.Head.Position
            )
          end

          if not v9 then
            mouse1press()
            v9 = true
          end
        elseif v9 then
          mouse1release()
          v9 = false
        end
      else
        if connect then
          connect:Disconnect()
          connect = nil
        end

        if v9 then
          mouse1release()
          v9 = false
        end
      end
    end)
  end

  localPlayer4.CharacterAdded:Connect(function(character4)
    wait(0.5)
    f13()
  end)

  if value13 then
    wait(0.5)
    f13()
  else
    local v13 = game
    v13:GetService("ReplicatedStorage").wkspc.CurrentCurse.Value = ""

    getgenv().AutoFarm = false

    local v14 = game
    v14:GetService("ReplicatedStorage").wkspc.TimeScale.Value = 1

    if connect then
      connect:Disconnect()
      connect = nil
    end

    if v9 then
      mouse1release()
      v9 = false
    end
  end
end)

getgenv().triggerb = false
local value15 = "Team-Based"
local v15 = 0.2
local v16 = true
addRightGroupbox2:AddToggle("TriggerbotEnabled", { Text = "Enable Triggerbot", Default = false })

toggles.TriggerbotEnabled:OnChanged(function()
  getgenv().triggerb = toggles.TriggerbotEnabled.Value
end)

addRightGroupbox2:AddDropdown("TriggerbotTeamCheck", {
  Text = "Team Check Mode",
  Values = { "FFA", "Team-Based", "Everyone" },
  Default = "Team-Based",
  Multi = false,
})

options.TriggerbotTeamCheck:OnChanged(function() value15 = options.TriggerbotTeamCheck.Value end)

addRightGroupbox2:AddSlider("TriggerbotDelay", {
  Text = "Shot Delay (1-10)",
  Min = 1,
  Max = 10,
  Default = 10,
  Rounding = 0,
})

options.TriggerbotDelay:OnChanged(function() v15 = options.TriggerbotDelay.Value / 10 end)

local function f14(p12)
  if value15 == "FFA" then
    return true
  elseif value15 == "Everyone" then
    return p12 ~= players.LocalPlayer
  else
    if value15 == "Team-Based" then
      return p12.Team ~= players.LocalPlayer.Team
    end

    return false
  end
end

local function f15()
  local localPlayer5 = players.LocalPlayer
  local humanoid3 = (localPlayer5.Character or localPlayer5.CharacterAdded:Wait()):FindFirstChildOfClass("Humanoid")

  if humanoid3 then
    humanoid3.HealthChanged:Connect(function(p13) v16 = p13 > 0 end)
  end
end

players.LocalPlayer.CharacterAdded:Connect(f15)
f15()

runService.RenderStepped:Connect(function()
  if getgenv().triggerb and v16 then
    local localPlayer6 = players.LocalPlayer
    local target = localPlayer6:GetMouse().Target

    if target and target.Parent:FindFirstChild("Humanoid")
      and target.Parent.Name ~= localPlayer6.Name then
      local findFirstChild3 = players:FindFirstChild(target.Parent.Name)

      if findFirstChild3 and f14(findFirstChild3) then
        mouse1press()
        wait(v15)
        mouse1release()
      end
    end
  end
end)

local addLeftGroupbox4 = v5.Gun:AddLeftGroupbox("Overpower Gun", "bolt")
addLeftGroupbox4:AddToggle("InfiniteAmmoV1", { Text = "Infinite Ammo v1", Default = false })

toggles.InfiniteAmmoV1:OnChanged(function()
  local currentCurse2 = replicatedStorage.wkspc.CurrentCurse
  currentCurse2.Value = toggles.InfiniteAmmoV1.Value and "Infinite Ammo" or ""
end)

local value16 = false
addLeftGroupbox4:AddToggle("InfiniteAmmoV2", { Text = "Infinite Ammo v2", Default = false })

toggles.InfiniteAmmoV2:OnChanged(function()
  value16 = toggles.InfiniteAmmoV2.Value

  if value16 then
    runService.Stepped:Connect(function()
      pcall(function()
        if value16 then
          local playerGui = players.LocalPlayer.PlayerGui
          playerGui.GUI.Client.Variables.ammocount.Value = 99
          playerGui.GUI.Client.Variables.ammocount2.Value = 99
        end
      end)
    end)
  end
end)

local v17 = {
  FireRate = {},
  ReloadTime = {},
  EReloadTime = {},
  Auto = {},
  Spread = {},
  Recoil = {},
}

addLeftGroupbox4:AddToggle("FastReload", { Text = "Fast Reload", Default = false })

toggles.FastReload:OnChanged(function()
  local value17 = toggles.FastReload.Value

  for key4, value18 in pairs(replicatedStorage.Weapons:GetChildren()) do
    if value18:FindFirstChild("ReloadTime") then
      if value17 then
        if not v17.ReloadTime[value18] then
          v17.ReloadTime[value18] = value18.ReloadTime.Value
        end

        value18.ReloadTime.Value = 0.01
      else
        value18.ReloadTime.Value = v17.ReloadTime[value18] or 0.8
      end
    end

    if value18:FindFirstChild("EReloadTime") then
      if value17 then
        if not v17.EReloadTime[value18] then
          v17.EReloadTime[value18] = value18.EReloadTime.Value
        end

        value18.EReloadTime.Value = 0.01
      else
        value18.EReloadTime.Value = v17.EReloadTime[value18] or 0.8
      end
    end
  end
end)

addLeftGroupbox4:AddToggle("FastFireRate", { Text = "Fast Fire Rate", Default = false })

toggles.FastFireRate:OnChanged(function()
  local value19 = toggles.FastFireRate.Value

  for key5, value20 in pairs(replicatedStorage.Weapons:GetDescendants()) do
    if value20.Name == "FireRate" or value20.Name == "BFireRate" then
      if value19 then
        if not v17.FireRate[value20] then
          v17.FireRate[value20] = value20.Value
        end

        value20.Value = 0.02
      else
        value20.Value = v17.FireRate[value20] or 0.8
      end
    end
  end
end)

addLeftGroupbox4:AddToggle("AlwaysAuto", { Text = "Always Auto", Default = false })

toggles.AlwaysAuto:OnChanged(function()
  local value21 = toggles.AlwaysAuto.Value

  for key6, value22 in pairs(replicatedStorage.Weapons:GetDescendants()) do
    if value22.Name == "Auto" or value22.Name == "AutoFire" or value22.Name == "Automatic"
      or value22.Name == "AutoShoot" or value22.Name == "AutoGun" then
      if value21 then
        if not v17.Auto[value22] then
          v17.Auto[value22] = value22.Value
        end

        value22.Value = true
      else
        value22.Value = v17.Auto[value22] or false
      end
    end
  end
end)

addLeftGroupbox4:AddToggle("NoSpread", { Text = "No Spread", Default = false })

toggles.NoSpread:OnChanged(function()
  local value23 = toggles.NoSpread.Value

  for key7, value24 in pairs(replicatedStorage.Weapons:GetDescendants()) do
    if value24.Name == "MaxSpread" or value24.Name == "Spread"
      or value24.Name == "SpreadControl" then
      if value23 then
        if not v17.Spread[value24] then
          v17.Spread[value24] = value24.Value
        end

        value24.Value = 0
      else
        value24.Value = v17.Spread[value24] or 1
      end
    end
  end
end)

addLeftGroupbox4:AddToggle("NoRecoil", { Text = "No Recoil", Default = false })

toggles.NoRecoil:OnChanged(function()
  local value25 = toggles.NoRecoil.Value

  for key8, value26 in pairs(replicatedStorage.Weapons:GetDescendants()) do
    if value26.Name == "RecoilControl" or value26.Name == "Recoil" then
      if value25 then
        if not v17.Recoil[value26] then
          v17.Recoil[value26] = value26.Value
        end

        value26.Value = 0
      else
        value26.Value = v17.Recoil[value26] or 1
      end
    end
  end
end)

local addLeftGroupbox5 = v5.Player:AddLeftGroupbox("Fly Hacks", "move")
local addLeftGroupbox6 = v5.Player:AddLeftGroupbox("Speed Power", "bolt")
local addLeftGroupbox7 = v5.Player:AddLeftGroupbox("Jump Power", "chevronR")
local addLeftGroupbox8 = v5.Player:AddLeftGroupbox("Anti Aim", "circle")
local addRightGroupbox3 = v5.Player:AddRightGroupbox("Object Teleport", "package")
local addRightGroupbox4 = v5.Player:AddRightGroupbox("Useful Cheat", "star")
local addRightGroupbox5 = v5.Player:AddRightGroupbox("Misc", "settings")
addLeftGroupbox5:AddToggle("Fly", { Text = "Fly", Default = false })

toggles.Fly:OnChanged(function()
  if toggles.Fly.Value then
    f1()
  else
    f2()
  end
end)

addLeftGroupbox5:AddSlider("FlySpeed", {
  Text = "Fly Speed",
  Min = 1,
  Max = 500,
  Default = 50,
  Rounding = 0,
})

options.FlySpeed:OnChanged(function() end)
local v18 = { WalkSpeed = 16 }
local value27 = false
local values = { "Velocity", "Vector", "CFrame" }
local value28 = "Velocity"
addLeftGroupbox6:AddToggle("WalkSpeedEnabled", { Text = "Custom WalkSpeed", Default = false })
toggles.WalkSpeedEnabled:OnChanged(function() value27 = toggles.WalkSpeedEnabled.Value end)

addLeftGroupbox6:AddDropdown("WalkMethod", {
  Text = "Walk Method",
  Values = values,
  Default = "Velocity",
  Multi = false,
})

options.WalkMethod:OnChanged(function() value28 = options.WalkMethod.Value end)

addLeftGroupbox6:AddSlider("WalkSpeedValue", {
  Text = "Walkspeed Power",
  Min = 16,
  Max = 500,
  Default = 16,
  Rounding = 0,
})

options.WalkSpeedValue:OnChanged(function() v18.WalkSpeed = options.WalkSpeedValue.Value end)

local function f16(p14, p15)
  local character5 = p14.Character
  local humanoid4 = character5 and character5:FindFirstChildOfClass("Humanoid")
  local humanoidRootPart3 = character5 and character5:FindFirstChild("HumanoidRootPart")

  if humanoid4 and humanoidRootPart3 then
    local v19 = humanoid4.MoveDirection * 16

    if value28 == "Velocity" then
      humanoidRootPart3.Velocity = Vector3.new(v19.X, humanoidRootPart3.Velocity.Y, v19.Z)
    elseif value28 == "Vector" then
      humanoidRootPart3.CFrame = humanoidRootPart3.CFrame + v19 * p15 * 0.0001
    elseif value28 == "CFrame" then
      humanoidRootPart3.CFrame = humanoidRootPart3.CFrame
        + humanoid4.MoveDirection * 16 * p15 * 0.0001
    else
      humanoid4.WalkSpeed = 16
    end
  end
end

runService.Stepped:Connect(function(delta2)
  if value27 then
    local localPlayer7 = players.LocalPlayer

    if localPlayer7 and localPlayer7.Character
      and localPlayer7.Character:FindFirstChild("HumanoidRootPart") then
      f16(localPlayer7, delta2)
    end
  end
end)

local value29 = false
addLeftGroupbox7:AddToggle("InfiniteJump", { Text = "Infinite Jump", Default = false })

toggles.InfiniteJump:OnChanged(function()
  value29 = toggles.InfiniteJump.Value

  userInputService.JumpRequest:Connect(function()
    if value29 then
      players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
  end)
end)

local value30 = false
local values2 = { "Velocity", "Vector", "CFrame" }
local value31 = "Velocity"
addLeftGroupbox7:AddToggle("JumpPowerEnabled", { Text = "Custom JumpPower", Default = false })
toggles.JumpPowerEnabled:OnChanged(function() value30 = toggles.JumpPowerEnabled.Value end)

addLeftGroupbox7:AddDropdown("JumpMethod", {
  Text = "Jump Method",
  Values = values2,
  Default = "Velocity",
  Multi = false,
})

options.JumpMethod:OnChanged(function() value31 = options.JumpMethod.Value end)

addLeftGroupbox7:AddSlider("JumpPowerValue", {
  Text = "Change JumpPower",
  Min = 30,
  Max = 500,
  Default = 50,
  Rounding = 0,
})

options.JumpPowerValue:OnChanged(function()
  local value32 = options.JumpPowerValue.Value
  local localPlayer8 = players.LocalPlayer

  if localPlayer8.Character then
    local humanoid5 = localPlayer8.Character:WaitForChild("Humanoid")
    humanoid5.UseJumpPower = true

    humanoid5.Jumping:Connect(function(p16)
      if value30 and p16 then
        local humanoidRootPart4 = localPlayer8.Character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart4 then
          if value31 == "Velocity" then
            humanoidRootPart4.Velocity = humanoidRootPart4.Velocity * Vector3.new(1, 0, 1)
              + Vector3.new(0, value32, 0)
          elseif value31 == "Vector" then
            humanoidRootPart4.Velocity = Vector3.new(0, value32, 0)
          elseif value31 == "CFrame" then
            localPlayer8.Character:SetPrimaryPartCFrame(localPlayer8.Character:GetPrimaryPartCFrame()
              + Vector3.new(0, value32, 0))
          end
        end
      end
    end)
  end
end)

local value33 = 10
addLeftGroupbox8:AddToggle("AntiAimEnabled", { Text = "Anti-Aim v1", Default = false })
local antiAimGyro

toggles.AntiAimEnabled:OnChanged(function()
  local value34 = toggles.AntiAimEnabled.Value
  local character6 = players.LocalPlayer.Character
  local humanoidRootPart5 = character6 and character6:FindFirstChild("HumanoidRootPart")

  if value34 then
    if humanoidRootPart5 then
      local antiAimSpin = Instance.new("BodyAngularVelocity")
      antiAimSpin.Name = "AntiAimSpin"
      antiAimSpin.AngularVelocity = Vector3.new(0, value33, 0)
      antiAimSpin.MaxTorque = Vector3.new(0, math.huge, 0)
      antiAimSpin.P = 500000
      antiAimSpin.Parent = humanoidRootPart5

      antiAimGyro = Instance.new("BodyGyro")
      antiAimGyro.Name = "AntiAimGyro"
      antiAimGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
      antiAimGyro.CFrame = humanoidRootPart5.CFrame
      antiAimGyro.P = 3000
      antiAimGyro.Parent = humanoidRootPart5
    end
  elseif humanoidRootPart5 then
    local antiAimSpin2 = humanoidRootPart5:FindFirstChild("AntiAimSpin")

    if antiAimSpin2 then
      antiAimSpin2:Destroy()
    end

    if antiAimGyro then
      antiAimGyro:Destroy()
      antiAimGyro = nil
    end
  end
end)

addLeftGroupbox8:AddSlider("SpinSpeed", {
  Text = "Spin Speed",
  Min = 10,
  Max = 100,
  Default = 10,
  Rounding = 0,
})

options.SpinSpeed:OnChanged(function()
  value33 = options.SpinSpeed.Value
  local character7 = players.LocalPlayer.Character
  local humanoidRootPart6 = character7 and character7:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart6 then
    local antiAimSpin3 = humanoidRootPart6:FindFirstChild("AntiAimSpin")

    if antiAimSpin3 then
      antiAimSpin3.AngularVelocity = Vector3.new(0, value33, 0)
    end
  end
end)

local value35 = "Both"
local value36 = false
addRightGroupbox3:AddToggle("CollectDebris", { Text = "Enable Collect Debris", Default = false })

toggles.CollectDebris:OnChanged(function()
  value36 = toggles.CollectDebris.Value

  if value36 then
    spawn(function()
      while value36 do
        wait(0.1)

        pcall(function()
          local character8 = players.LocalPlayer.Character

          if character8 then
            local humanoidRootPart7 = character8:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart7 then
              for key9, value37 in pairs(workspaceService.Debris:GetChildren()) do
                if value35 == "DeadHP" and value37.Name == "DeadHP"
                  or value35 == "DeadAmmo" and value37.Name == "DeadAmmo"
                  or value35 == "Both"
                    and (value37.Name == "DeadHP" or value37.Name == "DeadAmmo") then
                  value37.CFrame = humanoidRootPart7.CFrame * CFrame.new(0, 0.2, 0)
                end
              end
            end
          end
        end)
      end
    end)
  end
end)

addRightGroupbox3:AddDropdown("DebrisSelect", {
  Text = "Select Object",
  Values = { "DeadHP", "DeadAmmo", "Both" },
  Default = "Both",
  Multi = false,
})

options.DebrisSelect:OnChanged(function() value35 = options.DebrisSelect.Value end)

addRightGroupbox4:AddInput("TimeScale", {
  Text = "TimeScale",
  Default = "1",
  Placeholder = "Enter TimeScale value",
  Finished = true,
})

options.TimeScale:OnChanged(function() end)

addRightGroupbox4:AddButton({
  Text = "Apply TimeScale",
  Func = function()
    local value38 = options.TimeScale.Value

    if value38 and value38 ~= "" then
      local timeScale = replicatedStorage.wkspc.TimeScale
      timeScale.Value = tonumber(value38) or value38

      library:Notify({
        Title = "TimeScale",
        Description = "Set to " .. tostring(value38),
        Time = 3,
      })
    end
  end,
})

addRightGroupbox5:AddSlider("FOVArsenal", {
  Text = "FOV Arsenal",
  Min = 0,
  Max = 120,
  Default = 70,
  Rounding = 0,
})

options.FOVArsenal:OnChanged(function()
  local v20 = game
  v20:GetService("Players").LocalPlayer.Settings.FOV.Value = options.FOVArsenal.Value
end)

local value39 = false
addRightGroupbox5:AddToggle("NoClip", { Text = "Toggle NoClip", Default = false })

toggles.NoClip:OnChanged(function()
  value39 = toggles.NoClip.Value
  local localPlayer9 = players.LocalPlayer

  local function f17()
    while value39 do
      local character9 = localPlayer9.Character

      if character9 then
        for key10, value40 in pairs(character9:GetDescendants()) do
          if value40:IsA("BasePart") then
            value40.CanCollide = false
          end
        end
      end

      runService.Stepped:Wait()
    end

    local character10 = localPlayer9.Character

    if character10 then
      for key11, value41 in pairs(character10:GetDescendants()) do
        if value41:IsA("BasePart") then
          value41.CanCollide = true
        end
      end
    end
  end

  if value39 then
    spawn(f17)
  end
end)

addRightGroupbox5:AddToggle("Xray", { Text = "Toggle Xray", Default = false })

toggles.Xray:OnChanged(function()
  if toggles.Xray.Value then
    for key12, value42 in pairs(workspace:GetDescendants()) do
      if value42:IsA("BasePart") then
        if not value42:FindFirstChild("OriginalTransparency") then
          local originalTransparency = Instance.new("NumberValue")
          originalTransparency.Name = "OriginalTransparency"
          originalTransparency.Value = value42.Transparency
          originalTransparency.Parent = value42
        end

        value42.Transparency = 0.5
      end
    end
  else
    for key13, value43 in pairs(workspace:GetDescendants()) do
      if value43:IsA("BasePart") then
        if value43:FindFirstChild("OriginalTransparency") then
          value43.Transparency = value43.OriginalTransparency.Value
          value43.OriginalTransparency:Destroy()
        end
      end
    end
  end
end)

local addLeftGroupbox9 = v5.Skins:AddLeftGroupbox("Arm Skins", "user")
local addLeftGroupbox10 = v5.Skins:AddLeftGroupbox("Gun Skin", "bolt")
local addRightGroupbox6 = v5.Skins:AddRightGroupbox("Rainbow Gun", "star")

local function f18(p17)
  return Vector3.new(p17.R, p17.G, p17.B)
end

local value44 = "Plastic"

addLeftGroupbox9:AddDropdown("ArmMaterial", {
  Text = "Arm Material",
  Values = { "Plastic", "ForceField", "Wood", "Grass" },
  Default = "Plastic",
  Multi = false,
})

options.ArmMaterial:OnChanged(function() value44 = options.ArmMaterial.Value end)
local color = Color3.fromRGB(50, 50, 50)

addLeftGroupbox9:AddSlider("ArmColorR", {
  Text = "Arm Color R",
  Min = 0,
  Max = 255,
  Default = 50,
  Rounding = 0,
})

addLeftGroupbox9:AddSlider("ArmColorG", {
  Text = "Arm Color G",
  Min = 0,
  Max = 255,
  Default = 50,
  Rounding = 0,
})

addLeftGroupbox9:AddSlider("ArmColorB", {
  Text = "Arm Color B",
  Min = 0,
  Max = 255,
  Default = 50,
  Rounding = 0,
})

options.ArmColorR:OnChanged(function()
  color = Color3.fromRGB(
    options.ArmColorR.Value, options.ArmColorG.Value, options.ArmColorB.Value
  )
end)

options.ArmColorG:OnChanged(function()
  color = Color3.fromRGB(
    options.ArmColorR.Value, options.ArmColorG.Value, options.ArmColorB.Value
  )
end)

options.ArmColorB:OnChanged(function()
  color = Color3.fromRGB(
    options.ArmColorR.Value, options.ArmColorG.Value, options.ArmColorB.Value
  )
end)

local value45 = false
addLeftGroupbox9:AddToggle("ArmCharms", { Text = "Arm Charms", Default = false })

toggles.ArmCharms:OnChanged(function()
  value45 = toggles.ArmCharms.Value

  if value45 then
    spawn(function()
      while true do
        wait(0.01)

        if not value45 then
          break
        else
          local arms = workspace.Camera:FindFirstChild("Arms")

          if arms then
            for key14, value46 in pairs(arms:GetDescendants()) do
              if value46.Name == "Right Arm" or value46.Name == "Left Arm" then
                if value46:IsA("BasePart") then
                  value46.Material = Enum.Material[value44]
                  value46.Color = color
                end
              elseif value46:IsA("SpecialMesh") then
                if value46.TextureId == "" then
                  value46.TextureId = "rbxassetid://0"
                  value46.VertexColor = f18(color)
                end
              elseif value46.Name == "L" or value46.Name == "R" then
                value46:Destroy()
              end
            end
          end
        end
      end
    end)
  end
end)

local value47 = "Plastic"

addLeftGroupbox10:AddDropdown("GunMaterial", {
  Text = "Gun Material",
  Values = { "Plastic", "ForceField", "Wood", "Grass" },
  Default = "Plastic",
  Multi = false,
})

options.GunMaterial:OnChanged(function() value47 = options.GunMaterial.Value end)
local color2 = Color3.fromRGB(50, 50, 50)

addLeftGroupbox10:AddSlider("GunColorR", {
  Text = "Gun Color R",
  Min = 0,
  Max = 255,
  Default = 50,
  Rounding = 0,
})

addLeftGroupbox10:AddSlider("GunColorG", {
  Text = "Gun Color G",
  Min = 0,
  Max = 255,
  Default = 50,
  Rounding = 0,
})

addLeftGroupbox10:AddSlider("GunColorB", {
  Text = "Gun Color B",
  Min = 0,
  Max = 255,
  Default = 50,
  Rounding = 0,
})

options.GunColorR:OnChanged(function()
  color2 = Color3.fromRGB(
    options.GunColorR.Value, options.GunColorG.Value, options.GunColorB.Value
  )
end)

options.GunColorG:OnChanged(function()
  color2 = Color3.fromRGB(
    options.GunColorR.Value, options.GunColorG.Value, options.GunColorB.Value
  )
end)

options.GunColorB:OnChanged(function()
  color2 = Color3.fromRGB(
    options.GunColorR.Value, options.GunColorG.Value, options.GunColorB.Value
  )
end)

local value48 = false
addLeftGroupbox10:AddToggle("GunCharms", { Text = "Gun Charms", Default = false })
local gunCharms = toggles.GunCharms

local function f19(p18)
  return math.acos(math.cos(p18 * math.pi)) / math.pi
end

gunCharms:OnChanged(function()
  value48 = toggles.GunCharms.Value

  if value48 then
    spawn(function()
      while true do
        wait(0.01)

        if not value48 then
          break
        end

        if not workspace.Camera:FindFirstChild("Arms") then
          wait()
        else
          for key15, value49 in pairs(workspace.Camera.Arms:GetDescendants()) do
            if value49:IsA("MeshPart") then
              value49.Material = Enum.Material[value47]
              value49.Color = color2
            end
          end
        end
      end
    end)
  end
end)

local value50 = false
local v21 = 1
addRightGroupbox6:AddToggle("RainbowV1", { Text = "Rainbow Gun v1", Default = false })
toggles.RainbowV1:OnChanged(function() value50 = toggles.RainbowV1.Value end)

runService.RenderStepped:Connect(function()
  if workspaceService.Camera:FindFirstChild("Arms") and value50 then
    for key16, value51 in pairs(workspaceService.Camera.Arms:GetDescendants()) do
      if value51.ClassName == "MeshPart" then
        value51.Color = Color3.fromHSV(f19(v21), 1, 1)
        v21 = v21 + 0.0001
      end
    end
  end
end)

local value52 = false
local v22 = 0

addRightGroupbox6:AddToggle("RainbowV2", {
  Text = "Rainbow Gun v2 [Crazy Fast]",
  Default = false,
})

toggles.RainbowV2:OnChanged(function() value52 = toggles.RainbowV2.Value end)

runService.RenderStepped:Connect(function()
  if workspaceService.Camera:FindFirstChild("Arms") and value52 then
    v22 = v22 + 0.1

    if v22 >= 1 then
      v22 = v22 % 1
    end

    for key17, value53 in pairs(workspaceService.Camera.Arms:GetDescendants()) do
      if value53.ClassName == "MeshPart" then
        value53.Color = Color3.fromHSV(v22, 1, 1)
      end
    end
  end
end)

local addLeftGroupbox11 = v5.Extra:AddLeftGroupbox("Random", "star")
local addRightGroupbox7 = v5.Extra:AddRightGroupbox("Chat", "info")

local function f20()
  for key18, value54 in pairs(game:GetDescendants()) do
    if value54:IsA("ParticleEmitter") then
      value54.Parent = workspace
    end
  end
end

local function f21()
  for key19, value55 in pairs(game:GetDescendants()) do
    if value55:IsA("ParticleEmitter") then
      value55.Parent = players.LocalPlayer.Character["Particle Area"]
    end
  end
end

addLeftGroupbox11:AddToggle("MessUpScreen", {
  Text = "Mess up your screen lol",
  Default = false,
})

toggles.MessUpScreen:OnChanged(function()
  if toggles.MessUpScreen.Value then
    f21()
  else
    f20()
  end
end)

local v23 = { Score = nil, Kills = nil }
addLeftGroupbox11:AddToggle("MaxLevel", { Text = "Max Level???", Default = false })

toggles.MaxLevel:OnChanged(function()
  local careerStatsCache = localPlayer3.CareerStatsCache

  if toggles.MaxLevel.Value then
    if not v23.Score then
      v23.Score = careerStatsCache.Score.Value
    end

    if not v23.Kills then
      v23.Kills = careerStatsCache.Kills.Value
    end

    careerStatsCache.Score.Value = 1000000000000000000
    careerStatsCache.Kills.Value = 100000000000000
  elseif v23.Score and v23.Kills then
    careerStatsCache.Score.Value = v23.Score
    careerStatsCache.Kills.Value = v23.Kills
  end
end)

local v24 = {
  GUIName = nil,
  GUIName2 = nil,
  KillFeed = {},
  WinnerName = nil,
  ScorecardName = nil,
}

local value56 = false

local function f22()
  local playerGui2 = localPlayer3.PlayerGui

  if v24.GUIName then
    playerGui2.Menew_Main.Container.PlrName.Text = v24.GUIName
  end

  if v24.GUIName2 then
    playerGui2.Menew_Main.Container.PlrName2.Text = v24.GUIName2
  end

  for key20, value57 in pairs(v24.KillFeed) do
    Workspace.KillFeed[tostring(key20)].Killer.Value = value57
  end

  if v24.WinnerName ~= nil then
    playerGui2.GUI.Winner.Visible = v24.WinnerName
  end

  if v24.ScorecardName then
    playerGui2.GUI_Scorecard.Scorecard.PlayerCard.Username.Text = v24.ScorecardName
  end
end

local v25 = false
addLeftGroupbox11:AddToggle("ChangeName", { Text = "Change Name", Default = false })

toggles.ChangeName:OnChanged(function()
  value56 = toggles.ChangeName.Value
  v25 = value56

  if value56 then
    local playerGui3 = localPlayer3.PlayerGui

    v24.GUIName = playerGui3.Menew_Main.Container.PlrName.Text
    v24.GUIName2 = playerGui3.Menew_Main.Container.PlrName2.Text
    v24.WinnerName = playerGui3.GUI.Winner.Visible
    v24.ScorecardName = playerGui3.GUI_Scorecard.Scorecard.PlayerCard.Username.Text

    local count = 0

    while true do
      count = 1 + count

      if not (6 >= count) then
        break
      end

      local v26 = count
      v24.KillFeed[v26] = Workspace.KillFeed[tostring(v26)].Killer.Value
    end

    spawn(function()
      while v25 do
        wait(0.2)
      end
    end)
  else
    v25 = false
    f22()
  end
end)

addRightGroupbox7:AddToggle("IsChad", { Text = "IsChad", Default = false })

toggles.IsChad:OnChanged(function()
  local localPlayer10 = players.LocalPlayer

  if localPlayer10:FindFirstChild("IsChad") then
    localPlayer10.IsChad:Destroy()
    return
  end

  if toggles.IsChad.Value then
    Instance.new("IntValue", localPlayer10).Name = "IsChad"
  end
end)

addRightGroupbox7:AddToggle("VIP", { Text = "VIP", Default = false })

toggles.VIP:OnChanged(function()
  local localPlayer11 = players.LocalPlayer

  if localPlayer11:FindFirstChild("VIP") then
    localPlayer11.VIP:Destroy()
    return
  end

  if toggles.VIP.Value then
    Instance.new("IntValue", localPlayer11).Name = "VIP"
  end
end)

addRightGroupbox7:AddToggle("OldVIP", { Text = "OldVIP", Default = false })

toggles.OldVIP:OnChanged(function()
  local localPlayer12 = players.LocalPlayer

  if localPlayer12:FindFirstChild("OldVIP") then
    localPlayer12.OldVIP:Destroy()
    return
  end

  if toggles.OldVIP.Value then
    Instance.new("IntValue", localPlayer12).Name = "OldVIP"
  end
end)

addRightGroupbox7:AddToggle("Romin", { Text = "Romin", Default = false })

toggles.Romin:OnChanged(function()
  local localPlayer13 = players.LocalPlayer

  if localPlayer13:FindFirstChild("Romin") then
    localPlayer13.Romin:Destroy()
    return
  end

  if toggles.Romin.Value then
    Instance.new("IntValue", localPlayer13).Name = "Romin"
  end
end)

addRightGroupbox7:AddToggle("IsAdmin", { Text = "IsAdmin", Default = false })

toggles.IsAdmin:OnChanged(function()
  local localPlayer14 = players.LocalPlayer

  if localPlayer14:FindFirstChild("IsAdmin") then
    localPlayer14.IsAdmin:Destroy()
    return
  end

  if toggles.IsAdmin.Value then
    Instance.new("IntValue", localPlayer14).Name = "IsAdmin"
  end
end)

local addLeftGroupbox12 = v5.Visuals:AddLeftGroupbox("ESP V1", "eye")
local addRightGroupbox8 = v5.Visuals:AddRightGroupbox("ESP Options", "settings")
local esp1 = loadstring(game:HttpGet("https://rawscript.vercel.app/api/raw/esp_1"))()
addLeftGroupbox12:AddToggle("ESPEnabled", { Text = "Enable ESP", Default = false })

toggles.ESPEnabled:OnChanged(function()
  local value58 = toggles.ESPEnabled.Value
  esp1:Toggle(value58)
  esp1.Players = value58
end)

addLeftGroupbox12:AddToggle("ESPTracers", { Text = "Tracers ESP", Default = false })
toggles.ESPTracers:OnChanged(function() esp1.Tracers = toggles.ESPTracers.Value end)
addLeftGroupbox12:AddToggle("ESPNames", { Text = "Name ESP", Default = false })
toggles.ESPNames:OnChanged(function() esp1.Names = toggles.ESPNames.Value end)
addLeftGroupbox12:AddToggle("ESPBoxes", { Text = "Boxes ESP", Default = false })
toggles.ESPBoxes:OnChanged(function() esp1.Boxes = toggles.ESPBoxes.Value end)
addLeftGroupbox12:AddToggle("ESPTeamColor", { Text = "Team Coordinate", Default = false })
toggles.ESPTeamColor:OnChanged(function() esp1.TeamColor = toggles.ESPTeamColor.Value end)
addLeftGroupbox12:AddToggle("ESPTeamMates", { Text = "Teammates", Default = false })
toggles.ESPTeamMates:OnChanged(function() esp1.TeamMates = toggles.ESPTeamMates.Value end)

addLeftGroupbox12:AddSlider("ESPColorR", {
  Text = "ESP Color R",
  Min = 0,
  Max = 255,
  Default = 255,
  Rounding = 0,
})

addLeftGroupbox12:AddSlider("ESPColorG", {
  Text = "ESP Color G",
  Min = 0,
  Max = 255,
  Default = 255,
  Rounding = 0,
})

addLeftGroupbox12:AddSlider("ESPColorB", {
  Text = "ESP Color B",
  Min = 0,
  Max = 255,
  Default = 255,
  Rounding = 0,
})

options.ESPColorR:OnChanged(function()
  esp1.Color = Color3.fromRGB(
    options.ESPColorR.Value, options.ESPColorG.Value, options.ESPColorB.Value
  )
end)

options.ESPColorG:OnChanged(function()
  esp1.Color = Color3.fromRGB(
    options.ESPColorR.Value, options.ESPColorG.Value, options.ESPColorB.Value
  )
end)

options.ESPColorB:OnChanged(function()
  esp1.Color = Color3.fromRGB(
    options.ESPColorR.Value, options.ESPColorG.Value, options.ESPColorB.Value
  )
end)

local v27 = {}
local v28 = "advtech_esp"

local function f23(parent, text)
  local billboardGui = Instance.new("BillboardGui")
  local textLabel = Instance.new("TextLabel")

  billboardGui.Name = v28
  billboardGui.Parent = parent
  billboardGui.AlwaysOnTop = true
  billboardGui.Size = UDim2.new(0, 50, 0, 50)
  billboardGui.StudsOffset = Vector3.new(0, 2, 0)

  textLabel.Parent = billboardGui
  textLabel.BackgroundTransparency = 1
  textLabel.Size = UDim2.new(1, 0, 1, 0)
  textLabel.Text = text
  textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)

  return billboardGui
end

local f24

local function f25(p19, p20, p21)
  if p19 then
    for index6, value59 in ipairs(workspaceService:GetDescendants()) do
      if value59:IsA("TouchTransmitter") and value59.Parent.Name == p20 then
        f24(value59, p21)
      end
    end

    workspaceService.DescendantAdded:Connect(function(descendant)
      if descendant:IsA("TouchTransmitter") and descendant.Parent.Name == p20 then
        f24(descendant, p21)
      end
    end)
  else
    for key21, value60 in pairs(v27) do
      if key21 and value60 then
        value60:Destroy()
        v27[key21] = nil
      end
    end
  end
end

function f24(p22, p23)
  if p22:IsA("TouchTransmitter") then
    local parent2 = p22.Parent

    if not parent2:FindFirstChild(v28) then
      v27[parent2] = f23(parent2, p23)
    end
  end
end

addRightGroupbox8:AddToggle("AmmoBoxESP", { Text = "Ammo Box ESP", Default = false })
toggles.AmmoBoxESP:OnChanged(function() f25(toggles.AmmoBoxESP.Value, "DeadAmmo", "Ammo Box") end)
addRightGroupbox8:AddToggle("HPJugESP", { Text = "HP Jug ESP", Default = false })
toggles.HPJugESP:OnChanged(function() f25(toggles.HPJugESP.Value, "DeadHP", "HP Jar") end)
local addLeftGroupbox13 = v5.Setting:AddLeftGroupbox("Performance", "bolt")
local addRightGroupbox9 = v5.Setting:AddRightGroupbox("Server", "globe")
local addRightGroupbox10 = v5.Setting:AddRightGroupbox("Keybind", "settings")
local v29 = {}
local v30 = {}

local v31 = {
  GlobalShadows = lighting.GlobalShadows,
  FogEnd = lighting.FogEnd,
  Brightness = lighting.Brightness,
}

local v32 = {
  WaterWaveSize = workspaceService.Terrain.WaterWaveSize,
  WaterWaveSpeed = workspaceService.Terrain.WaterWaveSpeed,
  WaterReflectance = workspaceService.Terrain.WaterReflectance,
  WaterTransparency = workspaceService.Terrain.WaterTransparency,
}

local v33 = {}
addLeftGroupbox13:AddToggle("AntiLag", { Text = "Anti Lag", Default = false })

toggles.AntiLag:OnChanged(function()
  if toggles.AntiLag.Value then
    for key22, value61 in pairs(workspaceService:GetDescendants()) do
      if value61:IsA("BasePart") and not value61.Parent:FindFirstChild("Humanoid") then
        v29[value61] = value61.Material
        value61.Material = Enum.Material.SmoothPlastic

        if value61:IsA("Texture") then
          table.insert(v30, value61)
          value61:Destroy()
        end
      end
    end
  else
    for key23, value62 in pairs(v29) do
      if key23 and key23:IsA("BasePart") then
        key23.Material = value62
      end
    end

    v29 = {}
  end
end)

addLeftGroupbox13:AddToggle("FPSBoost", { Text = "FPS Boost", Default = false })

toggles.FPSBoost:OnChanged(function()
  if toggles.FPSBoost.Value then
    local v34 = game
    local lighting2 = v34.Lighting

    local terrain = v34.Workspace.Terrain
    terrain.WaterWaveSize = 0
    terrain.WaterWaveSpeed = 0
    terrain.WaterReflectance = 0
    terrain.WaterTransparency = 0

    lighting2.GlobalShadows = false
    lighting2.FogEnd = 9000000000
    lighting2.Brightness = 0

    v18().Rendering.QualityLevel = "Level01"

    for key24, value63 in pairs(v34:GetDescendants()) do
      if value63:IsA("Part") or value63:IsA("Union") or value63:IsA("CornerWedgePart")
        or value63:IsA("TrussPart") then
        v29[value63] = value63.Material
        value63.Material = "Plastic"
        value63.Reflectance = 0
      elseif value63:IsA("Decal") or value63:IsA("Texture") then
        table.insert(v30, value63)
        value63.Transparency = 1
      elseif value63:IsA("ParticleEmitter") or value63:IsA("Trail") then
        value63.Lifetime = NumberRange.new(0)
      elseif value63:IsA("Explosion") then
        value63.BlastPressure = 1
        value63.BlastRadius = 1
      elseif value63:IsA("Fire") or value63:IsA("SpotLight") or value63:IsA("Smoke") then
        value63.Enabled = false
      elseif value63:IsA("MeshPart") then
        v29[value63] = value63.Material
        value63.Material = "Plastic"
        value63.Reflectance = 0
      end
    end

    for key25, value64 in pairs(lighting2:GetChildren()) do
      if value64:IsA("BlurEffect") or value64:IsA("SunRaysEffect")
        or value64:IsA("ColorCorrectionEffect") or value64:IsA("BloomEffect")
        or value64:IsA("DepthOfFieldEffect") then
        v33[value64] = value64.Enabled
        value64.Enabled = false
      end
    end
  else
    local terrain2 = workspaceService.Terrain
    terrain2.WaterWaveSize = v32.WaterWaveSize
    terrain2.WaterWaveSpeed = v32.WaterWaveSpeed
    terrain2.WaterReflectance = v32.WaterReflectance
    terrain2.WaterTransparency = v32.WaterTransparency

    lighting.GlobalShadows = v31.GlobalShadows
    lighting.FogEnd = v31.FogEnd
    lighting.Brightness = v31.Brightness

    v18().Rendering.QualityLevel = "Automatic"

    for key26, value65 in pairs(v29) do
      if key26 and key26:IsA("BasePart") then
        key26.Material = value65
        key26.Reflectance = 0
      end
    end

    v29 = {}

    for key27, value66 in pairs(v33) do
      if key27 then
        key27.Enabled = value66
      end
    end

    v33 = {}

    for key28, value67 in pairs(v30) do
      if value67 and value67.Parent then
        value67.Transparency = 0
      end
    end

    v30 = {}
  end
end)

local value68 = false
addLeftGroupbox13:AddToggle("FullBright", { Text = "Full Bright", Default = false })

toggles.FullBright:OnChanged(function()
  value68 = toggles.FullBright.Value

  local function f26()
    if value68 then
      lighting.Ambient = Color3.new(1, 1, 1)
      lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
      lighting.ColorShift_Top = Color3.new(1, 1, 1)
    else
      lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
      lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
      lighting.ColorShift_Top = Color3.new(0, 0, 0)
    end
  end

  f26()

  lighting.LightingChanged:Connect(f26)
end)

addRightGroupbox9:AddButton({
  Text = "Server Hop",
  Func = function()
    local placeId = game.PlaceId
    local jsonDecode = {}
    local nextPageCursor = ""
    local hour = os.date("!*t").hour

    if not pcall(function() jsonDecode = httpService:JSONDecode(readfile("NotSameServers.json")) end) then
      table.insert(jsonDecode, hour)
      writefile("NotSameServers.json", httpService:JSONEncode(jsonDecode))
    end

    local function f27()
      local jsonDecode2

      if nextPageCursor == "" then
        jsonDecode2 = httpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"
          .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"))
      else
        jsonDecode2 = httpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"
          .. placeId .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. nextPageCursor))
      end

      local v35 = ""

      if jsonDecode2.nextPageCursor and jsonDecode2.nextPageCursor ~= "null"
        and jsonDecode2.nextPageCursor ~= nil then
        nextPageCursor = jsonDecode2.nextPageCursor
      end

      local count2 = 0

      for key29, value69 in pairs(jsonDecode2.data) do
        local v36 = true
        v35 = tostring(value69.id)

        if tonumber(value69.maxPlayers) > tonumber(value69.playing) then
          for key30, value70 in pairs(jsonDecode) do
            if count2 ~= 0 then
              if v35 == tostring(value70) then
                v36 = false
              end
            elseif tonumber(hour) ~= tonumber(value70) then
              pcall(function()
                delfile("NotSameServers.json")
                jsonDecode = {}
                table.insert(jsonDecode, hour)
              end)
            end

            count2 = count2 + 1
          end

          if v36 == true then
            table.insert(jsonDecode, v35)
            wait()

            pcall(function()
              writefile("NotSameServers.json", httpService:JSONEncode(jsonDecode))
              wait()
              teleportService:TeleportToPlaceInstance(placeId, v35, players.LocalPlayer)
            end)

            wait(4)
          end
        end
      end
    end

    while wait() do
      pcall(function()
        f27()

        if nextPageCursor ~= "" then
          f27()
        end
      end)
    end
  end,
})

addRightGroupbox9:AddButton({
  Text = "Rejoin Server",
  Func = function() teleportService:Teleport(game.PlaceId, players.LocalPlayer) end,
})

addRightGroupbox10:AddButton({
  Text = "Close UI (Press to Toggle)",
  Func = function() library:Toggle() end,
})

local addLeftGroupbox14 = v5.Credits:AddLeftGroupbox("Credits", "info")
local addRightGroupbox11 = v5.Credits:AddRightGroupbox("Developers", "user")

addLeftGroupbox14:AddLabel("Script Developed by: TITANIC HUB Team")
addLeftGroupbox14:AddLabel("UI Framework: Obsidian")

addRightGroupbox11:AddDropdown("Developer", {
  Text = "Developer",
  Values = { "L", "BinContent" },
  Default = "L",
  Multi = false,
})

options.Developer:OnChanged(function()
  local value71 = options.Developer.Value
  print(value71 .. " created " .. ({ BinContent = "Owner", L = "Head Developer" })[value71])
end)

addRightGroupbox11:AddButton({
  Text = "Copy Discord Link",
  Func = function()
    setclipboard("https://discord.gg/AGzuCsXtnp")
    library:Notify({ Title = "Discord", Description = "Link copied!", Time = 4 })
  end,
})

themeManager:SetLibrary(library)
saveManager:SetLibrary(library)
themeManager:SetFolder("THUB-Arsenal")
saveManager:SetFolder("THUB-Arsenal")

themeManager:SetDefaultTheme({
  FontColor = Color3.fromRGB(225, 225, 225),
  MainColor = Color3.fromRGB(28, 28, 28),
  AccentColor = Color3.fromRGB(100, 100, 255),
  BackgroundColor = Color3.fromRGB(20, 20, 20),
  OutlineColor = Color3.fromRGB(50, 50, 50),
  FontFace = Font.fromName("Gotham", Enum.FontWeight.Medium),
})

saveManager:BuildConfigSection(v5.Setting)

themeManager:ApplyToTab(v5.Setting)
themeManager:LoadDefault()

saveManager:LoadAutoloadConfig()

library:Notify({
  Title = "TIATNIC HUB",
  Description = "Arsenal script loaded successfully!",
  Time = 4,
})
