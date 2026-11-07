-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf

if not game:IsLoaded() then
	game.Loaded:Wait()
end

task.wait(0.5)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

while not LocalPlayer do
	Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
	LocalPlayer = Players.LocalPlayer
end

local flag = true
local num = 0
local v11
local Label
local str = "en"

local tbl = {
	en = {
		tab_main = "Main",
		tab_boost = "Boost",
		tab_visuals = "Visuals",
		tab_rollback = "Rollback",
		tab_settings = "Settings",
		group_combat = "Combat",
		group_aim_serve = "Aim & Serve",
		group_jump = "Jump",
		group_spike = "Spike",
		group_effects = "Effects",
		group_perf = "Performance",
		group_cards = "Player Cards",
		group_rollback = "Data Rollback",
		group_info = "Info",
		group_actions = "Actions",
		hitbox = "Ball Hitbox",
		hitbox_size = "Hitbox Size",
		hitbox_trans = "Hitbox Transparency",
		hitbox_color = "Hitbox Color",
		directional = "Directional Hit",
		official_path = "Official Move Path",
		perfect_spike = "Perfect Spike Assist",
		max_power = "Max Power Spike (TSH)",
		max_power_tip = "Tiny movement while idle keeps spike meter full",
		silent_spike = "Silent Spike",
		silent_spike_tip = "DoMove Spike + mute anim/SFX. Grounded, camera aim. Spike / keybind.",
		silent_spike_key = "Silent Spike Key",
		lock_pico = "Lock Spike Button",
		lock_pico_tip = "Prevent dragging the on-screen Spike button",
		desync = "Desync",
		desync_tip = "Visual lag desync (no anim block). Rejoin to fully reverse.",
		anti_mod = "Anti-Moderator",
		anti_mod_tip = "Leave if a moderator joins",
		corner = "Corner Aimbot",
		corner_tip = "Corner Aimbot by RNCRAZY",
		corner_by = "Corner Aimbot by RNCRAZY",
		camera_jump = "Camera Jump",
		camera_jump_tip = "Face camera direction when jumping",
		auto_serve = "Auto Strong Serve (UI)",
		force_serve = "Force Strong Serve",
		serve_power = "Serve Boost Power",
		jump_boost = "Jump Boost",
		jump_mult = "Jump Multiplier",
		spike_boost = "Spike Boost",
		spike_charge = "Spike Charge",
		no_cd = "No Cooldown",
		no_cd_tip = "Reduce action cooldowns (pick which actions below)",
		no_cd_spike = "No CD: Spike",
		no_cd_serve = "No CD: Serve",
		no_cd_block = "No CD: Block",
		no_cd_dive = "No CD: Dive",
		no_cd_set = "No CD: Set",
		no_cd_receive = "No CD: Receive",
		no_cd_ability = "No CD: Ability",
		score_select = "Select Score Effect",
		score_toggle = "ScoreEffect Changer",
		score_test = "Test Effect NOW",
		card_toggle = "PlayerCard Changer",
		card_select = "Card Select",
		card_test = "Test Card NOW",
		anti_lag = "Anti-Lag",
		anti_lag_tip = "Same as Performance Mode (reduces lag)",
		predict = "Predict Aim",
		predict_tip = "Show prediction lines on enemies",
		predict_len = "Prediction Length",
		predict_color = "Predict Color",
		optimal_spot = "Optimal Spot",
		optimal_spot_tip = "Marks where to stand based on the ball",
		optimal_on = "Optimal Spot ON",
		optimal_off = "Optimal Spot OFF",
		fps = "FPS Counter",
		fps_tip = "Fixed FPS counter at the top of the screen",
		potato = "Anti-Lag / Performance",
		potato_tip = "Reduce local graphics (levels below)",
		perf_level = "Performance Level",
		perf_light = "Light",
		perf_bal = "Balanced",
		perf_max = "Maximum",
		bar_tsh = "TSH Bar Lock",
		bar_tsh_tip = "Keep Timeskip special bar full (local)",
		bar_ronin = "Ronin Bar Lock",
		bar_ronin_tip = "Keep Samurai/Ronin special bar full (local)",
		bar_kazana = "Kazana Bar Lock",
		bar_kazana_tip = "Keep Kazana charge ready (local)",
		streamer = "Streamer Mode",
		streamer_tip = "Hide other player names",
		unlock_all = "Unlock All (Visual)",
		unlock_all_tip = "CLIENT ONLY: unlock & equip cosmetics/emotes on your screen. Others still see your real loadout. Not styles/gems/yen/spins.",
		unlock_on = "Unlock All ON - cosmetics local",
		unlock_off = "Unlock All OFF",
		last_updated = "Last Updated: ",
		creator = "Creator: thiagxjzu3",
		ui_lib = "UI Library: Obsidian",
		enjoy = "Enjoy the script!",
		rb_l1 = "Two rollbacks: Classic + END",
		rb_l2 = "Sends UpdateKeybind payload then rejoins",
		rb_l3 = "Use right after spending. ~3 spins typical",
		rb_run = "Rollback Classic",
		rb_tip = "Original KingsHub rollback payload + rejoin",
		rb_run_beta = "Rollback (END)",
		rb_tip_beta = "END: SettingsService UpdateKeybind + teleport",
		rb_l4 = "You will be teleported automatically",
		menu_bind = "Menu bind",
		online_users = "Users online",
		online_tip = "Anonymous heartbeat to your API",
		online_toggle = "Live User Counter",
		online_off = "Counter off / no API URL",
		online_err = "Online API unreachable",
		unload = "Unload Script",
		copy_discord = "Copy Discord",
		discord_ok = "Discord link copied",
		discord_fail = "Clipboard unavailable",
		welcome = "Welcome to KingsHub by thiagxjzu3. Enjoy!",
		loaded = " loaded | ",
		pick_title = "Choose your language",
		pick_sub = "Select language / Elige el idioma",
		pick_en = "English",
		pick_es = "Español",
		on = "ON",
		off = "OFF",
		studs = " studs",
		pico = "Spike",
		pico_locked = "Spike button locked",
		pico_unlocked = "Spike button unlocked",
		desync_on = "Desync ON - visual lag (rejoin to fully reverse)",
		desync_off = "Desync OFF (rejoin if still weird)",
		silent_on = "Silent Spike ON - DoMove Spike (Spike / key)",
		silent_off = "Silent Spike OFF",
		unloading = "Unloading",
		rb_sending = "Rollback: sending payload...",
		rb_fail = "Rollback failed",
		rb_ok = "Rollback sent. Rejoining...",
		mod_detect = "Moderator detected: ",
		mod_leave = " - leaving",
		mod_join = "Moderator joined: ",
	},
	es = {
		tab_main = "Principal",
		tab_boost = "Boost",
		tab_visuals = "Visuales",
		tab_rollback = "Rollback",
		tab_settings = "Ajustes",
		group_combat = "Combate",
		group_aim_serve = "Aim y Saque",
		group_jump = "Salto",
		group_spike = "Remate",
		group_effects = "Efectos",
		group_perf = "Rendimiento",
		group_cards = "Cartas",
		group_rollback = "Rollback de Datos",
		group_info = "Info",
		group_actions = "Acciones",
		hitbox = "Hitbox de Pelota",
		hitbox_size = "Tamaño Hitbox",
		hitbox_trans = "Transparencia Hitbox",
		hitbox_color = "Color Hitbox",
		directional = "Golpe Direccional",
		official_path = "Ruta Oficial de Movimiento",
		perfect_spike = "Asistencia Spike Perfecto",
		max_power = "Max Power Spike (TSH)",
		max_power_tip = "Movimiento mínimo en idle mantiene la barra llena",
		silent_spike = "Silent Spike",
		silent_spike_tip = "DoMove Spike + mute anim/SFX. En suelo, mira cámara. Pico / tecla.",
		silent_spike_key = "Tecla Silent Spike",
		lock_pico = "Bloquear botón Pico",
		lock_pico_tip = "Evita arrastrar el botón Pico en pantalla",
		desync = "Desync",
		desync_tip = "Desync con lag visual (sin bloquear anims). Rejoin para revertir del todo.",
		anti_mod = "Anti-Moderador",
		anti_mod_tip = "Sale si entra un moderador",
		corner = "Corner Aimbot",
		corner_tip = "Corner Aimbot by RNCRAZY",
		corner_by = "Corner Aimbot by RNCRAZY",
		camera_jump = "Camera Jump",
		camera_jump_tip = "Mira hacia la cámara al saltar",
		auto_serve = "Auto Strong Serve (UI)",
		force_serve = "Forzar Strong Serve",
		serve_power = "Potencia de Saque",
		jump_boost = "Boost de Salto",
		jump_mult = "Multiplicador de Salto",
		spike_boost = "Boost de Spike",
		spike_charge = "Carga de Spike",
		no_cd = "Sin Cooldown",
		no_cd_tip = "Reduce cooldowns (elegí qué acciones abajo)",
		no_cd_spike = "Sin CD: Spike",
		no_cd_serve = "Sin CD: Serve",
		no_cd_block = "Sin CD: Block",
		no_cd_dive = "Sin CD: Dive",
		no_cd_set = "Sin CD: Set",
		no_cd_receive = "Sin CD: Receive",
		no_cd_ability = "Sin CD: Ability",
		score_select = "Elegir Score Effect",
		score_toggle = "Cambiar ScoreEffect",
		score_test = "Probar efecto AHORA",
		card_toggle = "Cambiar PlayerCard",
		card_select = "Elegir carta",
		card_test = "Probar carta AHORA",
		anti_lag = "Anti-Lag",
		anti_lag_tip = "Igual que Modo Rendimiento (baja lag)",
		predict = "Predict Aim",
		predict_tip = "Líneas de predicción en enemigos",
		predict_len = "Largo de Predicción",
		predict_color = "Color Predict",
		optimal_spot = "Posición Óptima",
		optimal_spot_tip = "Marca dónde pararte según la pelota",
		optimal_on = "Posición Óptima ON",
		optimal_off = "Posición Óptima OFF",
		fps = "Contador FPS",
		fps_tip = "FPS fijo arriba de la pantalla",
		potato = "Anti-Lag / Rendimiento",
		potato_tip = "Baja gráficos locales (niveles abajo)",
		perf_level = "Nivel de Rendimiento",
		perf_light = "Ligero",
		perf_bal = "Equilibrado",
		perf_max = "Máximo",
		bar_tsh = "Lock Barra TSH",
		bar_tsh_tip = "Mantiene la barra especial Timeskip llena (local)",
		bar_ronin = "Lock Barra Ronin",
		bar_ronin_tip = "Mantiene la barra Samurai/Ronin llena (local)",
		bar_kazana = "Lock Barra Kazana",
		bar_kazana_tip = "Mantiene la carga Kazana lista (local)",
		streamer = "Modo Streamer",
		streamer_tip = "Oculta nombres de otros jugadores",
		unlock_all = "Desbloquear Todo (Visual)",
		unlock_all_tip = "SOLO CLIENTE: desbloquea y equipa cosméticos/emotes en TU pantalla. Los demás te ven normal. No estilos/gemas/yen/giros.",
		unlock_on = "Unlock All ON - cosméticos locales",
		unlock_off = "Unlock All OFF",
		last_updated = "Actualizado: ",
		creator = "Creador: thiagxjzu3",
		ui_lib = "UI: Obsidian",
		enjoy = "¡Disfruta el script!",
		rb_l1 = "Dos rollbacks: Clásico + END",
		rb_l2 = "Envía payload UpdateKeybind y hace rejoin",
		rb_l3 = "Usar justo después de gastar. ~3 giros típico",
		rb_run = "Rollback Clásico",
		rb_tip = "Rollback original de KingsHub + rejoin",
		rb_run_beta = "Rollback (END)",
		rb_tip_beta = "END: SettingsService UpdateKeybind + teleport",
		rb_l4 = "Serás teletransportado automáticamente",
		menu_bind = "Tecla del menú",
		online_users = "Usuarios en línea",
		online_tip = "Heartbeat anónimo a tu API",
		online_toggle = "Contador en vivo",
		online_off = "Contador off / sin URL de API",
		online_err = "API de online no responde",
		unload = "Cerrar Script",
		copy_discord = "Copiar Discord",
		discord_ok = "Link de Discord copiado",
		discord_fail = "Portapapeles no disponible",
		welcome = "Bienvenido a KingsHub by thiagxjzu3. ¡Disfruta!",
		loaded = " cargado | ",
		pick_title = "Elige tu idioma",
		pick_sub = "Select language / Elige el idioma",
		pick_en = "English",
		pick_es = "Español",
		on = "ON",
		off = "OFF",
		studs = " studs",
		pico = "Pico",
		pico_locked = "Botón Pico bloqueado",
		pico_unlocked = "Botón Pico desbloqueado",
		desync_on = "Desync ON - lag visual (rejoin para revertir del todo)",
		desync_off = "Desync OFF (rejoin si sigue raro)",
		silent_on = "Silent Spike ON - DoMove Spike (Pico / tecla)",
		silent_off = "Silent Spike OFF",
		unloading = "Descargando",
		rb_sending = "Rollback: enviando payload...",
		rb_fail = "Rollback falló",
		rb_ok = "Rollback enviado. Rejoin...",
		mod_detect = "Moderador detectado: ",
		mod_leave = " - saliendo",
		mod_join = "Moderador entró: ",
	},
}

local function func(arg1)
	return (tbl[str] or tbl.en)[arg1] or tbl.en[arg1] or arg1
end

local v2
local v3

local function func1(arg1)
	local ok, result = pcall(function()
		return game:HttpGet(arg1)
	end)

	if not ok or type(result) ~= "string" or #result < 100 then
		return nil
	end

	local ok1, result1 = pcall(function()
		return loadstring(result)()
	end)

	if ok1 then
		return result1
	end

	return nil
end

local v1 = func1("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua")
task.wait(0.15)

if v1 then
	v2 = func1("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua")
	task.wait(0.1)
	v3 = func1("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/SaveManager.lua")
end

if not v1 then
	warn("[KingsHub] Failed to load UI library")
	return
end

local Options = v1.Options
local Toggles = v1.Toggles
v1.ForceCheckbox = false
v1.ShowToggleFrameInKeybinds = true
v1.ShowCustomCursor = false

pcall(function()
	v1:SetNotifySide("Left")
end)

local function func2()
	if v11 then
		return v11
	end

	local v1

	pcall(function()
		if type(generateGUID) == "function" then
			v1 = tostring(generateGUID()):gsub("%W", ""):sub(1, 24)
		end
	end)

	if not v1 or v1 == "" then
		v1 = (tostring(math.random(100000, 999999)) .. tostring(os.clock()):gsub("%W", "")):sub(1, 24)
	end

	v11 = v1
	return v1
end

