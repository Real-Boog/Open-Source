-- this is for da hood.

local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local guiService = game:GetService("GuiService")
local workspaceService = game:GetService("Workspace")
local httpService = game:GetService("HttpService")
local statsService = game:GetService("Stats")
local rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local localPlayer = players.LocalPlayer
local getMouse = localPlayer:GetMouse()
local currentCamera = workspace.CurrentCamera
local y = guiService:GetGuiInset().Y

getgenv().Silent = {
  Setting = {
    IsTargetting = false,
    AutoPrediction = true,
    ManualPrediction = 0.17,
    InAirPrediction = true,
    InAirPredValue = 0.03,
    ViewPrediction = true,
    TargetPart = "HumanoidRootPart",
    WallCheck = true,
    FOV = { Radius = 360, Visible = true, Color = Color3.fromRGB(230, 230, 250) },
  },
}

local triggerbotUI = false
local v1 = false
local camlockUI = false
local silentAimUI = false
local v2 = false
local v3 = false
local weaponWhitelist = false
local v4 = { "doublebarrel", "revolver", "tacticalshotgun", "shotgun", "uzi" }
local camlockTargetPart = "Head"
local camlockAutoPred = true
local camlockManualPred = 0.17
local v5 = { ESP = {}, Skeleton = {} }
local v6 = {}

local v7 = {
  Enabled = false,
  TeamCheck = false,
  ShowTeam = false,
  VisibilityCheck = true,
  BoxESP = false,
  BoxStyle = "Corner",
  BoxOutline = true,
  BoxFilled = false,
  BoxFillTransparency = 0.5,
  BoxThickness = 1,
  TracerESP = false,
  TracerOrigin = "Bottom",
  TracerStyle = "Line",
  TracerThickness = 1,
  HealthESP = false,
  HealthStyle = "Bar",
  HealthBarSide = "Left",
  HealthTextSuffix = "HP",
  NameESP = false,
  NameMode = "DisplayName",
  ShowDistance = true,
  DistanceUnit = "studs",
  TextSize = 14,
  TextFont = 2,
  RainbowSpeed = 1,
  MaxDistance = 1000,
  RefreshRate = 0.0069444444444444,
  Snaplines = false,
  SnaplineStyle = "Straight",
  RainbowEnabled = false,
  RainbowBoxes = false,
  RainbowTracers = false,
  RainbowText = false,
  ChamsEnabled = false,
  ChamsOutlineColor = Color3.fromRGB(255, 255, 255),
  ChamsFillColor = Color3.fromRGB(255, 0, 0),
  ChamsOccludedColor = Color3.fromRGB(150, 0, 0),
  ChamsTransparency = 0.5,
  ChamsOutlineTransparency = 0,
  ChamsOutlineThickness = 0.1,
  SkeletonESP = false,
  SkeletonColor = Color3.fromRGB(255, 255, 255),
  SkeletonThickness = 1.5,
  SkeletonTransparency = 1,
  HealthTextFormat = "Number",
}

local v8 = {
  Enemy = Color3.fromRGB(255, 25, 25),
  Ally = Color3.fromRGB(25, 255, 25),
  Neutral = Color3.fromRGB(255, 255, 255),
  Selected = Color3.fromRGB(255, 210, 0),
  Health = Color3.fromRGB(0, 255, 0),
  Distance = Color3.fromRGB(200, 200, 200),
  Rainbow = nil,
}

local window = rayfield:CreateWindow({
  Name = "Adonix.cc | Premium",
  LoadingTitle = "Made by ryuk | Cracked by Boog X",
  LoadingSubtitle = "by Adonix Utilities",
  ConfigurationSaving = { Enabled = false, FolderName = nil, FileName = "HubConfig" },
  Discord = { Enabled = false },
  KeySystem = false,
})

local triggerbotTab = window:CreateTab("Triggerbot", 4483362458)
local camlockTab = window:CreateTab("Camlock", 4483362458)
local espTab = window:CreateTab("ESP", 4483362458)
local silentAimTab = window:CreateTab("Silent Aim", 4483362458)
local settingsTab = window:CreateTab("Settings", 4483362458)
local creditsTab = window:CreateTab("Credits", 4483362458)

local enableTriggerbotToggle = triggerbotTab:CreateToggle({
  Name = "Enable Triggerbot",
  CurrentValue = false,
  Flag = "TriggerbotToggle",
  Callback = function(value)
    triggerbotUI = value

    if not triggerbotUI then
      v1 = false

      if v3 then
        mouse1release()
        v3 = false
      end
    end

    if not v2 then
      rayfield:Notify({
        Title = "Triggerbot",
        Content = value and "Enabled" or "Disabled",
        Duration = 3,
      })
    end
  end,
})

local triggerbotKeybindKeybind = triggerbotTab:CreateKeybind({
  Name = "Triggerbot Keybind",
  CurrentKeybind = "E",
  HoldToInteract = false,
  Flag = "TriggerbotKeybindUI",
  Callback = function()
    if triggerbotUI then
      v1 = not v1

      if not v1 and v3 then
        mouse1release()
        v3 = false
      end

      if not v2 then
        rayfield:Notify({
          Title = "Triggerbot",
          Content = v1 and "Active" or "Inactive",
          Duration = 2,
        })
      end
    elseif not v2 then
      rayfield:Notify({
        Title = "Error",
        Content = "Enable Triggerbot in UI first!",
        Duration = 3,
      })
    end
  end,
})

local knifeCheckToggle = triggerbotTab:CreateToggle({
  Name = "Knife Check",
  CurrentValue = false,
  Flag = "TriggerbotWeaponWhitelist",
  Callback = function(value2)
    weaponWhitelist = value2

    if not v2 then
      rayfield:Notify({
        Title = "Knife Check",
        Content = value2 and "Enabled" or "Disabled",
        Duration = 3,
      })
    end
  end,
})

local v9

local enableCamlockToggle = camlockTab:CreateToggle({
  Name = "Enable Camlock",
  CurrentValue = false,
  Flag = "CamlockToggle",
  Callback = function(value3)
    camlockUI = value3

    if not camlockUI then
      v9 = nil
    end

    if not v2 then
      rayfield:Notify({
        Title = "Camlock",
        Content = value3 and "Enabled" or "Disabled",
        Duration = 3,
      })
    end
  end,
})

local aimPartDropdown = camlockTab:CreateDropdown({
  Name = "Aim Part",
  Options = { "Head", "HumanoidRootPart", "UpperTorso", "LowerTorso" },
  CurrentOption = camlockTargetPart,
  Flag = "CamlockAimPart",
  Callback = function(value4) camlockTargetPart = value4 end,
})

local toggle = camlockTab:CreateToggle({
  Name = "Auto Prediction (1 ping = 1 pred)",
  CurrentValue = camlockAutoPred,
  Flag = "CamlockAutoPred",
  Callback = function(value5) camlockAutoPred = value5 end,
})

local manualPredictionSlider = camlockTab:CreateSlider({
  Name = "Manual Prediction",
  Range = { 0.001, 1 },
  Increment = 0.001,
  Suffix = "s",
  CurrentValue = camlockManualPred,
  Flag = "CamlockManualPred",
  Callback = function(value6) camlockManualPred = value6 end,
})

local function f1()
  local huge = math.huge
  local vector = Vector2.new(currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y / 2)
  local v10

  for key, value7 in pairs(players:GetPlayers()) do
    if value7 ~= localPlayer and value7.Character then
      local findFirstChild = value7.Character:FindFirstChild(camlockTargetPart)

      local humanoidRootPart = findFirstChild
      humanoidRootPart = findFirstChild or value7.Character:FindFirstChild("HumanoidRootPart")

      local humanoid = value7.Character:FindFirstChildOfClass("Humanoid")

      if humanoidRootPart and humanoid and humanoid.Health > 0 then
        local v11, v12 = currentCamera:WorldToViewportPoint(humanoidRootPart.Position)

        if v12 then
          local magnitude = (Vector2.new(v11.X, v11.Y) - vector).Magnitude

          if magnitude < huge then
            v10 = humanoidRootPart
            huge = magnitude
          end
        end
      end
    end
  end

  return v10
