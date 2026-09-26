local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local contextActionService = game:GetService("ContextActionService")
local workspaceService = game:GetService("Workspace")
local userInputService = game:GetService("UserInputService")
local lighting = game:GetService("Lighting")
local virtualUser = game:GetService("VirtualUser")

local f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, ui, localPlayer, currentCamera,
  waitForChild, skinsTab, f12, f13, f14, f15, v1, v2, circle, f16, f17, v3, v4, v5, v6, v7, v8,
  v9, v10, v11, v12, f18, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, clone, animator,
  loadAnimation, loadAnimation2, loadAnimation3, loadAnimation4, loadAnimation5, loadAnimation6,
  f19, f20, v23, v24, v25, v26, skins, f21

if not _G["2107"] then
  local localPlayer2 = players.LocalPlayer

  if localPlayer2 then
    localPlayer2:Kick("\n🛡️ Unauthorized Execution 🛡️\n\nPlease use the official Key System to run NNVN Hub")
  end

  return
else
  ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/twistedk1d/BloxStrike/refs/heads/main/Source/UI/source.lua"))()

  local nnvnHubWindow = ui:CreateWindow({
    Name = "NNVN Hub",
    Icon = 0,
    LoadingTitle = "Loading NNVN Hub",
    LoadingSubtitle = "Blox Strike Script",
    ShowText = "NNVN",
    Theme = _G.NNVNTheme or "AmberGlow",
    ToggleUIKeybind = Enum.KeyCode.K,
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    ConfigurationSaving = { Enabled = true, FolderName = "NNVN_Hub", FileName = "NNVN_Config" },
    Size = UDim2.new(0, 600, 0, 500),
  })

  localPlayer = players.LocalPlayer
  currentCamera = workspaceService.CurrentCamera
  waitForChild = workspaceService:WaitForChild("Characters", 10)
  local combatTab = nnvnHubWindow:CreateTab("Combat", "crosshair")
  local rageTab = nnvnHubWindow:CreateTab("Rage", "zap")
  skinsTab = nnvnHubWindow:CreateTab("Skins", "swords")
  local visualsTab = nnvnHubWindow:CreateTab("Visuals", "eye")
  local miscTab = nnvnHubWindow:CreateTab("Misc", "settings")
  local configTab = nnvnHubWindow:CreateTab("Config", "save")

  function f12(title, content, p1)
    ui:Notify({
      Title = title,
      Content = content,
      Duration = p1 or 3,
      Image = 4483362458,
    })
  end

  f12("NNVN Hub", "Successfully loaded NNVN Hub v3.0.0", 5)

  function f13()
    return waitForChild:FindFirstChild("Terrorists")
  end

  function f14()
    return waitForChild:FindFirstChild("Counter-Terrorists")
  end

  function f1()
    if not f15() then
      return nil
    else
      local v27 = f13()
      local v28 = f14()

      if v27 and v27:FindFirstChild(localPlayer.Name) then
        return v28
      end

      if v28 and v28:FindFirstChild(localPlayer.Name) then
        return v27
      end

      return nil
    end
  end

  function f15()
    local v29 = f13()
    local v30 = f14()

    return v29 and v29:FindFirstChild(localPlayer.Name)
      or v30 and v30:FindFirstChild(localPlayer.Name)
  end

  v1 = {
    Enabled = false,
    ShowFOV = false,
    FOVRadius = 100,
    Smoothing = 3,
    AimKey = Enum.UserInputType.MouseButton2,
    AimPart = "Head",
    PredictMovement = false,
    PredictionAmount = 0.1,
    VisibilityCheck = true,
    TeamCheck = true,
    IgnoreKnocked = true,
    AutoShoot = false,
    SilentAim = false,
    AimAssist = false,
    AssistStrength = 0.5,
  }

  v2 = false

  circle = Drawing.new("Circle")

  circle.Position = Vector2.new(
    currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y / 2
  )

  circle.Radius = v1.FOVRadius
  circle.Filled = false
  circle.Color = Color3.fromRGB(138, 43, 226)
  circle.Visible = false
  circle.Thickness = 2
  circle.Transparency = 0.8

  function f16(p2)
    if not v1.VisibilityCheck then
      return true
    else
      local findPartOnRayWithIgnoreList = workspaceService:FindPartOnRayWithIgnoreList(Ray.new(currentCamera.CFrame.Position, (p2
          - currentCamera.CFrame.Position).Unit
        * 1000), {
        currentCamera, localPlayer.Character,
      })

      return findPartOnRayWithIgnoreList == nil
        or findPartOnRayWithIgnoreList:IsDescendantOf(workspaceService:FindFirstChild("Characters"))
    end
  end

  function f2()
    local fovRadius = v1.FOVRadius
    local v31 = f1()
    local v32 = not v31 or not v1.Enabled
    local v33

    if v32 then
      return nil
    else
      local getMouseLocation = userInputService:GetMouseLocation()

      for index, value in ipairs(v31:GetChildren()) do
        local humanoid = value:FindFirstChildOfClass("Humanoid")
        local findFirstChild = value:FindFirstChild(v1.AimPart)

        if humanoid and humanoid.Health > 0 and findFirstChild then
          if v1.IgnoreKnocked and humanoid:GetState() == Enum.HumanoidStateType.Dead then
          else
            local v34 = f17(value, findFirstChild)
            local v35, v36 = currentCamera:WorldToViewportPoint(v34)

            if v36 and f16(v34) then
              local magnitude = (Vector2.new(v35.X, v35.Y) - getMouseLocation).Magnitude

              if magnitude < fovRadius then
                fovRadius = magnitude
                v33 = findFirstChild
              end
            end
          end
        end
      end

      return v33
    end
  end

  function f17(p3, p4)
    if not v1.PredictMovement then
      return p4.Position
    end

    return p4.Position + p3.HumanoidRootPart.Velocity * v1.PredictionAmount
  end

  userInputService.InputBegan:Connect(function(input)
    if input.UserInputType == v1.AimKey then
      v2 = true
    end
  end)

  userInputService.InputEnded:Connect(function(input2)
    if input2.UserInputType == v1.AimKey then
      v2 = false
    end
  end)

  runService.RenderStepped:Connect(function()
    if v1.ShowFOV then
      circle.Position = userInputService:GetMouseLocation()
      circle.Radius = v1.FOVRadius
      circle.Visible = true
    else
      circle.Visible = false
    end

    if not v2 or not f15() or not v1.Enabled then
      return
    else
      local v37 = f2()

      if v37 then
        local worldToViewportPoint = currentCamera:WorldToViewportPoint((f17(v37.Parent, v37)))
        local getMouseLocation2 = userInputService:GetMouseLocation()
        local v38 = (worldToViewportPoint.X - getMouseLocation2.X) / v1.Smoothing
        local v39 = (worldToViewportPoint.Y - getMouseLocation2.Y) / v1.Smoothing

        if mousemoverel then
          mousemoverel(v38, v39)
        end

        if v1.AutoShoot and mouse1click then
          mouse1click()
        end
      end

      return
    end
  end)

  combatTab:CreateSection("Aimbot Settings")

  combatTab:CreateToggle({
    Name = "Enable Aimbot",
    CurrentValue = false,
    Flag = "AimbotToggle",
    Callback = function(value2) v1.Enabled = value2 end,
  })

  combatTab:CreateToggle({
    Name = "Show FOV Circle",
    CurrentValue = false,
    Flag = "FOVToggle",
    Callback = function(value3) v1.ShowFOV = value3 end,
  })

  combatTab:CreateSlider({
    Name = "FOV Radius",
    Range = { 10, 500 },
    Increment = 10,
    Suffix = "px",
    CurrentValue = 100,
    Flag = "FOVSlider",
    Callback = function(value4) v1.FOVRadius = value4 end,
  })

  combatTab:CreateSlider({
    Name = "Smoothing",
    Range = { 0.1, 10 },
    Increment = 0.1,
    Suffix = "",
    CurrentValue = 3,
    Flag = "AimbotSmoothing",
    Callback = function(value5) v1.Smoothing = value5 end,
  })

  combatTab:CreateDropdown({
    Name = "Aim Part",
    Options = { "Head", "HumanoidRootPart", "UpperTorso", "LowerTorso" },
    CurrentOption = { "Head" },
    Flag = "AimPart",
    Callback = function(value6) v1.AimPart = value6[1] end,
  })

  combatTab:CreateToggle({
    Name = "Prediction",
    CurrentValue = false,
    Flag = "PredictionToggle",
    Callback = function(value7) v1.PredictMovement = value7 end,
  })

  combatTab:CreateSlider({
    Name = "Prediction Amount",
    Range = { 0.05, 0.5 },
    Increment = 0.01,
    Suffix = "",
    CurrentValue = 0.1,
    Flag = "PredictionAmount",
    Callback = function(value8) v1.PredictionAmount = value8 end,
  })

  combatTab:CreateToggle({
    Name = "Visibility Check",
    CurrentValue = true,
    Flag = "VisCheckToggle",
    Callback = function(value9) v1.VisibilityCheck = value9 end,
  })

  combatTab:CreateToggle({
    Name = "Auto Shoot",
    CurrentValue = false,
    Flag = "AutoShootToggle",
    Callback = function(value10) v1.AutoShoot = value10 end,
  })

  v3 = {
    Enabled = false,
    Delay = 0,
    HeadOnly = false,
    BurstMode = false,
    BurstCount = 3,
    BurstDelay = 50,
  }

  combatTab:CreateSection("TriggerBot Settings")

  combatTab:CreateToggle({
    Name = "Enable TriggerBot",
    CurrentValue = false,
    Flag = "TriggerBotToggle",
    Callback = function(value11) v3.Enabled = value11 end,
  })

  combatTab:CreateSlider({
    Name = "Shot Delay",
    Range = { 0, 500 },
    Increment = 10,
    Suffix = "ms",
    CurrentValue = 0,
    Flag = "TriggerBotDelay",
    Callback = function(value12) v3.Delay = value12 end,
  })

  combatTab:CreateToggle({
    Name = "Head Only",
    CurrentValue = false,
    Flag = "HeadOnlyToggle",
    Callback = function(value13) v3.HeadOnly = value13 end,
  })

  combatTab:CreateToggle({
    Name = "Burst Mode",
    CurrentValue = false,
    Flag = "BurstModeToggle",
    Callback = function(value14) v3.BurstMode = value14 end,
  })

  combatTab:CreateSlider({
    Name = "Burst Count",
    Range = { 2, 10 },
    Increment = 1,
    Suffix = " shots",
    CurrentValue = 3,
    Flag = "BurstCount",
    Callback = function(value15) v3.BurstCount = value15 end,
  })

  task.spawn(function()
    while task.wait(0.01) do
      if v3.Enabled and f15() then
        local viewportSize = currentCamera.ViewportSize

        local viewportPointToRay = currentCamera:ViewportPointToRay(
          viewportSize.X / 2, viewportSize.Y / 2
        )

        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude

        local v40 = { currentCamera }

        if localPlayer.Character then
          table.insert(v40, localPlayer.Character)
        end

        raycastParams.FilterDescendantsInstances = v40

        local raycast = workspaceService:Raycast(
          viewportPointToRay.Origin, viewportPointToRay.Direction * 1000, raycastParams
        )

        if raycast and raycast.Instance then
          local instance = raycast.Instance
          local model = instance:FindFirstAncestorOfClass("Model")

          if model and model:FindFirstChildOfClass("Humanoid") then
            local v41 = f1()

            if v41 and model.Parent == v41 then
              local humanoid2 = model:FindFirstChildOfClass("Humanoid")

              if humanoid2 and humanoid2.Health > 0 then
                if v3.HeadOnly and instance.Name ~= "Head" then
                else
                  if v3.Delay > 0 then
                    task.wait(v3.Delay / 1000)
                  end

                  if v3.BurstMode and mouse1click then
                    for i = 1, v3.BurstCount do
                      mouse1click()
                      task.wait(v3.BurstDelay / 1000)
                    end
                  elseif mouse1click then
                    mouse1click()
                  end

                  task.wait(0.1)
                end
              end
            end
          end
        end
      end
    end
  end)

  v4 = {
    Enabled = false,
    Size = 3,
    Transparency = 0.5,
    CanCollide = false,
    Material = "ForceField",
  }

  v5 = {}

  combatTab:CreateSection("Hitbox Expander")

  combatTab:CreateToggle({
    Name = "Enable Hitbox",
    CurrentValue = false,
    Flag = "HitboxToggle",
    Callback = function(value16) v4.Enabled = value16 end,
  })

  combatTab:CreateSlider({
    Name = "Hitbox Size",
    Range = { 1, 10 },
    Increment = 0.5,
    Suffix = " studs",
    CurrentValue = 3,
    Flag = "HitboxSize",
    Callback = function(value17) v4.Size = value17 end,
  })

  combatTab:CreateSlider({
    Name = "Transparency",
    Range = { 0, 1 },
    Increment = 0.1,
    Suffix = "",
    CurrentValue = 0.5,
    Flag = "HitboxTransparency",
    Callback = function(value18) v4.Transparency = value18 end,
  })

  task.spawn(function()
    while task.wait(0.3) do
      local v42 = f1()

      if v42 then
        for index2, value19 in ipairs(v42:GetChildren()) do
          local head = value19:FindFirstChild("Head")
          local humanoid3 = value19:FindFirstChildOfClass("Humanoid")

          if head and humanoid3 and humanoid3.Health > 0 then
            if not v5[head] then
              v5[head] = {
                Size = head.Size,
                Transparency = head.Transparency,
                CanCollide = head.CanCollide,
                Material = head.Material,
              }
            end

            if v4.Enabled then
              head.Size = Vector3.new(v4.Size, v4.Size, v4.Size)
              head.Transparency = v4.Transparency
              head.CanCollide = false
              head.Massless = true
            elseif v5[head] then
              head.Size = v5[head].Size
              head.Transparency = v5[head].Transparency
              head.CanCollide = v5[head].CanCollide
            end
          end
        end
      end
    end
  end)

  v6 = {
    SpinbotEnabled = false,
    SpinSpeed = 50,
    AntiAimEnabled = false,
    JitterEnabled = false,
    JitterSpeed = 10,
    FakeLagEnabled = false,
    FakeLagAmount = 3,
    AutoPeekEnabled = false,
  }

  rageTab:CreateSection("Spinbot")

  rageTab:CreateToggle({
    Name = "Enable Spinbot",
    CurrentValue = false,
    Flag = "SpinbotToggle",
    Callback = function(value20)
      v6.SpinbotEnabled = value20

      if value20 then
        f12("Spinbot", "Spinbot activated", 2)
      end
    end,
  })

  rageTab:CreateSlider({
    Name = "Spin Speed",
    Range = { 1, 100 },
    Increment = 1,
    Suffix = "",
    CurrentValue = 50,
    Flag = "SpinSpeed",
    Callback = function(value21) v6.SpinSpeed = value21 end,
  })

  v7 = 0

  runService.RenderStepped:Connect(function(delta)
    if v6.SpinbotEnabled and f15() and localPlayer.Character then
      local humanoidRootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart then
        v7 = (v7 + v6.SpinSpeed * delta) % 360

        humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position)
          * CFrame.Angles(0, math.rad(v7), 0)
      end
    end
  end)

  rageTab:CreateSection("Anti-Aim")

  rageTab:CreateToggle({
    Name = "Enable Anti-Aim",
    CurrentValue = false,
    Flag = "AntiAimToggle",
    Callback = function(value22) v6.AntiAimEnabled = value22 end,
  })

  rageTab:CreateToggle({
    Name = "Head Jitter",
    CurrentValue = false,
    Flag = "JitterToggle",
    Callback = function(value23) v6.JitterEnabled = value23 end,
  })

  runService.Heartbeat:Connect(function()
    if v6.JitterEnabled and f15() and localPlayer.Character then
      local head2 = localPlayer.Character:FindFirstChild("Head")

      if head2 then
        local v43 = math.random(-v6.JitterSpeed, v6.JitterSpeed)
        head2.CFrame = head2.CFrame * CFrame.Angles(0, math.rad(v43), 0)
      end
    end
  end)

  rageTab:CreateSection("Fake Lag")

  rageTab:CreateToggle({
    Name = "Enable Fake Lag",
    CurrentValue = false,
    Flag = "FakeLagToggle",
    Callback = function(value24) v6.FakeLagEnabled = value24 end,
  })

  rageTab:CreateSlider({
    Name = "Lag Amount",
    Range = { 1, 10 },
    Increment = 1,
    Suffix = " ticks",
    CurrentValue = 3,
    Flag = "FakeLagAmount",
    Callback = function(value25) v6.FakeLagAmount = value25 end,
  })

  v8 = {
    BhopEnabled = false,
    SpeedEnabled = false,
    SpeedMultiplier = 1.5,
    NoClipEnabled = false,
    InfiniteJumpEnabled = false,
    FlyEnabled = false,
    FlySpeed = 50,
  }

  miscTab:CreateSection("Movement")

  miscTab:CreateToggle({
    Name = "Bunny Hop (Hold Space)",
    CurrentValue = false,
    Flag = "BhopToggle",
    Callback = function(value26) v8.BhopEnabled = value26 end,
  })

  runService.RenderStepped:Connect(function()
    if v8.BhopEnabled and userInputService:IsKeyDown(Enum.KeyCode.Space) and f15() then
      if localPlayer.Character then
        local humanoid4 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

        if humanoid4 and humanoid4:GetState() ~= Enum.HumanoidStateType.Jumping
          and humanoid4:GetState() ~= Enum.HumanoidStateType.Freefall then
          humanoid4.Jump = true
        end
      end
    end
  end)

  miscTab:CreateToggle({
    Name = "Speed Boost",
    CurrentValue = false,
    Flag = "SpeedToggle",
    Callback = function(value27) v8.SpeedEnabled = value27 end,
  })

  miscTab:CreateSlider({
    Name = "Speed Multiplier",
    Range = { 1, 5 },
    Increment = 0.1,
    Suffix = "x",
    CurrentValue = 1.5,
    Flag = "SpeedMultiplier",
    Callback = function(value28) v8.SpeedMultiplier = value28 end,
  })

  runService.Heartbeat:Connect(function()
    if v8.SpeedEnabled and f15() and localPlayer.Character then
      local humanoid5 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid5 then
        humanoid5.WalkSpeed = 16 * v8.SpeedMultiplier
      end
    end
  end)

  miscTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfiniteJumpToggle",
    Callback = function(value29) v8.InfiniteJumpEnabled = value29 end,
  })

  userInputService.JumpRequest:Connect(function()
    if v8.InfiniteJumpEnabled and f15() and localPlayer.Character then
      local humanoid6 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid6 then
        humanoid6:ChangeState(Enum.HumanoidStateType.Jumping)
      end
    end
  end)

  v9 = {
    Enabled = false,
    Box = true,
    BoxOutline = true,
    BoxColor = Color3.fromRGB(138, 43, 226),
    Name = true,
    NameColor = Color3.new(1, 1, 1),
    Health = true,
    HealthBar = true,
    Distance = true,
    DistanceColor = Color3.fromRGB(200, 200, 200),
    Skeleton = false,
    SkeletonColor = Color3.fromRGB(255, 255, 255),
    Tracers = false,
    TracersColor = Color3.fromRGB(138, 43, 226),
    TracersFrom = "Bottom",
    Chams = false,
    ChamsColor = Color3.fromRGB(138, 43, 226),
    MaxDistance = 1000,
  }

  function f3()
    local v44 = {
      boxOutline = Drawing.new("Square"),
      box = Drawing.new("Square"),
      name = Drawing.new("Text"),
      distance = Drawing.new("Text"),
      healthOutline = Drawing.new("Line"),
      healthBar = Drawing.new("Line"),
      tracer = Drawing.new("Line"),
    }

    v44.boxOutline.Thickness = 3
    v44.boxOutline.Filled = false
    v44.boxOutline.Color = Color3.new(0, 0, 0)
    v44.boxOutline.Transparency = 1
    v44.box.Thickness = 2
    v44.box.Filled = false
    v44.box.Color = v9.BoxColor
    v44.box.Transparency = 1
    v44.name.Center = true
    v44.name.Outline = true
    v44.name.Color = v9.NameColor
    v44.name.Size = 16
    v44.name.Font = 2
    v44.distance.Center = true
    v44.distance.Outline = true
    v44.distance.Color = v9.DistanceColor
    v44.distance.Size = 13
    v44.distance.Font = 2
    v44.healthOutline.Thickness = 4
    v44.healthOutline.Color = Color3.new(0, 0, 0)
    v44.healthOutline.Transparency = 1
    v44.healthBar.Thickness = 2
    v44.healthBar.Color = Color3.new(0, 1, 0)
    v44.healthBar.Transparency = 1
    v44.tracer.Thickness = 2
    v44.tracer.Color = v9.TracersColor
    v44.tracer.Transparency = 1

    return v44
  end

  v10 = {}

  runService.RenderStepped:Connect(function()
    local v45 = not v9.Enabled
    local vector

    if v45 or not f15() then
      for key, value30 in pairs(v10) do
        for key2, value31 in pairs(value30) do
          value31.Visible = false
        end
      end

      return
    else
      local v46 = f1()

      if not v46 then
        return
      else
        local v47 = {}

        for index3, value32 in ipairs(v46:GetChildren()) do
          local humanoid7 = value32:FindFirstChildOfClass("Humanoid")
          local humanoidRootPart2 = value32:FindFirstChild("HumanoidRootPart")
          local v48 = humanoid7
          local head3 = value32:FindFirstChild("Head")

          if humanoid7 then
            v48 = humanoid7.Health > 0 and humanoidRootPart2 and head3
          end

          if v48 then
            v47[value32] = true
            local magnitude2 = (currentCamera.CFrame.Position - humanoidRootPart2.Position).Magnitude

            if magnitude2 > v9.MaxDistance then
            else
              if not v10[value32] then
                v10[value32] = f3()
              end

              local v49 = v10[value32]
              local v50, v51 = currentCamera:WorldToViewportPoint(humanoidRootPart2.Position)

              local worldToViewportPoint2 = currentCamera:WorldToViewportPoint(head3.Position + Vector3.new(
                0, 0.5, 0
              ))

              local worldToViewportPoint3 = currentCamera:WorldToViewportPoint(humanoidRootPart2.Position - Vector3.new(
                0, 3, 0
              ))

              if v51 then
                local v52 = math.abs(worldToViewportPoint2.Y - worldToViewportPoint3.Y)
                local v53 = math.abs(worldToViewportPoint2.Y - worldToViewportPoint3.Y) / 2
                local v54 = math.floor(magnitude2)

                if v9.Box then
                  if v9.BoxOutline then
                    v49.boxOutline.Size = Vector2.new(v53, v52)

                    v49.boxOutline.Position = Vector2.new(
                      v50.X - v53 / 2, worldToViewportPoint2.Y
                    )

                    v49.boxOutline.Visible = true
                  else
                    v49.boxOutline.Visible = false
                  end

                  v49.box.Size = Vector2.new(v53, v52)
                  v49.box.Position = Vector2.new(v50.X - v53 / 2, worldToViewportPoint2.Y)
                  v49.box.Color = v9.BoxColor
                  v49.box.Filled = v9.BoxFilled
                  v49.box.Transparency = v9.BoxFilled and 0.3 or 1
                  v49.box.Visible = true
                else
                  local box = v49.box
                  v49.boxOutline.Visible = false
                  box.Visible = false
                end

                if v9.HealthBar then
                  local v55 = humanoid7.Health / humanoid7.MaxHealth
                  local v56 = v50.X - v53 / 2 - 6

                  v49.healthOutline.From = Vector2.new(v56, worldToViewportPoint2.Y - 1)
                  v49.healthOutline.To = Vector2.new(v56, worldToViewportPoint2.Y + v52 + 1)
                  v49.healthOutline.Visible = true
                  v49.healthBar.From = Vector2.new(v56, worldToViewportPoint2.Y + v52)
                  v49.healthBar.To = Vector2.new(v56, worldToViewportPoint2.Y + v52 - v52 * v55)
                  v49.healthBar.Color = Color3.new(1 - v55, v55, 0)
                  v49.healthBar.Visible = true
                else
                  local healthBar = v49.healthBar
                  v49.healthOutline.Visible = false
                  healthBar.Visible = false
                end

                if v9.Name then
                  v49.name.Text = value32.Name
                  v49.name.Position = Vector2.new(v50.X, worldToViewportPoint2.Y - 20)
                  v49.name.Color = v9.NameColor
                  v49.name.Visible = true
                else
                  v49.name.Visible = false
                end

                if v9.Distance then
                  v49.distance.Text = "[" .. v54 .. "m]"
                  v49.distance.Position = Vector2.new(v50.X, worldToViewportPoint2.Y + v52 + 2)
                  v49.distance.Color = v9.DistanceColor
                  v49.distance.Visible = true
                else
                  v49.distance.Visible = false
                end

                if v9.Tracers then
                  if v9.TracersFrom == "Top" then
                    vector = Vector2.new(currentCamera.ViewportSize.X / 2, 0)
                  elseif v9.TracersFrom == "Middle" then
                    vector = Vector2.new(
                      currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y / 2
                    )
                  else
                    vector = Vector2.new(
                      currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y
                    )
                  end

                  v49.tracer.From = vector
                  v49.tracer.To = Vector2.new(v50.X, v50.Y)
                  v49.tracer.Color = v9.TracersColor
                  v49.tracer.Visible = true
                else
                  v49.tracer.Visible = false
                end
              else
                for key3, value33 in pairs(v49) do
                  value33.Visible = false
                end
              end
            end
          end
        end

        for key4, value34 in pairs(v10) do
          if not v47[key4] then
            for key5, value35 in pairs(value34) do
              value35:Remove()
            end

            v10[key4] = nil
          end
        end

        return
      end
    end
  end)

  local color = Color3.fromRGB(138, 43, 226)
  local color2 = Color3.fromRGB(138, 43, 226)

  function f4(p5)
    for key6, value36 in pairs(p5:GetDescendants()) do
      if value36:IsA("BasePart") or value36:IsA("MeshPart") then
        if v12[value36] then
          value36.Transparency = v12[value36].OriginalTransparency
          value36.Material = v12[value36].OriginalMaterial
          value36.Color = v12[value36].OriginalColor

          v12[value36] = nil
        end

        local highlight = value36:FindFirstChildOfClass("Highlight")

        if highlight then
          highlight:Destroy()
        end
      end
    end
  end

  v11 = {
    Enabled = false,
    Color = color,
    Transparency = 0.5,
    Material = Enum.Material.ForceField,
    Rainbow = false,
    Glow = false,
    GlowColor = color2,
    GlowTransparency = 0.3,
  }

  v12 = {}

  function f18(p6)
    if not v11.Enabled then
      return
    end

    for key7, value37 in pairs(p6:GetDescendants()) do
      if value37:IsA("BasePart") or value37:IsA("MeshPart") then
        if not v12[value37] then
          v12[value37] = {
            OriginalTransparency = value37.Transparency,
            OriginalMaterial = value37.Material,
            OriginalColor = value37.Color,
          }
        end

        local color3 = v11.Color

        if v11.Rainbow then
          local v57 = tick()
          color3 = Color3.fromHSV(v57 % 10 / 10, 1, 1)
        end

        value37.Transparency = v11.Transparency
        value37.Material = v11.Material
        value37.Color = color3

        if v11.Glow then
          local highlight2 = value37:FindFirstChildOfClass("Highlight")

          if not highlight2 then
            highlight2 = Instance.new("Highlight")
            highlight2.Parent = value37
          end

          highlight2.FillColor = v11.GlowColor
          highlight2.OutlineColor = v11.GlowColor
          highlight2.FillTransparency = v11.GlowTransparency
          highlight2.OutlineTransparency = 0
          highlight2.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

          if v11.Rainbow then
            local v58 = tick() % 10 / 10
            highlight2.FillColor = Color3.fromHSV(v58, 1, 1)
            highlight2.OutlineColor = Color3.fromHSV(v58, 1, 1)
          end
        else
          local highlight3 = value37:FindFirstChildOfClass("Highlight")

          if highlight3 then
            highlight3:Destroy()
          end
        end
      end
    end
  end

  task.spawn(function()
    while task.wait(0.1) do
      if v11.Enabled and f15() then
        local v59 = f1()

        if v59 then
          for index4, value38 in ipairs(v59:GetChildren()) do
            local humanoid8 = value38:FindFirstChildOfClass("Humanoid")

            if humanoid8 and humanoid8.Health > 0 then
              f18(value38)
            end
          end
        end
      else
        for key8, value39 in pairs(v12) do
          if key8 and key8.Parent then
            f4(key8)
          end
        end

        v12 = {}
      end
    end
  end)

  visualsTab:CreateSection("ESP Master")

  visualsTab:CreateToggle({
    Name = "Enable ESP",
    CurrentValue = false,
    Flag = "ESPToggle",
    Callback = function(value40) v9.Enabled = value40 end,
  })

  visualsTab:CreateSlider({
    Name = "Max Distance",
    Range = { 100, 5000 },
    Increment = 100,
    Suffix = " studs",
    CurrentValue = 1000,
    Flag = "MaxDistance",
    Callback = function(value41) v9.MaxDistance = value41 end,
  })

  visualsTab:CreateSection("Box ESP")

  visualsTab:CreateToggle({
    Name = "Show Box",
    CurrentValue = true,
    Flag = "EspBoxToggle",
    Callback = function(value42) v9.Box = value42 end,
  })

  visualsTab:CreateToggle({
    Name = "Box Filled",
    CurrentValue = false,
    Flag = "EspBoxFilled",
    Callback = function(value43) v9.BoxFilled = value43 end,
  })

  visualsTab:CreateToggle({
    Name = "Box Outline",
    CurrentValue = true,
    Flag = "EspBoxOutline",
    Callback = function(value44) v9.BoxOutline = value44 end,
  })

  visualsTab:CreateColorPicker({
    Name = "Box Color",
    Color = Color3.fromRGB(138, 43, 226),
    Flag = "BoxColor",
    Callback = function(value45) v9.BoxColor = value45 end,
  })

  visualsTab:CreateSection("Health ESP")

  visualsTab:CreateToggle({
    Name = "Show Health Bar",
    CurrentValue = true,
    Flag = "EspHealthToggle",
    Callback = function(value46) v9.HealthBar = value46 end,
  })

  visualsTab:CreateSection("Text ESP")

  visualsTab:CreateToggle({
    Name = "Show Name",
    CurrentValue = true,
    Flag = "EspNameToggle",
    Callback = function(value47) v9.Name = value47 end,
  })

  visualsTab:CreateColorPicker({
    Name = "Name Color",
    Color = Color3.new(1, 1, 1),
    Flag = "NameColor",
    Callback = function(value48) v9.NameColor = value48 end,
  })

  visualsTab:CreateToggle({
    Name = "Show Distance",
    CurrentValue = true,
    Flag = "EspDistanceToggle",
    Callback = function(value49) v9.Distance = value49 end,
  })

  visualsTab:CreateColorPicker({
    Name = "Distance Color",
    Color = Color3.fromRGB(200, 200, 200),
    Flag = "DistanceColor",
    Callback = function(value50) v9.DistanceColor = value50 end,
  })

  visualsTab:CreateSection("Tracers")

  visualsTab:CreateToggle({
    Name = "Show Tracers",
    CurrentValue = false,
    Flag = "TracersToggle",
    Callback = function(value51) v9.Tracers = value51 end,
  })

  visualsTab:CreateDropdown({
    Name = "Tracers From",
    Options = { "Top", "Middle", "Bottom" },
    CurrentOption = { "Bottom" },
    Flag = "TracersFrom",
    Callback = function(value52) v9.TracersFrom = value52[1] end,
  })

  visualsTab:CreateColorPicker({
    Name = "Tracers Color",
    Color = Color3.fromRGB(138, 43, 226),
    Flag = "TracersColor",
    Callback = function(value53) v9.TracersColor = value53 end,
  })

  visualsTab:CreateSection("Chams & Glow")

  visualsTab:CreateToggle({
    Name = "Enable Chams",
    CurrentValue = false,
    Flag = "ChamsToggle",
    Callback = function(value54)
      v11.Enabled = value54

      if value54 then
        f12("Chams", "Chams activated", 2)
      end
    end,
  })

  visualsTab:CreateColorPicker({
    Name = "Chams Color",
    Color = Color3.fromRGB(138, 43, 226),
    Flag = "ChamsColor",
    Callback = function(value55) v11.Color = value55 end,
  })

  visualsTab:CreateSlider({
    Name = "Chams Transparency",
    Range = { 0, 1 },
    Increment = 0.05,
    Suffix = "",
    CurrentValue = 0.5,
    Flag = "ChamsTransparency",
    Callback = function(value56) v11.Transparency = value56 end,
  })

  visualsTab:CreateDropdown({
    Name = "Chams Material",
    Options = { "ForceField", "Neon", "Glass", "Plastic", "Metal" },
    CurrentOption = { "ForceField" },
    Flag = "ChamsMaterial",
    Callback = function(value57) v11.Material = Enum.Material[value57[1]] end,
  })

  visualsTab:CreateToggle({
    Name = "Rainbow Chams",
    CurrentValue = false,
    Flag = "RainbowChams",
    Callback = function(value58) v11.Rainbow = value58 end,
  })

  visualsTab:CreateToggle({
    Name = "Enable Glow",
    CurrentValue = false,
    Flag = "GlowToggle",
    Callback = function(value59)
      v11.Glow = value59

      if value59 then
        f12("Glow ESP", "Glow effect activated", 2)
      end
    end,
  })

  visualsTab:CreateColorPicker({
    Name = "Glow Color",
    Color = Color3.fromRGB(138, 43, 226),
    Flag = "GlowColor",
    Callback = function(value60) v11.GlowColor = value60 end,
  })

  visualsTab:CreateSlider({
    Name = "Glow Transparency",
    Range = { 0, 1 },
    Increment = 0.05,
    Suffix = "",
    CurrentValue = 0.3,
    Flag = "GlowTransparency",
    Callback = function(value61) v11.GlowTransparency = value61 end,
  })

  v13 = {
    AntiFlashEnabled = false,
    AntiSmokeEnabled = false,
    FullbrightEnabled = false,
    NoFogEnabled = false,
    CustomFOV = false,
    FOVValue = 70,
    CustomAmbient = false,
    AmbientColor = Color3.fromRGB(255, 255, 255),
  }

  visualsTab:CreateSection("World Effects")

  visualsTab:CreateToggle({
    Name = "Anti-Flashbang",
    CurrentValue = false,
    Flag = "AntiFlashToggle",
    Callback = function(value62) v13.AntiFlashEnabled = value62 end,
  })

  visualsTab:CreateToggle({
    Name = "Anti-Smoke",
    CurrentValue = false,
    Flag = "AntiSmokeToggle",
    Callback = function(value63) v13.AntiSmokeEnabled = value63 end,
  })

  visualsTab:CreateToggle({
    Name = "Fullbright",
    CurrentValue = false,
    Flag = "FullbrightToggle",
    Callback = function(value64)
      v13.FullbrightEnabled = value64

      if value64 then
        lighting.Brightness = 2
        lighting.ClockTime = 14
        lighting.FogEnd = 100000
        lighting.GlobalShadows = false
        lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
      else
        lighting.Brightness = 1
        lighting.ClockTime = 12
        lighting.FogEnd = 1000
        lighting.GlobalShadows = true
      end
    end,
  })

  visualsTab:CreateToggle({
    Name = "No Fog",
    CurrentValue = false,
    Flag = "NoFogToggle",
    Callback = function(value65)
      v13.NoFogEnabled = value65

      if value65 then
        lighting.FogEnd = 100000
      else
        lighting.FogEnd = 1000
      end
    end,
  })

  visualsTab:CreateToggle({
    Name = "Custom FOV",
    CurrentValue = false,
    Flag = "CustomFOVToggle",
    Callback = function(value66) v13.CustomFOV = value66 end,
  })

  visualsTab:CreateSlider({
    Name = "FOV Value",
    Range = { 60, 120 },
    Increment = 1,
    Suffix = "°",
    CurrentValue = 70,
    Flag = "FOVValue",
    Callback = function(value67) v13.FOVValue = value67 end,
  })

  visualsTab:CreateToggle({
    Name = "Custom Ambient",
    CurrentValue = false,
    Flag = "CustomAmbientToggle",
    Callback = function(value68) v13.CustomAmbient = value68 end,
  })

  visualsTab:CreateColorPicker({
    Name = "Ambient Color",
    Color = Color3.fromRGB(255, 255, 255),
    Flag = "AmbientColor",
    Callback = function(value69) v13.AmbientColor = value69 end,
  })

  runService.RenderStepped:Connect(function()
    if v13.CustomFOV then
      currentCamera.FieldOfView = v13.FOVValue
    end

    if v13.CustomAmbient then
      lighting.Ambient = v13.AmbientColor
      lighting.OutdoorAmbient = v13.AmbientColor
    end
  end)

  task.spawn(function()
    while task.wait(0.2) do
      if v13.AntiFlashEnabled then
        local flashbangEffect = localPlayer.PlayerGui:FindFirstChild("FlashbangEffect")
        local flashbangColorCorrection = lighting:FindFirstChild("FlashbangColorCorrection")

        if flashbangEffect then
          flashbangEffect:Destroy()
        end

        if flashbangColorCorrection then
          flashbangColorCorrection:Destroy()
        end
      end
    end
  end)

  task.spawn(function()
    while task.wait(0.5) do
      if v13.AntiSmokeEnabled then
        local debris = workspaceService:FindFirstChild("Debris")

        if debris then
          for index5, value70 in ipairs(debris:GetChildren()) do
            if string.match(value70.Name, "Voxel") then
              value70:ClearAllChildren()
              value70:Destroy()
            end
          end
        end
      end
    end
  end)

  skinsTab:CreateSection("Skin System")
  v14 = false
  v15 = "Butterfly Knife"

  skinsTab:CreateToggle({
    Name = "Enable Skin Changer",
    CurrentValue = false,
    Flag = "SkinChangerToggle",
    Callback = function(value71)
      v14 = value71

      if value71 then
        f12("Skin Changer", "Skin changer enabled", 2)
      end
    end,
  })

  skinsTab:CreateToggle({
    Name = "Enable Custom Knife",
    CurrentValue = false,
    Flag = "CustomKnifeToggle",
    Callback = function(value72) end,
  })

  skinsTab:CreateDropdown({
    Name = "Select Knife",
    Options = { "Butterfly Knife", "Karambit", "M9 Bayonet", "Flip Knife", "Gut Knife" },
    CurrentOption = { "Butterfly Knife" },
    Flag = "KnifeDropdown",
    Callback = function(value73) v15 = value73[1] end,
  })

  miscTab:CreateSection("Utility")

  miscTab:CreateButton({
    Name = "🔄 Respawn Character",
    Callback = function()
      if localPlayer.Character then
        localPlayer.Character:BreakJoints()
        f12("Respawn", "Respawning character...", 2)
      end
    end,
  })

  miscTab:CreateButton({
    Name = "🗑️ Remove Ragdolls",
    Callback = function()
      local count = 0

      for key9, value74 in pairs(workspaceService:GetDescendants()) do
        if value74.Name == "Ragdoll" then
          value74:Destroy()
          count = count + 1
        end
      end

      f12("Cleanup", "Removed " .. count .. " ragdolls", 2)
    end,
  })

  miscTab:CreateSection("Anti-AFK")

  v16 = false

  miscTab:CreateToggle({
    Name = "Enable Anti-AFK",
    CurrentValue = false,
    Flag = "AntiAFKToggle",
    Callback = function(value75)
      v16 = value75

      if value75 then
        f12("Anti-AFK", "Anti-AFK enabled", 2)
      end
    end,
  })

  task.spawn(function()
    while task.wait(60) do
      if v16 then
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new())
      end
    end
  end)

  miscTab:CreateSection("Server Info")
  miscTab:CreateLabel("Server: " .. game.JobId, "server", Color3.fromRGB(150, 150, 150), false)

  miscTab:CreateLabel(
    "Players: " .. #players:GetPlayers() .. "/" .. players.MaxPlayers, "users",
    Color3.fromRGB(150, 150, 150), false
  )

  miscTab:CreateLabel(
    "Ping: " .. math.floor(localPlayer:GetNetworkPing() * 1000) .. "ms", "wifi",
    Color3.fromRGB(150, 150, 150), false
  )

  configTab:CreateSection("Menu Customization")

  configTab:CreateDropdown({
    Name = "Menu Theme",
    Options = {
      "Amethyst", "Default", "Ocean", "Dark", "Light", "Green", "Cherry", "AmberGlow",
    },
    CurrentOption = { "AmberGlow" },
    Flag = "MenuTheme",
    Callback = function(value76)
      local v60 = value76[1]
      f12("Theme", "Theme changed to " .. v60 .. " - Reload script to apply", 4)
      _G.NNVNTheme = v60
    end,
  })

  configTab:CreateButton({
    Name = "🎨 Apply Theme (Reload Required)",
    Callback = function() f12("Theme", "Please reload the script to apply the new theme", 3) end,
  })

  configTab:CreateSection("Configuration")

  configTab:CreateButton({
    Name = "💾 Save Config",
    Callback = function()
      ui:SaveConfiguration()
      f12("Config", "Configuration saved successfully", 3)
    end,
  })

  configTab:CreateButton({
    Name = "📂 Load Config",
    Callback = function()
      ui:LoadConfiguration()
      f12("Config", "Configuration loaded successfully", 3)
    end,
  })

  configTab:CreateButton({
    Name = "🔄 Reset Config",
    Callback = function()
      ui:ResetConfiguration()
      f12("Config", "Configuration reset to defaults", 3)
    end,
  })

  configTab:CreateSection("Script Info")
  configTab:CreateLabel("NNVN Hub v3.0.0", "info", Color3.fromRGB(138, 43, 226), false)
  configTab:CreateLabel("Blox Strike Script", "crosshair", Color3.fromRGB(150, 150, 150), false)

  configTab:CreateLabel(
    "Made with ❤️ by N0NAMEVN", "heart", Color3.fromRGB(255, 100, 100), false
  )

  ui:LoadConfiguration()
  f12("NNVN Hub", "All systems loaded successfully!", 4)
  v17 = false
  v18 = false
  v19 = false
  v20 = false
  v21 = 0

  pcall(function()
    replicatedStorage.Assets.Weapons.Karambit.Camera.ViewmodelLight.Transparency = 1
  end)

  local cframe = CFrame.new(0, -1.5, 1.5)
  local cframe2 = CFrame.new(0, -1.5, 1.5)
  local cframe3 = CFrame.new(0, -1.5, 1)
  local cframe4 = CFrame.new(0, -1.5, 1.25)
  local cframe5 = CFrame.new(0, -1.5, 0.5)

  function f5(p7, p8)
    local findFirstChild2 = replicatedStorage.Sounds:FindFirstChild(v15)

    if not findFirstChild2 then
      return
    end

    local clone2 = findFirstChild2:WaitForChild(p7):WaitForChild(p8):Clone()
    clone2.Parent = currentCamera
    clone2:Play()
    clone2.Ended:Once(function() clone2:Destroy() end)

    return clone2
  end

  v22 = {
    Karambit = { Offset = cframe },
    ["Butterfly Knife"] = { Offset = cframe2 },
    ["M9 Bayonet"] = { Offset = cframe3 },
    ["Flip Knife"] = { Offset = cframe4 },
    ["Gut Knife"] = { Offset = cframe5 },
  }

  clone = nil
  animator = nil
  loadAnimation = nil

  function f6()
    v18 = false

    contextActionService:UnbindAction("InspectKnifeAction")
    contextActionService:UnbindAction("AttackKnifeAction")

    if clone then
      clone:Destroy()
      clone = nil
    end

    animator = nil
    v19 = false
    v20 = false
  end

  loadAnimation2 = nil
  loadAnimation3 = nil

  function f7(p9)
    for v61, v62 in p9:GetDescendants() do
      if v62:IsA("BasePart") or v62:IsA("MeshPart") or v62:IsA("Texture") then
        v62.Transparency = 1
      end
    end
  end

  loadAnimation4 = nil
  loadAnimation5 = nil

  function f8()
    return currentCamera:FindFirstChild("T Knife") or currentCamera:FindFirstChild("CT Knife")
  end

  loadAnimation6 = nil

  function f9(p10)
    for v63, v64 in p10:GetDescendants() do
      f19(v64)
    end
  end

  function f19(p11)
    if not p11:IsA("BasePart") then
      return
    end

    p11.CanCollide = false
    p11.Anchored = false
    p11.CastShadow = false
    p11.CanTouch = false
    p11.CanQuery = false
  end

  function f10(p12, p13, p14, name, c0)
    local findFirstChild3 = clone:FindFirstChild(p13)

    if not findFirstChild3 then
      return
    else
      local clone3 = p12:WaitForChild(p14):Clone()
      f19(clone3)

      clone3.Name = name
      clone3.Parent = findFirstChild3

      local motor6D = Instance.new("Motor6D")
      motor6D.Part0 = findFirstChild3
      motor6D.Part1 = clone3
      motor6D.C0 = c0
      motor6D.Parent = findFirstChild3

      return
    end
  end

  function f11(p15, p16, p17)
    if p16 ~= Enum.UserInputState.Begin or not v18 or not animator or not f15() then
      return Enum.ContextActionResult.Pass
    elseif p15 == "InspectKnifeAction" then
      if loadAnimation and loadAnimation.IsPlaying or v19 or v20 then
        return Enum.ContextActionResult.Pass
      end

      v19 = true

      if loadAnimation2 then
        loadAnimation2:Stop()
      end

      loadAnimation3:Play()
      loadAnimation3.Stopped:Once(function() v19 = false end)

      return Enum.ContextActionResult.Pass
    elseif p15 == "AttackKnifeAction" then
      local v65 = os.clock()

      if loadAnimation and loadAnimation.IsPlaying or v65 - v21 < 1 then
        return Enum.ContextActionResult.Pass
      else
        v21 = v65

        if v19 then
          v19 = false

          if loadAnimation3 then
            loadAnimation3:Stop()
          end
        end

        v20 = true

        if loadAnimation2 then
          loadAnimation2:Stop()
        end

        local v66 = { loadAnimation4, loadAnimation5, loadAnimation6 }
        local v67 = v66[math.random(1, #v66)]
        local v68 = v67 == loadAnimation4 and "HitOne"

        local v69 = v68
        v69 = v68 or v67 == loadAnimation5 and "HitTwo" or "HitThree"

        v67:Play()
        local v70 = f5(v69, "1")

        if v70 then
          v70.Volume = 5
        end

        v67.Stopped:Once(function() v20 = false end)
        return Enum.ContextActionResult.Pass
      end
    else
      return Enum.ContextActionResult.Pass
    end
  end

  function f20(p18)
    if v18 or not v17 then
      return
    else
      local v71 = f15()

      if not v71 then
        return
      else
        v18 = true
        local waitForChild2 = replicatedStorage.Assets.Weapons:WaitForChild(v15)
        local offset = v22[v15].Offset
        clone = waitForChild2:WaitForChild("Camera"):Clone()
        local v72 = clone
        clone.Name = v15
        v72.Parent = currentCamera
        f9(clone)
        f7(p18)

        if v71.Parent.Name == "Terrorists" then
          local tGlove = replicatedStorage.Assets.Weapons:WaitForChild("T Glove")
          f10(tGlove, "Left Arm", "Left Arm", "Glove", CFrame.new(0, 0, -1.5))
          f10(tGlove, "Right Arm", "Right Arm", "Glove", CFrame.new(0, 0, -1.5))
        else
          local idf = replicatedStorage.Assets.Sleeves:WaitForChild("IDF")
          local ctGlove = replicatedStorage.Assets.Weapons:WaitForChild("CT Glove")

          f10(idf, "Left Arm", "Left Arm", "Sleeve", CFrame.new(0, 0, 0.5))
          f10(ctGlove, "Left Arm", "Left Arm", "Glove", CFrame.new(0, 0, -1.5))
          f10(idf, "Right Arm", "Right Arm", "Sleeve", CFrame.new(0, 0, 0.5))
          f10(ctGlove, "Right Arm", "Right Arm", "Glove", CFrame.new(0, 0, -1.5))
        end

        local animationController = clone:FindFirstChildOfClass("AnimationController")
          or clone:FindFirstChildOfClass("Animator")

        animator = animationController:FindFirstChildWhichIsA("Animator") or animationController
        local cameraAnimations = replicatedStorage.Assets.WeaponAnimations:WaitForChild(v15):WaitForChild("CameraAnimations")
        loadAnimation = animator:LoadAnimation(cameraAnimations:WaitForChild("Equip"))
        loadAnimation2 = animator:LoadAnimation(cameraAnimations:WaitForChild("Idle"))
        loadAnimation3 = animator:LoadAnimation(cameraAnimations:WaitForChild("Inspect"))
        loadAnimation4 = animator:LoadAnimation(cameraAnimations:WaitForChild("Heavy Swing"))
        loadAnimation5 = animator:LoadAnimation(cameraAnimations:WaitForChild("Swing1"))
        loadAnimation6 = animator:LoadAnimation(cameraAnimations:WaitForChild("Swing2"))
        clone:SetPrimaryPartCFrame(currentCamera.CFrame * CFrame.new(0, -1.5, 5))

        tweenService:Create(
          clone.PrimaryPart,
          TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
          { CFrame = currentCamera.CFrame * offset }
        ):Play()

        loadAnimation:Play()
        f5("Equip", "1")

        contextActionService:BindAction("InspectKnifeAction", f11, false, Enum.KeyCode.F)

        contextActionService:BindAction(
          "AttackKnifeAction", f11, false, Enum.UserInputType.MouseButton1
        )

        return
      end
    end
  end

  runService.RenderStepped:Connect(function()
    if not v17 or not clone or not clone.PrimaryPart then
      return
    else
      local primaryPart = clone.PrimaryPart
      primaryPart.CFrame = currentCamera.CFrame * v22[v15].Offset

      if not (loadAnimation and loadAnimation.IsPlaying) and not v19 and not v20 then
        if loadAnimation2 and not loadAnimation2.IsPlaying then
          loadAnimation2:Play()
        end
      end

      return
    end
  end)

  task.spawn(function()
    while task.wait(0.1) do
      local v73 = f15()
      local v74 = v17
      local v75 = f8()

      if v74 and v73 and v75 and not v18 then
        f20(v75)
      elseif (not v17 or not v75 or not v73) and v18 then
        f6()
      end
    end
  end)

  v23 = {}
  v24 = {}
  v25 = {}

  local v76 = {
    ["USP-S"] = true,
    ["Five-SeveN"] = true,
    MP9 = true,
    FAMAS = true,
    ["M4A1-S"] = true,
    M4A4 = true,
    AUG = true,
  }

  local v77 = {
    P250 = true,
    ["Desert Eagle"] = true,
    ["Dual Berettas"] = true,
    Negev = true,
    P90 = true,
    Nova = true,
    XM1014 = true,
    AWP = true,
    ["SSG 08"] = true,
  }

  local v78 = {
    Karambit = true,
    ["Butterfly Knife"] = true,
    ["M9 Bayonet"] = true,
    ["Flip Knife"] = true,
    ["Gut Knife"] = true,
    ["T Knife"] = true,
    ["CT Knife"] = true,
  }

  v26 = { ["Sports Gloves"] = true }
  skins = replicatedStorage:WaitForChild("Assets"):WaitForChild("Skins")

  local v79 = {
    ["HE Grenade"] = true,
    ["Incendiary Grenade"] = true,
    Molotov = true,
    ["Smoke Grenade"] = true,
    Flashbang = true,
    ["Decoy Grenade"] = true,
    C4 = true,
    ["CT Glove"] = true,
    ["T Glove"] = true,
  }

  function f21(p19)
    if not p19 or not v14 or not f15() then
      return
    end

    local v80 = v25[p19.Name]

    if not v80 then
      return
    end

    pcall(function()
      local findFirstChild4 = skins:FindFirstChild(p19.Name)

      if not findFirstChild4 then
        return
      else
        local findFirstChild5 = findFirstChild4:FindFirstChild(v80)

        local factoryNew = findFirstChild5 and findFirstChild5:FindFirstChild("Camera")
          and findFirstChild5.Camera:FindFirstChild("Factory New")

        if not factoryNew then
          return
        end

        for v81, v82 in currentCamera:GetChildren() do
          if v82:FindFirstChild("Left Arm") or v82:FindFirstChild("Right Arm") then
            local sportsGloves = skins:FindFirstChild("Sports Gloves")

            local findFirstChild6 = sportsGloves
            findFirstChild6 = sportsGloves and sportsGloves:FindFirstChild(v25["Sports Gloves"])

            local factoryNew2 = findFirstChild6 and findFirstChild6:FindFirstChild("Camera")
              and findFirstChild6.Camera:FindFirstChild("Factory New")

            if factoryNew2 then
              for v83, v84 in { "Left Arm", "Right Arm" }, nil, nil do
                local findFirstChild7 = v82:FindFirstChild(v84)
                local findFirstChild8 = factoryNew2:FindFirstChild(v84)

                if findFirstChild7 and findFirstChild8 then
                  local glove = findFirstChild7:FindFirstChild("Glove")

                  if glove then
                    local surfaceAppearance = glove:FindFirstChildOfClass("SurfaceAppearance")

                    if surfaceAppearance then
                      surfaceAppearance:Destroy()
                    end

                    local surfaceAppearance2 = findFirstChild8:Clone()
                    surfaceAppearance2.Name = "SurfaceAppearance"
                    surfaceAppearance2.Parent = glove
                  end
                end
              end
            end
          end

          if not v26[p19.Name] then
            local weapon = p19:FindFirstChild("Weapon")

            if weapon then
              for v85, v86 in weapon:GetDescendants() do
                if v86:IsA("BasePart") then
                  local findFirstChild9 = factoryNew:FindFirstChild(v86.Name)

                  if findFirstChild9 then
                    local surfaceAppearance3 = v86:FindFirstChildOfClass("SurfaceAppearance")

                    if surfaceAppearance3 then
                      surfaceAppearance3:Destroy()
                    end

                    local surfaceAppearance4 = findFirstChild9:Clone()
                    surfaceAppearance4.Name = "SurfaceAppearance"
                    surfaceAppearance4.Parent = v86
                  end
                end
              end
            end
          end
        end

        p19:SetAttribute("SkinApplied", v80)
        return
      end
    end)
  end

  skinsTab:CreateButton({
    Name = "🎲 Randomize All Skins",
    Callback = function()
      for key10, value77 in pairs(v23) do
        if #value77 > 0 then
          v2811 = value77[math.random(1, #value77)]

          if v24[key10] then
            for index6, value78 in ipairs(v24[key10]) do
            end
          end
        end
      end
    end,
  })

  local function f22(p20)
    local findFirstChild10 = skins:FindFirstChild(p20)

    if not findFirstChild10 then
      return
    else
      local v87 = {}

      for v88, v89 in findFirstChild10:GetChildren() do
        table.insert(v87, v89.Name)
      end

      v23[p20] = v87

      if not v25[p20] then
        v25[p20] = v87[1]
      end

      local dropdown = skinsTab:CreateDropdown({
        Name = p20,
        Options = v87,
        CurrentOption = { v25[p20] },
        Flag = "Skin_" .. p20,
        Callback = function(value79)
          local v90 = value79[1]
          v25[p20] = v90

          if v24[p20] then
            for v91, v92 in v24[p20], nil, nil do
              if v92.CurrentOption[1] ~= v90 then
                v92:Set({ v90 })
              end
            end
          end

          for v93, v94 in currentCamera:GetChildren() do
            v94:SetAttribute("SkinApplied", nil)
            f21(v94)
          end
        end,
      })

      v24[p20] = v24[p20] or {}
      table.insert(v24[p20], dropdown)
      return
    end
  end

  skinsTab:CreateToggle({
    Name = "Enable Custom Knife",
    CurrentValue = false,
    Flag = "KnifeToggle",
    Callback = function(value80)
      v17 = value80

      if not value80 then
        f6()
      end
    end,
  })

  skinsTab:CreateDropdown({
    Name = "Selected Custom Knife",
    Options = { "Butterfly Knife", "Karambit", "M9 Bayonet", "Flip Knife", "Gut Knife" },
    CurrentOption = { "Butterfly Knife" },
    MultipleOptions = false,
    Flag = "KnifeDropdown",
    Callback = function(value81)
      v15 = value81[1]

      if v18 then
        f6()
      end
    end,
  })

  skinsTab:CreateSection("Knives Skins")

  for key11 in pairs(v78) do
    f22(key11)
  end

  skinsTab:CreateSection("Gloves")

  for key12 in pairs(v26) do
    f22(key12)
  end

  skinsTab:CreateSection("CT Weapons")

  for key13 in pairs(v76) do
    f22(key13)
  end

  skinsTab:CreateSection("T Weapons")

  for key14 in pairs(v77) do
    f22(key14)
  end

  for v95, v96 in skins:GetChildren() do
    local name2 = v96.Name

    if not v79[name2] and not v78[name2] and not v26[name2] and not v76[name2]
      and not v77[name2] then
      f22(name2)
    end
  end

  currentCamera.ChildAdded:Connect(function(child)
    if not v14 or not f15() then
      return
    end

    task.wait(0.1)
    f21(child)
  end)

  task.spawn(function()
    while task.wait(0.5) do
      if v14 and f15() then
        for v97, v98 in currentCamera:GetChildren() do
          if v25[v98.Name] and v98:GetAttribute("SkinApplied") ~= v25[v98.Name] then
            f21(v98)
          end
        end
      end
    end
  end)

  print("NNVN Hub v3.0.0 - Loaded Successfully")
  print("NNVN Hub Loaded Successfully!")

  return
end
