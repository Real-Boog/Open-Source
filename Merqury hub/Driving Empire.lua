-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf

local httpService = game:GetService("HttpService")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local teams = game:GetService("Teams")
local rbxAnalyticsService = game:GetService("RbxAnalyticsService")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local virtualUser = game:GetService("VirtualUser")
local userInputService = game:GetService("UserInputService")
local marketplaceService = game:GetService("MarketplaceService")
local windUI

do
  local function f1()
    local function getHttpRequest()
      return http_request
    end

    local function getRequest()
      return request
    end

    local function getRequest2()
      return (getgenv or function() return {} end)().request
    end

    local function getRequest3()
      return fluxus and fluxus.request
    end

    local function getRequest4()
      return syn and syn.request
    end

    for _, value in ipairs({
      getRequest, getHttpRequest, function() return http and http.request end, getRequest4,
      getRequest3, getRequest2,
    }) do
      local ok, result = pcall(value)

      if ok and type(result) == "function" then
        return result
      end
    end

    return nil
  end

  local function f2()
    local ok2, hwid = pcall(gethwid)

    if ok2 and hwid and hwid ~= "" then
      return hwid
    end

    return tostring(rbxAnalyticsService:GetClientId()):gsub("-", "")
  end

  local localPlayer = players.LocalPlayer

  local function f3()
    local ok3, v1 = pcall(readfile, "MerquryHub_Key.txt")

    if not ok3 or not v1 or v1 == "" then
      localPlayer:Kick("Error S1")
      return false
    end

    local gsub = tostring(v1):gsub("^[%s\n\r\t]+", ""):gsub("[%s\n\r\t]+$", "")
    local v2 = f1()

    if not v2 then
      localPlayer:Kick("Error S2")
      return false
    end

    local _, body = pcall(httpService.JSONEncode, httpService, {
      key_string = gsub,
      hwid = f2(),
    })

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

  task.spawn(function()
    pcall(function()
      pcall(function()
        local map = require(replicatedStorage:WaitForChild("Modules"):WaitForChild("Shared"):WaitForChild("Logger"))

        if map then
          for key, value2 in pairs(map) do
            if type(value2) == "function" and key ~= "setLevel" then
              map[key] = function() end
            end
          end
        end
      end)

      pcall(function()
        local frameworkLogging = replicatedStorage:WaitForChild("Modules"):WaitForChild("Shared"):WaitForChild("Framework"):FindFirstChild("FrameworkLogging")

        if frameworkLogging then
          local map2 = require(frameworkLogging)

          if map2 then
            for key2, value3 in pairs(map2) do
              if type(value3) == "function" then
                map2[key2] = function() end
              end
            end
          end
        end
      end)

      pcall(function()
        local httpServiceWrapper = replicatedStorage:WaitForChild("Modules"):WaitForChild("Shared"):WaitForChild("Wrappers"):FindFirstChild("HTTPServiceWrapper")

        if httpServiceWrapper then
          local v4 = require(httpServiceWrapper)

          if v4 then
            function v4.generateReport()
              return ""
            end

            function v4.getRecords()
              return {}
            end
          end
        end
      end)

      pcall(function()
        local v5 = replicatedStorage:FindFirstChild("Modules")
          and replicatedStorage.Modules:FindFirstChild("Shared")

        local serverLog = v5 and v5:FindFirstChild("ServerLog")

        if serverLog then
          local client = serverLog:FindFirstChild("Client")

          if client then
            local ok6, v6 = pcall(require, client)

            if ok6 and v6 then
              function v6._Init()
              end

              function v6.Log()
              end
            end
          end
        end
      end)

      local v7 = {
        LogEvent = true,
        ClientLog = true,
        ServerLog = true,
        ClientFrameworkBootOutputLogs = true,
      }

      local v8

      if getgenv().hookmetamethod then
        v8 = nil

        v8 = hookmetamethod(game, "__namecall", function(p1, ...)
          local namecallmethod = getnamecallmethod()

          if v7[p1.Name]
            and (namecallmethod == "FireServer" or namecallmethod == "InvokeServer") then
            return
          end

          return v8(p1, ...)
        end)
      end
    end)
  end)

  windUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
end

local window = windUI:CreateWindow({
  Title = "Merquryhub - Driving Empire v1.6",
  Icon = "crown",
  Author = "by Merquryhub on discord",
  Folder = "Merquryhub/Driving Empire",
  Size = UDim2.fromOffset(580, 460),
  MinSize = Vector2.new(560, 350),
  MaxSize = Vector2.new(850, 560),
  ToggleKey = Enum.KeyCode.RightShift,
  Transparent = true,
  Theme = "Dark",
  Resizable = true,
  SideBarWidth = 200,
  BackgroundImageTransparency = 0.42,
  HideSearchBar = false,
  ScrollBarEnabled = true,
  User = { Enabled = true, Anonymous = false, Callback = function() end },
})

local v9, v10, v11, name

do
  v9 = players
  v10 = runService
  v11 = tweenService
  name = "Security"

  for _, value4 in ipairs(teams:GetTeams()) do
    if value4.Name:find("Security") then
      name = value4.Name
      break
    end
  end

  local v12 = replicatedStorage:WaitForChild("Modules"):WaitForChild("Shared")

  require(v12:WaitForChild("Remotes"))
  require(v12:WaitForChild("Jobs"):WaitForChild("JobsConstants"))
end

local localPlayer2 = v9.LocalPlayer
local remotes = replicatedStorage:WaitForChild("Remotes")
local requestStartJobSession = remotes:WaitForChild("RequestStartJobSession")
local attemptATMBustStart = remotes:WaitForChild("AttemptATMBustStart")
local attemptATMBustComplete = remotes:WaitForChild("AttemptATMBustComplete")
local attemptCriminalJobComplete = remotes:WaitForChild("AttemptCriminalJobComplete")
local tryPurchaseProductYield = remotes:WaitForChild("TryPurchaseProductYield")
local autoArrest = false
local v13 = false
local autoRob = false
local avoidSecurity = false
local autoCashout = false
local cashoutAmount = 300000
local avoidMethod = "Cashout"
local v14 = { true, true, false }
local map3 = {}
local flag = false
local flag2 = false
local seen = {}
local v15 = false
local v16 = 300
local v17 = 0

local seen2 = {
  Big = true,
  Medium = true,
  Small = false,
  Random = false,
}

local v18 = false
local autoDelivery = false
local dropoffDelay = 5
local moveMethod = "Tween"
local tweenSpeed = 1200
local autoDrive = false
local v19 = false
local driveSpeed = 700
local antiAFK = false
local v20 = "Security"
local v21, v22, v23

do
  v21 = false
  v22 = "Notify"

  v23 = {
    Mod = true,
    ["Senior Moderator"] = true,
    ["QA Alts"] = true,
    ["Voldex QA"] = true,
    Creative = true,
    Developer = true,
    LT = true,
    Admin = true,
    Owner = true,
  }

  local v24

  if hookmetamethod and getnamecallmethod then
    v24 = nil

    v24 = hookmetamethod(game, "__namecall", function(p2, ...)
      if antiAFK then
        local namecallmethod2 = getnamecallmethod()

        if namecallmethod2 == "FireServer" or namecallmethod2 == "InvokeServer" then
          local lower = tostring(p2.Name):lower()

          if lower:find("idle") or lower:find("afk") or lower:find("activity") then
            return
          end
        end
      end

      return v24(p2, ...)
    end)
  end
end

local function f4(p3, p4, ...)
  local v25 = { ... }
  local flag3 = false
  local invokeServer

  task.spawn(function()
    pcall(function() invokeServer = p3:InvokeServer(unpack(v25)) end)
    flag3 = true
  end)

  local total = 0

  while not flag3 and total < p4 do
    task.wait(0.1)
    total = total + 0.1
  end

  return flag3, invokeServer
end

local v26 = tick()

local function f5(p5)
  if not p5 or not p5.model or not p5.model.Parent then
    return false
  end

  if not p5.part then
    return false
  end

  if p5.part:FindFirstChild("ATMIconBillboard") then
    return true
  end

  local findFirstChild = p5.model:FindFirstChild("ProximityPrompt", true)

  if findFirstChild and findFirstChild.Enabled then
    return true
  end

  return p5.model:FindFirstChild("ATMIconBillboard", true) ~= nil
end

local heartbeat = v10.Heartbeat
local connect = heartbeat.Connect

