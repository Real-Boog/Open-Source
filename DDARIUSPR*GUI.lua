-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf
-- this is for alkedion (ORIGINAL SCRIPT FROM [https://rscripts.net/script/insta-kill-esp-auto-kill-enemies-trigger-bot-3Bog])

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")
local CurrentCamera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local tbl = {
	Bg = Color3.fromRGB(14, 12, 22),
	Glass = Color3.fromRGB(24, 20, 36),
	GlassLight = Color3.fromRGB(34, 28, 50),
	Accent1 = Color3.fromRGB(138, 92, 246),
	Accent2 = Color3.fromRGB(56, 214, 214),
	Accent3 = Color3.fromRGB(246, 92, 178),
	Text = Color3.fromRGB(238, 236, 245),
	SubText = Color3.fromRGB(158, 152, 176),
	Stroke = Color3.fromRGB(70, 62, 96),
	Warning = Color3.fromRGB(255, 200, 50),
}

tbl.Font = Enum.Font.GothamMedium
tbl.FontBold = Enum.Font.GothamBold
local tweenInfo = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local tweenInfo1 = TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function func(className, arg2, arg3)
	local instance = Instance.new(className)

	for k, v1 in pairs(arg2 or {}) do
		instance[k] = v1
	end

	for _, v2 in ipairs(arg3 or {}) do
		v2.Parent = instance
	end

	return instance
end

local function func1(arg1)
	return (func("UICorner", {CornerRadius = UDim.new(0, arg1 or 12)}))
end

local function func2(arg1, arg2, arg3)
	return (func("UIStroke", {Color = arg1 or tbl.Stroke, Thickness = arg2 or 1, Transparency = arg3 or 0.5}))
end

local function func3(arg1, arg2)
	return (func("UIGradient", {Rotation = arg1 or 0, Color = arg2 or ColorSequence.new(tbl.Accent1, tbl.Accent3)}))
end

local function func4(arg1, arg2, arg3)
	local tween = TweenService:Create(arg1, arg2, arg3)
	tween:Play()
	return tween
end

local function func5(arg1, arg2)
	local MouseLocation = UserInputService:GetMouseLocation()
	local v1 = math.max(arg1.AbsoluteSize.X, arg1.AbsoluteSize.Y) * 1.6

	local v2 = func("Frame", {
		BackgroundColor3 = arg2 or tbl.Accent1,
		BackgroundTransparency = 0.55,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromOffset(MouseLocation.X - arg1.AbsolutePosition.X, MouseLocation.Y - arg1.AbsolutePosition.Y),
		Size = UDim2.fromOffset(0, 0),
		ZIndex = 5,
		Parent = arg1,
	})

	func1(999).Parent = v2

	func4(
		v2,
		TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
		{Size = UDim2.fromOffset(v1, v1), BackgroundTransparency = 1}
	)

	task.delay(0.5, function()
		v2:Destroy()
	end)
end

local function func6(arg1, arg2)
	local flag
	local Position
	local Position1

	arg1.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			flag = true
			Position = input.Position
			Position1 = arg2.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					flag = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if flag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local v1 = input.Position - Position
			arg2.Position = UDim2.new(Position1.X.Scale, Position1.X.Offset + v1.X, Position1.Y.Scale, Position1.Y.Offset + v1.Y)
		end
	end)
end

local DDARIUSPR_GUI = PlayerGui:FindFirstChild("DDARIUSPR_GUI")

if DDARIUSPR_GUI then
	DDARIUSPR_GUI:Destroy()
end

local v1 = func("ScreenGui", {
	Name = "DDARIUSPR_GUI",
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	Parent = PlayerGui,
})

local v2 = func("Frame", {
	Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = tbl.Bg,
	BackgroundTransparency = 0,
	ZIndex = 50,
	Parent = v1,
})

local tbl1 = {}

for i = 1, 3 do
	local v3 = func("Frame", {
		Size = UDim2.fromOffset(340, 340),
		BackgroundColor3 = ({tbl.Accent1, tbl.Accent2, tbl.Accent3})[i],
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		ZIndex = 50,
		Parent = v2,
	})

	func1(999).Parent = v3
	table.insert(tbl1, v3)

	func4(
		v3,
		TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		{BackgroundTransparency = 0.86, Position = UDim2.fromScale(0.35 + i * 0.12, 0.4 + i * 0.08)}
	)
end

local v4 = func("Frame", {
	Size = UDim2.fromOffset(400, 60),
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.46),
	BackgroundTransparency = 1,
	ZIndex = 51,
	Parent = v2,
})

func("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	HorizontalAlignment = Enum.HorizontalAlignment.Center,
	VerticalAlignment = Enum.VerticalAlignment.Center,
}).Parent = v4

for i1 = 1, 13 do
	local v5 = func("TextLabel", {
		Text = ("DDARIUSPR*GUI"):sub(i1, i1),
		Font = tbl.FontBold,
		TextSize = ("DDARIUSPR*GUI"):sub(i1, i1) == "*" and 40 or 32,
		TextColor3 = ("DDARIUSPR*GUI"):sub(i1, i1) == "*" and tbl.Accent2 or tbl.Text,
		TextTransparency = 1,
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(34, 60),
		ZIndex = 51,
		Parent = v4,
	})

	v5.Position = UDim2.fromOffset(0, 20)

	task.delay(i1 * 0.06, function()
		func4(v5, tweenInfo, {TextTransparency = 0, Position = UDim2.fromOffset(0, 0)})
	end)
end

