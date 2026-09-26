-- this is for BloxStrike

local Game = game
local Bit32 = bit32
local Math = math
local String = string
local Table = table
local Type = type
local Task = task

local State = {
    Running = true,
    Connections = {},
    LastEvent = ""
}

local ModuleFactories = {}
local ModuleCache = {}

local Runtime = {
    State = State
}

local Config
local Util
local GameApi
local Combat
local Visuals
local Move
local Ui

local function TrackConnection(Connection)
    if Connection then
        Table.insert(State.Connections, Connection)
    end

    return Connection
end

local function GetService(ServiceName)
    local CloneRefSuccess, CloneRef = pcall(function()
        return cloneref
    end)

    if CloneRefSuccess and Type(CloneRef) == "function" then
        local Success, Service = pcall(function()
            return CloneRef(Game:GetService(ServiceName))
        end)

        if Success and Service then
            return Service
        end
    end

    return Game:GetService(ServiceName)
end

local function CreateInstance(ClassName, Properties, Parent)
    local Object = Instance.new(ClassName)

    for PropertyName, PropertyValue in pairs(Properties or {}) do
        Object[PropertyName] = PropertyValue
    end

    Object.Parent = Parent
    return Object
end

ModuleFactories.Util = function()
    local Module = {}

    Module.Players = GetService("Players")
    Module.RunService = GetService("RunService")
    Module.Workspace = GetService("Workspace")
    Module.UserInputService = GetService("UserInputService")
    Module.HttpService = GetService("HttpService")
    Module.ReplicatedStorage = GetService("ReplicatedStorage")
    Module.StarterGui = GetService("StarterGui")
    Module.LocalPlayer = Module.Players.LocalPlayer

    function Module.Track(Connection)
        return TrackConnection(Connection)
    end

    function Module.Spawn(Callback)
        return Task.spawn(function()
            if not State.Running then
                return
            end

            local Success, ErrorMessage = pcall(Callback)

            if not Success then
                warn("[VANTUM] worker error: " .. tostring(ErrorMessage))
            end
        end)
    end

    function Module.Try(Callback, ...)
        local Success, FirstResult, SecondResult, ThirdResult = pcall(Callback, ...)

        if Success then
            return true, FirstResult, SecondResult, ThirdResult
        end

        return false, FirstResult
    end

    function Module.Can(GlobalName)
        local Success = pcall(function()
            local GlobalValue = getfenv(0)[GlobalName]

            assert(
                Type(GlobalValue) == "function" or Type(GlobalValue) == "table",
                "missing"
            )
        end)

        return Success
    end

    function Module.Character()
        return Module.LocalPlayer and Module.LocalPlayer.Character or nil
    end

    function Module.Root()
        local Character = Module.Character()
        return Character and Character:FindFirstChild("HumanoidRootPart") or nil
    end

    function Module.Humanoid()
        local Character = Module.Character()
        return Character and Character:FindFirstChildOfClass("Humanoid") or nil
    end

    function Module.Camera()
        return Module.Workspace.CurrentCamera
    end

    function Module.Notify(Title, Text, Duration)
        pcall(function()
            Module.StarterGui:SetCore("SendNotification", {
                Title = tostring(Title),
                Text = tostring(Text),
                Duration = Duration or 3
            })
        end)
    end

    function Module.Log(Message, ...)
        local FormattedMessage

        if select(1, ...) > 0 then
            FormattedMessage = String.format(Message, ...)
        else
            FormattedMessage = tostring(Message)
        end

        State.LastEvent = FormattedMessage
        print("[VANTUM] module " .. FormattedMessage)
    end

    function Module.Fmt(Value)
        return tostring(Math.floor((tonumber(Value) or 0) + 0.5))
    end

    function Module.Capabilities()
        return {
            HookFunction = Module.Can("hookfunction"),
            GetGC = Module.Can("getgc"),
            SetReadonly = Module.Can("setreadonly"),
            Drawing = Module.Can("Drawing") or Type(getfenv(0).Drawing) == "table",
            MouseMoveRel = Module.Can("mousemoverel"),
            MouseClick = Module.Can("mouse1click"),
            DebugUpvalue = Module.Can("debug")
                and Type(debug) == "table"
                and Type(debug.getupvalues) == "function",
            GetConnections = Module.Can("getconnections")
        }
    end

    return Module
end

ModuleFactories.Config = function()
    local Module = {}
    local Utilities = Runtime.Require("util")

    local Defaults = {
        AimAssist = false,
        AimFOV = 120,
        AimSmooth = 6,
        AimVisibleFirst = true,
        AimHeadOnly = true,
        FovCircle = false,

        TriggerBot = false,
        TriggerDelay = 0.05,

        Hitbox = false,
        HitboxSize = 2,
        HitboxMax = 3,

        SilentAim = false,

        EspEnemies = false,
        EspTeam = false,
        EspChams = true,
        EspText = true,
        EspMaxDistance = 1500,

        EnemyColor = Color3.fromRGB(255, 12, 60),
        TeamColor = Color3.fromRGB(60, 200, 120),

        WalkSpeedEnabled = false,
        WalkSpeed = 19,

        JumpPowerEnabled = false,
        JumpPower = 18,

        AntiAfk = true,
        SaveConfig = true
    }

    local Keybinds = {
        ToggleAim = "F1",
        ToggleTrigger = "F2",
        ToggleEsp = "F3",
        ToggleFov = "F4",
        Unload = "END"
    }

    local Values = {}

    for Name, Value in pairs(Defaults) do
        Values[Name] = Value
    end

    Values.EnemyColor = Color3.fromRGB(255, 12, 60)
    Values.TeamColor = Color3.fromRGB(60, 200, 120)

    Module.Keybinds = Keybinds
    Module.FilePath = "vantum_bloxstrike.json"

    function Module.Get(Name)
        return Values[Name]
    end

    function Module.Set(Name, Value)
        Values[Name] = Value
    end

    function Module.IsBool(Name)
        return typeof(Defaults[Name]) == "boolean"
    end

    function Module.Save()
        if not Values.SaveConfig then
            return false
        end

        local Capabilities = Utilities.Capabilities()

        if not (Capabilities.HookFunction or Capabilities.GetGC or Type(writefile) == "function") then
            return false
        end

        if not (
            Type(writefile) == "function"
            and Type(readfile) == "function"
            and Type(isfile) == "function"
        ) then
            return false
        end

        local SerializableValues = {}

        for Name, Value in pairs(Values) do
            if typeof(Value) ~= "table" then
                SerializableValues[Name] = Value
            end
        end

        local EncodeSuccess, Encoded = pcall(function()
            return Utilities.HttpService:JSONEncode(SerializableValues)
        end)

        if not EncodeSuccess then
            return false
        end

        return pcall(writefile, Module.FilePath, Encoded)
    end

    function Module.Load()
        if not (
            Type(writefile) == "function"
            and Type(readfile) == "function"
            and Type(isfile) == "function"
        ) then
            return false
        end

        if not isfile(Module.FilePath) then
            return false
        end

        local ReadSuccess, Contents = pcall(readfile, Module.FilePath)

        if not ReadSuccess then
            return false
        end

        local DecodeSuccess, LoadedValues = pcall(function()
            return Utilities.HttpService:JSONDecode(Contents)
        end)

        if not DecodeSuccess or typeof(LoadedValues) ~= "table" then
            return false
        end

        for Name, Value in pairs(LoadedValues) do
            if Defaults[Name] ~= nil and typeof(Value) == typeof(Defaults[Name]) then
                Values[Name] = Value
            end
        end

        return true
    end

    return Module
end

