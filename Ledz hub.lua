-- this is for BloxStrike

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local State = type(STATE) == "table" and STATE or nil
local CleanupTasks = {}
local Connections = {}
local IsDestroyed = false

local Cleanup = {}

function Cleanup.OnCleanup(CleanupFunction)
  table.insert(CleanupTasks, CleanupFunction)

  if State and State.onCleanup then
    pcall(State.onCleanup, CleanupFunction)
  end
end

function Cleanup.Connect(Signal, Callback)
  local Connection = Signal:Connect(Callback)
  table.insert(Connections, Connection)
  return Connection
end

function Cleanup.Alive()
  if IsDestroyed then
    return false
  end

  if State and State.alive then
    local Success, IsAlive = pcall(State.alive)

    if Success and IsAlive == false then
      return false
    end

    return true
  end

  return true
end

local function Unload()
  if IsDestroyed then
    return
  end

  IsDestroyed = true

  for Index, Connection in ipairs(Connections) do
  end

  table.clear(Connections)

  for Index = #CleanupTasks, 1, -1 do
    pcall(CleanupTasks[Index])
  end

  table.clear(CleanupTasks)
end

Cleanup.OnCleanup(function()
  IsDestroyed = true
end)

local IsTouchDevice = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
local HasNativeClickSupport = type(mouse1click) == "function" and type(isrbxactive) == "function"

local Config = {
  Master = true,
  Aim = {
    Enabled = true,
    Mode = IsTouchDevice and "Toggle" or "Hold",
    Toggled = false,
    TargetPart = "Head",
    Priority = "Crosshair",
    FOVRadius = 140,
    Smoothing = 12,
    MaxDegPerSec = 260,
    VisibleOnly = true,
    ShowFOV = true,
    RecoilComp = true,
    RecoilCompPct = 100,
  },
  Assist = {
    Enabled = false,
    Strength = 0.3,
    RecoilAssist = false,
    RecoilAmount = 0.75,
  },
  ESP = {
    Enabled = true,
    Box = true,
    HealthBar = true,
    Name = true,
    Info = true,
    HeadDot = true,
    Snapline = false,
    Skeleton = false,
    LookingAtYou = true,
    DimOccluded = true,
    MaxDistance = 1000,
    TeamCheck = true,
  },
  Radar = {
    Enabled = true,
    Radius = 105,
    Range = 250,
    X = 150,
    Y = 330,
    Facing = true,
  },
  Intel = { Enabled = true },
  NoFlash = { Enabled = true },
  Debug = { Enabled = true },
  Trigger = {
    Enabled = false,
    Key = Enum.KeyCode.LeftAlt,
    DelayMs = 45,
    Cooldown = 0.12,
    VisibleOnly = true,
  },
  FOV = { Enabled = false, Value = 70 },
  Colors = {
    Enemy = Color3.fromRGB(255, 85, 95),
    EnemyDim = Color3.fromRGB(135, 58, 63),
    Watching = Color3.fromRGB(255, 210, 90),
    Health = Color3.fromRGB(110, 230, 130),
    HealthLow = Color3.fromRGB(240, 90, 90),
    Text = Color3.fromRGB(235, 240, 245),
    Accent = Color3.fromRGB(120, 200, 255),
  },
}

local function DeepCopy(Table)
  local Copy = {}

  for Key, Value in pairs(Table) do
    Copy[Key] = type(Value) == "table" and DeepCopy(Value) or Value
  end

  return Copy
end

local function IsFiniteNumber(Value)
  return type(Value) == "number" and Value == Value and Value ~= math.huge and Value ~= -math.huge
end

local function MergeConfig(Target, Source)
  for Key, Value in pairs(Source) do
    if type(Value) == "table" and type(Target[Key]) == "table" then
      MergeConfig(Target[Key], Value)
    else
      Target[Key] = Value
    end
  end
end

local DefaultConfig = DeepCopy(Config)

local function ToNumber(Value, DefaultValue)
  local NumberValue = tonumber(Value)

  if NumberValue == nil or NumberValue ~= NumberValue then
    return DefaultValue
  end

  return NumberValue
end

local function DecodeJson(Value)
  if type(Value) ~= "string" or #Value == 0 then
    return nil
  else
    local Success, DecodedValue = pcall(function()
      return HttpService:JSONDecode(Value)
    end)

    if Success and type(DecodedValue) == "table" then
      return DecodedValue
    end

    return nil
  end
end

local function IsCharacterAlive(Character)
  if not Character or not Character.Parent then
    return false
  elseif Character:GetAttribute("Dead") == true then
    return false
  else
    local Health = Character:GetAttribute("Health")

    if Health ~= nil and ToNumber(Health, 0) <= 0 then
      return false
    end

    return Character:FindFirstChild("HumanoidRootPart") ~= nil
  end
end

local function GetCurrentCamera()
  return Workspace.CurrentCamera
end

local function GetArmorHealth(Player)
  local ArmorData = DecodeJson(Player:GetAttribute("Armor"))

  if ArmorData then
    return ToNumber(ArmorData.Health, 0)
  end

  return 0
end

local function GetCharacter(Player)
  if not Player then
    return nil
  else
    local Character = Player.Character

    if Character and Character.Parent then
      return Character
    else
      local CharactersFolder = Workspace:FindFirstChild("Characters")

      if CharactersFolder then
        local CharacterModel = CharactersFolder:FindFirstChild(Player.Name)

        if CharacterModel then
          return CharacterModel
        end

        return Workspace:FindFirstChild(Player.Name)
      end

      return Workspace:FindFirstChild(Player.Name)
    end
  end
end

local function GetEquippedWeapon(Player)
  local EquippedData = DecodeJson(Player:GetAttribute("CurrentEquipped"))

  if EquippedData and type(EquippedData.Name) == "string" then
    return EquippedData.Name, tonumber(EquippedData.Rounds), tonumber(EquippedData.Capacity)
  end

  return nil
end

local function GetLocalTeam()
  return LocalPlayer:GetAttribute("Team")
end

local function IsEnemy(Player)
  if not Config.ESP.TeamCheck then
    return true
  else
    local LocalTeam = GetLocalTeam()
    local PlayerTeam = Player:GetAttribute("Team")

    if not LocalTeam or not PlayerTeam then
      return true
    end

    return PlayerTeam ~= LocalTeam
  end
end

local RaycastParams = RaycastParams.new()
RaycastParams.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams.IgnoreWater = true

local function GetRaycastExclusions(FirstCharacter, SecondCharacter)
  local ExcludedInstances = {}

  if FirstCharacter then
    table.insert(ExcludedInstances, FirstCharacter)
  end

  if SecondCharacter then
    table.insert(ExcludedInstances, SecondCharacter)
  end

  local DebrisFolder = Workspace:FindFirstChild("Debris")

  if DebrisFolder then
    table.insert(ExcludedInstances, DebrisFolder)
  end

  return ExcludedInstances
end

local function IsVisible(Origin, Destination, Character, LocalCharacter)
  RaycastParams.FilterDescendantsInstances = GetRaycastExclusions(Character, LocalCharacter)
  local Direction = Destination - Origin

  if Direction.Magnitude < 0.01 then
    return true
  else
    local Success, Result = pcall(function()
      return Workspace:Raycast(Origin, Direction, RaycastParams)
    end)

    if not Success then
      return false
    end

    return Result == nil
  end
end

local function SafeSet(Object, Property, Value)
  if Object then
    pcall(function()
      Object[Property] = Value
    end)
  end
end

local Drawings = {}

local function CreateDrawing(DrawingType, Properties)
  local Success, DrawingObject = pcall(Drawing.new, DrawingType)

  if not Success or not DrawingObject then
    return nil
  end

  for Property, Value in pairs(Properties or {}) do
    local PropertyName = Property
    local PropertyValue = Value
    pcall(function()
      DrawingObject[PropertyName] = PropertyValue
    end)
  end

  pcall(function()
    DrawingObject.Visible = false
  end)

  table.insert(Drawings, DrawingObject)
  return DrawingObject
end

Cleanup.OnCleanup(function()
  for Index, DrawingObject in ipairs(Drawings) do
  end

  table.clear(Drawings)
end)

local SkeletonConnections = {
  { "Head", "UpperTorso" }, { "UpperTorso", "LowerTorso" }, { "UpperTorso", "LeftUpperArm" },
  { "LeftUpperArm", "LeftLowerArm" }, { "LeftLowerArm", "LeftHand" },
  { "UpperTorso", "RightUpperArm" }, { "RightUpperArm", "RightLowerArm" },
  { "RightLowerArm", "RightHand" }, { "LowerTorso", "LeftUpperLeg" },
  { "LeftUpperLeg", "LeftLowerLeg" }, { "LeftLowerLeg", "LeftFoot" },
  { "LowerTorso", "RightUpperLeg" }, { "RightUpperLeg", "RightLowerLeg" },
  { "RightLowerLeg", "RightFoot" },
}

