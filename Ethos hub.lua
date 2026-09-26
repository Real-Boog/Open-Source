-- this is for Arsenal

local Players, RunService, UserInputService, LocalPlayer, v12, t2, v51, t5, u301, u302, t10, n2, u306, u307, u310, n3, s2, n4, u314, u315, u316, u317, u318, u319, u320, color3, u323, u324, u325, u330, u331, n6, t13, u335, t14, u337, t15, u339, t16, u341, t17, u344, v357, v363, v372, v389, v391, u399, u405, v407, v409

do
	local u346, u383
	local function v1(...)
		local t1 = { ... }

		t1.n = select("#", ...)

		return t1
	end

	Players = game:GetService("Players")
	RunService = game:GetService("RunService")
	UserInputService = game:GetService("UserInputService")

	local TeleportService = game:GetService("TeleportService")
	local CurrentCamera, v23

	do
		local BlurEffect, ScreenGui

		do
			local TweenService = game:GetService("TweenService")
			local Frame, Frame2, TextLabel, Frame3

			do
				local Lighting = game:GetService("Lighting")

				LocalPlayer = Players.LocalPlayer
				CurrentCamera = workspace.CurrentCamera

				do
					local v11 = v1(game:HttpGet("https://raw.githubusercontent.com/TKyoka/EthosX/refs/heads/main/EthosX%20UI"))

					v12 = loadstring(unpack(v11, 1, v11.n))()
				end

				BlurEffect = Instance.new("BlurEffect")
				BlurEffect.Size = 0
				BlurEffect.Parent = Lighting
				TweenService:Create(BlurEffect, TweenInfo.new(1.2, Enum.EasingStyle.Quint), {
					Size = 20,
				}):Play()
				ScreenGui = Instance.new("ScreenGui")
				ScreenGui.Name = "ScriptHubLoader"
				ScreenGui.IgnoreGuiInset = true
				ScreenGui.ResetOnSpawn = false
				ScreenGui.DisplayOrder = 999999
				ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
				ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
				Frame = Instance.new("Frame")
				Frame.Size = UDim2.new(1, 0, 1, 0)
				Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				Frame.BackgroundTransparency = 1
				Frame.BorderSizePixel = 0
				Frame.Parent = ScreenGui
				TweenService:Create(Frame, TweenInfo.new(1.2, Enum.EasingStyle.Quint), {
					BackgroundTransparency = 0.35,
				}):Play()
				task.wait(0.8)
				Frame2 = Instance.new("Frame")
				Frame2.AnchorPoint = Vector2.new(0.5, 0.5)
				Frame2.Position = UDim2.new(0.5, 0, 0.5, 0)
				Frame2.Size = UDim2.new(0, 380, 0, 60)
				Frame2.BackgroundTransparency = 1
				Frame2.Parent = Frame
				TextLabel = Instance.new("TextLabel")
				TextLabel.BackgroundTransparency = 1
				TextLabel.Size = UDim2.new(1, 0, 0, 28)
				TextLabel.Position = UDim2.new(0, 0, 0, 0)
				TextLabel.Text = "LOADING ETHOS HUB"
				TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.TextTransparency = 1
				TextLabel.TextSize = 21
				TextLabel.Font = Enum.Font.GothamBold
				TextLabel.TextXAlignment = Enum.TextXAlignment.Center
				TextLabel.Parent = Frame2
				Frame3 = Instance.new("Frame")
				Frame3.AnchorPoint = Vector2.new(0.5, 0.5)
				Frame3.Position = UDim2.new(0.5, 0, 0.85, 0)
				Frame3.Size = UDim2.new(0, 300, 0, 10)
				Frame3.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
				Frame3.BackgroundTransparency = 1
				Frame3.BorderSizePixel = 0
				Frame3.Parent = Frame2

				local UICorner = Instance.new("UICorner")

				UICorner.CornerRadius = UDim.new(1, 0)
				UICorner.Parent = Frame3
			end

			local Frame4 = Instance.new("Frame")

			Frame4.Size = UDim2.new(0, 0, 1, 0)
			Frame4.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
			Frame4.BackgroundTransparency = 1
			Frame4.BorderSizePixel = 0
			Frame4.Parent = Frame3

			local UICorner = Instance.new("UICorner")

			UICorner.CornerRadius = UDim.new(1, 0)
			UICorner.Parent = Frame4

			local TextLabel2 = Instance.new("TextLabel")

			TextLabel2.BackgroundTransparency = 1
			TextLabel2.Size = UDim2.new(1, 0, 0, 18)
			TextLabel2.Position = UDim2.new(0, 0, 1, 5)
			TextLabel2.Text = "Arsenal - Kyoka"
			TextLabel2.TextColor3 = Color3.fromRGB(180, 180, 180)
			TextLabel2.TextTransparency = 1
			TextLabel2.TextSize = 14
			TextLabel2.Font = Enum.Font.Gotham
			TextLabel2.TextXAlignment = Enum.TextXAlignment.Center
			TextLabel2.Parent = Frame2
			TweenService:Create(TextLabel, TweenInfo.new(0.6), {
				TextTransparency = 0,
			}):Play()
			TweenService:Create(Frame3, TweenInfo.new(0.6), {
				BackgroundTransparency = 0.5,
			}):Play()
			TweenService:Create(Frame4, TweenInfo.new(0.6), {
				BackgroundTransparency = 0,
			}):Play()
			TweenService:Create(TextLabel2, TweenInfo.new(0.6), {
				TextTransparency = 0,
			}):Play()
			task.wait(0.3)
			TweenService:Create(Frame4, TweenInfo.new(5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
				Size = UDim2.new(1, 0, 1, 0),
			}):Play()
			task.wait(5.2)
			TweenService:Create(Frame, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {
				BackgroundTransparency = 1,
			}):Play()
			TweenService:Create(TextLabel, TweenInfo.new(0.4), {
				TextTransparency = 1,
			}):Play()
			TweenService:Create(Frame3, TweenInfo.new(0.4), {
				BackgroundTransparency = 1,
			}):Play()
			TweenService:Create(Frame4, TweenInfo.new(0.4), {
				BackgroundTransparency = 1,
			}):Play()
			TweenService:Create(BlurEffect, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {
				Size = 0,
			}):Play()
			TweenService:Create(TextLabel2, TweenInfo.new(0.4), {
				TextTransparency = 1,
			}):Play()
		end

		task.wait(0.4)
		ScreenGui:Destroy()
		BlurEffect:Destroy()

		function v23(p1, p2, p3)
			local s1 = ""
			local v568 = #p1

			for i = 1, v568 do
				local v571 = i - 1
				local v572 = v568 - 1
				local v573 = v571 / math.max(v572, 1)
				local v574 = (p2.R + (p3.R - p2.R) * v573) * 255
				local v575 = math.floor(v574)
				local v576 = (p2.G + (p3.G - p2.G) * v573) * 255
				local v577 = math.floor(v576)
				local v578 = (p2.B + (p3.B - p2.B) * v573) * 255
				local v579 = math.floor(v578)
				local _ = s1 .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', v575, v577, v579, p1:sub(i, i))
			end

			return s1
		end

		t2 = {}

		local color3_2 = Color3.fromHex("#856d6d")
		local v26 = v1(Color3.fromHex("#ffffff"))

		t2.Ethos = v23("Ethos", color3_2, unpack(v26, 1, v26.n))

		local color3_3 = Color3.fromHex("#00ff88")
		local v28 = v1(Color3.fromHex("#00e1ff"))

		t2.Release = v23("Release", color3_3, unpack(v28, 1, v28.n))

		local color3_4 = Color3.fromHex("#00ccff")
		local v30 = v1(Color3.fromHex("#ffffff"))

		t2.Update = v23("Update", color3_4, unpack(v30, 1, v30.n))

		local color3_5 = Color3.fromHex("#a259ff")
		local v32 = v1(Color3.fromHex("#6a00f4"))

		t2.Discord = v23("Discord", color3_5, unpack(v32, 1, v32.n))
	end

	do
		local color3_6 = Color3.fromHex("#00eeff")
		local v34 = v1(Color3.fromHex("#0077ff"))

		t2.Script = v23("Script Developer", color3_6, unpack(v34, 1, v34.n))

		local color3_7 = Color3.fromHex("#00ff33")
		local v36 = v1(Color3.fromHex("#00ff33"))

		t2.Add = v23("[ + ]", color3_7, unpack(v36, 1, v36.n))

		local color3_8 = Color3.fromHex("#ff5555")
		local v38 = v1(Color3.fromHex("#ff5555"))

		t2.Remove = v23("[ - ]", color3_8, unpack(v38, 1, v38.n))

		local color3_9 = Color3.fromHex("#00ccff")
		local v40 = v1(Color3.fromHex("#00ccff"))

		t2.Notice = v23("[ ! ]", color3_9, unpack(v40, 1, v40.n))
	end

	do
		local color3_10 = Color3.fromHex("#00ff88")
		local v42 = v1(Color3.fromHex("#00e1ff"))

		t2.Coming = v23("Coming Soon", color3_10, unpack(v42, 1, v42.n))

		local color3_11 = Color3.fromHex("#ffcc00")
		local v44 = v1(Color3.fromHex("#ffeda3"))

		t2.Warning = v23("Warning", color3_11, unpack(v44, 1, v44.n))
		v12:SetNotificationLower(true)
		local u45 = false

		local t3 = {
			Title = "Arsenal - [1.6.5]",
			Author = "by Kyoka - Ethos Hub",
			Icon = "rbxassetid://120319402766383",
			Folder = "arsenal.configs",
			Size = UDim2.fromOffset(650, 425),
			NewElements = true,
			Transparent = true,
			Theme = "Dark",
			SideBarWidth = 200,
			HasOutline = true,
			ToggleKey = Enum.KeyCode.U,
			User = {
				Enabled = true,
				Anonymous = false,
				Callback = function()
					u45 = not u45
					Window.User:SetAnonymous(u45)
				end,
			},
		}
		local t4 = {
			CornerRadius = UDim.new(1, 0),
			StrokeThickness = 3,
			Enabled = true,
			OnlyMobile = false,
			Scale = 0.75,
		}
		local new = ColorSequence.new
		local color3_12 = Color3.fromHex("#856d6d")
		local v50 = v1(Color3.fromHex("#ffffff"))

		t4.Color = new(color3_12, unpack(v50, 1, v50.n))
		t3.OpenButton = t4
		v51 = v12:CreateWindow(t3)
	end

	do
		local v52 = v1(UDim2.fromOffset(40, 40))

		v51:SetIconSize(unpack(v52, 1, v52.n))
		task.wait(0.1)
		pcall(function()
			local v581 = game:GetService("CoreGui").RobloxGui.WindUI.Window:GetChildren()[2]

			if v581 then
				local v582 = v581.Frame and v581.Frame:FindFirstChild("Drag")

				if v582 then
					v582:Destroy()
				end

				local v583 = v581.Frame and v581.Frame:FindFirstChild("Frame")

				if v583 then
					v583:Destroy()
				end

				local v584 = v581.Frame and (v581.Frame.TextButton and (v581.Frame.TextButton.Frame and v581.Frame.TextButton.Frame.ImageLabel))

				if v584 then
					v584.Size = UDim2.new(0, 35, 0, 35)
					v584.AnchorPoint = Vector2.new(0.125, 0.2)
				end

				return
			end
		end)
		t5 = {
			Information = v51:Tab({
				Title = "Information",
				Icon = "star",
			}),
			Utilities = v51:Tab({
				Title = "Utilities",
				Icon = "wrench",
			}),
			Visuals = v51:Tab({
				Title = "Visuals",
				Icon = "eye",
			}),
			Aimbot = v51:Tab({
				Title = "Aimbot",
				Icon = "crosshair",
			}),
			Gunmods = v51:Tab({
				Title = "Gun Mods",
				Icon = "zap",
			}),
			Settings = v51:Tab({
				Title = "Settings",
				Icon = "settings",
			}),
		}
		v51:Divider()
		v51:SelectTab(1)

		local t6 = {}
		local color3_13 = Color3.fromHex("#856d6d")
		local v172 = v1(Color3.fromHex("#ffffff"))

		t6.Title = v23("FPS: 0", color3_13, unpack(v172, 1, v172.n))
		t6.Color = Color3.fromRGB(80, 60, 60)

		local v173 = v51:Tag(t6)
		local timestamp = tick()
		local n1 = 0

		local RenderStepped = RunService.RenderStepped
		local u177 = v173
		local u178 = v23

		RenderStepped:Connect(function()
			n1 = n1 + 1

			local timestamp2 = tick()

			if timestamp2 - timestamp >= 1 then
				local v586 = n1 / (timestamp2 - timestamp)
				local v587 = math.floor(v586)

				if not (v587 >= 50) then
					if not (v587 >= 30) then
						u177:SetTitle((u178("FPS: " .. v587, Color3.fromHex("#ff4444"), Color3.fromHex("#ff9999"))))
					else
						u177:SetTitle((u178("FPS: " .. v587, Color3.fromHex("#ffdd00"), Color3.fromHex("#ffaa00"))))
					end
				else
					u177:SetTitle((u178("FPS: " .. v587, Color3.fromHex("#00ff88"), Color3.fromHex("#00e1ff"))))
				end

				n1 = 0
				timestamp = timestamp2
			end
		end)
	end

	local t7 = {}
	local color3_14 = Color3.fromHex("#856d6d")
	local v181 = v1(Color3.fromHex("#ffffff"))

	t7.Title = v23("Ping: 0ms", color3_14, unpack(v181, 1, v181.n))
	t7.Color = Color3.fromRGB(80, 60, 60)

	local v182 = v51:Tag(t7)
	local spawn = task.spawn
	local u184 = v182
	local u185 = v23

	spawn(function()
		while true do
			local ok, result = pcall(function()
				local Value = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()

				return (math.floor(Value))
			end)

			if ok and result then
				if not (result <= 50) then
					if not (result <= 100) then
						if not (result <= 200) then
							u184:SetTitle((u185("Ping: " .. result .. "ms", Color3.fromHex("#ff4444"), Color3.fromHex("#ff9999"))))
						else
							u184:SetTitle((u185("Ping: " .. result .. "ms", Color3.fromHex("#ff8800"), Color3.fromHex("#ff4400"))))
						end
					else
						u184:SetTitle((u185("Ping: " .. result .. "ms", Color3.fromHex("#ffdd00"), Color3.fromHex("#ffaa00"))))
					end
				else
					u184:SetTitle((u185("Ping: " .. result .. "ms", Color3.fromHex("#00ff88"), Color3.fromHex("#00e1ff"))))
				end
			end

			task.wait(2)
		end
	end)

	local v186

	if not identifyexecutor then
		if not getexecutorname then
			v186 = DELTA_LOADED and "Delta" or (fluxus and "Fluxus" or "Unknown")
		else
			v186 = getexecutorname()
		end
	else
		v186 = identifyexecutor()
	end

	local t8 = {
		"Potassium",
		"Delta",
		"Synapse Z",
		"Fluxus",
		"Codex",
		"Hydrogen",
		"Solara",
		"Wave",
		"Xeno",
		"Velocity",
		"Ronix",
		"Luna",
		"Volt",
		"LX63",
		"MacSploit",
		"OpiumWare",
		"Vega X",
		"Volcano",
		"Cryptic",
		"Yub-X",
		"Madium",
	}

	for _, v in ipairs(t8) do
		local v190 = v186:lower()
		local v191 = v1(v:lower())

		if v190:find(unpack(v191, 1, v191.n)) then
			break
		end
	end

	local t9 = {}
	local color3_15 = Color3.fromHex("#856d6d")
	local v296 = v1(Color3.fromHex("#ffffff"))

	t9.Title = v23(v186, color3_15, unpack(v296, 1, v296.n))
	t9.Color = Color3.fromRGB(80, 60, 60)
	v51:Tag(t9)

	if setfpscap then
		setfpscap(0)
	end
	local u298 = LocalPlayer
	local u299 = Players

	local function v300()
		if u298.Team ~= nil then
			for _, player in ipairs(u299:GetPlayers()) do
				if player ~= u298 and player.Team ~= u298.Team then
					return false
				end
			end

			return true
		end

		return true
	end

	u301 = false
	u302 = v12
	t10 = {
		box = false,
		tracer = false,
		name = false,
		health = false,
		distance = false,
		highlight = false,
	}

	local t11 = {
		box = {},
		tracer = {},
		nameLbl = {},
		healthBg = {},
		healthBar = {},
		healthPct = {},
		distance = {},
	}

	n2 = 1000
	u306 = nil
	u307 = true

	local color3_16 = Color3.fromRGB(255, 255, 255)
	local color3_17 = Color3.fromRGB(255, 255, 255)

	u310 = false
	n3 = 100
	s2 = "Head"
	n4 = 0
	u314 = true
	u315 = nil
	u316 = nil
	u317 = false
	u318 = false
	u319 = nil
	u320 = nil
	color3 = Color3.fromRGB(160, 89, 255)
	local u322 = nil
	u323 = false
	u324 = nil
	u325 = false
	local u326 = false
	local u327 = false
	local u328 = nil
	local n5 = 50
	u330 = false
	u331 = true
	n6 = 10

	local t12 = {}

	t13 = {}
	u335 = false
	t14 = {}
	u337 = false
	t15 = {}
	u339 = false
	t16 = {}
	u341 = false
	t17 = {}

	local t18 = {
		norecoil = {},
		rapidfire = {},
		nospread = {},
		allauto = {},
	}

	u344 = nil

	local u345 = t11

	function u346(p4)
		if u345.box[p4] then
			local v627 = u345.box[p4]

			for _, v in ipairs(v627) do
				v.Visible = false
			end

			for _, v in ipairs(u345.box[p4]) do
				v:Remove()
			end

			u345.box[p4] = nil
		end

		for k, v in pairs(u345) do
			if k ~= "box" and v[p4] then
				local v634 = v[p4]

				if type(v634) ~= "table" then
					local _pcall = pcall
					local u636 = v
					local u637 = p4

					pcall(function()
						u636[u637]:Remove()
					end)
				else
					for _, v2 in ipairs(v[p4]) do
						local _pcall = pcall
						local u641 = v2

						pcall(function()
							u641:Remove()
						end)
					end
				end

				v[p4] = nil
			end
		end

		if p4.Character then
			local EthosHighlight = p4.Character:FindFirstChild("EthosHighlight")

			if EthosHighlight then
				EthosHighlight:Destroy()
			end
		end
	end

	local u347 = CurrentCamera
	local u348 = v300
	local u349 = Players
	local u350 = LocalPlayer
	local u351 = t10
	local u352 = t11

	local function u353()
		local t19 = {}

		for i = 1, 8 do
			local drawing = Drawing.new("Line")

			drawing.Thickness = 2.5
			drawing.Transparency = 1
			drawing.Visible = false
			drawing.ZIndex = 5
			t19[i] = drawing
		end

		return t19
	end
	local function u354(p5, p6, p7, p8, p9, p10)
		local v612 = p8 * 0.18
		local v613 = p9 * 0.18

		p5[1].From = Vector2.new(p6, p7)
		p5[1].To = Vector2.new(p6 + v612, p7)
		p5[2].From = Vector2.new(p6, p7)
		p5[2].To = Vector2.new(p6, p7 + v613)
		p5[3].From = Vector2.new(p6 + p8, p7)
		p5[3].To = Vector2.new(p6 + p8 - v612, p7)
		p5[4].From = Vector2.new(p6 + p8, p7)
		p5[4].To = Vector2.new(p6 + p8, p7 + v613)
		p5[5].From = Vector2.new(p6, p7 + p9)
		p5[5].To = Vector2.new(p6 + v612, p7 + p9)
		p5[6].From = Vector2.new(p6, p7 + p9)
		p5[6].To = Vector2.new(p6, p7 + p9 - v613)
		p5[7].From = Vector2.new(p6 + p8, p7 + p9)
		p5[7].To = Vector2.new(p6 + p8 - v612, p7 + p9)
		p5[8].From = Vector2.new(p6 + p8, p7 + p9)
		p5[8].To = Vector2.new(p6 + p8, p7 + p9 - v613)

		for _, v in ipairs(p5) do
			v.Color = p10
			v.Visible = true
		end
	end

	local u355 = color3_16
	local u356 = color3_17

	function v357()
		local n8 = nil
		local g655 = nil
		local g670 = nil
		local g672 = nil
		local n7 = nil

		if not u322 then
			u322 = Drawing.new("Circle")
			u322.Radius = 4
			u322.Filled = true
			u322.Transparency = 1
			u322.Color = Color3.fromRGB(255, 50, 50)
			u322.ZIndex = 10
			u322.Visible = false
		end

		if not u310 or not u316 or not u316.Parent then
			u322.Visible = false
		else
			local v645 = u316 and u316.Character
			local v646 = v645 and v645:FindFirstChild(s2)

			if not v646 then
				u322.Visible = false
			else
				local v647, v648 = u347:WorldToViewportPoint(v646.Position)

				u322.Position = Vector2.new(v647.X, v647.Y)
				u322.Visible = v648
			end
		end

		local v649 = u348()

		for _, player in ipairs(u349:GetPlayers()) do
			if player ~= u350 then
				local v652 = v649 or (not player.Team or (not u350.Team or player.Team ~= u350.Team))

				if not u307 or v652 then
					local v653 = player and player.Character
					local v654 = v653 and v653:FindFirstChild("HumanoidRootPart")

					repeat
						if g655 or not v654 then
							g655 = false
							u346(player)
						else
							local v656 = player and player.Character
							local v657 = v656 and v656:FindFirstChildOfClass("Humanoid")

							if not (v657 and v657.Health > 0) then
								g655 = true
							end

							if not g655 then
								local Magnitude = (u347.CFrame.Position - v654.Position).Magnitude

								if not (Magnitude > n2) then
									local v659, v660 = u347:WorldToViewportPoint(v654.Position)

									if v660 then
										local v661 = u347:WorldToViewportPoint(v654.Position + Vector3.new(0, 3.2, 0))
										local v662 = u347:WorldToViewportPoint(v654.Position - Vector3.new(0, 3, 0))
										local v663 = v661.Y - v662.Y
										local v664 = math.abs(v663)
										local v665 = v664 * 0.55
										local v666 = v659.X - v665 * 0.5
										local Y = v661.Y
										local v668 = player and player.Character
										local v669 = v668 and v668:FindFirstChildOfClass("Humanoid")

										repeat
											if g670 or not v669 then
												g670 = false
												n7 = 0
												g672 = true
											end

											if g672 then
												break
											end

											local v673 = v669.Health / v669.MaxHealth

											n7 = math.clamp(v673, 0, 1)

											if not n7 then
												g670 = true
											end
										until not g670

										g672 = false

										local color3_18 = Color3.fromRGB(255, 255, 255)

										if not u351.box then
											if u352.box[player] then
												local v675 = u352.box[player]

												for _, v in ipairs(v675) do
													v.Visible = false
												end
											end
										else
											if not u352.box[player] then
												u352.box[player] = u353()
											end

											u354(u352.box[player], v666, Y, v665, v664, color3_18)
										end

										if not u351.tracer then
											if u352.tracer[player] then
												u352.tracer[player].Visible = false
											end
										else
											if not u352.tracer[player] then
												local drawing = Drawing.new("Line")

												drawing.Thickness = 2
												drawing.Transparency = 1
												drawing.ZIndex = 3
												u352.tracer[player] = drawing
											end

											local v679 = u352.tracer[player]

											v679.Color = color3_18
											v679.From = Vector2.new(u347.ViewportSize.X * 0.5, u347.ViewportSize.Y)
											v679.To = Vector2.new(v659.X, v659.Y + v664 * 0.5)
											v679.Visible = true
										end

										if not u351.name then
											if u352.nameLbl[player] then
												u352.nameLbl[player].Visible = false
											end

											if u352.healthPct[player] then
												u352.healthPct[player].Visible = false
											end
										else
											if not u352.nameLbl[player] then
												local drawing = Drawing.new("Text")

												drawing.Size = 13
												drawing.Center = true
												drawing.Outline = true
												drawing.OutlineColor = Color3.fromRGB(0, 0, 0)
												drawing.Font = Drawing.Fonts.UI
												drawing.ZIndex = 6
												u352.nameLbl[player] = drawing
											end

											local v681 = u352.nameLbl[player]

											v681.Text = player.DisplayName
											v681.Color = Color3.fromRGB(255, 255, 255)
											v681.Position = Vector2.new(v659.X, Y - 20)
											v681.Visible = true

											if not u352.healthPct[player] then
												local drawing = Drawing.new("Text")

												drawing.Size = 11
												drawing.Center = true
												drawing.Outline = true
												drawing.OutlineColor = Color3.fromRGB(0, 0, 0)
												drawing.Font = Drawing.Fonts.UI
												drawing.ZIndex = 6
												u352.healthPct[player] = drawing
											end

											local v683 = u352.healthPct[player]
											local v686

											if not (n7 > 0.5) then
												local fromRGB = Color3.fromRGB
												local v685 = n7 * 2 * 255

												v686 = fromRGB(255, math.floor(v685), 0)
											else
												local _ = (n7 - 0.5) * 2
												local fromRGB = Color3.fromRGB
												local v689 = n8 * 255

												n8 = 0
												v686 = fromRGB(math.floor(v689), 255, 0)
											end

											v683.Color = v686

											local v690 = n7 * 100

											v683.Text = math.floor(v690) .. "%"
											v683.Position = Vector2.new(v659.X, Y - 8)
											v683.Visible = true
										end

										if not u351.health then
											if u352.healthBg[player] then
												u352.healthBg[player].Visible = false
											end

											if u352.healthBar[player] then
												u352.healthBar[player].Visible = false
											end
										else
											local v691 = v664 * n7
											local v692 = v666 - 6

											if not u352.healthBg[player] then
												local drawing = Drawing.new("Square")

												drawing.Filled = true
												drawing.Transparency = 0.8
												drawing.Color = Color3.fromRGB(10, 10, 10)
												drawing.ZIndex = 4
												u352.healthBg[player] = drawing
											end

											local v694 = u352.healthBg[player]

											v694.Size = Vector2.new(6, v664 + 2)
											v694.Position = Vector2.new(v692 - 1, Y - 1)
											v694.Visible = true

											if not u352.healthBar[player] then
												local drawing = Drawing.new("Square")

												drawing.Filled = true
												drawing.Transparency = 1
												drawing.ZIndex = 5
												u352.healthBar[player] = drawing
											end

											local v696 = u352.healthBar[player]

											v696.Color = Color3.fromHSV(n7 * 0.33, 1, 1)
											v696.Size = Vector2.new(2, v691)

											local new = Vector2.new
											local v698 = v692 + 1

											n8 = v664 - v691
											v696.Position = new(v698, Y + n8)
											v696.Visible = true
										end

										if not u351.distance then
											if u352.distance[player] then
												u352.distance[player].Visible = false
											end
										else
											if not u352.distance[player] then
												local drawing = Drawing.new("Text")

												drawing.Size = 10
												drawing.Center = true
												drawing.Outline = true
												drawing.OutlineColor = Color3.fromRGB(0, 0, 0)
												drawing.Color = Color3.fromRGB(200, 200, 200)
												drawing.Font = Drawing.Fonts.UI
												drawing.ZIndex = 6
												u352.distance[player] = drawing
											end

											local v700 = u352.distance[player]

											v700.Text = string.format("[%dm]", (math.floor(Magnitude)))
											v700.Position = Vector2.new(v659.X, v662.Y + 4)
											v700.Visible = true
										end

										if not u351.highlight then
											if player.Character then
												local EthosHighlight = player.Character:FindFirstChild("EthosHighlight")

												if EthosHighlight then
													EthosHighlight:Destroy()
												end
											end
										else
											local v702 = player.Character and player.Character:FindFirstChild("EthosHighlight")

											if not v702 and player.Character then
												v702 = Instance.new("Highlight")
												v702.Name = "EthosHighlight"
												v702.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
												v702.Parent = player.Character
											end

											if v702 then
												v702.OutlineColor = u355
												v702.FillColor = u356
												v702.FillTransparency = 0.7
												v702.OutlineTransparency = 0
											end
										end
									else
										u346(player)
									end
								else
									u346(player)
								end
							end
						end
					until not g655
				else
					u346(player)
				end
			end
		end

		for _, v in pairs(u352) do
			for k in pairs(v) do
				if type(k) == "userdata" and not k.Parent then
					local v706 = v[k]

					if type(v706) ~= "table" then
						local _pcall = pcall
						local u708 = v
						local u709 = k

						pcall(function()
							u708[u709]:Remove()
						end)
					else
						for _, v3 in ipairs(v[k]) do
							local _pcall = pcall
							local u713 = v3

							pcall(function()
								u713:Remove()
							end)
						end
					end

					v[k] = nil
				end
			end
		end
	end
	local u360 = t10
	local u361 = t11
	local u362 = Players

	function v363()
		for _, v in pairs(u360) do
			if v then
				return
			end
		end

		if u306 then
			u306:Disconnect()
			u306 = nil
		end

		for _, v in pairs(u361) do
			for _, v4 in pairs(v) do
				if type(v4) ~= "table" then
					local _pcall = pcall
					local u721 = v4

					pcall(function()
						u721.Visible = false
					end)
				else
					for _, v5 in ipairs(v4) do
						local _pcall = pcall
						local u725 = v5

						pcall(function()
							u725.Visible = false
						end)
					end
				end
			end
		end

		if u322 then
			u322.Visible = false
		end

		for _, player in ipairs(u362:GetPlayers()) do
			if player.Character then
				local EthosHighlight = player.Character:FindFirstChild("EthosHighlight")

				if EthosHighlight then
					EthosHighlight:Destroy()
				end
			end
		end
	end

	local u364 = UserInputService
	local u365 = v300
	local u366 = Players
	local u367 = LocalPlayer
	local u368 = CurrentCamera

	local function v369()
		local MouseLocation = u364:GetMouseLocation()
		local v730 = u365()
		local v731 = nil
		local n9 = 1e999

		for _, player in ipairs(u366:GetPlayers()) do
			if player ~= u367 then
				local v735 = player and player.Character
				local v736 = v735 and v735:FindFirstChildOfClass("Humanoid")

				if v736 and v736.Health > 0 and (not u314 or v730 or (not player.Team or (not u367.Team or player.Team ~= u367.Team))) then
					local v737 = player and player.Character
					local v738 = v737 and v737:FindFirstChild(s2)

					if v738 then
						local v739, v740 = u368:WorldToViewportPoint(v738.Position)

						if v740 then
							local Magnitude = (Vector2.new(v739.X, v739.Y) - MouseLocation).Magnitude

							if Magnitude < n3 and Magnitude < n9 then
								n9 = Magnitude
								v731 = player
							end
						end
					end
				end
			end
		end

		return v731
	end

	local u370 = v369
	local u371 = CurrentCamera

	function v372()
		local v742 = u370()

		u316 = v742

		if v742 then
			local v743 = v742 and v742.Character
			local v744 = v743 and v743:FindFirstChild(s2)

			if v744 then
				if not (n4 <= 0) then
					local cFrame = CFrame.new(u371.CFrame.Position, v744.Position)
					local v746 = 1 / (n4 + 1)
					local v747 = math.clamp(v746, 0.01, 1)

					u371.CFrame = u371.CFrame:Lerp(cFrame, v747)

					return
				end

				u371.CFrame = CFrame.new(u371.CFrame.Position, v744.Position)

				return
			end

			return
		end
	end
	local u379 = LocalPlayer
	local u380 = RunService
	local u381 = CurrentCamera
	local u382 = UserInputService

	function u383()
		if not u328 then
			local v752 = u379 and u379.Character
			local v753 = v752 and v752:FindFirstChild("HumanoidRootPart")

			if v753 then
				local BodyVelocity = Instance.new("BodyVelocity")

				BodyVelocity.MaxForce = Vector3.new(1000000000, 1000000000, 1000000000)
				BodyVelocity.Velocity = Vector3.zero
				BodyVelocity.Parent = v753

				local Heartbeat = u380.Heartbeat
				local u756 = BodyVelocity

				u328 = Heartbeat:Connect(function()
					if u327 then
						local CFrame2 = u381.CFrame
						local zero = Vector3.zero

						if u382:IsKeyDown(Enum.KeyCode.W) then
							zero = zero + CFrame2.LookVector
						end

						if u382:IsKeyDown(Enum.KeyCode.S) then
							zero = zero - CFrame2.LookVector
						end

						if u382:IsKeyDown(Enum.KeyCode.A) then
							zero = zero - CFrame2.RightVector
						end

						if u382:IsKeyDown(Enum.KeyCode.D) then
							zero = zero + CFrame2.RightVector
						end

						if u382:IsKeyDown(Enum.KeyCode.Space) then
							zero = zero + Vector3.new(0, 1, 0)
						end

						if u382:IsKeyDown(Enum.KeyCode.LeftShift) then
							zero = zero - Vector3.new(0, 1, 0)
						end

						u756.Velocity = zero.Magnitude > 0 and zero.Unit * n5 or Vector3.zero

						return
					end

					u756:Destroy()

					local v911 = u328

					u328 = nil
					v911:Disconnect()
				end)

				return
			end

			return
		end
	end
	local u386 = v300
	local u387 = LocalPlayer
	local u388 = t13

	function v389(p11)
		if not u331 or (u386() or (not p11.Team or (not u387.Team or p11.Team ~= u387.Team))) then
			local v760 = p11 and p11.Character

			if v760 then
				if not u388[p11] then
					u388[p11] = {}
				end

				for _, v in ipairs({
					"HumanoidRootPart",
					"UpperTorso",
					"LowerTorso",
				}) do
					local v6 = v760:FindFirstChild(v)

					if v6 and not u388[p11][v] then
						u388[p11][v] = {
							Size = v6.Size,
							Transparency = v6.Transparency,
							CanCollide = v6.CanCollide,
						}
						v6.Size = Vector3.new(n6, n6, n6)
						v6.Transparency = 0
						v6.CanCollide = true
					end
				end

				return
			end

			return
		end
	end

	local u390 = t13

	function v391(p12)
		local v765 = p12 and p12.Character
		local v766 = u390[p12]

		if v765 and v766 then
			for _, v in ipairs({
				"HumanoidRootPart",
				"UpperTorso",
				"LowerTorso",
			}) do
				local v7 = v765:FindFirstChild(v)

				if v7 and v766[v] then
					v7.Size = v766[v].Size
					v7.Transparency = v766[v].Transparency
					v7.CanCollide = v766[v].CanCollide
				end
			end

			u390[p12] = nil

			return
		end
	end

	local u392 = Players
	local u393 = LocalPlayer
	local u394 = v389
	local u395 = t12
	local u396 = RunService
	local u397 = v300
	local u398 = v391

	function u399()
		for _, player in ipairs(u392:GetPlayers()) do
			if player ~= u393 then
				pcall(u394, player)
			end
			local CharacterAdded = player.CharacterAdded
			local u774 = player

			u395[player] = CharacterAdded:Connect(function()
				task.wait(0.5)

				if u330 then
					pcall(u394, u774)
				end
			end)
		end

		u395._added = u392.PlayerAdded:Connect(function(player)
			local CharacterAdded = player.CharacterAdded
			local u915 = player

			u395[player] = CharacterAdded:Connect(function()
				task.wait(0.5)

				if u330 then
					pcall(u394, u915)
				end
			end)
		end)
		u395._loop = u396.Heartbeat:Connect(function()
			if u330 then
				for _, player in ipairs(u392:GetPlayers()) do
					if player ~= u393 then
						if not u331 or u397() or (not player.Team or (not u393.Team or player.Team ~= u393.Team)) then
							pcall(u394, player)
						else
							pcall(u398, player)
						end
					end
				end

				return
			end

			u395._loop:Disconnect()
			u395._loop = nil
		end)
	end

	local u400 = t12
	local u401 = Players
	local u402 = LocalPlayer
	local u403 = v391
	local u404 = t13

	function u405()
		for k, v in pairs(u400) do
			if typeof(v) == "RBXScriptConnection" then
				v:Disconnect()
			end

			u400[k] = nil
		end

		for _, player in ipairs(u401:GetPlayers()) do
			if player ~= u402 then
				pcall(u403, player)
			end
		end

		table.clear(u404)
	end

	local u406 = t18

	function v407(p13, p14, p15, p16, p17)
		local function v784(...)
			local t20 = { ... }

			t20.n = select("#", ...)

			return t20
		end

		for _, v in ipairs(u406[p13]) do
			v:Disconnect()
		end

		table.clear(u406[p13])

		local Weapons = game:GetService("ReplicatedStorage"):FindFirstChild("Weapons")

		if Weapons then
			local u788 = p14
			local u789 = p15
			local u790 = p17
			local u791 = p16
			local u792 = p13

			local function u793(p18)
				if p18.Name == u788 and p18:IsA(u789) then
					if u790[p18] == nil then
						u790[p18] = p18.Value
					end

					p18.Value = u791

					local v920 = u406[u792]
					local Changed = p18.Changed
					local u922 = p18
					local v923 = (function(...)
						local t21 = { ... }

						t21.n = select("#", ...)

						return t21
					end)(Changed:Connect(function(p19)
						if p19 ~= u791 then
							u922.Value = u791
						end
					end))

					table.insert(v920, unpack(v923, 1, v923.n))
				end
			end

			local _ipairs = ipairs
			local v795 = v784(Weapons:GetDescendants())

			for _, v797 in _ipairs(unpack(v795, 1, v795.n)) do
				u793(v797)
			end

			local v798 = u406[p13]
			local v799 = v784(Weapons.DescendantAdded:Connect(function(descendant)
				task.wait()
				u793(descendant)
			end))

			table.insert(v798, unpack(v799, 1, v799.n))

			return
		end
	end

	local u408 = t18

	function v409(p20, p21, p22, p23)
		for _, v in ipairs(u408[p20]) do
			v:Disconnect()
		end

		table.clear(u408[p20])

		local Weapons = game:GetService("ReplicatedStorage"):FindFirstChild("Weapons")

		if Weapons then
			for _, descendant in ipairs(Weapons:GetDescendants()) do
				if p21 == descendant.Name and descendant:IsA(p22) and p23[descendant] ~= nil then
					local _pcall = pcall
					local u815 = descendant
					local u816 = p23

					pcall(function()
						u815.Value = u816[u815]
					end)
				end
			end
		end

		table.clear(p23)
	end
	local InputBegan = UserInputService.InputBegan
	local u427 = v369
	local u428 = LocalPlayer

	InputBegan:Connect(function(p24, p25)
		if not p25 then
			if u310 and u317 and p24.UserInputType == Enum.UserInputType.MouseButton2 then
				if u316 then
				end

				u316 = u427()
			end

			if u326 and p24.KeyCode == Enum.KeyCode.Space then
				local v820 = u428 and u428.Character
				local v821 = v820 and v820:FindFirstChildOfClass("Humanoid")

				if v821 then
					v821:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end

			return
		end
	end)

	local v429 = t5.Information:Section({
		Title = "-——  " .. t2.Update .. "  1.6.5  -  Arsenal",
		Icon = "sparkles",
		Box = true,
		BoxBorder = true,
		Opened = true,
	})

	v429:Paragraph({
		Title = t2.Add .. " Changelog",
		Desc = "[v1.6.5] Aether Hub > Ethos Hub",
	})
	v429:Paragraph({
		Title = t2.Notice .. " Reminder",
		Desc = "Join the Discord to report bugs, suggest features, and stay up to date.",
	})

	local t22 = {
		Title = "Copy Discord Invite",
		Icon = "copy",
	}
	local u431 = v12

	function t22.Callback()
		setclipboard("discord.gg/ZRfJ7kdGDv")

		if u301 then
			u431:Notify({
				Title = "Notification",
				Content = "Discord link copied to clipboard.",
				Icon = "info",
			})

			return
		end
	end

	v429:Button(t22)
	v429:Divider()
	v429:Paragraph({
		Title = "Credits",
		Desc = "Kyoka — " .. t2.Script,
	})

	local v432 = t5.Utilities:Section({
		Title = "Main Player",
		Icon = "user-round",
		Box = true,
		BoxBorder = true,
		Opened = true,
	})
	local t23 = {
		Title = "Infinite Jump",
		Flag = "infinite_jump",
		Default = false,
	}
	local u434 = v12

	function t23.Callback(p26)
		u326 = p26

		local v823 = p26 and "Enabled." or "Disabled."

		if u301 then
			u434:Notify({
				Title = "Infinite Jump",
				Content = v823,
				Icon = "info",
			})

			return
		end
	end

	v432:Toggle(t23)
	v432:Divider()

	local t24 = {
		Title = "Fly",
		Desc = "WASD to move, Space/Shift to ascend/descend",
		Flag = "fly_enabled",
		Default = false,
	}
	local u436 = v12

	function t24.Callback(p27)
		u327 = p27

		if p27 then
			u383()
		end

		local v825 = p27 and "Enabled." or "Disabled."

		if u301 then
			u436:Notify({
				Title = "Fly",
				Content = v825,
				Icon = "info",
			})

			return
		end
	end

	v432:Toggle(t24)
	v432:Slider({
		Title = "Fly Speed",
		Flag = "fly_speed",
		Value = {
			Min = 10,
			Max = 500,
			Default = 50,
		},
		Callback = function(p28)
			n5 = p28
		end,
	})
	v432:Divider()

	local t25 = {
		Title = "Rejoin Server",
		Icon = "log-in",
	}
	local u438 = TeleportService
	local u439 = LocalPlayer

	function t25.Callback()
		pcall(function()
			u438:Teleport(game.PlaceId, u439)
		end)
	end

	v432:Button(t25)
