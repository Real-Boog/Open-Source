-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf

if getgenv().QDL_AIM and getgenv().QDL_AIM.unload then
	pcall(getgenv().QDL_AIM.unload)
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
game:GetService("TweenService")
local localPlayer = Players.LocalPlayer
local currentCamera = workspace.CurrentCamera

local tbl = {
	silent = false,
	aimbot = false,
	tracer = true,
	fovCircle = true,
	esp = false,
	espBox = true,
	espName = true,
	espHealth = true,
	visCheck = true,
	npcs = false,
	fov = 200,
	smooth = 0.12,
	part = "Head",
	aimKey = Enum.UserInputType.MouseButton2,
	infAmmo = false,
	instReload = false,
	instEquip = false,
	animSpeed = 12,
	rage = false,
	autoFire = false,
	rapidFire = false,
	fireDelay = 0.06,
	autoReload = false,
	blockReport = true,
	noSpread = false,
	noRecoil = false,
	wallbang = false,
	thirdPerson = false,
	tpDist = 12,
	spinbot = false,
	spinSpeed = 10,
	unlockJump = false,
	lagPelletNuke = false,
	lagPelletCount = 32,
	lagGlassNuke = false,
	lagIntensity = 5,
}

local function fn()
	return tbl.silent or tbl.rage
end

local tbl2 = {
	alive = true,
	target = nil,
	targetModel = nil,
	aimPos = nil,
	holding = false,
	gunPoint = nil,
	lastScan = 0,
}

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.RespectCanCollide = true

local function fn2()
	return localPlayer.Character
end

local function fn3(arg)
	local tbl3 = {}
	local v = table.pack(workspace:FindFirstChild("Exclude"))
	tbl3[1] = currentCamera

	do
		local values = table.pack(table.unpack(v, 1, v.n))
		table.move(values, 1, values.n, 2, tbl3)
	end

	local v2 = fn2()

	if v2 then
		table.insert(tbl3, v2)
	end

	if arg then
		table.insert(tbl3, arg)
	end

	return tbl3
end

local function fn4(arg)
	if tbl.part == "Head" then
		return arg:FindFirstChild("Head")
	end
	local upperTorso = arg:FindFirstChild("UpperTorso") or arg:FindFirstChild("Torso") or arg:FindFirstChild("HumanoidRootPart")
	if tbl.part == "Torso" then
		return upperTorso
	end
	local head = arg:FindFirstChild("Head")
	if not head then
		return upperTorso
	end

	if not upperTorso then
		return head
	end
	local mouseLocation = UserInputService:GetMouseLocation()
	local v = currentCamera:WorldToScreenPoint(head.Position)
	local v2 = currentCamera:WorldToScreenPoint(upperTorso.Position)
	return (Vector2.new(v.X, v.Y) - mouseLocation).Magnitude <= (Vector2.new(v2.X, v2.Y) - mouseLocation).Magnitude and head or upperTorso
end

local function fn5()
	local tbl3 = {}
	local characters = workspace:FindFirstChild("Characters")
	if not characters then
		return tbl3
	end
	local v = fn2()

	for _, child in ipairs(characters:GetChildren()) do
		if child:IsA("Model") and child ~= v then
			if tbl.npcs or Players:GetPlayerFromCharacter(child) then
				table.insert(tbl3, child)
			end
		elseif tbl.npcs and child:IsA("Folder") then
			for _, child2 in ipairs(child:GetChildren()) do
				if child2:IsA("Model") then
					table.insert(tbl3, child2)
				end
			end
		end
	end

	return tbl3
end

local function fn6(arg, arg2)
	if not tbl.visCheck then
		return true
	end
	local position = currentCamera.CFrame.Position
	raycastParams.FilterDescendantsInstances = fn3(arg2)
	return workspace:Raycast(position, arg.Position - position, raycastParams) == nil
end

local function fn7(arg, arg2)
	local n = math.clamp((arg - arg2).Magnitude * 0.0018, 0.09, 0.34)
	local vector = Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5)

	if vector.Magnitude < 0.001 then
		vector = Vector3.new(0.3, 0.2, 0.1)
	end

	return arg + vector.Unit * n
end

