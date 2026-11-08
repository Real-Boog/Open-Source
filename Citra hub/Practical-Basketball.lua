-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer
local aeroRemoteServices = game:GetService("ReplicatedStorage"):WaitForChild("Aero"):WaitForChild("AeroRemoteServices")
local meterService = aeroRemoteServices:WaitForChild("MeterService")
local inputService = aeroRemoteServices:WaitForChild("InputService")
local interfaceService = aeroRemoteServices:WaitForChild("InterfaceService")
local registerPacket = meterService:WaitForChild("RegisterPacket")
local unregisterPacket = meterService:WaitForChild("UnregisterPacket")
local updateGreenWindow = meterService:WaitForChild("UpdateGreenWindow")
local shoot = inputService:WaitForChild("Shoot")
local runGreenEffect = interfaceService:WaitForChild("RunGreenEffect")
local tbl = {}

local function fn(arg)
	tbl[#tbl + 1] = arg
	return arg
end

local v = nil
local v2 = nil
local v3 = nil

local function fn2(arg)
	local v4 = v2 and v2[arg]
	return v4 and v4.Value
end

local function fn3(arg, arg2)
	local v4 = v3 and v3[arg]
	if v4 and v4.Value ~= nil then
		return v4.Value
	end
	return arg2
end

local function fn4()
	local characters = workspace:FindFirstChild("Characters")
	return characters and characters:FindFirstChild(localPlayer.Name) or nil
end

local function fn5(arg)
	if not arg then
		return 0
	end
	return -arg
end

local n = 0.12

local function fn6()
	local ok, result = pcall(function()
		return Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
	end)

	if ok and type(result) == "number" and result > 0 then
		n += (result / 1000 - n) * 0.25
	end

	return n
end

local n2 = nil

local function fn7()
	if fn2("AG_AutoPing") ~= false and n2 then
		return n2
	end
	return fn6()
end

local tbl2 = nil
local tbl3 = {}
local n3 = nil

fn(registerPacket.OnClientEvent:Connect(function(arg, arg2, arg3)
	if arg ~= fn4() then
		return
	end

	tbl2 = {
		t0 = os.clock(),
		released = false,
		peak = -math.huge,
		frozen = nil,
		rate = 0,
		green = false,
		firedAt = nil,
		greenValue = tonumber(arg3) or 0.278,
	}
end))

fn(updateGreenWindow.OnClientEvent:Connect(function(arg, arg2)
	if arg ~= fn4() or not tbl2 then
		return
	end
	tbl2.greenValue = tonumber(arg2) or tbl2.greenValue
end))

fn(runGreenEffect.OnClientEvent:Connect(function()
	if tbl2 then
		tbl2.green = true
	end
end))

local function fn8()
	pcall(function()
		shoot:FireServer({ Shoot = false, Input = "E" })
	end)
end

local function fn9()
	if #tbl3 == 0 then
		return nil
	end
	local n4 = 0

	for _, v4 in ipairs(tbl3) do
		n4 += v4
	end

	return n4 / #tbl3
end

local function fn10()
	if fn2("AG_AutoTune") and n3 then
		return n3
	end
	return fn3("AG_ReleaseAt", 85) / 100
end

fn(RunService.Heartbeat:Connect(function()
	if not tbl2 then
		return
	end
	local v4 = fn4()
	if not v4 then
		return
	end
	local attribute = v4:GetAttribute("meterOffset")
	if typeof(attribute) ~= "Vector2" then
		return
	end
	local v5 = fn5(attribute.Y)
	local now = os.clock()

	if v5 > tbl2.peak then
		tbl2.peak = v5
	end

	tbl2.frozen = v5

	if not tbl2.p0 or v5 < tbl2.p0 then
		local v6 = tbl2
		tbl2.p0 = v5
		v6.tp0 = now
	end

	local n4 = now - tbl2.tp0

	if n4 > 0.05 and v5 > tbl2.p0 then
		tbl2.rate = (v5 - tbl2.p0) / n4
	end

	if tbl2.released or not fn2("AG_Enabled") then
		return
	end

	if tbl2.rate <= 0 then
		return
	end
	fn6()
	local firedAt = v5 + tbl2.rate * fn7()

	if fn10() <= firedAt then
		tbl2.released = true
		tbl2.firedAt = firedAt
		tbl2.firePos = v5
		tbl2.fireRate = tbl2.rate
		fn8()
	end
end))

fn(unregisterPacket.OnClientEvent:Connect(function(arg)
	if arg ~= fn4() or not tbl2 then
		return
	end
	local v4 = tbl2
	tbl2 = nil
	if not v4.frozen or v4.peak == -math.huge then
		return
	end
	lastFrozenPos = v4.frozen
	lastPeakPos = v4.peak
	local flag = v4.peak - v4.frozen > 0.02

	if v4.green then
		tbl3[#tbl3 + 1] = v4.frozen

		if #tbl3 > 20 then
			table.remove(tbl3, 1)
		end
	end

	table.insert(history, {
		pos = v4.frozen,
		green = v4.green,
		receded = flag,
		band = v4.greenValue,
		fired = v4.released,
		peak = v4.peak,
	})

	if #history > 8 then
		table.remove(history, 1)
	end

	if not v4.released and fn2("AG_Enabled") then
		stats.nofire = stats.nofire + 1
	end

	if v4.green then
		stats.green = stats.green + 1
	elseif flag then
		stats.late = stats.late + 1
	else
		stats.early = stats.early + 1
	end

	if v4.released and not flag and v4.firePos and v4.fireRate and v4.fireRate > 0 then
		local n4 = (v4.frozen - v4.firePos) / v4.fireRate
		local n5 = n * 0.5
		local n6 = math.max(n * 2, 0.08)

		if n4 > 0.005 and n4 < 0.6 and v4.frozen < 0.95 then
			local n7 = math.clamp(n4, n5, n6)
			n2 = n2 and n2 + (n7 - n2) * 0.3 or n7
		end
	end

	if fn2("AG_AutoTune") then
		local v5 = fn9()

		if v5 then
			n3 = v5
		elseif v4.released then
			n3 = math.clamp((n3 or fn10()) + (flag and -0.02 or 0.01), 0.3, 1.1)
		end
	end
end))

local dribble = inputService:WaitForChild("Dribble")
local flag = nil

local function fn11()
	if not flag then
		local ok, result = pcall(require, localPlayer.PlayerScripts.Aero.Controllers.Player)
		flag = ok and result or false
	end

	if flag and flag.Character and flag.Character.Movement then
		return flag.Character.Movement.lastMoveDirection or Vector3.zero
	end
	return Vector3.zero
end

fn(RunService.Heartbeat:Connect(function()
	if not fn2("DR_InfStamina") then
		return
	end
	local v4 = fn4()
	if not v4 then
		return
	end

	if v4:GetAttribute("Stamina") ~= 100 then
		v4:SetAttribute("Stamina", 100)
	end
end))

fn(RunService.Heartbeat:Connect(function()
	if not fn2("DR_NoStun") then
		return
	end
	local v4 = fn4()
	if not v4 then
		return
	end

	if v4:GetAttribute("CanMove") == false then
		v4:SetAttribute("CanMove", true)
	end

	if v4:GetAttribute("CanTurn") == false then
		v4:SetAttribute("CanTurn", true)
	end

	if v4:GetAttribute("Debounce") == true then
		v4:SetAttribute("Debounce", false)
	end
end))

local tbl4 = {
	Crossover = { L = "C", R = "Z" },
	Hesitation = { L = "Z", R = "C" },
	["Step Back"] = { L = "X", R = "X" },
	["Half Spin"] = { L = "V", R = "V" },
	["Switch Hand"] = { L = "H", R = "H" },
	["Double Crossover"] = { L = "ZZ", R = "CC" },
	Tween = { L = "CC", R = "ZZ" },
	["Snatch Back"] = { L = "XX", R = "XX" },
	Combo = { L = "VV", R = "VV" },
	["Behind Back"] = { L = "ZX", R = "CX" },
	["Double Behind Back"] = { L = "XZ", R = "XZ" },
	Breakdown = { L = "VC", R = "VC" },
	Spin = { L = "ZXC", R = "CXZ" },
}

local tbl5 = { "None" }

for k in pairs(tbl4) do
	table.insert(tbl5, k)
end

table.sort(tbl5, function(arg, arg2)
	if arg == "None" then
		return true
	end

	if arg2 == "None" then
		return false
	end
	return arg < arg2
end)

local function fn12(arg)
	local v4 = tbl4[arg]
	if not v4 then
		return nil
	end
	local v5 = fn4()
	local l = (v5 and v5:GetAttribute("Hand")) == "L" and v4.L or v4.R

	if l == nil or l == "" then
		l = v4.L ~= "" and v4.L or v4.R
	end

	return l ~= "" and l or nil
end

local function fn13(arg, arg2)
	local v4 = fn12(arg)
	if not v4 then
		return false
	end

	pcall(function()
		dribble:FireServer(v4, arg2 and true or false, fn11())
	end)

	return true
end

local flag2 = false
local tbl6 = { "T", "Y", "U" }
local v4 = nil

pcall(function()
	if isfile and isfile("PracticalCitra/combokeys.json") then
		local data = game:GetService("HttpService"):JSONDecode(readfile("PracticalCitra/combokeys.json"))

		if type(data) == "table" then
			for i = 1, 3 do
				if type(data[i]) == "string" then
					tbl6[i] = data[i]
				end
			end
		end
	end
end)

local function fn14()
	pcall(function()
		writefile("PracticalCitra/combokeys.json", game:GetService("HttpService"):JSONEncode(tbl6))
	end)
end

local function fn15(arg)
	if not fn2("DR_ComboEnabled") then
		return
	end

	if flag2 then
		return
	end
	local tbl7 = {}

	for i = 1, 5 do
		local none = fn3(("DR_S%dM%d"):format(arg, i), "None")

		if tbl4[none] then
			table.insert(tbl7, none)
		end
	end

	if #tbl7 == 0 then
		if v then
			v:Notify(("Slot %d has no moves set."):format(arg), 3)
		end

		return
	end

	flag2 = true

	task.spawn(function()
		local n4 = fn3("DR_ComboDelay", 260) / 1000
		local DR_ComboSprint = fn2("DR_ComboSprint")

		for _, v5 in ipairs(tbl7) do
			if not (not flag2 or not fn2("DR_ComboEnabled")) then
				fn13(v5, DR_ComboSprint)
				task.wait(n4)
				continue
			end

			break
		end

		flag2 = false
	end)
end

fn(RunService.Heartbeat:Connect(function()
	local ok, result = pcall(require, localPlayer.PlayerScripts.Aero.Controllers.Player)
	if not ok then
		return
	end
	local movement = result.Character and result.Character.Movement
	if not movement then
		return
	end
	local autoGuard = fn2("DF_AutoGuard") and true or false

	if movement.AutoGuard ~= autoGuard then
		movement.AutoGuard = autoGuard
	end

	local DF_GuardSmooth = fn3("DF_GuardSmooth", 8)

	if autoGuard and movement.AutoGuardSpeed ~= DF_GuardSmooth then
		movement.AutoGuardSpeed = DF_GuardSmooth
	end
end))

local n4 = 12
local n5 = 0

fn(RunService.Heartbeat:Connect(function()
	if not fn2("DF_Ankle") then
		return
	end

	if os.clock() - n5 < 1.2 then
		return
	end
	local DF_AnkleMove = fn3("DF_AnkleMove", "None")
	if not tbl4[DF_AnkleMove] then
		return
	end
	local v5 = fn4()
	if not v5 then
		return
	end
	local humanoidRootPart = v5:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return
	end
	local characters = workspace:FindFirstChild("Characters")
	if not characters then
		return
	end

	for _, child in ipairs(characters:GetChildren()) do
		if child ~= v5 and child:GetAttribute("Action") == "Stealing" then
			local humanoidRootPart2 = child:FindFirstChild("HumanoidRootPart")

			if humanoidRootPart2 and (humanoidRootPart2.Position - humanoidRootPart.Position).Magnitude <= n4 then
				n5 = os.clock()
				fn13(DF_AnkleMove, false)
				break
			end
		end
	end
end))

local jump = inputService:WaitForChild("Jump")

local function fn16()
	pcall(function()
		shoot:FireServer({ Shoot = true, Input = "E", UseSpace = true })
		jump:FireServer()
	end)
end

local n6 = 5

fn(registerPacket.OnClientEvent:Connect(function(arg)
	if not fn2("DF_AutoBlock") then
		return
	end

	if tbl2 then
		return
	end
	local v5 = fn4()
	if not v5 or arg == v5 then
		return
	end
	local humanoidRootPart = arg:FindFirstChild("HumanoidRootPart")
	local humanoidRootPart2 = v5:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart or not humanoidRootPart2 then
		return
	end

	if n6 < (humanoidRootPart.Position - humanoidRootPart2.Position).Magnitude then
		return
	end
	task.delay(fn3("DF_BlockDelay", 150) / 1000, fn16)
end))

fn(RunService.Heartbeat:Connect(function()
	local ok, result = pcall(require, localPlayer.PlayerScripts.Aero.Controllers.Player)
	if not ok then
		return
	end
	local movement = result.Character and result.Character.Movement
	if not movement then
		return
	end
	local walkSpring = movement.WalkSpring

	if walkSpring and not walkSpring._citraSpeed then
		walkSpring._citraSpeed = true
		local setGoal = walkSpring.SetGoal

		walkSpring.SetGoal = function(arg, arg2)
			if fn2("MV_Speed") then
				local v5 = fn4()

				if v5 and v5:GetAttribute("CanMove") and arg2 == arg2 and arg2 > 0 then
					local attribute = v5:GetAttribute("WalkSpeed") or 0
					local MV_SpeedVal = fn3("MV_SpeedVal", 14)
					local n7 = math.min(attribute, 14)
					local n8 = math.min(attribute, MV_SpeedVal)

					if n7 > 0 and n8 > n7 then
						arg2 *= n8 / n7
					end
				end
			end

			return setGoal(arg, arg2)
		end
	end

	local guard = movement.Types and movement.Types.Guard

	if guard and not guard._citraSpeed then
		guard._citraSpeed = true
		local updateSpeed = guard.UpdateSpeed

		guard.UpdateSpeed = function(arg, arg2)
			updateSpeed(arg, arg2)
			if not fn2("MV_Speed") then
				return
			end
			local movement2 = arg.Movement
			local attribute = movement2.State:GetAttribute("WalkSpeed") or 0
			local MV_SpeedVal = fn3("MV_SpeedVal", 14)
			MV_SpeedVal = attribute > MV_SpeedVal and MV_SpeedVal or attribute
			local desiredSpeed = movement2.State:GetAttribute("CanMove") and movement2.MoveDirection.Magnitude > 0

			if desiredSpeed then
				desiredSpeed = movement2:IsSprinting()

				if desiredSpeed then
					desiredSpeed = (movement2.Character.model:GetAttribute("Stamina") or 0) > 0.25
				end

				desiredSpeed = desiredSpeed and MV_SpeedVal + 3.5 or MV_SpeedVal + 2.5 or 0
			end

			arg.DesiredSpeed = desiredSpeed or 0

			if arg.DesiredSpeed > 0 then
				if math.abs(movement2.rightValue) < 0.85 and movement2.forwardValue < 0 then
					arg.DesiredSpeed = arg.DesiredSpeed * 0.95
				end

				if math.abs(movement2.rightValue) > 0.5 and math.abs(movement2.forwardValue) < 0.5 then
					arg.DesiredSpeed = arg.DesiredSpeed * 1.05
				end

				if movement2.rightValue < 0.25 and movement2.forwardValue < -0.5 then
					arg.DesiredSpeed = arg.DesiredSpeed * 0.85
				end
			end

			if arg.DesiredSpeed ~= arg.DesiredSpeed then
				arg.DesiredSpeed = 0
			end
		end
	end
end))

fn(RunService.Heartbeat:Connect(function()
	if not fn2("MV_Speed") then
		return
	end
	local v5 = fn4()
	if not v5 then
		return
	end
	local MV_SpeedVal = fn3("MV_SpeedVal", 14)

	if v5:GetAttribute("WalkSpeed") ~= MV_SpeedVal then
		v5:SetAttribute("WalkSpeed", MV_SpeedVal)
	end
end))

local function fn17()
	local hoops = workspace:FindFirstChild("Hoops")
	local humanoidRootPart = fn4()
	humanoidRootPart = humanoidRootPart and humanoidRootPart:FindFirstChild("HumanoidRootPart")
	if not hoops or not humanoidRootPart then
		return nil
	end
	local v5 = nil
	local v6 = nil

	for _, child in ipairs(hoops:GetChildren()) do
		local rim = child:FindFirstChild("Rim", true)

		if rim and rim:IsA("BasePart") then
			local magnitude = (rim.Position - humanoidRootPart.Position).Magnitude

			if not v5 or magnitude < v5 then
				v5 = magnitude
				v6 = rim
			end
		end
	end

	return v6, v5
end

local function fn18()
	local v5 = fn4()
	local humanoidRootPart = v5 and v5:FindFirstChild("HumanoidRootPart")
	local characters = workspace:FindFirstChild("Characters")
	if not humanoidRootPart or not characters then
		return {}
	end
	local attribute = v5:GetAttribute("Team")
	local tbl7 = {}

	for _, child in ipairs(characters:GetChildren()) do
		if child ~= v5 then
			local attribute2 = child:GetAttribute("Team")

			if attribute == 0 or attribute2 ~= attribute then
				local humanoidRootPart2 = child:FindFirstChild("HumanoidRootPart")

				if humanoidRootPart2 then
					tbl7[#tbl7 + 1] = { char = child, dist = (humanoidRootPart2.Position - humanoidRootPart.Position).Magnitude }
				end
			end
		end
	end

	return tbl7
end

local n7 = 7

local function fn19(arg)
	if arg >= n7 then
		return 0
	end
	return math.min(1, 1 / arg)
end

local function fn20(arg, arg2)
	local humanoidRootPart = arg2:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return false
	end
	local n8 = (arg.Position - humanoidRootPart.Position) * Vector3.new(1, 0, 1)
	if n8.Magnitude < 0.01 then
		return true
	end
	return n8.Unit:Dot(arg.CFrame.LookVector * Vector3.new(1, 0, 1)) > 0
end

local function fn21()
	local v5 = fn4()
	local humanoidRootPart = v5 and v5:FindFirstChild("HumanoidRootPart")
	local characters = workspace:FindFirstChild("Characters")
	if not humanoidRootPart or not characters then
		return 0, math.huge, false
	end
	local attribute = v5:GetAttribute("Team")
	local huge = math.huge
	local flag3 = false

	for _, child in ipairs(characters:GetChildren()) do
		if child ~= v5 then
			local attribute2 = child:GetAttribute("Team")

			if attribute == 0 or attribute2 ~= attribute then
				local humanoidRootPart2 = child:FindFirstChild("HumanoidRootPart")

				if humanoidRootPart2 then
					local magnitude = (humanoidRootPart2.Position - humanoidRootPart.Position).Magnitude

					if magnitude < huge then
						flag3 = fn20(humanoidRootPart, child)
						huge = magnitude
					end
				end
			end
		end
	end

	local v6 = fn19(huge)

	if huge < n7 and not flag3 then
		v6 *= 0.5
	end

	return v6, huge, flag3
end

local function fn22(arg, arg2)
	local v5 = fn19(arg2.dist)

	if arg2.dist < n7 and not fn20(arg, arg2.char) then
		v5 *= 0.5
	end

	return v5
end

local function fn23(arg)
	return Color3.fromHSV(0.33 * (1 - math.clamp(arg, 0, 1)), 0.9, 1)
end

local tbl7 = {}

local function fn24(adornee)
	local v5 = tbl7[adornee]
	if v5 and v5.h and v5.h.Parent then
		return v5
	end
	local highlight = Instance.new("Highlight")
	highlight.Name = "CitraContest"
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.FillTransparency = 0.55
	highlight.OutlineTransparency = 0.35
	highlight.Adornee = adornee
	highlight.Parent = adornee
	local head = adornee:FindFirstChild("Head")
	local billboardGui = Instance.new("BillboardGui")
	billboardGui.Name = "CitraContestTag"
	billboardGui.AlwaysOnTop = true
	billboardGui.Size = UDim2.fromOffset(56, 20)
	billboardGui.StudsOffset = Vector3.new(0, head and head.Size.Y + 1.2 or 3.5, 0)
	billboardGui.Adornee = head
	billboardGui.MaxDistance = 300
	billboardGui.Parent = adornee
	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.BackgroundColor3 = Color3.new(0, 0, 0)
	textLabel.BackgroundTransparency = 0.3
	textLabel.BorderSizePixel = 0
	textLabel.Font = Enum.Font.GothamBold
	textLabel.TextSize = 14
	textLabel.Text = "--%"
	textLabel.TextColor3 = Color3.new(1, 1, 1)
	textLabel.Parent = billboardGui
	local tbl8 = { h = highlight, tag = billboardGui, lbl = textLabel }
	tbl7[adornee] = tbl8
	return tbl8
end

local function fn25()
	for _, v5 in pairs(tbl7) do
		pcall(function()
			v5.h:Destroy()
		end)

		pcall(function()
			v5.tag:Destroy()
		end)
	end

	table.clear(tbl7)
end

local function fn26()
	for k, v5 in pairs(tbl7) do
		if not v5.h.Parent then
			tbl7[k] = nil
		end
	end

	if not fn2("VZ_Chams") then
		fn25()
		return
	end
	local v5 = fn4()
	local characters = workspace:FindFirstChild("Characters")
	if not v5 or not characters then
		fn25()
		return
	end
	local humanoidRootPart = v5:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		fn25()
		return
	end
	local tbl8 = {}

	for _, v6 in ipairs(fn18()) do
		tbl8[v6.char] = true
		local v7 = fn22(humanoidRootPart, v6)
		local v8 = fn24(v6.char)
		local v9 = fn23(v7)
		v8.h.FillColor = v9
		v8.h.OutlineColor = v9
		local text = ("%d%%"):format(v7 * 100)

		if v8.lbl.Text ~= text then
			v8.lbl.Text = text
		end

		v8.lbl.TextColor3 = v9
	end

	for k, v6 in pairs(tbl7) do
		if not tbl8[k] then
			pcall(function()
				v6.h:Destroy()
			end)

			pcall(function()
				v6.tag:Destroy()
			end)

			tbl7[k] = nil
		end
	end
end

task.spawn(function()
	while not (v and v.Unloaded) do
		pcall(fn26)
		task.wait(0.1)
	end
end)

local v5, v6

v, v2, v3, v5, v6 = loadstring(game:HttpGet("https://raw.githubusercontent.com/gilgameshfate59/ohbfoosk8tid/main/CitraUI.lua"))().Shim:Init({
	Name = "Citra",
	SubName = "Practical Basketball",
	Logo = "102010944233602",
	Accent = Color3.fromRGB(255, 138, 32),
	ShowTabIcons = false,
	ConfigFolder = "PracticalCitra/configs",
	ThemeFolder = "PracticalCitra",
})

local v7 = v:CreateWindow({
	Title = "Citra Hub | Practical Basketball",
	Center = true,
	AutoShow = true,
	TabPaddingX = 8,
	MenuFadeTime = 0.2,
})

v.ToggleKeybind = Enum.KeyCode.RightShift
local Shooting = v7:AddTab("Shooting")
local v8 = Shooting:AddLeftGroupbox("Auto Green")
local v9 = Shooting:AddRightGroupbox("Release Window")

v8:AddToggle("AG_Enabled", {
	Text = "Enable Auto Green",
	Default = false,
	Tooltip = "Hold the shoot key -- the release is sent for you when the projected landing point reaches your window.",
}):AddKeyPicker("AG_Key", { Default = "G", SyncToggleState = true, Mode = "Toggle", Text = "Auto Green" })

v8:AddToggle("AG_AutoTune", {
	Text = "Auto-Tune",
	Default = true,
	Tooltip = "Learns the release point from greens that actually happen -- including ones you hit manually. Until the first green it hunts upward and backs off on late shots. Overrides the Release At slider while on.",
})

v8:AddButton({
	Text = "Reset Tuning",
	Func = function()
		table.clear(tbl3)
		n3 = nil
		n2 = nil
		local v10 = stats
		local v11 = stats
		local v12 = stats
		stats.green = 0
		v10.early = 0
		v11.late = 0
		v12.nofire = 0
		table.clear(history)

		if v then
			v:Notify("Tuning reset.", 2)
		end
	end,
})

v9:AddSlider("AG_ReleaseAt", {
	Text = "Release At",
	Default = 97,
	Min = 40,
	Max = 110,
	Rounding = 0,
	Suffix = "%",
	Tooltip = "How far up the bar to release. This is the only timing number there is. Auto-Tune takes it over as soon as it has seen one real green, and sets it from where your greens actually land.",
})

v9:AddToggle("AG_AutoPing", {
	Text = "Auto Ping",
	Default = true,
	Tooltip = "Measures how far the bar actually travels between sending the release and the server freezing it, and uses that as the lead. More accurate than the ping counter, which only measures the network and not the server's own processing. Off = use raw measured ping.",
})

local Dribbling = v7:AddTab("Dribbling")
local Movement = Dribbling:AddLeftGroupbox("Movement")
local v10 = Dribbling:AddRightGroupbox("Auto Combo")

Movement:AddToggle("DR_NoStun", {
	Text = "No Stun",
	Default = false,
	Tooltip = "A dribble move sets CanMove/CanTurn false and Debounce true for ~730ms. This clears all three each frame so you keep control through the animation.",
})

Movement:AddToggle("DR_InfStamina", {
	Text = "Infinite Stamina",
	Default = false,
	Tooltip = "Pins the client Stamina attribute to 100. Your real pool still drains and regenerates on the server -- but the client is what reads stamina to grant the sprint bonus and to report that you stopped sprinting, and it never sees a low value.",
})

Movement:AddToggle("MV_Speed", {
	Text = "Walk Speed",
	Default = false,
	Tooltip = "Lifts the client's 14 stud/sec cap on the WalkSpeed attribute (Movement.UpdateSpeed throws anything higher away) and pins the attribute to the slider. The game drives movement with a client BodyVelocity, so nothing else re-checks the speed. Sprint still adds a flat 3.35 on top.",
})

Movement:AddSlider("MV_SpeedVal", {
	Text = "Speed",
	Default = 14,
	Min = 10,
	Max = 40,
	Rounding = 1,
	Suffix = " st/s",
	Tooltip = "Your base speed with the 14 cap removed. Base build is 13.1 -- 14 is the old ceiling, 40 is roughly double speed. Sprint adds +3.35 while it holds. Guard stance has its own 27.5 st/s hard cap in the game's code, so it tops out there.",
})

v10:AddToggle("DR_ComboEnabled", {
	Text = "Enable Auto Combo",
	Default = false,
	Tooltip = "Master switch. The slot keys do nothing while this is off.",
})

v10:AddSlider("DR_ComboDelay", {
	Text = "Move Gap",
	Default = 260,
	Min = 80,
	Max = 800,
	Rounding = 0,
	Suffix = "ms",
	Tooltip = "Wait between moves. The game has its own 0.15s DribbleDelay window and drops inputs fired faster than that.",
})

v10:AddToggle("DR_ComboSprint", {
	Text = "Sprint During Combo",
	Default = false,
	Tooltip = "Passed as the sprint flag, same as holding shift while comboing.",
})

local tbl8 = {}

for i = 1, 3 do
	local v11 = Dribbling:AddRightGroupbox("Combo Slot " .. i)
	tbl8[i] = v11:AddLabel("Key: " .. tbl6[i])

	v11:AddButton({
		Text = "Set Keybind",
		Func = function()
			v4 = i
			tbl8[i]:SetText("Press any key...  (Esc cancels)")
		end,
	})

	for i2 = 1, 5 do
		v11:AddDropdown(("DR_S%dM%d"):format(i, i2), {
			Values = tbl5,
			Default = 1,
			Multi = false,
			Text = "Move " .. i2,
			Tooltip = i2 == 1 and "Moves are by name -- the key combo is resolved from whichever hand you are on when it fires." or nil,
		})
	end

	v11:AddButton({
		Text = "Run Now",
		Func = function()
			fn15(i)
		end,
	})
end

fn(UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if input.UserInputType ~= Enum.UserInputType.Keyboard then
		return
	end
	local name = input.KeyCode.Name

	if v4 then
		local v11 = v4
		v4 = nil

		if name ~= "Escape" then
			tbl6[v11] = name
			fn14()
		end

		tbl8[v11]:SetText("Key: " .. tbl6[v11])
		return
	end

	if gameProcessed then
		return
	end

	for i = 1, 3 do
		if name == tbl6[i] then
			fn15(i)
			return
		end
	end
end))

local Defense = v7:AddTab("Defense")
local v11 = Defense:AddLeftGroupbox("Auto Guard")
local v12 = Defense:AddRightGroupbox("Auto Ankle Breaker")
local v13 = Defense:AddLeftGroupbox("Auto Block")

v11:AddToggle("DF_AutoGuard", {
	Text = "Auto Guard",
	Default = false,
	Tooltip = "Uses the game's own guard AI (the one bound to K for the developers). Hold your guard key -- it only engages in guard stance -- and it stays between the ballhandler and the hoop, leading their movement.",
}):AddKeyPicker("DF_GuardKey", { Default = "K", SyncToggleState = true, Mode = "Toggle", Text = "Auto Guard" })

v11:AddSlider("DF_GuardSmooth", {
	Text = "Smoothness",
	Default = 8,
	Min = 1,
	Max = 35,
	Rounding = 0,
	Tooltip = "How hard it snaps onto the target. This is the game's own lerp rate; it defaults to 25, which looks robotic. Lower eases onto the ballhandler instead of tracking them perfectly. Higher sticks tighter but reads as inhuman.",
})

v12:AddToggle("DF_Ankle", {
	Text = "Auto Ankle Breaker",
	Default = false,
	Tooltip = "Fires your chosen dribble move the moment a nearby opponent goes for a steal (their Action becomes \"Stealing\"). 12 stud range, one move per attempt.",
})

v12:AddDropdown("DF_AnkleMove", {
	Values = tbl5,
	Default = 1,
	Multi = false,
	Text = "Move",
	Tooltip = "Which dribble move to throw. Picked by name -- the key combo is resolved from whichever hand you are on at the moment they reach.",
})

v13:AddToggle("DF_AutoBlock", {
	Text = "Auto Block",
	Default = false,
	Tooltip = "Blocks when another player starts a shot within 5 studs. There is no block remote -- blocking is the space input, which fires Shoot(UseSpace) and Jump together.",
}):AddKeyPicker("DF_BlockKey", { Default = "J", SyncToggleState = true, Mode = "Toggle", Text = "Auto Block" })

v13:AddSlider("DF_BlockDelay", {
	Text = "Block Delay",
	Default = 150,
	Min = 0,
	Max = 800,
	Rounding = 0,
	Suffix = "ms",
	Tooltip = "Wait after their shot starts before jumping. The shot meter sweeps for ~390ms, so 0 jumps the instant they begin and higher values jump closer to their release.",
})

local Visuals = v7:AddTab("Visuals")
local Contest = Visuals:AddLeftGroupbox("Contest")
local Tracer = Visuals:AddRightGroupbox("Tracer")

Contest:AddToggle("VZ_Chance", {
	Text = "Contested %",
	Default = false,
	Tooltip = "Live readout of how contested a shot from where you stand would be, calibrated to the game's own post-shot number (measured 20% @ 5 studs, 25% @ 4, 35% @ 3). A defender in front of you counts at the game's rate; one nearby but not in front counts half of it (the potential if they jumped). 0% (green) at 7+ studs.",
})

Contest:AddToggle("VZ_Chams", {
	Text = "Contest Chams",
	Default = false,
	Tooltip = "Highlights every opponent through walls, colored by their own contested rate: green = open (7+ studs), yellow = closing in, red = right on top of you. Defenders in front of you read at the game's real rate; ones behind you read half. Uses a separate Highlight so the game's own pass highlight is untouched.",
})

Tracer:AddToggle("VZ_Tracer", {
	Text = "Tracer To Hoop",
	Default = false,
	Tooltip = "Line from the bottom of your screen to the nearest rim. Uses workspace.Hoops.<hoop>.Rim, so it tracks the real rim rather than the backboard.",
})

local Settings = v7:AddTab("Settings")
v5:SetLibrary(v)

pcall(function()
	v5:ApplyToTab(Settings)
end)

v6:SetLibrary(v)

pcall(function()
	v6:IgnoreThemeSettings()
end)

pcall(function()
	v6:SetFolder("PracticalCitra")
end)

pcall(function()
	v6:BuildConfigSection(Settings)
end)

local tbl9 = {
	bg = Color3.fromRGB(10, 10, 11),
	panel = Color3.fromRGB(16, 16, 17),
	line = Color3.fromRGB(255, 138, 32),
	accent = Color3.fromRGB(168, 85, 247),
	text = Color3.fromRGB(233, 233, 234),
	sub = Color3.fromRGB(150, 150, 154),
	green = Color3.fromRGB(78, 205, 120),
	red = Color3.fromRGB(232, 84, 84),
	aim = Color3.fromRGB(250, 204, 21),
}

local function fn27(arg, arg2, parent)
	local instance = Instance.new(arg)
	local v14 = pairs
	arg2 = arg2 or {}

	for k, v15 in v14(arg2) do
		instance[k] = v15
	end

	if parent then
		instance.Parent = parent
	end

	return instance
end

local ScreenGui = fn27("ScreenGui", {
	Name = "CitraHud",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	DisplayOrder = 999995,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
})

pcall(function()
	ScreenGui.Parent = gethui and gethui() or localPlayer:WaitForChild("PlayerGui")
end)

local Frame = fn27("Frame", {
	Size = UDim2.fromOffset(150, 44),
	Position = UDim2.new(0.5, -75, 0.72, 0),
	BackgroundColor3 = tbl9.bg,
	BackgroundTransparency = 0.25,
	BorderSizePixel = 0,
	Visible = false,
}, ScreenGui)

fn27("UIStroke", { Color = tbl9.line, Thickness = 1 }, Frame)

local TextLabel = fn27("TextLabel", {
	Size = UDim2.new(1, 0, 0, 24),
	Position = UDim2.fromOffset(0, 3),
	BackgroundTransparency = 1,
	Font = Enum.Font.GothamBold,
	TextSize = 20,
	TextColor3 = tbl9.text,
	Text = "--%",
}, Frame)

local TextLabel2 = fn27("TextLabel", {
	Size = UDim2.new(1, 0, 0, 12),
	Position = UDim2.fromOffset(0, 27),
	BackgroundTransparency = 1,
	Font = Enum.Font.GothamMedium,
	TextSize = 10,
	TextColor3 = tbl9.sub,
	Text = "",
}, Frame)

local Frame2 = fn27("Frame", {
	Size = UDim2.fromOffset(2, 2),
	BackgroundColor3 = tbl9.aim,
	BorderSizePixel = 0,
	AnchorPoint = Vector2.new(0.5, 0.5),
	Visible = false,
	ZIndex = 2,
}, ScreenGui)

fn(RunService.RenderStepped:Connect(function()
	if v and v.Unloaded then
		return
	end
	local currentCamera = workspace.CurrentCamera
	local VZ_Chance = fn2("VZ_Chance") or fn2("VZ_Tracer")
	local v14 = nil
	local v15 = nil
	local v16 = nil

	if VZ_Chance then
		v16, v14, v15 = fn21()
	end

	Frame.Visible = fn2("VZ_Chance") == true and v16 ~= nil

	if Frame.Visible then
		TextLabel.Text = ("%d%%"):format(v16 * 100)
		TextLabel.TextColor3 = fn23(v16)
		TextLabel2.Text = ("%.0f studs   %s"):format(v14, v14 >= n7 and "open" or v15 and "guarded" or "potential jump")
	end

	Frame2.Visible = false

	if fn2("VZ_Tracer") and currentCamera then
		local v17 = fn17()

		if v17 then
			local v18, v19 = currentCamera:WorldToViewportPoint(v17.Position)

			if v19 then
				local viewportSize = currentCamera.ViewportSize
				local vector2 = Vector2.new(viewportSize.X / 2, viewportSize.Y)
				local n8 = Vector2.new(v18.X, v18.Y) - vector2
				local n9 = vector2 + n8 / 2
				Frame2.Visible = true
				Frame2.Position = UDim2.fromOffset(n9.X, n9.Y)
				Frame2.Size = UDim2.fromOffset(n8.Magnitude, 2)
				Frame2.Rotation = math.deg(math.atan2(n8.Y, n8.X))
				Frame2.BackgroundColor3 = v16 and fn23(v16) or tbl9.aim
			end
		end
	end
end))

pcall(function()
	v:OnUnload(function()
		for _, v14 in ipairs(tbl) do
			if typeof(v14) == "RBXScriptConnection" then
				pcall(function()
					v14:Disconnect()
				end)
			end
		end

		pcall(function()
			ScreenGui:Destroy()
		end)

		pcall(fn25)
	end)
end)

Settings:AddLeftGroupbox("Hub"):AddButton({
	Text = "Unload",
	DoubleClick = true,
	Func = function()
		task.spawn(function()
			pcall(function()
				v:Unload()
			end)
		end)
	end,
})

pcall(function()
	v7:Init()
end)

pcall(function()
	v6:LoadAutoloadConfig()
end)

v:Notify("Citra | Practical Basketball loaded.", 4)