end

t5.Utilities:Space()

local v440 = t5.Utilities:Section({
	Title = "Performance",
	Icon = "gauge",
	Box = true,
	BoxBorder = true,
	Opened = true,
})
local t26 = {
	Title = "Disable Shadows",
	Flag = "perf_shadows",
	Default = false,
}
local u442 = v12

function t26.Callback(p29)
	game:GetService("Lighting").GlobalShadows = not p29

	local v828 = p29 and "Disabled." or "Enabled."

	if u301 then
		u442:Notify({
			Title = "Shadows",
			Content = v828,
			Icon = "info",
		})

		return
	end
end

v440:Toggle(t26)

local t27 = {
	Title = "Fast Mode",
	Desc = "Disables particles, decals, and reflections",
	Flag = "perf_fastmode",
	Default = false,
}
local t28 = {}
local u445 = v12

function t27.Callback(p30)
	local function v830(p31)
		if not p31:IsA("ParticleEmitter") and not p31:IsA("Trail") and not p31:IsA("Smoke") and not p31:IsA("Fire") and not p31:IsA("Sparkles") then
			if not p31:IsA("Decal") and not p31:IsA("Texture") then
				if p31:IsA("BasePart") then
					t28[p31] = {
						CastShadow = p31.CastShadow,
						Material = p31.Material,
						Reflectance = p31.Reflectance,
					}
					p31.CastShadow = false
					p31.Material = Enum.Material.SmoothPlastic
					p31.Reflectance = 0
				end

				return
			end

			t28[p31] = {
				Transparency = p31.Transparency,
			}
			p31.Transparency = 1

			return
		end

		t28[p31] = {
			Enabled = p31.Enabled,
		}
		p31.Enabled = false
	end

	if not p30 then
		if u344 then
			u344:Disconnect()
			u344 = nil
		end

		for _, descendant in ipairs(workspace:GetDescendants()) do
			pcall(function(p32)
				local v930 = t28[p32]

				if v930 then
					local u932 = v930
					local u933 = p32

					pcall(function()
						if u932.Enabled ~= nil then
							u933.Enabled = u932.Enabled
						end

						if u932.Transparency ~= nil then
							u933.Transparency = u932.Transparency
						end

						if u932.Material ~= nil then
							u933.Material = u932.Material
						end

						if u932.CastShadow ~= nil then
							u933.CastShadow = u932.CastShadow
						end

						if u932.Reflectance ~= nil then
							u933.Reflectance = u932.Reflectance
						end
					end)
					t28[p32] = nil

					return
				end
			end, descendant)
		end

		table.clear(t28)
		game:GetService("Lighting").GlobalShadows = true
		game:GetService("Lighting").FogEnd = 100000

		if u301 then
			u445:Notify({
				Title = "Fast Mode",
				Content = "Disabled.",
				Icon = "info",
			})

			return
		end

		return
	end

	table.clear(t28)

	for _, descendant in ipairs(workspace:GetDescendants()) do
		pcall(v830, descendant)
	end

	local DescendantAdded = workspace.DescendantAdded
	local u836 = v830

	u344 = DescendantAdded:Connect(function(p33)
		task.wait()
		pcall(u836, p33)
	end)
	game:GetService("Lighting").GlobalShadows = false
	game:GetService("Lighting").FogEnd = 9999

	if u301 then
		u445:Notify({
			Title = "Fast Mode",
			Content = "Enabled.",
			Icon = "info",
		})

		return
	end
