-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf
-- yea a random ass script i found which has 0 protection and really shit too
-- this is for alkedion

local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local virtualInputManager = game:GetService("VirtualInputManager")
local replicatedStorage = game:GetService("ReplicatedStorage")
local godzPoKamiNiSantino = GodzPoKamiNiSantino
local localPlayer = players.LocalPlayer
local currentCamera = workspace.CurrentCamera
local playerGui = localPlayer:WaitForChild("PlayerGui")

local v1 = {
  AutoFarm = false,
  FarmThread = nil,
  ESP = true,
  Aimbot = false,
  AimbotFOV = 150,
  AimbotSmooth = 3,
  ForceFarmEvent = false,
}

local list = {
  Vector3.new(-5774.112, 4.791, 790.977), Vector3.new(-5780.186, 4.871, 795.276),
  Vector3.new(-5788.657, 5.037, 801.847), Vector3.new(-5798.568, 5.08, 803.292),
  Vector3.new(-5805.831, 5.091, 801.87), Vector3.new(-5809.395, 5.06, 795.572),
  Vector3.new(-5807.513, 4.956, 775.678), Vector3.new(-5799.881, 4.924, 771.341),
  Vector3.new(-5796.688, 4.935, 762.417), Vector3.new(-5799.951, 4.944, 751.247),
  Vector3.new(-5792.35, 4.804, 746.708), Vector3.new(-5798.869, 4.811, 733.347),
  Vector3.new(-5804.769, 4.929, 735.804), Vector3.new(-5811.888, 4.989, 719.865),
  Vector3.new(-5823.434, 5.033, 723.318), Vector3.new(-5837.409, 4.922, 726.687),
  Vector3.new(-5844.74, 4.932, 733.9), Vector3.new(-5865.454, 4.815, 744.57),
  Vector3.new(-5877.794, 4.912, 747.939), Vector3.new(-5899.823, 4.92, 753.069),
  Vector3.new(-5906.275, 4.895, 757.081), Vector3.new(-5916.896, 4.738, 762.143),
  Vector3.new(-5907.223, 4.804, 775.585), Vector3.new(-5900.468, 4.891, 774.409),
  Vector3.new(-5889.983, 4.947, 778.325), Vector3.new(-5805.853, 5.052, 787.604),
  Vector3.new(-5813.453, 4.961, 782.622), Vector3.new(-5814.189, 4.967, 788.321),
  Vector3.new(-5812.808, 4.967, 781.883), Vector3.new(-5814.038, 5.047, 775.044),
  Vector3.new(-5816.177, 5.05, 767.584), Vector3.new(-5836.914, 5.116, 770.339),
  Vector3.new(-5858.344, 4.987, 756.518), Vector3.new(-5873.229, 4.938, 757.857),
  Vector3.new(-5884.208, 4.937, 755.231), Vector3.new(-5823.24, 4.905, 795.556),
  Vector3.new(-5824.981, 4.964, 786.766), Vector3.new(-5832.146, 5.066, 776.668),
  Vector3.new(-5838.22, 5.122, 770.526), Vector3.new(-5850.099, 5.088, 765.28),
  Vector3.new(-5860.786, 4.981, 758.679), Vector3.new(-5858.673, 4.946, 751.715),
  Vector3.new(-5866.396, 4.765, 738.114), Vector3.new(-5876.356, 4.804, 675.745),
  Vector3.new(-5871.748, 4.893, 666.589), Vector3.new(-5807.513, 4.964, 775.678),
  Vector3.new(-5803.065, 4.994, 769.926), Vector3.new(-5842.411, 4.838, 663.373),
  Vector3.new(-5870.272, 5.027, 652.435), Vector3.new(-5873.002, 5.066, 647.365),
  Vector3.new(-5876.784, 5.091, 640.975), Vector3.new(-5887.184, 5.029, 633.252),
  Vector3.new(-5921.929, 5.035, 636.875), Vector3.new(-5924.158, 4.941, 695.66),
  Vector3.new(-5941.261, 4.955, 693.263), Vector3.new(-5949.5, 4.758, 692.989),
  Vector3.new(-5948.512, 4.843, 689.415), Vector3.new(-5952.588, 4.824, 680.084),
  Vector3.new(-5827.627, 5.019, 779.192),
}

local vector = Vector3.new(-6507.73, 13.838, 1537.153)
local vector2 = Vector3.new(-1845.968, 13.304, 285.765)
local vector3 = Vector3.new(-8083.208, 26.009, 6637.696)
local vector4 = Vector3.new(-1676.885, 3.618, 723.216)
local vector5 = Vector3.new(-8817.523, 8.813, 801.961)
local vector6 = Vector3.new(-1227.37, 3.55, -1849.743)
local vector7 = Vector3.new(-5823.004, 4.697, 667.102)

