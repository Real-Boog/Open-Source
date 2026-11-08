-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")
local localPlayer = Players.LocalPlayer
local currentCamera = Workspace.CurrentCamera
local mouse = localPlayer:GetMouse()
local tbl = {}
local tbl2 = {}

local tbl3 = {
	Ambient = Lighting.Ambient,
	OutdoorAmbient = Lighting.OutdoorAmbient,
	ColorShift_Bottom = Lighting.ColorShift_Bottom,
	ColorShift_Top = Lighting.ColorShift_Top,
	ClockTime = Lighting.ClockTime,
}

local function fn(arg)
	table.insert(tbl, arg)
	return arg
end

local v, v2, v3 = loadstring(game:HttpGet("https://raw.githubusercontent.com/gilgameshfate59/ohbfoosk8tid/main/CitraUI.lua"))().Shim:Init({
	Name = "Citra",
	SubName = "Redliner",
	Logo = "95077438762744",
	Accent = Color3.fromRGB(255, 138, 32),
})

Toggles = v2
Options = v3

local v4 = v:CreateWindow({
	Title = "REDLINER | Citra Hub",
	Center = true,
	AutoShow = true,
	TabPaddingX = 8,
	MenuFadeTime = 0.2,
})

v.ToggleKeybind = Enum.KeyCode.RightShift
local Combat = v4:AddTab("Combat")
local Ranged = Combat:AddRightGroupbox("Ranged")
local Movement = Combat:AddLeftGroupbox("Movement")
local Evasion = Combat:AddLeftGroupbox("Evasion")
Ranged:AddToggle("Triggerbot", { Text = "Auto Fire", Default = false })
Ranged:AddToggle("AutoBrake", { Text = "Auto Brake", Default = false })
Movement:AddToggle("AutoSlideHop", { Text = "Auto Hop", Default = false })

Movement:AddDropdown("AutoHopKey", {
	Values = { "Space", "LeftShift", "Q", "E", "C", "X", "Z" },
	Default = 1,
	Multi = false,
	Text = "Hop Key",
})

Movement:AddLabel(" ")
Evasion:AddToggle("AutoEvasion", { Text = "Auto Evade", Default = false, Tooltip = "Dashes when glint detected" })

Evasion:AddDropdown("AutoEvadeKey", {
	Values = { "LeftShift", "Q", "E", "C", "X", "Z" },
	Default = 1,
	Multi = false,
	Text = "Evade Key",
})

Evasion:AddLabel(" ")

local function fn2(arg)
	local v5 = nil

	if not pcall(function()
		v5 = Enum.KeyCode[arg]
	end) or not v5 then
		pcall(function()
			v5 = Enum.KeyCode[arg:upper()]
		end)
	end

	if not v5 then
		return
	end

	pcall(function()
		VirtualInputManager:SendKeyEvent(true, v5, false, game)
		task.wait(0.03)
		VirtualInputManager:SendKeyEvent(false, v5, false, game)
	end)
end

local n = 0

local function fn3(descendant)
	local name = descendant.Name
	if not (Toggles.AutoEvasion and Toggles.AutoEvasion.Value) then
		return
	end
	local v5 = string.lower(name)
	if not (string.find(v5, "flash") ~= nil or string.find(v5, "glint") ~= nil or string.find(v5, "indicator") ~= nil or string.find(v5, "warning") ~= nil or string.find(v5, "threat") ~= nil) then
		return
	end
	local character = localPlayer.Character
	local entities = Workspace:FindFirstChild("Entities")

	if entities then
		entities = entities:FindFirstChild(localPlayer.Name) or entities:FindFirstChild(localPlayer.DisplayName)
	end

	while descendant and descendant ~= game do
		if character and descendant == character or entities and descendant == entities then
			return
		end
		descendant = descendant.Parent
	end

	if tick() - n > 0.3 then
		n = tick()
		v:Notify("Auto-Evasion: Dashing away!", 1)

		task.spawn(function()
			fn2(Options.AutoEvadeKey and Options.AutoEvadeKey.Value or "LeftShift")
		end)
	end
end

fn(localPlayer:WaitForChild("PlayerGui").DescendantAdded:Connect(fn3))
fn(Workspace.DescendantAdded:Connect(fn3))
local Aimbot = v4:AddTab("Aimbot")
local Aimbot2 = Aimbot:AddLeftGroupbox("Aimbot")
local fov = Aimbot:AddRightGroupbox("FOV")
local v5 = Aimbot:AddLeftGroupbox("Hitbox Expander")
local Target = Aimbot:AddRightGroupbox("Target")
Aimbot2:AddToggle("LockOnToggle", { Text = "Lock On", Default = false }):AddKeyPicker("LockOnKey", { Default = "None", SyncToggleState = true, Mode = "Toggle", Text = "Lock On" })
Aimbot2:AddDropdown("LockOnMode", { Values = { "Normal", "Closest Player" }, Default = 1, Multi = false, Text = "Lock On Mode" })
Aimbot2:AddSlider("AimSmoothness", { Text = "Smoothness", Default = 0, Min = 0, Max = 5, Rounding = 1 })

Aimbot2:AddDropdown("AimPartTarget", {
	Values = { "Head", "HumanoidRootPart", "Torso", "UpperTorso" },
	Default = 1,
	Multi = false,
	Text = "Target Part",
})

