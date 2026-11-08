-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

if not game:IsLoaded() then
	game.Loaded:Wait()
end

while not Players.LocalPlayer do
	task.wait()
end

local localPlayer = Players.LocalPlayer
local genv = getgenv and getgenv() or _G

if genv.RunawaysScriptLoading and genv.RunawaysScriptLoading ~= coroutine.running() then
	while true do
		task.wait(0.1)
		local autoLoot = not genv.RunawaysScriptLoading or genv.AutoLoot

		if not autoLoot then
			autoLoot = os.clock() - (tonumber(genv.RunawaysScriptLoadingAt) or 0) >= 60
		end

		if not autoLoot then
			continue
		end
		break
	end

	local flag = genv.AutoLoot and not genv.AutoLoot.Unloaded

	if flag then
		flag = tostring(genv.RunawaysAutoFarmTransitionToken or "") == "" or genv.RunawaysScriptLoadedTransition == tostring(genv.RunawaysAutoFarmTransitionToken)
	end

	if flag then
		return genv.AutoLoot
	end
end

genv.RunawaysScriptLoading = coroutine.running()
genv.RunawaysScriptLoadingAt = os.clock()
genv.RunawaysScriptLoadingToken = tostring(genv.RunawaysAutoFarmTransitionToken or "")

if genv.RunawaysScriptLoadingToken ~= "" then
	genv.RunawaysScriptLatestTransition = nil

	pcall(function()
		genv.RunawaysScriptLatestTransition = game:GetService("TeleportService"):GetTeleportSetting("RUNAWAYS_AUTO_FARM_TRANSITION")
	end)

	local flag = genv.RunawaysScriptLatestTransition ~= nil

	if flag then
		local runawaysScriptLoadingToken = genv.RunawaysScriptLoadingToken
		flag = tostring(genv.RunawaysScriptLatestTransition) ~= runawaysScriptLoadingToken
	end

	if flag then
		genv.RunawaysScriptLoading = nil
		genv.RunawaysScriptLoadingAt = nil
		genv.RunawaysScriptLoadingToken = nil
		genv.RunawaysScriptLatestTransition = nil
		return genv.AutoLoot
	end

	if genv.RunawaysScriptLoadedTransition == genv.RunawaysScriptLoadingToken and genv.AutoLoot and not genv.AutoLoot.Unloaded then
		genv.RunawaysScriptLoading = nil
		genv.RunawaysScriptLoadingAt = nil
		genv.RunawaysScriptLoadingToken = nil
		genv.RunawaysScriptLatestTransition = nil
		return genv.AutoLoot
	end
end

genv.RunawaysScriptLatestTransition = nil

if genv.AutoLoot and type(genv.AutoLoot.Unload) == "function" then
	genv.RunawaysScriptReloading = true

	pcall(function()
		genv.AutoLoot:Unload()
	end)

	genv.RunawaysScriptReloading = nil
end

local data = ReplicatedStorage:WaitForChild("Data")
local FlowClient = require(ReplicatedStorage:WaitForChild("FlowClient"))
local module = require(data)
local luck = require(ReplicatedStorage:WaitForChild("Packages")).Utility.Luck
local Data = FlowClient.Loot and require(data:WaitForChild("Loot"):WaitForChild("Data")) or {}
local loot = FlowClient.Loot and workspace:WaitForChild("Loot") or workspace:FindFirstChild("Loot")

if FlowClient.Loot then
	assert(type(FlowClient.Loot.LootEquip) == "function", "LootEquip is unavailable")
end