local function HidePlayerDrawings(PlayerDrawings)
  if not PlayerDrawings then
    return
  end

  SafeSet(PlayerDrawings.boxOut, "Visible", false)
  SafeSet(PlayerDrawings.box, "Visible", false)
  SafeSet(PlayerDrawings.hpBg, "Visible", false)
  SafeSet(PlayerDrawings.hpFg, "Visible", false)
  SafeSet(PlayerDrawings.name, "Visible", false)
  SafeSet(PlayerDrawings.info, "Visible", false)
  SafeSet(PlayerDrawings.snap, "Visible", false)
  SafeSet(PlayerDrawings.head, "Visible", false)
  SafeSet(PlayerDrawings.radar, "Visible", false)
  SafeSet(PlayerDrawings.radarDir, "Visible", false)

  for Index, BoneDrawing in ipairs(PlayerDrawings.bones) do
  end
end

local PlayerDrawingsCache = {}

local function GetPlayerDrawings(Player)
  local ExistingDrawings = PlayerDrawingsCache[Player]

  if ExistingDrawings then
    return ExistingDrawings
  else
    local NewDrawings = {
      boxOut = CreateDrawing("Square", {
        Thickness = 3,
        Filled = false,
        Color = Color3.new(0, 0, 0),
        Transparency = 0.5,
      }),
      box = CreateDrawing("Square", {
        Thickness = 1,
        Filled = false,
        Color = Config.Colors.Enemy,
      }),
      hpBg = CreateDrawing("Square", {
        Thickness = 1,
        Filled = true,
        Color = Color3.fromRGB(18, 18, 18),
        Transparency = 0.7,
      }),
      hpFg = CreateDrawing("Square", {
        Thickness = 1,
        Filled = true,
        Color = Config.Colors.Health,
      }),
      name = CreateDrawing("Text", {
        Size = 13,
        Center = true,
        Outline = true,
        Color = Config.Colors.Text,
      }),
      info = CreateDrawing("Text", {
        Size = 12,
        Center = true,
        Outline = true,
        Color = Config.Colors.Accent,
      }),
      snap = CreateDrawing("Line", {
        Thickness = 1,
        Color = Config.Colors.Enemy,
        Transparency = 0.6,
      }),
      head = CreateDrawing("Circle", {
        Thickness = 1,
        Filled = false,
        Color = Config.Colors.Enemy,
      }),
      radar = CreateDrawing("Circle", {
        Thickness = 1,
        Filled = true,
        Color = Config.Colors.Enemy,
        Radius = 3,
      }),
      radarDir = CreateDrawing("Line", {
        Thickness = 1,
        Color = Config.Colors.Watching,
        Transparency = 0.75,
      }),
      bones = {},
    }

    for Index = 1, #SkeletonConnections do
      table.insert(
        NewDrawings.bones,
        CreateDrawing("Line", {
          Thickness = 1,
          Color = Config.Colors.Enemy,
          Transparency = 0.75,
        })
      )
    end

    PlayerDrawingsCache[Player] = NewDrawings
    return NewDrawings
  end
end

Cleanup.Connect(Players.PlayerRemoving, function(Player)
  HidePlayerDrawings(PlayerDrawingsCache[Player])
  PlayerDrawingsCache[Player] = nil
end)

local FOVCircle = CreateDrawing("Circle", {
  Thickness = 1,
  Filled = false,
  Color = Config.Colors.Accent,
  Transparency = 0.5,
})

local CrosshairDot = CreateDrawing("Circle", {
  Thickness = 1,
  Filled = true,
  Color = Color3.fromRGB(255, 255, 255),
  Radius = 2,
})

local AimFOVCircle = CreateDrawing("Circle", {
  Thickness = 1,
  Filled = false,
  Color = Config.Colors.Accent,
  Transparency = 0.55,
})

local WatchingText = CreateDrawing("Text", {
  Size = 15,
  Center = true,
  Outline = true,
  Color = Config.Colors.Watching,
})

local IntelText = {}

for Index = 1, 12 do
  IntelText[Index] = CreateDrawing("Text", {
    Size = 13,
    Center = false,
    Outline = true,
    Color = Config.Colors.Text,
  })
end

local Targets = {}

local function UpdateTargets()
  table.clear(Targets)

  local Camera = GetCurrentCamera()

  if not Camera then
    return
  else
    local LocalCharacter = GetCharacter(LocalPlayer)
    local CameraPosition = Camera.CFrame.Position
    local ViewportSize = Camera.ViewportSize
    local ScreenCenter = Vector2.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.5)
    local LocalHead = LocalCharacter
      and (LocalCharacter:FindFirstChild("Head") or LocalCharacter:FindFirstChild("HumanoidRootPart"))

    for Index, Player in ipairs(Players:GetPlayers()) do
      if Player ~= LocalPlayer and IsEnemy(Player) then
        local Character = GetCharacter(Player)

        if IsCharacterAlive(Character) then
          local RootPart = Character:FindFirstChild("HumanoidRootPart")
          local Head = Character:FindFirstChild("Head") or RootPart

          if RootPart and Head then
            local Distance = (CameraPosition - RootPart.Position).Magnitude

            if IsFiniteNumber(Distance) and Distance <= Config.ESP.MaxDistance then
              local Success, ScreenPosition, IsVisibleOnScreen = pcall(function()
                local Position, Visible = Camera:WorldToViewportPoint(Head.Position)
                return Position, Visible
              end)

              if Success and ScreenPosition then
                local ScreenVector = Vector2.new(ScreenPosition.X, ScreenPosition.Y)

                local TargetData = {
                  plr = Player,
                  char = Character,
                  root = RootPart,
                  head = Head,
                  dist = Distance,
                  onScreen = IsVisibleOnScreen == true and ScreenPosition.Z > 0,
                  screen = ScreenVector,
                  crossD = (ScreenVector - ScreenCenter).Magnitude,
                  hp = ToNumber(Character:GetAttribute("Health"), 0),
                  maxHp = math.max(ToNumber(Character:GetAttribute("MaxHealth"), 100), 1),
                  visible = false,
                  watching = false,
                }

                if TargetData.onScreen then
                  TargetData.visible = IsVisible(
                    CameraPosition,
                    Head.Position,
                    Character,
                    LocalCharacter
                  )
                end

                if Config.ESP.LookingAtYou and LocalHead then
                  local CameraCFrame = Character:GetAttribute("CameraCFrame")

                  if typeof(CameraCFrame) == "CFrame" then
                    local DirectionToLocalHead = LocalHead.Position - CameraCFrame.Position

                    if DirectionToLocalHead.Magnitude > 0.1 then
                      local DotProduct = CameraCFrame.LookVector:Dot(DirectionToLocalHead.Unit)

                      if IsFiniteNumber(DotProduct) then
                        TargetData.watching =
                          math.deg(math.acos(math.clamp(DotProduct, -1, 1))) < 18
                      end
                    end
                  end
                end

                table.insert(Targets, TargetData)
              end
            end
          end
        end
      end
    end

    return
  end
end

local BoundingBoxOffsets = {
  Vector3.new(2, 3, 2), Vector3.new(-2, 3, 2), Vector3.new(2, -3, 2),
  Vector3.new(-2, -3, 2), Vector3.new(2, 3, -2), Vector3.new(-2, 3, -2),
  Vector3.new(2, -3, -2), Vector3.new(-2, -3, -2),
}

local function GetBoundingBox(Camera, RootPart)
  local RootCFrame = RootPart.CFrame
  local MinX = math.huge
  local MinY = math.huge
  local MaxX = -math.huge
  local MaxY = -math.huge
  local HasVisiblePoint = false

  for Index, Offset in ipairs(BoundingBoxOffsets) do
    local ScreenPosition = Camera:WorldToViewportPoint(
      RootCFrame:PointToWorldSpace(Offset)
    )

    if ScreenPosition.Z > 0 then
      HasVisiblePoint = true
    end

    if ScreenPosition.X < MinX then
      MinX = ScreenPosition.X
    end

    if ScreenPosition.X > MaxX then
      MaxX = ScreenPosition.X
    end

    if ScreenPosition.Y < MinY then
      MinY = ScreenPosition.Y
    end

    if ScreenPosition.Y > MaxY then
      MaxY = ScreenPosition.Y
    end
  end

  if not HasVisiblePoint then
    return nil
  end

  if not (IsFiniteNumber(MinX) and IsFiniteNumber(MinY)
    and IsFiniteNumber(MaxX) and IsFiniteNumber(MaxY)) then
    return nil
  end

  return MinX, MinY, MaxX - MinX, MaxY - MinY