Aimbot2:AddToggle("WallCheck", { Text = "Wall Check", Default = false, Tooltip = "Skip targets that are behind walls" })
fov:AddToggle("ShowFOVCircle", { Text = "Show FOV", Default = false })
fov:AddSlider("FOVRadius", { Text = "Radius", Default = 100, Min = 10, Max = 800, Rounding = 0 })
local circle = nil

pcall(function()
	circle = Drawing.new("Circle")
	circle.Thickness = 1.5
	circle.Color = Color3.fromRGB(255, 255, 255)
	circle.Filled = false
	circle.Transparency = 1
	circle.Visible = false
	return circle
end)

local function fn4(arg, arg2, arg3)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = { localPlayer.Character, arg2 }
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	return Workspace:Raycast(arg, arg3.Position - arg, raycastParams) == nil
end

local function fn5()
	local n2 = Options.FOVRadius and Options.FOVRadius.Value or 100
	local str = Options.AimPartTarget and Options.AimPartTarget.Value or "Head"
	local value = Toggles.WallCheck and Toggles.WallCheck.Value
	local character = localPlayer.Character

	if character then
		character = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head")
	end

	local mouseLocation = UserInputService:GetMouseLocation()
	local huge = math.huge
	local v6 = nil

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= localPlayer and player.Character then
			local character2 = player.Character
			local head = character2:FindFirstChild(str) or character2:FindFirstChild("Head") or character2:FindFirstChild("HumanoidRootPart")
			local humanoid = character2:FindFirstChildOfClass("Humanoid")

			if head and humanoid and humanoid.Health > 0 then
				local v7, v8 = currentCamera:WorldToViewportPoint(head.Position)

				if v8 then
					local magnitude = (Vector2.new(v7.X, v7.Y) - mouseLocation).Magnitude

					if magnitude < huge and magnitude <= n2 then
						if not value or character and fn4(character.Position, character2, head) then
							huge = magnitude
							v6 = player
						end
					end
				end
			end
		end
	end

	return v6
end

local function fn6()
	local value = Toggles.WallCheck and Toggles.WallCheck.Value
	local str = Options.AimPartTarget and Options.AimPartTarget.Value or "Head"
	local character = localPlayer.Character

	if character then
		character = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head")
	end

	if not character then
		local entities = Workspace:FindFirstChild("Entities")
		character = entities and (entities:FindFirstChild(localPlayer.Name) or entities:FindFirstChild(localPlayer.DisplayName))

		if character then
			character = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head")
		end
	end

	if not character then
		return nil
	end
	local huge = math.huge
	local v6 = nil

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= localPlayer then
			local character2 = player.Character

			if not character2 then
				local entities = Workspace:FindFirstChild("Entities")

				if entities then
					character2 = entities:FindFirstChild(player.Name) or entities:FindFirstChild(player.DisplayName)
				end
			end

			if character2 then
				local humanoidRootPart = character2:FindFirstChild(str) or character2:FindFirstChild("HumanoidRootPart") or character2:FindFirstChild("Head")
				local humanoid = character2:FindFirstChildOfClass("Humanoid")

				if humanoidRootPart and humanoid and humanoid.Health > 0 then
					local magnitude = (character.Position - humanoidRootPart.Position).Magnitude

					if magnitude < huge then
						if not value or fn4(character.Position, character2, humanoidRootPart) then
							huge = magnitude
							v6 = player
						end
					end
				end
			end
		end
	end

	return v6
end

local v6 = nil

fn(RunService.RenderStepped:Connect(function()
	if circle then
		circle.Visible = Toggles.ShowFOVCircle and Toggles.ShowFOVCircle.Value or false
		circle.Radius = Options.FOVRadius and Options.FOVRadius.Value or 100
		circle.Position = UserInputService:GetMouseLocation()
	end

	if Toggles.LockOnToggle and Toggles.LockOnToggle.Value then
		local str = Options.LockOnMode and Options.LockOnMode.Value or "Normal"

		if not v6 or not v6.Character or not v6.Character:FindFirstChildOfClass("Humanoid") or v6.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then
			if str == "Closest Player" then
				v6 = fn6()
			else
				v6 = fn5()
			end
		end

		if v6 and v6.Character then
			local head = v6.Character:FindFirstChild(Options.AimPartTarget and Options.AimPartTarget.Value or "Head") or v6.Character:FindFirstChild("Head") or v6.Character:FindFirstChild("HumanoidRootPart")

			if head then
				local n2 = Options.AimSmoothness and Options.AimSmoothness.Value or 0
				local cframe = CFrame.lookAt(currentCamera.CFrame.Position, head.Position)

				if n2 > 0 then
					currentCamera.CFrame = currentCamera.CFrame:Lerp(cframe, 1 / (n2 * 4 + 1))
				else
					currentCamera.CFrame = cframe
				end
			end
		end
	else
		v6 = nil
	end
end))

v5:AddToggle("ExtendHitboxes", { Text = "Hitbox Expander", Default = false })
v5:AddSlider("HitboxSize", { Text = "Size", Default = 2, Min = 2, Max = 50, Rounding = 1 })
local tbl4 = {}