local function func3()
	if not flag then
		return
	end

	if type("https://kingshub-api.thiagodamianff.workers.dev") ~= "string" or false then
		return
	end

	if type(game.HttpGet) ~= "function" and type(request) ~= "function" and type(http_request) ~= "function" then
		return
	end

	local v1 = func2()
	local v2 = ("https://kingshub-api.thiagodamianff.workers.dev"):gsub("/+$", "") .. "/heartbeat"
	local v3 = game:GetService("HttpService"):JSONEncode({id = v1})

	local ok, result = pcall(function()
		if type(request) == "function" then
			local v1 = request({Url = v2, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = v3})
			return v1 and (v1.Body or v1.body)
		end

		if type(http_request) == "function" then
			local v4 = http_request({Url = v2, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = v3})
			return v4 and (v4.Body or v4.body)
		end

		return game:HttpGet(("https://kingshub-api.thiagodamianff.workers.dev"):gsub("/+$", "") .. "/count")
	end)

	if ok and type(result) == "string" and result ~= "" then
		local v4

		pcall(function()
			v4 = game:GetService("HttpService"):JSONDecode(result)
		end)

		if type(v4) == "table" and tonumber(v4.online) then
			num = math.floor(tonumber(v4.online))
			pcall(function()
				if Label and Label.SetText then
					local v1 = func("online_users")
					if not flag then
						Label:SetText(v1 .. ": -")
					else
						Label:SetText(v1 .. ": " .. tostring(num))
					end
				end
			end)
		end
	end
end

local flag1 = false
local num1 = 10
local v4 = Color3.fromRGB(0, 255, 0)
local num2 = 0.8
local str1 = "Balanced"
local flag2 = false
local flag3 = false
local flag4 = false
local num3 = 1
local flag5 = false
local flag6 = false
local flag7 = false
local flag8 = false
local flag9 = false
local num4 = 0
local flag10 = false
local flag11 = true
local v12
local flag12 = false
local tbl1 = {}
local flag13 = false
local flag14 = false
local flag15 = false
local v5 = Color3.fromRGB(255, 255, 0)
local num5 = 25
local flag16 = false
local v13
local flag17 = false
local num6 = 1.35
local flag18 = false
local num7 = 1
local flag19 = true
local flag20 = false
local flag21 = false
local flag22 = false
local tbl2 = {}
local v14
local v15
local num8 = 0
local tbl3 = {}
local tbl4 = {}
local tbl5 = {"ROBLOX", "Roblox", "Admin", "Moderator", "VolleyballLegends"}

pcall(function()
	local Packages = ReplicatedStorage:FindFirstChild("Packages")

	if not Packages then
		return
	end

	local _Index = Packages:FindFirstChild("_Index")

	if not _Index then
		return
	end

	local sleitnick_knit170 = _Index:FindFirstChild("sleitnick_knit@1.7.0")

	if not sleitnick_knit170 then
		return
	end

	local knit = sleitnick_knit170:FindFirstChild("knit")

	if not knit then
		return
	end

	local Services = knit:FindFirstChild("Services")

	if not Services then
		return
	end

	local BallService = Services:FindFirstChild("BallService")
	local v1 = BallService and BallService:FindFirstChild("RF")

	if v1 then
		v14 = v1:FindFirstChild("Jump") or v14
		v15 = v1:FindFirstChild("Interact") or v15
	end
end)

task.spawn(function()
	for _ = 1, 8 do
		if v14 and v15 then
			break
		end

		task.wait(1)

		pcall(function()
			local Packages = ReplicatedStorage:FindFirstChild("Packages")

			if not Packages then
				return
			end

			local _Index = Packages:FindFirstChild("_Index")

			if not _Index then
				return
			end

			local sleitnick_knit170 = _Index:FindFirstChild("sleitnick_knit@1.7.0")

			if not sleitnick_knit170 then
				return
			end

			local knit = sleitnick_knit170:FindFirstChild("knit")

			if not knit then
				return
			end

			local Services = knit:FindFirstChild("Services")

			if not Services then
				return
			end

			local BallService = Services:FindFirstChild("BallService")
			local v1 = BallService and BallService:FindFirstChild("RF")

			if v1 then
				v14 = v1:FindFirstChild("Jump") or v14
				v15 = v1:FindFirstChild("Interact") or v15
			end
		end)
	end
end)

local function func4()
	local v1 = num1

	if v1 <= 0 then
		return
	end

	for _, child in pairs(workspace:GetChildren()) do
		local str = tostring(child.Name or "")
		if (str:find("CLIENT_BALL") or str:find("BALL")) and child:IsA("Model") then
			local BasePart = child:FindFirstChildWhichIsA("BasePart")
			if BasePart then
				local ExtendedHitbox = child:FindFirstChild("ExtendedHitbox")
				if ExtendedHitbox and ExtendedHitbox:IsA("BasePart") then
					ExtendedHitbox.Size = Vector3.new(v1, v1, v1)
					ExtendedHitbox.Color = v4
					ExtendedHitbox.Transparency = num2
					ExtendedHitbox.CFrame = BasePart.CFrame
				else
					local part = Instance.new("Part")
					part.Name = "ExtendedHitbox"
					part.Size = Vector3.new(v1, v1, v1)
					part.Transparency = num2
					part.Color = v4
					local enum = Enum
					part.Material = enum.Material.ForceField
					part.CanCollide = false
					part.CanTouch = true
					part.Massless = true
					part.Shape = enum.PartType.Ball
					part.CFrame = BasePart.CFrame
					part.Parent = child
					local weldConstraint = Instance.new("WeldConstraint")
					weldConstraint.Part0 = BasePart
					weldConstraint.Part1 = part
					weldConstraint.Parent = part
				end
			end
		end
	end
end

local function func5()
	for _, child in pairs(workspace:GetChildren()) do
		if tostring(child.Name):find("CLIENT_BALL") and child:IsA("Model") then
			local ExtendedHitbox = child:FindFirstChild("ExtendedHitbox")
			if ExtendedHitbox then
				ExtendedHitbox:Destroy()
			end
		end
	end
end

local function func6(arg1)
	if not arg1 then
		return nil
	end

	local str = tostring(arg1.Name or "")
	local num = tonumber(str:match("(%d+)"))

	if num then
		return num
	end

	for _, v1 in ipairs({"BallId", "Id", "ballId", "ID", "NetId"}) do
		local Attribute = arg1:GetAttribute(v1)
		if Attribute ~= nil then
			local num1 = tonumber(Attribute)
			if num1 then
				return num1
			end
		end
	end

	local v2 = arg1:FindFirstChild("BallId") or arg1:FindFirstChild("Id")

	if v2 and v2:IsA("ValueBase") then
		return tonumber(v2.Value)
	end

	return nil
end

local v16

local function func7()
	pcall(function()
		if v16 and v16.Parent then
			return
		end

		local Packages = ReplicatedStorage:FindFirstChild("Packages")
		local v1 = Packages and Packages:FindFirstChild("_Index")
		local v2 = v1 and v1:FindFirstChild("sleitnick_knit@1.7.0")
		local v3 = v2 and v2:FindFirstChild("knit")
		local v4 = v3 and v3:FindFirstChild("Services")
		local v5 = v4 and v4:FindFirstChild("BallService")
		local v6 = v5 and v5:FindFirstChild("RE")
		v16 = v6 and v6:FindFirstChild("DoMove")
	end)
end

local function func8()
	local tbl = {}
	local pcallRef = pcall

	pcallRef(function()
		table.insert(tbl, firesignal)
	end)

	pcallRef(function()
		if getgenv then
			table.insert(tbl, getgenv().firesignal)
		end
	end)

	pcallRef(function()
		if getrenv then
			table.insert(tbl, getrenv().firesignal)
		end
	end)

	pcallRef(function()
		if getfenv then
			table.insert(tbl, getfenv().firesignal)
		end
	end)

	for _, v1 in ipairs(tbl) do
		if type(v1) == "function" then
			return v1
		end
	end

	return nil
end

local function func9(arg1)
	if not arg1 then
		return 20
	end

	local v1

	pcall(function()
		local Map = workspace:FindFirstChild("Map")
		local v2 = Map and Map:FindFirstChild("BallCollideOnly")
		local v3 = v2 and v2:FindFirstChild("Net")

		if v3 then
			v1 = v3:IsA("BasePart") and v3.Position or v3:GetPivot().Position
		end
	end)

	v1 = v1 or Vector3.new(arg1.Position.X, arg1.Position.Y, 0)
	return Vector3.new(arg1.Position.X - v1.X, 0, arg1.Position.Z - v1.Z).Magnitude
end

local function func10(arg1)
	local CurrentCamera = workspace.CurrentCamera
	local v1 = CurrentCamera and CurrentCamera.CFrame.LookVector or Vector3.new(0, 0.05, -1)
	local vector3 = Vector3.new(v1.X, 0, v1.Z)
	local vector31

	if vector3.Magnitude < 0.05 then
		vector31 = Vector3.new(0, 0, -1)
	else
		vector31 = vector3.Unit
	end

	local v2 = func9(arg1)
	local v3 = -0.12 + math.clamp(v2 / 35, 0, 1) * 0.34

	if arg1 then
		local v4 = arg1.AssemblyLinearVelocity or arg1.Velocity or Vector3.zero
		local vector32 = Vector3.new(v4.X, 0, v4.Z)

		if vector32.Magnitude > 2 then
			local v5 = vector32.Unit:Dot(vector31)
			v3 = v3 - math.clamp(v5, -1, 1) * 0.04
		end
	end

	local v6 = math.clamp(v3, -0.15, 0.28)
	local vector33 = Vector3.new(vector31.X, v6, vector31.Z)
	local vector33Ref = vector33

	if vector33.Magnitude > 0.0001 then
		vector33Ref = vector33.Unit
	end

	return vector33Ref, vector31, v2, v6
end

local function func11(arg1, arg2)
	pcall(function()
		local Packages = ReplicatedStorage:FindFirstChild("Packages")

		if not Packages then
			return
		end

		local _Index = Packages:FindFirstChild("_Index")

		if not _Index then
			return
		end

		local sleitnick_knit170 = _Index:FindFirstChild("sleitnick_knit@1.7.0")

		if not sleitnick_knit170 then
			return
		end

		local knit = sleitnick_knit170:FindFirstChild("knit")

		if not knit then
			return
		end

		local Services = knit:FindFirstChild("Services")

		if not Services then
			return
		end

		local BallService = Services:FindFirstChild("BallService")
		local v1 = BallService and BallService:FindFirstChild("RF")

		if v1 then
			v14 = v1:FindFirstChild("Jump") or v14
			v15 = v1:FindFirstChild("Interact") or v15
		end
	end)

	pcall(function()
		if v16 and v16.Parent then
			return
		end

		local Packages = ReplicatedStorage:FindFirstChild("Packages")
		local v1 = Packages and Packages:FindFirstChild("_Index")
		local v2 = v1 and v1:FindFirstChild("sleitnick_knit@1.7.0")
		local v3 = v2 and v2:FindFirstChild("knit")
		local v4 = v3 and v3:FindFirstChild("Services")
		local v5 = v4 and v4:FindFirstChild("BallService")
		local v6 = v5 and v5:FindFirstChild("RE")
		v16 = v6 and v6:FindFirstChild("DoMove")
	end)

	local v1, v2 = func10(arg1)
	local v3 = func6(arg2)
	local v4 = func8()

	if v4 and v16 then
		local pcallRef = pcall

		pcallRef(function()
			v4(v16.OnClientEvent, "Spike", false, false, v1)
		end)

		pcallRef(function()
			v4(v16.OnClientEvent, "Spike", false, false)
		end)
	elseif v16 and type(getconnections) == "function" then
		pcall(function()
			for _, v2 in ipairs(getconnections(v16.OnClientEvent)) do
				pcall(function()
					if v2.Fire then
						v2:Fire("Spike", false, false, v1)
					elseif v2.Function then
						v2.Function("Spike", false, false, v1)
					end
				end)
			end
		end)
	end

	if v15 then
		local tbl = {
			Charge = 1,
			Move = "Spike",
			Action = "Spike",
			SpecialCharge = 0,
			TiltDirection = Vector3.new(v2.X, 0.14, v2.Z),
			LookVector = v1,
			Direction = v1,
			MoveDirection = Vector3.new(0, 0, 0),
			ClientCanRunSpecial = false,
			From = "Client",
			Timestamp = tick(),
			CustomClient = {},
		}

		if v3 then
			tbl.BallId = v3
		end

		applyNoCooldownToPayload(tbl)

		pcall(function()
			if v15:IsA("RemoteFunction") then
				v15:InvokeServer(tbl)
			else
				v15:FireServer(tbl)
			end
		end)
	end

	return true
end

local function func12(_)
	return false
end

local function func13(arg1)
	if type(arg1) ~= "table" then
		return
	end

	if not func12(arg1.Action or arg1.Move or arg1.action or arg1.move) then
		return
	end

	arg1.Cooldown = 0
	arg1.cooldown = 0
	arg1.Debounce = 0
	arg1.debounce = false
	arg1.NoCooldown = true
	arg1.CanAct = true
	arg1.CanSpike = true
	arg1.ActionCooldown = 0
	arg1.Recover = 0
	arg1.Recovery = 0

	if arg1.Charge == nil then
		arg1.Charge = 1
	end
end

local function func14(arg1)
	local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

	if not v1 then
		return nil
	end

	local v4
	local v2 = arg1 or 22
	local v5
	local v6
	local v7

	for _, child in pairs(workspace:GetChildren()) do
		local str = tostring(child.Name or "")
		if (str:find("CLIENT_BALL") or str:find("BALL")) and child:IsA("Model") then
			local BasePart = child:FindFirstChildWhichIsA("BasePart")
			if BasePart then
				local ExtendedHitbox = child:FindFirstChild("ExtendedHitbox")
				local v3 = ExtendedHitbox or BasePart
				local Magnitude = (v1.Position - v3.Position).Magnitude

				if Magnitude < v2 then
					v2 = Magnitude
					v4 = v3
					v5 = child
					v6 = BasePart
					v7 = ExtendedHitbox
				end
			end
		end
	end

	return v4, v5, v6, v7
end

local function func15(arg1)
	if not arg1 then
		return
	end

	local Humanoid = arg1:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		return
	end

	local Animator = Humanoid:FindFirstChildOfClass("Animator")

	if not Animator then
		return
	end

	for _, track in ipairs(Animator:GetPlayingAnimationTracks()) do
		local ok, result = pcall(function()
			local Animation = track.Animation

			if Animation then
				return (tostring(Animation.AnimationId or "") .. " " .. tostring(Animation.Name or "")):lower()
			end

			return tostring(track.Name or ""):lower()
		end)

		local v1 = ok and result or ""

		if
			v1:find("spike")
			or v1:find("attack")
			or v1:find("swing")
			or v1:find("hit")
			or v1:find("set")
			or v1:find("bump")
			or v1:find("receive")
		then
			local pcallRef = pcall

			pcallRef(function()
				track:Stop(0)
			end)

			pcallRef(function()
				track:AdjustSpeed(0)
			end)
		end
	end
