-- this is for Arsenal

local starterGui = game:GetService("StarterGui")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local coreGui = game:GetService("CoreGui")
local lighting = game:GetService("Lighting")
local placeId = game.PlaceId
local v1 = false

for index, value in ipairs({ 286090429 }) do
  if placeId == value then
    v1 = true
    break
  end
end

local f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, v2, v3, char, v4, sub, v5, random, floor,
  f12, f13, f14, f15, f16, v6, f17, f18, f19, v7, v8, v9, f20, v10, v11, v12, v13, v14, v15,
  v16, f21, f22, f23, v17, v18, v19, v20, url, v21, v22, f24, f25, f26, f27, localPlayer,
  currentCamera, v23, v24, v25, v26, v27, instance, instance2, instance3, instance4, instance5,
  f28, instance6, v28, circle, v29, f29, f30

if not v1 then
  warn("Artifact Hub Arsenal: This script is not supported by this game! (PlaceId: "
    .. tostring(placeId) .. ")")

  pcall(function()
    starterGui:SetCore("SendNotification", {
      Title = "Artifact Hub Arsenal",
      Text = "Script doesn't support this game!",
      Duration = 5,
    })
  end)

  return
else
  function f2(p1, p2)
    local v30 = p1
    local v31 = p2
    local v32 = 1
    local total = 0

    while v30 ~= 0 or v31 ~= 0 do
      total = total + (v30 % 2 + v31 % 2) % 2 * v32
      v30 = math.floor(v30 / 2)
      v31 = math.floor(v31 / 2)
      v32 = v32 * 2
    end

    return total % 4294967296
  end

  function f3(p3)
    return 4294967295 - p3
  end

  function f13(p4, p5, p6, ...)
    if p5 then
      local v33 = f2(p4 % 4294967296, p5 % 4294967296)

      if p6 then
        v33 = f13(v33, p6, ...)
      end

      return v33
    end

    if p4 then
      return p4 % 4294967296
    end

    return 0
  end

  function f4(p7, p8)
    if p8 < 0 then
      return lshift(p7, -p8)
    end

    return math.floor(p7 % 4294967296 / 2 ^ p8)
  end

  function f14(p9, p10, p11, ...)
    if p10 then
      local v34 = p9 % 4294967296
      local v35 = p10 % 4294967296
      local v36 = (v34 + v35 - f2(v34, v35)) / 2

      if p11 then
        v36 = f14(v36, p11, ...)
      end

      return v36
    end

    if p9 then
      return p9 % 4294967296
    end

    return 4294967295
  end

  function f15(p12, p13)
    if p13 > 31 or p13 < -31 then
      return 0
    end

    return f4(p12 % 4294967296, p13)
  end

  function f5(p14, p15)
    local v37 = p14 % 4294967296
    local v38 = p15 % 32
    local v39 = f14(v37, 2 ^ v38 - 1)
    return f15(v37, v38) + f16(v39, 32 - v38)
  end

  function f16(p16, p17)
    if p17 < 0 then
      return f15(p16, -p17)
    end

    return p16 * 2 ^ p17 % 4294967296
  end

  function f6(p18)
    return string.gsub(p18, ".", function(p19)
      return string.format("%02x", string.byte(p19))
    end)
  end

  v6 = {
    1116352408, 1899447441, 3049323471, 3921009573, 961987163, 1508970993, 2453635748,
    2870763221, 3624381080, 310598401, 607225278, 1426881987, 1925078388, 2162078206,
    2614888103, 3248222580, 3835390401, 4022224774, 264347078, 604807628, 770255983, 1249150122,
    1555081692, 1996064986, 2554220882, 2821834349, 2952996808, 3210313671, 3336571891,
    3584528711, 113926993, 338241895, 666307205, 773529912, 1294757372, 1396182291, 1695183700,
    1986661051, 2177026350, 2456956037, 2730485921, 2820302411, 3259730800, 3345764771,
    3516065817, 3600352804, 4094571909, 275423344, 430227734, 506948616, 659060556, 883997877,
    958139571, 1322822218, 1537002063, 1747873779, 1955562222, 2024104815, 2227730452,
    2361852424, 2428436474, 2756734187, 3204031479, 3329325298,
  }

  function f7(p20, p21)
    local v40 = f17(8 * p21, 8)
    local v41 = p20 .. "\128" .. string.rep("\0", 64 - (p21 + 9) % 64) .. v40
    assert(#v41 % 64 == 0)
    return v41
  end

  function f17(p22, p23)
    local v42 = p22
    local text = ""

    for i = 1, p23 do
      local v43 = v42 % 256
      v42 = (v42 - v43) / 256
      text = string.char(v43) .. text
    end

    return text
  end

  function f8(p24, p25, p26)
    local v44 = {}

    for j = 1, 16 do
      v44[j] = f18(p24, p25 + (j - 1) * 4)
    end

    for k = 17, 64 do
      local v45 = v44[k - 15]
      local v46 = v44[k - 2]

      v44[k] = (v44[k - 16] + f13(f5(v45, 7), f5(v45, 18), f15(v45, 3)) + v44[k - 7]
          + f13(f5(v46, 17), f5(v46, 19), f15(v46, 10)))
        % 4294967296
    end

    local v47 = p26[3]
    local v48 = p26[2]
    local v49 = p26[4]
    local v50 = p26[5]
    local v51 = p26[6]
    local v52 = p26[7]
    local v53 = p26[8]
    local v54 = p26[1]

    for m = 1, 64 do
      local v55 = f13(f5(v54, 2), f5(v54, 13), f5(v54, 22))
      local v56 = f13(f14(v54, v48), f14(v54, v47), f14(v48, v47))
      local v57 = v51

      local v58 = (v53 + f13(f5(v50, 6), f5(v50, 11), f5(v50, 25))
          + f13(f14(v50, v51), f14(f3(v50), v52)) + v6[m] + v44[m])
        % 4294967296

      local v59 = v49 + v58
      v53 = v52
      v51 = v50
      v52 = v57
      local v60 = v48
      v49 = v47
      v50 = v59 % 4294967296
      v48 = v54
      v47 = v60
      v54 = (v58 + (v55 + v56) % 4294967296) % 4294967296
    end

    p26[1] = (p26[1] + v54) % 4294967296
    p26[2] = (p26[2] + v48) % 4294967296
    p26[3] = (p26[3] + v47) % 4294967296
    p26[4] = (p26[4] + v49) % 4294967296
    p26[5] = (p26[5] + v50) % 4294967296
    p26[6] = (p26[6] + v51) % 4294967296
    p26[7] = (p26[7] + v52) % 4294967296
    p26[8] = (p26[8] + v53) % 4294967296
  end

  function f18(p27, p28)
    local v61 = 0

    for n = p28, p28 + 3 do
      v61 = v61 * 256 + string.byte(p27, n)
    end

    return v61
  end

  function f19(p29)
    p29[1] = 1779033703
    p29[2] = 3144134277
    p29[3] = 1013904242
    p29[4] = 2773480762
    p29[5] = 1359893119
    p29[6] = 2600822924
    p29[7] = 528734635
    p29[8] = 1541459225

    return p29
  end

  function f1(p30)
    local v62 = f7(p30, #p30)
    local v63 = f19({})

    for i6 = 1, #v62, 64 do
      f8(v62, i6, v63)
    end

    return f6(f17(v63[1], 4) .. f17(v63[2], 4) .. f17(v63[3], 4) .. f17(v63[4], 4)
      .. f17(v63[5], 4) .. f17(v63[6], 4) .. f17(v63[7], 4) .. f17(v63[8], 4))
  end

  v7 = nil

  v8 = {
    ["\\"] = "\\",
    ['"'] = '"',
    ["\8"] = "b",
    ["\12"] = "f",
    ["\n"] = "n",
    ["\r"] = "r",
    ["\t"] = "t",
  }

  v9 = { ["/"] = "/" }

  for key, value2 in pairs(v8) do
    v9[value2] = key
  end

  function f20(p31)
    return "\\" .. (v8[p31] or string.format("u%04x", p31:byte()))
  end

  v10 = {
    ["nil"] = function(p32) return "null" end,
    table = function(p33, p34)
      local v64 = {}
      local v65 = p34 or {}

      if v65[p33] then
        error("circular reference")
      end

      v65[p33] = true

      if rawget(p33, 1) ~= nil or next(p33) == nil then
        local count = 0

        for key2 in pairs(p33) do
          if type(key2) ~= "number" then
            error("invalid table: mixed or invalid key types")
          end

          count = count + 1
        end

        if count ~= #p33 then
          error("invalid table: sparse array")
        end

        for index2, value3 in ipairs(p33) do
          table.insert(v64, v7(value3, v65))
        end

        v65[p33] = nil
        return "[" .. table.concat(v64, ",") .. "]"
      end

      for key3, value4 in pairs(p33) do
        if type(key3) ~= "string" then
          error("invalid table: mixed or invalid key types")
        end

        table.insert(v64, v7(key3, v65) .. ":" .. v7(value4, v65))
      end

      v65[p33] = nil
      return "{" .. table.concat(v64, ",") .. "}"
    end,
    string = function(p35) return '"' .. p35:gsub('[%z\1-\31\\"]', f20) .. '"' end,
    number = function(p36)
      if p36 ~= p36 or p36 <= -math.huge or p36 >= math.huge then
        error("unexpected number value '" .. tostring(p36) .. "'")
      end

      return string.format("%.14g", p36)
    end,
    boolean = tostring,
  }

  function f9(p37)
    return v7(p37)
  end

  function v7(p38, p39)
    local v66 = type(p38)
    local v67 = v10[v66]

    if v67 then
      return v67(p38, p39)
    end

    error("unexpected type '" .. v66 .. "'")
  end

  v11 = nil

  local function f31(...)
    local v68 = {}

    for i7 = 1, select("#", ...) do
      v68[select(i7, ...)] = true
    end

    return v68
  end

  v12 = f31(" ", "\t", "\r", "\n")
  v13 = f31(" ", "\t", "\r", "\n", "]", "}", ",")
  v14 = f31("\\", "/", '"', "b", "f", "n", "r", "t", "u")
  v15 = f31("true", "false", "null")
  v16 = { ["true"] = true, ["false"] = false, null = nil }

  local function f32(p40, p41)
    local v69 = f21(p40, p41, v13)
    local sub2 = p40:sub(p41, v69 - 1)
    local v70 = tonumber(sub2)

    if not v70 then
      f22(p40, p41, "invalid number '" .. sub2 .. "'")
    end

    return v70, v69
  end

  function f21(p42, p43, p44, p45)
    for i8 = p43, #p42 do
      if p44[p42:sub(i8, i8)] ~= p45 then
        return i8
      end
    end

    return #p42 + 1
  end

  function f22(p46, p47, p48)
    local v71 = 1
    local v72 = 1

    for i9 = 1, p47 - 1 do
      v72 = v72 + 1

      if p46:sub(i9, i9) == "\n" then
        v71 = v71 + 1
        v72 = 1
      end
    end

    error(string.format("%s at line %d col %d", p48, v71, v72))
  end

  function f11(p49)
    local floor2 = math.floor

    if p49 <= 127 then
      return string.char(p49)
    elseif p49 <= 2047 then
      return string.char(floor2(p49 / 64) + 192, p49 % 64 + 128)
    elseif p49 <= 65535 then
      return string.char(
        floor2(p49 / 4096) + 224, floor2(p49 % 4096 / 64) + 128, p49 % 64 + 128
      )
    else
      if p49 <= 1114111 then
        return string.char(
          floor2(p49 / 262144) + 240, floor2(p49 % 262144 / 4096) + 128,
          floor2(p49 % 4096 / 64) + 128, p49 % 64 + 128
        )
      end

      error(string.format("invalid unicode codepoint '%x'", p49))
      return
    end
  end

  function f23(p50)
    local v73 = tonumber(p50:sub(1, 4), 16)
    local v74 = tonumber(p50:sub(7, 10), 16)

    if v74 then
      return f11((v73 - 55296) * 1024 + v74 - 56320 + 65536)
    end

    return f11(v73)
  end

  local function f33(p51, p52)
    local v75 = f21(p51, p52, v13)
    local sub3 = p51:sub(p52, v75 - 1)

    if not v15[sub3] then
      f22(p51, p52, "invalid literal '" .. sub3 .. "'")
    end

    return v16[sub3], v75
  end

  v17 = {
    ['"'] = function(p53, p54)
      local v76 = ""
      local v77 = p54 + 1
      local v78 = v77

      while v77 <= #p53 do
        local byte = p53:byte(v77)

        if byte < 32 then
          f22(p53, v77, "control character in string")
        elseif byte == 92 then
          local v79 = v76 .. p53:sub(v78, v77 - 1)
          v77 = v77 + 1
          local sub4 = p53:sub(v77, v77)

          if sub4 == "u" then
            local match = p53:match("^[dD][89aAbB]%x%x\\u%x%x%x%x", v77 + 1)

            local match2 = match

            match2 = match or p53:match("^%x%x%x%x", v77 + 1)
              or f22(p53, v77 - 1, "invalid unicode escape in string")

            v76 = v79 .. f23(match2)
            v77 = v77 + #match2
          else
            if not v14[sub4] then
              f22(p53, v77 - 1, "invalid escape char '" .. sub4 .. "' in string")
            end

            v76 = v79 .. v9[sub4]
          end

          v78 = v77 + 1
        elseif byte == 34 then
          return v76 .. p53:sub(v78, v77 - 1), v77 + 1
        end

        v77 = v77 + 1
      end

      f22(p53, p54, "expected closing quote for string")
    end,
    ["0"] = f32,
    ["1"] = f32,
    ["2"] = f32,
    ["3"] = f32,
    ["4"] = f32,
    ["5"] = f32,
    ["6"] = f32,
    ["7"] = f32,
    ["8"] = f32,
    ["9"] = f32,
    ["-"] = f32,
    t = f33,
    f = f33,
    n = f33,
    ["["] = function(p55, p56)
      local v80 = {}
      local v81 = 1
      local v82 = p56 + 1

      while 1 do
        local v83 = f21(p55, v82, v12, true)

        if p55:sub(v83, v83) == "]" then
          v82 = v83 + 1
          break
        else
          local v84, v85 = v11(p55, v83)
          v80[v81] = v84
          v81 = v81 + 1
          local v86 = f21(p55, v85, v12, true)
          local sub5 = p55:sub(v86, v86)
          v82 = v86 + 1

          if sub5 == "]" then
            break
          elseif sub5 ~= "," then
            f22(p55, v82, "expected ']' or ','")
          end
        end
      end

      return v80, v82
    end,
    ["{"] = function(p57, p58)
      local v87 = {}
      local v88 = p58 + 1

      while 1 do
        local v89 = f21(p57, v88, v12, true)

        if p57:sub(v89, v89) == "}" then
          v88 = v89 + 1
          break
        else
          if p57:sub(v89, v89) ~= '"' then
            f22(p57, v89, "expected string for key")
          end

          local v90, v91 = v11(p57, v89)
          local v92 = f21(p57, v91, v12, true)

          if p57:sub(v92, v92) ~= ":" then
            f22(p57, v92, "expected ':' after key")
          end

          local v93, v94 = v11(p57, (f21(p57, v92 + 1, v12, true)))
          v87[v90] = v93
          local v95 = f21(p57, v94, v12, true)
          local sub6 = p57:sub(v95, v95)
          v88 = v95 + 1

          if sub6 == "}" then
            break
          elseif sub6 ~= "," then
            f22(p57, v88, "expected '}' or ','")
          end
        end
      end

      return v87, v88
    end,
  }

  function f10(p59)
    if type(p59) ~= "string" then
      error("expected argument of type string, got " .. type(p59))
    end

    local v96, v97 = v11(p59, f21(p59, 1, v12, true))
    local v98 = f21(p59, v97, v12, true)

    if v98 <= #p59 then
      f22(p59, v98, "trailing garbage")
    end

    return v96
  end

  function v11(p60, p61)
    local sub7 = p60:sub(p61, p61)
    local v99 = v17[sub7]

    if v99 then
      return v99(p60, p61)
    end

    f22(p60, p61, "unexpected character '" .. sub7 .. "'")
  end

  game:IsLoaded()

  repeat
    task.wait(1)
    v2 = game
  until v2:IsLoaded()

  v18 = false
  v3 = setclipboard or toclipboard
  local v100 = request

  local httpRequest = v100
  httpRequest = v100 or http_request or syn_request

  char = string.char
  v4 = tostring
  sub = string.sub
  v5 = os.time
  random = math.random
  floor = math.floor
  local v101 = gethwid

  local v102 = v101
  v102 = v101 or function() return players.LocalPlayer.UserId end

  v19 = httpRequest
  v20 = v102
  url = ""
  v21 = 0
  v22 = "https://api.platoboost.com"

  local v103, v104 = pcall(function()
    return v19({ Url = v22 .. "/public/connectivity", Method = "GET" })
  end)

  if not v103 or not v104 or v104.StatusCode ~= 200 and v104.StatusCode ~= 429 then
    v22 = "https://api.platoboost.net"
  end

  function cacheLink()
    if v21 + 600 < v5() then
      local v105, v106 = pcall(function()
        return v19({
          Url = v22 .. "/public/start",
          Method = "POST",
          Body = f9({ service = 28412, identifier = f1(v20()) }),
          Headers = { ["Content-Type"] = "application/json" },
        })
      end)

      if v105 and v106 and v106.StatusCode == 200 then
        local v107, v108 = pcall(f10, v106.Body)

        if v107 and v108 and v108.success == true then
          url = v108.data.url
          v21 = v5()
          return true, url
        end

        return false, ""
      end

      return false, ""
    end

    return true, url
  end

  cacheLink()

  function f24()
    local text2 = ""

    for i10 = 1, 16 do
      text2 = text2 .. char(floor(random() * 26) + 97)
    end

    return text2
  end

  for i11 = 1, 5 do
    local v109 = f24()
    task.wait(0.2)

    if f24() == v109 then
      error("nonce error.")
    end
  end

  function f25()
    local v110, v111 = cacheLink()

    if v110 then
      v3(v111)
    end
  end

  function f26(key4)
    local v112 = f24()
    local url2 = v22 .. "/public/redeem/" .. v4(28412)

    local v113 = { identifier = f1(v20()), key = key4 }
    v113.nonce = v112

    local v114, v115 = pcall(function()
      return v19({
        Url = url2,
        Method = "POST",
        Body = f9(v113),
        Headers = { ["Content-Type"] = "application/json" },
      })
    end)

    if v114 and v115 and v115.StatusCode == 200 then
      local v116, v117 = pcall(f10, v115.Body)

      if v116 and v117 and v117.success == true then
        if v117.data.valid == true then
          if v117.data.hash
            == f1("true" .. "-" .. v112 .. "-ad79c087-c9cc-4d1a-98b9-bb141bb3a829") then
            return true, "Success"
          end

          return false, "Integrity error"
        end

        return false, "Key invalid"
      end

      return false, v117 and v117.message or "Decode error"
    end

    return false, "Server error"
  end

  function f27(p62)
    local v118

    if v18 == true then
      return false, "Wait"
    else
      v18 = true
      local v119 = f24()

      v118 = v22 .. "/public/whitelist/" .. v4(28412) .. "?identifier=" .. f1(v20()) .. "&key="
        .. p62

      v118 = v118 .. "&nonce=" .. v119

      local v120, v121 = pcall(function() return v19({ Url = v118, Method = "GET" }) end)
      v18 = false

      if v120 and v121 and v121.StatusCode == 200 then
        local v122, v123 = pcall(f10, v121.Body)

        if v122 and v123 and v123.success == true then
          if v123.data.valid == true then
            if v123.data.hash
              == f1("true" .. "-" .. v119 .. "-ad79c087-c9cc-4d1a-98b9-bb141bb3a829") then
              return true, "Valid"
            end

            return false, "Integrity Error"
          end

          if sub(p62, 1, 4) == "KEY_" then
            return f26(p62)
          end

          return false, "Invalid"
        end

        return false, v123 and v123.message or "Decode error"
      end

      return false, "Error contacting server"
    end
  end

  localPlayer = players.LocalPlayer
  currentCamera = workspace.CurrentCamera
  v23 = mousemoverel or Input and Input.MouseMove or nil
  v24 = false
  local color = Color3.fromRGB(255, 40, 40)
  local color2 = Color3.fromRGB(10, 10, 12)
  local color3 = Color3.fromRGB(20, 20, 22)
  local color4 = Color3.fromRGB(240, 240, 240)

  function f12(p63)
    if not p63 then
      return nil
    elseif p63.Character then
      return p63.Character
    else
      local characters = workspace:FindFirstChild("Characters")
        or workspace:FindFirstChild("Players")

      if characters then
        local findFirstChild = characters:FindFirstChild(p63.Name)

        if findFirstChild then
          return findFirstChild
        end

        return workspace:FindFirstChild(p63.Name)
      end

      return workspace:FindFirstChild(p63.Name)
    end
  end

  v25 = {
    Aimbot = false,
    TeamCheck = true,
    HoldKey = Enum.KeyCode.E,
    WallCheck = false,
    TargetPart = "Head",
    Smoothness = 4,
    InfJump = false,
    SpeedEnabled = false,
    SpeedValue = 1,
    ESP = false,
    BoxESP = false,
    Tracers = false,
    HighlightESP = false,
    HighlightTrans = 0.5,
    ShowFOV = true,
    FOVRadius = 150,
    MaxDistance = 2000,
    MenuKey = Enum.KeyCode.RightControl,
    Holding = false,
    ThemeColor = color,
    BgColor = color2,
    SectionColor = color3,
    TextColor = color4,
  }

  v26 = nil
  v27 = false

  local artifactHubUI = Instance.new("ScreenGui")
  artifactHubUI.Name = "ArtifactHub_UI"
  artifactHubUI.ResetOnSpawn = false

  if syn and syn.protect_gui then
    syn.protect_gui(artifactHubUI)
  end

  artifactHubUI.Parent = coreGui

  instance = Instance.new("Frame", artifactHubUI)
  instance.Size = UDim2.new(0, 360, 0, 215)
  instance.Position = UDim2.new(0.5, -180, 0.5, -107)
  instance.BackgroundColor3 = v25.BgColor
  instance.BorderSizePixel = 0
  instance.Active = true
  instance.Draggable = true

  Instance.new("UICorner", instance).CornerRadius = UDim.new(0, 4)

  local instance7 = Instance.new("Frame", instance)
  instance7.Size = UDim2.new(1, 0, 0, 35)
  instance7.BackgroundColor3 = v25.BgColor
  instance7.BorderSizePixel = 0

  local instance8 = Instance.new("Frame", instance7)
  instance8.Size = UDim2.new(1, 0, 0, 1)
  instance8.Position = UDim2.new(0, 0, 1, 0)
  instance8.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
  instance8.BorderSizePixel = 0

  local instance9 = Instance.new("TextLabel", instance7)
  instance9.Size = UDim2.new(1, -30, 1, 0)
  instance9.Position = UDim2.new(0, 15, 0, 0)
  instance9.Text = "Artifact Hub - Authentication"
  instance9.TextColor3 = v25.TextColor
  instance9.Font = Enum.Font.Code
  instance9.TextSize = 15
  instance9.TextXAlignment = Enum.TextXAlignment.Left
  instance9.BackgroundTransparency = 1

  instance2 = Instance.new("TextBox", instance)
  instance2.Size = UDim2.new(1, -40, 0, 30)
  instance2.Position = UDim2.new(0, 20, 0, 55)
  instance2.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
  instance2.TextColor3 = v25.TextColor
  instance2.Font = Enum.Font.Code
  instance2.TextSize = 12
  instance2.Text = ""
  instance2.PlaceholderText = "Enter key / code here..."
  instance2.BorderSizePixel = 1
  instance2.BorderColor3 = Color3.fromRGB(50, 50, 50)

  instance3 = Instance.new("TextLabel", instance)
  instance3.Size = UDim2.new(1, -20, 0, 20)
  instance3.Position = UDim2.new(0, 10, 0, 90)
  instance3.Text = ""
  instance3.TextColor3 = v25.ThemeColor
  instance3.Font = Enum.Font.Code
  instance3.TextSize = 11
  instance3.BackgroundTransparency = 1

  instance4 = Instance.new("TextButton", instance)
  instance4.Size = UDim2.new(0.5, -25, 0, 30)
  instance4.Position = UDim2.new(0, 20, 0, 120)
  instance4.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
  instance4.TextColor3 = v25.TextColor
  instance4.Font = Enum.Font.Code
  instance4.TextSize = 12
  instance4.Text = "Copy Discord"
  instance4.BorderSizePixel = 1
  instance4.BorderColor3 = Color3.fromRGB(60, 60, 60)

  instance5 = Instance.new("TextButton", instance)
  instance5.Size = UDim2.new(0.5, -25, 0, 30)
  instance5.Position = UDim2.new(0.5, 5, 0, 120)
  instance5.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
  instance5.TextColor3 = v25.TextColor
  instance5.Font = Enum.Font.Code
  instance5.TextSize = 12
  instance5.Text = "Get Key"
  instance5.BorderSizePixel = 1
  instance5.BorderColor3 = Color3.fromRGB(60, 60, 60)

  local instance10 = Instance.new("TextButton", instance)
  instance10.Size = UDim2.new(1, -40, 0, 35)
  instance10.Position = UDim2.new(0, 20, 0, 160)
  instance10.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
  instance10.TextColor3 = v25.ThemeColor
  instance10.Font = Enum.Font.Code
  instance10.TextSize = 13
  instance10.Text = "Verify Key"
  instance10.BorderSizePixel = 1
  instance10.BorderColor3 = Color3.fromRGB(60, 60, 60)

  function f28(p64)
    if setclipboard then
      setclipboard(p64)
    elseif toclipboard then
      toclipboard(p64)
    end
  end

  instance4.MouseButton1Click:Connect(function()
    f28("https://discord.com/invite/RwQYkhaq5f")
    instance4.Text = "Copied!"
    task.delay(1.5, function() instance4.Text = "Copy Discord" end)
  end)

  instance5.MouseButton1Click:Connect(function()
    f25()
    instance5.Text = "Copied!"
    task.delay(1.5, function() instance5.Text = "Get Key" end)
  end)

  instance6 = Instance.new("Frame", artifactHubUI)
  instance6.Size = UDim2.new(0, 700, 0, 440)
  instance6.Position = UDim2.new(0.5, -350, 0.5, -220)
  instance6.BackgroundColor3 = v25.BgColor
  instance6.BorderSizePixel = 0
  instance6.Active = true
  instance6.Draggable = true
  instance6.Visible = false

  Instance.new("UICorner", instance6).CornerRadius = UDim.new(0, 4)

  local instance11 = Instance.new("Frame", instance6)
  instance11.Size = UDim2.new(1, 0, 0, 35)
  instance11.BackgroundColor3 = v25.BgColor
  instance11.BorderSizePixel = 0

  local instance12 = Instance.new("Frame", instance11)
  instance12.Size = UDim2.new(1, 0, 0, 1)
  instance12.Position = UDim2.new(0, 0, 1, 0)
  instance12.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
  instance12.BorderSizePixel = 0

  local instance13 = Instance.new("TextLabel", instance11)
  instance13.Size = UDim2.new(0, 200, 1, 0)
  instance13.Position = UDim2.new(0, 15, 0, 0)
  instance13.Text = "Artifact Hub"
  instance13.TextColor3 = v25.TextColor
  instance13.Font = Enum.Font.Code
  instance13.TextSize = 18
  instance13.TextXAlignment = Enum.TextXAlignment.Left
  instance13.BackgroundTransparency = 1

  local instance14 = Instance.new("Frame", instance6)
  instance14.Size = UDim2.new(1, -20, 1, -45)
  instance14.Position = UDim2.new(0, 10, 0, 40)
  instance14.BackgroundTransparency = 1

  local instance15 = Instance.new("UIListLayout", instance14)
  instance15.FillDirection = Enum.FillDirection.Horizontal
  instance15.SortOrder = Enum.SortOrder.LayoutOrder
  instance15.Padding = UDim.new(0, 15)

  local v124 = {}

  for i12 = 1, 3 do
    local instance16 = Instance.new("Frame", instance14)
    instance16.Size = UDim2.new(0, 215, 1, 0)
    instance16.BackgroundTransparency = 1

    local instance17 = Instance.new("UIListLayout", instance16)
    instance17.Padding = UDim.new(0, 8)
    instance17.SortOrder = Enum.SortOrder.LayoutOrder

    v124[i12] = instance16
  end

  local function f34(text3, p65)
    local instance18 = Instance.new("Frame", p65)
    instance18.Size = UDim2.new(1, 0, 0, 25)
    instance18.BackgroundTransparency = 1

    local instance19 = Instance.new("TextLabel", instance18)
    instance19.Size = UDim2.new(1, -10, 1, 0)
    instance19.Position = UDim2.new(0, 5, 0, 0)
    instance19.Text = text3
    instance19.TextColor3 = Color3.fromRGB(255, 80, 80)
    instance19.Font = Enum.Font.Code
    instance19.TextSize = 11
    instance19.TextWrapped = true
    instance19.TextXAlignment = Enum.TextXAlignment.Left
    instance19.BackgroundTransparency = 1
  end

  local v125 = v124[1]

  local function f35(text4, p66, p67, p68)
    local instance20 = Instance.new("Frame", p66)
    instance20.Size = UDim2.new(1, 0, 0, 25)
    instance20.BackgroundTransparency = 1

    local instance21 = Instance.new("TextLabel", instance20)
    instance21.Size = UDim2.new(0.5, 0, 1, 0)
    instance21.Position = UDim2.new(0, 5, 0, 0)
    instance21.Text = text4
    instance21.TextColor3 = v25.TextColor
    instance21.Font = Enum.Font.Code
    instance21.TextSize = 12
    instance21.TextXAlignment = Enum.TextXAlignment.Left
    instance21.BackgroundTransparency = 1

    local instance22 = Instance.new("TextButton", instance20)
    instance22.Size = UDim2.new(0.45, 0, 0, 18)
    instance22.Position = UDim2.new(0.55, -5, 0.5, -9)
    instance22.Text = v25[p67]
    instance22.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    instance22.TextColor3 = v25.ThemeColor
    instance22.Font = Enum.Font.Code
    instance22.TextSize = 11
    instance22.BorderSizePixel = 1
    instance22.BorderColor3 = Color3.fromRGB(60, 60, 60)

    local v126 = 1

    for index3, value5 in ipairs(p68) do
      if value5 == v25[p67] then
        v126 = index3
        break
      end
    end

    instance22.MouseButton1Click:Connect(function()
      v126 = v126 + 1

      if v126 > #p68 then
        v126 = 1
      end

      v25[p67] = p68[v126]
      instance22.Text = v25[p67]
    end)
  end

  local v127 = v124[2]

  local function f36(text5, p69, p70)
    local instance23 = Instance.new("Frame", p69)
    instance23.Size = UDim2.new(1, 0, 0, 25)
    instance23.BackgroundTransparency = 1

    local instance24 = Instance.new("TextButton", instance23)
    instance24.Size = UDim2.new(1, -10, 1, 0)
    instance24.Position = UDim2.new(0, 5, 0, 0)
    instance24.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    instance24.TextColor3 = v25.ThemeColor
    instance24.Font = Enum.Font.Code
    instance24.TextSize = 12
    instance24.BorderSizePixel = 1
    instance24.BorderColor3 = Color3.fromRGB(60, 60, 60)
    instance24.Text = text5
    instance24.MouseButton1Click:Connect(p70)
  end

  local v128 = v124[3]

  local function f37(p71, p72)
    local instance25 = Instance.new("Frame", p72)
    instance25.Size = UDim2.new(1, 0, 0, 20)
    instance25.BackgroundTransparency = 1

    local instance26 = Instance.new("TextLabel", instance25)
    instance26.Size = UDim2.new(0, 0, 1, 0)
    instance26.Text = " " .. p71 .. " "
    instance26.TextColor3 = Color3.fromRGB(150, 150, 150)
    instance26.Font = Enum.Font.Code
    instance26.TextSize = 12
    instance26.AutomaticSize = Enum.AutomaticSize.X
    instance26.Position = UDim2.new(0.5, 0, 0, 0)
    instance26.AnchorPoint = Vector2.new(0.5, 0)
    instance26.BackgroundTransparency = 1

    local instance27 = Instance.new("Frame", instance25)
    instance27.Size = UDim2.new(0.5, -instance26.TextBounds.X / 2 - 5, 0, 1)
    instance27.Position = UDim2.new(0, 0, 0.5, 0)
    instance27.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    instance27.BorderSizePixel = 0

    local instance28 = Instance.new("Frame", instance25)
    instance28.Size = UDim2.new(0.5, -instance26.TextBounds.X / 2 - 5, 0, 1)
    instance28.Position = UDim2.new(1, 0, 0.5, 0)
    instance28.AnchorPoint = Vector2.new(1, 0)
    instance28.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    instance28.BorderSizePixel = 0
  end

  local function f38(text6, p73, p74)
    local instance29 = Instance.new("Frame", p73)
    instance29.Size = UDim2.new(1, 0, 0, 20)
    instance29.BackgroundTransparency = 1

    local instance30 = Instance.new("TextButton", instance29)
    instance30.Size = UDim2.new(0, 12, 0, 12)
    instance30.Position = UDim2.new(0, 5, 0.5, -6)
    instance30.Text = ""
    instance30.BackgroundColor3 = v25[p74] and v25.ThemeColor or Color3.fromRGB(30, 30, 30)
    instance30.BorderSizePixel = 1
    instance30.BorderColor3 = Color3.fromRGB(60, 60, 60)

    local instance31 = Instance.new("TextLabel", instance29)
    instance31.Size = UDim2.new(1, -25, 1, 0)
    instance31.Position = UDim2.new(0, 25, 0, 0)
    instance31.Text = text6
    instance31.TextColor3 = v25.TextColor
    instance31.Font = Enum.Font.Code
    instance31.TextSize = 12
    instance31.TextXAlignment = Enum.TextXAlignment.Left
    instance31.BackgroundTransparency = 1

    instance30.MouseButton1Click:Connect(function()
      v25[p74] = not v25[p74]
      instance30.BackgroundColor3 = v25[p74] and v25.ThemeColor or Color3.fromRGB(30, 30, 30)
    end)
  end

  local function f39(p75, p76, p77, p78, p79, p80)
    local instance32 = Instance.new("Frame", p76)
    instance32.Size = UDim2.new(1, 0, 0, 35)
    instance32.BackgroundTransparency = 1

    local instance33 = Instance.new("TextLabel", instance32)
    instance33.Size = UDim2.new(1, -10, 0, 15)
    instance33.Position = UDim2.new(0, 5, 0, 0)
    instance33.Text = p75 .. ": " .. tostring(v25[p77])
    instance33.TextColor3 = v25.TextColor
    instance33.Font = Enum.Font.Code
    instance33.TextSize = 12
    instance33.TextXAlignment = Enum.TextXAlignment.Left
    instance33.BackgroundTransparency = 1

    local instance34 = Instance.new("Frame", instance32)
    instance34.Size = UDim2.new(1, -10, 0, 6)
    instance34.Position = UDim2.new(0, 5, 0, 20)
    instance34.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    instance34.BorderSizePixel = 1
    instance34.BorderColor3 = Color3.fromRGB(50, 50, 50)

    local instance35 = Instance.new("Frame", instance34)
    instance35.Size = UDim2.new((v25[p77] - p78) / (p79 - p78), 0, 1, 0)
    instance35.BackgroundColor3 = v25.ThemeColor
    instance35.BorderSizePixel = 0

    local instance36 = Instance.new("TextButton", instance34)
    instance36.Size = UDim2.new(1, 0, 1, 10)
    instance36.Position = UDim2.new(0, 0, 0, -5)
    instance36.BackgroundTransparency = 1
    instance36.Text = ""

    local v129 = false
    instance36.MouseButton1Down:Connect(function() v129 = true end)

    userInputService.InputEnded:Connect(function(input)
      if input.UserInputType == Enum.UserInputType.MouseButton1 then
        v129 = false
      end
    end)

    runService.RenderStepped:Connect(function()
      if v129 then
        local getMouseLocation = userInputService:GetMouseLocation()

        local v130 = math.clamp((getMouseLocation.X - instance34.AbsolutePosition.X)
          / instance34.AbsoluteSize.X, 0, 1)

        instance35.Size = UDim2.new(v130, 0, 1, 0)
        local v131 = p78 + v130 * (p79 - p78)
        v25[p77] = p80 and v131 or math.floor(v131)

        instance33.Text = p75 .. ": "
          .. (p80 and string.format("%.2f", v25[p77]) or tostring(v25[p77]))
      end
    end)
  end

  local function f40(text7, p81, p82)
    local instance37 = Instance.new("Frame", p81)
    instance37.Size = UDim2.new(1, 0, 0, 25)
    instance37.BackgroundTransparency = 1

    local instance38 = Instance.new("TextLabel", instance37)
    instance38.Size = UDim2.new(0.5, 0, 1, 0)
    instance38.Position = UDim2.new(0, 5, 0, 0)
    instance38.Text = text7
    instance38.TextColor3 = v25.TextColor
    instance38.Font = Enum.Font.Code
    instance38.TextSize = 12
    instance38.TextXAlignment = Enum.TextXAlignment.Left
    instance38.BackgroundTransparency = 1

    local instance39 = Instance.new("TextButton", instance37)
    instance39.Size = UDim2.new(0.45, 0, 0, 18)
    instance39.Position = UDim2.new(0.55, -5, 0.5, -9)
    instance39.Text = v25[p82].Name
    instance39.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    instance39.TextColor3 = v25.ThemeColor
    instance39.Font = Enum.Font.Code
    instance39.TextSize = 11
    instance39.BorderSizePixel = 1
    instance39.BorderColor3 = Color3.fromRGB(60, 60, 60)

    instance39.MouseButton1Click:Connect(function()
      instance39.Text = "..."
      v26 = p82
      v27 = true
      task.delay(0.1, function() v27 = false end)
    end)

    runService.Heartbeat:Connect(function()
      if v26 ~= p82 then
        if instance39.Text ~= v25[p82].Name then
          instance39.Text = v25[p82].Name
        end
      end
    end)
  end

  f37("Aimbot Config", v125)

  f38("Enable Aimbot", v125, "Aimbot")
  f38("Team Check", v125, "TeamCheck")

  f40("Hold Key", v125, "HoldKey")
  f38("Wall Check", v125, "WallCheck")
  f35("Target Part", v125, "TargetPart", { "Head", "Torso" })
  f39("Aimbot Smoothness", v125, "Smoothness", 1, 10, true)
  f37("Movement", v127)
  f34("Use it wisely, it's bannable!", v127)

  f38("Infinite Jump", v127, "InfJump")
  f38("Speed Boost", v127, "SpeedEnabled")

  f39("Speed Multiplier", v127, "SpeedValue", 0.1, 5, true)
  f37("Visuals", v127)

  f38("Player ESP", v127, "ESP")
  f38("Box ESP", v127, "BoxESP")
  f38("Tracers & Distance", v127, "Tracers")
  f38("Body Highlight", v127, "HighlightESP")

  f39("Highlight Transparency", v127, "HighlightTrans", 0, 1, true)
  f37("World Settings", v128)

  f36("Apply Anti-Lag", v128, function()
    local terrain = workspace:FindFirstChildOfClass("Terrain")

    if terrain then
      terrain.WaterWaveSize = 0
      terrain.WaterWaveSpeed = 0
      terrain.WaterReflectance = 0
      terrain.WaterTransparency = 0
    end

    lighting.GlobalShadows = false

    for key5, value6 in pairs(workspace:GetDescendants()) do
      if value6:IsA("BasePart") and not value6:IsA("MeshPart") then
        value6.Material = Enum.Material.SmoothPlastic
        value6.Reflectance = 0
      elseif value6:IsA("Decal") or value6:IsA("Texture") then
        value6.Transparency = 1
      elseif value6:IsA("ParticleEmitter") or value6:IsA("Trail") then
        value6.Enabled = false
      end
    end
  end)

  f37("Misc & FOV", v128)
  f38("Show FOV", v128, "ShowFOV")
  f39("FOV Radius", v128, "FOVRadius", 30, 400, false)
  f37("Menu Settings", v128)
  f40("Toggle Menu Key", v128, "MenuKey")
  v28 = ""

  instance10.MouseButton1Click:Connect(function()
    local text8 = instance2.Text

    if text8 == "345765423" then
      instance3.TextColor3 = Color3.fromRGB(0, 255, 0)
      instance3.Text = "Valid Key! Owner Access Granted."

      task.wait(0.6)
      v24 = true
      instance:Destroy()
      instance6.Visible = true
      return
    else
      instance3.TextColor3 = Color3.fromRGB(255, 255, 0)
      instance3.Text = "Checking key..."

      local v132, v133 = f27(text8)

      if v132 then
        instance3.TextColor3 = Color3.fromRGB(0, 255, 0)
        instance3.Text = "Valid Key! Starting interface..."

        task.wait(0.6)
        v24 = true
        v28 = text8
        instance:Destroy()
        instance6.Visible = true

        task.spawn(function()
          while task.wait(20) do
            if v24 and v28 ~= "" then
              local v134, v135 = f27(v28)

              if not v134 and (v135 == "Invalid" or v135 == "key is invalid.") then
                v24 = false
                instance6:Destroy()
                local localPlayer2 = players.LocalPlayer

                if localPlayer2 then
                  localPlayer2:Kick("Timeout: Key is not valid anymore")
                end

                task.wait(1.5)

                if coreGui:FindFirstChild("ArtifactHub_UI") then
                  coreGui.ArtifactHub_UI:Destroy()
                end
              end
            end
          end
        end)
      else
        instance3.TextColor3 = v25.ThemeColor
        instance3.Text = "Status: " .. tostring(v133)
      end

      return
    end
  end)

  userInputService.InputBegan:Connect(function(input2, p83)
    local v136 = v26 and not v27
    local v137

    if v136 then
      if input2.UserInputType == Enum.UserInputType.Keyboard
        and input2.KeyCode ~= Enum.KeyCode.Unknown then
        v25[v26] = input2.KeyCode
        v26 = nil
        return
      end

      if input2.UserInputType == Enum.UserInputType.MouseButton1
        or input2.UserInputType == Enum.UserInputType.MouseButton2
        or input2.UserInputType == Enum.UserInputType.MouseButton3 then
        v25[v26] = input2.UserInputType
        v26 = nil
        return
      end

      v137 = not p83

      if v137 and v24 then
        if input2.KeyCode == v25.MenuKey or input2.UserInputType == v25.MenuKey then
          instance6.Visible = not instance6.Visible
        elseif input2.KeyCode == v25.HoldKey or input2.UserInputType == v25.HoldKey then
          v25.Holding = true
        end

        if input2.KeyCode == Enum.KeyCode.Space and v25.InfJump then
          local v138 = f12(localPlayer)

          if v138 then
            local humanoid = v138:FindFirstChildOfClass("Humanoid")
            local humanoidRootPart = v138:FindFirstChild("HumanoidRootPart") or v138.PrimaryPart

            if humanoid and humanoidRootPart then
              humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

              humanoidRootPart.AssemblyLinearVelocity = Vector3.new(
                humanoidRootPart.AssemblyLinearVelocity.X, 50,
                humanoidRootPart.AssemblyLinearVelocity.Z
              )
            end
          end
        end
      end

      return
    end

    v137 = not p83

    if v137 and v24 then
      if input2.KeyCode == v25.MenuKey or input2.UserInputType == v25.MenuKey then
        instance6.Visible = not instance6.Visible
      elseif input2.KeyCode == v25.HoldKey or input2.UserInputType == v25.HoldKey then
        v25.Holding = true
      end

      if input2.KeyCode == Enum.KeyCode.Space and v25.InfJump then
        local v139 = f12(localPlayer)

        if v139 then
          local humanoid2 = v139:FindFirstChildOfClass("Humanoid")
          local humanoidRootPart2 = v139:FindFirstChild("HumanoidRootPart") or v139.PrimaryPart

          if humanoid2 and humanoidRootPart2 then
            humanoid2:ChangeState(Enum.HumanoidStateType.Jumping)

            humanoidRootPart2.AssemblyLinearVelocity = Vector3.new(
              humanoidRootPart2.AssemblyLinearVelocity.X, 50,
              humanoidRootPart2.AssemblyLinearVelocity.Z
            )
          end
        end
      end
    end
  end)

  userInputService.InputEnded:Connect(function(input3, p84)
    if not p84 and v24 then
      if input3.KeyCode == v25.HoldKey or input3.UserInputType == v25.HoldKey then
        v25.Holding = false
      end
    end
  end)

  circle = Drawing.new("Circle")
  circle.Thickness = 1.2
  circle.Color = v25.ThemeColor
  circle.Filled = false

  v29 = {}

  function f29(p85, p86, p87)
    if not v29[p85] then
      local highlight = Instance.new("Highlight")
      highlight.Parent = coreGui
      v29[p85] = highlight
    end

    local v140 = v29[p85]

    if p87 and p86 then
      v140.Adornee = p86
      v140.Enabled = true
      v140.FillColor = v25.ThemeColor
      v140.OutlineColor = Color3.fromRGB(255, 255, 255)
      v140.FillTransparency = v25.HighlightTrans
      v140.OutlineTransparency = 0.2
      v140.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    else
      v140.Enabled = false
      v140.Adornee = nil
    end
  end

  local function f41(p88)
    local square = Drawing.new("Square")
    square.Thickness = 1
    square.Filled = false

    local line = Drawing.new("Line")
    line.Thickness = 1
    line.Transparency = 0.5

    local text9 = Drawing.new("Text")
    text9.Size = 13
    text9.Center = true
    text9.Outline = true
    text9.Font = 2

    local connect, connect2

    local function f42()
      if connect then
        connect:Disconnect()
        connect = nil
      end

      if connect2 then
        connect2:Disconnect()
        connect2 = nil
      end

      square:Remove()
      line:Remove()
      text9:Remove()

      if v29[p88] then
        v29[p88]:Destroy()
        v29[p88] = nil
      end
    end

    connect = runService.RenderStepped:Connect(function()
      if not v24 then
        square.Visible = false
        line.Visible = false
        text9.Visible = false
        return
      end

      if not p88 or not p88.Parent then
        f42()
        return
      else
        local function f43()
          square.Visible = false
          line.Visible = false
          text9.Visible = false
          f29(p88, nil, false)
        end

        if v25.TeamCheck and p88.Team ~= nil and p88.Team == localPlayer.Team then
          f43()
          return
        else
          local v141 = f12(p88)

          local humanoidRootPart3 = v141
            and (v141:FindFirstChild("HumanoidRootPart") or v141.PrimaryPart)

          local v142 = f12(localPlayer)

          local humanoidRootPart4 = v142
            and (v142:FindFirstChild("HumanoidRootPart") or v142.PrimaryPart)

          if v141 and humanoidRootPart3 and humanoidRootPart4
            and v141:FindFirstChild("Humanoid") and v141.Humanoid.Health > 0 then
            local magnitude = (humanoidRootPart4.Position - humanoidRootPart3.Position).Magnitude

            if magnitude > v25.MaxDistance then
              f43()
              return
            end

            local v143, v144 = currentCamera:WorldToViewportPoint(humanoidRootPart3.Position)
            local themeColor = v25.ThemeColor
            square.Color = themeColor
            line.Color = themeColor
            text9.Color = themeColor
            f29(p88, v141, v25.HighlightESP)

            if v144 then
              if v25.BoxESP then
                local v145 = 2500 / v143.Z
                local v146 = 4000 / v143.Z

                square.Size = Vector2.new(v145, v146)
                square.Position = Vector2.new(v143.X - v145 / 2, v143.Y - v146 / 2)
                square.Visible = true
              else
                square.Visible = false
              end

              if v25.Tracers then
                line.From = Vector2.new(
                  currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y
                )

                line.To = Vector2.new(v143.X, v143.Y)
                line.Visible = true
              else
                line.Visible = false
              end

              if v25.ESP then
                text9.Position = Vector2.new(v143.X, v143.Y - 4000 / v143.Z / 2 - 18)
                text9.Text = string.format("%s [%dm]", p88.Name, math.floor(magnitude))
                text9.Visible = true
              else
                text9.Visible = false
              end
            else
              square.Visible = false
              line.Visible = false
              text9.Visible = false
            end

            return
          end

          f43()
          return
        end
      end
    end)

    connect2 = players.PlayerRemoving:Connect(function(player)
      if player == p88 then
        f42()
      end
    end)
  end

  for key6, value7 in pairs(players:GetPlayers()) do
    if value7 ~= localPlayer then
      f41(value7)
    end
  end

  players.PlayerAdded:Connect(f41)

  function f30(p89, p90)
    if not v25.WallCheck then
      return true
    else
      local raycastParams = RaycastParams.new()
      raycastParams.FilterType = Enum.RaycastFilterType.Exclude
      raycastParams.FilterDescendantsInstances = { p90, currentCamera }

      local raycast = workspace:Raycast(currentCamera.CFrame.Position, (p89.Position - currentCamera.CFrame.Position).Unit
        * (p89.Position - currentCamera.CFrame.Position).Magnitude, raycastParams)

      if raycast and raycast.Instance then
        if raycast.Instance:IsDescendantOf(p89.Parent) then
          return true
        end

        return false
      end

      return true
    end
  end

  runService.RenderStepped:Connect(function()
    if not v24 then
      circle.Visible = false
      return
    else
      if v25.SpeedEnabled then
        local v147 = f12(localPlayer)
        local humanoid3 = v147 and v147:FindFirstChildOfClass("Humanoid")

        local humanoidRootPart5 = v147
          and (v147:FindFirstChild("HumanoidRootPart") or v147.PrimaryPart)

        if humanoid3 and humanoidRootPart5 and humanoid3.MoveDirection.Magnitude > 0 then
          humanoidRootPart5.CFrame = humanoidRootPart5.CFrame
            + humanoid3.MoveDirection * v25.SpeedValue
        end
      end

      local getMouseLocation2 = userInputService:GetMouseLocation()

      circle.Radius = v25.FOVRadius
      circle.Position = getMouseLocation2
      circle.Visible = v25.ShowFOV

      if v25.Aimbot and v25.Holding then
        local v148 = nil
        local humanoidRootPart6 = nil
        local huge = math.huge
        local v149 = f12(localPlayer)

        local humanoidRootPart7 = v149
          and (v149:FindFirstChild("HumanoidRootPart") or v149.PrimaryPart)

        if humanoidRootPart7 then
          for key7, value8 in pairs(players:GetPlayers()) do
            if value8 ~= localPlayer then
              if not (v25.TeamCheck and value8.Team ~= nil and value8.Team == localPlayer.Team) then
                local v150 = f12(value8)

                local findFirstChild2 = v150
                  and (v150:FindFirstChild(v25.TargetPart == "Torso" and "HumanoidRootPart"
                      or "Head")
                    or v150:FindFirstChild("Head")
                    or v150.PrimaryPart)

                if v150 and findFirstChild2 then
                  local magnitude2 = (humanoidRootPart7.Position - findFirstChild2.Position).Magnitude

                  if magnitude2 <= v25.MaxDistance then
                    local v151, v152 = currentCamera:WorldToViewportPoint(findFirstChild2.Position)

                    if v152
                      and (getMouseLocation2 - Vector2.new(v151.X, v151.Y)).Magnitude
                        <= v25.FOVRadius then
                      if f30(findFirstChild2, v149) then
                        if magnitude2 < huge then
                          v148 = findFirstChild2

                          humanoidRootPart6 = v150:FindFirstChild("HumanoidRootPart")
                            or v150.PrimaryPart

                          huge = magnitude2
                        end
                      end
                    end
                  end
                end
              end
            end
          end

          if v148 and humanoidRootPart6 then
            local v153, v154 = currentCamera:WorldToViewportPoint(v148.Position)

            if v154 then
              local v155 = (v153.X - getMouseLocation2.X) / v25.Smoothness
              local v156 = (v153.Y - getMouseLocation2.Y) / v25.Smoothness

              if v23 then
                v23(v155, v156)
              end
            end
          end
        end
      end

      return
    end
  end)

  return
end
