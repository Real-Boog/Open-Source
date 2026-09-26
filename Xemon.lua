local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local workspaceService = game:GetService("Workspace")
local v1 = {}
local floor = math.floor
local random = math.random
local remove = table.remove
local char = string.char
local v2 = 0
local v3 = 2
local v4 = {}

for i = 1, 256 do
  v1[i] = i
end

repeat
  local v5 = remove(v1, (random(1, #v1)))
  v4[v5] = char(v5 - 1)
until #v1 == 0

local v6 = {}

local function f1()
  if #v6 == 0 then
    v2 = (v2 * 9 + 18683968512507) % 35184372088832

    repeat
      v3 = v3 * 119 % 257
    until v3 ~= 1

    local v7 = v3 % 32
    local v8 = floor(v2 / 2 ^ (13 - (v3 - v7) / 32)) % 4294967296 / 2 ^ v7
    local v9 = floor(v8 % 1 * 4294967296) + floor(v8)
    local v10 = v9 % 65536
    local v11 = (v9 - v10) / 65536
    local v12 = v10 % 256
    local v13 = v11 % 256
    v6 = { v12, (v10 - v12) / 256, v13, (v11 - v13) / 256 }
  end

  return table.remove(v6)
end

local v14 = {}
local v15 = setmetatable({}, { __index = v14, __metatable = nil })

local function f2(p1, p2)
  if v14[p2] then
  else
    v6 = {}
    v2 = p2 % 35184372088832
    v3 = p2 % 255 + 2
    local v16 = string.len(p1)
    v14[p2] = ""
    local v17 = 254

    for j = 1, v16 do
      v17 = (string.byte(p1, j) + f1() + v17) % 256
      v14[p2] = v14[p2] .. v4[v17 + 1]
    end
  end

  return p2
end

local rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local localPlayer = players.LocalPlayer
local lightsaberRemotes = replicatedStorage:WaitForChild("LightsaberRemotes")
local killAura = false
local v18 = false
local legitCooldown = 0.3
local godMode = false
local cooldown = 0.3
local autoBlock = false
local espEnemies = false
local nameESP = false
local v19 = false
local v20 = 100
local v21 = 50
local killAll = false
local v22 = 0
local v23 = false
local walkSpeed = 16
local jumpPower = 50
local v24 = false
local v25 = 0
local v26 = 0
local v27 = 0

local function f3()
  if godMode then
    localPlayer.CharacterAdded:Connect(function(character)
      local humanoid = character:WaitForChild("Humanoid")

      humanoid.HealthChanged:Connect(function()
        if godMode and humanoid.Health < humanoid.MaxHealth then
          humanoid.Health = humanoid.MaxHealth
        end
      end)
    end)
  end
end

local connect = nil

local function f4()
  if connect then
    connect:Disconnect()
    connect = nil
  end

  if not killAura and not v18 and not v23 then
    return
  end

  connect = runService.Heartbeat:Connect(function()
    local v28 = not killAura and not v18 and not v23
    local v29, v30, v31

    if v28 then
      if connect then
        connect:Disconnect()
        connect = nil
      end

      return
    else
      local character2 = localPlayer.Character

      if not character2 then
        return
      else
        local humanoidRootPart = character2:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart then
          return
        end

        if v18 and not v23 then
          local v32 = false

          for index, value in ipairs(players:GetPlayers()) do
            if value ~= localPlayer and value.Character
              and value.Character:FindFirstChild("HumanoidRootPart")
              and value.Character:FindFirstChild("Humanoid") then
              if value.Character.Humanoid.Health <= 0 then
              elseif (value.Character.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude
                <= 10 then
                v32 = true
                break
              end
            end
          end

          if not v32 then
            return
          end

          v29 = tick()
          v30 = v23 and 0.01

          v31 = v30
          v31 = v30 or v18 and legitCooldown or cooldown

          if v29 - v22 >= v31 then
            pcall(function()
              lightsaberRemotes.MouseDown:FireServer()
              lightsaberRemotes.Attack:FireServer(3, 1, false, false)
              lightsaberRemotes.Swing:FireServer()

              for index2, value2 in ipairs(players:GetPlayers()) do
                if value2 ~= localPlayer and value2.Character
                  and value2.Character:FindFirstChild("Humanoid") then
                  if value2.Character.Humanoid.Health > 0 then
                    lightsaberRemotes.OnHit:FireServer(value2.Character)
                  end
                end
              end

              lightsaberRemotes.FinishSwingNoBounce:FireServer()
              lightsaberRemotes.ResetSwingDirection:FireServer()
              lightsaberRemotes.MouseUp:FireServer()
            end)

            v22 = v29
          end

          return
        end

        v29 = tick()
        v30 = v23 and 0.01

        v31 = v30
        v31 = v30 or v18 and legitCooldown or cooldown

        if v29 - v22 >= v31 then
          pcall(function()
            lightsaberRemotes.MouseDown:FireServer()
            lightsaberRemotes.Attack:FireServer(3, 1, false, false)
            lightsaberRemotes.Swing:FireServer()

            for index3, value3 in ipairs(players:GetPlayers()) do
              if value3 ~= localPlayer and value3.Character
                and value3.Character:FindFirstChild("Humanoid") then
                if value3.Character.Humanoid.Health > 0 then
                  lightsaberRemotes.OnHit:FireServer(value3.Character)
                end
              end
            end

            lightsaberRemotes.FinishSwingNoBounce:FireServer()
            lightsaberRemotes.ResetSwingDirection:FireServer()
            lightsaberRemotes.MouseUp:FireServer()
          end)

          v22 = v29
        end

        return
      end
    end
  end)
end

local v33 = {
  [12718502938] = { 1, 13, 2 },
  [12625839385] = { 1, 13, 2 },
  [13564880014] = { 1, 13, 2 },
  [12734285787] = { 1, 13, 2 },
  [13453391958] = { 1, 13, 2 },
  [14167593691] = { 1, 13, 2 },
  [13783202348] = { 1, 13, 2 },
  [13540434005] = { 1, 13, 2 },
  [15563343338] = { 1, 13, 2 },
  [12734468945] = { 1, 13, 2 },
  [13304774028] = { 1, 13, 2 },
  [17372041039] = { 1, 13, 2 },
  [14329314419] = { 1, 13, 2 },
  [12718504431] = { 2, 3, 4 },
  [12625848489] = { 2, 3, 4 },
  [13565725049] = { 2, 3, 4 },
  [12734288411] = { 2, 3, 4 },
  [13453386109] = { 2, 3, 4 },
  [14167584256] = { 2, 3, 4 },
  [13783395464] = { 2, 3, 4 },
  [13540430226] = { 2, 3, 4 },
  [15563344914] = { 2, 3, 4 },
  [12734471179] = { 2, 3, 4 },
  [13304781510] = { 2, 3, 4 },
  [17566657634] = { 2, 3, 4 },
  [14329308611] = { 2, 3, 4 },
  [12718501806] = { 4, 5, 6 },
  [12625841878] = { 4, 5, 6 },
  [13569466383] = { 4, 5, 6 },
  [12734284724] = { 4, 5, 6 },
  [13453390619] = { 4, 5, 6 },
  [14167591876] = { 4, 5, 6 },
  [13783497920] = { 4, 5, 6 },
  [15563343960] = { 4, 5, 6 },
  [12734468200] = { 4, 5, 6 },
  [13306520673] = { 4, 5, 6 },
  [17372039079] = { 4, 5, 6 },
  [14329312618] = { 4, 5, 6 },
  [12718500875] = { 6, 7, 8 },
  [12625853257] = { 6, 7, 8 },
  [13569308951] = { 6, 7, 8 },
  [12734283312] = { 6, 7, 8 },
  [13453385141] = { 6, 7, 8 },
  [14167502905] = { 6, 7, 8 },
  [13781663786] = { 6, 7, 8 },
  [13540431378] = { 6, 7, 8 },
  [15563346027] = { 6, 7, 8 },
  [12734467243] = { 6, 7, 8 },
  [13306517941] = { 6, 7, 8 },
  [17372038496] = { 6, 7, 8 },
  [14329161930] = { 6, 7, 8 },
  [12718483984] = { 8, 9, 10 },
  [12625843823] = { 8, 9, 10 },
  [13568360345] = { 8, 9, 10 },
  [12734279804] = { 8, 9, 10 },
  [13453387454] = { 8, 9, 10 },
  [14167592684] = { 8, 9, 10 },
  [13781621647] = { 8, 9, 10 },
  [15563342470] = { 8, 9, 10 },
  [12734465074] = { 8, 9, 10 },
  [13304777249] = { 8, 9, 10 },
  [17372037456] = { 8, 9, 10 },
  [14355055371] = { 8, 9, 10 },
  [12718486016] = { 10, 11 },
  [12625846167] = { 10, 11 },
  [13568907848] = { 10, 11 },
  [12734282359] = { 10, 11 },
  [13453382299] = { 10, 11 },
  [14167590501] = { 10, 11 },
  [13781667793] = { 10, 11 },
  [15564066873] = { 10, 11 },
  [12734466257] = { 10, 11 },
  [13304786458] = { 10, 11 },
  [17372036678] = { 10, 11 },
  [14329310837] = { 10, 11 },
  [12718503706] = { 12, 13 },
  [12625851115] = { 12, 13 },
  [13566518265] = { 12, 13 },
  [12734286808] = { 12, 13 },
  [13453383921] = { 12, 13 },
  [14167585544] = { 12, 13 },
  [13783293417] = { 12, 13 },
  [15563346564] = { 12, 13 },
  [12734470075] = { 12, 13 },
  [13304788013] = { 12, 13 },
  [17566667400] = { 12, 13 },
  [14329160019] = { 12, 13 },
}

local f5

local function f6()
  if not v24 and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
    f5()
  end
end

function f5()
  if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
    local humanoid2 = localPlayer.Character.Humanoid
    humanoid2.WalkSpeed = walkSpeed
    humanoid2.JumpPower = jumpPower

    v24 = true
  end
end

local connect2 = nil

local function f7()
  if connect2 then
    connect2:Disconnect()
    connect2 = nil
  end

  if not autoBlock and not v19 then
    return
  end

  connect2 = runService.Heartbeat:Connect(function()
    local v34 = tick()

    if v34 - v26 < 0.2 then
      return
    end

    v26 = v34

    if not localPlayer.Character then
      return
    else
      local humanoidRootPart2 = localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart2 then
        return
      end

      for index4, value4 in ipairs(players:GetPlayers()) do
        if value4 ~= localPlayer and value4.Character
          and value4.Character:FindFirstChild("HumanoidRootPart")
          and value4.Character:FindFirstChild("Humanoid") then
          if value4.Character.Humanoid.Health <= 0 then
          else
            local magnitude = (value4.Character.HumanoidRootPart.Position
              - humanoidRootPart2.Position).Magnitude

            if autoBlock and magnitude < 10 then
              pcall(function() lightsaberRemotes.Block:FireServer() end)
              break
            end

            if v19 and magnitude <= v21 then
              local humanoid3 = value4.Character:FindFirstChildOfClass("Humanoid")

              if humanoid3 then
                for index5, value5 in ipairs(humanoid3:GetPlayingAnimationTracks()) do
                  if value5.Animation then
                    local d = value5.Animation.AnimationId:match("%d+")

                    if d then
                      local v35 = tonumber(d)

                      if v35 and v33[v35] and math.random(0, 100) <= v20 then
                        pcall(function() lightsaberRemotes.Block:FireServer() end)
                        break
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end

      return
    end
  end)
end

local connect3 = nil
local v36 = 0

local function f8()
  if connect3 then
    connect3:Disconnect()
    connect3 = nil
  end

  if not killAll then
    v23 = false

    if killAura or v18 then
      f4()
    end

    return
  end

  v23 = true
  f4()

  connect3 = runService.Heartbeat:Connect(function()
    local v37 = tick()

    if v37 - v27 < 0.1 then
      return
    end

    v27 = v37

    if not killAll then
      if connect3 then
        connect3:Disconnect()
        connect3 = nil
      end

      return
    end

    if not localPlayer.Character then
      return
    end

    local humanoidRootPart3 = localPlayer.Character:FindFirstChild("HumanoidRootPart")
    local v38, v39

    if not humanoidRootPart3 then
      return
    else
      local v40 = {}

      for index6, value6 in ipairs(players:GetPlayers()) do
        local v41 = value6 ~= localPlayer
        local v42 = v41

        if v41 then
          v38 = "Character"
          local v43 = value6[v38]
          local humanoid4 = v43

          if v43 then
            local character3 = value6.Character
            v38 = v39

            humanoid4 = character3:FindFirstChild("HumanoidRootPart")
              and value6.Character:FindFirstChild("Humanoid")
          end

          v42 = humanoid4
        end

        if v42 then
          local v44 = false
          local v45, v46, v47 = ipairs(value6.Character:GetChildren())

          while true do
            v47, v38 = v45(v46, v47)

            if not v47 then
              break
            end

            if v38:IsA("ForceField") then
              v38 = nil
              v44 = true
              break
            end
          end

          local v48 = not v44
          local v49 = v48

          if v48 then
            v38 = 0
            v49 = value6.Character.Humanoid.Health > v38
          end

          if v49 then
            v38 = f2
            table[v15[v38("\179\245a\189{\189", 34822697811799)]](v40, value6)
          end
        end
      end

      if #v40 == 0 then
        return
      end

      for index7, value7 in ipairs(v40) do
        if not killAll then
          break
        else
          local v50 = false

          for index8, value8 in ipairs(value7.Character:GetChildren()) do
            if value8:IsA("ForceField") then
              v50 = true
              break
            end
          end

          if v50 then
          else
            local humanoidRootPart4 = value7.Character:FindFirstChild("HumanoidRootPart")
            local humanoid5 = value7.Character:FindFirstChild("Humanoid")

            if not humanoidRootPart4 or not humanoid5 then
            elseif humanoid5.Health <= 0 then
            else
              v36 = v36 + 0.05

              if v36 >= 360 then
                v36 = 0
              end

              local v51 = math.cos(v36)
              local v52 = math.sin(v36)
              local vector = Vector3.new(v51 * 3, 0, v52 * 3)
              local v53 = humanoidRootPart4.Position + vector

              local raycastParams = RaycastParams.new()
              raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

              raycastParams.FilterDescendantsInstances = {
                localPlayer.Character, value7.Character,
              }

              local raycast = workspace:Raycast(
                v53 + Vector3.new(0, 10, 0), Vector3.new(0, -20, 0), raycastParams
              )

              if raycast then
                v53 = raycast.Position + Vector3.new(0, 3, 0)
              else
                v53 = v53 + Vector3.new(0, 3, 0)
              end

              pcall(function()
                humanoidRootPart3.CFrame = CFrame.new(v53)
                humanoidRootPart3.Velocity = Vector3.new(0, 0, 0)
                humanoidRootPart3.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
              end)

              wait(1)
            end
          end
        end
      end

      return
    end
  end)
end

local v54 = {}
local v55 = {}
local f9

local function f10()
  local v56 = tick()

  if v56 - v25 < 1 then
    return
  end

  v25 = v56

  if not espEnemies and not nameESP then
    f9()
    return
  end

  for key, value9 in pairs(v54) do
    local v57 = value9

    if not players:FindFirstChild(key.Name) or not key.Character
      or key.Character.Humanoid.Health <= 0 then
      pcall(function() v57:Destroy() end)
      v54[key] = nil
    end
  end

  for key2, value10 in pairs(v55) do
    local v58 = value10

    if not players:FindFirstChild(key2.Name) or not key2.Character
      or key2.Character.Humanoid.Health <= 0 then
      pcall(function() v58:Destroy() end)
      v55[key2] = nil
    end
  end

  for index9, value11 in ipairs(players:GetPlayers()) do
    if value11 == localPlayer then
    elseif value11.Character and value11.Character:FindFirstChild("Humanoid")
      and value11.Character.Humanoid.Health > 0 then
      if espEnemies and not v54[value11] then
        local highlight = Instance.new("Highlight")
        highlight.FillColor = Color3.new(1, 0, 0)
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = Color3.new(1, 0, 0)
        highlight.OutlineTransparency = 0
        highlight.Adornee = value11.Character
        highlight.Parent = value11.Character

        v54[value11] = highlight
      end

      if nameESP and not v55[value11] and value11.Character:FindFirstChild("Head") then
        local nameESP2 = Instance.new("BillboardGui")
        nameESP2.Name = "NameESP"
        nameESP2.Adornee = value11.Character.Head
        nameESP2.Size = UDim2.new(0, 100, 0, 20)
        nameESP2.StudsOffset = Vector3.new(0, 2.5, 0)
        nameESP2.AlwaysOnTop = true

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = value11.Name
        textLabel.TextColor3 = Color3.new(1, 1, 1)
        textLabel.TextScaled = false
        textLabel.TextSize = 14
        textLabel.Font = Enum.Font.GothamBold
        textLabel.Parent = nameESP2

        nameESP2.Parent = value11.Character
        v55[value11] = nameESP2
      end
    end
  end
end

function f9()
  for key3, value12 in pairs(v54) do
    local v59 = value12
    pcall(function() v59:Destroy() end)
  end

  for key4, value13 in pairs(v55) do
    local v60 = value13
    pcall(function() v60:Destroy() end)
  end

  v54 = {}
  v55 = {}
end

players.PlayerAdded:Connect(function(player)
  if espEnemies or nameESP then
    wait(1)
    f10()
  end
end)

players.PlayerRemoving:Connect(function(player2)
  if v54[player2] then
    pcall(function() v54[player2]:Destroy() end)
    v54[player2] = nil
  end

  if v55[player2] then
    pcall(function() v55[player2]:Destroy() end)
    v55[player2] = nil
  end
end)

localPlayer.CharacterAdded:Connect(function(character4)
  v24 = false
  f6()

  if killAura then
    f4()
  end

  if v18 then
    f4()
  end

  if autoBlock then
    f7()
  end

  if killAll then
    wait(1)
    f8()
  end

  if godMode then
    f3()
  end
end)

local window = rayfield:CreateWindow({
  Name = "Xemon Saber Showdown",
  LoadingTitle = "Xemon Saber Showdown",
  LoadingSubtitle = "Version V1.2",
  ConfigurationSaving = { Enabled = true, FolderName = "XemonConfig", FileName = "Settings" },
  Discord = { Enabled = false },
  KeySystem = false,
})

local combatTab = window:CreateTab("Combat", 4483362458)

combatTab:CreateToggle({
  Name = "God Mode [HAVE BUGS]",
  CurrentValue = godMode,
  Flag = "GodMode",
  Callback = function(value14)
    godMode = value14

    if value14 then
      f3()
    end
  end,
})

combatTab:CreateToggle({
  Name = "Kill Aura",
  CurrentValue = killAura,
  Flag = "KillAura",
  Callback = function(value15)
    killAura = value15
    f4()
  end,
})

combatTab:CreateToggle({
  Name = "Legit Kill Aura",
  CurrentValue = v18,
  Flag = "LegitKillAura",
  Callback = function(value16)
    v18 = value16
    f4()
  end,
})

combatTab:CreateSlider({
  Name = "Kill Aura Cooldown",
  Range = { 0.01, 1 },
  Increment = 0.01,
  Suffix = "s",
  CurrentValue = cooldown,
  Flag = "Cooldown",
  Callback = function(value17) cooldown = value17 end,
})

combatTab:CreateSlider({
  Name = "Legit Kill Aura Cooldown",
  Range = { 0.01, 1 },
  Increment = 0.01,
  Suffix = "s",
  CurrentValue = legitCooldown,
  Flag = "LegitCooldown",
  Callback = function(value18) legitCooldown = value18 end,
})

combatTab:CreateLabel("use 0.50 for if you dont wanna ban lol")
combatTab:CreateSection("Block System")

combatTab:CreateToggle({
  Name = "Auto Block [HAVE BUGS]",
  CurrentValue = autoBlock,
  Flag = "AutoBlock",
  Callback = function(value19)
    autoBlock = value19
    f7()
  end,
})

combatTab:CreateToggle({
  Name = "Auto Perfect Block [HAVE BUGS]",
  CurrentValue = v19,
  Flag = "AutoPerfectBlock",
  Callback = function(value20)
    v19 = value20
    f7()
  end,
})

combatTab:CreateSlider({
  Name = "Perfect Block Radius",
  Range = { 5, 50 },
  Increment = 1,
  Suffix = "studs",
  CurrentValue = v21,
  Flag = "PerfectBlockRadius",
  Callback = function(value21) v21 = value21 end,
})

combatTab:CreateSlider({
  Name = "Perfect Block Chance",
  Range = { 0, 100 },
  Increment = 1,
  Suffix = "%",
  CurrentValue = v20,
  Flag = "PerfectBlockChance",
  Callback = function(value22) v20 = value22 end,
})

local opTab = window:CreateTab("OP", 4483362458)
opTab:CreateSection("Kill All (Ban Risk)")

opTab:CreateToggle({
  Name = "Kill All Players",
  CurrentValue = killAll,
  Flag = "KillAll",
  Callback = function(value23)
    killAll = value23

    if value23 then
      rayfield:Notify({
        Title = "Warning",
        Content = "Kill All has ban risk! Use at your own risk!",
        Duration = 5,
        Image = 4483362458,
      })
    end

    f8()
  end,
})

local visualsTab = window:CreateTab("Visuals", 4483362458)

visualsTab:CreateToggle({
  Name = "ESP (Enemies)",
  CurrentValue = espEnemies,
  Flag = "ESP",
  Callback = function(value24)
    espEnemies = value24

    if not value24 then
      f9()
    else
      f10()
    end
  end,
})

visualsTab:CreateToggle({
  Name = "Name ESP",
  CurrentValue = nameESP,
  Flag = "NameESP",
  Callback = function(value25)
    nameESP = value25

    if not value25 then
      f9()
    else
      f10()
    end
  end,
})

local movementTab = window:CreateTab("Movement", 4483362458)
movementTab:CreateSection("Movement Settings")

movementTab:CreateSlider({
  Name = "Walk Speed",
  Range = { 16, 50 },
  Increment = 1,
  Suffix = "studs",
  CurrentValue = walkSpeed,
  Flag = "Speed",
  Callback = function(value26)
    walkSpeed = value26
    v24 = false
    f6()
  end,
})

movementTab:CreateSlider({
  Name = "Jump Power",
  Range = { 50, 100 },
  Increment = 5,
  Suffix = "power",
  CurrentValue = jumpPower,
  Flag = "Jump",
  Callback = function(value27)
    jumpPower = value27
    v24 = false
    f6()
  end,
})

local settingsTab = window:CreateTab("Settings", 4483362458)

settingsTab:CreateButton({
  Name = "Copy Discord",
  Callback = function()
    setclipboard("discord.gg/pAfq65sShf")

    rayfield:Notify({
      Title = "Copied!",
      Content = "Discord link copied to clipboard",
      Duration = 2,
      Image = 4483362458,
    })
  end,
})

settingsTab:CreateSection("Changelog")
settingsTab:CreateLabel("Mini Update - Increased Kill Aura cooldown range to 1 second")
settingsTab:CreateLabel("v1.2 - Kill All - Perfect Block + Legit Kill Aura + someone changes for kill aura +  Name Esp + Optimized Esp")
settingsTab:CreateLabel("v1.1 - Bug fixes and improvements")
settingsTab:CreateLabel("v1.0 - Released - Kill aura - auto block")
settingsTab:CreateSection("Credits")
settingsTab:CreateLabel("Reign - functions + ui")
settingsTab:CreateLabel("Lorinsp - ideas")
settingsTab:CreateLabel("OriginPreacher - Perfect Block")
settingsTab:CreateLabel("V1.2")
settingsTab:CreateButton({ Name = "Destroy GUI", Callback = function() rayfield:Destroy() end })

settingsTab:CreateKeybind({
  Name = "Toggle GUI",
  CurrentKeybind = "RightControl",
  HoldToInteract = false,
  Flag = "ToggleKey",
  Callback = function(value28) rayfield.ToggleKeybind = value28 end,
})

f4()
f7()
f10()

rayfield:Notify({
  Title = "Xemon Saber Showdown v1.2",
  Content = "Updated September 7, 2025",
  Duration = 5,
  Image = 4483362458,
})