end

v440:Toggle(t27)

local v446 = t5.Visuals:Section({
	Title = "Visual Settings",
	Icon = "sliders-horizontal",
	Box = true,
	BoxBorder = true,
	Opened = true,
})

v446:Toggle({
	Title = "Team Check",
	Desc = "Only show enemies",
	Flag = "esp_teamcheck",
	Default = true,
	Callback = function(p34)
		u307 = p34
	end,
})
v446:Slider({
	Title = "Max Distance",
	Flag = "esp_maxdist",
	Value = {
		Min = 100,
		Max = 3000,
		Default = 1000,
	},
	Callback = function(p35)
		n2 = p35
	end,
})
v446:Divider()

local t29 = {
	Title = "Toggle All ESP",
	Icon = "layers",
}
local u448 = t10
local u449 = RunService
local u450 = v357
local u451 = v363
local u452 = v12

function t29.Callback()
	local v839 = false

	for _, v in pairs(u448) do
		if v then
			v839 = true

			break
		end
	end

	local v842 = not v839

	for k in pairs(u448) do
		u448[k] = v842
	end

	if not v842 then
		u451()
	elseif not u306 then
		u306 = u449.RenderStepped:Connect(u450)
	end

	local v844 = v842 and "All enabled." or "All disabled."

	if u301 then
		u452:Notify({
			Title = "ESP",
			Content = v844,
			Icon = "info",
		})

		return
	end
