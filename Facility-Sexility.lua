-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local function func(arg1)
	local tbl = {}

	for i = 1, tonumber(arg1 or 12) do
		local v1 = math.random(1, 62)
		tbl[i] = string.sub("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", v1, v1)
	end

	return table.concat(tbl)
end

local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")

local function func1()
	local LocalPlayer = Players.LocalPlayer

	if not LocalPlayer then
		Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
		LocalPlayer = Players.LocalPlayer
	end

	if not LocalPlayer then
		return nil
	end

	return LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 10)
end

local function func2(arg1)
	if arg1:IsA("ScreenGui") then
		pcall(function()
			arg1.OnTopOfCoreBlur = true
		end)
	end

	if pcall(function()
		if gethui then
			arg1.Parent = gethui()
		elseif syn and syn.protect_gui then
			syn.protect_gui(arg1)
			arg1.Parent = game:GetService("CoreGui")
		else
			arg1.Parent = game:GetService("CoreGui")
		end
	end) and arg1.Parent then
		return
	end

	local v1 = func1()

	if v1 then
		arg1.Parent = v1
	else
		arg1.Parent = game:GetService("CoreGui")
	end
end

local tbl = {
	Window = Color3.fromRGB(26, 26, 28),
	WindowAlpha = 0.012,
	WindowBorder = Color3.fromRGB(52, 52, 56),
	TopBar = Color3.fromRGB(31, 31, 34),
	Section = Color3.fromRGB(29, 29, 32),
	SectionBorder = Color3.fromRGB(46, 46, 50),
	Group = Color3.fromRGB(34, 34, 37),
	GroupBorder = Color3.fromRGB(54, 54, 58),
	Field = Color3.fromRGB(40, 40, 44),
	FieldHover = Color3.fromRGB(48, 48, 52),
	Border = Color3.fromRGB(60, 60, 65),
	BorderSoft = Color3.fromRGB(45, 45, 49),
	PopupBg = Color3.fromRGB(38, 38, 42),
	PopupBorder = Color3.fromRGB(62, 62, 67),
	Track = Color3.fromRGB(58, 58, 62),
	Text = Color3.fromRGB(174, 174, 178),
	TextDim = Color3.fromRGB(108, 108, 113),
	TextBright = Color3.fromRGB(228, 228, 232),
	TextMarked = Color3.fromRGB(198, 198, 122),
	TextCode = Color3.fromRGB(96, 200, 96),
	Danger = Color3.fromRGB(226, 102, 102),
	Accent = Color3.fromRGB(232, 161, 168),
	AccentSoft = Color3.fromRGB(240, 186, 191),
	AccentDim = Color3.fromRGB(146, 98, 103),
}

tbl.Font = Enum.Font.Gotham
tbl.FontMedium = Enum.Font.GothamMedium
tbl.TextSize = 13
tbl.Radius = 6
tbl.GearIcon = "rbxassetid://6031280882"

local function func3()
	return string.format(
		"#%02X%02X%02X",
		math.floor(tbl.Accent.R * 255 + 0.5),
		math.floor(tbl.Accent.G * 255 + 0.5),
		math.floor(tbl.Accent.B * 255 + 0.5)
	)
end

local tweenInfo = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo1 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tbl1 = {}
local num = 0
local tbl2 = {}

local tbl3 = {
	BackgroundColor3 = "BackgroundTransparency",
	ImageColor3 = "ImageTransparency",
	TextColor3 = "TextTransparency",
	Color = "Transparency",
}

local tbl4 = {}

local tbl5 = {
	"Window",
	"WindowBorder",
	"TopBar",
	"Section",
	"SectionBorder",
	"Group",
	"GroupBorder",
	"Field",
	"FieldHover",
	"Border",
	"BorderSoft",
	"PopupBg",
	"PopupBorder",
	"Track",
	"Text",
	"TextDim",
	"TextBright",
	"TextMarked",
	"TextCode",
	"Danger",
	"Accent",
	"AccentSoft",
	"AccentDim",
}

local function func4()
	table.clear(tbl4)
	for _, v1 in ipairs(tbl5) do
		local v2 = tbl[v1]
		if typeof(v2) == "Color3" and tbl4[tostring(v2)] == nil then
			tbl4[tostring(v2)] = v1
		end
	end
end

func4()

local function func5(arg1, arg2)
	local v1 = tbl1[arg1]

	if not v1 then
		v1 = {}
		tbl1[arg1] = v1
		num = num + 1
	end

	for k, v2 in pairs(arg2) do
		if v2 == false then
			v1[k] = nil
		else
			v1[k] = v2
			local v3 = tbl[v2]

			if v3 ~= nil then
				pcall(function()
					arg1[k] = v3
				end)
			end
		end
	end

	return arg1
end

local tbl6 = {}
tbl6.Theme = tbl
tbl6.Flags = {}
tbl6.Windows = {}
tbl6.Connections = {}
tbl6.Open = true
tbl6.ToggleKey = Enum.KeyCode.RightShift
tbl6.ToggleInput = nil
tbl6.Binding = false
tbl6.Registry = {}
tbl6.Defaults = {}
tbl6.NotificationsEnabled = true
tbl6.NotificationLimit = 5
tbl6.Dirty = false
tbl6.BaseUrl = "https://raw.githubusercontent.com/FacilityHUB/UI-Facility/refs/heads/main/"

tbl6.AddonPaths = {
	Icons = "addons/Icons.luau",
	SaveManager = "addons/SaveManager.luau",
	InterfaceManager = "addons/InterfaceManager.luau",
	ThemeManager = "addons/ThemeManager.luau",
}

tbl6.Addons = {}
tbl6.Painted = tbl1

function tbl6.PaintedCount()
	return num
end

tbl6.SectionTitleStyle = "inline"
tbl6.RepaintHooks = {}

function tbl6:SafeCallback(arg2, arg3, ...)
	if not arg3 then
		return
	end

	local v1 = table.pack(...)

	task.spawn(function()
		local ok, result = pcall(arg3, table.unpack(v1, 1, v1.n))

		if ok then
			return
		end

		local str = tostring(result)
		local _, v2 = string.find(str, ":%d+: ")

		if v2 then
			str = string.sub(str, v2 + 1)
		end

		warn("Facility | callback error in '" .. tostring(arg2) .. "': " .. tostring(result))
		self:Error("callback error", tostring(arg2) .. " - " .. str, 7)
	end)
end

function tbl6:OnRepaint(arg2)
	table.insert(self.RepaintHooks, arg2)
	return arg2
end

tbl6.ThemeAlpha = tbl2
tbl6.Version = "2026.09.11-layers"

function tbl6:LoadAddon(name)
	if self.Addons[name] ~= nil then
		return self.Addons[name]
	end

	local v1

	local ok, result = pcall(function()
		local v1 = script and script.Parent
		local v2 = v1 and (v1:FindFirstChild("addons") or v1:FindFirstChild("Addons"))
		local v3 = v2 and v2:FindFirstChild(name)
		return v3 and require(v3) or nil
	end)

	if ok then
		v1 = result
	end

	if v1 == nil then
		local v2 = self.AddonPaths[name]

		if not v2 then
			warn("Facility | unknown addon '" .. tostring(name) .. "'")
			return nil
		end

		local ok1, result1 = pcall(function()
			return game:HttpGet(self.BaseUrl .. v2)
		end)

		if ok1 and type(result1) == "string" and #result1 > 0 then
			local ok2, result2 = pcall(loadstring, result1)
			if ok2 and type(result2) == "function" then
				local ok3, result3 = pcall(result2)
				if ok3 then
					v1 = result3
				end
			end
		end
	end

	if v1 == nil then
		warn("Facility | addon '" .. tostring(name) .. "' unavailable")
		return nil
	end

	if type(v1) == "function" then
		v1 = v1(self)
	end

	self.Addons[name] = v1
	return v1
end

function tbl6:SetColor(arg2, arg3, arg4)
	if typeof(arg3) ~= "Color3" or tbl[arg2] == nil then
		return false
	end

	tbl[arg2] = arg3

	if arg4 ~= nil then
		tbl2[arg2] = math.clamp(arg4, 0, 1)
	end

	self:Repaint()
	return true
end

function tbl6:Tag(arg2, arg3)
	if typeof(arg2) ~= "Instance" then
		return arg2
	end
	return (func5(arg2, arg3))
end

function tbl6.Untag(_, arg2)
	if tbl1[arg2] then
		tbl1[arg2] = nil
		num = num - 1
	end
end

function tbl6:Repaint()
	if num == 0 then
		warn("Facility | repaint registry is empty, main.luau is probably outdated")
	end

	func4()
	local tbl4 = {}

	for k, v1 in pairs(tbl1) do
		if not pcall(function()
			if not k.Parent and not k:IsA("ScreenGui") then
				table.insert(tbl4, k)
				return
			end
			for k1, v2 in pairs(v1) do
				local v3 = tbl[v2]
				if v3 ~= nil then
					k[k1] = v3
					local num = tonumber(tbl2[v2])
					local v4 = tbl3[k1]

					if num and num < 1 and num > 0 and v4 and k[v4] < 1 then
						k[v4] = 1 - num
					end
				end
			end
		end) then
			table.insert(tbl4, k)
		end
	end

	for _, v2 in ipairs(tbl4) do
		tbl1[v2] = nil
		num = num - 1
	end

	self:RefreshHotkeys()

	for i = #self.RepaintHooks, 1, -1 do
		if not pcall(self.RepaintHooks[i]) then
			table.remove(self.RepaintHooks, i)
		end
	end
end

function tbl6:Register(arg2, arg3)
	if self.Registry[arg2] then
		warn("Facility | duplicate flag '" .. tostring(arg2) .. "', the previous element will no longer be saved")
	end

	self.Registry[arg2] = arg3
	self.Defaults[arg2] = arg3.Get()
end

function tbl6:MarkDirty(arg2)
	if arg2 and self.DirtyIgnore and self.DirtyIgnore[arg2] then
		return
	end

	if self.Dirty then
		return
	end

	self.Dirty = true

	if self.OnDirty then
		task.spawn(self.OnDirty, true)
	end
end

function tbl6:ClearDirty()
	self.Dirty = false
	if self.OnDirty then
		task.spawn(self.OnDirty, false)
	end
end

function tbl6.GetConfig(arg1, arg2)
	local tbl = {}

	for k, v1 in pairs(arg1.Registry) do
		if not (arg2 and arg2[k]) then
			local ok, result = pcall(v1.Get)
			if ok then
				tbl[k] = result
			end
		end
	end

	return tbl
end

function tbl6:LoadConfig(arg2, arg3)
	for k, v1 in pairs(arg2 or {}) do
		local v2 = self.Registry[k]
		if v2 and not (arg3 and arg3[k]) then
			pcall(v2.Set, v1)
		end
	end
	self:ClearDirty()
end

function tbl6.CaptureDefaults(arg1)
	for k, v1 in pairs(arg1.Registry) do
		local ok, result = pcall(v1.Get)
		if ok then
			arg1.Defaults[k] = result
		end
	end
end

function tbl6.ResetDefaults(arg1, arg2)
	arg1:LoadConfig(arg1.Defaults, arg2)
end

local tbl7 = {
	Window = 0.32,
	TopBar = 1,
	Section = 0.55,
	Group = 0.58,
	Field = 0.62,
	FieldHover = 0.62,
	PopupBg = 0.1,
}

local v1 = setmetatable({}, {__mode = "k"})
tbl6.Glass = false
tbl6.GlassBlur = true
tbl6.GlassStrength = 1

local function func6(arg1)
	if v1[arg1] ~= nil then
		return
	end

	local v2 = tbl1[arg1]
	local v3 = v2 and v2.BackgroundColor3
	local v4 = v3 and tbl7[v3]

	if not v4 or not arg1:IsA("GuiObject") then
		return
	end

	local BackgroundTransparency = arg1.BackgroundTransparency

	if BackgroundTransparency >= 1 then
		return
	end

	v1[arg1] = BackgroundTransparency

	if v4 >= 1 then
		arg1.BackgroundTransparency = 1
		return
	end

	local v5 = math.clamp(v4 * (tbl6.GlassStrength or 1), 0, 0.95)
	arg1.BackgroundTransparency = BackgroundTransparency + (1 - BackgroundTransparency) * v5
end

local function func7()
	for k, v2 in pairs(v1) do
		pcall(function()
			k.BackgroundTransparency = v2
		end)
	end
	table.clear(v1)
end

local function func8(className, arg2, arg3)
	local instance = Instance.new(className)
	local v2
	local v3

	for k, v1 in pairs(arg2 or {}) do
		if k == "Parent" then
			v2 = v1
		elseif k == "ThemeTag" then
			v3 = v1
		else
			instance[k] = v1
			if typeof(v1) == "Color3" then
				local v4 = tbl4[tostring(v1)]
				if v4 then
					local tbl = {}
					tbl[k] = v4
					func5(instance, tbl)
				end
			end
		end
	end

	if v3 then
		func5(instance, v3)
	end

	if tbl6.Glass then
		func6(instance)
	end

	for _, v5 in ipairs(arg3 or {}) do
		v5.Parent = instance
	end

	if v2 then
		instance.Parent = v2
	end

	return instance
end

local function func9(arg1, arg2)
	return (func8("UICorner", {CornerRadius = UDim.new(0, arg2 or tbl.Radius), Parent = arg1}))
end

local function func10(arg1, arg2, arg3, arg4)
	return (func8("UIStroke", {
		Color = arg2 or tbl.Border,
		Thickness = arg3 or 1,
		Transparency = arg4 or 0,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = arg1,
	}))
end

local function func11(arg1, arg2, arg3, arg4, arg5)
	return (func8("UIPadding", {
		PaddingTop = UDim.new(0, arg2 or 0),
		PaddingRight = UDim.new(0, arg3 or arg2 or 0),
		PaddingBottom = UDim.new(0, arg4 or arg2 or 0),
		PaddingLeft = UDim.new(0, arg5 or arg3 or arg2 or 0),
		Parent = arg1,
	}))
end

local function func12(arg1, arg2, arg3, arg4)
	return (func8("UIListLayout", {
		FillDirection = arg3 or Enum.FillDirection.Vertical,
		Padding = UDim.new(0, arg2 or 0),
		SortOrder = arg4 or Enum.SortOrder.LayoutOrder,
		Parent = arg1,
	}))
end

local function func13(parent, arg2, arg3, arg4, arg5)
	local tbl1 = {
		BackgroundTransparency = 1,
		Text = arg2,
		TextColor3 = arg3 or tbl.Text,
		TextSize = arg4 or tbl.TextSize,
		Font = arg5 or tbl.Font,
	}

	tbl1.TextXAlignment = Enum.TextXAlignment.Left
	tbl1.TextYAlignment = Enum.TextYAlignment.Center
	tbl1.RichText = true
	tbl1.Parent = parent
	return (func8("TextLabel", tbl1))
end

local function func14(arg1, arg2, arg3)
	local tween = TweenService:Create(arg1, arg3 or tweenInfo, arg2)
	tween:Play()
	return tween
end

local function func15(arg1, arg2)
	local v1 = func8(
		"Frame",
		{Name = "Chevron", Size = UDim2.fromOffset(10, 10), BackgroundTransparency = 1, Parent = arg1}
	)

	for i = 1, 2 do
		local v2 = func8("Frame", {
			Size = UDim2.fromOffset(7, 2),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, i == 1 and -2 or 2, 0.5, 0),
			Rotation = i == 1 and 45 or -45,
			BackgroundColor3 = arg2 or tbl.TextDim,
			BorderSizePixel = 0,
			Parent = v1,
		})

		func8("UICorner", {CornerRadius = UDim.new(0, 1), Parent = v2})
		func8("UICorner", {CornerRadius = UDim.new(0, 1), Parent = v2})
	end

	return v1
end

local function func16(arg1)
	if arg1.UserInputType == Enum.UserInputType.MouseButton1 then
		return "MB1"
	end

	if arg1.UserInputType == Enum.UserInputType.MouseButton2 then
		return "MB2"
	end

	if arg1.UserInputType == Enum.UserInputType.MouseButton3 then
		return "MB3"
	end

	if arg1.UserInputType == Enum.UserInputType.Keyboard then
		return arg1.KeyCode.Name
	end

	return nil
end

local function func17(arg1, arg2, arg3, arg4)
	local connection = arg1.MouseEnter:Connect(function()
		TweenService:Create(arg2, tweenInfo1 or tweenInfo, {BackgroundColor3 = tbl[arg4]}):Play()
	end)

	table.insert(tbl6.Connections, connection)

	local connection1 = arg1.MouseLeave:Connect(function()
		TweenService:Create(arg2, tweenInfo1 or tweenInfo, {BackgroundColor3 = tbl[arg3]}):Play()
	end)

	table.insert(tbl6.Connections, connection1)
end

local function func18(arg1, arg2)
	local connection1
	local connection2

	local connection = arg1.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		arg2(input.Position)

		if connection1 then
			connection1:Disconnect()
		end

		connection1 = UserInputService.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				arg2(input.Position)
			end
		end)

		if connection2 then
			connection2:Disconnect()
		end

		connection2 = UserInputService.InputEnded:Connect(function(input1)
			if input1.UserInputType == input.UserInputType then
				if connection1 then
					connection1:Disconnect()
					connection1 = nil
				end
				if connection2 then
					connection2:Disconnect()
					connection2 = nil
				end
			end
		end)
	end)

	table.insert(tbl6.Connections, connection)
end

local function func19(arg1, arg2)
	return string.format(
		"#%02X%02X%02X%02X",
		math.floor(arg1.R * 255 + 0.5),
		math.floor(arg1.G * 255 + 0.5),
		math.floor(arg1.B * 255 + 0.5),
		math.floor(math.clamp(arg2 or 1, 0, 1) * 255 + 0.5)
	)
end

local function func20(arg1)
	if typeof(arg1) == "Color3" then
		return arg1, 1
	end

	if type(arg1) ~= "string" then
		return nil
	end

	local v1 = string.gsub(string.gsub(arg1, "#", ""), "%s", "")

	if #v1 ~= 6 and #v1 ~= 8 then
		return nil
	end

	local num = tonumber(string.sub(v1, 1, 2), 16)
	local num1 = tonumber(string.sub(v1, 3, 4), 16)
	local num2 = tonumber(string.sub(v1, 5, 6), 16)

	if not num or not num1 or not num2 then
		return nil
	end

	local num3 = 255

	if #v1 == 8 then
		num3 = tonumber(string.sub(v1, 7, 8), 16) or 255
	end

	return Color3.fromRGB(num, num1, num2), num3 / 255
end

local colorSequence = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
	ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
	ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
	ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
	ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
})

local v5
local flag

function tbl6:PreloadIcons()
	if flag then
		return v5
	end

	flag = true
	local v1 = self:LoadAddon("Icons")

	if type(v1) == "table" then
		v5 = v1
	end

	return v5
end

local function func21(arg1)
	if not arg1 or arg1 == 0 or arg1 == "" then
		return nil
	end

	if type(arg1) == "number" then
		return {Image = "rbxassetid://" .. arg1}
	end

	if type(arg1) ~= "string" then
		return nil
	end

	if string.find(arg1, "rbxassetid://") == 1 or string.find(arg1, "rbxasset://") == 1 then
		return {Image = arg1}
	end

	local v1 = tbl6:PreloadIcons()
	local v2 = v1 and v1["48px"]
	local v3 = v2 and v2[string.lower(string.match(arg1, "^%s*(.-)%s*$"))]

	if not v3 or type(v3[1]) ~= "number" then
		return nil
	end

	return {
		Image = "rbxassetid://" .. v3[1],
		RectSize = Vector2.new(v3[2][1], v3[2][2]),
		RectOffset = Vector2.new(v3[3][1], v3[3][2]),
	}
end

local function func22(arg1, arg2)
	if typeof(arg1) == "Color3" then
		return arg1
	end

	if type(arg1) ~= "string" then
		return arg2
	end

	local v1 = string.lower(arg1)

	if v1 == "normal" or v1 == "text" then
		return tbl.Text
	end

	if v1 == "dim" or v1 == "muted" then
		return tbl.TextDim
	end

	if v1 == "bright" or v1 == "title" then
		return tbl.TextBright
	end

	if v1 == "warning" or v1 == "warn" or v1 == "yellow" then
		return tbl.TextMarked
	end

	if v1 == "danger" or v1 == "error" or v1 == "red" then
		return tbl.Danger
	end

	if v1 == "success" or v1 == "green" then
		return tbl.TextCode
	end

	if v1 == "accent" or v1 == "pink" then
		return tbl.Accent
	end

	return arg2
end

local function func23(arg1, arg2, arg3)
	arg1.Enabled = true

	function arg1:SetEnabled(arg21)
		local v1 = arg21 ~= false
		self.Enabled = v1

		for _, v2 in ipairs(arg2) do
			pcall(function()
				if v2:IsA("UIStroke") then
					v2.Transparency = v1 and 0 or 0.7
				elseif v2:IsA("ImageLabel") or v2:IsA("ImageButton") then
					v2.ImageTransparency = v1 and 0 or 0.6
				else
					v2.TextTransparency = v1 and 0 or 0.6
					if v2:IsA("TextBox") then
						v2.TextEditable = v1
					end
				end
			end)
		end

		return self
	end

	function arg1.SetDisabled(arg1, arg2)
		return arg1:SetEnabled(not arg2)
	end

	if arg3 and arg3.Disabled then
		arg1:SetEnabled(false)
	end

	return arg1
end

local function func24(arg1, arg2)
	if typeof(arg1.Color) == "Color3" then
		return arg1.Color, true
	end

	local v1 = func22(arg1.Style, nil)

	if v1 then
		return v1, true
	end

	return arg2, false
end

local function func25(arg1)
	local Flag = arg1.Flag

	if Flag == nil then
		Flag = arg1.Text
	end

	if Flag == false then
		return nil
	end

	return Flag
end

local func30
local func31
local tbl8 = {}
tbl8.__index = tbl8

function tbl8.Image(arg1, arg2)
	local v1 = arg2 or {}

	local v2 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, v1.Height or 120),
		BackgroundColor3 = tbl.Field,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Parent = arg1.Container,
		ThemeTag = {BackgroundColor3 = "Field"},
	})

	func9(v2, v1.Corner or 6)

	if v1.Border ~= false then
		func10(v2, tbl.Border)
	end

	local v3 = func8("ImageLabel", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Image = v1.Image or "",
		ScaleType = v1.ScaleType or Enum.ScaleType.Crop,
		Parent = v2,
	})

	local tbl1 = {
		Instance = v2,
		Image = v3,
		Set = function(arg1, arg2)
			v3.Image = tostring(arg2 or "")
			return arg1
		end,
		SetUser = function(arg1, arg2, arg3, arg4)
			local v1 = tonumber(arg2) or 0
			v3.Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", v1)

			task.spawn(function()
				local ok, result = pcall(function()
					return Players:GetUserThumbnailAsync(v1, arg3 or Enum.ThumbnailType.HeadShot, arg4 or Enum.ThumbnailSize.Size150x150)
				end)
				if ok and result and result ~= "" then
					v3.Image = result
				end
			end)

			return arg1
		end,
		SetHeight = function(arg1, arg2)
			v2.Size = UDim2.new(1, 0, 0, arg2)
			return arg1
		end,
	}

	if v1.UserId then
		tbl1:SetUser(v1.UserId)
	end

	return tbl1
end

function tbl8.Table(arg1, arg2)
	local v1 = arg2 or {}
	local v2 = v1.Columns or {"column"}
	local v3 = math.max(#v2, 1)
	local v4 = v1.MaxRows or 12
	local v5 = v1.RowHeight or 18

	local v6 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = arg1.Container,
	})

	func12(v6, 4)

	local function func(arg1, arg2)
		local v2 = func8(
			"Frame",
			{Size = UDim2.new(1, 0, 0, v5), BackgroundTransparency = 1, LayoutOrder = arg2, Parent = arg1}
		)

		local tbl1 = {}

		for i = 1, v3 do
			local Text = tbl.Text
			local v4 = tbl.TextSize - 1

			local tbl2 = {
				BackgroundTransparency = 1,
				Text = "",
				TextColor3 = Text or tbl.Text,
				TextSize = v4 or tbl.TextSize,
				Font = tbl.Font,
			}

			tbl2.TextXAlignment = Enum.TextXAlignment.Left
			tbl2.TextYAlignment = Enum.TextYAlignment.Center
			tbl2.RichText = true
			tbl2.Parent = v2
			local v6 = func8("TextLabel", tbl2)
			local fromScale = UDim2.fromScale
			v6.Position = fromScale((i - 1) / v3, 0)
			v6.Size = UDim2.new(1 / v3, -6, 1, 0)
			v6.TextTruncate = Enum.TextTruncate.AtEnd

			if i > 1 and v1.AlignRight then
				v6.TextXAlignment = Enum.TextXAlignment.Right
			end

			tbl1[i] = v6
		end

		return v2, tbl1
	end

	local v8

	if v1.Header ~= false then
		local _, v7 = func(v6, 1)
		v8 = v7

		for i, v9 in ipairs(v8) do
			v9.Text = tostring(v2[i] or "")
			v9.TextColor3 = tbl.TextDim
			func5(v9, {TextColor3 = "TextDim"})
		end

		func8("Frame", {
			Size = UDim2.new(1, 0, 0, 1),
			BackgroundColor3 = tbl.BorderSoft,
			BorderSizePixel = 0,
			LayoutOrder = 2,
			Parent = v6,
			ThemeTag = {BackgroundColor3 = "BorderSoft"},
		})
	end

	local v10 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = 3,
		Parent = v6,
	})

	func12(v10, 2)
	local v11 = func13(v6, v1.EmptyText or "no data", tbl.TextDim, tbl.TextSize - 1)
	v11.Size = UDim2.new(1, 0, 0, v5)
	v11.LayoutOrder = 4
	local tbl1 = {}

	for i1 = 1, tonumber(v4) do
		local v12, v13 = func(v10, i1)
		v12.Visible = false
		tbl1[i1] = {Frame = v12, Cells = v13}
	end

	local tbl2 = {
		Instance = v6,
		Rows = tbl1,
		SetRows = function(_, arg2)
			local v2 = arg2 or {}
			local num = 0

			for i, v3 in ipairs(tbl1) do
				local v4 = v2[i]
				if v4 then
					num = num + 1
					v3.Frame.Visible = true

					for i1, cell in ipairs(v3.Cells) do
						local v5 = v4[i1]
						cell.Text = v5 ~= nil and tostring(v5) or ""
						local v6 = v4.Color or v4.Colors and v4.Colors[i1]

						if typeof(v6) == "Color3" then
							cell.TextColor3 = v6
						elseif v4.Style then
							cell.TextColor3 = func22(v4.Style, tbl.Text)
						end
					end
				else
					v3.Frame.Visible = false
				end
			end

			v11.Visible = num == 0

			if v8 then
				for _, v7 in ipairs(v8) do
					v7.Visible = num > 0 or v1.KeepHeader == true
				end
			end

			return num
		end,
		Clear = function(arg1)
			return arg1:SetRows({})
		end,
	}

	tbl2:SetRows(v1.Rows)
	return tbl2
end

function tbl8.Divider(arg1)
	return (func8("Frame", {
		Size = UDim2.new(1, 0, 0, 1),
		BackgroundColor3 = tbl.BorderSoft,
		BorderSizePixel = 0,
		Parent = arg1.Container,
		ThemeTag = {BackgroundColor3 = "BorderSoft"},
	}))
end

local function func26(arg1, arg2, arg3, arg4)
	local v1 = func21(arg2)

	if not v1 then
		return nil
	end

	local v2 = func8("ImageLabel", {
		Size = UDim2.fromOffset(arg4, arg4),
		Position = UDim2.fromOffset(0, 1),
		BackgroundTransparency = 1,
		Image = v1.Image,
		ImageColor3 = arg3,
		Parent = arg1,
	})

	if v1.RectOffset then
		v2.ImageRectOffset = v1.RectOffset
	end

	if v1.RectSize then
		v2.ImageRectSize = v1.RectSize
	end

	return v2
end

function tbl8:Label(arg2, arg3)
	local v1 = arg3

	if typeof(arg3) == "Color3" then
		v1 = {Color = arg3}
	end

	local v2 = v1 or {}
	local v3 = v2.Color or func22(v2.Style, tbl.TextDim)

	local v4 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = self.Container,
	})

	local v5 = func26(v4, v2.Icon, v3, 14)
	local v6 = v5 and 20 or 0
	local v7 = func13(v4, tostring(arg2 or ""), v3, v2.TextSize, v2.Font)
	v7.Position = UDim2.fromOffset(v6, 0)
	v7.Size = UDim2.new(1, -v6, 0, 0)
	v7.AutomaticSize = Enum.AutomaticSize.Y
	v7.TextWrapped = true
	v7.TextYAlignment = Enum.TextYAlignment.Top
	local tbl1 = {Instance = v4, Text = v7, Icon = v5}

	local function func()
		if v2.KeepSpace then
			return
		end
		v4.Visible = v7.Text ~= ""
	end

	function tbl1:Set(arg2)
		v7.Text = tostring(arg2 or "")
		func()
	end

	function tbl1:SetColor(textColor3)
		v7.TextColor3 = textColor3
		if v5 then
			v5.ImageColor3 = textColor3
		end
	end

	function tbl1.SetStyle(_, arg2)
		tbl1:SetColor((func22(arg2, tbl.TextDim)))
	end

	func()
	return tbl1
end