local function fn8()
	local mouseLocation = UserInputService:GetMouseLocation()
	local humanoidRootPart = fn2() and fn2():FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return
	end
	local huge = math.huge
	local v = nil
	local v2 = nil

	for _, v3 in ipairs(fn5()) do
		local humanoid = v3:FindFirstChildOfClass("Humanoid")
		humanoid = humanoid and humanoid.Health > 0 and fn4(v3)

		if humanoid then
			local magnitude = (humanoid.Position - humanoidRootPart.Position).Magnitude

			if not tbl.rage then
				local v4, magnitude2 = currentCamera:WorldToScreenPoint(humanoid.Position)
				magnitude2 = magnitude2 and (Vector2.new(v4.X, v4.Y) - mouseLocation).Magnitude or nil
				magnitude = magnitude2 and magnitude2 <= tbl.fov and magnitude2 + magnitude / 10 or nil
			end

			if magnitude and magnitude < huge and fn6(humanoid, v3) then
				huge = magnitude
				v = v3
				v2 = humanoid
			end
		end
	end

	return v, v2
end

local v = nil

v = hookmetamethod(game, "__index", newcclosure(function(arg, arg2)
	if arg2 == "WorldCFrame" and tbl2.alive and fn() and tbl2.aimPos and not checkcaller() then
		if typeof(arg) == "Instance" and arg.Name == "GunPoint" and arg:IsA("Attachment") then
			local v2 = fn2()
			if v2 and arg:IsDescendantOf(v2) then
				local aimPos = tbl2.aimPos
				return CFrame.lookAt(v(arg, "WorldPosition"), aimPos)
			end
		end
	end

	return v(arg, arg2)
end))

local function fn9()
	local gunPoint = tbl2.gunPoint
	local v2 = fn2()
	if not v2 then
		return nil
	end

	if gunPoint and gunPoint.Parent and gunPoint:IsDescendantOf(v2) then
		return gunPoint
	end
	local lastScan = tbl2.lastScan
	if os.clock() - lastScan < 0.25 then
		return nil
	end
	tbl2.lastScan = os.clock()

	for _, descendant in ipairs(v2:GetDescendants()) do
		if descendant.Name == "GunPoint" and descendant:IsA("Attachment") then
			tbl2.gunPoint = descendant
			return descendant
		end
	end

	tbl2.gunPoint = nil
	return nil
end

local gunModule = game:GetService("ReplicatedStorage").Modules:WaitForChild("GunModule")
local Reload = require(gunModule:WaitForChild("Reload"))
local Animations = require(gunModule:WaitForChild("Animations"))
local tbl3 = {}
local obj = setmetatable({}, { __mode = "k" })

local function fn10(arg)
	if table.isfrozen and table.isfrozen(arg) and setreadonly then
		setreadonly(arg, false)
	end
end

fn10(Reload)
fn10(Animations)
local start = Reload.start

Reload.start = function(arg, ...)
	if type(arg) == "table" then
		if arg.model then
			tbl3[arg.model] = arg
		end

		if arg.animations then
			obj[arg.animations] = true
		end
	end

	return start(arg, ...)
end

local load = Animations.load

Animations.load = function(...)
	local v2 = load(...)

	if type(v2) == "table" then
		obj[v2] = true
	end

	return v2
end

local Packets = require(game:GetService("ReplicatedStorage").Modules:WaitForChild("Packets"))
fn10(Packets.Gun.cheatReport)
local send = Packets.Gun.cheatReport.send

Packets.Gun.cheatReport.send = function(...)
	if tbl.blockReport then
		return
	end
	return send(...)
end

local ShotMath = require(gunModule:WaitForChild("ShotMath"))
local Functions = require(gunModule:WaitForChild("Functions"))
local Recoil = require(gunModule:WaitForChild("Recoil"))
local v2 = nil

v2 = hookfunction(ShotMath.directions, function(arg, arg2, arg3, arg4)
	if tbl.noSpread and typeof(arg) == "Vector3" and arg.Magnitude > 0 and type(arg3) == "number" then
		local v3 = table.create(arg3)
		local unit = arg.Unit

		for i = 1, arg3 do
			v3[i] = unit
		end

		return v3
	end

	return v2(arg, arg2, arg3, arg4)
end)

local v3 = nil

v3 = hookfunction(Functions.PierceCheck, function(arg, arg2, arg3)
	if tbl.wallbang and type(arg) == "table" then
		arg.UserData = arg.UserData or {}
		arg.UserData.MaxPierceDistance = 1000000
	end

	return v3(arg, arg2, arg3)
end)

fn10(Recoil)
local consume = Recoil.consume

Recoil.consume = function(...)
	local v4, v5, v6, v7 = consume(...)
	if tbl.noRecoil then
		return 0, v5, v6, v7
	end
	return v4, v5, v6, v7
end