end

v446:Button(t29)
t5.Visuals:Space()

local v453 = t5.Visuals:Section({
	Title = "Visual Toggles",
	Icon = "eye",
	Box = true,
	BoxBorder = true,
	Opened = true,
})
local t30 = {
	Title = "Corner Box",
	Flag = "esp_box",
	Default = false,
}
local u455 = t10
local u456 = RunService
local u457 = v357
local u458 = v363

function t30.Callback(p36)
	u455.box = p36

	if not p36 then
		u458()

		return
	end

	if not u306 then
		u306 = u456.RenderStepped:Connect(u457)

		return
	end
end

v453:Toggle(t30)

local t31 = {
	Title = "Tracer Lines",
	Flag = "esp_tracer",
	Default = false,
}
local u460 = t10
local u461 = RunService
local u462 = v357
local u463 = v363

function t31.Callback(p37)
	u460.tracer = p37

	if not p37 then
		u463()

		return
	end

	if not u306 then
		u306 = u461.RenderStepped:Connect(u462)

		return
	end
end

v453:Toggle(t31)

local t32 = {
	Title = "Name & Health %",
	Flag = "esp_name",
	Default = false,
}
local u465 = t10
local u466 = RunService
local u467 = v357
local u468 = v363

function t32.Callback(p38)
	u465.name = p38

	if not p38 then
		u468()

		return
	end

	if not u306 then
		u306 = u466.RenderStepped:Connect(u467)

		return
	end