function tbl8.Paragraph(arg1, arg2)
	local v1 = arg2 or {}
	local v2 = func22(v1.Style, tbl.TextBright)
	local v3 = type(v1.Style) == "string" and string.lower(v1.Style) ~= "normal"

	local v4 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = tbl.Group,
		BorderSizePixel = 0,
		Parent = arg1.Container,
		ThemeTag = {BackgroundColor3 = "Group"},
	})

	func9(v4, 5)
	local v5 = func10(v4, v3 and v2 or tbl.GroupBorder, 1, v3 and 0.55 or 0)
	func11(v4, 9, 11)

	local v6 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = v4,
	})

	func12(v6, 4)

	local v7 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = v6,
	})

	local v8 = func26(v7, v1.Icon, v2, 15)
	local v9 = v8 and 21 or 0
	local v10 = func13(v7, v1.Title or "", v2, tbl.TextSize, tbl.FontMedium)
	v10.Position = UDim2.fromOffset(v9, 0)
	v10.Size = UDim2.new(1, -v9, 0, 0)
	v10.AutomaticSize = Enum.AutomaticSize.Y
	v10.TextWrapped = true
	v10.TextYAlignment = Enum.TextYAlignment.Top
	local v11

	if v1.Content then
		v11 = func13(v6, v1.Content, v1.ContentColor or tbl.TextDim, v1.TextSize or 12)
		v11.Size = UDim2.new(1, 0, 0, 0)
		v11.AutomaticSize = Enum.AutomaticSize.Y
		v11.TextWrapped = true
		v11.TextYAlignment = Enum.TextYAlignment.Top
		v11.LayoutOrder = 2
	end

	return {
		Instance = v4,
		Title = v10,
		Body = v11,
		Icon = v8,
		Set = function(_, arg2)
			local v1 = arg2 or {}

			if v1.Title then
				v10.Text = v1.Title
			end

			if v1.Content and v11 then
				v11.Text = v1.Content
			end

			if v1.Style then
				local v2 = func22(v1.Style, tbl.TextBright)
				v10.TextColor3 = v2

				if v8 then
					v8.ImageColor3 = v2
				end

				v5.Color = v2
			end
		end,
	}
end

local tbl9 = {
	BETA = Color3.fromRGB(255, 184, 76),
	HOT = Color3.fromRGB(255, 92, 92),
	FIXED = Color3.fromRGB(96, 214, 140),
	NEW = Color3.fromRGB(96, 205, 255),
}

local function func27(arg1, arg2)
	if arg2 == nil or arg2 == false or arg2 == "" then
		return nil
	end

	local v1 = arg2
	local Color

	if type(arg2) == "table" then
		v1 = arg2.Text or arg2.Title or ""
		Color = arg2.Color
	end

	local v2 = string.upper(tostring(v1))

	if v2 == "" then
		return nil
	end

	local v3

	if Color then
		v3 = Color
	else
		v3 = tbl9[v2]
	end

	local v4 = func8("Frame", {
		Name = "Badge",
		Size = UDim2.fromOffset(0, 15),
		AutomaticSize = Enum.AutomaticSize.X,
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = v3 or tbl.Accent,
		BackgroundTransparency = 0.84,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = arg1,
		ThemeTag = not v3 and {BackgroundColor3 = "Accent"} or nil,
	})

	func9(v4, 4)
	local v5 = func10(v4, v3 or tbl.Accent, 1, 0.55)

	if not v3 then
		tbl6:Tag(v5, {Color = "Accent"})
	end

	func11(v4, 0, 6, 0, 6)
	local v6 = func13(v4, v2, v3 or tbl.Accent, 9, Enum.Font.GothamBold)
	v6.Size = UDim2.fromScale(0, 1)
	v6.AutomaticSize = Enum.AutomaticSize.X
	v6.TextXAlignment = Enum.TextXAlignment.Center
	v6.ZIndex = 3

	if not v3 then
		tbl6:Tag(v6, {TextColor3 = "Accent"})
	end

	return v4
end

local function func28(arg1, arg2, arg3, arg4)
	local tbl1 = {Enabled = true}

	local v1 = func8("TextButton", {
		Size = arg3 or UDim2.new(1, 0, 0, 26),
		BackgroundColor3 = tbl.Field,
		AutoButtonColor = false,
		Text = "",
		BorderSizePixel = 0,
		LayoutOrder = arg4,
		Parent = arg1,
		ThemeTag = {BackgroundColor3 = "Field"},
	})

	func9(v1, 5)
	func10(v1, tbl.Border)
	local v2 = func13(v1, arg2.Text or "button", (func24(arg2, tbl.TextBright)))
	v2.Size = UDim2.fromScale(1, 1)
	v2.TextXAlignment = Enum.TextXAlignment.Center
	v2.TextTruncate = Enum.TextTruncate.AtEnd
	func17(v1, v1, "Field", "FieldHover")

	local connection = v1.Activated:Connect(function()
		if tbl1.Enabled == false then
			return
		end
		tbl6:SafeCallback(arg2.Text or "button", arg2.Callback)
	end)

	table.insert(tbl6.Connections, connection)

	function tbl1.SetBadge(arg1)
		if tbl1.Badge then
			tbl1.Badge:Destroy()
			tbl1.Badge = nil
		end

		if tbl1.BadgeConn then
			tbl1.BadgeConn:Disconnect()
			tbl1.BadgeConn = nil
		end

		local v3 = func27(v1, arg1)

		if not v3 then
			return
		end

		tbl1.Badge = v3

		local function func()
			local v4 = math.min(v2.TextBounds.X, v1.AbsoluteSize.X)
			v3.Position = UDim2.new(0.5, math.floor(v4 / 2) + 6, 0.5, 0)
		end

		tbl1.BadgeConn = v2:GetPropertyChangedSignal("TextBounds"):Connect(func)
		table.insert(tbl6.Connections, tbl1.BadgeConn)
		func()
	end

	if arg2.Badge then
		tbl1.SetBadge(arg2.Badge)
	end

	return v1, tbl1, v2
end

function tbl8.Button(arg1, arg2)
	local v1 = arg2 or {}
	local v2, v3, v4 = func28(arg1.Container, v1)
	local v5 = func23({Instance = v2}, {v4})
	local SetEnabled = v5.SetEnabled

	function v5:SetEnabled(arg2)
		v3.Enabled = arg2 ~= false
		return SetEnabled(self, arg2)
	end

	function v5.SetBadge(arg1, arg2)
		v3.SetBadge(arg2)
		return arg1
	end

	function v5.SetText(arg1, arg2)
		v4.Text = tostring(arg2)
		return arg1
	end

	if v1.Disabled then
		v5:SetEnabled(false)
	end

	return v5
end

function tbl8:ButtonRow(arg2)
	local v1 = func8("Frame", {Size = UDim2.new(1, 0, 0, 26), BackgroundTransparency = 1, Parent = self.Container})
	func12(v1, 8, Enum.FillDirection.Horizontal)
	local v2 = math.max(#arg2, 1)
	local tbl = {}

	for i, v3 in ipairs(arg2) do
		tbl[i] = func28(v1, v3, UDim2.new(1 / v2, -(8 * (v2 - 1)) / v2, 1, 0), i)
	end

	return {Instance = v1, Buttons = tbl}
end

function tbl8.Split(arg1, arg2)
	local tbl = {Size = UDim2.new(1, 0, 0, 0)}
	tbl.AutomaticSize = Enum.AutomaticSize.Y
	tbl.BackgroundTransparency = 1
	tbl.Parent = arg1.Container
	local v1 = func8("Frame", tbl)
	func12(v1, 12, Enum.FillDirection.Horizontal).SortOrder = Enum.SortOrder.LayoutOrder
	local v2 = math.max(#arg2, 1)
	local tbl1 = {}

	for i = 1, v2 do
		local tbl2 = {Size = UDim2.new(1 / v2, -(12 * (v2 - 1)) / v2, 0, 0)}
		tbl2.AutomaticSize = Enum.AutomaticSize.Y
		tbl2.BackgroundTransparency = 1
		tbl2.LayoutOrder = i
		tbl2.Parent = v1
		local v3 = func8("Frame", tbl2)
		local tbl3 = {FillDirection = Enum.FillDirection.Vertical, Padding = UDim.new(0, 9)}
		tbl3.SortOrder = Enum.SortOrder.LayoutOrder
		tbl3.Parent = v3
		func8("UIListLayout", tbl3)

		func8("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(0, 9),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = v3,
		})

		tbl1[i] = setmetatable({Window = arg1.Window, Container = v3, Float = arg1.Float}, tbl8)

		if type(arg2[i]) == "function" then
			arg2[i](tbl1[i])
		end
	end

	return {Instance = v1, Columns = tbl1}
end

function tbl8.Input(arg1, arg2)
	local v1 = arg2 or {}
	local v2 = func25(v1)

	local v3 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = arg1.Container,
	})

	func12(v3, 5)

	if v1.Text then
		func13(v3, v1.Text, (func24(v1, tbl.Text))).Size = UDim2.new(1, 0, 0, 15)
	end

	local v4 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 26),
		BackgroundColor3 = tbl.Field,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		LayoutOrder = 2,
		Parent = v3,
		ThemeTag = {BackgroundColor3 = "Field"},
	})

	func9(v4, 5)
	local v5 = func10(v4, tbl.Border)

	local v6 = func8("TextBox", {
		Size = UDim2.new(1, -20, 1, 0),
		Position = UDim2.fromOffset(10, 0),
		BackgroundTransparency = 1,
		Text = v1.Default or "",
		PlaceholderText = v1.Placeholder or "",
		PlaceholderColor3 = tbl.TextDim,
		TextColor3 = tbl.TextBright,
		TextSize = tbl.TextSize,
		Font = tbl.Font,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = false,
		Parent = v4,
		ThemeTag = {PlaceholderColor3 = "TextDim", TextColor3 = "TextBright"},
	})

	local v7 = func23({Instance = v3, Box = v6}, {v6}, v1)

	function v7.Get(_)
		return v6.Text
	end

	function v7:Set(arg2, arg3)
		v6.Text = tostring(arg2 or "")

		if v2 then
			tbl6.Flags[v2] = v6.Text
		end

		if not arg3 then
			tbl6:SafeCallback(v1.Text or "input", v1.Callback, v6.Text)
		end
	end

	local connection = v6.Focused:Connect(function()
		TweenService:Create(v5, tweenInfo1 or tweenInfo, {Color = tbl.Accent}):Play()
	end)

	table.insert(tbl6.Connections, connection)

	local connection1 = v6.FocusLost:Connect(function(enterPressed)
		TweenService:Create(v5, tweenInfo1 or tweenInfo, {Color = tbl.Border}):Play()

		if v2 then
			tbl6.Flags[v2] = v6.Text
			tbl6:MarkDirty(v2)
		end

		tbl6:SafeCallback(v1.Text or "input", v1.Callback, v6.Text, enterPressed)
	end)

	table.insert(tbl6.Connections, connection1)

	if v2 then
		tbl6.Flags[v2] = v6.Text
		tbl6:Register(v2, {
			Type = "Input",
			Get = function()
				return v6.Text
			end,
			Set = function(arg1)
				v7:Set(arg1)
			end,
		})
	end

	return v7
end

local function func29(arg1, arg2, arg3, arg4)
	local v1 = func13(arg2, "?", tbl.TextDim, 12)
	v1.Size = UDim2.fromOffset(10, 18)
	v1.TextXAlignment = Enum.TextXAlignment.Center
	v1.LayoutOrder = arg4 or 2
	v1.Name = "Hint"
	local v2 = arg1 and arg1.Window
	local v3

	local function func()
		if v3 then
			v3:Destroy()
			v3 = nil
		end
	end

	local connection = v1.MouseEnter:Connect(function()
		if v3 then
			v3:Destroy()
			v3 = nil
		end

		local v4 = v2 and v2.Overlay or v1

		local tbl1 = {
			BackgroundColor3 = tbl.PopupBg,
			Text = arg3,
			TextColor3 = tbl.TextBright,
			TextSize = 12,
			Font = tbl.Font,
			TextWrapped = true,
		}

		tbl1.TextXAlignment = Enum.TextXAlignment.Left
		tbl1.AutomaticSize = Enum.AutomaticSize.Y
		tbl1.Size = UDim2.fromOffset(210, 0)
		tbl1.AnchorPoint = Vector2.new(0, 1)
		tbl1.ZIndex = 340
		tbl1.BorderSizePixel = 0
		tbl1.Parent = v4
		tbl1.ThemeTag = {BackgroundColor3 = "PopupBg", TextColor3 = "TextBright"}
		v3 = func8("TextLabel", tbl1)
		local v5 = v3
		func11(v5, 6, 9)
		func9(v5, 4)
		func10(v5, tbl.PopupBorder)

		if v2 then
			local v6 = math.max(v2.Scale.Scale, 0.05)
			local v7 = (v1.AbsolutePosition.X - v2.Main.AbsolutePosition.X) / v6
			local v8 = (v1.AbsolutePosition.Y - v2.Main.AbsolutePosition.Y) / v6
			local v9 = v2.Main.AbsoluteSize.X / v6
			v3.Position = UDim2.fromOffset(math.clamp(v7 + 14, 8, math.max(v9 - 218, 8)), v8 - 4)
			return
		end

		v3.Position = UDim2.new(0, 14, 0, -4)
	end)

	table.insert(tbl6.Connections, connection)
	local connection1 = v1.MouseLeave:Connect(func)
	table.insert(tbl6.Connections, connection1)
	return v1
end

function tbl8:Toggle(arg2)
	local v1 = arg2 or {}
	local v2 = func25(v1)
	local v3 = v1.Default == true
	local v4 = func8("Frame", {Size = UDim2.new(1, 0, 0, 22), BackgroundTransparency = 1, Parent = self.Container})

	local v5 = func8("TextButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		AutoButtonColor = false,
		Parent = v4,
	})

	local v6 = func8("Frame", {
		Size = UDim2.fromOffset(13, 13),
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 0, 0.5, 0),
		BackgroundColor3 = tbl.Accent,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Parent = v4,
		ThemeTag = {BackgroundColor3 = "Accent"},
	})

	func9(v6, 3)
	local v7 = func10(v6, tbl.Border)
	local v8, v9 = func24(v1, tbl.Text)
	local v10 = func13(v4, v1.Text or "toggle", v8)
	v10.Position = UDim2.fromOffset(21, 0)
	v10.Size = UDim2.new(1, -21, 1, 0)

	local v11 = func8("Frame", {
		Size = UDim2.new(1, -21, 1, 0),
		Position = UDim2.fromOffset(21, 0),
		BackgroundTransparency = 1,
		Parent = v4,
	})

	func12(v11, 6, Enum.FillDirection.Horizontal).VerticalAlignment = Enum.VerticalAlignment.Center
	v10.Parent = v11
	v10.Size = UDim2.fromOffset(0, 18)
	v10.AutomaticSize = Enum.AutomaticSize.X
	v10.Position = UDim2.fromOffset(0, 0)
	v10.LayoutOrder = 1

	if v1.Hint then
		func29(self, v11, v1.Hint, 2)
	end

	local tbl1 = {Size = UDim2.new(0, 0, 1, 0), AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0)}
	tbl1.AutomaticSize = Enum.AutomaticSize.X
	tbl1.BackgroundTransparency = 1
	tbl1.Parent = v4
	local v12 = func8("Frame", tbl1)
	local v13 = func12(v12, 8, Enum.FillDirection.Horizontal)
	v13.VerticalAlignment = Enum.VerticalAlignment.Center
	v13.HorizontalAlignment = Enum.HorizontalAlignment.Right

	local function func()
		local v1 = math.max(self.Window.Scale.Scale, 0.05)
		local v2 = v12.AbsoluteSize.X / v1
		v11.Size = UDim2.new(1, -(21 + (v2 > 0 and v2 + 10 or 0)), 1, 0)
	end

	local connection = v12:GetPropertyChangedSignal("AbsoluteSize"):Connect(func)
	table.insert(tbl6.Connections, connection)
	func()
	local num = 0
	local tbl2 = {Instance = v4, State = v3, Pickers = {}}

	local function func1(arg1)
		local v1 = arg1 and tweenInfo1 or TweenInfo.new(0)
		TweenService:Create(v6, v1 or tweenInfo, {BackgroundTransparency = v3 and 0 or 1}):Play()
		tbl6:Tag(v7, {Color = v3 and "Accent" or "Border"})
		TweenService:Create(v7, v1 or tweenInfo, {Color = v3 and tbl.Accent or tbl.Border}):Play()
	end

	function tbl2:Set(arg2, arg3)
		v3 = arg2 and true or false
		tbl2.State = v3

		if v2 then
			tbl6.Flags[v2] = v3
			tbl6:MarkDirty(v2)
		end

		func1(true)
		tbl6:RefreshHotkeys()

		if not arg3 then
			tbl6:SafeCallback(v1.Text or "toggle", v1.Callback, v3)
		end
	end

	local connection1 = v5.Activated:Connect(function()
		if tbl2.Enabled == false then
			return
		end
		tbl2:Set(not v3)
	end)

	table.insert(tbl6.Connections, connection1)

	local connection2 = v5.MouseEnter:Connect(function()
		if v9 then
			return
		end
		TweenService:Create(v10, tweenInfo1 or tweenInfo, {TextColor3 = tbl.TextBright}):Play()
	end)

	table.insert(tbl6.Connections, connection2)

	local connection3 = v5.MouseLeave:Connect(function()
		if v9 then
			return
		end
		TweenService:Create(v10, tweenInfo1 or tweenInfo, {TextColor3 = tbl.Text}):Play()
	end)

	table.insert(tbl6.Connections, connection3)

	function tbl2.Keybind(_, arg2)
		local v2 = arg2 or {}
		local Default = v2.Default

		local v4 = func8("TextButton", {
			Size = UDim2.new(0, 0, 0, 20),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundColor3 = tbl.Field,
			AutoButtonColor = false,
			Text = "",
			BorderSizePixel = 0,
			LayoutOrder = 20,
			Parent = v12,
			ThemeTag = {BackgroundColor3 = "Field"},
		})

		func9(v4, 4)
		func10(v4, tbl.Border)
		local v5 = func13(v4, "", tbl.TextDim, 12)
		v5.Size = UDim2.new(0, 0, 1, 0)
		v5.AutomaticSize = Enum.AutomaticSize.X
		func11(v4, 0, 8)
		local Flag = v2.Flag
		local flag = false

		local function func()
			if flag then
				v5.Text = 'key: <font color="' .. func3() .. '">...</font>'
			elseif Default then
				v5.Text = 'key: <font color="' .. func3() .. '">' .. Default .. "</font>"
			else
				v5.Text = "key: NONE"
			end

			if Flag then
				tbl6.Flags[Flag] = Default or ""
				tbl6:MarkDirty(Flag)
			end

			tbl6:RefreshHotkeys()
		end

		func()

		tbl6:RegisterHotkey(function()
			return {Label = v1.Text or "toggle", Key = Default, Active = v3, Visible = Default ~= nil}
		end)

		tbl6:OnRepaint(func)

		if Flag then
			tbl6:Register(Flag, {
				Type = "Keybind",
				Get = function()
					return Default or ""
				end,
				Set = function(arg1)
					Default = arg1 ~= "" and arg1 or nil
					flag = false
					func()
				end,
			})
		end

		local connection = v4.Activated:Connect(function()
			flag = true
			tbl6.Binding = true
			func()
			TweenService:Create(v4, tweenInfo1 or tweenInfo, {BackgroundColor3 = tbl.FieldHover}):Play()
		end)

		table.insert(tbl6.Connections, connection)

		local connection1 = v4.MouseButton2Click:Connect(function()
			Default = nil
			flag = false
			tbl6.Binding = false
			func()
		end)

		table.insert(tbl6.Connections, connection1)

		local connection2 = UserInputService.InputBegan:Connect(function(input, gameProcessed)
			local v1 = func16(input)

			if flag then
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					flag = false
					tbl6.Binding = false
					TweenService:Create(v4, tweenInfo1 or tweenInfo, {BackgroundColor3 = tbl.Field}):Play()
					func()
					return
				end

				if input.KeyCode == Enum.KeyCode.Escape then
					Default = nil
				elseif v1 then
					Default = v1
				else
					return
				end

				flag = false
				tbl6.Binding = false
				func()
				TweenService:Create(v4, tweenInfo1 or tweenInfo, {BackgroundColor3 = tbl.Field}):Play()
				return
			end

			if gameProcessed or not Default or v1 ~= Default then
				return
			end

			if v2.Mode == "hold" then
				return
			end

			tbl2:Set(not v3)
		end)

		table.insert(tbl6.Connections, connection2)

		if v2.Mode == "hold" then
			local connection3 = UserInputService.InputEnded:Connect(function(input)
				if Default and func16(input) == Default then
					tbl2:Set(false)
				end
			end)

			table.insert(tbl6.Connections, connection3)

			local connection4 = UserInputService.InputBegan:Connect(function(input, gameProcessed)
				if not gameProcessed and Default and func16(input) == Default then
					tbl2:Set(true)
				end
			end)

			table.insert(tbl6.Connections, connection4)
		end

		return tbl2
	end

	function tbl2.ColorPicker(_, arg2)
		local v1 = arg2 or {}
		num = num + 1

		local v2 = func31(v12, {
			Size = UDim2.fromOffset(24, 13),
			BackgroundColor3 = v1.Default or Color3.fromRGB(255, 255, 255),
			AutoButtonColor = false,
			Text = "",
			BorderSizePixel = 0,
			LayoutOrder = num,
			Parent = v12,
		})

		local v3 = func30(self, v2, v1)
		tbl2.Pickers[num] = v3
		return tbl2
	end

	function tbl2.Gear(_, arg2)
		local v1 = func8("ImageButton", {
			Size = UDim2.fromOffset(14, 14),
			BackgroundTransparency = 1,
			Image = tbl.GearIcon,
			ImageColor3 = tbl.TextDim,
			LayoutOrder = 30,
			Parent = v12,
			ThemeTag = {ImageColor3 = "TextDim"},
		})

		local Floating = self.Window:CreateFloating(190, false, self.Float)
		local v2 = setmetatable({Window = self.Window, Container = Floating.Content, Float = Floating}, tbl8)

		if arg2 then
			arg2(v2)
		end

		local connection = v1.MouseEnter:Connect(function()
			TweenService:Create(v1, tweenInfo1 or tweenInfo, {ImageColor3 = tbl.TextBright}):Play()
		end)

		table.insert(tbl6.Connections, connection)

		local connection1 = v1.MouseLeave:Connect(function()
			TweenService:Create(v1, tweenInfo1 or tweenInfo, {ImageColor3 = tbl.TextDim}):Play()
		end)

		table.insert(tbl6.Connections, connection1)

		local connection2 = v1.Activated:Connect(function()
			self.Window:ToggleFloating(Floating, v1)
		end)

		table.insert(tbl6.Connections, connection2)
		return tbl2
	end

	func23(tbl2, {v10, v7}, v1)

	if v2 then
		tbl6.Flags[v2] = v3
		tbl6:Register(v2, {
			Type = "Toggle",
			Get = function()
				return v3
			end,
			Set = function(arg1)
				tbl2:Set(arg1 == true)
			end,
		})
	end

	func1(false)

	if v3 then
		tbl6:SafeCallback(v1.Text or "toggle", v1.Callback, v3)
	end

	return tbl2
end

function tbl8:Dropdown(arg2)
	local v1 = arg2 or {}
	local v2 = func25(v1)
	local v3 = v1.Options or {}
	local v4 = v1.Multi == true
	local v5 = v4 and (v1.Default or {}) or v1.Default or v3[1]

	local v6 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = self.Container,
	})

	func12(v6, 5)
	local v8

	if v1.Text then
		local v7 = func13(v6, v1.Text, (func24(v1, tbl.Text)))
		v8 = v7
		v7.Size = UDim2.new(1, 0, 0, 15)
	end

	local v9 = func8("TextButton", {
		Size = UDim2.new(1, 0, 0, 26),
		BackgroundColor3 = tbl.Field,
		AutoButtonColor = false,
		Text = "",
		BorderSizePixel = 0,
		LayoutOrder = 2,
		Parent = v6,
		ThemeTag = {BackgroundColor3 = "Field"},
	})

	func9(v9, 5)
	local v10 = func10(v9, tbl.Border)
	local v11 = func13(v9, "", tbl.TextBright)
	v11.Position = UDim2.fromOffset(10, 0)
	v11.Size = UDim2.new(1, -34, 1, 0)
	v11.TextTruncate = Enum.TextTruncate.AtEnd
	local v12 = func15(v9, tbl.Text)
	v12.AnchorPoint = Vector2.new(1, 0.5)
	v12.Position = UDim2.new(1, -10, 0.5, 0)
	local v13 = v4 and v1.Chips == true
	local v14

	if v13 then
		local tbl1 = {Size = UDim2.new(1, 0, 0, 0)}
		tbl1.AutomaticSize = Enum.AutomaticSize.Y
		tbl1.BackgroundTransparency = 1
		tbl1.LayoutOrder = 3
		tbl1.Visible = false
		tbl1.Parent = v6
		v14 = func8("Frame", tbl1)
		local v15 = func12(v14, 5, Enum.FillDirection.Horizontal)
		v15.Wraps = true
		v15.VerticalAlignment = Enum.VerticalAlignment.Center
	end

	local Floating = self.Window:CreateFloating(0, true, self.Float)

	local v16 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 24),
		BackgroundColor3 = tbl.Field,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		LayoutOrder = 1,
		Visible = false,
		ZIndex = Floating.Frame.ZIndex,
		Parent = Floating.Content,
		ThemeTag = {BackgroundColor3 = "Field"},
	})

	func9(v16, 4)
	func10(v16, tbl.Border)

	local v17 = func8("TextBox", {
		Size = UDim2.new(1, -16, 1, 0),
		Position = UDim2.fromOffset(8, 0),
		BackgroundTransparency = 1,
		Text = "",
		PlaceholderText = "search",
		PlaceholderColor3 = tbl.TextDim,
		TextColor3 = tbl.TextBright,
		TextSize = 12,
		Font = tbl.Font,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = false,
		ZIndex = Floating.Frame.ZIndex,
		Parent = v16,
		ThemeTag = {PlaceholderColor3 = "TextDim", TextColor3 = "TextBright"},
	})

	local v18 = func8("ScrollingFrame", {
		Size = UDim2.new(1, 0, 0, 24),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.new(),
		ScrollBarThickness = 2,
		ScrollBarImageColor3 = tbl.AccentDim,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		LayoutOrder = 2,
		ZIndex = Floating.Frame.ZIndex,
		Parent = Floating.Content,
		ThemeTag = {ScrollBarImageColor3 = "AccentDim"},
	})

	func12(v18, 2)
	local tbl2 = {Instance = v6}
	local tbl3 = {}

	local function func()
		if v4 then
			if #v5 == 0 then
				return v1.Empty or "none"
			end

			if v13 then
				return #v5 .. " selected"
			end

			return table.concat(v5, ", ")
		end
		return tostring(v5 or v1.Empty or "none")
	end

	local function func1(arg1)
		if v4 then
			for _, v1 in ipairs(v5) do
				if v1 == arg1 then
					return true
				end
			end
			return false
		end
		return v5 == arg1
	end

	local func3

	local function func2()
		v11.Text = func()

		if func3 then
			func3()
		end

		for k, v1 in pairs(tbl3) do
			local flag

			if v4 then
				local v3, v6, v7 = ipairs(v5)
				flag = false

				for _, v8 in v3, v6, v7 do
					if v8 == k then
						flag = true
						break
					end
				end
			else
				flag = v5 == k
			end

			tbl6:Tag(v1.Text, {TextColor3 = flag and "AccentSoft" or "Text"})
			TweenService:Create(v1.Text, tweenInfo1 or tweenInfo, {TextColor3 = flag and tbl.AccentSoft or tbl.Text}):Play()
		end

		if v2 then
			tbl6.Flags[v2] = v5
			tbl6:MarkDirty(v2)
		end
	end

	if v13 then
		local tbl4 = {}
		function func3()
			for _, v2 in ipairs(tbl4) do
				v2:Destroy()
			end

			table.clear(tbl4)
			v14.Visible = #v5 > 0

			for i, v3 in ipairs(v5) do
				local v4 = func8("Frame", {
					Size = UDim2.fromOffset(0, 22),
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundColor3 = tbl.Accent,
					BackgroundTransparency = 0.84,
					BorderSizePixel = 0,
					LayoutOrder = i,
					Parent = v14,
					ThemeTag = {BackgroundColor3 = "Accent"},
				})

				func8("UICorner", {CornerRadius = UDim.new(0, 11), Parent = v4})
				func8("UICorner", {CornerRadius = UDim.new(0, 11), Parent = v4})

				local v6 = func8("UIStroke", {
					Color = tbl.Accent or tbl.Border,
					Thickness = 1,
					Transparency = 0.6,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Parent = v4,
				})

				tbl6:Tag(v6, {Color = "Accent"})
				func11(v4, 0, 6, 0, 10)

				func8("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal or Enum.FillDirection.Vertical,
					Padding = UDim.new(0, 6),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = v4,
				}).VerticalAlignment = Enum.VerticalAlignment.Center

				local tbl1 = {
					BackgroundTransparency = 1,
					Text = tostring(v3),
					TextColor3 = tbl.AccentSoft or tbl.Text,
					TextSize = 12,
					Font = tbl.Font,
				}

				tbl1.TextXAlignment = Enum.TextXAlignment.Left
				tbl1.TextYAlignment = Enum.TextYAlignment.Center
				tbl1.RichText = true
				tbl1.Parent = v4
				local v7 = func8("TextLabel", tbl1)
				v7.Size = UDim2.fromScale(0, 1)
				v7.AutomaticSize = Enum.AutomaticSize.X
				v7.LayoutOrder = 1
				tbl6:Tag(v7, {TextColor3 = "AccentSoft"})

				local v8 = func8("TextButton", {
					Size = UDim2.fromOffset(14, 14),
					BackgroundTransparency = 1,
					AutoButtonColor = false,
					Text = "×",
					TextColor3 = tbl.AccentSoft,
					TextSize = 14,
					Font = tbl.FontMedium,
					LayoutOrder = 2,
					Parent = v4,
					ThemeTag = {TextColor3 = "AccentSoft"},
				})

				local connection = v8.MouseEnter:Connect(function()
					TweenService:Create(v8, tweenInfo1 or tweenInfo, {TextColor3 = tbl.Danger}):Play()
				end)

				table.insert(tbl6.Connections, connection)

				local connection1 = v8.MouseLeave:Connect(function()
					TweenService:Create(v8, tweenInfo1 or tweenInfo, {TextColor3 = tbl.AccentSoft}):Play()
				end)

				table.insert(tbl6.Connections, connection1)

				local connection2 = v8.Activated:Connect(function()
					if tbl2.Enabled == false then
						return
					end

					for i, v2 in ipairs(v5) do
						if v2 == v3 then
							table.remove(v5, i)
							break
						end
					end

					func2()
					tbl6:SafeCallback(v1.Text or "dropdown", v1.Callback, v5)
				end)

				table.insert(tbl6.Connections, connection2)
				table.insert(tbl4, v4)
			end
		end
	end

	local function func4()
		local v2 = v16.Visible and string.lower(v17.Text) or ""
		local num = 0

		for _, v4 in ipairs(v3) do
			local v5 = tbl3[v4]
			if v5 then
				local v6 = v2 == "" or string.find(string.lower(tostring(v4)), v2, 1, true) ~= nil
				v5.Button.Visible = v6

				if v6 then
					num = num + 1
				end
			end
		end

		v18.Size = UDim2.new(1, 0, 0, math.min(math.max(num, 1) * 26 - 2, v1.MaxHeight or 154))
	end

	local function func5()
		for _, v2 in pairs(tbl3) do
			v2.Button:Destroy()
		end

		v16.Visible = v1.Search == true or v1.Search ~= false and #v3 > 8
		tbl3 = {}

		for i, v6 in ipairs(v3) do
			local v7 = func8("TextButton", {
				Size = UDim2.new(1, 0, 0, 24),
				BackgroundColor3 = tbl.FieldHover,
				BackgroundTransparency = 1,
				AutoButtonColor = false,
				Text = "",
				BorderSizePixel = 0,
				LayoutOrder = i,
				ZIndex = Floating.Frame.ZIndex,
				Parent = v18,
				ThemeTag = {BackgroundColor3 = "FieldHover"},
			})

			func8("UICorner", {CornerRadius = UDim.new(0, 4), Parent = v7})
			func8("UICorner", {CornerRadius = UDim.new(0, 4), Parent = v7})
			local v8 = func13(v7, tostring(v6), tbl.Text)
			v8.Position = UDim2.fromOffset(8, 0)
			v8.Size = UDim2.new(1, -16, 1, 0)
			v8.ZIndex = Floating.Frame.ZIndex
			tbl3[v6] = {Button = v7, Text = v8}

			local connection = v7.MouseEnter:Connect(function()
				TweenService:Create(v7, tweenInfo1 or tweenInfo, {BackgroundTransparency = 0.4}):Play()
			end)

			table.insert(tbl6.Connections, connection)

			local connection1 = v7.MouseLeave:Connect(function()
				TweenService:Create(v7, tweenInfo1 or tweenInfo, {BackgroundTransparency = 1}):Play()
			end)

			table.insert(tbl6.Connections, connection1)

			local connection2 = v7.Activated:Connect(function()
				if v4 then
					local v3

					for i, v2 in ipairs(v5) do
						if v2 == v6 then
							v3 = i
							break
						end
					end

					if v3 then
						table.remove(v5, v3)
					else
						table.insert(v5, v6)
					end
				else
					v5 = v6
					self.Window:CloseFloating()
				end

				func2()
				tbl6:SafeCallback(v1.Text or "dropdown", v1.Callback, v5)
			end)

			table.insert(tbl6.Connections, connection2)
		end

		func4()
	end

	local connection = v17:GetPropertyChangedSignal("Text"):Connect(func4)
	table.insert(tbl6.Connections, connection)

	function Floating.OnOpen()
		v17.Text = ""
		func4()
		tbl6:Tag(v10, {Color = "Accent"})
		TweenService:Create(v10, tweenInfo1 or tweenInfo, {Color = tbl.Accent}):Play()
		TweenService:Create(v12, tweenInfo1 or tweenInfo, {Rotation = 180}):Play()
	end

	function Floating.OnClose()
		tbl6:Tag(v10, {Color = "Border"})
		TweenService:Create(v10, tweenInfo1 or tweenInfo, {Color = tbl.Border}):Play()
		TweenService:Create(v12, tweenInfo1 or tweenInfo, {Rotation = 0}):Play()
	end

	local connection1 = v9.Activated:Connect(function()
		if tbl2.Enabled == false then
			return
		end
		self.Window:ToggleFloating(Floating, v9, true)
	end)

	table.insert(tbl6.Connections, connection1)
	func17(v9, v9, "Field", "FieldHover")

	function tbl2:Set(arg2, arg3)
		v5 = arg2
		func2()

		if not arg3 then
			tbl6:SafeCallback(v1.Text or "dropdown", v1.Callback, v5)
		end
	end

	function tbl2.Get(_)
		return v5
	end

	function tbl2.SetOptions(_, arg2)
		v3 = arg2 or {}
		func5()

		if not v4 and not func1(v5) then
			v5 = v3[1]
		end

		func2()
	end

	func5()
	func2()
	func23(tbl2, {v11, v8}, v1)
	tbl6:OnRepaint(func2)

	if v2 then
		tbl6:Register(v2, {
			Type = v4 and "MultiDropdown" or "Dropdown",
			Get = function()
				if not v4 then
					return v5
				end

				local tbl = {}

				for i, v1 in ipairs(v5) do
					tbl[i] = v1
				end

				return tbl
			end,
			Set = function(arg1)
				local v1 = arg1

				if v4 and type(arg1) ~= "table" then
					v1 = {arg1}
				end

				tbl2:Set(v1)
			end,
		})
	end

	return tbl2