local function f1(p1)
  local menu = playerGui:FindFirstChild("Menu")
  local container = menu and menu:FindFirstChild("Container")
  local jobSelection = container and container:FindFirstChild("JobSelection")

  if not jobSelection then
    return
  end

  local cards = jobSelection:FindFirstChild("Cards")

  if not cards then
    return
  end

  if not jobSelection.Visible then
    local jobAction = replicatedStorage:FindFirstChild("Network"):FindFirstChild("Events"):FindFirstChild("JobAction")

    if jobAction then
      jobAction:FireServer("View")
    end

    task.wait(0.5)
  end

  for _, value in ipairs(cards:GetChildren()) do
    local jobId = value:GetAttribute("JobId") or value.Name

    if value:IsA("Frame") and jobId == p1 then
      local select = value:FindFirstChild("Select")

      if select and select:IsA("ImageButton") then
        local actionTitle = select:FindFirstChild("ActionTitle")

        if actionTitle and (actionTitle.Text == "SELECT" or actionTitle.Text == "OFF-DUTY") then
          select:Activate()
          return true
        end
      end
    end
  end

  return false
end

local function f2(p2)
  if not p2.Enabled then
    return
  end

  pcall(function() fireproximityprompt(p2) end)

  if getconnections then
    pcall(function()
      for _, value2 in ipairs((getconnections(p2.Triggered))) do
        if value2.Fire then
          value2:Fire(0)
        end
      end
    end)
  end

  pcall(function()
    local e = Enum.KeyCode.E

    if p2.KeyboardKeyCode then
      e = p2.KeyboardKeyCode
    end

    virtualInputManager:SendKeyEvent(true, e, false, game)
    virtualInputManager:SendKeyEvent(false, e, false, game)
  end)
end

local function getCharacter()
  return localPlayer.Character or localPlayer.CharacterAdded:Wait()
end

local window = godzPoKamiNiSantino:CreateWindow({
  Name = "Cracked",
  LoadingTitle = ".gg/pAfq65sShf",
  LoadingSubtitle = "santinoK",
  Theme = "Dark",
  ConfigurationSaving = {
    Enabled = true,
    FolderName = "SantinoGarapalino",
    FileName = "Config",
  },
  KeySystem = false,
  KeySettings = {
    Title = "Santino a Bitch!",
    Subtitle = "Santino Sucks",
    Note = "GodzMoSiSantinoAh",
    FileName = "SantinoKeyGui",
    SaveKey = false,
    GrabKeyFromSite = false,
    Key = { "CRACKED-BY-BOOG-X" },
  },
})

local autoFarmTab = window:CreateTab("Auto Farm", nil)
autoFarmTab:CreateSection("Automatic")

autoFarmTab:CreateToggle({
  Name = "Enable Auto Farm",
  CurrentValue = false,
  Flag = "AutoFarm",
  Callback = function(value3)
    v1.AutoFarm = value3

    if value3 then
      v1.FarmThread = task.spawn(function()
        while v1.AutoFarm do
          local list2 = {}

          for _, value4 in ipairs(list) do
            table.insert(list2, value4)
          end

          for i = #list2, 2, -1 do
            local roll = math.random(i)
            list2[i], list2[roll] = list2[roll], list2[i]
          end

          for _, value5 in ipairs(list2) do
            if not v1.AutoFarm then
              break
            end

            pcall(function()
              local character = getCharacter()
              local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

              if humanoidRootPart and character:FindFirstChildOfClass("Humanoid") then
                humanoidRootPart.CFrame = CFrame.new(value5)
                humanoidRootPart.Velocity = Vector3.new(0, 0, 0)

                task.wait(0.1)
                local v2 = tick()

                while tick() - v2 < 2.5 do
                  for _, value6 in ipairs(workspace:GetDescendants()) do
                    if value6:IsA("ProximityPrompt") and value6.Enabled then
                      local parent = value6.Parent

                      if parent and parent:IsA("BasePart")
                        and (parent.Position - value5).Magnitude <= 25 then
                        f2(value6)
                      end
                    end
                  end

                  task.wait(0.2)

                  if not v1.AutoFarm then
                    break
                  end
                end
              end
            end)
          end

          if v1.AutoFarm then
            local character2 = getCharacter()

            if character2 and character2:FindFirstChild("HumanoidRootPart") then
              character2.HumanoidRootPart.CFrame = CFrame.new(vector7)
              task.wait(0.2)

              for _, value7 in ipairs(workspace:GetDescendants()) do
                if value7:IsA("ProximityPrompt") and value7.Enabled then
                  local parent2 = value7.Parent

                  if parent2 and parent2:IsA("BasePart")
                    and (parent2.Position - vector7).Magnitude <= 25 then
                    f2(value7)
                  end
                end
              end
            end
          end

          task.wait(0.5)
        end
      end)
    elseif v1.FarmThread then
      task.cancel(v1.FarmThread)
      v1.FarmThread = nil
    end
  end,
})