fn(RunService.Heartbeat:Connect(function()
	if Toggles.ExtendHitboxes and Toggles.ExtendHitboxes.Value then
		local n2 = Options.HitboxSize and Options.HitboxSize.Value or 2

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer and player.Character then
				local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")

				if humanoidRootPart then
					if not tbl4[humanoidRootPart] then
						tbl4[humanoidRootPart] = {
							Size = humanoidRootPart.Size,
							CanCollide = humanoidRootPart.CanCollide,
							Transparency = humanoidRootPart.Transparency,
						}
					end

					humanoidRootPart.Size = Vector3.new(n2, n2, n2)
					humanoidRootPart.CanCollide = false
					humanoidRootPart.Transparency = 0.7
				end
			end
		end
	elseif next(tbl4) then
		for k, v7 in pairs(tbl4) do
			pcall(function()
				if k and k.Parent then
					k.Size = v7.Size
					k.CanCollide = v7.CanCollide
					k.Transparency = v7.Transparency
				end
			end)
		end

		table.clear(tbl4)
	end
end))

local tbl5 = {}
local v7 = nil

local function fn7()
	pcall(function()
		table.clear(tbl5)

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer then
				table.insert(tbl5, player.Name)
			end
		end

		if Options.TargetPlayerDropdown then
			Options.TargetPlayerDropdown:SetValues(tbl5)
		end
	end)
end

Target:AddDropdown("TargetPlayerDropdown", { Values = tbl5, Default = 1, AllowNull = true, Multi = false, Text = "Player" })

Options.TargetPlayerDropdown:OnChanged(function()
	v7 = Players:FindFirstChild(Options.TargetPlayerDropdown.Value)
end)

fn(Players.PlayerAdded:Connect(fn7))
fn(Players.PlayerRemoving:Connect(fn7))
fn7()

Target:AddButton({
	Text = "Teleport",
	Func = function()
		if v7 and v7.Character then
			local humanoidRootPart = v7.Character:FindFirstChild("HumanoidRootPart")
			local humanoidRootPart2 = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")

			if humanoidRootPart and humanoidRootPart2 then
				humanoidRootPart2.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 0, -3)
			end
		else
			v:Notify("Target character not found.", 2)
		end
	end,
})

Target:AddButton({
	Text = "Spectate",
	Func = function()
		if v7 and v7.Character then
			local humanoid = v7.Character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				currentCamera.CameraSubject = humanoid
				v:Notify("Now spectating: " .. v7.Name, 2)
			end
		else
			currentCamera.CameraSubject = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
			v:Notify("Reset camera to local player.", 2)
		end
	end,
})

Target:AddButton({
	Text = "Stop Spectating",
	Func = function()
		currentCamera.CameraSubject = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
		v:Notify("Reset camera to local player.", 2)
	end,
})

local esp = v4:AddTab("ESP")
local esp2 = esp:AddLeftGroupbox("ESP")
local Visuals = esp:AddRightGroupbox("Visuals")
esp2:AddToggle("MasterESP", { Text = "Enable", Default = false })
Toggles.MasterESP:AddKeyPicker("MasterESPKey", { Default = "None", SyncToggleState = true, Mode = "Toggle", Text = "ESP toggle key" })
esp2:AddDivider()
esp2:AddToggle("BoxESP", { Text = "Box", Default = false }):AddColorPicker("BoxColor", { Default = Color3.fromRGB(255, 255, 255), Title = "Box Color" })
esp2:AddToggle("TracerESP", { Text = "Tracers", Default = false }):AddColorPicker("TracerColor", { Default = Color3.fromRGB(255, 255, 255), Title = "Tracer Color" })
esp2:AddToggle("TextESP", { Text = "Names", Default = false }):AddColorPicker("TextColor", { Default = Color3.fromRGB(255, 255, 255), Title = "Name Color" })
esp2:AddToggle("DistanceESP", { Text = "Distances", Default = false }):AddColorPicker("DistanceColor", { Default = Color3.fromRGB(255, 255, 255), Title = "Distance Color" })
esp2:AddToggle("HealthESP", { Text = "Health Bar", Default = false })
local ChamsActive = esp2:AddToggle("ChamsActive", { Text = "Chams", Default = false })
ChamsActive:AddColorPicker("ChamsColor", { Default = Color3.fromRGB(255, 0, 100), Title = "Chams Fill Color" })
ChamsActive:AddColorPicker("ChamsOutlineColor", { Default = Color3.fromRGB(255, 255, 255), Title = "Chams Outline Color" })
esp2:AddSlider("MaxESPDistance", { Text = "Max Distance", Default = 1000, Min = 100, Max = 5000, Rounding = 0 })
local tbl6 = {}

