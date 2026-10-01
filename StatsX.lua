-- shit deobfuscation (prob not even runnable too)

local players = game:GetService("Players")
local lighting = game:GetService("Lighting")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")
local workspaceService = game:GetService("Workspace")
local starterGui = game:GetService("StarterGui")
local virtualUser = game:GetService("VirtualUser")
local httpService = game:GetService("HttpService")
local rbxAnalyticsService = game:GetService("RbxAnalyticsService")
local coreGui = game:GetService("CoreGui")
local textService = game:GetService("TextService")

warn("[StatsX] loaded")

local v42 = {}
v42.mobile = false

if not pcall(function()
  v42.mobile = userInputService.TouchEnabled and not userInputService.KeyboardEnabled
end) then
  v42.mobile = false
end

function v42.viewport()
  local vector = Vector2.new(1280, 720)

  pcall(function()
    local currentCamera = workspaceService.CurrentCamera

    if currentCamera and currentCamera.ViewportSize.X > 1 then
      vector = currentCamera.ViewportSize
    end
  end)

  return vector
end

local v43 = game:FindService("Stats")
local v44
pcall(function() v44 = virtualUser end)
local localPlayer = players.LocalPlayer
local v45, v46 = false, false

do
  local v47 = {
    Bg = Color3.fromRGB(16, 16, 22),
    Bg2 = Color3.fromRGB(22, 22, 30),
    Field = Color3.fromRGB(29, 29, 39),
    Stroke = Color3.fromRGB(45, 45, 59),
    Edge = Color3.fromRGB(52, 60, 92),
    Text = Color3.fromRGB(242, 242, 250),
    Sub = Color3.fromRGB(140, 140, 158),
    Accent = Color3.fromRGB(90, 140, 255),
    Accent2 = Color3.fromRGB(124, 110, 255),
    Accent3 = Color3.fromRGB(120, 60, 230),
    Ok = Color3.fromRGB(110, 220, 130),
    Bad = Color3.fromRGB(235, 90, 100),
  }

  local function f2(p3)
    return httpService:UrlEncode(tostring(p3))
  end

  local function f3(p4)
    local v48, v49 = pcall(function() return game:HttpGet(p4, true) end)

    if v48 and type(v49) == "string" and #v49 > 0 then
      return v49
    end

    local v50 = typeof(request) == "function" and request
      or typeof(http_request) == "function" and http_request
      or typeof(syn) == "table" and syn.request or typeof(fluxus) == "table" and fluxus.request

    if v50 then
      local v51, v52 = pcall(v50, { Url = p4, Method = "GET" })

      if v51 and type(v52) == "table" and type(v52.Body) == "string" then
        return v52.Body
      end
    end

    return nil
  end

  local function f4()
    local v53, v54 = pcall(function() return rbxAnalyticsService:GetClientId() end)

    if v53 and type(v54) == "string" and #v54 > 0 then
      return v54
    end

    if typeof(gethwid) == "function" then
      local v55, v56 = pcall(gethwid)

      if v55 and type(v56) == "string" and #v56 > 0 then
        return v56
      end
    end

    return "uid-" .. tostring(localPlayer.UserId)
  end

  local v57 = f4()

  local function f5(p5, p6)
    if ("https://statsx-api.discordflex911.workers.dev"):find("YOURNAME", 1, true) then
      return {
        ok = false,
        error = "not_configured",
        message = "API_URL is not set in the script yet.",
      }
    end

    local v58 = f3("https://statsx-api.discordflex911.workers.dev" .. "/v1/check?u=" .. f2(p5)
      .. "&k=" .. f2(p6) .. "&h=" .. f2(v57) .. "&v=" .. f2("1.17") .. "&p="
      .. f2(localPlayer.Name) .. "&i=" .. f2(localPlayer.UserId))

    if not v58 then
      return {
        ok = false,
        error = "network",
        message = "Could not reach the StatsX server. Check your connection and try again.",
      }
    end

    local v59, v60 = pcall(function() return httpService:JSONDecode(v58) end)

    if not v59 or type(v60) ~= "table" then
      return {
        ok = false,
        error = "bad_response",
        message = "The server sent an unreadable reply. Try again.",
      }
    end

    return v60
  end

  local v61 = typeof(writefile) == "function" and typeof(readfile) == "function"
    and typeof(isfile) == "function"

  local function f6()
    if not v61 then
      return nil
    end

    local v62, v63 = pcall(function()
      if isfile("StatsX_session.dat") then
        return readfile("StatsX_session.dat")
      end
    end)

    if not v62 or type(v63) ~= "string" then
      return nil
    end

    local v64, v65 = v63:match("^([^|]+)|([^|\r\n]+)")

    if v64 and v65 then
      return { user = v64, key = v65 }
    end

    return nil
  end

  local function f7(p7, p8)
    if v61 then
      pcall(function() writefile("StatsX_session.dat", p7 .. "|" .. p8) end)
    end
  end

  local function f8()
    if v61 and typeof(delfile) == "function" then
      pcall(function() delfile("StatsX_session.dat") end)
    elseif v61 then
      pcall(function() writefile("StatsX_session.dat", "") end)
    end
  end

  local function f9(p9)
    if p9 == nil then
      return "forever"
    end

    local v66 = math.max(0, math.floor((tonumber(p9) or 0) / 1000))
    local v67 = math.floor(v66 / 3600)
    local v68 = math.floor(v66 % 3600 / 60)

    if v67 > 0 then
      return string.format("%dh %02dm", v67, v68)
    end

    return string.format("%dm", v68)
  end

  local statsXLogin = Instance.new("ScreenGui")
  statsXLogin.Name = "StatsXLogin"
  statsXLogin.ResetOnSpawn = false
  statsXLogin.IgnoreGuiInset = true
  statsXLogin.DisplayOrder = 10000
  statsXLogin.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

  do
    local v69 = false

    if typeof(gethui) == "function" then
      local v70, v71 = pcall(gethui)

      if v70 and v71 then
        statsXLogin.Parent = v71
        v69 = true
      end
    end

    if not v69 then
      local protectGui = typeof(syn) == "table" and syn.protect_gui or protectgui

      if typeof(protectGui) == "function" then
        pcall(protectGui, statsXLogin)
      end

      if pcall(function() statsXLogin.Parent = coreGui end) and statsXLogin.Parent then
        v69 = true
      end
    end

    if not v69 then
      statsXLogin.Parent = localPlayer:WaitForChild("PlayerGui")
    end

    for index2, value2 in ipairs(statsXLogin.Parent:GetChildren()) do
      if value2 ~= statsXLogin and value2.Name == "StatsXLogin" then
        value2:Destroy()
      end
    end
  end

  local function f10(parent, p10)
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, p10 or 8)
    uiCorner.Parent = parent

    return uiCorner
  end

  local function f11(parent2, p11, p12)
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = p11 or v47.Stroke
    uiStroke.Thickness = p12 or 1
    uiStroke.Parent = parent2

    return uiStroke
  end

  local function f12(p13, p14, p15)
    local create = tweenService:Create(p13, p14, p15)
    create:Play()
    return create
  end

  local function f13(parent3, p16, p17, p18, p19)
    local uiGradient = Instance.new("UIGradient")

    if p18 then
      uiGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, p16), ColorSequenceKeypoint.new(0.5, p17),
        ColorSequenceKeypoint.new(1, p18),
      })
    else
      uiGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, p16), ColorSequenceKeypoint.new(1, p17),
      })
    end

    uiGradient.Rotation = p19 or 0
    uiGradient.Parent = parent3

    return uiGradient
  end

  local tweenInfo = TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

  local dim = Instance.new("Frame")
  dim.Name = "Dim"
  dim.Size = UDim2.fromScale(1, 1)
  dim.BackgroundColor3 = Color3.new(0, 0, 0)
  dim.BackgroundTransparency = 1
  dim.BorderSizePixel = 0
  dim.Parent = statsXLogin

  f12(dim, tweenInfo, { BackgroundTransparency = 0.45 })

  local card = Instance.new("Frame")
  card.Name = "Card"
  card.AnchorPoint = Vector2.new(0.5, 0.5)
  card.Position = UDim2.fromScale(0.5, 0.5)
  card.Size = UDim2.fromOffset(404, 476)
  card.BackgroundColor3 = v47.Bg
  card.BorderSizePixel = 0
  card.Parent = statsXLogin

  f10(card, 18)

  local v72 = f11(card, v47.Accent, 1.5)
  v72.Transparency = 0.25

  f13(card, v47.Bg2, v47.Bg, nil, 90)
  card.BackgroundTransparency = 1
  local v73 = 1

  do
    local v74 = v42.viewport()
    local mobile = v42.mobile and 56 or 20
    local mobile2 = v42.mobile and 0.82 or 1
    v73 = math.clamp(math.min((v74.X - mobile) / 404, (v74.Y - mobile) / 476), 0.5, mobile2)
  end

  local uiScale = Instance.new("UIScale")
  uiScale.Scale = v73 * 0.94
  uiScale.Parent = card

  f12(card, tweenInfo, { BackgroundTransparency = 0 })
  f12(uiScale, tweenInfo, { Scale = v73 })

  local frame = Instance.new("Frame")
  frame.Size = UDim2.new(1, -36, 0, 3)
  frame.Position = UDim2.fromOffset(18, 0)
  frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  frame.BorderSizePixel = 0
  frame.Parent = card

  f10(frame, 2)
  f13(frame, v47.Accent, v47.Accent2, v47.Accent3, 0)

  local function f14(text2, p20, p21, p22, p23)
    local textLabel = Instance.new("TextLabel")
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text2
    textLabel.TextSize = p20 or 13
    textLabel.TextColor3 = p21 or v47.Text
    textLabel.Font = p22 or Enum.Font.Gotham
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = p23 or card

    return textLabel
  end

  do
    local frame2 = Instance.new("Frame")
    frame2.Size = UDim2.fromOffset(10, 10)
    frame2.Position = UDim2.fromOffset(20, 26)
    frame2.BackgroundColor3 = v47.Accent
    frame2.BorderSizePixel = 0
    frame2.Parent = card

    f10(frame2, 5)

    local v75 = f11(frame2, v47.Accent, 4)
    v75.Transparency = 0.6
  end

  local v76 = f14("StatsX", 20, v47.Text, Enum.Font.GothamBold)
  v76.Position = UDim2.fromOffset(40, 18)
  v76.Size = UDim2.fromOffset(220, 26)

  local textButton = Instance.new("TextButton")
  textButton.Size = UDim2.fromOffset(30, 30)
  textButton.Position = UDim2.new(1, -50, 0, 16)
  textButton.BackgroundColor3 = v47.Field
  textButton.Text = "X"
  textButton.TextSize = 16
  textButton.Font = Enum.Font.GothamBold
  textButton.TextColor3 = v47.Text
  textButton.AutoButtonColor = false
  textButton.Parent = card

  f10(textButton, 8)

  do
    local v77 = f11(textButton, v47.Stroke, 1)
    v77.Transparency = 0.3
  end

  do
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Size = UDim2.fromOffset(44, 44)
    imageLabel.Position = UDim2.fromOffset(20, 62)
    imageLabel.BackgroundColor3 = v47.Field
    imageLabel.BorderSizePixel = 0
    imageLabel.Parent = card

    f10(imageLabel, 22)
    f11(imageLabel, v47.Accent, 2)

    task.spawn(function()
      local v78, v79 = pcall(function()
        return players:GetUserThumbnailAsync(
          localPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150
        )
      end)

      if v78 and v79 then
        imageLabel.Image = v79
      end
    end)

    local v80 = f14("Account login", 15, v47.Text, Enum.Font.GothamBold)
    v80.Position = UDim2.fromOffset(76, 68)
    v80.Size = UDim2.new(1, -96, 0, 20)

    local v81 = f14("@" .. localPlayer.Name .. "  -  Build 1.17", 12, v47.Sub)
    v81.Position = UDim2.fromOffset(76, 88)
    v81.Size = UDim2.new(1, -96, 0, 16)

    local frame3 = Instance.new("Frame")
    frame3.Size = UDim2.new(1, -40, 0, 1)
    frame3.Position = UDim2.fromOffset(20, 118)
    frame3.BackgroundColor3 = v47.Stroke
    frame3.BorderSizePixel = 0
    frame3.Parent = card
  end

  local function f15(p24, p25, placeholderText, p26)
    local v82 = f14(p25, 10, v47.Sub, Enum.Font.GothamBold)
    v82.Position = UDim2.fromOffset(20, p24)
    v82.Size = UDim2.fromOffset(320, 14)

    local textBox = Instance.new("TextBox")
    textBox.Position = UDim2.fromOffset(20, p24 + 18)
    textBox.Size = UDim2.new(1, -40, 0, 42)
    textBox.BackgroundColor3 = v47.Field
    textBox.TextColor3 = v47.Text
    textBox.PlaceholderColor3 = Color3.fromRGB(90, 90, 108)
    textBox.PlaceholderText = placeholderText
    textBox.Text = p26 or ""
    textBox.Font = Enum.Font.Code
    textBox.TextSize = 14
    textBox.ClearTextOnFocus = false
    textBox.TextXAlignment = Enum.TextXAlignment.Left
    textBox.Parent = card

    f10(textBox, 10)
    local v83 = f11(textBox, v47.Stroke, 1)

    local uiPadding = Instance.new("UIPadding")
    uiPadding.PaddingLeft = UDim.new(0, 12)
    uiPadding.PaddingRight = UDim.new(0, 12)
    uiPadding.Parent = textBox

    textBox.Focused:Connect(function() f12(v83, tweenInfo, { Color = v47.Accent }) end)
    textBox.FocusLost:Connect(function() f12(v83, tweenInfo, { Color = v47.Stroke }) end)

    return textBox
  end

  local v84 = f6()

  local v85 = f15(
    134, "ROBLOX USERNAME", "your Roblox username", v84 and v84.user or localPlayer.Name
  )

  local v86 = f15(206, "KEY", "STATSX-XXXX-XXXX-XXXX", v84 and v84.key or "")

  local v87 = f14("", 12, v47.Sub)
  v87.Position = UDim2.fromOffset(20, 276)
  v87.Size = UDim2.new(1, -40, 0, 34)
  v87.TextWrapped = true
  v87.TextYAlignment = Enum.TextYAlignment.Top

  local textButton2 = Instance.new("TextButton")
  textButton2.Position = UDim2.fromOffset(20, 316)
  textButton2.Size = UDim2.new(1, -40, 0, 44)
  textButton2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  textButton2.Text = ""
  textButton2.AutoButtonColor = false
  textButton2.Parent = card

  f10(textButton2, 10)
  local v88 = f13(textButton2, v47.Accent, v47.Accent2, v47.Accent3, 0)

  local v89 = f14(
    "UNLOCK", 13, Color3.fromRGB(255, 255, 255), Enum.Font.GothamBold, textButton2
  )

  v89.Size = UDim2.fromScale(1, 1)
  v89.TextXAlignment = Enum.TextXAlignment.Center

  local textButton3 = Instance.new("TextButton")
  textButton3.Position = UDim2.fromOffset(20, 370)
  textButton3.Size = UDim2.new(1, -40, 0, 42)
  textButton3.BackgroundColor3 = v47.Field
  textButton3.Text = "GET A FREE 12 HOUR KEY"
  textButton3.TextSize = 12
  textButton3.Font = Enum.Font.GothamBold
  textButton3.TextColor3 = v47.Text
  textButton3.AutoButtonColor = false
  textButton3.Parent = card

  f10(textButton3, 10)

  do
    local v90 = f11(textButton3, v47.Stroke, 1)
    v90.Transparency = 0.3
  end

  local v91 = f14(
    "Copies the work.ink link. Finish it, log in on the StatsX site with this username, then paste your key above.",
    11, v47.Sub
  )

  v91.Position = UDim2.fromOffset(20, 420)
  v91.Size = UDim2.new(1, -40, 0, 28)
  v91.TextWrapped = true
  v91.TextYAlignment = Enum.TextYAlignment.Top

  local textButton4 = Instance.new("TextButton")
  textButton4.Position = UDim2.fromOffset(20, 450)
  textButton4.Size = UDim2.new(1, -40, 0, 18)
  textButton4.BackgroundTransparency = 1
  textButton4.Text = "copy account page link"
  textButton4.TextSize = 11
  textButton4.Font = Enum.Font.GothamMedium
  textButton4.TextColor3 = v47.Accent
  textButton4.TextXAlignment = Enum.TextXAlignment.Left
  textButton4.Parent = card

  local function f16(p27, backgroundColor3, backgroundColor32)
    p27.MouseEnter:Connect(function()
      f12(p27, tweenInfo, { BackgroundColor3 = backgroundColor32 })
    end)

    p27.MouseLeave:Connect(function()
      f12(p27, tweenInfo, { BackgroundColor3 = backgroundColor3 })
    end)
  end

  textButton2.MouseEnter:Connect(function()
    f12(v88, tweenInfo, { Offset = Vector2.new(0.14, 0) })
  end)

  textButton2.MouseLeave:Connect(function()
    f12(v88, tweenInfo, { Offset = Vector2.new(0, 0) })
  end)

  f16(textButton3, v47.Field, Color3.fromRGB(37, 37, 49))
  f16(textButton, v47.Field, Color3.fromRGB(220, 70, 80))

  local function f17(p28, p29)
    v87.Text = p28 or ""
    v87.TextColor3 = p29 == "bad" and v47.Bad or p29 == "ok" and v47.Ok or v47.Sub
  end

  local function f18(p30)
    local v92 = typeof(setclipboard) == "function" and setclipboard
      or typeof(toclipboard) == "function" and toclipboard

    if v92 then
      return (pcall(v92, p30))
    end

    return false
  end

  textButton3.MouseButton1Click:Connect(function()
    if f18("https://statsx-api.discordflex911.workers.dev/v1/gate/start") then
      f17(
        "Key link copied. Paste it in your browser, clear all 3 checkpoints, then log in on the site to see your key.",
        "ok"
      )
    else
      f17(
        "Open this in your browser: https://statsx-api.discordflex911.workers.dev/v1/gate/start",
        "ok"
      )
    end
  end)

  textButton4.MouseButton1Click:Connect(function()
    if f18("https://synchronizingframes.github.io/StatsX/account.html") then
      f17(
        "Account page link copied: https://synchronizingframes.github.io/StatsX/account.html",
        "ok"
      )
    else
      f17("https://synchronizingframes.github.io/StatsX/account.html", "ok")
    end
  end)

  local function f19(p31)
    for index3, value3 in ipairs(card:GetDescendants()) do
      pcall(function()
        if value3:IsA("TextLabel") or value3:IsA("TextButton") or value3:IsA("TextBox") then
          f12(value3, p31, { TextTransparency = 1, BackgroundTransparency = 1 })
        elseif value3:IsA("ImageLabel") then
          f12(value3, p31, { ImageTransparency = 1, BackgroundTransparency = 1 })
        elseif value3:IsA("Frame") then
          f12(value3, p31, { BackgroundTransparency = 1 })
        elseif value3:IsA("UIStroke") then
          f12(value3, p31, { Transparency = 1 })
        end
      end)
    end
  end

  local function f20(p32)
    v46 = p32

    if not p32 then
      f12(dim, tweenInfo, { BackgroundTransparency = 1 })
      f12(card, tweenInfo, { BackgroundTransparency = 1 })
      f12(uiScale, tweenInfo, { Scale = v73 * 0.96 })

      f19(tweenInfo)
      task.delay(0.36, function() pcall(function() statsXLogin:Destroy() end) end)
      v45 = true
      return
    end

    task.delay(1.2, function()
      pcall(function() statsXLogin:Destroy() end)
      v45 = true
    end)

    local function f21(p33, p34)
      task.delay(p33, function() end)
    end

    pcall(function()
      local out = Enum.EasingDirection.Out
      local quint = Enum.EasingStyle.Quint
      local text3 = v85.Text
      card.ClipsDescendants = true

      f12(v72, TweenInfo.new(0.28, quint, out), { Color = v47.Ok, Transparency = 0 })
      f12(uiScale, TweenInfo.new(0.14, Enum.EasingStyle.Quad, out), { Scale = v73 * 1.025 })

      f21(0.14, function() f12(uiScale, TweenInfo.new(0.24, quint, out), { Scale = v73 }) end)

      for n = 0, 1 do
        f21(n * 0.12, function()
          local frame4 = Instance.new("Frame")
          frame4.AnchorPoint = Vector2.new(0.5, 0.5)
          frame4.Position = UDim2.fromScale(0.5, 0.5)
          frame4.Size = card.Size
          frame4.BackgroundTransparency = 1
          frame4.BorderSizePixel = 0
          frame4.ZIndex = 3
          frame4.Parent = statsXLogin

          f10(frame4, 18)

          local v93 = f11(frame4, v47.Ok, 2)
          v93.Transparency = 0.15

          local uiScale2 = Instance.new("UIScale")
          uiScale2.Scale = v73
          uiScale2.Parent = frame4

          f12(uiScale2, TweenInfo.new(0.62, quint, out), { Scale = v73 * 1.16 })
          f12(v93, TweenInfo.new(0.62, quint, out), { Transparency = 1 })
        end)
      end

      local frame5 = Instance.new("Frame")
      frame5.AnchorPoint = Vector2.new(0.5, 0.5)
      frame5.Position = UDim2.new(0, -90, 0.5, 0)
      frame5.Size = UDim2.new(0, 130, 2, 0)
      frame5.Rotation = 16
      frame5.ZIndex = 6
      frame5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      frame5.BackgroundTransparency = 0.82
      frame5.BorderSizePixel = 0
      frame5.Parent = card

      local uiGradient2 = Instance.new("UIGradient")

      uiGradient2.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(1, 1),
      })

      uiGradient2.Parent = frame5

      f12(frame5, TweenInfo.new(0.52, quint, out), { Position = UDim2.new(1, 110, 0.5, 0) })

      f21(0.34, function()
        f19(TweenInfo.new(0.22, Enum.EasingStyle.Sine, out))

        local frame6 = Instance.new("Frame")
        frame6.AnchorPoint = Vector2.new(0.5, 0.5)
        frame6.Position = UDim2.fromScale(0.5, 0.44)
        frame6.Size = UDim2.fromOffset(82, 82)
        frame6.BackgroundColor3 = v47.Ok
        frame6.BackgroundTransparency = 0.86
        frame6.BorderSizePixel = 0
        frame6.ZIndex = 8
        frame6.Parent = card

        f10(frame6, 41)
        f11(frame6, v47.Ok, 2)

        local uiScale3 = Instance.new("UIScale")
        uiScale3.Scale = 0.5
        uiScale3.Parent = frame6

        f12(uiScale3, TweenInfo.new(0.34, Enum.EasingStyle.Back, out), { Scale = 1 })

        local frame7 = Instance.new("Frame")
        frame7.AnchorPoint = Vector2.new(0, 0.5)
        frame7.Position = UDim2.new(0.5, -16, 0.5, -1)
        frame7.Size = UDim2.fromOffset(0, 4)
        frame7.Rotation = 45
        frame7.BackgroundColor3 = v47.Text
        frame7.BorderSizePixel = 0
        frame7.ZIndex = 9
        frame7.Parent = frame6

        f10(frame7, 2)

        local frame8 = Instance.new("Frame")
        frame8.AnchorPoint = Vector2.new(0, 0.5)
        frame8.Position = UDim2.new(0.5, -5, 0.5, 10)
        frame8.Size = UDim2.fromOffset(0, 4)
        frame8.Rotation = -55
        frame8.BackgroundColor3 = v47.Text
        frame8.BorderSizePixel = 0
        frame8.ZIndex = 9
        frame8.Parent = frame6

        f10(frame8, 2)
        f12(frame7, TweenInfo.new(0.14, quint, out), { Size = UDim2.fromOffset(16, 4) })

        f21(0.12, function()
          f12(frame8, TweenInfo.new(0.2, quint, out), { Size = UDim2.fromOffset(30, 4) })
        end)

        local v94 = f14("Welcome, @" .. text3, 14, v47.Text, Enum.Font.GothamBold)
        v94.Position = UDim2.new(0, 20, 0.44, 56)
        v94.Size = UDim2.new(1, -40, 0, 20)
        v94.TextXAlignment = Enum.TextXAlignment.Center
        v94.TextTransparency = 1
        v94.ZIndex = 8

        f12(v94, TweenInfo.new(0.3, Enum.EasingStyle.Sine, out), { TextTransparency = 0 })
      end)

      f21(0.78, function()
        local tweenInfo2 = TweenInfo.new(0.36, quint, out)

        f12(dim, tweenInfo2, { BackgroundTransparency = 1 })
        f12(card, tweenInfo2, { BackgroundTransparency = 1 })
        f12(v72, tweenInfo2, { Transparency = 1 })
        f12(uiScale, TweenInfo.new(0.4, quint, out), { Scale = v73 * 0.86 })

        f19(TweenInfo.new(0.28, quint, out))
      end)
    end)
  end

  local function f22()
    if typeof(gethui) == "function" then
      local v95, v96 = pcall(gethui)

      if v95 and v96 then
        return v96
      end
    end

    local v97, v98 = pcall(function() return coreGui end)

    if v97 and v98 then
      return v98
    end

    return localPlayer:WaitForChild("PlayerGui")
  end

  local function f23(p35, p36, p37)
    local v99 = {
      user = tostring(p35),
      key = tostring(p37 or p36.key or ""),
      plan = tostring(p36.plan or "free"),
      label = tostring(p36.duration_label or ""),
      never = p36.never == true or p36.left == nil,
      expiresAt = nil,
    }

    if not v99.never then
      v99.expiresAt = os.time() + math.max(0, math.floor((tonumber(p36.left) or 0) / 1000))
    end

    _G.StatsX_PLAN = v99
    local v100 = f22()

    for index4, value4 in ipairs(v100:GetChildren()) do
      if value4.Name == "StatsXPlan" then
        pcall(function() value4:Destroy() end)
      end
    end

    local statsXPlan = Instance.new("ScreenGui")
    statsXPlan.Name = "StatsXPlan"
    statsXPlan.ResetOnSpawn = false
    statsXPlan.IgnoreGuiInset = true
    statsXPlan.DisplayOrder = 9998
    statsXPlan.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    statsXPlan.Parent = v100

    local pill = Instance.new("Frame")
    pill.Name = "Pill"
    pill.AnchorPoint = Vector2.new(1, 0)
    pill.Position = UDim2.new(1, -14, 0, 14)
    pill.Size = UDim2.fromOffset(206, 36)
    pill.BackgroundColor3 = v47.Bg
    pill.BorderSizePixel = 0
    pill.Active = true
    pill.Draggable = true
    pill.Parent = statsXPlan

    f10(pill, 10)
    f11(pill, v47.Edge, 1)

    local frame9 = Instance.new("Frame")
    frame9.Size = UDim2.new(0, 3, 1, -14)
    frame9.Position = UDim2.new(0, 6, 0, 7)
    frame9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    frame9.BorderSizePixel = 0
    frame9.Parent = pill

    f10(frame9, 2)
    f13(frame9, v47.Accent, v47.Accent2, v47.Accent3, 90)

    local frame10 = Instance.new("Frame")
    frame10.Size = UDim2.fromOffset(6, 6)
    frame10.Position = UDim2.new(0, 13, 0.5, -3)
    frame10.BackgroundColor3 = v47.Ok
    frame10.BorderSizePixel = 0
    frame10.Parent = pill

    f10(frame10, 3)

    local v101 = f14("STATSX  -  @" .. v99.user, 10, v47.Sub, Enum.Font.GothamBold, pill)
    v101.Position = UDim2.new(0, 27, 0, 5)
    v101.Size = UDim2.new(1, -56, 0, 12)

    local v102 = f14("", 12, v47.Text, Enum.Font.GothamMedium, pill)
    v102.Position = UDim2.new(0, 27, 0, 18)
    v102.Size = UDim2.new(1, -56, 0, 13)

    local hide = Instance.new("TextButton")
    hide.Name = "Hide"
    hide.AnchorPoint = Vector2.new(1, 0.5)
    hide.Position = UDim2.new(1, -9, 0.5, 0)
    hide.Size = UDim2.fromOffset(20, 20)
    hide.BackgroundColor3 = v47.Field
    hide.BackgroundTransparency = 1
    hide.Text = "x"
    hide.TextSize = 13
    hide.Font = Enum.Font.GothamBold
    hide.TextColor3 = v47.Sub
    hide.AutoButtonColor = false
    hide.Parent = pill

    f10(hide, 6)

    hide.MouseEnter:Connect(function()
      f12(hide, tweenInfo, { BackgroundTransparency = 0 })
      hide.TextColor3 = v47.Text
    end)

    hide.MouseLeave:Connect(function()
      f12(hide, tweenInfo, { BackgroundTransparency = 1 })
      hide.TextColor3 = v47.Sub
    end)

    hide.MouseButton1Click:Connect(function() pcall(function() statsXPlan:Destroy() end) end)

    local function f24()
      if v99.never then
        v102.Text = "Lifetime plan  -  no expiry"
        frame10.BackgroundColor3 = v47.Accent
        return
      end

      local v103 = math.max(0, (v99.expiresAt or 0) - os.time())
      local v104 = math.floor(v103 / 86400)
      local v105 = math.floor(v103 % 86400 / 3600)
      local v106 = math.floor(v103 % 3600 / 60)
      local v107 = v103 % 60

      if v103 <= 0 then
        v102.Text = "Key expired  -  get a new one"
        frame10.BackgroundColor3 = v47.Bad
        return
      end

      if v104 > 0 then
        v102.Text = string.format("%dd %02dh %02dm left", v104, v105, v106)
      elseif v105 > 0 then
        v102.Text = string.format("%dh %02dm %02ds left", v105, v106, v107)
      else
        v102.Text = string.format("%dm %02ds left", v106, v107)
      end

      if v103 < 3600 then
        frame10.BackgroundColor3 = v47.Bad
      elseif v103 < 21600 then
        frame10.BackgroundColor3 = Color3.fromRGB(250, 190, 90)
      else
        frame10.BackgroundColor3 = v47.Ok
      end
    end

    f24()

    task.spawn(function()
      while statsXPlan.Parent do
        task.wait(1)

        if not statsXPlan.Parent then
          break
        end

        pcall(f24)
      end
    end)

    task.spawn(function()
      while statsXPlan.Parent do
        task.wait(300)

        if not statsXPlan.Parent then
          break
        end

        if v99.key ~= "" then
          local v108 = f5(v99.user, v99.key)

          if type(v108) == "table" then
            if v108.ok then
              v99.never = v108.never == true or v108.left == nil

              if v99.never then
                v99.expiresAt = nil
              else
                v99.expiresAt = os.time()
                  + math.max(0, math.floor((tonumber(v108.left) or 0) / 1000))
              end

              pcall(f24)
            elseif v108.error == "expired" or v108.error == "revoked"
              or v108.error == "banned" or v108.error == "wrong_account" then
              v102.Text = tostring(v108.message or "Key no longer valid")
              frame10.BackgroundColor3 = v47.Bad
            end
          end
        end
      end
    end)

    function _G.StatsX_ShowPlan()
      return f23(p35, p36, p37)
    end
  end

  local v109 = false

  local function f25(p38)
    if v109 then
      return
    end

    local gsub = (v85.Text or ""):gsub("^%s+", ""):gsub("%s+$", ""):gsub("^@", "")
    local upper = (v86.Text or ""):gsub("%s+", ""):upper()

    if gsub == "" then
      f17("Type your Roblox username.", "bad")
      return
    end

    if gsub:lower() ~= localPlayer.Name:lower() then
      f17("You are playing as @" .. localPlayer.Name
        .. ". Keys only work on the account they were made for.", "bad")

      return
    end

    local v110 = upper:match("^STATSX%-GIFT%-%w%w%w%w%-%w%w%w%w%-%w%w%w%w$") ~= nil

    if not v110 and not upper:match("^STATSX%-%w%w%w%w%-%w%w%w%w%-%w%w%w%w$") then
      if not p38 then
        f17("That does not look like a StatsX key. Copy it from your account page.", "bad")
      end

      return
    end

    v109 = true
    v89.Text = "CHECKING..."
    f17("Asking the server...", nil)

    task.spawn(function()
      local v111 = f5(gsub, upper)
      v109 = false

      if v111.ok then
        local key = type(v111.key) == "string" and v111.key ~= "" and v111.key or upper
        f7(gsub, key)

        if v110 then
          v86.Text = key
        end

        local v112 = (v111.never == true or v111.left == nil) and "This key never expires."
          or f9(v111.left) .. " left on this key."

        v88.Enabled = false
        v89.Text = "UNLOCKED"
        textButton2.BackgroundColor3 = v47.Ok
        v89.TextColor3 = Color3.fromRGB(18, 26, 20)
        pcall(f23, tostring(v111.user or gsub), v111, key)

        local v113 = type(v111.motd) == "string" and v111.motd ~= "" and "  -  " .. v111.motd
          or ""

        f17((v110 and "Gift code accepted. " or "") .. "Welcome, @"
          .. tostring(v111.user or gsub) .. ". " .. v112 .. v113, "ok")

        task.delay(0.55, function() f20(true) end)
      else
        v89.Text = "UNLOCK"

        if v111.error == "expired" or v111.error == "invalid_key" or v111.error == "revoked"
          or v111.error == "wrong_user" or v111.error == "wrong_account" then
          f8()
        end

        f17(tostring(v111.message or "Could not verify the key."), "bad")
      end
    end)
  end

  textButton2.MouseButton1Click:Connect(function() f25(false) end)

  v86.FocusLost:Connect(function(p39)
    if p39 then
      f25(false)
    end
  end)

  textButton.MouseButton1Click:Connect(function()
    f20(false)
    task.delay(0.4, function() statsXLogin:Destroy() end)
  end)

  if ("https://statsx-api.discordflex911.workers.dev"):find("YOURNAME", 1, true) then
    f17(
      "Setup needed: set GATE.API_URL at the top of the script to your Cloudflare Worker URL.",
      "bad"
    )
  elseif v84 and v84.key ~= "" then
    f17("Saved key found. Checking...", nil)
    f25(true)
  end