end

local tbl6 = {active = false, conns = {}, untilT = 0}

local function func16(arg1)
	local v1 = arg1 or 0.35
	tbl6.active = true
	tbl6.untilT = os.clock() + v1
	local Character = LocalPlayer.Character

	if Character then
		func15(Character)
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		local v2 = Humanoid and Humanoid:FindFirstChildOfClass("Animator")

		if v2 then
			table.insert(tbl6.conns, v2.AnimationPlayed:Connect(function(arg1)
				if not tbl6.active or os.clock() > tbl6.untilT then
					return
				end
				pcall(function()
					arg1:Stop(0)
				end)
			end))
		end
	end

	pcall(function()
		for _, descendant in ipairs(workspace:GetDescendants()) do
			if descendant:IsA("Sound") and descendant.IsPlaying then
				local v1 = string.lower(descendant.Name)
				if v1:find("spike") or v1:find("hit") or v1:find("swing") then
					pcall(function()
						descendant.Volume = 0
					end)
				end
			end
		end
	end)
end

local function func17()
	tbl6.active = false

	for _, conn in ipairs(tbl6.conns) do
		pcall(function()
			conn:Disconnect()
		end)
	end

	tbl6.conns = {}
end

local function func18()
	local ok, result = pcall(function()
		return ReplicatedStorage.Packages._Index["sleitnick_knit@1.7.0"].knit.Services.BallService.RE.DoMove
	end)

	if ok and result then
		return result
	end

	return nil
end

local function func19()
	if not flag9 then
		return
	end

	if tick() - num4 < 0.12 then
		return
	end

	local Character = LocalPlayer.Character
	local v1 = Character and Character:FindFirstChild("HumanoidRootPart")

	if not v1 then
		return
	end

	num4 = tick()
	local CurrentCamera = workspace.CurrentCamera
	local v2 = CurrentCamera and CurrentCamera.CFrame.LookVector or v1.CFrame.LookVector
	local vector3 = Vector3.new(v2.X, 0, v2.Z)

	if vector3.Magnitude > 0.01 then
		pcall(function()
			v1.CFrame = CFrame.lookAt(v1.Position, v1.Position + vector3.Unit)
		end)
	end

	func16(0.45)
	local _, v3 = func14(32)

	if v3 then
		pcall(function()
			func11(v1, v3)
		end)
	else
		pcall(function()
			local v2, v3 = func10(v1)
			local v4 = func18 and func18() or v16

			if not v4 then
				pcall(func7)
				v4 = v16
			end

			local v5 = func8 and func8() or type(firesignal) == "function" and firesignal

			if v5 and v4 then
				v5(v4.OnClientEvent, "Spike", false, false, v2)
				v5(v4.OnClientEvent, "Spike", false, false)
			end

			if v15 then
				local tbl = {
					Charge = 1,
					Move = "Spike",
					Action = "Spike",
					SpecialCharge = 9.9999999999999995e-07,
					TiltDirection = Vector3.new(v3.X, 0.12, v3.Z),
					LookVector = v2,
					Direction = v2,
					MoveDirection = Vector3.new(0, 0, 0),
					From = "Client",
					Timestamp = tick(),
				}

				func13(tbl)

				if v15:IsA("RemoteFunction") then
					v15:InvokeServer(tbl)
				else
					v15:FireServer(tbl)
				end
			end
		end)
	end

	task.delay(0.05, function()
		func15(LocalPlayer.Character)
	end)

	task.delay(0.12, function()
		func15(LocalPlayer.Character)
	end)

	task.delay(0.4, function()
		func17()
		func15(LocalPlayer.Character)
	end)
end

local function func20()
	local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")

	if not PlayerGui then
		return
	end

	local KingsHub_SilentSpike = PlayerGui:FindFirstChild("KingsHub_SilentSpike")

	if KingsHub_SilentSpike then
		KingsHub_SilentSpike:Destroy()
	end
end

local function func21()
	func20()
	local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")

	if not PlayerGui then
		return
	end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "KingsHub_SilentSpike"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.IgnoreGuiInset = true

	pcall(function()
		if syn and syn.protect_gui then
			syn.protect_gui(screenGui)
		end
	end)

	screenGui.Parent = PlayerGui
	local textButton = Instance.new("TextButton")
	textButton.Name = "Pico"
	textButton.Size = UDim2.new(0, 64, 0, 64)
	textButton.Position = UDim2.new(0.82, 0, 0.72, 0)
	textButton.BackgroundColor3 = Color3.fromRGB(30, 32, 38)
	textButton.BackgroundTransparency = 0.15
	textButton.Text = func("pico")
	textButton.TextColor3 = Color3.fromRGB(80, 255, 160)
	textButton.TextSize = 17
	textButton.Font = Enum.Font.GothamBold
	textButton.AutoButtonColor = true
	textButton.ZIndex = 10
	textButton.Parent = screenGui
	local uICorner = Instance.new("UICorner")
	uICorner.CornerRadius = UDim.new(1, 0)
	uICorner.Parent = textButton
	local uIStroke = Instance.new("UIStroke")
	uIStroke.Color = Color3.fromRGB(80, 255, 160)
	uIStroke.Thickness = 2.5
	uIStroke.Transparency = 0.2
	uIStroke.Parent = textButton
	local flag = false
	local flag1 = false
	local Position
	local Position1

	textButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			flag = true
			flag1 = false
			Position = input.Position
			Position1 = textButton.Position
		end
	end)

	textButton.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			if flag and not flag1 then
				func19()
			end
			flag = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if not flag or not Position then
			return
		end

		if flag10 then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			local v1 = input.Position - Position

			if v1.Magnitude > 12 then
				flag1 = true
			end

			if flag1 then
				textButton.Position = UDim2.new(Position1.X.Scale, Position1.X.Offset + v1.X, Position1.Y.Scale, Position1.Y.Offset + v1.Y)
			end
		end
	end)
end

pcall(function()
	local v1

	local function func(arg1, ...)
		local v2 = getnamecallmethod()
		local v3 = select("#", ...)
		local tbl = {...}

		if v2 == "InvokeServer" or v2 == "FireServer" then
			local str = ""

			pcall(function()
				str = tostring(arg1.Name or "")
			end)

			if str == "Interact" and type(tbl[1]) == "table" then
				local v4 = tbl[1]

				if flag5 then
					local CurrentCamera = workspace.CurrentCamera
					if CurrentCamera and v4.LookVector ~= nil then
						local LookVector = CurrentCamera.CFrame.LookVector
						local v5 = type(v4.LookVector)
						local vector3 = Vector3.new(LookVector.X, v5 == "Vector3" and v4.LookVector.Y or 0, LookVector.Z)

						if vector3.Magnitude > 0.001 then
							v4.LookVector = vector3.Unit
						end
					end
				end

				local str1 = tostring(v4.Action or "")

				if str1 == "Spike" or str1 == "spike" then
					if flag18 then
						v4.Charge = math.clamp(tonumber(num7) or 1, 0, 1)
					end
					if flag19 then
						v4.Charge = 1
						if not v4.SpecialCharge or (tonumber(v4.SpecialCharge) or 0) < 9.9999999999999995e-07 then
							v4.SpecialCharge = 9.9999999999999995e-07
						end
					end
				end

				func13(v4)
			end

			if flag4 and str == "Serve" and tbl[2] ~= nil then
				tbl[2] = num3
			end
		end

		return v1(arg1, unpack(tbl, 1, v3))
	end

	task.defer(function()
		task.wait(1)
		pcall(function()
			if type(newcclosure) == "function" then
				v1 = hookmetamethod(game, "__namecall", newcclosure(func))
			else
				v1 = hookmetamethod(game, "__namecall", func)
			end
		end)
	end)
end)

local CurrentCamera = workspace.CurrentCamera
local vector3 = Vector3.new(-393, -24.2, -1356.6)
local num9 = 52
local num10 = 102
local num11 = -1356.6
local num12 = -24.2
local v17
local v18
local flag23 = false
local num13 = 0
local flag24 = false
local folder = Instance.new("Folder")
folder.Name = "CornerAimVFX"
folder.Parent = workspace

local function func22(name, position)
	local part = Instance.new("Part")
	part.Name = name
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.Material = Enum.Material.SmoothPlastic
	part.Color = Color3.fromRGB(25, 28, 30)
	part.Shape = Enum.PartType.Ball
	part.Size = Vector3.new(3, 1.6, 3)
	part.Position = position
	part.Transparency = 0.35
	part.Parent = folder
	return part
end

local function func23()
	local Map = workspace:FindFirstChild("Map")
	local v1 = Map and Map:FindFirstChild("Court")

	if v1 and v1:IsA("BasePart") then
		local X = v1.Size.X
		local Z = v1.Size.Z
		vector3 = v1.Position
		num9 = X
		num10 = Z
		local Y = v1.Position.Y
		num11 = v1.Position.Z
		num12 = Y
	end
end

func23()

local function func24()
	local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

	if not v1 then
		return v17
	end

	local v2 = v1.Position.Z - num11

	if math.abs(v2) < 6 then
		return v17
	end

	return v2 > 0 and 1 or -1
end

local function func25()
	local v1 = func24()

	if v1 then
		v17 = v1
	end

	if not v17 then
		local v2 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		v17 = v2 and v2.CFrame.LookVector.Z > 0 and -1 or 1
	end

	local v3 = -v17
	local v4 = vector3.Z + v3 * (num10 / 2 - 3)

	return {
		Right = Vector3.new(vector3.X + (num9 / 2 - 2.5), num12 + 1, v4),
		Left = Vector3.new(vector3.X - (num9 / 2 - 2.5), num12 + 1, v4),
	}
end

local v6 = func25()
local v7 = func22("LeftHalf", Vector3.new(v6.Left.X, num12 + 0.8, v6.Left.Z))
local v8 = func22("RightHalf", Vector3.new(v6.Right.X, num12 + 0.8, v6.Right.Z))

local function func26()
	v6 = func25()
	local new = Vector3.new
	local X = v6.Left.X
	local v1 = num12 + 0.8
	local v2 = v6
	v7.Position = new(X, v1, v2.Left.Z)
	v8.Position = Vector3.new(v2.Right.X, num12 + 0.8, v6.Right.Z)
end

local function func27()
	local MouseLocation = UserInputService:GetMouseLocation()
	local GuiInset = GuiService:GetGuiInset()
	local vector2 = Vector2.new(MouseLocation.X, MouseLocation.Y - GuiInset.Y)
	local v4
	local num = 250

	for k, v1 in pairs(v6) do
		local v2, v3 = CurrentCamera:WorldToViewportPoint(v1 + Vector3.new(0, 2, 0))
		if v3 then
			local Magnitude = (Vector2.new(v2.X, v2.Y) - vector2).Magnitude
			if Magnitude < num then
				num = Magnitude
				v4 = k
			end
		end
	end

	return v4
end

local function func28(arg1)
	if flag23 then
		return
	end

	flag23 = true

	task.spawn(function()
		local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		local v2 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

		if not v1 then
			flag23 = false
			return
		end

		local v3 = v2 and v2.AutoRotate

		if v2 then
			v2.AutoRotate = false
		end

		local v4 = os.clock()

		while os.clock() - v4 < 1.2 do
			if flag6 and flag23 then
				local v5 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				if v5 then
					local v6 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
					v2 = v6

					if v6 then
						local State = v6:GetState()
						if
							(State == Enum.HumanoidStateType.Landed or State == Enum.HumanoidStateType.Running)
							and v5.Position.Y - num12 < 4
							and os.clock() - v4 > 0.3
						then
							break
						end
					end

					local Position = v5.Position
					v5.CFrame = CFrame.lookAt(Position, Vector3.new(arg1.X, Position.Y, arg1.Z))
					task.wait()
					continue
				end
			end
			break
		end

		if v2 and v3 ~= nil then
			v2.AutoRotate = v3
		end

		flag23 = false
	end)
end

local function func29()
	if not flag6 or flag23 then
		return
	end

	local v1 = func27() or v18

	if v1 and v6[v1] then
		v18 = v1
		num13 = os.clock()
		func28(v6[v1])
	end
end

local function func30()
	if not flag17 then
		return
	end

	local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

	if not v1 then
		return
	end

	pcall(function()
		if v1.UseJumpPower then
			v1.JumpPower = 50 * num6
		else
			v1.JumpHeight = 7.2 * num6
		end
	end)
end

local v19
local tbl7 = {}
local tbl8 = {}

local function func31()
	for _, v1 in pairs(tbl7) do
		pcall(function()
			v1:Destroy()
		end)
	end

	tbl7 = {}

	if v19 then
		pcall(function()
			v19:Destroy()
		end)
		v19 = nil
	end

	tbl8 = {}
end

local function func32()
	for _, v1 in pairs(tbl1) do
		pcall(function()
			v1:Disconnect()
		end)
	end

	tbl1 = {}
	flag12 = false
	func31()
	local pcallRef = pcall

	pcallRef(function()
		settings().Network.IncomingReplicationLag = 0
	end)

	pcallRef(function()
		if sethiddenproperty then
			local sethiddenpropertyRef = sethiddenproperty
			local localPlayer = LocalPlayer
			sethiddenpropertyRef(localPlayer, "MaxSimulationRadius", 1000)
			sethiddenpropertyRef(localPlayer, "SimulationRadius", 1000)
		end
	end)
end

local function func33()
	if flag12 and #tbl1 > 0 then
		return
	end

	func32()
	flag12 = true
	local pcallRef = pcall

	pcallRef(function()
		settings().Network.IncomingReplicationLag = 0.45
	end)

	pcallRef(function()
		if sethiddenproperty then
			local sethiddenpropertyRef = sethiddenproperty
			local localPlayer = LocalPlayer
			sethiddenpropertyRef(localPlayer, "MaxSimulationRadius", 0)
			sethiddenpropertyRef(localPlayer, "SimulationRadius", 0)
		end
	end)

	pcallRef(function()
		if setfflag then
			local pcallRef = pcall

			pcallRef(function()
				setfflag("WorldStepMax", "30")
			end)

			pcallRef(function()
				setfflag("S2PhysicsSenderRate", "5")
			end)
		end
	end)

	local function func(character)
		func31()

		if not character then
			return
		end

		if not character:FindFirstChild("HumanoidRootPart") then
			return
		end

		local folder = Instance.new("Folder")
		folder.Name = "KingsHub_DesyncGhost"
		folder.Parent = workspace
		v19 = folder

		for _, descendant in ipairs(character:GetDescendants()) do
			if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" then
				local part = Instance.new("Part")
				part.Name = "Ghost_" .. descendant.Name
				part.Size = descendant.Size
				part.CFrame = descendant.CFrame
				part.Anchored = true
				part.CanCollide = false
				part.CanQuery = false
				part.CanTouch = false
				part.Material = Enum.Material.ForceField
				part.Color = Color3.fromRGB(120, 180, 255)
				part.Transparency = 0.55
				part.Parent = folder
				table.insert(tbl7, part)
			end
		end
	end

	local function func1(character)
		if not flag12 or not character then
			return
		end

		local HumanoidRootPart = character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return
		end

		table.insert(tbl8, {t = tick(), cf = HumanoidRootPart.CFrame})

		while #tbl8 > 0 and tick() - tbl8[1].t > 0.35 do
			table.remove(tbl8, 1)
		end

		local v1 = tbl8[1] and tbl8[1].cf or HumanoidRootPart.CFrame

		if #tbl7 == 0 then
			func(character)
		end

		local num = 1

		for _, descendant in ipairs(character:GetDescendants()) do
			if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" then
				local v2 = tbl7[num]

				if v2 and v2.Parent then
					v2.CFrame = v1 * HumanoidRootPart.CFrame:ToObjectSpace(descendant.CFrame)
					v2.Size = descendant.Size
				end

				num = num + 1
			end
		end
	end

	if LocalPlayer.Character then
		task.defer(func, LocalPlayer.Character)
	end

	table.insert(tbl1, LocalPlayer.CharacterAdded:Connect(function(character)
		task.wait(0.2)
		if flag12 then
			func(character)
		end
	end))

	table.insert(tbl1, RunService.Heartbeat:Connect(function()
		if not flag12 then
			return
		end

		local pcallRef = pcall
		pcallRef(func1, LocalPlayer.Character)

		pcallRef(function()
			if settings().Network.IncomingReplicationLag < 0.3 then
				settings().Network.IncomingReplicationLag = 0.45
			end
		end)
	end))