local v6 = func("TextLabel", {
	Text = "sub to DD",
	Font = tbl.Font,
	TextSize = 14,
	TextColor3 = tbl.SubText,
	TextTransparency = 1,
	BackgroundTransparency = 1,
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.56),
	Size = UDim2.fromOffset(400, 20),
	ZIndex = 51,
	Parent = v2,
})

task.delay(0.55, function()
	func4(v6, tweenInfo1, {TextTransparency = 0})
end)

local v7 = func("Frame", {
	Size = UDim2.fromOffset(0, 0),
	Position = UDim2.new(0.5, -240, 0.5, -160),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = tbl.Glass,
	BackgroundTransparency = 0.15,
	BorderSizePixel = 0,
	ClipsDescendants = true,
	ZIndex = 60,
	Parent = v1,
	Visible = false,
})

func1(18).Parent = v7
func2(tbl.Warning, 2, 0.6).Parent = v7

func("TextLabel", {
	Text = "⚠️",
	Font = Enum.Font.SourceSansBold,
	TextSize = 48,
	TextColor3 = tbl.Warning,
	BackgroundTransparency = 1,
	Size = UDim2.fromOffset(60, 60),
	Position = UDim2.new(0.5, -30, 0, 20),
	ZIndex = 62,
	Parent = v7,
})

func("TextLabel", {
	Text = "READ INFO BEFORE USING",
	Font = tbl.FontBold,
	TextSize = 22,
	TextColor3 = tbl.Warning,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, -40, 0, 30),
	Position = UDim2.new(0.5, 0, 0, 75),
	AnchorPoint = Vector2.new(0.5, 0),
	ZIndex = 62,
	Parent = v7,
})

func("TextLabel", {
	Text = "Make sure to read the Info tab for tips\nand important warnings before using features.",
	Font = tbl.Font,
	TextSize = 14,
	TextColor3 = tbl.SubText,
	TextXAlignment = Enum.TextXAlignment.Center,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, -40, 0, 40),
	Position = UDim2.new(0.5, 0, 0, 115),
	AnchorPoint = Vector2.new(0.5, 0),
	ZIndex = 62,
	Parent = v7,
})

local v8 = func("TextButton", {
	Text = "OKAY",
	Font = tbl.FontBold,
	TextSize = 18,
	TextColor3 = tbl.Text,
	BackgroundColor3 = tbl.Accent1,
	Size = UDim2.fromOffset(160, 44),
	Position = UDim2.new(0.5, -80, 0, 230),
	AnchorPoint = Vector2.new(0.5, 0),
	ZIndex = 62,
	Parent = v7,
})

func1(10).Parent = v8

v8.MouseButton1Click:Connect(function()
	func4(v7, tweenInfo1, {Size = UDim2.fromOffset(0, 0)})
	task.delay(0.3, function()
		v7.Visible = false
	end)
end)

v8.MouseEnter:Connect(function()
	func4(v8, tweenInfo2, {BackgroundColor3 = tbl.Accent2})
end)

v8.MouseLeave:Connect(function()
	func4(v8, tweenInfo2, {BackgroundColor3 = tbl.Accent1})
end)

local v9 = func("Frame", {
	Name = "Main",
	Size = UDim2.fromOffset(0, 0),
	Position = UDim2.new(0.5, 0, 0.5, 0),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = tbl.Bg,
	BorderSizePixel = 0,
	ClipsDescendants = true,
	ZIndex = 2,
	Parent = v1,
})

func1(18).Parent = v9
func2(tbl.Stroke, 1, 0.3).Parent = v9

local v10 = func("Frame", {
	Size = UDim2.fromScale(1, 1),
	BackgroundTransparency = 1,
	ClipsDescendants = true,
	ZIndex = 2,
	Parent = v9,
})

local tbl2 = {tbl.Accent1, tbl.Accent2, tbl.Accent3}
local tbl3 = {}

for i2 = 1, 3 do
	local v11 = func("Frame", {
		Size = UDim2.fromOffset(260, 260),
		BackgroundColor3 = tbl2[i2],
		BackgroundTransparency = 0.82,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.2 * i2, 0.3 * i2),
		ZIndex = 2,
		Parent = v10,
	})

	func1(999).Parent = v11
	table.insert(tbl3, v11)
end

task.spawn(function()
	local num = 0
	while v9.Parent do
		num = num + RunService.Heartbeat:Wait()
		for i, v1 in ipairs(tbl3) do
			v1.Position = UDim2.fromScale(0.5 + math.sin(num * 0.15 + i * 2) * 0.35, 0.5 + math.cos(num * 0.12 + i * 3) * 0.35)
		end
	end
end)

func("Frame", {
	Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = tbl.Bg,
	BackgroundTransparency = 0.25,
	BorderSizePixel = 0,
	ZIndex = 3,
	Parent = v9,
})

local v12 = func("Frame", {Size = UDim2.new(1, 0, 0, 56), BackgroundTransparency = 1, ZIndex = 4, Parent = v9})
func6(v12, v9)

func("TextLabel", {
	Text = "DDARIUSPR*GUI",
	Font = tbl.FontBold,
	TextSize = 18,
	TextColor3 = tbl.Text,
	TextXAlignment = Enum.TextXAlignment.Left,
	BackgroundTransparency = 1,
	Position = UDim2.fromOffset(22, 10),
	Size = UDim2.fromOffset(300, 22),
	ZIndex = 4,
	Parent = v12,
})