end

local lockKeybindKeybind = camlockTab:CreateKeybind({
  Name = "Lock Keybind",
  CurrentKeybind = "Q",
  HoldToInteract = false,
  Flag = "CamlockKeybindUI",
  Callback = function()
    if camlockUI then
      if v9 then
        v9 = nil

        if not v2 then
          rayfield:Notify({ Title = "Camlock", Content = "Unlocked", Duration = 2 })
        end
      else
        local v13 = f1()

        if v13 then
          v9 = v13
          local name = players:GetPlayerFromCharacter(v9.Parent).Name

          if not v2 then
            rayfield:Notify({
              Title = "Camlock",
              Content = "Locked onto: " .. name,
              Duration = 2,
            })
          end
        elseif not v2 then
          rayfield:Notify({
            Title = "Camlock",
            Content = "No player found on screen",
            Duration = 2,
          })
        end
      end
    elseif not v2 then
      rayfield:Notify({ Title = "Error", Content = "Enable Camlock in UI first!", Duration = 3 })
    end
  end,
})

local function f2(p1)
  if p1 == localPlayer then
    return
  else
    local v14 = {
      TopLeft = Drawing.new("Line"),
      TopRight = Drawing.new("Line"),
      BottomLeft = Drawing.new("Line"),
      BottomRight = Drawing.new("Line"),
      Left = Drawing.new("Line"),
      Right = Drawing.new("Line"),
      Top = Drawing.new("Line"),
      Bottom = Drawing.new("Line"),
    }

    for key2, value8 in pairs(v14) do
      value8.Visible = false
      value8.Color = v8.Enemy
      value8.Thickness = v7.BoxThickness
    end

    local line = Drawing.new("Line")
    line.Visible = false
    line.Color = v8.Enemy
    line.Thickness = v7.TracerThickness

    local v15 = {
      Outline = Drawing.new("Square"),
      Fill = Drawing.new("Square"),
      Text = Drawing.new("Text"),
    }

    for key3, value9 in pairs(v15) do
      value9.Visible = false

      if value9 == v15.Fill then
        value9.Color = v8.Health
        value9.Filled = true
      elseif value9 == v15.Text then
        value9.Center = true
        value9.Size = v7.TextSize
        value9.Color = v8.Health
        value9.Font = v7.TextFont
      end
    end

    local v16 = { Name = Drawing.new("Text"), Distance = Drawing.new("Text") }

    for key4, value10 in pairs(v16) do
      value10.Visible = false
      value10.Center = true
      value10.Size = v7.TextSize
      value10.Color = v8.Enemy
      value10.Font = v7.TextFont
      value10.Outline = true
    end

    local line2 = Drawing.new("Line")
    line2.Visible = false
    line2.Color = v8.Enemy
    line2.Thickness = 1

    local highlight = Instance.new("Highlight")
    highlight.FillColor = v7.ChamsFillColor
    highlight.OutlineColor = v7.ChamsOutlineColor
    highlight.FillTransparency = v7.ChamsTransparency
    highlight.OutlineTransparency = v7.ChamsOutlineTransparency
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Enabled = v7.ChamsEnabled

    v6[p1] = highlight

    local v17 = {
      Head = Drawing.new("Line"),
      Neck = Drawing.new("Line"),
      UpperSpine = Drawing.new("Line"),
      LowerSpine = Drawing.new("Line"),
      LeftShoulder = Drawing.new("Line"),
      LeftUpperArm = Drawing.new("Line"),
      LeftLowerArm = Drawing.new("Line"),
      LeftHand = Drawing.new("Line"),
      RightShoulder = Drawing.new("Line"),
      RightUpperArm = Drawing.new("Line"),
      RightLowerArm = Drawing.new("Line"),
      RightHand = Drawing.new("Line"),
      LeftHip = Drawing.new("Line"),
      LeftUpperLeg = Drawing.new("Line"),
      LeftLowerLeg = Drawing.new("Line"),
      LeftFoot = Drawing.new("Line"),
      RightHip = Drawing.new("Line"),
      RightUpperLeg = Drawing.new("Line"),
      RightLowerLeg = Drawing.new("Line"),
      RightFoot = Drawing.new("Line"),
    }

    for key5, value11 in pairs(v17) do
      value11.Visible = false
      value11.Color = v7.SkeletonColor
      value11.Thickness = v7.SkeletonThickness
      value11.Transparency = v7.SkeletonTransparency
    end

    v5.Skeleton[p1] = v17

    v5.ESP[p1] = {
      Box = v14,
      Tracer = line,
      HealthBar = v15,
      Info = v16,
      Snapline = line2,
    }

    return
  end
end

local function f3(p2)
  local v18 = v5.ESP[p2]

  if v18 then
    for key6, value12 in pairs(v18.Box) do
      value12:Remove()
    end

    v18.Tracer:Remove()

    for key7, value13 in pairs(v18.HealthBar) do
      value13:Remove()
    end

    for key8, value14 in pairs(v18.Info) do
      value14:Remove()
    end

    v18.Snapline:Remove()
    v5.ESP[p2] = nil
  end

  local v19 = v6[p2]

  if v19 then
    v19:Destroy()
    v6[p2] = nil
  end

  local v20 = v5.Skeleton[p2]

  if v20 then
    for key9, value15 in pairs(v20) do
      value15:Remove()
    end

    v5.Skeleton[p2] = nil
  end
end

local function f4()
  for index, value16 in ipairs(players:GetPlayers()) do
    local v21 = v5.ESP[value16]

    if v21 then
      for key10, value17 in pairs(v21.Box) do
        value17.Visible = false
      end

      v21.Tracer.Visible = false

      for key11, value18 in pairs(v21.HealthBar) do
        value18.Visible = false
      end

      for key12, value19 in pairs(v21.Info) do
        value19.Visible = false
      end

      v21.Snapline.Visible = false
    end

    local v22 = v5.Skeleton[value16]

    if v22 then
      for key13, value20 in pairs(v22) do
        value20.Visible = false
      end
    end
  end
end

local function f5(p3)
  local v23, ally

  if v7.RainbowEnabled then
    if v7.RainbowBoxes and v7.BoxESP then
      return v8.Rainbow
    end

    if v7.RainbowTracers and v7.TracerESP then
      return v8.Rainbow
    end

    if v7.RainbowText and (v7.NameESP or v7.HealthESP) then
      return v8.Rainbow
    end

    v23 = p3.Team == localPlayer.Team

    ally = v23
    ally = v23 and v8.Ally

    return ally or v8.Enemy
  end

  v23 = p3.Team == localPlayer.Team

  ally = v23
  ally = v23 and v8.Ally

  return ally or v8.Enemy
end

local function f6()
  for index2, value21 in ipairs(players:GetPlayers()) do
    f3(value21)
  end

  v5.ESP = {}
  v5.Skeleton = {}

  v6 = {}
end

local f7

