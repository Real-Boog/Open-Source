-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf

local rbxAnalyticsService = game:GetService("RbxAnalyticsService")
local httpService = game:GetService("HttpService")
local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")

local function f1()
  local function getHttpRequest()
    return http_request
  end

  local function getRequest()
    return request
  end

  local function getRequest2()
    return http and http.request
  end

  local function getRequest3()
    return (getgenv or function() return {} end)().request
  end

  local function getRequest4()
    return fluxus and fluxus.request
  end

  for _, value in ipairs({
    getRequest, getHttpRequest, getRequest2, function() return syn and syn.request end,
    getRequest4, getRequest3,
  }) do
    local ok, result = pcall(value)

    if ok and type(result) == "function" then
      return result
    end
  end

  return nil
end

local function f2()
  local ok2, hwid = pcall(gethwid)

  if ok2 and hwid and hwid ~= "" then
    return hwid
  end

  return tostring(rbxAnalyticsService:GetClientId()):gsub("-", "")
end

local localPlayer = players.LocalPlayer

local function f3()
  local ok3, v1 = pcall(readfile, "MerquryHub_Key.txt")

  if not ok3 or not v1 or v1 == "" then
    localPlayer:Kick("Error S1")
    return false
  end

  local gsub = tostring(v1):gsub("^[%s\n\r\t]+", ""):gsub("[%s\n\r\t]+$", "")
  local v2 = f1()

  if not v2 then
    localPlayer:Kick("Error S2")
    return false
  end

  local _, body = pcall(httpService.JSONEncode, httpService, { key_string = gsub, hwid = f2() })
  local v3 = 3

  while v3 > 0 do
    local ok4, result2 = pcall(v2, {
      Url = "https://sskgujtorprdelkjaupf.supabase.co/functions/v1/key-api?action=validate",
      Method = "POST",
      Headers = { ["Content-Type"] = "application/json" },
      Body = body,
    })

    if ok4 and result2 and type(result2) == "table" and result2.Body and result2.Body ~= "" then
      local ok5, data = pcall(httpService.JSONDecode, httpService, result2.Body)

      if ok5 and type(data) == "table" then
        if data.valid == true then
          return true
        end

        localPlayer:Kick("Error S3")
        return false
      end
    end

    v3 = v3 - 1
    task.wait(1)
  end

  localPlayer:Kick("Error S4")
  return false
end

if not f3() then
  return
end

local window = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))():CreateWindow({
  Title = "Merqury hub | Flick V1",
  Icon = "crown",
  Author = "by mh on discord",
  Folder = "MerquryFlick",
  Size = UDim2.fromOffset(580, 460),
  MinSize = Vector2.new(560, 350),
  MaxSize = Vector2.new(850, 560),
  Transparent = true,
  Theme = "Dark",
  Resizable = true,
  SideBarWidth = 200,
  BackgroundImageTransparency = 0.42,
  HideSearchBar = true,
  ScrollBarEnabled = false,
})

local currentCamera = workspace.CurrentCamera
local localPlayer2 = players.LocalPlayer
local getMouse = localPlayer2:GetMouse()
local remotes = replicatedStorage:WaitForChild("Remotes")

local function getIsDescendantOf(head)
  local position = currentCamera.CFrame.Position
  local position2 = head.Position

  local raycastParams = RaycastParams.new()
  raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
  raycastParams.FilterDescendantsInstances = { localPlayer2.Character, currentCamera }
  raycastParams.IgnoreWater = true

  local raycast = workspace:Raycast(position, position2 - position, raycastParams)
  return not raycast or raycast.Instance:IsDescendantOf(head.Parent)
end

local command = remotes:WaitForChild("Command")
local autoPlay = false
local v4 = 0.5
local v5 = false
local speed = 16
local flickBot = false
local flickFOV = 200
local visible = false
local targetFov = false
local aimbot = false
local e = Enum.KeyCode.E
local aimbotSpeed = 20
local v6 = 150
local visible2 = false
local aimbotMode = "Hold"
local flag = false
local radius = flickFOV
local visible3 = false
local color = Color3.fromRGB(255, 255, 255)
local color2 = Color3.fromRGB(255, 0, 0)
local targetFov2 = false
local enableEsp = false
local flag2 = false
local flag3 = false
local flag4 = false
local flag5 = false
local color3 = Color3.fromRGB(255, 255, 255)
local map = {}
local v7 = {}
local v8 = {}
local v9 = {}