end

local function UpdateIntel()
  for Index, TextDrawing in ipairs(IntelText) do
  end

  if not (Config.Master and Config.Intel.Enabled) then
    return
  else
    local Camera = GetCurrentCamera()

    if not Camera then
      return
    else
      local TextX = Camera.ViewportSize.X - 320

      SafeSet(IntelText[1], "Text", "-- ENEMY INTEL --")
      SafeSet(IntelText[1], "Position", Vector2.new(TextX, 96))
      SafeSet(IntelText[1], "Color", Config.Colors.Accent)
      SafeSet(IntelText[1], "Visible", true)

      local LocalTeam = GetLocalTeam()
      local TextIndex = 2

      for Index, Player in ipairs(Players:GetPlayers()) do
        if TextIndex > #IntelText then
          break
        elseif Player ~= LocalPlayer then
          local PlayerTeam = Player:GetAttribute("Team")

          if not LocalTeam or not PlayerTeam or PlayerTeam ~= LocalTeam then
            local IsAlive = IsCharacterAlive(GetCharacter(Player))
            local Money = math.floor(ToNumber(Player:GetAttribute("Money"), 0))
            local WeaponName = GetEquippedWeapon(Player) or "-"
            local Kills = math.floor(ToNumber(Player:GetAttribute("Kills"), 0))
            local Deaths = math.floor(ToNumber(Player:GetAttribute("Deaths"), 0))
            local TextDrawing = IntelText[TextIndex]

            SafeSet(TextDrawing, "Text", string.format(
              "%-13s $%-6d %-12s %d/%d%s",
              string.sub(Player.DisplayName, 1, 13),
              Money,
              string.sub(WeaponName, 1, 12),
              Kills,
              Deaths,
              IsAlive and "" or " [DEAD]"
            ))

            SafeSet(
              TextDrawing,
              "Position",
              Vector2.new(TextX, 96 + (TextIndex - 1) * 15)
            )

            SafeSet(
              TextDrawing,
              "Color",
              IsAlive and Config.Colors.Text or Config.Colors.EnemyDim
            )

            SafeSet(TextDrawing, "Visible", true)

            TextIndex = TextIndex + 1
          end
        end
      end

      return
    end
  end
end

local function UpdateVisuals()
  local Camera = GetCurrentCamera()
  local WatchingColor

  if not Camera then
    return
  else
    local ViewportSize = Camera.ViewportSize
    local ScreenBottomCenter = Vector2.new(ViewportSize.X * 0.5, ViewportSize.Y)
    local RadarPosition = Vector2.new(Config.Radar.X, Config.Radar.Y)
    local RadarEnabled = Config.Master and Config.Radar.Enabled

    SafeSet(FOVCircle, "Visible", RadarEnabled)
    SafeSet(FOVCircle, "Radius", Config.Radar.Radius)
    SafeSet(FOVCircle, "Position", RadarPosition)
    SafeSet(CrosshairDot, "Visible", RadarEnabled)
    SafeSet(CrosshairDot, "Position", RadarPosition)

    local IsAnyoneWatching = false
    local ActivePlayers = {}

    for Index, Target in ipairs(Targets) do
      local PlayerDrawings = GetPlayerDrawings(Target.plr)
      ActivePlayers[Target.plr] = true
      HidePlayerDrawings(PlayerDrawings)

      if Target.watching then
        IsAnyoneWatching = true
      end

      if Target.watching then
        WatchingColor = Config.Colors.Watching
      elseif Target.visible or not Config.ESP.DimOccluded then
        WatchingColor = Config.Colors.Enemy
      else
        WatchingColor = Config.Colors.EnemyDim
      end

      if RadarEnabled then
        local RelativePosition = Camera.CFrame:PointToObjectSpace(Target.root.Position)

        local RadarOffset = Vector2.new(
          RelativePosition.X,
          RelativePosition.Z
        ) / math.max(Config.Radar.Range, 1) * Config.Radar.Radius

        if IsFiniteNumber(RadarOffset.X) and IsFiniteNumber(RadarOffset.Y) then
          if RadarOffset.Magnitude > Config.Radar.Radius then
            RadarOffset = RadarOffset.Unit * Config.Radar.Radius
          end

          local RadarPoint = RadarPosition + RadarOffset

          SafeSet(PlayerDrawings.radar, "Position", RadarPoint)
          SafeSet(PlayerDrawings.radar, "Color", WatchingColor)
          SafeSet(PlayerDrawings.radar, "Visible", true)

          if Config.Radar.Facing then
            local EnemyCameraCFrame = Target.char:GetAttribute("CameraCFrame")

            if typeof(EnemyCameraCFrame) == "CFrame" then
              local RelativeLookVector =
                Camera.CFrame:VectorToObjectSpace(EnemyCameraCFrame.LookVector)

              local FacingVector = Vector2.new(
                RelativeLookVector.X,
                RelativeLookVector.Z
              )

              if FacingVector.Magnitude > 0.01 then
                SafeSet(PlayerDrawings.radarDir, "From", RadarPoint)
                SafeSet(
                  PlayerDrawings.radarDir,
                  "To",
                  RadarPoint + FacingVector.Unit * 10
                )
                SafeSet(PlayerDrawings.radarDir, "Color", WatchingColor)
                SafeSet(PlayerDrawings.radarDir, "Visible", true)
              end
            end
          end
        end
      end

      if Config.Master and Config.ESP.Enabled and Target.onScreen then
        local Success, BoxX, BoxY, BoxWidth, BoxHeight =
          pcall(GetBoundingBox, Camera, Target.root)

        if Success and BoxX and BoxY and BoxWidth > 0 and BoxHeight > 0 then
          if Config.ESP.Box then
            SafeSet(PlayerDrawings.boxOut, "Position", Vector2.new(BoxX, BoxY))
            SafeSet(PlayerDrawings.boxOut, "Size", Vector2.new(BoxWidth, BoxHeight))
            SafeSet(PlayerDrawings.box, "Position", Vector2.new(BoxX, BoxY))
            SafeSet(PlayerDrawings.box, "Size", Vector2.new(BoxWidth, BoxHeight))
            SafeSet(PlayerDrawings.box, "Color", WatchingColor)
            SafeSet(PlayerDrawings.boxOut, "Visible", true)
            SafeSet(PlayerDrawings.box, "Visible", true)
          end

          if Config.ESP.HealthBar then
            local HealthHeight =
              BoxHeight * math.clamp(Target.hp / Target.maxHp, 0, 1)

            SafeSet(
              PlayerDrawings.hpBg,
              "Position",
              Vector2.new(BoxX - 6, BoxY)
            )
            SafeSet(
              PlayerDrawings.hpBg,
              "Size",
              Vector2.new(3, BoxHeight)
            )
            SafeSet(
              PlayerDrawings.hpFg,
              "Position",
              Vector2.new(BoxX - 6, BoxY + (BoxHeight - HealthHeight))
            )
            SafeSet(
              PlayerDrawings.hpFg,
              "Size",
              Vector2.new(3, HealthHeight)
            )
            SafeSet(PlayerDrawings.hpBg, "Visible", true)
            SafeSet(PlayerDrawings.hpFg, "Visible", true)
          end

          if Config.ESP.Name then
            local DisplayName = Target.plr.DisplayName

            if Target.watching then
              DisplayName = "> " .. DisplayName .. " <"
            end

            SafeSet(PlayerDrawings.name, "Text", DisplayName)
            SafeSet(
              PlayerDrawings.name,
              "Position",
              Vector2.new(BoxX + BoxWidth * 0.5, BoxY - 16)
            )
            SafeSet(PlayerDrawings.name, "Color", WatchingColor)
            SafeSet(PlayerDrawings.name, "Visible", true)
          end

          if Config.ESP.Info then
            local WeaponName, CurrentRounds, MaxRounds =
              GetEquippedWeapon(Target.plr)

            local ArmorHealth = GetArmorHealth(Target.plr)
            local InfoParts = {
              string.format("%dhp", math.floor(Target.hp)),
            }

            if ArmorHealth > 0 then
              table.insert(InfoParts, string.format("%da", math.floor(ArmorHealth)))
            end

            if WeaponName then
              if CurrentRounds and MaxRounds then
                table.insert(
                  InfoParts,
                  string.format("%s %d/%d", WeaponName, CurrentRounds, MaxRounds)
                )
              else
                table.insert(InfoParts, WeaponName)
              end
            end

            table.insert(
              InfoParts,
              string.format("%dm", math.floor(Target.dist))
            )

            if Target.plr:GetAttribute("HasDefuseKit") == true then
              table.insert(InfoParts, "KIT")
            end

            SafeSet(
              PlayerDrawings.info,
              "Text",
              table.concat(InfoParts, "  ")
            )
            SafeSet(
              PlayerDrawings.info,
              "Position",
              Vector2.new(BoxX + BoxWidth * 0.5, BoxY + BoxHeight + 3)
            )
            SafeSet(PlayerDrawings.info, "Visible", true)
          end

          if Config.ESP.HeadDot then
            local HeadScreenPosition =
              Camera:WorldToViewportPoint(Target.head.Position)

            SafeSet(
              PlayerDrawings.head,
              "Position",
              Vector2.new(
                HeadScreenPosition.X,
                HeadScreenPosition.Y
              )
            )

            SafeSet(
              PlayerDrawings.head,
              "Radius",
              math.clamp(BoxWidth * 0.16, 2, 10)
            )
            SafeSet(PlayerDrawings.head, "Color", WatchingColor)
            SafeSet(PlayerDrawings.head, "Visible", true)
          end

          if Config.ESP.Snapline then
            SafeSet(PlayerDrawings.snap, "From", ScreenBottomCenter)
            SafeSet(
              PlayerDrawings.snap,
              "To",
              Vector2.new(
                BoxX + BoxWidth * 0.5,
                BoxY + BoxHeight
              )
            )
            SafeSet(PlayerDrawings.snap, "Color", WatchingColor)
            SafeSet(PlayerDrawings.snap, "Visible", true)
          end

          if Config.ESP.Skeleton then
            for BoneIndex, BonePair in ipairs(SkeletonConnections) do
              local FirstBodyPart = Target.char:FindFirstChild(BonePair[1])
              local SecondBodyPart = Target.char:FindFirstChild(BonePair[2])
              local BoneDrawing = PlayerDrawings.bones[BoneIndex]

              if FirstBodyPart and SecondBodyPart and BoneDrawing then
                local FirstScreenPosition =
                  Camera:WorldToViewportPoint(FirstBodyPart.Position)
                local SecondScreenPosition =
                  Camera:WorldToViewportPoint(SecondBodyPart.Position)

                if FirstScreenPosition.Z > 0 and SecondScreenPosition.Z > 0 then
                  SafeSet(
                    BoneDrawing,
                    "From",
                    Vector2.new(
                      FirstScreenPosition.X,
                      FirstScreenPosition.Y
                    )
                  )

                  SafeSet(
                    BoneDrawing,
                    "To",
                    Vector2.new(
                      SecondScreenPosition.X,
                      SecondScreenPosition.Y
                    )
                  )

                  SafeSet(BoneDrawing, "Color", WatchingColor)
                  SafeSet(BoneDrawing, "Visible", true)
                end
              end
            end
          end
        end
      end
    end

    for Player, PlayerDrawings in pairs(PlayerDrawingsCache) do
    end

    if Config.Master and Config.ESP.LookingAtYou and IsAnyoneWatching then
      SafeSet(WatchingText, "Text", "! WATCHED !")
      SafeSet(
        WatchingText,
        "Position",
        Vector2.new(
          ViewportSize.X * 0.5,
          ViewportSize.Y * 0.5 + 70
        )
      )
      SafeSet(WatchingText, "Visible", true)
    else
      SafeSet(WatchingText, "Visible", false)
    end

    return
  end