end

repeat
  task.wait()
until v45

if not v46 then
  return
end

local statsX = Instance.new("ScreenGui")
statsX.Name = "StatsX"
statsX.ResetOnSpawn = false
statsX.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
statsX.IgnoreGuiInset = true
statsX.DisplayOrder = 9999

local v114 = false

if typeof(gethui) == "function" then
  local v115, v116 = pcall(gethui)

  if v115 and v116 then
    statsX.Parent = v116
    v114 = true
  end
end

if not v114 then
  local protectGui2 = typeof(syn) == "table" and syn.protect_gui or protectgui

  if typeof(protectGui2) == "function" then
    pcall(protectGui2, statsX)
  end

  if pcall(function() statsX.Parent = coreGui end) and statsX.Parent then
    v114 = true
  end
end

if not v114 then
  statsX.Parent = localPlayer:WaitForChild("PlayerGui")
end

for index5, value5 in ipairs(statsX.Parent:GetChildren()) do
  if value5 ~= statsX and value5.Name == "StatsX" then
    value5:Destroy()
  end
end

local v117 = {
  Background = Color3.fromRGB(16, 16, 22),
  Background2 = Color3.fromRGB(22, 22, 30),
  Row = Color3.fromRGB(29, 29, 39),
  RowHover = Color3.fromRGB(37, 37, 49),
  RowActive = Color3.fromRGB(33, 33, 45),
  Stroke = Color3.fromRGB(45, 45, 59),
  Text = Color3.fromRGB(242, 242, 250),
  SubText = Color3.fromRGB(140, 140, 158),
  TrackOff = Color3.fromRGB(55, 55, 70),
}

local color = Color3.fromRGB(132, 106, 255)
local color2 = color

local v118 = {
  Smooth = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
  Snappy = TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
  Knob = TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
  Hover = TweenInfo.new(0.16, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
  Open = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
  Morph = TweenInfo.new(0.42, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
}

local v119 = false

local function f26(p40, p41, p42)
  local create2 = tweenService:Create(p40, p41, p42)
  create2:Play()
  return create2
end

local function f27(parent4, p43)
  local uiCorner2 = Instance.new("UICorner")
  uiCorner2.CornerRadius = UDim.new(0, p43 or 8)
  uiCorner2.Parent = parent4

  return uiCorner2
end

local function f28(parent5, color3, p44, p45)
  local uiStroke2 = Instance.new("UIStroke")
  uiStroke2.Color = color3
  uiStroke2.Thickness = p44 or 1
  uiStroke2.Transparency = p45 or 0
  uiStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
  uiStroke2.Parent = parent5

  return uiStroke2
end

local function f29(parent6, p46, p47, p48)
  local uiGradient3 = Instance.new("UIGradient")
  uiGradient3.Rotation = p48 or 90

  uiGradient3.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, p46), ColorSequenceKeypoint.new(1, p47),
  })

  uiGradient3.Parent = parent6

  return uiGradient3
end

local v120 = {}

local function f30(p49)
  v120[p49] = true
end

local v121, v122 = false, 2
local v123, v124, v125 = false, false, 0.55
local v126, v127, v128 = false, false, false
local v129 = {}
local v130 = {}
local v131, v132 = false, false
local v133, v134 = false, 50
local v135, v136 = false, 100
local v137, v138 = false, 90
local v139 = false
local connect, v140, v141 = nil, 0.12, 0.7
local v142 = {}
local udim, udim2

do
  local v143, v144 = 404, 506

  if v42.mobile then
    local v145 = v42.viewport()
    v143 = math.clamp(math.floor(v145.X - 20), 288, 404)
    v144 = math.clamp(math.floor(v145.Y - 130), 320, 506)
  end

  udim = UDim2.fromOffset(v143, v144)
  udim2 = UDim2.fromOffset(math.min(280, v143 - 8), 54)
end

local udim3 = UDim2.fromScale(0.5, 0.5)
local udim4 = UDim2.new(0.5, 0, 0, 42)

local main = Instance.new("Frame")
main.Name = "Main"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = udim3
main.Size = udim
main.BackgroundColor3 = v117.Background
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = statsX

f27(main, 18)

v42.scale = Instance.new("UIScale")
v42.scale.Scale = 1
v42.scale.Parent = main

function v42.fit()
  local v146 = v42.viewport()
  local offset, offset2 = main.Size.X.Offset, main.Size.Y.Offset

  if offset < 2 or offset2 < 2 then
    return
  end

  v42.scale.Scale = math.clamp(
    math.min((v146.X - 12) / offset, (v146.Y - 12) / offset2), 0.5, 1
  )
end

function v42.clamp()
  local v147 = v42.viewport()
  local absoluteSize = main.AbsoluteSize
  local position = main.Position
  local v148 = position.X.Scale * v147.X + position.X.Offset
  local v149 = position.Y.Scale * v147.Y + position.Y.Offset
  local v150, v151 = absoluteSize.X * 0.5, v147.X - absoluteSize.X * 0.5
  local v152, v153 = absoluteSize.Y * 0.5, v147.Y - absoluteSize.Y * 0.5

  if v150 > v151 then
    v150, v151 = v147.X * 0.5, v147.X * 0.5
  end

  if v152 > v153 then
    v152, v153 = v147.Y * 0.5, v147.Y * 0.5
  end

  main.Position = UDim2.new(position.X.Scale, math.floor(math.clamp(v148, v150, v151) - position.X.Scale * v147.X
    + 0.5), position.Y.Scale, math.floor(math.clamp(v149, v152, v153) - position.Y.Scale * v147.Y
    + 0.5))
end

v42.fit()

statsX:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
  task.defer(function()
    v42.fit()
    v42.clamp()
  end)
end)

local v154 = f28(main, color2, 1.5, 0.25)
f30(v154)
f29(main, v117.Background2, v117.Background, 90)

local frame11 = Instance.new("Frame")
frame11.Size = UDim2.new(1, -36, 0, 3)
frame11.Position = UDim2.fromOffset(18, 0)
frame11.BackgroundColor3 = color2
frame11.BorderSizePixel = 0
frame11.Parent = main

f27(frame11, 2)
f30(frame11)

local header = Instance.new("Frame")
header.Name = "Header"
header.BackgroundTransparency = 1
header.Size = UDim2.new(1, 0, 0, 54)
header.Position = UDim2.fromOffset(0, 4)
header.Parent = main

local frame12 = Instance.new("Frame")
frame12.Size = UDim2.fromOffset(10, 10)
frame12.Position = UDim2.fromOffset(20, 22)
frame12.BackgroundColor3 = color2
frame12.BorderSizePixel = 0
frame12.Parent = header

f27(frame12, 5)
f30(frame12)
f28(frame12, color2, 4, 0.6)

local textLabel2 = Instance.new("TextLabel")
textLabel2.BackgroundTransparency = 1
textLabel2.Position = UDim2.fromOffset(40, 14)
textLabel2.Size = UDim2.new(1, -130, 0, 26)
textLabel2.Font = Enum.Font.GothamBold
textLabel2.Text = "StatsX"
textLabel2.TextColor3 = v117.Text
textLabel2.TextSize = 20
textLabel2.TextXAlignment = Enum.TextXAlignment.Left
textLabel2.Parent = header

local function f31(text4, p50)
  local textButton5 = Instance.new("TextButton")
  textButton5.Size = UDim2.fromOffset(30, 30)
  textButton5.Position = UDim2.new(1, p50, 0, 13)
  textButton5.BackgroundColor3 = v117.Row
  textButton5.Text = text4
  textButton5.TextColor3 = v117.Text
  textButton5.TextSize = 18
  textButton5.Font = Enum.Font.GothamBold
  textButton5.AutoButtonColor = false
  textButton5.Parent = header

  f27(textButton5, 8)
  f28(textButton5, v117.Stroke, 1, 0.3)
  return textButton5
end

local v155 = f31("X", -42)
local v156 = f31("-", -80)

v155.MouseEnter:Connect(function()
  f26(v155, v118.Hover, { BackgroundColor3 = Color3.fromRGB(220, 70, 80) })
end)

v155.MouseLeave:Connect(function() f26(v155, v118.Hover, { BackgroundColor3 = v117.Row }) end)

v156.MouseEnter:Connect(function()
  f26(v156, v118.Hover, { BackgroundColor3 = Color3.fromRGB(235, 185, 60) })
end)

v156.MouseLeave:Connect(function() f26(v156, v118.Hover, { BackgroundColor3 = v117.Row }) end)

local body = Instance.new("Frame")
body.Name = "Body"
body.BackgroundTransparency = 1
body.ClipsDescendants = true
body.Position = UDim2.fromOffset(0, 54)
body.Size = UDim2.new(1, 0, 1, -54)
body.Parent = main

local frame13 = Instance.new("Frame")
frame13.BackgroundTransparency = 1
frame13.Position = UDim2.fromOffset(0, 6)
frame13.Size = UDim2.new(1, 0, 0, 58)
frame13.Parent = body

local imageLabel2 = Instance.new("ImageLabel")
imageLabel2.Size = UDim2.fromOffset(46, 46)
imageLabel2.Position = UDim2.fromOffset(20, 6)
imageLabel2.BackgroundColor3 = v117.Row
imageLabel2.Parent = frame13

f27(imageLabel2, 23)
f30((f28(imageLabel2, color2, 2.5, 0)))

task.spawn(function()
  local v157, v158 = pcall(function()
    return players:GetUserThumbnailAsync(
      localPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180
    )
  end)

  if v157 and v158 then
    imageLabel2.Image = v158
  end
end)

local textLabel3 = Instance.new("TextLabel")
textLabel3.BackgroundTransparency = 1
textLabel3.Position = UDim2.fromOffset(78, 10)
textLabel3.Size = UDim2.new(1, -98, 0, 22)
textLabel3.Font = Enum.Font.GothamBold
textLabel3.Text = "Welcome, " .. (localPlayer.DisplayName or localPlayer.Name) .. "!"
textLabel3.TextColor3 = v117.Text
textLabel3.TextSize = 16
textLabel3.TextXAlignment = Enum.TextXAlignment.Left
textLabel3.Parent = frame13

local textLabel4 = Instance.new("TextLabel")
textLabel4.BackgroundTransparency = 1
textLabel4.Position = UDim2.fromOffset(78, 30)
textLabel4.Size = UDim2.new(1, -98, 0, 16)
textLabel4.Font = Enum.Font.Gotham
textLabel4.Text = "@" .. localPlayer.Name
textLabel4.TextColor3 = v117.SubText
textLabel4.TextSize = 12
textLabel4.TextXAlignment = Enum.TextXAlignment.Left
textLabel4.Parent = frame13

local frame14 = Instance.new("Frame")
frame14.Size = UDim2.new(1, -40, 0, 1)
frame14.Position = UDim2.fromOffset(20, 64)
frame14.BackgroundColor3 = v117.Stroke
frame14.BorderSizePixel = 0
frame14.Parent = body

local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.BorderSizePixel = 0
scrollingFrame.Position = UDim2.fromOffset(0, 148)
scrollingFrame.Size = UDim2.new(1, 0, 1, -186)
scrollingFrame.ScrollBarThickness = 4
scrollingFrame.ScrollBarImageColor3 = color2
scrollingFrame.CanvasSize = UDim2.new()
scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
scrollingFrame.Parent = body

local uiPadding2 = Instance.new("UIPadding")
uiPadding2.PaddingLeft = UDim.new(0, 18)
uiPadding2.PaddingRight = UDim.new(0, 18)
uiPadding2.PaddingTop = UDim.new(0, 2)
uiPadding2.PaddingBottom = UDim.new(0, 10)
uiPadding2.Parent = scrollingFrame

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Padding = UDim.new(0, 10)
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Parent = scrollingFrame

local frame15 = Instance.new("Frame")
frame15.BackgroundTransparency = 1
frame15.AnchorPoint = Vector2.new(0, 1)
frame15.Position = UDim2.new(0, 0, 1, 0)
frame15.Size = UDim2.new(1, 0, 0, 34)
frame15.Parent = body