local function fn8(player)
	if player == localPlayer then
		return
	end

	local ok, result = pcall(function()
		local tbl7 = {
			Box = Drawing.new("Square"),
			Tracer = Drawing.new("Line"),
			Name = Drawing.new("Text"),
			Distance = Drawing.new("Text"),
			HealthBarBg = Drawing.new("Line"),
			HealthBar = Drawing.new("Line"),
		}

		tbl7.Box.Color = Color3.fromRGB(255, 0, 100)
		tbl7.Box.Thickness = 1.5
		tbl7.Box.Filled = false
		tbl7.Box.Visible = false
		tbl7.Tracer.Color = Color3.fromRGB(255, 255, 255)
		tbl7.Tracer.Thickness = 1
		tbl7.Tracer.Visible = false
		tbl7.Name.Color = Color3.fromRGB(255, 255, 255)
		tbl7.Name.Size = 13
		tbl7.Name.Center = true
		tbl7.Name.Outline = true
		tbl7.Name.Visible = false
		tbl7.Distance.Color = Color3.fromRGB(255, 255, 255)
		tbl7.Distance.Size = 13
		tbl7.Distance.Center = true
		tbl7.Distance.Outline = true
		tbl7.Distance.Visible = false
		tbl7.HealthBarBg.Thickness = 2
		tbl7.HealthBarBg.Color = Color3.fromRGB(50, 0, 0)
		tbl7.HealthBarBg.Visible = false
		tbl7.HealthBar.Thickness = 2
		tbl7.HealthBar.Color = Color3.fromRGB(0, 255, 0)
		tbl7.HealthBar.Visible = false
		return tbl7
	end)

	if ok and result then
		tbl6[player] = result
	end
end

local function fn9(player)
	if tbl6[player] then
		for _, v8 in pairs(tbl6[player]) do
			v8:Destroy()
		end

		tbl6[player] = nil
	end
end

for _, player in ipairs(Players:GetPlayers()) do
	fn8(player)
end

fn(Players.PlayerAdded:Connect(fn8))
fn(Players.PlayerRemoving:Connect(fn9))

fn(RunService.RenderStepped:Connect(function()
	local value = Toggles.MasterESP and Toggles.MasterESP.Value
	local value2 = Toggles.BoxESP and Toggles.BoxESP.Value
	local value3 = Toggles.TracerESP and Toggles.TracerESP.Value
	local value4 = Toggles.TextESP and Toggles.TextESP.Value
	local value5 = Toggles.DistanceESP and Toggles.DistanceESP.Value
	local value6 = Toggles.HealthESP and Toggles.HealthESP.Value
	local n2 = Options.MaxESPDistance and Options.MaxESPDistance.Value or 1000

	for k, v8 in pairs(tbl6) do
		local parent = value and k.Parent
		local flag = false

		if parent then
			local character = k.Character

			if not character then
				local entities = Workspace:FindFirstChild("Entities")

				if entities then
					character = entities:FindFirstChild(k.Name) or entities:FindFirstChild(k.DisplayName)
				end
			end

			if character then
				local head = character:FindFirstChild("Head")
				local humanoidRootPart = character:FindFirstChild("HumanoidRootPart") or head or character:FindFirstChildWhichIsA("BasePart")
				local humanoid = character:FindFirstChildOfClass("Humanoid")

				if humanoidRootPart then
					local magnitude = (currentCamera.CFrame.Position - humanoidRootPart.Position).Magnitude

					if magnitude <= n2 then
						local v9, v10 = currentCamera:WorldToViewportPoint(humanoidRootPart.Position)
						head = head and head.Position + Vector3.new(0, 0.5, 0) or humanoidRootPart.Position + Vector3.new(0, 3, 0)
						local n3 = humanoidRootPart.Position - Vector3.new(0, 3.05, 0)
						local v11 = currentCamera:WorldToViewportPoint(head)
						local v12 = currentCamera:WorldToViewportPoint(n3)

						if v10 then
							local n4 = v11.Y - 2
							local n5 = v12.Y + 2
							local n6 = math.max(n5 - n4, 6)
							local n7 = n6 * 0.52
							local n8 = v9.X - n7 / 2

							if value3 then
								v8.Tracer.From = Vector2.new(currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y)
								v8.Tracer.To = Vector2.new(v9.X, n5)
								v8.Tracer.Color = Options.TracerColor and Options.TracerColor.Value or Color3.fromRGB(255, 255, 255)
								v8.Tracer.Visible = true
							else
								v8.Tracer.Visible = false
							end

							if value2 then
								v8.Box.Size = Vector2.new(n7, n6)
								v8.Box.Position = Vector2.new(n8, n4)
								v8.Box.Color = Options.BoxColor and Options.BoxColor.Value or Color3.fromRGB(255, 0, 100)
								v8.Box.Visible = true
							else
								v8.Box.Visible = false
							end

							if value6 then
								local health = nil
								local maxHealth = nil

								if humanoid then
									health = humanoid.Health
									maxHealth = humanoid.MaxHealth
								end

								if not health or health == 0 then
									local health2 = character:FindFirstChild("Health")

									if health2 and health2:IsA("NumberValue") or health2 and health2:IsA("IntValue") then
										health = health2.Value
									end
								end

								local maxHealth2 = character:FindFirstChild("MaxHealth")

								if maxHealth2 and (maxHealth2:IsA("NumberValue") or maxHealth2:IsA("IntValue")) then
									maxHealth = maxHealth2.Value
								end

								local n9 = math.clamp((health or 100) / math.max(maxHealth or 100, 1), 0, 1)
								local n10 = n8 - 5
								v8.HealthBarBg.From = Vector2.new(n10, n4)
								v8.HealthBarBg.To = Vector2.new(n10, n4 + n6)
								v8.HealthBarBg.Visible = true
								v8.HealthBar.From = Vector2.new(n10, n4)
								v8.HealthBar.To = Vector2.new(n10, n4 + n6 * n9)
								v8.HealthBar.Color = Color3.fromHSV(n9 * 0.33, 1, 1)
								v8.HealthBar.Visible = true
							else
								v8.HealthBarBg.Visible = false
								v8.HealthBar.Visible = false
							end

							if value4 then
								v8.Name.Text = k.Name
								v8.Name.Position = Vector2.new(v9.X, n4 - 14)
								v8.Name.Color = Options.TextColor and Options.TextColor.Value or Color3.fromRGB(255, 255, 255)
								v8.Name.Visible = true
							else
								v8.Name.Visible = false
							end

							if value5 then
								local n9 = value4 and 12 or 0
								v8.Distance.Text = string.format("%.0fm", magnitude)
								v8.Distance.Position = Vector2.new(v9.X, n4 - 14 - n9)
								v8.Distance.Color = Options.DistanceColor and Options.DistanceColor.Value or Color3.fromRGB(255, 255, 255)
								v8.Distance.Visible = true
								flag = true
							else
								v8.Distance.Visible = false
								flag = true
							end
						end
					end
				end
			end
		end

		if not flag then
			v8.Box.Visible = false
			v8.Tracer.Visible = false
			v8.Name.Visible = false
			v8.Distance.Visible = false
			v8.HealthBarBg.Visible = false
			v8.HealthBar.Visible = false
		end
	end
end))