end

function tbl8.MultiSelect(arg1, arg2)
	local tbl = {}

	for k, v1 in pairs(arg2 or {}) do
		tbl[k] = v1
	end

	tbl.Multi = true

	if tbl.Chips == nil then
		tbl.Chips = true
	end

	if tbl.Empty == nil then
		tbl.Empty = tbl.Placeholder or "select..."
	end

	return arg1:Dropdown(tbl)
end

function tbl8.Slider(arg1, arg2)
	local v1 = arg2 or {}
	local v2 = func25(v1)
	local v3 = v1.Min or 0
	local v4 = v1.Max or 100
	local v5 = v1.Decimals or 0
	local v6 = math.clamp(v1.Default or v3, v3, v4)
	local v7 = func8("Frame", {Size = UDim2.new(1, 0, 0, 30), BackgroundTransparency = 1, Parent = arg1.Container})
	local v8 = func8("Frame", {Size = UDim2.new(1, 0, 0, 16), BackgroundTransparency = 1, Parent = v7})
	func12(v8, 8, Enum.FillDirection.Horizontal).VerticalAlignment = Enum.VerticalAlignment.Center
	local v9 = func13(v8, v1.Text or "slider", (func24(v1, tbl.Text)))
	v9.Size = UDim2.fromOffset(0, 16)
	v9.AutomaticSize = Enum.AutomaticSize.X

	local v10 = func8("TextBox", {
		Size = UDim2.fromOffset(0, 16),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		Text = "",
		TextColor3 = tbl.TextDim,
		TextSize = 12,
		Font = tbl.Font,
		PlaceholderColor3 = tbl.TextDim,
		ClearTextOnFocus = true,
		LayoutOrder = 2,
		Parent = v8,
		ThemeTag = {TextColor3 = "TextDim", PlaceholderColor3 = "TextDim"},
	})

	local v11 = func8("TextButton", {
		Size = UDim2.new(1, 0, 0, 4),
		Position = UDim2.new(0, 0, 0, 24),
		BackgroundColor3 = tbl.Track,
		AutoButtonColor = false,
		Text = "",
		BorderSizePixel = 0,
		Parent = v7,
		ThemeTag = {BackgroundColor3 = "Track"},
	})

	func9(v11, 2)

	local v12 = func8("Frame", {
		Size = UDim2.fromScale(0, 1),
		BackgroundColor3 = tbl.Accent,
		BorderSizePixel = 0,
		Parent = v11,
		ThemeTag = {BackgroundColor3 = "Accent"},
	})

	func9(v12, 2)

	local v13 = func8("Frame", {
		Size = UDim2.fromOffset(9, 9),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0, 0.5),
		BackgroundColor3 = tbl.Accent,
		BorderSizePixel = 0,
		Parent = v11,
		ThemeTag = {BackgroundColor3 = "Accent"},
	})

	func9(v13, 5)

	local v14 = func8("TextButton", {
		Size = UDim2.new(1, 0, 0, 15),
		Position = UDim2.new(0, 0, 0, 16),
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Text = "",
		Parent = v7,
	})

	local tbl1 = {Instance = v7, Value = v6}

	local function func(arg1)
		if v1.ZeroText and arg1 == v3 then
			return v1.ZeroText
		end
		return (v5 > 0 and string.format("%." .. v5 .. "f", arg1) or tostring(math.floor(arg1 + 0.5))) .. (v1.Suffix or "")
	end

	local function func1(arg1, arg2)
		local v1 = v4 - v3 == 0 and 0 or (arg1 - v3) / (v4 - v3)
		local v2 = arg2 and tweenInfo1 or TweenInfo.new(0)
		local tbl = {Size = UDim2.fromScale(v1, 1)}
		TweenService:Create(v12, v2 or tweenInfo, tbl):Play()
		local tbl1 = {Position = UDim2.new(v1, 0, 0.5, 0)}
		TweenService:Create(v13, v2 or tweenInfo, tbl1):Play()
		v10.Text = func(arg1)
	end

	local connection = v10.Focused:Connect(function()
		v10.Text = tostring(math.floor(v6 * 10 ^ v5 + 0.5) / 10 ^ v5)
		v10.TextColor3 = tbl.TextBright
	end)

	table.insert(tbl6.Connections, connection)

	local connection1 = v10.FocusLost:Connect(function(enterPressed)
		v10.TextColor3 = tbl.TextDim
		if enterPressed then
			local num = tonumber(v10.Text)
			if num then
				tbl1:Set(num)
			else
				func1(v6, false)
			end
		else
			func1(v6, false)
		end
	end)

	table.insert(tbl6.Connections, connection1)

	function tbl1:Set(arg2, arg3)
		local v7 = math.clamp(arg2, v3, v4)
		local v8 = v7

		if v1.Step then
			local floor = math.floor
			local v9 = v7 - v3
			v8 = v3 + floor(v9 / v1.Step + 0.5) * v1.Step
		end

		if v5 == 0 then
			v8 = math.floor(v8 + 0.5)
		end

		v6 = v8
		tbl1.Value = v8

		if v2 then
			tbl6.Flags[v2] = v8
			tbl6:MarkDirty(v2)
		end

		func1(v8, true)

		if not arg3 then
			tbl6:SafeCallback(v1.Text or "slider", v1.Callback, v8)
		end
	end

	local flag
	local connection3
	local connection4

	local function func2(arg1)
		local v1 = math.clamp((arg1 - v11.AbsolutePosition.X) / math.max(v11.AbsoluteSize.X, 1), 0, 1)
		tbl1:Set(v3 + (v4 - v3) * v1)
	end

	local connection2 = v14.InputBegan:Connect(function(input)
		if tbl1.Enabled == false then
			return
		end

		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		flag = true
		local tbl = {Size = UDim2.fromOffset(11, 11)}
		TweenService:Create(v13, tweenInfo1 or tweenInfo, tbl):Play()
		func2(input.Position.X)

		connection3 = UserInputService.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				if flag then
					func2(input.Position.X)
				end
			end
		end)

		connection4 = UserInputService.InputEnded:Connect(function(input1)
			if input1.UserInputType == input.UserInputType then
				flag = false
				local tbl = {Size = UDim2.fromOffset(9, 9)}
				TweenService:Create(v13, tweenInfo1 or tweenInfo, tbl):Play()

				if connection3 then
					connection3:Disconnect()
					connection3 = nil
				end

				if connection4 then
					connection4:Disconnect()
					connection4 = nil
				end
			end
		end)
	end)

	table.insert(tbl6.Connections, connection2)
	func23(tbl1, {v9, v10}, v1)

	if v2 then
		tbl6.Flags[v2] = v6
		tbl6:Register(v2, {
			Type = "Slider",
			Get = function()
				return v6
			end,
			Set = function(arg1)
				tbl1:Set(tonumber(arg1) or v3)
			end,
		})
	end

	func1(v6, false)
	return tbl1
end

function tbl8.RangeSlider(arg1, arg2)
	local v1 = arg2 or {}
	local v2 = func25(v1)
	local v3 = v1.Min or 0
	local v4 = v1.Max or 100
	local v5 = v1.Decimals or 0
	local v6 = type(v1.Default) == "table" and v1.Default or {}
	local v7 = math.clamp(v6[1] or v6.Min or v1.DefaultMin or v3, v3, v4)
	local v8 = math.clamp(v6[2] or v6.Max or v1.DefaultMax or v4, v3, v4)

	if v7 > v8 then
		v8, v7 = v7, v8
	end

	local v9 = v7
	local v10 = v8
	local v11 = func8("Frame", {Size = UDim2.new(1, 0, 0, 30), BackgroundTransparency = 1, Parent = arg1.Container})
	local v12 = func8("Frame", {Size = UDim2.new(1, 0, 0, 16), BackgroundTransparency = 1, Parent = v11})
	func12(v12, 8, Enum.FillDirection.Horizontal).VerticalAlignment = Enum.VerticalAlignment.Center
	local v13 = func13(v12, v1.Text or "range", (func24(v1, tbl.Text)))
	v13.Size = UDim2.fromOffset(0, 16)
	v13.AutomaticSize = Enum.AutomaticSize.X
	local v14 = func13(v12, "", tbl.TextDim, 12)
	v14.Size = UDim2.fromOffset(0, 16)
	v14.AutomaticSize = Enum.AutomaticSize.X
	v14.LayoutOrder = 2
	tbl6:Tag(v14, {TextColor3 = "TextDim"})

	local v15 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 4),
		Position = UDim2.new(0, 0, 0, 24),
		BackgroundColor3 = tbl.Track,
		BorderSizePixel = 0,
		Parent = v11,
		ThemeTag = {BackgroundColor3 = "Track"},
	})

	func9(v15, 2)

	local v16 = func8("Frame", {
		Size = UDim2.fromScale(0, 1),
		BackgroundColor3 = tbl.Accent,
		BorderSizePixel = 0,
		Parent = v15,
		ThemeTag = {BackgroundColor3 = "Accent"},
	})

	func9(v16, 2)

	local function func()
		local v1 = func8("Frame", {
			Size = UDim2.fromOffset(9, 9),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0, 0.5),
			BackgroundColor3 = tbl.Accent,
			BorderSizePixel = 0,
			ZIndex = 2,
			Parent = v15,
			ThemeTag = {BackgroundColor3 = "Accent"},
		})

		func9(v1, 5)
		return v1
	end

	local v17 = func()
	local v18 = func()

	local v19 = func8("TextButton", {
		Size = UDim2.new(1, 0, 0, 15),
		Position = UDim2.new(0, 0, 0, 16),
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Text = "",
		Parent = v11,
	})

	local tbl1 = {Instance = v11, Value = {v7, v8}}

	local function func1(arg1)
		return (v5 > 0 and string.format("%." .. v5 .. "f", arg1) or tostring(math.floor(arg1 + 0.5))) .. (v1.Suffix or "")
	end

	local function func2(arg1)
		local v2 = math.clamp(arg1, v3, v4)
		local v6 = v2

		if v1.Step then
			local floor = math.floor
			local v7 = v2 - v3
			v6 = v3 + floor(v7 / v1.Step + 0.5) * v1.Step
		end

		if v5 == 0 then
			return math.floor(v6 + 0.5)
		end

		local v8 = 10 ^ v5
		return math.floor(v6 * v8 + 0.5) / v8
	end

	local function func3(arg1)
		local v1 = v4 - v3 == 0 and 1 or v4 - v3
		local v2 = (v7 - v3) / v1
		local v5 = (v8 - v3) / v1
		local v6 = arg1 and tweenInfo1 or TweenInfo.new(0)
		local tbl = {Position = UDim2.fromScale(v2, 0), Size = UDim2.fromScale(v5 - v2, 1)}
		TweenService:Create(v16, v6 or tweenInfo, tbl):Play()
		local tbl1 = {Position = UDim2.new(v2, 0, 0.5, 0)}
		TweenService:Create(v17, v6 or tweenInfo, tbl1):Play()
		local tbl2 = {Position = UDim2.new(v5, 0, 0.5, 0)}
		TweenService:Create(v18, v6 or tweenInfo, tbl2):Play()
		v14.Text = func1(v7) .. " - " .. func1(v8)
	end

	local function func4(arg1, arg2, arg3)
		local v5 = func2(tonumber(arg1) or v3)
		local v6 = v5
		local v9 = func2(tonumber(arg2) or v4)
		local v10 = v9

		if v5 > v9 then
			v10 = v5
			v6 = v9
		end

		local v11 = v6 ~= v7 or v10 ~= v8
		v7 = v6
		v8 = v10
		tbl1.Value = {v7, v8}

		if v2 then
			tbl6.Flags[v2] = {v7, v8}
			if v11 then
				tbl6:MarkDirty(v2)
			end
		end

		func3(true)

		if v11 and not arg3 then
			tbl6:SafeCallback(v1.Text or "range", v1.Callback, v7, v8)
		end
	end

	function tbl1:Set(arg2, arg3)
		if type(arg2) == "table" then
			func4(arg2[1] or arg2.Min, arg2[2] or arg2.Max, arg3)
		end
		return self
	end

	function tbl1.SetRange(arg1, arg2, arg3, arg4)
		func4(arg2, arg3, arg4)
		return arg1
	end

	function tbl1.Get(_)
		return v7, v8
	end

	local v20
	local connection1
	local connection2

	local function func5(arg1)
		local v1 = math.clamp((arg1 - v15.AbsolutePosition.X) / math.max(v15.AbsoluteSize.X, 1), 0, 1)
		return v3 + (v4 - v3) * v1
	end

	local function func6(arg1)
		local v1 = func2((func5(arg1)))
		if v20 == "lo" then
			local v2 = v8
			func4(math.min(v1, v2), v2)
		else
			func4(v7, math.max(v1, v7))
		end
	end

	local connection = v19.InputBegan:Connect(function(input)
		if tbl1.Enabled == false then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseButton2 then
			func4(v9, v10)
			return
		end

		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		local v1 = func5(input.Position.X)

		if v7 == v8 then
			v20 = v1 < v7 and "lo" or "hi"
		else
			v20 = math.abs(v1 - v7) <= math.abs(v1 - v8) and "lo" or "hi"
		end

		local v2 = v20 == "lo" and v17 or v18
		local tbl = {Size = UDim2.fromOffset(11, 11)}
		TweenService:Create(v2, tweenInfo1 or tweenInfo, tbl):Play()
		func6(input.Position.X)

		connection1 = UserInputService.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				if v20 then
					func6(input.Position.X)
				end
			end
		end)

		connection2 = UserInputService.InputEnded:Connect(function(input1)
			if input1.UserInputType == input.UserInputType then
				v20 = nil
				local tbl = {Size = UDim2.fromOffset(9, 9)}
				TweenService:Create(v17, tweenInfo1 or tweenInfo, tbl):Play()
				local tbl1 = {Size = UDim2.fromOffset(9, 9)}
				TweenService:Create(v18, tweenInfo1 or tweenInfo, tbl1):Play()

				if connection1 then
					connection1:Disconnect()
					connection1 = nil
				end

				if connection2 then
					connection2:Disconnect()
					connection2 = nil
				end
			end
		end)
	end)

	table.insert(tbl6.Connections, connection)
	func23(tbl1, {v13, v14}, v1)

	if v2 then
		tbl6.Flags[v2] = {v7, v8}
		tbl6:Register(v2, {
			Type = "RangeSlider",
			Get = function()
				return {v7, v8}
			end,
			Set = function(arg1)
				if type(arg1) == "table" then
					func4(arg1[1] or arg1.Min, arg1[2] or arg1.Max)
				end
			end,
		})
	end

	func3(false)
	return tbl1
end

function func30(arg1, arg2, arg3)
	local v1 = arg3 or {}
	local v2 = func25(v1)
	local v3 = v1.Alpha ~= false
	local v4 = v1.Default or Color3.fromRGB(255, 255, 255)
	local v5 = v1.DefaultAlpha or 1
	local v6, v7, v8 = v4:ToHSV()
	local v9 = v6
	local v10 = v7
	local v11 = v8
	local Floating = arg1.Window:CreateFloating(198, false, arg1.Float)
	local ZIndex = Floating.Frame.ZIndex

	local v12 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 106),
		BackgroundTransparency = 1,
		ZIndex = ZIndex,
		Parent = Floating.Content,
	})

	local v13 = func8("TextButton", {
		Size = UDim2.new(1, -22, 1, 0),
		BackgroundColor3 = Color3.fromHSV(v9, 1, 1),
		AutoButtonColor = false,
		Text = "",
		BorderSizePixel = 0,
		ZIndex = ZIndex,
		Parent = v12,
	})

	func9(v13, 4)

	local v14 = func8("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		ZIndex = ZIndex,
		Parent = v13,
	})

	func9(v14, 4)

	func8("UIGradient", {
		Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)}),
		Parent = v14,
	})

	local v15 = func8("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		ThemeTag = {BackgroundColor3 = false},
		BorderSizePixel = 0,
		ZIndex = ZIndex,
		Parent = v13,
	})

	func9(v15, 4)

	func8("UIGradient", {
		Rotation = 90,
		Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)}),
		Parent = v15,
	})

	local v16 = func8("Frame", {
		Size = UDim2.fromOffset(10, 10),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		ZIndex = ZIndex + 1,
		Parent = v13,
	})

	func9(v16, 5)
	func10(v16, Color3.fromRGB(255, 255, 255), 2)

	local v17 = func8("TextButton", {
		Size = UDim2.new(0, 14, 1, 0),
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.fromScale(1, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		AutoButtonColor = false,
		Text = "",
		BorderSizePixel = 0,
		ZIndex = ZIndex,
		Parent = v12,
	})

	func9(v17, 4)
	func8("UIGradient", {Rotation = 90, Color = colorSequence, Parent = v17})

	local v18 = func8("Frame", {
		Size = UDim2.new(1, 4, 0, 3),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		ZIndex = ZIndex + 1,
		Parent = v17,
	})

	func9(v18, 2)
	local v20
	local v22
	local v21

	if v3 then
		local v19 = func8("Frame", {
			Size = UDim2.new(1, 0, 0, 10),
			BackgroundColor3 = tbl.Track,
			BorderSizePixel = 0,
			LayoutOrder = 2,
			ZIndex = ZIndex,
			Parent = Floating.Content,
			ThemeTag = {BackgroundColor3 = "Track"},
		})

		func9(v19, 3)

		v20 = func8("TextButton", {
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = v4,
			AutoButtonColor = false,
			Text = "",
			BorderSizePixel = 0,
			ZIndex = ZIndex,
			Parent = v19,
		})

		func9(v20, 3)

		v21 = func8("UIGradient", {
			Color = ColorSequence.new(v4),
			Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)}),
			Parent = v20,
		})

		v22 = func8("Frame", {
			Size = UDim2.new(0, 3, 1, 4),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(1, 0, 0.5, 0),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BorderSizePixel = 0,
			ZIndex = ZIndex + 1,
			Parent = v20,
		})

		func9(v22, 2)
	end

	local v23 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 24),
		BackgroundColor3 = tbl.Field,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		LayoutOrder = 3,
		ZIndex = ZIndex,
		Parent = Floating.Content,
		ThemeTag = {BackgroundColor3 = "Field"},
	})

	func9(v23, 4)
	local v24 = func10(v23, tbl.Border)

	local v25 = func8("TextBox", {
		Size = UDim2.new(1, -16, 1, 0),
		Position = UDim2.fromOffset(8, 0),
		BackgroundTransparency = 1,
		Text = func19(v4, v5),
		TextColor3 = tbl.TextBright,
		TextSize = 12,
		Font = tbl.Font,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = false,
		ZIndex = ZIndex,
		Parent = v23,
		ThemeTag = {TextColor3 = "TextBright"},
	})

	local tbl1 = {Instance = arg2, Swatch = arg2, Color = v4, Alpha = v5}
	local flag = false

	local function func()
		local v1 = Color3.fromHSV(v9, v10, v11)
		tbl1.Color = v1
		tbl1.Alpha = v5
		v13.BackgroundColor3 = Color3.fromHSV(v9, 1, 1)
		v16.Position = UDim2.fromScale(v10, 1 - v11)
		v18.Position = UDim2.new(0.5, 0, v9, 0)
		arg2.BackgroundColor3 = v1
		arg2.BackgroundTransparency = v3 and (1 - v5) * 0.75 or 0

		if v21 then
			v21.Color = ColorSequence.new(v1)
			v22.Position = UDim2.new(v5, 0, 0.5, 0)
		end

		if not flag then
			v25.Text = func19(v1, v5)
		end

		if v2 then
			tbl6.Flags[v2] = func19(v1, v5)
			tbl6:MarkDirty(v2)
		end
	end

	local function func1()
		tbl6:SafeCallback(v1.Text or "color picker", v1.Callback, Color3.fromHSV(v9, v10, v11), v5)
	end

	function tbl1:Set(arg2, arg3, arg4)
		local v1 = arg2
		local v2 = arg3
		local v3, v4 = func20(arg2)

		if v3 then
			v1 = v3
			v2 = arg3 or v4
		end

		if typeof(v1) == "Color3" then
			local v6, v7, v8 = v1:ToHSV()
			v9 = v6
			v10 = v7
			v11 = v8
		end

		if v2 then
			v5 = math.clamp(v2, 0, 1)
		end

		func()

		if not arg4 then
			func1()
		end
	end

	function tbl1.Get(_)
		return Color3.fromHSV(v9, v10, v11), v5
	end

	func18(v13, function(arg1)
		v10 = math.clamp((arg1.X - v13.AbsolutePosition.X) / math.max(v13.AbsoluteSize.X, 1), 0, 1)
		v11 = 1 - math.clamp((arg1.Y - v13.AbsolutePosition.Y) / math.max(v13.AbsoluteSize.Y, 1), 0, 1)
		func()
		func1()
	end)

	func18(v17, function(arg1)
		v9 = math.clamp((arg1.Y - v17.AbsolutePosition.Y) / math.max(v17.AbsoluteSize.Y, 1), 0, 1)
		func()
		func1()
	end)

	if v20 then
		func18(v20, function(arg1)
			v5 = math.clamp((arg1.X - v20.AbsolutePosition.X) / math.max(v20.AbsoluteSize.X, 1), 0, 1)
			func()
			func1()
		end)
	end

	local connection = v25.Focused:Connect(function()
		flag = true
		TweenService:Create(v24, tweenInfo1 or tweenInfo, {Color = tbl.Accent}):Play()
	end)

	table.insert(tbl6.Connections, connection)

	local connection1 = v25.FocusLost:Connect(function()
		flag = false
		TweenService:Create(v24, tweenInfo1 or tweenInfo, {Color = tbl.Border}):Play()
		local v1, v2 = func20(v25.Text)

		if v1 then
			tbl1:Set(v1, v2)
		else
			func()
		end
	end)

	table.insert(tbl6.Connections, connection1)

	local connection2 = arg2.Activated:Connect(function()
		if tbl1.Enabled == false then
			return
		end
		arg1.Window:ToggleFloating(Floating, arg2)
	end)

	table.insert(tbl6.Connections, connection2)
	func23(tbl1, {}, v1)
	tbl6:OnRepaint(func)

	if v2 then
		tbl6.Flags[v2] = func19(v4, v5)
		tbl6:Register(v2, {
			Type = "ColorPicker",
			Get = function()
				return func19(Color3.fromHSV(v9, v10, v11), v5)
			end,
			Set = function(arg1)
				tbl1:Set(arg1)
			end,
		})
	end

	func()
	return tbl1
end

function func31(_, arg2)
	local v1 = func8("TextButton", arg2)
	func9(v1, 3)
	func10(v1, tbl.Border)
	return v1
end

function tbl8.ColorPicker(arg1, arg2)
	local v1 = arg2 or {}
	local v2 = func8("Frame", {Size = UDim2.new(1, 0, 0, 22), BackgroundTransparency = 1, Parent = arg1.Container})
	func13(v2, v1.Text or "color", (func24(v1, tbl.Text))).Size = UDim2.new(1, -36, 1, 0)

	local v3 = func31(v2, {
		Size = UDim2.fromOffset(28, 14),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, 0, 0.5, 0),
		BackgroundColor3 = v1.Default or Color3.fromRGB(255, 255, 255),
		AutoButtonColor = false,
		Text = "",
		BorderSizePixel = 0,
		Parent = v2,
	})

	local v4 = func30(arg1, v3, v1)
	v4.Instance = v2
	return v4
end

