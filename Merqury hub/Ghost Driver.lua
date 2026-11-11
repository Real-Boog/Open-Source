-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf

-- [ Fetcher ] loader: this script fetches https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua at run time
-- [ Fetcher ] loader: this script fetches https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/SaveManager.lua at run time
local function func()
	local ok, result = pcall(gethwid)

	if ok and result and result ~= "" then
		return result
	end

	return tostring(game:GetService("RbxAnalyticsService"):GetClientId()):gsub("-", "")
end

local function func1()
	for _, v1 in ipairs({
		function()
			return request
		end,
		function()
			return http_request
		end,
		function()
			return http and http.request
		end,
		function()
			return syn and syn.request
		end,
		function()
			return fluxus and fluxus.request
		end,
		function()
			return (getgenv or function()
				return {}
			end)().request
		end,
	}) do
		local ok, result = pcall(v1)
		if ok and type(result) == "function" then
			return result
		end
	end
	return nil
end

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if not (function()
	local ok, result = pcall(readfile, "MerquryHub_Key.txt")

	if not ok or not result or result == "" then
		LocalPlayer:Kick("Error S1")
		return false
	end

	local v1 = tostring(result):gsub("^[%s\n\r\t]+", ""):gsub("[%s\n\r\t]+$", "")
	local v2 = func1()

	if not v2 then
		LocalPlayer:Kick("Error S2")
		return false
	end

	local _, result1 = pcall(HttpService.JSONEncode, HttpService, {key_string = v1, hwid = func()})
	local num = 3

	while num > 0 do
		local ok1, result2 = pcall(v2, {
			Url = "https://sskgujtorprdelkjaupf.supabase.co/functions/v1/key-api?action=validate",
			Method = "POST",
			Headers = {["Content-Type"] = "application/json"},
			Body = result1,
		})

		if ok1 and result2 and type(result2) == "table" and result2.Body and result2.Body ~= "" then
			local ok2, result3 = pcall(HttpService.JSONDecode, HttpService, result2.Body)
			if ok2 and type(result3) == "table" then
				if result3.valid == true then
					return true
				end

				LocalPlayer:Kick("Error S3")
				return false
			end
		end

		num = num - 1
		task.wait(0.5)
	end

	LocalPlayer:Kick("Error S4")
	return false
end)() then
	return
end

local flag = false

pcall(function()
	local v1 = identifyexecutor()
	flag = v1 and string.lower(v1):find("velocity") ~= nil
end)

if flag then
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

local min = math.min
local max = math.max
local clamp = math.clamp
local sin = math.sin
local sqrt = math.sqrt
local atan2 = math.atan2
local abs = math.abs
local floor = math.floor
local random = math.random
local huge = math.huge
local new = Vector3.new
local zero = Vector3.zero
local new1 = CFrame.new
local fromEulerAnglesYXZ = CFrame.fromEulerAnglesYXZ
local vector3 = Vector3.new(0, -15, 0)
local wait = task.wait
local spawn = task.spawn
local format = string.format
local sort = table.sort
local concat = table.concat
local v1 = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/SaveManager.lua"))()

local Window = Library:CreateWindow({
	Title = "Merqury Hub",
	Footer = "Ghost Driver v1",
	Font = Enum.Font.GothamMedium,
	NotifySide = "Right",
	ShowCustomCursor = false,
	CornerRadius = 6,
	Animations = {ToggleWindow = false, TabSwitch = true, Dropdown = true},
})

local Options = Library.Options

local Tabs = {
	Main = Window:AddTab("Main", "house"),
	Misc = Window:AddTab("Misc", "sliders-horizontal"),
	Settings = Window:AddTab("UI Settings", "settings"),
}

local mainFeaturesGroupbox = Tabs.Main:AddLeftGroupbox("Main Features")
local autoFarmGroupbox = Tabs.Main:AddRightGroupbox("Auto Farm")
local autoFarmStatsGroupbox = Tabs.Main:AddRightGroupbox("Auto Farm Stats")
local carModifierGroupbox = Tabs.Main:AddLeftGroupbox("Car Modifier")
local webhookGroupbox = Tabs.Misc:AddLeftGroupbox("Webhook")
local funGroupbox = Tabs.Misc:AddRightGroupbox("Fun")
local flag1 = false
local v6
local flag2 = false
local flag3 = true
local flag4 = false
local flag5 = false
local v7
local num = 0
local func11
local num1 = 0

local function func2()
	if not getconnections then
		return
	end

	local v2 = tick()

	if v2 - num1 < 4 then
		return
	end

	num1 = v2

	pcall(function()
		for _, v2 in ipairs(getconnections(v1.Idled)) do
			if v2.Disable then
				v2:Disable()
			elseif v2.Disconnect then
				v2:Disconnect()
			end
		end
	end)
end

local function func3()
	local PlayerGui = v1:FindFirstChild("PlayerGui")

	if not PlayerGui then
		return
	end

	pcall(function()
		for _, child in ipairs(PlayerGui:GetChildren()) do
			if child:IsA("ScreenGui") and child.Enabled then
				local v1 = child.Name:lower()
				local v2 = v1:find("afk") or v1:find("idle") or v1:find("inact")

				if not v2 then
					for _, descendant in ipairs(child:GetDescendants()) do
						if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
							local v3 = descendant.Text:lower()
							if
								v3:find("are you")
								or v3:find("still there")
								or v3:find("still playing")
								or v3:find("afk")
								or v3:find("inactivity")
							then
								v2 = true
								break
							end
						end
					end
				end

				if v2 then
					for _, descendant1 in ipairs(child:GetDescendants()) do
						if descendant1:IsA("TextButton") or descendant1:IsA("ImageButton") then
							pcall(function()
								if firesignal then
									firesignal(descendant1.Activated)
									firesignal(descendant1.MouseButton1Click)
								end
							end)
						end
					end
					pcall(function()
						child.Enabled = false
					end)
				end
			end
		end
	end)
end

local InputHeartbeat
local v8
local v9

local function func4()
	pcall(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")

		if not v9 then
			local Packages = ReplicatedStorage:FindFirstChild("Packages")
			local v1 = Packages and Packages:FindFirstChild("Remotes")

			if v1 and v1:IsA("ModuleScript") then
				local ok, result = pcall(require, v1)
				if ok and type(result) == "table" then
					v9 = result
					if result.InputHeartbeat then
						InputHeartbeat = result.InputHeartbeat
					end
				end
			end
		end

		if not v8 then
			local Controllers = ReplicatedStorage:FindFirstChild("Controllers")
			local v2 = Controllers and Controllers:FindFirstChild("InputHeartbeatController")

			if v2 and v2:IsA("ModuleScript") then
				local ok1, result1 = pcall(require, v2)
				if ok1 and type(result1) == "table" then
					v8 = result1
				end
			end
		end

		if not InputHeartbeat then
			local InputHeartbeat1 = ReplicatedStorage:FindFirstChild("InputHeartbeat", true)
			if InputHeartbeat1 and (InputHeartbeat1:IsA("RemoteEvent") or InputHeartbeat1:IsA("UnreliableRemoteEvent")) then
				InputHeartbeat = InputHeartbeat1
			end
		end
	end)
end

local function func5()
	func4()

	if v8 then
		pcall(function()
			v8.pending = true
			if type(v8.Report) == "function" then
				v8:Report()
			end
		end)
	end

	if InputHeartbeat then
		pcall(function()
			InputHeartbeat:FireServer()
		end)
	end

	if v9 and v9.InputHeartbeat and v9.InputHeartbeat ~= InputHeartbeat then
		pcall(function()
			v9.InputHeartbeat:FireServer()
		end)
	end

	if getconnections then
		pcall(function()
			local UserInputService = game:GetService("UserInputService")

			local tbl = {
				UserInputType = Enum.UserInputType.Touch,
				UserInputState = Enum.UserInputState.Begin,
				KeyCode = Enum.KeyCode.Unknown,
				Position = new(0, 0, 0),
				Delta = new(0, 0, 0),
			}

			for _, v1 in ipairs(getconnections(UserInputService.InputBegan)) do
				pcall(function()
					v1:Fire(tbl)
				end)
			end

			for _, v2 in ipairs(getconnections(UserInputService.InputEnded)) do
				pcall(function()
					v2:Fire(tbl)
				end)
			end
		end)
	end