local textLabel5 = Instance.new("TextLabel")
textLabel5.BackgroundTransparency = 1
textLabel5.Position = UDim2.fromOffset(20, 0)
textLabel5.Size = UDim2.new(1, -40, 1, 0)
textLabel5.Font = Enum.Font.Gotham
textLabel5.Text = "FPS: --   Ping: -- ms"
textLabel5.TextColor3 = v117.SubText
textLabel5.TextSize = 12
textLabel5.TextXAlignment = Enum.TextXAlignment.Left
textLabel5.Parent = frame15

local v159 = { "Visuals", "Movement", "Player", "Hubs" }

local v160 = {
  fullbright = "Visuals",
  esp = "Visuals",
  fov = "Visuals",
  rainbow = "Visuals",
  clean = "Visuals",
  walk = "Movement",
  jump = "Movement",
  infjump = "Movement",
  fly = "Movement",
  noclip = "Movement",
  gravity = "Movement",
  speed = "Player",
  afk = "Player",
  visibility = "Player",
  aimlock = "Player",
}

local v161 = {}
local v162 = {}
local v163 = {}
local v164 = "Visuals"

local tabBar = Instance.new("Frame")
tabBar.Name = "TabBar"
tabBar.BackgroundColor3 = v117.Row
tabBar.BorderSizePixel = 0
tabBar.Position = UDim2.fromOffset(18, 72)
tabBar.Size = UDim2.new(1, -76, 0, 34)
tabBar.Parent = body

f27(tabBar, 10)

local uiPadding3 = Instance.new("UIPadding")
uiPadding3.PaddingLeft = UDim.new(0, 4)
uiPadding3.PaddingRight = UDim.new(0, 4)
uiPadding3.PaddingTop = UDim.new(0, 4)
uiPadding3.PaddingBottom = UDim.new(0, 4)
uiPadding3.Parent = tabBar

local uiListLayout2 = Instance.new("UIListLayout")
uiListLayout2.FillDirection = Enum.FillDirection.Horizontal
uiListLayout2.Padding = UDim.new(0, 4)
uiListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout2.Parent = tabBar

local function f32(p51)
  v164 = p51

  for key2, value6 in pairs(v161) do
    for index6, value7 in ipairs(value6) do
      value7.Visible = key2 == p51
    end
  end

  for key3, value8 in pairs(v162) do
    local v165 = key3 == p51
    f26(value8, v118.Hover, { BackgroundColor3 = v165 and color2 or v117.Row })
    value8.TextColor3 = v165 and Color3.fromRGB(22, 22, 30) or v117.SubText

    if v165 then
      v120[value8] = true
    else
      v120[value8] = nil
    end
  end

  scrollingFrame.CanvasPosition = Vector2.new(0, 0)
end

for index7, value9 in ipairs(v159) do
  local textButton6 = Instance.new("TextButton")
  textButton6.Name = value9
  textButton6.Size = UDim2.new(1 / #v159, -4, 1, 0)
  textButton6.BackgroundColor3 = v117.Row
  textButton6.Text = value9
  textButton6.Font = Enum.Font.GothamMedium
  textButton6.TextSize = 13
  textButton6.TextColor3 = v117.SubText
  textButton6.AutoButtonColor = false
  textButton6.LayoutOrder = index7
  textButton6.Parent = tabBar

  f27(textButton6, 8)
  v162[value9] = textButton6
  textButton6.MouseButton1Click:Connect(function() f32(value9) end)
end

local function f33()
  local v166 = {
    {
      name = "TSB Hub",
      by = "The Strongest Battlegrounds",
      icon = "👊",
      urls = {
        "https://gist.githubusercontent.com/SynchronizingFrames/ef4bce240bb0ac17a19186dc265b9234/raw/Build1.18TSBHub.obf.lua",
        "https://gist.githubusercontent.com/SynchronizingFrames/ef4bce240bb0ac17a19186dc265b9234/raw/Build1.18TSBHub.lua",
        "https://gist.githubusercontent.com/SynchronizingFrames/ef4bce240bb0ac17a19186dc265b9234/raw/Build1.17TSBHub.obf.lua",
        "https://gist.githubusercontent.com/SynchronizingFrames/ef4bce240bb0ac17a19186dc265b9234/raw/Build1.17BetaTSBHub.obf.lua",
        "https://gist.githubusercontent.com/SynchronizingFrames/ef4bce240bb0ac17a19186dc265b9234/raw/Build1.16TSBHub.obf.lua",
      },
    },
  }

  local function f34(p52, layoutOrder)
    p52.LayoutOrder = layoutOrder
    p52.Parent = scrollingFrame

    v161.Hubs = v161.Hubs or {}

    table.insert(v161.Hubs, p52)
    table.insert(v163, p52)

    p52.Visible = v164 == "Hubs"
  end

  local hubsNote = Instance.new("Frame")
  hubsNote.Name = "HubsNote"
  hubsNote.Size = UDim2.new(1, 0, 0, 50)
  hubsNote.BackgroundColor3 = v117.Row
  hubsNote.BorderSizePixel = 0

  f27(hubsNote, 12)

  local textLabel6 = Instance.new("TextLabel")
  textLabel6.BackgroundTransparency = 1
  textLabel6.Position = UDim2.fromOffset(14, 0)
  textLabel6.Size = UDim2.new(1, -28, 1, 0)
  textLabel6.Font = Enum.Font.Gotham
  textLabel6.TextSize = 12
  textLabel6.Text = "Game-specific hubs by StatsX. Open the matching game, then press Load."
  textLabel6.TextColor3 = v117.SubText
  textLabel6.TextWrapped = true
  textLabel6.TextXAlignment = Enum.TextXAlignment.Left
  textLabel6.Parent = hubsNote

  f34(hubsNote, 1)

  for index8, value10 in ipairs(v166) do
    local frame16 = Instance.new("Frame")
    frame16.Name = value10.name
    frame16.Size = UDim2.new(1, 0, 0, 64)
    frame16.BackgroundColor3 = v117.Row
    frame16.BorderSizePixel = 0

    f27(frame16, 12)
    f28(frame16, color2, 1.2, 0.55)

    local textLabel7 = Instance.new("TextLabel")
    textLabel7.BackgroundTransparency = 1
    textLabel7.Position = UDim2.fromOffset(14, 0)
    textLabel7.Size = UDim2.fromOffset(40, 64)
    textLabel7.Font = Enum.Font.GothamBold
    textLabel7.TextSize = 26
    textLabel7.Text = value10.icon
    textLabel7.TextColor3 = v117.Text
    textLabel7.Parent = frame16

    local textLabel8 = Instance.new("TextLabel")
    textLabel8.BackgroundTransparency = 1
    textLabel8.Position = UDim2.fromOffset(60, 13)
    textLabel8.Size = UDim2.new(1, -180, 0, 20)
    textLabel8.Font = Enum.Font.GothamBold
    textLabel8.TextSize = 15
    textLabel8.Text = value10.name
    textLabel8.TextColor3 = v117.Text
    textLabel8.TextXAlignment = Enum.TextXAlignment.Left
    textLabel8.Parent = frame16

    local textLabel9 = Instance.new("TextLabel")
    textLabel9.BackgroundTransparency = 1
    textLabel9.Position = UDim2.fromOffset(60, 33)
    textLabel9.Size = UDim2.new(1, -180, 0, 16)
    textLabel9.Font = Enum.Font.GothamMedium
    textLabel9.TextSize = 12
    textLabel9.Text = value10.by
    textLabel9.TextColor3 = v117.SubText
    textLabel9.TextXAlignment = Enum.TextXAlignment.Left
    textLabel9.Parent = frame16

    local textButton7 = Instance.new("TextButton")
    textButton7.AnchorPoint = Vector2.new(1, 0.5)
    textButton7.Position = UDim2.new(1, -14, 0.5, 0)
    textButton7.Size = UDim2.fromOffset(96, 34)
    textButton7.BackgroundColor3 = color2
    textButton7.AutoButtonColor = false
    textButton7.Font = Enum.Font.GothamBold
    textButton7.TextSize = 13
    textButton7.Text = "Load"
    textButton7.TextColor3 = Color3.fromRGB(22, 22, 30)
    textButton7.Parent = frame16

    f27(textButton7, 8)

    textButton7.MouseEnter:Connect(function()
      f26(textButton7, v118.Hover, { Size = UDim2.fromOffset(102, 36) })
    end)

    textButton7.MouseLeave:Connect(function()
      f26(textButton7, v118.Hover, { Size = UDim2.fromOffset(96, 34) })
    end)

    textButton7.MouseButton1Click:Connect(function()
      textButton7.Text = "..."
      local v167, v168 = false, "no url"

      for index9, value11 in ipairs(value10.urls or { value10.url }) do
        local v169, v170 = pcall(game.HttpGet, game, value11)

        if v169 and type(v170) == "string" and #v170 > 200 then
          local v171, v172 = loadstring(v170)

          if v171 then
            local v173, v174 = pcall(v171)

            if v173 then
              v167 = true
              break
            end

            v168 = tostring(v174)
          else
            v168 = tostring(v172)
          end
        else
          v168 = v169 and "empty or 404 body" or tostring(v170)
        end
      end

      textButton7.Text = v167 and "Loaded" or "Failed"

      if not v167 then
        warn("[StatsX] Hub load failed: " .. tostring(v168))
      end

      task.wait(1.5)
      textButton7.Text = "Load"
    end)

    f34(frame16, index8 + 1)
  end
end

f33()

local function f35(parent7, p53)
  local slider = Instance.new("Frame")
  slider.Name = "Slider"
  slider.Size = UDim2.new(1, 0, 0, 40)
  slider.BackgroundTransparency = 1
  slider.LayoutOrder = p53.order or 1
  slider.Parent = parent7

  local textLabel10 = Instance.new("TextLabel")
  textLabel10.BackgroundTransparency = 1
  textLabel10.Size = UDim2.new(1, -64, 0, 16)
  textLabel10.Font = Enum.Font.Gotham
  textLabel10.Text = p53.name
  textLabel10.TextColor3 = v117.SubText
  textLabel10.TextSize = 12
  textLabel10.TextXAlignment = Enum.TextXAlignment.Left
  textLabel10.Parent = slider

  local textLabel11 = Instance.new("TextLabel")
  textLabel11.BackgroundTransparency = 1
  textLabel11.AnchorPoint = Vector2.new(1, 0)
  textLabel11.Position = UDim2.new(1, 0, 0, 0)
  textLabel11.Size = UDim2.new(0, 64, 0, 16)
  textLabel11.Font = Enum.Font.GothamMedium
  textLabel11.TextColor3 = v117.Text
  textLabel11.TextSize = 12
  textLabel11.TextXAlignment = Enum.TextXAlignment.Right
  textLabel11.Parent = slider

  local frame17 = Instance.new("Frame")
  frame17.Position = UDim2.fromOffset(0, 24)
  frame17.Size = UDim2.new(1, 0, 0, 8)
  frame17.BackgroundColor3 = v117.TrackOff
  frame17.BorderSizePixel = 0
  frame17.Parent = slider

  f27(frame17, 4)

  local frame18 = Instance.new("Frame")
  frame18.Size = UDim2.new(0, 0, 1, 0)
  frame18.BackgroundColor3 = color2
  frame18.BorderSizePixel = 0
  frame18.Parent = frame17

  f27(frame18, 4)
  f30(frame18)

  local frame19 = Instance.new("Frame")
  frame19.AnchorPoint = Vector2.new(0.5, 0.5)
  frame19.Position = UDim2.new(0, 0, 0.5, 0)
  frame19.Size = UDim2.fromOffset(14, 14)
  frame19.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
  frame19.BorderSizePixel = 0
  frame19.ZIndex = 2
  frame19.Parent = frame17

  f27(frame19, 7)
  local decimals = p53.decimals or 0

  local function f36(p54)
    local v175 = 10 ^ decimals
    return math.floor(p54 * v175 + 0.5) / v175
  end

  local default = p53.default
  local v176 = false

  local function f37(p55)
    local v177 = math.clamp((p55 - p53.min) / (p53.max - p53.min), 0, 1)
    frame18.Size = UDim2.new(v177, 0, 1, 0)
    frame19.Position = UDim2.new(v177, 0, 0.5, 0)
    textLabel11.Text = tostring(f36(p55)) .. (p53.suffix or "")
  end

  local function f38(p56)
    local v178 = math.clamp((p56 - frame17.AbsolutePosition.X) / frame17.AbsoluteSize.X, 0, 1)
    default = f36(p53.min + (p53.max - p53.min) * v178)
    f37(default)

    if p53.onChange then
      p53.onChange(default)
    end
  end

  frame17.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
      or input.UserInputType == Enum.UserInputType.Touch then
      v176 = true
      f26(frame19, v118.Hover, { Size = UDim2.fromOffset(18, 18) })
      f38(input.Position.X)
    end
  end)

  frame17.InputEnded:Connect(function(input2)
    if input2.UserInputType == Enum.UserInputType.MouseButton1
      or input2.UserInputType == Enum.UserInputType.Touch then
      v176 = false
      f26(frame19, v118.Hover, { Size = UDim2.fromOffset(14, 14) })
    end
  end)

  userInputService.InputChanged:Connect(function(input3)
    if v176
      and (input3.UserInputType == Enum.UserInputType.MouseMovement
        or input3.UserInputType == Enum.UserInputType.Touch) then
      f38(input3.Position.X)
    end
  end)

  f37(default)
  return slider
end

local function f39(parent8, p57)
  local textButton8 = Instance.new("TextButton")
  textButton8.AutoButtonColor = false
  textButton8.Text = ""
  textButton8.Size = UDim2.new(1, 0, 0, 26)
  textButton8.BackgroundTransparency = 1
  textButton8.LayoutOrder = p57.order or 1
  textButton8.Parent = parent8

  local frame20 = Instance.new("Frame")
  frame20.Size = UDim2.fromOffset(18, 18)
  frame20.Position = UDim2.fromOffset(0, 4)
  frame20.BackgroundColor3 = v117.TrackOff
  frame20.BorderSizePixel = 0
  frame20.Parent = textButton8

  f27(frame20, 5)

  local frame21 = Instance.new("Frame")
  frame21.AnchorPoint = Vector2.new(0.5, 0.5)
  frame21.Position = UDim2.new(0.5, 0, 0.5, 0)
  frame21.Size = UDim2.fromOffset(0, 0)
  frame21.BackgroundColor3 = color2
  frame21.BorderSizePixel = 0
  frame21.Parent = frame20

  f27(frame21, 3)
  f30(frame21)

  local textLabel12 = Instance.new("TextLabel")
  textLabel12.BackgroundTransparency = 1
  textLabel12.Position = UDim2.fromOffset(28, 0)
  textLabel12.Size = UDim2.new(1, -28, 1, 0)
  textLabel12.Font = Enum.Font.Gotham
  textLabel12.Text = p57.name
  textLabel12.TextColor3 = v117.SubText
  textLabel12.TextSize = 12
  textLabel12.TextXAlignment = Enum.TextXAlignment.Left
  textLabel12.Parent = textButton8

  local default2 = p57.default or false

  local function f40()
    f26(frame21, v118.Snappy, {
      Size = default2 and UDim2.fromOffset(11, 11) or UDim2.fromOffset(0, 0),
    })
  end

  textButton8.MouseButton1Click:Connect(function()
    default2 = not default2
    f40()

    if p57.onChange then
      p57.onChange(default2)
    end
  end)

  f40()
  return textButton8
end

local function f41(parent9, p58)
  local textButton9 = Instance.new("TextButton")
  textButton9.AutoButtonColor = false
  textButton9.Size = UDim2.new(1, 0, 0, 30)
  textButton9.BackgroundColor3 = v117.Row
  textButton9.Text = p58.name
  textButton9.Font = Enum.Font.GothamMedium
  textButton9.TextSize = 13
  textButton9.TextColor3 = v117.Text
  textButton9.LayoutOrder = p58.order or 1
  textButton9.Parent = parent9

  f27(textButton9, 8)
  f28(textButton9, v117.Stroke, 1, 0.3)

  textButton9.MouseEnter:Connect(function()
    f26(textButton9, v118.Hover, { BackgroundColor3 = v117.RowHover })
  end)

  textButton9.MouseLeave:Connect(function()
    f26(textButton9, v118.Hover, { BackgroundColor3 = v117.Row })
  end)

  textButton9.MouseButton1Click:Connect(function()
    if p58.onClick then
      p58.onClick()
    end
  end)

  return textButton9
end

local v179 = false

local function f42(p59)
  if not p59 then
    return "None"
  end

  return (tostring(p59):gsub("Enum.KeyCode.", ""))
end

local function f43(parent10, p60)
  local textButton10 = Instance.new("TextButton")
  textButton10.AutoButtonColor = false
  textButton10.Text = ""
  textButton10.Size = UDim2.new(1, 0, 0, 30)
  textButton10.BackgroundTransparency = 1
  textButton10.LayoutOrder = p60.order or 1
  textButton10.Parent = parent10

  local textLabel13 = Instance.new("TextLabel")
  textLabel13.BackgroundTransparency = 1
  textLabel13.Size = UDim2.new(1, -150, 1, 0)
  textLabel13.Font = Enum.Font.Gotham
  textLabel13.Text = p60.name
  textLabel13.TextColor3 = v117.SubText
  textLabel13.TextSize = 12
  textLabel13.TextXAlignment = Enum.TextXAlignment.Left
  textLabel13.Parent = textButton10

  local default3 = p60.default

  local textButton11 = Instance.new("TextButton")
  textButton11.AnchorPoint = Vector2.new(1, 0.5)
  textButton11.Position = UDim2.new(1, 0, 0.5, 0)
  textButton11.Size = UDim2.fromOffset(72, 26)
  textButton11.BackgroundColor3 = v117.TrackOff
  textButton11.AutoButtonColor = false
  textButton11.Font = Enum.Font.GothamBold
  textButton11.TextSize = 13
  textButton11.TextColor3 = default3 and v117.Text or v117.SubText
  textButton11.Text = f42(default3)
  textButton11.Parent = textButton10

  f27(textButton11, 7)
  local v180 = f28(textButton11, color2, 1.2, 1)

  local textButton12 = Instance.new("TextButton")
  textButton12.AnchorPoint = Vector2.new(1, 0.5)
  textButton12.Position = UDim2.new(1, -82, 0.5, 0)
  textButton12.Size = UDim2.fromOffset(24, 24)
  textButton12.BackgroundColor3 = v117.TrackOff
  textButton12.AutoButtonColor = false
  textButton12.Font = Enum.Font.GothamBold
  textButton12.TextSize = 14
  textButton12.TextColor3 = v117.SubText
  textButton12.Text = "x"
  textButton12.Parent = textButton10

  f27(textButton12, 7)

  local function f44(p61)
    default3 = p61

    textButton11.Text = f42(default3)
    textButton11.TextColor3 = default3 and v117.Text or v117.SubText

    if p60.onChange then
      p60.onChange(default3)
    end
  end

  textButton12.MouseEnter:Connect(function()
    f26(textButton12, v118.Hover, { BackgroundColor3 = Color3.fromRGB(220, 70, 80) })
  end)

  textButton12.MouseLeave:Connect(function()
    f26(textButton12, v118.Hover, { BackgroundColor3 = v117.TrackOff })
  end)

  textButton12.MouseButton1Click:Connect(function()
    f44(nil)
    f26(v180, v118.Snappy, { Transparency = 1 })
  end)

  textButton11.MouseButton1Click:Connect(function()
    textButton11.Text = "..."
    v179 = true
    f26(v180, v118.Snappy, { Transparency = 0 })

    local connect2

    connect2 = userInputService.InputBegan:Connect(function(input4)
      if input4.UserInputType ~= Enum.UserInputType.Keyboard then
        return
      end

      local keyCode = input4.KeyCode

      if keyCode == Enum.KeyCode.Escape then
        textButton11.Text = f42(default3)
      elseif keyCode == Enum.KeyCode.Backspace or keyCode == Enum.KeyCode.Delete then
        f44(nil)
      else
        f44(keyCode)
      end

      f26(v180, v118.Snappy, { Transparency = 1 })
      v179 = false
      connect2:Disconnect()
    end)
  end)

  return textButton10
end

