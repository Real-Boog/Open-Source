local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local lighting = game:GetService("Lighting")
local teleportService = game:GetService("TeleportService")
local coreGui = game:GetService("CoreGui")
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"))()
local themeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua"))()
local saveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/SaveManager.lua"))()
local options = library.Options

local v1 = {
  conns = {},
  drawings = {},
  highlights = {},
  dead = false,
}

_G.OxideStealAnEgg = v1

local function f1(p1)
  if p1 then
    table.insert(v1.drawings, p1)
  end

  return p1
end

local function f2(p2)
  table.insert(v1.conns, p2)
  return p2
end

local v2 = "stealanegg"
local v3 = game

local function f3(p3, p4, p5)
  local v4 = {}

  for key, value in pairs(p3) do
    if type(value) == "string" then
      if value:match("^X%-%d+$") then
        v4.marker = v4.marker or key
      elseif p4 and value == p4 then
        v4.arg1 = v4.arg1 or key
      elseif p5 and value == p5 then
        v4.arg2 = v4.arg2 or key
      end
    end
  end

  return v4
end

local v5 = v3:GetService("Workspace")
local v6 = game

local function f4(p6)
  local v7 = p6 % 1000
  return math.floor(v7 / 100), math.floor(v7 / 10) % 10, v7 % 10
end

local virtualUser = v6:GetService("VirtualUser")
local localPlayer = players.LocalPlayer

local function f5(p7)
  if p7.state and p7.map.arg2 then
    local v8, v9 = pcall(rawget, p7.state, p7.map.arg2)

    if type(v9) == "string" then
      p7.arg2 = v9
    end
  end

  return p7.arg2
end

local function f6()
  return v5.CurrentCamera or v5:FindFirstChildOfClass("Camera")
end

pcall(function()
  f2(coreGui.ChildAdded:Connect(function(child)
    if child.Name == "PurchasePrompt" then
      task.wait(0.04)

      pcall(function()
        local findFirstChild = child:FindFirstChild("CancelButton", true)

        if findFirstChild and typeof(findFirstChild) == "Instance"
          and findFirstChild:IsA("GuiButton") then
          pcall(function() findFirstChild.MouseButton1Click:Fire() end)
        end
      end)
    end
  end))
end)

local function f7(p8, p9, p10, p11)
end

local function f8(p12)
  return function(...)
    local v10, v11 = pcall(p12, ...)

    if not v10 then
      pcall(f7, "Exium HUB", "Error: " .. tostring(v11), "Error", 4)
    end
  end
end

pcall(function()
  if typeof(filtergc) ~= "function" or typeof(debug) ~= "table"
    or typeof(debug.getupvalues) ~= "function" then
    return false, "no filtergc"
  else
    local v12, v13 = pcall(function()
      return filtergc("function", { Constants = { "gmatch", "GetFullName" } }, true)
    end)

    if not v12 or type(v13) ~= "function" then
      return false, "filter miss"
    else
      local v14 = typeof(setrawmetatable) == "function" and setrawmetatable
        or typeof(setmetatable) == "function" and setmetatable

      if not v14 then
        return false, "no setmeta"
      else
        local count = 0
        local v15, v16 = pcall(debug.getupvalues, v13)

        if not v15 or type(v16) ~= "table" then
          return false, "no upvalues"
        end

        for key2, value2 in pairs(v16) do
          if typeof(value2) == "table" then
            if pcall(v14, value2, { __newindex = function() end }) then
              count = count + 1
            end
          end
        end

        return count > 0, count
      end
    end
  end
end)

local function f9(p13, p14)
  local v17 = getgc or debug and debug.getgc

  if type(v17) ~= "function" then
    return
  else
    local v18, v19 = pcall(v17, true)

    if not v18 or type(v19) ~= "table" then
      return
    else
      local v20 = #v19
      local v21 = p14 or 400
      local count2 = 0

      while true do
        count2 = 1 + count2

        if not (v20 >= count2) then
          break
        end

        local v22 = count2
        local v23 = v19[v22]
        v19[v22] = nil
        local v24, v25 = pcall(p13, v23)

        if v24 and v25 == true then
          return
        elseif v22 % v21 == 0 then
          task.wait()
        end
      end

      return
    end
  end
end

local v26 = {}

function v26.FreezeTables()
  local v27 = setrawmetatable or setmetatable
  local v28 = getrawmetatable or getmetatable

  if not v27 then
    return
  end

  f9(function(p15)
    if typeof(p15) ~= "table" or v28 and v28(p15) then
      return
    else
      local v29 = false

      for key3, value3 in pairs(p15) do
        if value3 == p15 then
          v29 = true
          break
        end
      end

      if not v29 then
        return
      end

      for key4, value4 in pairs(p15) do
        if typeof(value4) == "number" and value4 >= 1 and value4 <= 3 and p15[value4] == nil then
          pcall(v27, p15, { __newindex = function() end })
          break
        end
      end

      return
    end
  end)
end

function v26.WipeUGI()
  local v30 = getconstants or debug and debug.getconstants
  local v31 = setconstant or debug and debug.setconstant
  local v32 = islclosure or function(p16) return not pcall(setfenv, getfenv(p16)) end

  if not (v30 and v31 and debug and debug.info) then
    return
  end

  f9(function(p17)
    if typeof(p17) ~= "function" or not v32(p17) then
      return
    else
      local v33, v34 = pcall(debug.info, p17, "s")

      if not v33 or type(v34) ~= "string" then
        return
      end

      if not v34:find("ReplicatedFirst", 1, true) or not v34:find("UGI", 1, true) then
        return
      else
        local v35, v36 = pcall(v30, p17)

        if not v35 or type(v36) ~= "table" then
          return
        end

        for key5, value5 in next, v36, nil do
          if type(value5) == "string" and value5 == "Humanoid" then
            pcall(v31, p17, key5, "")
          end
        end

        return
      end
    end
  end)
end

function v26.ScrubX14()
  local v37 = getconstants or debug and debug.getconstants
  local v38 = islclosure or function(p18) return not pcall(setfenv, getfenv(p18)) end
  local v39 = hookfunction or replaceclosure or hookfunc

  if not (v37 and v39 and debug and debug.getstack and debug.setstack) then
    return
  end

  f9(function(p19)
    local v40 = typeof(p19) ~= "function"
    local v41

    if v40 or not v38(p19) then
      return
    else
      local v42, v43 = pcall(v37, p19)

      if not v42 or type(v43) ~= "table" or not table.find(v43, "X-14") then
        return
      end

      v41 = nil

      pcall(function()
        v41 = v39(p19, function(...)
          if v41 then
            return v41(...)
          end
        end)
      end)

      return
    end
  end)
end

function v26.SanitizeState()
  local v44 = islclosure or function(p20) return not pcall(setfenv, getfenv(p20)) end
  local v45 = getupvalues or debug and debug.getupvalues
  local v46 = getupvalue or debug and debug.getupvalue
  local v47 = setupvalue or debug and debug.setupvalue
  local v48 = clonefunction or function(fn) return function(...) return fn(...) end end

  if not (v45 and v46 and v47) then
    return
  end

  f9(function(p21)
    local v49 = typeof(p21) ~= "function"
    local v50

    if v49 or not v44(p21) then
      return
    else
      local v51, v52 = pcall(v45, p21)

      if not v51 or type(v52) ~= "table" or #v52 ~= 19 then
        return
      else
        local v53, v54 = pcall(v46, p21, 2)

        if not v53 or typeof(v54) ~= "function" then
          return
        end

        v50 = v48(v54)

        pcall(v47, p21, 2, function(p22, p23)
          if p23 and typeof(p23) == "table" then
            pcall(setmetatable, p23, {})
          end

          return v50(p22, p23)
        end)

        return
      end
    end
  end)
end

task.spawn(function()
  pcall(v26.FreezeTables)
  task.wait()
  pcall(v26.WipeUGI)
  task.wait()
  pcall(v26.ScrubX14)
  task.wait()
  pcall(v26.SanitizeState)
end)

local function f10()
  local character = localPlayer.Character
  return character and character:FindFirstChildOfClass("Humanoid")
end

local function f11()
  local character2 = localPlayer.Character

  return character2
    and (character2:FindFirstChild("HumanoidRootPart") or character2.PrimaryPart
      or character2:FindFirstChildWhichIsA("BasePart"))
end

local bxor = bit32.bxor

local function f12(p24, p25)
  if type(p24) ~= "table" then
    return false
  end

  local v55 = false
  local v56 = false

  return pcall(function()
    for key6, value6 in pairs(p24) do
      if value6 == p25 then
        v55 = true
      elseif type(value6) == "string" and value6:match("^X%-%d+$") then
        v56 = true
      end
    end
  end) and v55 and v56
end

local v57 = table.unpack

local function f13(p26)
  return #p26 == 36 and p26:sub(9, 9) == "-" and p26:sub(14, 14) == "-"
    and p26:sub(19, 19) == "-" and p26:sub(24, 24) == "-"
    and p26:gsub("-", ""):match("^%x+$") ~= nil
end

local v58 = {}
local v59

local function f14()
  for index, value7 in ipairs(game:GetChildren()) do
    local v60, v61 = pcall(value7.GetDescendants, value7)

    if v60 and v61 then
      for index2, value8 in ipairs(v61) do
        if value8:IsA("RemoteEvent") and f13(value8.Name) then
          v58[value8] = true
          v59 = v59 or value8
        end
      end
    end
  end
end

f14()

local function f15(p27)
  if type(p27) ~= "string" then
    return
  else
    local xD = p27:match("^X%-(%d+)$")
    return xD and tonumber(xD)
  end
end

local function f16(p28)
  local v62 = 1

  while true do
    v62 = 1 + v62

    if not (24 >= v62) then
      break
    end

    local v63, v64 = pcall(debug.info, v62, "f")

    if type(v64) == "function" then
      local v65, v66 = pcall(debug.getupvalues, v64)

      if type(v66) == "table" then
        for key7, value9 in pairs(v66) do
          local v67 = value9

          if f12(v67, p28) then
            return v67
          elseif type(v67) == "table" then
            local v68

            pcall(function()
              for key8, value10 in pairs(v67) do
                if f12(value10, p28) then
                  v68 = value10
                  return
                end
              end
            end)

            if v68 then
              return v68
            end
          end
        end
      end
    end
  end
end

local function f17(p29)
  if p29.state and p29.map.marker then
    local v69 = { pcall(rawget, p29.state, p29.map.marker) }
    local v70 = f15(v69[2])

    if v70 and math.abs(v70 - os.time() - p29.offset) <= 5 then
      return v70
    end

    return os.time() + p29.offset
  end

  return os.time() + p29.offset
end

local f18

local function f19(p30, p31, p32)
  local v71 = f16(p30)

  if not v71 then
    return
  else
    local v72 = f3(v71, p31, p32)

    if not v72.marker then
      return
    else
      local v73 = f15(rawget(v71, v72.marker))

      if not v73 then
        return
      else
        local v74, v75, v76 = f4(v73)

        local v77 = {
          state = v71,
          map = v72,
          remote = p30,
          prefix = p31:sub(1, 9),
          k1 = bxor(p31:byte(10), v74),
          k2 = bxor(p31:byte(11), v75),
          k3 = bxor(p31:byte(12), v76),
          offset = v73 - os.time(),
          arg2 = p32,
        }

        if f18(v77, v73) == p31 then
          return v77
        end

        return
      end
    end
  end
end

function f18(p33, p34)
  local v78, v79, v80 = f4(p34)
  return p33.prefix .. string.char(bxor(v78, p33.k1), bxor(v79, p33.k2), bxor(v80, p33.k3))
end

local v81 = hookfunction or replaceclosure or hookfunc or detour_function
local v82, v83

if v59 and v81 then
  v83 = nil

  v83 = v81(v59.FireServer, function(p35, ...)
    local v84 = table.pack(...)

    if not v58[p35] then
      return v83(p35, v57(v84, 1, v84.n))
    else
      local v85 = v84[1]

      if type(v85) == "string" and #v85 == 12 then
        if not v82 then
          v82 = f19(p35, v85, v84[2])
        else
          local v86 = f15(rawget(v82.state, v82.map.marker))

          if v86 and f18(v82, v86) ~= v85 then
            local v87 = f19(p35, v85, v84[2])

            if v87 then
              v87.spoofed = v82.spoofed
              v82 = v87
            end
          end
        end

        return v83(p35, v57(v84, 1, v84.n))
      end

      if v82 and type(v85) == "string" and #v85 == 4 then
        v84[1] = f18(v82, (f17(v82)))
        v84[2] = f5(v82)

        v82.spoofed = (v82.spoofed or 0) + 1
        return v83(p35, v57(v84, 1, math.max(v84.n, 2)))
      end

      return v83(p35, v57(v84, 1, v84.n))
    end
  end)