function tbl8.Keybind(arg1, arg2)
	local v1 = arg2 or {}
	local v2 = func25(v1)
	local Default = v1.Default
	local v3 = func8("Frame", {Size = UDim2.new(1, 0, 0, 22), BackgroundTransparency = 1, Parent = arg1.Container})
	local v4 = func13(v3, v1.Text or "keybind", (func24(v1, tbl.Text)))
	v4.Size = UDim2.new(1, -80, 1, 0)

	local v5 = func8("TextButton", {
		Size = UDim2.new(0, 0, 0, 20),
		AutomaticSize = Enum.AutomaticSize.X,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, 0, 0.5, 0),
		BackgroundColor3 = tbl.Field,
		AutoButtonColor = false,
		Text = "",
		BorderSizePixel = 0,
		Parent = v3,
		ThemeTag = {BackgroundColor3 = "Field"},
	})

	func9(v5, 4)
	func10(v5, tbl.Border)
	func11(v5, 0, 8)
	local v6 = func13(v5, "", tbl.TextDim, 12)
	v6.Size = UDim2.new(0, 0, 1, 0)
	v6.AutomaticSize = Enum.AutomaticSize.X
	local tbl1
	local flag = false
	local flag1 = false
	local v7 = v1.Default == true
	local v8 = string.lower(v1.Mode or "press") == "toggle"

	local function func()
		if flag then
			v6.Text = 'key: <font color="' .. func3() .. '">...</font>'
		elseif Default then
			v6.Text = 'key: <font color="' .. func3() .. '">' .. Default .. "</font>"
		else
			v6.Text = "key: NONE"
		end
	end

	func()

	local function func1()
		if v2 then
			tbl6.Flags[v2] = Default or ""
			tbl6:MarkDirty(v2)
		end

		tbl6:RefreshHotkeys()
		tbl6:SafeCallback(v1.Text or "keybind", v1.OnChanged, Default)
	end

	local connection = v5.Activated:Connect(function()
		if tbl1 and tbl1.Enabled == false then
			return
		end

		flag = true
		tbl6.Binding = true
		func()
		TweenService:Create(v5, tweenInfo1 or tweenInfo, {BackgroundColor3 = tbl.FieldHover}):Play()
	end)

	table.insert(tbl6.Connections, connection)

	local connection1 = v5.MouseButton2Click:Connect(function()
		Default = nil
		flag = false
		tbl6.Binding = false
		func()
		func1()
	end)

	table.insert(tbl6.Connections, connection1)

	local connection2 = UserInputService.InputBegan:Connect(function(input, gameProcessed)
		local v2 = func16(input)

		if flag then
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				flag = false
				tbl6.Binding = false
				func()
				TweenService:Create(v5, tweenInfo1 or tweenInfo, {BackgroundColor3 = tbl.Field}):Play()
				return
			end

			if input.KeyCode == Enum.KeyCode.Escape then
				Default = nil
			elseif v2 then
				Default = v2
			else
				return
			end

			flag = false
			tbl6.Binding = false
			func()
			TweenService:Create(v5, tweenInfo1 or tweenInfo, {BackgroundColor3 = tbl.Field}):Play()
			func1()
			return
		end

		if gameProcessed or not Default or v2 ~= Default then
			return
		end

		if tbl1 and tbl1.Enabled == false then
			return
		end

		if v8 then
			v7 = not v7

			if tbl1 then
				tbl1.Active = v7
			end

			tbl6:RefreshHotkeys()
			tbl6:SafeCallback(v1.Text or "keybind", v1.Callback, v7)
		else
			flag1 = true
			tbl6:RefreshHotkeys()
			tbl6:SafeCallback(v1.Text or "keybind", v1.Callback, true)
		end
	end)

	table.insert(tbl6.Connections, connection2)

	local connection3 = UserInputService.InputEnded:Connect(function(input)
		if v8 or not flag1 then
			return
		end
		if Default and func16(input) == Default then
			flag1 = false
			tbl6:RefreshHotkeys()
			tbl6:SafeCallback(v1.Text or "keybind", v1.Callback, false)
		end
	end)

	table.insert(tbl6.Connections, connection3)

	tbl1 = {
		Instance = v3,
		Active = v7,
		Get = function()
			return Default or ""
		end,
		Set = function(_, arg2)
			Default = arg2 ~= "" and arg2 or nil
			func()
			func1()
		end,
	}

	func23(tbl1, {v4, v6}, v1)

	tbl6:RegisterHotkey(function()
		return {
			Label = v1.Text or "keybind",
			Key = Default,
			Active = v8 and v7 or flag1,
			Visible = Default ~= nil and (v8 or flag1),
		}
	end)

	tbl6:OnRepaint(func)

	if v2 then
		tbl6.Flags[v2] = Default or ""
		tbl6:Register(v2, {
			Type = "Keybind",
			Get = function()
				return Default or ""
			end,
			Set = function(arg1)
				tbl1:Set(arg1)
			end,
		})
	end

	if Default then
		func1()
	end

	return tbl1
end

function tbl8.Search(arg1, arg2)
	local v1 = arg2 or {}
	local v2 = v1.Flag or nil
	local v3 = func8("Frame", {Size = UDim2.new(1, 0, 0, 26), BackgroundTransparency = 1, Parent = arg1.Container})

	local v4 = func8("Frame", {
		Size = UDim2.new(1, -56, 1, 0),
		BackgroundColor3 = tbl.Field,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Parent = v3,
		ThemeTag = {BackgroundColor3 = "Field"},
	})

	func9(v4, 5)
	local v5 = func10(v4, tbl.Border)

	local v6 = func8("TextBox", {
		Size = UDim2.new(1, -20, 1, 0),
		Position = UDim2.fromOffset(10, 0),
		BackgroundTransparency = 1,
		Text = v1.Default or "",
		PlaceholderText = v1.Placeholder or "",
		PlaceholderColor3 = tbl.TextDim,
		TextColor3 = tbl.TextBright,
		TextSize = tbl.TextSize,
		Font = tbl.Font,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = false,
		Parent = v4,
		ThemeTag = {PlaceholderColor3 = "TextDim", TextColor3 = "TextBright"},
	})

	local v7 = func13(v3, v1.Label or "search", tbl.TextDim)
	v7.AnchorPoint = Vector2.new(1, 0.5)
	v7.Position = UDim2.new(1, 0, 0.5, 0)
	v7.Size = UDim2.fromOffset(48, 18)
	v7.TextXAlignment = Enum.TextXAlignment.Right

	local connection = v6.Focused:Connect(function()
		TweenService:Create(v5, tweenInfo1 or tweenInfo, {Color = tbl.Accent}):Play()
	end)

	table.insert(tbl6.Connections, connection)

	local connection1 = v6.FocusLost:Connect(function(enterPressed)
		TweenService:Create(v5, tweenInfo1 or tweenInfo, {Color = tbl.Border}):Play()
		tbl6:SafeCallback(v1.Text or "input", v1.Callback, v6.Text, enterPressed)
	end)

	table.insert(tbl6.Connections, connection1)

	if v1.Live then
		local connection2 = v6:GetPropertyChangedSignal("Text"):Connect(function()
			tbl6:SafeCallback(v1.Text or "search", v1.Callback, v6.Text, false)
		end)
		table.insert(tbl6.Connections, connection2)
	end

	local v8 = func23({
		Instance = v3,
		Box = v6,
		Get = function()
			return v6.Text
		end,
		Set = function(_, arg2)
			v6.Text = tostring(arg2 or "")
		end,
	}, {v6, v7}, v1)

	if v2 then
		tbl6.Flags[v2] = v6.Text
		tbl6:Register(v2, {
			Type = "Input",
			Get = function()
				return v6.Text
			end,
			Set = function(arg1)
				v6.Text = tostring(arg1 or "")
				tbl6:SafeCallback(v1.Text or "search", v1.Callback, v6.Text, false)
			end,
		})
	end

	return v8
end

local str = "Button"

local tbl10 = {
	"Toggle",
	"Slider",
	"RangeSlider",
	"Dropdown",
	"Input",
	"Button",
	"Keybind",
	"ColorPicker",
	"Paragraph",
	"Label",
}

local function func32(arg1, arg2, arg3)
	local v1 = arg1 and arg1.Window
	local v2 = v1 and v1.SearchIndex

	if not v2 or type(arg2) ~= "string" or arg2 == "" or typeof(arg3) ~= "Instance" then
		return
	end

	table.insert(v2, {Title = arg2, Instance = arg3, Section = arg1.Title})
end

for _, v2 in ipairs(tbl10) do
	str = tbl8[v2]
	if str then
		tbl8[v2] = function(arg1, arg2, ...)
			local v1 = str(arg1, arg2, ...)
			local v2

			if type(arg2) == "string" then
				v2 = arg2
			elseif type(arg2) == "table" then
				v2 = arg2.Text or arg2.Title
			end

			if type(v1) == "table" then
				pcall(func32, arg1, v2, v1.Instance)
			end

			return v1
		end
	end
end

local ButtonRow = tbl8.ButtonRow

function tbl8:ButtonRow(arg2)
	local v1 = ButtonRow(self, arg2)

	for i, v2 in ipairs(arg2 or {}) do
		if type(v2) == "table" and v1.Buttons and v1.Buttons[i] then
			pcall(func32, self, v2.Text, v1.Buttons[i])
		end
	end

	return v1
end

local v3 = setmetatable({}, {__index = tbl8})
v3.__index = v3

local function func33(arg1, arg2, title, arg4)
	local v1 = tbl6.SectionTitleStyle == "border"

	local v2 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = tbl.Section,
		BorderSizePixel = 0,
		LayoutOrder = arg4,
		Parent = arg2,
		ThemeTag = {BackgroundColor3 = "Section"},
	})

	func9(v2, 7)
	func10(v2, tbl.SectionBorder)

	local v4 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = v2,
	})

	func11(v4, v1 and 18 or 12, 14, 14, 14)
	func12(v4, 0)
	local v5, v7, v8

	if v1 then
		v5 = func8("TextButton", {
			Size = UDim2.fromOffset(0, 16),
			AutomaticSize = Enum.AutomaticSize.X,
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.fromOffset(12, 0),
			BackgroundTransparency = 1,
			AutoButtonColor = false,
			Text = "",
			ZIndex = 3,
			Parent = v2,
		})

		func11(v5, 0, 6, 0, 6)

		func8("Frame", {
			Size = UDim2.new(1, 0, 0, 3),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			BackgroundColor3 = tbl.Window,
			BorderSizePixel = 0,
			ZIndex = 2,
			Parent = v5,
			ThemeTag = {BackgroundColor3 = "Window"},
		})

		local tbl1 = {Size = UDim2.new(0, 0, 1, 0)}
		tbl1.AutomaticSize = Enum.AutomaticSize.X
		tbl1.BackgroundTransparency = 1
		tbl1.ZIndex = 3
		tbl1.Parent = v5
		local v6 = func8("Frame", tbl1)
		func12(v6, 5, Enum.FillDirection.Horizontal).VerticalAlignment = Enum.VerticalAlignment.Center
		v7 = func13(v6, title, tbl.TextBright, tbl.TextSize, tbl.FontMedium)
		v7.Size = UDim2.new(0, 0, 1, 0)
		v7.AutomaticSize = Enum.AutomaticSize.X
		v7.ZIndex = 3
		v8 = func15(v6, tbl.TextDim)
		v8.LayoutOrder = 2
		v8.ZIndex = 3
	else
		v5 = func8("TextButton", {
			Size = UDim2.new(1, 0, 0, 22),
			BackgroundTransparency = 1,
			AutoButtonColor = false,
			Text = "",
			Parent = v4,
		})

		v7 = func13(v5, title, tbl.TextBright, tbl.TextSize + 1, tbl.FontMedium)
		v7.Size = UDim2.new(1, -16, 1, 0)
		v8 = func15(v5, tbl.TextDim)
		v8.AnchorPoint = Vector2.new(0, 0.5)
		v8.Position = UDim2.new(0, v7.TextBounds.X + 6, 0.5, 1)

		local connection = v7:GetPropertyChangedSignal("TextBounds"):Connect(function()
			v8.Position = UDim2.new(0, v7.TextBounds.X + 6, 0.5, 1)
		end)

		table.insert(tbl6.Connections, connection)
	end

	local v9 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		ClipsDescendants = false,
		LayoutOrder = 2,
		Parent = v4,
	})

	local v10 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = v9,
	})

	func12(v10, 9)
	func11(v10, 6, 0, 0, 0)
	local tbl2 = {Window = arg1, Container = v10}
	tbl2.Float = nil
	local v11 = setmetatable(setmetatable(tbl2, tbl8), v3)
	v11.Frame = v2
	v11.Open = true
	v11.Title = title

	local connection1 = v5.Activated:Connect(function()
		v11.Open = not v11.Open
		v9.ClipsDescendants = true

		if v11.Open then
			v9.Visible = true
			v9.Size = UDim2.new(1, 0, 0, 0)
			local v1 = v10.AbsoluteSize.Y / arg1.Scale.Scale

			func14(v9, {Size = UDim2.new(1, 0, 0, v1)}).Completed:Once(function()
				if v11.Open then
					v9.AutomaticSize = Enum.AutomaticSize.Y
					v9.ClipsDescendants = false
				end
			end)

			func14(v8, {Rotation = 0}, tweenInfo1)
		else
			local v2 = v9.AbsoluteSize.Y / arg1.Scale.Scale
			v9.AutomaticSize = Enum.AutomaticSize.None
			v9.Size = UDim2.new(1, 0, 0, v2)

			func14(v9, {Size = UDim2.new(1, 0, 0, 0)}).Completed:Once(function()
				if not v11.Open then
					v9.Visible = false
				end
			end)

			func14(v8, {Rotation = 180}, tweenInfo1)
		end

		arg1:CloseFloating()
	end)

	table.insert(tbl6.Connections, connection1)

	local connection2 = v5.MouseEnter:Connect(function()
		func14(v7, {TextColor3 = tbl.AccentSoft}, tweenInfo1)
	end)

	table.insert(tbl6.Connections, connection2)

	local connection3 = v5.MouseLeave:Connect(function()
		func14(v7, {TextColor3 = tbl.TextBright}, tweenInfo1)
	end)

	table.insert(tbl6.Connections, connection3)
	return v11
end

local tbl11 = {}
tbl11.__index = tbl11

function tbl11:Section(arg2)
	self.Order = self.Order + 1
	return (func33(self.Window, self.Frame, arg2, self.Order))
end

local tbl12 = {}
tbl12.__index = tbl12

function tbl12:Block()
	if self.SubTabs then
		return self.SubTabs[1]:Block()
	end

	if self.CurrentBlock then
		return self.CurrentBlock
	end

	self.Order = self.Order + 1
	local tbl = {Size = UDim2.new(1, 0, 0, 0)}
	tbl.AutomaticSize = Enum.AutomaticSize.Y
	tbl.BackgroundTransparency = 1
	tbl.LayoutOrder = self.Order
	tbl.Parent = self.Page
	local v1 = func8("Frame", tbl)
	func12(v1, 14, Enum.FillDirection.Horizontal).SortOrder = Enum.SortOrder.LayoutOrder
	self.Columns = {}

	for i = 1, 2 do
		local v2 = func8("Frame", {
			Size = UDim2.new(0.5, -7, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = i,
			Parent = v1,
		})

		func12(v2, tbl6.SectionTitleStyle == "border" and 22 or 14)
		self.Columns[i] = setmetatable({Window = self.Window, Frame = v2, Order = 0}, tbl11)
	end

	self.CurrentBlock = v1
	return v1
end

function tbl12:Column(arg2)
	if self.SubTabs then
		return self.SubTabs[1]:Column(arg2)
	end

	self:Block()
	local v1 = math.clamp(math.floor(tonumber(arg2) or 1), 1, #self.Columns)
	return self.Columns[v1]
end

function tbl12:Full(arg2)
	if self.SubTabs then
		return self.SubTabs[1]:Full(arg2)
	end

	self.Order = self.Order + 1
	local v1 = func33(self.Window, self.Page, arg2, self.Order)
	self.CurrentBlock = nil
	return v1
end

function tbl12:Section(arg2, arg3)
	if arg3 == "full" or arg3 == "0" or tonumber(arg3) == 0 then
		return self:Full(arg2)
	end
	return self:Column(arg3):Section(arg2)
end

function tbl12:_SubTabHost()
	if self.SubTabs then
		return self.SubTabHost
	end

	local Page = self.Page

	local v1 = func8("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Visible = Page.Visible,
		Parent = Page.Parent,
	})

	local v2 = func8("Frame", {
		Size = UDim2.new(1, -16, 0, 30),
		Position = UDim2.fromOffset(8, 8),
		BackgroundColor3 = tbl.Field,
		Parent = v1,
		ThemeTag = {BackgroundColor3 = "Field"},
	})

	func9(v2, tbl.Radius)

	func8("UIStroke", {
		Color = tbl.Border,
		Thickness = 1,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = v2,
		ThemeTag = {Color = "Border"},
	})

	local v3 = func8("Frame", {
		Size = UDim2.new(0, 0, 1, -6),
		Position = UDim2.fromOffset(3, 3),
		BackgroundColor3 = tbl.Accent,
		BackgroundTransparency = 0.84,
		BorderSizePixel = 0,
		Visible = false,
		Parent = v2,
		ThemeTag = {BackgroundColor3 = "Accent"},
	})

	func9(v3, math.max(tbl.Radius - 2, 2))

	func8("UIStroke", {
		Color = tbl.AccentDim,
		Thickness = 1,
		Transparency = 0.2,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = v3,
		ThemeTag = {Color = "AccentDim"},
	})

	local v4 = func8("Frame", {
		Size = UDim2.new(1, -6, 1, -6),
		Position = UDim2.fromOffset(3, 3),
		BackgroundTransparency = 1,
		ZIndex = 2,
		Parent = v2,
	})

	func12(v4, 0, Enum.FillDirection.Horizontal)
	Page.Visible = true
	Page.Position = UDim2.new()
	Page.Size = UDim2.fromScale(1, 1)

	local v5 = func8("Frame", {
		Size = UDim2.new(1, 0, 1, -46),
		Position = UDim2.fromOffset(0, 46),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Parent = v1,
	})

	Page.Parent = v5
	self.SubTabs = {}
	self.SubTabHost = {Host = v1, Bar = v2, Pill = v3, Row = v4, Slide = v5, Base = Page}
	self.Page = v1
	return self.SubTabHost
end

function tbl12:_LayoutSubTabs(arg2)
	local SubTabHost = self.SubTabHost
	local v1 = #self.SubTabs

	if v1 == 0 then
		return
	end

	for i, subTab in ipairs(self.SubTabs) do
		subTab.Button.Size = UDim2.new(1 / v1, 0, 1, 0)
		subTab.Button.LayoutOrder = i
	end

	local ActiveSubTab = self.ActiveSubTab

	if not ActiveSubTab then
		return
	end

	local v2 = table.find(self.SubTabs, ActiveSubTab) or 1

	local tbl = {
		Position = UDim2.new((v2 - 1) / v1, 3 - 6 * (v2 - 1) / v1, 0, 3),
		Size = UDim2.new(1 / v1, -6 / v1, 1, -6),
	}

	SubTabHost.Pill.Visible = true

	if arg2 then
		TweenService:Create(SubTabHost.Pill, tweenInfo or tweenInfo, tbl):Play()
	else
		SubTabHost.Pill.Position = tbl.Position
		SubTabHost.Pill.Size = tbl.Size
	end
end

function tbl12.SubTab(arg1, arg2, arg3)
	assert(not arg1.IsSubTab, "SubTab: call it on the main tab, not on a sub tab")
	local v1 = type(arg2) == "table" and arg2 or {Title = arg2, Icon = arg3}
	local v2 = v1.Title or v1.Text or "sub"
	local Window = arg1.Window
	local v3 = arg1:_SubTabHost()
	local Base

	if #arg1.SubTabs == 0 then
		Base = v3.Base
	else
		local tbl1 = {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			CanvasSize = UDim2.new(),
		}

		tbl1.AutomaticCanvasSize = Enum.AutomaticSize.Y
		tbl1.ScrollBarThickness = 3
		tbl1.ScrollBarImageColor3 = tbl.AccentDim
		tbl1.ScrollBarImageTransparency = 0.3
		tbl1.VerticalScrollBarInset = Enum.ScrollBarInset.None
		tbl1.Visible = false
		tbl1.Parent = v3.Slide
		tbl1.ThemeTag = {ScrollBarImageColor3 = "AccentDim"}
		Base = func8("ScrollingFrame", tbl1)
		func12(Base, tbl6.SectionTitleStyle == "border" and 22 or 14).SortOrder = Enum.SortOrder.LayoutOrder
		func11(Base, tbl6.SectionTitleStyle == "border" and 12 or 2, 8, 2, 8)

		local connection = Base:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
			Window:CloseFloating()
		end)

		table.insert(tbl6.Connections, connection)
	end

	local v4 = setmetatable(
		{Window = Window, Page = Base, Columns = {}, Name = v2, Order = 0, Parent = arg1, IsSubTab = true},
		tbl12
	)

	if Base == v3.Base then
		v4.Columns = arg1.Columns
		v4.Order = arg1.Order
		v4.CurrentBlock = arg1.CurrentBlock
	end

	local v5 = func8("TextButton", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Text = "",
		Parent = v3.Row,
	})

	local v6 = func8("Frame", {
		Size = UDim2.fromScale(0, 1),
		AutomaticSize = Enum.AutomaticSize.X,
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.fromScale(0.5, 0),
		BackgroundTransparency = 1,
		Parent = v5,
	})

	func12(v6, 6, Enum.FillDirection.Horizontal).VerticalAlignment = Enum.VerticalAlignment.Center
	local v7 = func26(v6, v1.Icon, tbl.TextDim, 14)

	if v7 then
		v7.LayoutOrder = 1
	end

	local v8 = func13(v6, v2, tbl.TextDim, tbl.TextSize)
	v8.Font = tbl.FontMedium or tbl.Font
	v8.Size = UDim2.new(0, 0, 1, 0)
	v8.AutomaticSize = Enum.AutomaticSize.X
	v8.TextTruncate = Enum.TextTruncate.AtEnd
	v8.LayoutOrder = 2
	v4.Button = v5
	v4.Label = v8
	v4.Icon = v7

	function v4:SetActive(arg2, arg3)
		local v1 = arg3 and tweenInfo1 or TweenInfo.new(0)
		local v2 = arg2 and "Accent" or "TextDim"
		tbl6:Tag(v8, {TextColor3 = v2})

		if v7 then
			tbl6:Tag(v7, {ImageColor3 = v2})
		end

		TweenService:Create(v8, v1 or tweenInfo, {TextColor3 = tbl[v2]}):Play()

		if v7 then
			TweenService:Create(v7, v1 or tweenInfo, {ImageColor3 = tbl[v2]}):Play()
		end
	end

	function v4.Select(arg1)
		arg1.Parent:SetSubTab(arg1)
	end

	table.insert(arg1.SubTabs, v4)
	arg1:_LayoutSubTabs(false)

	local connection1 = v5.Activated:Connect(function()
		arg1:SetSubTab(v4)
	end)

	table.insert(tbl6.Connections, connection1)

	local connection2 = v5.MouseEnter:Connect(function()
		if arg1.ActiveSubTab == v4 then
			return
		end

		TweenService:Create(v8, tweenInfo1 or tweenInfo, {TextColor3 = tbl.Text}):Play()

		if v7 then
			TweenService:Create(v7, tweenInfo1 or tweenInfo, {ImageColor3 = tbl.Text}):Play()
		end
	end)

	table.insert(tbl6.Connections, connection2)

	local connection3 = v5.MouseLeave:Connect(function()
		if arg1.ActiveSubTab == v4 then
			return
		end

		TweenService:Create(v8, tweenInfo1 or tweenInfo, {TextColor3 = tbl.TextDim}):Play()

		if v7 then
			TweenService:Create(v7, tweenInfo1 or tweenInfo, {ImageColor3 = tbl.TextDim}):Play()
		end
	end)

	table.insert(tbl6.Connections, connection3)

	if not arg1.ActiveSubTab then
		arg1:SetSubTab(v4, true)
	else
		v4:SetActive(false, false)
	end

	return v4
end

function tbl12:SetSubTab(arg2, arg3)
	local v1 = arg2

	if not self.SubTabs then
		return
	end

	if type(arg2) == "string" then
		for _, subTab in ipairs(self.SubTabs) do
			if subTab.Name == arg2 then
				v1 = subTab
				break
			end
		end
	end

	if type(v1) ~= "table" or v1.Parent ~= self then
		return
	end

	local ActiveSubTab = self.ActiveSubTab

	if ActiveSubTab == v1 then
		return
	end

	self.Window:CloseFloating()
	local v2 = ActiveSubTab and table.find(self.SubTabs, ActiveSubTab)
	local v3 = (table.find(self.SubTabs, v1) or 0) >= (v2 or 0) and 1 or -1

	if ActiveSubTab then
		ActiveSubTab.Page.Visible = false
		ActiveSubTab:SetActive(false, not arg3)
	end

	self.ActiveSubTab = v1
	v1.Page.Visible = true

	if arg3 then
		v1.Page.Position = UDim2.new()
	else
		v1.Page.Position = UDim2.fromOffset(18 * v3, 0)
		func14(v1.Page, {Position = UDim2.new()})
	end

	v1:SetActive(true, not arg3)
	self:_LayoutSubTabs(not arg3)

	if self.OnSubTab then
		tbl6:SafeCallback("subtab", self.OnSubTab, v1.Name)
	end
end

function tbl12:PageFor(arg2)
	if not self.SubTabs then
		return self.Page
	end

	for _, subTab in ipairs(self.SubTabs) do
		if arg2:IsDescendantOf(subTab.Page) then
			self:SetSubTab(subTab, true)
			return subTab.Page
		end
	end

	return self.ActiveSubTab and self.ActiveSubTab.Page or self.Page
end

local tbl13 = {}
tbl13.__index = tbl13

function tbl13:CreateFloating(arg2, arg3, arg4)
	local v1 = arg4 and arg4.Depth + 1 or 1
	local v2 = 118 + v1 * 4

	local v3 = func8("Frame", {
		Size = UDim2.fromOffset(arg2 > 0 and arg2 or 160, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = tbl.PopupBg,
		BorderSizePixel = 0,
		Visible = false,
		Active = true,
		ZIndex = v2,
		Parent = self.Overlay,
		ThemeTag = {BackgroundColor3 = "PopupBg"},
	})

	func9(v3, 5)
	func10(v3, arg3 and tbl.Accent or tbl.PopupBorder)
	func11(v3, 6)

	local v4 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		ZIndex = v2,
		Parent = v3,
	})

	func12(v4, 6)
	return {Frame = v3, Content = v4, MatchAnchor = arg3, Parent = arg4, Depth = v1}
end

function tbl13:CloseFloatingFrom(arg2)
	local FloatStack = self.FloatStack

	while #FloatStack > 0 and FloatStack[#FloatStack].Depth >= arg2 do
		local v1 = table.remove(FloatStack)
		v1.Frame.Visible = false

		if v1.OnClose then
			v1.OnClose()
		end
	end

	self.Blocker.Visible = #FloatStack > 0
end

function tbl13:CloseFloating()
	self:CloseFloatingFrom(1)
end

function tbl13:ToggleFloating(arg2, arg3, arg4)
	for _, v1 in ipairs(self.FloatStack) do
		if v1 == arg2 then
			self:CloseFloatingFrom(arg2.Depth)
			return
		end
	end

	self:CloseFloatingFrom(arg2.Depth)
	local Scale = self.Scale.Scale
	local v2 = (arg3.AbsolutePosition.X - self.Main.AbsolutePosition.X) / Scale
	local v3 = (arg3.AbsolutePosition.Y - self.Main.AbsolutePosition.Y) / Scale
	local v4 = arg3.AbsoluteSize.Y / Scale

	if arg4 then
		arg2.Frame.Size = UDim2.fromOffset(arg3.AbsoluteSize.X / Scale, 0)
	end

	arg2.Frame.Position = UDim2.fromOffset(v2, v3 + v4 + 4)
	arg2.Frame.Visible = true
	table.insert(self.FloatStack, arg2)
	self.Blocker.Visible = true

	if arg2.OnOpen then
		arg2.OnOpen()
	end

	local Position = arg2.Frame.Position
	arg2.Frame.Position = Position - UDim2.fromOffset(0, 4)
	func14(arg2.Frame, {Position = Position}, tweenInfo1)
end