end

local FlashObjects = {}

local function TrackFlashObject(Object)
  if not (Object:IsA("Frame") or Object:IsA("ImageLabel")) then
    return
  else
    local ObjectName = string.lower(Object.Name)

    if string.find(ObjectName, "flash", 1, true)
      or string.find(ObjectName, "blind", 1, true) then
      FlashObjects[Object] = true
    end

    return
  end
end

task.defer(function()
  if not pcall(function()
    for Index, Descendant in ipairs(PlayerGui:GetDescendants()) do
      TrackFlashObject(Descendant)
    end
  end) then
    warn("[LedZ] initial flash scan failed")
  end
end)

Cleanup.Connect(PlayerGui.DescendantAdded, function(Descendant)
  pcall(TrackFlashObject, Descendant)
end)

Cleanup.Connect(PlayerGui.DescendantRemoving, function(Descendant)
  FlashObjects[Descendant] = nil
end)

local function UpdateNoFlash()
  if not (Config.Master and Config.NoFlash.Enabled) then
    return
  end

  for Object in pairs(FlashObjects) do
    local FlashObject = Object

    if typeof(FlashObject) == "Instance" and FlashObject.Parent then
      pcall(function()
        if FlashObject.BackgroundTransparency < 1 then
          FlashObject.BackgroundTransparency = 1
        end

        if FlashObject:IsA("ImageLabel")
          and FlashObject.ImageTransparency < 1 then
          FlashObject.ImageTransparency = 1
        end
      end)
    else
      FlashObjects[FlashObject] = nil
    end
  end
end

local function FindAimTarget()
  local BestPriority = math.huge
  local BestTargetPart

  for Index, Target in ipairs(Targets) do
    if Target.onScreen
      and (not Config.Aim.VisibleOnly or Target.visible)
      and Target.crossD <= Config.Aim.FOVRadius then

      local PriorityValue

      if Config.Aim.Priority == "Lowest HP" then
        PriorityValue = Target.hp
      elseif Config.Aim.Priority == "Closest" then
        PriorityValue = Target.dist
      else
        PriorityValue = Target.crossD
      end

      if PriorityValue < BestPriority then
        BestPriority = PriorityValue
        BestTargetPart =
          Target.char:FindFirstChild(Config.Aim.TargetPart) or Target.head
      end
    end
  end

  return BestTargetPart
end

local IsADSActive = false
local IsFireActive = false
local IsMouseInputAvailable

local function IsFiring()
  if IsTouchDevice then
    return IsFireActive
  end

  return IsMouseInputAvailable(Enum.UserInputType.MouseButton1) or IsFireActive
end

function IsMouseInputAvailable(InputType)
  local Success, IsPressed = pcall(function()
    return UserInputService:IsMouseButtonPressed(InputType)
  end)

  return (Success and IsPressed) == true
end

local IsADSInputAvailable

local function IsAiming()
  if not (Config.Master and Config.Aim.Enabled) then
    return false
  else
    local AimMode = Config.Aim.Mode

    if AimMode == "Always" then
      return true
    elseif AimMode == "Toggle" then
      return Config.Aim.Toggled
    elseif AimMode == "On Fire" then
      return IsFiring()
    else
      if AimMode == "ADS or Fire" then
        return IsADSInputAvailable() or IsFiring()
      end

      return IsADSInputAvailable()
    end
  end
end

function IsADSInputAvailable()
  if IsTouchDevice then
    return IsADSActive
  end

  return IsMouseInputAvailable(Enum.UserInputType.MouseButton2) or IsADSActive
end

local RecoilRotation = CFrame.identity
local RecoilDegrees = 0
local LastCameraRotation

local function UpdateRecoil()
  if not LastCameraRotation then
    return
  else
    local CurrentCamera = Workspace.CurrentCamera

    if not CurrentCamera then
      return
    else
      local RelativeRotation =
        LastCameraRotation:Inverse() * CurrentCamera.CFrame.Rotation

      local RotationComponents = { RelativeRotation:GetComponents() }

      local RotationAngle = math.acos(
        math.clamp(
          (RotationComponents[4]
            + RotationComponents[8]
            + RotationComponents[12]
            - 1) * 0.5,
          -1,
          1
        )
      )

      if not IsFiniteNumber(RotationAngle)
        or math.deg(RotationAngle) > 30 then
        RecoilRotation = CFrame.identity
        RecoilDegrees = 0
        return
      end

      RecoilRotation = RelativeRotation
      RecoilDegrees = math.deg(RotationAngle)
      return
    end
  end
end