end

task.spawn(function()
  while not v1.dead do
    task.wait(10)
    local v88 = false

    for key9 in pairs(v58) do
      if key9:IsDescendantOf(game) then
        v88 = true
        break
      end
    end

    if not v88 then
      table.clear(v58)
      v59 = nil
      v82 = nil
      f14()
    end
  end
end)

task.spawn(function()
  local v89 = getgc or debug and debug.getgc
  local v90, f20

  if not v89 then
    return
  else
    v90 = nil
    local v91 = 0

    function f20()
      local v92

      f9(function(p36)
        if v92 then
          return true
        end

        if type(p36) ~= "table" then
          return
        end

        local v93 = false

        pcall(function()
          v93 = rawget(p36, "ValidationLocked") ~= nil and rawget(p36, "Evidence") ~= nil
            or rawget(p36, "ThreatLevel") ~= nil and rawget(p36, "LastObservedSample") ~= nil
        end)

        if v93 then
          v92 = p36
          return true
        end
      end, 250)

      return v92
    end

    f2(localPlayer.CharacterAdded:Connect(function()
      task.wait(1)
      v90 = f20()
    end))

    while not v1.dead do
      if not v90 then
        v90 = f20()

        if not v90 then
          v91 = v91 + 1
          local v94 = math.min(5 * 2 ^ math.min(v91 - 1, 3), 30)
          local total = 0

          while total < v94 and not v1.dead do
            task.wait(0.5)
            total = total + 0.5
          end
        elseif v91 > 0 then
          v91 = 0
        end
      end

      if v90 then
        pcall(function()
          local v95 = rawget(v90, "Evidence")

          if rawget(v90, "ThreatLevel") ~= "Trusted" then
            rawset(v90, "ThreatLevel", "Trusted")
          end

          if rawget(v90, "ValidationLocked") == true then
            rawset(v90, "ValidationLocked", false)
          end

          if rawget(v90, "FirstSuspiciousAt") ~= nil then
            rawset(v90, "FirstSuspiciousAt", nil)
          end

          if rawget(v90, "KickQueued") == true then
            rawset(v90, "KickQueued", false)
          end

          if rawget(v90, "TamperScore") ~= nil then
            rawset(v90, "TamperScore", 0)
          end

          if rawget(v90, "InvalidHeartbeatCount") ~= nil then
            rawset(v90, "InvalidHeartbeatCount", 0)
          end

          local v96 = rawget(v90, "LastObservedSample")

          if v96 ~= nil then
            if rawget(v90, "LastGameplayTrustedSample") == nil then
              rawset(v90, "LastGameplayTrustedSample", v96)
            end

            if rawget(v90, "LastValidatedSample") == nil then
              rawset(v90, "LastValidatedSample", v96)
            end

            if rawget(v90, "LastValidatedGroundedSample") == nil then
              rawset(v90, "LastValidatedGroundedSample", v96)
            end

            if rawget(v90, "LastConfirmedGroundSample") == nil then
              rawset(v90, "LastConfirmedGroundSample", v96)
            end

            if rawget(v90, "LastGoodSample") == nil then
              rawset(v90, "LastGoodSample", v96)
            end
          end
        end)
      end

      task.wait(0.2)
    end

    return
  end
end)

local v97
pcall(function() v97 = require(replicatedStorage.Client.PlotState) end)
local v98
pcall(function() v98 = require(replicatedStorage.Data.Areas) end)
local v99
pcall(function() v99 = require(replicatedStorage.Data.Rarity) end)
local v100
pcall(function() v100 = require(replicatedStorage.Data.Assets) end)
local v101
pcall(function() v101 = require(replicatedStorage.Shared.Save) end)
local v102
pcall(function() v102 = require(replicatedStorage.Shared.Eggs.EggToolDisplay) end)
local util

pcall(function()
  util = replicatedStorage:FindFirstChild("Shared")
      and replicatedStorage.Shared:FindFirstChild("Util")
      and require(replicatedStorage.Shared.Util.AreaEggSlotIdentity)
    or replicatedStorage:FindFirstChild("Util")
      and require(replicatedStorage.Util.AreaEggSlotIdentity)
    or replicatedStorage:FindFirstChild("Shared")
      and replicatedStorage.Shared:FindFirstChild("Utils")
      and require(replicatedStorage.Shared.Utils.AreaEggSlotIdentity)
end)

local function f21()
  local resolvePlot = v97 and v97.ResolvePlot and v97.ResolvePlot()

  local centerPoint = resolvePlot
    and resolvePlot.CenterPoint
    and (typeof(resolvePlot.CenterPoint) == "Vector3" and resolvePlot.CenterPoint
      or resolvePlot.CenterPoint:IsA("BasePart") and resolvePlot.CenterPoint.Position)

  if centerPoint then
    return Vector3.new(centerPoint.X, math.max(centerPoint.Y, 70.4), centerPoint.Z), CFrame.new(centerPoint.X, math.max(centerPoint.Y, 70.4), centerPoint.Z)
  end

  return Vector3.new(464.7, 70.4, -364), CFrame.new(464.7, 70.4, -364)
end

local function f22(p37)
  local networking = replicatedStorage:FindFirstChild("Packages")
    and replicatedStorage.Packages:FindFirstChild("Networking")

  return networking and networking:FindFirstChild(p37)
end

local function f23()
  if v97 and v97.ResolveLocalSlot then
    local v103, v104 = pcall(v97.ResolveLocalSlot)

    if v103 and v104 then
      return v104
    end

    return 1
  end

  return 1
end

local v105 = "Tween Glide"
local v106 = true

local v107 = {
  autoJoin = false,
  autoMastery = false,
  claimed = {},
  arenaReady = false,
}

local function f24(p38, p39, p40)
  local v108 = f11()

  if not v108 or not p38 then
    return false
  else
    local position = v108.Position
    local magnitude = (p38 - position).Magnitude

    if magnitude < 1 then
      v108.CFrame = CFrame.new(p38.X, math.max(p38.Y, 70), p38.Z)
      v108.AssemblyLinearVelocity = Vector3.zero
      v108.AssemblyAngularVelocity = Vector3.zero

      return true
    else
      local v109 = math.clamp(tonumber(p39) or tonumber(glideSpeed) or 750, 50, 750)
      local v110 = math.max(magnitude / v109, 0.02)

      if p40 then
        v110 = v110 * 1.25
      end

      local v111 = os.clock()
      local v112 = p38 - position
      local unit = v112.Magnitude > 0.001 and v112.Unit

      local vector = unit
      vector = unit or Vector3.new(1, 0, 0)

      while os.clock() - v111 < v110 and not v1.dead do
        runService.Heartbeat:Wait()
        local v113 = math.clamp((os.clock() - v111) / v110, 0, 1)
        local v114 = v113

        if p40 then
          v114 = math.sin(v113 * (math.pi / 2))
        end

        local lerp = position:Lerp(p38, v114)
        v108.CFrame = CFrame.lookAt(lerp, lerp + vector)
        local v115 = v109

        if p40 then
          v115 = math.max(v109 * (1 - v113 * 0.8), 35)
        end

        v108.AssemblyLinearVelocity = Vector3.new(
          vector.X * v115, math.clamp(vector.Y * v115, -15, 150), vector.Z * v115
        )

        v108.AssemblyAngularVelocity = Vector3.zero
      end

      v108.CFrame = CFrame.new(p38.X, math.max(p38.Y, 70), p38.Z)
      v108.AssemblyLinearVelocity = Vector3.zero
      v108.AssemblyAngularVelocity = Vector3.zero

      return true
    end
  end
end

local function f25(p41, p42, p43)
  local v116 = f11()

  if not v116 or not p41 then
    return false
  else
    local magnitude2 = (p41 - v116.Position).Magnitude

    if magnitude2 < 1 then
      v116.CFrame = CFrame.new(p41.X, math.max(p41.Y, 70), p41.Z)
      v116.AssemblyLinearVelocity = Vector3.zero
      v116.AssemblyAngularVelocity = Vector3.zero

      return true
    else
      local v117 = math.clamp(tonumber(p42) or tonumber(glideSpeed) or 750, 50, 750)
      local v118 = os.clock()

      while not v1.dead do
        local v119 = runService.Heartbeat:Wait()
        local position2 = v116.Position
        local v120 = p41 - position2
        local magnitude3 = v120.Magnitude

        if magnitude3 < 1 then
          break
        else
          local v121 = v117

          if p43 then
            local v122 = math.clamp(magnitude3 / magnitude2, 0, 1)
            v121 = math.max(v117 * (1 - (1 - v122) * 0.8), 35)
          end

          local v123 = math.min(v121 * v119, magnitude3)
          local unit2 = v120.Unit
          local v124 = position2 + unit2 * v123

          v116.CFrame = CFrame.lookAt(v124, v124 + unit2)
          v116.AssemblyLinearVelocity = Vector3.zero
          v116.AssemblyAngularVelocity = Vector3.zero

          if os.clock() - v118 > magnitude2 / 50 + 5 then
            break
          end
        end
      end

      v116.CFrame = CFrame.new(p41.X, math.max(p41.Y, 70), p41.Z)
      v116.AssemblyLinearVelocity = Vector3.zero
      v116.AssemblyAngularVelocity = Vector3.zero

      return true
    end
  end
end

local v125 = 580
local v126 = 245

local function f26(p44, p45, p46)
  local v127 = f11()

  if not v127 or not p44 then
    return false
  else
    local position3 = v127.Position
    local v128 = math.max(position3.Y, p44.Y, 70.4)

    if p44.X < 560 and position3.X > v125 then
      f25(Vector3.new(position3.X, v128, -364.5), p45, false)
      f25(Vector3.new(v125, v128, -364.5), p45, false)
      f25(Vector3.new(p44.X, v128, -364.5), v126, false)
      f25(p44 + Vector3.new(0, 1.2, 0), v126, p46 == true)

      return true
    else
      local vector2 = Vector3.new(position3.X, v128, -364.5)
      local vector3 = Vector3.new(p44.X, v128, -364.5)
      local vector4 = Vector3.new(0, 1.2, 0)

      f25(vector2, p45, false)
      f25(vector3, p45, false)
      f25(p44 + vector4, p45, p46 == true)

      return true
    end
  end
end

local function f27(p47)
  local v129 = f10()
  local v130 = not v129
  local v131 = f11()

  if v130 or not v131 or not p47 then
    return false
  else
    local position4 = v131.Position

    for index3, value11 in ipairs({
      Vector3.new(position4.X, position4.Y, -364.5), Vector3.new(p47.X, p47.Y, -364.5),
      p47 + Vector3.new(0, 1.2, 0),
    }) do
      if v1.dead then
        break
      else
        v129:MoveTo(value11)
        local v132 = os.clock()

        while (v131.Position - value11).Magnitude > 4.5 and os.clock() - v132 < 5
          and not v1.dead do
          task.wait(0.05)
        end
      end
    end

    return true
  end
end

local function f28(p48, p49, p50)
  local v133 = f11()

  if not v133 or not p48 then
    return false
  else
    local position5 = v133.Position
    local v134 = p48.X < 560
    local v135 = math.max(position5.Y, p48.Y, 70.4) + 28

    if v134 and position5.X > v125 then
      local vector5 = Vector3.new(position5.X, v135, position5.Z)
      local vector6 = Vector3.new(v125, v135, -364.5)

      f24(vector5, p49, false)
      f24(vector6, p49, false)
      f24(Vector3.new(v125, 70.4, -364.5), v126, false)

      f25(Vector3.new(p48.X, 70.4, -364.5), v126, false)
      f25(p48 + Vector3.new(0, 1.2, 0), v126, p50 == true)

      return true
    elseif (p48 - position5).Magnitude < 25 then
      f24(Vector3.new(p48.X, math.max(p48.Y, 70) + 1.2, p48.Z), p49, p50 == true)
      return true
    else
      local vector7 = Vector3.new(position5.X, v135, position5.Z)
      local vector8 = Vector3.new(p48.X, v135, p48.Z)
      local v136 = math.max(p48.Y, 70)
      local vector9 = Vector3.new(p48.X, v136 + 1.2, p48.Z)

      f24(vector7, p49, false)
      f24(vector8, p49, false)
      f24(vector9, p49, p50 == true)

      return true
    end
  end
