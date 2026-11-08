-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf

local notifyExport, result2, result3, instance3, instance4 = loadstring(game:HttpGet("https://raw.githubusercontent.com/gilgameshfate59/ohbfoosk8tid/main/CitraUI.lua"))().Shim:Init({
	Name = "Azure Latch",
	SubName = "Blue Lock | Citra Hub",
	Accent = Color3.fromRGB(255, 138, 32),
	ShowTabIcons = false,
})

local instance5 = notifyExport:CreateWindow({
	Title = "Citra Hub | Azure Latch",
	Center = true,
	AutoShow = true,
	TabPaddingX = 8,
	MenuFadeTime = 0.2,
})

notifyExport.ToggleKeybind = Enum.KeyCode.RightAlt
local prefix = 0

local function exampleUsage(x)
	prefix += 1
	local sourceString = tostring(x):gsub("%W", "")
	local query = "_" .. prefix
	return sourceString:sub(1, 40) .. query
end

local function Scheduler(x)
	local iteration = tonumber(x) or 1
	if iteration >= 1 then
		return 0
	end
	return math.max(0, math.ceil(-math.log10(iteration)))
end

local function func(x, playerIdentifier)
	local decoded, model = pcall(function()
		return x.Items.Content.Instance
	end)

	if not decoded or not model then
		return
	end
	local array = model:GetChildren()
	local container = array[#array]
	if not container then
		return
	end

	for _, descendant in ipairs(container:GetDescendants()) do
		if descendant:IsA("TextLabel") and descendant.Text == playerIdentifier then
			descendant.TextWrapped = true
			descendant.TextXAlignment = Enum.TextXAlignment.Left
			descendant.AutomaticSize = Enum.AutomaticSize.Y
			descendant.Size = UDim2.new(1, -(descendant.Position.X.Offset + 12), 0, 0)
			return
		end
	end
end

local function createNode(x)
	local function generateRandomArray(playerIdentifier, deltaTime)
		if type(playerIdentifier) == "function" then
			return nil, playerIdentifier
		end
		return playerIdentifier, deltaTime
	end

	return {
		Label = function(playerIdentifier, deltaTime)
			local sourceString = tostring(deltaTime)
			x:AddLabel(sourceString)
			pcall(func, x._sec, sourceString)
			return playerIdentifier
		end,
		Banner = function(playerIdentifier)
			return playerIdentifier
		end,
		Button = function(playerIdentifier, deltaTime, playerId, source)
			local container, header = generateRandomArray(playerId, source)
			x:AddButton({ Text = deltaTime, Tooltip = container, Func = header })
			return playerIdentifier
		end,
		Toggle = function(playerIdentifier, deltaTime, playerId, source)
			local container, header = generateRandomArray(playerId, source)
			local instance6 = exampleUsage(deltaTime)
			x:AddToggle(instance6, { Text = deltaTime, Default = false, Tooltip = container })

			if header and result2[instance6] then
				result2[instance6]:OnChanged(header)
			end

			return playerIdentifier
		end,
		Slider = function(playerIdentifier, deltaTime, playerId, source, callback, entity, duration)
			local container = exampleUsage(deltaTime)
			x:AddSlider(container, { Text = deltaTime, Default = playerId, Min = source, Max = callback, Rounding = Scheduler(entity) })

			if duration and result3[container] then
				result3[container]:OnChanged(duration)
			end

			return playerIdentifier
		end,
		Dropdown = function(playerIdentifier, deltaTime, playerId, source)
			local container = exampleUsage(deltaTime)
			x:AddDropdown(container, { Text = deltaTime, Values = playerId, Multi = false })

			if source and result3[container] then
				result3[container]:OnChanged(source)
			end

			return playerIdentifier
		end,
		Textbox = function(playerIdentifier, deltaTime, playerId, source)
			local container = exampleUsage(deltaTime)
			x:AddInput(container, { Text = deltaTime, Placeholder = playerId, Default = "" })

			if source and result3[container] then
				result3[container]:OnChanged(source)
			end

			return playerIdentifier
		end,
	}
end

local function generateRandomArray(x)
	local function lerp(playerIdentifier)
		if not playerIdentifier._base then
			playerIdentifier._base = playerIdentifier:Folder(x)
		end

		return playerIdentifier._base
	end

	return {
		_page = instance5:AddTab(x),
		_n = 0,
		Folder = function(playerIdentifier, deltaTime)
			playerIdentifier._n = playerIdentifier._n + 1
			return createNode(playerIdentifier._n % 2 == 1 and playerIdentifier._page:AddLeftGroupbox(deltaTime) or playerIdentifier._page:AddRightGroupbox(deltaTime))
		end,
		Label = function(playerIdentifier, ...)
			return lerp(playerIdentifier):Label(...)
		end,
		Button = function(playerIdentifier, ...)
			return lerp(playerIdentifier):Button(...)
		end,
		Toggle = function(playerIdentifier, ...)
			return lerp(playerIdentifier):Toggle(...)
		end,
		Slider = function(playerIdentifier, ...)
			return lerp(playerIdentifier):Slider(...)
		end,
		Dropdown = function(playerIdentifier, ...)
			return lerp(playerIdentifier):Dropdown(...)
		end,
		Textbox = function(playerIdentifier, ...)
			return lerp(playerIdentifier):Textbox(...)
		end,
		Banner = function(playerIdentifier)
			return playerIdentifier
		end,
	}
end

local queue = { Create = function()
	return { Tab = function(x, playerIdentifier)
		return generateRandomArray(playerIdentifier)
	end }
end }

local function lerp()
	local bottomTween = queue:Create({
		Name = "Azure Latch",
		ThemeColor = Color3.fromRGB(111, 111, 111),
		ThemeGradient = Color3.fromRGB(10, 10, 10),
		StartupSound = "rbxassetid://6958727243",
		ThemeFont = Enum.Font.GothamBold,
		ToggledSideBar = true,
	})

	local instance = bottomTween:Tab("Blatant")
	local node = bottomTween:Tab("Silent")
	local result = bottomTween:Tab("Movesets")
	local part = bottomTween:Tab("Teleports")
	part:Label("Map Teleports, No Prerequisites To Use!")
	local sorter = {}
	loadstring(game:HttpGet("https://pastebin.com/raw/8XJh7dzh"))()

	repeat
		task.wait()
	until game.Lighting:FindFirstChild("BUFFERSTRINGS")

	local container = ipairs
	local folder = game.Lighting:FindFirstChild("BUFFERSTRINGS")

	for _, child in container(folder:GetChildren()) do
		sorter[child.Name] = child.Value
	end

	game.Lighting:FindFirstChild("BUFFERSTRINGS"):Destroy()
	local xString = game:GetService("ReplicatedStorage"):WaitForChild("BytenetStorage"):WaitForChild("Networking").Value:match("\"bytenet_selectRole\"%s*:%s*(%d+)")
	local header = string.char(xString and tonumber(xString))
	local Players = game:GetService("Players")
	game:GetService("ReplicatedStorage")
	local value = game:GetService("Workspace")
	local index = game:GetService("RunService")
	game:GetService("UserInputService")
	game:GetService("StarterGui")
	local instance6 = instance:Folder("Metavision Features.", Color3.fromRGB(24, 255, 228), true)
	instance6:Label("Metavision Features.")

	instance6:Button("Metavision V1", "This Feature Emulates Having Isagi's Metavision From The Show.", function()
		loadstring(game:HttpGet("https://pastebin.com/raw/FVgs7bQw"))()
	end)

	instance6:Button("Metavision V2", "Similar To V1, Only Can Be Used Below 1:30 On Clock, Click Puzzle Piece To Activate.", function()
		loadstring(game:HttpGet("https://pastebin.com/raw/HfpQBAsF"))()
	end)

	local isReady = instance:Folder("Ball Features.", Color3.fromRGB(24, 255, 228), true)
	isReady:Label("Ball Features.")
	local output = { enabled = false, conn = nil }

	isReady:Toggle("Auto Goal", "Attempts To Steal The Ball And Score.", function()
		output.enabled = not output.enabled
		game.StarterGui:SetCore("SendNotification", { Title = "Auto Goal", Text = output.enabled and "Enabled." or "Disabled.", Duration = 1 })

		if output.enabled then
			local RunService = game:GetService("Players")
			local success = game:GetService("RunService")
			local character = game:GetService("ReplicatedStorage")
			local characterModel = workspace:WaitForChild("map")
			local y = characterModel:WaitForChild("Agoal")
			local startTime = characterModel:WaitForChild("Bgoal")
			local localPlayer = RunService.LocalPlayer

			local function demo()
				local currencyStat = localPlayer.Character and localPlayer.Character:FindFirstChild("state")
				return currencyStat and currencyStat:FindFirstChild("ingame") and currencyStat.ingame.Value
			end

			local function step()
				local head = characterModel:FindFirstChild("gkbarriar")

				if head then
					if head:FindFirstChild("A") then
						head.A.CanCollide = false
					end

					if head:FindFirstChild("B") then
						head.B.CanCollide = false
					end
				end

				if y then
					y.CanCollide = false
				end

				if startTime then
					startTime.CanCollide = false
				end
			end

			local function binarySearch()
				local RemoteEvent = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
				local humanoidRootPart = workspace.Terrain:FindFirstChild("Ball")

				if RemoteEvent and humanoidRootPart then
					RemoteEvent.CFrame = CFrame.new(humanoidRootPart.Position.X, 0, humanoidRootPart.Position.Z)
				end

				for _, edge in pairs(RunService:GetPlayers()) do
					if edge ~= localPlayer and edge.Character then
						local rootPart = edge.Character:FindFirstChild("Ball")
						local newPart = edge.Character:FindFirstChild("HumanoidRootPart")
						local vehicle = localPlayer.Character:FindFirstChild("HumanoidRootPart")

						if rootPart and newPart and vehicle then
							vehicle.CFrame = rootPart.CFrame
							character:WaitForChild("ByteNetReliable"):FireServer(buffer.fromstring(sorter.base), { { "tackle" } })
						end
					end
				end
			end

			local function safeCall()
				return localPlayer.Character and localPlayer.Character:FindFirstChild("Ball") ~= nil
			end

			output.conn = success.RenderStepped:Connect(function()
				if not output.enabled then
					return
				end

				pcall(function()
					if not demo() then
						return
					end
					step()
					binarySearch()

					if safeCall() then
						local RemoteEvent = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
						local found = localPlayer.Team.Name == "A" and startTime or y

						if RemoteEvent and found then
							RemoteEvent.CFrame = found.CFrame
							task.wait(0.185)
							character:WaitForChild("ByteNetReliable"):FireServer(buffer.fromstring(sorter.base), { { "kick", 20, false, Vector3.new(0, 1, 0) } })
						end
					end
				end)
			end)
		elseif output.conn then
			output.conn:Disconnect()
			output.conn = nil
		end
	end)

	local aimbotManager = { enabled = false, conn = nil }

	isReady:Toggle("Always Ball", "Attempts To Always Hold The Ball (zero gravity while active).", function()
		aimbotManager.enabled = not aimbotManager.enabled
		game.StarterGui:SetCore("SendNotification", { Title = "Always Ball", Text = aimbotManager.enabled and "Enabled." or "Disabled.", Duration = 1 })

		if aimbotManager.enabled then
			workspace.Gravity = 0

			aimbotManager.conn = coroutine.wrap(function()
				while aimbotManager.enabled do
					local RemoteEvent = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
					local humanoidRootPart = workspace.Terrain:FindFirstChild("Ball")

					if RemoteEvent and humanoidRootPart then
						RemoteEvent.CFrame = CFrame.new(humanoidRootPart.Position)
					end

					for _, edge in pairs(game.Players:GetPlayers()) do
						if edge ~= game.Players.LocalPlayer and edge.Character then
							local rootPart = edge.Character:FindFirstChild("Ball")
							local newPart = edge.Character:FindFirstChild("HumanoidRootPart")

							if rootPart and newPart and RemoteEvent then
								RemoteEvent.CFrame = rootPart.CFrame
								game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable"):FireServer(buffer.fromstring(sorter.base), { { "tackle" } })
							end
						end
					end

					task.wait(0.1)
				end
			end)()
		else
			workspace.Gravity = 196.2
		end
	end)

	local PlayerService = {
		LocalPlayer = game:GetService("Players").LocalPlayer,
		ByteNetReliable = game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable"),
		flowPart = nil,
		flowActive = false,
		flowConnection = nil,
		originalCFrame = nil,
		flowPart = Instance.new("Part"),
	}

	PlayerService.flowPart.Size = Vector3.new(150, 1, 150)
	PlayerService.flowPart.Anchored = true
	PlayerService.flowPart.CanCollide = true
	PlayerService.flowPart.Position = Vector3.new(-782, 2500, 1262)
	PlayerService.flowPart.Parent = workspace

	isReady:Button("Get Flow (Req. Ball)", "Click To Attempt Getting Flow. Click Again To Cancel.", function()
		local currentNode = PlayerService.LocalPlayer.Character
		if not currentNode then
			return
		end
		local RemoteEvent = currentNode:FindFirstChild("HumanoidRootPart")
		if not RemoteEvent then
			return
		end

		if PlayerService.flowActive then
			PlayerService.flowActive = false

			if PlayerService.flowConnection then
				task.cancel(PlayerService.flowConnection)
				PlayerService.flowConnection = nil
			end

			if PlayerService.originalCFrame then
				RemoteEvent.CFrame = PlayerService.originalCFrame
			end

			return
		end

		PlayerService.flowActive = true
		PlayerService.originalCFrame = RemoteEvent.CFrame
		RemoteEvent.CFrame = PlayerService.flowPart.CFrame + Vector3.new(0, 5, 0)
		task.wait(0.67)

		PlayerService.flowConnection = task.spawn(function()
			local cash = workspace:WaitForChild("characters"):WaitForChild(PlayerService.LocalPlayer.Name):WaitForChild("state"):WaitForChild("flow")
			local zone = { A = workspace.gks:FindFirstChild("A"), B = workspace.gks:FindFirstChild("B") }
			local tool = PlayerService.LocalPlayer.Team
			local current = nil

			if tool then
				local sourceString = tool.Name:lower()

				if sourceString:find("a") or sourceString == "red" then
					current = zone.A or zone.B
				else
					local visited = sourceString:find("b") or sourceString == "blue"
					current = nil

					if visited then
						current = zone.B or zone.A
					end
				end
			end

			if not current then
				game.StarterGui:SetCore("SendNotification", { Title = "oops!!! error!!", Text = "no AI gk found. cannot get flow.", Duration = 5 })

				if PlayerService.originalCFrame and RemoteEvent and RemoteEvent.Parent then
					RemoteEvent.CFrame = PlayerService.originalCFrame
				end

				PlayerService.flowActive = false
				return
			end

			while true do
				if PlayerService.flowActive and cash.Value < 100 then
					for rowIndex = 1, 25 do
						if not (not PlayerService.flowActive or cash.Value >= 100) then
							PlayerService.ByteNetReliable:FireServer(buffer.fromstring(sorter.base), { { "kick", 1, false, Vector3.new(0, 1, 0) } })
							task.wait(0.15)
							continue
						end

						break
					end

					if not (not PlayerService.flowActive or cash.Value >= 100) then
						task.wait(0.5)

						if current then
							RemoteEvent.CFrame = (current.PrimaryPart and current.PrimaryPart.CFrame or current:GetPivot()) + Vector3.new(0, 5, 0)
						end

						task.wait(0.25)

						for rowIndex = 1, 2 do
							if not (not PlayerService.flowActive or cash.Value >= 100) then
								PlayerService.ByteNetReliable:FireServer(buffer.fromstring(sorter.base), { { "kick", 1, false, Vector3.new(0, 1, 0) } })
								task.wait(0.12)
								continue
							end

							break
						end

						if not (not PlayerService.flowActive or cash.Value >= 100) then
							task.wait(1)
							local humanoidRootPart = workspace.Terrain:FindFirstChild("Ball") or workspace.Terrain:WaitForChild("Ball", 10)

							if humanoidRootPart then
								while PlayerService.flowActive and humanoidRootPart.Parent == workspace.Terrain and cash.Value < 100 do
									RemoteEvent.CFrame = humanoidRootPart.CFrame + Vector3.new(0, 5, 0)
									task.wait(0.05)
								end
							end

							if not (not PlayerService.flowActive or cash.Value >= 100) then
								task.wait(0.2)
								RemoteEvent.CFrame = PlayerService.flowPart.CFrame + Vector3.new(0, 5, 0)
								task.wait(0.5)
								continue
							end
						end
					end
				end

				break
			end

			task.wait(0.5)

			if cash.Value >= 100 then
				local humanoidRootPart = workspace.Terrain:FindFirstChild("Ball")

				if humanoidRootPart and humanoidRootPart.Parent == workspace.Terrain then
					while humanoidRootPart.Parent == workspace.Terrain and PlayerService.flowActive do
						RemoteEvent.CFrame = humanoidRootPart.CFrame + Vector3.new(0, 5, 0)
						task.wait(0.05)
					end
				end
			end

			task.wait(0.3)

			if PlayerService.flowActive and RemoteEvent and RemoteEvent.Parent and PlayerService.originalCFrame then
				RemoteEvent.CFrame = PlayerService.originalCFrame
			end

			PlayerService.flowActive = false
			PlayerService.flowConnection = nil
		end)
	end)

	local found = false

	isReady:Button("Steal Ball", "Repeatedly Attempts To Get The Ball. Click Again To Cancel.", function()
		local RemoteEvent = PlayerService.LocalPlayer.Character and PlayerService.LocalPlayer.Character.HumanoidRootPart
		if not RemoteEvent then
			return
		end

		if found then
			found = false
			return
		end
		found = true

		spawn(function()
			while found and RemoteEvent and RemoteEvent.Parent and not PlayerService.LocalPlayer.Character:FindFirstChild("Ball") do
				local humanoidRootPart = workspace.Terrain:FindFirstChild("Ball")

				if humanoidRootPart then
					RemoteEvent.CFrame = CFrame.new(humanoidRootPart.Position)
				end

				for _, expectedType in game.Players:GetPlayers() do
					if found then
						if expectedType ~= PlayerService.LocalPlayer then
							local rootPart = expectedType.Character and expectedType.Character:FindFirstChild("Ball")

							if rootPart then
								RemoteEvent.CFrame = rootPart.CFrame
								PlayerService.ByteNetReliable:FireServer(buffer.fromstring(sorter.base), { { "tackle" } })
							end
						end

						continue
					end

					break
				end

				task.wait(0.05)
			end

			found = false
		end)
	end)

	isReady:Button("Bring Ball", "Steals The Ball Then Teleports Back. Click Again To Cancel.", function()
		local RemoteEvent = PlayerService.LocalPlayer.Character and PlayerService.LocalPlayer.Character.HumanoidRootPart
		if not RemoteEvent then
			return
		end

		if found then
			found = false
			return
		end
		found = true

		spawn(function()
			local angle = RemoteEvent.CFrame

			while found and RemoteEvent and RemoteEvent.Parent and not PlayerService.LocalPlayer.Character:FindFirstChild("Ball") do
				local humanoidRootPart = workspace.Terrain:FindFirstChild("Ball")

				if humanoidRootPart then
					RemoteEvent.CFrame = CFrame.new(humanoidRootPart.Position)
				end

				for _, expectedType in game.Players:GetPlayers() do
					if found then
						if expectedType ~= PlayerService.LocalPlayer then
							local rootPart = expectedType.Character and expectedType.Character:FindFirstChild("Ball")

							if rootPart then
								RemoteEvent.CFrame = rootPart.CFrame
								PlayerService.ByteNetReliable:FireServer(buffer.fromstring(sorter.base), { { "tackle" } })
							end
						end

						continue
					end

					break
				end

				task.wait(0.05)
			end

			if found and RemoteEvent and RemoteEvent.Parent and PlayerService.LocalPlayer.Character:FindFirstChild("Ball") then
				RemoteEvent.CFrame = angle
			end

			found = false
		end)
	end)

	local score = instance:Folder("No Cooldown Features.", Color3.fromRGB(24, 255, 228), true)
	score:Label("No Cooldown Features. Please Note This Is Exclusive To PC.")
	userInputService = game:GetService("UserInputService")
	runService = game:GetService("RunService")
	starterGui = game:GetService("StarterGui")
	player = game.Players.LocalPlayer

	dashState = {
		ForwardRushEnabled = false,
		SideDashEnabled = false,
		rushing = false,
		sideDashing = false,
		dashBindsSetup = false,
		lastForwardRush = 0,
		lastSideDash = 0,
		character = nil,
		humanoid = nil,
		rootPart = nil,
	}

	forward_animm = "rbxassetid://79394729551302"
	sideright_animm = "rbxassetid://114016332539655"
	sideleft_animm = "rbxassetid://100207093237932"

	updateCharacter = function()
		dashState.character = player.Character or player.CharacterAdded:Wait()
		dashState.humanoid = dashState.character:WaitForChild("Humanoid")
		dashState.rootPart = dashState.character:WaitForChild("HumanoidRootPart")
	end

	updateCharacter()
	player.CharacterAdded:Connect(updateCharacter)

	noty = function(x, playerIdentifier)
		starterGui:SetCore("SendNotification", { Title = x, Text = playerIdentifier, Duration = 2 })
	end

	isAnimationPlaying = function(x)
		if not dashState.humanoid then
			return false
		end
		local path = dashState.humanoid:GetPlayingAnimationTracks()

		for _, neighbor in ipairs(path) do
			if neighbor.Animation and neighbor.Animation.AnimationId == x then
				return true
			end
		end

		return false
	end

	isAnySideDashPlaying = function()
		return isAnimationPlaying(sideright_animm) or isAnimationPlaying(sideleft_animm)
	end

	clearPreviousDashForces = function()
		if not dashState.rootPart then
			return
		end

		for _, child in ipairs(dashState.rootPart:GetChildren()) do
			if child:IsA("BodyVelocity") and child.Name:match("^DashBV_") then
				child:Destroy()
			end
		end
	end

	forwardRush = function()
		if not dashState.ForwardRushEnabled or not dashState.humanoid or not dashState.rootPart then
			return
		end
		local targetPosition = dashState.lastForwardRush
		if tick() - targetPosition < 0.75 then
			return
		end

		if isAnimationPlaying(forward_animm) then
			return
		end
		dashState.lastForwardRush = tick()
		dashState.rushing = true
		clearPreviousDashForces()
		local humanoid = dashState.humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", dashState.humanoid)
		local errorMessage = Instance.new("Animation")
		errorMessage.AnimationId = forward_animm
		humanoid:LoadAnimation(errorMessage):Play()

		task.delay(0, function()
			local sound = Instance.new("Sound")
			sound.SoundId = "rbxassetid://105267293181745"
			sound.Parent = dashState.rootPart
			sound:Play()

			sound.Ended:Connect(function()
				sound:Destroy()
			end)
		end)

		local fileHandle = Instance.new("BodyVelocity")
		fileHandle.Name = "DashBV_" .. tostring(os.clock())
		fileHandle.MaxForce = Vector3.new(2000000, 20000, 2000000)
		fileHandle.P = 1500
		fileHandle.Parent = dashState.rootPart
		local sourceString = "ForwardRush_" .. tostring(os.clock())

		runService:BindToRenderStep(sourceString, Enum.RenderPriority.Character.Value + 10, function()
			if not dashState.rootPart or not dashState.rootPart.Parent or not fileHandle or not fileHandle.Parent then
				runService:UnbindFromRenderStep(sourceString)

				if fileHandle then
					fileHandle:Destroy()
				end

				dashState.rushing = false
				return
			end

			fileHandle.Velocity = dashState.rootPart.CFrame.LookVector * 100
		end)

		task.delay(0.5, function()
			runService:UnbindFromRenderStep(sourceString)

			if fileHandle then
				fileHandle:Destroy()
			end

			dashState.rushing = false
		end)
	end

	sideDash = function(x)
		if not dashState.SideDashEnabled or not dashState.humanoid or not dashState.rootPart then
			return
		end
		local now = dashState.lastSideDash
		if tick() - now < 0.3 then
			return
		end

		if isAnySideDashPlaying() then
			return
		end
		dashState.lastSideDash = tick()
		dashState.sideDashing = true
		clearPreviousDashForces()
		local count = x == "right" and sideright_animm or sideleft_animm
		local humanoid = dashState.humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", dashState.humanoid)
		local errorMessage = Instance.new("Animation")
		errorMessage.AnimationId = count
		humanoid:LoadAnimation(errorMessage):Play()
		local sound = Instance.new("Sound")
		sound.SoundId = "rbxassetid://71212694698006"
		sound.Parent = dashState.rootPart
		sound:Play()

		sound.Ended:Connect(function()
			sound:Destroy()
		end)

		local fileHandle = Instance.new("BodyVelocity")
		fileHandle.Name = "DashBV_" .. tostring(os.clock())
		fileHandle.MaxForce = Vector3.new(2000000, 20000, 2000000)
		fileHandle.P = 1500
		fileHandle.Parent = dashState.rootPart
		local sourceString = "SideDash_" .. tostring(os.clock())

		runService:BindToRenderStep(sourceString, Enum.RenderPriority.Character.Value + 10, function()
			if not dashState.rootPart or not dashState.rootPart.Parent or not fileHandle or not fileHandle.Parent then
				runService:UnbindFromRenderStep(sourceString)

				if fileHandle then
					fileHandle:Destroy()
				end

				dashState.sideDashing = false
				return
			end

			fileHandle.Velocity = dashState.rootPart.CFrame.RightVector * (x == "right" and 75 or -75)
		end)

		task.delay(0.4, function()
			runService:UnbindFromRenderStep(sourceString)

			if fileHandle then
				fileHandle:Destroy()
			end

			dashState.sideDashing = false
		end)
	end

	score:Toggle("No Rush Cooldown", "Emulates Having No Rush Cooldown.", function()
		dashState.ForwardRushEnabled = not dashState.ForwardRushEnabled
		noty("No Rush CD", dashState.ForwardRushEnabled and "Enabled." or "Disabled.")
	end)

	score:Toggle("No Side Dash Cooldown", "Emulates Having No Side Dash Cooldown.", function()
		dashState.SideDashEnabled = not dashState.SideDashEnabled
		noty("No Side Dash CD", dashState.SideDashEnabled and "Enabled." or "Disabled.")
	end)

	if not dashState.dashBindsSetup then
		dashState.dashBindsSetup = true

		userInputService.InputBegan:Connect(function(inputObject, gameProcessed)
			if gameProcessed then
				return
			end

			if inputObject.KeyCode == Enum.KeyCode.F then
				forwardRush()
			elseif inputObject.KeyCode == Enum.KeyCode.Q then
				local jumpState = userInputService:IsKeyDown(Enum.KeyCode.A)

				if userInputService:IsKeyDown(Enum.KeyCode.D) then
					sideDash("right")
				elseif jumpState then
					sideDash("left")
				end
			end
		end)
	end

	local jumpState = instance:Folder("Ball Breaker", Color3.fromRGB(24, 255, 228), true)
	jumpState:Label("Break Ball Features.")

	jumpState:Button("Break Ball (Player Method, Req. Ball)", "Breaks The Ball By Going Extremely High Up.", function()
		local previous = Vector3.new(10, 1, 10)

		for rowIndex = 0, 2 do
			for row = 0, 2 do
				local projectile = Instance.new("Part")
				projectile.Size = Vector3.new(10, 1, 10)
				projectile.Anchored = true
				projectile.Position = Vector3.new(-190, 14864566, 492) + Vector3.new(rowIndex * (previous.X + 0), 0, row * (previous.Z + 0))
				projectile.Parent = workspace
			end
		end

		local localPlayer = game.Players.LocalPlayer
		;(localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").CFrame = CFrame.new(Vector3.new(-190, 14864566, 492) + Vector3.new(0, 1e14, 0))
	end)

	jumpState:Button("Break Ball (Ball Method, Req. Ball)", "Breaks The Ball By Kicking It Out Of Bounds.", function()
		local localPlayer = game.Players.LocalPlayer
		local RemoteEvent = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
		local manager = game:GetService("VirtualInputManager")

		if RemoteEvent then
			local currentPosition = RemoteEvent.Position
			RemoteEvent.CFrame = CFrame.new(Vector3.new(-390, 475, 354))
			task.wait(0.3)
			manager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
			task.wait(0.1)
			manager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
			task.wait(0.3)
			RemoteEvent.CFrame = CFrame.new(currentPosition)
		end
	end)

	jumpState:Button("Permanent Break Ball (Req. Ball)", "Breaks The Ball By Placing It In The Void.", function()
		workspace.FallenPartsDestroyHeight = -50000
		game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(1, -49999, 1))
	end)

	local str = node:Folder("Ball Magnet Features.", Color3.fromRGB(24, 255, 228), true)
	str:Label("Original Ball Magnet: Allows You To Grab The Ball From Further Away.")

	local zone = {
		active = false,
		conn = nil,
		lastFire = 0,
		fire_intrv = 0.05,
		radius = 1,
		hrp = nil,
		useM2Hold = false,
	}

	local status = game:GetService("UserInputService")
	local playerGui = game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable")
	local localPlayer = Players.LocalPlayer

	str:Toggle("Ball Magnet", "Ball Magnet, Uses Set Radius As Range.", function()
		zone.active = not zone.active
		game.StarterGui:SetCore("SendNotification", { Title = "Ball Magnet", Text = zone.active and "Enabled." or "Disabled.", Duration = 1 })

		if zone.active then
			if zone.conn then
				zone.conn:Disconnect()
			end

			zone.conn = index.Heartbeat:Connect(function()
				local scalar = zone.radius or 1
				if scalar < 2 then
					return
				end
				local humanoidRootPart = value.Terrain:FindFirstChild("Ball")
				if not humanoidRootPart then
					return
				end

				if zone.hrp then
					local speed = (zone.hrp.Position - humanoidRootPart.Position).Magnitude
					if zone.useM2Hold and not status:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
						return
					end
					local high = speed <= scalar

					if high then
						local endTime = zone.lastFire
						high = time() - endTime >= zone.fire_intrv
					end

					if high then
						zone.lastFire = time()

						pcall(function()
							playerGui:FireServer(buffer.fromstring(sorter.grabball))
						end)
					end
				end
			end)
		elseif zone.conn then
			zone.conn:Disconnect()
			zone.conn = nil
		end
	end)

	str:Slider("Ball Magnet Radius", 7, 7, 25, 0.5, function(callbackFunction)
		zone.radius = callbackFunction
	end)

	str:Toggle("Magnet Uses M2 Hold", "If Enabled, Ball Magnet Only Grabs While Right Click Is Held Down.", function()
		zone.useM2Hold = not zone.useM2Hold
		game.StarterGui:SetCore("SendNotification", { Title = "Magnet Uses M2 Hold", Text = zone.useM2Hold and "Enabled." or "Disabled.", Duration = 1 })
	end)

	local function demo(x)
		zone.hrp = x:WaitForChild("HumanoidRootPart", 10)
	end

	if localPlayer.Character then
		demo(localPlayer.Character)
	end

	localPlayer.CharacterAdded:Connect(function(input)
		demo(input)
	end)

	local sequence = { enabled = false, hitbox = nil, loop = nil }

	str:Toggle("Ball Magnet Radius Hitbox", "Shows The Magnet's Radius Hitbox.", function()
		sequence.enabled = not sequence.enabled

		game.StarterGui:SetCore("SendNotification", {
			Title = "Ball Magnet Radius Hitbox",
			Text = sequence.enabled and "Enabled." or "Disabled.",
			Duration = 1,
		})

		local function step()
			if sequence.hitbox then
				sequence.hitbox:Destroy()
				sequence.hitbox = nil
			end
		end

		local function binarySearch()
			if sequence.loop then
				sequence.loop:Disconnect()
				sequence.loop = nil
			end
		end

		if not sequence.enabled then
			binarySearch()
			step()
			return
		end

		binarySearch()

		sequence.loop = index.Heartbeat:Connect(function()
			if not sequence.enabled then
				binarySearch()
				step()
				return
			end

			local accessory = workspace:FindFirstChild("Terrain")
			accessory = accessory and accessory:FindFirstChild("Ball")
			if not accessory or not accessory:IsA("MeshPart") then
				step()
				return
			end
			local scalar = zone.radius or 1
			if scalar < 2 then
				step()
				return
			end

			if not sequence.hitbox then
				local projectile = Instance.new("Part")
				projectile.Name = "BallMagnetRange"
				projectile.Shape = Enum.PartType.Ball
				projectile.Material = Enum.Material.Neon
				projectile.Color = Color3.fromRGB(15, 155, 155)
				projectile.Transparency = 0.9
				projectile.CanCollide = false
				projectile.CanTouch = false
				projectile.CanQuery = false
				projectile.Anchored = true
				projectile.Massless = true
				projectile.Parent = workspace
				sequence.hitbox = projectile
			end

			local iteration = scalar * 2
			local handle = sequence.hitbox
			handle.Size = Vector3.new(iteration, iteration, iteration)
			handle.CFrame = accessory.CFrame
		end)
	end)

	local instance2 = node:Folder("Auto Counter", Color3.fromRGB(24, 255, 228), true)
	instance2:Label("Set The Auto-Counter Number To Your Character's Counter Move.")
	local index2 = tick
	local index3 = ipairs
	local index4 = pairs
	local index5 = unpack

	local turret = {
		suppressNotifs = false,
		autoSkills = {
			toggleDribble = "dribble",
			toggleCounter1 = "skill1",
			toggleCounter2 = "skill2",
			toggleCounter3 = "skill3",
			toggleCounter4 = "skill4",
			toggleCounter5 = "skill5",
			toggleTSpecial = "Tspecialer",
		},
		toggleDribble = false,
		toggleCounter1 = false,
		toggleCounter2 = false,
		toggleCounter3 = false,
		toggleCounter4 = false,
		toggleCounter5 = false,
		toggleTSpecial = false,
		cooldowns = {},
		useClosestTeammate = false,
		mCD = 65,
		fireRate = 0.05,
		playerCooldown = 0.33,
	}

	local depth = buffer or { fromstring = function(x)
		return x
	end }

	local LocalPlayer = Players.LocalPlayer
	local otherPlayer = LocalPlayer
	local TweenService = game:GetService("StarterGui")
	local UserInputService = game:GetService("UserInputService")
	local character = game:GetService("ReplicatedStorage")
	local keys = { "rbxassetid://109744655458082", "rbxassetid://113088324958896" }

	local function step(x, playerIdentifier, deltaTime)
		if not turret.suppressNotifs then
			TweenService:SetCore("SendNotification", { Title = x, Text = playerIdentifier, Duration = deltaTime or 2 })
		end
	end

	local matrix = {}
	local iterator = character:WaitForChild("ByteNetReliable")

	local function binarySearch()
		return otherPlayer.Character and otherPlayer.Character:FindFirstChild("Ball") ~= nil
	end

	local function safeCall()
		local currentNode = otherPlayer.Character
		currentNode = currentNode and currentNode:FindFirstChild("HumanoidRootPart")
		if not currentNode then
			return nil
		end
		local currentPosition = currentNode.Position
		local tool = otherPlayer.Team
		local nearestDistance = math.huge
		local bestLabel = nil

		for _, edge in index3(Players:GetPlayers()) do
			if edge ~= otherPlayer and edge.Team == tool and edge.Character then
				local RemoteEvent = edge.Character:FindFirstChild("HumanoidRootPart")

				if RemoteEvent then
					local iteration = (currentPosition - RemoteEvent.Position).Magnitude ^ 2

					if iteration < nearestDistance then
						nearestDistance = iteration
						bestLabel = edge
					end
				end
			end
		end

		return bestLabel
	end

	local function deepCopy(x, playerIdentifier)
		if not binarySearch() then
			return
		end
		local stack

		if turret.useClosestTeammate and playerIdentifier then
			local currentNode = playerIdentifier.Character
			stack = { depth.fromstring(sorter.base), { { x, currentNode } } }
		else
			stack = { depth.fromstring(sorter.base), { { x } } }
		end

		iterator:FireServer(index5(stack))
	end

	local stack = { "toggleCounter1", "toggleCounter2", "toggleCounter3", "toggleCounter4", "toggleCounter5" }

	local function onCharacterAdded(x, playerIdentifier)
		if matrix[playerIdentifier] and matrix[playerIdentifier].animLoop then
			matrix[playerIdentifier].animLoop:Disconnect()
		end

		local connection = x.AnimationPlayed:Connect(function(deltaTime)
			local high = false

			for _, heartbeatConnection in index3(keys) do
				if deltaTime.Animation.AnimationId == heartbeatConnection then
					high = true
					break
				end
			end

			if not high then
				return
			end

			if playerIdentifier.Team == otherPlayer.Team then
				return
			end
			local iteration = 0
			local connection = nil

			connection = game:GetService("RunService").Heartbeat:Connect(function()
				if not deltaTime.IsPlaying or not binarySearch() then
					if connection then
						connection:Disconnect()
					end

					return
				end

				local bestLabel = index2()
				if turret.cooldowns[playerIdentifier] and bestLabel - turret.cooldowns[playerIdentifier] < turret.playerCooldown then
					return
				end

				if bestLabel - iteration < turret.fireRate then
					return
				end
				iteration = bestLabel
				local currentNode = otherPlayer.Character
				currentNode = currentNode and currentNode:FindFirstChild("HumanoidRootPart")
				local RemoteEvent = playerIdentifier.Character and playerIdentifier.Character:FindFirstChild("HumanoidRootPart")
				if currentNode and RemoteEvent and (currentNode.Position - RemoteEvent.Position).Magnitude > turret.mCD then
					return
				end
				local cost = turret.useClosestTeammate and safeCall() or nil

				for _, column in index3(stack) do
					if turret[column] then
						deepCopy(turret.autoSkills[column], cost)
					end
				end

				if turret.toggleTSpecial then
					deepCopy(turret.autoSkills.toggleTSpecial, cost)
				end

				if turret.toggleDribble then
					deepCopy(turret.autoSkills.toggleDribble, cost)
				end

				turret.cooldowns[playerIdentifier] = bestLabel
			end)

			matrix[playerIdentifier] = matrix[playerIdentifier] or {}
			matrix[playerIdentifier].animLoop = connection
		end)

		matrix[playerIdentifier] = matrix[playerIdentifier] or {}
		matrix[playerIdentifier].animatorConn = connection
	end

	local function onPlayerRemoving(columnIndex)
		if columnIndex == otherPlayer then
			return
		end

		local function createClass(input)
			if matrix[columnIndex] then
				for _, heartbeatConnection in index4(matrix[columnIndex]) do
					if typeof(heartbeatConnection) == "RBXScriptConnection" then
						heartbeatConnection:Disconnect()
					end
				end
			end

			local remoteEvent = input:WaitForChild("Humanoid", 6)
			if not remoteEvent then
				return
			end
			local humanoid = remoteEvent:FindFirstChildOfClass("Animator") or remoteEvent:WaitForChild("Animator", 4)

			if humanoid then
				onCharacterAdded(humanoid, columnIndex)
			end
		end

		if columnIndex.Character then
			createClass(columnIndex.Character)
		end

		columnIndex.CharacterAdded:Connect(createClass)
	end

	for _, edge in index3(Players:GetPlayers()) do
		onPlayerRemoving(edge)
	end

	Players.PlayerAdded:Connect(onPlayerRemoving)

	Players.PlayerRemoving:Connect(function(columnIndex)
		if matrix[columnIndex] then
			for _, heartbeatConnection in index4(matrix[columnIndex]) do
				if typeof(heartbeatConnection) == "RBXScriptConnection" then
					heartbeatConnection:Disconnect()
				end
			end

			matrix[columnIndex] = nil
		end
	end)

	local function createClass(x, playerIdentifier)
		instance2:Toggle(x, function()
			turret[playerIdentifier] = not turret[playerIdentifier]
			step(x, turret[playerIdentifier] and "Enabled." or "Disabled.", 3)
		end)
	end

	instance2:Toggle("Use Closest Teammate", "When Enabled, Skills Will Target Your Closest Teammate (Pass Based Counters Only).", function()
		turret.useClosestTeammate = not turret.useClosestTeammate
		step("Closest Teammate", turret.useClosestTeammate and "Enabled." or "Disabled.", 3)
	end)

	instance2:Slider("Counter Radius", 65, 25, 75, 1, function(firstVector)
		turret.mCD = firstVector
	end)

	createClass("Auto Dribble", "toggleDribble")
	createClass("Auto Counter (Move One)", "toggleCounter1")
	createClass("Auto Counter (Move Two)", "toggleCounter2")
	createClass("Auto Counter (Move Three)", "toggleCounter3")
	createClass("Auto Counter (Move Four)", "toggleCounter4")
	createClass("Auto Counter (Move Five)", "toggleCounter5")
	createClass("T Special", "toggleTSpecial")
	local bestLabel = instance:Folder("Auto Goal Features.", Color3.fromRGB(24, 255, 228), true)
	bestLabel:Label("Auto Goal: Automatically Does Auto Goal Steps Instantly, Use In 5v5.")

	bestLabel:Button("Isagi U-20 Goal", "Attempts To Do Isagi's U-20 Auto Goal By Teleporting To The Designated Area.", function()
		local PLAYER = game.Players.LocalPlayer

		if PLAYER.Character and PLAYER.Character:FindFirstChild("HumanoidRootPart") then
			local RemoteEvent = PLAYER.Character.HumanoidRootPart

			if PLAYER.Team == game.Teams:FindFirstChild("A") then
				RemoteEvent.CFrame = CFrame.new(-536, 3, 999)
			elseif PLAYER.Team == game.Teams:FindFirstChild("B") then
				RemoteEvent.CFrame = CFrame.new(-537, 3, 1549)
			end

			task.wait(0.2)
			character:WaitForChild("ByteNetReliable"):FireServer(depth.fromstring(sorter.base), { { "skill3" } })
		end
	end)

	bestLabel:Button("Nagi Dream Goal", "Attempts To Do Nagi's Control Move Auto Goal In Flow.", function()
		local PLAYER = game.Players.LocalPlayer

		if PLAYER.Character and PLAYER.Character:FindFirstChild("HumanoidRootPart") then
			local RemoteEvent = PLAYER.Character.HumanoidRootPart

			if PLAYER.Team == game.Teams:FindFirstChild("A") then
				RemoteEvent.CFrame = CFrame.new(-459, 3, 862)
			elseif PLAYER.Team == game.Teams:FindFirstChild("B") then
				RemoteEvent.CFrame = CFrame.new(-611, 3, 1682) * CFrame.Angles(0, 3.1415926535897931, 0)
			end

			task.wait(0.2)

			if PLAYER.Character and PLAYER.Character:FindFirstChild("Humanoid") then
				PLAYER.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end

			task.wait(0.2)
			character:WaitForChild("ByteNetReliable"):FireServer(depth.fromstring(sorter.base), { { "skill2", true } })
		end
	end)

	bestLabel:Button("Barou Devour Goal", "Attempts To Do Barou's Devour Auto Goal By Teleporting Behind Two Enemy Players.", function()
		local PLAYER = game.Players.LocalPlayer

		local function deepCopyTable()
			local current = game.Teams:FindFirstChild("A")

			if PLAYER.Team == game.Teams:FindFirstChild("A") then
				current = game.Teams:FindFirstChild("B")
			end

			local iteration = 0

			for _, edge in index3(game.Players:GetPlayers()) do
				if edge.Team == current then
					iteration += 1
				end
			end

			return iteration
		end

		local function createVector()
			local sortedArray = {}
			local current = game.Teams:FindFirstChild("A")

			if PLAYER.Team == game.Teams:FindFirstChild("A") then
				current = game.Teams:FindFirstChild("B")
			end

			for _, edge in index3(game.Players:GetPlayers()) do
				if edge ~= PLAYER and edge.Team == current then
					table.insert(sortedArray, edge)
				end
			end

			for rowIndex = #sortedArray, 2, -1 do
				local iteration = math.random(1, rowIndex)
				local top = sortedArray[rowIndex]
				sortedArray[rowIndex] = sortedArray[iteration]
				sortedArray[iteration] = top
			end

			return sortedArray[1], sortedArray[2]
		end

		if deepCopyTable() >= 2 then
			local top, track = createVector()
			if not top or not track then
				return
			end

			local function generateUniqueIdentifier(x)
				local RemoteEvent = (PLAYER.Character or PLAYER.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
				local newPart = x.Character and x.Character:FindFirstChild("HumanoidRootPart")

				if RemoteEvent and newPart then
					RemoteEvent.CFrame = newPart.CFrame
				end
			end

			generateUniqueIdentifier(top)
			task.wait(0.3)
			generateUniqueIdentifier(track)
			task.wait(0.3)

			if PLAYER.Team == game.Teams:FindFirstChild("A") then
				PLAYER.Character.HumanoidRootPart.Position = Vector3.new(-625, 3, 925)
			elseif PLAYER.Team == game.Teams:FindFirstChild("B") then
				PLAYER.Character.HumanoidRootPart.Position = Vector3.new(-588, 3, 1643)
			end
		end
	end)

	local top = instance:Folder("Fun Features.", Color3.fromRGB(24, 255, 228), true)
	top:Label("Fun Features: Pretty Fun Features I'd Say.")
	local count = "rbxassetid://113098409724280"
	local sortedArray = { active = false, character = nil, humanoid = nil, animationTrack = nil }

	local function deepCopyTable()
		if not sortedArray.humanoid then
			return
		end
		sortedArray.active = true
		local errorMessage = Instance.new("Animation")
		errorMessage.AnimationId = count
		local track = sortedArray.humanoid:LoadAnimation(errorMessage)
		track.Priority = Enum.AnimationPriority.Action4
		track.Looped = false
		track:Play(0)
		track:AdjustSpeed(0)
		sortedArray.animationTrack = track
	end

	local function createVector()
		sortedArray.active = false

		if sortedArray.animationTrack then
			sortedArray.animationTrack:Stop()
			sortedArray.animationTrack:Destroy()
			sortedArray.animationTrack = nil
		end

		if sortedArray.humanoid then
			sortedArray.humanoid.CameraOffset = Vector3.zero
		end
	end

	index.RenderStepped:Connect(function()
		if not sortedArray.active then
			return
		end

		if not sortedArray.humanoid or not sortedArray.character then
			return
		end
		sortedArray.humanoid.CameraOffset = Vector3.zero
		local RemoteEvent = sortedArray.character:FindFirstChild("HumanoidRootPart")

		if RemoteEvent then
			if not value:Raycast(RemoteEvent.Position, Vector3.new(0, -500, 0)) then
				RemoteEvent.CFrame = CFrame.new(Vector3.new(-540, 3, 1274))
			end
		end
	end)

	LocalPlayer.CharacterAdded:Connect(function(input)
		sortedArray.character = input
		sortedArray.humanoid = input:WaitForChild("Humanoid")

		if sortedArray.active then
			deepCopyTable()
		end
	end)

	if LocalPlayer.Character then
		sortedArray.character = LocalPlayer.Character
		sortedArray.humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	end

	top:Toggle("Invisibility V1 (Method: Animation)", "Makes You Almost Fully Invisible To Other Players Using An Animation.", function(x)
		if x then
			deepCopyTable()
		else
			createVector()
		end
	end)

	top:Button("Invisibility V2 (Method: Clone)", "Makes You Almost Fully Invisible To Other Players Using Cloning. Click Z To Disable.", function()
		local RunService = game:GetService("Players")
		local success = game:GetService("RunService")
		local currentTime = game:GetService("UserInputService")
		local PLAYER = RunService.LocalPlayer
		local high = true
		local targetPlayer = workspace:WaitForChild("characters", 10)
		if not targetPlayer then
			return
		end
		local track = targetPlayer:WaitForChild(PLAYER.Name, 15)
		if not track then
			return
		end

		if not track:FindFirstChild("Humanoid") or not track:FindFirstChild("HumanoidRootPart") then
			return
		end
		track.Archivable = true
		local RemoteEvent = track:WaitForChild("HumanoidRootPart")
		RemoteEvent.Transparency = 1
		local button = track:Clone()
		if not button then
			return
		end
		button.Name = PLAYER.Name .. "_Ghost"
		button.Parent = workspace

		for _, descendant in index3(button:GetDescendants()) do
			if descendant:IsA("BasePart") or descendant:IsA("MeshPart") or descendant:IsA("Part") then
				if descendant.Name == "HumanoidRootPart" then
					descendant.Transparency = 1
				else
					descendant.Transparency = 0.4
				end

				descendant.CanCollide = true
			elseif descendant:IsA("Decal") or descendant:IsA("Texture") or descendant:IsA("ShirtGraphic") then
				descendant.Transparency = 0
			end
		end

		local newPart = button:WaitForChild("HumanoidRootPart", 5)

		if newPart then
			newPart.Transparency = 1
		end

		local remoteEvent = button:WaitForChild("Humanoid", 5)
		if not newPart or not remoteEvent then
			button:Destroy()
			return
		end
		newPart.CFrame = track.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
		remoteEvent.PlatformStand = false
		remoteEvent.WalkSpeed = 75
		remoteEvent.JumpPower = 50
		PLAYER.Character = button
		workspace.CurrentCamera.CameraSubject = remoteEvent
		local hook = { Run = "rbxassetid://90801998022970", Jump = "rbxassetid://80330677678466" }
		local errorMessage = Instance.new("Animation")
		errorMessage.AnimationId = hook.Run
		local animationTrack = remoteEvent:LoadAnimation(errorMessage)
		animationTrack.Looped = true
		animationTrack.Priority = Enum.AnimationPriority.Movement
		local message = Instance.new("Animation")
		message.AnimationId = hook.Jump
		local soundInstance = remoteEvent:LoadAnimation(message)
		soundInstance.Looped = false
		soundInstance.Priority = Enum.AnimationPriority.Action
		local low = false
		local connection = nil
		local j = nil

		currentTime.InputBegan:Connect(function(inputObject, gameProcessed)
			if gameProcessed then
				return
			end

			if inputObject.KeyCode == Enum.KeyCode.Z and high then
				high = false

				if connection then
					connection:Disconnect()
				end

				if j then
					j:Disconnect()
				end

				connection = nil
				j = nil
				PLAYER.Character = track
				workspace.CurrentCamera.CameraSubject = track:FindFirstChild("Humanoid")

				if button then
					button:Destroy()
				end

				button = nil

				for _, descendant in index3(track:GetDescendants()) do
					if descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
						if descendant.Name == "HumanoidRootPart" then
							descendant.Transparency = 1
						else
							descendant.Transparency = 0
						end

						descendant.CanCollide = true
					elseif descendant:IsA("Decal") or descendant:IsA("Texture") or descendant:IsA("ShirtGraphic") then
						descendant.Transparency = 0
					end
				end

				animationTrack:Stop(0.2)
				soundInstance:Stop(0.2)
				low = false
			end
		end)

		connection = success.Heartbeat:Connect(function()
			if not high then
				return
			end

			if not newPart or not newPart.Parent or not RemoteEvent or not RemoteEvent.Parent then
				return
			end
			local currentPosition = newPart.Position
			RemoteEvent.CFrame = CFrame.new(currentPosition - Vector3.new(0, 15, 0), currentPosition)

			for _, descendant in index3(track:GetDescendants()) do
				if descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
					descendant.Transparency = 1
					descendant.CanCollide = false
				end
			end
		end)

		j = success.RenderStepped:Connect(function()
			if not high then
				return
			end

			if not remoteEvent or not remoteEvent.Parent then
				return
			end
			remoteEvent.WalkSpeed = 75
			remoteEvent.JumpPower = 50
		end)

		success.Heartbeat:Connect(function()
			if not high or not remoteEvent or not remoteEvent.Parent then
				return
			end
			local offset = remoteEvent.MoveDirection.Magnitude > 0.01
			local currencyStat = remoteEvent:GetState()

			if offset and currencyStat ~= Enum.HumanoidStateType.Jumping then
				if not low then
					animationTrack:Play(0.1)
					low = true
				end
			elseif low then
				animationTrack:Stop(0.3)
				low = false
			end

			if currencyStat == Enum.HumanoidStateType.Jumping or currencyStat == Enum.HumanoidStateType.Freefall then
				if not soundInstance.IsPlaying then
					soundInstance:Play(0.15)
				end
			elseif soundInstance.IsPlaying then
				soundInstance:Stop(0.2)
			end
		end)

		PLAYER.CharacterRemoving:Connect(function()
			high = false

			if connection then
				connection:Disconnect()
			end

			if j then
				j:Disconnect()
			end

			animationTrack:Stop(0)
			soundInstance:Stop(0)
			low = false

			if button then
				button:Destroy()
			end
		end)
	end)

	local hook = { InfiniteRangePassing = false, busy = false }
	local PLAYER = Players.LocalPlayer
	PLAYER:GetMouse()
	local camera = workspace.CurrentCamera
	local playerPed = character:WaitForChild("ByteNetReliable")

	local heap = {
		[Enum.KeyCode.One] = "skill1",
		[Enum.KeyCode.Two] = "skill2",
		[Enum.KeyCode.Three] = "skill3",
		[Enum.KeyCode.Four] = "skill4",
	}

	local function generateUniqueIdentifier()
		local mouseLocation = UserInputService:GetMouseLocation()
		local nearestDistance = math.huge
		local track = nil

		for _, edge in index3(Players:GetPlayers()) do
			if edge ~= PLAYER and edge.Team == PLAYER.Team then
				local currentNode = edge.Character

				if currentNode then
					local remoteEvent = currentNode:FindFirstChild("Humanoid")
					local RemoteEvent = currentNode:FindFirstChild("HumanoidRootPart")

					if remoteEvent and RemoteEvent and remoteEvent.Health > 0 then
						local animationTrack, soundInstance = camera:WorldToViewportPoint(RemoteEvent.Position)

						if soundInstance then
							local speed = (Vector2.new(animationTrack.X, animationTrack.Y) - mouseLocation).Magnitude

							if speed < nearestDistance then
								nearestDistance = speed
								track = currentNode
							end
						end
					end
				end
			end
		end

		return track
	end

	UserInputService.InputBegan:Connect(function(inputObject, gameProcessed)
		if gameProcessed then
			return
		end

		if not hook.InfiniteRangePassing then
			return
		end

		if hook.busy then
			return
		end

		if PLAYER.Team == game.Teams.lobby then
			return
		end
		local track = heap[inputObject.KeyCode]
		if not track then
			return
		end
		local animationTrack = generateUniqueIdentifier()
		if not animationTrack then
			return
		end
		hook.busy = true
		playerPed:FireServer(depth.fromstring(sorter.base), { { track, animationTrack } })

		task.delay(0.1, function()
			hook.busy = false
		end)
	end)

	top:Toggle("Infinite Range Passing", "Pass To The Closest Teammate To Your Mouse From Anywhere.", function(initialCapacity)
		hook.InfiniteRangePassing = initialCapacity
		TweenService:SetCore("SendNotification", { Title = "Infinite Pass", Text = initialCapacity and "Enabled." or "Disabled.", Duration = 5 })
	end)

	top:Toggle("Auto Break Server (Demon's Contract)", "When Using Demon's Contract With Kunigami, It Will Automatically Reset.", function(name)
		local RunService = game:GetService("Players")
		local ReplicatedStorage = game:GetService("StarterGui")
		getgenv().AutoBreakServerEnabled = name
		ReplicatedStorage:SetCore("SendNotification", { Title = "Auto Break Server", Text = name and "Enabled." or "Disabled.", Duration = 3 })

		if getgenv().AutoBreakServerConnection then
			getgenv().AutoBreakServerConnection:Disconnect()
			getgenv().AutoBreakServerConnection = nil
		end

		getgenv().DemonContractActive = false
		if not name then
			return
		end

		local function createVector3(input)
			local humanoid = input:WaitForChild("Humanoid"):WaitForChild("Animator")

			if getgenv().AutoBreakServerConnection then
				getgenv().AutoBreakServerConnection:Disconnect()
			end

			local placeholder = humanoid.AnimationPlayed

			getgenv().AutoBreakServerConnection = placeholder:Connect(function(x)
				if not getgenv().AutoBreakServerEnabled or getgenv().DemonContractActive then
					return
				end

				if x.Animation and x.Animation.AnimationId == "rbxassetid://91509980165830" then
					getgenv().DemonContractActive = true

					task.delay(2, function()
						getgenv().DemonContractActive = false
						local resourceName = RunService.LocalPlayer.Character

						if getgenv().AutoBreakServerEnabled and resourceName then
							local remoteEvent = resourceName:FindFirstChildOfClass("Humanoid")

							if remoteEvent then
								remoteEvent.Health = 0
							end
						end
					end)
				end
			end)
		end

		if RunService.LocalPlayer.Character then
			createVector3(RunService.LocalPlayer.Character)
		end

		RunService.LocalPlayer.CharacterAdded:Connect(createVector3)
	end)

	top:Button("Steal Screen Time (funny)", "Click Z To Disable, Steals Screen Time.", function()
		local playerInstance = game.Players.LocalPlayer
		local currentNode = playerInstance.Character
		local Camera = workspace.CurrentCamera
		local high = false

		game.UserInputService.InputBegan:Connect(function(inputObject, gameProcessed)
			if gameProcessed then
				return
			end

			if inputObject.KeyCode == Enum.KeyCode.Z then
				high = true
			end
		end)

		local currentPosition = playerInstance.Character.HumanoidRootPart.Position
		local low = false
		local track = nil
		local attachment = nil
		local textLabel = nil

		local function createVector3()
			if attachment then
				attachment:Destroy()
				attachment = nil
			end

			if textLabel then
				textLabel:Destroy()
				textLabel = nil
			end
		end

		local connection = nil

		connection = game["Run Service"].RenderStepped:Connect(function()
			if high then
				createVector3()
				connection:Disconnect()
				return
			end

			if currentNode ~= playerInstance.Character then
				currentNode = playerInstance.Character
			end

			local remoteEvent = currentNode:FindFirstChild("Humanoid")
			local RemoteEvent = currentNode:FindFirstChild("HumanoidRootPart")

			if Camera.CameraType == Enum.CameraType.Scriptable then
				if low == false then
					track = remoteEvent.Animator:LoadAnimation(game:GetService("ReplicatedStorage").emoteWiki.myanimefans.Animation)
					track.Looped = true
					track:Play()
					track:AdjustSpeed(4)
					attachment = Instance.new("BodyGyro")
					attachment.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
					attachment.P = 10000
					attachment.D = 500
					attachment.Parent = RemoteEvent
					textLabel = Instance.new("BodyPosition")
					textLabel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
					textLabel.P = 10000
					textLabel.D = 500
					textLabel.Parent = RemoteEvent
				end

				low = true
				local angle = Camera.CFrame * CFrame.new(0, -1.3, -2.3) * CFrame.Angles(0, 3.1415926535897931, 0)
				textLabel.Position = angle.Position
				attachment.CFrame = angle
			else
				if low == true then
					low = false

					if track then
						track:Stop()
					end

					createVector3()
					RemoteEvent.AssemblyLinearVelocity = Vector3.zero
					RemoteEvent.CFrame = CFrame.new(currentPosition)
					RemoteEvent.AssemblyLinearVelocity = Vector3.zero
				end

				currentPosition = RemoteEvent.Position
			end
		end)
	end)

	top:Button("Goalkeeper Anywhere (Rejoin To Disable.)", "Allows You To Do GK Side Dashes Instead!", function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Goalkeeper Anywhere",
			Text = "If You Don't See GK Animations, Your Executor Doesn't Support The Required Functions.",
			Duration = 10,
			Button1 = "ok my executor is fine",
			Button2 = "aw man my executor sucks",
		})

		hookfunction(require(game:GetService("ReplicatedStorage").util.actionUtil).checkGK, function()
			return true
		end)
	end)

	top:Button("Shachoko GK Catch (Req. GK Position.)", "Makes It Almost Impossible To Be Scored On As GK And Does Shachoko Kick.", function()
		loadstring(game:HttpGet("https://pastebin.com/raw/Hr1HnK38"))()
	end)

	local track = instance:Folder("Other Blatant Features.", Color3.fromRGB(24, 255, 228), true)
	track:Label("Other Blatant Features: It's In The Name.")
	local controller = { enabled = false, loopConnection = nil }
	local success = game:GetService("RunService")
	local ReplicatedStorage = game:GetService("StarterGui")
	local data = game:GetService("Workspace")

	local function createVector3(rawCommand)
		local key = data.map.gkbarriar.Abarriar
		local file = data.map.gkbarriar.Bbarriar
		local y = data.map.Agoal
		local startTime = data.map.Bgoal

		if key then
			key.CanCollide = rawCommand
		end

		if file then
			file.CanCollide = rawCommand
		end

		if y then
			y.CanCollide = rawCommand
		end

		if startTime then
			startTime.CanCollide = rawCommand
		end
	end

	track:Toggle("Blatant Mode", "Removes Collisions With Goal Boxes.", function()
		controller.enabled = not controller.enabled

		if controller.enabled then
			controller.loopConnection = success.Heartbeat:Connect(function()
				createVector3(false)
			end)

			ReplicatedStorage:SetCore("SendNotification", { Title = "Blatant Mode", Text = "Enabled.", Duration = 3 })
		else
			if controller.loopConnection then
				controller.loopConnection:Disconnect()
				controller.loopConnection = nil
			end

			createVector3(true)
			ReplicatedStorage:SetCore("SendNotification", { Title = "Blatant Mode", Text = "Disabled.", Duration = 3 })
		end
	end)

	local hookData = { enabled = false }
	local playerInstance = game.Players.LocalPlayer

	local function mainLoop()
		if not hookData.enabled then
			return
		end
		local currentNode = playerInstance.Character
		if not currentNode then
			return
		end
		local remoteEvent = currentNode:FindFirstChild("Humanoid")

		if remoteEvent then
			remoteEvent.WalkSpeed = 40
		end
	end

	local function onInputBegan()
		if hookData.enabled then
			mainLoop()
		end
	end

	playerInstance.CharacterAdded:Connect(onInputBegan)

	if playerInstance.Character then
		onInputBegan(playerInstance.Character)
	end

	track:Toggle("No Stun", "Overrides The Stunned State So You Can Move.", function(chunk)
		hookData.enabled = chunk

		if chunk then
			game.StarterGui:SetCore("SendNotification", { Title = "No Stun", Text = "Enabled" })
			mainLoop()
		else
			game.StarterGui:SetCore("SendNotification", { Title = "No Stun", Text = "Disabled" })
		end
	end)

	game:GetService("RunService").RenderStepped:Connect(function()
		if hookData.enabled then
			mainLoop()
		end
	end)

	local response = { running = false }

	track:Toggle("Spam Brick Sound (5v5 + GK Only.)", "This SHOULD Be Self Explanatory.", function(nodeIdentifier)
		response.running = nodeIdentifier

		if response.running then
			ReplicatedStorage:SetCore("SendNotification", { Title = "Brick Spam", Text = "Enabled.", Duration = 3 })

			task.spawn(function()
				local RemoteEvent = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
				local intersect = game.Players.LocalPlayer.Team and game.Players.LocalPlayer.Team.Name
				local previous

				if intersect == "A" then
					previous = Vector3.new(-510, 3, 1706)
				else
					previous = nil

					if intersect == "B" then
						previous = Vector3.new(-559, 3, 843)
					end
				end

				if previous then
					while response.running do
						RemoteEvent.CFrame = CFrame.new(previous)
						task.wait(0.1)
						local firstElement = { depth.fromstring(sorter.base), { { "kick", 27, false, Vector3.new(0, 1, 0) } } }
						game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable"):FireServer(index5(firstElement))
						task.wait(0.05)
					end
				end
			end)
		else
			ReplicatedStorage:SetCore("SendNotification", { Title = "Brick Spam", Text = "Disabled.", Duration = 3 })
		end
	end)

	local animationTrack = instance:Folder("Trap Assist", Color3.fromRGB(24, 255, 228), true)
	animationTrack:Label("Trap Helper: Automatically Moves Toward Ball During Trap Moves.")

	local firstElement = {
		"rbxassetid://73387016994281",
		"rbxassetid://101043441232233",
		"rbxassetid://96593185131882",
		"rbxassetid://116422938520670",
		"rbxassetid://90734196141468",
		"rbxassetid://85349589701503",
		"rbxassetid://120351399679118",
	}

	local effect = {
		enabled = false,
		detected = false,
		armTime = 0,
		active = false,
		track = nil,
		ball = nil,
		conn = nil,
		alignOri = nil,
	}

	local iteration = 50
	local t = 50

	local function initialize()
		local accessory = workspace.Terrain

		if accessory then
			local humanoidRootPart = accessory:FindFirstChild("Ball")
			if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
				return humanoidRootPart
			end
		end
	end

	local function serializeTable()
		if effect.conn then
			effect.conn:Disconnect()
			effect.conn = nil
		end

		effect.active = false
		effect.track = nil
		effect.ball = nil

		if effect.alignOri then
			effect.alignOri:Destroy()
			effect.alignOri = nil
		end
	end

	local function generateRandomPoints(explosion, arguments, zCoordinate)
		if iteration < (arguments.Position - explosion.Position).Magnitude then
			return
		end
		effect.ball = arguments
		effect.track = zCoordinate
		effect.active = true

		if effect.alignOri then
			effect.alignOri:Destroy()
		end

		local screenGui = Instance.new("AlignOrientation")
		screenGui.Name = "TrapFaceAlign"
		screenGui.Mode = Enum.OrientationAlignmentMode.OneAttachment
		screenGui.Attachment0 = explosion:FindFirstChild("RootAttachment") or Instance.new("Attachment", explosion)
		screenGui.RigidityEnabled = false
		screenGui.MaxTorque = 20000
		screenGui.Responsiveness = 1000
		screenGui.Parent = explosion
		effect.alignOri = screenGui

		if effect.conn then
			effect.conn:Disconnect()
		end

		effect.conn = index.RenderStepped:Connect(function(radius)
			if not effect.track or not effect.track.IsPlaying then
				serializeTable()
				return
			end

			if not effect.ball or not effect.ball.Parent then
				serializeTable()
				return
			end
			local currentPosition = explosion.Position
			local deltaZ = effect.ball.Position - Vector3.new(0, 3, 0) - currentPosition
			local speed = deltaZ.Magnitude
			if speed > iteration or speed < 0.5 then
				serializeTable()
				return
			end
			explosion.CFrame = CFrame.new(currentPosition + deltaZ.Unit * t * radius) * explosion.CFrame.Rotation
			local previous = Vector3.new(effect.ball.Position.X, explosion.Position.Y, effect.ball.Position.Z)

			if effect.alignOri then
				effect.alignOri.CFrame = CFrame.lookAt(explosion.Position, previous)
			end
		end)

		zCoordinate.Stopped:Connect(function()
			serializeTable()
		end)
	end

	local function initializeSystem(x)
		local humanoid = x:WaitForChild("Humanoid"):WaitForChild("Animator")
		local RemoteEvent = x:WaitForChild("HumanoidRootPart")

		humanoid.AnimationPlayed:Connect(function(playerIdentifier)
			if not effect.enabled then
				return
			end

			if not playerIdentifier.Animation then
				return
			end
			local length = playerIdentifier.Animation.AnimationId

			for _, k in index3(firstElement) do
				local high = length == k

				if high then
					local elapsed = effect.armTime
					high = os.clock() >= elapsed
				end

				if high then
					effect.detected = true

					task.delay(0.05, function()
						if playerIdentifier.IsPlaying then
							local cell = initialize()

							if cell then
								generateRandomPoints(RemoteEvent, cell, playerIdentifier)
							end
						end
					end)

					break
				end
			end
		end)
	end

	local function handlePlayerAdded(input)
		initializeSystem(input)
	end

	if LocalPlayer.Character then
		handlePlayerAdded(LocalPlayer.Character)
	end

	LocalPlayer.CharacterAdded:Connect(handlePlayerAdded)

	UserInputService.InputBegan:Connect(function(inputObject, gameProcessed)
		if gameProcessed then
			return
		end

		if inputObject.UserInputType ~= Enum.UserInputType.Keyboard then
			return
		end
		local playerCharacter = inputObject.KeyCode.Value
		if playerCharacter < Enum.KeyCode.One.Value or playerCharacter > Enum.KeyCode.Five.Value then
			return
		end

		if effect.active then
			return
		end
		effect.armTime = os.clock()
		effect.detected = false

		task.delay(0.35, function()
			if not effect.detected then
				return
			end
			local currentNode = LocalPlayer.Character
			if not currentNode then
				return
			end
			local RemoteEvent = currentNode:FindFirstChild("HumanoidRootPart")
			if not RemoteEvent then
				return
			end
			local soundInstance = initialize()

			if soundInstance then
				local path = currentNode.Humanoid.Animator:GetPlayingAnimationTracks()

				for _, neighbor in index3(path) do
					if neighbor.Animation and table.find(firstElement, neighbor.Animation.AnimationId) then
						generateRandomPoints(RemoteEvent, soundInstance, neighbor)
						break
					end
				end
			end
		end)
	end)

	animationTrack:Toggle("Trap Helper", function(chunk)
		effect.enabled = chunk
		TweenService:SetCore("SendNotification", { Title = "Trap Helper", Text = chunk and "Enabled." or "Disabled.", Duration = 1 })
	end)

	animationTrack:Slider("Trap Helper Max Distance", 50, 50, 200, 1, function(x)
		iteration = x
	end)

	animationTrack:Slider("Trap Helper Speed", 50, 50, 1000, 1, function(x)
		t = x
	end)

	local soundInstance = instance:Folder("Distance Move Buffs.", Color3.fromRGB(24, 255, 228), true)
	soundInstance:Label("Distance Move Buffs: Buffs Movement Based Moves.")
	local newPlayer = Players.LocalPlayer

	local serialized = {
		Tackle = {
			animId = "rbxassetid://109744655458082",
			sliderVar = "tackleDist",
			duration = 0.4,
			cooldown = 0.15,
			wait = 0,
		},
		Rush = {
			animId = "rbxassetid://79394729551302",
			sliderVar = "rushDist",
			duration = 0.4,
			cooldown = 0.15,
			wait = 0.15,
		},
		GKDash = {
			animId = "rbxassetid://90537955276413",
			sliderVar = "gkDist",
			duration = 0.55,
			cooldown = 0.15,
			wait = 0.05,
		},
		Naruhaya = {
			animId = "rbxassetid://82240286756891",
			sliderVar = "naruhayaDist",
			duration = 0.45,
			cooldown = 0.15,
			wait = 0.33,
		},
		Raumdeuter = {
			animIds = { ["rbxassetid://81582265162782"] = true },
			sliderVar = "raumDist",
			duration = 0.55,
			cooldown = 0.15,
			wait = 0.1,
		},
		DraconicRush = {
			animId = "rbxassetid://95359966795185",
			sliderVar = "dracDist",
			duration = 0.625,
			cooldown = 0.15,
			wait = 0.175,
		},
		StepOvers = {
			animId = "rbxassetid://84063609284472",
			sliderVar = "stepDist",
			duration = 0.15,
			cooldown = 0.15,
			wait = 1.275,
		},
		KaiserOffBall = {
			animId = "rbxassetid://110660551661470",
			sliderVar = "kaiserDist",
			duration = 0.55,
			cooldown = 0.15,
			wait = 0.15,
		},
		OcclusionBreak = {
			animId = "rbxassetid://116181317759538",
			sliderVar = "occlusionDist",
			duration = 1,
			cooldown = 0.15,
			wait = 0.2,
		},
		DivingHeader = {
			animId = "rbxassetid://91506202951715",
			sliderVar = "divingDist",
			duration = 0.35,
			cooldown = 0.15,
			wait = 0.05,
		},
		ReflexTackle = {
			animId = "rbxassetid://113088324958896",
			sliderVar = "reflexDist",
			duration = 0.2,
			cooldown = 0.15,
			wait = 0,
		},
		RazorBreak = {
			animIds = {
				["rbxassetid://131681055843039"] = "Front",
				["rbxassetid://114963791456755"] = "Left",
				["rbxassetid://115966658644919"] = "Right",
				["rbxassetid://122404546980503"] = "Back",
				["rbxassetid://70754845580062"] = "RightBack",
				["rbxassetid://128061536134952"] = "LeftBack",
				["rbxassetid://71501932579824"] = "FrontRight",
				["rbxassetid://96632954418440"] = "FrontLeft",
				["rbxassetid://70397727954557"] = "Front",
				["rbxassetid://131196726012273"] = "Front",
			},
			sliderVar = "razorDist",
			duration = 0.35,
			cooldown = 0.15,
			wait = 0.1,
			isDirectional = true,
		},
		CutIn = {
			animIds = { ["rbxassetid://71217538180364"] = true, ["rbxassetid://87853371514282"] = true },
			sliderVar = "dragDist",
			duration = 1,
			cooldown = 0.15,
			wait = 0.2,
		},
		HeroInstinct = {
			animId = "rbxassetid://82417661349987",
			sliderVar = "instinctDist",
			duration = 1.25,
			cooldown = 0.15,
			wait = 0.33,
		},
		CloseQuarterDribble = {
			animId = "rbxassetid://94171465685487",
			sliderVar = "quarterDist",
			duration = 2.25,
			cooldown = 0.15,
			wait = 0.18,
		},
		SpeedyTurn = {
			animId = "rbxassetid://109145068926350",
			sliderVar = "speedyDist",
			duration = 0.7,
			cooldown = 0.15,
			wait = 0.05,
		},
		Fetch = {
			animId = "rbxassetid://110734304480469",
			sliderVar = "fetchDist",
			duration = 0.525,
			cooldown = 0.15,
			wait = 0.125,
		},
		GoGo = {
			animId = "rbxassetid://111297568709238",
			sliderVar = "gogoDist",
			duration = 0.35,
			cooldown = 0.15,
			wait = 0.55,
		},
		GuardDog = {
			animId = "rbxassetid://111439544531399",
			sliderVar = "guardDist",
			duration = 0.35,
			cooldown = 0.15,
			wait = 0.1,
		},
		ZombieDribble = {
			animId = "rbxassetid://102294508090597",
			sliderVar = "zombDist",
			duration = 1.7,
			cooldown = 0.15,
			wait = 0.15,
		},
		Creative = {
			animId = "rbxassetid://77926234700416",
			sliderVar = "creativeDist",
			duration = 0.2,
			cooldown = 0.15,
			wait = 0.85,
		},
		GlacialCut = {
			animId = "rbxassetid://116769918041530",
			sliderVar = "glacialDist",
			duration = 0.5,
			cooldown = 0.15,
			wait = 0.425,
		},
		Beautiful = {
			animIds = { ["rbxassetid://132788854309681"] = true, ["rbxassetid://138985718053619"] = true },
			sliderVar = "beautifulDist",
			duration = 0.3,
			cooldown = 0.15,
			wait = 0,
		},
		ControlVar = {
			animId = "rbxassetid://77370115011368",
			sliderVar = "controlVarDist",
			duration = 0.3,
			cooldown = 0.15,
			wait = 0.1,
		},
		Corvine = {
			animId = "rbxassetid://79459013513539",
			sliderVar = "corvineDist",
			duration = 0.4,
			cooldown = 0.15,
			wait = 1.1,
		},
		Kusarigama = {
			animId = "rbxassetid://84772583028665",
			sliderVar = "kusarDist",
			duration = 0.55,
			cooldown = 0.15,
			wait = 0,
		},
		ShadowStep = {
			animIds = { ["rbxassetid://133810381664491"] = true, ["rbxassetid://139230259021390"] = true },
			sliderVar = "shadowDist",
			duration = 0.3,
			cooldown = 0.15,
			wait = 0,
		},
		SilentSteal = {
			animId = "rbxassetid://89782964116671",
			sliderVar = "silentDist",
			duration = 0.55,
			cooldown = 0.15,
			wait = 0.1,
		},
		NutmegReflex = {
			animId = "rbxassetid://73266865968554",
			sliderVar = "reflexNutmegDist",
			duration = 0.25,
			cooldown = 0.15,
			wait = 0.05,
		},
		TwinSteps = {
			animId = "rbxassetid://106299517516303",
			sliderVar = "twinStepsDist",
			duration = 0.15,
			cooldown = 0.15,
			wait = 1.75,
		},
		KingsPath = {
			animId = "rbxassetid://73560885704292",
			sliderVar = "kingsDist",
			duration = 1.175,
			cooldown = 0.15,
			wait = 0.4,
		},
		MachCutIn = {
			animIds = { ["rbxassetid://133945265328817"] = true, ["rbxassetid://88448030655006"] = true },
			sliderVar = "machDist",
			duration = 0.15,
			cooldown = 0.15,
			wait = 0.625,
		},
		GoldenZone = {
			animId = "rbxassetid://132426354821688",
			sliderVar = "goldenDist",
			duration = 2,
			cooldown = 0.15,
			requiresBall = true,
			wait = 0.15,
		},
		Devour = {
			animId = "rbxassetid://117921992582675",
			sliderVar = "devourMaxDist",
			speed = 150,
			cooldown = 0.15,
			isUnlimited = true,
			wait = 0.2,
		},
	}

	local tween = {}

	for _, vertex in index4(serialized) do
		tween[vertex.sliderVar] = 0
	end

	local characters = {}
	local RemoteEvent = nil
	local connection = nil
	local previous = Vector3.new()

	local record = {
		Front = Vector3.new(0, 0, 1),
		Back = Vector3.new(0, 0, -1),
		Left = Vector3.new(-1, 0, 0),
		Right = Vector3.new(1, 0, 0),
		FrontLeft = (Vector3.new(-1, 0, 1)).Unit,
		FrontRight = (Vector3.new(1, 0, 1)).Unit,
		LeftBack = (Vector3.new(-1, 0, -1)).Unit,
		RightBack = (Vector3.new(1, 0, -1)).Unit,
	}

	local function onHeartbeat(radius)
		for rowIndex = #characters, 1, -1 do
			local cell = characters[rowIndex]
			local targetPart = cell.hrp

			if not targetPart or not targetPart.Parent then
				table.remove(characters, rowIndex)
			else
				local deltaZ = cell.cfg.isUnlimited and cell.speed * radius or math.min(cell.speed * radius, cell.remaining)
				local directionVector

				if cell.isDirectional then
					local vectorB = targetPart.CFrame.LookVector
					local screenPosition = cell.offset
					local total = -screenPosition.X
					local delta = vectorB * screenPosition.Z
					directionVector = (vectorB:Cross(Vector3.new(0, 1, 0)) * total + delta).Unit
				else
					local vectorB = targetPart.CFrame.LookVector
					directionVector = Vector3.new(vectorB.X, 0, vectorB.Z).Unit

					if directionVector.Magnitude < 0.01 then
						directionVector = Vector3.new(0, 0, 1)
					end
				end

				local total = targetPart.Position + directionVector * deltaZ
				targetPart.CFrame = CFrame.new(total.X, targetPart.Position.Y, total.Z) * CFrame.new(previous, directionVector)
				cell.remaining = cell.remaining - deltaZ

				if cell.remaining <= 0 then
					table.remove(characters, rowIndex)
				end
			end
		end

		if #characters == 0 and connection then
			connection:Disconnect()
			connection = nil
		end
	end

	local function addVectors()
		if not connection and #characters > 0 then
			connection = game:GetService("RunService").RenderStepped:Connect(onHeartbeat)
		end
	end

	local function calculateDistance(x, playerIdentifier, deltaTime, playerId)
		local cell = tween[playerIdentifier.sliderVar]
		if cell <= 0 then
			return
		end

		task.delay(playerIdentifier.wait or 0, function()
			if not x or not x.Parent then
				return
			end
			local token = { hrp = x, remaining = cell, cfg = playerIdentifier, isDirectional = playerIdentifier.isDirectional == true }

			if token.isDirectional and playerId then
				token.offset = record[playerId] or Vector3.new(0, 0, 1)
			end

			if playerIdentifier.isUnlimited then
				token.remaining = math.huge
				token.speed = playerIdentifier.speed

				if deltaTime then
					local j = nil

					j = deltaTime.Stopped:Connect(function()
						token.remaining = 0

						if j then
							j:Disconnect()
						end
					end)
				end
			else
				token.speed = cell / playerIdentifier.duration
			end

			table.insert(characters, token)
			addVectors()
		end)
	end

	local function onInputEnded(x)
		if not x.Animation then
			return
		end
		local length = x.Animation.AnimationId

		for _, vertex in index4(serialized) do
			local high, bestPair

			if vertex.animId and length == vertex.animId then
				high = true
				bestPair = nil
			else
				high = false
				bestPair = nil

				if vertex.animIds then
					if vertex.isDirectional then
						bestPair = vertex.animIds[length]

						if bestPair then
							high = true
						end
					else
						bestPair = nil

						if vertex.animIds[length] then
							high = true
							bestPair = nil
						end
					end
				end
			end

			if high then
				if RemoteEvent and RemoteEvent.Parent then
					if vertex.requiresBall then
						local humanoidRootPart = RemoteEvent.Parent:FindFirstChild("Ball")
						if not humanoidRootPart or not humanoidRootPart:IsA("MeshPart") then
							continue
						end
					end

					calculateDistance(RemoteEvent, vertex, x, bestPair)
				end
			end
		end
	end

	local function handlePlayerRemoving(input)
		local remoteEvent = input:WaitForChild("Humanoid", 5)
		if not remoteEvent then
			return
		end
		local humanoid = remoteEvent:WaitForChild("Animator", 5)
		if not humanoid then
			return
		end
		RemoteEvent = input:WaitForChild("HumanoidRootPart", 5)
		if not RemoteEvent then
			return
		end
		humanoid.AnimationPlayed:Connect(onInputEnded)
	end

	if newPlayer.Character then
		handlePlayerRemoving(newPlayer.Character)
	end

	newPlayer.CharacterAdded:Connect(handlePlayerRemoving)
	soundInstance:Label("Universal Movement Buffs.")

	soundInstance:Slider("Tackle Distance", 0, 0, 75, 1, function(actionName)
		tween.tackleDist = actionName
	end)

	soundInstance:Slider("Rush Distance", 0, 0, 75, 1, function(weight)
		tween.rushDist = weight
	end)

	soundInstance:Slider("GK Front Dive Distance", 0, 0, 75, 1, function(command)
		tween.gkDist = command
	end)

	soundInstance:Label("Isagi Movement Buffs.")

	soundInstance:Slider("Naruhaya Footwork Distance", 0, 0, 200, 1, function(item)
		tween.naruhayaDist = item
	end)

	soundInstance:Label("NEL Isagi Movement Buffs.")

	soundInstance:Slider("Raumdeuter Distance", 0, 0, 200, 1, function(startIndex)
		tween.raumDist = startIndex
	end)

	soundInstance:Label("Shidou Movement Buffs.")

	soundInstance:Slider("Draconic Rush Distance", 0, 0, 200, 1, function(xCoordinate)
		tween.dracDist = xCoordinate
	end)

	soundInstance:Label("Bachira Movement Buffs.")

	soundInstance:Slider("Step Overs Distance", 0, 0, 200, 1, function(action)
		tween.stepDist = action
	end)

	soundInstance:Label("Kaiser Movement Buffs.")

	soundInstance:Slider("Off The Ball Distance", 0, 0, 200, 1, function(target)
		tween.kaiserDist = target
	end)

	soundInstance:Label("Rin Movement Buffs.")

	soundInstance:Slider("Occlusion Break Distance", 0, 0, 200, 1, function(secondVector)
		tween.occlusionDist = secondVector
	end)

	soundInstance:Label("Gagamaru Movement Buffs.")

	soundInstance:Slider("Diving Header Distance", 0, 0, 125, 1, function(inputString)
		tween.divingDist = inputString
	end)

	soundInstance:Label("Aiku Movement Buffs.")

	soundInstance:Slider("Reflex Tackle Distance", 0, 0, 125, 1, function(newValue)
		tween.reflexDist = newValue
	end)

	soundInstance:Label("Yukimiya Movement Buffs.")

	soundInstance:Slider("Razor Break Distance", 0, 0, 35, 1, function(event)
		tween.razorDist = event
	end)

	soundInstance:Slider("Drag Scissors Distance", 0, 0, 100, 1, function(itemName)
		tween.dragDist = itemName
	end)

	soundInstance:Label("Kunigami Movement Buffs.")

	soundInstance:Slider("Hero's Instinct Distance", 0, 0, 300, 1, function(payload)
		tween.instinctDist = payload
	end)

	soundInstance:Label("Don Lorenzo Movement Buffs.")

	soundInstance:Slider("Zombie Dribble Distance", 0, 0, 250, 1, function(number)
		tween.zombDist = number
	end)

	soundInstance:Label("Sae Movement Buffs.")

	soundInstance:Slider("Beautiful Destruction Distance", 0, 0, 33, 1, function(parent)
		tween.beautifulDist = parent
	end)

	soundInstance:Slider("Beautiful Destruction: Side Variant Distance", 0, 0, 25, 1, function(filePath)
		tween.creativeDist = filePath
	end)

	soundInstance:Slider("Nutmeg: Reflex Distance", 0, 0, 50, 1, function(pattern)
		tween.reflexNutmegDist = pattern
	end)

	soundInstance:Label("Barou Movement Buffs.")

	soundInstance:Slider("King's Path Distance", 0, 0, 750, 1, function(startPosition)
		tween.kingsDist = startPosition
	end)

	soundInstance:Slider("DEVOUR. Distance", 0, 0, 500, 1, function(amount)
		tween.devourMaxDist = amount
	end)

	soundInstance:Label("Nagi Movement Buffs.")

	soundInstance:Slider("Control Distance (Ground Variant)", 0, 0, 30, 1, function(text)
		tween.controlVarDist = text
	end)

	soundInstance:Label("Chigiri Movement Buffs.")

	soundInstance:Slider("Mach Cut-In Distance", 0, 0, 200, 1, function(other)
		tween.machDist = other
	end)

	soundInstance:Slider("Golden Zone Distance (Req. Ball)", 0, 0, 400, 1, function(height)
		tween.goldenDist = height
	end)

	soundInstance:Label("Reo Movement Buffs.")

	soundInstance:Slider("Twin Steps Distance", 0, 0, 75, 1, function(quantity)
		tween.twinStepsDist = quantity
	end)

	soundInstance:Label("Hiori Movement Buffs.")

	soundInstance:Slider("Glacial Cut (Variant: Forward) Distance", 0, 0, 175, 1, function(original)
		tween.glacialDist = original
	end)

	soundInstance:Label("Kurona Movement Buffs.")

	soundInstance:Slider("Close Quarter Dribble Distance", 0, 0, 250, 1, function(vehicleEntity)
		tween.quarterDist = vehicleEntity
	end)

	soundInstance:Slider("Go-Go! Distance", 0, 0, 100, 1, function(context)
		tween.gogoDist = context
	end)

	soundInstance:Slider("Guard Dog Distance", 0, 0, 100, 1, function(width)
		tween.guardDist = width
	end)

	soundInstance:Slider("Speedy Turn Distance", 0, 0, 250, 1, function(v)
		tween.speedyDist = v
	end)

	soundInstance:Slider("Fetch Distance", 0, 0, 100, 1, function(size)
		tween.fetchDist = size
	end)

	soundInstance:Label("Karasu Movement Buffs.")

	soundInstance:Slider("Silent Steal Distance", 0, 0, 125, 1, function(pointB)
		tween.silentDist = pointB
	end)

	soundInstance:Slider("Corvine Distance", 0, 0, 100, 1, function(eventName)
		tween.corvineDist = eventName
	end)

	soundInstance:Label("Otoya Movement Buffs.")

	soundInstance:Slider("Kusarigama Distance", 0, 0, 75, 1, function(reason)
		tween.kusarDist = reason
	end)

	soundInstance:Slider("Shadow Step Distance", 0, 0, 50, 1, function(pointA)
		tween.shadowDist = pointA
	end)

	local cell = node:Folder("Auto Activate Features.", Color3.fromRGB(24, 255, 228), true)
	cell:Label("Auto Activate: Activates The Move When Ball Within Range.")
	local token = { distance = 10, toggleState = false, moveNumber = 1, db = true, mode = "Hold" }

	cell:Toggle("Auto Activate", "Toggles The Feature On.", function(eventData)
		token.toggleState = eventData
	end)

	cell:Textbox("Auto Activate Move Number", "Example: 1, 2, 3, 4, 5.", function(x)
		nsdv = tonumber(x)

		if nsdv and nsdv <= 5 and nsdv > 0 then
			token.moveNumber = nsdv
		end
	end)

	cell:Slider("Auto Activate Distance", 10, 3, 70, 0.5, function(taskFunction)
		token.distance = taskFunction
	end)

	cell:Dropdown("Auto Activate Mode", { "Hold", "Toggle" }, function(entityIdentifier)
		token.mode = entityIdentifier

		if token.toggleState ~= nil then
			game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Auto Activate Mode", Text = "Current Mode: " .. token.mode, Duration = 3 })
		end
	end)

	game.UserInputService.InputBegan:Connect(function(inputObject, gameProcessed)
		if gameProcessed then
			return
		end

		if inputObject.UserInputType == Enum.UserInputType.MouseButton2 then
			if token.mode == "Hold" then
				token.db = false
			else
				token.db = not token.db
			end
		end
	end)

	game.UserInputService.InputEnded:Connect(function(inputObject, gameProcessed)
		if gameProcessed then
			return
		end

		if inputObject.UserInputType == Enum.UserInputType.MouseButton2 then
			if token.mode == "Hold" then
				token.db = true
			end
		end
	end)

	game:GetService("RunService").RenderStepped:Connect(function()
		if not token.toggleState or token.db then
			if game.CoreGui:FindFirstChild("AutoActGui") then
				game.CoreGui.AutoActGui:Destroy()
			end

			return
		end

		if not game.CoreGui:FindFirstChild("AutoActGui") then
			gui = Instance.new("ScreenGui")
			gui.Name = "AutoActGui"
			dot = Instance.new("Frame")
			dot.Name = "IndicatorDot"
			dot.Size = UDim2.new(0, 20, 0, 20)
			dot.Position = UDim2.new(0, 20, 1, -40)
			dot.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
			dot.BorderSizePixel = 0
			dot.Parent = gui
			corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(1, 0)
			corner.Parent = dot
			gui.Parent = game.CoreGui
		end

		char = game.Players.LocalPlayer.Character
		hrp = char and char:FindFirstChild("HumanoidRootPart")
		if not hrp then
			return
		end
		ball = game.Workspace.Terrain:FindFirstChild("Ball")
		if not ball then
			return
		end
		distance = (hrp.Position - ball.Position).Magnitude

		if distance <= token.distance then
			local priority = { { "skill" .. token.moveNumber } }
			args = { depth.fromstring(sorter.base), priority }
			game.ReplicatedStorage:WaitForChild("ByteNetReliable"):FireServer(index5(args))
		end
	end)

	local bestPair = node:Folder("Auto Line Up Features.", Color3.fromRGB(24, 255, 228), true)
	bestPair:Label("Auto Line Ups: Helps You Aim At Certain Areas.")
	local existingPlayer = Players.LocalPlayer
	local Camera = value.CurrentCamera
	local currentNode = existingPlayer.Character
	local newPart = currentNode and currentNode:FindFirstChild("HumanoidRootPart")
	local deltaZ = 0
	local total = 0
	local high = false
	local j = nil
	local bestChild = nil
	local low = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

	local function onTouched(playerEntity)
		currentNode = playerEntity
		newPart = currentNode:WaitForChild("HumanoidRootPart")
	end

	if existingPlayer.Character then
		onTouched(existingPlayer.Character)
	end

	existingPlayer.CharacterAdded:Connect(onTouched)

	local function traverse(minimum, yCoordinate)
		deltaZ += 1
		local projectile = Instance.new("Part")
		projectile.Name = "pad" .. deltaZ
		projectile.Size = Vector3.new(5, 5, 5)
		projectile.Position = minimum
		projectile.Transparency = 0.65
		projectile.Anchored = true
		projectile.CanCollide = false
		projectile.Color = yCoordinate
		projectile.Material = Enum.Material.SmoothPlastic
		projectile.Parent = value
	end

	local function clamp(minimum, yCoordinate)
		total += 1
		local projectile = Instance.new("Part")
		projectile.Name = "target" .. total
		projectile.Shape = Enum.PartType.Ball
		projectile.Size = Vector3.new(6, 6, 6)
		projectile.Position = minimum
		projectile.Anchored = true
		projectile.CanCollide = false
		projectile.Color = yCoordinate
		projectile.Material = Enum.Material.Neon
		projectile.Parent = value
	end

	UserInputService.InputBegan:Connect(function(inputObject, gameProcessed)
		if gameProcessed then
			return
		end

		if inputObject.UserInputType == Enum.UserInputType.MouseButton2 then
			high = true
		end
	end)

	UserInputService.InputEnded:Connect(function(inputObject)
		if inputObject.UserInputType == Enum.UserInputType.MouseButton2 then
			high = false
			bestChild = nil

			if j then
				j:Disconnect()
				j = nil
			end

			if newPart then
				newPart.Anchored = false
			end
		end
	end)

	local function cleanupResources()
		if not newPart then
			return nil
		end
		local raycastParams = RaycastParams.new()
		raycastParams.FilterDescendantsInstances = { currentNode }
		raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
		local raycastResult = value:Raycast(newPart.Position, Vector3.new(0, -6, 0), raycastParams)
		if raycastResult and raycastResult.Instance then
			return raycastResult.Instance.Name:match("^pad(%d+)$")
		end
		return nil
	end

	local function normalizeVector(x)
		bestChild = x

		if j then
			j:Disconnect()
		end

		j = index.RenderStepped:Connect(function()
			if not bestChild then
				if j then
					j:Disconnect()
					j = nil
				end

				return
			end

			Camera.CFrame = CFrame.new(Camera.CFrame.Position, bestChild.Position)
		end)
	end

	local function runSimulation()
		bestChild = nil

		if j then
			j:Disconnect()
			j = nil
		end
	end

	if low then
		index.RenderStepped:Connect(function()
			if not newPart then
				return
			end
			local targetCharacter = cleanupResources()

			if targetCharacter then
				local requestData = value:FindFirstChild("target" .. targetCharacter)

				if requestData and bestChild ~= requestData then
					normalizeVector(requestData)
				end
			elseif bestChild then
				runSimulation()
			end
		end)
	else
		index.RenderStepped:Connect(function()
			if not high or not newPart then
				return
			end
			local targetCharacter = cleanupResources()
			if not targetCharacter then
				return
			end
			local requestData = value:FindFirstChild("target" .. targetCharacter)
			if not requestData then
				return
			end

			if bestChild ~= requestData then
				normalizeVector(requestData)
			end

			newPart.Anchored = true
		end)
	end

	bestPair:Toggle("Sae Line Ups", "Sae's Drive Shot Line Ups.", function(x)
		if x then
			TweenService:SetCore("SendNotification", { Title = "Sae Line Ups", Text = "Enabled.", Duration = 3 })
			local priority = {}
			local ffi = Color3.fromRGB(255, 0, 0)
			local graph = Color3.fromRGB(0, 255, 0)
			local parts = Color3.fromRGB(255, 255, 0)
			local safeExecute = Color3.fromRGB
			priority[1] = ffi
			priority[2] = graph
			priority[3] = parts

			do
				local packed = table.pack(safeExecute(0, 0, 255))
				table.move(packed, 1, packed.n, 4, priority)
			end

			local candidate = {
				{ pad = Vector3.new(80, -10, -162), target = Vector3.new(20, 44, -26) },
				{ pad = Vector3.new(172, -10, -44), target = Vector3.new(110, 13, -15) },
				{ pad = Vector3.new(0, -10, -211), target = Vector3.new(32, 85, -14) },
				{ pad = Vector3.new(-78, -10, -133), target = Vector3.new(82, 41, -18) },
				{ pad = Vector3.new(-130, -9, 166), target = Vector3.new(-50, 52, 16) },
				{ pad = Vector3.new(-190, -9, 66), target = Vector3.new(-90, 30, 16) },
				{ pad = Vector3.new(72, -9, 164), target = Vector3.new(-57, 56, 16) },
				{ pad = Vector3.new(-1, -9, 222), target = Vector3.new(-6, 76, 55) },
			}

			local characterModel = value:WaitForChild("map", 8)
			if not characterModel then
				return
			end
			local targetCharacter = characterModel
			local currentPosition = characterModel:FindFirstChild("Agoal").Position
			local playerPosition = targetCharacter:FindFirstChild("Bgoal").Position

			for rowIndex = 1, 8 do
				local requestData = candidate[rowIndex]

				if requestData then
					local offset = rowIndex <= 4 and currentPosition or playerPosition
					local exponent = priority[(rowIndex - 1) % 4 + 1]
					traverse(offset + requestData.pad, exponent)
					clamp(offset + requestData.target, exponent)
				end
			end
		else
			TweenService:SetCore("SendNotification", { Title = "Sae Line Ups", Text = "Disabled.", Duration = 3 })

			for rowIndex = 1, deltaZ do
				local targetCharacter = value:FindFirstChild("pad" .. rowIndex)

				if targetCharacter then
					targetCharacter:Destroy()
				end
			end

			for rowIndex = 1, total do
				local targetCharacter = value:FindFirstChild("target" .. rowIndex)

				if targetCharacter then
					targetCharacter:Destroy()
				end
			end

			deltaZ = 0
			total = 0
		end
	end)

	bestPair:Toggle("Kaiser Line Ups", "Kaiser's Impact Magnus Line Ups.", function(x)
		if x then
			TweenService:SetCore("SendNotification", { Title = "Kaiser Line Ups", Text = "Enabled.", Duration = 3 })
			local priority = {}
			local ffi = Color3.fromRGB(255, 0, 0)
			local graph = Color3.fromRGB(0, 255, 0)
			local parts = Color3.fromRGB(255, 255, 0)
			local safeExecute = Color3.fromRGB(0, 0, 255)
			local results = Color3.fromRGB(255, 0, 255)
			local currentIndex = Color3.fromRGB(255, 182, 193)
			local points = Color3.fromRGB(255, 0, 0)
			local onPlayerAdded = Color3.fromRGB(0, 255, 0)
			local middle = Color3.fromRGB(255, 255, 0)
			local identifier = Color3.fromRGB(0, 0, 255)
			local copy = Color3.fromRGB(255, 0, 255)
			local main = Color3.fromRGB
			priority[1] = ffi
			priority[2] = graph
			priority[3] = parts
			priority[4] = safeExecute
			priority[5] = results
			priority[6] = currentIndex
			priority[7] = points
			priority[8] = onPlayerAdded
			priority[9] = middle
			priority[10] = identifier
			priority[11] = copy

			do
				local packed = table.pack(main(255, 182, 193))
				table.move(packed, 1, packed.n, 12, priority)
			end

			local candidate = {
				{ pad = Vector3.new(-3, -9, 263), target = Vector3.new(8, 112, 16) },
				{ pad = Vector3.new(120, -9, 221), target = Vector3.new(49, 75, 15) },
				{ pad = Vector3.new(230, -9, 68), target = Vector3.new(116, 39, 21) },
				{ pad = Vector3.new(207, -9, 15), target = Vector3.new(91, 29, -11) },
				{ pad = Vector3.new(39, -9, 117), target = Vector3.new(24, 10, 13) },
				{ pad = Vector3.new(-134, -9, 148), target = Vector3.new(87, 57, 19) },
				{ pad = Vector3.new(-1, -10, -250), target = Vector3.new(-12, 115, -13) },
				{ pad = Vector3.new(-231, -10, -60), target = Vector3.new(-142, 24, -22) },
				{ pad = Vector3.new(-120, -10, -215), target = Vector3.new(-53, 65, -18) },
				{ pad = Vector3.new(-212, -10, -15), target = Vector3.new(-89, 33, 12) },
				{ pad = Vector3.new(-48, -10, -116), target = Vector3.new(-24, 8, -13) },
				{ pad = Vector3.new(126, -10, -146), target = Vector3.new(-109, 60, -14) },
			}

			local characterModel = value:WaitForChild("map", 8)
			if not characterModel then
				return
			end
			local targetCharacter = characterModel
			local currentPosition = characterModel:FindFirstChild("Agoal").Position
			local playerPosition = targetCharacter:FindFirstChild("Bgoal").Position

			for rowIndex = 1, 12 do
				local requestData = candidate[rowIndex]

				if requestData then
					local offset = rowIndex <= 6 and playerPosition or currentPosition
					local exponent = priority[rowIndex]
					traverse(offset + requestData.pad, exponent)
					clamp(offset + requestData.target, exponent)
				end
			end
		else
			TweenService:SetCore("SendNotification", { Title = "Kaiser Line Ups", Text = "Disabled.", Duration = 3 })

			for rowIndex = 1, deltaZ do
				local targetCharacter = value:FindFirstChild("pad" .. rowIndex)

				if targetCharacter then
					targetCharacter:Destroy()
				end
			end

			for rowIndex = 1, total do
				local targetCharacter = value:FindFirstChild("target" .. rowIndex)

				if targetCharacter then
					targetCharacter:Destroy()
				end
			end

			deltaZ = 0
			total = 0
		end
	end)

	bestPair:Toggle("Yukimiya Line Ups", "Yukimiya's Gyro Shot Line Ups.", function(x)
		if x then
			TweenService:SetCore("SendNotification", { Title = "Yukimiya Line Ups", Text = "Enabled.", Duration = 3 })
			local priority = {}
			local ffi = Color3.fromRGB(255, 0, 0)
			local graph = Color3.fromRGB(255, 255, 0)
			local parts = Color3.fromRGB(0, 0, 255)
			local safeExecute = Color3.fromRGB(0, 255, 0)
			local results = Color3.fromRGB(255, 0, 0)
			local currentIndex = Color3.fromRGB(0, 255, 0)
			local points = Color3.fromRGB(255, 255, 0)
			local onPlayerAdded = Color3.fromRGB
			priority[1] = ffi
			priority[2] = graph
			priority[3] = parts
			priority[4] = safeExecute
			priority[5] = results
			priority[6] = currentIndex
			priority[7] = points

			do
				local packed = table.pack(onPlayerAdded(0, 0, 255))
				table.move(packed, 1, packed.n, 8, priority)
			end

			local candidate = {
				{ pad = Vector3.new(-1, -9, 222), target = Vector3.new(-57, 58, 13) },
				{ pad = Vector3.new(-82, -9, 182), target = Vector3.new(-51, 74, 14) },
				{ pad = Vector3.new(130, -9, 136), target = Vector3.new(-114, 95, 13) },
				{ pad = Vector3.new(63, -9, 192), target = Vector3.new(-104, 128, 13) },
				{ pad = Vector3.new(6, -10, -206), target = Vector3.new(65, 95, -12) },
				{ pad = Vector3.new(-59, -10, -201), target = Vector3.new(123, 148, -12) },
				{ pad = Vector3.new(68, -10, -198), target = Vector3.new(61, 105, -12) },
				{ pad = Vector3.new(-134, -10, -113), target = Vector3.new(4, 48, -53) },
			}

			local characterModel = value:WaitForChild("map", 8)
			if not characterModel then
				return
			end
			local targetCharacter = characterModel
			local currentPosition = characterModel:FindFirstChild("Agoal").Position
			local playerPosition = targetCharacter:FindFirstChild("Bgoal").Position

			for rowIndex = 1, 8 do
				local requestData = candidate[rowIndex]

				if requestData then
					local offset = rowIndex <= 4 and playerPosition or currentPosition
					local exponent = priority[rowIndex]
					traverse(offset + requestData.pad, exponent)
					clamp(offset + requestData.target, exponent)
				end
			end
		else
			TweenService:SetCore("SendNotification", { Title = "Yukimiya Line Ups", Text = "Disabled.", Duration = 3 })

			for rowIndex = 1, deltaZ do
				local targetCharacter = value:FindFirstChild("pad" .. rowIndex)

				if targetCharacter then
					targetCharacter:Destroy()
				end
			end

			for rowIndex = 1, total do
				local targetCharacter = value:FindFirstChild("target" .. rowIndex)

				if targetCharacter then
					targetCharacter:Destroy()
				end
			end

			deltaZ = 0
			total = 0
		end
	end)

	bestPair:Toggle("Rin Line Ups", "Rin's Curve Shot Line Ups.", function(x)
		if x then
			TweenService:SetCore("SendNotification", { Title = "Rin Line Ups", Text = "Enabled.", Duration = 3 })
			local priority = {}
			local ffi = Color3.fromRGB(255, 0, 0)
			local graph = Color3.fromRGB(0, 255, 0)
			local parts = Color3.fromRGB(255, 255, 0)
			local safeExecute = Color3.fromRGB(0, 0, 255)
			local results = Color3.fromRGB(255, 0, 0)
			local currentIndex = Color3.fromRGB(0, 255, 0)
			local points = Color3.fromRGB(255, 255, 0)
			local onPlayerAdded = Color3.fromRGB
			priority[1] = ffi
			priority[2] = graph
			priority[3] = parts
			priority[4] = safeExecute
			priority[5] = results
			priority[6] = currentIndex
			priority[7] = points

			do
				local packed = table.pack(onPlayerAdded(0, 0, 255))
				table.move(packed, 1, packed.n, 8, priority)
			end

			local candidate = {
				{ pad = Vector3.new(73, -9, 200), target = Vector3.new(5, 67, 54) },
				{ pad = Vector3.new(-2, -9, 215), target = Vector3.new(0, 88, 54) },
				{ pad = Vector3.new(-84, -9, 160), target = Vector3.new(-29, 13, 26) },
				{ pad = Vector3.new(-169, -9, 105), target = Vector3.new(-29, 24, 26) },
				{ pad = Vector3.new(-1, -10, -213), target = Vector3.new(-1, 77, -53) },
				{ pad = Vector3.new(-70, -10, -196), target = Vector3.new(9, 71, -53) },
				{ pad = Vector3.new(81, -10, -114), target = Vector3.new(30, 11, -20) },
				{ pad = Vector3.new(163, -10, -91), target = Vector3.new(30, 26, -20) },
			}

			local characterModel = value:WaitForChild("map", 8)
			if not characterModel then
				return
			end
			local targetCharacter = characterModel
			local currentPosition = characterModel:FindFirstChild("Agoal").Position
			local playerPosition = targetCharacter:FindFirstChild("Bgoal").Position

			for rowIndex = 1, 8 do
				local requestData = candidate[rowIndex]

				if requestData then
					local offset = rowIndex <= 4 and playerPosition or currentPosition
					local exponent = priority[rowIndex]
					traverse(offset + requestData.pad, exponent)
					clamp(offset + requestData.target, exponent)
				end
			end
		else
			TweenService:SetCore("SendNotification", { Title = "Rin Line Ups", Text = "Disabled.", Duration = 3 })

			for rowIndex = 1, deltaZ do
				local targetCharacter = value:FindFirstChild("pad" .. rowIndex)

				if targetCharacter then
					targetCharacter:Destroy()
				end
			end

			for rowIndex = 1, total do
				local targetCharacter = value:FindFirstChild("target" .. rowIndex)

				if targetCharacter then
					targetCharacter:Destroy()
				end
			end

			deltaZ = 0
			total = 0
		end
	end)

	bestPair:Toggle("Karasu Line Ups", "Karasu's Dive Bomb Line Ups.", function(x)
		if x then
			TweenService:SetCore("SendNotification", { Title = "Karasu Line Ups", Text = "Enabled.", Duration = 3 })
			local priority = {}
			local ffi = Color3.fromRGB(255, 0, 0)
			local graph = Color3.fromRGB(255, 128, 0)
			local parts = Color3.fromRGB(255, 255, 0)
			local safeExecute = Color3.fromRGB(0, 255, 0)
			local results = Color3.fromRGB(0, 0, 255)
			local currentIndex = Color3.fromRGB(128, 0, 255)
			local points = Color3.fromRGB(255, 0, 255)
			local onPlayerAdded = Color3.fromRGB(128, 255, 0)
			local middle = Color3.fromRGB(120, 72, 0)
			local identifier = Color3.fromRGB(255, 255, 255)
			local copy = Color3.fromRGB(0, 0, 0)
			local main = Color3.fromRGB(255, 0, 0)
			local err = Color3.fromRGB(255, 128, 0)
			local sourcePlayer = Color3.fromRGB(255, 255, 0)
			local left = Color3.fromRGB(0, 255, 0)
			local deltaX = Color3.fromRGB(0, 0, 255)
			local deltaY = Color3.fromRGB(128, 0, 255)
			local right = Color3.fromRGB(255, 0, 255)
			local direction = Color3.fromRGB(128, 255, 0)
			local dummy = Color3.fromRGB(120, 72, 0)
			local BUTTON_PRESSED_COLOR = Color3.fromRGB(255, 255, 255)
			local Graph = Color3.fromRGB
			priority[1] = ffi
			priority[2] = graph
			priority[3] = parts
			priority[4] = safeExecute
			priority[5] = results
			priority[6] = currentIndex
			priority[7] = points
			priority[8] = onPlayerAdded
			priority[9] = middle
			priority[10] = identifier
			priority[11] = copy
			priority[12] = main
			priority[13] = err
			priority[14] = sourcePlayer
			priority[15] = left
			priority[16] = deltaX
			priority[17] = deltaY
			priority[18] = right
			priority[19] = direction
			priority[20] = dummy
			priority[21] = BUTTON_PRESSED_COLOR

			do
				local packed = table.pack(Graph(0, 0, 0))
				table.move(packed, 1, packed.n, 22, priority)
			end

			local candidate = {
				{ pad = Vector3.new(-47, -9, 164), target = Vector3.new(-25, 30, 14) },
				{ pad = Vector3.new(-24, -9, 193), target = Vector3.new(-30, 78, 14) },
				{ pad = Vector3.new(-2, -9, 206), target = Vector3.new(-4, 103, 14) },
				{ pad = Vector3.new(14, -9, 195), target = Vector3.new(-22, 93, 14) },
				{ pad = Vector3.new(56, -9, 157), target = Vector3.new(-71, 45, 14) },
				{ pad = Vector3.new(-19, -9, 114), target = Vector3.new(-25, 11, 16) },
				{ pad = Vector3.new(30, -9, 158), target = Vector3.new(-52, 28, 14) },
				{ pad = Vector3.new(66, -9, 187), target = Vector3.new(-34, 124, 14) },
				{ pad = Vector3.new(141, -9, 167), target = Vector3.new(-8, 122, 14) },
				{ pad = Vector3.new(-141, -9, 164), target = Vector3.new(-35, 118, 14) },
				{ pad = Vector3.new(-3, -9, -205), target = Vector3.new(-1, 270, -14) },
				{ pad = Vector3.new(-22, -9, -201), target = Vector3.new(10, 146, -14) },
				{ pad = Vector3.new(34, -9, -197), target = Vector3.new(39, 103, -14) },
				{ pad = Vector3.new(-37, -9, -169), target = Vector3.new(53, 57, -14) },
				{ pad = Vector3.new(-130, -9, -172), target = Vector3.new(13, 111, -14) },
				{ pad = Vector3.new(-148, -9, -150), target = Vector3.new(3, 129, -14) },
				{ pad = Vector3.new(14, -9, -184), target = Vector3.new(40, 67, -14) },
				{ pad = Vector3.new(85, -9, -158), target = Vector3.new(54, 41, -14) },
				{ pad = Vector3.new(118, -9, -168), target = Vector3.new(44, 71, -14) },
				{ pad = Vector3.new(170, -9, -154), target = Vector3.new(56, 85, -14) },
			}

			local characterModel = value:WaitForChild("map", 8)
			if not characterModel then
				return
			end
			local targetCharacter = characterModel
			local currentPosition = characterModel:FindFirstChild("Agoal").Position
			local playerPosition = targetCharacter:FindFirstChild("Bgoal").Position

			for rowIndex = 1, 20 do
				local requestData = candidate[rowIndex]

				if requestData then
					local offset = rowIndex <= 10 and playerPosition or currentPosition
					local exponent = priority[rowIndex]
					traverse(offset + requestData.pad, exponent)
					clamp(offset + requestData.target, exponent)
				end
			end
		else
			TweenService:SetCore("SendNotification", { Title = "Karasu Line Ups", Text = "Disabled.", Duration = 3 })

			for rowIndex = 1, deltaZ do
				local targetCharacter = value:FindFirstChild("pad" .. rowIndex)

				if targetCharacter then
					targetCharacter:Destroy()
				end
			end

			for rowIndex = 1, total do
				local targetCharacter = value:FindFirstChild("target" .. rowIndex)

				if targetCharacter then
					targetCharacter:Destroy()
				end
			end

			deltaZ = 0
			total = 0
		end
	end)

	bestPair:Toggle("Rin Flow Line Ups", "Rin's Kill Shot Line Ups.", function(x)
		if x then
			TweenService:SetCore("SendNotification", { Title = "Rin Flow Line Ups", Text = "Enabled.", Duration = 3 })
			local priority = {}
			local ffi = Color3.fromRGB(147, 112, 219)
			local graph = Color3.fromRGB(255, 0, 0)
			local parts = Color3.fromRGB(147, 112, 219)
			local safeExecute = Color3.fromRGB
			priority[1] = ffi
			priority[2] = graph
			priority[3] = parts

			do
				local packed = table.pack(safeExecute(255, 0, 0))
				table.move(packed, 1, packed.n, 4, priority)
			end

			local candidate = {
				{ pad = Vector3.new(158, -9, 321), target = Vector3.new(-12, 80, 54) },
				{ pad = Vector3.new(-187, -9, 290), target = Vector3.new(-29, 83, 20) },
				{ pad = Vector3.new(-117, -10, -320), target = Vector3.new(14, 80, -53) },
				{ pad = Vector3.new(198, -10, -265), target = Vector3.new(30, 90, -13) },
			}

			local characterModel = value:WaitForChild("map", 8)
			if not characterModel then
				return
			end
			local targetCharacter = characterModel
			local currentPosition = characterModel:FindFirstChild("Agoal").Position
			local playerPosition = targetCharacter:FindFirstChild("Bgoal").Position

			for rowIndex = 1, 4 do
				local requestData = candidate[rowIndex]

				if requestData then
					local offset = rowIndex <= 2 and playerPosition or currentPosition
					local exponent = priority[rowIndex]
					traverse(offset + requestData.pad, exponent)
					clamp(offset + requestData.target, exponent)
				end
			end
		else
			TweenService:SetCore("SendNotification", { Title = "Rin Flow Line Ups", Text = "Disabled.", Duration = 3 })

			for rowIndex = 1, deltaZ do
				local targetCharacter = value:FindFirstChild("pad" .. rowIndex)

				if targetCharacter then
					targetCharacter:Destroy()
				end
			end

			for rowIndex = 1, total do
				local targetCharacter = value:FindFirstChild("target" .. rowIndex)

				if targetCharacter then
					targetCharacter:Destroy()
				end
			end

			deltaZ = 0
			total = 0
		end
	end)

	local targetCharacter = node:Folder("Auto Position Features.", Color3.fromRGB(24, 255, 228), true)
	targetCharacter:Label("Auto Position: Automatically Sets Certain Positions.")
	local priority = { CF = false, GK = false, CFConn = nil, GKConn = nil }

	depth = depth or { fromstring = function(x)
		return x
	end }

	local function vectorLength()
		local resourceName = game:GetService("Players").LocalPlayer.Character
		if not resourceName then
			return
		end
		local vehicle = resourceName:FindFirstChild("HumanoidRootPart")
		if not vehicle then
			return
		end

		if (vehicle.Position - Vector3.new(-371, 13, -1599)).Magnitude <= 15 or (vehicle.Position - Vector3.new(-196, 13, -1599)).Magnitude <= 15 then
			game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable"):FireServer(depth.fromstring(header .. "\1\1\0A"))
			game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable"):FireServer(depth.fromstring(header .. "\1\1\0B"))
		end
	end

	local function vectorAdd()
		local resourceName = game:GetService("Players").LocalPlayer.Character
		if not resourceName then
			return
		end

		if not resourceName:FindFirstChild("HumanoidRootPart") then
			return
		end
		game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable"):FireServer(depth.fromstring(header .. "\5\1\0B"))
		game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable"):FireServer(depth.fromstring(header .. "\5\1\0A"))
	end

	targetCharacter:Toggle("Auto Pick CF", "Automatically Picks Center Field Position On Respawn Or Enable.", function()
		priority.CF = not priority.CF
		game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Auto Pick CF", Text = priority.CF and "Enabled." or "Disabled.", Duration = 1 })

		if priority.CF then
			priority.CFConn = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
				task.wait(0.3)
				vectorLength()
			end)

			task.spawn(function()
				while true do
					task.wait()
					if not (game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then
						continue
					end
					break
				end

				vectorLength()
			end)
		elseif priority.CFConn then
			priority.CFConn:Disconnect()
			priority.CFConn = nil
		end
	end)

	targetCharacter:Toggle("Auto Pick GK", "Automatically Picks Goalkeeper Position On Respawn Or Enable.", function()
		priority.GK = not priority.GK
		game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Auto Pick GK", Text = priority.GK and "Enabled." or "Disabled.", Duration = 1 })

		if priority.GK then
			priority.GKConn = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
				task.wait(0.3)
				vectorAdd()
			end)

			task.spawn(function()
				while true do
					task.wait()
					if not (game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then
						continue
					end
					break
				end

				vectorAdd()
			end)
		elseif priority.GKConn then
			priority.GKConn:Disconnect()
			priority.GKConn = nil
		end
	end)

	local requestData = node:Folder("Auto Goalkeeper Features.", Color3.fromRGB(24, 255, 228), true)
	requestData:Label("Auto Goalkeeper: Automatically Plays As GK For You.")

	requestData:Button("Auto GK Enhanced", "Click V To Toggle, Reset To Disable.", function()
		task.spawn(function()
			local playerObject = Players.LocalPlayer
			local resourceName = playerObject.Character or playerObject.CharacterAdded:Wait()
			local remoteEvent = resourceName:WaitForChild("Humanoid")
			local vehicle = resourceName:WaitForChild("HumanoidRootPart")
			local tweenInfo = Instance.new("ScreenGui")
			tweenInfo.ResetOnSpawn = false
			tweenInfo.Parent = playerObject.PlayerGui
			local label = Instance.new("Frame")
			label.Size = UDim2.new(0.012, 0, 0.025, 0)
			label.Position = UDim2.new(0.988, 0, 0.975, 0)
			label.BorderSizePixel = 0
			label.Parent = tweenInfo

			local candidate = {
				enabled = true,
				pause = false,
				look = nil,
				ballHolder = character.workspace.ballHolder,
				lastHolder = nil,
				remote = character:WaitForChild("ByteNetReliable"),
				map = value:WaitForChild("map"),
				GRAVITY = Vector3.new(0, -value.Gravity, 0),
				velSmooth = Vector3.zero,
				lastVel = Vector3.zero,
				tackleArgs = { depth.fromstring(sorter.base), { { "tackle" } } },
				emptyBuffer = depth.fromstring(sorter.grabball),
				magnetBurstActive = false,
				tackle_radius = 35,
				terrain = value.Terrain,
				cachedBall = nil,
				renderConn = nil,
				inputConn = nil,
				holderConn = nil,
				ballAdded = nil,
				ballRemoved = nil,
				diedConn = nil,
				charAddedConn = nil,
				look = Instance.new("AlignOrientation"),
			}

			candidate.look.Name = "AutoGKLook"
			candidate.look.Mode = Enum.OrientationAlignmentMode.OneAttachment
			candidate.look.Attachment0 = vehicle:WaitForChild("RootAttachment")
			candidate.look.Responsiveness = 1200
			candidate.look.MaxTorque = math.huge
			candidate.look.Enabled = false
			candidate.look.Parent = vehicle
			candidate.lastHolder = candidate.ballHolder.Value

			local function cleanup()
				label.BackgroundColor3 = candidate.enabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
			end

			local function heartbeatUpdate()
				candidate.enabled = false

				if candidate.renderConn then
					candidate.renderConn:Disconnect()
				end

				if candidate.inputConn then
					candidate.inputConn:Disconnect()
				end

				if candidate.holderConn then
					candidate.holderConn:Disconnect()
				end

				if candidate.ballAdded then
					candidate.ballAdded:Disconnect()
				end

				if candidate.ballRemoved then
					candidate.ballRemoved:Disconnect()
				end

				if candidate.diedConn then
					candidate.diedConn:Disconnect()
				end

				if candidate.charAddedConn then
					candidate.charAddedConn:Disconnect()
				end

				if candidate.look then
					candidate.look:Destroy()
				end

				if tweenInfo then
					tweenInfo:Destroy()
				end
			end

			candidate.holderConn = candidate.ballHolder.Changed:Connect(function(maximum)
				if candidate.lastHolder == resourceName and maximum == nil then
					candidate.pause = true

					task.delay(2.6, function()
						candidate.pause = false
					end)
				end

				candidate.lastHolder = maximum
			end)

			candidate.ballAdded = candidate.terrain.ChildAdded:Connect(function(smallest)
				if smallest.Name == "Ball" then
					candidate.cachedBall = smallest
				end
			end)

			candidate.ballRemoved = candidate.terrain.ChildRemoved:Connect(function(smallest)
				if smallest == candidate.cachedBall then
					candidate.cachedBall = nil
				end
			end)

			local function generateRandomString(x, playerIdentifier, deltaTime, playerId)
				if not playerId then
					return nil
				end
				local angle = playerId.CFrame
				local vectorB = angle.LookVector
				local delta = x - angle.Position
				local vectorA = 0.5 * deltaTime:Dot(vectorB)
				local exponent = playerIdentifier:Dot(vectorB)
				local alpha = delta:Dot(vectorB)

				if math.abs(vectorA) < 1e-06 then
					if math.abs(exponent) < 1e-06 then
						return nil
					end
					local difference = -alpha / exponent
					return difference > 0 and difference
				end

				local difference = exponent * exponent - 4 * vectorA * alpha
				if difference < 0 then
					return nil
				end
				local magnitude = math.sqrt(difference)
				local offsetY = (-exponent - magnitude) / 2 * vectorA
				local offsetX = (-exponent + magnitude) / 2 * vectorA
				return offsetY > 0 and offsetY or offsetX > 0 and offsetX
			end

			candidate.renderConn = index.RenderStepped:Connect(function(radius)
				if not candidate.enabled then
					return
				end
				local ok = candidate.cachedBall
				if not ok or playerObject.Team == game.Teams.lobby or candidate.pause then
					candidate.look.Enabled = false
					return
				end
				local playerCharacter = candidate.ballHolder.Value

				if playerCharacter and playerCharacter ~= resourceName and playerCharacter:FindFirstChild("HumanoidRootPart") then
					local textButton = playerCharacter.HumanoidRootPart
					candidate.look.Enabled = true
					candidate.look.CFrame = CFrame.lookAt(vehicle.Position, Vector3.new(textButton.Position.X, vehicle.Position.Y, textButton.Position.Z))
				else
					candidate.velSmooth = candidate.velSmooth:Lerp(ok.AssemblyLinearVelocity, math.clamp(radius * 15, 0, 1))
					local delta = (candidate.velSmooth - candidate.lastVel) / math.max(radius, 0.0041666666666666666)
					candidate.lastVel = candidate.velSmooth
					local exponent = generateRandomString(ok.Position, candidate.velSmooth, delta, playerObject.Team == game.Teams.B and candidate.map.Bgoal or playerObject.Team == game.Teams.A and candidate.map.Agoal)
					local vectorA

					if exponent then
						vectorA = ok.Position + candidate.velSmooth * exponent + 0.5 * delta * exponent ^ 2
					else
						vectorA = ok.Position + candidate.velSmooth * 0.25 + 0.5 * candidate.GRAVITY * 0.0625
					end

					candidate.look.Enabled = true
					candidate.look.CFrame = CFrame.lookAt(vehicle.Position, Vector3.new(vectorA.X, vehicle.Position.Y, vectorA.Z))
				end

				local speed = (vehicle.Position - ok.Position).Magnitude

				if speed > candidate.tackle_radius and speed <= 37 and ok.Position.Y > vehicle.Position.Y + 4 then
					remoteEvent.Jump = true
				end

				if speed <= candidate.tackle_radius then
					candidate.remote:FireServer(index5(candidate.tackleArgs))

					if not candidate.magnetBurstActive then
						candidate.magnetBurstActive = true

						task.spawn(function()
							local timestamp = os.clock()

							while os.clock() - timestamp < 0.897 and candidate.enabled do
								candidate.remote:FireServer(candidate.emptyBuffer)
								task.wait(0.125)
							end

							candidate.magnetBurstActive = false
						end)
					end
				end
			end)

			candidate.inputConn = UserInputService.InputBegan:Connect(function(inputObject, gameProcessed)
				if gameProcessed then
					return
				end

				if inputObject.KeyCode == Enum.KeyCode.V then
					candidate.enabled = not candidate.enabled
					cleanup()

					if not candidate.enabled then
						candidate.look.Enabled = false
					end
				end
			end)

			candidate.diedConn = remoteEvent.Died:Connect(heartbeatUpdate)
			candidate.charAddedConn = playerObject.CharacterAdded:Connect(heartbeatUpdate)
			cleanup()
		end)
	end)

	requestData:Button("Auto GK Classic", "Reset Or Click F4 To Disable.", function()
		local candidate = {
			plr = Players.LocalPlayer,
			char = nil,
			cam = workspace.CurrentCamera,
			hum = nil,
			hrp = nil,
			originalCamType = nil,
			originalCamCFrame = nil,
			guii = nil,
			cambu = nil,
			gerg = nil,
			dot = nil,
			kind = "",
			align = nil,
			onn = true,
			pause = false,
			ballHolder = nil,
			lastHolder = nil,
			remote = nil,
			con = nil,
			kill = nil,
		}

		candidate.char = candidate.plr.Character or candidate.plr.CharacterAdded:Wait()
		candidate.hum = candidate.char:WaitForChild("Humanoid")
		candidate.hrp = candidate.char:WaitForChild("HumanoidRootPart")
		candidate.originalCamType = candidate.cam.CameraType
		candidate.originalCamCFrame = candidate.cam.CFrame
		candidate.guii = Instance.new("ScreenGui")
		candidate.guii.Parent = candidate.plr.PlayerGui
		candidate.cambu = Instance.new("TextButton")
		candidate.cambu.Text = "Camera Mode"
		candidate.cambu.Size = UDim2.new(0.159, 0, 0.109, 0)
		candidate.cambu.Position = UDim2.new(0.317, 0, 0.444, 0)
		candidate.cambu.TextScaled = true
		candidate.cambu.Parent = candidate.guii
		candidate.gerg = Instance.new("TextButton")
		candidate.gerg.Text = "Body Mode"
		candidate.gerg.Size = UDim2.new(0.159, 0, 0.109, 0)
		candidate.gerg.Position = UDim2.new(0.524, 0, 0.444, 0)
		candidate.gerg.TextScaled = true
		candidate.gerg.Parent = candidate.guii
		candidate.dot = Instance.new("Frame")
		candidate.dot.Size = UDim2.new(0.012, 0, 0.025, 0)
		candidate.dot.Position = UDim2.new(0.988, 0, 0.975, 0)
		candidate.dot.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		candidate.dot.BorderSizePixel = 0
		candidate.dot.Parent = candidate.guii

		candidate.cambu.MouseButton1Up:Connect(function()
			candidate.kind = "cam"
		end)

		candidate.gerg.MouseButton1Up:Connect(function()
			candidate.kind = "body"
		end)

		repeat
			task.wait()
		until candidate.kind ~= ""

		candidate.cambu:Destroy()
		candidate.gerg:Destroy()

		local function cleanup()
			return workspace.Terrain:FindFirstChild("Ball")
		end

		if candidate.kind == "body" then
			candidate.hum.AutoRotate = false
			candidate.align = Instance.new("AlignOrientation")
			candidate.align.Mode = Enum.OrientationAlignmentMode.OneAttachment
			candidate.align.Attachment0 = candidate.hrp:WaitForChild("RootAttachment")
			candidate.align.Responsiveness = 300
			candidate.align.MaxTorque = math.huge
			candidate.align.Enabled = false
			candidate.align.Parent = candidate.hrp
		end

		candidate.ballHolder = character.workspace.ballHolder
		candidate.lastHolder = candidate.ballHolder.Value

		candidate.ballHolder.Changed:Connect(function()
			local valueType = candidate.ballHolder.Value

			if candidate.lastHolder == candidate.char and valueType == nil then
				candidate.pause = true

				task.delay(0.7, function()
					candidate.pause = false
				end)
			end

			candidate.lastHolder = valueType
		end)

		candidate.remote = character:WaitForChild("ByteNetReliable")

		local function heartbeatUpdate()
			candidate.onn = false

			if candidate.align then
				candidate.align:Destroy()
			end

			candidate.cam.CameraType = candidate.originalCamType
			candidate.cam.CFrame = candidate.originalCamCFrame

			if candidate.guii then
				candidate.guii:Destroy()
			end
		end

		candidate.con = index.RenderStepped:Connect(function()
			if not candidate.onn then
				candidate.con:Disconnect()
				return
			end
			local exponent = cleanup()

			if not exponent or candidate.plr.Team == game.Teams.lobby or candidate.pause then
				if candidate.align then
					candidate.align.Enabled = false
				end

				return
			end

			if candidate.kind == "cam" then
				candidate.cam.CameraType = Enum.CameraType.Scriptable
				candidate.cam.CFrame = CFrame.lookAt(candidate.cam.CFrame.Position, exponent.Position)
			elseif candidate.kind == "body" then
				candidate.align.Enabled = true
				local delta = exponent.Position - candidate.hrp.Position
				local velocity = Vector3.new(delta.X, 0, delta.Z)

				if velocity.Magnitude > 0.01 then
					candidate.align.CFrame = CFrame.lookAt(Vector3.zero, velocity)
				end
			end

			if (candidate.hrp.Position - exponent.Position).Magnitude <= 60 then
				if candidate.hrp.Position.Y + 6 <= exponent.Position.Y then
					candidate.hum.Jump = true
				else
					candidate.hum.Jump = false
				end

				candidate.remote:FireServer(depth.fromstring(sorter.base), { { "tackle" } })
			end
		end)

		candidate.kill = UserInputService.InputBegan:Connect(function(inputObject, gameProcessed)
			if gameProcessed then
				return
			end

			if inputObject.KeyCode == Enum.KeyCode.F4 then
				heartbeatUpdate()
				candidate.kill:Disconnect()
				candidate.con:Disconnect()
			end
		end)

		while true do
			task.wait()
			if not (candidate.hum.Health <= 0 or candidate.plr.Team == game.Teams.lobby) then
				continue
			end
			break
		end

		heartbeatUpdate()
		candidate.kill:Disconnect()
		candidate.con:Disconnect()
	end)

	local exponent = node:Folder("Air Dribble Features.", Color3.fromRGB(24, 255, 228), true)
	exponent:Label("Air Dribble: Dribbles The Ball Through The Air.")
	local bestDistance = Enum.KeyCode.LeftAlt
	local candidate = { enabled = false, isHolding = false, lastKick = 0 }
	local delta = 0.255

	local function cleanup(x)
		game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Air Dribble", Text = x, Duration = 2 })
	end

	exponent:Toggle("Air Dribble", "Kicks The Ball Forward Infront Of You And Up.", function()
		candidate.enabled = not candidate.enabled
		cleanup(candidate.enabled and "Enabled." or "Disabled.")
	end)

	exponent:Textbox("Air Dribble Bind", "Enter Key (Example: E, Q, LeftAlt.)", function(x)
		if typeof(x) ~= "string" then
			bestDistance = Enum.KeyCode.LeftAlt
			cleanup("Invalid Key. Bind Is Now LeftAlt.")
			return
		end

		local sourceString = x:gsub("%s+", "")

		local decoded, model = pcall(function()
			return Enum.KeyCode[sourceString]
		end)

		if decoded and model then
			bestDistance = model
			cleanup("Bind Set To: " .. model.Name)
		else
			bestDistance = Enum.KeyCode.LeftAlt
			cleanup("Invalid Key. Bind Is Now LeftAlt.")
		end
	end)

	local playerObject = Players.LocalPlayer
	local hash = nil

	local function heartbeatUpdate()
		local alpha = index2()
		if alpha - candidate.lastKick < delta then
			return
		end
		local resourceName = playerObject.Character
		local remoteEvent = resourceName and resourceName:FindFirstChildOfClass("Humanoid")
		resourceName = resourceName and resourceName:FindFirstChild("HumanoidRootPart")
		if not (remoteEvent and resourceName) then
			return
		end
		candidate.lastKick = alpha
		local errorMessage = Instance.new("Animation")
		errorMessage.AnimationId = "rbxassetid://76587445975710"
		remoteEvent:LoadAnimation(errorMessage):Play()
		local vectorB = resourceName.CFrame.LookVector
		local velocity = Vector3.new(vectorB.X * 0.75, 0.65, vectorB.Z * 0.75)
		character:WaitForChild("ByteNetReliable"):FireServer(depth.fromstring(sorter.base), { { "kick", 28, false, velocity } })
	end

	UserInputService.InputBegan:Connect(function(inputObject, gameProcessed)
		if gameProcessed or inputObject.KeyCode ~= bestDistance then
			return
		end

		if not candidate.enabled then
			return
		end
		candidate.isHolding = true
		heartbeatUpdate()

		if hash then
			hash:Disconnect()
		end

		hash = index.Heartbeat:Connect(function()
			if candidate.isHolding and candidate.enabled then
				heartbeatUpdate()
			else
				hash:Disconnect()
				hash = nil
			end
		end)
	end)

	UserInputService.InputEnded:Connect(function(inputObject)
		if inputObject.KeyCode == bestDistance then
			candidate.isHolding = false

			if hash then
				hash:Disconnect()
				hash = nil
			end
		end
	end)

	local alpha = node:Folder("Other Features.", Color3.fromRGB(24, 255, 228), true)
	alpha:Label("Other Features: Self Explanatory, Other Silent Features.")
	local playerData = { enabled = false }

	alpha:Toggle("Auto QuickTimeEvent", "Automatically Does QuickTimeEvents, How Else Can I Explain It?", function()
		playerData.enabled = not playerData.enabled

		local function generateRandomString(x)
			if not turret.suppressNotifs then
				game:GetService("StarterGui"):SetCore("SendNotification", { Title = "QuickTimeEvent", Text = x, Duration = 1 })
			end
		end

		local function subtractVectors(x)
			return ({
				["1"] = "One",
				["2"] = "Two",
				["3"] = "Three",
				["4"] = "Four",
				["5"] = "Five",
				["6"] = "Six",
				["7"] = "Seven",
				["8"] = "Eight",
				["9"] = "Nine",
				["0"] = "Zero",
			})[x] or x
		end

		local function crossProduct(x)
			return x.G > x.R and x.G > x.B
		end

		game:GetService("RunService").RenderStepped:Connect(function()
			local ServerStorage = game:GetService("Players").LocalPlayer

			if playerData.enabled and ServerStorage and ServerStorage:FindFirstChild("PlayerGui") then
				local existing = ServerStorage.PlayerGui:FindFirstChild("Qte")

				if existing and existing:FindFirstChild("QTE") then
					for _, descendant in index3(existing.QTE:GetDescendants()) do
						if descendant:IsA("Frame") or descendant:IsA("TextLabel") then
							if crossProduct(descendant.BackgroundColor3) then
								local titleLabel = existing.QTE:FindFirstChild("TextLabel")

								if titleLabel then
									local magnitude = Enum.KeyCode[subtractVectors(titleLabel.Text)]

									if magnitude then
										game:GetService("VirtualInputManager"):SendKeyEvent(true, magnitude, false, game)
										game:GetService("VirtualInputManager"):SendKeyEvent(false, magnitude, false, game)
									end
								end

								break
							end
						end
					end
				end
			end
		end)

		generateRandomString(playerData.enabled and "Enabled." or "Disabled.")
	end)

	getgenv().AutoStealState = getgenv().AutoStealState or { enabled = false, connections = {} }
	state = getgenv().AutoStealState

	alpha:Toggle("Auto Steal Ball", "Automatically Attempts To Steal When Opponent Normal Kicks The Ball.", function(chunk)
		Players = game:GetService("Players")
		index = game:GetService("RunService")
		lp = Players.LocalPlayer
		state.enabled = chunk
		animId = "rbxassetid://76587445975710"

		getHRP = function(x)
			return x and x:FindFirstChild("HumanoidRootPart")
		end

		stareAt = function(x)
			char = lp.Character
			newPart = getHRP(char)
			if not newPart or not x then
				return
			end

			if (newPart.Position - x.Position).Magnitude > 20 then
				return
			end
			start = index2()

			conn = index.RenderStepped:Connect(function()
				local offset = not state.enabled

				if not offset then
					local magnitude = start
					offset = index2() - magnitude > 0.5
				end

				if offset then
					conn:Disconnect()
					return
				end
				pos = newPart.Position
				tpos = x.Position
				newPart.CFrame = CFrame.lookAt(pos, Vector3.new(tpos.X, pos.Y, tpos.Z))
				local list = { depth.fromstring(sorter.base), { { "tackle" } } }
				game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable"):FireServer(index5(list))
			end)
		end

		hookCharacter = function(x, playerIdentifier)
			hum = playerIdentifier:WaitForChild("Humanoid")
			animator = hum:WaitForChild("Animator")

			conn = animator.AnimationPlayed:Connect(function(deltaTime)
				if not state.enabled then
					return
				end

				if deltaTime.Animation and deltaTime.Animation.AnimationId == animId then
					stareAt(getHRP(playerIdentifier), x)
				end
			end)

			table.insert(state.connections, conn)
		end

		hookPlayer = function(x)
			if x == lp then
				return
			end

			if x.Character then
				hookCharacter(x, x.Character)
			end

			table.insert(state.connections, x.CharacterAdded:Connect(function(playerEntity)
				hookCharacter(x, playerEntity)
			end))
		end

		if not chunk then
			for _, point in index3(state.connections) do
				point:Disconnect()
			end

			table.clear(state.connections)
			game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Auto Steal", Text = "Disabled.", Duration = 2 })
			return
		end

		game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Auto Steal", Text = "Enabled.", Duration = 2 })

		for _, edge in index3(Players:GetPlayers()) do
			hookPlayer(edge)
		end

		table.insert(state.connections, Players.PlayerAdded:Connect(hookPlayer))
	end)

	local list = { enabled = false }

	alpha:Toggle("Auto Formless (Bind: Y)", "Shidou Only Formless Macro.", function()
		list.enabled = not (list.enabled or false)
		game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Auto Formless", Text = list.enabled and "Enabled." or "Disabled.", Duration = 2 })

		if list.inputConnection then
			list.inputConnection:Disconnect()
			list.inputConnection = nil
		end

		if list.enabled then
			list.inputConnection = game:GetService("UserInputService").InputBegan:Connect(function(inputObject, gameProcessed)
				if gameProcessed or inputObject.KeyCode ~= Enum.KeyCode.Y then
					return
				end
				local magnitude = game
				local element = Enum.MouseBehavior.LockCenter
				if magnitude:GetService("UserInputService").MouseBehavior ~= element then
					return
				end
				local ServerStorage = game:GetService("Players").LocalPlayer
				local resourceName = ServerStorage.Character
				local vehicle = resourceName and resourceName:FindFirstChild("HumanoidRootPart")
				local remoteEvent = resourceName and resourceName:FindFirstChildOfClass("Humanoid")
				if not vehicle or not remoteEvent then
					return
				end
				remoteEvent.AutoRotate = false
				local primaryPart = workspace.CurrentCamera
				local sum = primaryPart.CameraType
				local coroutineHandle = primaryPart.CameraSubject
				local angle = primaryPart.CFrame * CFrame.Angles(0, 3.1415926535897931, 0)
				primaryPart.CameraType = Enum.CameraType.Scriptable
				primaryPart.CFrame = angle

				task.delay(0.1, function()
					if ServerStorage.Character and ServerStorage.Character:FindFirstChildOfClass("Humanoid") then
						primaryPart.CameraSubject = ServerStorage.Character:FindFirstChildOfClass("Humanoid")
						primaryPart.CameraType = Enum.CameraType.Custom
					else
						primaryPart.CameraSubject = coroutineHandle
						primaryPart.CameraType = sum
					end

					remoteEvent.AutoRotate = true
				end)

				task.wait(0.15)
				local errorMessage = Instance.new("Animation")
				errorMessage.AnimationId = "rbxassetid://76587445975710"
				remoteEvent:LoadAnimation(errorMessage):Play()
				local vectorB = vehicle.CFrame.LookVector
				local thread = vector.create(vectorB.X * 0.5, 1, vectorB.Z * 0.5)
				game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable"):FireServer(depth.fromstring(sorter.base), { { "kick", 25, false, thread } })
				game:GetService("ReplicatedStorage"):WaitForChild("ByteNetReliable"):FireServer(depth.fromstring(sorter.base), { { "skill1" } })
			end)
		end
	end)

	local config = { nocutscene = false }

	alpha:Toggle("No Cutscene", "Shitty Feature For Right Now That Disables Cutscenes.", function()
		config.nocutscene = not config.nocutscene
		local HttpService = game:GetService("StarterGui")
		local Workspace = game:GetService("SoundService")
		local entry = Workspace:FindFirstChild("azltemp") or Instance.new("Folder", Workspace)
		entry.Name = "azltemp"
		local object = Workspace:FindFirstChild("football-crowd-3-69245") or entry:FindFirstChild("football-crowd-3-69245")
		HttpService:SetCore("SendNotification", { Title = "No Cutscene", Text = config.nocutscene and "Enabled." or "Disabled.", Duration = 1 })

		if config.nocutscene then
			if object and object:IsDescendantOf(Workspace) then
				object:Clone().Parent = entry
				object:Stop()
				object:Destroy()
			end
		else
			local leaderstats = entry:FindFirstChild("football-crowd-3-69245")

			if leaderstats then
				leaderstats.Parent = Workspace
				leaderstats:Play()
			end
		end
	end)

	local configuration = {
		enabled = false,
		activeDots = {},
		dotSize = UDim2.new(0, 6, 0, 6),
		offset = Vector3.new(0, 3, 0),
		updateInterval = 0.2,
	}

	alpha:Toggle("IFrame Indicator", "Shows The I-Frame Status Of All Players. (Green = Off, Red = On.)", function()
		configuration.enabled = not configuration.enabled
		game:GetService("StarterGui"):SetCore("SendNotification", { Title = "IFrame Indicator", Text = configuration.enabled and "Enabled." or "Disabled.", Duration = 3 })
		local targetPlayer = workspace:FindFirstChild("characters")
		if not targetPlayer then
			return
		end

		local function generateRandomString(x)
			if configuration.activeDots[x] then
				return
			end
			local vehicle = x:FindFirstChild("HumanoidRootPart")
			if not vehicle then
				return
			end
			local frame = Instance.new("BillboardGui")
			frame.Name = "IframeDot"
			frame.Size = UDim2.new(0, 12, 0, 12)
			frame.StudsOffset = configuration.offset
			frame.AlwaysOnTop = true
			frame.Adornee = vehicle
			frame.Parent = vehicle
			local label = Instance.new("Frame")
			label.Size = configuration.dotSize
			label.Position = UDim2.new(0.5, -3, 0.5, -3)
			label.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
			label.BorderSizePixel = 0
			label.BackgroundTransparency = 0
			label.Parent = frame
			configuration.activeDots[x] = label
		end

		local function subtractVectors(x, playerIdentifier)
			local currencyStat = x:FindFirstChild("state")
			currencyStat = currencyStat and currencyStat:FindFirstChild("iframe")

			if currencyStat and currencyStat:IsA("BoolValue") then
				playerIdentifier.BackgroundColor3 = currencyStat.Value and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
			else
				playerIdentifier.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
			end
		end

		local function crossProduct()
			for _, i in index4(configuration.activeDots) do
				if i and i.Parent then
					i.Parent:Destroy()
				end
			end

			configuration.activeDots = {}
		end

		if configuration.enabled then
			for _, child in index3(targetPlayer:GetChildren()) do
				generateRandomString(child)
			end

			targetPlayer.ChildAdded:Connect(function(smallest)
				task.wait(0.5)

				if configuration.enabled then
					generateRandomString(smallest)
				end
			end)

			task.spawn(function()
				while configuration.enabled do
					for line, i in index4(configuration.activeDots) do
						if line and i then
							subtractVectors(line, i)
						end
					end

					for _, child in index3(targetPlayer:GetChildren()) do
						if not configuration.activeDots[child] then
							generateRandomString(child)
						end
					end

					task.wait(configuration.updateInterval)
				end
			end)
		else
			crossProduct()
		end
	end)

	alpha:Button("Fix Duplicate Ball", "I Don't Know If This Is Still An Issue But Removes Duplicate Balls If Existent.", function()
		for _, descendant in index3(workspace.Terrain:GetDescendants()) do
			if descendant:IsA("MeshPart") and descendant.Name == "Ball" then
				descendant:Destroy()
			end
		end
	end)

	result:Label("Movesets, Recommend Using In Normal Servers.")

	result:Button("Goku Moveset (Req. Isagi)", "Click F4 To Disable.", function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/ghostofcelleron/Celeron/refs/heads/main/goku%20moveset%20(azl)", true))()
	end)

	result:Button("Aizen Moveset (Req. Isagi)", "Click F4 To Disable.", function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/ghostofcelleron/Celeron/refs/heads/main/aizen%20moveset", true))()
	end)

	result:Button("Loki Moveset (V2) (Req. Isagi.)", "Click F4 To Disable, Rejoin To Fix Isagi Music.", function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/ghostofcelleron/Celeron/refs/heads/main/loki%20v2"))()
	end)

	result:Button("Ronaldo Moveset (V3) (Req. Shidou)", "Click F4 To Disable.", function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/ghostofcelleron/Celeron/refs/heads/main/ronaldov3"))()
	end)

	result:Label("More Movesets.")

	result:Button("Gojo Moveset (Req. Isagi.)", "Click F4 To Disable.", function()
		loadstring(game:HttpGet("https://pastebin.com/raw/TH8xDy9X"))()
	end)

	result:Button("Hugo Moveset (Early Access.) (Req. Kunigami)", "Click F4 To Disable, Rejoin To Fix Kunigami Music.", function()
		loadstring(game:HttpGet("https://pastebin.com/raw/ND6yrPyk"))()
	end)

	result:Button("Naoya Moveset (Req. Sae)", "Click F4 To Disable.", function()
		loadstring(game:HttpGet("https://pastebin.com/raw/PDwm0ZcF"))()
	end)

	result:Button("Lore Sae Moveset (Req. Sae.)", "Rejoin To Disable.", function()
		loadstring(game:HttpGet("https://pastebin.com/raw/kMQ0v88u"))()
	end)

	part:Button("Spawn Area", function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-269, 4, -1599)
	end)

	part:Button("Middle Field", function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-540, 3, 1274)
	end)

	part:Button("Commentator Area", function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6, 2, 3237)
	end)

	part:Button("Goal Box (A)", function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-537, 3, 1575)
	end)

	part:Button("Goal Box (B)", function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-534, 3, 974)
	end)
end

lerp()
local position = instance5:AddTab("Settings")
instance3:SetLibrary(notifyExport)

pcall(function()
	instance3:ApplyToTab(position)
end)

instance4:SetLibrary(notifyExport)

pcall(function()
	instance4:IgnoreThemeSettings()
end)

pcall(function()
	instance4:SetFolder("AzureLatchCitra")
end)

pcall(function()
	instance4:BuildConfigSection(position)
end)

local container = position:AddLeftGroupbox("Citra Hub")
container:AddLabel("Azure Latch  |  Citra Hub")
container:AddLabel("Toggle GUI: Right Alt / Right Shift")
container:AddLabel("UI: Citra Hub")

container:AddButton({
	Text = "Unload Menu",
	DoubleClick = true,
	Tooltip = "Double-click. Closes the menu -- rejoin to fully stop features that are already running.",
	Func = function()
		pcall(function()
			notifyExport:Unload()
		end)
	end,
})

pcall(function()
	instance5:Init()
end)

pcall(function()
	instance4:LoadAutoloadConfig()
end)

notifyExport:Notify("Azure Latch | Citra Hub loaded.", 4)