end

v453:Toggle(t32)

local t33 = {
	Title = "Health Bar",
	Flag = "esp_health",
	Default = false,
}
local u470 = t10
local u471 = RunService
local u472 = v357
local u473 = v363

function t33.Callback(p39)
	u470.health = p39

	if not p39 then
		u473()

		return
	end

	if not u306 then
		u306 = u471.RenderStepped:Connect(u472)

		return
	end
end

v453:Toggle(t33)

local t34 = {
	Title = "Distance",
	Flag = "esp_distance",
	Default = false,
}
local u475 = t10
local u476 = RunService
local u477 = v357
local u478 = v363

function t34.Callback(p40)
	u475.distance = p40

	if not p40 then
		u478()

		return
	end

	if not u306 then
		u306 = u476.RenderStepped:Connect(u477)

		return
	end
end

v453:Toggle(t34)

local t35 = {
	Title = "Highlights",
	Flag = "esp_highlight",
	Default = false,
}
local u480 = t10
local u481 = RunService
local u482 = v357
local u483 = v363

function t35.Callback(p41)
	u480.highlight = p41

	if not p41 then
		u483()

		return
	end

	if not u306 then
		u306 = u481.RenderStepped:Connect(u482)

		return
	end
end

v453:Toggle(t35)

local v484 = t5.Aimbot:Section({
	Title = "Aimbot",
	Icon = "crosshair",
	Box = true,
	BoxBorder = true,
	Opened = true,
})