func("TextLabel", {
	Text = "sub to DD",
	Font = tbl.Font,
	TextSize = 12,
	TextColor3 = tbl.SubText,
	TextXAlignment = Enum.TextXAlignment.Left,
	BackgroundTransparency = 1,
	Position = UDim2.fromOffset(22, 30),
	Size = UDim2.fromOffset(300, 16),
	ZIndex = 4,
	Parent = v12,
})

local v13 = func("Frame", {
	Size = UDim2.new(1, -44, 0, 2),
	Position = UDim2.fromOffset(22, 52),
	BackgroundColor3 = tbl.Accent1,
	BorderSizePixel = 0,
	ZIndex = 4,
	Parent = v12,
})

func1(2).Parent = v13

func3(0, ColorSequence.new({
	ColorSequenceKeypoint.new(0, tbl.Accent1),
	ColorSequenceKeypoint.new(0.5, tbl.Accent2),
	ColorSequenceKeypoint.new(1, tbl.Accent3),
})).Parent = v13

task.spawn(function()
	while v9.Parent do
		func4(
			v13,
			TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{BackgroundTransparency = 0.6}
		).Completed:Wait()
		func4(
			v13,
			TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{BackgroundTransparency = 0}
		).Completed:Wait()
	end
end)

local v14 = func("ImageButton", {
	Image = "rbxassetid://3926307971",
	ImageColor3 = tbl.SubText,
	BackgroundTransparency = 1,
	Size = UDim2.fromOffset(28, 28),
	Position = UDim2.new(1, -40, 0, 14),
	ZIndex = 4,
	Parent = v12,
})

func1(8).Parent = v14

v14.MouseButton1Click:Connect(function()
	func4(v9, tweenInfo1, {Size = UDim2.fromOffset(0, 0)})
	task.delay(0.3, function()
		v1:Destroy()
	end)
end)

v14.MouseEnter:Connect(function()
	func4(v14, tweenInfo2, {ImageColor3 = tbl.Accent3})
end)

v14.MouseLeave:Connect(function()
	func4(v14, tweenInfo2, {ImageColor3 = tbl.SubText})
end)

local v15 = func("Frame", {
	Size = UDim2.new(0, 76, 1, -70),
	Position = UDim2.fromOffset(14, 62),
	BackgroundTransparency = 1,
	ZIndex = 4,
	Parent = v9,
})

local tbl4 = {Padding = UDim.new(0, 10)}
tbl4.HorizontalAlignment = Enum.HorizontalAlignment.Center
tbl4.SortOrder = Enum.SortOrder.LayoutOrder
func("UIListLayout", tbl4).Parent = v15

local v16 = func("Frame", {
	Size = UDim2.new(1, 0, 0, 52),
	BackgroundColor3 = tbl.Accent1,
	BackgroundTransparency = 0.85,
	BorderSizePixel = 0,
	ZIndex = 3,
	Parent = v15,
})

func1(14).Parent = v16
func2(tbl.Accent1, 1, 0.4).Parent = v16

local v17 = func("Frame", {
	Size = UDim2.new(1, -110, 1, -70),
	Position = UDim2.fromOffset(100, 62),
	BackgroundTransparency = 1,
	ClipsDescendants = true,
	ZIndex = 4,
	Parent = v9,
})

local v18 = func("Frame", {
	Size = UDim2.fromOffset(280, 500),
	Position = UDim2.new(1, -300, 0, 20),
	BackgroundTransparency = 1,
	ZIndex = 10,
	Parent = v1,
})

func("UIListLayout", {Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}).Parent = v18

local function func7(arg1, arg2, arg3)
	local v1 = arg3 or 4

	local v2 = func("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = tbl.Glass,
		BackgroundTransparency = 0.05,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Parent = v18,
	})

	func1(12).Parent = v2
	func2(tbl.Accent2, 1, 0.5).Parent = v2

	local v3 = func(
		"Frame",
		{Size = UDim2.new(0, 4, 1, 0), BackgroundColor3 = tbl.Accent2, BorderSizePixel = 0, Parent = v2}
	)

	func1(2).Parent = v3

	func("TextLabel", {
		Text = arg1,
		Font = tbl.FontBold,
		TextSize = 14,
		TextColor3 = tbl.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(16, 10),
		Size = UDim2.new(1, -28, 0, 18),
		Parent = v2,
	})

	local tbl1 = {Text = arg2, Font = tbl.Font, TextSize = 12, TextColor3 = tbl.SubText}
	tbl1.TextXAlignment = Enum.TextXAlignment.Left
	tbl1.TextWrapped = true
	tbl1.AutomaticSize = Enum.AutomaticSize.Y
	tbl1.BackgroundTransparency = 1
	tbl1.Position = UDim2.fromOffset(16, 30)
	tbl1.Size = UDim2.new(1, -28, 0, 0)
	tbl1.Parent = v2
	func("TextLabel", tbl1)
	func("UIPadding", {PaddingBottom = UDim.new(0, 12)}).Parent = v2
	v2.Position = UDim2.fromOffset(320, 0)
	func4(v2, tweenInfo, {Position = UDim2.fromOffset(0, 0)})

	task.delay(v1, function()
		func4(v2, tweenInfo1, {Position = UDim2.fromOffset(320, 0)}).Completed:Wait()
		v2:Destroy()
	end)
end

local tbl5 = {}
local v22

