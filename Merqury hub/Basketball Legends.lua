-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf

local httpService = game:GetService("HttpService")
local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local lighting = game:GetService("Lighting")
local coreGui = game:GetService("CoreGui")
local rbxAnalyticsService = game:GetService("RbxAnalyticsService")

local function f1()
  local ok, hwid = pcall(gethwid)

  if ok and hwid and hwid ~= "" then
    return hwid
  end

  return tostring(rbxAnalyticsService:GetClientId()):gsub("-", "")
end

local function f2()
  local function getRequest()
    return request
  end

  local function getRequest2()
    return (getgenv or function() return {} end)().request
  end

  local function getRequest3()
    return fluxus and fluxus.request
  end

  for _, value in ipairs({
    getRequest, function() return http_request end, function() return http and http.request end,
    function() return syn and syn.request end, getRequest3, getRequest2,
  }) do
    local ok2, result = pcall(value)

    if ok2 and type(result) == "function" then
      return result
    end
  end

  return nil
end

local localPlayer = players.LocalPlayer

local function f3()
  local ok3, v1 = pcall(readfile, "MerquryHub_Key.txt")

  if not ok3 or not v1 or v1 == "" then
    localPlayer:Kick("Error S1")
    return false
  end

  local gsub = tostring(v1):gsub("^[%s\n\r\t]+", ""):gsub("[%s\n\r\t]+$", "")
  local v2 = f2()

  if not v2 then
    localPlayer:Kick("Error S2")
    return false
  end

  local _, body = pcall(httpService.JSONEncode, httpService, { key_string = gsub, hwid = f1() })
  local v3 = 3

  while v3 > 0 do
    local ok4, result2 = pcall(v2, {
      Url = "https://sskgujtorprdelkjaupf.supabase.co/functions/v1/key-api?action=validate",
      Method = "POST",
      Headers = { ["Content-Type"] = "application/json" },
      Body = body,
    })

    if ok4 and result2 and type(result2) == "table" and result2.Body and result2.Body ~= "" then
      local ok5, data = pcall(httpService.JSONDecode, httpService, result2.Body)

      if ok5 and type(data) == "table" then
        if data.valid == true then
          return true
        end

        localPlayer:Kick("Error S3")
        return false
      end
    end

    v3 = v3 - 1
    task.wait(0.5)
  end

  localPlayer:Kick("Error S4")
  return false
end

if not f3() then
  return
end

local v4 = false

pcall(function()
  local v5 = identifyexecutor()
  v4 = v5 and string.lower(v5):find("velocity") ~= nil
end)

if v4 then
  function makefolder()
  end

  function isfolder()
    return false
  end

  function writefile()
  end

  function readfile()
    return ""
  end

  function isfile()
    return false
  end
end

local httpGet

task.spawn(function()
  httpGet = game:HttpGet(
    "https://raw.githubusercontent.com/Puckolito/lib/refs/heads/main/icons.lua", true
  )
end)

local httpGet2

task.spawn(function()
  httpGet2 = game:HttpGet(
    "https://raw.githubusercontent.com/Puckolito/lib/refs/heads/main/libary.lua", true
  )
end)

while not (httpGet and httpGet2) do
  task.wait()
end

loadstring(httpGet)()
local v6 = loadstring(httpGet2)()

local function f4(value2, color)
  if typeof(value2) == "Color3" then
    return value2
  end

  if type(value2) == "table" then
    if typeof(value2.Color) == "Color3" then
      return value2.Color
    elseif type(value2.Color) == "string" then
      local ok6, fromHex = pcall(Color3.fromHex, value2.Color)

      if ok6 and fromHex then
        return fromHex
      end
    elseif type(value2[1]) == "number" and type(value2[2]) == "number"
      and type(value2[3]) == "number" then
      return Color3.fromRGB(value2[1], value2[2], value2[3])
    end
  elseif type(value2) == "string" then
    local ok7, fromHex2 = pcall(Color3.fromHex, value2)

    if ok7 and fromHex2 then
      return fromHex2
    end
  end

  return color or Color3.fromRGB(255, 255, 255)
end

local function f5(value3)
  if type(value3) == "table" then
    if value3.Value ~= nil then
      return f5(value3.Value)
    elseif value3.Color ~= nil then
      return f4(value3, value3.Color)
    end
  end

  return value3
end

local v7 = {}
local v8 = {}
local v9 = {}
local v10 = false

task.spawn(function()
  local v11 = 0

  runService.Heartbeat:Connect(function(delta)
    v11 = v11 + delta

    if v11 < 0.1 then
      return
    end

    v11 = 0
    v10 = v8 and v8.PostReach ~= nil and v8.PostReach.Value == true

    if not v6 or not v6.Flags then
      return
    end

    for key, value4 in pairs(v6.Flags) do
      if not v9[key] then
        v9[key] = {
          Value = f5(value4),
          SetValue = function(_, p1)
            local v12 = v6.Flags[key]

            if type(v12) == "table" and v12.SetValue then
              pcall(function() v12:SetValue(p1) end)
            else
              v6.Flags[key] = p1
            end
          end,
          OnChanged = function(value5, p2) end,
        }

        v7[key] = v9[key]
        v8[key] = v9[key]
      else
        v9[key].Value = f5(value4)
      end
    end
  end)
end)

local merquryhubWindow = v6:Window({
  Name = "Merquryhub",
  Version = "v1.3",
  Logo = 0,
  Size = userInputService.TouchEnabled and UDim2.new(0, 659, 0, 340)
    or UDim2.new(0, 659, 0, 511),
  FadeSpeed = 0.2,
})

local v13 = {
  Main = merquryhubWindow:Page({
    Name = "Main",
    Icon = "house",
    Columns = 2,
    SubPages = false,
  }),
  Misc = merquryhubWindow:Page({
    Name = "Misc",
    Icon = "eye",
    Columns = 2,
    SubPages = false,
  }),
  ["UI Settings"] = merquryhubWindow:Page({
    Name = "UI Settings",
    Icon = "settings",
    Columns = 2,
    SubPages = false,
  }),
}

local localPlayer2 = players.LocalPlayer
local shoot = replicatedStorage.Packages.Knit.Services.ControlService.RE.Shoot
local zero = Vector3.zero
local connect

local function f6()
  if connect then
    connect:Disconnect()
    connect = nil
  end
end

local v14 = require(replicatedStorage:WaitForChild("Modules"):WaitForChild("SharedUtil"))
local xyMagnitude = v14.Math.XYMagnitude
local v15 = v14.Math
local connect2, part, particleEmitter, ambient

local function f7()
  if connect2 then
    connect2:Disconnect()
    connect2 = nil
  end

  if part then
    part:Destroy()
    part = nil
  end

  particleEmitter = nil
  local ambientFilter = lighting:FindFirstChild("AmbientFilter")

  if ambientFilter then
    ambientFilter:Destroy()
  end

  local ambientBloom = lighting:FindFirstChild("AmbientBloom")

  if ambientBloom then
    ambientBloom:Destroy()
  end

  if ambient then
    lighting.Ambient = ambient
    ambient = nil
  end
end

function v15.XYMagnitude(p3, p4, p5)
  if v10 then
    return 0
  end

  return xyMagnitude(p3, p4, p5)
end

local function f8()
  local ok8, result3 = pcall(function() return localPlayer2:GetNetworkPing() end)

  if ok8 and type(result3) == "number" and result3 > 0 then
    return result3 * 1000
  end

  return 32
end

local connect3, instance

local function f9()
  if connect3 then
    connect3:Disconnect()
    connect3 = nil
  end

  instance = nil
  zero = Vector3.zero
  local character = localPlayer2.Character

  if character then
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart then
      local guardGyro = humanoidRootPart:FindFirstChild("GuardGyro")

      if guardGyro then
        guardGyro:Destroy()
      end
    end

    if humanoid and humanoidRootPart then
      humanoid:MoveTo(humanoidRootPart.Position)
    end
  end
end

local v16 = task.spawn

local function getGoal(instance2)
  local court = instance2:GetAttribute("Court")

  if not court then
    return nil
  end

  local courts = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Courts")

  if not courts then
    return nil
  end

  local instance3

  for _, value6 in ipairs(courts:GetChildren()) do
    if value6:GetAttribute("CourtID") == court then
      instance3 = value6
      break
    end
  end

  if instance3 then
    if (instance3:GetAttribute("CourtType") or 3) < 3 or instance3:GetAttribute("AI") then
      local basket = instance3:FindFirstChild("Basket")
      return basket and basket:FindFirstChild("Goal")
    end

    local team = instance2:GetAttribute("Team")

    if team then
      local findFirstChild = instance3:FindFirstChild((team == "Home" and "Away" or "Home")
        .. "Basket")

      return findFirstChild and findFirstChild:FindFirstChild("Goal")
    end
  end

  return nil
end

v16(function()
  local v17, visible, visible2, v18, bar

  while true do
    task.wait(0.033)

    if not (not v8.AutoShoot or not v8.AutoShoot.Value) then
      if not bar or not bar.Parent then
        pcall(function()
          local playerGui = localPlayer2:FindFirstChildOfClass("PlayerGui")
          local visual = playerGui and playerGui:FindFirstChild("Visual")
          local shooting = visual and visual:FindFirstChild("Shooting")
          bar = shooting and shooting:FindFirstChild("Bar")
        end)
      end

      if not (not bar or not bar.Parent) then
        local instance4 = bar

        repeat
          task.wait()

          v17 = not instance4.Parent or not instance4.Visible or instance4.Size.Y.Scale < 0.15
            or not v8.AutoShoot or not v8.AutoShoot.Value
        until v17

        if not (not v8.AutoShoot or not v8.AutoShoot.Value or not instance4.Parent) then
          repeat
            task.wait()

            visible = not instance4.Parent or instance4.Visible and instance4.Size.Y.Scale > 0
              or not v8.AutoShoot or not v8.AutoShoot.Value
          until visible

          if not (not v8.AutoShoot or not v8.AutoShoot.Value or not instance4.Parent) then
            local value7 = v7.ShootMode and v7.ShootMode.Value or "Single"
            local v19 = 0.995
            local v20 = 1

            if value7 == "Single" then
              local value8 = v7.SingleShotType and v7.SingleShotType.Value or "Perfect"
              v20 = value8 == "Perfect" and 1 or 0.96108663082123
              v19 = (value8 == "Perfect" and 0.995 or 0.94) - math.random(0, 20) * 0.001
            elseif value7 == "Multi" then
              local value9 = v7.PerfectChance and v7.PerfectChance.Value
              local v21 = tonumber(value9)

              local v22 = v21
              v22 = v21 or type(value9) == "table" and tonumber(value9.Value) or 70

              if math.random(1, 100) <= v22 then
                v19 = 0.995 - math.random(0, 20) * 0.001
                v20 = 1
              else
                v19 = 0.94 - math.random(0, 20) * 0.001
                v20 = 0.96108663082123
              end
            end

            repeat
              task.wait()

              visible2 = not instance4.Parent
                or instance4.Visible and instance4.Size.Y.Scale >= v19 or not v8.AutoShoot
                or not v8.AutoShoot.Value
            until visible2

            if not (not v8.AutoShoot or not v8.AutoShoot.Value or not instance4.Parent) then
              local v23 = f8()
              local roll = math.random(50, 95)
              local clamped = math.clamp(roll * 0.001 + (v23 - 32) / 1000, 0.001, 0.45)
              task.wait(clamped)

              if not (not v8.AutoShoot or not v8.AutoShoot.Value or not instance4.Parent) then
                shoot:FireServer(v20)

                repeat
                  task.wait()

                  v18 = not instance4.Parent or not instance4.Visible
                    or instance4.Size.Y.Scale < 0.5 or not v8.AutoShoot
                    or not v8.AutoShoot.Value
                until v18
              end
            end
          end
        end
      end
    end
  end
end)

local function f10(circle)
  if not circle then
    return nil
  end

  if circle:IsA("ImageLabel") or circle:IsA("ImageButton") then
    return circle.ImageColor3
  end

  if circle:IsA("GuiObject") then
    return circle.BackgroundColor3
  end

  if circle:IsA("Decal") or circle:IsA("Texture") then
    return circle.Color3
  end

  return nil
end

local function f11()
  if connect then
    connect:Disconnect()
    connect = nil
  end

  connect = runService.RenderStepped:Connect(function()
    local character2 = localPlayer2.Character

    if not character2 then
      return
    end

    local humanoidRootPart2 = character2:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart2 then
      return
    end

    for _, value10 in ipairs(workspace:GetChildren()) do
      local handle

      if value10:IsA("BasePart")
        and (value10.Name:lower():find("ball") or value10.Name:lower():find("basket")) then
        handle = value10
      elseif value10:IsA("Tool")
        and (value10.Name:lower():find("ball") or value10.Name:lower():find("basket")) then
        handle = value10:FindFirstChild("Handle")
      end

      if handle and handle:IsA("BasePart") then
        if (handle.Position - humanoidRootPart2.Position).Magnitude <= 20 then
          if handle:FindFirstChild("TouchInterest")
            or handle:FindFirstChildWhichIsA("TouchTransmitter") then
            if firetouchinterest then
              firetouchinterest(humanoidRootPart2, handle, 0)
              firetouchinterest(humanoidRootPart2, handle, 1)

              local rightArm = character2:FindFirstChild("Right Arm")

              local rightLowerArm = rightArm
              rightLowerArm = rightArm or character2:FindFirstChild("RightLowerArm")

              if rightLowerArm then
                firetouchinterest(rightLowerArm, handle, 0)
                firetouchinterest(rightLowerArm, handle, 1)
              end
            end
          end
        end
      end
    end
  end)