RunService:BindToRenderStep(
  "LedZ_Aim",
  Enum.RenderPriority.Camera.Value,
  function(DeltaTime)
    if not Cleanup.Alive() then
      pcall(function()
        RunService:UnbindFromRenderStep("LedZ_Aim")
      end)
      return
    else
      local Camera = GetCurrentCamera()

      if not Camera then
        return
      else
        local AimEngaged = IsAiming()

        SafeSet(
          AimFOVCircle,
          "Visible",
          AimEngaged and Config.Aim.ShowFOV
        )

        SafeSet(AimFOVCircle, "Radius", Config.Aim.FOVRadius)
        SafeSet(
          AimFOVCircle,
          "Position",
          Vector2.new(
            Camera.ViewportSize.X * 0.5,
            Camera.ViewportSize.Y * 0.5
          )
        )

        LastCameraRotation = Camera.CFrame.Rotation

        if not AimEngaged then
          return
        elseif not IsCharacterAlive(GetCharacter(LocalPlayer)) then
          return
        else
          local TargetPart = FindAimTarget()

          if not TargetPart or not TargetPart.Parent then
            return
          else
            local CameraCFrame = Camera.CFrame
            local CameraPosition = CameraCFrame.Position

            if (TargetPart.Position - CameraPosition).Magnitude < 0.01 then
              return
            else
              local TargetRotation =
                CFrame.lookAt(
                  CameraPosition,
                  TargetPart.Position,
                  CameraCFrame.UpVector
                ).Rotation

              if Config.Aim.RecoilComp then
                local RecoilAmount =
                  math.clamp(Config.Aim.RecoilCompPct, 0, 100) / 100

                TargetRotation =
                  TargetRotation
                  * (
                    RecoilAmount >= 0.999
                      and RecoilRotation:Inverse()
                      or CFrame.identity:Lerp(
                        RecoilRotation:Inverse(),
                        RecoilAmount
                      )
                  )
              end

              local RotationDot =
                CameraCFrame.LookVector:Dot(TargetRotation.LookVector)

              local ClampedDot = math.clamp(RotationDot, -1, 1)
              local AngleDifference = math.acos(ClampedDot)

              if not IsFiniteNumber(AngleDifference)
                or AngleDifference < 0.0001 then
                LastCameraRotation = CameraCFrame.Rotation
                return
              else
                local SmoothingAlpha =
                  math.clamp(Config.Aim.Smoothing * DeltaTime, 0, 1)

                local MaxRotationPerFrame =
                  math.rad(Config.Aim.MaxDegPerSec)

                local RotationStep =
                  math.min(
                    AngleDifference * SmoothingAlpha,
                    MaxRotationPerFrame * DeltaTime
                  )

                local RotationAlpha =
                  math.clamp(RotationStep / AngleDifference, 0, 1)

                if not IsFiniteNumber(RotationAlpha) then
                  return
                else
                  local NewRotation =
                    CameraCFrame.Rotation:Lerp(
                      TargetRotation,
                      RotationAlpha
                    )

                  Camera.CFrame =
                    CFrame.new(CameraPosition) * NewRotation

                  LastCameraRotation = NewRotation
                  return
                end
              end
            end
          end
        end
      end
    end
  end
)

Cleanup.OnCleanup(function()
  pcall(function()
    RunService:UnbindFromRenderStep("LedZ_Aim")
  end)
end)

local AimAssistOriginalFriction
local AimAssistPatched = false
local AimAssistController
local OriginalMagnetismRotation
local OriginalRecoilAssistMultiplier

local function PatchAimAssist()
  local Controller

  if AimAssistPatched then
    return true
  else
    local Success

    Success, Controller = pcall(function()
      return require(ReplicatedStorage.Controllers.AimAssistController)
    end)

    if not Success or type(Controller) ~= "table" then
      return false, "require failed"
    end

    AimAssistController = Controller
    OriginalMagnetismRotation = rawget(
      Controller,
      "GetMagnetismRotation"
    )
    OriginalRecoilAssistMultiplier = rawget(
      Controller,
      "GetRecoilAssistMultiplier"
    )
    AimAssistOriginalFriction = rawget(
      Controller,
      "GetFrictionMultiplier"
    )

    if not pcall(function()
      function Controller.GetMagnetismRotation(Player)
        if not (Config.Master and Config.Assist.Enabled) then
          if OriginalMagnetismRotation then
            local Success, Result =
              pcall(OriginalMagnetismRotation, Player)

            if Success and typeof(Result) == "Vector2" then
              return Result
            end

            return Vector2.zero
          end

          return Vector2.zero
        elseif not IsAiming() then
          return Vector2.zero
        else
          local Camera = GetCurrentCamera()

          if not Camera then
            return Vector2.zero
          elseif not IsCharacterAlive(GetCharacter(LocalPlayer)) then
            return Vector2.zero
          else
            local TargetPart = FindAimTarget()

            if not TargetPart or not TargetPart.Parent then
              return Vector2.zero
            else
              local CameraCFrame = Camera.CFrame
              local Direction = TargetPart.Position - CameraCFrame.Position

              if Direction.Magnitude < 0.01 then
                return Vector2.zero
              else
                local DirectionUnit = Direction.Unit
                local LookVector = CameraCFrame.LookVector

                local CurrentYaw =
                  math.atan2(-LookVector.X, -LookVector.Z)

                local TargetYaw =
                  math.atan2(-DirectionUnit.X, -DirectionUnit.Z)

                local YawDifference =
                  (TargetYaw - CurrentYaw + math.pi) % (2 * math.pi)
                  - math.pi

                local PitchDifference =
                  math.asin(math.clamp(DirectionUnit.Y, -1, 1))
                  - math.asin(math.clamp(LookVector.Y, -1, 1))

                if not (
                  IsFiniteNumber(YawDifference)
                  and IsFiniteNumber(PitchDifference)
                ) then
                  return Vector2.zero
                else
                  local AssistStrength =
                    math.clamp(Config.Assist.Strength, 0, 1)

                  local AssistVector =
                    Vector2.new(
                      YawDifference * AssistStrength,
                      PitchDifference * AssistStrength
                    )

                  if AssistVector.Magnitude < 0.0035 then
                    return Vector2.zero
                  end

                  return Vector2.new(
                    math.clamp(AssistVector.X, -1.5, 1.5),
                    math.clamp(AssistVector.Y, -1.5, 1.5)
                  )
                end
              end
            end
          end
        end
      end

      function Controller.GetRecoilAssistMultiplier(...)
        if Config.Master and Config.Assist.RecoilAssist then
          return math.clamp(
            Config.Assist.RecoilAmount,
            0,
            1
          )
        elseif OriginalRecoilAssistMultiplier then
          local Success, Result =
            pcall(OriginalRecoilAssistMultiplier, ...)

          if Success and type(Result) == "number"
            and IsFiniteNumber(Result) then
            return Result
          end

          return 0
        else
          return 0
        end
      end
    end) then
      return false, "table is frozen"
    end

    AimAssistPatched = true
    return true
  end
end

Cleanup.OnCleanup(function()
  if not AimAssistPatched or not AimAssistController then
    return
  end

  pcall(function()
    if OriginalMagnetismRotation then
      AimAssistController.GetMagnetismRotation =
        OriginalMagnetismRotation
    end

    if OriginalRecoilAssistMultiplier then
      AimAssistController.GetRecoilAssistMultiplier =
        OriginalRecoilAssistMultiplier
    end

    if AimAssistOriginalFriction then
      AimAssistController.GetFrictionMultiplier =
        AimAssistOriginalFriction
    end
  end)

  AimAssistPatched = false
end)

local CameraController

local function GetCameraController()
  if CameraController then
    return CameraController
  else
    local Success, Controller = pcall(function()
      return require(ReplicatedStorage.Controllers.CameraController)
    end)

    if Success and type(Controller) == "table" then
      CameraController = Controller
    end

    return CameraController
  end
end

local function UpdateFOVLock()
  local Controller = GetCameraController()

  if not Controller or type(Controller.setFOVLock) ~= "function" then
    return false
  end

  return pcall(function()
    if Config.Master and Config.FOV.Enabled then
      Controller.setFOVLock(
        "LedZ",
        true,
        math.clamp(Config.FOV.Value, 1, 80)
      )
    else
      Controller.setFOVLock("LedZ", false)
    end
  end)
end

Cleanup.OnCleanup(function()
  local Controller = CameraController

  if Controller and type(Controller.setFOVLock) == "function" then
    pcall(function()
      Controller.setFOVLock("LedZ", false)
    end)
  end
end)

local LastTriggerTime = 0