end

local function f29(p51, p52, p53)
  if v105 == "Fly Glide" then
    return f28(p51, p52, p53)
  end

  if v105 == "Safe Walk" then
    return f27(p51)
  end

  return f26(p51, p52, p53)
end

local v137 = {
  LightDark = 1300,
  ["Light & Dark"] = 1300,
  Titan = 1100,
  Divine = 1000,
  Transcendent = 1000,
  Superior = 1000,
  Eternal = 900,
  Limited = 900,
  Secret = 800,
  Exotic = 800,
  Cosmic = 700,
  Exclusive = 700,
  Admin = 700,
  Mythic = 600,
  Mythical = 600,
  Prismatic = 600,
  Rainbow = 600,
  ["Squishy God"] = 600,
  BrainrotGod = 600,
  Legendary = 500,
  Epic = 400,
  Rare = 300,
  SuperRare = 200,
  Celestial = 200,
  Uncommon = 200,
  Basic = 100,
  Common = 100,
}

local vector10 = Vector3.new(491.7, 70.4, -364.4)

local function f30()
  local reHomesteadAskNearbyPurchase = f22("RE/Homestead/AskNearbyPurchase")

  if reHomesteadAskNearbyPurchase then
    pcall(function() reHomesteadAskNearbyPurchase:FireServer() end)
  end

  local reHomesteadAskBaseTierRaise = f22("RE/Homestead/AskBaseTierRaise")

  if reHomesteadAskBaseTierRaise then
    pcall(function() reHomesteadAskBaseTierRaise:FireServer() end)
  end
end

local vector11 = Vector3.new(539.5, 68, -364.5)
local vector12 = Vector3.new(596, 68, -328)
local vector13 = Vector3.new(744, 68.5, -408)
local v138

local function f31()
  local resolvePlot2 = v97 and v97.ResolvePlot and v97.ResolvePlot()

  local position6 = resolvePlot2 and resolvePlot2.CenterPoint
      and resolvePlot2.CenterPoint.Position
    or Vector3.new(464.7, 68.2, -364)

  local v139 = {}

  for index4, value12 in ipairs(localPlayer.Character:GetChildren()) do
    if value12:IsA("Tool") and v102 and v102.IsEggTool and v102.IsEggTool(value12) then
      local v140 = v102.GetToolUid(value12)

      if v140 then
        table.insert(v139, v140)
      end
    end
  end

  for index5, value13 in ipairs(localPlayer.Backpack:GetChildren()) do
    if value13:IsA("Tool") and v102 and v102.IsEggTool and v102.IsEggTool(value13) then
      local v141 = v102.GetToolUid(value13)

      if v141 then
        table.insert(v139, v141)
      end
    end
  end

  local count3 = 0

  for index6, value14 in ipairs(v139) do
    local v142 = value14
    local count4 = 0

    while true do
      count4 = 1 + count4

      if not (count4 <= 3) then
        break
      end

      local cframe = CFrame.new(math.random(-6, 6), 0, math.random(-6, 6))

      local v143, v144 = pcall(function()
        if v138 and v138.PlantEgg then
          return v138.PlantEgg(v142, cframe)
        end

        return false
      end)

      if v143 and v144 then
        count3 = count3 + 1
        break
      end

      task.wait(0.1)
    end
  end

  return count3
end

local v145 = {
  ["Base / Plot"] = vector10,
  ["Stands & Shops"] = vector11,
  Forest = vector12,
  Lake = vector13,
  Desert = Vector3.new(948, 69.5, -323),
  Jungle = Vector3.new(1188, 68.5, -408),
  Snow = Vector3.new(1492, 69, -315),
  Volcano = Vector3.new(1882, 68, -398),
  ["Abyss Ocean"] = Vector3.new(2280, 68, -326),
  Prehistoric = Vector3.new(2812, 69, -398),
  Cosmic = Vector3.new(3390, 68, -324),
  ["Cherry Blossom"] = Vector3.new(4028, 68.5, -396),
  ["Titan Temple"] = Vector3.new(4796, 69.5, -328),
  ["Light Dark"] = Vector3.new(5660, 70, -331),
  ["Dragon Event"] = Vector3.new(539.5, 68, -318),
}

local function f32()
  local v146 = not v138
  local v147, v148

  if v146 or not v138.ReadOwnedEggs then
    return 0
  else
    local v149, v150 = pcall(v138.ReadOwnedEggs, localPlayer.UserId)

    if not v149 or not v150 then
      return 0
    else
      v148 = 0
      local records = v150.Records or v150

      if typeof(records) == "table" then
        for key10, value15 in pairs(records) do
          local v151 = key10

          if typeof(value15) == "table" then
            if v138.IsReadyToHatch then
              v147 = v138.IsReadyToHatch(value15)
            else
              v147 = value15.Placement ~= nil
            end

            if v147 then
              pcall(function()
                if v138.BeginHatch then
                  v138.BeginHatch(v151)
                end

                task.wait(0.05)

                if v138.FinishHatch then
                  v138.FinishHatch(v151)
                end

                v148 = v148 + 1
              end)
            end
          end
        end
      end

      return v148
    end
  end
end

local function f33()
  local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
  local dropHeldEgg = playerGui and playerGui:FindFirstChild("DropHeldEgg")

  if dropHeldEgg and dropHeldEgg.Enabled == true then
    return true
  else
    local character3 = localPlayer.Character

    if character3 then
      for index7, value16 in ipairs(character3:GetChildren()) do
        if value16:IsA("Model")
          and (value16.Name:lower():find("egg") or value16:GetAttribute("Uid")
            or value16:GetAttribute("AssetCategory")) then
          return true
        elseif value16:IsA("Tool") then
          if v102 and v102.IsEggTool and v102.IsEggTool(value16) then
            return true
          end

          if value16:GetAttribute("IsEgg") == true or value16:GetAttribute("Uid") ~= nil
            or value16:GetAttribute("AssetCategory") ~= nil then
            return true
          else
            local lower = value16.Name:lower()

            if lower:find("egg")
              or lower ~= "bat" and lower ~= "defaulttool" and not lower:find("bat")
                and not lower:find("slap") and not lower:find("coil")
                and not lower:find("potion") and not lower:find("lantern") then
              return true
            end
          end
        end
      end
    end

    local backpack = localPlayer:FindFirstChild("Backpack")

    if backpack then
      for index8, value17 in ipairs(backpack:GetChildren()) do
        if value17:IsA("Tool") and v102 and v102.IsEggTool and v102.IsEggTool(value17) then
          return true
        end
      end

      return false
    end

    return false
  end
end

local values = {
  "Forest", "Lake", "Desert", "Jungle", "Snow", "Volcano", "Abyss Ocean", "Prehistoric",
  "Cosmic", "Cherry Blossom", "Titan Temple", "Light Dark", "Angels & Demons",
}

local function f34()
  local rfHaulWearBest = f22("RF/Haul/WearBest") or f22("RF/PenRoster/ConfirmEquipBestBadge")

  if rfHaulWearBest then
    pcall(function() rfHaulWearBest:InvokeServer() end)
  end
end

local values2 = {
  "Light & Dark", "Titan", "Divine", "Superior", "Eternal", "Limited", "Secret", "Exotic",
  "Cosmic", "Exclusive", "Mythic", "Rainbow", "Squishy God", "Celestial", "Legendary", "Epic",
  "Rare", "SuperRare", "Uncommon", "Common",
}

local values3 = {
  "Normal Only", "Mutated Only", "Parasite / Infested", "Rainbow Only", "Gold Only",
  "Silver Only", "Monstrous",
}

local v152 = false

local function f35()
  local rfTreadmillAskTierRaise = f22("RF/Treadmill/AskTierRaise")

  if rfTreadmillAskTierRaise then
    pcall(function() rfTreadmillAskTierRaise:InvokeServer() end)
  end
end

local v153 = {}
local v154 = {}
local v155 = {}
local v156 = 1.5
local v157 = 750
local v158 = {}
local v159 = false
local v160 = false
local v161 = 2
local v162 = false
local v163 = false
local v164 = false
local v165 = false
local v166 = false
local v167 = {}
local v168 = {}

local v169 = {
  Common = true,
  Uncommon = true,
  Rare = true,
  Epic = true,
  Legendary = true,
  Mythic = true,
}

local function f36(p54, p55)
  if not p55 or type(p55) ~= "table" then
    return true
  else
    local count5 = 0

    for key11 in pairs(p55) do
      count5 = count5 + 1
    end

    if count5 == 0 then
      return true
    elseif p55[p54] == true then
      return true
    else
      local v170 = string.lower(tostring(p54))

      for key12, value18 in pairs(p55) do
        if type(value18) == "string" and string.lower(value18) == v170 then
          return true
        end

        if type(key12) == "string" and string.lower(key12) == v170 and value18 == true then
          return true
        end
      end

      return false
    end
  end
end

local function f37(p56)
  if not p56 or next(p56) == nil then
    return v169
  end

  return p56
end

local v171 = false
local v172 = 20

local function f38(p57)
  if not p57 then
    return "Common", 100
  elseif p57.Rarity then
    local rarity = p57.Rarity

    local displayName = type(rarity) == "table"
        and (rarity.DisplayName or rarity._id or rarity.Name)
      or tostring(rarity)

    return displayName, v137[displayName]
      or type(rarity) == "table" and tonumber(rarity.RarityNumber) and rarity.RarityNumber * 100
      or 100
  else
    local assetCategory = p57.AssetCategory or p57.Category or p57.Name

    if assetCategory and v100 then
      local v173 = (v100.Directory or v100)[assetCategory]

      if v173 and v173.Rarity then
        local rarity2 = v173.Rarity

        local displayName2 = type(rarity2) == "table"
            and (rarity2.DisplayName or rarity2._id or rarity2.Name)
          or tostring(rarity2)

        return displayName2, v137[displayName2]
          or type(rarity2) == "table" and tonumber(rarity2.RarityNumber)
            and rarity2.RarityNumber * 100
          or 100
      end
    end

    local directory = v98 and (v98.Directory or v98) and (v98.Directory or v98)[p57.AreaId]
    local rarity3 = directory and directory.Rarity
    local id = type(rarity3) == "table" and (rarity3._id or rarity3.DisplayName or rarity3.Name)

    local v174 = id
    v174 = id or type(rarity3) == "string" and rarity3 or "Common"

    local v175 = v99
    local v176 = v174
    local v177 = (v175 and (v99.Rarities or v99) or {})[v176] or {}

    local displayName3 = type(v177) == "table" and (v177.DisplayName or v177._id)
      or type(rarity3) == "table" and rarity3.DisplayName or v176 or "Common"

    return displayName3, v137[displayName3]
      or v137[v176]
      or type(rarity3) == "table" and tonumber(rarity3.RarityNumber)
        and rarity3.RarityNumber * 100
      or 100
  end
end

local v178 = 0.2

local function f39(p58, p59, p60)
  local v179 = p59 and p59.HasParasite == true
    or type(p58) == "table" and (table.find(p58, "Parasite") or table.find(p58, "Monstrous"))
    or p59 and (p59.BaseMutation == "Parasite" or p59.BaseMutation == "Monstrous")

  if not p60 or type(p60) ~= "table" then
    return true
  else
    local count6 = 0

    for key13 in pairs(p60) do
      count6 = count6 + 1
    end

    if count6 == 0 then
      return true
    else
      local v180 = type(p58) == "table" and #p58 > 0
      local v181 = false

      for key14, value19 in pairs(p60) do
        if type(value19) == "string" then
          if value19 == "Normal Only" and not v180 and not v179 then
            v181 = true
          elseif value19 == "Mutated Only" and (v180 or v179) then
            v181 = true
          elseif (value19 == "Parasite / Infested" or value19 == "Monstrous") and v179 then
            v181 = true
          elseif value19 == "Silver Only" and type(p58) == "table"
            and table.find(p58, "Silver") then
            v181 = true
          elseif value19 == "Gold Only" and type(p58) == "table"
            and (table.find(p58, "Gold") or table.find(p58, "Golden")) then
            v181 = true
          elseif value19 == "Rainbow Only" and type(p58) == "table"
            and table.find(p58, "Rainbow") then
            v181 = true
          end
        end
      end

      return v181
    end
  end
end

local f40