local function f4(key)
  local line = Drawing.new("Line")
  line.Color = color3
  line.Thickness = 1

  v8[key] = line
end

local v10
local v11

local function makeCircle(color4)
  local circle = Drawing.new("Circle")
  circle.Thickness = 1
  circle.NumSides = 100
  circle.Filled = false
  circle.Transparency = 1
  circle.Color = color4 or Color3.fromRGB(255, 255, 255)
  circle.Visible = false

  return circle
end

v10 = makeCircle(color)
SilentFOVCircle = makeCircle(color)

local function f5(key2)
  if map[key2] then
    for _, value2 in pairs(map[key2]) do
      value2:Remove()
    end
  end

  if v7[key2] then
    v7[key2]:Remove()
  end

  if v8[key2] then
    v8[key2]:Remove()
  end

  if v9[key2] then
    v9[key2]:Destroy()
  end

  local v12 = v7
  local v13 = v8
  local v14 = v9
  map[key2] = nil
  v12[key2] = nil
  v13[key2] = nil
  v14[key2] = nil
end

v11 = makeCircle(color)

local function f6(key3)
  local v15 = {}

  for i = 1, 4 do
    local line2 = Drawing.new("Line")
    line2.Color = color3
    line2.Thickness = 1
    line2.Transparency = 1
    line2.Visible = false

    v15[i] = line2
  end

  map[key3] = v15
end

local function f7(flickFOV2, p1)
  local v16 = flickFOV2
  local getMouseLocation = userInputService:GetMouseLocation()
  local v17

  for _, value3 in ipairs(players:GetPlayers()) do
    if value3 ~= localPlayer2 and value3.Character then
      local head2 = value3.Character:FindFirstChild("Head")
      local humanoid = value3.Character:FindFirstChildOfClass("Humanoid")

      if head2 and humanoid and humanoid.Health > 0 then
        local screenPoint, onScreen = currentCamera:WorldToViewportPoint(head2.Position)

        if onScreen then
          local magnitude = (Vector2.new(screenPoint.X, screenPoint.Y)
            - getMouseLocation).Magnitude

          if magnitude < v16 and (not p1 or getIsDescendantOf(head2)) then
            v16 = magnitude
            v17 = head2
          end
        end
      end
    end
  end

  return v17
end

local function f8(key4)
  local text = Drawing.new("Text")
  text.Color = color3
  text.Size = 13
  text.Center = true
  text.Outline = true

  v7[key4] = text
end

local function makeHighlight(key5)
  if key5.Character then
    local highlight = Instance.new("Highlight")
    highlight.FillColor = color3
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
    highlight.OutlineTransparency = 0
    highlight.Parent = key5.Character

    v9[key5] = highlight
  end
end

local mainTab = window:Tab({ Title = "Main", Icon = "house" })
mainTab:Section({ Title = "Aimbot" })

mainTab:Toggle({
  Title = "Aimbot",
  Type = "Checkbox",
  Value = false,
  Callback = function(value4) aimbot = value4 end,
})

mainTab:Dropdown({
  Title = "Aimbot Mode",
  Desc = "",
  Values = { "Toggle", "Hold" },
  Value = "Hold",
  Callback = function(value5)
    aimbotMode = value5
    flag = false
  end,
})

mainTab:Keybind({
  Title = "Aimbot Key",
  Value = "E",
  Callback = function(value6) e = Enum.KeyCode[value6:upper()] or Enum.KeyCode.E end,
})

mainTab:Slider({
  Title = "Aimbot Speed",
  Step = 1,
  Value = { Min = 1, Max = 70, Default = 20 },
  Callback = function(value7) aimbotSpeed = value7 end,
})

mainTab:Toggle({
  Title = "Show Aimbot Fov",
  Type = "Checkbox",
  Value = false,
  Callback = function(value8) visible2 = value8 end,
})

mainTab:Slider({
  Title = "Aimbot Fov Size",
  Step = 1,
  Value = { Min = 40, Max = 420, Default = v6 },
  Callback = function(value9) v6 = value9 end,
})