local function f8(p4)
  local tr, br, tr2, br2, tl, bl, tl2, bl2, f9, v24, v25

  if not v7.Enabled then
    return
  else
    local v26 = v5.ESP[p4]

    if not v26 then
      return
    else
      local character = p4.Character
      local humanoidRootPart2 = character and character:FindFirstChild("HumanoidRootPart")
      local humanoid2 = character and character:FindFirstChild("Humanoid")

      if not character or not humanoidRootPart2 or not humanoid2 or humanoid2.Health <= 0 then
        for key14, value22 in pairs(v26.Box) do
          value22.Visible = false
        end

        v26.Tracer.Visible = false

        for key15, value23 in pairs(v26.HealthBar) do
          value23.Visible = false
        end

        for key16, value24 in pairs(v26.Info) do
          value24.Visible = false
        end

        v26.Snapline.Visible = false
        local v27 = v5.Skeleton[p4]

        if v27 then
          for key17, value25 in pairs(v27) do
            value25.Visible = false
          end
        end

        return
      else
        local v28, v29 = currentCamera:WorldToViewportPoint(humanoidRootPart2.Position)

        if not v29
          or (humanoidRootPart2.Position - currentCamera.CFrame.Position).Magnitude
            > v7.MaxDistance then
          for key18, value26 in pairs(v26.Box) do
            value26.Visible = false
          end

          v26.Tracer.Visible = false

          for key19, value27 in pairs(v26.HealthBar) do
            value27.Visible = false
          end

          for key20, value28 in pairs(v26.Info) do
            value28.Visible = false
          end

          v26.Snapline.Visible = false
          return
        end

        if v7.TeamCheck and p4.Team == localPlayer.Team and not v7.ShowTeam then
          for key21, value29 in pairs(v26.Box) do
            value29.Visible = false
          end

          v26.Tracer.Visible = false

          for key22, value30 in pairs(v26.HealthBar) do
            value30.Visible = false
          end

          for key23, value31 in pairs(v26.Info) do
            value31.Visible = false
          end

          v26.Snapline.Visible = false
          return
        else
          local color = f5(p4)
          local getExtentsSize = character:GetExtentsSize()
          local cframe = humanoidRootPart2.CFrame

          local v30, v31 = currentCamera:WorldToViewportPoint((cframe * CFrame.new(
            0, getExtentsSize.Y / 2, 0
          )).Position)

          local v32, v33 = currentCamera:WorldToViewportPoint((cframe * CFrame.new(
            0, -getExtentsSize.Y / 2, 0
          )).Position)

          if not v31 or not v33 then
            for key24, value32 in pairs(v26.Box) do
              value32.Visible = false
            end

            return
          else
            local v34 = v32.Y - v30.Y
            local v35 = v34 * 0.65
            local vector2 = Vector2.new(v30.X - v35 / 2, v30.Y)
            local vector3 = Vector2.new(v35, v34)

            for key25, value33 in pairs(v26.Box) do
              value33.Visible = false
            end

            if v7.BoxESP then
              if v7.BoxStyle == "ThreeD" then
                local v36 = currentCamera
                local v37 = currentCamera
                local v38 = currentCamera
                local v39 = currentCamera

                local v40 = {
                  TL = v36:WorldToViewportPoint((cframe * CFrame.new(
                    -getExtentsSize.X / 2, getExtentsSize.Y / 2, -getExtentsSize.Z / 2
                  )).Position),
                  TR = v37:WorldToViewportPoint((cframe * CFrame.new(
                    getExtentsSize.X / 2, getExtentsSize.Y / 2, -getExtentsSize.Z / 2
                  )).Position),
                  BL = v38:WorldToViewportPoint((cframe * CFrame.new(
                    -getExtentsSize.X / 2, -getExtentsSize.Y / 2, -getExtentsSize.Z / 2
                  )).Position),
                  BR = v39:WorldToViewportPoint((cframe * CFrame.new(
                    getExtentsSize.X / 2, -getExtentsSize.Y / 2, -getExtentsSize.Z / 2
                  )).Position),
                }

                local v41 = currentCamera
                local v42 = currentCamera
                local v43 = currentCamera
                local v44 = currentCamera

                local v45 = {
                  TL = v41:WorldToViewportPoint((cframe * CFrame.new(
                    -getExtentsSize.X / 2, getExtentsSize.Y / 2, getExtentsSize.Z / 2
                  )).Position),
                  TR = v42:WorldToViewportPoint((cframe * CFrame.new(
                    getExtentsSize.X / 2, getExtentsSize.Y / 2, getExtentsSize.Z / 2
                  )).Position),
                  BL = v43:WorldToViewportPoint((cframe * CFrame.new(
                    -getExtentsSize.X / 2, -getExtentsSize.Y / 2, getExtentsSize.Z / 2
                  )).Position),
                  BR = v44:WorldToViewportPoint((cframe * CFrame.new(
                    getExtentsSize.X / 2, -getExtentsSize.Y / 2, getExtentsSize.Z / 2
                  )).Position),
                }

                if not (v40.TL.Z > 0 and v40.TR.Z > 0 and v40.BL.Z > 0 and v40.BR.Z > 0
                  and v45.TL.Z > 0 and v45.TR.Z > 0 and v45.BL.Z > 0 and v45.BR.Z > 0) then
                  for key26, value34 in pairs(v26.Box) do
                    value34.Visible = false
                  end

                  return
                else
                  function f9(p5)
                    return Vector2.new(p5.X, p5.Y)
                  end

                  tl = f9(v40.TL)
                  tr = f9(v40.TR)

                  v40.TL = tl
                  v40.TR = tr

                  bl = f9(v40.BL)
                  br = f9(v40.BR)

                  v40.BL = bl
                  v40.BR = br

                  tl2 = f9(v45.TL)
                  tr2 = f9(v45.TR)

                  v45.TL = tl2
                  v45.TR = tr2

                  bl2 = f9(v45.BL)
                  br2 = f9(v45.BR)

                  v45.BL = bl2
                  v45.BR = br2

                  v26.Box.TopLeft.From = v40.TL
                  v26.Box.TopLeft.To = v40.TR
                  v26.Box.TopLeft.Visible = true
                  v26.Box.TopRight.From = v40.TR
                  v26.Box.TopRight.To = v40.BR
                  v26.Box.TopRight.Visible = true
                  v26.Box.BottomLeft.From = v40.BL
                  v26.Box.BottomLeft.To = v40.BR
                  v26.Box.BottomLeft.Visible = true
                  v26.Box.BottomRight.From = v40.TL
                  v26.Box.BottomRight.To = v40.BL
                  v26.Box.BottomRight.Visible = true
                  v26.Box.Left.From = v45.TL
                  v26.Box.Left.To = v45.TR
                  v26.Box.Left.Visible = true
                  v26.Box.Right.From = v45.TR
                  v26.Box.Right.To = v45.BR
                  v26.Box.Right.Visible = true
                  v26.Box.Top.From = v45.BL
                  v26.Box.Top.To = v45.BR
                  v26.Box.Top.Visible = true
                  v26.Box.Bottom.From = v45.TL
                  v26.Box.Bottom.To = v45.BL
                  v26.Box.Bottom.Visible = true

                  v25 = {
                    Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line"),
                    Drawing.new("Line"),
                  }

                  v25[1].From = v40.TL
                  v25[1].To = v45.TL
                  v25[1].Visible = true
                  v25[1].Color = color
                  v25[1].Thickness = v7.BoxThickness
                  v25[2].From = v40.TR
                  v25[2].To = v45.TR
                  v25[2].Visible = true
                  v25[2].Color = color
                  v25[2].Thickness = v7.BoxThickness
                  v25[3].From = v40.BL
                  v25[3].To = v45.BL
                  v25[3].Visible = true
                  v25[3].Color = color
                  v25[3].Thickness = v7.BoxThickness
                  v25[4].From = v40.BR
                  v25[4].To = v45.BR
                  v25[4].Visible = true
                  v25[4].Color = color
                  v25[4].Thickness = v7.BoxThickness

                  task.spawn(function()
                    task.wait()

                    for index3, value35 in ipairs(v25) do
                      value35:Remove()
                    end
                  end)

                  for key27, value36 in pairs(v26.Box) do
                    if value36.Visible then
                      value36.Color = color
                      value36.Thickness = v7.BoxThickness
                    end
                  end

                  ::L14752011::

                  if v7.TracerESP then
                    v26.Tracer.From = f7()
                    v26.Tracer.To = Vector2.new(v28.X, v28.Y)
                    v26.Tracer.Color = color
                    v26.Tracer.Visible = true
                  else
                    v26.Tracer.Visible = false
                  end

                  if v7.HealthESP then
                    local v46 = humanoid2.Health / humanoid2.MaxHealth
                    local v47 = v34 * 0.8
                    local vector4 = Vector2.new(vector2.X - 4 - 2, vector2.Y + (v34 - v47) / 2)

                    v26.HealthBar.Outline.Size = Vector2.new(4, v47)
                    v26.HealthBar.Outline.Position = vector4
                    v26.HealthBar.Outline.Visible = true
                    v26.HealthBar.Fill.Size = Vector2.new(2, v47 * v46)

                    v26.HealthBar.Fill.Position = Vector2.new(
                      vector4.X + 1, vector4.Y + v47 * (1 - v46)
                    )

                    v26.HealthBar.Fill.Color = Color3.fromRGB(255 - 255 * v46, 255 * v46, 0)
                    v26.HealthBar.Fill.Visible = true

                    if v7.HealthStyle == "Both" or v7.HealthStyle == "Text" then
                      v26.HealthBar.Text.Text = math.floor(humanoid2.Health)
                        .. v7.HealthTextSuffix

                      v26.HealthBar.Text.Position = Vector2.new(
                        vector4.X + 4 + 2, vector4.Y + v47 / 2
                      )

                      v26.HealthBar.Text.Visible = true
                    else
                      v26.HealthBar.Text.Visible = false
                    end
                  else
                    for key28, value37 in pairs(v26.HealthBar) do
                      value37.Visible = false
                    end
                  end

                  if v7.NameESP then
                    v26.Info.Name.Text = p4.DisplayName
                    v26.Info.Name.Position = Vector2.new(vector2.X + v35 / 2, vector2.Y - 20)
                    v26.Info.Name.Color = color
                    v26.Info.Name.Visible = true
                  else
                    v26.Info.Name.Visible = false
                  end

                  if v7.Snaplines then
                    v26.Snapline.From = Vector2.new(
                      currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y
                    )

                    v26.Snapline.To = Vector2.new(v28.X, v28.Y)
                    v26.Snapline.Color = color
                    v26.Snapline.Visible = true
                  else
                    v26.Snapline.Visible = false
                  end

                  v24 = v6[p4]

                  if v24 then
                    if v7.ChamsEnabled and character then
                      v24.Parent = character
                      v24.FillColor = v7.ChamsFillColor
                      v24.OutlineColor = v7.ChamsOutlineColor
                      v24.FillTransparency = v7.ChamsTransparency
                      v24.OutlineTransparency = v7.ChamsOutlineTransparency
                      v24.Enabled = true
                    else
                      v24.Enabled = false
                    end
                  end

                  return
                end
              elseif v7.BoxStyle == "Corner" then
                local v48 = v35 * 0.2

                v26.Box.TopLeft.From = vector2
                v26.Box.TopLeft.To = vector2 + Vector2.new(v48, 0)
                v26.Box.TopLeft.Visible = true
                v26.Box.TopRight.From = vector2 + Vector2.new(vector3.X, 0)
                v26.Box.TopRight.To = vector2 + Vector2.new(vector3.X - v48, 0)
                v26.Box.TopRight.Visible = true
                v26.Box.BottomLeft.From = vector2 + Vector2.new(0, vector3.Y)
                v26.Box.BottomLeft.To = vector2 + Vector2.new(v48, vector3.Y)
                v26.Box.BottomLeft.Visible = true
                v26.Box.BottomRight.From = vector2 + Vector2.new(vector3.X, vector3.Y)
                v26.Box.BottomRight.To = vector2 + Vector2.new(vector3.X - v48, vector3.Y)
                v26.Box.BottomRight.Visible = true
                v26.Box.Left.From = vector2
                v26.Box.Left.To = vector2 + Vector2.new(0, v48)
                v26.Box.Left.Visible = true
                v26.Box.Right.From = vector2 + Vector2.new(vector3.X, 0)
                v26.Box.Right.To = vector2 + Vector2.new(vector3.X, v48)
                v26.Box.Right.Visible = true
                v26.Box.Top.From = vector2 + Vector2.new(0, vector3.Y)
                v26.Box.Top.To = vector2 + Vector2.new(0, vector3.Y - v48)
                v26.Box.Top.Visible = true
                v26.Box.Bottom.From = vector2 + Vector2.new(vector3.X, vector3.Y)
                v26.Box.Bottom.To = vector2 + Vector2.new(vector3.X, vector3.Y - v48)
                v26.Box.Bottom.Visible = true
              else
                v26.Box.Left.From = vector2
                v26.Box.Left.To = vector2 + Vector2.new(0, vector3.Y)
                v26.Box.Left.Visible = true
                v26.Box.Right.From = vector2 + Vector2.new(vector3.X, 0)
                v26.Box.Right.To = vector2 + Vector2.new(vector3.X, vector3.Y)
                v26.Box.Right.Visible = true
                v26.Box.Top.From = vector2
                v26.Box.Top.To = vector2 + Vector2.new(vector3.X, 0)
                v26.Box.Top.Visible = true
                v26.Box.Bottom.From = vector2 + Vector2.new(0, vector3.Y)
                v26.Box.Bottom.To = vector2 + Vector2.new(vector3.X, vector3.Y)
                v26.Box.Bottom.Visible = true
              end
            else
              goto L14752011
            end
          end
        end
      end
    end
  end