local function fn11()
	local v4 = fn2()
	if not v4 then
		return nil
	end

	for k, v5 in pairs(tbl3) do
		if not k.Parent then
			tbl3[k] = nil
			continue
		end

		if k:IsDescendantOf(v4) then
			return v5
		end
	end

	return nil
end

local function fn12(arg)
	local ok, result, result2 = pcall(arg.getAmmo)
	if not ok or type(result) ~= "number" or result > 0 then
		return
	end
	local maxAmmo = arg.maxAmmo
	arg.setAmmo(maxAmmo, result2)
	local v4, v5 = arg.sessionAuth.sign()
	arg.reloadPacket.send({ sendTime = workspace:GetServerTimeNow(), ammo = maxAmmo, ammoStock = result2, seq = v4, token = v5 })
end

local function fn13()
	if not (tbl.instReload or tbl.instEquip) then
		return
	end

	for k in pairs(obj) do
		for k2, v4 in pairs(k) do
			if type(k2) == "string" and typeof(v4) == "Instance" and v4:IsA("AnimationTrack") and v4.IsPlaying then
				if (tbl.instReload and string.find(k2, "reload", 1, true) or tbl.instEquip and string.find(k2, "equip", 1, true)) and math.abs(v4.Speed - tbl.animSpeed) > 0.01 then
					pcall(function()
						v4:AdjustSpeed(tbl.animSpeed)
					end)
				end
			end
		end
	end
end

local obj2 = setmetatable({}, { __mode = "k" })

local function fn14()
	for k, v4 in pairs(obj2) do
		pcall(function()
			k.pellets = v4
		end)

		obj2[k] = nil
	end
end

local function fn15(arg)
	arg = arg and arg.toolConfig
	if not arg then
		return
	end

	if obj2[arg] == nil then
		obj2[arg] = arg.pellets
	end

	fn10(arg)
	arg.pellets = math.clamp(tbl.lagPelletCount, 1, 32)
end

local color = Color3.fromRGB(235, 72, 62)
local color2 = Color3.fromRGB(70, 226, 132)
local color3 = Color3.fromRGB(178, 126, 255)
local color4 = Color3.fromRGB(232, 165, 62)
local line = Drawing.new("Line")
line.Thickness = 1.8
line.Transparency = 1
line.Visible = false
local circle = Drawing.new("Circle")
circle.Radius = 3
circle.Filled = true
circle.NumSides = 16
circle.Transparency = 1
circle.Visible = false
local circle2 = Drawing.new("Circle")
circle2.Thickness = 1.4
circle2.NumSides = 64
circle2.Filled = false
circle2.Transparency = 0.85
circle2.Color = color4
circle2.Visible = false
local tbl4 = {}

local function fn16()
	for _, v4 in ipairs({ line, circle, circle2 }) do
		pcall(function()
			v4.Visible = false
			v4:Remove()
		end)
	end

	for _, v4 in ipairs(tbl4) do
		for _, v5 in pairs(v4) do
			pcall(function()
				v5.Visible = false
				v5:Remove()
			end)
		end
	end

	table.clear(tbl4)
end

local function fn17(arg)
	arg = arg and arg:FindFirstAncestorOfClass("Model")

	while arg do
		if arg:FindFirstChildOfClass("Humanoid") and arg ~= fn2() then
			return true
		end
		arg = arg:FindFirstAncestorOfClass("Model")
	end

	return false
end

local function fn18()
	if not tbl.tracer then
		local v4 = circle
		line.Visible = false
		v4.Visible = false
		return
	end

	local v4 = fn9()

	if not v4 then
		local v5 = circle
		line.Visible = false
		v5.Visible = false
		return
	end

	local worldPosition = v4.WorldPosition
	local aimPos, hit

	if fn() and tbl2.aimPos then
		aimPos = tbl2.aimPos
		hit = color3
	else
		local lookVector = v4.WorldCFrame.LookVector
		raycastParams.FilterDescendantsInstances = fn3()
		hit = workspace:Raycast(worldPosition, lookVector * 2000, raycastParams)
		aimPos = hit and hit.Position or worldPosition + lookVector * 2000
		hit = hit and fn17(hit.Instance) and color2 or color
	end

	local v5, v6 = currentCamera:WorldToViewportPoint(worldPosition)
	local v7, v8 = currentCamera:WorldToViewportPoint(aimPos)

	if not (v6 and v8) then
		local v9 = circle
		line.Visible = false
		v9.Visible = false
		return
	end

	line.From = Vector2.new(v5.X, v5.Y)
	line.To = Vector2.new(v7.X, v7.Y)
	line.Color = hit
	line.Visible = true
	circle.Position = Vector2.new(v7.X, v7.Y)
	circle.Color = hit
	circle.Visible = true