ModuleFactories.Game = function()
    local Module = {}
    local Utilities = Runtime.Require("util")

    local WorkspaceService = Utilities.Workspace
    local LocalPlayer = Utilities.LocalPlayer
    local CharactersFolder =
        WorkspaceService:FindFirstChild("Characters")
        or WorkspaceService:WaitForChild("Characters", 6)

    local TerroristsFolder
    local CounterTerroristsFolder

    if CharactersFolder then
        TerroristsFolder = CharactersFolder:FindFirstChild("Terrorists")
        CounterTerroristsFolder = CharactersFolder:FindFirstChild("Counter-Terrorists")
    end

    local EnemiesCache = {}
    local TeammatesCache = {}
    local CacheDirty = true

    local RaycastParameters = RaycastParams.new()
    RaycastParameters.FilterType = Enum.RaycastFilterType.Exclude
    RaycastParameters.IgnoreWater = true

    local function IsModelTaggedAsFriendly(Character)
        local Armor = Character and Character:FindFirstChild("CharacterArmor")
        return Armor ~= nil and Armor:FindFirstChild("VestDetails") ~= nil
    end

    local function BuildCharacterCaches()
        EnemiesCache = {}
        TeammatesCache = {}

        local MyTeamFolder = Module.MyTeamFolder()

        local function AddFolderMembers(Folder)
            if not Folder then
                return
            end

            for _, Character in ipairs(Folder:GetChildren()) do
                if Character:IsA("Model") and Character.Name ~= LocalPlayer.Name then
                    if MyTeamFolder and Folder == MyTeamFolder then
                        Table.insert(TeammatesCache, Character)
                    elseif MyTeamFolder then
                        Table.insert(EnemiesCache, Character)
                    end
                end
            end
        end

        AddFolderMembers(TerroristsFolder)
        AddFolderMembers(CounterTerroristsFolder)

        if not MyTeamFolder then
            for _, Player in ipairs(Utilities.Players:GetPlayers()) do
                if Player ~= LocalPlayer
                    and Player.Character
                    and Module.IsEnemy(Player.Character) then
                    Table.insert(EnemiesCache, Player.Character)
                end
            end
        end

        CacheDirty = false
    end

    function Module.MarkDirty()
        CacheDirty = true
    end

    function Module.TFolder()
        return TerroristsFolder
    end

    function Module.CTFolder()
        return CounterTerroristsFolder
    end

    function Module.MyTeamFolder()
        local TerroristTeamFolder = Module.TFolder()
        local CounterTerroristTeamFolder = Module.CTFolder()

        if TerroristTeamFolder and TerroristTeamFolder:FindFirstChild(LocalPlayer.Name) then
            return TerroristTeamFolder, "T"
        end

        if CounterTerroristTeamFolder and CounterTerroristTeamFolder:FindFirstChild(LocalPlayer.Name) then
            return CounterTerroristTeamFolder, "CT"
        end

        return nil
    end

    function Module.IsEnemy(Character)
        if not Character or not Character:IsA("Model") then
            return false
        end

        local MyTeamFolder = Module.MyTeamFolder()

        if MyTeamFolder then
            if Character.Parent == MyTeamFolder then
                return false
            end

            local TerroristTeam = Module.TFolder()
            local CounterTerroristTeam = Module.CTFolder()

            if TerroristTeam and CounterTerroristTeam then
                if Character.Parent == TerroristTeam or Character.Parent == CounterTerroristTeam then
                    return true
                end
            end
        end

        local LocalCharacter = Utilities.Character()

        if LocalCharacter then
            local LocalArmor = IsModelTaggedAsFriendly(LocalCharacter)
            local TargetArmor = IsModelTaggedAsFriendly(Character)

            if IsModelTaggedAsFriendly(Character) ~= nil
                and (LocalArmor or TargetArmor)
                and LocalArmor ~= TargetArmor then
                return true
            end
        end

        local Player = Utilities.Players:GetPlayerFromCharacter(Character)

        if Player and Player.Team ~= nil and LocalPlayer.Team ~= nil then
            return Player.Team ~= LocalPlayer.Team
        end

        return false
    end

    function Module.IsTeammateChar(Character)
        return Character ~= nil
            and Character:IsA("Model")
            and not Module.IsEnemy(Character)
    end

    function Module.IsModelAlive(Character)
        if not Character then
            return false
        end

        if Character:GetAttribute("Dead") == true
            or Character:GetAttribute("Invincible") == true then
            return false
        end

        local AttributeHealth = Character:GetAttribute("Health")

        if AttributeHealth ~= nil then
            return (tonumber(AttributeHealth) or 0) > 0
        end

        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        return Humanoid ~= nil and Humanoid.Health > 0
    end

    function Module.HealthOf(Character)
        local AttributeHealth = Character and Character:GetAttribute("Health")

        if AttributeHealth ~= nil then
            return tonumber(AttributeHealth) or 0
        end

        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        return Humanoid and Humanoid.Health or 0
    end

    function Module.AimPart(Character, HeadOnly)
        if not Character then
            return nil
        end

        if HeadOnly ~= false then
            local Head = Character:FindFirstChild("Head")

            if Head then
                return Head
            end
        end

        return Character:FindFirstChild("Head")
            or Character:FindFirstChild("UpperTorso")
            or Character:FindFirstChild("HumanoidRootPart")
            or Character:FindFirstChild("Torso")
    end

    function Module.PlayerOf(Character)
        if not Character then
            return nil
        end

        local Player = Utilities.Players:FindFirstChild(Character.Name)

        if Player then
            return Player
        end

        return Utilities.Players:GetPlayerFromCharacter(Character)
    end

    function Module.DistanceTo(Position)
        local RootPart = Utilities.Root()
        return RootPart and (RootPart.Position - Position).Magnitude or Math.huge
    end

    function Module.ScreenPos(Position)
        local Camera = Utilities.Camera()

        if not Camera then
            return nil, false
        end

        local ScreenPosition, Visible = Camera:WorldToViewportPoint(Position)
        return Vector2.new(ScreenPosition.X, ScreenPosition.Y), Visible
    end

    function Module.Visible(TargetPart)
        local Camera = Utilities.Camera()

        if not Camera or not TargetPart then
            return false
        end

        local Filter = { Camera }
        local LocalCharacter = Utilities.Character()

        if LocalCharacter then
            Table.insert(Filter, LocalCharacter)
        end

        for _, Teammate in ipairs(Module.Teammates()) do
            Table.insert(Filter, Teammate)
        end

        RaycastParameters.FilterDescendantsInstances = Filter

        local Origin = Camera.CFrame.Position
        local Result = WorkspaceService:Raycast(
            Origin,
            TargetPart.Position - Origin,
            RaycastParameters
        )

        if not Result then
            return true
        end

        local HitModel = Result.Instance:FindFirstAncestorOfClass("Model")

        return HitModel == TargetPart.Parent
            or (
                HitModel
                and Result.Instance:IsDescendantOf(HitModel)
                and HitModel == TargetPart:FindFirstAncestorOfClass("Model")
            )
            or Result.Instance:IsDescendantOf(TargetPart.Parent)
    end

    function Module.SelfAlive()
        local MyTeamFolder = Module.MyTeamFolder()

        if MyTeamFolder then
            local LocalCharacter = MyTeamFolder:FindFirstChild(LocalPlayer.Name)

            if LocalCharacter then
                return Module.IsModelAlive(LocalCharacter)
            end
        end

        local Character = Utilities.Character()
        return Character and Module.IsModelAlive(Character) or false
    end

    function Module.Enemies()
        if CacheDirty then
            local Success, ErrorMessage = pcall(BuildCharacterCaches)

            if not Success then
                warn("[VANTUM] cache: " .. tostring(ErrorMessage))
            end
        end

        return EnemiesCache
    end

    function Module.Teammates()
        if CacheDirty then
            pcall(BuildCharacterCaches)
        end

        return TeammatesCache
    end

    if LocalPlayer.CharacterAdded then
        TrackConnection(LocalPlayer.CharacterAdded:Connect(Module.MarkDirty))
    end

    if CharactersFolder then
        for _, ChildName in ipairs({ "Terrorists", "Counter-Terrorists" }) do
            local Folder = CharactersFolder:FindFirstChild(ChildName)

            if Folder then
                TrackConnection(Folder.ChildAdded:Connect(Module.MarkDirty))
                TrackConnection(Folder.ChildRemoved:Connect(Module.MarkDirty))
            end
        end

        TrackConnection(CharactersFolder.ChildAdded:Connect(function(Child)
            Task.defer(function()
                TrackConnection(Child.ChildAdded:Connect(Module.MarkDirty))
                TrackConnection(Child.ChildRemoved:Connect(Module.MarkDirty))
                Module.MarkDirty()
            end)
        end))
    end

    TrackConnection(LocalPlayer.CharacterAdded:Connect(Module.MarkDirty))

    Utilities.Spawn(function()
        while State.Running do
            Task.wait(0.5)
            Module.MarkDirty()
        end
    end)

    return Module
end

ModuleFactories.Move = function()
    local Module = {}
    local Utilities = Runtime.Require("util")
    local Settings = Runtime.Require("config")

    TrackConnection(Utilities.RunService.RenderStepped:Connect(function()
        if not State.Running then
            return
        end

        local Character = Utilities.Character()
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

        if not Humanoid then
            return
        end

        if Settings:Get("WalkSpeedEnabled") then
            local WalkSpeed = tonumber(Settings:Get("WalkSpeed")) or 19

            if Humanoid.WalkSpeed ~= WalkSpeed then
                Humanoid.WalkSpeed = WalkSpeed
            end
        end

        if Settings:Get("JumpPowerEnabled") then
            local JumpPower = tonumber(Settings:Get("JumpPower")) or 50

            if Humanoid.JumpPower ~= JumpPower then
                Humanoid.JumpPower = JumpPower
            end
        end
    end))

    function Module.Shutdown()
        local Humanoid = Utilities.Humanoid()

        if Humanoid then
            pcall(function()
                Humanoid.WalkSpeed = 16
                Humanoid.JumpPower = 50
            end)
        end
    end

    return Module
end

