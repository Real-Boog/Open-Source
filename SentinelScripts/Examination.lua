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
local starterGui = game:GetService("StarterGui")
local httpService = game:GetService("HttpService")
local badgeService = game:GetService("BadgeService")
local proximityPromptService = game:GetService("ProximityPromptService")
local collectionService = game:GetService("CollectionService")
local soundService = game:GetService("SoundService")
local marketplaceService = game:GetService("MarketplaceService")
local localPlayer = players.LocalPlayer
local currentCamera = workspace.CurrentCamera
SentinelActive = true
SentinelLastInteraction = tick()
interfaceVisible = false
noclipConnection = nil

local function f1()
  local v1, v2 = pcall(function()
    local function f2()
      return "original"
    end

    local v3 = hookfunction(f2, function() return "hooked" end)

    if v3 and false then
      hookfunction(f2, v3)
      return true
    end

    return false
  end)

  return v1 and v2 == true
end

SentinelHookSupported = f1()
SentinelExecutorName = "Unknown"
local v4 = identifyexecutor

if type(v4) == "function" then
  local v5 = v4()

  if type(v5) == "string" and #v5 > 0 then
    SentinelExecutorName = v5
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
  local v6 = syn.getplatform()

  if v6 == "UWP" then
    SentinelDeviceType = "UWP"
  elseif v6 == "Android" then
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

function isPlayerCharacter(p1)
  if not p1 or not p1:IsA("Model") then
    return false
  end

  return players:GetPlayerFromCharacter(p1) ~= nil
end

local function f3()
  local function f4(p2)
    local v7, v8 = pcall(p2)
    return v7 and v8 ~= nil
  end

  local function f5(p3, p4)
    print((f4(p4) and "OK  " or "MISS") .. " | " .. p3)
  end

  print("\n============ Sentinel UNC Test ============")

  f5("hookmetamethod", function() return hookmetamethod ~= nil end)
  f5("hookfunction", function() return hookfunction ~= nil end)
  f5("getnamecallmethod", function() return getnamecallmethod ~= nil end)
  f5("newcclosure", function() return newcclosure ~= nil end)
  f5("getfenv", function() return getfenv ~= nil end)
  f5("setfenv", function() return setfenv ~= nil end)
  f5("Drawing.new", function() return Drawing and Drawing.new ~= nil end)
  f5("getrawmetatable", function() return getrawmetatable ~= nil end)
  f5("setreadonly", function() return setreadonly ~= nil end)
  f5("getrenv", function() return getrenv ~= nil end)
  f5("identifyexecutor", function() return identifyexecutor ~= nil end)
  f5("setfpscap", function() return setfpscap ~= nil end)
  f5("fireclickdetector", function() return fireclickdetector ~= nil end)
  f5("fireproximityprompt", function() return fireproximityprompt ~= nil end)
  f5("request/http", function() return request ~= nil or http_request ~= nil end)
  f5("cloneref", function() return cloneref ~= nil end)
  f5("clonefunction", function() return clonefunction ~= nil end)
  f5("loadstring", function() return loadstring ~= nil end)
  f5("getcustomasset", function() return getcustomasset ~= nil end)
  f5("isfile", function() return isfile ~= nil end)

  print([[
===========================================
]])
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
  FlyType = "Seat [UNDETECTED]",
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
  ThirdPersonShiftlockEnabled = false,
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
  HighlightLandmines = false,
  HighlightGenerators = false,
  ColorLandmines = Color3.fromRGB(255, 255, 0),
  ColorGenerators = Color3.fromRGB(0, 255, 255),
  IgnoreLandmine = false,
  RemoveDeathScreen = false,
  AntiAFKEnabled = false,
  ChatLoggerEnabled = false,
  CustomFOVEnabled = false,
  FOVValue = 70,
  Theme = "Amber",
  UITheme = "Amber",
  MinimizeKeybind = "K",
  XrayMaterial = "ForceField",
  XrayTransparency = 0.3,
  InstantProximityPrompt = false,
  AutoCompleteProximityPrompt = false,
  InfiniteAmmoEnabled = false,
  StaggerImmune = false,
  AntiAnchorEnabled = false,
  AutoQTEEnabled = false,
  NightStalkerInfAmmo = false,
  AutoReload = false,
  FastReload = false,
  FastReloadBoosts = { "+100%", "+200%", "+150%" },
  InstantShotgunReload = false,
  WindowTransparency = 0,
  WindowTheme = "Amber",
  WindowBackground = "",
  NotificationSound = "",
  NetworkBypassEnabled = false,
  ActiveBypasses = {},
  BoxThickness = 2,
  BoxAutoThickness = true,
  BoxPart = "Head",
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
}

local v9 = { "Gilbert", "Chimera", "Mikhail", "Sin", "SIN", "Dave" }

local function f6(p7)
  if not p7 or not p7:IsA("Model") then
    return false
  end

  for index, value in ipairs(v9) do
    if p7.Name:find(value) then
      return true
    end
  end

  return false
end

local function f7(p8)
  if not p8 or not p8:IsA("Model") then
    return false
  elseif isPlayerCharacter(p8) then
    return false
  elseif p8 == localPlayer.Character then
    return false
  elseif f6(p8) then
    return true
  else
    if isMobModel(p8) then
      return true
    end

    return false
  end
end

HitboxEnabled = false
HitboxModifiedHeads = {}
flyBV = nil
flyBG = nil
flySeat = nil
flyWeld = nil
flyActive = false
CurrentFlyType = "Seat [UNDETECTED]"
FlySpeed = 25
savedHipHeight = 2
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

local function f8()
  if ShadowRemovalConnection then
    ShadowRemovalConnection:Disconnect()
    ShadowRemovalConnection = nil
  end

  for key in pairs(ShadowModifiedParts) do
    local v10 = key

    if v10 and v10.Parent then
      pcall(function() v10.CastShadow = true end)
    end
  end
end

OrigGlobalShadows = lighting.GlobalShadows
ShadowModifiedParts = {}

local function f9()
  for index2, value2 in ipairs(workspace:GetDescendants()) do
    if value2:IsA("BasePart") and value2.CastShadow then
      ShadowModifiedParts[value2] = true
      value2.CastShadow = false
    end
  end
end

ShadowRemovalConnection = nil

local function f10()
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

FakeDeathAnimTrack = nil
FakeInjuredTrack = nil
InfiniteNVConnection = nil
NVForcerConnection = nil
isShiftHeld = false
InfiniteStaminaThread = nil
AutoShieldRemovalActive = false
AutoShieldRemovalConnection = nil
NeckSnapEvent = replicatedStorage:WaitForChild("NeckSnapEvent")
BashCooldownUI = replicatedStorage:WaitForChild("BashCooldownUI")
gameAee = lighting:FindFirstChild("aee")

local function f11(p9)
  local character3 = localPlayer.Character

  if not character3 then
    return false
  elseif character3:FindFirstChild(p9) then
    return true
  else
    local backpack = localPlayer:FindFirstChild("Backpack")

    if backpack and backpack:FindFirstChild(p9) then
      return true
    end

    return false
  end
end

gameRadiationTint = lighting:FindFirstChild("RadiationTint")
LandmineHighlights = {}
GeneratorHighlights = {}
IgnoreLandmineConnection = nil
landmineHitEvent = replicatedStorage:FindFirstChild("landmineHit")
originalLandmineFire = nil
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

local function f12(p10)
  virtualInputManager:SendKeyEvent(true, p10, false, game)
  task.wait(0.03)
  virtualInputManager:SendKeyEvent(false, p10, false, game)
end

local v11 = {
  E = Enum.KeyCode.E,
  F = Enum.KeyCode.F,
  Q = Enum.KeyCode.Q,
  Y = Enum.KeyCode.Y,
  H = Enum.KeyCode.H,
  G = Enum.KeyCode.G,
  R = Enum.KeyCode.R,
  T = Enum.KeyCode.T,
}

local connect

local function f13(p11)
  if p11 then
    if not connect then
      connect = qteInput.OnClientEvent:Connect(function(p12)
        local v12 = v11[tostring(p12)]

        if v12 then
          task.wait(0.2)
          f12(v12)
        end
      end)
    end
  elseif connect then
    connect:Disconnect()
    connect = nil
  end
end

NoRecoilApplied = false
NoRecoilOriginalNewIndex = nil
NoRecoilMouseConn = nil
NoRecoilStoredPitch = 0
NoRecoilMouseMoved = false

function applyNoRecoil()
  if NoRecoilApplied then
    return
  end

  if not getrawmetatable or not newcclosure or not setreadonly then
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

    local v13 = getrawmetatable(currentCamera2)
    NoRecoilOriginalNewIndex = v13.__newindex
    setreadonly(v13, false)

    v13.__newindex = newcclosure(function(p13, p14, p15)
      if p14 == "CFrame" and typeof(p15) == "CFrame" then
        local v14, v15, v16 = p15:ToEulerAnglesYXZ()

        if NoRecoilMouseMoved then
          NoRecoilMouseMoved = false
          NoRecoilStoredPitch = v14
          return NoRecoilOriginalNewIndex(p13, p14, p15)
        end

        return NoRecoilOriginalNewIndex(p13, p14, CFrame.new(p15.Position)
          * CFrame.fromEulerAnglesYXZ(NoRecoilStoredPitch, v15, v16))
      end

      return NoRecoilOriginalNewIndex(p13, p14, p15)
    end)

    setreadonly(v13, true)
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
      local v17 = getrawmetatable(currentCamera3)
      setreadonly(v17, false)
      v17.__newindex = NoRecoilOriginalNewIndex
      setreadonly(v17, true)
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

local function f14(p16)
  if p16 then
    pcall(function() p16:SetAttribute("infiniteStamina", true) end)
  end
end

function toggleInfiniteStamina(p17)
  Config.InfiniteStaminaEnabled = p17
  local character4

  if p17 then
    f14(localPlayer.Character)

    if InfiniteStaminaThread then
      task.cancel(InfiniteStaminaThread)
    end

    InfiniteStaminaThread = task.spawn(function()
      while Config.InfiniteStaminaEnabled and SentinelActive do
        local character5 = localPlayer.Character

        if character5 and character5:GetAttribute("infiniteStamina") ~= true then
          pcall(function() character5:SetAttribute("infiniteStamina", true) end)
        end

        task.wait(1)
      end
    end)
  else
    if InfiniteStaminaThread then
      task.cancel(InfiniteStaminaThread)
      InfiniteStaminaThread = nil
    end

    character4 = localPlayer.Character

    if character4 then
      pcall(function() character4:SetAttribute("infiniteStamina", false) end)
    end
  end
end

localPlayer.CharacterAdded:Connect(function(character6) task.wait(0.5) end)

function deleteSlasherAxe()
  local characters2 = workspaceService:FindFirstChild("Characters")

  if not characters2 then
    return
  end

  for i = 1, 5 do
    local findFirstChild = characters2:FindFirstChild("Slasher" .. i)

    if findFirstChild then
      local rightArm = findFirstChild:FindFirstChild("Right Arm")

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

local v18 = {
  ["rbxassetid://129323669816538"] = true,
  ["rbxassetid://100585713982883"] = true,
  ["rbxassetid://102516762592870"] = true,
  ["rbxassetid://100869060669563"] = true,
  ["rbxassetid://110910899819148"] = true,
  ["rbxassetid://91043768324636"] = true,
}

local function f15(p18)
  local humanoidRootPart = p18:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart then
    return humanoidRootPart.AssemblyLinearVelocity.Magnitude > 0.5
  else
    local humanoid = p18:FindFirstChildOfClass("Humanoid")

    if humanoid then
      return humanoid.MoveDirection.Magnitude > 0.1
    end

    return false
  end
end

local f16

local function f17()
  for index3, value3 in ipairs(workspace:GetDescendants()) do
    if string.lower(value3.Name):find("riser") then
      local humanoid2 = value3:FindFirstChildOfClass("Humanoid")

      if humanoid2 then
        local animator = humanoid2:FindFirstChildOfClass("Animator")

        if animator then
          f16(animator, value3, value3.Name)
        end
      end

      local animationController = value3:FindFirstChildOfClass("AnimationController")

      if animationController then
        local animator2 = animationController:FindFirstChildOfClass("Animator")

        if animator2 then
          f16(animator2, value3, value3.Name)
        end
      end
    end
  end
end

function f16(p19, p20, p21)
  if AntiRiserDodgeHooked[p19] then
    return
  end

  AntiRiserDodgeHooked[p19] = true

  p19.AnimationPlayed:Connect(function(p22)
    if not Config.AntiRiserDodgeEnabled then
      return
    else
      local animation = p22.Animation

      if animation and v18[animation.AnimationId] then
        pcall(function() p22:Stop(0) end)
        local v19 = f15(p20)
        local v20 = v19 and "rbxassetid://114185638104823" or "rbxassetid://79525526834566"

        local animation2 = Instance.new("Animation")
        animation2.AnimationId = v20

        p19:LoadAnimation(animation2)

        print(("[Riser Block] %s : %s → %s (%s)"):format(
          p21, animation.AnimationId, v20, v19 and "bouge" or "immobile"
        ))
      end

      return
    end
  end)
end

AntiRiserAddedConn = nil

function AntiRiserDodge_Enable(p23)
  Config.AntiRiserDodgeEnabled = p23

  if p23 then
    f17()

    if not AntiRiserAddedConn then
      AntiRiserAddedConn = workspace.DescendantAdded:Connect(function(descendant3)
        if not Config.AntiRiserDodgeEnabled then
          return
        end

        task.wait(0.1)

        if string.lower(descendant3.Name):find("riser") then
          local humanoid3 = descendant3:FindFirstChildOfClass("Humanoid")

          if humanoid3 then
            local animator3 = humanoid3:FindFirstChildOfClass("Animator")

            if animator3 then
              f16(animator3, descendant3, descendant3.Name)
            end
          end

          local animationController2 = descendant3:FindFirstChildOfClass("AnimationController")

          if animationController2 then
            local animator4 = animationController2:FindFirstChildOfClass("Animator")

            if animator4 then
              f16(animator4, descendant3, descendant3.Name)
            end
          end
        end
      end)
    end
  else
    for index4, value4 in ipairs(AntiRiserDodgeConnections) do
      local v21 = value4
      pcall(function() v21:Disconnect() end)
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

function toggleAutoBringAxe(p24)
  Config.AutoBringAxe = p24
  AutoBringAxeActive = p24

  if AutoBringAxeConn then
    pcall(function() AutoBringAxeConn:Disconnect() end)
    AutoBringAxeConn = nil
  end

  AutoBringAxeRunning = false
  AutoBringAxeLastCheck = 0

  if p24 then
    AutoBringAxeConn = runService.Heartbeat:Connect(function()
      if not AutoBringAxeActive then
        return
      elseif AutoBringAxeRunning then
        return
      elseif f11("Axe") then
        return
      else
        local v22 = tick()

        if v22 - AutoBringAxeLastCheck < 1.5 then
          return
        end

        AutoBringAxeLastCheck = v22
        AutoBringAxeRunning = true
        task.spawn(function() AutoBringAxeRunning = false end)
        return
      end
    end)
  end
end

function toggleAutoBringHammer(p25)
  Config.AutoBringHammer = p25
  AutoBringHammerActive = p25

  if AutoBringHammerConn then
    pcall(function() AutoBringHammerConn:Disconnect() end)
    AutoBringHammerConn = nil
  end

  AutoBringHammerRunning = false
  AutoBringHammerLastCheck = 0

  if p25 then
    AutoBringHammerConn = runService.Heartbeat:Connect(function()
      if not AutoBringHammerActive then
        return
      elseif AutoBringHammerRunning then
        return
      elseif f11("Sledgehammer") then
        return
      else
        local v23 = tick()

        if v23 - AutoBringHammerLastCheck < 1.5 then
          return
        end

        AutoBringHammerLastCheck = v23
        AutoBringHammerRunning = true
        task.spawn(function() AutoBringHammerRunning = false end)
        return
      end
    end)
  end
end