local color = Color3.fromHex("#FF8A20")
local response = game:HttpGet("https://raw.githubusercontent.com/gilgameshfate59/ohbfoosk8tid/main/CitraUI.lua")
assert(type(response) == "string" and #response > 128, "CitraUI came back empty -- GitHub is likely rate limiting. Try again shortly.")
local lib = loadstring(response)()
assert(lib and lib.Shim, "This CitraUI build has no Shim; the port needs it.")
local str = ""

pcall(function()
	str = game:HttpGet("https://raw.githubusercontent.com/Bac0nHck/Something/refs/heads/main/telegram"):match("^%s*(.-)%s*$") or ""
end)

if genv.RunawaysScriptLoading ~= coroutine.running() then
	return genv.AutoLoot
end

local v, v2, v3, v4, v5 = lib.Shim:Init({ Name = "RUNAWAYS", Accent = color, Logo = 95077438762744 })
genv.AutoLoot = v
local tbl = { BigElectronic = true, Cash = true, Painting = true, VehiclePart = true }
local tbl2 = {}
local tbl3 = {}
local tbl4 = {}
local tbl5 = {}
local n = 0

for _, v6 in Data, nil, nil do
	if v6.Item and v6.Category then
		tbl3[v6.Item] = v6.Category
		tbl4[v6.Item] = v6.Value
		local n2 = math.max(n, tonumber(v6.Value) or 0)

		if not tbl[v6.Category] and not tbl5[v6.Category] then
			tbl5[v6.Category] = true
			tbl2[#tbl2 + 1] = v6.Category
			n = n2
		else
			n = n2
		end
	end
end

table.sort(tbl2)

local function fn(arg, arg2)
	v:Notify({ Title = "RUNAWAYS", Description = arg, Time = arg2 or 4 })
end

local function fn2(arg)
	if arg.Parent ~= loot or not arg:IsA("Model") then
		return false
	end
	local primaryPart = arg.PrimaryPart
	return primaryPart and primaryPart:IsA("BasePart") and primaryPart.Parent == arg and CollectionService:HasTag(arg, "Draggable") and CollectionService:HasTag(arg, "Equippable") and not CollectionService:HasTag(arg, "BuyableLoot")
end

local function fn3()
	local tbl6 = {}
	local tbl7 = {}
	local tbl8 = {}
	if not loot then
		return tbl6, tbl7
	end

	for _, v6 in loot:GetChildren() do
		if fn2(v6) then
			tbl6[#tbl6 + 1] = v6

			if not tbl8[v6.Name] then
				tbl8[v6.Name] = true
				tbl7[#tbl7 + 1] = v6.Name
			end
		end
	end

	table.sort(tbl6, function(arg, arg2)
		return arg.Name < arg2.Name
	end)

	table.sort(tbl7)
	return tbl6, tbl7
end

local tbl6 = {}
local v6 = select
local v7, v8 = fn3()
tbl6.Names = v6(2, v7, v8)
tbl6.Signatures = {}
tbl6.Token = nil
tbl6.Running = false
tbl6.Context = nil
tbl6.CashToken = nil
tbl6.CashAuraToken = nil
tbl6.CashRunning = false
tbl6.CashContext = nil
local flag = false
local tbl7 = nil
local tbl8 = nil
v.Rage = {}
v.VehicleMods = {}

local function fn4(arg)
	return (arg:gsub("(%l)(%u)", "%1 %2"))
end

local function fn5(arg)
	if arg:HasTag("Backpack") then
		return "Backpack"
	end
	return tbl3[arg.Name]
end

local tbl9 = {
	BackpackLarge = module.Balance and module.Balance.MaxToolsLargeBackpack,
	BackpackMedium = module.Balance and module.Balance.MaxToolsMediumBackpack,
	BackpackSmall = module.Balance and module.Balance.MaxToolsSmallBackpack,
}

local function fn6()
	local backpack = localPlayer:FindFirstChildOfClass("Backpack")
	local character = localPlayer.Character
	if not backpack then
		return
	end
	local n2 = #backpack:GetChildren()

	if character and character:FindFirstChildOfClass("Tool") then
		n2 += 1
	end

	for _, v9 in { "BackpackLarge", "BackpackMedium", "BackpackSmall" }, nil, nil do
		if backpack:FindFirstChild(v9) or character and character:FindFirstChild(v9) then
			return n2, tbl9[v9]
		end
	end

	return n2, module.Balance and module.Balance.MaxTools
end

local function fn7(arg, arg2)
	local n2 = arg.Position - arg2.Position
	local vector = Vector3.new(n2.X, 0, n2.Z)
	local n3 = arg2.Position + (vector.Magnitude > 0.1 and vector.Unit or Vector3.new(0, 0, 1)) * 3 + Vector3.new(0, 2.5, 0)
	return CFrame.lookAt(n3, Vector3.new(arg2.Position.X, n3.Y, arg2.Position.Z))
end

local function fn8(arg)
	local npCs = workspace:FindFirstChild("NPCs")
	if not npCs or not FlowClient.NPCs or type(FlowClient.NPCs.Damage) ~= "function" then
		return 0
	end
	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	local n2 = 0

	for _, v9 in npCs:QueryDescendants("Humanoid") do
		local model = v9:FindFirstAncestorWhichIsA("Model")
		model = model and model:FindFirstChild("HumanoidRootPart")

		if v9.Health > 0 and (not arg or character and model and (model.Position - character.Position).Magnitude <= arg) then
			if pcall(FlowClient.NPCs.Damage, v9, v9.Health + 1) then
				n2 += 1
			end
		end
	end

	return n2
end

v.Rage.AggroNPCs = function(arg, arg2)
	local npCs = workspace:FindFirstChild("NPCs")
	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	if not npCs or not character or not FlowClient.NPCs or type(FlowClient.NPCs.Threaten) ~= "function" then
		return 0
	end
	local n2 = 0

	for _, v9 in npCs:GetChildren() do
		local humanoid = v9:IsA("Model") and v9:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = v9:IsA("Model") and v9:FindFirstChild("HumanoidRootPart")

		if humanoid and humanoid.Health > 0 and humanoidRootPart and (humanoidRootPart.Position - character.Position).Magnitude <= arg2 then
			pcall(FlowClient.NPCs.Threaten, v9)
			n2 += 1
		end
	end

	return n2
end

v.Rage.BreakNearbySources = function(arg, arg2)
	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	if not character or not FlowClient.DamageToOpen or type(FlowClient.DamageToOpen.Damage) ~= "function" then
		return 0
	end
	local n2 = 0

	for _, v9 in CollectionService:GetTagged("DamageToOpen") do
		local health = v9:IsDescendantOf(workspace) and v9:FindFirstChild("Health")
		local primaryPart = v9:IsA("Model") and (v9.PrimaryPart or v9:FindFirstChildWhichIsA("BasePart", true))

		if health and health:IsA("NumberValue") and health.Value > 0 and primaryPart and (primaryPart.Position - character.Position).Magnitude <= arg2 then
			pcall(FlowClient.DamageToOpen.Damage, v9, math.max(health.Value * 10, 100), "melee")
			n2 += 1
		end
	end

	return n2
end

local tbl10 = {
	Service = game:GetService("ProximityPromptService"),
	Active = false,
	States = setmetatable({}, { __mode = "k" }),
	Connections = setmetatable({}, { __mode = "k" }),
	Set = function(arg, arg2)
		if not arg2:IsA("ProximityPrompt") then
			return
		end

		if arg.States[arg2] == nil then
			arg.States[arg2] = arg2.HoldDuration
		end

		if not arg.Connections[arg2] then
			arg.Connections[arg2] = arg2:GetPropertyChangedSignal("HoldDuration"):Connect(function()
				if not arg.Active or not arg2.Parent then
					return
				end
				local holdDuration = arg2.HoldDuration

				if holdDuration ~= 0 then
					arg.States[arg2] = holdDuration
					arg2.HoldDuration = 0
				end
			end)
		end

		arg2.HoldDuration = 0
	end,
	Apply = function(arg)
		for _, v9 in workspace:QueryDescendants("ProximityPrompt") do
			arg:Set(v9)
		end
	end,
	Restore = function(arg)
		arg.Active = false

		for _, v9 in arg.Connections, nil, nil do
			v9:Disconnect()
		end

		table.clear(arg.Connections)

		for k, v9 in arg.States, nil, nil do
			if k.Parent then
				k.HoldDuration = v9
			end
		end

		table.clear(arg.States)
	end,
	SetActive = function(arg, arg2)
		if arg2 then
			arg.Active = true
			arg:Apply()
		else
			arg:Restore()
		end
	end,
}

local obj = setmetatable({}, { __mode = "k" })
local obj2 = setmetatable({}, { __mode = "k" })
local obj3 = setmetatable({}, { __mode = "k" })
local v9 = nil
local v10 = nil
local takeDamage = FlowClient.PlayerDamage and FlowClient.PlayerDamage.TakeDamage
local abandon = FlowClient.Passout and FlowClient.Passout.Abandon
local damage = FlowClient.DamageVehicle and FlowClient.DamageVehicle.Damage
local setAmmo = FlowClient.Ammo and FlowClient.Ammo.setAmmo
local substractReserve = FlowClient.Ammo and FlowClient.Ammo.substractReserve
local recoil = FlowClient.Camera and FlowClient.Camera.Recoil
local recoil2 = FlowClient.Viewmodel and FlowClient.Viewmodel.Recoil
local radialFalloff = luck and luck.radialFalloff

local function takeDamage2()
end

local obj4 = setmetatable({}, { __mode = "k" })

local tbl11 = {
	Config = module.Tools.GetToolConfig("Punch"),
	Configs = require(data:WaitForChild("Tools"):WaitForChild("Melees")),
	ConfigStates = setmetatable({}, { __mode = "k" }),
	MeleeRuntimes = setmetatable({}, { __mode = "k" }),
	Character = nil,
	Function = nil,
	SpeedIndex = nil,
	LastSearch = 0,
	MeleeTool = nil,
	MeleeConfig = nil,
	MeleeFunction = nil,
	MeleeSpeedIndex = nil,
	MeleeLastSearch = 0,
}

tbl11.Defaults = {
	Damage = tbl11.Config.damage,
	Speed = tbl11.Config.hitsPerSecond,
	ObjectDamage = tbl11.Config.destructibleDamage,
}

tbl11.ConfigStates[tbl11.Config] = tbl11.Defaults

local teleports = {
	Maps = {},
	Signatures = {},
	Ids = setmetatable({}, { __mode = "k" }),
	NextId = 0,
	LastPosition = nil,
	SavedPosition = nil,
	RefuelToken = nil,
	RefuelContext = nil,
	OptionIds = {
		Buildings = "RunawaysTeleportBuilding",
		NPCs = "RunawaysTeleportNPC",
		Vehicles = "RunawaysTeleportVehicle",
		Players = "RunawaysTeleportPlayer",
	},
}

v.Teleports = teleports
local v11 = nil
local v12 = nil
local v13 = nil

local tbl12 = {
	"TopSpeedMPH",
	"Acceleration",
	"Torque",
	"BrakingPower",
	"TurningAngle",
	"TurningAngleSpeedFactor",
	"Downforce",
}

local tbl13 = { "fl", "fr", "rl", "rr" }

local function fn9()
	local character = localPlayer.Character
	return character and character:FindFirstChildOfClass("Humanoid")
end

local function fn10()
	local v14 = fn9()
	local seatPart = v14 and v14.SeatPart
	if not seatPart or not seatPart:IsA("VehicleSeat") or seatPart.Occupant ~= v14 then
		return
	end
	local model = seatPart:FindFirstAncestorOfClass("Model")
	if not model or not model:FindFirstChild("VehicleProperty") or not model:FindFirstChild("system") then
		return
	end
	return model
end

local function fn11(arg)
	arg = arg and arg:FindFirstChild("system")
	return arg and arg:FindFirstChild("chassis")
end

local function fn12(arg)
	arg = arg and arg:FindFirstChild("system")
	arg = arg and arg:FindFirstChild("seats")
	return arg and arg:FindFirstChildWhichIsA("VehicleSeat")
end

teleports.GetId = function(arg, arg2)
	local nextId = arg.Ids[arg2]

	if not nextId then
		arg.NextId = arg.NextId + 1
		nextId = arg.NextId
		arg.Ids[arg2] = nextId
	end

	return nextId
end

teleports.Refresh = function(arg, arg2)
	local tbl14 = { Buildings = {}, NPCs = {}, Vehicles = {}, Players = {} }
	local map = workspace:FindFirstChild("Map")
	map = map and map:FindFirstChild("Buildings")
	local npCs = workspace:FindFirstChild("NPCs")
	local vehicles = workspace:FindFirstChild("Vehicles")

	if map then
		for _, v14 in map:GetChildren() do
			local attribute = v14:GetAttribute("BuildingId")
			local str2 = v14.Name:lower()

			if v14:IsA("Model") and not str2:find("sign", 1, true) then
				local id = arg:GetId(v14)

				tbl14.Buildings[#tbl14.Buildings + 1] = {
					Instance = v14,
					Label = attribute ~= nil and fn4(v14.Name) .. " #" .. tostring(attribute) or fn4(v14.Name) .. " (Landmark #" .. id .. ")",
					Order = tonumber(attribute) or 1e9 + id,
				}
			end
		end
	end

	if npCs then
		for _, v14 in CollectionService:GetTagged("NPC") do
			local humanoid = v14:IsA("Model") and v14:FindFirstChildOfClass("Humanoid")
			local humanoidRootPart = v14:IsA("Model") and v14:FindFirstChild("HumanoidRootPart")

			if v14:IsA("Model") and v14:IsDescendantOf(npCs) and humanoid and humanoidRootPart and humanoid.Health > 0 then
				tbl14.NPCs[#tbl14.NPCs + 1] = {
					Instance = v14,
					Label = fn4(v14.Name) .. " #" .. arg:GetId(v14),
					Order = arg:GetId(v14),
				}
			end
		end
	end

	if vehicles then
		for _, v14 in CollectionService:GetTagged("Vehicle") do
			local basePart = v14:IsA("Model") and (fn11(v14) or fn12(v14) or v14:FindFirstChildWhichIsA("BasePart", true))

			if v14:IsA("Model") and v14:IsDescendantOf(vehicles) and basePart then
				local v15 = fn4(v14.Name)

				if CollectionService:HasTag(v14, "MainVehicle") then
					v15 ..= " (Your Vehicle)"
				end

				tbl14.Vehicles[#tbl14.Vehicles + 1] = { Instance = v14, Label = v15 .. " #" .. arg:GetId(v14), Order = arg:GetId(v14) }
			end
		end
	end

	for _, v14 in Players:GetPlayers() do
		if v14 ~= localPlayer then
			local name = v14.Name

			if v14.DisplayName ~= v14.Name then
				name = v14.DisplayName .. " (@" .. v14.Name .. ")"
			end

			tbl14.Players[#tbl14.Players + 1] = { Instance = v14, Label = name, Order = v14.UserId }
		end
	end

	for k, v14 in tbl14, nil, nil do
		table.sort(v14, function(arg3, arg4)
			if arg3.Order == arg4.Order then
				return arg3.Label < arg4.Label
			end
			return arg3.Order < arg4.Order
		end)

		local tbl15 = { "None" }
		local tbl16 = {}

		for _, v15 in v14, nil, nil do
			tbl15[#tbl15 + 1] = v15.Label
			tbl16[v15.Label] = v15.Instance
		end

		arg.Maps[k] = tbl16
		local str2 = table.concat(tbl15, "\0")
		local v15 = v3[arg.OptionIds[k]]

		if v15 then
			local value = v15.Value

			if arg2 or arg.Signatures[k] ~= str2 then
				v15:SetValues(tbl15)
				local v16 = v15
				local setValue = v16.SetValue
				value = tbl16[value] and value or "None"
				setValue(v16, value)
			elseif value ~= "None" and not tbl16[value] then
				v15:SetValue("None")
			end
		end

		arg.Signatures[k] = str2
	end
end

teleports.GetSelected = function(arg, arg2)
	local v14 = v3[arg.OptionIds[arg2]]
	local v15 = arg.Maps[arg2]
	local v16 = v14 and v15 and v15[v14.Value]
	if not v16 or not v16.Parent then
		fn("Select an available target.")
		return
	end
	return v16
end

teleports.GetBuildingSurface = function(arg, arg2)
	local n2 = -math.huge
	local v14 = nil

	for _, v15 in arg2:GetDescendants() do
		if v15:IsA("BasePart") and v15.CanCollide and v15.Transparency < 0.95 then
			local str2 = v15.Name:lower()

			if str2 == "road" or str2 == "floor" then
				local n3 = v15.Size.X * v15.Size.Z

				if str2 == "road" then
					n3 += 1e9
				end

				if n2 < n3 then
					n2 = n3
					v14 = v15
				end
			end
		end
	end

	return v14
end

teleports.Stream = function(arg, arg2)
	pcall(function()
		localPlayer:RequestStreamAroundAsync(arg2, 5)
	end)
end

teleports.GetDestination = function(arg, arg2, arg3)
	if arg2 == "Players" then
		local character = arg3.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

		if character and (not humanoid or not humanoidRootPart) then
			local ok, result = pcall(character.GetPivot, character)

			if ok then
				arg:Stream(result.Position)
			end

			local n2 = os.clock() + 4

			while true do
				task.wait(0.15)
				humanoid = character:FindFirstChildOfClass("Humanoid")
				humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
				if not (humanoid and humanoidRootPart or not character.Parent or os.clock() >= n2) then
					continue
				end
				break
			end
		end

		if not humanoid or not humanoidRootPart or humanoid.Health <= 0 then
			return
		end
		local n2 = humanoidRootPart.Position + humanoidRootPart.CFrame.RightVector * 4 + Vector3.new(0, 1, 0) * 2
		return CFrame.lookAt(n2, Vector3.new(humanoidRootPart.Position.X, n2.Y, humanoidRootPart.Position.Z))
	end

	if not arg3:IsDescendantOf(workspace) then
		return
	end

	if arg2 == "NPCs" then
		local humanoid = arg3:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = arg3:FindFirstChild("HumanoidRootPart")
		if not humanoid or not humanoidRootPart or humanoid.Health <= 0 then
			return
		end
		local n2 = humanoidRootPart.Position + humanoidRootPart.CFrame.RightVector * 4 + Vector3.new(0, 1, 0) * 2
		return CFrame.lookAt(n2, Vector3.new(humanoidRootPart.Position.X, n2.Y, humanoidRootPart.Position.Z))
	end

	if arg2 == "Vehicles" then
		local basePart = fn11(arg3) or fn12(arg3) or arg3:FindFirstChildWhichIsA("BasePart", true)
		if not basePart then
			return
		end
		arg:Stream(basePart.Position)
		if not arg3:IsDescendantOf(workspace) then
			return
		end
		local ok, result, result2 = pcall(arg3.GetBoundingBox, arg3)
		if not ok or typeof(result) ~= "CFrame" or typeof(result2) ~= "Vector3" then
			return
		end
		local n2 = result2 * 0.5
		local x = n2.X
		local n3 = result.Position.Y + math.abs(result.RightVector.Y) * x
		local y = n2.Y
		local z = n2.Z
		local vector = Vector3.new(result.Position.X, n3 + math.abs(result.UpVector.Y) * y + math.abs(result.LookVector.Y) * z + 6, result.Position.Z)
		local vector2 = Vector3.new(result.LookVector.X, 0, result.LookVector.Z)

		if vector2.Magnitude < 0.1 then
			vector2 = Vector3.new(basePart.CFrame.LookVector.X, 0, basePart.CFrame.LookVector.Z)
		end

		return CFrame.lookAt(vector, vector + (vector2.Magnitude > 0.1 and vector2.Unit or Vector3.new(0, 0, -1)), Vector3.new(0, 1, 0))
	end

	if arg2 == "Buildings" then
		local buildingSurface = arg:GetBuildingSurface(arg3)
		local result = nil

		if not buildingSurface then
			local ok
			ok, result = pcall(arg3.GetPivot, arg3)
			local v14 = nil

			if ok then
				arg:Stream(result.Position)
			else
				result = v14
			end

			local n2 = os.clock() + 4

			while true do
				task.wait(0.15)
				buildingSurface = arg:GetBuildingSurface(arg3)
				if not (buildingSurface or not arg3.Parent or os.clock() >= n2) then
					continue
				end
				break
			end
		end

		if not buildingSurface then
			if result and arg3.Parent then
				local rotation = result.Rotation
				return CFrame.new(result.Position + Vector3.new(0, 1, 0) * 8) * rotation
			end
			return
		end

		local n2 = buildingSurface.Position + Vector3.new(0, 1, 0) * (buildingSurface.Size.Y * 0.5 + 4)
		local vector = Vector3.new(buildingSurface.CFrame.LookVector.X, 0, buildingSurface.CFrame.LookVector.Z)

		if vector.Magnitude < 0.1 then
			vector = Vector3.new(0, 0, -1)
		end

		return CFrame.lookAt(n2, n2 + vector.Unit, Vector3.new(0, 1, 0))
	end
end

teleports.GetRoadNear = function(arg, arg2)
	local map = workspace:FindFirstChild("Map")
	if not map then
		return
	end
	local huge = math.huge
	local n2 = 0
	local v14 = nil

	for _, v15 in map:GetDescendants() do
		local str2 = v15.Name:lower()
		local str3 = v15.Parent and v15.Parent.Name:lower()

		if v15:IsA("BasePart") and (str2 == "road" or str2 == "sideroad" or str3 == "road") and not str2:find("pathfinding", 1, true) and v15.CanCollide and v15.Transparency < 0.95 then
			local n3 = math.max(math.abs(v15.Position.Z - arg2) - math.max(v15.Size.X, v15.Size.Z) * 0.5, 0)
			local n4 = v15.Size.X * v15.Size.Z

			if n3 < huge or n3 == huge and n4 > n2 then
				huge = n3
				n2 = n4
				v14 = v15
			end
		end
	end

	if huge <= 2000 then
		return v14
	end
end

teleports.GetEndPrompt = function()
	local map = workspace:FindFirstChild("Map")
	map = map and map:FindFirstChild("Buildings")
	map = map and map:FindFirstChild("CustomsFinal")
	if not map then
		return
	end
	local customsBuilding = map:FindFirstChild("CustomsBuilding")
	customsBuilding = customsBuilding and customsBuilding:FindFirstChild("FinalDoor")
	customsBuilding = customsBuilding and customsBuilding:FindFirstChild("Command")
	customsBuilding = customsBuilding and customsBuilding:FindFirstChild("CommandButton")
	customsBuilding = customsBuilding and customsBuilding:FindFirstChild("Prompt")

	if customsBuilding then
		customsBuilding = customsBuilding:IsA("ProximityPrompt") and customsBuilding or customsBuilding:FindFirstChildOfClass("ProximityPrompt")
	end

	if customsBuilding then
		return customsBuilding
	end
	local ok, result = pcall(map.QueryDescendants, map, "ProximityPrompt")

	if ok then
		for _, v14 in result, nil, nil do
			if v14.ActionText == "Activate" and v14:FindFirstAncestor("FinalDoor") then
				return v14
			end
		end
	end
end

teleports.GetEndAnchor = function(arg, arg2, arg3)
	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	character = character and character.Position or Vector3.new(500, 2000, arg2)
	local map = workspace:FindFirstChild("Map")
	map = map and map:FindFirstChild("Buildings")

	if map then
		local huge = math.huge

		for _, v14 in map:GetChildren() do
			if v14:IsA("Model") then
				local ok, result = pcall(v14.GetPivot, v14)

				if ok then
					if v14.Name == "CustomsFinal" then
						return result:PointToWorldSpace(Vector3.new(-44.4001, 4.65, -16.5))
					end
					local n2 = math.abs(arg2 - result.Position.Z)

					if (arg2 - result.Position.Z) * arg3 >= -500 and n2 < huge then
						character = result.Position
						huge = n2
					end
				end
			end
		end
	end

	return Vector3.new(character.X, character.Y + 30, arg2 - arg3 * 35)
end

teleports.GetEndPromptDestination = function(arg, arg2, arg3)
	arg2 = arg2 and arg2.Parent
	local worldCFrame

	if arg2 and arg2:IsA("Attachment") then
		worldCFrame = arg2.WorldCFrame
	else
		local isBasePart = arg2 and arg2:IsA("BasePart")
		worldCFrame = nil

		if isBasePart then
			worldCFrame = arg2.CFrame
		end
	end

	if not worldCFrame then
		return
	end
	local lookVector = worldCFrame.LookVector

	if lookVector.Z * arg3 > 0 then
		lookVector = -lookVector
	end

	if math.abs(lookVector.Z) < 0.25 then
		lookVector = Vector3.new(0, 0, -arg3)
	end

	local n2 = worldCFrame.Position + lookVector * 4
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = localPlayer.Character and { localPlayer.Character } or {}
	local hit = workspace:Raycast(n2 + Vector3.new(0, 1, 0) * 20, Vector3.new(0, -60, 0), raycastParams)

	if hit then
		n2 = Vector3.new(n2.X, hit.Position.Y + 3.25, n2.Z)
	end

	return CFrame.lookAt(n2, Vector3.new(worldCFrame.Position.X, n2.Y, worldCFrame.Position.Z), Vector3.new(0, 1, 0))
end

teleports.ParkEndVehicle = function(arg, arg2, arg3, arg4)
	local v14 = fn11(arg2)
	if not v14 or not arg2.Parent then
		return
	end
	local roadNear = arg:GetRoadNear(arg3)
	local vector

	if roadNear then
		vector = Vector3.new(roadNear.Position.X, roadNear.Position.Y + roadNear.Size.Y * 0.5 + 4.5, arg3 - arg4 * 28)
	else
		local map = workspace:FindFirstChild("Map")
		map = map and map:FindFirstChild("Buildings")
		map = map and map:FindFirstChild("CustomsFinal")
		vector = nil

		if map then
			local ok, result = pcall(map.GetPivot, map)
			vector = nil

			if ok then
				vector = Vector3.new(result.Position.X, result.Position.Y + 5, arg3 - arg4 * 28)
			end
		end
	end

	if not vector then
		return
	end
	local vector2 = Vector3.new(v14.CFrame.LookVector.X, 0, v14.CFrame.LookVector.Z)

	if vector2.Magnitude < 0.1 then
		vector2 = Vector3.new(0, 0, arg4)
	end

	arg:Move(CFrame.lookAt(vector, vector + vector2.Unit, Vector3.new(0, 1, 0)), arg2, false)
end

teleports.Move = function(arg, arg2, arg3, arg4)
	if typeof(arg2) ~= "CFrame" then
		return false
	end
	local character = localPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
	if not character or not humanoid or not humanoidRootPart or humanoid.Health <= 0 then
		fn("Character is unavailable.")
		return false
	end
	arg3 = arg3 or character
	local flag2 = arg3 == character and humanoidRootPart or fn11(arg3)
	if not flag2 or not arg3.Parent then
		fn("Teleport target is unavailable.")
		return false
	end
	local lastPosition = arg.LastPosition

	if arg4 ~= false then
		arg.LastPosition = humanoidRootPart.CFrame
	end

	local currentCamera = workspace.CurrentCamera
	local cFrame = currentCamera and currentCamera.CFrame
	local cameraSubject = currentCamera and currentCamera.CameraSubject
	local cameraType = currentCamera and currentCamera.CameraType

	if currentCamera then
		currentCamera.CameraType = Enum.CameraType.Scriptable
		currentCamera.CFrame = cFrame
	end

	local ok, result = pcall(function()
		if arg3 == character and humanoid.SeatPart then
			humanoid.Sit = false
			humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
			RunService.Heartbeat:Wait()
		end

		arg3:PivotTo(arg2 * flag2.CFrame:Inverse() * arg3:GetPivot())
		flag2.AssemblyLinearVelocity = Vector3.zero
		flag2.AssemblyAngularVelocity = Vector3.zero
		RunService.Heartbeat:Wait()
	end)

	if currentCamera and currentCamera.Parent then
		currentCamera.CameraSubject = cameraSubject
		currentCamera.CameraType = cameraType
		currentCamera.CFrame = cFrame
	end

	if not ok then
		arg.LastPosition = lastPosition
		fn("Teleport failed: " .. tostring(result))
		return false
	end

	return true
end

teleports.Go = function(arg, arg2)
	local selected = arg:GetSelected(arg2)
	if not selected then
		return
	end

	task.spawn(function()
		local destination = arg:GetDestination(arg2, selected)
		if not destination then
			fn("Target position is unavailable.")
			return
		end
		arg:Move(destination)
	end)
end

teleports.GetEndZ = function()
	local flowClient = ReplicatedStorage:FindFirstChild("FlowClient")
	flowClient = flowClient and flowClient:FindFirstChild("Gui")
	flowClient = flowClient and flowClient:FindFirstChild("DistanceToBorderClient")

	if flowClient then
		local ok, result = pcall(require, flowClient)

		if ok and type(result) == "table" then
			local setEndPosEvent = result.SetEndPos_event or result.SetEndPos

			if type(setEndPosEvent) == "function" and debug and type(debug.getupvalues) == "function" then
				local ok2, result2 = pcall(debug.getupvalues, setEndPosEvent)

				if ok2 and type(result2) == "table" then
					if type(result2[1]) == "number" then
						return result2[1]
					end

					for _, v14 in result2, nil, nil do
						if type(v14) == "number" and math.abs(v14) > 1000 then
							return v14
						end
					end
				end
			end
		end
	end

	local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")

	if playerGui then
		for _, v14 in playerGui:GetDescendants() do
			if v14:IsA("TextLabel") and v14.Text:find("Mexico", 1, true) then
				local parent = v14.Parent

				while parent and parent ~= playerGui do
					local num = tonumber(parent.Name:match("^Border_(-?[%d%.]+)$"))
					if num then
						return num
					end
					parent = parent.Parent
				end
			end
		end
	end
end

teleports.GetStartCFrame = function()
	local spawnLocation = workspace:FindFirstChildOfClass("SpawnLocation")
	if not spawnLocation or not spawnLocation.Enabled then
		return
	end
	local filterDescendantsInstances = { spawnLocation }

	if localPlayer.Character then
		filterDescendantsInstances[#filterDescendantsInstances + 1] = localPlayer.Character
	end

	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = filterDescendantsInstances
	raycastParams.RespectCanCollide = true
	local hit = workspace:Raycast(spawnLocation.Position + Vector3.new(0, 1, 0) * 6, -Vector3.new(0, 1, 0) * 20, raycastParams)
	hit = hit and hit.Position.Y + 3.5 or spawnLocation.Position.Y + 3
	local rotation = spawnLocation.CFrame.Rotation
	return CFrame.new(spawnLocation.Position.X, hit, spawnLocation.Position.Z) * rotation
end

teleports.ToEnd = function(arg)
	task.spawn(function()
		local endZ = arg:GetEndZ()
		local character = localPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		local v14 = fn10()
		local v15 = v14 and fn11(v14) or humanoidRootPart
		if not endZ then
			fn("End position is unavailable.")
			return
		end

		if not humanoid or not v15 or humanoid.Health <= 0 then
			fn("Character is unavailable.")
			return
		end
		local startCFrame = arg:GetStartCFrame()
		local n2 = (not startCFrame or endZ >= startCFrame.Position.Z) and 1 or -1
		local endPrompt = arg:GetEndPrompt()

		if endPrompt then
			local endPromptDestination = arg:GetEndPromptDestination(endPrompt, n2)

			if endPromptDestination then
				if v14 then
					arg.LastPosition = humanoidRootPart.CFrame
					arg:ParkEndVehicle(v14, endZ, n2)
					arg:Move(endPromptDestination, nil, false)
				else
					arg:Move(endPromptDestination)
				end

				return
			end
		end

		local endAnchor = arg:GetEndAnchor(endZ, n2)
		arg:Stream(endAnchor)
		local endPrompt2 = arg:GetEndPrompt()

		if endPrompt2 then
			local endPromptDestination = arg:GetEndPromptDestination(endPrompt2, n2)

			if endPromptDestination then
				if v14 then
					arg.LastPosition = humanoidRootPart.CFrame
					arg:ParkEndVehicle(v14, endZ, n2)
					arg:Move(endPromptDestination, nil, false)
				else
					arg:Move(endPromptDestination)
				end

				return
			end
		end

		local roadNear = arg:GetRoadNear(endZ)

		if roadNear then
			endAnchor = Vector3.new(roadNear.Position.X, roadNear.Position.Y + roadNear.Size.Y * 0.5 + 8, endZ - n2 * 35)
		end

		local vector = v14 and Vector3.new(v15.CFrame.LookVector.X, 0, v15.CFrame.LookVector.Z) or Vector3.new(0, 0, n2)

		if vector.Magnitude < 0.1 then
			vector = Vector3.new(0, 0, n2)
		end

		if not arg:Move(CFrame.lookAt(endAnchor, endAnchor + vector.Unit, Vector3.new(0, 1, 0)), v14 or character) then
			return
		end
		local humanoidRootPart2 = v14 and fn11(v14) or character:FindFirstChild("HumanoidRootPart")
		local anchored = humanoidRootPart2 and humanoidRootPart2.Anchored

		if humanoidRootPart2 then
			humanoidRootPart2.Anchored = true
		end

		local ok, result = pcall(function()
			local n3 = os.clock() + 12
			local flag2 = false
			local endPrompt3

			while true do
				endPrompt3 = arg:GetEndPrompt()

				if not endPrompt3 and not flag2 then
					local map = workspace:FindFirstChild("Map")
					map = map and map:FindFirstChild("Buildings")
					map = map and map:FindFirstChild("CustomsFinal")

					if map then
						local ok, result = pcall(map.GetPivot, map)

						if ok then
							arg:Stream(result.Position)
							endPrompt3 = arg:GetEndPrompt()
							flag2 = true
						end
					end
				end

				if not endPrompt3 then
					task.wait(0.2)
				end

				if not (endPrompt3 or not character.Parent or os.clock() >= n3) then
					continue
				end
				break
			end

			return endPrompt3
		end)

		if humanoidRootPart2 and humanoidRootPart2.Parent then
			humanoidRootPart2.Anchored = anchored
		end

		if ok then
			endPrompt2 = result
		end

		if endPrompt2 then
			local endPromptDestination = arg:GetEndPromptDestination(endPrompt2, n2)

			if endPromptDestination then
				if v14 then
					arg:ParkEndVehicle(v14, endZ, n2)
				end

				arg:Move(endPromptDestination, nil, false)
				return
			end
		end

		local roadNear2 = arg:GetRoadNear(endZ)

		if roadNear2 then
			if v14 then
				arg:ParkEndVehicle(v14, endZ, n2)
			else
				local vector2 = Vector3.new(roadNear2.Position.X, roadNear2.Position.Y + roadNear2.Size.Y * 0.5 + 8, endZ - n2 * 20)
				arg:Move(CFrame.lookAt(vector2, vector2 + Vector3.new(0, 0, n2), Vector3.new(0, 1, 0)), nil, false)
			end
		end

		fn("End gate button is unavailable.")
	end)
end

teleports.ToStart = function(arg)
	task.spawn(function()
		local startCFrame = arg:GetStartCFrame()
		if not startCFrame then
			fn("Start position is unavailable.")
			return
		end
		arg:Stream(startCFrame.Position)
		arg:Move(startCFrame)
	end)
end

teleports.ToObjective = function(arg)
	local attribute = localPlayer:GetAttribute("Pointy")
	if typeof(attribute) ~= "CFrame" then
		fn("Objective position is unavailable.")
		return
	end

	task.spawn(function()
		local rotation = attribute.Rotation
		attribute = CFrame.new(attribute.Position + Vector3.new(0, 1, 0) * 4) * rotation
		arg:Stream(attribute.Position)
		arg:Move(attribute)
	end)
end

teleports.SavePosition = function(arg)
	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	if not character then
		fn("Character is unavailable.")
		return
	end
	arg.SavedPosition = character.CFrame
	fn("Position saved.")
end

teleports.ToSaved = function(arg)
	if not arg.SavedPosition then
		fn("Save a position first.")
		return
	end

	task.spawn(function()
		arg:Stream(arg.SavedPosition.Position)
		arg:Move(arg.SavedPosition)
	end)
end

teleports.ToLast = function(arg)
	if not arg.LastPosition then
		fn("No previous position.")
		return
	end

	task.spawn(function()
		local lastPosition = arg.LastPosition
		arg:Stream(lastPosition.Position)
		arg:Move(lastPosition, nil, false)
	end)
end

teleports.GetRefuelVehicle = function()
	local v14 = fn10()
	if v14 then
		return v14
	end
	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	if not character then
		return
	end
	local n2 = 60
	local v15 = nil

	for _, v16 in CollectionService:GetTagged("Vehicle") do
		local gasLevel = v16:FindFirstChild("gasLevel")
		local vehicleProperty = v16:FindFirstChild("VehicleProperty")
		local system = v16:FindFirstChild("system")
		system = system and system:FindFirstChild("gas")
		system = system and system:FindFirstChild("collider")

		if v16:IsA("Model") and v16:IsDescendantOf(workspace) and gasLevel and vehicleProperty then
			local magnitude = ((system and system.Position or v16:GetPivot().Position) - character.Position).Magnitude

			if magnitude < n2 then
				n2 = magnitude
				v15 = v16
			end
		end
	end

	return v15
end

teleports.GetRefuelSystem = function(arg, arg2)
	arg2 = arg2 and arg2:FindFirstChild("system")
	arg2 = arg2 and arg2:FindFirstChild("gas")
	arg2 = arg2 and arg2:FindFirstChild("collider")
	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	if not arg2 or not arg2:IsA("BasePart") or not character then
		return
	end
	local n2 = 4
	local huge = math.huge
	local huge2 = math.huge
	local v14 = nil
	local v15 = nil

	for _, v16 in CollectionService:GetTagged("GasPump") do
		local detectCarCollider = v16:FindFirstChild("DetectCarCollider")
		local gasGun = v16:FindFirstChild("GasGun")
		local getTargetCol = gasGun and gasGun:FindFirstChild("GetTargetCol")

		if v16:IsA("Model") and v16:IsDescendantOf(workspace) and detectCarCollider and detectCarCollider:IsA("BasePart") and gasGun and getTargetCol then
			local v17 = detectCarCollider.CFrame:PointToObjectSpace(arg2.Position)
			local n3 = detectCarCollider.Size * 0.5
			local vector = Vector3.new
			local x = n3.X
			local n4 = math.max(math.abs(v17.X) - x, 0)
			local y = n3.Y
			local max = math.max
			local z = n3.Z
			local magnitude = vector(n4, math.max(math.abs(v17.Y) - y, 0), max(math.abs(v17.Z) - z, 0)).Magnitude
			local magnitude2 = (detectCarCollider.Position - arg2.Position).Magnitude
			local magnitude3 = (getTargetCol.Position - character.Position).Magnitude
			local flag2 = magnitude < n2 - 0.001
			local flag3 = math.abs(magnitude - n2) <= 0.001
			local flag4 = magnitude3 < huge - 0.001
			local flag5 = math.abs(magnitude3 - huge) <= 0.001

			if magnitude3 <= 19 and (flag2 or flag3 and (flag4 or flag5 and magnitude2 < huge2)) then
				n2 = magnitude
				huge = magnitude3
				huge2 = magnitude2
				v14 = v16
				v15 = gasGun
			end
		end
	end

	return v14, v15, arg2
end

teleports.PositionRefuelGun = function(arg, arg2, arg3)
	local gun = arg2 and arg2.Gun
	local heldPart = arg2 and arg2.HeldPart
	arg2 = arg2 and arg2.ControlAttachment
	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	local flag2 = not gun or not gun.Parent or not heldPart or not heldPart.Parent or not arg2 or not arg2.Parent or not arg3 or not arg3.Parent or not character

	if not flag2 then
		flag2 = FlowClient.LocalStates.GetValue("draggedObject"):get() ~= gun
	end

	if flag2 then
		return false
	end
	local n2 = character.Position - arg3.Position
	local rightVector

	if n2.Magnitude < 0.1 then
		rightVector = arg3.CFrame.RightVector
	else
		rightVector = n2.Unit
	end

	arg2.WorldPosition = arg2.WorldPosition:Lerp(arg3.Position + rightVector * 2, 0.35)
	heldPart.AssemblyLinearVelocity = Vector3.zero
	heldPart.AssemblyAngularVelocity = Vector3.zero
	return true
end

teleports.PayRefuel = function(arg, arg2)
	arg2 = arg2 and arg2:FindFirstChild("PayGas")
	arg2 = arg2 and arg2:FindFirstChildWhichIsA("ClickDetector", true)
	if not arg2 then
		return false
	end
	return (pcall(fireclickdetector, arg2, 0, "MouseClick"))
end

teleports.StopRefuel = function(arg)
	local refuelContext = arg.RefuelContext
	local v14 = nil
	arg.RefuelContext = nil
	if not refuelContext then
		return
	end

	if FlowClient.GasPump and type(FlowClient.GasPump.Pour) == "function" and refuelContext.System and refuelContext.System.Parent then
		pcall(FlowClient.GasPump.Pour, refuelContext.System, false)
	end

	pcall(function()
		v14 = FlowClient.LocalStates.GetValue("draggedObject"):get()
	end)

	if refuelContext.OwnedDrag and FlowClient.Draggables and type(FlowClient.Draggables.Drop) == "function" and v14 == refuelContext.Gun then
		pcall(function()
			local gun = refuelContext.Gun
			local root = gun and gun:FindFirstChild("Root")
			local assemblyRootPart = root and (root.AssemblyRootPart or root)
			root = root and root:FindFirstChild("BasePlacementGun")
			gun = gun and gun:FindFirstChild("BasePlacement")
			gun = gun and gun:FindFirstChild("BasePlacementPump")

			if assemblyRootPart and root and gun then
				local cFrame = assemblyRootPart.CFrame
				assemblyRootPart.CFrame = gun.WorldCFrame * root.WorldCFrame:Inverse() * cFrame
				assemblyRootPart.AssemblyLinearVelocity = Vector3.zero
				assemblyRootPart.AssemblyAngularVelocity = Vector3.zero
			end
		end)

		pcall(FlowClient.Draggables.Drop)
	end
end

teleports.StartRefuel = function(arg, arg2, arg3, arg4, arg5, arg6)
	if not FlowClient.GasPump or type(FlowClient.GasPump.Pour) ~= "function" or not FlowClient.Draggables or type(FlowClient.Draggables.Drop) ~= "function" then
		return false, "Auto refuel is unavailable."
	end
	local getTargetCol = arg5 and arg5:FindFirstChild("GetTargetCol")
	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	if not getTargetCol then
		return false, "Gas pump is unavailable."
	end

	if not character or (getTargetCol.Position - character.Position).Magnitude > 19 then
		return false, "Stand closer to the gas pump."
	end
	local v14 = FlowClient.LocalStates.GetValue("draggedObject"):get()
	if v14 and v14 ~= arg5 then
		return false, "Drop the held item first."
	end
	local flag2 = v14 ~= arg5

	if flag2 then
		local ok, result = pcall(filtergc, "function", { Name = "pickup" }, false)
		local v15 = nil

		if ok then
			v15 = nil

			for _, v16 in result, nil, nil do
				local ok2, result2 = pcall(debug.info, v16, "s")

				if ok2 and result2 == "ReplicatedStorage.FlowClient.Draggables" then
					v15 = v16
					break
				else
					v15 = nil
				end
			end
		end

		local ok2, result2 = pcall(v15, getTargetCol)
		if not ok2 or not result2 then
			return false, "Gas pump is busy."
		end
	end

	local gasLevel = arg3:FindFirstChild("gasLevel")

	local refuelContext = {
		Vehicle = arg3,
		System = arg4,
		Gun = arg5,
		HeldPart = getTargetCol,
		OwnedDrag = flag2,
		LastFuel = gasLevel and gasLevel.Value,
		LastChange = os.clock(),
	}

	arg.RefuelContext = refuelContext
	task.wait(0.15)
	if arg.RefuelToken ~= arg2 or v.Unloaded then
		arg:StopRefuel()
		return false
	end
	local grabAttachment = getTargetCol:FindFirstChild("GrabAttachment")

	local ok, result = pcall(function()
		return FlowClient.CameraPart and FlowClient.CameraPart.GetCameraPart()
	end)

	ok = ok and result
	local v15 = nil

	if ok then
		v15 = nil

		for _, v16 in result:GetChildren() do
			local alignPosition = v16:IsA("Attachment") and v16:FindFirstChildOfClass("AlignPosition")

			if alignPosition and alignPosition.Attachment0 == grabAttachment then
				v15 = v16
				break
			else
				v15 = nil
			end
		end
	end

	local flag3 = not grabAttachment or not v15

	if not flag3 then
		flag3 = FlowClient.LocalStates.GetValue("draggedObject"):get() ~= arg5
	end

	if flag3 then
		arg:StopRefuel()
		return false, "Gas pump is busy."
	end
	refuelContext.ControlAttachment = v15
	if not arg:PositionRefuelGun(refuelContext, arg6) then
		arg:StopRefuel()
		return false, "Move the vehicle closer to the gas pump."
	end

	for i = 1, 30 do
		if not arg:PositionRefuelGun(refuelContext, arg6) then
			arg:StopRefuel()
			return false, "Move the vehicle closer to the gas pump."
		end
		task.wait(0.04)
	end

	if arg.RefuelToken ~= arg2 or arg.RefuelContext ~= refuelContext or v.Unloaded then
		arg:StopRefuel()
		return false
	end
	arg:PayRefuel(arg4)
	pcall(FlowClient.GasPump.Pour, arg4, false)
	task.wait(0.05)
	pcall(FlowClient.GasPump.Pour, arg4, true)
	return true
end

teleports.SetAutoRefuel = function(arg, arg2)
	arg.RefuelToken = nil
	arg:StopRefuel()
	if not arg2 then
		return
	end
	local refuelToken = {}
	arg.RefuelToken = refuelToken

	task.spawn(function()
		local flag2 = false

		while arg.RefuelToken == refuelToken and not v.Unloaded do
			local refuelVehicle = arg:GetRefuelVehicle()
			local gasLevel = refuelVehicle and refuelVehicle:FindFirstChild("gasLevel")
			local vehicleProperty = refuelVehicle and refuelVehicle:FindFirstChild("VehicleProperty")
			vehicleProperty = vehicleProperty and vehicleProperty:GetAttribute("GasCapacity")

			if gasLevel and type(vehicleProperty) == "number" and gasLevel.Value < vehicleProperty - 0.01 then
				local refuelSystem, v14, v15 = arg:GetRefuelSystem(refuelVehicle)
				local refuelContext = arg.RefuelContext

				if not refuelSystem then
					arg:StopRefuel()

					if not flag2 then
						fn("Park a vehicle next to a gas pump.", 5)
						flag2 = true
					end
				elseif not refuelContext or refuelContext.Vehicle ~= refuelVehicle or refuelContext.System ~= refuelSystem then
					arg:StopRefuel()
					local ok, result, result2 = pcall(arg.StartRefuel, arg, refuelToken, refuelVehicle, refuelSystem, v14, v15)

					if not ok then
						arg:StopRefuel()
						result = false
						result2 = "Auto refuel failed."
					end

					if not result and result2 and not flag2 then
						fn(result2, 5)
						flag2 = true
					elseif result then
						flag2 = false
					end
				elseif arg:PositionRefuelGun(refuelContext, v15) then
					if gasLevel.Value > (refuelContext.LastFuel or gasLevel.Value) then
						refuelContext.LastFuel = gasLevel.Value
						refuelContext.LastChange = os.clock()
						flag2 = false
					else
						local lastChange = refuelContext.LastChange

						if os.clock() - lastChange >= 2 then
							pcall(FlowClient.GasPump.Pour, refuelSystem, false)
							task.wait(0.1)
							pcall(FlowClient.GasPump.Pour, refuelSystem, true)
							refuelContext.LastChange = os.clock()

							if not flag2 then
								fn("Refueling paused. Move closer or check your cash.", 5)
								flag2 = true
							end
						end
					end
				else
					arg:StopRefuel()
				end
			else
				arg:StopRefuel()

				if not refuelVehicle and not flag2 then
					fn("Stand next to a vehicle at a gas pump.", 5)
					flag2 = true
				elseif refuelVehicle and (not gasLevel or type(vehicleProperty) ~= "number") and not flag2 then
					fn("This vehicle cannot be refueled.", 5)
					flag2 = true
				elseif refuelVehicle and gasLevel and type(vehicleProperty) == "number" then
					flag2 = false
				end
			end

			task.wait(0.1)
		end

		if arg.RefuelToken == refuelToken then
			arg.RefuelToken = nil
			arg:StopRefuel()
		end
	end)
end

teleports.Destroy = function(arg)
	arg:SetAutoRefuel(false)
	table.clear(arg.Maps)
	table.clear(arg.Signatures)
	table.clear(arg.Ids)
	arg.LastPosition = nil
	arg.SavedPosition = nil

	if v.Teleports == arg then
		v.Teleports = nil
	end
end

local function fn13()
	for _, v14 in CollectionService:GetTagged("MainVehicle") do
		if v14:IsA("Model") and v14:IsDescendantOf(workspace) then
			return v14
		end
	end
end

local function damage2(arg, ...)
	local v14 = fn10() or fn13()
	if v14 and arg == v14 then
		return
	end
	return damage(arg, ...)
end

local function fn14(arg)
	if not FlowClient.DamageVehicle or type(damage) ~= "function" then
		return
	end

	if arg then
		FlowClient.DamageVehicle.Damage = damage2
	elseif FlowClient.DamageVehicle.Damage == damage2 then
		FlowClient.DamageVehicle.Damage = damage
	end
end

local function fn15(arg)
	local v14 = obj3[arg]
	if v14 and v14.Property.Parent then
		return v14
	end
	local vehicleProperty = arg:FindFirstChild("VehicleProperty")
	if not vehicleProperty then
		return
	end

	local tbl14 = {
		Property = vehicleProperty,
		Attributes = {},
		Wheels = {},
		PerformanceApplied = false,
		GripApplied = false,
		FuelApplied = false,
	}

	for _, v15 in tbl12, nil, nil do
		tbl14.Attributes[v15] = vehicleProperty:GetAttribute(v15)
	end

	local system = arg:FindFirstChild("system")

	for _, v15 in tbl13, nil, nil do
		local v16 = system and system:FindFirstChild(v15)
		v16 = v16 and v16:FindFirstChild("wheel_" .. v15)

		if v16 and v16:IsA("BasePart") then
			tbl14.Wheels[#tbl14.Wheels + 1] = { Part = v16, Properties = v16.CustomPhysicalProperties }
		end
	end

	obj3[arg] = tbl14
	return tbl14
end

v.VehicleMods.ApplyFuel = function(arg, arg2)
	local v14 = fn15(arg2)
	arg2 = arg2 and arg2:FindFirstChild("gasLevel")
	local attribute = v14 and v14.Property:GetAttribute("GasCapacity")
	if not v14 or not arg2 or not arg2:IsA("NumberValue") or type(attribute) ~= "number" then
		return
	end

	if not v14.FuelApplied or arg2.Value ~= attribute then
		v14.FuelValue = arg2.Value
	end

	arg2.Value = attribute
	v14.FuelApplied = true
end

v.VehicleMods.RestoreFuel = function(arg, arg2)
	local v14 = obj3[arg2]
	if not v14 or not v14.FuelApplied then
		return
	end
	arg2 = arg2 and arg2:FindFirstChild("gasLevel")

	if arg2 and arg2:IsA("NumberValue") and v14.FuelValue ~= nil then
		arg2.Value = v14.FuelValue
	end

	v14.FuelApplied = false
	v14.FuelValue = nil
end

local function fn16(arg)
	local v14 = obj3[arg]
	if not v14 or not v14.PerformanceApplied or not v14.Property.Parent then
		return
	end

	for k, v15 in v14.Attributes, nil, nil do
		v14.Property:SetAttribute(k, v15)
	end

	v14.PerformanceApplied = false
end

local function fn17(arg)
	local v14 = obj3[arg]
	if not v14 or not v14.GripApplied then
		return
	end

	for _, v15 in v14.Wheels, nil, nil do
		if v15.Part.Parent then
			v15.Part.CustomPhysicalProperties = v15.Properties
		end
	end

	v14.GripApplied = false
end

local function fn18(arg)
	fn16(arg)
	fn17(arg)
	v.VehicleMods:RestoreFuel(arg)
end

local function fn19()
	for k in obj3, nil, nil do
		fn16(k)
	end
end

local function fn20()
	for k in obj3, nil, nil do
		fn17(k)
	end
end

local function fn21()
	for k in obj3, nil, nil do
		fn18(k)
	end

	v9 = nil
	v10 = nil
end

local function fn22(arg, arg2, arg3, arg4)
	local v14 = arg2[arg3]

	if type(v14) == "number" then
		arg:SetAttribute(arg3, v14 * arg4)
	end
end

local function fn23(arg)
	local v14 = fn15(arg)
	if not v14 then
		return
	end
	local property = v14.Property
	local attributes = v14.Attributes
	local topSpeedMultiplier = v3.RunawaysVehicleTopSpeedMultiplier.Value
	local accelerationMultiplier = v3.RunawaysVehicleAccelerationMultiplier.Value
	local torqueMultiplier = v3.RunawaysVehicleTorqueMultiplier.Value
	local brakeMultiplier = v3.RunawaysVehicleBrakeMultiplier.Value
	local steeringMultiplier = v3.RunawaysVehicleSteeringMultiplier.Value
	local downforceMultiplier = v3.RunawaysVehicleDownforceMultiplier.Value
	if v14.PerformanceApplied and v14.TopSpeedMultiplier == topSpeedMultiplier and v14.AccelerationMultiplier == accelerationMultiplier and v14.TorqueMultiplier == torqueMultiplier and v14.BrakeMultiplier == brakeMultiplier and v14.SteeringMultiplier == steeringMultiplier and v14.DownforceMultiplier == downforceMultiplier then
		return
	end
	fn22(property, attributes, "TopSpeedMPH", topSpeedMultiplier)
	fn22(property, attributes, "Acceleration", accelerationMultiplier)
	fn22(property, attributes, "Torque", torqueMultiplier)
	fn22(property, attributes, "BrakingPower", brakeMultiplier)
	fn22(property, attributes, "TurningAngle", steeringMultiplier)
	fn22(property, attributes, "Downforce", downforceMultiplier)

	if type(attributes.TurningAngleSpeedFactor) == "number" then
		property:SetAttribute("TurningAngleSpeedFactor", math.clamp(attributes.TurningAngleSpeedFactor * steeringMultiplier, 0, 1))
	end

	v14.PerformanceApplied = true
	v14.TopSpeedMultiplier = topSpeedMultiplier
	v14.AccelerationMultiplier = accelerationMultiplier
	v14.TorqueMultiplier = torqueMultiplier
	v14.BrakeMultiplier = brakeMultiplier
	v14.SteeringMultiplier = steeringMultiplier
	v14.DownforceMultiplier = downforceMultiplier
end

local function fn24(arg)
	local v14 = fn15(arg)
	if not v14 then
		return
	end
	local gripValue = v3.RunawaysVehicleTireGrip.Value
	if v14.GripApplied and v14.GripValue == gripValue then
		return
	end

	for _, v15 in v14.Wheels, nil, nil do
		local part = v15.Part

		if part.Parent then
			local properties = v15.Properties or part.CurrentPhysicalProperties
			part.CustomPhysicalProperties = PhysicalProperties.new(properties.Density, gripValue, properties.Elasticity, properties.FrictionWeight, properties.ElasticityWeight)
		end
	end

	v14.GripApplied = true
	v14.GripValue = gripValue
end

local function fn25()
	local v14 = fn10()

	if v9 and v9 ~= v14 then
		fn18(v9)
	end

	v9 = v14

	if v14 then
		if v2.RunawaysVehiclePerformance and v2.RunawaysVehiclePerformance.Value then
			fn23(v14)
		else
			fn16(v14)
		end

		if v2.RunawaysVehicleTireGripOverride and v2.RunawaysVehicleTireGripOverride.Value then
			fn24(v14)
		else
			fn17(v14)
		end

		if v2.RunawaysVehicleInfiniteFuel and v2.RunawaysVehicleInfiniteFuel.Value then
			v.VehicleMods:ApplyFuel(v14)
		else
			v.VehicleMods:RestoreFuel(v14)
		end
	end

	v14 = v14 or fn13()
	local value = v2.RunawaysVehicleIndestructible and v2.RunawaysVehicleIndestructible.Value
	fn14(value)
	if not v14 then
		return
	end
	local vehicleProperty = v14:FindFirstChild("VehicleProperty")

	if value then
		local vehicleHealth = v14:FindFirstChild("vehicleHealth")
		vehicleProperty = vehicleProperty and vehicleProperty:GetAttribute("MaxHealth")

		if vehicleHealth and type(vehicleProperty) == "number" then
			vehicleHealth.Value = vehicleProperty
		end
	end
end

local function fn26(arg)
	local tbl14 = obj[arg]

	if not tbl14 then
		tbl14 = {}
		obj[arg] = tbl14
	end

	return tbl14
end

local function fn27()
	for k, v14 in obj, nil, nil do
		if v14.WalkSpeed ~= nil then
			if k.Parent then
				k.WalkSpeed = v14.WalkSpeed
			end

			v14.WalkSpeed = nil
		end
	end
end

local function fn28()
	for k, v14 in obj, nil, nil do
		if v14.UseJumpPower ~= nil then
			if k.Parent then
				k.JumpPower = v14.JumpPower
				k.JumpHeight = v14.JumpHeight
				k.UseJumpPower = v14.UseJumpPower
			end

			v14.UseJumpPower = nil
			v14.JumpPower = nil
			v14.JumpHeight = nil
		end
	end
end

local function fn29()
	for k, v14 in obj2, nil, nil do
		if k.Parent then
			k.CanCollide = v14
		end
	end

	table.clear(obj2)
end

local function fn30(arg)
	if FlowClient.PlayerDamage and type(takeDamage) == "function" then
		if arg then
			FlowClient.PlayerDamage.TakeDamage = takeDamage2
		elseif FlowClient.PlayerDamage.TakeDamage == takeDamage2 then
			FlowClient.PlayerDamage.TakeDamage = takeDamage
		end
	end

	if FlowClient.Passout and type(abandon) == "function" then
		if arg then
			FlowClient.Passout.Abandon = takeDamage2
		elseif FlowClient.Passout.Abandon == takeDamage2 then
			FlowClient.Passout.Abandon = abandon
		end
	end
end

local function fn31()
	fn30(false)

	for k, v14 in obj, nil, nil do
		local godMode = v14.GodMode

		if godMode then
			if k.Parent then
				k.BreakJointsOnDeath = godMode.BreakJointsOnDeath
				k.RequiresNeck = godMode.RequiresNeck
				k:SetStateEnabled(Enum.HumanoidStateType.Dead, godMode.DeadEnabled)
			end

			v14.GodMode = nil
		end
	end
end

local function fn32(arg)
	local v14 = fn26(arg)

	if not v14.GodMode then
		v14.GodMode = {
			BreakJointsOnDeath = arg.BreakJointsOnDeath,
			RequiresNeck = arg.RequiresNeck,
			DeadEnabled = arg:GetStateEnabled(Enum.HumanoidStateType.Dead),
		}
	end

	fn30(true)
	arg.BreakJointsOnDeath = false
	arg.RequiresNeck = false
	arg:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
	arg.Health = arg.MaxHealth

	if arg:GetAttribute("Downed") == true then
		arg:SetAttribute("Downed", false)
		arg:ChangeState(Enum.HumanoidStateType.GettingUp)
	end
end

local function fn33()
	local v14 = fn9()

	if v14 and (v2.RunawaysPlayerGodMode and v2.RunawaysPlayerGodMode.Value or v.AutoFarm and v.AutoFarm.Running and v.AutoFarm:GetContext() == "Game") then
		fn32(v14)
	end

	if v14 and v14.Health > 0 then
		local v15 = fn26(v14)

		if v2.RunawaysPlayerSpeedBoost and v2.RunawaysPlayerSpeedBoost.Value then
			if v15.WalkSpeed == nil then
				v15.WalkSpeed = v14.WalkSpeed
			end

			v14.WalkSpeed = v3.RunawaysPlayerWalkSpeed.Value
		end

		if v2.RunawaysPlayerJumpPowerOverride and v2.RunawaysPlayerJumpPowerOverride.Value then
			if v15.UseJumpPower == nil then
				v15.UseJumpPower = v14.UseJumpPower
				v15.JumpPower = v14.JumpPower
				v15.JumpHeight = v14.JumpHeight
			end

			v14.UseJumpPower = true
			v14.JumpPower = v3.RunawaysPlayerJumpPower.Value
		end
	end

	if v2.RunawaysPlayerNoclip and v2.RunawaysPlayerNoclip.Value then
		local character = localPlayer.Character

		if character then
			for _, v15 in character:QueryDescendants("BasePart") do
				if obj2[v15] == nil then
					obj2[v15] = v15.CanCollide
				end

				v15.CanCollide = false
			end
		end
	end

	fn25()
end

local n2 = 0
local n3 = 0
local str2 = ""
local tbl14 = { Guns = true, RPG7 = true, GrenadeLauncher = true, Minigun = true, Flamethrower = true }

local function fn34(arg)
	return v2[arg] and v2[arg].Value == true
end

local function fn35(arg)
	if not arg or not arg:IsA("Tool") then
		return
	end
	local ok, result = pcall(module.Tools.GetToolConfig, arg:GetAttribute("BaseTool") or arg.Name)
	if not ok or type(result) ~= "table" then
		return
	end

	if type(result.magCapacity) ~= "number" or type(result.recoilPattern) ~= "table" or type(result.maxRpm) ~= "number" then
		return
	end
	return result
end

local function fn36(arg)
	local v14 = obj4[arg]
	if v14 then
		return v14
	end

	local tbl15 = {
		HasMaxRpm = arg.maxRpm ~= nil,
		MaxRpm = arg.maxRpm,
		HasMode = arg.mode ~= nil,
		Mode = arg.mode,
		HasPushForce = arg.pushForce ~= nil,
		PushForce = arg.pushForce,
	}

	obj4[arg] = tbl15
	return tbl15
end

local function fn37(arg, arg2)
	local RunawaysWeaponNoCooldown = fn34("RunawaysWeaponNoCooldown")
	local RunawaysWeaponAutomatic = fn34("RunawaysWeaponAutomatic")
	local RunawaysWeaponNoPushback = fn34("RunawaysWeaponNoPushback")
	local concat = table.concat
	local tbl15 = {}
	local str3 = tostring(RunawaysWeaponNoCooldown)
	local str4 = tostring(RunawaysWeaponAutomatic)
	local v14 = tostring
	tbl15[1] = str3
	tbl15[2] = str4

	do
		local values = table.pack(v14(RunawaysWeaponNoPushback))
		table.move(values, 1, values.n, 3, tbl15)
	end

	local v15 = concat(tbl15, ":")
	if arg2.Signature == v15 then
		return
	end

	if arg2.HasMaxRpm then
		arg.maxRpm = RunawaysWeaponNoCooldown and math.huge or arg2.MaxRpm
	end

	if arg2.HasMode then
		arg.mode = RunawaysWeaponAutomatic and "auto" or arg2.Mode
	end

	if RunawaysWeaponNoPushback then
		arg.pushForce = nil
	elseif arg2.HasPushForce then
		arg.pushForce = arg2.PushForce
	else
		arg.pushForce = nil
	end

	arg2.Signature = v15
end

local function fn38()
	for k, v14 in obj4, nil, nil do
		if v14.HasMaxRpm then
			k.maxRpm = v14.MaxRpm
		end

		if v14.HasMode then
			k.mode = v14.Mode
		end

		if v14.HasPushForce then
			k.pushForce = v14.PushForce
		else
			k.pushForce = nil
		end

		v14.Signature = nil
	end
end

local function fn39(arg)
	if type(arg) ~= "function" or type(debug.info) ~= "function" then
		return
	end
	local ok, result = pcall(debug.info, arg, "s")
	if not ok or type(result) ~= "string" then
		return
	end

	for k in tbl14, nil, nil do
		if result:find("FlowClient.Tools." .. k, 1, true) then
			return k
		end
	end
end

local function fn40(arg)
	if type(arg) == "function" then
		return { arg }
	end
	local tbl15 = {}

	if type(arg) == "table" then
		for _, v14 in arg, nil, nil do
			if type(v14) == "function" then
				tbl15[#tbl15 + 1] = v14
			end
		end
	end

	return tbl15
end

local function fn41(arg, arg2)
	if type(filtergc) ~= "function" then
		return {}
	end
	local ok, result = pcall(filtergc, "function", { Name = arg, Upvalues = arg2 }, false)
	return ok and fn40(result) or {}
end

local function fn42(arg)
	if type(arg) ~= "function" or type(debug.getupvalues) ~= "function" then
		return {}
	end
	local ok, result = pcall(debug.getupvalues, arg)
	return ok and result or {}
end

local function fn43(arg, arg2, arg3)
	if type(debug.setupvalue) ~= "function" then
		return
	end
	local tbl15 = { Tool = arg, Config = arg2, Fires = {}, Shoots = {} }
	local tbl16 = {}
	local tbl17 = {}

	for _, v14 in fn41("fire", { arg }) do
		local v15 = fn39(v14)

		if v15 and not tbl16[v14] then
			tbl16[v14] = true
			local n4 = v15 == "Flamethrower" and 9 or 1
			local ok, result = pcall(debug.getupvalue, v14, n4)

			if ok and type(result) == "number" then
				tbl15.Fires[#tbl15.Fires + 1] = { Function = v14, Index = n4 }
			end

			for _, v16 in fn41("shoot", { v14 }) do
				if fn39(v16) and not tbl17[v16] then
					tbl17[v16] = true
					local tbl18 = { Function = v16, Rpm = {}, Mode = {} }

					for k, v17 in fn42(v16) do
						if arg3.HasMaxRpm and type(v17) == "number" and (v17 == arg3.MaxRpm or v17 == arg2.maxRpm) then
							tbl18.Rpm[#tbl18.Rpm + 1] = k
						elseif arg3.HasMode and type(v17) == "string" and (v17 == arg3.Mode or v17 == arg2.mode) then
							tbl18.Mode[#tbl18.Mode + 1] = k
						end
					end

					tbl15.Shoots[#tbl15.Shoots + 1] = tbl18
				end
			end
		end
	end

	if #tbl15.Fires == 0 and #tbl15.Shoots == 0 then
		return
	end
	return tbl15
end

local function fn44(arg, arg2, arg3)
	pcall(debug.setupvalue, arg, arg2, arg3)
end

tbl11.FindFunction = function(arg, arg2)
	local character = localPlayer.Character

	if arg.Character ~= character then
		arg.Character = character
		arg.Function = nil
		arg.SpeedIndex = nil
		arg.LastSearch = 0
	end

	if arg.Function then
		return arg.Function
	end
	local flag2 = not character

	if not flag2 then
		flag2 = not arg2

		if flag2 then
			local lastSearch = arg.LastSearch
			flag2 = os.clock() - lastSearch < 0.5
		end
	end

	if flag2 then
		return
	end
	arg.LastSearch = os.clock()

	for _, v14 in fn41("doPunch") do
		local v15 = fn42(v14)

		if v15[2] == character and v15[16] == arg.Config and type(v15[19]) == "number" then
			arg.Function = v14
			arg.SpeedIndex = 19
			return v14
		end
	end
end

tbl11.GetConfigState = function(arg, arg2)
	local tbl15 = arg.ConfigStates[arg2]

	if not tbl15 then
		tbl15 = { Damage = arg2.damage, Speed = arg2.hitsPerSecond, ObjectDamage = arg2.destructibleDamage }
		arg.ConfigStates[arg2] = tbl15
	end

	return tbl15
end

tbl11.FindMeleeFunction = function(arg, arg2)
	local character = localPlayer.Character
	character = character and character:FindFirstChildOfClass("Tool")

	if not character or not character:HasTag("Melee") then
		character = nil
	end

	if arg.MeleeTool ~= character then
		arg.MeleeTool = character
		arg.MeleeConfig = nil
		arg.MeleeFunction = nil
		arg.MeleeSpeedIndex = nil
		arg.MeleeLastSearch = 0
	end

	if arg.MeleeFunction then
		return arg.MeleeFunction
	end
	local flag2 = not character

	if not flag2 then
		flag2 = not arg2

		if flag2 then
			local meleeLastSearch = arg.MeleeLastSearch
			flag2 = os.clock() - meleeLastSearch < 0.5
		end
	end

	if flag2 then
		return
	end
	arg.MeleeLastSearch = os.clock()
	local attribute = character:GetAttribute("BaseTool")
	local meleeConfig = module.Tools.GetToolConfig(character.Name) or type(attribute) == "string" and module.Tools.GetToolConfig(attribute)
	if type(meleeConfig) ~= "table" or type(meleeConfig.damage) ~= "number" or type(meleeConfig.hitsPerSecond) ~= "number" or type(meleeConfig.destructibleDamage) ~= "number" then
		return
	end
	arg.MeleeConfig = meleeConfig
	arg:GetConfigState(meleeConfig)

	for _, v14 in fn41("doSwing", { character }) do
		local v15 = fn42(v14)

		if v15[7] == character and v15[12] == meleeConfig and type(v15[15]) == "number" then
			arg.MeleeFunction = v14
			arg.MeleeSpeedIndex = 15
			arg.MeleeRuntimes[v14] = { Config = meleeConfig, Index = 15 }
			return v14
		end
	end
end

tbl11.Apply = function(arg, arg2)
	local value = v2.RunawaysPunchMods and v2.RunawaysPunchMods.Value
	local damage3 = arg.Defaults.Damage
	local speed = arg.Defaults.Speed
	local objectDamage = arg.Defaults.ObjectDamage

	if value then
		damage3 = v3.RunawaysPunchDamage.Value
		speed = v2.RunawaysPunchNoCooldown.Value and math.huge or v3.RunawaysPunchSpeed.Value
		objectDamage = v3.RunawaysPunchObjectDamage.Value
	end

	for _, v14 in arg.Configs, nil, nil do
		local configState = arg:GetConfigState(v14)
		v14.damage = value and damage3 or configState.Damage
		v14.hitsPerSecond = value and speed or configState.Speed
		v14.destructibleDamage = value and objectDamage or configState.ObjectDamage
	end

	local v14 = arg:FindFunction(arg2)

	if v14 and arg.SpeedIndex and type(debug.getupvalue) == "function" then
		local ok, result = pcall(debug.getupvalue, v14, arg.SpeedIndex)

		if ok and result ~= speed then
			fn44(v14, arg.SpeedIndex, speed)
		end
	end

	local v15 = arg:FindMeleeFunction(arg2)

	if v15 and arg.MeleeSpeedIndex and arg.MeleeConfig and type(debug.getupvalue) == "function" then
		local configState = arg:GetConfigState(arg.MeleeConfig)
		speed = value and speed or configState.Speed
		local ok, result = pcall(debug.getupvalue, v15, arg.MeleeSpeedIndex)

		if ok and result ~= speed then
			fn44(v15, arg.MeleeSpeedIndex, speed)
		end
	end
end

tbl11.Restore = function(arg)
	for k, v14 in arg.ConfigStates, nil, nil do
		k.damage = v14.Damage
		k.hitsPerSecond = v14.Speed
		k.destructibleDamage = v14.ObjectDamage
	end

	if arg.Function and arg.SpeedIndex then
		fn44(arg.Function, arg.SpeedIndex, arg.Defaults.Speed)
	end

	for k, v14 in arg.MeleeRuntimes, nil, nil do
		local v15 = arg.ConfigStates[v14.Config]

		if v15 then
			fn44(k, v14.Index, v15.Speed)
		end
	end

	arg.Character = nil
	arg.Function = nil
	arg.SpeedIndex = nil
	arg.LastSearch = 0
	arg.MeleeTool = nil
	arg.MeleeConfig = nil
	arg.MeleeFunction = nil
	arg.MeleeSpeedIndex = nil
	arg.MeleeLastSearch = 0
	arg.MeleeRuntimes = setmetatable({}, { __mode = "k" })
end

local function fn45(arg, arg2)
	if not arg or type(arg2) ~= "number" then
		return
	end

	for _, v14 in arg.Fires, nil, nil do
		fn44(v14.Function, v14.Index, arg2)
	end
end

local function fn46()
	local v14 = v13
	if not v14 then
		return
	end
	local attribute = v14.Tool and v14.Tool:GetAttribute("Ammo")

	if type(attribute) == "number" then
		fn45(v14, attribute)
	end

	local v15 = obj4[v14.Config]

	for _, v16 in v14.Shoots, nil, nil do
		if v15 then
			for _, v17 in v16.Rpm, nil, nil do
				fn44(v16.Function, v17, v15.MaxRpm)
			end

			for _, v17 in v16.Mode, nil, nil do
				fn44(v16.Function, v17, v15.Mode)
			end
		end
	end

	v13 = nil
end

local function fn47(arg, arg2)
	return math.max(tonumber(arg2.magCapacity) or tonumber(arg:GetAttribute("MaxAmmo")) or tonumber(arg:GetAttribute("Ammo")) or 1, 1)
end

local function fn48(arg, arg2)
	local RunawaysWeaponNoCooldown = fn34("RunawaysWeaponNoCooldown")
	local RunawaysWeaponAutomatic = fn34("RunawaysWeaponAutomatic")

	for _, v14 in arg.Shoots, nil, nil do
		for _, v15 in v14.Rpm, nil, nil do
			fn44(v14.Function, v15, RunawaysWeaponNoCooldown and math.huge or arg2.MaxRpm)
		end

		for _, v15 in v14.Mode, nil, nil do
			fn44(v14.Function, v15, RunawaysWeaponAutomatic and "auto" or arg2.Mode)
		end
	end

	if fn34("RunawaysWeaponInfiniteAmmo") then
		fn45(arg, fn47(arg.Tool, arg.Config))
		arg.InfiniteAmmo = true
	elseif arg.InfiniteAmmo then
		local attribute = arg.Tool:GetAttribute("Ammo")

		if type(attribute) == "number" then
			fn45(arg, attribute)
		end

		arg.InfiniteAmmo = false
	end
end

local function fn49()
	for k, v14 in obj4, nil, nil do
		fn37(k, v14)
	end

	local character = localPlayer.Character
	character = character and character:FindFirstChildOfClass("Tool")
	local v14 = fn35(character)

	if not v14 then
		character = nil
	end

	if character ~= v11 then
		fn46()
		v11 = character
		v12 = v14
		n2 = 0
		n3 = 0
	else
		v12 = v14
	end

	if not character or not v14 then
		return
	end
	local v15 = fn36(v14)
	fn37(v14, v15)
	local RunawaysWeaponInfiniteAmmo = fn34("RunawaysWeaponInfiniteAmmo") or fn34("RunawaysWeaponNoCooldown") or fn34("RunawaysWeaponAutomatic")
	local concat = table.concat
	local tbl15 = {}
	local str3 = tostring(fn34("RunawaysWeaponInfiniteAmmo"))
	local str4 = tostring(fn34("RunawaysWeaponNoCooldown"))
	local v16 = table.pack(tostring(fn34("RunawaysWeaponAutomatic")))
	tbl15[1] = str3
	tbl15[2] = str4
	table.move(v16, 1, v16.n, 3, tbl15)
	local v17 = concat(tbl15, ":")

	if v17 ~= str2 then
		str2 = v17
		n2 = 0
		n3 = 0
	end

	if RunawaysWeaponInfiniteAmmo and not v13 and os.clock() >= n2 then
		n3 += 1
		n2 = os.clock() + (n3 <= 3 and 0.2 or 1.5)
		v13 = fn43(character, v14, v15)
	end

	if v13 then
		fn48(v13, v15)
	end
end

local function setAmmo2(arg, arg2, ...)
	if fn34("RunawaysWeaponInfiniteAmmo") and arg == v11 and v13 and v12 then
		fn45(v13, fn47(arg, v12))
		return
	end
	return setAmmo(arg, arg2, ...)
end

local function substractReserve2(arg, arg2, ...)
	if fn34("RunawaysWeaponInfiniteAmmo") and arg == v12 then
		return
	end
	local v14 = table.pack(...)
	local v15 = substractReserve
	v14.n = 3 + v14.n - 1
	table.move(v14, 1, v14.n, 3, v14)
	v14[1] = arg
	v14[2] = arg2
	return v15(table.unpack(v14, 1, v14.n))
end

local function recoil3(...)
	if fn34("RunawaysWeaponNoRecoil") then
		return
	end
	return recoil(...)
end

local function recoil4(...)
	if fn34("RunawaysWeaponNoRecoil") then
		return
	end
	return recoil2(...)
end

local function radialFalloff2(...)
	if fn34("RunawaysWeaponNoSpread") and type(debug.info) == "function" then
		local v14 = debug.info(2, "f")
		if fn39(v14) then
			return Vector2.zero
		end
	end

	return radialFalloff(...)
end

local v14 = Drawing
local flag2 = type(v14) == "table" and type(v14.new) == "function"
local tbl15 = { Items = {}, NPCs = {}, Players = {}, Vehicles = {}, Safes = {} }
local tbl16 = { Items = {}, NPCs = {}, Players = {}, Vehicles = {}, Safes = {} }

local tbl17 = {
	Items = {
		Toggle = "RunawaysESPItems",
		Color = "RunawaysESPItemColor",
		Box = "RunawaysESPItemBox",
		Tracer = "RunawaysESPItemTracer",
		Distance = "RunawaysESPItemDistance",
		Range = "RunawaysESPItemMaxDistance",
	},
	NPCs = {
		Toggle = "RunawaysESPNPCs",
		Color = "RunawaysESPNPCColor",
		Box = "RunawaysESPNPCBox",
		Tracer = "RunawaysESPNPCTracer",
		HealthBar = "RunawaysESPNPCHealthBar",
		Distance = "RunawaysESPNPCDistance",
		Range = "RunawaysESPNPCMaxDistance",
	},
	Players = {
		Toggle = "RunawaysESPPlayers",
		Color = "RunawaysESPPlayerColor",
		Box = "RunawaysESPPlayerBox",
		Tracer = "RunawaysESPPlayerTracer",
		HealthBar = "RunawaysESPPlayerHealthBar",
		Distance = "RunawaysESPPlayerDistance",
		Range = "RunawaysESPPlayerMaxDistance",
	},
	Vehicles = {
		Toggle = "RunawaysESPVehicles",
		Color = "RunawaysESPVehicleColor",
		Box = "RunawaysESPVehicleBox",
		Tracer = "RunawaysESPVehicleTracer",
		Distance = "RunawaysESPVehicleDistance",
		Range = "RunawaysESPVehicleMaxDistance",
	},
	Safes = {
		Toggle = "RunawaysESPSafes",
		Color = "RunawaysESPSafeColor",
		Box = "RunawaysESPSafeBox",
		Tracer = "RunawaysESPSafeTracer",
		Distance = "RunawaysESPSafeDistance",
		Range = "RunawaysESPSafeMaxDistance",
	},
}

local tbl18 = { UI = 0, System = 1, Plex = 2, Monospace = 3 }

local function fn50(arg)
	if not flag2 then
		return
	end
	local ok, result = pcall(v14.new, arg)
	if not ok or not result then
		flag2 = false
		return
	end
	result.Visible = false
	return result
end

local function fn51(arg)
	if not arg then
		return
	end
	arg.Visible = false

	if not pcall(function()
		arg:Remove()
	end) then
		pcall(function()
			arg:Destroy()
		end)
	end
end

local function fn52()
	if FlowClient.Ammo and type(setAmmo) == "function" then
		FlowClient.Ammo.setAmmo = setAmmo2
	end

	if FlowClient.Ammo and type(substractReserve) == "function" then
		FlowClient.Ammo.substractReserve = substractReserve2
	end

	if FlowClient.Camera and type(recoil) == "function" then
		FlowClient.Camera.Recoil = recoil3
	end

	if FlowClient.Viewmodel and type(recoil2) == "function" then
		FlowClient.Viewmodel.Recoil = recoil4
	end

	if luck and type(radialFalloff) == "function" then
		luck.radialFalloff = radialFalloff2
	end
end

local function fn53()
	if FlowClient.Ammo and FlowClient.Ammo.setAmmo == setAmmo2 then
		FlowClient.Ammo.setAmmo = setAmmo
	end

	if FlowClient.Ammo and FlowClient.Ammo.substractReserve == substractReserve2 then
		FlowClient.Ammo.substractReserve = substractReserve
	end

	if FlowClient.Camera and FlowClient.Camera.Recoil == recoil3 then
		FlowClient.Camera.Recoil = recoil
	end

	if FlowClient.Viewmodel and FlowClient.Viewmodel.Recoil == recoil4 then
		FlowClient.Viewmodel.Recoil = recoil2
	end

	if luck and luck.radialFalloff == radialFalloff2 then
		luck.radialFalloff = radialFalloff
	end
end

local function fn54(arg)
	local tbl19 = { Text = fn50("Text"), Box = fn50("Square"), Tracer = fn50("Line") }

	if arg == "NPCs" or arg == "Players" then
		tbl19.HealthBack = fn50("Line")
		tbl19.Health = fn50("Line")
	end

	if tbl19.Text then
		tbl19.Text.Center = true
		tbl19.Text.ZIndex = 3
	end

	if tbl19.Box then
		tbl19.Box.Filled = false
		tbl19.Box.ZIndex = 2
	end

	if tbl19.Tracer then
		tbl19.Tracer.ZIndex = 1
	end

	return tbl19
end

local function fn55(arg)
	for _, v15 in arg, nil, nil do
		v15.Visible = false
	end
end

local function fn56(arg)
	for k, v15 in arg, nil, nil do
		for _, v16 in v15, nil, nil do
			fn51(v16)
		end

		arg[k] = nil
	end
end

local function fn57()
	for _, v15 in tbl16, nil, nil do
		fn56(v15)
	end

	for _, v15 in tbl15, nil, nil do
		table.clear(v15)
	end
end

local function fn58()
	for _, v15 in tbl16, nil, nil do
		for _, v16 in v15, nil, nil do
			fn55(v16)
		end
	end
end

local function fn59(arg, arg2)
	local tbl19 = {}
	local v15 = tbl16[arg]

	for _, v16 in arg2, nil, nil do
		tbl19[v16] = true
	end

	for k, v16 in v15, nil, nil do
		if not tbl19[k] then
			for _, v17 in v16, nil, nil do
				fn51(v17)
			end

			v15[k] = nil
		end
	end

	tbl15[arg] = arg2
end

local function fn60(arg)
	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	return character and character.Position or arg.CFrame.Position
end

local function fn61(arg)
	local system = arg:FindFirstChild("system")
	return arg.PrimaryPart or system and system:FindFirstChild("chassis")
end

local function fn62(arg, arg2)
	if arg == "Items" then
		if not fn2(arg2) then
			return
		end
		return arg2, arg2.PrimaryPart
	end

	if arg == "NPCs" then
		local humanoid = arg2.Parent and arg2:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = arg2.Parent and arg2:FindFirstChild("HumanoidRootPart")
		if not humanoid or not humanoidRootPart then
			return
		end

		if v2.RunawaysESPNPCActiveOnly.Value and humanoid.Health <= 0 then
			return
		end
		return arg2, humanoidRootPart, humanoid
	end

	if arg == "Players" then
		local character = arg2.Parent == Players and arg2.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		if not humanoid or not humanoidRootPart or humanoid.Health <= 0 then
			return
		end
		return character, humanoidRootPart, humanoid
	end

	if arg == "Vehicles" then
		if not arg2.Parent then
			return
		end
		local findFirstChild = arg2.FindFirstChild
		return arg2, fn61(arg2), nil, findFirstChild(arg2, "vehicleHealth")
	end

	if arg == "Safes" and arg2.Parent then
		if arg2:IsA("Model") then
			return arg2, arg2.PrimaryPart or arg2:FindFirstChildWhichIsA("BasePart", true)
		end

		if arg2:IsA("BasePart") then
			return nil, arg2
		end
	end
end

local function fn63(arg, arg2)
	if arg then
		local ok, result, result2 = pcall(arg.GetBoundingBox, arg)
		if ok and result2.Magnitude > 0 then
			return result, result2
		end
	end

	if arg2 then
		return arg2.CFrame, arg2.Size
	end
end

local function fn64(arg, arg2, arg3)
	local huge = math.huge
	local huge2 = math.huge
	local n4 = -math.huge
	local n5 = -math.huge

	for _, v15 in { -1, 1 }, nil, nil do
		for _, v16 in { -1, 1 }, nil, nil do
			for _, v17 in { -1, 1 }, nil, nil do
				local v18 = arg:WorldToViewportPoint(arg2:PointToWorldSpace(Vector3.new(arg3.X * v15, arg3.Y * v16, arg3.Z * v17) * 0.5))
				if v18.Z <= 0 then
					return
				end
				huge = math.min(huge, v18.X)
				huge2 = math.min(huge2, v18.Y)
				n4 = math.max(n4, v18.X)
				n5 = math.max(n5, v18.Y)
			end
		end
	end

	local viewportSize = arg.ViewportSize
	if n4 < 0 or n5 < 0 or huge > viewportSize.X or huge2 > viewportSize.Y then
		return
	end
	local n6 = math.clamp(huge, -64, viewportSize.X + 64)
	local n7 = math.clamp(huge2, -64, viewportSize.Y + 64)
	local n8 = math.clamp(n4, -64, viewportSize.X + 64)
	local n9 = math.clamp(n5, -64, viewportSize.Y + 64)
	local vector2 = Vector2.new
	return Vector2.new(n6, n7), vector2(n8 - n6, n9 - n7)
end

local function fn65(arg, arg2, arg3, arg4, arg5)
	local tbl19 = {}

	if arg == "Items" then
		if v2.RunawaysESPItemName.Value then
			tbl19[#tbl19 + 1] = fn4(arg2.Name)
		end

		if v2.RunawaysESPItemCategory.Value then
			tbl19[#tbl19 + 1] = fn4(tbl3[arg2.Name] or "Unknown")
		end

		if v2.RunawaysESPItemPrice.Value then
			tbl19[#tbl19 + 1] = "$" .. tostring(tbl4[arg2.Name] or 0)
		end
	elseif arg == "NPCs" then
		if v2.RunawaysESPNPCName.Value then
			tbl19[#tbl19 + 1] = fn4(arg2.Name)
		end

		if v2.RunawaysESPNPCHealth.Value and arg3.Health >= 0 then
			tbl19[#tbl19 + 1] = string.format("%d/%d HP", arg3.Health, arg3.MaxHealth)
		end
	elseif arg == "Players" then
		if v2.RunawaysESPPlayerName.Value then
			local displayName = arg2.DisplayName

			if arg2.DisplayName ~= arg2.Name then
				displayName ..= " (@" .. arg2.Name .. ")"
			end

			tbl19[#tbl19 + 1] = displayName
		end

		if v2.RunawaysESPPlayerHealth.Value then
			tbl19[#tbl19 + 1] = string.format("%d/%d HP", arg3.Health, arg3.MaxHealth)
		end
	elseif arg == "Vehicles" then
		if v2.RunawaysESPVehicleName.Value then
			tbl19[#tbl19 + 1] = fn4(arg2.Name)
		end

		if v2.RunawaysESPVehicleHealth.Value and arg4 then
			tbl19[#tbl19 + 1] = tostring(math.round(arg4.Value)) .. " HP"
		end
	elseif arg == "Safes" and v2.RunawaysESPSafeName.Value then
		tbl19[#tbl19 + 1] = fn4(arg2.Name)
	end

	if v2[tbl17[arg].Distance].Value then
		tbl19[#tbl19 + 1] = tostring(math.round(arg5)) .. " studs"
	end

	return table.concat(tbl19, " | ")
end

local function fn66(arg, arg2)
	local runawaysESPItemHighValueColor = v3[tbl17[arg].Color]
	local value = arg == "Items" and v2.RunawaysESPItemHighValue.Value

	if value then
		value = (tonumber(tbl4[arg2.Name]) or 0) >= v3.RunawaysESPItemHighValueThreshold.Value
	end

	if value then
		runawaysESPItemHighValueColor = v3.RunawaysESPItemHighValueColor
	end

	return runawaysESPItemHighValueColor.Value, 1 - runawaysESPItemHighValueColor.Transparency
end

local function fn67(arg)
	local value = v3.RunawaysESPTracerOrigin.Value
	if value == "Center" then
		return arg.ViewportSize * 0.5
	end

	if value == "Mouse" and UserInputService.MouseEnabled then
		return UserInputService:GetMouseLocation()
	end

	if value == "Mouse" then
		return arg.ViewportSize * 0.5
	end
	return Vector2.new(arg.ViewportSize.X * 0.5, arg.ViewportSize.Y)
end

local function fn68(arg, arg2, arg3, arg4, arg5)
	local v15, v16, v17, v18 = fn62(arg, arg2)
	if not v16 then
		fn55(arg3)
		return
	end
	local magnitude = (v16.Position - arg5).Magnitude
	if v3[tbl17[arg].Range].Value < magnitude then
		fn55(arg3)
		return
	end
	local v19, v20 = arg4:WorldToViewportPoint(v16.Position)
	if v19.Z <= 0 or not v20 then
		fn55(arg3)
		return
	end
	local value = v2[tbl17[arg].Box].Value
	local flag3 = tbl17[arg].HealthBar and v2[tbl17[arg].HealthBar].Value and v17 and v17.Health >= 0 and v17.MaxHealth > 0
	local vector2 = Vector2.new(v19.X, v19.Y)
	local vector22 = Vector2.zero

	if value or flag3 then
		local v21, v22 = fn63(v15, v16)
		if not v21 then
			fn55(arg3)
			return
		end
		vector2, vector22 = fn64(arg4, v21, v22)
		if not vector2 then
			fn55(arg3)
			return
		end
	end

	local v21, v22 = fn66(arg, arg2)
	local v23 = fn65(arg, arg2, v17, v18, magnitude)
	local thickness = v3.RunawaysESPBoxThickness.Value

	if arg3.Text and v23 ~= "" then
		arg3.Text.Text = v23
		arg3.Text.Position = Vector2.new(vector2.X + vector22.X * 0.5, math.max(0, vector2.Y - v3.RunawaysESPTextSize.Value - 2))
		arg3.Text.Size = v3.RunawaysESPTextSize.Value
		arg3.Text.Font = tbl18[v3.RunawaysESPFont.Value] or 2
		arg3.Text.Color = v21
		arg3.Text.Transparency = v22
		arg3.Text.Outline = v2.RunawaysESPTextOutline.Value
		arg3.Text.OutlineColor = v3.RunawaysESPOutlineColor.Value
		arg3.Text.Visible = true
	elseif arg3.Text then
		arg3.Text.Visible = false
	end

	if arg3.Box and value then
		arg3.Box.Position = vector2
		arg3.Box.Size = vector22
		arg3.Box.Color = v21
		arg3.Box.Transparency = v22
		arg3.Box.Thickness = thickness
		arg3.Box.Visible = true
	elseif arg3.Box then
		arg3.Box.Visible = false
	end

	if arg3.Tracer and v2[tbl17[arg].Tracer].Value then
		arg3.Tracer.From = fn67(arg4)
		arg3.Tracer.To = Vector2.new(vector2.X + vector22.X * 0.5, vector2.Y + vector22.Y)
		arg3.Tracer.Color = v21
		arg3.Tracer.Transparency = v22
		arg3.Tracer.Thickness = thickness
		arg3.Tracer.Visible = true
	elseif arg3.Tracer then
		arg3.Tracer.Visible = false
	end

	if arg3.Health and flag3 then
		local n4 = math.clamp(v17.Health / v17.MaxHealth, 0, 1)
		local n5 = vector2.X - 4
		local n6 = vector2.Y + vector22.Y
		arg3.HealthBack.From = Vector2.new(n5, n6)
		arg3.HealthBack.To = Vector2.new(n5, vector2.Y)
		arg3.HealthBack.Color = Color3.new(0, 0, 0)
		arg3.HealthBack.Transparency = v22
		arg3.HealthBack.Thickness = thickness + 2
		arg3.HealthBack.Visible = true
		arg3.Health.From = Vector2.new(n5, n6)
		arg3.Health.To = Vector2.new(n5, n6 - vector22.Y * n4)
		arg3.Health.Color = Color3.fromHSV(n4 * 0.33, 1, 1)
		arg3.Health.Transparency = v22
		arg3.Health.Thickness = thickness
		arg3.Health.Visible = true
	elseif arg3.Health then
		arg3.Health.Visible = false
		arg3.HealthBack.Visible = false
	end
end

local function fn69()
	if not v2.RunawaysESPEnabled or not v2.RunawaysESPEnabled.Value then
		return
	end

	if not flag2 then
		fn58()
		return
	end
	local currentCamera = workspace.CurrentCamera
	if not currentCamera then
		fn58()
		return
	end
	local v15 = fn60(currentCamera)

	for k, v16 in tbl15, nil, nil do
		local v17 = tbl16[k]

		if v2[tbl17[k].Toggle].Value then
			for _, v18 in v16, nil, nil do
				local v19 = v17[v18]

				if not v19 then
					v19 = fn54(k)
					v17[v18] = v19
				end

				fn68(k, v18, v19, currentCamera, v15)
			end
		else
			for _, v18 in v17, nil, nil do
				fn55(v18)
			end
		end
	end
end

local function fn70()
	if not flag2 or not v2.RunawaysESPEnabled.Value then
		fn57()
		return
	end
	local currentCamera = workspace.CurrentCamera
	local v15 = currentCamera and fn60(currentCamera)
	local tbl19 = {}
	local tbl20 = {}
	local tbl21 = {}
	local tbl22 = {}
	local tbl23 = {}

	local function fn71(arg, arg2)
		return arg and (not v15 or (arg.Position - v15).Magnitude <= arg2)
	end

	if v2.RunawaysESPItems.Value and loot then
		local value = v3.RunawaysESPItemCategories.Value
		local flag3 = next(value) ~= nil
		local tbl24 = {}

		for _, v16 in loot:GetChildren() do
			local v17 = tbl3[v16.Name]
			local n4 = tonumber(tbl4[v16.Name]) or 0

			if fn2(v16) and n4 >= v3.RunawaysESPItemMinValue.Value and (not flag3 or value[v17]) then
				local magnitude = v15 and (v16.PrimaryPart.Position - v15).Magnitude or 0

				if magnitude <= v3.RunawaysESPItemMaxDistance.Value then
					tbl24[#tbl24 + 1] = { Target = v16, Distance = magnitude }
				end
			end
		end

		table.sort(tbl24, function(arg, arg2)
			return arg.Distance < arg2.Distance
		end)

		for i = 1, math.min(#tbl24, v3.RunawaysESPMaxItems.Value) do
			tbl19[i] = tbl24[i].Target
		end
	end

	if v2.RunawaysESPNPCs.Value then
		local npCs = workspace:FindFirstChild("NPCs")

		if npCs then
			local tbl24 = {}

			for _, v16 in npCs:QueryDescendants("Humanoid") do
				local parent = v16.Parent
				local humanoidRootPart = parent and parent:FindFirstChild("HumanoidRootPart")

				if parent and parent:IsA("Model") and not tbl24[parent] and fn71(humanoidRootPart, v3.RunawaysESPNPCMaxDistance.Value) and (not v2.RunawaysESPNPCActiveOnly.Value or v16.Health > 0) then
					tbl24[parent] = true
					tbl20[#tbl20 + 1] = parent
					if not (#tbl20 >= 100) then
						continue
					end
				else
					continue
				end

				break
			end
		end
	end

	if v2.RunawaysESPPlayers.Value then
		for _, v16 in Players:GetPlayers() do
			local character = v16.Character
			character = character and character:FindFirstChild("HumanoidRootPart")

			if v16 ~= localPlayer and fn71(character, v3.RunawaysESPPlayerMaxDistance.Value) then
				tbl21[#tbl21 + 1] = v16
			end
		end
	end

	if v2.RunawaysESPVehicles.Value then
		local vehicles = workspace:FindFirstChild("Vehicles")

		if vehicles then
			for _, v16 in vehicles:GetChildren() do
				local isModel = v16:IsA("Model") and fn61(v16)

				if isModel and fn71(isModel, v3.RunawaysESPVehicleMaxDistance.Value) then
					tbl22[#tbl22 + 1] = v16
					if not (#tbl22 >= 100) then
						continue
					end
				else
					continue
				end

				break
			end
		end
	end

	if v2.RunawaysESPSafes.Value then
		for _, v16 in CollectionService:GetTagged("Safe") do
			local Safes, v17 = fn62("Safes", v16)

			if v16:IsDescendantOf(workspace) and fn71(v17, v3.RunawaysESPSafeMaxDistance.Value) then
				tbl23[#tbl23 + 1] = v16
				if not (#tbl23 >= 100) then
					continue
				end
			else
				continue
			end

			break
		end
	end

	fn59("Items", tbl19)
	fn59("NPCs", tbl20)
	fn59("Players", tbl21)
	fn59("Vehicles", tbl22)
	fn59("Safes", tbl23)
end

local tbl19 = {
	Entries = {},
	Signature = "",
	Busy = false,
	Token = nil,
	Context = nil,
	GetCashValue = function()
		local leaderstats = localPlayer:FindFirstChild("leaderstats")
		leaderstats = leaderstats and leaderstats:FindFirstChild("Cash 💵")
		if leaderstats and (leaderstats:IsA("NumberValue") or leaderstats:IsA("IntValue")) then
			return leaderstats.Value
		end
		local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
		playerGui = playerGui and playerGui:FindFirstChild("HudGui")
		playerGui = playerGui and playerGui:FindFirstChild("BottomPanel")
		playerGui = playerGui and playerGui:FindFirstChild("CashAmount")
		playerGui = playerGui and playerGui:FindFirstChild("CashAmount")
		playerGui = playerGui and playerGui.Text:gsub("[^%d]", "")
		return playerGui and tonumber(playerGui)
	end,
	CountNamedTools = function(arg, arg2)
		local character = localPlayer.Character
		local n4 = 0

		for _, v15 in { localPlayer:FindFirstChildOfClass("Backpack"), character }, nil, nil do
			if v15 then
				for _, v16 in v15:GetChildren() do
					if v16:IsA("Tool") and v16.Name == arg2 then
						n4 += 1
					end
				end
			end
		end

		return n4
	end,
	DidPurchase = function(arg, arg2, arg3, arg4)
		if arg4 < arg:CountNamedTools(arg2.Name) then
			return true
		end
		local cashValue = arg:GetCashValue()
		return arg2.Price ~= nil and arg2.Price > 0 and arg3 ~= nil and cashValue ~= nil and arg3 - cashValue == arg2.Price
	end,
	Refresh = function(arg, arg2)
		local character = localPlayer.Character
		character = character and character:FindFirstChild("HumanoidRootPart")
		local tbl19 = {}

		for _, v15 in CollectionService:GetTagged("BuyableItem") do
			local attribute = v15:IsA("BasePart") and v15:GetAttribute("ItemName")
			local buyPrompt = v15:IsDescendantOf(workspace) and v15:FindFirstChild("BuyPrompt")

			if type(attribute) == "string" and attribute ~= "" and buyPrompt and buyPrompt:IsA("ProximityPrompt") and buyPrompt.Enabled then
				local magnitude = character and (v15.Position - character.Position).Magnitude or 0
				local v16 = tbl19[attribute]

				if not v16 or magnitude < v16.Distance then
					local v17 = tonumber
					local str3 = buyPrompt.ActionText:gsub("[^%d]", "")

					tbl19[attribute] = {
						Name = attribute,
						Part = v15,
						Prompt = buyPrompt,
						Price = v17(str3),
						Action = buyPrompt.ActionText,
						Distance = magnitude,
					}
				end
			end
		end

		local tbl20 = {}

		for _, v15 in tbl19, nil, nil do
			tbl20[#tbl20 + 1] = v15
		end

		table.sort(tbl20, function(arg3, arg4)
			return arg3.Name < arg4.Name
		end)

		local tbl21 = { "None" }
		local entries = {}

		for _, v15 in tbl20, nil, nil do
			local str3 = " | " .. v15.Action
			local str4 = fn4(v15.Name) .. str3
			tbl21[#tbl21 + 1] = str4
			entries[str4] = v15
		end

		arg.Entries = entries
		local signature = table.concat(tbl21, "\0")
		local runawaysRemoteShopItem = v3.RunawaysRemoteShopItem

		if runawaysRemoteShopItem then
			local value = runawaysRemoteShopItem.Value

			if arg2 or arg.Signature ~= signature then
				runawaysRemoteShopItem:SetValues(tbl21)
				local v15 = runawaysRemoteShopItem
				local setValue = v15.SetValue
				value = entries[value] and value or "None"
				setValue(v15, value)
			elseif value ~= "None" and not entries[value] then
				runawaysRemoteShopItem:SetValue("None")
			end
		end

		arg.Signature = signature
	end,
	GetSelected = function(arg)
		local runawaysRemoteShopItem = v3.RunawaysRemoteShopItem
		runawaysRemoteShopItem = runawaysRemoteShopItem and arg.Entries[runawaysRemoteShopItem.Value]

		if not runawaysRemoteShopItem or not runawaysRemoteShopItem.Part.Parent or not runawaysRemoteShopItem.Prompt.Parent then
			arg:Refresh(true)
			runawaysRemoteShopItem = v3.RunawaysRemoteShopItem
			runawaysRemoteShopItem = runawaysRemoteShopItem and arg.Entries[runawaysRemoteShopItem.Value]
		end

		if not runawaysRemoteShopItem then
			fn("Select an available shop item.")
			return
		end
		return runawaysRemoteShopItem
	end,
	Restore = function(arg, arg2)
		local context = arg2 or arg.Context
		if not context then
			return
		end
		local character = context.Character
		local root = context.Root

		if localPlayer.Character == character and character and character.Parent and root and root.Parent == character then
			pcall(function()
				character:PivotTo(context.StartPivot)
				root.AssemblyLinearVelocity = Vector3.zero
				root.AssemblyAngularVelocity = Vector3.zero
			end)
		end

		local currentCamera = workspace.CurrentCamera or context.Camera

		if currentCamera and currentCamera.Parent then
			pcall(function()
				local cameraSubject = context.CameraSubject

				if localPlayer.Character ~= character or not cameraSubject or not cameraSubject.Parent then
					cameraSubject = localPlayer.Character

					if cameraSubject then
						cameraSubject = cameraSubject:FindFirstChildOfClass("Humanoid") or cameraSubject:FindFirstChild("HumanoidRootPart")
					end
				end

				if cameraSubject then
					currentCamera.CameraSubject = cameraSubject
				end

				if context.CameraType then
					currentCamera.CameraType = context.CameraType
				end

				if context.CameraCFrame then
					currentCamera.CFrame = context.CameraCFrame
				end
			end)
		end

		if arg.Context == context then
			arg.Context = nil
		end
	end,
	Buy = function(arg)
		if arg.Busy then
			fn("A purchase is already running.", 3)
			return
		end
		local selected = arg:GetSelected()
		if not selected then
			return
		end

		if type(fireproximityprompt) ~= "function" then
			fn("Prompt activation is unavailable.", 6)
			return
		end
		local cashValue = arg:GetCashValue()
		if selected.Price and cashValue and cashValue < selected.Price then
			fn(string.format("Not enough cash: $%d / $%d.", cashValue, selected.Price), 5)
			return
		end
		local v15, v16 = fn6()
		if v15 and v16 and v15 >= v16 and not selected.Name:find("Backpack", 1, true) then
			fn(string.format("Inventory full: %d/%d.", v15, v16), 5)
			return
		end
		local token = {}
		arg.Token = token
		arg.Busy = true

		task.spawn(function()
			if arg.Token ~= token or v.Unloaded then
				return
			end
			local cashValue2 = arg:GetCashValue()
			local v17 = arg:CountNamedTools(selected.Name)
			local context = nil

			local ok, result = pcall(function()
				local character = localPlayer.Character
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")
				local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

				if not character or not humanoid or not humanoidRootPart or humanoid.Health <= 0 then
					error("Character is unavailable.", 0)
				end

				if humanoid.SeatPart then
					error("Exit the vehicle first.", 0)
				end

				local currentCamera = workspace.CurrentCamera

				context = {
					Character = character,
					Root = humanoidRootPart,
					StartPivot = character:GetPivot(),
					Camera = currentCamera,
					CameraCFrame = currentCamera and currentCamera.CFrame,
					CameraSubject = currentCamera and currentCamera.CameraSubject,
					CameraType = currentCamera and currentCamera.CameraType,
				}

				if arg.Token ~= token or v.Unloaded then
					return
				end
				arg.Context = context

				if currentCamera then
					currentCamera.CameraType = Enum.CameraType.Scriptable
					currentCamera.CFrame = context.CameraCFrame
				end

				character:PivotTo(fn7(humanoidRootPart, selected.Part))
				humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
				humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
				task.wait(0.35)
				if arg.Token ~= token or v.Unloaded or not selected.Prompt.Parent then
					return
				end
				fireproximityprompt(selected.Prompt, selected.Prompt.HoldDuration, true)
				local n4 = os.clock() + 1.5

				while true do
					task.wait(0.05)
					if not (arg.Token ~= token or v.Unloaded or arg:DidPurchase(selected, cashValue2, v17) or os.clock() >= n4) then
						continue
					end
					break
				end
			end)

			arg:Restore(context)
			if arg.Token ~= token then
				return
			end
			arg.Token = nil
			arg.Busy = false
			if v.Unloaded then
				return
			end
			local v18 = arg:DidPurchase(selected, cashValue2, v17)

			if not ok then
				fn("Purchase failed: " .. tostring(result), 6)
			elseif v18 then
				fn("Purchased " .. fn4(selected.Name) .. ".")
			else
				fn("Purchase was not completed.", 5)
			end
		end)
	end,
	Destroy = function(arg)
		arg.Token = nil
		arg:Restore(arg.Context)
		arg.Busy = false
		table.clear(arg.Entries)
	end,
}

v.LobbyShop = { Box = nil, Entries = {}, Signature = "", Busy = false, Token = nil }

v.LobbyShop.IsLobby = function()
	return v.AutoFarm and game.PlaceId == v.AutoFarm.LobbyPlaceId
end

v.LobbyShop.GetData = function(arg, arg2)
	if not FlowClient.PlayerDataClient or type(FlowClient.PlayerDataClient.get) ~= "function" then
		return
	end
	local ok, result = pcall(FlowClient.PlayerDataClient.get, arg2)
	if ok then
		return result
	end
end

v.LobbyShop.GetCoins = function(arg)
	return tonumber(arg:GetData("coins"))
end

v.LobbyShop.GetOwnedCount = function(arg, arg2, arg3)
	if arg2 == "Classes" then
		local data2 = arg:GetData("ownedClasses")
		return type(data2) == "table" and data2[arg3] == true and 1 or 0
	end

	if arg2 == "Vehicles" then
		local data2 = arg:GetData("cars")
		return type(data2) == "table" and data2[arg3] ~= nil and 1 or 0
	end
	local data2 = arg:GetData("weaponStash")
	local data3 = arg:GetData("equippedWeapons")
	local n4 = 0

	if type(data2) == "table" then
		n4 = 0 + (tonumber(data2[arg3]) or 0)
	end

	if type(data3) == "table" then
		for _, v15 in data3, nil, nil do
			if v15 == arg3 then
				n4 += 1
			end
		end
	end

	return n4
end

v.LobbyShop.FormatPrice = function(arg, arg2)
	return tostring(math.max(0, math.floor(tonumber(arg2) or 0))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. " Credz"
end

v.LobbyShop.GetCatalog = function(arg, arg2)
	if arg2 == "Classes" then
		return module.ClassesData
	end

	if arg2 == "Vehicles" then
		return module.CarData and module.CarData.Cars
	end
	return module.WeaponData and module.WeaponData.Weapons
end

v.LobbyShop.Refresh = function(arg, arg2)
	if not arg:IsLobby() or not arg.Box then
		return
	end
	local runawaysLobbyShopCategory = v3.RunawaysLobbyShopCategory
	local runawaysLobbyShopItem = v3.RunawaysLobbyShopItem
	if not runawaysLobbyShopCategory or not runawaysLobbyShopItem then
		return
	end
	local value = runawaysLobbyShopCategory.Value

	if value ~= "Classes" and value ~= "Weapons" and value ~= "Vehicles" then
		value = "Classes"
	end

	local catalog = arg:GetCatalog(value)
	local tbl20 = {}

	if type(catalog) == "table" then
		for k, v15 in catalog, nil, nil do
			local num = type(v15) == "table" and tonumber(v15.price)
			local flag3 = num ~= nil

			if value == "Classes" and v15.robuxPurchase == true then
				flag3 = false
			elseif value == "Vehicles" and v15.gamepassId ~= nil then
				flag3 = false
			end

			if flag3 and (value == "Weapons" or arg:GetOwnedCount(value, k) == 0) then
				tbl20[#tbl20 + 1] = {
					Id = k,
					Name = tostring(v15.name or fn4(tostring(k))),
					Price = num,
					Category = value,
					ItemCategory = tostring(v15.category or ""),
				}
			end
		end
	end

	table.sort(tbl20, function(arg3, arg4)
		if arg3.Name == arg4.Name then
			return tostring(arg3.Id) < tostring(arg4.Id)
		end
		return arg3.Name < arg4.Name
	end)

	local tbl21 = { "None" }
	local entries = {}

	for _, v15 in tbl20, nil, nil do
		local str3 = v15.Name .. (v15.Category == "Weapons" and v15.ItemCategory ~= "" and " [" .. v15.ItemCategory .. "]" or "") .. " | " .. arg:FormatPrice(v15.Price)
		tbl21[#tbl21 + 1] = str3
		entries[str3] = v15
	end

	arg.Entries = entries
	local signature = value .. "\0" .. table.concat(tbl21, "\0")
	local value2 = runawaysLobbyShopItem.Value

	if arg2 or arg.Signature ~= signature then
		runawaysLobbyShopItem:SetValues(tbl21)
		local v15 = runawaysLobbyShopItem
		local setValue = v15.SetValue
		value2 = entries[value2] and value2 or "None"
		setValue(v15, value2)
	elseif value2 ~= "None" and not entries[value2] then
		runawaysLobbyShopItem:SetValue("None")
	end

	arg.Signature = signature
end

v.LobbyShop.GetSelected = function(arg)
	local runawaysLobbyShopItem = v3.RunawaysLobbyShopItem
	runawaysLobbyShopItem = runawaysLobbyShopItem and arg.Entries[runawaysLobbyShopItem.Value]

	if not runawaysLobbyShopItem then
		arg:Refresh(true)
		runawaysLobbyShopItem = v3.RunawaysLobbyShopItem
		runawaysLobbyShopItem = runawaysLobbyShopItem and arg.Entries[runawaysLobbyShopItem.Value]
	end

	if not runawaysLobbyShopItem then
		fn("Select an available lobby item.")
		return
	end
	return runawaysLobbyShopItem
end

v.LobbyShop.Buy = function(arg)
	if not arg:IsLobby() then
		fn("Lobby Shop is only available in the lobby.", 5)
		return
	end

	if arg.Busy then
		fn("A lobby purchase is already running.", 3)
		return
	end
	local selected = arg:GetSelected()
	if not selected then
		return
	end
	local coins = arg:GetCoins()
	if coins and coins < selected.Price then
		fn(string.format("Not enough Credz: %d / %d.", coins, selected.Price), 5)
		return
	end
	local str3 = selected.Category == "Classes" and "BuyClass" or selected.Category == "Vehicles" and "BuyCar" or "BuyWeapon"
	local playerDataServer = FlowClient.PlayerDataServer and FlowClient.PlayerDataServer[str3]
	if type(playerDataServer) ~= "function" then
		fn(str3 .. " is unavailable.", 5)
		return
	end
	local token = {}
	local ownedCount = arg:GetOwnedCount(selected.Category, selected.Id)
	local coins2 = arg:GetCoins()
	arg.Token = token
	arg.Busy = true

	task.spawn(function()
		local ok, result = pcall(playerDataServer, selected.Id)
		local n4 = os.clock() + 2
		local ownedCount2, coins3

		while true do
			task.wait(0.05)
			ownedCount2 = arg:GetOwnedCount(selected.Category, selected.Id)
			coins3 = arg:GetCoins()
			if not (arg.Token ~= token or v.Unloaded or ownedCount2 > ownedCount or selected.Price > 0 and coins2 ~= nil and coins3 ~= nil and coins2 - coins3 >= selected.Price or os.clock() >= n4) then
				continue
			end
			break
		end

		if arg.Token ~= token then
			return
		end
		arg.Token = nil
		arg.Busy = false
		arg:Refresh(true)
		if v.Unloaded then
			return
		end
		local flag3 = result == true or ownedCount2 > ownedCount or selected.Price > 0 and coins2 ~= nil and coins3 ~= nil and coins2 - coins3 >= selected.Price

		if not ok then
			fn("Lobby purchase failed: " .. tostring(result), 6)
		elseif flag3 then
			fn("Purchased " .. selected.Name .. " for " .. arg:FormatPrice(selected.Price) .. ".")
		else
			fn("Purchase was rejected by the server.", 5)
		end
	end)
end

v.LobbyShop.Destroy = function(arg)
	arg.Token = nil
	arg.Busy = false
	table.clear(arg.Entries)
end

v.AutoFarm = {
	Version = 1,
	StatsVersion = 2,
	LobbyPlaceId = 118418618261207,
	GamePlaceId = 117311404196294,
	StatePath = "MyScriptHub/RUNAWAYS/auto_farm.json",
	StateKey = "RUNAWAYS_AUTO_FARM_STATE",
	EnabledKey = "RUNAWAYS_AUTO_FARM_ENABLED",
	SessionKey = "RUNAWAYS_AUTO_FARM_SESSION",
	TransitionKey = "RUNAWAYS_AUTO_FARM_TRANSITION",
	TeleportLoader = "    loadstring(game:HttpGet(\"https://raw.githubusercontent.com/gilgameshfate59/ohbfoosk8tid/refs/heads/main/Runaways.lua?cb=\" .. tostring(os.time())))()\n",
	Running = false,
	ResumeRequested = false,
	Token = nil,
	QueueJob = nil,
	Revision = 0,
	Teleporting = false,
	RunActive = false,
	ActiveRunToken = nil,
	RunHeartbeat = 0,
	Phase = "Idle",
	Detail = "Ready",
	GateText = "--",
	LastError = "None",
	QueueStatus = "Not armed",
	WebhookStatus = "Idle",
	SessionId = "",
	TransitionToken = "",
	ExpectedPlaceId = 0,
	TransitionAt = 0,
	StartedAt = 0,
	RunStartedAt = 0,
	RunCashStart = 0,
	RunWinsStart = 0,
	LastCredzBalance = nil,
	LastWins = nil,
	PendingCredz = 0,
	PendingWins = 0,
	BalanceWarmupUntil = 0,
	GateStartedAt = 0,
	PendingFinish = false,
	FinishCrossed = false,
	PendingAt = 0,
	ResultBusy = false,
	ResultFinalized = false,
	ReplayRequested = false,
	SafeCFrame = nil,
	SafeCharacter = nil,
	SafeRootAnchored = nil,
	LastGameJob = "",
	LastSnapshot = nil,
	LastPersistAt = 0,
	StateReady = false,
	LastWebhookAt = 0,
	WebhookGeneration = 0,
	TeleportFailureGeneration = 0,
	TeleportRecoveryGeneration = 0,
	TeleportRetryCount = 0,
	TeleportRetryDelay = 0,
	TeleportRetryTarget = 0,
	TeleportRetryOptions = nil,
	TeleportRecovering = false,
	LastTeleportFailureAt = 0,
	Labels = {},
	LabelCache = {},
	LastUIProgressAt = 0,
	LastEndScreenScanAt = 0,
	Config = { LobbyDelay = 3, GateTimeout = 165, RetryDelay = 10, SafeGateWait = true, AutoReplay = true },
	Webhook = {
		Enabled = false,
		URL = "",
		Events = {
			["Session Started"] = true,
			["Run Started"] = true,
			["Run Completed"] = true,
			Error = true,
			Stopped = true,
		},
	},
	Stats = {
		Attempts = 0,
		Completed = 0,
		Failed = 0,
		Teleports = 0,
		GateActivations = 0,
		NPCAttacks = 0,
		Retries = 0,
		Replays = 0,
		CashEarned = 0,
		TotalRunTime = 0,
		BestRun = 0,
		LastRun = 0,
	},
}

v.AutoFarm.GetContext = function(arg)
	if game.PlaceId == arg.LobbyPlaceId then
		return "Lobby"
	end

	if game.PlaceId == arg.GamePlaceId then
		return "Game"
	end

	if FlowClient.LobbyServer and type(FlowClient.LobbyServer.create) == "function" then
		return "Lobby"
	end

	if workspace:FindFirstChild("Map") and FlowClient.NPCs then
		return "Game"
	end
	return "Unsupported"
end

v.AutoFarm.IsAutoReplayEnabled = function(arg)
	if v2.RunawaysAutoFarmAutoReplay then
		return v2.RunawaysAutoFarmAutoReplay.Value == true
	end
	return arg.Config.AutoReplay == true
end

v.AutoFarm.GetQueueFunction = function()
	if type(queue_on_teleport) == "function" then
		return queue_on_teleport
	end

	if type(queueonteleport) == "function" then
		return queueonteleport
	end

	if type(syn) == "table" and type(syn.queue_on_teleport) == "function" then
		return syn.queue_on_teleport
	end

	if type(fluxus) == "table" and type(fluxus.queue_on_teleport) == "function" then
		return fluxus.queue_on_teleport
	end
end

v.AutoFarm.GetTeleportLoader = function(arg)
	return tostring(arg.TeleportLoader or ""):match("^%s*(.-)%s*$") or ""
end

v.AutoFarm.HasTeleportLoader = function(arg)
	local teleportLoader = arg:GetTeleportLoader()
	return teleportLoader ~= "" and not teleportLoader:match("^%-%-")
end

v.AutoFarm.GetTeleportQueueError = function(arg, arg2)
	if not tonumber(arg2) then
		return "Target place unavailable"
	end

	if not arg:GetQueueFunction() then
		return "queue_on_teleport unavailable"
	end

	if not arg:HasTeleportLoader() then
		return "Teleport loader is not configured"
	end
end

v.AutoFarm.GetRequestFunction = function()
	if type(request) == "function" then
		return request
	end

	if type(http_request) == "function" then
		return http_request
	end

	if type(http) == "table" and type(http.request) == "function" then
		return http.request
	end

	if type(syn) == "table" and type(syn.request) == "function" then
		return syn.request
	end

	if type(fluxus) == "table" and type(fluxus.request) == "function" then
		return fluxus.request
	end
end

v.AutoFarm.GetDataValue = function(arg, arg2)
	if FlowClient.LocalData and type(FlowClient.LocalData.Get) == "function" then
		local ok, result = pcall(FlowClient.LocalData.Get, arg2)
		if ok and type(result) == "number" then
			return result
		end
	end

	if FlowClient.LocalData and type(FlowClient.LocalData.GetValue) == "function" then
		local ok, result = pcall(FlowClient.LocalData.GetValue, arg2)

		if ok and result then
			local ok2, result2 = pcall(function()
				return result:get()
			end)

			if ok2 and type(result2) == "number" then
				return result2
			end
		end
	end

	if FlowClient.PlayerDataClient and type(FlowClient.PlayerDataClient.getObserver) == "function" then
		local ok, result = pcall(FlowClient.PlayerDataClient.getObserver, arg2)

		if ok and result and type(result.get) == "function" then
			local ok2, result2 = pcall(result.get, result)
			if ok2 and type(result2) == "number" then
				return result2
			end
		end
	end
end

v.AutoFarm.GetCash = function(arg)
	return arg:GetDataValue("coins")
end

v.AutoFarm.GetWins = function(arg)
	return arg:GetDataValue("wins")
end

v.AutoFarm.GetEffectiveCredz = function(arg)
	return (tonumber(arg.LastCredzBalance) or 0) + math.max(0, tonumber(arg.PendingCredz) or 0)
end

v.AutoFarm.GetEffectiveWins = function(arg)
	return (tonumber(arg.LastWins) or 0) + math.max(0, tonumber(arg.PendingWins) or 0)
end

v.AutoFarm.SyncProgress = function(arg, arg2)
	local cash = arg:GetCash()
	local wins = arg:GetWins()

	if type(cash) == "number" then
		if arg2 or type(arg.LastCredzBalance) ~= "number" then
			arg.LastCredzBalance = cash
			arg.PendingCredz = 0
		elseif cash > arg.LastCredzBalance then
			local n4 = cash - arg.LastCredzBalance
			local n5 = math.min(n4, math.max(0, tonumber(arg.PendingCredz) or 0))
			arg.PendingCredz = math.max(0, arg.PendingCredz - n5)
			local now = os.clock()

			if (tonumber(arg.BalanceWarmupUntil) or 0) <= now then
				local stats = arg.Stats
				stats.CashEarned = stats.CashEarned + n4 - n5
			end

			arg.LastCredzBalance = cash
		end
	end

	if type(wins) == "number" then
		if arg2 or type(arg.LastWins) ~= "number" then
			arg.LastWins = wins
			arg.PendingWins = 0
		elseif arg.LastWins < wins then
			arg.PendingWins = math.max(0, arg.PendingWins - math.min(wins - arg.LastWins, math.max(0, tonumber(arg.PendingWins) or 0)))
			arg.LastWins = wins
		end
	end

	return cash, wins
end

v.AutoFarm.NormalizeStats = function(arg)
	local n4 = arg.RunStartedAt > 0 and 1 or 0
	local attempts = math.max(n4, math.max(0, math.floor(tonumber(arg.Stats.Attempts) or 0)))
	local n5 = math.max(0, attempts - n4)
	local failed = math.min(math.max(0, math.floor(tonumber(arg.Stats.Failed) or 0)), n5)
	local completed = math.min(math.max(0, math.floor(tonumber(arg.Stats.Completed) or 0)), math.max(0, n5 - failed))
	arg.Stats.Attempts = attempts
	arg.Stats.Completed = completed
	arg.Stats.Failed = failed
end

v.AutoFarm.FormatDuration = function(arg, arg2)
	local n4 = math.max(0, math.floor(tonumber(arg2) or 0))
	return string.format("%02d:%02d:%02d", math.floor(n4 / 3600), math.floor(n4 % 3600 / 60), n4 % 60)
end

v.AutoFarm.SetPhase = function(arg, phase, detail)
	arg.Phase = phase
	arg.Detail = detail or ""
	arg:UpdateUI()
end

v.AutoFarm.SetLabel = function(arg, arg2, arg3)
	local v15 = arg.Labels[arg2]
	local str3 = tostring(arg3)
	if arg.LabelCache[arg2] == str3 then
		return
	end

	if v15 and type(v15.SetText) == "function" then
		if pcall(v15.SetText, v15, str3) then
			arg.LabelCache[arg2] = str3
		end
	end
end

v.AutoFarm.UpdateUI = function(arg)
	local now = os.clock()

	if (arg.StateReady or arg.Running) and now - arg.LastUIProgressAt >= 1 then
		arg.LastUIProgressAt = now
		arg:SyncProgress()
	end

	arg:NormalizeStats()
	local now2 = os.time()
	local n4 = arg.StartedAt > 0 and now2 - arg.StartedAt or 0
	local n5 = arg.RunStartedAt > 0 and now2 - arg.RunStartedAt or 0
	local completed = arg.Stats.Completed
	local attempts = arg.Stats.Attempts
	local n6 = attempts > 0 and completed / attempts * 100 or 0
	local n7 = completed > 0 and arg.Stats.TotalRunTime / completed or 0
	local str3 = not arg:GetQueueFunction() and "Unavailable" or arg:HasTeleportLoader() and "Loader ready" or "Loader placeholder"
	arg:SetLabel("Status", "Status: " .. arg.Phase .. "\n" .. arg.Detail)
	arg:SetLabel("Context", "Context: " .. arg:GetContext() .. " | Place: " .. tostring(game.PlaceId))
	arg:SetLabel("Queue", "Queue: " .. arg.QueueStatus .. " | Mode: " .. str3)
	arg:SetLabel("Session", "Session: " .. arg:FormatDuration(n4) .. " | Credz: +" .. tostring(math.floor(arg.Stats.CashEarned)))
	arg:SetLabel("Runs", string.format("Runs: %d completed / %d started | %.1f%%", completed, attempts, n6))
	arg:SetLabel("Failures", "Failures: " .. arg.Stats.Failed .. " | Retries: " .. arg.Stats.Retries .. " | Replay votes: " .. arg.Stats.Replays .. " | Teleports: " .. arg.Stats.Teleports)
	arg:SetLabel("Timing", "Average: " .. arg:FormatDuration(n7) .. " | Best: " .. arg:FormatDuration(arg.Stats.BestRun) .. " | Last: " .. arg:FormatDuration(arg.Stats.LastRun))
	arg:SetLabel("Combat", "NPC attack requests: " .. arg.Stats.NPCAttacks .. " | Gate activations: " .. arg.Stats.GateActivations)
	local str4 = " | Gate: " .. arg.GateText
	arg:SetLabel("Run", "Current run: " .. arg:FormatDuration(n5) .. str4)
	arg:SetLabel("Error", "Last error: " .. arg.LastError)
	arg:SetLabel("Webhook", "Webhook: " .. arg.WebhookStatus)
end

v.AutoFarm.ResetStats = function(arg)
	arg:SyncProgress()
	local now = os.time()
	local flag3 = arg.Running and arg.RunStartedAt > 0
	local effectiveCredz = arg:GetEffectiveCredz()
	local effectiveWins = arg:GetEffectiveWins()
	local gateStartedAt = flag3 and arg.GateStartedAt or 0
	arg.StartedAt = now
	arg.RunStartedAt = flag3 and now or 0
	arg.RunCashStart = effectiveCredz
	arg.RunWinsStart = effectiveWins
	arg.GateStartedAt = gateStartedAt
	arg.LastError = "None"
	arg.GateText = "--"

	arg.Stats = {
		Attempts = flag3 and 1 or 0,
		Completed = 0,
		Failed = 0,
		Teleports = 0,
		GateActivations = 0,
		NPCAttacks = 0,
		Retries = 0,
		Replays = 0,
		CashEarned = 0,
		TotalRunTime = 0,
		BestRun = 0,
		LastRun = 0,
	}

	arg.LastCredzBalance = effectiveCredz
	arg.LastWins = effectiveWins
	arg.PendingCredz = 0
	arg.PendingWins = 0
	arg:Persist()
	arg:UpdateUI()
end

v.AutoFarm.GetSnapshot = function(arg)
	if arg.StateReady or arg.Running then
		arg:SyncProgress()
	end

	arg:NormalizeStats()
	local tbl20 = {}

	for k, v15 in arg.Webhook.Events, nil, nil do
		tbl20[k] = v15 == true
	end

	if v3.RunawaysAutoFarmWebhookEvents then
		table.clear(tbl20)

		for k, v15 in v3.RunawaysAutoFarmWebhookEvents.Value, nil, nil do
			tbl20[k] = v15 == true
		end
	end

	return {
		Version = arg.Version,
		StatsVersion = arg.StatsVersion,
		Revision = arg.Revision,
		UserId = localPlayer.UserId,
		Enabled = arg.Running,
		SessionId = arg.SessionId,
		TransitionToken = arg.TransitionToken,
		ExpectedPlaceId = arg.ExpectedPlaceId,
		TransitionAt = arg.TransitionAt,
		Phase = arg.Phase,
		Detail = arg.Detail,
		StartedAt = arg.StartedAt,
		RunStartedAt = arg.RunStartedAt,
		RunCashStart = arg.RunCashStart,
		RunWinsStart = arg.RunWinsStart,
		LastCredzBalance = arg.LastCredzBalance,
		LastWins = arg.LastWins,
		PendingCredz = arg.PendingCredz,
		PendingWins = arg.PendingWins,
		GateStartedAt = arg.GateStartedAt,
		PendingFinish = arg.PendingFinish,
		FinishCrossed = arg.FinishCrossed,
		PendingAt = arg.PendingAt,
		LastGameJob = arg.LastGameJob,
		LastError = arg.LastError,
		UpdatedAt = os.time(),
		Stats = arg.Stats,
		Config = {
			LobbyDelay = v3.RunawaysAutoFarmLobbyDelay and v3.RunawaysAutoFarmLobbyDelay.Value or arg.Config.LobbyDelay,
			GateTimeout = v3.RunawaysAutoFarmGateTimeout and v3.RunawaysAutoFarmGateTimeout.Value or arg.Config.GateTimeout,
			RetryDelay = v3.RunawaysAutoFarmRetryDelay and v3.RunawaysAutoFarmRetryDelay.Value or arg.Config.RetryDelay,
			SafeGateWait = arg.Config.SafeGateWait,
			AutoReplay = arg.Config.AutoReplay,
		},
		Webhook = {
			Enabled = v2.RunawaysAutoFarmWebhook and v2.RunawaysAutoFarmWebhook.Value or arg.Webhook.Enabled,
			URL = v3.RunawaysAutoFarmWebhookURL and v3.RunawaysAutoFarmWebhookURL.Value or arg.Webhook.URL,
			Events = tbl20,
		},
	}
end

v.AutoFarm.Persist = function(arg)
	arg.Revision = arg.Revision + 1

	local ok, lastSnapshot = pcall(function()
		return game:GetService("HttpService"):JSONEncode(arg:GetSnapshot())
	end)

	if not ok then
		return false
	end
	arg.LastSnapshot = lastSnapshot
	arg.LastPersistAt = os.clock()
	local TeleportService = game:GetService("TeleportService")
	pcall(TeleportService.SetTeleportSetting, TeleportService, arg.StateKey, lastSnapshot)
	pcall(TeleportService.SetTeleportSetting, TeleportService, arg.EnabledKey, arg.Running)
	pcall(TeleportService.SetTeleportSetting, TeleportService, arg.SessionKey, arg.SessionId)
	pcall(TeleportService.SetTeleportSetting, TeleportService, arg.TransitionKey, arg.TransitionToken)

	if type(writefile) == "function" then
		if type(makefolder) == "function" then
			pcall(function()
				if type(isfolder) ~= "function" or not isfolder("MyScriptHub") then
					makefolder("MyScriptHub")
				end
			end)

			pcall(function()
				if type(isfolder) ~= "function" or not isfolder("MyScriptHub/RUNAWAYS") then
					makefolder("MyScriptHub/RUNAWAYS")
				end
			end)
		end

		pcall(writefile, arg.StatePath, lastSnapshot)
	end

	return true
end

v.AutoFarm.ApplyPreferences = function(arg, arg2)
	if type(arg2) ~= "table" or arg2.Version ~= arg.Version or arg2.UserId ~= localPlayer.UserId then
		return false
	end
	arg.Revision = math.max(arg.Revision, tonumber(arg2.Revision) or 0)

	if type(arg2.Config) == "table" then
		arg.Config.LobbyDelay = tonumber(arg2.Config.LobbyDelay) or arg.Config.LobbyDelay
		arg.Config.GateTimeout = tonumber(arg2.Config.GateTimeout) or arg.Config.GateTimeout
		arg.Config.RetryDelay = tonumber(arg2.Config.RetryDelay) or arg.Config.RetryDelay

		if type(arg2.Config.SafeGateWait) == "boolean" then
			arg.Config.SafeGateWait = arg2.Config.SafeGateWait
		end

		if type(arg2.Config.AutoReplay) == "boolean" then
			arg.Config.AutoReplay = arg2.Config.AutoReplay
		end
	end

	if type(arg2.Webhook) == "table" then
		arg.Webhook.Enabled = arg2.Webhook.Enabled == true
		arg.Webhook.URL = tostring(arg2.Webhook.URL or "")

		if type(arg2.Webhook.Events) == "table" then
			table.clear(arg.Webhook.Events)

			for k, v15 in arg2.Webhook.Events, nil, nil do
				arg.Webhook.Events[k] = v15 == true
			end
		end
	end

	return true
end

v.AutoFarm.ApplySnapshot = function(arg, arg2)
	if not arg:ApplyPreferences(arg2) then
		return false
	end
	arg.SessionId = tostring(arg2.SessionId or "")
	arg.TransitionToken = tostring(arg2.TransitionToken or "")
	arg.ExpectedPlaceId = tonumber(arg2.ExpectedPlaceId) or 0
	arg.TransitionAt = tonumber(arg2.TransitionAt) or 0
	arg.Revision = tonumber(arg2.Revision) or 0
	arg.StartedAt = tonumber(arg2.StartedAt) or 0
	arg.RunStartedAt = tonumber(arg2.RunStartedAt) or 0
	arg.RunCashStart = tonumber(arg2.RunCashStart) or 0
	arg.RunWinsStart = tonumber(arg2.RunWinsStart) or 0
	arg.LastCredzBalance = tonumber(arg2.LastCredzBalance)
	arg.LastWins = tonumber(arg2.LastWins)
	arg.PendingCredz = math.max(0, tonumber(arg2.PendingCredz) or 0)
	arg.PendingWins = math.max(0, tonumber(arg2.PendingWins) or 0)
	arg.GateStartedAt = tonumber(arg2.GateStartedAt) or 0
	arg.PendingFinish = arg2.PendingFinish == true
	arg.FinishCrossed = arg2.FinishCrossed == true
	arg.PendingAt = tonumber(arg2.PendingAt) or 0
	arg.LastGameJob = tostring(arg2.LastGameJob or "")
	arg.LastError = tostring(arg2.LastError or "None")
	arg.BalanceWarmupUntil = os.clock() + 10
	local flag3 = (tonumber(arg2.StatsVersion) or 1) < arg.StatsVersion

	if type(arg2.Stats) == "table" then
		for k, v15 in arg.Stats, nil, nil do
			arg.Stats[k] = tonumber(arg2.Stats[k]) or v15
		end
	end

	if flag3 then
		local attempts = math.max(0, math.floor(tonumber(arg.Stats.Attempts) or 0))
		local n4 = math.max(0, attempts - (arg.RunStartedAt > 0 and 1 or 0))
		local failed = math.min(math.max(0, math.floor(tonumber(arg.Stats.Failed) or 0)), n4)
		local cash = arg:GetCash()
		local wins = arg:GetWins()
		arg.Stats.Attempts = attempts
		arg.Stats.Completed = math.max(0, n4 - failed)
		arg.Stats.Failed = failed
		arg.Stats.CashEarned = 0
		arg.PendingCredz = 0
		arg.PendingWins = 0

		if type(cash) == "number" and (type(arg.LastCredzBalance) ~= "number" or cash > arg.LastCredzBalance) then
			arg.LastCredzBalance = cash
		end

		if type(wins) == "number" and (type(arg.LastWins) ~= "number" or wins > arg.LastWins) then
			arg.LastWins = wins
		end

		arg.RunCashStart = tonumber(arg.LastCredzBalance) or 0
		arg.RunWinsStart = tonumber(arg.LastWins) or 0
	end

	arg:NormalizeStats()

	if type(arg.LastCredzBalance) ~= "number" then
		arg.LastCredzBalance = arg:GetCash()
		arg.PendingCredz = 0
	end

	if type(arg.LastWins) ~= "number" then
		arg.LastWins = arg:GetWins()
		arg.PendingWins = 0
	end

	if arg.RunCashStart <= 0 and type(arg.LastCredzBalance) == "number" then
		arg.RunCashStart = arg:GetEffectiveCredz()
	end

	if arg.RunWinsStart <= 0 and type(arg.LastWins) == "number" then
		arg.RunWinsStart = arg:GetEffectiveWins()
	end

	local resumeRequested = arg.SessionId ~= "" and arg2.Enabled == true

	if resumeRequested then
		resumeRequested = os.time() - (tonumber(arg2.UpdatedAt) or 0) <= 900
	end

	arg.ResumeRequested = resumeRequested

	if arg2.Enabled == true and not arg.ResumeRequested then
		arg.LastError = "Saved Auto Farm session expired"

		pcall(function()
			game:GetService("TeleportService"):SetTeleportSetting(arg.EnabledKey, false)
		end)
	end

	arg.LastSnapshot = nil
	return true
end

v.AutoFarm.LoadState = function(arg)
	local str3 = tostring(genv.RunawaysAutoFarmTransitionToken or "")
	local runawaysAutoFarmQueuedState = genv.RunawaysAutoFarmQueuedState
	local v15 = nil
	local n4 = -1
	local n5 = -1
	local v16 = nil
	local n6 = -1
	local n7 = -1
	genv.RunawaysAutoFarmTransitionToken = nil
	genv.RunawaysAutoFarmQueuedState = nil

	local function fn71(arg2)
		if type(arg2) == "string" then
			local v17 = game
			local ok, result = pcall(game:GetService("HttpService").JSONDecode, v17:GetService("HttpService"), arg2)
			if not ok then
				return
			end
			arg2 = result
		end

		if type(arg2) ~= "table" or arg2.Version ~= arg.Version or arg2.UserId ~= localPlayer.UserId then
			return
		end
		local n8 = tonumber(arg2.UpdatedAt) or 0
		local n9 = tonumber(arg2.Revision) or 0

		if n8 > n6 or n8 == n6 and n9 >= n7 then
			v16 = arg2
			n6 = n8
			n7 = n9
		end

		local n10 = tonumber(arg2.TransitionAt) or 0
		local flag3 = str3 ~= ""

		if flag3 then
			flag3 = tostring(arg2.TransitionToken or "") == str3
		end

		flag3 = flag3 and (game.PlaceId == arg.LobbyPlaceId or game.PlaceId == arg.GamePlaceId) and n10 > 0 and math.abs(os.time() - n10) <= 900

		if flag3 then
			flag3 = tostring(arg2.SessionId or "") ~= ""
		end

		if flag3 and arg2.Enabled == true and os.time() - n8 <= 900 and (n8 > n4 or n8 == n4 and n9 >= n5) then
			v15 = arg2
			n4 = n8
			n5 = n9
		end
	end

	fn71(runawaysAutoFarmQueuedState)

	pcall(function()
		fn71(game:GetService("TeleportService"):GetTeleportSetting(arg.StateKey))
	end)

	if type(readfile) == "function" and type(isfile) == "function" then
		pcall(function()
			if isfile(arg.StatePath) then
				fn71(readfile(arg.StatePath))
			end
		end)
	end

	if v15 and arg:ApplySnapshot(v15) and arg.ResumeRequested then
		arg.ExpectedPlaceId = game.PlaceId
		return
	end

	if v16 then
		arg:ApplyPreferences(v16)
	end

	arg.ResumeRequested = false
	arg.SessionId = ""
	arg.TransitionToken = ""
	arg.ExpectedPlaceId = 0
	arg.TransitionAt = 0
	arg.StartedAt = 0
	arg.RunStartedAt = 0
	arg.RunCashStart = 0
	arg.RunWinsStart = 0
	arg.LastCredzBalance = arg:GetCash()
	arg.LastWins = arg:GetWins()
	arg.PendingCredz = 0
	arg.PendingWins = 0
	arg.GateStartedAt = 0
	arg.PendingFinish = false
	arg.FinishCrossed = false
	arg.PendingAt = 0
	arg.LastGameJob = ""
	arg.LastError = "None"
	arg.GateText = "--"

	for k in arg.Stats, nil, nil do
		arg.Stats[k] = 0
	end
end

v.AutoFarm.ApplyStoredOptions = function(arg)
	if v3.RunawaysAutoFarmLobbyDelay then
		v3.RunawaysAutoFarmLobbyDelay:SetValue(arg.Config.LobbyDelay)
	end

	if v3.RunawaysAutoFarmGateTimeout then
		v3.RunawaysAutoFarmGateTimeout:SetValue(arg.Config.GateTimeout)
	end

	if v3.RunawaysAutoFarmRetryDelay then
		v3.RunawaysAutoFarmRetryDelay:SetValue(arg.Config.RetryDelay)
	end

	if v2.RunawaysAutoFarmSafeGateWait then
		v2.RunawaysAutoFarmSafeGateWait:SetValue(arg.Config.SafeGateWait)
	end

	if v2.RunawaysAutoFarmAutoReplay then
		v2.RunawaysAutoFarmAutoReplay:SetValue(arg.Config.AutoReplay)
	end

	if v3.RunawaysAutoFarmWebhookURL then
		v3.RunawaysAutoFarmWebhookURL:SetValue(arg.Webhook.URL)
	end

	if v3.RunawaysAutoFarmWebhookEvents then
		v3.RunawaysAutoFarmWebhookEvents:SetValue(arg.Webhook.Events)
	end

	if v2.RunawaysAutoFarmWebhook then
		v2.RunawaysAutoFarmWebhook:SetValue(arg.Webhook.Enabled)
	end
end

v.AutoFarm.SendWebhook = function()
end

v.AutoFarm.QueueTeleport = function(arg, arg2, arg3)
	local expectedPlaceId = tonumber(arg3)
	local teleportQueueError = arg:GetTeleportQueueError(expectedPlaceId)

	if teleportQueueError then
		arg.QueueStatus = teleportQueueError
		arg:UpdateUI()
		return false, arg.QueueStatus
	end

	local queueFunction = arg:GetQueueFunction()
	local teleportLoader = arg:GetTeleportLoader()

	if arg.QueueJob == game.JobId and arg.TransitionToken ~= "" then
		arg.ExpectedPlaceId = expectedPlaceId
		arg.TransitionAt = os.time()
		if not arg:Persist() then
			return false, "Transition state is unavailable"
		end
		arg.QueueStatus = "Armed: " .. tostring(arg2)
		arg:UpdateUI()
		return true
	end

	local concat = table.concat
	local tbl20 = {}
	local str3 = tostring(arg.SessionId)
	local jobId = game.JobId
	local str4 = tostring(expectedPlaceId)
	local str5 = tostring(os.time())
	local v15 = tostring
	local random = math.random
	tbl20[1] = str3
	tbl20[2] = jobId
	tbl20[3] = str4
	tbl20[4] = str5

	do
		local values = table.pack(v15(random(100000, 999999)))
		table.move(values, 1, values.n, 5, tbl20)
	end

	local v16 = concat(tbl20, ":")
	arg.TransitionToken = v16
	arg.ExpectedPlaceId = expectedPlaceId
	arg.TransitionAt = os.time()
	if not arg:Persist() or type(arg.LastSnapshot) ~= "string" then
		return false, "Transition state is unavailable"
	end

	local str6 = string.format([[if not game:IsLoaded() then game.Loaded:Wait() end
if game.PlaceId == %d or game.PlaceId == %d then
local p = game:GetService(%q)
while not p.LocalPlayer do task.wait() end
local t = game:GetService(%q)
local v = nil
pcall(function() v = t:GetTeleportSetting(%q) end)
if t:GetTeleportSetting(%q) ~= false and tostring(v or '') == %q then
local e = getgenv and getgenv() or _G
if e.RunawaysAutoFarmQueueExecution ~= %q then
e.RunawaysAutoFarmQueueExecution = %q
e.RunawaysAutoFarmQueueLoading = %q
local s = false
for i = 1, 3 do
e.RunawaysAutoFarmTransitionToken = %q
e.RunawaysAutoFarmQueuedState = %q
local o = pcall(function()
%s
end)
if o then s = true break end
task.wait(i)
end
if e.RunawaysAutoFarmQueueLoading == %q then e.RunawaysAutoFarmQueueLoading = nil end
if not s and e.RunawaysAutoFarmQueueExecution == %q then
e.RunawaysAutoFarmQueueExecution = nil
if e.RunawaysScriptLoading == coroutine.running() then
e.RunawaysScriptLoading = nil
e.RunawaysScriptLoadingAt = nil
e.RunawaysScriptLoadingToken = nil
end
end
end
end
end]], arg.LobbyPlaceId, arg.GamePlaceId, "Players", "TeleportService", arg.TransitionKey, arg.EnabledKey, v16, v16, v16, v16, v16, arg.LastSnapshot, teleportLoader, v16, v16)

	local ok, result = pcall(queueFunction, str6)

	if not ok then
		arg.TransitionToken = ""
		arg.ExpectedPlaceId = 0
		arg.TransitionAt = 0
		arg.QueueStatus = "Queue failed"
		arg:Persist()
		arg:UpdateUI()
		return false, tostring(result)
	end

	arg.QueueJob = game.JobId
	arg.QueueStatus = "Armed: " .. tostring(arg2)
	arg:UpdateUI()
	return true
end

v.AutoFarm.GetOwnedCar = function()
	if not FlowClient.PlayerDataClient or type(FlowClient.PlayerDataClient.getObserver) ~= "function" then
		return
	end
	local ok, result = pcall(FlowClient.PlayerDataClient.getObserver, "cars")
	if not ok or not result or type(result.get) ~= "function" then
		return
	end
	local ok2, result2 = pcall(result.get, result)
	if not ok2 or type(result2) ~= "table" then
		return
	end
	local tbl20 = {}

	for k in result2, nil, nil do
		tbl20[#tbl20 + 1] = tostring(k)
	end

	table.sort(tbl20)
	return tbl20[1]
end

v.AutoFarm.WaitForTeleport = function(arg, arg2, arg3, arg4)
	local n4 = os.clock() + arg3
	local teleportFailureGeneration = tonumber(arg4) or arg.TeleportFailureGeneration
	if arg.TeleportFailureGeneration ~= teleportFailureGeneration then
		return false, "Teleport failed"
	end

	while true do
		if arg.TeleportFailureGeneration ~= teleportFailureGeneration then
			return false, "Teleport failed"
		else
			if arg.Teleporting then
				return true, "Teleport started"
			end
			task.wait(0.25)
			if not arg.Running or arg.Token ~= arg2 or v.Unloaded or arg.TeleportFailureGeneration ~= teleportFailureGeneration or os.clock() >= n4 then
				break
			end
		end
	end

	if arg.Teleporting and arg.TeleportFailureGeneration == teleportFailureGeneration then
		return true, "Teleport started"
	end
	return false, "Teleport timed out"
end

v.AutoFarm.DismissTeleportError = function()
	local GuiService = game:GetService("GuiService")
	pcall(GuiService.ClearError, GuiService)
	local robloxPromptGui = game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui")
	robloxPromptGui = robloxPromptGui and robloxPromptGui:FindFirstChild("promptOverlay")
	local errorPrompt = robloxPromptGui and (robloxPromptGui:FindFirstChild("ErrorPrompt") or robloxPromptGui:FindFirstChild("errorPrompt"))
	if not errorPrompt then
		return
	end
	local ok, result = pcall(errorPrompt.QueryDescendants, errorPrompt, "TextButton")
	if not ok then
		return
	end

	for _, v15 in result, nil, nil do
		local str3 = tostring(v15.Text or ""):lower()

		if str3 == "ok" or str3:find("reconnect", 1, true) then
			if type(firesignal) == "function" then
				pcall(firesignal, v15.MouseButton1Click)
			else
				pcall(v15.Activate, v15)
			end

			break
		end
	end
end

v.AutoFarm.StartTeleportRecovery = function(arg, arg2)
	if not arg.Running or arg.Token ~= arg2 or v.Unloaded then
		return
	end
	arg.TeleportRecovering = true
	arg.TeleportRecoveryGeneration = arg.TeleportRecoveryGeneration + 1
	local teleportRecoveryGeneration = arg.TeleportRecoveryGeneration
	local n4 = math.max(1, tonumber(arg.TeleportRetryCount) or 1)
	local tbl20 = { 2, 5, 10, 20, 30 }
	local teleportRetryDelay = arg.TeleportRetryDelay > 0 and arg.TeleportRetryDelay or tbl20[math.min(n4, #tbl20)]
	arg.TeleportRetryDelay = 0
	arg:SetPhase("Teleport Recovery", "Rejoining in " .. tostring(teleportRetryDelay) .. " seconds | Attempt " .. tostring(n4))
	arg:Persist()

	task.spawn(function()
		local n5 = os.clock() + teleportRetryDelay

		while true do
			task.wait(0.25)
			if not (not arg.Running or arg.Token ~= arg2 or v.Unloaded or arg.TeleportRecoveryGeneration ~= teleportRecoveryGeneration or os.clock() >= n5) then
				continue
			end
			break
		end

		if not arg.Running or arg.Token ~= arg2 or v.Unloaded or arg.TeleportRecoveryGeneration ~= teleportRecoveryGeneration then
			return
		end
		arg:DismissTeleportError()
		local num = tonumber(arg.TeleportRetryTarget)
		local teleportRetryOptions = arg.TeleportRetryOptions
		local flag3 = num == arg.LobbyPlaceId or num == arg.GamePlaceId

		if not flag3 then
			num = arg:IsAutoReplayEnabled() and arg.GamePlaceId or arg.LobbyPlaceId
		end

		local isTeleportOptions = n4 <= 3 and flag3 and typeof(teleportRetryOptions) == "Instance" and teleportRetryOptions:IsA("TeleportOptions")

		if not isTeleportOptions then
			teleportRetryOptions = nil
		end

		arg.QueueJob = nil
		arg.Teleporting = false
		local v15, v16 = arg:QueueTeleport("teleport recovery", num)

		if not v15 then
			local stats = arg.Stats
			stats.Retries = stats.Retries + 1
			arg.TeleportRetryCount = arg.TeleportRetryCount + 1
			arg.LastError = tostring(v16)
			arg:StartTeleportRecovery(arg2)
			return
		end

		arg:SetPhase(isTeleportOptions and "Retrying Teleport" or num == arg.GamePlaceId and "Rejoining Game" or "Rejoining Lobby", "Recovery attempt " .. tostring(n4))
		arg:Persist()
		local jobId = game.JobId
		local teleportFailureGeneration = arg.TeleportFailureGeneration

		local ok, result = pcall(function()
			local TeleportService = game:GetService("TeleportService")

			if isTeleportOptions then
				TeleportService:TeleportAsync(num, { localPlayer }, teleportRetryOptions)
			else
				TeleportService:Teleport(num, localPlayer)
			end
		end)

		if not ok then
			arg.Teleporting = false
			local stats = arg.Stats
			stats.Retries = stats.Retries + 1
			arg.TeleportRetryCount = arg.TeleportRetryCount + 1
			arg.LastError = tostring(result)
			arg:StartTeleportRecovery(arg2)
			return
		end

		local n6 = os.clock() + 30

		while true do
			task.wait(0.25)
			if not (not arg.Running or arg.Token ~= arg2 or v.Unloaded or arg.TeleportRecoveryGeneration ~= teleportRecoveryGeneration or arg.TeleportFailureGeneration ~= teleportFailureGeneration or game.JobId ~= jobId or os.clock() >= n6) then
				continue
			end
			break
		end

		if arg.Running and arg.Token == arg2 and not v.Unloaded and arg.TeleportRecoveryGeneration == teleportRecoveryGeneration and arg.TeleportFailureGeneration == teleportFailureGeneration and game.JobId == jobId then
			arg.Teleporting = false
			local stats = arg.Stats
			stats.Retries = stats.Retries + 1
			arg.TeleportRetryCount = arg.TeleportRetryCount + 1
			arg.LastError = "Teleport timed out"
			arg:StartTeleportRecovery(arg2)
		end
	end)
end

v.AutoFarm.HandleTeleportFailure = function(arg, arg2, arg3, arg4, arg5)
	if not arg.Running or v.Unloaded then
		return
	end
	task.defer(arg.DismissTeleportError, arg)
	local lastTeleportFailureAt = arg.LastTeleportFailureAt
	if os.clock() - lastTeleportFailureAt < 0.75 then
		return
	end
	arg.LastTeleportFailureAt = os.clock()
	local teleportRetryTarget = tonumber(arg4)

	if teleportRetryTarget ~= arg.LobbyPlaceId and teleportRetryTarget ~= arg.GamePlaceId then
		teleportRetryTarget = tonumber(arg.ExpectedPlaceId)
	end

	if teleportRetryTarget ~= arg.LobbyPlaceId and teleportRetryTarget ~= arg.GamePlaceId then
		teleportRetryTarget = arg:GetContext() == "Game" and arg:IsAutoReplayEnabled() and arg.GamePlaceId or arg.LobbyPlaceId
	end

	arg.TeleportFailureGeneration = arg.TeleportFailureGeneration + 1
	arg.Teleporting = false
	arg.QueueJob = nil
	arg.ReplayRequested = false
	arg.TeleportRetryCount = arg.TeleportRetryCount + 1
	arg.TeleportRetryTarget = teleportRetryTarget
	arg.TeleportRetryOptions = typeof(arg5) == "Instance" and arg5 or nil
	arg.TeleportRetryDelay = arg2 == Enum.TeleportResult.Flooded and 15 or 0
	local stats = arg.Stats
	stats.Retries = stats.Retries + 1
	arg.LastError = tostring(arg3 or arg2 or "Teleport failed")
	arg:SetCrossNoclip(false)
	arg:SetPhase("Teleport Failed", arg.LastError)
	arg:Persist()
	arg:SendWebhook("Error", arg.LastError)
	arg:StartTeleportRecovery(arg.Token)
end

v.AutoFarm.GetEndScreen = function(arg)
	local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
	local endFrame = playerGui and playerGui:FindFirstChild("EndFrame", true)
	if not playerGui then
		return
	end

	local function fn71(arg2)
		while arg2 and arg2 ~= playerGui do
			if arg2:IsA("GuiObject") and not arg2.Visible then
				return false
			end

			if arg2:IsA("LayerCollector") and not arg2.Enabled then
				return false
			end
			arg2 = arg2.Parent
		end

		return arg2 == playerGui
	end

	local function fn72(arg2)
		while arg2 and arg2 ~= playerGui do
			if arg2:IsA("LayerCollector") then
				return arg2
			end
			arg2 = arg2.Parent
		end
	end

	if endFrame then
		if not fn71(endFrame) then
			return
		end
		local escaped = endFrame:FindFirstChild("Escaped", true)
		local captured = endFrame:FindFirstChild("Captured", true)
		local replay = endFrame:FindFirstChild("Replay", true) or endFrame:FindFirstChild("Lobby", true)
		if escaped and fn71(escaped) then
			return endFrame, "Escaped"
		end

		if captured and fn71(captured) then
			return endFrame, "Captured"
		end

		if replay and fn71(replay) then
			return endFrame, "Ended"
		end

		for _, v15 in endFrame:GetDescendants() do
			if v15:IsA("GuiObject") and fn71(v15) then
				local str3 = v15.Name:lower()
				local str4 = (v15:IsA("TextLabel") or v15:IsA("TextButton")) and v15.Text:lower() or ""
				local flag3 = str3:find("captured", 1, true) ~= nil or str4:find("captured", 1, true) ~= nil
				local flag4 = str3:find("escaped", 1, true) ~= nil or str4:find("escaped", 1, true) ~= nil
				if flag3 or flag4 then
					return endFrame, flag3 and "Captured" or "Escaped"
				end
			end
		end

		return
	end

	local lastEndScreenScanAt = arg.LastEndScreenScanAt
	if os.clock() - lastEndScreenScanAt < 1 then
		return
	end
	arg.LastEndScreenScanAt = os.clock()

	for _, v15 in playerGui:GetDescendants() do
		if v15:IsA("GuiObject") and fn71(v15) then
			local str3 = v15.Name:lower()
			local str4 = (v15:IsA("TextLabel") or v15:IsA("TextButton")) and v15.Text:lower() or ""
			local flag3 = str3:find("captured", 1, true) ~= nil or str4:find("captured", 1, true) ~= nil
			local flag4 = str3:find("escaped", 1, true) ~= nil or str4:find("escaped", 1, true) ~= nil
			if flag3 or flag4 then
				return fn72(v15) or endFrame, flag3 and "Captured" or "Escaped"
			end
		end
	end
end

v.AutoFarm.IsVisible = function(arg, arg2)
	local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")

	while arg2 and arg2 ~= playerGui do
		if arg2:IsA("GuiObject") and not arg2.Visible then
			return false
		end

		if arg2:IsA("LayerCollector") and not arg2.Enabled then
			return false
		end
		arg2 = arg2.Parent
	end

	return arg2 == playerGui
end

v.AutoFarm.GetReplayButton = function(arg, arg2)
	if not arg2 then
		return
	end

	local function fn71(arg3)
		if not arg3:IsA("GuiButton") or not arg:IsVisible(arg3) then
			return false
		end
		local str3 = arg3.Name:lower()
		local isTextButton = arg3:IsA("TextButton")

		if isTextButton then
			isTextButton = tostring(arg3.Text or ""):lower()
		end

		isTextButton = isTextButton or ""

		if isTextButton == "" then
			isTextButton = arg3:FindFirstChildWhichIsA("TextLabel", true)

			if isTextButton then
				isTextButton = tostring(isTextButton.Text or ""):lower()
			end

			isTextButton = isTextButton or ""
		end

		return str3:find("replay", 1, true) ~= nil or isTextButton:find("replay", 1, true) ~= nil
	end

	local replay = arg2:FindFirstChild("Replay", true)

	if replay then
		if fn71(replay) then
			return replay
		end
		local guiButton = replay:FindFirstChildWhichIsA("GuiButton", true)
		if guiButton and fn71(guiButton) then
			return guiButton
		end
	end

	for _, v15 in arg2:GetDescendants() do
		if fn71(v15) then
			return v15
		end
	end
end

v.AutoFarm.GetReplayVotes = function(arg, arg2)
	if not arg2 then
		return
	end
	local isTextButton = arg2:IsA("TextButton")

	if isTextButton then
		isTextButton = tostring(arg2.Text or "")
	end

	isTextButton = isTextButton or ""

	if isTextButton == "" then
		isTextButton = arg2:FindFirstChildWhichIsA("TextLabel", true)

		if isTextButton then
			isTextButton = tostring(isTextButton.Text or "")
		end

		isTextButton = isTextButton or ""
	end

	local match, v15 = isTextButton:match("(%d+)%s*/%s*(%d+)")
	local v16 = tonumber
	return tonumber(match), v16(v15)
end

v.AutoFarm.RequestReplay = function(arg, arg2)
	local flag3 = FlowClient.GameManager and type(FlowClient.GameManager.Replay) == "function"
	local str3 = "Replay is unavailable"

	if flag3 then
		local ok, result = pcall(FlowClient.GameManager.Replay)
		if ok and result ~= false then
			return true
		end
		str3 = tostring(result or "Replay was rejected")
	end

	if arg2 then
		if type(firesignal) == "function" then
			local ok, result = pcall(firesignal, arg2.MouseButton1Click)
			if ok then
				return true
			end
			str3 = tostring(result)
		else
			local ok, result = pcall(arg2.Activate, arg2)
			if ok then
				return true
			end
			str3 = tostring(result)
		end
	end

	return false, str3
end

v.AutoFarm.GetResultCredz = function(arg, arg2)
	arg2 = arg2 and arg2:FindFirstChild("Total", true)
	if not arg2 then
		return
	end

	for _, v15 in { "RobloxPlus", "Credz" }, nil, nil do
		local v16 = arg2:FindFirstChild(v15, true)

		if v16 and (v16:IsA("TextLabel") or v16:IsA("TextButton")) and arg:IsVisible(v16) then
			local str3 = tostring(v16.Text or ""):gsub("[^%d]", "")
			local num = tonumber(str3)
			if num then
				return num
			end
		end
	end

	local v15

	for _, v16 in arg2:GetDescendants() do
		if (v16:IsA("TextLabel") or v16:IsA("TextButton")) and arg:IsVisible(v16) then
			if tostring(v16.Text or ""):lower():find("total:", 1, true) then
				local str3 = v15:gsub("[^%d]", "")
				local num = tonumber(str3)
				if num then
					return num
				end
			end
		end
	end
end

v.AutoFarm.FinalizeRun = function(arg, arg2, arg3, arg4)
	if arg.ResultFinalized then
		return
	end
	local lastRun = arg.RunStartedAt > 0

	if lastRun then
		local runStartedAt = arg.RunStartedAt
		lastRun = math.max(0, os.time() - runStartedAt)
	end

	lastRun = lastRun or 0
	local flag3 = arg.RunStartedAt > 0
	arg:SyncProgress()
	local effectiveCredz = arg:GetEffectiveCredz()
	local effectiveWins = arg:GetEffectiveWins()
	local n4 = math.max(0, effectiveCredz - (tonumber(arg.RunCashStart) or effectiveCredz))
	local num = tonumber(arg4)

	if flag3 and num and num > n4 then
		local n5 = num - n4
		local stats = arg.Stats
		stats.CashEarned = stats.CashEarned + n5
		arg.PendingCredz = arg.PendingCredz + n5
		effectiveCredz += n5
	else
		num = n4
	end

	arg:ReleaseSafeZone()
	arg.ResultFinalized = true

	if flag3 then
		arg.Stats.Attempts = math.max(arg.Stats.Attempts, arg.Stats.Completed + arg.Stats.Failed + 1)
	end

	if flag3 and arg2 == "Escaped" then
		local stats = arg.Stats
		stats.Completed = stats.Completed + 1

		if effectiveWins <= (tonumber(arg.RunWinsStart) or effectiveWins) then
			arg.PendingWins = arg.PendingWins + 1
			effectiveWins += 1
		end

		arg.Stats.LastRun = lastRun
		local stats2 = arg.Stats
		stats2.TotalRunTime = stats2.TotalRunTime + lastRun

		if arg.Stats.BestRun == 0 or lastRun < arg.Stats.BestRun then
			arg.Stats.BestRun = lastRun
		end
	elseif flag3 then
		local stats = arg.Stats
		stats.Failed = stats.Failed + 1
		arg.Stats.LastRun = lastRun
	end

	arg.PendingFinish = false
	arg.FinishCrossed = false
	arg.PendingAt = 0
	arg.RunStartedAt = 0
	arg.RunCashStart = effectiveCredz
	arg.RunWinsStart = effectiveWins
	arg.GateStartedAt = 0
	arg.GatePassage = nil
	arg.GateText = "--"

	if arg2 == "Escaped" then
		arg.LastError = "None"
		local v15 = arg
		local setPhase = v15.SetPhase
		arg3 = arg3 or "Finish confirmed"
		setPhase(v15, "Run Completed", arg3 .. " | +" .. tostring(math.floor(num)) .. " Credz")
		arg:Persist()

		if flag3 then
			arg:SendWebhook("Run Completed", arg.Detail)
		end
	else
		arg.LastError = "Run captured"
		arg:SetPhase("Run Captured", arg3 or "Preparing the next run")
		arg:Persist()

		if flag3 then
			arg:SendWebhook("Error", arg.LastError)
		end
	end
end

v.AutoFarm.CompletePending = function(arg, arg2)
	if not arg.PendingFinish then
		return
	end
	local finishCrossed = arg.LastGameJob ~= "" and arg.LastGameJob ~= game.JobId and arg.PendingAt > 0 and arg.FinishCrossed

	if finishCrossed then
		local pendingAt = arg.PendingAt
		finishCrossed = os.time() - pendingAt <= 600
	end

	if not finishCrossed then
		arg.PendingFinish = false
		arg.FinishCrossed = false
		arg.PendingAt = 0
		arg.LastError = "Pending completion expired"
		return
	end

	arg:FinalizeRun("Escaped", arg2 or "Transition confirmed")
end

v.AutoFarm.HandleEndScreen = function(arg, arg2)
	if arg.ResultBusy then
		return false, "Result is already being handled"
	end
	local endScreen, v15 = arg:GetEndScreen()
	if not endScreen then
		return false, "Result screen is unavailable"
	end
	arg.ResultBusy = true
	arg:ReleaseSafeZone()
	local map = workspace:FindFirstChild("Map")
	local character = localPlayer.Character
	local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
	humanoidRootPart = humanoidRootPart and humanoidRootPart.Position
	local endPrompt = teleports:GetEndPrompt()
	local enabled = endPrompt and endPrompt.Enabled

	if v15 == "Ended" then
		local n4 = os.clock() + 2

		while true do
			task.wait(0.1)
			endScreen, v15 = arg:GetEndScreen()
			if not (v15 ~= "Ended" or not endScreen or not arg.Running or arg.Token ~= arg2 or os.clock() >= n4) then
				continue
			end
			break
		end
	end

	local str3

	if v15 == "Escaped" or v15 == "Ended" and arg.FinishCrossed then
		str3 = "Escaped"
	else
		str3 = "Captured"
	end

	local n4 = os.clock() + 3
	local resultCredz

	while true do
		resultCredz = arg:GetResultCredz(endScreen)

		if resultCredz then
			break
		else
			task.wait(0.1)
			if not (not arg.Running or arg.Token ~= arg2 or v.Unloaded or os.clock() >= n4) then
				continue
			end
			break
		end
	end

	if not arg.Running or arg.Token ~= arg2 or v.Unloaded then
		arg.ResultBusy = false
		return true, "Stopped"
	end
	arg:FinalizeRun(str3, str3 == "Escaped" and "Finish confirmed" or "The run ended before the finish", resultCredz)
	if not arg.Running or arg.Token ~= arg2 then
		arg.ResultBusy = false
		return true, "Stopped"
	end

	if arg:IsAutoReplayEnabled() then
		local now = os.clock()
		local n5 = now + 45
		arg.ReplayRequested = true
		arg:SetPhase("Auto Replay", "Waiting for the replay control")
		local now2 = nil
		local flag3 = false
		local n6 = 0
		local n7 = now

		while true do
			arg.RunHeartbeat = os.clock()

			if arg.Teleporting then
				return true, "Teleporting"
			else
				local endScreen2 = arg:GetEndScreen()

				if not endScreen2 then
					now2 = now2 or os.clock()
					local map2 = workspace:FindFirstChild("Map")
					local character2 = localPlayer.Character
					local humanoid = character2 and character2:FindFirstChildOfClass("Humanoid")
					local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")
					local endPrompt2 = teleports:GetEndPrompt()

					if (map2 and map and map2 ~= map or character2 and character and character2 ~= character or endPrompt2 and endPrompt and endPrompt2 ~= endPrompt or endPrompt and endPrompt2 == endPrompt and not enabled and endPrompt2.Enabled or humanoidRootPart and humanoidRootPart2 and (humanoidRootPart2.Position - humanoidRootPart).Magnitude >= 250) and humanoid and humanoid.Health > 0 and os.clock() - now2 >= 0.75 then
						arg.LastGameJob = ""
						arg.ReplayRequested = false
						arg.ResultBusy = false
						arg.QueueStatus = "Replay started"
						arg:Persist()
						task.wait(1)
						return true, "Replay"
					end
				else
					now2 = nil

					if n7 <= os.clock() then
						local replayButton = arg:GetReplayButton(endScreen2)
						local replayVotes, v16 = arg:GetReplayVotes(replayButton)

						if replayVotes and v16 and v16 > 0 and replayVotes >= v16 then
							arg:SetPhase("Auto Replay", "Replay vote confirmed")
							n7 = os.clock() + 5
							now2 = nil
						elseif replayButton or os.clock() - now >= 8 then
							if not flag3 then
								local v17
								flag3, v17 = arg:QueueTeleport("replay", arg.GamePlaceId)

								if not flag3 then
									arg.LastError = tostring(v17)
									arg:SetPhase("Auto Replay", "Waiting for the teleport loader")
									n7 = os.clock() + 3
								end
							end

							if flag3 and n6 < 10 then
								local flag4 = n6 == 0

								if flag4 then
									local stats = arg.Stats
									stats.Replays = stats.Replays + 1
									arg:SetPhase("Auto Replay", "Submitting replay vote")
									arg:Persist()
								end

								local v17, v18 = arg:RequestReplay(replayButton)

								if v17 then
									n6 += 1
									arg:SetPhase("Auto Replay", "Replay vote submitted")
								else
									if flag4 then
										arg.Stats.Replays = math.max(0, arg.Stats.Replays - 1)
										arg:Persist()
									end

									arg.LastError = tostring(v18)
									arg:SetPhase("Auto Replay", arg.LastError)
								end

								n7 = os.clock() + 2
								now2 = nil
							else
								now2 = nil

								if flag3 then
									n7 = os.clock() + 3
									now2 = nil
								end
							end
						else
							n7 = os.clock() + 0.5
							now2 = nil
						end
					end
				end

				task.wait(0.25)
				if not arg.Running or arg.Token ~= arg2 or v.Unloaded or os.clock() >= n5 then
					break
				end
			end
		end

		arg.ReplayRequested = false
		if not arg.Running or arg.Token ~= arg2 or v.Unloaded then
			arg.ResultBusy = false
			return true, "Stopped"
		end
		local v16, v17 = arg:QueueTeleport("replay recovery", arg.GamePlaceId)
		if not v16 then
			arg.ResultBusy = false
			return false, tostring(v17)
		end
		arg:SetPhase("Restarting Game", "Replay did not start")
		local teleportFailureGeneration = arg.TeleportFailureGeneration
		local ok, result = pcall(game:GetService("TeleportService").Teleport, game:GetService("TeleportService"), arg.GamePlaceId, localPlayer)
		if not ok then
			arg.ResultBusy = false
			return false, tostring(result)
		end

		if arg:WaitForTeleport(arg2, 30, teleportFailureGeneration) then
			return true, "Teleporting"
		end

		if arg.TeleportRecovering then
			return false, "Teleport recovery active"
		end
		arg.ResultBusy = false
		return false, "Game restart did not start"
	end

	arg.ReplayRequested = false
	if not arg.Running or arg.Token ~= arg2 then
		arg.ResultBusy = false
		return true, "Stopped"
	end

	if not FlowClient.GameManager or type(FlowClient.GameManager.BackToLobby) ~= "function" then
		arg.ResultBusy = false
		return false, "Lobby return is unavailable"
	end
	local lobby, v16 = arg:QueueTeleport("lobby", arg.LobbyPlaceId)

	if not lobby then
		arg.LastError = tostring(v16)
	end

	local teleportFailureGeneration = arg.TeleportFailureGeneration
	local ok, result = pcall(FlowClient.GameManager.BackToLobby)
	if not ok then
		arg.ResultBusy = false
		return false, tostring(result)
	end
	arg:SetPhase("Returning to Lobby", "Replay was unavailable")
	if arg:WaitForTeleport(arg2, 30, teleportFailureGeneration) then
		return true, "Teleporting"
	end
	arg.ResultBusy = false
	return false, "Lobby teleport did not start"
end

v.AutoFarm.RunLobby = function(arg, arg2)
	if not FlowClient.LobbyServer or type(FlowClient.LobbyServer.play) ~= "function" or type(FlowClient.LobbyServer.create) ~= "function" or type(FlowClient.LobbyServer.exit) ~= "function" then
		return false, "Lobby API is unavailable"
	end

	if arg.PendingFinish then
		arg:SetPhase("Confirming Run", "Waiting for the lobby reward")
		local n4 = os.clock() + 8

		while true do
			arg:SyncProgress()

			if not (arg:GetEffectiveWins() > (tonumber(arg.RunWinsStart) or arg:GetEffectiveWins())) then
				task.wait(0.5)
				if not (not arg.Running or arg.Token ~= arg2 or os.clock() >= n4) then
					continue
				end
			end

			break
		end

		if not arg.Running or arg.Token ~= arg2 then
			return true
		end
		arg:CompletePending("Returned to lobby")
	end

	arg:SetPhase("Lobby", "Waiting before the next game")
	local lobbyDelay = v3.RunawaysAutoFarmLobbyDelay and v3.RunawaysAutoFarmLobbyDelay.Value or arg.Config.LobbyDelay
	local n4 = os.clock() + lobbyDelay

	while true do
		task.wait(0.1)
		if not (not arg.Running or arg.Token ~= arg2 or os.clock() >= n4) then
			continue
		end
		break
	end

	if not arg.Running or arg.Token ~= arg2 then
		return true
	end
	local ownedCar = arg:GetOwnedCar()
	if not ownedCar then
		return false, "No owned vehicle is available"
	end
	local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")

	if playerGui then
		playerGui = playerGui:FindFirstChild("CreateLobbyGui") or playerGui:WaitForChild("CreateLobbyGui", 10)
	end

	if not playerGui then
		return false, "Create lobby UI is unavailable"
	end
	local game_, v15 = arg:QueueTeleport("game", arg.GamePlaceId)
	if not game_ then
		return false, v15
	end

	if playerGui then
		playerGui:FindFirstChild("Frame")
	end

	if playerGui then
		playerGui:FindFirstChild("Exit")
	end

	for i = 1, 2 do
		if not arg.Running or arg.Token ~= arg2 then
			return true
		end
		local frame = playerGui:FindFirstChild("Frame")
		local exit = playerGui:FindFirstChild("Exit")

		if exit and exit.Visible then
			arg:SetPhase("Lobby", "Leaving an existing queue")
			pcall(FlowClient.LobbyServer.exit)
			local n5 = os.clock() + 5

			while true do
				task.wait(0.1)
				if not (not exit.Visible or not arg.Running or arg.Token ~= arg2 or os.clock() >= n5) then
					continue
				end
				break
			end

			if exit.Visible then
				local stats = arg.Stats
				stats.Retries = stats.Retries + 1
				task.wait(i)
				continue
			end
		end

		local flag3 = not frame

		if flag3 or not frame.Visible then
			arg:SetPhase("Lobby", "Requesting the next game")
			local ok, result = pcall(FlowClient.LobbyServer.play)
			if not ok then
				return false, tostring(result)
			end
			local n5 = os.clock() + 10

			while true do
				if arg.Teleporting then
					return true
				else
					task.wait(0.2)
					if not arg.Running or arg.Token ~= arg2 or frame and frame.Visible or exit and exit.Visible or os.clock() >= n5 then
						break
					end
				end
			end
		end

		if exit and exit.Visible then
			arg:SetPhase("Lobby", "Leaving an existing queue")
			local stats = arg.Stats
			stats.Retries = stats.Retries + 1
			pcall(FlowClient.LobbyServer.exit)
			task.wait(i * 1.5)
			continue
		end

		if flag3 or not frame.Visible then
			local stats = arg.Stats
			stats.Retries = stats.Retries + 1
			task.wait(i)
			continue
		end

		arg:SetPhase("Creating Game", "Vehicle: " .. ownedCar .. " | Solo | Friends")
		frame.Visible = false
		local teleportFailureGeneration = arg.TeleportFailureGeneration
		local ok, result = pcall(FlowClient.LobbyServer.create, { maxPlayers = 1, permissions = "Friends", car = ownedCar })
		if not ok then
			return false, tostring(result)
		end
		local n5 = os.clock() + 5

		while true do
			task.wait(0.2)
			if not (arg.Teleporting or exit and exit.Visible or not arg.Running or arg.Token ~= arg2 or os.clock() >= n5) then
				continue
			end
			break
		end

		if arg.Teleporting or arg:WaitForTeleport(arg2, 20, teleportFailureGeneration) then
			return true
		end

		if arg.TeleportRecovering then
			return false, "Teleport recovery active"
		end
		local stats = arg.Stats
		stats.Retries = stats.Retries + 1
		pcall(FlowClient.LobbyServer.exit)

		if FlowClient.LobbyClient and type(FlowClient.LobbyClient.forceLeave_event) == "function" then
			pcall(FlowClient.LobbyClient.forceLeave_event)
		end

		task.wait(i * 2)
	end

	arg:SetPhase("Refreshing Lobby", "Game creation timed out")
	local v16, v17 = arg:QueueTeleport("lobby retry", arg.LobbyPlaceId)
	if not v16 then
		return false, v17
	end
	local teleportFailureGeneration = arg.TeleportFailureGeneration
	local ok, result = pcall(game:GetService("TeleportService").Teleport, game:GetService("TeleportService"), arg.LobbyPlaceId, localPlayer)
	if not ok then
		return false, tostring(result)
	end

	if arg:WaitForTeleport(arg2, 30, teleportFailureGeneration) then
		return true, "Teleporting"
	end
	return false, "Lobby refresh did not start"
end

v.AutoFarm.ReachGate = function(arg, arg2)
	arg:SetPhase("Traveling", "Teleporting to the end gate")
	local n4 = os.clock() + 20
	local endZ

	while true do
		endZ = teleports:GetEndZ()

		if not endZ then
			task.wait(0.25)
		end

		if not (endZ or not arg.Running or arg.Token ~= arg2 or v.Unloaded or os.clock() >= n4) then
			continue
		end
		break
	end

	if not endZ then
		return nil, nil, nil, "End position is unavailable"
	end
	local startCFrame = teleports:GetStartCFrame()
	local n5 = (not startCFrame or endZ >= startCFrame.Position.Z) and 1 or -1
	local endAnchor = teleports:GetEndAnchor(endZ, n5)
	teleports:Stream(endAnchor)

	if not teleports:GetEndPrompt() then
		local roadNear = teleports:GetRoadNear(endZ)
		local vector

		if roadNear then
			vector = Vector3.new(roadNear.Position.X, roadNear.Position.Y + roadNear.Size.Y * 0.5 + 5, endZ - n5 * 30)
		else
			vector = Vector3.new(endAnchor.X, endAnchor.Y + 4, endZ - n5 * 30)
		end

		teleports:Move(CFrame.lookAt(vector, vector + Vector3.new(0, 0, n5), Vector3.new(0, 1, 0)), nil, false)
		teleports:Stream(endAnchor)
	end

	local n6 = os.clock() + 20

	repeat
		local endPrompt = teleports:GetEndPrompt()

		if endPrompt then
			local endPromptDestination = teleports:GetEndPromptDestination(endPrompt, n5)

			if endPromptDestination then
				teleports:Move(endPromptDestination, nil, false)
				task.wait(0.4)
				local character = localPlayer.Character
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")
				character = character and character:FindFirstChild("HumanoidRootPart")
				if humanoid and character and humanoid.Health > 0 and (character.Position - endPromptDestination.Position).Magnitude <= math.max(endPrompt.MaxActivationDistance + 5, 14) then
					arg.GatePassage = arg.GatePassage or arg:GetGatePassage(endPrompt, n5, endZ)
					return endPrompt, n5, endZ
				end
			end
		end

		task.wait(0.25)
	until not arg.Running or arg.Token ~= arg2 or v.Unloaded or os.clock() >= n6

	if arg.Running and arg.Token == arg2 and arg.GateStartedAt > 0 and arg.LastGameJob == game.JobId then
		arg.GatePassage = arg.GatePassage or arg:GetGatePassage(nil, n5, endZ)

		if arg.GatePassage then
			local n7 = arg.GatePassage.Position - Vector3.new(0, 0, n5 * 8)
			teleports:Move(CFrame.lookAt(n7, n7 + Vector3.new(0, 0, n5), Vector3.new(0, 1, 0)), nil, false)
			return nil, n5, endZ, nil, true
		end
	end

	return nil, nil, nil, "End gate prompt was not reached"
end

v.AutoFarm.GetFinalDoor = function(arg, arg2)
	arg2 = arg2 and arg2:FindFirstAncestor("FinalDoor")
	if arg2 then
		return arg2
	end
	local map = workspace:FindFirstChild("Map")
	map = map and map:FindFirstChild("Buildings")
	map = map and map:FindFirstChild("CustomsFinal")
	return map and map:FindFirstChild("FinalDoor", true)
end

v.AutoFarm.GetGateTimer = function(arg, arg2)
	local finalDoor = arg:GetFinalDoor(arg2)
	if not finalDoor then
		return
	end
	local ok, result = pcall(finalDoor.QueryDescendants, finalDoor, "TextLabel")

	if not ok then
		result = {}

		for _, v15 in finalDoor:GetDescendants() do
			if v15:IsA("TextLabel") then
				result[#result + 1] = v15
			end
		end
	end

	for _, v15 in result, nil, nil do
		local text = v15.Text
		local match, v16 = text:match("(%d+)%s*m%s*(%d+)%s*s")

		if not match then
			match, v16 = text:match("(%d+)%s*:%s*(%d+)")
		end

		if match and v16 then
			return tonumber(match) * 60 + tonumber(v16), text
		end
	end
end

v.AutoFarm.CaptureGate = function(arg, arg2)
	local finalDoor = arg:GetFinalDoor(arg2)
	local tbl20 = {}
	if not finalDoor then
		return tbl20
	end
	local ok, result = pcall(finalDoor.QueryDescendants, finalDoor, "BasePart")

	if not ok then
		result = {}

		for _, v15 in finalDoor:GetDescendants() do
			if v15:IsA("BasePart") then
				result[#result + 1] = v15
			end
		end
	end

	for _, v15 in result, nil, nil do
		tbl20[v15] = { Position = v15.Position, CanCollide = v15.CanCollide, Transparency = v15.Transparency }
	end

	return tbl20
end

v.AutoFarm.GetGatePassage = function(arg, arg2, arg3, arg4)
	local finalDoor = arg:GetFinalDoor(arg2)
	local command = finalDoor and finalDoor:FindFirstChild("Command", true)
	local doorL = finalDoor and finalDoor:FindFirstChild("DoorL")
	local doorR = finalDoor and finalDoor:FindFirstChild("DoorR")
	doorL = doorL and doorL:FindFirstChild("Door", true)
	doorR = doorR and doorR:FindFirstChild("Door", true)
	local v15 = nil

	if finalDoor then
		local ok, result = pcall(finalDoor.QueryDescendants, finalDoor, "BasePart")

		if not ok then
			result = {}

			for _, v16 in finalDoor:GetDescendants() do
				if v16:IsA("BasePart") then
					result[#result + 1] = v16
				end
			end
		end

		local n4 = -math.huge
		v15 = nil

		for _, v16 in result, nil, nil do
			if v16.CanCollide and v16.Transparency < 0.95 and v16.Size.Y >= 4 and (not command or not v16:IsDescendantOf(command)) then
				local str3 = v16.Name:lower()
				local n5 = v16.Size.X * v16.Size.Y / math.max(v16.Size.Z, 0.5)

				if str3:find("door", 1, true) or str3:find("gate", 1, true) then
					n5 += 1000000
				elseif str3:find("wall", 1, true) or str3:find("frame", 1, true) then
					n5 -= 1000000
				end

				if n4 < n5 then
					n4 = n5
					v15 = v16
				end
			end
		end
	end

	local roadNear = teleports:GetRoadNear(arg4)
	local position = doorL and doorL:IsA("BasePart") and doorR and doorR:IsA("BasePart") and (doorL.Position + doorR.Position) * 0.5 or v15 and v15.Position or roadNear and Vector3.new(roadNear.Position.X, roadNear.Position.Y + roadNear.Size.Y * 0.5 + 3.5, arg4)

	if not position then
		arg2 = arg2 and arg2.Parent

		if arg2 and arg2:IsA("Attachment") then
			position = arg2.WorldPosition
		elseif arg2 and arg2:IsA("BasePart") then
			position = arg2.Position
		end
	end

	if not position then
		return
	end
	local raycastParams = RaycastParams.new()
	local filterDescendantsInstances = {}
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude

	if localPlayer.Character then
		filterDescendantsInstances[#filterDescendantsInstances + 1] = localPlayer.Character
	end

	if finalDoor then
		filterDescendantsInstances[#filterDescendantsInstances + 1] = finalDoor
	end

	raycastParams.FilterDescendantsInstances = filterDescendantsInstances
	raycastParams.RespectCanCollide = true
	local hit = workspace:Raycast(position + Vector3.new(0, 1, 0) * 30, -Vector3.new(0, 1, 0) * 80, raycastParams)

	if hit then
		position = Vector3.new(position.X, hit.Position.Y + 3.5, position.Z)
	elseif roadNear then
		position = Vector3.new(position.X, roadNear.Position.Y + roadNear.Size.Y * 0.5 + 3.5, position.Z)
	end

	return { Position = position, Direction = arg3, FinalDoor = finalDoor, DoorL = doorL, DoorR = doorR }
end

v.AutoFarm.IsGatePassageOpen = function(arg, arg2)
	if not arg2 or typeof(arg2.Position) ~= "Vector3" then
		return false
	end
	local finalDoor = arg2.FinalDoor

	if not finalDoor or not finalDoor.Parent then
		finalDoor = arg:GetFinalDoor()
		arg2.FinalDoor = finalDoor
	end

	if finalDoor then
		local doorL = finalDoor:FindFirstChild("DoorL")
		local doorR = finalDoor:FindFirstChild("DoorR")
		doorL = doorL and doorL:FindFirstChild("Door", true)
		doorR = doorR and doorR:FindFirstChild("Door", true)

		if doorL and doorL:IsA("BasePart") then
			arg2.DoorL = doorL
		end

		if doorR and doorR:IsA("BasePart") then
			arg2.DoorR = doorR
		end
	end

	local doorL = arg2.DoorL
	local doorR = arg2.DoorR

	if doorL and doorL.Parent and doorL:IsA("BasePart") and doorR and doorR.Parent and doorR:IsA("BasePart") then
		local n4 = doorL.Position - doorR.Position

		if n4.Magnitude > 0.1 then
			local unit = n4.Unit
			local x = doorL.Size.X
			local upVector = doorL.CFrame.UpVector
			local y = doorL.Size.Y
			local n5 = math.abs(doorL.CFrame.RightVector:Dot(unit)) * x * 0.5 + math.abs(upVector:Dot(unit)) * y * 0.5
			local z = doorL.Size.Z
			local n6 = n5 + math.abs(doorL.CFrame.LookVector:Dot(unit)) * z * 0.5
			local x2 = doorR.Size.X
			local upVector2 = doorR.CFrame.UpVector
			local y2 = doorR.Size.Y
			local n7 = math.abs(doorR.CFrame.RightVector:Dot(unit)) * x2 * 0.5 + math.abs(upVector2:Dot(unit)) * y2 * 0.5
			local z2 = doorR.Size.Z
			local n8 = n7 + math.abs(doorR.CFrame.LookVector:Dot(unit)) * z2 * 0.5
			local n9 = (doorL.Position + doorR.Position) * 0.5
			arg2.Position = Vector3.new(n9.X, arg2.Position.Y, n9.Z)
			return n4.Magnitude - n6 - n8 >= 12
		end
	end

	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = localPlayer.Character and { localPlayer.Character } or {}
	raycastParams.RespectCanCollide = true
	local vector = Vector3.new(0, 0, arg2.Direction)
	return workspace:Raycast(arg2.Position - vector * 10, vector * 20, raycastParams) == nil
end

v.AutoFarm.IsGateWindowOpen = function()
	if FlowClient.CrimesGui and type(FlowClient.CrimesGui.StartEndTimer_event) == "function" and debug and type(debug.getupvalues) == "function" then
		local ok, result = pcall(debug.getupvalues, FlowClient.CrimesGui.StartEndTimer_event)

		if ok and type(result) == "table" then
			local num = tonumber(result[2])
			local num2 = tonumber(result[3])
			local serverTimeNow = workspace:GetServerTimeNow()
			if num and num2 and serverTimeNow >= num and serverTimeNow < num2 then
				return true
			end
		end
	end

	local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
	playerGui = playerGui and playerGui:FindFirstChild("HudGui")
	playerGui = playerGui and playerGui:FindFirstChild("Events")
	playerGui = playerGui and playerGui:FindFirstChild("Closing")
	if not playerGui or not playerGui.Visible then
		return false
	end
	local timer = playerGui:FindFirstChild("Timer")
	local match, v15 = (timer and timer.Text or ""):match("(%d+)%s*:%s*(%d+)")
	return not match or tonumber(match) * 60 + tonumber(v15) > 0
end

v.AutoFarm.IsGateMoving = function(arg, arg2)
	for k, v15 in arg2, nil, nil do
		if not k.Parent or (k.Position - v15.Position).Magnitude >= 5 or v15.CanCollide and not k.CanCollide or k.Transparency - v15.Transparency >= 0.7 then
			return true
		end
	end

	return false
end

v.AutoFarm.ActivateGate = function(arg, arg2, arg3, arg4)
	if not arg.Running or arg.Token ~= arg4 then
		return false, {}, "Auto Farm stopped"
	end

	if arg.GateStartedAt > 0 and arg.LastGameJob == game.JobId then
		local gateTimer = arg:GetGateTimer(arg2)
		if not arg2.Enabled or gateTimer and gateTimer < 120 then
			return true, arg:CaptureGate(arg2)
		end
		arg.GateStartedAt = 0
	end

	arg:SetPhase("Activating Gate", "Starting the two minute countdown")
	local v15 = arg:CaptureGate(arg2)

	for i = 1, 3 do
		if not arg.Running or arg.Token ~= arg4 then
			return false, v15, "Auto Farm stopped"
		end
		local endPromptDestination = teleports:GetEndPromptDestination(arg2, arg3)

		if endPromptDestination then
			teleports:Move(endPromptDestination, nil, false)
			task.wait(0.4)
		end

		if not arg.Running or arg.Token ~= arg4 then
			return false, v15, "Auto Farm stopped"
		end
		local gateTimer = arg:GetGateTimer(arg2)
		local flag3 = false

		if type(fireproximityprompt) == "function" then
			flag3 = pcall(fireproximityprompt, arg2)
		end

		flag3 = flag3 or pcall(function()
			local holdDuration = arg2.HoldDuration
			arg2.HoldDuration = 0
			arg2:InputHoldBegin()
			task.wait(0.1)
			arg2:InputHoldEnd()
			arg2.HoldDuration = holdDuration
		end)

		if not arg.Running or arg.Token ~= arg4 then
			return false, v15, "Auto Farm stopped"
		end

		if flag3 then
			local n4 = os.clock() + 6

			repeat
				local gateTimer2 = arg:GetGateTimer(arg2)

				if not arg2.Enabled or gateTimer2 and gateTimer and gateTimer2 < gateTimer or gateTimer2 and gateTimer2 < 120 then
					arg.GateStartedAt = os.time() - (gateTimer2 and math.max(0, 120 - gateTimer2) or 0)
					local stats = arg.Stats
					stats.GateActivations = stats.GateActivations + 1
					arg:Persist()
					return true, v15
				end

				task.wait(0.25)
			until os.clock() >= n4 or not arg.Running or arg.Token ~= arg4 or v.Unloaded

			if not arg.Running or arg.Token ~= arg4 then
				return false, v15, "Auto Farm stopped"
			end
		end

		local stats = arg.Stats
		stats.Retries = stats.Retries + 1
		task.wait(i)
	end

	arg.GateStartedAt = 0
	return false, v15, "Gate activation was not confirmed"
end

v.AutoFarm.GetSafeCFrame = function(arg)
	local gatePassage = arg.GatePassage
	if not gatePassage or typeof(gatePassage.Position) ~= "Vector3" then
		return
	end
	local finalDoor = gatePassage.FinalDoor
	finalDoor = finalDoor and finalDoor:FindFirstAncestor("CustomsBuilding")
	local endPrompt = teleports:GetEndPrompt()
	endPrompt = endPrompt and endPrompt.Parent
	local worldPosition = endPrompt and endPrompt:IsA("Attachment") and endPrompt.WorldPosition or endPrompt and endPrompt:IsA("BasePart") and endPrompt.Position or gatePassage.Position
	local v15 = nil

	if finalDoor then
		local huge = math.huge
		v15 = nil

		for _, v16 in finalDoor:GetChildren() do
			if v16.Name == "CustomsOffice" then
				local floor = v16:FindFirstChild("Floor", true)

				if floor and floor:IsA("BasePart") then
					local magnitude = (floor.Position - worldPosition).Magnitude

					if magnitude < huge then
						huge = magnitude
						v15 = floor
					end
				end
			end
		end
	end

	if v15 then
		local v16 = v15.CFrame:PointToWorldSpace(Vector3.new(5, v15.Size.Y * 0.5 + 3.25, 8))
		local raycastParams = RaycastParams.new()
		local overlapParams = OverlapParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastParams.FilterDescendantsInstances = localPlayer.Character and { localPlayer.Character } or {}
		raycastParams.RespectCanCollide = true
		overlapParams.FilterType = Enum.RaycastFilterType.Exclude
		overlapParams.FilterDescendantsInstances = localPlayer.Character and { localPlayer.Character } or {}
		local hit = workspace:Raycast(v16, -Vector3.new(0, 1, 0) * 6, raycastParams)
		local hit2 = workspace:Raycast(v16, Vector3.new(0, 1, 0) * 30, raycastParams)
		local flag3 = false

		for _, v17 in workspace:GetPartBoundsInBox(CFrame.new(v16), Vector3.new(3.5, 5.5, 3.5), overlapParams) do
			if v17.CanCollide and v17 ~= v15 then
				flag3 = true
				break
			end
		end

		if hit and hit2 and not flag3 then
			return CFrame.lookAt(v16, Vector3.new(worldPosition.X, v16.Y, worldPosition.Z), Vector3.new(0, 1, 0))
		end
	end
end

v.AutoFarm.DisengageHelicopter = function()
	if FlowClient.PoliceHeli and type(FlowClient.PoliceHeli.Despawn) == "function" then
		pcall(FlowClient.PoliceHeli.Despawn)
	end
end

v.AutoFarm.ReleaseSafeZone = function(arg)
	local safeCharacter = arg.SafeCharacter
	safeCharacter = safeCharacter and safeCharacter:FindFirstChild("HumanoidRootPart")

	if safeCharacter and arg.SafeRootAnchored ~= nil then
		safeCharacter.Anchored = arg.SafeRootAnchored
		safeCharacter.AssemblyLinearVelocity = Vector3.zero
		safeCharacter.AssemblyAngularVelocity = Vector3.zero
	end

	arg.SafeCFrame = nil
	arg.SafeCharacter = nil
	arg.SafeRootAnchored = nil
end

v.AutoFarm.MoveToSafeZone = function(arg, arg2)
	if not arg.Config.SafeGateWait then
		arg:ReleaseSafeZone()
		return true
	end

	if not arg.Running or arg.Token ~= arg2 then
		return false, "Auto Farm stopped"
	end
	local safeCFrame = arg:GetSafeCFrame()
	local character = localPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
	if not safeCFrame or not humanoid or not humanoidRootPart or humanoid.Health <= 0 then
		return false, "Safe gate position is unavailable"
	end
	arg:ReleaseSafeZone()
	arg.SafeCharacter = character
	arg.SafeRootAnchored = humanoidRootPart.Anchored
	arg.SafeCFrame = safeCFrame
	if not teleports:Move(safeCFrame, nil, false) then
		arg:ReleaseSafeZone()
		return false, "Could not enter the safe gate position"
	end

	if not arg.Running or arg.Token ~= arg2 or v.Unloaded then
		arg:ReleaseSafeZone()
		return false, "Auto Farm stopped"
	end

	if not arg.Config.SafeGateWait then
		arg:ReleaseSafeZone()
		return true
	end

	if localPlayer.Character ~= character or arg.SafeCharacter ~= character or arg.SafeCFrame ~= safeCFrame then
		arg:ReleaseSafeZone()
		return false, "Character changed while entering the safe zone"
	end
	local humanoidRootPart2 = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart2 then
		arg:ReleaseSafeZone()
		return false, "Character changed while entering the safe zone"
	end
	humanoidRootPart2.CFrame = safeCFrame
	humanoidRootPart2.AssemblyLinearVelocity = Vector3.zero
	humanoidRootPart2.AssemblyAngularVelocity = Vector3.zero
	humanoidRootPart2.Anchored = true
	arg:DisengageHelicopter()
	arg:SetPhase("Safe Gate Wait", "Protected from the helicopter until the gate opens")
	return true
end

v.AutoFarm.MaintainSafeZone = function(arg, arg2)
	if not arg.Config.SafeGateWait then
		arg:ReleaseSafeZone()
		return true
	end
	local character = localPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
	if character ~= arg.SafeCharacter or not arg.SafeCFrame then
		return arg:MoveToSafeZone(arg2)
	end

	if not humanoid or not humanoidRootPart or humanoid.Health <= 0 then
		return false, "Character is unavailable in the safe zone"
	end
	humanoidRootPart.CFrame = arg.SafeCFrame
	humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
	humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
	humanoidRootPart.Anchored = true
	return true
end

v.AutoFarm.WaitForGate = function(arg, arg2, arg3)
	local gateTimeout = v3.RunawaysAutoFarmGateTimeout and v3.RunawaysAutoFarmGateTimeout.Value or arg.Config.GateTimeout
	local n4 = os.clock() + gateTimeout
	arg:SetPhase("Waiting for Gate", "God Mode and NPC clearing are active")

	while true do
		arg.RunHeartbeat = os.clock()

		if arg:GetEndScreen() then
			arg:ReleaseSafeZone()
			local v15, v16 = arg:HandleEndScreen(arg2)
			return false, v16
		else
			local v15, v16 = arg:MaintainSafeZone(arg2)

			if not v15 then
				arg:ReleaseSafeZone()
				local n5 = os.clock() + 4

				while true do
					if arg:GetEndScreen() then
						local v17, v18 = arg:HandleEndScreen(arg2)
						return false, v18
					else
						task.wait(0.1)
						if not arg.Running or arg.Token ~= arg2 or v.Unloaded or os.clock() >= n5 then
							break
						end
					end
				end

				return false, v16
			end

			local gateStartedAt = arg.GateStartedAt
			local n5 = math.max(0, os.time() - gateStartedAt)
			local gateTimer, v17 = arg:GetGateTimer(arg3)

			if v17 then
				arg.GateText = v17
			else
				arg.GateText = arg:FormatDuration(math.max(120 - n5, 0)):sub(4)
			end

			arg:UpdateUI()
			local ok, result = pcall(arg.IsGatePassageOpen, arg, arg.GatePassage)
			local ok2, result2 = pcall(arg.IsGateWindowOpen, arg)
			if ok and result or ok2 and result2 or arg.GateStartedAt > 0 and n5 >= 120 then
				arg:ReleaseSafeZone()
				return true
			end
			local lastPersistAt = arg.LastPersistAt

			if os.clock() - lastPersistAt >= 10 then
				arg:Persist()
			end

			task.wait(0.5)
			if not arg.Running or arg.Token ~= arg2 or v.Unloaded or os.clock() >= n4 then
				break
			end
		end
	end

	if not arg.Running or arg.Token ~= arg2 then
		arg:ReleaseSafeZone()
		return false, "Auto Farm stopped"
	end
	arg:ReleaseSafeZone()
	return false, "Gate wait timed out"
end

v.AutoFarm.SetCrossNoclip = function(arg, arg2)
	if arg2 then
		if arg.CrossCollisions then
			return
		end
		arg.CrossCollisions = {}
		local character = localPlayer.Character

		if character then
			for _, v15 in character:GetDescendants() do
				if v15:IsA("BasePart") then
					arg.CrossCollisions[v15] = v15.CanCollide
					v15.CanCollide = false
				end
			end
		end

		return
	end

	local crossCollisions = arg.CrossCollisions or {}

	for k, v15 in crossCollisions, nil, nil do
		if k.Parent then
			k.CanCollide = v15
		end
	end

	arg.CrossCollisions = nil
end

v.AutoFarm.WaitForFinishResult = function(arg, arg2, arg3)
	local n4 = os.clock() + arg3

	while true do
		if arg.Teleporting then
			return true, "Teleporting"
		else
			if arg:GetEndScreen() then
				arg:SetCrossNoclip(false)
				return arg:HandleEndScreen(arg2)
			end
			task.wait(0.2)
			if not arg.Running or arg.Token ~= arg2 or v.Unloaded or os.clock() >= n4 then
				break
			end
		end
	end

	if not arg.Running or arg.Token ~= arg2 then
		return true, "Stopped"
	end
	return false, "Finish result did not appear"
end

v.AutoFarm.CrossGate = function(arg, arg2, arg3, arg4, arg5)
	arg:ReleaseSafeZone()
	arg:SetPhase("Entering Finish", "Crossing the opened gate")
	arg:SetCrossNoclip(true)
	local character = localPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	character = character and character:FindFirstChild("HumanoidRootPart")
	if not humanoid or not character or humanoid.Health <= 0 then
		arg:SetCrossNoclip(false)
		return false, "Character is unavailable"
	end
	local gatePassage = arg.GatePassage or arg:GetGatePassage(arg3, arg4, arg5)
	if not gatePassage then
		arg:SetCrossNoclip(false)
		return false, "Gate passage is unavailable"
	end
	arg:IsGatePassageOpen(gatePassage)
	teleports:Stream(gatePassage.Position)
	task.wait(0.4)
	local n4 = math.max(12, (tonumber(arg5) and (arg5 - gatePassage.Position.Z) * arg4 or 0) + 12)

	for _, v15 in { -10, -3, 6, n4, n4 + 24, n4 + 50, n4 + 85 }, nil, nil do
		if not arg.Running or arg.Token ~= arg2 or v.Unloaded then
			arg:SetCrossNoclip(false)
			return false, "Auto Farm stopped"
		end
		local n5 = gatePassage.Position + Vector3.new(0, 0, arg4 * v15)
		local v16 = teleports:Move(CFrame.lookAt(n5, n5 + Vector3.new(0, 0, arg4), Vector3.new(0, 1, 0)), nil, false)
		local flag3 = tonumber(arg5) and (n5.Z - arg5) * arg4 >= 0 or v15 >= 6

		if v16 and flag3 and not arg.FinishCrossed then
			arg.FinishCrossed = true
			arg:Persist()
		end

		task.wait(0.4)
		if arg.Teleporting then
			arg:SetCrossNoclip(false)
			return true, "Teleporting"
		end

		if arg:GetEndScreen() then
			arg:SetCrossNoclip(false)
			return arg:HandleEndScreen(arg2)
		end
	end

	humanoid:MoveTo(gatePassage.Position + Vector3.new(0, 0, arg4 * 110))
	local v15, v16 = arg:WaitForFinishResult(arg2, 35)
	if v15 then
		return true, v16
	end
	arg:SetCrossNoclip(false)
	return false, v16
end

v.AutoFarm.RunGame = function(arg, arg2)
	if arg.PendingFinish and arg.LastGameJob ~= "" and arg.LastGameJob ~= game.JobId then
		arg:CompletePending("Replay transition confirmed")
	end

	if arg:GetEndScreen() then
		return arg:HandleEndScreen(arg2)
	end

	if arg.LastGameJob ~= game.JobId then
		arg:ReleaseSafeZone()
		arg.BalanceWarmupUntil = os.clock() + 10
		arg:SyncProgress()
		arg.LastGameJob = game.JobId
		arg.RunStartedAt = os.time()
		arg.RunCashStart = arg:GetEffectiveCredz()
		arg.RunWinsStart = arg:GetEffectiveWins()
		arg.GateStartedAt = 0
		arg.GatePassage = nil
		arg.PendingFinish = false
		arg.FinishCrossed = false
		arg.PendingAt = 0
		arg.ResultBusy = false
		arg.ResultFinalized = false
		arg.ReplayRequested = false
		local stats = arg.Stats
		stats.Attempts = stats.Attempts + 1
		arg:Persist()
		arg:SendWebhook("Run Started", "Gameplay server joined")
	end

	arg:SetPhase("Loading Game", "Waiting for the character and map")
	local n4 = os.clock() + 30

	while true do
		local character = localPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		character = character and character:FindFirstChild("HumanoidRootPart")

		if not (humanoid and character and humanoid.Health > 0 and workspace:FindFirstChild("Map")) then
			task.wait(0.25)
			if not (not arg.Running or arg.Token ~= arg2 or os.clock() >= n4) then
				continue
			end
		end

		break
	end

	if not arg.Running or arg.Token ~= arg2 then
		return true
	end
	local character = localPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	character = character and character:FindFirstChild("HumanoidRootPart")
	if not humanoid or not character or humanoid.Health <= 0 or not workspace:FindFirstChild("Map") then
		return false, "Gameplay did not finish loading"
	end
	local v15, v16, v17, v18, v19 = arg:ReachGate(arg2)
	if not v15 and not v19 then
		return false, v18
	end
	local v20

	if v19 then
		v20 = arg:CaptureGate(v15)
	else
		local v21, v22
		v21, v20, v22 = arg:ActivateGate(v15, v16, arg2)
		if not v21 then
			return false, v22
		end
	end

	local v21, v22 = arg:WaitForGate(arg2, v15, v20)

	if not v21 then
		if v22 == "Replay" or v22 == "Teleporting" or v22 == "Stopped" then
			return true, v22
		end
		return false, v22
	end

	arg.PendingFinish = true
	arg.FinishCrossed = true
	arg.PendingAt = os.time()
	arg:Persist()
	local v23 = arg:IsAutoReplayEnabled()
	local v24, v25 = arg:QueueTeleport(v23 and "replay" or "lobby", v23 and arg.GamePlaceId or arg.LobbyPlaceId)

	if not v24 then
		arg.PendingFinish = false
		arg.FinishCrossed = false
		arg.PendingAt = 0
		return false, v25
	end

	for i = 1, 3 do
		local v26, v27 = arg:CrossGate(arg2, v15, v16, v17)
		if v26 then
			return true, v27
		end

		if not arg.Running or arg.Token ~= arg2 then
			return true
		end
		local stats = arg.Stats
		stats.Retries = stats.Retries + 1
		arg.LastError = v27
		task.wait(i * 2)
	end

	arg.PendingFinish = false
	arg.FinishCrossed = false
	arg.PendingAt = 0
	arg:ReleaseSafeZone()
	return false, "Could not enter the finish"
end

v.AutoFarm.ReleaseRun = function(arg, arg2)
	if arg.ActiveRunToken ~= arg2 then
		return
	end
	arg.RunActive = false
	arg.ActiveRunToken = nil

	if arg.Running and arg.Token and arg.Token ~= arg2 and not v.Unloaded then
		task.spawn(arg.Run, arg, arg.Token)
	end
end

v.AutoFarm.Run = function(arg, activeRunToken)
	if arg.RunActive then
		return
	end
	arg.RunActive = true
	arg.ActiveRunToken = activeRunToken
	arg.RunHeartbeat = os.clock()
	local n4 = 0

	while arg.Running and arg.Token == activeRunToken and not v.Unloaded do
		arg.RunHeartbeat = os.clock()
		if arg.TeleportRecovering then
			task.wait(0.25)
			continue
		end

		local ok, result, result2 = xpcall(function()
			local context = arg:GetContext()
			if context == "Lobby" then
				return arg:RunLobby(activeRunToken)
			end

			if context == "Game" then
				return arg:RunGame(activeRunToken)
			end
			return false, "Unsupported place: " .. tostring(game.PlaceId)
		end, function(arg2)
			if type(debug) == "table" and type(debug.traceback) == "function" then
				local ok, result = pcall(debug.traceback, tostring(arg2), 2)
				if ok and type(result) == "string" then
					return result
				end
			end

			return tostring(arg2)
		end)

		local flag3

		if not ok then
			arg:ReleaseSafeZone()
			arg:SetCrossNoclip(false)
			arg.ResultBusy = false
			arg.ReplayRequested = false
			flag3 = false
		else
			flag3 = result
			result = result2
		end

		if arg.TeleportRecovering then
			task.wait(0.25)
			n4 = 0
			continue
		end

		if flag3 and result == "Replay" and not arg.Teleporting and arg.Running and arg.Token == activeRunToken then
			task.wait(1)
			n4 = 0
			continue
		end

		flag3 = flag3 or arg.Teleporting or not arg.Running or arg.Token ~= activeRunToken
		if flag3 then
			arg:ReleaseRun(activeRunToken)
			return
		end
		n4 += 1
		local stats = arg.Stats
		stats.Retries = stats.Retries + 1
		arg.LastError = tostring(result or "Unknown error")
		arg:SetPhase("Retrying", arg.LastError)
		arg:Persist()
		arg:SendWebhook("Error", arg.LastError)
		local retryDelay = v3.RunawaysAutoFarmRetryDelay and v3.RunawaysAutoFarmRetryDelay.Value or arg.Config.RetryDelay
		local n5 = os.clock() + math.min(retryDelay * n4, 30)

		while true do
			arg.RunHeartbeat = os.clock()
			task.wait(0.25)
			if not (not arg.Running or arg.Token ~= activeRunToken or os.clock() >= n5) then
				continue
			end
			break
		end
	end

	arg:ReleaseRun(activeRunToken)
end

v.AutoFarm.Start = function(arg)
	if arg.Running then
		return
	end
	local flag3 = not arg.ResumeRequested

	if flag3 then
		arg.SessionId = tostring(localPlayer.UserId) .. "-" .. tostring(os.time()) .. "-" .. tostring(math.random(100000, 999999))
		arg:ResetStats()
	elseif arg.StartedAt <= 0 then
		arg.StartedAt = os.time()
	end

	arg.ResumeRequested = false
	arg.Running = true
	arg.RunActive = false
	arg.ActiveRunToken = nil
	arg.Teleporting = false
	arg.TeleportRecoveryGeneration = arg.TeleportRecoveryGeneration + 1
	arg.TeleportRetryCount = 0
	arg.TeleportRetryDelay = 0
	arg.TeleportRetryTarget = 0
	arg.TeleportRetryOptions = nil
	arg.TeleportRecovering = false
	arg.LastTeleportFailureAt = 0
	arg.QueueJob = nil
	arg.ResultBusy = false
	arg.ResultFinalized = false
	arg.ReplayRequested = false
	arg.RunHeartbeat = os.clock()
	arg.TransitionToken = ""
	arg.ExpectedPlaceId = 0
	arg.TransitionAt = 0
	arg.Token = {}
	arg.QueueStatus = "Not armed"
	arg:Persist()
	arg:SetPhase("Starting", "Preparing Auto Farm")
	local context = arg:GetContext()
	local teleportQueueError = arg:GetTeleportQueueError(context == "Lobby" and arg.GamePlaceId or context == "Game" and (arg:IsAutoReplayEnabled() and arg.GamePlaceId or arg.LobbyPlaceId))

	if teleportQueueError then
		arg.Running = false
		arg.Token = nil
		arg.QueueStatus = teleportQueueError
		arg.LastError = tostring(teleportQueueError)
		arg:SetPhase("Start Failed", arg.LastError)
		arg:Persist()
		fn("Auto Farm: " .. teleportQueueError .. ".")

		task.defer(function()
			if v2.RunawaysAutoFarm and v2.RunawaysAutoFarm.Value then
				v2.RunawaysAutoFarm:SetValue(false)
			end
		end)

		return
	end

	if flag3 then
		arg:SendWebhook("Session Started", "Auto Farm enabled")
	end

	task.spawn(function()
		local token = arg.Token

		while arg.Running and arg.Token == token and not v.Unloaded do
			local context2 = arg:GetContext()

			if context2 == "Game" then
				local v15 = fn9()

				if v15 then
					fn32(v15)
				end

				local stats = arg.Stats
				stats.NPCAttacks = stats.NPCAttacks + fn8()
			end

			task.wait(context2 == "Game" and 0.4 or 1)
		end
	end)

	task.spawn(function()
		local token = arg.Token

		while arg.Running and arg.Token == token and not v.Unloaded do
			local context2 = arg:GetContext()

			if context2 == "Game" and not arg.ResultBusy and not arg.RunActive then
				if arg:GetEndScreen() then
					arg:ReleaseSafeZone()
					arg:SetCrossNoclip(false)
					arg.RunActive = false
					arg.ActiveRunToken = nil
					arg.RunHeartbeat = os.clock()
					arg:SetPhase("Recovering", "Handling the result screen")
					task.spawn(arg.Run, arg, token)
				end
			end

			task.wait(context2 == "Game" and 0.5 or 1)
		end
	end)

	task.spawn(arg.Run, arg, arg.Token)
end

v.AutoFarm.Stop = function(arg, arg2)
	if not arg.Running and not arg.ResumeRequested then
		return
	end
	local flag3 = not arg2

	if flag3 then
		arg:SendWebhook("Stopped", "Auto Farm disabled")
	end

	arg.Running = false
	arg.ResumeRequested = false
	arg.Token = nil
	arg.RunActive = false
	arg.ActiveRunToken = nil
	arg.Teleporting = false
	arg.TeleportRecoveryGeneration = arg.TeleportRecoveryGeneration + 1
	arg.TeleportRetryCount = 0
	arg.TeleportRetryDelay = 0
	arg.TeleportRetryTarget = 0
	arg.TeleportRetryOptions = nil
	arg.TeleportRecovering = false
	arg.LastTeleportFailureAt = 0
	arg.QueueJob = nil
	arg.TransitionToken = ""
	arg.ExpectedPlaceId = 0
	arg.TransitionAt = 0
	arg.PendingFinish = false
	arg.FinishCrossed = false
	arg.PendingAt = 0
	arg.ResultBusy = false
	arg.ResultFinalized = false
	arg.ReplayRequested = false
	arg.RunHeartbeat = 0
	arg.LastGameJob = ""
	arg.RunStartedAt = 0
	arg.RunCashStart = 0
	arg.RunWinsStart = 0
	arg.GateStartedAt = 0
	arg.GatePassage = nil
	arg.GateText = "--"
	arg.QueueStatus = "Disabled"
	arg:ReleaseSafeZone()
	arg:SetCrossNoclip(false)
	arg:DismissTeleportError()

	if not v2.RunawaysPlayerGodMode or not v2.RunawaysPlayerGodMode.Value then
		fn31()
	end

	pcall(function()
		game:GetService("TeleportService"):SetTeleportSetting(arg.EnabledKey, false)
		game:GetService("TeleportService"):SetTeleportSetting(arg.TransitionKey, "")
	end)

	arg:SetPhase("Stopped", "Auto Farm is disabled")
	arg:Persist()

	if flag3 then
		fn("Auto Farm stopped.")
	end
end

v.AutoFarm.Destroy = function(arg, arg2)
	arg.Running = false
	arg.ResumeRequested = false
	arg.Token = nil
	arg.RunActive = false
	arg.ActiveRunToken = nil
	arg.Teleporting = false
	arg.TeleportRecoveryGeneration = arg.TeleportRecoveryGeneration + 1
	arg.TeleportRetryCount = 0
	arg.TeleportRetryDelay = 0
	arg.TeleportRetryTarget = 0
	arg.TeleportRetryOptions = nil
	arg.TeleportRecovering = false
	arg.LastTeleportFailureAt = 0
	arg.ResultBusy = false
	arg.ResultFinalized = false
	arg.ReplayRequested = false
	arg.WebhookGeneration = arg.WebhookGeneration + 1
	arg:ReleaseSafeZone()
	arg:SetCrossNoclip(false)
	arg:DismissTeleportError()

	if arg.TeleportConnection then
		arg.TeleportConnection:Disconnect()
		arg.TeleportConnection = nil
	end

	if arg.TeleportFailedConnection then
		arg.TeleportFailedConnection:Disconnect()
		arg.TeleportFailedConnection = nil
	end

	if not v2.RunawaysPlayerGodMode or not v2.RunawaysPlayerGodMode.Value then
		fn31()
	end

	if not arg2 then
		arg.TransitionToken = ""
		arg.ExpectedPlaceId = 0
		arg.TransitionAt = 0
		genv.RunawaysAutoFarmTransitionToken = nil

		pcall(function()
			game:GetService("TeleportService"):SetTeleportSetting(arg.EnabledKey, false)
			game:GetService("TeleportService"):SetTeleportSetting(arg.TransitionKey, "")
		end)

		arg.PendingFinish = false
		arg.FinishCrossed = false
		arg.PendingAt = 0
		arg.LastGameJob = ""
		arg.RunStartedAt = 0
		arg.RunCashStart = 0
		arg.RunWinsStart = 0
		arg.GateStartedAt = 0
		arg.GatePassage = nil
		arg.GateText = "--"
		arg:Persist()
	end
end

local v15 = v:CreateWindow({
	Title = "RUNAWAYS",
	Footer = "RUNAWAYS | " .. str,
	Size = UDim2.fromOffset(v.IsMobile and 560 or 640, v.IsMobile and 360 or 520),
	NotifySide = "Right",
	ShowCustomCursor = not v.IsMobile,
	ShowMobileButtons = true,
	MobileButtonsSide = "Left",
	EnableCompacting = true,
})

local tbl20 = {
	Main = v15:AddTab("Main", "package", ""),
	Player = v15:AddTab("Player", "user", ""),
	Teleports = v15:AddTab("Teleports", "map-pin", ""),
	Car = v15:AddTab("Car Modify", "car-front", ""),
	Weapon = v15:AddTab("Weapon", "crosshair", ""),
	ESP = v15:AddTab("ESP", "eye", ""),
	AutoFarm = v15:AddTab("Auto Farm", "bot", ""),
	Settings = v15:AddTab("Settings", "settings", ""),
}

if v.LobbyShop:IsLobby() then
	v.LobbyShop.Box = tbl20.Main:AddLeftGroupbox("Lobby Shop", "store")
end

local Loot = tbl20.Main:AddLeftGroupbox("Loot", "package-open")
local Money = tbl20.Main:AddLeftGroupbox("Money", "badge-dollar-sign")
tbl20.RemoteShopBox = tbl20.Main:AddLeftGroupbox("Remote Shop", "shopping-cart")
local NPCs = v.IsMobile and tbl20.Main:AddLeftGroupbox("NPCs", "users") or tbl20.Main:AddRightGroupbox("NPCs", "users")
tbl6.Box = v.IsMobile and tbl20.Main:AddLeftGroupbox("Bring Items", "package-plus") or tbl20.Main:AddRightGroupbox("Bring Items", "package-plus")
local Utility = v.IsMobile and tbl20.Main:AddLeftGroupbox("Utility", "wrench") or tbl20.Main:AddRightGroupbox("Utility", "wrench")
local Movement = tbl20.Player:AddLeftGroupbox("Movement", "gauge")
tbl11.Box = v.IsMobile and tbl20.Player:AddLeftGroupbox("Melee Mods", "hand") or tbl20.Player:AddRightGroupbox("Melee Mods", "hand")
teleports.LocationBox = tbl20.Teleports:AddLeftGroupbox("Locations", "map-pin")
teleports.EntityBox = v.IsMobile and tbl20.Teleports:AddLeftGroupbox("Entities", "users") or tbl20.Teleports:AddRightGroupbox("Entities", "users")
local Performance = tbl20.Car:AddLeftGroupbox("Performance", "gauge")
local isMobile = v.IsMobile and tbl20.Car:AddLeftGroupbox("Vehicle Utility", "wrench") or tbl20.Car:AddRightGroupbox("Vehicle Utility", "wrench")
local v16 = tbl20.Weapon:AddLeftGroupbox("Weapon Mods", "crosshair")
v.AutoFarm.ControlBox = tbl20.AutoFarm:AddLeftGroupbox("Automation", "bot")
local v17 = tbl20.ESP:AddLeftTabbox()
local isMobile2 = v.IsMobile and v17 or tbl20.ESP:AddRightTabbox()
local Style = v17:AddTab("Style")
local Items = isMobile2:AddTab("Items")
local Players2 = isMobile2:AddTab("Players")
local NPCs2 = isMobile2:AddTab("NPCs")
local World = isMobile2:AddTab("World")
local Menu = tbl20.Settings:AddLeftGroupbox("Menu", "wrench")

v.AutoFarm.ControlBox:AddToggle("RunawaysAutoFarm", {
	Text = "Auto Farm",
	Default = false,
	Callback = function(arg)
		if arg then
			v.AutoFarm:Start()
		else
			v.AutoFarm:Stop()
		end
	end,
})

v.AutoFarm.ControlBox:AddToggle("RunawaysAutoFarmSafeGateWait", {
	Text = "Safe Gate Wait",
	Default = true,
	Callback = function(safeGateWait)
		v.AutoFarm.Config.SafeGateWait = safeGateWait

		if not safeGateWait then
			v.AutoFarm:ReleaseSafeZone()
		end

		if v.AutoFarm.StateReady then
			v.AutoFarm:Persist()
		end
	end,
})

v.AutoFarm.ControlBox:AddToggle("RunawaysAutoFarmAutoReplay", {
	Text = "Auto Replay",
	Default = true,
	Callback = function(autoReplay)
		v.AutoFarm.Config.AutoReplay = autoReplay

		if v.AutoFarm.StateReady then
			v.AutoFarm:Persist()
		end
	end,
})

v.AutoFarm.ControlBox:AddSlider("RunawaysAutoFarmLobbyDelay", {
	Text = "Delay Between Runs",
	Default = 3,
	Min = 0,
	Max = 30,
	Rounding = 0,
	Suffix = " seconds",
	Callback = function(lobbyDelay)
		v.AutoFarm.Config.LobbyDelay = lobbyDelay

		if v.AutoFarm.StateReady then
			v.AutoFarm:Persist()
		end
	end,
})

v.AutoFarm.ControlBox:AddSlider("RunawaysAutoFarmGateTimeout", {
	Text = "Gate Timeout",
	Default = 165,
	Min = 125,
	Max = 240,
	Rounding = 0,
	Suffix = " seconds",
	Callback = function(gateTimeout)
		v.AutoFarm.Config.GateTimeout = gateTimeout

		if v.AutoFarm.StateReady then
			v.AutoFarm:Persist()
		end
	end,
})

v.AutoFarm.ControlBox:AddSlider("RunawaysAutoFarmRetryDelay", {
	Text = "Retry Delay",
	Default = 10,
	Min = 3,
	Max = 30,
	Rounding = 0,
	Suffix = " seconds",
	Callback = function(retryDelay)
		v.AutoFarm.Config.RetryDelay = retryDelay

		if v.AutoFarm.StateReady then
			v.AutoFarm:Persist()
		end
	end,
})

v.AutoFarm.TeleportConnection = localPlayer.OnTeleport:Connect(function(arg)
	if not v.AutoFarm.Running then
		return
	end

	if arg == Enum.TeleportState.Started or arg == Enum.TeleportState.InProgress then
		if not v.AutoFarm.Teleporting then
			local stats = v.AutoFarm.Stats
			stats.Teleports = stats.Teleports + 1
		end

		v.AutoFarm.Teleporting = true
		v.AutoFarm:SetPhase("Teleporting", "Moving to the next server")
		v.AutoFarm:Persist()
	end
end)

v.AutoFarm.TeleportFailedConnection = game:GetService("TeleportService").TeleportInitFailed:Connect(function(arg, arg2, arg3, arg4, arg5)
	if arg ~= localPlayer then
		return
	end
	v.AutoFarm:HandleTeleportFailure(arg2, arg3, arg4, arg5)
end)

teleports.LocationBox:AddLabel("Route")

teleports.LocationBox:AddButton("Teleport to End Gate", function()
	teleports:ToEnd()
end)

teleports.LocationBox:AddButton("Teleport to Start", function()
	teleports:ToStart()
end)

teleports.LocationBox:AddButton("Teleport to Objective", function()
	teleports:ToObjective()
end)

teleports.LocationBox:AddDivider()

teleports.LocationBox:AddDropdown("RunawaysTeleportBuilding", {
	Values = { "None" },
	Default = 1,
	Multi = false,
	Text = "Building",
	Searchable = true,
	MaxVisibleDropdownItems = 12,
})

teleports.LocationBox:AddButton("Teleport to Building", function()
	teleports:Go("Buildings")
end)

teleports.LocationBox:AddDivider()

teleports.LocationBox:AddButton("Save Current Position", function()
	teleports:SavePosition()
end)

teleports.LocationBox:AddButton("Teleport to Saved Position", function()
	teleports:ToSaved()
end)

teleports.LocationBox:AddButton("Return to Previous Position", function()
	teleports:ToLast()
end)

teleports.EntityBox:AddDropdown("RunawaysTeleportNPC", {
	Values = { "None" },
	Default = 1,
	Multi = false,
	Text = "NPC",
	Searchable = true,
	MaxVisibleDropdownItems = 12,
})

teleports.EntityBox:AddButton("Teleport to NPC", function()
	teleports:Go("NPCs")
end)

teleports.EntityBox:AddDropdown("RunawaysTeleportVehicle", {
	Values = { "None" },
	Default = 1,
	Multi = false,
	Text = "Vehicle",
	Searchable = true,
	MaxVisibleDropdownItems = 12,
})

teleports.EntityBox:AddButton("Teleport to Vehicle", function()
	teleports:Go("Vehicles")
end)

teleports.EntityBox:AddDropdown("RunawaysTeleportPlayer", {
	Values = { "None" },
	Default = 1,
	Multi = false,
	Text = "Player",
	Searchable = true,
	MaxVisibleDropdownItems = 12,
})

teleports.EntityBox:AddButton("Teleport to Player", function()
	teleports:Go("Players")
end)

NPCs:AddSlider("RunawaysRageNPCRadius", { Text = "Aura Radius", Default = 150, Min = 10, Max = 1000, Rounding = 0, Suffix = " studs" })

NPCs:AddToggle("RunawaysRageNPCKillAura", {
	Text = "NPC Kill Aura",
	Default = false,
	Callback = function(arg)
		v.Rage.KillAuraLoop = arg and {} or nil
		local killAuraLoop = v.Rage.KillAuraLoop
		if not killAuraLoop then
			return
		end

		task.spawn(function()
			while v.Rage.KillAuraLoop == killAuraLoop and not v.Unloaded do
				fn8(v3.RunawaysRageNPCRadius.Value)
				task.wait(0.15)
			end
		end)
	end,
})

NPCs:AddButton("Aggro Nearby NPCs", function()
	local v18 = v.Rage:AggroNPCs(v3.RunawaysRageNPCRadius.Value)
	fn(string.format("Aggro requests: %d.", v18), 4)
end)

Money:AddSlider("RunawaysRageWorldRadius", { Text = "Break Radius", Default = 100, Min = 10, Max = 1000, Rounding = 0, Suffix = " studs" })

Money:AddButton("Break Nearby Cash Sources", function()
	local v18 = v.Rage:BreakNearbySources(v3.RunawaysRageWorldRadius.Value)
	fn(string.format("Break requests: %d.", v18), 4)
end)

if v.LobbyShop.Box then
	v.LobbyShop.Box:AddLabel("Credz purchases only")

	v.LobbyShop.Box:AddDropdown("RunawaysLobbyShopCategory", {
		Values = { "Classes", "Weapons", "Vehicles" },
		Default = 1,
		Multi = false,
		Text = "Category",
		Callback = function()
			v.LobbyShop:Refresh(true)
		end,
	})

	v.LobbyShop.Box:AddDropdown("RunawaysLobbyShopItem", {
		Values = { "None" },
		Default = 1,
		Multi = false,
		Text = "Item",
		Searchable = true,
		MaxVisibleDropdownItems = 12,
	})

	v.LobbyShop.Box:AddButton("Buy Selected Item", function()
		v.LobbyShop:Buy()
	end)
end

tbl20.RemoteShopBox:AddLabel("Server prices apply")

tbl20.RemoteShopBox:AddDropdown("RunawaysRemoteShopItem", {
	Values = { "None" },
	Default = 1,
	Multi = false,
	Text = "Item",
	Searchable = true,
	MaxVisibleDropdownItems = 12,
})

tbl20.RemoteShopBox:AddButton("Buy Selected Item", function()
	tbl19:Buy()
end)

Loot:AddDropdown("LootItems", {
	Values = tbl6.Names,
	Default = {},
	Multi = true,
	Text = "Items",
	Searchable = true,
	MaxVisibleDropdownItems = 12,
	FormatDisplayValue = fn4,
	FormatListValue = fn4,
})

tbl6.Box:AddDropdown("RunawaysBringItems", {
	Values = tbl6.Names,
	Default = {},
	Multi = true,
	Text = "Items",
	Searchable = true,
	MaxVisibleDropdownItems = 12,
	FormatDisplayValue = fn4,
	FormatListValue = fn4,
})

tbl6.Box:AddDropdown("RunawaysBringCategories", {
	Values = tbl2,
	Default = {},
	Multi = true,
	Text = "Categories",
	Searchable = true,
	MaxVisibleDropdownItems = 12,
	FormatDisplayValue = fn4,
	FormatListValue = fn4,
})

tbl6.Box:AddButton("Bring Selected", function()
	tbl6:Start(false)
end)

tbl6.Box:AddButton("Bring All", function()
	tbl6:Start(true)
end)

tbl6.Box:AddButton("Stop Bring", function()
	tbl6:Stop()
end)

tbl6.UpdateOption = function(arg, arg2, arg3, arg4)
	local v18 = v3[arg2]
	if not v18 then
		return
	end
	local str3 = table.concat(arg3, "\0")
	local v19 = table.clone(v18.Value)
	local tbl21 = {}

	for _, v20 in arg3, nil, nil do
		if v19[v20] then
			tbl21[v20] = true
		end
	end

	local flag3 = false

	for k in v19, nil, nil do
		if not tbl21[k] then
			flag3 = true
			break
		end
	end

	if arg4 or arg.Signatures[arg2] ~= str3 then
		v18:SetValues(arg3)
		v18:SetValue(tbl21)
		arg.Signatures[arg2] = str3
	elseif flag3 then
		v18:SetValue(tbl21)
	end
end

tbl6.Refresh = function(arg, arg2)
	local v18, v19 = fn3()
	arg.Names = v19
	arg:UpdateOption("LootItems", v19, arg2)
	arg:UpdateOption("RunawaysBringItems", v19, arg2)
	arg:UpdateOption("RunawaysBringCategories", tbl2, arg2)
end

tbl6.Restore = function(arg, arg2)
	local context = arg2 or arg.Context
	if not context then
		return
	end
	local ownedPart = context.OwnedPart

	if ownedPart and ownedPart.Parent then
		pcall(FlowClient.Loot.OwnNetworkRequest, ownedPart, nil)
		context.OwnedPart = nil
	end

	local character = context.Character
	local root = context.Root

	if localPlayer.Character == character and character and character.Parent and root and root.Parent == character then
		pcall(function()
			character:PivotTo(context.StartPivot)
			root.AssemblyLinearVelocity = Vector3.zero
			root.AssemblyAngularVelocity = Vector3.zero
		end)
	end

	local currentCamera = workspace.CurrentCamera or context.Camera

	if currentCamera and currentCamera.Parent then
		local cameraSubject = context.CameraSubject

		if localPlayer.Character ~= character or not cameraSubject or not cameraSubject.Parent then
			local character2 = localPlayer.Character

			if character2 then
				cameraSubject = character2:FindFirstChildOfClass("Humanoid") or character2:FindFirstChild("HumanoidRootPart")
			else
				cameraSubject = character2
			end
		end

		if cameraSubject then
			pcall(function()
				currentCamera.CameraSubject = cameraSubject
			end)
		end

		pcall(function()
			currentCamera.CameraType = context.CameraType
		end)

		pcall(function()
			currentCamera.CFrame = context.CameraCFrame
		end)
	end
end

tbl6.Stop = function(arg, arg2)
	if not arg.Running then
		if not arg2 then
			fn("Bring is not running.")
		end

		return
	end

	local context = arg.Context
	arg.Token = nil
	arg.Running = false
	flag = false

	if context then
		arg:Restore(context)

		if arg.Context == context then
			arg.Context = nil
		end
	end

	if not arg2 then
		fn("Bring stopped.", 3)
	end
end

tbl6.Start = function(arg, arg2)
	if arg.Running then
		fn("Bring is already running.", 3)
		return
	end

	if flag then
		fn("Another inventory action is running.", 3)
		return
	end
	local v18 = table.clone(v3.RunawaysBringItems.Value)
	local v19 = table.clone(v3.RunawaysBringCategories.Value)
	if not arg2 and not next(v18) and not next(v19) then
		fn("Select items or categories first.")
		return
	end
	local token = {}
	arg.Token = token
	arg.Running = true
	arg.Context = nil
	flag = true

	task.spawn(function()
		local n4 = 0
		local n5 = 0
		local n6 = 0
		local flag3 = false
		local character = nil
		local humanoidRootPart = nil
		local pivot = nil
		local cFrame = nil
		local currentCamera = nil
		local cFrame2 = nil
		local cameraSubject = nil
		local cameraType = nil
		local context = nil
		local v20, ok, result

		ok, result = pcall(function()
			character = localPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

			if not character or not humanoid or not humanoidRootPart or humanoid.Health <= 0 then
				error("Character is not ready.", 0)
			end

			if humanoid.SeatPart then
				error("Exit the vehicle first.", 0)
			end

			pivot = character:GetPivot()
			cFrame = humanoidRootPart.CFrame
			currentCamera = workspace.CurrentCamera
			cFrame2 = currentCamera and currentCamera.CFrame
			cameraSubject = currentCamera and currentCamera.CameraSubject
			cameraType = currentCamera and currentCamera.CameraType
			if arg.Token ~= token or v.Unloaded then
				flag3 = true
				return
			end

			context = {
				Character = character,
				Root = humanoidRootPart,
				StartPivot = pivot,
				Camera = currentCamera,
				CameraCFrame = cFrame2,
				CameraSubject = cameraSubject,
				CameraType = cameraType,
			}

			arg.Context = context

			if currentCamera then
				currentCamera.CameraType = Enum.CameraType.Scriptable
				currentCamera.CFrame = cFrame2
			end

			for _, v21 in fn3(), nil, nil do
				if arg.Token ~= token or v.Unloaded then
					flag3 = true
					break
				else
					local v22 = fn5(v21)
					local flag4 = not arg2 and not v18[v21.Name]

					if flag4 then
						flag4 = not (v22 and v19[v22])
					end

					if not flag4 then
						if fn2(v21) then
							n4 += 1
							local primaryPart = v21.PrimaryPart
							local v23 = fn7(humanoidRootPart, primaryPart)
							character:PivotTo(v23)
							humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
							humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
							task.wait(0.22)

							if arg.Token ~= token or v.Unloaded then
								flag3 = true
								break
							elseif not fn2(v21) then
								n6 += 1

								if character.Parent and humanoidRootPart.Parent == character then
									character:PivotTo(pivot)
									humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
									humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
								end

								task.wait(0.06)
							else
								if v21:HasTag("Attachable") and type(FlowClient.Loot.WeldDetach) == "function" then
									pcall(FlowClient.Loot.WeldDetach, primaryPart)
									local attachableWeld = primaryPart:FindFirstChild("AttachableWeld")

									if attachableWeld then
										attachableWeld:Destroy()
									end

									task.wait(0.05)
								end

								if arg.Token ~= token or v.Unloaded then
									flag3 = true
									break
								else
									v20 = primaryPart
									context.OwnedPart = primaryPart
									local ok2, result2 = pcall(FlowClient.Loot.OwnNetworkRequestAsync, primaryPart, true)

									if not ok2 then
										local attachableWeld = primaryPart:FindFirstChild("AttachableWeld")

										if attachableWeld then
											attachableWeld:Destroy()
										end

										ok2, result2 = pcall(FlowClient.Loot.OwnNetworkRequestAsync, primaryPart, true)
									end

									result2 = ok2 and result2
									local flag5 = false

									if result2 then
										local n7 = os.clock() + 0.75

										while true do
											RunService.Heartbeat:Wait()
											flag5 = primaryPart.Parent == v21 and not primaryPart.Anchored

											if flag5 and type(isnetworkowner) == "function" then
												local ok3
												ok3, flag5 = pcall(isnetworkowner, primaryPart)
												flag5 = ok3 and flag5
											end

											if not (flag5 or arg.Token ~= token or v.Unloaded or os.clock() >= n7) then
												continue
											end
											break
										end
									end

									if arg.Token ~= token or v.Unloaded or arg.Context ~= context then
										flag3 = true
										local context2 = arg.Context

										if not (context2 and context2 ~= context and context2.OwnedPart == primaryPart) then
											pcall(FlowClient.Loot.OwnNetworkRequest, primaryPart, nil)
										end

										v20 = nil
										context.OwnedPart = nil
										break
									else
										if flag5 and arg.Token == token and not v.Unloaded and fn2(v21) then
											local rotation = primaryPart.CFrame.Rotation
											local cFrame3 = primaryPart.CFrame
											v21:PivotTo(CFrame.new((cFrame * CFrame.new(((n4 - 1) % 4 - 1.5) * 4, 2, -7 - math.floor((n4 - 1) / 4) * 4)).Position) * rotation * cFrame3:Inverse() * v21:GetPivot())
											primaryPart.AssemblyLinearVelocity = Vector3.zero
											primaryPart.AssemblyAngularVelocity = Vector3.zero
											n5 += 1
										else
											n6 += 1
										end

										if character.Parent and humanoidRootPart.Parent == character then
											character:PivotTo(pivot)
											humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
											humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
										end

										RunService.Heartbeat:Wait()
										RunService.Heartbeat:Wait()
										pcall(FlowClient.Loot.OwnNetworkRequest, primaryPart, nil)
										v20 = nil
										context.OwnedPart = nil
										task.wait(0.06)
									end
								end
							end
						end
					end
				end
			end
		end)

		if arg.Context == context then
			arg:Restore(context)
			arg.Context = nil
		elseif v20 and v20.Parent then
			local context2 = arg.Context

			if not (context2 and context2 ~= context and context2.OwnedPart == v20) then
				pcall(FlowClient.Loot.OwnNetworkRequest, v20, nil)
			end
		end

		if arg.Token ~= token then
			return
		end
		arg.Token = nil
		arg.Running = false
		flag = false
		if v.Unloaded then
			return
		end
		arg:Refresh()

		if not ok then
			fn("Bring failed: " .. tostring(result), 6)
		elseif flag3 then
			fn(string.format("Bring stopped. Brought: %d.", n5))
		elseif n4 == 0 then
			fn("Nothing to bring.")
		elseif n6 == 0 then
			fn(string.format("Brought: %d.", n5))
		else
			fn(string.format("Brought: %d, failed: %d.", n5, n6), 6)
		end
	end)
end

tbl6.GetCashAmount = function()
	local leaderstats = localPlayer:FindFirstChild("leaderstats")
	leaderstats = leaderstats and leaderstats:FindFirstChild("Cash 💵")
	if leaderstats and (leaderstats:IsA("NumberValue") or leaderstats:IsA("IntValue")) then
		return leaderstats.Value
	end
	local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
	playerGui = playerGui and playerGui:FindFirstChild("HudGui")
	playerGui = playerGui and playerGui:FindFirstChild("BottomPanel")
	playerGui = playerGui and playerGui:FindFirstChild("CashAmount")
	playerGui = playerGui and playerGui:FindFirstChild("CashAmount")
	playerGui = playerGui and playerGui.Text:gsub("[^%d]", "")
	return playerGui and tonumber(playerGui)
end

tbl6.IsCashSource = function(arg, arg2)
	return arg2:IsA("Model") and arg2:IsDescendantOf(workspace) and arg2:HasTag("DamageToOpen") and arg2:FindFirstChild("Health") ~= nil and arg2:FindFirstChild("CashFx", true) ~= nil
end

tbl6.GetCashDrops = function(arg, arg2)
	local tbl21 = {}
	local character = localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	local position = character and character.Position or Vector3.zero

	for _, v18 in CollectionService:GetTagged("Cash") do
		local parent = v18.Parent
		local touchSensor = parent and parent:FindFirstChild("TouchSensor", true)

		if v18:IsDescendantOf(workspace) and parent and parent:IsA("Model") and not parent:HasTag("ForbiddenLoot") and touchSensor and touchSensor:IsA("BasePart") then
			tbl21[#tbl21 + 1] = v18
		end
	end

	if arg2 ~= false then
		table.sort(tbl21, function(arg3, arg4)
			local parent = arg3.Parent
			local parent2 = arg4.Parent
			parent = parent and parent:FindFirstChild("TouchSensor", true)
			parent2 = parent2 and parent2:FindFirstChild("TouchSensor", true)
			if not parent or not parent2 then
				return arg3.Name < arg4.Name
			end
			return (parent.Position - position).Magnitude < (parent2.Position - position).Magnitude
		end)
	end

	return tbl21
end

tbl6.CollectCashDrop = function(arg, arg2, arg3, arg4)
	if arg.CashToken ~= arg2 or arg.CashContext ~= arg3 or v.Unloaded then
		return false
	end
	local parent = arg4 and arg4.Parent
	parent = parent and parent:FindFirstChild("TouchSensor", true)
	local character = arg3.Character
	local root = arg3.Root
	if not parent or not parent:IsA("BasePart") or not arg4:IsDescendantOf(workspace) then
		return false
	end

	if localPlayer.Character ~= character or not character.Parent or root.Parent ~= character then
		return false
	end
	local n4 = arg3.StartPivot.Position - parent.Position
	local vector = Vector3.new(n4.X, 0, n4.Z)
	local n5 = parent.Position + (vector.Magnitude > 0.05 and vector.Unit or Vector3.new(1, 0, 0)) * 6 + Vector3.new(0, 1, 0) * 2.5

	if arg3.Camera and arg3.Camera.Parent then
		arg3.Camera.CameraType = Enum.CameraType.Scriptable
		arg3.Camera.CFrame = arg3.CameraCFrame
	end

	character:PivotTo(CFrame.lookAt(n5, Vector3.new(parent.Position.X, n5.Y, parent.Position.Z)))
	root.AssemblyLinearVelocity = Vector3.zero
	root.AssemblyAngularVelocity = Vector3.zero
	task.wait(0.8)
	if arg.CashToken ~= arg2 or arg.CashContext ~= arg3 or v.Unloaded then
		return false
	end
	local cashAmount = arg:GetCashAmount()
	local ok = pcall(FlowClient.Cash.Collect, arg4)
	local n6 = os.clock() + 0.8

	repeat
		task.wait(0.05)
		local cashAmount2 = arg:GetCashAmount()
		if not arg4:IsDescendantOf(workspace) or cashAmount and cashAmount2 and cashAmount2 > cashAmount then
			return ok
		end
	until arg.CashToken ~= arg2 or arg.CashContext ~= arg3 or v.Unloaded or os.clock() >= n6

	return ok and not arg4:IsDescendantOf(workspace)
end

tbl6.StopCash = function(arg, arg2)
	if not arg.CashRunning and not arg.CashContext then
		if not arg2 then
			fn("Cash run is not running.")
		end

		return
	end

	local cashContext = arg.CashContext
	arg.CashToken = nil
	arg.CashRunning = false
	flag = false

	if cashContext then
		arg:Restore(cashContext)

		if arg.CashContext == cashContext then
			arg.CashContext = nil
		end
	end

	if not arg2 then
		fn("Cash run stopped.", 3)
	end
end

tbl6.StartCashRun = function(arg, arg2)
	if arg.CashRunning then
		fn("Cash run is already running.", 3)
		return
	end

	if flag then
		fn("Another inventory action is running.", 3)
		return
	end
	local tbl21 = arg2 and table.clone(v3.RunawaysCashSources.Value) or {}
	if arg2 and not next(tbl21) then
		fn("Select at least one cash source.")
		return
	end
	local cashToken = {}
	arg.CashToken = cashToken
	arg.CashRunning = true
	arg.CashContext = nil
	flag = true

	task.spawn(function()
		local n4 = 0
		local n5 = 0
		local n6 = 0
		local n7 = 0
		local cashAmount = arg:GetCashAmount()
		local cashContext = nil

		local ok, result = pcall(function()
			if not FlowClient.Cash or type(FlowClient.Cash.Collect) ~= "function" then
				error("Cash collection is unavailable.", 0)
			end

			if arg2 and (not FlowClient.DamageToOpen or type(FlowClient.DamageToOpen.Damage) ~= "function") then
				error("Cash sources are unavailable.", 0)
			end

			local character = localPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

			if not character or not humanoid or not humanoidRootPart or humanoid.Health <= 0 then
				error("Character is not ready.", 0)
			end

			if humanoid.SeatPart then
				error("Exit the vehicle first.", 0)
			end

			local currentCamera = workspace.CurrentCamera

			cashContext = {
				Character = character,
				Root = humanoidRootPart,
				StartPivot = character:GetPivot(),
				Camera = currentCamera,
				CameraCFrame = currentCamera and currentCamera.CFrame,
				CameraSubject = currentCamera and currentCamera.CameraSubject,
				CameraType = currentCamera and currentCamera.CameraType,
			}

			if arg.CashToken ~= cashToken or v.Unloaded then
				return
			end
			arg.CashContext = cashContext

			if currentCamera then
				currentCamera.CameraType = Enum.CameraType.Scriptable
				currentCamera.CFrame = cashContext.CameraCFrame
			end

			if arg2 then
				local tbl22 = {}

				for _, v18 in CollectionService:GetTagged("DamageToOpen") do
					if arg:IsCashSource(v18) then
						local health = v18:FindFirstChild("Health")
						local flag3 = false

						for k in tbl21, nil, nil do
							if v18:HasTag(k) then
								flag3 = true
								break
							end
						end

						if flag3 and health and health:IsA("NumberValue") and health.Value > 0 then
							tbl22[#tbl22 + 1] = v18
						end
					end
				end

				table.sort(tbl22, function(arg3, arg4)
					return arg3.Name < arg4.Name
				end)

				for _, v18 in tbl22, nil, nil do
					if arg.CashToken ~= cashToken or arg.CashContext ~= cashContext or v.Unloaded or localPlayer.Character ~= character or not character.Parent or humanoidRootPart.Parent ~= character or humanoid.Health <= 0 then
						return
					end
					local health = v18:FindFirstChild("Health")
					local maxHealth = v18:FindFirstChild("MaxHealth")

					if health and health:IsA("NumberValue") and health.Value > 0 then
						n5 += 1
						local n8 = math.max(health.Value, maxHealth and maxHealth.Value or 0, 1) * 10
						pcall(FlowClient.DamageToOpen.Damage, v18, n8, "melee")
						local n9 = os.clock() + 0.6

						while true do
							task.wait(0.05)
							if not (not health.Parent or health.Value <= 0 or arg.CashToken ~= cashToken or arg.CashContext ~= cashContext or v.Unloaded or os.clock() >= n9) then
								continue
							end
							break
						end

						if arg.CashToken ~= cashToken or arg.CashContext ~= cashContext or v.Unloaded or localPlayer.Character ~= character or not character.Parent or humanoidRootPart.Parent ~= character or humanoid.Health <= 0 then
							return
						end

						if health.Parent and health.Value > 0 then
							pcall(FlowClient.DamageToOpen.Damage, v18, n8, "melee")
							local n10 = os.clock() + 0.5

							while true do
								task.wait(0.05)
								if not (not health.Parent or health.Value <= 0 or arg.CashToken ~= cashToken or arg.CashContext ~= cashContext or v.Unloaded or os.clock() >= n10) then
									continue
								end
								break
							end
						end

						if not health.Parent or health.Value <= 0 then
							n4 += 1
						end
					end
				end

				task.wait(0.8)
			end

			local tbl22 = {}
			local tbl23 = {}
			local n8 = 0

			for i = 1, 12 do
				if arg.CashToken ~= cashToken or arg.CashContext ~= cashContext or v.Unloaded or localPlayer.Character ~= character or not character.Parent or humanoidRootPart.Parent ~= character or humanoid.Health <= 0 then
					return
				end
				local flag3 = false

				for _, v18 in arg:GetCashDrops() do
					local flag4 = not tbl22[v18]

					if flag4 then
						flag4 = (tbl23[v18] or 0) < 2
					end

					if flag4 then
						if not tbl23[v18] then
							n6 += 1
						end

						tbl23[v18] = (tbl23[v18] or 0) + 1

						if arg:CollectCashDrop(cashToken, cashContext, v18) then
							tbl22[v18] = true
							n7 += 1
						end

						local flag5 = localPlayer.Character ~= character or not character.Parent or humanoidRootPart.Parent ~= character or humanoid.Health <= 0
						flag3 = true
						if flag5 then
							return
						end
					end
				end

				n8 = flag3 and 0 or n8 + 1
				if n8 >= (arg2 and 6 or 3) then
					break
				end
				task.wait(flag3 and 0.1 or 0.25)
			end
		end)

		if arg.CashToken ~= cashToken then
			if arg.CashContext == cashContext then
				arg:Restore(cashContext)
				arg.CashContext = nil
			end

			return
		end

		if arg.CashContext == cashContext then
			arg:Restore(cashContext)
			arg.CashContext = nil
		end

		arg.CashToken = nil
		arg.CashRunning = false
		flag = false
		if v.Unloaded then
			return
		end
		local cashAmount2 = arg:GetCashAmount()
		local n8 = cashAmount and cashAmount2 and math.max(cashAmount2 - cashAmount, 0)

		if not ok then
			fn("Cash run failed: " .. tostring(result), 6)
		elseif n5 == 0 and n6 == 0 then
			fn(arg2 and "No cash sources or drops found." or "No cash found.")
		elseif n5 > 0 and n4 == 0 and n6 == 0 then
			fn("Cash sources were found, but none opened.", 6)
		elseif n8 and n8 > 0 then
			fn(string.format("Earned: $%d. Opened: %d, collected: %d.", n8, n4, n7), 6)
		else
			fn(string.format("Opened: %d, collected: %d.", n4, n7), 6)
		end
	end)
end

tbl6.SetCashAura = function(arg, arg2)
	arg.CashAuraToken = arg2 and {} or nil
	local cashAuraToken = arg.CashAuraToken
	if not cashAuraToken then
		return
	end

	task.spawn(function()
		local obj5 = setmetatable({}, { __mode = "k" })

		while arg.CashAuraToken == cashAuraToken and not v.Unloaded do
			local character = localPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			character = character and character:FindFirstChild("HumanoidRootPart")

			if humanoid and character and humanoid.Health > 0 then
				for _, v18 in arg:GetCashDrops(false) do
					local parent = v18.Parent
					parent = parent and parent:FindFirstChild("TouchSensor", true)
					local v19 = obj5[v18]

					if FlowClient.Cash and type(FlowClient.Cash.Collect) == "function" and parent and (parent.Position - character.Position).Magnitude <= 7 and (not v19 or os.clock() - v19 >= 0.75) then
						obj5[v18] = os.clock()
						pcall(FlowClient.Cash.Collect, v18)
					end
				end
			end

			task.wait(0.12)
		end
	end)
end

tbl6.Destroy = function(arg)
	arg:StopCash(true)
	arg.CashAuraToken = nil
	arg:Stop(true)
	table.clear(arg.Names)
	table.clear(arg.Signatures)
end

local function fn71()
	if flag then
		return false
	end
	local character = localPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	character = character and character:FindFirstChild("HumanoidRootPart")
	local v18, v19 = fn6()
	if not humanoid or not character or humanoid.Health <= 0 or humanoid.SeatPart or not v18 or not v19 or v18 >= v19 then
		return false
	end
	local n4 = 8
	local v20 = nil

	for _, v21 in fn3(), nil, nil do
		local primaryPart = v21.PrimaryPart
		primaryPart = primaryPart and (primaryPart.Position - character.Position).Magnitude

		if primaryPart and primaryPart <= n4 then
			n4 = primaryPart
			v20 = v21
		end
	end

	if not v20 or not fn2(v20) then
		return false
	end
	flag = true
	local ok, result = pcall(FlowClient.Loot.LootEquip, v20.PrimaryPart)
	flag = false
	return ok and result == "Success"
end

local function fn72(arg)
	if flag then
		fn("Loot is already running.", 3)
		return
	end
	flag = true

	task.spawn(function()
		local n4 = 0
		local n5 = 0
		local n6 = 0
		local flag3 = false
		local n7 = nil
		local v18 = nil
		local character = nil
		local humanoidRootPart = nil
		local pivot = nil
		local currentCamera = nil
		local cFrame = nil
		local cameraType = nil
		local cameraSubject, ok, result

		ok, result = pcall(function()
			character = localPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

			if not character or not humanoid or not humanoidRootPart or humanoid.Health <= 0 then
				error("Character is not ready.", 0)
			end

			if humanoid.SeatPart then
				error("Exit the vehicle first.", 0)
			end

			local v19, v20 = fn6()
			n7 = v19
			v18 = v20

			if not n7 or not v18 then
				error("Backpack is not ready.", 0)
			end

			for _, v21 in fn3(), nil, nil do
				if not v.Unloaded then
					if not arg(v21.Name) or not fn2(v21) then
						continue
					else
						local v22, v23 = fn6()

						if not v22 or not v23 then
							error("Backpack is not ready.", 0)
						end

						n7 = math.max(n7, v22)
						v18 = v23

						if v18 <= n7 then
							flag3 = true
							break
						else
							n4 += 1
							local primaryPart = v21.PrimaryPart
							local flag4 = (humanoidRootPart.Position - primaryPart.Position).Magnitude > 6

							if flag4 then
								if not pivot then
									pivot = character:GetPivot()
									currentCamera = workspace.CurrentCamera
									cFrame = currentCamera and currentCamera.CFrame
									cameraSubject = currentCamera and currentCamera.CameraSubject
									cameraType = currentCamera and currentCamera.CameraType

									if currentCamera then
										currentCamera.CameraType = Enum.CameraType.Scriptable
										currentCamera.CFrame = cFrame
									end
								end

								character:PivotTo(fn7(humanoidRootPart, primaryPart))
								humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
								humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
								task.wait(0.18)
							end

							local ok2, result2 = pcall(FlowClient.Loot.LootEquip, primaryPart)

							if flag4 and (not ok2 or result2 ~= "Success") and fn2(v21) then
								task.wait(0.15)
								ok2, result2 = pcall(FlowClient.Loot.LootEquip, primaryPart)
							end

							if ok2 and result2 == "Success" then
								n5 += 1
								n7 += 1
							else
								n6 += 1
							end

							task.wait(0.08)
							continue
						end
					end
				end

				break
			end
		end)

		if pivot and character and character.Parent and humanoidRootPart and humanoidRootPart.Parent == character then
			character:PivotTo(pivot)
			humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
			humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
		end

		if currentCamera and currentCamera.Parent then
			currentCamera.CameraSubject = cameraSubject
			currentCamera.CameraType = cameraType
			currentCamera.CFrame = cFrame
		end

		flag = false
		if v.Unloaded then
			return
		end
		tbl6:Refresh()

		if not ok then
			fn("Loot failed: " .. tostring(result), 6)
		elseif flag3 then
			fn(string.format("Inventory full: %d/%d. Looted: %d.", n7, v18, n5), 6)
		elseif n4 == 0 then
			fn("Nothing to loot.")
		elseif n6 == 0 then
			fn(string.format("Looted: %d.", n5))
		else
			fn(string.format("Looted: %d, failed: %d.", n5, n6), 6)
		end
	end)
end

local function fn73()
	if flag then
		fn("Inventory action is already running.", 3)
		return
	end
	flag = true

	task.spawn(function()
		local n4 = 0

		local ok, result = pcall(function()
			local backpack = localPlayer:FindFirstChildOfClass("Backpack")
			local character = localPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			local v18 = table.clone(v3.DropExclusions.Value)

			if not backpack or not character or not humanoid then
				error("Inventory is not ready.", 0)
			end

			local tbl21 = {}

			for _, v19 in { backpack, character }, nil, nil do
				for _, v20 in v19:QueryDescendants("> Tool") do
					local v21 = fn5(v20)
					local flag3 = not v20:HasTag("Undroppable")

					if flag3 then
						flag3 = not (v21 and v18[v21])
					end

					if flag3 then
						tbl21[#tbl21 + 1] = v20
					end
				end
			end

			humanoid:UnequipTools()

			for _, v19 in tbl21, nil, nil do
				if v19.Parent == backpack or v19.Parent == character then
					if pcall(FlowClient.Loot.LootUnequip, v19, v19:HasTag("RemoteOnly")) then
						n4 += 1
					end

					task.wait(0.05)
				end
			end
		end)

		flag = false
		if v.Unloaded then
			return
		end

		if not ok then
			fn("Drop failed: " .. tostring(result), 6)
		elseif n4 == 0 then
			fn("Nothing to drop.")
		else
			fn(string.format("Dropped: %d.", n4))
		end
	end)
end

local function fn74()
	return tbl6:GetCashAmount()
end

local function fn75()
	if flag then
		fn("Inventory action is already running.", 3)
		return
	end
	flag = true

	task.spawn(function()
		local n4 = 0
		local n5 = 0
		local n6 = nil
		local character = nil
		local humanoidRootPart = nil
		local pivot = nil
		local currentCamera = nil
		local cameraSubject = nil
		local cameraType = nil
		local cFrame, ok, result

		ok, result = pcall(function()
			local backpack = localPlayer:FindFirstChildOfClass("Backpack")
			character = localPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
			local callBell = CollectionService:GetTagged("PawnCounter")[1]
			local volume = callBell and callBell:FindFirstChild("Volume", true)
			callBell = callBell and callBell:FindFirstChild("CallBell", true)
			local proximityPrompt = callBell and callBell:FindFirstChildWhichIsA("ProximityPrompt", true)
			local v18 = table.clone(v3.SellExclusions.Value)

			if not backpack or not character or not humanoid or not humanoidRootPart or humanoid.Health <= 0 then
				error("Inventory is not ready.", 0)
			end

			if humanoid.SeatPart then
				error("Exit the vehicle first.", 0)
			end

			if not volume or not callBell or not proximityPrompt then
				error("Pawn shop is not available.", 0)
			end

			if proximityPrompt.Enabled then
				error("Pawn counter is occupied.", 0)
			end

			local tbl21 = {}

			for _, v19 in { backpack, character }, nil, nil do
				for _, v20 in v19:QueryDescendants("> Tool") do
					local v21 = fn5(v20)
					local flag3 = tbl4[v20.Name]
					flag3 = flag3 and flag3 > 0 and not v20:HasTag("Undroppable")

					if flag3 then
						flag3 = not (v21 and v18[v21])
					end

					if flag3 then
						tbl21[#tbl21 + 1] = v20
					end
				end
			end

			if #tbl21 == 0 then
				return
			end
			pivot = character:GetPivot()
			currentCamera = workspace.CurrentCamera
			cFrame = currentCamera and currentCamera.CFrame
			cameraSubject = currentCamera and currentCamera.CameraSubject
			cameraType = currentCamera and currentCamera.CameraType

			if currentCamera then
				currentCamera.CameraType = Enum.CameraType.Scriptable
				currentCamera.CFrame = cFrame
			end

			local n7 = callBell.Position - volume.Position
			local vector = Vector3.new(n7.X, 0, n7.Z)
			local n8 = volume.Position + (vector.Magnitude > 0.1 and vector.Unit or -volume.CFrame.LookVector) * 3.8
			local vector2 = Vector3.new(n8.X, volume.Position.Y + 0.35, n8.Z)
			humanoid:UnequipTools()
			character:PivotTo(CFrame.lookAt(vector2, Vector3.new(volume.Position.X, vector2.Y, volume.Position.Z)))
			humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
			humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
			task.wait(0.25)
			local v19 = fn74()
			local n9 = 1
			local v20, flag3

			while true do
				if n9 <= #tbl21 and not v.Unloaded then
					local n10 = 0
					local n11 = 0

					for i = 1, 5 do
						local v21 = tbl21[n9]

						if v21 then
							n9 += 1

							if v21.Parent == backpack or v21.Parent == character then
								if pcall(FlowClient.Loot.LootUnequip, v21, v21:HasTag("RemoteOnly")) then
									local n12 = os.clock() + 0.75

									while true do
										task.wait()
										if not (v21.Parent ~= backpack and v21.Parent ~= character or os.clock() >= n12) then
											continue
										end
										break
									end

									if v21.Parent ~= backpack and v21.Parent ~= character then
										n10 += 1
										n11 += tbl4[v21.Name]
									else
										n5 += 1
									end
								else
									n5 += 1
								end

								task.wait(0.04)
							end

							continue
						end

						break
					end

					if not (n10 > 0) then
						continue
					else
						local n12 = os.clock() + 3

						while true do
							task.wait(0.05)
							if not (proximityPrompt.Enabled or os.clock() >= n12) then
								continue
							end
							break
						end

						if not proximityPrompt.Enabled then
							n5 += n10
							break
						else
							local v21 = fn74()
							task.wait(0.15)
							local n13 = 0

							for i = 1, n10 do
								local v22 = fn74()

								if v21 and v22 and v22 - v21 >= n11 then
									n13 = n10
									break
								else
									local n14 = os.clock() + 1.5

									while true do
										task.wait(0.03)
										v20 = fn74()
										if not (proximityPrompt.Enabled or v21 and v20 and v20 - v21 >= n11 or os.clock() >= n14) then
											continue
										end
										break
									end

									if v21 and v20 and v20 - v21 >= n11 then
										n13 = n10
										break
									elseif proximityPrompt.Enabled then
										if fireproximityprompt then
											fireproximityprompt(proximityPrompt)
										else
											proximityPrompt:InputHoldBegin()
											task.wait(proximityPrompt.HoldDuration + 0.1)
											proximityPrompt:InputHoldEnd()
										end

										local n15 = os.clock() + 1.5

										while true do
											task.wait(0.05)
											local v23 = fn74()
											flag3 = not proximityPrompt.Enabled or v20 and v23 and v23 > v20
											if not (flag3 or os.clock() >= n15) then
												continue
											end
											break
										end

										if flag3 then
											n13 += 1
											task.wait(0.05)
											continue
										end
									end
								end

								break
							end

							local v22 = fn74()

							if v21 and v22 and v22 - v21 >= n11 then
								n13 = n10
							end

							n4 += n13

							if n13 < n10 then
								n5 += n10 - n13
								break
							else
								continue
							end
						end
					end
				end

				break
			end

			local v21 = fn74()

			if v19 and v21 and v21 > v19 then
				n6 = v21 - v19
			end
		end)

		if pivot and character and character.Parent and humanoidRootPart and humanoidRootPart.Parent == character then
			character:PivotTo(pivot)
			humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
			humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
		end

		if currentCamera and currentCamera.Parent then
			currentCamera.CameraSubject = cameraSubject
			currentCamera.CameraType = cameraType
			currentCamera.CFrame = cFrame
		end

		flag = false
		if v.Unloaded then
			return
		end

		if not ok then
			fn("Sell failed: " .. tostring(result), 6)
		elseif n4 == 0 and n5 == 0 then
			fn("Nothing to sell.")
		elseif n6 then
			fn(string.format("Sold: %d, earned: $%d.", n4, n6))
		elseif n5 == 0 then
			fn(string.format("Sold: %d.", n4))
		else
			fn(string.format("Sold: %d, failed: %d.", n4, n5), 6)
		end
	end)
end

Loot:AddButton({
	Text = "Loot Selected",
	Func = function()
		local v18 = table.clone(v3.LootItems.Value)
		if not next(v18) then
			fn("Select at least one item.", 3)
			return
		end

		fn72(function(arg)
			return v18[arg] == true
		end)
	end,
})

Loot:AddButton({
	Text = "Loot All",
	Func = function()
		fn72(function()
			return true
		end)
	end,
})

Loot:AddToggle("LootAura", {
	Text = "Loot Aura",
	Default = false,
	Callback = function(arg)
		tbl7 = arg and {} or nil
		local v18 = tbl7
		if not v18 then
			return
		end

		task.spawn(function()
			while tbl7 == v18 and not v.Unloaded do
				task.wait(fn71() and 0.1 or 0.2)
			end
		end)
	end,
})

Loot:AddDropdown("DropExclusions", {
	Values = tbl2,
	Default = table.find(tbl2, "Backpack"),
	Multi = true,
	Text = "Keep Categories",
	Searchable = true,
	MaxVisibleDropdownItems = 12,
	FormatDisplayValue = fn4,
	FormatListValue = fn4,
})

Loot:AddButton({ Text = "Drop All Loot", Func = fn73 })

Money:AddDropdown("RunawaysCashSources", {
	Values = { "ATM", "Register", "Safe", "Nightstand", "Dumpster", "MailBox", "GarbageCan" },
	Default = { "ATM", "Register", "Safe", "Nightstand", "Dumpster", "MailBox", "GarbageCan" },
	Multi = true,
	Text = "Cash Sources",
	Searchable = true,
	MaxVisibleDropdownItems = 10,
	FormatDisplayValue = fn4,
	FormatListValue = fn4,
})

Money:AddButton({
	Text = "Cash Run",
	Func = function()
		tbl6:StartCashRun(true)
	end,
})

Money:AddButton({
	Text = "Collect All Cash",
	Func = function()
		tbl6:StartCashRun(false)
	end,
})

Money:AddButton({
	Text = "Stop Cash Run",
	Func = function()
		tbl6:StopCash()
	end,
})

Money:AddToggle("RunawaysCashAura", {
	Text = "Cash Aura",
	Default = false,
	Callback = function(arg)
		tbl6:SetCashAura(arg)
	end,
})

Money:AddDivider()

Money:AddDropdown("SellExclusions", {
	Values = tbl2,
	Default = table.find(tbl2, "Backpack"),
	Multi = true,
	Text = "Keep Categories",
	Searchable = true,
	MaxVisibleDropdownItems = 12,
	FormatDisplayValue = fn4,
	FormatListValue = fn4,
})

Money:AddButton({ Text = "Sell All Loot", Func = fn75 })

NPCs:AddToggle("KillAllNPCs", {
	Text = "Kill All NPCs",
	Default = false,
	Callback = function(arg)
		tbl8 = arg and {} or nil
		local v18 = tbl8
		if not v18 then
			return
		end

		task.spawn(function()
			while tbl8 == v18 and not v.Unloaded do
				fn8()
				task.wait(0.5)
			end
		end)
	end,
})

Utility:AddToggle("RunawaysInstantPrompt", {
	Text = "Instant Prompt",
	Default = false,
	Callback = function(arg)
		tbl10:SetActive(arg)
	end,
})

Utility:AddToggle("RunawaysVehicleAutoRefuel", {
	Text = "Auto Refuel",
	Default = false,
	Callback = function(arg)
		teleports:SetAutoRefuel(arg)
	end,
})

local function fn76(arg)
	local v18 = fn10()
	if not v18 then
		fn("Enter the driver's seat first.")
		return
	end
	arg(v18)
end

Performance:AddLabel("Uses the current vehicle's stock values")

Performance:AddToggle("RunawaysVehiclePerformance", {
	Text = "Performance Mods",
	Default = false,
	Callback = function(arg)
		if not arg then
			fn19()
		end
	end,
})

Performance:AddSlider("RunawaysVehicleTopSpeedMultiplier", { Text = "Top Speed", Default = 2, Min = 1, Max = 5, Rounding = 1, Suffix = "x" })
Performance:AddSlider("RunawaysVehicleAccelerationMultiplier", { Text = "Acceleration", Default = 3, Min = 1, Max = 10, Rounding = 1, Suffix = "x" })
Performance:AddSlider("RunawaysVehicleTorqueMultiplier", { Text = "Engine Torque", Default = 3, Min = 1, Max = 10, Rounding = 1, Suffix = "x" })
Performance:AddSlider("RunawaysVehicleBrakeMultiplier", { Text = "Brake Power", Default = 2, Min = 1, Max = 10, Rounding = 1, Suffix = "x" })
Performance:AddSlider("RunawaysVehicleSteeringMultiplier", { Text = "High-Speed Steering", Default = 1.5, Min = 0.5, Max = 3, Rounding = 1, Suffix = "x" })
Performance:AddSlider("RunawaysVehicleDownforceMultiplier", { Text = "Downforce", Default = 1.5, Min = 0, Max = 5, Rounding = 1, Suffix = "x" })

Performance:AddToggle("RunawaysVehicleTireGripOverride", {
	Text = "Drift Mode",
	Default = false,
	Callback = function(arg)
		if not arg then
			fn20()
		end
	end,
})

Performance:AddSlider("RunawaysVehicleTireGrip", { Text = "Drift Grip", Default = 0.6, Min = 0.1, Max = 2, Rounding = 1 })
isMobile:AddLabel("Driving controls require the driver seat")

isMobile:AddToggle("RunawaysVehicleInfiniteFuel", {
	Text = "Infinite Fuel",
	Default = false,
	Callback = function(arg)
		if arg then
			return
		end

		for k in obj3, nil, nil do
			v.VehicleMods:RestoreFuel(k)
		end
	end,
})

isMobile:AddToggle("RunawaysVehicleIndestructible", { Text = "Indestructible Vehicle", Default = false, Callback = fn14 })

isMobile:AddButton("Flip Vehicle", function()
	fn76(function(arg)
		local v18 = fn11(arg)
		local v19 = fn12(arg)

		if v18 and v19 then
			local vector = Vector3.new(v19.CFrame.LookVector.X, 0, v19.CFrame.LookVector.Z)

			if vector.Magnitude < 0.1 then
				vector = Vector3.new(-v18.CFrame.RightVector.X, 0, -v18.CFrame.RightVector.Z)
			end

			if vector.Magnitude < 0.1 then
				vector = Vector3.new(0, 0, -1)
			end

			local n4 = v19.Position + Vector3.new(0, 3, 0)
			local cFrame = v19.CFrame
			arg:PivotTo(CFrame.lookAt(n4, n4 + vector.Unit, Vector3.new(0, 1, 0)) * cFrame:Inverse() * arg:GetPivot())
			v18.AssemblyLinearVelocity = Vector3.zero
			v18.AssemblyAngularVelocity = Vector3.zero
		end
	end)
end)

isMobile:AddButton("Reset Vehicle Mods", function()
	for _, v18 in {
		"RunawaysVehiclePerformance",
		"RunawaysVehicleTireGripOverride",
		"RunawaysVehicleInfiniteFuel",
		"RunawaysVehicleAutoRefuel",
		"RunawaysVehicleIndestructible",
	}, nil, nil do
		if v2[v18] then
			v2[v18]:SetValue(false)
		end
	end

	for _, v18 in {
		"RunawaysVehicleTopSpeedMultiplier",
		"RunawaysVehicleAccelerationMultiplier",
		"RunawaysVehicleTorqueMultiplier",
		"RunawaysVehicleBrakeMultiplier",
		"RunawaysVehicleSteeringMultiplier",
		"RunawaysVehicleDownforceMultiplier",
		"RunawaysVehicleTireGrip",
	}, nil, nil do
		if v3[v18] then
			v3[v18]:SetValue(v3[v18].Default)
		end
	end

	fn21()
	fn("Vehicle mods reset.")
end)

v16:AddLabel("Applies to the equipped firearm")
v16:AddToggle("RunawaysWeaponInfiniteAmmo", { Text = "Infinite Ammo", Default = false })
v16:AddToggle("RunawaysWeaponNoCooldown", { Text = "No Cooldown", Default = false })
v16:AddToggle("RunawaysWeaponAutomatic", { Text = "Automatic Fire", Default = false })
v16:AddToggle("RunawaysWeaponNoRecoil", { Text = "No Recoil", Default = false })
v16:AddToggle("RunawaysWeaponNoSpread", { Text = "No Spread", Default = false })
v16:AddToggle("RunawaysWeaponNoPushback", { Text = "No Weapon Pushback", Default = false })

v16:AddButton("Reset Weapon Mods", function()
	for _, v18 in {
		"RunawaysWeaponInfiniteAmmo",
		"RunawaysWeaponNoCooldown",
		"RunawaysWeaponAutomatic",
		"RunawaysWeaponNoRecoil",
		"RunawaysWeaponNoSpread",
		"RunawaysWeaponNoPushback",
	}, nil, nil do
		if v2[v18] then
			v2[v18]:SetValue(false)
		end
	end

	fn46()
	fn38()
	fn("Weapon mods reset.")
end)

Style:AddToggle("RunawaysESPEnabled", {
	Text = "ESP Enabled",
	Default = false,
	Callback = function(arg)
		if arg and not flag2 then
			fn("Drawing API is unavailable")

			task.defer(function()
				v2.RunawaysESPEnabled:SetValue(false)
			end)
		elseif not arg then
			fn57()
		end
	end,
}):AddKeyPicker("RunawaysESPKeybind", { Default = "P", SyncToggleState = true, Mode = "Toggle", Text = "ESP Keybind" })

Style:AddSlider("RunawaysESPTextSize", { Text = "Text Size", Default = 13, Min = 10, Max = 24, Rounding = 0 })
Style:AddDropdown("RunawaysESPFont", { Values = { "UI", "System", "Plex", "Monospace" }, Default = 3, Text = "Font" })
Style:AddToggle("RunawaysESPTextOutline", { Text = "Text Outline", Default = true }):AddColorPicker("RunawaysESPOutlineColor", { Default = Color3.new(0, 0, 0), Title = "Outline Color", Transparency = 0 })
Style:AddSlider("RunawaysESPBoxThickness", { Text = "Line Thickness", Default = 1, Min = 1, Max = 3, Rounding = 0 })
Style:AddDropdown("RunawaysESPTracerOrigin", { Values = { "Bottom", "Center", "Mouse" }, Default = 1, Text = "Tracer Origin" })
Items:AddToggle("RunawaysESPItems", { Text = "Item ESP", Default = true }):AddColorPicker("RunawaysESPItemColor", { Default = Color3.fromRGB(255, 210, 90), Title = "Item Color", Transparency = 0 })
Items:AddToggle("RunawaysESPItemName", { Text = "Show Name", Default = true })
Items:AddToggle("RunawaysESPItemCategory", { Text = "Show Category", Default = true })
Items:AddToggle("RunawaysESPItemPrice", { Text = "Show Price", Default = true })
Items:AddToggle("RunawaysESPItemDistance", { Text = "Show Distance", Default = true })
Items:AddToggle("RunawaysESPItemBox", { Text = "Boxes", Default = false })
Items:AddToggle("RunawaysESPItemTracer", { Text = "Tracers", Default = false })
Items:AddToggle("RunawaysESPItemHighValue", { Text = "High Value Color", Default = false }):AddColorPicker("RunawaysESPItemHighValueColor", { Default = Color3.fromRGB(80, 255, 130), Title = "High Value Color", Transparency = 0 })

Items:AddSlider("RunawaysESPItemHighValueThreshold", {
	Text = "High Value Threshold",
	Default = math.floor(n * 0.6),
	Min = 0,
	Max = math.max(1, math.ceil(n)),
	Rounding = 0,
	Prefix = "$",
})

Items:AddSlider("RunawaysESPItemMinValue", {
	Text = "Minimum Value",
	Default = 0,
	Min = 0,
	Max = math.max(1, math.ceil(n)),
	Rounding = 0,
	Prefix = "$",
})

Items:AddDropdown("RunawaysESPItemCategories", {
	Values = tbl2,
	Default = tbl2,
	Multi = true,
	Text = "Categories",
	Searchable = true,
	MaxVisibleDropdownItems = 12,
	FormatDisplayValue = fn4,
	FormatListValue = fn4,
})

Items:AddSlider("RunawaysESPItemMaxDistance", {
	Text = "Maximum Distance",
	Default = 1500,
	Min = 100,
	Max = 5000,
	Rounding = 0,
	Suffix = " studs",
})

Items:AddSlider("RunawaysESPMaxItems", { Text = "Maximum Items", Default = 100, Min = 25, Max = 250, Rounding = 0 })
Players2:AddToggle("RunawaysESPPlayers", { Text = "Player ESP", Default = true }):AddColorPicker("RunawaysESPPlayerColor", { Default = Color3.fromRGB(75, 210, 255), Title = "Player Color", Transparency = 0 })
Players2:AddToggle("RunawaysESPPlayerName", { Text = "Show Name", Default = true })
Players2:AddToggle("RunawaysESPPlayerHealth", { Text = "Show Health", Default = true })
Players2:AddToggle("RunawaysESPPlayerDistance", { Text = "Show Distance", Default = true })
Players2:AddToggle("RunawaysESPPlayerBox", { Text = "Boxes", Default = true })
Players2:AddToggle("RunawaysESPPlayerHealthBar", { Text = "Health Bars", Default = true })
Players2:AddToggle("RunawaysESPPlayerTracer", { Text = "Tracers", Default = false })

Players2:AddSlider("RunawaysESPPlayerMaxDistance", {
	Text = "Maximum Distance",
	Default = 2500,
	Min = 100,
	Max = 5000,
	Rounding = 0,
	Suffix = " studs",
})

NPCs2:AddToggle("RunawaysESPNPCs", { Text = "NPC ESP", Default = true }):AddColorPicker("RunawaysESPNPCColor", { Default = Color3.fromRGB(255, 90, 90), Title = "NPC Color", Transparency = 0 })
NPCs2:AddToggle("RunawaysESPNPCName", { Text = "Show Name", Default = true })
NPCs2:AddToggle("RunawaysESPNPCHealth", { Text = "Show Health", Default = true })
NPCs2:AddToggle("RunawaysESPNPCDistance", { Text = "Show Distance", Default = true })
NPCs2:AddToggle("RunawaysESPNPCBox", { Text = "Boxes", Default = true })
NPCs2:AddToggle("RunawaysESPNPCHealthBar", { Text = "Health Bars", Default = true })
NPCs2:AddToggle("RunawaysESPNPCTracer", { Text = "Tracers", Default = false })
NPCs2:AddToggle("RunawaysESPNPCActiveOnly", { Text = "Active NPCs Only", Default = false })

NPCs2:AddSlider("RunawaysESPNPCMaxDistance", {
	Text = "Maximum Distance",
	Default = 2000,
	Min = 100,
	Max = 5000,
	Rounding = 0,
	Suffix = " studs",
})

World:AddToggle("RunawaysESPVehicles", { Text = "Vehicle ESP", Default = true }):AddColorPicker("RunawaysESPVehicleColor", { Default = Color3.fromRGB(180, 110, 255), Title = "Vehicle Color", Transparency = 0 })
World:AddToggle("RunawaysESPVehicleName", { Text = "Vehicle Name", Default = true })
World:AddToggle("RunawaysESPVehicleHealth", { Text = "Vehicle Health", Default = true })
World:AddToggle("RunawaysESPVehicleDistance", { Text = "Vehicle Distance", Default = true })
World:AddToggle("RunawaysESPVehicleBox", { Text = "Vehicle Boxes", Default = true })
World:AddToggle("RunawaysESPVehicleTracer", { Text = "Vehicle Tracers", Default = false })

World:AddSlider("RunawaysESPVehicleMaxDistance", {
	Text = "Vehicle Distance Limit",
	Default = 5000,
	Min = 100,
	Max = 10000,
	Rounding = 0,
	Suffix = " studs",
})

World:AddDivider()
World:AddToggle("RunawaysESPSafes", { Text = "Safe ESP", Default = true }):AddColorPicker("RunawaysESPSafeColor", { Default = Color3.fromRGB(255, 170, 60), Title = "Safe Color", Transparency = 0 })
World:AddToggle("RunawaysESPSafeName", { Text = "Safe Name", Default = true })
World:AddToggle("RunawaysESPSafeDistance", { Text = "Safe Distance", Default = true })
World:AddToggle("RunawaysESPSafeBox", { Text = "Safe Boxes", Default = true })
World:AddToggle("RunawaysESPSafeTracer", { Text = "Safe Tracers", Default = false })

World:AddSlider("RunawaysESPSafeMaxDistance", {
	Text = "Safe Distance Limit",
	Default = 5000,
	Min = 100,
	Max = 10000,
	Rounding = 0,
	Suffix = " studs",
})

tbl11.Box:AddLabel("Unarmed punches and melee weapons")

tbl11.Box:AddToggle("RunawaysPunchMods", {
	Text = "Melee Mods",
	Default = false,
	Callback = function(arg)
		if arg then
			tbl11:Apply(true)
		else
			tbl11:Restore()
		end
	end,
})

tbl11.Box:AddToggle("RunawaysPunchNoCooldown", {
	Text = "No Melee Cooldown",
	Default = false,
	Callback = function()
		tbl11:Apply(true)
	end,
})

tbl11.Box:AddSlider("RunawaysPunchDamage", {
	Text = "Melee Damage",
	Default = tbl11.Defaults.Damage,
	Min = 1,
	Max = 500,
	Rounding = 0,
	Callback = function()
		tbl11:Apply(true)
	end,
})

tbl11.Box:AddSlider("RunawaysPunchSpeed", {
	Text = "Melee Speed",
	Default = tbl11.Defaults.Speed,
	Min = 1,
	Max = 30,
	Rounding = 1,
	Suffix = " hits/s",
	Callback = function()
		tbl11:Apply(true)
	end,
})

tbl11.Box:AddSlider("RunawaysPunchObjectDamage", {
	Text = "Object Damage",
	Default = tbl11.Defaults.ObjectDamage,
	Min = 1,
	Max = 500,
	Rounding = 0,
	Callback = function()
		tbl11:Apply(true)
	end,
})

tbl11.Box:AddButton("Reset Melee Mods", function()
	for _, v18 in { "RunawaysPunchMods", "RunawaysPunchNoCooldown" }, nil, nil do
		if v2[v18] then
			v2[v18]:SetValue(false)
		end
	end

	for _, v18 in { "RunawaysPunchDamage", "RunawaysPunchSpeed", "RunawaysPunchObjectDamage" }, nil, nil do
		if v3[v18] then
			v3[v18]:SetValue(v3[v18].Default)
		end
	end

	tbl11:Restore()
	fn("Melee mods reset.")
end)

Movement:AddToggle("RunawaysPlayerGodMode", {
	Text = "God Mode",
	Default = false,
	Callback = function(arg)
		if not arg then
			fn31()
		end
	end,
})

Movement:AddToggle("RunawaysPlayerSpeedBoost", {
	Text = "Speed Boost",
	Default = false,
	Callback = function(arg)
		if not arg then
			fn27()
		end
	end,
})

Movement:AddSlider("RunawaysPlayerWalkSpeed", { Text = "Walk Speed", Default = 30, Min = 15, Max = 100, Rounding = 0 })

Movement:AddToggle("RunawaysPlayerJumpPowerOverride", {
	Text = "Jump Power Override",
	Default = false,
	Callback = function(arg)
		if not arg then
			fn28()
		end
	end,
})

Movement:AddSlider("RunawaysPlayerJumpPower", { Text = "Jump Power", Default = 60, Min = 25, Max = 150, Rounding = 0 })
Movement:AddToggle("RunawaysPlayerInfiniteJump", { Text = "Infinite Jump", Default = false })

Movement:AddToggle("RunawaysPlayerNoclip", {
	Text = "Noclip",
	Default = false,
	Callback = function(arg)
		if not arg then
			fn29()
		end
	end,
})

Movement:AddToggle("RunawaysPlayerAntiAFK", {
	Text = "Anti AFK",
	Default = true,
	Callback = function(arg)
		if v.RunawaysAntiAFKConnection then
			v.RunawaysAntiAFKConnection:Disconnect()
			v.RunawaysAntiAFKConnection = nil
		end

		if not arg then
			return
		end
		local VirtualUser = game:GetService("VirtualUser")

		v.RunawaysAntiAFKConnection = localPlayer.Idled:Connect(function()
			pcall(function()
				VirtualUser:CaptureController()
				VirtualUser:ClickButton2(Vector2.zero)
			end)
		end)
	end,
})

fn52()

tbl10.Connection = tbl10.Service.PromptShown:Connect(function(arg)
	if tbl10.Active then
		tbl10:Set(arg)
	end
end)

tbl10.AddedConnection = workspace.DescendantAdded:Connect(function(descendant)
	if tbl10.Active and descendant:IsA("ProximityPrompt") then
		tbl10:Set(descendant)
	end
end)

local connection = RunService.PreSimulation:Connect(function()
	fn33()
	tbl11:Apply()
end)

local connection2 = RunService.PreSimulation:Connect(fn49)

local connection3 = UserInputService.JumpRequest:Connect(function()
	if not v2.RunawaysPlayerInfiniteJump or not v2.RunawaysPlayerInfiniteJump.Value then
		return
	end
	local v18 = fn9()

	if v18 and v18.Health > 0 then
		v18:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

pcall(function()
	RunService:UnbindFromRenderStep("RUNAWAYS_ESP")
end)

RunService:BindToRenderStep("RUNAWAYS_ESP", Enum.RenderPriority.Camera.Value + 10, fn69)
local tbl21 = {}

task.spawn(function()
	local v18 = tbl21

	while tbl21 == v18 and not v.Unloaded do
		fn70()
		task.wait(0.5)
	end
end)

Menu:AddLabel("Menu key"):AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu key" })

Menu:AddButton("Unload", function()
	v:Unload()
end)

v.ToggleKeybind = v3.MenuKeybind

v:OnUnload(function()
	v.AutoFarm:Destroy(genv.RunawaysScriptReloading == true or v.AutoFarm.Teleporting)
	tbl6:Destroy()
	tbl19:Destroy()
	v.LobbyShop:Destroy()
	tbl7 = nil
	tbl8 = nil
	v.Rage.KillAuraLoop = nil
	tbl21 = nil

	if connection then
		connection:Disconnect()
		connection = nil
	end

	if connection3 then
		connection3:Disconnect()
		connection3 = nil
	end

	if v.RunawaysAntiAFKConnection then
		v.RunawaysAntiAFKConnection:Disconnect()
		v.RunawaysAntiAFKConnection = nil
	end

	if connection2 then
		connection2:Disconnect()
		connection2 = nil
	end

	if tbl10.Connection then
		tbl10.Connection:Disconnect()
		tbl10.Connection = nil
	end

	if tbl10.AddedConnection then
		tbl10.AddedConnection:Disconnect()
		tbl10.AddedConnection = nil
	end

	RunService:UnbindFromRenderStep("RUNAWAYS_ESP")
	fn57()
	fn46()
	fn38()
	fn53()
	tbl11:Restore()
	teleports:Destroy()
	tbl10:Restore()
	fn27()
	fn28()
	fn29()
	fn31()
	fn21()
	fn14(false)

	if genv.AutoLoot == v then
		genv.AutoLoot = nil
	end
end)

task.spawn(function()
	while not v.Unloaded do
		task.wait(1)

		if not v.Unloaded then
			if not flag then
				tbl6:Refresh()
			end

			teleports:Refresh()
			tbl19:Refresh()
			v.LobbyShop:Refresh()
			v.AutoFarm:UpdateUI()
			local flag3 = v.AutoFarm.Running and v.AutoFarm:GetContext() == "Game"

			if flag3 then
				local lastPersistAt = v.AutoFarm.LastPersistAt
				flag3 = os.clock() - lastPersistAt >= 10
			end

			if flag3 then
				v.AutoFarm:Persist()
			end
		end
	end
end)

v4:SetLibrary(v)
v5:SetLibrary(v)
v5:IgnoreThemeSettings()
v5:SetIgnoreIndexes({ "MenuKeybind", "RunawaysAutoFarm", "RunawaysAutoFarmWebhookURL" })
v4:SetFolder("MyScriptHub")
local str3 = "MyScriptHub/RUNAWAYS/" .. tostring(game.PlaceId)
v5:SetFolder(str3)

if isfolder and makefolder then
	local str4 = ""

	for match in (str3 .. "/Configs"):gmatch("[^/]+") do
		str4 = str4 == "" and match or str4 .. "/" .. match

		if not isfolder(str4) then
			pcall(makefolder, str4)
		end
	end
end

v5:BuildConfigSection(tbl20.Settings)
v4:ApplyToTab(tbl20.Settings)
teleports:Refresh(true)
tbl6:Refresh(true)
tbl19:Refresh(true)
v.LobbyShop:Refresh(true)
v5:LoadAutoloadConfig()
tbl6:Refresh(true)
tbl19:Refresh(true)
v.LobbyShop:Refresh(true)
v.AutoFarm:LoadState()
v.AutoFarm:ApplyStoredOptions()
v.AutoFarm.StateReady = true
v.AutoFarm:UpdateUI()

if v.AutoFarm.ResumeRequested then
	task.defer(function()
		if v2.RunawaysAutoFarm and not v2.RunawaysAutoFarm.Value then
			v2.RunawaysAutoFarm:SetValue(true)
		else
			v.AutoFarm:Start()
		end
	end)
else
	v.AutoFarm:Persist()
end

if genv.RunawaysScriptLoading == coroutine.running() then
	if genv.RunawaysScriptLoadingToken ~= "" then
		genv.RunawaysScriptLoadedTransition = genv.RunawaysScriptLoadingToken
	end

	genv.RunawaysScriptLoading = nil
	genv.RunawaysScriptLoadingAt = nil
	genv.RunawaysScriptLoadingToken = nil
end

return v