end

UserInputService.JumpRequest:Connect(function()
	if flag6 then
		return
	end

	if not flag7 then
		return
	end

	local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

	if not v1 then
		return
	end

	local CurrentCamera = workspace.CurrentCamera

	if not CurrentCamera then
		return
	end

	local LookVector = CurrentCamera.CFrame.LookVector
	local vector3 = Vector3.new(LookVector.X, 0, LookVector.Z)

	if vector3.Magnitude > 0 then
		v1.CFrame = CFrame.lookAt(v1.Position, v1.Position + vector3.Unit)
	end
end)

local tbl9 = {}
tbl9.controller = nil
tbl9.patched = nil
tbl9.value = 1
tbl9.rawCharge = 0

local tbl10 = {
	TSH = {TimeskipShoyo = true, TimeskipShoyo2 = true, TimeskipShoyo3 = true, TimeskipShoyo4 = true},
	Ronin = {Samurai = true, Samurai2 = true, Ronin = true, Ronin2 = true},
	Kazana = {Kazana = true, Kazana2 = true, Kazana3 = true},
}

local function func34()
	if tbl9.controller then
		return tbl9.controller
	end

	local ok, result = pcall(function()
		local Controllers = game:GetService("ReplicatedFirst"):FindFirstChild("Controllers")
		local v1 = Controllers and Controllers:FindFirstChild("SpecialController")

		if not v1 then
			return nil
		end

		return require(v1)
	end)

	if ok and type(result) == "table" and result.ChargeSpring then
		tbl9.controller = result
		return result
	end

	return nil
end

local function func35(arg1)
	if flag2 and (tbl10.Ronin[arg1] or arg1:find("Samurai") or arg1:find("Ronin")) then
		return true
	end

	if flag3 and (tbl10.Kazana[arg1] or arg1:find("Kazana")) then
		return true
	end

	return false
end

local function func36(arg1)
	if arg1 and arg1.Type == "ActionActivatable" then
		return math.clamp(tonumber((arg1.Metadata or {}).MaxActions) or 1, 1, 2)
	end
	return 1
end

local function func37(arg1)
	if tbl9.patched then
		return true
	end

	local ChargeSpring = arg1.ChargeSpring

	if type(ChargeSpring) ~= "table" then
		return false
	end

	local get = ChargeSpring.get

	if type(get) ~= "function" then
		return false
	end

	rawset(ChargeSpring, "get", function(arg1, arg2)
		local ok, result = pcall(get, arg1, arg2)

		if type(result) == "number" then
			tbl9.rawCharge = math.clamp(result, 0, 1)
		end

		if (flag2 or flag3) and func35(tostring(LocalPlayer:GetAttribute("Gameplay_Style") or "")) then
			return math.min(tbl9.value, 1)
		end

		return ok and result or 0
	end)

	tbl9.patched = {spring = ChargeSpring, get = get}
	return true
end

local function func38()
	if not (flag2 or flag3) then
		return
	end

	local str = tostring(LocalPlayer:GetAttribute("Gameplay_Style") or "")

	if not func35(str) then
		return
	end

	local v1 = func34()

	if not v1 then
		return
	end

	if not tbl9.patched and not func37(v1) then
		return
	end

	local v4

	pcall(function()
		if v1.Special and v1.Special.get then
			v4 = v1.Special:get()
		end
	end)

	if not v4 then
		pcall(function()
			LocalPlayer:SetAttribute("Special_CooldownTimestamp", 0)
			LocalPlayer:SetAttribute("Special_Charge", 1)
			LocalPlayer:SetAttribute("SpecialCharge", 1)
		end)
		return
	end

	tbl9.value = func36(v4)
	local Type = v4.Type

	if Type == "Charge" then
		pcall(function()
			if v1.ChargeVisibility and v1.ChargeVisibility.get and v1.ChargeVisibility:get() ~= true then
				v1.ChargeVisibility:set(true)
			end
			if v1.Charge and v1.Charge.set then
				v1.Charge:set(tbl9.value)
			end
		end)
		return
	end

	if Type == "Activation" then
		pcall(function()
			if LocalPlayer:GetAttribute("Special_CooldownTimestamp") ~= 0 then
				LocalPlayer:SetAttribute("Special_CooldownTimestamp", 0)
			end
		end)
		return
	end

	if Type == "Action" or Type == "ActionActivatable" then
		local v2 = tonumber((v4.Metadata or {}).Requirement) or 0

		if v2 <= 0 then
			v2 = 1
		end

		local v3 = v2 * tbl9.value

		pcall(function()
			if LocalPlayer:GetAttribute("Special_Charge") ~= v3 then
				LocalPlayer:SetAttribute("Special_Charge", v3)
			end
		end)
	end
end

local function func39()
	pcall(func38)
end

local function func40()
	local v1 = func34()

	if v1 then
		func37(v1)
	end

	pcall(func38)
end

local function func41()
	if not flag8 then
		return
	end

	local Character = LocalPlayer.Character
	local v1 = Character and Character:FindFirstChildOfClass("Humanoid")

	if not v1 then
		return
	end

	local State = v1:GetState()

	if State == Enum.HumanoidStateType.Jumping or State == Enum.HumanoidStateType.Freefall then
		return
	end

	if v1.MoveDirection.Magnitude > 0.05 then
		return
	end

	num8 = num8 + 0.22
	v1:Move(Vector3.new(math.sin(num8), 0, math.cos(num8)), true)
end

local function func42(arg1)
	local v1 = string.lower(tostring(arg1 or ""))

	for _, v2 in ipairs(tbl5) do
		if v1:find(string.lower(v2), 1, true) then
			return true
		end
	end

	return false
end

local function func43()
	if not flag13 then
		return
	end
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and func42(player.Name) then
			local v2 = "Moderator detected: " .. player.Name .. " - leaving"
			local num = 5

			pcall(function()
				v1:Notify({Title = "KingsHub", Description = tostring(v2), Time = num or 6})
			end)

			pcall(function()
				LocalPlayer:Kick("Anti-Mod: " .. player.Name)
			end)

			return
		end
	end
end

Players.PlayerAdded:Connect(function(player)
	if flag13 and func42(player.Name) then
		local v2 = "Moderator joined: " .. player.Name
		local num = 5

		pcall(function()
			v1:Notify({Title = "KingsHub", Description = tostring(v2), Time = num or 6})
		end)

		pcall(function()
			LocalPlayer:Kick("Anti-Mod: " .. player.Name)
		end)
	end
end)

local function func44(player)
	if not player or player == LocalPlayer then
		return
	end

	pcall(function()
		if tbl4[player] == nil then
			tbl4[player] = {DisplayName = player.DisplayName, Name = player.Name}
		end
	end)

	local Character = player.Character

	if not Character then
		return
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if Humanoid then
		pcall(function()
			if tbl4[player] and tbl4[player].DisplayDistanceType == nil then
				tbl4[player].DisplayDistanceType = Humanoid.DisplayDistanceType
				tbl4[player].NameDisplayDistance = Humanoid.NameDisplayDistance
				tbl4[player].HealthDisplayDistance = Humanoid.HealthDisplayDistance
			end

			Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			Humanoid.NameDisplayDistance = 0
			Humanoid.HealthDisplayDistance = 0
		end)
	end

	for _, descendant in ipairs(Character:GetDescendants()) do
		if descendant:IsA("BillboardGui") then
			pcall(function()
				if not tbl4[descendant] then
					tbl4[descendant] = descendant.Enabled
				end
				descendant.Enabled = false
			end)
		elseif descendant:IsA("TextLabel") or descendant:IsA("TextBox") then
			local Parent = descendant.Parent
			if Parent and (Parent:IsA("BillboardGui") or Parent:IsA("SurfaceGui")) then
				pcall(function()
					if tbl4[descendant] == nil then
						tbl4[descendant] = descendant.Text
					end
					descendant.Text = ""
				end)
			end
		end
	end
end

local function func45(player)
	if not player then
		return
	end

	local Character = player.Character

	if not Character then
		return
	end

	local v1 = tbl4[player]
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if Humanoid and type(v1) == "table" then
		pcall(function()
			if v1.DisplayDistanceType ~= nil then
				Humanoid.DisplayDistanceType = v1.DisplayDistanceType
			end

			if v1.NameDisplayDistance ~= nil then
				Humanoid.NameDisplayDistance = v1.NameDisplayDistance
			end

			if v1.HealthDisplayDistance ~= nil then
				Humanoid.HealthDisplayDistance = v1.HealthDisplayDistance
			end
		end)
	end

	for _, descendant in ipairs(Character:GetDescendants()) do
		if tbl4[descendant] ~= nil then
			pcall(function()
				if descendant:IsA("BillboardGui") then
					descendant.Enabled = tbl4[descendant] and true or false
				elseif descendant:IsA("TextLabel") or descendant:IsA("TextBox") then
					descendant.Text = tostring(tbl4[descendant])
				end
			end)
		end
	end
end

local function func46()
	for _, player in pairs(Players:GetPlayers()) do
		func44(player)
	end
end

local function func47()
	for _, player in pairs(Players:GetPlayers()) do
		func45(player)
	end
	tbl4 = {}
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		if flag14 then
			task.defer(function()
				func44(player)
			end)
		end
	end)
end)

for _, player in pairs(Players:GetPlayers()) do
	player.CharacterAdded:Connect(function()
		if flag14 then
			task.defer(function()
				func44(player)
			end)
		end
	end)
end

local function func48()
	for k, v1 in pairs(tbl3) do
		pcall(function()
			if v1 then
				v1:Destroy()
			end
		end)
		tbl3[k] = nil
	end
end

local function func49()
	if not flag15 then
		return
	end

	local v1 = math.max(5, num5 or 25)

	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			local Character = player.Character
			local v2 = Character and Character:FindFirstChild("HumanoidRootPart")

			if not v2 then
				if tbl3[player] then
					tbl3[player]:Destroy()
					tbl3[player] = nil
				end
			else
				local LookVector = v2.CFrame.LookVector
				local v3 = v2.Position + Vector3.new(0, 1.5, 0)
				local v4 = v3 + LookVector * v1
				local v6 = tbl3[player]

				if not v6 or not v6.Parent then
					local part = Instance.new("Part")
					v6 = part
					part.Name = "PredictAimLine"
					part.Anchored = true
					part.CanCollide = false
					part.CanQuery = false
					part.Material = Enum.Material.Neon
					part.Color = v5
					part.Transparency = 0.35
					part.Parent = workspace
					tbl3[player] = part
				end

				local v7 = (v3 + v4) / 2
				local v8 = v4 - v3
				v6.Size = Vector3.new(0.2, 0.2, v8.Magnitude)
				v6.CFrame = CFrame.lookAt(v7, v4)
				v6.Color = v5
			end
		end
	end
end

Players.PlayerRemoving:Connect(function(player)
	if tbl3[player] then
		tbl3[player]:Destroy()
		tbl3[player] = nil
	end
end)

local function func50()
	if v13 then
		pcall(function()
			v13:Destroy()
		end)
		v13 = nil
	end
end

local function func51()
	for _, child in pairs(workspace:GetChildren()) do
		local str = tostring(child.Name or "")
		if (str:find("CLIENT_BALL") or str:find("BALL")) and child:IsA("Model") then
			local BasePart = child:FindFirstChildWhichIsA("BasePart")
			if BasePart then
				return BasePart, BasePart.AssemblyLinearVelocity
			end
		end
	end
	return nil, nil
end

local function func52(arg1, arg2)
	local Position = arg1.Position
	local Y = Position.Y

	pcall(function()
		local Map = workspace:FindFirstChild("Map")
		local v1 = Map and Map:FindFirstChild("Court")

		if v1 then
			Y = v1.Position.Y + v1.Size.Y / 2 + 0.5
		end
	end)

	if not arg2 or arg2.Magnitude < 0.5 then
		return Vector3.new(Position.X, Y, Position.Z)
	end

	local Gravity = workspace.Gravity

	if Gravity < 1 then
		Gravity = 196.2
	end

	local Y1 = Position.Y
	local Y2 = arg2.Y
	local v1 = -0.5 * Gravity
	local v2 = Y1 - Y
	local v3 = Y2 * Y2 - 4 * v1 * v2
	local v7

	if v3 >= 0 and math.abs(v1) > 9.9999999999999995e-07 then
		local v4 = math.sqrt(v3)
		local v5 = (-Y2 + v4) / (2 * v1)
		local v6 = (-Y2 - v4) / (2 * v1)

		if v5 > 0.05 and v6 > 0.05 then
			v7 = math.min(v5, v6)
		elseif v5 > 0.05 then
			v7 = v5
		elseif v6 > 0.05 then
			v7 = v6
		end
	end

	if not v7 or v7 > 4 then
		return Vector3.new(Position.X + arg2.X * 0.35, Y, Position.Z + arg2.Z * 0.35)
	end

	local vector3 = Vector3.new(Position.X + arg2.X * v7, Y, Position.Z + arg2.Z * v7)
	local v8 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

	if v8 then
		local vector31 = Vector3.new(vector3.X - v8.Position.X, 0, vector3.Z - v8.Position.Z)
		if vector31.Magnitude > 0.1 then
			local v9 = vector3 - vector31.Unit * 1.2
			vector3 = Vector3.new(v9.X, Y, v9.Z)
		end
	end

	return vector3
end