mainTab:Section({ Title = "Silent Aim" })

mainTab:Toggle({
  Title = "Silent Aim",
  Type = "Checkbox",
  Value = false,
  Callback = function(value10) end,
})

mainTab:Toggle({
  Title = "Show Silent aim Fov",
  Type = "Checkbox",
  Value = false,
  Callback = function(value11) visible3 = value11 end,
})

mainTab:Slider({
  Title = "Silent aim Fov Size",
  Step = 1,
  Value = { Min = 40, Max = 420, Default = flickFOV },
  Callback = function(value12) radius = value12 end,
})

mainTab:Toggle({
  Title = "Target Fov",
  Desc = "if theres a target in the fov it turns red",
  Type = "Checkbox",
  Value = false,
  Callback = function(value13) targetFov2 = value13 end,
})

mainTab:Section({ Title = "Flickbot" })

mainTab:Toggle({
  Title = "FlickBot",
  Type = "Checkbox",
  Value = false,
  Callback = function(value14) flickBot = value14 end,
})

mainTab:Toggle({
  Title = "Show Flick FOV",
  Type = "Checkbox",
  Value = false,
  Callback = function(value15) visible = value15 end,
})

mainTab:Slider({
  Title = "Flick FOV",
  Step = 1,
  Value = { Min = 40, Max = 420, Default = flickFOV },
  Callback = function(value16) flickFOV = value16 end,
})

mainTab:Toggle({
  Title = "Target Fov",
  Desc = "if theres a target in the fov it turns red",
  Type = "Checkbox",
  Value = false,
  Callback = function(value17) targetFov = value17 end,
})

local visualsTab = window:Tab({ Title = "Visuals", Icon = "user", Locked = false })
visualsTab:Section({ Title = "Esp" })

visualsTab:Toggle({
  Title = "Enable Esp",
  Desc = "",
  Icon = "check",
  Type = "Checkbox",
  Value = false,
  Callback = function(value18) enableEsp = value18 end,
})

visualsTab:Dropdown({
  Title = "ESP Features",
  Desc = "",
  Values = { "Box", "Chams", "Distance", "Tracers" },
  Value = {},
  Multi = true,
  AllowNone = true,
  Callback = function(value19)
    flag2 = false
    flag5 = false
    flag3 = false
    flag4 = false

    for _, value20 in ipairs(value19) do
      if value20 == "Box" then
        flag2 = true
      elseif value20 == "Chams" then
        flag5 = true
      elseif value20 == "Distance" then
        flag3 = true
      elseif value20 == "Tracers" then
        flag4 = true
      end
    end
  end,
})

visualsTab:Colorpicker({
  Title = "Esp Color",
  Desc = "",
  Default = Color3.fromRGB(255, 255, 255),
  Transparency = 0,
  Locked = false,
  Callback = function(value21) color3 = value21 end,
})

visualsTab:Button({
  Title = "Reload Esp",
  Desc = "If the ESP gets bugged click this to reload it",
  Locked = false,
  Callback = function()
    for key6, _ in pairs(map) do
      f5(key6)
    end

    map = {}
    v7 = {}
    v8 = {}
    v9 = {}

    for _, value22 in ipairs(players:GetPlayers()) do
      if value22 ~= localPlayer2 and value22.Character then
        if flag2 then
          f6(value22)
        end

        if flag3 then
          f8(value22)
        end

        if flag4 then
          f4(value22)
        end

        if flag5 then
          makeHighlight(value22)
        end
      end
    end
  end,
})

local miscTab = window:Tab({ Title = "Misc", Icon = "zap", Locked = false })
miscTab:Section({ Title = "Misc" })

miscTab:Toggle({
  Title = "Auto Play",
  Type = "Checkbox",
  Value = false,
  Callback = function(value23) autoPlay = value23 end,
})

miscTab:Slider({
  Title = "Auto Play Delay",
  Step = 0.1,
  Value = { Min = 0, Max = 3, Default = 0.5 },
  Callback = function(value24) v4 = value24 end,
})

miscTab:Section({ Title = "WalkSpeed" })