local function f6(p6)
  if not localPlayer2.Character or not localPlayer2.Character:FindFirstChild("HumanoidRootPart") then
    return
  end

  local humanoidRootPart = localPlayer2.Character.HumanoidRootPart

  if (humanoidRootPart.Position - p6.Position).Magnitude > 15 then
    humanoidRootPart.Anchored = false
    task.wait(0.1)
  end

  v13 = true

  humanoidRootPart.Anchored = false
  humanoidRootPart.CFrame = CFrame.new(p6.Position)

  task.wait(0.1)
  humanoidRootPart.Anchored = true
end

connect(heartbeat, function()
  if not antiAFK then
    v26 = tick()
    return
  end

  local currentCamera, cframe

  if tick() - v26 >= 50 then
    v26 = tick()
    currentCamera = workspace.CurrentCamera

    if currentCamera then
      cframe = currentCamera.CFrame
      currentCamera.CFrame = cframe * CFrame.Angles(0, 0.0001, 0)
      task.defer(function() currentCamera.CFrame = cframe end)
    end

    pcall(function()
      virtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)

    task.delay(0.1, function()
      pcall(function()
        virtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
      end)
    end)
  end
end)

localPlayer2.Idled:Connect(function()
  if antiAFK then
    pcall(function()
      virtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
      task.wait(0.5)
      virtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)

    pcall(function()
      local currentCamera2 = workspace.CurrentCamera
      local cframe2 = currentCamera2.CFrame
      currentCamera2.CFrame = cframe2 * CFrame.Angles(0, 0.0001, 0)
      task.defer(function() currentCamera2.CFrame = cframe2 end)
    end)
  end
end)

local vector = Vector3.new(-18226.3, 32.9, -500.1)
local vector2 = Vector3.new(-34534.5, 32.7, -32788.4)

local function f7(instance)
  if not instance or not instance:IsA("ProximityPrompt") then
    return
  end

  instance.MaxActivationDistance = 50
  instance.RequiresLineOfSight = false

  task.spawn(function()
    pcall(function()
      if fireproximityprompt then
        fireproximityprompt(instance)
      end
    end)
  end)

  pcall(function()
    instance:InputHoldBegin()
    local holdDuration = instance.HoldDuration
    task.wait((holdDuration or 0.25) + 0.15)
    instance:InputHoldEnd()
  end)
end

local criminalDropOffPoint = workspace:WaitForChild("Game"):WaitForChild("Jobs"):WaitForChild("CriminalDropOffSpawners"):WaitForChild("CriminalDropOffSpawnerPermanent"):WaitForChild("CriminalDropOffPoint")
local vector3 = Vector3.new(-2543.3, 14.9, 4030.8)
local v27 = game

local function f8()
  local criminalATMSpawners = workspace:FindFirstChild("Game")
    and workspace.Game:FindFirstChild("Jobs")
    and workspace.Game.Jobs:FindFirstChild("CriminalATMSpawners")

  if not criminalATMSpawners then
    return {}
  end

  local list = {}

  for _, value5 in ipairs(criminalATMSpawners:GetChildren()) do
    table.insert(list, value5)
  end

  return list
end

local teleportService = v27:GetService("TeleportService")

local function f9(p7)
  local total2 = 0

  while total2 < p7 do
    if localPlayer2.Character and localPlayer2.Character:FindFirstChild("HumanoidRootPart") then
      local humanoid = localPlayer2.Character:FindFirstChild("Humanoid")

      if humanoid and humanoid.Health > 0 then
        return true
      end
    end

    task.wait(0.2)
    total2 = total2 + 0.2
  end

  return false
end

local function f10(atm)
  if not atm then
    return nil
  end

  if atm:IsA("BasePart") then
    return atm.Position
  end

  if atm:IsA("Attachment") then
    return atm.WorldPosition
  end

  if atm:IsA("Model") then
    local getPivot = atm:GetPivot()
    return Vector3.new(getPivot.X, getPivot.Y, getPivot.Z)
  end

  return nil
end

local function f11(character)
  if not character then
    return
  end

  local waitForChild = character:WaitForChild("Humanoid", 3)

  if not waitForChild then
    return
  end

  local v28 = autoRob or autoDelivery
  waitForChild:SetStateEnabled(Enum.HumanoidStateType.Seated, not v28)

  if v28 then
    if waitForChild.SeatPart then
      waitForChild.Sit = false
      waitForChild.Jump = true
    end

    local humanoidRootPart2 = character:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart2 then
      local seatWeld = humanoidRootPart2:FindFirstChild("SeatWeld")

      if seatWeld then
        seatWeld:Destroy()
      end
    end
  end
end

local function f12()
  local ok7, result3 = pcall(function()
    local bankMoneyPrintingFloorSTREAM = workspace:FindFirstChild("BankMoneyPrintingFloor_STREAM")

    local ignoreMoneyPrintingFloor = bankMoneyPrintingFloorSTREAM
      and bankMoneyPrintingFloorSTREAM:FindFirstChild("IGNOREMoneyPrintingFloor")

    local ignore = ignoreMoneyPrintingFloor
      and ignoreMoneyPrintingFloor:FindFirstChild("IGNORE")

    if ignore then
      for _, value6 in ipairs(ignore:GetChildren()) do
        local mainMachineNew = value6:FindFirstChild("MainMachineNew")

        if mainMachineNew then
          return mainMachineNew
        end
      end
    end

    return nil
  end)

  return ok7 and result3 or nil
end

localPlayer2.CharacterAdded:Connect(function(character2)
  task.spawn(function() f11(character2) end)
end)

local v29

local function f13(vector4, tweenSpeed2)
  if not vector4 or typeof(vector4) ~= "Vector3" then
    return
  end

  if not localPlayer2.Character or not localPlayer2.Character:FindFirstChild("HumanoidRootPart") then
    return
  end

  local humanoidRootPart3 = localPlayer2.Character.HumanoidRootPart
  local vector5 = Vector3.new(vector4.X, vector4.Y + 3, vector4.Z)
  local magnitude = (humanoidRootPart3.Position - vector5).Magnitude
  v13 = true
  local new = TweenInfo.new
  local easingStyle = Enum.EasingStyle

  local create = v11:Create(
    humanoidRootPart3, new(magnitude / tweenSpeed2, easingStyle.Linear),
    { CFrame = CFrame.new(vector5) }
  )

  v29 = create

  create:Play()
  create.Completed:Wait()

  v29 = nil

  if not autoRob then
    v13 = false
  end
end

local stepped = v10.Stepped

local function f14()
  if not localPlayer2.Character then
    return 0
  end

  local findFirstChild2 = localPlayer2.Character:FindFirstChild("CharacterBillboard", true)

  if not findFirstChild2 then
    return 0
  end

  for _, value7 in ipairs(findFirstChild2:GetChildren()) do
    if value7:IsA("TextLabel") and value7.Name == "CriminalCharacterTextLabel" then
      local d = value7.Text:match("%$([%d,%.]+)")

      if d then
        local v30 = tonumber((d:gsub(",", "")))

        if v30 then
          return v30
        end
      else
        local v31 = tonumber((value7.Text:gsub("%$", ""):gsub(",", "")))

        if v31 then
          return v31
        end
      end
    end
  end

  return 0
end

stepped:Connect(function()
  if v13 and localPlayer2.Character then
    for _, value8 in ipairs(localPlayer2.Character:GetDescendants()) do
      if value8:IsA("BasePart") then
        value8.CanCollide = false
      end
    end
  end

  if (autoRob or autoDelivery) and localPlayer2.Character then
    local humanoid2 = localPlayer2.Character:FindFirstChild("Humanoid")
    local humanoidRootPart4 = localPlayer2.Character:FindFirstChild("HumanoidRootPart")

    if humanoid2 then
      humanoid2.Sit = false
    end

    if humanoidRootPart4 then
      local seatWeld2 = humanoidRootPart4:FindFirstChild("SeatWeld")

      if seatWeld2 then
        seatWeld2:Destroy()
      end
    end
  end
end)

local function f15()
  if not localPlayer2.Character or not localPlayer2.Character:FindFirstChild("HumanoidRootPart") then
    return false
  end

  local position = localPlayer2.Character.HumanoidRootPart.Position

  for _, value9 in ipairs(v9:GetPlayers()) do
    if value9 ~= localPlayer2 then
      if not (not value9.Team or value9.Team.Name ~= name) then
        if not (not value9.Character or not value9.Character:FindFirstChild("HumanoidRootPart")) then
          local position2 = value9.Character.HumanoidRootPart.Position

          if Vector3.new(position2.X - position.X, 0, position2.Z - position.Z).Magnitude <= 30 then
            return true
          end
        end
      end
    end
  end

  return false
