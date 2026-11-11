-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf

local rbxAnalyticsService = game:GetService("RbxAnalyticsService")
local httpService = game:GetService("HttpService")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local virtualUser = game:GetService("VirtualUser")
local textChatService = game:GetService("TextChatService")
local coreGui = game:GetService("CoreGui")
local userInputService = game:GetService("UserInputService")

local function f1()
  local ok, hwid = pcall(gethwid)

  if ok and hwid and hwid ~= "" then
    return hwid
  end

  return tostring(rbxAnalyticsService:GetClientId()):gsub("-", "")
end

local function f2()
  local function getRequest()
    return fluxus and fluxus.request
  end

  local function getRequest2()
    return (getgenv or function() return {} end)().request
  end

  local function getHttpRequest()
    return http_request
  end

  local function getRequest3()
    return request
  end

  local function getRequest4()
    return syn and syn.request
  end

  for _, value in ipairs({
    getRequest3, getHttpRequest, function() return http and http.request end, getRequest4,
    getRequest, getRequest2,
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
    task.wait(1)
  end

  localPlayer:Kick("Error S4")
  return false
end

if not f3() then
  return
end

local ok6, v4 = pcall(identifyexecutor)

if ok6 and v4 and string.lower(v4):find("velocity") then
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

pcall(function()
  local localPlayer2 = players.LocalPlayer
  sethiddenproperty(localPlayer2, "SimulationRadius", math.huge)
  local rawmetatable = getrawmetatable(game)
  local namecall = rawmetatable.__namecall
  setreadonly(rawmetatable, false)

  getgenv().isAttacking = false
  getgenv().attackTask = nil

  rawmetatable.__namecall = newcclosure(function(p1, ...)
    local namecallmethod = getnamecallmethod()

    if namecallmethod == "Kick" or namecallmethod == "kick" then
      return
    end

    local v5, shoot

    if namecallmethod == "FireServer" or namecallmethod == "InvokeServer" then
      local ok7, result3 = pcall(function() return (p1.Name or ""):lower() end)

      if ok7 and result3 then
        if result3:find("position") or result3:find("check") or result3:find("anticheat")
          or result3:find("sanity") then
          if namecallmethod == "InvokeServer" then
            return
          end

          return
        end

        if getgenv().InvisActive
          and (result3:find("stab") or result3:find("throw") or result3:find("shoot")
            or result3:find("fire") or result3:find("slash")) then
          getgenv().isAttacking = true

          if getgenv().attackTask then
            task.cancel(getgenv().attackTask)
          end

          local genv = getgenv()
          genv.attackTask = task.delay(0.1, function() getgenv().isAttacking = false end)

          local shoot2 = (result3:find("shoot") or result3:find("fire")) and 0.05 or 0.05

          if namecallmethod == "FireServer" then
            v5 = { ... }
            shoot = result3:find("shoot") or result3:find("fire")

            task.delay(shoot2, function()
              pcall(function()
                if shoot and getgenv().lastRealCFrame then
                  local position = getgenv().lastRealCFrame.Position
                  local vector = Vector3.new(0, 300, 0)
                  local v6 = position + vector

                  for i = 1, #v5 do
                    if typeof(v5[i]) == "Vector3" then
                      if (v5[i] - v6).Magnitude < 30 then
                        v5[i] = v5[i] - vector
                      end
                    elseif typeof(v5[i]) == "CFrame" then
                      if (v5[i].Position - v6).Magnitude < 30 then
                        v5[i] = v5[i] - vector
                      end
                    end
                  end
                end

                p1:FireServer(unpack(v5))
              end)
            end)

            return
          end

          task.wait(shoot2)
        end
      end
    end

    return namecall(p1, ...)
  end)

  setreadonly(rawmetatable, true)

  task.spawn(function()
    local v7

    repeat
      pcall(function()
        local waitForChild = localPlayer2:WaitForChild("PlayerScripts", 5)
        local waitForChild2 = waitForChild and waitForChild:WaitForChild("Modules", 5)
        local waitForChild3 = waitForChild2 and waitForChild2:WaitForChild("ItemTypes", 5)
        local waitForChild4 = waitForChild3 and waitForChild3:WaitForChild("Gun", 5)

        if waitForChild4 then
          v7 = require(waitForChild4)
        end
      end)

      if not v7 then
        task.wait(1)
      end
    until v7

    local startShooting = v7.StartShooting

    if startShooting then
      function v7.StartShooting(p2, ...)
        if getgenv().InvisActive then
          getgenv().isAttacking = true

          if getgenv().attackTask then
            task.cancel(getgenv().attackTask)
          end

          getgenv().attackTask = task.delay(0.1, function() getgenv().isAttacking = false end)
        end

        return startShooting(p2, ...)
      end
    end
  end)
end)

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()
local saveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/SaveManager.lua"))()
local options = library.Options
local toggles = library.Toggles

local merquryhubWindow = library:CreateWindow({
  Title = "Merquryhub",
  Footer = "MM2 v1",
  NotifySide = "Right",
  Font = Font.fromEnum(Enum.Font.Gotham),
  Resizable = true,
  ShowCustomCursor = false,
  AutoShow = true,
})

local v8 = {
  Main = merquryhubWindow:AddTab("Main", "house"),
  Visuals = merquryhubWindow:AddTab("Visuals", "eye"),
  Roles = merquryhubWindow:AddTab("Roles", "user"),
  Misc = merquryhubWindow:AddTab("Misc", "list"),
  Settings = merquryhubWindow:AddTab("UI Settings", "settings"),
}

local localPlayer3 = players.LocalPlayer
local instance
local humanoidRootPart

local function f4(character)
  instance = character
  humanoidRootPart = character:WaitForChild("HumanoidRootPart")

  task.spawn(function()
    task.wait(1)

    if instance == character and getgenv().wantsInvis and getgenv().enableInvis then
      getgenv().disableInvis()
      task.wait(0.1)
      getgenv().enableInvis()
    end
  end)
end

if localPlayer3.Character then
  f4(localPlayer3.Character)
else
  localPlayer3.CharacterAdded:Wait()
  f4(localPlayer3.Character)
end

localPlayer3.CharacterAdded:Connect(f4)
local connect
local connect2
local connect3
local v9

localPlayer3.Idled:Connect(function()
  if toggles.AntiAFK and toggles.AntiAFK.Value then
    virtualUser:CaptureController()
    virtualUser:ClickButton2(Vector2.new())
  end
end)

local map = {}
local v10 = {}

local function f5(invokeServer)
  v10 = {}

  if not invokeServer then
    return
  end

  for key, value2 in pairs(invokeServer) do
    if type(value2) == "table" then
      local name = value2.Name or type(key) == "string" and key or nil
      local role = value2.Role

      if name and role then
        v10[name] = role
      end
    elseif type(key) == "string" and type(value2) == "string" then
      v10[key] = value2
    end
  end
end

local v11
local v12

local function getGunDrop()
  for _, value3 in ipairs(workspace:GetChildren()) do
    local gunDrop = value3:FindFirstChild("GunDrop")

    if gunDrop then
      return gunDrop
    end
  end
end

local f6

local function f7(p3)
  local name2, name3

  for _, value4 in ipairs(players:GetPlayers()) do
    local v13 = f6(value4)

    if v13 == "Murderer" then
      name2 = value4.Name
    end

    if v13 == "Sheriff" then
      name3 = value4.Name
    end
  end

  if not name2 and not name3 then
    v11 = nil
    v12 = nil
    return
  end

  if not p3 and name2 == v11 and name3 == v12 then
    return
  end

  v11 = name2
  local list = {}
  v12 = name3

  if name2 then
    table.insert(list, "Murderer " .. name2)
  end

  if name3 then
    table.insert(list, "Sheriff " .. name3)
  end

  if #list == 0 then
    return
  end

  local joined = table.concat(list, "   ")

  if toggles.NotifyRoles and toggles.NotifyRoles.Value then
    library:Notify(joined, 8)
  end

  if toggles.ExposeRoles and toggles.ExposeRoles.Value then
    task.spawn(function()
      pcall(function()
        local rbxGeneral = textChatService.TextChannels:FindFirstChild("RBXGeneral")

        if rbxGeneral then
          rbxGeneral:SendAsync(joined)
        end
      end)

      pcall(function()
        replicatedStorage:WaitForChild("DefaultChatSystemChatEvents", 2):WaitForChild(
          "SayMessageRequest", 2
        ):FireServer(
          joined, "All"
        )
      end)
    end)
  end
end

function f6(key2)
  if map[key2] == "Murderer" or map[key2] == "Sheriff" then
    return map[key2]
  elseif v10[key2.Name] == "Murderer" then
    if key2.Character then
      local humanoid = key2.Character:FindFirstChild("Humanoid")

      if humanoid and humanoid.Health <= 0 then
        return "Innocent"
      end
    end

    return "Murderer"
  elseif v10[key2.Name] == "Sheriff" then
    if key2.Character then
      local humanoid2 = key2.Character:FindFirstChild("Humanoid")

      if humanoid2 and humanoid2.Health <= 0 then
        return "Innocent"
      end
    end

    if getGunDrop() then
      return "Innocent"
    end

    for key3, value5 in pairs(map) do
      if key3 ~= key2 and value5 == "Sheriff" then
        return "Innocent"
      end
    end

    return "Sheriff"
  end

  return "Innocent"
end

local function f8(key4)
  if key4 == localPlayer3 then
    return
  end

  local backpack = key4:FindFirstChild("Backpack")
  local character2 = key4.Character

  if backpack and backpack:FindFirstChild("Knife")
    or character2 and character2:FindFirstChild("Knife") then
    map[key4] = "Murderer"
  elseif backpack and backpack:FindFirstChild("Gun")
    or character2 and character2:FindFirstChild("Gun") then
    local humanoid3 = character2 and character2:FindFirstChildWhichIsA("Humanoid")

    if humanoid3 and humanoid3.Health > 0 then
      map[key4] = "Sheriff"
    else
      map[key4] = "Innocent"
    end
  else
    map[key4] = "Innocent"
  end

  task.defer(function()
    if f7 then
      f7()
    end
  end)
end

pcall(function()
  f5(replicatedStorage:WaitForChild("Remotes", 5):WaitForChild(
    "Gameplay", 5
  ):WaitForChild(
    "GetCurrentPlayerData", 5
  ):InvokeServer())

  replicatedStorage.Remotes.Gameplay.PlayerDataChanged.OnClientEvent:Connect(function(p4)
    f5(p4)
    f7()
  end)
end)

local function f9(p5)
  if next(v10) ~= nil then
    return v10[p5.Name] ~= nil
  end

  if not p5.Character then
    return false
  end

  local alive = p5.Character:GetAttribute("Alive")

  if alive ~= nil then
    return alive == true
  end

  local humanoid4 = p5.Character:FindFirstChildWhichIsA("Humanoid")
  return humanoid4 ~= nil and humanoid4.Health > 0
end

local function f10(instance2)
  if instance2 == localPlayer3 then
    return
  end

  f8(instance2)
  local backpack2 = instance2:FindFirstChild("Backpack")

  if backpack2 then
    backpack2.ChildAdded:Connect(function() f8(instance2) end)
    backpack2.ChildRemoved:Connect(function() f8(instance2) end)
  end

  instance2.CharacterAdded:Connect(function(character3)
    task.wait(0.05)
    f8(instance2)

    character3.ChildAdded:Connect(function() f8(instance2) end)
    character3.ChildRemoved:Connect(function() f8(instance2) end)

    local waitForChild5 = character3:WaitForChild("Humanoid", 3)

    if waitForChild5 then
      waitForChild5.Died:Connect(function() f8(instance2) end)
    end
  end)

  if instance2.Character then
    instance2.Character.ChildAdded:Connect(function() f8(instance2) end)
    instance2.Character.ChildRemoved:Connect(function() f8(instance2) end)

    local humanoid5 = instance2.Character:FindFirstChildWhichIsA("Humanoid")

    if humanoid5 then
      humanoid5.Died:Connect(function() f8(instance2) end)
    end
  end
end

for _, value6 in ipairs(players:GetPlayers()) do
  f10(value6)
end

players.PlayerAdded:Connect(f10)

players.PlayerRemoving:Connect(function(player)
  map[player] = nil
  v10[player.Name] = nil
end)

local function f11()
  local ok8, result4 = pcall(function()
    local coin = localPlayer3.PlayerGui.MainGUI.Game.CoinBags.Container.Coin
    return coin.Visible and coin.Full.Visible
  end)

  return ok8 and result4 == true
end

local function getMainCoin(instance3)
  local coinVisual = instance3:FindFirstChild("CoinVisual")
  return coinVisual and coinVisual:FindFirstChild("MainCoin")
end

local instance4

local function f12()
  if instance4 and instance4.Parent then
    return instance4
  end

  for _, value7 in ipairs(workspace:GetChildren()) do
    local coinContainer = value7:FindFirstChild("CoinContainer")

    if coinContainer then
      instance4 = coinContainer
      return coinContainer
    end
  end
end

local function f13()
  local ok9, result5 = pcall(function()
    local coin2 = localPlayer3.PlayerGui.MainGUI.Game.CoinBags.Container.Coin
    return coin2.Visible and not coin2.Full.Visible
  end)

  return ok9 and result5 == true
end

local function f14(p6)
  local wantsInvis = getgenv().wantsInvis

  if wantsInvis and getgenv().disableInvis then
    getgenv().disableInvis()
  end

  task.wait(0.1)

  if wantsInvis and getgenv().enableInvis then
    task.delay(0.2, function() getgenv().enableInvis() end)
  end
end

local function f15()
  local instance5 = f12()

  if not instance5 or not humanoidRootPart then
    return
  end

  local huge = math.huge
  local v14

  for _, value8 in ipairs(instance5:GetChildren()) do
    local mainCoin = getMainCoin(value8)

    if mainCoin and mainCoin.Transparency == 0 then
      local magnitude = (humanoidRootPart.Position - value8.Position).Magnitude

      if magnitude < huge then
        huge = magnitude
        v14 = value8
      end
    end
  end

  return v14
end

local function f16()
  if not instance then
    return false
  end

  local knife = instance:FindFirstChild("Knife")
    or localPlayer3.Backpack and localPlayer3.Backpack:FindFirstChild("Knife")

  if not knife then
    return false
  end

  if knife.Parent ~= instance then
    local humanoid6 = instance:FindFirstChildWhichIsA("Humanoid")

    if humanoid6 then
      humanoid6:EquipTool(knife)
    end

    task.wait(0.4)
  end

  return true
end

local function getRemoteEvent()
  if not instance then
    return nil, nil
  end

  local knife2 = instance:FindFirstChild("Knife")
    or localPlayer3.Backpack and localPlayer3.Backpack:FindFirstChild("Knife")

  if not knife2 then
    return nil, nil
  end

  local events = knife2:FindFirstChild("Events")

  if not events then
    return nil, nil
  end

  local v15
  local remoteEvent

  for _, value9 in ipairs(events:GetChildren()) do
    if value9:IsA("RemoteEvent") then
      local lower = value9.Name:lower()

      if lower:find("stab") then
        remoteEvent = value9
      elseif lower:find("touch") then
        v15 = value9
      end
    end
  end

  if not remoteEvent then
    remoteEvent = events:FindFirstChildWhichIsA("RemoteEvent")
  end

  return remoteEvent, v15
end

local v16 = 0.1

task.spawn(function()
  while true do
    runService.Heartbeat:Wait()

    if toggles.TouchFling and toggles.TouchFling.Value and humanoidRootPart
      and humanoidRootPart.Parent then
      local velocity = humanoidRootPart.Velocity
      local value10 = options.TouchFlingPower and options.TouchFlingPower.Value or 1000000

      humanoidRootPart.AssemblyLinearVelocity = Vector3.new(1000000, 1000000, 1000000)
      humanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, value10, 0)

      runService.RenderStepped:Wait()

      if humanoidRootPart then
        humanoidRootPart.AssemblyLinearVelocity = velocity
        humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
      end

      runService.Stepped:Wait()

      if humanoidRootPart then
        humanoidRootPart.AssemblyLinearVelocity = velocity + Vector3.new(0, v16, 0)
        v16 = -v16
      end
    end
  end
end)

local function f17(findFirstChild, p7)
  getgenv().isFlinging = true

  if not instance or not humanoidRootPart then
    getgenv().isFlinging = false
    return
  end

  if not findFirstChild or not findFirstChild.Character
    or not findFirstChild.Character:FindFirstChild("HumanoidRootPart") then
    getgenv().isFlinging = false
    return
  end

  local lastRealCFrame = getgenv().lastRealCFrame or humanoidRootPart.CFrame
  local humanoid7 = instance:FindFirstChildOfClass("Humanoid")

  if humanoid7 then
    humanoid7.PlatformStand = true
  end

  local value11 = toggles.TouchFling.Value

  if not value11 then
    toggles.TouchFling:SetValue(true)
  end

  local connect4 = runService.Stepped:Connect(function()
    local character4 = findFirstChild.Character
    local humanoidRootPart2 = character4 and character4:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart2 or not humanoidRootPart2.Parent then
      return
    end

    humanoidRootPart.CFrame = humanoidRootPart2.CFrame
  end)

  local v17 = tick() + 5
  tick()

  repeat
    if p7 and p7() then
      break
    end

    local character5 = findFirstChild.Character

    if not character5 or not character5:FindFirstChild("HumanoidRootPart") then
      break
    end

    if character5.HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 200 then
      break
    end

    task.wait(0.05)
  until tick() > v17

  connect4:Disconnect()

  if not value11 then
    toggles.TouchFling:SetValue(false)
  end

  if humanoidRootPart then
    humanoidRootPart.Anchored = true
    task.wait(0.1)

    humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
    humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
    humanoidRootPart.Velocity = Vector3.zero
    humanoidRootPart.RotVelocity = Vector3.zero
    humanoidRootPart.CFrame = lastRealCFrame

    task.wait(0.1)
    humanoidRootPart.Anchored = false
  end

  if humanoid7 then
    humanoid7.PlatformStand = false
  end

  getgenv().isFlinging = false
end

local autoFarm = v8.Main:AddLeftGroupbox("Auto Farm")

autoFarm:AddToggle("AutoFarm", { Text = "Auto Farm", Default = false }):AddKeyPicker("AutoFarmKeybind", {
  Default = "None",
  Mode = "Toggle",
  Text = "Toggle Farm",
  Callback = function(value12) toggles.AutoFarm:SetValue(value12) end,
})

autoFarm:AddToggle("ResetOnFull", { Text = "Reset on Bag Full", Default = true })
autoFarm:AddToggle("FlingMurdOnFull", { Text = "Fling Murderer When Full", Default = false })

autoFarm:AddSlider("TweenSpeed", {
  Text = "Farm Speed",
  Default = 30,
  Min = 5,
  Max = 30,
  Rounding = 0,
  Compact = false,
  HideMax = true,
  Suffix = "",
})

local invisibility = v8.Main:AddRightGroupbox("Invisibility")
local connect5
local map2 = {}

local addToggle = invisibility:AddToggle("Invisible", { Text = "Invisible", Default = false })

addToggle:AddKeyPicker("InvisibleKeybind", {
  Default = "None",
  Text = "Toggle Invis",
  Mode = "Toggle",
})

getgenv().enableInvis = function()
  getgenv().InvisActive = true
  getgenv().invisChar = instance

  library:Notify("Invisible turned ON", 3)

  if toggles.InvisTrans and toggles.InvisTrans.Value and instance then
    map2 = {}

    for _, value13 in ipairs(instance:GetDescendants()) do
      if value13:IsA("BasePart") and value13.Name ~= "HumanoidRootPart" then
        map2[value13] = value13.Transparency
        value13.Transparency = 0.5
      end
    end
  end

  if connect5 then
    connect5:Disconnect()
  end

  connect5 = runService.Heartbeat:Connect(function()
    if not instance or instance ~= getgenv().invisChar then
      return
    end

    local humanoidRootPart3 = instance:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart3 then
      return
    end

    local cframe = humanoidRootPart3.CFrame
    getgenv().lastRealCFrame = cframe
    local velocity2 = humanoidRootPart3.Velocity
    local rotVelocity = humanoidRootPart3.RotVelocity

    if not getgenv().isAttacking and not getgenv().isFlinging then
      humanoidRootPart3.CFrame = cframe + Vector3.new(0, 300, 0)

      runService:BindToRenderStep("InvisRestore", 101, function()
        if humanoidRootPart3 then
          humanoidRootPart3.CFrame = cframe
          humanoidRootPart3.Velocity = velocity2
          humanoidRootPart3.RotVelocity = rotVelocity
        end

        runService:UnbindFromRenderStep("InvisRestore")
      end)
    end
  end)
end

getgenv().disableInvis = function()
  getgenv().InvisActive = false
  library:Notify("Invisible turned OFF", 3)

  if connect5 then
    connect5:Disconnect()
    connect5 = nil
  end

  pcall(function() runService:UnbindFromRenderStep("InvisRestore") end)
  local humanoidRootPart4 = instance and instance:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart4 and getgenv().lastRealCFrame and instance == getgenv().invisChar then
    humanoidRootPart4.CFrame = getgenv().lastRealCFrame
  end

  for key5, value14 in pairs(map2) do
    if key5 and key5.Parent then
      key5.Transparency = value14
    end
  end

  map2 = {}
end

addToggle:OnChanged(function(wantsInvis2)
  getgenv().wantsInvis = wantsInvis2

  if wantsInvis2 then
    getgenv().enableInvis()
  else
    getgenv().disableInvis()
  end
end)

invisibility:AddToggle("InvisTrans", {
  Text = "Transparent when Invis",
  Default = true,
}):OnChanged(function(p8)
  if toggles.Invisible and toggles.Invisible.Value and instance then
    if p8 then
      map2 = {}

      for _, value15 in ipairs(instance:GetDescendants()) do
        if value15:IsA("BasePart") and value15.Name ~= "HumanoidRootPart" then
          map2[value15] = value15.Transparency
          value15.Transparency = 0.5
        end
      end
    else
      for key6, value16 in pairs(map2) do
        if key6 and key6.Parent then
          key6.Transparency = value16
        end
      end

      map2 = {}
    end
  end
end)

local esp = v8.Visuals:AddLeftGroupbox("ESP")
esp:AddToggle("PlayerChams", { Text = "Player Chams", Default = false })

esp:AddDropdown("PlayerChamsFilter", {
  Values = { "Innocent", "Murderer", "Sheriff" },
  Default = 1,
  Multi = true,
  Text = "Cham Roles",
})

esp:AddToggle("CoinChams", { Text = "Coin Chams", Default = false })

options.PlayerChamsFilter:SetValue({ Innocent = true, Murderer = true, Sheriff = true })

local droppedGun = v8.Visuals:AddRightGroupbox("Dropped Gun")
droppedGun:AddToggle("GunNotify", { Text = "Gun Notifier", Default = true })

droppedGun:AddToggle("GunChams", { Text = "Gun Chams", Default = true }):OnChanged(function(p9)
  if not p9 then
    clearGunChams()
  else
    local gunDrop2 = getGunDrop()

    if gunDrop2 then
      applyGunChams(gunDrop2)
    end
  end
end)

local instance6
local f18

local function makeHighlight(descendant)
  f18()

  if not (toggles.GunChams and toggles.GunChams.Value) then
    return
  end

  local cham = Instance.new("Highlight")
  cham.Name = "Cham"
  cham.Adornee = descendant
  cham.FillColor = Color3.fromRGB(50, 120, 255)
  cham.OutlineColor = Color3.fromRGB(255, 255, 255)
  cham.FillTransparency = 0.3
  cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
  cham.Parent = coreGui

  instance6 = cham
end

function f18()
  if instance6 then
    pcall(function() instance6:Destroy() end)
    instance6 = nil
  end
end

droppedGun:AddToggle("AutoGetGun", { Text = "Auto Get Gun", Default = false }):OnChanged(function(p10)
  if p10 then
    local gunDrop3 = getGunDrop()

    if gunDrop3 and humanoidRootPart then
      local function f19(instance7)
        if instance7:IsA("BasePart") then
          pcall(function()
            firetouchinterest(instance7, humanoidRootPart, 0)
            firetouchinterest(instance7, humanoidRootPart, 1)
          end)
        end

        for _, value17 in ipairs(instance7:GetDescendants()) do
          if value17:IsA("BasePart") then
            pcall(function()
              firetouchinterest(value17, humanoidRootPart, 0)
              firetouchinterest(value17, humanoidRootPart, 1)
            end)
          end
        end
      end

      f19(gunDrop3)
    end
  end
end)

droppedGun:AddButton({
  Text = "Get Gun",
  Func = function()
    local gunDrop4 = getGunDrop()

    if gunDrop4 and humanoidRootPart then
      local function f20(instance8)
        if instance8:IsA("BasePart") then
          pcall(function()
            firetouchinterest(instance8, humanoidRootPart, 0)
            firetouchinterest(instance8, humanoidRootPart, 1)
          end)
        end

        for _, value18 in ipairs(instance8:GetDescendants()) do
          if value18:IsA("BasePart") then
            pcall(function()
              firetouchinterest(value18, humanoidRootPart, 0)
              firetouchinterest(value18, humanoidRootPart, 1)
            end)
          end
        end
      end

      f20(gunDrop4)
      library:Notify("Picked up gun!", 2)
    else
      library:Notify("No dropped gun found", 3)
    end
  end,
})

droppedGun:AddButton({
  Text = "Teleport to gun",
  Func = function()
    local gunDrop5 = getGunDrop()

    if gunDrop5 and humanoidRootPart then
      humanoidRootPart.CFrame = gunDrop5.CFrame * CFrame.new(0, 3, 0)
      library:Notify("Teleported to gun", 2)
    else
      library:Notify("No dropped gun found", 3)
    end
  end,
})

workspace.DescendantAdded:Connect(function(descendant2)
  if descendant2.Name == "GunDrop" and descendant2:IsA("BasePart") then
    if toggles.GunNotify and toggles.GunNotify.Value then
      library:Notify("Gun dropped!", 5)
    end

    makeHighlight(descendant2)

    if toggles.AutoGetGun and toggles.AutoGetGun.Value and humanoidRootPart then
      task.spawn(function()
        task.wait(0.15)

        local function f21(descendant3)
          if descendant3:IsA("BasePart") then
            pcall(function()
              firetouchinterest(descendant3, humanoidRootPart, 0)
              firetouchinterest(descendant3, humanoidRootPart, 1)
            end)
          end

          for _, value19 in ipairs(descendant3:GetDescendants()) do
            if value19:IsA("BasePart") then
              pcall(function()
                firetouchinterest(value19, humanoidRootPart, 0)
                firetouchinterest(value19, humanoidRootPart, 1)
              end)
            end
          end
        end

        f21(descendant2)
      end)
    end

    descendant2.AncestryChanged:Connect(function()
      if not descendant2:IsDescendantOf(workspace) then
        f18()
      end
    end)
  end
end)

local murderer = v8.Roles:AddLeftGroupbox("Murderer")
murderer:AddToggle("SilentAimMurderer", { Text = "Silent Aim", Default = false })

murderer:AddButton({
  Text = "Kill All",
  Func = function()
    f14(function()
      if not f16() then
        library:Notify("No knife found!", 4)
        return
      end

      task.wait(0.1)
      local knife3 = instance and instance:FindFirstChild("Knife")

      if knife3 then
        pcall(function()
          local bindableEvent = knife3:FindFirstChildOfClass("BindableEvent")

          if bindableEvent then
            bindableEvent:Fire()
          end
        end)
      end

      local cframe2 = humanoidRootPart and humanoidRootPart.CFrame
      local count = 0

      for _, value20 in ipairs(players:GetPlayers()) do
        if value20 ~= localPlayer3 and f9(value20) then
          local character6 = value20.Character

          if character6 then
            local humanoidRootPart5 = character6:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart5 then
              local humanoid8 = character6:FindFirstChildWhichIsA("Humanoid")

              if not (humanoid8 and humanoid8.Health <= 0) then
                local v18, v19 = getRemoteEvent()

                if v18 then
                  humanoidRootPart.CFrame = humanoidRootPart5.CFrame
                  task.wait(0.25)
                  pcall(function() v18:FireServer() end)

                  if v19 then
                    pcall(function() v19:FireServer(humanoidRootPart5) end)
                  end

                  count = count + 1
                  task.wait(0.35)
                end
              end
            end
          end
        end
      end

      if cframe2 and humanoidRootPart then
        humanoidRootPart.CFrame = cframe2
      end

      library:Notify("Killed " .. count .. " players", 3)
    end)
  end,
})

v8.Roles:AddRightGroupbox("Sheriff"):AddToggle("SilentAimSheriff", {
  Text = "Silent Aim",
  Default = false,
})

local misc = v8.Misc:AddLeftGroupbox("Misc")
misc:AddToggle("AntiAFK", { Text = "Anti afk", Default = true })
misc:AddToggle("AntiFling", { Text = "Anti Fling", Default = false })

local player2 = v8.Misc:AddRightGroupbox("Player")

player2:AddToggle("WalkSpeedTog", { Text = "WalkSpeed", Default = false }):OnChanged(function(p11)
  if not p11 and instance then
    local humanoid9 = instance:FindFirstChildWhichIsA("Humanoid")

    if humanoid9 then
      humanoid9.WalkSpeed = 16
    end
  end
end)

player2:AddSlider("WalkSpeed", {
  Text = "WalkSpeed",
  Default = 16,
  Min = 16,
  Max = 150,
  Rounding = 0,
  Compact = false,
  HideMax = true,
  Suffix = "",
})

player2:AddToggle("Fly", { Text = "Fly", Default = false })

player2:AddSlider("FlySpeed", {
  Text = "Fly Speed",
  Default = 50,
  Min = 16,
  Max = 300,
  Rounding = 0,
  Compact = false,
  HideMax = true,
  Suffix = "",
})

player2:AddToggle("Noclip", { Text = "Noclip", Default = false })

local bodyVelocity
local bodyGyro
local flag = false

runService.Stepped:Connect(function()
  if instance then
    local humanoid10 = instance:FindFirstChildWhichIsA("Humanoid")

    if humanoid10 and toggles.WalkSpeedTog and toggles.WalkSpeedTog.Value and options.WalkSpeed
      and not (toggles.Fly and toggles.Fly.Value) then
      humanoid10.WalkSpeed = options.WalkSpeed.Value
    end

    if toggles.Noclip and toggles.Noclip.Value then
      for _, value21 in ipairs(instance:GetDescendants()) do
        if value21:IsA("BasePart") and value21.CanCollide then
          value21.CanCollide = false
        end
      end
    end
  end
end)

runService.RenderStepped:Connect(function()
  if toggles.Fly and toggles.Fly.Value and instance and humanoidRootPart then
    flag = true
    local humanoid11 = instance:FindFirstChildWhichIsA("Humanoid")

    if not bodyVelocity or bodyVelocity.Parent ~= humanoidRootPart then
      if bodyVelocity then
        bodyVelocity:Destroy()
      end

      bodyVelocity = Instance.new("BodyVelocity")
      bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
      bodyVelocity.Velocity = Vector3.zero
      bodyVelocity.Parent = humanoidRootPart
    end

    if not bodyGyro or bodyGyro.Parent ~= humanoidRootPart then
      if bodyGyro then
        bodyGyro:Destroy()
      end

      bodyGyro = Instance.new("BodyGyro")
      bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
      bodyGyro.P = 10000
      bodyGyro.cframe = humanoidRootPart.CFrame
      bodyGyro.Parent = humanoidRootPart
    end

    if humanoid11 then
      humanoid11.PlatformStand = true
    end

    local currentCamera = workspace.CurrentCamera
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

    local value22 = options.FlySpeed and options.FlySpeed.Value or 50

    if zero.Magnitude > 0 then
      bodyVelocity.Velocity = zero.Unit * value22
    else
      bodyVelocity.Velocity = Vector3.zero
    end

    bodyGyro.cframe = currentCamera.CFrame
  elseif flag then
    flag = false

    if bodyVelocity then
      bodyVelocity:Destroy()
      bodyVelocity = nil
    end

    if bodyGyro then
      bodyGyro:Destroy()
      bodyGyro = nil
    end

    if instance and not getgenv().isFlinging
      and not (toggles.AutoFarm and toggles.AutoFarm.Value) then
      local humanoid12 = instance:FindFirstChildWhichIsA("Humanoid")

      if humanoid12 then
        humanoid12.PlatformStand = false
      end
    end
  end
end)

local misc2 = v8.Roles:AddLeftGroupbox("Misc")
misc2:AddToggle("ExposeRoles", { Text = "Expose Roles", Default = false })
misc2:AddToggle("NotifyRoles", { Text = "Notify Roles", Default = false })

toggles.ExposeRoles:OnChanged(function(p12)
  if p12 then
    f7(true)
  end
end)

toggles.NotifyRoles:OnChanged(function(p13)
  if p13 then
    f7(true)
  end
end)

local fling = v8.Misc:AddLeftGroupbox("Fling")
local flag2 = false
local flag3 = false

fling:AddButton({
  Text = "Fling All",
  Func = function()
    if flag2 then
      flag3 = true
      return
    end

    flag2 = true
    flag3 = false

    task.spawn(function()
      for _, value23 in ipairs(players:GetPlayers()) do
        if flag3 then
          break
        elseif value23 ~= localPlayer3 then
          f17(value23, function() return flag3 end)
        end
      end

      flag2 = false
    end)
  end,
})

fling:AddButton({
  Text = "Fling Murderer",
  Func = function()
    task.spawn(function()
      for _, value24 in ipairs(players:GetPlayers()) do
        if value24 ~= localPlayer3 and f6(value24) == "Murderer" then
          f17(value24)
          break
        end
      end
    end)
  end,
})

fling:AddButton({
  Text = "Fling Sheriff",
  Func = function()
    task.spawn(function()
      for _, value25 in ipairs(players:GetPlayers()) do
        if value25 ~= localPlayer3 and f6(value25) == "Sheriff" then
          f17(value25)
          break
        end
      end
    end)
  end,
})

local values = {}

for _, value26 in ipairs(players:GetPlayers()) do
  if value26 ~= localPlayer3 then
    table.insert(values, value26.Name)
  end
end

fling:AddDropdown("FlingPick", {
  Values = values,
  Default = 1,
  Multi = false,
  Text = "Player",
})

fling:AddButton({
  Text = "Fling Player",
  Func = function()
    task.spawn(function()
      local value27 = options.FlingPick and options.FlingPick.Value

      if value27 then
        local findFirstChild2 = players:FindFirstChild(value27)

        if findFirstChild2 then
          f17(findFirstChild2)
        end
      end
    end)
  end,
})

fling:AddDivider()
fling:AddToggle("TouchFling", { Text = "Touch Fling", Default = false })

fling:AddSlider("TouchFlingPower", {
  Text = "Fling power",
  Default = 1000000,
  Min = 5000,
  Max = 1000000,
  Rounding = 0,
  Compact = false,
  HideMax = true,
  Suffix = "",
})

task.spawn(function()
  while task.wait(3) do
    local list2 = {}

    for _, value28 in ipairs(players:GetPlayers()) do
      if value28 ~= localPlayer3 then
        table.insert(list2, value28.Name)
      end
    end

    if options.FlingPick then
      options.FlingPick:SetValues(list2)
    end
  end
end)

local misc3 = v8.Settings:AddLeftGroupbox("Misc")

misc3:AddLabel("Menu Keybind"):AddKeyPicker("MenuKeybind", {
  Default = "RightControl",
  SyncToggleVisibility = true,
  Mode = "Toggle",
  Text = "Toggle Menu",
  Callback = function() end,
})

library.ToggleKeybind = options.MenuKeybind

misc3:AddButton({
  Text = "Unload",
  Func = function()
    toggles.AutoFarm:SetValue(false)
    toggles.PlayerChams:SetValue(false)
    toggles.TouchFling:SetValue(false)

    for _, value29 in ipairs({ nil, connect3, nil, nil }) do
      if value29 then
        pcall(function() value29:Disconnect() end)
      end
    end

    if connect then
      pcall(function() connect:Disconnect() end)
    end

    if connect2 then
      pcall(function() connect2:Disconnect() end)
    end

    f18()

    if v9 then
      pcall(function() hookmetamethod(game, "__namecall", v9) end)
    end

    for _, value30 in ipairs(players:GetPlayers()) do
      if value30.Character then
        local chamHighlight = value30.Character:FindFirstChild("ChamHighlight")

        if chamHighlight then
          chamHighlight:Destroy()
        end
      end
    end

    local instance9 = f12()

    if instance9 then
      for _, value31 in ipairs(instance9:GetChildren()) do
        local coinVisual2 = value31:FindFirstChild("CoinVisual")

        if coinVisual2 then
          local coinChamHighlight = coinVisual2:FindFirstChild("CoinChamHighlight")

          if coinChamHighlight then
            coinChamHighlight:Destroy()
          end

          local coinChamBoxFolder = coinVisual2:FindFirstChild("CoinChamBoxFolder")

          if coinChamBoxFolder then
            coinChamBoxFolder:Destroy()
          end
        end
      end
    end

    library:Unload()
  end,
})

saveManager:SetLibrary(library)
saveManager:SetFolder("MM2Script")
saveManager:BuildConfigSection(v8.Settings)

local function makeHighlight2()
  local value32 = options.PlayerChamsFilter.Value

  for _, value33 in ipairs(players:GetPlayers()) do
    if value33 ~= localPlayer3 and value33.Character then
      local v20 = f6(value33)
      local chamHighlight2 = value33.Character:FindFirstChild("ChamHighlight")

      if toggles.PlayerChams.Value and value32[v20] then
        local color = v20 == "Murderer" and Color3.fromRGB(255, 50, 50)
          or v20 == "Sheriff" and Color3.fromRGB(50, 50, 255) or Color3.fromRGB(50, 255, 50)

        if not chamHighlight2 then
          chamHighlight2 = Instance.new("Highlight")
          chamHighlight2.Name = "ChamHighlight"
          chamHighlight2.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
          chamHighlight2.Parent = value33.Character
        end

        chamHighlight2.Adornee = value33.Character
        chamHighlight2.FillColor = color
        chamHighlight2.OutlineColor = Color3.fromRGB(0, 0, 0)
        chamHighlight2.FillTransparency = 0.45
        chamHighlight2.OutlineTransparency = 0
      elseif chamHighlight2 then
        chamHighlight2:Destroy()
      end
    end
  end
end

local function makeHighlight3()
  local instance10 = f12()

  if not instance10 then
    return
  end

  for _, value34 in ipairs(instance10:GetChildren()) do
    local coinVisual3 = value34:FindFirstChild("CoinVisual")

    if coinVisual3 then
      local coinChamBoxFolder2 = coinVisual3:FindFirstChild("CoinChamBoxFolder")

      if coinChamBoxFolder2 then
        coinChamBoxFolder2:Destroy()
      end
    end
  end

  if not toggles.CoinChams.Value then
    for _, value35 in ipairs(instance10:GetChildren()) do
      local coinVisual4 = value35:FindFirstChild("CoinVisual")

      if coinVisual4 then
        local coinChamHighlight2 = coinVisual4:FindFirstChild("CoinChamHighlight")

        if coinChamHighlight2 then
          coinChamHighlight2:Destroy()
        end
      end
    end

    return
  end

  local list3 = {}
  local position2 = workspace.CurrentCamera.CFrame.Position

  for _, value36 in ipairs(instance10:GetChildren()) do
    local coinVisual5 = value36:FindFirstChild("CoinVisual")

    if coinVisual5 then
      local mainCoin2 = coinVisual5:FindFirstChild("MainCoin")

      if mainCoin2 and mainCoin2.Transparency == 0 then
        table.insert(list3, {
          vis = coinVisual5,
          mc = mainCoin2,
          dist = (mainCoin2.Position - position2).Magnitude,
        })
      else
        local coinChamHighlight3 = coinVisual5:FindFirstChild("CoinChamHighlight")

        if coinChamHighlight3 then
          coinChamHighlight3:Destroy()
        end
      end
    end
  end

  table.sort(list3, function(p14, p15) return p14.dist < p15.dist end)

  for index, value37 in ipairs(list3) do
    local vis = value37.vis
    local coinChamHighlight4 = vis:FindFirstChild("CoinChamHighlight")

    if index <= 15 then
      if not coinChamHighlight4 then
        local coinChamHighlight5 = Instance.new("Highlight")
        coinChamHighlight5.Name = "CoinChamHighlight"
        coinChamHighlight5.Adornee = value37.mc
        coinChamHighlight5.FillColor = Color3.fromRGB(255, 215, 0)
        coinChamHighlight5.OutlineColor = Color3.fromRGB(0, 0, 0)
        coinChamHighlight5.FillTransparency = 0.5
        coinChamHighlight5.OutlineTransparency = 0.2
        coinChamHighlight5.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        coinChamHighlight5.Parent = vis
      end
    elseif coinChamHighlight4 then
      coinChamHighlight4:Destroy()
    end
  end
end

task.spawn(function()
  while task.wait(0.1) do
    pcall(function()
      if toggles.PlayerChams then
        if toggles.PlayerChams.Value then
          makeHighlight2()
        else
          for _, value38 in ipairs(players:GetPlayers()) do
            if value38.Character then
              local chamHighlight3 = value38.Character:FindFirstChild("ChamHighlight")

              if chamHighlight3 then
                chamHighlight3:Destroy()
              end
            end
          end
        end
      end
    end)

    pcall(function()
      if toggles.CoinChams then
        if toggles.CoinChams.Value then
          makeHighlight3()
        else
          local instance11 = f12()

          if instance11 then
            for _, value39 in ipairs(instance11:GetChildren()) do
              local coinVisual6 = value39:FindFirstChild("CoinVisual")

              if coinVisual6 then
                local coinChamHighlight6 = coinVisual6:FindFirstChild("CoinChamHighlight")
                local coinChamBoxFolder3 = coinVisual6:FindFirstChild("CoinChamBoxFolder")

                if coinChamHighlight6 then
                  coinChamHighlight6:Destroy()
                end

                if coinChamBoxFolder3 then
                  coinChamBoxFolder3:Destroy()
                end
              end
            end
          end
        end
      end
    end)
  end
end)

local count2 = 0

connect3 = runService.Stepped:Connect(function()
  if not (toggles.AntiFling and toggles.AntiFling.Value) then
    return
  end

  count2 = count2 + 1

  if count2 % 10 ~= 0 then
    return
  end

  for _, value40 in ipairs(players:GetPlayers()) do
    if value40 ~= localPlayer3 and value40.Character then
      for _, value41 in ipairs(value40.Character:GetDescendants()) do
        if value41:IsA("BasePart") and value41.CanCollide then
          value41.CanCollide = false
        end
      end
    end
  end
end)

toggles.AutoFarm:OnChanged(function(p16)
  if connect then
    connect:Disconnect()
    connect = nil
  end

  if connect2 then
    connect2:Disconnect()
    connect2 = nil
  end

  if instance then
    local humanoid13 = instance:FindFirstChildWhichIsA("Humanoid")

    if humanoid13 then
      humanoid13.PlatformStand = false
    end
  end

  if not p16 then
    return
  end

  local flag4 = false

  connect2 = runService.Stepped:Connect(function()
    if instance and flag4 then
      for _, value42 in ipairs(instance:GetDescendants()) do
        if value42:IsA("BasePart") and value42.CanCollide then
          value42.CanCollide = false
        end
      end
    end
  end)

  local cframe3 = CFrame.Angles(math.rad(-90), 0, 0)
  local flag5 = false

  connect = runService.Stepped:Connect(function(_, p17)
    if not humanoidRootPart then
      return
    end

    local humanoid14 = instance and instance:FindFirstChildWhichIsA("Humanoid")

    if f11() then
      if not flag5 then
        flag5 = true

        if toggles.FlingMurdOnFull and toggles.FlingMurdOnFull.Value then
          task.spawn(function()
            for _, value43 in ipairs(players:GetPlayers()) do
              if value43 ~= localPlayer3 and f6(value43) == "Murderer" then
                f17(value43)
                break
              end
            end
          end)
        end

        if toggles.ResetOnFull.Value then
          if humanoid14 and humanoid14.Parent and humanoid14.Health > 0 then
            humanoid14.Health = 0
          end
        end
      end

      if humanoid14 then
        humanoid14.PlatformStand = false
      end

      flag4 = false
      return
    end

    flag5 = false

    if not f13() then
      if humanoid14 then
        humanoid14.PlatformStand = false
      end

      flag4 = false
      return
    end

    flag4 = true
    local v21 = f15()

    if not v21 then
      return
    end

    if humanoid14 then
      humanoid14.PlatformStand = true
    end

    humanoidRootPart.Velocity = Vector3.zero
    humanoidRootPart.RotVelocity = Vector3.zero

    local position3 = v21.Position
    local v22 = position3.Y - 2
    local position4 = humanoidRootPart.Position
    local value44 = options.TweenSpeed.Value
    local distance = math.abs(position4.Y - v22)

    if distance > 1 then
      local unit = Vector3.new(0, v22 - position4.Y, 0).Unit

      humanoidRootPart.CFrame = CFrame.new(position4 + unit * math.min(distance, value44 * p17))
        * cframe3

      return
    end

    local magnitude2 = (Vector3.new(position4.X, 0, position4.Z)
      - Vector3.new(position3.X, 0, position3.Z)).Magnitude

    if magnitude2 > 1.5 then
      local vector2 = Vector3.new(position3.X, position4.Y, position3.Z)

      humanoidRootPart.CFrame = CFrame.new(position4
          + (vector2 - position4).Unit * math.min(magnitude2, value44 * p17))
        * cframe3

      return
    end

    if getMainCoin(v21) then
      local v23 = position3 + Vector3.new(0, 1, 0)
      local magnitude3 = (v23 - position4).Magnitude

      if magnitude3 > 0.5 then
        humanoidRootPart.CFrame = CFrame.new(position4
            + (v23 - position4).Unit * math.min(magnitude3, value44 * p17))
          * cframe3
      else
        humanoidRootPart.CFrame = CFrame.new(v23) * cframe3
      end
    end
  end)
end)

v9 = hookmetamethod(game, "__namecall", newcclosure(function(p18, ...)
  local namecallmethod2 = getnamecallmethod()

  if checkcaller() or namecallmethod2 ~= "FireServer" then
    return v9(p18, ...)
  end

  local v24 = tostring(p18)
  local v25 = v24 == "Shoot"
  local position5

  if v25 and toggles.SilentAimSheriff and toggles.SilentAimSheriff.Value then
    local v26 = { ... }
    local v27 = select("#", ...)
    local list4 = {}

    for j = 1, v27 do
      if typeof(v26[j]) == "Vector3" or typeof(v26[j]) == "CFrame" then
        table.insert(list4, j)
      end
    end
  elseif v24 == "KnifeThrown" and toggles.SilentAimMurderer
    and toggles.SilentAimMurderer.Value then
    local v28 = select("#", ...)
    local v29 = { ... }
    local list5 = {}

    for k = 1, v28 do
      if typeof(v29[k]) == "Vector3" or typeof(v29[k]) == "CFrame" then
        table.insert(list5, k)
      end
    end

    if #list5 > 0 then
      position5 = nil

      pcall(function()
        local humanoidRootPart6 = localPlayer3.Character
          and localPlayer3.Character:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart6 then
          return
        end

        local v30
        local huge2 = math.huge

        for _, value45 in ipairs(players:GetPlayers()) do
          if value45 ~= localPlayer3 and value45.Character
            and value45.Character:FindFirstChild("HumanoidRootPart")
            and f6(value45) ~= "Murderer" then
            local magnitude4 = (value45.Character.HumanoidRootPart.Position
              - humanoidRootPart6.Position).Magnitude

            if magnitude4 < huge2 then
              huge2 = magnitude4
              v30 = value45
            end
          end
        end

        if v30 then
          position5 = v30.Character.HumanoidRootPart.Position
        end
      end)

      if position5 then
        local v31 = list5[1]
        local v32 = list5[2]

        local unit2 = (position5
          - (typeof(v29[v31]) == "Vector3" and v29[v31] or v29[v31].Position)).Unit

        if v32 then
          if (typeof(v29[v32]) == "Vector3" and v29[v32] or v29[v32].Position).Magnitude > 10 then
            v29[v32] = typeof(v29[v32]) == "Vector3" and position5 or CFrame.new(position5)
          else
            v29[v32] = typeof(v29[v32]) == "Vector3" and unit2
              or CFrame.lookAt(Vector3.zero, unit2)
          end
        else
          v29[v31] = typeof(v29[v31]) == "Vector3" and position5 or CFrame.new(position5)
        end

        setnamecallmethod(namecallmethod2)
        return v9(p18, unpack(v29, 1, v28))
      end
    end
  end

  setnamecallmethod(namecallmethod2)
  return v9(p18, ...)
end))