end

function f7()
  local tracerOrigin = v7.TracerOrigin

  if tracerOrigin == "Bottom" then
    return Vector2.new(currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y)
  elseif tracerOrigin == "Top" then
    return Vector2.new(currentCamera.ViewportSize.X / 2, 0)
  else
    if tracerOrigin == "Mouse" then
      return userInputService:GetMouseLocation()
    end

    return Vector2.new(currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y / 2)
  end
end

espTab:CreateSection("Main ESP")

local enableESPToggle = espTab:CreateToggle({
  Name = "Enable ESP",
  CurrentValue = v7.Enabled,
  Flag = "EspEnabled",
  Callback = function(value38)
    v7.Enabled = value38

    if not v7.Enabled then
      f6()
    else
      for index4, value39 in ipairs(players:GetPlayers()) do
        if value39 ~= localPlayer then
          f2(value39)
        end
      end
    end
  end,
})

local teamCheckToggle = espTab:CreateToggle({
  Name = "Team Check",
  CurrentValue = v7.TeamCheck,
  Flag = "EspTeamCheck",
  Callback = function(value40) v7.TeamCheck = value40 end,
})

local showTeamToggle = espTab:CreateToggle({
  Name = "Show Team",
  CurrentValue = v7.ShowTeam,
  Flag = "EspShowTeam",
  Callback = function(value41) v7.ShowTeam = value41 end,
})

espTab:CreateSection("Box ESP")

local boxESPToggle = espTab:CreateToggle({
  Name = "Box ESP",
  CurrentValue = v7.BoxESP,
  Flag = "EspBox",
  Callback = function(value42) v7.BoxESP = value42 end,
})

local boxStyleDropdown = espTab:CreateDropdown({
  Name = "Box Style",
  Options = { "Corner", "Full", "ThreeD" },
  CurrentOption = v7.BoxStyle,
  Flag = "EspBoxStyle",
  Callback = function(value43) v7.BoxStyle = value43 end,
})

