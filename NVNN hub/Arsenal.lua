local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local workspaceService = game:GetService("Workspace")
local lighting = game:GetService("Lighting")
local replicatedStorage = game:GetService("ReplicatedStorage")
local teleportService = game:GetService("TeleportService")
local httpService = game:GetService("HttpService")

local v1, f1, f2, f3, localPlayer, rayfield, f4, v2, v3, v4, v5, v6, f5, f6, v7, v8, v9,
  bodyVelocity, bodyAngularVelocity, humanoid, f7, v10, walkSpeed, v11, v12, v13, v14, color,
  v15, v16, v17, v18

if not _G["2107"] then
  local localPlayer2 = players.LocalPlayer

  if localPlayer2 then
    localPlayer2:Kick("\n🛡️ Unauthorized Execution 🛡️\n\nPlease use the official Key System to run NNVN Hub")
  end

  return
else
  game:IsLoaded()

  repeat
    task.wait()
    v1 = game
  until v1:IsLoaded()

  wait(2)
  localPlayer = players.LocalPlayer
  rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

  local window = rayfield:CreateWindow({
    Name = "⚡ NNVN Hub | Arsenal",
    LoadingTitle = "NNVN Hub",
    LoadingSubtitle = "Made by N0NAMEVN",
    ConfigurationSaving = {
      Enabled = true,
      FolderName = "NNVN_Hub",
      FileName = "Arsenal_Settings",
    },
    KeySystem = false,
  })

  function f4(title, content, p1)
    rayfield:Notify({ Title = title, Content = content, Duration = p1 or 3 })
  end

  f4("⚡ NNVN Hub", "Loaded successfully! By N0NAMEVN", 5)

  local hitboxTab = window:CreateTab("Hitbox", 4483362458)
  local gunModsTab = window:CreateTab("Gun Mods", 4483362458)
  local playerTab = window:CreateTab("Player", 4483362458)
  local visualsTab = window:CreateTab("Visuals", 4483362458)
  local skinsTab = window:CreateTab("Skins", 4483362458)
  local extraTab = window:CreateTab("Extra", 4483362458)
  local infoTab = window:CreateTab("Info", 4483362458)
  local settingsTab = window:CreateTab("Settings", 4483362458)
  hitboxTab:CreateSection("Hitbox Settings")
  v2 = false
  v3 = 21
  v4 = 6

  function f1(p2)
    if v5 == "FFA" then
      return true
    end

    if v5 == "Everyone" then
      return p2 ~= localPlayer
    end

    return p2.Team ~= localPlayer.Team
  end

  v5 = "FFA"

  function f2(p3)
    if v6[p3] then
      for key, value in pairs(v6[p3]) do
        local character = p3.Character

        local findFirstChild = character
        findFirstChild = character and p3.Character:FindFirstChild(key)

        if findFirstChild and findFirstChild:IsA("BasePart") then
          findFirstChild.CanCollide = value.CanCollide
          findFirstChild.Transparency = value.Transparency
          findFirstChild.Size = value.Size
        end
      end
    end
  end

  v6 = {}

  function f5(p4, p5)
    if not v6[p4] then
      v6[p4] = {}
    end

    if not v6[p4][p5.Name] then
      v6[p4][p5.Name] = {
        CanCollide = p5.CanCollide,
        Transparency = p5.Transparency,
        Size = p5.Size,
      }
    end
  end

  function f6()
    for index, value2 in ipairs(players:GetPlayers()) do
      if value2 ~= localPlayer and value2.Character then
        if f1(value2) and v2 then
          for index2, value3 in ipairs({ "Head", "UpperTorso", "HumanoidRootPart" }) do
            local findFirstChild2 = value2.Character:FindFirstChild(value3)

            if findFirstChild2 and findFirstChild2:IsA("BasePart") then
              f5(value2, findFirstChild2)
              findFirstChild2.Size = Vector3.new(v3, v3, v3)
              findFirstChild2.Transparency = v4 / 10
            end
          end
        else
          f2(value2)
        end
      end
    end
  end

  hitboxTab:CreateToggle({
    Name = "Enable Hitbox",
    CurrentValue = false,
    Callback = function(value4)
      v2 = value4

      if not value4 then
        for index3, value5 in ipairs(players:GetPlayers()) do
          f2(value5)
        end

        v6 = {}
      end

      f6()
    end,
  })

  hitboxTab:CreateSlider({
    Name = "Hitbox Size",
    Range = { 1, 50 },
    Increment = 1,
    CurrentValue = 21,
    Callback = function(value6)
      v3 = value6

      if v2 then
        f6()
      end
    end,
  })

  hitboxTab:CreateSlider({
    Name = "Hitbox Transparency",
    Range = { 1, 10 },
    Increment = 1,
    CurrentValue = 6,
    Callback = function(value7)
      v4 = value7

      if v2 then
        f6()
      end
    end,
  })

  hitboxTab:CreateDropdown({
    Name = "Team Check",
    Options = { "FFA", "Team-Based", "Everyone" },
    CurrentOption = "FFA",
    Callback = function(value8)
      v5 = value8

      if v2 then
        f6()
      end
    end,
  })

  gunModsTab:CreateSection("Weapon Mods")
  v7 = {}

  gunModsTab:CreateToggle({
    Name = "Infinite Ammo",
    CurrentValue = false,
    Callback = function(value9) end,
  })

  gunModsTab:CreateToggle({
    Name = "Fast Reload",
    CurrentValue = false,
    Callback = function(value10)
      for key2, value11 in pairs(replicatedStorage.Weapons:GetChildren()) do
        local reloadTime = value11:FindFirstChild("ReloadTime")
        local ereloadTime = value11:FindFirstChild("EReloadTime")

        if reloadTime then
          if value10 then
            if not v7[value11] then
              v7[value11] = {}
            end

            v7[value11].ReloadTime = reloadTime.Value
            reloadTime.Value = 0.01
          elseif v7[value11] and v7[value11].ReloadTime then
            reloadTime.Value = v7[value11].ReloadTime
          end
        end

        if ereloadTime then
          if value10 then
            if not v7[value11] then
              v7[value11] = {}
            end

            v7[value11].EReloadTime = ereloadTime.Value
            ereloadTime.Value = 0.01
          elseif v7[value11] and v7[value11].EReloadTime then
            ereloadTime.Value = v7[value11].EReloadTime
          end
        end
      end
    end,
  })

  gunModsTab:CreateToggle({
    Name = "Fast Fire Rate",
    CurrentValue = false,
    Callback = function(value12)
      for key3, value13 in pairs(replicatedStorage.Weapons:GetDescendants()) do
        if value13.Name == "FireRate" or value13.Name == "BFireRate" then
          if value12 then
            if not v7[value13] then
              v7[value13] = {}
            end

            v7[value13].FireRate = value13.Value
            value13.Value = 0.02
          elseif v7[value13] and v7[value13].FireRate then
            value13.Value = v7[value13].FireRate
          end
        end
      end
    end,
  })

  gunModsTab:CreateToggle({
    Name = "No Spread",
    CurrentValue = false,
    Callback = function(value14)
      for key4, value15 in pairs(replicatedStorage.Weapons:GetDescendants()) do
        if value15.Name == "MaxSpread" or value15.Name == "Spread"
          or value15.Name == "SpreadControl" then
          if value14 then
            if not v7[value15] then
              v7[value15] = {}
            end

            v7[value15].Spread = value15.Value
            value15.Value = 0
          elseif v7[value15] and v7[value15].Spread then
            value15.Value = v7[value15].Spread
          end
        end
      end
    end,
  })

  gunModsTab:CreateToggle({
    Name = "No Recoil",
    CurrentValue = false,
    Callback = function(value16)
      for key5, value17 in pairs(replicatedStorage.Weapons:GetDescendants()) do
        if value17.Name == "RecoilControl" or value17.Name == "Recoil" then
          if value16 then
            if not v7[value17] then
              v7[value17] = {}
            end

            v7[value17].Recoil = value17.Value
            value17.Value = 0
          elseif v7[value17] and v7[value17].Recoil then
            value17.Value = v7[value17].Recoil
          end
        end
      end
    end,
  })

  playerTab:CreateSection("Movement")
  v8 = false
  v9 = 50
  bodyVelocity = nil
  bodyAngularVelocity = nil
  humanoid = nil

  function f3()
    if not v8 then
      return
    end

    if humanoid then
      humanoid.PlatformStand = false
    end

    if bodyVelocity then
      bodyVelocity:Destroy()
    end

    if bodyAngularVelocity then
      bodyAngularVelocity:Destroy()
    end

    v8 = false
  end

  function f7()
    local character2 = localPlayer.Character

    if not character2 or v8 then
      return
    end

    humanoid = character2:FindFirstChildOfClass("Humanoid")

    if not humanoid then
      return
    end

    humanoid.PlatformStand = true
    bodyVelocity = Instance.new("BodyVelocity")
    bodyAngularVelocity = Instance.new("BodyAngularVelocity")

    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
    bodyVelocity.P = 1000

    bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
    bodyAngularVelocity.MaxTorque = Vector3.new(10000, 10000, 10000)
    bodyAngularVelocity.P = 1000

    bodyVelocity.Parent = character2.Head
    bodyAngularVelocity.Parent = character2.Head
    v8 = true
  end

  playerTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Callback = function(value18)
      if value18 then
        f7()
      else
        f3()
      end
    end,
  })

  playerTab:CreateSlider({
    Name = "Fly Speed",
    Range = { 10, 500 },
    Increment = 1,
    CurrentValue = 50,
    Callback = function(value19) v9 = value19 end,
  })

  v10 = false
  walkSpeed = 16

  playerTab:CreateToggle({
    Name = "Custom WalkSpeed",
    CurrentValue = false,
    Callback = function(value20)
      v10 = value20

      if not value20 then
        local humanoid2 = localPlayer.Character
          and localPlayer.Character:FindFirstChildOfClass("Humanoid")

        if humanoid2 then
          humanoid2.WalkSpeed = 16
        end
      end
    end,
  })

  playerTab:CreateSlider({
    Name = "WalkSpeed Power",
    Range = { 16, 500 },
    Increment = 1,
    CurrentValue = 16,
    Callback = function(value21)
      walkSpeed = value21

      if v10 then
        local humanoid3 = localPlayer.Character
          and localPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid3 then
          humanoid3.WalkSpeed = value21
        end
      end
    end,
  })

  v11 = false

  playerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(value22) v11 = value22 end,
  })

  userInputService.JumpRequest:Connect(function()
    if v11 then
      local humanoid4 = localPlayer.Character
        and localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid4 then
        humanoid4:ChangeState("Jumping")
      end
    end
  end)

  v12 = false

  playerTab:CreateToggle({
    Name = "NoClip",
    CurrentValue = false,
    Callback = function(value23)
      v12 = value23
      local character3 = localPlayer.Character

      if character3 then
        for key6, value24 in pairs(character3:GetDescendants()) do
          if value24:IsA("BasePart") then
            value24.CanCollide = not value23
          end
        end
      end
    end,
  })

  visualsTab:CreateSection("Visual Settings")
  v13 = {}

  visualsTab:CreateToggle({
    Name = "X-Ray",
    CurrentValue = false,
    Callback = function(value25)
      for key7, value26 in pairs(workspaceService:GetDescendants()) do
        if value26:IsA("BasePart") then
          if value25 then
            if not v13[value26] then
              v13[value26] = value26.Transparency
            end

            value26.Transparency = 0.5
          elseif v13[value26] then
            value26.Transparency = v13[value26]
            v13[value26] = nil
          end
        end
      end
    end,
  })

  visualsTab:CreateToggle({
    Name = "Full Bright",
    CurrentValue = false,
    Callback = function(value27)
      if value27 then
        lighting.Ambient = Color3.new(1, 1, 1)
        lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
        lighting.ColorShift_Top = Color3.new(1, 1, 1)
      else
        lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
        lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
        lighting.ColorShift_Top = Color3.new(0, 0, 0)
      end
    end,
  })

  visualsTab:CreateSlider({
    Name = "FOV",
    Range = { 10, 120 },
    Increment = 1,
    CurrentValue = 70,
    Callback = function(value28)
      pcall(function() localPlayer.Settings.FOV.Value = value28 end)
    end,
  })

  skinsTab:CreateSection("Arm Skins")
  v14 = "Plastic"
  color = Color3.fromRGB(50, 50, 50)
  v15 = false

  skinsTab:CreateDropdown({
    Name = "Arm Material",
    Options = { "Plastic", "ForceField", "Wood", "Grass" },
    CurrentOption = "Plastic",
    Callback = function(value29) v14 = value29 end,
  })

  skinsTab:CreateColorPicker({
    Name = "Arm Color",
    Color = Color3.fromRGB(50, 50, 50),
    Callback = function(value30) color = value30 end,
  })

  skinsTab:CreateToggle({
    Name = "Arm Skin",
    CurrentValue = false,
    Callback = function(value31)
      v15 = value31

      if value31 then
        task.spawn(function()
          while v15 do
            task.wait(0.01)
            local arms = workspaceService.Camera:FindFirstChild("Arms")

            if arms then
              for key8, value32 in pairs(arms:GetDescendants()) do
                if (value32.Name == "Right Arm" or value32.Name == "Left Arm")
                  and value32:IsA("BasePart") then
                  value32.Material = Enum.Material[v14]
                  value32.Color = color
                end
              end
            end
          end
        end)
      end
    end,
  })

  v16 = false
  v17 = 0.0001
  v18 = 0

  skinsTab:CreateToggle({
    Name = "Rainbow Gun",
    CurrentValue = false,
    Callback = function(value33)
      v16 = value33

      if not value33 then
        v18 = 0
      end
    end,
  })

  skinsTab:CreateSlider({
    Name = "Rainbow Speed",
    Range = { 1, 10 },
    Increment = 1,
    CurrentValue = 1,
    Callback = function(value34) v17 = value34 / 10000 end,
  })

  runService.RenderStepped:Connect(function()
    if v16 then
      v18 = v18 + v17

      if v18 >= 1 then
        v18 = 0
      end

      local arms2 = workspaceService.Camera:FindFirstChild("Arms")

      if arms2 then
        for key9, value35 in pairs(arms2:GetDescendants()) do
          if value35:IsA("MeshPart") then
            value35.Color = Color3.fromHSV(v18, 1, 1)
          end
        end
      end
    end
  end)

  extraTab:CreateSection("Extra Features")

  extraTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Callback = function(value36)
      getgenv().AutoFarm = value36

      pcall(function()
        local currentCurse = replicatedStorage.wkspc.CurrentCurse
        currentCurse.Value = value36 and "Infinite Ammo" or ""
      end)
    end,
  })

  extraTab:CreateToggle({
    Name = "VIP Tag",
    CurrentValue = false,
    Callback = function(value37)
      if value37 then
        Instance.new("IntValue", localPlayer).Name = "VIP"
      elseif localPlayer:FindFirstChild("VIP") then
        localPlayer.VIP:Destroy()
      end
    end,
  })

  extraTab:CreateToggle({
    Name = "Admin Tag",
    CurrentValue = false,
    Callback = function(value38)
      if value38 then
        Instance.new("IntValue", localPlayer).Name = "IsAdmin"
      elseif localPlayer:FindFirstChild("IsAdmin") then
        localPlayer.IsAdmin:Destroy()
      end
    end,
  })

  extraTab:CreateSlider({
    Name = "Time Scale",
    Range = { 0.1, 10 },
    Increment = 0.1,
    CurrentValue = 1,
    Callback = function(value39) end,
  })

  infoTab:CreateSection("ℹ️ About")
  infoTab:CreateLabel("╔════════════════════════════╗")
  infoTab:CreateLabel("        ⚡ NNVN Hub")
  infoTab:CreateLabel("        By N0NAMEVN")
  infoTab:CreateLabel("        Version: 3.0")
  infoTab:CreateLabel("        Game: Arsenal")
  infoTab:CreateLabel("╚════════════════════════════╝")
  infoTab:CreateSection("👑 Credits")
  infoTab:CreateLabel("Developer: N0NAMEVN")
  infoTab:CreateLabel("UI Library: Rayfield")
  infoTab:CreateLabel("Game: Arsenal")
  infoTab:CreateSection("📱 Contact")
  infoTab:CreateLabel("Discord: N0NAMEVN")
  infoTab:CreateLabel("YouTube: N0NAMEVN")
  infoTab:CreateSection("💖 Support")
  infoTab:CreateLabel("Thanks for using NNVN Hub!")
  infoTab:CreateLabel("Don't forget to subscribe!")

  infoTab:CreateButton({
    Name = "Show Credits",
    Callback = function()
      f4("👑 Credits", [[
NNVN Hub | Arsenal
Developed by N0NAMEVN
Version 3.0]], 5)
    end,
  })

  settingsTab:CreateSection("Performance")

  settingsTab:CreateToggle({
    Name = "Anti Lag",
    CurrentValue = false,
    Callback = function(value40)
      for key10, value41 in pairs(workspaceService:GetDescendants()) do
        if value41:IsA("BasePart") and not value41.Parent:FindFirstChild("Humanoid") then
          value41.Material = value40 and Enum.Material.SmoothPlastic or Enum.Material.Plastic
        end
      end
    end,
  })

  settingsTab:CreateToggle({
    Name = "FPS Boost",
    CurrentValue = false,
    Callback = function(value42)
      if value42 then
        settings().Rendering.QualityLevel = "Level01"

        lighting.GlobalShadows = false
        lighting.FogEnd = 9000000000

        workspaceService.Terrain.WaterWaveSize = 0
        workspaceService.Terrain.WaterWaveSpeed = 0
      else
        settings().Rendering.QualityLevel = "Automatic"

        lighting.GlobalShadows = true
        lighting.FogEnd = 1000

        workspaceService.Terrain.WaterWaveSize = 0.5
        workspaceService.Terrain.WaterWaveSpeed = 10
      end
    end,
  })

  settingsTab:CreateButton({
    Name = "Server Hop",
    Callback = function()
      local placeId = game.PlaceId

      local v19, v20 = pcall(function()
        return httpService:JSONDecode(httpService:HttpGet("https://games.roblox.com/v1/games/"
          .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"))
      end)

      if v19 and v20 and v20.data then
        for key11, value43 in pairs(v20.data) do
          if tonumber(value43.maxPlayers) > tonumber(value43.playing) then
            teleportService:TeleportToPlaceInstance(placeId, value43.id, localPlayer)
            break
          end
        end
      end
    end,
  })

  settingsTab:CreateButton({
    Name = "Rejoin",
    Callback = function() teleportService:Teleport(game.PlaceId, localPlayer) end,
  })

  runService.Heartbeat:Connect(function(delta)
    if v8 and localPlayer.Character then
      local currentCamera = workspaceService.CurrentCamera
      local humanoidRootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart and currentCamera then
        local vector = Vector3.new()

        if userInputService:IsKeyDown(Enum.KeyCode.W) then
          vector = vector + currentCamera.CFrame.LookVector
        end

        if userInputService:IsKeyDown(Enum.KeyCode.S) then
          vector = vector - currentCamera.CFrame.LookVector
        end

        if userInputService:IsKeyDown(Enum.KeyCode.A) then
          vector = vector - currentCamera.CFrame.RightVector
        end

        if userInputService:IsKeyDown(Enum.KeyCode.D) then
          vector = vector + currentCamera.CFrame.RightVector
        end

        if vector.Magnitude > 0 then
          local v21 = vector.Unit * v9
          humanoidRootPart.Velocity = Vector3.new(v21.X, humanoidRootPart.Velocity.Y, v21.Z)
        end

        if userInputService:IsKeyDown(Enum.KeyCode.Space) then
          humanoidRootPart.Velocity = Vector3.new(
            humanoidRootPart.Velocity.X, v9, humanoidRootPart.Velocity.Z
          )
        end
      end
    end
  end)

  localPlayer.CharacterAdded:Connect(function()
    task.wait(1)

    if v10 then
      local humanoid5 = localPlayer.Character
        and localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid5 then
        humanoid5.WalkSpeed = walkSpeed
      end
    end

    if v12 then
      local character4 = localPlayer.Character

      if character4 then
        for key12, value44 in pairs(character4:GetDescendants()) do
          if value44:IsA("BasePart") then
            value44.CanCollide = false
          end
        end
      end
    end

    if v2 then
      f6()
    end
  end)

  players.PlayerAdded:Connect(function()
    if v2 then
      task.wait(1)
      f6()
    end
  end)

  f4("✅ NNVN Hub", [[
Arsenal script loaded successfully!
By N0NAMEVN]], 5)

  print("NNVN Hub Loaded Successfully!")
  return
end