local function f45(parent11, p62)
  local segmented = Instance.new("Frame")
  segmented.Name = "Segmented"
  segmented.Size = UDim2.new(1, 0, 0, 48)
  segmented.BackgroundTransparency = 1
  segmented.LayoutOrder = p62.order or 1
  segmented.Parent = parent11

  local textLabel14 = Instance.new("TextLabel")
  textLabel14.BackgroundTransparency = 1
  textLabel14.Size = UDim2.new(1, 0, 0, 16)
  textLabel14.Font = Enum.Font.Gotham
  textLabel14.Text = p62.name
  textLabel14.TextColor3 = v117.SubText
  textLabel14.TextSize = 12
  textLabel14.TextXAlignment = Enum.TextXAlignment.Left
  textLabel14.Parent = segmented

  local frame22 = Instance.new("Frame")
  frame22.Position = UDim2.fromOffset(0, 20)
  frame22.Size = UDim2.new(1, 0, 0, 26)
  frame22.BackgroundColor3 = v117.TrackOff
  frame22.BorderSizePixel = 0
  frame22.Parent = segmented

  f27(frame22, 8)

  local uiPadding4 = Instance.new("UIPadding")
  uiPadding4.PaddingLeft = UDim.new(0, 3)
  uiPadding4.PaddingRight = UDim.new(0, 3)
  uiPadding4.PaddingTop = UDim.new(0, 3)
  uiPadding4.PaddingBottom = UDim.new(0, 3)
  uiPadding4.Parent = frame22

  local uiListLayout3 = Instance.new("UIListLayout")
  uiListLayout3.FillDirection = Enum.FillDirection.Horizontal
  uiListLayout3.Padding = UDim.new(0, 3)
  uiListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
  uiListLayout3.Parent = frame22

  local v181 = {}
  local default4 = p62.default

  local function f46()
    for key4, value12 in pairs(v181) do
      local v182 = key4 == default4
      f26(value12, v118.Hover, { BackgroundColor3 = v182 and color2 or v117.Row })
      value12.TextColor3 = v182 and Color3.fromRGB(22, 22, 30) or v117.SubText

      if v182 then
        v120[value12] = true
      else
        v120[value12] = nil
      end
    end
  end

  for index10, value13 in ipairs(p62.options) do
    local textButton13 = Instance.new("TextButton")
    textButton13.Size = UDim2.new(1 / #p62.options, -3, 1, 0)
    textButton13.BackgroundColor3 = v117.Row
    textButton13.Text = value13
    textButton13.Font = Enum.Font.GothamMedium
    textButton13.TextSize = 12
    textButton13.TextColor3 = v117.SubText
    textButton13.AutoButtonColor = false
    textButton13.LayoutOrder = index10
    textButton13.Parent = frame22

    f27(textButton13, 6)
    v181[value13] = textButton13

    textButton13.MouseButton1Click:Connect(function()
      default4 = value13
      f46()

      if p62.onChange then
        p62.onChange(value13)
      end
    end)
  end

  f46()
  return segmented
end

local function f47(p63)
  local frame23 = Instance.new("Frame")
  frame23.Name = p63.key
  frame23.Size = UDim2.new(1, 0, 0, 56)
  frame23.BackgroundColor3 = v117.Row
  frame23.BorderSizePixel = 0
  frame23.ClipsDescendants = true
  frame23.LayoutOrder = p63.order
  frame23.Parent = scrollingFrame

  f27(frame23, 12)
  local v183 = v160[p63.key] or "Player"
  v161[v183] = v161[v183] or {}

  table.insert(v161[v183], frame23)
  table.insert(v163, frame23)

  local v184 = f28(frame23, color2, 1.2, 1)

  local textButton14 = Instance.new("TextButton")
  textButton14.AutoButtonColor = false
  textButton14.Text = ""
  textButton14.BackgroundTransparency = 1
  textButton14.Size = UDim2.new(1, 0, 0, 56)
  textButton14.Parent = frame23

  local textLabel15 = Instance.new("TextLabel")
  textLabel15.BackgroundTransparency = 1
  textLabel15.Position = UDim2.fromOffset(16, 10)
  textLabel15.Size = UDim2.new(1, -110, 0, 20)
  textLabel15.Font = Enum.Font.GothamMedium
  textLabel15.Text = p63.name
  textLabel15.TextColor3 = v117.Text
  textLabel15.TextSize = 14
  textLabel15.TextXAlignment = Enum.TextXAlignment.Left
  textLabel15.Parent = textButton14

  if p63.badge then
    local x = 0

    pcall(function()
      x = textService:GetTextSize(p63.name, 14, Enum.Font.GothamMedium, Vector2.new(400, 20)).X
    end)

    local textLabel16 = Instance.new("TextLabel")
    textLabel16.BackgroundColor3 = color2
    textLabel16.Position = UDim2.fromOffset(16 + x + 8, 11)
    textLabel16.Size = UDim2.fromOffset(38, 16)
    textLabel16.Font = Enum.Font.GothamBold
    textLabel16.Text = p63.badge
    textLabel16.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel16.TextSize = 9
    textLabel16.Parent = textButton14

    f27(textLabel16, 5)
    f30(textLabel16)
  end

  local textLabel17 = Instance.new("TextLabel")
  textLabel17.BackgroundTransparency = 1
  textLabel17.Position = UDim2.fromOffset(16, 30)
  textLabel17.Size = UDim2.new(1, -110, 0, 16)
  textLabel17.Font = Enum.Font.Gotham
  textLabel17.Text = p63.desc
  textLabel17.TextColor3 = v117.SubText
  textLabel17.TextSize = 11
  textLabel17.TextXAlignment = Enum.TextXAlignment.Left
  textLabel17.Parent = textButton14

  local frame24 = Instance.new("Frame")
  frame24.AnchorPoint = Vector2.new(1, 0.5)
  frame24.Position = UDim2.new(1, -16, 0, 28)
  frame24.Size = UDim2.fromOffset(50, 26)
  frame24.BackgroundColor3 = v117.TrackOff
  frame24.BorderSizePixel = 0
  frame24.ZIndex = 2
  frame24.Parent = frame23

  f27(frame24, 13)

  local frame25 = Instance.new("Frame")
  frame25.AnchorPoint = Vector2.new(0, 0.5)
  frame25.Position = UDim2.new(0, 3, 0.5, 0)
  frame25.Size = UDim2.fromOffset(20, 20)
  frame25.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
  frame25.BorderSizePixel = 0
  frame25.Parent = frame24

  f27(frame25, 10)
  local v185 = f28(frame25, color2, 0, 1)
  local textButton15
  local uiListLayout4

  if p63.buildConfig then
    textButton15 = Instance.new("TextButton")
    textButton15.AutoButtonColor = false
    textButton15.Text = ">"
    textButton15.Font = Enum.Font.GothamBold
    textButton15.TextSize = 16
    textButton15.TextColor3 = v117.SubText
    textButton15.BackgroundTransparency = 1
    textButton15.AnchorPoint = Vector2.new(1, 0.5)
    textButton15.Position = UDim2.new(1, -74, 0, 28)
    textButton15.Size = UDim2.fromOffset(24, 24)
    textButton15.ZIndex = 3
    textButton15.Parent = frame23

    local config = Instance.new("Frame")
    config.Name = "Config"
    config.BackgroundTransparency = 1
    config.Position = UDim2.fromOffset(0, 58)
    config.Size = UDim2.new(1, 0, 0, 300)
    config.Parent = frame23

    local uiPadding5 = Instance.new("UIPadding")
    uiPadding5.PaddingLeft = UDim.new(0, 16)
    uiPadding5.PaddingRight = UDim.new(0, 16)
    uiPadding5.PaddingTop = UDim.new(0, 2)
    uiPadding5.PaddingBottom = UDim.new(0, 12)
    uiPadding5.Parent = config

    uiListLayout4 = Instance.new("UIListLayout")
    uiListLayout4.Padding = UDim.new(0, 6)
    uiListLayout4.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout4.Parent = config

    p63.buildConfig(config)
  end

  local v186 = false

  local function f48(p64)
    f26(frame24, v118.Snappy, { BackgroundColor3 = p64 and color2 or v117.TrackOff })

    f26(frame25, v118.Knob, {
      Position = p64 and UDim2.new(1, -23, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
    })

    f26(frame23, v118.Snappy, { BackgroundColor3 = p64 and v117.RowActive or v117.Row })
    f26(v184, v118.Snappy, { Transparency = p64 and 0.35 or 1 })
    f26(v185, v118.Snappy, { Transparency = p64 and 0.1 or 1, Thickness = p64 and 2.5 or 0 })

    if p64 then
      v120[frame24] = true
      v120[v184] = true
      v120[v185] = true
    else
      v120[frame24] = nil
      v120[v184] = nil
      v120[v185] = nil
    end
  end

  local function f49(p65)
    if p65 == v186 then
      return
    end

    v186 = p65
    f48(p65)

    local v187, v188 = pcall(function()
      if p65 then
        if p63.onEnable then
          p63.onEnable()
        end
      elseif p63.onDisable then
        p63.onDisable()
      end
    end)

    if not v187 then
      warn("[StatsX] " .. p63.name .. " error: " .. tostring(v188))
    end
  end

  textButton14.MouseButton1Click:Connect(function() f49(not v186) end)

  textButton14.MouseEnter:Connect(function()
    if not v186 then
      f26(frame23, v118.Hover, { BackgroundColor3 = v117.RowHover })
      f26(v184, v118.Hover, { Transparency = 0.6 })
    end
  end)

  textButton14.MouseLeave:Connect(function()
    if not v186 then
      f26(frame23, v118.Hover, { BackgroundColor3 = v117.Row })
      f26(v184, v118.Hover, { Transparency = 1 })
    end
  end)

  if textButton15 then
    local v189 = false

    textButton15.MouseButton1Click:Connect(function()
      v189 = not v189
      local v190 = v189 and uiListLayout4.AbsoluteContentSize.Y + 16 or 0

      f26(frame23, v118.Smooth, { Size = UDim2.new(1, 0, 0, 56 + v190) })

      f26(textButton15, v118.Smooth, {
        Rotation = v189 and 90 or 0,
        TextColor3 = v189 and color2 or v117.SubText,
      })
    end)

    textButton15.MouseEnter:Connect(function()
      f26(textButton15, v118.Hover, { TextColor3 = v117.Text })
    end)

    textButton15.MouseLeave:Connect(function()
      f26(textButton15, v118.Hover, { TextColor3 = v189 and color2 or v117.SubText })
    end)
  end

  v142[p63.key] = {
    set = f49,
    get = function() return v186 end,
    color = p63.color or color2,
    short = p63.short or string.sub(p63.name, 1, 2),
    name = p63.name,
    key = p63.key,
  }

  return f49
end

local function f50()
  for key5 in pairs(v120) do
    if key5 and key5.Parent then
      if key5:IsA("UIStroke") then
        key5.Color = color2
      else
        key5.BackgroundColor3 = color2
      end
    end
  end

  scrollingFrame.ScrollBarImageColor3 = color2

  if v123 then
    for key6, value14 in pairs(v129) do
      if value14.hl then
        value14.hl.FillColor = color2
      end

      if value14.boxStroke then
        value14.boxStroke.Color = color2
      end
    end
  end
end

local function f51()
  local character = localPlayer.Character
  return character and character:FindFirstChildOfClass("Humanoid")
end

local v191, connect3
local v192, f52

local function f53()
  local function f54()
    lighting.Brightness = v122
    lighting.ClockTime = 14
    lighting.FogEnd = 1000000000
    lighting.GlobalShadows = false
    lighting.Ambient = Color3.fromRGB(178, 178, 178)
    lighting.OutdoorAmbient = Color3.fromRGB(178, 178, 178)
  end

  local function f55(p66)
    local head = p66:FindFirstChild("Head")

    if not head then
      return
    end

    local getPlayerFromCharacter = players:GetPlayerFromCharacter(p66)

    local statsXTag = Instance.new("BillboardGui")
    statsXTag.Name = "StatsXTag"
    statsXTag.Size = UDim2.fromOffset(170, 48)
    statsXTag.StudsOffset = Vector3.new(0, 3, 0)
    statsXTag.AlwaysOnTop = true
    statsXTag.Adornee = head
    statsXTag.Parent = head

    local textLabel18 = Instance.new("TextLabel")
    textLabel18.BackgroundTransparency = 1
    textLabel18.Size = UDim2.new(1, 0, 0, 16)
    textLabel18.Font = Enum.Font.GothamBold
    textLabel18.TextSize = 14
    textLabel18.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel18.TextStrokeTransparency = 0.4

    textLabel18.Text = getPlayerFromCharacter
        and (getPlayerFromCharacter.DisplayName or getPlayerFromCharacter.Name)
      or "?"

    textLabel18.Parent = statsXTag

    local textLabel19 = Instance.new("TextLabel")
    textLabel19.BackgroundTransparency = 1
    textLabel19.Position = UDim2.fromOffset(0, 16)
    textLabel19.Size = UDim2.new(1, 0, 0, 12)
    textLabel19.Font = Enum.Font.Gotham
    textLabel19.TextSize = 11
    textLabel19.TextColor3 = Color3.fromRGB(205, 205, 218)
    textLabel19.TextStrokeTransparency = 0.5
    textLabel19.Text = ""
    textLabel19.Parent = statsXTag

    local frame26 = Instance.new("Frame")
    frame26.AnchorPoint = Vector2.new(0.5, 0)
    frame26.Position = UDim2.new(0.5, 0, 0, 33)
    frame26.Size = UDim2.fromOffset(74, 5)
    frame26.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
    frame26.BorderSizePixel = 0
    frame26.Parent = statsXTag

    f27(frame26, 3)

    local frame27 = Instance.new("Frame")
    frame27.Size = UDim2.fromScale(1, 1)
    frame27.BackgroundColor3 = Color3.fromRGB(80, 220, 120)
    frame27.BorderSizePixel = 0
    frame27.Parent = frame26

    f27(frame27, 3)
    return statsXTag, textLabel18, textLabel19, frame26, frame27
  end

  local function f56(p67)
    local humanoidRootPart = p67:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart then
      return
    end

    local statsXBox = Instance.new("BillboardGui")
    statsXBox.Name = "StatsXBox"
    statsXBox.Adornee = humanoidRootPart
    statsXBox.Size = UDim2.fromScale(4, 6)
    statsXBox.AlwaysOnTop = true
    statsXBox.LightInfluence = 0
    statsXBox.Parent = humanoidRootPart

    local frame28 = Instance.new("Frame")
    frame28.BackgroundTransparency = 1
    frame28.Size = UDim2.fromScale(1, 1)
    frame28.Parent = statsXBox

    local uiStroke3 = Instance.new("UIStroke")
    uiStroke3.Thickness = 2
    uiStroke3.Color = color2
    uiStroke3.Parent = frame28

    return statsXBox, uiStroke3
  end

  local function f57(p68)
    if p68.nameLbl then
      p68.nameLbl.Visible = v124
    end

    if p68.distLbl then
      p68.distLbl.Visible = v127
    end

    if p68.healthBg then
      p68.healthBg.Visible = v128
    end

    if p68.tag then
      p68.tag.Enabled = v124 or v127 or v128
    end

    if p68.box then
      p68.box.Enabled = v126
    end
  end

  local function f58(p69)
    if not p69 or v129[p69] then
      return
    end

    local v193 = {}

    local statsXESP = Instance.new("Highlight")
    statsXESP.Name = "StatsXESP"
    statsXESP.FillColor = color2
    statsXESP.OutlineColor = Color3.fromRGB(255, 255, 255)
    statsXESP.FillTransparency = v125
    statsXESP.OutlineTransparency = 0
    statsXESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    statsXESP.Parent = p69

    v193.hl = statsXESP
    v193.tag, v193.nameLbl, v193.distLbl, v193.healthBg, v193.healthFill = f55(p69)
    v193.box, v193.boxStroke = f56(p69)

    v129[p69] = v193
    f57(v193)
  end

  local function f59()
    if not v123 then
      return
    end

    for key7, value15 in pairs(v129) do
      if value15.hl then
        value15.hl.FillTransparency = v125
      end

      f57(value15)
    end
  end

  runService.Heartbeat:Connect(function()
    if v119 or not v123 then
      return
    end

    local currentCamera2 = workspaceService.CurrentCamera
    local position2 = currentCamera2 and currentCamera2.CFrame.Position

    for key8, value16 in pairs(v129) do
      local humanoid = key8:FindFirstChildOfClass("Humanoid")
      local humanoidRootPart2 = key8:FindFirstChild("HumanoidRootPart")

      if v128 and value16.healthFill and humanoid then
        local v194 = math.clamp(humanoid.Health / math.max(humanoid.MaxHealth, 1), 0, 1)
        value16.healthFill.Size = UDim2.fromScale(v194, 1)

        value16.healthFill.BackgroundColor3 = Color3.fromRGB(
          math.floor(225 * (1 - v194)) + 30, math.floor(190 * v194) + 50, 90
        )
      end

      if v127 and value16.distLbl and position2 and humanoidRootPart2 then
        local v195 = math.floor((humanoidRootPart2.Position - position2).Magnitude + 0.5)
        value16.distLbl.Text = "[" .. v195 .. "m]"
      end
    end
  end)

  local function f60()
    local v196 = f51()

    if v196 then
      v196.WalkSpeed = 16
    end
  end

  local function f61()
    local v197 = f51()

    if v197 then
      if v197.UseJumpPower then
        v197.JumpPower = 50
      else
        v197.JumpHeight = 7.2
      end
    end
  end

  local function f62()
    local currentCamera3 = workspaceService.CurrentCamera

    if currentCamera3 then
      currentCamera3.FieldOfView = 70
    end
  end

  local v198, v199 = false, 60
  local v200, v201 = true, 0.5

  local function f63(parent12)
    local v202 = {}

    local statsXFly0 = Instance.new("Attachment")
    statsXFly0.Name = "StatsXFly0"
    statsXFly0.Position = Vector3.new(0, 1.6, 0)
    statsXFly0.Parent = parent12

    local statsXFly1 = Instance.new("Attachment")
    statsXFly1.Name = "StatsXFly1"
    statsXFly1.Position = Vector3.new(0, -1.6, 0)
    statsXFly1.Parent = parent12

    local trail = Instance.new("Trail")
    trail.Attachment0 = statsXFly0
    trail.Attachment1 = statsXFly1
    trail.Lifetime = v201
    trail.MinLength = 0.05
    trail.LightEmission = 1
    trail.LightInfluence = 0
    trail.FaceCamera = true
    trail.Color = ColorSequence.new(color2, Color3.fromRGB(150, 190, 255))

    trail.Transparency = NumberSequence.new({
      NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 1),
    })

    trail.WidthScale = NumberSequence.new({
      NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0),
    })

    trail.Enabled = false
    trail.Parent = parent12

    local particleEmitter = Instance.new("ParticleEmitter")
    particleEmitter.Color = ColorSequence.new(color2)
    particleEmitter.LightEmission = 1

    particleEmitter.Size = NumberSequence.new({
      NumberSequenceKeypoint.new(0, 0.9), NumberSequenceKeypoint.new(1, 0),
    })

    particleEmitter.Transparency = NumberSequence.new({
      NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 1),
    })

    particleEmitter.Lifetime = NumberRange.new(0.25, 0.45)
    particleEmitter.Speed = NumberRange.new(6, 12)
    particleEmitter.SpreadAngle = Vector2.new(18, 18)
    particleEmitter.Rate = 0
    particleEmitter.Parent = statsXFly1

    local pointLight = Instance.new("PointLight")
    pointLight.Color = color2
    pointLight.Range = 14
    pointLight.Brightness = 0
    pointLight.Parent = parent12

    v202.a0, v202.a1, v202.trail, v202.thrust, v202.glow = statsXFly0, statsXFly1, trail, particleEmitter, pointLight
    return v202
  end

  local connect4 = nil
  local gravity = workspaceService.Gravity
  local v203, gravity2 = false, workspaceService.Gravity
  local v204 = false
  local v205 = {}

  StatsXVis = {
    mode = "Local",
    render = nil,
    phys = nil,
    joints = {},
  }

  function StatsXVis.ghost()
    local character2 = localPlayer.Character

    if not character2 then
      return
    end

    local humanoidRootPart3 = character2:FindFirstChild("HumanoidRootPart")

    for index11, value17 in ipairs(character2:GetDescendants()) do
      if value17:IsA("Motor6D") or value17:IsA("Weld") or value17:IsA("WeldConstraint") then
        if StatsXVis.joints[value17] == nil then
          StatsXVis.joints[value17] = value17.Enabled
        end

        value17.Enabled = false
      end
    end

    for index12, value18 in ipairs(character2:GetDescendants()) do
      if value18:IsA("BasePart") and value18 ~= humanoidRootPart3 then
        value18.CanCollide = false
        value18.Massless = true
        value18.CFrame = CFrame.new(0, -900, 0)
        value18.AssemblyLinearVelocity = Vector3.zero
      end
    end
  end

  local function f64()
    v204 = true
    v205 = {}
    StatsXVis.joints = {}

    if StatsXVis.render then
      StatsXVis.render:Disconnect()
    end

    StatsXVis.render = runService.RenderStepped:Connect(function()
      if not v204 or v119 then
        return
      end
    end)

    if StatsXVis.phys then
      StatsXVis.phys:Disconnect()
      StatsXVis.phys = nil
    end

    if StatsXVis.mode == "Server" then
      StatsXVis.phys = runService.Heartbeat:Connect(function()
        if not v204 or v119 then
          return
        end
      end)
    end

    pcall(function()
      starterGui:SetCore("SendNotification", {
        Title = "StatsX",
        Text = StatsXVis.mode == "Server" and "Server ghost on. Respawn to restore your body."
          or "Hidden from your own camera only.",
        Duration = 5,
      })
    end)
  end

  local function f65()
    v204 = false

    if StatsXVis.render then
      StatsXVis.render:Disconnect()
      StatsXVis.render = nil
    end

    if StatsXVis.phys then
      StatsXVis.phys:Disconnect()
      StatsXVis.phys = nil
    end

    local character3 = localPlayer.Character

    if character3 then
      for index13, value19 in ipairs(character3:GetDescendants()) do
        if value19:IsA("BasePart") then
          pcall(function() value19.LocalTransparencyModifier = 0 end)
        end
      end
    end

    for key9, value20 in pairs(StatsXVis.joints) do
      if key9 and key9.Parent then
        pcall(function() key9.Enabled = value20 end)
      end
    end

    StatsXVis.joints = {}

    for key10, value21 in pairs(v205) do
      if key10 and key10.Parent then
        pcall(function()
          if typeof(value21) == "boolean" then
            key10.Enabled = value21
          else
            key10.Transparency = value21
          end
        end)
      end
    end

    v205 = {}
  end

  localPlayer.CharacterAdded:Connect(function()
    if v119 then
      return
    end

    if v204 then
      task.wait(0.6)
      v205 = {}
      StatsXVis.joints = {}
    end
  end)

  local v206 = "Head"
  local v207 = 0.65
  local v208 = 1000
  local v209 = 250
  local v210 = true
  local v211 = false
  local v212 = true
  local v213 = nil
  StatsXAim = { toggleMode = false, toggled = false }

  local v214 = {
    Head = { "Head" },
    Torso = { "UpperTorso", "Torso", "HumanoidRootPart" },
    Leg = {
      "LeftUpperLeg", "RightUpperLeg", "LeftLowerLeg", "Left Leg", "Right Leg", "LeftFoot",
      "RightFoot",
    },
  }

  local function f66(p70)
    for index14, value22 in ipairs(v214[v206] or v214.Head) do
      local findFirstChild = p70:FindFirstChild(value22)

      if findFirstChild then
        return findFirstChild
      end
    end

    return p70:FindFirstChild("HumanoidRootPart") or p70.PrimaryPart
  end

  local function f67(p71, p72)
    if not v211 then
      return true
    end

    local currentCamera4 = workspaceService.CurrentCamera

    if not currentCamera4 then
      return true
    end

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = { localPlayer.Character, currentCamera4 }

    local position3 = currentCamera4.CFrame.Position
    local raycast = workspaceService:Raycast(position3, p71.Position - position3, raycastParams)

    if not raycast then
      return true
    end

    return raycast.Instance:IsDescendantOf(p72)
  end

  local function f68()
    local currentCamera5 = workspaceService.CurrentCamera

    if not currentCamera5 then
      return nil
    end

    local getMouseLocation = userInputService:GetMouseLocation()
    local v215, v216 = nil, v209
    local position4 = currentCamera5.CFrame.Position

    for index15, value23 in ipairs(players:GetPlayers()) do
      if value23 ~= localPlayer and value23.Character then
        local character4 = value23.Character
        local humanoid2 = character4:FindFirstChildOfClass("Humanoid")

        local team = v210 and value23.Team and localPlayer.Team
          and value23.Team == localPlayer.Team

        if humanoid2 and humanoid2.Health > 0 and not team then
          local v217 = f66(character4)

          if v217 and (v217.Position - position4).Magnitude <= v208 then
            local v218, v219 = currentCamera5:WorldToViewportPoint(v217.Position)

            if v219 then
              local magnitude = (Vector2.new(v218.X, v218.Y) - getMouseLocation).Magnitude

              if magnitude < v216 and f67(v217, character4) then
                v215, v216 = v217, magnitude
              end
            end
          end
        end
      end
    end

    return v215
  end

  local connect5

  userInputService.InputBegan:Connect(function(input5, p73)
    if v119 or p73 then
      return
    end

    if not StatsXAim.toggleMode or not connect5 then
      return
    end

    local v220

    if v213 then
      v220 = input5.KeyCode == v213
    else
      v220 = input5.UserInputType == Enum.UserInputType.MouseButton2
    end

    if v220 then
      StatsXAim.toggled = not StatsXAim.toggled
    end
  end)

  v192 = false

  function f52(p74)
    v192 = p74

    f26(main, v118.Smooth, { BackgroundTransparency = p74 and 0.35 or 0 })
    f26(v154, v118.Smooth, { Transparency = p74 and 0.1 or 0.25 })
    f26(tabBar, v118.Smooth, { BackgroundTransparency = p74 and 0.5 or 0 })

    for index16, value24 in ipairs(v163) do
      f26(value24, v118.Smooth, { BackgroundTransparency = p74 and 0.5 or 0 })
    end
  end

  local v221 = {}

  runService.RenderStepped:Connect(function()
    if v119 then
      return
    end

    local v222 = tick()
    v221[#v221 + 1] = v222

    while v221[1] and v221[1] < v222 - 1 do
      table.remove(v221, 1)
    end
  end)

  local function f69()
    if not v43 then
      return 0
    end

    local v223, v224 = pcall(function()
      return v43.Network.ServerStatsItem["Data Ping"]:GetValue()
    end)

    return v223 and math.floor(v224) or 0
  end

  runService.Heartbeat:Connect(function()
    if v119 then
      return
    end

    local v225 = "FPS: " .. #v221 .. "    Ping: " .. f69() .. " ms"

    if v131 then
      local character5 = localPlayer.Character
      local humanoidRootPart4 = character5 and character5:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart4 then
        local assemblyLinearVelocity = humanoidRootPart4.AssemblyLinearVelocity

        local magnitude2 = v132 and assemblyLinearVelocity.Magnitude
          or Vector3.new(assemblyLinearVelocity.X, 0, assemblyLinearVelocity.Z).Magnitude

        v225 = v225 .. "    Speed: " .. math.floor(magnitude2 + 0.5)
      end
    end

    textLabel5.Text = v225
    local v226 = f51()

    if v226 then
      if v133 then
        v226.WalkSpeed = v134
      end

      if v135 then
        if v226.UseJumpPower then
          v226.JumpPower = v136
        else
          v226.JumpHeight = v136 / 14
        end
      end
    end

    local currentCamera6 = workspaceService.CurrentCamera

    if currentCamera6 and v137 then
      currentCamera6.FieldOfView = v138
    end
  end)

  userInputService.JumpRequest:Connect(function()
    if v119 then
      return
    end

    if v139 then
      local v227 = f51()

      if v227 then
        v227:ChangeState(Enum.HumanoidStateType.Jumping)
      end
    end
  end)

  f47({
    key = "fullbright",
    name = "Fullbright",
    desc = "Removes darkness and fog",
    color = Color3.fromRGB(255, 214, 102),
    short = "FB",
    order = 1,
    onEnable = function()
      v121 = true

      v191 = {
        Brightness = lighting.Brightness,
        ClockTime = lighting.ClockTime,
        FogEnd = lighting.FogEnd,
        GlobalShadows = lighting.GlobalShadows,
        Ambient = lighting.Ambient,
        OutdoorAmbient = lighting.OutdoorAmbient,
      }

      f54()
    end,
    onDisable = function()
      v121 = false

      if v191 then
        lighting.Brightness = v191.Brightness
        lighting.ClockTime = v191.ClockTime
        lighting.FogEnd = v191.FogEnd
        lighting.GlobalShadows = v191.GlobalShadows
        lighting.Ambient = v191.Ambient
        lighting.OutdoorAmbient = v191.OutdoorAmbient
      end
    end,
    buildConfig = function(p75)
      f35(p75, {
        name = "Brightness",
        min = 0,
        max = 5,
        default = v122,
        decimals = 1,
        order = 1,
        onChange = function(p76)
          v122 = p76

          if v121 then
            f54()
          end
        end,
      })
    end,
  })

  f47({
    key = "esp",
    name = "Player ESP",
    desc = "Highlights other players",
    color = Color3.fromRGB(96, 165, 250),
    short = "ESP",
    order = 2,
    onEnable = function()
      v123 = true

      local function f70(p77)
        if p77 == localPlayer then
          return
        end

        v130[p77] = p77.CharacterAdded:Connect(function(character6)
          task.wait(0.2)

          if v123 then
            f58(character6)
          end
        end)

        if p77.Character then
          f58(p77.Character)
        end
      end

      for index17, value25 in ipairs(players:GetPlayers()) do
        f70(value25)
      end

      v130._added = players.PlayerAdded:Connect(f70)
    end,
    onDisable = function()
      v123 = false

      for key11, value26 in pairs(v130) do
        pcall(function() value26:Disconnect() end)
      end

      v130 = {}

      for key12, value27 in pairs(v129) do
        if value27.hl then
          value27.hl:Destroy()
        end

        if value27.tag then
          value27.tag:Destroy()
        end

        if value27.box then
          value27.box:Destroy()
        end
      end

      v129 = {}
    end,
    buildConfig = function(p78)
      f35(p78, {
        name = "Fill transparency",
        min = 0,
        max = 1,
        default = v125,
        decimals = 2,
        order = 1,
        onChange = function(p79)
          v125 = p79
          f59()
        end,
      })

      f39(p78, {
        name = "Show name tags",
        default = v124,
        order = 2,
        onChange = function(p80)
          v124 = p80
          f59()
        end,
      })

      f39(p78, {
        name = "Show boxes",
        default = v126,
        order = 3,
        onChange = function(p81)
          v126 = p81
          f59()
        end,
      })

      f39(p78, {
        name = "Show distance",
        default = v127,
        order = 4,
        onChange = function(p82)
          v127 = p82
          f59()
        end,
      })

      f39(p78, {
        name = "Show health bar",
        default = v128,
        order = 5,
        onChange = function(p83)
          v128 = p83
          f59()
        end,
      })
    end,
  })

  f47({
    key = "speed",
    name = "Speed Readout",
    desc = "Shows live speed in footer",
    color = Color3.fromRGB(248, 113, 113),
    short = "SPD",
    order = 3,
    onEnable = function() v131 = true end,
    onDisable = function() v131 = false end,
    buildConfig = function(p84)
      f39(p84, {
        name = "Include vertical velocity",
        default = v132,
        order = 1,
        onChange = function(p85) v132 = p85 end,
      })
    end,
  })

  f47({
    key = "walk",
    name = "WalkSpeed",
    desc = "Sets your walk speed",
    color = Color3.fromRGB(52, 211, 153),
    short = "WS",
    order = 4,
    onEnable = function() v133 = true end,
    onDisable = function()
      v133 = false
      f60()
    end,
    buildConfig = function(p86)
      f35(p86, {
        name = "Speed",
        min = 16,
        max = 250,
        default = v134,
        decimals = 0,
        order = 1,
        onChange = function(p87) v134 = p87 end,
      })
    end,
  })

  f47({
    key = "jump",
    name = "Jump Power",
    desc = "Sets your jump strength",
    color = Color3.fromRGB(167, 139, 250),
    short = "JP",
    order = 5,
    onEnable = function() v135 = true end,
    onDisable = function()
      v135 = false
      f61()
    end,
    buildConfig = function(p88)
      f35(p88, {
        name = "Power",
        min = 50,
        max = 400,
        default = v136,
        decimals = 0,
        order = 1,
        onChange = function(p89) v136 = p89 end,
      })
    end,
  })

  f47({
    key = "infjump",
    name = "Infinite Jump",
    desc = "Jump again in mid-air",
    color = Color3.fromRGB(56, 189, 248),
    short = "IJ",
    order = 6,
    onEnable = function() v139 = true end,
    onDisable = function() v139 = false end,
  })

  f47({
    key = "fov",
    name = "FOV Changer",
    desc = "Adjusts camera field of view",
    color = Color3.fromRGB(251, 146, 60),
    short = "FOV",
    order = 7,
    onEnable = function() v137 = true end,
    onDisable = function()
      v137 = false
      f62()
    end,
    buildConfig = function(p90)
      f35(p90, {
        name = "Field of view",
        min = 70,
        max = 120,
        default = v138,
        decimals = 0,
        order = 1,
        onChange = function(p91) v138 = p91 end,
      })
    end,
  })

  f47({
    key = "afk",
    name = "Anti-AFK",
    desc = "Prevents the idle kick",
    color = Color3.fromRGB(45, 212, 191),
    short = "AFK",
    order = 8,
    onEnable = function()
      if not v44 then
        return
      end

      connect3 = localPlayer.Idled:Connect(function()
        pcall(function()
          v44:CaptureController()
          v44:ClickButton2(Vector2.new())
        end)
      end)
    end,
    onDisable = function()
      if connect3 then
        connect3:Disconnect()
        connect3 = nil
      end
    end,
  })

  local v228, connect6, v229, v230, v231

  f47({
    key = "fly",
    name = "Fly",
    desc = "WASD to move, Space up / Shift down",
    color = Color3.fromRGB(125, 211, 252),
    short = "FLY",
    order = 9,
    onEnable = function()
      local character7 = localPlayer.Character
      local humanoidRootPart5 = character7 and character7:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart5 then
        return
      end

      v198 = true
      v230 = tick()
      local humanoid3 = character7:FindFirstChildOfClass("Humanoid")

      if humanoid3 then
        humanoid3.PlatformStand = true
        pcall(function() humanoid3.AutoRotate = false end)
      end

      local statsXFly = Instance.new("BodyVelocity")
      statsXFly.Name = "StatsXFly"
      statsXFly.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000)
      statsXFly.P = 90000
      statsXFly.Velocity = Vector3.zero
      statsXFly.Parent = humanoidRootPart5

      v228 = statsXFly

      local statsXFlyGyro = Instance.new("BodyGyro")
      statsXFlyGyro.Name = "StatsXFlyGyro"
      statsXFlyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000)
      statsXFlyGyro.P = 90000
      statsXFlyGyro.D = 800
      statsXFlyGyro.CFrame = humanoidRootPart5.CFrame
      statsXFlyGyro.Parent = humanoidRootPart5

      v231 = statsXFlyGyro
      v229 = f63(humanoidRootPart5)

      connect6 = runService.RenderStepped:Connect(function(delta)
        if not v198 or not statsXFly.Parent then
          return
        end

        local currentCamera7 = workspaceService.CurrentCamera

        if not currentCamera7 then
          return
        end

        local v232 = (userInputService:IsKeyDown(Enum.KeyCode.W) and 1 or 0)
          - (userInputService:IsKeyDown(Enum.KeyCode.S) and 1 or 0)

        local v233 = (userInputService:IsKeyDown(Enum.KeyCode.D) and 1 or 0)
          - (userInputService:IsKeyDown(Enum.KeyCode.A) and 1 or 0)

        local v234 = (userInputService:IsKeyDown(Enum.KeyCode.Space) and 1 or 0)
          - (userInputService:IsKeyDown(Enum.KeyCode.LeftShift) and 1 or 0)

        local zero = currentCamera7.CFrame.LookVector * v232
          + currentCamera7.CFrame.RightVector * v233 + Vector3.new(0, 1, 0) * v234

        if zero.Magnitude > 0 then
          zero = zero.Unit * v199
        else
          zero = Vector3.zero
        end

        statsXFly.Velocity = zero
        local parent13 = statsXFly.Parent
        local lookVector = currentCamera7.CFrame.LookVector
        local vector2 = Vector3.new(lookVector.X, 0, lookVector.Z)

        if vector2.Magnitude < 0.05 then
          vector2 = parent13.CFrame.LookVector
        end

        vector2 = vector2.Unit
        local v235 = tick() - (v230 or 0)
        local v236 = v232 ~= 0 or v233 ~= 0
        local v237

        if v236 then
          local v238 = math.rad(74)
          local v239 = math.rad(-24) * v233

          v237 = CFrame.lookAt(parent13.Position, parent13.Position + vector2)
            * CFrame.Angles(-v238, 0, v239)
        else
          local v240 = math.rad(4) * math.sin(v235 * 1.8)

          v237 = CFrame.lookAt(parent13.Position, parent13.Position + vector2)
            * CFrame.Angles(math.rad(-10), 0, v240)
        end

        if v231 then
          local v241 = math.clamp((delta or 0.016666666666667) * 12, 0, 1)
          v231.CFrame = v231.CFrame:Lerp(v237, v241)
        end

        if v229 then
          local v242 = zero.Magnitude > 1

          v229.trail.Enabled = v242 and v200
          v229.thrust.Rate = v242 and 60 or 0
          v229.glow.Brightness = v242 and 1.5 + 0.5 * math.sin(v235 * 10) or 0
        end
      end)
    end,
    onDisable = function()
      v198 = false

      if connect6 then
        connect6:Disconnect()
        connect6 = nil
      end

      if v228 then
        v228:Destroy()
        v228 = nil
      end

      if v231 then
        v231:Destroy()
        v231 = nil
      end

      if v229 then
        for key13, value28 in pairs(v229) do
          if typeof(value28) == "Instance" then
            value28:Destroy()
          end
        end

        v229 = nil
      end

      local v243 = f51()

      if v243 then
        v243.PlatformStand = false
        pcall(function() v243.AutoRotate = true end)
      end
    end,
    buildConfig = function(p92)
      f35(p92, {
        name = "Fly speed",
        min = 20,
        max = 250,
        default = v199,
        decimals = 0,
        order = 1,
        onChange = function(p93) v199 = p93 end,
      })

      f35(p92, {
        name = "Trail length",
        min = 0,
        max = 1.5,
        default = v201,
        decimals = 2,
        suffix = "s",
        order = 2,
        onChange = function(p94)
          v201 = p94

          if v229 and v229.trail then
            v229.trail.Lifetime = p94
          end
        end,
      })

      f39(p92, {
        name = "Glowing trail",
        default = v200,
        order = 3,
        onChange = function(p95)
          v200 = p95

          if v229 and v229.trail then
            v229.trail.Enabled = p95 and v198
          end
        end,
      })
    end,
  })

  f47({
    key = "noclip",
    name = "Noclip",
    desc = "Walk through walls and floors",
    color = Color3.fromRGB(148, 163, 184),
    short = "NC",
    order = 10,
    onEnable = function()
      connect4 = runService.Stepped:Connect(function()
        local character8 = localPlayer.Character

        if not character8 then
          return
        end

        for index18, value29 in ipairs(character8:GetDescendants()) do
          if value29:IsA("BasePart") and value29.CanCollide then
            value29.CanCollide = false
          end
        end
      end)
    end,
    onDisable = function()
      if connect4 then
        connect4:Disconnect()
        connect4 = nil
      end
    end,
  })

  f47({
    key = "gravity",
    name = "Gravity Control",
    desc = "Adjust the world gravity",
    color = Color3.fromRGB(192, 132, 252),
    short = "GRV",
    order = 11,
    onEnable = function()
      v203 = true
      workspaceService.Gravity = gravity2
    end,
    onDisable = function()
      v203 = false
      workspaceService.Gravity = gravity
    end,
    buildConfig = function(p96)
      f35(p96, {
        name = "Gravity",
        min = 5,
        max = 196,
        default = gravity2,
        decimals = 0,
        order = 1,
        onChange = function(p97)
          gravity2 = p97

          if v203 then
            workspaceService.Gravity = p97
          end
        end,
      })
    end,
  })

  f47({
    key = "visibility",
    name = "Visibility",
    desc = "Hide your character -- pick the scope below",
    color = Color3.fromRGB(129, 140, 248),
    short = "INV",
    order = 12,
    onEnable = f64,
    onDisable = f65,
    buildConfig = function(p98)
      f45(p98, {
        name = "Hide from",
        options = { "Local", "Server" },
        default = StatsXVis.mode,
        order = 1,
        onChange = function(mode)
          StatsXVis.mode = mode

          if v204 then
            f65()
            f64()
          end
        end,
      })
    end,
  })

  local v244

  f47({
    key = "aimlock",
    name = "Aim Lock",
    desc = "Snap aim onto the nearest target",
    color = Color3.fromRGB(255, 99, 132),
    short = "AIM",
    order = 13,
    onEnable = function()
      if connect5 then
        connect5:Disconnect()
      end

      connect5 = runService.RenderStepped:Connect(function(delta2)
        local currentCamera8 = workspaceService.CurrentCamera

        if not currentCamera8 then
          return
        end

        local toggled

        if StatsXAim.toggleMode then
          toggled = StatsXAim.toggled
        elseif v212 and v213 then
          toggled = userInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
            or userInputService:IsKeyDown(v213)
        elseif v212 then
          toggled = userInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
        elseif v213 then
          toggled = userInputService:IsKeyDown(v213)
        else
          toggled = true
        end

        if not toggled then
          v244 = nil
          return
        end

        v244 = f68()

        if v244 and v244.Parent then
          local cframe = CFrame.new(currentCamera8.CFrame.Position, v244.Position)
          local v245 = math.clamp((1 - v207) * (delta2 * 60), 0.02, 1)
          currentCamera8.CFrame = currentCamera8.CFrame:Lerp(cframe, v245)
        end
      end)
    end,
    onDisable = function()
      if connect5 then
        connect5:Disconnect()
        connect5 = nil
      end

      v244 = nil
      StatsXAim.toggled = false
    end,
    buildConfig = function(p99)
      f45(p99, {
        name = "Target part",
        options = { "Head", "Torso", "Leg" },
        default = v206,
        order = 1,
        onChange = function(p100) v206 = p100 end,
      })

      f35(p99, {
        name = "Smoothness",
        min = 0,
        max = 1,
        default = v207,
        decimals = 2,
        order = 2,
        onChange = function(p101) v207 = p101 end,
      })

      f35(p99, {
        name = "Aim FOV",
        min = 30,
        max = 600,
        default = v209,
        decimals = 0,
        suffix = "px",
        order = 3,
        onChange = function(p102) v209 = p102 end,
      })

      f35(p99, {
        name = "Max distance",
        min = 50,
        max = 5000,
        default = v208,
        decimals = 0,
        order = 4,
        onChange = function(p103) v208 = p103 end,
      })

      f39(p99, {
        name = "Toggle mode (tap key, stays locked)",
        default = StatsXAim.toggleMode,
        order = 5,
        onChange = function(toggleMode)
          StatsXAim.toggleMode = toggleMode
          StatsXAim.toggled = false
        end,
      })

      f39(p99, {
        name = "Hold right mouse to aim",
        default = v212,
        order = 6,
        onChange = function(p104) v212 = p104 end,
      })

      f39(p99, {
        name = "Team check (skip teammates)",
        default = v210,
        order = 7,
        onChange = function(p105) v210 = p105 end,
      })

      f39(p99, {
        name = "Visible only (wall check)",
        default = v211,
        order = 8,
        onChange = function(p106) v211 = p106 end,
      })

      f43(p99, {
        name = "Aim key (hold, or tap in Toggle mode)",
        default = v213,
        order = 9,
        onChange = function(p107) v213 = p107 end,
      })
    end,
  })

  local v246 = false
  local v247 = 3
  local getMouse = localPlayer:GetMouse()

  local function f71(cframe2)
    local character9 = localPlayer.Character
    local humanoidRootPart6 = character9 and character9:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart6 then
      humanoidRootPart6.CFrame = cframe2
    end
  end

  local function f72(p108)
    local character10 = p108 and p108.Character
    local humanoidRootPart7 = character10 and character10:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart7 then
      f71(humanoidRootPart7.CFrame * CFrame.new(0, 0, 3))
    end
  end

  userInputService.InputBegan:Connect(function(input6, p109)
    if v119 or not v246 or p109 then
      return
    end

    if input6.UserInputType == Enum.UserInputType.MouseButton1
      or input6.UserInputType == Enum.UserInputType.Touch then
      if getMouse.Target then
        f71(CFrame.new(getMouse.Hit.Position + Vector3.new(0, v247, 0)))
      end
    end
  end)

  f47({
    key = "teleport",
    name = "Teleport",
    desc = "Click-to-teleport + go to players",
    color = Color3.fromRGB(96, 205, 255),
    short = "TP",
    order = 18,
    onEnable = function() v246 = true end,
    onDisable = function() v246 = false end,
    buildConfig = function(p110)
      f35(p110, {
        name = "Teleport height offset",
        min = 0,
        max = 12,
        default = v247,
        decimals = 1,
        order = 1,
        onChange = function(p111) v247 = p111 end,
      })

      local textLabel20 = Instance.new("TextLabel")
      textLabel20.BackgroundTransparency = 1
      textLabel20.Size = UDim2.new(1, 0, 0, 18)
      textLabel20.Font = Enum.Font.GothamMedium
      textLabel20.Text = "Teleport to player"
      textLabel20.TextColor3 = v117.SubText
      textLabel20.TextSize = 12
      textLabel20.TextXAlignment = Enum.TextXAlignment.Left
      textLabel20.LayoutOrder = 2
      textLabel20.Parent = p110

      local scrollingFrame2 = Instance.new("ScrollingFrame")
      scrollingFrame2.Size = UDim2.new(1, 0, 0, 116)
      scrollingFrame2.BackgroundTransparency = 1
      scrollingFrame2.BorderSizePixel = 0
      scrollingFrame2.ScrollBarThickness = 3
      scrollingFrame2.ScrollBarImageColor3 = color2
      scrollingFrame2.CanvasSize = UDim2.new()
      scrollingFrame2.AutomaticCanvasSize = Enum.AutomaticSize.Y
      scrollingFrame2.ScrollingDirection = Enum.ScrollingDirection.Y
      scrollingFrame2.LayoutOrder = 3
      scrollingFrame2.Parent = p110

      local uiListLayout5 = Instance.new("UIListLayout")
      uiListLayout5.Padding = UDim.new(0, 4)
      uiListLayout5.SortOrder = Enum.SortOrder.LayoutOrder
      uiListLayout5.Parent = scrollingFrame2

      local function f73()
        for index19, value30 in ipairs(scrollingFrame2:GetChildren()) do
          if value30:IsA("TextButton") or value30:IsA("TextLabel") then
            value30:Destroy()
          end
        end

        local count = 0

        for index20, value31 in ipairs(players:GetPlayers()) do
          if value31 ~= localPlayer then
            count = count + 1

            f41(scrollingFrame2, {
              name = value31.Name,
              order = count,
              onClick = function() f72(value31) end,
            })
          end
        end

        if count == 0 then
          local textLabel21 = Instance.new("TextLabel")
          textLabel21.BackgroundTransparency = 1
          textLabel21.Size = UDim2.new(1, 0, 0, 24)
          textLabel21.Font = Enum.Font.Gotham
          textLabel21.Text = "No other players"
          textLabel21.TextColor3 = v117.SubText
          textLabel21.TextSize = 12
          textLabel21.Parent = scrollingFrame2
        end
      end

      f73()

      players.PlayerAdded:Connect(function()
        if not v119 then
          task.defer(f73)
        end
      end)

      players.PlayerRemoving:Connect(function()
        if not v119 then
          task.defer(f73)
        end
      end)

      f41(p110, { name = "Refresh list", order = 4, onClick = f73 })
    end,
  })

  f47({
    key = "clean",
    name = "Transparent UI",
    desc = "Glassy, transparent interface",
    color = Color3.fromRGB(94, 234, 212),
    short = "UI",
    order = 17,
    onEnable = function() f52(true) end,
    onDisable = function() f52(false) end,
  })

  f47({
    key = "rainbow",
    name = "Rainbow UI",
    desc = "Cycles the accent color",
    color = Color3.fromRGB(244, 114, 182),
    short = "RGB",
    order = 16,
    onEnable = function()
      connect = runService.RenderStepped:Connect(function()
        local v248 = tick() * v140 % 1
        color2 = Color3.fromHSV(v248, v141, 1)
        f50()
      end)
    end,
    onDisable = function()
      if connect then
        connect:Disconnect()
        connect = nil
      end

      color2 = color
      f50()
    end,
    buildConfig = function(p112)
      f35(p112, {
        name = "Cycle speed",
        min = 0.05,
        max = 0.5,
        default = v140,
        decimals = 2,
        order = 1,
        onChange = function(p113) v140 = p113 end,
      })

      f35(p112, {
        name = "Saturation",
        min = 0.2,
        max = 1,
        default = v141,
        decimals = 2,
        order = 2,
        onChange = function(p114)
          v141 = p114

          if connect then
            f50()
          end
        end,
      })
    end,
  })