local function f41(p61, p62)
  if not p62 or type(p62) ~= "table" then
    return true
  else
    local count7 = 0

    for key15 in pairs(p62) do
      count7 = count7 + 1
    end

    if count7 == 0 then
      return true
    elseif p62[p61] == true then
      return true
    else
      local v182 = string.lower(tostring(p61))

      for key16, value20 in pairs(p62) do
        if type(value20) == "string"
          and (string.lower(value20) == v182 or string.lower(tostring(f40(value20))) == v182) then
          return true
        end

        if type(key16) == "string" and string.lower(key16) == v182 and value20 == true then
          return true
        end
      end

      return false
    end
  end
end

function f40(p63)
  local directory2 = v98 and v98.Directory

  if type(directory2) ~= "table" then
    return tostring(p63)
  else
    local v183 = string.lower(tostring(p63))

    for key17, value21 in pairs(directory2) do
      if string.lower(tostring(key17)) == v183 then
        return key17
      end

      if type(value21) == "table" and value21.DisplayName
        and string.lower(tostring(value21.DisplayName)) == v183 then
        return key17
      end
    end

    return tostring(p63)
  end
end

local cframe2

local function f42()
  if not cframe2 then
    local v184 = f11()

    if v184 then
      cframe2 = v184.CFrame
    end
  end
end

local f43

local function f44(p64, p65, p66)
  if not v138 or not v138.ReadFieldEggs then
    return {}
  else
    local v185, v186 = pcall(v138.ReadFieldEggs)

    if not v185 or not v186 or not v186.Records then
      return {}
    else
      local v187 = {}

      for index9, value22 in ipairs(v186.Records) do
        if value22.State == "Slot" and value22.BoundsCFrame then
          if not (v158[value22.Uid] and os.clock() - v158[value22.Uid] < 2.5)
            and (true or f43(value22)) then
            local v188 = f41(value22.AreaId, p64)
            local v189, v190 = f38(value22)
            local v191 = f36(v189, p65)
            local mutations = value22.Mutations or {}

            if v188 and v191 and f39(mutations, value22, p66) then
              local total2 = 0

              for index10, value23 in ipairs(mutations) do
                if value23 == "Rainbow" then
                  total2 = total2 + 35
                elseif value23 == "Gold" or value23 == "Golden" then
                  total2 = total2 + 20
                elseif value23 == "Silver" then
                  total2 = total2 + 10
                end
              end

              if value22.HasParasite == true
                or type(mutations) == "table"
                  and (table.find(mutations, "Parasite") or table.find(mutations, "Monstrous")) then
                total2 = total2 + 800
              end

              if f43(value22) then
                total2 = total2 + 600
              end

              table.insert(v187, { record = value22, rarity = v189, score = v190 + total2 })
            end
          end
        end
      end

      if #v187 > 1 then
        table.sort(v187, function(p67, p68) return p67.score > p68.score end)
      end

      return v187
    end
  end
end

function f43(p69)
  if not p69 then
    return false
  end

  return (tonumber(p69.AssetScale) or 1) >= 1.35 or (tonumber(p69.NestScale) or 1) >= 1
end

local function f45(p70)
  local record = p70.record or p70
  local v192 = not record or not record.Uid or not record.BoundsCFrame
  local position7, v193, rfEggWorldAskFieldEggCarry, v194, v195, v196, humanoid

  if v192 then
    return false
  else
    if v138 and v138.ReadFieldEggs then
      local v197, v198 = pcall(v138.ReadFieldEggs)

      if v197 and v198 and v198.Records then
        local v199 = false

        for index11, value24 in ipairs(v198.Records) do
          if value24.Uid == record.Uid and value24.State == "Slot" then
            record = value24
            v199 = true
            break
          end
        end

        if not v199 then
          return false
        end
      end
    end

    local v200 = f11()
    f10()

    if not v200 then
      return false
    else
      f42()
      position7 = record.BoundsCFrame.Position
      local v201 = math.clamp(tonumber(v157) or 750, 50, 750)
      f29(position7 + Vector3.new(0, 1.2, 0), v201, true)

      if v200 then
        v200.CFrame = CFrame.new(position7 + Vector3.new(0, 1.2, 0))
        v200.AssemblyLinearVelocity = Vector3.zero
        v200.AssemblyAngularVelocity = Vector3.zero
      end

      task.wait(0.5)
      v193 = nil

      if util and util.LooksLikeFirstAreaUid and util.LooksLikeFirstAreaUid(record.Uid) then
        v193 = util.SlotKey(record.AreaId, record.NestId)
      end

      local packages = replicatedStorage:FindFirstChild("Packages")

      local networking2 = packages
      networking2 = packages and replicatedStorage.Packages:FindFirstChild("Networking")

      rfEggWorldAskFieldEggCarry = networking2
        and networking2:FindFirstChild("RF/EggWorld/AskFieldEggCarry")

      if rfEggWorldAskFieldEggCarry then
        pcall(function()
          rfEggWorldAskFieldEggCarry:InvokeServer({ Uid = record.Uid, FirstAreaSlotKey = v193 })
        end)
      end

      pcall(function()
        if v138 and v138.CarryFieldEgg then
          v138.CarryFieldEgg(record.Uid, v193)
        end
      end)

      v194 = nil

      for index12, value25 in ipairs(v5:GetDescendants()) do
        if value25:IsA("ProximityPrompt") and value25.Name == "CarryAreaEgg" and value25.Enabled then
          local lower2 = (value25.ActionText or ""):lower()
          local lower3 = (value25.ObjectText or ""):lower()

          if not lower2:find("skip") and not lower2:find("robux") and not lower3:find("skip")
            and not lower3:find("robux") then
            local parent = value25.Parent

            if parent:IsA("Attachment") then
              parent = parent.Parent
            end

            if parent and (parent.Position - v200.Position).Magnitude < 14 then
              v194 = value25
              break
            end
          end
        end
      end

      if v194 then
        v194.HoldDuration = 0
        pcall(function() fireproximityprompt(v194) end)
        pcall(function() fireproximityprompt(v194, 0) end)
      end

      local v202, v203 = f21()
      CFrame.new(v202 + Vector3.new(0, 1.2, 0))
      local v204 = os.clock()
      local v205 = false

      while os.clock() - v204 < 1.5 and not v1.dead do
        if v205 then
          break
        end

        if f33() then
          v205 = true
          break
        end

        pcall(function()
          if v138 and v138.CarryFieldEgg then
            v138.CarryFieldEgg(record.Uid, v193)
          end
        end)

        if v194 then
          v194.HoldDuration = 0
          pcall(function() fireproximityprompt(v194) end)
        end

        task.wait(0.08)
      end

      if not v205 then
        v158[record.Uid] = os.clock()
        return false
      else
        if v205 then
          local v206 = os.clock()
          local health = 100
          local v207 = f10()

          if v207 then
            health = v207.Health
          end

          local v208 = false

          while os.clock() - v206 < 4 and not v1.dead do
            if not f33() then
              v208 = true
              break
            else
              local v209 = f10()

              if v209 then
                local getState = v209:GetState()

                if v209.Health < health - 1.5 or getState == Enum.HumanoidStateType.Physics
                  or getState == Enum.HumanoidStateType.Ragdoll
                  or getState == Enum.HumanoidStateType.FallingDown then
                  v208 = true
                  local v210 = os.clock()

                  while os.clock() - v210 < 0.85 and not v1.dead do
                    if not f33() then
                      break
                    end

                    task.wait(0.05)
                  end

                  break
                end
              end

              task.wait(0.05)
            end
          end

          if v208 or not f33() then
            task.wait(0.65)
            local v211 = os.clock()

            while os.clock() - v211 < 3.2 and not v1.dead do
              local v212 = f10()

              if not v212 then
                break
              else
                local getState2 = v212:GetState()

                if getState2 ~= Enum.HumanoidStateType.Physics
                  and getState2 ~= Enum.HumanoidStateType.Ragdoll
                  and getState2 ~= Enum.HumanoidStateType.FallingDown then
                  break
                end

                pcall(function() v212:ChangeState(Enum.HumanoidStateType.GettingUp) end)
                task.wait(0.12)
              end
            end

            task.wait(0.35)
            v195 = f11()

            if v195 and (v195.Position - position7).Magnitude > 14 then
              pcall(function()
                v195.CFrame = CFrame.new(position7 + Vector3.new(0, 1.8, 0))
                v195.AssemblyLinearVelocity = Vector3.zero
                v195.AssemblyAngularVelocity = Vector3.zero
              end)

              task.wait(0.35)
            end

            local v213 = os.clock()

            while os.clock() - v213 < 1.5 and not v1.dead do
              local v214 = f10()

              if v214 and v214:GetState() ~= Enum.HumanoidStateType.Physics
                and v214:GetState() ~= Enum.HumanoidStateType.Ragdoll then
                break
              end

              task.wait(0.08)
            end

            local v215 = os.clock()

            while os.clock() - v215 < 4.5 and not v1.dead do
              task.wait(0.14)
            end

            task.wait(0.08)
            task.wait(0.08)

            pcall(function()
              if rfEggWorldAskFieldEggCarry then
                rfEggWorldAskFieldEggCarry:InvokeServer({
                  Uid = record.Uid,
                  FirstAreaSlotKey = v193,
                })
              end
            end)

            pcall(function()
              if v138 and v138.CarryFieldEgg then
                v138.CarryFieldEgg(record.Uid, v193)
              end
            end)

            task.wait(0.08)
            v196 = nil

            for index13, value26 in ipairs(v5:GetDescendants()) do
              if value26:IsA("ProximityPrompt") and value26.Name == "CarryAreaEgg"
                and value26.Enabled then
                local parent2 = value26.Parent

                if parent2 and parent2:IsA("Attachment") then
                  parent2 = parent2.Parent
                end

                if parent2 then
                  if (parent2.Position - (f11() and f11().Position or position7)).Magnitude < 16 then
                    local lower4 = (value26.ActionText or ""):lower()

                    if not lower4:find("skip") and not lower4:find("robux") then
                      v196 = value26
                      break
                    end
                  end
                end
              end
            end

            if v196 then
              v196.HoldDuration = 0
              pcall(function() fireproximityprompt(v196) end)
              pcall(function() fireproximityprompt(v196, 0) end)
            else
              for index14, value27 in ipairs(v5:GetDescendants()) do
                local v216 = value27

                if v216:IsA("ProximityPrompt") and v216.Name == "CarryAreaEgg" and v216.Enabled then
                  local parent3 = v216.Parent

                  if parent3 and parent3:IsA("Attachment") then
                    parent3 = parent3.Parent
                  end

                  if parent3
                    and (parent3.Position - (f11() and f11().Position or position7)).Magnitude
                      < 18 then
                    v216.HoldDuration = 0
                    pcall(function() fireproximityprompt(v216) end)
                    task.wait(0.08)

                    if f33() then
                      break
                    end
                  end
                end
              end
            end

            local v217 = os.clock()

            while os.clock() - v217 < 2.2 and not v1.dead do
              if f33() then
                v205 = true
                break
              end

              pcall(function()
                if v138 and v138.CarryFieldEgg then
                  v138.CarryFieldEgg(record.Uid, v193)
                end
              end)

              if v196 then
                pcall(function() fireproximityprompt(v196) end)
              end

              task.wait(0.06)
            end

            if f33() then
              v205 = true
            end

            if f33() then
              task.wait(0.12)
            else
              task.wait(0.12)

              for index15, value28 in ipairs(v5:GetDescendants()) do
                local v218 = value28

                if v218:IsA("ProximityPrompt") and v218.Name == "CarryAreaEgg" and v218.Enabled then
                  local parent4 = v218.Parent

                  if parent4 and parent4:IsA("Attachment") then
                    parent4 = parent4.Parent
                  end

                  if parent4
                    and (parent4.Position - (f11() and f11().Position or position7)).Magnitude
                      < 18 then
                    v218.HoldDuration = 0
                    pcall(function() fireproximityprompt(v218) end)
                  end
                end
              end

              task.wait(0.12)

              if f33() then
                v205 = true
              end
            end
          end
        end

        if v201 > 250 then
          local v219 = f11()
          local v220 = v202 - (v219 and v219.Position or position7)

          if v220.Magnitude > 45 then
            local v221 = v202 - v220.Unit * 35
            f29(Vector3.new(v221.X, math.max(v221.Y, 70.4), v221.Z), v201, false)
            local v222 = f11()

            if v222 then
              v222.AssemblyLinearVelocity = Vector3.zero
              v222.AssemblyAngularVelocity = Vector3.zero
            end

            task.wait(0.35)
          end

          f29(v202, 240, true)
        else
          f29(v202, v201, true)
        end

        local v223 = os.clock()

        while os.clock() - v223 < 1.5 and f33() and not v1.dead do
          task.wait(0.08)
        end

        f31()
        local character4 = localPlayer.Character

        local humanoidRootPart = character4
        humanoidRootPart = character4 and character4:FindFirstChild("HumanoidRootPart")

        humanoid = character4 and character4:FindFirstChildOfClass("Humanoid")

        if humanoidRootPart then
          humanoidRootPart.CFrame = CFrame.new(v202.X, math.max(v202.Y, 70.4), v202.Z)
          humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
          humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
        end

        if humanoid then
          humanoid.PlatformStand = false
          humanoid.AutoRotate = true
          pcall(function() humanoid:ChangeState(Enum.HumanoidStateType.Running) end)
        end

        return v205 or f33()
      end
    end
  end
