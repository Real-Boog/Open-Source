-- this is for BloxStrike

local lighting = game:GetService("Lighting")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local userInputService = game:GetService("UserInputService")
local httpService = game:GetService("HttpService")
local runService = game:GetService("RunService")
local workspaceService = game:GetService("Workspace")
local coreGui = game:GetService("CoreGui")
local virtualInputManager = game:GetService("VirtualInputManager")
local tweenService = game:GetService("TweenService")
local localPlayer = players.LocalPlayer

task.spawn(function()
  while task.wait(0.1) do
    if not _G.NT_ProtectName then
    else
      local name = localPlayer.Name
      local displayName = localPlayer.DisplayName
      local v1 = {}
      local playerGui = localPlayer:FindFirstChild("PlayerGui")

      if playerGui then
        table.insert(v1, playerGui)
      end

      for index, value in ipairs(v1) do
        local v2 = value

        pcall(function()
          for index2, value2 in ipairs(v2:GetDescendants()) do
            if value2:IsA("TextLabel") or value2:IsA("TextButton") or value2:IsA("TextBox") then
              local text = value2.Text

              if type(text) == "string"
                and (text:find(name, 1, true) or text:find(displayName, 1, true)) then
                local gsub = text

                if name ~= "" then
                  gsub = gsub:gsub(name, "NeverTive")
                end

                if displayName ~= "" then
                  gsub = gsub:gsub(displayName, "NeverTive")
                end

                if gsub ~= text then
                  value2.Text = gsub
                end
              end
            end
          end
        end)
      end
    end
  end
end)

_G.NT_ProtectName = false
local gistfile1 = loadstring(game:HttpGet("https://gist.githubusercontent.com/RovlixTinProject/a076ba70f58bd8ac21b94e7f68fa0dc3/raw/9a21a85ce7f2e55be86b1fe9b1af011dfe5cfd0b/gistfile1.txt"))()
local notification = gistfile1:CreateNotification()
local logger = gistfile1:CreateLogger()
gistfile1:CreateIndicator()

local nevertiveWindow = gistfile1:CreateWindow({
  Logo = gistfile1.GlobalLogo,
  Name = "Nevertive",
  Content = "Project Erestive • 1.4",
  Size = gistfile1.Scales.Default,
  ConfigFolder = "NevertiveConfigs",
  Enable3DRenderer = false,
  Keybind = "Insert",
})

local function f1(p1, p2)
  local v3 = p2 or {}
  local watermark = p1:Watermark()
  local v4 = {}
  local v5 = {}

  for key, value3 in pairs({
    cheatname = true,
    fps = false,
    ping = false,
    time = false,
    players = false,
    health = false,
    armor = false,
    weapon = false,
    ammo = false,
    kd = false,
    kills = false,
    deaths = false,
    coords = false,
    speed = false,
    direction = false,
    uptime = false,
    roundTime = false,
    map = false,
    mode = false,
    scoreCT = false,
    scoreT = false,
    bomb = false,
    spectators = false,
    username = false,
    version = false,
    status = false,
    serverId = false,
  }) do
    if v3[key] == nil then
      v3[key] = value3
    end
  end

  local function f2(p3, p4, p5)
    v4[p3] = watermark:AddBlock(p4, p5 or p3)
    return v4[p3]
  end

  local function f3(p6, p7)
    if v4[p6] then
      v4[p6]:SetText(p7)
    end
  end

  local function f4(p8, p9, p10)
    v5[p8] = task.spawn(function()
      while v4[p8] do
        task.wait(p9)
      end
    end)
  end

  if v3.cheatname then
    f2("cheatname", "N", "everTive")
  end

  if v3.fps then
    f2("fps", "chart-line", "FPS: 60")

    task.spawn(function()
      local v6 = tick()
      local v7 = 0
      local v8 = v6

      runService.RenderStepped:Connect(function()
        if not v4.fps then
          return
        else
          v7 = v7 + 1
          local v9 = tick()

          if v9 - v8 >= 0.5 then
            f3("fps", "FPS: " .. math.floor(v7 / (v9 - v8) + 0.5))
            v7 = 0
            v8 = v9
          end

          return
        end
      end)
    end)
  end

  if v3.ping then
    f2("ping", "arrow-spin-clockwise", "Ping: 0")

    f4("ping", 1, function()
      local getNetworkPing = localPlayer:GetNetworkPing()
      f3("ping", "Ping: " .. math.floor(getNetworkPing * 1000 + 0.5) .. "ms")
    end)
  end

  if v3.time then
    f2("time", "clock", "00:00:00")

    f4("time", 0.5, function()
      local v10 = os.date("*t", os.time())
      f3("time", string.format("%02d:%02d:%02d", v10.hour, v10.min, v10.sec))
    end)
  end

  if v3.players then
    f2("players", "person", "0/0")

    f4("players", 1, function()
      local v11 = #players:GetPlayers()
      local count = 0
      local characters = workspace:FindFirstChild("Characters")

      if characters then
        for index3, value4 in ipairs(players:GetPlayers()) do
          local findFirstChild = characters:FindFirstChild(value4.Name)

          if findFirstChild and findFirstChild:GetAttribute("Dead") ~= true then
            count = count + 1
          end
        end
      end

      f3("players", count .. "/" .. v11)
    end)
  end

  if v3.health then
    f2("health", "heart", "HP: 100")

    f4("health", 0.2, function()
      local character = localPlayer.Character

      if not character then
        return
      else
        local health = character:GetAttribute("Health")
        local maxHealth = character:GetAttribute("MaxHealth")
        f3("health", "HP: " .. math.floor(health or 100) .. "/" .. math.floor(maxHealth or 100))
        return
      end
    end)
  end

  if v3.armor then
    f2("armor", "shield-check", "Armor: 0")

    f4("armor", 0.5, function()
      local character2 = localPlayer.Character

      if not character2 then
        return
      else
        local armor = character2:GetAttribute("Armor")
        f3("armor", "Armor: " .. math.floor(armor or 0))
        return
      end
    end)
  end

  if v3.weapon then
    f2("weapon", "sword", "—")

    f4("weapon", 0.5, function()
      local currentEquipped = localPlayer:GetAttribute("CurrentEquipped")

      if type(currentEquipped) == "string" then
        local v12, v13 = pcall(httpService.JSONDecode, httpService, currentEquipped)

        if v12 and v13 and v13.Name then
          f3("weapon", v13.Name)
          return
        end

        f3("weapon", "—")
        return
      end

      f3("weapon", "—")
    end)
  end

  if v3.ammo then
    f2("ammo", "bullet-flying", "0/0")

    f4("ammo", 0.2, function()
      local character3 = localPlayer.Character

      if not character3 then
        return
      else
        local ammo = character3:GetAttribute("Ammo")
        local reserve = character3:GetAttribute("Reserve")
        f3("ammo", (ammo or 0) .. "/" .. (reserve or 0))
        return
      end
    end)
  end

  if v3.kd then
    f2("kd", "trophy", "K/D: 0.0")

    f4("kd", 2, function()
      local kills = localPlayer:GetAttribute("Kills") or 0
      local deaths = localPlayer:GetAttribute("Deaths") or 0
      local v14 = deaths > 0 and kills / deaths or kills
      f3("kd", string.format("K/D: %.2f", v14))
    end)
  end

  if v3.kills then
    f2("kills", "crosshairs", "K: 0")
    f4("kills", 1, function() f3("kills", "K: " .. (localPlayer:GetAttribute("Kills") or 0)) end)
  end

  if v3.deaths then
    f2("deaths", "person-falling", "D: 0")

    f4("deaths", 1, function()
      f3("deaths", "D: " .. (localPlayer:GetAttribute("Deaths") or 0))
    end)
  end

  if v3.coords then
    f2("coords", "location-pin", "0, 0, 0")

    f4("coords", 0.2, function()
      local character4 = localPlayer.Character

      if not character4 then
        return
      else
        local humanoidRootPart = character4:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart then
          return
        else
          local position = humanoidRootPart.Position
          f3("coords", string.format("%d, %d, %d", position.X, position.Y, position.Z))
          return
        end
      end
    end)
  end

  if v3.speed then
    f2("speed", "person-running", "0 u/s")

    f4("speed", 0.2, function()
      local character5 = localPlayer.Character

      if not character5 then
        return
      else
        local humanoidRootPart2 = character5:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart2 then
          return
        else
          local assemblyLinearVelocity = humanoidRootPart2.AssemblyLinearVelocity
          local v15 = math.sqrt(assemblyLinearVelocity.X ^ 2 + assemblyLinearVelocity.Z ^ 2)
          f3("speed", math.floor(v15) .. " u/s")
          return
        end
      end
    end)
  end

  if v3.direction then
    f2("direction", "compass", "N")

    f4("direction", 0.2, function()
      local currentCamera = workspace.CurrentCamera
      local v16

      if not currentCamera then
        return
      else
        local lookVector = currentCamera.CFrame.LookVector
        local v17 = math.deg(math.atan2(lookVector.X, -lookVector.Z))

        if v17 >= -45 and v17 < 45 then
          v16 = "N"
        elseif v17 >= 45 and v17 < 135 then
          v16 = "E"
        elseif v17 >= -135 and v17 < -45 then
          v16 = "W"
        else
          v16 = "S"
        end

        f3("direction", v16)
        return
      end
    end)
  end

  local v18

  if v3.uptime then
    f2("uptime", "clock-spin-reverse", "0s")
    v18 = tick()

    f4("uptime", 1, function()
      local v19 = math.floor(tick() - v18)
      local v20 = math.floor(v19 / 3600)
      local v21 = math.floor(v19 % 3600 / 60)
      f3("uptime", string.format("%02d:%02d:%02d", v20, v21, v19 % 60))
    end)
  end

  if v3.roundTime then
    f2("roundTime", "clock-dashed", "0:00")

    f4("roundTime", 0.5, function()
      local roundTime = localPlayer:GetAttribute("RoundTime")

      if type(roundTime) == "number" then
        local v22 = math.floor(roundTime / 60)
        local v23 = math.floor(roundTime % 60)
        f3("roundTime", string.format("%d:%02d", v22, v23))
      else
        f3("roundTime", "—")
      end
    end)
  end

  if v3.map then
    f2("map", "globe-simplified", "—")

    f4("map", 2, function()
      f3("map", tostring(localPlayer:GetAttribute("Map") or localPlayer:GetAttribute("CurrentMap")
        or "—"))
    end)
  end

  if v3.mode then
    f2("mode", "controller-with-cog", "—")

    f4("mode", 2, function()
      f3("mode", tostring(localPlayer:GetAttribute("GameMode") or localPlayer:GetAttribute("Mode")
        or "—"))
    end)
  end

  if v3.scoreCT then
    f2("scoreCT", "flag", "CT: 0")

    f4("scoreCT", 1, function()
      f3("scoreCT", "CT: " .. (localPlayer:GetAttribute("ScoreCT") or 0))
    end)
  end

  if v3.scoreT then
    f2("scoreT", "flag", "T: 0")

    f4("scoreT", 1, function()
      f3("scoreT", "T: " .. (localPlayer:GetAttribute("ScoreT") or 0))
    end)
  end

  if v3.bomb then
    f2("bomb", "flame", "Bomb: OFF")

    f4("bomb", 0.5, function()
      local bombPlanted = localPlayer:GetAttribute("BombPlanted")
      local bombTimer = localPlayer:GetAttribute("BombTimer")

      if bombPlanted then
        f3("bomb", "Bomb: " .. math.floor(bombTimer or 0) .. "s")
      else
        f3("bomb", "Bomb: OFF")
      end
    end)
  end

  if v3.spectators then
    f2("spectators", "eye", "Spec: 0")

    f4("spectators", 1, function()
      f3("spectators", "Spec: " .. (localPlayer:GetAttribute("Spectators") or 0))
    end)
  end

  if v3.username then
    f2("username", "person", localPlayer.DisplayName)
    f4("username", 5, function() f3("username", localPlayer.DisplayName) end)
  end

  if v3.version then
    f2("version", "tag-sparkle", "v1.0")
  end

  if v3.status then
    f2("status", "signal-exclamation", "Online")

    f4("status", 2, function()
      local character6 = localPlayer.Character

      if not character6 then
        f3("status", "Dead")
        return
      end

      if character6:GetAttribute("Dead") == true then
        f3("status", "Dead")
      else
        f3("status", "Online")
      end
    end)
  end

  if v3.serverId then
    f2("serverId", "cloud", "—")
    f4("serverId", 5, function() f3("serverId", tostring(game.JobId):sub(1, 8)) end)
  end

  return watermark, v4
end

local v24 = {
  cheatname = true,
  fps = false,
  ping = false,
  time = false,
  uptime = false,
  status = false,
  players = false,
  spectators = false,
  username = false,
  health = false,
  armor = false,
  coords = false,
  speed = false,
  direction = false,
  weapon = false,
  ammo = false,
  kills = false,
  deaths = false,
  kd = false,
  roundTime = false,
  map = false,
  mode = false,
  scoreCT = false,
  scoreT = false,
  bomb = false,
  version = false,
  serverId = false,
}

local v25, v26 = f1(nevertiveWindow, v24)
local v27 = v26

function _G.RebuildWatermark()
  if v27 then
    for key2, value5 in pairs(v27) do
      local v28 = value5

      pcall(function()
        if v28.Destroy then
          v28:Destroy()
        elseif v28.SetVisible then
          v28:SetVisible(false)
        end
      end)
    end
  end

  pcall(function()
    if gistfile1.__WatermarkCache then
      gistfile1.__WatermarkCache = nil
    end
  end)

  pcall(function()
    local screenGui = gistfile1.ScreenGui

    if screenGui then
      for index4, value6 in ipairs(screenGui:GetDescendants()) do
        if value6:IsA("Frame") and value6:FindFirstChildOfClass("UIListLayout")
          and value6:FindFirstChildOfClass("UICorner") and value6.Size.Y.Offset == 30 then
          value6:Destroy()
        end
      end
    end
  end)

  v25, v27 = f1(nevertiveWindow, v24)
end

nevertiveWindow:AddTabLabel("Nevertive")

task.spawn(function()
  pcall(function()
    local v29 = game
    v29:GetService("CoreGui").Name = "NeverTive"
  end)

  pcall(function()
    for index5, neverTive in ipairs(coreGui:GetChildren()) do
      if neverTive:IsA("ScreenGui") and neverTive.Name:find("Nevertive") then
        neverTive.Name = "NeverTive"
      end
    end
  end)
end)

local function f5(title, content, p11)
  notification.new({ Title = title, Content = content, Duration = p11 or 5 })
end

local function f6(p12)
  if not M or not M.missLogs then
    return
  end

  if p12 then
    f5("Miss", p12.DisplayName, 2)
  else
    f5("Miss", "no target", 2)
  end
end

local function f7(p13, p14, p15, p16)
  if not M or not M.hitLogs then
    return
  else
    local displayName2 = p13 and p13.DisplayName or "?"
    local name2 = p15 and p15.Name or "?"
    local v30 = p16 and math.floor(p16) or "?"

    f5("Hit", string.format(
      "%s | %d dmg | %s | HP: %s", displayName2, math.floor(p14), name2, tostring(v30)
    ), 3)

    return
  end
end

local function f8(p17)
  if not p17 then
    return nil
  else
    local findFirstChild2 = players:FindFirstChild(p17.Name)

    if findFirstChild2 then
      return findFirstChild2
    end

    for index6, value7 in ipairs(players:GetPlayers()) do
      if value7.Character == p17 then
        return value7
      end
    end

    return nil
  end
end

local v31 = {
  lastShotTime = 0,
  lastShotTarget = nil,
  lastShotTargetHP = nil,
  pendingMissCheck = false,
}

local function f9(p18)
  local v32 = getthreadidentity and getthreadidentity()
  local v33, v34 = pcall(require, p18)

  if v33 and v34 ~= nil then
    return v34
  else
    local v35, v36 = pcall(require, p18)

    if v35 and v36 ~= nil then
      return v36
    end

    return nil, v34
  end
end

local v37 = f9(replicatedStorage.Database.Components.Libraries.Skins)

if type(v37) ~= "table" then
  error("[Nevertive.cs] Failed to load Skins library")
end

local v38 = f9(replicatedStorage.Components.Common.GetWeaponProperties)

f9(replicatedStorage.Classes.WeaponComponent.Classes.CharacterAnimator)
f9(replicatedStorage.Classes.Sound)

local v39 = {
  enabled = true,
  skins = {},
  knifeModel = nil,
  gloveModel = nil,
  factoryNew = true,
  statTrak = false,
  statTrakKills = 1337,
  applyOthers = false,
}