v484:Toggle({
	Title = "Team Check",
	Flag = "aim_teamcheck",
	Default = true,
	Callback = function(p42)
		u314 = p42
	end,
})
v484:Divider()

local t36 = {
	Title = "Aimbot Mode",
	Flag = "aim_mode",
	Values = {
		"None Selected",
		"Hold RMB",
		"Toggle",
	},
	Value = "None Selected",
}
local u486 = RunService
local u487 = v372
local u488 = UserInputService
local u489 = v12

function t36.Callback(p43)
	u310 = p43 ~= "None Selected"
	u317 = p43 == "Toggle"

	if not u310 then
		if u315 then
			u315:Disconnect()
			u315 = nil
		end

		u316 = nil
	else
		if u315 then
			u315:Disconnect()
			u315 = nil
		end

		u315 = u486.RenderStepped:Connect(function()
			if u310 then
				if not u317 then
					if u488:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
						u487()

						return
					end

					u316 = nil
				elseif u316 then
					u487()

					return
				end

				return
			end
		end)
	end

	local v853 = p43 == "None Selected" and "Disabled." or p43 .. " enabled."

	if u301 then
		u489:Notify({
			Title = "Aimbot",
			Content = v853,
			Icon = "info",
		})

		return
	end
end

v484:Dropdown(t36)
v484:Dropdown({
	Title = "Aim Part",
	Flag = "aim_part",
	Values = {
		"Head",
		"HumanoidRootPart",
		"UpperTorso",
		"LowerTorso",
	},
	Value = "Head",
	Callback = function(p44)
		s2 = p44
	end,
})
v484:Slider({
	Title = "Smoothing",
	Flag = "aim_smoothing",
	Value = {
		Min = 0,
		Max = 20,
		Default = 0,
	},
	Callback = function(p45)
		n4 = p45
	end,
})