function teleportAndBack(p26, p27)
  local character7 = localPlayer.Character

  if not character7 then
    return
  else
    local humanoidRootPart2 = character7:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart2 then
      return
    else
      local cframe = humanoidRootPart2.CFrame
      character7:PivotTo(p26)
      task.wait(p27 or 0.5)

      if character7 and character7:FindFirstChild("HumanoidRootPart") then
        character7:PivotTo(cframe)
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
  for index5, value5 in ipairs(workspaceService:GetDescendants()) do
    if value5:IsA("ProximityPrompt") then
      value5.HoldDuration = 0
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

  AutoCompletePromptConnection = proximityPromptService.PromptShown:Connect(function(p28)
    if not Config.AutoCompleteProximityPrompt then
      return
    elseif not p28.Enabled then
      return
    else
      virtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
      p28.PromptHidden:Wait()
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

          for key2, value6 in pairs(maskHole:GetDescendants()) do
            if value6:IsA("ImageLabel") then
              value6.ImageTransparency = 0
              value6.Visible = true
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

function showBloodVignette(p29)
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
        bloodVignette.Visible = p29

        if p29 then
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

function playAnimationOnHumanoid(animationId, p30, p31)
  local character8 = localPlayer.Character

  if not character8 then
    return nil
  else
    local humanoid4 = character8:FindFirstChildOfClass("Humanoid")

    if not humanoid4 then
      return nil
    else
      local animator5 = humanoid4:FindFirstChildOfClass("Animator")
        or Instance.new("Animator", humanoid4)

      local animation3 = Instance.new("Animation")
      animation3.AnimationId = animationId

      local loadAnimation = animator5:LoadAnimation(animation3)
      loadAnimation.Looped = p30 or false
      loadAnimation:Play()

      if p31 then
        loadAnimation.Stopped:Connect(p31)
      end

      return loadAnimation
    end
  end
end

demonicChars = {
  "Ω", "Ж", "Ψ", "≠", "Σ", "µ", "∂", "ø", "π", "§", "҂", "Ϟ", "Җ", "Ҩ", "?",
  "!",
}

function spawnDemonicSymbol(p32)
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

    local v24 = p32 and 5 or 3
    local count = 0

    while true do
      count = 1 + count

      if not (v24 >= count) then
        break
      end

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

      local v25 = math.random()

      local create = tweenService:Create(textLabel, TweenInfo.new(
        2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out
      ), {
        TextTransparency = 1,
        Position = UDim2.new(textLabel.Position.X.Scale, 0, 0.1 + v25 * 0.1, 0),
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

  for index6, value7 in ipairs({
    infectionInjuredTrack, infectionHeadShakeTrack, infectionCoughTrack, infectionUnstableTrack,
    infectionFallTrack, infectionLurkerTrack, infectionIdleTrack, infectionWalkTrack,
    infectionRunTrack,
  }) do
    if value7 then
      value7:Stop()
    end
  end

  infectionTransformDone = false
  infectionCurrentState = nil
  local character9 = localPlayer.Character

  if character9 then
    local humanoid5 = character9:FindFirstChildOfClass("Humanoid")

    if humanoid5 then
      humanoid5.PlatformStand = false
      humanoid5.WalkSpeed = Config.SpeedHackEnabled and Config.WalkSpeedValue or 9
      humanoid5.JumpPower = Config.JumpPowerEnabled and Config.JumpPowerValue or 50

      local animator6 = humanoid5:FindFirstChildOfClass("Animator")

      if animator6 then
        for key3, value8 in pairs(animator6:GetPlayingAnimationTracks()) do
          value8:Stop()
        end
      end
    end

    local humanoidRootPart3 = character9:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart3 then
      humanoidRootPart3.Anchored = false
    end

    local clientScripts = character9:FindFirstChild("ClientScripts")

    if clientScripts then
      local stagger = clientScripts:FindFirstChild("Stagger")

      if stagger then
        stagger.Disabled = not Config.StaggerEnabled
      end
    end
  end
end

function startInfectionSequence(p33)
  local v26 = p33

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

  if v26 ~= "Controllable" and v26 ~= "NonControllable" then
    v26 = "Controllable"
  end

  canInfect = false
  InfectionActive = true
  infectionIsRunning = true
  InfectionMode = v26
  BreakGasmask()
  showBloodVignette(true)
  local character10 = localPlayer.Character

  if not character10 then
    InfectionActive = false
    infectionIsRunning = false
    canInfect = true
    return
  end

  local humanoid6 = character10:FindFirstChildOfClass("Humanoid")

  if not humanoid6 then
    InfectionActive = false
    infectionIsRunning = false
    canInfect = true
    return
  end

  humanoid6.Health = 1
  infectionInjuredTrack = playAnimationOnHumanoid(InfectionAnims.INJURED, true)
  infectionHeadShakeTrack = playAnimationOnHumanoid(InfectionAnims.HEAD_SHAKE, true)

  local v27 = createRedTint()
  v27.TintColor = Color3.fromRGB(255, 255, 255)

  local v28 = tick()
  local v29 = tick()

  task.spawn(function()
    while infectionIsRunning and humanoid6 and humanoid6.Health > 0 do
      local v30 = tick() - v28

      if tick() - v29 >= 10 and v30 < 60 then
        v29 = tick()

        if infectionCoughTrack then
          infectionCoughTrack:Stop()
        end

        infectionCoughTrack = playAnimationOnHumanoid(InfectionAnims.COUGH, false)

        local sound2 = Instance.new("Sound")
        sound2.SoundId = "rbxassetid://93090593281658"
        sound2.Volume = 1
        sound2.Parent = character10
        sound2:Play()

        debris:AddItem(sound2, 2)
      end

      if not infectionUnstableTrack or not infectionUnstableTrack.IsPlaying then
        if infectionUnstableTrack then
          infectionUnstableTrack:Stop()
        end

        infectionUnstableTrack = playAnimationOnHumanoid(InfectionAnims.UNSTABLE, true)
      end

      if v30 >= 40 then
        local v31 = math.min((v30 - 40) / 30, 1)

        v27.TintColor = Color3.fromRGB(
          255, 255 - math.floor(v31 * 255), 255 - math.floor(v31 * 255)
        )
      end

      if v30 >= 45 then
        spawnDemonicSymbol(true)
      end

      if v30 >= 60 then
        break
      end

      task.wait(0.5)
    end
  end)

  task.wait(60)

  if not infectionIsRunning or not humanoid6 or humanoid6.Health <= 0 then
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
          local humanoidRootPart4 = character10:FindFirstChild("HumanoidRootPart")

          if humanoidRootPart4 then
            humanoidRootPart4.Anchored = false
          end

          humanoid6.PlatformStand = false
          humanoid6.WalkSpeed = 9
          humanoid6.JumpPower = 50

          infectionTransformDone = true
          infectionCurrentState = nil

          task.spawn(function()
            local v32

            while infectionIsRunning and humanoid6 and humanoid6.Health > 0 do
              local humanoidRootPart5 = character10:FindFirstChild("HumanoidRootPart")

              if humanoidRootPart5 then
                local velocity = humanoidRootPart5.Velocity
                local v33 = isShiftHeld
                local magnitude = Vector3.new(velocity.X, 0, velocity.Z).Magnitude

                if v33 and magnitude > 2 then
                  v32 = "run"
                elseif magnitude > 0.5 then
                  v32 = "walk"
                else
                  v32 = "idle"
                end

                if v32 ~= infectionCurrentState then
                  infectionCurrentState = v32

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

                  if v32 == "idle" then
                    infectionIdleTrack = playAnimationOnHumanoid(InfectionAnims.IDLE, true)
                  elseif v32 == "walk" then
                    infectionWalkTrack = playAnimationOnHumanoid(InfectionAnims.WALK, true)
                  elseif v32 == "run" then
                    infectionRunTrack = playAnimationOnHumanoid(InfectionAnims.RUN, true)
                  end
                end
              end

              task.wait(0.2)
            end
          end)

          task.wait(60)

          if infectionIsRunning and humanoid6 and humanoid6.Health > 0 then
            humanoid6.Health = 0
          end

          stopInfection()
          canInfect = true
        end)
      end
    end)
  else
    local animator7 = humanoid6:FindFirstChildOfClass("Animator")

    local instance = animator7
    instance = animator7 or Instance.new("Animator", humanoid6)

    local animation4 = Instance.new("Animation")
    animation4.AnimationId = "rbxassetid://82480275101558"

    local loadAnimation2 = instance:LoadAnimation(animation4)
    loadAnimation2:Play()
    loadAnimation2.Stopped:Wait()

    humanoid6.Health = 0
    canInfect = true
  end

  humanoid6.Died:Connect(function()
    if InfectionActive then
      local animator8 = humanoid6:FindFirstChildOfClass("Animator")
        or Instance.new("Animator", humanoid6)

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
    local humanoidRootPart6 = character10:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart6 then
      humanoidRootPart6.Anchored = false
    end

    if humanoid6 then
      humanoid6.PlatformStand = false
      humanoid6.WalkSpeed = Config.SpeedHackEnabled and Config.WalkSpeedValue or 9
      humanoid6.JumpPower = Config.JumpPowerEnabled and Config.JumpPowerValue or 50
    end

    for index7, value9 in ipairs({
      infectionInjuredTrack, infectionHeadShakeTrack, infectionCoughTrack,
      infectionUnstableTrack, infectionFallTrack, infectionLurkerTrack, infectionIdleTrack,
      infectionWalkTrack, infectionRunTrack,
    }) do
      if value9 then
        value9:Stop()
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

function ApplyHitboxToPart(p34, p35)
  if not p34 or not p34:IsA("BasePart") then
    return
  elseif p34.Name ~= "Head" then
    return
  else
    local parent2 = p34.Parent

    if not isHumanoidModel(parent2) or isPlayerCharacter(parent2) then
      return
    elseif parent2 == localPlayer.Character then
      return
    else
      if not f7(parent2) then
        return
      end

      pcall(function()
        if p35 then
          if not HitboxModifiedHeads[p34] then
            HitboxModifiedHeads[p34] = {
              Size = p34.Size,
              Transparency = p34.Transparency,
              CanCollide = p34.CanCollide,
            }
          end

          p34.Size = Vector3.new(Config.BoxSize, Config.BoxSize, Config.BoxSize)
          p34.CanCollide = false
          p34.Transparency = 0.5
        else
          local v34 = HitboxModifiedHeads[p34]

          if v34 then
            p34.Size = v34.Size
            p34.CanCollide = v34.CanCollide
            p34.Transparency = v34.Transparency

            HitboxModifiedHeads[p34] = nil
          end
        end
      end)

      return
    end
  end
end

function UpdateAllHitboxes(p36)
  for index8, value10 in ipairs(workspaceService:GetDescendants()) do
    if value10:IsA("BasePart") and value10.Name == "Head" then
      local parent3 = value10.Parent

      if isHumanoidModel(parent3) and not isPlayerCharacter(parent3) then
        ApplyHitboxToPart(value10, p36)
      end
    end
  end
end

workspaceService.DescendantAdded:Connect(function(descendant5)
  if HitboxEnabled and descendant5:IsA("BasePart") and descendant5.Name == "Head" then
    local parent4 = descendant5.Parent

    if isHumanoidModel(parent4) and not isPlayerCharacter(parent4)
      and parent4 ~= localPlayer.Character then
      ApplyHitboxToPart(descendant5, true)
    end
  end

  if descendant5:IsA("BasePart") then
    descendant5:GetPropertyChangedSignal("Name"):Connect(function()
      if HitboxEnabled and descendant5.Name == "Head" then
        local parent5 = descendant5.Parent

        if isHumanoidModel(parent5) and not isPlayerCharacter(parent5)
          and parent5 ~= localPlayer.Character then
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

  local character11 = localPlayer.Character

  local humanoid7 = character11
  humanoid7 = character11 and character11:FindFirstChildOfClass("Humanoid")

  if humanoid7 then
    humanoid7.PlatformStand = false
    humanoid7:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
  end

  flyActive = false
end

function enableFly(p37)
  if not p37 then
    cleanFly()
    return
  else
    local character12 = localPlayer.Character

    if not character12 then
      return
    else
      local humanoidRootPart7 = character12:FindFirstChild("HumanoidRootPart")
      local v35 = not humanoidRootPart7
      local humanoid8 = character12:FindFirstChildOfClass("Humanoid")

      if v35 or not humanoid8 then
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
      flyWeld.Part0 = humanoidRootPart7
      flyWeld.Part1 = flySeat
      flyWeld.C0 = CFrame.new(0, -1.5, 0)
      flyWeld.Parent = flySeat

      humanoid8.Sit = true
      humanoid8.PlatformStand = true
      humanoid8:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

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
    local character13 = localPlayer.Character

    if not character13 then
      return
    else
      local v36 = not character13:FindFirstChild("HumanoidRootPart")
      local humanoid9 = character13:FindFirstChildOfClass("Humanoid")

      if v36 or not humanoid9 then
        return
      else
        local vector = Vector3.new()

        if SentinelDeviceType == "Mobile" then
          local moveDirection = humanoid9.MoveDirection

          if moveDirection.Magnitude > 0 then
            vector = Vector3.new(moveDirection.X, 0, moveDirection.Z)
          end

          if flyMobileUp then
            vector = vector + Vector3.new(0, 1, 0)
          end

          if flyMobileDown then
            vector = vector - Vector3.new(0, 1, 0)
          end
        else
          if userInputService:IsKeyDown(Enum.KeyCode.W) then
            vector = vector + currentCamera.CFrame.LookVector
          end

          if userInputService:IsKeyDown(Enum.KeyCode.S) then
            vector = vector - currentCamera.CFrame.LookVector
          end

          if userInputService:IsKeyDown(Enum.KeyCode.A) then
            vector = vector - currentCamera.CFrame.RightVector
          end

          if userInputService:IsKeyDown(Enum.KeyCode.D) then
            vector = vector + currentCamera.CFrame.RightVector
          end

          if userInputService:IsKeyDown(Enum.KeyCode.Space) then
            vector = vector + Vector3.new(0, 1, 0)
          end

          if userInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            vector = vector - Vector3.new(0, 1, 0)
          end
        end

        if vector.Magnitude > 0 then
          vector = vector.Unit
        end

        if flyBV and flyBG and flySeat then
          flyBG.CFrame = currentCamera.CFrame
          flyBV.Velocity = vector * FlySpeed
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

function applyXrayToPart(p38, p39)
  if not p38:IsA("BasePart") then
    return
  end

  if p39 then
    if not XrayModifiedParts[p38] then
      XrayModifiedParts[p38] = { Material = p38.Material, Transparency = p38.Transparency }
    end

    p38.Material = XrayMaterial
    p38.Transparency = XrayTransparency
  else
    local v37 = XrayModifiedParts[p38]

    if v37 then
      p38.Material = v37.Material
      p38.Transparency = v37.Transparency
      XrayModifiedParts[p38] = nil
    end
  end
end

function updateXrayMaterialAndTransparency()
  if not XrayEnabled then
    return
  end

  for key4, value11 in pairs(XrayModifiedParts) do
    local v38 = key4

    if v38 and v38:IsA("BasePart") then
      pcall(function()
        v38.Material = XrayMaterial
        v38.Transparency = XrayTransparency
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

    local v39 = {}

    for key5, value12 in pairs(XrayModifiedParts) do
      table.insert(v39, key5)
    end

    for index9, value13 in ipairs(v39) do
      local v40 = value13
      pcall(function() applyXrayToPart(v40, false) end)
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
      local character14 = localPlayer.Character

      if not character14 then
        return
      else
        local humanoidRootPart8 = character14:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart8 then
          return
        else
          local v41 = {}

          for index10, value14 in ipairs((workspaceService:GetPartBoundsInRadius(
            humanoidRootPart8.Position, XrayDistance
          ))) do
            if value14:IsA("BasePart") and not value14:IsDescendantOf(character14) then
              v41[value14] = true

              if not XrayModifiedParts[value14] then
                applyXrayToPart(value14, true)
              elseif value14.Material ~= XrayMaterial
                or value14.Transparency ~= XrayTransparency then
                value14.Material = XrayMaterial
                value14.Transparency = XrayTransparency
              end
            end
          end

          local v42 = {}

          for key6 in pairs(XrayModifiedParts) do
            if not v41[key6] then
              table.insert(v42, key6)
            end
          end

          for index11, value15 in ipairs(v42) do
            applyXrayToPart(value15, false)
          end

          return
        end
      end
    end
  end)
end

function updateSilencers(p40)
  local backpack2 = localPlayer:FindFirstChild("Backpack")

  if backpack2 then
    for index12, value16 in ipairs(backpack2:GetChildren()) do
      if value16:GetAttribute("IsGun") == true then
        value16:SetAttribute("Silencer", p40)
      end
    end
  end

  local character15 = localPlayer.Character

  if character15 then
    for index13, value17 in ipairs(character15:GetChildren()) do
      if value17:IsA("Tool") and value17:GetAttribute("IsGun") == true then
        value17:SetAttribute("Silencer", p40)
      end
    end
  end
end

function checkAndApplySilencer(p41)
  if p41:GetAttribute("IsGun") == true then
    p41:SetAttribute("Silencer", Config.SilencerEnabled)
  end
end

function listenToBackpack(p42)
  if not p42 then
    return
  end

  p42.ChildAdded:Connect(function(child)
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

localPlayer.CharacterAdded:Connect(function(character16)
  task.wait(1)
  listenToBackpack((localPlayer:WaitForChild("Backpack")))

  character16.ChildAdded:Connect(function(child3)
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

function applyNametags(p43)
  local head2 = p43 and p43:FindFirstChild("Head")

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

function changeTeam(p44)
  local findFirstChild2 = teams:FindFirstChild(p44)

  if findFirstChild2 then
    localPlayer.Team = findFirstChild2
    local character17 = localPlayer.Character

    if character17 and character17:FindFirstChildOfClass("Humanoid") then
      character17:FindFirstChildOfClass("Humanoid").Health = 0
    end
  end
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

localPlayer.CharacterAdded:Connect(function(character18)
  task.spawn(function() applyNametags(character18) end)
  task.wait(1)

  local clientScripts2 = character18:FindFirstChild("ClientScripts")

  if clientScripts2 then
    local stagger2 = clientScripts2:FindFirstChild("Stagger")

    if stagger2 then
      stagger2.Disabled = not Config.StaggerEnabled
    end
  end

  canInfect = true

  if Config.StaggerImmune then
    character18:SetAttribute("StaggerImmune", true)
  end

  if Config.FlyEnabled then
    task.wait(0.5)
    CurrentFlyType = "Seat [UNDETECTED]"
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

function clearStun(p45)
  if not p45 then
    return
  else
    local humanoidRootPart9 = p45:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart9 then
      return
    else
      local shockStun = humanoidRootPart9:FindFirstChild("ShockStun")

      if shockStun then
        shockStun:Destroy()
      end

      return
    end
  end
end

function applyStun(p46)
  if not p46 then
    return
  else
    local humanoidRootPart10 = p46:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart10 then
      return
    else
      local shockStun2 = humanoidRootPart10:FindFirstChild("ShockStun")

      if shockStun2 then
        shockStun2:Destroy()
      end

      local shockStun3 = Instance.new("BodyVelocity")
      shockStun3.Name = "ShockStun"
      shockStun3.MaxForce = Vector3.new(100000, 0, 100000)
      shockStun3.Velocity = Vector3.new(0, 0, 0)
      shockStun3.P = 10000
      shockStun3.Parent = humanoidRootPart10

      return
    end
  end
end

function toggleFakeInjured()
  if Config.FakeInjured then
    local character19 = localPlayer.Character

    if not character19 then
      return
    else
      local humanoid10 = character19:FindFirstChildOfClass("Humanoid")

      if not humanoid10 then
        return
      end

      if not FakeInjuredTrack then
        local animator9 = humanoid10:FindFirstChildOfClass("Animator")
          or Instance.new("Animator", humanoid10)

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
    local character20 = localPlayer.Character

    if not character20 then
      return
    else
      local humanoid11 = character20:FindFirstChildOfClass("Humanoid")

      if not humanoid11 or humanoid11.Health <= 0 then
        if FakeInjuredTrack and FakeInjuredTrack.IsPlaying then
          FakeInjuredTrack:Stop()
        end

        return
      else
        local humanoidRootPart11 = character20:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart11 then
          if FakeInjuredTrack and FakeInjuredTrack.IsPlaying then
            FakeInjuredTrack:Stop()
          end

          return
        else
          local velocity2 = humanoidRootPart11.Velocity

          if Vector3.new(velocity2.X, 0, velocity2.Z).Magnitude < 0.5
            and humanoid11:GetState() ~= Enum.HumanoidStateType.Jumping
            and humanoid11:GetState() ~= Enum.HumanoidStateType.Freefall then
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
  local character21 = localPlayer.Character

  if not character21 then
    return
  else
    local humanoid12 = character21:FindFirstChildOfClass("Humanoid")

    if not humanoid12 then
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

      local animator10 = humanoid12:FindFirstChildOfClass("Animator")

      local instance2 = animator10
      instance2 = animator10 or Instance.new("Animator", humanoid12)

      local animation7 = Instance.new("Animation")
      animation7.AnimationId = "rbxassetid://114023816208972"

      FakeDeathAnimTrack = instance2:LoadAnimation(animation7)
      FakeDeathAnimTrack.Looped = true
      FakeDeathAnimTrack:Play()

      humanoid12.PlatformStand = true
      humanoid12.WalkSpeed = 0
      humanoid12.JumpPower = 0

      local humanoidRootPart12 = character21:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart12 then
        fakeDeathBV = Instance.new("BodyVelocity")
        fakeDeathBV.MaxForce = Vector3.new(1000000, 1000000, 1000000)
        fakeDeathBV.Velocity = Vector3.new(0, 0, 0)
        fakeDeathBV.Parent = humanoidRootPart12

        fakeDeathBP = Instance.new("BodyPosition")
        fakeDeathBP.MaxForce = Vector3.new(1000000, 1000000, 1000000)
        fakeDeathBP.Position = humanoidRootPart12.Position + Vector3.new(0, 1, 0)
        fakeDeathBP.Parent = humanoidRootPart12
      end
    else
      if FakeDeathAnimTrack then
        FakeDeathAnimTrack:Stop()
        FakeDeathAnimTrack = nil
      end

      humanoid12.PlatformStand = false
      humanoid12.WalkSpeed = 9
      humanoid12.JumpPower = 50

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
  local character22 = localPlayer.Character

  if not character22 then
    return
  else
    local humanoid13 = character22:FindFirstChildOfClass("Humanoid")

    if not humanoid13 then
      return
    else
      local animator11 = humanoid13:FindFirstChildOfClass("Animator")
        or Instance.new("Animator", humanoid13)

      local animation8 = Instance.new("Animation")
      animation8.AnimationId = "rbxassetid://82480275101558"

      local loadAnimation4 = animator11:LoadAnimation(animation8)
      loadAnimation4:Play()
      loadAnimation4.Stopped:Wait()

      humanoid13.Health = 0
      return
    end
  end
end

function removeElephantFoot()
  local v43 = false

  for index14, value18 in ipairs(workspace:GetDescendants()) do
    if value18.Name == "LookAtMe" then
      value18:Destroy()
      v43 = true
    end
  end

  if v43 then
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
  local count2 = 0

  for index15, value19 in ipairs(workspace:GetDescendants()) do
    if value19.Name == "Radio" then
      value19:Destroy()
      count2 = count2 + 1
    end
  end

  pcall(function()
    if WindUI then
      WindUI:Notify({
        Title = "Success",
        Content = "Removed " .. count2 .. " Radio(s)",
        Duration = 3,
      })
    end
  end)
end

function deleteAllDoors()
  local gameDoors = workspace:FindFirstChild("GameDoors")

  if not gameDoors then
    pcall(function()
      if WindUI then
        WindUI:Notify({ Title = "Error", Content = "GameDoors not found", Duration = 3 })
      end
    end)

    return
  end

  local count3 = 0

  for index16, value20 in ipairs(gameDoors:GetChildren()) do
    if value20.Name:match("Generator%d") then
      local doorsToOpen = value20:FindFirstChild("DoorsToOpen")

      if doorsToOpen then
        doorsToOpen:Destroy()
        count3 = count3 + 1
      end
    end
  end

  pcall(function()
    if WindUI then
      WindUI:Notify({
        Title = "Success",
        Content = "Deleted " .. count3 .. " DoorsToOpen folder(s)",
        Duration = 3,
      })
    end
  end)
end

function deleteAllLandmines()
  local count4 = 0

  for index17, value21 in ipairs(workspace:GetDescendants()) do
    if value21.Name == "Landmine" and value21:IsA("Model") then
      value21:Destroy()
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
    { "Reactor 4", Vector3.new(-230, -30, -1428) }, { "Mutant", Vector3.new(-155, -33, -1565) },
    { "Valve", Vector3.new(-225, -35, -1635) },
    { "Generator 2", Vector3.new(-145, -30, -1149) },
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
  ["Out-of-map"] = {
    { "Baseplate", Vector3.new(-200, -2, -75) },
    { "Rasonian armory", Vector3.new(63, 23, -1705) },
  },
}

function teleportTo(p47)
  local character23 = localPlayer.Character

  if character23 and character23:FindFirstChild("HumanoidRootPart") then
    character23:PivotTo(CFrame.new(p47))
  end
end

function teleportToCFrame(p48)
  local character24 = localPlayer.Character

  if character24 and character24:FindFirstChild("HumanoidRootPart") then
    character24:PivotTo(p48)
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

function playToggleAnim(animationId2, p49)
  local character25 = localPlayer.Character

  if not character25 then
    return
  else
    local humanoid14 = character25:FindFirstChildOfClass("Humanoid")

    if not humanoid14 then
      return
    else
      local animator12 = humanoid14:FindFirstChildOfClass("Animator")
        or Instance.new("Animator", humanoid14)

      if p49 then
        if activeAnimTrack then
          activeAnimTrack:Stop()
        end

        local animation9 = Instance.new("Animation")
        animation9.AnimationId = animationId2

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

function playButtonAnim(animationId3)
  local character26 = localPlayer.Character

  if not character26 then
    return
  else
    local humanoid15 = character26:FindFirstChildOfClass("Humanoid")

    if not humanoid15 then
      return
    else
      local animator13 = humanoid15:FindFirstChildOfClass("Animator")
        or Instance.new("Animator", humanoid15)

      local animation10 = Instance.new("Animation")
      animation10.AnimationId = animationId3

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
    local character27 = localPlayer.Character
    local tool = character27 and character27:FindFirstChildOfClass("Tool")

    if not tool then
      return nil
    else
      local findFirstChild3 = playerGui4:FindFirstChild(tool.Name)

      return findFirstChild3 and findFirstChild3:FindFirstChild("Data")
        and findFirstChild3.Data:FindFirstChild("Cooldowns")
    end
  end
end

function setCooldownVisibility(p50, visible)
  local v44 = getCooldownContainer()

  if not v44 then
    return
  else
    local findFirstChild4 = v44:FindFirstChild(p50)

    if findFirstChild4 then
      findFirstChild4.Visible = visible
    end

    v44.Visible = (v44:FindFirstChild("Bash") and v44.Bash.Visible
          or v44:FindFirstChild("Kick") and v44.Kick.Visible)
        and true
      or false

    return
  end
end

function resetFade(p51)
  for index18, value22 in ipairs(p51:GetDescendants()) do
    if value22:IsA("Frame") and value22:GetAttribute("_cd_BackgroundTransparency") then
      value22.BackgroundTransparency = value22:GetAttribute("_cd_BackgroundTransparency")
    elseif value22:IsA("ImageLabel") or value22:IsA("ImageButton") then
      if value22:GetAttribute("_cd_ImageTransparency") then
        value22.ImageTransparency = value22:GetAttribute("_cd_ImageTransparency")
      end

      if value22:GetAttribute("_cd_BackgroundTransparency") then
        value22.BackgroundTransparency = value22:GetAttribute("_cd_BackgroundTransparency")
      end
    elseif value22:IsA("TextLabel") or value22:IsA("TextButton") or value22:IsA("TextBox") then
      if value22:GetAttribute("_cd_TextTransparency") then
        value22.TextTransparency = value22:GetAttribute("_cd_TextTransparency")
      end

      if value22:GetAttribute("_cd_BackgroundTransparency") then
        value22.BackgroundTransparency = value22:GetAttribute("_cd_BackgroundTransparency")
      end
    elseif value22:IsA("UIStroke") and value22:GetAttribute("_cd_Transparency") then
      value22.Transparency = value22:GetAttribute("_cd_Transparency")
    end
  end
end

function fadeOut(p52, p53)
  local tweenInfo = TweenInfo.new(p53, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

  for index19, value23 in ipairs(p52:GetDescendants()) do
    if value23:IsA("Frame") then
      if not value23:GetAttribute("_cd_BackgroundTransparency") then
        value23:SetAttribute("_cd_BackgroundTransparency", value23.BackgroundTransparency)
      end

      tweenService:Create(value23, tweenInfo, { BackgroundTransparency = 1 }):Play()
    elseif value23:IsA("ImageLabel") or value23:IsA("ImageButton") then
      if not value23:GetAttribute("_cd_ImageTransparency") then
        value23:SetAttribute("_cd_ImageTransparency", value23.ImageTransparency)
      end

      if not value23:GetAttribute("_cd_BackgroundTransparency") then
        value23:SetAttribute("_cd_BackgroundTransparency", value23.BackgroundTransparency)
      end

      tweenService:Create(value23, tweenInfo, {
        ImageTransparency = 1,
        BackgroundTransparency = 1,
      }):Play()
    elseif value23:IsA("TextLabel") or value23:IsA("TextButton") or value23:IsA("TextBox") then
      if not value23:GetAttribute("_cd_TextTransparency") then
        value23:SetAttribute("_cd_TextTransparency", value23.TextTransparency)
      end

      if not value23:GetAttribute("_cd_BackgroundTransparency") then
        value23:SetAttribute("_cd_BackgroundTransparency", value23.BackgroundTransparency)
      end

      tweenService:Create(value23, tweenInfo, {
        TextTransparency = 1,
        BackgroundTransparency = 1,
      }):Play()
    elseif value23:IsA("UIStroke") then
      if not value23:GetAttribute("_cd_Transparency") then
        value23:SetAttribute("_cd_Transparency", value23.Transparency)
      end

      tweenService:Create(value23, tweenInfo, { Transparency = 1 }):Play()
    end
  end
end

function getCooldownBar(p54)
  local playerGui5 = localPlayer:FindFirstChild("PlayerGui")

  if not playerGui5 then
    return nil
  else
    local character28 = localPlayer.Character
    local tool2 = character28 and character28:FindFirstChildOfClass("Tool")

    if not tool2 then
      return nil
    else
      local findFirstChild5 = playerGui5:FindFirstChild(tool2.Name)

      if findFirstChild5 and findFirstChild5:FindFirstChild("Data")
        and findFirstChild5.Data:FindFirstChild("Cooldowns")
        and findFirstChild5.Data.Cooldowns:FindFirstChild(p54) then
        return findFirstChild5.Data.Cooldowns[p54]:FindFirstChild("Bar")
      end

      return nil
    end
  end
end

function playCooldown(p55, p56, p57)
  local cooldownCounter = CooldownCounter
  local v45 = getCooldownBar(p55)
  local v46, create2

  if not v45 then
    return
  else
    v46 = getCooldownContainer()
    local findFirstChild6 = v46 and v46:FindFirstChild(p55)

    if findFirstChild6 then
      resetFade(findFirstChild6)
    end

    if ActiveTweens[p55] then
      ActiveTweens[p55]:Cancel()
      ActiveTweens[p55] = nil
    end

    v45.AnchorPoint = Vector2.new(0, 1)
    v45.Position = UDim2.new(0, 0, 1, 0)
    v45.Size = UDim2.new(1, 0, math.clamp(p57 or 0, 0, 1), 0)
    v45.Visible = true

    create2 = tweenService:Create(v45, TweenInfo.new(
      p56, Enum.EasingStyle.Linear, Enum.EasingDirection.Out
    ), { Size = UDim2.new(1, 0, 1, 0) })

    ActiveTweens[p55] = create2

    if v46 then
      setCooldownVisibility(p55, true)
    end

    create2:Play()

    create2.Completed:Connect(function()
      if cooldownCounter ~= CooldownCounter or ActiveTweens[p55] ~= create2 then
        return
      end

      ActiveTweens[p55] = nil
      CooldownData[p55] = nil

      if findFirstChild6 then
        fadeOut(findFirstChild6, 0.2)
      end

      task.delay(0.2, function()
        if cooldownCounter ~= CooldownCounter then
          return
        end

        v45.Visible = false

        if v46 then
          setCooldownVisibility(p55, false)
        end

        if findFirstChild6 then
          resetFade(findFirstChild6)
        end
      end)
    end)

    return
  end
end

function renderCooldown(p58)
  local v47 = CooldownData[p58]

  if not v47 then
    if getCooldownContainer() then
      setCooldownVisibility(p58, false)
    end

    return
  else
    local v48 = tick()
    local v49 = v47.finish - v48

    if v49 <= 0 then
      CooldownData[p58] = nil

      if getCooldownContainer() then
        setCooldownVisibility(p58, false)
      end

      return
    end

    playCooldown(
      p58, v49, v47.duration > 0 and math.clamp((v48 - v47.start) / v47.duration, 0, 1) or 0
    )

    return
  end
end

function renderAllCooldowns()
  CooldownCounter = CooldownCounter + 1

  for key7, value24 in pairs(ActiveTweens) do
    if value24 then
      value24:Cancel()
    end

    ActiveTweens[key7] = nil
  end

  renderCooldown("Bash")
  renderCooldown("Kick")
end

if BashCooldownUI then
  BashCooldownUI.OnClientEvent:Connect(function(p59, p60)
    local v50 = p59

    if v50 == "bash" then
      v50 = "Bash"
    end

    if v50 == "kick" then
      v50 = "Kick"
    end

    local v51 = tick()
    CooldownData[v50] = { start = v51, duration = p60, finish = v51 + p60 }
    renderAllCooldowns()
  end)
end

userInputService.InputBegan:Connect(function(input6, p61)
  SentinelLastInteraction = tick()

  if p61 then
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
    local character29 = localPlayer.Character

    if character29 then
      local humanoid16 = character29:FindFirstChildOfClass("Humanoid")

      if humanoid16 and Config.SpeedHackEnabled then
        humanoid16.WalkSpeed = Config.WalkSpeedValue
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

function hookToolSwap(p62)
  p62.ChildAdded:Connect(function(child7)
    if child7:IsA("Tool") then
      task.defer(renderAllCooldowns)
    end
  end)

  p62.ChildRemoved:Connect(function(child8)
    if child8:IsA("Tool") then
      task.defer(renderAllCooldowns)
    end
  end)
end

if localPlayer.Character then
  hookToolSwap(localPlayer.Character)
  task.defer(renderAllCooldowns)
end

localPlayer.CharacterAdded:Connect(function(character30)
  hookToolSwap(character30)
  task.defer(renderAllCooldowns)
  local waitForChild = character30:WaitForChild("Humanoid", 5)

  if waitForChild then
    savedHipHeight = waitForChild.HipHeight
  end

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
    character30:SetAttribute("StaggerImmune", true)
  end

  if Config.FlyEnabled then
    task.wait(0.5)
    CurrentFlyType = "Seat [UNDETECTED]"
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
    ClientEvents.client.Event:Connect(function(p63, ...)
      if Config.AntiCamShake and (p63 == "camspring" or p63 == "recoil" or p63 == "shake") then
        return
      end
    end)
  end)
end

function checkMob(p64)
  local characters3 = workspace:FindFirstChild("Characters")

  if characters3 and not p64:IsDescendantOf(characters3) then
    return
  end

  if p64:IsA("Model") and p64:FindFirstChild("HumanoidRootPart")
    and p64:FindFirstChildOfClass("Humanoid") then
    if p64 ~= localPlayer.Character and p64.Name ~= localPlayer.Name
      and not players:GetPlayerFromCharacter(p64) and not table.find(CachedMobs, p64) then
      table.insert(CachedMobs, p64)
      p64.AncestryChanged:Connect(function(p65, p66) end)
    end
  end
end

task.spawn(function()
  local characters4 = workspace:FindFirstChild("Characters")

  for index20, value25 in ipairs(characters4 and characters4:GetDescendants()
    or workspace:GetDescendants()) do
    checkMob(value25)

    if index20 % 200 == 0 then
      task.wait()
    end
  end
end)

workspace.DescendantAdded:Connect(function(descendant6)
  if descendant6:IsA("Model") then
    task.wait(0.3)
    checkMob(descendant6)
  end
end)

local jumpRequest = userInputService.JumpRequest

local function f18(p67, p68, color, thickness)
  if not p67 or not p68 then
    return
  else
    local humanoidRootPart13 = p68:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart13 then
      for index21, value26 in ipairs(p67) do
        value26.Visible = false
      end

      return
    else
      local humanoid17 = p68:FindFirstChildOfClass("Humanoid")

      if not humanoid17 or humanoid17.Health <= 0 then
        for index22, value27 in ipairs(p67) do
          value27.Visible = false
        end

        return
      else
        local position = humanoidRootPart13.Position
        local position2 = currentCamera.CFrame.Position
        local cframe2 = CFrame.lookAt(position, position + (position - position2).Unit)
        local x = humanoidRootPart13.Size.X
        local v52 = humanoidRootPart13.Size.Y * 1.5
        local cframe3 = CFrame.new(-x, v52, 0)
        local cframe4 = CFrame.new(x, v52, 0)
        local cframe5 = CFrame.new(-x, -v52, 0)
        local cframe6 = CFrame.new(x, -v52, 0)
        local v53, v54 = currentCamera:WorldToViewportPoint((cframe2 * cframe3).p)
        local v55, v56 = currentCamera:WorldToViewportPoint((cframe2 * cframe4).p)
        local v57, v58 = currentCamera:WorldToViewportPoint((cframe2 * cframe5).p)
        local v59, v60 = currentCamera:WorldToViewportPoint((cframe2 * cframe6).p)

        if not v54 then
          for index23, value28 in ipairs(p67) do
            value28.Visible = false
          end

          return
        else
          local magnitude2 = (position - position2).Magnitude
          local v61 = math.clamp(1 / magnitude2 * 750, 2, 300)

          p67[1].From = Vector2.new(v53.X, v53.Y)
          p67[1].To = Vector2.new(v53.X + v61, v53.Y)
          p67[2].From = Vector2.new(v53.X, v53.Y)
          p67[2].To = Vector2.new(v53.X, v53.Y + v61)
          p67[3].From = Vector2.new(v55.X, v55.Y)
          p67[3].To = Vector2.new(v55.X - v61, v55.Y)
          p67[4].From = Vector2.new(v55.X, v55.Y)
          p67[4].To = Vector2.new(v55.X, v55.Y + v61)
          p67[5].From = Vector2.new(v57.X, v57.Y)
          p67[5].To = Vector2.new(v57.X + v61, v57.Y)
          p67[6].From = Vector2.new(v57.X, v57.Y)
          p67[6].To = Vector2.new(v57.X, v57.Y - v61)
          p67[7].From = Vector2.new(v59.X, v59.Y)
          p67[7].To = Vector2.new(v59.X - v61, v59.Y)
          p67[8].From = Vector2.new(v59.X, v59.Y)
          p67[8].To = Vector2.new(v59.X, v59.Y - v61)

          for index24, value29 in ipairs(p67) do
            value29.Color = color

            if Config.BoxAutoThickness then
              value29.Thickness = math.clamp(1 / magnitude2 * 100, 1, 4)
            else
              value29.Thickness = thickness
            end

            value29.Visible = true
            value29.Transparency = 1
          end

          return
        end
      end
    end
  end
end

jumpRequest:Connect(function()
  local character31 = localPlayer.Character
  local humanoid18 = character31 and character31:FindFirstChildOfClass("Humanoid")
  local humanoidRootPart14 = character31 and character31:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart14 or not humanoid18 then
    return
  else
    local jumpPowerValue = Config.JumpPowerEnabled and Config.JumpPowerValue or 50

    if Config.InfiniteJump then
      humanoidRootPart14.Velocity = Vector3.new(
        humanoidRootPart14.Velocity.X, jumpPowerValue, humanoidRootPart14.Velocity.Z
      )

      humanoid18:ChangeState(Enum.HumanoidStateType.Jumping)
    end

    if Config.JumpBypassActive and not Config.InfiniteJump then
      if humanoid18.FloorMaterial ~= Enum.Material.Air then
        humanoidRootPart14.Velocity = Vector3.new(
          humanoidRootPart14.Velocity.X, jumpPowerValue, humanoidRootPart14.Velocity.Z
        )
      end
    end

    return
  end
end)

local function f19(color2, thickness2)
  local v62 = {}

  for j = 1, 8 do
    local line = Drawing.new("Line")
    line.Visible = false
    line.From = Vector2.new(0, 0)
    line.To = Vector2.new(0, 0)
    line.Color = color2
    line.Thickness = thickness2
    line.Transparency = 1

    v62[j] = line
  end

  return v62
end

local function f20(p69)
  if not p69 then
    return
  else
    local humanoidRootPart15 = p69:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart15 then
      local sentinelInfoBBG = humanoidRootPart15:FindFirstChild("SentinelInfoBBG")

      if sentinelInfoBBG then
        sentinelInfoBBG:Destroy()
      end
    end

    return
  end
end

local v63 = {}

local function f21(p70)
  if not p70 then
    return
  end

  for index25, value30 in ipairs(p70) do
    local v64 = value30
    pcall(function() v64:Remove() end)
  end
end

local function f22()
  if AutoReloadToolConn then
    AutoReloadToolConn:Disconnect()
    AutoReloadToolConn = nil
  end

  AutoReloadWatching = false
end

local function f23(p71)
  if not p71 then
    return
  end

  for index26, value31 in ipairs(p71) do
    value31.Visible = false
  end
end

local v65 = {}
local f24

local function f25(p72, textColor3, p73, p74, p75, p76)
  if not p72 then
    return
  else
    local v66 = f24(p72)

    if not v66 then
      return
    else
      local name = v66:FindFirstChild("Name")
      local health = v66:FindFirstChild("Health")
      local distance = v66:FindFirstChild("Distance")

      if name then
        name.Visible = p73

        if p73 then
          local getPlayerFromCharacter = players:GetPlayerFromCharacter(p72)
          name.Text = getPlayerFromCharacter and getPlayerFromCharacter.Name or p72.Name
          name.TextColor3 = textColor3
        end
      end

      if health then
        health.Visible = p74

        if p74 then
          local humanoid19 = p72:FindFirstChildOfClass("Humanoid")

          if humanoid19 then
            health.Text = math.round(humanoid19.Health) .. " HP"
            health.TextColor3 = textColor3
          end
        end
      end

      if distance then
        distance.Visible = p75

        if p75 and p76 then
          distance.Text = string.format("%.1f m", p76)
          distance.TextColor3 = textColor3
        end
      end

      return
    end
  end
end

function f24(p77)
  if not p77 then
    return nil
  else
    local humanoidRootPart16 = p77:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart16 then
      return nil
    else
      local sentinelInfoBBG2 = humanoidRootPart16:FindFirstChild("SentinelInfoBBG")

      if not sentinelInfoBBG2 then
        sentinelInfoBBG2 = Instance.new("BillboardGui")
        sentinelInfoBBG2.Name = "SentinelInfoBBG"
        sentinelInfoBBG2.Size = UDim2.new(0, 200, 0, 60)
        sentinelInfoBBG2.AlwaysOnTop = true
        sentinelInfoBBG2.StudsOffset = Vector3.new(0, 3.5, 0)
        sentinelInfoBBG2.Adornee = humanoidRootPart16
        sentinelInfoBBG2.Parent = humanoidRootPart16

        local uiListLayout = Instance.new("UIListLayout")
        uiListLayout.FillDirection = Enum.FillDirection.Vertical
        uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
        uiListLayout.Parent = sentinelInfoBBG2

        local name2 = Instance.new("TextLabel")
        name2.Name = "Name"
        name2.Size = UDim2.new(1, 0, 0, 16)
        name2.BackgroundTransparency = 1
        name2.TextStrokeTransparency = 0.5
        name2.Font = Enum.Font.SourceSansBold
        name2.TextSize = 14
        name2.Visible = false
        name2.Parent = sentinelInfoBBG2

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
  local humanoid20

  if not SentinelActive then
    return
  else
    local character32 = localPlayer.Character

    if not character32 then
      return
    end

    humanoid20 = character32:FindFirstChildOfClass("Humanoid")

    if not humanoid20 or humanoid20.Health <= 0 then
      return
    else
      if Config.SpeedHackEnabled then
        humanoid20.WalkSpeed = Config.WalkSpeedValue
      end

      if Config.JumpPowerEnabled then
        pcall(function()
          humanoid20.UseJumpPower = true
          humanoid20.JumpPower = Config.JumpPowerValue
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
        local character33 = localPlayer.Character

        if character33 then
          local humanoidRootPart17 = character33:FindFirstChild("HumanoidRootPart")

          if humanoidRootPart17 and humanoidRootPart17.Anchored then
            humanoidRootPart17.Anchored = false
          end
        end
      end

      local character34 = localPlayer.Character
      local humanoidRootPart18 = character34 and character34:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart18 then
        return
      else
        local v67 = {}

        for key9, value32 in pairs(v63) do
          if not key9 or not key9.Parent then
            table.insert(v67, key9)
          end
        end

        for index27, value33 in ipairs(v67) do
          if v63[value33] then
            f21(v63[value33])
            v63[value33] = nil
          end

          f20(value33)
          v65[value33] = nil
        end

        for key10, value34 in pairs(players:GetPlayers()) do
          if value34 ~= localPlayer then
            local character35 = value34.Character

            local humanoidRootPart19 = character35
            humanoidRootPart19 = character35 and character35:FindFirstChild("HumanoidRootPart")

            local humanoid21 = character35
            humanoid21 = character35 and character35:FindFirstChildOfClass("Humanoid")

            if humanoidRootPart19 and humanoid21 then
              local magnitude3 = (humanoidRootPart18.Position - humanoidRootPart19.Position).Magnitude
              local isFriendsWith = localPlayer:IsFriendsWith(value34.UserId)
              local colorFriends = isFriendsWith and Config.ColorFriends or Config.ColorPlayer

              local highlightFriends = isFriendsWith and Config.HighlightFriends
                or Config.HighlightPlayer

              local boxFriends = isFriendsWith and Config.BoxFriends or Config.BoxPlayers

              local showNameFriends = isFriendsWith and Config.ShowNameFriends
                or Config.ShowNamePlayers

              local showHealthFriends = isFriendsWith and Config.ShowHealthFriends
                or Config.ShowHealthPlayers

              local showDistanceFriends = isFriendsWith and Config.ShowDistanceFriends
                or Config.ShowDistancePlayers

              if magnitude3 <= Config.MaxDistance and humanoid21.Health > 0 then
                local sentinelHL = character35:FindFirstChild("SentinelHL")

                if highlightFriends then
                  if not sentinelHL then
                    sentinelHL = Instance.new("Highlight", character35)
                    sentinelHL.Name = "SentinelHL"
                  end

                  sentinelHL.FillColor = colorFriends
                  sentinelHL.FillTransparency = Config.HLFillTrans
                  sentinelHL.OutlineTransparency = Config.HLOutlineTrans
                elseif sentinelHL then
                  sentinelHL:Destroy()
                end

                if boxFriends then
                  if not v63[character35] then
                    v63[character35] = f19(colorFriends, Config.BoxThickness)
                  end

                  f18(v63[character35], character35, colorFriends, Config.BoxThickness)
                elseif v63[character35] then
                  f23(v63[character35])
                end

                f25(
                  character35, colorFriends, showNameFriends, showHealthFriends,
                  showDistanceFriends, magnitude3
                )
              else
                if v63[character35] then
                  f23(v63[character35])
                end

                if character35:FindFirstChild("SentinelHL") then
                  character35.SentinelHL:Destroy()
                end

                f20(character35)
              end
            elseif character35 then
              if v63[character35] then
                f21(v63[character35])
                v63[character35] = nil
              end

              if character35:FindFirstChild("SentinelHL") then
                character35.SentinelHL:Destroy()
              end

              f20(character35)
            end
          end
        end

        local v68 = #CachedMobs - -1

        while true do
          v68 = -1 + v68

          if not (1 <= v68 or false) then
            break
          end

          local v69 = v68
          local v70 = CachedMobs[v69]

          if v70 and v70.Parent then
            if v70 == character34 or v70 == localPlayer.Character
              or v70.Name == localPlayer.Name or players:GetPlayerFromCharacter(v70) then
              if v63[v70] then
                f21(v63[v70])
                v63[v70] = nil
              end

              if v70:FindFirstChild("SentinelMobHL") then
                v70.SentinelMobHL:Destroy()
              end

              f20(v70)
              table.remove(CachedMobs, v69)
            else
              local humanoidRootPart20 = v70:FindFirstChild("HumanoidRootPart")
              local humanoid22 = v70:FindFirstChildOfClass("Humanoid")

              if humanoidRootPart20 and humanoid22 then
                local magnitude4 = (humanoidRootPart18.Position - humanoidRootPart20.Position).Magnitude
                local v71 = f6(v70)
                local colorBosses = v71 and Config.ColorBosses or Config.ColorMobs
                local highlightBosses = v71 and Config.HighlightBosses or Config.HighlightMobs
                local boxBosses = v71 and Config.BoxBosses or Config.BoxMobs
                local showNameBosses = v71 and Config.ShowNameBosses or Config.ShowNameMobs

                local showHealthBosses = v71 and Config.ShowHealthBosses
                  or Config.ShowHealthMobs

                local showDistanceBosses = v71 and Config.ShowDistanceBosses
                  or Config.ShowDistanceMobs

                if magnitude4 <= Config.MaxDistance and humanoid22.Health > 0 then
                  local sentinelMobHL = v70:FindFirstChild("SentinelMobHL")

                  if highlightBosses then
                    if not sentinelMobHL then
                      sentinelMobHL = Instance.new("Highlight", v70)
                      sentinelMobHL.Name = "SentinelMobHL"
                    end

                    sentinelMobHL.FillColor = colorBosses
                    sentinelMobHL.FillTransparency = Config.HLFillTrans
                    sentinelMobHL.OutlineTransparency = Config.HLOutlineTrans
                  elseif sentinelMobHL then
                    sentinelMobHL:Destroy()
                  end

                  if boxBosses then
                    if not v63[v70] then
                      v63[v70] = f19(colorBosses, Config.BoxThickness)
                    end

                    f18(v63[v70], v70, colorBosses, Config.BoxThickness)
                  elseif v63[v70] then
                    f23(v63[v70])
                  end

                  f25(
                    v70, colorBosses, showNameBosses, showHealthBosses, showDistanceBosses,
                    magnitude4
                  )
                else
                  if v63[v70] then
                    f23(v63[v70])
                  end

                  if v70:FindFirstChild("SentinelMobHL") then
                    v70.SentinelMobHL:Destroy()
                  end

                  f20(v70)
                end
              end
            end
          else
            if v63[v70] then
              f21(v63[v70])
              v63[v70] = nil
            end

            f20(v70)
            table.remove(CachedMobs, v69)
          end
        end

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

function filterAnimNames(p78)
  local v72 = {}

  for key11, value35 in pairs(toggleAnims) do
    local lower = key11:lower()

    for index28, value36 in ipairs(p78) do
      if lower:sub(-#value36) == value36 then
        table.insert(v72, key11)
        break
      end
    end
  end

  return v72
end

idleAnimNames = filterAnimNames({ "idle", "idle (old)" })
walkAnimNames = filterAnimNames({ "walk", "walk (old)" })
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
  local v73

  if Config.FakeDeath then
    stopAllAnimatorTracks()
    return
  elseif not Config.AnimatorEnabled then
    stopAllAnimatorTracks()
    return
  else
    local character36 = localPlayer.Character

    if not character36 then
      return
    else
      local humanoid23 = character36:FindFirstChildOfClass("Humanoid")

      if not humanoid23 or humanoid23.Health <= 0 then
        return
      else
        local humanoidRootPart21 = character36:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart21 then
          return
        else
          local magnitude5 = Vector3.new(
            humanoidRootPart21.Velocity.X, 0, humanoidRootPart21.Velocity.Z
          ).Magnitude

          if isShiftHeld and magnitude5 > 2 then
            v73 = "run"
          elseif magnitude5 > 0.5 then
            v73 = "walk"
          else
            v73 = "idle"
          end

          if v73 ~= animatorLastState then
            animatorLastState = v73
            stopAllAnimatorTracks()

            if v73 == "idle" and Config.AnimatorIdleAnimName then
              animatorIdleTrack = playAnimationOnHumanoid(
                toggleAnims[Config.AnimatorIdleAnimName], true
              )
            elseif v73 == "walk" and Config.AnimatorWalkAnimName then
              animatorWalkTrack = playAnimationOnHumanoid(
                toggleAnims[Config.AnimatorWalkAnimName], true
              )
            elseif v73 == "run" and Config.AnimatorRunAnimName then
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

ThirdPersonShiftlockState = { enabled = false, wasFirstPerson = false, renderConn = nil }

local function f26()
  local playerGui7 = localPlayer:FindFirstChild("PlayerGui")

  if not playerGui7 then
    return nil
  else
    local findFirstChild7 = playerGui7:FindFirstChild("MobileControls", true)

    if not findFirstChild7 then
      return nil
    end

    return findFirstChild7:FindFirstChild("Reload", true)
  end
end

local vector2 = Vector3.new(1.75, 0.5, 0)

local function f27()
  if localPlayer.CameraMaxZoomDistance <= 0.5 then
    return true
  else
    local character37 = localPlayer.Character
    local head3 = character37 and character37:FindFirstChild("Head")

    if head3 then
      if (currentCamera.CFrame.Position - head3.Position).Magnitude < 1.5 then
        return true
      end

      return false
    end

    return false
  end
end

function ThirdPersonShiftlock_Enable(p79)
  ThirdPersonShiftlockState.enabled = p79

  if ThirdPersonShiftlockState.renderConn then
    ThirdPersonShiftlockState.renderConn:Disconnect()
    ThirdPersonShiftlockState.renderConn = nil
  end

  if not p79 then
    ThirdPersonShiftlockState.wasFirstPerson = false
    pcall(function() userInputService.MouseBehavior = Enum.MouseBehavior.Default end)
    return
  end

  ThirdPersonShiftlockState.renderConn = runService.RenderStepped:Connect(function()
    if not SentinelActive then
      return
    elseif not ThirdPersonShiftlockState.enabled then
      return
    else
      local character38 = localPlayer.Character

      if not character38 then
        return
      else
        local humanoidRootPart22 = character38:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart22 then
          return
        elseif f27() then
          ThirdPersonShiftlockState.wasFirstPerson = true
          return
        else
          ThirdPersonShiftlockState.wasFirstPerson = false
          userInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
          local v74 = { currentCamera.CFrame:ToEulerAnglesYXZ() }

          humanoidRootPart22.CFrame = CFrame.new(humanoidRootPart22.Position)
            * CFrame.Angles(0, v74[2], 0)

          currentCamera.CFrame = currentCamera.CFrame
            + currentCamera.CFrame.RightVector * vector2.X + Vector3.new(0, vector2.Y, 0)

          return
        end
      end
    end
  end)
end

function ThirdPersonShiftlock_Cleanup()
  ThirdPersonShiftlockState.enabled = false

  if ThirdPersonShiftlockState.renderConn then
    pcall(function() ThirdPersonShiftlockState.renderConn:Disconnect() end)
    ThirdPersonShiftlockState.renderConn = nil
  end

  ThirdPersonShiftlockState.wasFirstPerson = false
  pcall(function() userInputService.MouseBehavior = Enum.MouseBehavior.Default end)
end

local v75 = false

local function f28()
  while v75 and SentinelActive do
    local backpack4 = localPlayer:FindFirstChild("Backpack")

    if backpack4 then
      for key12, value37 in pairs(backpack4:GetChildren()) do
        local v76 = value37

        if v76:IsA("Tool") and v76:GetAttribute("ClipCurrent") then
          if v76:GetAttribute("ClipCurrent") < 1e+24 then
            pcall(function()
              v76:SetAttribute("ClipSize", 1e+24)
              v76:SetAttribute("ClipCurrent", 1e+24)
              v76:SetAttribute("MaxAmmo", 1e+24)
            end)
          end
        end
      end
    end

    task.wait(0.1)
  end
end

local v77

function toggleNightStalkerInfAmmo(p80)
  Config.NightStalkerInfAmmo = p80

  if p80 then
    if not v75 then
      v75 = true

      if v77 then
        task.cancel(v77)
      end

      v77 = task.spawn(f28)
    end
  else
    v75 = false

    if v77 then
      task.cancel(v77)
      v77 = nil
    end
  end
end

AutoReloadWatching = false
AutoReloadToolConn = nil
AutoReloadCharConn = nil

local function f29()
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

  local v78 = f26()
  local activated

  if v78 then
    activated = v78.Activated

    if activated then
      pcall(function() activated:Fire() end)
    end
  end
end

local function f30(p81)
  local clipCurrent = p81:GetAttribute("ClipCurrent")
  local maxAmmo = p81:GetAttribute("MaxAmmo")
  local v79 = clipCurrent == 0
  local reloading = p81:GetAttribute("Reloading")

  if v79 and (maxAmmo or 0) > 0 and not reloading and not AutoReloadWatching then
    AutoReloadWatching = true

    task.delay(1.5, function()
      f29()
      task.delay(0.5, function() AutoReloadWatching = false end)
    end)
  end
end

local f31

local function f32(p82)
  f22()

  p82.ChildAdded:Connect(function(child9)
    if child9:IsA("Tool") then
      f31(child9)
    end
  end)

  p82.ChildRemoved:Connect(function(child10)
    if child10:IsA("Tool") then
      f22()
    end
  end)

  local tool3 = p82:FindFirstChildOfClass("Tool")

  if tool3 then
    f31(tool3)
  end
end

function f31(p83)
  f22()

  if not p83:GetAttribute("IsGun") then
    return
  end

  task.delay(1.5, function() f30(p83) end)

  AutoReloadToolConn = p83:GetAttributeChangedSignal("ClipCurrent"):Connect(function()
    f30(p83)
  end)
end

AutoReloadCharacterConn = nil

function toggleAutoReload(p84)
  Config.AutoReload = p84

  if p84 then
    if localPlayer.Character then
      f32(localPlayer.Character)
    end

    if AutoReloadCharacterConn then
      AutoReloadCharacterConn:Disconnect()
    end

    AutoReloadCharacterConn = localPlayer.CharacterAdded:Connect(f32)
  else
    f22()

    if AutoReloadCharacterConn then
      AutoReloadCharacterConn:Disconnect()
      AutoReloadCharacterConn = nil
    end
  end
end

local v80 = {
  ["+100%"] = { attr = "FelsiReloadSpeedMult", val = 1 },
  ["+200%"] = { attr = "SquadReloadSpeedMultiplier", val = 2 },
  ["+150%"] = { attr = "AdminstalSpeedMult", val = 1.5 },
}

local v81 = { "FelsiReloadSpeedMult", "SquadReloadSpeedMultiplier", "AdminstalSpeedMult" }

local function f33(p85)
  if not p85 then
    return
  end

  for index29, value38 in ipairs(v81) do
    p85:SetAttribute(value38, 1)
  end

  for index30, value39 in ipairs(Config.FastReloadBoosts) do
    local v82 = v80[value39]

    if v82 then
      p85:SetAttribute(v82.attr, v82.val)
    end
  end
end

local function f34(p86)
  if not p86 then
    return
  end

  for index31, value40 in ipairs(v81) do
    p86:SetAttribute(value40, 1)
  end
end

local connect2

function toggleFastReload(p87)
  Config.FastReload = p87

  if connect2 then
    connect2:Disconnect()
    connect2 = nil
  end

  if p87 then
    if localPlayer.Character then
      f33(localPlayer.Character)
    end

    connect2 = localPlayer.CharacterAdded:Connect(function(character39)
      character39:WaitForChild("Humanoid")
      f33(character39)
    end)
  elseif localPlayer.Character then
    f34(localPlayer.Character)
  end
end

local function f35(p88)
  local v83 = {}

  if type(p88) == "table" then
    for index32, value41 in ipairs(p88) do
      local title = value41

      if type(value41) == "table" then
        title = value41.Title or value41.Value
      end

      if v80[title] then
        table.insert(v83, title)
      end
    end
  elseif type(p88) == "string" and v80[p88] then
    v83 = { p88 }
  end

  Config.FastReloadBoosts = v83

  if Config.FastReload and localPlayer.Character then
    pcall(f33, localPlayer.Character)
  end
end

InstantShotgunConnection = nil
local v84 = { ["SRS-58"] = true, ["PMS-12T 'Hammer'"] = true }

local v85 = {
  ["rbxassetid://83290487541789"] = true,
  ["rbxassetid://116823220427411"] = true,
  ["rbxassetid://126710614165281"] = true,
  ["rbxassetid://115903749552317"] = true,
}

local function f36(p89)
  if InstantShotgunConnection then
    InstantShotgunConnection:Disconnect()
    InstantShotgunConnection = nil
  end

  if not p89 then
    return
  elseif not Config.InstantShotgunReload then
    return
  else
    InstantShotgunConnection = p89:WaitForChild("Humanoid"):WaitForChild("Animator").AnimationPlayed:Connect(function(p90)
      if not Config.InstantShotgunReload then
        return
      end

      if not (p90.Animation and v85[p90.Animation.AnimationId]) then
        return
      else
        local tool4 = p89:FindFirstChildOfClass("Tool")

        if not tool4 or not v84[tool4.Name] then
          return
        end

        pcall(function() p90:AdjustSpeed(100) end)

        task.delay(0.05, function()
          if p90.IsPlaying then
            pcall(function() p90:AdjustSpeed(100) end)
          end
        end)

        return
      end
    end)

    return
  end
end

function setupInstantShotgunReload(p91)
  if InstantShotgunConnection then
    InstantShotgunConnection:Disconnect()
    InstantShotgunConnection = nil
  end

  Config.InstantShotgunReload = p91

  if p91 then
    if localPlayer.Character then
      f36(localPlayer.Character)
    end
  end
end

localPlayer.CharacterAdded:Connect(function(character40)
  if Config.InstantShotgunReload then
    task.wait(1)
    f36(character40)
  end
end)

local v86 = { fovCircle = nil, hooked = false, originalNew = nil }
local v87 = cloneref or function(p92) return p92 end
local v88 = clonefunction or function(p93) return p93 end
local v89 = newcclosure or v88
local v90 = v87(players)
local v91 = v87(runService)
local v92 = v87(userInputService)
local v93 = v87(replicatedStorage)

v86.fovCircle = Drawing.new("Circle")
v86.fovCircle.Thickness = 1.5
v86.fovCircle.NumSides = 128
v86.fovCircle.Filled = false
v86.fovCircle.Transparency = 1
v86.fovCircle.Radius = Config.SilentAimFOVRadius
v86.fovCircle.Color = Config.SilentAimFOVNoTargetColor
v86.fovCircle.Visible = false

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude

local function f37(p94)
  local head4 = p94:FindFirstChild("Head")

  if head4 and head4:IsA("BasePart") then
    return head4
  else
    local collisions = p94:FindFirstChild("Collisions")

    if collisions then
      local headCollision = collisions:FindFirstChild("Head Collision")
        or collisions:FindFirstChild("Head")

      if headCollision and headCollision:IsA("BasePart") then
        return headCollision
      end

      for index33, value42 in ipairs(p94:GetChildren()) do
        if value42:IsA("BasePart") and value42.Name:lower():find("head") then
          return value42
        end
      end

      return nil
    end

    for index34, value43 in ipairs(p94:GetChildren()) do
      if value43:IsA("BasePart") and value43.Name:lower():find("head") then
        return value43
      end
    end

    return nil
  end
end

raycastParams.IgnoreWater = true

local function f38(p95)
  return p95:FindFirstChild("HumanoidRootPart") or p95:FindFirstChild("Torso")
    or p95:FindFirstChild("UpperTorso") or p95:FindFirstChild("LowerTorso") or p95.PrimaryPart
    or p95:FindFirstChildWhichIsA("BasePart")
end

local f39

local function f40(p96, p97, p98)
  local character41 = v90.LocalPlayer.Character

  if not (character41 and p96) then
    return false, nil, nil
  else
    local v94 = { character41, workspace.CurrentCamera, workspace.Terrain }
    local characters5 = workspace:FindFirstChild("Characters")

    if characters5 then
      for index35, value44 in ipairs(characters5:GetChildren()) do
        if value44 ~= p98 then
          table.insert(v94, value44)
        end
      end
    end

    for index36, value45 in ipairs(f39()) do
      if value45 ~= p98 then
        table.insert(v94, value45)
      end
    end

    raycastParams.FilterDescendantsInstances = v94

    local position3 = p97
      or workspace.CurrentCamera and workspace.CurrentCamera.CFrame
        and workspace.CurrentCamera.CFrame.Position
      or Vector3.zero

    local raycast = workspace:Raycast(position3, p96.Position - position3, raycastParams)

    if not raycast then
      return true, p96, p96.Position
    else
      local parent6 = p98 or p96.Parent

      if parent6 and raycast.Instance:IsDescendantOf(parent6) then
        return true, p98 and p98:FindFirstChild("Right Arm")
            and p98["Right Arm"]:FindFirstChild("Shield") and p98:FindFirstChild("Head")
          or raycast.Instance, raycast.Position
      end

      return false, raycast.Instance, raycast.Position
    end
  end
end

function f39()
  local v95 = {}

  for index37, value46 in ipairs(v90:GetPlayers()) do
    if value46.Character then
      table.insert(v95, value46.Character)
    end
  end

  return v95
end

local function f41(p99)
  if not Config.SilentAimEnabled then
    return nil, nil
  else
    local v96 = nil
    local v97 = nil
    local silentAimFOVRadius = Config.SilentAimFOVRadius or 150
    local currentCamera4 = workspace.CurrentCamera
    local viewportSize = currentCamera4 and currentCamera4.ViewportSize or Vector2.new(800, 600)

    local getMouseLocation = Config.SilentAimFOVMode == "Mouse" and v92:GetMouseLocation() or Vector2.new(
      (viewportSize.X or 800) / 2, (viewportSize.Y or 600) / 2
    )

    local characters6 = workspace:FindFirstChild("Characters")

    if not characters6 then
      return nil, nil
    end

    for index38, value47 in ipairs(characters6:GetChildren()) do
      local humanoid24 = value47:IsA("Model") and value47:FindFirstChildOfClass("Humanoid")

      if humanoid24 and humanoid24.Health > 0
        and not value47:FindFirstChildOfClass("ForceField")
        and (value47:FindFirstChild("AI") or not v90:GetPlayerFromCharacter(value47)) then
        local headCollision2 = nil

        if Config.SilentAimTargetPart == "Head" then
          headCollision2 = f37(value47)
        end

        if not headCollision2 then
          headCollision2 = f38(value47)
        end

        if not headCollision2 then
          local collisions2 = value47:FindFirstChild("Collisions")

          if collisions2 then
            headCollision2 = collisions2:FindFirstChild("Head Collision")
              or collisions2:FindFirstChild("Left Arm Collision")
              or collisions2:FindFirstChild("Right Arm Collision")
              or collisions2:FindFirstChildWhichIsA("BasePart")
          end
        end

        if headCollision2 then
          local position4 = headCollision2.Position
          local v98, v99 = currentCamera4:WorldToViewportPoint(position4)

          if v99 then
            local v100 = true

            if Config.SilentAimWallCheck then
              local v101, v102, v103 = f40(headCollision2, p99, value47)

              if not v101 then
                local v104 = f38(value47)

                if v104 then
                  v101, v102, v103 = f40(v104, p99, value47)
                end
              end

              if not v101 then
                v100 = false
              elseif v102 and v103 then
                position4 = v103
                headCollision2 = v102
              end
            end

            if v100 then
              local magnitude6 = (Vector2.new(v98.X, v98.Y) - getMouseLocation).Magnitude

              if magnitude6 < silentAimFOVRadius then
                v96 = headCollision2
                v97 = position4
                silentAimFOVRadius = magnitude6
              end
            end
          end
        end
      end
    end

    return v96, v97
  end
end

local function f42()
  if v86.hooked then
    return
  end

  local v105

  if not (hookfunction and clonefunction and newcclosure) then
    return
  else
    local v106, v107 = pcall(require, v93.Assets.Modules.Raycast.ActiveCast)

    if v106 and v107 then
      v105 = nil

      v105 = v88(hookfunction(rawget(v107, "new"), v89(function(p100, p101, p102, p103, ...)
        local v108, v109 = f41(p101)

        if v108 and v109 and p101 then
          local v110 = v109 - p101

          if typeof(v110) == "Vector3" and v110.Magnitude > 0 then
            local magnitude7 = 1000

            if typeof(p103) == "Vector3" and p103.Magnitude > 0 then
              magnitude7 = p103.Magnitude
            end

            local v111 = v110.Unit
            return v105(p100, p101, v111, v111 * magnitude7, ...)
          end

          return v105(p100, p101, p102, p103, ...)
        end

        return v105(p100, p101, p102, p103, ...)
      end)))

      v86.hooked = true
      v86.originalNew = v105
    end

    return
  end
end

function SilentAim_Enable(p104)
  Config.SilentAimEnabled = p104

  if v86.fovCircle then
    v86.fovCircle.Radius = Config.SilentAimFOVRadius
    local fovCircle = v86.fovCircle
    fovCircle.Visible = p104 and Config.SilentAimShowFOV or false
  end

  if p104 then
    f42()
  end
end

function SilentAim_UpdateFOVVisual()
  if not v86.fovCircle then
    return
  else
    v86.fovCircle.Radius = Config.SilentAimFOVRadius

    local fovCircle2 = v86.fovCircle
    fovCircle2.Visible = Config.SilentAimEnabled and Config.SilentAimShowFOV

    return
  end
end

function SilentAim_Cleanup()
  Config.SilentAimEnabled = false
  Config.SilentAimShowFOV = false

  if v86.fovCircle then
    v86.fovCircle.Visible = false
  end
end

v91.RenderStepped:Connect(function()
  if not SentinelActive then
    return
  else
    local fovCircle3 = v86.fovCircle

    if not fovCircle3 then
      return
    end

    if Config.SilentAimShowFOV and Config.SilentAimEnabled then
      fovCircle3.Visible = true
      local currentCamera5 = workspace.CurrentCamera

      local viewportSize2 = currentCamera5 and currentCamera5.ViewportSize
        or Vector2.new(800, 600)

      fovCircle3.Position = Config.SilentAimFOVMode == "Mouse" and v92:GetMouseLocation() or Vector2.new(
        (viewportSize2.X or 800) / 2, (viewportSize2.Y or 600) / 2
      )

      fovCircle3.Radius = Config.SilentAimFOVRadius or 150

      if f41(currentCamera5 and currentCamera5.CFrame and currentCamera5.CFrame.Position
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

BulletVisualizerState = { activeTrails = {} }

local function f43()
  for index39, value48 in ipairs(localPlayer.PlayerGui:GetChildren()) do
    local data = value48:FindFirstChild("Data")

    if data then
      local clip = data:FindFirstChild("clip")

      if clip and clip:IsA("TextLabel") then
        local v112 = tonumber(clip.Text)

        if v112 ~= nil then
          return v112 > 0
        end
      end
    end
  end

  return true
end

local function f44()
  local character42 = localPlayer.Character

  if not character42 then
    return nil
  end

  for index40, value49 in ipairs(character42:GetChildren()) do
    if value49:IsA("Tool") then
      for index41, value50 in ipairs(value49:GetDescendants()) do
        if value50:IsA("Attachment") and value50.Name == "FirePoint" then
          return value50.WorldPosition
        end
      end
    end
  end

  return nil
end

local f45

function f45(p105)
  if not p105 then
    return false
  else
    local model = p105:FindFirstAncestorOfClass("Model")

    if not model then
      return false
    elseif model == localPlayer.Character then
      return false
    else
      local humanoid25 = model:FindFirstChildWhichIsA("Humanoid")
      return humanoid25 ~= nil and humanoid25.Health > 0
    end
  end
end

local f46

local function f47()
  if not Config.BulletVisualizerEnabled then
    return
  else
    local v113 = f43()
    local v114 = f44()

    if not v114 then
      return
    else
      local getMouse = localPlayer:GetMouse()

      if not getMouse then
        return
      else
        local screenPointToRay = currentCamera:ScreenPointToRay(getMouse.X, getMouse.Y)
        local character43 = localPlayer.Character

        local raycastParams2 = RaycastParams.new()
        raycastParams2.FilterDescendantsInstances = { character43 or {} }
        raycastParams2.FilterType = Enum.RaycastFilterType.Exclude

        local bulletVisualizerRange = Config.BulletVisualizerRange or 500

        local raycast2 = workspace:Raycast(
          screenPointToRay.Origin, screenPointToRay.Direction * bulletVisualizerRange,
          raycastParams2
        )

        f46(v114, raycast2 and raycast2.Position
          or screenPointToRay.Origin + screenPointToRay.Direction * bulletVisualizerRange, raycast2 and raycast2.Instance or nil, not v113)

        return
      end
    end
  end
end

function f46(p106, p107, p108, p109)
  local magnitude8 = (p107 - p106).Magnitude
  local bulletVisualizerFadeOut, bulletTrail

  if magnitude8 < 0.1 then
    return
  else
    local v115 = (p106 + p107) / 2
    local v116 = (p107 - p106).Unit
    local bulletVisualizerThickness = Config.BulletVisualizerThickness or 0.09
    local bulletVisualizerLifetime = Config.BulletVisualizerLifetime or 3
    bulletVisualizerFadeOut = Config.BulletVisualizerFadeOut or 0.8

    bulletTrail = Instance.new("Part")
    bulletTrail.Name = "BulletTrail"
    bulletTrail.Anchored = true
    bulletTrail.CanCollide = false
    bulletTrail.CanQuery = false
    bulletTrail.CanTouch = false
    bulletTrail.CastShadow = false

    bulletTrail.Size = Vector3.new(
      bulletVisualizerThickness, bulletVisualizerThickness, magnitude8
    )

    bulletTrail.CFrame = CFrame.new(v115, v115 + v116)
    bulletTrail.Material = Enum.Material.Neon
    bulletTrail.Parent = workspace

    if p109 then
      bulletTrail.Color = Config.BulletVisualizerColorLoading or Color3.fromRGB(255, 200, 0)
      bulletTrail.Transparency = 0.5
    else
      if f45(p108) then
        bulletTrail.Color = Config.BulletVisualizerColorSuccess or Color3.fromRGB(0, 255, 80)
      else
        bulletTrail.Color = Config.BulletVisualizerColorMissed or Color3.fromRGB(220, 30, 30)
      end

      bulletTrail.Transparency = 0.45
    end

    local v117 = math.max(bulletVisualizerLifetime - bulletVisualizerFadeOut, 0)

    task.delay(v117, function()
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
          local v118 = math.clamp(total / bulletVisualizerFadeOut, 0, 1)
          bulletTrail.Transparency = transparency + (1 - transparency) * v118

          if v118 >= 1 then
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

local clipCurrent2 = 0
local v119, connect4

local function f48(p110)
  if not p110 or not p110:IsA("Tool") then
    return
  elseif v119 == p110 then
    return
  else
    v119 = p110

    if connect4 then
      connect4:Disconnect()
    end

    clipCurrent2 = p110:GetAttribute("ClipCurrent") or 0

    connect4 = p110:GetAttributeChangedSignal("ClipCurrent"):Connect(function()
      local clipCurrent3 = p110:GetAttribute("ClipCurrent") or 0

      if Config.BulletVisualizerEnabled and clipCurrent3 < clipCurrent2 then
        f47()
      end

      clipCurrent2 = clipCurrent3
    end)

    return
  end
end

local connect5

function BulletVisualizer_Enable(p111)
  Config.BulletVisualizerEnabled = p111

  if p111 then
    if connect5 then
      connect5:Disconnect()
    end

    local character44 = localPlayer.Character

    if character44 then
      f48(character44:FindFirstChildOfClass("Tool"))

      connect5 = character44.ChildAdded:Connect(function(child11)
        if child11:IsA("Tool") then
          task.wait(0.1)
          f48(child11)
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

    v119 = nil
  end
end

function BulletVisualizer_Cleanup()
  Config.BulletVisualizerEnabled = false

  for index42, value51 in ipairs(BulletVisualizerState.activeTrails) do
    local v120 = value51

    pcall(function()
      if v120 and v120.Parent then
        v120:Destroy()
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

localPlayer.CharacterAdded:Connect(function(character45)
  if not Config.BulletVisualizerEnabled then
    return
  else
    character45:WaitForChild("HumanoidRootPart", 10)
    task.wait(0.5)

    if connect5 then
      connect5:Disconnect()
      connect5 = nil
    end

    if connect4 then
      connect4:Disconnect()
      connect4 = nil
    end

    v119 = nil
    local character46 = localPlayer.Character

    if character46 then
      f48(character46:FindFirstChildOfClass("Tool"))

      connect5 = character46.ChildAdded:Connect(function(child12)
        if child12:IsA("Tool") then
          task.wait(0.1)
          f48(child12)
        end
      end)
    end

    return
  end
end)

local function f49(p112, p113)
  if not p112 or not p112:IsA("ClickDetector") then
    pcall(function()
      if WindUI then
        WindUI:Notify({
          Title = "Free Tools",
          Content = p113 .. " detector not found",
          Duration = 3,
        })
      end
    end)

    return
  end

  pcall(function() fireclickdetector(p112) end)

  pcall(function()
    if WindUI then
      WindUI:Notify({ Title = "Free Tools", Content = "Fired " .. p113, Duration = 2 })
    end
  end)
end

BypassState = { Movement = false }
MovementBypassHooks = {}

function applyMovementBypass(p114)
  BypassState.Movement = p114
  local humanoid26

  if p114 then
    local character47 = localPlayer.Character

    if character47 then
      humanoid26 = character47:FindFirstChildOfClass("Humanoid")

      if humanoid26 and getrawmetatable and newcclosure and setreadonly then
        pcall(function()
          local v121 = getrawmetatable(humanoid26)
          local v122 = v121 and not MovementBypassHooks.Humanoid
          local newindex

          if v122 then
            newindex = v121.__newindex
            setreadonly(v121, false)

            v121.__newindex = newcclosure(function(p115, p116, p117)
              local v123 = p117

              if p116 == "WalkSpeed" or p116 == "JumpPower" then
                if typeof(v123) == "number" then
                  if p116 == "WalkSpeed" and v123 > 100 then
                    v123 = 100
                  end

                  if p116 == "JumpPower" and v123 > 200 then
                    v123 = 200
                  end
                end
              end

              return newindex(p115, p116, v123)
            end)

            setreadonly(v121, true)
            MovementBypassHooks.Humanoid = true
          end
        end)
      end
    end
  end
end

function applyAllBypasses()
  if not Config.NetworkBypassEnabled then
    applyMovementBypass(false)
    return
  else
    local v124 = {}

    for index43, value52 in ipairs(Config.ActiveBypasses) do
      v124[value52] = true
    end

    applyMovementBypass(v124["Movement Bypass"] == true)
    return
  end
end

function collectAllDocuments()
  task.spawn(function()
    local character48 = localPlayer.Character
    local currentCamera6, v125

    if not character48 then
      return
    else
      local humanoidRootPart23 = character48:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart23 then
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
          local getChildren = documents.GetChildren
          currentCamera6 = workspace.CurrentCamera
          v125 = {}

          for index44, value53 in ipairs(getChildren(documents)) do
            local findFirstChildWhichIsA = value53:FindFirstChildWhichIsA(
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
                table.insert(v125, {
                  pp = findFirstChildWhichIsA,
                  part = parent7,
                  name = value53.Name,
                })
              end
            end
          end

          if #v125 == 0 then
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
                  Content = #v125 .. " document(s) trouvé(s), collecte en cours...",
                  Duration = 3,
                })
              end
            end)

            for index45, value54 in ipairs(v125) do
              value54.pp.HoldDuration = 0
              value54.pp.MaxActivationDistance = 9999
              value54.pp.Enabled = true
            end

            local cframe7 = humanoidRootPart23.CFrame
            local cameraType = currentCamera6.CameraType
            currentCamera6.CameraType = Enum.CameraType.Scriptable

            local function f50(p118, p119)
              currentCamera6.CFrame = CFrame.new(p118, p118 + (p119 - p118).Unit)
            end

            for index46, value55 in ipairs(v125) do
              local v126 = index46
              local v127 = value55

              if not v127.pp or not v127.pp.Parent then
              else
                local position5 = v127.part.Position
                local vector3 = Vector3.new(0, 0, 3)
                humanoidRootPart23.CFrame = CFrame.new(position5 + vector3, position5)
                task.wait(0.05)
                f50(humanoidRootPart23.CFrame.Position + Vector3.new(0, 1.5, 0), position5)
                task.wait(0.1)
                pcall(function() fireproximityprompt(v127.pp) end)
                task.wait(0.35)

                pcall(function()
                  if WindUI then
                    WindUI:Notify({
                      Title = "Doc [" .. v126 .. "/" .. #v125 .. "]",
                      Content = "Picked Up : " .. v127.name,
                      Duration = 1,
                    })
                  end
                end)
              end
            end

            currentCamera6.CameraType = cameraType
            humanoidRootPart23.CFrame = cframe7
            return
          end
        end
      end
    end
  end)
end

function completeManhattanQuests()
  local userId = localPlayer.UserId
  local v128 = false
  local v129 = false

  local v130, v131 = pcall(function()
    return badgeService:UserHasBadgeAsync(userId, 2147991835)
  end)

  if v130 and v131 then
    v128 = true
  end

  local v132, v133 = pcall(function()
    return badgeService:UserHasBadgeAsync(userId, 282806616820550)
  end)

  if v132 and v133 then
    v129 = true
  end

  if v129 then
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

  if not v128 then
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
        local character49 = localPlayer.Character

        if not character49 then
          return
        else
          local humanoidRootPart24 = character49:FindFirstChild("HumanoidRootPart")

          if not humanoidRootPart24 then
            return
          else
            local cframe8 = humanoidRootPart24.CFrame
            local getChildren2 = activeItems:GetChildren()

            if #getChildren2 == 0 then
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

            for index47, value56 in ipairs(getChildren2) do
              if value56:IsA("BasePart") or value56:IsA("Model") then
                local position6 = value56:GetPivot().Position
                humanoidRootPart24.CFrame = CFrame.new(position6 + Vector3.new(0, 2, 0))
                task.wait(0.3)
                currentCamera7.CFrame = CFrame.new(currentCamera7.CFrame.Position, position6)

                humanoidRootPart24.CFrame = CFrame.new(humanoidRootPart24.Position, Vector3.new(
                  position6.X, humanoidRootPart24.Position.Y, position6.Z
                ))

                task.wait(0.2)
                virtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                task.wait(3)
                virtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                task.wait(1)
              end
            end

            humanoidRootPart24.CFrame = cframe8

            pcall(function()
              if WindUI then
                WindUI:Notify({
                  Title = "Manhattan Quest",
                  Content = "Items collected!",
                  Duration = 3,
                })
              end
            end)

            return
          end
        end
      end
    end
  end)
end

function getUnderequippedBadge()
  local character50 = localPlayer.Character
  local cframe9, vector4, vector5, walkSpeed, connect6

  if not character50 then
    return
  else
    local humanoidRootPart25 = character50:FindFirstChild("HumanoidRootPart")
    local v134 = not humanoidRootPart25
    local humanoid27 = character50:FindFirstChildOfClass("Humanoid")

    if v134 or not humanoid27 then
      return
    end

    cframe9 = humanoidRootPart25.CFrame
    vector4 = Vector3.new(241, -31, -1172)
    vector5 = Vector3.new(267, -31, -1172)
    walkSpeed = humanoid27.WalkSpeed
    humanoidRootPart25.CFrame = CFrame.lookAt(vector4, vector5)
    humanoid27.WalkSpeed = 9
    task.wait(0.1)

    connect6 = nil

    connect6 = runService.Heartbeat:Connect(function()
      if not SentinelActive then
        if connect6 then
          connect6:Disconnect()
        end

        return
      else
        local character51 = localPlayer.Character

        if not character51 then
          if connect6 then
            connect6:Disconnect()
          end

          return
        else
          local humanoidRootPart26 = character51:FindFirstChild("HumanoidRootPart")
          local v135 = not humanoidRootPart26
          local humanoid28 = character51:FindFirstChildOfClass("Humanoid")

          if v135 or not humanoid28 then
            if connect6 then
              connect6:Disconnect()
            end

            return
          else
            local position7 = humanoidRootPart26.Position

            if (Vector3.new(vector5.X, position7.Y, vector5.Z) - position7).Magnitude <= 1 then
              humanoid28.WalkSpeed = walkSpeed
              connect6:Disconnect()
              task.wait(0.5)
              local character52 = localPlayer.Character

              if character52 and character52:FindFirstChild("HumanoidRootPart") then
                character52:PivotTo(cframe9)
              end

              return
            else
              local v136 = (vector5 - position7) * Vector3.new(1, 0, 1)

              if v136.Magnitude > 0 then
                local v137 = v136.Unit * 0.15

                humanoidRootPart26.CFrame = CFrame.lookAt(position7 + v137, position7 + v137
                  + (vector5 - vector4).Unit)
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

ElsherHelperActive = false
ElsherLoopThread = nil

function startElsherLoop()
  if ElsherHelperActive then
    return
  end

  ElsherHelperActive = true

  pcall(function()
    if WindUI then
      WindUI:Notify({
        Title = "Elsher Quest",
        Content = "Elsher auto quest is not implemented yet.",
        Duration = 4,
      })
    end
  end)

  ElsherLoopThread = task.spawn(function()
    while ElsherHelperActive and SentinelActive do
      task.wait(5)
    end
  end)
end

function stopElsherLoop()
  ElsherHelperActive = false

  if ElsherLoopThread then
    task.cancel(ElsherLoopThread)
    ElsherLoopThread = nil
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

    local character53 = localPlayer.Character

    if character53 then
      for key13, value57 in pairs(character53:GetDescendants()) do
        if value57:IsA("BasePart") then
          value57.CanCollide = true
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

  local character54 = localPlayer.Character
  local humanoid29 = character54 and character54:FindFirstChildOfClass("Humanoid")

  if humanoid29 then
    humanoid29.WalkSpeed = 9
    humanoid29.JumpPower = 50
  end

  if Config.FakeDeath then
    Config.FakeDeath = false
  end

  if Config.FakeInjured then
    Config.FakeInjured = false
  end

  for index48, value58 in ipairs({
    "HighlightPlayer", "HighlightFriends", "HighlightMobs", "HighlightBosses", "BoxPlayers",
    "BoxFriends", "BoxMobs", "BoxBosses", "ShowNamePlayers", "ShowNameFriends", "ShowNameMobs",
    "ShowNameBosses", "ShowHealthPlayers", "ShowHealthFriends", "ShowHealthMobs",
    "ShowHealthBosses", "ShowDistancePlayers", "ShowDistanceFriends", "ShowDistanceMobs",
    "ShowDistanceBosses",
  }) do
    Config[value58] = false
  end

  pcall(function()
    for key14, value59 in pairs(players:GetPlayers()) do
      if value59 ~= localPlayer and value59.Character then
        local sentinelHL2 = value59.Character:FindFirstChild("SentinelHL")

        if sentinelHL2 then
          sentinelHL2:Destroy()
        end
      end
    end

    for index49, value60 in ipairs(workspace:GetDescendants()) do
      local sentinelMobHL2 = value60:FindFirstChild("SentinelMobHL")

      if sentinelMobHL2 then
        sentinelMobHL2:Destroy()
      end

      local sentinelInfoBBG3 = value60:FindFirstChild("SentinelInfoBBG")

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

  Config.ThirdPersonShiftlockEnabled = false
  Config.AnimatorEnabled = false

  animatorLastState = nil

  if activeAnimTrack then
    pcall(function() activeAnimTrack:Stop() end)
    activeAnimTrack = nil
  end

  if HitboxEnabled then
    HitboxEnabled = false
  end

  Config.HighlightLandmines = false
  Config.HighlightGenerators = false

  for key15, value61 in pairs(LandmineHighlights) do
    local v138 = value61
    pcall(function() v138:Destroy() end)
  end

  LandmineHighlights = {}

  for key16, value62 in pairs(GeneratorHighlights) do
    local v139 = value62
    pcall(function() v139:Destroy() end)
  end

  GeneratorHighlights = {}

  Config.AntiAnchorEnabled = false
  Config.StaggerEnabled = true
  Config.StaggerImmune = false

  if character54 then
    local clientScripts4 = character54:FindFirstChild("ClientScripts")

    local stagger4 = clientScripts4
    stagger4 = clientScripts4 and clientScripts4:FindFirstChild("Stagger")

    if stagger4 then
      stagger4.Disabled = false
    end

    pcall(function() character54:SetAttribute("StaggerImmune", false) end)
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
    pcall(function() f13(false) end)
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

    pcall(f8)
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

  for index50, value63 in ipairs(AntiRiserDodgeConnections) do
    local v140 = value63
    pcall(function() v140:Disconnect() end)
  end

  AntiRiserDodgeConnections = {}
  AntiRiserDodgeHooked = {}
  AntiRiserAddedConn = nil
end

function FullScriptCleanup()
  SentinelActive = false
  pcall(f8)

  if InfiniteNVConnection then
    pcall(function() InfiniteNVConnection:Disconnect() end)
  end

  if NVForcerConnection then
    pcall(function() NVForcerConnection:Disconnect() end)
  end

  if connect then
    pcall(function() connect:Disconnect() end)
  end

  if AutoReloadToolConn then
    pcall(function() AutoReloadToolConn:Disconnect() end)
  end

  if AutoReloadCharConn then
    pcall(function() AutoReloadCharConn:Disconnect() end)
  end

  if AutoReloadCharacterConn then
    pcall(function() AutoReloadCharacterConn:Disconnect() end)
  end

  if connect2 then
    pcall(function() connect2:Disconnect() end)
  end

  if AutoShieldRemovalConnection then
    pcall(function() AutoShieldRemovalConnection:Disconnect() end)
  end

  if AutoRemoveAxeConnection then
    pcall(function() AutoRemoveAxeConnection:Disconnect() end)
  end

  if InstantProximityConnection then
    pcall(function() InstantProximityConnection:Disconnect() end)
  end

  if AutoCompletePromptConnection then
    pcall(function() AutoCompletePromptConnection:Disconnect() end)
  end

  if IgnoreLandmineConnection then
    pcall(function() IgnoreLandmineConnection:Disconnect() end)
  end

  if HeadAccessoryConnection then
    pcall(function() HeadAccessoryConnection:Disconnect() end)
  end

  if CharacterAccessoryConnection then
    pcall(function() CharacterAccessoryConnection:Disconnect() end)
  end

  if XrayLoop then
    pcall(function() XrayLoop:Disconnect() end)
  end

  if v77 then
    pcall(function() task.cancel(v77) end)
  end

  if noclipConnection then
    pcall(function() task.cancel(noclipConnection) end)
  end

  if ElsherLoopThread then
    pcall(function() task.cancel(ElsherLoopThread) end)
  end

  if InfiniteStaminaThread then
    pcall(function() task.cancel(InfiniteStaminaThread) end)
    InfiniteStaminaThread = nil
  end

  if InstantShotgunConnection then
    pcall(function() InstantShotgunConnection:Disconnect() end)
  end

  if connect4 then
    pcall(function() connect4:Disconnect() end)
  end

  if connect5 then
    pcall(function() connect5:Disconnect() end)
  end

  if AutoBringAxeConn then
    pcall(function() AutoBringAxeConn:Disconnect() end)
  end

  if AutoBringHammerConn then
    pcall(function() AutoBringHammerConn:Disconnect() end)
  end

  for index51, value64 in ipairs(AntiRiserDodgeConnections) do
    local v141 = value64
    pcall(function() v141:Disconnect() end)
  end

  function v9134()
    for key17, value65 in pairs(v63) do
    end

    table.clear(v63)
  end

  AntiRiserDodgeConnections = {}

  pcall(function()
    for key18, value66 in pairs(v65) do
      f20(key18)
    end

    table.clear(v65)
  end)

  pcall(function()
    for key19, value67 in pairs(players:GetPlayers()) do
      if value67.Character then
        local sentinelHL3 = value67.Character:FindFirstChild("SentinelHL")

        if sentinelHL3 then
          sentinelHL3:Destroy()
        end
      end
    end

    for index52, value68 in ipairs(workspace:GetDescendants()) do
      local sentinelMobHL3 = value68:FindFirstChild("SentinelMobHL")

      if sentinelMobHL3 then
        sentinelMobHL3:Destroy()
      end

      local sentinelInfoBBG4 = value68:FindFirstChild("SentinelInfoBBG")

      if sentinelInfoBBG4 then
        sentinelInfoBBG4:Destroy()
      end

      local sentinelLandmineHL = value68:FindFirstChild("SentinelLandmineHL")

      if sentinelLandmineHL then
        sentinelLandmineHL:Destroy()
      end

      local sentinelGeneratorHL = value68:FindFirstChild("SentinelGeneratorHL")

      if sentinelGeneratorHL then
        sentinelGeneratorHL:Destroy()
      end
    end
  end)

  pcall(function()
    lighting.Ambient = OrigAmbient
    lighting.OutdoorAmbient = OrigOutdoorAmbient
    lighting.Brightness = OrigBrightness
    lighting.FogEnd = OrigFogEnd
    lighting.FogStart = OrigFogStart
    lighting.GlobalShadows = OrigGlobalShadows
  end)

  pcall(function()
    local infectionRedTint4 = lighting:FindFirstChild("InfectionRedTint")

    if infectionRedTint4 then
      infectionRedTint4:Destroy()
    end

    local nvgEffect2 = lighting:FindFirstChild("__NVG_Effect")

    if nvgEffect2 then
      nvgEffect2:Destroy()
    end

    local nvgBloom2 = lighting:FindFirstChild("__NVG_Bloom")

    if nvgBloom2 then
      nvgBloom2:Destroy()
    end
  end)

  pcall(function()
    if mainWindow then
      mainWindow:Destroy()
    end
  end)

  pcall(function()
    if v86 and v86.fovCircle then
      v86.fovCircle:Remove()
    end
  end)
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

local f51, f52, notify, sentinelExaminationWindow, sentinelStatusParagraph, v142, f53

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
    New = function(p120, p121, p122)
      return {
        Name = p121 or "Copy",
        Desc = p122 or "Click to copy.",
        Verify = function(p123)
          if not p123 or p123 == "" then
            return false, "Please enter a key."
          end

          if tostring(p123) == "Sentinel.Examination.Ux89v" then
            return true, "Key valid! Welcome to Sentinel."
          end

          return false, "Invalid key. Check your key and try again."
        end,
        Copy = function()
          if setclipboard then
            pcall(setclipboard, p120)
          end

          return p120
        end,
      }
    end,
  }

  pcall(function()
    if listfiles and isfolder and delfile then
      if isfolder("Sentinel") then
        for index53, value69 in ipairs(listfiles("Sentinel")) do
          if type(value69) == "string" and value69:match("%.key$") then
            delfile(value69)
          end
        end
      end
    end

    if WindUI and WindUI.Flags then
      WindUI.Flags.KeySaved = nil
      WindUI.Flags.KeySystem = nil
    end
  end)

  sentinelExaminationWindow = nil
  sentinelStatusParagraph = nil

  function BuildUI()
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
      Config = sentinelExaminationWindow:Tab({ Title = "Configs", Icon = "save" }),
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

        if value70 then
          pcall(function()
            if WindUI then
              WindUI:Notify({
                Title = "Network Bypass",
                Content = "Bypass applied.",
                Duration = 3,
              })
            end
          end)
        else
          pcall(function()
            if WindUI then
              WindUI:Notify({
                Title = "Network Bypass",
                Content = "Bypass disabled.",
                Duration = 3,
              })
            end
          end)
        end
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
        local character55 = localPlayer.Character
        local humanoid30 = character55 and character55:FindFirstChildOfClass("Humanoid")

        if humanoid30 then
          humanoid30.Health = 0
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
        changeTeam(value81)
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
          CurrentFlyType = "Seat [UNDETECTED]"
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
      Callback = function(value89) Config.FlyType = "Seat [UNDETECTED]" end,
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
                local character56 = localPlayer.Character

                if character56 then
                  local torso = character56:FindFirstChild("Torso")
                    or character56:FindFirstChild("UpperTorso")
                    or character56:FindFirstChild("LowerTorso")

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

          local character57 = localPlayer.Character

          if character57 then
            local torso2 = character57:FindFirstChild("Torso")
              or character57:FindFirstChild("UpperTorso")
              or character57:FindFirstChild("LowerTorso")

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
        local character58 = localPlayer.Character

        if character58 then
          local clientScripts5 = character58:FindFirstChild("ClientScripts")

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

    local freeToolsSection = combat:Section({
      Title = "Free Tools",
      Opened = true,
      Icon = "toolbox",
    })

    local button3

    button3 = freeToolsSection:Button({
      Title = "Get Free Guitare",
      Locked = true,
      LockedTitle = "Working On...",
      Callback = function()
        button3:Highlight()
        local brokenGuitarChallenge = workspace:FindFirstChild("BrokenGuitarChallenge")

        f49(
          brokenGuitarChallenge and brokenGuitarChallenge:FindFirstChild("ClickDetector"),
          "Guitar"
        )
      end,
    })

    button3:Lock()

    local button4

    button4 = freeToolsSection:Button({
      Title = "Get FlashLight",
      Callback = function()
        button4:Highlight()
        local map2 = workspace:FindFirstChild("Map")
        local lobbySpawn2 = map2 and map2:FindFirstChild("LobbySpawn")
        local handTorch = lobbySpawn2 and lobbySpawn2:FindFirstChild("HandTorch")
        f49(handTorch and handTorch:FindFirstChild("ClickDetector"), "Flashlight")
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

    local button5

    button5 = section:Button({
      Title = "Delete All Shields",
      Callback = function()
        button5:Highlight()

        for index54, value96 in ipairs(workspace:GetDescendants()) do
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
          for index55, value98 in ipairs(workspace:GetDescendants()) do
            if value98.Name == "Shield" then
              value98:Destroy()
            end
          end

          if not AutoShieldRemovalConnection then
            AutoShieldRemovalConnection = workspace.DescendantAdded:Connect(function(descendant7)
              if AutoShieldRemovalActive then
                task.wait(0.1)

                if descendant7.Name == "Shield" then
                  descendant7:Destroy()
                end

                for index56, value99 in ipairs(descendant7:GetDescendants()) do
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

    local button6

    button6 = section:Button({
      Title = "Delete Slasher Axe",
      Callback = function()
        button6:Highlight()
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
          deleteSlasherAxe()
          setupAutoRemoveAxe()
        elseif AutoRemoveAxeConnection then
          AutoRemoveAxeConnection:Disconnect()
          AutoRemoveAxeConnection = nil
        end
      end,
    })

    section:Divider()

    section:Toggle({
      Title = "Anti Riser Dodge",
      Desc = "Blocks the Riser dodge animation and replaces it with a static one.",
      Default = false,
      Flag = "AntiRiserDodgeEnabled",
      Callback = function(value101) AntiRiserDodge_Enable(value101) end,
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
      Flag = "SilentAimEnabled",
      Callback = function(value102) SilentAim_Enable(value102) end,
    })

    silentAimSection:Toggle({
      Title = "Enable Wall Check",
      Default = true,
      Flag = "SilentAimWallCheck",
      Callback = function(value103) Config.SilentAimWallCheck = value103 end,
    })

    silentAimSection:Divider()

    silentAimSection:Dropdown({
      Title = "Target Part",
      Values = { "Head", "Torso" },
      Value = "Head",
      Flag = "SilentAimTargetPart",
      Callback = function(value104) Config.SilentAimTargetPart = value104 end,
    })

    silentAimSection:Divider()

    silentAimSection:Toggle({
      Title = "Show FOV Circle",
      Default = false,
      Flag = "SilentAimShowFOV",
      Callback = function(value105)
        Config.SilentAimShowFOV = value105
        SilentAim_UpdateFOVVisual()
      end,
    })

    silentAimSection:Slider({
      Title = "FOV Circle Radius",
      Value = { Min = 50, Max = 500, Default = Config.SilentAimFOVRadius },
      Rounding = 0,
      Enabled = true,
      Flag = "SilentAimFOVRadius",
      Callback = function(value106)
        Config.SilentAimFOVRadius = value106
        SilentAim_UpdateFOVVisual()
      end,
    })

    silentAimSection:Dropdown({
      Title = "FOV Circle Mode",
      Values = { "Center", "Mouse" },
      Value = "Mouse",
      Flag = "SilentAimFOVMode",
      Callback = function(value107) Config.SilentAimFOVMode = value107 end,
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
      Callback = f35,
    })

    reloadSection:Toggle({
      Title = "Fast Reload",
      Default = false,
      Flag = "FastReload",
      Callback = function(value108) toggleFastReload(value108) end,
    })

    reloadSection:Divider()

    reloadSection:Toggle({
      Title = "Auto Reload",
      Default = false,
      Flag = "AutoReload",
      Callback = function(value109) toggleAutoReload(value109) end,
    })

    reloadSection:Divider()

    reloadSection:Toggle({
      Title = "Instant Shotgun Reload",
      Desc = "Makes the shotgun reload animation instant.",
      Default = false,
      Flag = "InstantShotgunReload",
      Callback = function(value110) setupInstantShotgunReload(value110) end,
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
      Callback = function(value111) Config.BulletVisualizerColorMissed = value111 end,
    })

    bulletVisualizerSection:Colorpicker({
      Title = "Is Succes",
      Default = Config.BulletVisualizerColorSuccess,
      Flag = "BulletVisualizerColorSuccess",
      Callback = function(value112) Config.BulletVisualizerColorSuccess = value112 end,
    })

    bulletVisualizerSection:Colorpicker({
      Title = "Loading",
      Default = Config.BulletVisualizerColorLoading,
      Flag = "BulletVisualizerColorLoading",
      Callback = function(value113) Config.BulletVisualizerColorLoading = value113 end,
    })

    bulletVisualizerSection:Divider()

    bulletVisualizerSection:Slider({
      Title = "Visualizer Lifetime (s)",
      Value = { Min = 1, Max = 5, Default = 3 },
      Rounding = 1,
      Enabled = true,
      Flag = "BulletVisualizerLifetime",
      Callback = function(value114) Config.BulletVisualizerLifetime = value114 end,
    })

    bulletVisualizerSection:Slider({
      Title = "Visualizer Fade-out Time (s)",
      Value = { Min = 0.1, Max = 1, Default = 0.8 },
      Rounding = 2,
      Enabled = true,
      Flag = "BulletVisualizerFadeOut",
      Callback = function(value115) Config.BulletVisualizerFadeOut = value115 end,
    })

    bulletVisualizerSection:Divider()

    bulletVisualizerSection:Toggle({
      Title = "Enable Bullet Visualizer",
      Default = false,
      Flag = "BulletVisualizerEnabled",
      Callback = function(value116) BulletVisualizer_Enable(value116) end,
    })

    local hitboxSection = gunMods:Section({ Title = "Hitbox", Opened = true, Icon = "box" })

    hitboxSection:Slider({
      Title = "Box Size",
      Value = { Min = 1, Max = 5, Default = 4 },
      Rounding = 0,
      Enabled = true,
      Flag = "BoxSize",
      Callback = function(value117)
        Config.BoxSize = value117

        if HitboxEnabled then
          UpdateAllHitboxes(true)
        end
      end,
    })

    hitboxSection:Toggle({
      Title = "Enable Hitbox Expander",
      Default = false,
      Flag = "HitboxEnabled",
      Callback = function(value118)
        HitboxEnabled = value118
        UpdateAllHitboxes(value118)
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
      Flag = "AntiCamShake",
      Callback = function(value119)
        Config.AntiCamShake = value119

        if value119 then
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
      Callback = function(value120)
        Config.SilencerEnabled = value120
        updateSilencers(value120)
      end,
    })

    randomModsSection:Divider()

    randomModsSection:Toggle({
      Title = "Infinite Ammo",
      Desc = "Only work for Night Stalker Quest.",
      Default = false,
      Flag = "NightStalkerInfAmmo",
      Callback = function(value121) toggleNightStalkerInfAmmo(value121) end,
    })

    local infected = Tabs.Infected

    local playerInfectionSection = infected:Section({
      Title = "Player Infection",
      Opened = true,
      Icon = "biohazard",
    })

    local button7

    button7 = playerInfectionSection:Button({
      Title = "Fake Controllable Infected",
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

        startInfectionSequence("Controllable")
      end,
    })

    local button8

    button8 = playerInfectionSection:Button({
      Title = "Fake Non-Controllable Infected",
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

    local button9

    button9 = playerInfectionSection:Button({
      Title = "Get Infected [BETA]",
      Callback = function()
        button9:Highlight()

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
          local character59 = localPlayer.Character

          if not character59 then
            return
          else
            local humanoid31 = character59:FindFirstChildOfClass("Humanoid")

            if not humanoid31 then
              return
            elseif humanoid31.Health < 100 then
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
              local humanoidRootPart27 = character59:FindFirstChild("HumanoidRootPart")

              if not humanoidRootPart27 then
                return
              else
                teleportTo((Vector3.new(-216, 54, -1135)))
                task.wait(3)
                character59:PivotTo(humanoidRootPart27.CFrame)
                task.wait(0.5)
                local health3 = humanoid31.Health

                if health3 < 10 then
                  pcall(function()
                    if WindUI then
                      WindUI:Notify({
                        Title = "Infection",
                        Content = "Infected :D",
                        Duration = 3,
                      })
                    end
                  end)
                elseif health3 == 10 then
                  pcall(function()
                    if WindUI then
                      WindUI:Notify({
                        Title = "Infection",
                        Content = "Might be infected :/",
                        Duration = 3,
                      })
                    end
                  end)
                else
                  pcall(function()
                    if WindUI then
                      WindUI:Notify({ Title = "Infection", Content = "Failed :(", Duration = 3 })
                    end
                  end)
                end

                return
              end
            end
          end
        end
      end,
    })

    infected:Section({ Title = "CI Fight Mods", Opened = true, Icon = "biohazard" }):Toggle({
      Title = "Auto Complete QTE",
      Default = false,
      Flag = "AutoQTEEnabled",
      Callback = function(value122)
        Config.AutoQTEEnabled = value122
        f13(value122)
      end,
    })

    local esp = Tabs.ESP

    local section2 = esp:Section({ Title = "Global ESP Settings", Opened = true, Icon = "globe" })

    section2:Slider({
      Title = "Outline Transparency",
      Value = { Min = 0, Max = 100, Default = Config.HLOutlineTrans },
      Rounding = 0,
      Enabled = true,
      Flag = "HLOutlineTrans",
      Callback = function(value123) Config.HLOutlineTrans = value123 end,
    })

    section2:Slider({
      Title = "Highlight Transparency",
      Value = { Min = 0, Max = 100, Default = Config.HLFillTrans },
      Rounding = 0,
      Enabled = true,
      Flag = "HLFillTrans",
      Callback = function(value124) Config.HLFillTrans = value124 end,
    })

    section2:Slider({
      Title = "Max Distance",
      Value = { Min = 50, Max = 2000, Default = Config.MaxDistance },
      Rounding = 0,
      Enabled = true,
      Flag = "MaxDistance",
      Callback = function(value125) Config.MaxDistance = value125 end,
    })

    section2:Divider()

    section2:Slider({
      Title = "Box Thickness",
      Value = { Min = 1, Max = 10, Default = Config.BoxThickness },
      Rounding = 0,
      Enabled = true,
      Flag = "BoxThickness",
      Callback = function(value126) Config.BoxThickness = value126 end,
    })

    section2:Toggle({
      Title = "Auto Thickness (distance based)",
      Default = Config.BoxAutoThickness,
      Flag = "BoxAutoThickness",
      Callback = function(value127) Config.BoxAutoThickness = value127 end,
    })

    local section3 = esp:Section({
      Title = "Players ESP Settings",
      Opened = true,
      Icon = "user-round-plus",
    })

    section3:Colorpicker({
      Title = "Players Color",
      Default = Config.ColorPlayer,
      Flag = "ColorPlayer",
      Callback = function(value128) Config.ColorPlayer = value128 end,
    })

    section3:Divider()

    section3:Toggle({
      Title = "Highlight Players",
      Default = false,
      Flag = "HighlightPlayer",
      Callback = function(value129) Config.HighlightPlayer = value129 end,
    })

    section3:Toggle({
      Title = "Box Players",
      Default = false,
      Flag = "BoxPlayers",
      Callback = function(value130) Config.BoxPlayers = value130 end,
    })

    section3:Divider()

    section3:Toggle({
      Title = "Show Players Name",
      Default = false,
      Flag = "ShowNamePlayers",
      Callback = function(value131) Config.ShowNamePlayers = value131 end,
    })

    section3:Toggle({
      Title = "Show Players Health",
      Default = false,
      Flag = "ShowHealthPlayers",
      Callback = function(value132) Config.ShowHealthPlayers = value132 end,
    })

    section3:Toggle({
      Title = "Show Players Distance",
      Default = false,
      Flag = "ShowDistancePlayers",
      Callback = function(value133) Config.ShowDistancePlayers = value133 end,
    })

    local section4 = esp:Section({
      Title = "Friends ESP Settings",
      Opened = true,
      Icon = "user-round-check",
    })

    section4:Colorpicker({
      Title = "Friends Color",
      Default = Config.ColorFriends,
      Flag = "ColorFriends",
      Callback = function(value134) Config.ColorFriends = value134 end,
    })

    section4:Divider()

    section4:Toggle({
      Title = "Highlight Friends",
      Default = false,
      Flag = "HighlightFriends",
      Callback = function(value135) Config.HighlightFriends = value135 end,
    })

    section4:Toggle({
      Title = "Box Friends",
      Default = false,
      Flag = "BoxFriends",
      Callback = function(value136) Config.BoxFriends = value136 end,
    })

    section4:Divider()

    section4:Toggle({
      Title = "Show Friends Name",
      Default = false,
      Flag = "ShowNameFriends",
      Callback = function(value137) Config.ShowNameFriends = value137 end,
    })

    section4:Toggle({
      Title = "Show Friends Health",
      Default = false,
      Flag = "ShowHealthFriends",
      Callback = function(value138) Config.ShowHealthFriends = value138 end,
    })

    section4:Toggle({
      Title = "Show Friends Distance",
      Default = false,
      Flag = "ShowDistanceFriends",
      Callback = function(value139) Config.ShowDistanceFriends = value139 end,
    })

    local section5 = esp:Section({ Title = "Mobs ESP Settings", Opened = true, Icon = "syringe" })

    section5:Colorpicker({
      Title = "Mobs Color",
      Default = Config.ColorMobs,
      Flag = "ColorMobs",
      Callback = function(value140) Config.ColorMobs = value140 end,
    })

    section5:Divider()

    section5:Toggle({
      Title = "Highlight Mobs",
      Default = false,
      Flag = "HighlightMobs",
      Callback = function(value141) Config.HighlightMobs = value141 end,
    })

    section5:Toggle({
      Title = "Box Mobs",
      Default = false,
      Flag = "BoxMobs",
      Callback = function(value142) Config.BoxMobs = value142 end,
    })

    section5:Divider()

    section5:Toggle({
      Title = "Show Mobs Name",
      Default = false,
      Flag = "ShowNameMobs",
      Callback = function(value143) Config.ShowNameMobs = value143 end,
    })

    section5:Toggle({
      Title = "Show Mobs Health",
      Default = false,
      Flag = "ShowHealthMobs",
      Callback = function(value144) Config.ShowHealthMobs = value144 end,
    })

    section5:Toggle({
      Title = "Show Mobs Distance",
      Default = false,
      Flag = "ShowDistanceMobs",
      Callback = function(value145) Config.ShowDistanceMobs = value145 end,
    })

    local section6 = esp:Section({ Title = "Boss ESP Settings", Opened = true, Icon = "skull" })

    section6:Colorpicker({
      Title = "Boss Color",
      Default = Config.ColorBosses,
      Flag = "ColorBosses",
      Callback = function(value146) Config.ColorBosses = value146 end,
    })

    section6:Divider()

    section6:Toggle({
      Title = "Highlight Bosses",
      Default = false,
      Flag = "HighlightBosses",
      Callback = function(value147) Config.HighlightBosses = value147 end,
    })

    section6:Toggle({
      Title = "Box Bosses",
      Default = false,
      Flag = "BoxBosses",
      Callback = function(value148) Config.BoxBosses = value148 end,
    })

    section6:Divider()

    section6:Toggle({
      Title = "Show Bosses Name",
      Default = false,
      Flag = "ShowNameBosses",
      Callback = function(value149) Config.ShowNameBosses = value149 end,
    })

    section6:Toggle({
      Title = "Show Bosses Health",
      Default = false,
      Flag = "ShowHealthBosses",
      Callback = function(value150) Config.ShowHealthBosses = value150 end,
    })

    section6:Toggle({
      Title = "Show Bosses Distance",
      Default = false,
      Flag = "ShowDistanceBosses",
      Callback = function(value151) Config.ShowDistanceBosses = value151 end,
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
      Callback = function(value152) Config.UnlockThirdPerson = value152 end,
    })

    cameraSettingsSection:Toggle({
      Title = "Enable Third Person Shiftlock",
      Default = false,
      Flag = "ThirdPersonShiftlockEnabled",
      Callback = function(value153)
        Config.ThirdPersonShiftlockEnabled = value153
        ThirdPersonShiftlock_Enable(value153)

        pcall(function()
          if WindUI then
            WindUI:Notify({
              Title = "Third Person Shiftlock",
              Content = value153 and "Enabled." or "Disabled.",
              Duration = 3,
            })
          end
        end)
      end,
    })

    cameraSettingsSection:Divider()

    cameraSettingsSection:Toggle({
      Title = "Custom FOV",
      Default = false,
      Flag = "CustomFOVEnabled",
      Callback = function(value154) Config.CustomFOVEnabled = value154 end,
    })

    cameraSettingsSection:Slider({
      Title = "Field of View",
      Value = { Min = 1, Max = 120, Default = 70 },
      Rounding = 0,
      Enabled = true,
      Flag = "FOVValue",
      Callback = function(value155) Config.FOVValue = value155 end,
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
      Callback = function(value156)
        Config.FullBright = value156

        if value156 then
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
      Callback = function(value157)
        Config.NoFog = value157

        if value157 then
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
      Flag = "XrayEnabled",
      Callback = function(value158)
        XrayEnabled = value158
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
      Callback = function(value159)
        XrayDistance = value159

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
      Callback = function(value160)
        XrayTransparency = value160 / 100
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
      Callback = function(value161)
        Config.XrayMaterial = value161

        XrayMaterial = ({
          Plastic = Enum.Material.Plastic,
          Neon = Enum.Material.Neon,
          ForceField = Enum.Material.ForceField,
          Glass = Enum.Material.Glass,
          SmoothPlastic = Enum.Material.SmoothPlastic,
        })[value161] or Enum.Material.ForceField

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
      Callback = function(value162) Config.AutoWipeBlood = value162 end,
    })

    local cleanScreenButton

    cleanScreenButton = screenCustomizationSection:Button({
      Title = "Clean Screen",
      Callback = function()
        cleanScreenButton:Highlight()
        local gui4 = localPlayer.PlayerGui:FindFirstChild("Gui")

        if gui4 then
          for key20, clean2 in pairs(gui4:GetChildren()) do
            if clean2.Name == "blood" then
              clean2.Name = "clean"
              tweenService:Create(clean2, TweenInfo.new(0.2), { ImageTransparency = 1 }):Play()
              debris:AddItem(clean2, 0.5)
            end
          end
        end
      end,
    })

    local section7 = visuals:Section({
      Title = "Night Vision & Gasmask",
      Opened = true,
      Icon = "moon",
    })

    local deleteGasmaskButton

    deleteGasmaskButton = section7:Button({
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

    breakGasmaskButton = section7:Button({
      Title = "Break Gasmask",
      Callback = function()
        breakGasmaskButton:Highlight()
        BreakGasmask()
      end,
    })

    section7:Toggle({
      Title = "Infinite Night Vision",
      Default = false,
      Flag = "InfiniteNightVision",
      Callback = function(value163)
        Config.InfiniteNightVision = value163
        local nvgEffect3, nvgBloom3

        if value163 then
          nvgEffect3 = lighting:FindFirstChild("__NVG_Effect")

          if not nvgEffect3 then
            nvgEffect3 = Instance.new("ColorCorrectionEffect")
            nvgEffect3.Name = "__NVG_Effect"
            nvgEffect3.Brightness = 0.2
            nvgEffect3.Contrast = 0.1
            nvgEffect3.Saturation = -0.2
            nvgEffect3.TintColor = Color3.fromRGB(255, 255, 255)
            nvgEffect3.Parent = lighting
          end

          nvgBloom3 = lighting:FindFirstChild("__NVG_Bloom")

          if not nvgBloom3 then
            nvgBloom3 = Instance.new("BloomEffect")
            nvgBloom3.Name = "__NVG_Bloom"
            nvgBloom3.Intensity = 2
            nvgBloom3.Size = 32
            nvgBloom3.Threshold = 0.4
            nvgBloom3.Parent = lighting
          end

          lighting.GlobalShadows = false
          f9()
          f10()

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

            if nvgEffect3 then
              nvgEffect3.Enabled = true
            end

            if nvgBloom3 then
              nvgBloom3.Enabled = true
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

          local nvgEffect4 = lighting:FindFirstChild("__NVG_Effect")

          if nvgEffect4 then
            nvgEffect4:Destroy()
          end

          local nvgBloom4 = lighting:FindFirstChild("__NVG_Bloom")

          if nvgBloom4 then
            nvgBloom4:Destroy()
          end

          lighting.FogEnd = OrigFogEnd
          lighting.FogStart = OrigFogStart
          lighting.Ambient = OrigAmbient
          lighting.OutdoorAmbient = OrigOutdoorAmbient
          lighting.GlobalShadows = OrigGlobalShadows

          f8()
        end
      end,
    })

    local world = Tabs.World
    local teleportSection = world:Section({ Title = "Teleport", Opened = true, Icon = "globe" })

    for key21, value164 in pairs(teleportPoints) do
      local v143 = {}
      local v144 = {}

      for index57, value165 in ipairs(value164) do
        local v145, v146 = unpack(value165)
        table.insert(v144, v145)
        v143[v145] = v146
      end

      teleportSection:Dropdown({
        Title = key21,
        Values = v144,
        Default = v144[1],
        Flag = "TP_" .. key21,
        Callback = function(value166)
          local v147 = v143[value166]

          if v147 then
            teleportTo(v147)
          end
        end,
      })
    end

    local landMinesSection = world:Section({ Title = "LandMines", Opened = true, Icon = "bolt" })

    landMinesSection:Toggle({
      Title = "Ignor Landmines",
      Default = false,
      Locked = true,
      LockedTitle = "Fixing...",
      Flag = "IgnoreLandmine",
      Callback = function(value167)
        Config.IgnoreLandmine = value167

        if value167 then
          if landmineHitEvent then
            if pcall(function() return getrawmetatable end)
              and pcall(function() return hookmetamethod end) then
              originalLandmineFire = landmineHitEvent.FireServer

              function landmineHitEvent.FireServer()
              end
            end
          end

          for index58, value168 in ipairs(workspace:GetDescendants()) do
            if value168.Name == "Landmine" then
              local mine = value168:FindFirstChild("Mine")

              if mine and mine:IsA("BasePart") then
                mine.CanTouch = false
              end
            end
          end

          if not IgnoreLandmineConnection then
            IgnoreLandmineConnection = workspace.DescendantAdded:Connect(function(descendant8)
              if Config.IgnoreLandmine and descendant8.Name == "Landmine" then
                task.wait(0.1)
                local mine2 = descendant8:FindFirstChild("Mine")

                if mine2 and mine2:IsA("BasePart") then
                  mine2.CanTouch = false
                end
              end
            end)
          end
        else
          if originalLandmineFire and landmineHitEvent then
            landmineHitEvent.FireServer = originalLandmineFire
            originalLandmineFire = nil
          end

          if IgnoreLandmineConnection then
            IgnoreLandmineConnection:Disconnect()
            IgnoreLandmineConnection = nil
          end
        end
      end,
    }):Lock()

    local button10

    button10 = landMinesSection:Button({
      Title = "Delete All Landmines",
      Callback = function()
        button10:Highlight()
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
      Callback = function(value169) Config.ImmuneLookHazard = value169 end,
    })

    local button11

    button11 = radiationsSection:Button({
      Title = "Remove Elephant Foot",
      Callback = function()
        button11:Highlight()
        removeElephantFoot()
      end,
    })

    local terrorUISection = world:Section({ Title = "Terror UI", Opened = true, Icon = "skull" })

    local button12

    button12 = terrorUISection:Button({
      Title = "Disable ChimeraRad",
      Callback = function()
        button12:Highlight()
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
          for index59, value170 in ipairs(currentCamera8:GetChildren()) do
            if value170:IsA("ColorCorrectionEffect")
              and value170.Name == "RadiationColorCorrection" then
              value170:Destroy()
            end
          end
        end
      end,
    })

    local button13

    button13 = terrorUISection:Button({
      Title = "Disable MikhailTerror",
      Callback = function()
        button13:Highlight()
        local playerGui10 = localPlayer:FindFirstChild("PlayerGui")

        if playerGui10 then
          local mikhailTerror = playerGui10:FindFirstChild("MikhailTerror")

          if mikhailTerror then
            mikhailTerror:Destroy()
          end
        end
      end,
    })

    button13:Lock()

    local button14

    button14 = terrorUISection:Button({
      Title = "Disable GilbertRad",
      Callback = function()
        button14:Highlight()
        local playerGui11 = localPlayer:FindFirstChild("PlayerGui")

        if playerGui11 then
          local gilbertRad = playerGui11:FindFirstChild("GilbertRad")

          if gilbertRad then
            local localHandler = gilbertRad:FindFirstChild("LocalHandler")

            if localHandler then
              localHandler:Destroy()
            end
          end

          local glitchedScreen = playerGui11:FindFirstChild("GlitchedScreen")

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

    local button15

    button15 = mapRemoverSection:Button({
      Title = "Remove Arabic dud",
      Callback = function()
        button15:Highlight()
        removeArabicDud()
      end,
    })

    local button16

    button16 = mapRemoverSection:Button({
      Title = "Remove Lobby Music",
      Callback = function()
        button16:Highlight()
        removeLobbyMusic()
      end,
    })

    local button17

    button17 = mapRemoverSection:Button({
      Title = "Delete ALL doors",
      Callback = function()
        button17:Highlight()
        deleteAllDoors()
      end,
    })

    local animations = Tabs.Animations

    local toggleAnimationsSection = animations:Section({
      Title = "Toggle Animations",
      Opened = false,
      Icon = "toggle-right",
    })

    for key22, value171 in pairs(toggleAnims) do
      local v148 = value171

      toggleAnimationsSection:Toggle({
        Title = key22,
        Default = false,
        Flag = "Anim_" .. key22:gsub("[^%w]", "_"),
        Callback = function(value172) playToggleAnim(v148, value172) end,
      })
    end

    local buttonAnimationsSection = animations:Section({
      Title = "Button Animations",
      Opened = false,
      Icon = "play",
    })

    for key23, value173 in pairs(buttonAnims) do
      local v149 = value173
      local button18

      button18 = buttonAnimationsSection:Button({
        Title = key23,
        Callback = function()
          button18:Highlight()
          playButtonAnim(v149)
        end,
      })
    end

    local quests = Tabs.Quests

    local questCompletionSection = quests:Section({
      Title = "Quest Completion",
      Opened = true,
      Icon = "scroll",
    })

    local button19

    button19 = questCompletionSection:Button({
      Title = "Complete Manhattan Radiation Quest",
      Callback = function()
        button19:Highlight()
        completeManhattanQuests()
      end,
    })

    questCompletionSection:Toggle({
      Title = "Elsher Quest Helper",
      Default = false,
      Flag = "ElsherHelper",
      Callback = function(value174)
        if value174 then
          startElsherLoop()
        else
          stopElsherLoop()
        end
      end,
    }):Lock()

    questCompletionSection:Divider()

    local button20

    button20 = questCompletionSection:Button({
      Title = "Collect All Documents",
      Callback = function()
        button20:Highlight()
        collectAllDocuments()
      end,
    })

    local getBadgesSection = quests:Section({
      Title = "Get Badges",
      Opened = true,
      Icon = "award",
    })

    local button21

    button21 = getBadgesSection:Button({
      Title = "Get Underequipped Badge",
      Desc = "This will give you three badges : 'ONE-MANE-ARMY', 'VETERAN-OF-PURGATORY' and 'UNDEREQUIPPED'",
      Callback = function()
        button21:Highlight()
        getUnderequippedBadge()
      end,
    })

    getBadgesSection:Divider()

    local button22

    button22 = getBadgesSection:Button({
      Title = "Get 'Unfortunate' Badge",
      Callback = function()
        button22:Highlight()
        getBadge1()
      end,
    })

    local button23

    button23 = getBadgesSection:Button({
      Title = "Get 'NECROTIC-CONTROL' Badge",
      Callback = function()
        button23:Highlight()
        getBadge2()
      end,
    })

    local button24

    button24 = getBadgesSection:Button({
      Title = "Get 'SECTOR-SWEEP' Badge",
      Callback = function()
        button24:Highlight()
        getBadge3()
      end,
    })

    local utilities = Tabs.Utilities

    local mainStuffSection = utilities:Section({
      Title = "Main Stuff",
      Opened = true,
      Icon = "settings-2",
    })

    local button25

    button25 = mainStuffSection:Button({
      Title = "Go to Restricted Server",
      Callback = function()
        button25:Highlight()
        teleportToCFrame(RestrictedServerCFrame)
      end,
    })

    mainStuffSection:Toggle({
      Title = "Anti-AFK",
      Default = false,
      Flag = "AntiAFKEnabled",
      Callback = function(value175) Config.AntiAFKEnabled = value175 end,
    })

    mainStuffSection:Divider()

    mainStuffSection:Toggle({
      Title = "Auto Remove Death Screen",
      Default = false,
      Flag = "RemoveDeathScreen",
      Callback = function(value176)
        Config.RemoveDeathScreen = value176

        if value176 then
          local playerGui12 = localPlayer:FindFirstChild("PlayerGui")

          if playerGui12 then
            local death = playerGui12:FindFirstChild("Death")

            if death then
              death:Destroy()
            end

            if not removeDeathConnection then
              removeDeathConnection = playerGui12.ChildAdded:Connect(function(child13)
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
      Callback = function(value177)
        chatEverToggled = true
        Config.ChatLoggerEnabled = value177
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
      Flag = "InstantProximityPrompt",
      Callback = function(value178)
        Config.InstantProximityPrompt = value178

        if value178 then
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
      Flag = "AutoCompleteProximityPrompt",
      Callback = function(value179)
        Config.AutoCompleteProximityPrompt = value179

        if value179 then
          autoCompleteProximity()
        elseif AutoCompletePromptConnection then
          AutoCompletePromptConnection:Disconnect()
          AutoCompletePromptConnection = nil
        end
      end,
    })

    local v150 = Tabs.Settings

    local deleteScriptButton

    deleteScriptButton = v150:Section({
      Title = "Danger Zone",
      Opened = true,
      Icon = "triangle-alert",
    }):Button({
      Title = "Delete Script",
      Icon = "trash",
      Color = Color3.fromHex("#EF4F1D"),
      Locked = true,
      LockedTitle = "Working On...",
      Callback = function()
        deleteScriptButton:Highlight()
        task.spawn(function() FullScriptCleanup() end)
      end,
    })

    local interfaceSection = v150:Section({
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
      Callback = function(value180)
        Config.UITheme = value180
        pcall(function() WindUI:SetTheme(value180) end)
      end,
    })

    interfaceSection:Dropdown({
      Title = "Minimize Keybind",
      Values = {
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q",
        "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "F1", "F2", "F3", "F4", "F5", "F6", "F7",
        "F8", "F9", "F10", "F11", "F12", "Zero", "One", "Two", "Three", "Four", "Five", "Six",
        "Seven", "Eight", "Nine",
      },
      Value = "K",
      Flag = "MinimizeKeybind",
      Callback = function(value181)
        Config.MinimizeKeybind = value181

        if sentinelExaminationWindow then
          pcall(function() sentinelExaminationWindow:SetToggleKey(Enum.KeyCode[value181]) end)
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

    local config = Tabs.Config
    local configManager = sentinelExaminationWindow.ConfigManager
    local v151 = ""
    local v152

    local configDropdown = config:Dropdown({
      Title = "Config",
      Desc = "Load / Delete a config",
      Values = configManager:AllConfigs(),
      Value = nil,
      Flag = "ConfigSelection",
      Callback = function(value182) v152 = value182 end,
    })

    config:Space()

    local input8 = config:Input({
      Title = "New Config Name",
      Placeholder = "Enter a name for your new config...",
      Flag = "NewConfigName",
      Callback = function(value183) v151 = value183 or "" end,
    })

    config:Space()

    local group = config:Group({})

    group:Button({
      Title = "Create",
      Icon = "plus",
      Justify = "Center",
      Callback = function()
        local gsub = tostring(v151 or ""):gsub("^%s+", ""):gsub("%s+$", "")

        if gsub == "" then
          WindUI:Notify({
            Title = "Error",
            Content = "donner d'abord un nom à votre config",
            Icon = "x",
            Duration = 4,
          })

          return
        else
          local allConfigs = configManager:AllConfigs()

          if table.find(allConfigs, gsub) then
            WindUI:Notify({
              Title = "Error",
              Content = "Cette config existe déjà, supprimer la et sauvegarder cette config à nouveau",
              Icon = "x",
              Duration = 6,
            })

            return
          end

          sentinelExaminationWindow.CurrentConfig = configManager:CreateConfig(gsub)

          if sentinelExaminationWindow.CurrentConfig:Save() then
            WindUI:Notify({
              Title = "Config Created",
              Content = "Config '" .. gsub .. "' created successfully",
              Icon = "check",
              Duration = 4,
            })

            configDropdown:Refresh((configManager:AllConfigs()))
            pcall(function() configDropdown:Set(gsub) end)
            v152 = gsub
            v151 = ""
            pcall(function() input8:Set("") end)
          else
            WindUI:Notify({
              Title = "Error",
              Content = "Failed to create config '" .. gsub .. "'",
              Icon = "x",
              Duration = 4,
            })
          end

          return
        end
      end,
    })

    group:Space()

    group:Button({
      Title = "Load",
      Icon = "refresh-cw",
      Justify = "Center",
      Callback = function()
        if not v152 or v152 == "" then
          WindUI:Notify({
            Title = "Error",
            Content = "Select a config first",
            Icon = "x",
            Duration = 4,
          })

          return
        end

        sentinelExaminationWindow.CurrentConfig = configManager:CreateConfig(v152)

        if sentinelExaminationWindow.CurrentConfig:Load() then
          WindUI:Notify({
            Title = "Config Loaded",
            Content = "Config '" .. v152 .. "' loaded",
            Icon = "refresh-cw",
            Duration = 4,
          })
        else
          WindUI:Notify({
            Title = "Error",
            Content = "Failed to load config '" .. v152 .. "'",
            Icon = "x",
            Duration = 4,
          })
        end
      end,
    })

    group:Space()

    group:Button({
      Title = "Delete",
      Icon = "trash",
      Justify = "Center",
      Callback = function()
        if not v152 or v152 == "" then
          WindUI:Notify({
            Title = "Error",
            Content = "Select a config first",
            Icon = "x",
            Duration = 4,
          })

          return
        end

        local v153 = false

        if not v153 and configManager.DeleteConfig then
          if pcall(function() configManager:DeleteConfig(v152) end) then
            v153 = true
          end
        end

        if not v153 then
          pcall(function()
            local config2 = configManager:Config(v152)

            if config2 and config2.Delete then
              config2:Delete()
              v153 = true
            end
          end)
        end

        if not v153 and isfile and delfile then
          for index60, value184 in ipairs({
            "Sentinel/configs/" .. v152 .. ".json", "Sentinel/Configs/" .. v152 .. ".json",
            "Sentinel/" .. v152 .. ".json", "Sentinel/configs/" .. v152,
            "Sentinel/Configs/" .. v152,
          }) do
            local v154 = value184

            if isfile(v154) then
              pcall(function() delfile(v154) end)
              v153 = true
              break
            end
          end
        end

        WindUI:Notify({
          Title = "Config Deleted",
          Content = "Config '" .. v152 .. "' deleted",
          Icon = "trash",
          Duration = 4,
        })

        configDropdown:Refresh((configManager:AllConfigs()))
        pcall(function() configDropdown:Set(nil) end)
        v152 = nil
      end,
    })

    task.spawn(function()
      local v155 = 0
      local v156 = 0
      local v157 = tick()

      runService.RenderStepped:Connect(function()
        if not SentinelActive then
          return
        else
          v156 = v156 + 1
          local v158 = tick()

          if v158 - v157 >= 1 then
            v155 = v156
            v156 = 0
            v157 = v158
          end

          return
        end
      end)

      while SentinelActive do
        task.wait(0.5)
        local v159 = tick() - SentinelLastInteraction >= 10 and "AFK" or "Active"
        local getNetworkPing = localPlayer:GetNetworkPing()

        local v160 = "Status: " .. v159 .. "\nFPS: " .. v155 .. "\nPing: "
          .. math.floor(getNetworkPing * 1000) .. " ms"

        if sentinelStatusParagraph then
          if not pcall(function() sentinelStatusParagraph:SetDesc(v160) end) then
            pcall(function()
              sentinelStatusParagraph:Set({
                Title = "Sentinel Status",
                Desc = v160,
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
      Folder = "Sentinel",
      ScrollBarEnabled = true,
      Size = UDim2.fromOffset(250, 150),
      ToggleKey = Enum.KeyCode.K,
      Theme = "Dark",
      HideSearchBar = false,
      Background = "rbxassetid://0",
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
        Title = "v15.00.00",
        Icon = "shield-check",
        Color = Color3.fromHex("#30ff6a"),
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

    if Config.WindowBackground ~= "" then
      pcall(function() sentinelExaminationWindow:SetBackgroundImage(Config.WindowBackground) end)
    end

    BuildUI()
  end

  WindUI:SetTheme("Dark")

  if not sentinelExaminationWindow then
    initializeUI()
  end

  interfaceVisible = true

  if sentinelExaminationWindow then
    sentinelExaminationWindow.Visible = true
  end

  pcall(function()
    if sentinelExaminationWindow then
      sentinelExaminationWindow:GetPropertyChangedSignal("Visible"):Connect(function() end)
    end
  end)

  firstHide = true

  userInputService.InputBegan:Connect(function(input9, p124)
    if p124 then
      return
    end

    if input9.KeyCode == Enum.KeyCode[Config.MinimizeKeybind] and sentinelExaminationWindow then
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
      local playerGui13 = localPlayer:FindFirstChild("PlayerGui")

      if playerGui13 then
        removeDeathConnection = playerGui13.ChildAdded:Connect(function(child14)
          if child14.Name == "Death" and Config.RemoveDeathScreen then
            child14:Destroy()
          end
        end)
      end
    end

    if Config.StaggerImmune then
      local character60 = localPlayer.Character

      if character60 then
        character60:SetAttribute("StaggerImmune", true)
      end
    end

    if Config.NetworkBypassEnabled then
      task.wait(1)
    end
  end)

  task.spawn(function()
    while SentinelActive do
      task.wait(1.5)

      if Config.HighlightLandmines then
        for key24, value185 in pairs(LandmineHighlights) do
          if not key24.Parent then
            value185:Destroy()
            LandmineHighlights[key24] = nil
          end
        end

        for index61, value186 in ipairs(workspace:GetDescendants()) do
          if value186:IsA("Model") and value186.Name == "Landmine"
            and not LandmineHighlights[value186] then
            local sentinelLandmineHL2 = Instance.new("Highlight")
            sentinelLandmineHL2.Name = "SentinelLandmineHL"
            sentinelLandmineHL2.FillColor = Config.ColorLandmines
            sentinelLandmineHL2.FillTransparency = 0.5
            sentinelLandmineHL2.OutlineTransparency = 0.5
            sentinelLandmineHL2.Parent = value186

            LandmineHighlights[value186] = sentinelLandmineHL2
          end
        end
      else
        for key25, value187 in pairs(LandmineHighlights) do
          value187:Destroy()
          LandmineHighlights[key25] = nil
        end
      end
    end
  end)

  task.spawn(function()
    while SentinelActive do
      task.wait(0.5)

      if Config.HighlightGenerators then
        local gameDoors2 = workspace:FindFirstChild("GameDoors")

        if gameDoors2 then
          for index62, value188 in ipairs(gameDoors2:GetChildren()) do
            if value188.Name:match("Generator%d") then
              local generator = value188:FindFirstChild("Generator")

              if generator and generator:IsA("Model") and not GeneratorHighlights[generator] then
                local sentinelGeneratorHL2 = Instance.new("Highlight")
                sentinelGeneratorHL2.Name = "SentinelGeneratorHL"
                sentinelGeneratorHL2.FillColor = Config.ColorGenerators
                sentinelGeneratorHL2.FillTransparency = 0.4
                sentinelGeneratorHL2.OutlineTransparency = 0.4
                sentinelGeneratorHL2.Parent = generator

                GeneratorHighlights[generator] = sentinelGeneratorHL2
              end
            end
          end
        end

        for key26, value189 in pairs(GeneratorHighlights) do
          if not key26.Parent then
            value189:Destroy()
            GeneratorHighlights[key26] = nil
          end
        end
      else
        for key27, value190 in pairs(GeneratorHighlights) do
          value190:Destroy()
          GeneratorHighlights[key27] = nil
        end
      end
    end
  end)

  runService.RenderStepped:Connect(function()
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
  CharacterAccessoryConnection = nil

  function f51(p125, p126)
    if not p125 or not p125:IsA("Accessory") then
      return false
    else
      local handle2 = p125:FindFirstChild("Handle")

      if not handle2 then
        return false
      end

      for index63, value191 in ipairs(handle2:GetChildren()) do
        if value191:IsA("Attachment") then
          if v142[value191.Name] then
            return true
          elseif p126 and p126:FindFirstChild(value191.Name) then
            return true
          end
        end
      end

      return false
    end
  end

  v142 = {
    HatAttachment = true,
    HairAttachment = true,
    FaceFrontAttachment = true,
    FaceCenterAttachment = true,
    HeadAttachment = true,
  }

  function f52(p127)
    if HeadAccessoryConnection then
      HeadAccessoryConnection:Disconnect()
      HeadAccessoryConnection = nil
    end

    if CharacterAccessoryConnection then
      CharacterAccessoryConnection:Disconnect()
      CharacterAccessoryConnection = nil
    end

    f53(p127)
    local head5 = p127 and p127:FindFirstChild("Head")

    if head5 then
      HeadAccessoryConnection = head5.ChildAdded:Connect(function(child15)
        if child15:IsA("Accessory") or child15:IsA("Hat") then
          task.defer(function()
            if child15 and child15.Parent then
              child15:Destroy()
            end
          end)
        end
      end)
    end

    CharacterAccessoryConnection = p127.ChildAdded:Connect(function(child16)
      if child16:IsA("Accessory") or child16:IsA("Hat") then
        task.defer(function()
          if child16 and child16.Parent then
            if f51(child16, (p127:FindFirstChild("Head"))) then
              child16:Destroy()
            end
          end
        end)
      end
    end)
  end

  function f53(p128)
    if not p128 then
      return
    else
      local head6 = p128:FindFirstChild("Head")

      for index64, value192 in ipairs(p128:GetChildren()) do
        if value192:IsA("Accessory") and f51(value192, head6) then
          value192:Destroy()
        end
      end

      if head6 then
        for index65, value193 in ipairs(head6:GetChildren()) do
          if value193:IsA("Accessory") or value193:IsA("Hat") then
            value193:Destroy()
          end
        end
      end

      return
    end
  end

  task.spawn(function()
    while SentinelActive do
      task.wait(0.1)
      local character61 = localPlayer.Character

      if character61 then
        local head7 = character61:FindFirstChild("Head")

        if head7 then
          for index66, value194 in ipairs(head7:GetChildren()) do
            local v161 = value194

            if v161:IsA("Accessory") or v161:IsA("Hat") then
              pcall(function() v161:Destroy() end)
            end
          end
        end

        for index67, value195 in ipairs(character61:GetChildren()) do
          local v162 = value195

          if v162:IsA("Accessory") or v162:IsA("Hat") then
            if f51(v162, head7) then
              pcall(function() v162:Destroy() end)
            end
          end
        end
      end
    end
  end)

  if localPlayer.Character then
    f52(localPlayer.Character)
  end

  localPlayer.CharacterAdded:Connect(function(character62)
    character62:WaitForChild("Head")
    f52(character62)
  end)

  local v163 = os.clock()

  print("\n============ Sentinel Account & Info ============")
  print("User         : " .. SentinelUserName)
  print("Account Age  : " .. SentinelAccountAge)
  print("Device       : " .. SentinelDeviceType)
  print("\n============ Sentinel Script & Executor ============")
  print("Load Time    : " .. string.format("%.3f", v163 - SentinelLoadStart) .. "s")
  print("Executor     : " .. SentinelExecutorName)
  print("Hook Support : " .. (SentinelHookSupported and "YES" or "NO"))

  f3()

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
        Title = "Sentinel v15.00.00",
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
        Content = [[
Key system Fixed.
Added new bypass for movement and silent aim.
The script is now undetected :D]],
        Icon = "newspaper",
        Duration = 8.3,
      })
    end)
  end

  return
end