end

local function f12(instance5)
  if not instance5 then
    return false
  end

  local character3 = localPlayer2.Character
  local v24 = not character3
  local character4 = instance5.Character

  if v24 or not character4 then
    return false
  end

  local humanoidRootPart3 = character3:FindFirstChild("HumanoidRootPart")
  local humanoidRootPart4 = character4:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart3 or not humanoidRootPart4 then
    return false
  end

  if workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Courts") then
    local court2 = localPlayer2:GetAttribute("Court")
    local court3 = instance5:GetAttribute("Court")

    if court2 and court3 then
      if court2 ~= court3 then
        return false
      end
    end
  end

  local overhead = humanoidRootPart3:FindFirstChild("Overhead")
  local overhead2 = humanoidRootPart4:FindFirstChild("Overhead")

  if not overhead or not overhead2 then
    return false
  end

  local circle2 = overhead:FindFirstChild("Circle")
  local v25 = not circle2
  local circle3 = overhead2:FindFirstChild("Circle")

  if v25 or not circle3 then
    return false
  end

  local v26 = f10(circle2)
  local v27 = f10(circle3)

  if v26 and v27 then
    local v28 = v26.R - v27.R
    local v29 = v26.G - v27.G
    local v30 = v26.B - v27.B

    if math.sqrt(v28 * v28 + v29 * v29 + v30 * v30) < 0.05 then
      return true
    end
  end

  return false
end

local connect4

local function f13()
  if connect4 then
    connect4:Disconnect()
    connect4 = nil
  end
end

local f14

local function f15()
  local instance6 = f14()

  if not instance6 then
    return true
  end

  return #instance6:GetChildren() <= 1
end

function f14()
  return (workspace:FindFirstChild("Game") or workspace):FindFirstChild("Courts")
end

local f16

local function makeBodyGyro()
  if connect3 then
    return
  end

  connect3 = runService.Heartbeat:Connect(function()
    if not v8.AutoGuard or not v8.AutoGuard.Value then
      return
    end

    local character5 = localPlayer2.Character

    if not character5 then
      return
    end

    local humanoidRootPart5 = character5:FindFirstChild("HumanoidRootPart")
    local v31 = not humanoidRootPart5
    local humanoid2 = character5:FindFirstChildOfClass("Humanoid")

    if v31 or not humanoid2 then
      return
    end

    if not localPlayer2:GetAttribute("Court") and not f15() and game.PlaceId ~= 4931927012 then
      return
    end

    if not instance or not instance.Parent or instance.Parent ~= players then
      instance = f16()
    end

    local v32 = instance

    if not v32 then
      return
    end

    local character6 = v32.Character

    if not character6 then
      instance = nil
      return
    end

    local humanoidRootPart6 = character6:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart6 then
      instance = nil
      return
    end

    if (v7.GuardTargetMode and v7.GuardTargetMode.Value or "Closest") == "Only Ball" then
      local flag = false

      for _, value11 in ipairs(character6:GetChildren()) do
        local name = value11.Name

        if value11:IsA("Tool")
          and (string.find(name, "ball") or string.find(name, "Ball")
            or string.find(name, "basket") or string.find(name, "Basket")) then
          flag = true
          break
        end
      end

      if not flag then
        instance = nil
        return
      end
    end

    if f12(v32) then
      instance = nil
      return
    end

    local goal = getGoal(v32)
    local position, vector

    if goal then
      local unit = (goal.Position - humanoidRootPart6.Position).Unit
      local v33 = humanoidRootPart6.Position + unit * 4
      vector = Vector3.new(v33.X, humanoidRootPart5.Position.Y, v33.Z)
    else
      if humanoidRootPart6.Velocity.Magnitude > 2 then
        local unit2 = humanoidRootPart6.Velocity.Unit
        position = humanoidRootPart6.Position + unit2 * 4
      else
        position = (humanoidRootPart6.CFrame * CFrame.new(0, 0, -4)).Position
      end

      vector = Vector3.new(position.X, humanoidRootPart5.Position.Y, position.Z)
    end

    local vector2 = Vector3.new(
      humanoidRootPart6.Position.X, humanoidRootPart5.Position.Y, humanoidRootPart6.Position.Z
    )

    local value12 = v7.GuardMode and v7.GuardMode.Value or "Legit"

    if value12 == "Rage" then
      humanoidRootPart5.CFrame = CFrame.new(vector, vector2)
    elseif value12 == "Legit" then
      if (vector - zero).Magnitude > 1 then
        zero = vector
        humanoid2:MoveTo(vector)
      end

      local guardGyro2 = humanoidRootPart5:FindFirstChild("GuardGyro")

      if not guardGyro2 then
        guardGyro2 = Instance.new("BodyGyro")
        guardGyro2.Name = "GuardGyro"
        guardGyro2.MaxTorque = Vector3.new(0, 400000, 0)
        guardGyro2.P = 10000
        guardGyro2.Parent = humanoidRootPart5
      end

      local value13 = v7.GuardSmoothness and v7.GuardSmoothness.Value or 0

      if value13 == 0 then
        guardGyro2.CFrame = CFrame.new(humanoidRootPart5.Position, vector2)
      else
        local cframe = CFrame.new(humanoidRootPart5.Position, vector2)
        local clamped2 = math.clamp(1 - value13 / 100, 0.05, 1)
        guardGyro2.CFrame = guardGyro2.CFrame:Lerp(cframe, clamped2)
      end
    end
  end)
end

function f16()
  local character7 = localPlayer2.Character

  if not character7 then
    return nil
  end

  local humanoidRootPart7 = character7:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart7 then
    return nil
  end

  local huge = math.huge
  local value14 = v7.GuardTargetMode and v7.GuardTargetMode.Value or "Closest"
  local court4 = localPlayer2:GetAttribute("Court")
  local v34

  for _, value15 in ipairs(players:GetPlayers()) do
    if not (value15 == localPlayer2 or f12(value15)) then
      local v35 = not court4 or value15:GetAttribute("Court") == court4

      if game.PlaceId == 4931927012 then
        v35 = true
      end

      if v35 then
        local character8 = value15.Character

        if character8 then
          local flag2 = false

          if value14 == "Only Ball" then
            local flag3 = false

            for _, value16 in ipairs(character8:GetChildren()) do
              local name2 = value16.Name

              if value16:IsA("Tool")
                and (string.find(name2, "ball", 1, true) or string.find(name2, "Ball", 1, true)
                  or string.find(name2, "basket", 1, true)
                  or string.find(name2, "Basket", 1, true)) then
                flag3 = true
                break
              end
            end

            if flag3 then
              flag2 = true
            end
          else
            flag2 = true
          end

          if flag2 then
            local humanoidRootPart8 = character8:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart8 then
              local magnitude = (humanoidRootPart7.Position
                - humanoidRootPart8.Position).Magnitude

              if magnitude <= huge then
                huge = magnitude
                v34 = value15
              end
            end
          end
        end
      end
    end
  end

  return v34
end

connect4 = nil
local v36 = 0
local v37

local function f17()
  if connect4 then
    return
  end

  connect4 = runService.Heartbeat:Connect(function()
    if not v8.BallRage or not v8.BallRage.Value then
      return
    end

    local character9 = localPlayer2.Character

    if not character9 then
      return
    end

    local humanoidRootPart9 = character9:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart9 then
      return
    end

    local court5 = localPlayer2:GetAttribute("Court")

    if not court5 and not f15() and game.PlaceId ~= 4931927012 then
      return
    end

    local v38

    for _, value17 in ipairs(workspace:GetChildren()) do
      local attach

      if value17:IsA("BasePart")
        and (value17.Name:lower():find("ball") or value17.Name:lower():find("basket")) then
        attach = value17
      elseif (value17:IsA("Tool") or value17:IsA("Model"))
        and (value17.Name:lower():find("ball") or value17.Name:lower():find("basket")) then
        attach = value17:FindFirstChild("Attach") or value17:FindFirstChild("Handle")
          or value17:FindFirstChildWhichIsA("BasePart")
      end

      if attach and attach:IsA("BasePart") then
        local court6 = value17:GetAttribute("Court")

        local courtID = court6
        courtID = court6 or value17:GetAttribute("CourtID")

        local ready = value17:GetAttribute("Ready")

        if ready == nil then
          ready = attach:GetAttribute("Ready")
        end

        local v39 = court5
        v39 = court5 and courtID and court5 == courtID

        if game.PlaceId == 4931927012 then
          v39 = true
        end

        if ready == true and v39 then
          v38 = attach
          break
        end
      end
    end

    if v38 then
      if v38 ~= v37 then
        v37 = v38
        v36 = tick()
      end

      if tick() - v36 >= 0.05 then
        humanoidRootPart9.CFrame = CFrame.new(v38.Position)
          * (humanoidRootPart9.CFrame - humanoidRootPart9.CFrame.Position)
      end
    else
      v37 = nil
      v36 = 0
    end
  end)
end

local connect5

local function f18()
  if connect5 then
    connect5:Disconnect()
    connect5 = nil
  end

  local heartbeat = runService.Heartbeat
  local v40, humanoid3, humanoidRootPart10

  connect5 = heartbeat:Connect(function(p6)
    if not v8.Walkspeed or not v8.Walkspeed.Value then
      return
    end

    local character10 = localPlayer2.Character

    if not character10 then
      return
    end

    if character10 ~= v40 then
      v40 = character10
      humanoid3 = character10:FindFirstChildOfClass("Humanoid")
      humanoidRootPart10 = character10:FindFirstChild("HumanoidRootPart")
    end

    local v41 = humanoid3
    local v42 = humanoidRootPart10

    if not v41 or not v42 then
      return
    end

    local value18 = v7.SpeedValue and v7.SpeedValue.Value or 16
    local walkSpeed = v41.WalkSpeed

    if v41.MoveDirection.Magnitude > 0 and value18 > walkSpeed then
      local unit3 = v41.MoveDirection.Unit
      v42.CFrame = v42.CFrame + unit3 * ((value18 - walkSpeed) * p6)
    end
  end)
end

local f19
local connect6, map

local function makePart(p7)
  if connect6 then
    connect6:Disconnect()
    connect6 = nil
  end

  for _, value19 in pairs(map) do
    if value19.Trail then
      value19.Trail:Destroy()
    end

    if value19.TracerPart then
      value19.TracerPart:Destroy()
    end

    if value19.AttBall then
      value19.AttBall:Destroy()
    end
  end

  table.clear(map)

  if not (p7 ~= nil and p7 or v8.BallTracers and v8.BallTracers.Value) then
    return
  end

  local v43 = 0

  connect6 = runService.Heartbeat:Connect(function(delta2)
    v43 = v43 + delta2

    if v43 < 0.066 then
      return
    end

    local v44 = true
    v43 = 0

    if v8.BallTracerOnlyDropped and v8.BallTracerOnlyDropped.Value ~= nil then
      v44 = v8.BallTracerOnlyDropped.Value == true
    end

    local list = f19(v44)

    local v45 = f4(
      v7.BallTracerColor and v7.BallTracerColor.Value, Color3.fromRGB(170, 130, 255)
    )

    local value20 = v7.BallTracerDuration and v7.BallTracerDuration.Value or 2

    for _, value21 in ipairs(list) do
      local v46 = map[value21]

      if not v46 then
        local tracer = Instance.new("Part")
        tracer.Name = "Tracer"
        tracer.Transparency = 1
        tracer.CanCollide = false
        tracer.Massless = true
        tracer.Size = Vector3.new(0.1, 0.1, 0.1)
        tracer.Position = value21.Position
        tracer.Parent = workspace

        local instance7 = Instance.new("Attachment", value21)
        local instance8 = Instance.new("Attachment", tracer)

        local alignPosition = Instance.new("AlignPosition")
        alignPosition.Attachment0 = instance8
        alignPosition.Attachment1 = instance7
        alignPosition.RigidityEnabled = true
        alignPosition.Parent = tracer

        local attachment = Instance.new("Attachment")
        attachment.Position = Vector3.new(0, 0.1, 0)
        attachment.Parent = tracer

        local attachment2 = Instance.new("Attachment")
        attachment2.Position = Vector3.new(0, -0.1, 0)
        attachment2.Parent = tracer

        local trail = Instance.new("Trail")
        trail.Attachment0 = attachment
        trail.Attachment1 = attachment2
        trail.FaceCamera = true
        trail.MinLength = 0

        trail.Transparency = NumberSequence.new({
          NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1),
        })

        trail.WidthScale = NumberSequence.new({
          NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0),
        })

        trail.Parent = tracer

        map[value21] = { Trail = trail, TracerPart = tracer, AttBall = instance7 }
        v46 = map[value21]
      end

      local trail2 = v46.Trail
      local attachment0 = trail2 and trail2.Attachment0
      local attachment1 = trail2 and trail2.Attachment1

      if trail2 and attachment0 and attachment1 then
        trail2.Color = ColorSequence.new(v45)
        trail2.Lifetime = value20

        attachment0.Position = Vector3.new(0, 0.05, 0)
        attachment1.Position = Vector3.new(0, -0.05, 0)

        trail2.LightEmission = 0
        trail2.Texture = ""
      end
    end

    for key2, value22 in pairs(map) do
      if not key2 or not key2.Parent or not key2:IsDescendantOf(workspace)
        or not table.find(list, key2) then
        pcall(function()
          if value22.Trail then
            value22.Trail:Destroy()
          end

          if value22.TracerPart then
            value22.TracerPart:Destroy()
          end

          if value22.AttBall then
            value22.AttBall:Destroy()
          end
        end)

        map[key2] = nil
      end
    end
  end)
