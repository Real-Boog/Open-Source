-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("VirtualInputManager")
local localPlayer = Players.LocalPlayer
local currentCamera = Workspace.CurrentCamera
localPlayer:GetMouse()
local v = nil
local tbl = {}
local tbl2 = {}
local tbl3 = {}
local fn = function(arg, arg2)
	if #arg ~= #arg2 then
		return false
	end

	for i = 1, #arg do
		if arg[i] ~= arg2[i] then
			return false
		end
	end

	return true
end

local tbl4

tbl4 = {
	Ambient = Lighting.Ambient,
	OutdoorAmbient = Lighting.OutdoorAmbient,
	ColorShift_Bottom = Lighting.ColorShift_Bottom,
	ColorShift_Top = Lighting.ColorShift_Top,
	ClockTime = Lighting.ClockTime,
}

local fn2

fn2 = function(arg)
	table.insert(tbl, arg)
	return arg
end

local fn3

fn3 = function(arg)
	table.insert(tbl2, arg)
	return arg
end

local fn4

fn4 = function()
	local str = v and v.EntityPath and v.EntityPath.Value or "Characters.Client"
	if str == nil or str == "" then
		return nil
	end
	local v2 = Workspace

	for match in string.gmatch(str, "[^%.]+") do
		if not v2 then
			return nil
		end
		v2 = v2:FindFirstChild(match)
	end

	return v2
end

local fn5

fn5 = function(arg)
	if arg then
		arg = arg:FindFirstChild("HumanoidRootPart") or arg.PrimaryPart
	end

	return arg
end

local fn6

local function fn7(arg)
	if not (arg and arg:IsA("Model")) then
		return false
	end

	if not string.match(arg.Name, "_Client$") then
		return false
	end

	if arg.Name == localPlayer.Name .. "_Client" then
		return false
	end
	return fn5(arg) ~= nil
end

fn6 = function()
	local tbl5 = {}
	local v2 = fn4()
	if not v2 then
		return tbl5
	end

	for _, child in ipairs(v2:GetChildren()) do
		if fn7(child) then
			table.insert(tbl5, child)
		end
	end

	return tbl5
end

local fn8, fn9, fn10, fn11, fn12, fn13, v2, v3, v4, v5
local fn14, fn15, tbl5, fn16, fn17, fn18, fn19, v6, v7, v8
local v9, v10, fn20, networkComm

