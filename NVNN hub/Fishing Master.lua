if getgenv().NNVN_FishingMasterLoaded then
    warn("[NNVN Hub] Fishing Master v1.0 is already loaded")
    return
end
getgenv().NNVN_FishingMasterLoaded = true

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Events = ReplicatedStorage:FindFirstChild("Events")
local Data = ReplicatedStorage:FindFirstChild("Data")

local State = {
    AutoClickFish = false,
    AutoPullMinigame = false,
    AutoUseSkills = false,
    AutoCast = false,
    AutoEquipRod = false,
    AutoSell = false,
    AutoSellWhenFull = false,
    AutoBuyRod = false,
    AutoPerfect = false,
    AutoUnlockIsland = false,
    AutoClaimRewards = false,
    AutoSkillGacha = false,
    AutoAuraGacha = false,
    AutoCrate = false,
    WalkOnWater = false,
    ESPPlayers = false,
    ESPNPCs = false,
    ESPFish = false,
    ESPChests = false,
    ESPGuides = false,
    Streamer = false,
    Fly = false,
    Noclip = false,
    FullBright = false,
    InfiniteJump = false,
    Clicks = 0,
    Casts = 0,
    Skills = 0,
    Sells = 0,
    Codes = 0,
    RodBuys = 0,
    SelectedIsland = "Starter Island",
    SelectedChest = "Ocean Chest",
    SelectedFish = "All",
    SelectedRod = "wooden_rod",
    SelectedSkin = "None",
    SkillOrder = "Z,X,C,V",
    SavedPosition = nil,
    FakeName = "NNVN Hub",
    TweenSpeed = 300,
    TweenHeight = 5,
    CastHoldMin = 1,
    CastHoldMax = 2,
    ClickDelay = 0.18,
    PullDelay = 0.12,
    WalkSpeed = 16,
    JumpPower = 50,
    FlySpeed = 60,
    SelectedUnlockIsland = "Jungle Island",
    ESPDistance = 2500,
    GachaDelay = 3,
    AuraDelay = 3,
    CrateDelay = 3,
    StopCoin = 0,
    StopGem = 0,
    DiscordOnline = "Unknown",
    DiscordMembers = "Unknown",
}

local Status = {}
local Paragraphs = {}

local IslandPaths = {
    ["Starter Island"] = "island_starter",
    ["Jungle Island"] = "island_jungle",
    ["Desert Island"] = "island_desert",
    ["Snow Island"] = "island_snow",
    ["Volcano Island"] = "island_volcano",
    ["Fossil Island"] = "island_fossil",
}

local UnlockIslandIds = {
    ["Jungle Island"] = 2,
    ["Desert Island"] = 3,
    ["Snow Island"] = 4,
    ["Volcano Island"] = 5,
    ["Fossil Island"] = 6,
}

local Codes = { "BUMROBLOX", "KVT2K4", "TRUNGTHU2026" }
local CrateOptions = { "Ocean Chest", "Dragon Chest" }

local RodShopFallback = {
    wooden_rod = { price = 0, islandId = "island_starter" },
    stone_rod = { price = 3000, islandId = "island_starter" },
    iron_rod = { price = 12000, islandId = "island_starter" },
    golden_rod = { price = 35000, islandId = "island_jungle" },
    steel_rod = { price = 90000, islandId = "island_jungle" },
    golden_steel_rod = { price = 220000, islandId = "island_desert" },
    diamond_steel_rod = { price = 520000, islandId = "island_desert" },
    taoist_rod = { price = 1300000, islandId = "island_snow" },
    legacy_rod = { price = 3000000, islandId = "island_snow" },
}