end

local connect7, map2

local function makeHighlight(p8)
  if connect7 then
    connect7:Disconnect()
    connect7 = nil
  end

  for _, value23 in pairs(map2) do
    pcall(function() value23:Destroy() end)
  end

  table.clear(map2)

  if not (p8 ~= nil and p8 or v8.BallESP and v8.BallESP.Value) then
    return
  end

  local v47 = 0

  connect7 = runService.Heartbeat:Connect(function(delta3)
    v47 = v47 + delta3

    if v47 < 0.1 then
      return
    end

    v47 = 0
    local v48 = true

    if v8.BallChamsOnlyDropped and v8.BallChamsOnlyDropped.Value ~= nil then
      v48 = v8.BallChamsOnlyDropped.Value == true
    end

    local list2 = f19(v48)
    local v49 = f4(v7.BallESPColor and v7.BallESPColor.Value, Color3.fromRGB(170, 130, 255))

    for _, value24 in ipairs(list2) do
      local ballChams = map2[value24]

      if not ballChams or not ballChams.Parent then
        ballChams = Instance.new("Highlight")
        ballChams.Name = "BallChams"
        ballChams.Adornee = value24
        ballChams.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        ballChams.FillTransparency = 0.5
        ballChams.OutlineTransparency = 0
        ballChams.Parent = value24

        map2[value24] = ballChams
      end

      ballChams.FillColor = v49
      ballChams.OutlineColor = v49
    end

    for key3, value25 in pairs(map2) do
      if not key3 or not key3.Parent or not key3:IsDescendantOf(workspace)
        or not table.find(list2, key3) then
        pcall(function() value25:Destroy() end)
        map2[key3] = nil
      end
    end
  end)
end

connect2 = nil
part = nil
particleEmitter = nil
ambient = nil
local v50, v51

local function makePart2(p9)
  if not (p9 ~= nil and p9 or v8.AmbientEnabled and v8.AmbientEnabled.Value) then
    f7()
    return
  end

  if not ambient then
    ambient = lighting.Ambient
  end

  if connect2 then
    connect2:Disconnect()
    connect2 = nil
  end

  local v52 = 0

  connect2 = runService.Heartbeat:Connect(function(delta4)
    v52 = v52 + delta4

    if v52 < 0.1 then
      return
    end

    v52 = 0

    if not v8.AmbientEnabled or not v8.AmbientEnabled.Value then
      f7()
      return
    end

    local value26 = v7.AmbientColor and v7.AmbientColor.Value
    local ambient2 = f4(value26, Color3.fromRGB(170, 130, 255))

    if v50 ~= value26 then
      v50 = value26
      lighting.Ambient = ambient2
    end

    if (v7.AmbientMode and v7.AmbientMode.Value or "V1") == "V2" then
      if not part then
        part = Instance.new("Part")
        part.Anchored = true
        part.CanCollide = false
        part.CanQuery = false
        part.CanTouch = false
        part.CastShadow = false
        part.Transparency = 1
        part.Size = Vector3.new(100, 100, 1)
        part.Parent = workspace.CurrentCamera

        particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Lifetime = NumberRange.new(8, 15)
        particleEmitter.Speed = NumberRange.new(1, 3)
        particleEmitter.Acceleration = Vector3.new(0, -1.5, 0)
        particleEmitter.EmissionDirection = Enum.NormalId.Bottom
        particleEmitter.SpreadAngle = Vector2.new(180, 180)

        particleEmitter.Size = NumberSequence.new({
          NumberSequenceKeypoint.new(0, 0.45), NumberSequenceKeypoint.new(1, 0.25),
        })

        particleEmitter.Transparency = NumberSequence.new({
          NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0.6),
          NumberSequenceKeypoint.new(0.8, 0.6), NumberSequenceKeypoint.new(1, 1),
        })

        particleEmitter.LightEmission = 1
        particleEmitter.LightInfluence = 0
        particleEmitter.RotSpeed = NumberRange.new(-40, 40)
        particleEmitter.Drag = 2
        particleEmitter.Texture = "rbxassetid://284205403"
        particleEmitter.Parent = part
      end

      local lerp = ambient2:Lerp(Color3.new(1, 1, 1), 0.5)

      if v51 ~= lerp then
        v51 = lerp
        particleEmitter.Color = ColorSequence.new(lerp)
      end

      particleEmitter.Rate = 40
      part.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -40)
    elseif part then
      part:Destroy()
      part = nil
      particleEmitter = nil
    end
  end)
end

local v53 = {}
local v54 = 0
local v55 = {}
local v56 = 0

function f19(p10)
  local v57 = tick()

  if p10 then
    if v57 - v56 < 0.25 then
      return v55
    end
  elseif v57 - v54 < 0.25 then
    return v53
  end

  local list3 = {}
  local seen = {}

  local function f20(attach2)
    if attach2 and attach2:IsA("BasePart") and not seen[attach2] then
      seen[attach2] = true
      table.insert(list3, attach2)
    end
  end

  local function f21(instance9)
    if not instance9 then
      return
    end

    local name3 = instance9.Name

    if instance9:IsA("BasePart")
      and (string.find(name3, "ball") or string.find(name3, "Ball")
        or string.find(name3, "basket") or string.find(name3, "Basket")) then
      f20(instance9)
    elseif (instance9:IsA("Tool") or instance9:IsA("Model"))
      and (string.find(name3, "ball") or string.find(name3, "Ball")
        or string.find(name3, "basket") or string.find(name3, "Basket")) then
      f20(instance9:FindFirstChild("Attach") or instance9:FindFirstChild("Handle")
        or instance9:FindFirstChild("Basketball")
        or instance9:FindFirstChildWhichIsA("BasePart"))
    end
  end

  for _, value27 in ipairs(workspace:GetChildren()) do
    f21(value27)
  end

  if not p10 then
    for _, value28 in ipairs(players:GetPlayers()) do
      local character11 = value28.Character

      if character11 then
        for _, value29 in ipairs(character11:GetChildren()) do
          f21(value29)
        end
      end
    end
  end

  if p10 then
    v55 = list3
    v56 = v57
  else
    v53 = list3
    v54 = v57
  end

  return list3
end

connect6 = nil
map = {}
connect7 = nil
map2 = {}
local name4 = localPlayer2.Name

local function f22()
  local fakeDisplayName = v6 and v6.Flags and v6.Flags.FakeDisplayName
    or v7.FakeDisplayName and v7.FakeDisplayName.Value

  if type(fakeDisplayName) == "table" then
    fakeDisplayName = fakeDisplayName.Value
  end

  if not fakeDisplayName or fakeDisplayName == "" then
    return "Merqury"
  end

  return tostring(fakeDisplayName)
end

local displayName = localPlayer2.DisplayName

local function f23()
  local fakeUsername = v6 and v6.Flags and v6.Flags.FakeUsername
    or v7.FakeUsername and v7.FakeUsername.Value

  if type(fakeUsername) == "table" then
    fakeUsername = fakeUsername.Value
  end

  if not fakeUsername or fakeUsername == "" then
    return "Merquryhub"
  end

  return tostring(fakeUsername)
end

getgenv().__ns_on = false
getgenv().__ns_u = "Merquryhub"
getgenv().__ns_d = "Merqury"
getgenv().__ns_lp = localPlayer2

if not getgenv().__ns_hk then
  getgenv().__ns_hk = true

  pcall(function()
    local rawmetatable = getrawmetatable(game)
    local index

    if rawmetatable then
      index = rawmetatable.__index
      setreadonly(rawmetatable, false)

      rawmetatable.__index = newcclosure(function(p11, p12)
        if not checkcaller() then
          if getgenv().__ns_on then
            if p11 == getgenv().__ns_lp then
              if p12 == "Name" then
                return getgenv().__ns_u
              elseif p12 == "DisplayName" then
                return getgenv().__ns_d
              end
            end
          end
        end

        return index(p11, p12)
      end)

      setreadonly(rawmetatable, true)
    end
  end)
end

local list4

local function f24(p13)
  if list4 then
    if typeof(list4) == "table" then
      for _, value30 in ipairs(list4) do
        pcall(function() value30:Disconnect() end)
      end
    elseif typeof(list4) == "RBXScriptConnection" then
      pcall(function() list4:Disconnect() end)
    end

    list4 = nil
  end

  if not (p13 ~= nil and p13 or v8.EnableSpoofName and v8.EnableSpoofName.Value) then
    getgenv().__ns_on = false
    return
  end

  local nsU = f23()
  local nsD = f22()

  getgenv().__ns_on = true
  getgenv().__ns_u = nsU
  getgenv().__ns_d = nsD

  local function f25(text)
    if not text then
      return
    end

    if not (text:IsA("TextLabel") or text:IsA("TextButton")) then
      return
    end

    local text2 = text.Text

    if not text2 or text2 == "" then
      return
    end

    local nsU2 = getgenv().__ns_u
    local nsD2 = getgenv().__ns_d
    local flag4 = false

    if name4 ~= "" and string.find(text2, name4, 1, true) then
      text2 = string.gsub(text2, name4, nsU2)
      flag4 = true
    end

    if displayName ~= "" and string.find(text2, displayName, 1, true) then
      text2 = string.gsub(text2, displayName, nsD2)
      flag4 = true
    end

    if flag4 then
      text.Text = text2
    end
  end

  local function f26(instance10)
    if not instance10 then
      return
    end

    for _, value31 in ipairs(instance10:GetDescendants()) do
      f25(value31)
    end
  end

  local v58 = {}
  list4 = v58
  local playerGui2 = localPlayer2:FindFirstChildOfClass("PlayerGui")

  if playerGui2 then
    f26(playerGui2)
    local v59 = #v58
    local descendantAdded = playerGui2.DescendantAdded
    v58[v59 + 1] = descendantAdded:Connect(f25)
  end

  pcall(function()
    local playerList = coreGui:FindFirstChild("PlayerList")
      or coreGui:FindFirstChild("RobloxGui")

    if playerList then
      f26(playerList)
      local v60 = #v58
      local descendantAdded2 = playerList.DescendantAdded
      v58[v60 + 1] = descendantAdded2:Connect(f25)
    end
  end)

  local function f27(character12)
    if not character12 then
      return
    end

    f26(character12)
    local v61 = #v58
    local descendantAdded3 = character12.DescendantAdded
    v58[v61 + 1] = descendantAdded3:Connect(f25)
  end

  f27(localPlayer2.Character)

  local v62 = #v58
  local characterAdded = localPlayer2.CharacterAdded
  v58[v62 + 1] = characterAdded:Connect(f27)
end

local autoShootSection = v13.Main:Section({ Name = "Auto Shoot", Side = 1 })

autoShootSection:Toggle({
  Name = "Auto Shoot",
  Default = false,
  Flag = "AutoShoot",
  Callback = function(value32) end,
}):Keybind({
  Flag = "AutoShootKey",
  Mode = "Toggle",
  Default = "None",
})

local shotTypeDropdown, perfectChanceSlider
local greatChanceSlider

local function f28(p14)
  local v63 = shotTypeDropdown
  local v64 = p14 == "Multi"

  local function f29(p15, p16)
    if not p15 then
      return
    end

    if p15.SetVisible then
      p15:SetVisible(p16)
    elseif p15.SetVisibility then
      p15:SetVisibility(p16)
    end
  end

  f29(v63, p14 == "Single")
  f29(perfectChanceSlider, v64)
  f29(greatChanceSlider, v64)
end

autoShootSection:Dropdown({
  Name = "Mode",
  Items = { "Single", "Multi" },
  Default = 1,
  MaxSize = 3,
  Flag = "ShootMode",
  Multi = false,
  Callback = function(value33) f28(value33) end,
})

shotTypeDropdown = autoShootSection:Dropdown({
  Name = "Shot Type",
  Items = { "Perfect", "Great" },
  Default = 1,
  MaxSize = 3,
  Flag = "SingleShotType",
  Multi = false,
  Callback = function() end,
})

local flag5 = false

perfectChanceSlider = autoShootSection:Slider({
  Name = "Perfect Chance",
  Min = 0,
  Max = 100,
  Default = 20,
  Decimals = 0,
  Flag = "PerfectChance",
  Suffix = "%",
  Callback = function(value34)
    if flag5 then
      return
    end

    flag5 = true
    local v65 = tonumber(value34)
    local clamped3 = math.clamp(100 - (v65 or 20), 0, 100)

    if greatChanceSlider then
      if greatChanceSlider.SetValue then
        pcall(function() greatChanceSlider:SetValue(clamped3) end)
      elseif greatChanceSlider.Set then
        pcall(function() greatChanceSlider:Set(clamped3) end)
      end
    end

    if v7.GreatChance and v7.GreatChance.SetValue then
      pcall(function() v7.GreatChance:SetValue(clamped3) end)
    end

    flag5 = false
  end,
})

greatChanceSlider = autoShootSection:Slider({
  Name = "Great Chance",
  Min = 0,
  Max = 100,
  Default = 80,
  Decimals = 0,
  Flag = "GreatChance",
  Suffix = "%",
  Callback = function(value35)
    if flag5 then
      return
    end

    flag5 = true
    local v66 = tonumber(value35)
    local clamped4 = math.clamp(100 - (v66 or 80), 0, 100)

    if perfectChanceSlider then
      if perfectChanceSlider.SetValue then
        pcall(function() perfectChanceSlider:SetValue(clamped4) end)
      elseif perfectChanceSlider.Set then
        pcall(function() perfectChanceSlider:Set(clamped4) end)
      end
    end

    if v7.PerfectChance and v7.PerfectChance.SetValue then
      pcall(function() v7.PerfectChance:SetValue(clamped4) end)
    end

    flag5 = false
  end,
})