autoFarmTab:CreateButton({
  Name = "Teleport to Sell Point",
  Callback = function()
    local character3 = getCharacter()

    if character3 and character3:FindFirstChild("HumanoidRootPart") then
      character3.HumanoidRootPart.CFrame = CFrame.new(vector7)
    end
  end,
})

autoFarmTab:CreateToggle({
  Name = "Force Farm Event (Double Price)",
  CurrentValue = false,
  Flag = "ForceFarmEvent",
  Callback = function(value8)
    v1.ForceFarmEvent = value8

    if value8 then
      local cmdrClient = replicatedStorage:FindFirstChild("CmdrClient")
        or replicatedStorage:FindFirstChild("Cmdr")

      if cmdrClient then
        local remoteEvent = cmdrClient:FindFirstChild("RemoteEvent")
          or cmdrClient:FindFirstChild("CmdrRemote")

        if remoteEvent then
          remoteEvent:FireServer("farming", { 60 })
        end
      end
    else
      local cmdrClient2 = replicatedStorage:FindFirstChild("CmdrClient")
        or replicatedStorage:FindFirstChild("Cmdr")

      if cmdrClient2 then
        local remoteEvent2 = cmdrClient2:FindFirstChild("RemoteEvent")
          or cmdrClient2:FindFirstChild("CmdrRemote")

        if remoteEvent2 then
          remoteEvent2:FireServer("farming", { 0 })
        end
      end
    end
  end,
})

local teleportTab = window:CreateTab("Teleport", nil)
teleportTab:CreateSection("Locations")

for _, value9 in ipairs({
  { Name = "Traphouse", Pos = vector }, { Name = "Police Department", Pos = vector2 },
  { Name = "Sheriff", Pos = vector3 }, { Name = "Clothing", Pos = vector4 },
  { Name = "Gun Store", Pos = vector5 }, { Name = "Medical", Pos = vector6 },
}) do
  teleportTab:CreateButton({
    Name = "TP to " .. value9.Name,
    Callback = function()
      local character4 = getCharacter()

      if character4 and character4:FindFirstChild("HumanoidRootPart") then
        character4.HumanoidRootPart.CFrame = CFrame.new(value9.Pos)
      end
    end,
  })
end

local jobsTab = window:CreateTab("Jobs", nil)
jobsTab:CreateSection("Auto Assign")
jobsTab:CreateButton({ Name = "Become Police", Callback = function() f1("Police") end })
jobsTab:CreateButton({ Name = "Become Criminal", Callback = function() f1("Criminal") end })
jobsTab:CreateButton({ Name = "Become Sheriff", Callback = function() f1("Sheriff") end })
jobsTab:CreateButton({ Name = "Become Medic", Callback = function() f1("Medic") end })

local visualsTab = window:CreateTab("Visuals", nil)
visualsTab:CreateSection("Players")

visualsTab:CreateToggle({
  Name = "Player ESP",
  CurrentValue = true,
  Flag = "ESP",
  Callback = function(value10) v1.ESP = value10 end,
})

local aimbotTab = window:CreateTab("Aimbot", nil)
aimbotTab:CreateSection("Aiming")

aimbotTab:CreateToggle({
  Name = "Enable Aimbot (Hold Right Click)",
  CurrentValue = false,
  Flag = "Aimbot",
  Callback = function(value11) v1.Aimbot = value11 end,
})

aimbotTab:CreateSlider({
  Name = "FOV",
  Range = { 50, 500 },
  Increment = 10,
  Suffix = "px",
  CurrentValue = 150,
  Flag = "AimbotFOV",
  Callback = function(value12) v1.AimbotFOV = value12 end,
})

aimbotTab:CreateSlider({
  Name = "Smoothness",
  Range = { 1, 20 },
  Increment = 1,
  Suffix = "x",
  CurrentValue = 3,
  Flag = "AimbotSmooth",
  Callback = function(value13) v1.AimbotSmooth = value13 end,
})

local scriptsTab = window:CreateTab("Scripts", nil)
scriptsTab:CreateSection("Loaders")

