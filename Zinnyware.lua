-- this is for Ghost Driver

local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local virtualUser = game:GetService("VirtualUser")
local players = game:GetService("Players")

if not LPH_OBFUSCATED then
  function LPH_JIT(p1)
    return p1
  end

  LPH_JIT_MAX = LPH_JIT

  function LPH_ENCSTR(p2)
    return p2
  end

  function LPH_ENCNUM(p3)
    return p3
  end
end

local localPlayer = players.LocalPlayer
local v1 = getgenv()

if v1.GHOSTFARM and v1.GHOSTFARM.Unload then
  pcall(v1.GHOSTFARM.Unload)
end

local function f1()
  for index, value in ipairs(workspace:GetChildren()) do
    if value:IsA("Model")
      and value.Name:sub(1, #localPlayer.Name + 1) == localPlayer.Name .. "_"
      and value:FindFirstChild("DriveSeat") then
      return value
    end
  end

  return nil
end

local getMapCacheFunc = replicatedStorage:WaitForChild("GetMapCacheFunc")
local v2 = {}

for key, value2 in pairs((getMapCacheFunc:InvokeServer())) do
  local waypoints = value2.Waypoints

  if waypoints and #waypoints > 1 then
    local v3 = { 0 }

    for i = 2, #waypoints do
      v3[i] = v3[i - 1] + (waypoints[i] - waypoints[i - 1]).Magnitude
    end

    v2[key] = { WP = waypoints, cum = v3, total = v3[#waypoints] }
  end
end

local lane2 = v2.Lane2 or select(2, next(v2))
local y = lane2.WP[1].Y

local function f2(p4, p5)
  local v4 = 1000000000000000000
  local v5 = 1

  for j = 1, #p4.WP do
    local magnitude = (p4.WP[j] - p5).Magnitude

    if magnitude < v4 then
      v5 = j
      v4 = magnitude
    end
  end

  return p4.cum[v5]
end

local function f3(p6, p7)
  local wp = p6.WP
  local cum = p6.cum
  local v6 = p7 % p6.total

  for k = 1, #wp - 1 do
    if v6 <= cum[k + 1] then
      local v7 = wp[k + 1] - wp[k]
      return wp[k] + v7 * ((v6 - cum[k]) / math.max(v7.Magnitude, 0.001)), v7.Unit
    end
  end

  return wp[#wp], (wp[#wp] - wp[#wp - 1]).Unit
end

local v8 = {
  enabled = false,
  farmMode = false,
  speed = 498,
  autoEnd = false,
  comboCap = 1000,
  maxSpeed = 490,
  fluctuate = false,
  flucAmp = 0.2,
  flucRate = 2.2,
  flucMult = 1,
  dodge = true,
  weaveAmp = 9,
  weaveFreq = 1.6,
  lookAhead = 260,
  reactDist = 90,
  swerve = 320,
  dist = 0,
  node = 1,
  curOffset = 0,
}

v1.GHOSTFARM = v8
local v9 = { -13.5, 0, 13.5 }
local trafficFolder = workspace:WaitForChild("TrafficFolder")

local function f4(p8, p9, p10)
  local v10 = { v8.lookAhead, v8.lookAhead, v8.lookAhead }

  for index2, value3 in ipairs(trafficFolder:GetChildren()) do
    local coreHitbox = value3:FindFirstChild("CoreHitbox")

    if coreHitbox then
      local v11 = coreHitbox.Position - p8
      local dot = v11:Dot(p9)

      if dot > -6 and dot < v8.lookAhead then
        local dot2 = v11:Dot(p10)

        for index3, value4 in ipairs(v9) do
          if math.abs(dot2 - value4) < 7 and dot < v10[index3] then
            v10[index3] = dot
          end
        end
      end
    end
  end

  local v12 = 2
  local v13 = 1000000000

  for m = 1, 3 do
    local v14 = math.abs(v9[m] - v8.curOffset)

    if v14 < v13 then
      v12 = m
      v13 = v14
    end
  end

  if v10[v12] >= v8.reactDist then
    return v9[v12]
  else
    local v15 = v12
    local v16 = v10[v12]

    for n = 1, 3 do
      if n ~= v12 then
        local v17 = true

        for i6 = math.min(v12, n) + 1, math.max(v12, n) - 1 do
          if v10[i6] < 70 then
            v17 = false
          end
        end

        if v17 and v10[n] > v16 + 15 then
          v16 = v10[n]
          v15 = n
        end
      end
    end

    return v9[v15]
  end
end

local inputHeartbeat
pcall(function() inputHeartbeat = require(replicatedStorage.Packages.Remotes).InputHeartbeat end)

local connect = localPlayer.Idled:Connect(function()
  pcall(function()
    virtualUser:CaptureController()
    virtualUser:ClickButton2(Vector2.new())
  end)
end)

local getQuestsByScope = replicatedStorage:FindFirstChild("GetQuestsByScope")
local claimQuestByScope = replicatedStorage:FindFirstChild("ClaimQuestByScope")

local function f5()
  if not getQuestsByScope or not claimQuestByScope then
    return
  end

  for index4, value5 in ipairs({ "Daily", "Weekly" }) do
    local v18 = value5
    local v19, v20 = pcall(function() return getQuestsByScope:InvokeServer(v18) end)

    if v19 and type(v20) == "table" and v20.Quests then
      for index5, value6 in ipairs(v20.Quests) do
        local v21 = value6

        if v21.Id and not v21.Claimed and (v21.Progress or 0) >= (v21.Max or 1) then
          pcall(function() claimQuestByScope:InvokeServer(v21.Id, v18) end)
        end
      end
    end
  end
end

local v22 = f1()
local connect2 = nil

local function f6()
  v8.enabled = false

  if connect2 then
    connect2:Disconnect()
    connect2 = nil
  end
end

local function f7()
  if v8.enabled then
    return
  end

  v22 = f1()

  if not v22 then
    return
  end

  v8.dist = f2(lane2, v22:GetPivot().Position)
  v8.enabled = true

  task.spawn(f5)
  local v23 = os.clock()

  connect2 = runService.RenderStepped:Connect(LPH_JIT(function(p11)
    if not v8.enabled then
      return
    end

    if not v22 or not v22.Parent then
      v22 = f1()

      if not v22 then
        return
      end
    end

    local v24 = math.min(v8.speed, v8.maxSpeed)
    local v25 = nil

    if v8.fluctuate then
      local v26 = os.clock()
      local v27 = math.sin(v26 * v8.flucRate)
      local v28 = math.sin(v26 * v8.flucRate * 2.7)
      v25 = v24 * (1 - v8.flucAmp * (0.7 * (0.5 - 0.5 * v27) + 0.3 * (0.5 - 0.5 * v28)))
    else
      v25 = v24
    end

    v8.flucMult = v25 / math.max(v8.speed, 1)
    v8.dist = v8.dist + v25 * p11

    local v29, v30 = f3(lane2, v8.dist)
    local cross = v30:Cross(Vector3.new(0, 1, 0))
    local unit

    if cross.Magnitude > 0.001 then
      unit = cross.Unit
    else
      unit = Vector3.new(1, 0, 0)
    end

    local vector = Vector3.new(v29.X, y, v29.Z)
    local v31

    if v8.dodge then
      v31 = f4(vector, v30, unit)
    else
      v31 = math.sin((os.clock() - v23) * v8.weaveFreq * math.pi * 2) * v8.weaveAmp
    end

    local v32 = v8.swerve * p11
    v8.curOffset = v8.curOffset + math.clamp(v31 - v8.curOffset, -v32, v32)
    v22:PivotTo(CFrame.lookAlong(vector + unit * v8.curOffset, v30))
    pcall(function() v22.DriveSeat.AssemblyLinearVelocity = v30 * v25 end)
  end))
end

function v8.start()
  v8.farmMode = true
  f7()
end

function v8.stop()
  v8.farmMode = false
  f6()
end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()
library.Scheme.BackgroundColor = Color3.fromRGB(15, 15, 15)
library.Scheme.MainColor = Color3.fromRGB(22, 22, 22)
library.Scheme.AccentColor = Color3.fromRGB(20, 160, 70)
library.Scheme.OutlineColor = Color3.fromRGB(32, 32, 32)
library.Scheme.FontColor = Color3.fromRGB(235, 235, 235)

pcall(function() library:UpdateColorsUsingRegistry() end)

local addLeftGroupbox = library:CreateWindow({
  Title = "Zinnyware",
  Footer = "key system",
  Icon = "lock",
  NotifySide = "Right",
  ShowCustomCursor = true,
  Center = true,
  AutoShow = true,
  Resizable = false,
  CornerRadius = 6,
}):AddTab(
  "Key", "key-round"
):AddLeftGroupbox(
  "Authentication", "lock"
)

local addInput = addLeftGroupbox:AddInput("ZW_Key", {
  Text = "Key",
  Placeholder = "Enter your key",
  ClearTextOnFocus = false,
})

local v33 = false

addLeftGroupbox:AddButton({
  Text = "Check Key",
  Func = function()
    if (addInput.Value or "") == "weback" then
      pcall(function() writefile("ZinnywareGhost/key.txt", "weback") end)
      library:Notify({ Title = "Zinnyware", Description = "Key accepted — loading.", Time = 3 })
      v33 = true
    else
      library:Notify({ Title = "Zinnyware", Description = "Invalid key.", Time = 3 })
    end
  end,
})

addLeftGroupbox:AddButton({
  Text = "Join Discord",
  Func = function()
    pcall(function() setclipboard("https://discord.gg/xrrpdPMVpQ") end)

    library:Notify({
      Title = "Zinnyware",
      Description = "Discord invite copied to clipboard.",
      Time = 3,
    })
  end,
})

repeat
  task.wait()
until v33

pcall(function() library:Unload() end)
local library2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()
local themeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/addons/ThemeManager.lua"))()
local saveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/addons/SaveManager.lua"))()

local zinnywareWindow = library2:CreateWindow({
  Title = "Zinnyware",
  Footer = "ghost driver • traffic farm",
  Icon = "zap",
  NotifySide = "Right",
  ShowCustomCursor = true,
  Resizable = true,
  AlwaysOnTop = true,
  CornerRadius = 6,
  Center = true,
  AutoShow = true,
  ToggleKeybind = Enum.KeyCode.RightShift,
})

library2.Scheme.BackgroundColor = Color3.fromRGB(15, 15, 15)
library2.Scheme.MainColor = Color3.fromRGB(22, 22, 22)
library2.Scheme.AccentColor = Color3.fromRGB(20, 160, 70)
library2.Scheme.OutlineColor = Color3.fromRGB(32, 32, 32)
library2.Scheme.FontColor = Color3.fromRGB(235, 235, 235)

pcall(function() library2:UpdateColorsUsingRegistry() end)
local addTab = zinnywareWindow:AddTab("Farm", "car")
local addTab2 = zinnywareWindow:AddTab("Config", "settings")
local addLeftGroupbox2 = addTab:AddLeftGroupbox("Auto Farm", "gauge")
local addRightGroupbox = addTab:AddRightGroupbox("Stats", "chart-line")

addLeftGroupbox2:AddToggle("GF_Enabled", {
  Text = "Auto Farm",
  Default = false,
  Tooltip = "Drive + weave through traffic for XP/cash",
  Callback = function(value7)
    v8.farmMode = value7

    if value7 then
      f7()
    else
      f6()
    end
  end,
}):AddKeyPicker("GF_FarmKey", {
  Default = "RightShift",
  Mode = "Toggle",
  Text = "Auto Farm",
  SyncToggleState = true,
})

addLeftGroupbox2:AddToggle("GF_Dodge", {
  Text = "Dodge Traffic",
  Default = true,
  Tooltip = "Auto-pick the clear lane",
  Callback = function(value8) v8.dodge = value8 end,
})

addLeftGroupbox2:AddSlider("GF_Speed", {
  Text = "Speed",
  Default = 498,
  Min = 110,
  Max = 800,
  Rounding = 0,
  Suffix = " studs/s",
  Callback = function(value9) v8.speed = value9 end,
})

addLeftGroupbox2:AddSlider("GF_Look", {
  Text = "Look Ahead",
  Default = 220,
  Min = 60,
  Max = 400,
  Rounding = 0,
  Suffix = " studs",
  Callback = function(value10) v8.lookAhead = value10 end,
})

addLeftGroupbox2:AddSlider("GF_React", {
  Text = "React Distance",
  Default = 90,
  Min = 30,
  Max = 250,
  Rounding = 0,
  Suffix = " studs",
  Tooltip = "Switch lanes when a car is this close",
  Callback = function(value11) v8.reactDist = value11 end,
})

addLeftGroupbox2:AddSlider("GF_Swerve", {
  Text = "Swerve Speed",
  Default = 320,
  Min = 60,
  Max = 600,
  Rounding = 0,
  Suffix = " studs/s",
  Callback = function(value12) v8.swerve = value12 end,
})

addLeftGroupbox2:AddToggle("GF_Fluctuate", {
  Text = "Fluctuate Speed",
  Default = false,
  Tooltip = "Varies speed so cash keeps flowing",
  Callback = function(value13) v8.fluctuate = value13 end,
})

addLeftGroupbox2:AddSlider("GF_FlucAmp", {
  Text = "Fluctuation",
  Default = 20,
  Min = 5,
  Max = 60,
  Rounding = 0,
  Suffix = "%",
  Callback = function(value14) v8.flucAmp = value14 / 100 end,
})

addLeftGroupbox2:AddToggle("GF_AutoEnd", {
  Text = "Cap Combo",
  Default = false,
  Tooltip = "Reset combo at the cap, keep farming",
  Callback = function(value15) v8.autoEnd = value15 end,
})

addLeftGroupbox2:AddSlider("GF_ComboCap", {
  Text = "Combo Cap",
  Default = 1000,
  Min = 50,
  Max = 5000,
  Rounding = 0,
  Callback = function(value16) v8.comboCap = value16 end,
})

addLeftGroupbox2:AddSlider("GF_Weave", {
  Text = "Weave",
  Default = 9,
  Min = 0,
  Max = 14,
  Rounding = 0,
  Suffix = " studs",
  Tooltip = "Blind weave size when Dodge is off",
  Callback = function(value17) v8.weaveAmp = value17 end,
})

local addLabel = addRightGroupbox:AddLabel("start the farm...", true)
local v34 = true
local v35

task.spawn(function()
  local count = 0
  local v36 = 0
  local v37 = 0
  local v38

  while v34 do
    task.wait(0.5)
    local value18 = localPlayer:FindFirstChild("XP") and localPlayer.XP.Value or 0
    local value19 = localPlayer:FindFirstChild("MaxXP") and localPlayer.MaxXP.Value
    local leaderstats = localPlayer:FindFirstChild("leaderstats")
    local v39 = value19 or 0
    local value20 = leaderstats and localPlayer.leaderstats.Cash.Value or 0

    local value21 = localPlayer:FindFirstChild("leaderstats")
        and localPlayer.leaderstats.Level.Value
      or 0

    if v8.enabled and v8.autoEnd and 0 >= v8.comboCap then
      pcall(function()
        if v35 and v35.ResetComboState then
          v35:ResetComboState()
        end
      end)
    end

    if v8.farmMode and not v8.enabled then
      f7()
    end

    if v38 then
      local v40 = value18 - v38

      if v40 >= 0 then
        v36 = v36 + v40
      end
    end

    v38 = value18
    count = count + 1

    if count % 2 == 0 then
      v37 = v36
      v36 = 0
    end

    addLabel:SetText(([[
%s
Level %d
XP %d / %d
Cash %s
Combo %d
XP/sec ~ %d]]):format(v8.enabled
        and "FARMING"
      or "stopped", value21, value18, v39, tostring(value20), 0, v37))
  end
end)

task.spawn(function()
  while v34 do
    task.wait(4)

    if inputHeartbeat then
      pcall(function() inputHeartbeat:FireServer() end)
    end
  end
end)

addTab2:AddLeftGroupbox("Menu", "power"):AddButton({
  Text = "Unload",
  Risky = true,
  Tooltip = "Stop all + close UI",
  Func = function()
    task.defer(function()
      if v8.Unload then
        v8.Unload()
      end
    end)
  end,
})

themeManager:SetLibrary(library2)

saveManager:SetLibrary(library2)
saveManager:IgnoreThemeSettings()
saveManager:SetIgnoreIndexes({ "GF_FarmKey" })

themeManager:SetFolder("ZinnywareGhost")

saveManager:SetFolder("ZinnywareGhost")
saveManager:SetSubFolder("configs")
saveManager:BuildConfigSection(addTab2)

themeManager:ApplyToTab(addTab2)
saveManager:LoadAutoloadConfig()

function v8.Unload()
  v34 = false
  v8.farmMode = false
  pcall(function() connect:Disconnect() end)

  function v816()
    library2:Unload()
  end

  f6()
  v1.GHOSTFARM = nil
end

pcall(function() library2:OnUnload(function() v8.Unload() end) end)

library2:Notify({
  Title = "Zinnyware",
  Description = "Loaded. Sit in your car, flip Auto farm (RightShift).",
  Time = 5,
})