do
	local function fn21(arg)
		local tbl6 = {}
		local characters = Workspace:FindFirstChild("Characters")
		characters = characters and characters:FindFirstChild("Server")
		if not characters then
			return tbl6
		end
		local tbl7 = { characters:FindFirstChild("NPCs") }

		if arg then
			tbl7[#tbl7 + 1] = characters:FindFirstChild("Players")
		end

		for _, v11 in ipairs(tbl7) do
			if v11 then
				for _, child in ipairs(v11:GetChildren()) do
					local humanoidRootPart = child:FindFirstChild("HumanoidRootPart")

					if humanoidRootPart then
						tbl6[#tbl6 + 1] = { child, humanoidRootPart.Position }
					end
				end
			end
		end

		return tbl6
	end

	local function fn22(arg, arg2)
		for _, v11 in ipairs(arg2) do
			if (v11[2] - arg).Magnitude < 0.5 then
				return v11[1]
			end
		end
	end

	fn8 = function()
		local humanoidRootPart = Workspace.Characters.Client:FindFirstChild(localPlayer.Name .. "_Client")
		humanoidRootPart = humanoidRootPart and humanoidRootPart:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return
		end
		local server = Workspace.Characters.Server
		local findFirstChild = server.FindFirstChild

		for _, v11 in ipairs({ server:FindFirstChild("Players"), findFirstChild(server, "NPCs") }) do
			if v11 then
				for _, child in ipairs(v11:GetChildren()) do
					local humanoidRootPart2 = child:FindFirstChild("HumanoidRootPart")
					if humanoidRootPart2 and (humanoidRootPart2.Position - humanoidRootPart.Position).Magnitude < 0.5 then
						return child, humanoidRootPart2
					end
				end
			end
		end
	end

	fn9 = function()
		return Workspace.Characters.Client:FindFirstChild(localPlayer.Name .. "_Client")
	end

	fn10 = function()
		local v11 = fn9()
		return v11 and v11:FindFirstChild("HumanoidRootPart")
	end

	fn11 = function(arg)
		if not arg then
			return nil
		end
		return Workspace.Characters.Client:FindFirstChild(arg.Name .. "_Client")
	end

	fn12 = function(arg)
		arg = arg and arg:FindFirstChild("BillboardGui")
		if not arg then
			return nil
		end
		local num = nil
		local num2 = nil
		local num3 = nil
		local v11 = nil
		local flag = nil
		local v12 = nil

		for _, descendant in ipairs(arg:GetDescendants()) do
			if descendant:IsA("TextLabel") then
				local text = descendant.Text

				if text and text ~= "" then
					local v13, v14 = string.match(text, "^(%d+)/(%d+)$")

					if v13 then
						num = tonumber(v13)
						num2 = tonumber(v14)
					end

					local v15, v16 = string.match(text, "^Lv%.(%d+)%s+(.+)$")

					if v15 then
						num3 = tonumber(v15)
					else
						v16 = v11
					end

					v11 = string.match(text, "^@(%S+)")

					if v11 then
						flag = true
					else
						v11 = v16
					end

					v12 = string.match(text, "^%[(.-)%]$") or v12
				end
			end
		end

		if not v11 then
			return nil
		end
		return { Name = v11, Level = num3, Grade = v12, HP = num or 0, MaxHP = num2 or 1, IsPlayer = flag or false }
	end

	local function fn23()
		return v and v.BossHPThreshold and v.BossHPThreshold.Value or 1000000
	end

	fn13 = function(arg)
		local v11 = fn12(arg)
		if not v11 then
			return nil
		end

		if v11.IsPlayer then
			return "player", v11
		end
		return v11.MaxHP >= fn23() and "boss" or "mob", v11
	end

	v2 = nil
	v3 = nil
	v4 = nil
	v5 = nil

	local function fn24(arg, arg2)
		if (arg2 - arg).Magnitude < 0.05 then
			return CFrame.new(arg)
		end
		return CFrame.lookAt(arg, arg2)
	end

	fn14 = function(arg)
		if not arg then
			return nil
		end
		local position = arg.Position
		if position.X ~= position.X or position.Y ~= position.Y or position.Z ~= position.Z then
			return nil
		end

		if math.abs(position.X) > 1000000 or math.abs(position.Y) > 1000000 or math.abs(position.Z) > 1000000 then
			return nil
		end
		return arg
	end

	fn15 = function(arg)
		if not arg then
			return nil
		end
		local cFrame = typeof(arg) == "CFrame" and arg or arg.CFrame
		if not cFrame then
			return nil
		end
		local str = v.FarmMethod and v.FarmMethod.Value or "Behind"
		local n = v.FarmOffsetX and v.FarmOffsetX.Value or 0
		local n2 = v.FarmOffsetY and v.FarmOffsetY.Value or 5
		local n3 = v.FarmOffsetZ and v.FarmOffsetZ.Value or 0
		local position = cFrame.Position

		if str == "Above" or str == "Below" then
			local n4 = math.abs(n2)

			if n4 < 1 then
				n4 = 5
			end

			if str == "Below" then
				n4 = -n4
			end

			local vector = Vector3.new(position.X + n, position.Y + n4, position.Z)
			local n5 = position - vector
			if n5.Magnitude < 0.05 then
				return fn14(CFrame.new(vector))
			end
			local v11 = math.asin(math.clamp(n5.Unit.Y, -1, 1))
			local v12 = math.atan2(-cFrame.LookVector.X, -cFrame.LookVector.Z)
			return fn14(CFrame.new(vector) * CFrame.fromOrientation(v11, v12, 0))
		end

		if str == "Custom" then
			return fn14(fn24(position + Vector3.new(n, n2, n3), position))
		end
		local position2 = (cFrame * CFrame.new(n, n2, n3)).Position
		return fn14(fn24(position2, Vector3.new(position.X, position2.Y, position.Z)))
	end

	tbl5 = {}
	local playerScripts = localPlayer:FindFirstChild("PlayerScripts")
	playerScripts = playerScripts and playerScripts:FindFirstChild("Client")
	playerScripts = playerScripts and playerScripts:FindFirstChild("Controllers")

	local function fn25(arg, arg2)
		if not arg2 then
			return
		end

		local ok, result = pcall(function()
			return require(arg2)
		end)

		if ok then
			tbl5[arg] = result
		end
	end

	if playerScripts then
		fn25("Inventory", playerScripts:FindFirstChild("InventoryController"))
		fn25("PlayerData", playerScripts:FindFirstChild("PlayerDataController"))
		fn25("Character", playerScripts:FindFirstChild("CharacterController"))
	end

	fn25("ItemConfig", ReplicatedStorage.Configs:FindFirstChild("ItemConfig"))
	fn25("StatTree", ReplicatedStorage.Configs:FindFirstChild("StatTreeConfig"))
	fn25("Crates", ReplicatedStorage.Configs.MapConfig:FindFirstChild("CratesConfig"))
	fn25("Gacha", ReplicatedStorage.Configs:FindFirstChild("CTGachaConfig"))
	fn25("Stats", ReplicatedStorage.Configs:FindFirstChild("StatsConfig"))

	fn16 = function(arg)
		local localCharacter = tbl5.Character and tbl5.Character.LocalCharacter

		if localCharacter and localCharacter.Inventory then
			local ok, result = pcall(function()
				return localCharacter.Inventory:GetItemCount(arg)
			end)

			if ok and tonumber(result) then
				return tonumber(result)
			end
		end

		return nil
	end

	fn17 = function(arg, arg2)
		local tbl6 = {}
		local flag = false

		local function fn26(arg3)
			if type(arg3) ~= "string" then
				return
			end
			tbl6[arg2 and arg2[arg3] or arg3] = true
			flag = true
		end

		arg = arg and arg.Value

		if type(arg) == "table" then
			for k, v11 in pairs(arg) do
				if v11 == true and type(k) == "string" then
					fn26(k)
				elseif type(v11) == "string" then
					fn26(v11)
				end
			end
		elseif type(arg) == "string" then
			fn26(arg)
		end

		return tbl6, flag
	end

	fn18 = function()
		local currentInventory = tbl5.Inventory and tbl5.Inventory.CurrentInventory
		return currentInventory and currentInventory.Items or nil
	end

	fn19 = function()
		local currentInventory = tbl5.Inventory and tbl5.Inventory.CurrentInventory
		if not currentInventory or not currentInventory.GetSupply then
			return 0
		end

		local ok, result = pcall(function()
			return currentInventory:GetSupply("StatPoints")
		end)

		return ok and result and result.Count or 0
	end

	pcall(function()
		tbl3 = fn6()
	end)

	fn3(task.spawn(function()
		while true do
			task.wait(0.5)

			pcall(function()
				tbl3 = fn6()
			end)
		end
	end))

	v6, v7, v, v8, v9 = loadstring(game:HttpGet("https://raw.githubusercontent.com/gilgameshfate59/ohbfoosk8tid/main/CitraUI.lua"))().Shim:Init({
		Name = "Citra Hub",
		SubName = "Jujutsu: Zero",
		Logo = "95077438762744",
		Accent = Color3.fromRGB(255, 138, 32),
		ShowTabIcons = false,
	})

	v10 = v6:CreateWindow({ Title = "Citra Hub ", Center = true, AutoShow = true, TabPaddingX = 8, MenuFadeTime = 0.2 })
	v6.ToggleKeybind = Enum.KeyCode.RightShift
	local Main = v10:AddTab("Main")
	local v11 = Main:AddLeftGroupbox("Mob Farm")
	local v12 = Main:AddLeftGroupbox("Boss Farm")
	local Combat = Main:AddRightGroupbox("Combat")
	local v13 = Main:AddRightGroupbox("Farm Position")

	local function fn26(arg, arg2, arg3)
		tbl3 = fn6()
		local tbl6 = { "Closest" }
		local tbl7 = {}
		local n = 0

		for _, v14 in ipairs(tbl3) do
			local v15, v16 = fn13(v14)

			if v15 == arg and v16.HP > 0 then
				n += 1

				if not tbl7[v16.Name] then
					tbl7[v16.Name] = true
					table.insert(tbl6, v16.Name)
				end
			end
		end

		table.sort(tbl6)

		if arg2 then
			arg2:SetValues(tbl6)
		end

		v6:Notify(("Found %d %s (%d types)."):format(n, arg3, #tbl6 - 1), 3)
	end

	v11:AddToggle("MobFarm", {
		Text = "Enable Mob Farm",
		Default = false,
		Tooltip = "Teleports to the selected mob and holds your Farm Position offsets.",
	})

	v11:AddDropdown("SelectMob", { Values = { "Closest" }, Default = 1, Multi = false, Text = "Select Mob" })

	v11:AddButton({
		Text = "Refresh Mobs",
		Func = function()
			fn26("mob", v.SelectMob, "mobs")
		end,
	})

	v12:AddToggle("BossFarm", {
		Text = "Enable Boss Farm",
		Default = false,
		Tooltip = "Same as Mob Farm but only targets bosses. Overrides Mob Farm while on.",
	})

	v12:AddDropdown("SelectBoss", { Values = { "Closest" }, Default = 1, Multi = false, Text = "Select Boss" })

	v12:AddButton({
		Text = "Refresh Bosses",
		Func = function()
			fn26("boss", v.SelectBoss, "bosses")
		end,
	})

	v12:AddSlider("BossHPThreshold", { Text = "Boss Min HP", Default = 1000000, Min = 1000, Max = 50000000, Rounding = 0 })
	local tbl6 = { ID = "Punch", Args = { 1, 1 } }

	local function fn27()
		local playerData = tbl5.PlayerData and tbl5.PlayerData.PlayerData
		local blackFlashSkill = playerData and playerData.Flags and playerData.Flags.BlackFlashSkill
		if type(blackFlashSkill) == "string" and string.match(blackFlashSkill, "^BlackFlashSkill%d+$") then
			return blackFlashSkill
		end
		return nil
	end

	local function fn28()
		if (v.AuraSkill and v.AuraSkill.Value or "Punch") == "Black Flash" then
			local v14 = fn27()

			if v14 then
				local n = tonumber(string.match(v14, "(%d+)$")) or 1
				local tbl7 = { n }

				if n >= 2 then
					tbl7[#tbl7 + 1] = {}
				end

				return { ID = v14, Args = tbl7 }
			end

			return tbl6
		end

		return tbl6
	end

	Combat:AddToggle("KillAura", {
		Text = "Kill Aura",
		Default = false,
		Tooltip = "Damages every NPC in range. Fires as fast as the client allows.",
	})

	local function fn29()
		local tbl7 = { "Punch" }

		if fn27() then
			tbl7[#tbl7 + 1] = "Black Flash"
		end

		return tbl7
	end

	Combat:AddDropdown("AuraSkill", {
		Values = fn29(),
		Default = 1,
		Multi = false,
		Text = "Aura Skill",
		Tooltip = "Punch = base attack. Black Flash = your owned black flash tier (higher damage).",
	})

	Combat:AddToggle("AuraPlayers", {
		Text = "Include Players",
		Default = false,
		Tooltip = "Off = NPCs only. Quest targets are always NPCs, so leave this off for questing.",
	})

	Combat:AddSlider("AuraRange", { Text = "Aura Range", Default = 250, Min = 20, Max = 500, Rounding = 0, Suffix = " studs" })
	local v14 = nil

	fn3(task.spawn(function()
		while task.wait(3) do
			local auraSkill = v.AuraSkill

			if auraSkill then
				local flag = fn27() ~= nil

				if flag ~= v14 then
					v14 = flag
					local tbl7 = { "Punch" }

					if flag then
						tbl7[#tbl7 + 1] = "Black Flash"
					end

					pcall(function()
						auraSkill:SetValues(tbl7)
					end)
				end
			end
		end
	end))

	local Crates = Main:AddLeftGroupbox("Crates")

	Crates:AddToggle("AutoOpenCrates", {
		Text = "Auto Open Crates (Inventory)",
		Default = false,
		Tooltip = "Uses crate items from your inventory in bulk, respecting each crate's max use count.",
	})

	Crates:AddToggle("AutoGrabCrates", {
		Text = "Auto Grab Crates (World)",
		Default = false,
		Tooltip = "Travels to world crates and opens them. Filter which types below.",
	})

	local tbl7 = {}
	local tbl8 = {}
	local crates = tbl5.Crates and tbl5.Crates.Crates

	if crates then
		for k, crate in pairs(crates) do
			local str = type(crate) == "table" and crate.Name and crate.Name .. " [" .. k .. "]" or k
			tbl7[#tbl7 + 1] = str
			tbl8[str] = k
		end

		table.sort(tbl7)
	end

	table.insert(tbl7, 1, "All")

	Crates:AddDropdown("CrateFilter", {
		Values = tbl7,
		Default = {},
		Multi = true,
		Text = "Grab Which Crates",
		Tooltip = "Tick All (or nothing) to grab every type.",
	})

	local Idle = Crates:AddLabel("Idle")
	local v15 = Main:AddRightGroupbox("Auto Quest")

	v15:AddToggle("AutoQuest", {
		Text = "Auto Quest",
		Default = false,
		Tooltip = "Accepts quests in order, travels to the enemy and kills it. Runs to max level.",
	})

	local v16 = v15:AddLabel("Quest: idle")
	local Idle2 = v15:AddLabel("Idle")

	v13:AddDropdown("FarmMethod", {
		Values = { "Behind", "Above", "Below", "Custom" },
		Default = 1,
		Multi = false,
		Text = "Farm Method",
	})

	v13:AddSlider("FarmOffsetX", { Text = "Offset X", Default = 0, Min = -30, Max = 30, Rounding = 1 })
	v13:AddSlider("FarmOffsetY", { Text = "Offset Y", Default = 4, Min = -30, Max = 30, Rounding = 1 })
	v13:AddSlider("FarmOffsetZ", { Text = "Offset Z", Default = 6, Min = -30, Max = 30, Rounding = 1 })
	v13:AddSlider("FarmSmoothness", { Text = "Tween Smoothness", Default = 0.5, Min = 0.1, Max = 1, Rounding = 2 })

	fn20 = function(moveSpeedMultiplier)
		local ok, result = pcall(function()
			return require(game.Players.LocalPlayer.PlayerScripts.Client.Controllers.CharacterController)
		end)

		ok = ok and result and result.LocalCharacter
		ok = ok and ok.MovementComponent

		if ok then
			ok.MoveSpeedMultiplier = moveSpeedMultiplier
		end
	end

	fn3(task.spawn(function()
		while true do
			task.wait(0.5)

			pcall(function()
				fn20(v7.SpeedBoost and v7.SpeedBoost.Value and (v.SpeedMult and v.SpeedMult.Value or 2) or 1)
			end)
		end
	end))

	networkComm = ReplicatedStorage:WaitForChild("NetworkComm")
	local acceptQuestMethod = networkComm.QuestService.AcceptQuest_Method
	local cancelQuestMethod = networkComm.QuestService.CancelQuest_Method
	local v17 = nil

	local function fn30(arg, arg2, arg3, arg4, arg5)
		if #arg == 0 then
			return
		end
		local networkComm2 = game.ReplicatedStorage:FindFirstChild("NetworkComm")
		local skillService = networkComm2 and networkComm2:FindFirstChild("SkillService")
		networkComm2 = networkComm2 and networkComm2:FindFirstChild("CombatService")
		skillService = skillService and skillService:FindFirstChild("StartSkilll_Method")
		networkComm2 = networkComm2 and networkComm2:FindFirstChild("DamageCharacter_Method")
		if not skillService or not networkComm2 then
			return
		end
		skillService:InvokeServer(arg4, arg2, arg3.CFrame.LookVector, nil, table.unpack(arg5))

		networkComm2:InvokeServer(arg, true, {
			CanParry = true,
			Origin = arg3.CFrame,
			WindowID = arg2.Name .. "_" .. arg4,
			LocalCharacter = arg2,
			SkillID = arg4,
		})
	end

	fn3(task.spawn(function()
		while true do
			RunService.Heartbeat:Wait()

			if v7.KillAura and v7.KillAura.Value then
				pcall(function()
					local v18, v19 = fn8()
					if not v18 then
						return
					end
					local n = v.AuraRange and v.AuraRange.Value or 250
					local flag = v7.AutoQuest and v7.AutoQuest.Value and v17 ~= nil
					local v20 = fn21(v7.AuraPlayers and v7.AuraPlayers.Value)
					local tbl9 = {}

					for _, v21 in ipairs(fn6()) do
						if not flag or v21:FindFirstChild("QuestNPCOutline") then
							local v22 = fn5(v21)

							if v22 and (v22.Position - v19.Position).Magnitude <= n then
								local v23 = fn22(v22.Position, v20)

								if v23 then
									tbl9[#tbl9 + 1] = v23
								end
							end
						end
					end

					local v21 = fn28()
					fn30(tbl9, v18, v19, v21.ID, v21.Args)
				end)
			end
		end
	end))

	local tbl9 = {}

	local ok, result = pcall(function()
		return require(ReplicatedStorage.Configs.QuestConfig.Quests.NPCDialogue)
	end)

	if ok and type(result) == "table" then
		for k, v18 in pairs(result) do
			if type(v18) == "table" and v18.Type == "Enemies" and v18.EnemyID then
				tbl9[#tbl9 + 1] = {
					ID = k,
					Level = type(v18.Requirements) == "table" and tonumber(v18.Requirements.Level) or 0,
					Enemy = v18.EnemyID,
					Count = tonumber(v18.EnemyCount) or 1,
					Name = v18.Name,
					AreaID = v18.QuestAreaID,
				}
			end
		end

		table.sort(tbl9, function(arg, arg2)
			return arg.Level < arg2.Level
		end)
	end

	local tbl10 = {}

	for _, child in ipairs(ReplicatedStorage.Configs.NPCConfig.NPCs:GetChildren()) do
		local ok2, result2 = pcall(function()
			return require(child)
		end)

		if ok2 and type(result2) == "table" then
			for k, v18 in pairs(result2) do
				if type(v18) == "table" and v18.Name then
					tbl10[k] = v18.Name
				end
			end
		end
	end

	local function fn31(arg)
		if not arg then
			return nil
		end
		local container = Workspace:FindFirstChild("Container")
		container = container and container:FindFirstChild("QuestAreas")
		if not container then
			return nil
		end

		for _, child in ipairs(container:GetChildren()) do
			for _, child2 in ipairs(child:GetChildren()) do
				if child2:GetAttribute("AreaID") ~= arg then
					continue
				end
				local waypoint = child2:FindFirstChild("Waypoint")
				if waypoint and waypoint:IsA("BasePart") then
					return waypoint.CFrame
				end
				local spawns = child2:FindFirstChild("Spawns")
				spawns = spawns and spawns:FindFirstChildWhichIsA("BasePart", true)
				if spawns then
					return spawns.CFrame
				end
				local basePart = child2:FindFirstChildWhichIsA("BasePart", true)
				if basePart then
					return basePart.CFrame
				end
			end
		end

		return nil
	end

	local function fn32()
		return v17 and (tbl10[v17.Enemy] or v17.Enemy) or nil
	end

	local v18 = nil

	local function fn33()
		if v18 and v18.Parent then
			local v19 = string.match(v18.Text or "", "^Level%s+(%d+)$")
			if v19 then
				return tonumber(v19)
			end
		end

		for _, descendant in ipairs(localPlayer.PlayerGui:GetDescendants()) do
			if descendant:IsA("TextLabel") then
				local v19 = string.match(descendant.Text or "", "^Level%s+(%d+)$")
				if v19 then
					v18 = descendant
					return tonumber(v19)
				end
			end
		end

		return nil
	end

	local function fn34(arg, arg2)
		if not arg then
			v16:SetText("Quest: idle")
			Idle2:SetText(arg2 or "Idle")
			return
		end

		v16:SetText(("Quest: [Lv.%d] %s"):format(arg.Level or 0, arg.Name and arg.Name ~= "Defeat" and arg.Name or arg.ID))
		local setText = Idle2.SetText
		local v19 = Idle2

		if not arg2 then
			arg2 = ("Defeat %s x%d"):format(tostring(fn32()), arg.Count or 1)
		end

		setText(v19, arg2)
	end

	local function fn35()
		local text = nil

		for _, descendant in ipairs(localPlayer.PlayerGui:GetDescendants()) do
			if descendant:IsA("TextLabel") and descendant.Text and string.match(descendant.Text, "^Defeat .+%(%d+/%d+%)") then
				text = descendant.Text
				break
			else
				text = nil
			end
		end

		if not text then
			return false
		end
		local v19, v20 = string.match(text, "%((%d+)/(%d+)%)")
		local num = tonumber(v20)

		for _, v21 in ipairs(tbl9) do
			local enemy = tbl10[v21.Enemy] or v21.Enemy

			if enemy and string.find(text, enemy, 1, true) and v21.Count == num then
				v17 = v21
				fn34(v21, "Resumed in-progress quest")
				return true
			end
		end

		return false
	end

	local function fn36()
		local v19 = fn33()
		local tbl11 = {}

		for _, v20 in ipairs(tbl9) do
			if not v19 or v20.Level <= v19 then
				tbl11[#tbl11 + 1] = v20
			end
		end

		table.sort(tbl11, function(arg, arg2)
			return arg.Level > arg2.Level
		end)

		for _, v20 in ipairs(tbl11) do
			if fn31(v20.AreaID) then
				local ok2, result2 = pcall(function()
					return acceptQuestMethod:InvokeServer(v20.ID)
				end)

				if ok2 and result2 then
					v17 = v20
					fn34(v20)
					return true
				end
			end
		end

		v17 = nil
		fn34(nil, v19 and "No quest available at Lv." .. v19 .. " - retrying" or "Waiting for level - retrying")
		return false
	end

	fn2(networkComm.QuestService.QuestFinished_Signal.OnClientEvent:Connect(function()
		if not (v7.AutoQuest and v7.AutoQuest.Value) then
			return
		end
		v17 = nil
	end))

	local flag = false

	fn3(task.spawn(function()
		while task.wait(2) do
			if not (v7.AutoQuest and v7.AutoQuest.Value) then
				if flag then
					flag = false
					v3 = nil
					v17 = nil
					fn34(nil, "Stopped")
				end
			else
				if not flag then
					flag = true

					if not v17 then
						pcall(fn35)
					end
				end

				local ok2, result2 = pcall(function()
					if not v17 then
						fn36()
					end

					if not v17 then
						return
					end
					local v19 = fn10()
					if not v19 then
						return
					end
					local v20 = fn32()
					local huge = math.huge
					local v21 = nil

					for _, v22 in ipairs(fn6()) do
						local v23 = fn12(v22)

						if v23 and v23.HP > 0 and not v23.IsPlayer and (v22:FindFirstChild("QuestNPCOutline") or v23.Name == v20) then
							local v24 = fn5(v22)

							if v24 then
								local magnitude = (v24.Position - v19.Position).Magnitude

								if magnitude < huge then
									huge = magnitude
									v21 = v24
								end
							end
						end
					end

					if v21 then
						v3 = fn15(v21)
						local floor = math.floor
						fn34(v17, ("Fighting %s (%d studs)"):format(tostring(v20), floor(huge)))
					else
						local v22 = fn31(v17.AreaID)

						if v22 then
							v3 = fn15(v22)
							fn34(v17, ("Travelling to %s spawn area"):format(tostring(v20)))
						else
							v3 = nil
							fn34(v17, "Unreachable area - skipping")

							pcall(function()
								cancelQuestMethod:InvokeServer(v17.ID)
							end)

							v17 = nil
							fn36()
						end
					end
				end)

				if not ok2 then
					Idle2:SetText("Error: " .. tostring(result2):sub(1, 60))
				end
			end
		end
	end))

	local openCrateMethod = networkComm.MapService.OpenCrate_Method

	local function fn37(arg)
		local items = tbl5.ItemConfig and tbl5.ItemConfig.Items
		items = items and items[arg]
		if items and items.ConsumableType == "Crate" then
			return items
		end
		return nil
	end

	fn3(task.spawn(function()
		while task.wait(2) do
			if v7.AutoOpenCrates and v7.AutoOpenCrates.Value then
				pcall(function()
					local v19 = fn18()
					if not (v19 and tbl5.Inventory) then
						return
					end
					local n = 0

					for _, v20 in pairs(v19) do
						if type(v20) == "table" and v20.ConfigID then
							local v21 = fn37(v20.ConfigID)

							if v21 then
								local n2 = math.max(1, math.min(tonumber(v20.Count) or 1, tonumber(v21.MaxUseCount) or 1))

								if pcall(function()
									tbl5.Inventory:UseItem(v20.ID, n2)
								end) then
									n += n2
								end

								task.wait(tbl5.ItemConfig and tbl5.ItemConfig.ItemUseCooldown or 0.5)
							end
						end
					end

					if n > 0 then
						Idle:SetText(("Opened %d crate(s)"):format(n))
					end
				end)
			end
		end
	end))

	local function fn38()
		local ok2, result2 = pcall(function()
			return require(game.Players.LocalPlayer.PlayerScripts.Client.Controllers.InterfaceController.Interfaces.Interact)
		end)

		return ok2 and type(result2) == "table" and result2.Interacted and result2 or nil
	end

	local function fn39(arg)
		return arg and arg:FindFirstChildWhichIsA("ProximityPrompt", true)
	end

	local function fn40(arg)
		local v19 = fn39(arg)
		local v20 = v19 and fn38()

		if v20 then
			if pcall(function()
				v20.Interacted:Fire(v19)
			end) then
				return "prompt"
			end
		end

		pcall(function()
			openCrateMethod:InvokeServer(arg.Name)
		end)

		return "remote"
	end

	fn3(task.spawn(function()
		local flag2 = false

		while task.wait(0.5) do
			if not (v7.AutoGrabCrates and v7.AutoGrabCrates.Value) then
				v4 = nil
				flag2 = false
			else
				pcall(function()
					local map = Workspace:FindFirstChild("Map")
					map = map and map:FindFirstChild("ActiveCrates")
					local v19 = fn10()
					if not (map and v19) then
						return
					end
					local v20, flag3 = fn17(v.CrateFilter, tbl8)

					if v20.All then
						flag3 = false
					end

					local n = tbl5.Crates and tonumber(tbl5.Crates.MaxOpenDistance) or 25
					local tbl11 = {}
					local n2 = 0
					local v21 = nil
					local v22 = nil

					for _, child in ipairs(map:GetChildren()) do
						local name = child:IsA("BasePart") and (string.match(child.Name, "^([^_]+)") or child.Name)
						local v23 = name and fn39(child)

						if v23 and (not flag3 or v20[name]) then
							n2 += 1
							local magnitude = (child.Position - v19.Position).Magnitude

							if magnitude <= math.min(n, tonumber(v23.MaxActivationDistance) or n) * 0.8 then
								fn40(child)
								tbl11[#tbl11 + 1] = child.Name
							elseif not v21 or magnitude < v21 then
								v21 = magnitude
								v22 = child
							end
						end
					end

					if n2 == 0 then
						v4 = nil
						Idle:SetText("No active crates")

						if flag2 then
							v6:Notify("No active crates", 3)
						end

						flag2 = false
						return
					end

					flag2 = true

					if #tbl11 > 0 then
						Idle:SetText(("Opened %d (%s) - %d left"):format(#tbl11, tbl11[1], n2 - #tbl11))
					end

					if v22 then
						v4 = fn15(v22.CFrame)

						if #tbl11 == 0 then
							Idle:SetText(("Travelling to %s (%d studs, %d left)"):format(v22.Name, math.floor(v21), n2))
						end
					else
						v4 = nil
					end
				end)
			end
		end
	end))
end

local tbl6 = { mob = {}, boss = {} }

fn3(task.spawn(function()
	while task.wait(2) do
		for k, v11 in pairs({ mob = v.SelectMob, boss = v.SelectBoss }) do
			if v11 then
				local tbl7 = { "Closest" }
				local tbl8 = {}

				for _, v12 in ipairs(tbl3) do
					local v13, v14 = fn13(v12)

					if v13 == k and not tbl8[v14.Name] then
						tbl8[v14.Name] = true
						table.insert(tbl7, v14.Name)
					end
				end

				table.sort(tbl7)

				if not fn(tbl7, tbl6[k]) then
					tbl6[k] = tbl7
					v11:SetValues(tbl7)
				end
			end
		end
	end
end))

local function fn21(arg)
	local v11 = fn10()
	if not v11 then
		return nil
	end
	local selectBoss = arg == "boss" and v.SelectBoss or v.SelectMob
	selectBoss = selectBoss and selectBoss.Value or "Closest"
	local huge = math.huge
	local v12 = nil

	for _, v13 in ipairs(tbl3) do
		local v14, v15 = fn13(v13)

		if v14 == arg and v15.HP > 0 then
			if selectBoss == "Closest" or string.find(string.lower(v15.Name), string.lower(selectBoss), 1, true) then
				local v16 = fn5(v13)

				if v16 then
					local magnitude = (v11.Position - v16.Position).Magnitude

					if magnitude < huge then
						huge = magnitude
						v12 = v13
					end
				end
			end
		end
	end

	return v12
end

fn3(task.spawn(function()
	while task.wait() do
		local str = v7.BossFarm and v7.BossFarm.Value and "boss" or v7.MobFarm and v7.MobFarm.Value and "mob" or nil

		if not str then
			v2 = nil
		else
			local v11 = fn21(str)
			v2 = v11 and fn15(v11:FindFirstChild("HumanoidRootPart")) or nil
		end
	end
end))

local fn22

do
	local v11 = nil
	local v12 = nil

	local function fn23()
		if v12 and v12.Parent and v11 and v11.Parent then
			return v12
		end
		local v13, v14 = fn8()
		v11 = v13
		v12 = v14
		return v12
	end

	local cFrame = nil
	local tbl7 = {}

	fn22 = function()
		if not next(tbl7) then
			return
		end

		for k, v13 in pairs(tbl7) do
			if k and k.Parent then
				pcall(function()
					k.CanCollide = v13
				end)
			end
		end

		table.clear(tbl7)
	end

	local function fn24(arg)
		if not arg then
			return
		end

		for _, child in ipairs(arg:GetChildren()) do
			if child:IsA("BasePart") and child.CanCollide then
				if tbl7[child] == nil then
					tbl7[child] = child.CanCollide
				end

				child.CanCollide = false
			end
		end
	end

	task.spawn(function()
		task.wait(1)

		pcall(function()
			local v13
			v13, v13 = fn8()

			if v13 and not v13.CanCollide then
				v13.CanCollide = true
			end
		end)
	end)

	fn2(RunService.RenderStepped:Connect(function(deltaTime)
		local v13 = fn23()
		if not v13 then
			fn22()
			return
		end

		if v13.Position.Y < -500 and cFrame then
			v13.AssemblyLinearVelocity = Vector3.zero
			v13.CFrame = cFrame
			return
		end

		if v13.Position.Y > -500 then
			cFrame = v13.CFrame
		end

		if v7.Fly and v7.Fly.Value then
			local lookVector = currentCamera.CFrame.LookVector
			local vector = Vector3.new(lookVector.X, 0, lookVector.Z)
			local unit = vector.Magnitude > 0.01 and vector.Unit or Vector3.new(0, 0, -1)
			local v14 = unit:Cross(Vector3.new(0, 1, 0))
			local vector2 = Vector3.new()

			if UserInputService:IsKeyDown(Enum.KeyCode.W) then
				vector2 += unit
			end

			if UserInputService:IsKeyDown(Enum.KeyCode.S) then
				vector2 -= unit
			end

			if UserInputService:IsKeyDown(Enum.KeyCode.D) then
				vector2 += v14
			end

			if UserInputService:IsKeyDown(Enum.KeyCode.A) then
				vector2 -= v14
			end

			if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
				vector2 += Vector3.new(0, 1, 0)
			end

			if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
				vector2 -= Vector3.new(0, 1, 0)
			end

			if vector2.Magnitude > 0 then
				vector2 = vector2.Unit
			end

			local n = v.FlySpeed and v.FlySpeed.Value or 100
			fn24(v13.Parent)
			v13.CFrame = v13.CFrame + vector2 * n * math.clamp(deltaTime, 0, 0.1)
			v13.AssemblyLinearVelocity = Vector3.zero
			v13.AssemblyAngularVelocity = Vector3.zero

			if v13.Position.Y > -500 then
				cFrame = v13.CFrame
			end

			return
		end

		local v14 = fn14(v5 or v2 or v3 or v4)

		if not v14 then
			if v7.Noclip and v7.Noclip.Value then
				fn24(v13.Parent)
			else
				fn22()
			end

			return
		end

		fn24(v13.Parent)
		local n = 1 - math.exp(-(22 - (math.clamp(v.FarmSmoothness and v.FarmSmoothness.Value or 0.5, 0.1, 1) * 10 - 1) * 1.8) * math.clamp(deltaTime, 0, 0.1))
		local v15 = fn14((v13.Position - v14.Position).Magnitude > 100 and v14 or v13.CFrame:Lerp(v14, math.clamp(n, 0.05, 1)))
		if not v15 then
			return
		end
		v13.CFrame = v15
		v13.AssemblyLinearVelocity = Vector3.zero
		v13.AssemblyAngularVelocity = Vector3.zero
	end))
end

do
	local Character = v10:AddTab("Character")
	local v11 = Character:AddLeftGroupbox("Stat Upgrades")
	local v12 = Character:AddRightGroupbox("Auto Equip")
	local tbl7 = { "Offense", "Sorcery", "Vitality" }
	v11:AddToggle("AutoOffense", { Text = "Auto Upgrade Offense", Default = false })
	v11:AddToggle("AutoSorcery", { Text = "Auto Upgrade Sorcery", Default = false })
	v11:AddToggle("AutoVitality", { Text = "Auto Upgrade Vitality", Default = false })

	v11:AddToggle("AutoAllNodes", {
		Text = "Auto Upgrade All Nodes",
		Default = false,
		Tooltip = "Runs all three trees. Overrides the individual toggles.",
	})

	local v13 = v11:AddLabel("Stat Points: -")

	v12:AddToggle("AutoEquipBest", {
		Text = "Auto Equip Best Gear",
		Default = false,
		Tooltip = "Uses the game's own best-item ranking, then equips up to each type's limit. This WILL replace anything you equipped by hand.",
	})

	v12:AddSlider("EquipInterval", { Text = "Recheck Every", Default = 15, Min = 5, Max = 120, Rounding = 0, Suffix = "s" })
	local Idle = v12:AddLabel("Idle")
	local Movement = Character:AddRightGroupbox("Movement")

	Movement:AddToggle("Fly", {
		Text = "Fly",
		Default = false,
		Tooltip = "WASD to move (camera-relative), Space = up, LeftCtrl = down. Noclips while on.",
	}):AddKeyPicker("FlyKey", { Default = "V", Text = "Fly" })

	Movement:AddSlider("FlySpeed", { Text = "Fly Speed", Default = 100, Min = 20, Max = 500, Rounding = 0, Suffix = " s/s" })

	Movement:AddToggle("Noclip", {
		Text = "Noclip",
		Default = false,
		Tooltip = "Walk through walls. Turning it off restores collision.",
	}):AddKeyPicker("NoclipKey", { Default = "N", Text = "Noclip" })

	Movement:AddToggle("SpeedBoost", {
		Text = "Speed Boost",
		Default = false,
		Tooltip = "Multiplies the game's own walk speed via MovementComponent.MoveSpeedMultiplier -- applied by the game itself, no fighting.",
	}):AddKeyPicker("BoostKey", { Default = "G", Text = "Speed Boost" })

	Movement:AddSlider("SpeedMult", { Text = "Speed Multiplier", Default = 2, Min = 1, Max = 5, Rounding = 1 })

	local function fn23(arg, arg2)
		local v14 = v[arg]

		if v14 and v14.OnClick then
			v14:OnClick(function()
				local v15 = v7[arg2]

				if v15 then
					pcall(function()
						v15:SetValue(not v15.Value)
					end)
				end
			end)
		end
	end

	fn23("FlyKey", "Fly")
	fn23("NoclipKey", "Noclip")
	fn23("BoostKey", "SpeedBoost")
	local v14 = Character:AddLeftGroupbox("Auto Summon")
	local ctGachaService = networkComm.CTGachaService
	local tbl8 = {}
	local tbl9 = {}
	local tbl10 = {}
	local tbl11 = {}

	v14:AddToggle("AutoSummon", {
		Text = "Auto Summon",
		Default = false,
		Tooltip = "Pulls the banner featuring your target until you get it. Spends Lumen -- pulls are permanent.",
	})

	v14:AddDropdown("SummonTarget", {
		Values = {},
		Default = {},
		Multi = true,
		AllowNull = true,
		Text = "Target Technique",
		Tooltip = "Pick one or more. Everything the 3 live banners can drop; updates when they rotate. Stops once you own them all.",
	})

	v14:AddDropdown("SummonSize", {
		Values = { "x1", "x10", "x100" },
		Default = 2,
		Multi = false,
		Text = "Pull Size",
		Tooltip = "Same rate per pull -- bigger is only faster, and overshoots more.",
	})

	v14:AddSlider("LumenReserve", { Text = "Keep Lumen Above", Default = 0, Min = 0, Max = 200000, Rounding = 0 })
	local Idle2 = v14:AddLabel("Idle")

	local function fn24(arg)
		local stats = tbl5.Stats
		local grades = stats and stats.Grades and stats.Grades[arg]
		local name = type(grades) == "table" and grades.Name or nil
		if not name then
			return "R" .. tostring(arg or "?")
		end
		local v15 = string.match(name, "^Grade%s+(%d+)$")
		if v15 then
			return "G" .. v15
		end
		local str = ""

		for match in string.gmatch(name, "%a+") do
			str ..= string.upper(string.sub(match, 1, 1))
		end

		return str ~= "" and str or string.sub(name, 1, 2)
	end

	local function fn25()
		local gacha = tbl5.Gacha
		local itemConfig = tbl5.ItemConfig
		if not (gacha and itemConfig) then
			return
		end

		local ok, result = pcall(function()
			local response, v15 = ctGachaService.GetCurrentTimeline_Method:InvokeServer()
			return type(response) == "table" and response or v15
		end)

		if not ok or type(result) ~= "table" or type(result.BannerIDs) ~= "table" then
			return
		end
		local tbl12 = {}
		local tbl13 = {}
		local tbl14 = {}

		for _, bannerID in pairs(result.BannerIDs) do
			local banners = gacha.Banners and gacha.Banners[bannerID]

			if banners then
				for _, v15 in ipairs({ banners.Featured, banners.Standard }) do
					if type(v15) == "table" then
						for k, v16 in pairs(v15) do
							local n = tonumber(v16) or 0

							if not tbl12[k] or n > tbl12[k] then
								tbl12[k] = n
								tbl13[k] = bannerID
							end
						end
					end
				end
			end
		end

		local tbl15 = {}
		local tbl16 = {}
		local tbl17 = {}
		local tbl18 = {}

		for k in pairs(tbl12) do
			local rarity = itemConfig.Items[k]
			local name = rarity and rarity.Name or k
			rarity = rarity and rarity.Rarity
			local str = fn24(rarity) .. " " .. name
			tbl15[#tbl15 + 1] = str
			tbl16[str] = tbl13[k]
			tbl17[str] = k
			tbl18[str] = tbl12[k]
			tbl14[str] = tonumber(rarity) or 0
		end

		tbl11 = tbl18

		table.sort(tbl15, function(arg, arg2)
			if tbl14[arg] ~= tbl14[arg2] then
				return tbl14[arg] > tbl14[arg2]
			end
			return arg < arg2
		end)

		tbl8 = tbl15
		tbl9 = tbl16
		tbl10 = tbl17

		if v.SummonTarget then
			pcall(function()
				v.SummonTarget:SetValues(tbl15)
			end)
		end
	end

	task.spawn(function()
		task.wait(2)
		pcall(fn25)
	end)

	fn2(ctGachaService.TimelineChanged_Signal.OnClientEvent:Connect(function()
		task.wait(1)
		pcall(fn25)
	end))

	local tbl12 = nil

	fn3(task.spawn(function()
		local n = 0

		while task.wait(1.5) do
			if not (v7.AutoSummon and v7.AutoSummon.Value) then
				n = 0
				tbl12 = nil
			else
				local ok, result = pcall(function()
					local gacha = tbl5.Gacha
					local v15 = fn17(v.SummonTarget, nil)
					local tbl13 = {}

					for k in pairs(v15) do
						tbl13[#tbl13 + 1] = k
					end

					if #tbl13 == 0 then
						Idle2:SetText("Pick a target technique")
						return
					end

					if not tbl12 then
						tbl12 = {}

						for _, v16 in ipairs(tbl13) do
							local v17 = tbl10[v16]

							if v17 then
								tbl12[v17] = fn16(v17) or 0
							end
						end
					end

					for _, v16 in ipairs(tbl13) do
						local v17 = tbl10[v16]
						local v18 = v17 and tbl12[v17]
						local v19 = v17 and fn16(v17)

						if v17 and v18 and v19 and v19 > v18 then
							Idle2:SetText(("GOT %s after %d Lumen"):format(v16, n))

							pcall(function()
								v7.AutoSummon:SetValue(false)
							end)

							pcall(function()
								v6:Notify(("Auto Summon: got %s after %d Lumen!"):format(v16, n), 10)
							end)

							return
						end
					end

					local tbl14 = {}

					for _, v16 in ipairs(tbl13) do
						if tbl10[v16] then
							tbl14[#tbl14 + 1] = v16
						end
					end

					local n2 = -1
					local v16 = nil

					for _, v17 in ipairs(tbl14) do
						if tbl9[v17] then
							local n3 = tonumber(tbl11[v17]) or 0

							if n2 < n3 then
								n2 = n3
								v16 = v17
							end
						end
					end

					if not v16 then
						Idle2:SetText(("%d target(s) not featured now - waiting for rotation"):format(#tbl14))
						pcall(fn25)
						return
					end

					local v17 = tbl9[v16]
					local n3 = ({ x1 = 1, x10 = 10, x100 = 100 })[v.SummonSize and v.SummonSize.Value or "x10"] or 10
					local banners = gacha.Banners and gacha.Banners[v17]
					local str = "Lumen"
					local pullCost = gacha.PullCost

					if banners and type(banners.PullCost) == "table" then
						str = banners.PullCost[1]
						pullCost = banners.PullCost[2]
					end

					local n4 = (tonumber(pullCost) or 350) * n3
					local n5 = fn16(str) or 0
					local n6 = v.LumenReserve and v.LumenReserve.Value or 0
					if n5 - n4 < n6 then
						Idle2:SetText(("Need %d %s (have %d, reserve %d)"):format(n4, str, n5, n6))
						return
					end
					ctGachaService.Pull_Method:InvokeServer(v17, n3)
					n += n4
					task.wait(1)

					for _, v18 in ipairs(tbl13) do
						local v19 = tbl10[v18]
						local v20 = v19 and tbl12[v19]
						local v21 = v19 and fn16(v19)

						if v19 and v20 and v21 and v21 > v20 then
							Idle2:SetText(("GOT %s after %d %s"):format(v18, n, str))

							pcall(function()
								v7.AutoSummon:SetValue(false)
							end)

							pcall(function()
								v6:Notify(("Auto Summon: got %s after %d %s!"):format(v18, n, str), 10)
							end)

							return
						end
					end

					Idle2:SetText(("%s x%d | spent %d %s"):format(v16, n3, n, str))
				end)

				if not ok then
					Idle2:SetText("Error: " .. tostring(result):sub(1, 50))
				end
			end
		end
	end))

	local v15 = Character:AddRightGroupbox("Auto Sell")
	local tbl13 = {}
	local tbl14 = {}

	local ok, result = pcall(function()
		return require(ReplicatedStorage.Configs.StatsConfig)
	end)

	ok = ok and result and result.Grades

	for i = 1, 8 do
		local v16 = ok and ok[i]
		local name = type(v16) == "table" and v16.Name and v16.Name or "Rarity " .. i

		if tbl14[name] then
			name ..= " (" .. i .. ")"
		end

		tbl13[#tbl13 + 1] = name
		tbl14[name] = i
	end

	v15:AddToggle("AutoSell", {
		Text = "Auto Sell",
		Default = false,
		Tooltip = "Sells unequipped, unlocked GEAR of the selected grades. Selling is permanent.",
	})

	v15:AddDropdown("SellRarities", {
		Values = tbl13,
		Default = {},
		Multi = true,
		Text = "Sell These Grades",
		Tooltip = "Nothing is sold until you tick at least one grade.",
	})

	local Idle3 = v15:AddLabel("Idle")

	fn3(task.spawn(function()
		while task.wait(5) do
			if v7.AutoSell and v7.AutoSell.Value then
				local ok2, result2 = pcall(function()
					local v16 = fn18()
					local itemConfig = tbl5.ItemConfig
					if not (v16 and itemConfig and tbl5.Inventory) then
						Idle3:SetText("Inventory unavailable")
						return
					end
					local v17, v18 = fn17(v.SellRarities, tbl14)

					if not v18 then
						local value = v.SellRarities and v.SellRarities.Value
						local kind = type(value)

						if type(value) == "table" then
							local tbl15 = {}

							for k, v19 in pairs(value) do
								if #tbl15 < 3 then
									tbl15[#tbl15 + 1] = tostring(k) .. ":" .. tostring(v19)
								end
							end

							kind = "table{" .. table.concat(tbl15, ",") .. "}"
						elseif value ~= nil then
							kind ..= "(" .. tostring(value) .. ")"
						end

						Idle3:SetText("Pick a grade - value=" .. kind)
						return
					end

					local tbl15 = {}
					local bestEquipItems = itemConfig.GetBestEquipItems and itemConfig:GetBestEquipItems(v16, tbl5.PlayerData.PlayerData)

					if type(bestEquipItems) == "table" then
						for _, bestEquipItem in ipairs(bestEquipItems) do
							tbl15[bestEquipItem.ID] = true
						end
					end

					local tbl16 = {}
					local n = 0

					for _, v19 in pairs(v16) do
						if type(v19) == "table" and v19.ConfigID and not v19.Equipped and not v19.Locked and not tbl15[v19.ID] then
							local v20 = itemConfig.Items[v19.ConfigID]

							if v20 and v20.Type == "Gear" and v17[v20.Rarity] then
								tbl16[#tbl16 + 1] = v19.ID
								n += 1
							end
						end
					end

					if n == 0 then
						Idle3:SetText("Nothing to sell")
						return
					end
					networkComm.InventoryService.SellItems_Method:InvokeServer(tbl16)
					Idle3:SetText(("Sold %d item(s)"):format(n))
				end)

				if not ok2 then
					Idle3:SetText("Error: " .. tostring(result2):sub(1, 50))
				end
			end
		end
	end))

	local unlockNodeMethod = networkComm.StatTreeService.UnlockNode_Method
	local tbl15 = {}

	local function fn26(arg)
		if tbl15[arg] then
			return tbl15[arg]
		end
		local trees = tbl5.StatTree and tbl5.StatTree.Trees
		trees = trees and trees[arg]
		local nodes = trees and trees.Nodes
		if not nodes then
			return {}
		end

		local function fn27(arg2)
			local tbl16 = {}
			local v16 = ipairs
			local nextNodes = arg2.NextNodes or {}

			for _, nextNode in v16(nextNodes) do
				if type(nextNode) == "string" then
					tbl16[#tbl16 + 1] = nextNode
				elseif type(nextNode) == "table" and nextNode.ID then
					tbl16[#tbl16 + 1] = nextNode.ID
				end
			end

			return tbl16
		end

		local tbl16 = {}
		local tbl17 = { trees.StartNode }
		local tbl18 = { [trees.StartNode] = true }

		while #tbl17 > 0 do
			local v16 = nodes[table.remove(tbl17, 1)]

			if v16 then
				tbl16[#tbl16 + 1] = v16
				local v17 = ipairs
				local v18 = fn27(v16)

				for _, v19 in v17(v18) do
					if not tbl18[v19] then
						tbl18[v19] = true
						tbl17[#tbl17 + 1] = v19
					end
				end
			end
		end

		for k, node in pairs(nodes) do
			if not tbl18[k] then
				tbl16[#tbl16 + 1] = node
			end
		end

		tbl15[arg] = tbl16
		return tbl16
	end

	local function fn27(arg, arg2)
		local v16 = fn26(arg)
		if #v16 == 0 then
			return 0, arg2
		end
		local n = 0

		for _, v17 in ipairs(v16) do
			if not (arg2 <= 0) then
				local n2 = tonumber(v17.StatPointCost) or 0

				if n2 > 0 and n2 <= arg2 then
					local ok2, result2 = pcall(function()
						return unlockNodeMethod:InvokeServer(arg, v17.ID)
					end)

					if ok2 and result2 then
						arg2 -= n2
						n += 1
					end

					task.wait(0.05)
				end

				continue
			end

			break
		end

		return n, arg2
	end

	fn3(task.spawn(function()
		while task.wait(3) do
			local value = v7.AutoAllNodes and v7.AutoAllNodes.Value
			local tbl16 = {}

			if value then
				tbl16 = tbl7
			else
				if v7.AutoOffense and v7.AutoOffense.Value then
					tbl16[#tbl16 + 1] = "Offense"
				end

				if v7.AutoSorcery and v7.AutoSorcery.Value then
					tbl16[#tbl16 + 1] = "Sorcery"
				end

				if v7.AutoVitality and v7.AutoVitality.Value then
					tbl16[#tbl16 + 1] = "Vitality"
				end
			end

			local statPoints = fn19()

			if #tbl16 == 0 then
				v13:SetText("Stat Points: " .. statPoints)
			elseif statPoints <= 0 then
				v13:SetText("Stat Points: 0 - waiting")
			else
				local n = 0
				local v16 = statPoints

				for _, v17 in ipairs(tbl16) do
					local v18, v19 = fn27(v17, v16)
					n += v18
					v16 = v19
				end

				v13:SetText(n > 0 and ("Unlocked %d node(s), %d points left"):format(n, fn19()) or ("Stat Points: %d - nothing unlockable"):format(statPoints))
			end
		end
	end))

	fn3(task.spawn(function()
		while true do
			task.wait(v.EquipInterval and v.EquipInterval.Value or 15)

			if v7.AutoEquipBest and v7.AutoEquipBest.Value then
				local ok2, result2 = pcall(function()
					local v16 = fn18()
					local itemConfig = tbl5.ItemConfig
					local playerData = tbl5.PlayerData
					if not (v16 and itemConfig and playerData and tbl5.Inventory) then
						Idle:SetText("Inventory unavailable")
						return
					end
					local bestEquipItems = itemConfig:GetBestEquipItems(v16, playerData.PlayerData)
					if not bestEquipItems or #bestEquipItems == 0 then
						Idle:SetText("Nothing to equip")
						return
					end
					local tbl16 = {}

					for _, bestEquipItem in ipairs(bestEquipItems) do
						local type_ = bestEquipItem.Type or "Gear"
						tbl16[type_] = tbl16[type_] or {}
						table.insert(tbl16[type_], bestEquipItem)
					end

					local n = 0

					for k, v17 in pairs(tbl16) do
						local tbl17 = {}

						for _, v18 in ipairs(v17) do
							tbl17[v18.ID] = true
						end

						local flag = false

						for _, v18 in pairs(v16) do
							if v18.Type == k and v18.Equipped and not tbl17[v18.ID] then
								flag = true
							end
						end

						for _, v18 in ipairs(v17) do
							if not v18.Equipped then
								flag = true
							end
						end

						if flag then
							for _, v18 in pairs(v16) do
								if v18.Type == k and v18.Equipped then
									pcall(function()
										tbl5.Inventory:UnequipItem(v18.ID)
									end)
								end
							end

							local localCharacter = tbl5.Character and tbl5.Character.LocalCharacter
							local inventory = localCharacter and localCharacter.Inventory
							local n2 = 99

							if inventory then
								local ok2

								ok2, n2 = pcall(function()
									return localCharacter.Inventory:GetEquipLimit(k)
								end)

								ok2 = ok2 and tonumber(n2)
								local n3 = 99

								if not ok2 then
									n2 = n3
								end
							end

							for i, v18 in ipairs(v17) do
								if not (n2 < i) then
									pcall(function()
										tbl5.Inventory:EquipItem(v18.ID)
									end)

									n += 1
									continue
								end

								break
							end
						end
					end

					Idle:SetText(n > 0 and ("Equipped %d item(s)"):format(n) or "Best gear already equipped")
				end)

				if not ok2 then
					Idle:SetText("Error: " .. tostring(result2):sub(1, 50))
				end
			end
		end
	end))
end

local fn23

do
	local Events = v10:AddTab("Events")
	local v11 = Events:AddLeftGroupbox("Auto Raid")
	local v12 = Events:AddLeftGroupbox("Auto Tower")
	local v13 = Events:AddLeftGroupbox("Auto Boss Island")
	local v14 = Events:AddRightGroupbox("Bot Core")
	local tbl7 = {}
	local tbl8 = {}
	local tbl9 = { "Easy", "Normal", "Hard", "Nightmare", "Calamity" }
	local n = 30
	local tbl10 = {}
	local tbl11 = {}
	local tbl12 = {}

	local ok, result = pcall(function()
		return require(ReplicatedStorage.Configs.RaidsConfig)
	end)

	if ok and type(result) == "table" then
		if type(result.RaidsData) == "table" then
			local tbl13 = {}

			for k, v15 in pairs(result.RaidsData) do
				if type(v15) == "table" then
					tbl13[#tbl13 + 1] = {
						ID = k,
						Name = v15.Name or k,
						Levels = type(v15.LevelDifficulties) == "table" and v15.LevelDifficulties or {},
						MaxTime = tonumber(v15.RaidMaxTime) or 3600,
						BossName = type(v15.BaseNPCConfig) == "table" and v15.BaseNPCConfig.Name or nil,
					}
				end
			end

			table.sort(tbl13, function(arg, arg2)
				return (arg.Levels[1] or 0) < (arg2.Levels[1] or 0)
			end)

			for _, v15 in ipairs(tbl13) do
				tbl8[("%s (Lv %s+)"):format(v15.Name, v15.Levels[1] or "?")] = v15.ID
				tbl7[v15.ID] = v15
			end
		end

		if type(result.Difficulties) == "table" and #result.Difficulties > 0 then
			for i, difficulty in ipairs(result.Difficulties) do
				tbl9[i] = difficulty.Name or tbl9[i]
			end
		end

		n = tonumber(result.RetryInterval) or n
	end

	local trialTowerConfig = ReplicatedStorage.Configs:FindFirstChild("TrialTowerConfig")
	trialTowerConfig = trialTowerConfig and trialTowerConfig:FindFirstChild("Towers")

	if trialTowerConfig then
		for _, child in ipairs(trialTowerConfig:GetChildren()) do
			local ok2, result2 = pcall(function()
				return require(child)
			end)

			if ok2 and type(result2) == "table" and result2.ID then
				tbl10[#tbl10 + 1] = {
					ID = result2.ID,
					Index = tonumber(result2.Index) or tonumber(result2.ID:match("%d+")) or 0,
					Name = result2.Name or result2.ID,
					Strength = tonumber(result2.RecommendedSorceryStrength) or 0,
					Last = result2.LastTower,
					FloorID = type(result2.Floors) == "table" and result2.Floors[1] or nil,
				}
			end
		end

		table.sort(tbl10, function(arg, arg2)
			return arg.Index < arg2.Index
		end)
	end

	local ok2, result2 = pcall(function()
		return require(ReplicatedStorage.Configs.BossIslandsConfig)
	end)

	if ok2 and type(result2) == "table" and type(result2.Islands) == "table" then
		for k, island in pairs(result2.Islands) do
			if type(island) == "table" then
				local difficulties = type(island.Difficulties) == "table" and island.Difficulties or {}
				local tbl13 = {}

				for i, difficulty in ipairs(difficulties) do
					tbl13[i] = tonumber(difficulty.StartLevel) or 0
				end

				local str

				if island.IsInfiniteRaid then
					str = "Infinite"
				elseif island.IsWaveRaid then
					str = "Waves"
				elseif island.IsTowerFloor then
					str = "Tower"
				else
					str = "Regular"

					if #difficulties == 0 then
						str = "Shikigami"
					end
				end

				local str2 = ("%s · %s"):format(str, island.Name or k)

				tbl11[k] = {
					ID = k,
					Name = island.Name or k,
					Group = str,
					Difficulties = #difficulties,
					StartLevels = tbl13,
					BossName = type(island.BaseNPCConfig) == "table" and island.BaseNPCConfig.Name or nil,
				}

				tbl12[str2] = k
			end
		end

		for _, v15 in ipairs(tbl10) do
			local floorID = v15.FloorID and result2.Islands[v15.FloorID]
			v15.BossName = floorID and floorID.BaseNPCConfig and floorID.BaseNPCConfig.Name or nil
		end
	end

	local function fn24(arg, arg2)
		local networkComm2 = game.ReplicatedStorage:FindFirstChild("NetworkComm")
		networkComm2 = networkComm2 and networkComm2:FindFirstChild(arg)
		return networkComm2 and networkComm2:FindFirstChild(arg2)
	end

	local function fn25()
		local playerData = tbl5.PlayerData and tbl5.PlayerData.PlayerData
		return playerData and playerData.Stats and tonumber(playerData.Stats.Level) or 0
	end

	local function fn26(arg)
		local playerData = tbl5.PlayerData and tbl5.PlayerData.PlayerData
		local towersCompleted = playerData and playerData.Leaderstats and playerData.Leaderstats.TowersCompleted
		return towersCompleted and towersCompleted[arg]
	end

	local function fn27()
		pcall(function()
			local playerScripts = game.Players.LocalPlayer:FindFirstChild("PlayerScripts")
			playerScripts = playerScripts and playerScripts:FindFirstChild("Client")
			playerScripts = playerScripts and playerScripts:FindFirstChild("Controllers")
			playerScripts = playerScripts and playerScripts:FindFirstChild("PlayerDataController")

			if playerScripts then
				tbl5.PlayerData = require(playerScripts)
			end
		end)
	end

	local function fn28(arg)
		if not arg then
			return false
		end
		return string.find(arg, "Dummy", 1, true) ~= nil or string.find(arg, "Punching Bag", 1, true) ~= nil or string.find(arg, "Test", 1, true) ~= nil
	end

	local function fn29(arg, arg2)
		local v15 = fn10()
		local n2 = 0
		local v16 = nil
		local n3 = 0
		local v17 = nil

		for _, v18 in ipairs(fn6()) do
			local v19 = fn12(v18)

			if v19 and v19.HP > 0 and not v19.IsPlayer and not fn28(v19.Name) and v19.MaxHP >= 50000 then
				local v20 = fn5(v18)

				if v20 then
					if (v15 and (v20.Position - v15.Position).Magnitude or 0) <= arg then
						if arg2 and string.find(v19.Name, arg2, 1, true) and v19.MaxHP > n2 then
							n2 = v19.MaxHP
							v16 = v18
						end

						if n3 < v19.MaxHP then
							n3 = v19.MaxHP
							v17 = v18
						end
					end
				end
			end
		end

		if arg2 then
			return v16
		end
		return v17
	end

	local function fn30(arg)
		local v15 = fn12(arg)
		if v15 and v15.MaxHP > 0 then
			return ("%d%%"):format(math.floor(v15.HP / v15.MaxHP * 100))
		end
		return "?"
	end

	local waveBossServerModel = nil
	local flag = false
	local tbl13 = {}
	local position = nil

	local function fn31(arg, arg2)
		for _, v15 in ipairs(tbl13) do
			pcall(function()
				v15:Disconnect()
			end)
		end

		table.clear(tbl13)
		waveBossServerModel = nil
		flag = false
		position = nil
		local networkComm2 = game.ReplicatedStorage:FindFirstChild("NetworkComm")

		local function fn32(arg3, arg4)
			if arg3 and arg3.ClassName == "RemoteEvent" then
				local ok3, result3 = pcall(function()
					return arg3.OnClientEvent:Connect(arg4)
				end)

				if ok3 and result3 then
					tbl13[#tbl13 + 1] = result3
				end
			end
		end

		if arg == "island" or arg == "tower" then
			local bossIslandService = networkComm2 and networkComm2:FindFirstChild("BossIslandService")

			fn32(bossIslandService and bossIslandService:FindFirstChild("IslandCreated_Signal"), function(arg3)
				if type(arg3) == "table" and (not arg2 or arg3.ConfigID == arg2) then
					v5 = nil
					local bossNPC = arg3.BossNPC
					bossNPC = bossNPC and bossNPC.Character

					if not bossNPC and arg3.WaveBossServerModel then
						bossNPC = arg3.WaveBossServerModel
					end

					if bossNPC then
						waveBossServerModel = bossNPC
					end
				end
			end)

			fn32(bossIslandService and bossIslandService:FindFirstChild("IslandDataUpdated_Signal"), function(arg3)
				if type(arg3) == "table" and arg3.WaveBossServerModel and (not arg2 or arg3.ConfigID == arg2 or not waveBossServerModel) then
					waveBossServerModel = arg3.WaveBossServerModel
				end
			end)

			fn32(bossIslandService and bossIslandService:FindFirstChild("IslandEnded_Signal"), function()
				waveBossServerModel = nil
				v5 = nil
				flag = true
			end)

			networkComm2 = networkComm2 and networkComm2:FindFirstChild("QueueZones")
			networkComm2 = networkComm2 and networkComm2:FindFirstChild("QueueZoneAdded_Signal")

			fn32(networkComm2, function(arg3)
				if type(arg3) == "table" and arg3.BossIslandConfigID == arg2 then
					local zone = arg3.Zone

					if typeof(zone) == "CFrame" then
						position = zone.Position
					elseif type(zone) == "table" and zone.Position then
						position = zone.Position
					elseif zone and zone:IsA("BasePart") then
						position = zone.Position
					end
				end
			end)
		elseif arg == "raid" then
			networkComm2 = networkComm2 and networkComm2:FindFirstChild("RaidsService")

			fn32(networkComm2 and networkComm2:FindFirstChild("RaidBossSpawned_Signal"), function(arg3)
				if arg3 and arg3.Parent then
					waveBossServerModel = arg3
				end
			end)

			fn32(networkComm2 and networkComm2:FindFirstChild("RaidEnded_Signal"), function()
				waveBossServerModel = nil
				flag = true
			end)
		end
	end

	fn23 = function()
		for _, v15 in ipairs(tbl13) do
			pcall(function()
				v15:Disconnect()
			end)
		end

		table.clear(tbl13)
		waveBossServerModel = nil
	end

	local function fn32(arg, arg2, arg3, arg4, arg5, arg6, arg7)
		local now = os.clock()
		flag = false
		local flag2 = false
		local now2 = nil
		local n2 = 0

		while os.clock() - now < arg2 do
			if arg7 and arg7() then
				return nil
			end

			if flag then
				return flag2
			end
			local v15 = waveBossServerModel

			if not v15 or not v15.Parent then
				v15 = fn29(1200, arg6)
			end

			if v15 then
				local v16 = fn5(v15)

				if v16 then
					v5 = fn15(v16)
				end

				flag2 = true
				now2 = nil

				if os.clock() - n2 > 3 then
					arg3:SetText(("%s: farming %s (%s)"):format(arg4, arg, fn30(v15)))
					n2 = os.clock()
					now2 = nil
				end
			else
				v5 = nil

				if flag2 then
					now2 = now2 or os.clock()
					if os.clock() - now2 > 12 then
						return true
					end
				else
					now2 = now2 or os.clock()
					arg3:SetText(("%s: waiting for %s boss..."):format(arg4, arg))

					if os.clock() - now2 > (arg5 or 120) then
						error((arg or arg4) .. " boss never appeared")
					end
				end
			end

			task.wait(0.5)
		end

		return false
	end

	local function fn33()
		local n2 = math.floor(workspace:GetServerTimeNow()) % 3600
		local flag2 = n2 < 900
		return flag2, flag2 and 900 - n2 or 3600 - n2
	end

	local function fn34(arg)
		return ("%d:%02d"):format(math.floor(arg / 60), arg % 60)
	end

	local function fn35(arg, arg2)
		local now = os.clock()

		while os.clock() - now < arg and (not arg2 or arg2()) do
			task.wait(0.25)
		end
	end

	local flag2 = false
	local fn36 = nil
	local Idle = v11:AddLabel("Idle")

	v11:AddToggle("AutoRaid", {
		Text = "Enable Auto Raid",
		Default = false,
		Tooltip = "Creates a solo raid lobby, farms the boss with Kill Aura, retries until Clears Then Stop is reached, then leaves.",
		Callback = function(arg)
			if arg and not flag2 then
				flag2 = true

				fn3(task.spawn(function()
					fn36()
					flag2 = false
				end))
			end
		end,
	})

	local function fn37()
		local tbl14 = {}

		for k, v15 in pairs(tbl8) do
			local v16 = tbl7[v15]
			local n2 = #tbl14 + 1
			local tbl15 = {}
			local levels = v16 and v16.Levels and v16.Levels[1] or math.huge
			tbl15[1] = k
			tbl15[2] = levels
			tbl14[n2] = tbl15
		end

		table.sort(tbl14, function(arg, arg2)
			return arg[2] < arg2[2]
		end)

		for i, v15 in ipairs(tbl14) do
			tbl14[i] = v15[1]
		end

		return tbl14
	end

	v11:AddDropdown("RaidSelect", { Values = fn37(), Default = 1, Multi = false, Text = "Select Raid" })

	v11:AddDropdown("RaidDiff", {
		Values = { "Auto (Highest Unlocked)", "Easy", "Normal", "Hard", "Nightmare", "Calamity" },
		Default = 1,
		Multi = false,
		Text = "Difficulty",
	})

	v11:AddDropdown("RaidMods", {
		Values = { "None", "Weaken", "Hardcore", "Both" },
		Default = 1,
		Multi = false,
		Text = "Modifiers",
	})

	v11:AddSlider("RaidClears", { Text = "Clears Then Stop (0 = infinite)", Default = 1, Min = 0, Max = 50, Rounding = 0 })

	v11:AddButton({
		Text = "Force Stop",
		Func = function()
			pcall(function()
				v7.AutoRaid:SetValue(false)
			end)
		end,
	})

	local n2 = 0

	local function fn38()
		local str = v.RaidMods and v.RaidMods.Value or "None"
		if str == "None" then
			return {}
		end
		return { Weaken = str == "Weaken" or str == "Both", Hardcore = str == "Hardcore" or str == "Both" }
	end

	local function fn39(arg)
		local str = v.RaidDiff and v.RaidDiff.Value or "Auto (Highest Unlocked)"

		if str ~= "Auto (Highest Unlocked)" then
			for i, v15 in ipairs(tbl9) do
				if v15 == str then
					return i
				end
			end

			return 1
		end

		local v15 = tbl7[arg]
		local v16 = fn25()
		local flag3 = v15 and type(v15.Levels) == "table"
		local n3 = 1

		if flag3 then
			for i, level in ipairs(v15.Levels) do
				if (tonumber(level) or math.huge) <= v16 then
					n3 = i
				end
			end
		end

		return n3
	end

	fn36 = function()
		while v7.AutoRaid and v7.AutoRaid.Value do
			local ok3, result3 = pcall(function()
				local v15 = tbl8[v.RaidSelect and v.RaidSelect.Value or ""]

				if not v15 then
					error("pick a raid")
				end

				local name = tbl7[v15] and tbl7[v15].Name or v15
				Idle:SetText("Raid: creating lobby (" .. name .. ")...")
				local RaidsService = fn24("RaidsService", "CreateLobby_Method")

				if not (RaidsService and RaidsService:InvokeServer({ RaidID = v15, Difficulty = fn39(v15), FriendsOnly = false, Modifiers = fn38() })) then
					error("server rejected lobby")
				end

				Idle:SetText("Raid: teleporting to lobby...")
				local RaidsService2 = fn24("RaidsService", "TeleportToLobby_Method")

				if RaidsService2 then
					pcall(function()
						RaidsService2:InvokeServer()
					end)
				end

				task.wait(6)
				fn27()
				fn31("raid")
				Idle:SetText("Raid: starting run...")
				local RaidsService3 = fn24("RaidsService", "BeginRaid_Method")

				if RaidsService3 then
					if not pcall(function()
						return RaidsService3:InvokeServer()
					end) then
						error("server rejected begin")
					end
				end

				local raid = fn32(name, (tbl7[v15] and tbl7[v15].MaxTime or 3600) + 120, Idle, "Raid", 180, tbl7[v15] and tbl7[v15].BossName, function()
					return not (v7.AutoRaid and v7.AutoRaid.Value)
				end)

				v5 = nil
				if raid == nil then
					return
				end

				if not raid then
					error(name .. " ended without a kill")
				end

				n2 += 1
				local n3 = v.RaidClears and v.RaidClears.Value or 1

				if n3 > 0 and n2 >= n3 then
					Idle:SetText(("Raid: done - %d clear(s), leaving"):format(n2))
					local RaidsService4 = fn24("RaidsService", "LeaveLobby_Method")

					if RaidsService4 then
						pcall(function()
							RaidsService4:InvokeServer()
						end)
					end

					task.wait(3)

					pcall(function()
						v7.AutoRaid:SetValue(false)
					end)

					return
				end

				Idle:SetText(("Raid: clear %d%s - retry in %ds"):format(n2, n3 > 0 and "/" .. tostring(n3) or "", n))
				local RaidsService4 = fn24("RaidsService", "RetryRaid_Method")

				if RaidsService4 then
					pcall(function()
						RaidsService4:InvokeServer()
					end)
				end

				task.wait(n)
			end)

			if not ok3 then
				Idle:SetText("Error: " .. tostring(result3):sub(1, 60))

				pcall(function()
					v7.AutoRaid:SetValue(false)
				end)
			end

			task.wait(1)
		end

		v5 = nil
		fn23()
		Idle:SetText("Idle")
	end

	local flag3 = false
	local fn40 = nil
	local Idle2 = v12:AddLabel("Idle")
	local tbl14 = {}

	for _, v15 in ipairs(tbl10) do
		tbl14[#tbl14 + 1] = v15.ID
	end

	v12:AddToggle("AutoTower", {
		Text = "Enable Auto Tower",
		Default = false,
		Tooltip = "Starts at the selected chamber, farms each floor with Kill Aura, and advances until Stop At Chamber or a locked floor.",
		Callback = function(arg)
			if arg and not flag3 then
				flag3 = true

				fn3(task.spawn(function()
					fn40()
					flag3 = false
				end))
			end
		end,
	})

	v12:AddDropdown("TowerStart", { Values = tbl14, Default = 1, Multi = false, Text = "Start Chamber" })
	v12:AddDropdown("TowerStop", { Values = tbl14, Default = #tbl14, Multi = false, Text = "Stop At Chamber" })

	v12:AddButton({
		Text = "Force Stop",
		Func = function()
			pcall(function()
				v7.AutoTower:SetValue(false)
			end)
		end,
	})

	local function fn41(arg)
		for i, v15 in ipairs(tbl10) do
			if v15.ID == arg then
				return i
			end
		end

		return 1
	end

	fn40 = function()
		local v15 = fn41(v.TowerStart and v.TowerStart.Value or "")
		local v16 = fn41(v.TowerStop and v.TowerStop.Value or "")

		local function fn42()
			return v7.AutoTower and v7.AutoTower.Value
		end

		while fn42() do
			local ok3, result3 = pcall(function()
				local v17 = tbl10[v15]

				if not v17 then
					error("no chamber " .. tostring(v15))
				end

				if fn26(v17.ID) then
					Idle2:SetText(("Tower: %s already cleared - next"):format(v17.ID))
					v15 += 1
					task.wait(2)
					return
				end

				if v17.Last and not fn26(v17.Last) then
					Idle2:SetText(("Tower: %s locked (needs %s) - stopping"):format(v17.ID, v17.Last))

					pcall(function()
						v7.AutoTower:SetValue(false)
					end)

					return
				end

				local n3 = 0

				while fn42() do
					n3 += 1

					if n3 > 1 then
						Idle2:SetText(("Tower: %s failed (attempt %d) - retrying in 3s"):format(v17.ID, n3))
						fn35(3, fn42)
						if not fn42() then
							return
						end
					end

					Idle2:SetText(("Tower: starting %s (%s)..."):format(v17.ID, v17.Name))
					local TrialTowerService = fn24("TrialTowerService", "StartTower_Method")

					if TrialTowerService and TrialTowerService:InvokeServer(v17.ID) then
						fn31("tower", v17.FloorID)

						local tower = fn32(v17.ID, 300, Idle2, "Tower", 240, v17.BossName, function()
							return not fn42()
						end)

						v5 = nil
						if tower == nil then
							return
						end

						if not tower then
							continue
						end
						local now = os.clock()

						while not fn26(v17.ID) and os.clock() - now < 15 do
							task.wait(1)
						end

						if fn26(v17.ID) then
							Idle2:SetText(("Tower: %s cleared - next"):format(v17.ID))
							v15 += 1
							fn35(4, fn42)
							return
						end
					end
				end
			end)

			if not ok3 then
				Idle2:SetText("Error: " .. tostring(result3):sub(1, 60))

				pcall(function()
					v7.AutoTower:SetValue(false)
				end)
			end

			if v15 > v16 or v15 > #tbl10 then
				Idle2:SetText(("Tower: reached stop chamber %s"):format(tbl10[math.min(v16, #tbl10)] and tbl10[math.min(v16, #tbl10)].ID or "?"))

				pcall(function()
					v7.AutoTower:SetValue(false)
				end)
			end

			task.wait(1)
		end

		v5 = nil
		fn23()
		Idle2:SetText("Idle")
	end

	local flag4 = false
	local fn42 = nil
	local Idle3 = v13:AddLabel("Idle")

	v13:AddToggle("AutoIsland", {
		Text = "Enable Auto Boss Island",
		Default = false,
		Tooltip = "Travels to the island, queues solo, farms the boss with Kill Aura, and loops. Infinite islands wait for their open window.",
		Callback = function(arg)
			if arg and not flag4 then
				flag4 = true

				fn3(task.spawn(function()
					fn42()
					flag4 = false
				end))
			end
		end,
	})

	local function fn43()
		local tbl15 = { Regular = 1, Waves = 2, Tower = 3, Shikigami = 4, Infinite = 5, Misc = 6 }
		local tbl16 = {}

		for k, v15 in pairs(tbl12) do
			local n3 = #tbl16 + 1
			local tbl17 = {}
			local n4 = tbl15[tbl11[v15].Group] or 9
			tbl17[1] = k
			tbl17[2] = n4
			tbl16[n3] = tbl17
		end

		table.sort(tbl16, function(arg, arg2)
			return arg[2] < arg2[2]
		end)

		for i, v15 in ipairs(tbl16) do
			tbl16[i] = v15[1]
		end

		return tbl16
	end

	v13:AddDropdown("IslandSelect", { Values = fn43(), Default = 1, Multi = false, Text = "Select Island" })

	v13:AddDropdown("IslandDiff", {
		Values = { "Auto (Highest Unlocked)", "Easy", "Normal", "Hard", "Nightmare", "Calamity" },
		Default = 1,
		Multi = false,
		Text = "Difficulty",
	})

	local v15 = v13:AddLabel("Infinite raids: --")

	v13:AddButton({
		Text = "Force Stop",
		Func = function()
			pcall(function()
				v7.AutoIsland:SetValue(false)
			end)
		end,
	})

	local function fn44(arg)
		local v16 = tbl11[arg]
		local n3 = math.max(1, v16 and v16.Difficulties or 1)
		local str = v.IslandDiff and v.IslandDiff.Value or "Auto (Highest Unlocked)"

		if str ~= "Auto (Highest Unlocked)" then
			for i, v17 in ipairs(tbl9) do
				if v17 == str then
					return math.min(i, n3)
				end
			end

			return 1
		end

		local v17 = fn25()
		local flag5 = v16 and type(v16.StartLevels) == "table"
		local n4 = 1

		if flag5 then
			for i, startLevel in ipairs(v16.StartLevels) do
				if (tonumber(startLevel) or 0) <= v17 then
					n4 = i
				end
			end
		end

		return math.min(n4, n3)
	end

	fn42 = function()
		local function fn45()
			return v7.AutoIsland and v7.AutoIsland.Value
		end

		local function fn46(arg, arg2)
			local now = os.clock()

			while true do
				local flag5 = fn45()

				if flag5 then
					flag5 = os.clock() - now < (arg2 or 60)
				end

				if flag5 then
					if position then
						return position
					end
					local queueZones = workspace.Map and workspace.Map:FindFirstChild("QueueZones")

					if queueZones then
						for _, child in ipairs(queueZones:GetChildren()) do
							if (child:GetAttribute("ConfigID") or child.Name) == arg and child:IsA("BasePart") then
								return child.Position
							end
						end
					end

					task.wait(0.5)
					continue
				end

				break
			end

			return nil
		end

		while fn45() do
			local ok3, result3 = pcall(function()
				local v16 = tbl12[v.IslandSelect and v.IslandSelect.Value or ""]
				local v17 = v16 and tbl11[v16]

				if not v17 then
					error("pick an island")
				end

				if v17.Group == "Infinite" then
					local v18, v19 = fn33()

					if not v18 then
						Idle3:SetText(("Island: infinite raids in %s"):format(fn34(v19)))
						task.wait(5)
						return
					end

					Idle3:SetText(("Island: infinite raids OPEN - queuing %s"):format(v17.Name))
				end

				fn31("island", v16)

				if v17.Group ~= "Infinite" then
					local BossIslandService = fn24("BossIslandService", "CreateIslandQueue_Method")

					if not BossIslandService then
						error("no queue remote")
					end

					Idle3:SetText(("Island: creating queue (%s)..."):format(v17.Name))
					local response, v18 = BossIslandService:InvokeServer({ ConfigID = v16, Difficulty = fn44(v16), Modifiers = {} })

					if not response then
						error("server rejected queue" .. (v18 and " (" .. tostring(v18) .. ")" or ""))
					end
				end

				local v18 = fn46(v16, 60)

				if not v18 then
					error("queue zone for " .. v17.Name .. " never appeared")
				end

				Idle3:SetText(("Island: standing in queue for %s..."):format(v17.Name))
				v5 = fn15(v18)
				fn35(25, fn45)

				local island = fn32(v17.Name, 1800, Idle3, "Island", 180, v17.BossName, function()
					return not fn45()
				end)

				v5 = nil
				if island == nil then
					return
				end

				if not island then
					error(v17.Name .. " ended without a kill")
				end

				Idle3:SetText(("Island: %s ended - next run"):format(v17.Name))
				fn35(6, fn45)
			end)

			if not ok3 then
				Idle3:SetText("Error: " .. tostring(result3):sub(1, 60))

				pcall(function()
					v7.AutoIsland:SetValue(false)
				end)
			end

			task.wait(1)
		end

		v5 = nil
		fn23()
		Idle3:SetText("Idle")
	end

	local v16 = v14:AddLabel("Level: -")
	local v17 = v14:AddLabel("Kill Aura: OFF - bots need it")

	v14:AddButton({
		Text = "Stop All Bots",
		Func = function()
			pcall(function()
				v7.AutoRaid:SetValue(false)
			end)

			pcall(function()
				v7.AutoTower:SetValue(false)
			end)

			pcall(function()
				v7.AutoIsland:SetValue(false)
			end)
		end,
	})

	fn3(task.spawn(function()
		while true do
			task.wait(2)

			pcall(function()
				v16:SetText(("Level: %d"):format(fn25()))
				v17:SetText(v7.KillAura and v7.KillAura.Value and "Kill Aura: ON" or "Kill Aura: OFF - bots need it")
			end)
		end
	end))

	fn3(task.spawn(function()
		while true do
			task.wait(1)

			pcall(function()
				local v18, v19 = fn33()
				v15:SetText(v18 and ("Infinite raids OPEN - %s left"):format(fn34(v19)) or ("Infinite raids in %s"):format(fn34(v19)))
			end)
		end
	end))
end

do
	local esp = v10:AddTab("ESP")
	local v11 = esp:AddLeftGroupbox("Player ESP")
	local v12 = esp:AddRightGroupbox("Mob ESP")
	local Visuals = esp:AddLeftGroupbox("Visuals")

	local function fn24(arg, arg2, arg3, arg4)
		arg:AddToggle(arg2 .. "_Enable", { Text = "Enable", Default = false })
		arg:AddToggle(arg2 .. "_Rainbow", { Text = "Rainbow", Default = false })
		arg:AddToggle(arg2 .. "_Box", { Text = "Box", Default = true })
		arg:AddToggle(arg2 .. "_Name", { Text = "Name", Default = true })
		arg:AddToggle(arg2 .. "_Health", { Text = "Health", Default = false })
		arg:AddToggle(arg2 .. "_Distance", { Text = "Distance", Default = false })
		arg:AddToggle(arg2 .. "_Tracer", { Text = "Tracer", Default = false })
		arg:AddToggle(arg2 .. "_Highlight", { Text = "Highlight (Chams)", Default = false }):AddColorPicker(arg2 .. "_Color", { Default = arg3, Title = arg4 .. " Color" })
	end

	fn24(v11, "PlayerESP", Color3.fromRGB(0, 150, 255), "Player ESP")
	fn24(v12, "MobESP", Color3.fromRGB(255, 80, 80), "Mob ESP")
	fn24(esp:AddRightGroupbox("Crate ESP"), "CrateESP", Color3.fromRGB(255, 215, 0), "Crate ESP")
	local tbl7 = { "ActiveCrates", "SpecialCrates", "TimeCrates", "CratesST", "CrateRain", "Crates" }

	CrateFolders = function()
		local tbl8 = {}
		local map = Workspace:FindFirstChild("Map")
		if not map then
			return tbl8
		end

		for _, v13 in ipairs(tbl7) do
			local v14 = map:FindFirstChild(v13)

			if v14 then
				tbl8[#tbl8 + 1] = v14
			end
		end

		return tbl8
	end

	Visuals:AddSlider("MaxESPDistance", { Text = "Max Distance", Default = 1000, Min = 100, Max = 5000, Rounding = 0 })

	Visuals:AddDropdown("TracerOrigin", {
		Values = { "Bottom", "Center", "Mouse" },
		Default = "Bottom",
		Multi = false,
		Text = "Tracer Origin",
		Tooltip = "Where tracers start: screen bottom, screen centre, or your mouse.",
	})

	local tbl8 = {}

	local function fn25(arg)
		if tbl8[arg] then
			return tbl8[arg]
		end

		local ok, result = pcall(function()
			local tbl9 = {
				Box = Drawing.new("Square"),
				Tracer = Drawing.new("Line"),
				Name = Drawing.new("Text"),
				Distance = Drawing.new("Text"),
				HealthBg = Drawing.new("Line"),
				HealthBar = Drawing.new("Line"),
			}

			tbl9.Box.Thickness = 1.5
			tbl9.Box.Filled = false
			tbl9.Box.Visible = false
			tbl9.Tracer.Thickness = 1
			tbl9.Tracer.Visible = false
			tbl9.Name.Size = 13
			tbl9.Name.Center = true
			tbl9.Name.Outline = true
			tbl9.Name.Visible = false
			tbl9.Distance.Size = 13
			tbl9.Distance.Center = true
			tbl9.Distance.Outline = true
			tbl9.Distance.Visible = false
			tbl9.HealthBg.Thickness = 3
			tbl9.HealthBg.Color = Color3.fromRGB(40, 0, 0)
			tbl9.HealthBg.Visible = false
			tbl9.HealthBar.Thickness = 3
			tbl9.HealthBar.Visible = false
			return tbl9
		end)

		if ok and result then
			tbl8[arg] = result
			return result
		end
		return nil
	end

	local function fn26(arg)
		if not arg then
			return
		end
		arg.Box.Visible = false
		arg.Tracer.Visible = false
		arg.Name.Visible = false
		arg.Distance.Visible = false
		arg.HealthBg.Visible = false
		arg.HealthBar.Visible = false
	end

	local function fn27(arg)
		local v13 = tbl8[arg]
		if not v13 then
			return
		end

		for _, v14 in pairs(v13) do
			pcall(function()
				v14:Destroy()
			end)
		end

		tbl8[arg] = nil
	end

	fn2(RunService.RenderStepped:Connect(function()
		local n = v.MaxESPDistance and v.MaxESPDistance.Value or 1000
		local str = v.TracerOrigin and v.TracerOrigin.Value or "Bottom"

		local function fn28()
			if str == "Mouse" then
				return UserInputService:GetMouseLocation()
			end

			if str == "Center" then
				return Vector2.new(currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y / 2)
			end
			return Vector2.new(currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y)
		end

		local tbl9 = {}

		local function fn29(arg)
			return v7[arg] and v7[arg].Value
		end

		local function fn30(adornee, arg, arg2, text, arg3)
			if not fn29(arg3 .. "_Enable") then
				return
			end

			if not (arg and arg2 and arg2.HP > 0) then
				return
			end
			local magnitude = (currentCamera.CFrame.Position - arg.Position).Magnitude
			if n < magnitude then
				return
			end
			local v13 = fn25(adornee)
			if not v13 then
				return
			end
			tbl9[adornee] = true
			local color = fn29(arg3 .. "_Rainbow") and Color3.fromHSV(tick() % 5 / 5, 1, 1) or nil or v[arg3 .. "_Color"] and v[arg3 .. "_Color"].Value or Color3.fromRGB(255, 255, 255)

			if fn29(arg3 .. "_Highlight") then
				if not v13.Highlight then
					local highlight = Instance.new("Highlight")
					highlight.FillTransparency = 0.5
					highlight.OutlineTransparency = 0
					highlight.Adornee = adornee
					highlight.Parent = adornee
					v13.Highlight = highlight
				end

				v13.Highlight.FillColor = color
				v13.Highlight.OutlineColor = color
			elseif v13.Highlight then
				v13.Highlight:Destroy()
				v13.Highlight = nil
			end

			local v14, v15 = currentCamera:WorldToViewportPoint(arg.Position)
			if not v15 then
				fn26(v13)
				return
			end
			local n2 = 2000 / v14.Z
			local n3 = 3000 / v14.Z
			v13.Box.Visible = fn29(arg3 .. "_Box")

			if v13.Box.Visible then
				v13.Box.Size = Vector2.new(n2, n3)
				v13.Box.Position = Vector2.new(v14.X - n2 / 2, v14.Y - n3 / 2)
				v13.Box.Color = color
			end

			if fn29(arg3 .. "_Health") then
				local n4 = math.clamp(arg2.HP / math.max(arg2.MaxHP, 1), 0, 1)
				local vector2 = Vector2.new(v14.X - n2 / 2 - 6, v14.Y - n3 / 2)
				v13.HealthBg.From = vector2
				v13.HealthBg.To = Vector2.new(vector2.X, vector2.Y + n3)
				v13.HealthBg.Visible = true
				v13.HealthBar.From = Vector2.new(vector2.X, vector2.Y + n3)
				v13.HealthBar.To = Vector2.new(vector2.X, vector2.Y + n3 - n3 * n4)
				v13.HealthBar.Color = Color3.fromHSV(n4 * 0.33, 1, 1)
				v13.HealthBar.Visible = true
			else
				v13.HealthBg.Visible = false
				v13.HealthBar.Visible = false
			end

			local v16 = fn29(arg3 .. "_Name")
			v13.Name.Visible = v16

			if v16 then
				v13.Name.Text = text
				v13.Name.Position = Vector2.new(v14.X, v14.Y - 1500 / v14.Z - 15)
				v13.Name.Color = color
			end

			v13.Distance.Visible = fn29(arg3 .. "_Distance")

			if v13.Distance.Visible then
				v13.Distance.Text = string.format("%dm", math.floor(magnitude))
				v13.Distance.Position = Vector2.new(v14.X, v14.Y - 1500 / v14.Z - (v16 and 27 or 15))
				v13.Distance.Color = color
			end

			v13.Tracer.Visible = fn29(arg3 .. "_Tracer")

			if v13.Tracer.Visible then
				v13.Tracer.From = fn28()
				v13.Tracer.To = Vector2.new(v14.X, v14.Y)
				v13.Tracer.Color = color
			end
		end

		if fn29("PlayerESP_Enable") then
			for _, player in ipairs(Players:GetPlayers()) do
				local v13 = fn11(player)

				if player ~= localPlayer and v13 then
					fn30(v13, v13:FindFirstChild("HumanoidRootPart"), fn12(v13), player.DisplayName or player.Name, "PlayerESP")
				end
			end
		end

		if fn29("MobESP_Enable") then
			for _, v13 in ipairs(tbl3) do
				local v14 = fn12(v13)

				if v14 and v14.HP > 0 then
					fn30(v13, fn5(v13), v14, v14.Level and ("[%d] %s"):format(v14.Level, v14.Name) or v14.Name, "MobESP")
				end
			end
		end

		if fn29("CrateESP_Enable") then
			for _, v13 in ipairs(CrateFolders()) do
				for _, child in ipairs(v13:GetChildren()) do
					local isBasePart = child:IsA("BasePart") and child or child:IsA("Model") and (child.PrimaryPart or child:FindFirstChildWhichIsA("BasePart"))

					if isBasePart then
						fn30(child, isBasePart, { HP = 1, MaxHP = 1 }, v13.Name, "CrateESP")
					end
				end
			end
		end

		for k, v13 in pairs(tbl8) do
			if not k.Parent then
				fn27(k)
			elseif not tbl9[k] then
				fn26(v13)

				if v13.Highlight then
					v13.Highlight:Destroy()
					v13.Highlight = nil
				end
			end
		end
	end))

	Visuals:AddToggle("FullBrightActive", { Text = "FullBright", Default = false })

	v7.FullBrightActive:OnChanged(function()
		if v7.FullBrightActive.Value then
			Lighting.Ambient = Color3.fromRGB(255, 255, 255)
			Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
			Lighting.ClockTime = 14
		else
			Lighting.Ambient = tbl4.Ambient
			Lighting.OutdoorAmbient = tbl4.OutdoorAmbient
			Lighting.ClockTime = tbl4.ClockTime or 12
		end
	end)

	local Utilities = v10:AddTab("Utilities")
	local Performance = Utilities:AddLeftGroupbox("Performance")
	local Connections = Utilities:AddRightGroupbox("Connections")
	Performance:AddToggle("FPSBoosterActive", { Text = "FPS Booster", Default = false })
	local tbl9 = {}

	local function fn28(arg)
		if arg then
			task.spawn(function()
				for _, descendant in ipairs(Workspace:GetDescendants()) do
					if not tbl9[descendant] then
						if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") or descendant:IsA("Smoke") or descendant:IsA("Sparkles") or descendant:IsA("Fire") then
							tbl9[descendant] = { Enabled = descendant.Enabled }
							descendant.Enabled = false
						elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
							tbl9[descendant] = { Texture = descendant.Texture }
							descendant.Texture = ""
						elseif descendant:IsA("PostEffect") then
							tbl9[descendant] = { Enabled = descendant.Enabled }
							descendant.Enabled = false
						end
					end
				end
			end)
		else
			for k, v13 in pairs(tbl9) do
				pcall(function()
					if v13.Enabled ~= nil then
						k.Enabled = v13.Enabled
					elseif v13.Texture ~= nil then
						k.Texture = v13.Texture
					end
				end)
			end

			table.clear(tbl9)
		end
	end

	v7.FPSBoosterActive:OnChanged(function()
		fn28(v7.FPSBoosterActive.Value)
	end)

	fn2(Workspace.DescendantAdded:Connect(function(descendant)
		if v7.FPSBoosterActive and v7.FPSBoosterActive.Value then
			if not tbl9[descendant] then
				if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") or descendant:IsA("Smoke") or descendant:IsA("Sparkles") or descendant:IsA("Fire") then
					tbl9[descendant] = { Enabled = descendant.Enabled }
					descendant.Enabled = false
				elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
					tbl9[descendant] = { Texture = descendant.Texture }
					descendant.Texture = ""
				elseif descendant:IsA("PostEffect") then
					tbl9[descendant] = { Enabled = descendant.Enabled }
					descendant.Enabled = false
				end
			end
		end
	end))

	Performance:AddToggle("AntiAFK", {
		Text = "Anti-AFK",
		Default = false,
		Tooltip = "Bypasses idle kick using VirtualUser interactions",
	})

	local connection = nil

	v7.AntiAFK:OnChanged(function()
		if v7.AntiAFK.Value then
			connection = localPlayer.Idled:Connect(function()
				VirtualUser:Button2Down(Vector2.new(0, 0), currentCamera.CFrame)
				task.wait(1)
				VirtualUser:Button2Up(Vector2.new(0, 0), currentCamera.CFrame)
			end)
		elseif connection then
			connection:Disconnect()
			connection = nil
		end
	end)

	Performance:AddSlider("FPSCap", { Text = "FPS Cap (0 = Unlimited)", Default = 0, Min = 0, Max = 360, Rounding = 0 })

	v.FPSCap:OnChanged(function()
		if setfpscap then
			pcall(setfpscap, v.FPSCap.Value <= 0 and 9999 or v.FPSCap.Value)
		end
	end)

	Performance:AddToggle("NoShadows", { Text = "No Shadows", Default = false, Tooltip = "Disables global shadows for extra FPS." })

	v7.NoShadows:OnChanged(function()
		pcall(function()
			Lighting.GlobalShadows = not v7.NoShadows.Value
		end)
	end)

	Performance:AddToggle("LowDetail", {
		Text = "Low Detail Terrain",
		Default = false,
		Tooltip = "Removes water waves/reflection for extra FPS.",
	})

	v7.LowDetail:OnChanged(function()
		pcall(function()
			local terrain = Workspace:FindFirstChildOfClass("Terrain")
			if not terrain then
				return
			end

			if v7.LowDetail.Value then
				terrain.WaterWaveSize = 0
				terrain.WaterWaveSpeed = 0
				terrain.WaterReflectance = 0
				terrain.WaterTransparency = 1
			else
				terrain.WaterWaveSize = 0.15
				terrain.WaterWaveSpeed = 10
				terrain.WaterReflectance = 1
				terrain.WaterTransparency = 0.3
			end
		end)
	end)

	Performance:AddToggle("NoCharEffects", {
		Text = "No Character Effects",
		Default = false,
		Tooltip = "Disables particle/trail effects on all characters (re-checks as they spawn).",
	})

	fn3(task.spawn(function()
		while task.wait(0.5) do
			if v7.NoCharEffects and v7.NoCharEffects.Value then
				pcall(function()
					local v13 = fn4()
					local tbl10 = { fn9() }

					for _, player in ipairs(Players:GetPlayers()) do
						table.insert(tbl10, fn11(player))
					end

					if v13 then
						table.insert(tbl10, v13)
					end

					for _, v14 in ipairs(tbl10) do
						if v14 then
							for _, descendant in ipairs(v14:GetDescendants()) do
								if (descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") or descendant:IsA("Smoke") or descendant:IsA("Fire") or descendant:IsA("Sparkles")) and descendant.Enabled then
									descendant.Enabled = false
								end
							end
						end
					end
				end)
			end
		end
	end))

	Connections:AddButton({
		Text = "Server Hopper",
		Func = function()
			v6:Notify("Searching for a new server...", 3)

			task.spawn(function()
				local tbl10 = {}

				local ok, result = pcall(function()
					return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
				end)

				if ok and result and result.data then
					for _, v13 in ipairs(result.data) do
						if v13.playing < v13.maxPlayers and v13.id ~= game.JobId then
							table.insert(tbl10, v13.id)
						end
					end
				end

				if #tbl10 > 0 then
					TeleportService:TeleportToPlaceInstance(game.PlaceId, tbl10[math.random(1, #tbl10)], localPlayer)
				else
					v6:Notify("No suitable servers found.", 3)
				end
			end)
		end,
	})

	Connections:AddButton({
		Text = "Rejoin Server",
		Func = function()
			v6:Notify("Reconnecting to server...", 3)

			if #Players:GetPlayers() <= 1 then
				TeleportService:Teleport(game.PlaceId, localPlayer)
			else
				TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayer)
			end
		end,
	})

	local Settings = v10:AddTab("Settings")
	local Menu = Settings:AddLeftGroupbox("Menu")
	Menu:AddLabel("Menu Toggle"):AddKeyPicker("UAP_Menu", { Default = "RightShift", NoUI = true, Text = "Menu Toggle" })
	v6.ToggleKeybind = v.UAP_Menu

	Menu:AddToggle("ShowKeybindsList", {
		Text = "Show Keybinds List",
		Default = true,
		Callback = function(arg)
			if v6.KeyList and v6.KeyList.SetVisibility then
				v6.KeyList:SetVisibility(arg)
			end
		end,
	})

	v8:SetLibrary(v6)
	v8:SetFolder("UAPAutomation")
	v8:ApplyToTab(Settings)
	v9:SetLibrary(v6)
	v9:IgnoreThemeSettings()
	v9:SetIgnoreIndexes({})
	v9:SetFolder("UAPAutomation/configs")
	v9:BuildConfigSection(Settings)

	Menu:AddButton({
		Text = "Unload Menu",
		Func = function()
			for _, v13 in ipairs(tbl) do
				if typeof(v13) == "RBXScriptConnection" then
					v13:Disconnect()
				end
			end

			table.clear(tbl)

			if connection then
				connection:Disconnect()
				connection = nil
			end

			for _, v13 in ipairs(tbl2) do
				pcall(task.cancel, v13)
			end

			table.clear(tbl2)
			v2 = nil
			v3 = nil
			v4 = nil
			v5 = nil
			pcall(fn23)
			pcall(fn22)
			pcall(fn20, 1)

			for _, v13 in pairs(tbl8) do
				for _, v14 in pairs(v13) do
					pcall(function()
						v14:Destroy()
					end)
				end
			end

			table.clear(tbl8)
			fn28(false)
			Lighting.Ambient = tbl4.Ambient
			Lighting.OutdoorAmbient = tbl4.OutdoorAmbient
			Lighting.ClockTime = tbl4.ClockTime or 12
			local humanoid = fn9()
			humanoid = humanoid and humanoid:FindFirstChildOfClass("Humanoid")

			if humanoid then
				humanoid.WalkSpeed = 16
				humanoid.JumpPower = 50
			end

			v6:Unload()
		end,
		DoubleClick = true,
		Tooltip = "Double-click to completely clean and unload the script.",
	})
end

v6:Notify("Base Framework Loaded Successfully.", 3)

pcall(function()
	v10:Init()
end)

pcall(function()
	v9:LoadAutoloadConfig()
end)