scriptsTab:CreateButton({
  Name = "MONSY V6",
  Callback = function()
    loadstring(game:HttpGet("https://api.rubis.app/v2/scrap/wFnRLrBT98LRuJtp/raw", true))()
  end,
})

scriptsTab:CreateButton({
  Name = "AIMBOT (EXUNYS)",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V3/main/src/Aimbot.lua"))()

    if type(ExunysDeveloperAimbot) == "function" then
      ExunysDeveloperAimbot()
    end
  end,
})

scriptsTab:CreateButton({
  Name = "DEX EXPLORER",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BigBoyTimme/New.Loadstring.Scripts/refs/heads/main/Dex.Explorer"))()
  end,
})

scriptsTab:CreateButton({
  Name = "INFINITE YIELD",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
  end,
})

scriptsTab:CreateButton({
  Name = "COPY MAP V2",
  Callback = function() loadstring(game:HttpGet("https://pastefy.app/lum2i8Er/raw"))() end,
})

scriptsTab:CreateButton({
  Name = "TOUCH FLING",
  Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/LgZwZ7ZB", true))()
  end,
})

scriptsTab:CreateButton({
  Name = "SNTS MAIN CHEAT",
  Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Kogoronegirito/SNTS-MAIN-CHEAT/refs/heads/main/SNTS%20MAIN%20CHEAT"))(SNTSMAINCHEAT)
  end,
})

local shopTab = window:CreateTab("Shop", nil)

local function f3(text, text2, p3)
  local flag = false
  local character5 = getCharacter()

  if not flag and character5 and character5:FindFirstChild("HumanoidRootPart") then
    local shopDisplays = workspace:FindFirstChild("ShopDisplays")

    if shopDisplays then
      for _, value14 in ipairs(shopDisplays:GetDescendants()) do
        if value14:IsA("Model") or value14:IsA("Part") then
          local lower = value14.Name:lower()

          if lower:find(text2:lower()) or lower:find(text:lower()) then
            for _, value15 in ipairs(value14:GetDescendants()) do
              if value15:IsA("ProximityPrompt") then
                local parent3 = value15.Parent

                if parent3:IsA("BasePart") then
                  character5.HumanoidRootPart.CFrame = parent3.CFrame * CFrame.new(0, 0, 4)
                  task.wait(0.5)
                  f2(value15)
                  flag = true
                  break
                end
              end
            end
          end
        end

        if flag then
          break
        end
      end
    end
  end
end

shopTab:CreateSection("Auto Purchase")

shopTab:CreateButton({
  Name = "Buy Silenced Pistol (4000)",
  Callback = function() f3("Blackmarket", "Silenced Pistol", 4000) end,
})

shopTab:CreateButton({
  Name = "Buy AK-47 (6000)",
  Callback = function() f3("Blackmarket", "AK-47", 6000) end,
})

shopTab:CreateButton({
  Name = "Buy Armor (2000)",
  Callback = function() f3("Armory", "Armor", 2000) end,
})

shopTab:CreateButton({
  Name = "Buy Coffee (25)",
  Callback = function() f3("Eatery", "Coffee", 25) end,
})

shopTab:CreateButton({
  Name = "Rent BMX (Request Event)",
  Callback = function()
    local flag2 = false
    local character6 = getCharacter()

    if not flag2 and character6 and character6:FindFirstChild("HumanoidRootPart") then
      local shopDisplays2 = workspace:FindFirstChild("ShopDisplays")

      if shopDisplays2 then
        for _, value16 in ipairs(shopDisplays2:GetDescendants()) do
          if value16:IsA("ProximityPrompt") and value16.Enabled then
            if value16.ActionText:lower():find("rent") or value16.ObjectText:lower():find("bmx")
              or value16.Parent.Name:lower():find("bmx") then
              character6.HumanoidRootPart.CFrame = value16.Parent.CFrame * CFrame.new(0, 0, 4)
              task.wait(0.5)
              f2(value16)
              flag2 = true
              break
            end
          end
        end
      end
    end
  end,
})

local dupeTab = window:CreateTab("Dupe", nil)
dupeTab:CreateSection("Item Duping")

dupeTab:CreateButton({
  Name = "Dupe To Tanga Silenced Pistol (Shop Event)",
  Callback = function()
    local character7 = getCharacter()

    if character7 and character7:FindFirstChild("HumanoidRootPart") then
      local shopDisplays3 = workspace:FindFirstChild("ShopDisplays")

      if shopDisplays3 then
        for _, value17 in ipairs(shopDisplays3:GetDescendants()) do
          if value17:IsA("ProximityPrompt") and value17.Enabled then
            if value17.Parent.Name:lower():find("silenced")
              or value17.ObjectText:lower():find("silenced") then
              character7.HumanoidRootPart.CFrame = value17.Parent.CFrame * CFrame.new(0, 0, 4)
              task.wait(0.5)
              f2(value17)
              break
            end
          end
        end
      end
    end
  end,
})