f28("Single")

local autoGuardSection = v13.Main:Section({ Name = "Auto Guard", Side = 2 })

autoGuardSection:Toggle({
  Name = "Auto Guard",
  Default = false,
  Flag = "AutoGuard",
  Callback = function(value36)
    if value36 then
      makeBodyGyro()
    else
      f9()
    end
  end,
}):Keybind({
  Flag = "AutoGuardKey",
  Mode = "Toggle",
  Default = "None",
})

autoGuardSection:Dropdown({
  Name = "Guard Mode",
  Items = { "Legit", "Rage" },
  Default = 1,
  MaxSize = 3,
  Flag = "GuardMode",
  Multi = false,
  Callback = function() end,
})

autoGuardSection:Dropdown({
  Name = "Target Mode",
  Items = { "Closest", "Only Ball" },
  Default = 1,
  MaxSize = 3,
  Flag = "GuardTargetMode",
  Multi = false,
  Callback = function() end,
})

autoGuardSection:Slider({
  Name = "Smoothness",
  Min = 0,
  Max = 100,
  Default = 0,
  Decimals = 0,
  Flag = "GuardSmoothness",
  Suffix = "%",
  Callback = function() end,
})

local ballFeaturesSection = v13.Main:Section({ Name = "Ball Features", Side = 2 })

ballFeaturesSection:Toggle({
  Name = "Ball Magnet",
  Default = false,
  Flag = "BallMagnet",
  Callback = function(value37)
    if value37 then
      f11()
    else
      f6()
    end
  end,
})

ballFeaturesSection:Toggle({
  Name = "Ball Rage",
  Default = false,
  Flag = "BallRage",
  Callback = function(value38)
    if value38 then
      f17()
    else
      f13()
    end
  end,
}):Keybind({
  Flag = "BallRageKey",
  Mode = "Toggle",
  Default = "None",
})

local cosmeticsSection = v13.Main:Section({ Name = "Cosmetics", Side = 2 })