local tbl7 = {}

Options.ChamsColor:OnChanged(function()
	local fillColor = Options.ChamsColor.Value

	for _, v8 in pairs(tbl7) do
		pcall(function()
			if v8 then
				v8.FillColor = fillColor
			end
		end)
	end
end)

Options.ChamsOutlineColor:OnChanged(function()
	local outlineColor = Options.ChamsOutlineColor.Value

	for _, v8 in pairs(tbl7) do
		pcall(function()
			if v8 then
				v8.OutlineColor = outlineColor
			end
		end)
	end
end)

local function fn10(arg)
	if arg == localPlayer then
		return
	end

	local function fn11(character)
		if not Toggles.ChamsActive or not Toggles.ChamsActive.Value then
			return
		end

		if tbl7[arg] then
			tbl7[arg]:Destroy()
		end

		local highlight = Instance.new("Highlight")
		highlight.Name = "LinoriaCham"
		highlight.FillColor = Options.ChamsColor and Options.ChamsColor.Value or Color3.fromRGB(255, 0, 100)
		highlight.OutlineColor = Options.ChamsOutlineColor and Options.ChamsOutlineColor.Value or Color3.fromRGB(255, 255, 255)
		highlight.FillTransparency = 0.5
		highlight.OutlineTransparency = 0
		highlight.Adornee = character
		highlight.Parent = character
		tbl7[arg] = highlight
	end

	if arg.Character then
		fn11(arg.Character)
	end

	arg.CharacterAdded:Connect(fn11)
end

local function fn11(arg)
	if tbl7[arg] then
		tbl7[arg]:Destroy()
		tbl7[arg] = nil
	end
end

Toggles.ChamsActive:OnChanged(function()
	if Toggles.ChamsActive.Value then
		for _, player in ipairs(Players:GetPlayers()) do
			fn10(player)
		end
	else
		for k in pairs(tbl7) do
			fn11(k)
		end
	end
end)

fn(Players.PlayerAdded:Connect(function(player)
	if Toggles.ChamsActive and Toggles.ChamsActive.Value then
		fn10(player)
	end
end))

fn(Players.PlayerRemoving:Connect(function(player)
	fn11(player)
end))

Visuals:AddToggle("FullBrightActive", { Text = "FullBright", Default = false })
Toggles.FullBrightActive:AddKeyPicker("FullBrightKey", { Default = "None", SyncToggleState = true, Mode = "Toggle", Text = "FullBright" })
local tbl8 = nil

Toggles.FullBrightActive:OnChanged(function()
	if Toggles.FullBrightActive.Value then
		if not tbl8 then
			tbl8 = { Ambient = Lighting.Ambient, OutdoorAmbient = Lighting.OutdoorAmbient, ClockTime = Lighting.ClockTime }
		end

		Lighting.Ambient = Color3.fromRGB(255, 255, 255)
		Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
		Lighting.ClockTime = 14
	elseif tbl8 then
		Lighting.Ambient = tbl8.Ambient
		Lighting.OutdoorAmbient = tbl8.OutdoorAmbient
		Lighting.ClockTime = tbl8.ClockTime
		tbl8 = nil
	end
end)

local Utilities = v4:AddTab("Utilities")
local Performance = Utilities:AddLeftGroupbox("Performance")
local Connections = Utilities:AddRightGroupbox("Connections")

Performance:AddButton("Fix Blue World (Lighting)", function()
	Lighting.Ambient = Color3.fromRGB(255, 255, 255)
	Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
	Lighting.ClockTime = 14

	for _, child in pairs(Lighting:GetChildren()) do
		if child:IsA("ColorCorrectionEffect") or child:IsA("Atmosphere") or child:IsA("Sky") or child:IsA("Fog") or child:IsA("BloomEffect") or child:IsA("BlurEffect") then
			child:Destroy()
		end
	end

	v:Notify("Lighting and Atmosphere fixed.", 2)
end)

Performance:AddToggle("FPSBoosterActive", { Text = "FPS Booster", Default = false })
local tbl9 = {}