end

f53()

local arrowTab = Instance.new("TextButton")
arrowTab.Name = "ArrowTab"
arrowTab.AnchorPoint = Vector2.new(0.5, 1)
arrowTab.Position = UDim2.new(0.5, 0, 1, 50)
arrowTab.Size = UDim2.fromOffset(58, 28)
arrowTab.BackgroundColor3 = v117.Background
arrowTab.Text = "^"
arrowTab.TextColor3 = v117.Text
arrowTab.Font = Enum.Font.GothamBold
arrowTab.TextSize = 18
arrowTab.AutoButtonColor = false
arrowTab.Visible = false
arrowTab.Parent = statsX

f27(arrowTab, 12)
f30((f28(arrowTab, color2, 1.5, 0.2)))
local v249 = { "fullbright", "esp", "fly", "noclip", "walk", "fov", "visibility", "rainbow" }
local v250 = #v249
local v251 = 84 + (v250 * 42 + (v250 - 1) * 8) + 58 + 40

local dock = Instance.new("Frame")
dock.Name = "Dock"
dock.AnchorPoint = Vector2.new(0.5, 1)
dock.Position = UDim2.new(0.5, 0, 1, 140)
dock.Size = UDim2.fromOffset(v251, 62)
dock.BackgroundColor3 = v117.Background
dock.Visible = false
dock.Parent = statsX