cosmeticsSection:Button({
  Name = "Unlock All Cosmetics",
  Callback = function()
    if getactors and #getactors() > 0 then
      run_on_actor(
        getactors()[1],
        '            local repStorage = game:GetService(\'ReplicatedStorage\')\n            local players = game:GetService(\'Players\')\n            local RunService = game:GetService(\'RunService\')\n\n            local localPlayer = players.LocalPlayer \n            local character = localPlayer.Character \n\n            local knit = require(repStorage.Packages.Knit)\n            local items = require(repStorage.Modules.Items)\n            local inventory = require(repStorage.Controllers.UIController.Inventory)\n            local store = require(repStorage.Controllers.UIController.Store)\n            local visuals = require(repStorage.Controllers.VisualController)\n\n            local economy = knit.GetService(\'EconomyService\')\n            local data = knit.GetController(\'DataController\').Data \n\n            local inventoryFrames = localPlayer.PlayerGui.Main.Inventory\n            local storeFrames = localPlayer.PlayerGui.Main.Store.Glow.Holder.Main.ShopFrames \n\n            local function WaitForChildWhichIsA(self, ClassName)\n                while self:FindFirstChildWhichIsA(ClassName) == nil do \n                    task.wait()\n                end \n            end \n\n            local storeButtons = {\n                Equipped = {\n                    Text = \'USING\',\n                    Color = ColorSequence.new(Color3.fromRGB(146, 26, 221), Color3.fromRGB(53, 7, 71)),\n                    Image = \'rbxassetid://16546841553\'\n                };\n                Equip = {\n                    Text = \'EQUIP\',\n                    Color = ColorSequence.new(Color3.fromRGB(23, 221, 198), Color3.fromRGB(8, 71, 64)),\n                    Image = \'rbxassetid://16546837268\'\n                }\n            }\n\n            local function unlockAll() \n                pcall(function()\n                    for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do\n                        if v.Name == "ReplicaController" and v:IsA("ModuleScript") then\n                            local ReplicaController = require(v)\n                            if ReplicaController and type(ReplicaController) == "table" and type(ReplicaController.ReplicaSetValue) == "function" then\n                                if not ReplicaController._HookedForNil then\n                                    ReplicaController._HookedForNil = true\n                                    local oldRSV = ReplicaController.ReplicaSetValue\n                                    ReplicaController.ReplicaSetValue = function(replica, ...)\n                                        if not replica or type(replica) ~= "table" or rawget(replica, "Data") == nil then\n                                            return\n                                        end\n                                        return oldRSV(replica, ...)\n                                    end\n                                end\n                            end\n                        end\n                    end\n                end)\n\n                local bannerAssets = game.ReplicatedStorage.Assets.Banners \n                local effectAssets = game.ReplicatedStorage.Assets.Effects \n                local dunks = {}\n\n                for dunk, dunkData in next, items.Dunks do \n                    dunks[dunk] = false\n                end \n                \n                local newInventory = {Skins={},Effects={},Banners={},Emotes={},Dunks={}}\n\n                for category, _ in next, newInventory do \n                    for item, _ in next, items[category] do \n                        newInventory[category][#newInventory[category]+1] = {item, false}\n                    end \n                end\n\n                if data.Gamepasses then\n                    for gamepass, _ in next, data.Gamepasses do \n                        data.Gamepasses[gamepass] = true\n                    end \n                end\n                data.Prestige = 3\n\n                if not data.Dunks then data.Dunks = {} end\n                if not data.Dunks.Owned then data.Dunks.Owned = {} end\n                for dunk, _ in next, items.Dunks do \n                    data.Dunks.Owned[dunk] = true\n                end\n                \n                for category, arr in next, newInventory do\n                    if data[category] then\n                        data[category].Inventory = arr\n                    else\n                        data[category] = { Inventory = arr }\n                    end\n                end\n\n                local function unequipAll(category) \n                    for i,v in next, inventoryFrames[category]:GetChildren() do \n                        if v:FindFirstChild(\'Using\') then \n                            v.Using.Visible = false \n                        end \n                    end  \n                end \n\n                if inventory.UpdateList then\n                    inventory:UpdateList()\n                elseif inventory.UpdateInventory then\n                    inventory:UpdateInventory(newInventory)\n                end\n\n\n                local ball = localPlayer.Character:FindFirstChild(\'Basketball\')\n                local currentSkin = nil \n                local currentEffect = nil \n                local currentBanner = nil \n                local currentEmote = nil\n                local currentDunk = nil\n                local currentEmoteProps = {}\n                local currentEmoteSound = nil\n\n                local function getItemDataByName(category, name)\n                    local result = nil \n                    for i,v in next, items[category] do \n                        if v[1] == name then \n                            result = v \n                            break \n                        end \n                    end \n                    return result\n                end \n\n                local function getRealItemName(category, name)\n                    local result = nil \n                    local nameIdx = 1 \n                    if category == \'Dunks\' then \n                        nameIdx = 2 \n                    end \n                    for i,v in next, items[category] do \n                        if v[nameIdx] == name then \n                            result = i \n                            break \n                        end  \n                    end \n                    return result\n                end \n\n                local function getMyWorkspaceBall()\n                    local result = nil \n                    for i,v in next, workspace:GetChildren() do \n                        if v.Name == \'Basketball\' and v:GetAttribute(\'Owner\') == localPlayer.UserId then \n                            result = v \n                            break \n                        end \n                    end \n                    return result   \n                end \n\n                local oldEffects = {}\n                local oldBallEffects = {} \n\n                local skinAliases = {\n                    ["Purple Eye"] = "EyePurple",\n                    ["PurpleEye"] = "EyePurple",\n                    ["Eye Purple"] = "EyePurple",\n                    ["Dragon Eye"] = "Dragoneye",\n                    ["The Sun"] = "TheSun",\n                    ["Galaxy Emperor"] = "GalaxyEmperor"\n                }\n\n                local function findSkinEffectsFolder(keyName)\n                    if not keyName then return nil end\n                    local resolvedKey = skinAliases[keyName] or keyName\n                    local noSpaceKey = resolvedKey:gsub("%s+", "")\n                    local assets = repStorage:FindFirstChild("Assets")\n                    if not assets then return nil end\n                    \n                    local candidates = {\n                        assets:FindFirstChild("Ball"),\n                        assets:FindFirstChild("Skins"),\n                        assets:FindFirstChild("Effects"),\n                        assets:FindFirstChild("Auras"),\n                        assets:FindFirstChild("Cosmetics"),\n                        assets\n                    }\n                    \n                    for _, folder in ipairs(candidates) do\n                        if folder then\n                            local found = folder:FindFirstChild(resolvedKey) or folder:FindFirstChild(noSpaceKey) or folder:FindFirstChild(keyName)\n                            if found then return found end\n                            for _, child in ipairs(folder:GetChildren()) do\n                                local n = child.Name:lower()\n                                if n == resolvedKey:lower() or n == noSpaceKey:lower() or n == keyName:lower() then\n                                    return child\n                                end\n                            end\n                        end\n                    end\n                    return nil\n                end\n\n                local function applyBallAppearance(keyName, ballIsHeld, targetBall)\n                    local currentBall = targetBall or ball\n                    for i, v in ipairs(oldEffects) do \n                        pcall(function()\n                            if typeof(v) == \'RBXScriptConnection\' then\n                                v:Disconnect()\n                            elseif typeof(v) == \'Instance\' and v.Parent then\n                                v.Parent = nil\n                                v:Destroy()\n                            end\n                        end)\n                    end \n                    table.clear(oldEffects)\n\n                    if not keyName then return end \n\n                    local effects = findSkinEffectsFolder(keyName)\n                    if not effects then return end \n\n                    local isSunSkin = keyName:lower():find(\'sun\') ~= nil\n\n                    local cachedMiscPlanets\n                    if isSunSkin then\n                        local assets = repStorage:FindFirstChild("Assets")\n                        local misc = assets and assets:FindFirstChild("Misc")\n                        cachedMiscPlanets = misc and misc:FindFirstChild("Planets")\n                    end\n\n                    local function setupPartPhysics(part)\n                        if part:IsA("BasePart") then\n                            part.CanCollide = false\n                            part.CanQuery = false\n                            part.CanTouch = false\n                            part.Massless = true\n                            part.Anchored = false\n                        end\n                        for _, child in ipairs(part:GetDescendants()) do\n                            if child:IsA("BasePart") then\n                                child.CanCollide = false\n                                child.CanQuery = false\n                                child.CanTouch = false\n                                child.Massless = true\n                                child.Anchored = false\n                            end\n                        end\n                    end\n\n                    local function isSunSlashEffect(pe)\n                        if not isSunSkin then return false end\n                        if pe:IsA(\'ParticleEmitter\') then\n                            local nLower = pe.Name:lower()\n                            local texStr = tostring(pe.Texture)\n                            if nLower:find(\'lightning\') or nLower:find(\'slash\') or texStr:find(\'14454562247\') or nLower == \'detail1\' then\n                                return true\n                            end\n                        end\n                        return false\n                    end\n\n                    local function handleParticleEmitter(pe)\n                        if not pe:IsA(\'ParticleEmitter\') then return end\n                        if isSunSlashEffect(pe) then\n                            pe.Enabled = false\n                            return\n                        end\n                        pe.Enabled = true\n                        local ec = pe:GetAttribute(\'EmitCount\')\n                        local ed = pe:GetAttribute(\'EmitDelay\')\n                        local edur = pe:GetAttribute(\'EmitDuration\')\n                        if ec then\n                            task.spawn(function()\n                                if ed then task.wait(ed) end\n                                while true do\n                                    if not pe or not pe.Parent then break end\n                                    pe:Emit(ec)\n                                    if edur then\n                                        task.wait(edur)\n                                    else\n                                        break\n                                    end\n                                end\n                            end)\n                        end\n                    end\n\n                    for _, possibleEffect in next, effects:GetChildren() do \n                        if possibleEffect:IsA(\'ParticleEmitter\') then \n                            if not isSunSlashEffect(possibleEffect) then\n                                local newEffect = possibleEffect:Clone() \n                                handleParticleEmitter(newEffect)\n                                if currentBall and currentBall:FindFirstChild("Attach") then\n                                    newEffect.Parent = currentBall.Attach\n                                elseif currentBall then\n                                    newEffect.Parent = currentBall\n                                end\n                                table.insert(oldEffects, newEffect)\n                            end\n                        end  \n                    end  \n\n                    local skinHolder = effects:FindFirstChild(\'CUSTOM_SKIN_HOLDER\')\n                    if skinHolder then \n                        local innerHolder = skinHolder:FindFirstChild(\'CUSTOM_SKIN_HOLDER\') or skinHolder\n                        \n                        local hasVisibleMesh = false\n                        for _, desc in ipairs(innerHolder:GetDescendants()) do\n                            if desc:IsA("MeshPart") then\n                                if desc.Transparency < 0.9 then\n                                    hasVisibleMesh = true\n                                    break\n                                end\n                            elseif desc:IsA("SpecialMesh") and desc.MeshId ~= "" then\n                                if desc.Parent and desc.Parent:IsA("BasePart") and desc.Parent.Transparency < 0.9 then\n                                    hasVisibleMesh = true\n                                    break\n                                end\n                            elseif desc:IsA("BasePart") then\n                                if desc.Transparency < 0.9 then\n                                    local nameLower = desc.Name:lower()\n                                    if not nameLower:find("att") and not nameLower:find("holder") and not nameLower:find("hitbox") and not nameLower:find("anchor") then\n                                        local isAnchor = false\n                                        for _, child in ipairs(desc:GetChildren()) do\n                                            if child:IsA("ParticleEmitter") or child:IsA("Attachment") or child:IsA("PointLight") or child:IsA("Trail") or child:IsA("Beam") then\n                                                isAnchor = true\n                                                break\n                                            end\n                                        end\n                                        if not isAnchor then\n                                            hasVisibleMesh = true\n                                            break\n                                        end\n                                    end\n                                end\n                            end\n                        end\n\n                        if currentBall and currentBall:FindFirstChild("Attach") then\n                            local skinData = items and items.Skins and items.Skins[keyName]\n                            local isTableSkin = skinData and typeof(skinData[3]) == "table"\n\n                            if isTableSkin and hasVisibleMesh then\n                                currentBall.Attach.Transparency = 1\n                            else\n                                currentBall.Attach.Transparency = 0\n                            end\n                            for _, oldWeldChild in ipairs(currentBall.Attach:GetChildren()) do\n                                if oldWeldChild:IsA("WeldConstraint") or oldWeldChild:IsA("BasePart") or oldWeldChild:IsA("Model") then\n                                    pcall(function() oldWeldChild:Destroy() end)\n                                end\n                            end\n                        end\n                        \n                        for _, skinElement in next, innerHolder:GetChildren() do \n                            if skinElement:IsA(\'MeshPart\') or skinElement:IsA(\'BasePart\') or skinElement:IsA(\'Model\') then \n                                local newEffect = skinElement:Clone()\n                                setupPartPhysics(newEffect)\n                                \n                                if currentBall and currentBall:FindFirstChild("Attach") then\n                                    if newEffect:IsA(\'BasePart\') then\n                                        local weld = Instance.new(\'WeldConstraint\')\n                                        weld.Parent = newEffect\n                                        newEffect.CFrame = currentBall.Attach.CFrame \n                                        weld.Part0 = currentBall.Attach   \n                                        weld.Part1 = newEffect\n                                        newEffect.Parent = currentBall.Attach \n                                    elseif newEffect:IsA(\'Model\') then\n                                        newEffect:PivotTo(currentBall.Attach.CFrame)\n                                        local primary = newEffect.PrimaryPart or newEffect:FindFirstChildWhichIsA(\'BasePart\')\n                                        if primary then\n                                            local weld = Instance.new(\'WeldConstraint\')\n                                            weld.Part0 = currentBall.Attach\n                                            weld.Part1 = primary\n                                            weld.Parent = primary\n\n                                            for _, subPart in ipairs(newEffect:GetDescendants()) do\n                                                if subPart:IsA(\'BasePart\') and subPart ~= primary then\n                                                    local hasWeld = false\n                                                    for _, w in ipairs(subPart:GetChildren()) do\n                                                        if w:IsA(\'WeldConstraint\') or w:IsA(\'Weld\') or w:IsA(\'Motor6D\') then\n                                                            hasWeld = true\n                                                            break\n                                                        end\n                                                    end\n                                                    if not hasWeld then\n                                                        local subWeld = Instance.new(\'WeldConstraint\')\n                                                        subWeld.Part0 = primary\n                                                        subWeld.Part1 = subPart\n                                                        subWeld.Parent = subPart\n                                                    end\n                                                end\n                                            end\n                                        end\n                                        newEffect.Parent = currentBall.Attach\n                                    end\n                                end\n                                for _, desc in ipairs(newEffect:GetDescendants()) do\n                                    if desc:IsA(\'ParticleEmitter\') then\n                                        handleParticleEmitter(desc)\n                                    end\n                                end\n                                table.insert(oldEffects, newEffect)\n                            end \n                        end  \n\n                        local attHolder = innerHolder:FindFirstChild(\'AttHolder\') or skinHolder:FindFirstChild(\'AttHolder\')\n                        if attHolder then \n                            for _, attEffect in next, attHolder:GetChildren() do \n                                local newAttEffect = attEffect:Clone() \n                                setupPartPhysics(newAttEffect)\n                                for _, desc in ipairs(newAttEffect:GetDescendants()) do\n                                    if desc:IsA(\'ParticleEmitter\') then\n                                        handleParticleEmitter(desc)\n                                    end\n                                end\n                                if currentBall and currentBall:FindFirstChild("Attach") then\n                                    newAttEffect.Parent = currentBall.Attach\n                                end\n                                table.insert(oldEffects, newAttEffect)\n                            end  \n                        end  \n                    end \n\n                    local r15ToR6 = {\n                        UpperTorso = "Torso", LowerTorso = "Torso",\n                        LeftUpperArm = "Left Arm", LeftLowerArm = "Left Arm", LeftHand = "Left Arm",\n                        RightUpperArm = "Right Arm", RightLowerArm = "Right Arm", RightHand = "Right Arm",\n                        LeftUpperLeg = "Left Leg", LeftLowerLeg = "Left Leg", LeftFoot = "Left Leg",\n                        RightUpperLeg = "Right Leg", RightLowerLeg = "Right Leg", RightFoot = "Right Leg",\n                    }\n\n                    local customAura = ballIsHeld and (effects:FindFirstChild(\'CUSTOM_AURA\') or effects:FindFirstChild(\'AURA\') or effects:FindFirstChild(\'BodyEffects\'))\n                    if customAura then \n                        local createdAtts = {}\n                        local pendingBeams = {}\n\n                        for _, bodyPart in next, customAura:GetChildren() do \n                            local targetCharPart = character and (character:FindFirstChild(bodyPart.Name) or character:FindFirstChild(r15ToR6[bodyPart.Name] or ""))\n                            if targetCharPart then\n                                for _, effect in next, bodyPart:GetChildren() do   \n                                    if effect:IsA(\'CFrameValue\') then \n                                        local attachment = Instance.new(\'Attachment\')\n                                        attachment.Name = effect.Name\n                                        attachment.CFrame = effect.Value\n                                        attachment.Parent = targetCharPart\n\n                                        if not createdAtts[effect.Name] then\n                                            createdAtts[effect.Name] = {}\n                                        end\n                                        table.insert(createdAtts[effect.Name], attachment)\n\n                                        local scopedKey = targetCharPart.Name .. "_" .. effect.Name\n                                        if not createdAtts[scopedKey] then\n                                            createdAtts[scopedKey] = {}\n                                        end\n                                        table.insert(createdAtts[scopedKey], attachment)\n                                        table.insert(oldEffects, attachment)\n\n                                        for _, cfEffect in next, effect:GetChildren() do \n                                            local newCfEffect = cfEffect:Clone() \n                                            setupPartPhysics(newCfEffect)\n                                            if newCfEffect:IsA(\'Beam\') then\n                                                newCfEffect.Parent = targetCharPart\n                                                newCfEffect.Enabled = true\n                                                table.insert(pendingBeams, { beam = newCfEffect, attName = effect.Name, parentPart = targetCharPart })\n                                            else\n                                                newCfEffect.Parent = attachment\n                                            end\n                                            table.insert(oldEffects, newCfEffect)\n                                        end \n                                        continue\n                                    end \n\n                                    if effect:IsA(\'BasePart\') or effect:IsA(\'Model\') then \n                                        local newPart\n                                        local isSunPlanet = isSunSkin and (effect.Name == \'Earth\' or effect.Name == \'Jupiter\' or effect.Name == \'Mars\' or effect.Name == \'Saturn\')\n                                        if isSunPlanet then\n                                            local realPlanet = cachedMiscPlanets and cachedMiscPlanets:FindFirstChild(effect.Name)\n                                            if realPlanet then\n                                                newPart = realPlanet:Clone()\n                                                for k, v in pairs(effect:GetAttributes()) do\n                                                    newPart:SetAttribute(k, v)\n                                                end\n                                            else\n                                                newPart = effect:Clone()\n                                            end\n                                        else\n                                            newPart = effect:Clone()\n                                        end\n                                        setupPartPhysics(newPart)\n\n                                        local isOrbitPart = newPart:IsA(\'BasePart\') and not newPart:FindFirstChildWhichIsA(\'WeldConstraint\') and bodyPart.Name == \'HumanoidRootPart\'\n\n                                        if isOrbitPart then\n                                            newPart.Anchored = false\n                                            newPart.CanCollide = false\n                                            newPart.CanQuery = false\n                                            newPart.CanTouch = false\n                                            newPart.Massless = true\n\n                                            local hrp = character:FindFirstChild(\'HumanoidRootPart\') or character:FindFirstChild(\'Torso\')\n                                            newPart.Parent = character\n                                            local moons = {}\n                                            for _, desc in ipairs(newPart:GetDescendants()) do\n                                                if desc:IsA(\'BasePart\') then\n                                                    desc.Anchored = false\n                                                    desc.CanCollide = false\n                                                    desc.Massless = true\n                                                    if desc.Name == \'Moon\' then\n                                                        table.insert(moons, desc)\n                                                    end\n                                                end\n                                                if desc:IsA(\'ParticleEmitter\') then\n                                                    if isSunSlashEffect(desc) then\n                                                        desc.Enabled = false\n                                                    else\n                                                        desc.Enabled = true\n                                                        local ec = desc:GetAttribute(\'EmitCount\')\n                                                        if ec then desc:Emit(ec) end\n                                                    end\n                                                end\n                                            end\n                                            \n                                            for _, moon in ipairs(moons) do\n                                                local ap = moon:FindFirstChildWhichIsA("AlignPosition")\n                                                if ap then ap:Destroy() end\n                                                local moonMotor = Instance.new("Motor6D")\n                                                moonMotor.Part0 = newPart\n                                                moonMotor.Part1 = moon\n                                                moonMotor.C1 = CFrame.new()\n                                                moonMotor.Parent = moon\n                                                \n                                                local mAngle = 0\n                                                local moonConn\n                                                moonConn = RunService.Heartbeat:Connect(function(dt)\n                                                    if not moon or not moon.Parent or not newPart or not newPart.Parent then \n                                                        if moonConn then moonConn:Disconnect() end\n                                                        return \n                                                    end\n                                                    mAngle = mAngle + (dt * 1.5)\n                                                    moonMotor.C0 = CFrame.Angles(0, mAngle, 0) * CFrame.new(0, 0.2, 1.2)\n                                                end)\n                                                table.insert(oldEffects, moonConn)\n                                            end\n                                            local rawOffset = newPart:GetAttribute(\'Offset\')\n                                            local manipulate = newPart:GetAttribute(\'Manipulate\')\n                                            local yOffsetAttr = newPart:GetAttribute(\'YOffset\')\n                                            local motor = Instance.new(\'Motor6D\')\n                                            motor.Part0 = hrp\n                                            motor.Part1 = newPart\n                                            motor.C1 = CFrame.new()\n                                            motor.Parent = newPart\n                                            if manipulate then\n                                                local centerCF\n                                                if rawOffset and typeof(rawOffset) == \'CFrame\' then\n                                                    centerCF = rawOffset\n                                                else\n                                                    centerCF = CFrame.new(0, tonumber(yOffsetAttr) or 1.6, 2)\n                                                end\n                                                local angleOffsetDeg = newPart:GetAttribute(\'AngleOffset\') or 0\n                                                local orbitSpeed = newPart:GetAttribute(\'OrbitSpeed\') or 0.35\n                                                local startAngle = math.rad(angleOffsetDeg)\n                                                local orbitRadius = 2.5\n                                                motor.C0 = centerCF * CFrame.Angles(0, 0, startAngle) * CFrame.new(orbitRadius, 0, 0)\n                                                local angle = 0\n                                                local conn\n                                                conn = RunService.Heartbeat:Connect(function(dt)\n                                                    if not motor or not motor.Parent then \n                                                        if conn then conn:Disconnect() end\n                                                        return \n                                                    end\n                                                    angle = angle + dt * orbitSpeed\n                                                    motor.C0 = centerCF * CFrame.Angles(0, 0, startAngle + angle) * CFrame.new(orbitRadius, 0, 0)\n                                                end)\n                                                table.insert(oldEffects, conn)\n                                            elseif yOffsetAttr and not rawOffset then\n                                                local yOff = tonumber(yOffsetAttr) or 1.5\n                                                local orbitRadius = 2.4\n                                                local orbitSpeed = 0.4\n\n                                                local totalOrbit = 0\n                                                local myIdx = 0\n                                                for _, sib in ipairs(bodyPart:GetChildren()) do\n                                                    if sib:IsA(\'BasePart\') and not sib:FindFirstChildWhichIsA(\'WeldConstraint\') then\n                                                        totalOrbit = totalOrbit + 1\n                                                        if sib == effect then myIdx = totalOrbit end\n                                                    end\n                                                end\n                                                local startAngle = (myIdx - 1) / math.max(totalOrbit, 1) * math.pi * 2\n                                                motor.C0 = CFrame.new(0, yOff, 0) * CFrame.Angles(0, startAngle, 0) * CFrame.new(orbitRadius, 0, 0)\n                                                local angle = 0\n                                                local conn\n                                                conn = RunService.Heartbeat:Connect(function(dt)\n                                                    if not motor or not motor.Parent then \n                                                        if conn then conn:Disconnect() end\n                                                        return \n                                                    end\n                                                    angle = angle + dt * orbitSpeed\n                                                    motor.C0 = CFrame.new(0, yOff, 0) * CFrame.Angles(0, startAngle + angle, 0) * CFrame.new(orbitRadius, 0, 0)\n                                                end)\n                                                table.insert(oldEffects, conn)\n                                            else\n                                                local centerCF\n                                                if rawOffset and typeof(rawOffset) == \'CFrame\' then\n                                                    centerCF = rawOffset\n                                                else\n                                                    centerCF = CFrame.new(0, tonumber(yOffsetAttr) or 1.6, 2)\n                                                end\n                                                motor.C0 = centerCF\n                                            end\n                                            table.insert(oldEffects, newPart)\n                                            table.insert(oldEffects, motor)\n                                        else\n                                            local offset = newPart:GetAttribute(\'Offset\') or CFrame.new()\n                                            if newPart:IsA(\'BasePart\') then\n                                                local weld = Instance.new(\'WeldConstraint\')\n                                                weld.Parent = newPart\n                                                newPart.CFrame = targetCharPart.CFrame * offset\n                                                weld.Part0 = targetCharPart\n                                                weld.Part1 = newPart\n                                                newPart.Parent = targetCharPart\n                                            elseif newPart:IsA(\'Model\') then\n                                                newPart:PivotTo(targetCharPart.CFrame * offset)\n                                                local primary = newPart.PrimaryPart or newPart:FindFirstChildWhichIsA(\'BasePart\')\n                                                if primary then\n                                                    local weld = Instance.new(\'WeldConstraint\')\n                                                    weld.Part0 = targetCharPart\n                                                    weld.Part1 = primary\n                                                    weld.Parent = primary\n\n                                                    for _, subPart in ipairs(newPart:GetDescendants()) do\n                                                        if subPart:IsA(\'BasePart\') and subPart ~= primary then\n                                                            local hasWeld = false\n                                                            for _, w in ipairs(subPart:GetChildren()) do\n                                                                if w:IsA(\'WeldConstraint\') or w:IsA(\'Weld\') or w:IsA(\'Motor6D\') then\n                                                                    hasWeld = true\n                                                                    break\n                                                                end\n                                                            end\n                                                            if not hasWeld then\n                                                                local subWeld = Instance.new(\'WeldConstraint\')\n                                                                subWeld.Part0 = primary\n                                                                subWeld.Part1 = subPart\n                                                                subWeld.Parent = subPart\n                                                            end\n                                                        end\n                                                    end\n                                                end\n                                                newPart.Parent = targetCharPart\n                                            end\n                                        end\n                                        for _, desc in ipairs(newPart:GetDescendants()) do\n                                            if desc:IsA(\'ParticleEmitter\') then\n                                                if isSunSlashEffect(desc) then\n                                                    desc.Enabled = false\n                                                else\n                                                    desc.Enabled = true\n                                                    local ec = desc:GetAttribute(\'EmitCount\')\n                                                    if ec then desc:Emit(ec) end\n                                                end\n                                            end\n                                        end\n                                        table.insert(oldEffects, newPart)\n                                        continue\n                                    end \n\n                                    local newEffect = effect:Clone()\n                                    setupPartPhysics(newEffect)\n                                    newEffect.Parent = targetCharPart\n                                    if newEffect:IsA(\'ParticleEmitter\') then\n                                        if isSunSlashEffect(newEffect) then\n                                            newEffect.Enabled = false\n                                        else\n                                            newEffect.Enabled = true\n                                            local ec = newEffect:GetAttribute(\'EmitCount\')\n                                            if ec then newEffect:Emit(ec) end\n                                        end\n                                    end\n                                    table.insert(oldEffects, newEffect)\n                                end \n                            end\n                        end   \n\n                        for _, entry in ipairs(pendingBeams) do\n                            local beam = entry.beam\n                            local linkName = entry.attName .. \'_Link\'\n                            local parentPart = entry.parentPart\n                            local scopedSrcKey = parentPart and (parentPart.Name .. "_" .. entry.attName)\n                            local scopedLinkKey = parentPart and (parentPart.Name .. "_" .. linkName)\n\n                            local srcList = (scopedSrcKey and createdAtts[scopedSrcKey]) or createdAtts[entry.attName]\n                            local linkList = (scopedLinkKey and createdAtts[scopedLinkKey]) or createdAtts[linkName]\n                            if srcList and srcList[1] then\n                                beam.Attachment0 = srcList[1]\n                            end\n                            if linkList and linkList[1] then\n                                beam.Attachment1 = linkList[1]\n                            end\n                        end\n                    end \n                end\n\n                local sharedUtil = require(game.ReplicatedStorage.Modules.SharedUtil)\n                local function applyBallEffects(name, basketball)\n                    local effectFolder = (effectAssets and effectAssets:FindFirstChild(name)) or findSkinEffectsFolder(name)\n                    if not effectFolder then return end  \n                    local basketballObj = sharedUtil.Ball:GetClosestBall(localPlayer)\n                    if not basketballObj then return end\n                    \n                    for _, child in ipairs(basketballObj:GetChildren()) do\n                        if child:IsA(\'Trail\') then\n                            child:Destroy()\n                        end\n                    end\n                    \n                    for i,v in next, effectFolder:GetChildren() do \n                        if v:IsA(\'Trail\') then \n                            local a = v:Clone() \n                            a.Enabled = true \n                            local a0 = basketballObj:FindFirstChild("A0")\n                            local a1 = basketballObj:FindFirstChild("A1")\n                            if a0 and a1 then\n                                a.Attachment0 = a0 \n                                a.Attachment1 = a1\n                            end\n                            a.Parent = basketballObj\n                            table.insert(oldBallEffects, a)\n                        elseif v:IsA(\'Sound\') then\n                            local oldSound = basketballObj:FindFirstChild(v.Name)\n                            if oldSound then\n                                oldSound.SoundId = v.SoundId\n                                oldSound.Volume = v.Volume\n                                for attrName, attrValue in pairs(v:GetAttributes()) do\n                                    oldSound:SetAttribute(attrName, attrValue)\n                                end\n                            else\n                                local newSound = v:Clone()\n                                newSound.Parent = basketballObj\n                                table.insert(oldBallEffects, newSound)\n                            end\n                        elseif v:IsA(\'ParticleEmitter\') then \n                            local newEffect = v:Clone() \n                            newEffect.Parent = basketballObj\n                            table.insert(oldBallEffects, newEffect)\n                        elseif v:IsA(\'Folder\') then\n                            if v.Name == "EffectAtt" then\n                                local a0 = basketballObj:FindFirstChild("A0")\n                                if a0 then\n                                    for _, effect in next, v:GetChildren() do \n                                        local newEffect = effect:Clone() \n                                        newEffect.Parent = a0\n                                        table.insert(oldBallEffects, newEffect)\n                                    end  \n                                end\n                            elseif v.Name == "EffectAtt2" then\n                                local a1 = basketballObj:FindFirstChild("A1")\n                                if a1 then\n                                    for _, effect in next, v:GetChildren() do \n                                        local newEffect = effect:Clone() \n                                        newEffect.Parent = a1\n                                        table.insert(oldBallEffects, newEffect)\n                                    end  \n                                end\n                            else\n                                local existing = basketballObj:FindFirstChild(v.Name)\n                                if existing then existing:Destroy() end\n                                local clone = v:Clone()\n                                clone.Parent = basketballObj\n                                table.insert(oldBallEffects, clone)\n                            end\n                        end\n                    end \n                end \n\n                local function changeEmote(keyName)\n                    if not keyName then return end\n                    data.Emotes.Equipped = keyName\n                end \n\n                local _skinGeneration = 0\n                local function changeBallSkin(ballObj)\n                    _skinGeneration = _skinGeneration + 1\n                    local myGen = _skinGeneration\n                    task.spawn(function()\n                        if ballObj and currentSkin then \n                            local skinData = items.Skins[currentSkin]\n                            if not skinData then return end\n\n                            if ballObj.Parent == character then \n                                ballObj:WaitForChild(\'Attach\')\n                            end \n                            if myGen ~= _skinGeneration then return end\n\n                            local attach = ballObj:FindFirstChild(\'Attach\') or ballObj\n\n                            WaitForChildWhichIsA(attach, \'SpecialMesh\')\n                            if myGen ~= _skinGeneration then return end\n                            \n                            attach.Transparency = 0\n\n                            if typeof(skinData[3]) == \'number\' then \n                                attach:FindFirstChildWhichIsA(\'SpecialMesh\').MeshId = \'rbxassetid://14536927547\'\n                                attach:FindFirstChildWhichIsA(\'SpecialMesh\').TextureId = \'rbxassetid://\' .. skinData[3]\n                            end\n\n                            if typeof(skinData[3]) == \'table\' then \n                                attach.Transparency = 1\n                                attach:FindFirstChildWhichIsA(\'SpecialMesh\').TextureId = \'\'\n                                attach:FindFirstChildWhichIsA(\'SpecialMesh\').MeshId = \'rbxassetid://\' .. skinData[4]\n                            end  \n\n                            applyBallAppearance(currentSkin, ballObj.Parent == character, ballObj)\n                        end \n                    end)\n                end \n\n\n\n                local function changeBanner(keyName)\n                    if not keyName then return end\n                    local newBg = bannerAssets:FindFirstChild(keyName)\n                    if not newBg then return end\n\n                    local infoUi = character.HumanoidRootPart.Info \n                    local currentBg = infoUi.BG\n                    if infoUi:FindFirstChild(\'Frame\') then \n                        infoUi.Frame:Destroy()\n                    end \n\n                    local score = currentBg.Score.Record.Text\n                    local streak = currentBg.Streak.Title.Text\n\n                    currentBg:Destroy() \n\n                    local newBgFrame = newBg.BG:Clone() \n                    local newAnimFrame = newBg:FindFirstChild(\'Frame\')\n                    if newAnimFrame then \n                        newAnimFrame = newAnimFrame:Clone()\n                        newAnimFrame.ZIndex = 0\n                        newAnimFrame.Parent = infoUi\n                    end \n\n                    newBgFrame.UsernameBox.Username.Text = localPlayer.Name \n                    newBgFrame.Streak.Title.Text = streak \n                    newBgFrame.Score.Record.Text = score\n                    newBgFrame.Parent = infoUi \n                end \n\n                local function newEquip(category, name)\n                    for i,v in next, data[category].Inventory do \n                        if v[1] == name then \n                            data[category].Inventory[i][2] = true \n                        else \n                            data[category].Inventory[i][2] = false \n                        end \n                    end  \n                end\n\n                if not inventoryFrames:GetAttribute("_UnlockHooked") then\n                    inventoryFrames:SetAttribute("_UnlockHooked", true)\n                    for _, category in next, inventoryFrames:GetChildren() do \n                        if not newInventory[category.Name] then continue end \n                        for _, item in next, category:GetChildren() do \n                            if item:IsA(\'ImageButton\') then \n                                if item.Name:match(\'Model\') then continue end \n\n                                if category.Name == \'Banners\' then \n                                    local bannerName = getRealItemName(\'Banners\', item.Name)\n                                    item.Icon.Image = bannerAssets[bannerName].BG.BasicBanner.Image\n                                end \n\n                                if getconnections and getconnections(item.MouseButton1Click)[1] then\n                                    hookfunction(getconnections(item.MouseButton1Click)[1].Function, function() end)\n                                end\n\n                                item.MouseButton1Click:Connect(function()\n                                    unequipAll(category.Name)\n                                    newEquip(category.Name, item.Name)\n                                    item.Using.Visible = true\n                                    \n                                    if category.Name == \'Skins\' then \n                                        currentSkin = item.Name \n                                        changeBallSkin(ball)\n                                    elseif category.Name == \'Emotes\' then \n                                        currentEmote = item.Name \n                                        changeEmote(currentEmote)\n                                    elseif category.Name == \'Banners\' then \n                                        currentBanner = item.Name \n                                        changeBanner(currentBanner)\n                                    elseif category.Name == \'Effects\' then \n                                        currentEffect = item.Name \n                                    end \n                                end)\n                            end \n                        end \n                    end \n                end\n\n                local shopTab = storeFrames:FindFirstChild("ShopTab")\n                if shopTab and not shopTab:GetAttribute("_UnlockHooked") then\n                    shopTab:SetAttribute("_UnlockHooked", true)\n                    local list = shopTab.Selection.Buttons:FindFirstChild("List")\n                    local bottomBtn = shopTab.View.Bottom.Holder:FindFirstChild("Button")\n                    local selectedItemName = nil\n                    local selectedItemCategory = nil\n\n                    if list then\n                        for _, itemFrame in ipairs(list:GetChildren()) do\n                            if itemFrame:IsA("Frame") then\n                                local btn = itemFrame:FindFirstChild("Button")\n                                if btn and getconnections and getconnections(btn.MouseButton1Click)[1] then\n                                    local frameName = itemFrame.Name\n                                    local oldItemFn\n                                    oldItemFn = hookfunction(getconnections(btn.MouseButton1Click)[1].Function, function()\n                                        if items.Dunks and items.Dunks[frameName] then\n                                            selectedItemName = frameName\n                                            selectedItemCategory = "Dunks"\n                                        elseif items.Emotes and items.Emotes[frameName] then\n                                            selectedItemName = frameName\n                                            selectedItemCategory = "Emotes"\n                                        elseif items.Skins and items.Skins[frameName] then\n                                            selectedItemName = frameName\n                                            selectedItemCategory = "Skins"\n                                        elseif items.Effects and items.Effects[frameName] then\n                                            selectedItemName = frameName\n                                            selectedItemCategory = "Effects"\n                                        elseif items.Banners and items.Banners[frameName] then\n                                            selectedItemName = frameName\n                                            selectedItemCategory = "Banners"\n                                        else\n                                            selectedItemName = nil\n                                            selectedItemCategory = nil\n                                        end\n\n                                        local result = oldItemFn()\n\n                                        if selectedItemCategory and bottomBtn then\n                                            task.defer(function()\n                                                local t = bottomBtn:FindFirstChild("Title")\n                                                if t then t.Text = "EQUIP" end\n                                            end)\n                                        end\n\n                                        return result\n                                    end)\n                                end\n                            end\n                        end\n                    end\n\n                    if bottomBtn and getconnections and getconnections(bottomBtn.MouseButton1Click)[1] then\n                        local oldBottomFn\n                        oldBottomFn = hookfunction(getconnections(bottomBtn.MouseButton1Click)[1].Function, function()\n                            if selectedItemCategory and selectedItemName then\n                                if selectedItemCategory == "Dunks" or selectedItemCategory == "Emotes" then\n                                    if not data[selectedItemCategory] then data[selectedItemCategory] = {} end\n                                    data[selectedItemCategory].Equipped = selectedItemName\n\n                                    local t = bottomBtn:FindFirstChild("Title")\n                                    if t then t.Text = "EQUIPPED âœ“" end\n\n                                    if selectedItemCategory == "Emotes" then\n                                        changeEmote(selectedItemName)\n                                    end\n\n                                    return\n                                else\n                                    task.spawn(function()\n                                        local t = bottomBtn:FindFirstChild("Title")\n                                        if t then t.Text = "EQUIPPED âœ“" end\n                                    end)\n                                end\n                            end\n                            return oldBottomFn()\n                        end)\n                    end\n                end\n\n                if economy.Equip and economy.Equip.Fire then\n                    local oldEquipFire\n                    oldEquipFire = hookfunction(economy.Equip.Fire, function(self, ...)\n                        if self == economy.Equip then\n                            local args = {...}\n                            local category = args[1]\n                            local index = args[2]\n\n                            if category and data[category] then\n                                if data[category].Inventory then\n                                    local itemKey = data[category].Inventory[index] and data[category].Inventory[index][1]\n                                    for i, _ in ipairs(data[category].Inventory) do\n                                        data[category].Inventory[i][2] = (i == index)\n                                    end\n                                    if itemKey then\n                                        if category == \'Skins\' then\n                                            currentSkin = itemKey\n                                            local currentBall = localPlayer.Character:FindFirstChild(\'Basketball\')\n                                            changeBallSkin(currentBall or ball)\n                                        elseif category == \'Effects\' then\n                                            currentEffect = itemKey\n                                        elseif category == \'Banners\' then\n                                            currentBanner = itemKey\n                                            changeBanner(currentBanner)\n                                        elseif category == \'Emotes\' then\n                                            currentEmote = itemKey\n                                            changeEmote(currentEmote)\n                                        end\n                                    end\n                                    if inventory.UpdateList then\n                                        inventory:UpdateList()\n                                    end\n                                    return\n                                elseif category == \'Dunks\' or category == \'Abilities\' then\n                                    data[category].Equipped = index\n                                    local shopTab = localPlayer.PlayerGui.Main.Store.Glow.Holder.Main.ShopFrames:FindFirstChild("ShopTab")\n                                    if shopTab and shopTab:FindFirstChild("View") and shopTab.View:FindFirstChild("Bottom") and shopTab.View.Bottom:FindFirstChild("Holder") then\n                                        local btn = shopTab.View.Bottom.Holder:FindFirstChild("Button")\n                                        if btn and btn:FindFirstChild("Title") then\n                                            btn.Title.Text = "EQUIPPED"\n                                        end\n                                    end\n                                    return\n                                end\n                            end\n                            return\n                        end\n                        return oldEquipFire(self, ...)\n                    end)\n                end\n\n                local ballAncestryConnection = nil\n\n                local function ballAdded(ballObj)\n                    if ballObj.Name ~= \'Basketball\' then return end \n\n                    ball = ballObj \n                    if currentSkin then \n                        changeBallSkin(ball)\n                    end \n\n                    if ballAncestryConnection then\n                        pcall(function() ballAncestryConnection:Disconnect() end)\n                        ballAncestryConnection = nil\n                    end\n\n                    local _ancestryDebounce = false\n                    ballAncestryConnection = ball.AncestryChanged:Connect(function()\n                        if ball ~= ballObj then return end\n                        if _ancestryDebounce then return end\n                        _ancestryDebounce = true\n                        task.defer(function()\n                            _ancestryDebounce = false\n                        end)\n\n                        for i,v in next, oldEffects do \n                            pcall(function()\n                                if typeof(v) == \'RBXScriptConnection\' then\n                                    v:Disconnect()\n                                elseif typeof(v) == \'Instance\' and v.Parent then\n                                    v.Parent = nil\n                                    v:Destroy()\n                                end\n                            end)\n                        end\n                        table.clear(oldEffects)\n                        local workspaceBall = getMyWorkspaceBall()\n                        if workspaceBall then\n                            changeBallSkin(workspaceBall)\n                        end\n                    end) \n                end\n\n                localPlayer.CharacterAdded:Connect(function(newChar)\n                    character = newChar\n                    newChar.ChildAdded:Connect(ballAdded)\n                end)\n                character.ChildAdded:Connect(ballAdded)\n\n                local oldEffect\n                oldEffect = hookfunction(visuals.Effect, function(self, effect, ...)\n                    local args = {...}\n\n                    pcall(function()\n                        if effect == \'StartBallEffect\' then \n                            local effectOwner = args[3]\n                            if effectOwner == character.HumanoidRootPart then \n                                local effectName = currentEffect or \'Default\'\n                                args[1] = effectName\n                                local ballObj = sharedUtil.Ball:GetClosestBall(localPlayer)\n                                if ballObj then\n                                    applyBallEffects(effectName, ballObj)\n                                end\n                            end \n                        end \n\n                        if effect == \'BallEffect\' then \n                            local effectBall = args[3]\n                            local myBall = sharedUtil.Ball:GetClosestBall(localPlayer)\n                            if myBall and effectBall == myBall then \n                                for _, effectObj in next, oldBallEffects do \n                                    pcall(function()\n                                        effectObj.Parent = nil \n                                        effectObj:Destroy()\n                                    end)\n                                end \n                                table.clear(oldBallEffects)\n                                local effectName = currentEffect or \'Default\'\n                                args[1] = effectName\n                            end \n                        end \n                    end) \n\n                    return oldEffect(self, effect, unpack(args))\n                end)\n\n                local currentEmoteSounds = {}\n\n                local function cleanupEmoteExtras()\n                    for _, prop in next, currentEmoteProps do\n                        pcall(function() prop:Destroy() end)\n                    end\n                    currentEmoteProps = {}\n                    for _, snd in next, currentEmoteSounds do\n                        pcall(function()\n                            snd:Stop()\n                            snd:Destroy()\n                        end)\n                    end\n                    currentEmoteSounds = {}\n                    currentEmoteSound = nil\n                end\n\n                local function spawnEmoteExtras(emoteName, char)\n                    cleanupEmoteExtras()\n                    local hrp = char:FindFirstChild("HumanoidRootPart")\n                    if not hrp then return end\n\n                    local assetsFolder = repStorage:FindFirstChild("Assets")\n                    local emoteItemsFolder = assetsFolder and assetsFolder:FindFirstChild("EmoteItems")\n                    if not emoteItemsFolder then return end\n\n                    local assetFolder = emoteItemsFolder:FindFirstChild(emoteName)\n                    if not assetFolder then return end\n\n                    local propFolder = assetFolder:FindFirstChild("Prop")\n                    if propFolder then\n                        local propsToAttach = {}\n                        if propFolder:IsA("BasePart") or propFolder:IsA("Model") or propFolder:IsA("Accessory") or propFolder:IsA("Tool") then\n                            table.insert(propsToAttach, propFolder)\n                        elseif propFolder:IsA("Folder") then\n                            for _, child in next, propFolder:GetChildren() do\n                                table.insert(propsToAttach, child)\n                            end\n                        end\n\n                        for _, propTpl in next, propsToAttach do\n                            local prop = propTpl:Clone()\n                            prop.Parent = char\n\n                            if prop:IsA("Accessory") then\n                                local hum = char:FindFirstChildOfClass("Humanoid")\n                                if hum then\n                                    hum:AddAccessory(prop)\n                                    table.insert(currentEmoteProps, prop)\n                                end\n                                continue\n                            end\n\n                            local handle = prop\n                            if prop:IsA("Model") or prop:IsA("Tool") then\n                                handle = prop.PrimaryPart or prop:FindFirstChild("Handle") or prop:FindFirstChildWhichIsA("BasePart")\n                            end\n\n                            local originalCFrames = {}\n                            if prop:IsA("BasePart") then originalCFrames[prop] = prop.CFrame end\n                            for _, p in next, prop:GetDescendants() do\n                                if p:IsA("BasePart") then originalCFrames[p] = p.CFrame end\n                            end\n\n                            if prop:IsA("Model") or prop:IsA("Tool") then\n                                if handle then\n                                    local pLimb = handle:GetAttribute("Limb") or prop:GetAttribute("Limb")\n                                    local pTarget = pLimb and char:FindFirstChild(pLimb) or char:FindFirstChild("Right Arm") or char:FindFirstChild("RightHand") or hrp\n                                    local pOffset = handle:GetAttribute("Offset") or originalCFrames[handle] or CFrame.new()\n                                    prop:PivotTo(pTarget.CFrame * pOffset)\n                                end\n                            end\n\n                            local partsToWeld = {}\n                            if prop:IsA("BasePart") then table.insert(partsToWeld, prop) end\n                            for _, p in next, prop:GetDescendants() do\n                                if p:IsA("BasePart") then table.insert(partsToWeld, p) end\n                            end\n\n                            for _, part in next, partsToWeld do\n                                part.Anchored = false\n                                part.CanCollide = false\n                                \n                                local limbName = part:GetAttribute("Limb")\n                                if limbName == nil and part == handle then\n                                    limbName = prop:GetAttribute("Limb")\n                                end\n                                \n                                local explicitLimb = true\n                                local targetBodyPart\n                                if limbName and type(limbName) == "string" then\n                                    targetBodyPart = char:FindFirstChild(limbName)\n                                end\n                                \n                                if not targetBodyPart then\n                                    explicitLimb = false\n                                    if part == handle or not handle then\n                                        targetBodyPart = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightHand") or hrp\n                                    else\n                                        targetBodyPart = handle\n                                    end\n                                end\n                                \n                                if explicitLimb or part == handle or not handle then\n                                    local existingJoint = part:FindFirstChild("Attach")\n                                    if existingJoint and existingJoint:IsA("JointInstance") then\n                                        existingJoint.Part0 = targetBodyPart\n                                        existingJoint.Part1 = part\n                                    else\n                                        if not (part == handle and (prop:IsA("Model") or prop:IsA("Tool"))) then\n                                            local offsetCFrame = part:GetAttribute("Offset") or originalCFrames[part] or CFrame.new()\n                                            local att = part:FindFirstChildWhichIsA("Attachment")\n                                            local targetCFrame = targetBodyPart.CFrame\n                                            \n                                            if att and att.Name ~= "Attach" then\n                                                local charAtt = char:FindFirstChild(att.Name, true)\n                                                if charAtt then\n                                                    targetCFrame = charAtt.WorldCFrame * att.CFrame:Inverse()\n                                                    targetBodyPart = charAtt.Parent\n                                                end\n                                            end\n                                            \n                                            part.CFrame = targetCFrame * offsetCFrame\n                                        end\n                                        \n                                        local weld = Instance.new("WeldConstraint")\n                                        weld.Part0 = targetBodyPart\n                                        weld.Part1 = part\n                                        weld.Parent = part\n                                    end\n                                else\n                                    if not part:FindFirstChildWhichIsA("JointInstance") then\n                                        local pWeld = Instance.new("WeldConstraint")\n                                        pWeld.Part0 = handle\n                                        pWeld.Part1 = part\n                                        pWeld.Parent = part\n                                    end\n                                end\n                            end\n                            table.insert(currentEmoteProps, prop)\n                        end\n                    end\n\n                    for _, child in next, assetFolder:GetDescendants() do\n                        if child:IsA("Sound") then\n                            local sound = child:Clone()\n                            sound.Parent = hrp\n                            \n                            local delayTime = child:GetAttribute("Delay") or 0\n                            if delayTime > 0 then\n                                task.delay(delayTime, function()\n                                    if sound.Parent then\n                                        sound:Play()\n                                    end\n                                end)\n                            else\n                                sound:Play()\n                            end\n                            \n                            table.insert(currentEmoteSounds, sound)\n                            if sound.Looped or child.Parent.Name == "Loop" then\n                                currentEmoteSound = sound\n                                sound.Looped = true\n                            end\n                        end\n                    end\n                end\n\n                local controlService = knit.GetService("ControlService")\n                if controlService and controlService.Emote and controlService.Emote.Fire then\n                    local oldFire\n                    oldFire = hookfunction(controlService.Emote.Fire, function(self, ...)\n                        if self == controlService.Emote then\n                            local pc = knit.GetController("PlayerController")\n                            local char = localPlayer.Character\n                            if pc and char and data.Emotes and data.Emotes.Equipped and data.Emotes.Equipped ~= "None" and data.Emotes.Equipped ~= "Default" then\n                                if not localPlayer:GetAttribute("Emoting") then\n                                    local animName = "Dance_" .. data.Emotes.Equipped\n                                    pc:PlayAnimation(animName)\n                                    pc.Args.LastEmote = animName\n                                    localPlayer:SetAttribute("Emoting", true)\n                                    spawnEmoteExtras(data.Emotes.Equipped, char)\n                                end\n                                return\n                            end\n                        elseif controlService.StopEmote and self == controlService.StopEmote then\n                            local pc = knit.GetController("PlayerController")\n                            local char = localPlayer.Character\n                            if pc and char and localPlayer:GetAttribute("Emoting") then\n                                if pc.Args.LastEmote then\n                                    pc:StopAnimation(pc.Args.LastEmote)\n                                end\n                                localPlayer:SetAttribute("Emoting", false)\n                                cleanupEmoteExtras()\n                                return\n                            end\n                        end\n                        return oldFire(self, ...)\n                    end)\n                end\n            end\n\n            unlockAll()\n        '
      )
    end
  end,
})

