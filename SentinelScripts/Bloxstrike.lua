-- spaghetti code

local players, workspaceService, runService, replicatedStorage, userInputService, lighting,
  coreGui, httpService, starterGui

do
  players = game:GetService("Players")
  workspaceService = game:GetService("Workspace")
  runService = game:GetService("RunService")
  replicatedStorage = game:GetService("ReplicatedStorage")
  userInputService = game:GetService("UserInputService")
  local soundService = game:GetService("SoundService")
  lighting = game:GetService("Lighting")
  coreGui = game:GetService("CoreGui")
  local tweenService = game:GetService("TweenService")
  httpService = game:GetService("HttpService")
  local statsService = game:GetService("Stats")
  starterGui = game:GetService("StarterGui")
end

do
  do
    do
      do
        do
          do
            do
              do
                do
                  do
                    do
                      do
                        do
                          do
                            do
                              do
                                local v1 = 2
                                local floor = math.floor
                                local v2 = 0
                                local v3 = {}
                                local char = string.char
                                local remove = table.remove
                                local random = math.random
                                local v4 = {}
                                local count = 0

                                while true do
                                  count = 1 + count

                                  if not (256 >= count) then
                                    break
                                  end

                                  local v5 = count
                                  v4[v5] = v5
                                end

                                while true do
                                  local v6 = remove(v4, (random(1, #v4)))
                                  v3[v6] = char(v6 - 1)

                                  if #v4 == 0 then
                                    break
                                  end
                                end

                                local v7 = {}

                                local function f1()
                                  if #v7 == 0 then
                                    v2 = (v2 * 213 + 27552854471197) % 35184372088832

                                    while true do
                                      v1 = v1 * 201 % 257

                                      if v1 ~= 1 then
                                        break
                                      end
                                    end

                                    local v8 = v1 % 32

                                    local v9 = floor(v2 / 2 ^ (13 - (v1 - v8) / 32))
                                        % 4294967296
                                      / 2 ^ v8

                                    local v10 = floor(v9 % 1 * 4294967296) + floor(v9)
                                    local v11 = v10 % 65536
                                    local v12 = (v10 - v11) / 65536

                                    v7 = {
                                      v11 % 256, (v11 - v11 % 256) / 256, v12 % 256,
                                      (v12 - v12 % 256) / 256,
                                    }
                                  end

                                  local v13 = #v7
                                  local v14 = v7[v13]
                                  v7[v13] = nil
                                  return v14
                                end

                                local v15 = {}

                                local v16 = setmetatable({}, {
                                  __index = v15,
                                  __metatable = nil,
                                })

                                local function f2(p1, p2)
                                  if v15[p2] then
                                    return p2
                                  else
                                    v7 = {}
                                    local text = ""
                                    v2 = p2 % 35184372088832
                                    v1 = p2 % 255 + 2
                                    local v17 = #p1
                                    v15[p2] = ""
                                    local v18 = 204
                                    local count2 = 0

                                    while true do
                                      count2 = 1 + count2

                                      if not (v17 >= count2) then
                                        break
                                      end

                                      v18 = (string.byte(p1, count2) + f1() + v18) % 256
                                      text = text .. v3[v18 + 1]
                                    end

                                    v15[p2] = text
                                    return p2
                                  end
                                end

                                local localPlayer = players.LocalPlayer
                                local currentCamera = workspaceService.CurrentCamera

                                local function f3()
                                  if typeof(hookfunction) ~= "function" then
                                    return false
                                  elseif typeof(getgc) ~= "function" then
                                    return false
                                  elseif typeof(setreadonly) ~= "function" then
                                    return false
                                  elseif typeof(newcclosure) ~= "function" then
                                    return false
                                  else
                                    if typeof(getrawmetatable) ~= "function" then
                                      return false
                                    end

                                    if typeof(Drawing) ~= "table"
                                      and typeof(Drawing) ~= "userdata" then
                                      return false
                                    end

                                    return true
                                  end
                                end

                                if not f3() then
                                  pcall(function()
                                    localPlayer:Kick([[
Unknown isn't supported.

Join the discord server to have the list of all friendly executors.

https://discord.gg/dyQsQVV8ck]])
                                  end)

                                  return
                                end

                                local ambient = lighting.Ambient
                                local outdoorAmbient = lighting.OutdoorAmbient
                                local brightness = lighting.Brightness
                                local fogEnd = lighting.FogEnd
                                local fogStart = lighting.FogStart

                                local f4

                                function f4()
                                  local zero = Vector3.zero
                                  local lookVector = currentCamera.CFrame.LookVector
                                  local rightVector = currentCamera.CFrame.RightVector

                                  if userInputService:IsKeyDown(Enum.KeyCode.W) then
                                    zero = zero + lookVector
                                  end

                                  if userInputService:IsKeyDown(Enum.KeyCode.S) then
                                    zero = zero - lookVector
                                  end

                                  if userInputService:IsKeyDown(Enum.KeyCode.A) then
                                    zero = zero - rightVector
                                  end

                                  if userInputService:IsKeyDown(Enum.KeyCode.D) then
                                    zero = zero + rightVector
                                  end

                                  return Vector3.new(zero.X, 0, zero.Z).Unit
                                end

                                SentinelLastInteraction = tick()
                                SilentFovRadiusValue = 50
                                workspaceService:WaitForChild("Characters", 10)

                                local f5

                                function f5(p3)
                                  if not p3 then
                                    return nil
                                  end

                                  if p3.Team then
                                    return p3.Team.Name
                                  end

                                  return nil
                                end

                                local dist = nil

                                local f6, f7, f8, window, f9, f10, f11, f12, f13, f14, f15, f16,
                                  f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28,
                                  f29, f30, f31, v19, f32, v20, slider, v21, v22, v23, v24, v25,
                                  f33, f34, f35, f36, f37, v26, v27, circle, raycastParams, v28,
                                  f38, f39, f40, color, f41, v29, esplib, v30, abs, huge,
                                  floor2, clamp, sin, cos, v31, v32, v33, v34, v35,
                                  worldToViewportPoint, box, healthbar, healthtext, name,
                                  distance, tracer, skeleton, weapon, circulartarget, v36, f42,
                                  f43, v37, v38, f44, v39, v40, v41, waitForChild, f45, f46,
                                  newindex, v42, v43, connect, f47, v44, f48,
                                  sentinelWeatherSky, sentinelWeatherGround, v45, f49, v46, f50,
                                  f51, f52, v47, v48, raycastParams2, f53, f54, f55, f56, v49,
                                  f57, v50, v51, v52, v53, f58, configManager, v54, v55, v56

                                if not pcall(function()
                                  dist = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
                                end) or not dist then
                                  starterGui:SetCore("SendNotification", {
                                    Title = "WindUI Error",
                                    Text = "Failed to load WindUI.",
                                    Duration = 15,
                                  })

                                  return
                                else
                                  pcall(function()
                                    dist.Creator.AddThemes({ "Light", "Dark", "Rose" })
                                  end)

                                  dist.Services["SentinelKey-Bloxstrike"] = {
                                    Name = "Sentinel Key System",
                                    Icon = "key-round",
                                    Args = { "Link", "ButtonName", "ButtonDesc" },
                                    New = function(p4, p5, p6)
                                      return {
                                        Name = p5 or "Copy",
                                        Desc = p6 or "Click to copy.",
                                        Verify = function(p7)
                                          if not p7 or p7 == "" then
                                            return false, "Please enter a key."
                                          end

                                          if tostring(p7) == "Sentinel.BloxStrike.Qy27d" then
                                            return true, "Key valid! Welcome to Sentinel."
                                          end

                                          return false, "Invalid key. Check your key and try again."
                                        end,
                                        Copy = function()
                                          if setclipboard then
                                            pcall(setclipboard, p4)
                                          end

                                          return p4
                                        end,
                                      }
                                    end,
                                  }

                                  dist:SetTheme("Amber")

                                  v19 = { Elements = {} }
                                  Toggles = {}
                                  Options = {}

                                  function f6(p8, p9)
                                    local v57 = {
                                      Value = p9 or false,
                                      _changed = {},
                                      _name = p8,
                                    }

                                    function v57:SetValue(p10)
                                      self.Value = p10
                                      local v58 = v19.Elements[p8]

                                      if v58 and v58.Set then
                                        pcall(function() v58:Set(p10) end)
                                      end

                                      f32(self, p10)
                                    end

                                    function v57:OnChanged(p11)
                                    end

                                    Toggles[p8] = v57
                                    return v57
                                  end

                                  function f32(p12, p13)
                                  end

                                  local function f59(p14, title, callback)
                                    return p14:Button({ Title = title, Callback = callback })
                                  end

                                  function f7(p15, value)
                                    local v59 = {
                                      Value = value,
                                      _changed = {},
                                      _name = p15,
                                      _values = nil,
                                    }

                                    function v59:SetValue(p16)
                                      self.Value = p16
                                      local v60 = v19.Elements[p15]

                                      if v60 and v60.Set then
                                        pcall(function() v60:Set(p16) end)
                                      end

                                      f32(self, p16)
                                    end

                                    function v59:SetValues(p17)
                                      self._values = p17
                                      local v61 = v19.Elements[p15]

                                      if v61 and v61.Refresh then
                                        pcall(function() v61:Refresh(p17) end)
                                      end
                                    end

                                    function v59.GetState(p18)
                                      return p18.Value
                                    end

                                    function v59:OnChanged(p19)
                                    end

                                    Options[p15] = v59
                                    return v59
                                  end

                                  local function f60(p20, p21, title2, p22, min, max, p23, p24, p25)
                                    local v62 = p25
                                    local v63 = f7(p21, p22)
                                    v62 = v62 or {}

                                    local slider2 = p20:Slider({
                                      Title = title2,
                                      Value = { Min = min, Max = max, Default = p22 },
                                      Rounding = p23 or 0,
                                      Suffix = p24 or "",
                                      Flag = p21,
                                      Callback = function(value2)
                                        local value3 = value2

                                        if type(value3) == "table" then
                                          value3 = value3.Value or value3.Default
                                            or value3.Current
                                        end

                                        if type(value3) == "string" then
                                          value3 = tonumber(value3) or v63.Value
                                        end

                                        if type(value3) ~= "number" then
                                          return
                                        end

                                        v63.Value = value3
                                        f32(v63, value3)

                                        if v62.Callback then
                                          v62.Callback(value3)
                                        end
                                      end,
                                    })

                                    v19.Elements[p21] = slider2
                                    return slider2
                                  end

                                  local function f61(p26, p27, title3, p28, p29)
                                    local v64 = p29
                                    local v65 = f6(p27, p28)
                                    v64 = v64 or {}

                                    local v67 = {
                                      Title = title3,
                                      Default = p28,
                                      Flag = p27,
                                      Callback = function(value4)
                                        v65.Value = value4
                                        f32(v65, value4)

                                        if v64.Callback then
                                          v64.Callback(value4)
                                        end
                                      end,
                                    }

                                    if v64.Disabled then
                                      v67.Locked = true
                                      v67.LockedTitle = v64.DisabledTooltip or "Unavailable"
                                    end

                                    local toggle = p26:Toggle(v67)
                                    v19.Elements[p27] = toggle
                                    return toggle
                                  end

                                  local function f62(p30, p31, title4, p32, p33, p34, p35)
                                    local v68 = p35

                                    local v69 = f7(p31, p33)
                                    v69._values = p32

                                    v68 = v68 or {}

                                    local v70 = {
                                      Title = title4,
                                      Values = p32,
                                      Value = p33,
                                      Multi = p34 or false,
                                      Flag = p31,
                                      Callback = function(value5)
                                        v69.Value = value5
                                        f32(v69, value5)

                                        if v68.Callback then
                                          v68.Callback(value5)
                                        end
                                      end,
                                    }

                                    if v68.Locked then
                                      v70.Locked = true
                                      v70.LockedTitle = v68.LockedTitle or "Locked"
                                    end

                                    local dropdown = p30:Dropdown(v70)
                                    v19.Elements[p31] = dropdown

                                    if v68.Locked and dropdown and dropdown.Lock then
                                      pcall(function() dropdown:Lock() end)
                                    end

                                    return dropdown
                                  end

                                  local v71 = dist

                                  local function f63(p36, p37, title5, p38, p39)
                                    local v72 = p39
                                    local v73 = f7(p37, p38)
                                    v72 = v72 or {}

                                    local colorpicker = p36:Colorpicker({
                                      Title = title5,
                                      Default = p38,
                                      Flag = p37,
                                      Callback = function(value6)
                                        v73.Value = value6
                                        f32(v73, value6)

                                        if v72.Callback then
                                          v72.Callback(value6)
                                        end
                                      end,
                                    })

                                    v19.Elements[p37] = colorpicker
                                    return colorpicker
                                  end

                                  local function f64(p40, title6, desc, p41)
                                    return p40:Paragraph({
                                      Title = title6,
                                      Desc = desc,
                                      Image = p41 or "bookmark",
                                      ImageSize = 20,
                                    })
                                  end

                                  local function f65(p42, p43, title7, p44, p45, p46)
                                    local v74 = p46
                                    local v75 = f7(p43, p44)
                                    v74 = v74 or {}

                                    local input = p42:Input({
                                      Title = title7,
                                      Default = p44 or "",
                                      Placeholder = p45 or "",
                                      Flag = p43,
                                      Callback = function(value7)
                                        v75.Value = value7
                                        f32(v75, value7)

                                        if v74.Callback then
                                          v74.Callback(value7)
                                        end
                                      end,
                                    })

                                    v19.Elements[p43] = input
                                    return input
                                  end

                                  window = v71:CreateWindow({
                                    Title = "Sentinel - BloxStrike",
                                    Author = "x4tmq",
                                    Icon = "swords",
                                    Folder = "Sentinel",
                                    ScrollBarEnabled = true,
                                    Size = UDim2.fromOffset(650, 520),
                                    ToggleKey = Enum.KeyCode.K,
                                    Theme = "Amber",
                                    HideSearchBar = false,
                                    Background = "rbxassetid://0",
                                    Resizable = true,
                                    Transparent = true,
                                    BackgroundImageTransparency = 0.5,
                                    KeySystem = {
                                      Note = [[
Enter your key to access Sentinel.
Get it from the Discord or the website below.]],
                                      SaveKey = false,
                                      API = {
                                        {
                                          Title = "Discord",
                                          Desc = "Click to copy the Discord invite link.",
                                          Icon = "message-circle",
                                          Type = "SentinelKey-Bloxstrike",
                                          Link = "https://discord.gg/dyQsQVV8ck",
                                          ButtonName = "Discord",
                                          ButtonDesc = "Click to copy the Discord invite link.",
                                        },
                                        {
                                          Title = "Website",
                                          Desc = "Click to copy the website link.",
                                          Icon = "globe",
                                          Type = "SentinelKey-Bloxstrike",
                                          Link = "https://x4tmqq.github.io/Sentinel-Script/",
                                          ButtonName = "Website",
                                          ButtonDesc = "Click to copy the website link.",
                                        },
                                      },
                                    },
                                    User = { Enabled = false },
                                  })

                                  window:EditOpenButton({
                                    Title = "Sentinel - BloxStrike",
                                    Icon = "swords",
                                    CornerRadius = UDim.new(0, 24),
                                    StrokeThickness = 2,
                                    Color = ColorSequence.new(
                                      Color3.fromHex("FF0F7B"), Color3.fromHex("F89B29")
                                    ),
                                    OnlyMobile = false,
                                    Enabled = true,
                                    Draggable = true,
                                  })

                                  local playerTab = window:Tab({
                                    Title = "Player",
                                    Icon = "user",
                                  })

                                  window:Divider()

                                  local gunModsTab = window:Tab({
                                    Title = "Gun Mods",
                                    Icon = "crosshair",
                                  })

                                  local combatTab = window:Tab({
                                    Title = "Combat",
                                    Icon = "swords",
                                  })

                                  local skinChangerTab = window:Tab({
                                    Title = "Skin Changer",
                                    Icon = "paintbrush",
                                  })

                                  window:Divider()
                                  local espTab = window:Tab({ Title = "ESP", Icon = "eye" })
                                  local visualTab = window:Tab({ Title = "Visual", Icon = "sun" })
                                  local worldTab = window:Tab({ Title = "World", Icon = "globe" })
                                  window:Divider()

                                  local settingsTab = window:Tab({
                                    Title = "Settings",
                                    Icon = "settings",
                                  })

                                  local configsTab = window:Tab({
                                    Title = "Configs",
                                    Icon = "save",
                                  })

                                  f59(settingsTab:Section({
                                    Title = "Danger Zone",
                                    Opened = true,
                                    Icon = "triangle-alert",
                                  }), "Delete Script", function()
                                    pcall(function()
                                      if window then
                                        window:Destroy()
                                      end
                                    end)
                                  end)

                                  local interfaceSection = settingsTab:Section({
                                    Title = "Interface",
                                    Opened = true,
                                    Icon = "settings",
                                  })

                                  f62(interfaceSection, "UITheme", "UI Theme", {
                                    "Amber", "CottonCandy", "Crimson", "Dark", "Emerald",
                                    "Indigo", "Light", "Mellowsi", "Midnight", "MonokaiPro",
                                  }, "Amber", false, {
                                    Callback = function(value8)
                                      pcall(function() dist:SetTheme(value8) end)
                                    end,
                                  })

                                  f62(interfaceSection, "MinimizeKeybind", "Minimize Keybind", {
                                    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L",
                                    "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X",
                                    "Y", "Z", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8",
                                    "F9", "F10", "F11", "F12", "Zero", "One", "Two", "Three",
                                    "Four", "Five", "Six", "Seven", "Eight", "Nine",
                                  }, "K", false, { Callback = function(value9) end })

                                  interfaceSection:Divider()

                                  v20 = f64(interfaceSection, "Sentinel Status", [[
Status: Active
FPS: 0
Ping: 0 ms]], "bookmark")

                                  task.spawn(function()
                                    local v76 = 0
                                    local v77 = 0
                                    local v78 = tick()

                                    runService.RenderStepped:Connect(function()
                                      v77 = v77 + 1
                                      local v79 = tick()

                                      if v79 - v78 >= 1 then
                                        v76 = v77
                                        v77 = 0
                                        v78 = v79
                                      end
                                    end)

                                    while task.wait(0.5) do
                                      pcall(function()
                                        local v80 = tick() - (SentinelLastInteraction or tick())
                                              >= 10
                                            and "AFK"
                                          or "Active"

                                        local getNetworkPing = localPlayer:GetNetworkPing()

                                        local v81 = "Status: " .. v80 .. "\nFPS: " .. v76
                                          .. "\nPing: " .. math.floor(getNetworkPing * 1000)
                                          .. " ms"

                                        if v20 then
                                          if not pcall(function() v20:SetDesc(v81) end) then
                                            pcall(function()
                                              v20:Set({
                                                Title = "Sentinel Status",
                                                Desc = v81,
                                                Image = "bookmark",
                                                ImageSize = 24,
                                              })
                                            end)
                                          end
                                        end
                                      end)
                                    end
                                  end)

                                  local bunnyHopSection = playerTab:Section({
                                    Title = "Bunny Hop",
                                    Opened = true,
                                    Icon = "activity",
                                  })

                                  f61(bunnyHopSection, "AutoBhop", "Auto Bhop", false)

                                  f60(
                                    bunnyHopSection, "BhopSpeed", "Bhop Speed", 18, 5, 30, 0,
                                    "spd"
                                  )

                                  bunnyHopSection:Divider()
                                  f61(bunnyHopSection, "NoFallDamage", "No Fall Damage", false)

                                  runService.Heartbeat:Connect(function()
                                    pcall(function()
                                      local character = localPlayer.Character

                                      if not character then
                                        return
                                      else
                                        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                                        local v82 = not humanoidRootPart
                                        local humanoid = character:FindFirstChild("Humanoid")

                                        if v82 or not humanoid then
                                          return
                                        end

                                        if Toggles.AutoBhop and Toggles.AutoBhop.Value then
                                          if userInputService:IsKeyDown(Enum.KeyCode.Space) then
                                            local raycastParams3 = RaycastParams.new()

                                            raycastParams3.FilterDescendantsInstances = {
                                              character,
                                            }

                                            raycastParams3.FilterType = Enum.RaycastFilterType.Exclude

                                            if workspaceService:Raycast(
                                              humanoidRootPart.Position, Vector3.new(0, -4, 0),
                                              raycastParams3
                                            ) then
                                              humanoid.Jump = true
                                            end
                                          end

                                          local v83, v84 = pcall(function() return f4() end)

                                          if v83 and v84.Magnitude > 0 then
                                            local v85 = v84 * math.clamp(
                                              Options.BhopSpeed and Options.BhopSpeed.Value or 18,
                                              5, 30
                                            )

                                            local assemblyLinearVelocity = humanoidRootPart.AssemblyLinearVelocity

                                            humanoidRootPart.AssemblyLinearVelocity = Vector3.new(assemblyLinearVelocity.X
                                              + (v85.X - assemblyLinearVelocity.X) * 0.2, assemblyLinearVelocity.Y, assemblyLinearVelocity.Z
                                              + (v85.Z - assemblyLinearVelocity.Z) * 0.2)
                                          end
                                        end

                                        return
                                      end
                                    end)
                                  end)

                                  runService.Heartbeat:Connect(function()
                                    pcall(function()
                                      local noFallDamage = Toggles.NoFallDamage
                                      local humanoid2

                                      if noFallDamage and Toggles.NoFallDamage.Value then
                                        local character2 = localPlayer.Character

                                        if character2 then
                                          humanoid2 = character2:FindFirstChildOfClass("Humanoid")

                                          if humanoid2 then
                                            pcall(function()
                                              humanoid2:SetStateEnabled(
                                                Enum.HumanoidStateType.FallingDown, false
                                              )

                                              humanoid2:SetStateEnabled(
                                                Enum.HumanoidStateType.Ragdoll, false
                                              )
                                            end)
                                          end
                                        end
                                      end
                                    end)
                                  end)

                                  local section = gunModsTab:Section({
                                    Title = "Fire Rate Speed",
                                    Opened = true,
                                    Icon = "wrench",
                                  })

                                  f61(section, "Firerate", "Enable Firerate Changer", false, {
                                    Disabled = typeof(hookfunction) ~= "function",
                                    DisabledTooltip = "This feature is not available on your executor.",
                                  })

                                  f60(
                                    section, "FirerateSlider", "Firerate (ms)", 30, 0, 60, 0, ""
                                  )

                                  section:Divider()
                                  f61(section, "InstantReload", "Instant Reload", false)

                                  local section2 = gunModsTab:Section({
                                    Title = "Visual Weapons Mods",
                                    Opened = true,
                                    Icon = "eye",
                                  })

                                  f61(section2, "NoRecoil", "Enable No Recoil", false, {
                                    Disabled = typeof(hookfunction) ~= "function",
                                    DisabledTooltip = "This feature is not available on your executor.",
                                  })

                                  f61(section2, "NoSpread", "Enable No Spread", false, {
                                    Disabled = typeof(hookfunction) ~= "function",
                                    DisabledTooltip = "This feature is not available on your executor.",
                                  })

                                  local silentAimSection = gunModsTab:Section({
                                    Title = "Silent Aim",
                                    Opened = true,
                                    Icon = "zap",
                                  })

                                  f61(silentAimSection, "SilentAim", "Enable Silent Aim", false, {
                                    Disabled = typeof(hookfunction) ~= "function",
                                    DisabledTooltip = "This feature is not available on your executor.",
                                  })

                                  f61(
                                    silentAimSection, "SilentTeamCheck", "Enable Team Check",
                                    true
                                  )

                                  f62(silentAimSection, "SilentHitPart", "Hit Part", {
                                    "HumanoidRootPart", "Head", "LeftLowerArm", "LowerTorso",
                                    "RightHand", "RightLowerArm", "LeftFoot", "LeftHand",
                                    "RightFoot", "RightLowerLeg", "LeftLowerLeg",
                                    "RightUpperArm", "LeftUpperArm", "UpperTorso",
                                    "RightUpperLeg", "LeftUpperLeg",
                                  }, "Head", false)

                                  silentAimSection:Divider()

                                  f61(
                                    silentAimSection, "SilentUseFovCircle", "Use FOV Circle",
                                    false
                                  )

                                  f63(
                                    silentAimSection, "SilentFovColor", "FOV Circle Color",
                                    Color3.fromRGB(255, 0, 0)
                                  )

                                  slider = silentAimSection:Slider({
                                    Title = "FOV Circle Radius",
                                    Value = { Min = 0, Max = 300, Default = 50 },
                                    Rounding = 0,
                                    Suffix = "px",
                                    Flag = "SilentFovCircleRadius",
                                    Callback = function(value10)
                                      local value11 = value10

                                      if type(value10) == "table" then
                                        value11 = value10.Value or value10.Default
                                          or value10.Current
                                      end

                                      local v86 = tonumber(value11)

                                      if v86 then
                                        SilentFovRadiusValue = v86

                                        if Options.SilentFovCircleRadius then
                                          Options.SilentFovCircleRadius.Value = v86
                                        end
                                      end
                                    end,
                                  })

                                  v19.Elements.SilentFovCircleRadius = slider

                                  Options.SilentFovCircleRadius = {
                                    Value = 50,
                                    _changed = {},
                                    _name = "SilentFovCircleRadius",
                                    SetValue = function(p47, p48)
                                      local v87 = p48
                                      v87 = tonumber(v87) or 50

                                      SilentFovRadiusValue = v87
                                      p47.Value = v87

                                      if slider and slider.Set then
                                        pcall(function() slider:Set(v87) end)
                                      end

                                      for index, value12 in ipairs(p47._changed) do
                                        pcall(value12, v87)
                                      end
                                    end,
                                    OnChanged = function(value13, p49) end,
                                    GetState = function(p50) return p50.Value end,
                                  }

                                  silentAimSection:Divider()
                                  f61(silentAimSection, "SilentWallbang", "WallBang", false)

                                  local rageModSection = gunModsTab:Section({
                                    Title = "Rage Mod",
                                    Opened = true,
                                    Icon = "flame",
                                  })

                                  f61(rageModSection, "Ragebot", "Enable Ragebot", false, {
                                    Disabled = typeof(hookfunction) ~= "function",
                                    DisabledTooltip = "This feature is not available on your executor.",
                                  })

                                  rageModSection:Divider()

                                  f61(
                                    rageModSection, "RagebotWallCheck", "Enable Wall Check",
                                    false
                                  )

                                  f61(
                                    rageModSection, "RagebotVisibleCheck",
                                    "Enable Visible Check", true
                                  )

                                  f61(
                                    rageModSection, "RagebotTeamCheck", "Enable Team Check",
                                    true
                                  )

                                  rageModSection:Divider()

                                  f60(
                                    rageModSection, "RageDelay", "Delay (ms)", 20, 1, 1000, 0,
                                    "ms"
                                  )

                                  f62(
                                    rageModSection, "RageHitPart", "Hit Selection",
                                    { "Head", "HumanoidRootPart", "UpperTorso", "LowerTorso" },
                                    "Head", false
                                  )

                                  function f8()
                                    local v88 = { "AUTO" }

                                    for index2, value14 in ipairs(players:GetPlayers()) do
                                      if value14 ~= localPlayer then
                                        local v89 = f5(value14)
                                        local v90 = f5(localPlayer)

                                        if v89 == nil or v90 == nil or v89 ~= v90 then
                                          table.insert(v88, value14.Name)
                                        end
                                      end
                                    end

                                    return v88
                                  end

                                  v21 = nil

                                  f62(rageModSection, "RagePriorityTarget", "Priority Target", f8(), "AUTO", false, {
                                    Locked = true,
                                    LockedTitle = "under beta...",
                                    Callback = function(value15)
                                      v21 = (value15 == "AUTO" or value15 == "[ AUTO ]") and nil
                                        or value15
                                    end,
                                  })

                                  task.spawn(function()
                                    while task.wait(3) do
                                      pcall(function()
                                        if Options.RagePriorityTarget then
                                          local v91 = f8()

                                          if Options.RagePriorityTarget.SetValues then
                                            Options.RagePriorityTarget:SetValues(v91)
                                          end
                                        end
                                      end)
                                    end
                                  end)

                                  local hitSoundSection = combatTab:Section({
                                    Title = "Hit Sound",
                                    Opened = true,
                                    Icon = "volume-2",
                                  })

                                  f61(
                                    hitSoundSection, "HitSoundEnabled", "Enable Hit Sound",
                                    false
                                  )

                                  hitSoundSection:Divider()

                                  f60(
                                    hitSoundSection, "HitSoundVolume", "Hit Sound Volume", 5, 1,
                                    10, 0, "x"
                                  )

                                  f61(
                                    hitSoundSection, "CustomHitSoundToggle",
                                    "Enable Custom Hit Sound", false
                                  )

                                  f65(
                                    hitSoundSection, "CustomHitSoundID", "Custom Sound ID", "",
                                    "Clean ID or rbxassetid://..."
                                  )

                                  f62(hitSoundSection, "HitSoundPreset", "Hit Sound", {
                                    "Neverlose", "Skeet", "Bell", "Bell2", "Bubble", "Rust",
                                    "Agro1", "Agro2", "Coins", "Schaater", "Pick",
                                  }, "Neverlose", false)

                                  local hitMarkerSection = combatTab:Section({
                                    Title = "Hit Marker",
                                    Opened = true,
                                    Icon = "crosshair",
                                  })

                                  f61(
                                    hitMarkerSection, "HitMarkerEnabled", "Enable Hit Marker",
                                    false
                                  )

                                  hitMarkerSection:Divider()

                                  f63(
                                    hitMarkerSection, "HitMarkerColor", "Hit Marker Color",
                                    Color3.fromRGB(255, 255, 255)
                                  )

                                  f61(
                                    hitMarkerSection, "HitMarkerRainbow", "Rainbow Hit Marker",
                                    false
                                  )

                                  hitMarkerSection:Divider()

                                  f60(
                                    hitMarkerSection, "HitMarkerDuration", "Display Duration",
                                    20, 5, 50, 0, "x0.1s"
                                  )

                                  f60(
                                    hitMarkerSection, "HitMarkerSpinSpeed", "Spin Speed", 720,
                                    0, 1440, 0, "deg/s"
                                  )

                                  f60(
                                    hitMarkerSection, "HitMarkerSize", "Size", 25, 5, 50, 0,
                                    "px"
                                  )

                                  f60(
                                    hitMarkerSection, "HitMarkerThickness", "Thickness", 2, 1,
                                    6, 0, "px"
                                  )

                                  task.spawn(function()
                                    local v92 = {}

                                    runService.RenderStepped:Connect(function()
                                      pcall(function()
                                        local v93 = tick()

                                        local value16 = Toggles.HitMarkerEnabled
                                          and Toggles.HitMarkerEnabled.Value

                                        local value17 = Options.HitMarkerColor
                                            and Options.HitMarkerColor.Value
                                          or Color3.fromRGB(255, 255, 255)

                                        if Toggles.HitMarkerRainbow
                                          and Toggles.HitMarkerRainbow.Value then
                                          value17 = Color3.fromHSV(v93 % 5 / 5, 1, 1)
                                        end

                                        local value18 = Options.HitMarkerSize
                                            and Options.HitMarkerSize.Value
                                          or 25

                                        local value19 = Options.HitMarkerSpinSpeed
                                            and Options.HitMarkerSpinSpeed.Value
                                          or 720

                                        local v94 = 1 + 0.35 * math.sin(v93 * math.pi)
                                        local v95 = value18 * v94
                                        local v96 = 6 * v94
                                        local v97 = #v92 - -1

                                        while true do
                                          v97 = -1 + v97

                                          if not (v97 >= 1 or false) then
                                            break
                                          end

                                          local v98 = v97
                                          local v99 = v92[v98]

                                          if not value16 or v93 > v99.expireTick then
                                            for index3, value20 in ipairs(v99.lines) do
                                            end

                                            table.remove(v92, v98)
                                          else
                                            local v100, v101 = currentCamera:WorldToViewportPoint(v99.worldPos)

                                            if v101 then
                                              local vector = Vector2.new(v100.X, v100.Y)

                                              local v102 = math.rad((v93 - v99.spawnTick)
                                                  * value19
                                                % 360)

                                              local v103 = { 0, 90, 180, 270 }

                                              for i = 1, 4 do
                                                local v104 = v99.lines[i]
                                                v104.Color = value17

                                                v104.Thickness = Options.HitMarkerThickness
                                                    and Options.HitMarkerThickness.Value
                                                  or 2

                                                local v105 = v102 + math.rad(v103[i])
                                                local v106 = math.cos(v105)
                                                local v107 = math.sin(v105)

                                                v104.From = vector
                                                  + Vector2.new(v106 * v96, v107 * v96)

                                                v104.To = vector + Vector2.new(
                                                  v106 * (v96 + v95), v107 * (v96 + v95)
                                                )

                                                v104.Visible = true
                                              end
                                            else
                                              for index4, value21 in ipairs(v99.lines) do
                                                value21.Visible = false
                                              end
                                            end
                                          end
                                        end
                                      end)
                                    end)
                                  end)

                                  local bulletVisualizerSection = combatTab:Section({
                                    Title = "Bullet Visualizer",
                                    Opened = true,
                                    Icon = "activity",
                                  })

                                  f61(
                                    bulletVisualizerSection, "BulletTracers", "Bullet Tracer",
                                    false
                                  )

                                  f61(
                                    bulletVisualizerSection, "BulletImpacts", "Bullet Impact",
                                    false
                                  )

                                  bulletVisualizerSection:Divider()

                                  f60(
                                    bulletVisualizerSection, "TracerTime", "Tracer Time", 20, 1,
                                    100, 0, "x0.1s"
                                  )

                                  bulletVisualizerSection:Divider()

                                  f63(
                                    bulletVisualizerSection, "BulletTracersColor",
                                    "Tracer Color", Color3.fromRGB(0, 170, 255)
                                  )

                                  f61(
                                    bulletVisualizerSection, "TracerRainbow",
                                    "Tracer Rainbow Mode", false
                                  )

                                  f63(
                                    bulletVisualizerSection, "BulletImpactsColor",
                                    "Impact Color", Color3.fromRGB(255, 0, 0)
                                  )

                                  f62(
                                    bulletVisualizerSection, "TracerStyle", "Tracer Style",
                                    { "Block", "Cylinder (Obelius)" }, "Block", false
                                  )

                                  local weaponChamsSection = combatTab:Section({
                                    Title = "Weapon Chams",
                                    Opened = true,
                                    Icon = "eye",
                                  })

                                  f61(
                                    weaponChamsSection, "WeaponChamsEnabled",
                                    "Enable Weapon Chams", false
                                  )

                                  weaponChamsSection:Divider()

                                  f62(
                                    weaponChamsSection, "WeaponChamsMode",
                                    "Chams Material/Type",
                                    { "Glass", "ForceField", "Metal", "Highlight", "Neon" },
                                    "Glass", false
                                  )

                                  f63(
                                    weaponChamsSection, "WeaponChamsColor", "Chams Color",
                                    Color3.fromRGB(0, 150, 255)
                                  )

                                  weaponChamsSection:Divider()

                                  f60(
                                    weaponChamsSection, "GlassTransparency",
                                    "Glass Transparency", 40, 0, 100, 0, "%"
                                  )

                                  f60(
                                    weaponChamsSection, "MetalReflectance", "Metal Reflectance",
                                    100, 0, 100, 0, "%"
                                  )

                                  v22 = {}

                                  runService.RenderStepped:Connect(function()
                                    pcall(function()
                                      local value22 = Toggles.WeaponChamsEnabled
                                        and Toggles.WeaponChamsEnabled.Value

                                      local value23 = Options.WeaponChamsMode
                                          and Options.WeaponChamsMode.Value
                                        or "Glass"

                                      local value24 = Options.WeaponChamsColor
                                          and Options.WeaponChamsColor.Value
                                        or Color3.fromRGB(0, 150, 255)

                                      local v108

                                      for index5, value25 in ipairs(currentCamera:GetChildren()) do
                                        if value25:IsA("Model") and value25.Name ~= "Viewmodel"
                                          and not value25.Name:lower():find("light") then
                                          local weapon2 = value25:FindFirstChild("Weapon")
                                            or value25

                                          if weapon2:IsA("Model")
                                            and weapon2.Name ~= "Viewmodel"
                                            and not weapon2.Name:lower():find("light") then
                                            v108 = weapon2
                                            break
                                          end
                                        end
                                      end

                                      if not value22 or not v108 then
                                        for key, value26 in pairs(v22) do
                                        end

                                        v22 = {}

                                        if not value22 or not v108 then
                                          return
                                        end
                                      end

                                      local getDescendants = v108.GetDescendants
                                      local v109 = {}

                                      for index6, value27 in ipairs(getDescendants(v108)) do
                                        local v110 = value27

                                        if v110:IsA("BasePart") and v110.Name ~= "Hitbox"
                                          and v110.Name ~= "HumanoidRootPart" then
                                          if v110.Name == "ViewmodelLight"
                                            or v110:FindFirstAncestor("ViewmodelLight")
                                            or v110:FindFirstAncestor("Viewmodel") then
                                          else
                                            pcall(function()
                                              if value23 == "Highlight" then
                                                v109[v110] = true
                                                local weaponChamsHighlight = v110:FindFirstChild("WeaponChamsHighlight")

                                                if not weaponChamsHighlight then
                                                  weaponChamsHighlight = Instance.new("Highlight")
                                                  weaponChamsHighlight.Name = "WeaponChamsHighlight"
                                                  weaponChamsHighlight.Adornee = v110
                                                  weaponChamsHighlight.Parent = v110
                                                  weaponChamsHighlight.FillTransparency = 0
                                                  weaponChamsHighlight.OutlineTransparency = 1
                                                  weaponChamsHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

                                                  table.insert(v22, weaponChamsHighlight)
                                                end

                                                weaponChamsHighlight.FillColor = value24
                                              else
                                                local weaponChamsHighlight2 = v110:FindFirstChild("WeaponChamsHighlight")

                                                if weaponChamsHighlight2 then
                                                  weaponChamsHighlight2:Destroy()
                                                end

                                                if value23 ~= "Neon" then
                                                  for index7, value28 in ipairs(v110:GetChildren()) do
                                                    if value28:IsA("SurfaceAppearance")
                                                      or value28:IsA("Texture")
                                                      or value28:IsA("Decal") then
                                                      value28:Destroy()
                                                    end
                                                  end
                                                end

                                                if value23 == "Glass" then
                                                  v110.Material = Enum.Material.Glass
                                                  v110.Color = value24

                                                  v110.Transparency = (Options.GlassTransparency
                                                        and Options.GlassTransparency.Value
                                                      or 40)
                                                    / 100
                                                elseif value23 == "ForceField" then
                                                  v110.Material = Enum.Material.ForceField
                                                  v110.Color = value24
                                                  v110.Transparency = 0
                                                elseif value23 == "Metal" then
                                                  v110.Material = Enum.Material.Metal
                                                  v110.Color = value24

                                                  v110.Reflectance = (Options.MetalReflectance
                                                        and Options.MetalReflectance.Value
                                                      or 100)
                                                    / 100

                                                  v110.Transparency = 0
                                                elseif value23 == "Neon" then
                                                  v110.Material = Enum.Material.Neon
                                                  v110.Color = value24
                                                  v110.Transparency = 0

                                                  for index8, value29 in ipairs(v110:GetChildren()) do
                                                    if value29:IsA("SurfaceAppearance")
                                                      or value29:IsA("Texture")
                                                      or value29:IsA("Decal") then
                                                      value29:Destroy()
                                                    end
                                                  end
                                                end
                                              end
                                            end)
                                          end
                                        end
                                      end

                                      if value23 == "Highlight" then
                                        for j = #v22, 1, -1 do
                                          local v111 = v22[j]

                                          if not v111 or not v111.Parent
                                            or not v109[v111.Adornee] then
                                            if v111 then
                                              v111:Destroy()
                                            end

                                            table.remove(v22, j)
                                          end
                                        end
                                      end
                                    end)
                                  end)

                                  local customScopeSection = combatTab:Section({
                                    Title = "Custom Scope",
                                    Opened = true,
                                    Icon = "crosshair",
                                  })

                                  f61(
                                    customScopeSection, "CustomScopeFov", "Custom Scope FOV",
                                    false
                                  )

                                  f60(
                                    customScopeSection, "ScopeFovValue", "Scope FOV", 70, 10,
                                    100, 0, "deg"
                                  )

                                  customScopeSection:Divider()

                                  f61(customScopeSection, "RemoveScope", "Remove Scope", false)

                                  f61(
                                    customScopeSection, "CustomScopeCrosshair",
                                    "Scope Crosshair", false
                                  )

                                  customScopeSection:Divider()

                                  f63(
                                    customScopeSection, "ScopeCrosshairColor",
                                    "Crosshair Color", Color3.fromRGB(255, 255, 255)
                                  )

                                  customScopeSection:Divider()

                                  f60(
                                    customScopeSection, "ScopeCrosshairThickness",
                                    "Crosshair Thickness", 2, 1, 10, 0, "px"
                                  )

                                  f60(
                                    customScopeSection, "ScopeCrosshairLengthLR",
                                    "Left & Right Length", 150, 0, 1000, 0, "px"
                                  )

                                  f60(
                                    customScopeSection, "ScopeCrosshairLengthTB",
                                    "Top & Bottom Length", 100, 0, 1000, 0, "px"
                                  )

                                  task.spawn(function()
                                    local sentinelScopeCrosshair = Instance.new("ScreenGui")
                                    sentinelScopeCrosshair.Name = "Sentinel_ScopeCrosshair"
                                    sentinelScopeCrosshair.ResetOnSpawn = false

                                    pcall(function() sentinelScopeCrosshair.Parent = coreGui end)

                                    local instance = Instance.new(
                                      "Frame", sentinelScopeCrosshair
                                    )

                                    instance.BackgroundTransparency = 1
                                    instance.AnchorPoint = Vector2.new(0.5, 0.5)
                                    instance.Position = UDim2.new(0.5, 0, 0.5, 0)
                                    instance.Size = UDim2.new(0, 0, 0, 0)

                                    local instance2 = Instance.new("Frame", instance)
                                    instance2.AnchorPoint = Vector2.new(1, 0.5)
                                    instance2.BorderSizePixel = 0

                                    local instance3 = Instance.new("Frame", instance)
                                    instance3.AnchorPoint = Vector2.new(0, 0.5)
                                    instance3.BorderSizePixel = 0

                                    local instance4 = Instance.new("Frame", instance)
                                    instance4.AnchorPoint = Vector2.new(0.5, 1)
                                    instance4.BorderSizePixel = 0

                                    local instance5 = Instance.new("Frame", instance)
                                    instance5.AnchorPoint = Vector2.new(0.5, 0)
                                    instance5.BorderSizePixel = 0

                                    runService.RenderStepped:Connect(function()
                                      pcall(function()
                                        local v112 = false
                                        local playerGui = localPlayer:FindFirstChild("PlayerGui")

                                        if playerGui then
                                          local v113, v114 = pcall(function()
                                            return playerGui.MainGui.Gameplay.Middle.SniperScope
                                          end)

                                          if v113 and v114 and v114.Visible then
                                            v112 = true
                                          end
                                        end

                                        local value30 = Toggles.CustomScopeCrosshair
                                          and Toggles.CustomScopeCrosshair.Value and v112

                                        instance.Visible = value30

                                        if value30 then
                                          local value31 = Options.ScopeCrosshairColor
                                              and Options.ScopeCrosshairColor.Value
                                            or Color3.fromRGB(255, 255, 255)

                                          instance2.BackgroundColor3 = value31
                                          instance3.BackgroundColor3 = value31
                                          instance4.BackgroundColor3 = value31
                                          instance5.BackgroundColor3 = value31

                                          local value32 = Options.ScopeCrosshairThickness
                                              and Options.ScopeCrosshairThickness.Value
                                            or 2

                                          local value33 = Options.ScopeCrosshairLengthLR
                                              and Options.ScopeCrosshairLengthLR.Value
                                            or 150

                                          local value34 = Options.ScopeCrosshairLengthTB
                                              and Options.ScopeCrosshairLengthTB.Value
                                            or 100

                                          instance2.Size = UDim2.new(0, value33, 0, value32)
                                          instance2.Position = UDim2.new(0, 0, 0, 0)

                                          instance3.Size = UDim2.new(0, value33, 0, value32)
                                          instance3.Position = UDim2.new(0, 0, 0, 0)

                                          instance4.Size = UDim2.new(0, value32, 0, value34)
                                          instance4.Position = UDim2.new(0, 0, 0, 0)

                                          instance5.Size = UDim2.new(0, value32, 0, value34)
                                          instance5.Position = UDim2.new(0, 0, 0, 0)
                                        end
                                      end)
                                    end)
                                  end)

                                  task.spawn(function()
                                    local renderStepped = runService.RenderStepped
                                    local v115

                                    renderStepped:Connect(function()
                                      if v115 and not v115.Parent then
                                        v115 = nil
                                      end

                                      local playerGui2

                                      if not v115 then
                                        playerGui2 = localPlayer:FindFirstChild("PlayerGui")

                                        if playerGui2 then
                                          local v116, v117 = pcall(function()
                                            return playerGui2.MainGui.Gameplay.Middle.SniperScope
                                          end)

                                          if v116 and v117 then
                                            v115 = v117
                                          end
                                        end
                                      end

                                      local v118 = v115

                                      if not Toggles.RemoveScope
                                        or not Toggles.RemoveScope.Value then
                                        if v118 then
                                          if v118.Size ~= UDim2.new(1, 0, 1, 0) then
                                            v118.Size = UDim2.new(1, 0, 1, 0)
                                          end
                                        end

                                        return
                                      end

                                      if v118 then
                                        if v118.Visible == true then
                                          v118.Size = UDim2.new(0, 0, 0, 0)
                                        elseif v118.Size ~= UDim2.new(1, 0, 1, 0) then
                                          v118.Size = UDim2.new(1, 0, 1, 0)
                                        end
                                      end
                                    end)
                                  end)

                                  task.spawn(function()
                                    runService.RenderStepped:Connect(function()
                                      pcall(function()
                                        if Toggles.CustomScopeFov
                                          and Toggles.CustomScopeFov.Value then
                                          local currentCamera2 = workspaceService.CurrentCamera

                                          if currentCamera2 then
                                            local playerGui3 = localPlayer:FindFirstChild("PlayerGui")

                                            if playerGui3 then
                                              local sniperScope = playerGui3:FindFirstChild("MainGui")
                                                and playerGui3.MainGui:FindFirstChild("Gameplay")
                                                and playerGui3.MainGui.Gameplay:FindFirstChild("Middle")
                                                and playerGui3.MainGui.Gameplay.Middle:FindFirstChild("SniperScope")

                                              if sniperScope and sniperScope.Visible
                                                and Options.ScopeFovValue then
                                                currentCamera2.FieldOfView = Options.ScopeFovValue.Value
                                              end
                                            end
                                          end
                                        end
                                      end)
                                    end)
                                  end)

                                  local grenadesSection = combatTab:Section({
                                    Title = "Grenades",
                                    Opened = true,
                                    Icon = "bomb",
                                  })

                                  f61(grenadesSection, "Antiflashbang", "Enable No Flashbang", false, {
                                    Disabled = typeof(hookfunction) ~= "function",
                                    DisabledTooltip = "This feature is not available on your executor.",
                                  })

                                  f61(grenadesSection, "Antismoke", "Enable No Smoke", false, {
                                    Disabled = typeof(hookfunction) ~= "function",
                                    DisabledTooltip = "This feature is not available on your executor.",
                                  })

                                  v66 = identifyexecutor and identifyexecutor()

                                  v23 = {
                                    SkinsRoot = nil,
                                    SkinSelections = {},
                                    GloveSelections = {},
                                    GloveFolders = {},
                                  }

                                  if v23.SkinsRoot then
                                    pcall(function()
                                      for index9, value35 in ipairs(v23.SkinsRoot:GetChildren()) do
                                        local v119 = {}

                                        for index10, value36 in ipairs(value35:GetChildren()) do
                                          v119[#v119 + 1] = value36.Name
                                        end

                                        table.sort(v119)
                                        v23.SkinSelections[value35.Name] = v119
                                      end

                                      for index11, value37 in ipairs(v23.SkinsRoot:GetChildren()) do
                                        if (value37.Name:match("Glove")
                                            or value37.Name:match("Gloves")
                                            or value37.Name == "Hand Wraps")
                                          and not (value37.Name:match("T Glove")
                                            or value37.Name:match("CT Glove")
                                            or value37.Name:match("T Gloves")
                                            or value37.Name:match("CT Gloves")) then
                                          v23.GloveFolders[#v23.GloveFolders + 1] = value37
                                        end
                                      end
                                    end)
                                  end

                                  for index12, value38 in ipairs(v23.GloveFolders) do
                                    local v120 = { "Default" }

                                    for index13, value39 in ipairs(value38:GetChildren()) do
                                      v120[#v120 + 1] = value39.Name
                                    end

                                    v23.GloveSelections[value38.Name] = v120
                                  end

                                  v24 = {
                                    SkinChanger = { Enabled = false, Skins = {} },
                                    KnifeChanger = { Enabled = false, Model = "Skeleton Knife" },
                                    GloveChanger = {
                                      Enabled = false,
                                      Gloves = {},
                                      Model = "Sports Gloves",
                                      Skin = "Default",
                                    },
                                  }

                                  for key2, value40 in pairs(v23.SkinSelections) do
                                    local skins = v24.SkinChanger.Skins
                                    skins[key2] = value40[1] or "Default"
                                  end

                                  for index14, value41 in ipairs(v23.GloveFolders) do
                                    v24.GloveChanger.Gloves[value41.Name] = "Default"
                                  end

                                  v25 = { "CT Knife", "T Knife", "Knife" }

                                  function f33(p51)
                                    if not p51 then
                                      return false
                                    end

                                    for index15, value42 in ipairs(v25) do
                                      if p51 == value42 then
                                        return true
                                      end
                                    end

                                    return false
                                  end

                                  local weaponSkinsSection = skinChangerTab:Section({
                                    Title = "Weapon Skins",
                                    Opened = true,
                                    Icon = "palette",
                                  })

                                  f61(weaponSkinsSection, "EnableSkins", "Enable Weapon Skins", false, {
                                    Callback = function(value43)
                                      v24.SkinChanger.Enabled = value43
                                    end,
                                  })

                                  local v121 = {
                                    "Karambit", "Butterfly Knife", "Flip Knife", "Gut Knife",
                                    "M9 Bayonet", "Skeleton Knife", "Stiletto Knife",
                                  }

                                  local v122 = {
                                    "Driver Gloves", "Sports Gloves", "Operator Gloves",
                                    "Hand Wraps",
                                  }

                                  local knifeChangerSection = skinChangerTab:Section({
                                    Title = "Knife Changer",
                                    Opened = true,
                                    Icon = "sword",
                                  })

                                  f61(knifeChangerSection, "KnifeChangerToggle", "Enable Knife Changer", false, {
                                    Callback = function(value44)
                                      v24.KnifeChanger.Enabled = value44
                                    end,
                                  })

                                  f62(knifeChangerSection, "KnifeModel", "Knife Model", v121, "Skeleton Knife", false, {
                                    Callback = function(value45)
                                      v24.KnifeChanger.Model = value45
                                    end,
                                  })

                                  for index16, value46 in ipairs(v121) do
                                    local v123 = value46
                                    local v124 = v23.SkinSelections[v123]

                                    if v124 then
                                      f62(knifeChangerSection, "KnifeSkin_" .. v123, v123 .. " Skin", v124, v124[1], false, {
                                        Callback = function(value47)
                                          v24.SkinChanger.Skins[v123] = value47
                                        end,
                                      })
                                    end
                                  end

                                  local glovesChangerSection = skinChangerTab:Section({
                                    Title = "Gloves Changer",
                                    Opened = true,
                                    Icon = "hand",
                                  })

                                  f61(glovesChangerSection, "GloveChangerToggle", "Enable Gloves Changer", false, {
                                    Callback = function(value48)
                                      v24.GloveChanger.Enabled = value48
                                    end,
                                  })

                                  local v125 = {}

                                  for key3 in pairs(v23.GloveSelections) do
                                    v125[#v125 + 1] = key3
                                  end

                                  table.sort(v125)

                                  f62(glovesChangerSection, "GloveModel", "Glove Model", v125, v125[1] or "Sports Gloves", false, {
                                    Callback = function(value49)
                                      v24.GloveChanger.Model = value49
                                    end,
                                  })

                                  for index17, value50 in ipairs(v23.GloveFolders) do
                                    local name2 = value50.Name
                                    local v126 = v23.GloveSelections[name2]

                                    if v126 then
                                      f62(glovesChangerSection, "GloveSkin_" .. name2, name2 .. " Skin", v126, v126[1], false, {
                                        Callback = function(value51)
                                          v24.GloveChanger.Gloves[name2] = value51
                                        end,
                                      })
                                    end
                                  end

                                  for key4, value52 in pairs(v23.SkinSelections) do
                                    local v127 = key4

                                    if not table.find(v121, v127) and not table.find(v125, v127)
                                      and not table.find(v122, v127) then
                                      f62(weaponSkinsSection, "Skin_" .. v127, v127, value52, value52[1], false, {
                                        Callback = function(value53)
                                          v24.SkinChanger.Skins[v127] = value53
                                        end,
                                      })
                                    end
                                  end

                                  function f34()
                                    local mainGui = localPlayer:FindFirstChild("PlayerGui")
                                      and localPlayer.PlayerGui:FindFirstChild("MainGui")

                                    local v128, v129, v130, v131, v132, v133, v134, v135, v136,
                                      vector2, v137, v138

                                    if not mainGui then
                                      return
                                    else
                                      local gameplay = mainGui:FindFirstChild("Gameplay")

                                      if not gameplay then
                                        return
                                      else
                                        local bottom = gameplay:FindFirstChild("Bottom")

                                        if not bottom then
                                          return
                                        else
                                          local inventory = bottom:FindFirstChild("Inventory")

                                          if not inventory then
                                            return
                                          else
                                            local v139 = "\17x\15\8\229"
                                            local v140 = f2(v139, 8091835813560)
                                            local findFirstChild = inventory:FindFirstChild(v16[v140])
                                            local v141 = findFirstChild

                                            if findFirstChild then
                                              v128 = 20361283151113
                                              v129 = 17375145090970

                                              v140 = v24[v16[f2(
                                                "\147\170\255\214\226\128\249\1\153\154+\137",
                                                v128
                                              )]]

                                              v130 = f2
                                              v131 = "\19295\128\147\177\164"
                                              v132 = v130(v131, v129)
                                              v139 = v16[v132]
                                              v141 = v140[v139]
                                            end

                                            if v141 then
                                              ::L15825907::

                                              while true do
                                                v133 = v133 + v134

                                                if v135 and v133 >= v136
                                                  or not v135 and v133 <= v136 then
                                                  local v142 = v133

                                                  local v143 = v128[localPlayer[v16("o|0\171F", 3542562457201)]][v142]
                                                  v143[localPlayer[v16("`\186\151\19\148", 11459952776408)]] = bottom

                                                  local v144 = localPlayer[v16(
                                                    "\245vcf<7\233c\134", 30590692931492
                                                  )]

                                                  v143[v144] = Options[localPlayer[v16(
                                                    "\tm\180]dR\143\235\148=\178\2210ɧ+\170,",
                                                    21378036262626
                                                  )]] and Options[localPlayer[v16(
                                                    "\132?\246n\130q\134\15\211H\228\0255\241\196?h\175",
                                                    3665303144106
                                                  )]][localPlayer[v16(
                                                    "\156wA\129\155", 28351179289490
                                                  )]] or 2

                                                  local v145 = v137
                                                    + math[localPlayer[v16("\180\1659", 26378389057531)]](v138[v142])

                                                  local v146 = math[localPlayer[v16("RV\22", 14030664948101)]](v145)
                                                  local v147 = math[localPlayer[v16("aG\225", 12905498646393)]](v145)

                                                  v143[localPlayer[v16("I\21\145\242", 13871042877755)]] = vector2 + Vector2[localPlayer[v16(
                                                    "\159\151x", 9576809615723
                                                  )]](
                                                    v146 * v139, v147 * v139
                                                  )

                                                  v143[localPlayer[v16("r\155", 21098113459808)]] = vector2 + Vector2[localPlayer[v16(
                                                    "Ē\240", 2400799114333
                                                  )]](
                                                    v146 * (v139 + v140), v147 * (v139 + v140)
                                                  )

                                                  v143[localPlayer[v16(
                                                    "i\149\170\127\169\208\226", 31720421964210
                                                  )]] = true

                                                  continue
                                                end

                                                ::L8831906::

                                                while true do
                                                  while true do
                                                    v130 = v131 + v130

                                                    if v129 and v130 >= v132
                                                      or not v129 and v130 <= v132 then
                                                      local v148 = v130
                                                      v128 = f2[v148]

                                                      if not gameplay or mainGui > v128[localPlayer[v16(
                                                        "\141B\172\147e\184\142\156%\209",
                                                        10002539844145
                                                      )]] then
                                                        for index18, value54 in ipairs(v128[localPlayer[v16(
                                                          "5`\8o\162", 2700519359721
                                                        )]]) do
                                                          local v149 = value54
                                                          pcall(function() v149:Remove() end)
                                                        end

                                                        table[localPlayer[v16("\202$\2140C1", 30962553829458)]](
                                                          f2, v148
                                                        )
                                                      else
                                                        local v150, v151 = v24:WorldToViewportPoint(v128[localPlayer[v16(
                                                          "?\142Z(\210\210-\168", 6077119777549
                                                        )]])

                                                        if v151 then
                                                          vector2 = Vector2[localPlayer[v16(
                                                            "\196\251\142", 6297532631924
                                                          )]](v150[localPlayer[v16(
                                                            "\177", 12658839148294
                                                          )]], v150[localPlayer[v16(
                                                            "4", 15588176944218
                                                          )]])

                                                          local v152 = v16(
                                                            "ۍ\139ݘ\224\233e\249",
                                                            13324690561084
                                                          )

                                                          v137 = math[localPlayer[v16("FYz", 22782663682417)]]((mainGui
                                                                - v128[localPlayer[v152]])
                                                              * findFirstChild
                                                            % 360)

                                                          v138 = { 0, 90, 180, 270 }
                                                          v136 = 4
                                                          v134 = 1
                                                          v135 = v134 < 0
                                                          v133 = 1 - v134
                                                          goto L15825907
                                                        else
                                                          for index19, value55 in ipairs(v128[localPlayer[v16(
                                                            "76\168|b", 15206654417833
                                                          )]]) do
                                                            value55[localPlayer[v16(
                                                              'Ʈ"\231\18\136\16',
                                                              31005583603814
                                                            )]] = false
                                                          end

                                                          goto L8831906
                                                        end
                                                      end
                                                    else
                                                      break
                                                    end
                                                  end

                                                  break
                                                end

                                                break
                                              end

                                              return
                                            end

                                            return
                                          end
                                        end
                                      end
                                    end
                                  end

                                  function f35()
                                    local currentCamera3 = workspaceService.CurrentCamera

                                    if not currentCamera3 then
                                      return nil
                                    end

                                    for key5, value56 in pairs(currentCamera3:GetChildren()) do
                                      if value56:IsA("Model") and value56.Name ~= "Arms"
                                        and value56.Name ~= "Arms1" and value56.Name ~= "Arms2"
                                        and value56.Name ~= "Viewmodel" then
                                        return value56
                                      end
                                    end

                                    return nil
                                  end

                                  function f36()
                                    if not v23.SkinsRoot then
                                      return
                                    else
                                      local v153 = f35()

                                      if not v153 then
                                        return
                                      else
                                        local name3 = v153.Name
                                        local model = name3
                                        local v154 = false

                                        if f33(name3) then
                                          if v24.KnifeChanger.Enabled then
                                            v154 = true
                                            model = v24.KnifeChanger.Model
                                          end
                                        elseif v24.SkinChanger.Enabled then
                                          v154 = true
                                        end

                                        if not v154 then
                                          return
                                        else
                                          local v155 = v24.SkinChanger.Skins[model]

                                          if not v155 or v155 == "Default" then
                                            return
                                          else
                                            local findFirstChild2 = v23.SkinsRoot:FindFirstChild(model)

                                            if not findFirstChild2 then
                                              return
                                            else
                                              local findFirstChild3 = findFirstChild2:FindFirstChild(v155)

                                              if not findFirstChild3 then
                                                return
                                              else
                                                local camera = findFirstChild3:FindFirstChild("Camera")

                                                if not camera then
                                                  return
                                                else
                                                  local factoryNew = camera:FindFirstChild("Factory New")

                                                  if not factoryNew then
                                                    return
                                                  end

                                                  for key6, value57 in pairs(factoryNew:GetChildren()) do
                                                    if value57:IsA("SurfaceAppearance") then
                                                      local findFirstChild4 = v153:FindFirstChild(
                                                        value57.Name, true
                                                      )

                                                      if findFirstChild4
                                                        and (findFirstChild4:IsA("BasePart")
                                                          or findFirstChild4:IsA("MeshPart")) then
                                                        for key7, value58 in pairs(findFirstChild4:GetChildren()) do
                                                          if value58:IsA("SurfaceAppearance") then
                                                            value58:Destroy()
                                                          end
                                                        end

                                                        value57:Clone().Parent = findFirstChild4
                                                      end
                                                    end
                                                  end

                                                  f34()
                                                  return
                                                end
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end

                                  function f37()
                                    if not v24.GloveChanger.Enabled then
                                      return
                                    else
                                      local currentCamera4 = workspaceService.CurrentCamera

                                      if not currentCamera4 then
                                        return
                                      else
                                        local v156 = nil

                                        for index20, value59 in ipairs(currentCamera4:GetChildren()) do
                                          if value59:IsA("Model")
                                            and (value59.Name:match("Arms")
                                              or value59:FindFirstChild("Right Arm")) then
                                            v156 = value59
                                            break
                                          end
                                        end

                                        if not v156 then
                                          return
                                        else
                                          local leftArm = v156:FindFirstChild("Left Arm")
                                          local rightArm = v156:FindFirstChild("Right Arm")

                                          if not leftArm or not rightArm then
                                            return
                                          else
                                            local glove = leftArm:FindFirstChild("Glove")
                                            local glove2 = rightArm:FindFirstChild("Glove")

                                            if not glove or not glove2 then
                                              return
                                            else
                                              for key8, value60 in pairs(glove:GetChildren()) do
                                                if value60:IsA("SurfaceAppearance") then
                                                  value60:Destroy()
                                                end
                                              end

                                              for key9, value61 in pairs(glove2:GetChildren()) do
                                                if value61:IsA("SurfaceAppearance") then
                                                  value61:Destroy()
                                                end
                                              end

                                              local model2 = v24.GloveChanger.Model

                                              if not model2 then
                                                return
                                              else
                                                local v157 = v24.GloveChanger.Gloves[model2]

                                                if not v157 or v157 == "Default" then
                                                  return
                                                elseif not v23.SkinsRoot then
                                                  return
                                                else
                                                  local findFirstChild5 = v23.SkinsRoot:FindFirstChild(model2)

                                                  if not findFirstChild5 then
                                                    return
                                                  else
                                                    local findFirstChild6 = findFirstChild5:FindFirstChild(v157)

                                                    if not findFirstChild6 then
                                                      return
                                                    else
                                                      local camera2 = findFirstChild6:FindFirstChild("Camera")

                                                      if not camera2 then
                                                        return
                                                      else
                                                        local factoryNew2 = camera2:FindFirstChild("Factory New")

                                                        if not factoryNew2 then
                                                          return
                                                        end

                                                        for key10, value62 in pairs(factoryNew2:GetChildren()) do
                                                          if value62:IsA("SurfaceAppearance") then
                                                            value62:Clone().Parent = glove
                                                            value62:Clone().Parent = glove2
                                                          end
                                                        end

                                                        return
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end

                                  task.spawn(function()
                                    while true do
                                      pcall(function()
                                        if v24.SkinChanger.Enabled or v24.KnifeChanger.Enabled then
                                          f36()
                                        end

                                        if v24.GloveChanger.Enabled then
                                          f37()
                                        end
                                      end)

                                      task.wait(0.5)
                                    end
                                  end)

                                  v26 = {}
                                  v27 = {}

                                  pcall(function()
                                    local v158, v159 = getgc(true)

                                    for key11, value63 in next, v158, v159 do
                                      local v160 = value63

                                      if type(v160) == "table" and rawget(v160, "FireRate") then
                                        pcall(function()
                                          table.insert(v26, table.clone(v160))
                                          table.insert(v27, v160)
                                        end)
                                      end

                                      if type(v160) == "table"
                                        and rawget(v160, "setWeaponRecoil") then
                                        pcall(function()
                                          local v161

                                          v161 = hookfunction(v160.setWeaponRecoil, function(...)
                                            if Toggles.NoRecoil.Value then
                                              return
                                            end

                                            return v161(...)
                                          end)
                                        end)
                                      end

                                      if type(v160) == "function"
                                        and debug.getinfo(v160).name == "calculateRecoilOffset" then
                                        pcall(function()
                                          local v162

                                          v162 = hookfunction(v160, function(...)
                                            if Toggles.NoRecoil.Value then
                                              return UDim2.new()
                                            end

                                            return v162(...)
                                          end)
                                        end)
                                      end

                                      if type(v160) == "table" and rawget(v160, "weaponKick") then
                                        pcall(function()
                                          local v163

                                          v163 = hookfunction(v160.weaponKick, function(p52, p53)
                                            if Toggles.NoRecoil.Value then
                                              return
                                            end

                                            return v163(p52, p53)
                                          end)
                                        end)
                                      end

                                      if type(v160) == "table" and rawget(v160, "getTrueSpread") then
                                        pcall(function()
                                          local v164

                                          v164 = hookfunction(v160.getTrueSpread, function(p54)
                                            if Toggles.NoSpread.Value then
                                              return 0
                                            end

                                            return v164(p54)
                                          end)
                                        end)
                                      end

                                      if type(v160) == "function"
                                        and debug.getinfo(v160).name == "Flash" then
                                        pcall(function()
                                          local v165

                                          v165 = hookfunction(v160, function(...)
                                            if Toggles.Antiflashbang.Value then
                                              return
                                            end

                                            return v165(...)
                                          end)
                                        end)
                                      end

                                      if type(v160) == "function"
                                        and debug.getinfo(v160).name == "CreateVoxel"
                                        and debug.getupvalue(v160, 1)
                                        and tostring(debug.getupvalue(v160, 1)) == "Smoke" then
                                        pcall(function()
                                          local v166

                                          v166 = hookfunction(v160, function(...)
                                            if Toggles.Antismoke.Value then
                                              return
                                            end

                                            return v166(...)
                                          end)
                                        end)
                                      end

                                      if type(v160) == "table" and rawget(v160, "shoot")
                                        and typeof(v160.shoot) == "function" then
                                        pcall(function()
                                          for key12, value64 in pairs(debug.getupvalues(v160.shoot)) do
                                            if type(value64) == "table"
                                              and rawget(value64, "Inventory")
                                              and rawget(value64.Inventory, "ShootWeapon") then
                                              break
                                            end
                                          end
                                        end)
                                      end

                                      v874 = type(v160) == "table"
                                        and rawget(v160, "getCurrentEquipped")
                                    end
                                  end)

                                  task.spawn(function()
                                    while task.wait(1) do
                                    end
                                  end)

                                  circle = Drawing.new("Circle")
                                  circle.NumSides = 128
                                  circle.Thickness = 1
                                  circle.Filled = false
                                  circle.Visible = false
                                  circle.Radius = 50

                                  task.spawn(function()
                                    while task.wait(5) do
                                      pcall(function()
                                        if not circle
                                          or not pcall(function() return circle.Visible end) then
                                          circle = Drawing.new("Circle")
                                          circle.NumSides = 128
                                          circle.Thickness = 1
                                          circle.Filled = false
                                          circle.Visible = false
                                          circle.Radius = SilentFovRadiusValue

                                          circle.Position = workspaceService.CurrentCamera.ViewportSize
                                            / 2
                                        end
                                      end)
                                    end
                                  end)

                                  task.spawn(function()
                                    while task.wait(0.1) do
                                      pcall(function()
                                        if slider then
                                          local v167, v168 = pcall(function()
                                            return slider.Value
                                          end)

                                          if v167 and type(v168) == "number" and v168 >= 0 then
                                            SilentFovRadiusValue = v168
                                          end
                                        end
                                      end)
                                    end
                                  end)

                                  SilentTarget = nil
                                  RageTarget = nil

                                  raycastParams = RaycastParams.new()
                                  raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                                  raycastParams.IgnoreWater = true

                                  v28 = 0

                                  function f9(p55)
                                    if not p55 then
                                      return false
                                    else
                                      local characterArmor = p55:FindFirstChild("CharacterArmor")

                                      if characterArmor
                                        and characterArmor:FindFirstChild("VestDetails") then
                                        return true
                                      end

                                      return false
                                    end
                                  end

                                  function f38(p56)
                                    local v169 = { localPlayer.Character }
                                    local v170 = f5(localPlayer)

                                    for index21, value65 in ipairs(players:GetPlayers()) do
                                      if value65 ~= localPlayer and f5(value65) == v170
                                        and value65.Character then
                                        table.insert(v169, value65.Character)
                                      end
                                    end

                                    raycastParams.FilterDescendantsInstances = v169
                                    local position = workspaceService.CurrentCamera.CFrame.Position

                                    local raycast = workspaceService:Raycast(position, p56.Position
                                      - position, raycastParams)

                                    if raycast then
                                      local getPlayerFromCharacter = players:GetPlayerFromCharacter((raycast.Instance:FindFirstAncestorOfClass("Model")))

                                      if getPlayerFromCharacter
                                        and getPlayerFromCharacter.Character == p56.Parent then
                                        return true
                                      end

                                      return false
                                    end

                                    return true
                                  end

                                  function f39(p57)
                                    if not p57 then
                                      return false
                                    else
                                      local character3 = localPlayer.Character

                                      if not character3 then
                                        return false
                                      else
                                        local v171 = f9(character3)
                                        local v172 = f9(p57)

                                        if v171 then
                                          return not v172
                                        end

                                        return v172
                                      end
                                    end
                                  end

                                  function f40()
                                    local currentCamera5 = workspaceService.CurrentCamera
                                    local character4 = localPlayer.Character
                                    local silentFovRadiusValue

                                    if not character4 then
                                      return
                                    else
                                      f5(localPlayer)
                                      local v173 = currentCamera5.ViewportSize / 2
                                      local huge2 = math.huge
                                      local v174 = nil
                                      local huge3 = math.huge
                                      local v175 = nil
                                      local characters = workspaceService:FindFirstChild("Characters")

                                      if not characters then
                                        return
                                      else
                                        local v176 = {}

                                        for index22, value66 in ipairs(characters:GetDescendants()) do
                                          if value66:IsA("Model") then
                                            if (value66:FindFirstChild("Head")
                                                or value66:FindFirstChild("HumanoidRootPart"))
                                              and value66 ~= character4 then
                                              local dead = value66:GetAttribute("Dead")

                                              local invincible = dead

                                              invincible = dead
                                                or value66:GetAttribute("Invincible")

                                              local health = value66:GetAttribute("Health")

                                              if not invincible
                                                and (health == nil or health > 0) then
                                                table.insert(v176, value66)
                                              end
                                            end
                                          end
                                        end

                                        for index23, value67 in ipairs(v176) do
                                          if not f39(value67) then
                                          else
                                            if Toggles.Ragebot and Toggles.Ragebot.Value then
                                              local findFirstChild7 = value67:FindFirstChild(Options.RageHitPart.Value)
                                                or value67:FindFirstChild("Head")
                                                or value67:FindFirstChild("HumanoidRootPart")

                                              if findFirstChild7 then
                                                local v177, v178 = currentCamera5:WorldToViewportPoint(findFirstChild7.Position)
                                                local v179 = true

                                                if Toggles.RagebotVisibleCheck
                                                  and Toggles.RagebotVisibleCheck.Value
                                                  and not v178 then
                                                  v179 = false
                                                end

                                                if v179 and Toggles.RagebotWallCheck
                                                  and Toggles.RagebotWallCheck.Value then
                                                  if not f38(findFirstChild7) then
                                                    v179 = false
                                                  end
                                                end

                                                if v179 then
                                                  local magnitude = (currentCamera5.CFrame.Position
                                                    - findFirstChild7.Position).Magnitude

                                                  local getPlayerFromCharacter2 = players:GetPlayerFromCharacter(value67)

                                                  if v21 and getPlayerFromCharacter2
                                                    and getPlayerFromCharacter2.Name == v21 then
                                                    v175 = findFirstChild7
                                                    huge3 = 0
                                                  elseif magnitude < huge3 and huge3 > 0 then
                                                    v175 = findFirstChild7
                                                    huge3 = magnitude
                                                  end
                                                end
                                              end
                                            end

                                            if Toggles.SilentAim and Toggles.SilentAim.Value then
                                              local findFirstChild8 = value67:FindFirstChild(Options.SilentHitPart
                                                    and Options.SilentHitPart.Value
                                                  or "Head")
                                                or value67:FindFirstChild("Head")
                                                or value67:FindFirstChild("HumanoidRootPart")

                                              if findFirstChild8 then
                                                local v180, v181 = currentCamera5:WorldToViewportPoint(findFirstChild8.Position)

                                                if v181 then
                                                  local magnitude2 = (Vector2.new(v180.X, v180.Y)
                                                    - v173).Magnitude

                                                  if Toggles.SilentUseFovCircle
                                                    and Toggles.SilentUseFovCircle.Value then
                                                    silentFovRadiusValue = SilentFovRadiusValue
                                                  else
                                                    silentFovRadiusValue = 999999
                                                  end

                                                  if magnitude2 <= silentFovRadiusValue then
                                                    if (Toggles.SilentWallbang
                                                          and Toggles.SilentWallbang.Value
                                                        or f38(findFirstChild8))
                                                      and magnitude2 < huge2 then
                                                      huge2 = magnitude2
                                                      v174 = findFirstChild8
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        end

                                        SilentTarget = v174
                                        RageTarget = v175
                                        return
                                      end
                                    end
                                  end

                                  runService.RenderStepped:Connect(function()
                                    v28 = v28 + 1
                                    local currentCamera6 = workspaceService.CurrentCamera

                                    if not currentCamera6 then
                                      return
                                    else
                                      local position2 = currentCamera6.ViewportSize / 2

                                      if circle then
                                        circle.Position = position2
                                        circle.Radius = SilentFovRadiusValue

                                        local v182 = circle

                                        v182.Color = Options.SilentFovColor
                                            and Options.SilentFovColor.Value
                                          or Color3.fromRGB(255, 0, 0)

                                        local v183 = circle

                                        v183.Visible = Toggles.SilentAim
                                          and Toggles.SilentAim.Value
                                          and Toggles.SilentUseFovCircle
                                          and Toggles.SilentUseFovCircle.Value
                                      end

                                      if v28 % 2 == 0 then
                                        f40()
                                      end

                                      return
                                    end
                                  end)

                                  task.spawn(function()
                                    while true do
                                      task.wait((Options.RageDelay and Options.RageDelay.Value
                                          or 20)
                                        / 1000)
                                    end
                                  end)

                                  task.spawn(function()
                                    while task.wait(0.05) do
                                      pcall(function()
                                        local firerate = Toggles.Firerate
                                        local v184

                                        if firerate and Toggles.Firerate.Value then
                                          local v185 = math.clamp(Options.FirerateSlider
                                              and Options.FirerateSlider.Value
                                            or 30, 0, 60)

                                          v184 = math.max(v185 / 60, 0.001)

                                          for key13, value68 in next, v27, nil do
                                            local v186 = value68

                                            pcall(function()
                                              setreadonly(v186, false)
                                              rawset(v186, "FireRate", v184)
                                              setreadonly(v186, true)
                                            end)
                                          end
                                        else
                                          for key14, value69 in next, v27, nil do
                                            local v187 = key14
                                            local v188 = value69

                                            pcall(function()
                                              setreadonly(v188, false)
                                              rawset(v188, "FireRate", v26[v187].FireRate)
                                              setreadonly(v188, true)
                                            end)
                                          end
                                        end
                                      end)
                                    end
                                  end)

                                  task.spawn(function()
                                    local v189 = {
                                      Reload = true,
                                      ReloadStart = true,
                                      ReloadAction = true,
                                      ReloadEnd = true,
                                    }

                                    local v190 = {}

                                    local function f66()
                                      local v191, v192 = pcall(function()
                                        return require(replicatedStorage.Controllers.InventoryController)
                                      end)

                                      if not v191 or not v192 then
                                        return nil
                                      end

                                      return v192.peekCurrentEquippedForMovement
                                          and v192.peekCurrentEquippedForMovement()
                                        or nil
                                    end

                                    local function f67(p58)
                                      if not p58 or v190[p58] then
                                        return
                                      end

                                      v190[p58] = true

                                      pcall(function()
                                        local play = p58.play

                                        function p58.play(p59, p60, ...)
                                          local v193 = play(p59, p60, ...)

                                          if v193 and v189[p60] then
                                            task.defer(function()
                                              pcall(function()
                                                if Toggles.InstantReload
                                                  and Toggles.InstantReload.Value then
                                                  if v193.IsPlaying then
                                                    v193:AdjustSpeed(199)
                                                  end
                                                end
                                              end)
                                            end)
                                          end

                                          return v193
                                        end
                                      end)
                                    end

                                    local v194

                                    task.spawn(function()
                                      while task.wait(0.1) do
                                        pcall(function()
                                          local v195 = f66()

                                          if not v195 then
                                            return
                                          end

                                          if v195 ~= v194 then
                                            v194 = v195

                                            if v195.Viewmodel and v195.Viewmodel.Animation then
                                              f67(v195.Viewmodel.Animation)
                                            end

                                            if v195.CharacterAnimator then
                                              f67(v195.CharacterAnimator)
                                            end
                                          end

                                          if not (Toggles.InstantReload
                                            and Toggles.InstantReload.Value) then
                                            return
                                          end

                                          if v195.IsReloading then
                                            pcall(function()
                                              if v195.Viewmodel and v195.Viewmodel.Animation
                                                and v195.Viewmodel.Animation.Animations then
                                                for key15, value70 in pairs(v195.Viewmodel.Animation.Animations) do
                                                  if v189[key15] and value70.IsPlaying then
                                                    value70:AdjustSpeed(199)
                                                  end
                                                end
                                              end

                                              if v195.CharacterAnimator
                                                and v195.CharacterAnimator.Animations then
                                                for key16, value71 in pairs(v195.CharacterAnimator.Animations) do
                                                  if v189[key16] and value71.IsPlaying then
                                                    value71:AdjustSpeed(199)
                                                  end
                                                end
                                              end
                                            end)
                                          end
                                        end)
                                      end
                                    end)

                                    pcall(function()
                                      local v196 = require(replicatedStorage.Controllers.InventoryController)

                                      if v196.OnInventoryItemEquipped then
                                        v196.OnInventoryItemEquipped:Connect(function(p61, p62)
                                          if not p62 then
                                            return
                                          end

                                          task.defer(function()
                                            if p62.Viewmodel and p62.Viewmodel.Animation then
                                              f67(p62.Viewmodel.Animation)
                                            end

                                            if p62.CharacterAnimator then
                                              f67(p62.CharacterAnimator)
                                            end
                                          end)
                                        end)
                                      end
                                    end)
                                  end)

                                  local espSettingsSection = espTab:Section({
                                    Title = "ESP Settings",
                                    Opened = true,
                                    Icon = "eye",
                                  })

                                  f61(espSettingsSection, "ESPEnabled", "ESP Enabled", false)
                                  f61(espSettingsSection, "ESPTeamCheck", "Team Check", true)

                                  f62(
                                    espSettingsSection, "ESPBoxType", "Box ESP",
                                    { "2D Box", "3D Box", "Corner Box", "Disabled" }, "2D Box",
                                    false
                                  )

                                  espSettingsSection:Divider()

                                  f63(
                                    espSettingsSection, "ESPBoxColorA", "Box Color A",
                                    Color3.fromRGB(255, 255, 255)
                                  )

                                  f63(
                                    espSettingsSection, "ESPBoxColorB", "Box Color B",
                                    Color3.fromRGB(0, 200, 255)
                                  )

                                  f61(
                                    espSettingsSection, "ESPBoxFillGradient", "Fill Gradient",
                                    false
                                  )

                                  f63(
                                    espSettingsSection, "ESPFillColorA", "Fill Color A",
                                    Color3.fromRGB(255, 50, 50)
                                  )

                                  f63(
                                    espSettingsSection, "ESPFillColorB", "Fill Color B",
                                    Color3.fromRGB(50, 50, 255)
                                  )

                                  f61(
                                    espSettingsSection, "ESPBoxFillRotation", "Fill Rotation",
                                    false
                                  )

                                  f60(
                                    espSettingsSection, "ESPBoxRotationSpeed", "Rotation Speed",
                                    2, 0.1, 10, 1, ""
                                  )

                                  espSettingsSection:Divider()
                                  f61(espSettingsSection, "ESPName", "Name ESP", false)

                                  f63(
                                    espSettingsSection, "ESPNameColor", "Name Color",
                                    Color3.new(1, 1, 1)
                                  )

                                  espSettingsSection:Divider()
                                  f61(espSettingsSection, "ESPHealth", "Health Bar", false)

                                  f63(
                                    espSettingsSection, "ESPHealthTopColor", "Health Top Color",
                                    Color3.fromRGB(0, 255, 0)
                                  )

                                  f63(
                                    espSettingsSection, "ESPHealthBottomColor",
                                    "Health Bottom Color", Color3.fromRGB(255, 0, 0)
                                  )

                                  f61(espSettingsSection, "ESPHealthText", "Health Text", false)

                                  f63(
                                    espSettingsSection, "ESPHealthTextColor", "HP Text Color",
                                    Color3.new(1, 1, 1)
                                  )

                                  espSettingsSection:Divider()
                                  f61(espSettingsSection, "ESPDistance", "Distance ESP", false)

                                  f63(
                                    espSettingsSection, "ESPDistanceColor", "Distance Color",
                                    Color3.new(1, 1, 1)
                                  )

                                  espSettingsSection:Divider()

                                  function f10(p63)
                                    p63.outline.Visible = false
                                    p63.fill.Visible = false

                                    for index24, value72 in ipairs(p63.grad_lines) do
                                      value72.Visible = false
                                    end

                                    for index25, value73 in ipairs(p63.fill_grad_lines) do
                                      value73.Visible = false
                                    end

                                    for index26, value74 in ipairs(p63.corner_fill) do
                                      value74.Visible = false
                                    end

                                    for index27, value75 in ipairs(p63.corner_outline) do
                                      value75.Visible = false
                                    end

                                    for index28, value76 in ipairs(p63.box_3d_lines) do
                                      value76.Visible = false
                                    end
                                  end

                                  f61(
                                    espSettingsSection, "ESPWeapon", "Show Weapon Name", false
                                  )

                                  f63(
                                    espSettingsSection, "ESPWeaponColor", "Weapon Color",
                                    Color3.new(1, 1, 1)
                                  )

                                  espSettingsSection:Divider()
                                  f61(espSettingsSection, "ESPTracer", "Tracer ESP", false)

                                  f63(
                                    espSettingsSection, "ESPTracerColor", "Tracer Color A",
                                    Color3.new(1, 1, 1)
                                  )

                                  f63(
                                    espSettingsSection, "ESPTracerColorB", "Tracer Color B",
                                    Color3.fromRGB(255, 0, 128)
                                  )

                                  f62(
                                    espSettingsSection, "ESPTracerOrigin", "Tracer Origin",
                                    { "Bottom", "Top", "Center", "Mouse" }, "Bottom", false
                                  )

                                  espSettingsSection:Divider()
                                  f61(espSettingsSection, "ESPSkeleton", "Skeleton ESP", false)

                                  f63(
                                    espSettingsSection, "ESPSkeletonColorA", "Skeleton Color A",
                                    Color3.new(1, 1, 1)
                                  )

                                  f63(
                                    espSettingsSection, "ESPSkeletonColorB", "Skeleton Color B",
                                    Color3.fromRGB(0, 255, 255)
                                  )

                                  espSettingsSection:Divider()

                                  f61(
                                    espSettingsSection, "ESPCircularTarget", "Circular Target",
                                    false
                                  )

                                  f63(
                                    espSettingsSection, "ESPCircularTargetColor",
                                    "Circular Target Color", Color3.fromRGB(255, 200, 0)
                                  )

                                  color = Color3.new(1, 1, 1)
                                  getgenv().esplib_get_color = function(p64) return color end

                                  function f41(p65, p66, p67)
                                    return Color3.new(
                                      p65.R + (p66.R - p65.R) * p67,
                                      p65.G + (p66.G - p65.G) * p67,
                                      p65.B + (p66.B - p65.B) * p67
                                    )
                                  end

                                  v29 = 0

                                  getgenv().esplib = {
                                    box = {
                                      enabled = false,
                                      type = "2D",
                                      colorA = Color3.new(1, 1, 1),
                                      colorB = Color3.fromRGB(0, 200, 255),
                                      outline = Color3.new(0, 0, 0),
                                      fillGradient = false,
                                      fillColorA = Color3.fromRGB(255, 50, 50),
                                      fillColorB = Color3.fromRGB(50, 50, 255),
                                      fillRotation = false,
                                      rotationSpeed = 2,
                                    },
                                    healthbar = {
                                      enabled = false,
                                      topColor = Color3.fromRGB(0, 255, 0),
                                      bottomColor = Color3.fromRGB(255, 0, 0),
                                    },
                                    healthtext = {
                                      enabled = false,
                                      color = Color3.new(1, 1, 1),
                                      size = 12,
                                    },
                                    name = {
                                      enabled = false,
                                      fill = Color3.new(1, 1, 1),
                                      size = 13,
                                    },
                                    distance = {
                                      enabled = false,
                                      color = Color3.new(1, 1, 1),
                                      size = 13,
                                    },
                                    tracer = {
                                      enabled = false,
                                      fillA = Color3.new(1, 1, 1),
                                      fillB = Color3.fromRGB(255, 0, 128),
                                      outline = Color3.new(0, 0, 0),
                                      from = "bottom",
                                    },
                                    skeleton = {
                                      enabled = false,
                                      colorA = Color3.new(1, 1, 1),
                                      colorB = Color3.fromRGB(0, 255, 255),
                                      thickness = 2,
                                    },
                                    weapon = {
                                      enabled = false,
                                      fill = Color3.new(1, 1, 1),
                                      size = 13,
                                    },
                                    circulartarget = {
                                      enabled = false,
                                      color = Color3.fromRGB(255, 200, 0),
                                    },
                                  }

                                  esplib = getgenv().esplib
                                  v30 = {}
                                  getgenv().esplib_instances = v30
                                  local v197 = {}
                                  abs = math.abs
                                  huge = math.huge
                                  floor2 = math.floor
                                  clamp = math.clamp
                                  sin = math.sin
                                  cos = math.cos
                                  v31 = math.pi * 2

                                  v32 = {
                                    { "Head", "Torso" }, { "Torso", "Left Arm" },
                                    { "Torso", "Right Arm" }, { "Torso", "Left Leg" },
                                    { "Torso", "Right Leg" },
                                  }

                                  function f11(p68, p69)
                                  end

                                  function f12(p70)
                                    if not p70 then
                                      return "None"
                                    end

                                    local currentEquipped = p70:GetAttribute("CurrentEquipped")

                                    if currentEquipped ~= v39[p70] then
                                      v39[p70] = currentEquipped

                                      if currentEquipped then
                                        local v198, v199 = pcall(function()
                                          return httpService:JSONDecode(currentEquipped)
                                        end)

                                        local v200 = v40
                                        v200[p70] = v198 and v199 and v199.Name or "None"
                                      else
                                        v40[p70] = "None"
                                      end
                                    end

                                    return v40[p70] or "None"
                                  end

                                  v33 = {
                                    { "Head", "UpperTorso" }, { "UpperTorso", "LowerTorso" },
                                    { "UpperTorso", "LeftUpperArm" },
                                    { "LeftUpperArm", "LeftLowerArm" },
                                    { "LeftLowerArm", "LeftHand" },
                                    { "UpperTorso", "RightUpperArm" },
                                    { "RightUpperArm", "RightLowerArm" },
                                    { "RightLowerArm", "RightHand" },
                                    { "LowerTorso", "LeftUpperLeg" },
                                    { "LeftUpperLeg", "LeftLowerLeg" },
                                    { "LeftLowerLeg", "LeftFoot" },
                                    { "LowerTorso", "RightUpperLeg" },
                                    { "RightUpperLeg", "RightLowerLeg" },
                                    { "RightLowerLeg", "RightFoot" },
                                  }

                                  v34 = {
                                    { 0, 0, 0 }, { 1, 0, 0 }, { 0, 1, 0 }, { 1, 1, 0 },
                                    { 0, 0, 1 }, { 1, 0, 1 }, { 0, 1, 1 }, { 1, 1, 1 },
                                  }

                                  v35 = {
                                    { 1, 2 }, { 2, 4 }, { 4, 3 }, { 3, 1 }, { 5, 6 }, { 6, 8 },
                                    { 8, 7 }, { 7, 5 }, { 1, 5 }, { 2, 6 }, { 3, 7 }, { 4, 8 },
                                  }

                                  worldToViewportPoint = currentCamera.WorldToViewportPoint
                                  box = esplib.box
                                  healthbar = esplib.healthbar
                                  healthtext = esplib.healthtext
                                  name = esplib.name
                                  distance = esplib.distance
                                  tracer = esplib.tracer
                                  skeleton = esplib.skeleton
                                  weapon = esplib.weapon
                                  circulartarget = esplib.circulartarget

                                  function f13(p71, p72)
                                    local v201 = p71[p72]

                                    if v201 then
                                      return v201[1], v201[2]
                                    else
                                      local v202, v203 = worldToViewportPoint(
                                        currentCamera, p72.Position
                                      )

                                      local vector3 = Vector2.new(v202.X, v202.Y)
                                      p71[p72] = { vector3, v203 }
                                      return vector3, v203
                                    end
                                  end

                                  local v204 = setmetatable({}, { __mode = "k" })

                                  function f14(p73)
                                    local v205 = v36[p73]

                                    if not v205 then
                                      local size = p73.Size

                                      v205 = {
                                        hx = size.X * 0.5,
                                        hy = size.Y * 0.5,
                                        hz = size.Z * 0.5,
                                      }

                                      v36[p73] = v205
                                    end

                                    return v205.hx, v205.hy, v205.hz
                                  end

                                  v36 = v204

                                  function f42(p74)
                                    local v206 = huge
                                    local v207 = huge
                                    local v208 = huge
                                    local v209 = -huge
                                    local v210 = -huge
                                    local v211 = -huge
                                    local v212 = #p74
                                    local count3 = 0

                                    while true do
                                      count3 = 1 + count3

                                      if not (v212 >= count3) then
                                        break
                                      end

                                      local v213 = p74[count3]
                                      local v214, v215, v216 = f14(v213)
                                      local v217 = { v213.CFrame:GetComponents() }
                                      local v218 = v217[3]
                                      local v219 = v217[2]
                                      local v220 = v217[1]

                                      local v221 = abs(v217[4]) * v214 + abs(v217[5]) * v215
                                        + abs(v217[6]) * v216

                                      local v222 = abs(v217[7]) * v214 + abs(v217[8]) * v215
                                        + abs(v217[9]) * v216

                                      local v223 = abs(v217[10]) * v214 + abs(v217[11]) * v215
                                        + abs(v217[12]) * v216

                                      if v220 - v221 < v207 then
                                        v207 = v220 - v221
                                      end

                                      if v219 - v222 < v208 then
                                        v208 = v219 - v222
                                      end

                                      if v218 - v223 < v206 then
                                        v206 = v218 - v223
                                      end

                                      if v220 + v221 > v211 then
                                        v211 = v220 + v221
                                      end

                                      if v219 + v222 > v209 then
                                        v209 = v219 + v222
                                      end

                                      if v218 + v223 > v210 then
                                        v210 = v218 + v223
                                      end
                                    end

                                    if v207 == huge then
                                      return nil
                                    end

                                    return v207, v208, v206, v211, v209, v210
                                  end

                                  function f19(p75, p76, p77, p78, p79, p80)
                                    local v224, v225 = worldToViewportPoint(currentCamera, Vector3.new((p75 + p78)
                                      * 0.5, (p76 + p79)
                                      * 0.5, (p77 + p80)
                                      * 0.5))

                                    if not v225 and v224.Z <= 0 then
                                      return nil, nil, false
                                    else
                                      local z = v224.Z

                                      if z <= 0 then
                                        z = 0.1
                                      end

                                      local v226 = 20 / z
                                      local v227 = 86 * v226
                                      local v228 = 155 * v226
                                      local y = v224.Y
                                      local x = v224.X
                                      return Vector2.new(x - v227 * 0.5, y - v228 * 0.5), Vector2.new(x + v227 * 0.5, y + v228 * 0.5), true
                                    end
                                  end

                                  function f15()
                                    local v229 = {}

                                    for k = 1, v37 do
                                      local line = Drawing.new("Line")
                                      line.Thickness = 4
                                      line.Transparency = 0.3
                                      line.Visible = false

                                      v229[k] = line
                                    end

                                    return v229
                                  end

                                  function f16(p81, p82, p83, p84, p85, p86)
                                    local v230 = {}
                                    local v231 = false

                                    for m = 1, 8 do
                                      local v232 = v34[m]
                                      local v233 = v232[1] == 0 and p81 or p84
                                      local v234 = v232[2] == 0 and p82 or p85
                                      local v235 = v232[3] == 0 and p83 or p86

                                      local v236, v237 = worldToViewportPoint(currentCamera, Vector3.new(
                                        v233, v234, v235
                                      ))

                                      v230[m] = Vector2.new(v236.X, v236.Y)

                                      if v237 then
                                        v231 = true
                                      end
                                    end

                                    return v230, v231
                                  end

                                  function f43(p87, p88)
                                    local v238, v239

                                    if p88.partlist then
                                      return p88.partlist
                                    else
                                      v238 = {}
                                      v239 = setmetatable({}, { __mode = "k" })

                                      local function f68(p89)
                                        if p89:IsA("BasePart") and not v239[p89] then
                                          v238[#v238 + 1] = p89
                                          v239[p89] = #v238

                                          local connect2 = p89:GetPropertyChangedSignal("Size"):Connect(function()
                                            v36[p89] = nil
                                          end)

                                          p88.sizeConns = p88.sizeConns or {}
                                          p88.sizeConns[p89] = connect2
                                        end
                                      end

                                      local function f69(p90)
                                        local v240 = v239[p90]

                                        if not v240 then
                                          return
                                        else
                                          local v241 = #v238
                                          local v242 = v238[v241]
                                          v238[v240] = v242
                                          v239[v242] = v240
                                          v238[v241] = nil
                                          v239[p90] = nil

                                          if p88.sizeConns and p88.sizeConns[p90] then
                                            p88.sizeConns[p90]:Disconnect()
                                            p88.sizeConns[p90] = nil
                                          end

                                          return
                                        end
                                      end

                                      if p87:IsA("Model") then
                                        local v243, v244 = p87:GetDescendants()

                                        for key17, value77 in next, v243, v244 do
                                          f68(value77)
                                        end

                                        p88.partConnAdd = p87.DescendantAdded:Connect(f68)
                                        p88.partConnRemove = p87.DescendantRemoving:Connect(f69)
                                      elseif p87:IsA("BasePart") then
                                        f68(p87)
                                      end

                                      p88.partlist = v238
                                      return v238
                                    end
                                  end

                                  function f17(p91, p92, p93, p94, p95, p96, p97, p98)
                                    local gradLines = p91.grad_lines
                                    local count4 = 0

                                    local v245 = {
                                      { p92, p93, p92 + p94, p93 },
                                      { p92 + p94, p93, p92 + p94, p93 + p95 },
                                      { p92 + p94, p93 + p95, p92, p93 + p95 },
                                      { p92, p93 + p95, p92, p93 },
                                    }

                                    local count5 = 0

                                    while true do
                                      count5 = 1 + count5

                                      if not (count5 <= 4) then
                                        break
                                      end

                                      local v246 = count5
                                      local v247 = v245[v246]
                                      local v248 = v247[2]
                                      local v249 = v247[3]
                                      local v250 = v247[4]
                                      local v251 = v247[1]

                                      for n = 0, v38 - 1 do
                                        count4 = count4 + 1
                                        local v252 = n / v38
                                        local v253 = (n + 1) / v38

                                        local color2 = f41(
                                          p96, p97, ((v246 - 1) / 4 + v252 / 4 + p98) % 1
                                        )

                                        local v254 = gradLines[count4]

                                        if v254 then
                                          v254.From = Vector2.new(
                                            v251 + (v249 - v251) * v252,
                                            v248 + (v250 - v248) * v252
                                          )

                                          v254.To = Vector2.new(
                                            v251 + (v249 - v251) * v253,
                                            v248 + (v250 - v248) * v253
                                          )

                                          v254.Color = color2
                                          v254.Visible = true
                                        end
                                      end
                                    end

                                    for i6 = count4 + 1, #gradLines do
                                      gradLines[i6].Visible = false
                                    end
                                  end

                                  function f18(p99, p100, p101, p102, p103, p104, p105, p106)
                                    local v255 = cos(p106)
                                    local v256 = sin(p106)
                                    local v257 = p100 + p102 * 0.5
                                    local v258 = p101 + p103 * 0.5

                                    local v259 = math.max((abs(v255) * p102 + abs(v256) * p103)
                                      * 0.5, 1)

                                    local v260 = math.clamp(math.floor(p103 * 0.8), 15, v37)
                                    local v261 = p103 / v260
                                    local count6 = 0

                                    while true do
                                      count6 = 1 + count6

                                      if not (v260 >= count6) then
                                        break
                                      end

                                      local v262 = count6
                                      local v263 = p101 + (v262 - 0.5) * v261

                                      local v264 = clamp(((p100 - v257) * v255
                                              + (v263 - v258) * v256)
                                            / v259
                                          * 0.5
                                        + 0.5, 0, 1)

                                      local v265 = clamp(((p100 + p102 - v257) * v255
                                              + (v263 - v258) * v256)
                                            / v259
                                          * 0.5
                                        + 0.5, 0, 1)

                                      local v266 = p99[v262]
                                      v266.Color = f41(p104, p105, (v264 + v265) * 0.5)
                                      v266.Thickness = math.clamp(v261 + 1.5, 2, 8)
                                      v266.From = Vector2.new(p100 + 1, v263)
                                      v266.To = Vector2.new(p100 + p102 - 1, v263)
                                      v266.Visible = true
                                    end

                                    local v267 = #p99
                                    local v268 = v260 + 1 - 1

                                    while true do
                                      v268 = 1 + v268

                                      if not (v268 <= v267) then
                                        break
                                      end

                                      p99[v268].Visible = false
                                    end
                                  end

                                  v37 = 400
                                  v38 = 4

                                  function v197.add_box(p107)
                                    if not p107 or v30[p107] and v30[p107].box then
                                      return
                                    else
                                      local function f70(thickness)
                                        local line2 = Drawing.new("Line")
                                        line2.Thickness = thickness
                                        line2.Transparency = 1
                                        line2.Visible = false

                                        return line2
                                      end

                                      local function f71(thickness2, filled)
                                        local square = Drawing.new("Square")
                                        square.Thickness = thickness2
                                        square.Filled = filled
                                        square.Transparency = 1
                                        square.Visible = false

                                        return square
                                      end

                                      local v269 = {}
                                      v269.outline = f71(3, false)
                                      v269.fill = f71(1, false)
                                      v269.grad_lines = {}

                                      local count7 = 0

                                      while true do
                                        count7 = 1 + count7

                                        if not (count7 <= 16) then
                                          break
                                        end

                                        v269.grad_lines[count7] = f70(1)
                                      end

                                      v269.fill_grad_lines = f15()
                                      v269.corner_fill = {}
                                      v269.corner_outline = {}

                                      for i7 = 1, 8 do
                                        v269.corner_fill[i7] = f70(1)
                                        v269.corner_outline[i7] = f70(3)
                                      end

                                      v269.box_3d_lines = {}

                                      for i8 = 1, 12 do
                                        v269.box_3d_lines[i8] = f70(2)
                                      end

                                      v30[p107] = v30[p107] or {}
                                      v30[p107].box = v269

                                      return
                                    end
                                  end

                                  function v197.add_healthbar(p108)
                                    if not p108 or v30[p108] and v30[p108].healthbar then
                                      return
                                    else
                                      local square2 = Drawing.new("Square")
                                      square2.Thickness = 1
                                      square2.Filled = true
                                      square2.Color = Color3.new(0, 0, 0)
                                      square2.Transparency = 0.5
                                      square2.Visible = false

                                      local v270 = {}

                                      for i9 = 1, 12 do
                                        local line3 = Drawing.new("Line")
                                        line3.Thickness = 3
                                        line3.Transparency = 1
                                        line3.Visible = false

                                        v270[i9] = line3
                                      end

                                      v30[p108] = v30[p108] or {}

                                      v30[p108].healthbar = {
                                        background = square2,
                                        segments = v270,
                                      }

                                      return
                                    end
                                  end

                                  function v197.add_healthtext(p109)
                                    if not p109 or v30[p109] and v30[p109].healthtext then
                                      return
                                    else
                                      local text2 = Drawing.new("Text")
                                      text2.Center = false
                                      text2.Outline = true
                                      text2.Font = 1
                                      text2.Transparency = 1
                                      text2.Visible = false

                                      v30[p109] = v30[p109] or {}
                                      v30[p109].healthtext = text2

                                      return
                                    end
                                  end

                                  function v197.add_name(p110)
                                    if not p110 or v30[p110] and v30[p110].name then
                                      return
                                    else
                                      local text3 = Drawing.new("Text")
                                      text3.Center = true
                                      text3.Outline = true
                                      text3.Font = 1
                                      text3.Transparency = 1

                                      v30[p110] = v30[p110] or {}
                                      v30[p110].name = text3

                                      return
                                    end
                                  end

                                  function v197.add_distance(p111)
                                    if not p111 or v30[p111] and v30[p111].distance then
                                      return
                                    else
                                      local text4 = Drawing.new("Text")
                                      text4.Center = true
                                      text4.Outline = true
                                      text4.Font = 1
                                      text4.Transparency = 1

                                      v30[p111] = v30[p111] or {}
                                      v30[p111].distance = text4

                                      return
                                    end
                                  end

                                  function v197.add_tracer(p112)
                                    if not p112 or v30[p112] and v30[p112].tracer then
                                      return
                                    else
                                      local line4 = Drawing.new("Line")
                                      line4.Thickness = 3
                                      line4.Transparency = 1

                                      local line5 = Drawing.new("Line")
                                      line5.Thickness = 1
                                      line5.Transparency = 1

                                      v30[p112] = v30[p112] or {}
                                      v30[p112].tracer = { outline = line4, fill = line5 }

                                      return
                                    end
                                  end

                                  function v197.add_skeleton(p113, p114)
                                    if not p113 or v30[p113] and v30[p113].skeleton then
                                      return
                                    else
                                      local v271 = p114 or {}

                                      local v272 = p113:FindFirstChild("UpperTorso") ~= nil
                                          and v33
                                        or v32

                                      local v273 = {}
                                      local v274 = {}
                                      local v275 = #v272
                                      local count8 = 0

                                      while true do
                                        count8 = 1 + count8

                                        if not (v275 >= count8) then
                                          break
                                        end

                                        local v276 = count8

                                        local line6 = Drawing.new("Line")
                                        line6.Thickness = v271.thickness or 2
                                        line6.Transparency = 1
                                        line6.Visible = false

                                        v273[v276] = line6

                                        v274[v276] = {
                                          p113:FindFirstChild(v272[v276][1]),
                                          p113:FindFirstChild(v272[v276][2]),
                                        }
                                      end

                                      v30[p113] = v30[p113] or {}

                                      v30[p113].skeleton = {
                                        lines = v273,
                                        bone_parts = v274,
                                        screenCache = {},
                                      }

                                      return
                                    end
                                  end

                                  function v197.add_weapon(p115)
                                    if not p115 or v30[p115] and v30[p115].weapon then
                                      return
                                    else
                                      local text5 = Drawing.new("Text")
                                      text5.Center = true
                                      text5.Outline = true
                                      text5.Font = 1
                                      text5.Transparency = 1
                                      text5.Visible = false

                                      v30[p115] = v30[p115] or {}
                                      v30[p115].weapon = text5

                                      return
                                    end
                                  end

                                  function v197.add_circulartarget(p116)
                                    if not p116 or v30[p116] and v30[p116].circulartarget then
                                      return
                                    else
                                      local v277 = {}
                                      local count9 = 0

                                      while true do
                                        count9 = 1 + count9

                                        if not (32 >= count9) then
                                          break
                                        end

                                        local line7 = Drawing.new("Line")
                                        line7.Thickness = 1.5
                                        line7.Transparency = 1
                                        line7.Visible = false

                                        v277[count9] = line7
                                      end

                                      local v278 = {}
                                      local v279 = {}
                                      local count10 = 0

                                      while true do
                                        count10 = 1 + count10

                                        if not (25 >= count10) then
                                          break
                                        end

                                        local v280 = count10

                                        local line8 = Drawing.new("Line")
                                        line8.Thickness = 2.5
                                        line8.Transparency = 0.4
                                        line8.Visible = false

                                        v278[v280] = line8

                                        local line9 = Drawing.new("Line")
                                        line9.Thickness = 5
                                        line9.Transparency = 0.15
                                        line9.Visible = false

                                        v279[v280] = line9
                                      end

                                      v30[p116] = v30[p116] or {}

                                      v30[p116].circulartarget = {
                                        lines = v277,
                                        trailLines = v278,
                                        neonGlowLines = v279,
                                        segments = 32,
                                        alpha = 0,
                                        movingUp = true,
                                        trailHistory = {},
                                      }

                                      return
                                    end
                                  end

                                  function f44(p117)
                                    if p117.box then
                                      f10(p117.box)
                                    end

                                    if p117.healthbar then
                                      p117.healthbar.background.Visible = false

                                      for index29, value78 in ipairs(p117.healthbar.segments) do
                                        value78.Visible = false
                                      end
                                    end

                                    if p117.healthtext then
                                      p117.healthtext.Visible = false
                                    end

                                    if p117.name then
                                      p117.name.Visible = false
                                    end

                                    if p117.distance then
                                      p117.distance.Visible = false
                                    end

                                    if p117.tracer then
                                      p117.tracer.outline.Visible = false
                                      p117.tracer.fill.Visible = false
                                    end

                                    if p117.skeleton then
                                      for index30, value79 in ipairs(p117.skeleton.lines) do
                                        value79.Visible = false
                                      end
                                    end

                                    if p117.weapon then
                                      p117.weapon.Visible = false
                                    end

                                    if p117.circulartarget then
                                      for index31, value80 in ipairs(p117.circulartarget.lines) do
                                        value80.Visible = false
                                      end

                                      for index32, value81 in ipairs(p117.circulartarget.trailLines) do
                                        value81.Visible = false
                                      end

                                      for index33, value82 in ipairs(p117.circulartarget.neonGlowLines) do
                                        value82.Visible = false
                                      end
                                    end
                                  end

                                  v39 = {}
                                  v40 = {}

                                  runService.RenderStepped:Connect(function(delta)
                                    if box.fillRotation then
                                      v29 = (v29 + delta * (box.rotationSpeed or 2)) % v31
                                    end

                                    local position3 = currentCamera.CFrame.Position
                                    local viewportSize = currentCamera.ViewportSize

                                    local value83 = Toggles.ESPTeamCheck
                                      and Toggles.ESPTeamCheck.Value

                                    local v281 = v29 / v31
                                    local vector4

                                    for key18, value84 in next, v30, nil do
                                      if not key18 or not key18.Parent then
                                        f11(key18, value84)
                                        v30[key18] = nil
                                      elseif key18 == localPlayer.Character then
                                        f44(value84)
                                      else
                                        if key18:IsA("Model") and not key18.PrimaryPart then
                                          local head = key18:FindFirstChild("Head")

                                          local humanoidRootPart2 = key18:FindFirstChild("HumanoidRootPart")
                                            or key18:FindFirstChild("Torso")
                                            or key18:FindFirstChild("UpperTorso")

                                          if head then
                                            key18.PrimaryPart = head
                                          elseif humanoidRootPart2 then
                                            key18.PrimaryPart = humanoidRootPart2
                                          end
                                        end

                                        if value83 and f39 and not f39(key18) then
                                          f44(value84)
                                        else
                                          local health2 = key18:GetAttribute("Health")

                                          local maxHealth = key18:GetAttribute("MaxHealth")
                                            or 100

                                          if key18:GetAttribute("Dead") == true
                                            or health2 and health2 <= 0 then
                                            f44(value84)
                                          else
                                            local enabled = box.enabled and value84.box ~= nil

                                            local enabled2 = healthbar.enabled
                                              and value84.healthbar ~= nil

                                            local enabled3 = healthtext.enabled
                                              and value84.healthtext ~= nil

                                            local enabled4 = name.enabled
                                              and value84.name ~= nil

                                            local enabled5 = distance.enabled
                                              and value84.distance ~= nil

                                            local enabled6 = tracer.enabled
                                              and value84.tracer ~= nil

                                            local enabled7 = skeleton.enabled
                                              and value84.skeleton ~= nil

                                            local enabled8 = weapon.enabled
                                              and value84.weapon ~= nil

                                            local enabled9 = circulartarget.enabled
                                              and value84.circulartarget ~= nil

                                            if value84.box and not enabled then
                                              f10(value84.box)
                                            end

                                            if value84.healthbar and not enabled2 then
                                              value84.healthbar.background.Visible = false

                                              for index34, value85 in ipairs(value84.healthbar.segments) do
                                                value85.Visible = false
                                              end
                                            end

                                            if value84.healthtext and not enabled3 then
                                              value84.healthtext.Visible = false
                                            end

                                            if value84.name and not enabled4 then
                                              value84.name.Visible = false
                                            end

                                            if value84.distance and not enabled5 then
                                              value84.distance.Visible = false
                                            end

                                            if value84.tracer and not enabled6 then
                                              value84.tracer.outline.Visible = false
                                              value84.tracer.fill.Visible = false
                                            end

                                            if value84.skeleton and not enabled7 then
                                              for index35, value86 in ipairs(value84.skeleton.lines) do
                                                value86.Visible = false
                                              end
                                            end

                                            if value84.weapon and not enabled8 then
                                              value84.weapon.Visible = false
                                            end

                                            if value84.circulartarget then
                                              if not enabled9 then
                                                for index36, value87 in ipairs(value84.circulartarget.lines) do
                                                  value87.Visible = false
                                                end

                                                for index37, value88 in ipairs(value84.circulartarget.trailLines) do
                                                  value88.Visible = false
                                                end

                                                for index38, value89 in ipairs(value84.circulartarget.neonGlowLines) do
                                                  value89.Visible = false
                                                end
                                              end
                                            end

                                            local v282 = enabled or enabled2 or enabled3
                                              or enabled4 or enabled5 or enabled6 or enabled7
                                              or enabled8 or enabled9

                                            if not v282 then
                                            else
                                              local v283 = nil
                                              local v284 = nil
                                              local v285 = nil
                                              local visible = false
                                              local v286 = false

                                              local v287, v288, v289, v290, v291, v292 = f42((f43(
                                                key18, value84
                                              )))

                                              if v287 then
                                                v283, v285, v286 = f19(
                                                  v287, v288, v289, v290, v291, v292
                                                )

                                                if enabled and box.type == "3D" then
                                                  v284, visible = f16(
                                                    v287, v288, v289, v290, v291, v292
                                                  )
                                                end
                                              end

                                              if value84.box then
                                                if enabled and v286 and v283 and v285 then
                                                  local x2 = v283.X
                                                  local y2 = v283.Y
                                                  local v293 = v285.X - v283.X
                                                  local v294 = v285.Y - v283.Y
                                                  local colorA = box.colorA
                                                  local colorB = box.colorB
                                                  local fillColorA = box.fillColorA
                                                  local fillColorB = box.fillColorB

                                                  if box.type == "2D" then
                                                    if box.fillGradient then
                                                      f18(
                                                        value84.box.fill_grad_lines, x2, y2,
                                                        v293, v294, fillColorA, fillColorB, v29
                                                      )
                                                    else
                                                      for index39, value90 in ipairs(value84.box.fill_grad_lines) do
                                                        value90.Visible = false
                                                      end
                                                    end

                                                    f17(
                                                      value84.box, x2, y2, v293, v294, colorA,
                                                      colorB, v281
                                                    )

                                                    value84.box.outline.Visible = false
                                                    value84.box.fill.Visible = false

                                                    for index40, value91 in ipairs(value84.box.corner_fill) do
                                                      value91.Visible = false
                                                    end

                                                    for index41, value92 in ipairs(value84.box.corner_outline) do
                                                      value92.Visible = false
                                                    end

                                                    for index42, value93 in ipairs(value84.box.box_3d_lines) do
                                                      value93.Visible = false
                                                    end
                                                  elseif box.type == "Corner" then
                                                    for index43, value94 in ipairs(value84.box.grad_lines) do
                                                      value94.Visible = false
                                                    end

                                                    value84.box.outline.Visible = false
                                                    value84.box.fill.Visible = false

                                                    if box.fillGradient then
                                                      f18(
                                                        value84.box.fill_grad_lines, x2, y2,
                                                        v293, v294, fillColorA, fillColorB, v29
                                                      )
                                                    else
                                                      for index44, value95 in ipairs(value84.box.fill_grad_lines) do
                                                        value95.Visible = false
                                                      end
                                                    end

                                                    local v295 = math.min(v293, v294) * 0.25

                                                    local v296 = {
                                                      {
                                                        Vector2.new(x2, y2),
                                                        Vector2.new(x2 + v295, y2),
                                                      },
                                                      {
                                                        Vector2.new(x2, y2),
                                                        Vector2.new(x2, y2 + v295),
                                                      },
                                                      {
                                                        Vector2.new(x2 + v293 - v295, y2),
                                                        Vector2.new(x2 + v293, y2),
                                                      },
                                                      {
                                                        Vector2.new(x2 + v293, y2),
                                                        Vector2.new(x2 + v293, y2 + v295),
                                                      },
                                                      {
                                                        Vector2.new(x2, y2 + v294),
                                                        Vector2.new(x2 + v295, y2 + v294),
                                                      },
                                                      {
                                                        Vector2.new(x2, y2 + v294 - v295),
                                                        Vector2.new(x2, y2 + v294),
                                                      },
                                                      {
                                                        Vector2.new(x2 + v293 - v295, y2 + v294),
                                                        Vector2.new(x2 + v293, y2 + v294),
                                                      },
                                                      {
                                                        Vector2.new(x2 + v293, y2 + v294 - v295),
                                                        Vector2.new(x2 + v293, y2 + v294),
                                                      },
                                                    }

                                                    local count11 = 0

                                                    while true do
                                                      count11 = 1 + count11

                                                      if not (count11 <= 8) then
                                                        break
                                                      end

                                                      local v297 = count11

                                                      local color3 = f41(
                                                        colorA, colorB, (v297 - 1) / 8
                                                      )

                                                      value84.box.corner_outline[v297].From = v296[v297][1]
                                                      value84.box.corner_outline[v297].To = v296[v297][2]
                                                      value84.box.corner_outline[v297].Color = box.outline
                                                      value84.box.corner_outline[v297].Visible = true
                                                      value84.box.corner_fill[v297].From = v296[v297][1]
                                                      value84.box.corner_fill[v297].To = v296[v297][2]
                                                      value84.box.corner_fill[v297].Color = color3
                                                      value84.box.corner_fill[v297].Visible = true
                                                    end

                                                    for index45, value96 in ipairs(value84.box.box_3d_lines) do
                                                      value96.Visible = false
                                                    end
                                                  elseif box.type == "3D" then
                                                    for index46, value97 in ipairs(value84.box.fill_grad_lines) do
                                                      value97.Visible = false
                                                    end

                                                    for index47, value98 in ipairs(value84.box.grad_lines) do
                                                      value98.Visible = false
                                                    end

                                                    value84.box.outline.Visible = false
                                                    value84.box.fill.Visible = false

                                                    for index48, value99 in ipairs(value84.box.corner_fill) do
                                                      value99.Visible = false
                                                    end

                                                    for index49, value100 in ipairs(value84.box.corner_outline) do
                                                      value100.Visible = false
                                                    end

                                                    if v284 and #v284 == 8 then
                                                      local count12 = 0

                                                      while true do
                                                        count12 = 1 + count12

                                                        if not (12 >= count12) then
                                                          break
                                                        end

                                                        local v298 = count12
                                                        local v299 = v35[v298]

                                                        value84.box.box_3d_lines[v298].From = v284[v299[1]]
                                                        value84.box.box_3d_lines[v298].To = v284[v299[2]]

                                                        value84.box.box_3d_lines[v298].Color = f41(colorA, colorB, (v298
                                                            - 1)
                                                          / 12)

                                                        value84.box.box_3d_lines[v298].Visible = visible
                                                      end
                                                    else
                                                      for index50, value101 in ipairs(value84.box.box_3d_lines) do
                                                        value101.Visible = false
                                                      end
                                                    end
                                                  end
                                                else
                                                  f10(value84.box)
                                                end
                                              end

                                              if value84.healthbar then
                                                local background = value84.healthbar.background
                                                local segments = value84.healthbar.segments

                                                if enabled2 and v286 and v283 and v285
                                                  and health2 then
                                                  local v300 = v283.X - 6
                                                  local y3 = v283.Y
                                                  local v301 = v285.Y - v283.Y

                                                  local v302 = clamp(health2
                                                    / (maxHealth > 0 and maxHealth or 100), 0, 1)

                                                  background.Position = Vector2.new(
                                                    v300 - 1, y3 - 1
                                                  )

                                                  background.Size = Vector2.new(5, v301 + 2)
                                                  background.Visible = true

                                                  local v303 = v301 * v302
                                                  local v304 = y3 + (v301 - v303)

                                                  local v305 = math.clamp(
                                                    math.floor(12 * v302), 1, 12
                                                  )

                                                  local v306 = v303 / v305
                                                  local count13 = 0

                                                  while true do
                                                    count13 = 1 + count13

                                                    if not (12 >= count13) then
                                                      break
                                                    end

                                                    local v307 = count13
                                                    local v308 = segments[v307]

                                                    if v307 <= v305 then
                                                      v308.Color = f41(
                                                        healthbar.bottomColor,
                                                        healthbar.topColor, (v307 - 0.5) / 12
                                                      )

                                                      v308.From = Vector2.new(v300 + 1.5, v304
                                                        + (v307 - 1) * v306)

                                                      v308.To = Vector2.new(
                                                        v300 + 1.5, v304 + v307 * v306
                                                      )

                                                      v308.Thickness = 3
                                                      v308.Visible = true
                                                    else
                                                      v308.Visible = false
                                                    end
                                                  end
                                                else
                                                  background.Visible = false

                                                  for index51, value102 in ipairs(segments) do
                                                    value102.Visible = false
                                                  end
                                                end
                                              end

                                              if value84.healthtext then
                                                if enabled3 and v286 and v283 and v285
                                                  and health2 then
                                                  local v309 = math.floor(health2 + 0.5)

                                                  local v310 = maxHealth > 0 and maxHealth
                                                    or 100

                                                  value84.healthtext.Text = tostring(v309)
                                                  value84.healthtext.Size = healthtext.size
                                                  value84.healthtext.Color = healthtext.color

                                                  value84.healthtext.Position = Vector2.new(v285.X
                                                    + 4, v283.Y
                                                      + (v285.Y - v283.Y) * (1 - health2 / v310)
                                                    - 4)

                                                  value84.healthtext.Visible = true
                                                else
                                                  value84.healthtext.Visible = false
                                                end
                                              end

                                              if value84.name then
                                                if enabled4 and v286 and v283 and v285 then
                                                  value84.name.Text = key18.Name
                                                  value84.name.Size = name.size
                                                  value84.name.Color = name.fill

                                                  value84.name.Position = Vector2.new((v283.X
                                                      + v285.X)
                                                    * 0.5, v283.Y - 15)

                                                  value84.name.Visible = true
                                                else
                                                  value84.name.Visible = false
                                                end
                                              end

                                              if value84.distance then
                                                if enabled5 and v286 and v283 and v285 then
                                                  local magnitude3 = 999

                                                  if key18:IsA("Model") and key18.PrimaryPart then
                                                    magnitude3 = (position3
                                                      - key18.PrimaryPart.Position).Magnitude
                                                  elseif key18:IsA("BasePart") then
                                                    magnitude3 = (position3 - key18.Position).Magnitude
                                                  end

                                                  value84.distance.Text = tostring(floor2(magnitude3))
                                                    .. "m"

                                                  value84.distance.Size = distance.size
                                                  value84.distance.Color = distance.color

                                                  value84.distance.Position = Vector2.new((v283.X
                                                      + v285.X)
                                                    * 0.5, v285.Y
                                                    + 2)

                                                  value84.distance.Visible = true
                                                else
                                                  value84.distance.Visible = false
                                                end
                                              end

                                              if value84.weapon then
                                                if enabled8 and v286 and v283 and v285 then
                                                  if not value84.player then
                                                    value84.player = players:GetPlayerFromCharacter(key18)
                                                  end

                                                  local player = value84.player
                                                      and f12(value84.player)
                                                    or "None"

                                                  value84.weapon.Text = "[" .. player .. "]"
                                                  value84.weapon.Size = weapon.size or 13
                                                  value84.weapon.Color = weapon.fill

                                                  value84.weapon.Position = Vector2.new((v283.X
                                                      + v285.X)
                                                    * 0.5, v285.Y
                                                    + 15)

                                                  value84.weapon.Center = true
                                                  value84.weapon.Visible = true
                                                else
                                                  value84.weapon.Visible = false
                                                end
                                              end

                                              if value84.tracer then
                                                if enabled6 and v286 and v283 and v285 then
                                                  if tracer.from == "mouse" then
                                                    local getMouseLocation = userInputService:GetMouseLocation()

                                                    vector4 = Vector2.new(
                                                      getMouseLocation.X, getMouseLocation.Y
                                                    )
                                                  elseif tracer.from == "top" then
                                                    vector4 = Vector2.new(viewportSize.X / 2, 0)
                                                  elseif tracer.from == "center" then
                                                    vector4 = Vector2.new(
                                                      viewportSize.X / 2, viewportSize.Y / 2
                                                    )
                                                  else
                                                    vector4 = Vector2.new(
                                                      viewportSize.X / 2, viewportSize.Y
                                                    )
                                                  end

                                                  local to = (v283 + v285) / 2
                                                  local v311 = 0

                                                  if key18:IsA("Model") and key18.PrimaryPart then
                                                    v311 = clamp((position3
                                                        - key18.PrimaryPart.Position).Magnitude
                                                      / 200, 0, 1)
                                                  end

                                                  local color4 = f41(
                                                    tracer.fillA, tracer.fillB, v311
                                                  )

                                                  value84.tracer.outline.From = vector4
                                                  value84.tracer.outline.To = to
                                                  value84.tracer.outline.Color = tracer.outline
                                                  value84.tracer.outline.Visible = true
                                                  value84.tracer.fill.From = vector4
                                                  value84.tracer.fill.To = to
                                                  value84.tracer.fill.Color = color4
                                                  value84.tracer.fill.Visible = true
                                                else
                                                  value84.tracer.outline.Visible = false
                                                  value84.tracer.fill.Visible = false
                                                end
                                              end

                                              if value84.skeleton then
                                                if enabled7 then
                                                  local boneParts = value84.skeleton.bone_parts
                                                  local lines = value84.skeleton.lines
                                                  local screenCache = value84.skeleton.screenCache

                                                  for key19 in next, screenCache, nil do
                                                    screenCache[key19] = nil
                                                  end

                                                  local v312 = false

                                                  for i10 = 1, #boneParts do
                                                    local v313 = boneParts[i10]
                                                    local v314 = v313[1]
                                                    local v315 = v313[2]
                                                    local parent = v314
                                                    local v316 = lines[i10]

                                                    if v314 then
                                                      parent = v315 and v314.Parent
                                                        and v315.Parent
                                                    end

                                                    if parent then
                                                      local from, v317 = f13(screenCache, v314)
                                                      local to2, v318 = f13(screenCache, v315)

                                                      if v317 or v318 then
                                                        v316.From = from
                                                        v316.To = to2

                                                        v316.Color = f41(
                                                          skeleton.colorA, skeleton.colorB,
                                                          (i10 - 1) / #boneParts
                                                        )

                                                        v316.Thickness = skeleton.thickness
                                                        v316.Visible = true

                                                        v312 = true
                                                      else
                                                        v316.Visible = false
                                                      end
                                                    else
                                                      v316.Visible = false
                                                    end
                                                  end

                                                  if not v312 then
                                                    for index52, value103 in ipairs(lines) do
                                                      value103.Visible = false
                                                    end
                                                  end
                                                else
                                                  for index53, value104 in ipairs(value84.skeleton.lines) do
                                                    value104.Visible = false
                                                  end
                                                end
                                              end

                                              if value84.circulartarget then
                                                local circulartarget2 = value84.circulartarget
                                                local head2 = key18:FindFirstChild("Head")

                                                local primaryPart = key18:IsA("Model")
                                                  and key18.PrimaryPart

                                                local humanoidRootPart3 = primaryPart

                                                humanoidRootPart3 = primaryPart
                                                  or key18:FindFirstChild("HumanoidRootPart")
                                                  or head2

                                                if enabled9 and head2 and humanoidRootPart3 then
                                                  if circulartarget2.movingUp then
                                                    circulartarget2.alpha = circulartarget2.alpha
                                                      + delta * 2

                                                    if circulartarget2.alpha >= 1 then
                                                      circulartarget2.alpha = 1
                                                      circulartarget2.movingUp = false
                                                    end
                                                  else
                                                    circulartarget2.alpha = circulartarget2.alpha
                                                      - delta * 2

                                                    if circulartarget2.alpha <= 0 then
                                                      circulartarget2.alpha = 0
                                                      circulartarget2.movingUp = true
                                                    end
                                                  end

                                                  local lerp = (humanoidRootPart3.Position - Vector3.new(
                                                    0, humanoidRootPart3.Size.Y * 0.8 + 1.2, 0
                                                  )):Lerp(head2.Position + Vector3.new(
                                                    0, 0.3, 0
                                                  ), circulartarget2.alpha)

                                                  table.insert(
                                                    circulartarget2.trailHistory, 1, lerp
                                                  )

                                                  if #circulartarget2.trailHistory
                                                    > #circulartarget2.trailLines then
                                                    table.remove(circulartarget2.trailHistory)
                                                  end

                                                  for i11 = 1, #circulartarget2.trailLines do
                                                    local v319 = circulartarget2.trailLines[i11]
                                                    local v320 = circulartarget2.neonGlowLines[i11]
                                                    local v321 = circulartarget2.trailHistory[i11]
                                                    local v322 = circulartarget2.trailHistory[i11 + 1]

                                                    if v321 and v322 then
                                                      local v323, v324 = worldToViewportPoint(
                                                        currentCamera, v321
                                                      )

                                                      local v325, v326 = worldToViewportPoint(
                                                        currentCamera, v322
                                                      )

                                                      if v324 or v326 then
                                                        local v327 = clamp(1
                                                          - i11 / #circulartarget2.trailLines, 0.05, 1)

                                                        v320.From = Vector2.new(v323.X, v323.Y)
                                                        v320.To = Vector2.new(v325.X, v325.Y)
                                                        v320.Color = circulartarget.color
                                                        v320.Transparency = v327 * 0.35
                                                        v320.Visible = true

                                                        v319.From = Vector2.new(v323.X, v323.Y)
                                                        v319.To = Vector2.new(v325.X, v325.Y)
                                                        v319.Color = circulartarget.color
                                                        v319.Transparency = v327 * 0.85
                                                        v319.Visible = true
                                                      else
                                                        v319.Visible = false
                                                        v320.Visible = false
                                                      end
                                                    else
                                                      v319.Visible = false
                                                      v320.Visible = false
                                                    end
                                                  end

                                                  local segments2 = circulartarget2.segments
                                                  local color5 = circulartarget.color
                                                  local count14 = 0

                                                  while true do
                                                    count14 = 1 + count14

                                                    if not (count14 <= segments2) then
                                                      break
                                                    end

                                                    local v328 = count14
                                                    local v329 = v31 * ((v328 - 1) / segments2)
                                                    local v330 = v31 * (v328 / segments2)
                                                    local v331 = cos(v329)
                                                    local v332 = sin(v329)

                                                    local vector5 = Vector3.new(
                                                      v331 * 2.2, 0, v332 * 2.2
                                                    )

                                                    local v333 = cos(v330)
                                                    local v334 = sin(v330)

                                                    local vector6 = Vector3.new(
                                                      v333 * 2.2, 0, v334 * 2.2
                                                    )

                                                    local v335, v336 = worldToViewportPoint(currentCamera, lerp
                                                      + vector5)

                                                    local v337, v338 = worldToViewportPoint(currentCamera, lerp
                                                      + vector6)

                                                    local v339 = circulartarget2.lines[v328]

                                                    if v336 or v338 then
                                                      v339.From = Vector2.new(v335.X, v335.Y)
                                                      v339.To = Vector2.new(v337.X, v337.Y)
                                                      v339.Color = color5
                                                      v339.Visible = true
                                                    else
                                                      v339.Visible = false
                                                    end
                                                  end
                                                else
                                                  for index54, value105 in ipairs(circulartarget2.lines) do
                                                    value105.Visible = false
                                                  end

                                                  for index55, value106 in ipairs(circulartarget2.trailLines) do
                                                    value106.Visible = false
                                                  end

                                                  for index56, value107 in ipairs(circulartarget2.neonGlowLines) do
                                                    value107.Visible = false
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end)

                                  for key20, value108 in next, v197, nil do
                                    esplib[key20] = value108
                                  end

                                  function f22()
                                    local value109 = Options.ESPBoxType.Value

                                    if value109 == "Disabled" then
                                      esplib.box.enabled = false
                                    else
                                      esplib.box.enabled = Toggles.ESPEnabled.Value
                                      esplib.box.type = value109:gsub(" Box", "")
                                    end

                                    esplib.box.colorA = Options.ESPBoxColorA.Value
                                    esplib.box.colorB = Options.ESPBoxColorB.Value
                                    esplib.box.fillGradient = Toggles.ESPBoxFillGradient.Value
                                    esplib.box.fillColorA = Options.ESPFillColorA.Value
                                    esplib.box.fillColorB = Options.ESPFillColorB.Value
                                    esplib.box.fillRotation = Toggles.ESPBoxFillRotation.Value
                                    esplib.box.rotationSpeed = Options.ESPBoxRotationSpeed.Value

                                    local name4 = esplib.name

                                    name4.enabled = Toggles.ESPEnabled.Value
                                      and Toggles.ESPName.Value

                                    esplib.name.fill = Options.ESPNameColor.Value

                                    local healthbar2 = esplib.healthbar

                                    healthbar2.enabled = Toggles.ESPEnabled.Value
                                      and Toggles.ESPHealth.Value

                                    esplib.healthbar.topColor = Options.ESPHealthTopColor.Value
                                    esplib.healthbar.bottomColor = Options.ESPHealthBottomColor.Value

                                    local healthtext2 = esplib.healthtext

                                    healthtext2.enabled = Toggles.ESPEnabled.Value
                                      and Toggles.ESPHealthText.Value

                                    esplib.healthtext.color = Options.ESPHealthTextColor.Value

                                    local distance2 = esplib.distance

                                    distance2.enabled = Toggles.ESPEnabled.Value
                                      and Toggles.ESPDistance.Value

                                    esplib.distance.color = Options.ESPDistanceColor.Value

                                    local tracer2 = esplib.tracer

                                    tracer2.enabled = Toggles.ESPEnabled.Value
                                      and Toggles.ESPTracer.Value

                                    esplib.tracer.fillA = Options.ESPTracerColor.Value
                                    esplib.tracer.fillB = Options.ESPTracerColorB.Value

                                    local value110 = Options.ESPTracerOrigin.Value
                                    esplib.tracer.from = value110:lower()

                                    local skeleton2 = esplib.skeleton

                                    skeleton2.enabled = Toggles.ESPEnabled.Value
                                      and Toggles.ESPSkeleton.Value

                                    esplib.skeleton.colorA = Options.ESPSkeletonColorA.Value
                                    esplib.skeleton.colorB = Options.ESPSkeletonColorB.Value

                                    local weapon3 = esplib.weapon

                                    weapon3.enabled = Toggles.ESPEnabled.Value
                                      and Toggles.ESPWeapon.Value

                                    local weapon4 = esplib.weapon

                                    weapon4.fill = Options.ESPWeaponColor
                                        and Options.ESPWeaponColor.Value
                                      or Color3.new(1, 1, 1)

                                    local circulartarget3 = esplib.circulartarget

                                    circulartarget3.enabled = Toggles.ESPEnabled.Value
                                      and Toggles.ESPCircularTarget.Value

                                    esplib.circulartarget.color = Options.ESPCircularTargetColor.Value
                                  end

                                  function f20(p118)
                                    if not p118 or v41[p118] then
                                      return
                                    end

                                    if p118 == localPlayer.Character then
                                      return
                                    end

                                    esplib.add_box(p118)
                                    esplib.add_name(p118)
                                    esplib.add_healthbar(p118)
                                    esplib.add_healthtext(p118)
                                    esplib.add_distance(p118)
                                    esplib.add_tracer(p118)
                                    esplib.add_skeleton(p118, { thickness = 2 })
                                    esplib.add_weapon(p118)
                                    esplib.add_circulartarget(p118)

                                    v41[p118] = true
                                  end

                                  function f21(p119)
                                    if p119 then
                                      if v30[p119] then
                                        f11(p119, v30[p119])
                                        v30[p119] = nil
                                      end

                                      v41[p119] = nil
                                    end
                                  end

                                  v41 = {}
                                  waitForChild = workspaceService:WaitForChild("Characters", 5)

                                  function f45()
                                    if not waitForChild then
                                      return
                                    end

                                    local f72

                                    function f72(p120)
                                      for index57, value111 in ipairs(p120:GetChildren()) do
                                        if value111:IsA("Model") then
                                          if value111:GetAttribute("Health") ~= nil
                                            or value111:FindFirstChild("Head") then
                                            f20(value111)
                                          end

                                          f72(value111)
                                        end
                                      end
                                    end

                                    f72(waitForChild)
                                  end

                                  f45()

                                  if waitForChild then
                                    waitForChild.DescendantAdded:Connect(function(descendant)
                                      if descendant:IsA("Model") then
                                        task.wait(0.1)

                                        if descendant:GetAttribute("Health") ~= nil
                                          or descendant:FindFirstChild("Head") then
                                          f20(descendant)
                                        end
                                      end
                                    end)

                                    waitForChild.DescendantRemoving:Connect(function(descendant2)
                                      if descendant2:IsA("Model") then
                                        f21(descendant2)
                                      end
                                    end)
                                  end

                                  function f46()
                                    for key21 in next, v41, nil do
                                      f21(key21)
                                    end

                                    f45()
                                  end

                                  local function f73()
                                    f22()
                                    f46()
                                  end

                                  Toggles.ESPEnabled:OnChanged(f73)
                                  Toggles.ESPTeamCheck:OnChanged(f73)

                                  Options.ESPBoxType:OnChanged(f22)
                                  Options.ESPBoxColorA:OnChanged(f22)
                                  Options.ESPBoxColorB:OnChanged(f22)

                                  Toggles.ESPBoxFillGradient:OnChanged(f22)

                                  Options.ESPFillColorA:OnChanged(f22)
                                  Options.ESPFillColorB:OnChanged(f22)

                                  Toggles.ESPBoxFillRotation:OnChanged(f22)
                                  Options.ESPBoxRotationSpeed:OnChanged(f22)
                                  Toggles.ESPName:OnChanged(f22)
                                  Options.ESPNameColor:OnChanged(f22)
                                  Toggles.ESPHealth:OnChanged(f22)

                                  Options.ESPHealthTopColor:OnChanged(f22)
                                  Options.ESPHealthBottomColor:OnChanged(f22)

                                  Toggles.ESPHealthText:OnChanged(f22)
                                  Options.ESPHealthTextColor:OnChanged(f22)
                                  Toggles.ESPDistance:OnChanged(f22)
                                  Options.ESPDistanceColor:OnChanged(f22)
                                  Toggles.ESPTracer:OnChanged(f22)

                                  Options.ESPTracerColor:OnChanged(f22)
                                  Options.ESPTracerColorB:OnChanged(f22)
                                  Options.ESPTracerOrigin:OnChanged(f22)

                                  Toggles.ESPSkeleton:OnChanged(f22)

                                  Options.ESPSkeletonColorA:OnChanged(f22)
                                  Options.ESPSkeletonColorB:OnChanged(f22)

                                  Toggles.ESPWeapon:OnChanged(f22)

                                  if Options.ESPWeaponColor then
                                    Options.ESPWeaponColor:OnChanged(f22)
                                  end

                                  Toggles.ESPCircularTarget:OnChanged(f22)
                                  Options.ESPCircularTargetColor:OnChanged(f22)
                                  f22()

                                  players.PlayerRemoving:Connect(function(player2)
                                    if v21 and player2.Name == v21 then
                                      v21 = nil
                                    end
                                  end)

                                  local grenadeESPSection = espTab:Section({
                                    Title = "Grenade ESP",
                                    Opened = true,
                                    Icon = "activity",
                                  })

                                  f61(
                                    grenadeESPSection, "GrenadeTracers", "Grenade Tracers",
                                    false
                                  )

                                  f61(
                                    grenadeESPSection, "MolotovZoneESP", "Molotov Zone ESP",
                                    false
                                  )

                                  f61(
                                    grenadeESPSection, "SmokeZoneESP", "Smoke Zone ESP", false
                                  )

                                  grenadeESPSection:Divider()

                                  f63(
                                    grenadeESPSection, "GrenadeTracerColor", "Tracer Color",
                                    Color3.fromRGB(255, 100, 0)
                                  )

                                  f63(
                                    grenadeESPSection, "GrenadeZoneColor", "Zone Color",
                                    Color3.fromRGB(255, 60, 0)
                                  )

                                  f63(
                                    grenadeESPSection, "SmokeZoneColor", "Smoke Color",
                                    Color3.fromRGB(180, 180, 180)
                                  )

                                  local cameraSettingsSection = visualTab:Section({
                                    Title = "Camera Settings",
                                    Opened = true,
                                    Icon = "camera",
                                  })

                                  f61(
                                    cameraSettingsSection, "CustomFovToggle", "Custom FOV",
                                    false
                                  )

                                  f60(
                                    cameraSettingsSection, "FovAmount", "Field of View", 90, 70,
                                    120, 0, "deg"
                                  )

                                  cameraSettingsSection:Divider()

                                  f61(cameraSettingsSection, "ThirdPerson", "Unlock Third Person", false, {
                                    Callback = function(value112)
                                      if not value112 then
                                        pcall(function()
                                          localPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
                                          localPlayer.CameraMaxZoomDistance = 0.5
                                          localPlayer.CameraMinZoomDistance = 0.5
                                        end)
                                      end
                                    end,
                                  })

                                  f60(
                                    cameraSettingsSection, "ThirdPersonDist",
                                    "Third Person Camera Distance", 10, 5, 50, 0, "studs"
                                  )

                                  if SentinelThirdPersonHooked then
                                    pcall(function() SentinelThirdPersonHooked:Disconnect() end)
                                    SentinelThirdPersonHooked = nil
                                  end

                                  if getrawmetatable and setreadonly and newcclosure then
                                    SentinelThirdPersonHooked = true
                                    local v340 = getrawmetatable(game)
                                    newindex = v340.__newindex
                                    setreadonly(v340, false)

                                    v340.__newindex = newcclosure(function(p121, p122, p123)
                                      if p121 == localPlayer and Toggles and Toggles.ThirdPerson
                                        and Toggles.ThirdPerson.Value then
                                        if p122 == "CameraMode" then
                                          return newindex(p121, p122, Enum.CameraMode.Classic)
                                        elseif p122 == "CameraMaxZoomDistance" then
                                          return newindex(p121, p122, (math.clamp(Options.ThirdPersonDist
                                              and Options.ThirdPersonDist.Value
                                            or 10, 5, 50)))
                                        else
                                          if p122 == "CameraMinZoomDistance" then
                                            return newindex(p121, p122, (math.clamp(Options.ThirdPersonDist
                                                and Options.ThirdPersonDist.Value
                                              or 10, 5, 50)))
                                          end

                                          return newindex(p121, p122, p123)
                                        end
                                      else
                                        return newindex(p121, p122, p123)
                                      end
                                    end)

                                    setreadonly(v340, true)
                                  end

                                  runService.RenderStepped:Connect(function()
                                    pcall(function()
                                      if not (Toggles.ThirdPerson and Toggles.ThirdPerson.Value) then
                                        return
                                      else
                                        local v341 = math.clamp(Options.ThirdPersonDist
                                            and Options.ThirdPersonDist.Value
                                          or 10, 5, 50)

                                        if localPlayer.CameraMode ~= Enum.CameraMode.Classic then
                                          localPlayer.CameraMode = Enum.CameraMode.Classic
                                        end

                                        if localPlayer.CameraMaxZoomDistance ~= v341 then
                                          localPlayer.CameraMaxZoomDistance = v341
                                        end

                                        if localPlayer.CameraMinZoomDistance ~= v341 then
                                          localPlayer.CameraMinZoomDistance = v341
                                        end

                                        return
                                      end
                                    end)
                                  end)

                                  runService.RenderStepped:Connect(function()
                                    pcall(function()
                                      if Toggles.CustomFovToggle
                                        and Toggles.CustomFovToggle.Value then
                                        local currentCamera7 = workspaceService.CurrentCamera

                                        if currentCamera7 then
                                          currentCamera7.FieldOfView = Options.FovAmount.Value
                                            or 90
                                        end
                                      end
                                    end)
                                  end)

                                  local atmosphereSection = visualTab:Section({
                                    Title = "atmosphere",
                                    Opened = true,
                                    Icon = "cloud-sun",
                                  })

                                  f61(atmosphereSection, "Fullbright", "Fullbright", false)
                                  f61(atmosphereSection, "NoFog", "No Fog", false)

                                  runService.RenderStepped:Connect(function()
                                    pcall(function()
                                      if Toggles.Fullbright and Toggles.Fullbright.Value then
                                        lighting.Ambient = Color3.fromRGB(255, 255, 255)
                                        lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
                                        lighting.Brightness = 2
                                      else
                                        lighting.Ambient = ambient
                                        lighting.OutdoorAmbient = outdoorAmbient
                                        lighting.Brightness = brightness
                                      end

                                      if Toggles.NoFog and Toggles.NoFog.Value then
                                        lighting.FogEnd = 999999999
                                        lighting.FogStart = 999999999
                                      else
                                        lighting.FogEnd = fogEnd
                                        lighting.FogStart = fogStart
                                      end
                                    end)
                                  end)

                                  local section3 = visualTab:Section({
                                    Title = "X-ray Settings",
                                    Opened = true,
                                    Icon = "brick-wall",
                                  })

                                  f61(section3, "XrayEnabled", "Enable X-Ray", false)
                                  section3:Divider()

                                  f60(
                                    section3, "XrayDistance", "Distance", 30, 0, 100, 0, "studs"
                                  )

                                  f60(
                                    section3, "XrayTransparency", "Transparency", 30, 0, 100, 0,
                                    "%"
                                  )

                                  f62(section3, "XrayMaterial", "Material", {
                                    "Plastic", "Neon", "ForceField", "Glass", "SmoothPlastic",
                                  }, "ForceField", false)

                                  v42 = {
                                    Plastic = Enum.Material.Plastic,
                                    Neon = Enum.Material.Neon,
                                    ForceField = Enum.Material.ForceField,
                                    Glass = Enum.Material.Glass,
                                    SmoothPlastic = Enum.Material.SmoothPlastic,
                                  }

                                  v43 = {}
                                  connect = nil

                                  function f47(p124, p125, material, transparency)
                                    if not p124:IsA("BasePart") then
                                      return
                                    end

                                    if p125 then
                                      if not v43[p124] then
                                        v43[p124] = {
                                          Material = p124.Material,
                                          Transparency = p124.Transparency,
                                        }
                                      end

                                      p124.Material = material
                                      p124.Transparency = transparency
                                    else
                                      local v342 = v43[p124]

                                      if v342 then
                                        p124.Material = v342.Material
                                        p124.Transparency = v342.Transparency
                                        v43[p124] = nil
                                      end
                                    end
                                  end

                                  local function f74()
                                    if connect then
                                      connect:Disconnect()
                                      connect = nil
                                    end

                                    if not (Toggles.XrayEnabled and Toggles.XrayEnabled.Value) then
                                      local v343 = {}

                                      for key22, value113 in pairs(v43) do
                                        table.insert(v343, key22)
                                      end

                                      for index58, value114 in ipairs(v343) do
                                        local v344 = value114
                                        pcall(function() f47(v344, false) end)
                                      end

                                      table.clear(v43)
                                      return
                                    end

                                    local forceField = v42[Options.XrayMaterial
                                          and Options.XrayMaterial.Value
                                        or "ForceField"]
                                      or Enum.Material.ForceField

                                    local v345 = (Options.XrayTransparency
                                          and Options.XrayTransparency.Value
                                        or 30)
                                      / 100

                                    local value115 = Options.XrayDistance
                                        and Options.XrayDistance.Value
                                      or 30

                                    connect = runService.Heartbeat:Connect(function()
                                      local character5 = localPlayer.Character

                                      if not character5 then
                                        return
                                      else
                                        local humanoidRootPart4 = character5:FindFirstChild("HumanoidRootPart")

                                        if not humanoidRootPart4 then
                                          return
                                        else
                                          local v346 = {}

                                          for index59, value116 in ipairs((workspaceService:GetPartBoundsInRadius(
                                            humanoidRootPart4.Position, value115
                                          ))) do
                                            if value116:IsA("BasePart")
                                              and not value116:IsDescendantOf(character5) then
                                              v346[value116] = true

                                              if not v43[value116] then
                                                f47(value116, true, forceField, v345)
                                              elseif value116.Material ~= forceField
                                                or value116.Transparency ~= v345 then
                                                value116.Material = forceField
                                                value116.Transparency = v345
                                              end
                                            end
                                          end

                                          local v347 = {}

                                          for key23 in pairs(v43) do
                                            if not v346[key23] then
                                              table.insert(v347, key23)
                                            end
                                          end

                                          for index60, value117 in ipairs(v347) do
                                            f47(value117, false)
                                          end

                                          return
                                        end
                                      end
                                    end)
                                  end

                                  Toggles.XrayEnabled:OnChanged(f74)

                                  Options.XrayMaterial:OnChanged(f74)
                                  Options.XrayTransparency:OnChanged(f74)
                                  Options.XrayDistance:OnChanged(f74)

                                  local section4 = visualTab:Section({
                                    Title = "Custom Hands Position",
                                    Opened = true,
                                    Icon = "crosshair",
                                  })

                                  f61(section4, "CustomHandsEnabled", "Enable", false)

                                  f60(section4, "HandsX", "X", 20, -100, 100, 1, "×0.01")
                                  f60(section4, "HandsY", "Y", -15.5, -100, 100, 1, "×0.01")
                                  f60(section4, "HandsZ", "Z", 7.5, -100, 100, 1, "×0.01")

                                  runService.RenderStepped:Connect(function()
                                    pcall(function()
                                      if not Toggles.CustomHandsEnabled
                                        or not Toggles.CustomHandsEnabled.Value then
                                        return
                                      else
                                        local v348 = (Options.HandsX and Options.HandsX.Value
                                            or 20)
                                          / 100

                                        local v349 = (Options.HandsY and Options.HandsY.Value
                                            or -15.5)
                                          / 100

                                        local v350 = (Options.HandsZ and Options.HandsZ.Value
                                            or 7.5)
                                          / 100

                                        for index61, value118 in ipairs(currentCamera:GetChildren()) do
                                          if value118:IsA("Model") then
                                            local v351 = value118:FindFirstChild("Stats")

                                            if v351 then
                                              local default = v351:FindFirstChild("Default")

                                              if default and default:IsA("Vector3Value") then
                                                default.Value = Vector3.new(v348, v349, v350)
                                              end
                                            end
                                          end
                                        end

                                        return
                                      end
                                    end)
                                  end)

                                  v44 = {
                                    Night = {
                                      SkyboxBk = "rbxassetid://1514717643",
                                      SkyboxDn = "rbxassetid://1514716936",
                                      SkyboxFt = "rbxassetid://1514715910",
                                      SkyboxLf = "rbxassetid://1514714945",
                                      SkyboxRt = "rbxassetid://1514714011",
                                      SkyboxUp = "rbxassetid://1514713374",
                                    },
                                    ["Ocean Sunset"] = {
                                      SkyboxBk = "rbxassetid://17525686840",
                                      SkyboxDn = "rbxassetid://17525678473",
                                      SkyboxFt = "rbxassetid://17525684686",
                                      SkyboxLf = "rbxassetid://17525680663",
                                      SkyboxRt = "rbxassetid://17525682665",
                                      SkyboxUp = "rbxassetid://17525674545",
                                    },
                                    ["My Summer Car"] = {
                                      SkyboxBk = "rbxassetid://16648590964",
                                      SkyboxDn = "rbxassetid://16648617436",
                                      SkyboxFt = "rbxassetid://16648595424",
                                      SkyboxLf = "rbxassetid://16648566370",
                                      SkyboxRt = "rbxassetid://16648577071",
                                      SkyboxUp = "rbxassetid://16648598180",
                                    },
                                    Standard = {
                                      SkyboxBk = "http://www.roblox.com/asset/?id=91458024",
                                      SkyboxDn = "http://www.roblox.com/asset/?id=91457980",
                                      SkyboxFt = "http://www.roblox.com/asset/?id=91458024",
                                      SkyboxLf = "http://www.roblox.com/asset/?id=91458024",
                                      SkyboxRt = "http://www.roblox.com/asset/?id=91458024",
                                      SkyboxUp = "http://www.roblox.com/asset/?id=91458002",
                                    },
                                    Minecraft = {
                                      SkyboxBk = "http://www.roblox.com/asset/?id=8735166756",
                                      SkyboxDn = "http://www.roblox.com/asset/?id=8735166707",
                                      SkyboxFt = "http://www.roblox.com/asset/?id=8735231668",
                                      SkyboxLf = "http://www.roblox.com/asset/?id=8735166755",
                                      SkyboxRt = "http://www.roblox.com/asset/?id=8735166751",
                                      SkyboxUp = "http://www.roblox.com/asset/?id=8735166729",
                                    },
                                    Spongebob = {
                                      SkyboxBk = "http://www.roblox.com/asset/?id=277099484",
                                      SkyboxDn = "http://www.roblox.com/asset/?id=277099500",
                                      SkyboxFt = "http://www.roblox.com/asset/?id=277099554",
                                      SkyboxLf = "http://www.roblox.com/asset/?id=277099531",
                                      SkyboxRt = "http://www.roblox.com/asset/?id=277099589",
                                      SkyboxUp = "http://www.roblox.com/asset/?id=277101591",
                                    },
                                    ["Deep Space"] = {
                                      SkyboxBk = "http://www.roblox.com/asset/?id=159248188",
                                      SkyboxDn = "http://www.roblox.com/asset/?id=159248183",
                                      SkyboxFt = "http://www.roblox.com/asset/?id=159248187",
                                      SkyboxLf = "http://www.roblox.com/asset/?id=159248173",
                                      SkyboxRt = "http://www.roblox.com/asset/?id=159248192",
                                      SkyboxUp = "http://www.roblox.com/asset/?id=159248176",
                                    },
                                    ["Clouded Sky"] = {
                                      SkyboxBk = "http://www.roblox.com/asset/?id=252760981",
                                      SkyboxDn = "http://www.roblox.com/asset/?id=252763035",
                                      SkyboxFt = "http://www.roblox.com/asset/?id=252761439",
                                      SkyboxLf = "http://www.roblox.com/asset/?id=252760980",
                                      SkyboxRt = "http://www.roblox.com/asset/?id=252760986",
                                      SkyboxUp = "http://www.roblox.com/asset/?id=252762652",
                                    },
                                    Retro = {
                                      SkyboxBk = "rbxasset://sky/null_plainsky512_bk.jpg",
                                      SkyboxDn = "rbxasset://sky/null_plainsky512_dn.jpg",
                                      SkyboxFt = "rbxasset://sky/null_plainsky512_ft.jpg",
                                      SkyboxLf = "rbxasset://sky/null_plainsky512_lf.jpg",
                                      SkyboxRt = "rbxasset://sky/null_plainsky512_rt.jpg",
                                      SkyboxUp = "rbxasset://sky/null_plainsky512_up.jpg",
                                    },
                                    City = {
                                      SkyboxBk = "http://www.roblox.com/asset/?id=9134792889",
                                      SkyboxDn = "http://www.roblox.com/asset/?id=9134791975",
                                      SkyboxFt = "http://www.roblox.com/asset/?id=9134793457",
                                      SkyboxLf = "http://www.roblox.com/asset/?id=9134791234",
                                      SkyboxRt = "http://www.roblox.com/asset/?id=9134790419",
                                      SkyboxUp = "http://www.roblox.com/asset/?id=9134791633",
                                    },
                                    ["Purple Nebula"] = {
                                      SkyboxBk = "http://www.roblox.com/asset/?id=15983968922",
                                      SkyboxDn = "http://www.roblox.com/asset/?id=15983966825",
                                      SkyboxFt = "http://www.roblox.com/asset/?id=15983965025",
                                      SkyboxLf = "http://www.roblox.com/asset/?id=15983967420",
                                      SkyboxRt = "http://www.roblox.com/asset/?id=15983966246",
                                      SkyboxUp = "http://www.roblox.com/asset/?id=15983964246",
                                    },
                                    ["Pink Sky"] = {
                                      SkyboxBk = "http://www.roblox.com/asset/?id=7890140060",
                                      SkyboxDn = "http://www.roblox.com/asset/?id=7890140060",
                                      SkyboxFt = "http://www.roblox.com/asset/?id=7890140060",
                                      SkyboxLf = "http://www.roblox.com/asset/?id=7890140060",
                                      SkyboxRt = "http://www.roblox.com/asset/?id=7890140060",
                                      SkyboxUp = "http://www.roblox.com/asset/?id=7890140060",
                                    },
                                  }

                                  local v352 = {}

                                  for key24, value119 in pairs(v44) do
                                    table.insert(v352, key24)
                                  end

                                  table.sort(v352)

                                  function f23(p126)
                                    if sentinelWeatherSky then
                                      sentinelWeatherSky:Destroy()
                                      sentinelWeatherSky = nil
                                    end

                                    if sentinelWeatherGround then
                                      sentinelWeatherGround:Destroy()
                                      sentinelWeatherGround = nil
                                    end

                                    for key25, value120 in pairs(workspaceService:GetChildren()) do
                                      if value120.Name == "Sentinel_RainDrop" then
                                        value120:Destroy()
                                      end
                                    end

                                    if p126 == "None" then
                                      return
                                    else
                                      sentinelWeatherSky = Instance.new("Part")
                                      sentinelWeatherSky.Name = "Sentinel_Weather_Sky"
                                      sentinelWeatherSky.Size = Vector3.new(100, 1, 100)
                                      sentinelWeatherSky.Transparency = 1
                                      sentinelWeatherSky.Anchored = true
                                      sentinelWeatherSky.CanCollide = false
                                      sentinelWeatherSky.Parent = workspaceService.CurrentCamera

                                      local particleEmitter = Instance.new("ParticleEmitter")
                                      particleEmitter.Parent = sentinelWeatherSky
                                      particleEmitter.EmissionDirection = Enum.NormalId.Bottom
                                      particleEmitter.Enabled = true

                                      sentinelWeatherGround = Instance.new("Part")
                                      sentinelWeatherGround.Name = "Sentinel_Weather_Ground"
                                      sentinelWeatherGround.Size = Vector3.new(50, 1, 50)
                                      sentinelWeatherGround.Transparency = 1
                                      sentinelWeatherGround.Anchored = true
                                      sentinelWeatherGround.CanCollide = false
                                      sentinelWeatherGround.Parent = workspaceService.CurrentCamera

                                      local particleEmitter2 = Instance.new("ParticleEmitter")
                                      particleEmitter2.Parent = sentinelWeatherGround
                                      particleEmitter2.Enabled = false

                                      if p126 == "Rain" then
                                        particleEmitter.Texture = "rbxassetid://241868005"
                                        particleEmitter.Rate = 10000

                                        particleEmitter.Color = ColorSequence.new(Color3.fromRGB(
                                          255, 255, 255
                                        ))

                                        particleEmitter.LightEmission = 0.2
                                        particleEmitter.Transparency = NumberSequence.new(0)
                                        particleEmitter.Size = NumberSequence.new(3, 6)
                                        particleEmitter.Lifetime = NumberRange.new(2, 2.5)
                                        particleEmitter.Speed = NumberRange.new(80, 100)
                                        particleEmitter.SpreadAngle = Vector2.new(0, 0)
                                        particleEmitter.Acceleration = Vector3.new(0, -50, 0)
                                        particleEmitter.Orientation = Enum.ParticleOrientation.FacingCamera
                                      elseif p126 == "Snow" then
                                        particleEmitter.Texture = "rbxassetid://99851851"
                                        particleEmitter.Rate = 200

                                        particleEmitter.Color = ColorSequence.new(Color3.fromRGB(
                                          255, 255, 255
                                        ))

                                        particleEmitter.Size = NumberSequence.new(0.25, 0.35)
                                        particleEmitter.Speed = NumberRange.new(30, 30)
                                        particleEmitter.Lifetime = NumberRange.new(5, 10)
                                        particleEmitter.Acceleration = Vector3.new(0, 0, 0)
                                        particleEmitter.SpreadAngle = Vector2.new(50, 50)
                                        particleEmitter.LightEmission = 0.5
                                        particleEmitter.Rotation = NumberRange.new(0, 0)
                                        particleEmitter.RotSpeed = NumberRange.new(0, 0)
                                      elseif p126 == "Hell Fire" then
                                        particleEmitter.Texture = "rbxassetid://242205518"
                                        particleEmitter.Rate = 400

                                        particleEmitter.Color = ColorSequence.new(Color3.fromRGB(
                                          255, 100, 0
                                        ), Color3.fromRGB(
                                          150, 0, 0
                                        ))

                                        particleEmitter.Size = NumberSequence.new(2, 4)
                                        particleEmitter.Speed = NumberRange.new(40, 60)
                                        particleEmitter.Lifetime = NumberRange.new(2, 3)
                                        particleEmitter.Acceleration = Vector3.new(0, -10, 0)
                                        particleEmitter.RotSpeed = NumberRange.new(50, 100)
                                      end

                                      return
                                    end
                                  end

                                  function f48(p127)
                                    local v353 = v44[p127]

                                    if not v353 then
                                      return
                                    else
                                      for key26, value121 in pairs(lighting:GetChildren()) do
                                        if value121:IsA("Atmosphere") or value121:IsA("Clouds") then
                                          value121:Destroy()
                                        end
                                      end

                                      local sentinelSky = lighting:FindFirstChild("Sentinel_Sky")

                                      if not sentinelSky then
                                        for key27, value122 in pairs(lighting:GetChildren()) do
                                          if value122:IsA("Sky") then
                                            value122:Destroy()
                                          end
                                        end

                                        sentinelSky = Instance.new("Sky")
                                        sentinelSky.Name = "Sentinel_Sky"
                                        sentinelSky.Parent = lighting
                                      end

                                      sentinelSky.SkyboxBk = v353.SkyboxBk
                                      sentinelSky.SkyboxDn = v353.SkyboxDn
                                      sentinelSky.SkyboxFt = v353.SkyboxFt
                                      sentinelSky.SkyboxLf = v353.SkyboxLf
                                      sentinelSky.SkyboxRt = v353.SkyboxRt
                                      sentinelSky.SkyboxUp = v353.SkyboxUp
                                      sentinelSky.SunTextureId = ""
                                      sentinelSky.MoonTextureId = ""
                                      sentinelSky.StarCount = 0

                                      return
                                    end
                                  end

                                  sentinelWeatherSky = nil
                                  sentinelWeatherGround = nil

                                  v45 = {
                                    Ambient = lighting.Ambient,
                                    OutdoorAmbient = lighting.OutdoorAmbient,
                                    Brightness = lighting.Brightness,
                                    ClockTime = lighting.ClockTime,
                                    FogEnd = lighting.FogEnd,
                                    FogStart = lighting.FogStart,
                                    GlobalShadows = lighting.GlobalShadows,
                                  }

                                  function f49()
                                    if Toggles.EnableTime and Toggles.EnableTime.Value then
                                      lighting.ClockTime = Options.WorldClockTime.Value
                                    else
                                      lighting.ClockTime = v45.ClockTime
                                    end

                                    if Toggles.EnableBrightness
                                      and Toggles.EnableBrightness.Value then
                                      lighting.Brightness = Options.WorldBrightness.Value
                                    else
                                      lighting.Brightness = v45.Brightness
                                    end

                                    if Toggles.EnableColors and Toggles.EnableColors.Value then
                                      lighting.Ambient = Options.WorldAmbient.Value
                                      lighting.OutdoorAmbient = Options.WorldOutdoorAmbient.Value
                                    else
                                      lighting.Ambient = v45.Ambient
                                      lighting.OutdoorAmbient = v45.OutdoorAmbient
                                    end
                                  end

                                  local worldSection = worldTab:Section({
                                    Title = "World",
                                    Opened = true,
                                    Icon = "globe",
                                  })

                                  f61(worldSection, "EnableSkybox", "Enable Skybox", false, {
                                    Callback = function(value123)
                                      if value123 then
                                        if Toggles.Atmosphere and Toggles.Atmosphere.Value then
                                          Toggles.Atmosphere:SetValue(false)
                                        end

                                        f48(Options.SkyboxPreset.Value)
                                      end
                                    end,
                                  })

                                  f62(worldSection, "SkyboxPreset", "Skybox Preset", v352, "Night", false, {
                                    Callback = function(value124)
                                      if Toggles.EnableSkybox.Value then
                                        f48(value124)
                                      end
                                    end,
                                  })

                                  worldSection:Divider()

                                  f61(worldSection, "EnableWeather", "Enable Weather", false, {
                                    Callback = function(value125)
                                      if value125 then
                                        f23(Options.WeatherType.Value)
                                      else
                                        f23("None")
                                      end
                                    end,
                                  })

                                  f62(worldSection, "WeatherType", "Weather", { "None", "Rain", "Snow", "Hell Fire" }, "None", false, {
                                    Callback = function(value126)
                                      if Toggles.EnableWeather and Toggles.EnableWeather.Value then
                                        f23(value126)
                                      end
                                    end,
                                  })

                                  worldSection:Divider()

                                  f61(worldSection, "EnableTime", "Enable Time", false, {
                                    Callback = function(value127) f49() end,
                                  })

                                  f60(
                                    worldSection, "WorldClockTime", "Clock Time", 12, 0, 24, 0,
                                    "h", { Callback = function(value128) f49() end }
                                  )

                                  worldSection:Divider()

                                  f61(
                                    worldSection, "EnableBrightness", "Enable Brightness",
                                    false, { Callback = function(value129) f49() end }
                                  )

                                  f60(
                                    worldSection, "WorldBrightness", "Brightness", 2, 0, 10, 0,
                                    "x", { Callback = function(value130) f49() end }
                                  )

                                  worldSection:Divider()

                                  f61(worldSection, "EnableColors", "Enable Colors", false, {
                                    Callback = function(value131) f49() end,
                                  })

                                  f63(
                                    worldSection, "WorldAmbient", "Ambient Color",
                                    Color3.fromRGB(127, 127, 127),
                                    { Callback = function(value132) f49() end }
                                  )

                                  f63(
                                    worldSection, "WorldOutdoorAmbient", "Outdoor Color",
                                    Color3.fromRGB(127, 127, 127),
                                    { Callback = function(value133) f49() end }
                                  )

                                  task.spawn(function()
                                    while task.wait(1) do
                                      pcall(function()
                                        if Toggles.EnableSkybox and Toggles.EnableSkybox.Value then
                                          f48(Options.SkyboxPreset.Value)
                                        end

                                        f49()
                                      end)
                                    end
                                  end)

                                  runService.RenderStepped:Connect(function()
                                    if not workspaceService.CurrentCamera then
                                      return
                                    else
                                      local cframe = workspaceService.CurrentCamera.CFrame

                                      if sentinelWeatherSky then
                                        sentinelWeatherSky.CFrame = cframe
                                          * CFrame.new(0, 30, 0)
                                      end

                                      return
                                    end
                                  end)

                                  local color6 = Color3.fromRGB(255, 255, 255)
                                  local color7 = Color3.fromRGB(255, 255, 255)

                                  function f24(p128)
                                    if p128:IsA("BasePart") then
                                      if p128:GetAttribute("OriginalColor") then
                                        p128.Color = p128:GetAttribute("OriginalColor")
                                      end
                                    elseif p128:IsA("Texture") or p128:IsA("Decal") then
                                      if p128:GetAttribute("OriginalColor3") then
                                        p128.Color3 = p128:GetAttribute("OriginalColor3")
                                      end
                                    end
                                  end

                                  v46 = {
                                    WorldColorEnabled = false,
                                    WorldColor = color6,
                                    SkyColorEnabled = false,
                                    SkyColor = color7,
                                  }

                                  function f50(p129)
                                    local character6 = localPlayer.Character

                                    if character6
                                      and (p129 == character6 or p129:IsDescendantOf(character6)) then
                                      return true
                                    elseif p129:IsDescendantOf(workspaceService.CurrentCamera) then
                                      return true
                                    else
                                      if p129.Name == "CubeChecker_Physical"
                                        or p129.Name:find("Sentinel_") then
                                        return true
                                      end

                                      return false
                                    end
                                  end

                                  function f51(p130)
                                    if f50(p130) then
                                      return
                                    end

                                    if p130:IsA("BasePart") then
                                      if not p130:GetAttribute("OriginalColor") then
                                        p130:SetAttribute("OriginalColor", p130.Color)
                                      end

                                      p130.Color = v46.WorldColor
                                    elseif p130:IsA("Texture") or p130:IsA("Decal") then
                                      if not p130:GetAttribute("OriginalColor3") then
                                        p130:SetAttribute("OriginalColor3", p130.Color3)
                                      end

                                      p130.Color3 = v46.WorldColor
                                    end
                                  end

                                  function f52()
                                    for index62, value134 in ipairs(workspaceService:GetDescendants()) do
                                      if v46.WorldColorEnabled then
                                        f51(value134)
                                      else
                                        f24(value134)
                                      end
                                    end
                                  end

                                  workspaceService.DescendantAdded:Connect(function(descendant3)
                                    if v46.WorldColorEnabled then
                                      task.defer(function()
                                        if descendant3 and descendant3.Parent then
                                          f51(descendant3)
                                        end
                                      end)
                                    end
                                  end)

                                  runService.RenderStepped:Connect(function()
                                    if v46.SkyColorEnabled then
                                      local skyColor = v46.SkyColor

                                      lighting.Ambient = skyColor
                                      lighting.OutdoorAmbient = skyColor
                                      lighting.ColorShift_Bottom = skyColor
                                      lighting.ColorShift_Top = skyColor
                                      lighting.FogColor = skyColor

                                      local sentinelSky2 = lighting:FindFirstChild("SentinelSky")

                                      if not sentinelSky2 then
                                        sentinelSky2 = Instance.new("Atmosphere")
                                        sentinelSky2.Name = "SentinelSky"
                                        sentinelSky2.Parent = lighting
                                      end

                                      sentinelSky2.Color = skyColor
                                      sentinelSky2.Decay = skyColor
                                    else
                                      local sentinelSky3 = lighting:FindFirstChild("SentinelSky")

                                      if sentinelSky3 then
                                        sentinelSky3:Destroy()
                                      end
                                    end
                                  end)

                                  local nightModeSection = worldTab:Section({
                                    Title = "Night Mode",
                                    Opened = true,
                                    Icon = "moon",
                                  })

                                  f61(nightModeSection, "WorldColorToggle", "World Color", false, {
                                    Callback = function(value135)
                                      v46.WorldColorEnabled = value135
                                      f52()
                                    end,
                                  })

                                  f63(nightModeSection, "WorldColorPicker", "World Color", Color3.fromRGB(255, 255, 255), {
                                    Callback = function(value136)
                                      v46.WorldColor = value136

                                      if v46.WorldColorEnabled then
                                        f52()
                                      end
                                    end,
                                  })

                                  f61(nightModeSection, "SkyColorToggle", "Second Color", false, {
                                    Callback = function(value137)
                                      v46.SkyColorEnabled = value137
                                    end,
                                  })

                                  f63(nightModeSection, "SkyColorPicker", "Second Color", Color3.fromRGB(255, 255, 255), {
                                    Callback = function(value138) v46.SkyColor = value138 end,
                                  })

                                  local atmosphereFXSection = worldTab:Section({
                                    Title = "Atmosphere FX",
                                    Opened = true,
                                    Icon = "globe",
                                  })

                                  f61(atmosphereFXSection, "Atmosphere", "Enable", false, {
                                    Callback = function(value139)
                                      if value139 then
                                        if Toggles.EnableSkybox and Toggles.EnableSkybox.Value then
                                          Toggles.EnableSkybox:SetValue(false)
                                        end
                                      end
                                    end,
                                  })

                                  f60(
                                    atmosphereFXSection, "AtmosphereDensity",
                                    "Atmosphere Density", 30, 0, 100, 0, "%"
                                  )

                                  f60(
                                    atmosphereFXSection, "SubAtmosphereHaze", "Atmosphere Haze",
                                    0, 0, 100, 0, ""
                                  )

                                  f60(
                                    atmosphereFXSection, "AtmosphereGlare", "Atmosphere Glare",
                                    0, 0, 100, 0, ""
                                  )

                                  f61(
                                    atmosphereFXSection, "EnableColorCorrection",
                                    "Enabled Color Correction", false
                                  )

                                  f60(
                                    atmosphereFXSection, "SaturationSlider", "Saturation", 0,
                                    -100, 100, 0, "%"
                                  )

                                  f60(
                                    atmosphereFXSection, "ContrastSlider", "Contrast", 0, -100,
                                    100, 0, "%"
                                  )

                                  task.spawn(function()
                                    while task.wait(0.1) do
                                      pcall(function()
                                        if Toggles.Atmosphere and Toggles.Atmosphere.Value then
                                          if Toggles.EnableSkybox and Toggles.EnableSkybox.Value then
                                            Toggles.EnableSkybox:SetValue(false)
                                          end

                                          local atmosphere = lighting:FindFirstChildOfClass("Atmosphere")

                                          if not atmosphere then
                                            atmosphere = Instance.new("Atmosphere", lighting)
                                          end

                                          atmosphere.Density = (Options.AtmosphereDensity
                                                and Options.AtmosphereDensity.Value
                                              or 30)
                                            / 100

                                          atmosphere.Haze = (Options.SubAtmosphereHaze
                                                and Options.SubAtmosphereHaze.Value
                                              or 0)
                                            / 10

                                          atmosphere.Glare = (Options.AtmosphereGlare
                                                and Options.AtmosphereGlare.Value
                                              or 0)
                                            / 10
                                        end

                                        if Toggles.EnableColorCorrection
                                          and Toggles.EnableColorCorrection.Value then
                                          local colorCorrectionEffect = lighting:FindFirstChildOfClass("ColorCorrectionEffect")

                                          if not colorCorrectionEffect then
                                            colorCorrectionEffect = Instance.new(
                                              "ColorCorrectionEffect", lighting
                                            )
                                          end

                                          colorCorrectionEffect.Enabled = true

                                          colorCorrectionEffect.Saturation = (Options.SaturationSlider
                                                and Options.SaturationSlider.Value
                                              or 0)
                                            / 100

                                          colorCorrectionEffect.Contrast = (Options.ContrastSlider
                                                and Options.ContrastSlider.Value
                                              or 0)
                                            / 100
                                        else
                                          local colorCorrectionEffect2 = lighting:FindFirstChildOfClass("ColorCorrectionEffect")

                                          if colorCorrectionEffect2 then
                                            colorCorrectionEffect2.Enabled = false
                                          end
                                        end
                                      end)
                                    end
                                  end)

                                  if _G.WF_CircleZoneLoaded then
                                    warn("[ZoneESP] Already running, skipping re-inject.")
                                  else
                                    _G.WF_CircleZoneLoaded = true

                                    if not game:IsLoaded() then
                                      game.Loaded:Wait()
                                    end

                                    task.wait(1)

                                    if type(_G.Config) ~= "table" then
                                      _G.Config = {}
                                    end

                                    _G.Config.SmokeZoneESP = true
                                    _G.Config.MolotovZoneESP = true

                                    local function f75(p131, p132)
                                      if _G.Config[p131] == nil then
                                        _G.Config[p131] = p132
                                      end
                                    end

                                    f75("GrenadeESP", false)
                                    f75("GrenadeTracers", false)
                                    f75("ColoredSmoke", false)
                                    f75("NoSmoke", false)
                                    f75("SmokeColor", Color3.fromRGB(255, 0, 0))

                                    function f25()
                                      if Options and Options.SmokeZoneColor then
                                        return Options.SmokeZoneColor.Value
                                      end

                                      return Color3.fromRGB(180, 180, 180)
                                    end

                                    v47 = {
                                      Smoke = {
                                        RadiusTrim = 0,
                                        HeightOffset = 0.3,
                                        Segments = 40,
                                        Thickness = 0.28,
                                      },
                                      Molotov = {
                                        RadiusTrim = 4.5,
                                        HeightOffset = 0.3,
                                        Segments = 40,
                                        Thickness = 0.28,
                                      },
                                    }

                                    function f26()
                                      if Options and Options.GrenadeZoneColor then
                                        return Options.GrenadeZoneColor.Value
                                      end

                                      return Color3.fromRGB(255, 60, 0)
                                    end

                                    v48 = {}

                                    raycastParams2 = RaycastParams.new()
                                    raycastParams2.FilterType = Enum.RaycastFilterType.Exclude

                                    function f53(p133)
                                      local total = 0
                                      local total2 = 0
                                      local huge4 = math.huge
                                      local count15 = 0
                                      local v354 = {}

                                      for index63, value140 in ipairs(p133:GetChildren()) do
                                        if value140:IsA("BasePart") then
                                          count15 = count15 + 1
                                          total = total + value140.Position.X
                                          total2 = total2 + value140.Position.Z

                                          local v355 = value140.Position.Y
                                            - value140.Size.Y * 0.5

                                          if v355 < huge4 then
                                            huge4 = v355
                                          end

                                          table.insert(v354, value140)
                                        end
                                      end

                                      if count15 == 0 then
                                        return nil, nil, false
                                      else
                                        local v356 = total / count15
                                        local v357 = total2 / count15
                                        local v358 = 0

                                        for index64, value141 in ipairs(v354) do
                                          local v359 = value141.Position.X - v356
                                          local v360 = value141.Position.Z - v357

                                          local v361 = math.max(
                                            value141.Size.X, value141.Size.Z
                                          )

                                          local v362 = math.sqrt(v359 * v359 + v360 * v360)
                                            + v361 * 0.5

                                          if v362 > v358 then
                                            v358 = v362
                                          end
                                        end

                                        return Vector3.new(v356, huge4, v357), math.max(v358, 1.2), true
                                      end
                                    end

                                    function f27(color8, p134)
                                      local sentinelRingSeg = Instance.new("Part")
                                      sentinelRingSeg.Name = "Sentinel_RingSeg"
                                      sentinelRingSeg.Anchored = true
                                      sentinelRingSeg.CanCollide = false
                                      sentinelRingSeg.CanQuery = false
                                      sentinelRingSeg.CastShadow = false
                                      sentinelRingSeg.Material = Enum.Material.Neon
                                      sentinelRingSeg.Color = color8
                                      sentinelRingSeg.Transparency = 1
                                      sentinelRingSeg.Shape = Enum.PartType.Cylinder
                                      sentinelRingSeg.Size = Vector3.new(p134, p134, p134)
                                      sentinelRingSeg.Parent = workspace

                                      return sentinelRingSeg
                                    end

                                    function f54(p135, p136, p137, p138)
                                      raycastParams2.FilterDescendantsInstances = p138 or {}

                                      local raycast2 = workspace:Raycast(Vector3.new(
                                        p135, p136 + 5, p137
                                      ), Vector3.new(0, -14, 0), raycastParams2)

                                      return raycast2 and raycast2.Position.Y or p136
                                    end

                                    function f55(p139, p140, p141)
                                      local f76, segments3, thickness3, v363, v364, v365, v366,
                                        f77, connect3

                                      if v48[p139] then
                                        return
                                      else
                                        segments3 = p140.Segments or 40
                                        thickness3 = p140.Thickness or 0.28
                                        local v367 = p141 and f26() or f25()
                                        v363 = {}
                                        v364 = {}

                                        for i12 = 1, segments3 do
                                          local v368 = f27(v367, thickness3)
                                          table.insert(v363, v368)
                                          table.insert(v364, v368)
                                        end

                                        v365 = {
                                          cylinders = v363,
                                          allParts = v364,
                                          cfg = p140,
                                          isMolotov = p141,
                                          lastRecalc = 0,
                                          lastRadius = 1,
                                          alive = true,
                                          fadingOut = false,
                                          fadeAlpha = 0,
                                        }

                                        v48[p139] = v365
                                        local v369 = tick()

                                        function f76()
                                          if v365.fadingOut then
                                            return v365.fadeAlpha
                                          end

                                          return math.clamp((tick() - v366) / 0.4, 0, 1)
                                        end

                                        v366 = v369

                                        function f77()
                                          if v365.fadingOut then
                                            return
                                          end

                                          v365.fadingOut = true
                                          v365.fadeAlpha = f76()

                                          local v370 = tick()
                                          local fadeAlpha = v365.fadeAlpha

                                          local connect4 = nil

                                          connect4 = runService.Heartbeat:Connect(function()
                                            local v371 = math.clamp((tick() - v370) / 0.6, 0, 1)
                                            v365.fadeAlpha = fadeAlpha * (1 - v371)
                                            local transparency2 = 1 - v365.fadeAlpha

                                            for index65, value142 in ipairs(v363) do
                                              local v372 = value142

                                              pcall(function()
                                                v372.Transparency = transparency2
                                              end)
                                            end

                                            if v371 >= 1 then
                                              connect4:Disconnect()
                                              v365.alive = false

                                              for index66, value143 in ipairs(v363) do
                                              end

                                              v48[p139] = nil
                                            end
                                          end)
                                        end

                                        p139.AncestryChanged:Connect(function(p142, p143)
                                          if p143 == nil then
                                            f77()
                                          end
                                        end)

                                        connect3 = nil

                                        connect3 = runService.Heartbeat:Connect(function()
                                          if not v365.alive then
                                            connect3:Disconnect()
                                            return
                                          end

                                          if not p139 or not p139.Parent then
                                            connect3:Disconnect()
                                            f77()
                                            return
                                          else
                                            local v373 = tick()

                                            if v373 - v365.lastRecalc < 0.05 then
                                              return
                                            else
                                              v365.lastRecalc = v373
                                              local v374, v375, v376 = f53(p139)

                                              if not v376 then
                                                return
                                              else
                                                local radiusTrim = p140.RadiusTrim

                                                local v377 = v365.lastRadius
                                                  + (v375 - v365.lastRadius) * 0.25

                                                v365.lastRadius = v377

                                                local v378 = math.max(
                                                  v377 - (radiusTrim or 0), 0.8
                                                )

                                                local transparency3 = 1 - f76()

                                                local isMolotov = v365.isMolotov and f26()
                                                  or f25()

                                                for index67, value144 in ipairs(v363) do
                                                  local v379 = 2 * math.pi
                                                    * ((index67 - 1) / segments3)

                                                  local v380 = 2 * math.pi
                                                    * (index67 / segments3)

                                                  local v381 = (v379 + v380) / 2
                                                  local v382 = v374.X + math.cos(v379) * v378
                                                  local v383 = v374.Z + math.sin(v379) * v378
                                                  local v384 = v374.X + math.cos(v380) * v378
                                                  local v385 = v374.Z + math.sin(v380) * v378
                                                  local v386 = math.cos(v381)
                                                  local v387 = math.sin(v381)

                                                  local v388 = f54(v382, v374.Y, v383, v364)
                                                    + (p140.HeightOffset or 0.3)

                                                  local v389 = f54(v384, v374.Y, v385, v364)
                                                    + (p140.HeightOffset or 0.3)

                                                  local vector7 = Vector3.new(v382, v388, v383)
                                                  local vector8 = Vector3.new(v384, v389, v385)

                                                  local vector9 = Vector3.new(v374.X
                                                    + v386 * v378, (v388 + v389) * 0.5, v374.Z
                                                    + v387 * v378)

                                                  local v390 = vector8 - vector7
                                                  local magnitude4 = v390.Magnitude

                                                  if magnitude4 < 0.001 then
                                                  else
                                                    local cframe2 = CFrame.lookAt(
                                                      vector9, vector9 + v390
                                                    )

                                                    local v391 = math.rad(90)

                                                    value144.CFrame = cframe2
                                                      * CFrame.Angles(0, v391, 0)

                                                    value144.Size = Vector3.new(
                                                      magnitude4, thickness3, thickness3
                                                    )

                                                    value144.Color = isMolotov
                                                    value144.Transparency = transparency3
                                                  end
                                                end

                                                return
                                              end
                                            end
                                          end
                                        end)

                                        v365.updateConn = connect3
                                        return
                                      end
                                    end

                                    function f28(p144)
                                      if not p144 or not p144.Parent then
                                        return
                                      elseif v49[p144] then
                                        return
                                      else
                                        local lower = p144.Name:lower()

                                        local firezone = lower:find("firezone")
                                          or lower:find("fire_zone") or lower:find("molotov")
                                          or lower:find("voxelfire") or lower:find("ignite")
                                          or lower:find("flamezone") or lower:find("firearea")
                                          or lower:find("burnzone")

                                        local smokezone = lower:find("smokezone")
                                          or lower:find("smoke_zone")
                                          or lower:find("voxelsmoke") or lower:find("smokearea")
                                          or lower:find("gaszone")

                                        if firezone and f56("MolotovZoneESP") then
                                          v49[p144] = true
                                          f55(p144, v47.Molotov, true)

                                          p144.AncestryChanged:Connect(function(p145, p146)
                                            if p146 == nil then
                                              v49[p144] = nil
                                            end
                                          end)
                                        elseif smokezone and f56("SmokeZoneESP") then
                                          v49[p144] = true
                                          f55(p144, v47.Smoke, false)

                                          p144.AncestryChanged:Connect(function(p147, p148)
                                            if p148 == nil then
                                              v49[p144] = nil
                                            end
                                          end)
                                        end

                                        return
                                      end
                                    end

                                    function f56(p149)
                                      if Toggles and Toggles[p149] then
                                        return Toggles[p149].Value
                                      end

                                      return false
                                    end

                                    v49 = {}

                                    function f57(p150)
                                      if not p150 then
                                        return
                                      end

                                      for index68, value145 in ipairs(p150:GetChildren()) do
                                        f28(value145)

                                        for index69, value146 in ipairs(value145:GetChildren()) do
                                          f28(value146)
                                        end
                                      end

                                      p150.ChildAdded:Connect(function(child)
                                        task.wait()
                                        f28(child)

                                        child.ChildAdded:Connect(function(child2)
                                          task.wait()
                                          f28(child2)
                                        end)
                                      end)
                                    end

                                    task.spawn(function()
                                      task.wait(1)
                                      f57(workspaceService)
                                      local debris = workspaceService:FindFirstChild("Debris")

                                      if debris then
                                        f57(debris)
                                      end

                                      local effects = workspaceService:FindFirstChild("Effects")

                                      if effects then
                                        f57(effects)
                                      end

                                      local fx = workspaceService:FindFirstChild("FX")

                                      if fx then
                                        f57(fx)
                                      end

                                      workspaceService.ChildAdded:Connect(function(child3)
                                        local lower2 = child3.Name:lower()

                                        if lower2 == "debris" or lower2 == "effects"
                                          or lower2 == "fx" then
                                          f57(child3)
                                        end

                                        task.wait()
                                        f28(child3)

                                        child3.ChildAdded:Connect(function(child4)
                                          task.wait()
                                          f28(child4)
                                        end)
                                      end)

                                      while task.wait(3) do
                                        for index70, value147 in ipairs(workspaceService:GetChildren()) do
                                          f28(value147)

                                          for index71, value148 in ipairs(value147:GetChildren()) do
                                            f28(value148)
                                          end
                                        end
                                      end
                                    end)
                                  end

                                  function f29(p151)
                                    if not p151 or not p151:IsA("BasePart") then
                                      return
                                    end

                                    if v50[p151] then
                                      return
                                    end

                                    local v392 = {}
                                    local v393 = {}

                                    for i13 = 1, 30 do
                                      local line10 = Drawing.new("Line")
                                      line10.Visible = false
                                      line10.Thickness = 2
                                      line10.Transparency = 1

                                      v393[i13] = line10
                                    end

                                    v50[p151] = v393

                                    local connect5 = nil

                                    connect5 = runService.RenderStepped:Connect(function()
                                      local value149 = Toggles and Toggles.GrenadeTracers
                                        and Toggles.GrenadeTracers.Value

                                      local value150 = Options and Options.GrenadeTracerColor
                                          and Options.GrenadeTracerColor.Value
                                        or Color3.fromRGB(255, 100, 0)

                                      if not p151 or not p151.Parent then
                                        connect5:Disconnect()
                                        v50[p151] = nil

                                        for index72, value151 in ipairs(v393) do
                                          local v394 = value151
                                          pcall(function() v394:Remove() end)
                                        end

                                        return
                                      elseif not value149 then
                                        for index73, value152 in ipairs(v393) do
                                          value152.Visible = false
                                        end

                                        return
                                      else
                                        table.insert(v392, 1, p151.Position)

                                        if #v392 > 31 then
                                          table.remove(v392)
                                        end

                                        local currentCamera8 = workspace.CurrentCamera

                                        for i14 = 1, 30 do
                                          local v395 = v393[i14]
                                          local v396 = v392[i14]
                                          local v397 = not v396
                                          local v398 = v392[i14 + 1]

                                          if v397 or not v398 then
                                            v395.Visible = false
                                          else
                                            local v399, v400 = currentCamera8:WorldToViewportPoint(v396)
                                            local v401, v402 = currentCamera8:WorldToViewportPoint(v398)

                                            if (v400 or v402) and v399.Z > 0 and v401.Z > 0 then
                                              local v403 = 1 - i14 / 30

                                              v395.From = Vector2.new(v399.X, v399.Y)
                                              v395.To = Vector2.new(v401.X, v401.Y)
                                              v395.Color = value150
                                              v395.Thickness = math.max(2 * v403, 0.5)
                                              v395.Transparency = 1 - v403
                                              v395.Visible = true
                                            else
                                              v395.Visible = false
                                            end
                                          end
                                        end

                                        return
                                      end
                                    end)
                                  end

                                  v50 = {}
                                  v51 = {}

                                  v52 = {
                                    "grenade", "flash", "molotov", "bang", "frag", "he_", "_he",
                                    "throwable", "projectile", "nade", "incendiary", "decoy",
                                    "c4",
                                  }

                                  function f30(p152)
                                    if not p152:IsA("BasePart") and not p152:IsA("Model") then
                                      return false
                                    else
                                      local lower3 = p152.Name:lower()

                                      for index74, value153 in ipairs(v53) do
                                        if lower3:find(value153) then
                                          return false
                                        end
                                      end

                                      if #lower3 > 20 and lower3:find("%-") then
                                        return true
                                      end

                                      for index75, value154 in ipairs(v52) do
                                        if lower3:find(value154) then
                                          return true
                                        end
                                      end

                                      return false
                                    end
                                  end

                                  v53 = {
                                    "gun", "rifle", "pistol", "bullet", "casing", "debris",
                                    "light", "muzzle", "launch", "effect", "arm", "leg",
                                    "torso", "head", "humanoid", "mesh", "handle", "constraint",
                                    "weld", "motor", "zone", "voxel",
                                  }

                                  function f31(p153)
                                    if not p153 then
                                      return
                                    end

                                    for index76, value155 in ipairs(p153:GetChildren()) do
                                      if f30(value155) then
                                        f58(value155)
                                      end

                                      if value155:IsA("Model") then
                                        for index77, value156 in ipairs(value155:GetChildren()) do
                                          if f30(value156) then
                                            f58(value156)
                                          end
                                        end
                                      end
                                    end
                                  end

                                  function f58(p154)
                                    local connect6

                                    if v51[p154] then
                                      return
                                    else
                                      local handle = p154

                                      if p154:IsA("Model") then
                                        handle = p154:FindFirstChild("Handle")
                                          or p154:FindFirstChildWhichIsA("BasePart")
                                      end

                                      if not handle or not handle:IsA("BasePart") then
                                        return
                                      elseif handle.Size.Magnitude > 8 then
                                        return
                                      else
                                        if players:GetPlayerFromCharacter(p154) then
                                          return
                                        end

                                        if players:GetPlayerFromCharacter(p154.Parent) then
                                          return
                                        end

                                        v51[p154] = true

                                        connect6 = nil

                                        connect6 = p154.AncestryChanged:Connect(function(p155, p156)
                                          if p156 == nil then
                                            v51[p154] = nil
                                            connect6:Disconnect()
                                          end
                                        end)

                                        f29(handle)
                                        return
                                      end
                                    end
                                  end

                                  task.spawn(function()
                                    task.wait(0.5)
                                    f31(workspaceService)

                                    for index78, value157 in ipairs({
                                      "Debris", "Effects", "FX", "Projectiles", "Grenades",
                                    }) do
                                      local findFirstChild9 = workspaceService:FindFirstChild(value157)

                                      if findFirstChild9 then
                                        f31(findFirstChild9)

                                        findFirstChild9.ChildAdded:Connect(function(child5)
                                          task.wait()

                                          if f30(child5) then
                                            f58(child5)
                                          end
                                        end)
                                      end
                                    end

                                    workspaceService.ChildAdded:Connect(function(child6)
                                      task.wait()

                                      if f30(child6) then
                                        f58(child6)
                                      end

                                      local lower4 = child6.Name:lower()

                                      if lower4 == "debris" or lower4 == "effects"
                                        or lower4 == "fx" or lower4 == "projectiles"
                                        or lower4 == "grenades" then
                                        f31(child6)

                                        child6.ChildAdded:Connect(function(child7)
                                          task.wait()

                                          if f30(child7) then
                                            f58(child7)
                                          end
                                        end)
                                      end

                                      child6.ChildAdded:Connect(function(child8)
                                        task.wait()

                                        if f30(child8) then
                                          f58(child8)
                                        end
                                      end)
                                    end)
                                  end)

                                  configManager = window.ConfigManager
                                  v54 = nil
                                  v55 = ""

                                  v56 = f62(
                                    configsTab, "ConfigSelection", "Config",
                                    configManager:AllConfigs(), nil, false,
                                    { Callback = function(value158) v54 = value158 end }
                                  )

                                  configsTab:Space()

                                  f65(
                                    configsTab, "NewConfigName", "New Config Name", "",
                                    "Enter a name for your new config...",
                                    { Callback = function(value159) v55 = value159 or "" end }
                                  )

                                  configsTab:Space()

                                  local group = configsTab:Group({})

                                  group:Button({
                                    Title = "Create",
                                    Icon = "plus",
                                    Justify = "Center",
                                    Callback = function()
                                      local gsub = tostring(v55 or ""):gsub("^%s+", ""):gsub(
                                        "%s+$", ""
                                      )

                                      if gsub == "" then
                                        dist:Notify({
                                          Title = "Error",
                                          Content = "Donner d'abord un nom à votre config",
                                          Icon = "x",
                                          Duration = 4,
                                        })

                                        return
                                      else
                                        local allConfigs = configManager:AllConfigs()

                                        if table.find(allConfigs, gsub) then
                                          dist:Notify({
                                            Title = "Error",
                                            Content = "Cette config existe déjà",
                                            Icon = "x",
                                            Duration = 6,
                                          })

                                          return
                                        end

                                        window.CurrentConfig = configManager:CreateConfig(gsub)

                                        if window.CurrentConfig:Save() then
                                          dist:Notify({
                                            Title = "Config Created",
                                            Content = "Config '" .. gsub
                                              .. "' created successfully",
                                            Icon = "check",
                                            Duration = 4,
                                          })

                                          if v56 and v56.Refresh then
                                            v56:Refresh(configManager:AllConfigs())
                                          end

                                          if v56 and v56.Set then
                                            pcall(function() v56:Set(gsub) end)
                                          end

                                          v54 = gsub
                                          v55 = ""

                                          if v19.Elements.NewConfigName
                                            and v19.Elements.NewConfigName.Set then
                                            pcall(function()
                                              v19.Elements.NewConfigName:Set("")
                                            end)
                                          end
                                        end

                                        return
                                      end
                                    end,
                                  })

                                  group:Space()

                                  group:Button({
                                    Title = "Load",
                                    Icon = "refresh-cw",
                                    Justify = "Center",
                                    Callback = function()
                                      if not v54 or v54 == "" then
                                        dist:Notify({
                                          Title = "Error",
                                          Content = "Select a config first",
                                          Icon = "x",
                                          Duration = 4,
                                        })

                                        return
                                      end

                                      window.CurrentConfig = configManager:CreateConfig(v54)

                                      if window.CurrentConfig:Load() then
                                        dist:Notify({
                                          Title = "Config Loaded",
                                          Content = "Config '" .. v54 .. "' loaded",
                                          Icon = "refresh-cw",
                                          Duration = 4,
                                        })
                                      end
                                    end,
                                  })

                                  group:Space()

                                  group:Button({
                                    Title = "Delete",
                                    Icon = "trash",
                                    Justify = "Center",
                                    Callback = function()
                                      if not v54 or v54 == "" then
                                        dist:Notify({
                                          Title = "Error",
                                          Content = "Select a config first",
                                          Icon = "x",
                                          Duration = 4,
                                        })

                                        return
                                      end

                                      local v404 = false

                                      if not v404 and configManager.DeleteConfig then
                                        if pcall(function() configManager:DeleteConfig(v54) end) then
                                          v404 = true
                                        end
                                      end

                                      if not v404 then
                                        pcall(function()
                                          local config = configManager:Config(v54)

                                          if config and config.Delete then
                                            config:Delete()
                                            v404 = true
                                          end
                                        end)
                                      end

                                      dist:Notify({
                                        Title = "Config Deleted",
                                        Content = "Config '" .. v54 .. "' deleted",
                                        Icon = "trash",
                                        Duration = 4,
                                      })

                                      if v56 and v56.Refresh then
                                        v56:Refresh(configManager:AllConfigs())
                                      end

                                      if v56 and v56.Set then
                                        pcall(function() v56:Set(nil) end)
                                      end

                                      v54 = nil
                                    end,
                                  })

                                  task.wait(0.5)

                                  pcall(function()
                                    dist:Notify({
                                      Title = "News",
                                      Content = "Silent Aim & Wallbang Fixed. Added some ESP (credits to Wurfef)",
                                      Icon = "newspaper",
                                      Duration = 8.3,
                                    })
                                  end)

                                  return
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