local function func53()
	if not flag16 then
		return
	end

	local v1, v2 = func51()

	if not v1 then
		if v13 then
			v13.Transparency = 1
		end
		return
	end

	local v3 = func52(v1, v2)

	if not v13 or not v13.Parent then
		local part = Instance.new("Part")
		part.Name = "KingsHub_OptimalSpot"
		part.Anchored = true
		part.CanCollide = false
		part.CanQuery = false
		part.Material = Enum.Material.Neon
		part.Color = Color3.fromRGB(80, 220, 255)
		part.Size = Vector3.new(3.2, 0.2, 3.2)
		part.Transparency = 0.35
		part.Shape = Enum.PartType.Cylinder
		part.Parent = workspace
		v13 = part
		part.Size = Vector3.new(0.25, 3.4, 3.4)
	end

	local v4 = v13
	v4.Transparency = 0.3
	v4.CFrame = CFrame.new(v3) * CFrame.Angles(0, 0, math.rad(90))
end

local str2 = "SupernovaScoreEffect"
local tbl11 = {}
local tbl12 = {}
local flag25 = false
local flag26 = false
local str3 = "Default"
local tbl13 = {"Default"}

local function func54()
	tbl11 = {}
	local tbl = {}

	local function func(arg1)
		local str = tostring(arg1 or "")

		if str == "" or tbl[str] then
			return
		end

		tbl[str] = true
		table.insert(tbl11, str)
	end

	pcall(function()
		local Assets = ReplicatedStorage:FindFirstChild("Assets")

		if Assets then
			local v1 = Assets:FindFirstChild("ScoreEffect") or Assets:FindFirstChild("ScoreEffects")

			if v1 then
				for _, child in ipairs(v1:GetChildren()) do
					local str = tostring(child.Name or "")
					if not (str == "" or tbl[str]) then
						tbl[str] = true
						table.insert(tbl11, str)
					end
				end
			end

			local Effects = Assets:FindFirstChild("Effects")

			if Effects then
				for _, v2 in ipairs({"GroundHit1", "GroundHit2"}) do
					if Effects:FindFirstChild(v2) then
						local str1 = tostring(v2 or "")
						if not (str1 == "" or tbl[str1]) then
							tbl[str1] = true
							table.insert(tbl11, str1)
						end
					end
				end
			end
		end

		local Content = ReplicatedStorage:FindFirstChild("Content")
		local v3 = Content and Content:FindFirstChild("Item")
		local v4 = v3 and v3:FindFirstChild("Entities")

		if v4 then
			for _, child1 in ipairs(v4:GetChildren()) do
				if child1:IsA("ModuleScript") then
					local ok, result = pcall(require, child1)
					if ok and type(result) == "table" then
						local str2 = tostring(result.Type or result.type or "")
						if str2:lower():find("score") or str2 == "ScoreEffect" then
							local str3 = tostring(child1.Name or "")
							if not (str3 == "" or tbl[str3]) then
								tbl[str3] = true
								table.insert(tbl11, str3)
							end
						end
					end
				end
			end
		end
	end)

	local v1 = tbl11
	table.sort(v1)

	if #v1 == 0 then
		func("SupernovaScoreEffect")
		func("FlameScoreEffect")
		func("2026ScoreEffect")
	end

	if not tbl[str2] then
		str2 = tbl11[1]
	end
end

local function func55()
	tbl13 = {}
	local tbl = {}

	pcall(function()
		local tbl1 = {}

		for _, v1 in ipairs({"Assets", "Content", "Modules", "Shared", "ReplicatedStorage"}) do
			local v2 = v1 == "ReplicatedStorage" and ReplicatedStorage or ReplicatedStorage:FindFirstChild(v1)
			if v2 then
				table.insert(tbl1, v2)
			end
		end

		local tbl2 = {
			"PlayerCard",
			"PlayerCards",
			"Cards",
			"ProfileCard",
			"ScoreCard",
			"PlayerCardEntities",
			"Card",
			"BrawlerCard",
		}

		for _, v3 in ipairs(tbl1) do
			for _, v4 in ipairs(tbl2) do
				local v5 = v3:FindFirstChild(v4, true)
				if v5 then
					for _, child in ipairs(v5:GetChildren()) do
						local str = tostring(child.Name or "")
						if not (str == "" or tbl[str]) then
							tbl[str] = true
							table.insert(tbl13, str)
						end
					end
				end
			end
		end

		local Content = ReplicatedStorage:FindFirstChild("Content")
		local v6 = Content and Content:FindFirstChild("Item")
		local v7 = v6 and v6:FindFirstChild("Entities")

		if v7 then
			for i, child1 in ipairs(v7:GetChildren()) do
				if child1:IsA("ModuleScript") then
					local ok, result = pcall(require, child1)
					if ok and type(result) == "table" then
						local str1 = tostring(result.Type or result.type or result.ItemType or "")
						local v8 = str1:lower()

						if
							v8:find("playercard")
							or v8:find("profilecard")
							or str1 == "Card"
							or v8 == "card"
							or v8:find("scorecard")
						then
							local str2 = tostring(child1.Name or "")
							if not (str2 == "" or tbl[str2]) then
								tbl[str2] = true
								table.insert(tbl13, str2)
							end
						end

						local v9 = child1.Name:lower()

						if
							v9:find("playercard")
							or v9:find("brainrot")
							or v9:find("beller")
							or v9:find("card") and (v9:find("202") or v9:find("gold") or v9:find("neon"))
						then
							local str3 = tostring(child1.Name or "")
							if not (str3 == "" or tbl[str3]) then
								tbl[str3] = true
								table.insert(tbl13, str3)
							end
						end
					else
						local v10 = child1.Name:lower()
						if v10:find("playercard") or v10:find("brainrot") or v10:find("beller") then
							local str4 = tostring(child1.Name or "")
							if not (str4 == "" or tbl[str4]) then
								tbl[str4] = true
								table.insert(tbl13, str4)
							end
						end
					end
				end
				if i % 40 == 0 then
					task.wait()
				end
			end
		end

		local Assets = ReplicatedStorage:FindFirstChild("Assets")

		if Assets then
			for _, descendant in ipairs(Assets:GetDescendants()) do
				if descendant:IsA("ModuleScript") or descendant:IsA("Folder") then
					local v11 = descendant.Name:lower()
					if
						v11:find("playercard")
						or v11:find("brainrot")
						or v11:find("beller")
						or v11:find("card") and not v11:find("scoreeffect")
					then
						local str5 = tostring(descendant.Name or "")
						if not (str5 == "" or tbl[str5]) then
							tbl[str5] = true
							table.insert(tbl13, str5)
						end
					end
				end
			end
		end
	end)

	local v1 = tbl13
	table.sort(v1)

	if #v1 == 0 then
		tbl13 = {
			"Default",
			"2026PlayerCard",
			"BasicPlayerCard",
			"BrainrotPlayerCard",
			"BellerPlayerCard",
			"GoldPlayerCard",
			"NeonPlayerCard",
		}
	end

	if not str3 or str3 == "" or not tbl[str3] then
		local flag = false

		for _, v2 in ipairs(tbl13) do
			if v2 == str3 then
				flag = true
				break
			end
		end

		if not flag then
			str3 = tbl13[1]
		end
	end
end

func54()
func55()

local function func56()
	local HitGround

	pcall(function()
		HitGround = ReplicatedStorage.Packages._Index["sleitnick_knit@1.7.0"].knit.Services.BallService.RE.HitGround
	end)

	if HitGround then
		return HitGround
	end

	pcall(function()
		local Packages = ReplicatedStorage:FindFirstChild("Packages")
		local v1 = Packages and Packages:FindFirstChild("_Index")
		local v2 = v1 and v1:FindFirstChild("sleitnick_knit@1.7.0")
		local v3 = v2 and v2:FindFirstChild("knit")
		local v4 = v3 and v3:FindFirstChild("Services")
		local v5 = v4 and v4:FindFirstChild("BallService")
		local v6 = v5 and v5:FindFirstChild("RE")
		HitGround = v6 and v6:FindFirstChild("HitGround")
	end)

	return HitGround
end

local function func57(arg1)
	local v1 = func56()

	if not v1 then
		return false, "no HitGround"
	end

	local v2 = str2
	local flag = true

	if v2 == "GroundHit1" or v2 == "GroundHit2" then
		flag = v2 == "GroundHit2"
		v2 = nil
	end

	local tbl = {
		arg1,
		flag,
		false,
		5,
		v2,
		workspace:FindFirstChild(LocalPlayer.Name) or LocalPlayer.Character,
		Vector3.new(0, 1, 0),
	}

	local flag1 = false

	if type(firesignal) == "function" then
		flag1 = pcall(function()
			firesignal(v1.OnClientEvent, table.unpack(tbl))
		end)
	end

	if not flag1 and type(getconnections) == "function" then
		pcall(function()
			for _, v2 in ipairs(getconnections(v1.OnClientEvent)) do
				pcall(function()
					if v2.Fire then
						v2:Fire(table.unpack(tbl))
					elseif v2.Function then
						v2.Function(table.unpack(tbl))
					end
				end)
			end
			flag1 = true
		end)
	end

	return flag1
end

local function func58()
	local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	local v2 = v1 and v1.Position or Vector3.new(0, 5, 0)
	local v5

	pcall(function()
		local Map = workspace:FindFirstChild("Map")
		local v1 = Map and Map:FindFirstChild("BallCollideOnly")
		local v2 = v1 and v1:FindFirstChild("Net")

		if not v2 and Map then
			v2 = Map:FindFirstChild("Net", true)
		end

		v2 = v2 or workspace:FindFirstChild("Net", true)

		if v2 then
			v5 = v2:IsA("BasePart") and v2.Position or v2:GetPivot().Position
		end
	end)

	if v5 then
		local v3 = v2 - v5
		local vector3 = Vector3.new(v3.X, 0, v3.Z)
		local vector31

		if vector3.Magnitude < 0.5 then
			vector31 = Vector3.new(0, 0, 1)
		else
			vector31 = vector3.Unit
		end

		local v4 = v5 - vector31 * 6
		return Vector3.new(v4.X, v5.Y + 2.5, v4.Z)
	end

	local vector32 = Vector3.new(v2.X, math.max(v2.Y, 4), -v2.Z)

	if math.abs(v2.Z) < 2 then
		vector32 = v2 + Vector3.new(0, 3, 12)
	end

	return vector32
end

local function func59()
	local v2 = func58()
	if func57(v2) then
		pcall(function()
			Vector3.new(v2.X, v2.Y + 1.5, v2.Z * 0.3)
			func57(v2)
		end)

		local v3 = func("score_test") .. ": " .. tostring(str2)
		local num = 3

		pcall(function()
			v1:Notify({Title = "KingsHub", Description = tostring(v3), Time = num or 6})
		end)
	else
		local v4 = func("score_test") .. " - fail (no HitGround/firesignal)"
		local num1 = 4

		pcall(function()
			v1:Notify({Title = "KingsHub", Description = tostring(v4), Time = num1 or 6})
		end)
	end
end

local function func60(arg1)
	if not arg1 or arg1 == "" then
		return false
	end

	local v4

	pcall(function()
		v4 = require(ReplicatedStorage.Packages.Knit).GetController("InventoryController")
	end)

	local flag = false

	if v4 then
		for _, v1 in ipairs({"Equip", "equip", "SetEquipped", "EquipItem", "Select"}) do
			if type(v4[v1]) == "function" then
				if pcall(function()
					v4[v1](v4, arg1)
				end) then
					flag = true
				end
			end
		end
		for _, v2 in ipairs({"Equipped", "equipped", "Loadout", "Selected"}) do
			local v3 = v4[v2]
			if type(v3) == "table" then
				if type(v3.set) == "function" then
					pcall(function()
						v3:set(arg1)
					end)
					flag = true
				end
				if type(v3.Set) == "function" then
					pcall(function()
						v3:Set(arg1)
					end)
					flag = true
				end
			end
		end
	end

	pcall(function()
		LocalPlayer:SetAttribute("Equipped_" .. tostring(arg1), true)
		LocalPlayer:SetAttribute("SelectedItem", arg1)
	end)

	return flag
end

local function func61()
	local pcallRef = pcall

	pcallRef(function()
		local v1 = str3
		LocalPlayer:SetAttribute("PlayerCard", v1)
		LocalPlayer:SetAttribute("SelectedPlayerCard", v1)
		LocalPlayer:SetAttribute("EquippedPlayerCard", v1)
		LocalPlayer:SetAttribute("EquippedPlayerCardId", v1)
		LocalPlayer:SetAttribute("Card", v1)
	end)

	pcallRef(func60, str3)
end

local function func62()
	func61()
	local flag = false
	local pcallRef = pcall

	pcallRef(function()
		local Knit = require(ReplicatedStorage.Packages.Knit)
		local v1 = Knit.GetController("InventoryController")

		if v1 then
			for _, v2 in ipairs({"Equip", "equip", "Preview", "preview", "ShowCard", "EquipPlayerCard"}) do
				if type(v1[v2]) == "function" then
					local pcallRef = pcall

					pcallRef(function()
						v1[v2](v1, str3)
					end)

					pcallRef(function()
						v1[v2](v1, "PlayerCard", str3)
					end)

					flag = true
				end
			end
		end

		local v3 = Knit.GetController("UIController") or Knit.GetController("CardController") or Knit.GetController("PlayerCardController")

		if v3 then
			for _, v4 in ipairs({"ShowPlayerCard", "PlayCard", "PreviewCard", "DisplayCard", "Show"}) do
				if type(v3[v4]) == "function" then
					pcall(function()
						v3[v4](v3, str3)
					end)
					flag = true
				end
			end
		end
	end)

	pcallRef(function()
		local Content = ReplicatedStorage:FindFirstChild("Content")
		local v1 = Content and Content:FindFirstChild("Item")
		local v2 = v1 and v1:FindFirstChild("Entities")
		local v3 = v2 and v2:FindFirstChild(str3)

		if v3 and v3:IsA("ModuleScript") then
			local ok, result = pcall(require, v3)
			if ok and type(result) == "table" then
				for _, v4 in ipairs({"Play", "play", "Preview", "Run", "Activate", "Show"}) do
					if type(result[v4]) == "function" then
						pcall(function()
							result[v4](result, LocalPlayer)
						end)
						flag = true
					end
				end
			end
		end
	end)

	pcallRef(function()
		local function func(arg1, arg2)
			if not arg1 or arg2 > 5 then
				return
			end
			for _, child in ipairs(arg1:GetChildren()) do
				local v1 = string.lower(child.Name)

				if (v1:find("card") or v1:find("scoreboard") or v1:find("showcase")) and (child:IsA("RemoteEvent") or child:IsA("BindableEvent")) then
					pcall(function()
						if firesignal and child.OnClientEvent then
							firesignal(child.OnClientEvent, str3, LocalPlayer.Name)
							flag = true
						end
						if child:IsA("BindableEvent") then
							child:Fire(str3, LocalPlayer)
							flag = true
						end
					end)
				end

				if child:IsA("Folder") or child.Name == "RE" or child.Name == "RF" then
					func(child, arg2 + 1)
				end
			end
		end

		local Packages = ReplicatedStorage:FindFirstChild("Packages")
		local v1 = Packages and Packages:FindFirstChild("_Index")
		local v2 = v1 and v1:FindFirstChild("sleitnick_knit@1.7.0")
		local v3 = v2 and v2:FindFirstChild("knit") and v2.knit:FindFirstChild("Services")

		if v3 then
			func(v3, 0)
		end
	end)

	pcallRef(function()
		local v1 = func58()
		local v2 = func56()

		if v2 and type(firesignal) == "function" then
			firesignal(
				v2.OnClientEvent,
				v1,
				true,
				false,
				5,
				str2,
				workspace:FindFirstChild(LocalPlayer.Name) or LocalPlayer.Character,
				Vector3.new(0, 1, 0)
			)
		end
	end)

	return flag