cosmeticsSection:Button({
  Name = "Unlock Skills",
  Callback = function()
    if getactors and #getactors() > 0 then
      run_on_actor(getactors()[1], [[
            local repStorage = game:GetService('ReplicatedStorage')
            local knit = require(repStorage.Packages.Knit)
            
            pcall(function()
                local data = knit.GetController('DataController').Data
                if data then
                    if type(data.Abilities) ~= "table" then data.Abilities = {} end
                    rawset(data.Abilities, "Post", true)
                    rawset(data.Abilities, "Lob", true)
                    rawset(data.Abilities, "PumpFake", true)
                    rawset(data.Abilities, "Eurostep", true)
                    
                    if type(data.Gamepasses) ~= "table" then data.Gamepasses = {} end
                    rawset(data.Gamepasses, "PostGP", true)
                    rawset(data.Gamepasses, "LobGP", true)
                    rawset(data.Gamepasses, "EuroGP", true)
                end
            end)
        ]])
    end
  end,
})

local merquryConfig = coreGui:FindFirstChild("MerquryConfig")

if merquryConfig then
  pcall(function()
    for _, value39 in ipairs(merquryConfig:GetChildren()) do
      if value39:IsA("BoolValue") then
        value39.Value = false
      end
    end
  end)

  merquryConfig:Destroy()