end

local function fn19(arg)
	local v4 = tbl4[arg]
	if v4 then
		return v4
	end

	local tbl5 = {
		box = Drawing.new("Square"),
		name = Drawing.new("Text"),
		hpBg = Drawing.new("Line"),
		hp = Drawing.new("Line"),
	}

	local box = tbl5.box
	local box2 = tbl5.box
	tbl5.box.Thickness = 1.4
	box.Filled = false
	box2.Transparency = 1
	local name = tbl5.name
	local name2 = tbl5.name
	tbl5.name.Size = 13
	name.Center = true
	name2.Outline = true
	tbl5.name.Color = Color3.new(1, 1, 1)
	local hpBg = tbl5.hpBg
	local hpBg2 = tbl5.hpBg
	local color5 = Color3.fromRGB(15, 15, 18)
	hpBg.Thickness = 3
	hpBg2.Color = color5
	tbl5.hp.Thickness = 1.6
	tbl4[arg] = tbl5
	return tbl5
end

local function fn20(arg)
	for i = arg, #tbl4 do
		local v4 = tbl4[i]
		local box = v4.box
		local name = v4.name
		local hpBg = v4.hpBg
		local hp = v4.hp
		box.Visible = false
		name.Visible = false
		hpBg.Visible = false
		hp.Visible = false
	end
end

local function fn21()
	if not tbl.esp then
		return fn20(1)
	end
	local humanoidRootPart = fn2() and fn2():FindFirstChild("HumanoidRootPart")
	local n = 0

	for _, v4 in ipairs(fn5()) do
		local humanoid = v4:FindFirstChildOfClass("Humanoid")
		local head = v4:FindFirstChild("Head")
		local humanoidRootPart2 = v4:FindFirstChild("HumanoidRootPart") or v4:FindFirstChild("Torso")

		if humanoid and humanoid.Health > 0 and head and humanoidRootPart2 then
			local v5, v6 = currentCamera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.7, 0))
			local v7, v8 = currentCamera:WorldToViewportPoint(humanoidRootPart2.Position - Vector3.new(0, 3.2, 0))

			if v6 and v8 then
				n += 1
				local v9 = fn19(n)
				local n2 = math.max(v7.Y - v5.Y, 6)
				local n3 = n2 * 0.45
				local n4 = v5.X - n3 / 2
				local y = v5.Y
				local color5 = v4 == tbl2.targetModel and color3 or color4
				v9.box.Size = Vector2.new(n3, n2)
				v9.box.Position = Vector2.new(n4, y)
				v9.box.Color = color5
				v9.box.Visible = tbl.espBox

				if tbl.espName then
					v9.name.Text = ("%s  [%dm]"):format(v4.Name, humanoidRootPart and math.floor((humanoidRootPart2.Position - humanoidRootPart.Position).Magnitude) or 0)
					v9.name.Position = Vector2.new(v5.X, y - 15)
					v9.name.Color = color5
				end

				v9.name.Visible = tbl.espName

				if tbl.espHealth then
					local n5 = math.clamp(humanoid.Health / math.max(humanoid.MaxHealth, 1), 0, 1)
					local n6 = n4 - 5
					v9.hpBg.From = Vector2.new(n6, y)
					v9.hpBg.To = Vector2.new(n6, y + n2)
					v9.hp.From = Vector2.new(n6, y + n2)
					v9.hp.To = Vector2.new(n6, y + n2 - n2 * n5)
					v9.hp.Color = color:Lerp(color2, n5)
				end

				local hp = v9.hp
				local espHealth = tbl.espHealth
				v9.hpBg.Visible = tbl.espHealth
				hp.Visible = espHealth
			end
		end
	end

	fn20(n + 1)
end

local v4 = nil
local fn22 = nil
local SharedFunctions = require(game:GetService("ReplicatedStorage").Modules:WaitForChild("SharedFunctions"))
local cameraMode = localPlayer.CameraMode
local cameraMinZoomDistance = localPlayer.CameraMinZoomDistance
local n = 0
local tbl5 = {}

local function fn23(arg, arg2)
	if os.clock() - (tbl5[arg] or 0) < arg2 then
		return
	end
	tbl5[arg] = os.clock()
	SharedFunctions:SetVirtualInput(arg, true)

	task.delay(0.04, function()
		pcall(function()
			SharedFunctions:SetVirtualInput(arg, false)
		end)
	end)
