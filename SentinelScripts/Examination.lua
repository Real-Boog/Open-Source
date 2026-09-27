local players = game:GetService("Players")
local lighting = game:GetService("Lighting")
local replicatedStorage = game:GetService("ReplicatedStorage")
local tweenService = game:GetService("TweenService")
local workspaceService = game:GetService("Workspace")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local debris = game:GetService("Debris")
local textChatService = game:GetService("TextChatService")
local coreGui = game:GetService("CoreGui")
local teams = game:GetService("Teams")
local virtualInputManager = game:GetService("VirtualInputManager")
local badgeService = game:GetService("BadgeService")
local proximityPromptService = game:GetService("ProximityPromptService")
local soundService = game:GetService("SoundService")
local guiService = game:GetService("GuiService")
local starterGui = game:GetService("StarterGui")
local localPlayer = players.LocalPlayer
local currentCamera = workspace.CurrentCamera
SentinelActive = true
SentinelLastInteraction = tick()
noclipConnection = nil
local hookFunction = type(hookfunction) == "function"
local hookMetamethod = type(hookmetamethod) == "function"
local newCClosure = type(newcclosure) == "function"
local getRawMetatable = type(getrawmetatable) == "function"
local setReadonly = type(setreadonly) == "function"
local cloneFunction = type(clonefunction) == "function"

Capabilities = {
  HookFunction = hookFunction,
  HookMetamethod = hookMetamethod,
  NewCClosure = newCClosure,
  GetRawMetatable = getRawMetatable,
  SetReadonly = setReadonly,
  CloneFunction = cloneFunction,
  Drawing = type(Drawing) == "table" and type(Drawing.new) == "function",
  FireProximityPrompt = type(fireproximityprompt) == "function",
  FireClickDetector = type(fireclickdetector) == "function",
  GetCustomAsset = type(getcustomasset) == "function",
  IsFile = type(isfile) == "function",
  WriteFile = type(writefile) == "function",
  ReadFile = type(readfile) == "function",
  Request = type(request) == "function" or type(http_request) == "function",
  LoadString = type(loadstring) == "function",
  SetClipboard = type(setclipboard) == "function",
  IdentifyExecutor = type(identifyexecutor) == "function",
}

local capabilities = Capabilities

capabilities.Hooks = Capabilities.HookFunction and Capabilities.NewCClosure
  and Capabilities.GetRawMetatable and Capabilities.SetReadonly

local capabilities2 = Capabilities
capabilities2.SilentAim = Capabilities.Hooks and Capabilities.CloneFunction

SentinelHookSupported = Capabilities.Hooks
SentinelMissingFeatures = {}
SentinelLimitedExecutor = #SentinelMissingFeatures > 0
SentinelExecutorName = "Unknown"
local v1 = identifyexecutor

if type(v1) == "function" then
  local v2 = v1()

  if type(v2) == "string" and #v2 > 0 then
    SentinelExecutorName = v2
  end
elseif syn then
  SentinelExecutorName = "Synapse X"
elseif KRNL_LOADED then
  SentinelExecutorName = "KRNL"
elseif getexecutorname then
  SentinelExecutorName = "Script-Ware"
elseif IsElectron == true then
  SentinelExecutorName = "Electron"
elseif FLUXUS_LOADED then
  SentinelExecutorName = "Fluxus"
elseif hookfunction_raw and hmjdfk then
  SentinelExecutorName = "Fluxus (Mac)"
elseif shadow_env then
  SentinelExecutorName = "Shadow"
elseif is_sirhurt_closure then
  SentinelExecutorName = "SirHurt"
elseif WRDAPI then
  SentinelExecutorName = "WeAreDes"
elseif SENTINEL_LOADED then
  SentinelExecutorName = "Sentinel"
elseif PROTOSMASHER_LOADED then
  SentinelExecutorName = "Protosmasher"
elseif isvm then
  SentinelExecutorName = "Proxo"
elseif IS_VIVA_LOADED then
  SentinelExecutorName = "Viva"
elseif jit then
  SentinelExecutorName = "EasyExploits"
elseif CalamariLuaEnv then
  SentinelExecutorName = "Calamari"
elseif unit then
  SentinelExecutorName = "Unit"
end

SentinelDeviceType = "PC"

if syn and syn.getplatform then
  local v3 = syn.getplatform()

  if v3 == "UWP" then
    SentinelDeviceType = "UWP"
  elseif v3 == "Android" then
    SentinelDeviceType = "Mobile"
  end
elseif KRNL_LOADED and type(KRNL_LOADED) == "table" and KRNL_LOADED.Platform then
  if KRNL_LOADED.Platform == "UWP" then
    SentinelDeviceType = "UWP"
  end
elseif game and userInputService.TouchEnabled and not userInputService.MouseEnabled then
  SentinelDeviceType = "Mobile"
end

SentinelAccountAge = "Unknown"

if localPlayer and localPlayer.AccountAge then
  SentinelAccountAge = tostring(localPlayer.AccountAge) .. " days"
end

SentinelUserName = localPlayer and localPlayer.Name or "Unknown"
SentinelLoadStart = os.clock()

local function f1()
  local function f2(p1)
    local v4, v5 = pcall(p1)
    return v4 and v5 ~= nil
  end

  local function f3(p2, p3)
    print((f2(p3) and "✅ " or "❌ ") .. "| " .. p2)
  end

  print("\n============ Sentinel UNC Test ============")

  f3("hookmetamethod", function() return hookmetamethod ~= nil end)
  f3("hookfunction", function() return hookfunction ~= nil end)
  f3("getnamecallmethod", function() return getnamecallmethod ~= nil end)
  f3("newcclosure", function() return newcclosure ~= nil end)
  f3("getfenv", function() return getfenv ~= nil end)
  f3("setfenv", function() return setfenv ~= nil end)
  f3("Drawing.new", function() return Drawing and Drawing.new ~= nil end)
  f3("getrawmetatable", function() return getrawmetatable ~= nil end)
  f3("setreadonly", function() return setreadonly ~= nil end)
  f3("getrenv", function() return getrenv ~= nil end)
  f3("identifyexecutor", function() return identifyexecutor ~= nil end)
  f3("setfpscap", function() return setfpscap ~= nil end)
  f3("fireclickdetector", function() return fireclickdetector ~= nil end)
  f3("fireproximityprompt", function() return fireproximityprompt ~= nil end)
  f3("request/http", function() return request ~= nil or http_request ~= nil end)
  f3("cloneref", function() return cloneref ~= nil end)
  f3("clonefunction", function() return clonefunction ~= nil end)
  f3("loadstring", function() return loadstring ~= nil end)
  f3("getcustomasset", function() return getcustomasset ~= nil end)
  f3("isfile", function() return isfile ~= nil end)

  print([[
===========================================
]])
end

function isPlayerCharacter(p4)
  if not p4 or not p4:IsA("Model") then
    return false
  end

  return players:GetPlayerFromCharacter(p4) ~= nil
end

function isHumanoidModel(p5)
  if not p5 or not p5:IsA("Model") then
    return false
  end

  return p5:FindFirstChildWhichIsA("Humanoid") ~= nil
end

function isMobModel(p6)
  if not p6 then
    return false
  else
    local characters = workspaceService:FindFirstChild("Characters")

    if characters and p6:IsDescendantOf(characters) then
      return true
    end

    return false
  end
end

function hideLocalHead()
  local character = localPlayer.Character

  if not character then
    return
  end

  local head = character:FindFirstChild("Head")

  if head and head:IsA("BasePart") then
    pcall(function()
      head.Transparency = 1
      head.CanCollide = false

      local highlight = head:FindFirstChildWhichIsA("Highlight")

      if highlight then
        highlight:Destroy()
      end
    end)
  end
end

localPlayer.CharacterAdded:Connect(function(character2)
  character2:WaitForChild("Head", 5)
  hideLocalHead()
end)

if localPlayer.Character then
  task.wait(0.5)
  hideLocalHead()
end

Config = {
  SpeedHackEnabled = false,
  WalkSpeedValue = 9,
  InfiniteStaminaEnabled = false,
  JumpPowerEnabled = false,
  JumpPowerValue = 15,
  InfiniteJump = false,
  JumpBypassActive = false,
  FlyEnabled = false,
  FlySpeed = 25,
  NoclipEnabled = false,
  AutoWipeBlood = false,
  AntiCamShake = false,
  ImmuneLookHazard = false,
  HighlightPlayer = false,
  HighlightFriends = false,
  HighlightMobs = false,
  HighlightBosses = false,
  HealthPlayer = false,
  HealthFriends = false,
  HealthMobs = false,
  HealthBosses = false,
  TracerPlayer = false,
  TracerFriends = false,
  TracerMobs = false,
  TracerBosses = false,
  ColorPlayer = Color3.fromRGB(0, 255, 0),
  ColorFriends = Color3.fromRGB(173, 216, 230),
  ColorMobs = Color3.fromRGB(255, 165, 0),
  ColorBosses = Color3.fromRGB(255, 0, 0),
  MaxDistance = 1000,
  HLFillTrans = 0.7,
  HLOutlineTrans = 1,
  FullBright = false,
  Xray = false,
  XrayDistance = 30,
  NoFog = false,
  UnlockThirdPerson = false,
  FakeDeath = false,
  FakeInjured = false,
  InfiniteNightVision = false,
  SilencerEnabled = false,
  CharacterName = "",
  CharacterRank = "",
  TagColor = Color3.fromRGB(80, 109, 84),
  Team = "Menlo",
  StaggerEnabled = true,
  InfectionActive = false,
  AnimatorEnabled = false,
  AnimatorIdleAnimName = nil,
  AnimatorWalkAnimName = nil,
  AnimatorRunAnimName = nil,
  RemoveDeathScreen = false,
  AntiAFKEnabled = false,
  ChatLoggerEnabled = false,
  CustomFOVEnabled = false,
  FOVValue = 70,
  Theme = "Amber",
  MinimizeKeybind = "K",
  XrayMaterial = "ForceField",
  XrayTransparency = 0.3,
  InstantProximityPrompt = false,
  AutoCompleteProximityPrompt = false,
  StaggerImmune = false,
  AntiAnchorEnabled = false,
  AutoQTEEnabled = false,
  AutoQTEPlatform = "PC",
  AutoQTEReactionSpeed = 12,
  NightStalkerInfAmmo = false,
  AutoReload = false,
  FastReload = false,
  FastReloadBoosts = { "+100%", "+200%", "+150%" },
  InstantShotgunReload = false,
  NotificationSound = "",
  NetworkBypassEnabled = false,
  ActiveBypasses = {},
  BoxThickness = 2,
  BoxAutoThickness = true,
  BoxSize = 4,
  BoxPlayers = false,
  BoxFriends = false,
  BoxMobs = false,
  BoxBosses = false,
  ShowNamePlayers = false,
  ShowNameFriends = false,
  ShowNameMobs = false,
  ShowNameBosses = false,
  ShowHealthPlayers = false,
  ShowHealthFriends = false,
  ShowHealthMobs = false,
  ShowHealthBosses = false,
  ShowDistancePlayers = false,
  ShowDistanceFriends = false,
  ShowDistanceMobs = false,
  ShowDistanceBosses = false,
  SilentAimEnabled = false,
  SilentAimWallCheck = true,
  SilentAimTargetPart = "Head",
  SilentAimFOVMode = "Mouse",
  SilentAimShowFOV = false,
  SilentAimFOVRadius = 200,
  SilentAimFOVColor = Color3.fromRGB(0, 255, 100),
  SilentAimFOVNoTargetColor = Color3.fromRGB(255, 60, 60),
  BulletVisualizerEnabled = false,
  BulletVisualizerColorMissed = Color3.fromRGB(220, 30, 30),
  BulletVisualizerColorSuccess = Color3.fromRGB(0, 255, 80),
  BulletVisualizerColorLoading = Color3.fromRGB(255, 200, 0),
  BulletVisualizerLifetime = 3,
  BulletVisualizerFadeOut = 0.8,
  BulletVisualizerThickness = 0.09,
  BulletVisualizerRange = 500,
  AutoBringAxe = false,
  AutoBringHammer = false,
  AntiRiserDodgeEnabled = false,
  ViewModelEnabled = false,
  ViewModelColor = Color3.fromRGB(255, 255, 255),
  ViewModelMaterial = "ForceField",
  CustomWeaponsEnabled = false,
  CustomWeaponsColor = Color3.fromRGB(255, 255, 255),
  CustomWeaponsMaterial = "ForceField",
}

local v6 = {
  Plastic = Enum.Material.Plastic,
  Neon = Enum.Material.Neon,
  ForceField = Enum.Material.ForceField,
  Glass = Enum.Material.Glass,
  SmoothPlastic = Enum.Material.SmoothPlastic,
  Metal = Enum.Material.Metal,
  Ice = Enum.Material.Ice,
  Marble = Enum.Material.Marble,
  Granite = Enum.Material.Granite,
  Concrete = Enum.Material.Concrete,
  Brick = Enum.Material.Brick,
  Fabric = Enum.Material.Fabric,
  Wood = Enum.Material.Wood,
  DiamondPlate = Enum.Material.DiamondPlate,
  Foil = Enum.Material.Foil,
  CorrodedMetal = Enum.Material.CorrodedMetal,
  Grass = Enum.Material.Grass,
  Sand = Enum.Material.Sand,
  Slate = Enum.Material.Slate,
  Carpet = Enum.Material.Carpet,
  Leather = Enum.Material.Leather,
  Plaster = Enum.Material.Plaster,
  Rubber = Enum.Material.Rubber,
}

local function f4(p7)
  return v6[p7] or Enum.Material.ForceField
end

local values = {
  "Plastic", "Neon", "ForceField", "Glass", "SmoothPlastic", "Metal", "Ice", "Marble",
  "Granite", "Concrete", "Brick", "Fabric", "Wood", "DiamondPlate", "Foil", "CorrodedMetal",
  "Grass", "Sand", "Slate", "Carpet", "Leather", "Plaster", "Rubber",
}

local v7 = {}
local v8 = {}

local function f5(p8)
  if not p8 or not p8:IsA("Tool") then
    return
  end

  for index, value in ipairs(p8:GetDescendants()) do
    local v9 = value

    if v9:IsA("BasePart") then
      if not v8[v9] then
        v8[v9] = { Color = v9.Color, Material = v9.Material, Transparency = v9.Transparency }
      end

      pcall(function() v9.Color = Config.ViewModelColor end)
      pcall(function() v9.Material = f4(Config.ViewModelMaterial) end)
    end
  end
end

local function f6(p9)
  if not p9 then
    return
  end

  if not (p9:IsA("BasePart") or p9:IsA("MeshPart")) then
    return
  else
    local name = p9.Name

    if name ~= "Left Arm" and name ~= "Right Arm" then
      return
    end

    if not v8[p9] then
      v8[p9] = { Color = p9.Color, Material = p9.Material, Transparency = p9.Transparency }
    end

    pcall(function() p9.Color = Config.ViewModelColor end)
    pcall(function() p9.Material = f4(Config.ViewModelMaterial) end)
    pcall(function() p9.Transparency = 0 end)

    return
  end
end

local function f7(p10)
  if not p10 or not p10:IsA("Tool") then
    return
  end

  for index2, value2 in ipairs(p10:GetDescendants()) do
    local v10 = value2

    if v10:IsA("BasePart") then
      if not v7[v10] then
        v7[v10] = {
          Color = v10.Color,
          Material = v10.Material,
          Transparency = v10.Transparency,
          RemovedChildren = {},
        }

        for index3, value3 in ipairs(v10:GetChildren()) do
          if value3:IsA("SurfaceAppearance") or value3:IsA("Decal") or value3:IsA("Texture") then
            table.insert(v7[v10].RemovedChildren, value3)
            value3.Parent = nil
          end
        end
      end

      pcall(function() v10.Color = Config.CustomWeaponsColor end)
      pcall(function() v10.Material = f4(Config.CustomWeaponsMaterial) end)
    end
  end
end

local v11 = { "Radaways1", "Radaways2" }
local vector = Vector3.new(1, 0, 0)
local vector2 = Vector3.new(-1, 0, 0)
local vector3 = Vector3.new(0, 0, 1)
local vector4 = Vector3.new(0, 0, -1)
local vector5 = Vector3.new(0, 1, 0)
local vector6 = Vector3.new(1, 0, 1)

local function f8(p11)
  local character3 = localPlayer.Character

  if not character3 then
    return false
  elseif character3:FindFirstChild(p11) then
    return true
  else
    local backpack = localPlayer:FindFirstChild("Backpack")

    if backpack and backpack:FindFirstChild(p11) then
      return true
    end

    return false
  end
end

local v12 = {
  vector, vector2, vector3, vector4, vector5, vector6, Vector3.new(-1, 0, -1),
  Vector3.new(1, 0, -1), Vector3.new(-1, 0, 1),
}

local function f9(...)
  print("[Radaway-DEBUG]", ...)
end

local function f10(p12)
  if not p12 then
    return nil
  end

  return p12:FindFirstChild("HumanoidRootPart") or p12:FindFirstChild("Torso")
    or p12:FindFirstChild("UpperTorso") or p12:FindFirstChild("LowerTorso") or p12.PrimaryPart
end

local function f11(p13)
  if not p13 then
    return false
  elseif p13.Y < -500 then
    return false
  elseif math.abs(p13.X) > 10000 then
    return false
  else
    if math.abs(p13.Z) > 10000 then
      return false
    end

    return true
  end
end

local function f12(p14)
  if not p14 then
    f9("isValid: nil radaway")
    return false
  elseif not p14.Parent then
    f9("isValid: radaway.Parent is nil")
    return false
  else
    local humanoid = p14:FindFirstChildOfClass("Humanoid")

    if not humanoid then
      f9("isValid: no Humanoid on " .. tostring(p14.Name))
      return false
    elseif humanoid.Health <= 0 then
      f9("isValid: dead Humanoid on " .. tostring(p14.Name) .. " (hp=" .. humanoid.Health .. ")")
      return false
    else
      local v13 = f10(p14)

      if not v13 then
        f9("isValid: no root on " .. tostring(p14.Name))
        return false
      end

      if not f11(v13.Position) then
        f9("isValid: invalid position on " .. tostring(p14.Name) .. " pos="
          .. tostring(v13.Position))

        return false
      end

      return true
    end
  end
end

local function f13()
  local characters2 = workspace:FindFirstChild("Characters")

  if not characters2 then
    f9("find: no Characters folder")
    return nil
  end

  for index4, value4 in ipairs(v11) do
    local findFirstChild = characters2:FindFirstChild(value4)

    if findFirstChild then
      if f12(findFirstChild) then
        return findFirstChild
      end
    end
  end

  return nil
end

local f14

local function f15(p15, p16, p17)
  for index5, value5 in ipairs(v12) do
    local v14 = p15 + value5.Unit * 5

    if f14(v14, p16, { p17 }) then
      return v14
    end
  end

  return p15 + Vector3.new(0, 3, 0)
end

function f14(p18, p19, p20)
  if not p19 then
    return false
  else
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude

    local v15 = { p19, currentCamera }

    if p20 then
      for index6, value6 in ipairs(p20) do
        table.insert(v15, value6)
      end
    end

    raycastParams.FilterDescendantsInstances = v15
    raycastParams.IgnoreWater = true

    if not workspace:Raycast(p18, Vector3.new(0, -6, 0), raycastParams) then
      return false
    else
      local raycast = workspace:Raycast(p18, Vector3.new(0, 6, 0), raycastParams)

      if raycast and raycast.Distance < 5 then
        return false
      end

      return true
    end
  end
end

RadawayState = {
  active = false,
  originalCFrame = nil,
  radaway = nil,
  startHp = nil,
  successNotified = false,
}

local function f16(p21, p22, p23)
  if not p21 or not p22 then
    return false
  else
    local humanoidRootPart = p21:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart then
      return false
    else
      local position = humanoidRootPart.Position
      pcall(function() p21:PivotTo(p22) end)
      task.wait(0.05)
      local humanoidRootPart2 = p21:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart2 then
        return false
      else
        local position2 = humanoidRootPart2.Position

        f9("pivot[" .. tostring(p23) .. "]: before=" .. tostring(position) .. " target="
          .. tostring(p22.Position) .. " after=" .. tostring(position2))

        if not f11(position2) then
          f9("pivot[" .. tostring(p23) .. "]: VOID DETECTED -> reverting")

          if RadawayState.originalCFrame then
            pcall(function() p21:PivotTo(RadawayState.originalCFrame) end)
          end

          return false
        else
          local magnitude = (position2 - p22.Position).Magnitude

          if magnitude > 50 then
            f9("pivot[" .. tostring(p23) .. "]: REJECTED BY GAME (drift "
              .. string.format("%.1f", magnitude) .. " studs)")

            return false
          end

          return true
        end
      end
    end
  end
end

local f17

local function f18()
  RadawayState.active = false
  RadawayState.radaway = nil
  RadawayState.originalCFrame = nil
  RadawayState.startHp = nil
  RadawayState.successNotified = false

  f9("=== START ===")
  local character4 = localPlayer.Character

  if not character4 then
    f9("start: no character")
    return
  else
    local humanoid2 = character4:FindFirstChildOfClass("Humanoid")

    if not humanoid2 then
      f9("start: no humanoid")
      return
    else
      local humanoidRootPart3 = character4:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart3 then
        f9("start: no hrp")
        return
      else
        f9("start: HP=" .. humanoid2.Health .. " pos=" .. tostring(humanoidRootPart3.Position))

        pcall(function()
          if WindUI then
            WindUI:Notify({
              Title = "Get Infected",
              Content = "Waiting for the server",
              Icon = "cloud-backup",
              Duration = 17,
            })
          end
        end)

        local v16 = tick()
        local v17 = nil
        local count = 0

        while tick() - v16 < 15 do
          if not SentinelActive then
            f9("start: SentinelActive false, aborting")
            return
          else
            count = count + 1
            local v18 = f13()

            if v18 then
              v17 = v18
              f9("start: found valid radaway on attempt " .. count)
              break
            end

            if count % 4 == 1 then
              f9("start: search attempt " .. count .. " - no valid radaway yet")
            end

            task.wait(0.5)
          end
        end

        if not v17 then
          f9("start: timed out, no radaway found")

          pcall(function()
            if WindUI then
              WindUI:Notify({
                Title = "Get Infected",
                Content = 'The "Get Infected" function is not available on this server; wait a few minutes or switch servers.',
                Icon = "cloud-alert",
                Duration = 8,
              })
            end
          end)

          return
        end

        pcall(function()
          if WindUI then
            WindUI:Notify({
              Title = "Get Infected",
              Content = [[
The infectious phase is beginning.
sit tight, Sentinel is working on your infection...]],
              Icon = "cloud-check",
              Duration = 6,
            })
          end
        end)

        RadawayState.active = true
        RadawayState.originalCFrame = humanoidRootPart3.CFrame
        RadawayState.radaway = v17
        RadawayState.startHp = humanoid2.Health
        RadawayState.successNotified = false

        f9("start: launching follow loop, origin="
          .. tostring(RadawayState.originalCFrame.Position))

        task.spawn(f17)
        return
      end
    end
  end
end

function f17()
  local count2 = 0
  local vector7

  while true do
    local v19 = "active"
    local v20 = RadawayState[v19]
    local v21 = v20

    if v20 then
      v19 = false
      v21 = SentinelActive ~= v19
    end

    if v21 then
      count2 = count2 + 1
      local v22 = f13()

      if not v22 then
        if count2 % 10 == 1 then
          f9("follow[" .. count2 .. "]: no valid radaway, waiting...")
        end

        task.wait(0.2)
      else
        RadawayState.radaway = v22
        local v23 = f10(v22)

        if not v23 then
          task.wait(0.2)
        else
          local character5 = localPlayer.Character

          if not character5 then
            f9("follow: character is nil, breaking")
            break
          else
            local humanoidRootPart4 = character5:FindFirstChild("HumanoidRootPart")
            local humanoid3 = character5:FindFirstChildOfClass("Humanoid")

            if not humanoidRootPart4 or not humanoid3 then
              f9("follow: no myHrp or myHum, breaking")
              break
            end

            if not f11(humanoidRootPart4.Position) then
              f9("follow: MY character is in the void! reverting")

              if RadawayState.originalCFrame then
                pcall(function() character5:PivotTo(RadawayState.originalCFrame) end)
              end

              task.wait(0.5)
            end

            if humanoid3.Health <= 10 then
              if not RadawayState.successNotified and RadawayState.startHp
                and RadawayState.startHp > 10 then
                RadawayState.successNotified = true
                f9("follow: HP threshold reached -> SUCCESS")

                pcall(function()
                  if WindUI then
                    WindUI:Notify({
                      Title = "Get Infected",
                      Content = "success!",
                      Icon = "bug-play",
                      Duration = 5,
                    })
                  end
                end)
              end

              local character6 = localPlayer.Character

              if character6 and character6:FindFirstChild("HumanoidRootPart")
                and RadawayState.originalCFrame then
                character6:PivotTo(RadawayState.originalCFrame)
              end

              RadawayState.active = false
              break
            else
              local position3 = humanoidRootPart4.Position
              local position4 = v23.Position

              local magnitude2 = (Vector3.new(position3.X, 0, position3.Z)
                - Vector3.new(position4.X, 0, position4.Z)).Magnitude

              if (position3 - position4).Magnitude < 0.1 then
                Vector3.new(0, 0, 1)
              end

              if magnitude2 > 6 or magnitude2 < 4 then
                vector7 = f15(position4, character5, v22)
              else
                vector7 = Vector3.new(position3.X, position4.Y, position3.Z)

                if not f14(vector7, character5, { v22 }) then
                  vector7 = f15(position4, character5, v22)
                end
              end

              if vector7 and f11(vector7) then
                f16(
                  character5,
                  CFrame.new(vector7, Vector3.new(position4.X, vector7.Y, position4.Z)), count2
                )
              else
                f9("follow[" .. count2 .. "]: safePos invalid, skipping")
              end

              task.wait(0.1)
            end
          end
        end
      end
    else
      break
    end
  end

  f9("follow loop ended")
end

local v24 = { "Gilbert", "Chimera", "Mikhail", "Sin", "SIN", "Dave" }
local f19

local function f20(p24)
  if not p24 or not p24:IsA("Model") then
    return false
  elseif isPlayerCharacter(p24) then
    return false
  elseif p24 == localPlayer.Character then
    return false
  elseif f19(p24) then
    return true
  else
    if isMobModel(p24) then
      return true
    end

    return false
  end
end

function f19(p25)
  if not p25 or not p25:IsA("Model") then
    return false
  end

  for index7, value7 in ipairs(v24) do
    if p25.Name:find(value7) then
      return true
    end
  end

  return false
end

HitboxEnabled = false
HitboxModifiedHeads = {}
flyBV = nil
flyBG = nil
flySeat = nil
flyWeld = nil
flyActive = false
FlySpeed = 25
CooldownCounter = 0
CooldownData = { Bash = nil, Kick = nil }
ActiveTweens = {}
CachedMobs = {}
OrigAmbient = lighting.Ambient
OrigOutdoorAmbient = lighting.OutdoorAmbient
OrigBrightness = lighting.Brightness
OrigFogEnd = lighting.FogEnd
OrigFogStart = lighting.FogStart
OrigFOV = currentCamera.FieldOfView

local function f21()
  if ShadowRemovalConnection then
    ShadowRemovalConnection:Disconnect()
    ShadowRemovalConnection = nil
  end

  for key in pairs(ShadowModifiedParts) do
    local v25 = key

    if v25 and v25.Parent then
      pcall(function() v25.CastShadow = true end)
    end
  end
end

local function f22()
  for index8, value8 in ipairs(workspace:GetDescendants()) do
    if value8:IsA("BasePart") and value8.CastShadow then
      ShadowModifiedParts[value8] = true
      value8.CastShadow = false
    end
  end
end

OrigGlobalShadows = lighting.GlobalShadows

local function f23()
  if ShadowRemovalConnection then
    ShadowRemovalConnection:Disconnect()
  end

  ShadowRemovalConnection = workspace.DescendantAdded:Connect(function(descendant)
    if not Config.InfiniteNightVision then
      return
    end

    if descendant:IsA("BasePart") and descendant.CastShadow then
      ShadowModifiedParts[descendant] = true
      descendant.CastShadow = false
    end
  end)
end

ShadowModifiedParts = {}
ShadowRemovalConnection = nil
FakeDeathAnimTrack = nil
FakeInjuredTrack = nil
NVForcerConnection = nil
isShiftHeld = false
InfiniteStaminaThread = nil
AutoShieldRemovalActive = false
AutoShieldRemovalConnection = nil
BashCooldownUI = replicatedStorage:WaitForChild("BashCooldownUI")
gameAee = lighting:FindFirstChild("aee")
gameRadiationTint = lighting:FindFirstChild("RadiationTint")
InfectionActive = false
InfectionCleanupFunctions = {}
InfectionMode = "Controllable"
canInfect = true

InfectionAnims = {
  INJURED = "rbxassetid://94302036679429",
  HEAD_SHAKE = "rbxassetid://118621065272904",
  COUGH = "rbxassetid://111615919261340",
  UNSTABLE = "rbxassetid://9146103628",
  FALL1 = "rbxassetid://99985127815659",
  LURKER_AWAKE = "rbxassetid://138937044212276",
  IDLE = "rbxassetid://95464797704887",
  WALK = "rbxassetid://87989829896123",
  RUN = "rbxassetid://111821553591135",
}

infectionInjuredTrack = nil
infectionHeadShakeTrack = nil
infectionCoughTrack = nil
infectionUnstableTrack = nil
infectionFallTrack = nil
infectionLurkerTrack = nil
infectionIdleTrack = nil
infectionWalkTrack = nil
infectionRunTrack = nil
infectionCurrentState = nil
infectionTransformDone = false
infectionIsRunning = false
AutoRemoveAxeActive = false
AutoRemoveAxeConnection = nil
local qteInput = replicatedStorage:WaitForChild("Events"):WaitForChild("QTEInput")

local v26 = {
  E = Enum.KeyCode.E,
  F = Enum.KeyCode.F,
  Q = Enum.KeyCode.Q,
  Y = Enum.KeyCode.Y,
  H = Enum.KeyCode.H,
  G = Enum.KeyCode.G,
  R = Enum.KeyCode.R,
  T = Enum.KeyCode.T,
}

local v27 = {
  E = Enum.KeyCode.ButtonX,
  F = Enum.KeyCode.ButtonA,
  Q = Enum.KeyCode.ButtonB,
  R = Enum.KeyCode.ButtonX,
  T = Enum.KeyCode.ButtonA,
  Y = Enum.KeyCode.ButtonY,
  G = Enum.KeyCode.ButtonB,
  H = Enum.KeyCode.ButtonX,
}