f27(dock, 18)
f30((f28(dock, color2, 1.5, 0.25)))
f29(dock, v117.Background2, v117.Background, 90)

local textButton16 = Instance.new("TextButton")
textButton16.AnchorPoint = Vector2.new(0.5, 1)
textButton16.Position = UDim2.new(0.5, 0, 0, -6)
textButton16.Size = UDim2.fromOffset(36, 18)
textButton16.BackgroundTransparency = 1
textButton16.Text = "v"
textButton16.TextColor3 = v117.SubText
textButton16.Font = Enum.Font.GothamBold
textButton16.TextSize = 16
textButton16.AutoButtonColor = false
textButton16.Parent = dock

local textLabel22 = Instance.new("TextLabel")
textLabel22.BackgroundTransparency = 1
textLabel22.Position = UDim2.fromOffset(18, 0)
textLabel22.Size = UDim2.fromOffset(58, 62)
textLabel22.Font = Enum.Font.GothamBold
textLabel22.Text = os.date("%H:%M")
textLabel22.TextColor3 = v117.Text
textLabel22.TextSize = 18
textLabel22.TextXAlignment = Enum.TextXAlignment.Left
textLabel22.Parent = dock

local frame29 = Instance.new("Frame")
frame29.BackgroundTransparency = 1
frame29.AnchorPoint = Vector2.new(0.5, 0.5)
frame29.Position = UDim2.new(0.5, 12, 0.5, 0)
frame29.Size = UDim2.new(1, -150, 1, -16)
frame29.Parent = dock

local uiListLayout6 = Instance.new("UIListLayout")
uiListLayout6.FillDirection = Enum.FillDirection.Horizontal
uiListLayout6.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiListLayout6.VerticalAlignment = Enum.VerticalAlignment.Center
uiListLayout6.Padding = UDim.new(0, 8)
uiListLayout6.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout6.Parent = frame29

local function f74(parent14, p115, p116, p117, p118, p119)
  local frame30 = Instance.new("Frame")
  frame30.AnchorPoint = Vector2.new(0.5, 0.5)
  frame30.Position = UDim2.fromOffset(p117, p118)
  frame30.Size = UDim2.fromOffset(p115, p116)
  frame30.Rotation = p119 or 0
  frame30.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  frame30.BorderSizePixel = 0
  frame30.Parent = parent14

  return frame30
end

local function f75(parent15, p120, p121)
  local icon = Instance.new("Frame")
  icon.Name = "Icon"
  icon.AnchorPoint = Vector2.new(0.5, 0.5)
  icon.Position = UDim2.new(0.5, 0, 0.5, 0)
  icon.Size = UDim2.fromOffset(24, 24)
  icon.BackgroundTransparency = 1
  icon.Parent = parent15

  if p121 then
    local uiScale4 = Instance.new("UIScale")
    uiScale4.Scale = p121
    uiScale4.Parent = icon
  end

  if p120 == "sun" then
    f27(f74(icon, 10, 10, 12, 12), 5)

    for i6 = 0, 7 do
      local v252 = math.rad(i6 * 45)
      f27(f74(icon, 2.5, 5, 12 + math.sin(v252) * 10, 12 - math.cos(v252) * 10, i6 * 45), 1)
    end
  elseif p120 == "target" then
    local frame31 = Instance.new("Frame")
    frame31.AnchorPoint = Vector2.new(0.5, 0.5)
    frame31.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame31.Size = UDim2.fromOffset(22, 22)
    frame31.BackgroundTransparency = 1
    frame31.Parent = icon

    f27(frame31, 11)
    f28(frame31, Color3.fromRGB(255, 255, 255), 2, 0)
    f27(f74(icon, 6, 6, 12, 12), 3)

    f74(icon, 2, 5, 12, 1)
    f74(icon, 2, 5, 12, 23)
    f74(icon, 5, 2, 1, 12)
    f74(icon, 5, 2, 23, 12)
  elseif p120 == "speed" then
    for index21, value32 in ipairs({ 7, 14 }) do
      f27(f74(icon, 3, 11, value32, 8, 40), 2)
      f27(f74(icon, 3, 11, value32, 16, -40), 2)
    end
  elseif p120 == "eye" then
    local frame32 = Instance.new("Frame")
    frame32.AnchorPoint = Vector2.new(0.5, 0.5)
    frame32.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame32.Size = UDim2.fromOffset(24, 15)
    frame32.BackgroundTransparency = 1
    frame32.Parent = icon

    f27(frame32, 7)
    f28(frame32, Color3.fromRGB(255, 255, 255), 2, 0)
    f27(f74(icon, 7, 7, 12, 12), 4)
  elseif p120 == "rainbow" then
    local frame33 = Instance.new("Frame")
    frame33.AnchorPoint = Vector2.new(0.5, 0.5)
    frame33.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame33.Size = UDim2.fromOffset(22, 22)
    frame33.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    frame33.BorderSizePixel = 0
    frame33.Parent = icon

    f27(frame33, 11)

    local uiGradient4 = Instance.new("UIGradient")

    uiGradient4.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 90, 90)),
      ColorSequenceKeypoint.new(0.3, Color3.fromRGB(255, 215, 90)),
      ColorSequenceKeypoint.new(0.55, Color3.fromRGB(90, 230, 130)),
      ColorSequenceKeypoint.new(0.8, Color3.fromRGB(90, 170, 255)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(205, 120, 255)),
    })

    uiGradient4.Rotation = 45
    uiGradient4.Parent = frame33
  elseif p120 == "window" then
    local frame34 = Instance.new("Frame")
    frame34.AnchorPoint = Vector2.new(0.5, 0.5)
    frame34.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame34.Size = UDim2.fromOffset(22, 17)
    frame34.BackgroundTransparency = 1
    frame34.Parent = icon

    f27(frame34, 4)
    f28(frame34, Color3.fromRGB(255, 255, 255), 2, 0)
    f27(f74(icon, 22, 5, 12, 6), 2)
  elseif p120 == "fly" then
    f27(f74(icon, 3, 10, 8, 16, 45), 1)
    f27(f74(icon, 3, 10, 16, 16, -45), 1)
    f27(f74(icon, 3, 10, 8, 10, 45), 1)
    f27(f74(icon, 3, 10, 16, 10, -45), 1)
  elseif p120 == "phase" then
    local frame35 = Instance.new("Frame")
    frame35.AnchorPoint = Vector2.new(0.5, 0.5)
    frame35.Position = UDim2.fromOffset(9, 9)
    frame35.Size = UDim2.fromOffset(13, 13)
    frame35.BackgroundTransparency = 1
    frame35.Parent = icon

    f27(frame35, 3)
    f28(frame35, Color3.fromRGB(255, 255, 255), 2, 0)

    local frame36 = Instance.new("Frame")
    frame36.AnchorPoint = Vector2.new(0.5, 0.5)
    frame36.Position = UDim2.fromOffset(15, 15)
    frame36.Size = UDim2.fromOffset(13, 13)
    frame36.BackgroundColor3 = v117.Background
    frame36.BorderSizePixel = 0
    frame36.Parent = icon

    f27(frame36, 3)
    f28(frame36, Color3.fromRGB(255, 255, 255), 2, 0)
  elseif p120 == "eyeoff" then
    local frame37 = Instance.new("Frame")
    frame37.AnchorPoint = Vector2.new(0.5, 0.5)
    frame37.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame37.Size = UDim2.fromOffset(24, 15)
    frame37.BackgroundTransparency = 1
    frame37.Parent = icon

    f27(frame37, 7)
    f28(frame37, Color3.fromRGB(255, 255, 255), 2, 0)

    f27(f74(icon, 7, 7, 12, 12), 4)
    f27(f74(icon, 30, 2.5, 12, 12, 32), 1)
  elseif p120 == "gear" then
    local frame38 = Instance.new("Frame")
    frame38.AnchorPoint = Vector2.new(0.5, 0.5)
    frame38.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame38.Size = UDim2.fromOffset(14, 14)
    frame38.BackgroundTransparency = 1
    frame38.Parent = icon

    f27(frame38, 7)
    f28(frame38, Color3.fromRGB(255, 255, 255), 2.5, 0)

    for i7 = 0, 7 do
      local v253 = math.rad(i7 * 45)
      f27(f74(icon, 3.5, 4, 12 + math.sin(v253) * 10, 12 - math.cos(v253) * 10, i7 * 45), 1)
    end

    f27(f74(icon, 5, 5, 12, 12), 3)
  end

  return icon
end

local v254 = {
  fullbright = "sun",
  esp = "target",
  walk = "speed",
  fov = "eye",
  rainbow = "rainbow",
  fly = "fly",
  noclip = "phase",
  visibility = "eyeoff",
  aimlock = "target",
  speed = "speed",
  clean = "window",
  jump = "fly",
  infjump = "fly",
  gravity = "phase",
  afk = "eye",
}

local function f76(p122, layoutOrder2)
  local v255 = v142[p122]

  if not v255 then
    return
  end

  local textButton17 = Instance.new("TextButton")
  textButton17.Size = UDim2.fromOffset(42, 42)
  textButton17.BackgroundColor3 = v255.color
  textButton17.Text = ""
  textButton17.AutoButtonColor = false
  textButton17.LayoutOrder = layoutOrder2
  textButton17.Parent = frame29

  f27(textButton17, 12)
  local v256 = f75(textButton17, v254[p122] or "target")
  local v257 = f28(textButton17, Color3.fromRGB(255, 255, 255), 1.5, 1)

  local function f77()
    local v258 = v255.get()
    f26(textButton17, v118.Snappy, { BackgroundTransparency = v258 and 0 or 0.5 })
    f26(v257, v118.Snappy, { Transparency = v258 and 0.2 or 1 })
  end

  textButton17.MouseButton1Click:Connect(function()
    v255.set(not v255.get())
    f77()
  end)

  textButton17.MouseEnter:Connect(function()
    f26(textButton17, v118.Hover, { Size = UDim2.fromOffset(46, 46) })
  end)

  textButton17.MouseLeave:Connect(function()
    f26(textButton17, v118.Hover, { Size = UDim2.fromOffset(42, 42) })
  end)

  f77()
end

for index22, value33 in ipairs(v249) do
  f76(value33, index22)
end

local textButton18 = Instance.new("TextButton")
textButton18.AnchorPoint = Vector2.new(1, 0.5)
textButton18.Position = UDim2.new(1, -16, 0.5, 0)
textButton18.Size = UDim2.fromOffset(42, 42)
textButton18.BackgroundColor3 = v117.Row
textButton18.Text = ""
textButton18.AutoButtonColor = false
textButton18.Parent = dock

f27(textButton18, 12)
f75(textButton18, "window")
f30((f28(textButton18, color2, 1.5, 0.3)))

textButton18.MouseEnter:Connect(function()
  f26(textButton18, v118.Hover, { BackgroundColor3 = v117.RowHover })
end)

textButton18.MouseLeave:Connect(function()
  f26(textButton18, v118.Hover, { BackgroundColor3 = v117.Row })
end)

local v259 = false
local resizeGrip
local f78

local function f79(p123)
  v259 = p123

  if resizeGrip then
    resizeGrip.Visible = not p123
  end

  if f78 then
    f78()
  end

  if p123 then
    f26(body, v118.Morph, { Size = UDim2.new(1, 0, 0, 0) })
    f26(main, v118.Morph, { Size = udim2, Position = udim4 })
    v156.Text = "+"
  else
    f26(main, v118.Morph, { Size = udim, Position = udim3 })
    f26(body, v118.Morph, { Size = UDim2.new(1, 0, 1, -54) })
    v156.Text = "-"
  end
end

v156.MouseButton1Click:Connect(function() f79(not v259) end)

local function f80()
  arrowTab.Visible = true
  arrowTab.Position = UDim2.new(0.5, 0, 1, 50)
  f26(arrowTab, v118.Open, { Position = UDim2.new(0.5, 0, 1, -12) })
end

local function f81()
  f26(arrowTab, v118.Snappy, { Position = UDim2.new(0.5, 0, 1, 50) })
  task.delay(0.22, function() arrowTab.Visible = false end)
end

local function f82()
  dock.Visible = true
  dock.Position = UDim2.new(0.5, 0, 1, 140)
  f26(dock, v118.Open, { Position = UDim2.new(0.5, 0, 1, -18) })
end

local function f83()
  f26(dock, v118.Snappy, { Position = UDim2.new(0.5, 0, 1, 140) })
  task.delay(0.22, function() dock.Visible = false end)
end

local function f84()
  v259 = false
  v156.Text = "-"

  if resizeGrip then
    resizeGrip.Visible = true
  end

  body.Visible = true
  header.Visible = true
  body.Size = UDim2.new(1, 0, 1, -54)

  main.Visible = true
  main.Position = udim3
  main.Size = UDim2.fromOffset(udim.X.Offset * 0.85, udim.Y.Offset * 0.85)

  f26(main, v118.Open, { Size = udim })

  if v192 then
    f52(true)
  end
end

v155.MouseButton1Click:Connect(function()
  if f78 then
    f78()
  end

  body.Visible = false
  header.Visible = false

  f26(main, v118.Smooth, {
    Size = UDim2.fromOffset(0, 0),
    Position = UDim2.new(0.5, 0, 1, -20),
    BackgroundTransparency = 0.15,
  }).Completed:Connect(function()
    main.Visible = false
    main.BackgroundTransparency = 0
    main.Size = udim
    main.Position = udim3

    body.Visible = true
    header.Visible = true
    f80()
  end)
end)

arrowTab.MouseButton1Click:Connect(function()
  f81()
  f82()
end)

textButton16.MouseButton1Click:Connect(function()
  f83()
  f80()
end)

textButton18.MouseButton1Click:Connect(function()
  f83()
  f84()
end)

arrowTab.MouseEnter:Connect(function()
  f26(arrowTab, v118.Hover, { Size = UDim2.fromOffset(66, 30) })
end)

arrowTab.MouseLeave:Connect(function()
  f26(arrowTab, v118.Hover, { Size = UDim2.fromOffset(58, 28) })
end)

local function f85(p124, p125)
  local v260, position5, position6

  p124.InputBegan:Connect(function(input7)
    if input7.UserInputType == Enum.UserInputType.MouseButton1
      or input7.UserInputType == Enum.UserInputType.Touch then
      v260 = true
      position5 = p125.Position
      position6 = input7.Position

      input7.Changed:Connect(function()
        if input7.UserInputState == Enum.UserInputState.End then
          v260 = false
        end
      end)
    end
  end)

  userInputService.InputChanged:Connect(function(input8)
    if v260
      and (input8.UserInputType == Enum.UserInputType.MouseMovement
        or input8.UserInputType == Enum.UserInputType.Touch) then
      local v261 = input8.Position - position6

      p125.Position = UDim2.new(
        position5.X.Scale, position5.X.Offset + v261.X, position5.Y.Scale,
        position5.Y.Offset + v261.Y
      )
    end
  end)
end

f85(header, main)