end

local function func6(arg1)
	flag5 = arg1
	if arg1 then
		func2()
		func5()
	end
end

pcall(function()
	v1.Idled:Connect(function()
		if flag5 or flag2 then
			func2()
			func5()
		end
	end)
end)

spawn(function()
	while true do
		wait(3)
		if flag5 or flag2 then
			func5()
			func2()
			func3()

			pcall(function()
				local CurrentCamera = Workspace.CurrentCamera
				if CurrentCamera then
					local CFrame1 = CurrentCamera.CFrame
					CurrentCamera.CFrame = CFrame1 * fromEulerAnglesYXZ(random(-1, 1) * 0.0004, random(-1, 1) * 0.0004, 0)
					wait(0.04)
					CurrentCamera.CFrame = CFrame1
				end
			end)

			pcall(function()
				local v2 = func11 and func11()
				if v2 then
					local v3 = v2.PrimaryPart or v2:FindFirstChild("DriveSeat") or v2:FindFirstChildWhichIsA("BasePart")
					if v3 then
						local AssemblyLinearVelocity = v3.AssemblyLinearVelocity
						v3.AssemblyLinearVelocity = new(AssemblyLinearVelocity.X, AssemblyLinearVelocity.Y + 0.0005, AssemblyLinearVelocity.Z)
					end
				else
					local Character = v1.Character
					local v4 = Character and Character:FindFirstChild("HumanoidRootPart")
					local v5 = Character and Character:FindFirstChildWhichIsA("Humanoid")

					if v5 and v4 and not v5.SeatPart then
						v5:Move(new(0, 0, 0), false)
						local CFrame1 = v4.CFrame
						v4.CFrame = CFrame1 * new1(0, 0.0005, 0)
						wait(0.04)
						v4.CFrame = CFrame1
					end
				end
			end)

			pcall(function()
				if firesignal then
					local Mouse = v1:GetMouse()
					if Mouse then
						firesignal(Mouse.Move)
						firesignal(Mouse.Idle)
					end
				end
			end)

			if mousemoverel then
				pcall(function()
					local v1 = random(-2, 2)
					local v2 = random(-2, 2)

					if v1 == 0 and v2 == 0 then
						v1 = 1
					end

					mousemoverel(v1, v2)
					wait(0.04)
					mousemoverel(-v1, -v2)
				end)
			end
		end
	end
end)

local function func7()
	local v2 = v1:FindFirstChild("leaderstats") or v1.WaitForChild and v1:WaitForChild("leaderstats", 1)

	if v2 then
		local v3 = v2:FindFirstChild("Cash") or v2:FindFirstChild("cash") or v2:FindFirstChild("Money")
		if v3 then
			local Value = v3.Value

			if type(Value) == "string" then
				Value = tonumber((Value:gsub("[^%d%.%-]", ""))) or 0
			end

			return tonumber(Value) or 0
		end
	end

	return 0
end

local function func8(arg1)
	local v1 = floor(arg1 / 3600)
	local v2 = floor(arg1 % 3600 / 60)
	local v3 = floor(arg1 % 60)

	if v1 > 0 then
		return format("%dh %dm %ds", v1, v2, v3)
	end

	return format("%dm %ds", v2, v3)
end