local function f10()
  pcall(function() writefile("NevertiveCS.json", httpService:JSONEncode(v39)) end)
end

local v40 = {}

local function f11(p19)
  if v40[p19] == nil then
    local v41, v42 = pcall(v38, p19)
    v40[p19] = v41 and type(v42) == "table" and v42 or false
  end

  return v40[p19] or nil
end

local v43 = {
  "All", "Pistols", "Rifles", "Snipers", "SMGs", "Heavy", "Knives", "Gloves", "Grenades",
  "Other",
}

local v44 = {}

for index7, value8 in ipairs(v43) do
  v44[value8] = index7
end

local v45 = {}

local function f12(p20, p21)
  for index8, value9 in ipairs(p21) do
    v45[value9] = p20
  end
end

f12("Knives", {
  "T Knife", "CT Knife", "Gut Knife", "Flip Knife", "Butterfly Knife", "M9 Bayonet", "Karambit",
  "Stiletto Knife", "Skeleton Knife", "LightSaber",
})

f12("Gloves", {
  "Hand Wraps", "T Glove", "CT Glove", "Driver Gloves", "Operator Gloves", "Sports Gloves",
})

f12("Snipers", { "AWP", "SSG 08" })

f12("Pistols", {
  "Glock-18", "USP-S", "P250", "Five-SeveN", "Tec-9", "Dual Berettas", "Desert Eagle",
  "R8 Revolver", "Zeus x27",
})

f12("SMGs", { "MP9", "MAC-10", "P90" })
f12("Heavy", { "Nova", "XM1014", "MAG-7", "Sawed-Off", "Negev" })
f12("Rifles", { "AK-47", "M4A4", "M4A1-S", "FAMAS", "Galil AR", "AUG", "SG 553" })

f12("Grenades", {
  "HE Grenade", "Flashbang", "Smoke Grenade", "Molotov", "Incendiary Grenade", "Decoy Grenade",
})

f12("Other", { "C4" })

local f13

local function f14(p22)
  return f13(p22) == "Knives"
end

function f13(p23)
  local v46 = f11(p23)

  if v46 then
    local class = v46.Class or ""
    local v47 = v46.Type or ""

    if class == "Glove" then
      return "Gloves"
    elseif class == "Melee" then
      return "Knives"
    elseif class == "Grenade" then
      return "Grenades"
    elseif class == "C4" then
      return "Other"
    elseif v47 == "Pistol" then
      return "Pistols"
    elseif v47 == "Rifle" then
      return (p23 == "AWP" or p23 == "SSG 08") and "Snipers" or "Rifles"
    elseif v47 == "SMG" then
      return "SMGs"
    elseif v47 == "Heavy" then
      return "Heavy"
    elseif v45[p23] then
      return v45[p23]
    else
      if p23:find("Knife") or p23:find("Bayonet") or p23:find("Karambit") then
        return "Knives"
      end

      if p23:find("Glove") or p23 == "Hand Wraps" then
        return "Gloves"
      end

      if p23:find("Grenade") or p23 == "Molotov" or p23 == "Flashbang" then
        return "Grenades"
      end

      return "Other"
    end
  elseif v45[p23] then
    return v45[p23]
  else
    if p23:find("Knife") or p23:find("Bayonet") or p23:find("Karambit") then
      return "Knives"
    end

    if p23:find("Glove") or p23 == "Hand Wraps" then
      return "Gloves"
    end

    if p23:find("Grenade") or p23 == "Molotov" or p23 == "Flashbang" then
      return "Grenades"
    end

    return "Other"
  end
end

local function f15(p24)
  return f13(p24) == "Gloves"
end

local weapons = replicatedStorage.Assets:FindFirstChild("Weapons")

local function f16(p25)
  return type(p25) == "string" and weapons ~= nil and weapons:FindFirstChild(p25) ~= nil
end

local function f17(p26)
  local v48, v49 = pcall(v37.GetAllSkinsForWeapon, p26)

  if not v48 or type(v49) ~= "table" then
    return {}
  else
    local v50 = {}

    for index9, value10 in ipairs(v49) do
      local skin = value10.skin or value10.name

      if type(skin) == "string" then
        local imageAssetId = value10.imageAssetId

        if not imageAssetId and type(value10.wearImages) == "table" then
          local assetId = nil

          for key3, value11 in pairs(value10.wearImages) do
            if type(value11) == "table" then
              assetId = assetId or value11.assetId

              if value11.wear == "Factory New" then
                imageAssetId = value11.assetId
                break
              end
            elseif type(value11) == "string" then
              assetId = assetId or value11
            end
          end

          imageAssetId = imageAssetId or assetId
        end

        v50[#v50 + 1] = {
          name = skin,
          icon = imageAssetId,
          rarity = value10.rarity,
          enabled = value10.isEnabled,
        }
      end
    end

    table.sort(v50, function(p27, p28)
      if p27.name == "Stock" then
        return true
      end

      if p28.name == "Stock" then
        return false
      end

      return p27.name < p28.name
    end)

    return v50
  end
end

local function f18(p29, p30)
  if type(p29) ~= "string" or type(p30) ~= "string" then
    return false
  else
    local v51, v52 = pcall(v37.GetSkinInformation, p29, p30)
    return v51 and v52 ~= nil
  end
end

local function f19(p31, p32)
  if p32 and f18(p31, p32) then
    return p32
  elseif f18(p31, "Stock") then
    return "Stock"
  else
    local v53 = f17(p31)
    return v53[1] and v53[1].name or p32
  end
end

local v54 = {}