local function func8(arg1, arg2)
	local v1 = #tbl5 + 1

	local v2 = func("TextButton", {
		Text = "",
		Size = UDim2.new(1, 0, 0, 52),
		BackgroundTransparency = 1,
		LayoutOrder = v1,
		ZIndex = 5,
		Parent = v15,
	})

	local v3

	if arg2 then
		if arg2:match("^rbxassetid://") or arg2:match("^https?://") then
			v3 = func("ImageLabel", {
				Image = arg2,
				Size = UDim2.fromOffset(22, 22),
				Position = UDim2.new(0.5, -11, 0.5, -16),
				BackgroundTransparency = 1,
				ImageColor3 = tbl.SubText,
				ZIndex = 5,
				Parent = v2,
			})
		else
			v3 = func("TextLabel", {
				Text = arg2,
				Font = Enum.Font.SourceSansBold,
				TextSize = 20,
				TextColor3 = tbl.SubText,
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(22, 22),
				Position = UDim2.new(0.5, -11, 0.5, -16),
				ZIndex = 5,
				Parent = v2,
			})
		end
	end

	local v4 = func("TextLabel", {
		Text = arg1,
		Font = tbl.Font,
		TextSize = 10,
		TextColor3 = tbl.SubText,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0.5, 6),
		Size = UDim2.new(1, 0, 0, 12),
		ZIndex = 5,
		Parent = v2,
	})

	local v5 = func("ScrollingFrame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = tbl.Accent1,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Visible = false,
		ZIndex = 4,
		Parent = v17,
	})

	func("UIListLayout", {Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder}).Parent = v5
	func("UIPadding", {PaddingRight = UDim.new(0, 6)}).Parent = v5
	local tbl1 = {Button = v2, Icon = v3, Label = v4, Page = v5, Index = v1}
	tbl5[v1] = tbl1

	local function func3()
		if v22 == tbl1 then
			return
		end

		if v22 then
			local v2 = v22
			v2.Page.Visible = false

			if v2.Icon then
				if v2.Icon:IsA("ImageLabel") then
					func4(v2.Icon, tweenInfo2, {ImageColor3 = tbl.SubText})
				else
					func4(v2.Icon, tweenInfo2, {TextColor3 = tbl.SubText})
				end
			end

			func4(v2.Label, tweenInfo2, {TextColor3 = tbl.SubText})
		end

		v22 = tbl1
		func4(v16, tweenInfo, {Position = UDim2.new(0, 0, 0, (v1 - 1) * 62)})
		v5.Visible = true
		v5.Position = UDim2.fromScale(0.05, 0)
		func4(v5, tweenInfo1, {Position = UDim2.fromScale(0, 0)})

		if v3 then
			if v3:IsA("ImageLabel") then
				func4(v3, tweenInfo2, {ImageColor3 = tbl.Accent1})
			else
				func4(v3, tweenInfo2, {TextColor3 = tbl.Accent1})
			end
		end

		func4(v4, tweenInfo2, {TextColor3 = tbl.Text})
	end

	v2.MouseButton1Click:Connect(func3)

	v2.MouseEnter:Connect(function()
		if v22 ~= tbl1 and v3 then
			if v3:IsA("ImageLabel") then
				func4(v3, tweenInfo2, {ImageColor3 = tbl.Text})
			else
				func4(v3, tweenInfo2, {TextColor3 = tbl.Text})
			end
		end
	end)

	v2.MouseLeave:Connect(function()
		if v22 ~= tbl1 and v3 then
			if v3:IsA("ImageLabel") then
				func4(v3, tweenInfo2, {ImageColor3 = tbl.SubText})
			else
				func4(v3, tweenInfo2, {TextColor3 = tbl.SubText})
			end
		end
	end)

	if v1 == 1 then
		func3()
	end

	return {
		AddLabel = function(_, arg2)
			return (func("TextLabel", {
				Text = arg2,
				Font = tbl.Font,
				TextSize = 12,
				TextColor3 = tbl.SubText,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, -8, 0, 20),
				AutomaticSize = Enum.AutomaticSize.Y,
				LayoutOrder = #v5:GetChildren(),
				Parent = v5,
			}))
		end,
		AddButton = function(_, arg2, arg3)
			local v1 = func("TextButton", {
				Text = "",
				Size = UDim2.new(1, -8, 0, 44),
				BackgroundColor3 = tbl.Glass,
				ClipsDescendants = true,
				LayoutOrder = #v5:GetChildren(),
				Parent = v5,
			})

			func1(10).Parent = v1
			func2(tbl.Stroke, 1, 0.4).Parent = v1

			func("TextLabel", {
				Text = arg2,
				Font = tbl.Font,
				TextSize = 13,
				TextColor3 = tbl.Text,
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Parent = v1,
			})

			v1.MouseButton1Click:Connect(function()
				func5(v1, tbl.Accent1)
				func4(v1, tweenInfo2, {BackgroundColor3 = tbl.GlassLight})

				task.delay(0.15, function()
					func4(v1, tweenInfo2, {BackgroundColor3 = tbl.Glass})
				end)

				if arg3 then
					arg3()
				end
			end)

			return v1
		end,
		AddToggle = function(_, arg2, arg3, arg4)
			local v1 = arg3 or false

			local v2 = func("Frame", {
				Size = UDim2.new(1, -8, 0, 44),
				BackgroundColor3 = tbl.Glass,
				LayoutOrder = #v5:GetChildren(),
				Parent = v5,
			})

			func1(10).Parent = v2
			func2(tbl.Stroke, 1, 0.4).Parent = v2

			func("TextLabel", {
				Text = arg2,
				Font = tbl.Font,
				TextSize = 13,
				TextColor3 = tbl.Text,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(14, 0),
				Size = UDim2.new(1, -70, 1, 0),
				Parent = v2,
			})

			local v3 = func("Frame", {
				Size = UDim2.fromOffset(44, 22),
				Position = UDim2.new(1, -58, 0.5, -11),
				BackgroundColor3 = v1 and tbl.Accent1 or tbl.GlassLight,
				Parent = v2,
			})

			func1(999).Parent = v3

			local v4 = func("Frame", {
				Size = UDim2.fromOffset(16, 16),
				Position = v1 and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8),
				BackgroundColor3 = tbl.Text,
				Parent = v3,
			})

			func1(999).Parent = v4
			local v6 = func("TextButton", {Text = "", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = v2})

			local function func3(arg1)
				v1 = arg1
				func4(v3, tweenInfo2, {BackgroundColor3 = v1 and tbl.Accent1 or tbl.GlassLight})
				func4(v4, tweenInfo, {Position = v1 and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)})
			end

			v6.MouseButton1Click:Connect(function()
				v1 = not v1
				func3(v1)

				if arg4 then
					arg4(v1)
				end
			end)

			return {Holder = v2, SetState = func3}
		end,
		AddKeybind = function(_, arg2, arg3, arg4)
			local v1 = arg3 or Enum.KeyCode.F

			local v2 = func("Frame", {
				Size = UDim2.new(1, -8, 0, 44),
				BackgroundColor3 = tbl.Glass,
				LayoutOrder = #v5:GetChildren(),
				Parent = v5,
			})

			func1(10).Parent = v2
			func2(tbl.Stroke, 1, 0.4).Parent = v2

			func("TextLabel", {
				Text = arg2,
				Font = tbl.Font,
				TextSize = 13,
				TextColor3 = tbl.Text,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(14, 0),
				Size = UDim2.new(1, -100, 1, 0),
				Parent = v2,
			})

			local v3 = func("TextButton", {
				Text = tostring(v1.Name),
				Font = tbl.FontBold,
				TextSize = 12,
				TextColor3 = tbl.Accent1,
				BackgroundColor3 = tbl.GlassLight,
				Size = UDim2.fromOffset(70, 30),
				Position = UDim2.new(1, -80, 0.5, -15),
				Parent = v2,
			})

			func1(6).Parent = v3
			local flag = false

			v3.MouseButton1Click:Connect(function()
				flag = not flag
				if flag then
					v3.Text = "..."
					v3.TextColor3 = tbl.Accent3
				else
					v3.Text = tostring(v1.Name)
					v3.TextColor3 = tbl.Accent1
				end
			end)

			UserInputService.InputBegan:Connect(function(input, gameProcessed)
				if gameProcessed then
					return
				end
				if flag then
					if input.KeyCode ~= Enum.KeyCode.Unknown then
						v1 = input.KeyCode
						v3.Text = tostring(v1.Name)
						v3.TextColor3 = tbl.Accent1
						flag = false

						if arg4 then
							arg4(v1)
						end

						func7("Keybind", "Changed to " .. tostring(v1.Name))
					end
				end
			end)

			return v2
		end,
	}