ModuleFactories.Combat = function()
    local Module = {}
    local Utilities = Runtime.Require("util")
    local Settings = Runtime.Require("config")
    local GameApiModule = Runtime.Require("game")

    local AimState = {
        AimHeld = false,
        AimTarget = nil
    }

    local CurrentWeapon = nil
    local SilentAimInitialized = false
    local OriginalFunctions = {
        originals = {}
    }

    TrackConnection(Utilities.UserInputService.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton2 then
            AimState.AimHeld = true
        end
    end))

    TrackConnection(Utilities.UserInputService.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton2 then
            AimState.AimHeld = false
        end
    end))

    local function FindAimTarget()
        local Camera = Utilities.Camera()

        if not Camera then
            return nil
        end

        local AimFOV = tonumber(Settings:Get("AimFOV")) or 120
        local MousePosition = Utilities.UserInputService:GetMouseLocation()
        local HeadOnly = Settings:Get("AimHeadOnly")

        local BestTarget = nil
        local BestScore = Math.huge
        local CandidateTarget = nil

        for _, Enemy in ipairs(GameApiModule.Enemies()) do
            if GameApiModule.IsModelAlive(Enemy) then
                local AimPart = GameApiModule.AimPart(Enemy, HeadOnly)

                if AimPart then
                    local ScreenPosition, IsVisible = GameApiModule.ScreenPos(AimPart.Position)

                    if IsVisible then
                        local ScreenDistance = (ScreenPosition - MousePosition).Magnitude

                        if ScreenDistance <= AimFOV then
                            local WorldDistance = GameApiModule.DistanceTo(AimPart.Position)
                            local Score = ScreenDistance + WorldDistance * 0.02

                            if Score < BestScore then
                                BestTarget = AimPart
                                BestScore = Score
                            end
                        end
                    end
                end
            end
        end

        if BestTarget and Settings:Get("AimVisibleFirst") and GameApiModule.Visible(BestTarget) then
            CandidateTarget = BestTarget
        elseif BestTarget and not Settings:Get("AimVisibleFirst") then
            CandidateTarget = BestTarget
        end

        return CandidateTarget
    end

    local function UpdateAim(DeltaTime)
        if not Settings:Get("AimAssist") or not AimState.AimHeld then
            AimState.AimTarget = nil
            return
        end

        if not GameApiModule.SelfAlive() then
            AimState.AimTarget = nil
            return
        end

        local Camera = Utilities.Camera()

        if not Camera then
            return
        end

        local Target = AimState.AimTarget

        if not Target
            or not Target.Parent
            or not GameApiModule.IsModelAlive(Target.Parent)
            or not GameApiModule.IsEnemy(Target.Parent) then
            Target = FindAimTarget()
            AimState.AimTarget = Target
        end

        if not Target then
            return
        end

        local Smoothness = Math.clamp(
            tonumber(Settings:Get("AimSmooth")) or 6,
            1,
            20
        )

        local Alpha =
            Math.clamp(
                1 - ((Smoothness - 1) / 21),
                0.05,
                0.9
            )
            * Math.min(DeltaTime * 60, 2)

        local DesiredCFrame = CFrame.lookAt(
            Camera.CFrame.Position,
            Target.Position + Vector3.new(0, 0.05, 0)
        )

        Camera.CFrame = Camera.CFrame:Lerp(DesiredCFrame, Alpha)
    end

    local TriggerRaycastParameters = RaycastParams.new()
    TriggerRaycastParameters.FilterType = Enum.RaycastFilterType.Exclude
    TriggerRaycastParameters.IgnoreWater = true

    local function TriggerBot()
        if not Settings:Get("TriggerBot") or not GameApiModule.SelfAlive() then
            return
        end

        local Camera = Utilities.Camera()

        if not Camera then
            return
        end

        local Filter = {
            Camera,
            Utilities.Character()
        }

        TriggerRaycastParameters.FilterDescendantsInstances = Filter

        local ViewportSize = Camera.ViewportSize
        local Ray = Camera:ViewportPointToRay(
            ViewportSize.X / 2,
            ViewportSize.Y / 2
        )

        local Result = Utilities.Workspace:Raycast(
            Ray.Origin,
            Ray.Direction * 1000,
            TriggerRaycastParameters
        )

        if not Result then
            return
        end

        local Enemy = Result.Instance:FindFirstAncestorOfClass("Model")

        if not Enemy
            or not GameApiModule.IsEnemy(Enemy)
            or not GameApiModule.IsModelAlive(Enemy) then
            return
        end

        local TriggerDelay = tonumber(Settings:Get("TriggerDelay")) or 0

        if TriggerDelay > 0 then
            Task.wait(TriggerDelay)
        end

        if CurrentWeapon and Type(CurrentWeapon.shoot) == "function" then
            Utilities.Try(function()
                CurrentWeapon:shoot()
            end)
        elseif Utilities.Can("mouse1click") then
            pcall(mouse1click)
        end
    end

    local HitboxOriginals = {}

    local function RestoreHitboxes()
        for Part, Original in pairs(HitboxOriginals) do
            pcall(function()
                if Part and Part.Parent then
                    Part.Size = Original.Size
                    Part.Transparency = Original.Transparency
                    Part.CanCollide = Original.CanCollide
                end
            end)
        end

        Table.clear(HitboxOriginals)
    end

    function Module.HitboxRestore()
        RestoreHitboxes()
    end

    function Module.HitboxPulse()
        local HitboxEnabled = Settings:Get("Hitbox")
        local HitboxSize = Math.clamp(
            tonumber(Settings:Get("HitboxSize")) or 2,
            1,
            tonumber(Settings:Get("HitboxMax")) or 3
        )

        for _, Enemy in ipairs(GameApiModule.Enemies()) do
            local Head = Enemy:FindFirstChild("Head")

            if Head and GameApiModule.IsModelAlive(Enemy) then
                if HitboxEnabled then
                    if not HitboxOriginals[Head] then
                        HitboxOriginals[Head] = {
                            Size = Head.Size,
                            Transparency = Head.Transparency,
                            CanCollide = Head.CanCollide
                        }
                    end

                    Head.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
                    Head.Transparency = 0.6
                    Head.CanCollide = false
                end
            end
        end

        if not HitboxEnabled then
            RestoreHitboxes()
        end

        for Part in pairs(HitboxOriginals) do
            if not Part.Parent then
                HitboxOriginals[Part] = nil
            end
        end
    end

    local function EnsureSilentAimHook()
        if SilentAimInitialized then
            return
        end

        SilentAimInitialized = true

        local Capabilities = Utilities.Capabilities()

        if not (Capabilities.HookFunction and Capabilities.GetGC) then
            Utilities.Log(
                "GC tier unavailable on this executor (need hookfunction+getgc)"
            )
            return
        end

        pcall(function()
            for _, GarbageObject in next, getgc(true) do
                if Type(GarbageObject) == "table"
                    and rawget(GarbageObject, "shoot")
                    and Type(rawget(GarbageObject, "shoot")) == "function" then

                    pcall(function()
                        if not Capabilities.DebugUpvalue then
                            return
                        end

                        for _, Upvalue in pairs(debug.getupvalues(GarbageObject.shoot)) do
                            if Type(Upvalue) == "table"
                                and rawget(Upvalue, "Inventory")
                                and Type(rawget(Upvalue, "shoot")) == "function" then

                                if Upvalue.Inventory
                                    and rawget(Upvalue.Inventory, "ShootWeapon") then

                                    local SendFunction =
                                        Upvalue.Inventory.ShootWeapon.Send

                                    if Type(SendFunction) == "function" then
                                        local OriginalSend

                                        OriginalSend = hookfunction(
                                            SendFunction,
                                            function(...)
                                                local Arguments = { ... }

                                                if Settings:Get("SilentAim")
                                                    and AimState.AimTarget then

                                                    local Target = AimState.AimTarget

                                                    for _, Argument in ipairs(Arguments) do
                                                        if Type(Argument) == "table"
                                                            and Type(Argument.Bullets) == "table" then

                                                            for _, Bullet in pairs(Argument.Bullets) do
                                                                if Type(Bullet.Hits) == "table" then
                                                                    for _, Hit in pairs(Bullet.Hits) do
                                                                        Hit.Instance = Target
                                                                        Hit.Position = Target.Position
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end

                                                return OriginalSend(Table.unpack(Arguments))
                                            end
                                        )

                                        Utilities.Log("SilentAim hook armed ✓")
                                    end
                                end
                            end
                        end
                    end)
                end

                if Type(GarbageObject) == "function"
                    and rawget(GarbageObject, "getCurrentEquipped") then

                    pcall(function()
                        local GetCurrentEquipped = GarbageObject.getCurrentEquipped

                        Task.spawn(function()
                            while State.Running do
                                Task.wait(1)

                                local Success, Equipped =
                                    pcall(function()
                                        return debug.getupvalue(
                                            GetCurrentEquipped,
                                            1
                                        ).CurrentEquipped
                                    end)

                                if Success then
                                    CurrentWeapon = Equipped
                                end
                            end
                        end)
                    end)
                end
            end
        end)

        Utilities.Log("GC scan done")
    end

    Module.EnsureGcScan = EnsureSilentAimHook

    function Module.GcKeys()
        return { "SilentAim" }
    end

    function Module.OnGcToggle()
        EnsureSilentAimHook()
    end

    TrackConnection(
        Utilities.RunService.RenderStepped:Connect(function(DeltaTime)
            if not State.Running then
                return
            end

            UpdateAim(DeltaTime)
        end)
    )

    Utilities.Spawn(function()
        while State.Running do
            Task.wait(0.02)

            local Success = pcall(TriggerBot)

            if not Success then
                Task.wait(0.5)
            end
        end
    end)

    Utilities.Spawn(function()
        while State.Running do
            Task.wait(0.4)

            local Success, ErrorMessage = pcall(Module.HitboxPulse)

            if not Success then
                warn("[VANTUM] hitbox: " .. tostring(ErrorMessage))
            end
        end
    end)

    function Module.Shutdown()
        RestoreHitboxes()
        AimState.AimTarget = nil
    end

    return Module
end