local function f86()
  local v262 = 60

  local function f87(p126)
    v262 = p126

    pcall(function()
      if setfpscap then
        setfpscap(p126)
      end
    end)
  end

  local v263 = {}
  local v264 = nil
  local v265 = {}

  local settingsGear = Instance.new("TextButton")
  settingsGear.Name = "SettingsGear"
  settingsGear.AnchorPoint = Vector2.new(1, 0.5)
  settingsGear.Position = UDim2.new(1, -20, 0, 34)
  settingsGear.Size = UDim2.fromOffset(34, 34)
  settingsGear.BackgroundColor3 = v117.Row
  settingsGear.AutoButtonColor = false
  settingsGear.Text = ""
  settingsGear.Parent = body

  f27(settingsGear, 10)
  f30((f28(settingsGear, color2, 1.2, 0.4)))
  local v266 = f75(settingsGear, "gear")
  local v267, v268

  function f78()
    if v267 then
      v267:Cancel()
    end

    if v268 then
      v268:Cancel()
    end

    settingsGear.Size = UDim2.fromOffset(34, 34)
    settingsGear.BackgroundColor3 = v117.Row

    v266.Rotation = 0
  end

  settingsGear.MouseEnter:Connect(function()
    if v259 then
      return
    end

    v267 = f26(settingsGear, v118.Hover, {
      Size = UDim2.fromOffset(38, 38),
      BackgroundColor3 = v117.RowHover,
    })

    v268 = f26(v266, v118.Smooth, { Rotation = 120 })
  end)

  settingsGear.MouseLeave:Connect(function()
    if v259 then
      return
    end

    v267 = f26(settingsGear, v118.Hover, {
      Size = UDim2.fromOffset(34, 34),
      BackgroundColor3 = v117.Row,
    })

    v268 = f26(v266, v118.Smooth, { Rotation = 0 })
  end)

  local udim5 = UDim2.fromOffset(540, 484)

  if v42.mobile then
    local v269 = v42.viewport()

    udim5 = UDim2.fromOffset(
      math.clamp(math.floor(v269.X - 24), 280, 540),
      math.clamp(math.floor(v269.Y - 150), 320, 484)
    )
  end

  local v270 = false

  local settingsPanel = Instance.new("Frame")
  settingsPanel.Name = "SettingsPanel"
  settingsPanel.AnchorPoint = Vector2.new(0.5, 0.5)
  settingsPanel.Position = UDim2.fromScale(v42.mobile and 0.5 or 0.64, 0.5)
  settingsPanel.Size = udim5
  settingsPanel.BackgroundColor3 = v117.Background
  settingsPanel.BorderSizePixel = 0
  settingsPanel.ClipsDescendants = true
  settingsPanel.Visible = false
  settingsPanel.Parent = statsX

  f27(settingsPanel, 16)
  local v271 = f28(settingsPanel, color2, 1.5, 0.25)
  f30(v271)
  f29(settingsPanel, v117.Background2, v117.Background, 90)

  do
    local uiScale5 = Instance.new("UIScale")
    uiScale5.Scale = 1
    uiScale5.Parent = settingsPanel

    local function f88()
      local v272 = v42.viewport()
      local offset3, offset4 = settingsPanel.Size.X.Offset, settingsPanel.Size.Y.Offset

      if offset3 < 2 or offset4 < 2 then
        return
      end

      uiScale5.Scale = math.clamp(
        math.min((v272.X - 12) / offset3, (v272.Y - 12) / offset4), 0.5, 1
      )
    end

    f88()

    settingsPanel:GetPropertyChangedSignal("Size"):Connect(function() task.defer(f88) end)
    statsX:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() task.defer(f88) end)
  end

  local settingsResize = Instance.new("TextButton")
  settingsResize.Name = "SettingsResize"
  settingsResize.AnchorPoint = Vector2.new(1, 1)
  settingsResize.Position = UDim2.new(1, -3, 1, -3)
  settingsResize.Size = UDim2.fromOffset(20, 20)
  settingsResize.BackgroundTransparency = 1
  settingsResize.Text = ""
  settingsResize.AutoButtonColor = false
  settingsResize.ZIndex = 8
  settingsResize.Parent = settingsPanel

  for i8 = 1, 3 do
    local frame39 = Instance.new("Frame")
    frame39.AnchorPoint = Vector2.new(1, 1)
    frame39.Position = UDim2.new(1, -3, 1, -3 - (i8 - 1) * 5)
    frame39.Size = UDim2.fromOffset((4 - i8) * 5, 2)
    frame39.BackgroundColor3 = v117.SubText
    frame39.BackgroundTransparency = 0.25
    frame39.BorderSizePixel = 0
    frame39.ZIndex = 8
    frame39.Parent = settingsResize

    f27(frame39, 1)
  end

  local v273, position7, absoluteSize2

  settingsResize.InputBegan:Connect(function(input9)
    if input9.UserInputType == Enum.UserInputType.MouseButton1
      or input9.UserInputType == Enum.UserInputType.Touch then
      v273 = true
      position7 = input9.Position
      absoluteSize2 = settingsPanel.AbsoluteSize
    end
  end)

  settingsResize.InputEnded:Connect(function(input10)
    if input10.UserInputType == Enum.UserInputType.MouseButton1
      or input10.UserInputType == Enum.UserInputType.Touch then
      v273 = false
    end
  end)

  userInputService.InputChanged:Connect(function(input11)
    if v273
      and (input11.UserInputType == Enum.UserInputType.MouseMovement
        or input11.UserInputType == Enum.UserInputType.Touch) then
      local v274 = input11.Position - position7
      local v275 = math.clamp(absoluteSize2.X + v274.X * 2, 380, 760)
      local v276 = math.clamp(absoluteSize2.Y + v274.Y * 2, 320, 760)
      udim5 = UDim2.fromOffset(math.floor(v275), math.floor(v276))

      if v270 then
        settingsPanel.Size = udim5
      end
    end
  end)

  local frame40 = Instance.new("Frame")
  frame40.Size = UDim2.new(1, -32, 0, 3)
  frame40.Position = UDim2.fromOffset(16, 0)
  frame40.BackgroundColor3 = color2
  frame40.BorderSizePixel = 0
  frame40.Parent = settingsPanel

  f27(frame40, 2)
  f30(frame40)

  local header2 = Instance.new("Frame")
  header2.Name = "Header"
  header2.BackgroundTransparency = 1
  header2.Size = UDim2.new(1, 0, 0, 46)
  header2.Position = UDim2.fromOffset(0, 4)
  header2.Parent = settingsPanel

  local textLabel23 = Instance.new("TextLabel")
  textLabel23.BackgroundTransparency = 1
  textLabel23.Position = UDim2.fromOffset(18, 12)
  textLabel23.Size = UDim2.new(1, -70, 0, 24)
  textLabel23.Font = Enum.Font.GothamBold
  textLabel23.Text = "Settings"
  textLabel23.TextColor3 = v117.Text
  textLabel23.TextSize = 17
  textLabel23.TextXAlignment = Enum.TextXAlignment.Left
  textLabel23.Parent = header2

  local textButton19 = Instance.new("TextButton")
  textButton19.AnchorPoint = Vector2.new(1, 0.5)
  textButton19.Position = UDim2.new(1, -14, 0.5, 0)
  textButton19.Size = UDim2.fromOffset(28, 28)
  textButton19.BackgroundColor3 = v117.Row
  textButton19.Text = "X"
  textButton19.TextColor3 = v117.Text
  textButton19.TextSize = 15
  textButton19.Font = Enum.Font.GothamBold
  textButton19.AutoButtonColor = false
  textButton19.Parent = header2

  f27(textButton19, 8)

  textButton19.MouseEnter:Connect(function()
    f26(textButton19, v118.Hover, { BackgroundColor3 = Color3.fromRGB(220, 70, 80) })
  end)

  textButton19.MouseLeave:Connect(function()
    f26(textButton19, v118.Hover, { BackgroundColor3 = v117.Row })
  end)

  local v277 = "General"
  local v278 = {}

  local setTabBar = Instance.new("Frame")
  setTabBar.Name = "SetTabBar"
  setTabBar.BackgroundColor3 = v117.Row
  setTabBar.BorderSizePixel = 0
  setTabBar.Position = UDim2.fromOffset(18, 50)
  setTabBar.Size = UDim2.new(1, -36, 0, 30)
  setTabBar.Parent = settingsPanel

  f27(setTabBar, 9)

  local uiPadding6 = Instance.new("UIPadding")
  uiPadding6.PaddingLeft = UDim.new(0, 4)
  uiPadding6.PaddingRight = UDim.new(0, 4)
  uiPadding6.PaddingTop = UDim.new(0, 4)
  uiPadding6.PaddingBottom = UDim.new(0, 4)
  uiPadding6.Parent = setTabBar

  local uiListLayout7 = Instance.new("UIListLayout")
  uiListLayout7.FillDirection = Enum.FillDirection.Horizontal
  uiListLayout7.Padding = UDim.new(0, 4)
  uiListLayout7.SortOrder = Enum.SortOrder.LayoutOrder
  uiListLayout7.Parent = setTabBar

  local f89

  local function f90(p127, layoutOrder3)
    local textButton20 = Instance.new("TextButton")
    textButton20.Size = UDim2.new(0.5, -6, 1, 0)
    textButton20.BackgroundColor3 = v117.Row
    textButton20.AutoButtonColor = false
    textButton20.Font = Enum.Font.GothamMedium
    textButton20.Text = p127
    textButton20.TextSize = 13
    textButton20.TextColor3 = v117.SubText
    textButton20.LayoutOrder = layoutOrder3
    textButton20.Parent = setTabBar

    f27(textButton20, 7)
    v278[p127] = textButton20

    textButton20.MouseButton1Click:Connect(function()
      if f89 then
        f89(p127)
      end
    end)

    return textButton20
  end

  f90("General", 1)
  f90("Keybinds", 2)

  local scrollingFrame3 = Instance.new("ScrollingFrame")
  scrollingFrame3.BackgroundTransparency = 1
  scrollingFrame3.BorderSizePixel = 0
  scrollingFrame3.Position = UDim2.fromOffset(0, 88)
  scrollingFrame3.Size = UDim2.new(1, 0, 1, -96)
  scrollingFrame3.ScrollBarThickness = 4
  scrollingFrame3.ScrollBarImageColor3 = color2
  scrollingFrame3.CanvasSize = UDim2.new()
  scrollingFrame3.AutomaticCanvasSize = Enum.AutomaticSize.Y
  scrollingFrame3.ScrollingDirection = Enum.ScrollingDirection.Y
  scrollingFrame3.Parent = settingsPanel

  local uiPadding7 = Instance.new("UIPadding")
  uiPadding7.PaddingLeft = UDim.new(0, 18)
  uiPadding7.PaddingRight = UDim.new(0, 18)
  uiPadding7.PaddingTop = UDim.new(0, 4)
  uiPadding7.PaddingBottom = UDim.new(0, 12)
  uiPadding7.Parent = scrollingFrame3

  local uiListLayout8 = Instance.new("UIListLayout")
  uiListLayout8.Padding = UDim.new(0, 8)
  uiListLayout8.SortOrder = Enum.SortOrder.LayoutOrder
  uiListLayout8.Parent = scrollingFrame3

  f35(scrollingFrame3, {
    name = "FPS cap",
    min = 30,
    max = 360,
    default = v262,
    decimals = 0,
    order = 1,
    onChange = function(p128) f87(p128) end,
  })

  f39(scrollingFrame3, {
    name = "Unlock FPS (999)",
    default = false,
    order = 2,
    onChange = function(p129) f87(p129 and 999 or v262) end,
  })

  f39(scrollingFrame3, {
    name = "Low quality (boost FPS)",
    default = false,
    order = 3,
    onChange = function(p130) end,
  })

  f39(scrollingFrame3, {
    name = "Disable shadows",
    default = false,
    order = 4,
    onChange = function(p131) end,
  })

  f39(scrollingFrame3, {
    name = "Disable post-processing",
    default = false,
    order = 5,
    onChange = function(p132) end,
  })

  f39(scrollingFrame3, {
    name = "Remove fog",
    default = false,
    order = 6,
    onChange = function(p133) end,
  })

  local frame41 = Instance.new("Frame")
  frame41.Size = UDim2.new(1, 0, 0, 1)
  frame41.BackgroundColor3 = v117.Stroke
  frame41.BorderSizePixel = 0
  frame41.LayoutOrder = 90
  frame41.Parent = scrollingFrame3

  local textButton21 = Instance.new("TextButton")
  textButton21.Size = UDim2.new(1, 0, 0, 38)
  textButton21.BackgroundColor3 = Color3.fromRGB(45, 24, 28)
  textButton21.AutoButtonColor = false
  textButton21.Font = Enum.Font.GothamBold
  textButton21.TextSize = 14
  textButton21.Text = "Unload / Destroy StatsX"
  textButton21.TextColor3 = Color3.fromRGB(255, 120, 130)
  textButton21.LayoutOrder = 91
  textButton21.Parent = scrollingFrame3

  f27(textButton21, 9)
  f28(textButton21, Color3.fromRGB(220, 70, 80), 1.2, 0.4)

  local textLabel24 = Instance.new("TextLabel")
  textLabel24.BackgroundTransparency = 1
  textLabel24.Size = UDim2.new(1, 0, 0, 28)
  textLabel24.Font = Enum.Font.Gotham
  textLabel24.TextSize = 11
  textLabel24.Text = "Turns every feature off (restores your character) and removes the UI. Re-run the script to use it again."
  textLabel24.TextColor3 = v117.SubText
  textLabel24.TextXAlignment = Enum.TextXAlignment.Left
  textLabel24.TextYAlignment = Enum.TextYAlignment.Top
  textLabel24.TextWrapped = true
  textLabel24.LayoutOrder = 92
  textLabel24.Parent = scrollingFrame3

  local function f91()
    if v119 then
      return
    end

    v119 = true

    for key14, value34 in pairs(v142) do
      pcall(function()
        if value34.get and value34.get() then
          value34.set(false)
        end
      end)
    end

    pcall(function() statsX:Destroy() end)
  end

  local v279 = false

  textButton21.MouseEnter:Connect(function()
    f26(textButton21, v118.Hover, { BackgroundColor3 = Color3.fromRGB(220, 70, 80) })
  end)

  textButton21.MouseLeave:Connect(function()
    f26(textButton21, v118.Hover, {
      BackgroundColor3 = v279 and Color3.fromRGB(150, 40, 48) or Color3.fromRGB(45, 24, 28),
    })
  end)

  textButton21.MouseButton1Click:Connect(function()
    if not v279 then
      v279 = true
      textButton21.Text = "Click again to confirm"
      f26(textButton21, v118.Snappy, { BackgroundColor3 = Color3.fromRGB(150, 40, 48) })

      task.delay(2.5, function()
        if v279 and not v119 then
          v279 = false
          textButton21.Text = "Unload / Destroy StatsX"
          f26(textButton21, v118.Snappy, { BackgroundColor3 = Color3.fromRGB(45, 24, 28) })
        end
      end)

      return
    end

    f91()
  end)

  local keybindList = Instance.new("ScrollingFrame")
  keybindList.Name = "KeybindList"
  keybindList.BackgroundTransparency = 1
  keybindList.BorderSizePixel = 0
  keybindList.Position = UDim2.fromOffset(0, 106)
  keybindList.Size = UDim2.new(1, 0, 1, -114)
  keybindList.ScrollBarThickness = 4
  keybindList.ScrollBarImageColor3 = color2
  keybindList.CanvasSize = UDim2.new()
  keybindList.AutomaticCanvasSize = Enum.AutomaticSize.None
  keybindList.ScrollingDirection = Enum.ScrollingDirection.Y
  keybindList.Visible = false
  keybindList.Parent = settingsPanel

  local uiPadding8 = Instance.new("UIPadding")
  uiPadding8.PaddingLeft = UDim.new(0, 18)
  uiPadding8.PaddingRight = UDim.new(0, 18)
  uiPadding8.PaddingTop = UDim.new(0, 4)
  uiPadding8.PaddingBottom = UDim.new(0, 12)
  uiPadding8.Parent = keybindList

  local uiGridLayout = Instance.new("UIGridLayout")
  uiGridLayout.CellSize = UDim2.fromOffset(150, 96)
  uiGridLayout.CellPadding = UDim2.fromOffset(10, 10)
  uiGridLayout.FillDirection = Enum.FillDirection.Horizontal
  uiGridLayout.FillDirectionMaxCells = 0
  uiGridLayout.StartCorner = Enum.StartCorner.TopLeft
  uiGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
  uiGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
  uiGridLayout.Parent = keybindList

  uiGridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    keybindList.CanvasSize = UDim2.new(0, 0, 0, uiGridLayout.AbsoluteContentSize.Y + 16)
  end)

  local textLabel25 = Instance.new("TextLabel")
  textLabel25.BackgroundTransparency = 1
  textLabel25.Position = UDim2.fromOffset(18, 86)
  textLabel25.Size = UDim2.new(1, -36, 0, 16)
  textLabel25.Visible = false
  textLabel25.Font = Enum.Font.Gotham
  textLabel25.Text = "Click a key to rebind  -  Backspace clears  -  Esc cancels"
  textLabel25.TextColor3 = v117.SubText
  textLabel25.TextSize = 11
  textLabel25.TextXAlignment = Enum.TextXAlignment.Left
  textLabel25.Parent = settingsPanel

  local function f92(p134, layoutOrder4)
    local v280 = v142[p134]

    if not v280 then
      return
    end

    local frame42 = Instance.new("Frame")
    frame42.Name = p134
    frame42.Size = UDim2.fromOffset(150, 96)
    frame42.BackgroundColor3 = v117.Row
    frame42.BorderSizePixel = 0
    frame42.LayoutOrder = layoutOrder4
    frame42.Parent = keybindList

    f27(frame42, 12)

    local frame43 = Instance.new("Frame")
    frame43.AnchorPoint = Vector2.new(0, 0)
    frame43.Position = UDim2.fromOffset(12, 12)
    frame43.Size = UDim2.fromOffset(36, 36)
    frame43.BackgroundColor3 = v280.color
    frame43.BorderSizePixel = 0
    frame43.Parent = frame42

    f27(frame43, 10)
    f75(frame43, v254[p134] or "target")

    local textLabel26 = Instance.new("TextLabel")
    textLabel26.BackgroundTransparency = 1
    textLabel26.Position = UDim2.fromOffset(56, 18)
    textLabel26.Size = UDim2.fromOffset(82, 24)
    textLabel26.Font = Enum.Font.GothamMedium
    textLabel26.Text = v280.name or p134
    textLabel26.TextColor3 = v117.Text
    textLabel26.TextSize = 14
    textLabel26.TextXAlignment = Enum.TextXAlignment.Left
    textLabel26.TextTruncate = Enum.TextTruncate.AtEnd
    textLabel26.Parent = frame42

    local textButton22 = Instance.new("TextButton")
    textButton22.AnchorPoint = Vector2.new(0, 1)
    textButton22.Position = UDim2.new(0, 12, 1, -12)
    textButton22.Size = UDim2.fromOffset(66, 32)
    textButton22.BackgroundColor3 = v117.TrackOff
    textButton22.AutoButtonColor = false
    textButton22.Font = Enum.Font.GothamBold
    textButton22.TextSize = 15
    textButton22.TextColor3 = v117.Text
    textButton22.TextTruncate = Enum.TextTruncate.AtEnd
    textButton22.Text = f42(v263[p134])
    textButton22.Parent = frame42

    f27(textButton22, 9)
    local v281 = f28(textButton22, color2, 1.2, 1)
    v265[p134] = { btn = textButton22, st = v281 }
    textButton22.TextColor3 = v263[p134] and v117.Text or v117.SubText

    local textButton23 = Instance.new("TextButton")
    textButton23.AnchorPoint = Vector2.new(1, 1)
    textButton23.Position = UDim2.new(1, -12, 1, -12)
    textButton23.Size = UDim2.fromOffset(48, 32)
    textButton23.BackgroundColor3 = v117.TrackOff
    textButton23.AutoButtonColor = false
    textButton23.Font = Enum.Font.GothamBold
    textButton23.TextSize = 12
    textButton23.TextColor3 = v117.SubText
    textButton23.Text = "Clear"
    textButton23.Parent = frame42

    f27(textButton23, 9)

    textButton23.MouseEnter:Connect(function()
      f26(textButton23, v118.Hover, { BackgroundColor3 = Color3.fromRGB(220, 70, 80) })
    end)

    textButton23.MouseLeave:Connect(function()
      f26(textButton23, v118.Hover, { BackgroundColor3 = v117.TrackOff })
    end)

    textButton23.MouseButton1Click:Connect(function()
      if v264 == p134 then
        v264 = nil
      end

      v263[p134] = nil

      textButton22.Text = "None"
      textButton22.TextColor3 = v117.SubText

      f26(v281, v118.Snappy, { Transparency = 1 })
    end)

    textButton22.MouseEnter:Connect(function()
      if v264 ~= p134 then
        f26(v281, v118.Hover, { Transparency = 0.35 })
      end
    end)

    textButton22.MouseLeave:Connect(function()
      if v264 ~= p134 then
        f26(v281, v118.Hover, { Transparency = 1 })
      end
    end)

    textButton22.MouseButton1Click:Connect(function()
      if v264 and v265[v264] then
        v265[v264].btn.Text = f42(v263[v264])
        f26(v265[v264].st, v118.Snappy, { Transparency = 1 })
      end

      v264 = p134
      textButton22.Text = "..."
      f26(v281, v118.Snappy, { Transparency = 0 })
    end)
  end

  for index23, value35 in ipairs({
    "fullbright", "esp", "fov", "rainbow", "clean", "walk", "jump", "infjump", "fly", "noclip",
    "gravity", "speed", "afk", "visibility", "aimlock",
  }) do
    f92(value35, index23)
  end

  function f89(p135)
    v277 = p135
    scrollingFrame3.Visible = p135 == "General"
    keybindList.Visible = p135 == "Keybinds"
    textLabel25.Visible = p135 == "Keybinds"

    for key15, value36 in pairs(v278) do
      local v282 = key15 == p135

      f26(value36, v118.Snappy, {
        BackgroundColor3 = v282 and color2 or v117.Row,
        TextColor3 = v282 and Color3.fromRGB(22, 22, 30) or v117.SubText,
      })
    end
  end

  f89("General")

  settingsPanel.ZIndex = 50

  for index24, value37 in ipairs(settingsPanel:GetDescendants()) do
    if value37:IsA("GuiObject") then
      value37.ZIndex = value37.ZIndex + 50
    end
  end

  f85(header2, settingsPanel)

  local function f93()
    v270 = not v270

    if v270 then
      settingsPanel.Visible = true
      settingsPanel.Size = UDim2.fromOffset(380, 220)
      settingsPanel.BackgroundTransparency = 0.45

      v271.Transparency = 1

      f26(settingsPanel, v118.Open, { Size = udim5, BackgroundTransparency = 0 })
      f26(v271, v118.Smooth, { Transparency = 0.25 })
    else
      scrollingFrame3.Visible = false
      keybindList.Visible = false
      textLabel25.Visible = false

      f26(settingsPanel, v118.Smooth, {
        Size = UDim2.fromOffset(math.max(udim5.X.Offset - 14, 120), 0),
        BackgroundTransparency = 0.7,
      })

      f26(v271, v118.Smooth, { Transparency = 1 })

      task.delay(0.42, function()
        if not v270 then
          settingsPanel.Visible = false
          settingsPanel.Size = udim5
          settingsPanel.BackgroundTransparency = 0

          v271.Transparency = 0.25
          f89(v277)
        end
      end)
    end
  end

  settingsGear.MouseButton1Click:Connect(f93)

  textButton19.MouseButton1Click:Connect(function()
    if v270 then
      f93()
    end
  end)

  userInputService.InputBegan:Connect(function(input12, p136)
    if v119 then
      return
    end

    if input12.UserInputType ~= Enum.UserInputType.Keyboard then
      return
    end

    if v264 then
      local v283 = v264
      local keyCode2 = input12.KeyCode

      if keyCode2 == Enum.KeyCode.Escape then
      elseif keyCode2 == Enum.KeyCode.Backspace or keyCode2 == Enum.KeyCode.Delete then
        v263[v283] = nil
      else
        for key16, value38 in pairs(v263) do
          if value38 == keyCode2 and key16 ~= v283 then
            v263[key16] = nil

            if v265[key16] then
              v265[key16].btn.Text = "None"
              v265[key16].btn.TextColor3 = v117.SubText
            end
          end
        end

        v263[v283] = keyCode2
      end

      if v265[v283] then
        v265[v283].btn.Text = f42(v263[v283])
        v265[v283].btn.TextColor3 = v263[v283] and v117.Text or v117.SubText
        f26(v265[v283].st, v118.Snappy, { Transparency = 1 })
      end

      v264 = nil
      return
    end

    if v179 then
      return
    end

    if p136 then
      return
    end

    for key17, value39 in pairs(v263) do
      if value39 and input12.KeyCode == value39 then
        local v284 = v142[key17]

        if v284 and v284.set then
          v284.set(not v284.get())
        end
      end
    end
  end)

  local function f94()
    local v285 = writefile ~= nil
    local v286 = readfile ~= nil and isfile ~= nil

    local function f95(p137, text5, text6)
      if not p137 then
        return
      end

      p137.Text = text6

      task.delay(1.1, function()
        if p137 and p137.Parent then
          p137.Text = text5
        end
      end)
    end

    local v287

    local function f96(p138)
      if not v286 then
        if not p138 then
          f95(v287, "Load config", "Unsupported")
        end

        return
      end

      local statsXConfigJson = false
      pcall(function() statsXConfigJson = isfile("StatsX_config.json") end)

      if not statsXConfigJson then
        if not p138 then
          f95(v287, "Load config", "No save")
        end

        return
      end

      local v288, v289 = pcall(function() return readfile("StatsX_config.json") end)

      if not v288 or type(v289) ~= "string" then
        return
      end

      local v290, v291 = pcall(function() return httpService:JSONDecode(v289) end)

      if not v290 or type(v291) ~= "table" then
        return
      end

      if type(v291.toggles) == "table" then
        for key18, value40 in pairs(v291.toggles) do
          local v292 = v142[key18]

          if v292 and v292.set then
            pcall(function() v292.set(value40 and true or false) end)
          end
        end
      end

      if type(v291.binds) == "table" then
        for key19, value41 in pairs(v291.binds) do
          if type(value41) == "string" then
            local v293, v294 = pcall(function() return Enum.KeyCode[value41] end)

            if v293 and v294 then
              v263[key19] = v294

              if v265[key19] then
                v265[key19].btn.Text = f42(v294)
                v265[key19].btn.TextColor3 = v117.Text
              end
            end
          end
        end
      end

      if type(v291.aimToggleMode) == "boolean" then
        StatsXAim.toggleMode = v291.aimToggleMode
        StatsXAim.toggled = false
      end

      if not p138 then
        f95(v287, "Load config", "Loaded!")
      end
    end

    local configRow = Instance.new("Frame")
    configRow.Name = "ConfigRow"
    configRow.BackgroundTransparency = 1
    configRow.Size = UDim2.new(1, 0, 0, 34)
    configRow.LayoutOrder = 80
    configRow.Parent = scrollingFrame3

    local uiListLayout9 = Instance.new("UIListLayout")
    uiListLayout9.FillDirection = Enum.FillDirection.Horizontal
    uiListLayout9.Padding = UDim.new(0, 8)
    uiListLayout9.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout9.VerticalAlignment = Enum.VerticalAlignment.Center
    uiListLayout9.Parent = configRow

    local function f97(text7, layoutOrder5)
      local textButton24 = Instance.new("TextButton")
      textButton24.Size = UDim2.new(0.5, -4, 1, 0)
      textButton24.BackgroundColor3 = v117.Row
      textButton24.AutoButtonColor = false
      textButton24.Font = Enum.Font.GothamMedium
      textButton24.TextSize = 13
      textButton24.Text = text7
      textButton24.TextColor3 = v117.Text
      textButton24.LayoutOrder = layoutOrder5
      textButton24.Parent = configRow

      f27(textButton24, 8)
      f28(textButton24, v117.Stroke, 1, 0.3)

      textButton24.MouseEnter:Connect(function()
        f26(textButton24, v118.Hover, { BackgroundColor3 = v117.RowHover })
      end)

      textButton24.MouseLeave:Connect(function()
        f26(textButton24, v118.Hover, { BackgroundColor3 = v117.Row })
      end)

      return textButton24
    end

    local v295 = f97("Save config", 1)
    v287 = f97("Load config", 2)

    v295.MouseButton1Click:Connect(function()
      local v296 = { toggles = {}, binds = {} }

      for key20, value42 in pairs(v142) do
        local v297, v298 = pcall(value42.get)
        v296.toggles[key20] = v297 and v298 and true or false
      end

      for key21, value43 in pairs(v263) do
        if value43 then
          v296.binds[key21] = value43.Name
        end
      end

      v296.aimToggleMode = StatsXAim.toggleMode and true or false
      local v299, v300 = pcall(function() return httpService:JSONEncode(v296) end)

      if not (v299 and v285) then
        f95(v295, "Save config", "Unsupported")
        return
      end

      f95(
        v295, "Save config",
        pcall(function() writefile("StatsX_config.json", v300) end) and "Saved!" or "Failed"
      )
    end)

    v287.MouseButton1Click:Connect(function() f96(false) end)

    task.spawn(function()
      task.wait(0.7)
      pcall(f96, true)
    end)
  end

  f94()