local boxThicknessSlider = espTab:CreateSlider({
  Name = "Box Thickness",
  Range = { 1, 5 },
  Increment = 1,
  Suffix = "px",
  CurrentValue = v7.BoxThickness,
  Flag = "EspBoxThick",
  Callback = function(value44) v7.BoxThickness = value44 end,
})

espTab:CreateSection("Tracer ESP")

local tracerESPToggle = espTab:CreateToggle({
  Name = "Tracer ESP",
  CurrentValue = v7.TracerESP,
  Flag = "EspTracer",
  Callback = function(value45) v7.TracerESP = value45 end,
})

local tracerOriginDropdown = espTab:CreateDropdown({
  Name = "Tracer Origin",
  Options = { "Bottom", "Top", "Mouse", "Center" },
  CurrentOption = v7.TracerOrigin,
  Flag = "EspTracerOrigin",
  Callback = function(value46) v7.TracerOrigin = value46 end,
})

espTab:CreateSection("Chams")

local enableChamsToggle = espTab:CreateToggle({
  Name = "Enable Chams",
  CurrentValue = v7.ChamsEnabled,
  Flag = "EspChams",
  Callback = function(value47) v7.ChamsEnabled = value47 end,
})

local fillColorColorPicker = espTab:CreateColorPicker({
  Name = "Fill Color",
  Color = v7.ChamsFillColor,
  Flag = "EspChamsFill",
  Callback = function(value48) v7.ChamsFillColor = value48 end,
})

local outlineColorColorPicker = espTab:CreateColorPicker({
  Name = "Outline Color",
  Color = v7.ChamsOutlineColor,
  Flag = "EspChamsOutline",
  Callback = function(value49) v7.ChamsOutlineColor = value49 end,
})

local fillTransparencySlider = espTab:CreateSlider({
  Name = "Fill Transparency",
  Range = { 0, 1 },
  Increment = 0.01,
  CurrentValue = v7.ChamsTransparency,
  Flag = "EspChamsFillTrans",
  Callback = function(value50) v7.ChamsTransparency = value50 end,
})

local outlineTransparencySlider = espTab:CreateSlider({
  Name = "Outline Transparency",
  Range = { 0, 1 },
  Increment = 0.01,
  CurrentValue = v7.ChamsOutlineTransparency,
  Flag = "EspChamsOutlineTrans",
  Callback = function(value51) v7.ChamsOutlineTransparency = value51 end,
})

local outlineThicknessSlider = espTab:CreateSlider({
  Name = "Outline Thickness",
  Range = { 0, 1 },
  Increment = 0.01,
  CurrentValue = v7.ChamsOutlineThickness,
  Flag = "EspChamsOutlineThick",
  Callback = function(value52) v7.ChamsOutlineThickness = value52 end,
})

espTab:CreateSection("Health & Name ESP")

local healthBarToggle = espTab:CreateToggle({
  Name = "Health Bar",
  CurrentValue = v7.HealthESP,
  Flag = "EspHealth",
  Callback = function(value53) v7.HealthESP = value53 end,
})

local healthStyleDropdown = espTab:CreateDropdown({
  Name = "Health Style",
  Options = { "Bar", "Text", "Both" },
  CurrentOption = v7.HealthStyle,
  Flag = "EspHealthStyle",
  Callback = function(value54) v7.HealthStyle = value54 end,
})

local nameESPToggle = espTab:CreateToggle({
  Name = "Name ESP",
  CurrentValue = v7.NameESP,
  Flag = "EspName",
  Callback = function(value55) v7.NameESP = value55 end,
})

local snaplinesToggle = espTab:CreateToggle({
  Name = "Snaplines",
  CurrentValue = v7.Snaplines,
  Flag = "EspSnaplines",
  Callback = function(value56) v7.Snaplines = value56 end,
})

espTab:CreateSection("Skeleton ESP")

local skeletonESPToggle = espTab:CreateToggle({
  Name = "Skeleton ESP",
  CurrentValue = v7.SkeletonESP,
  Flag = "EspSkeleton",
  Callback = function(value57) v7.SkeletonESP = value57 end,
})

local skeletonColorColorPicker = espTab:CreateColorPicker({
  Name = "Skeleton Color",
  Color = v7.SkeletonColor,
  Flag = "EspSkeletonColor",
  Callback = function(value58)
    v7.SkeletonColor = value58

    for index5, value59 in ipairs(players:GetPlayers()) do
      local v49 = v5.Skeleton[value59]

      if v49 then
        for key29, value60 in pairs(v49) do
          value60.Color = value58
        end
      end
    end
  end,
})

local lineThicknessSlider = espTab:CreateSlider({
  Name = "Line Thickness",
  Range = { 1, 3 },
  Increment = 0.1,
  Suffix = "px",
  CurrentValue = v7.SkeletonThickness,
  Flag = "EspSkeletonThick",
  Callback = function(value61)
    v7.SkeletonThickness = value61

    for index6, value62 in ipairs(players:GetPlayers()) do
      local v50 = v5.Skeleton[value62]

      if v50 then
        for key30, value63 in pairs(v50) do
          value63.Thickness = value61
        end
      end
    end
  end,
})

local transparencySlider = espTab:CreateSlider({
  Name = "Transparency",
  Range = { 0, 1 },
  Increment = 0.01,
  CurrentValue = v7.SkeletonTransparency,
  Flag = "EspSkeletonTrans",
  Callback = function(value64)
    v7.SkeletonTransparency = value64

    for index7, value65 in ipairs(players:GetPlayers()) do
      local v51 = v5.Skeleton[value65]

      if v51 then
        for key31, value66 in pairs(v51) do
          value66.Transparency = value64
        end
      end
    end
  end,
})

espTab:CreateSection("ESP Settings")

local maxDistanceSlider = espTab:CreateSlider({
  Name = "Max Distance",
  Range = { 100, 5000 },
  Increment = 50,
  Suffix = "Studs",
  CurrentValue = v7.MaxDistance,
  Flag = "EspDist",
  Callback = function(value67) v7.MaxDistance = value67 end,
})

local textSizeSlider = espTab:CreateSlider({
  Name = "Text Size",
  Range = { 10, 24 },
  Increment = 1,
  Suffix = "px",
  CurrentValue = v7.TextSize,
  Flag = "EspTextSize",
  Callback = function(value68) v7.TextSize = value68 end,
})

local healthFormatDropdown = espTab:CreateDropdown({
  Name = "Health Format",
  Options = { "Number", "Percentage", "Both" },
  CurrentOption = v7.HealthTextFormat,
  Flag = "EspHealthFormat",
  Callback = function(value69) v7.HealthTextFormat = value69 end,
})

espTab:CreateSection("Colors")

local enemyColorColorPicker = espTab:CreateColorPicker({
  Name = "Enemy Color",
  Color = v8.Enemy,
  Flag = "EspEnemyColor",
  Callback = function(value70) v8.Enemy = value70 end,
})

local allyColorColorPicker = espTab:CreateColorPicker({
  Name = "Ally Color",
  Color = v8.Ally,
  Flag = "EspAllyColor",
  Callback = function(value71) v8.Ally = value71 end,
})

local colorPicker = espTab:CreateColorPicker({
  Name = "Health Bar Color",
  Color = v8.Health,
  Flag = "EspHealthColor",
  Callback = function(value72) v8.Health = value72 end,
})

espTab:CreateSection("Effects")

local rainbowModeToggle = espTab:CreateToggle({
  Name = "Rainbow Mode",
  CurrentValue = v7.RainbowEnabled,
  Flag = "EspRainbow",
  Callback = function(value73) v7.RainbowEnabled = value73 end,
})

local rainbowSpeedSlider = espTab:CreateSlider({
  Name = "Rainbow Speed",
  Range = { 0.1, 5 },
  Increment = 0.1,
  CurrentValue = v7.RainbowSpeed,
  Flag = "EspRainbowSpeed",
  Callback = function(value74) v7.RainbowSpeed = value74 end,
})

