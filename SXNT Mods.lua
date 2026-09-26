-- this is for BloxStrike

-- [ PROTECTION: SXNT ]
-- [ STATUS: ARMORED ]
-- [ TIMESTAMP: 24.09.2026 ]

--[[SKIDPROOF-STANDARD-LANE:ac58e499]]
do
    local __skf_ac58e4 = 4
    local __skf_999859 = __skf_ac58e4
end

local runService = game:GetService("RunService")
local players = game:GetService("Players")
local coreGui = game:GetService("CoreGui")
local workspaceService = game:GetService("Workspace")
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local debris = game:GetService("Debris")
local httpService = game:GetService("HttpService")
local rbxAnalyticsService = game:GetService("RbxAnalyticsService")
local v1 = getgenv and getgenv() or _G or _ENV

if v1.SXNT_Running then
  return
end

v1.SXNT_Running = true

local touchEnabled, f1, f2, v2, localPlayer, currentCamera, v3, v4, f3, v5, f4, f5, f6, f7, f8,
  f9, f10, f11, f12, f13, f14, f15, f16, v6, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26,
  v7, f27, f28, f29, v8, f30, f31, f32, f33, v9, keyChecker, v10, v11

if runService:IsStudio() then
  v1.SXNT_Running = nil
  return
else
  local localPlayer2 = players.LocalPlayer

  if not localPlayer2 or localPlayer2.UserId == 0 then
    v1.SXNT_Running = nil
    return
  else
    v2 = { uid = localPlayer2.UserId, place = game.PlaceId, job = game.JobId }

    task.spawn(function()
      while true do
        task.wait(30)
        local localPlayer3 = players.LocalPlayer

        if not localPlayer3 or localPlayer3.UserId ~= v2.uid or game.PlaceId ~= v2.place
          or game.JobId ~= v2.job then
          v1.SXNT_Running = nil

          pcall(function()
            for index, value in ipairs(coreGui:GetChildren()) do
              if value.Name == "Interface" or value.Name == "KeyChecker"
                or value.Name == "SxntWelcome" then
                value:Destroy()
              end
            end
          end)

          return
        end
      end
    end)

    localPlayer = players.LocalPlayer
    currentCamera = workspaceService.CurrentCamera

    v3 = {
      Ice = {
        label = "Ice",
        bg = Color3.fromRGB(18, 18, 22),
        card = Color3.fromRGB(28, 28, 33),
        cardHover = Color3.fromRGB(35, 35, 42),
        accent = Color3.fromRGB(0, 150, 255),
        accent2 = Color3.fromRGB(120, 80, 255),
        green = Color3.fromRGB(50, 210, 120),
        text = Color3.fromRGB(225, 225, 235),
        muted = Color3.fromRGB(90, 90, 115),
        border = Color3.fromRGB(45, 45, 55),
        red = Color3.fromRGB(255, 65, 65),
        telegram = Color3.fromRGB(88, 101, 242),
      },
      Purple = {
        label = "Purple",
        bg = Color3.fromRGB(20, 16, 30),
        card = Color3.fromRGB(32, 26, 46),
        cardHover = Color3.fromRGB(40, 32, 56),
        accent = Color3.fromRGB(170, 90, 255),
        accent2 = Color3.fromRGB(255, 90, 200),
        green = Color3.fromRGB(50, 210, 120),
        text = Color3.fromRGB(235, 225, 245),
        muted = Color3.fromRGB(120, 105, 145),
        border = Color3.fromRGB(55, 45, 75),
        red = Color3.fromRGB(255, 65, 65),
        telegram = Color3.fromRGB(88, 101, 242),
      },
      Crimson = {
        label = "Crimson",
        bg = Color3.fromRGB(24, 12, 14),
        card = Color3.fromRGB(38, 20, 22),
        cardHover = Color3.fromRGB(48, 26, 30),
        accent = Color3.fromRGB(255, 60, 80),
        accent2 = Color3.fromRGB(255, 140, 60),
        green = Color3.fromRGB(50, 210, 120),
        text = Color3.fromRGB(245, 225, 225),
        muted = Color3.fromRGB(140, 100, 105),
        border = Color3.fromRGB(65, 40, 45),
        red = Color3.fromRGB(255, 65, 65),
        telegram = Color3.fromRGB(88, 101, 242),
      },
      Toxic = {
        label = "Toxic",
        bg = Color3.fromRGB(12, 20, 14),
        card = Color3.fromRGB(20, 34, 22),
        cardHover = Color3.fromRGB(26, 44, 30),
        accent = Color3.fromRGB(60, 255, 130),
        accent2 = Color3.fromRGB(200, 255, 60),
        green = Color3.fromRGB(50, 210, 120),
        text = Color3.fromRGB(225, 245, 230),
        muted = Color3.fromRGB(100, 140, 110),
        border = Color3.fromRGB(40, 65, 45),
        red = Color3.fromRGB(255, 65, 65),
        telegram = Color3.fromRGB(88, 101, 242),
      },
      Midnight = {
        label = "Midnight",
        bg = Color3.fromRGB(10, 10, 14),
        card = Color3.fromRGB(20, 20, 26),
        cardHover = Color3.fromRGB(28, 28, 36),
        accent = Color3.fromRGB(180, 180, 200),
        accent2 = Color3.fromRGB(120, 120, 140),
        green = Color3.fromRGB(50, 210, 120),
        text = Color3.fromRGB(230, 230, 240),
        muted = Color3.fromRGB(100, 100, 120),
        border = Color3.fromRGB(40, 40, 50),
        red = Color3.fromRGB(255, 65, 65),
        telegram = Color3.fromRGB(88, 101, 242),
      },
      Sunset = {
        label = "Sunset",
        bg = Color3.fromRGB(24, 14, 20),
        card = Color3.fromRGB(38, 22, 32),
        cardHover = Color3.fromRGB(48, 28, 40),
        accent = Color3.fromRGB(255, 120, 80),
        accent2 = Color3.fromRGB(255, 60, 140),
        green = Color3.fromRGB(50, 210, 120),
        text = Color3.fromRGB(245, 225, 230),
        muted = Color3.fromRGB(140, 105, 120),
        border = Color3.fromRGB(60, 40, 55),
        red = Color3.fromRGB(255, 65, 65),
        telegram = Color3.fromRGB(88, 101, 242),
      },
    }

    v4 = { "Ice", "Purple", "Crimson", "Toxic", "Midnight", "Sunset" }

    function f3(p1)
      return v3[p1] or v3.Ice
    end

    if getgenv().SXNT_Connections then
      for index2, value2 in ipairs(getgenv().SXNT_Connections) do
        local v12 = value2
        pcall(function() v12:Disconnect() end)
      end
    end

    getgenv().SXNT_Connections = {}

    if getgenv().SXNT_Drawings then
      for index3, value3 in ipairs(getgenv().SXNT_Drawings) do
        local v13 = value3
        pcall(function() v13:Remove() end)
      end
    end

    getgenv().SXNT_Drawings = {}

    if getgenv().SXNT_KeyRecheckLoop then
      pcall(function() task.cancel(getgenv().SXNT_KeyRecheckLoop) end)
      getgenv().SXNT_KeyRecheckLoop = nil
    end

    touchEnabled = userInputService.TouchEnabled and not userInputService.KeyboardEnabled
    v5 = nil

    function f4(p2)
      local v14, v15 = pcall(function()
        if typeof(isfile) == "function" and isfile(p2) then
          return readfile(p2)
        end
      end)

      if v14 and v15 and v15 ~= "" then
        return v15
      end

      return nil
    end

    function f5(p3, p4)
    end

    function f6()
      local sxntConfigJson = f4("sxnt_config.json")

      if sxntConfigJson then
        local v16, v17 = pcall(function() return httpService:JSONDecode(sxntConfigJson) end)

        if v16 and type(v17) == "table" then
          return v17
        end

        return {}
      end

      return {}
    end

    function f7(p5)
      pcall(function() f5("sxnt_config.json", httpService:JSONEncode(p5)) end)
    end

    function f8()
      local v18, v19 = pcall(function() return coreGui end)

      if v18 then
        return v19
      end

      return localPlayer:WaitForChild("PlayerGui")
    end

    function f9(p6, expiresAt)
      if not p6 or p6 == "" then
        return
      end

      f5("sxnt_key.txt", p6)

      f5(
        "sxnt_keyinfo.json",
        httpService:JSONEncode({ expiresAt = expiresAt, savedAt = os.time() })
      )
    end

    function f10()
      return f4("sxnt_key.txt")
    end

    function f11()
      local sxntKeyinfoJson = f4("sxnt_keyinfo.json")

      if sxntKeyinfoJson then
        local v20, v21 = pcall(function() return httpService:JSONDecode(sxntKeyinfoJson) end)

        if v20 and type(v21) == "table" then
          return v21
        end

        return {}
      end

      return {}
    end

    function f12(p7)
      if syn and syn.request then
        local v22, v23 = pcall(syn.request, { Url = p7, Method = "GET" })

        if v22 and v23 and v23.Body then
          return v23.StatusCode, v23.Body
        end
      end

      if typeof(request) == "function" then
        local v24, v25 = pcall(request, { Url = p7, Method = "GET" })

        if v24 and v25 and v25.Body then
          return v25.StatusCode, v25.Body
        end
      end

      if typeof(http_request) == "function" then
        local v26, v28 = pcall(http_request, { Url = p7, Method = "GET" })

        if v26 and v28 and v28.Body then
          return v28.StatusCode, v28.Body
        end
      end

      local v29, v30, body

      if http and typeof(http.request) == "function" then
        local v31, v32 = pcall(http.request, { Url = p7, Method = "GET" })

        if v31 and v32 and v32.Body then
          return v32.StatusCode, v32.Body
        end

        v29, v30 = pcall(function()
          return httpService:RequestAsync({
            Url = p7,
            Method = "GET",
            Headers = { Accept = "application/json" },
          })
        end)

        body = v29
        body = v29 and v30 and v30.Body

        if body then
          return v30.StatusCode, v30.Body
        else
          local v33, v34 = pcall(function() return httpService:GetAsync(p7) end)

          if v33 and v34 then
            return 200, v34
          end

          return nil, nil
        end
      else
        v29, v30 = pcall(function()
          return httpService:RequestAsync({
            Url = p7,
            Method = "GET",
            Headers = { Accept = "application/json" },
          })
        end)

        body = v29
        body = v29 and v30 and v30.Body

        if body then
          return v30.StatusCode, v30.Body
        else
          local v35, v36 = pcall(function() return httpService:GetAsync(p7) end)

          if v35 and v36 then
            return 200, v36
          end

          return nil, nil
        end
      end
    end

    function f13()
      local getClientId

      pcall(function()
        if typeof(gethwid) == "function" then
          getClientId = gethwid()
        end
      end)

      if not getClientId or getClientId == "" then
        pcall(function() getClientId = rbxAnalyticsService:GetClientId() end)
      end

      if not getClientId or getClientId == "" then
        local sxntHwidTxt = f4("sxnt_hwid.txt")

        if sxntHwidTxt and sxntHwidTxt ~= "" then
          getClientId = sxntHwidTxt
        else
          getClientId = tostring(os.time()) .. "_" .. tostring(math.random(1, 1000000000))
          f5("sxnt_hwid.txt", getClientId)
        end
      end

      return getClientId
    end

    function f14(p8, p9)
      if type(p8) ~= "string" then
        return p9.hint_invalid
      elseif p8:find("invalid_key") then
        return p9.hint_invalid
      elseif p8:find("^banned") then
        return p9.hint_banned
      elseif p8 == "expired" then
        return p9.hint_expired
      elseif p8 == "inactive" then
        return p9.hint_inactive
      elseif p8 == "hwid_mismatch" then
        return p9.hint_hwid
      elseif p8 == "rate_limited" then
        return p9.hint_ratelimit
      elseif p8 == "key_and_hwid_required" then
        return p9.hint_no_key
      else
        if p8:find("Connection") or p8:find("No HTTP") then
          return p9.hint_error
        end

        if p8:find("Empty") then
          return p9.hint_no_key
        end

        return p9.hint_invalid
      end
    end

    function f15(p10)
      local v37 = not p10 or p10 == ""
      local v38, jsonDecode

      if v37 then
        return false, "Empty key", nil
      else
        local v39

        v39, v38 = f12("https://sxnt-mods.up.railway.app/validate" .. "?key="
          .. p10:gsub("%s+", "") .. "&hwid=" .. f13())

        if not v38 then
          return false, "No HTTP method worked on your executor", nil
        end

        if v38 == "" then
          return false, "Empty response (status " .. tostring(v39) .. ")", nil
        end

        jsonDecode = nil

        if not pcall(function() jsonDecode = httpService:JSONDecode(v38) end)
          or type(jsonDecode) ~= "table" then
          return false, "Bad response (HTTP " .. tostring(v39) .. ")", nil
        end

        if jsonDecode.valid == true then
          local expiresAtMs = jsonDecode.expires_at_ms

          return true, {
            first_name = "User",
            username = "sxnt_user",
            avatar_url = "",
            expiresAt = expiresAtMs,
          }, expiresAtMs
        end

        return false, jsonDecode.reason or "invalid_key", nil
      end
    end

    function f16(p11)
      if not p11 then
        return "unknown"
      else
        local v40 = p11 - os.time() * 1000

        if v40 <= 0 then
          return "expired"
        else
          local v41 = math.floor(v40 / 60000)
          local v42 = math.floor(v41 / 60)
          local v43 = v41 % 60

          if v42 > 0 then
            return string.format("%dh %dm", v42, v43)
          end

          return string.format("%dm", v43)
        end
      end
    end

    local function f34()
      local v44 = f6()

      if v44.Theme and v3[v44.Theme] then
        return v44.Theme
      end

      return "Ice"
    end

    v6 = {}

    for key, value4 in pairs((f3(f34()))) do
      v6[key] = value4
    end

    function f17(p12)
      for key2, value5 in pairs((f3(p12))) do
        v6[key2] = value5
      end
    end

    function f18(p13, p14, p15, p16, p17)
      return tweenService:Create(p13, TweenInfo.new(
        p14, p16 or Enum.EasingStyle.Quart, p17 or Enum.EasingDirection.Out
      ), p15)
    end

    function f19(p18, p19)
      local instance = Instance.new("UICorner", p18)
      instance.CornerRadius = UDim.new(0, p19 or 10)
      return instance
    end

    function f20(p20, p21, p22, p23)
      local instance2 = Instance.new("UIStroke", p20)
      instance2.Color = p21 or v6.border
      instance2.Thickness = p22 or 1
      instance2.Transparency = p23 or 0

      return instance2
    end

    function f21(p24, p25, p26, p27)
      local instance3 = Instance.new("UIGradient", p24)

      instance3.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, p25), ColorSequenceKeypoint.new(1, p26),
      })

      instance3.Rotation = p27 or 45

      return instance3
    end

    function f22(p28, p29, p30)
      local glowRing = Instance.new("Frame", p28)
      glowRing.Name = "GlowRing"
      glowRing.Size = UDim2.new(1, p30 or 8, 1, p30 or 8)
      glowRing.Position = UDim2.new(0.5, 0, 0.5, 0)
      glowRing.AnchorPoint = Vector2.new(0.5, 0.5)
      glowRing.BackgroundColor3 = p29 or v6.accent
      glowRing.BackgroundTransparency = 0.75
      glowRing.BorderSizePixel = 0
      glowRing.ZIndex = p28.ZIndex - 1

      f19(glowRing, 999)
      return glowRing
    end

    function f23(p31, p32, p33)
      local v45 = {}

      for i = 1, p32 or 18 do
        local instance4 = Instance.new("Frame", p31)
        instance4.Size = UDim2.new(0, math.random(2, 5), 0, math.random(2, 5))
        instance4.Position = UDim2.new(math.random(), 0, math.random(), 0)
        instance4.BackgroundColor3 = i % 3 == 0 and v6.accent2 or p33 or v6.accent
        instance4.BackgroundTransparency = math.random(50, 85) / 100
        instance4.BorderSizePixel = 0
        instance4.ZIndex = 0

        f19(instance4, 999)

        table.insert(v45, {
          obj = instance4,
          spd = math.random(8, 22) / 1000,
          dir = math.random() > 0.5 and 1 or -1,
          baseX = instance4.Position.X.Scale,
          baseY = instance4.Position.Y.Scale,
        })
      end

      local connect

      connect = runService.RenderStepped:Connect(function()
        if not p31.Parent then
          connect:Disconnect()
          return
        end

        for index4, value6 in ipairs(v45) do
          local obj = value6.obj

          if obj and obj.Parent then
            obj.Position = UDim2.new(value6.baseX
              + math.sin(tick() * 2 + value6.baseY * 10) * 0.02, 0, (obj.Position.Y.Scale + value6.spd * value6.dir) % 1, 0)
          end
        end
      end)

      table.insert(getgenv().SXNT_Connections, connect)
      return connect
    end

    function f24(p34, color, color2)
      task.spawn(function()
        while p34.Parent do
          f18(p34, 1.2, { Color = color2 }, Enum.EasingStyle.Sine):Play()
          task.wait(1.2)

          if not p34.Parent then
            break
          end

          f18(p34, 1.2, { Color = color }, Enum.EasingStyle.Sine):Play()
          task.wait(1.2)
        end
      end)
    end

    function f25(p35)
      local config = getgenv().Config

      if config and config.SoundEnabled == false then
        return
      else
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://127005215501903"
        sound.Volume = p35 or config and config.SoundVolume or 1.2
        sound.Parent = f8()
        sound:Play()

        debris:AddItem(sound, 1.5)
        return
      end
    end

    function f26(p36)
      if not p36:IsA("TextButton") then
        return
      end

      if p36:GetAttribute("SXNT_ClickAttached") then
        return
      end

      p36:SetAttribute("SXNT_ClickAttached", true)
      p36.MouseButton1Click:Connect(function() f25() end)
    end

    v7 = {
      ENG = true,
      UA = true,
      TR = true,
      RUS = true,
    }

    local function f35()
      local v46 = f6()

      if v46.Language and v7[v46.Language] then
        return v46.Language
      else
        local sxntLanguageTxt = f4("sxnt_language.txt")

        if sxntLanguageTxt then
          local gsub = sxntLanguageTxt:gsub("%s+", "")

          if v7[gsub] then
            return gsub
          end

          return "ENG"
        end

        return "ENG"
      end
    end

    function f27(p37)
      if not v7[p37] then
        return
      else
        getgenv().PreferredLanguage = p37

        local v47 = f6()
        v47.Language = p37

        f7(v47)
        f5("sxnt_language.txt", p37)
        return
      end
    end

    function f28()
      local v48 = f6()
      local config2 = getgenv().Config or {}

      for key3, value7 in pairs(v48) do
        if key3 == "MenuKey" then
          if type(value7) == "string" then
            local v49 = Enum.KeyCode[value7]

            if v49 then
              config2.MenuKey = v49
            end
          end
        elseif key3 == "Language" then
          config2.Language = value7
        else
          config2[key3] = value7
        end
      end

      getgenv().Config = config2
    end

    function f29()
      for key4, value8 in pairs(getgenv().Config) do
      end
    end

    v8 = {
      ENG = {
        welcome_new = "Welcome",
        welcome_back = "Welcome back",
        loading = "Loading menu...",
        entering = "Entering...",
      },
      UA = {
        welcome_new = "Вітаємо",
        welcome_back = "З поверненням",
        loading = "Завантаження меню...",
        entering = "Вхід...",
      },
      TR = {
        welcome_new = "Hoş geldin",
        welcome_back = "Tekrar hoş geldin",
        loading = "Menü yükleniyor...",
        entering = "Giriş...",
      },
      RUS = {
        welcome_new = "Добро пожаловать",
        welcome_back = "С возвращением",
        loading = "Загрузка меню...",
        entering = "Вход...",
      },
    }

    function f30(parent, p38, p39, p40)
      local sxntCard = Instance.new("Frame")
      sxntCard.Name = "SxntCard"
      sxntCard.Size = UDim2.new(0, 0, 0, 0)
      sxntCard.Position = UDim2.new(0.5, 0, 0.5, 0)
      sxntCard.AnchorPoint = Vector2.new(0.5, 0.5)
      sxntCard.BackgroundColor3 = v6.bg
      sxntCard.BorderSizePixel = 0
      sxntCard.ClipsDescendants = true
      sxntCard.Parent = parent

      f19(sxntCard, p40 or 20)
      local v50 = f20(sxntCard, v6.accent, 1.5, 0.3)
      f24(v50, v6.accent, v6.accent2)
      local v51 = f21(sxntCard, Color3.fromRGB(18, 18, 28), Color3.fromRGB(10, 14, 24), 135)

      local instance5 = Instance.new("Frame", sxntCard)
      instance5.Size = UDim2.new(1, 0, 1, 0)
      instance5.BackgroundTransparency = 1
      instance5.ZIndex = 1

      f23(instance5, 18, v6.accent)
      return sxntCard, v50, v51, instance5
    end

    function f31(p41, p42, p43)
      f18(p41, 0.55, { Size = UDim2.new(0, p42, 0, p43) }, Enum.EasingStyle.Back):Play()
    end

    function f32(p44, p45, p46, p47)
      f18(p44, 0.35, {
        Size = UDim2.new(0, p44.Size.X.Offset + 40, 0, p44.Size.Y.Offset + 40),
        BackgroundTransparency = 1,
      }, Enum.EasingStyle.Quad, Enum.EasingDirection.In):Play()

      if p45 then
        f18(p45, 0.35, { Transparency = 1 }):Play()
      end

      if p46 then
        p46:Destroy()
      end

      for index5, value9 in ipairs(p44:GetDescendants()) do
        local v52 = value9

        if v52:IsA("GuiObject") then
          pcall(function()
            f18(v52, 0.28, {
              BackgroundTransparency = 1,
              TextTransparency = 1,
              ImageTransparency = 1,
            }):Play()
          end)
        end
      end

      task.delay(0.38, p47)
    end

    function f33(p48, p49, p50, p51)
      local eng = v8[p50 or "ENG"] or v8.ENG

      local displayName = localPlayer.DisplayName ~= "" and localPlayer.DisplayName
        or localPlayer.Name

      local v53 = "@" .. localPlayer.Name
      local v54 = p51 and "welcome_back" or "welcome_new"

      local sxntWelcome = Instance.new("ScreenGui")
      sxntWelcome.Name = "SxntWelcome"
      sxntWelcome.ResetOnSpawn = false
      sxntWelcome.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
      sxntWelcome.Parent = f8()

      local v55, v56, v57 = f30(sxntWelcome, 340, 270, 20)

      if touchEnabled then
        local viewportSize = currentCamera.ViewportSize
        local v58 = math.min(1, viewportSize.X * 0.9 / 340, viewportSize.Y * 0.9 / 270)

        if v58 < 1 then
          Instance.new("UIScale", v55).Scale = v58
        end
      end

      local instance6 = Instance.new("Frame", v55)
      instance6.Size = UDim2.new(1, 0, 1, 0)
      instance6.BackgroundTransparency = 1
      instance6.ZIndex = 5

      local instance7 = Instance.new("TextLabel", instance6)
      instance7.Text = "SXNT"
      instance7.Font = Enum.Font.Cartoon
      instance7.TextSize = 28
      instance7.TextColor3 = v6.accent
      instance7.Size = UDim2.new(1, 0, 0, 36)
      instance7.Position = UDim2.new(0, 0, 0, 28)
      instance7.BackgroundTransparency = 1

      local instance8 = Instance.new("TextLabel", instance6)
      instance8.Text = eng[v54] .. ", " .. displayName .. "!"
      instance8.Font = Enum.Font.Cartoon
      instance8.TextSize = 16
      instance8.TextColor3 = v6.text
      instance8.Size = UDim2.new(1, -40, 0, 24)
      instance8.Position = UDim2.new(0, 20, 0, 72)
      instance8.BackgroundTransparency = 1
      instance8.TextTransparency = 1

      local instance9 = Instance.new("Frame", instance6)
      instance9.Size = UDim2.new(0, 72, 0, 72)
      instance9.Position = UDim2.new(0.5, -36, 0, 108)
      instance9.BackgroundTransparency = 1

      local v59 = f22(instance9, v6.accent, 14)
      v59.BackgroundTransparency = 1

      local instance10 = Instance.new("TextLabel", instance9)
      instance10.Text = displayName:sub(1, 1):upper()
      instance10.Font = Enum.Font.Cartoon
      instance10.TextSize = 28
      instance10.TextColor3 = Color3.new(1, 1, 1)
      instance10.Size = UDim2.new(1, 0, 1, 0)
      instance10.BackgroundColor3 = v6.accent

      f19(instance10, 36)

      instance10.BackgroundTransparency = 1
      instance10.TextTransparency = 1

      local instance11 = Instance.new("ImageLabel", instance9)
      instance11.Size = UDim2.new(1, 0, 1, 0)
      instance11.BackgroundTransparency = 1
      instance11.ImageTransparency = 1

      f19(instance11, 36)
      instance11.Image = "rbxassetid://127858462734195"
      local instance12

      if v53 ~= "" then
        instance12 = Instance.new("TextLabel", instance6)
        instance12.Text = v53
        instance12.Font = Enum.Font.Cartoon
        instance12.TextSize = 12
        instance12.TextColor3 = v6.muted
        instance12.Size = UDim2.new(1, 0, 0, 18)
        instance12.Position = UDim2.new(0, 0, 0, 188)
        instance12.BackgroundTransparency = 1
        instance12.TextTransparency = 1
      end

      local instance13 = Instance.new("Frame", instance6)
      instance13.Size = UDim2.new(1, -48, 0, 6)
      instance13.Position = UDim2.new(0, 24, 0, 220)
      instance13.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
      instance13.BorderSizePixel = 0
      instance13.BackgroundTransparency = 1

      f19(instance13, 3)

      local instance14 = Instance.new("Frame", instance13)
      instance14.Size = UDim2.new(0, 0, 1, 0)
      instance14.BackgroundColor3 = v6.accent
      instance14.BorderSizePixel = 0

      f19(instance14, 3)
      f21(instance14, v6.accent, v6.accent2, 0)

      local instance15 = Instance.new("TextLabel", instance6)
      instance15.Text = eng.loading
      instance15.Font = Enum.Font.Cartoon
      instance15.TextSize = 11
      instance15.TextColor3 = v6.muted
      instance15.Size = UDim2.new(1, 0, 0, 16)
      instance15.Position = UDim2.new(0, 0, 0, 232)
      instance15.BackgroundTransparency = 1
      instance15.TextTransparency = 1

      local instance16 = Instance.new("TextLabel", instance6)
      instance16.Text = "OK"
      instance16.Font = Enum.Font.Cartoon
      instance16.TextSize = 14
      instance16.TextColor3 = v6.green
      instance16.Size = UDim2.new(0, 30, 0, 30)
      instance16.Position = UDim2.new(1, -44, 0, 24)
      instance16.BackgroundTransparency = 1
      instance16.TextTransparency = 1

      f31(v55, 340, 270)
      task.wait(0.25)

      f18(instance8, 0.4, { TextTransparency = 0 }):Play()

      f18(
        instance10, 0.45, { BackgroundTransparency = 0, TextTransparency = 0 },
        Enum.EasingStyle.Back
      ):Play()

      f18(v59, 0.5, { BackgroundTransparency = 0.7 }):Play()
      f18(instance11, 0.5, { ImageTransparency = 0 }):Play()

      task.wait(0.15)

      if instance12 then
        f18(instance12, 0.35, { TextTransparency = 0 }):Play()
      end

      f18(instance13, 0.3, { BackgroundTransparency = 0 }):Play()
      f18(instance15, 0.3, { TextTransparency = 0 }):Play()

      local v60 = f18(instance14, 1.4, { Size = UDim2.new(1, 0, 1, 0) }, Enum.EasingStyle.Quad)
      v60:Play()
      v60.Completed:Wait()

      f18(instance16, 0.3, { TextTransparency = 0 }, Enum.EasingStyle.Back):Play()
      instance15.Text = eng.entering
      task.wait(0.35)

      f32(v55, v56, v57, function()
        sxntWelcome:Destroy()

        if p49 then
          p49()
        end
      end)

      task.wait(0.4)
    end

    v9 = {
      ENG = {
        title = "SXNT V1.3",
        subtitle = "Secure Activation",
        instructions_title = "HOW TO ACTIVATE",
        instructions_body = [[
1. Click GET KEY to open our website
2. Complete verification to receive your key
3. Copy the key and paste it below]],
        step1 = "GET YOUR KEY",
        step1_desc = "Open our website and grab your key",
        step1_btn = "GET KEY",
        copy_link_btn = "COPY",
        link_copied = "Copied!",
        step2 = "PASTE YOUR KEY",
        step2_desc = "Copy the key and paste it below",
        placeholder = "Paste your key here...",
        activate = "ACTIVATE",
        checking = "Verifying your key...",
        success = "Success! Loading menu...",
        close = "X",
        copied = "Link copied to clipboard",
        saved_key_loaded = "Saved key loaded - click ACTIVATE",
        status_idle = "Ready - paste your key to activate",
        status_checking = "Checking key...",
        status_success = "Access granted!",
        status_error = "Failed",
        hint_no_key = "Please enter a key first",
        hint_invalid = "Invalid or expired key",
        hint_error = "Connection error - check your internet",
        hint_expired = "Key expired - get a new one",
        footer = "Key is valid for 24 hours",
        paste_hint = "Copy your key from our website, then paste it here",
        paste_btn = "PASTE",
        expired_click = "Click below to enter a new key",
        expired_btn = "ENTER NEW KEY",
        hint_banned = "Key banned by admin",
        hint_hwid = "Key linked to another PC",
        hint_inactive = "Key disabled by admin",
        hint_ratelimit = "Too many attempts, wait a minute",
      },
      UA = {
        title = "SXNT V1.3",
        subtitle = "Безпечна активація",
        instructions_title = "ЯК АКТИВУВАТИ",
        instructions_body = "1. Натисніть ОТРИМАТИ КЛЮЧ щоб відкрити сайт\n2. Пройдіть перевірку та отримайте ключ\n3. Скопіюйте ключ і вставте нижче",
        step1 = "ОТРИМАЙТЕ КЛЮЧ",
        step1_desc = "Відкрийте наш сайт та візьміть ключ",
        step1_btn = "ОТРИМАТИ КЛЮЧ",
        copy_link_btn = "КОПІЯ",
        link_copied = "Скопійовано!",
        step2 = "ВСТАВТЕ КЛЮЧ",
        step2_desc = "Скопіюйте ключ і вставте нижче",
        placeholder = "Вставте ваш ключ...",
        activate = "АКТИВУВАТИ",
        checking = "Перевірка ключа...",
        success = "Успіх! Завантаження меню...",
        close = "X",
        copied = "Посилання скопійовано",
        saved_key_loaded = "Збережений ключ завантажено - натисніть АКТИВУВАТИ",
        status_idle = "Готово - вставте ключ для активації",
        status_checking = "Перевірка ключа...",
        status_success = "Доступ дозволено!",
        status_error = "Помилка",
        hint_no_key = "Спочатку введіть ключ",
        hint_invalid = "Невірний або прострочений ключ",
        hint_error = "Помилка з'єднання - перевірте інтернет",
        hint_expired = "Ключ прострочено - отримайте новий",
        footer = "Ключ діє 24 години",
        paste_hint = "Скопіюйте ключ з нашого сайту і вставте сюди",
        paste_btn = "ВСТАВИТИ",
        expired_click = "Натисніть нижче, щоб ввести новий ключ",
        expired_btn = "ВВЕСТИ НОВИЙ КЛЮЧ",
        hint_banned = "Ключ заблоковано адміном",
        hint_hwid = "Ключ прив'язаний до іншого ПК",
        hint_inactive = "Ключ вимкнено адміном",
        hint_ratelimit = "Занадто багато спроб, зачекайте хвилину",
      },
      TR = {
        title = "SXNT V1.3",
        subtitle = "Güvenli Aktivasyon",
        instructions_title = "NASIL AKTİVE EDİLİR",
        instructions_body = "1. Sitemizi açmak için ANAHTAR AL'a bas\n2. Doğrulamayı tamamla ve anahtarını al\n3. Anahtarı kopyala ve aşağıya yapıştır",
        step1 = "ANAHTARINI AL",
        step1_desc = "Sitemizi aç ve anahtarını al",
        step1_btn = "ANAHTAR AL",
        copy_link_btn = "KOPYALA",
        link_copied = "Kopyalandı!",
        step2 = "ANAHTARINI YAPIŞTIR",
        step2_desc = "Anahtarı kopyala ve aşağıya yapıştır",
        placeholder = "Anahtarını buraya yapıştır...",
        activate = "ETKİNLEŞTİR",
        checking = "Anahtar doğrulanıyor...",
        success = "Başarılı! Menü yükleniyor...",
        close = "X",
        copied = "Bağlantı kopyalandı",
        saved_key_loaded = "Kayıtlı anahtar yüklendi - ETKİNLEŞTİR'e bas",
        status_idle = "Hazır - aktive etmek için anahtarını yapıştır",
        status_checking = "Anahtar kontrol ediliyor...",
        status_success = "Erişim verildi!",
        status_error = "Başarısız",
        hint_no_key = "Önce bir anahtar gir",
        hint_invalid = "Geçersiz veya süresi dolmuş anahtar",
        hint_error = "Bağlantı hatası - internetini kontrol et",
        hint_expired = "Anahtarın süresi doldu - yeni bir tane al",
        footer = "Anahtar 24 saat geçerlidir",
        paste_hint = "Sitemizden anahtarını kopyala ve buraya yapıştır",
        paste_btn = "YAPIŞTIR",
        expired_click = "Yeni anahtar girmek için aşağıya bas",
        expired_btn = "YENİ ANAHTAR GİR",
        hint_banned = "Anahtar yönetici tarafından yasaklandı",
        hint_hwid = "Anahtar başka bir PC'ye bağlı",
        hint_inactive = "Anahtar yönetici tarafından kapatıldı",
        hint_ratelimit = "Çok fazla deneme, bir dakika bekleyin",
      },
      RUS = {
        title = "SXNT V1.3",
        subtitle = "Безопасная активация",
        instructions_title = "КАК АКТИВИРОВАТЬ",
        instructions_body = "1. Нажмите ПОЛУЧИТЬ КЛЮЧ чтобы открыть сайт\n2. Пройдите проверку и получите ключ\n3. Скопируйте ключ и вставьте ниже",
        step1 = "ПОЛУЧИТЕ КЛЮЧ",
        step1_desc = "Откройте наш сайт и возьмите ключ",
        step1_btn = "ПОЛУЧИТЬ КЛЮЧ",
        copy_link_btn = "КОПИЯ",
        link_copied = "Скопировано!",
        step2 = "ВСТАВЬТЕ КЛЮЧ",
        step2_desc = "Скопируйте ключ и вставьте ниже",
        placeholder = "Вставьте ваш ключ...",
        activate = "АКТИВИРОВАТЬ",
        checking = "Проверка ключа...",
        success = "Успех! Загрузка меню...",
        close = "X",
        copied = "Ссылка скопирована",
        saved_key_loaded = "Сохранённый ключ загружен - нажмите АКТИВИРОВАТЬ",
        status_idle = "Готово - вставьте ключ для активации",
        status_checking = "Проверка ключа...",
        status_success = "Доступ разрешён!",
        status_error = "Ошибка",
        hint_no_key = "Сначала введите ключ",
        hint_invalid = "Неверный или просроченный ключ",
        hint_error = "Ошибка соединения - проверьте интернет",
        hint_expired = "Ключ просрочен - получите новый",
        footer = "Ключ действует 24 часа",
        paste_hint = "Скопируйте ключ с нашего сайта и вставьте сюда",
        paste_btn = "ВСТАВИТЬ",
        expired_click = "Нажмите ниже, чтобы ввести новый ключ",
        expired_btn = "ВВЕСТИ НОВЫЙ КЛЮЧ",
        hint_banned = "Ключ заблокирован админом",
        hint_hwid = "Ключ привязан к другому ПК",
        hint_inactive = "Ключ отключён админом",
        hint_ratelimit = "Слишком много попыток, подождите минуту",
      },
    }

    keyChecker = Instance.new("ScreenGui")
    keyChecker.Name = "KeyChecker"
    keyChecker.ResetOnSpawn = false

    function f1(p52)
      table.insert(getgenv().SXNT_Connections, p52)
    end

    keyChecker.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    keyChecker.Parent = f8()

    local v61 = nil
    keyChecker.IgnoreGuiInset = true
    v10 = f35()
    getgenv().PreferredLanguage = v10

    function f2()
      if getgenv().SXNT_Connections then
        for index6, value10 in ipairs(getgenv().SXNT_Connections) do
          local v62 = value10
          pcall(function() v62:Disconnect() end)
        end
      end

      getgenv().SXNT_Connections = {}
    end

    v11 = nil

    function v11(p53, p54, p55, p56)
      if keyChecker:FindFirstChild("KeyFrame") then
        keyChecker.KeyFrame:Destroy()
      end

      local eng2 = v9[p53] or v9.ENG

      local keyFrame, v63, v64 = f30(keyChecker, 440, 615, 20)
      keyFrame.Name = "KeyFrame"

      if touchEnabled then
        local viewportSize2 = currentCamera.ViewportSize
        local v65 = math.min(1, viewportSize2.X * 0.95 / 440, viewportSize2.Y * 0.95 / 615)

        if v65 < 1 then
          Instance.new("UIScale", keyFrame).Scale = v65
        end
      end

      local instance17 = Instance.new("Frame", keyFrame)
      instance17.Size = UDim2.new(1, 0, 0, 3)
      instance17.BorderSizePixel = 0
      instance17.ZIndex = 3

      f19(instance17, 20)
      f21(instance17, v6.accent, v6.accent2, 0)

      local instance18 = Instance.new("TextButton", keyFrame)
      instance18.Text = eng2.close
      instance18.Font = Enum.Font.GothamBold
      instance18.TextSize = 13
      instance18.TextColor3 = Color3.fromRGB(210, 90, 90)
      instance18.Size = UDim2.new(0, 30, 0, 30)
      instance18.Position = UDim2.new(1, -40, 0, 14)
      instance18.BackgroundColor3 = Color3.fromRGB(36, 22, 24)
      instance18.BorderSizePixel = 0
      instance18.ZIndex = 10
      instance18.AutoButtonColor = false

      f19(instance18, 15)
      f20(instance18, Color3.fromRGB(120, 55, 60), 1, 0.45)

      instance18.MouseEnter:Connect(function()
        f18(instance18, 0.15, { BackgroundColor3 = v6.red, TextColor3 = Color3.new(1, 1, 1) }):Play()
      end)

      instance18.MouseLeave:Connect(function()
        f18(instance18, 0.15, {
          BackgroundColor3 = Color3.fromRGB(36, 22, 24),
          TextColor3 = Color3.fromRGB(210, 90, 90),
        }):Play()
      end)

      instance18.MouseButton1Click:Connect(function() keyChecker:Destroy() end)

      local instance19 = Instance.new("Frame", keyFrame)
      instance19.Size = UDim2.new(0, 44, 0, 44)
      instance19.Position = UDim2.new(0, 20, 0, 15)
      instance19.BackgroundColor3 = v6.accent
      instance19.BorderSizePixel = 0
      instance19.ZIndex = 5

      f19(instance19, 22)
      f21(instance19, v6.accent, v6.accent2, 45)

      local instance20 = Instance.new("TextLabel", instance19)
      instance20.Text = "S"
      instance20.Font = Enum.Font.GothamBold
      instance20.TextSize = 20
      instance20.TextColor3 = Color3.new(1, 1, 1)
      instance20.Size = UDim2.new(1, 0, 1, 0)
      instance20.BackgroundTransparency = 1
      instance20.ZIndex = 6

      local instance21 = Instance.new("ImageLabel", instance19)
      instance21.Size = UDim2.new(1, 0, 1, 0)
      instance21.BackgroundTransparency = 1
      instance21.Image = "rbxassetid://127858462734195"
      instance21.ZIndex = 7

      f19(instance21, 22)

      local instance22 = Instance.new("TextLabel", keyFrame)
      instance22.Text = eng2.title
      instance22.Font = Enum.Font.GothamBold
      instance22.TextSize = 16
      instance22.TextColor3 = v6.text
      instance22.Size = UDim2.new(1, -100, 0, 22)
      instance22.Position = UDim2.new(0, 74, 0, 18)
      instance22.BackgroundTransparency = 1
      instance22.TextXAlignment = Enum.TextXAlignment.Left
      instance22.ZIndex = 5

      local instance23 = Instance.new("TextLabel", keyFrame)
      instance23.Text = eng2.subtitle
      instance23.Font = Enum.Font.Gotham
      instance23.TextSize = 11
      instance23.TextColor3 = v6.muted
      instance23.Size = UDim2.new(1, -100, 0, 16)
      instance23.Position = UDim2.new(0, 74, 0, 38)
      instance23.BackgroundTransparency = 1
      instance23.TextXAlignment = Enum.TextXAlignment.Left
      instance23.ZIndex = 5

      local instance24 = Instance.new("Frame", keyFrame)
      instance24.Size = UDim2.new(1, -40, 0, 1)
      instance24.Position = UDim2.new(0, 20, 0, 72)
      instance24.BackgroundColor3 = v6.border
      instance24.BorderSizePixel = 0
      instance24.ZIndex = 5

      local instance25 = Instance.new("Frame", keyFrame)
      instance25.Size = UDim2.new(1, -40, 0, 96)
      instance25.Position = UDim2.new(0, 20, 0, 82)
      instance25.BackgroundColor3 = Color3.fromRGB(26, 28, 38)
      instance25.BorderSizePixel = 0
      instance25.ZIndex = 5

      f19(instance25, 10)
      f20(instance25, v6.accent, 1, 0.72)

      local instance26 = Instance.new("Frame", instance25)
      instance26.Size = UDim2.new(0, 20, 0, 20)
      instance26.Position = UDim2.new(0, 12, 0, 12)
      instance26.BackgroundColor3 = v6.accent
      instance26.BorderSizePixel = 0
      instance26.ZIndex = 6

      f19(instance26, 10)

      local instance27 = Instance.new("TextLabel", instance26)
      instance27.Text = "i"
      instance27.Font = Enum.Font.GothamBold
      instance27.TextSize = 13
      instance27.TextColor3 = Color3.new(1, 1, 1)
      instance27.Size = UDim2.new(1, 0, 1, 0)
      instance27.BackgroundTransparency = 1
      instance27.ZIndex = 7

      local instance28 = Instance.new("TextLabel", instance25)
      instance28.Text = eng2.instructions_title
      instance28.Font = Enum.Font.GothamBold
      instance28.TextSize = 11
      instance28.TextColor3 = v6.accent
      instance28.Size = UDim2.new(1, -50, 0, 20)
      instance28.Position = UDim2.new(0, 40, 0, 12)
      instance28.BackgroundTransparency = 1
      instance28.TextXAlignment = Enum.TextXAlignment.Left
      instance28.ZIndex = 6

      local instance29 = Instance.new("TextLabel", instance25)
      instance29.Text = eng2.instructions_body
      instance29.Font = Enum.Font.Gotham
      instance29.TextSize = 11
      instance29.TextColor3 = Color3.fromRGB(180, 186, 205)
      instance29.Size = UDim2.new(1, -24, 0, 56)
      instance29.Position = UDim2.new(0, 12, 0, 36)
      instance29.BackgroundTransparency = 1
      instance29.TextXAlignment = Enum.TextXAlignment.Left
      instance29.TextYAlignment = Enum.TextYAlignment.Top
      instance29.TextWrapped = true
      instance29.ZIndex = 6
      instance29.LineHeight = 1.25

      local instance30 = Instance.new("TextLabel", keyFrame)
      instance30.Text = "1"
      instance30.Font = Enum.Font.GothamBold
      instance30.TextSize = 12
      instance30.TextColor3 = Color3.new(1, 1, 1)
      instance30.Size = UDim2.new(0, 22, 0, 22)
      instance30.Position = UDim2.new(0, 20, 0, 188)
      instance30.BackgroundColor3 = v6.accent
      instance30.BorderSizePixel = 0

      f19(instance30, 11)
      f21(instance30, v6.accent, v6.accent2, 45)
      instance30.ZIndex = 5

      local instance31 = Instance.new("TextLabel", keyFrame)
      instance31.Text = eng2.step1
      instance31.Font = Enum.Font.GothamBold
      instance31.TextSize = 11
      instance31.TextColor3 = v6.accent
      instance31.Size = UDim2.new(1, -70, 0, 22)
      instance31.Position = UDim2.new(0, 50, 0, 188)
      instance31.BackgroundTransparency = 1
      instance31.TextXAlignment = Enum.TextXAlignment.Left
      instance31.ZIndex = 5

      local instance32 = Instance.new("TextLabel", keyFrame)
      instance32.Text = eng2.step1_desc
      instance32.Font = Enum.Font.Gotham
      instance32.TextSize = 11
      instance32.TextColor3 = v6.muted
      instance32.Size = UDim2.new(1, -40, 0, 16)
      instance32.Position = UDim2.new(0, 20, 0, 212)
      instance32.BackgroundTransparency = 1
      instance32.TextXAlignment = Enum.TextXAlignment.Left
      instance32.ZIndex = 5

      local instance33 = Instance.new("TextButton", keyFrame)
      instance33.Text = eng2.step1_btn
      instance33.Font = Enum.Font.GothamBold
      instance33.TextSize = 13
      instance33.TextColor3 = Color3.fromRGB(255, 255, 255)
      instance33.TextStrokeTransparency = 0.65
      instance33.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
      instance33.Size = UDim2.new(1, -120, 0, 42)
      instance33.Position = UDim2.new(0, 20, 0, 232)
      instance33.BackgroundColor3 = Color3.fromRGB(64, 82, 190)
      instance33.BorderSizePixel = 0
      instance33.AutoButtonColor = false
      instance33.ZIndex = 5

      f19(instance33, 10)
      f21(instance33, Color3.fromRGB(64, 82, 190), Color3.fromRGB(88, 108, 230), 45)

      instance33.MouseEnter:Connect(function()
        f18(instance33, 0.18, { BackgroundColor3 = Color3.fromRGB(90, 110, 235) }):Play()
      end)

      instance33.MouseLeave:Connect(function()
        f18(instance33, 0.18, { BackgroundColor3 = Color3.fromRGB(64, 82, 190) }):Play()
      end)

      local instance34 = Instance.new("TextButton", keyFrame)
      instance34.Text = eng2.copy_link_btn or "COPY"
      instance34.Font = Enum.Font.GothamBold
      instance34.TextSize = 11
      instance34.TextColor3 = v6.accent
      instance34.Size = UDim2.new(0, 80, 0, 42)
      instance34.Position = UDim2.new(1, -100, 0, 232)
      instance34.BackgroundColor3 = Color3.fromRGB(28, 30, 42)
      instance34.BorderSizePixel = 0
      instance34.AutoButtonColor = false
      instance34.ZIndex = 5

      f19(instance34, 10)
      f20(instance34, v6.accent, 1, 0.5)

      instance34.MouseEnter:Connect(function()
        f18(instance34, 0.15, { BackgroundColor3 = Color3.fromRGB(40, 44, 60) }):Play()
      end)

      instance34.MouseLeave:Connect(function()
        f18(instance34, 0.15, { BackgroundColor3 = Color3.fromRGB(28, 30, 42) }):Play()
      end)

      instance33.MouseButton1Click:Connect(function()
        pcall(function() setclipboard("https://sxnt-mods.up.railway.app/") end)

        pcall(function()
          if typeof(openbrowser) == "function" then
            openbrowser("https://sxnt-mods.up.railway.app/")
          end
        end)

        local text = instance33.Text
        instance33.Text = "✓ " .. (eng2.link_copied or "Copied!")

        task.delay(2, function()
          if instance33.Parent then
            instance33.Text = text
          end
        end)
      end)

      instance34.MouseButton1Click:Connect(function()
        pcall(function() setclipboard("https://sxnt-mods.up.railway.app/") end)
        local text2 = instance34.Text
        instance34.Text = "✓"

        task.delay(1.5, function()
          if instance34.Parent then
            instance34.Text = text2
          end
        end)
      end)

      local instance35 = Instance.new("TextLabel", keyFrame)
      instance35.Text = "2"
      instance35.Font = Enum.Font.GothamBold
      instance35.TextSize = 12
      instance35.TextColor3 = Color3.new(1, 1, 1)
      instance35.Size = UDim2.new(0, 22, 0, 22)
      instance35.Position = UDim2.new(0, 20, 0, 284)
      instance35.BackgroundColor3 = v6.accent
      instance35.BorderSizePixel = 0

      f19(instance35, 11)
      f21(instance35, v6.accent, v6.accent2, 45)
      instance35.ZIndex = 5

      local instance36 = Instance.new("TextLabel", keyFrame)
      instance36.Text = eng2.step2
      instance36.Font = Enum.Font.GothamBold
      instance36.TextSize = 11
      instance36.TextColor3 = v6.accent
      instance36.Size = UDim2.new(1, -70, 0, 22)
      instance36.Position = UDim2.new(0, 50, 0, 284)
      instance36.BackgroundTransparency = 1
      instance36.TextXAlignment = Enum.TextXAlignment.Left
      instance36.ZIndex = 5

      local instance37 = Instance.new("TextLabel", keyFrame)
      instance37.Text = eng2.step2_desc
      instance37.Font = Enum.Font.Gotham
      instance37.TextSize = 11
      instance37.TextColor3 = v6.muted
      instance37.Size = UDim2.new(1, -40, 0, 16)
      instance37.Position = UDim2.new(0, 20, 0, 308)
      instance37.BackgroundTransparency = 1
      instance37.TextXAlignment = Enum.TextXAlignment.Left
      instance37.ZIndex = 5

      local instance38 = Instance.new("Frame", keyFrame)
      instance38.Size = UDim2.new(1, -40, 0, 44)
      instance38.Position = UDim2.new(0, 20, 0, 328)
      instance38.BackgroundColor3 = Color3.fromRGB(22, 24, 32)
      instance38.BorderSizePixel = 0
      instance38.ZIndex = 5

      f19(instance38, 10)
      local v66 = f20(instance38, v6.border, 1.2, 0.4)

      local instance39 = Instance.new("TextBox", instance38)
      instance39.Size = UDim2.new(1, -70, 1, -8)
      instance39.Position = UDim2.new(0, 8, 0, 4)
      instance39.BackgroundTransparency = 1
      instance39.Text = p54 or ""
      instance39.Font = Enum.Font.Gotham
      instance39.TextSize = 12
      instance39.TextColor3 = v6.text
      instance39.PlaceholderText = eng2.placeholder
      instance39.PlaceholderColor3 = v6.muted
      instance39.ClearTextOnFocus = false
      instance39.ZIndex = 6
      instance39.TextXAlignment = Enum.TextXAlignment.Left

      local instance40 = Instance.new("TextButton", instance38)
      instance40.Text = eng2.paste_btn
      instance40.Font = Enum.Font.GothamBold
      instance40.TextSize = 10
      instance40.TextColor3 = v6.accent
      instance40.Size = UDim2.new(0, 60, 1, -8)
      instance40.Position = UDim2.new(1, -64, 0, 4)
      instance40.BackgroundColor3 = Color3.fromRGB(30, 32, 44)
      instance40.BorderSizePixel = 0
      instance40.AutoButtonColor = false
      instance40.ZIndex = 7

      f19(instance40, 8)

      instance40.MouseEnter:Connect(function()
        f18(instance40, 0.12, { BackgroundColor3 = Color3.fromRGB(42, 46, 60) }):Play()
      end)

      instance40.MouseLeave:Connect(function()
        f18(instance40, 0.12, { BackgroundColor3 = Color3.fromRGB(30, 32, 44) }):Play()
      end)

      instance40.MouseButton1Click:Connect(function()
        local v67

        if v67 and v67 ~= "" then
          instance39.Text = v67:gsub("%s+", "")
        else
          setStatus(eng2.paste_hint, "info")
        end
      end)

      local instance41 = Instance.new("TextButton", keyFrame)
      instance41.Size = UDim2.new(1, -40, 0, 48)
      instance41.Position = UDim2.new(0, 20, 0, 384)
      instance41.Text = eng2.activate
      instance41.Font = Enum.Font.GothamBold
      instance41.TextSize = 14
      instance41.TextColor3 = Color3.fromRGB(255, 255, 255)
      instance41.TextStrokeTransparency = 0.65
      instance41.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
      instance41.BackgroundColor3 = Color3.fromRGB(40, 95, 190)
      instance41.BorderSizePixel = 0
      instance41.AutoButtonColor = false
      instance41.ZIndex = 5

      f19(instance41, 10)
      f21(instance41, Color3.fromRGB(40, 95, 190), Color3.fromRGB(90, 55, 190), 0)

      local v68 = f22(instance41, v6.accent, 6)
      v68.BackgroundTransparency = 0.88

      instance41.MouseEnter:Connect(function()
        f18(instance41, 0.18, { BackgroundColor3 = Color3.fromRGB(58, 118, 215) }):Play()
        f18(v68, 0.18, { BackgroundTransparency = 0.7 }):Play()
      end)

      instance41.MouseLeave:Connect(function()
        f18(instance41, 0.18, { BackgroundColor3 = Color3.fromRGB(40, 95, 190) }):Play()
        f18(v68, 0.18, { BackgroundTransparency = 0.88 }):Play()
      end)

      local instance42 = Instance.new("Frame", keyFrame)
      instance42.Size = UDim2.new(1, -40, 0, 48)
      instance42.Position = UDim2.new(0, 20, 0, 442)
      instance42.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
      instance42.BorderSizePixel = 0
      instance42.ZIndex = 5

      f19(instance42, 10)
      local v69 = f20(instance42, v6.border, 1, 0.5)

      local instance43 = Instance.new("Frame", instance42)
      instance43.Size = UDim2.new(0, 8, 0, 8)
      instance43.Position = UDim2.new(0, 14, 0.5, -4)
      instance43.BackgroundColor3 = v6.muted
      instance43.BorderSizePixel = 0

      f19(instance43, 4)
      instance43.ZIndex = 6

      local instance44 = Instance.new("TextLabel", instance42)
      instance44.Size = UDim2.new(1, -40, 1, 0)
      instance44.Position = UDim2.new(0, 30, 0, 0)
      instance44.BackgroundTransparency = 1
      instance44.Font = Enum.Font.Gotham
      instance44.TextSize = 12
      instance44.TextColor3 = v6.muted
      instance44.ZIndex = 6
      instance44.TextXAlignment = Enum.TextXAlignment.Left
      instance44.TextWrapped = true

      local function f36(text3, p57)
        instance44.Text = text3

        if p57 == "success" then
          instance44.TextColor3 = v6.green
          instance43.BackgroundColor3 = v6.green
          v69.Color = v6.green
        elseif p57 == "error" then
          instance44.TextColor3 = v6.red
          instance43.BackgroundColor3 = v6.red
          v69.Color = v6.red
        elseif p57 == "checking" or p57 == "info" then
          instance44.TextColor3 = v6.accent
          instance43.BackgroundColor3 = v6.accent
          v69.Color = v6.accent
        else
          instance44.TextColor3 = v6.muted
          instance43.BackgroundColor3 = v6.muted
          v69.Color = v6.border
        end
      end

      if p56 == "success" then
        f36(p55 or eng2.status_success, "success")
      elseif p56 == "error" then
        f36(p55 or eng2.status_error, "error")
      elseif p54 and p54 ~= "" then
        f36(eng2.saved_key_loaded, "info")
      else
        f36(eng2.status_idle, "idle")
      end

      local instance45 = Instance.new("Frame", keyFrame)
      instance45.Size = UDim2.new(0, 240, 0, 26)
      instance45.Position = UDim2.new(0.5, -120, 0, 545)
      instance45.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
      instance45.BorderSizePixel = 0
      instance45.ZIndex = 6

      f19(instance45, 6)
      f20(instance45, v6.border, 1, 0.5)

      local instance46 = Instance.new("UIListLayout", instance45)
      instance46.FillDirection = Enum.FillDirection.Horizontal
      instance46.Padding = UDim.new(0, 4)
      instance46.HorizontalAlignment = Enum.HorizontalAlignment.Center
      instance46.VerticalAlignment = Enum.VerticalAlignment.Center

      for index7, value11 in ipairs({ "ENG", "UA", "TR", "RUS" }) do
        local v70 = value11

        local instance47 = Instance.new("TextButton", instance45)
        instance47.Text = v70
        instance47.Font = Enum.Font.GothamBold
        instance47.TextSize = 10
        instance47.TextColor3 = v70 == v10 and Color3.new(1, 1, 1) or v6.muted
        instance47.Size = UDim2.new(0, 52, 0, 20)
        instance47.BackgroundColor3 = v70 == v10 and v6.accent or Color3.fromRGB(32, 32, 40)
        instance47.BorderSizePixel = 0
        instance47.AutoButtonColor = false
        instance47.ZIndex = 7

        f19(instance47, 4)

        instance47.MouseEnter:Connect(function()
          if v70 ~= v10 then
            f18(instance47, 0.12, { BackgroundColor3 = Color3.fromRGB(45, 45, 58) }):Play()
          end
        end)

        instance47.MouseLeave:Connect(function()
          if v70 ~= v10 then
            f18(instance47, 0.12, { BackgroundColor3 = Color3.fromRGB(32, 32, 40) }):Play()
          end
        end)

        instance47.MouseButton1Click:Connect(function()
          if v70 == v10 then
            return
          else
            v10 = v70
            f27(v70)
            local v71 = nil
            local text4 = instance39.Text
            local savedKeyLoaded = nil

            if text4 and text4 ~= "" then
              v71 = "info"
              savedKeyLoaded = v9[v70].saved_key_loaded
            end

            v11(v70, text4, savedKeyLoaded, v71)
            return
          end
        end)
      end

      local instance48 = Instance.new("TextLabel", keyFrame)
      instance48.Text = eng2.footer
      instance48.Font = Enum.Font.Gotham
      instance48.TextSize = 10
      instance48.TextColor3 = v6.muted
      instance48.Size = UDim2.new(1, -40, 0, 16)
      instance48.Position = UDim2.new(0, 20, 0, 585)
      instance48.BackgroundTransparency = 1
      instance48.ZIndex = 5

      local v72 = false

      local function f37()
        local v73, offset, offset2

        if v72 then
          return
        else
          local gsub2 = instance39.Text:gsub("%s+", "")

          if gsub2 == "" then
            f36(eng2.hint_no_key, "error")
            offset2 = keyFrame.Position.X.Offset
            f18(keyFrame, 0.06, { Position = UDim2.new(0.5, offset2 - 6, 0.5, 0) }):Play()

            task.delay(0.06, function()
              f18(keyFrame, 0.1, { Position = UDim2.new(0.5, offset2 + 6, 0.5, 0) }):Play()
            end)

            task.delay(0.16, function()
              f18(keyFrame, 0.08, { Position = UDim2.new(0.5, offset2, 0.5, 0) }):Play()
            end)

            return
          else
            v72 = true

            instance41.Interactable = false
            instance41.Text = eng2.checking

            f18(instance41, 0.2, { BackgroundTransparency = 0.35 }):Play()
            f36(eng2.status_checking, "checking")

            task.spawn(function()
              while v72 do
                instance43.BackgroundTransparency = 0.3
                task.wait(0.3)

                if not v72 then
                  break
                end

                instance43.BackgroundTransparency = 1
                task.wait(0.3)
              end

              instance43.BackgroundTransparency = 0
            end)

            local v74, v75
            v75, v73, v74 = f15(gsub2)

            if v75 then
              f9(gsub2, v74)
              f36(eng2.status_success .. " (" .. f16(v74) .. ")", "success")
              instance41.Text = eng2.success
              f18(instance41, 0.25, { BackgroundTransparency = 0 }):Play()
              task.wait(1)
              v72 = false

              f32(keyFrame, v63, v64, function()
                keyChecker:Destroy()

                getgenv().TelegramProfile = v73
                getgenv().PreferredLanguage = v10

                f27(v10)
                f28()
                f33(v73, StartMainMenu(), v10, false)
              end)

              task.wait(0.45)
            else
              f36(f14(v73, eng2), "error")

              instance41.Interactable = true
              instance41.Text = eng2.activate

              f18(instance41, 0.2, { BackgroundTransparency = 0 }):Play()
              offset = keyFrame.Position.X.Offset
              f18(keyFrame, 0.06, { Position = UDim2.new(0.5, offset - 8, 0.5, 0) }):Play()

              task.delay(0.06, function()
                f18(keyFrame, 0.1, { Position = UDim2.new(0.5, offset + 8, 0.5, 0) }):Play()
              end)

              task.delay(0.16, function()
                f18(keyFrame, 0.08, { Position = UDim2.new(0.5, offset, 0.5, 0) }):Play()
              end)

              v72 = false
            end

            return
          end
        end
      end

      instance41.MouseButton1Click:Connect(f37)

      instance39.Focused:Connect(function()
        f18(v66, 0.2, { Color = v6.accent, Transparency = 0 }):Play()
        f18(instance38, 0.2, { BackgroundColor3 = Color3.fromRGB(28, 30, 40) }):Play()
      end)

      instance39.FocusLost:Connect(function(p58)
        f18(v66, 0.2, { Color = v6.border, Transparency = 0.4 }):Play()
        f18(instance38, 0.2, { BackgroundColor3 = Color3.fromRGB(22, 24, 32) }):Play()

        if p58 and not touchEnabled then
          f37()
        end
      end)

      f31(keyFrame, 440, 615)
    end

    function StartMainMenu()
      local v76 = f8()
      f2()

      if v76:FindFirstChild("Interface") then
        v76.Interface:Destroy()
      end

      local v77 = getgenv()
      v77.Config = getgenv().Config or {}

      local v78 = {
        ESP_Enabled = true,
        ESP_Box = true,
        ESP_Health = true,
        ESP_Name = true,
        ESP_Distance = true,
        ESP_Tracer = false,
        ESP_TeamCheck = true,
        EnemyColor = Color3.fromRGB(255, 65, 65),
        TeamColor = Color3.fromRGB(65, 180, 255),
        FOVCircle = true,
        FOVRadius = 60,
        FOVColor = Color3.fromRGB(130, 165, 255),
        SilentAim = true,
        Wallbang = false,
        HeadshotChance = 35,
        HitChance = 90,
        SilentTeamCheck = true,
        NoRecoil = true,
        NoSpread = false,
        AntiFlash = true,
        FlyEnabled = false,
        FlySpeed = 100,
        CheckpointPos = nil,
        TeleportLoop = false,
        SkinChanger_Enabled = true,
        SelectedWear = "Factory New",
        SelectedKnife = "Butterfly Knife",
        SelectedKnifeSkin = "Fade",
        SelectedGlove = "Sports Gloves",
        SelectedGloveSkin = "Imperial",
        ConfiguredSkins = {
          ["AK-47"] = "Sakura",
          AWP = "Lore",
          ["Desert Eagle"] = "Spectrum",
          ["Glock-18"] = "Fade",
          M4A4 = "Neo-Noir",
          ["M4A1-S"] = "SuperSoaked",
          ["USP-S"] = "Wintergreen",
          ["Dual Berettas"] = "Overclock",
        },
        Language = getgenv().PreferredLanguage or "ENG",
        MenuKey = Enum.KeyCode.F4,
        HideIcon = false,
        Theme = "Ice",
        SoundEnabled = true,
        SoundVolume = 1.2,
      }

      for key5, value12 in pairs(v78) do
        if getgenv().Config[key5] == nil then
          getgenv().Config[key5] = value12
        end
      end

      f28()

      if not getgenv().Config.ConfiguredSkins then
        getgenv().Config.ConfiguredSkins = v78.ConfiguredSkins
      end

      f17(getgenv().Config.Theme or "Ice")

      local v79 = {
        ENG = {
          title = "SXNT V1.3",
          visuals = "Visuals",
          combat = "Combat",
          movement = "Movement",
          skins = "Skins",
          telegram = "Telegram",
          settings = "Settings",
          account = "Account",
          esp_master = "Master ESP",
          esp_box = "Box ESP",
          esp_health = "Health Bar",
          esp_name = "Player Name",
          esp_dist = "Distance",
          esp_tracer = "Tracers",
          esp_team = "Team Check",
          fov_circle = "Show FOV Circle",
          fov_radius = "FOV Radius",
          silent = "Silent Aim",
          wallbang = "Wallbang",
          headshot = "Headshot Chance",
          hitchance = "Hit Chance",
          silent_team = "Aim Team Check",
          norecoil = "No Recoil",
          nospread = "No Spread",
          antiflash = "Anti Flash",
          fly = "Fly",
          flyspeed = "Fly Speed",
          record_cp = "Record Checkpoint",
          tp_loop = "Teleport Loop",
          skin_main = "Enable SkinChanger",
          wear = "Wear Condition",
          knife_section = "— 🔪 Force Knife —",
          knife_unavailable = "⚠️  Knife Changer unavailable",
          knife_unavailable_desc = "Couldn't be implemented. We apologize.",
          gloves_section = "— Gloves —",
          weapons_section = "— Weapons —",
          copy = "Copy Link",
          copied = "Copied!",
          lang = "Language",
          keybind = "Menu Key",
          bindkey = "Bind Key",
          hideicon = "Hide Icon",
          key_status = "Key Status",
          key_expires = "Expires in",
          clear_key_btn = "Clear saved key",
          no_key_saved = "No key saved",
          cant_hide_mobile = "Cannot hide on mobile",
          cleared = "Cleared",
          theme = "Theme",
          sound = "Click Sounds",
          volume = "Volume",
          reset_esp = "Reset ESP",
        },
        UA = {
          title = "SXNT V1.3",
          visuals = "Візуал",
          combat = "Бій",
          movement = "Рух",
          skins = "Скіни",
          telegram = "Телеграм",
          settings = "Налаштування",
          account = "Акаунт",
          esp_master = "Головний ESP",
          esp_box = "Бокс ESP",
          esp_health = "ХП-бар",
          esp_name = "Ім'я",
          esp_dist = "Дистанція",
          esp_tracer = "Трасери",
          esp_team = "Перевірка команди",
          fov_circle = "Показувати коло FOV",
          fov_radius = "Радіус FOV",
          silent = "Сайлент аим",
          wallbang = "Крізь стіни",
          headshot = "Шанс хедшота",
          hitchance = "Шанс влучання",
          silent_team = "Перевірка команди",
          norecoil = "Без віддачі",
          nospread = "Без розкиду",
          antiflash = "Анти-флеш",
          fly = "Політ",
          flyspeed = "Швидкість польоту",
          record_cp = "Записати чекпоінт",
          tp_loop = "Цикл-телепорт",
          skin_main = "Увімкнути SkinChanger",
          wear = "Стан зносу",
          knife_section = "— 🔪 Ножі —",
          knife_unavailable = "⚠️  Заміна ножів недоступна",
          knife_unavailable_desc = "Не вдалось реалізувати. Вибачте.",
          gloves_section = "— Рукавички —",
          weapons_section = "— Зброя —",
          copy = "Копіювати",
          copied = "Скопійовано!",
          lang = "Мова",
          keybind = "Клавіша меню",
          bindkey = "Призначити",
          hideicon = "Сховати іконку",
          key_status = "Статус ключа",
          key_expires = "Діє ще",
          clear_key_btn = "Видалити збережений ключ",
          no_key_saved = "Ключ не збережено",
          cant_hide_mobile = "Не можна сховати на телефоні",
          cleared = "Очищено",
          theme = "Тема",
          sound = "Клік-звуки",
          volume = "Гучність",
          reset_esp = "Скинути ESP",
        },
        TR = {
          title = "SXNT V1.3",
          visuals = "Görseller",
          combat = "Savaş",
          movement = "Hareket",
          skins = "Kaplamalar",
          telegram = "Telegram",
          settings = "Ayarlar",
          account = "Hesap",
          esp_master = "Master ESP",
          esp_box = "Kutu ESP",
          esp_health = "Can Barı",
          esp_name = "İsim",
          esp_dist = "Mesafe",
          esp_tracer = "İzleyici",
          esp_team = "Takım Kontrolü",
          fov_circle = "FOV Daire Göster",
          fov_radius = "FOV Yarıçapı",
          silent = "Sessiz Nişan",
          wallbang = "Duvar Delme",
          headshot = "Kafa Şansı",
          hitchance = "İsabet Şansı",
          silent_team = "Takım Kontrolü",
          norecoil = "Sekmeme",
          nospread = "Yayılmama",
          antiflash = "Anti Flash",
          fly = "Uçuş",
          flyspeed = "Uçuş Hızı",
          record_cp = "Nokta Kaydet",
          tp_loop = "Işınlanma Döngüsü",
          skin_main = "SkinChanger'ı Aç",
          wear = "Aşınma",
          knife_section = "— 🔪 Bıçak —",
          knife_unavailable = "⚠️  Bıçak Değiştirici kullanılamıyor",
          knife_unavailable_desc = "Uygulanamadı. Özür dileriz.",
          gloves_section = "— Eldivenler —",
          weapons_section = "— Silahlar —",
          copy = "Kopyala",
          copied = "Kopyalandı!",
          lang = "Dil",
          keybind = "Menü Tuşu",
          bindkey = "Tuş Ata",
          hideicon = "Simgeyi Gizle",
          key_status = "Anahtar Durumu",
          key_expires = "Sona eriyor",
          clear_key_btn = "Kayıtlı anahtarı temizle",
          no_key_saved = "Anahtar kayıtlı değil",
          cant_hide_mobile = "Mobilde gizlenemez",
          cleared = "Temizlendi",
          theme = "Tema",
          sound = "Tık Sesleri",
          volume = "Ses",
          reset_esp = "ESP Sıfırla",
        },
        RUS = {
          title = "SXNT V1.3",
          visuals = "Визуал",
          combat = "Бой",
          movement = "Движение",
          skins = "Скины",
          telegram = "Телеграм",
          settings = "Настройки",
          account = "Аккаунт",
          esp_master = "Главный ESP",
          esp_box = "Бокс ESP",
          esp_health = "ХП-бар",
          esp_name = "Имя",
          esp_dist = "Дистанция",
          esp_tracer = "Трассеры",
          esp_team = "Проверка команды",
          fov_circle = "Показывать круг FOV",
          fov_radius = "Радиус FOV",
          silent = "Сайлент аим",
          wallbang = "Сквозь стены",
          headshot = "Шанс хедшота",
          hitchance = "Шанс попадания",
          silent_team = "Проверка команды",
          norecoil = "Без отдачи",
          nospread = "Без разброса",
          antiflash = "Анти-флеш",
          fly = "Полёт",
          flyspeed = "Скорость полёта",
          record_cp = "Записать чекпоинт",
          tp_loop = "Цикл-телепорт",
          skin_main = "Включить SkinChanger",
          wear = "Состояние износа",
          knife_section = "— 🔪 Ножи —",
          knife_unavailable = "⚠️  Замена ножей недоступна",
          knife_unavailable_desc = "Не удалось реализовать. Извините.",
          gloves_section = "— Перчатки —",
          weapons_section = "— Оружие —",
          copy = "Копировать",
          copied = "Скопировано!",
          lang = "Язык",
          keybind = "Клавиша меню",
          bindkey = "Назначить",
          hideicon = "Скрыть иконку",
          key_status = "Статус ключа",
          key_expires = "Действует ещё",
          clear_key_btn = "Удалить сохранённый ключ",
          no_key_saved = "Ключ не сохранён",
          cant_hide_mobile = "Нельзя скрыть на телефоне",
          cleared = "Очищено",
          theme = "Тема",
          sound = "Клик-звуки",
          volume = "Громкость",
          reset_esp = "Сбросить ESP",
        },
      }

      local v80 = {
        bg = v6.bg,
        card = v6.card,
        accent = v6.accent,
        green = v6.green,
        text = v6.text,
        muted = v6.muted,
        border = v6.border,
        red = v6.red,
        telegram = v6.telegram,
      }

      local telegramProfile = getgenv().TelegramProfile

      local displayName2 = localPlayer.DisplayName ~= "" and localPlayer.DisplayName
        or localPlayer.Name

      local v81 = "@" .. localPlayer.Name

      local function f38(p59, p60, p61, p62, p63)
        local create = tweenService:Create(p59, TweenInfo.new(
          p60, p62 or Enum.EasingStyle.Quart, p63 or Enum.EasingDirection.Out
        ), p61)

        create:Play()
        return create
      end

      local function f39(p64, p65)
        local instance49 = Instance.new("UICorner", p64)
        instance49.CornerRadius = UDim.new(0, p65 or 8)
        return instance49
      end

      local function f40(p66, p67, p68)
        local instance50 = Instance.new("UIStroke", p66)
        instance50.Color = p67 or v80.border
        instance50.Thickness = p68 or 1

        return instance50
      end

      local interface = Instance.new("ScreenGui")
      interface.Name = "Interface"
      interface.Parent = v76
      interface.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
      interface.ResetOnSpawn = false
      interface.IgnoreGuiInset = true
      interface.DescendantAdded:Connect(f26)

      for index8, value13 in ipairs(interface:GetDescendants()) do
        f26(value13)
      end

      if touchEnabled then
        getgenv().Config.HideIcon = false
      end

      local v82 = touchEnabled and 56 or 48

      local textButton = Instance.new("TextButton")
      textButton.Size = UDim2.new(0, v82, 0, v82)
      textButton.Position = UDim2.new(0, 20, 0.4, 0)
      textButton.BackgroundColor3 = v80.accent
      textButton.Text = ""
      textButton.AutoButtonColor = false
      textButton.Parent = interface
      textButton.Visible = not getgenv().Config.HideIcon

      f39(textButton, v82 / 2)
      f40(textButton, Color3.fromRGB(255, 255, 255), 1.5)
      local sub = displayName2.sub

      local instance51 = Instance.new("TextLabel", textButton)
      instance51.Text = sub(displayName2, 1, 1):upper()
      instance51.Font = Enum.Font.Cartoon
      instance51.TextSize = 22
      instance51.TextColor3 = Color3.new(1, 1, 1)
      instance51.Size = UDim2.new(1, 0, 1, 0)
      instance51.BackgroundTransparency = 1
      instance51.ZIndex = 1

      local instance52 = Instance.new("ImageLabel", textButton)
      instance52.Size = UDim2.new(1, 0, 1, 0)
      instance52.BackgroundTransparency = 1
      instance52.Image = "rbxassetid://127858462734195"
      instance52.ZIndex = 2

      f39(instance52, v82 / 2)

      local instance53 = Instance.new("Frame", textButton)
      instance53.Size = UDim2.new(1, 0, 1, 0)
      instance53.Position = UDim2.new(0.5, 0, 0.5, 0)
      instance53.AnchorPoint = Vector2.new(0.5, 0.5)
      instance53.BackgroundTransparency = 1
      instance53.ZIndex = 0

      local instance54 = Instance.new("UIStroke", instance53)
      instance54.Thickness = 2.5
      instance54.Color = v80.accent
      instance54.Transparency = 0

      Instance.new("UICorner", instance53).CornerRadius = UDim.new(1, 0)

      task.spawn(function()
        while instance53.Parent do
          f18(instance53, 1, { Size = UDim2.new(1, 7, 1, 7) }, Enum.EasingStyle.Sine):Play()
          f18(instance54, 1, { Transparency = 0.75, Thickness = 1 }, Enum.EasingStyle.Sine):Play()

          task.wait(1)

          if not instance53.Parent then
            break
          end

          f18(instance53, 1, { Size = UDim2.new(1, 0, 1, 0) }, Enum.EasingStyle.Sine):Play()
          f18(instance54, 1, { Transparency = 0, Thickness = 2.5 }, Enum.EasingStyle.Sine):Play()

          task.wait(1)
        end
      end)

      local function f41(p69)
        f38(textButton, 0.25, { BackgroundTransparency = p69 })
        f38(instance51, 0.25, { TextTransparency = p69 })
        f38(instance52, 0.25, { ImageTransparency = p69 })
        f38(instance54, 0.25, { Transparency = p69 == 1 and 1 or 0.3 })
      end

      local v83 = {
        xs = 0,
        xo = 20,
        ys = 0.4,
        yo = 0,
      }

      local frame = Instance.new("Frame")
      frame.Size = UDim2.new(0, 500, 0, 360)
      frame.Position = UDim2.new(0.5, -250, 0.5, -180)
      frame.BackgroundColor3 = v80.bg
      frame.BorderSizePixel = 0
      frame.Visible = false
      frame.ClipsDescendants = true
      frame.Parent = interface

      f39(frame, 16)
      f40(frame, v80.border, 1.2)

      if touchEnabled then
        local viewportSize3 = currentCamera.ViewportSize
        local v84 = math.min(1, viewportSize3.X * 0.98 / 500, viewportSize3.Y * 0.95 / 360)

        if v84 < 1 then
          Instance.new("UIScale", frame).Scale = v84
        end
      end

      local instance55 = Instance.new("Frame", frame)
      instance55.Size = UDim2.new(1, 0, 1, 0)
      instance55.Position = UDim2.new(0, 0, 0, 0)
      instance55.BackgroundColor3 = Color3.new(0, 0, 0)
      instance55.BackgroundTransparency = 0.93
      instance55.BorderSizePixel = 0
      instance55.ZIndex = 0

      f39(instance55, 16)

      local instance56 = Instance.new("Frame", frame)
      instance56.Size = UDim2.new(1, 0, 1, -46)
      instance56.Position = UDim2.new(0, 0, 0, 46)
      instance56.BackgroundTransparency = 1
      instance56.BorderSizePixel = 0
      instance56.ZIndex = 0
      instance56.ClipsDescendants = true

      local v85 = {}

      for j = 1, 44 do
        local instance57 = Instance.new("Frame", instance56)
        instance57.Size = UDim2.new(0, math.random(2, 5), 0, math.random(2, 5))
        instance57.Position = UDim2.new(math.random(), 0, math.random(), 0)

        instance57.BackgroundColor3 = j % 3 == 0 and Color3.fromRGB(120, 80, 255)
          or Color3.fromRGB(0, 170, 255)

        instance57.BackgroundTransparency = math.random(45, 80) / 100
        instance57.BorderSizePixel = 0
        instance57.ZIndex = 0

        f19(instance57, 999)

        table.insert(v85, {
          obj = instance57,
          spd = math.random(8, 22) / 1000,
          dir = math.random() > 0.5 and 1 or -1,
          baseX = instance57.Position.X.Scale,
          baseY = instance57.Position.Y.Scale,
        })
      end

      local connect2

      connect2 = runService.RenderStepped:Connect(function()
        if not instance56.Parent then
          connect2:Disconnect()
          return
        end

        for index9, value14 in ipairs(v85) do
          local obj2 = value14.obj

          if obj2 and obj2.Parent then
            obj2.Position = UDim2.new(value14.baseX
              + math.sin(tick() * 1.5 + value14.baseY * 7) * 0.015, 0, (obj2.Position.Y.Scale + value14.spd * value14.dir) % 1, 0)
          end
        end
      end)

      f1(connect2)
      local v86 = { w = 500, h = 360 }

      local v87 = {
        xs = 0.5,
        xo = -250,
        ys = 0.5,
        yo = -180,
      }

      local function f42()
        f38(textButton, 0.25, {
          Size = UDim2.new(0, 0, 0, 0),
          Position = UDim2.new(v83.xs, v83.xo + v82 / 2, v83.ys, v83.yo + v82 / 2),
        }, Enum.EasingStyle.Back, Enum.EasingDirection.In)

        f41(1)

        task.delay(0.2, function()
          if not interface.Parent then
            return
          end

          textButton.Visible = false

          frame.Visible = true
          frame.Size = UDim2.new(0, 0, 0, 0)
          frame.Position = UDim2.new(v87.xs, v87.xo, v87.ys, v87.yo)

          f38(frame, 0.3, { Size = UDim2.new(0, v86.w, 0, v86.h) }, Enum.EasingStyle.Back)
        end)
      end

      local function f43()
        f38(
          frame, 0.2, { Size = UDim2.new(0, 0, 0, 0) }, Enum.EasingStyle.Quad,
          Enum.EasingDirection.In
        )

        task.delay(0.15, function()
          if not interface.Parent then
            return
          end

          frame.Visible = false

          textButton.Visible = not getgenv().Config.HideIcon
          textButton.Size = UDim2.new(0, 0, 0, 0)
          textButton.Position = UDim2.new(v83.xs, v83.xo + v82 / 2, v83.ys, v83.yo + v82 / 2)

          f41(1)

          f38(textButton, 0.25, {
            Size = UDim2.new(0, v82, 0, v82),
            Position = UDim2.new(v83.xs, v83.xo, v83.ys, v83.yo),
          }, Enum.EasingStyle.Back)

          f41(0)
        end)
      end

      if not touchEnabled then
        f1(userInputService.InputBegan:Connect(function(input, p70)
          if p70 then
            return
          end

          if input.UserInputType == Enum.UserInputType.Keyboard
            and input.KeyCode == getgenv().Config.MenuKey then
            if frame.Visible then
              f43()
            else
              f42()
            end
          end
        end))
      end

      local position = nil
      local v88, v89, position2

      local function f44(p71, p72)
        v88 = true
        v89 = p71
        position2 = p72.Position
        position = p71.Position

        p72.Changed:Connect(function()
          if p72.UserInputState == Enum.UserInputState.End then
            v88 = false
          end
        end)
      end

      f1(userInputService.InputChanged:Connect(function(input2)
        if v88
          and v89
          and (input2.UserInputType == Enum.UserInputType.MouseMovement
            or input2.UserInputType == Enum.UserInputType.Touch) then
          local v90 = input2.Position - position2

          v89.Position = UDim2.new(
            position.X.Scale, position.X.Offset + v90.X, position.Y.Scale,
            position.Y.Offset + v90.Y
          )

          if v89 == frame then
            v87 = {
              xs = frame.Position.X.Scale,
              xo = frame.Position.X.Offset,
              ys = frame.Position.Y.Scale,
              yo = frame.Position.Y.Offset,
            }
          elseif v89 == textButton then
            v83 = {
              xs = textButton.Position.X.Scale,
              xo = textButton.Position.X.Offset,
              ys = textButton.Position.Y.Scale,
              yo = textButton.Position.Y.Offset,
            }
          end
        end
      end))

      local position3

      textButton.InputBegan:Connect(function(input3)
        if input3.UserInputType == Enum.UserInputType.MouseButton1
          or input3.UserInputType == Enum.UserInputType.Touch then
          position3 = input3.Position
          f44(textButton, input3)
        end
      end)

      textButton.InputEnded:Connect(function(input4)
        if input4.UserInputType == Enum.UserInputType.MouseButton1
          or input4.UserInputType == Enum.UserInputType.Touch then
          if position3 then
            if (input4.Position - position3).Magnitude < 10 then
              f42()
            end

            position3 = nil
          end

          v88 = false
        end
      end)

      local frame2 = Instance.new("Frame")
      frame2.Size = UDim2.new(1, 0, 0, 46)
      frame2.BackgroundTransparency = 1
      frame2.Parent = frame
      frame2.ZIndex = 10

      local instance58 = Instance.new("TextLabel", frame2)
      instance58.Text = v79[getgenv().Config.Language].title or "SXNT V1.3"
      instance58.Font = Enum.Font.Cartoon
      instance58.TextSize = 15
      instance58.TextColor3 = v80.text
      instance58.Size = UDim2.new(0, 140, 0, 40)
      instance58.Position = UDim2.new(0, 16, 0, 4)
      instance58.BackgroundTransparency = 1
      instance58.TextXAlignment = Enum.TextXAlignment.Left
      instance58.ZIndex = 11

      local instance59 = Instance.new("Frame", frame2)
      instance59.Size = UDim2.new(0, 130, 0, 46)
      instance59.Position = UDim2.new(1, -180, 0, 0)
      instance59.BackgroundTransparency = 1

      local instance60 = Instance.new("Frame", instance59)
      instance60.Size = UDim2.new(0, 34, 0, 34)
      instance60.Position = UDim2.new(0, 3, 0.5, -17)
      instance60.BackgroundTransparency = 1
      instance60.ZIndex = 1

      Instance.new("UICorner", instance60).CornerRadius = UDim.new(1, 0)

      local instance61 = Instance.new("UIStroke", instance60)
      instance61.Thickness = 2
      instance61.Color = v80.accent
      instance61.Transparency = 0.15

      local instance62 = Instance.new("UIGradient", instance61)

      instance62.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, v80.accent), ColorSequenceKeypoint.new(0.5, v6.accent2),
        ColorSequenceKeypoint.new(1, v80.accent),
      })

      task.spawn(function()
        while instance60.Parent do
          f18(instance61, 1.2, { Transparency = 0.7 }, Enum.EasingStyle.Sine):Play()
          task.wait(1.2)

          if not instance60.Parent then
            break
          end

          f18(instance61, 1.2, { Transparency = 0.15 }, Enum.EasingStyle.Sine):Play()
          task.wait(1.2)
        end
      end)

      f1(runService.RenderStepped:Connect(function()
        if not instance60.Parent then
          return
        end

        instance62.Rotation = tick() * 150 % 360
      end))

      local instance63 = Instance.new("TextLabel", instance59)
      instance63.Text = displayName2:sub(1, 1):upper()
      instance63.Font = Enum.Font.Cartoon
      instance63.TextSize = 14
      instance63.TextColor3 = Color3.new(1, 1, 1)
      instance63.BackgroundColor3 = v80.accent
      instance63.Size = UDim2.new(0, 30, 0, 30)
      instance63.Position = UDim2.new(0, 5, 0.5, -15)

      Instance.new("UICorner", instance63).CornerRadius = UDim.new(0, 15)

      local instance64 = Instance.new("ImageLabel", instance59)
      instance64.Size = UDim2.new(0, 30, 0, 30)
      instance64.Position = UDim2.new(0, 5, 0.5, -15)
      instance64.BackgroundTransparency = 1

      Instance.new("UICorner", instance64).CornerRadius = UDim.new(0, 15)
      instance64.ZIndex = 2

      pcall(function()
        instance64.Image = players:GetUserThumbnailAsync(
          localPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150
        )
      end)

      local instance65 = Instance.new("TextLabel", instance59)
      instance65.Text = displayName2
      instance65.Font = Enum.Font.Cartoon
      instance65.TextSize = 13
      instance65.TextColor3 = Color3.new(1, 1, 1)
      instance65.Size = UDim2.new(1, -40, 0, 20)
      instance65.Position = UDim2.new(0, 42, 0, 4)
      instance65.BackgroundTransparency = 1
      instance65.TextXAlignment = Enum.TextXAlignment.Left

      if v81 ~= "" then
        local instance66 = Instance.new("TextLabel", instance59)
        instance66.Text = v81
        instance66.Font = Enum.Font.Cartoon
        instance66.TextSize = 10
        instance66.TextColor3 = Color3.fromRGB(150, 150, 160)
        instance66.Size = UDim2.new(1, -40, 0, 16)
        instance66.Position = UDim2.new(0, 42, 0, 24)
        instance66.BackgroundTransparency = 1
        instance66.TextXAlignment = Enum.TextXAlignment.Left
      end

      local instance67 = Instance.new("TextButton", frame2)
      instance67.Text = "X"
      instance67.Font = Enum.Font.Cartoon
      instance67.TextColor3 = v80.red
      instance67.TextSize = 16
      instance67.Size = UDim2.new(0, 32, 0, 32)
      instance67.Position = UDim2.new(1, -40, 0, 7)
      instance67.BackgroundColor3 = Color3.fromRGB(50, 18, 18)
      instance67.BorderSizePixel = 0

      f39(instance67, 16)

      instance67.ZIndex = 11

      instance67.MouseEnter:Connect(function()
        f38(instance67, 0.12, { BackgroundColor3 = v80.red, TextColor3 = Color3.new(1, 1, 1) })
      end)

      instance67.MouseLeave:Connect(function()
        f38(instance67, 0.12, {
          BackgroundColor3 = Color3.fromRGB(50, 18, 18),
          TextColor3 = v80.red,
        })
      end)

      instance67.MouseButton1Click:Connect(f43)

      local instance68 = Instance.new("Frame", frame)
      instance68.Size = UDim2.new(1, 0, 0, 1)
      instance68.Position = UDim2.new(0, 0, 0, 46)
      instance68.BackgroundColor3 = v80.border
      instance68.BorderSizePixel = 0

      local instance69 = Instance.new("Frame", frame)
      instance69.Size = UDim2.new(0, 1, 1, -60)
      instance69.Position = UDim2.new(0, 172, 0, 50)
      instance69.BackgroundColor3 = v80.border
      instance69.BorderSizePixel = 0

      frame2.InputBegan:Connect(function(input5)
        if input5.UserInputType == Enum.UserInputType.MouseButton1
          or input5.UserInputType == Enum.UserInputType.Touch then
          f44(frame, input5)
        end
      end)

      local textButton2 = Instance.new("TextButton")
      textButton2.Text = ""
      textButton2.Size = UDim2.new(0, 18, 0, 18)
      textButton2.Position = UDim2.new(1, -9, 1, -9)
      textButton2.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
      textButton2.BorderSizePixel = 0
      textButton2.AnchorPoint = Vector2.new(0.5, 0.5)
      textButton2.AutoButtonColor = false
      textButton2.ZIndex = 20

      f39(textButton2, 9)
      textButton2.Parent = frame
      local v91, getMouseLocation, absoluteSize

      textButton2.InputBegan:Connect(function(input6)
        if input6.UserInputType == Enum.UserInputType.MouseButton1
          or input6.UserInputType == Enum.UserInputType.Touch then
          v91 = true
          getMouseLocation = userInputService:GetMouseLocation()
          absoluteSize = frame.AbsoluteSize

          input6.Changed:Connect(function()
            if input6.UserInputState == Enum.UserInputState.End then
              v91 = false
            end
          end)
        end
      end)

      f1(userInputService.InputChanged:Connect(function(input7)
        if v91
          and (input7.UserInputType == Enum.UserInputType.MouseMovement
            or input7.UserInputType == Enum.UserInputType.Touch) then
          local v92 = userInputService:GetMouseLocation() - getMouseLocation
          local v93 = math.clamp(absoluteSize.X + v92.X, 400, 720)
          local v94 = math.clamp(absoluteSize.Y + v92.Y, 280, 520)
          frame.Size = UDim2.new(0, v93, 0, v94)

          v86.w = v93
          v86.h = v94
        end
      end))

      local count = 0

      local function f45()
        count = count + 1
        return count
      end

      local v95 = {}
      local v96 = {}
      local v97 = {}
      local v98 = {}
      local v99 = 1

      local frame3 = Instance.new("Frame")
      frame3.Size = UDim2.new(0, 160, 1, -70)
      frame3.Position = UDim2.new(0, 12, 0, 60)
      frame3.BackgroundTransparency = 1
      frame3.Parent = frame

      local instance70 = Instance.new("UIListLayout", frame3)
      instance70.Padding = UDim.new(0, 6)
      instance70.SortOrder = Enum.SortOrder.LayoutOrder

      local frame4 = Instance.new("Frame")
      frame4.Size = UDim2.new(1, -186, 1, -60)
      frame4.Position = UDim2.new(0, 178, 0, 50)
      frame4.BackgroundTransparency = 1
      frame4.Parent = frame
      frame4.ClipsDescendants = true

      local function f46(p73)
        p73.GroupTransparency = 0
        p73.Position = UDim2.new(0, 0, 0, 0)
      end

      local function f47(p74, p75)
        for index10, value15 in ipairs(v95) do
          local v100 = index10 == p75

          f38(value15, 0.15, {
            BackgroundColor3 = v100 and v80.accent or Color3.fromRGB(25, 25, 30),
            TextColor3 = v100 and Color3.new(1, 1, 1) or v80.muted,
          })
        end
      end

      local function f48(p76)
        if p76 == v99 then
          return
        else
          for index11, value16 in ipairs(v97) do
            value16.Visible = false
            f46(value16)
            v96[index11].Visible = false
          end

          v99 = p76
          f47(p76, p76)

          local v101 = v97[p76]
          v101.Visible = true

          v96[p76].Visible = true

          v101.GroupTransparency = 1
          v101.Position = UDim2.new(0.02, 0, 0, 0)

          f18(
            v101, 0.2, { GroupTransparency = 0, Position = UDim2.new(0, 0, 0, 0) },
            Enum.EasingStyle.Quart
          ):Play()

          return
        end
      end

      local function f49(p77, p78)
        local textButton3 = Instance.new("TextButton")
        textButton3.Text = p77 .. "  " .. (v79[getgenv().Config.Language][p78] or p78)
        textButton3.Font = Enum.Font.Cartoon
        textButton3.TextColor3 = v80.muted
        textButton3.TextSize = 13
        textButton3.Size = UDim2.new(1, -4, 0, 36)
        textButton3.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        textButton3.BorderSizePixel = 0
        textButton3.AutoButtonColor = false

        f39(textButton3, 8)

        textButton3.LayoutOrder = #v95 + 1
        textButton3.Parent = frame3

        local v102 = #v95 + 1

        table.insert(v95, textButton3)
        table.insert(v98, { btn = textButton3, icon = p77, textKey = p78 })

        local tabWrap = Instance.new("CanvasGroup")
        tabWrap.Name = "TabWrap"
        tabWrap.Size = UDim2.new(1, 0, 1, 0)
        tabWrap.BackgroundTransparency = 1
        tabWrap.GroupTransparency = 0
        tabWrap.Visible = false
        tabWrap.Parent = frame4

        table.insert(v97, tabWrap)

        local scrollingFrame = Instance.new("ScrollingFrame")
        scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
        scrollingFrame.BackgroundTransparency = 1
        scrollingFrame.Visible = true
        scrollingFrame.ScrollBarThickness = 4
        scrollingFrame.ScrollBarImageColor3 = v80.accent
        scrollingFrame.BorderSizePixel = 0
        scrollingFrame.Parent = tabWrap
        scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

        local instance71 = Instance.new("UIPadding", scrollingFrame)
        instance71.PaddingTop = UDim.new(0, 4)
        instance71.PaddingBottom = UDim.new(0, 8)
        instance71.PaddingLeft = UDim.new(0, 6)
        instance71.PaddingRight = UDim.new(0, 10)

        local instance72 = Instance.new("UIListLayout", scrollingFrame)
        instance72.Padding = UDim.new(0, 10)
        instance72.SortOrder = Enum.SortOrder.LayoutOrder

        instance72:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
          scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, instance72.AbsoluteContentSize.Y
            + instance71.PaddingTop.Offset + instance71.PaddingBottom.Offset + 4)
        end)

        table.insert(v96, scrollingFrame)
        textButton3.MouseButton1Click:Connect(function() f48(v102) end)
        return scrollingFrame
      end

      local v103 = f49("◉", "visuals")
      local v104 = f49("◆", "combat")
      local v105 = f49("▲", "movement")
      local v106 = f49("■", "skins")
      local v107 = f49("◇", "telegram")
      local v108 = f49("○", "account")
      local v109 = f49("▣", "settings")
      local v110 = {}
      local v111

      f1(userInputService.InputChanged:Connect(function(input8)
        if v111
          and (input8.UserInputType == Enum.UserInputType.MouseMovement
            or input8.UserInputType == Enum.UserInputType.Touch) then
          v111.setValue(
            input8.Position.X - v111.track.AbsolutePosition.X, v111.track.AbsoluteSize.X
          )
        end
      end))

      f1(userInputService.InputEnded:Connect(function(input9)
        if (input9.UserInputType == Enum.UserInputType.MouseButton1
            or input9.UserInputType == Enum.UserInputType.Touch)
          and v111 then
          if v111.scrollFrame then
            v111.scrollFrame.ScrollingEnabled = true
          end

          v111 = nil
        end
      end))

      local function f50(parent2, p79, p80, p81)
        local frame5 = Instance.new("Frame")
        frame5.Size = UDim2.new(1, 0, 0, 42)
        frame5.BackgroundColor3 = v80.card
        frame5.BorderSizePixel = 0

        f39(frame5, 10)
        f40(frame5, v80.border)

        frame5.Parent = parent2
        frame5.LayoutOrder = f45()

        local instance73 = Instance.new("TextLabel", frame5)
        instance73.Text = v79[getgenv().Config.Language][p79] or p79
        instance73.Font = Enum.Font.Cartoon
        instance73.TextColor3 = v80.text
        instance73.TextSize = 13
        instance73.Position = UDim2.new(0, 12, 0, 0)
        instance73.Size = UDim2.new(0.7, 0, 1, 0)
        instance73.BackgroundTransparency = 1
        instance73.TextXAlignment = Enum.TextXAlignment.Left

        table.insert(v110, { obj = instance73, key = p79, type = "text" })

        local instance74 = Instance.new("TextButton", frame5)
        instance74.Text = ""
        instance74.Size = UDim2.new(0, 44, 0, 24)
        instance74.Position = UDim2.new(1, -54, 0.5, -12)

        instance74.BackgroundColor3 = getgenv().Config[p80] and v80.accent
          or Color3.fromRGB(50, 50, 55)

        instance74.BorderSizePixel = 0

        f39(instance74, 12)

        local instance75 = Instance.new("Frame", instance74)
        instance75.Size = UDim2.new(0, 18, 0, 18)

        instance75.Position = getgenv().Config[p80] and UDim2.new(1, -20, 0.5, -9)
          or UDim2.new(0, 3, 0.5, -9)

        instance75.BackgroundColor3 = Color3.new(1, 1, 1)
        instance75.BorderSizePixel = 0

        f39(instance75, 9)

        instance74.MouseButton1Click:Connect(function()
          getgenv().Config[p80] = not getgenv().Config[p80]
          local v112 = getgenv().Config[p80]

          f38(instance74, 0.2, {
            BackgroundColor3 = v112 and v80.accent or Color3.fromRGB(50, 50, 55),
          })

          f38(instance75, 0.2, {
            Position = v112 and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
          })

          if p81 then
            p81(v112)
          end

          f29()
        end)

        return frame5
      end

      local function f51(p82, p83, p84, p85, p86, p87)
        local frame6 = Instance.new("Frame")
        frame6.Size = UDim2.new(1, 0, 0, 50)
        frame6.BackgroundColor3 = v80.card
        frame6.BorderSizePixel = 0

        f39(frame6, 10)
        f40(frame6, v80.border)

        frame6.Parent = p82
        frame6.LayoutOrder = f45()

        local instance76 = Instance.new("TextLabel", frame6)
        instance76.Font = Enum.Font.Cartoon
        instance76.TextColor3 = v80.text
        instance76.TextSize = 13
        instance76.Position = UDim2.new(0, 12, 0, 4)
        instance76.Size = UDim2.new(0.6, 0, 0, 20)
        instance76.BackgroundTransparency = 1
        instance76.TextXAlignment = Enum.TextXAlignment.Left

        local instance77 = Instance.new("TextLabel", frame6)
        instance77.Font = Enum.Font.Cartoon
        instance77.TextColor3 = v80.accent
        instance77.TextSize = 13
        instance77.Position = UDim2.new(0.7, 0, 0, 4)
        instance77.Size = UDim2.new(0.3, -12, 0, 20)
        instance77.BackgroundTransparency = 1
        instance77.TextXAlignment = Enum.TextXAlignment.Right

        local instance78 = Instance.new("TextButton", frame6)
        instance78.Text = ""
        instance78.Size = UDim2.new(1, -24, 0, 10)
        instance78.Position = UDim2.new(0, 12, 0, 32)
        instance78.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
        instance78.BorderSizePixel = 0

        f39(instance78, 5)
        instance78.AutoButtonColor = false

        local instance79 = Instance.new("Frame", instance78)
        instance79.Size = UDim2.new((getgenv().Config[p84] - p85) / (p86 - p85), 0, 1, 0)
        instance79.BackgroundColor3 = v80.accent
        instance79.BorderSizePixel = 0

        f39(instance79, 5)

        local instance80 = Instance.new("TextButton", instance78)
        instance80.Text = ""
        instance80.Size = UDim2.new(0, 20, 0, 20)

        instance80.Position = UDim2.new(
          (getgenv().Config[p84] - p85) / (p86 - p85), -10, 0.5, -10
        )

        instance80.BackgroundColor3 = Color3.new(1, 1, 1)
        instance80.BorderSizePixel = 0

        f39(instance80, 10)
        f40(instance80, v80.accent, 1.5)
        instance80.AutoButtonColor = false
        local v113 = getgenv().Config[p84]
        local count2 = 0

        local function f52()
          local v114 = getgenv().Config[p84]
          instance76.Text = (v79[getgenv().Config.Language][p83] or p83) .. ": "
          count2 = count2 + 1
          local v115 = count2

          if v114 == v113 then
            instance77.Text = tostring(v114)
            return
          end

          local v116 = v113
          v113 = v114
          local v117 = v114 - v116
          local v118 = math.max(4, math.min(14, math.abs(v117)))

          task.spawn(function()
            for k = 1, v118 do
              if v115 ~= count2 then
                return
              end

              instance77.Text = tostring(math.floor(v116 + v117 * (k / v118) + 0.5))
              task.wait(0.018)
            end

            if v115 == count2 then
              instance77.Text = tostring(v114)
            end
          end)
        end

        f52()

        table.insert(v110, {
          obj = instance76,
          key = p83,
          type = "text",
          refresh = f52,
        })

        local function f53(p88, p89)
          if p89 <= 0 then
            return
          else
            local v119 = math.clamp(p88 / p89, 0, 1)
            local v120 = math.floor((p85 + v119 * (p86 - p85)) / p87 + 0.5)
            local v121 = math.clamp(v120 * p87, p85, p86)
            getgenv().Config[p84] = v121
            instance79.Size = UDim2.new(v119, 0, 1, 0)
            instance80.Position = UDim2.new(v119, -10, 0.5, -10)
            f52()
            return
          end
        end

        local function f54()
          if p82 and p82:IsA("ScrollingFrame") then
            p82.ScrollingEnabled = false
          end

          v111 = { track = instance78, setValue = f53, scrollFrame = p82 }
        end

        instance78.InputBegan:Connect(function(input10)
          if input10.UserInputType == Enum.UserInputType.MouseButton1
            or input10.UserInputType == Enum.UserInputType.Touch then
            f54()
            f53(input10.Position.X - instance78.AbsolutePosition.X, instance78.AbsoluteSize.X)
          end
        end)

        instance80.InputBegan:Connect(function(input11)
          if input11.UserInputType == Enum.UserInputType.MouseButton1
            or input11.UserInputType == Enum.UserInputType.Touch then
            f54()
            f53(input11.Position.X - instance78.AbsolutePosition.X, instance78.AbsoluteSize.X)
          end
        end)

        return frame6
      end

      local function f55(p90)
        local parent3 = p90

        while parent3 do
          if parent3:IsA("ScrollingFrame") then
            return parent3
          end

          parent3 = parent3.Parent
        end

        return nil
      end

      local function f56(p91, p92, p93)
        local instance81 = Instance.new("Frame", p91)
        instance81.Size = UDim2.new(1, 0, 0, 36)
        instance81.BackgroundColor3 = Color3.fromRGB(38, 38, 44)
        instance81.BorderSizePixel = 0

        f39(instance81, 8)

        local instance82 = Instance.new("TextLabel", instance81)
        instance82.Text = v79[getgenv().Config.Language][p92] or p92
        instance82.Font = Enum.Font.Cartoon
        instance82.TextColor3 = v80.text
        instance82.TextSize = 12
        instance82.Position = UDim2.new(0, 10, 0, 0)
        instance82.Size = UDim2.new(0.7, 0, 1, 0)
        instance82.BackgroundTransparency = 1
        instance82.TextXAlignment = Enum.TextXAlignment.Left

        table.insert(v110, { obj = instance82, key = p92, type = "text" })

        local instance83 = Instance.new("TextButton", instance81)
        instance83.Text = ""
        instance83.Size = UDim2.new(0, 36, 0, 20)
        instance83.Position = UDim2.new(1, -46, 0.5, -10)

        instance83.BackgroundColor3 = getgenv().Config[p93] and v80.accent
          or Color3.fromRGB(55, 55, 60)

        instance83.BorderSizePixel = 0

        f39(instance83, 10)
        instance83.AutoButtonColor = false

        local instance84 = Instance.new("Frame", instance83)
        instance84.Size = UDim2.new(0, 14, 0, 14)

        instance84.Position = getgenv().Config[p93] and UDim2.new(1, -16, 0.5, -7)
          or UDim2.new(0, 2, 0.5, -7)

        instance84.BackgroundColor3 = Color3.new(1, 1, 1)
        instance84.BorderSizePixel = 0

        f39(instance84, 7)

        instance83.MouseButton1Click:Connect(function()
          getgenv().Config[p93] = not getgenv().Config[p93]
          local v122 = getgenv().Config[p93]

          f38(instance83, 0.2, {
            BackgroundColor3 = v122 and v80.accent or Color3.fromRGB(55, 55, 60),
          })

          f38(instance84, 0.2, {
            Position = v122 and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7),
          })

          f29()
        end)
      end

      local function f57(p94, p95, p96, p97, p98, p99)
        local instance85 = Instance.new("Frame", p94)
        instance85.Size = UDim2.new(1, 0, 0, 44)
        instance85.BackgroundColor3 = Color3.fromRGB(38, 38, 44)
        instance85.BorderSizePixel = 0

        f39(instance85, 8)

        local instance86 = Instance.new("TextLabel", instance85)
        instance86.Font = Enum.Font.Cartoon
        instance86.TextColor3 = v80.text
        instance86.TextSize = 11
        instance86.Position = UDim2.new(0, 10, 0, 4)
        instance86.Size = UDim2.new(0.6, 0, 0, 16)
        instance86.BackgroundTransparency = 1
        instance86.TextXAlignment = Enum.TextXAlignment.Left

        local instance87 = Instance.new("TextLabel", instance85)
        instance87.Font = Enum.Font.Cartoon
        instance87.TextColor3 = v80.accent
        instance87.TextSize = 11
        instance87.Position = UDim2.new(0.7, 0, 0, 4)
        instance87.Size = UDim2.new(0.3, -10, 0, 16)
        instance87.BackgroundTransparency = 1
        instance87.TextXAlignment = Enum.TextXAlignment.Right

        local instance88 = Instance.new("TextButton", instance85)
        instance88.Text = ""
        instance88.Size = UDim2.new(1, -20, 0, 8)
        instance88.Position = UDim2.new(0, 10, 0, 26)
        instance88.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
        instance88.BorderSizePixel = 0

        f39(instance88, 4)
        instance88.AutoButtonColor = false

        local instance89 = Instance.new("Frame", instance88)
        instance89.Size = UDim2.new((getgenv().Config[p96] - p97) / (p98 - p97), 0, 1, 0)
        instance89.BackgroundColor3 = v80.accent
        instance89.BorderSizePixel = 0

        f39(instance89, 4)

        local instance90 = Instance.new("TextButton", instance88)
        instance90.Text = ""
        instance90.Size = UDim2.new(0, 16, 0, 16)

        instance90.Position = UDim2.new(
          (getgenv().Config[p96] - p97) / (p98 - p97), -8, 0.5, -8
        )

        instance90.BackgroundColor3 = Color3.new(1, 1, 1)
        instance90.BorderSizePixel = 0

        f39(instance90, 8)
        f40(instance90, v80.accent, 1.5)
        instance90.AutoButtonColor = false

        local function f58()
          instance86.Text = (v79[getgenv().Config.Language][p95] or p95) .. ": "
          instance87.Text = tostring(getgenv().Config[p96])
        end

        f58()

        table.insert(v110, {
          obj = instance86,
          key = p95,
          type = "text",
          refresh = f58,
        })

        local function f59(p100, p101)
          if p101 <= 0 then
            return
          else
            local v123 = math.clamp(p100 / p101, 0, 1)
            local v124 = math.floor((p97 + v123 * (p98 - p97)) / p99 + 0.5)
            local v125 = math.clamp(v124 * p99, p97, p98)
            getgenv().Config[p96] = v125
            instance89.Size = UDim2.new(v123, 0, 1, 0)
            instance90.Position = UDim2.new(v123, -8, 0.5, -8)
            f58()
            return
          end
        end

        local function f60()
          local v126 = f55(instance85)

          if v126 then
            v126.ScrollingEnabled = false
          end

          v111 = { track = instance88, setValue = f59, scrollFrame = v126 }
        end

        instance88.InputBegan:Connect(function(input12)
          if input12.UserInputType == Enum.UserInputType.MouseButton1
            or input12.UserInputType == Enum.UserInputType.Touch then
            f60()
            f59(input12.Position.X - instance88.AbsolutePosition.X, instance88.AbsoluteSize.X)
          end
        end)

        instance90.InputBegan:Connect(function(input13)
          if input13.UserInputType == Enum.UserInputType.MouseButton1
            or input13.UserInputType == Enum.UserInputType.Touch then
            f60()
            f59(input13.Position.X - instance88.AbsolutePosition.X, instance88.AbsoluteSize.X)
          end
        end)
      end

      local function f61(p102, p103, p104, p105, p106, p107)
        local instance91 = Instance.new("Frame", p102)
        instance91.Size = UDim2.new(1, 0, 0, 36)
        instance91.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
        instance91.BorderSizePixel = 0

        f39(instance91, 8)
        instance91.ClipsDescendants = true

        local instance92 = Instance.new("TextLabel", instance91)
        instance92.Text = v79[getgenv().Config.Language][p103] or p103
        instance92.Font = Enum.Font.Cartoon
        instance92.TextColor3 = v80.text
        instance92.TextSize = 12
        instance92.Position = UDim2.new(0, 10, 0, 0)
        instance92.Size = UDim2.new(0.7, 0, 0, 36)
        instance92.BackgroundTransparency = 1
        instance92.TextXAlignment = Enum.TextXAlignment.Left

        table.insert(v110, { obj = instance92, key = p103, type = "text" })

        local instance93 = Instance.new("TextButton", instance91)
        instance93.Text = ""
        instance93.Size = UDim2.new(0, 36, 0, 20)
        instance93.Position = UDim2.new(1, -46, 0, 8)

        instance93.BackgroundColor3 = getgenv().Config[p104] and v80.accent
          or Color3.fromRGB(55, 55, 60)

        instance93.BorderSizePixel = 0

        f39(instance93, 10)
        instance93.AutoButtonColor = false

        local instance94 = Instance.new("Frame", instance93)
        instance94.Size = UDim2.new(0, 14, 0, 14)

        instance94.Position = getgenv().Config[p104] and UDim2.new(1, -16, 0.5, -7)
          or UDim2.new(0, 2, 0.5, -7)

        instance94.BackgroundColor3 = Color3.new(1, 1, 1)
        instance94.BorderSizePixel = 0

        f39(instance94, 7)

        local instance95 = Instance.new("Frame", instance91)
        instance95.Size = UDim2.new(1, -16, 0, 0)
        instance95.Position = UDim2.new(0, 8, 0, 36)
        instance95.BackgroundTransparency = 1
        instance95.ClipsDescendants = true

        local instance96 = Instance.new("UIListLayout", instance95)
        instance96.Padding = UDim.new(0, 6)
        instance96.SortOrder = Enum.SortOrder.LayoutOrder

        if p106 then
          p106(instance95)
        end

        local function f62(p108, p109)
          local v127 = p108 and 36 + p105 or 36
          local v128 = p108 and p105 or 0

          if p109 then
            f38(instance91, 0.3, { Size = UDim2.new(1, 0, 0, v127) }, Enum.EasingStyle.Quart):Play()
            f38(instance95, 0.3, { Size = UDim2.new(1, -16, 0, v128) }, Enum.EasingStyle.Quart):Play()
          else
            instance91.Size = UDim2.new(1, 0, 0, v127)
            instance95.Size = UDim2.new(1, -16, 0, v128)
          end
        end

        f62(getgenv().Config[p104], false)

        instance93.MouseButton1Click:Connect(function()
          getgenv().Config[p104] = not getgenv().Config[p104]
          local v129 = getgenv().Config[p104]

          f38(instance93, 0.2, {
            BackgroundColor3 = v129 and v80.accent or Color3.fromRGB(55, 55, 60),
          })

          f38(instance94, 0.2, {
            Position = v129 and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7),
          })

          f62(v129, true)

          if p107 then
            p107(v129)
          end

          f29()
        end)
      end

      local function f63(p110, p111, p112, p113, p114, p115, p116)
        local instance97 = Instance.new("Frame", p110)
        instance97.Size = UDim2.new(1, 0, 0, 42)
        instance97.BackgroundColor3 = v80.card
        instance97.BorderSizePixel = 0
        instance97.ClipsDescendants = true
        instance97.LayoutOrder = f45()

        f39(instance97, 10)
        f40(instance97, v80.border, 1)

        local instance98 = Instance.new("TextLabel", instance97)
        instance98.Text = v79[getgenv().Config.Language][p111] or p111
        instance98.Font = Enum.Font.Cartoon
        instance98.TextColor3 = v80.text
        instance98.TextSize = 13
        instance98.Position = UDim2.new(0, 12, 0, 0)
        instance98.Size = UDim2.new(0.7, 0, 0, 42)
        instance98.BackgroundTransparency = 1
        instance98.TextXAlignment = Enum.TextXAlignment.Left

        table.insert(v110, { obj = instance98, key = p111, type = "text" })

        local instance99 = Instance.new("TextButton", instance97)
        instance99.Text = ""
        instance99.Size = UDim2.new(0, 44, 0, 24)
        instance99.Position = UDim2.new(1, -54, 0, 9)

        instance99.BackgroundColor3 = getgenv().Config[p112] and v80.accent
          or Color3.fromRGB(50, 50, 55)

        instance99.BorderSizePixel = 0

        f39(instance99, 12)
        instance99.AutoButtonColor = false

        local instance100 = Instance.new("Frame", instance99)
        instance100.Size = UDim2.new(0, 18, 0, 18)

        instance100.Position = getgenv().Config[p112] and UDim2.new(1, -20, 0.5, -9)
          or UDim2.new(0, 3, 0.5, -9)

        instance100.BackgroundColor3 = Color3.new(1, 1, 1)
        instance100.BorderSizePixel = 0

        f39(instance100, 9)

        local instance101 = Instance.new("Frame", instance97)
        instance101.Size = UDim2.new(1, -24, 0, 0)
        instance101.Position = UDim2.new(0, 12, 0, 42)
        instance101.BackgroundTransparency = 1
        instance101.ClipsDescendants = true

        local instance102 = Instance.new("UIListLayout", instance101)
        instance102.Padding = UDim.new(0, 6)
        instance102.SortOrder = Enum.SortOrder.LayoutOrder

        if p114 then
          p114(instance101)
        end

        local function f64(p117, p118)
          local v130 = p116 and p116() or p113
          local v131 = p117 and 42 + v130 or 42
          local v132 = p117 and v130 or 0

          if p118 then
            f38(instance97, 0.35, { Size = UDim2.new(1, 0, 0, v131) }, Enum.EasingStyle.Quart):Play()

            f38(
              instance101, 0.35, { Size = UDim2.new(1, -24, 0, v132) }, Enum.EasingStyle.Quart
            ):Play()
          else
            instance97.Size = UDim2.new(1, 0, 0, v131)
            instance101.Size = UDim2.new(1, -24, 0, v132)
          end
        end

        f64(getgenv().Config[p112], false)

        instance99.MouseButton1Click:Connect(function()
          getgenv().Config[p112] = not getgenv().Config[p112]
          local v133 = getgenv().Config[p112]

          f38(instance99, 0.2, {
            BackgroundColor3 = v133 and v80.accent or Color3.fromRGB(50, 50, 55),
          })

          f38(instance100, 0.2, {
            Position = v133 and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
          })

          f64(v133, true)

          if p115 then
            p115(v133)
          end

          f29()
        end)

        return instance97, function()
          local v134 = p116 and p116() or p113

          if getgenv().Config[p112] then
            f38(
              instance97, 0.3, { Size = UDim2.new(1, 0, 0, 42 + v134) }, Enum.EasingStyle.Quart
            ):Play()

            f38(instance101, 0.3, { Size = UDim2.new(1, -24, 0, v134) }, Enum.EasingStyle.Quart):Play()
          end
        end
      end

      local assets = replicatedStorage:FindFirstChild("Assets")
        or replicatedStorage:WaitForChild("Assets", 5)

      local skins = assets
        and (assets:FindFirstChild("Skins") or assets:WaitForChild("Skins", 5))

      local weapons = assets and assets:FindFirstChild("Weapons")

      local function f65(p119)
        if not p119 then
          return false
        elseif string.find(p119, "Knife") then
          return true
        elseif p119 == "Karambit" then
          return true
        elseif string.find(p119, "Bayonet") then
          return true
        else
          if string.find(p119, "Saber") then
            return true
          end

          return false
        end
      end

      local function f66(p120, p121)
        if not skins then
          return
        else
          local findFirstChild = skins:FindFirstChild(p120)

          if not findFirstChild then
            return
          else
            local findFirstChild2 = findFirstChild:FindFirstChild(p121)
              or findFirstChild:GetChildren()[1]

            if not findFirstChild2 then
              return
            else
              local camera = findFirstChild2:FindFirstChild("Camera")
                or findFirstChild2:FindFirstChild("Character")

              local findFirstChild3 = camera
                and (camera:FindFirstChild(getgenv().Config.SelectedWear)
                  or camera:FindFirstChild("Factory New") or camera:GetChildren()[1])

              if not findFirstChild3 then
                return
              else
                local leftArm = findFirstChild3:FindFirstChild("Left Arm")
                local rightArm = findFirstChild3:FindFirstChild("Right Arm")

                for index12, value17 in ipairs(currentCamera:GetChildren()) do
                  if value17:IsA("Model") then
                    for index13, value18 in ipairs(value17:GetDescendants()) do
                      if value18:IsA("MeshPart") then
                        if value18.Name == "Left Arm" or value18.Name == "Right Arm" then
                          for index14, value19 in ipairs(value18:GetChildren()) do
                            if value19:IsA("SurfaceAppearance") then
                              value19:Destroy()
                            end
                          end
                        elseif value18.Name == "Glove" then
                          local parent4 = value18.Parent and value18.Parent.Name == "Left Arm"
                              and leftArm
                            or rightArm

                          if parent4 then
                            local surfaceAppearance = value18:FindFirstChildOfClass("SurfaceAppearance")
                            local v135 = not surfaceAppearance
                            local v136 = p120 .. "_" .. p121

                            if v135 or surfaceAppearance:GetAttribute("CustomApplied") ~= v136 then
                              if surfaceAppearance then
                                surfaceAppearance:Destroy()
                              end

                              local clone = parent4:Clone()
                              clone:SetAttribute("CustomApplied", v136)
                              clone.Parent = value18
                            end
                          end
                        end
                      end
                    end
                  end
                end

                return
              end
            end
          end
        end
      end

      local function f67(p122, p123, p124, p125)
        if not skins or not p122 or not p123 or not p124 then
          return
        else
          local v137 = p123

          if p125 and f65(p123) then
            v137 = p125
          end

          local findFirstChild4 = skins:FindFirstChild(v137)

          if not findFirstChild4 then
            return
          else
            local findFirstChild5 = findFirstChild4:FindFirstChild(p124)
              or findFirstChild4:GetChildren()[1]

            if not findFirstChild5 then
              return
            else
              local character = findFirstChild5:FindFirstChild("Character")
                or findFirstChild5:FindFirstChild("Camera")

              local findFirstChild6 = character
                and (character:FindFirstChild(getgenv().Config.SelectedWear)
                  or character:FindFirstChild("Factory New") or character:GetChildren()[1])

              if not findFirstChild6 then
                return
              else
                local v138 = v137 .. "_" .. p124

                for index15, value20 in ipairs(findFirstChild6:GetChildren()) do
                  if value20:IsA("SurfaceAppearance") then
                    for index16, value21 in ipairs(p122:GetDescendants()) do
                      if value21:IsA("MeshPart") and value21.Name == value20.Name then
                        local surfaceAppearance2 = value21:FindFirstChildOfClass("SurfaceAppearance")

                        if not surfaceAppearance2
                          or surfaceAppearance2:GetAttribute("CustomApplied") ~= v138 then
                          if surfaceAppearance2 then
                            surfaceAppearance2:Destroy()
                          end

                          local clone2 = value20:Clone()
                          clone2:SetAttribute("CustomApplied", v138)
                          clone2.Parent = value21
                        end
                      end
                    end
                  elseif value20:IsA("MeshPart") or value20:IsA("BasePart") then
                    for index17, value22 in ipairs(p122:GetDescendants()) do
                      if value22:IsA("MeshPart") and value22.Name == value20.Name then
                        local surfaceAppearance3 = value20:FindFirstChildOfClass("SurfaceAppearance")

                        if surfaceAppearance3 then
                          local surfaceAppearance4 = value22:FindFirstChildOfClass("SurfaceAppearance")
                          local v139 = not surfaceAppearance4
                          local v140 = v138 .. "_" .. value22.Name

                          if v139 or surfaceAppearance4:GetAttribute("CustomApplied") ~= v140 then
                            if surfaceAppearance4 then
                              surfaceAppearance4:Destroy()
                            end

                            local clone3 = surfaceAppearance3:Clone()
                            clone3:SetAttribute("CustomApplied", v140)
                            clone3.Parent = value22
                          end
                        end
                      end
                    end
                  end
                end

                return
              end
            end
          end
        end
      end

      local v141 = { Weapons = {}, Knives = {}, Gloves = {} }

      local function f68()
        table.clear(v141.Weapons)
        table.clear(v141.Knives)
        table.clear(v141.Gloves)

        if not skins then
          return
        end

        for index18, value23 in ipairs(skins:GetChildren()) do
          local name = value23.Name
          local v142 = {}

          for index19, value24 in ipairs(value23:GetChildren()) do
            table.insert(v142, value24.Name)
          end

          table.sort(v142)

          if f65(name) then
            v141.Knives[name] = v142
          elseif string.find(name, "Glove") or string.find(name, "Wraps") then
            v141.Gloves[name] = v142
          else
            v141.Weapons[name] = v142
          end
        end
      end

      f68()

      local v143 = {}

      for key6, value25 in pairs(v141.Knives) do
        table.insert(v143, key6)
      end

      table.sort(v143)
      local v144 = {}

      if weapons then
        for index20, value26 in ipairs(weapons:GetChildren()) do
          if f65(value26.Name) then
            local camera2 = value26:FindFirstChild("Camera")

            if camera2 and camera2:FindFirstChild("Weapon") then
              table.insert(v144, value26.Name)
            end
          end
        end
      end

      table.sort(v144)

      if #v144 == 0 then
        for index21, value27 in ipairs(v143) do
          table.insert(v144, value27)
        end
      end

      getgenv().SXNT_AvailableKnives = v144
      local v145 = 0

      f1(runService.Heartbeat:Connect(function(delta)
        if not getgenv().Config.SkinChanger_Enabled then
          return
        end

        v145 = v145 + delta

        if v145 < 0.15 then
          return
        end

        v145 = 0

        for index22, value28 in ipairs(currentCamera:GetChildren()) do
          if value28:IsA("Model") then
            local name2 = value28.Name

            if not f65(name2) then
              local v146 = getgenv().Config.ConfiguredSkins[name2]

              if v146 then
                f67(value28, name2, v146, nil)
              end
            end

            for index23, value29 in ipairs(value28:GetDescendants()) do
              if value29:IsA("BasePart")
                and (value29.Name == "ViewmodelLight" or value29.Name == "CameraModel3"
                  or value29.Name == "CameraModel4") then
                value29.Transparency = 1
              end
            end
          end
        end

        if getgenv().Config.SelectedGlove and getgenv().Config.SelectedGloveSkin then
          f66(getgenv().Config.SelectedGlove, getgenv().Config.SelectedGloveSkin)
        end
      end))

      local circle = Drawing.new("Circle")
      circle.Thickness = 1.5
      circle.NumSides = 64
      circle.Radius = getgenv().Config.FOVRadius
      circle.Filled = false
      circle.Color = getgenv().Config.FOVColor
      circle.Transparency = 0.7
      circle.Visible = getgenv().Config.FOVCircle

      table.insert(getgenv().SXNT_Drawings, circle)

      local function f69(p126)
        if not p126 then
          return nil
        end

        if v5 then
          local v147, v148 = pcall(function() return v5.getPlayerCharacter(p126) end)

          if v147 and v148 and typeof(v148) == "Instance" and v148:IsA("Model") then
            return v148
          end
        end

        if p126.Character and p126.Character:IsA("Model") then
          return p126.Character
        else
          local characters = workspaceService:FindFirstChild("Characters")

          if characters then
            local findFirstChild7 = characters:FindFirstChild(p126.Name)

            if findFirstChild7 and findFirstChild7:IsA("Model") then
              return findFirstChild7
            end

            return nil
          end

          return nil
        end
      end

      local function f70(p127, p128)
        local v149 = p127

        if not v149 and p128 then
          v149 = f69(p128)
        end

        if not v149 then
          return nil
        else
          local equippedGloves = v149:GetAttribute("EquippedGloves")

          if typeof(equippedGloves) == "string" then
            if string.find(equippedGloves, "CT Glove") then
              return "CT"
            end

            if string.find(equippedGloves, "T Glove") then
              return "T"
            end

            return nil
          end

          return nil
        end
      end

      local v150 = {}

      local function f71(p129)
        if v150[p129] then
          return
        else
          local v151 = {
            BoxOutline = Drawing.new("Square"),
            Box = Drawing.new("Square"),
            HealthBarOutline = Drawing.new("Line"),
            HealthBar = Drawing.new("Line"),
            HealthBarTop = Drawing.new("Circle"),
            HealthBarBot = Drawing.new("Circle"),
            NameTop = Drawing.new("Text"),
            DistBot = Drawing.new("Text"),
            Tracer = Drawing.new("Line"),
          }

          v151.BoxOutline.Thickness = 3
          v151.BoxOutline.Color = Color3.fromRGB(0, 0, 0)
          v151.BoxOutline.Filled = false
          v151.BoxOutline.Visible = false
          v151.Box.Thickness = 1.5
          v151.Box.Filled = false
          v151.Box.Visible = false
          v151.HealthBarOutline.Thickness = 4
          v151.HealthBarOutline.Color = Color3.fromRGB(0, 0, 0)
          v151.HealthBarOutline.Visible = false
          v151.HealthBar.Thickness = 2
          v151.HealthBar.Visible = false

          for index24, value30 in ipairs({ v151.HealthBarTop, v151.HealthBarBot }) do
            value30.Filled = true
            value30.NumSides = 16
            value30.Radius = 1
            value30.Visible = false
          end

          v151.NameTop.Size = 13
          v151.NameTop.Center = true
          v151.NameTop.Outline = true
          v151.NameTop.Color = Color3.fromRGB(255, 255, 255)
          v151.NameTop.Visible = false
          v151.DistBot.Size = 12
          v151.DistBot.Center = true
          v151.DistBot.Outline = true
          v151.DistBot.Color = Color3.fromRGB(200, 200, 200)
          v151.DistBot.Visible = false
          v151.Tracer.Thickness = 1.2
          v151.Tracer.Visible = false

          for key7, value31 in pairs(v151) do
            table.insert(getgenv().SXNT_Drawings, value31)
          end

          v150[p129] = v151
          return
        end
      end

      local function f72(p130)
        local v152 = v150[p130]

        if v152 then
          for key8, value32 in pairs(v152) do
            local v153 = value32
            pcall(function() v153:Remove() end)
            local v154 = table.find(getgenv().SXNT_Drawings, v153)

            if v154 then
              table.remove(getgenv().SXNT_Drawings, v154)
            end
          end

          v150[p130] = nil
        end
      end

      local function f73(p131, p132)
        if getgenv().Config.Wallbang then
          return true
        else
          local position4 = currentCamera.CFrame.Position
          local position5 = p131.Position

          local raycastParams = RaycastParams.new()
          raycastParams.FilterType = Enum.RaycastFilterType.Exclude
          raycastParams.FilterDescendantsInstances = { currentCamera, f69(localPlayer) }

          local raycast = workspaceService:Raycast(
            position4, position5 - position4, raycastParams
          )

          if raycast and raycast.Instance then
            return raycast.Instance:IsDescendantOf(p132)
          end

          return true
        end
      end

      local v155

      local function f74()
        if not getgenv().Config.SilentAim then
          v155 = nil
          return
        else
          local vector = Vector2.new(
            currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y / 2
          )

          local v156 = f70(f69(localPlayer), localPlayer)
          local huge = math.huge
          local v157 = nil
          local wallbang = getgenv().Config.Wallbang and 600 or getgenv().Config.FOVRadius

          for index25, value33 in ipairs(players:GetPlayers()) do
            if value33 ~= localPlayer then
              local v158 = f69(value33)

              if v158 then
                local dead = v158:GetAttribute("Dead")
                local health = v158:GetAttribute("Health") or 100

                if not (dead or false) and health > 0 then
                  local v159 = true

                  if getgenv().Config.SilentTeamCheck and v156 then
                    local v160 = f70(v158, value33)
                    v159 = v160 == nil or v156 == nil or v160 ~= v156
                  end

                  if v159 then
                    local head = v158:FindFirstChild("Head")
                      or v158:FindFirstChild("UpperTorso") or v158:FindFirstChild("Torso")
                      or v158:FindFirstChild("HumanoidRootPart")

                    if head and (getgenv().Config.Wallbang or f73(head, v158)) then
                      local v161, v162 = currentCamera:WorldToViewportPoint(head.Position)

                      if v162 and v161.Z > 0 then
                        local magnitude = (Vector2.new(v161.X, v161.Y) - vector).Magnitude

                        if magnitude <= wallbang and magnitude < huge then
                          huge = magnitude
                          v157 = head
                        end
                      end
                    end
                  end
                end
              end
            end
          end

          v155 = v157
          return
        end
      end

      local function f75(p133)
        p133.BoxOutline.Visible = false
        p133.Box.Visible = false
        p133.HealthBarOutline.Visible = false
        p133.HealthBar.Visible = false
        p133.HealthBarTop.Visible = false
        p133.HealthBarBot.Visible = false
        p133.NameTop.Visible = false
        p133.DistBot.Visible = false
        p133.Tracer.Visible = false
      end

      local function f76(p134)
        local v163 = v150[p134]

        if v163 then
          pcall(function() f75(v163) end)
        end
      end

      getgenv().SXNT_ForceHideESP = function()
        for key9, value34 in pairs(v150) do
          local v164 = value34
          pcall(function() f75(v164) end)
        end
      end

      for index26, value35 in ipairs(players:GetPlayers()) do
        if value35 ~= localPlayer then
          f71(value35)
        end
      end

      f1(players.PlayerAdded:Connect(function(player)
        if player ~= localPlayer then
          f71(player)
          player.CharacterAdded:Connect(function() f76(player) end)
          player.CharacterRemoving:Connect(function() f76(player) end)
        end
      end))

      f1(players.PlayerRemoving:Connect(function(player2) f72(player2) end))

      for index27, value36 in ipairs(players:GetPlayers()) do
        local v165 = value36

        if v165 ~= localPlayer then
          v165.CharacterAdded:Connect(function() f76(v165) end)
          v165.CharacterRemoving:Connect(function() f76(v165) end)
        end
      end

      f1(runService.RenderStepped:Connect(function()
        local v166, v167 = pcall(function()
          circle.Position = Vector2.new(
            currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y / 2
          )

          circle.Radius = getgenv().Config.FOVRadius
          circle.Visible = getgenv().Config.FOVCircle and getgenv().Config.SilentAim
          circle.Color = v155 and Color3.fromRGB(255, 60, 60) or getgenv().Config.FOVColor

          f74()
          local config3 = getgenv().Config
          local v168 = f69(localPlayer)

          local humanoidRootPart = v168
            and (v168:FindFirstChild("HumanoidRootPart") or v168.PrimaryPart)

          local position6 = humanoidRootPart and humanoidRootPart.Position
          local v169 = f70(v168, localPlayer)

          for index28, value37 in ipairs(players:GetPlayers()) do
            if value37 ~= localPlayer then
              local v170 = v150[value37]

              if v170 then
                local v171 = f69(value37)

                local dead2 = v171
                dead2 = v171 and v171:GetAttribute("Dead")

                local health2 = v171 and (v171:GetAttribute("Health") or 0) or 0
                local maxHealth = v171 and (v171:GetAttribute("MaxHealth") or 100) or 100

                local humanoidRootPart2 = v171

                humanoidRootPart2 = v171
                  and (v171:FindFirstChild("HumanoidRootPart") or v171.PrimaryPart)

                local head2 = v171
                head2 = v171 and v171:FindFirstChild("Head")

                local v172 = true

                if config3.ESP_TeamCheck and v169 then
                  local v173 = f70(v171, value37)
                  v172 = v173 == nil or v169 == nil or v173 ~= v169
                end

                local espEnabled = config3.ESP_Enabled and v171 and humanoidRootPart2 and head2
                  and not dead2 and health2 > 0

                if config3.ESP_TeamCheck and not v172 then
                  espEnabled = false
                end

                if espEnabled then
                  local v174, v175 = currentCamera:WorldToViewportPoint(humanoidRootPart2.Position)

                  if v175 and v174.Z > 0 then
                    local worldToViewportPoint = currentCamera:WorldToViewportPoint(head2.Position + Vector3.new(
                      0, 0.5, 0
                    ))

                    local worldToViewportPoint2 = currentCamera:WorldToViewportPoint(humanoidRootPart2.Position - Vector3.new(
                      0, 3, 0
                    ))

                    local v176 = math.abs(worldToViewportPoint.Y - worldToViewportPoint2.Y)
                    local v177 = math.max(v176 * 0.55, 6)
                    local v178 = v174.X - v177 / 2
                    local y = worldToViewportPoint.Y
                    local enemyColor = v172 and config3.EnemyColor or config3.TeamColor

                    if config3.ESP_Box then
                      v170.BoxOutline.Position = Vector2.new(v178, y)
                      v170.BoxOutline.Size = Vector2.new(v177, v176)
                      v170.BoxOutline.Visible = true
                      v170.Box.Position = Vector2.new(v178, y)
                      v170.Box.Size = Vector2.new(v177, v176)
                      v170.Box.Color = enemyColor
                      v170.Box.Visible = true
                    else
                      v170.BoxOutline.Visible = false
                      v170.Box.Visible = false
                    end

                    if config3.ESP_Health then
                      local v179 = math.clamp(health2 / maxHealth, 0, 1)
                      local v180 = v178 - 6
                      local v181 = y + v176

                      v170.HealthBarOutline.From = Vector2.new(v180, y)
                      v170.HealthBarOutline.To = Vector2.new(v180, v181)
                      v170.HealthBarOutline.Visible = true

                      local v182 = v181 - v176 * v179
                      local color3 = Color3.fromHSV(v179 * 0.33, 1, 1)

                      v170.HealthBar.From = Vector2.new(v180, v182)
                      v170.HealthBar.To = Vector2.new(v180, v181)
                      v170.HealthBar.Color = color3
                      v170.HealthBar.Visible = true
                      v170.HealthBarTop.Position = Vector2.new(v180, v182)
                      v170.HealthBarTop.Color = color3
                      v170.HealthBarTop.Visible = true
                      v170.HealthBarBot.Position = Vector2.new(v180, v181)
                      v170.HealthBarBot.Color = color3
                      v170.HealthBarBot.Visible = true
                    else
                      v170.HealthBarOutline.Visible = false
                      v170.HealthBar.Visible = false
                      v170.HealthBarTop.Visible = false
                      v170.HealthBarBot.Visible = false
                    end

                    if config3.ESP_Name or config3.ESP_Health then
                      local displayName3 = value37.DisplayName

                      if config3.ESP_Health then
                        displayName3 = displayName3
                          .. string.format(" (%dHP)", math.floor(health2))
                      end

                      v170.NameTop.Text = displayName3
                      v170.NameTop.Position = Vector2.new(v174.X, worldToViewportPoint.Y - 22)
                      v170.NameTop.Color = enemyColor
                      v170.NameTop.Visible = true
                    else
                      v170.NameTop.Visible = false
                    end

                    if config3.ESP_Distance then
                      local v183 = position6
                          and math.floor((position6 - humanoidRootPart2.Position).Magnitude
                            * 0.28)
                        or 0

                      v170.DistBot.Text = string.format("[%dm]", v183)
                      v170.DistBot.Position = Vector2.new(v174.X, worldToViewportPoint2.Y + 4)
                      v170.DistBot.Color = enemyColor
                      v170.DistBot.Visible = true
                    else
                      v170.DistBot.Visible = false
                    end

                    if config3.ESP_Tracer and v172 then
                      v170.Tracer.From = Vector2.new(
                        currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y
                      )

                      v170.Tracer.To = Vector2.new(v174.X, worldToViewportPoint2.Y)
                      v170.Tracer.Color = enemyColor
                      v170.Tracer.Visible = true
                    else
                      v170.Tracer.Visible = false
                    end
                  else
                    f75(v170)
                  end
                else
                  f75(v170)
                end
              end
            end
          end
        end)

        if not v166 then
          warn("[SXNT ESP] Error:", v167)
        end
      end))

      pcall(function()
        local filtergc = getgenv().filtergc or function() return nil end
        local v184 = filtergc("table", { Keys = { "setWeaponRecoil" } }, true)
        local setWeaponRecoil = v184 and v184.setWeaponRecoil
        local v185

        if setWeaponRecoil then
          v185 = nil

          v185 = hookfunction(v184.setWeaponRecoil, function(...)
            if getgenv().Config.NoRecoil then
              return
            end

            return v185(...)
          end)
        end

        local v186 = filtergc("function", { Name = "calculateRecoilOffset" }, true)
        local v187

        if v186 then
          v187 = nil

          v187 = hookfunction(v186, function(...)
            if getgenv().Config.NoRecoil then
              return UDim2.new()
            end

            return v187(...)
          end)
        end

        local v188 = filtergc("table", { Keys = { "getTrueSpread" } }, true)
        local v189

        if v188 and v188.getTrueSpread then
          v189 = nil

          v189 = hookfunction(v188.getTrueSpread, function(...)
            if getgenv().Config.NoSpread then
              return 0
            end

            return v189(...)
          end)
        end

        local v190 = filtergc("function", { Name = "Flash" }, true)
        local v191

        if v190 then
          v191 = nil

          v191 = hookfunction(v190, function(...)
            if getgenv().Config.AntiFlash then
              return
            end

            return v191(...)
          end)
        end
      end)

      local bodyGyro, bodyVelocity, connect3

      local function f77()
        getgenv().Config.FlyEnabled = false

        if connect3 then
          connect3:Disconnect()
          connect3 = nil
        end

        if bodyGyro then
          bodyGyro:Destroy()
          bodyGyro = nil
        end

        if bodyVelocity then
          bodyVelocity:Destroy()
          bodyVelocity = nil
        end

        pcall(function()
          local v192 = f69(localPlayer)
          local humanoid = v192 and v192:FindFirstChildOfClass("Humanoid")

          if humanoid then
            humanoid.PlatformStand = false
          end
        end)
      end

      local function f78()
        f77()
        local v193 = f69(localPlayer)

        local humanoidRootPart3 = v193
          and (v193:FindFirstChild("HumanoidRootPart") or v193.PrimaryPart)

        local humanoid2 = v193 and v193:FindFirstChildOfClass("Humanoid")

        if not humanoidRootPart3 or not humanoid2 then
          return
        end

        getgenv().Config.FlyEnabled = true
        humanoid2.PlatformStand = true

        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.P = 90000
        bodyGyro.maxTorque = Vector3.new(9000000000, 9000000000, 9000000000)
        bodyGyro.CFrame = humanoidRootPart3.CFrame
        bodyGyro.Parent = humanoidRootPart3

        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000)
        bodyVelocity.Parent = humanoidRootPart3

        connect3 = runService.RenderStepped:Connect(function()
          if not getgenv().Config.FlyEnabled then
            return
          else
            local v194 = f69(localPlayer)

            if not (v194 and (v194:FindFirstChild("HumanoidRootPart") or v194.PrimaryPart)) then
              f77()
              return
            else
              local vector2 = Vector3.new(0, 0, 0)
              local cframe = currentCamera.CFrame

              if userInputService:IsKeyDown(Enum.KeyCode.W) then
                vector2 = vector2 + cframe.LookVector
              end

              if userInputService:IsKeyDown(Enum.KeyCode.S) then
                vector2 = vector2 - cframe.LookVector
              end

              if userInputService:IsKeyDown(Enum.KeyCode.A) then
                vector2 = vector2 - cframe.RightVector
              end

              if userInputService:IsKeyDown(Enum.KeyCode.D) then
                vector2 = vector2 + cframe.RightVector
              end

              if userInputService:IsKeyDown(Enum.KeyCode.Space) then
                vector2 = vector2 + Vector3.new(0, 1, 0)
              end

              if userInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                vector2 = vector2 - Vector3.new(0, 1, 0)
              end

              local v195 = bodyVelocity

              v195.Velocity = vector2.Magnitude > 0 and vector2.Unit * getgenv().Config.FlySpeed
                or Vector3.new(0, 0, 0)

              bodyGyro.CFrame = cframe
              return
            end
          end
        end)

        f1(connect3)
      end

      local connect4

      local function f79()
        getgenv().Config.TeleportLoop = false

        if connect4 then
          connect4:Disconnect()
          connect4 = nil
        end
      end

      local function f80()
        f79()

        if not getgenv().Config.CheckpointPos then
          return
        end

        getgenv().Config.TeleportLoop = true

        connect4 = runService.Heartbeat:Connect(function()
          if not getgenv().Config.TeleportLoop or not getgenv().Config.CheckpointPos then
            return
          else
            local v196 = f69(localPlayer)

            local humanoidRootPart4 = v196
              and (v196:FindFirstChild("HumanoidRootPart") or v196.PrimaryPart)

            if humanoidRootPart4 then
              humanoidRootPart4.CFrame = getgenv().Config.CheckpointPos
              humanoidRootPart4.Velocity = Vector3.new(0, 0, 0)
            end

            return
          end
        end)

        f1(connect4)
      end

      f63(v103, "esp_master", "ESP_Enabled", 258, function(p135)
        f56(p135, "esp_box", "ESP_Box")
        f56(p135, "esp_health", "ESP_Health")
        f56(p135, "esp_name", "ESP_Name")
        f56(p135, "esp_dist", "ESP_Distance")
        f56(p135, "esp_tracer", "ESP_Tracer")
        f56(p135, "esp_team", "ESP_TeamCheck")
      end)

      local v197, v198

      v197, v198 = f63(v104, "silent", "SilentAim", 232, function(p136)
        f56(p136, "wallbang", "Wallbang")

        f57(p136, "headshot", "HeadshotChance", 0, 100, 1)
        f57(p136, "hitchance", "HitChance", 50, 100, 1)

        f56(p136, "silent_team", "SilentTeamCheck")

        f61(p136, "fov_circle", "FOVCircle", 44, function(p137) f57(p137, "fov_radius", "FOVRadius", 15, 250, 1) end, function(visible)
          circle.Visible = visible

          if v198 then
            v198()
          end
        end)
      end, nil, function() return 190 + (getgenv().Config.FOVCircle and 86 or 36) end)

      f50(v104, "norecoil", "NoRecoil")
      f50(v104, "nospread", "NoSpread")
      f50(v104, "antiflash", "AntiFlash")

      f50(v105, "fly", "FlyEnabled", function(p138)
        if p138 then
          f78()
        else
          f77()
        end
      end)

      f51(v105, "flyspeed", "FlySpeed", 50, 300, 5)

      local instance103 = Instance.new("TextButton", v105)
      instance103.Text = v79[getgenv().Config.Language].record_cp
      instance103.Font = Enum.Font.Cartoon
      instance103.TextSize = 13
      instance103.TextColor3 = v80.text
      instance103.Size = UDim2.new(1, 0, 0, 40)
      instance103.BackgroundColor3 = v80.card
      instance103.AutoButtonColor = false

      f39(instance103, 8)
      f40(instance103, v80.border)
      instance103.LayoutOrder = f45()
      table.insert(v110, { obj = instance103, key = "record_cp", type = "text" })

      instance103.MouseButton1Click:Connect(function()
        local v199 = f69(localPlayer)

        local humanoidRootPart5 = v199
          and (v199:FindFirstChild("HumanoidRootPart") or v199.PrimaryPart)

        if humanoidRootPart5 then
          getgenv().Config.CheckpointPos = humanoidRootPart5.CFrame
        end

        f29()
      end)

      f50(v105, "tp_loop", "TeleportLoop", function(p139)
        if p139 then
          f80()
        else
          f79()
        end
      end)

      local function f81(p140, p141)
        local instance104 = Instance.new("TextLabel", p140)
        instance104.Text = v79[getgenv().Config.Language][p141] or p141
        instance104.Font = Enum.Font.Cartoon
        instance104.TextSize = 14
        instance104.TextColor3 = v80.accent
        instance104.Size = UDim2.new(1, 0, 0, 20)
        instance104.BackgroundTransparency = 1
        instance104.TextXAlignment = Enum.TextXAlignment.Left
        instance104.LayoutOrder = f45()

        table.insert(v110, { obj = instance104, key = p141, type = "text" })
        return instance104
      end

      local v200

      local function f82(p142, text5, p143, fn, fn2, p144, p145)
        local v201 = p143

        if not v201 or #v201 == 0 then
          v201 = { "—" }
        end

        local v202 = fn() or v201[1]

        if not fn() then
          fn2(v202)
        end

        local instance105 = Instance.new("Frame", p142)
        instance105.Size = UDim2.new(1, 0, 0, 32)
        instance105.BackgroundColor3 = v80.card
        instance105.BorderSizePixel = 0
        instance105.ClipsDescendants = true

        f39(instance105, 8)
        f40(instance105, v80.border)
        instance105.LayoutOrder = p144 or f45()

        local instance106 = Instance.new("TextLabel", instance105)
        instance106.Text = text5
        instance106.Font = Enum.Font.Cartoon
        instance106.TextSize = 13
        instance106.TextColor3 = v80.text
        instance106.Size = UDim2.new(0.4, -12, 0, 32)
        instance106.Position = UDim2.new(0, 10, 0, 0)
        instance106.BackgroundTransparency = 1
        instance106.TextXAlignment = Enum.TextXAlignment.Left

        local instance107 = Instance.new("TextButton", instance105)
        instance107.Text = "▼ " .. tostring(v202)
        instance107.Font = Enum.Font.Cartoon
        instance107.TextSize = 12
        instance107.TextColor3 = Color3.new(1, 1, 1)
        instance107.Size = UDim2.new(0.6, -16, 0, 28)
        instance107.Position = UDim2.new(0.4, 6, 0, 2)
        instance107.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
        instance107.BorderSizePixel = 0

        f39(instance107, 6)
        instance107.AutoButtonColor = false
        local v203 = false

        local v204 = {}

        function v204.setOptions(p146, p147)
          v201 = p146

          if p147 then
            v202 = p147
          end

          instance107.Text = "▼ " .. tostring(v202)
        end

        local instance108

        local function f83()
          if v200 == f83 then
            v200 = nil
          end

          if instance108 then
            instance108:Destroy()
            instance108 = nil
          end

          v203 = false
          f38(instance105, 0.2, { Size = UDim2.new(1, 0, 0, 32) })

          task.delay(0.2, function()
            if instance105 and not v203 then
              instance105.ClipsDescendants = true
            end
          end)
        end

        local function f84()
          if v200 then
            v200()
            v200 = nil
          end

          v200 = f83

          if v203 then
            return
          else
            v203 = true
            instance105.ClipsDescendants = false
            local v205 = math.min(#v201, 6) * 28 + 2 + 4

            instance108 = Instance.new("Frame", instance105)
            instance108.Size = UDim2.new(1, -8, 0, v205)
            instance108.Position = UDim2.new(0, 4, 0, 34)
            instance108.BackgroundTransparency = 1
            instance108.ZIndex = 10

            local instance109 = Instance.new("ScrollingFrame", instance108)
            instance109.Size = UDim2.new(1, 0, 1, 0)
            instance109.BackgroundTransparency = 1
            instance109.ScrollBarThickness = 3
            instance109.ScrollBarImageColor3 = v80.accent
            instance109.CanvasSize = UDim2.new(0, 0, 0, #v201 * 28)
            instance109.ZIndex = 10

            Instance.new("UIListLayout", instance109).Padding = UDim.new(0, 2)

            for index29, value38 in ipairs(v201) do
              local v206 = value38

              local instance110 = Instance.new("TextButton", instance109)
              instance110.Text = tostring(v206)
              instance110.Font = Enum.Font.Cartoon
              instance110.TextSize = 12
              instance110.TextColor3 = Color3.new(1, 1, 1)
              instance110.Size = UDim2.new(1, -4, 0, 26)
              instance110.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
              instance110.BorderSizePixel = 0

              f39(instance110, 4)

              instance110.ZIndex = 10
              instance110.AutoButtonColor = false

              instance110.MouseEnter:Connect(function()
                f38(instance110, 0.1, { BackgroundColor3 = v80.accent })
              end)

              instance110.MouseLeave:Connect(function()
                f38(instance110, 0.1, { BackgroundColor3 = Color3.fromRGB(35, 35, 40) })
              end)

              instance110.MouseButton1Click:Connect(function()
                fn2(v206)
                v202 = v206
                instance107.Text = "▼ " .. tostring(v206)

                if p145 then
                  p145(v206)
                end

                f29()
                f83()
              end)
            end

            f38(instance105, 0.25, { Size = UDim2.new(1, 0, 0, 32 + v205 + 8) })
            return
          end
        end

        instance107.MouseButton1Click:Connect(function()
          if v203 then
            f83()
          else
            f84()
          end
        end)

        return instance105, v204
      end

      local function f85(p148, p149, p150)
        local v207 = v141[p150][p149]

        if not v207 or #v207 == 0 then
          return
        else
          local v208 = getgenv().Config.ConfiguredSkins[p149] or v207[1]

          local v209 = getgenv()
          v209.Config.ConfiguredSkins[p149] = v208

          f82(p148, p149, v207, function() return getgenv().Config.ConfiguredSkins[p149] end, function(selectedGloveSkin)
            getgenv().Config.ConfiguredSkins[p149] = selectedGloveSkin

            if p150 == "Gloves" then
              getgenv().Config.SelectedGloveSkin = selectedGloveSkin
              getgenv().Config.SelectedGlove = p149
            end
          end, f45())

          return
        end
      end

      f50(v106, "skin_main", "SkinChanger_Enabled")

      f82(
        v106, v79[getgenv().Config.Language].wear,
        { "Factory New", "Minimal Wear", "Field-Tested", "Well-Worn", "Battle-Scarred" },
        function() return getgenv().Config.SelectedWear end,
        function(selectedWear) getgenv().Config.SelectedWear = selectedWear end, f45()
      )

      f81(v106, "knife_section")

      local instance111 = Instance.new("Frame", v106)
      instance111.Size = UDim2.new(1, 0, 0, 52)
      instance111.BackgroundColor3 = v80.card
      instance111.BorderSizePixel = 0

      f39(instance111, 8)
      f40(instance111, v80.border)
      instance111.LayoutOrder = f45()

      local instance112 = Instance.new("TextLabel", instance111)
      instance112.Text = v79[getgenv().Config.Language].knife_unavailable
      instance112.Font = Enum.Font.Cartoon
      instance112.TextSize = 13
      instance112.TextColor3 = v80.muted
      instance112.Size = UDim2.new(1, -16, 0, 22)
      instance112.Position = UDim2.new(0, 8, 0, 8)
      instance112.BackgroundTransparency = 1
      instance112.TextXAlignment = Enum.TextXAlignment.Left

      table.insert(v110, { obj = instance112, key = "knife_unavailable", type = "text" })

      local instance113 = Instance.new("TextLabel", instance111)
      instance113.Text = v79[getgenv().Config.Language].knife_unavailable_desc
      instance113.Font = Enum.Font.Cartoon
      instance113.TextSize = 11
      instance113.TextColor3 = v80.muted
      instance113.Size = UDim2.new(1, -16, 0, 16)
      instance113.Position = UDim2.new(0, 8, 0, 30)
      instance113.BackgroundTransparency = 1
      instance113.TextXAlignment = Enum.TextXAlignment.Left

      table.insert(v110, { obj = instance113, key = "knife_unavailable_desc", type = "text" })
      f81(v106, "gloves_section")

      for key10, value39 in pairs(v141.Gloves) do
        f85(v106, key10, "Gloves")
      end

      f81(v106, "weapons_section")

      for key11, value40 in pairs(v141.Weapons) do
        f85(v106, key11, "Weapons")
      end

      local instance114 = Instance.new("TextLabel", v107)
      instance114.Text = "https://t.me/sxnt_mods"
      instance114.Font = Enum.Font.Cartoon
      instance114.TextSize = 15
      instance114.TextColor3 = Color3.new(1, 1, 1)
      instance114.Size = UDim2.new(1, 0, 0, 28)
      instance114.BackgroundTransparency = 1
      instance114.TextXAlignment = Enum.TextXAlignment.Center

      local instance115 = Instance.new("TextButton", v107)
      instance115.Text = v79[getgenv().Config.Language].copy
      instance115.Font = Enum.Font.Cartoon
      instance115.TextSize = 13
      instance115.TextColor3 = Color3.new(1, 1, 1)
      instance115.Size = UDim2.new(1, -12, 0, 36)
      instance115.AnchorPoint = Vector2.new(0.5, 0)
      instance115.Position = UDim2.new(0.5, 0, 0, 36)
      instance115.BackgroundColor3 = v80.telegram

      f39(instance115, 8)
      table.insert(v110, { obj = instance115, key = "copy", type = "text" })

      instance115.MouseButton1Click:Connect(function()
        pcall(function() setclipboard("https://t.me/sxnt_mods") end)
        instance115.Text = v79[getgenv().Config.Language].copied
        task.wait(1.5)
        instance115.Text = v79[getgenv().Config.Language].copy
      end)

      local instance116 = Instance.new("Frame", v108)
      instance116.Size = UDim2.new(1, 0, 0, 80)
      instance116.BackgroundColor3 = v80.card
      instance116.BorderSizePixel = 0

      f39(instance116, 10)
      f40(instance116, v80.border)

      local instance117 = Instance.new("TextLabel", instance116)
      instance117.Text = v79[getgenv().Config.Language].key_status
      instance117.Font = Enum.Font.Cartoon
      instance117.TextSize = 14
      instance117.TextColor3 = v80.text
      instance117.Size = UDim2.new(1, -20, 0, 22)
      instance117.Position = UDim2.new(0, 10, 0, 8)
      instance117.BackgroundTransparency = 1
      instance117.TextXAlignment = Enum.TextXAlignment.Left

      table.insert(v110, { obj = instance117, key = "key_status", type = "text" })

      local instance118 = Instance.new("TextLabel", instance116)
      instance118.Font = Enum.Font.Cartoon
      instance118.TextSize = 12
      instance118.TextColor3 = v80.muted
      instance118.Size = UDim2.new(1, -20, 0, 20)
      instance118.Position = UDim2.new(0, 10, 0, 32)
      instance118.BackgroundTransparency = 1
      instance118.TextXAlignment = Enum.TextXAlignment.Left

      local instance119 = Instance.new("TextLabel", instance116)
      instance119.Font = Enum.Font.Cartoon
      instance119.TextSize = 11
      instance119.TextColor3 = v80.muted
      instance119.Size = UDim2.new(1, -20, 0, 16)
      instance119.Position = UDim2.new(0, 10, 0, 52)
      instance119.BackgroundTransparency = 1
      instance119.TextXAlignment = Enum.TextXAlignment.Left

      local function f86()
        local v210 = f11()
        local v211 = f10()
        local v212 = not v211
        local language = getgenv().Config.Language or "ENG"

        if v212 or v211 == "" then
          instance118.Text = v79[language].no_key_saved or "No key saved"
          instance118.TextColor3 = v80.red
          instance119.Text = ""
        else
          instance118.Text = "Key: " .. v211:sub(1, 8) .. "..." .. v211:sub(-4)
          instance118.TextColor3 = v80.green

          if v210.expiresAt then
            local v213 = f16(v210.expiresAt)

            if v213 == "expired" then
              instance119.Text = v79[language].hint_expired or "Expired"
              instance119.TextColor3 = v80.red
            else
              instance119.Text = (v79[language].key_expires or "Expires in") .. ": " .. v213
              instance119.TextColor3 = v80.accent
            end
          else
            instance119.Text = ""
          end
        end
      end

      f86()

      task.spawn(function()
        while v108.Parent do
          task.wait(30)

          if v108.Visible then
            f86()
          end
        end
      end)

      local instance120 = Instance.new("TextButton", v109)
      instance120.Size = UDim2.new(1, -10, 0, 36)
      instance120.Position = UDim2.new(0, 5, 0, 10)
      instance120.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
      instance120.Font = Enum.Font.Cartoon
      instance120.TextColor3 = Color3.new(1, 1, 1)
      instance120.TextSize = 13
      instance120.AutoButtonColor = false

      f39(instance120, 8)

      local function f87()
        if not instance120 or not instance120.Parent then
          return
        else
          local language2 = getgenv().Config.Language

          instance120.Text = (v79[language2] and v79[language2].lang or "Language") .. "  ·  "
            .. language2

          return
        end
      end

      f87()

      table.insert(v110, { obj = instance120, type = "custom", update = f87 })
      local v214 = { "ENG", "UA", "TR", "RUS" }

      instance120.MouseButton1Click:Connect(function()
        local v215 = (table.find(v214, getgenv().Config.Language) or 1) % #v214 + 1
        getgenv().Config.Language = v214[v215]
        f27(v214[v215])
        f29()

        for index30, value41 in ipairs(v110) do
          if value41.type == "text" and v79[getgenv().Config.Language][value41.key] then
            value41.obj.Text = v79[getgenv().Config.Language][value41.key]
          elseif value41.type == "custom" and value41.update then
            value41.update()
          end
        end

        for index31, value42 in ipairs(v98) do
          local btn = value42.btn

          btn.Text = value42.icon .. "  "
            .. (v79[getgenv().Config.Language][value42.textKey] or value42.textKey)
        end

        instance58.Text = v79[getgenv().Config.Language].title or "SXNT V1.3"
      end)

      local f88, instance121, f89, instance122

      if not touchEnabled then
        function f88()
          return tostring(getgenv().Config.MenuKey):match("KeyCode%.(.+)") or "F4"
        end

        instance121 = Instance.new("TextLabel", v109)
        instance121.Font = Enum.Font.Cartoon
        instance121.TextColor3 = v80.text
        instance121.TextSize = 13
        instance121.TextXAlignment = Enum.TextXAlignment.Center
        instance121.Size = UDim2.new(1, 0, 0, 28)
        instance121.Position = UDim2.new(0, 0, 0, 60)
        instance121.BackgroundTransparency = 1

        function f89()
          instance121.Text = (v79[getgenv().Config.Language].keybind or "Menu Key") .. ": "
            .. f88()
        end

        f89()

        table.insert(v110, { obj = instance121, type = "custom", update = f89 })

        instance122 = Instance.new("TextButton", v109)
        instance122.Font = Enum.Font.Cartoon
        instance122.TextSize = 13
        instance122.TextColor3 = v80.text
        instance122.Size = UDim2.new(1, -12, 0, 28)
        instance122.AnchorPoint = Vector2.new(0.5, 0)
        instance122.Position = UDim2.new(0.5, 0, 0, 94)
        instance122.BackgroundColor3 = v80.card
        instance122.AutoButtonColor = false

        f39(instance122, 8)
        instance122.Text = v79[getgenv().Config.Language].bindkey or "Bind Key"
        table.insert(v110, { obj = instance122, key = "bindkey", type = "text" })

        instance122.MouseButton1Click:Connect(function()
          instance122.Text = "..."
          local connect5

          connect5 = userInputService.InputBegan:Connect(function(input14, p151)
            if not p151 and input14.UserInputType == Enum.UserInputType.Keyboard then
              connect5:Disconnect()
              getgenv().Config.MenuKey = input14.KeyCode
              f89()
              instance122.Text = v79[getgenv().Config.Language].bindkey or "Bind Key"
              f29()
            end
          end)
        end)
      end

      local instance123 = Instance.new("TextButton", v109)
      instance123.Font = Enum.Font.Cartoon
      instance123.TextSize = 13
      instance123.TextColor3 = v80.text
      instance123.Size = UDim2.new(1, -12, 0, 28)
      instance123.Position = UDim2.new(0, 6, 0, touchEnabled and 60 or 134)
      instance123.BackgroundColor3 = getgenv().Config.HideIcon and v80.accent or v80.card
      instance123.AutoButtonColor = false

      f39(instance123, 8)
      instance123.Text = v79[getgenv().Config.Language].hideicon or "Hide Icon"
      table.insert(v110, { obj = instance123, type = "text", key = "hideicon" })

      instance123.MouseButton1Click:Connect(function()
        if touchEnabled and not getgenv().Config.HideIcon then
          instance123.Text = v79[getgenv().Config.Language].cant_hide_mobile
            or "Cannot hide on mobile"

          task.delay(2, function()
            if instance123.Parent then
              instance123.Text = v79[getgenv().Config.Language].hideicon or "Hide Icon"
            end
          end)

          return
        end

        getgenv().Config.HideIcon = not getgenv().Config.HideIcon
        instance123.BackgroundColor3 = getgenv().Config.HideIcon and v80.accent or v80.card
        textButton.Visible = not getgenv().Config.HideIcon
        f29()
      end)

      local v216 = {}

      local function f90()
        local v217 = getgenv().Config.SoundEnabled ~= false and 0 or -34

        for index32, value43 in ipairs(v216) do
          if value43.obj and value43.obj.Parent then
            value43.obj.Position = UDim2.new(0, 6, 0, value43.baseY + v217)
          end
        end
      end

      local instance124 = Instance.new("Frame", v109)
      instance124.Size = UDim2.new(1, -12, 0, 28)
      instance124.Position = UDim2.new(0, 6, 0, touchEnabled and 94 or 168)
      instance124.BackgroundColor3 = v80.card
      instance124.BorderSizePixel = 0

      f39(instance124, 8)
      instance124.ClipsDescendants = true

      local instance125 = Instance.new("TextLabel", instance124)
      instance125.Text = v79[getgenv().Config.Language].sound or "Click Sounds"
      instance125.Font = Enum.Font.Cartoon
      instance125.TextSize = 13
      instance125.TextColor3 = v80.text
      instance125.Size = UDim2.new(1, -56, 0, 28)
      instance125.Position = UDim2.new(0, 10, 0, 0)
      instance125.BackgroundTransparency = 1
      instance125.TextXAlignment = Enum.TextXAlignment.Left
      instance125.ZIndex = 2

      table.insert(v110, { obj = instance125, key = "sound", type = "text" })

      local instance126 = Instance.new("TextButton", instance124)
      instance126.Text = ""
      instance126.Size = UDim2.new(0, 36, 0, 20)
      instance126.Position = UDim2.new(1, -46, 0, 4)

      instance126.BackgroundColor3 = getgenv().Config.SoundEnabled ~= false and v80.accent
        or Color3.fromRGB(50, 50, 55)

      instance126.BorderSizePixel = 0

      f39(instance126, 10)

      instance126.AutoButtonColor = false
      instance126.ZIndex = 3

      local instance127 = Instance.new("Frame", instance126)
      instance127.Size = UDim2.new(0, 14, 0, 14)

      instance127.Position = getgenv().Config.SoundEnabled ~= false
          and UDim2.new(1, -16, 0.5, -7)
        or UDim2.new(0, 2, 0.5, -7)

      instance127.BackgroundColor3 = Color3.new(1, 1, 1)
      instance127.BorderSizePixel = 0

      f39(instance127, 7)

      local instance128 = Instance.new("Frame", instance124)
      instance128.Size = UDim2.new(1, -20, 0, 34)
      instance128.Position = UDim2.new(0, 10, 0, 28)
      instance128.BackgroundTransparency = 1
      instance128.ClipsDescendants = true

      local instance129 = Instance.new("TextLabel", instance128)
      instance129.Font = Enum.Font.Cartoon
      instance129.TextSize = 11
      instance129.TextColor3 = v80.text
      instance129.Size = UDim2.new(0.6, 0, 0, 14)
      instance129.Position = UDim2.new(0, 0, 0, 0)
      instance129.BackgroundTransparency = 1
      instance129.TextXAlignment = Enum.TextXAlignment.Left

      local instance130 = Instance.new("TextLabel", instance128)
      instance130.Font = Enum.Font.Cartoon
      instance130.TextSize = 11
      instance130.TextColor3 = v80.accent
      instance130.Size = UDim2.new(0.4, -4, 0, 14)
      instance130.Position = UDim2.new(0.6, 4, 0, 0)
      instance130.BackgroundTransparency = 1
      instance130.TextXAlignment = Enum.TextXAlignment.Right

      local instance131 = Instance.new("TextButton", instance128)
      instance131.Text = ""
      instance131.Size = UDim2.new(1, -8, 0, 8)
      instance131.Position = UDim2.new(0, 4, 0, 22)
      instance131.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
      instance131.BorderSizePixel = 0

      f39(instance131, 4)
      instance131.AutoButtonColor = false
      local instance132 = Instance.new("Frame", instance131)
      local v218 = math.clamp(((getgenv().Config.SoundVolume or 1.2) - 0.1) / 2.9, 0, 1)

      instance132.Size = UDim2.new(v218, 0, 1, 0)
      instance132.BackgroundColor3 = v80.accent
      instance132.BorderSizePixel = 0

      f39(instance132, 4)

      local instance133 = Instance.new("TextButton", instance131)
      instance133.Text = ""
      instance133.Size = UDim2.new(0, 14, 0, 14)
      instance133.Position = UDim2.new(v218, -7, 0.5, -7)
      instance133.BackgroundColor3 = Color3.new(1, 1, 1)
      instance133.BorderSizePixel = 0

      f39(instance133, 7)
      f40(instance133, v80.accent, 1.5)
      instance133.AutoButtonColor = false

      local function f91()
        instance129.Text = (v79[getgenv().Config.Language].volume or "Volume") .. ": "
        instance130.Text = string.format("%.1f", getgenv().Config.SoundVolume or 1.2)
      end

      f91()

      table.insert(v110, {
        obj = instance129,
        key = "volume",
        type = "text",
        refresh = f91,
      })

      local function f92(p152, p153)
        if p153 <= 0 then
          return
        else
          local v219 = math.floor((0.1 + math.clamp(p152 / p153, 0, 1) * 2.9) * 10 + 0.5) / 10
          getgenv().Config.SoundVolume = v219
          local v220 = (v219 - 0.1) / 2.9
          instance132.Size = UDim2.new(v220, 0, 1, 0)
          instance133.Position = UDim2.new(v220, -7, 0.5, -7)
          f91()
          return
        end
      end

      instance131.InputBegan:Connect(function(input15)
        if input15.UserInputType == Enum.UserInputType.MouseButton1
          or input15.UserInputType == Enum.UserInputType.Touch then
          local v221 = f55(instance124)

          if v221 then
            v221.ScrollingEnabled = false
          end

          v111 = { track = instance131, setValue = f92, scrollFrame = v221 }
          f92(input15.Position.X - instance131.AbsolutePosition.X, instance131.AbsoluteSize.X)
        end
      end)

      instance133.InputBegan:Connect(function(input16)
        if input16.UserInputType == Enum.UserInputType.MouseButton1
          or input16.UserInputType == Enum.UserInputType.Touch then
          local v222 = f55(instance124)

          if v222 then
            v222.ScrollingEnabled = false
          end

          v111 = { track = instance131, setValue = f92, scrollFrame = v222 }
          f92(input16.Position.X - instance131.AbsolutePosition.X, instance131.AbsoluteSize.X)
        end
      end)

      local v223 = getgenv().Config.SoundEnabled ~= false
      instance124.Size = UDim2.new(1, -12, 0, v223 and 62 or 28)

      instance126.MouseButton1Click:Connect(function()
        getgenv().Config.SoundEnabled = not (getgenv().Config.SoundEnabled ~= false)
        local soundEnabled = getgenv().Config.SoundEnabled

        f38(instance126, 0.2, {
          BackgroundColor3 = soundEnabled and v80.accent or Color3.fromRGB(50, 50, 55),
        })

        f38(instance127, 0.2, {
          Position = soundEnabled and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7),
        })

        local v224 = soundEnabled and 62 or 28
        f38(instance124, 0.3, { Size = UDim2.new(1, -12, 0, v224) }, Enum.EasingStyle.Quart):Play()
        f90()
        f29()
      end)

      local instance134 = Instance.new("TextButton", v109)
      instance134.Font = Enum.Font.Cartoon
      instance134.TextSize = 12
      instance134.TextColor3 = Color3.new(1, 1, 1)
      instance134.Size = UDim2.new(1, -12, 0, 28)
      instance134.Position = UDim2.new(0, 6, 0, touchEnabled and 162 or 236)

      table.insert(v216, { obj = instance134, baseY = touchEnabled and 162 or 236 })

      instance134.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
      instance134.BorderSizePixel = 0
      instance134.AutoButtonColor = false

      f39(instance134, 8)
      instance134.Text = v79[getgenv().Config.Language].reset_esp or "Reset ESP"
      table.insert(v110, { obj = instance134, type = "text", key = "reset_esp" })

      instance134.MouseEnter:Connect(function()
        f38(instance134, 0.12, { BackgroundColor3 = Color3.fromRGB(120, 40, 40) })
      end)

      instance134.MouseLeave:Connect(function()
        f38(instance134, 0.12, { BackgroundColor3 = Color3.fromRGB(80, 30, 30) })
      end)

      instance134.MouseButton1Click:Connect(function()
        if getgenv().SXNT_ForceHideESP then
          getgenv().SXNT_ForceHideESP()
        end

        instance134.Text = "✓ " .. (v79[getgenv().Config.Language].reset_esp or "Reset ESP")

        task.delay(1.2, function()
          if instance134.Parent then
            instance134.Text = v79[getgenv().Config.Language].reset_esp or "Reset ESP"
          end
        end)
      end)

      local instance135 = Instance.new("TextLabel", v109)
      instance135.Text = "— " .. (v79[getgenv().Config.Language].theme or "Theme") .. " —"
      instance135.Font = Enum.Font.Cartoon
      instance135.TextSize = 13
      instance135.TextColor3 = v80.accent
      instance135.Size = UDim2.new(1, -12, 0, 22)
      instance135.Position = UDim2.new(0, 6, 0, touchEnabled and 196 or 270)

      table.insert(v216, { obj = instance135, baseY = touchEnabled and 196 or 270 })

      instance135.BackgroundTransparency = 1
      instance135.TextXAlignment = Enum.TextXAlignment.Left

      table.insert(v110, { obj = instance135, type = "text", key = "theme" })

      local instance136 = Instance.new("Frame", v109)
      instance136.Size = UDim2.new(1, -12, 0, 68)
      instance136.Position = UDim2.new(0, 6, 0, touchEnabled and 220 or 294)

      table.insert(v216, { obj = instance136, baseY = touchEnabled and 220 or 294 })
      instance136.BackgroundTransparency = 1

      local instance137 = Instance.new("UIGridLayout", instance136)
      instance137.CellSize = UDim2.new(0, 68, 0, 28)
      instance137.CellPadding = UDim2.new(0, 4, 0, 4)
      instance137.SortOrder = Enum.SortOrder.LayoutOrder

      for index33, value44 in ipairs(v4) do
        local v225 = value44
        local v226 = v3[v225]

        local instance138 = Instance.new("TextButton", instance136)
        instance138.Text = ""
        instance138.Font = Enum.Font.Cartoon
        instance138.TextSize = 10
        instance138.BackgroundColor3 = v226.accent
        instance138.BorderSizePixel = 0

        f39(instance138, 6)

        instance138.AutoButtonColor = false
        instance138.LayoutOrder = index33

        f21(instance138, v226.accent, v226.accent2, 0)

        local instance139 = Instance.new("Frame", instance138)
        instance139.Size = UDim2.new(1, 0, 1, 0)
        instance139.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        instance139.BackgroundTransparency = 0.55
        instance139.BorderSizePixel = 0

        f39(instance139, 6)
        instance139.ZIndex = 1

        local instance140 = Instance.new("TextLabel", instance138)
        instance140.Text = v225
        instance140.Font = Enum.Font.Cartoon
        instance140.TextSize = 10
        instance140.TextColor3 = Color3.new(1, 1, 1)
        instance140.BackgroundTransparency = 1
        instance140.Size = UDim2.new(1, 0, 1, 0)
        instance140.ZIndex = 2
        instance140.TextStrokeTransparency = 0.35
        instance140.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

        if (getgenv().Config.Theme or "Ice") == v225 then
          local instance141 = Instance.new("UIStroke", instance138)
          instance141.Color = Color3.new(1, 1, 1)
          instance141.Thickness = 2
        end

        instance138.MouseEnter:Connect(function()
          f38(instance138, 0.15, { Size = UDim2.new(0, 72, 0, 30) })
        end)

        instance138.MouseLeave:Connect(function()
          f38(instance138, 0.15, { Size = UDim2.new(0, 68, 0, 28) })
        end)

        instance138.MouseButton1Click:Connect(function()
          if (getgenv().Config.Theme or "Ice") == v225 then
            return
          end

          getgenv().Config.Theme = v225
          f29()
          f17(v225)

          task.spawn(function()
            task.wait(0.05)

            if getgenv().SXNT_ReloadMenu then
              getgenv().SXNT_ReloadMenu()
            end
          end)
        end)
      end

      v97[1].Visible = true
      v96[1].Visible = true
      f47(1, 1)

      getgenv().SXNT_ReloadMenu = function()
        if v76:FindFirstChild("Interface") then
          v76.Interface:Destroy()
        end

        f2()
        task.wait(0.15)
        local v227 = StartMainMenu()

        if v227 then
          v227()
        end
      end

      return f42
    end

    getgenv().SXNT_KeyRecheckLoop = task.spawn(function()
      task.wait(30)

      while true do
        local v228 = f10()

        if v228 and v228 ~= "" then
          v1501, u9316 = f15(v228)
        end

        task.wait(300)
      end
    end)

    local v229 = nil

    local function f93()
      local v230 = f13()

      if not v230 or v230 == "" then
        return nil
      end

      local v231
      v1505, v231 = f12("https://sxnt-mods.up.railway.app" .. "/hwid-lookup?hwid=" .. v230)

      if not v231 then
        return nil
      else
        local v232, v233 = pcall(function() return httpService:JSONDecode(v231) end)

        if not v232 or type(v233) ~= "table" then
          return nil
        end

        if v233.found and v233.key then
          return v233.key, v233.expires_at_ms
        end

        return nil
      end
    end

    local v234 = f10()
    local v235 = false

    if v234 and v234 ~= "" then
      v235, v229, v27 = f15(v234)

      if not v235 then
        v61 = v229
        v234 = nil
      end
    end

    if not v235 then
      local v236, v237 = f93()

      if v236 then
        f9(v236, v237)
        v234 = v236
        v235 = true

        v229 = {
          first_name = "User",
          username = "sxnt_user",
          avatar_url = "",
          expiresAt = v237,
        }

        v61 = nil
      end
    end

    if v235 and v234 then
      getgenv().TelegramProfile = v229
      getgenv().PreferredLanguage = f35()

      local v238 = getgenv()
      v238.Config = getgenv().Config or {}

      f28()
      f17(getgenv().Config.Theme or "Ice")
      f33(v229, StartMainMenu(), f35(), true)
    else
      local v239 = v61 and f14(v61, v9[v10] or v9.ENG) or nil
      v11(v10, "", v239, v239 and "error" or nil)
    end

    return
  end
end
--[[STANDARD-LANE-END:50cacc2e]]