dupeTab:CreateButton({
  Name = "Drop All Tools",
  Callback = function()
    local character8 = getCharacter()
    local humanoid = character8 and character8:FindFirstChildOfClass("Humanoid")
    local backpack = localPlayer:FindFirstChild("Backpack")

    if humanoid and backpack then
      for _, value18 in ipairs(backpack:GetChildren()) do
        if value18:IsA("Tool") then
          humanoid:EquipTool(value18)
          task.wait(0.1)
          value18.Parent = workspace
        end
      end
    end
  end,
})

dupeTab:CreateButton({
  Name = "Auto Buy Silenced Pistol (Loop)",
  Callback = function()
    task.spawn(function()
      for j = 1, 50 do
        pcall(function()
          local gunShop = replicatedStorage:FindFirstChild("GunShop")

          if gunShop then
            local events = gunShop:FindFirstChild("Events")

            if events then
              local purchase = events:FindFirstChild("Purchase")

              if purchase then
                purchase:FireServer("Silenced Pistol", 0)
              end
            end
          end
        end)

        task.wait(0.1)
      end
    end)
  end,
})

dupeTab:CreateButton({
  Name = "Itrigger ngani ang Purchase Event (Proximity)",
  Callback = function()
    local character9 = getCharacter()

    if character9 and character9:FindFirstChild("HumanoidRootPart") then
      local shopDisplays4 = workspace:FindFirstChild("ShopDisplays")

      if shopDisplays4 then
        for _, value19 in ipairs(shopDisplays4:GetDescendants()) do
          if value19:IsA("ProximityPrompt") and value19.Enabled then
            if value19.ActionText:lower():find("buy") or value19.ObjectText:lower():find("buy") then
              character9.HumanoidRootPart.CFrame = value19.Parent.CFrame * CFrame.new(0, 0, 4)
              task.wait(0.5)
              f2(value19)
              break
            end
          end
        end
      end
    end
  end,
})

local map = {}

local circle = Drawing.new("Circle")
circle.Thickness = 1
circle.Color = Color3.fromRGB(255, 0, 51)
circle.Filled = false

runService.RenderStepped:Connect(function()
  if v1.ESP then
    for _, value20 in ipairs(players:GetPlayers()) do
      if value20 ~= localPlayer and value20.Character
        and value20.Character:FindFirstChild("Head") then
        local screenPoint, onScreen = currentCamera:WorldToViewportPoint(value20.Character.Head.Position)

        if not map[value20] then
          map[value20] = { Line = Drawing.new("Line") }
          map[value20].Line.Color = Color3.fromRGB(255, 255, 255)
          map[value20].Line.Thickness = 1
        end

        local v3 = map[value20]

        if onScreen then
          v3.Line.From = Vector2.new(
            currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y
          )

          v3.Line.To = Vector2.new(screenPoint.X, screenPoint.Y)
          v3.Line.Visible = true
        else
          v3.Line.Visible = false
        end
      end
    end
  else
    for _, value21 in pairs(map) do
      if value21.Line then
        value21.Line.Visible = false
      end
    end
  end

  circle.Position = userInputService:GetMouseLocation()
  circle.Radius = v1.AimbotFOV
  circle.Visible = v1.Aimbot

  if v1.Aimbot and userInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
    local aimbotFOV = v1.AimbotFOV
    local getMouseLocation = userInputService:GetMouseLocation()
    local head

    for _, value22 in ipairs(players:GetPlayers()) do
      if value22 ~= localPlayer and value22.Character
        and value22.Character:FindFirstChild("Head") then
        local screenPoint2, onScreen2 = currentCamera:WorldToViewportPoint(value22.Character.Head.Position)

        if onScreen2 then
          local magnitude = (Vector2.new(screenPoint2.X, screenPoint2.Y)
            - getMouseLocation).Magnitude

          if magnitude < aimbotFOV then
            aimbotFOV = magnitude
            head = value22.Character.Head
          end
        end
      end
    end

    if head then
      local cframe = CFrame.new(currentCamera.CFrame.Position, head.Position)
      currentCamera.CFrame = currentCamera.CFrame:Lerp(cframe, 1 / v1.AimbotSmooth)
    end
  end
end)