espTab:CreateDropdown({
  Name = "Rainbow Parts",
  Options = { "All", "Box Only", "Tracers Only", "Text Only" },
  CurrentOption = "All",
  Flag = "EspRainbowParts",
  Callback = function(value75)
    if value75 == "All" then
      v7.RainbowBoxes = true
      v7.RainbowTracers = true
      v7.RainbowText = true
    elseif value75 == "Box Only" then
      v7.RainbowBoxes = true
      v7.RainbowTracers = false
      v7.RainbowText = false
    elseif value75 == "Tracers Only" then
      v7.RainbowBoxes = false
      v7.RainbowTracers = true
      v7.RainbowText = false
    elseif value75 == "Text Only" then
      v7.RainbowBoxes = false
      v7.RainbowTracers = false
      v7.RainbowText = true
    end
  end,
})

espTab:CreateSection("Performance")

local refreshRateSlider = espTab:CreateSlider({
  Name = "Refresh Rate",
  Range = { 1, 144 },
  Increment = 1,
  Suffix = "Hz",
  CurrentValue = 144,
  Flag = "EspRefreshRate",
  Callback = function(value76) v7.RefreshRate = 1 / value76 end,
})

local circle = Drawing.new("Circle")
circle.Transparency = 1
circle.Thickness = 2
circle.Color = getgenv().Silent.Setting.FOV.Color
circle.Filled = false
circle.NumSides = 100
circle.Visible = false

local circle2 = Drawing.new("Circle")
circle2.Radius = 6
circle2.Color = Color3.fromRGB(255, 0, 100)

local function f10(p6)
  local humanoid3 = p6 and p6:FindFirstChildOfClass("Humanoid")

  if not humanoid3 then
    return false
  else
    local getState = humanoid3:GetState()

    return getState == Enum.HumanoidStateType.Freefall
      or getState == Enum.HumanoidStateType.Jumping
  end
end

circle2.Filled = true
circle2.Visible = false

local v52 = 0

local function f11(p7, p8)
  if not getgenv().Silent.Setting.WallCheck then
    return true
  else
    local p = currentCamera.CFrame.p
    return workspaceService:FindPartOnRayWithIgnoreList(Ray.new(p, p7 - p), p8) == nil
  end
end

local function f12()
  if statsService and statsService.Network and statsService.Network.ServerStatsItem then
    return statsService.Network.ServerStatsItem["Data Ping"]:GetValue()
  end

  return 100
end

local v53 = 0
local manualPrediction = 0

local function f13()
  local huge2 = math.huge
  local v54

  for key32, value77 in pairs(players:GetPlayers()) do
    if value77 ~= localPlayer and value77.Character
      and value77.Character:FindFirstChild("HumanoidRootPart") then
      local humanoidRootPart3 = value77.Character.HumanoidRootPart
      local v55, v56 = currentCamera:WorldToScreenPoint(humanoidRootPart3.Position)
      local magnitude2 = (Vector2.new(v55.X, v55.Y) - Vector2.new(getMouse.X, getMouse.Y + y)).Magnitude

      if circle.Radius > magnitude2 and magnitude2 < huge2 and v56
        and f11(humanoidRootPart3.Position, { localPlayer, value77.Character }) then
        v54 = value77
        huge2 = magnitude2
      end
    end
  end

  return v54
end

local v57

local toggle2 = silentAimTab:CreateToggle({
  Name = "Enable Silent Aim",
  CurrentValue = false,
  Flag = "SilentIsTargetting",
  Callback = function(value78)
    silentAimUI = value78
    getgenv().Silent.Setting.IsTargetting = value78

    if not value78 then
      circle.Visible = false
      circle2.Visible = false
      v57 = nil
    end

    if not v2 then
      rayfield:Notify({
        Title = "Silent Aim",
        Content = value78 and "Enabled" or "Disabled",
        Duration = 3,
      })
    end
  end,
})

local wallCheckToggle = silentAimTab:CreateToggle({
  Name = "Wall Check",
  CurrentValue = getgenv().Silent.Setting.WallCheck,
  Flag = "SilentWallCheck",
  Callback = function(value79) getgenv().Silent.Setting.WallCheck = value79 end,
})

local targetPartDropdown = silentAimTab:CreateDropdown({
  Name = "Target Part",
  Options = { "HumanoidRootPart", "Head", "UpperTorso", "LowerTorso" },
  CurrentOption = getgenv().Silent.Setting.TargetPart,
  Flag = "SilentTargetPart",
  Callback = function(value80) getgenv().Silent.Setting.TargetPart = value80 end,
})

local manualPredictionSlider2 = silentAimTab:CreateSlider({
  Name = "Manual Prediction",
  Range = { 0.001, 1 },
  Increment = 0.001,
  Suffix = "s",
  CurrentValue = getgenv().Silent.Setting.ManualPrediction,
  Flag = "SilentManualPred",
  Callback = function(value81)
    getgenv().Silent.Setting.ManualPrediction = value81

    if not getgenv().Silent.Setting.AutoPrediction then
      manualPrediction = value81
    end
  end,
})

silentAimTab:CreateSection("Prediction Settings")

local toggle3 = silentAimTab:CreateToggle({
  Name = "Auto Prediction (1 ping = 1 pred)",
  CurrentValue = getgenv().Silent.Setting.AutoPrediction,
  Flag = "SilentAutoPred",
  Callback = function(value82)
    getgenv().Silent.Setting.AutoPrediction = value82

    if not value82 then
      manualPrediction = getgenv().Silent.Setting.ManualPrediction
    end
  end,
})

local toggle4 = silentAimTab:CreateToggle({
  Name = "In Air Prediction",
  CurrentValue = getgenv().Silent.Setting.InAirPrediction,
  Flag = "SilentInAirPred",
  Callback = function(value83) getgenv().Silent.Setting.InAirPrediction = value83 end,
})

local slider = silentAimTab:CreateSlider({
  Name = "In Air Pred Value",
  Range = { 0.001, 0.1 },
  Increment = 0.001,
  Suffix = "s",
  CurrentValue = getgenv().Silent.Setting.InAirPredValue,
  Flag = "SilentInAirValue",
  Callback = function(value84) getgenv().Silent.Setting.InAirPredValue = value84 end,
})

local toggle5 = silentAimTab:CreateToggle({
  Name = "View Prediction (Red Dot)",
  CurrentValue = getgenv().Silent.Setting.ViewPrediction,
  Flag = "SilentViewPred",
  Callback = function(value85) getgenv().Silent.Setting.ViewPrediction = value85 end,
})

silentAimTab:CreateSection("FOV Settings")

local drawFOVToggle = silentAimTab:CreateToggle({
  Name = "Draw FOV",
  CurrentValue = getgenv().Silent.Setting.FOV.Visible,
  Flag = "SilentDrawFOV",
  Callback = function(value86)
    getgenv().Silent.Setting.FOV.Visible = value86

    if not silentAimUI then
      circle.Visible = false
    end
  end,
})

local fovRadiusSlider = silentAimTab:CreateSlider({
  Name = "FOV Radius",
  Range = { 10, 1000 },
  Increment = 10,
  Suffix = "Studs",
  CurrentValue = getgenv().Silent.Setting.FOV.Radius,
  Flag = "SilentFOVRadius",
  Callback = function(value87) getgenv().Silent.Setting.FOV.Radius = value87 end,
})

local fovColorColorPicker = silentAimTab:CreateColorPicker({
  Name = "FOV Color",
  Color = getgenv().Silent.Setting.FOV.Color,
  Flag = "SilentFOVColor",
  Callback = function(value88)
    getgenv().Silent.Setting.FOV.Color = value88
    circle.Color = value88
  end,
})