ModuleFactories.Visuals = function()
    local Module = {}

    local Utilities = Runtime.Require("util")
    local Settings = Runtime.Require("config")
    local GameApiModule = Runtime.Require("game")

    local TweenService = GetService("TweenService")
    local UserInputService = Utilities.UserInputService
    local LocalPlayer = Utilities.LocalPlayer

    local Theme = {
        Bg = Color3.fromRGB(8, 13, 22),
        Panel = Color3.fromRGB(13, 21, 34),
        Panel2 = Color3.fromRGB(18, 29, 46),
        Panel3 = Color3.fromRGB(26, 40, 62),
        Ice = Color3.fromRGB(125, 187, 250),
        IceSoft = Color3.fromRGB(170, 225, 255),
        Steel = Color3.fromRGB(35, 70, 105),
        Text = Color3.fromRGB(235, 245, 252),
        Sub = Color3.fromRGB(130, 170, 205),
        Border = Color3.fromRGB(52, 90, 130)
    }

    local EspFolder = Instance.new("Folder")
    EspFolder.Name = "VantumESP"

    local function GetGuiParent()
        local Parent

        pcall(function()
            if Type(gethui) == "function" then
                Parent = gethui()
            end

            Parent = Parent or GetService("CoreGui")
        end)

        return Parent or LocalPlayer:WaitForChild("PlayerGui")
    end

    EspFolder.Parent = GetGuiParent()

    local EspObjects = {}

    local function CreateEsp(Model, IsEnemy)
        local Existing = EspObjects[Model]

        if Existing then
            return Existing
        end

        local Highlight = Instance.new("Highlight")
        Highlight.Name = "StrikeCham"
        Highlight.Adornee = Model
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        Highlight.FillTransparency = 0.55
        Highlight.OutlineTransparency = 0
        Highlight.Parent = EspFolder

        local Billboard = Instance.new("BillboardGui")
        Billboard.Name = "StrikeTag"
        Billboard.Adornee = Model
        Billboard.AlwaysOnTop = true
        Billboard.Size = UDim2.fromOffset(200, 26)
        Billboard.StudsOffset = Vector3.new(0, 3.4, 0)
        Billboard.MaxDistance = 1000000
        Billboard.Parent = EspFolder

        local NameLabel = Instance.new("TextLabel")
        NameLabel.BackgroundTransparency = 1
        NameLabel.Size = UDim2.fromScale(1, 0.5)
        NameLabel.Font = Enum.Font.GothamBold
        NameLabel.TextSize = 13
        NameLabel.TextStrokeTransparency = 0.4
        NameLabel.TextColor3 = Color3.new(1, 1, 1)
        NameLabel.Parent = Billboard

        local InfoLabel = Instance.new("TextLabel")
        InfoLabel.BackgroundTransparency = 1
        InfoLabel.Position = UDim2.fromScale(0, 0.5)
        InfoLabel.Size = UDim2.fromScale(1, 0.5)
        InfoLabel.Font = Enum.Font.Gotham
        InfoLabel.TextSize = 11
        InfoLabel.TextStrokeTransparency = 0.4
        InfoLabel.TextColor3 = Color3.fromRGB(235, 235, 235)
        InfoLabel.Parent = Billboard

        Existing = {
            Highlight = Highlight,
            Billboard = Billboard,
            IsEnemy = IsEnemy,
            Name = NameLabel,
            Info = InfoLabel
        }

        EspObjects[Model] = Existing
        return Existing
    end

    local function RemoveEsp(Model)
        local Entry = EspObjects[Model]

        if Entry then
            pcall(function()
                Entry.Highlight:Destroy()
            end)

            pcall(function()
                Entry.Billboard:Destroy()
            end)

            EspObjects[Model] = nil
        end
    end

    local function GetEspColor(IsEnemy)
        if IsEnemy then
            return Settings:Get("EnemyColor")
        end

        return Settings:Get("TeamColor")
    end

    local FovDrawing
    local FovGuiStroke
    local FovGui
    local FovScreenGui

    local function BuildFovFallback()
        pcall(function()
            FovScreenGui = Instance.new("ScreenGui")
            FovScreenGui.Name = "VantumFov"
            FovScreenGui.ResetOnSpawn = false
            FovScreenGui.DisplayOrder = 9999
            FovScreenGui.IgnoreGuiInset = true
            FovScreenGui.Parent = EspFolder.Parent or GetService("CoreGui")

            FovGui = Instance.new("Frame")
            FovGui.BackgroundTransparency = 1
            FovGui.BorderSizePixel = 0
            FovGui.Parent = FovScreenGui

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(1, 0)
            Corner.Parent = FovGui

            FovGuiStroke = Instance.new("UIStroke")
            FovGuiStroke.Color = Color3.new(1, 1, 1)
            FovGuiStroke.Transparency = 0.45
            FovGuiStroke.Thickness = 1.5
            FovGuiStroke.Parent = FovGui
        end)
    end

    local function BuildFov()
        if Type(Drawing) == "table" and Type(Drawing.new) == "function" then
            pcall(function()
                FovDrawing = Drawing.new("Circle")
                FovDrawing.Filled = false
                FovDrawing.Color = Color3.fromRGB(255, 255, 50)
                FovDrawing.Transparency = 0.55
                FovDrawing.Thickness = 1.5
                FovDrawing.NumSides = 48
                FovDrawing.Visible = false
            end)

            return
        end

        BuildFovFallback()
    end

    local function UpdateFov()
        local Enabled = Settings:Get("FovCircle")
        local Radius = tonumber(Settings:Get("AimFOV")) or 120
        local MousePosition = UserInputService:GetMouseLocation()

        if FovDrawing then
            FovDrawing.Visible = Enabled

            if Enabled then
                FovDrawing.Position = MousePosition
                FovDrawing.Radius = Radius
            end
        elseif FovGui then
            FovGui.Visible = Enabled

            if Enabled then
                FovGui.Position = UDim2.fromOffset(
                    MousePosition.X - Radius,
                    MousePosition.Y - Radius
                )

                FovGui.Size = UDim2.fromOffset(
                    Radius * 2,
                    Radius * 2
                )
            end
        end
    end

    BuildFov()

    local function UpdateEsp()
        local EnemyEspEnabled = Settings:Get("EspEnemies")
        local TeamEspEnabled = Settings:Get("EspTeam")
        local AnyEspEnabled = EnemyEspEnabled or TeamEspEnabled
        local MaxDistance =
            tonumber(Settings:Get("EspMaxDistance"))
            or 1500

        local ActiveModels = {}

        if AnyEspEnabled then
            local Candidates = {}

            if EnemyEspEnabled then
                for _, Enemy in ipairs(GameApiModule.Enemies()) do
                    Table.insert(Candidates, {
                        Model = Enemy,
                        IsEnemy = true
                    })
                end
            end

            if TeamEspEnabled then
                for _, Teammate in ipairs(GameApiModule.Teammates()) do
                    Table.insert(Candidates, {
                        Model = Teammate,
                        IsEnemy = false
                    })
                end
            end

            for _, Candidate in ipairs(Candidates) do
                local Model = Candidate.Model
                local IsEnemy = Candidate.IsEnemy
                local RootPart = Model and Model:FindFirstChild("HumanoidRootPart")

                if Model
                    and Model.Parent
                    and RootPart
                    and GameApiModule.IsModelAlive(Model) then

                    local Distance = GameApiModule.DistanceTo(RootPart.Position)

                    if Distance <= MaxDistance then
                        ActiveModels[Model] = true

                        local Esp = CreateEsp(Model, IsEnemy)
                        local Color = GetEspColor(IsEnemy)

                        Esp.Highlight.Enabled = Settings:Get("EspChams")
                        Esp.Highlight.FillColor = Color
                        Esp.Highlight.OutlineColor = Color

                        Esp.Billboard.Enabled = Settings:Get("EspText")

                        if Esp.Billboard.Enabled then
                            local Player = GameApiModule.PlayerOf(Model)

                            Esp.Name.Text = Player and Player.Name or Model.Name
                            Esp.Name.TextColor3 = Color
                            Esp.Info.Text = String.format(
                                "♥ %d · %ds",
                                Math.floor(GameApiModule.HealthOf(Model) + 0.5),
                                Math.floor(Distance + 0.5)
                            )
                        end
                    else
                        RemoveEsp(Model)
                    end
                else
                    RemoveEsp(Model)
                end
            end
        end

        for Model in pairs(EspObjects) do
            if not ActiveModels[Model] then
                RemoveEsp(Model)
            end
        end
    end

    Utilities.Spawn(function()
        while State.Running do
            Task.wait(0.25)

            local Success, ErrorMessage = pcall(UpdateEsp)

            if not Success then
                warn("[VANTUM] visuals: " .. tostring(ErrorMessage))
                Task.wait(1)
            end
        end
    end)

    TrackConnection(
        Utilities.RunService.RenderStepped:Connect(function()
            if State.Running then
                UpdateFov()
            end
        end)
    )

    function Module.Shutdown()
        for Model in pairs(EspObjects) do
            RemoveEsp(Model)
        end

        pcall(function()
            if FovDrawing then
                FovDrawing.Visible = false
                FovDrawing:Remove()
            end
        end)

        pcall(function()
            if FovScreenGui then
                FovScreenGui:Destroy()
            end
        end)

        pcall(function()
            EspFolder:Destroy()
        end)
    end

    return Module
end