local function UpdateTriggerbot()
  local TriggerEnabled = Config.Master and Config.Trigger.Enabled
  local Camera

  if not TriggerEnabled then
    return
  elseif not HasNativeClickSupport then
    return
  elseif not UserInputService:IsKeyDown(Config.Trigger.Key) then
    return
  elseif os.clock() - LastTriggerTime < Config.Trigger.Cooldown then
    return
  else
    local ActiveSuccess, IsActive = pcall(isrbxactive)

    if not ActiveSuccess or not IsActive then
      return
    else
      Camera = GetCurrentCamera()
      local LocalCharacter = GetCharacter(LocalPlayer)

      if not Camera or not IsCharacterAlive(LocalCharacter) then
        return
      else
        RaycastParams.FilterDescendantsInstances =
          GetRaycastExclusions(nil, LocalCharacter)

        local RaycastSuccess, RaycastResult = pcall(function()
          return Workspace:Raycast(
            Camera.CFrame.Position,
            Camera.CFrame.LookVector * 900,
            RaycastParams
          )
        end)

        if not RaycastSuccess or not RaycastResult then
          return
        else
          local HitModel =
            RaycastResult.Instance:FindFirstAncestorOfClass("Model")

          if not HitModel then
            return
          else
            local HitPlayer = Players:FindFirstChild(HitModel.Name)

            if not HitPlayer
              or HitPlayer == LocalPlayer
              or not IsEnemy(HitPlayer) then
              return
            end

            if not IsCharacterAlive(HitModel) then
              return
            end

            LastTriggerTime = os.clock()

            task.delay(
              math.max(Config.Trigger.DelayMs, 0) / 1000,
              function()
                if not Cleanup.Alive() then
                  return
                end
              end
            )

            return
          end
        end
      end
    end
  end
end

local DebugText = {}

for Index = 1, 4 do
  DebugText[Index] = CreateDrawing("Text", {
    Size = 14,
    Center = true,
    Outline = true,
    Color = Config.Colors.Text,
  })
end

local function UpdateDebug()
  if not (Config.Master and Config.Debug.Enabled) then
    for Index, TextDrawing in ipairs(DebugText) do
    end

    return
  else
    local Camera = GetCurrentCamera()

    if not Camera then
      return
    else
      local DebugX = Camera.ViewportSize.X * 0.5
      local DebugY = Camera.ViewportSize.Y * 0.5 + 96
      local IsEngaged = IsAiming()
      local InputState = IsFiring() and "FIRE"

      InputState = InputState
        or IsADSInputAvailable() and "ADS"
        or "-"

      local TargetName = "no target"
      local AimError = "-"
      local TargetPart = FindAimTarget()

      if TargetPart and TargetPart.Parent then
        TargetName = TargetPart.Parent.Name
        local TargetDirection =
          TargetPart.Position - Camera.CFrame.Position

        if TargetDirection.Magnitude > 0.01 then
          local DotProduct =
            Camera.CFrame.LookVector:Dot(TargetDirection.Unit)

          local ClampedDot = math.clamp(DotProduct, -1, 1)

          AimError = string.format(
            "%.2f deg",
            math.deg(math.acos(ClampedDot))
          )
        end
      end

      for Index, DebugEntry in ipairs({
        {
          IsEngaged
            and "ENGAGED  [" .. InputState .. "]"
            or "idle  [" .. InputState .. "]",
          IsEngaged and Config.Colors.Health
            or Config.Colors.EnemyDim,
        },
        {
          string.format(
            "recoil %.2f deg   comp %s",
            RecoilDegrees,
            Config.Aim.RecoilComp
              and Config.Aim.RecoilCompPct .. "%"
              or "OFF"
          ),
          Config.Colors.Accent,
        },
        {
          "aim err " .. AimError,
          Config.Colors.Text,
        },
        {
          TargetName,
          Config.Colors.EnemyDim,
        },
      }) do
        local TextDrawing = DebugText[Index]

        SafeSet(TextDrawing, "Text", DebugEntry[1])
        SafeSet(TextDrawing, "Color", DebugEntry[2])
        SafeSet(
          TextDrawing,
          "Position",
          Vector2.new(DebugX, DebugY + (Index - 1) * 16)
        )
        SafeSet(TextDrawing, "Visible", true)
      end

      return
    end
  end
end

local RenderCount = 0

RunService:BindToRenderStep(
  "LedZ_Render",
  Enum.RenderPriority.Last.Value,
  function()
    if not Cleanup.Alive() then
      pcall(function()
        RunService:UnbindFromRenderStep("LedZ_Render")
      end)
      return
    else
      RenderCount = RenderCount + 1

      local Success, ErrorMessage = pcall(function()
        UpdateRecoil()
        UpdateTargets()
        UpdateVisuals()
        UpdateDebug()

        if RenderCount % 6 == 0 then
          UpdateIntel()
          UpdateNoFlash()
        end

        UpdateTriggerbot()
      end)

      if not Success and RenderCount % 120 == 0 then
        warn("[LedZ] render error: " .. tostring(ErrorMessage))
      end

      return
    end
  end
)

Cleanup.OnCleanup(function()
  pcall(function()
    RunService:UnbindFromRenderStep("LedZ_Render")
  end)
end)

Cleanup.Connect(UserInputService.InputBegan, function(Input, GameProcessed)
  if GameProcessed then
    return
  end

  if Input.UserInputType == Enum.UserInputType.MouseButton2 then
    IsADSActive = true
  elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
    IsFireActive = true
  end
end)

Cleanup.Connect(UserInputService.InputEnded, function(Input)
  if Input.UserInputType == Enum.UserInputType.MouseButton2 then
    IsADSActive = false
  elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
    IsFireActive = false
  end
end)

local WindUISuccess, WindUIResult = pcall(function()
  return loadstring(
    game:HttpGet(
      "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
    )
  )()
end)

local WindUI

if WindUISuccess and type(WindUIResult) == "table" then
  WindUI = WindUIResult
end

local Window
local UIHost
local IsUserInteracting
local LastInputTime
local WasUISettled
local CreateWrappedTab

if not WindUI then
  warn("[LedZ] WindUI failed to load -- running headless. Features still active.")
  return "LedZ Bloxstrike v0.5 BETA (headless)"