end

merquryConfig = Instance.new("Folder")
merquryConfig.Name = "MerquryConfig"
merquryConfig.Parent = coreGui

local function getInstance(p17, name5, value40)
  local instance11 = Instance.new(p17, merquryConfig)
  instance11.Name = name5
  instance11.Value = value40

  return instance11
end

local instance12 = getInstance("BoolValue", "ReachEnabled", false)
local instance13 = getInstance("NumberValue", "ReachAmount", 2)
local instance14 = getInstance("BoolValue", "VisualizeReach", false)

local reachSection = v13.Main:Section({ Name = "Reach", Side = 1 })

reachSection:Toggle({
  Name = "Enable Reach",
  Default = false,
  Flag = "EnableReach",
  Callback = function(value41) instance12.Value = value41 end,
})

reachSection:Slider({
  Name = "Reach Amount",
  Min = 1,
  Max = 10,
  Default = 2,
  Step = 0.5,
  Increment = 0.5,
  Decimals = 0.5,
  Flag = "ReachAmount",
  Suffix = "x",
  Callback = function(value42) instance13.Value = value42 end,
})

reachSection:Toggle({
  Name = "Visualize Reach",
  Default = false,
  Flag = "VisualizeReach",
  Callback = function(value43) instance14.Value = value43 end,
})

