-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf

local str = "Steal a Egg"
local color, color2, tbl, lua

do
	local str2 = "https://raw.githubusercontent.com/gilgameshfate59/ohbfoosk8tid/main/"
	color = Color3.fromHex("#FF8A20")
	color2 = Color3.fromHex("#E5484D")
	tbl = {}
	local localPlayer = game:GetService("Players").LocalPlayer
	tbl.Watched = setmetatable({}, { __mode = "k" })
	tbl.AntiRagdoll = false

	tbl.States = {
		Enum.HumanoidStateType.Dead,
		Enum.HumanoidStateType.FallingDown,
		Enum.HumanoidStateType.Ragdoll,
	}

	tbl.Apply = function(arg)
		if not arg then
			return
		end

		for _, state in ipairs(tbl.States) do
			pcall(function()
				arg:SetStateEnabled(state, false)
			end)
		end

		if not tbl.Watched[arg] then
			tbl.Watched[arg] = true

			for _, v in ipairs({ "PlatformStand", "Sit" }) do
				pcall(function()
					arg:GetPropertyChangedSignal(v):Connect(function()
						if tbl.AntiRagdoll and arg[v] then
							arg[v] = false
						end
					end)
				end)
			end
		end

		pcall(function()
			if tbl.AntiRagdoll then
				if arg.PlatformStand then
					arg.PlatformStand = false
				end

				if arg.Sit then
					arg.Sit = false
				end
			end
		end)
	end

	tbl.Restore = function()
		local character = localPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return
		end

		for _, state in ipairs(tbl.States) do
			pcall(function()
				humanoid:SetStateEnabled(state, true)
			end)
		end
	end

	tbl.Apply(localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid"))
	tbl.Respawns = 0

	tbl.Conn = localPlayer.CharacterAdded:Connect(function(character)
		tbl.Respawns = tbl.Respawns + 1
		tbl.Apply(character:FindFirstChildOfClass("Humanoid"))

		task.delay(0.4, function()
			tbl.Apply(character:FindFirstChildOfClass("Humanoid"))
		end)
	end)

	task.spawn(function()
		for i = 1, 60 do
			local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				tbl.Apply(humanoid)
				return
			end
			task.wait(0.25)
		end
	end)

	local function fn(arg)
		local ok, result = pcall(game.HttpGet, game, str2 .. arg)

		if not ok then
			error(("[%s] could not load %s: %s"):format("Steal a Egg", arg, tostring(result)), 0)
		end

		if type(result) ~= "string" or #result < 128 then
			error(("[%s] %s came back empty (%d bytes) -- GitHub is likely rate limiting or down. Try again in a few minutes."):format("Steal a Egg", arg, type(result) == "string" and #result or 0), 0)
		end

		local chunk, v = loadstring(result)

		if not chunk then
			error(("[%s] failed to compile %s: %s"):format("Steal a Egg", arg, tostring(v)), 0)
		end

		local ok2, result2 = pcall(chunk)

		if not ok2 then
			error(("[%s] %s errored while loading: %s"):format("Steal a Egg", arg, tostring(result2)), 0)
		end

		if result2 == nil then
			error(("[%s] %s returned nothing"):format("Steal a Egg", arg), 0)
		end

		return result2
	end

	lua = fn("CitraUI.lua")
end

local fn, tbl2, tbl3

do
	local setThreadIdentity = setthreadidentity or syn and syn.set_thread_identity or set_thread_identity
	local getThreadIdentity = getthreadidentity or syn and syn.get_thread_identity or get_thread_identity
	local flag = (getgenv and getgenv().CitraNoElevate) == true

	local function fn2()
		if flag or not setThreadIdentity then
			return nil
		end
		local v = nil

		if getThreadIdentity then
			local ok, result = pcall(getThreadIdentity)
			ok = ok and type(result) == "number"
			v = nil

			if ok then
				v = result
			end
		end

		pcall(setThreadIdentity, 8)
		return v
	end

	local function fn3(arg)
		if arg and setThreadIdentity then
			pcall(setThreadIdentity, arg)
		end
	end

	fn = function(arg, ...)
		local v = fn2()
		local v2 = pcall
		local v3 = table.pack(...)
		v3.n = 2 + v3.n - 1
		table.move(v3, 1, v3.n, 2, v3)
		v3[1] = arg
		local v4, v5 = v2(table.unpack(v3, 1, v3.n))
		fn3(v)

		if not v4 then
			warn(("[%s] %s"):format("Steal a Egg", tostring(v5)))
		end

		return v4
	end

	tbl2 = {
		Connections = {},
		Instances = {},
		Callbacks = {},
		Dead = false,
		Connection = function(arg, arg2)
			arg.Connections[#arg.Connections + 1] = arg2
			return arg2
		end,
		Instance = function(arg, arg2)
			arg.Instances[#arg.Instances + 1] = arg2
			return arg2
		end,
		Callback = function(arg, arg2)
			arg.Callbacks[#arg.Callbacks + 1] = arg2
			return arg2
		end,
	}

	tbl3 = {
		Heart = {},
		Frame = {},
		Ticks = {},
		Job = function(arg, arg2, arg3)
			if not tbl2.Dead then
				arg.Heart[arg2] = arg3
			end
		end,
		OnRender = function(arg, arg2, arg3)
			if not tbl2.Dead then
				arg.Frame[arg2] = arg3
			end
		end,
		Every = function(arg, arg2, arg3, arg4)
			if tbl2.Dead then
				return
			end
			arg.Ticks[arg2] = { Interval = arg3, Clock = 0, Fn = arg4 }
		end,
		Stop = function(arg, arg2)
			local frame = arg.Frame
			local ticks = arg.Ticks
			arg.Heart[arg2] = nil
			frame[arg2] = nil
			ticks[arg2] = nil
		end,
	}

	local tbl4 = {}

	local function fn4(arg, arg2, arg3)
		if tbl2.Dead or tbl4[arg] then
			return
		end
		tbl4[arg] = true
		local v = fn2()
		local ok, result = pcall(arg2, arg3)
		fn3(v)
		tbl4[arg] = nil

		if not ok then
			warn(("[%s] job '%s' errored: %s"):format("Steal a Egg", arg, tostring(result)))
		end
	end

	tbl2:Connection(game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
		for k, v in pairs(tbl3.Heart) do
			fn4(k, v, deltaTime)
		end

		for k, tick in pairs(tbl3.Ticks) do
			tick.Clock = tick.Clock + deltaTime

			if tick.Clock >= tick.Interval then
				tick.Clock = 0
				fn4(k, tick.Fn, deltaTime)
			end
		end
	end))

	tbl2:Connection(game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
		for k, v in pairs(tbl3.Frame) do
			fn4(k, v, deltaTime)
		end
	end))
end

tbl2.Destroy = function(arg)
	if arg.Dead then
		return
	end
	arg.Dead = true
	table.clear(tbl3.Heart)
	table.clear(tbl3.Frame)
	table.clear(tbl3.Ticks)

	for _, connection in ipairs(arg.Connections) do
		pcall(function()
			connection:Disconnect()
		end)
	end

	for _, callback in ipairs(arg.Callbacks) do
		pcall(callback)
	end

	for _, instance in ipairs(arg.Instances) do
		pcall(function()
			instance:Destroy()
		end)
	end

	table.clear(arg.Callbacks)
	table.clear(arg.Connections)
	table.clear(arg.Instances)
end

local fn2
local flag = isfile and writefile and readfile and isfolder and makefolder and true or false

fn2 = setclipboard or toclipboard or function()
end

if flag and not isfolder("CitraHub") then
	pcall(makefolder, "CitraHub")
end

local fn3

fn3 = function()
	local character = game:GetService("Players").LocalPlayer.Character
	if not character then
		return
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoid or not humanoidRootPart then
		return
	end

	if humanoid:GetAttribute("CitraSwapped") then
		return character, humanoid, humanoidRootPart
	end
	local dead = Enum.HumanoidStateType.Dead
	if humanoid:GetState() == dead then
		return
	end
	return character, humanoid, humanoidRootPart
end

local v, v2, v3

local fn4 = cloneref or function(arg)
	return arg
end

v = fn4(game:GetService("Players"))
v2 = fn4(game:GetService("Workspace"))
v3 = fn4(game:GetService("HttpService"))
local localPlayer
localPlayer = v.LocalPlayer
local fn5, tbl4, fn6, tbl5, tbl6, fn7, tbl7, fn8, fn9, fn10

do
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local v4 = filtergc("function", { Constants = { "gmatch", "GetFullName" } }, true)

	for _, v5 in debug.getupvalues(v4) do
		if typeof(v5) == "table" then
			setrawmetatable(v5, { __newindex = function()
			end })
		end
	end

	if tbl.Conn then
		tbl2:Connection(tbl.Conn)
	end

	tbl3:Every("DeathImmunity", 2, function()
		local character = localPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return
		end

		for _, state in ipairs(tbl.States) do
			local ok, result = pcall(function()
				return humanoid:GetStateEnabled(state)
			end)

			if ok and result then
				tbl.Apply(humanoid)
				return
			end
		end
	end)

	tbl2:Callback(tbl.Restore)

	fn5 = function(arg, arg2, arg3, arg4)
		fn(function()
			lua:Notification({ Name = arg, Description = arg2, Duration = arg3 or 3, Icon = arg4 or "info" })
		end)
	end

	tbl4 = {
		Push = function(arg, arg2, arg3)
			fn5("Steal a Egg", arg2, arg3 or 2, "info")
		end,
		Status = function()
		end,
		Detail = function()
		end,
		Badge = function()
		end,
		Progress = function()
		end,
		Clear = function()
		end,
		Visible = function()
		end,
		SetAccent = function()
		end,
		SetIdleItems = function()
		end,
		AttachWindow = function()
		end,
	}

	local tbl8 = {
		en = {
			["Add Pet To Blacklist"] = "Add Pet To Blacklist",
			["Auto Claim Index Rewards"] = "Auto Claim Index Rewards",
			["Auto Claim Offline Money"] = "Auto Claim Offline Money",
			["Anti Guard"] = "Anti Guard",
			["Anti Ragdoll"] = "Anti Ragdoll",
			["Stand straight back up when something knocks you down."] = "Stand straight back up when something knocks you down.",
			Bat = "Bat",
			["Bat Kill Aura"] = "Bat Kill Aura",
			["Bat Range"] = "Bat Range",
			["Claim eggs other players drop. The window is about two seconds."] = "Claim eggs other players drop. The window is about two seconds.",
			["Guaranteed Spawns"] = "Guaranteed Spawns",
			Predictor = "Predictor",
			Snipe = "Snipe",
			["Snipe Dropped Eggs"] = "Snipe Dropped Eggs",
			["Snipe Min Rarity"] = "Snipe Min Rarity",
			["Swing the bat at any player in range."] = "Swing the bat at any player in range.",
			["Upcoming Weather"] = "Upcoming Weather",
			["Auto Claim"] = "Auto Claim",
			["Auto Drop Egg"] = "Auto Drop Egg",
			["Grab the egg straight back when a guard knocks it out of you."] = "Grab the egg straight back when a guard knocks it out of you.",
			["Auto Equip Best"] = "Auto Equip Best",
			["Auto Equip"] = "Auto Equip",
			["Auto Favorite"] = "Auto Favorite",
			["Auto Hatch Ready Eggs"] = "Auto Hatch Ready Eggs",
			["Auto Place Egg"] = "Auto Place Egg",
			["Auto Sell Rarities"] = "Auto Sell Rarities",
			["Auto Sell"] = "Auto Sell",
			["Auto Steal"] = "Auto Steal",
			["Auto Treadmill"] = "Auto Treadmill",
			["Auto Upgrade Base"] = "Auto Upgrade Base",
			["Auto Upgrade Treadmill"] = "Auto Upgrade Treadmill",
			["Auto Upgrades"] = "Auto Upgrades",
			["Base Lv2: 1K | Lv3: 1M | Lv4: 75M | Treadmill Lv2: 15K | Lv3: 250K | Lv4: 5M"] = "Base Lv2: 1K | Lv3: 1M | Lv4: 75M | Treadmill Lv2: 15K | Lv3: 250K | Lv4: 5M",
			["Blacklist Selected"] = "Blacklist Selected",
			["Blacklisted Pets"] = "Blacklisted Pets",
			["Buy the next base upgrade whenever affordable."] = "Buy the next base upgrade whenever affordable.",
			["Buy the next treadmill whenever affordable."] = "Buy the next treadmill whenever affordable.",
			["Clear Blacklist"] = "Clear Blacklist",
			Costs = "Costs",
			["Drop the carried egg the moment a guard chases you."] = "Drop the carried egg the moment a guard chases you.",
			["ESP Eggs"] = "ESP Eggs",
			["ESP Guards"] = "ESP Guards",
			["ESP Rare Eggs"] = "ESP Rare Eggs",
			Eggs = "Eggs",
			["Empty = all areas"] = "Empty = all areas",
			["Empty = all eggs"] = "Empty = all eggs",
			["Equip the best pets into your pen (game's Equip Best)."] = "Equip the best pets into your pen (game's Equip Best).",
			["Favorite Min Rarity"] = "Favorite Min Rarity",
			["Favorite Mutation"] = "Favorite Mutation",
			["Favorite Pets Now"] = "Favorite Pets Now",
			["Game Auto Sell"] = "Game Auto Sell",
			["Guard Chase Distance"] = "Guard Chase Distance",
			["Guard Safety"] = "Guard Safety",
			["Guard Warning"] = "Guard Warning",
			Guards = "Guards",
			["Hatch growing eggs as soon as they're ready."] = "Hatch growing eggs as soon as they're ready.",
			["Hop Speed"] = "Hop Speed",
			["Hops per second. Higher is faster but easier for the game to correct."] = "Hops per second. Higher is faster but easier for the game to correct.",
			["Mark every area egg with name, rarity and distance."] = "Mark every area egg with name, rarity and distance.",
			["Mark guards with state and distance."] = "Mark guards with state and distance.",
			["Minimum Rarity"] = "Minimum Rarity",
			["Notify when a guard is chasing you."] = "Notify when a guard is chasing you.",
			["Only mark eggs at or above the threshold below."] = "Only mark eggs at or above the threshold below.",
			["Only send for eggs at or above this rarity"] = "Only send for eggs at or above this rarity",
			["Pet Income Threshold"] = "Pet Income Threshold",
			["Pet Max Rarity"] = "Pet Max Rarity",
			["Place Egg"] = "Place Egg",
			["Place Rule"] = "Place Rule",
			["Place carried eggs into your pen when you get home."] = "Place carried eggs into your pen when you get home.",
			["Rare Threshold"] = "Rare Threshold",
			["Remove Selected"] = "Remove Selected",
			["Select a pet, it will never be sold"] = "Select a pet, it will never be sold",
			["Sell Blacklist"] = "Sell Blacklist",
			["Sell Pets Now"] = "Sell Pets Now",
			["Sell Rule"] = "Sell Rule",
			["Sell pets at or below this rarity."] = "Sell pets at or below this rarity.",
			["Sell pets below this income. 0 or empty = disabled. e.g. 10M"] = "Sell pets below this income. 0 or empty = disabled. e.g. 10M",
			["Send a Discord notification when an egg is stolen"] = "Send a Discord notification when an egg is stolen",
			["Steal Hop Size"] = "Steal Hop Size",
			["Steal Priority"] = "Steal Priority",
			["Steal eggs from areas, run them home and place them."] = "Steal eggs from areas, run them home and place them.",
			Steal = "Steal",
			["Target Areas"] = "Target Areas",
			["Target Eggs"] = "Target Eggs",
			["The game's own auto sell. Runs server side, works offline."] = "The game's own auto sell. Runs server side, works offline.",
			["Train when idle. Pauses while carrying or stealing."] = "Train when idle. Pauses while carrying or stealing.",
			Treadmill = "Treadmill",
			["Tween Speed"] = "Tween Speed",
			["Used by Walk mode and by the fallback when a run stalls."] = "Used by Walk mode and by the fallback when a run stalls.",
			["Walk Speed"] = "Walk Speed",
			["Webhook Egg Steal"] = "Webhook Egg Steal",
			["Webhook Min Rarity"] = "Webhook Min Rarity",
		},
		es = {
			["Add Pet To Blacklist"] = "Anadir mascota a la lista negra",
			["Auto Claim Index Rewards"] = "Reclamar recompensas del indice",
			["Auto Claim Offline Money"] = "Reclamar dinero offline",
			["Auto Claim"] = "Reclamo automatico",
			["Auto Drop Egg"] = "Soltar huevo automatico",
			["Auto Equip Best"] = "Equipar los mejores",
			["Auto Equip"] = "Equipar automatico",
			["Auto Favorite"] = "Favorito automatico",
			["Auto Hatch Ready Eggs"] = "Eclosionar huevos listos",
			["Auto Place Egg"] = "Colocar huevo automatico",
			["Auto Sell Rarities"] = "Rarezas a vender",
			["Auto Sell"] = "Venta automatica",
			["Auto Steal"] = "Robo automatico",
			["Auto Treadmill"] = "Cinta automatica",
			["Auto Upgrade Base"] = "Mejorar base automatico",
			["Auto Upgrade Treadmill"] = "Mejorar cinta automatico",
			["Auto Upgrades"] = "Mejoras automaticas",
			["Base Lv2: 1K | Lv3: 1M | Lv4: 75M | Treadmill Lv2: 15K | Lv3: 250K | Lv4: 5M"] = "Base Nv2: 1K | Nv3: 1M | Nv4: 75M | Cinta Nv2: 15K | Nv3: 250K | Nv4: 5M",
			["Blacklist Selected"] = "Anadir a la lista negra",
			["Blacklisted Pets"] = "Mascotas en lista negra",
			["Buy the next base upgrade whenever affordable."] = "Compra la siguiente mejora de base cuando puedas pagarla.",
			["Buy the next treadmill whenever affordable."] = "Compra la siguiente cinta cuando puedas pagarla.",
			["Clear Blacklist"] = "Vaciar lista negra",
			Costs = "Costes",
			["Drop the carried egg the moment a guard chases you."] = "Suelta el huevo en cuanto un guardia te persiga.",
			["ESP Eggs"] = "ESP de huevos",
			["ESP Guards"] = "ESP de guardias",
			["ESP Rare Eggs"] = "ESP de huevos raros",
			Eggs = "Huevos",
			["Empty = all areas"] = "Vacio = todas las areas",
			["Empty = all eggs"] = "Vacio = todos los huevos",
			["Equip the best pets into your pen (game's Equip Best)."] = "Equipa las mejores mascotas en tu corral (Equip Best del juego).",
			["Favorite Min Rarity"] = "Rareza minima para favorito",
			["Favorite Mutation"] = "Mutacion favorita",
			["Favorite Pets Now"] = "Marcar favoritos ahora",
			["Game Auto Sell"] = "Venta automatica del juego",
			["Guard Chase Distance"] = "Distancia de persecucion",
			["Guard Safety"] = "Seguridad ante guardias",
			["Guard Warning"] = "Aviso de guardia",
			Guards = "Guardias",
			["Hatch growing eggs as soon as they're ready."] = "Eclosiona los huevos en cuanto esten listos.",
			["Hop Speed"] = "Velocidad de salto",
			["Hops per second. Higher is faster but easier for the game to correct."] = "Saltos por segundo. Mas alto es mas rapido pero el juego lo corrige antes.",
			["Mark every area egg with name, rarity and distance."] = "Marca cada huevo con nombre, rareza y distancia.",
			["Mark guards with state and distance."] = "Marca los guardias con estado y distancia.",
			["Minimum Rarity"] = "Rareza minima",
			["Notify when a guard is chasing you."] = "Avisa cuando un guardia te persigue.",
			["Only mark eggs at or above the threshold below."] = "Solo marca huevos con rareza igual o superior al umbral.",
			["Only send for eggs at or above this rarity"] = "Solo envia huevos de esta rareza o superior",
			["Pet Income Threshold"] = "Umbral de ingresos",
			["Pet Max Rarity"] = "Rareza maxima",
			["Place Egg"] = "Colocar huevo",
			["Place Rule"] = "Regla de colocacion",
			["Place carried eggs into your pen when you get home."] = "Coloca los huevos en tu corral al llegar a casa.",
			["Rare Threshold"] = "Umbral de rareza",
			["Remove Selected"] = "Quitar seleccionado",
			["Select a pet, it will never be sold"] = "Elige una mascota, nunca se vendera",
			["Sell Blacklist"] = "Lista negra de venta",
			["Sell Pets Now"] = "Vender mascotas ahora",
			["Sell Rule"] = "Regla de venta",
			["Sell pets at or below this rarity."] = "Vende mascotas de esta rareza o inferior.",
			["Sell pets below this income. 0 or empty = disabled. e.g. 10M"] = "Vende mascotas por debajo de estos ingresos. 0 o vacio = desactivado. ej. 10M",
			["Send a Discord notification when an egg is stolen"] = "Envia una notificacion a Discord al robar un huevo",
			["Steal Hop Size"] = "Tamano del salto",
			["Steal Priority"] = "Prioridad de robo",
			["Steal eggs from areas, run them home and place them."] = "Roba huevos de las areas, llevalos a casa y colocalos.",
			Steal = "Robar",
			["Target Areas"] = "Areas objetivo",
			["Target Eggs"] = "Huevos objetivo",
			["The game's own auto sell. Runs server side, works offline."] = "La venta automatica del propio juego. Corre en el servidor y funciona offline.",
			["Train when idle. Pauses while carrying or stealing."] = "Entrena cuando estas libre. Se pausa al cargar o robar.",
			Treadmill = "Cinta de correr",
			["Tween Speed"] = "Velocidad de tween",
			["Used by Walk mode and by the fallback when a run stalls."] = "Lo usan el modo Walk y el respaldo cuando una carrera se atasca.",
			["Walk Speed"] = "Velocidad de caminata",
			["Webhook Egg Steal"] = "Webhook al robar huevo",
			["Webhook Min Rarity"] = "Rareza minima del webhook",
		},
		pt = {
			["Add Pet To Blacklist"] = "Adicionar pet a lista negra",
			["Auto Claim Index Rewards"] = "Coletar recompensas do indice",
			["Auto Claim Offline Money"] = "Coletar dinheiro offline",
			["Auto Claim"] = "Coleta automatica",
			["Auto Drop Egg"] = "Soltar ovo automatico",
			["Auto Equip Best"] = "Equipar os melhores",
			["Auto Equip"] = "Equipar automatico",
			["Auto Favorite"] = "Favoritar automatico",
			["Auto Hatch Ready Eggs"] = "Chocar ovos prontos",
			["Auto Place Egg"] = "Colocar ovo automatico",
			["Auto Sell Rarities"] = "Raridades para vender",
			["Auto Sell"] = "Venda automatica",
			["Auto Steal"] = "Roubo automatico",
			["Auto Treadmill"] = "Esteira automatica",
			["Auto Upgrade Base"] = "Melhorar base automatico",
			["Auto Upgrade Treadmill"] = "Melhorar esteira automatico",
			["Auto Upgrades"] = "Melhorias automaticas",
			["Base Lv2: 1K | Lv3: 1M | Lv4: 75M | Treadmill Lv2: 15K | Lv3: 250K | Lv4: 5M"] = "Base Nv2: 1K | Nv3: 1M | Nv4: 75M | Esteira Nv2: 15K | Nv3: 250K | Nv4: 5M",
			["Blacklist Selected"] = "Adicionar a lista negra",
			["Blacklisted Pets"] = "Pets na lista negra",
			["Buy the next base upgrade whenever affordable."] = "Compra a proxima melhoria de base quando der.",
			["Buy the next treadmill whenever affordable."] = "Compra a proxima esteira quando der.",
			["Clear Blacklist"] = "Limpar lista negra",
			Costs = "Custos",
			["Drop the carried egg the moment a guard chases you."] = "Solta o ovo assim que um guarda te perseguir.",
			["ESP Eggs"] = "ESP de ovos",
			["ESP Guards"] = "ESP de guardas",
			["ESP Rare Eggs"] = "ESP de ovos raros",
			Eggs = "Ovos",
			["Empty = all areas"] = "Vazio = todas as areas",
			["Empty = all eggs"] = "Vazio = todos os ovos",
			["Equip the best pets into your pen (game's Equip Best)."] = "Equipa os melhores pets no seu curral (Equip Best do jogo).",
			["Favorite Min Rarity"] = "Raridade minima para favoritar",
			["Favorite Mutation"] = "Mutacao favorita",
			["Favorite Pets Now"] = "Favoritar agora",
			["Game Auto Sell"] = "Venda automatica do jogo",
			["Guard Chase Distance"] = "Distancia de perseguicao",
			["Guard Safety"] = "Seguranca contra guardas",
			["Guard Warning"] = "Aviso de guarda",
			Guards = "Guardas",
			["Hatch growing eggs as soon as they're ready."] = "Choca os ovos assim que estiverem prontos.",
			["Hop Speed"] = "Velocidade de salto",
			["Hops per second. Higher is faster but easier for the game to correct."] = "Saltos por segundo. Maior e mais rapido mas o jogo corrige mais facil.",
			["Mark every area egg with name, rarity and distance."] = "Marca cada ovo com nome, raridade e distancia.",
			["Mark guards with state and distance."] = "Marca os guardas com estado e distancia.",
			["Minimum Rarity"] = "Raridade minima",
			["Notify when a guard is chasing you."] = "Avisa quando um guarda te persegue.",
			["Only mark eggs at or above the threshold below."] = "So marca ovos com raridade igual ou acima do limite.",
			["Only send for eggs at or above this rarity"] = "So envia ovos desta raridade ou acima",
			["Pet Income Threshold"] = "Limite de renda",
			["Pet Max Rarity"] = "Raridade maxima",
			["Place Egg"] = "Colocar ovo",
			["Place Rule"] = "Regra de colocacao",
			["Place carried eggs into your pen when you get home."] = "Coloca os ovos no seu curral ao chegar em casa.",
			["Rare Threshold"] = "Limite de raridade",
			["Remove Selected"] = "Remover selecionado",
			["Select a pet, it will never be sold"] = "Escolha um pet, ele nunca sera vendido",
			["Sell Blacklist"] = "Lista negra de venda",
			["Sell Pets Now"] = "Vender pets agora",
			["Sell Rule"] = "Regra de venda",
			["Sell pets at or below this rarity."] = "Vende pets desta raridade ou abaixo.",
			["Sell pets below this income. 0 or empty = disabled. e.g. 10M"] = "Vende pets abaixo desta renda. 0 ou vazio = desativado. ex. 10M",
			["Send a Discord notification when an egg is stolen"] = "Envia uma notificacao ao Discord ao roubar um ovo",
			["Steal Hop Size"] = "Tamanho do salto",
			["Steal Priority"] = "Prioridade de roubo",
			["Steal eggs from areas, run them home and place them."] = "Rouba ovos das areas, leva pra casa e coloca.",
			Steal = "Roubar",
			["Target Areas"] = "Areas alvo",
			["Target Eggs"] = "Ovos alvo",
			["The game's own auto sell. Runs server side, works offline."] = "A venda automatica do proprio jogo. Roda no servidor e funciona offline.",
			["Train when idle. Pauses while carrying or stealing."] = "Treina quando esta livre. Pausa ao carregar ou roubar.",
			Treadmill = "Esteira",
			["Tween Speed"] = "Velocidade do tween",
			["Used by Walk mode and by the fallback when a run stalls."] = "Usado pelo modo Walk e pelo fallback quando uma corrida trava.",
			["Walk Speed"] = "Velocidade de caminhada",
			["Webhook Egg Steal"] = "Webhook ao roubar ovo",
			["Webhook Min Rarity"] = "Raridade minima do webhook",
		},
		fr = {
			["Add Pet To Blacklist"] = "Ajouter un familier a la liste noire",
			["Auto Claim Index Rewards"] = "Recuperer les recompenses de l'index",
			["Auto Claim Offline Money"] = "Recuperer l'argent hors ligne",
			["Auto Claim"] = "Reclamation auto",
			["Auto Drop Egg"] = "Lacher l'oeuf auto",
			["Auto Equip Best"] = "Equiper les meilleurs",
			["Auto Equip"] = "Equipement auto",
			["Auto Favorite"] = "Favori auto",
			["Auto Hatch Ready Eggs"] = "Faire eclore les oeufs prets",
			["Auto Place Egg"] = "Placer l'oeuf auto",
			["Auto Sell Rarities"] = "Raretes a vendre",
			["Auto Sell"] = "Vente auto",
			["Auto Steal"] = "Vol auto",
			["Auto Treadmill"] = "Tapis roulant auto",
			["Auto Upgrade Base"] = "Ameliorer la base auto",
			["Auto Upgrade Treadmill"] = "Ameliorer le tapis auto",
			["Auto Upgrades"] = "Ameliorations auto",
			["Base Lv2: 1K | Lv3: 1M | Lv4: 75M | Treadmill Lv2: 15K | Lv3: 250K | Lv4: 5M"] = "Base Niv2: 1K | Niv3: 1M | Niv4: 75M | Tapis Niv2: 15K | Niv3: 250K | Niv4: 5M",
			["Blacklist Selected"] = "Mettre en liste noire",
			["Blacklisted Pets"] = "Familiers en liste noire",
			["Buy the next base upgrade whenever affordable."] = "Achete la prochaine amelioration de base des que possible.",
			["Buy the next treadmill whenever affordable."] = "Achete le prochain tapis des que possible.",
			["Clear Blacklist"] = "Vider la liste noire",
			Costs = "Couts",
			["Drop the carried egg the moment a guard chases you."] = "Lache l'oeuf des qu'un garde te poursuit.",
			["ESP Eggs"] = "ESP des oeufs",
			["ESP Guards"] = "ESP des gardes",
			["ESP Rare Eggs"] = "ESP des oeufs rares",
			Eggs = "Oeufs",
			["Empty = all areas"] = "Vide = toutes les zones",
			["Empty = all eggs"] = "Vide = tous les oeufs",
			["Equip the best pets into your pen (game's Equip Best)."] = "Equipe les meilleurs familiers dans ton enclos (Equip Best du jeu).",
			["Favorite Min Rarity"] = "Rarete min. pour favori",
			["Favorite Mutation"] = "Mutation favorite",
			["Favorite Pets Now"] = "Mettre en favori maintenant",
			["Game Auto Sell"] = "Vente auto du jeu",
			["Guard Chase Distance"] = "Distance de poursuite",
			["Guard Safety"] = "Securite face aux gardes",
			["Guard Warning"] = "Alerte garde",
			Guards = "Gardes",
			["Hatch growing eggs as soon as they're ready."] = "Fait eclore les oeufs des qu'ils sont prets.",
			["Hop Speed"] = "Vitesse de saut",
			["Hops per second. Higher is faster but easier for the game to correct."] = "Sauts par seconde. Plus eleve est plus rapide mais plus facile a corriger pour le jeu.",
			["Mark every area egg with name, rarity and distance."] = "Marque chaque oeuf avec nom, rarete et distance.",
			["Mark guards with state and distance."] = "Marque les gardes avec etat et distance.",
			["Minimum Rarity"] = "Rarete minimale",
			["Notify when a guard is chasing you."] = "Previent quand un garde te poursuit.",
			["Only mark eggs at or above the threshold below."] = "Ne marque que les oeufs au-dessus du seuil.",
			["Only send for eggs at or above this rarity"] = "N'envoie que les oeufs de cette rarete ou plus",
			["Pet Income Threshold"] = "Seuil de revenu",
			["Pet Max Rarity"] = "Rarete maximale",
			["Place Egg"] = "Placer l'oeuf",
			["Place Rule"] = "Regle de placement",
			["Place carried eggs into your pen when you get home."] = "Place les oeufs dans ton enclos en rentrant.",
			["Rare Threshold"] = "Seuil de rarete",
			["Remove Selected"] = "Retirer la selection",
			["Select a pet, it will never be sold"] = "Choisis un familier, il ne sera jamais vendu",
			["Sell Blacklist"] = "Liste noire de vente",
			["Sell Pets Now"] = "Vendre les familiers maintenant",
			["Sell Rule"] = "Regle de vente",
			["Sell pets at or below this rarity."] = "Vend les familiers de cette rarete ou moins.",
			["Sell pets below this income. 0 or empty = disabled. e.g. 10M"] = "Vend les familiers sous ce revenu. 0 ou vide = desactive. ex. 10M",
			["Send a Discord notification when an egg is stolen"] = "Envoie une notification Discord quand un oeuf est vole",
			["Steal Hop Size"] = "Taille du saut",
			["Steal Priority"] = "Priorite de vol",
			["Steal eggs from areas, run them home and place them."] = "Vole les oeufs des zones, ramene-les et place-les.",
			Steal = "Voler",
			["Target Areas"] = "Zones ciblees",
			["Target Eggs"] = "Oeufs cibles",
			["The game's own auto sell. Runs server side, works offline."] = "La vente auto du jeu. Cote serveur, fonctionne hors ligne.",
			["Train when idle. Pauses while carrying or stealing."] = "S'entraine quand inactif. Pause pendant le transport ou le vol.",
			Treadmill = "Tapis roulant",
			["Tween Speed"] = "Vitesse de tween",
			["Used by Walk mode and by the fallback when a run stalls."] = "Utilise par le mode Walk et par le repli quand un trajet bloque.",
			["Walk Speed"] = "Vitesse de marche",
			["Webhook Egg Steal"] = "Webhook au vol d'oeuf",
			["Webhook Min Rarity"] = "Rarete min. du webhook",
		},
		ru = {
			["Add Pet To Blacklist"] = "Добавить питомца в чёрный список",
			["Auto Claim Index Rewards"] = "Автосбор наград индекса",
			["Auto Claim Offline Money"] = "Автосбор офлайн-денег",
			["Auto Claim"] = "Автосбор",
			["Auto Drop Egg"] = "Автосброс яйца",
			["Auto Equip Best"] = "Экипировать лучших",
			["Auto Equip"] = "Автоэкипировка",
			["Auto Favorite"] = "Автоизбранное",
			["Auto Hatch Ready Eggs"] = "Автовылупление готовых яиц",
			["Auto Place Egg"] = "Авторазмещение яйца",
			["Auto Sell Rarities"] = "Редкости для продажи",
			["Auto Sell"] = "Автопродажа",
			["Auto Steal"] = "Автокража",
			["Auto Treadmill"] = "Автобеговая дорожка",
			["Auto Upgrade Base"] = "Автоулучшение базы",
			["Auto Upgrade Treadmill"] = "Автоулучшение дорожки",
			["Auto Upgrades"] = "Автоулучшения",
			["Base Lv2: 1K | Lv3: 1M | Lv4: 75M | Treadmill Lv2: 15K | Lv3: 250K | Lv4: 5M"] = "База ур.2: 1K | ур.3: 1M | ур.4: 75M | Дорожка ур.2: 15K | ур.3: 250K | ур.4: 5M",
			["Blacklist Selected"] = "В чёрный список",
			["Blacklisted Pets"] = "Питомцы в чёрном списке",
			["Buy the next base upgrade whenever affordable."] = "Покупает следующее улучшение базы, когда хватает денег.",
			["Buy the next treadmill whenever affordable."] = "Покупает следующую дорожку, когда хватает денег.",
			["Clear Blacklist"] = "Очистить чёрный список",
			Costs = "Стоимость",
			["Drop the carried egg the moment a guard chases you."] = "Бросает яйцо, как только охранник начинает погоню.",
			["ESP Eggs"] = "ESP яиц",
			["ESP Guards"] = "ESP охранников",
			["ESP Rare Eggs"] = "ESP редких яиц",
			Eggs = "Яйца",
			["Empty = all areas"] = "Пусто = все зоны",
			["Empty = all eggs"] = "Пусто = все яйца",
			["Equip the best pets into your pen (game's Equip Best)."] = "Ставит лучших питомцев в загон (функция игры Equip Best).",
			["Favorite Min Rarity"] = "Мин. редкость для избранного",
			["Favorite Mutation"] = "Избранная мутация",
			["Favorite Pets Now"] = "Добавить в избранное сейчас",
			["Game Auto Sell"] = "Автопродажа игры",
			["Guard Chase Distance"] = "Дистанция погони",
			["Guard Safety"] = "Защита от охранников",
			["Guard Warning"] = "Предупреждение об охраннике",
			Guards = "Охранники",
			["Hatch growing eggs as soon as they're ready."] = "Вылупляет яйца, как только они готовы.",
			["Hop Speed"] = "Скорость прыжков",
			["Hops per second. Higher is faster but easier for the game to correct."] = "Прыжков в секунду. Больше — быстрее, но игре легче это откатить.",
			["Mark every area egg with name, rarity and distance."] = "Отмечает каждое яйцо: имя, редкость, расстояние.",
			["Mark guards with state and distance."] = "Отмечает охранников: состояние и расстояние.",
			["Minimum Rarity"] = "Мин. редкость",
			["Notify when a guard is chasing you."] = "Уведомляет, когда охранник гонится за вами.",
			["Only mark eggs at or above the threshold below."] = "Отмечает только яйца не ниже порога.",
			["Only send for eggs at or above this rarity"] = "Отправлять только яйца не ниже этой редкости",
			["Pet Income Threshold"] = "Порог дохода",
			["Pet Max Rarity"] = "Макс. редкость",
			["Place Egg"] = "Размещение яйца",
			["Place Rule"] = "Правило размещения",
			["Place carried eggs into your pen when you get home."] = "Кладёт принесённые яйца в загон по возвращении.",
			["Rare Threshold"] = "Порог редкости",
			["Remove Selected"] = "Убрать выбранное",
			["Select a pet, it will never be sold"] = "Выберите питомца — он никогда не будет продан",
			["Sell Blacklist"] = "Чёрный список продажи",
			["Sell Pets Now"] = "Продать питомцев сейчас",
			["Sell Rule"] = "Правило продажи",
			["Sell pets at or below this rarity."] = "Продаёт питомцев не выше этой редкости.",
			["Sell pets below this income. 0 or empty = disabled. e.g. 10M"] = "Продаёт питомцев с доходом ниже этого. 0 или пусто = выкл. напр. 10M",
			["Send a Discord notification when an egg is stolen"] = "Отправляет уведомление в Discord при краже яйца",
			["Steal Hop Size"] = "Длина прыжка",
			["Steal Priority"] = "Приоритет кражи",
			["Steal eggs from areas, run them home and place them."] = "Крадёт яйца из зон, несёт домой и размещает.",
			Steal = "Кража",
			["Target Areas"] = "Целевые зоны",
			["Target Eggs"] = "Целевые яйца",
			["The game's own auto sell. Runs server side, works offline."] = "Собственная автопродажа игры. Работает на сервере и офлайн.",
			["Train when idle. Pauses while carrying or stealing."] = "Тренируется в простое. Пауза при переносе или краже.",
			Treadmill = "Беговая дорожка",
			["Tween Speed"] = "Скорость твина",
			["Used by Walk mode and by the fallback when a run stalls."] = "Используется режимом Walk и запасным ходом, когда забег застревает.",
			["Walk Speed"] = "Скорость ходьбы",
			["Webhook Egg Steal"] = "Вебхук при краже яйца",
			["Webhook Min Rarity"] = "Мин. редкость для вебхука",
		},
		tr = {
			["Add Pet To Blacklist"] = "Evcil hayvani kara listeye ekle",
			["Auto Claim Index Rewards"] = "Index odullerini otomatik al",
			["Auto Claim Offline Money"] = "Cevrimdisi parayi otomatik al",
			["Auto Claim"] = "Otomatik Alma",
			["Auto Drop Egg"] = "Yumurtayi otomatik birak",
			["Auto Equip Best"] = "En iyileri kusan",
			["Auto Equip"] = "Otomatik Kusan",
			["Auto Favorite"] = "Otomatik Favori",
			["Auto Hatch Ready Eggs"] = "Hazir yumurtalari cikart",
			["Auto Place Egg"] = "Yumurtayi otomatik yerlestir",
			["Auto Sell Rarities"] = "Satilacak nadirlikler",
			["Auto Sell"] = "Otomatik Satis",
			["Auto Steal"] = "Otomatik Calma",
			["Auto Treadmill"] = "Otomatik Kosu Bandi",
			["Auto Upgrade Base"] = "Ussu otomatik yukselt",
			["Auto Upgrade Treadmill"] = "Kosu bandini otomatik yukselt",
			["Auto Upgrades"] = "Otomatik Yukseltmeler",
			["Base Lv2: 1K | Lv3: 1M | Lv4: 75M | Treadmill Lv2: 15K | Lv3: 250K | Lv4: 5M"] = "Us Sv2: 1K | Sv3: 1M | Sv4: 75M | Kosu Bandi Sv2: 15K | Sv3: 250K | Sv4: 5M",
			["Blacklist Selected"] = "Kara listeye ekle",
			["Blacklisted Pets"] = "Kara listedeki hayvanlar",
			["Buy the next base upgrade whenever affordable."] = "Karsilayabildiginde bir sonraki us yukseltmesini satin alir.",
			["Buy the next treadmill whenever affordable."] = "Karsilayabildiginde bir sonraki kosu bandini satin alir.",
			["Clear Blacklist"] = "Kara listeyi temizle",
			Costs = "Maliyetler",
			["Drop the carried egg the moment a guard chases you."] = "Bir muhafiz kovaladigi anda yumurtayi birakir.",
			["ESP Eggs"] = "Yumurta ESP",
			["ESP Guards"] = "Muhafiz ESP",
			["ESP Rare Eggs"] = "Nadir yumurta ESP",
			Eggs = "Yumurtalar",
			["Empty = all areas"] = "Bos = tum bolgeler",
			["Empty = all eggs"] = "Bos = tum yumurtalar",
			["Equip the best pets into your pen (game's Equip Best)."] = "En iyi hayvanlari agilina kusanir (oyunun Equip Best ozelligi).",
			["Favorite Min Rarity"] = "Favori icin min nadirlik",
			["Favorite Mutation"] = "Favori mutasyon",
			["Favorite Pets Now"] = "Simdi favorile",
			["Game Auto Sell"] = "Oyunun otomatik satisi",
			["Guard Chase Distance"] = "Kovalama mesafesi",
			["Guard Safety"] = "Muhafiz guvenligi",
			["Guard Warning"] = "Muhafiz uyarisi",
			Guards = "Muhafizlar",
			["Hatch growing eggs as soon as they're ready."] = "Yumurtalar hazir olur olmaz cikartir.",
			["Hop Speed"] = "Ziplama hizi",
			["Hops per second. Higher is faster but easier for the game to correct."] = "Saniyedeki ziplama. Yuksek olan daha hizli ama oyunun duzeltmesi daha kolay.",
			["Mark every area egg with name, rarity and distance."] = "Her yumurtayi ad, nadirlik ve mesafe ile isaretler.",
			["Mark guards with state and distance."] = "Muhafizlari durum ve mesafe ile isaretler.",
			["Minimum Rarity"] = "Minimum nadirlik",
			["Notify when a guard is chasing you."] = "Bir muhafiz kovaladiginda bildirir.",
			["Only mark eggs at or above the threshold below."] = "Sadece esigin ustundeki yumurtalari isaretler.",
			["Only send for eggs at or above this rarity"] = "Sadece bu nadirlik ve ustu icin gonder",
			["Pet Income Threshold"] = "Gelir esigi",
			["Pet Max Rarity"] = "Maksimum nadirlik",
			["Place Egg"] = "Yumurta yerlestir",
			["Place Rule"] = "Yerlestirme kurali",
			["Place carried eggs into your pen when you get home."] = "Eve varinca yumurtalari agilina koyar.",
			["Rare Threshold"] = "Nadirlik esigi",
			["Remove Selected"] = "Secileni kaldir",
			["Select a pet, it will never be sold"] = "Bir hayvan sec, asla satilmaz",
			["Sell Blacklist"] = "Satis kara listesi",
			["Sell Pets Now"] = "Simdi sat",
			["Sell Rule"] = "Satis kurali",
			["Sell pets at or below this rarity."] = "Bu nadirlik ve altindaki hayvanlari satar.",
			["Sell pets below this income. 0 or empty = disabled. e.g. 10M"] = "Bu gelirin altindaki hayvanlari satar. 0 veya bos = kapali. orn. 10M",
			["Send a Discord notification when an egg is stolen"] = "Bir yumurta calindiginda Discord bildirimi gonderir",
			["Steal Hop Size"] = "Ziplama boyutu",
			["Steal Priority"] = "Calma onceligi",
			["Steal eggs from areas, run them home and place them."] = "Bolgelerden yumurta calar, eve goturur ve yerlestirir.",
			Steal = "Calma",
			["Target Areas"] = "Hedef bolgeler",
			["Target Eggs"] = "Hedef yumurtalar",
			["The game's own auto sell. Runs server side, works offline."] = "Oyunun kendi otomatik satisi. Sunucuda calisir, cevrimdisi de calisir.",
			["Train when idle. Pauses while carrying or stealing."] = "Bostayken antrenman yapar. Tasirken veya calarken duraklar.",
			Treadmill = "Kosu bandi",
			["Tween Speed"] = "Tween hizi",
			["Used by Walk mode and by the fallback when a run stalls."] = "Walk modu ve bir kosu takildiginda devreye giren yedek tarafindan kullanilir.",
			["Walk Speed"] = "Yurume hizi",
			["Webhook Egg Steal"] = "Yumurta calma webhook'u",
			["Webhook Min Rarity"] = "Webhook min nadirlik",
		},
		zh = {
			["Add Pet To Blacklist"] = "将宠物加入黑名单",
			["Auto Claim Index Rewards"] = "自动领取图鉴奖励",
			["Auto Claim Offline Money"] = "自动领取离线金币",
			["Auto Claim"] = "自动领取",
			["Auto Drop Egg"] = "自动丢弃蛋",
			["Auto Equip Best"] = "装备最佳宠物",
			["Auto Equip"] = "自动装备",
			["Auto Favorite"] = "自动收藏",
			["Auto Hatch Ready Eggs"] = "自动孵化就绪的蛋",
			["Auto Place Egg"] = "自动放置蛋",
			["Auto Sell Rarities"] = "自动出售稀有度",
			["Auto Sell"] = "自动出售",
			["Auto Steal"] = "自动偷蛋",
			["Auto Treadmill"] = "自动跑步机",
			["Auto Upgrade Base"] = "自动升级基地",
			["Auto Upgrade Treadmill"] = "自动升级跑步机",
			["Auto Upgrades"] = "自动升级",
			["Base Lv2: 1K | Lv3: 1M | Lv4: 75M | Treadmill Lv2: 15K | Lv3: 250K | Lv4: 5M"] = "基地 Lv2: 1K | Lv3: 1M | Lv4: 75M | 跑步机 Lv2: 15K | Lv3: 250K | Lv4: 5M",
			["Blacklist Selected"] = "加入黑名单",
			["Blacklisted Pets"] = "黑名单宠物",
			["Buy the next base upgrade whenever affordable."] = "有足够金币时自动购买下一级基地升级。",
			["Buy the next treadmill whenever affordable."] = "有足够金币时自动购买下一台跑步机。",
			["Clear Blacklist"] = "清空黑名单",
			Costs = "费用",
			["Drop the carried egg the moment a guard chases you."] = "守卫追赶时立刻丢下手中的蛋。",
			["ESP Eggs"] = "蛋 ESP",
			["ESP Guards"] = "守卫 ESP",
			["ESP Rare Eggs"] = "稀有蛋 ESP",
			Eggs = "蛋",
			["Empty = all areas"] = "留空 = 所有区域",
			["Empty = all eggs"] = "留空 = 所有蛋",
			["Equip the best pets into your pen (game's Equip Best)."] = "将最佳宠物装备到围栏中（游戏内的 Equip Best）。",
			["Favorite Min Rarity"] = "收藏最低稀有度",
			["Favorite Mutation"] = "收藏变异",
			["Favorite Pets Now"] = "立即收藏宠物",
			["Game Auto Sell"] = "游戏自动出售",
			["Guard Chase Distance"] = "守卫追击距离",
			["Guard Safety"] = "守卫防护",
			["Guard Warning"] = "守卫警告",
			Guards = "守卫",
			["Hatch growing eggs as soon as they're ready."] = "蛋一就绪就立刻孵化。",
			["Hop Speed"] = "跳跃速度",
			["Hops per second. Higher is faster but easier for the game to correct."] = "每秒跳跃次数。越高越快，但游戏更容易纠正。",
			["Mark every area egg with name, rarity and distance."] = "为每个区域蛋标注名称、稀有度和距离。",
			["Mark guards with state and distance."] = "为守卫标注状态和距离。",
			["Minimum Rarity"] = "最低稀有度",
			["Notify when a guard is chasing you."] = "守卫追赶你时发出通知。",
			["Only mark eggs at or above the threshold below."] = "仅标记达到或高于以下阈值的蛋。",
			["Only send for eggs at or above this rarity"] = "仅发送达到或高于此稀有度的蛋",
			["Pet Income Threshold"] = "宠物收益阈值",
			["Pet Max Rarity"] = "宠物最高稀有度",
			["Place Egg"] = "放置蛋",
			["Place Rule"] = "放置规则",
			["Place carried eggs into your pen when you get home."] = "回到基地时把携带的蛋放进围栏。",
			["Rare Threshold"] = "稀有阈值",
			["Remove Selected"] = "移除所选",
			["Select a pet, it will never be sold"] = "选择一只宠物，它将永不被出售",
			["Sell Blacklist"] = "出售黑名单",
			["Sell Pets Now"] = "立即出售宠物",
			["Sell Rule"] = "出售规则",
			["Sell pets at or below this rarity."] = "出售此稀有度及以下的宠物。",
			["Sell pets below this income. 0 or empty = disabled. e.g. 10M"] = "出售收益低于此值的宠物。0 或留空 = 关闭。例如 10M",
			["Send a Discord notification when an egg is stolen"] = "偷到蛋时发送 Discord 通知",
			["Steal Hop Size"] = "跳跃距离",
			["Steal Priority"] = "偷取优先级",
			["Steal eggs from areas, run them home and place them."] = "从区域偷蛋、带回基地并放置。",
			Steal = "偷蛋",
			["Target Areas"] = "目标区域",
			["Target Eggs"] = "目标蛋",
			["The game's own auto sell. Runs server side, works offline."] = "游戏自带的自动出售。服务端运行，离线也生效。",
			["Train when idle. Pauses while carrying or stealing."] = "空闲时训练。携带或偷取时暂停。",
			Treadmill = "跑步机",
			["Tween Speed"] = "补间速度",
			["Used by Walk mode and by the fallback when a run stalls."] = "用于 Walk 模式，以及行程卡住时的回退移动。",
			["Walk Speed"] = "行走速度",
			["Webhook Egg Steal"] = "偷蛋 Webhook",
			["Webhook Min Rarity"] = "Webhook 最低稀有度",
		},
	}

	local function fn11(arg, arg2)
		local ok, result = pcall(ReplicatedStorage.WaitForChild, ReplicatedStorage, arg, arg2)
		return ok and result or nil
	end

	local tbl9 = { Client = fn11("Client", 15) }
	tbl9.Shared = tbl9.Client and fn11("Shared", 3) or nil
	tbl9.Data = tbl9.Client and fn11("Data", 3) or nil

	if not tbl9.Client then
		fn5("Steal a Egg", "This game's modules were not found -- is this the right place? The script will load but do nothing.", 10, "triangle-alert")
	end

	fn6 = function(arg, ...)
		local v5 = tbl9[arg]

		for _, v6 in ipairs({ ... }) do
			if not v5 then
				return nil
			end
			v5 = v5:FindFirstChild(v6)
		end

		if not v5 then
			return nil
		end
		local ok, result = pcall(require, v5)
		return ok and result or nil
	end

	local Shared = fn6("Shared", "Remotes")

	local tbl10 = {
		en = "English",
		es = "Espanol",
		pt = "Portugues",
		fr = "Francais",
		ru = "Russian",
		tr = "Turkce",
		zh = "Chinese",
	}

	for k, v5 in pairs(tbl8) do
		if k ~= "en" then
			fn(function()
				lua:AddTranslations(k, tbl10[k] or k, v5)
			end)
		end
	end

	lua.Logo = "rbxassetid://95077438762744"
	lua:SetAccent(color)
	local v5 = lua:Window({ Name = str })
	lua.ToggleKey = Enum.KeyCode.RightShift
	tbl5 = {}

	local function fn12(arg, arg2)
		local v6 = v5:Tab({ Name = arg, Icon = arg2 })
		tbl5[arg] = v6
		return v6:SubTab({ Name = arg })
	end

	tbl6 = {
		Home = fn12("Home", "layout-dashboard"),
		Farm = fn12("Farm", "egg-fried"),
		Progress = fn12("Progress", "trending-up"),
		ESP = fn12("ESP", "eye"),
		Pets = fn12("Pets", "paw-print"),
		Predictor = fn12("Predictor", "clock"),
		Webhook = fn12("Webhook", "webhook"),
		Settings = fn12("Settings", "settings"),
	}

	local tbl11 = {}

	fn7 = function(arg, arg2)
		tbl11[arg] = (tbl11[arg] or 0) + 1
		return arg:Section({ Name = arg2, Side = tbl11[arg] % 2 == 1 and 1 or 2 })
	end

	tbl7 = {
		AreaEggSnapshot = "EggWorld.AskFieldEggSnapshot",
		AreaEggCarry = "EggWorld.AskFieldEggCarry",
		AreaEggDrop = "EggWorld.AskFieldEggDrop",
		PlaceEgg = "EggWorld.AskPlaceEgg",
		EquipTool = "EggWorld.AskWearTool",
		UnequipTool = "EggWorld.AskDoffTool",
		HatchEgg = "EggWorld.AskHatch",
		CompleteHatchEgg = "EggWorld.AskFinishHatch",
		AreaEggUpdated = "EggWorld.FieldEggShifted",
		AreaEggRemoved = "EggWorld.FieldEggGone",
		AreaEggBatchUpdated = "EggWorld.FieldEggBatchShifted",
		AreaEggCarryState = "EggWorld.FieldEggCarry",
		AreaEggClaimFeedback = "EggWorld.FieldEggRedeemVerdict",
		BaseUpgrade = "Homestead.AskBaseTierRaise",
		OnBaseUpgraded = "Homestead.BaseTierRaised",
		PlotState = "Homestead.AskState",
		TreadmillEquipStatic = "Treadmill.AskWearStill",
		TreadmillUnequip = "Treadmill.AskDoff",
		TreadmillUpgrade = "Treadmill.AskTierRaise",
		TreadmillActiveChanged = "Treadmill.AssignedBeltShifted",
		TreadmillSpeedGain = "Treadmill.SpeedGained",
		OfflineGetSummary = "AwayEarnings.FetchSummary",
		OfflineRedeem = "AwayEarnings.AskCollect",
		IndexClaimAll = "Codex.AskRedeemAll",
		AssetRuntimeSnapshot = "PenRoster.AskLiveSnapshot",
		AssetEquip = "PenRoster.AskWear",
		AssetUnequip = "PenRoster.AskDoff",
		MoneyUpdated = "PenRoster.CoinsGathered",
		ItemUpdated = "PenRoster.OwnerShifted",
		RequestSell = "PenRoster.AskSale",
		SetFavorite = "PetSatchel.WriteFavourite",
		SellAsset = "PetSatchel.SellPet",
		EquipBest = "Haul.WearBest",
		GetAutoSell = "Haul.FetchAutoSell",
		SetAutoSell = "Haul.WriteAutoSell",
		GuardSpeedHitWarning = "GuardPatrol.SpeedTollWarning",
		GuardWakeUp = "GuardPatrol.Rouse",
	}

	local function fn13(arg)
		if not Shared then
			return nil
		end
		local v6, v7 = string.match(arg, "^(.-)%.(.+)$")
		v6 = v6 and Shared[v6]
		return type(v6) == "table" and v6[v7] or nil
	end

	fn8 = function(arg, ...)
		local v6 = fn13(arg)
		if not v6 then
			return nil
		end

		if v6:IsA("RemoteFunction") then
			local v7 = table.pack(pcall(v6.InvokeServer, v6, ...))
			if v7[1] then
				return table.unpack(v7, 2, v7.n)
			end
		elseif v6:IsA("RemoteEvent") then
			pcall(v6.FireServer, v6, ...)
		end

		return nil
	end

	fn9 = function(arg, ...)
		local v6 = fn13(arg)

		if v6 and v6:IsA("RemoteEvent") then
			pcall(v6.FireServer, v6, ...)
		end
	end

	local function fn14(arg, arg2)
		local v6 = fn13(arg)
		if v6 and v6:IsA("RemoteEvent") then
			return v6.OnClientEvent:Connect(arg2)
		end
	end

	fn10 = function(arg, arg2)
		local v6 = fn14(arg, arg2)

		if v6 then
			tbl2:Connection(v6)
		end
	end
end

local Client, Client2, Client3, Data, Data2, directory, fn11

do
	local Shared = fn6("Shared", "Save")
	Client = fn6("Client", "PlotState")
	Client2 = fn6("Client", "EggState")
	Client3 = fn6("Client", "AssetRoster")
	Data = fn6("Data", "Bases")
	Data2 = fn6("Data", "Treadmills")
	local Data3 = fn6("Data", "Assets")
	directory = Data3 and Data3.Directory or nil

	fn11 = function()
		if not Shared then
			return nil
		end

		local ok, result = pcall(function()
			return Shared.Get(localPlayer, false)
		end)

		return ok and result or nil
	end
end

local fn12, fn13, fn14, fn15

local function fn16(arg)
	return directory and directory[arg]
end

fn12 = function(arg)
	local rarity = fn16(arg)
	rarity = rarity and rarity.Rarity
	return rarity and rarity.RarityNumber or 1
end

fn13 = function(arg)
	local rarity = fn16(arg)
	rarity = rarity and rarity.Rarity

	if rarity then
		rarity = rarity._id or rarity.DisplayName
	end

	return rarity or "Unknown"
end

fn14 = function(arg)
	local v4 = fn16(arg)
	return v4 and v4.DisplayName or arg or "?"
end

fn15 = function(arg)
	local v4 = fn16(arg)
	return v4 and v4.EarningRate or 0
end

local tbl8
tbl8 = {}

do
	local tbl9 = {}

	if directory then
		for _, v4 in pairs(directory) do
			v4 = v4 and v4.Rarity

			if v4 and v4.RarityNumber then
				local rarityNumber = v4.RarityNumber

				if not tbl9[rarityNumber] then
					tbl9[rarityNumber] = v4._id or v4.DisplayName or "Rarity " .. rarityNumber
				end
			end
		end
	end

	local tbl10 = {}

	for k in pairs(tbl9) do
		tbl10[#tbl10 + 1] = k
	end

	table.sort(tbl10)

	for _, v4 in ipairs(tbl10) do
		tbl8[#tbl8 + 1] = { n = v4, name = tbl9[v4] }
	end
end

if #tbl8 == 0 then
	for _, v4 in ipairs({
		"Common",
		"Uncommon",
		"Rare",
		"Epic",
		"Legendary",
		"Mythic",
		"Cosmic",
		"Secret",
		"Eternal",
		"Divine",
	}) do
		tbl8[#tbl8 + 1] = { n = #tbl8 + 1, name = v4 }
	end
end

local fn17

fn17 = function(arg)
	return ({
		Color3.fromRGB(170, 170, 170),
		Color3.fromRGB(83, 170, 98),
		Color3.fromRGB(7, 119, 255),
		Color3.fromRGB(255, 190, 60),
		Color3.fromRGB(255, 120, 60),
		Color3.fromRGB(170, 85, 255),
		Color3.fromRGB(255, 60, 255),
		(Color3.fromRGB(120, 190, 255)),
	})[arg] or Color3.fromRGB(255, 255, 255)
end

local fn18

fn18 = function(arg)
	if type(arg) ~= "number" then
		return "0"
	end
	local n = math.abs(arg)
	if n >= 1e15 then
		return ("%.2fQ"):format(arg / 1e15)
	end

	if n >= 1e12 then
		return ("%.2fT"):format(arg / 1e12)
	end

	if n >= 1e9 then
		return ("%.2fB"):format(arg / 1e9)
	end

	if n >= 1000000 then
		return ("%.2fM"):format(arg / 1000000)
	end

	if n >= 1000 then
		return ("%.1fK"):format(arg / 1000)
	end
	return ("%d"):format(math.floor(arg))
end

local fn19

fn19 = function(arg)
	if not arg then
		return nil
	end
	local str2 = arg:gsub(",", ""):gsub("%s+", ""):upper()
	if str2 == "" or str2 == "0" then
		return 0
	end
	local match = str2:match("^([%d%.]+)([KMBQ]?)$")
	if not match then
		return nil
	end
	local match2 = str2:match("[KMBQ]$")
	local n

	if match2 == "K" then
		n = 1000
	elseif match2 == "M" then
		n = 1000000
	elseif match2 == "B" then
		n = 1e9
	else
		n = 1

		if match2 == "Q" then
			n = 1e12
		end
	end

	local num = tonumber(match)
	if not num then
		return nil
	end
	return num * n
end

local fn20

fn20 = function()
	local v4, v5, v6 = fn3()
	return v6
end

local fn21

local function fn22()
	if Client then
		local ok, result = pcall(function()
			return Client.ResolveLocalSlot()
		end)

		if ok and result then
			return result
		end
	end

	local v4 = fn8(tbl7.PlotState)

	if type(v4) == "table" and type(v4.OwnersBySlot) == "table" then
		for k, v5 in pairs(v4.OwnersBySlot) do
			local userId = localPlayer.UserId
			if tonumber(v5) == userId then
				return tonumber(k)
			end
		end
	end

	return nil
end

fn21 = function()
	local v4 = fn22()
	if not v4 then
		return nil
	end
	local plots = v2:FindFirstChild("Plots")
	return plots and plots:FindFirstChild(tostring(v4))
end

local fn23

fn23 = function()
	local v4 = fn21()

	if v4 then
		local centerPoint = v4:FindFirstChild("CenterPoint")
		if centerPoint and centerPoint:IsA("BasePart") then
			return centerPoint.Position
		end
		local spawnPoint = v4:FindFirstChild("SpawnPoint")
		if spawnPoint and spawnPoint:IsA("BasePart") then
			return spawnPoint.Position
		end
	end

	return nil
end

local fn24

fn24 = function(arg)
	if not arg then
		return false
	end

	if Client then
		local ok, result = pcall(function()
			return Client.ContainsLocalPoint(arg)
		end)

		if ok and result then
			return true
		end
	end

	local v4 = fn23()
	return v4 ~= nil and (arg - v4).Magnitude <= 22
end

local fn25, fn26

do
	local function fn27()
		local ok, result = pcall(function()
			return v2.__OBJECTS.Build.MainMap.Bases:GetChildren()[8]
		end)

		return ok and result and result:IsA("BasePart") and result or nil
	end

	local function fn28()
		local v4 = fn27()
		return v4 and v4.Position.X or 545
	end

	fn25 = function()
		local v4 = fn27()
		if not v4 then
			return Vector3.new(530, 68, -365)
		end
		local v5 = fn23()
		return Vector3.new(v4.Position.X + ((v5 and v5.X or v4.Position.X - 50) < v4.Position.X and -1 or 1) * (v4.Size.X / 2 + 12), v4.Position.Y + 1, v4.Position.Z)
	end

	fn26 = function(arg)
		local v4 = fn20()
		if not (v4 and arg) then
			return arg
		end
		local position = v4.Position
		local v5 = fn28()
		if position.X < v5 == arg.X < v5 then
			return arg
		end
		local v6 = fn25()
		local n = position.X - v6.X
		local n2 = position.Z - v6.Z
		if math.sqrt(n * n + n2 * n2) < 16 then
			return arg
		end
		return v6
	end
end

local tbl9, tbl10, fn27, fn28, fn29, tbl11, fn30, fn31, fn32

do
	local function fn33()
		local v4, v5, v6 = fn3()
		if not v6 then
			return false
		end
		local parent = v6.Parent
		return parent and parent:GetAttribute("IsTrapped") == true
	end

	tbl9 = { Mode = "Tween", HopSize = 30, HopRate = 40, TweenSpeed = 400, WalkSpeed = 100 }
	tbl10 = { Running = false, Done = false, Original = nil }

	fn27 = function(arg)
		local animate = arg and arg:FindFirstChild("Animate")
		if not (animate and animate:IsA("LocalScript")) then
			return
		end

		task.defer(function()
			if not animate.Parent then
				return
			end
			animate.Disabled = false
			task.wait()

			if animate.Parent then
				animate.Disabled = true
				task.wait()
				animate.Disabled = false
			end
		end)
	end

	fn28 = function(arg)
		task.defer(function()
			if arg and arg.Parent then
				pcall(function()
					arg:ChangeState(Enum.HumanoidStateType.Running)
				end)
			end
		end)
	end

	fn29 = function(arg)
		local character = arg or localPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return false
		end

		if humanoid:GetAttribute("CitraSwapped") then
			return true
		end
		tbl10.Running = true
		local animate = character:FindFirstChild("Animate")

		if animate and animate:IsA("LocalScript") then
			animate.Disabled = true
		end

		local animator = humanoid:FindFirstChildOfClass("Animator")

		if animator then
			pcall(function()
				for _, v4 in ipairs(animator:GetPlayingAnimationTracks()) do
					v4:Stop(0)
				end
			end)
		end

		pcall(function()
			humanoid.Archivable = true
		end)

		local ok, parent = pcall(function()
			return humanoid:Clone()
		end)

		if not (ok and parent) then
			parent = Instance.new("Humanoid")
		end

		for _, child in ipairs(parent:GetChildren()) do
			if child:IsA("Animator") then
				child:Destroy()
			end
		end

		Instance.new("Animator").Parent = parent

		if not tbl10.Original then
			local ok2, result = pcall(function()
				return parent:Clone()
			end)

			tbl10.Original = ok2 and result or nil
		end

		humanoid.Name = "_OldHumanoid"
		parent.Name = "Humanoid"
		parent.Parent = character

		pcall(function()
			parent:SetAttribute("CitraSwapped", true)
		end)

		pcall(function()
			workspace.CurrentCamera.CameraSubject = parent
		end)

		humanoid:Destroy()

		pcall(function()
			tbl.Apply(parent)
		end)

		fn27(character)
		fn28(parent)
		tbl10.Running = false
		tbl10.Done = true
		return true
	end

	tbl2:Connection(localPlayer.CharacterAdded:Connect(function(character)
		if not tbl10.Done then
			return
		end

		task.delay(0.6, function()
			if not tbl10.Done then
				return
			end

			if localPlayer.Character ~= character then
				return
			end
			fn29(character)
		end)
	end))

	tbl11 = {
		Active = false,
		Target = nil,
		Within = 3,
		Clock = 0,
		ProgressCheck = 0,
		LastPos = nil,
		FallbackWalk = false,
		Fly = false,
		CruiseY = nil,
		CruiseHeight = 20,
	}

	local function fn34()
		local v4 = fn20()
		if not v4 then
			return 88
		end
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastParams.FilterDescendantsInstances = { v4.Parent }
		local hit = v2:Raycast(v4.Position + Vector3.new(0, 5, 0), Vector3.new(0, -200, 0), raycastParams)
		return (hit and hit.Position.Y or v4.Position.Y - 3) + tbl11.CruiseHeight
	end

	local walkSpeed = nil

	fn30 = function()
		if walkSpeed == nil then
			return
		end
		local v4
		v4, v4 = fn3()

		if v4 then
			pcall(function()
				v4.WalkSpeed = walkSpeed
			end)
		end

		walkSpeed = nil
	end

	tbl11.Go = function(arg, target, within, fly)
		if not target then
			return
		end
		fly = fly or false

		if fly and not arg.Fly then
			arg.CruiseY = fn34()
		end

		if arg.Active and arg.Target and (arg.Target - target).Magnitude < 5 then
			within = within or arg.Within
			arg.Within = within
			arg.Fly = fly
			return
		end

		arg.Target = target
		arg.Within = within or 3
		arg.Active = true
		arg.Fly = fly
		arg.Clock = 0
		arg.ProgressCheck = os.clock()
		arg.LastPos = nil
	end

	tbl11.Stop = function(arg)
		arg.Active = false
		arg.Target = nil
		arg.Fly = false
		fn30()
	end

	fn31 = function(arg, arg2)
		local v4 = fn20()
		if not (v4 and arg) then
			return false
		end
		local n = arg - v4.Position
		return math.sqrt(n.X * n.X + n.Z * n.Z) <= (arg2 or 4) and math.abs(n.Y) <= 20
	end

	fn32 = function(arg)
		if tbl10.Running then
			return
		end

		if not tbl11.Active then
			return
		end
		local v4, v5, v6 = fn3()
		if not v5 or not v6 then
			tbl11:Stop()
			return
		end
		local flag2 = not v5:GetAttribute("CitraSwapped") and v5.Health <= 0

		if flag2 then
			local dead = Enum.HumanoidStateType.Dead
			flag2 = v5:GetState() == dead
		end

		if flag2 then
			tbl11:Stop()
			return
		end

		if fn33() then
			return
		end
		local target = tbl11.Target
		local n = target - v6.Position
		local magnitude = n.Magnitude
		if magnitude <= tbl11.Within then
			tbl11:Stop()
			return
		end
		local mode = tbl9.Mode

		if tbl11.FallbackWalk then
			mode = "Walk"
		end

		if mode == "Tween" then
			local n2 = math.max(tbl9.TweenSpeed, 1)
			local vector = Vector3.new(n.X, 0, n.Z)
			local magnitude2 = vector.Magnitude
			if magnitude2 <= tbl11.Within then
				tbl11:Stop()
				return
			end
			local n3 = vector.Unit * math.min(magnitude2, n2 * arg)

			if tbl11.Fly and tbl11.CruiseY then
				v6.CFrame = v6.CFrame + n3 + Vector3.new(0, math.clamp(tbl11.CruiseY - v6.Position.Y, -n2 * arg, n2 * arg), 0)
				v6.AssemblyLinearVelocity = Vector3.zero
			else
				v6.CFrame = v6.CFrame + n3
				v6.AssemblyLinearVelocity = Vector3.new(0, v6.AssemblyLinearVelocity.Y, 0)
			end

			local flag3 = not tbl11.Fly

			if flag3 then
				local progressCheck = tbl11.ProgressCheck
				flag3 = os.clock() - progressCheck > 1.5
			end

			if flag3 then
				local position = v6.Position

				if tbl11.LastPos then
					if (position - tbl11.LastPos).Magnitude < 5 then
						tbl11.FallbackWalk = true

						task.delay(3, function()
							tbl11.FallbackWalk = false
						end)
					end
				end

				tbl11.LastPos = position
				tbl11.ProgressCheck = os.clock()
			end
		elseif mode == "Hop" then
			local n2 = 1 / math.max(tbl9.HopRate, 1)
			tbl11.Clock = tbl11.Clock + arg

			while n2 <= tbl11.Clock do
				tbl11.Clock = tbl11.Clock - n2
				v6.CFrame = v6.CFrame + n.Unit * math.min(magnitude, tbl9.HopSize) + Vector3.new(0, 1, 0)
				magnitude = (target - v6.Position).Magnitude
				if magnitude <= tbl11.Within then
					tbl11:Stop()
					return
				end
			end

			local progressCheck = tbl11.ProgressCheck

			if os.clock() - progressCheck > 1.5 then
				local position = v6.Position

				if tbl11.LastPos then
					if (position - tbl11.LastPos).Magnitude < 5 then
						tbl11.FallbackWalk = true

						task.delay(3, function()
							tbl11.FallbackWalk = false
						end)
					end
				end

				tbl11.LastPos = position
				tbl11.ProgressCheck = os.clock()
			end
		else
			if walkSpeed == nil then
				walkSpeed = v5.WalkSpeed
			end

			v5.WalkSpeed = tbl9.WalkSpeed
			v5:MoveTo(target)
			v5.AutoRotate = true
		end
	end
end

local tbl12
tbl12 = { ByUid = {}, List = {}, LastRefresh = 0, Ready = false }

local function fn33(list)
	tbl12.ByUid = {}

	for _, v4 in ipairs(list) do
		tbl12.ByUid[v4.Uid] = v4
	end

	tbl12.List = list
	tbl12.Ready = true
end

tbl12.Refresh = function(arg, arg2)
	local now = os.clock()
	if not arg2 and now - arg.LastRefresh < 1.2 then
		return arg.Ready
	end
	arg.LastRefresh = now
	local v4 = fn8(tbl7.AreaEggSnapshot)
	if type(v4) ~= "table" then
		return arg.Ready
	end
	local records = v4.Records or v4
	if type(records) ~= "table" then
		return arg.Ready
	end
	fn33(records)
	return true
end

tbl12.Get = function(arg, arg2)
	return arg.ByUid[arg2]
end

fn10(tbl7.AreaEggUpdated, function(arg)
	if arg and arg.Uid then
		tbl12.ByUid[arg.Uid] = arg
		tbl12.List = {}

		for _, v4 in pairs(tbl12.ByUid) do
			tbl12.List[#tbl12.List + 1] = v4
		end
	end
end)

fn10(tbl7.AreaEggRemoved, function(arg)
	if arg then
		tbl12.ByUid[arg] = nil
		tbl12.List = {}

		for _, v4 in pairs(tbl12.ByUid) do
			tbl12.List[#tbl12.List + 1] = v4
		end
	end
end)

local tbl13
tbl13 = { IsCarrying = false, Uid = nil, AreaId = nil, Category = nil, Since = 0 }
local tbl14
tbl14 = { On = false, LastUid = nil, Voluntary = false, Regrabs = 0 }
local fn34

fn34 = function()
	tbl14.Voluntary = true

	task.delay(1.5, function()
		tbl14.Voluntary = false
	end)
end

local fn35

fn35 = function(arg)
	if not arg then
		return false
	end
	local str2 = nil

	if string.find(arg, "FirstAreaEgg_", 1, true) == 1 then
		local v4 = fn8(tbl7.AreaEggSnapshot)
		local records = type(v4) == "table" and (v4.Records or v4) or {}
		str2 = nil

		for _, record in pairs(records) do
			if record.Uid == arg then
				str2 = record.AreaId .. ":" .. (record.NestId or "")
				break
			else
				str2 = nil
			end
		end

		if not str2 then
			return false
		end
	end

	return fn8(tbl7.AreaEggCarry, { Uid = arg, FirstAreaSlotKey = str2 }) == true
end

fn10(tbl7.AreaEggCarryState, function(arg)
	if type(arg) ~= "table" then
		return
	end
	local isCarrying = tbl13.IsCarrying
	tbl13.IsCarrying = arg.IsCarrying == true
	tbl13.Uid = arg.Uid
	tbl13.AreaId = arg.AreaId
	tbl13.Category = arg.AssetCategory
	tbl13.Since = os.clock()
	if tbl13.IsCarrying then
		tbl14.LastUid = arg.Uid
		return
	end

	if not (isCarrying and tbl14.On) or tbl14.Voluntary then
		return
	end
	local lastUid = tbl14.LastUid
	if not lastUid then
		return
	end

	task.spawn(function()
		for i = 1, 14 do
			if tbl13.IsCarrying then
				return
			end

			if fn35(lastUid) then
				tbl14.Regrabs = tbl14.Regrabs + 1
				tbl4:Push("Egg re-grabbed", 2)
				return
			end

			task.wait(0.25)
		end
	end)
end)

local fn36

fn36 = function()
	return tbl13.IsCarrying
end

local tbl15
tbl15 = { Chasing = false, Guard = nil, Distance = math.huge, LastWarnAt = 0, LastDropAt = 0 }
local tbl16
tbl16 = nil
local tbl17
tbl17 = nil
local tbl18
tbl18 = { Warning = false, AutoDrop = false, Distance = 25 }
local tbl19
tbl19 = { On = false, MinRarity = 0, Taken = 0, LastCarrier = {} }
local tbl20
tbl20 = { On = false, Range = 25, Rate = 0.7 }
local fn37

fn37 = function()
	local guardAreas = v2:FindFirstChild("__OBJECTS") and v2.__OBJECTS:FindFirstChild("Areas") and v2.__OBJECTS.Areas:FindFirstChild("GuardAreas")
	if not guardAreas then
		return {}
	end
	local tbl21 = {}

	for _, child in ipairs(guardAreas:GetChildren()) do
		local guard = child:FindFirstChild("Guard")

		if guard and guard:IsA("Model") then
			tbl21[#tbl21 + 1] = guard
		end
	end

	return tbl21
end

local fn38

fn38 = function()
	if not (tbl16.On or tbl18.Warning or tbl18.AutoDrop or tbl17.Guards) then
		if tbl15.Chasing then
			local v4 = tbl15
			local v5 = tbl15
			tbl15.Chasing = false
			v4.Guard = nil
			v5.Distance = math.huge
		end

		return
	end

	local str2 = tostring(localPlayer.UserId)
	local v4 = fn20()
	local chasing = false
	local huge = math.huge
	local v5 = nil

	for _, v6 in ipairs(fn37()) do
		local humanoidRootPart = v6:FindFirstChild("HumanoidRootPart")

		if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
			local magnitude = v4 and (humanoidRootPart.Position - v4.Position).Magnitude or math.huge
			local attribute = v6:GetAttribute("GuardState")
			local attribute2 = v6:GetAttribute("TargetPlayer")
			local attribute3 = v6:GetAttribute("WakeTargetPlayer")
			local humanoid = v6:FindFirstChildOfClass("Humanoid")

			if (attribute == "Chase" or attribute == "Waking" or attribute == "EggRetrieval") and (attribute2 == str2 or attribute3 == str2) or magnitude < tbl18.Distance and humanoid and humanoid.WalkSpeed > 1 then
				chasing = true
				local flag2 = true

				if not (magnitude < huge) then
					chasing = flag2
				else
					huge = magnitude
					v5 = v6
				end
			end
		end
	end

	tbl15.Chasing = chasing
	tbl15.Guard = v5
	tbl15.Distance = huge
end

fn10(tbl7.GuardSpeedHitWarning, function()
	if not tbl18.Warning then
		return
	end
	fn5("Guard", "Speed hit incoming! Move!", 2, "triangle-alert")
end)

fn10(tbl7.GuardWakeUp, function()
	if tbl18.Warning and not tbl15.Chasing then
		fn5("Guard", "A guard woke up.", 2, "eye")
	end
end)

local tbl21
tbl21 = { Url = "", OnSteal = false, MinRarity = 0 }
local request_
request_ = syn and syn.request or http and http.request or http_request or request
local fn39

fn39 = function()
	return request_ ~= nil and tbl21.Url ~= ""
end

local fn40

fn40 = function(arg)
	if not fn39() then
		return
	end
	local url = tbl21.Url

	task.spawn(function()
		fn(function()
			request_({
				Url = url,
				Method = "POST",
				Headers = { ["Content-Type"] = "application/json" },
				Body = v3:JSONEncode({
					username = "Citra | " .. str,
					avatar_url = "https://raw.githubusercontent.com/gilgameshfate59/hobfooskated/main/logo.png",
					embeds = { arg },
				}),
			})
		end)
	end)
end

local tbl22, fn41, fn42, fn43, fn44, fn45, fn46

do
	local function fn47(arg)
		local assetCategory = arg and arg.AssetCategory
		local v4 = fn12(assetCategory)
		local v5 = fn11()
		local v6 = fn17(v4)

		local tbl23 = {
			title = "Egg Stolen",
			color = math.floor(v6.R * 255) * 65536 + math.floor(v6.G * 255) * 256 + math.floor(v6.B * 255),
		}

		local fields = {}
		local tbl24 = { name = "Egg", value = fn14(assetCategory), inline = true }
		local tbl25 = { name = "Rarity", value = fn13(assetCategory), inline = true }
		local tbl26 = { name = "Area", value = tostring(arg and arg.AreaId or "?"), inline = true }
		local tbl27 = { name = "Income", value = fn18(fn15(assetCategory)) .. "/s", inline = true }
		local tbl28 = { name = "Money", value = fn18(v5 and v5.Money or 0), inline = true }
		local tbl29 = { name = "Player", value = localPlayer.Name, inline = true }
		fields[1] = tbl24
		fields[2] = tbl25
		fields[3] = tbl26
		fields[4] = tbl27
		fields[5] = tbl28
		fields[6] = tbl29
		tbl23.fields = fields
		tbl23.footer = { text = str .. " | " .. os.date("%X") }
		return tbl23
	end

	local function fn48(arg)
		if not tbl21.OnSteal or not arg then
			return
		end
		local flag2 = tbl21.MinRarity > 0

		if flag2 then
			local minRarity = tbl21.MinRarity
			flag2 = fn12(arg.AssetCategory) < minRarity
		end

		if flag2 then
			return
		end
		fn40(fn47(arg))
	end

	tbl16 = {
		On = false,
		MinRarity = 0,
		Priority = "Rarity",
		Areas = {},
		Eggs = {},
		AutoPlace = false,
		PlaceRule = "Always",
		AutoHatch = false,
	}

	tbl22 = { State = "Idle", Target = nil, StateChangedAt = 0, ActionAt = 0, FailCount = 0 }

	local function fn49(arg)
		if not arg then
			return false
		end

		if arg.State ~= "Slot" then
			return false
		end

		if tbl16.Areas[arg.AreaId] == false then
			return false
		end

		if tbl16.Eggs[arg.AssetCategory] == false then
			return false
		end
		local flag2 = tbl16.MinRarity > 0

		if flag2 then
			local minRarity = tbl16.MinRarity
			flag2 = fn12(arg.AssetCategory) < minRarity
		end

		if flag2 then
			return false
		end
		return true
	end

	local function fn50()
		tbl12:Refresh()
		local v4 = fn20()
		local huge = math.huge
		local v5 = nil

		for _, v6 in pairs(tbl12.ByUid) do
			if fn49(v6) and v6.BottomCFrame then
				local magnitude = v4 and (v6.BottomCFrame.Position - v4.Position).Magnitude or math.huge

				if tbl16.Priority ~= "Closest" then
					if tbl16.Priority == "Income" then
						magnitude = -fn15(v6.AssetCategory)
					else
						magnitude = -fn12(v6.AssetCategory) * 1000 + magnitude
					end
				end

				if magnitude < huge then
					huge = magnitude
					v5 = v6
				end
			end
		end

		return v5
	end

	fn41 = function(arg)
		if type(arg) ~= "table" then
			return {}
		end

		for _, v4 in ipairs(arg) do
			if type(v4) == "table" and v4.OwnerUserId == localPlayer.UserId and type(v4.Records) == "table" then
				return v4.Records
			end
		end

		return {}
	end

	local function fn51()
		if not Client2 then
			return {}
		end
		local ok, result = pcall(Client2.ReadOwnedEggs)
		return ok and fn41(result) or {}
	end

	local function fn52()
		local v4 = fn11()
		if not v4 then
			return false
		end
		local getAssetEquipCapacity = Data and Data.GetAssetEquipCapacity and Data.GetAssetEquipCapacity(v4.BaseUpgradeLevel) or 10
		local n = 0

		for k in pairs(fn51()) do
			n += 1
		end

		return n >= getAssetEquipCapacity
	end

	local function fn53()
		if not tbl16.AutoPlace then
			return false
		end

		if tbl16.PlaceRule == "Always" then
			return true
		end
		return fn52()
	end

	fn42 = function(arg)
		if not fn36() then
			return true
		end
		fn34()
		return fn8(tbl7.AreaEggDrop, { Reason = arg or "PlayerRequest" }) == true
	end

	local function fn54(arg)
		local v4 = fn20()
		if not v4 then
			return nil
		end
		local v5 = nil
		local v6 = nil

		for _, child in ipairs(v2:GetChildren()) do
			if child.Name == "SmartPromptPart" and child:IsA("BasePart") then
				local magnitude = (child.Position - v4.Position).Magnitude

				for _, child2 in ipairs(child:GetChildren()) do
					local enabled = child2:IsA("ProximityPrompt") and child2.Enabled

					if enabled then
						enabled = string.find(child2.ActionText or "", arg, 1, true)
					end

					if enabled then
						enabled = magnitude <= (child2.MaxActivationDistance or 8)
					end

					if enabled and (not v5 or magnitude < v5) then
						v5 = magnitude
						v6 = child2
					end
				end
			end
		end

		return v6
	end

	local function fn55(arg)
		if not arg then
			return false
		end

		pcall(function()
			arg.HoldDuration = 0
		end)

		if typeof(fireproximityprompt) == "function" then
			if not pcall(fireproximityprompt, arg, 1) then
				pcall(fireproximityprompt, arg)
			end

			return true
		end

		return false
	end

	local function fn56()
		return fn55(fn54("Steal"))
	end

	local function fn57(arg)
		local uid = arg.Uid
		local str2 = nil

		if string.find(uid, "FirstAreaEgg_", 1, true) == 1 then
			str2 = arg.AreaId .. ":" .. (arg.NestId or "")
		end

		local v4, v5 = fn8(tbl7.AreaEggCarry, { Uid = uid, FirstAreaSlotKey = str2 })
		if v4 == true then
			return true
		end

		if type(v5) == "string" then
			if v5:find("gameplay area") or v5:find("too far") then
				tbl4:Detail("moving closer")
				return false, true
			end
			fn5("Farm", v5, 2, "triangle-alert")
		end

		return false
	end

	local n = 0
	local n2 = 0

	local function fn58(arg)
		local n3 = arg * 2.3999632
		local n4 = math.min(3 + math.sqrt(arg) * 2.4, 18)
		return CFrame.new(math.cos(n3) * n4, 0, math.sin(n3) * n4)
	end

	local function fn59(arg)
		if not arg then
			return false
		end
		fn34()
		local placeFailed = nil

		for i = 1, 12 do
			n += 1
			local v4 = fn58(n)
			local plantEgg = Client2 and Client2.PlantEgg
			local ok = nil
			local result = nil
			placeFailed = nil

			if plantEgg then
				ok, result, placeFailed = pcall(Client2.PlantEgg, arg, v4)
			end

			if not ok then
				result, placeFailed = fn8(tbl7.PlaceEgg, { Uid = arg, LocalCFrame = v4 })
			end

			if result == true then
				return true
			end

			if type(placeFailed) ~= "string" or not placeFailed:find("too close") then
				break
			end
		end

		if type(placeFailed) == "string" and os.clock() - n2 > 15 then
			n2 = os.clock()
			fn5("Farm", "Place failed: " .. placeFailed, 3, "triangle-alert")
		end

		return false
	end

	local tbl23 = {}

	local function fn60()
		local str2 = tostring(localPlayer.UserId) .. "_"
		local tbl24 = {}

		for _, child in ipairs(v2:GetChildren()) do
			if child.Name == "PlacedEggRenders" then
				for _, child2 in ipairs(child:GetChildren()) do
					if string.find(child2.Name, str2, 1, true) == 1 then
						tbl24[string.sub(child2.Name, #str2 + 1)] = true
					end
				end
			end
		end

		return tbl24
	end

	fn43 = function()
		if not tbl16.AutoHatch then
			return
		end
		local tbl24 = {}

		for k in pairs(fn51()) do
			local ok, result = pcall(Client2.IsReadyToHatch, k)

			if ok and result then
				tbl24[#tbl24 + 1] = k
			end
		end

		if #tbl24 == 0 then
			return
		end
		local Hatch = fn54("Hatch")

		if Hatch then
			fn55(Hatch)
		end

		for _, v4 in ipairs(tbl24) do
			local flag2 = not tbl23[v4]

			if not flag2 then
				local v5 = tbl23[v4]
				flag2 = os.clock() - v5 > 8
			end

			if flag2 then
				tbl23[v4] = os.clock()

				if fn8(tbl7.HatchEgg, v4) == true then
					task.delay(0.4, function()
						fn8(tbl7.CompleteHatchEgg, v4)
					end)
				end
			end
		end
	end

	local tbl24 = {}
	local flag2 = false

	fn44 = function()
		if not tbl16.AutoPlace or flag2 then
			return
		end
		local v4 = fn60()
		local tbl25 = {}

		for k in pairs(fn51()) do
			local flag3 = not v4[k]

			if flag3 then
				flag3 = not tbl24[k]

				if not flag3 then
					local v5 = tbl24[k]
					flag3 = os.clock() - v5 > 5
				end
			end

			if flag3 then
				tbl25[#tbl25 + 1] = k
			end
		end

		if #tbl25 == 0 then
			return
		end
		flag2 = true

		task.spawn(function()
			local n3 = 0

			for i = 1, math.min(#tbl25, 8) do
				if tbl16.AutoPlace then
					local v5 = tbl25[i]
					tbl24[v5] = os.clock()

					if fn59(v5) then
						n3 += 1
					end

					continue
				end

				break
			end

			if n3 > 0 then
				tbl4:Push(n3 == 1 and "Placed egg" or "Placed " .. n3 .. " eggs", 2)
			end

			flag2 = false
		end)
	end

	local function fn61(arg, arg2)
		tbl4:Status(arg)
		tbl4:Detail(arg2 and fn14(arg2.AssetCategory) or nil)
	end

	fn45 = function(state)
		if tbl22.State ~= state then
			tbl22.StateChangedAt = os.clock()
		end

		tbl22.State = state
	end

	local function fn62(actionAt)
		local target = tbl22.Target
		if not target then
			fn45("Idle")
			return
		end

		local function fn63()
			tbl22.ActionAt = actionAt
			fn48(target)

			if tbl16.AutoPlace then
				fn45("RunningHome")
				fn61("Carrying home", target)
				local v4 = fn23()

				if v4 then
					tbl11:Go(fn26(v4), 6, true)
				end
			else
				fn45("HoldAtHub")
				fn61("Carrying to safe zone", target)
				tbl11:Go(fn25(), 6, true)
			end
		end

		fn56()
		if fn36() then
			fn63()
			return
		end
		local v4, v5 = fn57(target)

		if v4 then
			fn63()
		elseif v5 then
			fn45("MovingToEgg")
		else
			tbl22.FailCount = tbl22.FailCount + 1
			tbl22.ActionAt = actionAt
			tbl22.State = tbl22.FailCount >= 3 and "Idle" or "MovingToEgg"
		end
	end

	fn46 = function()
		if tbl10.Running then
			return
		end

		if not tbl16.On then
			if tbl22.State ~= "Idle" then
				tbl11:Stop()
				tbl22.Target = nil
			end

			fn45("Idle")
			return
		end

		local now = os.clock()

		if fn36() then
			if tbl18.AutoDrop and tbl15.Chasing and now - tbl15.LastDropAt > 1.5 then
				tbl15.LastDropAt = now
				fn42("PlayerRequest")
				fn45("Idle")
				return
			end

			if now - tbl13.Since < 0.15 then
				return
			end

			if not tbl16.AutoPlace then
				if tbl22.State ~= "HoldAtHub" then
					fn45("HoldAtHub")
				end

				return
			end

			if fn23() then
				if fn24(fn20() and fn20().Position) then
					tbl11:Stop()
					fn45("Placing")
				else
					fn45("RunningHome")
				end
			end
		end

		local state = tbl22.State

		if not fn36() and (state == "RunningHome" or state == "HoldAtHub" or state == "Placing" or state == "Holding") then
			fn45("Idle")
			tbl22.Target = nil
			fn61("Farm: idle", nil)
			tbl22.ActionAt = now
			return
		end

		if state == "Idle" then
			if now - tbl22.ActionAt < 1.2 then
				return
			end
			local v4 = fn50()
			if not v4 then
				fn61("Farm: no eggs", nil)
				return
			end
			tbl22.Target = v4
			fn45("MovingToEgg")
			tbl22.FailCount = 0
			fn61("Stealing", v4)
			return
		end

		if state == "MovingToEgg" then
			local target = tbl22.Target
			if not target then
				fn45("Idle")
				return
			end
			local v4 = tbl12:Get(target.Uid)

			if not v4 or v4.State ~= "Slot" then
				fn45("Idle")
				tbl22.ActionAt = now
				return
			end

			local position = target.BottomCFrame and target.BottomCFrame.Position
			if not position then
				fn45("Idle")
				return
			end

			if fn31(position, 5) then
				tbl11:Stop()
				fn45("Carrying")
				fn62(now)
				return
			end

			tbl11:Go(fn26(position), 3.5, false)

			if now - tbl22.StateChangedAt > 25 then
				tbl22.FailCount = tbl22.FailCount + 1
				tbl22.ActionAt = now
				tbl11:Stop()
				fn45(tbl22.FailCount >= 3 and "Idle" or "MovingToEgg")

				if tbl22.FailCount >= 3 then
					fn5("Farm", "Could not reach egg.", 2, "triangle-alert")
				end
			end

			return
		end

		if state == "Carrying" then
			fn62(now)
			return
		end

		if state == "RunningHome" then
			local v4 = fn23()

			if v4 then
				local v5 = fn20()

				if v5 and fn24(v5.Position) then
					tbl11:Stop()

					if fn53() then
						fn45("Placing")
					else
						fn45("Holding")
					end

					return
				end

				tbl11:Go(fn26(v4), 6, true)

				if now - tbl22.StateChangedAt > 30 then
					tbl11:Stop()
					fn42("PlayerRequest")
					fn45("Idle")
					tbl22.ActionAt = now
				end
			end

			return
		end

		if state == "HoldAtHub" then
			local v4 = fn25()
			local v5 = fn20()

			if v4 and v5 then
				local n3 = v5.Position.X - v4.X
				local n4 = v5.Position.Z - v4.Z

				if math.sqrt(n3 * n3 + n4 * n4) <= 8 then
					tbl11:Stop()
				else
					tbl11:Go(v4, 6, true)
				end
			end

			return
		end

		if state == "Placing" then
			local uid = tbl13.Uid or tbl22.Target and tbl22.Target.Uid

			if uid and fn59(uid) then
				fn45("Idle")
				tbl22.ActionAt = now
				tbl4:Push("Placed " .. fn14(tbl22.Target and tbl22.Target.AssetCategory or tbl13.Category), 2)
			else
				tbl22.FailCount = tbl22.FailCount + 1

				if tbl22.FailCount >= 3 then
					fn42("PlayerRequest")
					fn45("Idle")
					tbl22.ActionAt = now
				end
			end

			return
		end

		if state == "Holding" then
			if fn53() then
				fn45("Placing")
			end

			return
		end
	end
end

local tbl23
tbl23 = { On = false }
local tbl24
tbl24 = { Active = false, EquipAt = 0 }

fn10(tbl7.TreadmillActiveChanged, function(arg, arg2)
	if arg == localPlayer then
		tbl24.Active = arg2 == true
	end
end)

local fn47, fn48

local function fn49()
	local v4 = fn21()
	if not v4 then
		return nil
	end
	local treadmillBottom = v4:FindFirstChild("TreadmillBottom")
	return treadmillBottom and treadmillBottom:IsA("BasePart") and treadmillBottom or nil
end

fn47 = function()
	if not tbl24.Active then
		return true
	end
	fn8(tbl7.TreadmillUnequip)
	tbl24.Active = false
	return true
end

fn48 = function()
	if not tbl23.On then
		return
	end

	if fn36() or tbl16.On and tbl22.State ~= "Idle" then
		if tbl24.Active then
			fn47()
		end

		return
	end

	local v4 = fn49()
	if not v4 then
		return
	end
	local v5 = fn20()
	if not v5 then
		return
	end

	if tbl24.Active then
		tbl4:Status("Treadmill")
		tbl4:Detail("SpeedPower " .. tostring(fn11() and fn11().SpeedPower or 0))
		return
	end

	local flag2 = (v5.Position - v4.Position).Magnitude <= 7

	if flag2 then
		local equipAt = tbl24.EquipAt
		flag2 = os.clock() - equipAt > 2
	end

	if flag2 then
		tbl24.EquipAt = os.clock()

		if fn8(tbl7.TreadmillEquipStatic) == true then
			tbl24.Active = true
			tbl4:Status("Treadmill")
		end

		return
	end

	if fn31(v4.Position, 7) then
		tbl11:Stop()
		tbl24.EquipAt = 0
		return
	end

	tbl11:Go(v4.Position, 6)
end

local tbl25
tbl25 = { Base = false, Treadmill = false, Offline = false, Index = false }
local fn50

fn50 = function()
	if not tbl25.Base then
		return
	end
	local v4 = fn11()
	if not v4 then
		return
	end
	local baseUpgradeLevel = v4.BaseUpgradeLevel
	local bases = Data and Data.BASES and Data.BASES[baseUpgradeLevel + 1]
	if not bases then
		return
	end

	if bases.Cost <= v4.Money then
		fn9(tbl7.BaseUpgrade)
		tbl4:Push("Base -> Lv " .. tostring(baseUpgradeLevel + 1), 2)
	end
end

local fn51

fn51 = function()
	if not tbl25.Treadmill then
		return
	end
	local v4 = fn11()
	if not v4 then
		return
	end
	local getByUpgradeLevel = Data2 and Data2.GetByUpgradeLevel and Data2.GetByUpgradeLevel(v4.TreadmillUpgradeLevel + 1)
	if not getByUpgradeLevel then
		return
	end

	if (getByUpgradeLevel.Price or math.huge) <= v4.Money then
		if fn8(tbl7.TreadmillUpgrade, getByUpgradeLevel._id) == true then
			tbl4:Push("Treadmill -> " .. tostring(getByUpgradeLevel._id), 2)
		end
	end
end

local fn52

fn52 = function()
	if not tbl25.Offline then
		return
	end
	local v4 = fn8(tbl7.OfflineGetSummary)
	if type(v4) ~= "table" then
		return
	end

	if (v4.ClaimableAmount or 0) > 0 then
		fn8(tbl7.OfflineRedeem)
		tbl4:Push("Claimed " .. fn18(v4.ClaimableAmount) .. " offline", 2)
	end
end

local fn53

fn53 = function()
	if not tbl25.Index then
		return
	end
	local v4, v5 = fn8(tbl7.IndexClaimAll)

	if v4 == true then
		tbl4:Push("Claimed index rewards", 2)
	elseif type(v5) == "string" and not v5:find("No index rewards") then
		fn5("Progress", v5, 2, "triangle-alert")
	end
end

local tbl26

tbl26 = {
	AutoFavorite = false,
	FavMinRarity = 0,
	FavMutation = "",
	AutoSell = false,
	SellRule = "Both",
	MaxRarity = 0,
	IncomeThreshold = 0,
	Blacklist = {},
	EquipBest = false,
}

local fn54, fn55, fn56, fn57, tbl27, tbl28, fn58

do
	local n = 0

	fn54 = function()
		local tbl29 = {}
		local userId = localPlayer.UserId

		local function fn59(arg, arg2)
			if not arg or not arg2 or tbl29[arg] then
				return
			end
			tbl29[arg] = { UID = arg, ItemData = arg2 }
		end

		local v4 = fn8(tbl7.AssetRuntimeSnapshot)

		if type(v4) == "table" then
			for _, v5 in ipairs(v4) do
				if v5 and v5.OwnerUserId == userId and type(v5.Records) == "table" then
					for k, record in pairs(v5.Records) do
						if record and record.ItemData then
							fn59(k, record.ItemData)
						end
					end
				end
			end
		end

		if Client3 then
			local ok, result = pcall(Client3.ReadSnapshot)

			if ok then
				for k, v5 in pairs(fn41(result)) do
					if v5 then
						fn59(k, v5.ItemData)
					end
				end
			end
		end

		local v5 = fn11()

		if v5 and type(v5.Inventory) == "table" then
			for k, v6 in pairs(v5.Inventory) do
				if type(v6) == "table" then
					fn59(k, v6.ItemData or v6)
				end
			end
		end

		return tbl29
	end

	local function fn59(arg)
		return fn12(arg.Category)
	end

	local function fn60(arg)
		return arg.GeneratedMoney or fn15(arg.Category)
	end

	local function fn61(arg)
		return arg.Mutations or {}
	end

	local function fn62(arg)
		local flag2 = tbl26.FavMinRarity > 0

		if flag2 then
			local favMinRarity = tbl26.FavMinRarity
			flag2 = fn59(arg) < favMinRarity
		end

		if flag2 then
			return false
		end

		if tbl26.FavMutation ~= "" then
			local flag3 = false

			for _, v4 in ipairs(fn61(arg)) do
				if v4 == tbl26.FavMutation then
					flag3 = true
					break
				end
			end

			if not flag3 then
				return false
			end
		end

		return true
	end

	local function fn63(arg, arg2)
		if tbl26.Blacklist[arg2] then
			return false
		end

		if arg.IsFavorite == true then
			return false
		end
		local flag2 = tbl26.MaxRarity > 0

		if flag2 then
			local maxRarity = tbl26.MaxRarity
			flag2 = fn59(arg) > maxRarity
		end

		if flag2 then
			return false
		end
		local flag3 = tbl26.IncomeThreshold > 0

		if flag3 then
			local incomeThreshold = tbl26.IncomeThreshold
			flag3 = fn60(arg) >= incomeThreshold
		end

		if flag3 then
			return false
		end

		if tbl26.SellRule == "Rarity" then
			return tbl26.MaxRarity > 0
		end

		if tbl26.SellRule == "Income" then
			return tbl26.IncomeThreshold > 0
		end
		return tbl26.MaxRarity > 0 or tbl26.IncomeThreshold > 0
	end

	local function fn64(arg)
		fn9(tbl7.SetFavorite, arg, true)
	end

	local function fn65(arg)
		if fn8(tbl7.RequestSell, arg) == true then
			return true
		end
		fn9(tbl7.SellAsset, arg)
		return false
	end

	fn55 = function(arg)
		return fn8(tbl7.SetAutoSell, arg or {}) == true
	end

	local function fn66()
		if not tbl26.AutoFavorite then
			return
		end

		for k, v4 in pairs(fn54()) do
			if v4.ItemData.IsFavorite ~= true and fn62(v4.ItemData) then
				fn64(k)
			end
		end
	end

	local function fn67()
		if not tbl26.AutoSell then
			return
		end

		for k, v4 in pairs(fn54()) do
			if fn63(v4.ItemData, k) then
				fn65(k)
			end
		end
	end

	fn56 = function()
		local n2 = 0

		for k, v4 in pairs(fn54()) do
			if v4.ItemData.IsFavorite ~= true and fn62(v4.ItemData) then
				fn64(k)
				n2 += 1
			end
		end

		fn5("Pets", ("Favorited %d pet%s."):format(n2, n2 == 1 and "" or "s"), 2, "star")
	end

	fn57 = function()
		local n2 = 0

		for k, v4 in pairs(fn54()) do
			if fn63(v4.ItemData, k) then
				fn65(k)
				n2 += 1
			end
		end

		fn5("Pets", ("Selling %d pet%s..."):format(n2, n2 == 1 and "" or "s"), 2, "coins")
	end

	local function fn68()
		if not tbl26.EquipBest then
			return
		end

		if os.clock() - n < 8 then
			return
		end
		n = os.clock()
		fn8(tbl7.EquipBest)
	end

	tbl17 = { Eggs = false, RareEggs = false, RareThreshold = 0, Guards = false }
	local v4 = tbl2:Instance(Instance.new("Folder"))
	v4.Name = "StealEggESP"
	v4.Parent = v2
	tbl27 = {}
	tbl28 = {}

	local function fn69(text, textColor3)
		local part = Instance.new("Part")
		part.Size = Vector3.new(0.2, 0.2, 0.2)
		part.Transparency = 1
		part.Anchored = true
		part.CanCollide = false
		part.CanQuery = false
		part.CanTouch = false
		part.Parent = v4
		local billboardGui = Instance.new("BillboardGui")
		billboardGui.Size = UDim2.fromOffset(220, 60)
		billboardGui.StudsOffset = Vector3.new(0, 3, 0)
		billboardGui.AlwaysOnTop = true
		billboardGui.MaxDistance = 9000
		billboardGui.Parent = part
		local textLabel = Instance.new("TextLabel")
		textLabel.BackgroundTransparency = 1
		textLabel.Size = UDim2.new(1, 0, 0.6, 0)
		textLabel.Font = Enum.Font.GothamBold
		textLabel.TextSize = 13
		textLabel.TextColor3 = textColor3
		textLabel.TextStrokeTransparency = 0.3
		textLabel.Text = text
		textLabel.Parent = billboardGui
		local clone = textLabel:Clone()
		clone.Position = UDim2.new(0, 0, 0.5, 0)
		clone.Size = UDim2.new(1, 0, 0.5, 0)
		clone.Font = Enum.Font.Gotham
		clone.TextSize = 11
		clone.TextColor3 = Color3.fromRGB(220, 220, 220)
		clone.Parent = billboardGui
		return part, billboardGui, textLabel, clone
	end

	local function fn70(arg)
		for _, v5 in pairs(arg) do
			pcall(function()
				v5.Part:Destroy()
			end)
		end

		table.clear(arg)
	end

	local function fn71()
		local position = fn20()
		position = position and position.Position

		if tbl17.Eggs or tbl17.RareEggs then
			if tbl12:Refresh() then
				local tbl29 = {}

				for k, v5 in pairs(tbl12.ByUid) do
					local v6 = fn12(v5.AssetCategory)

					if (tbl17.Eggs or tbl17.RareEggs and v6 >= tbl17.RareThreshold) and v5.BottomCFrame then
						tbl29[k] = true
						local tbl30 = tbl27[k]

						if not tbl30 then
							local v7, v8, v9, v10 = fn69(fn14(v5.AssetCategory), fn17(v6))
							tbl30 = { Part = v7, Billboard = v8, Label = v9, Sub = v10 }
							tbl27[k] = tbl30
						end

						tbl30.Part.CFrame = v5.BottomCFrame + Vector3.new(0, 2, 0)
						local magnitude = position and (v5.BottomCFrame.Position - position).Magnitude or 0
						local assetCategory = v5.AssetCategory
						tbl30.Label.Text = ("%s [%s]"):format(fn14(v5.AssetCategory), fn13(assetCategory))
						tbl30.Sub.Text = string.format("%.0f studs", magnitude)
						tbl30.Label.TextColor3 = fn17(v6)
					end
				end

				for k in pairs(tbl27) do
					if not tbl29[k] then
						pcall(function()
							tbl27[k].Part:Destroy()
						end)

						tbl27[k] = nil
					end
				end
			end
		elseif next(tbl27) then
			fn70(tbl27)
		end

		if tbl17.Guards then
			for _, v5 in ipairs(fn37()) do
				local humanoidRootPart = v5:FindFirstChild("HumanoidRootPart")

				if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
					local name = v5.Parent and v5.Parent.Name or "?"
					local tbl29 = tbl28[name]

					if not tbl29 then
						local Guard, v6, v7, v8 = fn69("Guard", color2)
						tbl29 = { Part = Guard, Billboard = v6, Label = v7, Sub = v8 }
						tbl28[name] = tbl29
					end

					tbl29.Part.CFrame = humanoidRootPart.CFrame
					local attribute = v5:GetAttribute("GuardState") or "Sleep"
					local magnitude = position and (humanoidRootPart.Position - position).Magnitude or 0
					tbl29.Label.Text = ("Guard [%s]"):format(attribute)
					tbl29.Sub.Text = string.format("%s | %.0f studs", name, magnitude)
					tbl29.Label.TextColor3 = attribute == "Sleep" and Color3.fromRGB(150, 150, 150) or color2
				end
			end
		elseif next(tbl28) then
			fn70(tbl28)
		end
	end

	local tbl29 = {}

	fn58 = function(arg, arg2)
		return function(...)
			if tbl29[arg] then
				return
			end
			tbl29[arg] = true
			local v5 = table.pack(...)

			task.spawn(function()
				local ok, result = pcall(arg2, table.unpack(v5, 1, v5.n))
				tbl29[arg] = false

				if not ok then
					warn(("[%s] %s: %s"):format("Steal a Egg", arg, tostring(result)))
				end
			end)
		end
	end

	tbl3:Job("Mover", fn32)
	local flag2 = false

	tbl3:Every("EggStore", 2, function()
		if flag2 then
			return
		end

		if not (tbl16.On or tbl17.Eggs or tbl17.RareEggs) then
			return
		end
		flag2 = true

		task.spawn(function()
			pcall(function()
				tbl12:Refresh(true)
			end)

			flag2 = false
		end)
	end)

	tbl3:Every("Farm", 0.15, fn46)
	local every = tbl3.Every
	local AutoHatch = fn58("AutoHatch", fn43)
	every(tbl3, "AutoHatch", 2, AutoHatch)
	tbl3:Every("AutoPlace", 0.4, fn44)
	local every2 = tbl3.Every
	local Treadmill = fn58("Treadmill", fn48)
	every2(tbl3, "Treadmill", 0.8, Treadmill)
	tbl3:Every("Guards", 0.4, fn38)
	tbl3:Every("BaseUpgrade", 1.2, fn50)
	local every3 = tbl3.Every
	local TreadmillUpgrade = fn58("TreadmillUpgrade", fn51)
	every3(tbl3, "TreadmillUpgrade", 1.4, TreadmillUpgrade)
	local every4 = tbl3.Every
	local OfflineClaim = fn58("OfflineClaim", fn52)
	every4(tbl3, "OfflineClaim", 3, OfflineClaim)
	local every5 = tbl3.Every
	local IndexClaim = fn58("IndexClaim", fn53)
	every5(tbl3, "IndexClaim", 3, IndexClaim)
	local every6 = tbl3.Every
	local Favorite = fn58("Favorite", fn66)
	every6(tbl3, "Favorite", 2.5, Favorite)
	local every7 = tbl3.Every
	local Sell = fn58("Sell", fn67)
	every7(tbl3, "Sell", 3, Sell)
	local every8 = tbl3.Every
	local EquipBest = fn58("EquipBest", fn68)
	every8(tbl3, "EquipBest", 8, EquipBest)
	local every9 = tbl3.Every
	local EggEsp = fn58("EggEsp", fn71)
	every9(tbl3, "EggEsp", 1, EggEsp)

	fn10(tbl7.AreaEggUpdated, function(arg)
		if type(arg) ~= "table" or not arg.Uid then
			return
		end
		local userId = localPlayer.UserId
		if arg.State == "Carried" and arg.CarrierUserId then
			tbl19.LastCarrier[arg.Uid] = arg.CarrierUserId
			return
		end

		if arg.State ~= "Dropped" then
			if arg.State == "Slot" then
				tbl19.LastCarrier[arg.Uid] = nil
			end

			return
		end

		if not tbl19.On then
			return
		end

		if tbl19.LastCarrier[arg.Uid] == userId then
			return
		end

		if fn36() then
			return
		end
		local minRarity = tbl19.MinRarity
		if fn12(arg.AssetCategory) < minRarity then
			return
		end
		local uid = arg.Uid
		local assetCategory = arg.AssetCategory

		task.spawn(function()
			for i = 1, 6 do
				if fn35(uid) then
					tbl19.Taken = tbl19.Taken + 1
					tbl19.LastCarrier[uid] = userId
					tbl4:Push("Sniped " .. fn14(assetCategory), 2)
					return
				end

				task.wait(0.15)
			end
		end)
	end)

	local n2 = 0

	local function fn72()
		for _, v5 in ipairs({ localPlayer.Character, localPlayer:FindFirstChildOfClass("Backpack") }) do
			if v5 then
				for _, child in ipairs(v5:GetChildren()) do
					if child:IsA("Tool") and string.find(child.Name, "Bat", 1, true) == 1 then
						return child
					end
				end
			end
		end

		return nil
	end

	tbl3:Every("BatAura", 0.2, function()
		if not tbl20.On then
			return
		end
		local rate = tbl20.Rate
		if os.clock() - n2 < rate then
			return
		end
		local v5, v6, v7 = fn3()
		if not v7 then
			return
		end
		local v8 = fn72()
		if not v8 then
			return
		end

		if v8.Parent ~= v5 then
			pcall(function()
				v8.Parent = v5
			end)

			return
		end

		local humanoidRootPart = nil

		for _, player in ipairs(v:GetPlayers()) do
			if player ~= localPlayer and player.Character then
				humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
				if not (humanoidRootPart and (humanoidRootPart.Position - v7.Position).Magnitude <= tbl20.Range) then
					humanoidRootPart = nil
					continue
				end
			else
				humanoidRootPart = nil
				continue
			end

			break
		end

		if not humanoidRootPart then
			return
		end
		n2 = os.clock()

		pcall(function()
			v8:Activate()
		end)
	end)

	tbl2:Callback(function()
		fn30()
		fn70(tbl27)
		fn70(tbl28)

		if fn36() then
			fn42("PlayerRequest")
		end

		if tbl24.Active then
			fn8(tbl7.TreadmillUnequip)
		end
	end)
end

local stealAEgg = fn7(tbl6.Home, "Steal a Egg")
stealAEgg:Paragraph({ Title = "Discord", Content = "https://discord.gg/yTUe6JNhCx" })

stealAEgg:Button({
	Name = "Copy Discord Invite",
	Callback = function()
		fn2("https://discord.gg/yTUe6JNhCx")
		fn5("Steal a Egg", "Invite copied to clipboard.", 2, "copy")
	end,
})

do
	local anticheat = fn7(tbl6.Home, "Anticheat")

	anticheat:Paragraph({
		Title = "Movement Protection",
		Content = "Auto Steal turns this on for you and keeps it applied through respawns. The farm does not survive without it. Use the button below to turn it back off.",
	})

	local function fn59()
		local character = localPlayer.Character
		if not character then
			return false, "No character."
		end
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if not (humanoid and humanoid:GetAttribute("CitraSwapped")) then
			return false, "Nothing to restore -- protection is not active."
		end
		tbl10.Done = false
		tbl10.Running = true
		local animate = character:FindFirstChild("Animate")

		if animate and animate:IsA("LocalScript") then
			animate.Disabled = true
		end

		local clone = tbl10.Original and tbl10.Original:Clone() or Instance.new("Humanoid")

		for _, child in ipairs(clone:GetChildren()) do
			if child:IsA("Animator") then
				child:Destroy()
			end
		end

		Instance.new("Animator").Parent = clone
		humanoid.Name = "_OldHumanoid"
		clone.Name = "Humanoid"
		clone.Parent = character

		pcall(function()
			workspace.CurrentCamera.CameraSubject = clone
		end)

		humanoid:Destroy()
		fn27(character)
		fn28(clone)
		tbl10.Running = false
		return true
	end

	anticheat:Button({
		Name = "Restore Character",
		Tooltip = "Turns the protection off and puts your character back. Turn Auto Steal off first.",
		Callback = function()
			if tbl16.On then
				fn5("Steal a Egg", "Turn Auto Steal off first -- it re-applies protection.", 4, "triangle-alert")
				return
			end
			local v4, v5 = fn59()

			if v4 then
				fn5("Steal a Egg", "Character restored. Rejoin for a fully clean state.", 5, "rotate-ccw")
			else
				fn5("Steal a Egg", v5, 4, "triangle-alert")
			end
		end,
	})
end

do
	local steal = fn7(tbl6.Farm, "Steal")

	steal:Toggle({
		Name = "Auto Steal",
		Tooltip = "Steal eggs from areas, run them home and place them.",
		Default = false,
		Flag = "SAEAutoSteal",
		Callback = function(on)
			tbl16.On = on

			if on then
				fn29()
				tbl4:Status("Farm")
			else
				fn45("Idle")
				tbl22.Target = nil
				tbl11:Stop()
				tbl4:Clear()
			end
		end,
	})

	local function fn59()
		local tbl29 = {}
		local guardAreas = v2:FindFirstChild("__OBJECTS") and v2.__OBJECTS:FindFirstChild("Areas") and v2.__OBJECTS.Areas:FindFirstChild("GuardAreas")

		if guardAreas then
			for _, child in ipairs(guardAreas:GetChildren()) do
				if child:IsA("Model") then
					tbl29[#tbl29 + 1] = child.Name
				end
			end

			table.sort(tbl29)
		end

		return tbl29
	end

	steal:Dropdown({
		Name = "Target Areas",
		Tooltip = "Empty = all areas",
		Items = fn59(),
		Default = nil,
		Multi = true,
		Callback = function(arg)
			if type(arg) == "table" then
			end

			local areas = {}
			local value = AreaDropdown.Value

			if type(value) == "table" then
				for _, v4 in ipairs(value) do
					areas[v4] = true
				end
			elseif value then
				areas[value] = true
			end

			tbl16.Areas = areas
		end,
	})

	local function fn60()
		local tbl29 = {}

		if directory then
			for k in pairs(directory) do
				tbl29[#tbl29 + 1] = k
			end

			table.sort(tbl29)
		end

		return tbl29
	end

	steal:Dropdown({
		Name = "Target Eggs",
		Tooltip = "Empty = all eggs",
		Items = fn60(),
		Default = nil,
		Multi = true,
		Callback = function()
			local eggs = {}
			local value = EggDropdown.Value

			if type(value) == "table" then
				for _, v4 in ipairs(value) do
					eggs[v4] = true
				end
			elseif value then
				eggs[value] = true
			end

			tbl16.Eggs = eggs
		end,
	})

	local tbl29 = { "Disabled" }

	for _, v4 in ipairs(tbl8) do
		tbl29[#tbl29 + 1] = v4.name
	end

	steal:Dropdown({
		Name = "Minimum Rarity",
		Items = tbl29,
		Default = "Disabled",
		Callback = function(arg)
			if type(arg) == "table" then
				arg = arg[1]
			end

			for _, v4 in ipairs(tbl8) do
				if v4.name == arg then
					tbl16.MinRarity = v4.n
					return
				end
			end

			tbl16.MinRarity = 0
		end,
	})

	steal:Dropdown({
		Name = "Steal Priority",
		Items = { "Rarity", "Closest", "Income" },
		Default = "Rarity",
		Callback = function(priority)
			if type(priority) == "table" then
				priority = priority[1]
			end

			tbl16.Priority = priority
		end,
	})

	steal:Dropdown({
		Name = "Movement",
		Items = { "Tween", "Hop", "Walk" },
		Default = "Tween",
		Callback = function(mode)
			if type(mode) == "table" then
				mode = mode[1]
			end

			tbl9.Mode = mode
			tbl11.FallbackWalk = false

			if mode ~= "Walk" then
				fn30()
			end
		end,
	})

	steal:Slider({
		Name = "Walk Speed",
		Tooltip = "Used by Walk mode and by the fallback when a run stalls.",
		Default = 100,
		Min = 16,
		Max = 1000,
		Decimals = 5,
		Flag = "SAEWalkSpeed",
		Callback = function(walkSpeed)
			tbl9.WalkSpeed = walkSpeed
		end,
	})

	steal:Slider({
		Name = "Tween Speed",
		Default = 400,
		Min = 20,
		Max = 500,
		Decimals = 5,
		Flag = "SAETweenSpeed",
		Callback = function(tweenSpeed)
			tbl9.TweenSpeed = tweenSpeed
		end,
	})

	steal:Slider({
		Name = "Steal Hop Size",
		Default = 30,
		Min = 10,
		Max = 120,
		Decimals = 5,
		Flag = "SAEHopSize",
		Callback = function(hopSize)
			tbl9.HopSize = hopSize
		end,
	})

	steal:Slider({
		Name = "Hop Speed",
		Tooltip = "Hops per second. Higher is faster but easier for the game to correct.",
		Default = 40,
		Min = 4,
		Max = 45,
		Decimals = 1,
		Flag = "SAEHopRate",
		Callback = function(hopRate)
			tbl9.HopRate = hopRate
		end,
	})
end

local placeEgg = fn7(tbl6.Farm, "Place Egg")

placeEgg:Toggle({
	Name = "Auto Place Egg",
	Tooltip = "Place carried eggs into your pen when you get home.",
	Default = false,
	Flag = "SAEAutoPlace",
	Callback = function(autoPlace)
		tbl16.AutoPlace = autoPlace
	end,
})

placeEgg:Dropdown({
	Name = "Place Rule",
	Items = { "Always", "When Pen Full" },
	Default = "Always",
	Callback = function(arg)
		if type(arg) == "table" then
			arg = arg[1]
		end

		tbl16.PlaceRule = arg == "When Pen Full" and "Full" or "Always"
	end,
})

placeEgg:Toggle({
	Name = "Auto Hatch Ready Eggs",
	Tooltip = "Hatch growing eggs as soon as they're ready.",
	Default = false,
	Flag = "SAEAutoHatch",
	Callback = function(autoHatch)
		tbl16.AutoHatch = autoHatch
	end,
})

fn7(tbl6.Farm, "Treadmill"):Toggle({
	Name = "Auto Treadmill",
	Tooltip = "Train when idle. Pauses while carrying or stealing.",
	Default = false,
	Flag = "SAEAutoTreadmill",
	Callback = function(on)
		tbl23.On = on

		if not on then
			fn47()
		end
	end,
})

do
	local guardSafety = fn7(tbl6.Farm, "Guard Safety")

	guardSafety:Toggle({
		Name = "Guard Warning",
		Tooltip = "Notify when a guard is chasing you.",
		Default = false,
		Flag = "SAEGuardWarning",
		Callback = function(warning)
			tbl18.Warning = warning
		end,
	})

	guardSafety:Toggle({
		Name = "Auto Drop Egg",
		Tooltip = "Drop the carried egg the moment a guard chases you.",
		Default = false,
		Flag = "SAEAutoDrop",
		Callback = function(autoDrop)
			tbl18.AutoDrop = autoDrop
		end,
	})

	local snipe = fn7(tbl6.Farm, "Snipe")

	snipe:Toggle({
		Name = "Snipe Dropped Eggs",
		Tooltip = "Claim eggs other players drop. The window is about two seconds.",
		Default = false,
		Flag = "SAESnipe",
		Callback = function(on)
			tbl19.On = on
		end,
	})

	local tbl29 = { "Any" }

	for _, v4 in ipairs(tbl8) do
		tbl29[#tbl29 + 1] = v4.name
	end

	snipe:Dropdown({
		Name = "Snipe Min Rarity",
		Items = tbl29,
		Default = "Any",
		Callback = function(arg)
			if type(arg) == "table" then
				arg = arg[1]
			end

			for _, v4 in ipairs(tbl8) do
				if v4.name == arg then
					tbl19.MinRarity = v4.n
					return
				end
			end

			tbl19.MinRarity = 0
		end,
	})

	local bat = fn7(tbl6.Farm, "Bat")

	bat:Toggle({
		Name = "Bat Kill Aura",
		Tooltip = "Swing the bat at any player in range.",
		Default = false,
		Flag = "SAEBatAura",
		Callback = function(on)
			tbl20.On = on
		end,
	})

	bat:Slider({
		Name = "Bat Range",
		Default = 25,
		Min = 5,
		Max = 60,
		Decimals = 1,
		Flag = "SAEBatRange",
		Callback = function(range)
			tbl20.Range = range
		end,
	})

	guardSafety:Toggle({
		Name = "Anti Ragdoll",
		Tooltip = "Stand straight back up when something knocks you down.",
		Default = false,
		Flag = "SAEAntiRagdoll",
		Callback = function(antiRagdoll)
			tbl.AntiRagdoll = antiRagdoll
			local character = localPlayer.Character
			character = character and character:FindFirstChildOfClass("Humanoid")

			if antiRagdoll and character then
				tbl.Apply(character)
			end
		end,
	})

	guardSafety:Toggle({
		Name = "Anti Guard",
		Tooltip = "Grab the egg straight back when a guard knocks it out of you.",
		Default = false,
		Flag = "SAEAntiGuard",
		Callback = function(on)
			tbl14.On = on
		end,
	})

	guardSafety:Slider({
		Name = "Guard Chase Distance",
		Default = 25,
		Min = 10,
		Max = 60,
		Decimals = 1,
		Flag = "SAEChaseDist",
		Callback = function(distance)
			tbl18.Distance = distance
		end,
	})
end

local autoUpgrades = fn7(tbl6.Progress, "Auto Upgrades")

autoUpgrades:Toggle({
	Name = "Auto Upgrade Base",
	Tooltip = "Buy the next base upgrade whenever affordable.",
	Default = false,
	Flag = "SAEUpBase",
	Callback = function(base)
		tbl25.Base = base
	end,
})

autoUpgrades:Toggle({
	Name = "Auto Upgrade Treadmill",
	Tooltip = "Buy the next treadmill whenever affordable.",
	Default = false,
	Flag = "SAEUpTM",
	Callback = function(treadmill)
		tbl25.Treadmill = treadmill
	end,
})

local autoClaim = fn7(tbl6.Progress, "Auto Claim")

autoClaim:Toggle({
	Name = "Auto Claim Offline Money",
	Default = false,
	Flag = "SAEClaimOffline",
	Callback = function(offline)
		tbl25.Offline = offline
	end,
})

autoClaim:Toggle({
	Name = "Auto Claim Index Rewards",
	Default = false,
	Flag = "SAEClaimIndex",
	Callback = function(index)
		tbl25.Index = index
	end,
})

autoClaim:Paragraph({
	Title = "Costs",
	Content = "Base Lv2: 1K | Lv3: 1M | Lv4: 75M | Treadmill Lv2: 15K | Lv3: 250K | Lv4: 5M",
})

do
	local eggs = fn7(tbl6.ESP, "Eggs")

	eggs:Toggle({
		Name = "ESP Eggs",
		Tooltip = "Mark every area egg with name, rarity and distance.",
		Default = false,
		Flag = "SAEEspEggs",
		Callback = function(eggs2)
			tbl17.Eggs = eggs2
		end,
	})

	eggs:Toggle({
		Name = "ESP Rare Eggs",
		Tooltip = "Only mark eggs at or above the threshold below.",
		Default = false,
		Flag = "SAEEspRare",
		Callback = function(rareEggs)
			tbl17.RareEggs = rareEggs
		end,
	})

	local tbl29 = {}
	local tbl30 = {}

	for _, v4 in ipairs(tbl8) do
		tbl29[#tbl29 + 1] = v4.name
		tbl30[v4.name] = v4.n
	end

	local str2 = nil

	for _, v4 in ipairs(tbl29) do
		if tostring(v4):lower() == "mythic" then
			str2 = v4
		end
	end

	str2 = str2 or tbl29[#tbl29] or "Mythic"
	tbl17.RareThreshold = tbl30[str2] or 0

	eggs:Dropdown({
		Name = "Rare Threshold",
		Items = tbl29,
		Default = str2,
		Callback = function(arg)
			if type(arg) == "table" then
				arg = arg[1]
			end

			tbl17.RareThreshold = tbl30[arg] or 0
		end,
	})
end

fn7(tbl6.ESP, "Guards"):Toggle({
	Name = "ESP Guards",
	Tooltip = "Mark guards with state and distance.",
	Default = false,
	Flag = "SAEEspGuards",
	Callback = function(guards)
		tbl17.Guards = guards
	end,
})

do
	local autoFavorite = fn7(tbl6.Pets, "Auto Favorite")

	autoFavorite:Toggle({
		Name = "Auto Favorite",
		Default = false,
		Flag = "SAEAutoFav",
		Callback = function(autoFavorite2)
			tbl26.AutoFavorite = autoFavorite2
		end,
	})

	local tbl29 = { "Disabled" }

	for _, v4 in ipairs(tbl8) do
		tbl29[#tbl29 + 1] = v4.name
	end

	autoFavorite:Dropdown({
		Name = "Favorite Min Rarity",
		Items = tbl29,
		Default = "Disabled",
		Callback = function(arg)
			if type(arg) == "table" then
				arg = arg[1]
			end

			for _, v4 in ipairs(tbl8) do
				if v4.name == arg then
					tbl26.FavMinRarity = v4.n
					return
				end
			end

			tbl26.FavMinRarity = 0
		end,
	})

	autoFavorite:Textbox({
		Name = "Favorite Mutation",
		Placeholder = "Golden / Silver / empty = any",
		Finished = true,
		Callback = function(favMutation)
			tbl26.FavMutation = favMutation or ""
		end,
	})

	autoFavorite:Button({ Name = "Favorite Pets Now", Callback = fn56 })
end

do
	local autoSell = fn7(tbl6.Pets, "Auto Sell")

	autoSell:Toggle({
		Name = "Auto Sell",
		Default = false,
		Flag = "SAEAutoSell",
		Callback = function(autoSell2)
			tbl26.AutoSell = autoSell2
		end,
	})

	autoSell:Dropdown({
		Name = "Sell Rule",
		Items = { "Rarity Only", "Income Only", "Both" },
		Default = "Both",
		Callback = function(arg)
			if type(arg) == "table" then
				arg = arg[1]
			end

			tbl26.SellRule = arg == "Rarity Only" and "Rarity" or arg == "Income Only" and "Income" or "Both"
		end,
	})

	local tbl29 = { "Disabled" }

	for _, v4 in ipairs(tbl8) do
		tbl29[#tbl29 + 1] = v4.name
	end

	autoSell:Dropdown({
		Name = "Pet Max Rarity",
		Tooltip = "Sell pets at or below this rarity.",
		Items = tbl29,
		Default = "Disabled",
		Callback = function(arg)
			if type(arg) == "table" then
				arg = arg[1]
			end

			for _, v4 in ipairs(tbl8) do
				if v4.name == arg then
					tbl26.MaxRarity = v4.n
					return
				end
			end

			tbl26.MaxRarity = 0
		end,
	})

	autoSell:Textbox({
		Name = "Pet Income Threshold",
		Tooltip = "Sell pets below this income. 0 or empty = disabled. e.g. 10M",
		Placeholder = "10M",
		Finished = true,
		Callback = function(arg)
			local v4 = fn19(arg)

			if v4 ~= nil then
				tbl26.IncomeThreshold = v4
			end
		end,
	})

	autoSell:Button({ Name = "Sell Pets Now", Callback = fn57 })
end

do
	local gameAutoSell = fn7(tbl6.Pets, "Game Auto Sell")
	local tbl29 = {}

	for _, v4 in ipairs(tbl8) do
		tbl29[#tbl29 + 1] = v4.name
	end

	local v4 = gameAutoSell:Dropdown({
		Name = "Auto Sell Rarities",
		Tooltip = "The game's own auto sell. Runs server side, works offline.",
		Items = tbl29,
		Default = nil,
		Multi = true,
		Callback = function()
			local tbl30 = {}
			local value = NativeDropdown.Value

			if type(value) == "table" then
				for _, v4 in ipairs(value) do
					tbl30[v4] = true
				end
			elseif value then
				tbl30[value] = true
			end

			if fn55(tbl30) then
				local n = 0

				for k in pairs(tbl30) do
					n += 1
				end

				local v4 = fn5
				local str2 = n == 0 and "Game auto sell off."

				if not str2 then
					str2 = ("Game auto sell: %d rarit%s."):format(n, n == 1 and "y" or "ies")
				end

				v4("Pets", str2, 2, "coins")
			end
		end,
	})

	task.spawn(function()
		fn(function()
			local v5 = fn8(tbl7.GetAutoSell)
			if type(v5) ~= "table" then
				return
			end
			local tbl30 = {}

			for k, v6 in pairs(v5) do
				if v6 then
					tbl30[#tbl30 + 1] = k
				end
			end

			if #tbl30 > 0 then
				v4:Set(tbl30)
			end
		end)
	end)
end

fn7(tbl6.Pets, "Auto Equip"):Toggle({
	Name = "Auto Equip Best",
	Tooltip = "Equip the best pets into your pen (game's Equip Best).",
	Default = false,
	Flag = "SAEEquipBest",
	Callback = function(equipBest)
		tbl26.EquipBest = equipBest
	end,
})

do
	local sellBlacklist = fn7(tbl6.Pets, "Sell Blacklist")

	local function fn59(arg, arg2)
		local str2 = table.concat(arg2.ItemData.Mutations or {}, "+")
		local str3 = str2 ~= "" and " (" .. str2 .. ")" or ""
		return ("%s [%s]%s uid:%s"):format(fn14(arg2.ItemData.Category), fn13(arg2.ItemData.Category), str3, arg)
	end

	local v4 = sellBlacklist:Dropdown({
		Name = "Add Pet To Blacklist",
		Tooltip = "Select a pet, it will never be sold",
		Items = {},
		Default = nil,
	})

	sellBlacklist:Button({
		Name = "Blacklist Selected",
		Callback = function()
			local value = v4.Value

			if type(value) == "table" then
				value = value[1]
			end

			if not value then
				fn5("Pets", "Select a pet first.", 2, "triangle-alert")
				return
			end
			local match = value:match("uid:(%S+)$")

			if match then
				tbl26.Blacklist[match] = value:match("^(.-) uid:") or match
				fn5("Pets", "Blacklisted.", 2, "ban")
			end
		end,
	})

	local v5 = sellBlacklist:Dropdown({ Name = "Blacklisted Pets", Items = {}, Default = nil })

	local function fn60()
		local tbl29 = {}

		for k, v6 in pairs(tbl26.Blacklist) do
			local n = #tbl29 + 1
			v6 = v6 or k
			tbl29[n] = v6 .. " uid:" .. k
		end

		table.sort(tbl29)

		fn(function()
			v5:Refresh(tbl29)
		end)
	end

	sellBlacklist:Button({
		Name = "Remove Selected",
		Callback = function()
			local value = v5.Value

			if type(value) == "table" then
				value = value[1]
			end

			if not value then
				return
			end
			local match = value:match("uid:(%S+)$")

			if match then
				tbl26.Blacklist[match] = nil
				fn60()
			end
		end,
	})

	sellBlacklist:Button({
		Name = "Clear Blacklist",
		Callback = function()
			table.clear(tbl26.Blacklist)
			fn60()
			fn5("Pets", "Blacklist cleared.", 2, "eraser")
		end,
	})

	local every = tbl3.Every

	local PetList = fn58("PetList", function()
		local v6 = fn54()
		local tbl29 = {}

		for k, v7 in pairs(v6) do
			if not tbl26.Blacklist[k] then
				tbl29[#tbl29 + 1] = fn59(k, v7)
			end
		end

		table.sort(tbl29)

		fn(function()
			v4:Refresh(tbl29)
		end)

		fn60()
	end)

	every(tbl3, "PetList", 3, PetList)

	sellBlacklist:Paragraph({
		Title = "Note",
		Content = "Blacklisted pets are never sold; favorited pets are protected too. Use Game Auto Sell for plain rarity rules, and the script's own Auto Sell when you need income or blacklist filtering.",
	})
end

do
	local Library = fn6("Library", "Weather", "Schedule")
	local Library2 = fn6("Library", "Types", "GuaranteedBrainrotSpawns")
	local v4 = fn7(tbl6.Predictor, "Weather"):Paragraph({ Title = "Upcoming Weather", Content = "--" })
	local v5 = fn7(tbl6.Predictor, "Pets"):Paragraph({ Title = "Guaranteed Spawns", Content = "--" })

	local function fn59(arg)
		local n = math.max(0, math.floor(arg))
		if n >= 3600 then
			return ("%dh %02dm"):format(n / 3600, n % 3600 / 60)
		end
		return ("%02dm %02ds"):format(n / 60, n % 60)
	end

	tbl3:Every("Predictor", 1, function()
		local now = os.time()

		if Library then
			fn(function()
				local tbl29 = {}
				local ok, result = pcall(Library.GetUpcomingWeathers, now, 6)

				if ok and type(result) == "table" then
					for i, v6 in ipairs(result) do
						local str2 = tostring(v6.WeatherId or "?"):gsub("Weather$", "")
						local str3 = ("%d. %s"):format(i, str2)

						if type(v6.StartsAt) == "number" then
							str3 ..= ("  in %s"):format(fn59(v6.StartsAt - now))
						end

						tbl29[#tbl29 + 1] = str3
					end
				end

				local value = select(2, pcall(Library.GetSecondsToNextRefresh, now))

				if type(value) == "number" then
					table.insert(tbl29, 1, ("Next cycle in %s"):format(fn59(value)))
				end

				v4:SetContent(#tbl29 > 0 and table.concat(tbl29, "\n") or "--")
			end)
		else
			v4:SetContent("Weather schedule module not available in this game.")
		end

		if Library2 then
			fn(function()
				local tbl29 = {}

				for _, v6 in ipairs({
					{ "Secret", Library2.SECRET_BRAINROT_INTERVAL, Library2.SECRET_BRAINROT_PHASE_OFFSET },
					{ "Cosmic", Library2.COSMIC_BRAINROT_INTERVAL, Library2.COSMIC_BRAINROT_PHASE_OFFSET },
					{ "Eternal", Library2.ETERNAL_BRAINROT_INTERVAL, Library2.ETERNAL_BRAINROT_PHASE_OFFSET },
				}) do
					local v7 = v6[1]
					local v8 = v6[2]
					local n = v6[3] or 0

					if type(v8) == "number" and v8 > 0 then
						local n2 = math.ceil((now - n) / v8) * v8 + n

						if n2 <= now then
							n2 += v8
						end

						tbl29[#tbl29 + 1] = ("%-8s every %dm  next in %s"):format(v7, v8 / 60, fn59(n2 - now))
					end
				end

				v5:SetContent(#tbl29 > 0 and table.concat(tbl29, "\n") or "--")
			end)
		else
			v5:SetContent("Spawn interval module not available in this game.")
		end
	end)
end

local discord = fn7(tbl6.Webhook, "Discord")

if not request_ then
	discord:Paragraph({
		Title = "Unavailable",
		Content = "Your executor exposes no HTTP request function, so webhooks are disabled.",
	})
else
	discord:Textbox({
		Name = "Discord Webhook URL",
		Tooltip = "Paste your Discord webhook URL here",
		Placeholder = "https://discord.com/api/webhooks/...",
		Finished = true,
		Flag = "SAEWebhookUrl",
		Callback = function(arg)
			local url = tostring(arg or ""):gsub("%s+", "")

			if url ~= "" and not url:match("^https://[%w%.]*discord%.?a?p?p?%.com/api/webhooks/%d+/[%w%-_]+$") then
				fn5("Webhook", "That does not look like a Discord webhook URL.", 4, "triangle-alert")
				tbl21.Url = ""
				return
			end

			tbl21.Url = url

			if url ~= "" then
				fn5("Webhook", "URL saved.", 2, "check")
			end
		end,
	})

	discord:Toggle({
		Name = "Webhook Egg Steal",
		Tooltip = "Send a Discord notification when an egg is stolen",
		Default = false,
		Flag = "SAEWebhookSteal",
		Callback = function(onSteal)
			tbl21.OnSteal = onSteal

			if onSteal and tbl21.Url == "" then
				fn5("Webhook", "Set a webhook URL first.", 3, "triangle-alert")
			end
		end,
	})

	local tbl29 = { "All" }

	for _, v4 in ipairs(tbl8) do
		tbl29[#tbl29 + 1] = v4.name
	end

	discord:Dropdown({
		Name = "Webhook Min Rarity",
		Tooltip = "Only send for eggs at or above this rarity",
		Items = tbl29,
		Default = "All",
		Callback = function(arg)
			if type(arg) == "table" then
				arg = arg[1]
			end

			for _, v4 in ipairs(tbl8) do
				if v4.name == arg then
					tbl21.MinRarity = v4.n
					return
				end
			end

			tbl21.MinRarity = 0
		end,
	})

	discord:Button({
		Name = "Test Webhook",
		Tooltip = "Send a test notification to verify the URL",
		Callback = function()
			if not fn39() then
				fn5("Webhook", "Set a valid webhook URL first.", 3, "triangle-alert")
				return
			end

			fn40({
				title = "Webhook Connected",
				description = "Citra | " .. str .. " is linked to this channel.",
				color = 5017343,
				footer = { text = localPlayer.Name .. " | " .. os.date("%X") },
			})

			fn5("Webhook", "Test sent. Check your channel.", 3, "send")
		end,
	})
end

tbl5.Settings:SubTab({ Name = "Config", Icon = "save" }):ThemeConfig({})

fn7(tbl6.Settings, "Unload"):Button({
	Name = "Unload " .. str,
	Tooltip = "Restores everything this script changed and closes the menu",
	Callback = function()
		tbl2:Destroy()

		pcall(function()
			lua:Unload()
		end)
	end,
})

fn5("Steal a Egg", "Loaded. Press RightShift to toggle.", 4, "check")