local function func9(arg1)
	local v1 = arg1 < 0
	local v2 = abs(floor(arg1))
	local str = tostring(v2)
	local v3 = #str

	if v3 <= 3 then
		return (v1 and "-" or "") .. str
	end

	local tbl = {}
	local v4 = v3 % 3

	if v4 > 0 then
		tbl[1] = str:sub(1, v4)
	end

	for i = v4 + 1, v3, 3 do
		tbl[#tbl + 1] = str:sub(i, i + 2)
	end

	return (v1 and "-" or "") .. concat(tbl, ",")
end

local Label = autoFarmStatsGroupbox:AddLabel("Duration ?")
local Label1 = autoFarmStatsGroupbox:AddLabel("Money Made ?")

spawn(function()
	local str = "Duration ?"
	local str1 = "Money Made ?"

	while true do
		wait(2)
		if flag2 and v7 then
			local v1 = tick() - v7
			local v2 = func7()
			local v3 = max(0, v2 - num)
			local v4 = "Duration " .. func8(v1)
			local v5 = "Money Made " .. func9(v3)

			if v4 ~= str or v5 ~= str1 then
				str = v4
				str1 = v5
				pcall(Label.SetText, Label, v4)
				pcall(Label1.SetText, Label1, v5)
			end
		elseif str ~= "Duration ?" then
			str = "Duration ?"
			str1 = "Money Made ?"
			pcall(Label.SetText, Label, "Duration ?")
			pcall(Label1.SetText, Label1, "Money Made ?")
		end
	end
end)

local tbl = {
	TrafficCollisionFront = true,
	TrafficCollisionRear = true,
	TrafficCollisionLeft = true,
	TrafficCollisionRight = true,
}

if hookfunction then
	local v2
	v2 = hookfunction(Workspace.GetPartsInPart, function(arg1, arg2, ...)
		if flag1 then
			local v1 = arg1

			if typeof(arg1) ~= "Instance" or not arg1:IsA("BasePart") then
				v1 = arg2
			end

			if v1 and typeof(v1) == "Instance" and v1:IsA("BasePart") and tbl[v1.Name] then
				return {}
			end
		end
		return v2(arg1, arg2, ...)
	end)
end

local v10
local v3 = v1.Name .. "_"
local v4 = #v3

local function func10()
	local Children = Workspace:GetChildren()

	for i = 1, #Children do
		local v1 = Children[i]
		if v1.Name:sub(1, v4) == v3 then
			return v1
		end
	end

	return nil
end

local v5 = func10()

Workspace.ChildAdded:Connect(function(child)
	if child.Name:sub(1, v4) == v3 then
		v5 = child
		v10 = nil
	end
end)

Workspace.ChildRemoved:Connect(function(child)
	if child == v5 then
		v5 = nil
		v10 = nil
	end
end)

function func11()
	if v5 and v5.Parent then
		return v5
	end

	v5 = func10()
	return v5
end

local function func12(arg1)
	if not arg1 then
		return nil
	end

	if v10 and v10.Parent and (v10 == arg1.PrimaryPart or v10:IsDescendantOf(arg1)) then
		return v10
	end

	if arg1.PrimaryPart then
		v10 = arg1.PrimaryPart
		return v10
	end

	for _, descendant in ipairs(arg1:GetDescendants()) do
		if descendant:IsA("VehicleSeat") then
			v10 = descendant
			return v10
		end
	end

	v10 = arg1:FindFirstChildWhichIsA("BasePart", true)
	return v10
end

local function func13(arg1, arg2)
	if not arg1 then
		return
	end

	arg1:PivotTo(arg2)
	local v1 = func12(arg1)

	if v1 then
		v1.AssemblyLinearVelocity = zero
		v1.AssemblyAngularVelocity = zero
	end
end

local tbl1 = {
	1,
	-3498.043,
	65.015,
	-956.957,
	2,
	-3498.043,
	65.015,
	-3036.526,
	3,
	-3498.043,
	65.015,
	-3041.62,
	4,
	-3533.721,
	65.015,
	-4063.288,
	5,
	-3534.171,
	65.015,
	-4076.178,
	6,
	-3605.602,
	65.015,
	-5097.686,
	7,
	-3607.197,
	65.015,
	-5108.058,
	8,
	-3749.547,
	65.015,
	-6120.933,
	9,
	-3752.134,
	65.015,
	-6136.29,
	10,
	-3964.4,
	65.015,
	-7134.924,
	11,
	-3966.183,
	65.015,
	-7144.006,
	12,
	-4246.116,
	65.015,
	-8120.249,
	13,
	-4252.843,
	65.015,
	-8141.543,
	14,
	-4600.838,
	65.015,
	-9096.69,
	15,
	-4614.419,
	65.015,
	-9129.494,
	16,
	-5019.61,
	65.015,
	-10039.565,
	17,
	-5029.455,
	65.015,
	-10058.796,
	18,
	-5507.205,
	65.015,
	-10957.312,
	19,
	-5518.881,
	65.015,
	-10977.954,
	20,
	-6054.175,
	65.015,
	-11834.604,
	21,
	-6066.319,
	65.015,
	-11853.404,
	22,
	-6658.75,
	65.015,
	-12668.814,
	23,
	-6674.622,
	65.015,
	-12689.633,
	24,
	-7325.39,
	65.015,
	-13465.188,
	25,
	-7336.361,
	65.015,
	-13478.188,
	26,
	-8038.745,
	65.015,
	-14204.352,
	27,
	-8063.86,
	65.015,
	-14228.449,
	28,
	-8810.143,
	65.015,
	-14900.406,
	29,
	-8830.168,
	65.015,
	-14917.765,
	30,
	-9631.776,
	65.015,
	-15544.049,
	31,
	-9643.704,
	65.015,
	-15552.767,
	32,
	-10485.223,
	65.015,
	-16120.379,
	33,
	-10497.809,
	65.015,
	-16128.049,
	34,
	-11378.225,
	65.015,
	-16636.816,
	35,
	-11398.585,
	65.015,
	-16647.174,
	36,
	-12318.106,
	65.015,
	-17075.951,
	37,
	-12331.896,
	65.015,
	-17082.811,
	38,
	-13219.254,
	65.015,
	-17595.127,
	39,
	-13235.771,
	65.015,
	-17605.85,
	40,
	-14074.358,
	65.015,
	-18193.035,
	41,
	-14088.821,
	65.015,
	-18204.42,
	42,
	-14868.521,
	65.015,
	-18858.666,
	43,
	-14880.041,
	65.015,
	-18867.641,
	44,
	-15712.073,
	65.015,
	-19450.236,
	45,
	-15728.501,
	65.015,
	-19460.793,
	46,
	-16602.4,
	65.015,
	-19965.34,
	47,
	-16621.977,
	65.015,
	-19975.711,
	48,
	-17534.688,
	65.015,
	-20401.314,
	49,
	-17556.514,
	65.015,
	-20410.77,
	50,
	-18502.857,
	65.015,
	-20755.211,
	51,
	-18531.668,
	65.015,
	-20764.924,
	52,
	-23313.986,
	65.015,
	-22046.344,
	53,
	-23340.127,
	65.015,
	-22052.303,
	54,
	-24094.854,
	65.015,
	-22185.383,
	55,
	-24118.742,
	65.015,
	-22189.215,
	56,
	-24799.096,
	65.015,
	-22212.971,
	57,
	-24840.014,
	65.015,
	-22211.301,
	58,
	-25536.734,
	65.015,
	-22138.072,
	59,
	-25569.287,
	65.015,
	-22133.227,
	60,
	-26275.623,
	65.015,
	-21957.117,
	61,
	-26296.662,
	65.015,
	-21950.369,
	62,
	-26970.207,
	65.015,
	-21678.238,
	63,
	-26985.449,
	65.015,
	-21670.936,
	64,
	-27617.189,
	65.015,
	-21306.197,
	65,
	-27641.93,
	65.015,
	-21289.209,
	66,
	-28210.529,
	65.015,
	-20844.971,
	67,
	-28231.795,
	65.015,
	-20825.322,
	68,
	-28631.611,
	65.015,
	-20411.301,
	69,
	-28645.545,
	65.015,
	-20395.904,
	70,
	-28986.678,
	65.015,
	-19926.379,
	71,
	-28999.66,
	65.015,
	-19905.602,
	72,
	-29213.018,
	65.015,
	-19504.334,
	73,
	-29224.795,
	65.015,
	-19479.807,
	74,
	-29578.904,
	65.015,
	-18603.352,
	75,
	-29582.76,
	65.015,
	-18593.807,
	76,
	-29606.359,
	65.015,
	-18540.803,
	77,
	-29614.121,
	65.015,
	-18525.062,
	78,
	-29755.676,
	65.015,
	-18269.689,
	79,
	-29765.725,
	65.015,
	-18249.844,
	80,
	-29878.182,
	65.015,
	-17997.26,
	81,
	-29889.789,
	65.015,
	-17968.611,
	82,
	-29978.205,
	65.015,
	-17711.832,
	83,
	-29990.998,
	65.015,
	-17665.506,
	84,
	-30050.902,
	65.015,
	-17425.246,
	85,
	-30057.74,
	65.015,
	-17392.262,
	86,
	-30100.502,
	65.015,
	-17122.283,
	87,
	-30103.828,
	65.015,
	-17090.658,
	88,
	-30123.145,
	65.015,
	-16814.414,
	89,
	-30123.668,
	65.015,
	-16774.633,
	90,
	-30118.947,
	65.015,
	-16504.193,
	91,
	-30115.145,
	65.015,
	-16451.895,
	92,
	-30088.197,
	65.015,
	-16195.52,
	93,
	-30085.979,
	65.015,
	-16156.222,
	94,
	-30081.094,
	65.015,
	-15876.424,
	95,
	-30081.611,
	65.015,
	-15838.664,
	96,
	-30101.389,
	65.015,
	-15555.826,
	97,
	-30105.033,
	65.015,
	-15523.003,
	98,
	-30148.83,
	65.015,
	-15246.482,
	99,
	-30153.656,
	65.015,
	-15202.826,
	100,
	-30172.309,
	65.015,
	-14936.076,
	101,
	-30172.875,
	65.015,
	-14887.062,
	102,
	-30168.33,
	65.015,
	-14626.723,
	103,
	-30165.059,
	65.015,
	-14582.998,
	104,
	-30134.217,
	65.015,
	-14289.547,
	105,
	-30130.721,
	65.015,
	-14265.206,
	106,
	-30081.121,
	65.015,
	-14010.027,
	107,
	-30072.492,
	65.015,
	-13965.637,
	108,
	-30069.156,
	65.015,
	-13948.475,
	109,
	-30055.83,
	65.015,
	-13879.907,
	110,
	-30052.65,
	65.015,
	-13859.146,
	111,
	-30047.434,
	65.015,
	-13809.496,
	112,
	-30046.453,
	65.015,
	-13797.246,
	113,
	-30045.512,
	65.015,
	-13743.359,
	114,
	-30045.982,
	65.015,
	-13727.151,
	115,
	-30049.48,
	65.015,
	-13677.12,
	116,
	-30051.033,
	65.015,
	-13662.416,
	117,
	-30056.486,
	65.015,
	-13627.979,
	118,
	-30058.139,
	65.015,
	-13617.866,
	119,
	-30066.158,
	65.015,
	-13576.611,
	120,
	-30068.139,
	65.015,
	-13566.824,
	121,
	-30076.932,
	65.015,
	-13528.732,
	122,
	-30079.939,
	65.015,
	-13516.27,
	123,
	-30089.139,
	65.015,
	-13481.934,
	124,
	-30091.746,
	65.015,
	-13472.213,
	125,
	-30110.174,
	65.015,
	-13398.302,
	126,
	-30112.162,
	65.015,
	-13390.33,
	127,
	-30130.492,
	65.015,
	-13337.104,
	128,
	-30136.402,
	65.015,
	-13320.985,
	129,
	-30157.176,
	65.015,
	-13274.321,
	130,
	-30162.891,
	65.015,
	-13262.769,
	131,
	-30188.969,
	65.015,
	-13215.721,
	132,
	-30196.551,
	65.015,
	-13202.26,
	133,
	-30214.678,
	65.015,
	-13175.383,
	134,
	-30225.709,
	65.015,
	-13160.639,
	135,
	-30249.926,
	65.015,
	-13127.306,
	136,
	-30255.801,
	65.015,
	-13119.246,
	137,
	-30275.641,
	65.015,
	-13093.849,
	138,
	-30287.348,
	65.015,
	-13079.1,
	139,
	-30339.123,
	65.015,
	-13017.393,
	140,
	-30345.779,
	65.015,
	-13008.752,
	141,
	-30368.15,
	65.015,
	-12980.119,
	142,
	-30376.396,
	65.015,
	-12969.564,
	143,
	-30398.812,
	65.015,
	-12938.709,
	144,
	-30406.367,
	65.015,
	-12928.085,
	145,
	-30424.941,
	65.015,
	-12900.546,
	146,
	-30432.629,
	65.015,
	-12887.978,
	147,
	-30451.49,
	65.015,
	-12853.951,
	148,
	-30459.889,
	65.015,
	-12836.086,
	149,
	-30475.746,
	65.015,
	-12800.469,
	150,
	-30480.514,
	65.015,
	-12787.601,
	151,
	-30496.719,
	65.015,
	-12738.318,
	152,
	-30517.688,
	65.015,
	-12654.221,
	153,
	-30520.023,
	65.015,
	-12644.849,
	154,
	-30530.268,
	65.015,
	-12606.616,
	155,
	-30531.539,
	65.015,
	-12601.875,
	156,
	-30533.137,
	65.015,
	-12596.498,
	157,
	-30542.639,
	65.015,
	-12555.338,
	158,
	-30544.57,
	65.015,
	-12546.473,
	159,
	-30551.818,
	65.015,
	-12507.221,
	160,
	-30553.352,
	65.015,
	-12499.161,
	161,
	-30559.424,
	65.015,
	-12460.82,
	162,
	-30560.809,
	65.015,
	-12450.99,
	163,
	-30563.895,
	65.015,
	-12406.847,
	164,
	-30564.373,
	65.015,
	-12398.862,
	165,
	-30563.42,
	65.015,
	-12350.877,
	166,
	-30562.412,
	65.015,
	-12339.217,
	167,
	-30558.74,
	65.015,
	-12304.277,
	168,
	-30558.152,
	65.015,
	-12294.417,
	169,
	-30318.627,
	65.015,
	-11062.152,
	170,
	-30313.908,
	65.015,
	-11044.97,
	171,
	-30288.711,
	65.015,
	-10957.101,
	172,
	-30283.795,
	65.015,
	-10943.073,
	173,
	-30249.596,
	65.015,
	-10853.979,
	174,
	-30242.25,
	65.015,
	-10837.555,
	175,
	-30205.398,
	65.015,
	-10762,
	176,
	-30192.299,
	65.015,
	-10737.355,
	177,
	-30148.668,
	65.015,
	-10664.742,
	178,
	-30139.461,
	65.015,
	-10650.287,
	179,
	-30088.865,
	65.015,
	-10580.647,
	180,
	-30071.408,
	65.015,
	-10559.127,
	181,
	-30015.35,
	65.015,
	-10494.638,
	182,
	-29996.898,
	65.015,
	-10475.183,
	183,
	-29942.336,
	65.015,
	-10422.493,
	184,
	-29919.016,
	65.015,
	-10401.848,
	185,
	-29848.791,
	65.015,
	-10344.981,
	186,
	-29829.693,
	65.015,
	-10332.016,
	187,
	-29760.811,
	65.015,
	-10285.554,
	188,
	-29740.541,
	65.015,
	-10272.737,
	189,
	-29665.373,
	65.015,
	-10231.07,
	190,
	-29644.473,
	65.015,
	-10221.713,
	191,
	-29570.002,
	65.015,
	-10188.556,
	192,
	-29549.225,
	65.015,
	-10180.002,
	193,
	-29467.711,
	65.015,
	-10151.935,
	194,
	-29439.398,
	65.015,
	-10143.235,
	195,
	-29356.008,
	65.015,
	-10122.443,
	196,
	-29331.984,
	65.015,
	-10118.724,
	197,
	-29253.607,
	65.015,
	-10106.31,
	198,
	-29227.748,
	65.015,
	-10103.133,
	199,
	-29142.129,
	65.015,
	-10097.146,
	200,
	-29120.438,
	65.015,
	-10097.233,
	201,
	-28439.756,
	65.015,
	-10109.114,
	202,
	-28414.295,
	65.015,
	-10110.31,
	203,
	-28309.877,
	65.015,
	-10121.284,
	204,
	-28282.602,
	65.015,
	-10125.79,
	205,
	-28184.074,
	65.015,
	-10144.942,
	206,
	-28158.133,
	65.015,
	-10151.201,
	207,
	-28060.145,
	65.015,
	-10179.299,
	208,
	-28029.588,
	65.015,
	-10189.427,
	209,
	-27933.088,
	65.015,
	-10226.469,
	210,
	-27912.369,
	65.015,
	-10233.274,
	211,
	-27798.725,
	65.015,
	-10265.862,
	212,
	-27780.98,
	65.015,
	-10270.008,
	213,
	-27659.34,
	65.015,
	-10293.652,
	214,
	-27641.562,
	65.015,
	-10296.413,
	215,
	-27522.584,
	65.015,
	-10308.919,
	216,
	-27503.762,
	65.015,
	-10310.32,
	217,
	-27384.145,
	65.015,
	-10312.485,
	218,
	-27362.459,
	65.015,
	-10312.293,
	219,
	-27243.613,
	65.015,
	-10303.982,
	220,
	-27223.314,
	65.015,
	-10302.013,
	221,
	-27097.4,
	65.015,
	-10282.069,
	222,
	-27082.613,
	65.015,
	-10279.126,
	223,
	-26962.297,
	65.015,
	-10249.127,
	224,
	-26942.816,
	65.015,
	-10243.318,
	225,
	-26832.123,
	65.015,
	-10205.204,
	226,
	-26815.973,
	65.015,
	-10198.78,
	227,
	-26704.125,
	65.015,
	-10148.982,
	228,
	-26686.438,
	65.015,
	-10140.415,
	229,
	-26226.385,
	65.015,
	-9885.402,
	230,
	-26076.762,
	65.015,
	-9818.037,
	231,
	-26060.91,
	65.015,
	-9811.52,
	232,
	-25928.514,
	65.015,
	-9765.932,
	233,
	-25907.879,
	65.015,
	-9759.608,
	234,
	-25768.793,
	65.015,
	-9724.931,
	235,
	-25752.064,
	65.015,
	-9721.574,
	236,
	-25612.133,
	65.015,
	-9699.412,
	237,
	-25593.197,
	65.015,
	-9697.34,
	238,
	-25451.531,
	65.015,
	-9687.434,
	239,
	-25434.777,
	65.015,
	-9686.923,
	240,
	-25291.701,
	65.015,
	-9689.42,
	241,
	-25271.346,
	65.015,
	-9690.373,
	242,
	-25129.912,
	65.015,
	-9705.238,
	243,
	-25114.09,
	65.015,
	-9707.408,
	244,
	-24974.113,
	65.015,
	-9734.617,
	245,
	-24955.719,
	65.015,
	-9738.585,
	246,
	-24798.508,
	65.015,
	-9783.665,
	247,
	-24781.305,
	65.015,
	-9787.736,
	248,
	-24625.072,
	65.015,
	-9818.104,
	249,
	-24610.557,
	65.015,
	-9819.922,
	250,
	-24454.52,
	65.015,
	-9836.321,
	251,
	-24445.869,
	65.015,
	-9837.113,
	252,
	-24283.984,
	65.015,
	-9839.938,
	253,
	-24266.016,
	65.015,
	-9839.61,
	254,
	-24106.793,
	65.015,
	-9828.477,
	255,
	-24097.734,
	65.015,
	-9827.735,
	256,
	-23929.439,
	65.015,
	-9801.08,
	257,
	-23917.922,
	65.015,
	-9798.942,
	258,
	-23760.631,
	65.015,
	-9759.726,
	259,
	-23747.428,
	65.015,
	-9755.772,
	260,
	-23601.879,
	65.015,
	-9705.656,
	261,
	-23582.418,
	65.015,
	-9698.492,
	262,
	-23440.412,
	65.015,
	-9635.267,
	263,
	-23426.844,
	65.015,
	-9629.018,
	264,
	-23282.422,
	65.015,
	-9548.964,
	265,
	-23270.578,
	65.015,
	-9541.987,
	266,
	-23134.207,
	65.015,
	-9450.006,
	267,
	-23123.088,
	65.015,
	-9442.378,
	268,
	-23000.029,
	65.015,
	-9342.728,
	269,
	-22987.053,
	65.015,
	-9330.366,
	270,
	-22876.723,
	65.015,
	-9223.822,
	271,
	-22863.906,
	65.015,
	-9211.282,
	272,
	-22758.871,
	65.015,
	-9090.455,
	273,
	-22745.891,
	65.015,
	-9075.521,
	274,
	-22654.803,
	65.015,
	-8949.777,
	275,
	-22642.742,
	65.015,
	-8929.951,
	276,
	-22353.52,
	65.015,
	-8448.603,
	277,
	-22337.826,
	65.015,
	-8424.583,
	278,
	-22282.955,
	65.015,
	-8349.061,
	279,
	-22270.877,
	65.015,
	-8333.948,
	280,
	-22201.551,
	65.015,
	-8254.199,
	281,
	-22190.793,
	65.015,
	-8242.822,
	282,
	-22117.787,
	65.015,
	-8172.322,
	283,
	-22108.793,
	65.015,
	-8163.983,
	284,
	-22021.225,
	65.015,
	-8093.072,
	285,
	-22011.693,
	65.015,
	-8085.354,
	286,
	-21921.467,
	65.015,
	-8024.496,
	287,
	-21907.199,
	65.015,
	-8015.587,
	288,
	-21817.449,
	65.015,
	-7965.837,
	289,
	-21804.932,
	65.015,
	-7959.525,
	290,
	-21707.104,
	65.015,
	-7915.969,
	291,
	-21692.697,
	65.015,
	-7908.683,
	292,
	-21603.902,
	65.015,
	-7859.462,
	293,
	-21591.846,
	65.015,
	-7852.019,
	294,
	-21093.496,
	65.015,
	-7515.878,
	295,
	-21083.699,
	65.015,
	-7508.86,
	296,
	-20983.084,
	65.015,
	-7427.384,
	297,
	-20971.15,
	65.015,
	-7417.338,
	298,
	-20881.807,
	65.015,
	-7331.061,
	299,
	-20872.158,
	65.015,
	-7321.304,
	300,
	-20790.98,
	65.015,
	-7227.921,
	301,
	-20779.871,
	65.015,
	-7214.526,
	302,
	-20706.555,
	65.015,
	-7113.614,
	303,
	-20697.029,
	65.015,
	-7099.662,
	304,
	-20626.521,
	65.015,
	-6982.316,
	305,
	-20619.652,
	65.015,
	-6969.58,
	306,
	-20559.402,
	65.015,
	-6846.052,
	307,
	-20552.418,
	65.015,
	-6831.27,
	308,
	-20506.775,
	65.015,
	-6711.361,
	309,
	-20500.357,
	65.015,
	-6691.267,
	310,
	-20461.662,
	65.015,
	-6556.324,
	311,
	-20456.922,
	65.015,
	-6538.483,
	312,
	-20432.41,
	65.015,
	-6412.378,
	313,
	-20428.605,
	65.015,
	-6388.049,
	314,
	-20415.109,
	65.015,
	-6259.645,
	315,
	-20413.6,
	65.015,
	-6238.122,
	316,
	-20286.965,
	65.015,
	1016.885,
	317,
	-20287.346,
	65.015,
	1030.184,
	318,
	-20321.781,
	65.015,
	1423.791,
	319,
	-20323.234,
	65.015,
	1436.13,
	320,
	-20355.512,
	65.015,
	1619.189,
	321,
	-20359.295,
	65.015,
	1633.992,
	322,
	-20403.225,
	65.015,
	1799.01,
	323,
	-20409.547,
	65.015,
	1819.441,
	324,
	-20468.6,
	65.015,
	1981.683,
	325,
	-20475.398,
	65.015,
	1998.454,
	326,
	-20525.684,
	65.015,
	2106.29,
	327,
	-20533.504,
	65.015,
	2121.409,
	328,
	-20638.213,
	65.015,
	2302.769,
	329,
	-20644.723,
	65.015,
	2315.304,
	330,
	-20737.516,
	65.015,
	2514.298,
	331,
	-20745.047,
	65.015,
	2531.681,
	332,
	-20818.848,
	65.015,
	2734.449,
	333,
	-20823.697,
	65.015,
	2748.493,
	334,
	-20880.758,
	65.015,
	2961.447,
	335,
	-20883.254,
	65.015,
	2973.093,
	336,
	-20920.68,
	65.015,
	3185.348,
	337,
	-20923.186,
	65.015,
	3201.152,
	338,
	-20942.275,
	65.015,
	3419.334,
	339,
	-20942.824,
	65.015,
	3429.144,
	340,
	-20942.824,
	65.015,
	3648.625,
	341,
	-20942.441,
	65.015,
	3661.873,
	342,
	-20923.246,
	65.015,
	3881.268,
	343,
	-20922.035,
	65.015,
	3891.908,
	344,
	-20883.443,
	65.015,
	4110.776,
	345,
	-20880.85,
	65.015,
	4123.238,
	346,
	-20824.473,
	65.015,
	4333.646,
	347,
	-20820.393,
	65.015,
	4346.645,
	348,
	-20746.625,
	65.015,
	4550.572,
	349,
	-20740.617,
	65.015,
	4565.437,
	350,
	-20648.387,
	65.015,
	4763.224,
	351,
	-20640.705,
	65.015,
	4778.382,
	352,
	-20533.934,
	65.015,
	4963.314,
	353,
	-20524.486,
	65.015,
	4977.78,
	354,
	-20405.785,
	65.015,
	5147.302,
	355,
	-20394.176,
	65.015,
	5163.312,
	356,
	-20255.559,
	65.015,
	5328.51,
	357,
	-20242.637,
	65.015,
	5343.054,
	358,
	-20092.242,
	65.015,
	5493.448,
	359,
	-20080.656,
	65.015,
	5505.922,
	360,
	-19909.992,
	65.015,
	5649.127,
	361,
	-19900.104,
	65.015,
	5656.884,
	362,
	-19526.467,
	65.015,
	5918.508,
	363,
	-19511.316,
	65.015,
	5927.986,
	364,
	-18894.861,
	65.015,
	6283.896,
	365,
	-18880.602,
	65.015,
	6291.449,
	366,
	-18237.451,
	65.015,
	6591.354,
	367,
	-18221.529,
	65.015,
	6597.951,
	368,
	-17323.484,
	65.015,
	6924.812,
	369,
	-17305.465,
	65.015,
	6930.584,
	370,
	-16382.876,
	65.015,
	7177.792,
	371,
	-16362.068,
	65.015,
	7182.432,
	372,
	-15427.29,
	65.015,
	7347.259,
	373,
	-15408.189,
	65.015,
	7350.113,
	374,
	-13385.418,
	65.015,
	7527.083,
	375,
	-13367.506,
	65.015,
	7527.819,
	376,
	-12618.101,
	65.015,
	7527.819,
	377,
	-12604.641,
	65.015,
	7527.356,
	378,
	-7800.965,
	65.015,
	7107.089,
	379,
	-7786.005,
	65.015,
	7105.364,
	380,
	-7373.733,
	65.015,
	7032.67,
	381,
	-7359.525,
	65.015,
	7029.589,
	382,
	-6966.391,
	65.015,
	6924.249,
	383,
	-6943.172,
	65.015,
	6917.097,
	384,
	-6555.526,
	65.015,
	6776.006,
	385,
	-6534.693,
	65.015,
	6767.923,
	386,
	-6166.273,
	65.015,
	6596.126,
	387,
	-6146.886,
	65.015,
	6586.701,
	388,
	-5789.696,
	65.015,
	6380.477,
	389,
	-5772.423,
	65.015,
	6370.025,
	390,
	-5438.182,
	65.015,
	6135.987,
	391,
	-5428.106,
	65.015,
	6128.932,
	392,
	-5107.099,
	65.015,
	5859.575,
	393,
	-5092.273,
	65.015,
	5846.099,
	394,
	-4801.628,
	65.015,
	5555.454,
	395,
	-4783.742,
	65.015,
	5536.777,
	396,
	-4523.732,
	65.015,
	5226.911,
	397,
	-4508.358,
	65.015,
	5206.367,
	398,
	-4276.728,
	65.015,
	4875.564,
	399,
	-4262.262,
	65.015,
	4853.651,
	400,
	-4056.844,
	65.015,
	4497.856,
	401,
	-4047.861,
	65.015,
	4481.341,
	402,
	-3874.501,
	65.015,
	4109.57,
	403,
	-3868.097,
	65.015,
	4094.747,
	404,
	-3726.717,
	65.015,
	3706.308,
	405,
	-3721.616,
	65.015,
	3691.307,
	406,
	-3613.42,
	65.015,
	3287.511,
	407,
	-3608.176,
	65.015,
	3263.81,
	408,
	-3537.714,
	65.015,
	2864.202,
	409,
	-3534.208,
	65.015,
	2843.626,
	410,
	-3498.824,
	65.015,
	2439.186,
	411,
	-3497.79,
	65.015,
	2412.26,
	412,
	-3498,
	65,
	1450,
	413,
	-3539,
	65,
	1186,
	414,
	-3540,
	140,
	424,
	415,
	-3540,
	140,
	-219,
	416,
	-3540,
	126,
	-621,
	417,
	-3541,
	66,
	-1525,
	418,
	-3498,
	65,
	-1881,
}

local tbl2 = {}

for i = 1, #tbl1, 4 do
	tbl2[tbl1[i]] = new(tbl1[i + 1], tbl1[i + 2], tbl1[i + 3])
end

local v11
local num2 = -1

local function func14(arg1)
	local v1 = arg1 and arg1:GetChildren() or {}
	local v2 = #v1

	if v11 and v2 == num2 then
		return v11
	end

	num2 = v2
	local tbl = {}
	local num = 0

	for _, v3 in ipairs(v1) do
		local num1 = tonumber(v3.Name)
		if num1 and num1 ~= 1 and num1 ~= 412 then
			local Position

			if v3:IsA("BasePart") then
				Position = v3.Position
			elseif v3:IsA("Attachment") then
				Position = v3.WorldPosition
			elseif v3:IsA("Model") then
				Position = v3:GetPivot().Position
			else
				Position = v3.Position
			end

			tbl[num1] = Position

			if num1 > num then
				num = num1
			end
		end
	end

	for k, v4 in pairs(tbl2) do
		if not tbl[k] and k ~= 1 and k ~= 412 then
			tbl[k] = v4
			if k > num then
				num = k
			end
		end
	end

	local tbl1 = {}

	for k1, v5 in pairs(tbl) do
		tbl1[#tbl1 + 1] = {n = k1, p = v5}
	end

	sort(tbl1, function(arg1, arg2)
		return arg1.n < arg2.n
	end)

	v11 = tbl1
	return tbl1
end

local function func15(arg1)
	if arg1:IsA("BasePart") then
		arg1.CanCollide = false
		arg1.CanTouch = false
	end
end

mainFeaturesGroupbox:AddToggle("TrafficNoclip", {
	Text = "Traffic Noclip",
	Default = false,
	Callback = function(value)
		flag1 = value

		if v6 then
			v6:Disconnect()
			v6 = nil
		end

		local TrafficFolder = Workspace:FindFirstChild("TrafficFolder")

		if value then
			if TrafficFolder then
				for _, descendant in ipairs(TrafficFolder:GetDescendants()) do
					func15(descendant)
				end
				v6 = TrafficFolder.DescendantAdded:Connect(func15)
			end
		elseif TrafficFolder then
			for _, descendant1 in ipairs(TrafficFolder:GetDescendants()) do
				if descendant1:IsA("BasePart") then
					descendant1.CanCollide = true
					descendant1.CanTouch = true
				end
			end
		end
	end,
})

mainFeaturesGroupbox:AddToggle("AntiAFK", {
	Text = "Anti Afk",
	Default = false,
	Callback = function(value)
		func6(value)
	end,
})

autoFarmGroupbox:AddToggle("AutoFarm", {
	Text = "Enable Auto Farm",
	Default = false,
	Callback = function(value)
		flag2 = value

		if value then
			v7 = tick()
			num = func7()

			spawn(function()
				local num = 0
				local v1 = tick()
				local flag = false

				while flag2 do
					local TrafficLanes = Workspace:FindFirstChild("TrafficLanes")
					local v2 = TrafficLanes and TrafficLanes:FindFirstChild("Lane2")

					if not v2 or #v2:GetChildren() == 0 then
						local v3 = func11()

						if v3 then
							v3:PivotTo(new1(-3499, 65, -3036))
						end

						wait(2)
					else
						local v4 = func14(v2)
						local v6 = #v4

						if v6 < 1 then
							wait(1)
						else
							local v7 = func11()
							if not v7 then
								wait(1)
							else
								local v8 = func12(v7)
								if not v8 then
									wait(1)
								else
									local Position = v8.Position
									local num1 = 1
									local hugeRef = huge

									for i = 1, v6 do
										local v9 = v4[i]
										local v10 = v9.p.X - Position.X
										local v11 = v9.p.Z - Position.Z
										local v12 = v10 * v10 + v11 * v11

										if v12 < hugeRef then
											hugeRef = v12
											num1 = i
										end
									end

									if not flag then
										local v13 = v4[num1]
										func13(v7, new1(v13.p.X, v13.p.Y + 4, v13.p.Z))
										num = 0
										flag = true
										wait(0.2)
									end

									local v14 = num1 % v6 + 1
									local n = v4[v14].n
									local v15 = tick()
									local raycastParams = RaycastParams.new()
									raycastParams.FilterDescendantsInstances = {v7}
									raycastParams.FilterType = Enum.RaycastFilterType.Exclude
									local v16 = tick()
									local num2 = 0.016666666666666666
									local v17 = (Options.FarmSpeed and Options.FarmSpeed.Value or 150) * 2
									local num3 = 0
									local num4 = 0
									local num5 = 0
									local v18 = func11()
									local v19 = v18 and func12(v18)

									while flag2 do
										if v18 ~= v5 or not v18 or not v18.Parent then
											v18 = func11()
											local v20 = v18 and func12(v18)
											v19 = v20

											if not v18 or not v20 then
												wait(1)
												break
											end

											raycastParams.FilterDescendantsInstances = {v18}
										end

										if v19 then
											local v21 = tick()

											if flag4 then
												local v22 = (Options.PauseInterval and Options.PauseInterval.Value or 15) * 60
												if v21 - v1 >= v22 then
													local v23 = Options.PauseDuration and Options.PauseDuration.Value or 5

													if v19 then
														v19.AssemblyLinearVelocity = zero
														v19.AssemblyAngularVelocity = zero
													end

													num = 0
													wait(v23)
													local v24 = tick()
													v1 = v24
													v21 = v24

													if not flag2 then
														break
													end
												end
											end

											if v21 - v16 >= 10 then
												local TrafficLanes1 = Workspace:FindFirstChild("TrafficLanes")
												local v25 = TrafficLanes1 and TrafficLanes1:FindFirstChild("Lane2")

												if v25 then
													local v26 = func14(v25)
													if #v26 >= 1 then
														v4 = v26
														v6 = #v26
													end
												end

												v16 = v21
												raycastParams.FilterDescendantsInstances = {v18}
											end

											local v27 = v4[v14]

											if not v27 then
												v14 = 1
												v27 = v4[1]
											end

											local n1 = v27.n

											if n1 ~= n then
												n = n1
												v15 = v21
											elseif v21 - v15 >= 120 then
												func13(v18, new1(v27.p.X, v27.p.Y + 4, v27.p.Z))
												num = 0
												v15 = v21
											end

											num3 = num3 + 1

											if num3 >= 60 then
												num3 = 0
												v17 = (Options.FarmSpeed and Options.FarmSpeed.Value or 150) * 2
											end

											if flag3 then
												if num < v17 - 10 then
													num = min(num + v17 / 5 * num2, v17)
												else
													local v28 = sin(v21 * 1.5)
													num = clamp(v17 + (v28 - 1) * 10, v17 - 10, v17)
												end
											else
												num = v17
											end

											local Position1 = v19.Position
											local CFrame1 = v19.CFrame
											num4 = num4 + 1

											if num4 >= 6 then
												num4 = 0
												local v29 = Workspace:Raycast(Position1, vector3, raycastParams)

												if v29 then
													local v30 = Position1.Y - v29.Position.Y
													num5 = v30 >= 2.5 and -min((v30 - 2.5) * 5, 60) or 0
												else
													num5 = -80
												end
											end

											local p = v27.p
											local v31 = p.X - Position1.X
											local v32 = p.Z - Position1.Z
											local v33 = v31 * v31 + v32 * v32
											local v34 = max(15, num * num2 * 1.5)

											if v33 < v34 * v34 then
												v14 = v14 % v6 + 1
											else
												local v35 = sqrt(v33)
												local v36 = v31 / v35
												local v37 = v32 / v35
												local v38 = v36 * num
												local v39 = v37 * num
												v19.AssemblyLinearVelocity = new(v38, num5, v39)
												local v40 = atan2(-v36, -v37)

												if CFrame1.UpVector.Y < 0.85 then
													v19.CFrame = new1(Position1) * fromEulerAnglesYXZ(0, v40, 0)
													v19.AssemblyAngularVelocity = zero
													v19.AssemblyLinearVelocity = new(v38, 0, v39)
												else
													local LookVector = CFrame1.LookVector
													local v41 = v40 - atan2(-LookVector.X, -LookVector.Z)

													if v41 > 3.141592653589793 then
														v41 = v41 - 6.283185307179586
													end

													if v41 < -3.141592653589793 then
														v41 = v41 + 6.283185307179586
													end

													if abs(v41) < 0.03 then
														v19.AssemblyAngularVelocity = zero
													else
														v19.AssemblyAngularVelocity = new(0, clamp(v41 * 4, -7, 7), 0)
													end
												end
											end

											local _, v42 = RunService.Stepped:Wait()

											if v42 and v42 > 0 and v42 < 0.5 then
												num2 = v42
											end

											continue
										end

										break
									end

									wait(0.1)
								end
							end
						end
					end
				end
			end)

			return
		end

		v7 = nil
	end,
})

autoFarmGroupbox:AddSlider(
	"FarmSpeed",
	{Text = "Auto Farm Speed", Default = 240, Min = 65, Max = 350, Rounding = 0, HideMax = true}
)

autoFarmGroupbox:AddToggle("SpeedHumanize", {
	Text = "Speed Humanization",
	Default = true,
	Callback = function(value)
		flag3 = value
	end,
})

autoFarmGroupbox:AddToggle("FarmPauses", {
	Text = "Auto Pauses",
	Default = false,
	Callback = function(value)
		flag4 = value
	end,
})

autoFarmGroupbox:AddSlider("PauseInterval", {
	Text = "Pause Every",
	Default = 15,
	Min = 1,
	Max = 60,
	Rounding = 0,
	Suffix = " min",
	HideMax = true,
})

autoFarmGroupbox:AddSlider(
	"PauseDuration",
	{Text = "Pause Length", Default = 5, Min = 1, Max = 30, Rounding = 0, Suffix = " s", HideMax = true}
)

local tbl3

local function func16()
	local v1 = func11()

	if not v1 then
		return nil
	end

	for _, descendant in ipairs(v1:GetDescendants()) do
		if descendant:IsA("ModuleScript") and descendant.Name == "A-Chassis Tune" then
			local ok, result = pcall(require, descendant)
			if ok and type(result) == "table" then
				return result
			end
		end
	end

	return nil
end

local function func17()
	local v1 = func16()

	if not v1 then
		return
	end

	if not tbl3 then
		tbl3 = {
			Horsepower = v1.Horsepower,
			BrakeForce = v1.BrakeForce,
			Redline = v1.Redline,
			IdleThrottle = v1.IdleThrottle,
			TCSThreshold = v1.TCSThreshold or 20,
			TCSGradient = v1.TCSGradient or 20,
			TCSLimit = v1.TCSLimit or 10,
			ABSThreshold = v1.ABSThreshold or 20,
			Ratios = {},
		}
		if v1.Ratios then
			for i, ratio in ipairs(v1.Ratios) do
				tbl3.Ratios[i] = ratio
			end
		end
	end

	local v2 = tbl3.Horsepower * (Options.ModAccel and Options.ModAccel.Value or 1)
	v1.Horsepower = v2
	local v3 = tbl3.Horsepower / max(v2, 1)
	v1.IdleThrottle = tbl3.IdleThrottle * min(1, v3)
	v1.BrakeForce = tbl3.BrakeForce * (Options.ModBrake and Options.ModBrake.Value or 1)
	local v4 = (Options.ModTopSpeed and Options.ModTopSpeed.Value or 180) / 180

	if v1.Ratios and #tbl3.Ratios > 2 then
		for i1, ratio1 in ipairs(tbl3.Ratios) do
			v1.Ratios[i1] = ratio1
		end

		local v5 = #v1.Ratios

		for i2 = 0, min(3, v5 - 2) - 1 do
			local v6 = v5 - i2
			if v6 > 2 then
				v1.Ratios[v6] = tbl3.Ratios[v6] / v4
			end
		end
	end

	v1.Redline = tbl3.Redline * max(1, v4 * 0.8)
	local v7 = max(0.1, Options.ModFriction and Options.ModFriction.Value or 1)
	v1.TCSThreshold = max(1, 20 / v7)
	v1.TCSGradient = max(1, 20 / v7)
	v1.TCSLimit = max(1, 10 / v7)
	v1.ABSThreshold = max(1, 20 / v7)
end

carModifierGroupbox:AddButton("Apply Mods", function()
	func17()
end)

carModifierGroupbox:AddSlider("ModTopSpeed", {
	Text = "Top Speed",
	Default = 180,
	Min = 100,
	Max = 300,
	Rounding = 0,
	HideMax = true,
	Callback = function() end,
})

carModifierGroupbox:AddSlider("ModAccel", {
	Text = "Acceleration",
	Default = 1,
	Min = 1,
	Max = 50,
	Rounding = 0,
	HideMax = true,
	Callback = function() end,
})

carModifierGroupbox:AddSlider("ModBrake", {
	Text = "Brake Power",
	Default = 1,
	Min = 1,
	Max = 50,
	Rounding = 0,
	HideMax = true,
	Callback = function() end,
})

carModifierGroupbox:AddSlider("ModFriction", {
	Text = "Tire Grip",
	Default = 2,
	Min = 1,
	Max = 10,
	Rounding = 1,
	HideMax = true,
	Callback = function() end,
})

local str = ""
local flag6 = false
local v12

local function func18()
	if v12 then
		return v12
	end

	v12 = syn and syn.request or http and http.request or http_request or request or fluxus and fluxus.request or getgenv and getgenv().request or getgenv and getgenv().http_request
	return v12
end

local num3 = 0

local function func19()
	if not str or str == "" then
		return
	end

	if tick() - num3 < 2 then
		return
	end

	num3 = tick()

	pcall(function()
		local v1 = func18()

		if not v1 then
			return
		end

		local v2 = Options.WebhookFields and Options.WebhookFields.Value or {}

		local function func(arg1)
			if v2[arg1] == true or v2[arg1] == 1 then
				return true
			end

			for k, v1 in pairs(v2) do
				if v1 == arg1 or k == arg1 then
					return true
				end
			end

			return false
		end

		local v3 = func7()
		local v4 = v7 and func8(tick() - v7) or "Not Farming"
		local v5 = v7 and func9(max(0, v3 - num)) or "0"
		local tbl = {}

		if func("Current Money") then
			tbl[#tbl + 1] = {name = "Current Money", value = func9(v3), inline = true}
		end

		if func("Money Made") then
			tbl[#tbl + 1] = {name = "Money Made", value = v5, inline = true}
		end

		if func("Duration") then
			tbl[#tbl + 1] = {name = "Duration", value = v4, inline = false}
		end

		local v6 = HttpService:JSONEncode({embeds = {{title = "Merqury Hub - Ghost Driver", color = 5793266, fields = tbl}}})

		v1({
			Url = str,
			url = str,
			Method = "POST",
			method = "POST",
			Headers = {["Content-Type"] = "application/json"},
			headers = {["Content-Type"] = "application/json"},
			Body = v6,
			body = v6,
		})
	end)
end

webhookGroupbox:AddToggle("WebhookEnabled", {
	Text = "Enable Webhook",
	Default = false,
	Callback = function(value)
		flag6 = value
		if value and str ~= "" then
			spawn(func19)
		end
	end,
})

webhookGroupbox:AddInput("WebhookURL", {
	Default = "",
	Placeholder = "https://discord.com/api/webhooks/",
	Callback = function(value)
		if type(value) == "string" then
			str = value:match("^%s*(.-)%s*$") or value
		end
	end,
})

webhookGroupbox:AddDropdown("WebhookFields", {
	Text = "What to Send",
	Values = {"Current Money", "Money Made", "Duration"},
	Default = {"Current Money", "Money Made", "Duration"},
	Multi = true,
	Callback = function() end,
})

webhookGroupbox:AddSlider("WebhookInterval", {
	Text = "Send Every",
	Default = 5,
	Min = 1,
	Max = 60,
	Rounding = 0,
	Suffix = " min",
	HideMax = true,
	Callback = function() end,
})

spawn(function()
	local num = 0
	while true do
		if flag6 and str ~= "" then
			wait(1)
			local v1 = max(1, Options.WebhookInterval and tonumber(Options.WebhookInterval.Value) or 5) * 60
			num = num + 1

			if num >= v1 then
				num = 0
				func19()
			end
		else
			num = 0
			wait(10)
		end
	end
end)

local flag7 = false
local v13

funGroupbox:AddToggle("SpamDoors", {
	Text = "Spam Open All Doors",
	Default = false,
	Callback = function(value)
		flag7 = value
		if value then
			v13 = v13 or spawn(function()
				local tbl = {}
				local num = 0

				while flag7 do
					if tick() - num >= 10 then
						num = tick()
						tbl = {}

						for _, child in ipairs(Workspace:GetChildren()) do
							if child:IsA("Model") then
								local Misc = child:FindFirstChild("Misc")
								if Misc then
									for _, child1 in ipairs(Misc:GetChildren()) do
										local Handle = child1:FindFirstChild("Handle")
										if Handle then
											local ClickRemote = Handle:FindFirstChild("ClickRemote")
											if ClickRemote and ClickRemote:IsA("RemoteEvent") then
												tbl[#tbl + 1] = ClickRemote
											end
										end
									end
								end
							end
						end
					end

					for i = 1, #tbl do
						local v1 = tbl[i]
						if v1.Parent then
							pcall(v1.FireServer, v1)
						end
					end

					wait(2)
				end
			end)
		else
			v13 = nil
		end
	end,
})

local flag8 = false
local v14

funGroupbox:AddToggle("BackfireSpammer", {
	Text = "Flame Spammer",
	Default = false,
	Callback = function(value)
		flag8 = value
		if value then
			v14 = v14 or spawn(function()
				local ReplicatedStorage = game:GetService("ReplicatedStorage")
				local replicatedStorage = ReplicatedStorage
				local v1 = ReplicatedStorage.FindFirstChild(replicatedStorage, "AC6Shared")
				local str

				if v1 then
					str = "Remotes"
					replicatedStorage = v1:FindFirstChild("Remotes")
					v1 = replicatedStorage
				end

				if v1 then
					str = "BackfireBurst"
					replicatedStorage = v1:FindFirstChild("BackfireBurst")
					v1 = replicatedStorage
				end

				while true do
					replicatedStorage = flag8

					if not replicatedStorage then
						break
					end

					replicatedStorage = func11
					replicatedStorage = replicatedStorage()

					if replicatedStorage then
						str = Options
						local BackfireMode = str.BackfireMode

						if BackfireMode then
							str = Options.BackfireMode
							BackfireMode = str.Value
						end

						BackfireMode = BackfireMode or "BackfireBurst"
						str = "BackfireBurst"

						if BackfireMode == "BackfireBurst" then
							if v1 then
								str = pcall
								str(function()
									v1:FireServer(replicatedStorage)
								end)
							end
						else
							local replicatedStorageRef = replicatedStorage
							str = replicatedStorage.FindFirstChild
							str = str(replicatedStorageRef, "ExhaustHandler")

							if str then
								pcall(function()
									str:FireServer("FlamesSmall", true)
								end)
							end
						end
					end

					str = Options
					local BackfireCooldown = str.BackfireCooldown

					if BackfireCooldown then
						str = Options.BackfireCooldown
						BackfireCooldown = str.Value
					end

					BackfireCooldown = BackfireCooldown or 1
					str = wait
					local v2 = table.pack(max(0.1, BackfireCooldown))
					str(table.unpack(v2, 1, v2.n))
				end
			end)
		else
			v14 = nil
		end
	end,
})

funGroupbox:AddSlider("BackfireCooldown", {
	Text = "Cooldown",
	Default = 1,
	Min = 0.1,
	Max = 1,
	Rounding = 1,
	Suffix = " s",
	HideMax = true,
	Callback = function() end,
})

funGroupbox:AddDropdown("BackfireMode", {
	Text = "Fire Mode",
	Values = {"BackfireBurst", "Small Flames"},
	Default = "BackfireBurst",
	Multi = false,
	Callback = function() end,
})

funGroupbox:AddToggle("Disable3D", {
	Text = "Disable 3D Rendering",
	Default = false,
	Callback = function(value)
		if value then
			pcall(function()
				RunService:Set3dRenderingEnabled(false)
			end)
		else
			pcall(function()
				RunService:Set3dRenderingEnabled(true)
			end)
		end
	end,
})

local menuGroupbox = Tabs.Settings:AddLeftGroupbox("Menu")
menuGroupbox:AddLabel("Menu Keybind"):AddKeyPicker("MenuKeybind", {Default = "RightControl", NoUI = true, Text = "Menu keybind"})

menuGroupbox:AddButton("Unload Script", function()
	flag2 = false
	flag1 = false
	flag7 = false
	flag8 = false
	func6(false)

	if v6 then
		v6:Disconnect()
		v6 = nil
	end

	local TrafficFolder = Workspace:FindFirstChild("TrafficFolder")

	if TrafficFolder then
		for _, descendant in ipairs(TrafficFolder:GetDescendants()) do
			if descendant:IsA("BasePart") then
				descendant.CanCollide = true
				descendant.CanTouch = true
			end
		end
	end

	Library:Unload()
end)

Library.ToggleKeybind = Options.MenuKeybind
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({"MenuKeybind"})
SaveManager:SetFolder("MerquryHub/ghost driver")
SaveManager:BuildConfigSection(Tabs.Settings)