if getactors and #getactors() > 0 then
  run_on_actor(getactors()[1], [[
    local runService = game:GetService('RunService')
    local players = game:GetService('Players')

    local config = game:GetService("CoreGui"):WaitForChild("MerquryConfig")
    local cfgReach = config:WaitForChild("ReachEnabled")
    local cfgAmount = config:WaitForChild("ReachAmount")
    local cfgVis = config:WaitForChild("VisualizeReach")

    local localPlayer = players.LocalPlayer
    local originalArmSizes = {}
    local lastChar = nil

    local ARM_NAMES = {"Right Arm", "Left Arm", "RightUpperArm", "LeftUpperArm"}

    if getgenv().__rc_cn then getgenv().__rc_cn:Disconnect() end
    if getgenv().__rc_st then getgenv().__rc_st:Disconnect() end
    if getgenv().__rc_rn then getgenv().__rc_rn:Disconnect() end

    local function cleanupHitboxes(char)
        if not char then return end
        for _, child in ipairs(char:GetChildren()) do
            if child.Name:match("_VisualFake$") or child:FindFirstChild("IsHitbox") then
                child:Destroy()
            end
        end
    end

    getgenv().__rc_st = runService.Stepped:Connect(function()
        if not config or not config.Parent then
            if getgenv().__rc_st then getgenv().__rc_st:Disconnect() end
            return
        end

        local char = localPlayer.Character
        if not char then return end

        if char ~= lastChar then
            originalArmSizes = {}
            cleanupHitboxes(char)
            lastChar = char
        end

        local enabled = cfgReach.Value
        local amount = cfgAmount.Value
        local visualize = cfgVis.Value

        for _, name in ipairs(ARM_NAMES) do
            local arm = char:FindFirstChild(name)
            if arm and arm:IsA("BasePart") then
                if not originalArmSizes[name] then
                    originalArmSizes[name] = arm.Size
                end

                if enabled then
                    arm.Size = originalArmSizes[name] * amount
                    arm.Massless = true
                    arm.Transparency = visualize and 0.5 or 0
                else
                    arm.Size = originalArmSizes[name]
                    arm.Massless = false
                    arm.Transparency = 0
                end
            end
        end
    end)

    getgenv().__rc_rn = runService.RenderStepped:Connect(function()
        if not config or not config.Parent then
            if getgenv().__rc_rn then getgenv().__rc_rn:Disconnect() end
            return
        end
        if not cfgReach.Value or cfgVis.Value then return end

        local char = localPlayer.Character
        if not char then return end
        for _, name in ipairs(ARM_NAMES) do
            local arm = char:FindFirstChild(name)
            if arm and arm:IsA("BasePart") and originalArmSizes[name] then
                if arm.Size ~= originalArmSizes[name] then
                    arm.Size = originalArmSizes[name]
                end
            end
        end
    end)

]])
end

local movementSection = v13.Main:Section({ Name = "Movement", Side = 1 })

movementSection:Toggle({
  Name = "Walkspeed",
  Default = false,
  Flag = "Walkspeed",
  Callback = function(value44)
    if value44 then
      f18()
    elseif connect5 then
      connect5:Disconnect()
      connect5 = nil
    end
  end,
})

movementSection:Slider({
  Name = "Speed",
  Min = 16,
  Max = 100,
  Default = 16,
  Decimals = 0,
  Flag = "SpeedValue",
  Suffix = "s",
  Callback = function() end,
})

local ballVisualsSection = v13.Misc:Section({ Name = "Ball Visuals", Side = 1 })

ballVisualsSection:Toggle({
  Name = "Ball Trail",
  Default = false,
  Flag = "BallTracers",
  Callback = function(value45) makePart(value45) end,
}):Colorpicker({
  Default = Color3.fromRGB(170, 130, 255),
  Flag = "BallTracerColor",
  Alpha = 1,
  Callback = function(value46) makePart() end,
})

ballVisualsSection:Toggle({
  Name = "Only Dropped",
  Default = true,
  Flag = "BallTracerOnlyDropped",
  Callback = function(value47) makePart() end,
})

ballVisualsSection:Slider({
  Name = "Trail Duration",
  Min = 0.5,
  Max = 10,
  Default = 2,
  Decimals = 1,
  Flag = "BallTracerDuration",
  Suffix = "s",
  Callback = function() end,
})

ballVisualsSection:Toggle({
  Name = "Ball Chams",
  Default = false,
  Flag = "BallESP",
  Callback = function(value48) makeHighlight(value48) end,
}):Colorpicker({
  Default = Color3.fromRGB(170, 130, 255),
  Flag = "BallESPColor",
  Alpha = 1,
  Callback = function(value49) makeHighlight() end,
})

ballVisualsSection:Toggle({
  Name = "Only Dropped",
  Default = true,
  Flag = "BallChamsOnlyDropped",
  Callback = function(value50) makeHighlight() end,
})

v13.Misc:Section({ Name = "Ranked Bypass", Side = 1 }):Button({
  Name = "Join Ranked",
  Callback = function()
    pcall(function()
      replicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("PlayerService"):WaitForChild("RE"):WaitForChild("Teleport"):FireServer("Ranked")
    end)
  end,
})

local ambientSection = v13.Misc:Section({ Name = "Ambient", Side = 2 })

ambientSection:Toggle({
  Name = "Ambient",
  Default = false,
  Flag = "AmbientEnabled",
  Callback = function(value51) makePart2(value51) end,
}):Colorpicker({
  Default = Color3.fromRGB(170, 130, 255),
  Flag = "AmbientColor",
  Alpha = 1,
  Callback = function(value52) makePart2() end,
})

ambientSection:Dropdown({
  Name = "Mode",
  Items = { "V1", "V2" },
  Default = 2,
  MaxSize = 3,
  Flag = "AmbientMode",
  Multi = false,
  Callback = function(value53) makePart2() end,
})

local nameSection = v13.Misc:Section({ Name = "Name", Side = 2 })

nameSection:Toggle({
  Name = "Spoof",
  Default = false,
  Flag = "EnableSpoofName",
  Callback = function(value54) f24(value54) end,
})

nameSection:Input({
  Name = "Username",
  Default = "Merquryhub",
  Placeholder = "Merquryhub",
  Flag = "FakeUsername",
  Callback = function(value55)
    local nsU3 = value55 and value55 ~= "" and value55 or "Merquryhub"
    getgenv().__ns_u = nsU3
  end,
})

nameSection:Input({
  Name = "Display Name",
  Default = "Merqury",
  Placeholder = "Merqury",
  Flag = "FakeDisplayName",
  Callback = function(value56)
    local nsD3 = value56 and value56 ~= "" and value56 or "Merqury"
    getgenv().__ns_d = nsD3
  end,
})

local menuSection = v13["UI Settings"]:Section({ Name = "Menu", Side = 1 })

menuSection:Label("Menu Keybind"):Keybind({
  Default = "RightControl",
  Flag = "MenuKeybind",
  Mode = "Toggle",
  Callback = function(value57) v6:Toggle() end,
})

menuSection:Toggle({
  Name = "Keybind List",
  Default = false,
  Flag = "KeybindMenuOpen",
  Callback = function(value58)
    if v6.KeybindFrame then
      v6.KeybindFrame.Visible = value58
    end
  end,
})

menuSection:Button({
  Name = "Unload",
  Callback = function()
    f9()
    f6()
    f13()

    if connect5 then
      connect5:Disconnect()
      connect5 = nil
    end

    if connect6 then
      connect6:Disconnect()
      connect6 = nil
    end

    if connect7 then
      connect7:Disconnect()
      connect7 = nil
    end

    if list4 then
      if typeof(list4) == "thread" then
        pcall(task.cancel, list4)
      else
        pcall(function() list4:Disconnect() end)
      end

      list4 = nil
    end

    f7()

    for _, value59 in pairs(map or {}) do
      pcall(function()
        if value59.Trail then
          value59.Trail:Destroy()
        end

        if value59.TracerPart then
          value59.TracerPart:Destroy()
        end

        if value59.AttBall then
          value59.AttBall:Destroy()
        end
      end)
    end

    for _, value60 in pairs(map2 or {}) do
      pcall(function() value60:Destroy() end)
    end

    v6:Unload()
  end,
})

if getgenv().SaveManager then
  local saveManager = getgenv().SaveManager
  saveManager:SetLibrary(v6)
  saveManager:IgnoreThemeSettings()
  saveManager:SetIgnoreIndexes({ "KeybindMenuOpen" })
  saveManager:SetFolder("MerquryHub/BasketBallLegends")
  saveManager:BuildConfigSection(v13["UI Settings"])
  saveManager:LoadAutoloadConfig()

  task.delay(0.2, function()
    if v6 and v6.Flags then
      for key4, value61 in pairs(v6.Flags) do
        if not v9[key4] then
          v9[key4] = {
            Value = f5(value61),
            SetValue = function(_, p18)
              local v67 = v6.Flags[key4]

              if type(v67) == "table" and v67.SetValue then
                pcall(function() v67:SetValue(p18) end)
              else
                v6.Flags[key4] = p18
              end
            end,
            OnChanged = function(value62, p19) end,
          }

          v7[key4] = v9[key4]
          v8[key4] = v9[key4]
        else
          v9[key4].Value = f5(value61)
        end
      end
    end

    local function f30(key5)
      local v68 = v6.Flags[key5]

      if type(v68) == "table" and v68.Value ~= nil then
        return v68.Value
      end

      if type(v68) == "boolean" then
        return v68
      end

      return false
    end

    if f30("BallTracers") then
      makePart(true)
    end

    if f30("BallESP") then
      makeHighlight(true)
    end

    if f30("AmbientEnabled") then
      makePart2(true)
    end

    if f30("EnableSpoofName") then
      f24(true)
    end

    if f30("AutoGuard") then
      makeBodyGyro()
    end

    if f30("BallRage") then
      f17()
    end

    if f30("BallMagnet") then
      f11()
    end
  end)
end