local function f24()
  local isTenFootInterface = false
  pcall(function() isTenFootInterface = guiService:IsTenFootInterface() end)

  if isTenFootInterface then
    return "Console"
  end

  local getLastInputType = nil
  pcall(function() getLastInputType = userInputService:GetLastInputType() end)

  if getLastInputType and tostring(getLastInputType):match("^Gamepad") then
    return "Console"
  end

  if SentinelDeviceType == "Mobile" or SentinelDeviceType == "UWP" then
    return "Mobile"
  end

  return "PC"
end

Config.AutoQTEPlatform = f24()

local function f25(p26, p27)
  virtualInputManager:SendKeyEvent(true, p26, false, game)
  task.wait(p27 and 0.05 or 0.03)
  virtualInputManager:SendKeyEvent(false, p26, false, game)
end

local connect = nil

local function f26(p28)
  if p28 then
    if not connect then
      connect = qteInput.OnClientEvent:Connect(function(p29)
        local v28 = tostring(p29)
        local v29 = (Config.AutoQTEPlatform or "PC") == "Console"
        local v30 = v29 and v27[v28] or v26[v28]

        if v30 then
          local v31 = tonumber(Config.AutoQTEReactionSpeed) or 12

          if v31 < 0 then
            v31 = 0
          end

          if v31 > 60 then
            v31 = 60
          end

          local v32 = v31 / 60

          if v32 > 0 then
            task.wait(v32)
          end

          f25(v30, v29)
        end
      end)
    end
  elseif connect then
    connect:Disconnect()
    connect = nil
  end
end

userInputService.LastInputTypeChanged:Connect(function(p30)
  if not Config.AutoQTEEnabled then
    return
  end

  if tostring(p30):match("^Gamepad") and Config.AutoQTEPlatform ~= "Console" then
    Config.AutoQTEPlatform = "Console"

    pcall(function()
      if WindUI and WindUI.Notify then
        WindUI:Notify({ Title = "QTE", Content = "Switched to Console mode.", Duration = 3 })
      end
    end)
  elseif p30 == Enum.UserInputType.Keyboard and Config.AutoQTEPlatform == "Console" then
    local config = Config
    config.AutoQTEPlatform = SentinelDeviceType == "Mobile" and "Mobile" or "PC"

    pcall(function()
      if WindUI and WindUI.Notify then
        WindUI:Notify({
          Title = "QTE",
          Content = "Switched to " .. Config.AutoQTEPlatform .. " mode.",
          Duration = 3,
        })
      end
    end)
  end
end)

NoRecoilApplied = false
NoRecoilOriginalNewIndex = nil
NoRecoilMouseConn = nil
NoRecoilStoredPitch = 0
NoRecoilMouseMoved = false

function applyNoRecoil()
  if NoRecoilApplied then
    return
  end

  if not Capabilities.Hooks then
    pcall(function()
      if WindUI then
        WindUI:Notify({
          Title = "No Recoil",
          Content = "Your executor does not support this feature",
          Duration = 4,
        })
      end
    end)

    return
  end

  local currentCamera2 = workspace.CurrentCamera

  if not currentCamera2 then
    return
  end

  if pcall(function()
    NoRecoilStoredPitch = currentCamera2.CFrame:ToEulerAnglesYXZ()
    NoRecoilMouseMoved = false

    NoRecoilMouseConn = userInputService.InputChanged:Connect(function(input)
      if input.UserInputType == Enum.UserInputType.MouseMovement then
        NoRecoilMouseMoved = true
      end
    end)

    local v33 = getrawmetatable(currentCamera2)
    NoRecoilOriginalNewIndex = v33.__newindex
    setreadonly(v33, false)

    v33.__newindex = newcclosure(function(p31, p32, p33)
      if p32 == "CFrame" and typeof(p33) == "CFrame" then
        local v34, v35, v36 = p33:ToEulerAnglesYXZ()

        if NoRecoilMouseMoved then
          NoRecoilMouseMoved = false
          NoRecoilStoredPitch = v34
          return NoRecoilOriginalNewIndex(p31, p32, p33)
        end

        return NoRecoilOriginalNewIndex(p31, p32, CFrame.new(p33.Position)
          * CFrame.fromEulerAnglesYXZ(NoRecoilStoredPitch, v35, v36))
      end

      return NoRecoilOriginalNewIndex(p31, p32, p33)
    end)

    setreadonly(v33, true)
  end) then
    NoRecoilApplied = true
  else
    pcall(function()
      if WindUI then
        WindUI:Notify({
          Title = "No Recoil",
          Content = "Failed to apply No Recoil",
          Duration = 4,
        })
      end
    end)
  end
end

function removeNoRecoil()
  if not NoRecoilApplied then
    return
  end

  pcall(function()
    local currentCamera3 = workspace.CurrentCamera

    if currentCamera3 and NoRecoilOriginalNewIndex then
      local v37 = getrawmetatable(currentCamera3)
      setreadonly(v37, false)
      v37.__newindex = NoRecoilOriginalNewIndex
      setreadonly(v37, true)
    end
  end)

  if NoRecoilMouseConn then
    NoRecoilMouseConn:Disconnect()
    NoRecoilMouseConn = nil
  end

  NoRecoilApplied = false
  NoRecoilOriginalNewIndex = nil
  NoRecoilStoredPitch = 0
  NoRecoilMouseMoved = false
end

local function f27(p34)
  if p34 then
    pcall(function() p34:SetAttribute("infiniteStamina", true) end)
  end
end

function toggleInfiniteStamina(p35)
  Config.InfiniteStaminaEnabled = p35
  local character7

  if p35 then
    f27(localPlayer.Character)

    if InfiniteStaminaThread then
      task.cancel(InfiniteStaminaThread)
    end

    InfiniteStaminaThread = task.spawn(function()
      while Config.InfiniteStaminaEnabled and SentinelActive do
        local character8 = localPlayer.Character

        if character8 and character8:GetAttribute("infiniteStamina") ~= true then
          pcall(function() character8:SetAttribute("infiniteStamina", true) end)
        end

        task.wait(1)
      end
    end)
  else
    if InfiniteStaminaThread then
      task.cancel(InfiniteStaminaThread)
      InfiniteStaminaThread = nil
    end

    character7 = localPlayer.Character

    if character7 then
      pcall(function() character7:SetAttribute("infiniteStamina", false) end)
    end
  end
end

localPlayer.CharacterAdded:Connect(function(character9) task.wait(0.5) end)

function deleteSlasherAxe()
  local characters3 = workspaceService:FindFirstChild("Characters")

  if not characters3 then
    return
  end

  for i = 1, 5 do
    local findFirstChild2 = characters3:FindFirstChild("Slasher" .. i)

    if findFirstChild2 then
      local rightArm = findFirstChild2:FindFirstChild("Right Arm")

      if rightArm then
        local handle = rightArm:FindFirstChild("Handle")

        if handle then
          handle:Destroy()
        end
      end
    end
  end
end

function setupAutoRemoveAxe()
  if AutoRemoveAxeConnection then
    AutoRemoveAxeConnection:Disconnect()
  end

  if AutoRemoveAxeActive then
    AutoRemoveAxeConnection = workspace.DescendantAdded:Connect(function(descendant2)
      if AutoRemoveAxeActive then
        task.wait(0.1)

        if descendant2.Name == "Handle" and descendant2.Parent
          and descendant2.Parent.Name == "Right Arm" then
          local parent = descendant2.Parent.Parent

          if parent and parent.Name:match("Slasher%d") then
            descendant2:Destroy()
          end
        end
      end
    end)
  end
end

AntiRiserDodgeConnections = {}
AntiRiserDodgeHooked = {}

local v38 = {
  ["rbxassetid://129323669816538"] = true,
  ["rbxassetid://100585713982883"] = true,
  ["rbxassetid://102516762592870"] = true,
  ["rbxassetid://100869060669563"] = true,
  ["rbxassetid://110910899819148"] = true,
  ["rbxassetid://91043768324636"] = true,
}

local v39 = 0.5

local function f28(p36)
  local humanoidRootPart5 = p36:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart5 then
    return humanoidRootPart5.AssemblyLinearVelocity.Magnitude > v39
  else
    local humanoid4 = p36:FindFirstChildOfClass("Humanoid")

    if humanoid4 then
      return humanoid4.MoveDirection.Magnitude > 0.1
    end

    return false
  end
end

local f29

local function f30()
  for index9, value9 in ipairs(workspace:GetDescendants()) do
    if string.lower(value9.Name):find("riser") then
      local humanoid5 = value9:FindFirstChildOfClass("Humanoid")

      if humanoid5 then
        local animator = humanoid5:FindFirstChildOfClass("Animator")

        if animator then
          f29(animator, value9, value9.Name)
        end
      end

      local animationController = value9:FindFirstChildOfClass("AnimationController")

      if animationController then
        local animator2 = animationController:FindFirstChildOfClass("Animator")

        if animator2 then
          f29(animator2, value9, value9.Name)
        end
      end
    end
  end
end

function f29(p37, p38, p39)
  if AntiRiserDodgeHooked[p37] then
    return
  end

  AntiRiserDodgeHooked[p37] = true

  p37.AnimationPlayed:Connect(function(p40)
    if not Config.AntiRiserDodgeEnabled then
      return
    else
      local animation = p40.Animation

      if animation and v38[animation.AnimationId] then
        pcall(function() p40:Stop(0) end)

        local animationId = f28(p38) and "rbxassetid://114185638104823"
          or "rbxassetid://79525526834566"

        local animation2 = Instance.new("Animation")
        animation2.AnimationId = animationId

        p37:LoadAnimation(animation2)
      end

      return
    end
  end)
end

AntiRiserAddedConn = nil

function AntiRiserDodge_Enable(p41)
  Config.AntiRiserDodgeEnabled = p41

  if p41 then
    f30()

    if not AntiRiserAddedConn then
      AntiRiserAddedConn = workspace.DescendantAdded:Connect(function(descendant3)
        if not Config.AntiRiserDodgeEnabled then
          return
        end

        task.wait(0.1)

        if string.lower(descendant3.Name):find("riser") then
          local humanoid6 = descendant3:FindFirstChildOfClass("Humanoid")

          if humanoid6 then
            local animator3 = humanoid6:FindFirstChildOfClass("Animator")

            if animator3 then
              f29(animator3, descendant3, descendant3.Name)
            end
          end

          local animationController2 = descendant3:FindFirstChildOfClass("AnimationController")

          if animationController2 then
            local animator4 = animationController2:FindFirstChildOfClass("Animator")

            if animator4 then
              f29(animator4, descendant3, descendant3.Name)
            end
          end
        end
      end)
    end
  else
    for index10, value10 in ipairs(AntiRiserDodgeConnections) do
      local v40 = value10
      pcall(function() v40:Disconnect() end)
    end

    AntiRiserDodgeConnections = {}
    AntiRiserDodgeHooked = {}
    AntiRiserAddedConn = nil
  end
end

AutoBringAxeConn = nil
AutoBringHammerConn = nil
AutoBringAxeActive = false
AutoBringHammerActive = false
AutoBringAxeRunning = false
AutoBringHammerRunning = false
AutoBringAxeLastCheck = 0
AutoBringHammerLastCheck = 0

function toggleAutoBringAxe(p42)
  Config.AutoBringAxe = p42
  AutoBringAxeActive = p42

  if AutoBringAxeConn then
    pcall(function() AutoBringAxeConn:Disconnect() end)
    AutoBringAxeConn = nil
  end

  AutoBringAxeRunning = false
  AutoBringAxeLastCheck = 0

  if p42 then
    AutoBringAxeConn = runService.Heartbeat:Connect(function()
      if not AutoBringAxeActive then
        return
      elseif AutoBringAxeRunning then
        return
      elseif f8("Axe") then
        return
      else
        local v41 = tick()

        if v41 - AutoBringAxeLastCheck < 1.5 then
          return
        end

        AutoBringAxeLastCheck = v41
        AutoBringAxeRunning = true
        task.spawn(function() AutoBringAxeRunning = false end)
        return
      end
    end)
  end
end

function toggleAutoBringHammer(p43)
  Config.AutoBringHammer = p43
  AutoBringHammerActive = p43

  if AutoBringHammerConn then
    pcall(function() AutoBringHammerConn:Disconnect() end)
    AutoBringHammerConn = nil
  end

  AutoBringHammerRunning = false
  AutoBringHammerLastCheck = 0

  if p43 then
    AutoBringHammerConn = runService.Heartbeat:Connect(function()
      if not AutoBringHammerActive then
        return
      elseif AutoBringHammerRunning then
        return
      elseif f8("Sledgehammer") then
        return
      else
        local v42 = tick()

        if v42 - AutoBringHammerLastCheck < 1.5 then
          return
        end

        AutoBringHammerLastCheck = v42
        AutoBringHammerRunning = true
        task.spawn(function() AutoBringHammerRunning = false end)
        return
      end
    end)
  end
end

function teleportAndBack(p44, p45)
  local character10 = localPlayer.Character

  if not character10 then
    return
  else
    local humanoidRootPart6 = character10:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart6 then
      return
    else
      local cframe = humanoidRootPart6.CFrame
      character10:PivotTo(p44)
      task.wait(p45 or 0.5)

      if character10 and character10:FindFirstChild("HumanoidRootPart") then
        character10:PivotTo(cframe)
      end

      return
    end
  end
end