local v58

v58 = hookmetamethod(game, "__index", function(p9, p10)
  if not silentAimUI then
    return v58(p9, p10)
  end

  if getgenv().Silent and typeof(p9) == "Instance" and p9:IsA("Mouse")
    and (p10 == "Hit" or p10 == "Target") then
    local v59 = v57 or f13()

    if v59 and v59.Character then
      local findFirstChild2 = v59.Character:FindFirstChild(getgenv().Silent.Setting.TargetPart)

      if findFirstChild2 then
        if p10 == "Hit" then
          return findFirstChild2.CFrame + findFirstChild2.Velocity * manualPrediction
        elseif p10 == "Target" then
          return findFirstChild2
        end
      end
    end

    return v58(p9, p10)
  end

  return v58(p9, p10)
end)

local function f14()
  local v60, v61

  if not isfile("UniversalHub_Config.json") then
    return
  else
    local v62, v63 = pcall(function()
      return httpService:JSONDecode(readfile("UniversalHub_Config.json"))
    end)

    if not v62 or type(v63) ~= "table" then
      return
    else
      v2 = true
      triggerbotUI = v63.TriggerbotUI or false
      enableTriggerbotToggle:Set(triggerbotUI)

      if v63.TriggerbotKey then
        v60 = Enum.KeyCode[v63.TriggerbotKey]

        if v60 then
          pcall(function() triggerbotKeybindKeybind:Set(v60) end)
        end
      end

      weaponWhitelist = v63.WeaponWhitelist or false
      knifeCheckToggle:Set(weaponWhitelist)
      camlockUI = v63.CamlockUI or false
      enableCamlockToggle:Set(camlockUI)

      if v63.CamlockKey then
        v61 = Enum.KeyCode[v63.CamlockKey]

        if v61 then
          pcall(function() lockKeybindKeybind:Set(v61) end)
        end
      end

      camlockTargetPart = v63.CamlockTargetPart or "Head"
      aimPartDropdown:Set(camlockTargetPart)
      camlockAutoPred = v63.CamlockAutoPred == nil and true or v63.CamlockAutoPred
      toggle:Set(camlockAutoPred)
      camlockManualPred = v63.CamlockManualPred or 0.17
      manualPredictionSlider:Set(camlockManualPred)
      silentAimUI = v63.SilentAimUI or false
      getgenv().Silent.Setting.IsTargetting = silentAimUI
      toggle2:Set(silentAimUI)

      local setting = getgenv().Silent.Setting
      setting.WallCheck = v63.SilentWallCheck == nil and true or v63.SilentWallCheck

      wallCheckToggle:Set(getgenv().Silent.Setting.WallCheck)

      local setting2 = getgenv().Silent.Setting
      setting2.TargetPart = v63.SilentTargetPart or "HumanoidRootPart"

      targetPartDropdown:Set(getgenv().Silent.Setting.TargetPart)
      getgenv().Silent.Setting.ManualPrediction = v63.SilentManualPrediction or 0.17
      manualPredictionSlider2:Set(getgenv().Silent.Setting.ManualPrediction)

      local setting3 = getgenv().Silent.Setting

      setting3.AutoPrediction = v63.SilentAutoPrediction == nil and true
        or v63.SilentAutoPrediction

      toggle3:Set(getgenv().Silent.Setting.AutoPrediction)

      local setting4 = getgenv().Silent.Setting

      setting4.InAirPrediction = v63.SilentInAirPrediction == nil and true
        or v63.SilentInAirPrediction

      toggle4:Set(getgenv().Silent.Setting.InAirPrediction)
      getgenv().Silent.Setting.InAirPredValue = v63.SilentInAirPredValue or 0.03
      slider:Set(getgenv().Silent.Setting.InAirPredValue)

      local setting5 = getgenv().Silent.Setting

      setting5.ViewPrediction = v63.SilentViewPrediction == nil and true
        or v63.SilentViewPrediction

      toggle5:Set(getgenv().Silent.Setting.ViewPrediction)

      local fov = getgenv().Silent.Setting.FOV
      fov.Visible = v63.SilentFOVVisible == nil and true or v63.SilentFOVVisible

      drawFOVToggle:Set(getgenv().Silent.Setting.FOV.Visible)
      getgenv().Silent.Setting.FOV.Radius = v63.SilentFOVRadius or 360
      fovRadiusSlider:Set(getgenv().Silent.Setting.FOV.Radius)
      local silentFOVColor = v63.SilentFOVColor or { 230, 230, 250 }
      local color2 = Color3.new(silentFOVColor[1], silentFOVColor[2], silentFOVColor[3])
      getgenv().Silent.Setting.FOV.Color = color2
      circle.Color = color2
      fovColorColorPicker:Set(color2)

      if v63.ESPSettings then
        for key33, value89 in pairs(v63.ESPSettings) do
          v7[key33] = value89
        end
      end

      if v63.ESPColors then
        if v63.ESPColors.Enemy then
          v8.Enemy = Color3.new(
            v63.ESPColors.Enemy[1], v63.ESPColors.Enemy[2], v63.ESPColors.Enemy[3]
          )
        end

        if v63.ESPColors.Ally then
          v8.Ally = Color3.new(
            v63.ESPColors.Ally[1], v63.ESPColors.Ally[2], v63.ESPColors.Ally[3]
          )
        end

        if v63.ESPColors.Health then
          v8.Health = Color3.new(
            v63.ESPColors.Health[1], v63.ESPColors.Health[2], v63.ESPColors.Health[3]
          )
        end
      end

      enableESPToggle:Set(v7.Enabled)

      if v7.Enabled then
        for index8, value90 in ipairs(players:GetPlayers()) do
          if value90 ~= localPlayer then
            f2(value90)
          end
        end
      else
        f6()
      end

      teamCheckToggle:Set(v7.TeamCheck)
      showTeamToggle:Set(v7.ShowTeam)
      boxESPToggle:Set(v7.BoxESP)
      boxStyleDropdown:Set(v7.BoxStyle)
      boxThicknessSlider:Set(v7.BoxThickness)
      tracerESPToggle:Set(v7.TracerESP)
      tracerOriginDropdown:Set(v7.TracerOrigin)
      enableChamsToggle:Set(v7.ChamsEnabled)
      fillColorColorPicker:Set(v7.ChamsFillColor)
      outlineColorColorPicker:Set(v7.ChamsOutlineColor)
      fillTransparencySlider:Set(v7.ChamsTransparency)
      outlineTransparencySlider:Set(v7.ChamsOutlineTransparency)
      outlineThicknessSlider:Set(v7.ChamsOutlineThickness)
      healthBarToggle:Set(v7.HealthESP)
      healthStyleDropdown:Set(v7.HealthStyle)
      nameESPToggle:Set(v7.NameESP)
      snaplinesToggle:Set(v7.Snaplines)
      skeletonESPToggle:Set(v7.SkeletonESP)
      skeletonColorColorPicker:Set(v7.SkeletonColor)
      lineThicknessSlider:Set(v7.SkeletonThickness)
      transparencySlider:Set(v7.SkeletonTransparency)
      maxDistanceSlider:Set(v7.MaxDistance)
      textSizeSlider:Set(v7.TextSize)
      healthFormatDropdown:Set(v7.HealthTextFormat)
      enemyColorColorPicker:Set(v8.Enemy)
      allyColorColorPicker:Set(v8.Ally)
      colorPicker:Set(v8.Health)
      rainbowModeToggle:Set(v7.RainbowEnabled)
      rainbowSpeedSlider:Set(v7.RainbowSpeed)
      refreshRateSlider:Set(1 / v7.RefreshRate)
      v2 = false

      rayfield:Notify({
        Title = "Config Loaded",
        Content = "All settings loaded successfully!",
        Duration = 3,
      })

      return
    end
  end