end

local function f46()
  local v224 = f44(v154, v153, v155)

  if #v224 == 0 then
    return false
  end

  return f45(v224[1])
end

v107.Data = nil
v107.MasteryData = nil

function v107.EnsureData()
  if v107._dataTried then
    return
  end

  v107._dataTried = true

  pcall(function() v107.Data = require(replicatedStorage.Data.BossEvent) end)
  pcall(function() v107.MasteryData = require(replicatedStorage.Data.BossMastery) end)
end

v107.MilestoneFallback = {
  "Mastery3", "Mastery5", "Mastery10", "Mastery15", "Mastery20", "Mastery30",
}

function v107.Snapshot()
  local rfBossEventAskSnapshot = f22("RF/BossEvent/AskSnapshot")

  if not rfBossEventAskSnapshot then
    return nil
  else
    local v225, v226 = pcall(function() return rfBossEventAskSnapshot:InvokeServer() end)

    if v225 and type(v226) == "table" then
      return v226
    end

    return nil
  end
end

function v107.IsOpen()
  v107.EnsureData()
  local v227 = v107.Snapshot()

  if v227 then
    if v227.Open ~= nil then
      return v227.Open == true
    end

    if v227.BossHealth and v227.BossMaxHealth then
      return (tonumber(v227.BossHealth) or 0) > 0
    end
  end

  if v107.Data and type(v107.Data.SecondsUntilNextOpen) == "function" then
    local v228, v229 = pcall(function() return v107.Data.SecondsUntilNextOpen() end)

    if v228 and tonumber(v229) then
      return tonumber(v229) <= 0
    end

    return false
  end

  return false
end

function v107.SecondsUntilOpen()
  v107.EnsureData()

  if v107.Data and type(v107.Data.SecondsUntilNextOpen) == "function" then
    local v230, v231 = pcall(function() return v107.Data.SecondsUntilNextOpen() end)

    if v230 and tonumber(v231) then
      return tonumber(v231)
    end

    return nil
  end

  return nil
end

function v107.Join()
  local rfBossEventAskEnter = f22("RF/BossEvent/AskEnter")

  if not rfBossEventAskEnter then
    return false
  else
    local v232, v233 = pcall(function() return rfBossEventAskEnter:InvokeServer() end)
    return v232 and v233 ~= false and v233 ~= nil
  end
end

function v107.ClaimMastery()
  v107.EnsureData()
  local rfBossMasteryAskClaimMilestone = f22("RF/BossMastery/AskClaimMilestone")

  if not rfBossMasteryAskClaimMilestone then
    return 0
  else
    local v234 = {}

    if v107.MasteryData and type(v107.MasteryData.Milestones) == "table" then
      for key18, value29 in pairs(v107.MasteryData.Milestones) do
        if type(value29) == "table" and type(value29.Id) == "string"
          and not v107.claimed[value29.Id] then
          table.insert(v234, value29.Id)
        end
      end
    end

    if #v234 == 0 then
      for index16, value30 in ipairs(v107.MilestoneFallback) do
        if not v107.claimed[value30] then
          table.insert(v234, value30)
        end
      end
    end

    local count8 = 0

    for index17, value31 in ipairs(v234) do
      local v235 = value31

      local v236, v237 = pcall(function()
        return rfBossMasteryAskClaimMilestone:InvokeServer(v235)
      end)

      if v236 and v237 ~= false and v237 ~= nil then
        v107.claimed[v235] = true
        count8 = count8 + 1
      end
    end

    return count8
  end
end

v107.autoFight = false
v107.hazardImmune = false
v107.arenaApproach = "Crystals First"
v107.glideSpeed = 260
v107.engageDistance = 7
v107.swingInterval = 0.15
v107._target = nil
v107._targetPart = nil
v107._targetAt = 0
v107._stepAt = 0
v107._swingAt = 0
v107._batAt = 0

function v107.IsInArena()
  return localPlayer:GetAttribute("InBossArena") == true
end

function v107.FindBat()
  local character5 = localPlayer.Character
  local rfCodexAskWearFieldBat

  if not character5 then
    return nil
  else
    local tool = character5:FindFirstChildWhichIsA("Tool")

    if tool and tool:GetAttribute("IsBat") == true then
      return tool
    else
      local backpack2 = localPlayer:FindFirstChild("Backpack")

      if backpack2 then
        for index18, value32 in ipairs(backpack2:GetChildren()) do
          if value32:IsA("Tool") and value32:GetAttribute("IsBat") == true then
            value32.Parent = character5
            return value32
          end
        end
      end

      rfCodexAskWearFieldBat = f22("RF/Codex/AskWearFieldBat")

      if rfCodexAskWearFieldBat then
        pcall(function() rfCodexAskWearFieldBat:InvokeServer() end)
      end

      task.wait(0.25)

      if backpack2 then
        for index19, value33 in ipairs(backpack2:GetChildren()) do
          if value33:IsA("Tool") and value33:GetAttribute("IsBat") == true then
            value33.Parent = character5
            return value33
          end
        end

        return nil
      end

      return nil
    end
  end
end

function v107.FindTarget()
  local bossArena = v5:FindFirstChild("BossArena")

  if not bossArena then
    return nil
  else
    local v238 = f11()

    if not v238 then
      return nil
    else
      local v239 = nil
      local huge = math.huge
      local crystalTowers = bossArena:FindFirstChild("CrystalTowers")

      if crystalTowers then
        for index20, value34 in ipairs(crystalTowers:GetChildren()) do
          local findFirstChild2 = value34:FindFirstChild("Hitbox", true)

          if findFirstChild2 and findFirstChild2:IsA("BasePart") then
            local v240 = tonumber(findFirstChild2:GetAttribute("Health"))

            if v240 == nil or v240 > 0 then
              local magnitude4 = (v238.Position - findFirstChild2.Position).Magnitude

              if magnitude4 < huge then
                huge = magnitude4
                v239 = findFirstChild2
              end
            end
          end
        end
      end

      if v239 and v107.arenaApproach == "Crystals First" then
        return v239, "Crystal"
      else
        local boss = bossArena:FindFirstChild("Boss")

        if boss then
          local findFirstChild3 = boss:FindFirstChild("UpperHand1.R", true) or boss.PrimaryPart

          if findFirstChild3 and findFirstChild3:IsA("BasePart") then
            if (v238.Position - findFirstChild3.Position).Magnitude < huge then
              v239 = findFirstChild3
            end
          end
        end

        return v239, v239 and v239:IsDescendantOf(crystalTowers or bossArena) and "Boss" or nil
      end
    end
  end
end

function v107.GlideStep(p71)
  local v241 = f11()

  if not v241 or not p71 then
    return false
  else
    local v242 = v241.Position - p71.Position
    local vector14 = Vector3.new(v242.X, 0, v242.Z)

    if vector14.Magnitude < 0.5 then
      vector14 = Vector3.new(0, 0, 1)
    end

    local v243 = p71.Position + vector14.Unit * 5 - v241.Position
    local magnitude5 = v243.Magnitude

    if magnitude5 < 1 then
      v241.AssemblyLinearVelocity = Vector3.zero
      v241.AssemblyAngularVelocity = Vector3.zero
      return true
    else
      local v244 = os.clock()
      local v245 = math.clamp(v244 - (v107._stepAt or v244), 0.001, 0.1)
      v107._stepAt = v244
      local v246 = tonumber(v107.glideSpeed)
      local v247 = math.clamp(v246 or 260, 60, 500)
      local unit3 = v243.Unit
      local v248 = math.min(v247 * v245, magnitude5)
      local v249 = v241.Position + unit3 * v248
      local vector15 = Vector3.new(unit3.X, 0, unit3.Z)

      if vector15.Magnitude < 0.01 then
        vector15 = v241.CFrame.LookVector
      end

      v241.CFrame = CFrame.lookAt(v249, v249 + vector15.Unit)
      v241.AssemblyLinearVelocity = Vector3.zero
      v241.AssemblyAngularVelocity = Vector3.zero

      return false
    end
  end
end

function v107.EnsureBat()
  local character6 = localPlayer.Character

  if not character6 then
    return nil
  else
    local tool2 = character6:FindFirstChildWhichIsA("Tool")

    if tool2 and tool2:GetAttribute("IsBat") == true then
      return tool2
    else
      local v250 = os.clock()

      if v250 - (v107._batAt or 0) < 1.5 then
        return nil
      end

      v107._batAt = v250
      return v107.FindBat()
    end
  end
end

function v107.CurrentTarget()
  local v251 = os.clock()
  local targetPart = v107._targetPart
  local parent5 = targetPart and targetPart.Parent and v251 - (v107._targetAt or 0) < 0.35
  local v252, v253

  if parent5 then
    local v254 = tonumber(targetPart:GetAttribute("Health"))

    if v254 == nil or v254 > 0 then
      return targetPart, v107._target
    end

    v253, v252 = v107.FindTarget()

    v107._targetPart = v253
    v107._target = v252
    v107._targetAt = v251

    return v253, v252
  end

  v253, v252 = v107.FindTarget()

  v107._targetPart = v253
  v107._target = v252
  v107._targetAt = v251

  return v253, v252
end

function v107.Fight()
  local v255, reBatSwingTrigger

  if not v107.IsInArena() then
    return false
  else
    local v256 = f11()

    if not v256 then
      return false
    else
      local v257, target = v107.CurrentTarget()

      if not v257 then
        return false
      elseif (v256.Position - v257.Position).Magnitude > v107.engageDistance then
        v107.GlideStep(v257)
        v107._target = target
        return true
      else
        local v258 = os.clock()

        if v258 - (v107._swingAt or 0) < v107.swingInterval then
          return true
        end

        v107._swingAt = v258
        v255 = v107.EnsureBat()

        if v255 then
          pcall(function() v255:Activate() end)
        end

        reBatSwingTrigger = f22("RE/BatSwing/Trigger")

        if reBatSwingTrigger then
          pcall(function() reBatSwingTrigger:FireServer() end)
        end

        return true
      end
    end
  end
end

v107._hazardRemotes = {}
v107.hazardHook = false
v107.hazardHookTried = false

for index21, value35 in ipairs({
  f22("RE/BossEvent/HazardHit"), (f22("RE/BossEvent/BlackHoleHit")),
}) do
  if type(value35) == "userdata" and value35:IsA("RemoteEvent") then
    v107._hazardRemotes[value35] = true
  end
end

function v107.InstallHazardHook()
  if v107.hazardHook then
    return true
  end

  if v107.hazardHookTried then
    return false
  end

  v107.hazardHookTried = true
  local fireServer

  if not v81 then
    return false
  else
    local reBossEventHazardHit = f22("RE/BossEvent/HazardHit")

    if type(reBossEventHazardHit) ~= "userdata" or not reBossEventHazardHit:IsA("RemoteEvent") then
      return false
    end

    fireServer = reBossEventHazardHit.FireServer

    if type(fireServer) ~= "function" then
      return false
    else
      local v259 = pcall(function()
        v81(fireServer, function(p72, ...)
          if v107.hazardImmune and v107._hazardRemotes[p72] then
            return
          end

          return fireServer(p72, ...)
        end)
      end)

      v107.hazardHook = v259
      return v259
    end
  end
end

local function f47()
  local count9 = 0

  local function f48(p73)
    if not p73 then
      return
    end

    for index22, value36 in ipairs(p73:GetChildren()) do
      local v260 = value36

      if v260:IsA("Model") or v260:IsA("BasePart") then
        pcall(function()
          v260:Destroy()
          count9 = count9 + 1
        end)
      end
    end
  end

  f48(v5:FindFirstChild("Pets"))
  f48(v5:FindFirstChild("RenderedPets"))

  return count9