Badge1CFrame = CFrame.new(-72.5317383, -13.0901861, -880.639832, 0, 0, 1, 0, 1, 0, -1, 0, 0)
Badge2CFrame = CFrame.new(8.89144325, -33.9937019, -1363.57678, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Badge3CFrame = CFrame.new(-108.884972, -13.0943184, -834.477417, 1, 0, 0, 0, 1, 0, 0, 0, 1)

function getBadge1()
  teleportAndBack(Badge1CFrame, 0.5)
end

function getBadge2()
  teleportAndBack(Badge2CFrame, 0.5)
end

function getBadge3()
  teleportAndBack(Badge3CFrame, 0.5)
end

InstantProximityConnection = nil
AutoCompletePromptConnection = nil

function applyInstantProximity()
  for index11, value11 in ipairs(workspaceService:GetDescendants()) do
    if value11:IsA("ProximityPrompt") then
      value11.HoldDuration = 0
    end
  end
end

function setupInstantProximity()
  if InstantProximityConnection then
    InstantProximityConnection:Disconnect()
  end

  if Config.InstantProximityPrompt then
    applyInstantProximity()

    InstantProximityConnection = workspaceService.DescendantAdded:Connect(function(descendant4)
      if Config.InstantProximityPrompt and descendant4:IsA("ProximityPrompt") then
        descendant4.HoldDuration = 0
      end
    end)
  end
end

function autoCompleteProximity()
  if not Config.AutoCompleteProximityPrompt then
    if AutoCompletePromptConnection then
      AutoCompletePromptConnection:Disconnect()
      AutoCompletePromptConnection = nil
    end

    return
  end

  if AutoCompletePromptConnection then
    AutoCompletePromptConnection:Disconnect()
  end

  AutoCompletePromptConnection = proximityPromptService.PromptShown:Connect(function(p46)
    if not Config.AutoCompleteProximityPrompt then
      return
    elseif not p46.Enabled then
      return
    else
      virtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
      p46.PromptHidden:Wait()
      virtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
      return
    end
  end)
end

function BreakGasmask()
  local playerGui = localPlayer:FindFirstChild("PlayerGui")

  if not playerGui then
    return false
  else
    local gasmask = playerGui:FindFirstChild("Gasmask")

    if not gasmask then
      return false
    else
      local maskHole = gasmask:FindFirstChild("MaskHole")
      local glass = gasmask:FindFirstChild("Glass")

      if maskHole then
        if maskHole:IsA("ImageLabel") then
          maskHole.ImageTransparency = 0
          maskHole.Visible = true
        elseif maskHole:IsA("Frame") then
          maskHole.Visible = true

          for key2, value12 in pairs(maskHole:GetDescendants()) do
            if value12:IsA("ImageLabel") then
              value12.ImageTransparency = 0
              value12.Visible = true
            end
          end
        end
      end

      local sound = Instance.new("Sound")
      sound.SoundId = "rbxassetid://632831227"
      sound.Volume = 1
      sound.Parent = gasmask
      sound:Play()

      debris:AddItem(sound, 3)

      if glass and glass:IsA("ImageLabel") then
        tweenService:Create(glass, TweenInfo.new(0.1), { ImageTransparency = 0.5 }):Play()
        task.wait(0.05)

        tweenService:Create(glass, TweenInfo.new(0.5), {
          ImageTransparency = glass.ImageTransparency,
        }):Play()
      end

      return true
    end
  end
end

function showBloodVignette(p47)
  local playerGui2 = localPlayer:FindFirstChild("PlayerGui")

  if not playerGui2 then
    return
  else
    local gui = playerGui2:FindFirstChild("Gui")

    if not gui then
      return
    else
      local bloodVignette = gui:FindFirstChild("blood-vignette")

      if bloodVignette and bloodVignette:IsA("ImageLabel") then
        bloodVignette.Visible = p47

        if p47 then
          bloodVignette.ImageTransparency = 0
        else
          bloodVignette.ImageTransparency = 1
        end
      end

      return
    end
  end
end

function createRedTint()
  local infectionRedTint = lighting:FindFirstChild("InfectionRedTint")

  if not infectionRedTint then
    infectionRedTint = Instance.new("ColorCorrectionEffect")
    infectionRedTint.Name = "InfectionRedTint"
    infectionRedTint.Parent = lighting
  end

  return infectionRedTint
end

function playAnimationOnHumanoid(animationId2, p48, p49)
  local character11 = localPlayer.Character

  if not character11 then
    return nil
  else
    local humanoid7 = character11:FindFirstChildOfClass("Humanoid")

    if not humanoid7 then
      return nil
    else
      local animator5 = humanoid7:FindFirstChildOfClass("Animator")
        or Instance.new("Animator", humanoid7)

      local animation3 = Instance.new("Animation")
      animation3.AnimationId = animationId2

      local loadAnimation = animator5:LoadAnimation(animation3)
      loadAnimation.Looped = p48 or false
      loadAnimation:Play()

      if p49 then
        loadAnimation.Stopped:Connect(p49)
      end

      return loadAnimation
    end
  end
end

demonicChars = {
  "Ω", "Ж", "Ψ", "≠", "Σ", "µ", "∂", "ø", "π", "§", "҂", "Ϟ", "Җ", "Ҩ", "?",
  "!",
}

function spawnDemonicSymbol(p50)
  local playerGui3 = localPlayer:FindFirstChild("PlayerGui")

  if not playerGui3 then
    return
  else
    local infectionEffectsGui = playerGui3:FindFirstChild("InfectionEffectsGui")

    if not infectionEffectsGui then
      infectionEffectsGui = Instance.new("ScreenGui")
      infectionEffectsGui.Name = "InfectionEffectsGui"
      infectionEffectsGui.ResetOnSpawn = false
      infectionEffectsGui.IgnoreGuiInset = true
      infectionEffectsGui.Parent = playerGui3
    end

    for j = 1, p50 and 5 or 3 do
      local textLabel = Instance.new("TextLabel")
      textLabel.Text = demonicChars[math.random(1, #demonicChars)]
      textLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
      textLabel.Font = Enum.Font.Code
      textLabel.TextSize = math.random(70, 80)
      textLabel.BackgroundTransparency = 1
      textLabel.Size = UDim2.new(0, 60, 0, 60)
      textLabel.Position = UDim2.new(math.random(), 0, 1, 0)
      textLabel.AnchorPoint = Vector2.new(0.5, 1)
      textLabel.Parent = infectionEffectsGui

      local v43 = math.random()

      local create = tweenService:Create(textLabel, TweenInfo.new(
        2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out
      ), {
        TextTransparency = 1,
        Position = UDim2.new(textLabel.Position.X.Scale, 0, 0.1 + v43 * 0.1, 0),
      })

      create:Play()
      create.Completed:Connect(function() textLabel:Destroy() end)
    end

    return
  end
end

function stopInfection()
  InfectionActive = false
  infectionIsRunning = false
  showBloodVignette(false)
  local infectionRedTint2 = lighting:FindFirstChild("InfectionRedTint")

  if infectionRedTint2 then
    infectionRedTint2:Destroy()
  end

  local infectionEffectsGui2 = localPlayer.PlayerGui:FindFirstChild("InfectionEffectsGui")

  if infectionEffectsGui2 then
    infectionEffectsGui2:Destroy()
  end

  if InfectionCleanupFunctions then
    InfectionCleanupFunctions = {}
  end

  for index12, value13 in ipairs({
    infectionInjuredTrack, infectionHeadShakeTrack, infectionCoughTrack, infectionUnstableTrack,
    infectionFallTrack, infectionLurkerTrack, infectionIdleTrack, infectionWalkTrack,
    infectionRunTrack,
  }) do
    if value13 then
      value13:Stop()
    end
  end

  infectionTransformDone = false
  infectionCurrentState = nil
  local character12 = localPlayer.Character

  if character12 then
    local humanoid8 = character12:FindFirstChildOfClass("Humanoid")

    if humanoid8 then
      humanoid8.PlatformStand = false
      humanoid8.WalkSpeed = Config.SpeedHackEnabled and Config.WalkSpeedValue or 9
      humanoid8.JumpPower = Config.JumpPowerEnabled and Config.JumpPowerValue or 50

      local animator6 = humanoid8:FindFirstChildOfClass("Animator")

      if animator6 then
        for key3, value14 in pairs(animator6:GetPlayingAnimationTracks()) do
          value14:Stop()
        end
      end
    end

    local humanoidRootPart7 = character12:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart7 then
      humanoidRootPart7.Anchored = false
    end

    local clientScripts = character12:FindFirstChild("ClientScripts")

    if clientScripts then
      local stagger = clientScripts:FindFirstChild("Stagger")

      if stagger then
        stagger.Disabled = not Config.StaggerEnabled
      end
    end
  end
end

function startInfectionSequence(p51)
  local v44 = p51

  if not canInfect then
    pcall(function()
      if WindUI then
        WindUI:Notify({
          Title = "Infection",
          Content = "You must respawn before starting a new infection.",
          Duration = 3,
        })
      end
    end)

    return
  end

  if InfectionActive then
    return
  end

  if v44 ~= "Controllable" and v44 ~= "NonControllable" then
    v44 = "Controllable"
  end

  canInfect = false
  InfectionActive = true
  infectionIsRunning = true
  InfectionMode = v44
  BreakGasmask()
  showBloodVignette(true)
  local character13 = localPlayer.Character

  if not character13 then
    InfectionActive = false
    infectionIsRunning = false
    canInfect = true
    return
  end

  local humanoid9 = character13:FindFirstChildOfClass("Humanoid")

  if not humanoid9 then
    InfectionActive = false
    infectionIsRunning = false
    canInfect = true
    return
  end

  humanoid9.Health = 1
  infectionInjuredTrack = playAnimationOnHumanoid(InfectionAnims.INJURED, true)
  infectionHeadShakeTrack = playAnimationOnHumanoid(InfectionAnims.HEAD_SHAKE, true)

  local v45 = createRedTint()
  v45.TintColor = Color3.fromRGB(255, 255, 255)

  local v46 = tick()
  local v47 = tick()

  task.spawn(function()
    while infectionIsRunning and humanoid9 and humanoid9.Health > 0 do
      local v48 = tick() - v46

      if tick() - v47 >= 10 and v48 < 60 then
        v47 = tick()

        if infectionCoughTrack then
          infectionCoughTrack:Stop()
        end

        infectionCoughTrack = playAnimationOnHumanoid(InfectionAnims.COUGH, false)

        local sound2 = Instance.new("Sound")
        sound2.SoundId = "rbxassetid://93090593281658"
        sound2.Volume = 1
        sound2.Parent = character13
        sound2:Play()

        debris:AddItem(sound2, 2)
      end

      if not infectionUnstableTrack or not infectionUnstableTrack.IsPlaying then
        if infectionUnstableTrack then
          infectionUnstableTrack:Stop()
        end

        infectionUnstableTrack = playAnimationOnHumanoid(InfectionAnims.UNSTABLE, true)
      end

      if v48 >= 40 then
        local v49 = math.min((v48 - 40) / 30, 1)

        v45.TintColor = Color3.fromRGB(
          255, 255 - math.floor(v49 * 255), 255 - math.floor(v49 * 255)
        )
      end

      if v48 >= 45 then
        spawnDemonicSymbol(true)
      end

      if v48 >= 60 then
        break
      end

      task.wait(0.5)
    end
  end)

  task.wait(60)

  if not infectionIsRunning or not humanoid9 or humanoid9.Health <= 0 then
    stopInfection()
    canInfect = true
    return
  end

  if infectionCoughTrack then
    infectionCoughTrack:Stop()
    infectionCoughTrack = nil
  end

  if infectionUnstableTrack then
    infectionUnstableTrack:Stop()
    infectionUnstableTrack = nil
  end

  if infectionInjuredTrack then
    infectionInjuredTrack:Stop()
    infectionInjuredTrack = nil
  end

  if infectionHeadShakeTrack then
    infectionHeadShakeTrack:Stop()
    infectionHeadShakeTrack = nil
  end

  if InfectionMode == "Controllable" then
    infectionFallTrack = playAnimationOnHumanoid(InfectionAnims.FALL1, false, function()
      if infectionIsRunning then
        if infectionLurkerTrack then
          infectionLurkerTrack:Stop()
        end

        infectionLurkerTrack = playAnimationOnHumanoid(InfectionAnims.LURKER_AWAKE, false, function()
          local humanoidRootPart8 = character13:FindFirstChild("HumanoidRootPart")

          if humanoidRootPart8 then
            humanoidRootPart8.Anchored = false
          end

          humanoid9.PlatformStand = false
          humanoid9.WalkSpeed = 9
          humanoid9.JumpPower = 50

          infectionTransformDone = true
          infectionCurrentState = nil

          task.spawn(function()
            local v50

            while infectionIsRunning and humanoid9 and humanoid9.Health > 0 do
              local humanoidRootPart9 = character13:FindFirstChild("HumanoidRootPart")

              if humanoidRootPart9 then
                local velocity = humanoidRootPart9.Velocity
                local magnitude3 = Vector3.new(velocity.X, 0, velocity.Z).Magnitude

                if isShiftHeld and magnitude3 > 2 then
                  v50 = "run"
                elseif magnitude3 > 0.5 then
                  v50 = "walk"
                else
                  v50 = "idle"
                end

                if v50 ~= infectionCurrentState then
                  infectionCurrentState = v50

                  if infectionIdleTrack then
                    infectionIdleTrack:Stop()
                    infectionIdleTrack = nil
                  end

                  if infectionWalkTrack then
                    infectionWalkTrack:Stop()
                    infectionWalkTrack = nil
                  end

                  if infectionRunTrack then
                    infectionRunTrack:Stop()
                    infectionRunTrack = nil
                  end

                  if v50 == "idle" then
                    infectionIdleTrack = playAnimationOnHumanoid(InfectionAnims.IDLE, true)
                  elseif v50 == "walk" then
                    infectionWalkTrack = playAnimationOnHumanoid(InfectionAnims.WALK, true)
                  elseif v50 == "run" then
                    infectionRunTrack = playAnimationOnHumanoid(InfectionAnims.RUN, true)
                  end
                end
              end

              task.wait(0.2)
            end
          end)

          task.wait(60)

          if infectionIsRunning and humanoid9 and humanoid9.Health > 0 then
            humanoid9.Health = 0
          end

          stopInfection()
          canInfect = true
        end)
      end
    end)
  else
    local animator7 = humanoid9:FindFirstChildOfClass("Animator")

    local instance = animator7
    instance = animator7 or Instance.new("Animator", humanoid9)

    local animation4 = Instance.new("Animation")
    animation4.AnimationId = "rbxassetid://82480275101558"

    local loadAnimation2 = instance:LoadAnimation(animation4)
    loadAnimation2:Play()
    loadAnimation2.Stopped:Wait()

    humanoid9.Health = 0
    canInfect = true
  end

  humanoid9.Died:Connect(function()
    if InfectionActive then
      local animator8 = humanoid9:FindFirstChildOfClass("Animator")
        or Instance.new("Animator", humanoid9)

      local animation5 = Instance.new("Animation")
      animation5.AnimationId = "rbxassetid://82480275101558"

      local loadAnimation3 = animator8:LoadAnimation(animation5)
      loadAnimation3:Play()
      loadAnimation3.Stopped:Wait()
    end

    stopInfection()
    canInfect = true
  end)

  table.insert(InfectionCleanupFunctions, function()
    infectionIsRunning = false
    InfectionActive = false
    canInfect = true
    local humanoidRootPart10 = character13:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart10 then
      humanoidRootPart10.Anchored = false
    end

    if humanoid9 then
      humanoid9.PlatformStand = false
      humanoid9.WalkSpeed = Config.SpeedHackEnabled and Config.WalkSpeedValue or 9
      humanoid9.JumpPower = Config.JumpPowerEnabled and Config.JumpPowerValue or 50
    end

    for index13, value15 in ipairs({
      infectionInjuredTrack, infectionHeadShakeTrack, infectionCoughTrack,
      infectionUnstableTrack, infectionFallTrack, infectionLurkerTrack, infectionIdleTrack,
      infectionWalkTrack, infectionRunTrack,
    }) do
      if value15 then
        value15:Stop()
      end
    end

    infectionTransformDone = false
    showBloodVignette(false)
    local infectionRedTint3 = lighting:FindFirstChild("InfectionRedTint")

    if infectionRedTint3 then
      infectionRedTint3:Destroy()
    end

    local infectionEffectsGui3 = localPlayer.PlayerGui:FindFirstChild("InfectionEffectsGui")

    if infectionEffectsGui3 then
      infectionEffectsGui3:Destroy()
    end
  end)
end

function ApplyHitboxToPart(p52, p53)
  if not p52 or not p52:IsA("BasePart") then
    return
  elseif p52.Name ~= "Head" then
    return
  else
    local parent2 = p52.Parent

    if not isHumanoidModel(parent2) then
      return
    elseif isPlayerCharacter(parent2) then
      return
    elseif parent2 == localPlayer.Character then
      return
    else
      if not f20(parent2) then
        return
      end

      pcall(function()
        if p53 then
          if not HitboxModifiedHeads[p52] then
            HitboxModifiedHeads[p52] = {
              Size = p52.Size,
              Transparency = p52.Transparency,
              CanCollide = p52.CanCollide,
            }
          end

          p52.Size = Vector3.new(Config.BoxSize, Config.BoxSize, Config.BoxSize)
          p52.CanCollide = false
          p52.Transparency = 0.5
        else
          local v51 = HitboxModifiedHeads[p52]

          if v51 then
            p52.Size = v51.Size
            p52.CanCollide = v51.CanCollide
            p52.Transparency = v51.Transparency

            HitboxModifiedHeads[p52] = nil
          end
        end
      end)

      return
    end
  end
end

function UpdateAllHitboxes(p54)
  for index14, value16 in ipairs(workspaceService:GetDescendants()) do
    if value16:IsA("BasePart") and value16.Name == "Head" then
      local parent3 = value16.Parent

      if isHumanoidModel(parent3) and not isPlayerCharacter(parent3)
        and parent3 ~= localPlayer.Character and f20(parent3) then
        ApplyHitboxToPart(value16, p54)
      end
    end
  end
end

workspaceService.DescendantAdded:Connect(function(descendant5)
  if HitboxEnabled and descendant5:IsA("BasePart") and descendant5.Name == "Head" then
    local parent4 = descendant5.Parent

    if isHumanoidModel(parent4) and not isPlayerCharacter(parent4)
      and parent4 ~= localPlayer.Character and f20(parent4) then
      ApplyHitboxToPart(descendant5, true)
    end
  end

  if descendant5:IsA("BasePart") then
    descendant5:GetPropertyChangedSignal("Name"):Connect(function()
      if HitboxEnabled and descendant5.Name == "Head" then
        local parent5 = descendant5.Parent

        if isHumanoidModel(parent5) and not isPlayerCharacter(parent5)
          and parent5 ~= localPlayer.Character and f20(parent5) then
          ApplyHitboxToPart(descendant5, true)
        end
      end
    end)
  end
end)

flyMobileUp = false
flyMobileDown = false
flyMobileGui = nil

function cleanFly()
  flyMobileUp = false
  flyMobileDown = false

  if flyMobileGui then
    flyMobileGui:Destroy()
    flyMobileGui = nil
  end

  if flyBV then
    flyBV:Destroy()
    flyBV = nil
  end

  if flyBG then
    flyBG:Destroy()
    flyBG = nil
  end

  if flyWeld then
    flyWeld:Destroy()
    flyWeld = nil
  end

  if flySeat then
    flySeat:Destroy()
    flySeat = nil
  end

  local character14 = localPlayer.Character

  local humanoid10 = character14
  humanoid10 = character14 and character14:FindFirstChildOfClass("Humanoid")

  if humanoid10 then
    humanoid10.PlatformStand = false
    humanoid10:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
  end

  flyActive = false
end

function enableFly(p55)
  if not p55 then
    cleanFly()
    return
  else
    local character15 = localPlayer.Character

    if not character15 then
      return
    else
      local humanoidRootPart11 = character15:FindFirstChild("HumanoidRootPart")
      local v52 = not humanoidRootPart11
      local humanoid11 = character15:FindFirstChildOfClass("Humanoid")

      if v52 or not humanoid11 then
        return
      end

      cleanFly()
      flyActive = true

      flySeat = Instance.new("VehicleSeat")
      flySeat.Size = Vector3.new(1, 1, 1)
      flySeat.Transparency = 1
      flySeat.CanCollide = false
      flySeat.Parent = workspace

      flyWeld = Instance.new("Weld")
      flyWeld.Part0 = humanoidRootPart11
      flyWeld.Part1 = flySeat
      flyWeld.C0 = CFrame.new(0, -1.5, 0)
      flyWeld.Parent = flySeat

      humanoid11.Sit = true
      humanoid11.PlatformStand = true
      humanoid11:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

      flyBV = Instance.new("BodyVelocity")
      flyBV.MaxForce = Vector3.new(1000000, 1000000, 1000000)
      flyBV.Parent = flySeat

      flyBG = Instance.new("BodyGyro")
      flyBG.MaxTorque = Vector3.new(1000000, 1000000, 1000000)
      flyBG.Parent = flySeat

      if SentinelDeviceType == "Mobile" then
        flyMobileGui = Instance.new("ScreenGui")
        flyMobileGui.Name = "FlyMobileButtons"
        flyMobileGui.ResetOnSpawn = false
        flyMobileGui.IgnoreGuiInset = true
        flyMobileGui.Parent = localPlayer.PlayerGui

        local textButton = Instance.new("TextButton")
        textButton.Text = "⬆"
        textButton.Size = UDim2.new(0, 70, 0, 70)
        textButton.Position = UDim2.new(0.88, 0, 0.55, 0)
        textButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        textButton.TextColor3 = Color3.new(1, 1, 1)
        textButton.TextSize = 28
        textButton.BackgroundTransparency = 0.3
        textButton.Font = Enum.Font.GothamBold
        textButton.Parent = flyMobileGui

        Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 12)

        textButton.InputBegan:Connect(function(input2)
          if input2.UserInputType == Enum.UserInputType.Touch then
            flyMobileUp = true
          end
        end)

        textButton.InputEnded:Connect(function(input3)
          if input3.UserInputType == Enum.UserInputType.Touch then
            flyMobileUp = false
          end
        end)

        local textButton2 = Instance.new("TextButton")
        textButton2.Text = "⬇"
        textButton2.Size = UDim2.new(0, 70, 0, 70)
        textButton2.Position = UDim2.new(0.88, 0, 0.68, 0)
        textButton2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        textButton2.TextColor3 = Color3.new(1, 1, 1)
        textButton2.TextSize = 28
        textButton2.BackgroundTransparency = 0.3
        textButton2.Font = Enum.Font.GothamBold
        textButton2.Parent = flyMobileGui

        Instance.new("UICorner", textButton2).CornerRadius = UDim.new(0, 12)

        textButton2.InputBegan:Connect(function(input4)
          if input4.UserInputType == Enum.UserInputType.Touch then
            flyMobileDown = true
          end
        end)

        textButton2.InputEnded:Connect(function(input5)
          if input5.UserInputType == Enum.UserInputType.Touch then
            flyMobileDown = false
          end
        end)
      end

      return
    end
  end
end

runService.Heartbeat:Connect(function(delta)
  if not SentinelActive then
    return
  elseif not flyActive then
    return
  else
    local character16 = localPlayer.Character

    if not character16 then
      return
    else
      local humanoidRootPart12 = character16:FindFirstChild("HumanoidRootPart")
      local humanoid12 = character16:FindFirstChildOfClass("Humanoid")

      if not humanoidRootPart12 or not humanoid12 then
        return
      else
        local vector8 = Vector3.new()

        if SentinelDeviceType == "Mobile" then
          local moveDirection = humanoid12.MoveDirection

          if moveDirection.Magnitude > 0 then
            vector8 = Vector3.new(moveDirection.X, 0, moveDirection.Z)
          end

          if flyMobileUp then
            vector8 = vector8 + Vector3.new(0, 1, 0)
          end

          if flyMobileDown then
            vector8 = vector8 - Vector3.new(0, 1, 0)
          end
        else
          if userInputService:IsKeyDown(Enum.KeyCode.W) then
            vector8 = vector8 + currentCamera.CFrame.LookVector
          end

          if userInputService:IsKeyDown(Enum.KeyCode.S) then
            vector8 = vector8 - currentCamera.CFrame.LookVector
          end

          if userInputService:IsKeyDown(Enum.KeyCode.A) then
            vector8 = vector8 - currentCamera.CFrame.RightVector
          end

          if userInputService:IsKeyDown(Enum.KeyCode.D) then
            vector8 = vector8 + currentCamera.CFrame.RightVector
          end

          if userInputService:IsKeyDown(Enum.KeyCode.Space) then
            vector8 = vector8 + Vector3.new(0, 1, 0)
          end

          if userInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            vector8 = vector8 - Vector3.new(0, 1, 0)
          end
        end

        if vector8.Magnitude > 0 then
          vector8 = vector8.Unit
        end

        if flyBV and flyBG and flySeat then
          flyBG.CFrame = currentCamera.CFrame
          flyBV.Velocity = vector8 * FlySpeed
        end

        return
      end
    end
  end
end)

XrayEnabled = false
XrayDistance = 30
XrayMaterial = Enum.Material.ForceField
XrayTransparency = 0.3
XrayModifiedParts = {}
XrayLoop = nil

function applyXrayToPart(p56, p57)
  if not p56:IsA("BasePart") then
    return
  end

  if p57 then
    if not XrayModifiedParts[p56] then
      XrayModifiedParts[p56] = { Material = p56.Material, Transparency = p56.Transparency }
    end

    p56.Material = XrayMaterial
    p56.Transparency = XrayTransparency
  else
    local v53 = XrayModifiedParts[p56]

    if v53 then
      p56.Material = v53.Material
      p56.Transparency = v53.Transparency
      XrayModifiedParts[p56] = nil
    end
  end
end

function updateXrayMaterialAndTransparency()
  if not XrayEnabled then
    return
  end

  for key4, value17 in pairs(XrayModifiedParts) do
    local v54 = key4

    if v54 and v54:IsA("BasePart") then
      pcall(function()
        v54.Material = XrayMaterial
        v54.Transparency = XrayTransparency
      end)
    end
  end
end

function updateXray()
  if not XrayEnabled then
    if XrayLoop then
      XrayLoop:Disconnect()
      XrayLoop = nil
    end

    local v55 = {}

    for key5, value18 in pairs(XrayModifiedParts) do
      table.insert(v55, key5)
    end

    for index15, value19 in ipairs(v55) do
      local v56 = value19
      pcall(function() applyXrayToPart(v56, false) end)
    end

    return
  end

  if XrayLoop then
    XrayLoop:Disconnect()
  end

  XrayLoop = runService.Heartbeat:Connect(function()
    if not SentinelActive then
      return
    elseif not XrayEnabled then
      return
    else
      local character17 = localPlayer.Character

      if not character17 then
        return
      else
        local humanoidRootPart13 = character17:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart13 then
          return
        else
          local v57 = {}

          for index16, value20 in ipairs((workspaceService:GetPartBoundsInRadius(
            humanoidRootPart13.Position, XrayDistance
          ))) do
            if value20:IsA("BasePart") and not value20:IsDescendantOf(character17) then
              v57[value20] = true

              if not XrayModifiedParts[value20] then
                applyXrayToPart(value20, true)
              elseif value20.Material ~= XrayMaterial
                or value20.Transparency ~= XrayTransparency then
                value20.Material = XrayMaterial
                value20.Transparency = XrayTransparency
              end
            end
          end

          local v58 = {}

          for key6 in pairs(XrayModifiedParts) do
            if not v57[key6] then
              table.insert(v58, key6)
            end
          end

          for index17, value21 in ipairs(v58) do
            applyXrayToPart(value21, false)
          end

          return
        end
      end
    end
  end)
end

function updateSilencers(p58)
  local backpack2 = localPlayer:FindFirstChild("Backpack")

  if backpack2 then
    for index18, value22 in ipairs(backpack2:GetChildren()) do
      if value22:GetAttribute("IsGun") == true then
        value22:SetAttribute("Silencer", p58)
      end
    end
  end

  local character18 = localPlayer.Character

  if character18 then
    for index19, value23 in ipairs(character18:GetChildren()) do
      if value23:IsA("Tool") and value23:GetAttribute("IsGun") == true then
        value23:SetAttribute("Silencer", p58)
      end
    end
  end
end

function checkAndApplySilencer(p59)
  if p59:GetAttribute("IsGun") == true then
    p59:SetAttribute("Silencer", Config.SilencerEnabled)
  end
end

function listenToBackpack(p60)
  if not p60 then
    return
  end

  p60.ChildAdded:Connect(function(child)
    task.wait(0.1)
    checkAndApplySilencer(child)
  end)
end

if localPlayer.Character then
  localPlayer.Character.ChildAdded:Connect(function(child2)
    if child2:IsA("Tool") then
      task.wait(0.1)
      checkAndApplySilencer(child2)
      updateSilencers(Config.SilencerEnabled)
    end
  end)
end

localPlayer.CharacterAdded:Connect(function(character19)
  task.wait(1)
  listenToBackpack((localPlayer:WaitForChild("Backpack")))

  character19.ChildAdded:Connect(function(child3)
    if child3:IsA("Tool") then
      task.wait(0.1)
      checkAndApplySilencer(child3)
      updateSilencers(Config.SilencerEnabled)
    end
  end)

  updateSilencers(Config.SilencerEnabled)
end)

task.spawn(function()
  local backpack3 = localPlayer:FindFirstChild("Backpack")

  if backpack3 then
    listenToBackpack(backpack3)
  end
end)

function applyNametags(p61)
  local head2 = p61 and p61:FindFirstChild("Head")

  if not head2 then
    return
  else
    local nameTag = head2:FindFirstChild("NameTag")

    if not nameTag then
      nameTag = head2:WaitForChild("NameTag", 5)

      if not nameTag then
        return
      end

      nameTag.CharacterName.TextColor3 = Config.TagColor
      nameTag.Rank.TextColor3 = Config.TagColor
      nameTag.Username.TextColor3 = Config.TagColor

      if Config.CharacterName ~= "" then
        nameTag.CharacterName.Text = "[" .. Config.CharacterName .. "]"
      else
        nameTag.CharacterName.Text = ""
      end

      if Config.CharacterRank ~= "" then
        nameTag.Rank.Text = "[" .. Config.CharacterRank .. "]"
      else
        nameTag.Rank.Text = ""
      end

      return
    end

    nameTag.CharacterName.TextColor3 = Config.TagColor
    nameTag.Rank.TextColor3 = Config.TagColor
    nameTag.Username.TextColor3 = Config.TagColor

    if Config.CharacterName ~= "" then
      nameTag.CharacterName.Text = "[" .. Config.CharacterName .. "]"
    else
      nameTag.CharacterName.Text = ""
    end

    if Config.CharacterRank ~= "" then
      nameTag.Rank.Text = "[" .. Config.CharacterRank .. "]"
    else
      nameTag.Rank.Text = ""
    end

    return
  end
end

function changeTeam(p62, p63)
  local v59 = p63

  if v59 == nil then
    v59 = true
  end

  if not p62 or p62 == "" then
    return
  end

  local v60 = nil

  for index20, value24 in ipairs(teams:GetChildren()) do
    if value24:IsA("Team") and value24.Name:lower() == tostring(p62):lower() then
      v60 = value24
      break
    end
  end

  if not v60 then
    local findFirstChild3 = teams:FindFirstChild(p62)

    if findFirstChild3 then
      v60 = findFirstChild3
    end
  end

  if not v60 then
    pcall(function()
      if WindUI then
        WindUI:Notify({
          Title = "Team",
          Content = "Team '" .. tostring(p62) .. "' not found.",
          Duration = 4,
        })
      end
    end)

    return
  end

  pcall(function() localPlayer.Team = v60 end)
  pcall(function() localPlayer.TeamColor = v60.TeamColor end)
  pcall(function() localPlayer.Neutral = false end)

  pcall(function()
    local events = replicatedStorage:FindFirstChild("Events")

    if events then
      for index21, value25 in ipairs(events:GetDescendants()) do
        local v61 = value25

        if v61:IsA("RemoteEvent")
          and (v61.Name:lower():find("team") or v61.Name:lower():find("join")) then
          pcall(function() v61:FireServer(v60.Name) end)
          pcall(function() v61:FireServer(v60) end)
        end
      end
    end
  end)

  if not v59 then
    return
  end

  task.spawn(function()
    task.wait(0.15)
    local character20 = localPlayer.Character

    if character20 then
      local humanoid13 = character20:FindFirstChildOfClass("Humanoid")

      if humanoid13 and humanoid13.Health > 0 then
        humanoid13.Health = 0
      end
    end

    pcall(function()
      if localPlayer.Character then
        return localPlayer.Character
      end

      return localPlayer.CharacterAdded:Wait()
    end)

    task.wait(0.6)

    for k = 1, 5 do
      pcall(function() localPlayer.Team = v60 end)
      pcall(function() localPlayer.TeamColor = v60.TeamColor end)
      pcall(function() localPlayer.Neutral = false end)

      task.wait(0.3)

      if localPlayer.Team == v60 then
        break
      end
    end
  end)
end

chatEverToggled = false

function applyChatState()
  local chatLoggerEnabled = Config.ChatLoggerEnabled

  if textChatService and textChatService.ChatVersion == Enum.ChatVersion.TextChatService then
    local chatWindowConfiguration = textChatService:FindFirstChild("ChatWindowConfiguration")

    if chatWindowConfiguration then
      chatWindowConfiguration.Enabled = chatLoggerEnabled
    end

    local textChat = coreGui:FindFirstChild("TextChat")

    if textChat then
      textChat.Enabled = chatLoggerEnabled
    end

    pcall(function()
      local chatWindowParent = textChatService:FindFirstChild("ChatWindowParent")

      if chatWindowParent then
        local chatWindow = chatWindowParent:FindFirstChild("ChatWindow")

        if chatWindow then
          chatWindow.Visible = chatLoggerEnabled
        end
      end
    end)
  else
    local chat = localPlayer.PlayerGui:FindFirstChild("Chat")

    if chat then
      chat.Enabled = chatLoggerEnabled
    end

    local chat2 = coreGui:FindFirstChild("Chat")

    if chat2 then
      chat2.Enabled = chatLoggerEnabled
    end
  end
end

task.spawn(function()
  while SentinelActive do
    task.wait(0.25)
  end
end)

task.spawn(function()
  coreGui.ChildAdded:Connect(function(child4)
    if Config.ChatLoggerEnabled then
      if child4.Name == "TextChat" or child4.Name == "Chat" then
        task.wait(0.2)
        applyChatState()
      end
    end
  end)

  if textChatService then
    textChatService.ChildAdded:Connect(function(child5)
      if Config.ChatLoggerEnabled and child5.Name == "ChatWindowConfiguration" then
        task.wait(0.2)
        applyChatState()
      end
    end)
  end

  localPlayer.PlayerGui.ChildAdded:Connect(function(child6)
    if Config.ChatLoggerEnabled and child6.Name == "Chat" then
      task.wait(0.2)
      applyChatState()
    end
  end)
end)

localPlayer.CharacterAdded:Connect(function(character21)
  task.spawn(function() applyNametags(character21) end)
  task.wait(1)

  local clientScripts2 = character21:FindFirstChild("ClientScripts")

  if clientScripts2 then
    local stagger2 = clientScripts2:FindFirstChild("Stagger")

    if stagger2 then
      stagger2.Disabled = not Config.StaggerEnabled
    end
  end

  canInfect = true

  if Config.StaggerImmune then
    character21:SetAttribute("StaggerImmune", true)
  end

  if Config.FlyEnabled then
    task.wait(0.5)
    FlySpeed = Config.FlySpeed
    enableFly(true)
  end

  if Config.ChatLoggerEnabled then
    task.wait(1)
    applyChatState()

    task.delay(2, function()
      if Config.ChatLoggerEnabled then
        applyChatState()
      end
    end)
  end
end)

if localPlayer.Character then
  applyNametags(localPlayer.Character)
  local clientScripts3 = localPlayer.Character:FindFirstChild("ClientScripts")

  if clientScripts3 then
    local stagger3 = clientScripts3:FindFirstChild("Stagger")

    if stagger3 then
      stagger3.Disabled = not Config.StaggerEnabled
    end
  end

  if Config.StaggerImmune then
    localPlayer.Character:SetAttribute("StaggerImmune", true)
  end
end

function toggleFakeInjured()
  if Config.FakeInjured then
    local character22 = localPlayer.Character

    if not character22 then
      return
    else
      local humanoid14 = character22:FindFirstChildOfClass("Humanoid")

      if not humanoid14 then
        return
      end

      if not FakeInjuredTrack then
        local animator9 = humanoid14:FindFirstChildOfClass("Animator")
          or Instance.new("Animator", humanoid14)

        local animation6 = Instance.new("Animation")
        animation6.AnimationId = "rbxassetid://94302036679429"

        FakeInjuredTrack = animator9:LoadAnimation(animation6)
        FakeInjuredTrack.Looped = true
      end

      return
    end
  else
    if FakeInjuredTrack then
      FakeInjuredTrack:Stop()
      FakeInjuredTrack = nil
    end

    return
  end
end

runService.Heartbeat:Connect(function()
  if not SentinelActive then
    return
  elseif not Config.FakeInjured then
    if FakeInjuredTrack and FakeInjuredTrack.IsPlaying then
      FakeInjuredTrack:Stop()
    end

    return
  else
    local character23 = localPlayer.Character

    if not character23 then
      return
    else
      local humanoid15 = character23:FindFirstChildOfClass("Humanoid")

      if not humanoid15 or humanoid15.Health <= 0 then
        if FakeInjuredTrack and FakeInjuredTrack.IsPlaying then
          FakeInjuredTrack:Stop()
        end

        return
      else
        local humanoidRootPart14 = character23:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart14 then
          if FakeInjuredTrack and FakeInjuredTrack.IsPlaying then
            FakeInjuredTrack:Stop()
          end

          return
        else
          local velocity2 = humanoidRootPart14.Velocity

          if Vector3.new(velocity2.X, 0, velocity2.Z).Magnitude < 0.5
            and humanoid15:GetState() ~= Enum.HumanoidStateType.Jumping
            and humanoid15:GetState() ~= Enum.HumanoidStateType.Freefall then
            if FakeInjuredTrack and not FakeInjuredTrack.IsPlaying then
              FakeInjuredTrack:Play()
            end
          elseif FakeInjuredTrack and FakeInjuredTrack.IsPlaying then
            FakeInjuredTrack:Stop()
          end

          return
        end
      end
    end
  end
end)

fakeDeathBV = nil
fakeDeathBP = nil

function toggleFakeDeath()
  local character24 = localPlayer.Character

  if not character24 then
    return
  else
    local humanoid16 = character24:FindFirstChildOfClass("Humanoid")

    if not humanoid16 then
      return
    end

    if Config.FakeDeath then
      if fakeDeathBV then
        fakeDeathBV:Destroy()
        fakeDeathBV = nil
      end

      if fakeDeathBP then
        fakeDeathBP:Destroy()
        fakeDeathBP = nil
      end

      local animator10 = humanoid16:FindFirstChildOfClass("Animator")

      local instance2 = animator10
      instance2 = animator10 or Instance.new("Animator", humanoid16)

      local animation7 = Instance.new("Animation")
      animation7.AnimationId = "rbxassetid://114023816208972"

      FakeDeathAnimTrack = instance2:LoadAnimation(animation7)
      FakeDeathAnimTrack.Looped = true
      FakeDeathAnimTrack:Play()

      humanoid16.PlatformStand = true
      humanoid16.WalkSpeed = 0
      humanoid16.JumpPower = 0

      local humanoidRootPart15 = character24:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart15 then
        fakeDeathBV = Instance.new("BodyVelocity")
        fakeDeathBV.MaxForce = Vector3.new(1000000, 1000000, 1000000)
        fakeDeathBV.Velocity = Vector3.new(0, 0, 0)
        fakeDeathBV.Parent = humanoidRootPart15

        fakeDeathBP = Instance.new("BodyPosition")
        fakeDeathBP.MaxForce = Vector3.new(1000000, 1000000, 1000000)
        fakeDeathBP.Position = humanoidRootPart15.Position + Vector3.new(0, 1, 0)
        fakeDeathBP.Parent = humanoidRootPart15
      end
    else
      if FakeDeathAnimTrack then
        FakeDeathAnimTrack:Stop()
        FakeDeathAnimTrack = nil
      end

      humanoid16.PlatformStand = false
      humanoid16.WalkSpeed = 9
      humanoid16.JumpPower = 50

      if fakeDeathBV then
        fakeDeathBV:Destroy()
        fakeDeathBV = nil
      end

      if fakeDeathBP then
        fakeDeathBP:Destroy()
        fakeDeathBP = nil
      end
    end

    return
  end
end

function suicideWithAnimation()
  local character25 = localPlayer.Character

  if not character25 then
    return
  else
    local humanoid17 = character25:FindFirstChildOfClass("Humanoid")

    if not humanoid17 then
      return
    else
      local animator11 = humanoid17:FindFirstChildOfClass("Animator")
        or Instance.new("Animator", humanoid17)

      local animation8 = Instance.new("Animation")
      animation8.AnimationId = "rbxassetid://82480275101558"

      local loadAnimation4 = animator11:LoadAnimation(animation8)
      loadAnimation4:Play()
      loadAnimation4.Stopped:Wait()

      humanoid17.Health = 0
      return
    end
  end
end

function removeElephantFoot()
  local v62 = false

  for index22, value26 in ipairs(workspace:GetDescendants()) do
    if value26.Name == "LookAtMe" then
      value26:Destroy()
      v62 = true
    end
  end

  if v62 then
    pcall(function()
      if WindUI then
        WindUI:Notify({ Title = "Success", Content = "Elephant foot removed", Duration = 3 })
      end
    end)
  else
    pcall(function()
      if WindUI then
        WindUI:Notify({
          Title = "Failed",
          Content = "Elephant foot already removed",
          Duration = 3,
        })
      end
    end)
  end
end

function removeArabicDud()
  local map = workspace:FindFirstChild("Map")
  local lobbySpawn = map and map:FindFirstChild("LobbySpawn")
  local arabic = lobbySpawn and lobbySpawn:FindFirstChild("Arabic")

  if arabic then
    arabic:Destroy()
  else
    pcall(function()
      if WindUI then
        WindUI:Notify({ Title = "Failed", Content = "Arabic dud not found", Duration = 5 })
      end
    end)
  end
end

function removeLobbyMusic()
  local count3 = 0

  for index23, value27 in ipairs(workspace:GetDescendants()) do
    if value27.Name == "Radio" then
      value27:Destroy()
      count3 = count3 + 1
    end
  end

  pcall(function()
    if WindUI then
      WindUI:Notify({
        Title = "Success",
        Content = "Removed " .. count3 .. " Radio(s)",
        Duration = 3,
      })
    end
  end)
end

function deleteAllDoors()
  local gameDoors = workspace:FindFirstChild("GameDoors")
  local v63

  if not gameDoors then
    pcall(function()
      if WindUI then
        WindUI:Notify({ Title = "Error", Content = "GameDoors not found", Duration = 3 })
      end
    end)

    return
  else
    local getChildren = gameDoors.GetChildren
    v63 = 0

    for index24, value28 in ipairs(getChildren(gameDoors)) do
      if value28.Name:match("Generator%d") then
        local doorsToOpen = value28:FindFirstChild("DoorsToOpen")

        if doorsToOpen then
          doorsToOpen:Destroy()
          v63 = v63 + 1
        end
      end
    end

    pcall(function()
      if WindUI then
        WindUI:Notify({
          Title = "Success",
          Content = "Deleted " .. v63 .. " DoorsToOpen folder(s)",
          Duration = 3,
        })
      end
    end)

    return
  end
end

function deleteAllLandmines()
  local count4 = 0

  for index25, value29 in ipairs(workspace:GetDescendants()) do
    if value29.Name == "Landmine" and value29:IsA("Model") then
      value29:Destroy()
      count4 = count4 + 1
    end
  end

  pcall(function()
    if WindUI then
      WindUI:Notify({
        Title = "Success",
        Content = "Deleted " .. count4 .. " landmines",
        Duration = 3,
      })
    end
  end)
end

teleportPoints = {
  ["Sector 1"] = {
    { "Spawn", Vector3.new(-55, -33, -1410) }, { "Generator 1", Vector3.new(135, -30, -1225) },
    { "Reactor 4", Vector3.new(-208, -32, -933) }, { "Mutant", Vector3.new(-281, -31, -671) },
    { "Valve", Vector3.new(-510, -43, -548) }, { "Generator 2", Vector3.new(-145, -30, -1149) },
  },
  ["Sector 2"] = {
    { "Sector entrance", Vector3.new(-110, -10, -825) },
    { "Russman's office", Vector3.new(38, -10, -917) },
    { "Armory", Vector3.new(-45, -10, -894) }, { "Keycard", Vector3.new(50, -10, -1054) },
    { "Steve Remington", Vector3.new(-30, 0, -1058) },
  },
  ["Sector 3"] = {
    { "Sector entrance", Vector3.new(208, -31, -1171) },
    { "Crates 1-3", Vector3.new(289, -31, -1216) }, { "Crate 4", Vector3.new(676, -31, -1342) },
    { "Crate 5", Vector3.new(597, -49, -1395) }, { "Crate 6", Vector3.new(471, -50, -1293) },
    { "C4 crate 1", Vector3.new(462, -31, -1004) },
    { "C4 crate 2", Vector3.new(349, -31, -817) },
    { "C4 crate 3", Vector3.new(636, -31, -754) },
    { "C4 crate 4", Vector3.new(843, -18, -1060) }, { "Keycard", Vector3.new(774, -31, -857) },
  },
}

function teleportTo(p64)
  local character26 = localPlayer.Character

  if character26 and character26:FindFirstChild("HumanoidRootPart") then
    character26:PivotTo(CFrame.new(p64))
  end
end

function teleportToCFrame(p65)
  local character27 = localPlayer.Character

  if character27 and character27:FindFirstChild("HumanoidRootPart") then
    character27:PivotTo(p65)
  end
end

RestrictedServerCFrame = CFrame.new(
  -80.9715881, -28.5348167, -1419.7843, 0.996191859, 0, 0.0871884301, 0, 1, 0, -0.0871884301, 0,
  0.996191859
)

toggleAnims = {
  ["Artur Novas's idle"] = "rbxassetid://105747901312742",
  ["Adam Dice (died)"] = "rbxassetid://114023816208972",
  ["Chimera's walk (old)"] = "rbxassetid://97147187591899",
  ["Chimera's run (old)"] = "rbxassetid://95054120636955",
  ["Sinitzyn's idle"] = "rbxassetid://110122744601596",
  ["Sinitzyn's stun"] = "rbxassetid://111159713841127",
  ["Kamikaze's walk"] = "rbxassetid://87989829896123",
  ["Kamikaze's run"] = "rbxassetid://78355773495995",
  ["Mikhail William's walk (old)"] = "rbxassetid://100407162198079",
  ["Mikhail William's run (old)"] = "rbxassetid://126189604062142",
  ["Mikhail William's walk"] = "rbxassetid://91584116987163",
  ["Mikhail William's run"] = "rbxassetid://88561714950741",
  ["Dave's walk"] = "rbxassetid://102796637818967",
  ["Dave's idle"] = "rbxassetid://114416822114803",
  ["Dave's run"] = "rbxassetid://117962541964796",
  ["Gilbert's idle"] = "rbxassetid://93686257760742",
  ["Gabriel Campos's idle"] = "rbxassetid://90243612758647",
  ["Elsher Tachyon's idle"] = "rbxassetid://77191557762002",
  ["Lurker's idle"] = "rbxassetid://86501473853720",
  ["Lurker's sleeping"] = "rbxassetid://115201807246648",
  ["Manhattan Ristretto's idle"] = "rbxassetid://137802244588968",
  Masterbait = "rbxassetid://72042024",
  ["Mikhail Willaim's idle (old)"] = "rbxassetid://88875709567990",
  ["Mikhail William's idle"] = "rbxassetid://87959458481723",
  ["Mutant crawler idle"] = "rbxassetid://81279098398635",
  ["Slasher's idle (old)"] = "rbxassetid://91056825760026",
  ["Slasher's idle"] = "rbxassetid://95464797704887",
  ["Slasher's walk"] = "rbxassetid://139858886667310",
  ["Slasher's stun"] = "rbxassetid://137568989278456",
  ["Slasher's run"] = "rbxassetid://94555617501510",
  ["Stan's idle"] = "rbxassetid://108552997989260",
  ["MGF scared"] = "rbxassetid://86398576306953",
  ["MGF patrol"] = "rbxassetid://131603010936163",
  ["MGF musician"] = "rbxassetid://138827413895574",
  ["MGF dying"] = "rbxassetid://128467654154071",
  ["MGF medic"] = "rbxassetid://129366509916255",
  ["MGF injured"] = "rbxassetid://94302036679429",
  ["MGF idle (1)"] = "rbxassetid://113537404842453",
  ["MGF idle (2)"] = "rbxassetid://102193570284695",
  ["Viral Executioner's idle"] = "rbxassetid://97492866706742",
  ["Viral Executioner's walk"] = "rbxassetid://103392791669526",
  ["Viral Commander's walk"] = "rbxassetid://17621267464",
  ["Viral Commander's run"] = "rbxassetid://111821553591135",
  ["Head shake"] = "rbxassetid://118621065272904",
  Unstable = "rbxassetid://9146103628",
  ["Josh Katzmann idle"] = "rbxassetid://131498119560497",
  ["Josh Katzmann healed idle"] = "rbxassetid://139426604018597",
}

buttonAnims = {
  ["Adam Dice's death"] = "rbxassetid://102514666836619",
  ["Chimera's victim (old)"] = "rbxassetid://83991914102646",
  ["Chimera's teleport (old)"] = "rbxassetid://126809285460597",
  ["Chimera's enrage (old)"] = "rbxassetid://75151963392982",
  ["Chimera's execution (old)"] = "rbxassetid://97305733594978",
  ["Chimera's death"] = "rbxassetid://72189339897414",
  ["Chimera's execution"] = "rbxassetid://128010889227844",
  ["Chimera's enrage"] = "rbxassetid://99134420474156",
  ["Chimera's teleport (1)"] = "rbxassetid://112732398453305",
  ["Chimera's teleport (2)"] = "rbxassetid://136368566634578",
  ["Chimera's teleport execution (1)"] = "rbxassetid://112634711476303",
  ["Chimera's teleport execution (2)"] = "rbxassetid://135404812014332",
  ["Chimera's last stand"] = "rbxassetid://110849469223486",
  ["Chimera's punch"] = "rbxassetid://84314656273153",
  ["Cultist's dropkick"] = "rbxassetid://103266367846238",
  ["Cultist's miss"] = "rbxassetid://120641479913190",
  ["Cloaker's run"] = "rbxassetid://131730874916280",
  ["Controllable infected's turn (old)"] = "rbxassetid://136775254837264",
  Cough = "rbxassetid://111615919261340",
  ["Gilbert's execution"] = "rbxassetid://125655523925085",
  ["Gilbert's victim"] = "rbxassetid://135138331651211",
  ["D-Zero's vent"] = "rbxassetid://116242805691656",
  ["D-Zero's execution"] = "rbxassetid://127050736497150",
  ["Sinitzyn's swing"] = "rbxassetid://109639053938974",
  ["Sinitzyn's kick"] = "rbxassetid://139352596916392",
  ["Sinitzyn's enrage"] = "rbxassetid://98239206283649",
  ["Sinitzyn's execution (RPD)"] = "rbxassetid://136147569002553",
  ["Sinitzyn's execution (melee)"] = "rbxassetid://81984907411347",
  ["Sinitzyn's explosion"] = "rbxassetid://99615889025883",
  ["Slasher's swing"] = "rbxassetid://103822882233361",
  ["Slasher's execution"] = "rbxassetid://132206439126644",
  ["Slasher's victim"] = "rbxassetid://133617679957232",
  ["Shielder's execution"] = "rbxassetid://90580282540451",
  ["Slit Neck"] = "rbxassetid://130568157355000",
  ["Infection fall (1)"] = "rbxassetid://99985127815659",
  ["Infection fall (2)"] = "rbxassetid://139465334169627",
  ["Iris's rage"] = "rbxassetid://102771532479094",
  Kick = "rbxassetid://86079982232120",
  Punch = "rbxassetid://83700864626681",
  Taunt = "rbxassetid://80378935722704",
  ["Josh Katzmann healed"] = "rbxassetid://85697630315285",
  ["Lurker awaking"] = "rbxassetid://138937044212276",
  ["Mutant stun"] = "rbxassetid://111539044506405",
  ["Elephant foot"] = "rbxassetid://139981313122152",
  ["Riser's resurrection"] = "rbxassetid://116866937096686",
  ["Riser's death"] = "rbxassetid://89976361144233",
  ["Hatred kill (1)"] = "rbxassetid://138691140561523",
  ["Hatred kill (2)"] = "rbxassetid://91463196236370",
  ["Hatred kill (3)"] = "rbxassetid://83632013221100",
  ["Hatred kill (4)"] = "rbxassetid://91849031357031",
  ["Viral runner's execution"] = "rbxassetid://84530831648572",
  ["Viral runner's victim"] = "rbxassetid://76887258783187",
  ["Viral runner's maul"] = "rbxassetid://135884501960780",
  ["Viral runner's maul victim"] = "rbxassetid://118194067755191",
  ["Viral leader's execution"] = "rbxassetid://84358691838862",
  ["Viral leader's victim"] = "rbxassetid://76887258783187",
  ["Viral slasher's execution"] = "rbxassetid://132206439126644",
  ["Viral slasher's victim"] = "rbxassetid://133617679957232",
  ["MGF's last stand"] = "rbxassetid://117105602056649",
}

activeAnimTrack = nil

function playToggleAnim(animationId3, p66)
  local character28 = localPlayer.Character

  if not character28 then
    return
  else
    local humanoid18 = character28:FindFirstChildOfClass("Humanoid")

    if not humanoid18 then
      return
    else
      local animator12 = humanoid18:FindFirstChildOfClass("Animator")
        or Instance.new("Animator", humanoid18)

      if p66 then
        if activeAnimTrack then
          activeAnimTrack:Stop()
        end

        local animation9 = Instance.new("Animation")
        animation9.AnimationId = animationId3

        activeAnimTrack = animator12:LoadAnimation(animation9)
        activeAnimTrack.Looped = true
        activeAnimTrack:Play()
      elseif activeAnimTrack then
        activeAnimTrack:Stop()
        activeAnimTrack = nil
      end

      return
    end
  end
end

function playButtonAnim(animationId4)
  local character29 = localPlayer.Character

  if not character29 then
    return
  else
    local humanoid19 = character29:FindFirstChildOfClass("Humanoid")

    if not humanoid19 then
      return
    else
      local animator13 = humanoid19:FindFirstChildOfClass("Animator")
        or Instance.new("Animator", humanoid19)

      local animation10 = Instance.new("Animation")
      animation10.AnimationId = animationId4

      animator13:LoadAnimation(animation10):Play()
      return
    end
  end
end

function getCooldownContainer()
  local playerGui4 = localPlayer:FindFirstChild("PlayerGui")

  if not playerGui4 then
    return nil
  else
    local character30 = localPlayer.Character
    local tool = character30 and character30:FindFirstChildOfClass("Tool")

    if not tool then
      return nil
    else
      local findFirstChild4 = playerGui4:FindFirstChild(tool.Name)

      return findFirstChild4 and findFirstChild4:FindFirstChild("Data")
        and findFirstChild4.Data:FindFirstChild("Cooldowns")
    end
  end
end

function setCooldownVisibility(p67, visible)
  local v64 = getCooldownContainer()

  if not v64 then
    return
  else
    local findFirstChild5 = v64:FindFirstChild(p67)

    if findFirstChild5 then
      findFirstChild5.Visible = visible
    end

    v64.Visible = (v64:FindFirstChild("Bash") and v64.Bash.Visible
          or v64:FindFirstChild("Kick") and v64.Kick.Visible)
        and true
      or false

    return
  end
end

function resetFade(p68)
  for index26, value30 in ipairs(p68:GetDescendants()) do
    if value30:IsA("Frame") and value30:GetAttribute("_cd_BackgroundTransparency") then
      value30.BackgroundTransparency = value30:GetAttribute("_cd_BackgroundTransparency")
    elseif value30:IsA("ImageLabel") or value30:IsA("ImageButton") then
      if value30:GetAttribute("_cd_ImageTransparency") then
        value30.ImageTransparency = value30:GetAttribute("_cd_ImageTransparency")
      end

      if value30:GetAttribute("_cd_BackgroundTransparency") then
        value30.BackgroundTransparency = value30:GetAttribute("_cd_BackgroundTransparency")
      end
    elseif value30:IsA("TextLabel") or value30:IsA("TextButton") or value30:IsA("TextBox") then
      if value30:GetAttribute("_cd_TextTransparency") then
        value30.TextTransparency = value30:GetAttribute("_cd_TextTransparency")
      end

      if value30:GetAttribute("_cd_BackgroundTransparency") then
        value30.BackgroundTransparency = value30:GetAttribute("_cd_BackgroundTransparency")
      end
    elseif value30:IsA("UIStroke") and value30:GetAttribute("_cd_Transparency") then
      value30.Transparency = value30:GetAttribute("_cd_Transparency")
    end
  end
end

function fadeOut(p69, p70)
  local tweenInfo = TweenInfo.new(p70, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

  for index27, value31 in ipairs(p69:GetDescendants()) do
    if value31:IsA("Frame") then
      if not value31:GetAttribute("_cd_BackgroundTransparency") then
        value31:SetAttribute("_cd_BackgroundTransparency", value31.BackgroundTransparency)
      end

      tweenService:Create(value31, tweenInfo, { BackgroundTransparency = 1 }):Play()
    elseif value31:IsA("ImageLabel") or value31:IsA("ImageButton") then
      if not value31:GetAttribute("_cd_ImageTransparency") then
        value31:SetAttribute("_cd_ImageTransparency", value31.ImageTransparency)
      end

      if not value31:GetAttribute("_cd_BackgroundTransparency") then
        value31:SetAttribute("_cd_BackgroundTransparency", value31.BackgroundTransparency)
      end

      tweenService:Create(value31, tweenInfo, {
        ImageTransparency = 1,
        BackgroundTransparency = 1,
      }):Play()
    elseif value31:IsA("TextLabel") or value31:IsA("TextButton") or value31:IsA("TextBox") then
      if not value31:GetAttribute("_cd_TextTransparency") then
        value31:SetAttribute("_cd_TextTransparency", value31.TextTransparency)
      end

      if not value31:GetAttribute("_cd_BackgroundTransparency") then
        value31:SetAttribute("_cd_BackgroundTransparency", value31.BackgroundTransparency)
      end

      tweenService:Create(value31, tweenInfo, {
        TextTransparency = 1,
        BackgroundTransparency = 1,
      }):Play()
    elseif value31:IsA("UIStroke") then
      if not value31:GetAttribute("_cd_Transparency") then
        value31:SetAttribute("_cd_Transparency", value31.Transparency)
      end

      tweenService:Create(value31, tweenInfo, { Transparency = 1 }):Play()
    end
  end
end

function getCooldownBar(p71)
  local playerGui5 = localPlayer:FindFirstChild("PlayerGui")

  if not playerGui5 then
    return nil
  else
    local character31 = localPlayer.Character
    local tool2 = character31 and character31:FindFirstChildOfClass("Tool")

    if not tool2 then
      return nil
    else
      local findFirstChild6 = playerGui5:FindFirstChild(tool2.Name)

      if findFirstChild6 and findFirstChild6:FindFirstChild("Data")
        and findFirstChild6.Data:FindFirstChild("Cooldowns")
        and findFirstChild6.Data.Cooldowns:FindFirstChild(p71) then
        return findFirstChild6.Data.Cooldowns[p71]:FindFirstChild("Bar")
      end

      return nil
    end
  end
end

function playCooldown(p72, p73, p74)
  local cooldownCounter = CooldownCounter
  local v65 = getCooldownBar(p72)
  local v66, create2

  if not v65 then
    return
  else
    v66 = getCooldownContainer()
    local findFirstChild7 = v66 and v66:FindFirstChild(p72)

    if findFirstChild7 then
      resetFade(findFirstChild7)
    end

    if ActiveTweens[p72] then
      ActiveTweens[p72]:Cancel()
      ActiveTweens[p72] = nil
    end

    v65.AnchorPoint = Vector2.new(0, 1)
    v65.Position = UDim2.new(0, 0, 1, 0)
    v65.Size = UDim2.new(1, 0, math.clamp(p74 or 0, 0, 1), 0)
    v65.Visible = true

    create2 = tweenService:Create(v65, TweenInfo.new(
      p73, Enum.EasingStyle.Linear, Enum.EasingDirection.Out
    ), { Size = UDim2.new(1, 0, 1, 0) })

    ActiveTweens[p72] = create2

    if v66 then
      setCooldownVisibility(p72, true)
    end

    create2:Play()

    create2.Completed:Connect(function()
      if cooldownCounter ~= CooldownCounter or ActiveTweens[p72] ~= create2 then
        return
      end

      ActiveTweens[p72] = nil
      CooldownData[p72] = nil

      if findFirstChild7 then
        fadeOut(findFirstChild7, 0.2)
      end

      task.delay(0.2, function()
        if cooldownCounter ~= CooldownCounter then
          return
        end

        v65.Visible = false

        if v66 then
          setCooldownVisibility(p72, false)
        end

        if findFirstChild7 then
          resetFade(findFirstChild7)
        end
      end)
    end)

    return
  end
end

function renderCooldown(p75)
  local v67 = CooldownData[p75]

  if not v67 then
    if getCooldownContainer() then
      setCooldownVisibility(p75, false)
    end

    return
  else
    local v68 = tick()
    local v69 = v67.finish - v68

    if v69 <= 0 then
      CooldownData[p75] = nil

      if getCooldownContainer() then
        setCooldownVisibility(p75, false)
      end

      return
    end

    playCooldown(
      p75, v69, v67.duration > 0 and math.clamp((v68 - v67.start) / v67.duration, 0, 1) or 0
    )

    return
  end
end

function renderAllCooldowns()
  CooldownCounter = CooldownCounter + 1

  for key7, value32 in pairs(ActiveTweens) do
    if value32 then
      value32:Cancel()
    end

    ActiveTweens[key7] = nil
  end

  renderCooldown("Bash")
  renderCooldown("Kick")
end

if BashCooldownUI then
  BashCooldownUI.OnClientEvent:Connect(function(p76, p77)
    local v70 = p76

    if v70 == "bash" then
      v70 = "Bash"
    end

    if v70 == "kick" then
      v70 = "Kick"
    end

    local v71 = tick()
    CooldownData[v70] = { start = v71, duration = p77, finish = v71 + p77 }
    renderAllCooldowns()
  end)
end

userInputService.InputBegan:Connect(function(input6, p78)
  SentinelLastInteraction = tick()

  if p78 then
    return
  end

  if input6.KeyCode == Enum.KeyCode.LeftShift or input6.KeyCode == Enum.KeyCode.RightShift then
    isShiftHeld = true
  end
end)

userInputService.InputChanged:Connect(function() SentinelLastInteraction = tick() end)

userInputService.InputEnded:Connect(function(input7)
  if input7.KeyCode == Enum.KeyCode.LeftShift or input7.KeyCode == Enum.KeyCode.RightShift then
    isShiftHeld = false
    local character32 = localPlayer.Character

    if character32 then
      local humanoid20 = character32:FindFirstChildOfClass("Humanoid")

      if humanoid20 and Config.SpeedHackEnabled then
        humanoid20.WalkSpeed = Config.WalkSpeedValue
      end
    end
  end
end)

task.spawn(function()
  while SentinelActive do
    task.wait(0.2)

    if Config.AutoWipeBlood then
      pcall(function()
        local gui2 = localPlayer.PlayerGui:FindFirstChild("Gui")

        if gui2 then
          for key8, clean in pairs(gui2:GetChildren()) do
            if clean.Name == "blood" then
              clean.Name = "clean"
              tweenService:Create(clean, TweenInfo.new(0.2), { ImageTransparency = 1 }):Play()
              debris:AddItem(clean, 0.5)
            end
          end
        end
      end)
    end
  end
end)

function hookToolSwap(p79)
  p79.ChildAdded:Connect(function(child7)
    if child7:IsA("Tool") then
      task.defer(renderAllCooldowns)
    end
  end)

  p79.ChildRemoved:Connect(function(child8)
    if child8:IsA("Tool") then
      task.defer(renderAllCooldowns)
    end
  end)
end

if localPlayer.Character then
  hookToolSwap(localPlayer.Character)
  task.defer(renderAllCooldowns)
end

localPlayer.CharacterAdded:Connect(function(character33)
  hookToolSwap(character33)
  task.defer(renderAllCooldowns)
  character33:WaitForChild("Humanoid", 5)

  if Config.FakeDeath then
    task.wait(0.5)
    toggleFakeDeath()
  end

  if Config.FakeInjured then
    task.wait(0.5)
    toggleFakeInjured()
  end

  canInfect = true

  if Config.StaggerImmune then
    character33:SetAttribute("StaggerImmune", true)
  end

  if Config.FlyEnabled then
    task.wait(0.5)
    FlySpeed = Config.FlySpeed
    enableFly(true)
  end

  if Config.ChatLoggerEnabled then
    task.wait(1)
    applyChatState()

    task.delay(2, function()
      if Config.ChatLoggerEnabled then
        applyChatState()
      end
    end)
  end

  if Config.NightStalkerInfAmmo then
    task.wait(0.5)
  end
end)

ClientEvents = replicatedStorage:FindFirstChild("Events")

if ClientEvents and ClientEvents:FindFirstChild("client")
  and ClientEvents.client:FindFirstChild("Event") then
  pcall(function()
    ClientEvents.client.Event:Connect(function(p80, ...)
      if Config.AntiCamShake and (p80 == "camspring" or p80 == "recoil" or p80 == "shake") then
        return
      end
    end)
  end)
end

function checkMob(p81)
  local characters4 = workspace:FindFirstChild("Characters")

  if characters4 and not p81:IsDescendantOf(characters4) then
    return
  end

  if p81:IsA("Model") and p81:FindFirstChild("HumanoidRootPart")
    and p81:FindFirstChildOfClass("Humanoid") then
    if p81 ~= localPlayer.Character and p81.Name ~= localPlayer.Name
      and not players:GetPlayerFromCharacter(p81) and not table.find(CachedMobs, p81) then
      table.insert(CachedMobs, p81)
      p81.AncestryChanged:Connect(function(p82, p83) end)
    end
  end
end

task.spawn(function()
  local characters5 = workspace:FindFirstChild("Characters")

  for index28, value33 in ipairs(characters5 and characters5:GetDescendants()
    or workspace:GetDescendants()) do
    checkMob(value33)

    if index28 % 200 == 0 then
      task.wait()
    end
  end
end)

local descendantAdded = workspace.DescendantAdded

local function f31(p84)
  if not p84 then
    return
  else
    local humanoidRootPart16 = p84:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart16 then
      local sentinelInfoBBG = humanoidRootPart16:FindFirstChild("SentinelInfoBBG")

      if sentinelInfoBBG then
        sentinelInfoBBG:Destroy()
      end
    end

    return
  end
end

descendantAdded:Connect(function(p85)
  if p85:IsA("Model") then
    task.wait(0.3)
    checkMob(p85)
  end
end)

local jumpRequest = userInputService.JumpRequest

local function f32(p86)
  if not p86 then
    return
  end

  for index29, value34 in ipairs(p86) do
    value34.Visible = false
  end
end

jumpRequest:Connect(function()
  local character34 = localPlayer.Character
  local humanoid21 = character34 and character34:FindFirstChildOfClass("Humanoid")
  local humanoidRootPart17 = character34 and character34:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart17 or not humanoid21 then
    return
  else
    local jumpPowerValue = Config.JumpPowerEnabled and Config.JumpPowerValue or 50

    if Config.InfiniteJump then
      humanoidRootPart17.Velocity = Vector3.new(
        humanoidRootPart17.Velocity.X, jumpPowerValue, humanoidRootPart17.Velocity.Z
      )

      humanoid21:ChangeState(Enum.HumanoidStateType.Jumping)
    end

    if Config.JumpBypassActive and not Config.InfiniteJump then
      if humanoid21.FloorMaterial ~= Enum.Material.Air then
        humanoidRootPart17.Velocity = Vector3.new(
          humanoidRootPart17.Velocity.X, jumpPowerValue, humanoidRootPart17.Velocity.Z
        )
      end
    end

    return
  end
end)

local function f33(p87, p88, color, thickness)
  if not p87 or not p88 then
    return
  else
    local humanoidRootPart18 = p88:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart18 then
      for index30, value35 in ipairs(p87) do
        value35.Visible = false
      end

      return
    else
      local humanoid22 = p88:FindFirstChildOfClass("Humanoid")

      if not humanoid22 or humanoid22.Health <= 0 then
        for index31, value36 in ipairs(p87) do
          value36.Visible = false
        end

        return
      else
        local position5 = humanoidRootPart18.Position
        local position6 = currentCamera.CFrame.Position
        local cframe2 = CFrame.lookAt(position5, position5 + (position5 - position6).Unit)
        local x = humanoidRootPart18.Size.X
        local v72 = humanoidRootPart18.Size.Y * 1.5
        local cframe3 = CFrame.new(-x, v72, 0)
        local cframe4 = CFrame.new(x, v72, 0)
        local cframe5 = CFrame.new(-x, -v72, 0)
        local cframe6 = CFrame.new(x, -v72, 0)
        local v73, v74 = currentCamera:WorldToViewportPoint((cframe2 * cframe3).p)
        local v75, v76 = currentCamera:WorldToViewportPoint((cframe2 * cframe4).p)
        local v77, v78 = currentCamera:WorldToViewportPoint((cframe2 * cframe5).p)
        local v79, v80 = currentCamera:WorldToViewportPoint((cframe2 * cframe6).p)

        if not v74 then
          for index32, value37 in ipairs(p87) do
            value37.Visible = false
          end

          return
        else
          local magnitude4 = (position5 - position6).Magnitude
          local v81 = math.clamp(1 / magnitude4 * 750, 2, 300)

          p87[1].From = Vector2.new(v73.X, v73.Y)
          p87[1].To = Vector2.new(v73.X + v81, v73.Y)
          p87[2].From = Vector2.new(v73.X, v73.Y)
          p87[2].To = Vector2.new(v73.X, v73.Y + v81)
          p87[3].From = Vector2.new(v75.X, v75.Y)
          p87[3].To = Vector2.new(v75.X - v81, v75.Y)
          p87[4].From = Vector2.new(v75.X, v75.Y)
          p87[4].To = Vector2.new(v75.X, v75.Y + v81)
          p87[5].From = Vector2.new(v77.X, v77.Y)
          p87[5].To = Vector2.new(v77.X + v81, v77.Y)
          p87[6].From = Vector2.new(v77.X, v77.Y)
          p87[6].To = Vector2.new(v77.X, v77.Y - v81)
          p87[7].From = Vector2.new(v79.X, v79.Y)
          p87[7].To = Vector2.new(v79.X - v81, v79.Y)
          p87[8].From = Vector2.new(v79.X, v79.Y)
          p87[8].To = Vector2.new(v79.X, v79.Y - v81)

          for index33, value38 in ipairs(p87) do
            value38.Color = color

            if Config.BoxAutoThickness then
              value38.Thickness = math.clamp(1 / magnitude4 * 100, 1, 4)
            else
              value38.Thickness = thickness
            end

            value38.Visible = true
            value38.Transparency = 1
          end

          return
        end
      end
    end
  end
end

local v82 = {}

local function f34(p89)
  if not p89 then
    return
  end

  for index34, value39 in ipairs(p89) do
    local v83 = value39
    pcall(function() v83:Remove() end)
  end
end

local function f35(color2, thickness2)
  local v84 = {}

  if not Capabilities.Drawing then
    return v84
  else
    local count5 = 0

    while true do
      count5 = 1 + count5

      if not (count5 <= 8) then
        break
      end

      local line = Drawing.new("Line")
      line.Visible = false
      line.From = Vector2.new(0, 0)
      line.To = Vector2.new(0, 0)
      line.Color = color2
      line.Thickness = thickness2
      line.Transparency = 1

      v84[count5] = line
    end

    return v84
  end
end

local f36

local function f37(p90, textColor3, p91, p92, p93, p94)
  if not p90 then
    return
  else
    local v85 = f36(p90)

    if not v85 then
      return
    else
      local name2 = v85:FindFirstChild("Name")
      local health = v85:FindFirstChild("Health")
      local distance = v85:FindFirstChild("Distance")

      if name2 then
        name2.Visible = p91

        if p91 then
          local getPlayerFromCharacter = players:GetPlayerFromCharacter(p90)
          name2.Text = getPlayerFromCharacter and getPlayerFromCharacter.Name or p90.Name
          name2.TextColor3 = textColor3
        end
      end

      if health then
        health.Visible = p92

        if p92 then
          local humanoid23 = p90:FindFirstChildOfClass("Humanoid")

          if humanoid23 then
            health.Text = math.round(humanoid23.Health) .. " HP"
            health.TextColor3 = textColor3
          end
        end
      end

      if distance then
        distance.Visible = p93

        if p93 and p94 then
          distance.Text = string.format("%.1f m", p94)
          distance.TextColor3 = textColor3
        end
      end

      return
    end
  end
end

function f36(p95)
  if not p95 then
    return nil
  else
    local humanoidRootPart19 = p95:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart19 then
      return nil
    else
      local sentinelInfoBBG2 = humanoidRootPart19:FindFirstChild("SentinelInfoBBG")

      if not sentinelInfoBBG2 then
        sentinelInfoBBG2 = Instance.new("BillboardGui")
        sentinelInfoBBG2.Name = "SentinelInfoBBG"
        sentinelInfoBBG2.Size = UDim2.new(0, 200, 0, 60)
        sentinelInfoBBG2.AlwaysOnTop = true
        sentinelInfoBBG2.StudsOffset = Vector3.new(0, 3.5, 0)
        sentinelInfoBBG2.Adornee = humanoidRootPart19
        sentinelInfoBBG2.Parent = humanoidRootPart19

        local uiListLayout = Instance.new("UIListLayout")
        uiListLayout.FillDirection = Enum.FillDirection.Vertical
        uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
        uiListLayout.Parent = sentinelInfoBBG2

        local name3 = Instance.new("TextLabel")
        name3.Name = "Name"
        name3.Size = UDim2.new(1, 0, 0, 16)
        name3.BackgroundTransparency = 1
        name3.TextStrokeTransparency = 0.5
        name3.Font = Enum.Font.SourceSansBold
        name3.TextSize = 14
        name3.Visible = false
        name3.Parent = sentinelInfoBBG2

        local health2 = Instance.new("TextLabel")
        health2.Name = "Health"
        health2.Size = UDim2.new(1, 0, 0, 14)
        health2.BackgroundTransparency = 1
        health2.TextStrokeTransparency = 0.5
        health2.Font = Enum.Font.SourceSans
        health2.TextSize = 12
        health2.Visible = false
        health2.Parent = sentinelInfoBBG2

        local distance2 = Instance.new("TextLabel")
        distance2.Name = "Distance"
        distance2.Size = UDim2.new(1, 0, 0, 14)
        distance2.BackgroundTransparency = 1
        distance2.TextStrokeTransparency = 0.5
        distance2.TextColor3 = Color3.fromRGB(200, 200, 200)
        distance2.Font = Enum.Font.SourceSans
        distance2.TextSize = 12
        distance2.Visible = false
        distance2.Parent = sentinelInfoBBG2
      end

      return sentinelInfoBBG2
    end
  end
end

runService.RenderStepped:Connect(function(delta2)
  local humanoid24, tool3, tool4, character35, maxDistance

  if not SentinelActive then
    return
  else
    local character36 = localPlayer.Character

    if not character36 then
      return
    end

    humanoid24 = character36:FindFirstChildOfClass("Humanoid")

    if not humanoid24 or humanoid24.Health <= 0 then
      return
    else
      if Config.SpeedHackEnabled then
        humanoid24.WalkSpeed = Config.WalkSpeedValue
      end

      if Config.JumpPowerEnabled then
        pcall(function()
          humanoid24.UseJumpPower = true
          humanoid24.JumpPower = Config.JumpPowerValue
        end)
      end

      if Config.InfiniteStaminaEnabled then
        local playerGui6 = localPlayer:FindFirstChild("PlayerGui")

        if playerGui6 then
          local gui3 = playerGui6:FindFirstChild("Gui")

          if gui3 then
            local heartbeat = gui3:FindFirstChild("heartbeat")

            if heartbeat then
              if heartbeat:IsA("Sound") then
                heartbeat:Stop()
              end

              heartbeat:Destroy()
            end

            local heartbeat2 = gui3:FindFirstChild("heartbeat2")

            if heartbeat2 then
              if heartbeat2:IsA("Sound") then
                heartbeat2:Stop()
              end

              heartbeat2:Destroy()
            end

            local vignette = gui3:FindFirstChild("vignette")

            if vignette then
              vignette.Visible = false
            end

            local statusFrame = gui3:FindFirstChild("statusFrame")

            if statusFrame then
              local stamina = statusFrame:FindFirstChild("stamina")

              if stamina then
                local bar = stamina:FindFirstChild("bar")

                if bar then
                  bar.Size = UDim2.new(1, 0, 1, 0)
                end

                local overlay = stamina:FindFirstChild("overlay")

                if overlay then
                  overlay.Visible = false
                end
              end
            end
          end
        end
      end

      if Config.FullBright then
        lighting.Ambient = Color3.fromRGB(255, 255, 255)
        lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        lighting.Brightness = 2
      end

      if Config.NoFog then
        lighting.FogEnd = 999999999
        lighting.FogStart = 999999999
      else
        lighting.FogEnd = OrigFogEnd
        lighting.FogStart = OrigFogStart
      end

      if Config.ImmuneLookHazard then
        if gameAee then
          gameAee.Contrast = 0
        end

        if gameRadiationTint then
          gameRadiationTint.Contrast = 0
        end
      end

      if Config.CustomFOVEnabled then
        if currentCamera.FieldOfView ~= Config.FOVValue then
          tweenService:Create(
            currentCamera, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { FieldOfView = Config.FOVValue }
          ):Play()
        end
      elseif currentCamera.FieldOfView ~= OrigFOV then
        tweenService:Create(
          currentCamera, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
          { FieldOfView = OrigFOV }
        ):Play()
      end

      if Config.UnlockThirdPerson then
        if localPlayer.CameraMode ~= Enum.CameraMode.Classic then
          localPlayer.CameraMode = Enum.CameraMode.Classic
        end

        if localPlayer.CameraMaxZoomDistance < 999 then
          localPlayer.CameraMaxZoomDistance = 999
        end
      else
        if localPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
          localPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
        end

        if localPlayer.CameraMaxZoomDistance > 50 then
          localPlayer.CameraMaxZoomDistance = 50
        end
      end

      if Config.AntiAnchorEnabled then
        local character37 = localPlayer.Character

        if character37 then
          local humanoidRootPart20 = character37:FindFirstChild("HumanoidRootPart")

          if humanoidRootPart20 and humanoidRootPart20.Anchored then
            humanoidRootPart20.Anchored = false
          end
        end
      end

      if Config.ViewModelEnabled then
        tool3 = character36:FindFirstChildWhichIsA("Tool")

        if tool3 then
          pcall(function() f5(tool3) end)
        end
      end

      if Config.CustomWeaponsEnabled then
        tool4 = character36:FindFirstChildWhichIsA("Tool")

        if tool4 then
          pcall(function() f7(tool4) end)
        end
      end

      character35 = localPlayer.Character
      local humanoidRootPart21 = character35 and character35:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart21 then
        return
      else
        maxDistance = Config.MaxDistance

        if type(maxDistance) ~= "number" then
          maxDistance = 1000
          Config.MaxDistance = 1000
        end

        local v86 = {}

        for key9, value40 in pairs(v82) do
          if not key9 or not key9.Parent then
            table.insert(v86, key9)
          end
        end

        for index35, value41 in ipairs(v86) do
          if v82[value41] then
            f34(v82[value41])
            v82[value41] = nil
          end

          f31(value41)
        end

        pcall(function()
          local colorFriends, highlightFriends, boxFriends, showNameFriends, showHealthFriends,
            showDistanceFriends

          for key10, value42 in pairs(players:GetPlayers()) do
            local v87 = value42

            if v87 ~= localPlayer then
              local character38 = v87.Character

              local humanoidRootPart22 = character38

              humanoidRootPart22 = character38
                and character38:FindFirstChild("HumanoidRootPart")

              local humanoid25 = character38
              humanoid25 = character38 and character38:FindFirstChildOfClass("Humanoid")

              if humanoidRootPart22 and humanoid25 then
                local magnitude5 = (humanoidRootPart21.Position - humanoidRootPart22.Position).Magnitude

                local v88, v89 = pcall(function()
                  return localPlayer:IsFriendsWith(v87.UserId)
                end)

                local v90 = v89

                if not v88 then
                  v90 = false
                end

                if v90 then
                  colorFriends = Config.ColorFriends
                  highlightFriends = Config.HighlightFriends
                  boxFriends = Config.BoxFriends
                  showNameFriends = Config.ShowNameFriends
                  showHealthFriends = Config.ShowHealthFriends
                  showDistanceFriends = Config.ShowDistanceFriends
                else
                  colorFriends = Config.ColorPlayer
                  highlightFriends = Config.HighlightPlayer
                  boxFriends = Config.BoxPlayers
                  showNameFriends = Config.ShowNamePlayers
                  showHealthFriends = Config.ShowHealthPlayers
                  showDistanceFriends = Config.ShowDistancePlayers
                end

                if magnitude5 <= maxDistance and humanoid25.Health > 0 then
                  local sentinelHL = character38:FindFirstChild("SentinelHL")

                  if highlightFriends then
                    if not sentinelHL then
                      sentinelHL = Instance.new("Highlight", character38)
                      sentinelHL.Name = "SentinelHL"
                    end

                    sentinelHL.FillColor = colorFriends
                    sentinelHL.FillTransparency = Config.HLFillTrans
                    sentinelHL.OutlineTransparency = Config.HLOutlineTrans
                  elseif sentinelHL then
                    sentinelHL:Destroy()
                  end

                  if boxFriends then
                    if not v82[character38] then
                      v82[character38] = f35(colorFriends, Config.BoxThickness)
                    end

                    f33(v82[character38], character38, colorFriends, Config.BoxThickness)
                  elseif v82[character38] then
                    f32(v82[character38])
                  end

                  f37(
                    character38, colorFriends, showNameFriends, showHealthFriends,
                    showDistanceFriends, magnitude5
                  )
                else
                  if v82[character38] then
                    f32(v82[character38])
                  end

                  if character38:FindFirstChild("SentinelHL") then
                    character38.SentinelHL:Destroy()
                  end

                  f31(character38)
                end
              elseif character38 then
                if v82[character38] then
                  f34(v82[character38])
                  v82[character38] = nil
                end

                if character38:FindFirstChild("SentinelHL") then
                  character38.SentinelHL:Destroy()
                end

                f31(character38)
              end
            end
          end
        end)

        pcall(function()
          local v91 = #CachedMobs - -1

          local colorBosses, highlightBosses, boxBosses, showNameBosses, showHealthBosses,
            showDistanceBosses

          while true do
            v91 = -1 + v91

            if not (v91 >= 1 or false) then
              break
            end

            local v92 = v91
            local v93 = CachedMobs[v92]

            if v93 and v93.Parent then
              if v93 == character35 or v93 == localPlayer.Character
                or v93.Name == localPlayer.Name or players:GetPlayerFromCharacter(v93) then
                if v82[v93] then
                  f34(v82[v93])
                  v82[v93] = nil
                end

                if v93:FindFirstChild("SentinelMobHL") then
                  v93.SentinelMobHL:Destroy()
                end

                f31(v93)
                table.remove(CachedMobs, v92)
              else
                local humanoidRootPart23 = v93:FindFirstChild("HumanoidRootPart")
                local humanoid26 = v93:FindFirstChildOfClass("Humanoid")

                if humanoidRootPart23 and humanoid26 then
                  local magnitude6 = (humanoidRootPart21.Position - humanoidRootPart23.Position).Magnitude

                  if f19(v93) then
                    colorBosses = Config.ColorBosses
                    highlightBosses = Config.HighlightBosses
                    boxBosses = Config.BoxBosses
                    showNameBosses = Config.ShowNameBosses
                    showHealthBosses = Config.ShowHealthBosses
                    showDistanceBosses = Config.ShowDistanceBosses
                  else
                    colorBosses = Config.ColorMobs
                    highlightBosses = Config.HighlightMobs
                    boxBosses = Config.BoxMobs
                    showNameBosses = Config.ShowNameMobs
                    showHealthBosses = Config.ShowHealthMobs
                    showDistanceBosses = Config.ShowDistanceMobs
                  end

                  if magnitude6 <= maxDistance and humanoid26.Health > 0 then
                    local sentinelMobHL = v93:FindFirstChild("SentinelMobHL")

                    if highlightBosses then
                      if not sentinelMobHL then
                        sentinelMobHL = Instance.new("Highlight", v93)
                        sentinelMobHL.Name = "SentinelMobHL"
                      end

                      sentinelMobHL.FillColor = colorBosses
                      sentinelMobHL.FillTransparency = Config.HLFillTrans
                      sentinelMobHL.OutlineTransparency = Config.HLOutlineTrans
                    elseif sentinelMobHL then
                      sentinelMobHL:Destroy()
                    end

                    if boxBosses then
                      if not v82[v93] then
                        v82[v93] = f35(colorBosses, Config.BoxThickness)
                      end

                      f33(v82[v93], v93, colorBosses, Config.BoxThickness)
                    elseif v82[v93] then
                      f32(v82[v93])
                    end

                    f37(
                      v93, colorBosses, showNameBosses, showHealthBosses, showDistanceBosses,
                      magnitude6
                    )
                  else
                    if v82[v93] then
                      f32(v82[v93])
                    end

                    if v93:FindFirstChild("SentinelMobHL") then
                      v93.SentinelMobHL:Destroy()
                    end

                    f31(v93)
                  end
                end
              end
            else
              if v82[v93] then
                f34(v82[v93])
                v82[v93] = nil
              end

              f31(v93)
              table.remove(CachedMobs, v92)
            end
          end
        end)

        return
      end
    end
  end
end)

task.spawn(function()
  while SentinelActive do
    if Config.AntiAFKEnabled then
      pcall(function()
        virtualInputManager:SendKeyEvent(true, Enum.KeyCode.Unknown, false, game)
        task.wait(1)
        virtualInputManager:SendKeyEvent(false, Enum.KeyCode.Unknown, false, game)
      end)
    end

    task.wait(60)
  end
end)

animatorIdleTrack = nil
animatorWalkTrack = nil
animatorRunTrack = nil
animatorLastState = nil

function filterAnimNames(p96)
  local v94 = {}

  for key11, value43 in pairs(toggleAnims) do
    local lower = key11:lower()

    for index36, value44 in ipairs(p96) do
      if lower:sub(-#value44) == value44 then
        table.insert(v94, key11)
        break
      end
    end
  end

  return v94
end

idleAnimNames = filterAnimNames({ "idle", "idle (old)" })
walkAnimNames = filterAnimNames({ "walk", "walk (old)" })

local function f38()
  if AutoReloadToolConn then
    AutoReloadToolConn:Disconnect()
    AutoReloadToolConn = nil
  end

  AutoReloadWatching = false
end

runAnimNames = filterAnimNames({ "run", "run (old)" })

function stopAllAnimatorTracks()
  if animatorIdleTrack then
    animatorIdleTrack:Stop()
    animatorIdleTrack = nil
  end

  if animatorWalkTrack then
    animatorWalkTrack:Stop()
    animatorWalkTrack = nil
  end

  if animatorRunTrack then
    animatorRunTrack:Stop()
    animatorRunTrack = nil
  end
end

function applyAnimatorState()
  local v95

  if Config.FakeDeath then
    stopAllAnimatorTracks()
    return
  elseif not Config.AnimatorEnabled then
    stopAllAnimatorTracks()
    return
  else
    local character39 = localPlayer.Character

    if not character39 then
      return
    else
      local humanoid27 = character39:FindFirstChildOfClass("Humanoid")

      if not humanoid27 or humanoid27.Health <= 0 then
        return
      else
        local humanoidRootPart24 = character39:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart24 then
          return
        else
          local magnitude7 = Vector3.new(
            humanoidRootPart24.Velocity.X, 0, humanoidRootPart24.Velocity.Z
          ).Magnitude

          if isShiftHeld and magnitude7 > 2 then
            v95 = "run"
          elseif magnitude7 > 0.5 then
            v95 = "walk"
          else
            v95 = "idle"
          end

          if v95 ~= animatorLastState then
            animatorLastState = v95
            stopAllAnimatorTracks()

            if v95 == "idle" and Config.AnimatorIdleAnimName then
              animatorIdleTrack = playAnimationOnHumanoid(
                toggleAnims[Config.AnimatorIdleAnimName], true
              )
            elseif v95 == "walk" and Config.AnimatorWalkAnimName then
              animatorWalkTrack = playAnimationOnHumanoid(
                toggleAnims[Config.AnimatorWalkAnimName], true
              )
            elseif v95 == "run" and Config.AnimatorRunAnimName then
              animatorRunTrack = playAnimationOnHumanoid(
                toggleAnims[Config.AnimatorRunAnimName], true
              )
            end
          end

          return
        end
      end
    end
  end
end

local v96 = false

local function f39()
  while v96 and SentinelActive do
    local backpack4 = localPlayer:FindFirstChild("Backpack")

    if backpack4 then
      for key12, value45 in pairs(backpack4:GetChildren()) do
        local v97 = value45

        if v97:IsA("Tool") and v97:GetAttribute("ClipCurrent") then
          if v97:GetAttribute("ClipCurrent") < 1e+24 then
            pcall(function()
              v97:SetAttribute("ClipSize", 1e+24)
              v97:SetAttribute("ClipCurrent", 1e+24)
              v97:SetAttribute("MaxAmmo", 1e+24)
            end)
          end
        end
      end
    end

    task.wait(0.1)
  end
end

local v98

function toggleNightStalkerInfAmmo(p97)
  Config.NightStalkerInfAmmo = p97

  if p97 then
    if not v96 then
      v96 = true

      if v98 then
        task.cancel(v98)
      end

      v98 = task.spawn(f39)
    end
  else
    v96 = false

    if v98 then
      task.cancel(v98)
      v98 = nil
    end
  end
end

AutoReloadWatching = false
AutoReloadToolConn = nil
AutoReloadCharConn = nil
local f40

local function f41()
  if keypress and keyrelease then
    pcall(function()
      keypress(82)
      task.delay(0.08, function() keyrelease(82) end)
    end)
  else
    virtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)

    task.delay(0.08, function()
      virtualInputManager:SendKeyEvent(false, Enum.KeyCode.R, false, game)
    end)
  end

  local v99 = f40()
  local activated

  if v99 then
    activated = v99.Activated

    if activated then
      pcall(function() activated:Fire() end)
    end
  end
end

function f40()
  local playerGui7 = localPlayer:FindFirstChild("PlayerGui")

  if not playerGui7 then
    return nil
  else
    local findFirstChild8 = playerGui7:FindFirstChild("MobileControls", true)

    if not findFirstChild8 then
      return nil
    end

    return findFirstChild8:FindFirstChild("Reload", true)
  end
end

local function f42(p98)
  local clipCurrent = p98:GetAttribute("ClipCurrent")
  local maxAmmo = p98:GetAttribute("MaxAmmo")
  local reloading = p98:GetAttribute("Reloading")

  if clipCurrent == 0 and (maxAmmo or 0) > 0 and not reloading and not AutoReloadWatching then
    AutoReloadWatching = true

    task.delay(1.5, function()
      f41()
      task.delay(0.5, function() AutoReloadWatching = false end)
    end)
  end
end

local function f43(p99)
  f38()

  if not p99:GetAttribute("IsGun") then
    return
  end

  task.delay(1.5, function() f42(p99) end)

  AutoReloadToolConn = p99:GetAttributeChangedSignal("ClipCurrent"):Connect(function()
    f42(p99)
  end)
end

local function f44(p100)
  f38()

  p100.ChildAdded:Connect(function(child9)
    if child9:IsA("Tool") then
      f43(child9)
    end
  end)

  p100.ChildRemoved:Connect(function(child10)
    if child10:IsA("Tool") then
      f38()
    end
  end)

  local tool5 = p100:FindFirstChildOfClass("Tool")

  if tool5 then
    f43(tool5)
  end
end

AutoReloadCharacterConn = nil

function toggleAutoReload(p101)
  Config.AutoReload = p101

  if p101 then
    if localPlayer.Character then
      f44(localPlayer.Character)
    end

    if AutoReloadCharacterConn then
      AutoReloadCharacterConn:Disconnect()
    end

    AutoReloadCharacterConn = localPlayer.CharacterAdded:Connect(f44)
  else
    f38()

    if AutoReloadCharacterConn then
      AutoReloadCharacterConn:Disconnect()
      AutoReloadCharacterConn = nil
    end
  end
end

local v100 = {
  ["+100%"] = { attr = "FelsiReloadSpeedMult", val = 1 },
  ["+200%"] = { attr = "SquadReloadSpeedMultiplier", val = 2 },
  ["+150%"] = { attr = "AdminstalSpeedMult", val = 1.5 },
}

local v101 = { "FelsiReloadSpeedMult", "SquadReloadSpeedMultiplier", "AdminstalSpeedMult" }

local function f45(p102)
  if not p102 then
    return
  end

  for index37, value46 in ipairs(v101) do
    p102:SetAttribute(value46, 1)
  end

  for index38, value47 in ipairs(Config.FastReloadBoosts) do
    local v102 = v100[value47]

    if v102 then
      p102:SetAttribute(v102.attr, v102.val)
    end
  end
end

local function f46(p103)
  if not p103 then
    return
  end

  for index39, value48 in ipairs(v101) do
    p103:SetAttribute(value48, 1)
  end
end

local connect2

function toggleFastReload(p104)
  Config.FastReload = p104

  if connect2 then
    connect2:Disconnect()
    connect2 = nil
  end

  if p104 then
    if localPlayer.Character then
      f45(localPlayer.Character)
    end

    connect2 = localPlayer.CharacterAdded:Connect(function(character40)
      character40:WaitForChild("Humanoid")
      f45(character40)
    end)
  elseif localPlayer.Character then
    f46(localPlayer.Character)
  end
end

local function f47(p105)
  local v103 = {}

  if type(p105) == "table" then
    for index40, value49 in ipairs(p105) do
      local title = value49

      if type(value49) == "table" then
        title = value49.Title or value49.Value
      end

      if v100[title] then
        table.insert(v103, title)
      end
    end
  elseif type(p105) == "string" and v100[p105] then
    v103 = { p105 }
  end

  Config.FastReloadBoosts = v103

  if Config.FastReload and localPlayer.Character then
    pcall(f45, localPlayer.Character)
  end
end

InstantShotgunConnection = nil
local v104 = { ["SRS-58"] = true, ["PMS-12T 'Hammer'"] = true }

local v105 = {
  ["rbxassetid://83290487541789"] = true,
  ["rbxassetid://116823220427411"] = true,
  ["rbxassetid://126710614165281"] = true,
  ["rbxassetid://115903749552317"] = true,
}

local function f48(p106)
  if InstantShotgunConnection then
    InstantShotgunConnection:Disconnect()
    InstantShotgunConnection = nil
  end

  if not p106 then
    return
  elseif not Config.InstantShotgunReload then
    return
  else
    InstantShotgunConnection = p106:WaitForChild("Humanoid"):WaitForChild("Animator").AnimationPlayed:Connect(function(p107)
      if not Config.InstantShotgunReload then
        return
      end

      if not (p107.Animation and v105[p107.Animation.AnimationId]) then
        return
      else
        local tool6 = p106:FindFirstChildOfClass("Tool")

        if not tool6 or not v104[tool6.Name] then
          return
        end

        pcall(function() p107:AdjustSpeed(100) end)

        task.delay(0.05, function()
          if p107.IsPlaying then
            pcall(function() p107:AdjustSpeed(100) end)
          end
        end)

        return
      end
    end)

    return
  end
end

function setupInstantShotgunReload(p108)
  if InstantShotgunConnection then
    InstantShotgunConnection:Disconnect()
    InstantShotgunConnection = nil
  end

  Config.InstantShotgunReload = p108

  if p108 then
    if localPlayer.Character then
      f48(localPlayer.Character)
    end
  end
end

localPlayer.CharacterAdded:Connect(function(character41)
  if Config.InstantShotgunReload then
    task.wait(1)
    f48(character41)
  end
end)

local v106 = { fovCircle = nil, hooked = false, originalNew = nil }
local v107 = cloneref or function(p109) return p109 end
local v108 = clonefunction or function(p110) return p110 end
local v109 = newcclosure or v108
local v110 = v107(players)
local v111 = v107(runService)
local v112 = v107(userInputService)
local v113 = v107(replicatedStorage)

if Capabilities.Drawing then
  v106.fovCircle = Drawing.new("Circle")
  v106.fovCircle.Thickness = 1.5
  v106.fovCircle.NumSides = 128
  v106.fovCircle.Filled = false
  v106.fovCircle.Transparency = 1
  v106.fovCircle.Radius = Config.SilentAimFOVRadius
  v106.fovCircle.Color = Config.SilentAimFOVNoTargetColor
  v106.fovCircle.Visible = false
end

local raycastParams2 = RaycastParams.new()
raycastParams2.FilterType = Enum.RaycastFilterType.Exclude
raycastParams2.IgnoreWater = true

local function f49()
  local v114 = {}

  for index41, value50 in ipairs(v110:GetPlayers()) do
    if value50.Character then
      table.insert(v114, value50.Character)
    end
  end

  return v114
end

local function f50(p111)
  return p111:FindFirstChild("HumanoidRootPart") or p111:FindFirstChild("Torso")
    or p111:FindFirstChild("UpperTorso") or p111:FindFirstChild("LowerTorso")
    or p111.PrimaryPart or p111:FindFirstChildWhichIsA("BasePart")
end

local function f51(p112, p113, p114)
  local character42 = v110.LocalPlayer.Character

  if not (character42 and p112) then
    return false, nil, nil
  else
    local v115 = { character42, workspace.CurrentCamera, workspace.Terrain }
    local characters6 = workspace:FindFirstChild("Characters")

    if characters6 then
      for index42, value51 in ipairs(characters6:GetChildren()) do
        if value51 ~= p114 then
          table.insert(v115, value51)
        end
      end
    end

    for index43, value52 in ipairs(f49()) do
      if value52 ~= p114 then
        table.insert(v115, value52)
      end
    end

    raycastParams2.FilterDescendantsInstances = v115

    local position7 = p113
      or workspace.CurrentCamera and workspace.CurrentCamera.CFrame
        and workspace.CurrentCamera.CFrame.Position
      or Vector3.zero

    local raycast2 = workspace:Raycast(position7, p112.Position - position7, raycastParams2)

    if not raycast2 then
      return true, p112, p112.Position
    else
      local parent6 = p114 or p112.Parent

      if parent6 and raycast2.Instance:IsDescendantOf(parent6) then
        return true, p114 and p114:FindFirstChild("Right Arm")
            and p114["Right Arm"]:FindFirstChild("Shield") and p114:FindFirstChild("Head")
          or raycast2.Instance, raycast2.Position
      end

      return false, raycast2.Instance, raycast2.Position
    end
  end
end

local f52

local function f53(p115)
  if not Config.SilentAimEnabled then
    return nil, nil
  else
    local v116 = nil
    local v117 = nil
    local silentAimFOVRadius = Config.SilentAimFOVRadius or 150

    if type(silentAimFOVRadius) ~= "number" then
      silentAimFOVRadius = 150
    end

    local currentCamera4 = workspace.CurrentCamera
    local viewportSize = currentCamera4 and currentCamera4.ViewportSize

    local vector9 = viewportSize
    vector9 = viewportSize or Vector2.new(800, 600)

    local getMouseLocation = Config.SilentAimFOVMode == "Mouse" and v112:GetMouseLocation()

    local vector10 = getMouseLocation
    vector10 = getMouseLocation or Vector2.new((vector9.X or 800) / 2, (vector9.Y or 600) / 2)

    local characters7 = workspace:FindFirstChild("Characters")

    if not characters7 then
      return nil, nil
    end

    for index44, value53 in ipairs(characters7:GetChildren()) do
      local model = value53:IsA("Model")

      local humanoid28 = model
      humanoid28 = model and value53:FindFirstChildOfClass("Humanoid")

      if humanoid28 and humanoid28.Health > 0
        and not value53:FindFirstChildOfClass("ForceField")
        and (value53:FindFirstChild("AI") or not v110:GetPlayerFromCharacter(value53)) then
        local headCollision = nil

        if Config.SilentAimTargetPart == "Head" then
          headCollision = f52(value53)
        end

        if not headCollision then
          headCollision = f50(value53)
        end

        if not headCollision then
          local collisions = value53:FindFirstChild("Collisions")

          if collisions then
            headCollision = collisions:FindFirstChild("Head Collision")
              or collisions:FindFirstChild("Left Arm Collision")
              or collisions:FindFirstChild("Right Arm Collision")
              or collisions:FindFirstChildWhichIsA("BasePart")
          end
        end

        if headCollision then
          local position8 = headCollision.Position
          local v118, v119 = currentCamera4:WorldToViewportPoint(position8)

          if v119 then
            local v120 = true

            if Config.SilentAimWallCheck then
              local v121, v122, v123 = f51(headCollision, p115, value53)

              if not v121 then
                local v124 = f50(value53)

                if v124 then
                  v121, v122, v123 = f51(v124, p115, value53)
                end
              end

              if not v121 then
                v120 = false
              elseif v122 and v123 then
                position8 = v123
                headCollision = v122
              end
            end

            if v120 then
              local magnitude8 = (Vector2.new(v118.X, v118.Y) - vector10).Magnitude

              if magnitude8 < silentAimFOVRadius then
                v117 = position8
                v116 = headCollision
                silentAimFOVRadius = magnitude8
              end
            end
          end
        end
      end
    end

    return v116, v117
  end
end

function f52(p116)
  local head3 = p116:FindFirstChild("Head")

  if head3 and head3:IsA("BasePart") then
    return head3
  else
    local collisions2 = p116:FindFirstChild("Collisions")

    if collisions2 then
      local headCollision2 = collisions2:FindFirstChild("Head Collision")
        or collisions2:FindFirstChild("Head")

      if headCollision2 and headCollision2:IsA("BasePart") then
        return headCollision2
      end

      for index45, value54 in ipairs(p116:GetChildren()) do
        if value54:IsA("BasePart") and value54.Name:lower():find("head") then
          return value54
        end
      end

      return nil
    end

    for index46, value55 in ipairs(p116:GetChildren()) do
      if value55:IsA("BasePart") and value55.Name:lower():find("head") then
        return value55
      end
    end

    return nil
  end
end

local function f54()
  local v125

  if v106.hooked then
    return
  elseif not Capabilities.SilentAim then
    return
  else
    local v126, v127 = pcall(require, v113.Assets.Modules.Raycast.ActiveCast)

    if v126 and v127 then
      v125 = nil

      v125 = v108(hookfunction(rawget(v127, "new"), v109(function(p117, p118, p119, p120, ...)
        local v128, v129 = f53(p118)

        if v128 and v129 and p118 then
          local v130 = v129 - p118

          if typeof(v130) == "Vector3" and v130.Magnitude > 0 then
            local magnitude9 = 1000

            if typeof(p120) == "Vector3" and p120.Magnitude > 0 then
              magnitude9 = p120.Magnitude
            end

            local v131 = v130.Unit
            return v125(p117, p118, v131, v131 * magnitude9, ...)
          end

          return v125(p117, p118, p119, p120, ...)
        end

        return v125(p117, p118, p119, p120, ...)
      end)))

      v106.hooked = true
      v106.originalNew = v125
    end

    return
  end
end

function SilentAim_Enable(p121)
  Config.SilentAimEnabled = p121

  if v106.fovCircle then
    v106.fovCircle.Radius = Config.SilentAimFOVRadius
    local fovCircle = v106.fovCircle
    fovCircle.Visible = p121 and Config.SilentAimShowFOV or false
  end

  if p121 then
    f54()
  end
end

function SilentAim_UpdateFOVVisual()
  if not v106.fovCircle then
    return
  else
    v106.fovCircle.Radius = Config.SilentAimFOVRadius

    local fovCircle2 = v106.fovCircle
    fovCircle2.Visible = Config.SilentAimEnabled and Config.SilentAimShowFOV

    return
  end
end

function SilentAim_Cleanup()
  Config.SilentAimEnabled = false
  Config.SilentAimShowFOV = false

  if v106.fovCircle then
    v106.fovCircle.Visible = false
  end
end

v111.RenderStepped:Connect(function()
  if not SentinelActive then
    return
  else
    local fovCircle3 = v106.fovCircle

    if not fovCircle3 then
      return
    end

    if Config.SilentAimShowFOV and Config.SilentAimEnabled then
      fovCircle3.Visible = true
      local currentCamera5 = workspace.CurrentCamera

      local viewportSize2 = currentCamera5 and currentCamera5.ViewportSize
        or Vector2.new(800, 600)

      fovCircle3.Position = Config.SilentAimFOVMode == "Mouse" and v112:GetMouseLocation() or Vector2.new(
        (viewportSize2.X or 800) / 2, (viewportSize2.Y or 600) / 2
      )

      local silentAimFOVRadius2 = Config.SilentAimFOVRadius

      if type(silentAimFOVRadius2) ~= "number" then
        silentAimFOVRadius2 = 150
      end

      fovCircle3.Radius = silentAimFOVRadius2

      if f53(currentCamera5 and currentCamera5.CFrame and currentCamera5.CFrame.Position
        or Vector3.zero) then
        fovCircle3.Color = Config.SilentAimFOVColor
      else
        fovCircle3.Color = Config.SilentAimFOVNoTargetColor
      end
    else
      fovCircle3.Visible = false
    end

    return
  end
end)

local function f55(p122)
  if not p122 then
    return false
  else
    local model2 = p122:FindFirstAncestorOfClass("Model")

    if not model2 then
      return false
    elseif model2 == localPlayer.Character then
      return false
    else
      local humanoid29 = model2:FindFirstChildWhichIsA("Humanoid")
      return humanoid29 ~= nil and humanoid29.Health > 0
    end
  end
end

BulletVisualizerState = { activeTrails = {} }

local function f56()
  for index47, value56 in ipairs(localPlayer.PlayerGui:GetChildren()) do
    local data = value56:FindFirstChild("Data")

    if data then
      local clip = data:FindFirstChild("clip")

      if clip and clip:IsA("TextLabel") then
        local v132 = tonumber(clip.Text)

        if v132 ~= nil then
          return v132 > 0
        end
      end
    end
  end

  return true
end

local function f57()
  local character43 = localPlayer.Character

  if not character43 then
    return nil
  end

  for index48, value57 in ipairs(character43:GetChildren()) do
    if value57:IsA("Tool") then
      for index49, value58 in ipairs(value57:GetDescendants()) do
        if value58:IsA("Attachment") and value58.Name == "FirePoint" then
          return value58.WorldPosition
        end
      end
    end
  end

  return nil
end

local function f58(p123, p124, p125, p126)
  local magnitude10 = (p124 - p123).Magnitude
  local bulletVisualizerFadeOut, bulletTrail

  if magnitude10 < 0.1 then
    return
  else
    local v133 = (p123 + p124) / 2
    local v134 = (p124 - p123).Unit
    local bulletVisualizerThickness = Config.BulletVisualizerThickness or 0.09
    local bulletVisualizerLifetime = Config.BulletVisualizerLifetime or 3
    bulletVisualizerFadeOut = Config.BulletVisualizerFadeOut or 0.8

    if type(bulletVisualizerThickness) ~= "number" then
      bulletVisualizerThickness = 0.09
    end

    if type(bulletVisualizerLifetime) ~= "number" then
      bulletVisualizerLifetime = 3
    end

    if type(bulletVisualizerFadeOut) ~= "number" then
      bulletVisualizerFadeOut = 0.8
    end

    bulletTrail = Instance.new("Part")
    bulletTrail.Name = "BulletTrail"
    bulletTrail.Anchored = true
    bulletTrail.CanCollide = false
    bulletTrail.CanQuery = false
    bulletTrail.CanTouch = false
    bulletTrail.CastShadow = false

    bulletTrail.Size = Vector3.new(
      bulletVisualizerThickness, bulletVisualizerThickness, magnitude10
    )

    bulletTrail.CFrame = CFrame.new(v133, v133 + v134)
    bulletTrail.Material = Enum.Material.Neon
    bulletTrail.Parent = workspace

    if p126 then
      bulletTrail.Color = Config.BulletVisualizerColorLoading or Color3.fromRGB(255, 200, 0)
      bulletTrail.Transparency = 0.5
    else
      if f55(p125) then
        bulletTrail.Color = Config.BulletVisualizerColorSuccess or Color3.fromRGB(0, 255, 80)
      else
        bulletTrail.Color = Config.BulletVisualizerColorMissed or Color3.fromRGB(220, 30, 30)
      end

      bulletTrail.Transparency = 0.45
    end

    local v135 = math.max(bulletVisualizerLifetime - bulletVisualizerFadeOut, 0)

    task.delay(v135, function()
      if not bulletTrail or not bulletTrail.Parent then
        return
      end

      local total = 0
      local transparency = bulletTrail.Transparency

      local connect3 = nil

      connect3 = runService.Heartbeat:Connect(function(delta3)
        if not bulletTrail or not bulletTrail.Parent then
          if connect3 then
            connect3:Disconnect()
          end

          return
        else
          total = total + delta3
          local v136 = math.clamp(total / bulletVisualizerFadeOut, 0, 1)
          bulletTrail.Transparency = transparency + (1 - transparency) * v136

          if v136 >= 1 then
            connect3:Disconnect()
            bulletTrail:Destroy()
          end

          return
        end
      end)
    end)

    debris:AddItem(bulletTrail, bulletVisualizerLifetime + 0.5)
    table.insert(BulletVisualizerState.activeTrails, bulletTrail)
    return
  end
end

local function f59()
  if not Config.BulletVisualizerEnabled then
    return
  else
    local v137 = f56()
    local v138 = f57()

    if not v138 then
      return
    else
      local getMouse = localPlayer:GetMouse()

      if not getMouse then
        return
      else
        local screenPointToRay = currentCamera:ScreenPointToRay(getMouse.X, getMouse.Y)
        local character44 = localPlayer.Character

        local raycastParams3 = RaycastParams.new()
        raycastParams3.FilterDescendantsInstances = { character44 or {} }
        raycastParams3.FilterType = Enum.RaycastFilterType.Exclude

        local bulletVisualizerRange = Config.BulletVisualizerRange or 500

        if type(bulletVisualizerRange) ~= "number" then
          bulletVisualizerRange = 500
        end

        local raycast3 = workspace:Raycast(
          screenPointToRay.Origin, screenPointToRay.Direction * bulletVisualizerRange,
          raycastParams3
        )

        f58(v138, raycast3 and raycast3.Position
          or screenPointToRay.Origin + screenPointToRay.Direction * bulletVisualizerRange, raycast3 and raycast3.Instance or nil, not v137)

        return
      end
    end
  end
end

local v139 = nil
local clipCurrent2 = 0
local connect4 = nil

local function f60(p127)
  if not p127 or not p127:IsA("Tool") then
    return
  elseif v139 == p127 then
    return
  else
    v139 = p127

    if connect4 then
      connect4:Disconnect()
    end

    clipCurrent2 = p127:GetAttribute("ClipCurrent") or 0

    connect4 = p127:GetAttributeChangedSignal("ClipCurrent"):Connect(function()
      local clipCurrent3 = p127:GetAttribute("ClipCurrent") or 0

      if Config.BulletVisualizerEnabled and clipCurrent3 < clipCurrent2 then
        f59()
      end

      clipCurrent2 = clipCurrent3
    end)

    return
  end
end

local connect5

function BulletVisualizer_Enable(p128)
  Config.BulletVisualizerEnabled = p128

  if p128 then
    if connect5 then
      connect5:Disconnect()
    end

    local character45 = localPlayer.Character

    if character45 then
      f60(character45:FindFirstChildOfClass("Tool"))

      connect5 = character45.ChildAdded:Connect(function(child11)
        if child11:IsA("Tool") then
          task.wait(0.1)
          f60(child11)
        end
      end)
    end
  else
    if connect4 then
      connect4:Disconnect()
      connect4 = nil
    end

    if connect5 then
      connect5:Disconnect()
      connect5 = nil
    end

    v139 = nil
  end
end

function BulletVisualizer_Cleanup()
  Config.BulletVisualizerEnabled = false

  for index50, value59 in ipairs(BulletVisualizerState.activeTrails) do
    local v140 = value59

    pcall(function()
      if v140 and v140.Parent then
        v140:Destroy()
      end
    end)
  end

  BulletVisualizerState.activeTrails = {}

  if connect4 then
    connect4:Disconnect()
    connect4 = nil
  end

  if connect5 then
    connect5:Disconnect()
    connect5 = nil
  end
end

localPlayer.CharacterAdded:Connect(function(character46)
  if not Config.BulletVisualizerEnabled then
    return
  else
    character46:WaitForChild("HumanoidRootPart", 10)
    task.wait(0.5)

    if connect5 then
      connect5:Disconnect()
      connect5 = nil
    end

    if connect4 then
      connect4:Disconnect()
      connect4 = nil
    end

    v139 = nil
    local character47 = localPlayer.Character

    if character47 then
      f60(character47:FindFirstChildOfClass("Tool"))

      connect5 = character47.ChildAdded:Connect(function(child12)
        if child12:IsA("Tool") then
          task.wait(0.1)
          f60(child12)
        end
      end)
    end

    return
  end
end)

local function f61(p129, p130)
  if not p129 or not p129:IsA("ClickDetector") then
    pcall(function()
      if WindUI then
        WindUI:Notify({
          Title = "Free Tools",
          Content = p130 .. " detector not found",
          Duration = 3,
        })
      end
    end)

    return
  end

  pcall(function() fireclickdetector(p129) end)

  pcall(function()
    if WindUI then
      WindUI:Notify({ Title = "Free Tools", Content = "Fired " .. p130, Duration = 2 })
    end
  end)
end

BypassState = { Movement = false }
MovementBypassHooks = {}

function applyMovementBypass(p131)
  BypassState.Movement = p131
  local humanoid30

  if p131 then
    if not Capabilities.Hooks then
      pcall(function()
        if WindUI then
          WindUI:Notify({
            Title = "Movement Bypass",
            Content = "Not supported by your executor.",
            Icon = "alert-triangle",
            Duration = 5,
          })
        end
      end)

      return
    end

    local character48 = localPlayer.Character

    if character48 then
      humanoid30 = character48:FindFirstChildOfClass("Humanoid")

      if humanoid30 then
        pcall(function()
          local v141 = getrawmetatable(humanoid30)
          local newindex

          if v141 and not MovementBypassHooks.Humanoid then
            newindex = v141.__newindex
            setreadonly(v141, false)

            v141.__newindex = newcclosure(function(p132, p133, p134)
              local v142 = p134

              if p133 == "WalkSpeed" or p133 == "JumpPower" then
                if typeof(v142) == "number" then
                  if p133 == "WalkSpeed" and v142 > 100 then
                    v142 = 100
                  end

                  if p133 == "JumpPower" and v142 > 200 then
                    v142 = 200
                  end
                end
              end

              return newindex(p132, p133, v142)
            end)

            setreadonly(v141, true)
            MovementBypassHooks.Humanoid = true
          end
        end)
      end
    end

    return
  end
end

function applyAllBypasses()
  if not Config.NetworkBypassEnabled then
    applyMovementBypass(false)
    return
  else
    local v143 = {}

    for index51, value60 in ipairs(Config.ActiveBypasses) do
      v143[value60] = true
    end

    applyMovementBypass(v143["Movement Bypass"] == true)
    return
  end
end

function collectAllDocuments()
  task.spawn(function()
    local character49 = localPlayer.Character
    local currentCamera6, v144

    if not character49 then
      return
    else
      local humanoidRootPart25 = character49:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart25 then
        return
      else
        local documents = workspace:FindFirstChild("Documents")

        if not documents then
          pcall(function()
            if WindUI then
              WindUI:Notify({
                Title = "Documents",
                Content = "Dossier 'Documents' introuvable.",
                Duration = 3,
              })
            end
          end)

          return
        else
          currentCamera6 = workspace.CurrentCamera
          local getChildren2 = documents.GetChildren
          v144 = {}

          for index52, value61 in ipairs(getChildren2(documents)) do
            local findFirstChildWhichIsA = value61:FindFirstChildWhichIsA(
              "ProximityPrompt", true
            )

            if findFirstChildWhichIsA then
              local parent7 = nil

              if findFirstChildWhichIsA.Parent:IsA("Attachment") then
                parent7 = findFirstChildWhichIsA.Parent.Parent
              elseif findFirstChildWhichIsA.Parent:IsA("BasePart") then
                parent7 = findFirstChildWhichIsA.Parent
              end

              if parent7 then
                table.insert(v144, {
                  pp = findFirstChildWhichIsA,
                  part = parent7,
                  name = value61.Name,
                })
              end
            end
          end

          if #v144 == 0 then
            pcall(function()
              if WindUI then
                WindUI:Notify({
                  Title = "Documents",
                  Content = "Aucun document trouvé.",
                  Duration = 3,
                })
              end
            end)

            return
          else
            pcall(function()
              if WindUI then
                WindUI:Notify({
                  Title = "Documents",
                  Content = #v144 .. " document(s) trouvé(s), collecte en cours...",
                  Duration = 3,
                })
              end
            end)

            for index53, value62 in ipairs(v144) do
              value62.pp.HoldDuration = 0
              value62.pp.MaxActivationDistance = 9999
              value62.pp.Enabled = true
            end

            local cframe7 = humanoidRootPart25.CFrame
            local cameraType = currentCamera6.CameraType
            currentCamera6.CameraType = Enum.CameraType.Scriptable

            local function f62(p135, p136)
              currentCamera6.CFrame = CFrame.new(p135, p135 + (p136 - p135).Unit)
            end

            for index54, value63 in ipairs(v144) do
              local v145 = index54
              local v146 = value63

              if not v146.pp or not v146.pp.Parent then
              else
                local position9 = v146.part.Position
                local vector11 = Vector3.new(0, 0, 3)
                humanoidRootPart25.CFrame = CFrame.new(position9 + vector11, position9)
                task.wait(0.05)
                f62(humanoidRootPart25.CFrame.Position + Vector3.new(0, 1.5, 0), position9)
                task.wait(0.1)
                pcall(function() fireproximityprompt(v146.pp) end)
                task.wait(0.35)

                pcall(function()
                  if WindUI then
                    WindUI:Notify({
                      Title = "Doc [" .. v145 .. "/" .. #v144 .. "]",
                      Content = "Picked Up : " .. v146.name,
                      Duration = 1,
                    })
                  end
                end)
              end
            end

            currentCamera6.CameraType = cameraType
            humanoidRootPart25.CFrame = cframe7
            return
          end
        end
      end
    end
  end)
end

function completeManhattanQuests()
  local userId = localPlayer.UserId
  local v147 = false
  local v148 = false

  local v149, v150 = pcall(function()
    return badgeService:UserHasBadgeAsync(userId, 2147991835)
  end)

  if v149 and v150 then
    v147 = true
  end

  local v151, v152 = pcall(function()
    return badgeService:UserHasBadgeAsync(userId, 282806616820550)
  end)

  if v151 and v152 then
    v148 = true
  end

  if v148 then
    pcall(function()
      if WindUI then
        WindUI:Notify({
          Title = "Manhattan Quest",
          Content = "You already finished the manhattan quest.",
          Duration = 4,
        })
      end
    end)

    return
  end

  if not v147 then
    pcall(function()
      if WindUI then
        WindUI:Notify({
          Title = "Manhattan Quest",
          Content = 'You need to have the ["THE_POINTMAN"] badge.',
          Duration = 5,
        })
      end
    end)

    return
  end

  pcall(function()
    if WindUI then
      WindUI:Notify({
        Title = "Manhattan Quest",
        Content = "Go talk to manhattan and ask her for work.",
        Duration = 4,
      })
    end
  end)

  task.spawn(function()
    local currentCamera7 = workspace.CurrentCamera
    local manhattanRadiationQuest = workspace:FindFirstChild("ManhattanRadiationQuest")

    if not manhattanRadiationQuest then
      pcall(function()
        if WindUI then
          WindUI:Notify({
            Title = "Error",
            Content = "ManhattanRadiationQuest not found",
            Duration = 3,
          })
        end
      end)

      return
    else
      local activeItems = manhattanRadiationQuest:FindFirstChild("ActiveItems")

      if not activeItems then
        pcall(function()
          if WindUI then
            WindUI:Notify({ Title = "Error", Content = "ActiveItems not found", Duration = 3 })
          end
        end)

        return
      else
        local character50 = localPlayer.Character

        if not character50 then
          return
        else
          local humanoidRootPart26 = character50:FindFirstChild("HumanoidRootPart")

          if not humanoidRootPart26 then
            return
          else
            local cframe8 = humanoidRootPart26.CFrame
            local getChildren3 = activeItems:GetChildren()

            if #getChildren3 == 0 then
              pcall(function()
                if WindUI then
                  WindUI:Notify({
                    Title = "Info",
                    Content = "No active items found",
                    Duration = 3,
                  })
                end
              end)

              return
            end

            for index55, value64 in ipairs(getChildren3) do
              if value64:IsA("BasePart") or value64:IsA("Model") then
                local position10 = value64:GetPivot().Position
                humanoidRootPart26.CFrame = CFrame.new(position10 + Vector3.new(0, 2, 0))
                task.wait(0.3)
                currentCamera7.CFrame = CFrame.new(currentCamera7.CFrame.Position, position10)

                humanoidRootPart26.CFrame = CFrame.new(humanoidRootPart26.Position, Vector3.new(
                  position10.X, humanoidRootPart26.Position.Y, position10.Z
                ))

                task.wait(0.2)
                virtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                task.wait(3)
                virtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                task.wait(1)
              end
            end

            humanoidRootPart26.CFrame = cframe8
            return
          end
        end
      end
    end
  end)
end

function getUnderequippedBadge()
  local character51 = localPlayer.Character
  local cframe9, vector12, vector13, walkSpeed, connect6

  if not character51 then
    return
  else
    local humanoidRootPart27 = character51:FindFirstChild("HumanoidRootPart")
    local v153 = not humanoidRootPart27
    local humanoid31 = character51:FindFirstChildOfClass("Humanoid")

    if v153 or not humanoid31 then
      return
    end

    cframe9 = humanoidRootPart27.CFrame
    vector12 = Vector3.new(241, -31, -1172)
    vector13 = Vector3.new(267, -31, -1172)
    walkSpeed = humanoid31.WalkSpeed
    humanoidRootPart27.CFrame = CFrame.lookAt(vector12, vector13)
    humanoid31.WalkSpeed = 9
    task.wait(0.1)

    connect6 = nil

    connect6 = runService.Heartbeat:Connect(function()
      if not SentinelActive then
        if connect6 then
          connect6:Disconnect()
        end

        return
      else
        local character52 = localPlayer.Character

        if not character52 then
          if connect6 then
            connect6:Disconnect()
          end

          return
        else
          local humanoidRootPart28 = character52:FindFirstChild("HumanoidRootPart")
          local humanoid32 = character52:FindFirstChildOfClass("Humanoid")

          if not humanoidRootPart28 or not humanoid32 then
            if connect6 then
              connect6:Disconnect()
            end

            return
          else
            local position11 = humanoidRootPart28.Position

            if (Vector3.new(vector13.X, position11.Y, vector13.Z) - position11).Magnitude <= 1 then
              humanoid32.WalkSpeed = walkSpeed
              connect6:Disconnect()
              task.wait(0.5)
              local character53 = localPlayer.Character

              if character53 and character53:FindFirstChild("HumanoidRootPart") then
                character53:PivotTo(cframe9)
              end

              return
            else
              local v154 = (vector13 - position11) * Vector3.new(1, 0, 1)

              if v154.Magnitude > 0 then
                local v155 = v154.Unit * 0.15

                humanoidRootPart28.CFrame = CFrame.lookAt(position11 + v155, position11 + v155
                  + (vector13 - vector12).Unit)
              end

              return
            end
          end
        end
      end
    end)

    return
  end
end

function CleanupAllFeatures()
  if Config.FlyEnabled then
    Config.FlyEnabled = false
    pcall(function() enableFly(false) end)
  end

  if Config.NoclipEnabled then
    Config.NoclipEnabled = false

    if noclipConnection then
      pcall(function() task.cancel(noclipConnection) end)
      noclipConnection = nil
    end

    local character54 = localPlayer.Character

    if character54 then
      for key13, value65 in pairs(character54:GetDescendants()) do
        if value65:IsA("BasePart") then
          value65.CanCollide = true
        end
      end
    end
  end

  Config.SpeedHackEnabled = false

  if Config.InfiniteStaminaEnabled then
    pcall(function() toggleInfiniteStamina(false) end)
  end

  Config.InfiniteStaminaEnabled = false
  Config.JumpPowerEnabled = false
  Config.InfiniteJump = false
  Config.JumpBypassActive = false

  local character55 = localPlayer.Character
  local humanoid33 = character55 and character55:FindFirstChildOfClass("Humanoid")

  if humanoid33 then
    humanoid33.WalkSpeed = 9
    humanoid33.JumpPower = 50
  end

  if Config.FakeDeath then
    Config.FakeDeath = false
  end

  if Config.FakeInjured then
    Config.FakeInjured = false
  end

  for index56, value66 in ipairs({
    "HighlightPlayer", "HighlightFriends", "HighlightMobs", "HighlightBosses", "BoxPlayers",
    "BoxFriends", "BoxMobs", "BoxBosses", "ShowNamePlayers", "ShowNameFriends", "ShowNameMobs",
    "ShowNameBosses", "ShowHealthPlayers", "ShowHealthFriends", "ShowHealthMobs",
    "ShowHealthBosses", "ShowDistancePlayers", "ShowDistanceFriends", "ShowDistanceMobs",
    "ShowDistanceBosses",
  }) do
    Config[value66] = false
  end

  pcall(function()
    for key14, value67 in pairs(players:GetPlayers()) do
      if value67 ~= localPlayer and value67.Character then
        local sentinelHL2 = value67.Character:FindFirstChild("SentinelHL")

        if sentinelHL2 then
          sentinelHL2:Destroy()
        end
      end
    end

    for index57, value68 in ipairs(workspace:GetDescendants()) do
      local sentinelMobHL2 = value68:FindFirstChild("SentinelMobHL")

      if sentinelMobHL2 then
        sentinelMobHL2:Destroy()
      end

      local sentinelInfoBBG3 = value68:FindFirstChild("SentinelInfoBBG")

      if sentinelInfoBBG3 then
        sentinelInfoBBG3:Destroy()
      end
    end
  end)

  if XrayEnabled then
    XrayEnabled = false
  end

  Config.FullBright = false
  Config.NoFog = false

  pcall(function()
    lighting.Ambient = OrigAmbient
    lighting.OutdoorAmbient = OrigOutdoorAmbient
    lighting.Brightness = OrigBrightness
    lighting.FogEnd = OrigFogEnd
    lighting.FogStart = OrigFogStart
    lighting.GlobalShadows = OrigGlobalShadows
  end)

  Config.CustomFOVEnabled = false

  pcall(function()
    if currentCamera then
      currentCamera.FieldOfView = OrigFOV
    end
  end)

  Config.UnlockThirdPerson = false

  pcall(function()
    localPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
    localPlayer.CameraMaxZoomDistance = 50
  end)

  Config.AnimatorEnabled = false
  animatorLastState = nil

  if activeAnimTrack then
    pcall(function() activeAnimTrack:Stop() end)
    activeAnimTrack = nil
  end

  if HitboxEnabled then
    HitboxEnabled = false
  end

  Config.AntiAnchorEnabled = false
  Config.StaggerEnabled = true
  Config.StaggerImmune = false

  if character55 then
    local clientScripts4 = character55:FindFirstChild("ClientScripts")

    local stagger4 = clientScripts4
    stagger4 = clientScripts4 and clientScripts4:FindFirstChild("Stagger")

    if stagger4 then
      stagger4.Disabled = false
    end

    pcall(function() character55:SetAttribute("StaggerImmune", false) end)
  end

  Config.SilencerEnabled = false
  pcall(function() updateSilencers(false) end)

  if Config.AutoReload then
    Config.AutoReload = false
    pcall(function() toggleAutoReload(false) end)
  end

  if Config.FastReload then
    Config.FastReload = false
    pcall(function() toggleFastReload(false) end)
  end

  if Config.NightStalkerInfAmmo then
    pcall(function() toggleNightStalkerInfAmmo(false) end)
  end

  if Config.AutoQTEEnabled then
    Config.AutoQTEEnabled = false
    pcall(function() f26(false) end)
  end

  Config.AntiAFKEnabled = false
  Config.InstantProximityPrompt = false

  if InstantProximityConnection then
    pcall(function() InstantProximityConnection:Disconnect() end)
    InstantProximityConnection = nil
  end

  Config.AutoCompleteProximityPrompt = false

  if AutoCompletePromptConnection then
    pcall(function() AutoCompletePromptConnection:Disconnect() end)
    AutoCompletePromptConnection = nil
  end

  AutoShieldRemovalActive = false

  if AutoShieldRemovalConnection then
    pcall(function() AutoShieldRemovalConnection:Disconnect() end)
    AutoShieldRemovalConnection = nil
  end

  AutoRemoveAxeActive = false

  if AutoRemoveAxeConnection then
    pcall(function() AutoRemoveAxeConnection:Disconnect() end)
    AutoRemoveAxeConnection = nil
  end

  Config.AutoWipeBlood = false
  Config.AntiCamShake = false
  Config.ImmuneLookHazard = false

  if Config.InfiniteNightVision then
    Config.InfiniteNightVision = false

    if NVForcerConnection then
      pcall(function() NVForcerConnection:Disconnect() end)
      NVForcerConnection = nil
    end

    local nvgEffect = lighting:FindFirstChild("__NVG_Effect")

    if nvgEffect then
      nvgEffect:Destroy()
    end

    local nvgBloom = lighting:FindFirstChild("__NVG_Bloom")

    if nvgBloom then
      nvgBloom:Destroy()
    end

    pcall(f21)
  end

  Config.RemoveDeathScreen = false

  if removeDeathConnection then
    pcall(function() removeDeathConnection:Disconnect() end)
    removeDeathConnection = nil
  end

  if InstantShotgunConnection then
    pcall(function() InstantShotgunConnection:Disconnect() end)
    InstantShotgunConnection = nil
  end

  Config.FlySpeed = 25
  Config.MaxDistance = 1000
  Config.HLFillTrans = 0.7
  Config.HLOutlineTrans = 1
  Config.XrayDistance = 30
  Config.XrayTransparency = 0.3
  Config.AutoBringAxe = false
  Config.AutoBringHammer = false

  AutoBringAxeActive = false
  AutoBringHammerActive = false
  AutoBringAxeRunning = false
  AutoBringHammerRunning = false

  if AutoBringAxeConn then
    pcall(function() AutoBringAxeConn:Disconnect() end)
    AutoBringAxeConn = nil
  end

  if AutoBringHammerConn then
    pcall(function() AutoBringHammerConn:Disconnect() end)
    AutoBringHammerConn = nil
  end

  Config.AntiRiserDodgeEnabled = false

  for index58, value69 in ipairs(AntiRiserDodgeConnections) do
    local v156 = value69
    pcall(function() v156:Disconnect() end)
  end

  AntiRiserDodgeConnections = {}
  AntiRiserDodgeHooked = {}
  AntiRiserAddedConn = nil

  if Config.ViewModelEnabled then
    Config.ViewModelEnabled = false
  end

  if Config.CustomWeaponsEnabled then
    Config.CustomWeaponsEnabled = false
  end

  RadawayState.active = false
end

WindUI = nil

loadSuccess = pcall(function()
  WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
end)

if not loadSuccess or not WindUI then
  starterGui:SetCore("SendNotification", {
    Title = "WindUI Error",
    Text = "Failed to load WindUI.",
    Duration = 15,
  })

  return
end

local f63, f64, notify, sentinelExaminationWindow, sentinelStatusParagraph, v157, f65, f66,
  connect7, f67

if not WindUI.Creator or not WindUI.CreateWindow or not WindUI.SetTheme or not WindUI.Notify then
  starterGui:SetCore("SendNotification", {
    Title = "WindUI Error",
    Text = "WindUI missing methods.",
    Duration = 15,
  })

  return
else
  notify = WindUI.Notify

  function WindUI.Notify(...)
    return (notify(...))
  end

  pcall(function() WindUI.Creator.AddThemes({ "Light", "Dark", "Rose" }) end)

  WindUI.Services["SentinelKey-Examination"] = {
    Name = "Sentinel Key System",
    Icon = "key-round",
    Args = { "Link", "ButtonName", "ButtonDesc" },
    New = function(p137, p138, p139)
      return {
        Name = p138 or "Copy",
        Desc = p139 or "Click to copy.",
        Verify = function(p140)
          if not p140 or p140 == "" then
            return false, "Please enter a key."
          end

          if tostring(p140) == "Sentinel.Examination.Uv29b" then
            return true, "Key valid! Welcome to Sentinel."
          end

          return false, "Invalid key. Check your key and try again."
        end,
        Copy = function()
          if setclipboard then
            pcall(setclipboard, p137)
          end

          return p137
        end,
      }
    end,
  }

  sentinelExaminationWindow = nil
  sentinelStatusParagraph = nil

  function ApplyInfiniteNightVision(p141)
    Config.InfiniteNightVision = p141
    local nvgEffect2, nvgBloom2

    if p141 then
      nvgEffect2 = lighting:FindFirstChild("__NVG_Effect")

      if not nvgEffect2 then
        nvgEffect2 = Instance.new("ColorCorrectionEffect")
        nvgEffect2.Name = "__NVG_Effect"
        nvgEffect2.Brightness = 0.2
        nvgEffect2.Contrast = 0.1
        nvgEffect2.Saturation = -0.2
        nvgEffect2.TintColor = Color3.fromRGB(255, 255, 255)
        nvgEffect2.Parent = lighting
      end

      nvgBloom2 = lighting:FindFirstChild("__NVG_Bloom")

      if not nvgBloom2 then
        nvgBloom2 = Instance.new("BloomEffect")
        nvgBloom2.Name = "__NVG_Bloom"
        nvgBloom2.Intensity = 2
        nvgBloom2.Size = 32
        nvgBloom2.Threshold = 0.4
        nvgBloom2.Parent = lighting
      end

      lighting.GlobalShadows = false
      f22()
      f23()

      if NVForcerConnection then
        NVForcerConnection:Disconnect()
      end

      NVForcerConnection = runService.RenderStepped:Connect(function()
        if not SentinelActive then
          return
        end

        if not Config.InfiniteNightVision then
          return
        end

        if nvgEffect2 and nvgEffect2.Parent then
          nvgEffect2.Enabled = true
        end

        if nvgBloom2 and nvgBloom2.Parent then
          nvgBloom2.Enabled = true
        end

        lighting.FogEnd = 999999999
        lighting.FogStart = 999999999
        lighting.Ambient = Color3.fromRGB(67, 67, 67)
        lighting.OutdoorAmbient = Color3.fromRGB(67, 67, 67)
        lighting.GlobalShadows = false
      end)
    else
      if NVForcerConnection then
        NVForcerConnection:Disconnect()
        NVForcerConnection = nil
      end

      local nvgEffect3 = lighting:FindFirstChild("__NVG_Effect")

      if nvgEffect3 then
        nvgEffect3:Destroy()
      end

      local nvgBloom3 = lighting:FindFirstChild("__NVG_Bloom")

      if nvgBloom3 then
        nvgBloom3:Destroy()
      end

      lighting.FogEnd = OrigFogEnd
      lighting.FogStart = OrigFogStart
      lighting.Ambient = OrigAmbient
      lighting.OutdoorAmbient = OrigOutdoorAmbient
      lighting.GlobalShadows = OrigGlobalShadows

      f21()
    end
  end

  function BuildUI()
    local locked = not Capabilities.Drawing
    local locked2 = not Capabilities.Hooks
    local locked3 = not Capabilities.SilentAim
    local locked4 = not Capabilities.FireProximityPrompt
    local locked5 = not Capabilities.FireClickDetector

    local tab = sentinelExaminationWindow:Tab({
      Title = "AntiCheat & Bypass",
      Icon = "shield-alert",
    })

    sentinelExaminationWindow:Divider()
    local mainTab = sentinelExaminationWindow:Tab({ Title = "Main", Icon = "house" })
    local playerTab = sentinelExaminationWindow:Tab({ Title = "Player", Icon = "user" })
    sentinelExaminationWindow:Divider()
    local combatTab = sentinelExaminationWindow:Tab({ Title = "Combat", Icon = "swords" })
    local gunModsTab = sentinelExaminationWindow:Tab({ Title = "Gun Mods", Icon = "crosshair" })
    local infectedTab = sentinelExaminationWindow:Tab({ Title = "Infected", Icon = "brain" })
    sentinelExaminationWindow:Divider()
    local espTab = sentinelExaminationWindow:Tab({ Title = "ESP", Icon = "eye" })
    local visualsTab = sentinelExaminationWindow:Tab({ Title = "Visuals", Icon = "sun" })
    local worldTab = sentinelExaminationWindow:Tab({ Title = "World", Icon = "earth" })
    sentinelExaminationWindow:Divider()

    local animationsTab = sentinelExaminationWindow:Tab({
      Title = "Animations",
      Icon = "clapperboard",
    })

    local questsTab = sentinelExaminationWindow:Tab({ Title = "Quests", Icon = "scroll" })
    local utilitiesTab = sentinelExaminationWindow:Tab({ Title = "Utilities", Icon = "wrench" })
    sentinelExaminationWindow:Divider()

    Tabs = {
      AntiCheat = tab,
      Main = mainTab,
      Player = playerTab,
      Combat = combatTab,
      GunMods = gunModsTab,
      Infected = infectedTab,
      ESP = espTab,
      Visuals = visualsTab,
      World = worldTab,
      Animations = animationsTab,
      Quests = questsTab,
      Utilities = utilitiesTab,
      Settings = sentinelExaminationWindow:Tab({ Title = "Settings", Icon = "settings" }),
    }

    local antiCheat = Tabs.AntiCheat

    antiCheat:Section({ Title = "Warning", Opened = true, Icon = "triangle-alert" }):Paragraph({
      Title = "Read before using!",
      Desc = "Using third-party scripts in this game violates the Terms of Service and carries severe risks.\n\nPotential consequences include:\n• Permanent account termination\n• Hardware ID (HWID) bans\n• Account flagging by the anti-cheat system\n• Loss of all progress, items, and purchases\n\nSentinel is provided for educational purposes only. We are not responsible for any bans, account loss, or other damages resulting from its use.\n\nBy proceeding, you acknowledge that you use this software entirely at your own risk. It is strongly recommended to test on an alternate account.",
      Image = "message-circle-warning",
      ImageSize = 24,
    })

    local compatibilitySection = antiCheat:Section({
      Title = "Compatibility",
      Opened = true,
      Icon = "cpu",
    })

    compatibilitySection:Paragraph({
      Title = "Executor",
      Desc = SentinelExecutorName,
      Image = "terminal",
      ImageSize = 20,
    })

    compatibilitySection:Paragraph({
      Title = "Device",
      Desc = SentinelDeviceType,
      Image = "smartphone",
      ImageSize = 20,
    })

    compatibilitySection:Paragraph({
      Title = "Hook Support",
      Desc = SentinelHookSupported and "Supported (Silent Aim OK)"
        or "NOT supported (Silent Aim may fail)",
      Image = SentinelHookSupported and "check" or "x",
      ImageSize = 20,
    })

    compatibilitySection:Paragraph({
      Title = "Account",
      Desc = SentinelUserName .. " | Age: " .. SentinelAccountAge,
      Image = "user",
      ImageSize = 20,
    })

    local networkBypassSection = antiCheat:Section({
      Title = "Network Bypass",
      Opened = true,
      Icon = "shield",
    })

    networkBypassSection:Toggle({
      Title = "Apply Network Bypass",
      Desc = "Enable this to make the selected features undetected. Does NOT activate them.",
      Default = false,
      Flag = "NetworkBypassEnabled",
      Callback = function(value70)
        Config.NetworkBypassEnabled = value70
        applyAllBypasses()
      end,
    })

    networkBypassSection:Divider()

    networkBypassSection:Dropdown({
      Title = "Bypass",
      Desc = "Select which features should be made undetected when used.",
      Values = { "Movement Bypass" },
      Multi = true,
      Value = {},
      Flag = "ActiveBypasses",
      Callback = function(value71)
        if type(value71) == "table" then
          Config.ActiveBypasses = value71
        else
          Config.ActiveBypasses = {}
        end

        if Config.NetworkBypassEnabled then
          applyAllBypasses()
        end
      end,
    })

    local main = Tabs.Main

    local characterHealthSection = main:Section({
      Title = "Character Health",
      Opened = true,
      Icon = "heart",
    })

    local suicideButton

    suicideButton = characterHealthSection:Button({
      Title = "Suicide",
      Callback = function()
        suicideButton:Highlight()
        local character56 = localPlayer.Character
        local humanoid34 = character56 and character56:FindFirstChildOfClass("Humanoid")

        if humanoid34 then
          humanoid34.Health = 0
        end
      end,
    })

    local button

    button = characterHealthSection:Button({
      Title = "Suicide with Animation",
      Callback = function()
        button:Highlight()
        suicideWithAnimation()
      end,
    })

    characterHealthSection:Divider()

    characterHealthSection:Toggle({
      Title = "Fake Death",
      Default = false,
      Flag = "FakeDeath",
      Callback = function(value72)
        Config.FakeDeath = value72
        toggleFakeDeath()
      end,
    })

    characterHealthSection:Toggle({
      Title = "Fake Injured (idle)",
      Default = false,
      Flag = "FakeInjured",
      Callback = function(value73)
        Config.FakeInjured = value73
        toggleFakeInjured()
      end,
    })

    local animatorSection = main:Section({ Title = "Animator", Opened = true, Icon = "user" })

    animatorSection:Toggle({
      Title = "Apply Animator Config",
      Default = false,
      Flag = "AnimatorEnabled",
      Callback = function(value74)
        Config.AnimatorEnabled = value74

        if not value74 then
          stopAllAnimatorTracks()
          animatorLastState = nil
        end
      end,
    })

    animatorSection:Divider()

    animatorSection:Dropdown({
      Title = "Idle Animation",
      Values = idleAnimNames,
      Default = nil,
      Flag = "AnimatorIdleAnimName",
      Callback = function(value75) Config.AnimatorIdleAnimName = value75 end,
    })

    animatorSection:Dropdown({
      Title = "Walk Animation",
      Values = walkAnimNames,
      Default = nil,
      Flag = "AnimatorWalkAnimName",
      Callback = function(value76) Config.AnimatorWalkAnimName = value76 end,
    })

    animatorSection:Dropdown({
      Title = "Run Animation",
      Values = runAnimNames,
      Default = nil,
      Flag = "AnimatorRunAnimName",
      Callback = function(value77) Config.AnimatorRunAnimName = value77 end,
    })

    local customizationSection = main:Section({
      Title = "Customization",
      Opened = true,
      Icon = "palette",
    })

    customizationSection:Input({
      Title = "Character Name",
      Default = "",
      Placeholder = "Enter name",
      Flag = "CharacterName",
      Callback = function(value78)
        Config.CharacterName = value78
        applyNametags(localPlayer.Character)
      end,
    })

    customizationSection:Input({
      Title = "Rank",
      Default = "",
      Placeholder = "Enter rank",
      Flag = "CharacterRank",
      Callback = function(value79)
        Config.CharacterRank = value79
        applyNametags(localPlayer.Character)
      end,
    })

    customizationSection:Colorpicker({
      Title = "Nametag Color",
      Default = Config.TagColor,
      Flag = "TagColor",
      Callback = function(value80)
        Config.TagColor = value80
        applyNametags(localPlayer.Character)
      end,
    })

    customizationSection:Dropdown({
      Title = "Team",
      Values = { "Menlo", "RAID", "RSU" },
      Default = "Menlo",
      Flag = "Team",
      Callback = function(value81)
        Config.Team = value81
        changeTeam(value81, true)
      end,
    })

    local player = Tabs.Player

    local walkspeedSettingsSection = player:Section({
      Title = "Walkspeed Settings",
      Opened = true,
      Icon = "sport-shoe",
    })

    walkspeedSettingsSection:Toggle({
      Title = "Enable Speed Modifiers",
      Default = false,
      Flag = "SpeedHackEnabled",
      Callback = function(value82) Config.SpeedHackEnabled = value82 end,
    })

    walkspeedSettingsSection:Slider({
      Title = "WalkSpeed",
      Value = { Min = 1, Max = 30, Default = 9 },
      Rounding = 0,
      Enabled = true,
      Flag = "WalkSpeedValue",
      Callback = function(value83) Config.WalkSpeedValue = value83 end,
    })

    walkspeedSettingsSection:Divider()

    walkspeedSettingsSection:Toggle({
      Title = "Infinite Stamina",
      Default = false,
      Flag = "InfiniteStaminaEnabled",
      Callback = function(value84) toggleInfiniteStamina(value84) end,
    })

    local jumpSettingsSection = player:Section({
      Title = "Jump Settings",
      Opened = true,
      Icon = "plane-landing",
    })

    jumpSettingsSection:Toggle({
      Title = "Enable JumpPower",
      Default = false,
      Flag = "JumpPowerEnabled",
      Callback = function(value85) Config.JumpPowerEnabled = value85 end,
    })

    jumpSettingsSection:Slider({
      Title = "JumpPower",
      Value = { Min = 5, Max = 30, Default = 15 },
      Rounding = 0,
      Enabled = true,
      Flag = "JumpPowerValue",
      Callback = function(value86) Config.JumpPowerValue = value86 end,
    })

    jumpSettingsSection:Divider()

    jumpSettingsSection:Toggle({
      Title = "Infinite Jump",
      Default = false,
      Flag = "InfiniteJump",
      Callback = function(value87) Config.InfiniteJump = value87 end,
    })

    local button2

    button2 = jumpSettingsSection:Button({
      Title = "Bypass Jump AC",
      Callback = function()
        button2:Highlight()
        Config.JumpBypassActive = not Config.JumpBypassActive
      end,
    })

    local flySection = player:Section({ Title = "Fly", Opened = true, Icon = "plane" })

    flySection:Toggle({
      Title = "Enable Fly",
      Default = false,
      Flag = "FlyEnabled",
      Callback = function(value88)
        Config.FlyEnabled = value88

        if value88 then
          FlySpeed = Config.FlySpeed
          enableFly(true)
        else
          enableFly(false)
        end
      end,
    })

    flySection:Dropdown({
      Title = "Fly Method",
      Values = { "Seat [UNDETECTED]" },
      Value = "Seat [UNDETECTED]",
      Locked = true,
      LockedTitle = "Locked For Security Reason...",
      Flag = "FlyType",
      Callback = function(value89) end,
    }):Lock()

    flySection:Slider({
      Title = "Fly Speed",
      Value = { Min = 1, Max = 50, Default = 25 },
      Rounding = 0,
      Enabled = true,
      Flag = "FlySpeed",
      Callback = function(value90)
        Config.FlySpeed = value90
        FlySpeed = value90
      end,
    })

    player:Section({ Title = "Noclip", Opened = true, Icon = "ghost" }):Toggle({
      Title = "Enable Noclip",
      Default = false,
      Flag = "NoclipEnabled",
      Callback = function(value91)
        Config.NoclipEnabled = value91

        if value91 then
          if not noclipConnection then
            noclipConnection = task.spawn(function()
              while Config.NoclipEnabled and SentinelActive do
                local character57 = localPlayer.Character

                if character57 then
                  local torso = character57:FindFirstChild("Torso")
                    or character57:FindFirstChild("UpperTorso")
                    or character57:FindFirstChild("LowerTorso")

                  if torso and torso:IsA("BasePart") then
                    torso.CanCollide = false
                  end
                end

                task.wait(0.01)
              end
            end)
          end
        else
          if noclipConnection then
            task.cancel(noclipConnection)
            noclipConnection = nil
          end

          local character58 = localPlayer.Character

          if character58 then
            local torso2 = character58:FindFirstChild("Torso")
              or character58:FindFirstChild("UpperTorso")
              or character58:FindFirstChild("LowerTorso")

            if torso2 and torso2:IsA("BasePart") then
              torso2.CanCollide = true
            end
          end
        end
      end,
    })

    local patchSection = player:Section({ Title = "Patch", Opened = true, Icon = "wind" })

    patchSection:Toggle({
      Title = "Disable Stagger",
      Default = false,
      Flag = "StaggerEnabled",
      Callback = function(value92)
        Config.StaggerEnabled = not value92
        local character59 = localPlayer.Character

        if character59 then
          local clientScripts5 = character59:FindFirstChild("ClientScripts")

          if clientScripts5 then
            local stagger5 = clientScripts5:FindFirstChild("Stagger")

            if stagger5 then
              stagger5.Disabled = Config.StaggerEnabled
            end
          end
        end

        replicatedStorage:SetAttribute("StaggerEnabled", Config.StaggerEnabled)
      end,
    })

    patchSection:Toggle({
      Title = "Anti-Anchor",
      Desc = "Allow you to move while executing / getting executed",
      Default = false,
      Flag = "AntiAnchorEnabled",
      Callback = function(value93) Config.AntiAnchorEnabled = value93 end,
    })

    local combat = Tabs.Combat

    local button3

    button3 = combat:Section({ Title = "Free Tools", Opened = true, Icon = "toolbox" }):Button({
      Title = "Get FlashLight",
      Locked = locked5,
      LockedTitle = "Not supported by your executor",
      Callback = function()
        button3:Highlight()
        local map2 = workspace:FindFirstChild("Map")
        local lobbySpawn2 = map2 and map2:FindFirstChild("LobbySpawn")
        local handTorch = lobbySpawn2 and lobbySpawn2:FindFirstChild("HandTorch")
        f61(handTorch and handTorch:FindFirstChild("ClickDetector"), "Flashlight")
      end,
    })

    local bringWeaponsSection = combat:Section({
      Title = "Bring Weapons",
      Opened = true,
      Icon = "unplug",
    })

    bringWeaponsSection:Toggle({
      Title = "Auto Bring Axe",
      Default = false,
      Flag = "AutoBringAxe",
      Callback = function(value94) toggleAutoBringAxe(value94) end,
    })

    bringWeaponsSection:Toggle({
      Title = "Auto Bring Hammer",
      Default = false,
      Flag = "AutoBringHammer",
      Callback = function(value95) toggleAutoBringHammer(value95) end,
    })

    local section = combat:Section({
      Title = "Delete Mobs Protections",
      Opened = true,
      Icon = "shield-x",
    })

    local button4

    button4 = section:Button({
      Title = "Delete All Shields",
      Callback = function()
        button4:Highlight()

        for index59, value96 in ipairs(workspace:GetDescendants()) do
          if value96.Name == "Shield" then
            value96:Destroy()
          end
        end
      end,
    })

    section:Toggle({
      Title = "Auto-Remove Shields",
      Default = false,
      Flag = "AutoRemoveShields",
      Callback = function(value97)
        AutoShieldRemovalActive = value97

        if value97 then
          for index60, value98 in ipairs(workspace:GetDescendants()) do
            if value98.Name == "Shield" then
              value98:Destroy()
            end
          end

          if not AutoShieldRemovalConnection then
            AutoShieldRemovalConnection = workspace.DescendantAdded:Connect(function(descendant6)
              if AutoShieldRemovalActive then
                task.wait(0.1)

                if descendant6.Name == "Shield" then
                  descendant6:Destroy()
                end

                for index61, value99 in ipairs(descendant6:GetDescendants()) do
                  if value99.Name == "Shield" then
                    value99:Destroy()
                  end
                end
              end
            end)
          end
        elseif AutoShieldRemovalConnection then
          AutoShieldRemovalConnection:Disconnect()
          AutoShieldRemovalConnection = nil
        end
      end,
    })

    section:Divider()

    local button5

    button5 = section:Button({
      Title = "Delete Slasher Axe",
      Callback = function()
        button5:Highlight()
        deleteSlasherAxe()
      end,
    })

    section:Toggle({
      Title = "Auto-Remove Axe",
      Default = false,
      Flag = "AutoRemoveAxe",
      Callback = function(value100)
        AutoRemoveAxeActive = value100

        if value100 then
          return
        end

        if AutoRemoveAxeConnection then
          AutoRemoveAxeConnection:Disconnect()
          AutoRemoveAxeConnection = nil
        end
      end,
    })

    section:Divider()

    section:Toggle({
      Title = "Anti Riser Dodge",
      Desc = "Prevents risers from dodging",
      Default = false,
      Flag = "AntiRiserDodgeEnabled",
      Callback = function(value101) AntiRiserDodge_Enable(value101) end,
    })

    local viewModelSection = combat:Section({
      Title = "View Model",
      Opened = true,
      Icon = "person-standing",
    })

    viewModelSection:Toggle({
      Title = "Enable VM customizations",
      Default = false,
      Flag = "ViewModelEnabled",
      Callback = function(value102) Config.ViewModelEnabled = value102 end,
    })

    viewModelSection:Divider()

    viewModelSection:Colorpicker({
      Title = "VM Color",
      Default = Config.ViewModelColor,
      Flag = "ViewModelColor",
      Callback = function(value103) Config.ViewModelColor = value103 end,
    })

    viewModelSection:Dropdown({
      Title = "VM Material",
      Values = values,
      Value = Config.ViewModelMaterial,
      Flag = "ViewModelMaterial",
      Callback = function(value104) Config.ViewModelMaterial = value104 end,
    })

    local section2 = combat:Section({
      Title = "Custom Weapons Appearance",
      Opened = true,
      Icon = "sword",
    })

    section2:Toggle({
      Title = "Enable custom Weapons Appearance",
      Default = false,
      Flag = "CustomWeaponsEnabled",
      Callback = function(value105)
        Config.CustomWeaponsEnabled = value105
        local tool7

        if value105 then
          local character60 = localPlayer.Character

          if character60 then
            tool7 = character60:FindFirstChildWhichIsA("Tool")

            if tool7 then
              pcall(function() f7(tool7) end)
            end
          end
        end
      end,
    })

    section2:Divider()

    section2:Colorpicker({
      Title = "Weapons Color",
      Default = Config.CustomWeaponsColor,
      Flag = "CustomWeaponsColor",
      Callback = function(value106) Config.CustomWeaponsColor = value106 end,
    })

    section2:Dropdown({
      Title = "Weapons Material",
      Values = values,
      Value = Config.CustomWeaponsMaterial,
      Flag = "CustomWeaponsMaterial",
      Callback = function(value107) Config.CustomWeaponsMaterial = value107 end,
    })

    local gunMods = Tabs.GunMods

    local silentAimSection = gunMods:Section({
      Title = "Silent Aim",
      Opened = true,
      Icon = "wifi-cog",
    })

    silentAimSection:Toggle({
      Title = "Enable Silent Aim",
      Default = false,
      Locked = locked3,
      LockedTitle = "Not supported by your executor",
      Flag = "SilentAimEnabled",
      Callback = function(value108) SilentAim_Enable(value108) end,
    })

    silentAimSection:Toggle({
      Title = "Enable Wall Check",
      Default = true,
      Flag = "SilentAimWallCheck",
      Callback = function(value109) Config.SilentAimWallCheck = value109 end,
    })

    silentAimSection:Divider()

    silentAimSection:Dropdown({
      Title = "Target Part",
      Values = { "Head", "Torso" },
      Value = "Head",
      Flag = "SilentAimTargetPart",
      Callback = function(value110) Config.SilentAimTargetPart = value110 end,
    })

    silentAimSection:Divider()

    silentAimSection:Toggle({
      Title = "Show FOV Circle",
      Default = false,
      Locked = locked,
      LockedTitle = "Not supported by your executor",
      Flag = "SilentAimShowFOV",
      Callback = function(value111)
        Config.SilentAimShowFOV = value111
        SilentAim_UpdateFOVVisual()
      end,
    })

    silentAimSection:Slider({
      Title = "FOV Circle Radius",
      Value = { Min = 50, Max = 500, Default = Config.SilentAimFOVRadius },
      Rounding = 0,
      Enabled = true,
      Flag = "SilentAimFOVRadius",
      Callback = function(value112)
        Config.SilentAimFOVRadius = value112
        SilentAim_UpdateFOVVisual()
      end,
    })

    silentAimSection:Dropdown({
      Title = "FOV Circle Mode",
      Values = { "Center", "Mouse" },
      Value = "Mouse",
      Flag = "SilentAimFOVMode",
      Callback = function(value113) Config.SilentAimFOVMode = value113 end,
    })

    local reloadSection = gunMods:Section({
      Title = "Reload",
      Opened = true,
      Icon = "refresh-cw",
    })

    reloadSection:Dropdown({
      Title = "Fast Reload Boosts",
      Values = { "+100%", "+200%", "+150%" },
      Multi = true,
      Value = Config.FastReloadBoosts,
      Flag = "FastReloadBoosts",
      Callback = f47,
    })

    reloadSection:Toggle({
      Title = "Fast Reload",
      Default = false,
      Flag = "FastReload",
      Callback = function(value114) toggleFastReload(value114) end,
    })

    reloadSection:Divider()

    reloadSection:Toggle({
      Title = "Auto Reload",
      Default = false,
      Flag = "AutoReload",
      Callback = function(value115) toggleAutoReload(value115) end,
    })

    reloadSection:Divider()

    reloadSection:Toggle({
      Title = "Instant Shotgun Reload",
      Default = false,
      Flag = "InstantShotgunReload",
      Callback = function(value116) setupInstantShotgunReload(value116) end,
    })

    local bulletVisualizerSection = gunMods:Section({
      Title = "Bullet Visualizer",
      Opened = true,
      Icon = "crosshair",
    })

    bulletVisualizerSection:Colorpicker({
      Title = "Is missed",
      Default = Config.BulletVisualizerColorMissed,
      Flag = "BulletVisualizerColorMissed",
      Callback = function(value117) Config.BulletVisualizerColorMissed = value117 end,
    })

    bulletVisualizerSection:Colorpicker({
      Title = "Is Succes",
      Default = Config.BulletVisualizerColorSuccess,
      Flag = "BulletVisualizerColorSuccess",
      Callback = function(value118) Config.BulletVisualizerColorSuccess = value118 end,
    })

    bulletVisualizerSection:Colorpicker({
      Title = "Loading",
      Default = Config.BulletVisualizerColorLoading,
      Flag = "BulletVisualizerColorLoading",
      Callback = function(value119) Config.BulletVisualizerColorLoading = value119 end,
    })

    bulletVisualizerSection:Divider()

    bulletVisualizerSection:Slider({
      Title = "Visualizer Lifetime (s)",
      Value = { Min = 1, Max = 5, Default = 3 },
      Rounding = 1,
      Enabled = true,
      Flag = "BulletVisualizerLifetime",
      Callback = function(value120) Config.BulletVisualizerLifetime = value120 end,
    })

    bulletVisualizerSection:Slider({
      Title = "Visualizer Fade-out Time (s)",
      Value = { Min = 0.1, Max = 1, Default = 0.8 },
      Rounding = 2,
      Enabled = true,
      Flag = "BulletVisualizerFadeOut",
      Callback = function(value121) Config.BulletVisualizerFadeOut = value121 end,
    })

    bulletVisualizerSection:Divider()

    bulletVisualizerSection:Toggle({
      Title = "Enable Bullet Visualizer",
      Default = false,
      Flag = "BulletVisualizerEnabled",
      Callback = function(value122) BulletVisualizer_Enable(value122) end,
    })

    local hitboxSection = gunMods:Section({ Title = "Hitbox", Opened = true, Icon = "box" })

    hitboxSection:Slider({
      Title = "Box Size",
      Value = { Min = 1, Max = 5, Default = 4 },
      Rounding = 0,
      Enabled = true,
      Flag = "BoxSize",
      Callback = function(value123)
        Config.BoxSize = value123

        if HitboxEnabled then
          UpdateAllHitboxes(true)
        end
      end,
    })

    hitboxSection:Toggle({
      Title = "Enable Hitbox Expander",
      Default = false,
      Flag = "HitboxEnabled",
      Callback = function(value124)
        HitboxEnabled = value124
        UpdateAllHitboxes(value124)
      end,
    })

    local randomModsSection = gunMods:Section({
      Title = "Random Mods",
      Opened = true,
      Icon = "settings",
    })

    randomModsSection:Toggle({
      Title = "No Recoil",
      Default = false,
      Locked = locked2,
      LockedTitle = "Not supported by your executor",
      Flag = "AntiCamShake",
      Callback = function(value125)
        Config.AntiCamShake = value125

        if value125 then
          applyNoRecoil()
        else
          removeNoRecoil()
        end
      end,
    })

    randomModsSection:Toggle({
      Title = "Silencer",
      Default = false,
      Flag = "SilencerEnabled",
      Callback = function(value126)
        Config.SilencerEnabled = value126
        updateSilencers(value126)
      end,
    })

    randomModsSection:Divider()

    randomModsSection:Toggle({
      Title = "Infinite Ammo",
      Desc = "Only work for Night Stalker Quest.",
      Default = false,
      Flag = "NightStalkerInfAmmo",
      Callback = function(value127) toggleNightStalkerInfAmmo(value127) end,
    })

    local infected = Tabs.Infected

    local playerInfectionSection = infected:Section({
      Title = "Player Infection",
      Opened = true,
      Icon = "biohazard",
    })

    local button6

    button6 = playerInfectionSection:Button({
      Title = "Fake Controllable Infected",
      Callback = function()
        button6:Highlight()

        if not canInfect then
          pcall(function()
            if WindUI then
              WindUI:Notify({
                Title = "Infection",
                Content = "You must respawn before starting a new infection.",
                Duration = 3,
              })
            end
          end)

          return
        end

        if InfectionActive then
          pcall(function()
            if WindUI then
              WindUI:Notify({ Title = "Infection", Content = "Already active!", Duration = 2 })
            end
          end)

          return
        end

        startInfectionSequence("Controllable")
      end,
    })

    local button7

    button7 = playerInfectionSection:Button({
      Title = "Fake Non-Controllable Infected",
      Callback = function()
        button7:Highlight()

        if not canInfect then
          pcall(function()
            if WindUI then
              WindUI:Notify({
                Title = "Infection",
                Content = "You must respawn before starting a new infection.",
                Duration = 3,
              })
            end
          end)

          return
        end

        if InfectionActive then
          pcall(function()
            if WindUI then
              WindUI:Notify({ Title = "Infection", Content = "Already active!", Duration = 2 })
            end
          end)

          return
        end

        startInfectionSequence("NonControllable")
      end,
    })

    playerInfectionSection:Divider()

    local button8

    button8 = playerInfectionSection:Button({
      Title = "Get Infected [BETA]",
      Locked = true,
      LockedTitle = "Detected... Fixing.",
      Callback = function()
        button8:Highlight()

        if not canInfect then
          pcall(function()
            if WindUI then
              WindUI:Notify({
                Title = "Infection",
                Content = "You must respawn before starting a new infection.",
                Duration = 3,
              })
            end
          end)

          return
        elseif InfectionActive then
          pcall(function()
            if WindUI then
              WindUI:Notify({ Title = "Infection", Content = "Already active!", Duration = 2 })
            end
          end)

          return
        else
          local character61 = localPlayer.Character

          if not character61 then
            return
          else
            local humanoid35 = character61:FindFirstChildOfClass("Humanoid")

            if not humanoid35 then
              return
            elseif humanoid35.Health < 100 then
              pcall(function()
                if WindUI then
                  WindUI:Notify({
                    Title = "Infection Failed",
                    Content = "You do not meet all the requirements (100 HP+).",
                    Duration = 7,
                  })
                end
              end)

              return
            else
              if not character61:FindFirstChild("HumanoidRootPart") then
                return
              end

              task.spawn(f18)
              return
            end
          end
        end
      end,
    })

    local section3 = infected:Section({
      Title = "CI Fight Mods",
      Opened = true,
      Icon = "biohazard",
    })

    section3:Toggle({
      Title = "Auto Complete QTE",
      Default = false,
      Flag = "AutoQTEEnabled",
      Callback = function(value128)
        Config.AutoQTEEnabled = value128
        f26(value128)
      end,
    })

    section3:Dropdown({
      Title = "Auto QTE Platform",
      Desc = "Auto-detected. Change if keys aren't registering.",
      Values = { "PC", "Mobile", "Console" },
      Default = Config.AutoQTEPlatform or "PC",
      Flag = "AutoQTEPlatform",
      Callback = function(value129) Config.AutoQTEPlatform = value129 end,
    })

    section3:Slider({
      Title = "QTE Trigger Speed",
      Value = { Min = 0, Max = 60, Default = 12 },
      Rounding = 0,
      Enabled = true,
      Flag = "AutoQTEReactionSpeed",
      Callback = function(value130) Config.AutoQTEReactionSpeed = value130 end,
    })

    local esp = Tabs.ESP

    local section4 = esp:Section({ Title = "Global ESP Settings", Opened = true, Icon = "globe" })

    section4:Slider({
      Title = "Outline Transparency",
      Value = { Min = 0, Max = 1, Default = Config.HLOutlineTrans },
      Rounding = 2,
      Enabled = true,
      Flag = "HLOutlineTrans",
      Callback = function(value131) Config.HLOutlineTrans = value131 end,
    })

    section4:Slider({
      Title = "Highlight Transparency",
      Value = { Min = 0, Max = 1, Default = Config.HLFillTrans },
      Rounding = 2,
      Enabled = true,
      Flag = "HLFillTrans",
      Callback = function(value132) Config.HLFillTrans = value132 end,
    })

    section4:Slider({
      Title = "Max Distance",
      Value = { Min = 50, Max = 2000, Default = Config.MaxDistance },
      Rounding = 0,
      Enabled = true,
      Flag = "MaxDistance",
      Callback = function(value133) Config.MaxDistance = value133 end,
    })

    section4:Divider()

    section4:Slider({
      Title = "Box Thickness",
      Value = { Min = 1, Max = 10, Default = Config.BoxThickness },
      Rounding = 0,
      Enabled = true,
      Flag = "BoxThickness",
      Callback = function(value134) Config.BoxThickness = value134 end,
    })

    section4:Toggle({
      Title = "Auto Thickness (distance based)",
      Default = Config.BoxAutoThickness,
      Flag = "BoxAutoThickness",
      Callback = function(value135) Config.BoxAutoThickness = value135 end,
    })

    local section5 = esp:Section({
      Title = "Players ESP Settings",
      Opened = true,
      Icon = "user-round-plus",
    })

    section5:Colorpicker({
      Title = "Players Color",
      Default = Config.ColorPlayer,
      Flag = "ColorPlayer",
      Callback = function(value136) Config.ColorPlayer = value136 end,
    })

    section5:Divider()

    section5:Toggle({
      Title = "Highlight Players",
      Default = false,
      Flag = "HighlightPlayer",
      Callback = function(value137) Config.HighlightPlayer = value137 end,
    })

    section5:Toggle({
      Title = "Box Players",
      Default = false,
      Locked = locked,
      LockedTitle = "Not supported by your executor",
      Flag = "BoxPlayers",
      Callback = function(value138) Config.BoxPlayers = value138 end,
    })

    section5:Divider()

    section5:Toggle({
      Title = "Show Players Name",
      Default = false,
      Flag = "ShowNamePlayers",
      Callback = function(value139) Config.ShowNamePlayers = value139 end,
    })

    section5:Toggle({
      Title = "Show Players Health",
      Default = false,
      Flag = "ShowHealthPlayers",
      Callback = function(value140) Config.ShowHealthPlayers = value140 end,
    })

    section5:Toggle({
      Title = "Show Players Distance",
      Default = false,
      Flag = "ShowDistancePlayers",
      Callback = function(value141) Config.ShowDistancePlayers = value141 end,
    })

    local section6 = esp:Section({
      Title = "Friends ESP Settings",
      Opened = true,
      Icon = "user-round-check",
    })

    section6:Colorpicker({
      Title = "Friends Color",
      Default = Config.ColorFriends,
      Flag = "ColorFriends",
      Callback = function(value142) Config.ColorFriends = value142 end,
    })

    section6:Divider()

    section6:Toggle({
      Title = "Highlight Friends",
      Default = false,
      Flag = "HighlightFriends",
      Callback = function(value143) Config.HighlightFriends = value143 end,
    })

    section6:Toggle({
      Title = "Box Friends",
      Default = false,
      Locked = locked,
      LockedTitle = "Not supported by your executor",
      Flag = "BoxFriends",
      Callback = function(value144) Config.BoxFriends = value144 end,
    })

    section6:Divider()

    section6:Toggle({
      Title = "Show Friends Name",
      Default = false,
      Flag = "ShowNameFriends",
      Callback = function(value145) Config.ShowNameFriends = value145 end,
    })

    section6:Toggle({
      Title = "Show Friends Health",
      Default = false,
      Flag = "ShowHealthFriends",
      Callback = function(value146) Config.ShowHealthFriends = value146 end,
    })

    section6:Toggle({
      Title = "Show Friends Distance",
      Default = false,
      Flag = "ShowDistanceFriends",
      Callback = function(value147) Config.ShowDistanceFriends = value147 end,
    })

    local section7 = esp:Section({ Title = "Mobs ESP Settings", Opened = true, Icon = "syringe" })

    section7:Colorpicker({
      Title = "Mobs Color",
      Default = Config.ColorMobs,
      Flag = "ColorMobs",
      Callback = function(value148) Config.ColorMobs = value148 end,
    })

    section7:Divider()

    section7:Toggle({
      Title = "Highlight Mobs",
      Default = false,
      Flag = "HighlightMobs",
      Callback = function(value149) Config.HighlightMobs = value149 end,
    })

    section7:Toggle({
      Title = "Box Mobs",
      Default = false,
      Locked = locked,
      LockedTitle = "Not supported by your executor",
      Flag = "BoxMobs",
      Callback = function(value150) Config.BoxMobs = value150 end,
    })

    section7:Divider()

    section7:Toggle({
      Title = "Show Mobs Name",
      Default = false,
      Flag = "ShowNameMobs",
      Callback = function(value151) Config.ShowNameMobs = value151 end,
    })

    section7:Toggle({
      Title = "Show Mobs Health",
      Default = false,
      Flag = "ShowHealthMobs",
      Callback = function(value152) Config.ShowHealthMobs = value152 end,
    })

    section7:Toggle({
      Title = "Show Mobs Distance",
      Default = false,
      Flag = "ShowDistanceMobs",
      Callback = function(value153) Config.ShowDistanceMobs = value153 end,
    })

    local section8 = esp:Section({ Title = "Boss ESP Settings", Opened = true, Icon = "skull" })

    section8:Colorpicker({
      Title = "Boss Color",
      Default = Config.ColorBosses,
      Flag = "ColorBosses",
      Callback = function(value154) Config.ColorBosses = value154 end,
    })

    section8:Divider()

    section8:Toggle({
      Title = "Highlight Bosses",
      Default = false,
      Flag = "HighlightBosses",
      Callback = function(value155) Config.HighlightBosses = value155 end,
    })

    section8:Toggle({
      Title = "Box Bosses",
      Default = false,
      Locked = locked,
      LockedTitle = "Not supported by your executor",
      Flag = "BoxBosses",
      Callback = function(value156) Config.BoxBosses = value156 end,
    })

    section8:Divider()

    section8:Toggle({
      Title = "Show Bosses Name",
      Default = false,
      Flag = "ShowNameBosses",
      Callback = function(value157) Config.ShowNameBosses = value157 end,
    })

    section8:Toggle({
      Title = "Show Bosses Health",
      Default = false,
      Flag = "ShowHealthBosses",
      Callback = function(value158) Config.ShowHealthBosses = value158 end,
    })

    section8:Toggle({
      Title = "Show Bosses Distance",
      Default = false,
      Flag = "ShowDistanceBosses",
      Callback = function(value159) Config.ShowDistanceBosses = value159 end,
    })

    local visuals = Tabs.Visuals

    local cameraSettingsSection = visuals:Section({
      Title = "Camera Settings",
      Opened = true,
      Icon = "camera",
    })

    cameraSettingsSection:Toggle({
      Title = "Unlock Third Person",
      Default = false,
      Flag = "UnlockThirdPerson",
      Callback = function(value160) Config.UnlockThirdPerson = value160 end,
    })

    cameraSettingsSection:Divider()

    cameraSettingsSection:Toggle({
      Title = "Custom FOV",
      Default = false,
      Flag = "CustomFOVEnabled",
      Callback = function(value161) Config.CustomFOVEnabled = value161 end,
    })

    cameraSettingsSection:Slider({
      Title = "Field of View",
      Value = { Min = 1, Max = 120, Default = 70 },
      Rounding = 0,
      Enabled = true,
      Flag = "FOVValue",
      Callback = function(value162) Config.FOVValue = value162 end,
    })

    local atmosphereSection = visuals:Section({
      Title = "Atmosphere",
      Opened = true,
      Icon = "cloud-sun",
    })

    atmosphereSection:Toggle({
      Title = "Full Bright",
      Default = false,
      Flag = "FullBright",
      Callback = function(value163)
        Config.FullBright = value163

        if value163 then
          lighting.Ambient = Color3.fromRGB(255, 255, 255)
          lighting.Brightness = 2
        else
          lighting.Ambient = OrigAmbient
          lighting.Brightness = OrigBrightness
        end
      end,
    })

    atmosphereSection:Toggle({
      Title = "No Fog",
      Default = false,
      Flag = "NoFog",
      Callback = function(value164)
        Config.NoFog = value164

        if value164 then
          lighting.FogEnd = 999999999
          lighting.FogStart = 999999999
        else
          lighting.FogEnd = OrigFogEnd
          lighting.FogStart = OrigFogStart
        end
      end,
    })

    local xraySettingsSection = visuals:Section({
      Title = "Xray Settings",
      Opened = true,
      Icon = "brick-wall",
    })

    xraySettingsSection:Toggle({
      Title = "Enable X-Ray",
      Default = false,
      Flag = "Xray",
      Callback = function(value165)
        XrayEnabled = value165
        Config.Xray = value165
        updateXray()
      end,
    })

    xraySettingsSection:Divider()

    xraySettingsSection:Slider({
      Title = "Distance",
      Value = { Min = 1, Max = 1000, Default = 30 },
      Rounding = 0,
      Enabled = true,
      Flag = "XrayDistance",
      Callback = function(value166)
        XrayDistance = value166

        if XrayEnabled then
          updateXray()
        end
      end,
    })

    xraySettingsSection:Slider({
      Title = "Transparency",
      Value = { Min = 0, Max = 100, Default = 30 },
      Rounding = 0,
      Enabled = true,
      Flag = "XrayTransparency",
      Callback = function(value167)
        XrayTransparency = value167 / 100
        updateXrayMaterialAndTransparency()

        if XrayEnabled then
          updateXray()
        end
      end,
    })

    xraySettingsSection:Dropdown({
      Title = "Material",
      Values = { "Plastic", "Neon", "ForceField", "Glass", "SmoothPlastic" },
      Value = "ForceField",
      Flag = "XrayMaterial",
      Callback = function(value168)
        Config.XrayMaterial = value168

        XrayMaterial = ({
          Plastic = Enum.Material.Plastic,
          Neon = Enum.Material.Neon,
          ForceField = Enum.Material.ForceField,
          Glass = Enum.Material.Glass,
          SmoothPlastic = Enum.Material.SmoothPlastic,
        })[value168] or Enum.Material.ForceField

        updateXrayMaterialAndTransparency()

        if XrayEnabled then
          updateXray()
        end
      end,
    })

    local screenCustomizationSection = visuals:Section({
      Title = "Screen Customization",
      Opened = true,
      Icon = "brush",
    })

    screenCustomizationSection:Toggle({
      Title = "Auto-Wipe Screen Blood",
      Default = false,
      Flag = "AutoWipeBlood",
      Callback = function(value169) Config.AutoWipeBlood = value169 end,
    })

    local cleanScreenButton

    cleanScreenButton = screenCustomizationSection:Button({
      Title = "Clean Screen",
      Callback = function()
        cleanScreenButton:Highlight()
        local gui4 = localPlayer.PlayerGui:FindFirstChild("Gui")

        if gui4 then
          for key15, clean2 in pairs(gui4:GetChildren()) do
            if clean2.Name == "blood" then
              clean2.Name = "clean"
              tweenService:Create(clean2, TweenInfo.new(0.2), { ImageTransparency = 1 }):Play()
              debris:AddItem(clean2, 0.5)
            end
          end
        end
      end,
    })

    local section9 = visuals:Section({
      Title = "Night Vision & Gasmask",
      Opened = true,
      Icon = "moon",
    })

    local deleteGasmaskButton

    deleteGasmaskButton = section9:Button({
      Title = "Delete Gasmask",
      Callback = function()
        deleteGasmaskButton:Highlight()
        local playerGui8 = localPlayer:FindFirstChild("PlayerGui")

        if playerGui8 then
          local gasmask2 = playerGui8:FindFirstChild("Gasmask")

          if gasmask2 then
            gasmask2:Destroy()
          end
        end
      end,
    })

    local breakGasmaskButton

    breakGasmaskButton = section9:Button({
      Title = "Break Gasmask",
      Callback = function()
        breakGasmaskButton:Highlight()
        BreakGasmask()
      end,
    })

    section9:Toggle({
      Title = "Infinite Night Vision",
      Default = false,
      Flag = "InfiniteNightVision",
      Callback = function(value170) ApplyInfiniteNightVision(value170) end,
    })

    local world = Tabs.World
    local teleportSection = world:Section({ Title = "Teleport", Opened = true, Icon = "globe" })

    for key16, value171 in pairs(teleportPoints) do
      local v158 = {}
      local v159 = {}

      for index62, value172 in ipairs(value171) do
        local v160, v161 = unpack(value172)
        table.insert(v158, v160)
        v159[v160] = v161
      end

      teleportSection:Dropdown({
        Title = key16,
        Values = v158,
        Default = v158[1],
        Flag = "TP_" .. key16,
        Callback = function(value173)
          local v162 = v159[value173]

          if v162 then
            teleportTo(v162)
          end
        end,
      })
    end

    local button9

    button9 = world:Section({ Title = "LandMines", Opened = true, Icon = "bolt" }):Button({
      Title = "Delete All Landmines",
      Callback = function()
        button9:Highlight()
        deleteAllLandmines()
      end,
    })

    local radiationsSection = world:Section({
      Title = "Radiations",
      Opened = true,
      Icon = "radiation",
    })

    radiationsSection:Toggle({
      Title = "Anti-Radiation Effect",
      Default = false,
      Flag = "ImmuneLookHazard",
      Callback = function(value174) Config.ImmuneLookHazard = value174 end,
    })

    local button10

    button10 = radiationsSection:Button({
      Title = "Remove Elephant Foot",
      Callback = function()
        button10:Highlight()
        removeElephantFoot()
      end,
    })

    local terrorUISection = world:Section({ Title = "Terror UI", Opened = true, Icon = "skull" })

    local button11

    button11 = terrorUISection:Button({
      Title = "Disable ChimeraRad",
      Callback = function()
        button11:Highlight()
        local playerGui9 = localPlayer:FindFirstChild("PlayerGui")

        if playerGui9 then
          local chimeraRad = playerGui9:FindFirstChild("ChimeraRad")

          if chimeraRad then
            local chimeraTerror = chimeraRad:FindFirstChild("ChimeraTerror")

            if chimeraTerror then
              chimeraTerror:Destroy()
            end
          end
        end

        local currentCamera8 = workspace.CurrentCamera

        if currentCamera8 then
          for index63, value175 in ipairs(currentCamera8:GetChildren()) do
            if value175:IsA("ColorCorrectionEffect")
              and value175.Name == "RadiationColorCorrection" then
              value175:Destroy()
            end
          end
        end
      end,
    })

    local button12

    button12 = terrorUISection:Button({
      Title = "Disable GilbertRad",
      Callback = function()
        button12:Highlight()
        local playerGui10 = localPlayer:FindFirstChild("PlayerGui")

        if playerGui10 then
          local gilbertRad = playerGui10:FindFirstChild("GilbertRad")

          if gilbertRad then
            local localHandler = gilbertRad:FindFirstChild("LocalHandler")

            if localHandler then
              localHandler:Destroy()
            end
          end

          local glitchedScreen = playerGui10:FindFirstChild("GlitchedScreen")

          if glitchedScreen then
            glitchedScreen:Destroy()
          end
        end
      end,
    })

    local mapRemoverSection = world:Section({
      Title = "Map Remover",
      Opened = true,
      Icon = "trash",
    })

    local button13

    button13 = mapRemoverSection:Button({
      Title = "Remove Arabic dud",
      Callback = function()
        button13:Highlight()
        removeArabicDud()
      end,
    })

    local button14

    button14 = mapRemoverSection:Button({
      Title = "Remove Lobby Music",
      Callback = function()
        button14:Highlight()
        removeLobbyMusic()
      end,
    })

    local button15

    button15 = mapRemoverSection:Button({
      Title = "Delete ALL doors",
      Callback = function()
        button15:Highlight()
        deleteAllDoors()
      end,
    })

    local animations = Tabs.Animations

    local toggleAnimationsSection = animations:Section({
      Title = "Toggle Animations",
      Opened = false,
      Icon = "toggle-right",
    })

    for key17, value176 in pairs(toggleAnims) do
      local v163 = value176

      toggleAnimationsSection:Toggle({
        Title = key17,
        Default = false,
        Flag = "Anim_" .. key17:gsub("[^%w]", "_"),
        Callback = function(value177) playToggleAnim(v163, value177) end,
      })
    end

    local buttonAnimationsSection = animations:Section({
      Title = "Button Animations",
      Opened = false,
      Icon = "play",
    })

    for key18, value178 in pairs(buttonAnims) do
      local v164 = value178
      local button16

      button16 = buttonAnimationsSection:Button({
        Title = key18,
        Callback = function()
          button16:Highlight()
          playButtonAnim(v164)
        end,
      })
    end

    local quests = Tabs.Quests

    local questCompletionSection = quests:Section({
      Title = "Quest Completion",
      Opened = true,
      Icon = "scroll",
    })

    local divider = questCompletionSection.Divider

    local button17

    button17 = questCompletionSection:Button({
      Title = "Complete Manhattan Radiation Quest",
      Callback = function()
        button17:Highlight()
        completeManhattanQuests()
      end,
    })

    divider(questCompletionSection)

    local button18

    button18 = questCompletionSection:Button({
      Title = "Collect All Documents",
      Locked = locked4,
      LockedTitle = "Not supported by your executor",
      Callback = function()
        button18:Highlight()
        collectAllDocuments()
      end,
    })

    local getBadgesSection = quests:Section({
      Title = "Get Badges",
      Opened = true,
      Icon = "award",
    })

    local divider2 = getBadgesSection.Divider

    local button19

    button19 = getBadgesSection:Button({
      Title = "Get Underequipped Badge",
      Desc = "This will give you three badges : 'ONE-MANE-ARMY', 'VETERAN-OF-PURGATORY' and 'UNDEREQUIPPED'",
      Callback = function()
        button19:Highlight()
        getUnderequippedBadge()
      end,
    })

    divider2(getBadgesSection)

    local button20

    button20 = getBadgesSection:Button({
      Title = "Get 'Unfortunate' Badge",
      Callback = function()
        button20:Highlight()
        getBadge1()
      end,
    })

    local button21

    button21 = getBadgesSection:Button({
      Title = "Get 'NECROTIC-CONTROL' Badge",
      Callback = function()
        button21:Highlight()
        getBadge2()
      end,
    })

    local button22

    button22 = getBadgesSection:Button({
      Title = "Get 'SECTOR-SWEEP' Badge",
      Callback = function()
        button22:Highlight()
        getBadge3()
      end,
    })

    local utilities = Tabs.Utilities

    local mainStuffSection = utilities:Section({
      Title = "Main Stuff",
      Opened = true,
      Icon = "settings-2",
    })

    local button23

    button23 = mainStuffSection:Button({
      Title = "Go to Restricted Server",
      Callback = function()
        button23:Highlight()
        teleportToCFrame(RestrictedServerCFrame)
      end,
    })

    mainStuffSection:Toggle({
      Title = "Anti-AFK",
      Default = false,
      Flag = "AntiAFKEnabled",
      Callback = function(value179) Config.AntiAFKEnabled = value179 end,
    })

    mainStuffSection:Divider()

    mainStuffSection:Toggle({
      Title = "Auto Remove Death Screen",
      Default = false,
      Flag = "RemoveDeathScreen",
      Callback = function(value180)
        Config.RemoveDeathScreen = value180

        if value180 then
          local playerGui11 = localPlayer:FindFirstChild("PlayerGui")

          if playerGui11 then
            local death = playerGui11:FindFirstChild("Death")

            if death then
              death:Destroy()
            end

            if not removeDeathConnection then
              removeDeathConnection = playerGui11.ChildAdded:Connect(function(child13)
                if child13.Name == "Death" and Config.RemoveDeathScreen then
                  child13:Destroy()
                end
              end)
            end
          end
        elseif removeDeathConnection then
          removeDeathConnection:Disconnect()
          removeDeathConnection = nil
        end
      end,
    })

    mainStuffSection:Toggle({
      Title = "Show Native Chat (CoreGui)",
      Default = false,
      Flag = "ChatLoggerEnabled",
      Callback = function(value181)
        chatEverToggled = true
        Config.ChatLoggerEnabled = value181
        applyChatState()
      end,
    })

    local proximityPromptSection = utilities:Section({
      Title = "Proximity Prompt",
      Opened = true,
      Icon = "hand",
    })

    proximityPromptSection:Toggle({
      Title = "Instant proximity prompt",
      Default = false,
      Locked = locked4,
      LockedTitle = "Not supported by your executor",
      Flag = "InstantProximityPrompt",
      Callback = function(value182)
        Config.InstantProximityPrompt = value182

        if value182 then
          setupInstantProximity()
        elseif InstantProximityConnection then
          InstantProximityConnection:Disconnect()
          InstantProximityConnection = nil
        end
      end,
    })

    proximityPromptSection:Toggle({
      Title = "Auto Proximity Prompt",
      Default = false,
      Locked = locked4,
      LockedTitle = "Not supported by your executor",
      Flag = "AutoCompleteProximityPrompt",
      Callback = function(value183)
        Config.AutoCompleteProximityPrompt = value183

        if value183 then
          autoCompleteProximity()
        elseif AutoCompletePromptConnection then
          AutoCompletePromptConnection:Disconnect()
          AutoCompletePromptConnection = nil
        end
      end,
    })

    local interfaceSection = Tabs.Settings:Section({
      Title = "Interface",
      Opened = true,
      Icon = "settings",
    })

    interfaceSection:Dropdown({
      Title = "UI Theme",
      Values = {
        "Amber", "CottonCandy", "Crimson", "Dark", "Emerald", "Indigo", "Light", "Mellowsi",
        "Midnight", "MonokaiPro",
      },
      Value = "Amber",
      Flag = "UITheme",
      Callback = function(value184) end,
    })

    interfaceSection:Dropdown({
      Title = "Minimize Keybind",
      Values = {
        "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R",
        "S", "T", "U", "V", "W", "X", "Y", "Z", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8",
        "F9", "F10", "F11", "F12", "Zero", "One", "Two", "Three", "Four", "Five", "Six",
        "Seven", "Eight", "Nine",
      },
      Value = "K",
      Flag = "MinimizeKeybind",
      Callback = function(value185)
        Config.MinimizeKeybind = value185

        if sentinelExaminationWindow then
          pcall(function() sentinelExaminationWindow:SetToggleKey(Enum.KeyCode[value185]) end)
        end
      end,
    })

    interfaceSection:Divider()

    sentinelStatusParagraph = interfaceSection:Paragraph({
      Title = "Sentinel Status",
      Desc = [[
Status: Active
FPS: 0
Ping: 0 ms]],
      Image = "bookmark",
      ImageSize = 24,
    })

    task.spawn(function()
      local v165 = 0
      local v166 = 0
      local v167 = tick()

      runService.RenderStepped:Connect(function()
        if not SentinelActive then
          return
        else
          v166 = v166 + 1
          local v168 = tick()

          if v168 - v167 >= 1 then
            v165 = v166
            v166 = 0
            v167 = v168
          end

          return
        end
      end)

      while SentinelActive do
        task.wait(0.5)
        local v169 = tick() - SentinelLastInteraction >= 10 and "AFK" or "Active"
        local getNetworkPing = localPlayer:GetNetworkPing()

        local v170 = "Status: " .. v169 .. "\nFPS: " .. v165 .. "\nPing: "
          .. math.floor(getNetworkPing * 1000) .. " ms"

        if sentinelStatusParagraph then
          if not pcall(function() sentinelStatusParagraph:SetDesc(v170) end) then
            pcall(function()
              sentinelStatusParagraph:Set({
                Title = "Sentinel Status",
                Desc = v170,
                Image = "bookmark",
                ImageSize = 24,
              })
            end)
          end
        end
      end
    end)
  end

  function initializeUI()
    if sentinelExaminationWindow then
      return
    end

    sentinelExaminationWindow = WindUI:CreateWindow({
      Title = "Sentinel - Examination",
      Author = "x4tmq",
      Icon = "door-open",
      ScrollBarEnabled = true,
      Size = UDim2.fromOffset(250, 150),
      ToggleKey = Enum.KeyCode.K,
      Theme = "Dark",
      HideSearchBar = false,
      Background = "0",
      Resizable = true,
      Transparent = true,
      BackgroundImageTransparency = 0.5,
      KeySystem = {
        Note = [[
Enter your key to access Sentinel.
Get it from the Discord or the website below.]],
        SaveKey = false,
        API = {
          {
            Title = "Discord",
            Desc = "Click to copy the Discord invite link.",
            Icon = "message-circle",
            Type = "SentinelKey-Examination",
            Link = "https://discord.gg/dyQsQVV8ck",
            ButtonName = "Discord",
            ButtonDesc = "Click to copy the Discord invite link.",
          },
          {
            Title = "Website",
            Desc = "Click to copy the website link.",
            Icon = "globe",
            Type = "SentinelKey-Examination",
            Link = "https://x4tmqq.github.io/Sentinel-Script/",
            ButtonName = "Website",
            ButtonDesc = "Click to copy the website link.",
          },
        },
      },
      User = { Enabled = false },
    })

    pcall(function()
      sentinelExaminationWindow:Tag({
        Title = "Beta",
        Icon = "github",
        Color = Color3.fromHex("#000000"),
        Radius = 13,
      })
    end)

    sentinelExaminationWindow:EditOpenButton({
      Title = "Sentinel - Examination",
      Icon = "door-open",
      CornerRadius = UDim.new(0, 24),
      StrokeThickness = 2,
      Color = ColorSequence.new(Color3.fromHex("FF0F7B"), Color3.fromHex("F89B29")),
      OnlyMobile = false,
      Enabled = true,
      Draggable = true,
    })

    BuildUI()
  end

  WindUI:SetTheme("Dark")

  if not sentinelExaminationWindow then
    initializeUI()
  end

  if SentinelLimitedExecutor then
    task.wait(1.2)

    pcall(function()
      WindUI:Notify({
        Title = "Executor Compatibility",
        Content = SentinelExecutorName .. [[
 isn't fully friendly with the script.Some features have been locked for security reason.
Recommended executors : Real (free, key) / Potassium (Paid)]],
        Icon = "alert-triangle",
        Duration = 15,
      })
    end)

    pcall(function()
      WindUI:Notify({
        Title = "Locked Features",
        Content = "Locked: " .. table.concat(SentinelMissingFeatures, ", "),
        Icon = "lock",
        Duration = 12,
      })
    end)
  end

  if sentinelExaminationWindow then
    sentinelExaminationWindow.Visible = true
  end

  pcall(function()
    if sentinelExaminationWindow then
      sentinelExaminationWindow:GetPropertyChangedSignal("Visible"):Connect(function() end)
    end
  end)

  firstHide = true

  userInputService.InputBegan:Connect(function(input8, p142)
    if p142 then
      return
    end

    if input8.KeyCode == Enum.KeyCode[Config.MinimizeKeybind] and sentinelExaminationWindow then
      if not sentinelExaminationWindow.Visible and firstHide then
        firstHide = false
      end
    end
  end)

  runService.Heartbeat:Connect(function(delta4)
    if not SentinelActive then
      return
    end

    applyAnimatorState()
  end)

  localPlayer.CharacterAdded:Connect(function()
    if InfectionActive then
      stopInfection()
    end

    InfectionActive = false
    infectionIsRunning = false
    canInfect = true

    if Config.RemoveDeathScreen and not removeDeathConnection then
      local playerGui12 = localPlayer:FindFirstChild("PlayerGui")

      if playerGui12 then
        removeDeathConnection = playerGui12.ChildAdded:Connect(function(child14)
          if child14.Name == "Death" and Config.RemoveDeathScreen then
            child14:Destroy()
          end
        end)
      end
    end

    if Config.StaggerImmune then
      local character62 = localPlayer.Character

      if character62 then
        character62:SetAttribute("StaggerImmune", true)
      end
    end

    if Config.NetworkBypassEnabled then
      task.wait(1)
    end

    local v171

    if Config.Team and Config.Team ~= "" then
      task.wait(0.8)
      v171 = nil

      for index64, value186 in ipairs(teams:GetChildren()) do
        if value186:IsA("Team") and value186.Name:lower() == tostring(Config.Team):lower() then
          v171 = value186
          break
        end
      end

      if v171 and localPlayer.Team ~= v171 then
        pcall(function() localPlayer.Team = v171 end)
        pcall(function() localPlayer.TeamColor = v171.TeamColor end)
      end
    end
  end)

  local renderStepped = runService.RenderStepped

  function f63(p143)
    local v172 = {}

    if not p143 then
      return v172
    else
      local head4 = p143:FindFirstChild("Head")

      if head4 then
        for index65, value187 in ipairs(head4:GetChildren()) do
          if value187:IsA("Accessory") or value187:IsA("Hat") then
            table.insert(v172, value187)
          end
        end
      end

      for index66, value188 in ipairs(p143:GetChildren()) do
        if value188:IsA("Accessory") or value188:IsA("Hat") then
          table.insert(v172, value188)
        end
      end

      return v172
    end
  end

  renderStepped:Connect(function()
    if not SentinelActive then
      return
    end

    if Config.UnlockThirdPerson then
      if localPlayer.CameraMode ~= Enum.CameraMode.Classic then
        localPlayer.CameraMode = Enum.CameraMode.Classic
      end

      if localPlayer.CameraMaxZoomDistance < 999 then
        localPlayer.CameraMaxZoomDistance = 999
      end
    else
      if localPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
        localPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
      end

      if localPlayer.CameraMaxZoomDistance > 50 then
        localPlayer.CameraMaxZoomDistance = 50
      end
    end
  end)

  HeadAccessoryConnection = nil

  function f64(p144, p145)
    if not p144 then
      return
    end

    for index67, value189 in ipairs(p144:GetDescendants()) do
      local v173 = value189

      if v173:IsA("BasePart") then
        pcall(function() v173.LocalTransparencyModifier = p145 end)
      elseif v173:IsA("Decal") then
        pcall(function() v173.Transparency = p145 end)
      end
    end

    if p144:IsA("BasePart") then
      pcall(function() p144.LocalTransparencyModifier = p145 end)
    end
  end

  CharacterAccessoryConnection = nil
  v157 = nil

  function f65(p146, p147)
    for index68, value190 in ipairs(f63(p146)) do
      f64(value190, p147)
    end
  end

  function f66(p148)
    if HeadAccessoryConnection then
      HeadAccessoryConnection:Disconnect()
      HeadAccessoryConnection = nil
    end

    if CharacterAccessoryConnection then
      CharacterAccessoryConnection:Disconnect()
      CharacterAccessoryConnection = nil
    end

    if v157 ~= nil then
      f65(p148, v157 and 1 or 0)
    end

    local head5 = p148:FindFirstChild("Head")

    if head5 then
      HeadAccessoryConnection = head5.ChildAdded:Connect(function(child15)
        if child15:IsA("Accessory") or child15:IsA("Hat") then
          task.defer(function()
            if child15 and child15.Parent then
              f64(child15, v157 and 1 or 0)
            end
          end)
        end
      end)
    end

    CharacterAccessoryConnection = p148.ChildAdded:Connect(function(child16)
      if child16:IsA("Accessory") or child16:IsA("Hat") then
        task.defer(function()
          if child16 and child16.Parent then
            f64(child16, v157 and 1 or 0)
          end
        end)
      end
    end)
  end

  runService.RenderStepped:Connect(function()
    if not SentinelActive then
      return
    else
      local character63 = localPlayer.Character

      if not character63 then
        return
      else
        local head6 = character63:FindFirstChild("Head")

        if not head6 then
          return
        else
          local v174 = (currentCamera.CFrame.Position - head6.Position).Magnitude < 1.5

          if v174 ~= v157 then
            v157 = v174

            if v174 then
              f65(character63, 1)
            else
              f65(character63, 0)
            end
          elseif v174 then
            f65(character63, 1)
          end

          return
        end
      end
    end
  end)

  if currentCamera then
    currentCamera:GetPropertyChangedSignal("CFrame"):Connect(function()
      if not SentinelActive then
        return
      else
        local character64 = localPlayer.Character

        if not character64 then
          return
        else
          local head7 = character64:FindFirstChild("Head")

          if not head7 then
            return
          else
            local v175 = (currentCamera.CFrame.Position - head7.Position).Magnitude < 3

            if v175 ~= v157 then
              v157 = v175
              f65(character64, v175 and 1 or 0)
            elseif v175 then
              f65(character64, 1)
            end

            return
          end
        end
      end
    end)
  end

  if localPlayer.Character then
    localPlayer.Character:WaitForChild("Head", 5)
    f66(localPlayer.Character)
  end

  localPlayer.CharacterAdded:Connect(function(character65)
    character65:WaitForChild("Head", 5)
    f66(character65)
  end)

  connect7 = nil

  function f67()
    if connect7 then
      connect7:Disconnect()
      connect7 = nil
    end

    local ignore = workspace.Terrain:FindFirstChild("Ignore")

    if not ignore then
      return
    end

    connect7 = ignore.ChildAdded:Connect(function(child17)
      if not Config.ViewModelEnabled then
        return
      end

      if child17.Name == localPlayer.Name .. "viewmodel" then
        task.wait(0.1)

        for index69, value191 in ipairs(child17:GetChildren()) do
          f6(value191)
        end
      end
    end)
  end

  workspace.Terrain.ChildAdded:Connect(function(child18)
    if child18.Name == "Ignore" then
      task.wait(0.1)
      f67()
    end
  end)

  f67()

  task.spawn(function()
    while SentinelActive do
      task.wait(1)

      if Config.ViewModelEnabled then
        local ignore2 = workspace.Terrain:FindFirstChild("Ignore")

        if ignore2 then
          if ignore2:FindFirstChild(localPlayer.Name .. "viewmodel") and not connect7 then
            f67()
          end
        end
      end
    end
  end)

  local v176 = os.clock()

  print("\n============ Sentinel Account & Info ============")
  print("User         : " .. SentinelUserName)
  print("Account Age  : " .. SentinelAccountAge)
  print("Device       : " .. SentinelDeviceType)
  print("\n============ Sentinel Script & Executor ============")
  print("Load Time    : " .. string.format("%.3f", v176 - SentinelLoadStart) .. "s")
  print("Executor     : " .. SentinelExecutorName)
  print("Full Script Support : " .. (SentinelHookSupported and "YES" or "NO"))

  f1()

  if not SentinelHookSupported then
    pcall(function()
      if WindUI and WindUI.Notify then
        WindUI:Notify({
          Title = "Compatibility Warning",
          Content = "Hooks are not supported. Silent Aim may not work.",
          Icon = "alert-triangle",
          Duration = 10,
        })
      end
    end)
  end

  if sentinelExaminationWindow and WindUI then
    pcall(function()
      WindUI:Notify({
        Title = "Sentinel v16.30.07",
        Content = [[
Script Loaded successfully,
Welcome, ]] .. SentinelUserName .. [[
.
Executor: ]] .. SentinelExecutorName,
        Icon = "shield-check",
        Duration = 10,
      })
    end)

    task.wait(0.5)

    pcall(function()
      WindUI:Notify({
        Title = "News",
        Content = "Sorry for the downtime :(",
        Icon = "newspaper",
        Duration = 8.3,
      })
    end)
  end

  return
end