end

local tbl6 = {triggerBot = false, camLock = false, autoShoot = false, comboMode = false, esp = false}

local tbl7 = {
	triggerBot = Enum.KeyCode.F,
	camLock = Enum.KeyCode.Q,
	autoShoot = Enum.KeyCode.H,
	comboMode = Enum.KeyCode.F,
	autoKill = Enum.KeyCode.J,
	esp = Enum.KeyCode.G,
}

local v19 = func8("Combat", "⚔️")

local function func9()
	local Character = LocalPlayer.Character

	if not Character then
		return nil
	end

	for _, child in ipairs(Character:GetChildren()) do
		if child:IsA("Tool") then
			return child
		end
	end

	return nil
end

local function func10(player)
	if player == LocalPlayer then
		return false
	end

	local v1 = LocalPlayer:GetAttribute("StageInMatch") == true
	local v2 = player:GetAttribute("StageInMatch") == true

	if not v1 or not v2 then
		return false
	end

	local stageTeamSide = LocalPlayer:GetAttribute("StageTeamSide")
	local stageTeamSide1 = player:GetAttribute("StageTeamSide")

	if typeof(stageTeamSide) ~= "number" or typeof(stageTeamSide1) ~= "number" then
		return false
	end

	if stageTeamSide == stageTeamSide1 then
		return false
	end

	local Character = LocalPlayer.Character
	local Character1 = player.Character

	if not Character or not Character1 then
		return false
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	local HumanoidRootPart1 = Character1:FindFirstChild("HumanoidRootPart")

	if not HumanoidRootPart or not HumanoidRootPart1 then
		return false
	end

	if (HumanoidRootPart.Position - HumanoidRootPart1.Position).Magnitude > 200 then
		return false
	end

	return true
end

local function func11(player)
	local Character = player.Character

	if not Character then
		return false
	end

	local Head = Character:FindFirstChild("Head")

	if not Head or not Head:IsA("BasePart") then
		return false
	end

	local _, v1 = CurrentCamera:WorldToViewportPoint(Head.Position)
	return v1
end

local function func12(player)
	local Character = player.Character

	if not Character then
		return nil
	end

	local Head = Character:FindFirstChild("Head")

	if Head and Head:IsA("BasePart") then
		return Head.Position
	end

	return nil
end

local function func13()
	local v4
	local huge = math.huge
	local vector2 = Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y / 2)

	for _, player in pairs(Players:GetPlayers()) do
		if func10(player) and func11(player) then
			local v1 = func12(player)
			if v1 then
				local v2, v3 = CurrentCamera:WorldToViewportPoint(v1)
				if v3 then
					local Magnitude = (Vector2.new(v2.X, v2.Y) - vector2).Magnitude
					if Magnitude < huge then
						huge = Magnitude
						v4 = player
					end
				end
			end
		end
	end

	return v4