end

local function f49()
  if not v101 then
    return
  end

  local get = nil
  pcall(function() get = v101.Get and v101.Get() end)
  local rfEggWorldAskWearTool, rePetSatchelSellPet

  if not get then
    return
  else
    local eggInventory = get.EggInventory

    if type(eggInventory) ~= "table" then
      return
    end

    rfEggWorldAskWearTool = f22("RF/EggWorld/AskWearTool")
    rePetSatchelSellPet = f22("RE/PetSatchel/SellPet")

    if not rfEggWorldAskWearTool or not rePetSatchelSellPet then
      return
    end

    for key19, value37 in pairs(eggInventory) do
      local v261 = key19

      if type(value37) == "table" and not value37.Placement and not value37.Locked then
        if f36(f38(value37), f37(v168)) then
          pcall(function() rfEggWorldAskWearTool:InvokeServer(v261) end)
          pcall(function() rePetSatchelSellPet:FireServer({ v261 }) end)
          task.wait(0.1)
        end
      end
    end

    return
  end
end

local function f50()
  local rePetSatchelSellPet2 = f22("RE/PetSatchel/SellPet")

  if not rePetSatchelSellPet2 or not v101 then
    return
  else
    local v262 = nil
    local inventory = v262 and v262.Inventory

    if type(inventory) ~= "table" then
      return
    end

    for key20, value38 in pairs(inventory) do
      local v263 = key20

      if type(value38) == "table" and not value38.Locked then
        if f36(value38.Rarity or "Common", f37(v167)) then
          pcall(function() rePetSatchelSellPet2:FireServer(v263) end)
          task.wait(0.08)
        end
      end
    end

    return
  end
end

task.spawn(function()
  while not v1.dead do
    if v152 then
      pcall(f46)
    end

    task.wait(v156)
  end
end)

task.spawn(function()
  while not v1.dead do
    if v159 then
      pcall(f32)
    end

    if v160 then
      pcall(f31)
    end

    task.wait(v161)
  end
end)

task.spawn(function()
  while not v1.dead do
    if v162 then
      pcall(f30)
    end

    if v163 then
      pcall(f35)
    end

    if v164 then
      pcall(f34)
    end

    if v107.autoMastery then
      pcall(v107.ClaimMastery)
    end

    if v165 then
      pcall(f50)
    end

    if v166 then
      pcall(f49)
    end

    task.wait(2.5)
  end
end)

task.spawn(function()
  while not v1.dead do
    if v107.autoJoin or v107.autoFight then
      if v107.IsInArena() then
        if v107.autoFight then
          pcall(v107.Fight)
        end

        runService.Heartbeat:Wait()
      else
        local v264, v265 = pcall(v107.IsOpen)
        v107.arenaReady = v264 and v265 == true

        if v107.arenaReady then
          pcall(v107.Join)
        end

        task.wait(2)
      end
    else
      task.wait(1)
    end
  end
end)

task.spawn(function()
  local reBatSwingTrigger2 = f22("RE/BatSwing/Trigger")

  while not v1.dead do
    if v171 and reBatSwingTrigger2 then
      local v266 = f11()

      if v266 then
        local v267 = false

        for index23, value39 in ipairs(players:GetPlayers()) do
          if value39 ~= localPlayer and value39.Character then
            local humanoidRootPart2 = value39.Character:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart2
              and (humanoidRootPart2.Position - v266.Position).Magnitude <= v172 then
              v267 = true
              break
            end
          end
        end

        if v267 then
          pcall(function() reBatSwingTrigger2:FireServer() end)
        end
      end
    end

    task.wait(v178)
  end
end)

task.spawn(function()
  local debris = v5:FindFirstChild("__DEBRIS")

  if debris then
    f2(debris.ChildAdded:Connect(function(child2)
      if v106 and child2.Name == "PlayerTrap" then
        task.wait(0.05)

        if child2:GetAttribute("Owner") ~= localPlayer.Name then
          if child2:IsA("BasePart") then
            child2.CanTouch = false
          end

          for index24, value40 in ipairs(child2:GetChildren()) do
            if value40:IsA("BasePart") then
              value40.CanTouch = false
            end
          end
        end
      end
    end))
  end

  while not v1.dead do
    task.wait(1.5)
  end
end)

local v268 = {
  enabled = false,
  eggs = true,
  traps = false,
  players = false,
  guards = false,
  rareEggsOnly = false,
  showPetIcons = true,
  maxDistance = 800,
  eggColor = Color3.fromRGB(255, 200, 50),
  rareEggColor = Color3.fromRGB(255, 60, 220),
  trapColor = Color3.fromRGB(255, 60, 60),
  playerColor = Color3.fromRGB(100, 220, 100),
  guardColor = Color3.fromRGB(255, 60, 60),
}

local v269 = type(Drawing) == "table" and type(Drawing.new) == "function"
local v270 = {}

local function f51()
  if not v269 then
    return {}
  else
    local v271 = {}
    v271.name = f1(Drawing.new("Text"))
    v271.name.Size = 13
    v271.name.Center = true
    v271.name.Outline = true
    v271.name.Visible = false
    v271.dist = f1(Drawing.new("Text"))
    v271.dist.Size = 11
    v271.dist.Center = true
    v271.dist.Outline = true
    v271.dist.Visible = false
    v271.box = f1(Drawing.new("Square"))
    v271.box.Thickness = 1.5
    v271.box.Filled = false
    v271.box.Visible = false

    return v271
  end
end

local v272 = {}
local saeEspHolder = nil
local f52

local function f53(p74, p75, p76)
  local v273 = v272[p74]

  if not v273 or not v273.gui or not v273.gui.Parent then
    local parent6 = f52()

    local espAnchor = Instance.new("Part")
    espAnchor.Name = "EspAnchor"
    espAnchor.Size = Vector3.new(1, 1, 1)
    espAnchor.Transparency = 1
    espAnchor.Anchored = true
    espAnchor.CanCollide = false
    espAnchor.CanQuery = false
    espAnchor.CanTouch = false
    espAnchor.CFrame = CFrame.new(p75)
    espAnchor.Parent = parent6

    local eggIconBillboard = Instance.new("BillboardGui")
    eggIconBillboard.Name = "EggIconBillboard"
    eggIconBillboard.Adornee = espAnchor
    eggIconBillboard.Size = UDim2.fromOffset(28, 28)
    eggIconBillboard.StudsOffset = Vector3.new(-2.2, 1.2, 0)
    eggIconBillboard.AlwaysOnTop = true
    eggIconBillboard.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    eggIconBillboard.Parent = espAnchor

    local petImage = Instance.new("ImageLabel")
    petImage.Name = "PetImage"
    petImage.Size = UDim2.fromScale(1, 1)
    petImage.BackgroundTransparency = 1
    petImage.ScaleType = Enum.ScaleType.Fit
    petImage.Image = p76 or ""
    petImage.Parent = eggIconBillboard

    v273 = { part = espAnchor, gui = eggIconBillboard, img = petImage }
    v272[p74] = v273
  else
    v273.part.CFrame = CFrame.new(p75)

    local img = v273.img
    img.Image = p76 or ""

    local gui = v273.gui
    gui.Enabled = p76 ~= nil and p76 ~= ""
  end

  return v273
end

function f52()
  if saeEspHolder and saeEspHolder.Parent then
    return saeEspHolder
  end

  local playerGui2 = nil

  if not playerGui2 then
    pcall(function() playerGui2 = coreGui end)
  end

  if not playerGui2 then
    playerGui2 = localPlayer:FindFirstChild("PlayerGui") or v5
  end

  pcall(function()
    for index25, value41 in ipairs(playerGui2:GetChildren()) do
      if value41:IsA("Folder") and value41.Name == "SAE_Esp_Holder" then
        value41:Destroy()
      end
    end
  end)

  saeEspHolder = Instance.new("Folder")
  saeEspHolder.Name = "SAE_Esp_Holder"

  pcall(function() saeEspHolder.Parent = playerGui2 end)
  return saeEspHolder
end

f2(runService.RenderStepped:Connect(function()
  if v1.dead or not v268.enabled then
    for key21, value42 in pairs(v270) do
      if value42.name then
        value42.name.Visible = false
      end

      if value42.dist then
        value42.dist.Visible = false
      end

      if value42.box then
        value42.box.Visible = false
      end
    end

    for key22, value43 in pairs(v272) do
      if value43.gui then
        value43.gui.Enabled = false
      end
    end

    return
  else
    local v274 = f11()
    local position8 = v274 and v274.Position or Vector3.zero
    local v275 = {}
    local v276 = {}

    if v268.eggs and v138 and v138.ReadFieldEggs then
      local v277, v278 = pcall(v138.ReadFieldEggs)

      if v277 and v278 and v278.Records then
        for index26, value44 in ipairs(v278.Records) do
          if value44.State == "Slot" and value44.BoundsCFrame then
            local position9 = value44.BoundsCFrame.Position
            local magnitude6 = (position9 - position8).Magnitude

            if v268.maxDistance <= 0 or magnitude6 <= v268.maxDistance then
              local mutations2 = value44.Mutations or {}
              local v279 = #mutations2 > 0

              if not v268.rareEggsOnly or v279 then
                local v280 = v279 and " [" .. table.concat(mutations2, ",") .. "]" or ""
                local v281 = f38(value44)
                local name = (value44.AssetCategory or "Egg") .. " (" .. v281 .. ")" .. v280
                local assetCategory2 = value44.AssetCategory

                local directory3 = v100 and (v100.Directory or v100)
                  and (v100.Directory or v100)[assetCategory2]

                local icon = directory3
                    and (directory3.Icon or directory3.Egg and directory3.Egg.Icon)
                  or ""

                local rareEggColor = v279 and v268.rareEggColor or v268.eggColor

                table.insert(v275, {
                  Key = value44.Uid,
                  Pos = position9,
                  Name = name,
                  Color = rareEggColor,
                  Dist = magnitude6,
                })

                if v268.showPetIcons and icon ~= "" then
                  v276[value44.Uid] = true
                  f53(value44.Uid, position9, icon)
                end
              end
            end
          end
        end
      end
    end

    if v268.traps then
      local debris2 = v5:FindFirstChild("__DEBRIS")

      if debris2 then
        for index27, value45 in ipairs(debris2:GetChildren()) do
          if value45.Name == "PlayerTrap" and value45:IsA("BasePart") then
            local position10 = value45.Position
            local magnitude7 = (position10 - position8).Magnitude

            if v268.maxDistance <= 0 or magnitude7 <= v268.maxDistance then
              local owner = value45:GetAttribute("Owner") or "Enemy"

              table.insert(v275, {
                Key = value45,
                Pos = position10 + Vector3.new(0, 1.5, 0),
                Name = "[TRAP] @" .. owner,
                Color = v268.trapColor,
                Dist = magnitude7,
              })
            end
          end
        end
      end
    end

    if v268.players then
      for index28, value46 in ipairs(players:GetPlayers()) do
        if value46 ~= localPlayer and value46.Character then
          local humanoidRootPart3 = value46.Character:FindFirstChild("HumanoidRootPart")

          if humanoidRootPart3 then
            local magnitude8 = (humanoidRootPart3.Position - position8).Magnitude

            if v268.maxDistance <= 0 or magnitude8 <= v268.maxDistance then
              table.insert(v275, {
                Key = value46,
                Pos = humanoidRootPart3.Position,
                Name = value46.DisplayName .. " (@" .. value46.Name .. ")",
                Color = v268.playerColor,
                Dist = magnitude8,
              })
            end
          end
        end
      end
    end

    for key23, value47 in pairs(v272) do
      if not v276[key23] and value47.gui then
        value47.gui.Enabled = false
      end
    end

    local v282 = f6()
    local v283 = {}

    for index29, value48 in ipairs(v275) do
      v283[value48.Key] = true
      local v284 = v270[value48.Key]

      if not v284 then
        v284 = f51()
        v270[value48.Key] = v284
      end

      local v285 = false
      local v286 = nil

      if v282 then
        v286, v285 = v282:WorldToViewportPoint(value48.Pos)
      end

      if v285 and v269 and v286 then
        if v284.name then
          v284.name.Text = value48.Name
          v284.name.Position = Vector2.new(v286.X, v286.Y - 14)
          v284.name.Color = value48.Color
          v284.name.Visible = true
        end

        if v284.dist then
          v284.dist.Text = math.floor(value48.Dist) .. " studs"
          v284.dist.Position = Vector2.new(v286.X, v286.Y + 2)
          v284.dist.Color = Color3.fromRGB(220, 220, 220)
          v284.dist.Visible = true
        end
      else
        if v284.name then
          v284.name.Visible = false
        end

        if v284.dist then
          v284.dist.Visible = false
        end

        if v284.box then
          v284.box.Visible = false
        end
      end
    end

    for key24, value49 in pairs(v270) do
      if not v283[key24] then
        if value49.name then
          value49.name.Visible = false
        end

        if value49.dist then
          value49.dist.Visible = false
        end

        if value49.box then
          value49.box.Visible = false
        end
      end
    end

    return
  end
end))