miscTab:Toggle({
  Title = "Enable Walkspeed Changer",
  Type = "Checkbox",
  Value = false,
  Callback = function(value25)
    v5 = value25

    if v5 and localPlayer2.Character
      and localPlayer2.Character:FindFirstChildOfClass("Humanoid") then
      local character = localPlayer2.Character
      character:FindFirstChildOfClass("Humanoid").WalkSpeed = speed
    elseif not v5 and localPlayer2.Character
      and localPlayer2.Character:FindFirstChildOfClass("Humanoid") then
      local character2 = localPlayer2.Character
      character2:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
    end
  end,
})

miscTab:Slider({
  Title = "Speed",
  Step = 1,
  Value = { Min = 16, Max = 24, Default = 16 },
  Callback = function(value26)
    speed = value26

    if v5 and localPlayer2.Character
      and localPlayer2.Character:FindFirstChildOfClass("Humanoid") then
      local character3 = localPlayer2.Character
      character3:FindFirstChildOfClass("Humanoid").WalkSpeed = speed
    end
  end,
})

miscTab:Keybind({
  Title = "Menu Keybind",
  Desc = "",
  Value = "RightShift",
  Callback = function(value27) window:SetToggleKey(Enum.KeyCode[value27]) end,
})

runService.RenderStepped:Connect(function()
  local getMouseLocation2 = userInputService:GetMouseLocation()

  v10.Visible = visible
  v10.Position = getMouseLocation2
  v10.Radius = flickFOV

  if targetFov then
    v10.Color = f7(flickFOV, true) and color2 or color
  else
    v10.Color = color
  end

  SilentFOVCircle.Visible = visible3
  SilentFOVCircle.Position = getMouseLocation2
  SilentFOVCircle.Radius = radius

  if targetFov2 then
    SilentFOVCircle.Color = f7(radius, true) and color2 or color
  else
    SilentFOVCircle.Color = color
  end

  v11.Visible = visible2
  v11.Position = getMouseLocation2
  v11.Radius = v6

  if aimbot
    and (aimbotMode == "Hold" and userInputService:IsKeyDown(e)
      or aimbotMode == "Toggle" and flag) then
    local v18 = f7(v6, false)

    if v18 then
      local position3 = currentCamera.CFrame.Position
      local cframe = CFrame.new(position3, v18.Position)

      currentCamera.CFrame = currentCamera.CFrame:Lerp(
        cframe, math.clamp(aimbotSpeed / 100, 0, 1)
      )
    end
  end

  if enableEsp then
    for _, value28 in ipairs(players:GetPlayers()) do
      if value28 ~= localPlayer2 and value28.Character then
        local character4 = value28.Character
        local humanoid2 = character4:FindFirstChildOfClass("Humanoid")
        local humanoidRootPart = character4:FindFirstChild("HumanoidRootPart")

        if humanoid2 and humanoid2.Health > 0 and humanoidRootPart then
          local huge = math.huge
          local huge2 = math.huge
          local lowest = huge
          local huge3 = math.huge
          local highest = -math.huge
          local highest2 = -huge3
          local flag6 = false

          for _, value29 in ipairs({
            "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg",
          }) do
            local findFirstChild = character4:FindFirstChild(value29)

            if findFirstChild and findFirstChild:IsA("BasePart") then
              local cframe2 = findFirstChild.CFrame
              local v19 = findFirstChild.Size / 2

              for _, value30 in ipairs({
                Vector3.new(v19.X, v19.Y, v19.Z), Vector3.new(-v19.X, v19.Y, v19.Z),
                Vector3.new(v19.X, -v19.Y, v19.Z), Vector3.new(-v19.X, -v19.Y, v19.Z),
                Vector3.new(v19.X, v19.Y, -v19.Z), Vector3.new(-v19.X, v19.Y, -v19.Z),
                Vector3.new(v19.X, -v19.Y, -v19.Z), Vector3.new(-v19.X, -v19.Y, -v19.Z),
              }) do
                local screenPoint2, onScreen2 = currentCamera:WorldToViewportPoint((cframe2
                  * CFrame.new(value30)).Position)

                if onScreen2 then
                  flag6 = true
                end

                lowest = math.min(lowest, screenPoint2.X)
                huge2 = math.min(huge2, screenPoint2.Y)
                highest2 = math.max(highest2, screenPoint2.X)
                highest = math.max(highest, screenPoint2.Y)
              end
            end
          end

          if flag6 then
            if flag2 then
              if not map[value28] then
                f6(value28)
              end

              local map2 = map[value28]
              local v20 = map2[1]
              local v21 = map2[1]
              local vector = Vector2.new(lowest, huge2)
              local vector2 = Vector2.new(highest2, huge2)
              v20.From = vector
              v21.To = vector2
              local v22 = map2[2]
              local v23 = map2[2]
              local vector3 = Vector2.new(highest2, huge2)
              local vector4 = Vector2.new(highest2, highest)
              v22.From = vector3
              v23.To = vector4
              local v24 = map2[3]
              local v25 = map2[3]
              local vector5 = Vector2.new(highest2, highest)
              local vector6 = Vector2.new(lowest, highest)
              v24.From = vector5
              v25.To = vector6
              local v26 = map2[4]
              local v27 = map2[4]
              local vector7 = Vector2.new(lowest, highest)
              local vector8 = Vector2.new(lowest, huge2)
              v26.From = vector7
              v27.To = vector8

              for _, value31 in pairs(map2) do
                value31.Visible = true
                value31.Color = color3
              end
            elseif map[value28] then
              for _, value32 in pairs(map[value28]) do
                value32.Visible = false
              end
            end

            if flag3 then
              if not v7[value28] then
                f8(value28)
              end

              local rounded = math.floor((currentCamera.CFrame.Position
                - humanoidRootPart.Position).Magnitude)

              v7[value28].Text = rounded .. "m"
              v7[value28].Position = Vector2.new((lowest + highest2) / 2, highest + 5)
              v7[value28].Visible = true
              v7[value28].Color = color3
            elseif v7[value28] then
              v7[value28].Visible = false
            end

            if flag4 then
              if not v8[value28] then
                f4(value28)
              end

              v8[value28].From = Vector2.new(
                currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y
              )

              v8[value28].To = Vector2.new((lowest + highest2) / 2, highest)
              v8[value28].Visible = true
              v8[value28].Color = color3
            elseif v8[value28] then
              v8[value28].Visible = false
            end

            if flag5 then
              if not v9[value28] then
                makeHighlight(value28)
              end
            elseif v9[value28] then
              v9[value28]:Destroy()
              v9[value28] = nil
            end
          else
            f5(value28)
          end
        else
          f5(value28)
        end
      else
        f5(value28)
      end
    end
  else
    for key7, _ in pairs(map) do
      f5(key7)
    end
  end
end)