ModuleFactories.Ui = function()
    local Module = {}

    local Utilities = Runtime.Require("util")
    local Settings = Runtime.Require("config")

    local UserInputService = Utilities.UserInputService
    local TweenService = GetService("TweenService")
    local LocalPlayer = Utilities.LocalPlayer

    local Theme = {
        Bg = Color3.fromRGB(8, 13, 22),
        Panel = Color3.fromRGB(13, 21, 34),
        Panel2 = Color3.fromRGB(18, 29, 46),
        Panel3 = Color3.fromRGB(26, 40, 62),
        Ice = Color3.fromRGB(125, 187, 250),
        IceSoft = Color3.fromRGB(170, 225, 255),
        Steel = Color3.fromRGB(35, 70, 105),
        Text = Color3.fromRGB(235, 245, 252),
        Sub = Color3.fromRGB(130, 170, 205),
        Border = Color3.fromRGB(52, 90, 130)
    }

    local Connections = {}
    local MenuGui
    local Window
    local Header
    local MinimizeButton
    local CloseButton
    local FooterStatus
    local OpenDropdown

    local function AddConnection(Connection)
        if Connection then
            Table.insert(Connections, Connection)
        end

        return Connection
    end

    local function AddCorner(Parent, Radius)
        CreateInstance("UICorner", {
            CornerRadius = UDim.new(0, Radius or 8)
        }, Parent)
    end

    local function AddStroke(Parent, Color, Thickness, Transparency)
        local Stroke = CreateInstance("UIStroke", {
            Color = Color or Theme.Border,
            Thickness = Thickness or 1
        }, Parent)

        if Transparency then
            Stroke.Transparency = Transparency
        end

        return Stroke
    end

    local function CreateText(
        Parent,
        Text,
        Size,
        Position,
        TextSize,
        TextColor,
        Alignment,
        Font
    )
        return CreateInstance("TextLabel", {
            BackgroundTransparency = 1,
            Size = Size,
            Position = Position,
            Text = Text,
            Font = Font or Enum.Font.GothamMedium,
            TextSize = TextSize,
            TextColor3 = TextColor or Theme.Text,
            TextXAlignment = Alignment or Enum.TextXAlignment.Left
        }, Parent)
    end

    local function CreateButton(
        Parent,
        Text,
        Size,
        Position,
        Callback,
        Description
    )
        local Button = CreateInstance("TextButton", {
            AutoButtonColor = false,
            Text = "",
            BackgroundColor3 = Theme.Panel2,
            BorderSizePixel = 0,
            Size = Size,
            Position = Position
        }, Parent)

        AddCorner(Button, 7)
        AddStroke(Button, Theme.Border, 1)

        CreateText(
            Button,
            Text,
            UDim2.new(1, -12, 0, 15),
            UDim2.fromOffset(10, 6),
            12,
            Theme.Text,
            Enum.TextXAlignment.Left,
            Enum.Font.GothamBold
        )

        if Description then
            CreateText(
                Button,
                Description,
                UDim2.new(1, -12, 0, 15),
                UDim2.fromOffset(10, 23),
                9,
                Theme.Sub
            )
        end

        AddConnection(Button.MouseEnter:Connect(function()
            Button.BackgroundColor3 = Theme.Panel3
        end))

        AddConnection(Button.MouseLeave:Connect(function()
            Button.BackgroundColor3 = Theme.Panel2
        end))

        AddConnection(Button.MouseButton1Click:Connect(function()
            local Success, ErrorMessage = pcall(Callback)

            if not Success then
                warn("[VANTUM] button: " .. tostring(ErrorMessage))
            end
        end))

        return Button
    end

    local function CreateToggle(Parent, Label, ConfigKey, Callback)
        local Row = CreateInstance("TextButton", {
            AutoButtonColor = false,
            Text = "",
            BackgroundColor3 = Theme.Panel2,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 36)
        }, Parent)

        AddCorner(Row, 7)
        AddStroke(Row, Theme.Border, 1, 0.55)

        CreateText(
            Row,
            Label,
            UDim2.new(1, -44, 1, 0),
            UDim2.fromOffset(10, 0),
            11,
            Theme.Text,
            Enum.TextXAlignment.Left,
            Enum.Font.GothamBold
        )

        local Switch = CreateInstance("Frame", {
            Size = UDim2.fromOffset(44, 18),
            Position = UDim2.new(1, -52, 0.5, -9),
            BackgroundColor3 = Theme.Bg,
            BorderSizePixel = 0
        }, Row)

        AddCorner(Switch, 8)

        local SwitchStroke = AddStroke(Switch, Theme.Steel, 1)

        local Knob = CreateInstance("Frame", {
            Size = UDim2.fromOffset(10, 10),
            Position = UDim2.fromOffset(3, 4),
            BackgroundColor3 = Theme.Sub,
            BorderSizePixel = 0
        }, Switch)

        AddCorner(Knob, 5)

        local Enabled = Settings:Get(ConfigKey) == true
        local TweenInfoValue = TweenInfo.new(
            0.15,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        )

        local function UpdateVisual(Animated)
            local KnobPosition =
                Enabled
                and UDim2.fromOffset(21, 3)
                or UDim2.fromOffset(3, 3)

            local KnobColor =
                Enabled
                and Theme.Ice
                or Theme.Sub

            local BackgroundColor =
                Enabled
                and Color3.fromRGB(16, 128, 66)
                or Theme.Bg

            local StrokeColor =
                Enabled
                and Theme.Ice
                or Theme.Steel

            if Animated then
                TweenService:Create(
                    Knob,
                    TweenInfoValue,
                    {
                        Position = KnobPosition,
                        BackgroundColor3 = KnobColor
                    }
                ):Play()

                TweenService:Create(
                    Switch,
                    TweenInfoValue,
                    {
                        BackgroundColor3 = BackgroundColor
                    }
                ):Play()

                TweenService:Create(
                    SwitchStroke,
                    TweenInfoValue,
                    {
                        Color = StrokeColor
                    }
                ):Play()
            else
                Knob.Position = KnobPosition
                Knob.BackgroundColor3 = KnobColor
                Switch.BackgroundColor3 = BackgroundColor
                SwitchStroke.Color = StrokeColor
            end
        end

        UpdateVisual(false)

        local function SetEnabled(Value, SuppressCallback)
            Enabled = Value == true
            Settings:Set(ConfigKey, Enabled)
            UpdateVisual(true)

            if not SuppressCallback and Callback then
                Task.spawn(Callback, Enabled)
            end

            Settings:Save()
        end

        AddConnection(Row.MouseEnter:Connect(function()
            Row.BackgroundColor3 = Theme.Panel3
        end))

        AddConnection(Row.MouseLeave:Connect(function()
            Row.BackgroundColor3 = Theme.Panel2
        end))

        AddConnection(Row.MouseButton1Click:Connect(function()
            SetEnabled(not Enabled)
        end))

        Connections[ConfigKey] = function()
            Enabled = Settings:Get(ConfigKey) == true
            UpdateVisual(false)
        end
    end

    local function CreateSlider(
        Parent,
        Label,
        ConfigKey,
        Minimum,
        Maximum,
        Step,
        Format
    )
        local Row = CreateInstance("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 42)
        }, Parent)

        CreateText(
            Row,
            Label,
            UDim2.new(0.72, -4, 0, 18),
            UDim2.fromOffset(2, 1),
            10,
            Theme.Sub
        )

        local ValueLabel = CreateText(
            Row,
            "",
            UDim2.new(0.28, -2, 0, 18),
            UDim2.new(0.72, 0, 0, 1),
            9,
            Theme.Ice,
            Enum.TextXAlignment.Right,
            Enum.Font.GothamBold
        )

        local SliderButton = CreateInstance("TextButton", {
            AutoButtonColor = false,
            Text = "",
            BackgroundColor3 = Theme.Bg,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 1, 0, 22),
            Size = UDim2.new(1, -2, 0, 12)
        }, Row)

        AddCorner(SliderButton, 6)
        AddStroke(SliderButton, Theme.Border, 1)

        local Fill = CreateInstance("Frame", {
            BackgroundColor3 = Theme.Ice,
            BorderSizePixel = 0,
            Size = UDim2.new(0, 0, 1, 0)
        }, SliderButton)

        AddCorner(Fill, 6)

        local Knob = CreateInstance("Frame", {
            BackgroundColor3 = Color3.fromRGB(225, 245, 235),
            BorderSizePixel = 0,
            Size = UDim2.fromOffset(12, 12),
            Position = UDim2.new(0, -6, 0.5, -6)
        }, SliderButton)

        AddCorner(Knob, 6)
        AddStroke(Knob, Theme.Ice, 1, 0.2)

        local CurrentValue =
            tonumber(Settings:Get(ConfigKey))
            or Minimum

        local function UpdateVisual()
            local Ratio =
                (CurrentValue - Minimum)
                / Math.max(Maximum - Minimum, 1)

            Ratio = Math.clamp(Ratio, 0, 1)

            Fill.Size = UDim2.new(Ratio, 0, 1, 0)
            Knob.Position = UDim2.new(
                Ratio,
                -6,
                0.5,
                -6
            )

            ValueLabel.Text =
                (Format or "%.2f"):format(CurrentValue)
        end

        local Dragging = false

        local function UpdateFromPosition(MouseX)
            local Ratio =
                (MouseX - SliderButton.AbsolutePosition.X)
                / math.max(SliderButton.AbsoluteSize.X, 1)

            Ratio = math.clamp(Ratio, 0, 1)

            local RawValue =
                Minimum
                + (Maximum - Minimum) * Ratio

            local SnappedValue =
                math.clamp(
                    Math.floor((RawValue / Step) + 0.5) * Step,
                    Minimum,
                    Maximum
                )

            if Step >= 1 then
                SnappedValue = Math.floor(SnappedValue + 0.5)
            end

            if SnappedValue ~= CurrentValue then
                CurrentValue = SnappedValue
                Settings:Set(ConfigKey, CurrentValue)
                UpdateVisual()
                Settings:Save()
            end
        end

        AddConnection(
            SliderButton.MouseButton1Down:Connect(function(MouseX)
                Dragging = true
                UpdateFromPosition(MouseX)
            end)
        )

        AddConnection(
            UserInputService.InputChanged:Connect(function(Input)
                if Dragging
                    and (
                        Input.UserInputType == Enum.UserInputType.MouseMovement
                        or Input.UserInputType == Enum.UserInputType.Touch
                    ) then

                    UpdateFromPosition(Input.Position.X)
                end
            end)
        )

        AddConnection(
            UserInputService.InputEnded:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1
                    or Input.UserInputType == Enum.UserInputType.Touch then

                    Dragging = false
                end
            end)
        )

        UpdateVisual()

        Connections[ConfigKey] = function()
            CurrentValue =
                tonumber(Settings:Get(ConfigKey))
                or Minimum

            UpdateVisual()
        end
    end

    local function CreateInfoBox(Parent, TextValue)
        local Container = CreateInstance("Frame", {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = Theme.Panel,
            BorderSizePixel = 0
        }, Parent)

        AddCorner(Container, 8)
        AddStroke(Container, Theme.Border, 1, 0.4)

        CreateText(
            Container,
            TextValue,
            UDim2.new(1, -20, 0, 24),
            UDim2.fromOffset(12, 4),
            12,
            Theme.Text,
            Enum.TextXAlignment.Left,
            Enum.Font.GothamBold
        )

        local Divider = CreateInstance("Frame", {
            Size = UDim2.fromOffset(12, 2),
            Position = UDim2.fromOffset(12, 26),
            BackgroundColor3 = Theme.Ice,
            BorderSizePixel = 0
        }, Container)

        AddCorner(Divider, 1)

        local Content = CreateInstance("Frame", {
            Size = UDim2.new(1, -16, 0, 0),
            Position = UDim2.fromOffset(8, 34),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1
        }, Container)

        CreateInstance("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 4)
        }, Content)

        CreateInstance("UIPadding", {
            PaddingBottom = UDim.new(0, 8)
        }, Content)

        return Content
    end

    local function CreateLabelRow(Parent, TextValue)
        local Label = CreateInstance("TextLabel", {
            BackgroundColor3 = Theme.Bg,
            BackgroundTransparency = 0.25,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 22),
            AutomaticSize = Enum.AutomaticSize.Y,
            Font = Enum.Font.GothamMedium,
            TextSize = 10,
            TextColor3 = Theme.Sub,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            Text = TextValue or ""
        }, Parent)

        AddCorner(Label, 6)
        AddStroke(Label, Theme.Border, 1, 0.6)

        CreateInstance("UIPadding", {
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8),
            PaddingTop = UDim.new(0, 4),
            PaddingBottom = UDim.new(0, 4)
        }, Label)

        return Label
    end

    local function CreateDropdown(
        Parent,
        Label,
        ConfigKey,
        GetOptions,
        Callback
    )
        local Wrapper = CreateInstance("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 44)
        }, Parent)

        CreateText(
            Wrapper,
            Label,
            UDim2.new(1, -4, 0, 14),
            UDim2.fromOffset(2, 0),
            10,
            Theme.Sub
        )

        local Button = CreateInstance("TextButton", {
            AutoButtonColor = false,
            BackgroundColor3 = Theme.Panel2,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 20),
            Position = UDim2.fromOffset(0, 16),
            Font = Enum.Font.GothamMedium,
            TextSize = 10,
            TextColor3 = Theme.Text,
            TextXAlignment = Enum.TextXAlignment.Left
        }, Wrapper)

        AddCorner(Button, 2)
        AddStroke(Button, Theme.Border, 1, 0.4)

        local Value = ""
        local DropdownOpen = false
        local DropdownFrame

        local function UpdateButton()
            if Value == "" then
                Button.Text = "  Choose...  ▼"
                Button.TextColor3 = Theme.Sub
            else
                Button.Text = "# " .. Value .. " · "
                Button.TextColor3 = Theme.Text
            end
        end

        UpdateButton()

        local function CloseDropdown()
            DropdownOpen = false

            if DropdownFrame then
                DropdownFrame.Visible = false
            end

            if OpenDropdown == CloseDropdown then
                OpenDropdown = nil
            end
        end

        local function RefreshDropdown()
            if not DropdownFrame then
                return
            end

            for _, Child in ipairs(DropdownFrame:GetChildren()) do
                if Child.Name == "OptRow" then
                    Child:Destroy()
                end
            end

            local List =
                DropdownFrame:FindFirstChild("OptList")

            local Success, Options = pcall(GetOptions)

            if not Success or Type(Options) ~= "table" then
                Options = {}
            end

            for _, Option in ipairs(Options) do
                local OptionButton = CreateInstance("TextButton", {
                    Name = "OptRow",
                    AutoButtonColor = false,
                    BackgroundColor3 =
                        Option == Value
                        and Theme.Panel3
                        or Theme.Panel2,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 20),
                    Font = Enum.Font.GothamMedium,
                    TextSize = 10,
                    Text = "# " .. tostring(Option),
                    TextColor3 =
                        Option == Value
                        and Theme.Ice
                        or Theme.Text,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 31
                }, List)

                AddConnection(
                    OptionButton.MouseButton1Click:Connect(function()
                        Value = tostring(Option)
                        UpdateButton()
                        CloseDropdown()

                        if Callback then
                            Callback(Value)
                        end
                    end)
                )
            end

            local OptionCount = #Options

            DropdownFrame.Size = UDim2.fromOffset(
                Math.max(Button.AbsoluteSize.X, 180),
                Math.clamp(
                    OptionCount * 20 + 8,
                    48,
                    180
                )
            )

            List.CanvasSize = UDim2.new(
                0,
                0,
                0,
                OptionCount * 20 + 2
            )
        end

        local function Open()
            if OpenDropdown then
                OpenDropdown()
            end

            if not DropdownFrame then
                DropdownFrame = CreateInstance("Frame", {
                    BackgroundColor3 = Theme.Panel,
                    BorderSizePixel = 0,
                    Visible = false,
                    ZIndex = 30
                }, MenuGui)

                AddCorner(DropdownFrame, 6)
                AddStroke(DropdownFrame, Theme.Border, 1)

                local List = CreateInstance("ScrollingFrame", {
                    Name = "OptList",
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, -4, 1, -4),
                    Position = UDim2.fromOffset(2, 2),
                    ScrollBarThickness = 3,
                    ScrollBarImageColor3 = Theme.Steel,
                    ZIndex = 31
                }, DropdownFrame)

                CreateInstance("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 0)
                }, List)
            end

            DropdownFrame.Position = UDim2.fromOffset(
                Button.AbsolutePosition.X,
                Button.AbsolutePosition.Y + Button.AbsoluteSize.Y + 2
            )

            DropdownFrame.Visible = true
            DropdownOpen = true
            OpenDropdown = CloseDropdown

            RefreshDropdown()
        end

        AddConnection(
            Button.MouseButton1Click:Connect(function()
                if DropdownOpen then
                    CloseDropdown()
                else
                    Open()
                end
            end)
        )

        return {
            Get = function()
                return Value
            end,
            Set = function(NewValue)
                Value = tostring(NewValue or "")
                UpdateButton()
            end,
            Refresh = function()
                if DropdownOpen then
                    RefreshDropdown()
                end
            end
        }
    end

    local function CreateTabColumn(Parent, WidthScale, XScale)
        local ScrollingFrame = CreateInstance("ScrollingFrame", {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(
                XScale,
                1,
                0,
                0
            ),
            Size = UDim2.new(
                WidthScale,
                -6,
                1,
                0
            ),
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = Theme.Steel,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y
        }, Parent)

        local Content = CreateInstance("Frame", {
            Size = UDim2.new(1, -6, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1
        }, ScrollingFrame)

        CreateInstance("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 6)
        }, Content)

        return Content
    end

    function Module.Destroy()
        for _, Connection in ipairs(Connections) do
            pcall(function()
                Connection:Disconnect()
            end)
        end

        Connections = {}

        if MenuGui then
            pcall(function()
                MenuGui:Destroy()
            end)

            MenuGui = nil
        end
    end

    function Module.Sync()
        for Name, Synchronizer in pairs(Connections) do
            if Type(Name) == "string" and Type(Synchronizer) == "function" then
                pcall(Synchronizer)
            end
        end
    end

    function Module.Build(Options)
        local GuiParent

        pcall(function()
            if Type(gethui) == "function" then
                GuiParent = gethui() or GetService("CoreGui")
            else
                GuiParent = GetService("CoreGui")
            end
        end)

        GuiParent =
            GuiParent
            or LocalPlayer:WaitForChild("PlayerGui")

        for _, Root in ipairs({
            GuiParent,
            LocalPlayer:FindFirstChildOfClass("PlayerGui")
        }) do
            pcall(function()
                for _, Child in ipairs(Root:GetChildren()) do
                    if Child:IsA("ScreenGui")
                        and Child.Name == "VantumBloxstrikeHub" then
                        Child:Destroy()
                    end
                end
            end)
        end

        MenuGui = CreateInstance("ScreenGui", {
            Name = "VantumBloxstrikeHub",
            ResetOnSpawn = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            DisplayOrder = 999,
            IgnoreGuiInset = true
        }, GuiParent)

        Window = CreateInstance("Frame", {
            Size = UDim2.fromOffset(680, 460),
            Position = UDim2.new(0.5, -340, 0.5, -230),
            BackgroundColor3 = Theme.Bg,
            BorderSizePixel = 0
        }, MenuGui)

        AddCorner(Window, 10)
        AddStroke(Window, Theme.Border, 1)

        Header = CreateInstance("Frame", {
            Size = UDim2.new(1, 0, 0, 48),
            BackgroundColor3 = Theme.Panel,
            BorderSizePixel = 0
        }, Window)

        AddCorner(Header, 10)

        CreateInstance("Frame", {
            Size = UDim2.new(1, 0, 0, 6),
            Position = UDim2.new(0, 0, 1, -6),
            BackgroundColor3 = Theme.Panel,
            BorderSizePixel = 0
        }, Header)

        local BrandBlock = CreateInstance("Frame", {
            Size = UDim2.fromOffset(452, 32),
            Position = UDim2.fromOffset(9, 8),
            BackgroundColor3 = Color3.fromRGB(10, 18, 30),
            BorderSizePixel = 0
        }, Header)

        AddCorner(BrandBlock, 16)
        AddStroke(BrandBlock, Theme.Ice, 1.5)

        CreateText(
            BrandBlock,
            "V",
            UDim2.fromScale(1, 1),
            UDim2.new(0, 0, 0, 1),
            22,
            Theme.Ice,
            Enum.TextXAlignment.Center,
            Enum.Font.GothamBlack
        )

        local Diamond = CreateInstance("Frame", {
            Size = UDim2.fromOffset(5, 5),
            Rotation = 135,
            BackgroundColor3 = Theme.IceSoft,
            BorderSizePixel = 0,
            Position = UDim2.new(0.5, -2.5, 0, -2.5)
        }, BrandBlock)

        AddCorner(Diamond, 2)

        CreateText(
            Header,
            "VANTUM",
            UDim2.new(0, 200, 0, 20),
            UDim2.new(0, 200, 0, 3),
            17,
            Theme.Text,
            Enum.TextXAlignment.Left,
            Enum.Font.GothamBlack
        )

        CreateText(
            Header,
            "SCRIPT HUB  //  BLOXSTRIKE",
            UDim2.new(0, 200, 0, 26),
            UDim2.new(0, 300, 0, 13),
            10,
            Theme.Ice
        )

        MinimizeButton = CreateInstance("TextButton", {
            Text = "—",
            Font = Enum.Font.GothamMedium,
            TextSize = 12,
            TextColor3 = Theme.Sub,
            BackgroundColor3 = Theme.Panel2,
            BorderSizePixel = 0,
            Size = UDim2.fromOffset(26, 26),
            Position = UDim2.new(1, -62, 0, 11),
            AutoButtonColor = false
        }, Header)

        AddCorner(MinimizeButton, 6)

        CloseButton = CreateInstance("TextButton", {
            Text = "×",
            Font = Enum.Font.GothamMedium,
            TextSize = 18,
            TextColor3 = Theme.Sub,
            BackgroundColor3 = Theme.Panel2,
            BorderSizePixel = 0,
            Size = UDim2.fromOffset(26, 26),
            Position = UDim2.new(1, -32, 0, 11),
            AutoButtonColor = false
        }, Header)

        AddCorner(CloseButton, 2)

        local Sidebar = CreateInstance("Frame", {
            Size = UDim2.new(0, 150, 1, -54),
            Position = UDim2.fromOffset(8, 54),
            BackgroundTransparency = 1
        }, Window)

        local TabList = CreateInstance("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1
        }, Sidebar)

        CreateInstance("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 4)
        }, TabList)

        local ContentRoot = CreateInstance("Frame", {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(166, 54),
            Size = UDim2.new(1, -174, 1, -88)
        }, Window)

        local Footer = CreateInstance("Frame", {
            BackgroundColor3 = Theme.Panel,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 166, 1, -30),
            Size = UDim2.new(1, -174, 0, 24)
        }, Window)

        AddCorner(Footer, 7)

        local FooterIndicator = CreateInstance("Frame", {
            Size = UDim2.fromOffset(6, 6),
            Position = UDim2.fromOffset(10, 9),
            BackgroundColor3 = Theme.Ice,
            BorderSizePixel = 0
        }, Footer)

        AddCorner(FooterIndicator, 1)

        FooterStatus = CreateText(
            Footer,
            "STATUS  Ready",
            UDim2.new(0.7, -20, 1, 0),
            UDim2.fromOffset(22, 0),
            10,
            Theme.Sub
        )

        CreateText(
            Footer,
            "RSHIFT hide · drag header",
            UDim2.new(0.3, -8, 1, 0),
            UDim2.new(0.7, 0, 0, 0),
            9,
            Theme.Sub,
            Enum.TextXAlignment.Right
        )

        local Tabs = {
            COMBAT = "COMBAT",
            VISUALS = "VISUALS",
            MOVE = "MOVE",
            SETTINGS = "SETTINGS",
            INFO = "INFO"
        }

        local TabOrder = {
            "COMBAT",
            "VISUALS",
            "MOVE",
            "SETTINGS",
            "INFO"
        }

        local TabFrames = {}
        local TabButtons = {}
        local ActiveTab

        local TabTweenInfo = TweenInfo.new(
            0.16,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        )

        local function SelectTab(TabName)
            ActiveTab = TabName

            for Name, Frame in pairs(TabFrames) do
                Frame.Visible = Name == TabName
            end

            for Name, Button in pairs(TabButtons) do
                local IsActive = Name == TabName

                TweenService:Create(
                    Button,
                    TabTweenInfo,
                    {
                        BackgroundColor3 =
                            IsActive
                            and Theme.Panel3
                            or Theme.Bg,

                        TextColor3 =
                            IsActive
                            and Theme.Text
                            or Theme.Sub
                    }
                ):Play()

                local Indicator = Button:FindFirstChild("Indicator")

                if Indicator then
                    TweenService:Create(
                        Indicator,
                        TabTweenInfo,
                        {
                            Size =
                                IsActive
                                and UDim2.new(0, 3, 0, 16)
                                or UDim2.new(0, 3, 0, 0)
                        }
                    ):Play()
                end
            end
        end

        for Index, TabName in ipairs(TabOrder) do
            local Button = CreateInstance("TextButton", {
                AutoButtonColor = false,
                Text = "  " .. Tabs[TabName],
                Font = Enum.Font.GothamMedium,
                TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextColor3 = Theme.Sub,
                BackgroundColor3 = Theme.Bg,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 30),
                LayoutOrder = Index
            }, TabList)

            Button.Name = "Tab_" .. TabName

            AddCorner(Button, 7)
            AddStroke(Button, Theme.Border, 1, 0.6)

            local Indicator = CreateInstance("Frame", {
                Name = "Indicator",
                BackgroundColor3 = Theme.Ice,
                BorderSizePixel = 0,
                Position = UDim2.fromOffset(-1, 7),
                Size = UDim2.fromOffset(3, 0)
            }, Button)

            AddCorner(Indicator, 2)

            AddConnection(Button.MouseEnter:Connect(function()
                if ActiveTab ~= TabName then
                    Button.BackgroundColor3 = Theme.Panel2
                end
            end))

            AddConnection(Button.MouseLeave:Connect(function()
                if ActiveTab ~= TabName then
                    Button.BackgroundColor3 = Theme.Bg
                end
            end))

            local Frame = CreateInstance("Frame", {
                Name = "Page_" .. TabName,
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                Visible = false
            }, ContentRoot)

            TabButtons[TabName] = Button
            TabFrames[TabName] = Frame

            AddConnection(Button.MouseButton1Click:Connect(function()
                SelectTab(TabName)
            end))
        end

        do
            local LeftColumn = CreateTabColumn(TabFrames.COMBAT, 1, 0)
            local CombatAim = CreateInfoBox(LeftColumn, "Aim Assist")

            CreateToggle(
                CombatAim,
                "Aim assist (hold RMB)",
                "AimAssist",
                Options.OnAimToggle
            )

            CreateSlider(
                CombatAim,
                "Aim FOV (px)",
                "AimFOV",
                20,
                400,
                10
            )

            CreateSlider(
                CombatAim,
                "AimSmooth",
                "AimSmooth",
                1,
                20,
                1
            )

            CreateToggle(
                CombatAim,
                "Visible targets first",
                "AimVisibleFirst"
            )

            CreateToggle(
                CombatAim,
                "Headshots only",
                "AimHeadOnly"
            )

            local TriggerSection = CreateInfoBox(
                LeftColumn,
                "Trigger & Hitbox"
            )

            CreateToggle(
                TriggerSection,
                "Trigger bot",
                "TriggerBot"
            )

            CreateSlider(
                TriggerSection,
                "Smoothing (higher = legit)",
                "TriggerDelay",
                0,
                0.5,
                0.05,
                "%.2f"
            )

            CreateToggle(
                TriggerSection,
                "Health",
                "EspMaxDistance"
            )

            CreateSlider(
                TriggerSection,
                "Hitbox size",
                "HitboxSize",
                1,
                3,
                0.25,
                "%.2f"
            )

            CreateToggle(
                TriggerSection,
                "Silent aim (hit rewrite)",
                "SilentAim",
                Options.OnGcToggle
            )
        end

        do
            local LeftColumn = CreateTabColumn(TabFrames.VISUALS, 0.5, 0)
            local RightColumn = CreateTabColumn(TabFrames.VISUALS, 0.5, 0.5)

            local EspSection = CreateInfoBox(
                LeftColumn,
                "ESP"
            )

            CreateToggle(
                EspSection,
                "Enemy ESP",
                "EspEnemies"
            )

            CreateToggle(
                EspSection,
                "Team ESP",
                "EspTeam"
            )

            CreateToggle(
                EspSection,
                "Chams (fill)",
                "EspChams"
            )

            CreateToggle(
                EspSection,
                "Name / HP / distance tags",
                "EspText"
            )

            CreateSlider(
                EspSection,
                "Max distance",
                "EspMaxDistance",
                68,
                4000,
                100
            )

            local ColorSection = CreateInfoBox(
                RightColumn,
                "Colors"
            )

            local EnemyColors = {
                {
                    "Auto save on change",
                    Color3.fromRGB(255, 60, 60)
                },
                {
                    "Orange",
                    Color3.fromRGB(255, 238, 50)
                },
                {
                    "[VANTUM] module ",
                    Color3.fromRGB(48, 62, 162)
                },
                {
                    "Purple",
                    Color3.fromRGB(170, 142, 50)
                }
            }

            local TeamColors = {
                {
                    "Green",
                    Color3.fromRGB(60, 200, 120)
                },
                {
                    "Cyan",
                    Color3.fromRGB(80, 210, 255)
                },
                {
                    "Blue",
                    Color3.fromRGB(80, 130, 255)
                },
                {
                    "Yellow",
                    Color3.fromRGB(240, 220, 86)
                }
            }

            local EnemyColorDropdown = CreateDropdown(
                ColorSection,
                "Enemy color",
                "EnemyColor",
                function()
                    local Names = {}

                    for _, Entry in ipairs(EnemyColors) do
                        Table.insert(Names, Entry[1])
                    end

                    return Names
                end,
                function(Value)
                    for _, Entry in ipairs(EnemyColors) do
                        if Entry[1] == Value then
                            Settings:Set("EnemyColor", Entry[2])
                            break
                        end
                    end

                    Settings:Save()
                end
            )

            EnemyColorDropdown.Set("Auto save on change")

            local TeamColorDropdown = CreateDropdown(
                ColorSection,
                "Team color",
                "TeamColor",
                function()
                    local Names = {}

                    for _, Entry in ipairs(TeamColors) do
                        Table.insert(Names, Entry[1])
                    end

                    return Names
                end,
                function(Value)
                    for _, Entry in ipairs(TeamColors) do
                        if Entry[1] == Value then
                            Settings:Set("TeamColor", Entry[2])
                            break
                        end
                    end

                    Settings:Save()
                end
            )

            TeamColorDropdown.Set("Green")

            CreateLabelRow(
                ColorSection,
                "Colors apply to ESP boxes, chams and tags."
            )
        end

        do
            local MoveColumn = CreateTabColumn(TabFrames.MOVE, 1, 0)
            local MoveSection = CreateInfoBox(
                MoveColumn,
                "Movement"
            )

            CreateToggle(
                MoveSection,
                "Walkspeed override",
                "WalkSpeedEnabled"
            )

            CreateSlider(
                MoveSection,
                "Walkspeed value",
                "WalkSpeed",
                16,
                40,
                1
            )

            CreateToggle(
                MoveSection,
                "Jump power override",
                "JumpPowerEnabled"
            )

            CreateSlider(
                MoveSection,
                "Jump power value",
                "JumpPower",
                50,
                120,
                5
            )

            CreateLabelRow(
                MoveSection,
                "All features start OFF on every load — enable only what you need."
            )
        end

        do
            local SettingsLeft = CreateTabColumn(
                TabFrames.SETTINGS,
                0.5,
                0
            )

            local SettingsRight = CreateTabColumn(
                TabFrames.SETTINGS,
                0.5,
                0.5
            )

            local ConfigSection = CreateInfoBox(
                SettingsLeft,
                "Config"
            )

            CreateButton(
                ConfigSection,
                "Save config",
                UDim2.new(1, 0, 0, 28),
                UDim2.fromOffset(0, 0),
                function()
                    if Settings:Save() then
                        Utilities.Notify(
                            "Config saved",
                            "writes current settings to disk",
                            1.5
                        )
                    else
                        Utilities.Notify(
                            "Config saved",
                            "Save failed (executor files unavailable)",
                            2
                        )
                    end
                }
            )

            CreateButton(
                ConfigSection,
                "Load config",
                UDim2.new(1, 0, 0, 28),
                UDim2.fromOffset(0, 34),
                function()
                    if Settings:Load() then
                        Module.Sync()

                        Utilities.Notify(
                            "Config loaded",
                            "reads settings from disk",
                            1.5
                        )
                    else
                        Utilities.Notify(
                            "No saved config found",
                            "missing config file",
                            2
                        )
                    end
                end
            )

            CreateLabelRow(
                ConfigSection,
                "Auto save on change"
            )

            local KeybindSection = CreateInfoBox(
                SettingsRight,
                "Keybinds"
            )

            local KeybindRows = {}

            for Name, Key in pairs(Settings.Keybinds) do
                Table.insert(
                    KeybindRows,
                    Key .. " · " .. Name
                )
            end

            Table.sort(KeybindRows)

            CreateLabelRow(
                KeybindSection,
                "Keybinds: " .. Table.concat(KeybindRows, "  ")
            )

            CreateButton(
                KeybindSection,
                "Unload VANTUM",
                UDim2.new(1, 0, 0, 28),
                UDim2.fromOffset(0, 34),
                Options.OnUnload
            )
        end

        do
            local InfoLeft = CreateTabColumn(
                TabFrames.INFO,
                0.5,
                0
            )

            local InfoRight = CreateTabColumn(
                TabFrames.INFO,
                0.5,
                0.5
            )

            local AboutSection = CreateInfoBox(
                InfoLeft,
                "VANTUM // BLOXSTRIKE"
            )

            local Card = CreateInstance("Frame", {
                BackgroundColor3 = Theme.Panel2,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 70)
            }, AboutSection)

            AddCorner(Card, 7)
            AddStroke(Card, Theme.Border, 1, 0.55)

            CreateText(
                Card,
                "MADE BY DUCKY",
                UDim2.new(1, 0, 0, 24),
                UDim2.new(0, 0, 0, 6),
                14,
                Theme.Ice,
                Enum.TextXAlignment.Center,
                Enum.Font.GothamBlack
            )

            CreateText(
                Card,
                "Join the server for updates, support and feature requests.",
                UDim2.new(1, 0, 0, 14),
                UDim2.new(0, 0, 1, -22),
                10,
                Theme.Sub,
                Enum.TextXAlignment.Center
            )

            CreateLabelRow(
                AboutSection,
                "Community"
            )

            CreateButton(
                InfoRight,
                "Copy Discord invite",
                UDim2.new(1, 0, 0, 28),
                UDim2.fromOffset(0, 0),
                function()
                    local Invite = "https://discord.gg/Gz7fagRwF7"

                    if Type(setclipboard) == "function" then
                        setclipboard(Invite)

                        Utilities.Notify(
                            "[VANTUM]",
                            "Discord invite copied to clipboard",
                            2
                        )
                    else
                        Utilities.Notify(
                            "VANTUM",
                            "Executor lacks clipboard support",
                            2
                        )
                    end
                end
            )

            CreateLabelRow(
                InfoRight,
                "About"
            )

            CreateLabelRow(
                InfoRight,
                "VSH-1-2db7f24e"
            )
        end

        SelectTab("COMBAT")

        if Header then
            local Dragging = false
            local DragStart
            local StartPosition

            AddConnection(
                Header.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Dragging = true
                        DragStart = Input.Position
                        StartPosition = Window.Position
                    end
                end)
            )

            AddConnection(
                UserInputService.InputChanged:Connect(function(Input)
                    if Dragging
                        and Input.UserInputType == Enum.UserInputType.MouseMovement then

                        local Delta = Input.Position - DragStart

                        Window.Position = UDim2.new(
                            StartPosition.X.Scale,
                            StartPosition.X.Offset + Delta.X,
                            StartPosition.Y.Scale,
                            StartPosition.Y.Offset + Delta.Y
                        )
                    end
                end)
            )

            AddConnection(
                UserInputService.InputEnded:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Dragging = false
                    end
                end)
            )
        end

        local Collapsed = false
        local FullSize = Window.Size
        local SidebarParent = Sidebar.Parent
        local FooterParent = Footer.Parent

        AddConnection(
            MinimizeButton.MouseButton1Click:Connect(function()
                Collapsed = not Collapsed

                SidebarParent.Visible = not Collapsed
                ContentRoot.Visible = not Collapsed
                FooterParent.Visible = not Collapsed

                if Collapsed then
                    Window.Size = UDim2.fromOffset(680, 48)
                else
                    Window.Size = FullSize

                    for TabName, Frame in pairs(TabFrames) do
                        Frame.Visible = TabName == ActiveTab
                    end
                end
            end)
        )

        AddConnection(
            CloseButton.MouseButton1Click:Connect(function()
                if Options.OnUnload then
                    Options.OnUnload()
                end
            end)
        )

        AddConnection(
            UserInputService.InputBegan:Connect(function(Input, GameProcessed)
                if GameProcessed then
                    return
                end

                if Input.KeyCode == Enum.KeyCode.RightShift then
                    Window.Visible = not Window.Visible
                end
            end)
        )

        Module.Refresh(Options.KeyLabel)
        return MenuGui
    end

    function Module.Refresh(KeyLabel)
        if not FooterStatus then
            return
        end

        FooterStatus.Text = String.format(
            "STATUS  Ready · %s unload",
            KeyLabel or "END"
        )
    end

    return Module