local t37 = {
	Title = "Trigger Bot",
	Desc = "Auto-fires when crosshair is on an enemy",
	Flag = "aim_triggerbot",
	Default = false,
}
local u491 = LocalPlayer
local u492 = RunService
local u493 = Players
local u494 = v12

function t37.Callback(p46)
	u323 = p46

	if p46 and not u324 then
		local Mouse = u491:GetMouse()
		local RenderStepped = u492.RenderStepped
		local u859 = Mouse

		u324 = RenderStepped:Connect(function()
			if u323 then
				local Target = u859.Target

				if Target and Target.Parent and Target.Parent:FindFirstChild("Humanoid") then
					local player = u493:GetPlayerFromCharacter(Target.Parent)

					if player and player ~= u491 then
						local v937 = player and player.Character
						local v938 = v937 and v937:FindFirstChildOfClass("Humanoid")

						if v938 and v938.Health > 0 then
							if not u325 then
								u325 = true
								mouse1press()
							end

							return
						end
					end
				end

				if u325 then
					mouse1release()
					u325 = false
				end

				return
			end

			if u325 then
				mouse1release()
				u325 = false
			end

			local v939 = u324

			u324 = nil
			v939:Disconnect()
		end)
	end

	local v860 = p46 and "Enabled." or "Disabled."

	if u301 then
		u494:Notify({
			Title = "Trigger Bot",
			Content = v860,
			Icon = "info",
		})

		return
	end
end

v484:Toggle(t37)
t5.Aimbot:Space()

local v495 = t5.Aimbot:Section({
	Title = "FOV Circle",
	Icon = "circle",
	Box = true,
	BoxBorder = true,
	Opened = true,
})
local t38 = {
	Title = "Show FOV Circle",
	Flag = "fov_circle",
	Default = false,
}
local u497 = RunService
local u498 = UserInputService

function t38.Callback(p47)
	u318 = p47

	if not p47 then
		if u319 then
			u319.Visible = false
		end

		if u320 then
			u320:Disconnect()
			u320 = nil
		end
	elseif not u320 then
		u320 = u497.RenderStepped:Connect(function()
			if not u319 then
				u319 = Drawing.new("Circle")
				u319.Thickness = 2.5
				u319.Filled = false
				u319.Transparency = 1
				u319.ZIndex = 2
			end

			local MouseLocation = u498:GetMouseLocation()

			u319.Position = Vector2.new(MouseLocation.X, MouseLocation.Y)
			u319.Radius = n3
			u319.Color = color3
			u319.Visible = u318
		end)

		return
	end
end

v495:Toggle(t38)
v495:Slider({
	Title = "FOV Size",
	Flag = "fov_size",
	Value = {
		Min = 30,
		Max = 600,
		Default = 100,
	},
	Callback = function(p48)
		n3 = p48

		if u319 then
			u319.Radius = p48
		end
	end,
})
v495:Dropdown({
	Title = "FOV Color",
	Flag = "fov_color",
	Values = {
		"White",
		"Red",
		"Green",
		"Blue",
		"Yellow",
		"Purple",
	},
	Value = "Purple",
	Callback = function(p49)
		color3 = ({
			White = Color3.fromRGB(255, 255, 255),
			Red = Color3.fromRGB(255, 60, 60),
			Green = Color3.fromRGB(60, 255, 100),
			Blue = Color3.fromRGB(60, 140, 255),
			Yellow = Color3.fromRGB(255, 230, 60),
			Purple = Color3.fromRGB(160, 89, 255),
		})[p49] or Color3.fromRGB(160, 89, 255)

		if u319 then
			u319.Color = color3
		end
	end,
})
t5.Aimbot:Space()

local v499 = t5.Aimbot:Section({
	Title = "Hitbox Extender",
	Icon = "box",
	Box = true,
	BoxBorder = true,
	Opened = true,
})

v499:Toggle({
	Title = "Team Check",
	Flag = "hitbox_teamcheck",
	Default = true,
	Callback = function(p50)
		u331 = p50
	end,
})
v499:Divider()

local t39 = {
	Title = "Enable Hitbox Extender",
	Flag = "hitbox_enabled",
	Default = false,
}
local u501 = v12

function t39.Callback(p51)
	u330 = p51

	if not p51 then
		u405()
	else
		u399()
	end

	local v866 = p51 and "Enabled." or "Disabled."

	if u301 then
		u501:Notify({
			Title = "Hitbox Extender",
			Content = v866,
			Icon = "info",
		})

		return
	end
end

v499:Toggle(t39)

local t40 = {
	Title = "Hitbox Size",
	Flag = "hitbox_size",
	Value = {
		Min = 1,
		Max = 16,
		Default = 10,
	},
}
local u503 = Players
local u504 = LocalPlayer
local u505 = t13
local u506 = v391
local u507 = v389

function t40.Callback(p52)
	n6 = p52

	if u330 then
		for _, player in ipairs(u503:GetPlayers()) do
			if player ~= u504 and u505[player] then
				pcall(u506, player)
				pcall(u507, player)
			end
		end
	end
end

v499:Slider(t40)

local v508 = t5.Gunmods:Section({
	Title = t2.Warning .. " | Don't get clipped",
	Icon = "zap",
	Box = true,
	BoxBorder = true,
	Opened = true,
})
local t41 = {
	Title = "No Recoil",
	Flag = "no_recoil",
	Default = false,
}
local u510 = v407
local u511 = t16
local u512 = v409
local u513 = v12