getMouse.Button1Down:Connect(function()
  if not flickBot then
    return
  end

  local v28 = f7(flickFOV, true)

  if not v28 then
    return
  end

  local cframe3 = currentCamera.CFrame
  currentCamera.CFrame = CFrame.new(currentCamera.CFrame.Position, v28.Position)
  task.delay(0, function() currentCamera.CFrame = cframe3 end)
end)

task.spawn(function()
  while true do
    task.wait(3)

    if enableEsp then
      for key8, _ in pairs(map) do
        pcall(f5, key8)
      end

      map = {}
      v7 = {}
      v8 = {}
      v9 = {}

      for _, value33 in ipairs(players:GetPlayers()) do
        if value33 ~= localPlayer2 and value33.Character then
          pcall(function()
            if flag2 then
              f6(value33)
            end

            if flag3 then
              f8(value33)
            end

            if flag4 then
              f4(value33)
            end

            if flag5 then
              makeHighlight(value33)
            end
          end)
        end
      end
    end
  end
end)

localPlayer2.CharacterAdded:Connect(function(character5)
  character5:WaitForChild("Humanoid")

  if v5 then
    character5.Humanoid.WalkSpeed = speed
  end
end)

userInputService.InputBegan:Connect(function(input, p2)
  if p2 then
    return
  end

  if input.KeyCode == e and aimbotMode == "Toggle" then
    flag = not flag
  end
end)

spawn(function()
  while true do
    wait(0.1)

    if autoPlay then
      local playerGui = localPlayer2:FindFirstChild("PlayerGui")

      if playerGui and playerGui:FindFirstChild("Sp") then
        pcall(function() command:FireServer("Play") end)
        wait(v4)
      end
    end
  end
end)
