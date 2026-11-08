-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf
-- this is for blade ball

task.spawn(function()
	repeat
		task.wait(0.2)
	until game:IsLoaded()

	local PlayersService = cloneref(game:GetService("Players"))
	local ReplicatedStorageService = cloneref(game:GetService("ReplicatedStorage"))
	local UserInputService = cloneref(game:GetService("UserInputService"))
	local RunService = cloneref(game:GetService("RunService"))
	local TweenService = cloneref(game:GetService("TweenService"))
	local StatsService = cloneref(game:GetService("Stats"))
	local DebrisService = cloneref(game:GetService("Debris"))
	local CoreGuiService = cloneref(game:GetService("CoreGui"))
	local HttpService = cloneref(game:GetService("HttpService"))
	local WorkspaceService = cloneref(game:GetService("Workspace"))
	local LocalPlayer = PlayersService.LocalPlayer

	if not LocalPlayer then
		PlayersService:GetPropertyChangedSignal("LocalPlayer"):Wait()
		LocalPlayer = PlayersService.LocalPlayer
	end

	local function GetGuiParent()
		local Success, Result = pcall(function()
			return gethui()
		end)
		return Success and Result or CoreGuiService
	end

	local GradientConnections = {}

	local function CreateAnimatedStroke(Parent, Thickness)
		local Stroke = Instance.new("UIStroke")
		Stroke.Thickness = Thickness or 2
		Stroke.Color = Color3.fromRGB(255, 255, 255)
		Stroke.Transparency = 0.1
		Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		Stroke.Parent = Parent
		local Gradient = Instance.new("UIGradient")

		Gradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 60, 255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 60, 255)),
		})

		Gradient.Rotation = 0
		Gradient.Parent = Stroke
		local Connection

		Connection = RunService.RenderStepped:Connect(function(DeltaTime)
			if not Stroke.Parent then
				if Connection then
					Connection:Disconnect()
				end
				return
			end
			Gradient.Rotation = (Gradient.Rotation + DeltaTime * 95) % 360
		end)

		table.insert(GradientConnections, Connection)
		return Stroke, Gradient
	end

	local function IsKeySessionValid()
		local UserId = tostring(LocalPlayer.UserId)
		local Sessions = {}

		pcall(function()
			if isfile and isfile("Aeris/key_session.json") then
				local Decoded = HttpService:JSONDecode(readfile("Aeris/key_session.json"))
				if type(Decoded) == "table" then
					Sessions = Decoded
				end
			end
		end)

		local SessionData = Sessions
		local Session = SessionData[UserId]

		if type(Session) == "table" and Session.key == "bLidikBol" and type(Session.timestamp) == "number" then
			if os.time() - Session.timestamp < 86400 then
				return true
			end

			SessionData[UserId] = nil

			pcall(function()
				if isfolder and makefolder and not isfolder("Aeris") then
					makefolder("Aeris")
				end
				if writefile then
					writefile("Aeris/key_session.json", HttpService:JSONEncode(SessionData or {}))
				end
			end)
		end

		return false
	end

	local function SaveKeySession()
		local UserId = tostring(LocalPlayer.UserId)
		local Sessions = {}

		pcall(function()
			if isfile and isfile("Aeris/key_session.json") then
				local Decoded = HttpService:JSONDecode(readfile("Aeris/key_session.json"))
				if type(Decoded) == "table" then
					Sessions = Decoded
				end
			end
		end)

		local SessionData = Sessions
		SessionData[UserId] = {key = "bLidikBol", timestamp = os.time()}

		pcall(function()
			if isfolder and makefolder and not isfolder("Aeris") then
				makefolder("Aeris")
			end
			if writefile then
				writefile("Aeris/key_session.json", HttpService:JSONEncode(SessionData or {}))
			end
		end)
	end

	local function ShowSplashScreen()
		pcall(function()
			local ExistingSplashScreen = GetGuiParent():FindFirstChild("Aeris_SplashScreen")
			if ExistingSplashScreen then
				ExistingSplashScreen:Destroy()
			end
		end)

		local ScreenGui = Instance.new("ScreenGui")
		ScreenGui.Name = "Aeris_SplashScreen"
		ScreenGui.ResetOnSpawn = false
		ScreenGui.IgnoreGuiInset = true
		ScreenGui.DisplayOrder = 999999
		ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		ScreenGui.Parent = GetGuiParent()
		local WhiteOverlay = Instance.new("Frame")
		WhiteOverlay.Name = "WhiteOverlay"
		WhiteOverlay.Size = UDim2.fromScale(1, 1)
		WhiteOverlay.Position = UDim2.fromScale(0, 0)
		WhiteOverlay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		WhiteOverlay.BackgroundTransparency = 1
		WhiteOverlay.BorderSizePixel = 0
		WhiteOverlay.ZIndex = 10
		WhiteOverlay.Parent = ScreenGui
		local TopShadow = Instance.new("Frame")
		TopShadow.Name = "TopShadow"
		TopShadow.Size = UDim2.new(1, 0, 0, 120)
		TopShadow.Position = UDim2.fromScale(0, 0)
		TopShadow.BackgroundColor3 = Color3.fromRGB(165, 120, 230)
		TopShadow.BackgroundTransparency = 1
		TopShadow.BorderSizePixel = 0
		TopShadow.ZIndex = 11
		TopShadow.Parent = WhiteOverlay
		local ShadowGradient = Instance.new("UIGradient")
		ShadowGradient.Rotation = 90
		ShadowGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(1, 1)})
		ShadowGradient.Parent = TopShadow
		local Container = Instance.new("Frame")
		Container.Size = UDim2.fromOffset(320, 280)
		Container.Position = UDim2.fromScale(0.5, 0.5)
		Container.AnchorPoint = Vector2.new(0.5, 0.5)
		Container.BackgroundTransparency = 1
		Container.ZIndex = 12
		Container.Parent = WhiteOverlay
		local LogoImage = Instance.new("ImageLabel")
		LogoImage.Name = "AerisLogo"
		LogoImage.Size = UDim2.fromOffset(150, 150)
		LogoImage.Position = UDim2.new(0.5, 0, 0, 80)
		LogoImage.AnchorPoint = Vector2.new(0.5, 0.5)
		LogoImage.BackgroundTransparency = 1
		LogoImage.Image = "rbxassetid://94398897297532"
		LogoImage.ImageTransparency = 1
		LogoImage.ScaleType = Enum.ScaleType.Fit
		LogoImage.ZIndex = 13
		LogoImage.Parent = Container
		local TitleLabel = Instance.new("TextLabel")
		TitleLabel.Name = "Title"
		TitleLabel.Size = UDim2.new(1, 0, 0, 48)
		TitleLabel.Position = UDim2.new(0.5, 0, 0, 195)
		TitleLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		TitleLabel.BackgroundTransparency = 1
		TitleLabel.Text = "Aeris."
		TitleLabel.Font = Enum.Font.GothamBlack
		TitleLabel.TextSize = 42
		TitleLabel.TextColor3 = Color3.fromRGB(120, 40, 210)
		TitleLabel.TextTransparency = 1
		TitleLabel.ZIndex = 13
		TitleLabel.Parent = Container
		local SubtitleLabel = Instance.new("TextLabel")
		SubtitleLabel.Name = "Subtitle"
		SubtitleLabel.Size = UDim2.new(1, 0, 0, 30)
		SubtitleLabel.Position = UDim2.new(0.5, 0, 0, 235)
		SubtitleLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		SubtitleLabel.BackgroundTransparency = 1
		SubtitleLabel.Text = "All for you"
		SubtitleLabel.Font = Enum.Font.GothamBold
		SubtitleLabel.TextSize = 22
		SubtitleLabel.TextColor3 = Color3.fromRGB(60, 20, 110)
		SubtitleLabel.TextTransparency = 1
		SubtitleLabel.ZIndex = 13
		SubtitleLabel.Parent = Container
		local FadeInInfo = TweenInfo.new(1.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
		TweenService:Create(WhiteOverlay, FadeInInfo, {BackgroundTransparency = 0}):Play()
		TweenService:Create(TopShadow, FadeInInfo, {BackgroundTransparency = 0.15}):Play()
		TweenService:Create(LogoImage, FadeInInfo, {ImageTransparency = 0, Size = UDim2.fromOffset(175, 175)}):Play()
		TweenService:Create(TitleLabel, FadeInInfo, {TextTransparency = 0}):Play()
		TweenService:Create(SubtitleLabel, FadeInInfo, {TextTransparency = 0}):Play()
		task.wait(3.6)
		local FadeOutInfo = TweenInfo.new(1.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
		local OverlayFadeOut = TweenService:Create(WhiteOverlay, FadeOutInfo, {BackgroundTransparency = 1})
		TweenService:Create(TopShadow, FadeOutInfo, {BackgroundTransparency = 1}):Play()
		TweenService:Create(LogoImage, FadeOutInfo, {ImageTransparency = 1, Size = UDim2.fromOffset(145, 145)}):Play()
		TweenService:Create(TitleLabel, FadeOutInfo, {TextTransparency = 1}):Play()
		TweenService:Create(SubtitleLabel, FadeOutInfo, {TextTransparency = 1}):Play()
		OverlayFadeOut:Play()
		OverlayFadeOut.Completed:Wait()
		ScreenGui:Destroy()
	end

	local function ShowKeySystem()
		local KeyVerified = false

		pcall(function()
			local ExistingKeySystem = GetGuiParent():FindFirstChild("Aeris_KeySystem")
			if ExistingKeySystem then
				ExistingKeySystem:Destroy()
			end
		end)

		local ScreenGui = Instance.new("ScreenGui")
		ScreenGui.Name = "Aeris_KeySystem"
		ScreenGui.ResetOnSpawn = false
		ScreenGui.IgnoreGuiInset = true
		ScreenGui.DisplayOrder = 999998
		ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		ScreenGui.Parent = GetGuiParent()
		local MainFrame = Instance.new("Frame")
		MainFrame.Name = "MainFrame"
		MainFrame.Size = UDim2.fromOffset(0, 0)
		MainFrame.Position = UDim2.fromScale(0.5, 0.5)
		MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		MainFrame.BackgroundColor3 = Color3.fromRGB(35, 18, 58)
		MainFrame.BackgroundTransparency = 1
		MainFrame.ClipsDescendants = true
		MainFrame.Active = true
		MainFrame.Draggable = true
		MainFrame.Parent = ScreenGui
		Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)
		local BackgroundGradient = Instance.new("UIGradient")

		BackgroundGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(165, 110, 245)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(245, 235, 255)),
		})

		BackgroundGradient.Rotation = 45
		BackgroundGradient.Parent = MainFrame
		CreateAnimatedStroke(MainFrame, 2.5)
		local TitleLabel = Instance.new("TextLabel")
		TitleLabel.Size = UDim2.new(1, -30, 0, 36)
		TitleLabel.Position = UDim2.fromOffset(15, 16)
		TitleLabel.BackgroundTransparency = 1
		TitleLabel.Text = "AERIS | KEY VERIFICATION"
		TitleLabel.Font = Enum.Font.GothamBlack
		TitleLabel.TextSize = 20
		TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TitleLabel.TextStrokeTransparency = 0.6
		TitleLabel.TextStrokeColor3 = Color3.fromRGB(90, 30, 160)
		TitleLabel.Parent = MainFrame
		local WarningLabel = Instance.new("TextLabel")
		WarningLabel.Size = UDim2.new(1, -40, 0, 38)
		WarningLabel.Position = UDim2.fromOffset(20, 52)
		WarningLabel.BackgroundTransparency = 1
		WarningLabel.Text = "Warning: Your key resets every 24 hours and must be entered on each account."
		WarningLabel.Font = Enum.Font.GothamMedium
		WarningLabel.TextSize = 13
		WarningLabel.TextWrapped = true
		WarningLabel.TextColor3 = Color3.fromRGB(245, 230, 255)
		WarningLabel.TextStrokeTransparency = 0.75
		WarningLabel.Parent = MainFrame
		local KeyInput = Instance.new("TextBox")
		KeyInput.Size = UDim2.new(1, -50, 0, 44)
		KeyInput.Position = UDim2.fromOffset(25, 102)
		KeyInput.BackgroundColor3 = Color3.fromRGB(80, 40, 130)
		KeyInput.BackgroundTransparency = 0.45
		KeyInput.Text = ""
		KeyInput.PlaceholderText = "Enter your key here (case & space sensitive)..."
		KeyInput.PlaceholderColor3 = Color3.fromRGB(220, 200, 240)
		KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
		KeyInput.Font = Enum.Font.GothamBold
		KeyInput.TextSize = 14
		KeyInput.ClearTextOnFocus = false
		KeyInput.Parent = MainFrame
		Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 10)
		CreateAnimatedStroke(KeyInput, 1.6)
		local StatusLabel = Instance.new("TextLabel")
		StatusLabel.Size = UDim2.new(1, -50, 0, 22)
		StatusLabel.Position = UDim2.fromOffset(25, 152)
		StatusLabel.BackgroundTransparency = 1
		StatusLabel.Text = ""
		StatusLabel.Font = Enum.Font.GothamBold
		StatusLabel.TextSize = 13
		StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		StatusLabel.Parent = MainFrame
		local VerifyButton = Instance.new("TextButton")
		VerifyButton.Name = "VerifyButton"
		VerifyButton.Size = UDim2.new(0.44, 0, 0, 44)
		VerifyButton.Position = UDim2.new(0.05, 0, 0, 182)
		VerifyButton.BackgroundColor3 = Color3.fromRGB(130, 60, 220)
		VerifyButton.BackgroundTransparency = 0.5
		VerifyButton.Text = "Verify"
		VerifyButton.Font = Enum.Font.GothamBold
		VerifyButton.TextSize = 15
		VerifyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		VerifyButton.AutoButtonColor = true
		VerifyButton.Parent = MainFrame
		Instance.new("UICorner", VerifyButton).CornerRadius = UDim.new(0, 10)
		CreateAnimatedStroke(VerifyButton, 1.8)
		local GetKeyButton = Instance.new("TextButton")
		GetKeyButton.Name = "GetKeyButton"
		GetKeyButton.Size = UDim2.new(0.44, 0, 0, 44)
		GetKeyButton.Position = UDim2.new(0.51, 0, 0, 182)
		GetKeyButton.BackgroundColor3 = Color3.fromRGB(130, 60, 220)
		GetKeyButton.BackgroundTransparency = 0.5
		GetKeyButton.Text = "Get Key"
		GetKeyButton.Font = Enum.Font.GothamBold
		GetKeyButton.TextSize = 15
		GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		GetKeyButton.AutoButtonColor = true
		GetKeyButton.Parent = MainFrame
		Instance.new("UICorner", GetKeyButton).CornerRadius = UDim.new(0, 10)
		CreateAnimatedStroke(GetKeyButton, 1.8)

		TweenService:Create(
			MainFrame,
			TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
			{Size = UDim2.fromOffset(440, 248), BackgroundTransparency = 0.25}
		):Play()

		GetKeyButton.MouseButton1Click:Connect(function()
			pcall(function()
				setclipboard("https://discord.gg/t6rhaAZvhG")
			end)

			StatusLabel.TextColor3 = Color3.fromRGB(235, 210, 255)
			StatusLabel.Text = "Copied key link! (https://discord.gg/t6rhaAZvhG)"
		end)

		VerifyButton.MouseButton1Click:Connect(function()
			if KeyInput.Text == "bLidikBol" then
				StatusLabel.TextColor3 = Color3.fromRGB(180, 255, 200)
				StatusLabel.Text = "Key verified! Loading Aeris..."
				SaveKeySession()

				local CloseTween = TweenService:Create(
					MainFrame,
					TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.In),
					{Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1}
				)

				CloseTween:Play()
				CloseTween.Completed:Wait()
				ScreenGui:Destroy()
				KeyVerified = true
			else
				StatusLabel.TextColor3 = Color3.fromRGB(255, 120, 140)
				StatusLabel.Text = "Invalid key! Check spaces and uppercase/lowercase letters."
			end
		end)

		repeat
			task.wait(0.1)
		until KeyVerified
	end

	if not IsKeySessionValid() then
		ShowKeySystem()
	end

	ShowSplashScreen()

	task.spawn(function()
		while task.wait(60) do
			if not IsKeySessionValid() then
				pcall(function()
					LocalPlayer:Kick("[Aeris] Your 24-hour key session has expired. Please re-inject and enter your key again.")
				end)
				break
			end
		end
	end)

	local WindUi = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/download/1.6.66/main.lua"))()

	pcall(function()
		WindUi:AddTheme({
			Name = "Aeris Purple",
			Accent = Color3.fromRGB(170, 85, 255),
			Background = Color3.fromRGB(24, 14, 38),
			Outline = Color3.fromRGB(235, 215, 255),
			Text = Color3.fromRGB(255, 255, 255),
			Button = Color3.fromRGB(52, 28, 82),
			Icon = Color3.fromRGB(200, 140, 255),
		})
	end)

	local WindowConfig = {
		Title = "AERIS HUB | AERIS",
		Icon = "rbxassetid://94398897297532",
		Author = "Aeris. All for you",
		Folder = "AERIS_WINDUI",
		Size = UDim2.fromOffset(600, 480),
		Theme = "Aeris Purple",
		Transparent = true,
		HasOutline = true,
	}

	local Window = WindUi:CreateWindow(WindowConfig)

	pcall(function()
		Window:EditOpenButton({Enabled = false})
	end)

	task.spawn(function()
		task.wait(0.5)
		pcall(function()
			for _, Child in pairs(GetGuiParent():GetChildren()) do
				if Child:IsA("ScreenGui") and Child.Name ~= "Aeris_WindUI_Toggle" then
					for _, Descendant in pairs(Child:GetDescendants()) do
						if Descendant:IsA("UIStroke") and Descendant.Thickness >= 1 then
							local StrokeGradient = Descendant:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient", Descendant)

							StrokeGradient.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 60, 255)),
								ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 60, 255)),
							})

							task.spawn(function()
								while Descendant.Parent do
									StrokeGradient.Rotation = (StrokeGradient.Rotation + 2) % 360
									task.wait(0.03)
								end
							end)
						end
					end
				end
			end
		end)
	end)

	pcall(function()
		local ExistingToggleGui = GetGuiParent():FindFirstChild("Aeris_WindUI_Toggle")
		if ExistingToggleGui then
			ExistingToggleGui:Destroy()
		end
	end)

	local ToggleScreenGui = Instance.new("ScreenGui")
	ToggleScreenGui.Name = "Aeris_WindUI_Toggle"
	ToggleScreenGui.ResetOnSpawn = false
	ToggleScreenGui.IgnoreGuiInset = true
	ToggleScreenGui.Parent = GetGuiParent()
	local ToggleButton = Instance.new("TextButton")
	ToggleButton.Name = "MenuToggle"
	ToggleButton.Size = UDim2.fromOffset(56, 56)
	ToggleButton.Position = UDim2.new(0, 15, 0.5, -28)
	ToggleButton.BackgroundColor3 = Color3.fromRGB(235, 220, 255)
	ToggleButton.BackgroundTransparency = 0.15
	ToggleButton.Text = ""
	ToggleButton.AutoButtonColor = true
	ToggleButton.ZIndex = 100
	ToggleButton.Parent = ToggleScreenGui
	Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 14)
	CreateAnimatedStroke(ToggleButton, 2.2)
	local LogoImage = Instance.new("ImageLabel")
	LogoImage.Name = "LogoIcon"
	LogoImage.Size = UDim2.fromScale(0.76, 0.76)
	LogoImage.Position = UDim2.fromScale(0.5, 0.5)
	LogoImage.AnchorPoint = Vector2.new(0.5, 0.5)
	LogoImage.BackgroundTransparency = 1
	LogoImage.Image = "rbxassetid://94398897297532"
	LogoImage.ScaleType = Enum.ScaleType.Fit
	LogoImage.ZIndex = 101
	LogoImage.Parent = ToggleButton
	local WindowOpen = true
	local IsPressed = false
	local TrackedInput
	local StartInputPosition
	local StartButtonPosition
	local HasDragged = false

	ToggleButton.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			IsPressed = true
			HasDragged = false
			local ButtonPosition = ToggleButton.Position
			StartInputPosition = Input.Position
			StartButtonPosition = ButtonPosition
		end
	end)

	ToggleButton.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
			TrackedInput = Input
		end
	end)

	ToggleButton.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			IsPressed = false
			if not HasDragged then
				WindowOpen = not WindowOpen
				pcall(function()
					if WindowOpen then
						Window:Open()
					else
						Window:Close()
					end
				end)
			end
		end
	end)

	UserInputService.InputChanged:Connect(function(Input)
		if Input == TrackedInput and IsPressed then
			local Delta = Input.Position - StartInputPosition

			if math.abs(Delta.X) > 4 or math.abs(Delta.Y) > 4 then
				HasDragged = true
			end

			ToggleButton.Position = UDim2.new(StartButtonPosition.X.Scale, StartButtonPosition.X.Offset + Delta.X, StartButtonPosition.Y.Scale, StartButtonPosition.Y.Offset + Delta.Y)
		end
	end)

	getgenv().Aeris_WindUI_ToggleButton = ToggleButton

	function Window:AddTab(TabInfo)
		local Tab = self:Tab({Title = TabInfo.Title, Icon = TabInfo.Icon})

		function Tab:AddSection(Title, Icon)
			pcall(function()
				self:Section({Title = Title, Icon = Icon})
			end)
			return {
				AddToggle = function(Self, _, Options)
					return Self and Tab:Toggle({Title = Options.Title, Desc = Options.Description, Value = Options.Default, Callback = Options.Callback})
				end,
				AddDropdown = function(_, _, Options)
					return Tab:Dropdown({
						Title = Options.Title,
						Desc = Options.Description,
						Values = Options.Values,
						Value = Options.Default,
						Multi = Options.Multi,
						Callback = Options.Callback,
					})
				end,
				AddSlider = function(_, _, Options)
					return Tab:Slider({
						Title = Options.Title,
						Desc = Options.Description,
						Value = {Min = Options.Min, Max = Options.Max, Default = Options.Default},
						Rounding = Options.Rounding,
						Callback = Options.Callback,
					})
				end,
				AddInput = function(_, _, Options)
					return Tab:Input({
						Title = Options.Title,
						Desc = Options.Description,
						Placeholder = Options.Placeholder,
						Value = Options.Default,
						Callback = Options.Callback,
					})
				end,
				AddKeybind = function(_, _, Options)
					return Tab:Keybind({
						Title = Options.Title,
						Desc = Options.Description,
						Value = Options.Default,
						Callback = Options.Callback,
						ChangedCallback = Options.ChangedCallback,
					})
				end,
			}
		end

		return Tab
	end

	local Tabs = {
		Rage = Window:AddTab({Title = "Autoparry", Icon = "sword"}),
		Spam = Window:AddTab({Title = "Spam", Icon = "skull"}),
		Detection = Window:AddTab({Title = "Detection", Icon = "eye"}),
		Visuals = Window:AddTab({Title = "Visuals", Icon = "monitor"}),
		Misc = Window:AddTab({Title = "Misc", Icon = "settings"}),
		Dash = Window:AddTab({Title = "Dash", Icon = "zap"}),
		Discord = Window:AddTab({Title = "Discord", Icon = "message-circle"}),
		Settings = Window:AddTab({Title = "Settings", Icon = "sliders"}),
	}

	getgenv().NAZK_DashEnabled = getgenv().NAZK_DashEnabled ~= false
	getgenv().NAZK_DashPower = getgenv().NAZK_DashPower or 45
	getgenv().NAZK_DashVertical = getgenv().NAZK_DashVertical or 0
	getgenv().NAZK_DashKey = getgenv().NAZK_DashKey or Enum.KeyCode.Q
	getgenv().NAZK_DashCooldown = getgenv().NAZK_DashCooldown or 0.25
	getgenv().NAZK_dashLast = getgenv().NAZK_dashLast or 0

	getgenv().NAZK_DoDash = function()
		if tick() - getgenv().NAZK_dashLast < getgenv().NAZK_DashCooldown then
			return
		end

		getgenv().NAZK_dashLast = tick()
		local Character = LocalPlayer.Character
		local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		local CurrentCamera = WorkspaceService.CurrentCamera

		if not RootPart or not CurrentCamera then
			return
		end

		local LookDirection = Vector3.new(CurrentCamera.CFrame.LookVector.X, 0, CurrentCamera.CFrame.LookVector.Z)

		if LookDirection.Magnitude < 0.01 then
			return
		end

		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000)
		BodyVelocity.Velocity = LookDirection.Unit * getgenv().NAZK_DashPower + Vector3.new(0, getgenv().NAZK_DashVertical, 0)
		BodyVelocity.P = 20000
		BodyVelocity.Parent = RootPart
		DebrisService:AddItem(BodyVelocity, 0.15)
	end

	UserInputService.InputBegan:Connect(function(Input, GameProcessed)
		if not GameProcessed and getgenv().NAZK_DashEnabled and Input.KeyCode == getgenv().NAZK_DashKey then
			getgenv().NAZK_DoDash()
		end
	end)

	local DashSettingsSection = Tabs.Dash:AddSection("Dash Settings", "zap")

	DashSettingsSection:AddToggle("NAZKDashEnabled", {
		Title = "Dash Enabled",
		Description = "Enable dash hotkey",
		Default = true,
		Callback = function(Value)
			getgenv().NAZK_DashEnabled = Value
		end,
	})

	DashSettingsSection:AddSlider("NAZKDashPower", {
		Title = "Dash Power",
		Description = "Movement strength",
		Default = 45,
		Min = 10,
		Max = 200,
		Rounding = 0,
		Callback = function(Value)
			getgenv().NAZK_DashPower = Value
		end,
	})

	DashSettingsSection:AddSlider("NAZKDashVertical", {
		Title = "Dash Height",
		Description = "Vertical force",
		Default = 0,
		Min = 0,
		Max = 100,
		Rounding = 0,
		Callback = function(Value)
			getgenv().NAZK_DashVertical = Value
		end,
	})

	DashSettingsSection:AddSlider("NAZKDashCooldown", {
		Title = "Dash Cooldown",
		Description = "Delay between dashes",
		Default = 0.25,
		Min = 0,
		Max = 2,
		Rounding = 2,
		Callback = function(Value)
			getgenv().NAZK_DashCooldown = Value
		end,
	})

	DashSettingsSection:AddDropdown("NAZKDashKey", {
		Title = "Dash Key",
		Values = {"Q", "E", "F", "LeftShift", "C", "V", "X"},
		Default = "Q",
		Multi = false,
		Callback = function(Value)
			getgenv().NAZK_DashKey = Enum.KeyCode[Value] or Enum.KeyCode.Q
		end,
	})

	Tabs.Discord:AddSection("Aeris Community", "message-circle")
	Tabs.Discord:Paragraph({Title = "Aeris.", Desc = "All for you — Unified WindUI Interface"})
	Tabs.Discord:Paragraph({Title = "Discord Invite", Desc = "https://discord.gg/t6rhaAZvhG"})

	Tabs.Discord:Button({
		Title = "Copy Discord Invite",
		Icon = "copy",
		Callback = function()
			pcall(function()
				setclipboard("https://discord.gg/t6rhaAZvhG")
			end)
			WindUi:Notify({Title = "Discord", Content = "Invite link copied to clipboard!", Duration = 3})
		end,
	})

	if not LocalPlayer.Character then
		LocalPlayer.CharacterAdded:Wait()
	end

	local AliveFolder = WorkspaceService:FindFirstChild("Alive") or WorkspaceService:WaitForChild("Alive")
	local Runtime = WorkspaceService.Runtime

	local function IsMobileDevice()
		local TouchEnabled = UserInputService.TouchEnabled
		local MouseEnabled = UserInputService.MouseEnabled
		local KeyboardEnabled = UserInputService.KeyboardEnabled

		if TouchEnabled and not KeyboardEnabled then
			return true
		end

		if TouchEnabled and not MouseEnabled then
			return true
		end

		return false
	end

	local Properties = {
		__autoparry_enabled = false,
		__triggerbot_enabled = false,
		__manual_spam_enabled = false,
		__auto_spam_enabled = false,
		__play_animation = false,
		__accuracy = 50,
		__divisor_multiplier = 1.1,
		__parried = false,
		__training_parried = false,
		__spam_threshold = 1.5,
		__parries = 0,
	}

	Properties.__parry_key = nil
	Properties.__grab_animation = nil
	Properties.__tornado_time = tick()
	Properties.__first_parry_done = false
	Properties.__connections = {}
	Properties.__reverted_remotes = {}
	Properties.__spam_accumulator = 0
	Properties.__spam_rate = 240
	Properties.__infinity_active = false
	Properties.__deathslash_active = false
	Properties.__timehole_active = false
	Properties.__slashesoffury_active = false
	Properties.__slashesoffury_count = 0
	Properties.__is_mobile = IsMobileDevice()
	Properties.__mobile_guis = {}
	Properties.__randomized_accuracy_enabled = false
	Properties.__speed_display_enabled = false
	Properties.__auto_jump_enabled = false
	Properties.__ball_speed = 0
	Properties.__peak_ball_speed = 0
	Properties.__headless_enabled = false
	Properties.__korblox_enabled = false
	Properties.__thunder_dash_enabled = false
	Properties.__ball_velocity_gui = nil
	Properties.__ball_velocity_enabled = false
	Properties.__peak_velocity = 0
	Properties.__last_ball_id = nil
	Properties.__ping_label = nil

	local Hub = {
		__properties = Properties,
		__config = {
			__curve_names = {"Camera", "Random", "Accelerated", "Backwards", "Slow", "High", "Normal", "Speed", "Down"},
			__detections = {
				__infinity = false,
				__deathslash = false,
				__timehole = false,
				__slashesoffury = false,
				__phantom = false,
			},
		},
		__triggerbot = {
			__enabled = false,
			__is_parrying = false,
			__parries = 0,
			__max_parries = 10000,
			__parry_delay = 0.01,
		},
	}

	local SelectedCurveMode = "Camera"

	local CurveModeNames = {
		"Camera",
		"Random",
		"Accelerated",
		"Backwards",
		"Slow",
		"High",
		"Normal",
		"Speed",
		"Down",
		"Left",
		"Right",
	}

	local CurrentCurveMode = "Camera"

	local function UpdateDivisorMultiplier()
		Hub.__properties.__divisor_multiplier = 0.7 + (Hub.__properties.__accuracy - 1) * 0.00909090909090909
	end

	local function RandomizeAccuracy()
		if not Hub.__properties.__randomized_accuracy_enabled then
			return
		end

		local ValueString = StatsService.Network.ServerStatsItem["Data Ping"]:GetValueString()
		local PingValue = tonumber(ValueString:match("%d+")) or 0
		local NewAccuracy

		if PingValue >= 90 then
			NewAccuracy = 4
		elseif PingValue <= 50 then
			NewAccuracy = math.random(70, 100)
		else
			NewAccuracy = Hub.__properties.__accuracy
		end

		if NewAccuracy then
			Hub.__properties.__accuracy = NewAccuracy
			UpdateDivisorMultiplier()
		end
	end

	task.spawn(function()
		while task.wait(1) do
			if Hub.__properties.__randomized_accuracy_enabled then
				RandomizeAccuracy()
			end
		end
	end)

	local HookReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
	local TimeWorkspace = cloneref(game:GetService("Workspace"))
	local TokenFunction
	local TokenFound = false

	for _, GcObject in getgc(true) do
		if type(GcObject) == "function" and debug.info(GcObject, "s"):find("PRY", 1, true) then
			for _, Upvalue in debug.getupvalues(GcObject) do
				if type(Upvalue) == "function" then
					TokenFunction = Upvalue
					TokenFound = true
					break
				end
			end
			if TokenFunction then
				break
			end
		end
	end

	if not TokenFound then
		WindUi:Notify({Title = "Aeris Hub", Content = "Token not found!", Duration = 5})
		return
	end

	function _tokenize(Seed)
		local TimeString = tostring(math.floor(TimeWorkspace:GetServerTimeNow() * 100))
		local Key = TokenFunction(Seed, "TIME")
		local Encoded = table.create(#TimeString)

		for Index = 1, #TimeString do
			Encoded[Index] = string.char(bit32.bxor((string.byte(TimeString, Index) + Index) % 256, string.byte(Key, (Index - 1) % #Key + 1)))
		end

		return table.concat(Encoded)
	end

	local HookedRemoteArgs = {}
	local HookedMetatables = {}
	local ParryRemote
	local ParryArgs

	function _is_valid(Args)
		if not Args or #Args < 8 then
			return false
		end
		return true
	end

	function _hook(Remote)
		if not Remote or HookedRemoteArgs[Remote] or HookedMetatables[getrawmetatable(Remote)] then
			return
		end

		HookedMetatables[getrawmetatable(Remote)] = true
		local Metatable = getrawmetatable(Remote)
		setreadonly(Metatable, false)
		local OriginalIndex = Metatable.__index

		function Metatable.__index(Object, Key)
			if Key == "FireServer" and Object:IsA("RemoteEvent") or Key == "InvokeServer" and Object:IsA("RemoteFunction") then
				return function(Caller, ...)
					local Args = {...}

					if _is_valid(Args) then
						if not HookedRemoteArgs[Object] then
							HookedRemoteArgs[Object] = Args
							ParryRemote = Object
							ParryArgs = Args
						end
					end

					return OriginalIndex(Object, Key)(Caller, unpack(Args))
				end
			end
			return OriginalIndex(Object, Key)
		end

		setreadonly(Metatable, true)
	end

	for _, Descendant in pairs(HookReplicatedStorage:GetDescendants()) do
		if Descendant:IsA("RemoteEvent") or Descendant:IsA("RemoteFunction") then
			_hook(Descendant)
		end
	end

	task.wait(5)

	task.spawn(function()
		local Elapsed = 0

		while not ParryRemote and Elapsed < 30 do
			task.wait(1)
			Elapsed = Elapsed + 1
		end

		if ParryRemote then
			WindUi:Notify({Title = "Aeris Hub", Content = "Remote found ✓", Duration = 3})
		else
			WindUi:Notify({Title = "Aeris Hub", Content = "Remote not found! Please parry once manually.", Duration = 5})
		end
	end)

	local function FireParry(CameraCFrame)
		if not ParryRemote or not ParryArgs then
			return false
		end

		local CurrentCamera = WorkspaceService.CurrentCamera
		local CursorPosition

		if Hub.__properties.__is_mobile then
			local ViewportSize = CurrentCamera.ViewportSize
			CursorPosition = {math.floor(ViewportSize.X / 2), math.floor(ViewportSize.Y / 2)}
		else
			local Success, Result = pcall(function()
				return UserInputService:GetMouseLocation()
			end)
			if Success and Result then
				CursorPosition = {math.floor(Result.X), math.floor(Result.Y)}
			else
				local FallbackViewportSize = CurrentCamera.ViewportSize
				CursorPosition = {math.floor(FallbackViewportSize.X / 2), math.floor(FallbackViewportSize.Y / 2)}
			end
		end

		local ScreenPositions = {}

		if AliveFolder then
			for _, Child in pairs(AliveFolder:GetChildren()) do
				if Child.PrimaryPart then
					local ProjectSuccess, ProjectResult = pcall(function()
						return CurrentCamera:WorldToScreenPoint(Child.PrimaryPart.Position)
					end)
					if ProjectSuccess then
						ScreenPositions[Child.Name] = ProjectResult
					end
				end
			end
		end

		local ParryPayload = {ParryArgs[1], ParryArgs[2], _tokenize(ParryArgs[2]), 0.5, CameraCFrame or CurrentCamera.CFrame, ScreenPositions, CursorPosition, false}

		pcall(function()
			if ParryRemote:IsA("RemoteEvent") then
				ParryRemote:FireServer(unpack(ParryPayload))
			elseif ParryRemote:IsA("RemoteFunction") then
				ParryRemote:InvokeServer(unpack(ParryPayload))
			end
		end)

		return true
	end

	Hub.animation = {}
	local SwordAPI = ReplicatedStorageService:WaitForChild("Shared"):WaitForChild("SwordAPI")
	local LastGrabTime = 0
	local ForceGrabAnimation = false
	local GrabAnimationTrack
	local GrabAnimationCache = {}

	local function GetGrabAnimation(SwordName)
		if not SwordName or SwordName == "" then
			return SwordAPI.Collection.Default:FindFirstChild("GrabParry")
		end

		if GrabAnimationCache[SwordName] then
			return GrabAnimationCache[SwordName]
		end

		local Success, Result = pcall(function()
			return ReplicatedStorageService.Shared.ReplicatedInstances.Swords.GetSword:Invoke(SwordName)
		end)

		if not Success or not Result or type(Result) ~= "table" or not Result.AnimationType then
			GrabAnimationCache[SwordName] = SwordAPI.Collection.Default:FindFirstChild("GrabParry")
			return GrabAnimationCache[SwordName]
		end

		for _, Child in pairs(SwordAPI.Collection:GetChildren()) do
			if Child.Name == Result.AnimationType then
				local GrabAnimation = Child:FindFirstChild("GrabParry") or Child:FindFirstChild("Grab")
				if GrabAnimation then
					GrabAnimationCache[SwordName] = GrabAnimation
					return GrabAnimation
				end
			end
		end

		GrabAnimationCache[SwordName] = SwordAPI.Collection.Default:FindFirstChild("GrabParry")
		return GrabAnimationCache[SwordName]
	end

	function Hub.animation.play_grab_parry()
		if not Hub.__properties.__play_animation then
			return
		end

		if not (os.clock() - LastGrabTime >= 0.19999999999999996 or ForceGrabAnimation) then
			return
		end

		LastGrabTime = os.clock()
		ForceGrabAnimation = false
		local Character = LocalPlayer.Character

		if not Character then
			return
		end

		local Humanoid = Character:FindFirstChildOfClass("Humanoid")

		if not Humanoid then
			return
		end

		local SwordName

		if getgenv().skinChanger then
			SwordName = getgenv().swordAnimations ~= "" and getgenv().swordAnimations or getgenv().swordModel ~= "" and getgenv().swordModel or Character:GetAttribute("CurrentlyEquippedSword")
		else
			SwordName = Character:GetAttribute("CurrentlyEquippedSword")
		end

		local Animation = GetGrabAnimation(SwordName)

		if not Animation then
			return
		end

		for _, Track in pairs(Humanoid.Animator:GetPlayingAnimationTracks()) do
			if Track.Name == "GrabParry" or Track.Name == "Grab" then
				Track.TimePosition = 0
				if Track then
					pcall(function()
						Track:Stop(Track:GetAttribute("StopFadeTime") or 0.1)
					end)
				end
			elseif Track.Name == "SuccessParry" or Track.Name == "Success" then
				if Track then
					pcall(function()
						Track:Stop(Track:GetAttribute("StopFadeTime") or 0.1)
					end)
				end
			end
		end

		GrabAnimationTrack = Humanoid.Animator:LoadAnimation(Animation)
		local LoadedTrack = GrabAnimationTrack

		if LoadedTrack then
			pcall(function()
				LoadedTrack:Play(
					LoadedTrack:GetAttribute("PlayFadeTime") or 0,
					LoadedTrack:GetAttribute("PlayWeight") or 1,
					LoadedTrack:GetAttribute("PlaySpeed") or 1
				)
			end)
		end
	end

	pcall(function()
		ReplicatedStorageService.Remotes.ParrySuccessAll.OnClientEvent:Connect(function()
			ForceGrabAnimation = true
			local Character = LocalPlayer.Character

			if not Character then
				return
			end

			local Humanoid = Character:FindFirstChildOfClass("Humanoid")

			if not Humanoid then
				return
			end

			for _, Track in pairs(Humanoid.Animator:GetPlayingAnimationTracks()) do
				if Track.Name == "GrabParry" or Track.Name == "Grab" then
					if Track then
						pcall(function()
							Track:Stop(Track:GetAttribute("StopFadeTime") or 0.1)
						end)
					end
				end
			end
		end)
	end)

	Hub.ball = {}

	function Hub.ball.get()
		local Balls = WorkspaceService:FindFirstChild("Balls")

		if not Balls then
			return nil
		end

		for _, Child in pairs(Balls:GetChildren()) do
			if Child:GetAttribute("realBall") then
				Child.CanCollide = false
				return Child
			end
		end

		return nil
	end

	function Hub.ball.get_all()
		local RealBalls = {}
		local Balls = WorkspaceService:FindFirstChild("Balls")

		if not Balls then
			return RealBalls
		end

		for _, Child in pairs(Balls:GetChildren()) do
			if Child:GetAttribute("realBall") then
				Child.CanCollide = false
				table.insert(RealBalls, Child)
			end
		end

		return RealBalls
	end

	Hub.player = {}
	local CachedClosestPlayer
	local LastClosestCheck = 0

	function Hub.player.get_closest()
		local Now = tick()

		if Now - LastClosestCheck < 0.1 then
			return CachedClosestPlayer
		end

		LastClosestCheck = Now
		local ClosestDistance = math.huge
		local ClosestPlayer

		if not AliveFolder then
			return nil
		end

		for _, Child in pairs(AliveFolder:GetChildren()) do
			if Child ~= LocalPlayer.Character and Child.PrimaryPart then
				local Distance = LocalPlayer:DistanceFromCharacter(Child.PrimaryPart.Position)
				if Distance < ClosestDistance then
					ClosestDistance = Distance
					ClosestPlayer = Child
				end
			end
		end

		CachedClosestPlayer = ClosestPlayer
		return ClosestPlayer
	end

	Hub.curve = {}

	function Hub.curve.get_cframe()
		local CurrentCamera = WorkspaceService.CurrentCamera
		local RootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		local OriginPosition = RootPart and RootPart.Position or CurrentCamera.CFrame.Position
		local TargetPart
		local ClosestScreenDistance = math.huge
		local MouseLocation = not Hub.__properties.__is_mobile and UserInputService:GetMouseLocation() or nil

		if AliveFolder then
			for _, Child in pairs(AliveFolder:GetChildren()) do
				if Child ~= LocalPlayer.Character and Child.PrimaryPart then
					local ScreenPoint, OnScreen = CurrentCamera:WorldToScreenPoint(Child.PrimaryPart.Position)
					if OnScreen then
						local ScreenDistance

						if MouseLocation then
							ScreenDistance = (Vector2.new(ScreenPoint.X, ScreenPoint.Y) - MouseLocation).Magnitude
						else
							local ScreenCenter = Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y / 2)
							ScreenDistance = (Vector2.new(ScreenPoint.X, ScreenPoint.Y) - ScreenCenter).Magnitude
						end

						if ScreenDistance < ClosestScreenDistance then
							ClosestScreenDistance = ScreenDistance
							TargetPart = Child.PrimaryPart
						end
					end
				end
			end
		end

		local TargetPosition = TargetPart and TargetPart.Position or OriginPosition + CurrentCamera.CFrame.LookVector * 100
		local Mode = CurrentCurveMode
		local ResultCFrame

		if Mode == "Camera" then
			ResultCFrame = CurrentCamera.CFrame
		elseif Mode == "Random" then
			local Direction = (TargetPosition - OriginPosition).Unit
			local Attempts = 0
			local RandomOffset

			repeat
				RandomOffset = Vector3.new(math.random(-4000, 4000), math.random(-4000, 4000), math.random(-4000, 4000))
				local DotProduct = Direction:Dot((TargetPosition + RandomOffset - OriginPosition).Unit)
				Attempts = Attempts + 1
			until DotProduct < 0.95 or Attempts > 10

			ResultCFrame = CFrame.new(OriginPosition, TargetPosition + RandomOffset)
		elseif Mode == "Accelerated" then
			ResultCFrame = CFrame.new(OriginPosition, TargetPosition + Vector3.new(0, 5, 0))
		elseif Mode == "Backwards" then
			local BackwardsTarget = OriginPosition + (OriginPosition - TargetPosition).Unit * 10000 + Vector3.new(0, 1000, 0)
			ResultCFrame = CFrame.new(CurrentCamera.CFrame.Position, BackwardsTarget)
		elseif Mode == "Slow" then
			ResultCFrame = CFrame.new(OriginPosition, TargetPosition + Vector3.new(0, -9000000000000000000, 0))
		elseif Mode == "High" then
			ResultCFrame = CFrame.new(OriginPosition, TargetPosition + Vector3.new(0, 9000000000000000000, 0))
		elseif Mode == "Normal" then
			ResultCFrame = CFrame.new(OriginPosition, OriginPosition + (RootPart and RootPart.CFrame.LookVector or CurrentCamera.CFrame.LookVector))
		elseif Mode == "Speed" then
			ResultCFrame = CFrame.new(CurrentCamera.CFrame.Position, CurrentCamera.CFrame.Position + CurrentCamera.CFrame.UpVector * 5)
		elseif Mode == "Down" then
			ResultCFrame = CFrame.new(
				CurrentCamera.CFrame.Position,
				CurrentCamera.CFrame.Position + CurrentCamera.CFrame.UpVector * -9000000000
			)
		elseif Mode == "Left" then
			ResultCFrame = CFrame.new(
				CurrentCamera.CFrame.Position,
				CurrentCamera.CFrame.Position - CurrentCamera.CFrame.RightVector * 9000000000
			)
		elseif Mode == "Right" then
			ResultCFrame = CFrame.new(
				CurrentCamera.CFrame.Position,
				CurrentCamera.CFrame.Position + CurrentCamera.CFrame.RightVector * 9000000000
			)
		else
			ResultCFrame = CurrentCamera.CFrame
		end

		return ResultCFrame
	end

	Hub.parry = {}

	function Hub.parry.execute()
		if Hub.__properties.__parries > 10000 or not LocalPlayer.Character then
			return
		end

		FireParry(Hub.curve.get_cframe())

		if Hub.__properties.__parries > 10000 then
			return
		end

		Hub.__properties.__parries = Hub.__properties.__parries + 1

		task.delay(0.5, function()
			if Hub.__properties.__parries > 0 then
				Hub.__properties.__parries = Hub.__properties.__parries - 1
			end
		end)
	end

	function Hub.parry.keypress()
		Hub.parry.execute()
	end

	function Hub.parry.execute_action()
		Hub.animation.play_grab_parry()
		Hub.parry.execute()
	end

	Hub.detection = {
		__ball_properties = {__aerodynamic_time = tick(), __last_warping = tick(), __lerp_radians = 0, __curving = tick()},
	}

	function Hub.detection.is_curved()
		local BallProperties = Hub.detection.__ball_properties
		local Ball = Hub.ball.get()

		if not Ball then
			return false
		end

		local Zoomies = Ball:FindFirstChild("zoomies")

		if not Zoomies then
			return false
		end

		local VectorVelocity = Zoomies.VectorVelocity
		local Speed = VectorVelocity.Magnitude

		if Speed < 1 then
			return false
		end

		local VelocityDirection = VectorVelocity.Unit
		local Character = LocalPlayer.Character

		if not Character or not Character.PrimaryPart then
			return false
		end

		local CharacterPosition = Character.PrimaryPart.Position
		local Alignment = (CharacterPosition - Ball.Position).Unit:Dot(VelocityDirection)
		local PingSeconds = StatsService.Network.ServerStatsItem["Data Ping"]:GetValue() / 1000
		local Distance = (CharacterPosition - Ball.Position).Magnitude
		local TimeToImpact = Distance / Speed - PingSeconds
		local Threshold = math.clamp(0.55 - PingSeconds * 0.75, -1, 0.45)
		local SpeedFactor = math.min(Speed / 100, 45)
		local MinDistance = 15 - math.min(Distance / 1000, 15) + SpeedFactor
		local ClampedAlignment = math.clamp(Alignment, -1, 1)
		local AlignmentRadians = math.asin(ClampedAlignment)
		local PreviousLerpRadians = BallProperties.__lerp_radians
		BallProperties.__lerp_radians = PreviousLerpRadians + (AlignmentRadians - PreviousLerpRadians) * 0.85

		if BallProperties.__lerp_radians < 0.016 then
			BallProperties.__last_warping = tick()
		end

		if Distance < MinDistance * 0.85 then
			return false
		end

		if tick() - BallProperties.__last_warping < TimeToImpact / 1.4 then
			return true
		end

		if tick() - BallProperties.__curving < TimeToImpact / 1.1 then
			return true
		end

		return Alignment < Threshold
	end

	ReplicatedStorageService.Remotes.DeathBall.OnClientEvent:Connect(function(_, State)
		Hub.__properties.__deathslash_active = State or false
	end)

	ReplicatedStorageService.Remotes.InfinityBall.OnClientEvent:Connect(function(_, State)
		Hub.__properties.__infinity_active = State or false
	end)

	ReplicatedStorageService.Packages._Index["sleitnick_net@0.1.0"].net["RE/TimeHoleActivate"].OnClientEvent:Connect(function(...)
		local Activator = ({...})[1]
		if Activator == LocalPlayer or Activator == LocalPlayer.Name or Activator and Activator.Name == LocalPlayer.Name then
			Hub.__properties.__timehole_active = true
		end
	end)

	ReplicatedStorageService.Packages._Index["sleitnick_net@0.1.0"].net["RE/TimeHoleDeactivate"].OnClientEvent:Connect(function()
		Hub.__properties.__timehole_active = false
	end)

	local MaxSlashesOfFuryParries = 36
	local SlashesOfFuryParryDelay = 0.05

	ReplicatedStorageService.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryActivate"].OnClientEvent:Connect(function(...)
		local Activator = ({...})[1]
		if Activator == LocalPlayer or Activator == LocalPlayer.Name or Activator and Activator.Name == LocalPlayer.Name then
			Hub.__properties.__slashesoffury_active = true
			Hub.__properties.__slashesoffury_count = 0
		end
	end)

	ReplicatedStorageService.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryEnd"].OnClientEvent:Connect(function()
		Hub.__properties.__slashesoffury_active = false
		Hub.__properties.__slashesoffury_count = 0
	end)

	ReplicatedStorageService.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryParry"].OnClientEvent:Connect(function()
		Hub.__properties.__slashesoffury_count = Hub.__properties.__slashesoffury_count + 1
	end)

	ReplicatedStorageService.Packages._Index["sleitnick_net@0.1.0"].net["RE/SlashesOfFuryCatch"].OnClientEvent:Connect(function()
		task.spawn(function()
			while Hub.__properties.__slashesoffury_active and Hub.__properties.__slashesoffury_count < MaxSlashesOfFuryParries do
				if Hub.__config.__detections.__slashesoffury then
					Hub.parry.execute()
					task.wait(SlashesOfFuryParryDelay)
				else
					break
				end
			end
		end)
	end)

	Runtime.ChildAdded:Connect(function(Child)
		local StepResult = Hub.__config
		if StepResult.__detections.__phantom then
			local ChildName = Child.Name
			StepResult = "maxTransmission"
			local IsTransmissionPart = ChildName == "maxTransmission"

			if not IsTransmissionPart then
				local ChildNameAlt = Child.Name
				StepResult = "transmissionpart"
				IsTransmissionPart = ChildNameAlt == "transmissionpart"
			end

			if IsTransmissionPart then
				StepResult = "WeldConstraint"
				local WeldConstraint = Child:FindFirstChildWhichIsA("WeldConstraint")

				if WeldConstraint then
					local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
					StepResult = Character and WeldConstraint.Part1 == Character.HumanoidRootPart

					if StepResult then
						StepResult = Hub.ball.get()
						WeldConstraint:Destroy()

						if StepResult then
							local Connection

							Connection = RunService.RenderStepped:Connect(function()
								local Highlighted = StepResult:GetAttribute("highlighted")
								if Highlighted == true then
									ReplicatedStorageService.Remotes.AbilityButtonPress:Fire()
									Hub.__properties.__parried = true

									task.delay(1, function()
										Hub.__properties.__parried = false
									end)
								elseif Highlighted == false then
									Connection:Disconnect()
								end
							end)

							task.delay(3, function()
								if Connection and Connection.Connected then
									Connection:Disconnect()
								end
							end)
						end
					end
				end
			end
		end
	end)

	ReplicatedStorageService.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(_, Target)
		if Target.Parent and Target.Parent ~= LocalPlayer.Character then
			if not AliveFolder or Target.Parent.Parent ~= AliveFolder then
				return
			end
		end

		local ClosestPlayer = Hub.player.get_closest()
		local Ball = Hub.ball.get()

		if not Ball or not ClosestPlayer then
			return
		end

		local PlayerDistance = (LocalPlayer.Character.PrimaryPart.Position - ClosestPlayer.PrimaryPart.Position).Magnitude
		local BallDistance = (LocalPlayer.Character.PrimaryPart.Position - Ball.Position).Magnitude
		local DotProduct = (LocalPlayer.Character.PrimaryPart.Position - Ball.Position).Unit:Dot(Ball.AssemblyLinearVelocity.Unit)
		local IsCurved = Hub.detection.is_curved()

		if PlayerDistance < 15 and BallDistance < 15 and DotProduct > -0.25 then
			if IsCurved then
				Hub.parry.execute_action()
			end
		end

		if Hub.__properties.__grab_animation then
			Hub.__properties.__grab_animation:Stop()
		end
	end)

	ReplicatedStorageService.Remotes.ParrySuccess.OnClientEvent:Connect(function()
		if not AliveFolder or LocalPlayer.Character.Parent ~= AliveFolder then
			return
		end
		if Hub.__properties.__grab_animation then
			Hub.__properties.__grab_animation:Stop()
		end
	end)

	ReplicatedStorageService.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(_, Parrier)
		local LocalPrimaryPart = LocalPlayer.Character.PrimaryPart
		local Ball = Hub.ball.get()

		if not Ball then
			return
		end

		local Zoomies = Ball:FindFirstChild("zoomies")

		if not Zoomies then
			return
		end

		local Speed = Zoomies.VectorVelocity.Magnitude
		local Distance = (LocalPlayer.Character.PrimaryPart.Position - Ball.Position).Magnitude
		local Ping = StatsService.Network.ServerStatsItem["Data Ping"]:GetValue()
		local SpeedFactor = math.min(Speed / 100, 40)
		local TimeToImpact = Distance / Speed - Ping / 1000
		local IsMoving = Speed > 1
		local Threshold = 15 - math.min(Distance / 1000, 15) + SpeedFactor

		if IsMoving and TimeToImpact > Ping / 10 then
			Threshold = math.max(Threshold - 15, 15)
		end

		if Parrier ~= LocalPrimaryPart and Distance > Threshold then
			Hub.detection.__ball_properties.__curving = tick()
		end
	end)

	local ThunderDash = {}

	function ThunderDash:Enable()
		if Hub.__properties.__thunder_dash_enabled then
			return
		end

		Hub.__properties.__thunder_dash_enabled = true
		local Abilities = ReplicatedStorageService:WaitForChild("Shared"):WaitForChild("Abilities")

		local function ZeroCooldown(AbilityModule)
			local Success, Result = pcall(require, AbilityModule)
			if Success and Result then
				if Result.cooldown ~= nil then
					Result.cooldown = 0
				end
				if Result.cooldownReductionPerUpgrade ~= nil then
					Result.cooldownReductionPerUpgrade = 0
				end
			end
		end

		for _, Child in ipairs(Abilities:GetChildren()) do
			ZeroCooldown(Child)
		end

		Abilities.ChildAdded:Connect(ZeroCooldown)
	end

	function ThunderDash:Disable()
		Hub.__properties.__thunder_dash_enabled = false
	end

	Hub.triggerbot = {}
	local TriggerbotBusy = false

	function Hub.triggerbot.trigger(_)
		if TriggerbotBusy or Hub.__triggerbot.__is_parrying then
			return
		end

		if Hub.__triggerbot.__parries > Hub.__triggerbot.__max_parries then
			return
		end

		if
			LocalPlayer.Character
			and LocalPlayer.Character.PrimaryPart
			and LocalPlayer.Character.PrimaryPart:FindFirstChild("SingularityCape")
		then
			return
		end

		TriggerbotBusy = true
		Hub.__triggerbot.__is_parrying = true
		Hub.__triggerbot.__parries = Hub.__triggerbot.__parries + 1
		Hub.parry.execute()

		if Hub.__properties.__play_animation then
			Hub.animation.play_grab_parry()
		end

		task.delay(0.2, function()
			TriggerbotBusy = false
			if Hub.__triggerbot.__parries > 0 then
				Hub.__triggerbot.__parries = Hub.__triggerbot.__parries - 1
			end
		end)

		task.spawn(function()
			local StartTime = tick()

			repeat
				RunService.Heartbeat:Wait()
			until tick() - StartTime >= 0.15 or not Hub.__triggerbot.__is_parrying

			Hub.__triggerbot.__is_parrying = false
		end)
	end

	function Hub.triggerbot.loop()
		if not Hub.__triggerbot.__enabled then
			return
		end

		if
			LocalPlayer.Character
			and LocalPlayer.Character.PrimaryPart
			and LocalPlayer.Character.PrimaryPart:FindFirstChild("SingularityCape")
		then
			return
		end

		local Balls = WorkspaceService:FindFirstChild("Balls")

		if not Balls then
			return
		end

		for _, Child in pairs(Balls:GetChildren()) do
			if Child:IsA("BasePart") and Child:GetAttribute("target") == LocalPlayer.Name then
				Hub.triggerbot.trigger(Child)
				break
			end
		end
	end

	function Hub.triggerbot.enable(Enabled)
		Hub.__triggerbot.__enabled = Enabled
		if Enabled then
			if not Hub.__properties.__connections.__triggerbot then
				Hub.__properties.__connections.__triggerbot = RunService.Heartbeat:Connect(Hub.triggerbot.loop)
			end
		else
			if Hub.__properties.__connections.__triggerbot then
				Hub.__properties.__connections.__triggerbot:Disconnect()
				Hub.__properties.__connections.__triggerbot = nil
			end

			Hub.__triggerbot.__is_parrying = false
			Hub.__triggerbot.__parries = 0
			TriggerbotBusy = false
		end
	end

	Hub.manual_spam = {}
	local SpamCoroutine
	local ManualSpamActive = false
	local ParriesThisWindow = 0
	local WindowTimer = 0
	local AnimationFixEnabled = true

	function Hub.manual_spam.start()
		Hub.manual_spam.stop()
		Hub.__properties.__manual_spam_enabled = true
		ManualSpamActive = true
		local Keypress = Hub.parry.keypress
		local Execute = Hub.parry.execute
		local PlayGrabParry = Hub.animation.play_grab_parry

		SpamCoroutine = coroutine.create(function()
			local LastTime = 0
			while Hub.__properties.__manual_spam_enabled do
				local Now = os.clock()

				if Now - LastTime >= 0.015 then
					LastTime = Now
					if getgenv().ManualSpamMode == "Keypress" then
						Keypress()
					else
						Execute()
						if getgenv().ManualSpamAnimationFix then
							PlayGrabParry()
						end
					end
				end

				coroutine.yield()
			end
		end)

		task.spawn(function()
			while Hub.__properties.__manual_spam_enabled and SpamCoroutine and coroutine.status(SpamCoroutine) ~= "dead" do
				coroutine.resume(SpamCoroutine)
				task.wait()
			end
		end)
	end

	function Hub.manual_spam.stop()
		Hub.__properties.__manual_spam_enabled = false
		ManualSpamActive = false
		SpamCoroutine = nil
	end

	RunService.Heartbeat:Connect(function(DeltaTime)
		WindowTimer = WindowTimer + DeltaTime

		if WindowTimer >= 0.1 then
			ParriesThisWindow = 0
			WindowTimer = 0
		end

		if ManualSpamActive and ParryRemote then
			pcall(function()
				FireParry(Hub.curve.get_cframe())
				ParriesThisWindow = ParriesThisWindow + 1
			end)
			if AnimationFixEnabled then
				Hub.animation.play_grab_parry()
			end
		end
	end)

	Hub.autoparry = {}

	function Hub.autoparry.start()
		if Hub.__properties.__connections.__autoparry then
			Hub.__properties.__connections.__autoparry:Disconnect()
		end
		Hub.__properties.__connections.__autoparry = RunService.PreSimulation:Connect(function()
			if
				not Hub.__properties.__autoparry_enabled
				or not LocalPlayer.Character
				or not LocalPlayer.Character.PrimaryPart
			then
				return
			end

			local AllBalls = Hub.ball.get_all()
			local MainBall = Hub.ball.get()
			local TrainingBall

			if WorkspaceService:FindFirstChild("TrainingBalls") then
				for _, Child in pairs(WorkspaceService.TrainingBalls:GetChildren()) do
					if Child:GetAttribute("realBall") then
						TrainingBall = Child
						break
					end
				end
			end

			for _, Ball in pairs(AllBalls) do
				if not (Hub.__triggerbot.__enabled or getgenv().BallVelocityAbove800 or not Ball) then
					local Zoomies = Ball:FindFirstChild("zoomies")
					if Zoomies then
						Ball:GetAttributeChangedSignal("target"):Once(function()
							Hub.__properties.__parried = false
						end)
						if not Hub.__properties.__parried then
							local Target = Ball:GetAttribute("target")
							local VectorVelocity = Zoomies.VectorVelocity
							local Distance = (LocalPlayer.Character.PrimaryPart.Position - Ball.Position).Magnitude
							local PingValue = StatsService.Network.ServerStatsItem["Data Ping"]:GetValue() / 10
							local PingFactor = math.clamp(PingValue / 10, 5, 17)
							local Speed = VectorVelocity.Magnitude
							local Divisor = (2.4 + math.min(math.max(Speed - 9.5, 0), 650) * 0.002) * Hub.__properties.__divisor_multiplier
							local ParryRange = PingFactor + math.max(Speed / Divisor, 9.5)
							local IsCurved = Hub.detection.is_curved()

							if Ball:FindFirstChild("AeroDynamicSlashVFX") then
								Ball.AeroDynamicSlashVFX:Destroy()
								Hub.__properties.__tornado_time = tick()
							end

							if Runtime:FindFirstChild("Tornado") then
								if tick() - Hub.__properties.__tornado_time < (Runtime.Tornado:GetAttribute("TornadoTime") or 1) + 0.314159 then
									continue
								end
							end

							if not (MainBall and MainBall:GetAttribute("target") == LocalPlayer.Name and IsCurved) then
								if not (Ball:FindFirstChild("ComboCounter") or LocalPlayer.Character.PrimaryPart:FindFirstChild("SingularityCape")) then
									if not (Hub.__config.__detections.__infinity and Hub.__properties.__infinity_active) then
										if not (Hub.__config.__detections.__deathslash and Hub.__properties.__deathslash_active) then
											if not (Hub.__config.__detections.__timehole and Hub.__properties.__timehole_active) then
												if not (Hub.__config.__detections.__slashesoffury and Hub.__properties.__slashesoffury_active) then
													if Target == LocalPlayer.Name and Distance <= ParryRange then
														if getgenv().AutoAbility then
															local UIGradient = LocalPlayer.PlayerGui.Hotbar.Ability.UIGradient
															if UIGradient and UIGradient.Offset.Y == 0.5 then
																if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Abilities") then
																	local Abilities = LocalPlayer.Character.Abilities
																	if
																		Abilities:FindFirstChild("Raging Deflection") and Abilities["Raging Deflection"].Enabled
																		or Abilities:FindFirstChild("Rapture") and Abilities.Rapture.Enabled
																		or Abilities:FindFirstChild("Calming Deflection") and Abilities["Calming Deflection"].Enabled
																		or Abilities:FindFirstChild("Aerodynamic Slash") and Abilities["Aerodynamic Slash"].Enabled
																		or Abilities:FindFirstChild("Fracture") and Abilities.Fracture.Enabled
																		or Abilities:FindFirstChild("Death Slash") and Abilities["Death Slash"].Enabled
																	then
																		Hub.__properties.__parried = true
																		ReplicatedStorageService.Remotes.AbilityButtonPress:Fire()
																		task.wait(2.432)
																		ReplicatedStorageService:WaitForChild("Remotes"):WaitForChild("DeathSlashShootActivation"):FireServer(true)
																		continue
																	end
																end
															end
														end
													end

													if Target == LocalPlayer.Name and Distance <= ParryRange then
														if getgenv().AutoParryMode == "Keypress" then
															Hub.parry.keypress()
														else
															Hub.parry.execute_action()
														end
														Hub.__properties.__parried = true
													end

													local WaitStart = tick()

													repeat
														RunService.Stepped:Wait()
													until tick() - WaitStart >= 1 or not Hub.__properties.__parried

													Hub.__properties.__parried = false
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end

			if TrainingBall then
				local TrainingZoomies = TrainingBall:FindFirstChild("zoomies")
				if TrainingZoomies then
					TrainingBall:GetAttributeChangedSignal("target"):Once(function()
						Hub.__properties.__training_parried = false
					end)
					if not Hub.__properties.__training_parried then
						local TrainingTarget = TrainingBall:GetAttribute("target")
						local TrainingVelocity = TrainingZoomies.VectorVelocity
						local TrainingDistance = LocalPlayer:DistanceFromCharacter(TrainingBall.Position)
						local TrainingSpeed = TrainingVelocity.Magnitude
						local TrainingPing = StatsService.Network.ServerStatsItem["Data Ping"]:GetValue() / 10
						local TrainingPingFactor = math.clamp(TrainingPing / 10, 5, 17)
						local TrainingDivisor = (2.4 + math.min(math.max(TrainingSpeed - 9.5, 0), 650) * 0.002) * Hub.__properties.__divisor_multiplier
						local TrainingRange = TrainingPingFactor + math.max(TrainingSpeed / TrainingDivisor, 9.5)

						if TrainingTarget == LocalPlayer.Name and TrainingDistance <= TrainingRange then
							if getgenv().AutoParryMode == "Keypress" then
								Hub.parry.keypress()
							else
								Hub.parry.execute_action()
							end

							Hub.__properties.__training_parried = true
							local TrainingWaitStart = tick()

							repeat
								RunService.Stepped:Wait()
							until tick() - TrainingWaitStart >= 1 or not Hub.__properties.__training_parried

							Hub.__properties.__training_parried = false
						end
					end
				end
			end
		end)
	end

	function Hub.autoparry.stop()
		if Hub.__properties.__connections.__autoparry then
			Hub.__properties.__connections.__autoparry:Disconnect()
			Hub.__properties.__connections.__autoparry = nil
		end
	end

	local CharacterCosmetics = {}

	function CharacterCosmetics.Korblox(Character)
		if not Character then
			return
		end

		local RightLeg = Character:FindFirstChild("Right Leg")

		if not RightLeg then
			return
		end

		if not RightLeg:FindFirstChild("KorbloxMesh") then
			for _, Child in RightLeg:GetChildren() do
				if Child:IsA("SpecialMesh") then
					Child:Destroy()
				end
			end

			local KorbloxMesh = Instance.new("SpecialMesh")
			KorbloxMesh.Name = "KorbloxMesh"
			KorbloxMesh.MeshId = "rbxassetid://902942096"
			KorbloxMesh.TextureId = "rbxassetid://902843398"
			KorbloxMesh.Offset = Vector3.new(0, 0.7, 0)
			KorbloxMesh.Parent = RightLeg
		end
	end

	function CharacterCosmetics.Restore_Leg(Character)
		if not Character then
			return
		end

		local RightLeg = Character:FindFirstChild("Right Leg")

		if not RightLeg then
			return
		end

		for _, Child in RightLeg:GetChildren() do
			if Child:IsA("SpecialMesh") then
				Child:Destroy()
			end
		end
	end

	function CharacterCosmetics.Headless(Character)
		if not Character then
			return
		end

		local Head = Character:FindFirstChild("Head")

		if not Head then
			return
		end

		Head.Transparency = 1

		for _, Child in Head:GetChildren() do
			if Child:IsA("Decal") or Child.Name == "face" then
				Child.Transparency = 1
			elseif Child:IsA("SpecialMesh") or Child:IsA("DataModelMesh") then
				if not Child:GetAttribute("OriginalScale") then
					Child:SetAttribute("OriginalScale", Child.Scale)
					Child.Scale = Vector3.new(0, 0, 0)
				end
			end
		end
	end

	function CharacterCosmetics.Restore_Head(Character)
		if not Character then
			return
		end

		local Head = Character:FindFirstChild("Head")

		if not Head then
			return
		end

		Head.Transparency = 0

		for _, Child in Head:GetChildren() do
			if Child:IsA("Decal") or Child.Name == "face" then
				Child.Transparency = 0
			elseif Child:IsA("SpecialMesh") or Child:IsA("DataModelMesh") then
				local OriginalScale = Child:GetAttribute("OriginalScale")
				if OriginalScale then
					Child.Scale = OriginalScale
					Child:SetAttribute("OriginalScale", nil)
				end
			end
		end
	end

	LocalPlayer.CharacterAdded:Connect(function(Character)
		task.wait(0.5)

		if Hub.__properties.__headless_enabled then
			CharacterCosmetics.Headless(Character)
		end

		if Hub.__properties.__korblox_enabled then
			CharacterCosmetics.Korblox(Character)
		end
	end)

	local MobileButtonData

	local function CreateMobileUiButton()
		if MobileButtonData then
			MobileButtonData.gui:Destroy()
		end

		local ScreenGui = Instance.new("ScreenGui")
		ScreenGui.Name = "AerisMobileUIButton"
		ScreenGui.ResetOnSpawn = false
		ScreenGui.IgnoreGuiInset = true
		ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		ScreenGui.DisplayOrder = 9999
		local TextButton = Instance.new("TextButton")
		TextButton.Size = UDim2.new(0, 55, 0, 55)
		TextButton.Position = UDim2.new(0.95, -27, 0.05, 0)
		TextButton.BackgroundColor3 = Color3.fromRGB(45, 20, 75)
		TextButton.BackgroundTransparency = 0.3
		TextButton.AnchorPoint = Vector2.new(0.5, 0.5)
		TextButton.Draggable = true
		TextButton.AutoButtonColor = true
		TextButton.ZIndex = 10000
		Instance.new("UICorner", TextButton).CornerRadius = UDim.new(1, 0)
		CreateAnimatedStroke(TextButton, 2)
		local TextLabel = Instance.new("TextLabel")
		TextLabel.Size = UDim2.new(1, 0, 1, 0)
		TextLabel.BackgroundTransparency = 1
		TextLabel.Text = "UI"
		TextLabel.Font = Enum.Font.GothamBold
		TextLabel.TextSize = 24
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.ZIndex = 10001
		TextLabel.Parent = TextButton

		TextButton.MouseButton1Click:Connect(function()
			Window:Minimize(not Window.Minimized)
		end)

		TextButton.Parent = ScreenGui
		ScreenGui.Parent = CoreGuiService
		MobileButtonData = {gui = ScreenGui, button = TextButton}
		return MobileButtonData
	end

	local function CreateMobileToggleButton(Text, YPosition, _)
		local ScreenGui = Instance.new("ScreenGui")
		ScreenGui.Name = "Aeris_" .. Text .. "_Mobile"
		ScreenGui.ResetOnSpawn = false
		ScreenGui.IgnoreGuiInset = true
		ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		local TextButton = Instance.new("TextButton")
		TextButton.Size = UDim2.new(0, 140, 0, 50)
		TextButton.Position = UDim2.new(0.5, -70, YPosition, 0)
		TextButton.BackgroundTransparency = 1
		TextButton.AnchorPoint = Vector2.new(0.5, 0)
		TextButton.Draggable = true
		TextButton.AutoButtonColor = false
		TextButton.ZIndex = 2
		local Frame = Instance.new("Frame")
		Frame.Size = UDim2.new(1, 0, 1, 0)
		Frame.BackgroundColor3 = Color3.fromRGB(45, 22, 75)
		Frame.BackgroundTransparency = 0.25
		Frame.Parent = TextButton
		Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)
		CreateAnimatedStroke(Frame, 1.5)
		local TextLabel = Instance.new("TextLabel")
		TextLabel.Size = UDim2.new(1, 0, 1, 0)
		TextLabel.BackgroundTransparency = 1
		TextLabel.Text = Text
		TextLabel.Font = Enum.Font.GothamBold
		TextLabel.TextSize = 16
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.ZIndex = 3
		TextLabel.Parent = TextButton
		TextButton.Parent = ScreenGui
		ScreenGui.Parent = CoreGuiService
		return {gui = ScreenGui, button = TextButton, text = TextLabel, bg = Frame}
	end

	local function LoadLastEquippedSword()
		local Config = {}

		pcall(function()
			if isfile and isfile("Aeris/auto_config.json") then
				local Decoded = HttpService:JSONDecode(readfile("Aeris/auto_config.json"))
				if type(Decoded) == "table" then
					Config = Decoded
				end
			end
		end)

		local Sword = Config["Skin.LastEquippedSword"]
		return type(Sword) == "string" and Sword or ""
	end

	getgenv().saveLastEquippedSword = function(SwordName)
		if type(SwordName) ~= "string" or SwordName == "" then
			return
		end

		local Config = {}

		pcall(function()
			if isfile and isfile("Aeris/auto_config.json") then
				local Decoded = HttpService:JSONDecode(readfile("Aeris/auto_config.json"))
				if type(Decoded) == "table" then
					Config = Decoded
				end
			end
		end)

		local ConfigAlias = Config
		ConfigAlias["Skin.LastEquippedSword"] = SwordName

		pcall(function()
			if isfolder and makefolder and not isfolder("Aeris") then
				makefolder("Aeris")
			end
			if writefile then
				writefile("Aeris/auto_config.json", HttpService:JSONEncode(ConfigAlias or {}))
			end
		end)
	end

	local LastEquippedSword = LoadLastEquippedSword()
	getgenv().skinChanger = getgenv().skinChanger or LastEquippedSword ~= ""
	getgenv().swordModel = type(getgenv().swordModel) == "string" and getgenv().swordModel ~= "" and getgenv().swordModel or LastEquippedSword
	getgenv().swordAnimations = type(getgenv().swordAnimations) == "string" and getgenv().swordAnimations ~= "" and getgenv().swordAnimations or LastEquippedSword
	getgenv().swordFX = type(getgenv().swordFX) == "string" and getgenv().swordFX ~= "" and getgenv().swordFX or LastEquippedSword

	task.spawn(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local Swords = ReplicatedStorage:WaitForChild("Shared", 9000000000):WaitForChild("ReplicatedInstances", 9000000000):WaitForChild("Swords", 9000000000)
		local SwordsModule = require(Swords)
		local SwordController

		task.spawn(function()
			while task.wait(0.25) and not SwordController do
				local Success, Result = pcall(getconnections, ReplicatedStorage.Remotes.FireSwordInfo.OnClientEvent)
				if Success and Result then
					for _, Connection in ipairs(Result) do
						if Connection.Function and islclosure and islclosure(Connection.Function) then
							local UpvaluesSuccess, Upvalues = pcall(getupvalues, Connection.Function)
							if UpvaluesSuccess and #Upvalues == 1 and type(Upvalues[1]) == "table" then
								SwordController = Upvalues[1]
								break
							end
						end
					end
				end
			end
		end)

		local function GetSlashName(SwordName)
			local Success, Result = pcall(function()
				return SwordsModule:GetSword(SwordName)
			end)
			return Success and Result and Result.SlashName or "SlashEffect"
		end

		local function RefreshSlashName()
			local FxName = getgenv().swordFX ~= "" and getgenv().swordFX or getgenv().swordModel
			if FxName ~= "" then
				getgenv().slashName = GetSlashName(FxName)
			else
				getgenv().slashName = "SlashEffect"
			end
		end

		RefreshSlashName()

		local function ApplySkin()
			if not getgenv().skinChanger or not LocalPlayer.Character then
				return
			end

			pcall(function()
				local EquipFunction = rawget(SwordsModule, "EquipSwordTo")
				if type(EquipFunction) == "function" then
					local EquipUpvalues = getupvalues(EquipFunction)
					for Index = 1, #EquipUpvalues do
						if type(EquipUpvalues[Index]) == "boolean" then
							setupvalue(EquipFunction, 1, false)
							break
						end
					end
				end
			end)

			pcall(function()
				SwordsModule:EquipSwordTo(LocalPlayer.Character, getgenv().swordModel)
			end)

			task.spawn(function()
				local Attempts = 0

				while not SwordController and Attempts < 20 do
					task.wait(0.5)
					Attempts = Attempts + 1
				end

				if not SwordController then
					return
				end

				pcall(function()
					if SwordController.SetSword then
						SwordController:SetSword(getgenv().swordAnimations ~= "" and getgenv().swordAnimations or getgenv().swordModel)
					end
				end)

				pcall(function()
					local FxName = getgenv().swordFX ~= "" and getgenv().swordFX or getgenv().swordModel

					if ReplicatedStorage.Remotes:FindFirstChild("FireSwordInfo") then
						ReplicatedStorage.Remotes.FireSwordInfo:FireServer(FxName)
					end

					if SwordController.currentSword ~= nil then
						pcall(function()
							SwordController.currentSword = FxName
						end)
					end

					if SwordController.SwordFX ~= nil then
						pcall(function()
							SwordController.SwordFX = FxName
						end)
					end
				end)
			end)
		end

		local HookedFunctions = {}

		task.spawn(function()
			local RemoteNames = {"ParrySuccessAll", "ParryAttempt", "ParrySuccess", "PlaySound", "PlayVisuals"}
			while task.wait(1) do
				for _, RemoteName in ipairs(RemoteNames) do
					local Remote = ReplicatedStorage.Remotes:FindFirstChild(RemoteName)
					if Remote and Remote:IsA("RemoteEvent") then
						local Success, Result = pcall(getconnections, Remote.OnClientEvent)
						if Success and type(Result) == "table" then
							for _, Connection in ipairs(Result) do
								local HandlerFunction = Connection.Function
								if HandlerFunction and not HookedFunctions[HandlerFunction] then
									HookedFunctions[HandlerFunction] = true
									Connection:Disable()

									local function ReplacementHandler(...)
										local Args = {...}
										local InvolvesLocalPlayer = false

										for _, Arg in ipairs(Args) do
											if tostring(Arg) == LocalPlayer.Name or typeof(Arg) == "Instance" and (Arg == LocalPlayer.Character or Arg == LocalPlayer) then
												InvolvesLocalPlayer = true
												break
											end
										end

										if InvolvesLocalPlayer and getgenv().skinChanger then
											local FxName = getgenv().swordFX ~= "" and getgenv().swordFX or getgenv().swordModel
											RefreshSlashName()
											local ModelReplaced = false
											local SlashReplaced = false

											for Index, Arg in ipairs(Args) do
												if type(Arg) == "string" then
													if
														FxName ~= ""
														and not SlashReplaced
														and (Arg:match("Slash") or Arg == "Default" or Arg:match("Effect"))
													then
														Args[Index] = getgenv().slashName
														SlashReplaced = true
													elseif FxName ~= "" and not ModelReplaced then
														local SwordExists = false

														pcall(function()
															if ReplicatedStorage.Shared.ReplicatedInstances.Swords:FindFirstChild(Arg) then
																SwordExists = true
															end
														end)

														local IsSword = SwordExists

														if not IsSword then
															local CurrentlyEquippedSword = LocalPlayer:GetAttribute("CurrentlyEquippedSword")
															IsSword = Arg == CurrentlyEquippedSword
														end

														if IsSword then
															Args[Index] = FxName
															ModelReplaced = true
														end
													end
												end
											end

											if FxName ~= "" and not SlashReplaced and type(Args[1]) == "string" then
												Args[1] = getgenv().slashName
											end

											if FxName ~= "" and not ModelReplaced and type(Args[3]) == "string" then
												Args[3] = FxName
											end
										end

										if setthreadidentity then
											pcall(setthreadidentity, 2)
										end

										pcall(HandlerFunction, unpack(Args))
									end

									HookedFunctions[ReplacementHandler] = true
									Remote.OnClientEvent:Connect(ReplacementHandler)
								end
							end
						end
					end
				end
			end
		end)

		getgenv().updateSword = function()
			RefreshSlashName()

			if getgenv().skinChanger and getgenv().swordModel ~= "" and getgenv().saveLastEquippedSword then
				getgenv().saveLastEquippedSword(getgenv().swordModel)
			end

			ApplySkin()
		end

		task.spawn(function()
			while task.wait(1) do
				if getgenv().skinChanger and getgenv().swordModel ~= "" then
					local Character = LocalPlayer.Character
					if Character then
						if LocalPlayer:GetAttribute("CurrentlyEquippedSword") ~= getgenv().swordModel then
							ApplySkin()
						end

						if not Character:FindFirstChild(getgenv().swordModel) then
							ApplySkin()
						end

						for _, Child in pairs(Character:GetChildren()) do
							if Child:IsA("Model") and Child.Name ~= getgenv().swordModel then
								Child:Destroy()
							end
							task.wait()
						end
					end
				end
			end
		end)

		LocalPlayer.CharacterAdded:Connect(function()
			if getgenv().skinChanger then
				getgenv().skinChanger = false

				if getgenv().setSkinChangerToggleUI then
					getgenv().setSkinChangerToggleUI(false)
				end

				task.wait(2)
				getgenv().skinChanger = true

				if getgenv().setSkinChangerToggleUI then
					getgenv().setSkinChangerToggleUI(true)
				end

				task.wait(0.5)

				pcall(function()
					getgenv().updateSword()
				end)
			end
		end)
	end)

	getgenv().skinChanger = false
	getgenv().skinChangerEnabled = false
	getgenv().swordModel = ""
	getgenv().swordAnimations = ""
	getgenv().swordFX = ""
	getgenv().slashName = "SlashEffect"

	local Keybinds = {
		autoParryKeyCode = Enum.KeyCode.LeftShift,
		manualSpamKeyCode = Enum.KeyCode.E,
		trigKeyCode = Enum.KeyCode.R,
		autoJumpKeyCode = Enum.KeyCode.J,
	}

	local AutoParrySection = Tabs.Rage:AddSection("Auto Parry", "shield")

	AutoParrySection:AddToggle("AutoParryToggle", {
		Title = "Auto Parry",
		Description = "Automatically parries incoming balls",
		Default = false,
		Callback = function(Value)
			Hub.__properties.__autoparry_enabled = Value
			Hub.__properties.__play_animation = Value

			if Value then
				Hub.autoparry.start()
			else
				Hub.autoparry.stop()
			end

			if getgenv().AutoParryNotify then
				WindUi:Notify({Title = "Auto Parry", Content = Value and "ON" or "OFF", Duration = 2})
			end
		end,
	})

	AutoParrySection:AddDropdown("ParryMode", {
		Title = "Parry Mode",
		Values = {"Remote", "Keypress"},
		Default = "Remote",
		Multi = false,
		Callback = function(Value)
			getgenv().AutoParryMode = Value
		end,
	})

	AutoParrySection:AddDropdown("ModeCurve", {
		Title = "Curve Mode",
		Values = CurveModeNames,
		Default = "Camera",
		Multi = false,
		Callback = function(Value)
			CurrentCurveMode = Value
			SelectedCurveMode = Value
		end,
	})

	AutoParrySection:AddToggle("RandomCurveMode", {
		Title = "Random Curve",
		Default = false,
		Callback = function(Value)
			if Value then
				if not Hub.__properties.__connections.__random_curve then
					Hub.__properties.__connections.__random_curve = RunService.PreSimulation:Connect(function()
						CurrentCurveMode = CurveModeNames[math.random(#CurveModeNames)]
					end)
				end
			else
				if Hub.__properties.__connections.__random_curve then
					Hub.__properties.__connections.__random_curve:Disconnect()
					Hub.__properties.__connections.__random_curve = nil
				end
				CurrentCurveMode = SelectedCurveMode
			end
		end,
	})

	AutoParrySection:AddSlider("ParryAccuracy", {
		Title = "Accuracy",
		Default = 50,
		Min = 1,
		Max = 100,
		Rounding = 1,
		Callback = function(Value)
			Hub.__properties.__accuracy = Value
			UpdateDivisorMultiplier()
		end,
	})

	AutoParrySection:AddToggle("RandomizeAccuracy", {
		Title = "Randomize Accuracy",
		Default = false,
		Callback = function(Value)
			Hub.__properties.__randomized_accuracy_enabled = Value
			if Value then
				RandomizeAccuracy()
			end
		end,
	})

	AutoParrySection:AddToggle("CooldownProtection", {
		Title = "Cooldown Protection",
		Default = false,
		Callback = function(Value)
			getgenv().CooldownProtection = Value
		end,
	})

	AutoParrySection:AddToggle("AutoAbility", {
		Title = "Auto Ability",
		Default = false,
		Callback = function(Value)
			getgenv().AutoAbility = Value
		end,
	})

	AutoParrySection:AddToggle("AutoParryNotify", {
		Title = "Notify",
		Default = false,
		Callback = function(Value)
			getgenv().AutoParryNotify = Value
		end,
	})

	local AutoCurveHotkeySection = Tabs.Rage:AddSection("AutoCurve Hotkey", "keyboard")

	AutoCurveHotkeySection:AddToggle("AutoCurveHotkey", {
		Title = "AutoCurve Hotkey",
		Default = false,
		Callback = function(Value)
			getgenv().AutoCurveHotkeyEnabled = Value
		end,
	})

	AutoCurveHotkeySection:AddToggle("AutoCurveHotkeyNotify", {
		Title = "Notify",
		Default = false,
		Callback = function(Value)
			getgenv().AutoCurveHotkeyNotify = Value
		end,
	})

	local TriggerbotSection = Tabs.Rage:AddSection("Triggerbot", "target")

	TriggerbotSection:AddToggle("TriggerbotToggle", {
		Title = "Triggerbot",
		Description = "Parries instantly when targeted",
		Default = false,
		Callback = function(Value)
			if Hub.__properties.__is_mobile then
				if Value then
					if not Hub.__properties.__mobile_guis.triggerbot then
						local MobileButton = CreateMobileToggleButton("Trigger", 0.65, Color3.fromRGB(180, 100, 255))
						Hub.__properties.__mobile_guis.triggerbot = MobileButton
						local TouchStartTime = 0
						local IsDragging = false

						MobileButton.button.InputBegan:Connect(function(Input)
							if Input.UserInputType == Enum.UserInputType.Touch then
								TouchStartTime = tick()
								IsDragging = false
							end
						end)

						MobileButton.button.InputChanged:Connect(function(Input)
							if Input.UserInputType == Enum.UserInputType.Touch and tick() - TouchStartTime > 0.1 then
								IsDragging = true
							end
						end)

						MobileButton.button.InputEnded:Connect(function(Input)
							if Input.UserInputType == Enum.UserInputType.Touch and not IsDragging then
								Hub.__properties.__triggerbot_enabled = not Hub.__properties.__triggerbot_enabled
								Hub.triggerbot.enable(Hub.__properties.__triggerbot_enabled)
								MobileButton.text.Text = Hub.__properties.__triggerbot_enabled and "ON" or "Trigger"
								MobileButton.text.TextColor3 = Hub.__properties.__triggerbot_enabled and Color3.fromRGB(200, 130, 255) or Color3.fromRGB(255, 255, 255)

								if getgenv().TriggerbotNotify then
									WindUi:Notify({
										Title = "Triggerbot",
										Content = Hub.__properties.__triggerbot_enabled and "ON" or "OFF",
										Duration = 2,
									})
								end
							end
						end)
					end
				else
					Hub.__properties.__triggerbot_enabled = false
					Hub.triggerbot.enable(false)
					local TriggerbotGui = Hub.__properties.__mobile_guis.triggerbot

					if TriggerbotGui and TriggerbotGui.gui then
						TriggerbotGui.gui:Destroy()
					end

					Hub.__properties.__mobile_guis.triggerbot = nil
				end
			else
				Hub.__properties.__triggerbot_enabled = Value
				Hub.triggerbot.enable(Value)

				if getgenv().TriggerbotNotify then
					WindUi:Notify({Title = "Triggerbot", Content = Value and "ON" or "OFF", Duration = 2})
				end
			end
		end,
	})

	TriggerbotSection:AddToggle("TriggerbotNotify", {
		Title = "Notify",
		Description = "Show notifications for Triggerbot",
		Default = false,
		Callback = function(Value)
			getgenv().TriggerbotNotify = Value
		end,
	})

	local InfinityDetectionSection = Tabs.Detection:AddSection("Infinity Detection", "infinity")

	InfinityDetectionSection:AddToggle("InfinityDetection", {
		Title = "Infinity Detection",
		Default = false,
		Callback = function(Value)
			Hub.__config.__detections.__infinity = Value
		end,
	})

	InfinityDetectionSection:AddToggle("InfinityNotify", {
		Title = "Notify",
		Default = false,
		Callback = function(Value)
			getgenv().InfinityNotify = Value
		end,
	})

	Tabs.Detection:AddSection("Death Slash Detection", "skull"):AddToggle("DeathSlashDetection", {
		Title = "Death Slash Detection",
		Default = false,
		Callback = function(Value)
			Hub.__config.__detections.__deathslash = Value
		end,
	})

	Tabs.Detection:AddSection("Time Hole Detection", "clock"):AddToggle("TimeHoleDetection", {
		Title = "Time Hole Detection",
		Default = false,
		Callback = function(Value)
			Hub.__config.__detections.__timehole = Value
		end,
	})

	local SlashesOfFuryDetectionSection = Tabs.Detection:AddSection("Slashes Of Fury Detection", "swords")

	SlashesOfFuryDetectionSection:AddToggle("SlashesOfFuryDetection", {
		Title = "Slashes Of Fury Detection",
		Default = false,
		Callback = function(Value)
			Hub.__config.__detections.__slashesoffury = Value
		end,
	})

	SlashesOfFuryDetectionSection:AddSlider("ParryDelay", {
		Title = "Parry Delay",
		Default = 0.05,
		Min = 0.05,
		Max = 0.25,
		Rounding = 2,
		Callback = function(Value)
			SlashesOfFuryParryDelay = Value
		end,
	})

	SlashesOfFuryDetectionSection:AddSlider("MaxParryCount", {
		Title = "Max Parry Count",
		Default = 35,
		Min = 1,
		Max = 35,
		Rounding = 0,
		Callback = function(Value)
			MaxSlashesOfFuryParries = Value
		end,
	})

	Tabs.Detection:AddSection("Anti-Phantom", "ghost"):AddToggle("AntiPhantom", {
		Title = "Anti-Phantom",
		Default = false,
		Callback = function(Value)
			Hub.__config.__detections.__phantom = Value
		end,
	})

	local ManualSpamSection = Tabs.Spam:AddSection("Manual Spam", "zap")

	ManualSpamSection:AddToggle("ManualSpamToggle", {
		Title = "Manual Spam",
		Description = "High-frequency parry spam",
		Default = false,
		Callback = function(Value)
			if Hub.__properties.__is_mobile then
				if Value then
					if not Hub.__properties.__mobile_guis.manual_spam then
						local MobileButton = CreateMobileToggleButton("Spam", 0.8, Color3.fromRGB(255, 255, 255))
						Hub.__properties.__mobile_guis.manual_spam = MobileButton
						local TouchStartTime = 0
						local IsDragging = false

						MobileButton.button.InputBegan:Connect(function(Input)
							if Input.UserInputType == Enum.UserInputType.Touch then
								TouchStartTime = tick()
								IsDragging = false
							end
						end)

						MobileButton.button.InputChanged:Connect(function(Input)
							if Input.UserInputType == Enum.UserInputType.Touch and tick() - TouchStartTime > 0.1 then
								IsDragging = true
							end
						end)

						MobileButton.button.InputEnded:Connect(function(Input)
							if Input.UserInputType == Enum.UserInputType.Touch and not IsDragging then
								Hub.__properties.__manual_spam_enabled = not Hub.__properties.__manual_spam_enabled

								if Hub.__properties.__manual_spam_enabled then
									Hub.manual_spam.start()
									MobileButton.text.Text = "ON"
									MobileButton.text.TextColor3 = Color3.fromRGB(200, 130, 255)
								else
									Hub.manual_spam.stop()
									MobileButton.text.Text = "Spam"
									MobileButton.text.TextColor3 = Color3.fromRGB(255, 255, 255)
								end

								if getgenv().ManualSpamNotify then
									WindUi:Notify({
										Title = "Manual Spam",
										Content = Hub.__properties.__manual_spam_enabled and "ON" or "OFF",
										Duration = 2,
									})
								end
							end
						end)
					end
				else
					Hub.__properties.__manual_spam_enabled = false
					Hub.manual_spam.stop()
					local ManualSpamGui = Hub.__properties.__mobile_guis.manual_spam

					if ManualSpamGui and ManualSpamGui.gui then
						ManualSpamGui.gui:Destroy()
					end

					Hub.__properties.__mobile_guis.manual_spam = nil
				end
			else
				Hub.__properties.__manual_spam_enabled = Value
				ManualSpamActive = Value

				if Value then
					Hub.manual_spam.start()
				else
					Hub.manual_spam.stop()
				end

				if getgenv().ManualSpamNotify then
					WindUi:Notify({Title = "Manual Spam", Content = Value and "ON" or "OFF", Duration = 2})
				end
			end
		end,
	})

	ManualSpamSection:AddToggle("ManualSpamNotify", {
		Title = "Notify",
		Description = "Show notifications for manual spam",
		Default = false,
		Callback = function(Value)
			getgenv().ManualSpamNotify = Value
		end,
	})

	ManualSpamSection:AddDropdown("ManualSpamMode", {
		Title = "Mode",
		Description = "Select spam method",
		Values = {"Remote", "Keypress"},
		Default = "Remote",
		Multi = false,
		Callback = function(Value)
			getgenv().ManualSpamMode = Value
		end,
	})

	ManualSpamSection:AddToggle("ManualSpamAnimationFix", {
		Title = "Animation Fix",
		Description = "Fix animation during spam",
		Default = false,
		Callback = function(Value)
			getgenv().ManualSpamAnimationFix = Value
			AnimationFixEnabled = Value
		end,
	})

	local BallStatsSection = Tabs.Visuals:AddSection("Ball Stats", "gauge")

	function Hub.create_ball_velocity_gui()
		if Hub.__properties.__ball_velocity_gui then
			Hub.__properties.__ball_velocity_gui.gui:Destroy()
		end

		local ScreenGui = Instance.new("ScreenGui")
		ScreenGui.Name = "AerisBallVelocityGUI"
		ScreenGui.ResetOnSpawn = false
		ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		ScreenGui.DisplayOrder = 999
		local Frame = Instance.new("Frame")
		Frame.Size = UDim2.new(0, 220, 0, 80)
		Frame.Position = UDim2.new(0, 10, 0.82, 0)
		Frame.BackgroundColor3 = Color3.fromRGB(40, 20, 68)
		Frame.BackgroundTransparency = 0.35
		Frame.BorderSizePixel = 0
		Frame.Active = true
		Frame.Selectable = true
		Frame.Draggable = true
		Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)
		CreateAnimatedStroke(Frame, 2)
		local TitleLabel = Instance.new("TextLabel")
		TitleLabel.Size = UDim2.new(1, 0, 0, 20)
		TitleLabel.Position = UDim2.new(0, 0, 0, 5)
		TitleLabel.BackgroundTransparency = 1
		TitleLabel.Text = "Aeris | Ball Status"
		TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TitleLabel.Font = Enum.Font.GothamBold
		TitleLabel.TextSize = 14
		TitleLabel.Parent = Frame
		local CurrentLabel = Instance.new("TextLabel")
		CurrentLabel.Size = UDim2.new(1, -10, 0, 25)
		CurrentLabel.Position = UDim2.new(0, 5, 0, 25)
		CurrentLabel.BackgroundTransparency = 1
		CurrentLabel.Text = "Current: 0"
		CurrentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		CurrentLabel.Font = Enum.Font.GothamBold
		CurrentLabel.TextSize = 16
		CurrentLabel.TextXAlignment = Enum.TextXAlignment.Left
		CurrentLabel.Parent = Frame
		local PeakLabel = Instance.new("TextLabel")
		PeakLabel.Size = UDim2.new(1, -10, 0, 25)
		PeakLabel.Position = UDim2.new(0, 5, 0, 50)
		PeakLabel.BackgroundTransparency = 1
		PeakLabel.Text = "Peak: 0"
		PeakLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		PeakLabel.Font = Enum.Font.GothamBold
		PeakLabel.TextSize = 16
		PeakLabel.TextXAlignment = Enum.TextXAlignment.Left
		PeakLabel.Parent = Frame
		Frame.Parent = ScreenGui
		ScreenGui.Parent = CoreGuiService
		Hub.__properties.__ball_velocity_gui = {gui = ScreenGui, frame = Frame, currentSpeedLabel = CurrentLabel, peakSpeedLabel = PeakLabel}
	end

	function Hub.update_ball_velocity()
		if not Hub.__properties.__ball_velocity_enabled or not Hub.__properties.__ball_velocity_gui then
			return
		end

		local Ball = Hub.ball.get()

		if not Ball then
			Hub.__properties.__ball_velocity_gui.currentSpeedLabel.Text = "Current: 0"
			return
		end

		local FullName = Ball:GetFullName()

		if FullName ~= Hub.__properties.__last_ball_id then
			Hub.__properties.__peak_velocity = 0
			Hub.__properties.__last_ball_id = FullName
		end

		local Zoomies = Ball:FindFirstChild("zoomies")

		if not Zoomies then
			Hub.__properties.__ball_velocity_gui.currentSpeedLabel.Text = "Current: 0"
			return
		end

		local Speed = Zoomies.VectorVelocity.Magnitude

		if Speed > Hub.__properties.__peak_velocity then
			Hub.__properties.__peak_velocity = Speed
		end

		local CurrentColor = Color3.fromRGB(210, 160, 255)

		if Speed > 2000 then
			CurrentColor = Color3.fromRGB(255, 80, 120)
		elseif Speed > 1500 then
			CurrentColor = Color3.fromRGB(255, 165, 0)
		end

		local PeakColor = Color3.fromRGB(210, 160, 255)

		if Hub.__properties.__peak_velocity > 2000 then
			PeakColor = Color3.fromRGB(255, 80, 120)
		elseif Hub.__properties.__peak_velocity > 1500 then
			PeakColor = Color3.fromRGB(255, 165, 0)
		end

		Hub.__properties.__ball_velocity_gui.currentSpeedLabel.RichText = true

		Hub.__properties.__ball_velocity_gui.currentSpeedLabel.Text = string.format(
			"Current: <font color='#%02x%02x%02x'>%.1f</font>",
			math.floor(CurrentColor.R * 255),
			math.floor(CurrentColor.G * 255),
			math.floor(CurrentColor.B * 255),
			Speed
		)

		Hub.__properties.__ball_velocity_gui.peakSpeedLabel.RichText = true

		Hub.__properties.__ball_velocity_gui.peakSpeedLabel.Text = string.format(
			"Peak: <font color='#%02x%02x%02x'>%.1f</font>",
			math.floor(PeakColor.R * 255),
			math.floor(PeakColor.G * 255),
			math.floor(PeakColor.B * 255),
			Hub.__properties.__peak_velocity
		)
	end

	BallStatsSection:AddToggle("BallVelocity", {
		Title = "Show Ball Velocity",
		Description = "Display ball velocity stats",
		Default = false,
		Callback = function(Value)
			Hub.__properties.__ball_velocity_enabled = Value
			if Value then
				Hub.create_ball_velocity_gui()

				if not Hub.__properties.__connections.__ball_velocity then
					Hub.__properties.__connections.__ball_velocity = RunService.RenderStepped:Connect(Hub.update_ball_velocity)
				end

				WindUi:Notify({Title = "Ball Stats", Content = "Activated", Duration = 2})
			else
				if Hub.__properties.__ball_velocity_gui then
					Hub.__properties.__ball_velocity_gui.gui:Destroy()
					Hub.__properties.__ball_velocity_gui = nil
				end

				if Hub.__properties.__connections.__ball_velocity then
					Hub.__properties.__connections.__ball_velocity:Disconnect()
					Hub.__properties.__connections.__ball_velocity = nil
				end

				Hub.__properties.__peak_velocity = 0
				Hub.__properties.__last_ball_id = nil
				WindUi:Notify({Title = "Ball Stats", Content = "Deactivated", Duration = 2})
			end
		end,
	})

	local PingScreenGui = Instance.new("ScreenGui", CoreGuiService)
	PingScreenGui.Name = "AerisRealPing"
	PingScreenGui.ResetOnSpawn = false
	PingScreenGui.IgnoreGuiInset = true
	PingScreenGui.DisplayOrder = 999
	PingScreenGui.Enabled = false
	local PingFrame = Instance.new("Frame", PingScreenGui)
	PingFrame.Size = UDim2.new(0, 110, 0, 35)
	PingFrame.Position = UDim2.new(0, 15, 0.88, 0)
	PingFrame.BackgroundColor3 = Color3.fromRGB(40, 20, 68)
	PingFrame.BackgroundTransparency = 0.3
	PingFrame.BorderSizePixel = 0
	PingFrame.Active = true
	PingFrame.Draggable = true
	Instance.new("UICorner", PingFrame).CornerRadius = UDim.new(0, 8)
	CreateAnimatedStroke(PingFrame, 1.5)
	local PingLabel = Instance.new("TextLabel", PingFrame)
	PingLabel.Size = UDim2.new(1, 0, 1, 0)
	PingLabel.Text = "Ping: 0ms"
	PingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	PingLabel.BackgroundTransparency = 1
	PingLabel.Font = Enum.Font.GothamBold
	PingLabel.TextSize = 14
	PingLabel.TextXAlignment = Enum.TextXAlignment.Center

	BallStatsSection:AddToggle("ShowPing", {
		Title = "Show Real Ping",
		Description = "Shows your current ping",
		Default = false,
		Callback = function(Value)
			PingScreenGui.Enabled = Value
			if Value then
				WindUi:Notify({Title = "Real Ping", Content = "Activated", Duration = 2})
				task.spawn(function()
					while PingScreenGui.Enabled do
						task.wait(0.5)
						if PingScreenGui.Enabled and PingLabel then
							local PingValue = StatsService.Network.ServerStatsItem["Data Ping"]:GetValue()
							local PingColor = Color3.fromRGB(190, 140, 255)

							if PingValue > 150 then
								PingColor = Color3.fromRGB(255, 165, 0)
							elseif PingValue > 300 then
								PingColor = Color3.fromRGB(255, 0, 0)
							end

							PingLabel.Text = string.format(
								"Ping: <font color='#%02x%02x%02x'>%dms</font>",
								math.floor(PingColor.R * 255),
								math.floor(PingColor.G * 255),
								math.floor(PingColor.B * 255),
								PingValue
							)

							PingLabel.RichText = true
						end
					end
				end)
			else
				WindUi:Notify({Title = "Real Ping", Content = "Deactivated", Duration = 2})
			end
		end,
	})

	local AutoJumpEnabled = false
	local WasGrounded = false

	Tabs.Misc:AddSection("Auto Jump", "arrow-up"):AddToggle("AutoJump", {
		Title = "Auto Jump",
		Description = "Automatically jumps when grounded",
		Default = false,
		Callback = function(Value)
			AutoJumpEnabled = Value

			if not Value then
				WasGrounded = false
			end

			WindUi:Notify({Title = "Auto Jump", Content = Value and "Enabled" or "Disabled", Duration = 2})
		end,
	})

	RunService.Heartbeat:Connect(function()
		if AutoJumpEnabled then
			local Character = LocalPlayer.Character
			local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

			if Humanoid then
				local IsGrounded = Humanoid.FloorMaterial ~= Enum.Material.Air

				if IsGrounded and not WasGrounded then
					Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end

				WasGrounded = IsGrounded
			end
		else
			WasGrounded = false
		end
	end)

	local HeadlessKorbloxSection = Tabs.Misc:AddSection("Headless & Korblox", "user")

	HeadlessKorbloxSection:AddToggle("HeadlessToggle", {
		Title = "Headless",
		Description = "Makes your character headless",
		Default = false,
		Callback = function(Value)
			Hub.__properties.__headless_enabled = Value
			local Character = LocalPlayer.Character

			if Character then
				if Value then
					CharacterCosmetics.Headless(Character)
				else
					CharacterCosmetics.Restore_Head(Character)
				end
			end

			WindUi:Notify({Title = "Headless", Content = Value and "Enabled" or "Disabled", Duration = 2})
		end,
	})

	HeadlessKorbloxSection:AddToggle("KorbloxToggle", {
		Title = "Korblox",
		Description = "Gives you Korblox leg",
		Default = false,
		Callback = function(Value)
			Hub.__properties.__korblox_enabled = Value
			local Character = LocalPlayer.Character

			if Character then
				if Value then
					CharacterCosmetics.Korblox(Character)
				else
					CharacterCosmetics.Restore_Leg(Character)
				end
			end

			WindUi:Notify({Title = "Korblox", Content = Value and "Enabled" or "Disabled", Duration = 2})
		end,
	})

	Tabs.Misc:AddSection("Thunder Dash", "zap"):AddToggle("ThunderDashToggle", {
		Title = "Thunder Dash",
		Description = "Removes all ability cooldowns (Infinite Thunder Dash)",
		Default = false,
		Callback = function(Value)
			if Value then
				ThunderDash:Enable()
				WindUi:Notify({Title = "Thunder Dash", Content = "Enabled - Infinite Abilities!", Duration = 3})
			else
				ThunderDash:Disable()
				WindUi:Notify({Title = "Thunder Dash", Content = "Disabled", Duration = 2})
			end
		end,
	})

	local SkinChangerSection = Tabs.Misc:AddSection("Skin Changer", "sword")

	local SkinChangerToggle = SkinChangerSection:AddToggle("SkinChanger", {
		Title = "Skin Changer",
		Description = "Changes your sword skin",
		Default = false,
		Callback = function(Value)
			getgenv().skinChanger = Value
			getgenv().skinChangerEnabled = Value

			if Value and getgenv().swordModel ~= "" then
				if getgenv().updateSword then
					pcall(getgenv().updateSword)
				end
				WindUi:Notify({Title = "Skin Changer", Content = "Enabled", Duration = 2})
			elseif not Value then
				WindUi:Notify({Title = "Skin Changer", Content = "Disabled", Duration = 2})
			end
		end,
	})

	getgenv().setSkinChangerToggleUI = function(SkinChangerEnabled)
		if SkinChangerToggle and SkinChangerToggle.Value ~= SkinChangerEnabled then
			SkinChangerToggle:SetValue(SkinChangerEnabled)
			getgenv().skinChanger = SkinChangerEnabled
			getgenv().skinChangerEnabled = SkinChangerEnabled
		end
	end

	SkinChangerSection:AddInput("SwordName", {
		Title = "Sword Name",
		Placeholder = "Enter sword name (e.g. DualPrince)...",
		Default = "",
		Callback = function(Value)
			getgenv().swordModel = Value
			getgenv().swordAnimations = Value
			getgenv().swordFX = Value

			if getgenv().skinChanger and Value ~= "" and getgenv().updateSword then
				pcall(getgenv().updateSword)
			end

			if getgenv().saveLastEquippedSword then
				pcall(getgenv().saveLastEquippedSword, Value)
			end
		end,
	})

	SkinChangerSection:AddToggle("SaveLastSword", {
		Title = "Save Last Equipped Sword",
		Description = "Auto-loads your last sword on inject",
		Default = true,
		Callback = function(Value)
			getgenv().autoLoadLastSword = Value
		end,
	})

	local NoRenderSection = Tabs.Misc:AddSection("No Render", "eye-off")
	local RenderConnections = {}

	NoRenderSection:AddToggle("NoRender", {
		Title = "No Render",
		Default = false,
		Callback = function(Value)
			local EffectScripts = LocalPlayer.PlayerScripts:FindFirstChild("EffectScripts")

			if EffectScripts then
				local ClientFX = EffectScripts:FindFirstChild("ClientFX")
				if ClientFX then
					ClientFX.Disabled = Value
				end
			end

			if Value then
				RenderConnections["No Render"] = WorkspaceService.Runtime.ChildAdded:Connect(function(Child)
					DebrisService:AddItem(Child, 0)
				end)
			elseif RenderConnections["No Render"] then
				RenderConnections["No Render"]:Disconnect()
				RenderConnections["No Render"] = nil
			end
		end,
	})

	local KeybindsSection = Tabs.Settings:AddSection("Keybinds", "keyboard")

	KeybindsSection:AddKeybind("ManualSpamKeybind", {
		Title = "Manual Spam Key",
		Description = "Toggle Manual Spam",
		Default = "E",
		Callback = function() end,
		ChangedCallback = function(Key)
			local KeyString = tostring(Key)
			if KeyString and KeyString ~= "" then
				local KeyName = KeyString:match("Enum%.KeyCode%.(.+)") or KeyString
				local KeyCode = Enum.KeyCode[KeyName]

				if KeyCode then
					Keybinds.manualSpamKeyCode = KeyCode
					WindUi:Notify({Title = "Manual Spam Key", Content = KeyName, Duration = 2})
				end
			end
		end,
	})

	KeybindsSection:AddKeybind("TriggerKeybind", {
		Title = "Trigger Key",
		Description = "Toggle Triggerbot",
		Default = "R",
		Callback = function() end,
		ChangedCallback = function(Key)
			local KeyString = tostring(Key)
			if KeyString and KeyString ~= "" then
				local KeyName = KeyString:match("Enum%.KeyCode%.(.+)") or KeyString
				local KeyCode = Enum.KeyCode[KeyName]

				if KeyCode then
					Keybinds.trigKeyCode = KeyCode
					WindUi:Notify({Title = "Trigger Key", Content = KeyName, Duration = 2})
				end
			end
		end,
	})

	KeybindsSection:AddKeybind("AutoJumpKeybind", {
		Title = "Auto Jump Key",
		Description = "Toggle Auto Jump",
		Default = "J",
		Callback = function() end,
		ChangedCallback = function(Key)
			local KeyString = tostring(Key)
			if KeyString and KeyString ~= "" then
				local KeyName = KeyString:match("Enum%.KeyCode%.(.+)") or KeyString
				local KeyCode = Enum.KeyCode[KeyName]

				if KeyCode then
					Keybinds.autoJumpKeyCode = KeyCode
					WindUi:Notify({Title = "Auto Jump Key", Content = KeyName, Duration = 2})
				end
			end
		end,
	})

	KeybindsSection:AddKeybind("AutoParryKeybind", {
		Title = "Auto Parry Key",
		Description = "Toggle Auto Parry",
		Default = "LeftShift",
		Callback = function() end,
		ChangedCallback = function(Key)
			local KeyString = tostring(Key)
			if KeyString and KeyString ~= "" then
				local KeyName = KeyString:match("Enum%.KeyCode%.(.+)") or KeyString
				local KeyCode = Enum.KeyCode[KeyName]

				if KeyCode then
					Keybinds.autoParryKeyCode = KeyCode
					WindUi:Notify({Title = "Auto Parry Key", Content = KeyName, Duration = 2})
				end
			end
		end,
	})

	UserInputService.InputBegan:Connect(function(Input, GameProcessed)
		if GameProcessed then
			return
		end

		local KeyCode = Input.KeyCode
		local CurveKeyMap = {}
		CurveKeyMap[Enum.KeyCode.One] = "Camera"
		CurveKeyMap[Enum.KeyCode.Two] = "Random"
		CurveKeyMap[Enum.KeyCode.Three] = "Accelerated"
		CurveKeyMap[Enum.KeyCode.Four] = "Backwards"
		CurveKeyMap[Enum.KeyCode.Five] = "Slow"
		CurveKeyMap[Enum.KeyCode.Six] = "High"
		CurveKeyMap[Enum.KeyCode.Seven] = "Normal"
		CurveKeyMap[Enum.KeyCode.Eight] = "Speed"
		CurveKeyMap[Enum.KeyCode.Nine] = "Down"

		if CurveKeyMap[KeyCode] then
			CurrentCurveMode = CurveKeyMap[KeyCode]
			SelectedCurveMode = CurveKeyMap[KeyCode]

			if getgenv().AutoCurveHotkeyNotify then
				WindUi:Notify({Title = "Curve Mode", Content = CurveKeyMap[KeyCode], Duration = 1})
			end
		end

		if KeyCode == Keybinds.manualSpamKeyCode then
			Hub.__properties.__manual_spam_enabled = not Hub.__properties.__manual_spam_enabled
			ManualSpamActive = Hub.__properties.__manual_spam_enabled

			if ManualSpamActive then
				Hub.manual_spam.start()
			else
				Hub.manual_spam.stop()
			end

			if getgenv().ManualSpamNotify then
				WindUi:Notify({Title = "Manual Spam", Content = ManualSpamActive and "ON" or "OFF", Duration = 1})
			end
		end

		if KeyCode == Keybinds.trigKeyCode then
			local Enabled = not Hub.__properties.__triggerbot_enabled
			Hub.__properties.__triggerbot_enabled = Enabled
			Hub.triggerbot.enable(Enabled)

			if getgenv().TriggerbotNotify then
				WindUi:Notify({Title = "Triggerbot", Content = Enabled and "ON" or "OFF", Duration = 1})
			end
		end

		if KeyCode == Keybinds.autoParryKeyCode then
			Hub.__properties.__autoparry_enabled = not Hub.__properties.__autoparry_enabled
			Hub.__properties.__play_animation = Hub.__properties.__autoparry_enabled

			if Hub.__properties.__autoparry_enabled then
				Hub.autoparry.start()
			else
				Hub.autoparry.stop()
			end

			if getgenv().AutoParryNotify then
				WindUi:Notify({
					Title = "Auto Parry",
					Content = Hub.__properties.__autoparry_enabled and "ON" or "OFF",
					Duration = 1,
				})
			end
		end

		if KeyCode == Keybinds.autoJumpKeyCode then
			AutoJumpEnabled = not AutoJumpEnabled

			if not AutoJumpEnabled then
				WasGrounded = false
			end

			WindUi:Notify({Title = "Auto Jump", Content = AutoJumpEnabled and "ON" or "OFF", Duration = 1})
		end
	end)

	if Hub.__properties.__is_mobile then
		task.spawn(function()
			task.wait(2)
			CreateMobileUiButton()
		end)
	end

	WindUi:Notify({Title = "Aeris Hub", Content = "Loaded successfully! Block once manually first.", Duration = 8})
	print("Aeris Hub Loaded!")
end)