local function trim(v)
    return (tostring(v or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function getChar()
    return LocalPlayer.Character
end

local function getRoot()
    local char = getChar()
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function getHumanoid()
    local char = getChar()
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function setStatus(key, text)
    Status[key] = tostring(text or "Idle")
    local p = Paragraphs[key]
    if p and p.SetDesc then p:SetDesc(Status[key]) end
end

local function notify(title, content)
    if getgenv().NNVN_WindUI and getgenv().NNVN_WindUI.Notify then
        pcall(function()
            getgenv().NNVN_WindUI:Notify({ Title = title, Content = content, Duration = 3 })
        end)
    end
end

local function refreshPremiumAccess()
    local premium = rawget(_G, "NNVN_IsPremium") == true
        or getgenv().NNVN_IsPremium == true
        or rawget(_G, "SCRIPT_IsPremium") == true
        or getgenv().SCRIPT_IsPremium == true
    getgenv().NNVN_IsPremiumAccess = premium
    State.IsPremium = premium
    return premium
end

local function premiumSourceText()
    if rawget(_G, "NNVN_IsPremium") == true then return "_G.NNVN_IsPremium" end
    if getgenv().NNVN_IsPremium == true then return "getgenv().NNVN_IsPremium" end
    if rawget(_G, "SCRIPT_IsPremium") == true then return "_G.SCRIPT_IsPremium" end
    if getgenv().SCRIPT_IsPremium == true then return "getgenv().SCRIPT_IsPremium" end
    return "Free key / no premium flag"
end

local function accessText()
    local premium = refreshPremiumAccess()
    return ("Tier: %s\nDetected by: %s"):format(premium and "PREMIUM" or "FREE", premiumSourceText())
end

local TweenPart = Instance.new("Part")
TweenPart.Name = "NNVN_FishingMasterTweenPart"
TweenPart.Size = Vector3.new(1, 1, 1)
TweenPart.Anchored = true
TweenPart.CanCollide = false
TweenPart.CanTouch = false
TweenPart.Transparency = 1
TweenPart.Parent = workspace

local TweenConn
local CurrentTween

local function stopTween()
    if CurrentTween then pcall(function() CurrentTween:Cancel() end) end
    CurrentTween = nil
    if TweenConn then pcall(function() TweenConn:Disconnect() end) end
    TweenConn = nil
    local root = getRoot()
    local clip = root and root:FindFirstChild("NNVN_BodyClip")
    if clip then clip:Destroy() end
end

local function tweenTo(cf, speed)
    local root = getRoot()
    if not root or typeof(cf) ~= "CFrame" then return false end
    speed = tonumber(speed) or State.TweenSpeed or 300
    local dist = (root.Position - cf.Position).Magnitude
    if dist < 8 then
        root.CFrame = cf
        return true
    end
    stopTween()
    TweenPart.CFrame = root.CFrame
    local clip = Instance.new("BodyVelocity")
    clip.Name = "NNVN_BodyClip"
    clip.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    clip.Velocity = Vector3.zero
    clip.Parent = root
    for _, part in ipairs(getChar():GetDescendants()) do
        if part:IsA("BasePart") then part.CanCollide = false end
    end
    CurrentTween = TweenService:Create(TweenPart, TweenInfo.new(math.clamp(dist / speed, 0.08, 40), Enum.EasingStyle.Linear), { CFrame = cf })
    TweenConn = RunService.Heartbeat:Connect(function()
        local r = getRoot()
        if r then
            r.CFrame = TweenPart.CFrame
            r.AssemblyLinearVelocity = Vector3.zero
            r.AssemblyAngularVelocity = Vector3.zero
        end
    end)
    CurrentTween:Play()
    pcall(function() CurrentTween.Completed:Wait() end)
    if root and root.Parent then root.CFrame = cf end
    stopTween()
    return true
end

local function findIslandCF(name)
    local id = IslandPaths[name] or name
    local islands = workspace:FindFirstChild("World") and workspace.World:FindFirstChild("Islands")
    local island = islands and islands:FindFirstChild(id)
    local spawner = island and island:FindFirstChild("SpawnPoint") and island.SpawnPoint:FindFirstChild("Spawner")
    if spawner and spawner:IsA("BasePart") then return spawner.CFrame + Vector3.new(0, State.TweenHeight, 0) end
    if spawner and spawner:IsA("Model") then return spawner:GetPivot() + Vector3.new(0, State.TweenHeight, 0) end
    return nil
end

local function getPlayerData()
    local data = ReplicatedStorage:FindFirstChild("Data")
    if not data then return nil end
    return data:FindFirstChild(tostring(LocalPlayer.UserId)) or data:FindFirstChild(LocalPlayer.Name)
end

local function readNumber(names)
    local pdata = getPlayerData()
    for _, root in ipairs({ pdata, LocalPlayer:FindFirstChild("leaderstats") }) do
        if root then
            for _, name in ipairs(names) do
                local v = root:FindFirstChild(name, true)
                if v and (v:IsA("NumberValue") or v:IsA("IntValue")) then return v.Value end
                if v and v:IsA("StringValue") then return tonumber(v.Value) end
            end
        end
    end
    return 0
end

local function parseAmount(text)
    text = tostring(text or ""):gsub(",", ""):gsub("%s+", "")
    local mult = 1
    if text:lower():find("k") then mult = 1000 end
    if text:lower():find("m") then mult = 1000000 end
    if text:lower():find("b") then mult = 1000000000 end
    return (tonumber(text:match("[%d%.]+")) or 0) * mult
end

local function guiCounter(path)
    local ok, value = pcall(function()
        local node = LocalPlayer.PlayerGui
        for part in tostring(path):gmatch("[^%.]+") do node = node:FindFirstChild(part) end
        return node and node.Text
    end)
    return ok and parseAmount(value) or 0
end

local function getCoin()
    local gui = guiCounter("HUD.Frame.Coin.Button.Frame.Counter")
    return gui > 0 and gui or readNumber({ "Coin", "Coins", "Cash", "Money" })
end

local function getGem()
    local gui = guiCounter("HUD.Frame.Gem.Button.Frame.Counter")
    return gui > 0 and gui or readNumber({ "Gem", "Gems" })
end

local function getCatalogList(pathName, fallback)
    local result, seen = {}, {}
    local function add(v)
        v = trim(v)
        if v ~= "" and not seen[v] then seen[v] = true; table.insert(result, v) end
    end
    pcall(function()
        local catalog = Data and Data:FindFirstChild("Catalog")
        local obj = catalog and catalog:FindFirstChild(pathName)
        if obj and obj:IsA("ModuleScript") then
            local data = require(obj)
            if type(data) == "table" then
                for k, v in pairs(data) do
                    if type(k) == "string" then add(k) end
                    if type(v) == "table" then add(v.id or v.name or v.Name) end
                end
            end
        elseif obj then
            for _, child in ipairs(obj:GetChildren()) do add(child.Name) end
        end
    end)
    for _, v in ipairs(fallback or {}) do add(v) end
    table.sort(result)
    return result
end

local function getRodShop()
    local data = RodShopFallback
    pcall(function()
        local mod = Data and Data:FindFirstChild("Config") and Data.Config:FindFirstChild("RodShopConfig")
        if mod and mod:IsA("ModuleScript") then
            local ok = require(mod)
            if type(ok) == "table" then data = ok end
        end
    end)
    return data
end

local function getRodOptions()
    local list = {}
    for id, cfg in pairs(getRodShop()) do
        table.insert(list, ("%s - $%s"):format(tostring(id), tostring(cfg.price or 0)))
    end
    table.sort(list)
    return list
end

local function selectedRodId()
    return tostring(State.SelectedRod or ""):match("^([^%s]+)") or State.SelectedRod
end

local function getRodPrice(rodId)
    local cfg = getRodShop()[rodId]
    return cfg and tonumber(cfg.price) or 0
end

local function getEvent(name)
    return Events and Events:FindFirstChild(name)
end

local function fireRemoteNames(names, ...)
    local args = table.pack(...)
    for _, name in ipairs(names) do
        local ev = getEvent(name) or ReplicatedStorage:FindFirstChild(name, true)
        if ev and ev:IsA("RemoteEvent") then pcall(function() ev:FireServer(table.unpack(args, 1, args.n)) end); return true end
        if ev and ev:IsA("RemoteFunction") then pcall(function() ev:InvokeServer(table.unpack(args, 1, args.n)) end); return true end
    end
    return false
end

local function firePacket(name, arg)
    local ok = false
    pcall(function()
        local Stardust = require(ReplicatedStorage:WaitForChild("Stardust"))
        local Packet = Stardust.Packet
        local packet
        if type(arg) == "string" then
            packet = Packet(name, Packet.String)
        elseif type(arg) == "boolean" then
            packet = Packet(name, Packet.Boolean or Packet.Boolean8)
        elseif type(arg) == "number" then
            local numberType = (arg % 1 == 0 and arg >= 0 and arg <= 255) and Packet.NumberU8 or (Packet.NumberF32 or Packet.Float32 or Packet.Number)
            packet = numberType and Packet(name, numberType) or Packet(name)
        else
            packet = Packet(name)
        end
        if packet and packet.Fire then
            if arg == nil then packet:Fire() else packet:Fire(arg) end
            ok = true
        end
    end)
    return ok
end

local function getController(name)
    local controllers = ReplicatedStorage:FindFirstChild("Controllers")
    local mod = controllers and controllers:FindFirstChild(name)
    if not mod then return nil end
    local ok, controller = pcall(require, mod)
    return ok and controller or nil
end

local function callMethods(obj, methods, ...)
    if type(obj) ~= "table" then return false end
    local args = table.pack(...)
    for _, method in ipairs(methods) do
        if type(obj[method]) == "function" then
            local ok = pcall(function()
                obj[method](obj, table.unpack(args, 1, args.n))
            end)
            if ok then return true end
        end
    end
    return false
end

local function equipRod()
    if fireRemoteNames({ "ToggleHotbar" }, "1", nil) then return true end
    for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tostring(tool.Name):lower():find("rod", 1, true) then
            tool.Parent = getChar()
            return true
        end
    end
    return false
end

local function hasRodEquipped()
    local char = getChar()
    if not char then return false end
    for _, child in ipairs(char:GetChildren()) do
        if child:IsA("Tool") and tostring(child.Name):lower():find("rod", 1, true) then return true end
    end
    return false
end

local function castRod()
    local root = getRoot()
    local minHold = math.max(1, tonumber(State.CastHoldMin) or 1)
    local maxHold = math.max(minHold, tonumber(State.CastHoldMax) or 2)
    local hold = math.random(math.floor(minHold * 10), math.floor(maxHold * 10)) / 10
    pcall(function()
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
    end)
    task.wait(hold)
    pcall(function()
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
    end)
    pcall(function()
        local controller = ReplicatedStorage:FindFirstChild("Controllers") and ReplicatedStorage.Controllers:FindFirstChild("FishingController")
        controller = controller and require(controller)
        for _, method in ipairs({ "Cast", "StartCast", "RequestCast", "Throw", "BeginCast" }) do
            if type(controller[method]) == "function" then
                controller[method](controller, root and root.CFrame)
                break
            end
        end
    end)
    if root then
        fireRemoteNames({ "Fishing" }, root.CFrame)
    else
        fireRemoteNames({ "Fishing" })
    end
    State.Casts += 1
    setStatus("farm", ("Auto Cast: %d casts | Auto Click: %d clicks | Skills: %d"):format(State.Casts, State.Clicks, State.Skills))
end

local function unlockIslandOnce(name)
    local islandNo = UnlockIslandIds[name]
    if not islandNo then return false end
    local dialogueName = "npc_unlock_island_" .. tostring(islandNo)
    local questName = "unlock_island_" .. tostring(islandNo)
    local accepted = false
    pcall(function()
        local qc = require(ReplicatedStorage.Controllers.QuestController)
        if qc and qc.Accept then accepted = qc:Accept(questName) == true end
    end)
    pcall(function()
        local dialogues = Data and Data:FindFirstChild("Dialogues")
        local mod = dialogues and dialogues:FindFirstChild(dialogueName)
        if mod and mod:IsA("ModuleScript") then require(mod) end
    end)
    fireRemoteNames({ "Dialogue", "DialogueAnswer", "NPCDialogue", "InteractNPC", "UnlockIsland" }, dialogueName, "Accept")
    fireRemoteNames({ "QuestAccept", "AcceptQuest", "UnlockIsland", "IslandUnlock", "PurchaseIsland" }, questName)
    setStatus("teleport", (accepted and "Quest accepted: " or "Unlock sent: ") .. tostring(name))
    return true
end

local function clickFish()
    State.Clicks += 1
    local fishing = getController("FishingController")
    local sent = callMethods(fishing, {
        "Click",
        "Tap",
        "Reel",
        "Pull",
        "DamageFish",
        "RequestClick",
        "RequestReel",
        "OnClick",
        "OnTap",
        "HandleClick",
        "HandleInput",
    }, true)
    sent = firePacket("Fishing/Click", true) or sent
    sent = firePacket("Fishing/Reel", true) or sent
    sent = firePacket("Fishing/Pull", true) or sent
    sent = firePacket("FishingClick", true) or sent
    sent = firePacket("ReelFish", true) or sent
    sent = firePacket("PullFish", true) or sent
    sent = fireRemoteNames({ "FishingClick", "FishingReel", "FishingPull", "ReelFish", "PullFish", "FishClick", "FishTap" }, true) or sent
    if State.AutoPerfect then
        callMethods(fishing, { "Perfect", "PerfectClick", "PerfectPull", "RequestPerfect" }, true)
        firePacket("Fishing/Perfect", true)
        firePacket("Fishing/PerfectClick", true)
        fireRemoteNames({ "FishingPerfect", "PerfectClick", "PerfectPull" }, true)
    end
    setStatus("farm", ("Auto Click: %d game-clicks | Casts: %d | Skills: %d | %s"):format(State.Clicks, State.Casts, State.Skills, sent and "sent" or "waiting for minigame"))
end

local function pullBarScore()
    local root = getRoot()
    local candidates = {}
    if root then table.insert(candidates, root) end
    table.insert(candidates, PlayerGui)
    for _, base in ipairs(candidates) do
        for _, gui in ipairs(base:GetDescendants()) do
            if gui.Name == "FirstPullBar" or gui.Name == "PullBar" or gui.Name == "ReelCounter" then
                local holder = gui:FindFirstChild("Holder", true) or gui
                local bar = holder and (holder:FindFirstChild("Bar", true) or holder:FindFirstChild("Fill", true))
                if bar and bar:IsA("GuiObject") then
                    return math.clamp(bar.Size.Y.Scale > 0 and bar.Size.Y.Scale or bar.Size.X.Scale, 0, 1)
                end
                return 1
            end
        end
    end
    return nil
end

local function pullMinigame()
    local score = pullBarScore()
    if not score then
        setStatus("farm", ("Auto Pull: waiting | Clicks: %d | Casts: %d"):format(State.Clicks, State.Casts))
        return
    end
    if score >= 0.72 or State.AutoPerfect then
        clickFish()
    else
        local fishing = getController("FishingController")
        callMethods(fishing, { "Pull", "Reel", "RequestPull", "RequestReel" }, score)
        firePacket("Fishing/Pull", score)
        firePacket("Fishing/Reel", score)
        fireRemoteNames({ "FishingPull", "FishingReel", "PullFish", "ReelFish" }, score)
        setStatus("farm", ("Auto Pull: %.0f%% | Clicks: %d | Casts: %d"):format(score * 100, State.Clicks, State.Casts))
    end
end

local function pressKey(keyCode)
    pcall(function()
        VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
        task.wait(0.04)
        VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
    end)
end

local function useSkillsOnce()
    local order = {}
    for token in tostring(State.SkillOrder or "Z,X,C,V"):gmatch("[ZXCVzxcv]") do table.insert(order, token:upper()) end
    if #order == 0 then order = { "Z", "X", "C", "V" } end
    for _, key in ipairs(order) do
        fireRemoteNames({ "UseSkill", "Skill", "UseRodSkill" }, key)
        pressKey(Enum.KeyCode[key])
        State.Skills += 1
        task.wait(0.15)
    end
    setStatus("farm", ("Skills used: %d | Clicks: %d | Casts: %d"):format(State.Skills, State.Clicks, State.Casts))
end

local function claimRewardsOnce()
    fireRemoteNames({ "ClaimDailyReward", "DailyReward", "ClaimReward", "ClaimAllRewards" })
    pcall(function()
        local controllers = ReplicatedStorage:FindFirstChild("Controllers")
        local daily = controllers and controllers:FindFirstChild("DailyRewardController")
        daily = daily and require(daily)
        for _, method in ipairs({ "Claim", "ClaimAll", "ClaimDaily", "Redeem" }) do
            if type(daily[method]) == "function" then daily[method](daily) end
        end
    end)
    pcall(function()
        local controllers = ReplicatedStorage:FindFirstChild("Controllers")
        local equip = controllers and controllers:FindFirstChild("EquipmentController")
        equip = equip and require(equip)
        for _, method in ipairs({ "Claim", "ClaimReward", "ClaimAll" }) do
            if type(equip[method]) == "function" then equip[method](equip) end
        end
    end)
    firePacket("ClaimDailyReward")
    firePacket("ClaimReward")
    setStatus("rewards", "Claim request sent")
end

local function rollGacha(kind)
    local coin, gem = getCoin(), getGem()
    if State.StopCoin > 0 and coin <= State.StopCoin then setStatus("shop", "Stopped: coin reserve reached") return end
    if State.StopGem > 0 and gem <= State.StopGem then setStatus("shop", "Stopped: gem reserve reached") return end
    local packetName = kind == "Aura" and "AuraGacha" or (kind == "Crate" and "OpenCrate" or "SkillGacha")
    local arg = kind == "Crate" and State.SelectedChest or "Once"
    firePacket(packetName, arg)
    fireRemoteNames({ packetName, "Gacha", "RollGacha", "OpenCrate", "AuraGacha", "SkillGacha" }, arg)
    setStatus("shop", ("%s roll sent | Coin %s | Gem %s"):format(kind, math.floor(coin), math.floor(gem)))
end

local function refreshDiscordStats()
    local req = (syn and syn.request) or (http and http.request) or http_request or request
    if not req then
        setStatus("discord", "Executor does not expose HTTP request")
        return
    end
    local ok, res = pcall(function()
        return req({
            Url = "https://discord.com/api/v9/invites/n4DbXTyNPj?with_counts=true&with_expiration=true",
            Method = "GET",
            Headers = { ["User-Agent"] = "NNVNHub" },
        })
    end)
    if not ok or not res or not res.Body then
        setStatus("discord", "Could not load Discord invite stats")
        return
    end
    local data
    pcall(function() data = HttpService:JSONDecode(res.Body) end)
    State.DiscordOnline = tostring(data and data.approximate_presence_count or "Unknown")
    State.DiscordMembers = tostring(data and data.approximate_member_count or "Unknown")
    setStatus("discord", ("Online members: %s\nAll members: %s\nInvite: discord.gg/n4DbXTyNPj"):format(State.DiscordOnline, State.DiscordMembers))
end

local function sellOnce()
    local fish = State.SelectedFish
    if not fish or fish == "" or fish == "All" then fish = "All" end
    fireRemoteNames({ "SellFish", "Sell", "SellItem" }, fish)
    State.Sells += 1
    setStatus("sell", ("Sold %s | Total sell attempts: %d"):format(tostring(fish), State.Sells))
end

local function buyRodOnce()
    local rod = selectedRodId()
    if rod == "" then return end
    firePacket("PurchaseRod", rod)
    fireRemoteNames({ "BuyFishingRod", "BuyRod", "PurchaseRod", "PurchaseFishingRod" }, rod)
    State.RodBuys += 1
    setStatus("buyrod", ("Buy sent: %s | Attempts: %d"):format(rod, State.RodBuys))
    setStatus("shop", ("Buy rod sent: %s | Attempts: %d"):format(rod, State.RodBuys))
end

local function autoBuyRodOnce()
    local rod = selectedRodId()
    local price = getRodPrice(rod)
    local money = getCoin()
    if money >= price then
        buyRodOnce()
    else
        local text = ("Not enough money: %s / %s"):format(tostring(math.floor(money)), tostring(price))
        setStatus("buyrod", text)
        setStatus("shop", text)
    end
end

local function backpackIsFull()
    local pdata = getPlayerData()
    local inv = pdata and (pdata:FindFirstChild("Inventory", true) or pdata:FindFirstChild("Backpack", true) or pdata:FindFirstChild("Fishes", true))
    local limit = pdata and pdata:FindFirstChild("InventoryLimit", true)
    if inv and limit and tonumber(limit.Value) then return #inv:GetChildren() >= tonumber(limit.Value) end
    return false
end

local function redeemAllCodes()
    local sent = 0
    for _, code in ipairs(Codes) do
        fireRemoteNames({ "RedeemCode", "RedeemCodes", "Code" }, code)
        sent += 1
        task.wait(0.2)
    end
    State.Codes += sent
    setStatus("misc", ("Redeemed attempts: %d"):format(State.Codes))
    notify("Redeem Codes", ("Sent %d code(s)"):format(sent))
end

local function getInfoText()
    return table.concat({
        "Name: " .. LocalPlayer.Name,
        "UserId: " .. LocalPlayer.UserId,
        "Cash: " .. tostring(readNumber({ "Cash", "Money", "Coin", "Coins" })),
        "Gems: " .. tostring(readNumber({ "Gem", "Gems" })),
        "Rod: " .. tostring((getPlayerData() and getPlayerData():FindFirstChild("FishingRod", true) and getPlayerData():FindFirstChild("FishingRod", true).Value) or "Unknown"),
        "PlaceId: " .. game.PlaceId,
    }, "\n")
end

local function applyStreamer()
    local fake = State.FakeName ~= "" and State.FakeName or "NNVN Hub"
    pcall(function()
        local nt = workspace:FindFirstChild("Nametags")
        local tag = nt and nt:FindFirstChild(LocalPlayer.Name)
        local label = tag and tag:FindFirstChild("PlrName", true) and tag.PlrName:FindFirstChild("Label", true)
        if label and label:IsA("TextLabel") then label.Text = State.Streamer and fake or LocalPlayer.Name end
    end)
    pcall(function()
        local hum = getHumanoid()
        if hum then hum.DisplayName = State.Streamer and fake or LocalPlayer.DisplayName end
    end)
    pcall(function()
        for _, label in ipairs(PlayerGui:GetDescendants()) do
            if label:IsA("TextLabel") or label:IsA("TextBox") then
                if label.Text and label.Text:find(LocalPlayer.Name, 1, true) then
                    label.Text = State.Streamer and label.Text:gsub(LocalPlayer.Name, fake) or label.Text
                end
            end
        end
    end)
end

local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "NNVN_FishingMaster_ESP"
ESPFolder.Parent = PlayerGui
local ESPObjects = {}

local function clearESP()
    for inst, data in pairs(ESPObjects) do
        if data.Billboard then pcall(function() data.Billboard:Destroy() end) end
        if data.Highlight then pcall(function() data.Highlight:Destroy() end) end
        ESPObjects[inst] = nil
    end
end

local function espPart(inst)
    if inst:IsA("BasePart") then return inst end
    if inst:IsA("Model") then return inst:FindFirstChild("HumanoidRootPart", true) or inst:FindFirstChild("Head", true) or inst:FindFirstChildWhichIsA("BasePart", true) end
    return inst:FindFirstChildWhichIsA("BasePart", true)
end

local function espAllowed(inst, kind)
    if kind == "Player" then return State.ESPPlayers end
    if kind == "NPC" then return State.ESPNPCs end
    if kind == "Fish" then return State.ESPFish end
    if kind == "Chest" then return State.ESPChests end
    if kind == "Guide" then return State.ESPGuides end
    return false
end

local function upsertESP(inst, kind, color)
    if not inst or not inst.Parent or not espAllowed(inst, kind) then return end
    local part = espPart(inst)
    local root = getRoot()
    if not part or not root then return end
    local dist = (root.Position - part.Position).Magnitude
    if dist > State.ESPDistance then return end
    local data = ESPObjects[inst]
    if not data then
        data = {}
        local h = Instance.new("Highlight")
        h.Name = "NNVN_ESP_Highlight"
        h.FillColor = color
        h.OutlineColor = Color3.fromRGB(255, 255, 255)
        h.FillTransparency = 0.82
        h.OutlineTransparency = 0.15
        h.Adornee = inst
        h.Parent = ESPFolder
        local bb = Instance.new("BillboardGui")
        bb.Name = "NNVN_ESP_Label"
        bb.AlwaysOnTop = true
        bb.Size = UDim2.fromOffset(180, 42)
        bb.StudsOffset = Vector3.new(0, 3, 0)
        bb.Adornee = part
        bb.Parent = ESPFolder
        local txt = Instance.new("TextLabel")
        txt.Name = "Text"
        txt.BackgroundTransparency = 1
        txt.Font = Enum.Font.GothamMedium
        txt.TextSize = 11
        txt.TextColor3 = Color3.fromRGB(245, 245, 245)
        txt.TextStrokeTransparency = 0.35
        txt.Size = UDim2.fromScale(1, 1)
        txt.Parent = bb
        data.Highlight = h
        data.Billboard = bb
        data.Text = txt
        ESPObjects[inst] = data
    end
    local hum = inst:IsA("Model") and inst:FindFirstChildOfClass("Humanoid")
    local hp = hum and ("\nHP " .. math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth)) or ""
    data.Billboard.Adornee = part
    data.Text.Text = ("%s | %s\n%d studs%s"):format(kind, tostring(inst.Name), math.floor(dist), hp)
end

local function scanESP()
    if not (State.ESPPlayers or State.ESPNPCs or State.ESPFish or State.ESPChests or State.ESPGuides) then
        clearESP()
        return
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then upsertESP(plr.Character, "Player", Color3.fromRGB(80, 170, 255)) end
    end
    for _, inst in ipairs(workspace:GetDescendants()) do
        local n = tostring(inst.Name):lower()
        if inst:IsA("Model") and n:find("npc", 1, true) then upsertESP(inst, "NPC", Color3.fromRGB(255, 210, 90)) end
        if inst:IsA("Model") and n:find("fish", 1, true) then upsertESP(inst, "Fish", Color3.fromRGB(90, 255, 200)) end
        if (inst:IsA("Model") or inst:IsA("BasePart")) and (n:find("chest", 1, true) or n:find("crate", 1, true)) then upsertESP(inst, "Chest", Color3.fromRGB(255, 170, 60)) end
        if (inst:IsA("Model") or inst:IsA("BasePart")) and (n:find("unlock", 1, true) or n:find("guide", 1, true)) then upsertESP(inst, "Guide", Color3.fromRGB(210, 120, 255)) end
    end
end

local function startInfoBar()
    if PlayerGui:FindFirstChild("NNVN_FishingMaster_InfoBar") then return end
    local gui = Instance.new("ScreenGui")
    gui.Name = "NNVN_FishingMaster_InfoBar"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.Parent = PlayerGui
    local frame = Instance.new("Frame")
    frame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
    frame.BorderColor3 = Color3.fromRGB(245, 245, 245)
    frame.BorderSizePixel = 1
    frame.Position = UDim2.fromOffset(8, 112)
    frame.Size = UDim2.fromOffset(380, 24)
    frame.Parent = gui
    frame.Active = true
    frame.Selectable = true
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Position = UDim2.fromOffset(8, 0)
    label.Size = UDim2.new(1, -12, 1, 0)
    label.Text = "Fishing Master v1.0 | Real | -- ms | -- FPS"
    label.Parent = frame
    local dragging, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    local frames, last = 0, os.clock()
    RunService.RenderStepped:Connect(function()
        frames += 1
        local now = os.clock()
        if now - last >= 1 then
            local fps = frames
            frames = 0
            last = now
            local ping = "-- ms"
            pcall(function() ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValueString() end)
            label.Text = ("Fishing Master v1.0 | Real | %s | %d FPS"):format(tostring(ping), fps)
        end
    end)
end

local function startLoops()
    task.spawn(function()
        while task.wait(State.ClickDelay or 0.18) do
            if State.AutoClickFish then clickFish() end
        end
    end)
    task.spawn(function()
        while task.wait(State.PullDelay or 0.12) do
            if State.AutoPullMinigame then pullMinigame() end
        end
    end)
    task.spawn(function()
        while task.wait(1.2) do
            if State.AutoUseSkills then useSkillsOnce() end
        end
    end)
    task.spawn(function()
        while task.wait(math.random(10, 18) / 10) do
            if State.AutoCast then
                if State.AutoEquipRod and not hasRodEquipped() then equipRod() end
                task.wait(math.random(10, 18) / 10)
                castRod()
            end
        end
    end)
    task.spawn(function()
        while task.wait(1) do
            if State.AutoEquipRod and not hasRodEquipped() then equipRod() end
        end
    end)
    task.spawn(function()
        while task.wait(5) do
            if State.AutoSell then sellOnce() end
            if State.AutoSellWhenFull and backpackIsFull() then sellOnce() end
        end
    end)
    task.spawn(function()
        while task.wait(3) do
            if State.AutoBuyRod then autoBuyRodOnce() end
        end
    end)
    task.spawn(function()
        while task.wait(2.5) do
            if State.AutoUnlockIsland then unlockIslandOnce(State.SelectedUnlockIsland) end
        end
    end)
    task.spawn(function()
        while task.wait(5) do
            if State.AutoClaimRewards then claimRewardsOnce() end
        end
    end)
    task.spawn(function()
        while task.wait(State.GachaDelay) do if State.AutoSkillGacha then rollGacha("Skill") end end
    end)
    task.spawn(function()
        while task.wait(State.AuraDelay) do if State.AutoAuraGacha then rollGacha("Aura") end end
    end)
    task.spawn(function()
        while task.wait(State.CrateDelay) do if State.AutoCrate then rollGacha("Crate") end end
    end)
    task.spawn(function()
        while task.wait(0.75) do
            pcall(scanESP)
        end
    end)
    RunService.RenderStepped:Connect(function()
        local hum = getHumanoid()
        if hum then
            hum.WalkSpeed = State.WalkSpeed
            hum.JumpPower = State.JumpPower
        end
        if State.Noclip and getChar() then
            for _, part in ipairs(getChar():GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
        if State.FullBright then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
        end
        if State.WalkOnWater then
            local root = getRoot()
            if root then
                local p = workspace:FindFirstChild("NNVN_WalkOnWater") or Instance.new("Part")
                p.Name = "NNVN_WalkOnWater"; p.Anchored = true; p.CanCollide = true; p.Size = Vector3.new(9, 1, 9); p.Transparency = 0.35
                p.CFrame = CFrame.new(root.Position.X, root.Position.Y - 3.2, root.Position.Z)
                p.Parent = workspace
            end
        end
        applyStreamer()
    end)
end

UserInputService.JumpRequest:Connect(function()
    if State.InfiniteJump then
        local hum = getHumanoid()
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

local flyBV, flyBG
local function setFly(on)
    State.Fly = on
    local root = getRoot()
    if not root then return end
    if not on then
        if flyBV then flyBV:Destroy(); flyBV = nil end
        if flyBG then flyBG:Destroy(); flyBG = nil end
        return
    end
    flyBV = flyBV or Instance.new("BodyVelocity")
    flyBV.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    flyBV.Parent = root
    flyBG = flyBG or Instance.new("BodyGyro")
    flyBG.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    flyBG.Parent = root
    task.spawn(function()
        while State.Fly and flyBV and flyBG do
            local cam = workspace.CurrentCamera
            local move = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.yAxis end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.yAxis end
            flyBV.Velocity = move.Magnitude > 0 and move.Unit * State.FlySpeed or Vector3.zero
            flyBG.CFrame = cam.CFrame
            task.wait()
        end
    end)
end

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
getgenv().NNVN_WindUI = WindUI

local Window = WindUI:CreateWindow({
    Title = "NNVN Hub | Fishing Master v1.0",
    Icon = "fish",
    Author = "By n0namevnnek",
    Folder = "NNVN_FishingMaster",
    Size = UDim2.fromOffset(650, 430),
    MinSize = Vector2.new(450, 250),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    User = { Enabled = true, Anonymous = true },
})

pcall(function()
    Window:EditOpenButton({
        Title = "Open Menu",
        Icon = "fish",
        CornerRadius = UDim.new(0, 10),
        StrokeThickness = 1.5,
        Color = ColorSequence.new(Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 255, 255)),
        OnlyMobile = false,
        Enabled = true,
        Draggable = true,
    })
end)

pcall(function()
    local premium = refreshPremiumAccess()
    Window:Tag({
        Title = premium and "PREMIUM" or "FREE",
        Icon = premium and "crown" or "shield-check",
        Color = premium and Color3.fromHex("#EAB308") or Color3.fromHex("#000000"),
        Radius = 5,
    })
end)

local FarmTab = Window:Tab({ Title = "Farm", Icon = "fish" })
local PlayerTab = Window:Tab({ Title = "Player", Icon = "user" })
local ShopTab = Window:Tab({ Title = "Shop / Crate", Icon = "shopping-bag" })
local MiscTab = Window:Tab({ Title = "Misc", Icon = "wrench" })
local InfoTab = Window:Tab({ Title = "Info", Icon = "info" })

local function patchContainer(c)
    if not c then return c end
    if c.AddParagraph and not c.Paragraph then
        function c:Paragraph(opts) return self:AddParagraph(opts) end
    end
    if c.AddButton and not c.Button then
        function c:Button(opts) return self:AddButton(opts) end
    end
    if c.AddToggle and not c.Toggle then
        function c:Toggle(opts) return self:AddToggle(opts.Title or opts.Name or "Toggle", opts) end
    end
    if c.AddDropdown and not c.Dropdown then
        function c:Dropdown(opts) return self:AddDropdown(opts.Title or opts.Name or "Dropdown", opts) end
    end
    if c.AddSlider and not c.Slider then
        function c:Slider(opts) return self:AddSlider(opts.Title or opts.Name or "Slider", opts) end
    end
    if c.AddInput and not c.Input then
        function c:Input(opts) return self:AddInput(opts.Title or opts.Name or "Input", opts) end
    end
    return c
end

local function section(tab, opts)
    opts = opts or {}
    opts.Open = true
    opts.Opened = true
    opts.DefaultOpen = true
    opts.Collapsed = false
    if tab.Section then return patchContainer(tab:Section(opts)) end
    if tab.AddSection then return patchContainer(tab:AddSection(opts)) end
    return patchContainer(tab)
end

local FarmSec = section(FarmTab, { Title = "Fishing", Icon = "waves" })
Paragraphs.farm = FarmSec:Paragraph({ Title = "Status", Desc = "Idle" })
FarmSec:Toggle({ Title = "Auto Click Fish", Icon = "mouse-pointer-click", Default = false, Callback = function(v) State.AutoClickFish = v; setStatus("farm", v and "Auto click enabled" or "Idle") end })
FarmSec:Toggle({ Title = "Auto Pull Minigame", Icon = "circle-dot", Default = false, Callback = function(v) State.AutoPullMinigame = v; setStatus("farm", v and "Auto pull minigame enabled" or "Idle") end })
FarmSec:Toggle({ Title = "Auto Cast Fish", Icon = "send", Default = false, Callback = function(v) State.AutoCast = v; setStatus("farm", v and "Auto cast enabled" or "Idle") end })
FarmSec:Toggle({ Title = "Auto Equip Rod", Icon = "hand", Default = false, Callback = function(v) State.AutoEquipRod = v; setStatus("farm", v and "Auto equip enabled" or "Idle") end })
FarmSec:Toggle({ Title = "Auto Use Skills Z/X/C/V", Icon = "zap", Default = false, Callback = function(v) State.AutoUseSkills = v; setStatus("farm", v and "Auto skills enabled" or "Idle") end })
FarmSec:Toggle({ Title = "Auto Perfect", Icon = "target", Default = false, Callback = function(v) State.AutoPerfect = v; setStatus("farm", v and "Auto perfect enabled" or "Idle") end })
FarmSec:Button({ Title = "Use Skills Once", Icon = "play", Callback = useSkillsOnce })

local FarmSettingsSec = section(FarmTab, { Title = "Farm Settings", Icon = "sliders-horizontal" })
FarmSettingsSec:Input({ Title = "Skill Order", Icon = "list-ordered", Value = State.SkillOrder, Callback = function(v) State.SkillOrder = tostring(v or "Z,X,C,V") end })
FarmSettingsSec:Slider({ Title = "Tween Height", Icon = "arrow-up", Value = { Min = 0, Max = 60, Default = State.TweenHeight }, Callback = function(v) State.TweenHeight = tonumber(v) or 5 end })
FarmSettingsSec:Slider({ Title = "Tween Speed", Icon = "gauge", Value = { Min = 80, Max = 1200, Default = State.TweenSpeed }, Callback = function(v) State.TweenSpeed = tonumber(v) or 300 end })
FarmSettingsSec:Slider({ Title = "Auto Click Delay (ms)", Icon = "timer", Value = { Min = 40, Max = 1000, Default = 180 }, Callback = function(v) State.ClickDelay = math.max(0.04, (tonumber(v) or 180) / 1000) end })
FarmSettingsSec:Slider({ Title = "Auto Pull Delay (ms)", Icon = "timer-reset", Value = { Min = 40, Max = 1000, Default = 120 }, Callback = function(v) State.PullDelay = math.max(0.04, (tonumber(v) or 120) / 1000) end })
FarmSettingsSec:Slider({ Title = "Cast Hold Min", Icon = "timer", Value = { Min = 1, Max = 5, Default = State.CastHoldMin }, Callback = function(v) State.CastHoldMin = tonumber(v) or 1 end })
FarmSettingsSec:Slider({ Title = "Cast Hold Max", Icon = "timer-reset", Value = { Min = 1, Max = 8, Default = State.CastHoldMax }, Callback = function(v) State.CastHoldMax = tonumber(v) or 2 end })

local TeleportSec = section(PlayerTab, { Title = "Teleport Island", Icon = "map-pin" })
TeleportSec:Dropdown({ Title = "Island", Icon = "map", Values = { "Starter Island", "Jungle Island", "Desert Island", "Snow Island", "Volcano Island", "Fossil Island" }, Default = State.SelectedIsland, Search = true, Callback = function(v) if type(v) == "table" then v = v.Value or v[1] end; State.SelectedIsland = tostring(v or State.SelectedIsland) end })
TeleportSec:Slider({ Title = "Tween Speed", Icon = "gauge", Value = { Min = 80, Max = 900, Default = State.TweenSpeed }, Callback = function(v) State.TweenSpeed = tonumber(v) or 300 end })
TeleportSec:Button({ Title = "Teleport (Tween)", Icon = "send", Callback = function() local cf = findIslandCF(State.SelectedIsland); if cf then tweenTo(cf, State.TweenSpeed) end end })
TeleportSec:Button({ Title = "Teleport To Recommended Island", Icon = "sparkles", Callback = function() local cf = findIslandCF("Fossil Island"); if cf then tweenTo(cf, State.TweenSpeed) end end })

local UnlockSec = section(PlayerTab, { Title = "Auto Unlock Island", Icon = "unlock" })
Paragraphs.teleport = UnlockSec:Paragraph({ Title = "Status", Desc = "Idle" })
UnlockSec:Dropdown({ Title = "Island To Unlock", Icon = "map", Values = { "Jungle Island", "Desert Island", "Snow Island", "Volcano Island", "Fossil Island" }, Default = State.SelectedUnlockIsland, Search = true, Callback = function(v) if type(v) == "table" then v = v.Value or v[1] end; State.SelectedUnlockIsland = tostring(v or State.SelectedUnlockIsland) end })
UnlockSec:Toggle({ Title = "Auto Unlock Selected Island", Icon = "repeat", Default = false, Callback = function(v) State.AutoUnlockIsland = v; setStatus("teleport", v and "Auto unlock enabled" or "Idle") end })
UnlockSec:Button({ Title = "Unlock Once", Icon = "check", Callback = function() unlockIslandOnce(State.SelectedUnlockIsland) end })

local PlayerSec = section(PlayerTab, { Title = "Movement", Icon = "person-standing" })
PlayerSec:Toggle({ Title = "Fly", Icon = "plane", Default = false, Callback = setFly })
PlayerSec:Slider({ Title = "Fly Speed", Icon = "gauge", Value = { Min = 10, Max = 250, Default = State.FlySpeed }, Callback = function(v) State.FlySpeed = tonumber(v) or 60 end })
PlayerSec:Slider({ Title = "WalkSpeed", Icon = "footprints", Value = { Min = 16, Max = 200, Default = State.WalkSpeed }, Callback = function(v) State.WalkSpeed = tonumber(v) or 16 end })
PlayerSec:Slider({ Title = "JumpPower", Icon = "arrow-up", Value = { Min = 50, Max = 250, Default = State.JumpPower }, Callback = function(v) State.JumpPower = tonumber(v) or 50 end })
PlayerSec:Toggle({ Title = "Noclip", Icon = "ghost", Default = false, Callback = function(v) State.Noclip = v end })
PlayerSec:Toggle({ Title = "Infinite Jump", Icon = "chevrons-up", Default = false, Callback = function(v) State.InfiniteJump = v end })
PlayerSec:Toggle({ Title = "FullBright", Icon = "sun", Default = false, Callback = function(v) State.FullBright = v end })
PlayerSec:Toggle({ Title = "Walk In Water", Icon = "waves", Default = false, Callback = function(v) State.WalkOnWater = v end })

local SavePosSec = section(PlayerTab, { Title = "Saved Position", Icon = "bookmark" })
Paragraphs.savedpos = SavePosSec:Paragraph({ Title = "Status", Desc = "No saved position" })
SavePosSec:Button({ Title = "Save Current Position", Icon = "save", Callback = function()
    local root = getRoot()
    if root then
        State.SavedPosition = root.CFrame
        setStatus("savedpos", ("Saved: %.1f, %.1f, %.1f"):format(root.Position.X, root.Position.Y, root.Position.Z))
    end
end })
SavePosSec:Button({ Title = "Return To Saved Position", Icon = "rotate-ccw", Callback = function()
    if State.SavedPosition then
        tweenTo(State.SavedPosition, State.TweenSpeed)
        setStatus("savedpos", "Returned to saved position")
    else
        setStatus("savedpos", "No saved position")
    end
end })

local ESPSec = section(PlayerTab, { Title = "ESP", Icon = "eye" })
ESPSec:Slider({ Title = "ESP Distance", Icon = "ruler", Value = { Min = 200, Max = 10000, Default = State.ESPDistance }, Callback = function(v) State.ESPDistance = tonumber(v) or 2500 end })
ESPSec:Toggle({ Title = "Player ESP", Icon = "users", Default = false, Callback = function(v) State.ESPPlayers = v end })
ESPSec:Toggle({ Title = "NPC ESP", Icon = "bot", Default = false, Callback = function(v) State.ESPNPCs = v end })
ESPSec:Toggle({ Title = "Fish ESP", Icon = "fish", Default = false, Callback = function(v) State.ESPFish = v end })
ESPSec:Toggle({ Title = "Chest ESP", Icon = "archive", Default = false, Callback = function(v) State.ESPChests = v end })
ESPSec:Toggle({ Title = "Island Guide ESP", Icon = "map-pin", Default = false, Callback = function(v) State.ESPGuides = v end })
ESPSec:Button({ Title = "Clear ESP", Icon = "trash-2", Callback = clearESP })

local ChestSec = section(PlayerTab, { Title = "Chest", Icon = "archive" })
ChestSec:Dropdown({ Title = "Chest", Icon = "box", Values = { "Ocean Chest", "Dragon Chest" }, Default = "Ocean Chest", Callback = function(v) if type(v) == "table" then v = v.Value or v[1] end; State.SelectedChest = tostring(v or "Ocean Chest") end })
ChestSec:Button({ Title = "Open Selected Chest", Icon = "unlock", Callback = function() fireRemoteNames({ "OpenChest", "Chest", "ClaimChest" }, State.SelectedChest) end })

local SellSec = section(PlayerTab, { Title = "Auto Sell", Icon = "coins" })
Paragraphs.sell = SellSec:Paragraph({ Title = "Status", Desc = "Idle" })
local fishValues = getCatalogList("Fish", { "All" })
table.insert(fishValues, 1, "All")
SellSec:Dropdown({ Title = "Sell Select Fish", Icon = "fish", Values = fishValues, Default = "All", Search = true, Callback = function(v) if type(v) == "table" then v = v.Value or v[1] end; State.SelectedFish = tostring(v or "All") end })
SellSec:Toggle({ Title = "Auto Sell", Icon = "repeat", Default = false, Callback = function(v) State.AutoSell = v; setStatus("sell", v and "Auto sell enabled" or "Idle") end })
SellSec:Toggle({ Title = "Auto Sell When Backpack Full", Icon = "backpack", Default = false, Callback = function(v) State.AutoSellWhenFull = v; setStatus("sell", v and "Auto sell when full enabled" or "Idle") end })
SellSec:Button({ Title = "Sell Once", Icon = "circle-dollar-sign", Callback = sellOnce })

local RodSec = section(PlayerTab, { Title = "Buy Rod", Icon = "shopping-cart" })
Paragraphs.buyrod = RodSec:Paragraph({ Title = "Status", Desc = "Idle" })
RodSec:Dropdown({ Title = "Rod", Icon = "list", Values = getRodOptions(), Default = getRodOptions()[1], Search = true, Callback = function(v) if type(v) == "table" then v = v.Value or v[1] end; State.SelectedRod = tostring(v or "wooden_rod") end })
RodSec:Toggle({ Title = "Auto Buy When Enough Money", Icon = "repeat", Default = false, Callback = function(v) State.AutoBuyRod = v; setStatus("buyrod", v and "Auto buy enabled" or "Idle") end })
RodSec:Button({ Title = "Buy Once", Icon = "shopping-bag", Callback = buyRodOnce })

local SkinSec = section(PlayerTab, { Title = "Mod Skin", Icon = "palette" })
SkinSec:Dropdown({ Title = "Rod Skin", Icon = "paintbrush", Values = getCatalogList("RodSkin", { "None" }), Default = "None", Search = true, Callback = function(v) if type(v) == "table" then v = v.Value or v[1] end; State.SelectedSkin = tostring(v or "None") end })
SkinSec:Button({ Title = "Apply Skin", Icon = "check", Callback = function() fireRemoteNames({ "EquipRodSkin", "RodSkin", "EquipSkin" }, State.SelectedSkin) end })

local StreamerSec = section(PlayerTab, { Title = "Streamer Mode", Icon = "eye-off" })
StreamerSec:Toggle({ Title = "Streamer Mode", Icon = "eye-off", Default = false, Callback = function(v) State.Streamer = v; applyStreamer() end })
StreamerSec:Input({ Title = "Custom Name", Icon = "text-cursor-input", Value = State.FakeName, Callback = function(v) State.FakeName = tostring(v or "NNVN Hub"); applyStreamer() end })

local RewardsSec = section(PlayerTab, { Title = "Rewards", Icon = "gift" })
Paragraphs.rewards = RewardsSec:Paragraph({ Title = "Status", Desc = "Idle" })
RewardsSec:Toggle({ Title = "Auto Claim Rewards", Icon = "repeat", Default = false, Callback = function(v) State.AutoClaimRewards = v; setStatus("rewards", v and "Auto claim enabled" or "Idle") end })
RewardsSec:Button({ Title = "Claim Rewards Once", Icon = "gift", Callback = claimRewardsOnce })

local ShopStatusSec = section(ShopTab, { Title = "Status", Icon = "activity" })
Paragraphs.shop = ShopStatusSec:Paragraph({ Title = "Shop / Crate", Desc = "Idle" })
ShopStatusSec:Slider({ Title = "Gacha Delay", Icon = "timer", Value = { Min = 1, Max = 30, Default = State.GachaDelay }, Callback = function(v) State.GachaDelay = tonumber(v) or 3 end })
ShopStatusSec:Slider({ Title = "Keep Coin Reserve", Icon = "coins", Value = { Min = 0, Max = 10000000, Default = 0 }, Callback = function(v) State.StopCoin = tonumber(v) or 0 end })
ShopStatusSec:Slider({ Title = "Keep Gem Reserve", Icon = "gem", Value = { Min = 0, Max = 100000, Default = 0 }, Callback = function(v) State.StopGem = tonumber(v) or 0 end })
ShopStatusSec:Input({ Title = "Coin Reserve Input", Icon = "coins", Value = "0", Callback = function(v) State.StopCoin = tonumber(tostring(v or "0"):gsub(",", "")) or State.StopCoin end })
ShopStatusSec:Input({ Title = "Gem Reserve Input", Icon = "gem", Value = "0", Callback = function(v) State.StopGem = tonumber(tostring(v or "0"):gsub(",", "")) or State.StopGem end })

local ShopRodSec = section(ShopTab, { Title = "Buy Rod", Icon = "shopping-cart" })
ShopRodSec:Dropdown({ Title = "Rod", Icon = "list", Values = getRodOptions(), Default = getRodOptions()[1], Search = true, Callback = function(v) if type(v) == "table" then v = v.Value or v[1] end; State.SelectedRod = tostring(v or "wooden_rod") end })
ShopRodSec:Toggle({ Title = "Auto Buy When Enough Money", Icon = "repeat", Default = false, Callback = function(v) State.AutoBuyRod = v; setStatus("shop", v and "Auto buy rod enabled" or "Idle") end })
ShopRodSec:Button({ Title = "Buy Rod Once", Icon = "shopping-bag", Callback = buyRodOnce })

local SkillGachaSec = section(ShopTab, { Title = "Skill Gacha", Icon = "sparkles" })
SkillGachaSec:Button({ Title = "Roll Skill Once", Icon = "dice-5", Callback = function() rollGacha("Skill") end })
SkillGachaSec:Toggle({ Title = "Auto Skill Gacha", Icon = "repeat", Default = false, Callback = function(v) State.AutoSkillGacha = v; setStatus("shop", v and "Auto skill gacha enabled" or "Idle") end })

local AuraGachaSec = section(ShopTab, { Title = "Auras Gacha", Icon = "sparkle" })
AuraGachaSec:Slider({ Title = "Aura Delay", Icon = "timer", Value = { Min = 1, Max = 30, Default = State.AuraDelay }, Callback = function(v) State.AuraDelay = tonumber(v) or 3 end })
AuraGachaSec:Button({ Title = "Roll Aura Once", Icon = "dice-6", Callback = function() rollGacha("Aura") end })
AuraGachaSec:Toggle({ Title = "Auto Roll Aura", Icon = "repeat", Default = false, Callback = function(v) State.AutoAuraGacha = v; setStatus("shop", v and "Auto aura gacha enabled" or "Idle") end })

local CrateSec = section(ShopTab, { Title = "Crate", Icon = "package" })
CrateSec:Dropdown({ Title = "Crate", Icon = "box", Values = CrateOptions, Default = State.SelectedChest, Search = true, Callback = function(v) if type(v) == "table" then v = v.Value or v[1] end; State.SelectedChest = tostring(v or "Ocean Chest") end })
CrateSec:Slider({ Title = "Crate Delay", Icon = "timer", Value = { Min = 1, Max = 30, Default = State.CrateDelay }, Callback = function(v) State.CrateDelay = tonumber(v) or 3 end })
CrateSec:Button({ Title = "Open Crate Once", Icon = "package-open", Callback = function() rollGacha("Crate") end })
CrateSec:Toggle({ Title = "Auto Open Crate", Icon = "repeat", Default = false, Callback = function(v) State.AutoCrate = v; setStatus("shop", v and "Auto crate enabled" or "Idle") end })

local MiscSec = section(MiscTab, { Title = "Codes", Icon = "ticket" })
Paragraphs.misc = MiscSec:Paragraph({ Title = "Status", Desc = "Idle" })
MiscSec:Button({ Title = "Redeem All Codes", Icon = "gift", Callback = redeemAllCodes })

local InfoSec = section(InfoTab, { Title = "NNVN Hub", Icon = "info" })
Paragraphs.access = InfoSec:Paragraph({ Title = "Access Tag", Desc = accessText() })
InfoSec:Paragraph({ Title = "Author", Desc = "By n0namevnnek" })
InfoSec:Paragraph({ Title = "Player Info", Desc = getInfoText() })
Paragraphs.discord = InfoSec:Paragraph({ Title = "Discord", Desc = "Online members: Unknown\nAll members: Unknown\nInvite: discord.gg/n4DbXTyNPj" })
InfoSec:Button({ Title = "Refresh Player Info", Icon = "refresh-cw", Callback = function() notify("Info", getInfoText()) end })
InfoSec:Button({ Title = "Refresh Access Tag", Icon = "shield-check", Callback = function()
    setStatus("access", accessText())
    notify("Access", refreshPremiumAccess() and "PREMIUM detected" or "FREE detected")
end })
InfoSec:Button({ Title = "Refresh Discord Members", Icon = "users", Callback = refreshDiscordStats })

startInfoBar()
startLoops()
task.spawn(refreshDiscordStats)
task.spawn(function()
    while task.wait(5) do
        if Paragraphs.access then setStatus("access", accessText()) end
    end
end)
pcall(function() Window:SelectTab(1) end)
notify("NNVN Hub", "Fishing Master v1.0 loaded")