end

local function func63()
	pcall(func55)

	local v2 = pcall(function()
		func62()
	end)

	local v3 = func("card_test") .. ": " .. tostring(str3) .. (v2 and "" or " (partial)")
	local num = 3

	pcall(function()
		v1:Notify({Title = "KingsHub", Description = tostring(v3), Time = num or 6})
	end)
end

local function func64()
	for _, v1 in pairs(tbl12) do
		pcall(function()
			v1:Disconnect()
		end)
	end

	tbl12 = {}
	flag25 = false
	flag26 = false
end

local function func65()
	if #tbl12 > 0 then
		return
	end

	local v1 = func56()

	if not v1 then
		return
	end

	table.insert(tbl12, v1.OnClientEvent:Connect(function(...)
		for _, v1 in pairs({...}) do
			if tostring(v1) == LocalPlayer.Name then
				flag26 = true
				break
			end
		end
	end))

	local function func(arg1)
		if flag25 or not flag26 or not flag20 then
			return
		end

		flag25 = true
		func57(arg1)
		task.wait(0.5)
		flag25 = false
		flag26 = false
	end

	table.insert(tbl12, workspace.ChildAdded:Connect(function(child)
		if child.Name == "HitIndicator" and child.Color == Color3.fromRGB(0, 255, 0) then
			func(child.Position)
		end
	end))
end

local tbl14 = {}

local function func66(arg1, arg2, arg3)
	if not arg1 then
		return
	end

	local v1 = tostring(arg1) .. "." .. arg2

	if tbl14[v1] == nil then
		local ok, result = pcall(function()
			return arg1[arg2]
		end)
		if ok then
			tbl14[v1] = {obj = arg1, prop = arg2, val = result}
		end
	end

	pcall(function()
		arg1[arg2] = arg3
	end)
end

local v20
local v21
local num14 = 0

local tbl15 = {
	Title = true,
	ScoreEffect = true,
	Ball = true,
	Jersey = true,
	PlayerCard = true,
	ProfileArt = true,
	Card = true,
	Emote = true,
	Banner = true,
	NameTag = true,
	Animation = true,
	Gesture = true,
	Dance = true,
	Effect = true,
}

local function func67()
	local ok, result = pcall(function()
		return require(ReplicatedStorage.Packages.Knit)
	end)

	if not ok or type(result) ~= "table" or type(result.GetController) ~= "function" then
		return nil
	end

	local ok1, result1 = pcall(function()
		return result.GetController("InventoryController")
	end)

	if ok1 and type(result1) == "table" then
		return result1
	end

	return nil
end

local function func68(arg1)
	local ok, result = pcall(require, arg1)

	if ok and type(result) == "table" and result.Type then
		return tostring(result.Type), result
	end

	return nil, nil
end

local function func69(arg1)
	if not arg1 then
		return
	end

	local v1 = tick()

	if v1 - (num14 or 0) < 1.5 then
		return
	end

	num14 = v1
	local tbl = {}

	for _, v2 in ipairs({"Inventory", "Shop", "Store", "Cosmetics", "Collection", "Items", "Menu", "HUD"}) do
		local v3 = arg1:FindFirstChild(v2, true)
		if v3 then
			table.insert(tbl, v3)
		end
	end

	if #tbl == 0 then
		table.insert(tbl, arg1)
	end

	local num = 0

	for _, v4 in ipairs(tbl) do
		for _, descendant in ipairs(v4:GetDescendants()) do
			num = num + 1

			if num > 400 then
				return
			end

			if descendant:IsA("GuiObject") then
				local v5 = string.lower(tostring(descendant.Name or ""))

				if v5:find("lock", 1, true) or v5:find("padlock", 1, true) or v5:find("blocked", 1, true) then
					if
						descendant:IsA("ImageLabel")
						or descendant:IsA("ImageButton")
						or descendant:IsA("Frame")
						or descendant:IsA("TextLabel")
					then
						pcall(function()
							descendant.Visible = false
						end)
					end
				end

				if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
					local v6 = string.lower(tostring(descendant.Text or ""))
					if v6:find("locked") or v6:find("bloqueado") or v6:find("not owned") then
						pcall(function()
							descendant.Visible = false
						end)
					end
				end
			end
		end
	end
end

local function func70()
	local v1 = func67()

	if not v1 or not v1.Inventory then
		return false, "no InventoryController"
	end

	local ok, result = pcall(function()
		return v1.Inventory:get()
	end)

	if not ok or type(result) ~= "table" then
		return false, "inventory get failed"
	end

	if not v20 then
		local tbl = {}

		for k, v2 in pairs(result) do
			tbl[k] = v2
		end

		v20 = tbl
	end

	if v21 then
		if not pcall(function()
			v1.Inventory:set(v21)
		end) then
			return false, "inventory set failed"
		end

		local num = 0

		for _ in pairs(v21) do
			num = num + 1
		end

		return true, num
	end

	local tbl1 = {}

	for k1, v3 in pairs(v20) do
		tbl1[k1] = v3
	end

	local Content = ReplicatedStorage:FindFirstChild("Content")
	local v4 = Content and Content:FindFirstChild("Item")
	local v5 = v4 and v4:FindFirstChild("Entities")

	if not v5 then
		return false, "no Item.Entities"
	end

	local num1 = 0
	local Children = v5:GetChildren()

	for i, v6 in ipairs(Children) do
		if v6:IsA("ModuleScript") and not tbl1[v6.Name] then
			local v7 = func68(v6)
			if v7 and tbl15[v7] then
				tbl1[v6.Name] = 1
				num1 = num1 + 1
			end
		end
		if i % 25 == 0 then
			task.wait()
		end
	end

	v21 = tbl1

	if not pcall(function()
		v1.Inventory:set(tbl1)
	end) then
		return false, "inventory set failed"
	end

	return true, num1
end

local function func71()
	if not v20 then
		return
	end

	local v1 = func67()

	if v1 and v1.Inventory then
		pcall(function()
			v1.Inventory:set(v20)
		end)
	end

	v20 = nil
end

local function func72()
	for _, v1 in pairs(tbl2) do
		pcall(function()
			v1:Disconnect()
		end)
	end

	tbl2 = {}
	flag22 = false
	local pcallRef = pcall
	pcallRef(func71)

	pcallRef(function()
		LocalPlayer:SetAttribute("KH_UnlockAllVisual", nil)
	end)
end

local function func73()
	func72()
	flag22 = true
	local v2 = func("unlock_on") .. " ..."
	local num = 3

	pcall(function()
		v1:Notify({Title = "KingsHub", Description = tostring(v2), Time = num or 6})
	end)

	task.spawn(function()
		local v2, v3 = func70()

		if not flag22 then
			return
		end

		if v2 then
			local v4 = func("unlock_on") .. " (+" .. tostring(v3) .. ")"
			local num = 5

			pcall(function()
				v1:Notify({Title = "KingsHub", Description = tostring(v4), Time = num or 6})
			end)
		else
			local v5 = func("unlock_on") .. " (UI only)"
			local num1 = 5

			pcall(function()
				v1:Notify({Title = "KingsHub", Description = tostring(v5), Time = num1 or 6})
			end)
		end

		local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")

		if PlayerGui then
			func69(PlayerGui)
			table.insert(tbl2, PlayerGui.DescendantAdded:Connect(function(descendant)
				if not flag22 then
					return
				end

				local v1 = string.lower(tostring(descendant.Name or ""))

				if v1:find("lock") or v1:find("item") or v1:find("card") then
					task.delay(0.4, function()
						if flag22 then
							local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
							if PlayerGui then
								func69(PlayerGui)
							end
						end
					end)
				end
			end))
		end
	end)

	pcall(function()
		LocalPlayer:SetAttribute("KH_UnlockAllVisual", true)
	end)
end

local function func74()
	for _, v1 in pairs(tbl14) do
		if type(v1) == "table" and v1.obj and v1.prop then
			pcall(function()
				v1.obj[v1.prop] = v1.val
			end)
		end
	end

	tbl14 = {}
	local v2 = str1 or "Balanced"

	local function func(arg1)
		if not arg1 then
			return
		end
		for _, descendant in ipairs(arg1:GetDescendants()) do
			if
				descendant:IsA("ParticleEmitter")
				or descendant:IsA("Trail")
				or descendant:IsA("Beam")
				or descendant:IsA("Smoke")
				or descendant:IsA("Fire")
				or descendant:IsA("Sparkles")
			then
				func66(descendant, "Enabled", false)
			end
		end
	end

	func(workspace:FindFirstChild("Map"))

	for _, player in pairs(Players:GetPlayers()) do
		func(player.Character)
	end

	if v2 == "Light" then
		pcall(function()
			settings().Rendering.QualityLevel = Enum.QualityLevel.Level05
		end)
		return
	end

	func66(Lighting, "GlobalShadows", false)
	func66(Lighting, "EnvironmentDiffuseScale", 0)
	func66(Lighting, "EnvironmentSpecularScale", 0)

	for _, child in ipairs(Lighting:GetChildren()) do
		if
			child:IsA("BloomEffect")
			or child:IsA("BlurEffect")
			or child:IsA("SunRaysEffect")
			or child:IsA("ColorCorrectionEffect")
			or child:IsA("DepthOfFieldEffect")
		then
			func66(child, "Enabled", false)
		end
	end

	local function func1(arg1)
		if not arg1 then
			return
		end
		for _, descendant in ipairs(arg1:GetDescendants()) do
			if descendant:IsA("PointLight") or descendant:IsA("SpotLight") or descendant:IsA("SurfaceLight") then
				func66(descendant, "Enabled", false)
			end
		end
	end

	func1(workspace:FindFirstChild("Map"))

	for _, player1 in pairs(Players:GetPlayers()) do
		func1(player1.Character)
	end

	pcall(function()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level03
	end)

	if v2 ~= "Maximum" then
		return
	end

	func66(Lighting, "FogEnd", 1000000000)
	func66(Lighting, "Brightness", 1)
	local pcallRef = pcall

	pcallRef(function()
		Lighting.Technology = Enum.Technology.Compatibility
	end)

	pcallRef(function()
		Lighting.Ambient = Color3.fromRGB(120, 120, 120)
	end)

	pcallRef(function()
		Lighting.OutdoorAmbient = Color3.fromRGB(120, 120, 120)
	end)

	for _, child1 in ipairs(Lighting:GetChildren()) do
		if child1:IsA("Sky") then
			func66(child1, "StarCount", 0)
			func66(child1, "CelestialBodiesShown", false)
		elseif child1:IsA("Atmosphere") then
			func66(child1, "Density", 0)
			func66(child1, "Haze", 0)
		elseif child1:IsA("Clouds") then
			func66(child1, "Cover", 0)
		end
	end

	local Terrain = workspace:FindFirstChildOfClass("Terrain")

	if Terrain then
		func66(Terrain, "Decoration", false)
		func66(Terrain, "WaterWaveSize", 0)
	end

	pcall(function()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
	end)
end

local function func75()
	for _, v1 in pairs(tbl14) do
		if type(v1) == "table" and v1.obj and v1.prop then
			pcall(function()
				v1.obj[v1.prop] = v1.val
			end)
		end
	end
	tbl14 = {}
end

local function func76()
	local v2 = func("rb_sending")
	local num = 4

	pcall(function()
		v1:Notify({Title = "KingsHub", Description = tostring(v2), Time = num or 6})
	end)

	if not pcall(function()
		ReplicatedStorage.Packages._Index["sleitnick_knit@1.7.0"].knit.Services.SettingsService.RF.UpdateKeybind:InvokeServer("MouseButton1", true, "Spike" .. string.char(143))
	end) then
		local v3 = func("rb_fail")
		local num1 = 5

		pcall(function()
			v1:Notify({Title = "KingsHub", Description = tostring(v3), Time = num1 or 6})
		end)

		return
	end

	local v4 = func("rb_ok")
	local num2 = 4

	pcall(function()
		v1:Notify({Title = "KingsHub", Description = tostring(v4), Time = num2 or 6})
	end)

	task.wait(0.35)

	pcall(function()
		TeleportService:Teleport(game.PlaceId, LocalPlayer)
	end)
end

local function func77()
	local v2 = func("rb_sending")
	local num = 4

	pcall(function()
		v1:Notify({Title = "KingsHub", Description = tostring(v2), Time = num or 6})
	end)

	if not pcall(function()
		local UpdateKeybind = ReplicatedStorage:WaitForChild("Packages", 5):WaitForChild("_Index", 5):WaitForChild("sleitnick_knit@1.7.0", 5):WaitForChild("knit", 5):WaitForChild("Services", 5):WaitForChild("SettingsService", 5):WaitForChild("RF", 5):WaitForChild("UpdateKeybind", 5)
		local v1 = utf8.char(8203)
		local tbl = {"MouseButton1", true, "Spike" .. string.char(143)}
		local v2 = "Spike" .. v1 .. string.char(143)

		for _, v3 in ipairs({tbl, {"MouseButton1", true, v2}, {"MouseButton1", true, "Spike"}}) do
			pcall(function()
				if UpdateKeybind:IsA("RemoteFunction") then
					UpdateKeybind:InvokeServer(v3[1], v3[2], v3[3])
				else
					UpdateKeybind:FireServer(v3[1], v3[2], v3[3])
				end
			end)
			task.wait(0.05)
		end
	end) then
		local v3 = func("rb_fail")
		local num1 = 5

		pcall(function()
			v1:Notify({Title = "KingsHub", Description = tostring(v3), Time = num1 or 6})
		end)

		return
	end

	local v4 = func("rb_ok")
	local num2 = 4

	pcall(function()
		v1:Notify({Title = "KingsHub", Description = tostring(v4), Time = num2 or 6})
	end)

	task.wait(0.4)

	if not pcall(function()
		TeleportService:Teleport(game.PlaceId)
	end) then
		pcall(function()
			TeleportService:Teleport(game.PlaceId, LocalPlayer)
		end)
	end
end

local num15 = 0
local flag27 = false
local v9 = Color3.fromRGB(0, 255, 170)
local v10 = Color3.fromRGB(25, 28, 30)