function tbl13.Tab(arg1, arg2, arg3)
	local v1 = type(arg2) == "table" and arg2 or {Title = arg2, Icon = arg3}
	local v2 = v1.Title or v1.Text or "tab"

	local tbl1 = {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		CanvasSize = UDim2.new(),
	}

	tbl1.AutomaticCanvasSize = Enum.AutomaticSize.Y
	tbl1.ScrollBarThickness = 3
	tbl1.ScrollBarImageColor3 = tbl.AccentDim
	tbl1.ScrollBarImageTransparency = 0.3
	tbl1.VerticalScrollBarInset = Enum.ScrollBarInset.None
	tbl1.Visible = false
	tbl1.Parent = arg1.Body
	tbl1.ThemeTag = {ScrollBarImageColor3 = "AccentDim"}
	local v3 = func8("ScrollingFrame", tbl1)
	func12(v3, tbl6.SectionTitleStyle == "border" and 22 or 14).SortOrder = Enum.SortOrder.LayoutOrder
	func11(v3, tbl6.SectionTitleStyle == "border" and 12 or 2, 8, 2, 8)
	local v4 = setmetatable({Window = arg1, Page = v3, Columns = {}, Name = v2, Order = 0}, tbl12)
	local v5 = arg1.TabStyle == "side"

	local v6 = func8("TextButton", {
		Size = v5 and UDim2.new(1, 0, 0, 30) or UDim2.new(0, 0, 1, 0),
		AutomaticSize = not v5 and Enum.AutomaticSize.X or Enum.AutomaticSize.None,
		BackgroundColor3 = tbl.Field,
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Text = "",
		LayoutOrder = arg1:NextTabOrder(),
		Parent = arg1.TabBar,
		ThemeTag = {BackgroundColor3 = "Field"},
	})

	if v5 then
		func9(v6, 5)

		func8("Frame", {
			Size = UDim2.fromOffset(2, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 0, 0.5, 0),
			BackgroundColor3 = tbl.Accent,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Name = "ActiveBar",
			ZIndex = 2,
			Parent = v6,
			ThemeTag = {BackgroundColor3 = "Accent"},
		})

		func9(v6:FindFirstChild("ActiveBar") or v6, 2)
	end

	local v7 = func8("Frame", {
		Size = v5 and UDim2.new(1, -20, 1, 0) or UDim2.new(0, 0, 1, 0),
		Position = v5 and UDim2.fromOffset(10, 0) or UDim2.fromOffset(0, 0),
		AutomaticSize = not v5 and Enum.AutomaticSize.X or Enum.AutomaticSize.None,
		BackgroundTransparency = 1,
		Parent = v6,
	})

	func12(v7, 7, Enum.FillDirection.Horizontal).VerticalAlignment = Enum.VerticalAlignment.Center
	local v8 = func26(v7, v1.Icon, tbl.TextDim, 15)

	if v8 then
		v8.Position = UDim2.fromOffset(0, 0)
		v8.LayoutOrder = 1
	end

	local v9 = func13(v7, v2, tbl.TextDim, tbl.TextSize + 1)
	v9.Size = v5 and UDim2.new(1, v8 and -22 or 0, 1, 0) or UDim2.new(0, 0, 1, 0)
	v9.AutomaticSize = not v5 and Enum.AutomaticSize.X or Enum.AutomaticSize.None
	v9.TextTruncate = Enum.TextTruncate.AtEnd
	v9.LayoutOrder = 2
	v4.Button = v6
	v4.Label = v9
	v4.Icon = v8
	v4.Row = v7

	if v5 and arg1.Collapsed then
		arg1:ApplyCollapsedTab(v4, true)
	end

	local v10 = v5 and v6:FindFirstChild("ActiveBar") or nil

	function v4:SetActive(arg2, arg3)
		local v1 = arg3 and tweenInfo1 or TweenInfo.new(0)
		local v2 = arg2 and "Accent" or "TextDim"
		local v3 = tbl[v2]
		tbl6:Tag(v9, {TextColor3 = v2})

		if v8 then
			tbl6:Tag(v8, {ImageColor3 = v2})
		end

		if v10 then
			tbl6:Tag(v10, {BackgroundColor3 = "Accent"})
		end

		TweenService:Create(v9, v1 or tweenInfo, {TextColor3 = v3}):Play()

		if v8 then
			TweenService:Create(v8, v1 or tweenInfo, {ImageColor3 = v3}):Play()
		end

		if v5 then
			TweenService:Create(v6, v1 or tweenInfo, {BackgroundTransparency = arg2 and 0.85 or 1}):Play()
			if v10 then
				TweenService:Create(v10, v1 or tweenInfo, {BackgroundTransparency = arg2 and 0 or 1}):Play()
			end
		end
	end

	table.insert(arg1.Tabs, v4)

	local connection = v6.Activated:Connect(function()
		arg1:SetTab(v4)
	end)

	table.insert(tbl6.Connections, connection)

	local connection1 = v6.MouseEnter:Connect(function()
		if arg1.ActiveTab == v4 then
			return
		end

		TweenService:Create(v9, tweenInfo1 or tweenInfo, {TextColor3 = tbl.Text}):Play()

		if v8 then
			TweenService:Create(v8, tweenInfo1 or tweenInfo, {ImageColor3 = tbl.Text}):Play()
		end

		if v5 then
			TweenService:Create(v6, tweenInfo1 or tweenInfo, {BackgroundTransparency = 0.55}):Play()
		end
	end)

	table.insert(tbl6.Connections, connection1)

	local connection2 = v6.MouseLeave:Connect(function()
		if arg1.ActiveTab == v4 then
			return
		end

		TweenService:Create(v9, tweenInfo1 or tweenInfo, {TextColor3 = tbl.TextDim}):Play()

		if v8 then
			TweenService:Create(v8, tweenInfo1 or tweenInfo, {ImageColor3 = tbl.TextDim}):Play()
		end

		if v5 then
			TweenService:Create(v6, tweenInfo1 or tweenInfo, {BackgroundTransparency = 1}):Play()
		end
	end)

	table.insert(tbl6.Connections, connection2)

	local connection3 = v3:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
		arg1:CloseFloating()
	end)

	table.insert(tbl6.Connections, connection3)

	if not arg1.ActiveTab then
		arg1:SetTab(v4)
	end

	return v4
end

function tbl13:NextTabOrder()
	self.TabOrder = (self.TabOrder or 0) + 1
	return self.TabOrder
end

function tbl13.TabDivider(arg1, arg2)
	if arg1.TabStyle ~= "side" then
		return nil
	end

	local v1 = arg2 or {}

	local v2 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, v1.Height or 11),
		BackgroundTransparency = 1,
		LayoutOrder = arg1:NextTabOrder(),
		Parent = arg1.TabBar,
	})

	arg1.TabDividers = arg1.TabDividers or {}
	local v3 = v1.Inset or 12

	local v4 = func8("Frame", {
		Size = UDim2.new(1, -v3 * 2, 0, 1),
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, v3, 0.5, 0),
		BackgroundColor3 = tbl.BorderSoft,
		BorderSizePixel = 0,
		Parent = v2,
		ThemeTag = {BackgroundColor3 = "BorderSoft"},
	})

	if v1.Text then
		v2.Size = UDim2.new(1, 0, 0, v1.Height or 24)
		v4:Destroy()
		local v5 = func13(v2, v1.Text, tbl.TextDim, tbl.TextSize - 2)
		v5.Position = UDim2.fromOffset(v3, 0)
		v5.Size = UDim2.new(1, -v3 * 2, 1, 0)
		v5.TextYAlignment = Enum.TextYAlignment.Bottom
		v5.Visible = not arg1.Collapsed
		local tbl1 = {Instance = v2, Label = v5}
		table.insert(arg1.TabDividers, tbl1)
		return tbl1
	end

	return {Instance = v2, Line = v4}
end

function tbl13:SetTab(arg2)
	local v1 = arg2

	if type(arg2) == "string" then
		for _, tab in ipairs(self.Tabs) do
			if tab.Name == arg2 then
				v1 = tab
				break
			end
		end
	end

	if self.ActiveTab == v1 then
		return
	end

	self:CloseFloating()

	if self.ClearSearch then
		self.ClearSearch()
	end

	if self.ActiveTab then
		self.ActiveTab.Page.Visible = false
		self.ActiveTab:SetActive(false, true)
	end

	self.ActiveTab = v1
	v1.Page.Visible = true
	v1.Page.Position = UDim2.fromOffset(0, 6)
	func14(v1.Page, {Position = UDim2.fromOffset(0, 0)})
	v1:SetActive(true, true)
end

function tbl13.Action(arg1, arg2, arg3)
	local v1 = func8("TextButton", {
		Size = UDim2.new(0, 0, 1, 0),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Text = arg2,
		TextColor3 = tbl.Accent,
		TextSize = tbl.TextSize,
		Font = tbl.FontMedium,
		Parent = arg1.Footer,
		ThemeTag = {TextColor3 = "Accent"},
	})

	local connection = v1.MouseEnter:Connect(function()
		TweenService:Create(v1, tweenInfo1 or tweenInfo, {TextColor3 = tbl.AccentSoft}):Play()
	end)

	table.insert(tbl6.Connections, connection)

	local connection1 = v1.MouseLeave:Connect(function()
		TweenService:Create(v1, tweenInfo1 or tweenInfo, {TextColor3 = tbl.Accent}):Play()
	end)

	table.insert(tbl6.Connections, connection1)

	local connection2 = v1.Activated:Connect(function()
		tbl6:SafeCallback("action", arg3)
	end)

	table.insert(tbl6.Connections, connection2)
	return v1
end

function tbl13.SetUserScale(arg1, arg2)
	arg1.UserScale = math.clamp(tonumber(arg2) or 1, 0.6, 1.4)

	if arg1.Refit then
		arg1.Refit()
	end

	return arg1.UserScale
end

function tbl13.SetOpacity(arg1, arg2)
	arg1.Opacity = math.clamp(tonumber(arg2) or 1, 0.2, 1)
	arg1.Main.BackgroundTransparency = 1 - arg1.Opacity
	return arg1.Opacity
end

function tbl13:SetSize(arg2, arg3)
	self.Width = math.max(arg2, self.MinWidth)
	self.Height = math.max(arg3, self.MinHeight)
	self.Main.Size = UDim2.fromOffset(self.Width, self.Height)

	if self.Refit then
		self.Refit()
	end
end

function tbl13.IconAction(arg1, arg2, arg3, arg4)
	if not arg1.FooterLeft then
		return nil
	end

	local v1 = func8("ImageButton", {
		Size = UDim2.fromOffset(18, 18),
		BackgroundTransparency = 1,
		ImageColor3 = tbl.TextDim,
		LayoutOrder = arg4 or 1,
		Parent = arg1.FooterLeft,
		ThemeTag = {ImageColor3 = "TextDim"},
	})

	local v2 = func21(arg2)

	if v2 then
		v1.Image = v2.Image

		if v2.RectOffset then
			v1.ImageRectOffset = v2.RectOffset
		end

		if v2.RectSize then
			v1.ImageRectSize = v2.RectSize
		end
	end

	local connection = v1.MouseEnter:Connect(function()
		TweenService:Create(v1, tweenInfo1 or tweenInfo, {ImageColor3 = tbl.Accent}):Play()
	end)

	table.insert(tbl6.Connections, connection)

	local connection1 = v1.MouseLeave:Connect(function()
		TweenService:Create(v1, tweenInfo1 or tweenInfo, {ImageColor3 = tbl.TextDim}):Play()
	end)

	table.insert(tbl6.Connections, connection1)

	local connection2 = v1.Activated:Connect(function()
		tbl6:SafeCallback("action", arg3)
	end)

	table.insert(tbl6.Connections, connection2)
	return v1
end

function tbl13:Modal(arg2)
	local v1 = arg2 or {}

	local v2 = func8("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Visible = false,
		ZIndex = 200,
		Parent = self.Main,
	})

	local v3 = func8("TextButton", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		ThemeTag = {BackgroundColor3 = false},
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Text = "",
		ZIndex = 200,
		Parent = v2,
	})

	func9(v3, 10)

	local v4 = func8("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = v1.Height and v1.Height > 1 and UDim2.fromOffset(v1.Width or 340, v1.Height) or UDim2.new(0, v1.Width or 340, v1.Height or 0.78, 0),
		BackgroundColor3 = tbl.Window,
		BorderSizePixel = 0,
		Active = true,
		ZIndex = 210,
		Parent = v2,
		ThemeTag = {BackgroundColor3 = "Window"},
	})

	func9(v4, 10)
	func10(v4, tbl.WindowBorder)
	local v5 = func8("UIScale", {Parent = v4})
	local v6 = func8("Frame", {Size = UDim2.new(1, 0, 0, 38), BackgroundTransparency = 1, ZIndex = 210, Parent = v4})
	local v7 = func13(v6, v1.Title or "panel", tbl.TextBright, 14, tbl.FontMedium)
	v7.Position = UDim2.fromOffset(14, 0)
	v7.Size = UDim2.new(1, -48, 1, 0)
	v7.ZIndex = 210

	local v8 = func8("TextButton", {
		Size = UDim2.fromOffset(20, 20),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -12, 0.5, 0),
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Text = "",
		ZIndex = 210,
		Parent = v6,
	})

	local tbl1 = {}

	for i = 1, 2 do
		local v9 = func8("Frame", {
			Size = UDim2.fromOffset(13, 2),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Rotation = i == 1 and 45 or -45,
			BackgroundColor3 = tbl.TextDim,
			BorderSizePixel = 0,
			ZIndex = 210,
			Parent = v8,
			ThemeTag = {BackgroundColor3 = "TextDim"},
		})

		func8("UICorner", {CornerRadius = UDim.new(0, 1), Parent = v9})
		func8("UICorner", {CornerRadius = UDim.new(0, 1), Parent = v9})
		tbl1[i] = v9
	end

	func8("Frame", {
		Size = UDim2.new(1, 0, 0, 1),
		Position = UDim2.new(0, 0, 0, 38),
		BackgroundColor3 = tbl.BorderSoft,
		BorderSizePixel = 0,
		ZIndex = 210,
		Parent = v4,
		ThemeTag = {BackgroundColor3 = "BorderSoft"},
	})

	local tbl2 = {
		Size = UDim2.new(1, -16, 1, -50),
		Position = UDim2.fromOffset(8, 45),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		CanvasSize = UDim2.new(),
	}

	tbl2.AutomaticCanvasSize = Enum.AutomaticSize.Y
	tbl2.ScrollBarThickness = 3
	tbl2.ScrollBarImageColor3 = tbl.AccentDim
	tbl2.VerticalScrollBarInset = Enum.ScrollBarInset.None
	tbl2.ZIndex = 210
	tbl2.Parent = v4
	tbl2.ThemeTag = {ScrollBarImageColor3 = "AccentDim"}
	local v10 = func8("ScrollingFrame", tbl2)
	func12(v10, 9)
	func11(v10, 4, 10, 8, 6)
	local tbl3 = {Root = v2, Frame = v4, Scroller = v10}
	local tbl4 = {Window = self, Container = v10}
	tbl4.Float = nil
	tbl3.Content = setmetatable(tbl4, tbl8)
	tbl3.Open = false

	local function func(arg1)
		if arg1 then
			if tbl3.Blur then
				return
			end
			pcall(function()
				local blurEffect = Instance.new("BlurEffect")
				blurEffect.Name = "FacilityModalBlur"
				blurEffect.Size = 0
				blurEffect.Parent = Lighting
				tbl3.Blur = blurEffect
				func14(blurEffect, {Size = v1.Blur or 16})
			end)
		elseif tbl3.Blur then
			local Blur = tbl3.Blur
			tbl3.Blur = nil

			pcall(function()
				func14(Blur, {Size = 0}).Completed:Once(function()
					Blur:Destroy()
				end)
			end)
		end
	end

	function tbl3:SetOpen(open)
		if open == self.Open then
			return
		end

		self.Open = open

		if open then
			self:CloseFloating()
			v2.Visible = true
			v3.BackgroundTransparency = 1
			v5.Scale = 0.96
			func14(v3, {BackgroundTransparency = v1.Dim or 0.25})
			func14(v5, {Scale = 1})
			func(true)
		else
			self:CloseFloating()
			func14(v3, {BackgroundTransparency = 1})

			func14(v5, {Scale = 0.96}).Completed:Once(function()
				if not tbl3.Open then
					v2.Visible = false
				end
			end)

			func(false)

			if tbl3.OnClose then
				task.spawn(tbl3.OnClose)
			end
		end
	end

	function tbl3:Toggle()
		self:SetOpen(not self.Open)
	end

	local connection = v3.Activated:Connect(function()
		tbl3:SetOpen(false)
	end)

	table.insert(tbl6.Connections, connection)

	local connection1 = v8.Activated:Connect(function()
		tbl3:SetOpen(false)
	end)

	table.insert(tbl6.Connections, connection1)

	local connection2 = v8.MouseEnter:Connect(function()
		for _, v1 in ipairs(tbl1) do
			TweenService:Create(v1, tweenInfo1 or tweenInfo, {BackgroundColor3 = tbl.Danger}):Play()
		end
	end)

	table.insert(tbl6.Connections, connection2)

	local connection3 = v8.MouseLeave:Connect(function()
		for _, v1 in ipairs(tbl1) do
			TweenService:Create(v1, tweenInfo1 or tweenInfo, {BackgroundColor3 = tbl.TextDim}):Play()
		end
	end)

	table.insert(tbl6.Connections, connection3)

	local connection4 = UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed and tbl3.Open and input.KeyCode == Enum.KeyCode.Escape then
			tbl3:SetOpen(false)
		end
	end)

	table.insert(tbl6.Connections, connection4)
	self.Modals = self.Modals or {}
	table.insert(self.Modals, tbl3)
	return tbl3
end

function tbl13.Confirm(arg1, arg2)
	local v1 = arg2 or {}

	local v2 = arg1:Modal({
		Title = v1.Title or "confirm",
		Width = v1.Width or 280,
		Height = v1.Height or 150,
		Dim = v1.Dim or 0.45,
		Blur = v1.Blur or 10,
	})

	v2.Content:Label(v1.Text or "are you sure?", {Style = "text"})
	v2.Scroller.Size = UDim2.new(1, -16, 1, -95)
	local flag = false

	local function func(arg1)
		flag = true
		v2:SetOpen(false)
		tbl6:SafeCallback("action", arg1)
	end

	local v3 = func8("Frame", {
		Size = UDim2.new(1, -24, 0, 30),
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.new(0, 12, 1, -12),
		BackgroundTransparency = 1,
		ZIndex = v2.Frame.ZIndex,
		Parent = v2.Frame,
	})

	local tbl = {Window = arg1, Container = v3}
	tbl.Float = nil

	setmetatable(tbl, tbl8):ButtonRow({
		{
			Text = v1.Confirm or "save",
			Callback = function()
				func(v1.OnConfirm)
			end,
		},
		{
			Text = v1.Cancel or "discard",
			Callback = function()
				func(v1.OnCancel)
			end,
		},
	})

	function v2.OnClose()
		if not flag and v1.OnDismiss then
			task.spawn(v1.OnDismiss)
		end
		flag = false
	end

	v2:SetOpen(true)
	return v2
end

function tbl13:ApplyCollapsedTab(arg2, arg3)
	if not arg2.Row or not arg2.Label then
		return
	end
	if arg3 then
		arg2.Row.Position = UDim2.fromOffset(arg2.Icon and 13 or 0, 0)
		arg2.Row.Size = UDim2.new(1, arg2.Icon and -13 or 0, 1, 0)

		if arg2.Icon then
			arg2.Label.Visible = false
		else
			arg2.Label.Text = string.upper(string.sub(arg2.Name or "?", 1, 1))
			arg2.Label.Size = UDim2.fromScale(1, 1)
			arg2.Label.TextXAlignment = Enum.TextXAlignment.Center
		end
	else
		arg2.Row.Position = UDim2.fromOffset(10, 0)
		arg2.Row.Size = UDim2.new(1, -20, 1, 0)
		arg2.Label.Visible = true
		arg2.Label.Text = arg2.Name
		arg2.Label.Size = UDim2.new(1, arg2.Icon and -22 or 0, 1, 0)
		arg2.Label.TextXAlignment = Enum.TextXAlignment.Left
	end
end

function tbl13:SetCollapsed(arg2)
	if self.TabStyle ~= "side" or not self.SetSidebarWidth then
		return false
	end

	local v1 = arg2 and true or false
	self.Collapsed = v1
	self.SetSidebarWidth(v1 and self.CollapsedWidth or self.TabWidth, true)

	for _, tab in ipairs(self.Tabs) do
		self:ApplyCollapsedTab(tab, v1)
	end

	for _, v2 in ipairs(self.TabDividers or {}) do
		if v2.Label then
			v2.Label.Visible = not v1
		end
	end

	if self.CollapseButton then
		self.CollapseButton.Rotate(v1)
	end

	return v1
end

function tbl13:ToggleCollapsed()
	return self:SetCollapsed(not self.Collapsed)
end

function tbl13:SetVisible(visible)
	self.Visible = visible
	if visible then
		self.Main.Visible = true
		self.Scale.Scale = self.BaseScale * 0.97
		func14(self.Scale, {Scale = self.BaseScale}, tweenInfo1)
	else
		self:CloseFloating()

		for _, v1 in ipairs(self.Modals or {}) do
			v1:SetOpen(false)
		end

		func14(self.Scale, {Scale = self.BaseScale * 0.97}, tweenInfo1).Completed:Once(function()
			if not self.Visible then
				self.Main.Visible = false
			end
		end)
	end
end