local ambient = lighting.Ambient
local outdoorAmbient = lighting.OutdoorAmbient
local brightness = lighting.Brightness
local clockTime

local function f54(p77)
  if p77 then
    lighting.Ambient = Color3.fromRGB(255, 255, 255)
    lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    lighting.Brightness = 2
    lighting.ClockTime = 14
  else
    lighting.Ambient = ambient
    lighting.OutdoorAmbient = outdoorAmbient
    lighting.Brightness = brightness
    lighting.ClockTime = clockTime
  end
end

clockTime = lighting.ClockTime
local v287 = false
local walkSpeed = 24
local v288 = false

local function f55(p78)
  walkSpeed = p78
  local v289 = f10()

  if v289 and v287 then
    v289.WalkSpeed = p78
  end
end

local jumpPower = 60
local v290 = false
local v291 = 60
local v292 = false

local function f56(p79)
  jumpPower = p79
  local v293 = f10()

  if v293 and v288 then
    v293.UseJumpPower = true
    v293.JumpPower = p79
  end
end

f2(runService.Stepped:Connect(function()
  if v1.dead then
    return
  else
    local v294 = f10()

    if v294 then
      if v287 then
        v294.WalkSpeed = walkSpeed
      end

      if v288 then
        v294.UseJumpPower = true
        v294.JumpPower = jumpPower
      end
    end

    return
  end
end))

f2(userInputService.JumpRequest:Connect(function()
  if v1.dead then
    return
  else
    local v295 = f10()

    if v295 then
      v295.Jump = true
      v295:ChangeState(Enum.HumanoidStateType.Jumping)
    end

    return
  end
end))

local function f57()
  if v290 then
    return
  end

  local v296 = f11()

  if not (v296 and f10()) then
    return
  end

  v290 = true
  v296.Anchored = true

  local bodyGyro = Instance.new("BodyGyro")
  bodyGyro.MaxTorque = Vector3.new(1, 1, 1) * 100000
  bodyGyro.P = 100000
  bodyGyro.CFrame = v296.CFrame
  bodyGyro.Parent = v296

  v1._fly = {
    hrp = v296,
    gyro = bodyGyro,
    conn = f2(runService.RenderStepped:Connect(function(delta)
      if not v290 or v1.dead then
        return
      else
        local v297 = f6()

        if not v297 then
          return
        else
          local lookVector = v297.CFrame.LookVector
          local rightVector = v297.CFrame.RightVector
          local vector16 = Vector3.new(lookVector.X, 0, lookVector.Z)
          local unit4 = vector16.Magnitude > 0.001 and vector16.Unit or Vector3.new(0, 0, -1)
          local vector17 = Vector3.new(rightVector.X, 0, rightVector.Z)
          local unit5 = vector17.Magnitude > 0.001 and vector17.Unit or Vector3.new(1, 0, 0)
          local zero = Vector3.zero

          if userInputService:IsKeyDown(Enum.KeyCode.W) then
            zero = zero + unit4
          end

          if userInputService:IsKeyDown(Enum.KeyCode.S) then
            zero = zero - unit4
          end

          if userInputService:IsKeyDown(Enum.KeyCode.A) then
            zero = zero - unit5
          end

          if userInputService:IsKeyDown(Enum.KeyCode.D) then
            zero = zero + unit5
          end

          if userInputService:IsKeyDown(Enum.KeyCode.Space) then
            zero = zero + Vector3.new(0, 1, 0)
          end

          if userInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            zero = zero - Vector3.new(0, 1, 0)
          end

          if zero.Magnitude > 0 then
            v296.CFrame = v296.CFrame + zero.Unit * v291 * math.min(delta, 0.1)
          end

          bodyGyro.CFrame = CFrame.lookAt(v296.Position, v296.Position + lookVector)
          return
        end
      end
    end)),
  }
end

local v298 = nil

local function f58(p80)
  v292 = p80

  if p80 and not v298 then
    v298 = f2(localPlayer.Idled:Connect(function()
      if v292 then
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new())
      end
    end))
  elseif not p80 and v298 then
    pcall(function() v298:Disconnect() end)
    v298 = nil
  end
end

local function f59()
  v290 = false
  local fly = v1._fly

  if fly then
    pcall(function() fly.conn:Disconnect() end)
    pcall(function() fly.hrp.Anchored = false end)
    pcall(function() fly.gyro:Destroy() end)

    v1._fly = nil
  end
end

local window = library:CreateWindow({
  Title = "Exium HUB | Bright696",
  Footer = "v4.2.2",
  NotifySide = "Right",
  ShowCustomCursor = true,
})

local v299 = {
  Eggs = window:AddTab("Eggs", "package"),
  Base = window:AddTab("Base", "home"),
  Combat = window:AddTab("Combat", "crosshair"),
  Player = window:AddTab("Player", "user"),
  Settings = window:AddTab("Settings", "settings"),
}

local addLeftTabbox = v299.Eggs:AddLeftTabbox()
local autoSteal = addLeftTabbox:AddTab("Auto Steal")
local autoHatchPlant = addLeftTabbox:AddTab("Auto Hatch & Plant")
local eggTrackerESP = v299.Eggs:AddRightTabbox():AddTab("Egg Tracker ESP")

autoSteal:AddToggle("steal_auto", {
  Text = "Auto Steal Eggs",
  Default = false,
  Callback = f8(function(p81)
    v152 = p81

    if p81 then
      f42()
    end
  end),
})

autoSteal:AddDropdown("steal_method", {
  Values = { "Tween Glide", "Fly Glide", "Safe Walk" },
  Default = "Tween Glide",
  Text = "Steal Movement Method",
  Callback = function(value50) v105 = value50 end,
})

autoSteal:AddToggle("rare_hunter", {
  Text = "Rare Egg Hunter (Highest Rarity First)",
  Default = true,
  Callback = function(value51) end,
})

autoSteal:AddDropdown("steal_rarities", {
  Values = values2,
  Multi = true,
  Text = "Filter by Rarity (Multi-Select)",
  Callback = function(value52) v153 = value52 end,
})

autoSteal:AddDropdown("steal_areas", {
  Values = values,
  Multi = true,
  Text = "Filter by Area (Multi-Select)",
  Callback = function(value53) v154 = value53 end,
})

autoSteal:AddDropdown("steal_muts", {
  Values = values3,
  Multi = true,
  Text = "Filter by Mutation (Multi-Select)",
  Callback = function(value54) v155 = value54 end,
})

autoSteal:AddSlider("glide_speed", {
  Text = "Glide / Travel Speed",
  Min = 50,
  Max = 750,
  Default = 750,
  Rounding = 0,
  Suffix = " studs/s",
  Callback = function(value55) v157 = tonumber(value55) or 750 end,
})

autoSteal:AddSlider("steal_gap", {
  Text = "Steal Delay Gap",
  Min = 0.5,
  Max = 10,
  Default = 1.5,
  Rounding = 1,
  Suffix = "s",
  Callback = function(value56) v156 = value56 end,
})

autoSteal:AddButton({
  Text = "Steal Best Available Egg Once",
  Func = f8(function() local v300 = f46() end),
})

autoHatchPlant:AddToggle("hatch_auto", {
  Text = "Auto Hatch Ready Eggs",
  Default = false,
  Callback = f8(function(p82) v159 = p82 end),
})

autoHatchPlant:AddToggle("plant_auto", {
  Text = "Auto Place Egg (Base Pen)",
  Default = false,
  Callback = function(value57) v160 = value57 end,
})

autoHatchPlant:AddSlider("hatch_gap", {
  Text = "Hatch Check Delay",
  Min = 0.5,
  Max = 10,
  Default = 2,
  Rounding = 1,
  Suffix = "s",
  Callback = function(value58) v161 = value58 end,
})

autoHatchPlant:AddButton({
  Text = "Hatch All Ready Eggs Now",
  Func = f8(function() local v301 = f32() end),
})

autoHatchPlant:AddButton({
  Text = "Place Carried Eggs in Pen Now",
  Func = f8(function() local v302 = f31() end),
})

eggTrackerESP:AddToggle("esp_eggs_enabled", {
  Text = "Egg ESP Enabled",
  Default = false,
  Callback = f8(function(enabled) v268.enabled = enabled end),
})

eggTrackerESP:AddToggle("esp_pet_icons", {
  Text = "Show 3D Pet Image Badges",
  Default = true,
  Callback = function(value59) v268.showPetIcons = value59 end,
})

eggTrackerESP:AddToggle("esp_traps", {
  Text = "Trap ESP (Highlights Enemy Traps)",
  Default = false,
  Callback = function(value60) v268.traps = value60 end,
})

eggTrackerESP:AddToggle("esp_eggs_rare_only", {
  Text = "Show Mutated / Rare Eggs Only",
  Default = false,
  Callback = function(value61) v268.rareEggsOnly = value61 end,
})

eggTrackerESP:AddSlider("esp_max_dist", {
  Text = "Max ESP Distance",
  Min = 100,
  Max = 2500,
  Default = 800,
  Rounding = 0,
  Suffix = " studs",
  Callback = function(value62) v268.maxDistance = value62 end,
})

local addLeftTabbox2 = v299.Base:AddLeftTabbox()
local homesteadTreadmill = addLeftTabbox2:AddTab("Homestead & Treadmill")
local petsSatchel = addLeftTabbox2:AddTab("Pets & Satchel")
local autoSell = addLeftTabbox2:AddTab("Auto Sell")
local addRightTabbox = v299.Base:AddRightTabbox()
local eventsBosses = addRightTabbox:AddTab("Events & Bosses")
local claimRewards = addRightTabbox:AddTab("Claim Rewards")

homesteadTreadmill:AddToggle("up_base_auto", {
  Text = "Auto Upgrade Base / Plot",
  Default = false,
  Callback = function(value63) v162 = value63 end,
})

homesteadTreadmill:AddToggle("up_tread_auto", {
  Text = "Auto Upgrade Treadmill Tier",
  Default = false,
  Callback = function(value64) v163 = value64 end,
})

homesteadTreadmill:AddToggle("auto_buy_trails", {
  Text = "Auto Buy Speed Trails",
  Default = false,
  Callback = function(value65) end,
})

homesteadTreadmill:AddButton({ Text = "Upgrade Base Now", Func = f8(function() f30() end) })
homesteadTreadmill:AddButton({ Text = "Upgrade Treadmill Now", Func = f8(function() f35() end) })

petsSatchel:AddToggle("equip_best_pets", {
  Text = "Auto Equip Best Pets",
  Default = false,
  Callback = function(value66) v164 = value66 end,
})

petsSatchel:AddButton({ Text = "Equip Best Pets Now", Func = f8(function() f34() end) })

autoSell:AddToggle("auto_sell_pets", {
  Text = "Auto Sell Low-Tier Pets",
  Default = false,
  Callback = function(value67) v165 = value67 end,
})

autoSell:AddDropdown("sell_pet_rarities", {
  Values = values2,
  Multi = true,
  Text = "Filter Pet Sell Rarities",
  Callback = function(value68) v167 = value68 end,
})

autoSell:AddToggle("auto_sell_eggs", {
  Text = "Auto Sell Low-Tier Eggs",
  Default = false,
  Callback = function(value69) v166 = value69 end,
})

autoSell:AddDropdown("sell_egg_rarities", {
  Values = values2,
  Multi = true,
  Text = "Filter Egg Sell Rarities",
  Callback = function(value70) v168 = value70 end,
})

autoSell:AddButton({ Text = "Sell Selected Pets Now", Func = f8(function() f50() end) })
autoSell:AddButton({ Text = "Sell Selected Eggs Now", Func = f8(function() f49() end) })