RunService.Heartbeat:Connect(function()
	num15 = num15 + 1

	if flag8 then
		pcall(func41)
	end

	if (flag2 or flag3) and num15 % 6 == 0 then
		pcall(func39)
	end

	if flag1 and num15 % 4 == 0 then
		pcall(func4)
	end

	if flag15 and num15 % 5 == 0 then
		pcall(func49)
	end

	if flag16 and num15 % 3 == 0 then
		pcall(func53)
	end

	if num15 % 15 == 0 then
		if flag17 then
			pcall(func30)
		end
	end

	if flag14 and num15 % 45 == 0 then
		pcall(func46)
	end

	if flag22 and num15 % 300 == 0 then
		local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
		if PlayerGui then
			pcall(func69, PlayerGui)
		end
	end

	if flag and true and num15 % 900 == 0 then
		task.spawn(func3)
	end

	if flag13 and num15 % 60 == 0 then
		pcall(func43)
	end

	if flag6 then
		flag27 = false
		local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

		if v1 then
			if num15 % 12 == 0 then
				local Map = workspace:FindFirstChild("Map")
				local v2 = Map and Map:FindFirstChild("Court")

				if v2 and (v2.Position - vector3).Magnitude > 20 then
					func23()
					v17 = nil
					func26()
				end

				local v3 = func24()

				if v3 and v3 ~= v17 then
					v17 = v3
					func26()
				end
			end

			if not flag23 and num15 % 2 == 0 then
				local v4 = func27()

				if v4 then
					v18 = v4
				end

				v7.Color = v4 == "Left" and v9 or v10
				v8.Color = v4 == "Right" and v9 or v10
				v7.Transparency = v4 == "Left" and 0.15 or 0.35
				v8.Transparency = v4 == "Right" and 0.15 or 0.35
			end

			local v5 = v1.AssemblyLinearVelocity.Y > 8

			if not flag24 and v5 and os.clock() - num13 > 0.5 then
				func29()
			end

			flag24 = v5
		end
	elseif not flag27 then
		v7.Color = v10
		v8.Color = v10
		v7.Transparency = 0.35
		v8.Transparency = 0.35
		flag24 = false
		flag27 = true
	end
end)

LocalPlayer.CharacterAdded:Connect(function(character)
	v17 = nil
	v18 = nil
	flag23 = false
	local Humanoid = character:WaitForChild("Humanoid", 5)

	if Humanoid then
		Humanoid.Jumping:Connect(function(arg1)
			if arg1 and flag6 and os.clock() - num13 > 0.5 then
				task.wait()
				func29()
			end
		end)
	end
end)

local function func78()
	if v12 then
		pcall(function()
			v12:Destroy()
		end)
		v12 = nil
	end
end

local function func79()
	if v12 then
		pcall(function()
			v12:Destroy()
		end)
		v12 = nil
	end

	local v1 = LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 5)

	if not v1 then
		return
	end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "KingsHub_FPS"
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.DisplayOrder = 200
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	pcall(function()
		if gethui then
			screenGui.Parent = gethui()
		else
			screenGui.Parent = v1
		end
	end)

	if not screenGui.Parent then
		screenGui.Parent = v1
	end

	v12 = screenGui
	local textLabel = Instance.new("TextLabel")
	textLabel.Name = "FpsLabel"
	textLabel.AnchorPoint = Vector2.new(0.5, 0)
	textLabel.Position = UDim2.new(0.5, 0, 0, 8)
	textLabel.Size = UDim2.fromOffset(120, 28)
	textLabel.BackgroundColor3 = Color3.fromRGB(12, 14, 18)
	textLabel.BackgroundTransparency = 0.25
	textLabel.BorderSizePixel = 0
	textLabel.Text = "FPS: --"
	textLabel.TextColor3 = Color3.fromRGB(120, 255, 160)
	textLabel.TextSize = 16
	textLabel.Font = Enum.Font.GothamBold
	textLabel.Parent = screenGui
	local uICorner = Instance.new("UICorner")
	uICorner.CornerRadius = UDim.new(0, 8)
	uICorner.Parent = textLabel
	local uIStroke = Instance.new("UIStroke")
	uIStroke.Color = Color3.fromRGB(60, 200, 120)
	uIStroke.Thickness = 1
	uIStroke.Transparency = 0.4
	uIStroke.Parent = textLabel
	textLabel.Size = UDim2.fromOffset(340, 28)
	textLabel.Text = "KingsHub | --:--:-- | FPS: --"

	task.spawn(function()
		local num = 0
		local v1 = tick()
		local connection

		connection = RunService.RenderStepped:Connect(function()
			if not v12 or not v12.Parent then
				if connection then
					connection:Disconnect()
				end
				return
			end

			num = num + 1
			local v2 = tick()

			if v2 - v1 >= 0.5 then
				local v3 = math.floor(num / (v2 - v1) + 0.5)
				num = 0
				v1 = v2

				if textLabel and textLabel.Parent then
					local v4 = os.date("%H:%M:%S")
					local num1 = 0

					pcall(function()
						if LocalPlayer.GetNetworkPing then
							num1 = math.floor(LocalPlayer:GetNetworkPing() * 1000 + 0.5)
						end
					end)

					if num1 <= 0 then
						pcall(function()
							local v1 = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]
							if v1 then
								num1 = math.floor(v1:GetValue())
							end
						end)
					end

					textLabel.Text = "KingsHub" .. " | " .. v4 .. " | " .. tostring(v3) .. " FPS | " .. tostring(num1) .. " ms"

					if v3 >= 50 then
						textLabel.TextColor3 = Color3.fromRGB(120, 255, 160)
					elseif v3 >= 30 then
						textLabel.TextColor3 = Color3.fromRGB(255, 220, 80)
					else
						textLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
					end
				end
			end
		end)
	end)
end