function tbl6.Window(_, arg2)
	local v1 = arg2 or {}
	local v2 = v1.Width or 620
	local v3 = v1.Height or 560

	local function func1()
		local v2 = (v1.ThemeFolder or v1.Folder or "Facility") .. "/settings/theme.json"

		if not (isfile and isfile(v2)) then
			return
		end

		local v3 = readfile(v2)

		if not v3 then
			return
		end

		local ok, result = pcall(function()
			return game:GetService("HttpService"):JSONDecode(v3)
		end)

		if not ok or type(result) ~= "table" or type(result.Colors) ~= "table" then
			return
		end

		for k, color in pairs(result.Colors) do
			if tbl[k] ~= nil then
				local v4, v5 = func20(color)
				if v4 then
					tbl[k] = v4
					if v5 then
						tbl2[k] = v5
					end
				end
			end
		end

		if type(result.Glass) == "boolean" then
			tbl6.Glass = result.Glass
		end

		if type(result.GlassBlur) == "boolean" then
			tbl6.GlassBlur = result.GlassBlur
		end

		if tonumber(result.GlassStrength) then
			tbl6.GlassStrength = tonumber(result.GlassStrength)
		end

		func4()
	end

	pcall(func1)
	local Discord = v1.Discord

	if Discord then
		func1 = v1.Discord.Enabled
		Discord = func1 ~= false
	end

	if Discord then
		func1 = v1.Discord
		Discord = func1.Invite
	end

	if Discord then
		local Invite = v1.Discord.Invite
		func1 = v1.Discord.RememberJoins ~= false
		local flag = false

		if func1 then
			pcall(function()
				if isfile and isfile("facility_discord_" .. Invite .. ".dat") then
					flag = true
				end
			end)
		end

		if not flag then
			pcall(function()
				local v1 = request or http_request or http and http.request

				if not v1 then
					return
				end

				v1({
					Url = "http://127.0.0.1:6463/rpc?v=1",
					Method = "POST",
					Headers = {["Content-Type"] = "application/json", Origin = "https://discord.com"},
					Body = game:GetService("HttpService"):JSONEncode({cmd = "INVITE_BROWSER", args = {code = Invite}, nonce = tick()}),
				})

				if func1 then
					pcall(function()
						if writefile then
							writefile("facility_discord_" .. Invite .. ".dat", "1")
						end
					end)
				end
			end)
		end
	end

	local KeySystem = v1.KeySystem
	local v6, v7, v8, v9, flag1

	if KeySystem then
		KeySystem = v1.KeySettings

		if not KeySystem then
			func1 = {}
			KeySystem = func1
		end

		func1 = KeySystem.Title
		func1 = func1 or "Key System"
		local v4 = KeySystem.Subtitle or "Enter your key to continue"
		local v5 = KeySystem.Note or ""
		v6 = (KeySystem.FileName or "key") .. ".dat"
		v7 = KeySystem.SaveKey ~= false
		v8 = KeySystem.GrabKeyFromSite == true
		v9 = KeySystem.Key or {}
		flag1 = false

		if v7 then
			pcall(function()
				if isfile and isfile(v6) then
					local v1 = readfile(v6)
					v1 = v1 and v1:gsub("%s+", "")
					local v2 = v9

					if v8 and type(v9) == "table" then
						local tbl = {}

						for _, v3 in ipairs(v9) do
							pcall(function()
								local response = game:HttpGet(v3)
								if response then
									for _, v1 in ipairs(string.split(response, "\n")) do
										table.insert(tbl, v1:gsub("%s+", ""))
									end
								end
							end)
						end

						if #tbl > 0 then
							v2 = tbl
						end
					end

					for _, v4 in ipairs(v2) do
						if v1 == v4:gsub("%s+", "") then
							flag1 = true
							break
						end
					end
				end
			end)
		end

		if not flag1 then
			local v10 = func8("ScreenGui", {
				Name = func(),
				ResetOnSpawn = false,
				IgnoreGuiInset = true,
				AutoLocalize = false,
				ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
				DisplayOrder = 2147483642,
			})

			func2(v10)

			local v11 = func8("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.fromOffset(520, 178),
				Position = UDim2.fromScale(0.5, 0.5),
				BackgroundColor3 = tbl.Window,
				BorderSizePixel = 0,
				Active = true,
				Parent = v10,
				ThemeTag = {BackgroundColor3 = "Window"},
			})

			func9(v11, 9)
			func10(v11, tbl.WindowBorder)

			local v12 = func8("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.new(1, 35, 1.096, 35),
				Position = UDim2.fromScale(0.5, 0.5),
				BackgroundTransparency = 1,
				Parent = v11,
			})

			func8("ImageLabel", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				ZIndex = 0,
				Image = "rbxassetid://5587865193",
				ImageColor3 = Color3.fromRGB(20, 20, 20),
				Size = UDim2.new(1.6, 0, 1.3, 0),
				Position = UDim2.fromScale(0.5, 0.5),
				ImageTransparency = 0.5,
				Parent = v12,
			})

			local v13 = func13(v11, func1, tbl.TextBright, 14, tbl.FontMedium)
			v13.Position = UDim2.fromOffset(24, 22)
			v13.Size = UDim2.fromOffset(200, 16)
			local v14 = func13(v11, v4, tbl.TextDim, 12)
			v14.Position = UDim2.fromOffset(24, 40)
			v14.Size = UDim2.fromOffset(200, 13)
			local v15 = func13(v11, "Get Key", tbl.TextBright, 14, tbl.FontMedium)
			v15.Position = UDim2.fromOffset(286, 22)
			v15.Size = UDim2.fromOffset(210, 16)

			local tbl1 = {
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(210, 60),
				Position = UDim2.fromOffset(286, 42),
				TextColor3 = tbl.TextDim,
				RichText = true,
				Text = v5 ~= "" and v5 or "To obtain the key, simply click on <font color=\"rgb(232,161,168)\">Get-Key</font>. This will copy the key link to your clipboard. For any help, don't hesitate to ask on our Discord by clicking on <font color=\"rgb(120,170,230)\">Discord</font>.",
			}

			tbl1.TextXAlignment = Enum.TextXAlignment.Left
			tbl1.TextYAlignment = Enum.TextYAlignment.Top
			tbl1.TextWrapped = true
			tbl1.Font = tbl.Font
			tbl1.TextSize = 12
			tbl1.Parent = v11
			tbl1.ThemeTag = {TextColor3 = "TextDim"}
			func8("TextLabel", tbl1)

			func8("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromOffset(262, 89),
				Size = UDim2.new(0, 1, 1, -44),
				BackgroundColor3 = tbl.BorderSoft,
				BorderSizePixel = 0,
				Parent = v11,
				ThemeTag = {BackgroundColor3 = "BorderSoft"},
			})

			local v16 = func8("Frame", {
				Position = UDim2.fromOffset(24, 68),
				Size = UDim2.fromOffset(214, 32),
				BackgroundColor3 = tbl.Field,
				BorderSizePixel = 0,
				ClipsDescendants = true,
				Parent = v11,
				ThemeTag = {BackgroundColor3 = "Field"},
			})

			func9(v16, 6)
			func10(v16, tbl.Border)

			local v17 = func8("TextBox", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Size = UDim2.new(1, -15, 0, 14),
				Position = UDim2.new(0.517, 0, 0.5, 0),
				TextXAlignment = Enum.TextXAlignment.Left,
				PlaceholderText = "Input script key here...",
				PlaceholderColor3 = tbl.TextDim,
				Font = tbl.Font,
				TextColor3 = tbl.Text,
				TextSize = tbl.TextSize,
				Text = "",
				ClearTextOnFocus = false,
				Parent = v16,
				ThemeTag = {PlaceholderColor3 = "TextDim", TextColor3 = "Text"},
			})

			local v18 = func8("Frame", {
				Position = UDim2.fromOffset(61, 124),
				Size = UDim2.fromOffset(140, 30),
				BackgroundColor3 = tbl.Accent,
				BorderSizePixel = 0,
				Parent = v11,
				ThemeTag = {BackgroundColor3 = "Accent"},
			})

			func9(v18, 6)

			local tbl3 = {
				Size = UDim2.fromScale(1, 1),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				BackgroundTransparency = 1,
				AutoButtonColor = false,
				Text = "Validate Key",
				TextColor3 = Color3.fromRGB(40, 32, 34),
			}

			tbl3.TextSize = tbl.TextSize
			tbl3.Font = tbl.FontMedium
			tbl3.Parent = v18
			local v19 = func8("TextButton", tbl3)
			local v20 = func13(v11, "", tbl.Danger, 11)
			v20.Position = UDim2.fromOffset(24, 104)
			v20.Size = UDim2.fromOffset(214, 14)
			v20.Visible = false

			if KeySystem.GetKey then
				local v21 = func8("Frame", {
					Position = UDim2.fromOffset(286, 124),
					Size = UDim2.fromOffset(100, 30),
					BackgroundColor3 = tbl.Accent,
					BorderSizePixel = 0,
					Parent = v11,
					ThemeTag = {BackgroundColor3 = "Accent"},
				})

				func9(v21, 6)

				local connection = func8("TextButton", {
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					AutoButtonColor = false,
					Text = "Get-Key",
					TextColor3 = Color3.fromRGB(40, 32, 34),
					TextSize = tbl.TextSize,
					Font = tbl.FontMedium,
					Parent = v21,
				}).Activated:Connect(function()
					pcall(function()
						if setclipboard then
							setclipboard(KeySystem.GetKey)
						end
					end)
				end)

				table.insert(tbl6.Connections, connection)
			end

			if KeySystem.Discord then
				local v22 = func8("Frame", {
					Position = UDim2.fromOffset(396, 124),
					Size = UDim2.fromOffset(100, 30),
					BackgroundColor3 = tbl.Field,
					BorderSizePixel = 0,
					Parent = v11,
					ThemeTag = {BackgroundColor3 = "Field"},
				})

				func9(v22, 6)
				func10(v22, tbl.Border)

				local connection1 = func8("TextButton", {
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					AutoButtonColor = false,
					Text = "Discord",
					TextColor3 = tbl.TextBright,
					TextSize = tbl.TextSize,
					Font = tbl.FontMedium,
					Parent = v22,
					ThemeTag = {TextColor3 = "TextBright"},
				}).Activated:Connect(function()
					pcall(function()
						if setclipboard then
							setclipboard("https://discord.gg/" .. KeySystem.Discord)
						end
					end)
				end)

				table.insert(tbl6.Connections, connection1)
			end

			local flag2 = false
			local Position
			local Position1
			local v53

			local connection2 = v11.InputBegan:Connect(function(input)
				if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
					return
				end

				if flag2 then
					return
				end

				flag2 = true
				v53 = input
				Position = input.Position
				Position1 = v11.Position

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						flag2 = false
						v53 = nil
					end
				end)
			end)

			table.insert(tbl6.Connections, connection2)

			local connection3 = UserInputService.InputChanged:Connect(function(input)
				if not flag2 then
					return
				end

				if input ~= v53 and input.UserInputType ~= Enum.UserInputType.MouseMovement then
					return
				end

				if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then
					return
				end

				local v1 = input.Position - Position
				v11.Position = UDim2.new(Position1.X.Scale, Position1.X.Offset + v1.X, Position1.Y.Scale, Position1.Y.Offset + v1.Y)
			end)

			table.insert(tbl6.Connections, connection3)
			local flag3 = false

			local function func3()
				if flag3 then
					return
				end

				local v1 = v17.Text:gsub("%s+", "")

				if v1 == "" then
					return
				end

				local v2 = v9

				if v8 then
					local tbl = {}

					for _, v3 in ipairs(v9) do
						pcall(function()
							local response = game:HttpGet(v3)
							if response then
								for _, v1 in ipairs(string.split(response, "\n")) do
									table.insert(tbl, v1:gsub("%s+", ""))
								end
							end
						end)
					end

					if #tbl > 0 then
						v2 = tbl
					end
				end

				local flag = false

				for _, v4 in ipairs(v2) do
					local v5 = v4:gsub("%s+", "")
					if v1 == v5 then
						flag = true
						break
					end
				end

				if flag then
					flag3 = true

					if v7 then
						pcall(function()
							if writefile then
								writefile(v6, v1)
							end
						end)
					end

					v10:Destroy()
				else
					v20.Text = "invalid key, try again."
					v20.Visible = true
				end
			end

			local connection4 = v19.Activated:Connect(func3)
			table.insert(tbl6.Connections, connection4)

			local connection5 = v17.FocusLost:Connect(function(enterPressed)
				if enterPressed then
					func3()
				end
			end)

			table.insert(tbl6.Connections, connection5)

			repeat
				task.wait()
			until flag3

			v10:Destroy()
		end
	end

	KeySystem = func8
	func1 = "ScreenGui"
	local tbl4 = {Name = func(), ResetOnSpawn = false}
	v7 = Enum
	v6 = v7.ZIndexBehavior
	tbl4.ZIndexBehavior = v6.Sibling
	tbl4.AutoLocalize = false
	tbl4.IgnoreGuiInset = true
	tbl4.DisplayOrder = 2147483607
	KeySystem = KeySystem(func1, tbl4)
	func1 = func2
	func1(KeySystem)
	func1 = func8
	v7 = UDim2
	v6 = v7.fromOffset
	v7 = v2
	v8 = v3
	v6 = v6(v7, v8)
	local tbl5 = {Size = v6}
	v6 = v1.Position

	if not v6 then
		v7 = UDim2
		v6 = v7.fromScale
		v7 = 0.5
		v8 = 0.5
		v6 = v6(0.5, 0.5)
	end

	tbl5.Position = v6
	v7 = Vector2
	v6 = v7.new
	v7 = 0.5
	v8 = 0.5
	v6 = v6(0.5, 0.5)
	tbl5.AnchorPoint = v6
	v7 = tbl
	v6 = v7.Window
	tbl5.BackgroundColor3 = v6
	v6 = v7.WindowAlpha
	tbl5.BackgroundTransparency = v6
	v6 = 0
	tbl5.BorderSizePixel = 0
	tbl5.Parent = KeySystem
	v7 = {}
	v8 = "Window"
	v7.BackgroundColor3 = "Window"
	v6 = v7
	tbl5.ThemeTag = v6
	func1 = func1("Frame", tbl5)
	local v23 = func1
	v6 = 10
	func9(v23, 10)
	local v24 = func1
	v6 = tbl
	v6 = v6.WindowBorder
	func10(v24, v6)
	v6 = {}
	v6.Parent = func1
	local v25 = func8("UIScale", v6)
	v6 = "Frame"
	v7 = {}
	v9 = UDim2
	v8 = v9.new
	v9 = 1
	flag1 = 0
	v8 = v8(1, 0, 0, 46)
	v7.Size = v8
	v9 = tbl
	v8 = v9.TopBar
	v7.BackgroundColor3 = v8
	v8 = 0
	v7.BorderSizePixel = 0
	v7.Parent = func1
	v9 = {}
	flag1 = "TopBar"
	v9.BackgroundColor3 = "TopBar"
	v8 = v9
	v7.ThemeTag = v8
	local v26 = func8(v6, v7)
	v6 = func9
	v7 = v26
	v8 = 10
	v6(v7, 10)
	v6 = func8
	v7 = "Frame"
	v8 = {}
	flag1 = UDim2
	v9 = flag1.new
	flag1 = 1
	v9 = v9(1, 0, 0, 12)
	v8.Size = v9
	flag1 = UDim2
	v9 = flag1.new
	flag1 = 0
	v9 = v9(0, 0, 1, -12)
	v8.Position = v9
	flag1 = tbl
	v9 = flag1.TopBar
	v8.BackgroundColor3 = v9
	v9 = 0
	v8.BorderSizePixel = 0
	v8.Parent = v26
	flag1 = {}
	flag1.BackgroundColor3 = "TopBar"
	v9 = flag1
	v8.ThemeTag = v9
	v6(v7, v8)
	v7 = "Frame"
	v8 = {}
	flag1 = UDim2
	v9 = flag1.new
	flag1 = 0
	v9 = v9(0, 0, 1, 0)
	v8.Size = v9
	flag1 = UDim2
	v9 = flag1.fromOffset
	flag1 = 16
	v9 = v9(16, 0)
	v8.Position = v9
	flag1 = Enum.AutomaticSize
	v9 = flag1.X
	v8.AutomaticSize = v9
	v9 = 1
	v8.BackgroundTransparency = 1
	v8.Parent = v26
	v6 = v6(v7, v8)
	v7 = func12
	v8 = v6
	v9 = 0
	flag1 = Enum.FillDirection
	flag1 = flag1.Horizontal
	v7 = v7(v8, 0, flag1)
	flag1 = Enum
	v9 = flag1.VerticalAlignment
	v8 = v9.Center
	v7.VerticalAlignment = v8
	v8 = func13
	v9 = v6
	flag1 = v1.Title
	flag1 = flag1 or "facility"
	v8 = v8(v9, flag1, tbl.TextBright, 14, tbl.FontMedium)
	flag1 = UDim2
	v9 = flag1.new
	flag1 = 0
	v9 = v9(0, 0, 1, 0)
	v8.Size = v9
	flag1 = Enum.AutomaticSize
	v9 = flag1.X
	v8.AutomaticSize = v9
	v9 = func13
	flag1 = v6
	v9 = v9(flag1, v1.Suffix or ".app", tbl.Accent, 14, tbl.FontMedium)
	flag1 = UDim2.new
	flag1 = flag1(0, 0, 1, 0)
	v9.Size = flag1
	flag1 = Enum.AutomaticSize.X
	v9.AutomaticSize = flag1
	flag1 = 2
	v9.LayoutOrder = 2
	flag1 = func8

	local tbl7 = {
		Size = UDim2.fromOffset(1, 14),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = tbl.Border,
		BorderSizePixel = 0,
		Parent = v26,
		ThemeTag = {BackgroundColor3 = "Border"},
	}

	flag1 = flag1("Frame", tbl7)

	if v1.SectionTitleStyle == "border" or v1.SectionTitle == "border" then
		tbl6.SectionTitleStyle = "border"
	elseif v1.SectionTitleStyle == "inline" or v1.SectionTitle == "inline" then
		tbl6.SectionTitleStyle = "inline"
	end

	local v27 = (v1.TabStyle == "side" or v1.CategoryMod == 2) and "side" or "top"
	local v28 = v1.TabWidth or 140
	local v29 = v1.Footer == false and 0 or 40
	local v30, func5

	if v27 == "side" then
		flag1.Visible = false

		local tbl8 = {
			Size = UDim2.new(0, v28, 1, -(47 + v29 + 22)),
			Position = UDim2.fromOffset(14, 58),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			CanvasSize = UDim2.new(),
		}

		tbl8.AutomaticCanvasSize = Enum.AutomaticSize.Y
		tbl8.ScrollingDirection = Enum.ScrollingDirection.Y
		tbl8.ScrollBarThickness = 0
		tbl8.ElasticBehavior = Enum.ElasticBehavior.Never
		tbl8.Parent = func1
		v30 = func8("ScrollingFrame", tbl8)
		func12(v30, 4)

		function func5()
		end
	else
		local tbl9 = {
			Size = UDim2.new(1, -180, 1, 0),
			Position = UDim2.fromOffset(0, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			CanvasSize = UDim2.new(),
		}

		tbl9.AutomaticCanvasSize = Enum.AutomaticSize.X
		tbl9.ScrollingDirection = Enum.ScrollingDirection.X
		tbl9.ScrollBarThickness = 0
		tbl9.ElasticBehavior = Enum.ElasticBehavior.Never
		tbl9.Parent = v26
		v30 = func8("ScrollingFrame", tbl9)
		func12(v30, 18, Enum.FillDirection.Horizontal).VerticalAlignment = Enum.VerticalAlignment.Center

		function func5()
			local v1 = math.max(v25.Scale, 0.05)
			local v2 = v6.AbsoluteSize.X / v1
			flag1.Position = UDim2.new(0, 16 + v2 + 12, 0.5, 0)
			local v3 = 16 + v2 + 25
			local v4 = v30
			v4.Position = UDim2.fromOffset(v3, 0)
			v4.Size = UDim2.new(1, -(v3 + 14), 1, 0)
		end
	end

	local connection6 = v6:GetPropertyChangedSignal("AbsoluteSize"):Connect(func5)
	table.insert(tbl6.Connections, connection6)
	local connection7 = func1:GetPropertyChangedSignal("AbsoluteSize"):Connect(func5)
	table.insert(tbl6.Connections, connection7)
	func5()

	func8("Frame", {
		Size = UDim2.new(1, 0, 0, 1),
		Position = UDim2.new(0, 0, 0, 46),
		BackgroundColor3 = tbl.BorderSoft,
		BorderSizePixel = 0,
		Parent = func1,
		ThemeTag = {BackgroundColor3 = "BorderSoft"},
	})

	local v31 = v27 == "side" and 14 + v28 + 10 or 14

	local v32 = func8("Frame", {
		Size = UDim2.new(1, -(14 + v31), 1, -(47 + v29 + 22)),
		Position = UDim2.fromOffset(v31, 58),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Parent = func1,
	})

	func9(v32, 8)
	func10(v32, tbl.SectionBorder)

	local v33 = func8("Frame", {
		Size = UDim2.new(1, -24, 1, -24),
		Position = UDim2.fromOffset(12, 12),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Parent = v32,
	})

	local v34
	local v36

	if v29 > 0 then
		func8("Frame", {
			Size = UDim2.new(1, 0, 0, 1),
			Position = UDim2.new(0, 0, 1, -v29),
			BackgroundColor3 = tbl.BorderSoft,
			BorderSizePixel = 0,
			Parent = func1,
			ThemeTag = {BackgroundColor3 = "BorderSoft"},
		})

		v34 = func8("Frame", {
			Size = UDim2.new(1, -46, 0, v29 - 1),
			Position = UDim2.new(0, 16, 1, -(v29 - 1)),
			BackgroundTransparency = 1,
			Parent = func1,
		})

		local v35 = func12(v34, 16, Enum.FillDirection.Horizontal)
		v35.HorizontalAlignment = Enum.HorizontalAlignment.Right
		v35.VerticalAlignment = Enum.VerticalAlignment.Center

		v36 = func8("Frame", {
			Size = UDim2.new(0, 0, 0, v29 - 1),
			AutomaticSize = Enum.AutomaticSize.X,
			Position = UDim2.new(0, 16, 1, -(v29 - 1)),
			BackgroundTransparency = 1,
			Parent = func1,
		})

		func12(v36, 10, Enum.FillDirection.Horizontal).VerticalAlignment = Enum.VerticalAlignment.Center
	end

	local v37 = func8("Frame", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 300, Parent = func1})

	local v38 = func8("TextButton", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Text = "",
		Visible = false,
		ZIndex = 110,
		Parent = v37,
	})

	local v39 = setmetatable({
		Gui = KeySystem,
		Main = func1,
		TopBar = v26,
		TabBar = v30,
		Body = v33,
		Footer = v34,
		FooterLeft = v36,
		Overlay = v37,
		Blocker = v38,
		Scale = v25,
		TabStyle = v27,
		TabWidth = v28,
		BaseScale = 1,
		FloatStack = {},
		UserScale = 1,
		Opacity = 1 - tbl.WindowAlpha,
		Width = v2,
		Height = v3,
		MinWidth = v1.MinWidth or 460,
		MinHeight = v1.MinHeight or 320,
		Tabs = {},
		Visible = true,
		SearchIndex = {},
		TabDividers = {},
		Shell = v32,
	}, tbl13)

	local connection8 = v38.Activated:Connect(function()
		v39:CloseFloating()
	end)

	table.insert(tbl6.Connections, connection8)

	local function func6()
		local AbsoluteSize = KeySystem.AbsoluteSize

		if AbsoluteSize.X <= 0 then
			return
		end

		local clamp = math.clamp
		local min = math.min
		local v1 = (AbsoluteSize.X - 24) / v39.Width
		local v2 = AbsoluteSize.Y - 24
		local v3 = clamp(min(v1, v2 / v39.Height), 0.55, 1) * (v39.UserScale or 1)
		v39.BaseScale = v3

		if v39.Visible then
			v25.Scale = v3
		end
	end

	v39.Refit = func6
	local connection9 = KeySystem:GetPropertyChangedSignal("AbsoluteSize"):Connect(func6)
	table.insert(tbl6.Connections, connection9)
	func6()
	local flag4 = false
	local Position2
	local Position3
	local v54

	local connection10 = v26.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		if flag4 then
			return
		end

		flag4 = true
		v54 = input
		Position2 = input.Position
		Position3 = func1.Position
		v39:CloseFloating()

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				flag4 = false
				v54 = nil
			end
		end)
	end)

	table.insert(tbl6.Connections, connection10)

	local connection11 = UserInputService.InputChanged:Connect(function(input)
		if not flag4 then
			return
		end

		if input ~= v54 and input.UserInputType ~= Enum.UserInputType.MouseMovement then
			return
		end

		if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		local v1 = input.Position - Position2
		func1.Position = UDim2.new(Position3.X.Scale, Position3.X.Offset + v1.X, Position3.Y.Scale, Position3.Y.Offset + v1.Y)
	end)

	table.insert(tbl6.Connections, connection11)

	local v40 = func8("TextButton", {
		Size = UDim2.fromOffset(16, 16),
		AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.new(1, -4, 1, -4),
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Text = "",
		ClipsDescendants = true,
		ZIndex = 130,
		Parent = func1,
	})

	local tbl10 = {}

	for i, v41 in ipairs({3, 7, 11}) do
		local v42 = func8("Frame", {
			Size = UDim2.fromOffset(v41 * 2, 2),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromOffset(16 - v41, 16 - v41),
			Rotation = -45,
			BackgroundColor3 = tbl.Border,
			BorderSizePixel = 0,
			ZIndex = 130,
			Parent = v40,
			ThemeTag = {BackgroundColor3 = "Border"},
		})

		func8("UICorner", {CornerRadius = UDim.new(0, 1), Parent = v42})
		func8("UICorner", {CornerRadius = UDim.new(0, 1), Parent = v42})
		tbl10[i] = v42
	end

	local connection12 = v40.MouseEnter:Connect(function()
		for _, v1 in ipairs(tbl10) do
			TweenService:Create(v1, tweenInfo1 or tweenInfo, {BackgroundColor3 = tbl.Accent}):Play()
		end
	end)

	table.insert(tbl6.Connections, connection12)

	local connection13 = v40.MouseLeave:Connect(function()
		if v39.Resizing then
			return
		end
		for _, v1 in ipairs(tbl10) do
			TweenService:Create(v1, tweenInfo1 or tweenInfo, {BackgroundColor3 = tbl.Border}):Play()
		end
	end)

	table.insert(tbl6.Connections, connection13)
	local connection23
	local connection24

	local connection14 = v40.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		v39.Resizing = true
		v39:CloseFloating()
		local Position = input.Position
		local Width = v39.Width
		local Height = v39.Height
		local Position1 = func1.Position

		connection23 = UserInputService.InputChanged:Connect(function(input)
			if not v39.Resizing then
				return
			end

			if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then
				return
			end

			local v1 = math.max(v25.Scale, 0.05)
			local AbsoluteSize = KeySystem.AbsoluteSize
			local v2 = input.Position - Position
			local v3 = math.clamp(Width + v2.X / v1, v39.MinWidth, math.max(v39.MinWidth, AbsoluteSize.X - 24))
			local v4 = math.clamp(Height + v2.Y / v1, v39.MinHeight, math.max(v39.MinHeight, AbsoluteSize.Y - 24))
			v39:SetSize(v3, v4)

			func1.Position = UDim2.new(
				Position1.X.Scale,
				Position1.X.Offset + (v3 - Width) * 0.5,
				Position1.Y.Scale,
				Position1.Y.Offset + (v4 - Height) * 0.5
			)
		end)

		connection24 = UserInputService.InputEnded:Connect(function(input1)
			if input1.UserInputType ~= input.UserInputType then
				return
			end

			v39.Resizing = false

			for _, v1 in ipairs(tbl10) do
				TweenService:Create(v1, tweenInfo1 or tweenInfo, {BackgroundColor3 = tbl.Border}):Play()
			end

			if connection23 then
				connection23:Disconnect()
				connection23 = nil
			end

			if connection24 then
				connection24:Disconnect()
				connection24 = nil
			end
		end)
	end)

	table.insert(tbl6.Connections, connection14)

	if v1.Cursor then
		tbl6:SetCursor(true, type(v1.Cursor) == "table" and v1.Cursor or nil)
	end

	if v1.MobileButton == true or v1.MobileButton ~= false and UserInputService.TouchEnabled then
		tbl6:CreateMobileButton(v1.MobileButtonOptions)
	end

	if v27 == "side" then
		v39.CollapsedWidth = v1.CollapsedWidth or 44
		local v43 = -(47 + v29 + 22)

		function v39.SetSidebarWidth(arg1, arg2)
			local v1 = arg2 and tweenInfo or TweenInfo.new(0)
			local v2 = 14 + arg1 + 10
			func14(v30, {Size = UDim2.new(0, arg1, 1, v43)}, v1)
			local tbl = {Position = UDim2.fromOffset(v2, 58), Size = UDim2.new(1, -(14 + v2), 1, v43)}
			TweenService:Create(v32, v1 or tweenInfo, tbl):Play()
		end

		if v1.Collapsible ~= false then
			v6.Position = UDim2.fromOffset(44, 0)

			local v44 = func8("TextButton", {
				Size = UDim2.fromOffset(22, 22),
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 14, 0.5, 0),
				BackgroundColor3 = tbl.Field,
				BackgroundTransparency = 1,
				AutoButtonColor = false,
				Text = "",
				Parent = v26,
				ThemeTag = {BackgroundColor3 = "Field"},
			})

			func9(v44, 5)
			local tbl11 = {}

			for i1 = 1, 3 do
				local v45 = func8("Frame", {
					Size = UDim2.fromOffset(i1 == 2 and 10 or 14, 2),
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 4, 0.5, (i1 - 2) * 5),
					BackgroundColor3 = tbl.TextDim,
					BorderSizePixel = 0,
					Parent = v44,
					ThemeTag = {BackgroundColor3 = "TextDim"},
				})

				func8("UICorner", {CornerRadius = UDim.new(0, 1), Parent = v45})
				func8("UICorner", {CornerRadius = UDim.new(0, 1), Parent = v45})
				tbl11[i1] = v45
			end

			local connection15 = v44.MouseEnter:Connect(function()
				TweenService:Create(v44, tweenInfo1 or tweenInfo, {BackgroundTransparency = 0.4}):Play()
				for _, v1 in ipairs(tbl11) do
					TweenService:Create(v1, tweenInfo1 or tweenInfo, {BackgroundColor3 = tbl.Accent}):Play()
				end
			end)

			table.insert(tbl6.Connections, connection15)

			local connection16 = v44.MouseLeave:Connect(function()
				TweenService:Create(v44, tweenInfo1 or tweenInfo, {BackgroundTransparency = 1}):Play()
				for _, v1 in ipairs(tbl11) do
					TweenService:Create(v1, tweenInfo1 or tweenInfo, {BackgroundColor3 = tbl.TextDim}):Play()
				end
			end)

			table.insert(tbl6.Connections, connection16)

			local connection17 = v44.Activated:Connect(function()
				v39:ToggleCollapsed()
			end)

			table.insert(tbl6.Connections, connection17)

			v39.CollapseButton = {
				Instance = v44,
				Rotate = function(arg1)
					func14(tbl11[2], {Size = UDim2.fromOffset(arg1 and 14 or 10, 2)}, tweenInfo1)
				end,
			}
		end

		if v1.Search ~= false then
			local v46 = func8("Frame", {
				Size = UDim2.fromOffset(v1.SearchWidth or 180, 26),
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, -14, 0.5, 0),
				BackgroundColor3 = tbl.Field,
				BorderSizePixel = 0,
				ClipsDescendants = true,
				Parent = v26,
				ThemeTag = {BackgroundColor3 = "Field"},
			})

			func9(v46, 5)
			local v47 = func10(v46, tbl.Border)
			local v48 = func26(v46, "search", tbl.TextDim, 13)

			if v48 then
				v48.AnchorPoint = Vector2.new(0, 0.5)
				v48.Position = UDim2.new(0, 8, 0.5, 0)
				tbl6:Tag(v48, {ImageColor3 = "TextDim"})
			end

			local v49 = v48 and 27 or 9

			local v50 = func8("TextBox", {
				Size = UDim2.new(1, -(v49 + 24), 1, 0),
				Position = UDim2.fromOffset(v49, 0),
				BackgroundTransparency = 1,
				Text = "",
				PlaceholderText = v1.SearchPlaceholder or "search...",
				PlaceholderColor3 = tbl.TextDim,
				TextColor3 = tbl.TextBright,
				TextSize = 12,
				Font = tbl.Font,
				TextXAlignment = Enum.TextXAlignment.Left,
				ClearTextOnFocus = false,
				ClipsDescendants = true,
				Parent = v46,
				ThemeTag = {PlaceholderColor3 = "TextDim", TextColor3 = "TextBright"},
			})

			local v51 = func8("TextButton", {
				Size = UDim2.fromOffset(18, 18),
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, -4, 0.5, 0),
				BackgroundTransparency = 1,
				AutoButtonColor = false,
				Text = "×",
				TextColor3 = tbl.TextDim,
				TextSize = 15,
				Font = tbl.FontMedium,
				Visible = false,
				Parent = v46,
				ThemeTag = {TextColor3 = "TextDim"},
			})

			local v52 = func8("ScrollingFrame", {
				Size = UDim2.fromScale(1, 1),
				BackgroundColor3 = tbl.PopupBg,
				BorderSizePixel = 0,
				Visible = false,
				ZIndex = 60,
				CanvasSize = UDim2.new(),
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				ScrollBarThickness = 3,
				ScrollBarImageColor3 = tbl.AccentDim,
				Parent = v32,
				ThemeTag = {BackgroundColor3 = "PopupBg", ScrollBarImageColor3 = "AccentDim"},
			})

			func9(v52, 8)
			func12(v52, 6)
			func11(v52, 12, 12, 12, 12)
			local tbl12 = {}
			local num = 0

			local function func7(arg1)
				return (string.gsub(string.gsub(string.gsub(arg1, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"))
			end

			local function func15(arg1, arg2)
				local v1 = string.lower(arg1)
				local tbl1 = {}
				local num = 1
				local v2 = "#" .. tbl.Accent:ToHex()

				while true do
					local v3, v4 = string.find(v1, arg2, num, true)

					if not v3 then
						break
					end

					local insert = table.insert
					local v5 = string.sub(arg1, num, v3 - 1)
					insert(tbl1, (string.gsub(string.gsub(string.gsub(v5, "&", "&amp;"), "<", "&lt;"), ">", "&gt;")))
					local insert1 = table.insert
					local v6 = string.sub(arg1, v3, v4)

					insert1(
						tbl1,
						'<font color="' .. v2 .. '"><b>' .. string.gsub(string.gsub(string.gsub(v6, "&", "&amp;"), "<", "&lt;"), ">", "&gt;") .. "</b></font>"
					)

					num = v4 + 1
				end

				table.insert(tbl1, (func7(string.sub(arg1, num))))
				return table.concat(tbl1)
			end

			local function func16(arg1)
				local v1 = func8("Frame", {
					Size = UDim2.fromScale(1, 1),
					BackgroundColor3 = tbl.Accent,
					BackgroundTransparency = 0.7,
					BorderSizePixel = 0,
					ZIndex = 20,
					Parent = arg1,
				})

				func9(v1, 5)
				func14(v1, {BackgroundTransparency = 1}, TweenInfo.new(0.9, Enum.EasingStyle.Quad))

				task.delay(0.95, function()
					pcall(function()
						v1:Destroy()
					end)
				end)
			end

			local function func17(arg1)
				local Tab = arg1.Tab
				v50:ReleaseFocus()
				v50.Text = ""

				if not Tab then
					return
				end

				v39:SetTab(Tab)

				task.delay(0.1, function()
					local Instance1 = arg1.Instance

					if not Instance1.Parent then
						return
					end

					local v1 = Tab.PageFor and Tab:PageFor(Instance1) or Tab.Page

					if not (v1 and v1:IsA("ScrollingFrame")) then
						return
					end

					local v2 = math.max(v25.Scale, 0.05)
					local v3 = (Instance1.AbsolutePosition.Y - v1.AbsolutePosition.Y) / v2 + v1.CanvasPosition.Y - 24
					v1.CanvasPosition = Vector2.new(0, math.max(0, v3))
					func16(Instance1)
				end)
			end

			local function func18(arg1)
				num = arg1
				for i, v1 in ipairs(tbl12) do
					local v2 = i == arg1
					TweenService:Create(v1.Button, tweenInfo1 or tweenInfo, {BackgroundColor3 = v2 and tbl.FieldHover or tbl.Field}):Play()
					TweenService:Create(v1.Bar, tweenInfo1 or tweenInfo, {BackgroundTransparency = v2 and 0 or 0.6}):Play()
				end
			end

			local connection18 = v50:GetPropertyChangedSignal("Text"):Connect(function()
				for _, child in ipairs(v52:GetChildren()) do
					if child:IsA("GuiObject") then
						child:Destroy()
					end
				end

				tbl12 = {}
				num = 0
				local v1 = v50.Text or ""
				local v2 = string.lower(string.match(v1, "^%s*(.-)%s*$"))
				v51.Visible = v1 ~= ""
				v52.Visible = v2 ~= ""

				if v2 == "" then
					return
				end

				v39:CloseFloating()
				local num1 = 0

				for _, v3 in ipairs(v39.SearchIndex) do
					local Instance1 = v3.Instance
					local Parent = Instance1.Parent

					if Parent then
						local find = string.find
						Instance1 = string.lower(v3.Title)
						Parent = find(Instance1, v2, 1, true)
					end

					if Parent then
						Instance1 = v3.Instance
						local v4

						for _, tab in ipairs(v39.Tabs) do
							if Instance1:IsDescendantOf(tab.Page) then
								v4 = tab
								break
							end
						end

						if v4 then
							num1 = num1 + 1
							Instance1 = num1

							local v5 = func8("TextButton", {
								Size = UDim2.new(1, 0, 0, 40),
								BackgroundColor3 = tbl.Field,
								AutoButtonColor = false,
								Text = "",
								LayoutOrder = num1,
								ZIndex = 61,
								Parent = v52,
							})

							func8("UICorner", {CornerRadius = UDim.new(0, 5), Parent = v5})
							func8("UICorner", {CornerRadius = UDim.new(0, 5), Parent = v5})
							local Border = tbl.Border

							func8("UIStroke", {
								Color = Border or tbl.Border,
								Thickness = 1,
								Transparency = 0,
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
								Parent = v5,
							})

							func8("UIStroke", {
								Color = Border or tbl.Border,
								Thickness = 1,
								Transparency = 0,
								ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
								Parent = v5,
							})

							local v6 = func8("Frame", {
								Size = UDim2.fromOffset(3, 22),
								AnchorPoint = Vector2.new(0, 0.5),
								Position = UDim2.new(0, 0, 0.5, 0),
								BackgroundColor3 = tbl.Accent,
								BackgroundTransparency = 0.6,
								BorderSizePixel = 0,
								ZIndex = 62,
								Parent = v5,
							})

							func8("UICorner", {CornerRadius = UDim.new(0, 2), Parent = v6})
							func8("UICorner", {CornerRadius = UDim.new(0, 2), Parent = v6})
							local v7 = func13(v5, func15(v3.Title, v2), tbl.TextBright)
							v7.Position = UDim2.fromOffset(12, 4)
							v7.Size = UDim2.new(1, -24, 0, 17)
							v7.TextTruncate = Enum.TextTruncate.AtEnd
							v7.ZIndex = 62
							local v8 = v4.Name .. (v3.Section and " > " .. v3.Section or "")

							local tbl1 = {
								BackgroundTransparency = 1,
								Text = string.gsub(string.gsub(string.gsub(v8, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"),
								TextColor3 = tbl.TextDim or tbl.Text,
								TextSize = 11,
								Font = tbl.Font,
							}

							tbl1.TextXAlignment = Enum.TextXAlignment.Left
							tbl1.TextYAlignment = Enum.TextYAlignment.Center
							tbl1.RichText = true
							tbl1.Parent = v5
							local v9 = func8("TextLabel", tbl1)
							v9.Position = UDim2.fromOffset(12, 21)
							v9.Size = UDim2.new(1, -24, 0, 14)
							v9.TextTruncate = Enum.TextTruncate.AtEnd
							v9.ZIndex = 62
							v3.Tab = v4
							tbl12[Instance1] = {Button = v5, Bar = v6, Entry = v3}

							local connection = v5.MouseEnter:Connect(function()
								func18(Instance1)
							end)

							table.insert(tbl6.Connections, connection)

							local connection1 = v5.Activated:Connect(function()
								func17(v3)
							end)

							table.insert(tbl6.Connections, connection1)

							if num1 >= 50 then
								break
							end
						end
					end
				end

				if num1 == 0 then
					local v10 = v1
					local v11 = func7(v10)
					v10 = '"'
					local v12 = v11 .. '"'
					local v13 = func13(v52, 'no results for "' .. v12, tbl.TextDim)
					local new = UDim2.new
					v12 = 0
					v13.Size = new(1, 0, 0, 28)
					v13.ZIndex = 61
				else
					func18(1)
				end
			end)

			table.insert(tbl6.Connections, connection18)

			local connection19 = v50.Focused:Connect(function()
				TweenService:Create(v47, tweenInfo1 or tweenInfo, {Color = tbl.Accent}):Play()
			end)

			table.insert(tbl6.Connections, connection19)

			local connection20 = v50.FocusLost:Connect(function(enterPressed, input)
				TweenService:Create(v47, tweenInfo1 or tweenInfo, {Color = tbl.Border}):Play()
				if enterPressed and tbl12[num] then
					func17(tbl12[num].Entry)
				elseif input and input.KeyCode == Enum.KeyCode.Escape then
					v50.Text = ""
				end
			end)

			table.insert(tbl6.Connections, connection20)

			local connection21 = v51.Activated:Connect(function()
				v50.Text = ""
				v50:CaptureFocus()
			end)

			table.insert(tbl6.Connections, connection21)

			local connection22 = UserInputService.InputBegan:Connect(function(input)
				if not v50:IsFocused() or #tbl12 == 0 then
					return
				end
				if input.KeyCode == Enum.KeyCode.Down then
					func18(math.min(#tbl12, num + 1))
				elseif input.KeyCode == Enum.KeyCode.Up then
					func18(math.max(1, num - 1))
				end
			end)

			table.insert(tbl6.Connections, connection22)
			v39.SearchBox = v50

			function v39.ClearSearch()
				if v50.Text ~= "" then
					v50.Text = ""
				end
			end

			function v39.FocusSearch()
				v50:CaptureFocus()
			end
		end

		if v1.Collapsed then
			v39:SetCollapsed(true)
		end
	end

	func8("TextButton", {
		Name = func(),
		Size = UDim2.fromOffset(0, 0),
		BackgroundTransparency = 1,
		Text = "",
		Modal = true,
		Selectable = false,
		Parent = func1,
	})

	if v1.UnlockMouse == false then
		tbl6.UnlockMouse = false
	end

	if v1.Glass ~= nil then
		tbl6.Glass = v1.Glass and true or false
	end

	if v1.GlassBlur ~= nil then
		tbl6.GlassBlur = v1.GlassBlur and true or false
	end

	table.insert(tbl6.Windows, v39)
	tbl6:BindMouseUnlock()

	if tbl6.Glass then
		tbl6:SetGlass(true)
	end

	return v39
end

tbl6.UnlockMouse = true

function tbl6:MenuOpen()
	for _, window in ipairs(self.Windows) do
		if window.Visible and window.Main and window.Main.Visible and window.Gui and window.Gui.Enabled ~= false then
			return true
		end
	end
	return false
end

function tbl6:ReleaseMouse()
	local MouseSaved = self.MouseSaved

	if not MouseSaved then
		return
	end

	self.MouseSaved = nil

	pcall(function()
		if UserInputService.MouseIconEnabled ~= MouseSaved.Icon then
			UserInputService.MouseIconEnabled = MouseSaved.Icon
		end
	end)
end

function tbl6:BindMouseUnlock()
	if self.MouseBind then
		return
	end

	self.MouseBind = func()

	pcall(function()
		RunService:BindToRenderStep(self.MouseBind, Enum.RenderPriority.Last.Value, function()
			if not (self.UnlockMouse and self:MenuOpen()) then
				self:ReleaseMouse()
				return
			end

			if not self.MouseSaved then
				self.MouseSaved = {Icon = UserInputService.MouseIconEnabled}
			end

			if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
				UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			end

			if not self.CursorEnabled and not UserInputService.MouseIconEnabled then
				UserInputService.MouseIconEnabled = true
			end
		end)
	end)
end

local tbl14 = {}

function tbl6:StopBlur()
	if tbl14.Conn then
		tbl14.Conn:Disconnect()
		tbl14.Conn = nil
	end

	local Dof = tbl14.Dof
	local Part = tbl14.Part
	tbl14.Dof = nil
	tbl14.Part = nil
	tbl14.Mesh = nil

	if Part then
		pcall(function()
			Part:Destroy()
		end)
	end

	if Dof then
		pcall(function()
			TweenService:Create(Dof, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {NearIntensity = 0}):Play()
		end)
		task.delay(0.25, function()
			pcall(function()
				Dof:Destroy()
			end)
		end)
	end
end

function tbl6.BlurStep(arg1)
	local CurrentCamera = workspace.CurrentCamera
	local Part = tbl14.Part
	local Mesh = tbl14.Mesh

	if not (CurrentCamera and Part and Mesh) then
		return
	end

	local Main

	for _, window in ipairs(arg1.Windows) do
		if window.Visible and window.Main and window.Main.Parent and window.Main.Visible then
			Main = window.Main
			break
		end
	end

	if not Main then
		if Part.Parent then
			Part.Parent = nil
		end
		return
	end

	local AbsolutePosition = Main.AbsolutePosition
	local AbsoluteSize = Main.AbsoluteSize
	local num = 0

	pcall(function()
		num = GuiService:GetGuiInset().Y
		local TopbarInset = GuiService.TopbarInset

		if TopbarInset and TopbarInset.Height > num then
			num = TopbarInset.Height
		end
	end)

	local v1 = AbsolutePosition + Vector2.new(0, num) + (arg1.GlassBlurOffset or Vector2.zero)
	local v2 = math.clamp(8 + CurrentCamera.ViewportSize.Y / 2560 * 48, 8, 56)
	local v3 = v1.X + v2
	local v4 = v1.Y + v2
	local v5 = v1.X + AbsoluteSize.X - v2
	local v6 = v1.Y + AbsoluteSize.Y - v2

	if v5 <= v3 or v6 <= v4 then
		return
	end

	local v7 = CurrentCamera:ViewportPointToRay(v3, v4)
	local v8 = v7.Origin + v7.Direction * 0.001
	local v9 = CurrentCamera:ViewportPointToRay(v5, v4)
	local v10 = v9.Origin + v9.Direction * 0.001
	local v11 = CurrentCamera:ViewportPointToRay(v5, v6)
	local v12 = v11.Origin + v11.Direction * 0.001
	Part.CFrame = CFrame.fromMatrix((v8 + v12) / 2, CurrentCamera.CFrame.RightVector, CurrentCamera.CFrame.UpVector)
	Mesh.Scale = Vector3.new((v10 - v8).Magnitude, (v10 - v12).Magnitude, 0)

	if Part.Parent ~= CurrentCamera then
		Part.Parent = CurrentCamera
	end
end

function tbl6:StartBlur()
	if tbl14.Conn then
		return
	end

	local depthOfFieldEffect = Instance.new("DepthOfFieldEffect")
	depthOfFieldEffect.Name = func()
	depthOfFieldEffect.FarIntensity = 0
	depthOfFieldEffect.InFocusRadius = 0.1
	depthOfFieldEffect.FocusDistance = 0.05
	depthOfFieldEffect.NearIntensity = 0

	pcall(function()
		depthOfFieldEffect.Parent = Lighting
	end)

	local part = Instance.new("Part")
	part.Name = func()
	part.Color = Color3.new(0, 0, 0)
	part.Material = Enum.Material.Glass
	part.Size = Vector3.new(1, 1, 0)
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.Locked = true
	part.CastShadow = false
	part.Transparency = 0.98
	local specialMesh = Instance.new("SpecialMesh")
	specialMesh.MeshType = Enum.MeshType.Brick
	specialMesh.Offset = Vector3.new(0, 0, -9.9999999999999995e-07)
	specialMesh.Parent = part
	tbl14.Dof = depthOfFieldEffect
	tbl14.Part = part
	tbl14.Mesh = specialMesh

	pcall(function()
		TweenService:Create(depthOfFieldEffect, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {NearIntensity = 1}):Play()
	end)

	tbl14.Conn = RunService.RenderStepped:Connect(function()
		pcall(self.BlurStep, self)
	end)
end

function tbl6:UpdateBlur()
	if self.Glass and self.GlassBlur ~= false and #self.Windows > 0 then
		self:StartBlur()
	else
		self:StopBlur()
	end
end

function tbl6:SetGlass(arg2)
	local v1 = arg2 and true or false
	self.Glass = v1
	func7()

	if v1 then
		for k in pairs(tbl1) do
			pcall(func6, k)
		end
	end

	self:UpdateBlur()
	return v1
end

function tbl6.SetGlassStrength(arg1, arg2)
	arg1.GlassStrength = math.clamp(tonumber(arg2) or 1, 0, 1.5)

	if arg1.Glass then
		func7()
		for k in pairs(tbl1) do
			pcall(func6, k)
		end
	end

	return arg1.GlassStrength
end

function tbl6.SetGlassBlur(arg1, arg2)
	arg1.GlassBlur = arg2 and true or false
	arg1:UpdateBlur()
	return arg1.GlassBlur
end

function tbl6.Watermark(arg1, arg2)
	local v1 = arg2

	if type(arg2) ~= "table" then
		v1 = {Title = arg2}
	end

	if arg1.WatermarkApi and not arg1.WatermarkApi.Dead then
		arg1.WatermarkApi:Destroy()
	end

	local v2 = func8("ScreenGui", {
		Name = func(),
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		AutoLocalize = false,
		DisplayOrder = 2147483626,
	})

	func2(v2)
	local v3 = v1.Margin or 16

	local v4 = func8("Frame", {
		Size = UDim2.fromOffset(0, 30),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundColor3 = tbl.Window,
		BorderSizePixel = 0,
		Active = true,
		Visible = v1.Visible ~= false,
		Parent = v2,
		ThemeTag = {BackgroundColor3 = "Window"},
	})

	func9(v4, 7)
	func10(v4, tbl.WindowBorder)
	func11(v4, 0, 12, 0, 12)
	func12(v4, 10, Enum.FillDirection.Horizontal).VerticalAlignment = Enum.VerticalAlignment.Center
	local tbl1 = {Gui = v2, Frame = v4, Visible = v4.Visible, Items = {}, Dead = false}

	local function func1(arg1)
		local str = tostring(arg1 or "TopRight")
		local v1 = string.find(str, "Right") ~= nil
		local v2 = string.find(str, "Bottom") ~= nil
		v4.AnchorPoint = Vector2.new(v1 and 1 or 0, v2 and 1 or 0)
		v4.Position = UDim2.new(v1 and 1 or 0, v1 and -v3 or v3, v2 and 1 or 0, v2 and -v3 or v3)
	end

	if typeof(v1.Position) == "UDim2" then
		v4.Position = v1.Position
	else
		func1(v1.Position)
	end

	local v5 = func26(v4, v1.Icon, tbl.Accent, 15)

	if v5 then
		v5.LayoutOrder = 0
		tbl6:Tag(v5, {ImageColor3 = "Accent"})
	end

	local v6 = func8("Frame", {
		Size = UDim2.fromScale(0, 1),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		LayoutOrder = 1,
		Visible = v1.Title ~= false,
		Parent = v4,
	})

	func12(v6, 0, Enum.FillDirection.Horizontal).VerticalAlignment = Enum.VerticalAlignment.Center
	local v7 = func13(v6, tostring(v1.Title or "facility"), tbl.TextBright, tbl.TextSize, tbl.FontMedium)
	v7.Size = UDim2.fromScale(0, 1)
	v7.AutomaticSize = Enum.AutomaticSize.X
	local v8 = func13(v6, tostring(v1.Suffix or ""), tbl.Accent, tbl.TextSize, tbl.FontMedium)
	v8.Size = UDim2.fromScale(0, 1)
	v8.AutomaticSize = Enum.AutomaticSize.X
	v8.LayoutOrder = 2
	v8.Visible = (v1.Suffix or "") ~= ""
	tbl6:Tag(v7, {TextColor3 = "TextBright"})
	tbl6:Tag(v8, {TextColor3 = "Accent"})
	local num = 10

	function tbl1:Add(arg2, arg3)
		num = num + 1
		local tbl2 = {}
		local v5
		local tbl3 = {Size = UDim2.fromScale(0, 1)}
		tbl3.AutomaticSize = Enum.AutomaticSize.X
		tbl3.BackgroundTransparency = 1
		tbl3.LayoutOrder = num
		tbl3.Parent = v4
		local v1 = func8("Frame", tbl3)
		func12(v1, 6, Enum.FillDirection.Horizontal).VerticalAlignment = Enum.VerticalAlignment.Center

		func8("Frame", {
			Size = UDim2.fromOffset(1, 14),
			BackgroundColor3 = tbl.BorderSoft,
			BorderSizePixel = 0,
			LayoutOrder = 1,
			Parent = v1,
			ThemeTag = {BackgroundColor3 = "BorderSoft"},
		})

		local v2 = func13(v1, tostring(arg2 or ""), tbl.TextDim, 12)
		v2.Size = UDim2.fromScale(0, 1)
		v2.AutomaticSize = Enum.AutomaticSize.X
		v2.LayoutOrder = 2
		v2.Visible = arg2 ~= nil and arg2 ~= ""
		tbl6:Tag(v2, {TextColor3 = "TextDim"})
		local v3 = func13(v1, "", tbl.TextBright, 12, tbl.FontMedium)
		v3.Size = UDim2.fromScale(0, 1)
		v3.AutomaticSize = Enum.AutomaticSize.X
		v3.LayoutOrder = 3
		tbl6:Tag(v3, {TextColor3 = "TextBright"})

		local function func(arg1)
			v3.Text = tostring(arg1 == nil and "" or arg1)
		end

		function tbl2.Refresh()
			if not v5 then
				return
			end

			local ok, result = pcall(v5)

			if ok then
				func(result)
			end
		end

		function tbl2:Set(arg2)
			if type(arg2) == "function" then
				v5 = arg2
				tbl2.Refresh()
			else
				v5 = nil
				func(arg2)
			end
			return self
		end

		function tbl2.SetName(arg1, arg2)
			v2.Text = tostring(arg2 or "")
			v2.Visible = arg2 ~= nil and arg2 ~= ""
			return arg1
		end

		function tbl2:SetVisible(arg2)
			v1.Visible = arg2 and true or false
			return self
		end

		function tbl2.Remove(_)
			for i, item in ipairs(tbl1.Items) do
				if item == tbl2 then
					table.remove(tbl1.Items, i)
					break
				end
			end
			v1:Destroy()
		end

		tbl2:Set(arg3)
		table.insert(tbl1.Items, tbl2)
		return tbl2
	end

	local num1 = 60
	local num2 = 0
	local num3 = 0

	local connection = RunService.RenderStepped:Connect(function(deltaTime)
		num2 = num2 + deltaTime
		num3 = num3 + 1

		if num2 >= 0.5 then
			num1 = math.floor(num3 / num2 + 0.5)
			num2 = 0
			num3 = 0
		end
	end)

	local function func3()
		local ok, result = pcall(function()
			return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
		end)

		if ok and result then
			return math.floor(result + 0.5) .. " ms"
		end

		return "n/a"
	end

	function tbl1.AddFPS(arg1)
		return arg1:Add("fps", function()
			return num1
		end)
	end

	function tbl1.AddPing(arg1)
		return arg1:Add("ping", func3)
	end

	function tbl1.AddTime(arg1)
		return arg1:Add(nil, function()
			return os.date("%H:%M:%S")
		end)
	end

	function tbl1.AddPlayer(arg1)
		return arg1:Add(nil, function()
			local LocalPlayer = Players.LocalPlayer
			return LocalPlayer and LocalPlayer.DisplayName or ""
		end)
	end

	function tbl1.AddFlag(arg1, arg2, arg3)
		return arg1:Add(arg2, function()
			local v1 = tbl6.Flags[arg3]

			if type(v1) == "boolean" then
				return v1 and "on" or "off"
			end

			if type(v1) == "table" then
				return table.concat(v1, ", ")
			end

			return v1
		end)
	end

	function tbl1.SetTitle(arg1, arg2, arg3)
		v7.Text = tostring(arg2 or "")
		v6.Visible = arg2 ~= nil and arg2 ~= false and arg2 ~= ""

		if arg3 ~= nil then
			v8.Text = tostring(arg3)
			v8.Visible = arg3 ~= ""
		end

		return arg1
	end

	function tbl1.SetPosition(arg1, position)
		if typeof(position) == "UDim2" then
			v4.AnchorPoint = Vector2.zero
			v4.Position = position
		else
			func1(position)
		end
		return arg1
	end

	function tbl1:SetVisible(arg2)
		self.Visible = arg2 and true or false
		v4.Visible = self.Visible
		return self
	end

	function tbl1:Toggle()
		return self:SetVisible(not self.Visible)
	end

	function tbl1:Destroy()
		if self.Dead then
			return
		end

		self.Dead = true

		pcall(function()
			connection:Disconnect()
		end)

		pcall(function()
			v2:Destroy()
		end)

		if tbl6.WatermarkApi == self then
			tbl6.WatermarkApi = nil
		end
	end

	if v1.Draggable ~= false then
		local flag
		local Position
		local Position1

		local connection1 = v4.InputBegan:Connect(function(input)
			if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
				return
			end

			flag = true
			Position = input.Position
			Position1 = v4.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					flag = false
				end
			end)
		end)

		table.insert(tbl6.Connections, connection1)

		local connection2 = UserInputService.InputChanged:Connect(function(input)
			if not flag then
				return
			end

			if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then
				return
			end

			local v1 = input.Position - Position
			v4.Position = UDim2.new(Position1.X.Scale, Position1.X.Offset + v1.X, Position1.Y.Scale, Position1.Y.Offset + v1.Y)
		end)

		table.insert(tbl6.Connections, connection2)
	end

	local tbl2 = {FPS = tbl1.AddFPS, Ping = tbl1.AddPing, Time = tbl1.AddTime, Player = tbl1.AddPlayer}

	for _, v9 in ipairs(v1.Items or {"FPS", "Ping"}) do
		if type(v9) == "string" and tbl2[v9] then
			tbl2[v9](tbl1)
		elseif type(v9) == "table" then
			tbl1:Add(v9.Name or v9.Title, v9.Value)
		end
	end

	local v10 = v1.Interval or 0.5

	task.spawn(function()
		while not tbl1.Dead do
			for _, item in ipairs(tbl1.Items) do
				item.Refresh()
			end
			task.wait(v10)
		end
	end)

	arg1.WatermarkApi = tbl1
	return tbl1
end

function tbl6:Notify(arg2, arg3, arg4)
	local v1 = arg2

	if self.NotificationsEnabled == false then
		return
	end

	if type(arg2) == "string" then
		v1 = {Title = arg2, Text = arg3, Duration = arg4}
	end

	local v2 = v1 or {}
	v2.Text = v2.Text or v2.Content or v2.Description
	local v3 = v2.Color ~= nil or type(v2.Style) == "string" and string.lower(v2.Style) ~= "normal"
	local v4 = v2.Color or func22(v2.Style, tbl.Accent)
	local Icon = v2.Icon

	if Icon == nil and type(v2.Style) == "string" then
		local v5 = string.lower(v2.Style)
		if v5 == "warning" or v5 == "warn" or v5 == "yellow" then
			Icon = "alert-triangle"
		elseif v5 == "danger" or v5 == "error" or v5 == "red" then
			Icon = "x-circle"
		elseif v5 == "success" or v5 == "green" then
			Icon = "check-circle"
		end
	end

	if not self.NotifyGui then
		local v6 = func8("ScreenGui", {
			Name = func(),
			ResetOnSpawn = false,
			IgnoreGuiInset = true,
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
			AutoLocalize = false,
			DisplayOrder = 2147483637,
		})

		func2(v6)

		local v7 = func8("Frame", {
			Size = UDim2.fromOffset(260, 400),
			AnchorPoint = Vector2.new(1, 1),
			Position = UDim2.new(1, -18, 1, -18),
			BackgroundTransparency = 1,
			Parent = v6,
		})

		local v8 = func12(v7, 8)
		v8.VerticalAlignment = Enum.VerticalAlignment.Bottom
		v8.HorizontalAlignment = Enum.HorizontalAlignment.Right
		self.NotifyGui = v6
		self.NotifyHolder = v7
	end

	local v9 = self.NotificationLimit or 5
	local tbl1 = {}

	for _, child in ipairs(self.NotifyHolder:GetChildren()) do
		if child:IsA("Frame") then
			table.insert(tbl1, child)
		end
	end

	for i = 1, tonumber(#tbl1 - (v9 - 1)) do
		pcall(function()
			tbl1[i]:Destroy()
		end)
	end

	local v10 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = tbl.Section,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Parent = self.NotifyHolder,
		ThemeTag = {BackgroundColor3 = "Section"},
	})

	func9(v10, 6)
	local v11 = func10(v10, tbl.SectionBorder, 1, 1)

	local v12 = func8("Frame", {
		Size = UDim2.new(0, 12, 1, 0),
		Position = UDim2.fromOffset(0, 0),
		BackgroundColor3 = v4,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Parent = v10,
	})

	func9(v12, 6)

	local v13 = func8("Frame", {
		Size = UDim2.new(0, 9, 1, 0),
		Position = UDim2.fromOffset(3, 0),
		BackgroundColor3 = tbl.Section,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Parent = v10,
		ThemeTag = {BackgroundColor3 = "Section"},
	})

	local v14 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = v10,
	})

	func11(v14, 10, 12, 10, 14)
	func12(v14, 3)
	local v15 = func8("Frame", {Size = UDim2.new(1, 0, 0, 16), BackgroundTransparency = 1, Parent = v14})
	local v16 = func26(v15, Icon, v4, 14)

	if v16 then
		v16.ImageTransparency = 1
	end

	local v17 = v16 and 19 or 0
	local v18 = func13(v15, v2.Title or "notice", v3 and v4 or tbl.TextBright, 13, tbl.FontMedium)
	v18.Position = UDim2.fromOffset(v17, 0)
	v18.Size = UDim2.new(1, -v17, 1, 0)
	v18.TextTransparency = 1
	local v19

	if v2.Text then
		v19 = func13(v14, v2.Text, tbl.Text, 12)
		v19.Size = UDim2.new(1, 0, 0, 0)
		v19.AutomaticSize = Enum.AutomaticSize.Y
		v19.TextWrapped = true
		v19.LayoutOrder = 2
		v19.TextTransparency = 1
	end

	v10.Position = UDim2.new(1, 0, 0, 0)
	v10.BackgroundTransparency = 0
	func14(v10, {Position = UDim2.fromOffset(0, 0)})
	func14(v11, {Transparency = 0})
	func14(v12, {BackgroundTransparency = 0})
	func14(v13, {BackgroundTransparency = 0})
	func14(v18, {TextTransparency = 0})

	if v16 then
		func14(v16, {ImageTransparency = 0})
	end

	if v19 then
		func14(v19, {TextTransparency = 0})
	end

	task.delay(v2.Duration or 3.5, function()
		if not v10.Parent then
			return
		end

		func14(v10, {BackgroundTransparency = 1, Position = UDim2.fromOffset(20, 0)})
		func14(v11, {Transparency = 1})
		func14(v12, {BackgroundTransparency = 1})
		func14(v13, {BackgroundTransparency = 1})
		func14(v18, {TextTransparency = 1})

		if v16 then
			func14(v16, {ImageTransparency = 1})
		end

		if v19 then
			func14(v19, {TextTransparency = 1})
		end

		func14(v10, {Position = UDim2.new(0, 20, 0, 0)})
		task.wait(0.22)
		v10:Destroy()
	end)
end

local tbl15 = {
	MB1 = Enum.UserInputType.MouseButton1,
	MB2 = Enum.UserInputType.MouseButton2,
	MB3 = Enum.UserInputType.MouseButton3,
}

function tbl6.SetToggleKey(arg1, toggleKey)
	arg1.ToggleKey = nil
	arg1.ToggleInput = nil

	if typeof(toggleKey) == "EnumItem" then
		if toggleKey.EnumType == Enum.UserInputType then
			arg1.ToggleInput = toggleKey
		else
			arg1.ToggleKey = toggleKey
		end
	elseif type(toggleKey) == "string" then
		if tbl15[toggleKey] then
			arg1.ToggleInput = tbl15[toggleKey]
		else
			local ok, result = pcall(function()
				return Enum.KeyCode[toggleKey]
			end)
			arg1.ToggleKey = ok and result or nil
		end
	end

	return arg1.ToggleKey or arg1.ToggleInput
end

tbl6.Panels = {}

function tbl6.Panel(arg1, arg2)
	local v1 = arg2 or {}

	local v2 = func8("ScreenGui", {
		Name = func(),
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		AutoLocalize = false,
		DisplayOrder = v1.DisplayOrder or 2147483617,
	})

	func2(v2)
	v2.Name = func()
	local v3 = func8("Frame", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Parent = v2})
	local v4 = func8("UIScale", {Parent = v3})

	local v5 = func8("Frame", {
		Size = v1.Height and UDim2.fromOffset(v1.Width or 180, v1.Height) or UDim2.new(0, v1.Width or 180, 0, 0),
		AutomaticSize = not v1.Height and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
		Position = v1.Position or UDim2.fromOffset(18, 90),
		BackgroundColor3 = tbl.Section,
		BorderSizePixel = 0,
		Active = true,
		Parent = v3,
		ThemeTag = {BackgroundColor3 = "Section"},
	})

	func9(v5, 8)
	func10(v5, tbl.SectionBorder)

	local v6 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = v5,
	})

	func12(v6, 0)
	local v11
	local v12

	if v1.Title then
		local v7 = func8("Frame", {Size = UDim2.new(1, 0, 0, 32), BackgroundTransparency = 1, Parent = v6})
		func11(v7, 0, 11, 0, 11)
		local v8 = func26(v7, v1.Icon, tbl.TextBright, 14)

		if v8 then
			v8.AnchorPoint = Vector2.new(0, 0.5)
			v8.Position = UDim2.new(0, 0, 0.5, 0)
		end

		local v9 = v8 and 20 or 0
		local v10 = func13(v7, v1.Title, tbl.TextBright, tbl.TextSize, tbl.FontMedium)
		v10.Position = UDim2.fromOffset(v9, 0)
		v10.Size = UDim2.new(1, -v9 - 16, 1, 0)
		v11 = func15(v7, tbl.TextDim)
		v11.AnchorPoint = Vector2.new(1, 0.5)
		v11.Position = UDim2.new(1, 0, 0.5, 0)

		v12 = func8("TextButton", {
			Size = UDim2.fromOffset(26, 26),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, 6, 0.5, 0),
			BackgroundTransparency = 1,
			AutoButtonColor = false,
			Text = "",
			ZIndex = 2,
			Parent = v7,
		})

		func8("Frame", {
			Size = UDim2.new(1, 0, 0, 1),
			BackgroundColor3 = tbl.BorderSoft,
			BorderSizePixel = 0,
			LayoutOrder = 2,
			Parent = v6,
			ThemeTag = {BackgroundColor3 = "BorderSoft"},
		})
	end

	local v13 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		LayoutOrder = 3,
		Parent = v6,
	})

	func11(v13, v1.Title and 9 or 11, 11, 11, 11)
	func12(v13, 8)
	local v14 = func8("Frame", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 300, Parent = v3})

	local v15 = func8("TextButton", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Text = "",
		Visible = false,
		ZIndex = 110,
		Parent = v14,
	})

	local v16 = setmetatable({
		Gui = v2,
		Frame = v5,
		Main = v3,
		Scale = v4,
		Overlay = v14,
		Blocker = v15,
		FloatStack = {},
		Modals = {},
	}, {__index = tbl13})

	local tbl1 = {Window = v16, Container = v13}
	tbl1.Float = nil
	v16.Content = setmetatable(tbl1, tbl8)
	v16.Open = true

	function v16:SetOpen(arg2)
		local v1 = arg2 ~= false

		if v1 == self.Open then
			return
		end

		self.Open = v1
		self:CloseFloating()

		if v1 then
			v13.Visible = true
			v13.Size = UDim2.new(1, 0, 0, 0)
			v13.AutomaticSize = Enum.AutomaticSize.Y
			local Y = v13.AbsoluteSize.Y
			v13.AutomaticSize = Enum.AutomaticSize.None
			v13.Size = UDim2.new(1, 0, 0, 0)

			func14(v13, {Size = UDim2.new(1, 0, 0, Y)}).Completed:Once(function()
				if self.Open then
					v13.AutomaticSize = Enum.AutomaticSize.Y
				end
			end)
		else
			local Y1 = v13.AbsoluteSize.Y
			v13.AutomaticSize = Enum.AutomaticSize.None
			v13.Size = UDim2.new(1, 0, 0, Y1)

			func14(v13, {Size = UDim2.new(1, 0, 0, 0)}).Completed:Once(function()
				if not self.Open then
					v13.Visible = false
				end
			end)
		end

		if v11 then
			func14(v11, {Rotation = v1 and 0 or 180}, tweenInfo1)
		end

		return self
	end

	function v16:Toggle()
		return self:SetOpen(not self.Open)
	end

	if v12 then
		local connection = v12.Activated:Connect(function()
			v16:Toggle()
		end)

		table.insert(tbl6.Connections, connection)

		local connection1 = v12.MouseEnter:Connect(function()
			for _, child in ipairs(v11:GetChildren()) do
				if child:IsA("Frame") then
					TweenService:Create(child, tweenInfo1 or tweenInfo, {BackgroundColor3 = tbl.AccentSoft}):Play()
				end
			end
		end)

		table.insert(tbl6.Connections, connection1)

		local connection2 = v12.MouseLeave:Connect(function()
			for _, child in ipairs(v11:GetChildren()) do
				if child:IsA("Frame") then
					TweenService:Create(child, tweenInfo1 or tweenInfo, {BackgroundColor3 = tbl.TextDim}):Play()
				end
			end
		end)

		table.insert(tbl6.Connections, connection2)
	end

	local connection3 = v15.Activated:Connect(function()
		v16:CloseFloating()
	end)

	table.insert(tbl6.Connections, connection3)

	function v16:SetVisible(arg2)
		if not arg2 then
			self:CloseFloating()
		end
		v2.Enabled = arg2 and true or false
	end

	function v16.SetPosition(_, position)
		v5.Position = position
	end

	function v16:Destroy()
		self:CloseFloating()
		v2:Destroy()

		for i, panel in ipairs(tbl6.Panels) do
			if panel == v16 then
				table.remove(tbl6.Panels, i)
				break
			end
		end
	end

	if v1.Draggable ~= false then
		local Position
		local Position1
		local connection5
		local connection6

		local connection4 = v5.InputBegan:Connect(function(input)
			if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
				return
			end

			Position = input.Position
			Position1 = v5.Position

			connection5 = UserInputService.InputChanged:Connect(function(input)
				if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then
					return
				end

				local v1 = input.Position - Position
				v5.Position = UDim2.new(Position1.X.Scale, Position1.X.Offset + v1.X, Position1.Y.Scale, Position1.Y.Offset + v1.Y)
			end)

			connection6 = UserInputService.InputEnded:Connect(function(input1)
				if input1.UserInputType ~= input.UserInputType then
					return
				end

				if connection5 then
					connection5:Disconnect()
					connection5 = nil
				end

				if connection6 then
					connection6:Disconnect()
					connection6 = nil
				end
			end)
		end)

		table.insert(tbl6.Connections, connection4)
	end

	if v1.Visible == false then
		v16:SetVisible(false)
	end

	if v1.Collapsed then
		v16:SetOpen(false)
	end

	table.insert(arg1.Panels, v16)
	return v16