for index10, value12 in ipairs(replicatedStorage.Assets.Weapons:GetChildren()) do
  if value12:IsA("Folder") and f13(value12.Name) ~= "Grenades" then
    local count2 = 0

    for index11, value13 in ipairs(f17(value12.Name)) do
      if value13.name ~= "Stock" then
        count2 = count2 + 1
      end
    end

    if count2 > 0 then
      v54[#v54 + 1] = value12.Name
    end
  end
end

table.sort(v54, function(p33, p34)
  local v55 = v44[f13(p33)] or 99
  local v56 = v44[f13(p34)] or 99

  if v55 ~= v56 then
    return v55 < v56
  end

  return p33 < p34
end)

local function f20(p35)
  return v39.enabled and v39.statTrak and p35 == nil and v39.statTrakKills or p35
end

local function f21(p36)
  return v39.enabled and v39.factoryNew and 0 or p36
end

local function f22(p37, p38)
  if not v39.enabled or type(p37) ~= "string" then
    return p37, p38
  else
    local knifeModel = p37

    if v39.knifeModel and f14(p37) and v39.knifeModel ~= p37 and f16(v39.knifeModel) then
      knifeModel = v39.knifeModel
    elseif v39.gloveModel and f15(p37) and v39.gloveModel ~= p37 and f16(v39.gloveModel) then
      knifeModel = v39.gloveModel
    end

    local v57 = v39.skins[knifeModel]

    if v57 and f18(knifeModel, v57) then
      return knifeModel, v57
    end

    if knifeModel ~= p37 then
      return knifeModel, f19(knifeModel, p38)
    end

    return p37, p38
  end
end

local v58 = {}

for index12, value14 in ipairs({
  "GetCameraModel", "GetCharacterModel", "GetWorldModel", "GetMagazine", "GetGloves",
}) do
  v58[value14] = v37[value14]
end

function v37.GetCameraModel(p39, p40, p41, p42, p43, p44, p45, p46)
  local v59, v60 = f22(p39, p40)
  local v61, v62 = pcall(v58.GetCameraModel, v59, v60, f21(p41), f20(p42), p43, p44, p45, p46)
  return v61 and v62 and v62 or v58.GetCameraModel(p39, p40, p41, p42, p43, p44, p45, p46)
end

function v37.GetMagazine(p47, p48, p49)
  local v63, v64 = f22(p47, p48)
  local v65, v66 = pcall(v58.GetMagazine, v63, v64, f21(p49))
  return v65 and v66 and v66 or v58.GetMagazine(p47, p48, p49)
end

function v37.GetGloves(p50, p51, p52)
  local v67, v68 = f22(p50, p51)
  local v69, v70 = pcall(v58.GetGloves, v67, v68, f21(p52))
  return v69 and v70 and v70 or v58.GetGloves(p50, p51, p52)
end

function v37.GetCharacterModel(p53, p54, p55, p56, p57, p58, p59, p60)
  if not v39.applyOthers then
    return v58.GetCharacterModel(p53, p54, p55, p56, p57, p58, p59, p60)
  else
    local v71, v72 = f22(p53, p54)

    local v73, v74 = pcall(
      v58.GetCharacterModel, v71, v72, f21(p55), f20(p56), p57, p58, p59, p60
    )

    return v73 and v74 and v74 or v58.GetCharacterModel(p53, p54, p55, p56, p57, p58, p59, p60)
  end
end

function v37.GetWorldModel(p61, p62, p63, p64, p65, p66, p67)
  if not v39.applyOthers then
    return v58.GetWorldModel(p61, p62, p63, p64, p65, p66, p67)
  else
    local v75, v76 = f22(p61, p62)
    local v77, v78 = pcall(v58.GetWorldModel, v75, v76, f21(p63), f20(p64), p65, p66, p67)
    return v77 and v78 and v78 or v58.GetWorldModel(p61, p62, p63, p64, p65, p66, p67)
  end
end

local v79 = f9(replicatedStorage.Classes.WeaponComponent.Classes.Viewmodel)

if type(v79) == "table" and type(v79.new) == "function" then
  v58.ViewmodelNew = v79.new

  function v79.new(p68, p69, p70, p71)
    if v39.enabled and type(p69) == "string" then
      local v80, v81 = f22(p69, p70)
      local v82, v83 = pcall(v58.ViewmodelNew, p68, v80, v81, p71)

      if v82 and v83 then
        return v83
      end

      return v58.ViewmodelNew(p68, p69, p70, p71)
    end

    return v58.ViewmodelNew(p68, p69, p70, p71)
  end
end

v39.esp = type(v39.esp) == "table" and v39.esp or {}
local esp = v39.esp

for key4, value15 in pairs({
  arrowStyle = "Triangle",
  arrowGlow = false,
  arrowPulse = false,
  enabled = false,
  boxes = false,
  skeleton = false,
  names = false,
  health = false,
  distance = false,
  weapon = false,
  tracers = false,
  showTeam = false,
  maxDist = 1500,
  lookVector = false,
  highlights = false,
  enemyColor = { r = 135, g = 206, b = 235 },
  teamColor = { r = 135, g = 206, b = 235 },
  hlColor = { r = 173, g = 216, b = 230 },
  nameColor = { r = 255, g = 255, b = 255 },
  hpColor = { r = 100, g = 255, b = 100 },
  skeletonColor = { r = 255, g = 255, b = 255 },
  tracerColor = { r = 255, g = 255, b = 255 },
  lookVectorColor = { r = 255, g = 255, b = 0 },
  distanceColor = { r = 255, g = 255, b = 255 },
  weaponColor = { r = 255, g = 255, b = 255 },
  boxThickness = 1.5,
  skeletonThickness = 1,
  cornerBox = false,
  chams = false,
  arrows = false,
  arrowSize = 15,
  arrowRadius = 200,
  arrowColor = { r = 255, g = 80, b = 80 },
  arrowTeamColor = { r = 80, g = 180, b = 255 },
  arrowOutline = false,
  arrowShowDistance = false,
  chamsMode = "Both",
  chamsStyle = "Solid",
  chamsColor = { r = 135, g = 206, b = 235 },
  chamsColor2 = { r = 255, g = 100, b = 200 },
  chamsFillTransparency = 0.5,
  chamsOutlineTransparency = 0.8,
  chamsThroughWalls = false,
  chamsPulseSpeed = 3,
  chamsGradientSpeed = 2,
  chamsDistanceNear = 100,
  chamsDistanceFar = 1500,
  headDot = false,
  headDotSize = 6,
  headDotColor = { r = 255, g = 0, b = 0 },
  aimline = false,
  aimlineColor = { r = 255, g = 255, b = 255 },
  teamCheck = false,
  healthBarColor = { r = 0, g = 255, b = 0 },
}) do
  if esp[key4] == nil then
    esp[key4] = value15
  end
end

local function f23(p72)
  if type(p72) ~= "table" then
    return Color3.new(1, 1, 1)
  end

  return Color3.fromRGB(p72.r or 255, p72.g or 255, p72.b or 255)
end

v39.aim = type(v39.aim) == "table" and v39.aim or {}
local aim = v39.aim

local v84 = {
  enabled = false,
  fov = 180,
  part = "Head",
  visibleCheck = false,
  fovCircle = false,
  maxDist = 3000,
  wallbang = false,
  wallbangMode = "Some",
  silent360 = false,
  aimMode = "Silent",
  priorityTarget = nil,
  priorityEnabled = false,
  aimKey = nil,
  protectName = false,
  customScope = false,
  scopeColor = { r = 0, g = 255, b = 150 },
  scopeThickness = 2,
  scopeSize = 20,
  scopeGap = 4,
  scopeDot = false,
  fovBaseColor = { r = 255, g = 100, b = 100 },
  fovTargetColor = { r = 0, g = 255, b = 150 },
  autoFire = false,
  hitMarker = false,
  damageNumbers = false,
  wallbangMultiplier = 3,
  autoFireDelay = 0.05,
  autoFireHold = false,
  hitChance = 100,
  minDamage = 0,
  multipoint = 0,
  multipointEnabled = false,
  targetHead = true,
  targetTorso = false,
  targetArms = false,
  targetLegs = false,
  hitboxEnabled = false,
  hitboxSize = 2,
  hitboxTransparency = 1,
  backtrackEnabled = false,
  backtrackTime = 0.2,
  backtrackVisualize = false,
  headHookEnabled = false,
}

v39.misc = v39.misc or {}
v39.misc.protectName = false
v39.misc.protectNameValue = "NeverTive"

for key5, value16 in pairs(v84) do
  if aim[key5] == nil then
    aim[key5] = value16
  end
end

v39.movement = type(v39.movement) == "table" and v39.movement or {}
local movement = v39.movement

for key6, value17 in pairs({
  bhop = false,
  bhopSpeed = 22,
  bhopAutoStrafe = false,
  bhopStrafeForce = 2,
  bhopMinSpeed = 10,
  bhopAutoJump = true,
  bhopKey = false,
  bhopMode = "Legit",
  bhopTeleport = true,
  bhopTeleportDist = 0.18,
}) do
  if movement[key6] == nil then
    movement[key6] = value17
  end
end

v39.gunmod = type(v39.gunmod) == "table" and v39.gunmod or {}
local gunmod = v39.gunmod

for key7, value18 in pairs({
  firerate = false,
  firerateValue = 0.05,
  autoFire = false,
  noRecoil = false,
  noSpread = false,
  customRpm = false,
  rpmValue = 600,
  instantReload = false,
}) do
  if gunmod[key7] == nil then
    gunmod[key7] = value18
  end
end

v39.misc = type(v39.misc) == "table" and v39.misc or {}
local misc = v39.misc

for key8, value19 in pairs({
  specterChecked = false,
  noFlash = false,
  noSmoke = false,
  hitLogs = false,
  missLogs = false,
}) do
  if misc[key8] == nil then
    misc[key8] = value19
  end
end

v39.world = type(v39.world) == "table" and v39.world or {}
local world = v39.world

for key9, value20 in pairs({
  customFov = false,
  fovValue = 80,
  thirdPerson = false,
  thirdPersonDist = 10,
  fullbright = false,
  mapColorEnabled = false,
  mapColor = { r = 255, g = 255, b = 255 },
  mapColorMode = "Tint",
  mapSaturation = 0,
  noFog = false,
  noTextures = false,
  noParticles = false,
  removeGrass = false,
  clockTimeEnabled = false,
  clockTime = 14,
  brightnessEnabled = false,
  brightness = 2,
  ambientEnabled = false,
  ambientColor = { r = 100, g = 100, b = 100 },
  outdoorAmbientEnabled = false,
  outdoorAmbientColor = { r = 100, g = 100, b = 100 },
  skyboxEnabled = false,
  skyboxId = "rbxassetid://159454299",
  cameraDistanceEnabled = false,
  cameraDistance = 10,
  bloomEnabled = false,
  bloomIntensity = 1,
  bloomSize = 24,
  bloomThreshold = 0.9,
  colorCorrectionEnabled = false,
  ccBrightness = 0,
  ccContrast = 0,
  ccSaturation = 0,
  ccTintColor = { r = 255, g = 255, b = 255 },
  sunRaysEnabled = false,
  sunRaysIntensity = 0.25,
  sunRaysSpread = 1,
  motionBlurEnabled = false,
  motionBlurStrength = 1,
}) do
  if world[key9] == nil then
    world[key9] = value20
  end
end

local function f24(p73, p74)
  local drawing = Drawing.new(p73)

  for key10, value21 in pairs(p74) do
    drawing[key10] = value21
  end

  drawing.Visible = false
  return drawing
end

local v85 = {}

local function f25(p75, p76)
  if v85[p76] and v85[p76].Parent then
    return v85[p76]
  else
    local findFirstChild3 = lighting:FindFirstChild("__NT_" .. p76)

    if findFirstChild3 then
      v85[p76] = findFirstChild3
      return findFirstChild3
    else
      local v86, v87 = pcall(Instance.new, p75)

      if not v86 then
        return nil
      end

      v87.Name = "__NT_" .. p76
      v87.Parent = lighting

      v85[p76] = v87
      return v87
    end
  end
end

local function f26(p77, fn)
  for key11, value22 in pairs(p77) do
    if key11 == "bones" or key11 == "cornerBox" then
      for index13, value23 in ipairs(value22) do
        fn(value23)
      end
    else
      fn(value22)
    end
  end
end

local function f27()
  local v88, v89, v90

  if type(gethui) == "function" then
    local v91, v92 = pcall(gethui)

    if v91 and v92 then
      return v92
    end

    v88 = { pcall(function() return coreGui end) }
    v89 = v88[1]
    v90 = v88[2]

    if v89 and v90 then
      return v90
    end

    return localPlayer and localPlayer:FindFirstChild("PlayerGui")
  end

  v88 = { pcall(function() return coreGui end) }
  v89 = v88[1]
  v90 = v88[2]

  if v89 and v90 then
    return v90
  end

  return localPlayer and localPlayer:FindFirstChild("PlayerGui")
end

local function f28(p78)
  f26(p78, function(p79) end)
end

local v93 = {}
workspace:FindFirstChild("Characters")
local v94 = {}
local v95, instance

function v94.init()
  local v96 = f27()

  if not v96 then
    return
  end

  pcall(function()
    local agSpectatorUI = v96:FindFirstChild("AG_SpectatorUI")

    if agSpectatorUI then
      agSpectatorUI:Destroy()
    end

    local agSpectatorUI2 = Instance.new("ScreenGui")
    agSpectatorUI2.Name = "AG_SpectatorUI"
    agSpectatorUI2.ResetOnSpawn = false
    agSpectatorUI2.DisplayOrder = 1000000
    agSpectatorUI2.Parent = v96

    v95 = agSpectatorUI2

    local spectatorCard = Instance.new("Frame")
    spectatorCard.Name = "SpectatorCard"
    spectatorCard.Size = UDim2.new(0, 190, 0, 32)
    spectatorCard.Position = UDim2.new(0.5, -95, 0.05, 0)
    spectatorCard.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    spectatorCard.BorderSizePixel = 0
    spectatorCard.Visible = false
    spectatorCard.Parent = agSpectatorUI2

    Instance.new("UICorner", spectatorCard).CornerRadius = UDim.new(0, 8)

    local instance2 = Instance.new("UIStroke", spectatorCard)
    instance2.Color = Color3.fromRGB(80, 150, 220)
    instance2.Thickness = 1

    instance = Instance.new("TextLabel", spectatorCard)
    instance.Size = UDim2.new(1, 0, 1, 0)
    instance.BackgroundTransparency = 1
    instance.Font = Enum.Font.SourceSansBold
    instance.TextSize = 13
    instance.TextColor3 = Color3.fromRGB(255, 255, 255)
    instance.Text = ""
  end)
end

function v94.update()
  if not v95 then
    v94.init()
  end

  local spectatorCard2 = v95 and v95:FindFirstChild("SpectatorCard")

  if not spectatorCard2 or not instance then
    return
  end

  if misc.specterChecked then
    local spectators = localPlayer:GetAttribute("Spectators") or 0

    if spectators > 0 then
      spectatorCard2.Visible = true
      instance.Text = string.format("Spectating You: %d", spectators)
    else
      spectatorCard2.Visible = false
    end
  else
    spectatorCard2.Visible = false
  end
end

function v94.cleanup()
  if v95 then
    pcall(function() v95:Destroy() end)
    v95 = nil
  end

  instance = nil
end

task.spawn(function()
  local v97 = getrawmetatable and setreadonly
  local newindex

  if v97 then
    local v98 = getrawmetatable(game)
    newindex = v98.__newindex
    setreadonly(v98, false)

    v98.__newindex = newcclosure(function(p80, p81, p82)
      if p80 == localPlayer and world.thirdPerson then
        if p81 == "CameraMode" then
          return newindex(p80, p81, Enum.CameraMode.Classic)
        elseif p81 == "CameraMaxZoomDistance" then
          return newindex(p80, p81, world.thirdPersonDist or 10)
        else
          if p81 == "CameraMinZoomDistance" then
            return newindex(p80, p81, world.thirdPersonDist or 10)
          end

          return newindex(p80, p81, p82)
        end
      else
        return newindex(p80, p81, p82)
      end
    end)

    setreadonly(v98, true)
  end
end)

f24("Circle", {
  Thickness = 3,
  Color = Color3.new(0, 0, 0),
  Transparency = 0.5,
  NumSides = 64,
  Filled = false,
})

f24("Circle", {
  Thickness = 1.5,
  Transparency = 0.9,
  NumSides = 64,
  Filled = false,
  Color = f23(aim.fovBaseColor),
})

local v99 = {
  top = f24("Line", { Thickness = 2, Transparency = 0.9 }),
  bottom = f24("Line", { Thickness = 2, Transparency = 0.9 }),
  left = f24("Line", { Thickness = 2, Transparency = 0.9 }),
  right = f24("Line", { Thickness = 2, Transparency = 0.9 }),
  dot = f24("Circle", { Filled = true, Transparency = 1 }),
}

local v100 = {}
local v101 = {}
local v102, v103

local function f29()
  if not aim.hitMarker then
    return
  end

  v103 = tick() + 0.15

  if not v102 then
    v102 = {
      l1 = f24("Line", { Thickness = 2, Color = Color3.new(1, 1, 1), Transparency = 1 }),
      l2 = f24("Line", { Thickness = 2, Color = Color3.new(1, 1, 1), Transparency = 1 }),
      l3 = f24("Line", { Thickness = 2, Color = Color3.new(1, 1, 1), Transparency = 1 }),
      l4 = f24("Line", { Thickness = 2, Color = Color3.new(1, 1, 1), Transparency = 1 }),
    }
  end
end

local function f30(worldPos, p83, p84)
  if not aim.damageNumbers then
    return
  else
    local drawing2 = f24("Text", {
      Text = tostring(math.floor(p83)),
      Size = p84 and 20 or 16,
      Color = p84 and Color3.fromRGB(255, 80, 80) or Color3.new(1, 1, 1),
      Center = true,
      Outline = true,
      Font = 2,
      Transparency = 1,
    })

    v100[#v100 + 1] = {
      drawing = drawing2,
      worldPos = worldPos,
      startTime = tick(),
      duration = 1,
      offset = Vector2.new(math.random(-15, 15), 0),
    }

    return
  end
end

local raycastParams = RaycastParams.new()
pcall(function() raycastParams.FilterType = Enum.RaycastFilterType.Exclude end)
local v104 = {}

local function f31(p85)
  if not aim.backtrackEnabled then
    return nil
  else
    local v105 = f8(p85)

    if not v105 then
      return nil
    else
      local v106 = v104[v105]

      if not v106 or #v106 == 0 then
        return nil
      else
        local v107 = tonumber(aim.backtrackTime) or 0.2
        local v108 = tick()
        local v109 = nil
        local huge = math.huge

        for index14, value24 in ipairs(v106) do
          local v110 = math.abs(v108 - value24.time - v107)

          if v110 < huge then
            v109 = value24
            huge = v110
          end
        end

        return v109
      end
    end
  end
end

local v111 = 0
local v112

local function f32()
  local v113 = v112
  local v114 = tick()

  if v113 and v114 - v111 < 0.1 then
    return v112
  end

  v112 = nil
  v111 = v114
  return nil
end

local function f33(p86)
  if not aim.multipointEnabled then
    return p86.Position
  elseif not p86 then
    return Vector3.zero
  else
    local v115 = tonumber(aim.multipoint) or 0

    if v115 <= 0 then
      return p86.Position
    else
      local v116 = 0

      if p86:IsA("BasePart") then
        local size = p86.Size
        v116 = math.max(size.X, size.Y, size.Z) * 0.5
      end

      if v116 <= 0 then
        return p86.Position
      else
        local v117 = v116 * (v115 / 100)
        local v118 = math.random()
        local v119 = math.random()
        local v120 = math.random()

        local vector = Vector3.new(
          (v118 - 0.5) * 2 * v117, (v119 - 0.5) * 2 * v117, (v120 - 0.5) * 2 * v117
        )

        return p86.Position + vector
      end
    end
  end
end

local v121 = {
  [Enum.Material.Plastic] = 0.05,
  [Enum.Material.SmoothPlastic] = 0.05,
  [Enum.Material.Neon] = 0.1,
  [Enum.Material.Wood] = 0.1,
  [Enum.Material.WoodPlanks] = 0.1,
  [Enum.Material.Cardboard] = 0.03,
  [Enum.Material.Carpet] = 0.03,
  [Enum.Material.Fabric] = 0.03,
  [Enum.Material.Leather] = 0.05,
  [Enum.Material.Glass] = 0.05,
  [Enum.Material.Ice] = 0.15,
  [Enum.Material.Snow] = 0.1,
  [Enum.Material.Sand] = 0.2,
  [Enum.Material.Sandstone] = 0.25,
  [Enum.Material.Limestone] = 0.3,
  [Enum.Material.Rock] = 0.35,
  [Enum.Material.Slate] = 0.4,
  [Enum.Material.Basalt] = 0.4,
  [Enum.Material.Granite] = 0.4,
  [Enum.Material.Marble] = 0.4,
  [Enum.Material.Concrete] = 0.5,
  [Enum.Material.Cobblestone] = 0.5,
  [Enum.Material.Pebble] = 0.5,
  [Enum.Material.Asphalt] = 0.5,
  [Enum.Material.Brick] = 0.5,
  [Enum.Material.CorrodedMetal] = 0.6,
  [Enum.Material.DiamondPlate] = 0.6,
  [Enum.Material.Metal] = 0.6,
  [Enum.Material.Foil] = 0.6,
  [Enum.Material.Grass] = 0.03,
  [Enum.Material.LeafyGrass] = 0.03,
  [Enum.Material.Mud] = 0.1,
  [Enum.Material.Glacier] = 0.2,
  [Enum.Material.Salt] = 0.1,
  [Enum.Material.CrackedLava] = 0.6,
  [Enum.Material.Plaster] = 0.3,
  [Enum.Material.RoofShingles] = 0.2,
  [Enum.Material.ClayRoofTiles] = 0.3,
  [Enum.Material.CeramicTiles] = 0.35,
  [Enum.Material.Pavement] = 0.5,
  [Enum.Material.Rubber] = 0.2,
  [Enum.Material.ForceField] = 0.05,
  [Enum.Material.Water] = 0.01,
  [Enum.Material.Air] = 0.01,
}

local v122 = 0.14
local v123 = 0
local v124 = nil

local function f34()
  if aim.wallbang and aim.wallbangMode == "All" then
    return 99999
  else
    local v125 = f32()
    local v126 = tick()

    if v124 == v125 and v126 - v123 < 0.5 then
      return v122
    else
      v124 = v125
      local v127 = 0.14
      v123 = v126

      if v125 then
        local v128 = f11(v125)

        if v128 and v128.Penetration ~= nil then
          v127 = tonumber(v128.Penetration) or 0.14
        end
      end

      v122 = v127
      return v127
    end
  end
end

local v129 = f9(replicatedStorage.Components.Weapon.Classes.Bullet)

task.spawn(function()
  local v130 = not getrawmetatable or not hookmetamethod
  local namecall

  if v130 then
    return
  else
    local v131 = getrawmetatable(game)
    namecall = v131.__namecall
    setreadonly(v131, false)

    v131.__namecall = newcclosure(function(p87, ...)
      local v132 = { ... }
      local v133 = getnamecallmethod()
      local protectName = misc and misc.protectName and p87 == localPlayer
      local v134, v135

      if protectName then
        local protectNameValue = misc.protectNameValue or "NeverTive"

        if v133 == "GetAttribute" then
          local v136 = v132[1]

          if v136 == "DisplayName" or v136 == "Name" or v136 == "Username" then
            return protectNameValue
          end
        end

        v134 = v133 == "FireServer"

        v135 = v134
        v135 = v134 or v133 == "InvokeServer" or v133 == "Fire"

        if v135 then
          v885 = ({ unpack(v132) })[1]
        end

        return namecall(p87, unpack(v132))
      end

      v134 = v133 == "FireServer"

      v135 = v134
      v135 = v134 or v133 == "InvokeServer" or v133 == "Fire"

      if v135 then
        v885 = ({ unpack(v132) })[1]
      end

      return namecall(p87, unpack(v132))
    end)

    setreadonly(v131, true)
    return
  end
end)

f9(replicatedStorage.Components.Common.GetRayIgnore)
f9(replicatedStorage.Shared.Raycast)

local function f35(p88, p89)
  if not aim.headHookEnabled then
    return p88
  elseif not p89 then
    return p88
  else
    local head = p89:FindFirstChild("Head")

    if not head then
      return p88
    end

    for index15, value25 in ipairs(p88) do
      if value25.Instance and value25.Instance:IsDescendantOf(p89) then
        value25.Instance = head
      end
    end

    return p88
  end
end

local v137

if v129 and v129._performRaycast then
  if not _G.__originalPerformRaycast then
    _G.__originalPerformRaycast = v129._performRaycast
  end

  function v129._performRaycast(p90, p91)
    if not aim.enabled then
      return _G.__originalPerformRaycast(p90, p91)
    end

    if aim.aimMode == "None" or aim.aimMode == "Camera" or aim.aimMode == "Snap" then
      return _G.__originalPerformRaycast(p90, p91)
    end

    local origin, position2

    if not (v137 and v137.Parent and v137:IsDescendantOf(workspace)) then
      return _G.__originalPerformRaycast(p90, p91)
    else
      local parent = v137.Parent

      if parent:GetAttribute("Dead") == true then
        return _G.__originalPerformRaycast(p90, p91)
      else
        local currentCamera2 = workspace.CurrentCamera

        if not currentCamera2 then
          return _G.__originalPerformRaycast(p90, p91)
        else
          local v138 = currentCamera2.ViewportSize * 0.5
          origin = currentCamera2:ViewportPointToRay(v138.X, v138.Y).Origin

          if not v137 or not v137.Parent then
            return _G.__originalPerformRaycast(p90, p91)
          else
            position2 = f33(v137)

            if aim.backtrackEnabled then
              local v139 = f31(parent)

              if v139 then
                position2 = v139.position
              end
            end

            local raycastParams2 = RaycastParams.new()
            raycastParams2.FilterType = Enum.RaycastFilterType.Exclude

            raycastParams2.FilterDescendantsInstances = {
              localPlayer.Character, currentCamera2, parent,
            }

            raycastParams2.IgnoreWater = true

            local unit = (position2 - origin).Unit
            local magnitude = (position2 - origin).Magnitude
            local v140 = origin
            local v141 = f34()
            local total = 0
            local v142 = false
            local count3 = 0
            local v143 = 0
            local v144 = 1

            if aim.wallbangMode == "Some" then
              v144 = 1
              v143 = 1
            elseif aim.wallbangMode == "Much" then
              v144 = 2
              v143 = 3
            elseif aim.wallbangMode == "All" then
              v144 = 99999
              v143 = 99
            end

            while magnitude > 0 and count3 < 8 do
              local raycast = workspace:Raycast(v140, unit * magnitude, raycastParams2)

              if not raycast then
                break
              end

              if raycast.Instance:IsDescendantOf(parent) then
                break
              end

              count3 = count3 + 1

              if not aim.wallbang then
                v142 = true
                break
              elseif aim.wallbangMode == "None" then
                v142 = true
                break
              else
                if count3 > v143 then
                  v142 = true
                  break
                end

                if aim.wallbangMode == "Some" or aim.wallbangMode == "Much" then
                  total = total + (v121[raycast.Instance.Material] or 999)

                  if total > v141 * v144 then
                    v142 = true
                    break
                  end
                end

                v140 = raycast.Position + unit * 0.1
                magnitude = (position2 - v140).Magnitude
              end
            end

            if v142 then
              return _G.__originalPerformRaycast(p90, p91)
            else
              local v145, v146 = pcall(function()
                return {
                  Distance = (position2 - origin).Magnitude,
                  Origin = origin,
                  Direction = (position2 - origin).Unit,
                  Hits = {
                    {
                      Position = position2,
                      Instance = v137,
                      Material = "Plastic",
                      Normal = Vector3.zero,
                      Exit = false,
                    },
                  },
                }
              end)

              if v145 and v146 then
                if v146.Hits then
                  v146.Hits = f35(v146.Hits, parent)
                end

                return v146
              else
                local g = _G.__originalPerformRaycast(p90, p91)

                if aim.headHookEnabled and g and g.Hits then
                  for index16, value26 in ipairs(g.Hits) do
                    if value26.Instance and value26.Instance:IsA("BasePart") then
                      local parent2 = value26.Instance.Parent

                      if parent2 and players:FindFirstChild(parent2.Name) then
                        g.Hits = f35(g.Hits, parent2)
                        break
                      end
                    end
                  end
                end

                return g
              end
            end
          end
        end
      end
    end
  end
end

local weapons2 = replicatedStorage:WaitForChild("Database"):WaitForChild("Custom"):WaitForChild("Weapons")

local v147 = {
  Initialized = false,
  LoopActive = false,
  Connections = {},
  _originalConfigs = {},
}

local function f36(p92, p93)
  if not p92 or type(p92) ~= "table" then
    return
  else
    if isreadonly(p92) then
      setreadonly(p92, false)
    end

    local v148 = v147._originalConfigs[p93] or {}
    local firerateValue = nil

    if gunmod.customRpm and gunmod.rpmValue and gunmod.rpmValue > 0 then
      firerateValue = 60 / gunmod.rpmValue
    elseif gunmod.firerate and gunmod.firerateValue then
      firerateValue = gunmod.firerateValue
    elseif v148.FireRate ~= nil then
      firerateValue = v148.FireRate
    end

    if firerateValue then
      p92.FireRate = firerateValue
    end

    if gunmod.autoFire then
      p92.Automatic = true
    elseif v148.Automatic ~= nil then
      p92.Automatic = v148.Automatic
    end

    if type(p92.FireModes) == "table" then
      if isreadonly(p92.FireModes) then
        setreadonly(p92.FireModes, false)
      end

      if type(p92.FireModes.Primary) == "table" then
        if isreadonly(p92.FireModes.Primary) then
          setreadonly(p92.FireModes.Primary, false)
        end

        if firerateValue then
          p92.FireModes.Primary.FireRate = firerateValue
        end

        if gunmod.autoFire then
          p92.FireModes.Primary.HoldRepeat = true
        end

        table.freeze(p92.FireModes.Primary)
      end

      if type(p92.FireModes.Secondary) == "table" then
        if isreadonly(p92.FireModes.Secondary) then
          setreadonly(p92.FireModes.Secondary, false)
        end

        if firerateValue then
          p92.FireModes.Secondary.FireRate = firerateValue
        end

        if gunmod.autoFire then
          p92.FireModes.Secondary.HoldRepeat = true
        end

        table.freeze(p92.FireModes.Secondary)
      end

      table.freeze(p92.FireModes)
    end

    table.freeze(p92)
    return
  end
end

local function f37(p94)
  if not p94 or type(p94) ~= "table" then
    return
  else
    local properties = p94.Properties

    if properties and type(properties) == "table" then
      if isreadonly(properties) then
        setreadonly(properties, false)
      end

      local v149 = v147._originalConfigs[p94.Name] or {}
      local firerateValue2 = nil

      if gunmod.customRpm and gunmod.rpmValue and gunmod.rpmValue > 0 then
        firerateValue2 = 60 / gunmod.rpmValue
      elseif gunmod.firerate and gunmod.firerateValue then
        firerateValue2 = gunmod.firerateValue
      elseif v149.FireRate ~= nil then
        firerateValue2 = v149.FireRate
      end

      if firerateValue2 then
        local v150 = { "Stock" }

        if p94 and p94 ~= "None" then
          for index17, value27 in ipairs(v147(p94)) do
            table.insert(v150, value27.name)
          end
        end

        return v150
      end

      if gunmod.autoFire then
        properties.Automatic = true
      elseif v149.Automatic ~= nil then
        properties.Automatic = v149.Automatic
      end

      if type(properties.FireModes) == "table" then
        if isreadonly(properties.FireModes) then
          setreadonly(properties.FireModes, false)
        end

        if type(properties.FireModes.Primary) == "table" then
          if isreadonly(properties.FireModes.Primary) then
            setreadonly(properties.FireModes.Primary, false)
          end

          if firerateValue2 then
            properties.FireModes.Primary.FireRate = firerateValue2
          end

          if gunmod.autoFire then
            properties.FireModes.Primary.HoldRepeat = true
          end

          table.freeze(properties.FireModes.Primary)
        end

        if type(properties.FireModes.Secondary) == "table" then
          if isreadonly(properties.FireModes.Secondary) then
            setreadonly(properties.FireModes.Secondary, false)
          end

          if firerateValue2 then
            properties.FireModes.Secondary.FireRate = firerateValue2
          end

          if gunmod.autoFire then
            properties.FireModes.Secondary.HoldRepeat = true
          end

          table.freeze(properties.FireModes.Secondary)
        end

        table.freeze(properties.FireModes)
      end

      table.freeze(properties)
      return
    end

    return
  end
end

local function f38(p95)
  if type(p95) ~= "table" then
    return p95
  else
    local v151 = {}

    for key12, value28 in pairs(p95) do
      if type(value28) == "table" then
        v151[key12] = f38(value28)
      else
        v151[key12] = value28
      end
    end

    return v151
  end
end

local v152, v153

function v147.sync()
  for index18, value29 in ipairs(weapons2:GetChildren()) do
    if value29:IsA("ModuleScript") then
      local v154, v155 = pcall(require, value29)

      if v154 and type(v155) == "table" then
        f36(v155, value29.Name)
      end
    end
  end

  if v153 and v153.shoot and getupvalues then
    local v156, v157 = pcall(getupvalues, v153.shoot)

    if v156 and type(v157) == "table" and type(v157[5]) == "table" then
      for key13, value30 in pairs(v157[5]) do
        if type(value30) == "table" then
          f36(value30, key13)
        end
      end
    end
  end

  if v152 and (getupvalues or debug.getupvalues) then
    local v158, v159 = pcall(getupvalues or debug.getupvalues, v152.getCurrentInventory)

    if v158 and v159 and v159[1] then
      local v160 = v159[1]

      if v160.CurrentEquipped then
        f37(v160.CurrentEquipped)
      end

      if v160.Inventory then
        for key14, value31 in pairs(v160.Inventory) do
          if value31._items then
            for index19, value32 in ipairs(value31._items) do
              f37(value32)
            end
          end
        end
      end
    end
  end
end

function v147.init()
  if v147.Initialized then
    return
  end

  v147.Initialized = true

  for index20, value33 in ipairs(weapons2:GetChildren()) do
    if value33:IsA("ModuleScript") then
      local v161, v162 = pcall(require, value33)

      if v161 and type(v162) == "table" and not v147._originalConfigs[value33.Name] then
        v147._originalConfigs[value33.Name] = f38(v162)
      end
    end
  end

  if v152 and v152.OnInventoryItemEquipped then
    local connect = v152.OnInventoryItemEquipped:Connect(function(p96, p97)
      if type(p97) == "table" then
        f37(p97)
      end

      pcall(v147.sync)
    end)

    table.insert(v147.Connections, connect)
  end

  v147.LoopActive = true

  task.spawn(function()
    while v147.LoopActive do
      pcall(v147.sync)
      task.wait(0.35)
    end
  end)

  v147.sync()
end

function v147.cleanup()
  v147.LoopActive = false

  for index21, value34 in ipairs(v147.Connections) do
    local v163 = value34
    pcall(function() v163:Disconnect() end)
  end

  v147.Connections = {}

  for key15, value35 in pairs(v147._originalConfigs) do
    local findFirstChild4 = weapons2:FindFirstChild(key15)

    if findFirstChild4 and findFirstChild4:IsA("ModuleScript") then
      local v164, v165 = pcall(require, findFirstChild4)

      if v164 and type(v165) == "table" then
        if isreadonly(v165) then
          setreadonly(v165, false)
        end

        for key16, value36 in pairs(value35) do
          if type(value36) == "table" then
            v165[key16] = f38(value36)
          else
            v165[key16] = value36
          end
        end

        table.freeze(v165)
      end
    end
  end

  v147.Initialized = false
end

v147.init()

local v166 = {
  Reload = true,
  ReloadStart = true,
  ReloadAction = true,
  ReloadEnd = true,
}

local function f39()
  local v167, v168 = pcall(function()
    return require(replicatedStorage.Controllers.InventoryController)
  end)

  if not v167 or not v168 then
    return nil
  end

  return v168.peekCurrentEquippedForMovement and v168.peekCurrentEquippedForMovement() or nil
end

local v169 = {}

local function f40(p98)
  if not p98 or v169[p98] then
    return
  end

  v169[p98] = true

  pcall(function()
    local play = p98.play

    function p98.play(p99, p100, ...)
      local v170 = play(p99, p100, ...)

      if v170 and v166[p100] then
        task.defer(function()
          pcall(function()
            if gunmod.instantReload and v170.IsPlaying then
              v170:AdjustSpeed(199)
            end
          end)
        end)
      end

      return v170
    end
  end)
end

local v171

task.spawn(function()
  while task.wait(0.1) do
    pcall(function()
      local v172 = f39()

      if not v172 then
        return
      end

      if v172 ~= v171 then
        v171 = v172

        if v172.Viewmodel and v172.Viewmodel.Animation then
          f40(v172.Viewmodel.Animation)
        end

        if v172.CharacterAnimator then
          f40(v172.CharacterAnimator)
        end
      end

      if not gunmod.instantReload then
        return
      end

      if v172.IsReloading then
        pcall(function()
          if v172.Viewmodel and v172.Viewmodel.Animation and v172.Viewmodel.Animation.Animations then
            for key17, value37 in pairs(v172.Viewmodel.Animation.Animations) do
              if v166[key17] and value37.IsPlaying then
                value37:AdjustSpeed(199)
              end
            end
          end

          if v172.CharacterAnimator and v172.CharacterAnimator.Animations then
            for key18, value38 in pairs(v172.CharacterAnimator.Animations) do
              if v166[key18] and value38.IsPlaying then
                value38:AdjustSpeed(199)
              end
            end
          end
        end)
      end
    end)
  end
end)

pcall(function()
  if v152 and v152.OnInventoryItemEquipped then
    v152.OnInventoryItemEquipped:Connect(function(p101, p102)
      if not p102 then
        return
      end

      task.defer(function()
        if p102.Viewmodel and p102.Viewmodel.Animation then
          f40(p102.Viewmodel.Animation)
        end

        if p102.CharacterAnimator then
          f40(p102.CharacterAnimator)
        end
      end)
    end)
  end
end)

local v173 = 0
local v174 = 0

local function f41()
  local currentCamera3 = workspace.CurrentCamera
  local unit2, unit3

  if not currentCamera3 then
    return Vector3.zero
  else
    local vector2 = Vector3.new(
      currentCamera3.CFrame.LookVector.X, 0, currentCamera3.CFrame.LookVector.Z
    )

    local vector3 = Vector3.new(
      currentCamera3.CFrame.RightVector.X, 0, currentCamera3.CFrame.RightVector.Z
    )

    if vector2.Magnitude > 0.01 then
      unit2 = vector2.Unit
    else
      unit2 = Vector3.new(0, 0, -1)
    end

    if vector3.Magnitude > 0.01 then
      unit3 = vector3.Unit
    else
      unit3 = Vector3.new(1, 0, 0)
    end

    local zero = Vector3.zero

    if userInputService:IsKeyDown(Enum.KeyCode.W) then
      zero = zero + unit2
    end

    if userInputService:IsKeyDown(Enum.KeyCode.S) then
      zero = zero - unit2
    end

    if userInputService:IsKeyDown(Enum.KeyCode.A) then
      zero = zero - unit3
    end

    if userInputService:IsKeyDown(Enum.KeyCode.D) then
      zero = zero + unit3
    end

    if zero.Magnitude < 0.01 then
      return Vector3.zero
    end

    return zero.Unit
  end
end

local v175 = 0.18
local connect2

local function f42()
  if connect2 then
    return
  end

  connect2 = runService.Heartbeat:Connect(function()
    local humanoid

    if not movement.bhop then
      return
    else
      local character7 = localPlayer.Character

      if not character7 then
        return
      else
        humanoid = character7:FindFirstChildOfClass("Humanoid")
        local humanoidRootPart3 = character7:FindFirstChild("HumanoidRootPart")

        if not humanoid or not humanoidRootPart3 then
          return
        elseif humanoid.Health <= 0 then
          return
        else
          v175 = movement.bhopMode == "Rage" and 0.5 or 0.18

          if userInputService:IsKeyDown(Enum.KeyCode.Space) or movement.bhopAutoJump then
            local v176 = tick()

            if v176 - v173 >= 0.05 then
              v173 = v176

              if humanoid.FloorMaterial ~= Enum.Material.Air then
                pcall(function()
                  humanoid.Jump = true

                  if humanoid:GetState() ~= Enum.HumanoidStateType.Jumping then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                  end
                end)
              end
            end
          end

          if humanoid.FloorMaterial == Enum.Material.Air and movement.bhopTeleport then
            local v177 = f41()

            if v177.Magnitude >= 0.01 then
              local v178 = tick()

              if v178 - v174 >= 0.03 then
                humanoidRootPart3.CFrame = humanoidRootPart3.CFrame + v177 * v175
                v174 = v178
              end
            end
          end

          if movement.bhopAutoStrafe and humanoid.FloorMaterial == Enum.Material.Air
            and not movement.bhopTeleport then
            local currentCamera4 = workspace.CurrentCamera

            if currentCamera4 then
              local zero2 = Vector3.zero

              if userInputService:IsKeyDown(Enum.KeyCode.W) then
                zero2 = zero2 + currentCamera4.CFrame.LookVector
              end

              if userInputService:IsKeyDown(Enum.KeyCode.S) then
                zero2 = zero2 - currentCamera4.CFrame.LookVector
              end

              if userInputService:IsKeyDown(Enum.KeyCode.A) then
                zero2 = zero2 - currentCamera4.CFrame.RightVector
              end

              if userInputService:IsKeyDown(Enum.KeyCode.D) then
                zero2 = zero2 + currentCamera4.CFrame.RightVector
              end

              local vector4 = Vector3.new(zero2.X, 0, zero2.Z)

              if vector4.Magnitude > 0 then
                local v179 = vector4.Unit * movement.bhopStrafeForce
                local assemblyLinearVelocity2 = humanoidRootPart3.AssemblyLinearVelocity

                humanoidRootPart3.AssemblyLinearVelocity = Vector3.new(assemblyLinearVelocity2.X
                  + v179.X, assemblyLinearVelocity2.Y, assemblyLinearVelocity2.Z
                  + v179.Z)
              end
            end
          end

          return
        end
      end
    end
  end)
end

local function f43()
  if connect2 then
    pcall(function() connect2:Disconnect() end)
    connect2 = nil
  end
end

local v180 = 0

local connect3 = runService.RenderStepped:Connect(function()
  local v181 = f25("BloomEffect", "Bloom")

  if v181 then
    v181.Enabled = world.bloomEnabled

    if world.bloomEnabled then
      v181.Intensity = world.bloomIntensity
      v181.Size = world.bloomSize
      v181.Threshold = world.bloomThreshold
    end
  end

  pcall(v94.update)

  pcall(function()
    local characters2 = workspace:FindFirstChild("Characters")

    if not characters2 then
      return
    end

    for index22, value39 in ipairs(players:GetPlayers()) do
      if value39 ~= localPlayer then
        local findFirstChild5 = characters2:FindFirstChild(value39.Name)

        if findFirstChild5 then
          local health2 = findFirstChild5:GetAttribute("Health")
          local v182 = v101[value39.Name]

          if v182 and health2 and health2 < v182 then
            local v183 = v182 - health2
            local head2 = findFirstChild5:FindFirstChild("Head")

            if head2 and v183 > 0 then
              f30(head2.Position, v183, false)
              f29()
            end

            if misc.hitLogs and v31.lastShotTarget == value39
              and tick() - v31.lastShotTime < 1.5 then
              f7(value39, v183, head2, health2)
              v31.pendingMissCheck = false
            end
          end

          v101[value39.Name] = health2
        else
          v101[value39.Name] = nil
        end
      end
    end

    if misc.missLogs and v31.pendingMissCheck and tick() - v31.lastShotTime > 0.5 then
      f6(v31.lastShotTarget)
      v31.pendingMissCheck = false
    end
  end)

  pcall(function()
    local currentCamera5 = workspace.CurrentCamera

    if currentCamera5 then
      if world.customFov and world.fovValue then
        currentCamera5.FieldOfView = world.fovValue
      end
    end

    local v184 = f25("ColorCorrectionEffect", "CC")

    if v184 then
      v184.Enabled = world.colorCorrectionEnabled

      if world.colorCorrectionEnabled then
        v184.Brightness = world.ccBrightness
        v184.Contrast = world.ccContrast
        v184.Saturation = world.ccSaturation
        v184.TintColor = f23(world.ccTintColor)
      end
    end

    local v185 = f25("SunRaysEffect", "SunRays")

    if v185 then
      v185.Enabled = world.sunRaysEnabled

      if world.sunRaysEnabled then
        v185.Intensity = world.sunRaysIntensity
        v185.Spread = world.sunRaysSpread
      end
    end

    local v186 = f25("BlurEffect", "MotionBlur")

    if v186 then
      v186.Enabled = world.motionBlurEnabled

      if world.motionBlurEnabled then
        v186.Size = world.motionBlurStrength * 24
      end
    end

    if world.thirdPerson and localPlayer then
      local v187 = math.clamp(world.thirdPersonDist or 10, 5, 50)

      localPlayer.CameraMode = Enum.CameraMode.Classic
      localPlayer.CameraMaxZoomDistance = v187
      localPlayer.CameraMinZoomDistance = v187
    end

    if world.fullbright then
      lighting.Brightness = 3
      lighting.ClockTime = 14
      lighting.GlobalShadows = false
      lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    end

    if world.noFog then
      lighting.FogEnd = 1000000
    end

    if world.clockTimeEnabled then
      lighting.ClockTime = world.clockTime
    end

    if world.brightnessEnabled then
      lighting.Brightness = world.brightness
    end

    if world.ambientEnabled then
      lighting.Ambient = f23(world.ambientColor)
    end

    if world.outdoorAmbientEnabled then
      lighting.OutdoorAmbient = f23(world.outdoorAmbientColor)
    end

    if world.cameraDistanceEnabled and localPlayer then
      localPlayer.CameraMaxZoomDistance = world.cameraDistance
    end

    if tick() - v180 > 2 then
      v180 = tick()
    end
  end)
end)

task.spawn(function()
  while task.wait(1) do
    if not world.noTextures then
    else
      pcall(function()
        for index23, value40 in ipairs(workspace:GetDescendants()) do
          if value40:IsA("BasePart") and value40.Material ~= Enum.Material.SmoothPlastic then
            value40.Material = Enum.Material.SmoothPlastic
          end
        end
      end)
    end
  end
end)

task.spawn(function()
  while task.wait(1) do
    if not world.noParticles then
    else
      pcall(function()
        for index24, value41 in ipairs(workspace:GetDescendants()) do
          if value41:IsA("ParticleEmitter") or value41:IsA("Fire") or value41:IsA("Smoke")
            or value41:IsA("Sparkles") then
            value41.Enabled = false
          end
        end
      end)
    end
  end
end)

task.spawn(function()
  while task.wait(1) do
    if not world.removeGrass then
    else
      pcall(function()
        for index25, value42 in ipairs(workspace:GetDescendants()) do
          if value42:IsA("BasePart") and value42.Material == Enum.Material.Grass then
            value42.Material = Enum.Material.SmoothPlastic
          end
        end
      end)
    end
  end
end)

local function f44()
  local v188 = { "None" }

  for index26, value43 in ipairs(players:GetPlayers()) do
    if value43 ~= localPlayer then
      table.insert(v188, value43.Name)
    end
  end

  return v188
end

local skinChangerAddTab = nevertiveWindow:AddTab({ Icon = "shirt", Name = "Skin Changer" })
local visualsAddTab = nevertiveWindow:AddTab({ Icon = "eye", Name = "Visuals" })
local rageBotAddTab = nevertiveWindow:AddTab({ Icon = "crosshairs", Name = "RageBot" })
local gunModsAddTab = nevertiveWindow:AddTab({ Icon = "pencil", Name = "Gun Mods" })
local movementAddTab = nevertiveWindow:AddTab({ Icon = "person-running", Name = "Movement" })
local worldAddTab = nevertiveWindow:AddTab({ Icon = "globe-detailed", Name = "World" })
local miscAddTab = nevertiveWindow:AddTab({ Icon = "house", Name = "Misc" })

local bunnyHOPAddSection = movementAddTab:AddSection({ Name = "BUNNY HOP" })

bunnyHOPAddSection:AddLabel("Enable BHop"):AddToggle({
  Default = movement.bhop,
  Flag = "BhopEnabled",
  Callback = function(value44)
    movement.bhop = value44

    if value44 then
      f42()
    else
      f43()
    end
  end,
})

bunnyHOPAddSection:AddLabel("Auto Jump"):AddToggle({
  Default = movement.bhopAutoJump,
  Flag = "BhopAutoJump",
  Callback = function(value45) movement.bhopAutoJump = value45 end,
})

bunnyHOPAddSection:AddLabel("Auto Strafe"):AddToggle({
  Default = movement.bhopAutoStrafe,
  Flag = "BhopAutoStrafe",
  Callback = function(value46) movement.bhopAutoStrafe = value46 end,
})

bunnyHOPAddSection:AddLabel("Strafe Force"):AddSlider({
  Default = movement.bhopStrafeForce,
  Min = 0.5,
  Max = 10,
  Rounding = 1,
  Flag = "BhopStrafeForce",
  Callback = function(value47) movement.bhopStrafeForce = value47 end,
})

bunnyHOPAddSection:AddLabel("Min Speed"):AddSlider({
  Default = movement.bhopMinSpeed,
  Min = 0,
  Max = 50,
  Rounding = 0,
  Flag = "BhopMinSpeed",
  Callback = function(value48) movement.bhopMinSpeed = value48 end,
})

bunnyHOPAddSection:AddLabel("BHop Mode"):AddDropdown({
  Default = "Legit",
  Values = { "Legit", "Rage" },
  Flag = "BhopMode",
  Callback = function(value49) movement.bhopMode = value49 end,
})

bunnyHOPAddSection:AddLabel("Teleport Boost"):AddToggle({
  Default = movement.bhopTeleport ~= false,
  Flag = "BhopTeleport",
  Callback = function(value50) movement.bhopTeleport = value50 end,
})

bunnyHOPAddSection:AddLabel("Teleport Distance"):AddSlider({
  Default = movement.bhopTeleportDist or 0.18,
  Min = 0.05,
  Max = 1,
  Rounding = 2,
  Flag = "BhopTeleportDist",
  Callback = function(value51) movement.bhopTeleportDist = value51 end,
})

local weaponSKINSAddSection = skinChangerAddTab:AddSection({ Name = "WEAPON SKINS" })

weaponSKINSAddSection:AddLabel("Enable Skins"):AddToggle({
  Default = v39.enabled,
  Flag = "SkinsEnabled",
  Callback = function(value52)
    v39.enabled = value52
    pcall(v147.sync)
  end,
})

weaponSKINSAddSection:AddLabel("Apply To Others"):AddToggle({
  Default = v39.applyOthers,
  Flag = "ApplyOthers",
  Callback = function(value53) v39.applyOthers = value53 end,
})

weaponSKINSAddSection:AddLabel("Factory New"):AddToggle({
  Default = v39.factoryNew,
  Flag = "FactoryNew",
  Callback = function(value54) v39.factoryNew = value54 end,
})

weaponSKINSAddSection:AddLabel("StatTrak"):AddToggle({
  Default = v39.statTrak,
  Flag = "StatTrak",
  Callback = function(value55) v39.statTrak = value55 end,
})

local knifeModel2 = weaponSKINSAddSection:AddLabel("Knife Model")
local knifeModel3 = v39.knifeModel or "None"

local function f45()
  local v189 = { "None" }

  for index27, value56 in ipairs(v54) do
    if f13(value56) == "Knives" then
      table.insert(v189, value56)
    end
  end

  return v189
end

knifeModel2:AddDropdown({
  Default = knifeModel3,
  Values = f45(),
  Flag = "KnifeModel",
  Callback = function(value57) v39.knifeModel = value57 == "None" and nil or value57 end,
})

local gloveModel = weaponSKINSAddSection:AddLabel("Glove Model")
local gloveModel2 = v39.gloveModel or "None"

local function f46()
  local v190 = { "None" }

  for index28, value58 in ipairs(v54) do
    if f13(value58) == "Gloves" then
      table.insert(v190, value58)
    end
  end

  return v190
end

gloveModel:AddDropdown({
  Default = gloveModel2,
  Values = f46(),
  Flag = "GloveModel",
  Callback = function(value59) v39.gloveModel = value59 == "None" and nil or value59 end,
})

local selectWEAPONAddSection = skinChangerAddTab:AddSection({ Name = "SELECT WEAPON" })
local skinCategory = "All"
local skinWeapon = "None"

local function f47(p103)
  local v191 = { "Stock" }

  if p103 and p103 ~= "None" then
    for index29, value60 in ipairs(f17(p103)) do
      table.insert(v191, value60.name)
    end
  end

  return v191
end

local function f48()
  local v192 = {}

  for index30, value61 in ipairs(v54) do
    if skinCategory == "All" or f13(value61) == skinCategory then
      table.insert(v192, value61)
    end
  end

  return v192
end

local addDropdown

selectWEAPONAddSection:AddLabel("Category"):AddDropdown({
  Default = "All",
  Values = v43,
  Flag = "SkinCategory",
  Callback = function(value62)
    skinCategory = value62

    pcall(function()
      if addDropdown and addDropdown.SetValues then
        addDropdown:SetValues(f48())
      end
    end)
  end,
})

local weapon = selectWEAPONAddSection:AddLabel("Weapon")

local function f49()
  local v193 = { "None" }

  for index31, value63 in ipairs(v54) do
    table.insert(v193, value63)
  end

  return v193
end

addDropdown = weapon:AddDropdown({
  Default = "None",
  Values = f49(),
  Flag = "SkinWeapon",
  Callback = function(value64)
    skinWeapon = value64

    if value64 == "None" then
      return
    end

    v7447 = f47(value64)
  end,
})

selectWEAPONAddSection:AddLabel("Skin"):AddDropdown({
  Default = "Stock",
  Values = { "Stock" },
  Flag = "SkinValue",
  Callback = function(value65)
    local v194 = skinWeapon

    if not v194 or v194 == "None" then
      f5("Nevertive", "Select gun")
      return
    end

    v39.skins[v194] = value65

    if f14(v194) then
      v39.knifeModel = v194
    end

    if f15(v194) then
      v39.gloveModel = v194
    end

    pcall(v147.sync)
    f5("Nevertive", v194 .. " → " .. value65)
  end,
})

weaponSKINSAddSection:AddButton({
  Icon = "trash",
  Name = "Reset Current Weapon",
  Callback = function()
    local v195 = skinWeapon

    if not v195 or v195 == "None" then
      f5("Nevertive", "Gun not select")
      return
    end

    v39.skins[v195] = nil

    if v39.knifeModel == v195 then
      v39.knifeModel = nil
    end

    if v39.gloveModel == v195 then
      v39.gloveModel = nil
    end

    f5("Nevertive", "Reset: " .. v195)
  end,
})

local espAddSection = visualsAddTab:AddSection({ Name = "ESP" })

espAddSection:AddLabel("Enable ESP"):AddToggle({
  Default = esp.enabled,
  Flag = "EspEnabled",
  Callback = function(value66) esp.enabled = value66 end,
})

espAddSection:AddLabel("Highlights"):AddToggle({
  Default = esp.highlights,
  Flag = "EspHighlights",
  Callback = function(value67) esp.highlights = value67 end,
})

espAddSection:AddLabel("Boxes"):AddToggle({
  Default = esp.boxes,
  Flag = "EspBoxes",
  Callback = function(value68) esp.boxes = value68 end,
})

espAddSection:AddLabel("Skeleton"):AddToggle({
  Default = esp.skeleton,
  Flag = "EspSkeleton",
  Callback = function(value69) esp.skeleton = value69 end,
})

espAddSection:AddLabel("Names"):AddToggle({
  Default = esp.names,
  Flag = "EspNames",
  Callback = function(value70) esp.names = value70 end,
})

espAddSection:AddLabel("Health Bar"):AddToggle({
  Default = esp.health,
  Flag = "EspHealth",
  Callback = function(value71) esp.health = value71 end,
})

espAddSection:AddLabel("Distance"):AddToggle({
  Default = esp.distance,
  Flag = "EspDistance",
  Callback = function(value72) esp.distance = value72 end,
})

espAddSection:AddLabel("Weapon"):AddToggle({
  Default = esp.weapon,
  Flag = "EspWeapon",
  Callback = function(value73) esp.weapon = value73 end,
})

espAddSection:AddLabel("Tracers"):AddToggle({
  Default = esp.tracers,
  Flag = "EspTracers",
  Callback = function(value74) esp.tracers = value74 end,
})

espAddSection:AddLabel("Look Vector"):AddToggle({
  Default = esp.lookVector,
  Flag = "EspLookVector",
  Callback = function(value75) esp.lookVector = value75 end,
})

espAddSection:AddLabel("Show Team"):AddToggle({
  Default = esp.showTeam,
  Flag = "EspShowTeam",
  Callback = function(value76) esp.showTeam = value76 end,
})

espAddSection:AddLabel("Team Check"):AddToggle({
  Default = esp.teamCheck,
  Flag = "EspTeamCheck",
  Callback = function(value77) esp.teamCheck = value77 end,
})

espAddSection:AddLabel("Chams"):AddToggle({
  Default = esp.chams,
  Flag = "EspChams",
  Callback = function(value78) esp.chams = value78 end,
})

espAddSection:AddLabel("Chams Through Walls"):AddToggle({
  Default = esp.chamsThroughWalls,
  Flag = "EspChamsWalls",
  Callback = function(value79) esp.chamsThroughWalls = value79 end,
})

espAddSection:AddLabel("Chams Mode"):AddDropdown({
  Default = "Both",
  Values = { "Fill", "Outline", "Both" },
  Flag = "EspChamsMode",
  Callback = function(value80) esp.chamsMode = value80 end,
})

espAddSection:AddLabel("Chams Style"):AddDropdown({
  Default = "Solid",
  Values = { "Solid", "Pulse", "Rainbow", "Gradient", "Wireframe", "Distance" },
  Flag = "EspChamsStyle",
  Callback = function(value81) esp.chamsStyle = value81 end,
})

espAddSection:AddLabel("Chams Pulse Speed"):AddSlider({
  Default = esp.chamsPulseSpeed or 3,
  Min = 0.5,
  Max = 10,
  Rounding = 1,
  Flag = "EspChamsPulseSpeed",
  Callback = function(value82) esp.chamsPulseSpeed = value82 end,
})

espAddSection:AddLabel("Chams Gradient Speed"):AddSlider({
  Default = esp.chamsGradientSpeed or 2,
  Min = 0.1,
  Max = 10,
  Rounding = 1,
  Flag = "EspChamsGradientSpeed",
  Callback = function(value83) esp.chamsGradientSpeed = value83 end,
})

espAddSection:AddLabel("Chams Dist Near"):AddSlider({
  Default = esp.chamsDistanceNear or 100,
  Min = 0,
  Max = 1000,
  Rounding = 0,
  Flag = "EspChamsDistNear",
  Callback = function(value84) esp.chamsDistanceNear = value84 end,
})

espAddSection:AddLabel("Chams Dist Far"):AddSlider({
  Default = esp.chamsDistanceFar or 1500,
  Min = 500,
  Max = 5000,
  Rounding = 0,
  Flag = "EspChamsDistFar",
  Callback = function(value85) esp.chamsDistanceFar = value85 end,
})

espAddSection:AddLabel("Hit Marker"):AddToggle({
  Default = aim.hitMarker,
  Flag = "AimHitMarker",
  Callback = function(value86) aim.hitMarker = value86 end,
})

espAddSection:AddLabel("Damage Numbers"):AddToggle({
  Default = aim.damageNumbers,
  Flag = "AimDamageNumbers",
  Callback = function(value87) aim.damageNumbers = value87 end,
})

espAddSection:AddLabel("Custom Scope"):AddToggle({
  Default = aim.customScope,
  Flag = "AimCustomScope",
  Callback = function(value88) aim.customScope = value88 end,
})

espAddSection:AddLabel("Scope Size"):AddSlider({
  Default = aim.scopeSize,
  Min = 5,
  Max = 60,
  Rounding = 0,
  Flag = "AimScopeSize",
  Callback = function(value89) aim.scopeSize = value89 end,
})

espAddSection:AddLabel("Scope Gap"):AddSlider({
  Default = aim.scopeGap,
  Min = 0,
  Max = 20,
  Rounding = 0,
  Flag = "AimScopeGap",
  Callback = function(value90) aim.scopeGap = value90 end,
})

espAddSection:AddLabel("Scope Thickness"):AddSlider({
  Default = aim.scopeThickness,
  Min = 1,
  Max = 5,
  Rounding = 0,
  Flag = "AimScopeThickness",
  Callback = function(value91) aim.scopeThickness = value91 end,
})

espAddSection:AddLabel("Scope Dot"):AddToggle({
  Default = aim.scopeDot,
  Flag = "AimScopeDot",
  Callback = function(value92) aim.scopeDot = value92 end,
})

espAddSection:AddLabel("Corner Box"):AddToggle({
  Default = esp.cornerBox,
  Flag = "EspCornerBox",
  Callback = function(value93) esp.cornerBox = value93 end,
})

espAddSection:AddLabel("Head Dot"):AddToggle({
  Default = esp.headDot,
  Flag = "EspHeadDot",
  Callback = function(value94) esp.headDot = value94 end,
})

espAddSection:AddLabel("Aimline"):AddToggle({
  Default = esp.aimline,
  Flag = "EspAimline",
  Callback = function(value95) esp.aimline = value95 end,
})

espAddSection:AddLabel("Box Thickness"):AddSlider({
  Default = esp.boxThickness,
  Min = 0.5,
  Max = 5,
  Rounding = 1,
  Flag = "EspBoxThickness",
  Callback = function(value96) esp.boxThickness = value96 end,
})

espAddSection:AddLabel("Skeleton Thickness"):AddSlider({
  Default = esp.skeletonThickness,
  Min = 0.5,
  Max = 5,
  Rounding = 1,
  Flag = "EspSkelThickness",
  Callback = function(value97) esp.skeletonThickness = value97 end,
})

espAddSection:AddLabel("Chams Fill Transparency"):AddSlider({
  Default = esp.chamsFillTransparency,
  Min = 0,
  Max = 1,
  Rounding = 2,
  Flag = "EspChamsFill",
  Callback = function(value98) esp.chamsFillTransparency = value98 end,
})

espAddSection:AddLabel("Head Dot Size"):AddSlider({
  Default = esp.headDotSize,
  Min = 2,
  Max = 20,
  Rounding = 0,
  Flag = "EspHeadDotSize",
  Callback = function(value99) esp.headDotSize = value99 end,
})

espAddSection:AddLabel("Max Distance"):AddSlider({
  Default = esp.maxDist,
  Min = 200,
  Max = 5000,
  Rounding = 0,
  Flag = "EspMaxDist",
  Callback = function(value100) esp.maxDist = value100 end,
})

local arrowESPAddSection = visualsAddTab:AddSection({ Name = "ARROW ESP" })

arrowESPAddSection:AddLabel("Enable Arrows"):AddToggle({
  Default = esp.arrows,
  Flag = "EspArrows",
  Callback = function(value101) esp.arrows = value101 end,
})

arrowESPAddSection:AddLabel("Arrow Style"):AddDropdown({
  Default = "Triangle",
  Values = { "Triangle", "Chevron", "Circle", "Glow", "Line" },
  Flag = "EspArrowStyle",
  Callback = function(value102) esp.arrowStyle = value102 end,
})

arrowESPAddSection:AddLabel("Arrow Glow"):AddToggle({
  Default = esp.arrowGlow ~= false,
  Flag = "EspArrowGlow",
  Callback = function(value103) esp.arrowGlow = value103 end,
})

arrowESPAddSection:AddLabel("Arrow Pulse"):AddToggle({
  Default = esp.arrowPulse,
  Flag = "EspArrowPulse",
  Callback = function(value104) esp.arrowPulse = value104 end,
})

arrowESPAddSection:AddLabel("Arrow Size"):AddSlider({
  Default = esp.arrowSize,
  Min = 5,
  Max = 40,
  Rounding = 0,
  Flag = "EspArrowSize",
  Callback = function(value105) esp.arrowSize = value105 end,
})

arrowESPAddSection:AddLabel("Arrow Radius"):AddSlider({
  Default = esp.arrowRadius,
  Min = 50,
  Max = 600,
  Rounding = 0,
  Flag = "EspArrowRadius",
  Callback = function(value106) esp.arrowRadius = value106 end,
})

arrowESPAddSection:AddLabel("Show Distance"):AddToggle({
  Default = esp.arrowShowDistance,
  Flag = "EspArrowDist",
  Callback = function(value107) esp.arrowShowDistance = value107 end,
})

arrowESPAddSection:AddLabel("Arrow Outline"):AddToggle({
  Default = esp.arrowOutline,
  Flag = "EspArrowOutline",
  Callback = function(value108) esp.arrowOutline = value108 end,
})

local colorsAddSection = visualsAddTab:AddSection({ Name = "COLORS" })

colorsAddSection:AddLabel("Enemy Color"):AddColorPicker({
  Default = f23(esp.enemyColor),
  Flag = "EspEnemyColor",
  Callback = function(value109)
    esp.enemyColor = {
      r = math.floor(value109.R * 255),
      g = math.floor(value109.G * 255),
      b = math.floor(value109.B * 255),
    }
  end,
})

colorsAddSection:AddLabel("Team Color"):AddColorPicker({
  Default = f23(esp.teamColor),
  Flag = "EspTeamColor",
  Callback = function(value110)
    esp.teamColor = {
      r = math.floor(value110.R * 255),
      g = math.floor(value110.G * 255),
      b = math.floor(value110.B * 255),
    }
  end,
})

colorsAddSection:AddLabel("Highlight Color"):AddColorPicker({
  Default = f23(esp.hlColor),
  Flag = "EspHlColor",
  Callback = function(value111)
    esp.hlColor = {
      r = math.floor(value111.R * 255),
      g = math.floor(value111.G * 255),
      b = math.floor(value111.B * 255),
    }
  end,
})

colorsAddSection:AddLabel("Name Color"):AddColorPicker({
  Default = f23(esp.nameColor),
  Flag = "EspNameColor",
  Callback = function(value112)
    esp.nameColor = {
      r = math.floor(value112.R * 255),
      g = math.floor(value112.G * 255),
      b = math.floor(value112.B * 255),
    }
  end,
})

colorsAddSection:AddLabel("HP Color"):AddColorPicker({
  Default = f23(esp.hpColor),
  Flag = "EspHpColor",
  Callback = function(value113)
    esp.hpColor = {
      r = math.floor(value113.R * 255),
      g = math.floor(value113.G * 255),
      b = math.floor(value113.B * 255),
    }
  end,
})

colorsAddSection:AddLabel("Skeleton Color"):AddColorPicker({
  Default = f23(esp.skeletonColor),
  Flag = "EspSkelColor",
  Callback = function(value114)
    esp.skeletonColor = {
      r = math.floor(value114.R * 255),
      g = math.floor(value114.G * 255),
      b = math.floor(value114.B * 255),
    }
  end,
})

colorsAddSection:AddLabel("Tracer Color"):AddColorPicker({
  Default = f23(esp.tracerColor),
  Flag = "EspTracerColor",
  Callback = function(value115)
    esp.tracerColor = {
      r = math.floor(value115.R * 255),
      g = math.floor(value115.G * 255),
      b = math.floor(value115.B * 255),
    }
  end,
})

colorsAddSection:AddLabel("Look Vector Color"):AddColorPicker({
  Default = f23(esp.lookVectorColor),
  Flag = "EspLvColor",
  Callback = function(value116)
    esp.lookVectorColor = {
      r = math.floor(value116.R * 255),
      g = math.floor(value116.G * 255),
      b = math.floor(value116.B * 255),
    }
  end,
})

colorsAddSection:AddLabel("Chams Color"):AddColorPicker({
  Default = f23(esp.chamsColor),
  Flag = "EspChamsColor",
  Callback = function(value117)
    esp.chamsColor = {
      r = math.floor(value117.R * 255),
      g = math.floor(value117.G * 255),
      b = math.floor(value117.B * 255),
    }
  end,
})

colorsAddSection:AddLabel("Head Dot Color"):AddColorPicker({
  Default = f23(esp.headDotColor),
  Flag = "EspHeadDotColor",
  Callback = function(value118)
    esp.headDotColor = {
      r = math.floor(value118.R * 255),
      g = math.floor(value118.G * 255),
      b = math.floor(value118.B * 255),
    }
  end,
})

colorsAddSection:AddLabel("Aimline Color"):AddColorPicker({
  Default = f23(esp.aimlineColor),
  Flag = "EspAimlineColor",
  Callback = function(value119)
    esp.aimlineColor = {
      r = math.floor(value119.R * 255),
      g = math.floor(value119.G * 255),
      b = math.floor(value119.B * 255),
    }
  end,
})

colorsAddSection:AddLabel("Scope Color"):AddColorPicker({
  Default = f23(aim.scopeColor),
  Flag = "AimScopeColor",
  Callback = function(value120)
    aim.scopeColor = {
      r = math.floor(value120.R * 255),
      g = math.floor(value120.G * 255),
      b = math.floor(value120.B * 255),
    }
  end,
})

colorsAddSection:AddLabel("Arrow Enemy Color"):AddColorPicker({
  Default = f23(esp.arrowColor),
  Flag = "EspArrowColor",
  Callback = function(value121)
    esp.arrowColor = {
      r = math.floor(value121.R * 255),
      g = math.floor(value121.G * 255),
      b = math.floor(value121.B * 255),
    }
  end,
})

colorsAddSection:AddLabel("Arrow Team Color"):AddColorPicker({
  Default = f23(esp.arrowTeamColor),
  Flag = "EspArrowTeamColor",
  Callback = function(value122)
    esp.arrowTeamColor = {
      r = math.floor(value122.R * 255),
      g = math.floor(value122.G * 255),
      b = math.floor(value122.B * 255),
    }
  end,
})

local postEFFECTSAddSection = visualsAddTab:AddSection({ Name = "POST EFFECTS" })

postEFFECTSAddSection:AddLabel("Bloom"):AddToggle({
  Default = world.bloomEnabled,
  Flag = "VisBloomEnabled",
  Callback = function(value123) world.bloomEnabled = value123 end,
})

postEFFECTSAddSection:AddLabel("Bloom Intensity"):AddSlider({
  Default = world.bloomIntensity,
  Min = 0,
  Max = 5,
  Rounding = 1,
  Flag = "VisBloomIntensity",
  Callback = function(value124) world.bloomIntensity = value124 end,
})

postEFFECTSAddSection:AddLabel("Bloom Size"):AddSlider({
  Default = world.bloomSize,
  Min = 1,
  Max = 100,
  Rounding = 0,
  Flag = "VisBloomSize",
  Callback = function(value125) world.bloomSize = value125 end,
})

postEFFECTSAddSection:AddLabel("Bloom Threshold"):AddSlider({
  Default = world.bloomThreshold,
  Min = 0,
  Max = 2,
  Rounding = 2,
  Flag = "VisBloomThreshold",
  Callback = function(value126) world.bloomThreshold = value126 end,
})

postEFFECTSAddSection:AddLabel("Color Correction"):AddToggle({
  Default = world.colorCorrectionEnabled,
  Flag = "VisCCEnabled",
  Callback = function(value127) world.colorCorrectionEnabled = value127 end,
})

postEFFECTSAddSection:AddLabel("CC Brightness"):AddSlider({
  Default = world.ccBrightness,
  Min = -1,
  Max = 1,
  Rounding = 2,
  Flag = "VisCCBrightness",
  Callback = function(value128) world.ccBrightness = value128 end,
})

postEFFECTSAddSection:AddLabel("CC Contrast"):AddSlider({
  Default = world.ccContrast,
  Min = -1,
  Max = 1,
  Rounding = 2,
  Flag = "VisCCContrast",
  Callback = function(value129) world.ccContrast = value129 end,
})

postEFFECTSAddSection:AddLabel("CC Saturation"):AddSlider({
  Default = world.ccSaturation,
  Min = -1,
  Max = 1,
  Rounding = 2,
  Flag = "VisCCSaturation",
  Callback = function(value130) world.ccSaturation = value130 end,
})

postEFFECTSAddSection:AddLabel("CC Tint"):AddColorPicker({
  Default = f23(world.ccTintColor),
  Flag = "VisCCTint",
  Callback = function(value131)
    world.ccTintColor = {
      r = math.floor(value131.R * 255),
      g = math.floor(value131.G * 255),
      b = math.floor(value131.B * 255),
    }
  end,
})

postEFFECTSAddSection:AddLabel("Sun Rays"):AddToggle({
  Default = world.sunRaysEnabled,
  Flag = "VisSunRaysEnabled",
  Callback = function(value132) world.sunRaysEnabled = value132 end,
})

postEFFECTSAddSection:AddLabel("Sun Rays Intensity"):AddSlider({
  Default = world.sunRaysIntensity,
  Min = 0,
  Max = 1,
  Rounding = 2,
  Flag = "VisSunRaysIntensity",
  Callback = function(value133) world.sunRaysIntensity = value133 end,
})

postEFFECTSAddSection:AddLabel("Sun Rays Spread"):AddSlider({
  Default = world.sunRaysSpread,
  Min = 0,
  Max = 5,
  Rounding = 1,
  Flag = "VisSunRaysSpread",
  Callback = function(value134) world.sunRaysSpread = value134 end,
})

postEFFECTSAddSection:AddLabel("Motion Blur"):AddToggle({
  Default = world.motionBlurEnabled,
  Flag = "VisMBEnabled",
  Callback = function(value135) world.motionBlurEnabled = value135 end,
})

postEFFECTSAddSection:AddLabel("Motion Blur Strength"):AddSlider({
  Default = world.motionBlurStrength,
  Min = 0,
  Max = 5,
  Rounding = 1,
  Flag = "VisMBStrength",
  Callback = function(value136) world.motionBlurStrength = value136 end,
})

local silentAIMAddSection = rageBotAddTab:AddSection({ Name = "SILENT AIM" })

silentAIMAddSection:AddLabel("Enable Silent Aim"):AddToggle({
  Default = aim.enabled,
  Flag = "AimEnabled",
  Callback = function(value137) aim.enabled = value137 end,
})

silentAIMAddSection:AddLabel("FOV Circle"):AddToggle({
  Default = aim.fovCircle,
  Flag = "AimFovCircle",
  Callback = function(value138) aim.fovCircle = value138 end,
})

silentAIMAddSection:AddLabel("Visible Check"):AddToggle({
  Default = aim.visibleCheck,
  Flag = "AimVisibleCheck",
  Callback = function(value139) aim.visibleCheck = value139 end,
})

silentAIMAddSection:AddLabel("Wallbang"):AddToggle({
  Default = aim.wallbang,
  Flag = "AimWallbang",
  Callback = function(value140)
    aim.wallbang = value140
    v123 = 0
    v7779 = value140 and aim.wallbangMode == "All"
  end,
})

silentAIMAddSection:AddLabel("Silent 360"):AddToggle({
  Default = aim.silent360,
  Flag = "AimSilent360",
  Callback = function(value141) aim.silent360 = value141 end,
})

silentAIMAddSection:AddLabel("Aim Mode"):AddDropdown({
  Default = "Silent",
  Values = { "None", "Silent", "Camera", "Snap" },
  Flag = "AimAimMode",
  Callback = function(value142) aim.aimMode = value142 end,
})

silentAIMAddSection:AddLabel("Wallbang Mode"):AddDropdown({
  Default = "Some",
  Values = { "None", "Some", "Much", "All" },
  Flag = "AimWallbangMode",
  Callback = function(value143)
    aim.wallbangMode = value143
    v123 = 0
  end,
})

silentAIMAddSection:AddLabel("Target Mode"):AddDropdown({
  Default = aim.targetMode or "FOV",
  Values = { "FOV", "Nearest", "LowestHP", "HighestHP" },
  Flag = "AimTargetMode",
  Callback = function(value144) aim.targetMode = value144 end,
})

silentAIMAddSection:AddLabel("Hit Part"):AddDropdown({
  Default = "Head",
  Values = { "Head", "Closest", "Nearest", "Nearest3D", "Custom" },
  Flag = "AimPart",
  Callback = function(value145) aim.part = value145 end,
})

silentAIMAddSection:AddLabel("Custom: Head"):AddToggle({
  Default = aim.targetHead,
  Flag = "AimTargetHead",
  Callback = function(value146) aim.targetHead = value146 end,
})

silentAIMAddSection:AddLabel("Custom: Torso"):AddToggle({
  Default = aim.targetTorso,
  Flag = "AimTargetTorso",
  Callback = function(value147) aim.targetTorso = value147 end,
})

local v196, v197

silentAIMAddSection:AddLabel("Custom: Arms"):AddToggle({
  Default = false,
  Flag = "AimTargetArms",
  Callback = function()
    local v198

    if v198 then
      for key19, value148 in pairs(f10) do
        v196[v197[5]](value148)
      end
    end

    if not aim.enabled then
      for key20, value149 in pairs(v196[v197[6]]) do
        v196[v197[7]](value149)
      end

      for key21, value150 in pairs(v196[v197[8]]) do
        value150:Destroy()
        v196[v197[8]][key21] = nil
      end

      return
    else
      local v199 = v196[v197[9]]

      local characters3 = v199
      characters3 = v199 or workspace:FindFirstChild("Characters")

      v196[v197[9]] = characters3

      if not v196[v197[9]] then
        return
      else
        local currentCamera6 = workspace.CurrentCamera
        local viewportSize = currentCamera6.ViewportSize
        local position3 = currentCamera6.CFrame.Position
        local team = v196[v197[10]]:GetAttribute("Team")

        for index32, value151 in ipairs(v196[v197[11]]:GetPlayers()) do
          if value151 ~= v196[v197[10]]
            and (team == nil or value151:GetAttribute("Team") ~= team) then
            local v200 = v196[v197[6]][value151]

            local v201 = v200
            v201 = v200 or v196[v197[12]]()

            v196[v197[6]][value151] = v201
            local findFirstChild6 = v196[v197[9]]:FindFirstChild(value151.Name)

            local humanoidRootPart4 = findFirstChild6

            humanoidRootPart4 = findFirstChild6
              and findFirstChild6:FindFirstChild("HumanoidRootPart")

            local head3 = findFirstChild6
            head3 = findFirstChild6 and findFirstChild6:FindFirstChild("Head")

            local health3 = findFirstChild6
            health3 = findFirstChild6 and findFirstChild6:GetAttribute("Health")

            local maxHealth2 = findFirstChild6 and findFirstChild6:GetAttribute("MaxHealth")
              or 100

            local v202 = not humanoidRootPart4 or findFirstChild6:GetAttribute("Dead") == true
              or health3 ~= nil and health3 <= 0

            local team2 = value151:GetAttribute("Team")
            local v203 = team ~= nil and team2 == team
            local v204 = not v202

            local showTeam = v204
            showTeam = v204 and (aim.showTeam or not v203)

            if aim.teamCheck and v203 then
              showTeam = false
            end

            local magnitude2 = showTeam and (humanoidRootPart4.Position - position3).Magnitude
              or 0

            if showTeam and magnitude2 > aim.maxDist then
              showTeam = false
            end

            local v205 = nil
            local v206 = nil
            local v207 = nil
            local v208 = nil

            if showTeam then
              v207, v205, v206, v208 = v196[v197[13]](
                findFirstChild6, humanoidRootPart4, currentCamera6
              )

              if not v207 then
                showTeam = false
              end
            end

            v196[v197[14]](value151, findFirstChild6, showTeam)
            v196[v197[15]](value151, findFirstChild6, showTeam, magnitude2)

            pcall(
              v196[v197[16]], value151, findFirstChild6, humanoidRootPart4, currentCamera6,
              viewportSize, team, aim
            )

            if not showTeam then
              v196[v197[7]](v201)
            else
              local v209 = v203
              v209 = v203 and v196[v197[17]](aim.teamColor)

              local color = v209
              color = v209 or v196[v197[17]](aim.enemyColor)

              local v210 = v206 - v207
              local v211 = v208 - v205

              local boxO = v201.boxO
              boxO.Visible = aim.boxes and not aim.cornerBox

              local box = v201.box
              box.Visible = aim.boxes and not aim.cornerBox

              if aim.boxes and not aim.cornerBox then
                v201.boxO.Position = Vector2.new(v207, v205)
                v201.boxO.Size = Vector2.new(v210, v211)
                v201.boxO.Thickness = (aim.boxThickness or 1.5) + 2
                v201.box.Position = Vector2.new(v207, v205)
                v201.box.Size = Vector2.new(v210, v211)
                v201.box.Thickness = aim.boxThickness or 1.5
                v201.box.Color = color
              end

              v201.name.Visible = aim.names

              if aim.names then
                v201.name.Text = value151.DisplayName
                v201.name.Color = v196[v197[17]](aim.nameColor)
                v201.name.Position = Vector2.new(v207 + v210 / 2, v205 - 16)
              end

              local v212 = {}

              if aim.distance then
                v212[#v212 + 1] = string.format("%dm", math.floor(magnitude2 / 3.57))
              end

              if aim.weapon then
                local v213 = v196[v197[18]](value151)

                if v213 then
                  v212[#v212 + 1] = v213
                end
              end

              v201.info.Visible = #v212 > 0

              if #v212 > 0 then
                v201.info.Text = table.concat(v212, " | ")

                local info = v201.info

                info.Color = aim.distance and v196[v197[17]](aim.distanceColor)
                  or aim.weapon and v196[v197[17]](aim.weaponColor) or Color3.new(1, 1, 1)

                v201.info.Position = Vector2.new(v207 + v210 / 2, v208 + 3)
              end

              v201.hpBg.Visible = aim.health
              v201.hp.Visible = aim.health

              if aim.health then
                local v214 = math.clamp((health3 or maxHealth2) / math.max(maxHealth2, 1), 0, 1)

                v201.hpBg.Position = Vector2.new(v207 - 6, v205 - 1)
                v201.hpBg.Size = Vector2.new(4, v211 + 2)
                v201.hp.Position = Vector2.new(v207 - 5, v205 + v211 * (1 - v214))
                v201.hp.Size = Vector2.new(2, v211 * v214)
                v201.hp.Color = v196[v197[17]](aim.hpColor)
              end

              v201.tracer.Visible = aim.tracers
              v201.tracerO.Visible = aim.tracers

              if aim.tracers then
                local vector5 = Vector2.new(viewportSize.X / 2, viewportSize.Y)
                local vector6 = Vector2.new(v207 + v210 / 2, v208)

                v201.tracerO.From = vector5
                v201.tracerO.To = vector6
                v201.tracer.From = vector5
                v201.tracer.To = vector6
                v201.tracer.Color = v196[v197[17]](aim.tracerColor)
              end

              v201.lookVector.Visible = aim.lookVector
              v201.lookVectorO.Visible = aim.lookVector

              if aim.lookVector and head3 then
                local cframe = head3.CFrame
                local position4 = cframe.Position
                local v215, v216 = currentCamera6:WorldToViewportPoint(position4)

                local v217, v218 = currentCamera6:WorldToViewportPoint(position4
                  + cframe.LookVector * 10)

                if v216 and v218 and v215.Z > 0 and v217.Z > 0 then
                  local vector7 = Vector2.new(v215.X, v215.Y)
                  local vector8 = Vector2.new(v217.X, v217.Y)

                  v201.lookVectorO.From = vector7
                  v201.lookVectorO.To = vector8
                  v201.lookVector.From = vector7
                  v201.lookVector.To = vector8
                  v201.lookVector.Color = v196[v197[17]](aim.lookVectorColor)
                else
                  v201.lookVector.Visible = false
                  v201.lookVectorO.Visible = false
                end
              end

              v201.headDot.Visible = aim.headDot

              if aim.headDot and head3 then
                local worldToViewportPoint = currentCamera6:WorldToViewportPoint(head3.Position)

                if worldToViewportPoint.Z > 0 then
                  v201.headDot.Position = Vector2.new(
                    worldToViewportPoint.X, worldToViewportPoint.Y
                  )

                  v201.headDot.Radius = aim.headDotSize or 6
                  v201.headDot.Color = v196[v197[17]](aim.headDotColor)
                  v201.headDot.Filled = true
                  v201.headDot.Thickness = 1
                  v201.headDot.Transparency = 1
                else
                  v201.headDot.Visible = false
                end
              end

              v201.aimline.Visible = aim.aimline

              if aim.aimline then
                v201.aimline.From = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
                v201.aimline.To = Vector2.new(v207 + v210 / 2, v205 + v211 / 2)
                v201.aimline.Color = v196[v197[17]](aim.aimlineColor)
              end

              local count4 = 0

              while true do
                count4 = 1 + count4

                if not (4 >= count4) then
                  break
                end

                v201.cornerBox[count4].Visible = false
              end

              if aim.boxes and aim.cornerBox then
                v201.boxO.Visible = false
                v201.box.Visible = false

                local v219 = math.min(v210, v211) * 0.25

                v201.cornerBox[1].From = Vector2.new(v207, v205)
                v201.cornerBox[1].To = Vector2.new(v207 + v219, v205)
                v201.cornerBox[1].Visible = true
                v201.cornerBox[1].Color = color
                v201.cornerBox[2].From = Vector2.new(v206, v205)
                v201.cornerBox[2].To = Vector2.new(v206 - v219, v205)
                v201.cornerBox[2].Visible = true
                v201.cornerBox[2].Color = color
                v201.cornerBox[3].From = Vector2.new(v207, v208)
                v201.cornerBox[3].To = Vector2.new(v207 + v219, v208)
                v201.cornerBox[3].Visible = true
                v201.cornerBox[3].Color = color
                v201.cornerBox[4].From = Vector2.new(v206, v208)
                v201.cornerBox[4].To = Vector2.new(v206 - v219, v208)
                v201.cornerBox[4].Visible = true
                v201.cornerBox[4].Color = color
              end

              for index33, value152 in ipairs(v196[v197[19]]) do
                local v220 = v201.bones[index33]

                if aim.skeleton then
                  local findFirstChild7 = findFirstChild6:FindFirstChild(value152[1])
                  local findFirstChild8 = findFirstChild6:FindFirstChild(value152[2])

                  if findFirstChild7 and findFirstChild8 then
                    local worldToViewportPoint2 = currentCamera6:WorldToViewportPoint(findFirstChild7.Position)
                    local worldToViewportPoint3 = currentCamera6:WorldToViewportPoint(findFirstChild8.Position)

                    if worldToViewportPoint2.Z > 0 and worldToViewportPoint3.Z > 0 then
                      v220.From = Vector2.new(worldToViewportPoint2.X, worldToViewportPoint2.Y)
                      v220.To = Vector2.new(worldToViewportPoint3.X, worldToViewportPoint3.Y)
                      v220.Color = v196[v197[17]](aim.skeletonColor)
                      v220.Visible = true
                    else
                      v220.Visible = false
                    end
                  else
                    v220.Visible = false
                  end
                else
                  v220.Visible = false
                end
              end
            end
          end
        end

        for key22, value153 in pairs(v196[v197[6]]) do
          if key22.Parent ~= v196[v197[11]] then
            v196[v197[20]](value153)
            v196[v197[6]][key22] = nil

            if v196[v197[8]][key22] then
              v196[v197[8]][key22]:Destroy()
              v196[v197[8]][key22] = nil
            end

            if f10[key22] then
              for key23, value154 in pairs(f10[key22]) do
              end

              f10[key22] = nil
            end
          end
        end

        return
      end
    end
  end,
})

silentAIMAddSection:AddLabel("Custom: Legs"):AddToggle({
  Default = aim.targetLegs,
  Flag = "AimTargetLegs",
  Callback = function(value155) aim.targetLegs = value155 end,
})

silentAIMAddSection:AddLabel("Priority Target"):AddToggle({
  Default = aim.priorityEnabled or false,
  Flag = "AimPriorityEnabled",
  Callback = function(value156) aim.priorityEnabled = value156 end,
})

local addDropdown2 = silentAIMAddSection:AddLabel("Priority Player"):AddDropdown({
  Default = aim.priorityTarget or "None",
  Values = f44(),
  Flag = "AimPriorityTarget",
  AutoUpdate = false,
  Callback = function(value157) aim.priorityTarget = value157 == "None" and nil or value157 end,
})

task.spawn(function()
  while task.wait(2) do
    if addDropdown2 and addDropdown2.SetValues then
      pcall(function() addDropdown2:SetValues(f44()) end)
    end
  end
end)

silentAIMAddSection:AddLabel("FOV (px)"):AddSlider({
  Default = aim.fov,
  Min = 30,
  Max = 999,
  Rounding = 10,
  Flag = "AimFov",
  Callback = function(value158) aim.fov = value158 end,
})

silentAIMAddSection:AddLabel("Auto Fire"):AddToggle({
  Default = aim.autoFire,
  Flag = "AimAutoFire",
  Callback = function(value159) aim.autoFire = value159 end,
})

silentAIMAddSection:AddLabel("Auto Fire Hold"):AddToggle({
  Default = aim.autoFireHold,
  Flag = "AimAutoFireHold",
  Callback = function(value160) aim.autoFireHold = value160 end,
})

silentAIMAddSection:AddLabel("Hit Chance (%)"):AddSlider({
  Default = aim.hitChance or 100,
  Min = 0,
  Max = 100,
  Rounding = 0,
  Flag = "AimHitChance",
  Callback = function(value161) aim.hitChance = value161 end,
})

silentAIMAddSection:AddLabel("HeadHook (any hit = head)"):AddToggle({
  Default = aim.headHookEnabled,
  Flag = "AimHeadHookEnabled",
  Callback = function(value162) aim.headHookEnabled = value162 end,
})

silentAIMAddSection:AddLabel("Min Damage"):AddSlider({
  Default = aim.minDamage or 0,
  Min = 0,
  Max = 200,
  Rounding = 0,
  Flag = "AimMinDamage",
  Callback = function(value163) aim.minDamage = value163 end,
})

silentAIMAddSection:AddLabel("MultiPoint"):AddToggle({
  Default = aim.multipointEnabled or false,
  Flag = "AimMultipointEnabled",
  Callback = function(value164) aim.multipointEnabled = value164 end,
})

silentAIMAddSection:AddLabel("MultiPoint Scale (%)"):AddSlider({
  Default = aim.multipoint or 0,
  Min = 0,
  Max = 100,
  Rounding = 0,
  Flag = "AimMultipoint",
  Callback = function(value165) aim.multipoint = value165 end,
})

silentAIMAddSection:AddLabel("Auto Fire Delay"):AddSlider({
  Default = aim.autoFireDelay,
  Min = 0.00001,
  Max = 1,
  Rounding = 2,
  Flag = "AimAutoFireDelay",
  Callback = function(value166) aim.autoFireDelay = value166 end,
})

silentAIMAddSection:AddLabel("Max Distance"):AddSlider({
  Default = aim.maxDist,
  Min = 500,
  Max = 5000,
  Rounding = 100,
  Flag = "AimMaxDist",
  Callback = function(value167) aim.maxDist = value167 end,
})

local hitboxEXPANDERAddSection = rageBotAddTab:AddSection({ Name = "HITBOX EXPANDER" })

hitboxEXPANDERAddSection:AddLabel("Enable Hitbox Expander"):AddToggle({
  Default = aim.hitboxEnabled,
  Flag = "AimHitboxEnabled",
  Callback = function(value168) aim.hitboxEnabled = value168 end,
})

hitboxEXPANDERAddSection:AddLabel("Hitbox Size"):AddSlider({
  Default = aim.hitboxSize or 2,
  Min = 1,
  Max = 10,
  Rounding = 1,
  Flag = "AimHitboxSize",
  Callback = function(value169) aim.hitboxSize = value169 end,
})

hitboxEXPANDERAddSection:AddLabel("Hitbox Transparency"):AddSlider({
  Default = aim.hitboxTransparency or 1,
  Min = 0,
  Max = 1,
  Rounding = 2,
  Flag = "AimHitboxTransparency",
  Callback = function(value170) aim.hitboxTransparency = value170 end,
})

local backtrackAddSection = rageBotAddTab:AddSection({ Name = "BACKTRACK" })

backtrackAddSection:AddLabel("Enable Backtrack"):AddToggle({
  Default = aim.backtrackEnabled,
  Flag = "AimBacktrackEnabled",
  Callback = function(value171) aim.backtrackEnabled = value171 end,
})

backtrackAddSection:AddLabel("Backtrack Time (sec)"):AddSlider({
  Default = aim.backtrackTime or 0.2,
  Min = 0.05,
  Max = 0.5,
  Rounding = 2,
  Flag = "AimBacktrackTime",
  Callback = function(value172) aim.backtrackTime = value172 end,
})

local colorsAddSection2 = rageBotAddTab:AddSection({ Name = "COLORS" })

colorsAddSection2:AddLabel("FOV Base Color"):AddColorPicker({
  Default = f23(aim.fovBaseColor),
  Flag = "AimFovBase",
  Callback = function(value173)
    aim.fovBaseColor = {
      r = math.floor(value173.R * 255),
      g = math.floor(value173.G * 255),
      b = math.floor(value173.B * 255),
    }
  end,
})

colorsAddSection2:AddLabel("FOV Target Color"):AddColorPicker({
  Default = f23(aim.fovTargetColor),
  Flag = "AimFovTarget",
  Callback = function(value174)
    aim.fovTargetColor = {
      r = math.floor(value174.R * 255),
      g = math.floor(value174.G * 255),
      b = math.floor(value174.B * 255),
    }
  end,
})

local gunMODSAddSection = gunModsAddTab:AddSection({ Name = "GUN MODS" })

gunMODSAddSection:AddLabel("Rapid Fire"):AddToggle({
  Default = gunmod.firerate,
  Flag = "GmFirerate",
  Callback = function(value175) gunmod.firerate = value175 end,
})

gunMODSAddSection:AddLabel("Custom RPM"):AddToggle({
  Default = gunmod.customRpm,
  Flag = "GmCustomRpm",
  Callback = function(value176) gunmod.customRpm = value176 end,
})

gunMODSAddSection:AddLabel("Full Auto"):AddToggle({
  Default = gunmod.autoFire,
  Flag = "GmAutoFire",
  Callback = function(value177) gunmod.autoFire = value177 end,
})

gunMODSAddSection:AddLabel("No Recoil"):AddToggle({
  Default = gunmod.noRecoil,
  Flag = "GmNoRecoil",
  Callback = function(value178) gunmod.noRecoil = value178 end,
})

gunMODSAddSection:AddLabel("No Spread"):AddToggle({
  Default = gunmod.noSpread,
  Flag = "GmNoSpread",
  Callback = function(value179) gunmod.noSpread = value179 end,
})

gunMODSAddSection:AddLabel("Instant Reload"):AddToggle({
  Default = gunmod.instantReload,
  Flag = "GmInstantReload",
  Callback = function(value180) gunmod.instantReload = value180 end,
})

gunMODSAddSection:AddLabel("Fire Delay (sec)"):AddSlider({
  Default = gunmod.firerateValue,
  Min = 1e-7,
  Max = 0.2,
  Rounding = 2,
  Flag = "GmFirerateValue",
  Callback = function(value181) gunmod.firerateValue = value181 end,
})

gunMODSAddSection:AddLabel("Custom RPM Value"):AddSlider({
  Default = gunmod.rpmValue,
  Min = 100,
  Max = 3000,
  Rounding = 50,
  Flag = "GmRpmValue",
  Callback = function(value182) gunmod.rpmValue = value182 end,
})

local worldAddSection = worldAddTab:AddSection({ Name = "WORLD" })

worldAddSection:AddLabel("Custom Camera FOV"):AddToggle({
  Default = world.customFov,
  Flag = "WorldCustomFov",
  Callback = function(value183)
    world.customFov = value183

    if not value183 and workspace.CurrentCamera then
      workspace.CurrentCamera.FieldOfView = 70
    end
  end,
})

worldAddSection:AddLabel("Third Person"):AddToggle({
  Default = world.thirdPerson,
  Flag = "WorldThirdPerson",
  Callback = function(value184)
    world.thirdPerson = value184

    if not value184 and localPlayer then
      localPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
    end
  end,
})

worldAddSection:AddLabel("Camera FOV Value"):AddSlider({
  Default = world.fovValue,
  Min = 30,
  Max = 120,
  Rounding = 1,
  Flag = "WorldFovValue",
  Callback = function(value185) world.fovValue = value185 end,
})

worldAddSection:AddLabel("Third Person Distance"):AddSlider({
  Default = world.thirdPersonDist,
  Min = 5,
  Max = 50,
  Rounding = 1,
  Flag = "WorldThirdDist",
  Callback = function(value186) world.thirdPersonDist = value186 end,
})

worldAddSection:AddLabel("Custom Clock Time"):AddToggle({
  Default = world.clockTimeEnabled,
  Flag = "WorldClockEnabled",
  Callback = function(value187) world.clockTimeEnabled = value187 end,
})

worldAddSection:AddLabel("Brightness Override"):AddToggle({
  Default = world.brightnessEnabled,
  Flag = "WorldBrightnessEnabled",
  Callback = function(value188) world.brightnessEnabled = value188 end,
})

worldAddSection:AddLabel("Ambient Override"):AddToggle({
  Default = world.ambientEnabled,
  Flag = "WorldAmbientEnabled",
  Callback = function(value189) world.ambientEnabled = value189 end,
})

worldAddSection:AddLabel("Outdoor Ambient"):AddToggle({
  Default = world.outdoorAmbientEnabled,
  Flag = "WorldOutdoorEnabled",
  Callback = function(value190) world.outdoorAmbientEnabled = value190 end,
})

worldAddSection:AddLabel("Camera Distance Override"):AddToggle({
  Default = world.cameraDistanceEnabled,
  Flag = "WorldCamDistEnabled",
  Callback = function(value191) world.cameraDistanceEnabled = value191 end,
})

worldAddSection:AddLabel("Clock Time"):AddSlider({
  Default = world.clockTime,
  Min = 0,
  Max = 24,
  Rounding = 1,
  Flag = "WorldClockTime",
  Callback = function(value192) world.clockTime = value192 end,
})

worldAddSection:AddLabel("Brightness"):AddSlider({
  Default = world.brightness,
  Min = 0,
  Max = 10,
  Rounding = 1,
  Flag = "WorldBrightness",
  Callback = function(value193) world.brightness = value193 end,
})

worldAddSection:AddLabel("Camera Distance"):AddSlider({
  Default = world.cameraDistance,
  Min = 5,
  Max = 100,
  Rounding = 1,
  Flag = "WorldCamDist",
  Callback = function(value194) world.cameraDistance = value194 end,
})

worldAddSection:AddLabel("Ambient Color"):AddColorPicker({
  Default = f23(world.ambientColor),
  Flag = "WorldAmbientColor",
  Callback = function(value195)
    world.ambientColor = {
      r = math.floor(value195.R * 255),
      g = math.floor(value195.G * 255),
      b = math.floor(value195.B * 255),
    }
  end,
})

worldAddSection:AddLabel("Outdoor Color"):AddColorPicker({
  Default = f23(world.outdoorAmbientColor),
  Flag = "WorldOutdoorColor",
  Callback = function(value196)
    world.outdoorAmbientColor = {
      r = math.floor(value196.R * 255),
      g = math.floor(value196.G * 255),
      b = math.floor(value196.B * 255),
    }
  end,
})

local mapCOLORAddSection = worldAddTab:AddSection({ Name = "MAP COLOR" })

mapCOLORAddSection:AddLabel("Enable Map Color"):AddToggle({
  Default = world.mapColorEnabled,
  Flag = "WorldMapColorEnabled",
  Callback = function(value197) world.mapColorEnabled = value197 end,
})

mapCOLORAddSection:AddLabel("Mode"):AddDropdown({
  Default = "Tint",
  Values = { "Tint", "Ambient", "Both", "Saturation" },
  Flag = "WorldMapColorMode",
  Callback = function(value198) world.mapColorMode = value198 end,
})

mapCOLORAddSection:AddLabel("Map Color"):AddColorPicker({
  Default = f23(world.mapColor),
  Flag = "WorldMapColor",
  Callback = function(value199)
    world.mapColor = {
      r = math.floor(value199.R * 255),
      g = math.floor(value199.G * 255),
      b = math.floor(value199.B * 255),
    }
  end,
})

mapCOLORAddSection:AddLabel("Saturation"):AddSlider({
  Default = world.mapSaturation,
  Min = -1,
  Max = 1,
  Rounding = 2,
  Flag = "WorldMapSaturation",
  Callback = function(value200) world.mapSaturation = value200 end,
})

local watermarkAddSection = miscAddTab:AddSection({ Name = "WATERMARK" })

for index34, value201 in ipairs({
  { key = "cheatname", label = "Cheat Name", icon = "tag-sparkle" },
  { key = "fps", label = "FPS", icon = "chart-line" },
  { key = "ping", label = "Ping", icon = "arrow-spin-clockwise" },
  { key = "time", label = "Time", icon = "clock" },
  { key = "uptime", label = "Uptime", icon = "clock-spin-reverse" },
  { key = "status", label = "Status", icon = "signal-exclamation" },
  { key = "players", label = "Players", icon = "person" },
  { key = "spectators", label = "Spectators", icon = "eye" },
  { key = "username", label = "Username", icon = "person" },
  { key = "health", label = "Health", icon = "heart" },
  { key = "armor", label = "Armor", icon = "shield-check" },
  { key = "coords", label = "Coordinates", icon = "location-pin" },
  { key = "speed", label = "Speed", icon = "person-running" },
  { key = "direction", label = "Direction", icon = "compass" },
  { key = "weapon", label = "Weapon", icon = "sword" },
  { key = "ammo", label = "Ammo", icon = "bullet-flying" },
  { key = "kills", label = "Kills", icon = "crosshairs" },
  { key = "deaths", label = "Deaths", icon = "person-falling" },
  { key = "kd", label = "K/D", icon = "trophy" },
  { key = "roundTime", label = "Round Time", icon = "clock-dashed" },
  { key = "map", label = "Map", icon = "globe-simplified" },
  { key = "mode", label = "Game Mode", icon = "controller-with-cog" },
  { key = "scoreCT", label = "Score CT", icon = "flag" },
  { key = "scoreT", label = "Score T", icon = "flag" },
  { key = "bomb", label = "Bomb Timer", icon = "flame" },
  { key = "version", label = "Version", icon = "tag-sparkle" },
  { key = "serverId", label = "Server ID", icon = "cloud" },
}) do
  local v221 = value201

  watermarkAddSection:AddLabel(v221.label):AddToggle({
    Default = v24[v221.key] or false,
    Flag = "Watermark_" .. v221.key,
    Callback = function(value202)
      v24[v221.key] = value202

      if v39.watermark then
        v39.watermark[v221.key] = value202
      else
        v39.watermark = { [v221.key] = value202 }
      end
    end,
  })
end

local miscAddSection = miscAddTab:AddSection({ Name = "MISC" })

miscAddSection:AddLabel("Spectator Check"):AddToggle({
  Default = misc.specterChecked,
  Flag = "MiscSpecterChecked",
  Callback = function(value203)
    misc.specterChecked = value203

    if value203 then
      v94.init()
    else
      v94.cleanup()
    end
  end,
})

miscAddSection:AddLabel("Protect Name"):AddToggle({
  Default = misc.protectName or false,
  Flag = "MiscProtectName",
  Callback = function(value204)
    misc.protectName = value204
    _G.NT_ProtectName = value204
  end,
})

miscAddSection:AddLabel("No Flash"):AddToggle({
  Default = misc.noFlash,
  Flag = "MiscNoFlash",
  Callback = function(value205) misc.noFlash = value205 end,
})

miscAddSection:AddLabel("No Smoke"):AddToggle({
  Default = misc.noSmoke,
  Flag = "MiscNoSmoke",
  Callback = function(value206) misc.noSmoke = value206 end,
})

miscAddSection:AddLabel("Hit Logs"):AddToggle({
  Default = misc.hitLogs,
  Flag = "MiscHitLogs",
  Callback = function(value207) misc.hitLogs = value207 end,
})

miscAddSection:AddLabel("Miss Logs"):AddToggle({
  Default = misc.missLogs,
  Flag = "MiscMissLogs",
  Callback = function(value208) misc.missLogs = value208 end,
})

local nevertiveAddSection = nevertiveWindow:AddTab({ Icon = "fingerprint", Name = "Info" }):AddSection({
  Name = "Nevertive",
})

nevertiveWindow.UserSettings:AddButton({
  Icon = "discord",
  Name = "Discord",
  Callback = function()
    print("invite")
    setclipboard("https://discord.gg/w7ttxRgDJn")
    logger.new("discord", "Copied discord invite link", 5)
  end,
})

nevertiveAddSection:AddLabel("Actions"):AddDropdown({
  Default = "—",
  Values = { "—", "Unload Script" },
  Flag = "InfoActions",
  Callback = function(value209)
    if value209 == "Unload Script" then
      if _G.NevertiveUnload then
        f5("Nevertive", "Unloaded")
        f43()
      end
    end
  end,
})

function _G.NevertiveUnload()
  for key24, value210 in pairs(v58) do
    if key24 == "ViewmodelNew" then
      if type(v79) == "table" then
        v79.new = value210
      end
    else
      v37[key24] = value210
    end
  end

  if _G.__originalPerformRaycast and v129 then
    v129._performRaycast = _G.__originalPerformRaycast
    _G.__originalPerformRaycast = nil
  end

  v147.cleanup()

  aim.hitboxEnabled = false
  aim.backtrackEnabled = false

  v104 = {}
  v94.cleanup()
  pcall(function() connect3:Disconnect() end)

  for key25, value211 in pairs(v93) do
    f28(value211)
  end

  v93 = {}

  if world.mapColorEnabled then
    world.mapColorEnabled = false
  end

  pcall(function()
    for index35, value212 in ipairs({
      "__NT_Bloom", "__NT_CC", "__NT_SunRays", "__NT_MotionBlur",
    }) do
      local findFirstChild9 = lighting:FindFirstChild(value212)

      if findFirstChild9 then
        findFirstChild9:Destroy()
      end
    end
  end)

  pcall(function()
    local v222 = gethui and gethui()

    if v222 then
      for index36, value213 in ipairs(v222:GetChildren()) do
        local v223 = value213

        if v223:IsA("ScreenGui") then
          local name3 = v223.Name
          local v224 = false

          if name3 == "" or name3:match("^%s+$") or name3:match("^%c+$") then
            v224 = false
          end

          if name3 == "RobloxGui" or name3 == "MainGui" or name3:find("^CoreScripts") then
            v224 = true
          end

          if not v224 then
            pcall(function() v223:Destroy() end)
          end
        end
      end
    end
  end)

  pcall(function()
    if nevertiveWindow then
      if nevertiveWindow.Destroy then
        nevertiveWindow:Destroy()
      elseif nevertiveWindow.Unload then
        nevertiveWindow:Unload()
      elseif nevertiveWindow.Remove then
        nevertiveWindow:Remove()
      end
    end
  end)

  pcall(function()
    for key26, value214 in pairs(coreGui:GetChildren()) do
      if value214.Name:find("NeverLose") or value214.Name:find("Nevertive")
        or value214.Name:find("Erestive") then
        value214:Destroy()
      end
    end
  end)

  _G.NevertiveUnload = nil
end

local v225 = next
local v226, v227 = getgc(true)

for v228, v229 in v225, v226, v227 do
  local v230 = v229

  if type(v230) == "table" and rawget(v230, "setWeaponRecoil") then
    pcall(function()
      local v231
      v231 = hookfunction(v230.setWeaponRecoil, function(...) return v231(...) end)
    end)
  end

  if type(v230) == "function" and debug.getinfo(v230).name == "calculateRecoilOffset" then
    pcall(function()
      local v232
      v232 = hookfunction(v230, function(...) return v232(...) end)
    end)
  end

  if type(v230) == "table" and rawget(v230, "weaponKick") then
    pcall(function()
      local v233
      v233 = hookfunction(v230.weaponKick, function(p104, p105) return v233(p104, p105) end)
    end)
  end

  if type(v230) == "table" and rawget(v230, "getTrueSpread") then
    pcall(function()
      local v234
      v234 = hookfunction(v230.getTrueSpread, function(p106) return v234(p106) end)
    end)
  end

  if type(v230) == "function" and debug.getinfo(v230).name == "Flash" then
    pcall(function()
      local v235
      v235 = hookfunction(v230, function(...) return v235(...) end)
    end)
  end
end

_G.NT_ProtectName = false
f5("Nevertive", "Loaded!")