eventsBosses:AddToggle("auto_fight_boss", {
  Text = "FULL AUTO Boss Fight (Join + Fight + Dodge + Claim)",
  Default = false,
  Callback = f8(function(p83)
    v107.autoFight = p83

    if p83 then
      v107.autoJoin = true
      v107.autoMastery = true

      if v107.hazardImmune then
        pcall(v107.InstallHazardHook)
      end
    end
  end),
})

eventsBosses:AddDropdown("boss_targeting", {
  Values = { "Crystals First", "Boss First" },
  Default = "Crystals First",
  Text = "Boss Targeting",
  Callback = function(value71) v107.arenaApproach = value71 end,
})

eventsBosses:AddToggle("boss_hazard_imm2", {
  Text = "Hazard Immunity (No Black Hole / Trap Damage)",
  Default = false,
  Callback = f8(function(p84)
    v107.hazardImmune = p84

    if p84 then
      if v107.InstallHazardHook() then
      end
    end
  end),
})

eventsBosses:AddToggle("auto_join_boss", {
  Text = "Auto Join Boss Arena (Every 30 min)",
  Default = false,
  Callback = f8(function(autoJoin) v107.autoJoin = autoJoin end),
})

eventsBosses:AddToggle("auto_boss_mastery", {
  Text = "Auto Claim Boss Mastery Rewards",
  Default = false,
  Callback = f8(function(autoMastery) v107.autoMastery = autoMastery end),
})

eventsBosses:AddButton({
  Text = "Join Boss Arena Now",
  Func = f8(function()
    if v107.Join() then
    end
  end),
})

eventsBosses:AddButton({
  Text = "Claim Boss Mastery Now",
  Func = f8(function() local v303 = v107.ClaimMastery() end),
})

eventsBosses:AddButton({
  Text = "Boss Arena Status",
  Func = f8(function()
    local v304 = v107.Snapshot()

    if v304 and v304.Open then
      v9727 = tonumber(v304.BossHealth)
      v9729 = tonumber(v304.BossMaxHealth)
    else
      v9722 = v107.SecondsUntilOpen()
    end
  end),
})

claimRewards:AddToggle("claim_auto_rewards", {
  Text = "Auto Claim Away Earnings & Codex",
  Default = false,
  Callback = function(value72) end,
})

claimRewards:AddButton({ Text = "Claim Away Earnings & Codex Now", Func = f8(function() end) })

local batSlapAura = v299.Combat:AddLeftTabbox():AddTab("Bat & Slap Aura")
local defenseGuards = v299.Combat:AddRightTabbox():AddTab("Defense & Guards")

batSlapAura:AddToggle("bat_aura_enabled", {
  Text = "Bat / Slap Aura",
  Default = false,
  Callback = f8(function(p85) v171 = p85 end),
})

batSlapAura:AddSlider("bat_radius", {
  Text = "Aura Radius",
  Min = 5,
  Max = 50,
  Default = 20,
  Rounding = 0,
  Suffix = " studs",
  Callback = function(value73) v172 = value73 end,
})

batSlapAura:AddSlider("bat_delay", {
  Text = "Swing Delay",
  Min = 0.05,
  Max = 1,
  Default = 0.2,
  Rounding = 2,
  Suffix = "s",
  Callback = function(value74) v178 = value74 end,
})

batSlapAura:AddButton({
  Text = "Swing Bat Once (Manual)",
  Func = f8(function()
    local reBatSwingTrigger3 = f22("RE/BatSwing/Trigger")

    if reBatSwingTrigger3 then
      reBatSwingTrigger3:FireServer()
    end
  end),
})

defenseGuards:AddToggle("avoid_traps", {
  Text = "Anti-Trap (Full Immunity / Destroy Hitboxes)",
  Default = true,
  Callback = f8(function(p86) v106 = p86 end),
})

defenseGuards:AddToggle("no_knockback", {
  Text = "No Knockback / Ragdoll Immunity",
  Default = true,
  Callback = f8(function(p87) end),
})

defenseGuards:AddToggle("anti_ragdoll", {
  Text = "Anti-Ragdoll (Quick Standup)",
  Default = true,
  Callback = function(value75) end,
})

local addLeftTabbox3 = v299.Player:AddLeftTabbox()
local movement = addLeftTabbox3:AddTab("Movement")
local areaTravel = addLeftTabbox3:AddTab("Area Travel")
local plotTravel = addLeftTabbox3:AddTab("Plot Travel")
local addRightTabbox2 = v299.Player:AddRightTabbox()
local playerTravel = addRightTabbox2:AddTab("Player Travel")
local visualsPerformance = addRightTabbox2:AddTab("Visuals & Performance")

movement:AddToggle("speed_enabled", {
  Text = "Enable WalkSpeed",
  Default = false,
  Callback = f8(function(p88)
    v287 = p88

    if not p88 then
      local v305 = f10()

      if v305 then
        v305.WalkSpeed = 16
      end
    end
  end),
})

movement:AddSlider("speed_val", {
  Text = "WalkSpeed Value",
  Min = 16,
  Max = 10000,
  Default = 24,
  Rounding = 0,
  Suffix = " studs/s",
  Callback = function(value76) f55(value76) end,
})

movement:AddToggle("jump_enabled", {
  Text = "Enable JumpPower",
  Default = false,
  Callback = f8(function(p89)
    v288 = p89

    if not p89 then
      local v306 = f10()

      if v306 then
        v306.JumpPower = 50
      end
    end
  end),
})

movement:AddSlider("jump_val", {
  Text = "JumpPower Value",
  Min = 50,
  Max = 300,
  Default = 60,
  Rounding = 0,
  Callback = function(value77) f56(value77) end,
})

movement:AddToggle("inf_jump", {
  Text = "Infinite Jump",
  Default = false,
  Callback = function(value78) end,
})

movement:AddToggle("fly_enabled", {
  Text = "Smooth Fly (WASD + Space/Shift)",
  Default = false,
  Callback = f8(function(p90)
    if p90 then
      f57()
    else
      f59()
    end
  end),
})

movement:AddSlider("fly_speed", {
  Text = "Fly Speed",
  Min = 20,
  Max = 250,
  Default = 60,
  Rounding = 0,
  Suffix = " studs/s",
  Callback = function(value79) v291 = value79 end,
})

movement:AddToggle("anti_afk", {
  Text = "Anti-AFK (Bypass 20min Kick)",
  Default = false,
  Callback = function(value80) f58(value80) end,
})

local v307 = "Base / Plot"
local v308 = {}

for key25 in pairs(v145) do
  table.insert(v308, key25)
end

table.sort(v308)

areaTravel:AddDropdown("tele_area", {
  Values = v308,
  Default = "Base / Plot",
  Text = "Select Area",
  Callback = function(value81) v307 = value81 end,
})

areaTravel:AddButton({
  Text = "Travel to Selected Area",
  Func = f8(function()
    local v309 = v145[v307]

    if v307 == "Base / Plot" then
      v309 = f21()
    end

    if v309 then
      f7("Travel", "Traveling to " .. v307, "Info")
      f26(v309, v157 or 200)
      f7("Travel", "Arrived at " .. v307, "Success")
    end
  end),
})

local v310 = "My Plot"

plotTravel:AddDropdown("tele_plot", {
  Values = { "Plot 1", "Plot 2", "Plot 3", "Plot 4", "Plot 5", "Plot 6", "Plot 7", "My Plot" },
  Default = "My Plot",
  Text = "Select Plot",
  Callback = function(value82) v310 = value82 end,
})

plotTravel:AddButton({
  Text = "Travel to Plot",
  Func = f8(function()
    local v311 = v310 == "My Plot" and f23() or tonumber(v310:match("%d+")) or 1
    local findFirstChild4 = v5.Plots:FindFirstChild(tostring(v311))

    local position11 = findFirstChild4
      and (findFirstChild4:FindFirstChild("CenterPoint") and findFirstChild4.CenterPoint.Position
        or findFirstChild4:GetPivot().Position)

    if position11 then
      f26(position11 + Vector3.new(0, 2, 0), v157 or 200)
      f7("Plot", "Arrived at Plot " .. tostring(v311), "Success")
    end
  end),
})

local function f60()
  local v312 = {}

  for index30, value83 in ipairs(players:GetPlayers()) do
    if value83 ~= localPlayer then
      table.insert(v312, value83.Name)
    end
  end

  table.sort(v312)

  if #v312 == 0 then
    v312 = { "(no other players)" }
  end

  return v312
end

local v313

local addDropdown = playerTravel:AddDropdown("tele_plr", {
  Values = f60(),
  Text = "Select Player",
  Callback = function(value84) v313 = value84 end,
})

playerTravel:AddButton({
  Text = "Refresh Player List",
  Func = function() addDropdown:SetValues(f60()) end,
})

playerTravel:AddButton({
  Text = "Travel to Player",
  Func = f8(function()
    if not v313 then
      return
    else
      local findFirstChild5 = players:FindFirstChild(v313)

      local humanoidRootPart4 = findFirstChild5 and findFirstChild5.Character
        and findFirstChild5.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart4 then
        f26(humanoidRootPart4.Position + Vector3.new(0, 2, 0), v157 or 200)
        f7("Player", "Arrived at " .. v313, "Success")
      end

      return
    end
  end),
})

visualsPerformance:AddToggle("fullbright", {
  Text = "Fullbright (Daylight Visuals)",
  Default = false,
  Callback = function(value85) f54(value85) end,
})

visualsPerformance:AddButton({
  Text = "Delete Own Pet Renders (FPS Boost)",
  Func = f8(function() local v314 = f47() end),
})

local configuration = v299.Settings:AddLeftGroupbox("Configuration")

configuration:AddInput("cfg_name", {
  Default = v2,
  Text = "Config Name",
  Placeholder = "stealanegg",
  ClearTextOnFocus = false,
  Finished = true,
  Callback = function(value86)
    if value86 and #value86 > 0 then
      v2 = value86
    end
  end,
})

configuration:AddButton({
  Text = "Save Config",
  Func = f8(function() v10071, v10069 = saveManager:Save(v2) end),
})

configuration:AddButton({
  Text = "Load Config",
  Func = f8(function()
    if saveManager:Load(v2) then
      f7("Config", "Loaded config '" .. v2 .. "'", "Success")
    end
  end),
})

configuration:AddDivider()

configuration:AddLabel("Menu keybind"):AddKeyPicker("MenuKeybind", {
  Default = "RightControl",
  NoUI = true,
  Text = "Toggle menu",
  Mode = "Toggle",
})

library.ToggleKeybind = options.MenuKeybind

configuration:AddDivider()

configuration:AddButton({
  Text = "Unload Exium HUB",
  Func = f8(function() pcall(function() v1.Unload() end) end),
})

configuration:AddDivider()

configuration:AddLabel([[
Exium HUB | Bright696Equipped with UGI / Client AC Neutralizer, BAC Telemetry Spoofer, Evidence Scrubber, Strict Rarity Filtering, clean open walkway travel without wall clipping, automatic return to trigger position, and auto egg placement in pen.
Automated egg stealing, hatching, homestead base upgrades, treadmill speed training, rewards collector, bat aura, ESP tracker.]], true)

v299.Settings:AddRightGroupbox("Theme & Save Manager"):AddLabel("Theme and config menus are built by the addons below.")
themeManager:SetLibrary(library)

saveManager:SetLibrary(library)
saveManager:IgnoreThemeSettings()
saveManager:SetIgnoreIndexes({ "MenuKeybind" })

themeManager:SetFolder("ExiumHUB")

saveManager:SetFolder("ExiumHUB/stealanegg")
saveManager:BuildConfigSection(v299.Settings)

themeManager:ApplyToTab(v299.Settings)

function v1.Unload()
  v1.dead = true

  for index31, value87 in ipairs(v1.conns) do
    local v315 = value87
    pcall(function() v315:Disconnect() end)
  end

  v1.conns = {}

  for index32, value88 in ipairs(v1.drawings) do
    local v316 = value88
    pcall(function() v316:Remove() end)
  end

  v1.drawings = {}

  for index33, value89 in ipairs(v1.highlights) do
    local v317 = value89
    pcall(function() v317:Destroy() end)
  end

  v1.highlights = {}
  f59()
  f54(false)
  local v318 = f10()

  if v318 then
    v318.PlatformStand = false
    v318.WalkSpeed = 16
    v318.JumpPower = 50
  end

  pcall(function() library:Unload() end)
  _G.OxideStealAnEgg = nil
end

library:OnUnload(function()
  if _G.OxideStealAnEgg then
    _G.OxideStealAnEgg.dead = true
  end
end)