end

tbl6.HotkeyEntries = {}
tbl6.HotkeysEnabled = false

function tbl6:RegisterHotkey(arg2)
	table.insert(self.HotkeyEntries, arg2)
	self:RefreshHotkeys()
	return arg2
end

function tbl6:CreateHotkeyPanel(arg2)
	if self.HotkeyGui then
		return self.HotkeyPanel
	end

	local v1 = arg2 or {}

	local v2 = func8("ScreenGui", {
		Name = func(),
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		AutoLocalize = false,
		DisplayOrder = 2147483627,
		Enabled = false,
	})

	func2(v2)

	local v3 = func8("Frame", {
		Size = UDim2.fromOffset(v1.Width or 180, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Position = v1.Position or UDim2.fromOffset(18, 90),
		BackgroundColor3 = tbl.Section,
		BorderSizePixel = 0,
		Active = true,
		Parent = v2,
		ThemeTag = {BackgroundColor3 = "Section"},
	})

	func9(v3, 8)
	func10(v3, tbl.SectionBorder)

	local v4 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = v3,
	})

	func12(v4, 0)
	local v5 = func8("Frame", {Size = UDim2.new(1, 0, 0, 32), BackgroundTransparency = 1, Parent = v4})
	func11(v5, 0, 11, 0, 11)
	local v6 = func26(v5, v1.Icon or "keyboard", tbl.TextBright, 14)
	local v7 = v6 and 20 or 0

	if v6 then
		v6.AnchorPoint = Vector2.new(0, 0.5)
		v6.Position = UDim2.new(0, 0, 0.5, 0)
	end

	local v8 = func13(v5, v1.Title or "hotkeys", tbl.TextBright, tbl.TextSize, tbl.FontMedium)
	v8.Position = UDim2.fromOffset(v7, 0)
	v8.Size = UDim2.new(1, -v7, 1, 0)

	func8("Frame", {
		Size = UDim2.new(1, 0, 0, 1),
		BackgroundColor3 = tbl.BorderSoft,
		BorderSizePixel = 0,
		LayoutOrder = 2,
		Parent = v4,
		ThemeTag = {BackgroundColor3 = "BorderSoft"},
	})

	local v9 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = 3,
		Parent = v4,
	})

	func11(v9, 8, 11, 9, 11)

	local v10 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = v9,
	})

	func12(v10, 4)
	local Position
	local Position1
	local connection1
	local connection2

	local connection = v3.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		Position = input.Position
		Position1 = v3.Position

		connection1 = UserInputService.InputChanged:Connect(function(input)
			if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then
				return
			end

			local v1 = input.Position - Position
			v3.Position = UDim2.new(Position1.X.Scale, Position1.X.Offset + v1.X, Position1.Y.Scale, Position1.Y.Offset + v1.Y)
		end)

		connection2 = UserInputService.InputEnded:Connect(function(input1)
			if input1.UserInputType ~= input.UserInputType then
				return
			end

			if connection1 then
				connection1:Disconnect()
				connection1 = nil
			end

			if connection2 then
				connection2:Disconnect()
				connection2 = nil
			end
		end)
	end)

	table.insert(tbl6.Connections, connection)
	self.HotkeyGui = v2
	self.HotkeyPanel = v3
	self.HotkeyRows = v10
	return v3