else
  pcall(function()
    WindUI:SetNotificationLower(true)
  end)

  UIHost = nil

  if type(gethui) == "function" then
    local Success, Host = pcall(gethui)

    if Success and typeof(Host) == "Instance" then
      UIHost = Host
    end
  end

  if not UIHost then
    local Success, Host = pcall(function()
      return CoreGui
    end)

    if Success and typeof(Host) == "Instance" then
      UIHost = Host
    end
  end

  if UIHost then
    pcall(function()
      WindUI:SetParent(UIHost)
    end)
  end

  local function UpdateUIHost()
    if not UIHost then
      return
    end

    pcall(function()
      for Index, Descendant in ipairs(UIHost:GetDescendants()) do
        if Descendant:IsA("ScreenGui") then
          Descendant.DisplayOrder = 2147483647
          Descendant.IgnoreGuiInset = true
          Descendant.ResetOnSpawn = false
          Descendant.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        end
      end
    end)
  end

  Window = WindUI:CreateWindow({
    Title = "LedZ Bloxstrike v0.5 BETA",
    Icon = "crosshair",
    Author = "made by crypt",
    Folder = "LedZBloxstrike",
    Size = UDim2.fromOffset(600, 470),
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 175,
    HideSearchBar = true,
    ToggleKey = Enum.KeyCode.RightControl,
    OpenButton = {
      Title = "LedZ",
      Icon = "crosshair",
      Draggable = true,
      Enabled = true,
      OnlyMobile = false,
    },
  })

  Cleanup.OnCleanup(function()
    if not Window then
      return
    end

    for Index, MethodName in ipairs({
      "Destroy",
      "Unload",
      "Close",
    }) do
      local Method = MethodName

      if type(rawget(Window, Method)) == "function"
        or type(Window[Method]) == "function" then
        if pcall(function()
          Window[Method](Window)
        end) then
          return
        end
      end
    end
  end)

  WasUISettled = false

  function IsUserInteracting()
    LastInputTime = os.clock()
  end

  LastInputTime = 0

  Cleanup.Connect(UserInputService.InputBegan, IsUserInteracting)
  Cleanup.Connect(UserInputService.TouchStarted, IsUserInteracting)

  Cleanup.Connect(UserInputService.InputChanged, function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseWheel then
      IsUserInteracting()
    end
  end)

  function CreateWrappedTab()
    return WasUISettled and os.clock() - LastInputTime < 1.5
  end

  local function WrapTab(Tab)
    if type(Tab) ~= "table" then
      return Tab
    end

    for Index, MethodName in ipairs({
      "Toggle",
      "Dropdown",
    }) do
      local OriginalMethod = Tab[MethodName]

      if type(OriginalMethod) == "function" then
        Tab[MethodName] = function(TabObject, Options)
          local HasCallback =
            type(Options) == "table"
            and type(Options.Callback) == "function"

          local OriginalCallback

          if HasCallback then
            OriginalCallback = Options.Callback

            function Options.Callback(...)
              if not CreateWrappedTab() then
                return
              end

              return OriginalCallback(...)
            end
          end

          return OriginalMethod(TabObject, Options)
        end
      end
    end

    return Tab
  end

  local AimbotTab = WrapTab(
    Window:Tab({
      Title = "Aimbot",
      Icon = "crosshair",
    })
  )

  AimbotTab:Toggle({
    Title = "Enabled",
    Desc = "Rotation-only camera aim. Passes the game's camera trap.",
    Value = Config.Aim.Enabled,
    Callback = function(Value)
      Config.Aim.Enabled = Value
    end,
  })

  AimbotTab:Dropdown({
    Title = "Activation",
    Desc = IsTouchDevice
      and "Mobile detected - use Toggle or On Fire."
      or "Hold = right mouse (ADS). On Fire = while shooting.",
    Values = {
      "Hold",
      "On Fire",
      "ADS or Fire",
      "Toggle",
      "Always",
    },
    Value = Config.Aim.Mode,
    Callback = function(Value)
      Config.Aim.Mode = Value

      if Value ~= "Toggle" then
        Config.Aim.Toggled = false
      end
    end,
  })

  AimbotTab:Toggle({
    Title = "Toggle State",
    Desc = "Used when Activation is set to Toggle (mobile-friendly).",
    Value = false,
    Callback = function(Value)
      Config.Aim.Toggled = Value
    end,
  })

  AimbotTab:Dropdown({
    Title = "Target Part",
    Values = {
      "Head",
      "UpperTorso",
      "LowerTorso",
      "HumanoidRootPart",
    },
    Value = Config.Aim.TargetPart,
    Callback = function(Value)
      Config.Aim.TargetPart = Value
    end,
  })

  AimbotTab:Dropdown({
    Title = "Priority",
    Values = {
      "Crosshair",
      "Lowest HP",
      "Closest",
    },
    Value = Config.Aim.Priority,
    Callback = function(Value)
      Config.Aim.Priority = Value
    end,
  })

  AimbotTab:Slider({
    Title = "FOV Radius",
    Desc = "Pixels from crosshair a target must be inside.",
    Value = {
      Min = 20,
      Max = 600,
      Default = Config.Aim.FOVRadius,
    },
    Step = 5,
    Callback = function(Value)
      Config.Aim.FOVRadius = ToNumber(Value, 140)
    end,
  })

  AimbotTab:Slider({
    Title = "Smoothing",
    Desc = "Higher = snappier. Low values look more human.",
    Value = {
      Min = 1,
      Max = 40,
      Default = Config.Aim.Smoothing,
    },
    Step = 1,
    Callback = function(Value)
      Config.Aim.Smoothing = ToNumber(Value, 12)
    end,
  })

  AimbotTab:Slider({
    Title = "Max Turn Speed",
    Desc = "Degrees per second ceiling. Your camera angle replicates - keep this plausible.",
    Value = {
      Min = 60,
      Max = 900,
      Default = Config.Aim.MaxDegPerSec,
    },
    Step = 10,
    Callback = function(Value)
      Config.Aim.MaxDegPerSec = ToNumber(Value, 260)
    end,
  })

  AimbotTab:Toggle({
    Title = "Visible Only",
    Desc = "Skip targets behind walls.",
    Value = Config.Aim.VisibleOnly,
    Callback = function(Value)
      Config.Aim.VisibleOnly = Value
    end,
  })

  AimbotTab:Toggle({
    Title = "Show FOV Circle",
    Value = Config.Aim.ShowFOV,
    Callback = function(Value)
      Config.Aim.ShowFOV = Value
    end,
  })

  AimbotTab:Toggle({
    Title = "Recoil Compensation",
    Desc = "Cancels the kick the game stacks on after we aim. Fixes shots landing high.",
    Value = Config.Aim.RecoilComp,
    Callback = function(Value)
      Config.Aim.RecoilComp = Value
    end,
  })

  AimbotTab:Slider({
    Title = "Recoil Comp %",
    Desc = "100 holds the crosshair dead still through a full spray.",
    Value = {
      Min = 0,
      Max = 100,
      Default = Config.Aim.RecoilCompPct,
    },
    Step = 5,
    Callback = function(Value)
      Config.Aim.RecoilCompPct = ToNumber(Value, 100)
    end,
  })

  local AimAssistTab = WrapTab(
    Window:Tab({
      Title = "Aim Assist",
      Icon = "magnet",
    })
  )

  AimAssistTab:Toggle({
    Title = "Native Magnetism Hijack",
    Desc = "Routes aim through the game's own aim-assist path (PC normally gets none).",
    Value = Config.Assist.Enabled,
    Callback = function(Value)
      Config.Assist.Enabled = Value

      if Value then
        if PatchAimAssist() then
        else
          Config.Assist.Enabled = false
        end
      end
    end,
  })

  AimAssistTab:Slider({
    Title = "Magnetism Strength",
    Desc = "Fraction of the angle error fed back per frame. Game clamps to 5 deg/frame.",
    Value = {
      Min = 0,
      Max = 100,
      Default = math.floor(Config.Assist.Strength * 100),
    },
    Step = 1,
    Callback = function(Value)
      Config.Assist.Strength =
        math.clamp(ToNumber(Value, 30) / 100, 0, 1)
    end,
  })

  AimAssistTab:Toggle({
    Title = "Recoil Assist",
    Desc = "Cancels weapon kick through the game's own recoil-assist multiplier.",
    Value = Config.Assist.RecoilAssist,
    Callback = function(Value)
      Config.Assist.RecoilAssist = Value

      if Value then
        if not PatchAimAssist() then
          Config.Assist.RecoilAssist = false
        end
      end
    end,
  })

  AimAssistTab:Slider({
    Title = "Recoil Reduction %",
    Desc = "75 is the game's own hidden DEVELOPER tier. 100 removes kick entirely.",
    Value = {
      Min = 0,
      Max = 100,
      Default = math.floor(Config.Assist.RecoilAmount * 100),
    },
    Step = 5,
    Callback = function(Value)
      Config.Assist.RecoilAmount =
        math.clamp(ToNumber(Value, 75) / 100, 0, 1)
    end,
  })

  local VisualsTab = WrapTab(
    Window:Tab({
      Title = "Visuals",
      Icon = "eye",
    })
  )

  VisualsTab:Toggle({
    Title = "ESP Enabled",
    Value = Config.ESP.Enabled,
    Callback = function(Value)
      Config.ESP.Enabled = Value
    end,
  })

  VisualsTab:Toggle({
    Title = "Boxes",
    Value = Config.ESP.Box,
    Callback = function(Value)
      Config.ESP.Box = Value
    end,
  })

  VisualsTab:Toggle({
    Title = "Health Bars",
    Value = Config.ESP.HealthBar,
    Callback = function(Value)
      Config.ESP.HealthBar = Value
    end,
  })

  VisualsTab:Toggle({
    Title = "Names",
    Value = Config.ESP.Name,
    Callback = function(Value)
      Config.ESP.Name = Value
    end,
  })

  VisualsTab:Toggle({
    Title = "Info (weapon / ammo / armor / dist)",
    Value = Config.ESP.Info,
    Callback = function(Value)
      Config.ESP.Info = Value
    end,
  })

  VisualsTab:Toggle({
    Title = "Head Dots",
    Value = Config.ESP.HeadDot,
    Callback = function(Value)
      Config.ESP.HeadDot = Value
    end,
  })

  VisualsTab:Toggle({
    Title = "Snaplines",
    Value = Config.ESP.Snapline,
    Callback = function(Value)
      Config.ESP.Snapline = Value
    end,
  })

  VisualsTab:Toggle({
    Title = "Skeletons",
    Desc = "Heavier - 14 extra lines per player.",
    Value = Config.ESP.Skeleton,
    Callback = function(Value)
      Config.ESP.Skeleton = Value
    end,
  })

  VisualsTab:Toggle({
    Title = "Watched Warning",
    Desc = "Reads their replicated CameraCFrame. Flags anyone aiming near you.",
    Value = Config.ESP.LookingAtYou,
    Callback = function(Value)
      Config.ESP.LookingAtYou = Value
    end,
  })

  VisualsTab:Toggle({
    Title = "Dim Occluded",
    Value = Config.ESP.DimOccluded,
    Callback = function(Value)
      Config.ESP.DimOccluded = Value
    end,
  })

  VisualsTab:Toggle({
    Title = "Team Check",
    Desc = "Off = draw teammates too.",
    Value = Config.ESP.TeamCheck,
    Callback = function(Value)
      Config.ESP.TeamCheck = Value
    end,
  })

  VisualsTab:Slider({
    Title = "Max Distance",
    Value = {
      Min = 50,
      Max = 2000,
      Default = Config.ESP.MaxDistance,
    },
    Step = 50,
    Callback = function(Value)
      Config.ESP.MaxDistance = ToNumber(Value, 1000)
    end,
  })

  local RadarTab = WrapTab(
    Window:Tab({
      Title = "Radar",
      Icon = "radar",
    })
  )

  RadarTab:Toggle({
    Title = "Enabled",
    Value = Config.Radar.Enabled,
    Callback = function(Value)
      Config.Radar.Enabled = Value
    end,
  })

  RadarTab:Toggle({
    Title = "Facing Lines",
    Desc = "Shows which way each enemy is looking.",
    Value = Config.Radar.Facing,
    Callback = function(Value)
      Config.Radar.Facing = Value
    end,
  })

  RadarTab:Slider({
    Title = "Size",
    Value = {
      Min = 50,
      Max = 220,
      Default = Config.Radar.Radius,
    },
    Step = 5,
    Callback = function(Value)
      Config.Radar.Radius = ToNumber(Value, 105)
    end,
  })

  RadarTab:Slider({
    Title = "Range (studs)",
    Value = {
      Min = 50,
      Max = 800,
      Default = Config.Radar.Range,
    },
    Step = 25,
    Callback = function(Value)
      Config.Radar.Range = ToNumber(Value, 250)
    end,
  })

  RadarTab:Slider({
    Title = "Position X",
    Value = {
      Min = 60,
      Max = 1600,
      Default = Config.Radar.X,
    },
    Step = 10,
    Callback = function(Value)
      Config.Radar.X = ToNumber(Value, 150)
    end,
  })

  RadarTab:Slider({
    Title = "Position Y",
    Value = {
      Min = 60,
      Max = 900,
      Default = Config.Radar.Y,
    },
    Step = 10,
    Callback = function(Value)
      Config.Radar.Y = ToNumber(Value, 330)
    end,
  })

  local MiscTab = WrapTab(
    Window:Tab({
      Title = "Misc",
      Icon = "settings",
    })
  )

  MiscTab:Toggle({
    Title = "Enemy Intel Board",
    Desc = "Money, weapon and K/D read straight off their player attributes.",
    Value = Config.Intel.Enabled,
    Callback = function(Value)
      Config.Intel.Enabled = Value
    end,
  })

  MiscTab:Toggle({
    Title = "No Flash",
    Value = Config.NoFlash.Enabled,
    Callback = function(Value)
      Config.NoFlash.Enabled = Value
    end,
  })

  MiscTab:Toggle({
    Title = "Debug HUD",
    Desc = "Live engage state, recoil angle and aim error under the crosshair.",
    Value = Config.Debug.Enabled,
    Callback = function(Value)
      Config.Debug.Enabled = Value
    end,
  })

  MiscTab:Toggle({
    Title = HasNativeClickSupport
      and "Triggerbot"
      or "Triggerbot (needs desktop input)",
    Desc = HasNativeClickSupport
      and "Hold Left Alt. Fires real OS clicks."
      or "mouse1click is unavailable on this platform.",
    Value = false,
    Locked = not HasNativeClickSupport,
    Callback = function(Value)
      local TriggerConfig = Config.Trigger
      TriggerConfig.Enabled =
        Value and HasNativeClickSupport
    end,
  })

  MiscTab:Slider({
    Title = "Trigger Delay (ms)",
    Desc = "Reaction floor. Under ~40 stops looking human.",
    Value = {
      Min = 0,
      Max = 400,
      Default = Config.Trigger.DelayMs,
    },
    Step = 5,
    Callback = function(Value)
      Config.Trigger.DelayMs = ToNumber(Value, 45)
    end,
  })

  MiscTab:Toggle({
    Title = "FOV Override",
    Desc = "Uses the game's own setFOVLock. May fight ADS zoom.",
    Value = Config.FOV.Enabled,
    Callback = function(Value)
      Config.FOV.Enabled = Value

      if not UpdateFOVLock() then
        Config.FOV.Enabled = false
      end
    end,
  })

  MiscTab:Slider({
    Title = "FOV Value",
    Value = {
      Min = 40,
      Max = 80,
      Default = Config.FOV.Value,
    },
    Step = 1,
    Callback = function(Value)
      Config.FOV.Value = ToNumber(Value, 70)
      UpdateFOVLock()
    end,
  })

  local SystemTab = WrapTab(
    Window:Tab({
      Title = "System",
      Icon = "power",
    })
  )

  SystemTab:Toggle({
    Title = "Master Switch",
    Desc = "Kills every visual and hook instantly without unloading.",
    Value = Config.Master,
    Callback = function(Value)
      Config.Master = Value

      if not Value then
        SafeSet(FOVCircle, "Visible", false)
        SafeSet(CrosshairDot, "Visible", false)
        SafeSet(AimFOVCircle, "Visible", false)
        SafeSet(WatchingText, "Visible", false)

        for Index, TextDrawing in ipairs(IntelText) do
        end

        UpdateFOVLock()
      end
    end,
  })

  SystemTab:Slider({
    Title = "UI Scale",
    Desc = "Bump this up on a phone.",
    Value = {
      Min = 50,
      Max = 200,
      Default = 100,
    },
    Step = 5,
    Callback = function(Value)
      pcall(function()
        if Window.SetUIScale then
          Window:SetUIScale(
            ToNumber(Value, 100) / 100
          )
        end
      end)
    end,
  })

  SystemTab:Dropdown({
    Title = "Theme",
    Values = {
      "Dark",
      "Light",
    },
    Value = "Dark",
    Callback = function(Value)
    end,
  })

  SystemTab:Toggle({
    Title = "UNLOAD",
    Desc = "Restores every patched function and removes all drawings.",
    Value = false,
    Callback = function(Value)
      if Value then
        task.defer(Unload)
      end
    end,
  })

  task.defer(function()
  end)

  task.spawn(function()
    local InitializationStartTime = os.clock()

    while os.clock() - InitializationStartTime < 1.5
      and Cleanup.Alive() do

      MergeConfig(Config, DefaultConfig)
      task.wait(0.05)
    end

    WasUISettled = true

    warn(
      ("[LedZ] settled: Aim.Mode=%s RecoilAssist=%s"):format(
        tostring(Config.Aim.Mode),
        tostring(Config.Assist.RecoilAssist)
      )
    )
  end)

  Cleanup.Connect(
    UserInputService.WindowFocused,
    UpdateUIHost
  )

  Cleanup.Connect(
    UserInputService.WindowFocusReleased,
    UpdateUIHost
  )

  if IsTouchDevice then
    Cleanup.Connect(
      UserInputService.TouchStarted,
      function(TouchInput, GameProcessed)
        if not GameProcessed then
          IsADSActive = true
        end
      end
    )

    Cleanup.Connect(
      UserInputService.TouchEnded,
      function()
        IsADSActive = false
      end
    )
  end

  if type(getgenv) == "function" then
    pcall(function()
      getgenv().LedZ = {
        CFG = Config,
        Version = "v0.5 BETA",
        Targets = function()
          return Targets
        end,
        PickTarget = FindAimTarget,
        Engaged = IsAiming,
        RecoilDeg = function()
          return RecoilDegrees
        end,
        RecoilCF = function()
          return RecoilRotation
        end,
        UserDriven = function()
          return CreateWrappedTab()
        end,
        SinceInput = function()
          return os.clock() - LastInputTime
        end,
        Firing = function()
          return IsFiring()
        end,
        Ads = function()
          return IsADSInputAvailable()
        end,
        PatchAssist = PatchAimAssist,
        Unload = Unload,
        Window = Window,
      }
    end)

    Cleanup.OnCleanup(function()
      pcall(function()
        getgenv().LedZ = nil
      end)
    end)
  end

  warn(
    ("[LedZ] %s %s loaded (%s, native click: %s, ui host: %s)"):format(
      "LedZ Bloxstrike",
      "v0.5 BETA",
      IsTouchDevice and "mobile" or "desktop",
      tostring(HasNativeClickSupport),
      UIHost and UIHost.Name or "PlayerGui"
    )
  )

  return "LedZ Bloxstrike v0.5 BETA active"
end