end

local function func14()
	local v4
	local huge = math.huge
	local vector2 = Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y / 2)

	for _, player in pairs(Players:GetPlayers()) do
		if
			player ~= LocalPlayer
			and player.Character
			and player.Character:FindFirstChild("Humanoid")
			and player.Character.Humanoid.Health > 0
		then
			local v1 = func12(player)
			if v1 then
				local v2, v3 = CurrentCamera:WorldToViewportPoint(v1)
				if v3 then
					local Magnitude = (Vector2.new(v2.X, v2.Y) - vector2).Magnitude
					if Magnitude < huge then
						huge = Magnitude
						v4 = player
					end
				end
			end
		end
	end

	return v4
end

local v23
local num = 0

local function func15()
	local v1 = tick()

	if v1 - num < 0.15 then
		return false
	end

	num = v1

	if VirtualInputManager then
		local MouseLocation = UserInputService:GetMouseLocation()
		VirtualInputManager:SendMouseButtonEvent(MouseLocation.X, MouseLocation.Y, 0, true, game, false)
		task.wait(0.03)
		VirtualInputManager:SendMouseButtonEvent(MouseLocation.X, MouseLocation.Y, 0, false, game, false)
		return true
	end

	if mouse1click then
		mouse1click()
		return true
	end

	return false
end

local function func16()
	local CurrentCamera = Workspace.CurrentCamera

	if not CurrentCamera then
		return nil
	end

	local Character = LocalPlayer.Character

	if not Character then
		return nil
	end

	if not Character:FindFirstChild("HumanoidRootPart") then
		return nil
	end

	local MouseLocation = UserInputService:GetMouseLocation()
	local ViewportSize = CurrentCamera.ViewportSize

	if
		MouseLocation.X < 0
		or MouseLocation.X > ViewportSize.X
		or MouseLocation.Y < 0
		or MouseLocation.Y > ViewportSize.Y
	then
		return nil
	end

	local v1 = CurrentCamera:ViewportPointToRay(MouseLocation.X, MouseLocation.Y)
	local Unit = v1.Direction.Unit
	local Origin = v1.Origin

	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			local Character1 = player.Character
			if Character1 then
				local v2 = Workspace:FindPartOnRayWithIgnoreList(Ray.new(Origin, Unit * 500), {Character, CurrentCamera})
				if v2 and v2:IsDescendantOf(Character1) then
					return player
				end
			end
		end
	end

	return nil
end

local function func17()
	while tbl6.triggerBot or tbl6.comboMode do
		if tbl6.triggerBot or tbl6.comboMode then
			if func16() then
				func15()
			end
		end
		task.wait(0.05)
	end
end

local function func18()
	if v23 then
		task.cancel(v23)
	end
	v23 = task.spawn(func17)
end

local function func19()
	if v23 then
		task.cancel(v23)
	end
	v23 = nil
end

local function func20(triggerBot)
	tbl6.triggerBot = triggerBot

	if triggerBot or tbl6.comboMode then
		func18()
	else
		func19()
	end

	func7("Trigger Bot", triggerBot and "ON" or "OFF")
end

local v24

local function func21()
	v24 = func14()
	if not v24 then
		tbl6.camLock = false
		func7("Cam Lock", "No target found")
	end
end

local function func22()
	v24 = nil
end

local function func23(camLock)
	tbl6.camLock = camLock

	if camLock or tbl6.comboMode then
		func21()
	else
		func22()
	end

	func7("Cam Lock", camLock and "ON" or "OFF")
end

local num1 = 0

local function func24()
	if not tbl6.autoShoot and not tbl6.comboMode then
		return
	end
	if func13() then
		local v1 = tick()
		if v1 - num1 >= 0.1 then
			local v2 = func9()
			if v2 then
				pcall(function()
					v2:Activate()
					task.wait(0.05)
					v2:Deactivate()
				end)
				num1 = v1
			end
		end
	end
end

local function func25(autoShoot)
	tbl6.autoShoot = autoShoot
	func7("Auto Shoot", autoShoot and "ON" or "OFF")
end

local function func26(comboMode)
	tbl6.comboMode = comboMode
	if comboMode then
		func20(true)
		func23(true)
		func25(true)
		triggerBotToggle.SetState(true)
		camLockToggle.SetState(true)
		autoShootToggle.SetState(true)
		func7("Combo Mode", "Trigger Bot + Cam Lock + Auto Shoot ON")
	else
		func20(false)
		func23(false)
		func25(false)
		triggerBotToggle.SetState(false)
		camLockToggle.SetState(false)
		autoShootToggle.SetState(false)
		func7("Combo Mode", "OFF")
	end
end

local flag = false