end

function tbl6:RefreshHotkeys()
	if not self.HotkeyGui or not self.HotkeysEnabled then
		return
	end

	local HotkeyRows = self.HotkeyRows
	local num = 0

	for _, child in ipairs(HotkeyRows:GetChildren()) do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end

	for i = #self.HotkeyEntries, 1, -1 do
		local ok, result = pcall(self.HotkeyEntries[i])
		if not ok then
			table.remove(self.HotkeyEntries, i)
		elseif type(result) == "table" and result.Visible and result.Key and result.Key ~= "" then
			num = num + 1
			local v1 = result.Active and tbl.Accent or tbl.TextDim

			local v2 = func8(
				"Frame",
				{Size = UDim2.new(1, 0, 0, 16), BackgroundTransparency = 1, LayoutOrder = num, Parent = HotkeyRows}
			)

			local v3 = func13(v2, result.Label or "action", v1, tbl.TextSize - 1)
			v3.Size = UDim2.new(1, -52, 1, 0)
			v3.TextTruncate = Enum.TextTruncate.AtEnd
			local v4 = func13(v2, result.Key, v1, tbl.TextSize - 1)
			v4.AnchorPoint = Vector2.new(1, 0)
			v4.Position = UDim2.fromScale(1, 0)
			v4.Size = UDim2.fromOffset(50, 16)
			v4.TextXAlignment = Enum.TextXAlignment.Right
		end
	end

	self.HotkeyPanel.Visible = num > 0
end

function tbl6.SetHotkeysVisible(arg1, arg2)
	arg1.HotkeysEnabled = arg2 and true or false

	if arg1.HotkeysEnabled then
		arg1:CreateHotkeyPanel()
	end

	if arg1.HotkeyGui then
		arg1.HotkeyGui.Enabled = arg1.HotkeysEnabled
	end

	arg1:RefreshHotkeys()
	return arg1.HotkeysEnabled
end

tbl6.CursorEnabled = false

function tbl6:CreateCursor(arg2)
	if self.CursorGui then
		return self.CursorGui
	end

	local v1 = arg2 or {}
	local v2 = v1.Length or 9
	local v3 = v1.Thickness or 2
	local v4 = v1.Gap or 4

	local v5 = func8("ScreenGui", {
		Name = func(),
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		AutoLocalize = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 2147483647,
		Enabled = false,
	})

	func2(v5)

	local v6 = func8("Frame", {
		Size = UDim2.fromOffset(1, 1),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Parent = v5,
	})

	local function func1(arg1, arg2, arg3)
		local v2 = func8("Frame", {
			Size = arg3,
			AnchorPoint = arg1,
			Position = arg2,
			BackgroundColor3 = v1.Color or tbl.Accent,
			BorderSizePixel = 0,
			Parent = v6,
		})

		func9(v2, 1)
		return v2
	end

	func1(Vector2.new(1, 0.5), UDim2.new(0.5, -v4, 0.5, 0), UDim2.fromOffset(v2, v3))
	func1(Vector2.new(0, 0.5), UDim2.new(0.5, v4, 0.5, 0), UDim2.fromOffset(v2, v3))
	func1(Vector2.new(0.5, 1), UDim2.new(0.5, 0, 0.5, -v4), UDim2.fromOffset(v3, v2))
	func1(Vector2.new(0.5, 0), UDim2.new(0.5, 0, 0.5, v4), UDim2.fromOffset(v3, v2))

	if v1.Dot ~= false then
		func1(Vector2.new(0.5, 0.5), UDim2.fromScale(0.5, 0.5), UDim2.fromOffset(v3, v3))
	end

	local function func3()
		if not v5.Enabled then
			return
		end

		local MouseLocation = UserInputService:GetMouseLocation()

		if not v5.IgnoreGuiInset then
			MouseLocation = MouseLocation - GuiService:GetGuiInset()
		end

		v6.Position = UDim2.fromOffset(MouseLocation.X, MouseLocation.Y)
	end

	local connection = UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			func3()
		end
	end)

	table.insert(tbl6.Connections, connection)
	local v7 = "FacilityCursor_" .. func(6)

	pcall(function()
		RunService:BindToRenderStep(v7, Enum.RenderPriority.Last.Value, func3)
	end)

	self.CursorBind = v7
	self.CursorGui = v5
	self.CursorHolder = v6
	return v5
end

function tbl6:RefreshCursor()
	if not self.CursorGui then
		return
	end
	self.CursorGui.Enabled = self.CursorEnabled and self.Open
end

function tbl6:SetCursor(arg2, arg3)
	self.CursorEnabled = arg2 and true or false

	if self.CursorEnabled then
		self:CreateCursor(arg3)
	end

	self:RefreshCursor()
	return self.CursorEnabled
end

function tbl6.ServerBrowser(arg1, arg2)
	if arg1.ServerBrowserApi then
		return arg1.ServerBrowserApi
	end

	local v1 = arg2 or {}
	local HttpService = game:GetService("HttpService")
	local TeleportService = game:GetService("TeleportService")
	local LocalPlayer = Players.LocalPlayer
	local v2 = v1.PlaceId or game.PlaceId

	local v3 = func8("ScreenGui", {
		Name = func(),
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		AutoLocalize = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 2147483622,
		Enabled = false,
	})

	func2(v3)

	local v4 = func8("Frame", {
		Size = UDim2.fromOffset(v1.Width or 340, v1.Height or 420),
		Position = v1.Position or UDim2.new(0.5, -170, 0.5, -210),
		BackgroundColor3 = tbl.Window,
		BorderSizePixel = 0,
		Active = true,
		Parent = v3,
		ThemeTag = {BackgroundColor3 = "Window"},
	})

	func9(v4, 10)
	func10(v4, tbl.WindowBorder)

	local v5 = func8("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.new(1, 35, 1.096, 35),
		Position = UDim2.fromScale(0.5, 0.5),
		BackgroundTransparency = 1,
		Parent = v4,
	})

	func8("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		ZIndex = 0,
		Image = "rbxassetid://5587865193",
		ImageColor3 = Color3.fromRGB(20, 20, 20),
		Size = UDim2.new(1.6, 0, 1.3, 0),
		Position = UDim2.fromScale(0.5, 0.5),
		ImageTransparency = 0.5,
		Parent = v5,
	})

	local v6 = func8("Frame", {
		Size = UDim2.new(1, 0, 0, 40),
		BackgroundColor3 = tbl.TopBar,
		BorderSizePixel = 0,
		Parent = v4,
		ThemeTag = {BackgroundColor3 = "TopBar"},
	})

	func9(v6, 10)

	func8("Frame", {
		Size = UDim2.new(1, 0, 0, 12),
		Position = UDim2.fromOffset(0, 28),
		BackgroundColor3 = tbl.TopBar,
		BorderSizePixel = 0,
		Parent = v6,
		ThemeTag = {BackgroundColor3 = "TopBar"},
	})

	func8("Frame", {
		Size = UDim2.new(1, 0, 0, 1),
		Position = UDim2.fromOffset(0, 39),
		BackgroundColor3 = tbl.BorderSoft,
		BorderSizePixel = 0,
		Parent = v6,
		ThemeTag = {BackgroundColor3 = "BorderSoft"},
	})

	local v7 = func13(v6, v1.Title or "servers", tbl.TextBright, tbl.TextSize + 1, tbl.FontMedium)
	v7.Position = UDim2.fromOffset(14, 0)
	v7.Size = UDim2.new(1, -90, 1, 0)
	local v8 = func13(v6, "", tbl.TextDim, 11)
	v8.AnchorPoint = Vector2.new(1, 0.5)
	v8.Position = UDim2.new(1, -66, 0.5, 0)
	v8.Size = UDim2.fromOffset(120, 14)
	v8.TextXAlignment = Enum.TextXAlignment.Right

	local v9 = func8("TextButton", {
		Size = UDim2.fromOffset(22, 22),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -38, 0.5, 0),
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Text = "",
		Parent = v6,
	})

	local v10 = func26(v9, "refresh-cw", tbl.TextDim, 15)

	if v10 then
		v10.AnchorPoint = Vector2.new(0.5, 0.5)
		v10.Position = UDim2.fromScale(0.5, 0.5)
	end

	local v11 = func8("TextButton", {
		Size = UDim2.fromOffset(22, 22),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -12, 0.5, 0),
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Text = "",
		Parent = v6,
	})

	local tbl1 = {}

	for i = 1, 2 do
		local v12 = func8("Frame", {
			Size = UDim2.fromOffset(13, 2),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Rotation = i == 1 and 45 or -45,
			BackgroundColor3 = tbl.TextDim,
			BorderSizePixel = 0,
			Parent = v11,
			ThemeTag = {BackgroundColor3 = "TextDim"},
		})

		func8("UICorner", {CornerRadius = UDim.new(0, 1), Parent = v12})
		func8("UICorner", {CornerRadius = UDim.new(0, 1), Parent = v12})
		tbl1[i] = v12
	end

	local tbl2 = {
		Size = UDim2.new(1, -20, 1, -54),
		Position = UDim2.fromOffset(10, 48),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		CanvasSize = UDim2.new(),
	}

	tbl2.AutomaticCanvasSize = Enum.AutomaticSize.Y
	tbl2.ScrollBarThickness = 3
	tbl2.ScrollBarImageColor3 = tbl.AccentDim
	tbl2.ScrollBarImageTransparency = 0.3
	tbl2.VerticalScrollBarInset = Enum.ScrollBarInset.None
	tbl2.Parent = v4
	tbl2.ThemeTag = {ScrollBarImageColor3 = "AccentDim"}
	local v13 = func8("ScrollingFrame", tbl2)
	func12(v13, 6)
	func11(v13, 2, 8, 2, 2)
	local tbl3 = {Gui = v3, Frame = v4, Open = false}
	local flag = false

	local function func1()
		for _, child in ipairs(v13:GetChildren()) do
			if child:IsA("Frame") then
				child:Destroy()
			end
		end
	end

	local function func3(arg1, arg2)
		local v3 = func8("Frame", {
			Size = UDim2.new(1, 0, 0, 44),
			BackgroundColor3 = tbl.Section,
			BorderSizePixel = 0,
			LayoutOrder = arg2,
			Parent = v13,
			ThemeTag = {BackgroundColor3 = "Section"},
		})

		func9(v3, 6)
		func10(v3, tbl.SectionBorder)
		local v4 = func13(v3, string.format("%d / %d players", arg1.playing or 0, arg1.maxPlayers or 0), tbl.TextBright)
		v4.Position = UDim2.fromOffset(12, 6)
		v4.Size = UDim2.new(1, -90, 0, 16)
		local v5 = arg1.ping or 0
		local TextCode = tbl.TextCode

		if v5 > 150 then
			TextCode = tbl.Danger
		elseif v5 > 80 then
			TextCode = tbl.TextMarked
		end

		local v6 = func13(v3, string.format("%d ms  -  %d fps", math.floor(v5), math.floor(arg1.fps or 0)), TextCode, 11)
		v6.Position = UDim2.fromOffset(12, 23)
		v6.Size = UDim2.new(1, -90, 0, 14)

		local v7 = func8("Frame", {
			Size = UDim2.fromOffset(62, 26),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -10, 0.5, 0),
			BackgroundColor3 = tbl.Accent,
			BorderSizePixel = 0,
			Parent = v3,
			ThemeTag = {BackgroundColor3 = "Accent"},
		})

		func9(v7, 6)

		local connection = func8("TextButton", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			AutoButtonColor = false,
			Text = "join",
			TextColor3 = Color3.fromRGB(40, 32, 34),
			TextSize = tbl.TextSize,
			Font = tbl.FontMedium,
			Parent = v7,
		}).Activated:Connect(function()
			tbl6:Notify(v1.Title or "servers", "teleporting...", 3)

			if v1.OnJoin then
				tbl6:SafeCallback("server browser", v1.OnJoin, arg1.id, v2, arg1)
				return
			end

			local ok, result = pcall(function()
				TeleportService:TeleportToPlaceInstance(v2, arg1.id, LocalPlayer)
			end)

			if not ok then
				tbl6:Error(v1.Title or "servers", tostring(result), 6)
			end
		end)

		table.insert(tbl6.Connections, connection)
	end

	local function func4()
		if flag then
			return
		end

		flag = true
		v8.Text = "loading..."
		func1()

		task.spawn(function()
			local ok, result = pcall(function()
				return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. v2 .. "/servers/Public?sortOrder=Asc&limit=100"))
			end)

			if not ok or type(result) ~= "table" or type(result.data) ~= "table" then
				v8.Text = "request failed"
				flag = false
				return
			end

			local tbl = {}

			for _, v3 in ipairs(result.data) do
				if v2 ~= game.PlaceId or v3.id ~= game.JobId then
					table.insert(tbl, v3)
				end
			end

			table.sort(tbl, function(a, b)
				return (a.ping or 999) < (b.ping or 999)
			end)

			local num = 0

			for _, v4 in ipairs(tbl) do
				num = num + 1
				func3(v4, num)

				if num >= (v1.MaxRows or 40) then
					break
				end
			end

			v8.Text = num .. " servers"
			flag = false
		end)
	end

	local connection = v9.Activated:Connect(func4)
	table.insert(tbl6.Connections, connection)

	local connection1 = v9.MouseEnter:Connect(function()
		if v10 then
			TweenService:Create(v10, tweenInfo1 or tweenInfo, {ImageColor3 = tbl.Accent}):Play()
		end
	end)

	table.insert(tbl6.Connections, connection1)

	local connection2 = v9.MouseLeave:Connect(function()
		if v10 then
			TweenService:Create(v10, tweenInfo1 or tweenInfo, {ImageColor3 = tbl.TextDim}):Play()
		end
	end)

	table.insert(tbl6.Connections, connection2)

	local connection3 = v11.Activated:Connect(function()
		tbl3:SetVisible(false)
	end)

	table.insert(tbl6.Connections, connection3)

	local connection4 = v11.MouseEnter:Connect(function()
		for _, v1 in ipairs(tbl1) do
			TweenService:Create(v1, tweenInfo1 or tweenInfo, {BackgroundColor3 = tbl.Danger}):Play()
		end
	end)

	table.insert(tbl6.Connections, connection4)

	local connection5 = v11.MouseLeave:Connect(function()
		for _, v1 in ipairs(tbl1) do
			TweenService:Create(v1, tweenInfo1 or tweenInfo, {BackgroundColor3 = tbl.TextDim}):Play()
		end
	end)

	table.insert(tbl6.Connections, connection5)
	local flag1 = false
	local Position
	local Position1
	local v14

	local connection6 = v6.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		if flag1 then
			return
		end

		flag1 = true
		v14 = input
		Position = input.Position
		Position1 = v4.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				flag1 = false
				v14 = nil
			end
		end)
	end)

	table.insert(tbl6.Connections, connection6)

	local connection7 = UserInputService.InputChanged:Connect(function(input)
		if not flag1 then
			return
		end

		if input ~= v14 and input.UserInputType ~= Enum.UserInputType.MouseMovement then
			return
		end

		if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		local v1 = input.Position - Position
		v4.Position = UDim2.new(Position1.X.Scale, Position1.X.Offset + v1.X, Position1.Y.Scale, Position1.Y.Offset + v1.Y)
	end)

	table.insert(tbl6.Connections, connection7)

	function tbl3:SetVisible(arg2)
		self.Open = arg2 and true or false
		v3.Enabled = self.Open

		if self.Open and #v13:GetChildren() <= 2 then
			func4()
		end
	end

	function tbl3:Toggle()
		self:SetVisible(not self.Open)
	end

	function tbl3.Refresh(_)
		func4()
	end

	arg1.ServerBrowserApi = tbl3
	return tbl3
end

function tbl6:ToggleUI(arg2)
	local v1 = arg2

	if arg2 == nil then
		v1 = not self.Open
	end

	self.Open = v1

	for _, window in ipairs(self.Windows) do
		window:SetVisible(v1)
	end

	self:RefreshCursor()
	return self.Open
end

function tbl6:CreateMobileButton(arg2)
	if self.MobileGui then
		return self.MobileButton
	end

	local v1 = arg2 or {}

	local v2 = func8("ScreenGui", {
		Name = func(),
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		AutoLocalize = false,
		DisplayOrder = 2147483632,
	})

	func2(v2)

	local v3 = func8("TextButton", {
		Size = UDim2.fromOffset(v1.Size or 44, v1.Size or 44),
		Position = v1.Position or UDim2.new(0, 18, 0.5, -22),
		BackgroundColor3 = tbl.Section,
		AutoButtonColor = false,
		Text = "",
		BorderSizePixel = 0,
		Parent = v2,
		ThemeTag = {BackgroundColor3 = "Section"},
	})

	func8("UICorner", {CornerRadius = UDim.new(0, 12), Parent = v3})
	func8("UICorner", {CornerRadius = UDim.new(0, 12), Parent = v3})
	func10(v3, tbl.Border)

	for i = 1, 3 do
		local v4 = func8("Frame", {
			Size = UDim2.fromOffset(18, 2),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, (i - 2) * 6),
			BackgroundColor3 = tbl.Accent,
			BorderSizePixel = 0,
			Parent = v3,
			ThemeTag = {BackgroundColor3 = "Accent"},
		})

		func8("UICorner", {CornerRadius = UDim.new(0, 1), Parent = v4})
		func8("UICorner", {CornerRadius = UDim.new(0, 1), Parent = v4})
	end

	local flag1
	local Position
	local Position1
	local connection1
	local connection2
	local flag = false
	local num = 0

	local connection = v3.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		if flag then
			return
		end

		flag = true
		flag1 = false
		Position = input.Position
		Position1 = v3.Position
		TweenService:Create(v3, tweenInfo1 or tweenInfo, {BackgroundColor3 = tbl.FieldHover}):Play()

		connection1 = UserInputService.InputChanged:Connect(function(input)
			if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then
				return
			end

			local v1 = input.Position - Position

			if math.abs(v1.X) > 6 or math.abs(v1.Y) > 6 then
				flag1 = true
			end

			v3.Position = UDim2.new(Position1.X.Scale, Position1.X.Offset + v1.X, Position1.Y.Scale, Position1.Y.Offset + v1.Y)
		end)

		connection2 = UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
				return
			end

			if connection1 then
				connection1:Disconnect()
				connection1 = nil
			end

			if connection2 then
				connection2:Disconnect()
				connection2 = nil
			end

			flag = false
			TweenService:Create(v3, tweenInfo1 or tweenInfo, {BackgroundColor3 = tbl.Section}):Play()

			if not flag1 and tick() - num > 0.25 then
				num = tick()
				tbl6:ToggleUI()
			end
		end)
	end)

	table.insert(tbl6.Connections, connection)
	self.MobileGui = v2
	self.MobileButton = v3
	return v3
end

function tbl6.SetMobileButtonVisible(arg1, arg2)
	if not arg1.MobileGui then
		if not arg2 then
			return
		end
		arg1:CreateMobileButton()
	end
	arg1.MobileGui.Enabled = arg2 and true or false
end

local connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed or tbl6.Binding then
		return
	end
	if tbl6.ToggleKey ~= nil and input.KeyCode == tbl6.ToggleKey or tbl6.ToggleInput ~= nil and input.UserInputType == tbl6.ToggleInput then
		tbl6:ToggleUI()
	end
end)

table.insert(tbl6.Connections, connection)

function tbl6:Destroy()
	if self.WatermarkApi then
		pcall(function()
			self.WatermarkApi:Destroy()
		end)
	end

	pcall(function()
		self:StopBlur()
	end)

	func7()
	self.Glass = false

	if self.MouseBind then
		pcall(function()
			RunService:UnbindFromRenderStep(self.MouseBind)
		end)
		self.MouseBind = nil
	end

	self:ReleaseMouse()

	for _, connection in ipairs(self.Connections) do
		pcall(function()
			connection:Disconnect()
		end)
	end

	table.clear(self.Connections)

	for _, window in ipairs(self.Windows) do
		window.Gui:Destroy()
	end

	table.clear(self.Windows)

	if self.NotifyGui then
		self.NotifyGui:Destroy()
		self.NotifyGui = nil
	end

	if self.MobileGui then
		self.MobileGui:Destroy()
		self.MobileGui = nil
		self.MobileButton = nil
	end

	if self.CursorBind then
		pcall(function()
			RunService:UnbindFromRenderStep(self.CursorBind)
		end)
		self.CursorBind = nil
	end

	if self.CursorGui then
		self.CursorGui:Destroy()
		self.CursorGui = nil
		self.CursorHolder = nil
	end

	if self.ServerBrowserApi then
		pcall(function()
			self.ServerBrowserApi.Gui:Destroy()
		end)
		self.ServerBrowserApi = nil
	end

	if self.HotkeyGui then
		self.HotkeyGui:Destroy()
		self.HotkeyGui = nil
		self.HotkeyPanel = nil
	end

	for i = #self.Panels, 1, -1 do
		pcall(function()
			self.Panels[i].Gui:Destroy()
		end)
		self.Panels[i] = nil
	end

	table.clear(self.HotkeyEntries)
	table.clear(self.Registry)
	table.clear(self.Flags)
end

game:GetService("HttpService")
local tbl16 = {}
tbl16.Memory = {}
tbl16.Native = typeof(writefile) == "function" and typeof(readfile) == "function"

function tbl16:MakeFolder(arg2)
	if not self.Native then
		return
	end
	if typeof(makefolder) == "function" and typeof(isfolder) == "function" then
		local ok, result = pcall(isfolder, arg2)
		if ok and not result then
			pcall(makefolder, arg2)
		end
	end
end

function tbl16.Write(arg1, arg2, arg3)
	if arg1.Native and pcall(writefile, arg2, arg3) then
		arg1.Memory[arg2] = nil
		return true
	end

	arg1.Memory[arg2] = arg3
	return true
end

function tbl16.Read(arg1, arg2)
	if arg1.Native and typeof(isfile) == "function" then
		local ok, result = pcall(isfile, arg2)
		if ok and result then
			local ok1, result1 = pcall(readfile, arg2)
			if ok1 then
				return result1
			end
		end
	end
	return arg1.Memory[arg2]
end

function tbl16.Delete(arg1, arg2)
	if arg1.Native and typeof(delfile) == "function" then
		pcall(delfile, arg2)
	end
	arg1.Memory[arg2] = nil
end

function tbl16.List(arg1, arg2)
	local tbl = {}
	local tbl1 = {}

	if arg1.Native and typeof(listfiles) == "function" then
		local ok, result = pcall(listfiles, arg2)
		if ok and result then
			for _, v1 in ipairs(result) do
				local v2 = string.match(v1, "[^/\\]+$")
				if v2 and not tbl1[v2] then
					tbl1[v2] = true
					table.insert(tbl, v2)
				end
			end
		end
	end

	for k in pairs(arg1.Memory) do
		if string.sub(k, 1, #arg2 + 1) == arg2 .. "/" then
			local v3 = string.match(k, "[^/\\]+$")
			if v3 and not tbl1[v3] then
				tbl1[v3] = true
				table.insert(tbl, v3)
			end
		end
	end

	table.sort(tbl)
	return tbl
end

function tbl6.BuildFolders(_, arg2)
	local str = ""

	for _, v1 in ipairs(string.split(arg2, "/")) do
		local v2 = str == "" and v1 or str .. "/" .. v1
		str = v2
		tbl16:MakeFolder(v2)
	end

	tbl16:MakeFolder(arg2 .. "/configs")
	tbl16:MakeFolder(arg2 .. "/settings")
	return arg2
end

tbl6.FileSystem = tbl16

if getgenv then
	pcall(function()
		getgenv().Facility = tbl6
	end)
end

tbl6.SaveManager = tbl6:LoadAddon("SaveManager")
tbl6.InterfaceManager = tbl6:LoadAddon("InterfaceManager")
tbl6.ThemeManager = tbl6:LoadAddon("ThemeManager")
local ThemeManager = tbl6.ThemeManager

local tbl17 = {
	{"crimson", Color3.fromRGB(19, 19, 19), Color3.fromRGB(255, 24, 24)},
	{"dark", Color3.fromRGB(24, 24, 26), Color3.fromRGB(96, 205, 255)},
	{"onyx", Color3.fromRGB(10, 10, 10), Color3.fromRGB(235, 235, 235)},
	{"emerald", Color3.fromRGB(14, 24, 19), Color3.fromRGB(52, 211, 153)},
	{"toxic", Color3.fromRGB(12, 18, 10), Color3.fromRGB(166, 255, 0)},
	{"noir", Color3.fromRGB(10, 8, 9), Color3.fromRGB(255, 92, 150)},
	{"lagoon", Color3.fromRGB(8, 20, 30), Color3.fromRGB(34, 230, 222)},
}

if type(ThemeManager) == "table" and type(ThemeManager.Presets) == "table" and type(ThemeManager.Order) == "table" then
	for _, v4 in ipairs(tbl17) do
		if not ThemeManager.Presets[v4[1]] then
			ThemeManager.Presets[v4[1]] = {Bg = v4[2], Accent = v4[3]}
			table.insert(ThemeManager.Order, v4[1])
		end
	end
end

return tbl6