end

local function fn24()
	localPlayer.CameraMode = cameraMode
	localPlayer.CameraMinZoomDistance = cameraMinZoomDistance
end

local function fn25()
	local humanoid = fn2()
	humanoid = humanoid and humanoid:FindFirstChildOfClass("Humanoid")

	if humanoid then
		humanoid.AutoRotate = true
	end
end

local function fn26()
	local humanoid = fn2()
	humanoid = humanoid and humanoid:FindFirstChildOfClass("Humanoid")

	if humanoid then
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
	end
end

local connection = RunService.Heartbeat:Connect(function(deltaTime)
	if not tbl2.alive then
		return
	end
	local v5 = fn2()
	local humanoid = v5 and v5:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end

	if tbl.spinbot then
		local humanoidRootPart = v5:FindFirstChild("HumanoidRootPart")

		if humanoidRootPart then
			humanoid.AutoRotate = false
			n = (n + deltaTime * tbl.spinSpeed) % 6.2831853071795862
			humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position) * CFrame.Angles(0, n, 0)
		end
	end

	if tbl.unlockJump and not humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping) then
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
	end
end)

local connection2 = RunService.RenderStepped:Connect(function(deltaTime)
	if not tbl2.alive then
		return
	end

	if fn() or tbl.aimbot and tbl2.holding or tbl.autoFire then
		local v5, v6 = fn8()
		local v7 = tbl2
		tbl2.targetModel = v5
		v7.target = v6

		if v6 then
			local gunPoint = tbl2.gunPoint
			tbl2.aimPos = fn7(v6.Position, gunPoint and gunPoint.Parent and gunPoint.WorldPosition or currentCamera.CFrame.Position)
		else
			tbl2.aimPos = nil
		end
	else
		local v5 = tbl2
		local v6 = tbl2
		tbl2.target = nil
		v5.targetModel = nil
		v6.aimPos = nil
	end

	if tbl.aimbot and tbl2.holding and tbl2.target then
		currentCamera.CFrame = currentCamera.CFrame:Lerp(CFrame.lookAt(currentCamera.CFrame.Position, tbl2.target.Position), tbl.smooth <= 0.001 and 1 or math.clamp(1 - math.exp(-deltaTime / tbl.smooth), 0, 1))
	end

	if tbl.thirdPerson then
		if localPlayer.CameraMode ~= Enum.CameraMode.Classic then
			localPlayer.CameraMode = Enum.CameraMode.Classic
		end

		if localPlayer.CameraMinZoomDistance ~= tbl.tpDist then
			localPlayer.CameraMinZoomDistance = tbl.tpDist
		end
	end

	if tbl.autoFire and tbl2.target then
		fn23("LMB", tbl.fireDelay)
	end

	circle2.Visible = tbl.fovCircle and (fn() or tbl.aimbot)

	if circle2.Visible then
		local mouseLocation = UserInputService:GetMouseLocation()
		local guiInset = game:GetService("GuiService"):GetGuiInset()
		circle2.Position = Vector2.new(mouseLocation.X + guiInset.X, mouseLocation.Y + guiInset.Y)
		circle2.Radius = tbl.fov
		circle2.Color = tbl2.target and color2 or color4
	end

	fn18()
	fn21()
	fn13()
	local v5 = fn11()
	tbl2.ctx = v5

	if v5 and tbl.infAmmo then
		fn12(v5)
	end

	if tbl.lagPelletNuke then
		fn15(v5)
	else
		fn14()
	end

	if tbl.rapidFire and v5 then
		pcall(v5.finish)
	end

	if tbl.autoReload and not tbl.infAmmo then
		if v5 then
			local ok, result = pcall(v5.getAmmo)

			if ok and type(result) == "number" and result <= 0 then
				fn23("R", 0.5)
			end
		else
			fn23("R", 1.5)
		end
	end

	if v4 then
		local str = ""

		if tbl.infAmmo then
			if v5 then
				local result
				str, result = pcall(v5.getAmmo)

				if str then
					str = ("   ·   AMMO %d/∞"):format(result or 0)
				end

				str = str or ""
			else
				str = "   ·   AMMO: press R once"
			end
		end

		if tbl2.targetModel then
			local humanoidRootPart = fn2() and fn2():FindFirstChild("HumanoidRootPart")
			local target = humanoidRootPart and tbl2.target
			local n2 = 0

			if target then
				n2 = (tbl2.target.Position - humanoidRootPart.Position).Magnitude
			end

			v4.Text = ("LOCKED  %s  ·  %dm%s"):format(tbl2.targetModel.Name, math.floor(n2), str)
			v4.TextColor3 = color2
		else
			v4.Text = "NO TARGET" .. str
			v4.TextColor3 = Color3.fromRGB(120, 122, 134)
		end
	end
end)