end

f86()

task.spawn(function()
  while statsX.Parent do
    textLabel22.Text = os.date("%H:%M")
    task.wait(5)
  end
end)

main.Visible = false

local function f98()
  main.Visible = true
  main.Position = udim3
  main.Size = UDim2.fromOffset(udim.X.Offset * 0.8, udim.Y.Offset * 0.8)
  main.BackgroundTransparency = 0.3

  f26(main, v118.Open, { Size = udim })
  f26(main, v118.Smooth, { BackgroundTransparency = 0 })

  task.delay(0.45, function()
    if v119 then
      return
    end

    if v192 and f52 then
      f52(true)
    end
  end)
end

task.spawn(function()
  for index25, value44 in ipairs(statsX.Parent:GetChildren()) do
    if value44.Name == "StatsXSplash" then
      value44:Destroy()
    end
  end

  local statsXSplash = Instance.new("ScreenGui")
  statsXSplash.Name = "StatsXSplash"
  statsXSplash.ResetOnSpawn = false
  statsXSplash.IgnoreGuiInset = true
  statsXSplash.DisplayOrder = 100000
  statsXSplash.Parent = statsX.Parent

  local frame44 = Instance.new("Frame")
  frame44.Size = UDim2.fromScale(1, 1)
  frame44.BackgroundColor3 = v117.Background
  frame44.BackgroundTransparency = 1
  frame44.BorderSizePixel = 0
  frame44.Parent = statsXSplash

  local frame45 = Instance.new("Frame")
  frame45.AnchorPoint = Vector2.new(0.5, 0.5)
  frame45.Position = UDim2.fromScale(0.5, 0.5)
  frame45.Size = UDim2.fromOffset(440, 220)
  frame45.BackgroundTransparency = 1
  frame45.Parent = frame44

  local frame46 = Instance.new("Frame")
  frame46.AnchorPoint = Vector2.new(0.5, 0.5)
  frame46.Position = UDim2.fromScale(0.5, 0.34)
  frame46.Size = UDim2.fromOffset(460, 112)
  frame46.BackgroundTransparency = 1
  frame46.Parent = frame45

  local uiListLayout10 = Instance.new("UIListLayout")
  uiListLayout10.FillDirection = Enum.FillDirection.Horizontal
  uiListLayout10.HorizontalAlignment = Enum.HorizontalAlignment.Center
  uiListLayout10.VerticalAlignment = Enum.VerticalAlignment.Center
  uiListLayout10.SortOrder = Enum.SortOrder.LayoutOrder
  uiListLayout10.Padding = UDim.new(0, 1)
  uiListLayout10.Parent = frame46

  local uiScale6 = Instance.new("UIScale")
  uiScale6.Scale = 0.8
  uiScale6.Parent = frame46

  local textLabel27 = Instance.new("TextLabel")
  textLabel27.AutomaticSize = Enum.AutomaticSize.XY
  textLabel27.LayoutOrder = 1
  textLabel27.BackgroundTransparency = 1
  textLabel27.Font = Enum.Font.GothamBlack
  textLabel27.Text = "STATS"
  textLabel27.TextSize = 60
  textLabel27.TextColor3 = Color3.fromRGB(255, 255, 255)
  textLabel27.TextTransparency = 1
  textLabel27.Parent = frame46

  local uiGradient5 = Instance.new("UIGradient")

  uiGradient5.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 140, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(124, 110, 255)),
  })

  uiGradient5.Parent = textLabel27

  local textLabel28 = Instance.new("TextLabel")
  textLabel28.AutomaticSize = Enum.AutomaticSize.XY
  textLabel28.LayoutOrder = 2
  textLabel28.BackgroundTransparency = 1
  textLabel28.Font = Enum.Font.GothamBlack
  textLabel28.Text = "X"
  textLabel28.TextSize = 96
  textLabel28.TextColor3 = Color3.fromRGB(255, 255, 255)
  textLabel28.TextTransparency = 1
  textLabel28.Parent = frame46

  local uiGradient6 = Instance.new("UIGradient")

  uiGradient6.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(124, 110, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 60, 230)),
  })

  uiGradient6.Parent = textLabel28

  local textLabel29 = Instance.new("TextLabel")
  textLabel29.AnchorPoint = Vector2.new(0.5, 0.5)
  textLabel29.Position = UDim2.fromScale(0.5, 0.66)
  textLabel29.Size = UDim2.fromOffset(320, 26)
  textLabel29.BackgroundTransparency = 1
  textLabel29.Font = Enum.Font.GothamBold
  textLabel29.Text = "loading.."
  textLabel29.TextSize = 18
  textLabel29.TextColor3 = v117.SubText
  textLabel29.TextTransparency = 1
  textLabel29.Parent = frame45

  local frame47 = Instance.new("Frame")
  frame47.AnchorPoint = Vector2.new(0.5, 0.5)
  frame47.Position = UDim2.fromScale(0.5, 0.8)
  frame47.Size = UDim2.fromOffset(280, 8)
  frame47.BackgroundColor3 = v117.Row
  frame47.BackgroundTransparency = 1
  frame47.BorderSizePixel = 0
  frame47.Parent = frame45

  f27(frame47, 4)
  local v301 = f28(frame47, v117.Stroke, 1, 1)

  local frame48 = Instance.new("Frame")
  frame48.Size = UDim2.new(0, 0, 1, 0)
  frame48.BackgroundColor3 = color2
  frame48.BackgroundTransparency = 1
  frame48.BorderSizePixel = 0
  frame48.Parent = frame47

  f27(frame48, 4)
  f29(frame48, Color3.fromRGB(90, 140, 255), Color3.fromRGB(120, 60, 230), 0)

  f26(textLabel27, v118.Open, { TextTransparency = 0 })
  f26(textLabel28, v118.Open, { TextTransparency = 0 })
  f26(uiScale6, v118.Open, { Scale = 1 })

  task.wait(0.55)

  f26(textLabel29, v118.Smooth, { TextTransparency = 0 })
  f26(frame47, v118.Smooth, { BackgroundTransparency = 0 })
  f26(v301, v118.Smooth, { Transparency = 0.4 })
  f26(frame48, v118.Smooth, { BackgroundTransparency = 0 })

  f26(frame48, TweenInfo.new(1.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    Size = UDim2.new(1, 0, 1, 0),
  })

  task.wait(1.95)

  f26(textLabel27, v118.Smooth, { TextTransparency = 1 })
  f26(textLabel28, v118.Smooth, { TextTransparency = 1 })
  f26(uiScale6, v118.Smooth, { Scale = 1.08 })
  f26(textLabel29, v118.Smooth, { TextTransparency = 1 })
  f26(frame47, v118.Smooth, { BackgroundTransparency = 1 })
  f26(v301, v118.Smooth, { Transparency = 1 })
  f26(frame48, v118.Smooth, { BackgroundTransparency = 1 })

  task.wait(0.45)
  statsXSplash:Destroy()
  f98()
  task.wait(0.5)

  if v142.clean then
    v142.clean.set(true)
  end
end)

resizeGrip = Instance.new("TextButton")
resizeGrip.Name = "ResizeGrip"
resizeGrip.AnchorPoint = Vector2.new(1, 1)
resizeGrip.Position = UDim2.new(1, -5, 1, -5)
resizeGrip.Size = UDim2.fromOffset(22, 22)
resizeGrip.BackgroundTransparency = 1
resizeGrip.Text = ""
resizeGrip.AutoButtonColor = false
resizeGrip.ZIndex = 6
resizeGrip.Parent = main

for i9 = 1, 3 do
  local frame49 = Instance.new("Frame")
  frame49.AnchorPoint = Vector2.new(0.5, 0.5)
  frame49.Position = UDim2.fromOffset(20 - i9 * 4, 20 - i9 * 4)
  frame49.Size = UDim2.fromOffset(2, i9 * 6)
  frame49.Rotation = 45
  frame49.BackgroundColor3 = v117.SubText
  frame49.BorderSizePixel = 0
  frame49.ZIndex = 7
  frame49.Parent = resizeGrip

  f27(frame49, 1)
end

local v302, position8, vector3

resizeGrip.InputBegan:Connect(function(input13)
  if input13.UserInputType == Enum.UserInputType.MouseButton1
    or input13.UserInputType == Enum.UserInputType.Touch then
    v302 = true
    position8 = input13.Position
    vector3 = Vector2.new(main.Size.X.Offset, main.Size.Y.Offset)

    input13.Changed:Connect(function()
      if input13.UserInputState == Enum.UserInputState.End then
        v302 = false
      end
    end)
  end
end)

userInputService.InputChanged:Connect(function(input14)
  if v302
    and (input14.UserInputType == Enum.UserInputType.MouseMovement
      or input14.UserInputType == Enum.UserInputType.Touch) then
    local v303 = input14.Position - position8
    local v304 = math.max(v42.scale.Scale, 0.01)
    local mobile3 = v42.mobile and 280 or 360
    local mobile4 = v42.mobile and 300 or 380
    local v305 = math.clamp(vector3.X + v303.X / v304 * 2, mobile3, 760)
    local v306 = math.clamp(vector3.Y + v303.Y / v304 * 2, mobile4, 780)
    udim = UDim2.fromOffset(v305, v306)

    if not v259 then
      main.Size = udim
      main.Position = udim3
      v42.fit()
    end
  end
end)

local credits = Instance.new("TextLabel")
credits.Name = "Credits"
credits.AnchorPoint = Vector2.new(1, 1)
credits.Position = UDim2.new(1, -32, 1, -7)
credits.Size = UDim2.fromOffset(190, 13)
credits.BackgroundTransparency = 1
credits.Font = Enum.Font.GothamMedium
credits.Text = "Credits: @cammyisafemboy"
credits.TextSize = 10
credits.TextColor3 = v117.SubText
credits.TextXAlignment = Enum.TextXAlignment.Right
credits.ZIndex = 40
credits.Parent = body

local searchBar = Instance.new("Frame")
searchBar.Name = "SearchBar"
searchBar.BackgroundColor3 = v117.Row
searchBar.BorderSizePixel = 0
searchBar.Position = UDim2.fromOffset(18, 110)
searchBar.Size = UDim2.new(1, -36, 0, 30)
searchBar.Parent = body

f27(searchBar, 9)
local v307 = f28(searchBar, v117.Stroke, 1, 0.3)

local input15 = Instance.new("TextBox")
input15.Name = "Input"
input15.BackgroundTransparency = 1
input15.Position = UDim2.fromOffset(12, 0)
input15.Size = UDim2.new(1, -24, 1, 0)
input15.Font = Enum.Font.Gotham
input15.PlaceholderText = "Search features..."
input15.PlaceholderColor3 = v117.SubText
input15.Text = ""
input15.TextColor3 = v117.Text
input15.TextSize = 13
input15.TextXAlignment = Enum.TextXAlignment.Left
input15.ClearTextOnFocus = false
input15.Parent = searchBar

input15.Focused:Connect(function()
  f26(v307, v118.Hover, { Color = color2, Transparency = 0.2 })
end)

input15.FocusLost:Connect(function()
  f26(v307, v118.Hover, { Color = v117.Stroke, Transparency = 0.3 })
end)

local function f99(p139)
  p139 = string.lower(p139 or "")

  if p139 == "" then
    f32(v164)
    return
  end

  for index26, value45 in ipairs(v163) do
    local v308 = v142[value45.Name]
    local v309 = v308 and string.lower(v308.name) or string.lower(value45.Name)
    value45.Visible = string.find(v309, p139, 1, true) ~= nil
  end

  scrollingFrame.CanvasPosition = Vector2.new(0, 0)
end

input15:GetPropertyChangedSignal("Text"):Connect(function() f99(input15.Text) end)

local function f100()
  local searchToggle = Instance.new("TextButton")
  searchToggle.Name = "SearchToggle"
  searchToggle.AnchorPoint = Vector2.new(1, 0)
  searchToggle.Position = UDim2.new(1, -18, 0, 72)
  searchToggle.Size = UDim2.fromOffset(34, 34)
  searchToggle.BackgroundColor3 = v117.Row
  searchToggle.Text = ""
  searchToggle.AutoButtonColor = false
  searchToggle.Parent = body

  f27(searchToggle, 10)
  f28(searchToggle, v117.Stroke, 1, 0.4)

  local frame50 = Instance.new("Frame")
  frame50.AnchorPoint = Vector2.new(0.5, 0.5)
  frame50.Position = UDim2.new(0.5, -2, 0.5, -2)
  frame50.Size = UDim2.fromOffset(13, 13)
  frame50.BackgroundTransparency = 1
  frame50.Parent = searchToggle

  f27(frame50, 7)
  local v310 = f28(frame50, color2, 2, 0)

  local frame51 = Instance.new("Frame")
  frame51.AnchorPoint = Vector2.new(0.5, 0.5)
  frame51.Position = UDim2.new(0.5, 7, 0.5, 7)
  frame51.Size = UDim2.fromOffset(2, 7)
  frame51.Rotation = 45
  frame51.BorderSizePixel = 0
  frame51.BackgroundColor3 = color2
  frame51.Parent = searchToggle

  f27(frame51, 1)
  local tweenInfo3 = TweenInfo.new(0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
  local v311 = { Position = UDim2.fromOffset(0, 148), Size = UDim2.new(1, 0, 1, -186) }
  local v312 = { Position = UDim2.fromOffset(0, 112), Size = UDim2.new(1, 0, 1, -150) }
  local v313 = false
  local count2 = 0

  local function f101(p140)
    v313 = p140
    count2 = count2 + 1
    local v314 = count2

    f26(v310, v118.Hover, { Color = p140 and v117.SubText or color2 })
    f26(frame51, v118.Hover, { BackgroundColor3 = p140 and v117.SubText or color2 })

    if p140 then
      input15.TextEditable = false
      input15.Text = ""

      f26(searchBar, tweenInfo3, { BackgroundTransparency = 1 })
      f26(v307, tweenInfo3, { Transparency = 1 })
      f26(input15, tweenInfo3, { TextTransparency = 1 })

      task.spawn(function()
        task.wait(0.1)

        if v314 ~= count2 then
          return
        end

        searchBar.Visible = false
        f26(scrollingFrame, v118.Smooth, v312)
      end)
    else
      searchBar.Visible = true
      f26(scrollingFrame, v118.Smooth, v311)

      task.spawn(function()
        task.wait(0.14)

        if v314 ~= count2 then
          return
        end

        input15.TextEditable = true

        f26(searchBar, tweenInfo3, { BackgroundTransparency = 0 })
        f26(v307, tweenInfo3, { Transparency = 0.3 })
        f26(input15, tweenInfo3, { TextTransparency = 0 })
      end)
    end
  end

  searchToggle.MouseButton1Click:Connect(function() f101(not v313) end)

  searchToggle.MouseEnter:Connect(function()
    f26(searchToggle, v118.Hover, { BackgroundColor3 = v117.RowHover })
  end)

  searchToggle.MouseLeave:Connect(function()
    f26(searchToggle, v118.Hover, { BackgroundColor3 = v117.Row })
  end)
end

f100()

local function f102()
  local v315 = 1
  local v316 = false

  local function f103()
    v316 = false
    local character11 = localPlayer.Character
    local humanoidRootPart8 = character11 and character11:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart8 then
      pcall(function()
        humanoidRootPart8.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        humanoidRootPart8.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
      end)
    end
  end

  local function f104(p141)
    if not p141 or v316 then
      return
    end

    local character12 = localPlayer.Character
    local humanoidRootPart9 = character12 and character12:FindFirstChild("HumanoidRootPart")

    if not (humanoidRootPart9 and p141.Character
      and p141.Character:FindFirstChild("HumanoidRootPart")) then
      return
    end

    v316 = true
    local cframe3 = humanoidRootPart9.CFrame

    task.spawn(function()
      for i10 = 1, math.floor(12 + v315 * 6) do
        if v119 or not v316 then
          break
        end

        local humanoidRootPart10 = p141.Character
          and p141.Character:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart10 then
          break
        end

        pcall(function()
          humanoidRootPart9.CFrame = humanoidRootPart10.CFrame
          humanoidRootPart9.AssemblyLinearVelocity = Vector3.new(9999, 9999, 9999) * v315
          humanoidRootPart9.AssemblyAngularVelocity = Vector3.new(9000, 9000, 9000) * v315
        end)

        runService.Heartbeat:Wait()
      end

      pcall(function()
        humanoidRootPart9.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        humanoidRootPart9.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

        if cframe3 then
          humanoidRootPart9.CFrame = cframe3
        end
      end)

      v316 = false
    end)
  end

  f47({
    key = "fling",
    name = "Fling",
    desc = "Teleport to a player and spin-fling them",
    color = Color3.fromRGB(255, 150, 60),
    short = "FLG",
    order = 21,
    onEnable = function() end,
    onDisable = f103,
    buildConfig = function(p142)
      f35(p142, {
        name = "Fling power",
        min = 1,
        max = 10,
        default = v315,
        decimals = 1,
        order = 1,
        onChange = function(p143) v315 = p143 end,
      })

      f41(p142, { name = "Stop fling", order = 2, onClick = function() f103() end })

      local textLabel30 = Instance.new("TextLabel")
      textLabel30.BackgroundTransparency = 1
      textLabel30.Size = UDim2.new(1, 0, 0, 18)
      textLabel30.Font = Enum.Font.GothamMedium
      textLabel30.Text = "Select a player to fling"
      textLabel30.TextColor3 = v117.SubText
      textLabel30.TextSize = 12
      textLabel30.TextXAlignment = Enum.TextXAlignment.Left
      textLabel30.LayoutOrder = 3
      textLabel30.Parent = p142

      local scrollingFrame4 = Instance.new("ScrollingFrame")
      scrollingFrame4.Size = UDim2.new(1, 0, 0, 116)
      scrollingFrame4.BackgroundTransparency = 1
      scrollingFrame4.BorderSizePixel = 0
      scrollingFrame4.ScrollBarThickness = 3
      scrollingFrame4.ScrollBarImageColor3 = color2
      scrollingFrame4.CanvasSize = UDim2.new()
      scrollingFrame4.AutomaticCanvasSize = Enum.AutomaticSize.Y
      scrollingFrame4.ScrollingDirection = Enum.ScrollingDirection.Y
      scrollingFrame4.LayoutOrder = 4
      scrollingFrame4.Parent = p142

      local uiListLayout11 = Instance.new("UIListLayout")
      uiListLayout11.Padding = UDim.new(0, 4)
      uiListLayout11.SortOrder = Enum.SortOrder.LayoutOrder
      uiListLayout11.Parent = scrollingFrame4

      local function f105()
        for index27, value46 in ipairs(scrollingFrame4:GetChildren()) do
          if value46:IsA("TextButton") or value46:IsA("TextLabel") then
            value46:Destroy()
          end
        end

        local count3 = 0

        for index28, value47 in ipairs(players:GetPlayers()) do
          if value47 ~= localPlayer then
            count3 = count3 + 1

            f41(scrollingFrame4, {
              name = value47.Name,
              order = count3,
              onClick = function() f104(value47) end,
            })
          end
        end

        if count3 == 0 then
          local textLabel31 = Instance.new("TextLabel")
          textLabel31.BackgroundTransparency = 1
          textLabel31.Size = UDim2.new(1, 0, 0, 24)
          textLabel31.Font = Enum.Font.Gotham
          textLabel31.Text = "No other players"
          textLabel31.TextColor3 = v117.SubText
          textLabel31.TextSize = 12
          textLabel31.Parent = scrollingFrame4
        end
      end

      f105()

      players.PlayerAdded:Connect(function()
        if not v119 then
          task.defer(f105)
        end
      end)

      players.PlayerRemoving:Connect(function()
        if not v119 then
          task.defer(f105)
        end
      end)

      f41(p142, { name = "Refresh list", order = 5, onClick = f105 })

      local textLabel32 = Instance.new("TextLabel")
      textLabel32.BackgroundTransparency = 1
      textLabel32.Size = UDim2.new(1, 0, 0, 30)
      textLabel32.Font = Enum.Font.Gotham
      textLabel32.Text = "Spam TP to a player to fling them to the farlands"
      textLabel32.TextColor3 = v117.SubText
      textLabel32.TextSize = 11
      textLabel32.TextWrapped = true
      textLabel32.TextXAlignment = Enum.TextXAlignment.Left
      textLabel32.LayoutOrder = 6
      textLabel32.Parent = p142
    end,
  })

  local v317 = false
  local v318 = 10
  local connect7 = nil
  local v319 = {}

  f47({
    key = "hitbox",
    name = "Hitbox Expander",
    desc = "Enlarge other players' hitboxes",
    color = Color3.fromRGB(180, 120, 255),
    short = "HB",
    order = 22,
    onEnable = function()
      v317 = true

      if connect7 then
        connect7:Disconnect()
      end

      connect7 = runService.Heartbeat:Connect(function()
        if v119 or not v317 then
          return
        end

        for index29, value48 in ipairs(players:GetPlayers()) do
          if value48 ~= localPlayer and value48.Character then
            local humanoidRootPart11 = value48.Character:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart11 then
              if v319[humanoidRootPart11] == nil then
                v319[humanoidRootPart11] = humanoidRootPart11.Size
              end

              pcall(function()
                humanoidRootPart11.Size = Vector3.new(v318, v318, v318)
                humanoidRootPart11.Transparency = 0.7
                humanoidRootPart11.CanCollide = false
              end)
            end
          end
        end
      end)
    end,
    onDisable = function()
      v317 = false

      if connect7 then
        connect7:Disconnect()
        connect7 = nil
      end

      for key22, value49 in pairs(v319) do
        if key22 and key22.Parent then
          pcall(function()
            key22.Size = value49
            key22.Transparency = 1
          end)
        end
      end

      v319 = {}
    end,
    buildConfig = function(p144)
      f35(p144, {
        name = "Hitbox size",
        min = 3,
        max = 30,
        default = v318,
        decimals = 0,
        order = 1,
        onChange = function(p145) v318 = p145 end,
      })
    end,
  })
end

f102()

f32(v164)
print("[StatsX] Loaded successfully into: " .. tostring(statsX.Parent))