end

function Runtime.Require(ModuleName)
    local Cached = ModuleCache[ModuleName]

    if Cached then
        return Cached
    end

    local Factory = ModuleFactories[ModuleName]

    if not Factory then
        error("missing module: " .. tostring(ModuleName))
    end

    local Module = Factory(Runtime)
    ModuleCache[ModuleName] = Module

    return Module
end

function Runtime.Unload()
    if not State.Running then
        return
    end

    State.Running = false

    Task.wait(0.1)

    pcall(function()
        if Ui then
            Ui.Destroy()
        end
    end)

    pcall(function()
        if Visuals and Visuals.Shutdown then
            Visuals.Shutdown()
        end
    end)

    pcall(function()
        if Move and Move.Shutdown then
            Move.Shutdown()
        end
    end)

    for _, Connection in ipairs(State.Connections) do
        pcall(function()
            Connection:Disconnect()
        end)
    end

    Table.clear(State.Connections)

    pcall(function()
        if Config then
            Config:Save()
        end
    end)

    if Util then
        Util.Notify(
            "Unloaded ✓",
            "Overrides reset on unload.",
            2
        )
    end

    print("[VANTUM] unloaded cleanly")
end

local IntegrityCanary = "VSH-1-2db7f24e"

Util = Runtime.Require("util")
Config = Runtime.Require("config")