local function func27()
	if flag then
		return
	end

	flag = true
	func7("Auto Kill", "Executing…")
	local v1 = func13()

	if not v1 then
		func7("Auto Kill", "No target found")
		flag = false
		return
	end

	local Character = LocalPlayer.Character
	local Character1 = v1.Character

	if not Character or not Character1 then
		flag = false
		return
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	local HumanoidRootPart1 = Character1:FindFirstChild("HumanoidRootPart")

	if not HumanoidRootPart or not HumanoidRootPart1 then
		flag = false
		return
	end

	local Position = HumanoidRootPart1.Position
	local v2 = Position - HumanoidRootPart1.CFrame.LookVector * 3
	local vector3 = Vector3.new(v2.X, Position.Y + 0.5, v2.Z)
	HumanoidRootPart.CFrame = CFrame.new(vector3, Position)

	if mouse2press then
		mouse2press()
	end

	local v3 = tick()

	while tick() - v3 < 10 do
		if not v1.Character or not v1.Character:FindFirstChild("Humanoid") or v1.Character.Humanoid.Health <= 0 then
			break
		end

		local v4 = func9()

		if v4 then
			pcall(function()
				v4:Activate()
				task.wait(0.05)
				v4:Deactivate()
			end)
		end

		local v5 = func12(v1)

		if v5 then
			CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, v5)
		end

		task.wait(0.1)
	end

	if mouse2release then
		mouse2release()
	end

	func7("Auto Kill", "Finished")
	flag = false
end

local function func28(triggerBot)
	tbl7.triggerBot = triggerBot
end

local function func29(camLock)
	tbl7.camLock = camLock
end

local function func30(autoShoot)
	tbl7.autoShoot = autoShoot
end

local function func31(comboMode)
	tbl7.comboMode = comboMode
end

local function func32(autoKill)
	tbl7.autoKill = autoKill
end

v19:AddLabel("Individual Toggles:")
v19:AddLabel("Trigger Bot – auto clicks M1 when aiming at enemy.")
local triggerBotToggle1 = v19:AddToggle("Trigger Bot", false, func20)
v19:AddKeybind("Keybind", Enum.KeyCode.F, func28)
v19:AddLabel("Cam Lock – locks camera onto nearest enemy head.")
local camLockToggle1 = v19:AddToggle("Cam Lock", false, func23)
v19:AddKeybind("Keybind", Enum.KeyCode.Q, func29)
v19:AddLabel("Auto Shoot – shoots at enemy head when visible.")
local autoShootToggle1 = v19:AddToggle("Auto Shoot", false, func25)
v19:AddKeybind("Keybind", Enum.KeyCode.H, func30)
v19:AddLabel("-- Combined Toggle: Trigger Bot + Cam Lock + Auto Shoot --")
local Toggle = v19:AddToggle("Trigger Bot + Cam + Auto Shoot", false, func26)
v19:AddKeybind("Keybind", Enum.KeyCode.F, func31)
v19:AddLabel("Auto Kill – teleports behind enemy and kills once.")
v19:AddButton("Execute Auto Kill", func27)
v19:AddKeybind("Keybind", Enum.KeyCode.J, func32)
local v20 = func8("ESP", "rbxassetid://10734950309")
local tbl8 = {}
local flag1 = false
local tbl9 = {BoxColor = Color3.new(1, 0, 0), BoxTransparency = 0.25, BoxThickness = 2, MaxDistance = 200}

local function func33(arg1)
	if tbl8[arg1] then
		for _, v1 in ipairs(tbl8[arg1]) do
			v1:Remove()
		end
		tbl8[arg1] = nil
	end
end

local function func34(player)
	if player == LocalPlayer then
		return
	end

	func33(player)

	if not player.Character then
		return
	end

	local tbl = {}
	local drawing = Drawing.new("Square")
	drawing.Color = tbl9.BoxColor
	drawing.Thickness = tbl9.BoxThickness
	drawing.Filled = true
	drawing.Transparency = tbl9.BoxTransparency
	table.insert(tbl, drawing)
	local drawing1 = Drawing.new("Square")
	drawing1.Color = tbl9.BoxColor
	drawing1.Thickness = 2
	drawing1.Filled = false
	drawing1.Transparency = 1
	table.insert(tbl, drawing1)
	local drawing2 = Drawing.new("Text")
	drawing2.Color = tbl9.BoxColor
	drawing2.Size = 18
	drawing2.Center = true
	drawing2.Outline = true
	drawing2.OutlineColor = Color3.new(0, 0, 0)
	drawing2.Text = player.Name
	table.insert(tbl, drawing2)
	local drawing3 = Drawing.new("Text")
	drawing3.Color = Color3.new(1, 1, 1)
	drawing3.Size = 14
	drawing3.Center = true
	drawing3.Outline = true
	drawing3.OutlineColor = Color3.new(0, 0, 0)
	table.insert(tbl, drawing3)
	tbl8[player] = tbl
	return tbl
end

RunService.RenderStepped:Connect(function()
	if not flag1 then
		for _, v1 in pairs(tbl8) do
			for _, v2 in ipairs(v1) do
				v2.Visible = false
			end
		end
		return
	end

	local Character = LocalPlayer.Character
	local v3 = Character and Character:FindFirstChild("HumanoidRootPart")

	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			if not func10(player) then
				func33(player)
			else
				local Character1 = player.Character
				if not Character1 then
					func33(player)
				else
					local Humanoid = Character1:FindFirstChild("Humanoid")
					if not Humanoid or Humanoid.Health <= 0 then
						func33(player)
					else
						local Head = Character1:FindFirstChild("Head")
						local HumanoidRootPart = Character1:FindFirstChild("HumanoidRootPart")

						if not Head or not HumanoidRootPart then
							func33(player)
						else
							local v4, v5 = CurrentCamera:WorldToViewportPoint(Head.Position)
							local _, v6 = CurrentCamera:WorldToViewportPoint(HumanoidRootPart.Position)
							local v7 = v5 or v6
							local v8 = func34(player)

							if v8 then
								local v9 = HumanoidRootPart.Position - Vector3.new(0, 4, 0)
								local v10 = CurrentCamera:WorldToViewportPoint(v9)
								local v11 = math.abs(v4.Y - v10.Y) * 1.5
								local v12 = v11 * 0.65
								local X = v4.X
								local v13 = (v4.Y + v10.Y) / 2
								local vector2 = Vector2.new(X - v12 / 2, v13 - v11 / 2)
								local vector21 = Vector2.new(v12, v11)
								local v14 = v8[1]
								local v15 = v8[2]

								if v7 then
									v14.Visible = true
									v15.Visible = true
									v14.Position = vector2
									v14.Size = vector21
									v15.Position = vector2
									v15.Size = vector21
								else
									v14.Visible = false
									v15.Visible = false
								end

								local v16 = v8[3]

								if v7 then
									v16.Visible = true
									v16.Position = Vector2.new(v4.X, v4.Y - 35)
								else
									v16.Visible = false
								end

								local v17 = v8[4]

								if v7 and v3 then
									v17.Visible = true
									v17.Position = Vector2.new(v4.X, v4.Y + 30)
									v17.Text = math.floor((HumanoidRootPart.Position - v3.Position).Magnitude) .. "m"
								else
									v17.Visible = false
								end
							end
						end
					end
				end
			end
		end
	end

	for k in pairs(tbl8) do
		if not k.Parent or not Players:FindFirstChild(k.Name) then
			func33(k)
		end
	end
end)