local function fn27(arg)
	for i = 1, 12 do
		if typeof(arg:GetAttribute("Breakable")) == "string" then
			return true
		end
		arg = arg.Parent
		if not arg then
			return false
		end
	end

	return false
end

local n2 = 0
local tbl6 = {}

local tbl7 = {
	main = RunService.Heartbeat:Connect(function()
		if not tbl2.alive then
			return
		end

		if tbl.lagGlassNuke then
			if os.clock() - n2 > 1 then
				n2 = os.clock()
				tbl6 = {}

				for _, descendant in ipairs(workspace:GetDescendants()) do
					if descendant:IsA("BasePart") and descendant.Transparency < 1 and fn27(descendant) then
						tbl6[#tbl6 + 1] = descendant
					end
				end
			end

			for i = 1, math.min(#tbl6, tbl.lagIntensity * 2) do
				local v5 = tbl6[math.random(1, #tbl6)]

				if v5 and v5.Parent and v5.Transparency < 1 then
					pcall(Packets.Gun.glassHit.send, { part = v5, position = v5.Position, direction = Vector3.new(0, -1, 0) })
				end
			end
		end
	end),
}

local v5, v6, v7 = loadstring(game:HttpGet("https://raw.githubusercontent.com/gilgameshfate59/ohbfoosk8tid/main/CitraUI.lua"))().Shim:Init({
	Name = "QuickDraw",
	SubName = "QuickDraw | Citra Hub",
	Accent = Color3.fromRGB(255, 138, 32),
	ShowTabIcons = false,
})

local v8 = v5:CreateWindow({
	Title = "Citra Hub | QuickDraw",
	Center = true,
	AutoShow = true,
	TabPaddingX = 8,
	MenuFadeTime = 0.2,
})

v5.ToggleKeybind = Enum.KeyCode.RightShift

local function fn28(arg)
	return setmetatable({ _lbl = arg }, { __newindex = function(arg2, arg3, arg4)
		if arg3 == "Text" and arg2._lbl and arg2._lbl.SetText then
			pcall(function()
				arg2._lbl:SetText(tostring(arg4))
			end)
		end
	end })
end

local tbl8 = {
	AIM = "Aim",
	AMMO = "Aim",
	VISUALS = "Visuals",
	RAGE = "Rage",
	MISC = "Misc",
	BADGE = "Farm",
	OP = "OP",
}

local tbl9 = {}
local tbl10 = {}
local v9 = nil

local function fn29(arg)
	local str = tbl8[arg] or "Misc"
	local v10 = tbl9[str]

	if not v10 then
		v10 = v8:AddTab(str)
		tbl9[str] = v10
		tbl10[str] = false
	end

	tbl10[str] = not tbl10[str]
	v9 = tbl10[str] and v10:AddLeftGroupbox(arg) or v10:AddRightGroupbox(arg)
end

local function fn30(arg, arg2, arg3)
	v9:AddToggle(arg2, { Text = arg, Default = tbl[arg2] })

	v6[arg2]:OnChanged(function(arg4)
		tbl[arg2] = arg4

		if arg3 then
			arg3(arg4)
		end
	end)
end

local function fn31(arg, arg2, arg3, arg4, arg5)
	v9:AddSlider(arg2, { Text = arg, Default = tbl[arg2], Min = arg3, Max = arg4, Rounding = arg5 or 0 })

	v7[arg2]:OnChanged(function(arg6)
		tbl[arg2] = arg6
	end)
end

local function fn32(arg, arg2, arg3)
	v9:AddDropdown(arg2, { Values = arg3, Default = table.find(arg3, tbl[arg2]) or 1, Multi = false, Text = arg })

	v7[arg2]:OnChanged(function(arg4)
		tbl[arg2] = arg4
	end)
end

local function fn33(arg)
	v9:AddLabel(arg .. ": hold Right Mouse")
end

local function fn34(arg, arg2, arg3, arg4, arg5, arg6)
	v9:AddToggle(arg2, { Text = arg, Default = tbl[arg2], Tooltip = arg3 .. " — " .. arg5 })

	v6[arg2]:OnChanged(function(arg7)
		tbl[arg2] = arg7

		if arg6 then
			arg6(arg7)
		end
	end)
end

fn29("AIM")
fn30("Silent Aim", "silent")
fn30("Aimbot", "aimbot")
fn33("Aimbot Key", "aimKey")
fn31("Smoothing", "smooth", 0, 0.6, 2)
fn32("Target Part", "part", { "Head", "Torso", "Nearest" })
fn31("FOV (px)", "fov", 30, 700)
fn30("Wall Check", "visCheck")
fn30("Target NPCs", "npcs")
fn29("RAGE")
v9:AddLabel("RISKY — ac may detect these", true)
fn30("Ragebot [RISKY]", "rage")

fn30("Auto Fire [RISKY]", "autoFire", function(arg)
	if not arg then
		pcall(function()
			SharedFunctions:SetVirtualInput("LMB", false)
		end)
	end
end)

fn30("Rapid Fire [RISKY]", "rapidFire")
fn31("Fire Delay", "fireDelay", 0.02, 0.4, 2)
fn30("Auto Reload", "autoReload")
fn30("No Spread [RISKY]", "noSpread")
fn30("No Recoil [RISKY]", "noRecoil")
fn30("Wallbang [RISKY]", "wallbang")
fn30("Block Cheat Report", "blockReport")
fn29("MISC")

fn30("Third Person", "thirdPerson", function(arg)
	if not arg then
		fn24()
	end
end)

fn31("3P Distance", "tpDist", 5, 30)

fn30("Spinbot", "spinbot", function(arg)
	if not arg then
		fn25()
	end
end)

fn31("Spin Speed", "spinSpeed", 1, 30)

fn30("Unlock Jump", "unlockJump", function(arg)
	if not arg then
		fn26()
	end
end)

local function fn35()
	local tbl11 = {}

	for _, descendant in ipairs(workspace:GetDescendants()) do
		if descendant:IsA("BasePart") then
			local parent = descendant

			for i = 1, 12 do
				local attribute = parent:GetAttribute("Breakable")

				if typeof(attribute) == "string" then
					if attribute == "GlassBottle" and not descendant:GetAttribute("BottleLaunched") and not descendant:GetAttribute("BottleBroken") then
						tbl11[#tbl11 + 1] = descendant
					end

					break
				else
					parent = parent.Parent
					if parent then
						continue
					end
				end

				break
			end
		end
	end

	return tbl11
end

local flag = false
local v10 = nil

local function fn36()
	if flag then
		return
	end

	if not v10 then
		return
	end
	flag = true
	v10.Text = "FARMING..."

	task.spawn(function()
		local ok, result = pcall(function()
			if localPlayer:GetAttribute("BottleBadgeAwarded") then
				return "ALREADY UNLOCKED"
			end
			local v11 = fn35()
			if #v11 < 5 then
				return "NOT ENOUGH BOTTLES (" .. #v11 .. ")"
			end
			local humanoidRootPart = fn2()
			humanoidRootPart = humanoidRootPart and humanoidRootPart:FindFirstChild("HumanoidRootPart")
			if not humanoidRootPart then
				return "NO CHARACTER — WAIT FOR SPAWN"
			end

			for i = 1, 5 do
				local v12 = v11[i]
				if (v12.Position - humanoidRootPart.Position).Magnitude < 40 then
					return "A BOTTLE IS TOO CLOSE — STAND BACK"
				end
				Packets.Gun.glassHit.send({ part = v12, position = v12.Position, direction = (v12.Position - humanoidRootPart.Position).Unit })
			end

			for i = 1, 30 do
				task.wait(0.4)
				if localPlayer:GetAttribute("BottleBadgeAwarded") then
					return "BADGE UNLOCKED — DOUBLE BARREL AVAILABLE"
				end
			end

			return "TIMEOUT — RETRY"
		end)

		v10.Text = ok and result or "ERROR: " .. tostring(result)

		task.delay(8, function()
			if v10 then
				v10.Text = "breaks 5 bottles ≥40 studs · run before Glass Nuke"
			end
		end)

		flag = false
	end)
end

fn29("BADGE")
v9:AddButton({ Text = "Farm Bottle Badge", Func = fn36 })
v10 = fn28(v9:AddLabel("breaks 5 bottles ≥40 studs · run before Glass Nuke", true))
fn29("AMMO")
fn30("Infinite Ammo", "infAmmo")
fn30("Instant Reload", "instReload")
fn30("Instant Equip", "instEquip")
fn31("Anim Speed", "animSpeed", 2, 25)
fn29("VISUALS")

fn30("Tracer Line", "tracer", function(arg)
	if not arg then
		local v11 = circle
		line.Visible = false
		v11.Visible = false
	end
end)

fn30("FOV Circle", "fovCircle", function(arg)
	if not arg then
		circle2.Visible = false
	end
end)

fn30("ESP", "esp", function(arg)
	if not arg then
		fn20(1)
	end
end)

fn30("ESP Box", "espBox")
fn30("ESP Name", "espName")
fn30("ESP Health", "espHealth")
fn29("OP")
v9:AddLabel("RISKY — ac may detect these", true)
local color5 = Color3.fromRGB(235, 72, 62)
local color6 = Color3.fromRGB(220, 210, 80)
fn34("Pellet Nuke [RISKY]", "lagPelletNuke", "EXTREME", color5, "up to 32 pellets per barrel")
fn31("Pellet Count", "lagPelletCount", 8, 32)
v9:AddLabel("HOW TO USE PELLET NUKE", true)
v9:AddLabel("1. hold a shotgun — Double Barrel hits hardest", true)
v9:AddLabel("2. drag Pellet Count up (32 = max)", true)
v9:AddLabel("3. turn Pellet Nuke ON, then shoot", true)
v9:AddLabel("nothing changed? press R once, then fire again", true)
v9:AddLabel("shotguns only — rifles fire one shot either way", true)
fn34("Glass Nuke [RISKY]", "lagGlassNuke", "MEDIUM", color6, "shatters breakable glass · FX to lobby")
fn31("Intensity", "lagIntensity", 1, 10)
local Status = tbl9.Aim:AddRightGroupbox("Status")
v4 = fn28(Status:AddLabel("NO TARGET", true))
Status:AddLabel("green on target · red no target · purple silent redirect", true)

Status:AddButton({
	Text = "Unload",
	DoubleClick = true,
	Func = function()
		fn22()
	end,
})

pcall(function()
	v8:Init()
end)

local function fn37(arg, arg2)
	if typeof(arg2) == "EnumItem" and arg2.EnumType == Enum.UserInputType then
		return arg.UserInputType == arg2
	end
	return arg.UserInputType == Enum.UserInputType.Keyboard and arg.KeyCode == arg2
end

local tbl11 = {}

table.insert(tbl11, UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end

	if fn37(input, tbl.aimKey) then
		tbl2.holding = true
	end
end))

table.insert(tbl11, UserInputService.InputEnded:Connect(function(input)
	if fn37(input, tbl.aimKey) then
		tbl2.holding = false
	end
end))

fn22 = function()
	if not tbl2.alive then
		return
	end
	tbl2.alive = false
	local v11 = tbl
	local v12 = tbl
	local v13 = tbl
	tbl.silent = false
	v11.aimbot = false
	v12.tracer = false
	v13.fovCircle = false
	local v14 = tbl
	local v15 = tbl
	tbl.infAmmo = false
	v14.instReload = false
	v15.instEquip = false
	local v16 = tbl
	local v17 = tbl
	local v18 = tbl
	tbl.rage = false
	v16.autoFire = false
	v17.thirdPerson = false
	v18.spinbot = false
	tbl.unlockJump = false
	local v19 = tbl
	tbl.rapidFire = false
	v19.autoReload = false
	local v20 = tbl
	local v21 = tbl
	tbl.noSpread = false
	v20.noRecoil = false
	v21.wallbang = false
	local v22 = tbl
	local v23 = tbl
	tbl.lagPelletNuke = false
	v22.lagGlassNuke = false
	v23.esp = false
	Recoil.consume = consume
	Reload.start = start
	Animations.load = load
	Packets.Gun.cheatReport.send = send
	fn14()
	connection:Disconnect()
	fn24()
	fn25()
	fn26()

	pcall(function()
		SharedFunctions:SetVirtualInput("LMB", false)
	end)

	connection2:Disconnect()

	for _, v24 in pairs(tbl7) do
		pcall(function()
			v24:Disconnect()
		end)
	end

	table.clear(tbl7)

	for _, v24 in ipairs(tbl11) do
		pcall(function()
			v24:Disconnect()
		end)
	end

	fn16()

	pcall(function()
		v5:Unload()
	end)

	getgenv().QDL_AIM = nil
end

v5:OnUnload(fn22)
getgenv().QDL_AIM = { unload = fn22, cfg = tbl, state = tbl2, tracks = obj, ctxs = tbl3 }