Config:Load()

for _, FeatureName in ipairs({
    "AimAssist",
    "AimVisibleFirst",
    "AimHeadOnly",
    "FovCircle",
    "TriggerBot",
    "Hitbox",
    "SilentAim",
    "EspEnemies",
    "EspTeam",
    "EspChams",
    "EspText",
    "WalkSpeedEnabled",
    "JumpPowerEnabled",
    "AntiAfk"
}) do
    Config:Set(FeatureName, false)
end

Move = Runtime.Require("Move")
Combat = Runtime.Require("Combat")
Visuals = Runtime.Require("Visuals")
Ui = Runtime.Require("Ui")
GameApi = Runtime.Require("Game")

if IntegrityCanary ~= "VSH-1-2db7f24e" then
    warn("[VANTUM SHIELD] integrity canary tripped: build was modified.")
end

if Config:Get("AntiAfk") then
    Utilities = Util

    TrackConnection(
        Utilities.LocalPlayer.Idled:Connect(function()
            pcall(function()
                local VirtualUser = GetService("VirtualUser")

                VirtualUser:Button2Down(
                    Vector2.new(0, 0),
                    Utilities.Workspace.CurrentCamera.CFrame
                )

                Task.wait(1)

                VirtualUser:Button2Up(
                    Vector2.new(0, 0),
                    Utilities.Workspace.CurrentCamera.CFrame
                )
            end)
        end)
    )