function t41.Callback(p53)
	u339 = p53

	if not p53 then
		u512("norecoil", "Recoil", "NumberValue", u511)
	else
		u510("norecoil", "Recoil", "NumberValue", 0, u511)
	end

	local v871 = p53 and "Enabled." or "Disabled."

	if u301 then
		u513:Notify({
			Title = "No Recoil",
			Content = v871,
			Icon = "info",
		})

		return
	end
end

v508:Toggle(t41)

local t42 = {
	Title = "No Spread",
	Flag = "no_spread",
	Default = false,
}
local u515 = v407
local u516 = t17
local u517 = v409
local u518 = v12

function t42.Callback(p54)
	u341 = p54

	if not p54 then
		u517("nospread", "Spread", "NumberValue", u516)
	else
		u515("nospread", "Spread", "NumberValue", 0, u516)
	end

	local v873 = p54 and "Enabled." or "Disabled."

	if u301 then
		u518:Notify({
			Title = "No Spread",
			Content = v873,
			Icon = "info",
		})

		return
	end
end

v508:Toggle(t42)

local t43 = {
	Title = "Rapid Fire",
	Flag = "rapid_fire",
	Default = false,
}
local u520 = v407
local u521 = t14
local u522 = v409
local u523 = v12

function t43.Callback(p55)
	u335 = p55

	if not p55 then
		u522("rapidfire", "FireRate", "NumberValue", u521)
	else
		u520("rapidfire", "FireRate", "NumberValue", 0.02, u521)
	end

	local v875 = p55 and "Enabled." or "Disabled."

	if u301 then
		u523:Notify({
			Title = "Rapid Fire",
			Content = v875,
			Icon = "info",
		})

		return
	end
end

v508:Toggle(t43)

local t44 = {
	Title = "Always Auto",
	Flag = "all_auto",
	Default = false,
}
local u525 = v407
local u526 = t15
local u527 = v409
local u528 = v12

function t44.Callback(p56)
	u337 = p56

	if not p56 then
		u527("allauto", "Auto", "BoolValue", u526)
	else
		u525("allauto", "Auto", "BoolValue", true, u526)
	end

	local v877 = p56 and "Enabled." or "Disabled."

	if u301 then
		u528:Notify({
			Title = "Always Auto",
			Content = v877,
			Icon = "info",
		})

		return
	end
end

v508:Toggle(t44)
v508:Toggle({
	Title = "Infinite Ammo",
	Flag = "infinite_ammo",
	Locked = true,
	Default = false,
	Callback = function(_) end,
})

local s3 = "default"
local s4
local s5 = "None"
local u532 = v51.ConfigManager:Config("default")
local _pcall = pcall
local u534 = v51

pcall(function()
	local v879 = u534.ConfigManager:Config("_meta")

	v879:Load()

	local v880 = v879:Get("autoload")

	if v880 and v880 ~= "" then
		s5 = v880
	end
end)

local v535 = t5.Settings:Section({
	Title = "Config Manager",
	Icon = "folder",
	Box = true,
	BoxBorder = true,
	Opened = true,
})
local t45 = {
	Title = "Config List",
	Values = v51.ConfigManager:AllConfigs(),
	Value = "default",
}
local u537 = v51

function t45.Callback(p58)
	s3 = p58
	u532 = u537.ConfigManager:Config(p58)
end

local v538 = v535:Dropdown(t45)
local t46 = {
	Title = "Config Name",
	Placeholder = "Enter config name...",
}
local u540 = v51

function t46.Callback(p59)
	s3 = p59 ~= "" and p59 or "default"
	u532 = u540.ConfigManager:Config(s3)
end

v535:Input(t46)

local t47 = {
	Title = "Save Config",
	Icon = "save",
}
local u542 = v51
local u543 = v538
local u544 = v12

function t47.Callback()
	u532 = u542.ConfigManager:Config(s3)
	u532:Save()
	local v884 = (function(...)
		local t48 = { ... }

		t48.n = select("#", ...)

		return t48
	end)(u542.ConfigManager:AllConfigs())

	u543:Refresh(unpack(v884, 1, v884.n))

	local v888 = "Saved: " .. s3

	if u301 then
		u544:Notify({
			Title = "Config",
			Content = v888,
			Icon = "info",
		})

		return
	end
end

v535:Button(t47)

local t49 = {
	Title = "Load Config",
	Icon = "folder-open",
}
local u546 = v51
local u547 = v12

function t49.Callback()
	u532 = u546.ConfigManager:Config(s3)
	u532:Load()

	local v889 = "Loaded: " .. s3

	if u301 then
		u547:Notify({
			Title = "Config",
			Content = v889,
			Icon = "info",
		})

		return
	end
end

v535:Button(t49)

local u548 = nil
local t50 = {
	Title = "Delete Config",
	Icon = "trash",
}
local u550 = v51
local u551 = v538
local u552 = v12

function t50.Callback()
	local v890, v891 = u550.ConfigManager:DeleteConfig(s3)

	if not v890 then
		local v892 = v891 or "Failed to delete."

		if u301 then
			u552:Notify({
				Title = "Config",
				Content = v892,
				Icon = "info",
			})

			return
		end

		return
	end

	if s5 == s3 then
		s5 = "None"
		pcall(function()
			local v943 = u550.ConfigManager:Config("_meta")

			v943:Set("autoload", "")
			v943:Save()
		end)
		u548:SetDesc("Current autoload: None")
	end

	s3 = "default"
	u532 = u550.ConfigManager:Config("default")
	local v894 = (function(...)
		local t51 = { ... }

		t51.n = select("#", ...)

		return t51
	end)(u550.ConfigManager:AllConfigs())

	u551:Refresh(unpack(v894, 1, v894.n))

	if u301 then
		u552:Notify({
			Title = "Config",
			Content = "Deleted. Reset to default.",
			Icon = "info",
		})

		return
	end
end

v535:Button(t50)
v535:Divider()

local t52 = {
	Title = "Set as Autoload",
	Icon = "bookmark",
	Desc = "Current autoload: " .. s5,
}
local u554 = v51
local u555 = v12

function t52.Callback()
	s5 = s3
	pcall(function()
		local v944 = u554.ConfigManager:Config("_meta")

		v944:Set("autoload", s5)
		v944:Save()
	end)
	pcall(function()
		u554.ConfigManager:Config(s5):SetAutoLoad()
	end)
	u548:SetDesc("Current autoload: " .. s3)

	local v898 = "Autoload set to: " .. s3

	if u301 then
		u555:Notify({
			Title = "Config",
			Content = v898,
			Icon = "info",
		})

		return
	end
end

u548 = v535:Button(t52)
t5.Settings:Space()

local v556 = t5.Settings:Section({
	Title = "Interface",
	Icon = "monitor",
	Box = true,
	BoxBorder = true,
	Opened = true,
})
local t53 = {
	Title = "Theme",
	Flag = "ui_theme",
	Values = {
		"Dark",
		"Sky",
		"Light",
		"Midnight",
		"Emerald",
		"Crimson",
		"CottonCandy",
	},
	Value = "Dark",
}
local u558 = v12

function t53.Callback(p60)
	s4 = p60
	u558:SetTheme(p60)
end

v556:Dropdown(t53)

local t54 = {
	Title = "Toggle UI",
	Desc = "Press to open/close the UI",
	Value = "U",
}
local u560 = v51

function t54.Callback(p61)
	u560:SetToggleKey(Enum.KeyCode[p61])
end

v556:Keybind(t54)
task.wait(0.5)
local u562 = v51

pcall(function()
	local v901 = u562.ConfigManager:Config("_meta")

	v901:Load()

	local v902 = v901:Get("autoload")

	if v902 and v902 ~= "" then
		s5 = v902
		u548:SetDesc("Current autoload: " .. v902)
		u562.ConfigManager:Config(v902):Load()
	end
end)

if s5 ~= "None" then
	(function(p62, p63)
		if u301 then
			u302:Notify({
				Title = p62,
				Content = p63,
				Icon = "info",
			})

			return
		end
	end)("Config", "Autoloaded: " .. s5)
end

u301 = true