local function func35(arg1)
	flag1 = arg1
	func7("ESP", arg1 and "ON" or "OFF")
end

local function func36(esp)
	tbl7.esp = esp
end

v20:AddLabel("Box ESP for enemies (max 200 studs).")
local espToggle = v20:AddToggle("ESP", false, func35)
v20:AddKeybind("Keybind", Enum.KeyCode.G, func36)
local v21 = func8("Info", "ℹ️")
v21:AddLabel("⚠️ AUTO KILL TIP ⚠️")
v21:AddLabel("⚔️ Works best for 1v1 (not tested on 2v2/3v3).")
v21:AddLabel("🔫 EQUIP YOUR GUN BEFORE USING AUTO KILL!")
v21:AddLabel("")
v21:AddLabel("Created by DD, Open sourced by Boog")
v21:AddLabel("Script: DDARIUSPR*GUI")
v21:AddLabel("Version: 1.0")

v21:AddButton("Sub to my YT (changed to boog's)", function()
	pcall(function()
		setclipboard("https://www.youtube.com/@boog8645")
	end)
	func7("Copied!", "YouTube link copied to clipboard")
end)

local flag2 = true
local LeftShift = Enum.KeyCode.LeftShift
v21:AddLabel("-- UI Visibility --")

local Toggle1 = v21:AddToggle("Close / Open UI", true, function(arg1)
	flag2 = arg1
	v9.Visible = flag2
	func7("UI", flag2 and "Opened" or "Closed")
end)

v21:AddKeybind("Keybind", LeftShift, function(arg1)
	LeftShift = arg1
	func7("Keybind", "UI toggle key changed to " .. tostring(arg1.Name))
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end
	if input.KeyCode == LeftShift then
		flag2 = not flag2
		Toggle1.SetState(flag2)
		v9.Visible = flag2
		func7("UI", flag2 and "Opened" or "Closed")
	end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end
	if input.KeyCode == tbl7.triggerBot then
		func20(not tbl6.triggerBot)
		triggerBotToggle1.SetState(tbl6.triggerBot)
	elseif input.KeyCode == tbl7.camLock then
		func23(not tbl6.camLock)
		camLockToggle1.SetState(tbl6.camLock)
	elseif input.KeyCode == tbl7.autoShoot then
		func25(not tbl6.autoShoot)
		autoShootToggle1.SetState(tbl6.autoShoot)
	elseif input.KeyCode == tbl7.comboMode then
		func26(not tbl6.comboMode)
		Toggle.SetState(tbl6.comboMode)
		triggerBotToggle1.SetState(tbl6.triggerBot)
		camLockToggle1.SetState(tbl6.camLock)
		autoShootToggle1.SetState(tbl6.autoShoot)
	elseif input.KeyCode == tbl7.autoKill then
		func27()
	elseif input.KeyCode == tbl7.esp then
		func35(not flag1)
		espToggle.SetState(flag1)
	end
end)

RunService.RenderStepped:Connect(func24)

RunService.RenderStepped:Connect(function()
	if (tbl6.camLock or tbl6.comboMode) and v24 then
		local v1 = func12(v24)
		if v1 then
			CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, v1)
		else
			tbl6.camLock = false
			v24 = nil
			camLockToggle1.SetState(false)

			if tbl6.comboMode then
				func26(false)
				Toggle.SetState(false)
			end

			func7("Cam Lock", "Target lost")
		end
	end
end)

task.delay(1.9, function()
	func4(v2, tweenInfo1, {BackgroundTransparency = 1})

	for _, v1 in ipairs(tbl1) do
		func4(v1, tweenInfo1, {BackgroundTransparency = 1})
	end

	for _, child in ipairs(v4:GetChildren()) do
		if child:IsA("TextLabel") then
			func4(child, tweenInfo1, {TextTransparency = 1})
		end
	end

	func4(v6, tweenInfo1, {TextTransparency = 1})
	func4(v9, tweenInfo, {Size = UDim2.fromOffset(620, 400)})
	task.wait(0.5)
	v2:Destroy()
	v7.Visible = true
	v7.Size = UDim2.fromOffset(0, 0)
	func4(v7, tweenInfo, {Size = UDim2.fromOffset(480, 320)})
	func7("Welcome", "DDARIUSPR*GUI loaded")
end)