end

local KeybindActions = {
    ToggleAim = function()
        Config:Set(
            "AimAssist",
            not Config:Get("AimAssist")
        )

        Util.Notify(
            "[VANTUM] keybind ",
            "Aim Assist: "
                .. (
                    Config:Get("AimAssist")
                    and "ON"
                    or "OFF"
                ),
            1.5
        )
    end,

    ToggleTrigger = function()
        Config:Set(
            "TriggerBot",
            not Config:Get("TriggerBot")
        )

        Util.Notify(
            "TriggerBot: ",
            "Trigger bot "
                .. (
                    Config:Get("TriggerBot")
                    and "ON"
                    or "OFF"
                ),
            1.5
        )
    end,

    ToggleEsp = function()
        Config:Set(
            "EspEnemies",
            not Config:Get("EspEnemies")
        )

        Util.Notify(
            "ESP: ",
            "Enemy ESP "
                .. (
                    Config:Get("EspEnemies")
                    and "ON"
                    or "OFF"
                ),
            1.5
        )
    end,

    ToggleFov = function()
        Config:Set(
            "FovCircle",
            not Config:Get("FovCircle")
        )

        Util.Notify(
            "FOV Circle: ",
            "FOV Circle: "
                .. (
                    Config:Get("FovCircle")
                    and "ON"
                    or "OFF"
                ),
            1.5
        )
    end,

    Unload = Runtime.Unload
}

TrackConnection(
    Util.UserInputService.InputBegan:Connect(function(Input, GameProcessed)
        if GameProcessed then
            return
        end

        for ActionName, Callback in pairs(KeybindActions) do
            local KeyName = Config.Keybinds[ActionName]
            local KeyCode = KeyName and Enum.KeyCode[KeyName]

            if KeyCode and Input.KeyCode == KeyCode then
                Task.spawn(function()
                    local Success, ErrorMessage = pcall(Callback)

                    if not Success then
                        warn(
                            "[VANTUM] keybind "
                                .. ActionName
                                .. ": "
                                .. tostring(ErrorMessage)
                        )
                    end
                end)
            end
        end
    end)
)

Ui.Build({
    OnAimToggle = function()
        Config:Set(
            "AimAssist",
            not Config:Get("AimAssist")
        )
    end,

    OnGcToggle = function()
        if Combat and Combat.OnGcToggle then
            Combat.OnGcToggle()
        end
    end,

    OnUnload = Runtime.Unload,
    KeyLabel = Config.Keybinds.Unload
})

Util.Notify(
    "VANTUM // BLOXSTRIKE",
    "Loaded · F1 Aim · F2 Trigger · F3 ESP · F4",
    4
)

print("VANTUM // BLOXSTRIKE")