end

local function f16(anchored)
  if not localPlayer2.Character then
    return
  end

  local humanoidRootPart5 = localPlayer2.Character:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart5 then
    humanoidRootPart5.Anchored = anchored
  end
end

local function f17(p8)
  if p8 and p8.spawner then
    local pos = p8.pos
    return math.floor(pos.X) .. "," .. math.floor(pos.Y) .. "," .. math.floor(pos.Z)
  end

  return nil
end

local instance2

local function makePart()
  if instance2 then
    instance2:Destroy()
  end

  if not localPlayer2.Character or not localPlayer2.Character:FindFirstChild("HumanoidRootPart") then
    return
  end

  local humanoidRootPart6 = localPlayer2.Character.HumanoidRootPart

  local part = Instance.new("Part")
  part.Size = Vector3.new(50, 1, 50)
  part.Position = humanoidRootPart6.Position + Vector3.new(0, 200, 0)
  part.Anchored = true
  part.CanCollide = true
  part.Transparency = 1
  part.Parent = workspace

  instance2 = part
end

local function f18()
  local ok8, result4, v32 = pcall(function()
    local heistCashUIHolder = localPlayer2.PlayerGui:FindFirstChild("HeistCashUIHolder")
    local heistCashUI = heistCashUIHolder and heistCashUIHolder:FindFirstChild("HeistCashUI")

    if not heistCashUI or heistCashUI:IsA("GuiObject") and not heistCashUI.Visible then
      return 0, 0
    end

    local gsub2 = heistCashUI.Holder.Holder.CashAmount.Text:gsub("<[^>]+>", ""):gsub(",", "")
    local list2 = {}

    for match in gsub2:gmatch("%d+") do
      table.insert(list2, tonumber(match))
    end

    if #list2 >= 2 then
      return list2[#list2 - 1], list2[#list2]
    end

    return 0, 0
  end)

  if ok8 then
    return result4, v32
  end

  return 0, 0
end

local function f19()
  if v29 then
    v29:Cancel()
    v29 = nil
    v13 = false
  end
end

local findFirstChild3 = replicatedStorage.FindFirstChild

local function f20()
  local v33 = {}

  table.sort(v33, function(p9, p10)
    local rounded = math.floor(p9.part.Position.Y / 10)
    local rounded2 = math.floor(p10.part.Position.Y / 10)

    if rounded ~= rounded2 then
      return rounded > rounded2
    end

    if p9.isDiamond and not p10.isDiamond then
      return true
    end

    if not p9.isDiamond and p10.isDiamond then
      return false
    end

    return p9.part.Position.Y > p10.part.Position.Y
  end)

  return v33
end

local v34 = findFirstChild3(replicatedStorage, "Stats")

local function f21(p11)
  if not v34 then
    v34 = replicatedStorage:FindFirstChild("Stats")
  end

  if not v34 then
    return 0
  end

  local findFirstChild4 = v34:FindFirstChild(p11.Name .. "'s Stats")

  if not findFirstChild4 then
    return 0
  end

  local bounty = findFirstChild4:FindFirstChild("Bounty")

  if not bounty then
    return 0
  end

  return tonumber(bounty.Value) or 0
end

local function f22(p12)
  if p12 == localPlayer2 then
    return false
  end

  if not p12.Team or p12.Team.Name ~= "Outlaw" then
    return false
  end

  local v35 = f21(p12)

  if v35 < 0 then
    return false
  end

  return true, v35
end

local function f23()
  local ok9, result5 = pcall(function()
    local bankHeist = workspace.Game.Heists:FindFirstChild("BankHeist")

    if bankHeist then
      return bankHeist:GetAttribute("HeistActive") == true
    end

    return false
  end)

  return ok9 and result5
end

local function f24()
  local ok10, result6 = pcall(function()
    return workspace.Game.Heists.BankHeist.HeistAsset.PrerequisiteModels
  end)

  return ok10 and result6 or nil
end

v29 = nil

local function f25(instance3)
  local isWater = false
  local instance4, atm2, v36

  for _, value10 in ipairs({ "CriminalATMLegoSmall", "CriminalATMWater", "CriminalATM" }) do
    local findFirstChild5 = instance3:FindFirstChild(value10, true)

    if findFirstChild5 then
      if not v36 then
        v36 = findFirstChild5
      end

      local atm3 = findFirstChild5:FindFirstChild("ATM")

      local promptAttachment = atm3
      promptAttachment = atm3 or findFirstChild5:FindFirstChild("PromptAttachment")

      local flag4 = false

      if promptAttachment and promptAttachment:FindFirstChild("ATMIconBillboard") then
        flag4 = true
      else
        local findFirstChild6 = findFirstChild5:FindFirstChild("ProximityPrompt", true)

        if findFirstChild6 and findFirstChild6.Enabled then
          flag4 = true
        elseif findFirstChild5:FindFirstChild("ATMIconBillboard", true) then
          flag4 = true
        end
      end

      if flag4 then
        instance4 = findFirstChild5
        atm2 = promptAttachment or findFirstChild5
        isWater = value10 == "CriminalATMWater"
        break
      end
    end
  end

  if not instance4 and v36 then
    instance4 = v36

    atm2 = instance4:FindFirstChild("ATM") or instance4:FindFirstChild("PromptAttachment")
      or instance4

    isWater = instance4.Name == "CriminalATMWater"
  end

  if not atm2 then
    return nil
  end

  local v37 = f10(atm2)

  local pos2 = v37
  pos2 = v37 or f10(instance3)

  if not pos2 then
    return nil
  end

  return {
    spawner = instance3,
    model = instance4,
    part = atm2,
    pos = pos2,
    isWater = isWater,
  }
end

local function f26()
  if not localPlayer2.Character or not localPlayer2.Character:FindFirstChild("HumanoidRootPart") then
    return nil
  end

  local position3 = localPlayer2.Character.HumanoidRootPart.Position
  local huge = math.huge
  local v38

  for _, value11 in ipairs(f8()) do
    local v39 = f25(value11)

    if v39 then
      if f5(v39) then
        local v40 = f17(v39)

        if not (v40 and (map3[v40] or 0) > 3) then
          if not (v39.isWater and not v14[2]) then
            if not (not v39.isWater and not v14[1] and not flag2) then
              local magnitude2 = (v39.pos - position3).Magnitude

              if magnitude2 < huge then
                v38 = v39
                huge = magnitude2
              end
            end
          end
        end
      end
    end
  end

  return v38
end

local function f27()
  if localPlayer2.Character and localPlayer2.Character:FindFirstChild("HumanoidRootPart") then
    localPlayer2.Character.HumanoidRootPart.CFrame = CFrame.new(-1121.92, 14.96, 2161.2)
  end
end

local function f28()
  f16(false)
  f13(vector3, 500)
  task.wait(0.5)
  pcall(function() attemptCriminalJobComplete:InvokeServer(criminalDropOffPoint) end)
end

local function f29()
  local v41, v42 = f18()
  return v41 >= v42 and v42 > 0
end

local function f30()
  f16(false)
  f19()

  if avoidMethod == "Cashout" and f14() >= 80000 and not flag2 then
    f28()
  elseif localPlayer2.Character and localPlayer2.Character:FindFirstChild("HumanoidRootPart") then
    localPlayer2.Character.HumanoidRootPart.CFrame = CFrame.new(
      vector.X, vector.Y + 3, vector.Z
    )
  end
end

local function f31()
  local instance5 = f24()

  if not instance5 then
    return true
  end

  local list3 = {}

  for _, value12 in ipairs(instance5:GetChildren()) do
    local prerequisites = value12:FindFirstChild("Prerequisites")

    if prerequisites then
      for _, value13 in ipairs(prerequisites:GetChildren()) do
        if value13.Name == "TriggerBox" and value13:FindFirstChild("Eletrical Box") then
          table.insert(list3, value13)
        end
      end
    end
  end

  if #list3 == 0 then
    return true
  end

  local flag5 = false

  while autoRob and not flag5 do
    flag5 = true

    for _, value14 in ipairs(list3) do
      local primary = value14:FindFirstChild("Primary")

      if primary then
        local attachment = primary:FindFirstChild("Attachment")

        local proximityPrompt = attachment and attachment:FindFirstChild("ProximityPrompt")
          or primary:FindFirstChild("ProximityPrompt")

        if proximityPrompt and proximityPrompt.Enabled then
          flag5 = false
          f6(primary)
          task.wait(0.1)
          f7(proximityPrompt)
        end
      end
    end

    if not flag5 then
      task.wait(0.2)
    end
  end

  return true
end

local function f32()
  local instance6 = f24()

  if not instance6 then
    return true
  end

  local list4 = {}

  for _, value15 in ipairs(instance6:GetChildren()) do
    local prerequisites2 = value15:FindFirstChild("Prerequisites")

    if prerequisites2 then
      for _, value16 in ipairs(prerequisites2:GetChildren()) do
        if value16.Name == "TriggerBox" and value16:FindFirstChild("Detonator") then
          table.insert(list4, value16)
        end
      end
    end
  end

  if #list4 == 0 then
    return true
  end

  local flag6 = false

  while autoRob and not flag6 do
    flag6 = true

    for _, value17 in ipairs(list4) do
      local primary2 = value17:FindFirstChild("Primary")

      if primary2 then
        local attachment2 = primary2:FindFirstChild("Attachment")

        local proximityPrompt2 = attachment2 and attachment2:FindFirstChild("ProximityPrompt")
          or primary2:FindFirstChild("ProximityPrompt")

        if proximityPrompt2 and proximityPrompt2.Enabled then
          flag6 = false
          f6(primary2)
          task.wait(0.1)
          f7(proximityPrompt2)
        end
      end
    end

    if not flag6 then
      task.wait(0.2)
    end
  end

  return true
end

local function f33()
  local instance7 = f24()

  if not instance7 then
    return true
  end

  local codeSnippet

  for _, value18 in ipairs(instance7:GetChildren()) do
    local prerequisites3 = value18:FindFirstChild("Prerequisites")

    if prerequisites3 then
      codeSnippet = prerequisites3:FindFirstChild("CodeSnippet")

      if codeSnippet then
        break
      end
    end
  end

  if not codeSnippet then
    return true
  end

  local primary3 = codeSnippet:FindFirstChild("Primary")
  local d2

  if primary3 then
    local surfaceGui = primary3:FindFirstChild("SurfaceGui")

    local textLabel = surfaceGui
    textLabel = surfaceGui and surfaceGui:FindFirstChild("TextLabel")

    if textLabel and textLabel.Text and textLabel.Text ~= "" then
      d2 = textLabel.Text:match("%d+")

      if d2 then
        local v43 = f12()

        if v43 then
          f6(v43)
          task.wait(0.2)
        end

        pcall(function()
          replicatedStorage:WaitForChild("Remotes"):WaitForChild("HeistCodeEntered"):FireServer(d2)
        end)

        task.wait(1)
      end
    end
  end

  return true
end

local function f34()
  if not autoRob then
    return false
  end

  if not v14[3] then
    return false
  end

  if f14() > 0 then
    if f14() >= 75000 then
      f28()
      task.wait(1)
    else
      if v14[1] or v14[2] then
        return false
      end

      if localPlayer2.Character and localPlayer2.Character:FindFirstChild("Humanoid") then
        localPlayer2.Character.Humanoid.Health = 0
      end

      task.wait(6)
      return false
    end
  end

  f16(true)
  f27()
  task.wait(3)

  if not autoRob then
    f16(false)
    return false
  end

  f31()

  if not autoRob then
    return false
  end

  f33()

  if not autoRob then
    return false
  end

  f32()

  if not autoRob then
    return false
  end

  f16(true)
  local flag7 = false
  local count = 0
  local v44

  while autoRob and not flag7 and count < 300 do
    count = count + 1

    if not f23() then
      break
    end

    if f29() then
      break
    end

    local list5 = f20()

    if #list5 > 0 then
      for _, value19 in ipairs(list5) do
        if not autoRob then
          break
        end

        local rounded3 = math.floor(value19.part.Position.Y / 10)

        if v44 and v44 ~= rounded3 then
          f16(false)
          task.wait(0.5)
        end

        v44 = rounded3

        if f29() or not f23() then
          flag7 = true
          break
        end

        f6(value19.part)
        task.wait(0.2)
        f7(value19.prompt)
        task.wait(0.5)
      end

      task.wait(0.2)
    else
      break
    end
  end

  flag = true
  f16(false)
  flag2 = true

  if localPlayer2.Character and localPlayer2.Character:FindFirstChild("HumanoidRootPart") then
    localPlayer2.Character.HumanoidRootPart.CFrame = CFrame.new(-1056.83, 146.82, 2294.9)
  end

  task.wait(1)
  return true
end

local userOwnsGamePassAsync = false

task.spawn(function()
  pcall(function()
    userOwnsGamePassAsync = marketplaceService:UserOwnsGamePassAsync(
      localPlayer2.UserId, 19735776
    )
  end)
end)

local function f35()
  return userOwnsGamePassAsync and 2.35 or 4.5
end

local function f36(p13)
  local flag8 = false

  if not f5(p13) then
    return false
  end

  f4(attemptATMBustStart, 5, p13.model)
  local v45 = 0
  local v46 = f35()

  while v45 < v46 do
    task.wait(0.2)
    local v47 = v45 + 0.2
    local v48 = avoidSecurity
    v45 = v47

    if v48 and f15() then
      f30()
      flag8 = true
      break
    end

    if not autoRob then
      flag8 = true
      break
    end

    if not localPlayer2.Character
      or not localPlayer2.Character:FindFirstChild("HumanoidRootPart") then
      flag8 = true
      break
    end

    local humanoid3 = localPlayer2.Character:FindFirstChild("Humanoid")

    if humanoid3 and humanoid3.Health <= 0 then
      flag8 = true
      break
    end
  end

  if not flag8 then
    f4(attemptATMBustComplete, 5, p13.model)
    task.wait(0.5)

    if not f5(p13) then
      flag2 = false
    else
      return false
    end
  end

  return not flag8
end

local autoFarmTab = window:Tab({ Title = "Auto Farm", Icon = "house", Locked = false })

autoFarmTab:Section({ Title = "Auto Arrest", Box = false, Opened = true }):Toggle({
  Title = "Auto Arrest",
  Desc = "",
  Icon = "check",
  Type = "Checkbox",
  Flag = "AutoArrest",
  Value = false,
  Callback = function(value20)
    autoArrest = value20

    if autoArrest then
      if not localPlayer2.Team or localPlayer2.Team.Name ~= name then
        pcall(function() requestStartJobSession:FireServer("Security", "jobPad") end)
      end
    end
  end,
})

local robberySection = autoFarmTab:Section({ Title = "Robbery", Box = false, Opened = true })

robberySection:Toggle({
  Title = "Auto Rob",
  Desc = "",
  Icon = "check",
  Type = "Checkbox",
  Flag = "AutoRob",
  Value = false,
  Callback = function(value21)
    autoRob = value21
    v13 = value21

    if autoRob then
      windUI:Notify({
        Title = "Auto Rob",
        Content = "Set your graphics slider as high as possible to increase render distance Higher render distance makes the Auto Rob better",
        Duration = 5,
        Icon = "zap",
      })

      if not localPlayer2.Team or localPlayer2.Team.Name ~= "Outlaw" then
        pcall(function() requestStartJobSession:FireServer("Criminal", "jobPad") end)
      end

      makePart()
    else
      f16(false)
      flag2 = false
      flag = false

      if instance2 then
        instance2:Destroy()
        instance2 = nil
      end

      f19()
    end

    f11(localPlayer2.Character)
  end,
})

robberySection:Toggle({
  Title = "Avoid Security",
  Desc = "",
  Icon = "check",
  Type = "Checkbox",
  Flag = "AvoidSecurity",
  Value = true,
  Callback = function(value22) avoidSecurity = value22 end,
})

robberySection:Toggle({
  Title = "Auto Cashout",
  Desc = "",
  Icon = "check",
  Type = "Checkbox",
  Flag = "AutoCashout",
  Value = true,
  Callback = function(value23) autoCashout = value23 end,
})

robberySection:Dropdown({
  Title = "Avoid Method",
  Desc = "",
  Values = { "Cashout", "Avoid" },
  Value = "Cashout",
  Flag = "AvoidMethod",
  Callback = function(value24) avoidMethod = value24 end,
})

robberySection:Slider({
  Title = "Cashout Amount",
  Desc = "",
  Step = 10000,
  Flag = "CashoutAmount",
  Value = { Min = 80000, Max = 1000000, Default = 300000 },
  Callback = function(value25) cashoutAmount = tonumber(value25) or 300000 end,
})

robberySection:Toggle({
  Title = "Remove Bank Lasers",
  Desc = "",
  Icon = "check",
  Type = "Checkbox",
  Flag = "RemoveBankLasers",
  Value = false,
  Callback = function(value26) v18 = value26 end,
})

robberySection:Dropdown({
  Title = "Allowed Robberies",
  Desc = "",
  Values = { "ATM", "Water ATM", "Bank ( Beta )" },
  Value = { "ATM", "Water ATM" },
  Multi = true,
  AllowNone = true,
  Flag = "AllowedRobberies",
  Callback = function(value27)
    v14[1] = false
    v14[2] = false
    v14[3] = false

    for _, value28 in ipairs(value27) do
      if value28 == "ATM" then
        v14[1] = true
      end

      if value28 == "Water ATM" then
        v14[2] = true
      end

      if value28 == "Bank ( Beta )" then
        v14[3] = true
      end
    end
  end,
})

robberySection:Button({
  Title = "Cashout",
  Desc = "",
  Locked = false,
  Callback = function() f28() end,
})

local autoDriveSection = autoFarmTab:Section({ Title = "Auto Drive", Box = false, Opened = true })

autoDriveSection:Toggle({
  Title = "Auto Drive",
  Desc = "",
  Icon = "check",
  Type = "Checkbox",
  Flag = "AutoDrive",
  Value = false,
  Callback = function(value29) autoDrive = value29 end,
})

autoDriveSection:Toggle({
  Title = "Helicopter Auto Drive",
  Desc = "",
  Icon = "check",
  Type = "Checkbox",
  Flag = "HeliAutoDrive",
  Value = false,
  Callback = function(value30) v19 = value30 end,
})

autoDriveSection:Slider({
  Title = "Drive Speed",
  Desc = "",
  Step = 1,
  Flag = "DriveSpeed",
  Value = { Min = 100, Max = 750, Default = 750 },
  Callback = function(value31) driveSpeed = value31 end,
})

local autoDeliverySection = autoFarmTab:Section({
  Title = "Auto Delivery",
  Box = false,
  Opened = true,
})

autoDeliverySection:Toggle({
  Title = "Auto Delivery",
  Desc = "Do not sit in a car while using this",
  Icon = "check",
  Type = "Checkbox",
  Flag = "AutoDelivery",
  Value = false,
  Callback = function(value32)
    autoDelivery = value32

    if autoDelivery then
      windUI:Notify({
        Title = "Auto Delivery",
        Content = "Do not sit in a car",
        Duration = 5,
        Icon = "package",
      })

      if not localPlayer2.Team or localPlayer2.Team.Name ~= "Delivery Driver" then
        pcall(function() requestStartJobSession:FireServer("Delivery", "jobPad", "HighRisk") end)
      end
    end
  end,
})

autoDeliverySection:Slider({
  Title = "Dropoff Delay",
  Step = 0.5,
  Flag = "DeliveryDelay",
  Value = { Min = 2.5, Max = 60, Default = 2.5 },
  Callback = function(value33) dropoffDelay = tonumber(value33) or 2.5 end,
})

local function f37()
  if workspace:FindFirstChild("DeliveryTargetAnchor", true) then
    return true
  end

  local deliveryLocationEffects = workspace:FindFirstChild("DeliveryLocationEffects")

  if not deliveryLocationEffects then
    return false
  end

  local ringGlow = deliveryLocationEffects:FindFirstChild("RingGlow")

  if not ringGlow then
    return false
  end

  if ringGlow:IsA("BasePart") then
    return ringGlow.Transparency < 1
  end

  for _, value34 in ipairs(ringGlow:GetDescendants()) do
    if value34:IsA("BasePart") and value34.Transparency < 1 then
      return true
    end
  end

  return false
end

do
  local tweenSpeedSlider

  autoDeliverySection:Dropdown({
    Title = "Move Method",
    Desc = "",
    Values = { "Teleport", "Tween" },
    Value = "Tween",
    Flag = "DeliveryMoveMethod",
    Callback = function(value35)
      moveMethod = value35

      if tweenSpeedSlider then
        pcall(function()
          if value35 == "Teleport" then
            tweenSpeedSlider:Hide()
          else
            tweenSpeedSlider:Show()
          end
        end)
      end
    end,
  })

  tweenSpeedSlider = autoDeliverySection:Slider({
    Title = "Tween Speed",
    Desc = "",
    Step = 10,
    Flag = "DeliveryTweenSpeed",
    Value = { Min = 100, Max = 2000, Default = 1200 },
    Callback = function(value36) tweenSpeed = tonumber(value36) or 1200 end,
  })
end

local miscTab = window:Tab({ Title = "Misc", Icon = "zap", Locked = false })

local miscellaneousSection = miscTab:Section({
  Title = "Miscellaneous",
  Box = false,
  Opened = true,
})

miscellaneousSection:Button({
  Title = "Join Team",
  Desc = "",
  Locked = false,
  Callback = function()
    pcall(function()
      local v49, v50

      if v20 == "Outlaw" then
        v50 = "Criminal"
      elseif v20 == "Delivery Driver" then
        v50 = "Delivery"
        v49 = "HighRisk"
      else
        v50 = "Security"
      end

      if v49 then
        requestStartJobSession:FireServer(v50, "jobPad", v49)
      else
        requestStartJobSession:FireServer(v50, "jobPad")
      end
    end)
  end,
})

miscellaneousSection:Dropdown({
  Title = "Team to join",
  Desc = "",
  Values = { "Security", "Outlaw", "Delivery Driver" },
  Value = "",
  Callback = function(value37) v20 = value37 end,
})

local function f38(instance8)
  if not instance8 then
    return nil
  end

  local ok11, result7 = pcall(function()
    if typeof(instance8) == "Vector3" then
      return instance8
    end

    if instance8:IsA("BasePart") then
      return instance8.Position
    end

    if instance8:IsA("Attachment") then
      return instance8.WorldPosition
    end

    if instance8:IsA("Model") then
      local getPivot2 = instance8:GetPivot()
      return Vector3.new(getPivot2.X, getPivot2.Y, getPivot2.Z)
    end

    local findFirstChildWhichIsA = instance8:FindFirstChildWhichIsA("BasePart", true)
    return findFirstChildWhichIsA and findFirstChildWhichIsA.Position
  end)

  return ok11 and result7 or nil
end

miscellaneousSection:Button({
  Title = "Buy 10 Tuning Kits",
  Desc = "",
  Locked = false,
  Callback = function()
    pcall(function()
      tryPurchaseProductYield:InvokeServer(unpack({
        "TenTuningKits", "Cash",
        {
          Category_0 = "Crates",
          ShopTab = "Cash",
          Source = "Shop",
          DoNotifySuccess = false,
          PurchaseId = "CD481A2B-B41C-4EC5-A236-65E1562A3F33",
          Category_1 = "TuningKits",
        },
      }))
    end)
  end,
})

miscellaneousSection:Button({
  Title = "Open all tuning kits",
  Desc = "",
  Locked = false,
  Callback = function()
    pcall(function()
      local v51 = tonumber((players.LocalPlayer.PlayerGui.PartsInventory.GenericInventory.MainFrame.Menus.LootboxInventoryUI.Holder.View.Items.Container.Pack_Parts_Store.Holder.Container.Quantity.TextLabel.Text:gsub(
        "%D", ""
      )))

      if not v51 or v51 <= 0 then
        return
      end

      replicatedStorage:WaitForChild("Remotes"):WaitForChild("OpenGacha"):InvokeServer(unpack({
        "Pack_Parts_Store", { Amount = v51 },
      }))
    end)
  end,
})

miscellaneousSection:Toggle({
  Title = "Anti AFK",
  Desc = "",
  Icon = "check",
  Type = "Checkbox",
  Flag = "AntiAFK",
  Value = false,
  Callback = function(value38) antiAFK = value38 end,
})

local function f39()
  task.spawn(function()
    local v52

    while true do
      local random = seen2.Random
      local list6 = {}

      if not random then
        if seen2.Big then
          table.insert(list6, "Big")
        end

        if seen2.Medium then
          table.insert(list6, "Medium")
        end

        if seen2.Small then
          table.insert(list6, "Small")
        end
      end

      if random or #list6 == 0 then
        list6 = { "Random" }
      end

      local v53 = list6[math.random(1, #list6)]
      local v54 = "Desc"

      if v53 == "Small" then
        v54 = "Asc"
      elseif v53 == "Random" then
        v54 = math.random(1, 2) == 1 and "Desc" or "Asc"
      end

      local ok12, result8 = pcall(function()
        return httpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"
          .. game.PlaceId .. "/servers/Public?sortOrder=" .. v54 .. "&limit=100"))
      end)

      if ok12 and result8 and result8.data then
        local jobId = game.JobId
        local list7 = {}

        for _, value39 in ipairs(result8.data) do
          if value39.id ~= jobId and value39.playing and value39.maxPlayers
            and value39.playing < value39.maxPlayers then
            table.insert(list7, value39)
          end
        end

        if #list7 > 0 then
          local list8 = {}

          for _, value40 in ipairs(list7) do
            if not seen[value40.id] then
              table.insert(list8, value40)
            end
          end

          if #list8 == 0 then
            seen = {}
            seen[jobId] = true
            list8 = list7
          end

          local function f40(p14, p15)
            local playing = p14.playing

            if p15 == "Big" then
              return playing >= 15 and playing < p14.maxPlayers
            elseif p15 == "Medium" then
              return playing >= 5 and playing <= 14
            elseif p15 == "Small" then
              return playing >= 1 and playing <= 4
            end

            if p15 == "Random" then
              return true
            end

            return false
          end

          local list9 = {}

          for _, value41 in ipairs(list8) do
            for _, value42 in ipairs(list6) do
              if f40(value41, value42) then
                table.insert(list9, value41)
                break
              end
            end
          end

          if #list9 > 0 then
            v52 = list9[math.random(1, #list9)]
          else
            v52 = list8[math.random(1, #list8)]
          end

          if v52 then
            seen[v52.id] = true
            seen[jobId] = true

            teleportService:TeleportToPlaceInstance(game.PlaceId, v52.id, localPlayer2)
            return
          end
        end
      end

      task.wait(3)
    end
  end)
end

do
  local function f41(player)
    local flag9 = false

    pcall(function()
      local voldexAdmin = replicatedStorage:FindFirstChild("VoldexAdmin")

      if voldexAdmin then
        local voldexAdmins = voldexAdmin:FindFirstChild("VoldexAdmins")

        if voldexAdmins and voldexAdmins:IsA("ModuleScript") then
          local v55 = require(voldexAdmins)

          if type(v55) == "table" and v55[player.UserId] then
            flag9 = true
          end
        end
      end
    end)

    if flag9 then
      return true, "Module Staff"
    end

    local ok13, result9 = pcall(function() return player:GetRoleInGroup(4999963) end)

    if ok13 and result9 and v23[result9] then
      return true, result9
    end

    return false, nil
  end

  local function f42(player2, p16)
    if not v21 then
      return
    end

    if v22 == "Serverhop" then
      windUI:Notify({
        Title = "Anti Staff",
        Content = "Staff detected " .. player2.Name .. " (" .. p16 .. ") - Server hopping!",
        Duration = 5,
        Icon = "alert-triangle",
      })

      task.wait(1)
      f39()
    else
      windUI:Notify({
        Title = "Anti Staff",
        Content = "Staff detected " .. player2.Name .. " (" .. p16 .. ")",
        Duration = 10,
        Icon = "alert-triangle",
      })
    end
  end

  miscellaneousSection:Toggle({
    Title = "Anti Staff",
    Desc = "",
    Icon = "check",
    Type = "Checkbox",
    Flag = "AntiStaff",
    Value = false,
    Callback = function(value43)
      v21 = value43

      if v21 then
        task.spawn(function()
          for _, value44 in ipairs(v9:GetPlayers()) do
            if value44 ~= localPlayer2 then
              local v56, v57 = f41(value44)

              if v56 then
                f42(value44, v57)
                break
              end
            end
          end
        end)
      end
    end,
  })

  miscellaneousSection:Dropdown({
    Title = "Anti Staff Method",
    Desc = "",
    Values = { "Notify", "Serverhop" },
    Value = "Notify",
    Flag = "AntiStaffMethod",
    Callback = function(value45) v22 = value45 end,
  })

  v9.PlayerAdded:Connect(function(player3)
    if not v21 then
      return
    end

    task.spawn(function()
      local v58, v59 = f41(player3)

      if v58 then
        f42(player3, v59)
      end
    end)
  end)
end

miscellaneousSection:Keybind({
  Title = "Menu Keybind",
  Desc = "",
  Value = "RightShift",
  Flag = "MenuKeybind",
  Callback = function(value46) window:SetToggleKey(Enum.KeyCode[value46]) end,
})

local serverHopSection = miscTab:Section({ Title = "Server hop", Box = false, Opened = true })

serverHopSection:Button({
  Title = "Server hop",
  Desc = "",
  Locked = false,
  Callback = function() f39() end,
})

serverHopSection:Dropdown({
  Title = "Server Hop Mode",
  Desc = "",
  Values = { "Big", "Medium", "Small", "Random" },
  Value = { "Big", "Medium" },
  Multi = true,
  AllowNone = true,
  Flag = "ServerHopMode",
  Callback = function(value47)
    seen2.Big = false
    seen2.Medium = false
    seen2.Small = false
    seen2.Random = false

    for _, value48 in ipairs(value47) do
      if seen2[value48] ~= nil then
        seen2[value48] = true
      end
    end
  end,
})

serverHopSection:Toggle({
  Title = "Auto Server hop",
  Desc = "",
  Icon = "check",
  Type = "Checkbox",
  Flag = "AutoServerHop",
  Value = false,
  Callback = function(value49)
    v15 = value49

    if value49 then
      v17 = tick()
    end
  end,
})

serverHopSection:Slider({
  Title = "Server hop Cooldown",
  Desc = "",
  Step = 1,
  Flag = "AutoServerHopCooldown",
  Value = { Min = 10, Max = 600, Default = 20 },
  Callback = function(value50) v16 = tonumber(value50) or 20 end,
})

local configsSection = window:Tab({
  Title = "Configs",
  Icon = "settings",
  Locked = false,
}):Section({
  Title = "Configs",
  Box = false,
  Opened = true,
})

local configManager, v60

do
  configManager = window.ConfigManager

  local function f43()
    local list10 = {}

    if #list10 == 0 then
      table.insert(list10, "Default")
    end

    return list10
  end

  v60 = "Default"

  configsSection:Dropdown({
    Title = "Select Config",
    Desc = "",
    Values = f43(),
    Value = "",
    Callback = function(value51) v60 = value51 end,
  })
end

configsSection:Input({
  Title = "New Config Name",
  Desc = "",
  Value = "",
  Callback = function(value52)
    if value52 and value52 ~= "" then
      v60 = value52
    end
  end,
})

configsSection:Toggle({
  Title = "Auto Load Config",
  Desc = "",
  Icon = "check",
  Type = "Checkbox",
  Value = true,
  Callback = function(value53) end,
})

configsSection:Button({
  Title = "Save Config",
  Desc = "",
  Locked = false,
  Callback = function()
    pcall(function() configManager:CreateConfig(v60):Save() end)

    windUI:Notify({
      Title = "Config",
      Content = "Saved config " .. v60,
      Duration = 3,
      Icon = "save",
    })
  end,
})

local v61

do
  configsSection:Button({
    Title = "Load Config",
    Desc = "",
    Locked = false,
    Callback = function()
      pcall(function() configManager:CreateConfig(v60):Load() end)

      windUI:Notify({
        Title = "Config",
        Content = "Loaded config " .. v60,
        Duration = 3,
        Icon = "folder-open",
      })
    end,
  })

  configsSection:Button({
    Title = "Delete Config",
    Desc = "",
    Locked = false,
    Callback = function()
      pcall(function() configManager:CreateConfig(v60):Delete() end)

      windUI:Notify({
        Title = "Config",
        Content = "Deleted config " .. v60,
        Duration = 3,
        Icon = "trash-2",
      })
    end,
  })

  task.spawn(function() task.wait(1) end)
  v61 = 1

  local v62 = {
    Vector3.new(4000, 150, 4000), Vector3.new(-4000, 150, 4000), Vector3.new(4000, 150, -4000),
    Vector3.new(-4000, 150, -4000), Vector3.new(0, 150, 0), Vector3.new(2000, 150, 0),
    Vector3.new(-2000, 150, 0), Vector3.new(0, 150, 2000), Vector3.new(0, 150, -2000),
  }

  local v63 = tick()

  local function f44()
    local list11 = {}

    for _, value54 in ipairs(v9:GetPlayers()) do
      local v64, bounty2 = f22(value54)

      if v64 then
        table.insert(list11, { player = value54, bounty = bounty2 })
      end
    end

    return list11
  end

  local v65 = v63
  local v66 = 0

  local function f45()
    local v67 = f44()

    if #v67 == 0 then
      return {}
    end

    table.sort(v67, function(p17, p18) return p17.bounty > p18.bounty end)
    return v67
  end

  task.spawn(function()
    while true do
      task.wait(0.5)

      if v18 then
        pcall(function()
          local lasers = workspace.Game.Heists.BankHeist.HeistAsset:FindFirstChild("Lasers")

          if lasers then
            lasers:Destroy()
          end
        end)
      end
    end
  end)

  task.spawn(function()
    while true do
      task.wait(1)

      if autoArrest then
        if not localPlayer2.Team or localPlayer2.Team.Name ~= name then
          pcall(function() requestStartJobSession:FireServer("Security", "jobPad") end)
          task.wait(1)
        else
          local list12 = f45()

          if #list12 ~= 0 then
            for _, _ in ipairs(list12) do
              if not autoArrest then
                break
              elseif #list12 > 1 then
                task.wait(0.1)
              end
            end
          end
        end
      end
    end
  end)

  task.spawn(function()
    while true do
      task.wait(0.1)

      if not autoRob then
        v66 = 0
      else
        if tick() - v65 > 15 then
          for key3, value55 in pairs(map3) do
            if value55 > 0 then
              map3[key3] = math.max(0, value55 - 2)
            end
          end

          v65 = tick()
        end

        if not localPlayer2.Character
          or not localPlayer2.Character:FindFirstChild("HumanoidRootPart") then
          f16(false)

          if f9(10) then
            v13 = true
            makePart()
            f11(localPlayer2.Character)
            task.wait(0.5)
          end
        else
          local humanoid4 = localPlayer2.Character:FindFirstChild("Humanoid")

          if humanoid4 and humanoid4.Health <= 0 then
            f16(false)
            f9(10)
            v13 = true
            makePart()
            f11(localPlayer2.Character)
            task.wait(0.5)
          elseif autoCashout and f14() >= cashoutAmount and not flag2 then
            f16(false)
            f28()
            task.wait(0.5)
          elseif avoidSecurity and f15() then
            f30()
            task.wait(1)
          else
            if flag and not f23() then
              flag = false
            end

            local v68 = v14[3]

            local v69 = v68
            v69 = v68 and f23() and not flag

            local flag10 = false

            if v69 then
              f16(false)

              if f34() then
                task.wait(1)
              else
                flag10 = true
              end
            else
              flag10 = true
            end

            if flag10 then
              if v14[1] or v14[2] or flag2 then
                local v70 = f26()

                if not v70 then
                  v66 = v66 + 1

                  if v66 >= 3 then
                    map3 = {}
                    v66 = 0
                  end

                  for key4, value56 in pairs(map3) do
                    map3[key4] = math.floor(value56 / 2)
                  end

                  f16(false)
                  local flag11 = true
                  local v71 = tick()
                  local v72

                  task.spawn(function()
                    while flag11 and autoRob do
                      task.wait(0.5)
                      local v73 = f26()

                      if v73 then
                        v72 = v73
                        f19()
                        break
                      end

                      if v14[3] and f23() and not flag then
                        f19()
                        break
                      elseif tick() - v71 > 120 then
                        map3 = {}
                        v66 = 0
                        local v74 = f26()

                        if v74 then
                          v72 = v74
                          f19()
                          break
                        end

                        v71 = tick()
                      end
                    end
                  end)

                  while autoRob and not v72 do
                    if autoCashout and f14() >= cashoutAmount and not flag2 then
                      break
                    end

                    if avoidSecurity and f15() then
                      break
                    end

                    if v14[3] and f23() and not flag then
                      break
                    end

                    if not localPlayer2.Character
                      or not localPlayer2.Character:FindFirstChild("HumanoidRootPart") then
                      break
                    end

                    if tick() - v71 > 120 then
                      map3 = {}
                      v66 = 0
                      break
                    end

                    f16(false)
                    v61 = v61 + 1

                    if v61 > #v62 then
                      v61 = 1
                    end

                    f13(v62[v61], 1200)
                  end

                  flag11 = false
                  v70 = v72
                else
                  v66 = 0
                end

                if not (not v70 or not autoRob) then
                  if not (autoCashout and f14() >= cashoutAmount and not flag2) then
                    if avoidSecurity and f15() then
                      f30()
                      task.wait(1)
                    elseif f5(v70) then
                      local isWater2 = v70.isWater

                      local vector6 = Vector3.new(
                        v70.pos.X, v70.pos.Y + (isWater2 and 15 or 1), v70.pos.Z
                      )

                      f16(false)
                      f13(vector6, 1200)

                      if autoRob then
                        if not (not localPlayer2.Character
                          or not localPlayer2.Character:FindFirstChild("HumanoidRootPart")) then
                          if avoidSecurity and f15() then
                            f30()
                            local v75 = f17(v70)

                            if v75 then
                              map3[v75] = (map3[v75] or 0) + 10
                            end

                            task.wait(1)
                          elseif f5(v70) then
                            if localPlayer2.Character
                              and localPlayer2.Character:FindFirstChild("HumanoidRootPart") then
                              localPlayer2.Character.HumanoidRootPart.CFrame = CFrame.new(vector6)
                            end

                            f16(true)
                            task.wait(0.1)
                            local v76 = f36(v70)
                            local v77 = f17(v70)

                            if f5(v70) then
                              if v77 then
                                map3[v77] = (map3[v77] or 0) + 1
                              end
                            else
                              f16(false)

                              if v77 then
                                map3[v77] = 0
                              end
                            end

                            if not v76 and avoidSecurity and f15() then
                              f16(false)

                              if v77 then
                                map3[v77] = (map3[v77] or 0) + 10
                              end

                              f30()
                            end

                            f16(false)
                            task.wait(0.2)
                          end
                        end
                      end
                    end
                  end
                end
              else
                task.wait(1)
              end
            end
          end
        end
      end
    end
  end)
end

do
  local function getModel()
    local character3 = localPlayer2.Character

    if not character3 then
      return nil
    end

    local humanoid5 = character3:FindFirstChildOfClass("Humanoid")

    if not humanoid5 or not humanoid5.SeatPart then
      return nil
    end

    return (humanoid5.SeatPart:FindFirstAncestorOfClass("Model"))
  end

  local function makeAttachment(instance9, p19, driveSpeed2)
    local primaryPart = instance9.PrimaryPart or instance9:FindFirstChildOfClass("BasePart")

    if not primaryPart then
      return
    end

    local cframe3 = CFrame.lookAt(
      primaryPart.Position, Vector3.new(p19.X, primaryPart.Position.Y, p19.Z)
    )

    pcall(function() instance9:PivotTo(cframe3) end)
    local instance10 = Instance.new("Attachment", primaryPart)

    local instance11 = Instance.new("LinearVelocity", primaryPart)
    instance11.Attachment0 = instance10
    instance11.VectorVelocity = cframe3.LookVector * driveSpeed2
    instance11.MaxForce = math.huge
    instance11.RelativeTo = Enum.ActuatorRelativeTo.World

    local instance12 = Instance.new("AlignOrientation", primaryPart)
    instance12.Attachment0 = instance10
    instance12.Mode = Enum.OrientationAlignmentMode.OneAttachment
    instance12.CFrame = cframe3
    instance12.MaxTorque = math.huge

    local v78 = (primaryPart.Position - p19).Magnitude / driveSpeed2
    local v79 = tick()

    while tick() - v79 < v78 and (autoDrive or v19) do
      if not localPlayer2.Character or not localPlayer2.Character:FindFirstChild("Humanoid")
        or not localPlayer2.Character.Humanoid.SeatPart then
        break
      end

      task.wait(0.05)
    end

    instance11:Destroy()
    instance12:Destroy()
    instance10:Destroy()

    primaryPart.AssemblyLinearVelocity = Vector3.zero
    primaryPart.AssemblyAngularVelocity = Vector3.zero
  end

  local function f46(p20)
    while true do
      local v80 = 0.1
      task.wait(v80)
      local v81 = p20

      if p20 then
        v80 = not v19
        v81 = v80
      end

      if v81 then
        break
      end

      if not p20 and not autoDrive then
        break
      end

      local model = getModel()

      if not model then
        task.wait(1)
      elseif not (model.PrimaryPart or model:FindFirstChildOfClass("BasePart")) then
        task.wait(1)
      else
        local v82 = vector
        local v83 = vector2

        if p20 then
          v82 = v82 + Vector3.new(0, 50, 0)
          v83 = v83 + Vector3.new(0, 50, 0)
        end

        pcall(function() model:PivotTo(CFrame.new(v82)) end)
        task.wait(0.2)

        if p20 and not v19 then
          break
        end

        if not p20 and not autoDrive then
          break
        end

        makeAttachment(model, v83, driveSpeed)
      end
    end
  end

  task.spawn(function()
    local flag12 = false
    local flag13 = false

    while true do
      task.wait(0.2)

      if autoDrive and not flag12 then
        flag12 = true
        task.spawn(function() f46(false) end)
      elseif not autoDrive then
        flag12 = false
      end

      if v19 and not flag13 then
        flag13 = true
        task.spawn(function() f46(true) end)
      elseif not v19 then
        flag13 = false
      end
    end
  end)

  task.spawn(function()
    while true do
      task.wait(5)

      if v15 then
        if tick() - v17 >= v16 then
          v17 = tick()
          f39()
        end
      end
    end
  end)

  local function f47()
    local list13 = {}
    local v84 = workspace:FindFirstChild("Game")
    local jobs = v84 and v84:FindFirstChild("Jobs")
    local delivery = jobs and jobs:FindFirstChild("Delivery")
    local deliveryLocations = delivery and delivery:FindFirstChild("DeliveryLocations")

    if deliveryLocations then
      for _, value57 in ipairs(deliveryLocations:GetChildren()) do
        table.insert(list13, value57)
      end
    end

    return list13
  end

  local deliveryLocationInteracted = remotes:WaitForChild("DeliveryLocationInteracted")

  local function f48()
    local list14 = {}
    local deliveryPickupItemsDeliveryLocation = workspace:FindFirstChild("DeliveryPickupItems_DeliveryLocation")

    if deliveryPickupItemsDeliveryLocation then
      for _, value58 in ipairs(deliveryPickupItemsDeliveryLocation:GetChildren()) do
        table.insert(list14, value58)
      end
    end

    return list14
  end

  local v85 = 1

  local function f49(list15)
    for _, value59 in ipairs(list15) do
      pcall(function()
        for _, value60 in ipairs(value59:GetDescendants()) do
          if value60:IsA("ProximityPrompt") and value60.Enabled then
            value60.MaxActivationDistance = 50
            value60.RequiresLineOfSight = false

            if fireproximityprompt then
              fireproximityprompt(value60)
            else
              task.spawn(function()
                value60:InputHoldBegin()
                task.wait((value60.HoldDuration or 0) + 0.15)
                value60:InputHoldEnd()
              end)
            end
          end
        end
      end)
    end
  end

  local function f50()
    local deliveryLocationEffects2 = workspace:FindFirstChild("DeliveryLocationEffects")
    local ring = deliveryLocationEffects2 and deliveryLocationEffects2:FindFirstChild("Ring")
    local v86 = ring and f38(ring)

    local ringGlow2 = deliveryLocationEffects2
      and deliveryLocationEffects2:FindFirstChild("RingGlow")

    local v87 = ringGlow2 and f38(ringGlow2)
    local findFirstChild7 = workspace:FindFirstChild("DeliveryTargetAnchor", true)
    local v88 = findFirstChild7 and f38(findFirstChild7)
    local v89, v90

    if v86 then
      v89 = ring
      v90 = v86
    elseif v87 then
      v90 = v87
      v89 = ringGlow2
    elseif v88 then
      v90 = v88
      v89 = findFirstChild7
    end

    if not v90 then
      return nil, nil
    end

    local huge2 = math.huge
    local v91

    for _, value61 in ipairs(f47()) do
      local v92 = f38(value61)

      if v92 then
        local magnitude3 = (v92 - v90).Magnitude

        if magnitude3 < huge2 then
          huge2 = magnitude3
          v91 = value61
        end
      end
    end

    return v91, v89
  end

  local function f51(list16, position4, p21)
    for _, value62 in ipairs(list16) do
      local v93 = f38(value62)

      if v93 and (position4 - v93).Magnitude <= p21 then
        return true
      end
    end

    return false
  end

  local function f52(p22)
    local character4 = localPlayer2.Character
    local humanoidRootPart7 = character4 and character4:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart7 then
      return false
    end

    local v94 = f38(p22)

    if not v94 then
      return false
    end

    if moveMethod == "Tween" then
      f13(v94, tweenSpeed)
    else
      humanoidRootPart7.CFrame = CFrame.new(v94 + Vector3.new(0, 3, 0))
    end

    return true
  end

  local function f53(list17, position5)
    local huge3 = math.huge
    local v95

    for _, value63 in ipairs(list17) do
      local v96 = f38(value63)

      if v96 then
        local magnitude4 = (position5 - v96).Magnitude

        if magnitude4 < huge3 then
          v95 = value63
          huge3 = magnitude4
        end
      end
    end

    return v95
  end

  local function f54()
    local character5 = localPlayer2.Character

    if not (character5 and character5:FindFirstChild("HumanoidRootPart")) then
      return
    end

    local v97 = tick()
    local v98 = #f48()
    local v99 = 0

    while autoDelivery do
      local v100 = f48()

      if #v100 == 0 then
        break
      end

      if tick() - v97 > 25 then
        break
      end

      local character6 = localPlayer2.Character
      local humanoidRootPart8 = character6 and character6:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart8 then
        break
      end

      if not f51(v100, humanoidRootPart8.Position, 10) then
        f52(f53(v100, humanoidRootPart8.Position) or v100[1])
        task.wait(0.5)
      end

      f49(v100)
      task.wait(0.5)
      local v101 = #f48()

      if v101 >= v98 then
        v99 = v99 + 1

        if v99 >= 4 then
          v99 = 0

          local humanoidRootPart9 = localPlayer2.Character
            and localPlayer2.Character:FindFirstChild("HumanoidRootPart")

          if humanoidRootPart9 then
            humanoidRootPart9.CFrame = humanoidRootPart9.CFrame * CFrame.new(50, 0, 0)
            task.wait(0.5)
            local v102 = f48()

            if #v102 > 0 then
              f52(f53(v102, humanoidRootPart9.Position) or v102[1])
              task.wait(0.5)
            end
          end
        end
      else
        v99 = 0
        v98 = v101
      end
    end
  end

  local function f55()
    local v103 = f47()

    if #v103 == 0 then
      return
    end

    local count2 = 0

    while autoDelivery and count2 < #v103 * 2 do
      local v104 = #f48() > 0
      local v105 = v104

      if not v104 then
        v104 = f37
        v105 = v104()
      end

      if v105 then
        break
      end

      count2 = count2 + 1
      v85 = v85 % #v103 + 1
      local v106 = v103[v85]

      if f52(v106) then
        task.wait(0.5)
        pcall(function() deliveryLocationInteracted:FireServer(v106) end)
        task.wait(0.5)
      end
    end
  end

  local flag14 = false
  local v107

  task.spawn(function()
    while true do
      task.wait(0.1)

      if autoDelivery then
        if not localPlayer2.Team or localPlayer2.Team.Name ~= "Delivery Driver" then
          pcall(function()
            requestStartJobSession:FireServer("Delivery", "jobPad", "HighRisk")
          end)

          task.wait(1)
        elseif #f48() > 0 then
          flag14 = false
          v107 = nil
          f54()
        elseif f37() then
          local v108, v109 = f50()

          if v108 and v109 then
            if v107 ~= v108 then
              flag14 = false
              v107 = v108
            end

            if not flag14 then
              local v110 = tick()

              while tick() - v110 < dropoffDelay do
                if not autoDelivery then
                  break
                end

                task.wait(0.1)
              end

              flag14 = true
            end

            if not pcall(function() f52(v109) end) then
              pcall(function() f52(v108) end)
            end

            local v111 = tick()

            while tick() - v111 < 0.5 do
              task.wait(0.1)
            end

            pcall(function() deliveryLocationInteracted:FireServer(v108) end)
            local v112 = tick()

            while tick() - v112 < 0.5 do
              task.wait(0.1)
            end
          end
        else
          flag14 = false
          v107 = nil
          f55()
        end
      end
    end
  end)
end