local function fn12(arg)
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
		for k, v8 in pairs(tbl9) do
			pcall(function()
				if v8.Enabled ~= nil then
					k.Enabled = v8.Enabled
				elseif v8.Texture ~= nil then
					k.Texture = v8.Texture
				end
			end)
		end

		table.clear(tbl9)
	end
end

Toggles.FPSBoosterActive:OnChanged(function()
	fn12(Toggles.FPSBoosterActive.Value)
end)

fn(Workspace.DescendantAdded:Connect(function(descendant)
	if Toggles.FPSBoosterActive and Toggles.FPSBoosterActive.Value then
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
	Tooltip = "Bypasses idle kick using simulated keyboard inputs",
})

local connection = nil

Toggles.AntiAFK:OnChanged(function()
	if Toggles.AntiAFK.Value then
		connection = localPlayer.Idled:Connect(function()
			pcall(function()
				VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
				task.wait(0.1)
				VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.RightControl, false, game)
			end)
		end)
	elseif connection then
		connection:Disconnect()
		connection = nil
	end
end)

Connections:AddButton({
	Text = "Server Hopper",
	Func = function()
		v:Notify("Searching for a new server...", 3)

		task.spawn(function()
			local tbl10 = {}

			local ok, result = pcall(function()
				return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
			end)

			if ok and result and result.data then
				for _, v8 in ipairs(result.data) do
					if v8.playing < v8.maxPlayers and v8.id ~= game.JobId then
						table.insert(tbl10, v8.id)
					end
				end
			end

			if #tbl10 > 0 then
				TeleportService:TeleportToPlaceInstance(game.PlaceId, tbl10[math.random(1, #tbl10)], localPlayer)
			else
				v:Notify("No suitable servers found.", 3)
			end
		end)
	end,
})

Connections:AddButton({
	Text = "Rejoin Server",
	Func = function()
		v:Notify("Reconnecting to server...", 3)

		if #Players:GetPlayers() <= 1 then
			TeleportService:Teleport(game.PlaceId, localPlayer)
		else
			TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayer)
		end
	end,
})

local n2 = 0

fn(RunService.Heartbeat:Connect(function()
	local readOnly = localPlayer:FindFirstChild("ReadOnly")
	local heat = readOnly and readOnly:FindFirstChild("heat")
	local heatMax = readOnly and readOnly:FindFirstChild("heat_max")
	local heatPerBullet = readOnly and readOnly:FindFirstChild("heat_per_bullet")

	local function fn13()
		if not (heat and heatMax and heatPerBullet) then
			return false
		end
		return heat.Value + heatPerBullet.Value < heatMax.Value
	end

	if Toggles.Triggerbot and Toggles.Triggerbot.Value then
		local target = mouse.Target

		if target and target.Parent then
			local humanoid = target.Parent:FindFirstChild("Humanoid") or target.Parent.Parent:FindFirstChild("Humanoid")

			if humanoid and humanoid.Health > 0 and not target:IsDescendantOf(localPlayer.Character) then
				if fn13() then
					VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
					task.wait(0.01)
					VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
				end
			end
		end
	end

	if Toggles.KillAura and Toggles.KillAura.Value then
		local n3 = Options.KillAuraRange and Options.KillAuraRange.Value or 15
		local character = localPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		local v8 = nil

		if humanoidRootPart then
			local entities = Workspace:FindFirstChild("Entities") or Workspace
			v8 = nil

			for _, child in ipairs(entities:GetChildren()) do
				if child ~= character and child:FindFirstChild("HumanoidRootPart") and child:FindFirstChild("Humanoid") and child.Humanoid.Health > 0 then
					if (child.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude <= n3 then
						v8 = child
						break
					else
						v8 = nil
					end
				else
					v8 = nil
				end
			end
		end

		if v8 and tick() - n2 >= 0.08 then
			n2 = tick()
			local flag = false

			pcall(function()
				if mouse1click then
					mouse1click()
					flag = true
				elseif mouse1press and mouse1release then
					mouse1press()
					task.wait(0.01)
					mouse1release()
					flag = true
				end
			end)

			if not flag then
				local mouseLocation = UserInputService:GetMouseLocation()
				VirtualInputManager:SendMouseButtonEvent(mouseLocation.X, mouseLocation.Y, 0, true, game, 1)
				task.wait(0.01)
				VirtualInputManager:SendMouseButtonEvent(mouseLocation.X, mouseLocation.Y, 0, false, game, 1)
			end

			if Toggles.AutoDashStrike and Toggles.AutoDashStrike.Value then
				local leftShift = Enum.KeyCode[Options.DashStrikeKey and Options.DashStrikeKey.Value or "LeftShift"] or Enum.KeyCode.LeftShift
				VirtualInputManager:SendKeyEvent(true, leftShift, false, game)
				task.wait(0.01)
				VirtualInputManager:SendKeyEvent(false, leftShift, false, game)
			end
		end
	end
end))

fn(RunService.Heartbeat:Connect(function()
	if Toggles.AutoSlideHop and Toggles.AutoSlideHop.Value then
		local character = localPlayer.Character
		character = character and character:FindFirstChildOfClass("Humanoid")

		if character and character.FloorMaterial ~= Enum.Material.Air and character.MoveDirection.Magnitude > 0 then
			local str = Options.AutoHopKey and Options.AutoHopKey.Value or "Space"

			if str == "Space" then
				character.Jump = true
			else
				local v8 = Enum.KeyCode[str]

				if v8 then
					VirtualInputManager:SendKeyEvent(true, v8, false, game)
					task.wait(0.01)
					VirtualInputManager:SendKeyEvent(false, v8, false, game)
				end
			end
		end
	end
end))

fn(RunService.Heartbeat:Connect(function()
	if Toggles.AutoBrake and Toggles.AutoBrake.Value then
		local character = localPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

		if humanoidRootPart and humanoidRootPart.Velocity.Magnitude > 5 then
			local n3 = humanoidRootPart.Position + humanoidRootPart.Velocity.Unit * 4
			local raycastParams = RaycastParams.new()
			raycastParams.FilterDescendantsInstances = { character }
			raycastParams.FilterType = Enum.RaycastFilterType.Exclude

			if not Workspace:Raycast(n3, Vector3.new(0, -10, 0), raycastParams) then
				humanoidRootPart.Velocity = Vector3.new(0, humanoidRootPart.Velocity.Y, 0)
			end
		end
	end
end))

local Settings = v4:AddTab("Settings")
local Configs = Settings:AddLeftGroupbox("Configs")
local System = Settings:AddRightGroupbox("System")
local v8 = Settings:AddRightGroupbox("Share Config")
local str = "RedlinerConfigs"

local function fn13()
	local tbl10 = {}

	pcall(function()
		if isfolder("RedlinerConfigs") then
			for _, v9 in ipairs(listfiles("RedlinerConfigs")) do
				local match = v9:match("[/\\]([^/\\]+)%.json$") or v9:match("([^/\\]+)%.json$")

				if match and match ~= "_autoload" then
					table.insert(tbl10, match)
				end
			end
		end
	end)

	if #tbl10 == 0 then
		table.insert(tbl10, "(none)")
	end

	return tbl10
end

local tbl10 = { LoadConfigDropdown = true, ConfigName = true, AutoLoadConfig = true }

local function fn14(configNotFound)
	local ok, result = pcall(readfile, str .. "/" .. configNotFound .. ".json")
	if not ok or not result then
		v:Notify("Config not found: " .. configNotFound, 2)
		return
	end

	local ok2, result2 = pcall(function()
		return HttpService:JSONDecode(result)
	end)

	if not ok2 or not result2 then
		v:Notify("Failed to parse config.", 2)
		return
	end

	for k, v9 in pairs(result2) do
		if not tbl10[k] then
			pcall(function()
				if Toggles[k] then
					Toggles[k].Value = v9
				elseif Options[k] and Options[k].SetValue then
					Options[k]:SetValue(v9)
				end
			end)
		end
	end

	v:Notify("Loaded config: " .. configNotFound, 2)
end

local flag = false

local function fn15()
	flag = true

	pcall(function()
		Options.LoadConfigDropdown:SetValues(fn13())
	end)

	task.defer(function()
		flag = false
	end)
end

Configs:AddInput("ConfigName", { Text = "Config Name", Default = "default", Placeholder = "default" })

Configs:AddButton({
	Text = "Save Config",
	Func = function()
		local savedConfig = Options.ConfigName and Options.ConfigName.Value ~= "" and Options.ConfigName.Value or "default"

		pcall(function()
			if not isfolder("RedlinerConfigs") then
				makefolder("RedlinerConfigs")
			end

			local tbl11 = {}

			for k, flag2 in pairs(v.Flags) do
				if not tbl10[k] then
					local kind = type(flag2)

					if kind == "boolean" or kind == "number" or kind == "string" then
						tbl11[k] = flag2
					elseif kind == "table" and flag2.Key and flag2.Mode then
						tbl11[k] = tostring(flag2.Key):gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", "")
					end
				end
			end

			writefile(str .. "/" .. savedConfig .. ".json", HttpService:JSONEncode(tbl11))
		end)

		v:Notify("Saved config: " .. savedConfig, 2)
		fn15()
	end,
})

Configs:AddDropdown("LoadConfigDropdown", { Text = "Select Config", Values = fn13(), Default = 1, Multi = false })

Configs:AddButton({
	Text = "Load Config",
	Func = function()
		local str2 = Options.LoadConfigDropdown and Options.LoadConfigDropdown.Value or "(none)"
		if str2 == "(none)" then
			v:Notify("No config selected.", 2)
			return
		end
		fn14(str2)
	end,
})

Configs:AddButton({
	Text = "Refresh List",
	Func = function()
		fn15()
		v:Notify("Config list refreshed.", 2)
	end,
})

Configs:AddButton({
	Text = "Delete Config",
	Func = function()
		local deletedConfig = Options.LoadConfigDropdown and Options.LoadConfigDropdown.Value or "(none)"
		if deletedConfig == "(none)" then
			v:Notify("No config selected.", 2)
			return
		end

		pcall(function()
			if isfile(str .. "/" .. deletedConfig .. ".json") then
				delfile(str .. "/" .. deletedConfig .. ".json")
			end
		end)

		v:Notify("Deleted config: " .. deletedConfig, 2)
		fn15()
	end,
})

Configs:AddToggle("AutoLoadConfig", { Text = "Auto Load on Start", Default = false })
local flag2 = false

Toggles.AutoLoadConfig:OnChanged(function()
	if not flag2 then
		return
	end

	if Toggles.AutoLoadConfig.Value then
		local str2 = Options.LoadConfigDropdown and Options.LoadConfigDropdown.Value or "(none)"
		if str2 == "(none)" then
			v:Notify("Select a config first.", 2)
			return
		end

		pcall(function()
			if not isfolder("RedlinerConfigs") then
				makefolder("RedlinerConfigs")
			end

			writefile(str .. "/_autoload.txt", str2)
		end)

		v:Notify("Auto-load set to: " .. str2, 2)
	else
		pcall(function()
			if isfile(str .. "/_autoload.txt") then
				delfile(str .. "/_autoload.txt")
			end
		end)

		v:Notify("Auto-load disabled.", 2)
	end
end)

Options.LoadConfigDropdown:OnChanged(function()
	if flag then
		return
	end

	if Toggles.AutoLoadConfig and Toggles.AutoLoadConfig.Value then
		local value = Options.LoadConfigDropdown.Value

		if value and value ~= "(none)" then
			pcall(function()
				writefile(str .. "/_autoload.txt", value)
			end)
		end
	end
end)

System:AddLabel("Toggle Menu: RightShift")

System:AddButton({
	Text = "Unload Hub",
	Func = function()
		for _, v9 in ipairs(tbl) do
			pcall(function()
				if typeof(v9) == "RBXScriptConnection" then
					v9:Disconnect()
				end
			end)
		end

		table.clear(tbl)

		if connection then
			pcall(function()
				connection:Disconnect()
			end)

			connection = nil
		end

		for _, v9 in ipairs(tbl2) do
			pcall(task.cancel, v9)
		end

		table.clear(tbl2)

		for _, v9 in pairs(tbl7) do
			pcall(function()
				if v9 then
					v9:Destroy()
				end
			end)
		end

		table.clear(tbl7)

		if circle then
			pcall(function()
				circle:Destroy()
			end)
		end

		for _, v9 in pairs(tbl6) do
			for _, v10 in pairs(v9) do
				pcall(function()
					v10:Destroy()
				end)
			end
		end

		table.clear(tbl6)
		fn12(false)

		for k, v9 in pairs(tbl4) do
			pcall(function()
				if k and k.Parent then
					k.Size = v9.Size
					k.CanCollide = v9.CanCollide
					k.Transparency = v9.Transparency
				end
			end)
		end

		table.clear(tbl4)
		Lighting.Ambient = tbl3.Ambient
		Lighting.OutdoorAmbient = tbl3.OutdoorAmbient
		Lighting.ClockTime = tbl3.ClockTime or 12
		local character = localPlayer.Character
		character = character and character:FindFirstChildOfClass("Humanoid")

		if character then
			character.WalkSpeed = 16
			character.JumpPower = 50
		end

		v:Unload()
	end,
	DoubleClick = true,
	Tooltip = "Double-click to completely clean and unload the script.",
})

v8:AddInput("ConfigShareCode", { Text = "Share Config", Default = "", Placeholder = "Paste share code here..." })

v8:AddButton({
	Text = "Export (Copy)",
	Func = function()
		local tbl11 = {}

		for k, flag3 in pairs(v.Flags) do
			if not tbl10[k] then
				local kind = type(flag3)

				if kind == "boolean" or kind == "number" or kind == "string" then
					tbl11[k] = flag3
				elseif kind == "table" and flag3.Key and flag3.Mode then
					tbl11[k] = tostring(flag3.Key):gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", "")
				end
			end
		end

		local json = HttpService:JSONEncode(tbl11)

		local ok = pcall(function()
			setclipboard(json)
		end)

		pcall(function()
			Options.ConfigShareCode:SetValue(json)
		end)

		if ok then
			v:Notify("Config copied to clipboard! Paste to share.", 3)
		else
			v:Notify("Copied to code box — select all & copy manually.", 3)
		end
	end,
})

v8:AddButton({
	Text = "Import (Apply)",
	Func = function()
		local str2 = Options.ConfigShareCode and Options.ConfigShareCode.Value or ""
		if str2 == "" then
			v:Notify("Paste a share code first.", 2)
			return
		end

		local ok, result = pcall(function()
			return HttpService:JSONDecode(str2)
		end)

		if not ok or type(result) ~= "table" then
			v:Notify("Invalid share code.", 2)
			return
		end

		for k, v9 in pairs(result) do
			if not tbl10[k] then
				pcall(function()
					if Toggles[k] then
						Toggles[k].Value = v9
					elseif Options[k] and Options[k].SetValue then
						Options[k]:SetValue(v9)
					end
				end)
			end
		end

		v:Notify("Imported config from share code!", 2)
	end,
})

v:SetWatermarkVisibility(false)
v:Notify("Redliner Custom Framework Loaded Successfully.", 3)

task.spawn(function()
	task.wait(0.5)
	local ok, result = pcall(readfile, str .. "/_autoload.txt")

	if ok and result then
		result = result:match("^%s*(.-)%s*$")
	end

	if ok and result and result ~= "" and result ~= "(none)" then
		fn14(result)
		flag = true

		pcall(function()
			Options.LoadConfigDropdown:SetValue(result)
		end)

		task.defer(function()
			flag = false
		end)

		Toggles.AutoLoadConfig.Value = true
		v:Notify("Auto-loaded config: " .. result, 3)
	end

	flag2 = true
end)