local function func80()
	task.wait(0.05)

	local Window = v1:CreateWindow({
		Title = "KingsHub",
		Center = true,
		AutoShow = true,
		Resizable = true,
		ShowCustomCursor = false,
		UnlockMouseWhileOpen = true,
		NotifySide = "Left",
		TabPadding = 8,
		MenuFadeTime = 0.15,
	})

	local Tabs = {
		Main = Window:AddTab(func("tab_main"), "activity"),
		Boost = Window:AddTab(func("tab_boost"), "zap"),
		Visuals = Window:AddTab(func("tab_visuals"), "eye"),
		Rollback = Window:AddTab(func("tab_rollback"), "rotate-ccw"),
		Settings = Window:AddTab(func("tab_settings"), "settings"),
	}

	local LeftGroupbox = Tabs.Main:AddLeftGroupbox(func("group_combat"), "sword")
	local RightGroupbox = Tabs.Main:AddRightGroupbox(func("group_aim_serve"), "target")
	local LeftGroupbox1 = Tabs.Boost:AddLeftGroupbox(func("group_jump"), "arrow-up")
	local RightGroupbox1 = Tabs.Boost:AddRightGroupbox(func("group_spike"), "zap")
	local LeftGroupbox2 = Tabs.Visuals:AddLeftGroupbox(func("group_effects"), "sparkles")
	local RightGroupbox2 = Tabs.Visuals:AddRightGroupbox(func("group_cards"), "id-card")
	local RightGroupbox3 = Tabs.Visuals:AddRightGroupbox(func("group_perf"), "gauge")
	local LeftGroupbox3 = Tabs.Rollback:AddLeftGroupbox(func("group_rollback"), "rotate-ccw")
	local LeftGroupbox4 = Tabs.Settings:AddLeftGroupbox(func("group_info"), "info")
	local RightGroupbox4 = Tabs.Settings:AddRightGroupbox(func("group_actions"), "settings")
	local pcallRef = pcall

	pcallRef(function()
		LeftGroupbox3:AddLabel((func("rb_l1")))
		LeftGroupbox3:AddLabel((func("rb_l2")))
		LeftGroupbox3:AddLabel((func("rb_l3")))
		LeftGroupbox3:AddDivider()

		LeftGroupbox3:AddButton({
			Text = func("rb_run"),
			Func = function()
				pcall(func76)
			end,
			Tooltip = func("rb_tip"),
		})

		LeftGroupbox3:AddButton({
			Text = func("rb_run_beta"),
			Func = function()
				pcall(func77)
			end,
			Tooltip = func("rb_tip_beta"),
		})

		LeftGroupbox3:AddLabel((func("rb_l4")))
	end)

	pcallRef(function()
		LeftGroupbox4:AddLabel("KingsHub v5")
		LeftGroupbox4:AddLabel(func("last_updated") .. tostring("10-22-2026"))
		LeftGroupbox4:AddDivider()
		LeftGroupbox4:AddLabel((func("creator")))
		LeftGroupbox4:AddLabel((func("ui_lib")))
		LeftGroupbox4:AddLabel((func("enjoy")))
	end)

	pcallRef(function()
		RightGroupbox4:AddLabel((func("menu_bind"))):AddKeyPicker("MenuKeybind", {Default = "RightShift", NoUI = true, Text = func("menu_bind")})
		RightGroupbox4:AddDivider()

		RightGroupbox4:AddToggle("OnlineCounterToggle", {
			Text = func("online_toggle"),
			Default = true,
			Tooltip = func("online_tip"),
			Callback = function(value)
				flag = value
				if value and true then
					task.spawn(func3)
				else
					pcall(function()
						if Label and Label.SetText then
							local v1 = func("online_users")
							if not flag then
								Label:SetText(v1 .. ": -")
							else
								Label:SetText(v1 .. ": " .. tostring(num))
							end
						end
					end)
				end
			end,
		})

		Label = RightGroupbox4:AddLabel(func("online_users") .. ": -")

		RightGroupbox4:AddButton({
			Text = func("copy_discord"),
			Func = function()
				local v2 = pcall(function()
					if type(setclipboard) == "function" then
						setclipboard("https://discord.gg/EQM2KZZKTC")
					elseif type(toclipboard) == "function" then
						toclipboard("https://discord.gg/EQM2KZZKTC")
					else
						error("no clipboard")
					end
				end) and func("discord_ok") or func("discord_fail")

				local num = 3

				pcall(function()
					v1:Notify({Title = "KingsHub", Description = tostring(v2), Time = num or 6})
				end)
			end,
			Tooltip = "https://discord.gg/EQM2KZZKTC",
		})

		RightGroupbox4:AddButton({
			Text = func("unload"),
			Func = function()
				local v2 = func("unloading")
				local num = 3

				pcall(function()
					v1:Notify({Title = "KingsHub", Description = tostring(v2), Time = num or 6})
				end)

				flag1 = false
				flag6 = false
				flag8 = false
				flag9 = false
				flag15 = false
				flag14 = false
				flag20 = false
				flag21 = false
				flag13 = false
				local pcallRef = pcall
				pcallRef(func32)
				pcallRef(func64)
				pcallRef(func75)
				pcallRef(func47)
				pcallRef(func72)
				pcallRef(func48)
				pcallRef(func50)
				pcallRef(func5)
				pcallRef(func20)
				pcallRef(func78)

				if folder then
					pcall(function()
						folder:Destroy()
					end)
				end

				pcall(function()
					v1:Unload()
				end)
			end,
		})
	end)

	pcallRef(function()
		LeftGroupbox:AddToggle("HitboxToggle", {
			Text = func("hitbox"),
			Default = false,
			Callback = function(value)
				flag1 = value

				if not value then
					func5()
				end

				local v2 = value and func("hitbox") .. " " .. func("on") or func("hitbox") .. " " .. func("off")
				local num = 4

				pcall(function()
					v1:Notify({Title = "KingsHub", Description = tostring(v2), Time = num or 6})
				end)
			end,
		})

		LeftGroupbox:AddSlider("HitboxSize", {
			Text = func("hitbox_size"),
			Default = 10,
			Min = 0,
			Max = 50,
			Rounding = 0,
			Suffix = func("studs"),
			Callback = function(value)
				num1 = value
			end,
		})

		LeftGroupbox:AddSlider("HitboxTrans", {
			Text = func("hitbox_trans"),
			Default = 80,
			Min = 0,
			Max = 100,
			Rounding = 0,
			Suffix = "%",
			Callback = function(value)
				num2 = math.clamp(tonumber(value) or 80, 0, 100) / 100
			end,
		})

		LeftGroupbox:AddLabel((func("hitbox_color"))):AddColorPicker("HitboxColor", {
			Default = v4,
			Callback = function(value)
				v4 = value
			end,
		})

		LeftGroupbox:AddDivider()

		LeftGroupbox:AddToggle("RoninBarLockToggle", {
			Text = func("bar_ronin"),
			Default = false,
			Tooltip = func("bar_ronin_tip"),
			Callback = function(value)
				flag2 = value

				if value then
					pcall(func40)
				end

				local v2 = func("bar_ronin") .. " " .. (value and func("on") or func("off"))
				local num = 4

				pcall(function()
					v1:Notify({Title = "KingsHub", Description = tostring(v2), Time = num or 6})
				end)
			end,
		})

		LeftGroupbox:AddToggle("KazanaBarLockToggle", {
			Text = func("bar_kazana"),
			Default = false,
			Tooltip = func("bar_kazana_tip"),
			Callback = function(value)
				flag3 = value

				if value then
					pcall(func40)
				end

				local v2 = func("bar_kazana") .. " " .. (value and func("on") or func("off"))
				local num = 4

				pcall(function()
					v1:Notify({Title = "KingsHub", Description = tostring(v2), Time = num or 6})
				end)
			end,
		})

		LeftGroupbox:AddDivider()

		LeftGroupbox:AddToggle("DirectionalHitToggle", {
			Text = func("directional"),
			Default = false,
			Callback = function(value)
				flag5 = value
			end,
		})

		LeftGroupbox:AddToggle("OfficialPathToggle", {Text = func("official_path"), Default = true, Callback = function(_) end})

		LeftGroupbox:AddToggle("PerfectSpikeToggle", {
			Text = func("perfect_spike"),
			Default = true,
			Callback = function(value)
				flag19 = value
			end,
		})

		LeftGroupbox:AddToggle("MaxPowerSpikeToggle", {
			Text = func("max_power"),
			Default = false,
			Tooltip = func("max_power_tip"),
			Callback = function(value)
				flag8 = value
				local v2 = value and func("max_power") .. " " .. func("on") or func("max_power") .. " " .. func("off")
				local num = 4

				pcall(function()
					v1:Notify({Title = "KingsHub", Description = tostring(v2), Time = num or 6})
				end)
			end,
		}):AddKeyPicker(
			"MaxPowerSpikeKey",
			{Default = "T", SyncToggleState = true, Mode = "Toggle", Text = func("max_power")}
		)

		LeftGroupbox:AddToggle("SilentSpikeToggle", {
			Text = func("silent_spike"),
			Default = false,
			Tooltip = func("silent_spike_tip"),
			Callback = function(value)
				flag9 = value

				if value then
					func21()
				else
					func20()
				end

				local v2 = value and func("silent_on") or func("silent_off")
				local num = 4

				pcall(function()
					v1:Notify({Title = "KingsHub", Description = tostring(v2), Time = num or 6})
				end)
			end,
		}):AddKeyPicker("SilentSpikeKey", {Default = "C", Mode = "Hold", Text = func("silent_spike_key")})

		LeftGroupbox:AddToggle("LockPicoToggle", {
			Text = func("lock_pico"),
			Default = false,
			Tooltip = func("lock_pico_tip"),
			Callback = function(value)
				flag10 = value
				local v2 = value and func("pico_locked") or func("pico_unlocked")
				local num = 3

				pcall(function()
					v1:Notify({Title = "KingsHub", Description = tostring(v2), Time = num or 6})
				end)
			end,
		})

		LeftGroupbox:AddToggle("DesyncToggle", {
			Text = func("desync"),
			Default = false,
			Tooltip = func("desync_tip"),
			Callback = function(value)
				if value then
					func33()
				else
					func32()
				end

				local v2 = value and func("desync_on") or func("desync_off")
				local num = 4

				pcall(function()
					v1:Notify({Title = "KingsHub", Description = tostring(v2), Time = num or 6})
				end)
			end,
		})

		LeftGroupbox:AddToggle("AntiModToggle", {
			Text = func("anti_mod"),
			Default = false,
			Tooltip = func("anti_mod_tip"),
			Callback = function(value)
				flag13 = value

				if value then
					func43()
				end

				local v2 = value and func("anti_mod") .. " " .. func("on") or func("anti_mod") .. " " .. func("off")
				local num = 4

				pcall(function()
					v1:Notify({Title = "KingsHub", Description = tostring(v2), Time = num or 6})
				end)
			end,
		})
	end)

	pcallRef(function()
		RightGroupbox:AddToggle("CornerAimbotToggle", {
			Text = func("corner"),
			Default = false,
			Tooltip = func("corner_tip"),
			Callback = function(value)
				flag6 = value
				local v2 = value and func("corner") .. " " .. func("on") or func("corner") .. " " .. func("off")
				local num = 4

				pcall(function()
					v1:Notify({Title = "KingsHub", Description = tostring(v2), Time = num or 6})
				end)
			end,
		}):AddKeyPicker("CornerAimbotKey", {Default = "Z", SyncToggleState = true, Mode = "Toggle", Text = func("corner")})

		RightGroupbox:AddLabel((func("corner_by")))

		RightGroupbox:AddToggle("CameraJumpToggle", {
			Text = func("camera_jump"),
			Default = false,
			Tooltip = func("camera_jump_tip"),
			Callback = function(value)
				flag7 = value
			end,
		})

		RightGroupbox:AddToggle("AutoStrongServeUI", {
			Text = func("auto_serve"),
			Default = false,
			Callback = function(value)
				flag4 = value
			end,
		})

		RightGroupbox:AddToggle("AutoStrongServeForce", {Text = func("force_serve"), Default = false, Callback = function(_) end})

		RightGroupbox:AddSlider("ServeBoostPower", {
			Text = func("serve_power"),
			Default = 1,
			Min = 0,
			Max = 1,
			Rounding = 2,
			Callback = function(value)
				num3 = value
			end,
		})
	end)

	pcallRef(function()
		LeftGroupbox1:AddToggle("JumpBoostToggle", {
			Text = func("jump_boost"),
			Default = false,
			Callback = function(value)
				flag17 = value
			end,
		})

		LeftGroupbox1:AddSlider("JumpBoostMult", {
			Text = func("jump_mult"),
			Default = 1.35,
			Min = 1,
			Max = 2,
			Rounding = 2,
			Suffix = "x",
			Callback = function(value)
				num6 = value
			end,
		})

		RightGroupbox1:AddToggle("SpikeBoostToggle", {
			Text = func("spike_boost"),
			Default = false,
			Callback = function(value)
				flag18 = value
			end,
		})

		RightGroupbox1:AddSlider("SpikeCharge", {
			Text = func("spike_charge"),
			Default = 1,
			Min = 0.5,
			Max = 1,
			Rounding = 2,
			Callback = function(value)
				num7 = value
			end,
		})
	end)

	pcallRef(function()
		pcall(func54)

		LeftGroupbox2:AddToggle("ScoreEffectToggle", {
			Text = func("score_toggle"),
			Default = false,
			Callback = function(value)
				flag20 = value
				if value then
					func65()
				else
					func64()
				end
			end,
		})

		LeftGroupbox2:AddDropdown("ScoreEffectSelect", {
			Text = func("score_select"),
			Values = #tbl11 > 0 and tbl11 or {"SupernovaScoreEffect"},
			Default = str2 or tbl11[1] or "SupernovaScoreEffect",
			Callback = function(value)
				if type(value) == "string" and value ~= "" then
					str2 = value
				end
			end,
		})

		LeftGroupbox2:AddButton({
			Text = func("score_test"),
			Func = function()
				local pcallRef = pcall
				pcallRef(func54)
				pcallRef(func59)
			end,
		})

		LeftGroupbox2:AddDivider()

		LeftGroupbox2:AddToggle("PredictAimToggle", {
			Text = func("predict"),
			Default = false,
			Tooltip = func("predict_tip"),
			Callback = function(value)
				flag15 = value
				if not value then
					func48()
				end
			end,
		})

		LeftGroupbox2:AddSlider("PredictAimLength", {
			Text = func("predict_len"),
			Default = 25,
			Min = 5,
			Max = 50,
			Rounding = 0,
			Suffix = func("studs"),
			Callback = function(value)
				num5 = value
			end,
		})

		LeftGroupbox2:AddLabel((func("predict_color"))):AddColorPicker("PredictAimColor", {
			Default = v5,
			Callback = function(value)
				v5 = value
			end,
		})

		LeftGroupbox2:AddToggle("OptimalSpotToggle", {
			Text = func("optimal_spot"),
			Default = false,
			Tooltip = func("optimal_spot_tip"),
			Callback = function(value)
				flag16 = value
				if not value then
					if v13 then
						pcall(function()
							v13:Destroy()
						end)
						v13 = nil
					end
				end
			end,
		})
	end)

	pcallRef(function()
		local pcallRef = pcall
		pcallRef(func55)
		pcallRef(func55)
		local v2 = tbl13

		if type(v2) ~= "table" or #v2 < 3 then
			local tbl = {
				"Default",
				"2026PlayerCard",
				"BasicPlayerCard",
				"BrainrotPlayerCard",
				"BellerPlayerCard",
				"GoldPlayerCard",
				"NeonPlayerCard",
				"DiamondPlayerCard",
				"RainbowPlayerCard",
			}

			local tbl1 = {}
			local tbl2 = {}

			for _, v3 in ipairs(v2 or {}) do
				if not tbl1[v3] then
					tbl1[v3] = true
					table.insert(tbl2, v3)
				end
			end

			for _, v4 in ipairs(tbl) do
				if not tbl1[v4] then
					tbl1[v4] = true
					table.insert(tbl2, v4)
				end
			end

			table.sort(tbl2)
			v2 = tbl2
			tbl13 = tbl2
		end

		RightGroupbox2:AddToggle("PlayerCardToggle", {
			Text = func("card_toggle"),
			Default = false,
			Callback = function(value)
				if value then
					pcall(func61)
				end
			end,
		})

		RightGroupbox2:AddDropdown("PlayerCardSelect", {
			Text = func("card_select"),
			Values = v2,
			Default = v2[1],
			Callback = function(value)
				if type(value) == "string" and value ~= "" then
					str3 = value
					pcall(func61)
					local str = tostring(value)
					local num = 2

					pcall(function()
						v1:Notify({Title = "KingsHub", Description = tostring(str), Time = num or 6})
					end)
				end
			end,
		})

		RightGroupbox2:AddButton({
			Text = func("card_test"),
			Func = function()
				local pcallRef = pcall
				pcallRef(func55)
				pcallRef(func63)
			end,
		})
	end)

	pcallRef(function()
		RightGroupbox3:AddToggle("FpsCounterToggle", {
			Text = func("fps"),
			Default = true,
			Tooltip = func("fps_tip"),
			Callback = function(value)
				flag11 = value
				if value then
					func79()
				elseif v12 then
					pcall(function()
						v12:Destroy()
					end)
					v12 = nil
				end
			end,
		})

		RightGroupbox3:AddToggle("PotatoModeToggle", {
			Text = func("potato"),
			Default = false,
			Tooltip = func("potato_tip"),
			Callback = function(value)
				flag21 = value
				if value then
					pcall(func74)
				else
					pcall(func75)
				end
			end,
		})

		RightGroupbox3:AddDropdown("PerfLevelDrop", {
			Text = func("perf_level"),
			Values = {"Light", "Balanced", "Maximum"},
			Default = str1 or "Balanced",
			Callback = function(value)
				if value then
					str1 = value
				end
				if flag21 then
					pcall(func74)
				end
			end,
		})

		RightGroupbox3:AddToggle("StreamerModeToggle", {
			Text = func("streamer"),
			Default = false,
			Tooltip = func("streamer_tip"),
			Callback = function(value)
				flag14 = value
				if value then
					for _, player in pairs(Players:GetPlayers()) do
						func44(player)
					end
				else
					func47()
				end
			end,
		})

		RightGroupbox3:AddToggle("UnlockAllVisualToggle", {
			Text = func("unlock_all"),
			Default = false,
			Tooltip = func("unlock_all_tip"),
			Callback = function(value)
				if value then
					func73()
				else
					func72()
				end
			end,
		})
	end)

	v1.ToggleKeybind = Options.MenuKeybind

	task.defer(function()
		local pcallRef = pcall

		pcallRef(function()
			if v2 then
				v2:SetLibrary(v1)
				v2:SetFolder("KingsHub")
				v2:ApplyToTab(Tabs.Settings)
			end
		end)

		pcallRef(function()
			if v3 then
				v3:SetLibrary(v1)
				v3:SetFolder("KingsHub")
				v3:IgnoreThemeSettings()
				v3:SetIgnoreIndexes({"MenuKeybind"})
				v3:BuildConfigSection(Tabs.Settings)
				task.wait(0.2)
				v3:LoadAutoloadConfig()
			end
		end)
	end)

	task.spawn(function()
		while true do
			task.wait(flag9 and 0.08 or 0.35)
			pcall(function()
				if Options.CornerAimbotKey and Toggles.CornerAimbotToggle then
					local State = Options.CornerAimbotKey:GetState()
					if State ~= flag6 then
						flag6 = State
						Toggles.CornerAimbotToggle:SetValue(State)
					end
				end

				if Options.MaxPowerSpikeKey and Toggles.MaxPowerSpikeToggle then
					local State1 = Options.MaxPowerSpikeKey:GetState()
					if State1 ~= flag8 then
						flag8 = State1
						Toggles.MaxPowerSpikeToggle:SetValue(State1)
					end
				end

				if flag9 and Options.SilentSpikeKey and Options.SilentSpikeKey:GetState() then
					func19()
				end
			end)
		end
	end)

	if flag11 then
		pcall(func79)
	end

	local v6 = func("welcome")
	local num4 = 8

	pcall(function()
		v1:Notify({Title = "KingsHub", Description = tostring(v6), Time = num4 or 6})
	end)

	local v7 = "KingsHub" .. " v" .. "5" .. func("loaded") .. tostring("10-22-2026")
	local num8 = 5

	pcall(function()
		v1:Notify({Title = "KingsHub", Description = tostring(v7), Time = num8 or 6})
	end)
end;

(function()
	local v1 = LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 8)

	if not v1 then
		str = "en"
		func80()
		return
	end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "KingsHub_LangPick"
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.DisplayOrder = 500
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	pcall(function()
		if gethui then
			screenGui.Parent = gethui()
		else
			screenGui.Parent = v1
		end
	end)

	if not screenGui.Parent then
		screenGui.Parent = v1
	end

	local frame = Instance.new("Frame")
	frame.Size = UDim2.fromScale(1, 1)
	frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	frame.BackgroundTransparency = 0.35
	frame.BorderSizePixel = 0
	frame.Parent = screenGui
	local frame1 = Instance.new("Frame")
	frame1.AnchorPoint = Vector2.new(0.5, 0.5)
	frame1.Position = UDim2.fromScale(0.5, 0.5)
	frame1.Size = UDim2.fromOffset(320, 220)
	frame1.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
	frame1.BorderSizePixel = 0
	frame1.Parent = frame
	local uICorner = Instance.new("UICorner")
	uICorner.CornerRadius = UDim.new(0, 14)
	uICorner.Parent = frame1
	local uIStroke = Instance.new("UIStroke")
	uIStroke.Color = Color3.fromRGB(80, 255, 160)
	uIStroke.Thickness = 1.5
	uIStroke.Transparency = 0.35
	uIStroke.Parent = frame1
	local textLabel = Instance.new("TextLabel")
	textLabel.BackgroundTransparency = 1
	textLabel.Size = UDim2.new(1, -20, 0, 36)
	textLabel.Position = UDim2.fromOffset(10, 18)
	textLabel.Font = Enum.Font.GothamBold
	textLabel.TextSize = 22
	textLabel.TextColor3 = Color3.fromRGB(240, 245, 240)
	textLabel.Text = "KingsHub"
	textLabel.Parent = frame1
	local textLabel1 = Instance.new("TextLabel")
	textLabel1.BackgroundTransparency = 1
	textLabel1.Size = UDim2.new(1, -20, 0, 24)
	textLabel1.Position = UDim2.fromOffset(10, 54)
	textLabel1.Font = Enum.Font.Gotham
	textLabel1.TextSize = 14
	textLabel1.TextColor3 = Color3.fromRGB(180, 190, 185)
	textLabel1.Text = "Select language / Elige el idioma"
	textLabel1.Parent = frame1

	local function func(text, arg2, backgroundColor3, arg4)
		local textButton = Instance.new("TextButton")
		textButton.Size = UDim2.new(1, -40, 0, 42)
		textButton.Position = UDim2.fromOffset(20, arg2)
		textButton.BackgroundColor3 = backgroundColor3
		textButton.BorderSizePixel = 0
		textButton.Font = Enum.Font.GothamBold
		textButton.TextSize = 16
		textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		textButton.Text = text
		textButton.AutoButtonColor = true
		textButton.Parent = frame1
		local uICorner = Instance.new("UICorner")
		uICorner.CornerRadius = UDim.new(0, 10)
		uICorner.Parent = textButton

		textButton.MouseButton1Click:Connect(function()
			str = arg4

			pcall(function()
				screenGui:Destroy()
			end)

			func80()
		end)

		return textButton
	end

	func("English", 100, Color3.fromRGB(40, 90, 200), "en")
	func("Español", 152, Color3.fromRGB(30, 140, 90), "es")
end)()

task.defer(function()
	task.wait(2)
	if flag and type("https://kingshub-api.thiagodamianff.workers.dev") == "string" and true then
		pcall(func3)
	end
end)