end

settingsTab:CreateButton({
  Name = "Save Config",
  Callback = function()
    local v64 = {
      TriggerbotUI = triggerbotUI,
      TriggerbotKey = tostring(triggerbotKeybindKeybind:Get()),
      WeaponWhitelist = weaponWhitelist,
      CamlockUI = camlockUI,
      CamlockKey = tostring(lockKeybindKeybind:Get()),
      CamlockTargetPart = camlockTargetPart,
      CamlockAutoPred = camlockAutoPred,
      CamlockManualPred = camlockManualPred,
      SilentAimUI = silentAimUI,
      SilentWallCheck = getgenv().Silent.Setting.WallCheck,
      SilentTargetPart = getgenv().Silent.Setting.TargetPart,
      SilentManualPrediction = getgenv().Silent.Setting.ManualPrediction,
      SilentAutoPrediction = getgenv().Silent.Setting.AutoPrediction,
      SilentInAirPrediction = getgenv().Silent.Setting.InAirPrediction,
      SilentInAirPredValue = getgenv().Silent.Setting.InAirPredValue,
      SilentViewPrediction = getgenv().Silent.Setting.ViewPrediction,
      SilentFOVVisible = getgenv().Silent.Setting.FOV.Visible,
      SilentFOVRadius = getgenv().Silent.Setting.FOV.Radius,
      SilentFOVColor = {
        getgenv().Silent.Setting.FOV.Color.R, getgenv().Silent.Setting.FOV.Color.G,
        getgenv().Silent.Setting.FOV.Color.B,
      },
      ESPSettings = v7,
      ESPColors = {
        Enemy = { v8.Enemy.R, v8.Enemy.G, v8.Enemy.B },
        Ally = { v8.Ally.R, v8.Ally.G, v8.Ally.B },
        Health = { v8.Health.R, v8.Health.G, v8.Health.B },
      },
    }

    local v65, v66 = pcall(function()
      writefile("UniversalHub_Config.json", httpService:JSONEncode(v64))
    end)

    if v65 then
      rayfield:Notify({
        Title = "Config Saved",
        Content = "All settings saved successfully!",
        Duration = 3,
      })
    else
      rayfield:Notify({
        Title = "Error",
        Content = "Failed to save: " .. tostring(v66),
        Duration = 3,
      })
    end
  end,
})

settingsTab:CreateButton({ Name = "Load Config", Callback = f14 })

creditsTab:CreateSection("Script Info")
creditsTab:CreateParagraph({ Title = "Script Creation", Content = "Created by: ryuk" })
creditsTab:CreateParagraph({ Title = "UI Library", Content = "Rayfield UI by Sirius" })

task.spawn(function()
  while task.wait(0.1) do
    v8.Rainbow = Color3.fromHSV(tick() * v7.RainbowSpeed % 1, 1, 1)
  end
end)

local v67 = 0
local v68

runService.RenderStepped:Connect(function()
  if triggerbotUI and v1 then
    local tool = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Tool")

    if tool ~= v68 then
      v68 = tool

      if v3 then
        mouse1release()
        v3 = false
      end
    end

    local v69 = true

    if weaponWhitelist then
      if tool then
        local v70 = string.lower(string.gsub(tool.Name, "%s+", ""))
        v69 = false

        for key34, value91 in pairs(v4) do
          if string.find(v70, value91) then
            v69 = true
            break
          end
        end
      else
        v69 = false
      end
    end

    if v69 then
      local target = getMouse.Target
      local v71 = false

      if target then
        local parent = target.Parent
        local getPlayerFromCharacter = players:GetPlayerFromCharacter(parent)

        if getPlayerFromCharacter and getPlayerFromCharacter ~= localPlayer then
          local humanoid4 = parent:FindFirstChildOfClass("Humanoid")
          local v72 = false

          if humanoid4 then
            if humanoid4.Health <= 0 or humanoid4:GetState() == Enum.HumanoidStateType.Dead then
              v72 = true
            end
          else
            v72 = true
          end

          local dead = parent:FindFirstChild("Dead")

          local dead2 = dead
          dead2 = dead or parent:FindFirstChild("dead")

          if dead2 and dead2:IsA("BoolValue") and dead2.Value == true then
            v72 = true
          end

          if dead2 and dead2:IsA("StringValue") and dead2.Value ~= "" then
            v72 = true
          end

          local dead3 = parent:GetAttribute("Dead")

          local dead4 = dead3
          dead4 = dead3 or parent:GetAttribute("dead")

          if dead4 == true or dead4 == "true" then
            v72 = true
          end

          if not v72 then
            v71 = true
          end
        end
      end

      if v71 then
        if v3 then
          mouse1release()
          v3 = false
        else
          mouse1press()
          v3 = true
        end
      elseif v3 then
        mouse1release()
        v3 = false
      end
    elseif v3 then
      mouse1release()
      v3 = false
    end
  elseif v3 then
    mouse1release()
    v3 = false
  end

  if camlockUI and v9 then
    local humanoid5 = v9.Parent:FindFirstChildOfClass("Humanoid")

    if v9.Parent and humanoid5 and humanoid5.Health > 0 then
      local v73 = camlockManualPred

      if camlockAutoPred then
        v73 = f12() / 1000
      end

      local vector5 = Vector3.new(0, -0.6, 0)

      local cframe2 = CFrame.new(
        currentCamera.CFrame.Position, v9.Position + v9.Velocity * v73 + vector5
      )

      currentCamera.CFrame = currentCamera.CFrame:Lerp(cframe2, 0.2)
    else
      v9 = nil
    end
  end

  if not v7.Enabled then
    f4()
  else
    local v74 = tick()

    if v74 - v67 >= v7.RefreshRate then
      for index9, value92 in ipairs(players:GetPlayers()) do
        if value92 ~= localPlayer then
          if not v5.ESP[value92] then
            f2(value92)
          end

          f8(value92)
        end
      end

      v67 = v74
    end
  end
end)

runService.Heartbeat:Connect(function()
  if not silentAimUI then
    return
  else
    circle.Position = Vector2.new(getMouse.X, getMouse.Y + y)
    circle.Visible = getgenv().Silent.Setting.FOV.Visible
    circle.Radius = getgenv().Silent.Setting.FOV.Radius * 3.067

    if tick() - v52 >= 0.001 then
      v53 = f12()
      v52 = tick()
    end

    local v75 = f13()
    v57 = v75

    if v75 then
      local character2 = v75.Character

      local findFirstChild3 = character2

      findFirstChild3 = character2
        and character2:FindFirstChild(getgenv().Silent.Setting.TargetPart)

      if findFirstChild3 then
        local manualPrediction2 = getgenv().Silent.Setting.ManualPrediction

        if getgenv().Silent.Setting.AutoPrediction then
          manualPrediction2 = v53 / 1000

          if getgenv().Silent.Setting.InAirPrediction and f10(character2) then
            manualPrediction2 = getgenv().Silent.Setting.InAirPredValue
          end
        end

        manualPrediction = math.clamp(manualPrediction2, 0.001, 1)

        if getgenv().Silent.Setting.ViewPrediction then
          local v76, v77 = currentCamera:WorldToScreenPoint(findFirstChild3.Position
            + findFirstChild3.Velocity * manualPrediction)

          if v77 then
            circle2.Position = Vector2.new(v76.X, v76.Y)
            circle2.Visible = true
          else
            circle2.Visible = false
          end
        else
          circle2.Visible = false
        end
      end
    else
      circle2.Visible = false
    end

    return
  end
end)

players.PlayerAdded:Connect(f2)
players.PlayerRemoving:Connect(f3)

localPlayer.CharacterAdded:Connect(function()
  task.wait(1)
  currentCamera = workspaceService.CurrentCamera
end)

f14()
