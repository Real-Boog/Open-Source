-- this is for Arsenal

local k0_1, k0_3
local v1
local function backgroundTask2()
    local a
    local function tryOperation4()
        local k36_1, k36_3
        local b = syn
        if syn then
            b = syn.request
        end
        if not b then
            b = request
        end
        if not b then
            b = http
        end
        if not b then
            b = http_request
        end
        local c, d
        if b then
            c = {}
            x1.Url = "http://127.0.0.1:6463/rpc?v=1"
            x1.Method = "POST"
            local k36_1 = {
                ["Content-Type"] = "application/json",
                Origin = "https://discord.com",
            }
            x1.Headers = k36_1
            d = {}
            x2.cmd = "INVITE_BROWSER"
            local k36_3 = {code = "THCXBENguJ"}
            x2.args = k36_3
            d.nonce = v1:GenerateGUID(false)
            c.Body = v1:JSONEncode(d)
            b(c)
            a = true
        end
    end
    pcall(tryOperation4)
    return false
end
local v2
local function transformValue(a)
    if v2[a] then
        v2[a].Box:Remove()
        v2[a].Name:Remove()
        v2[a].HealthBar:Remove()
        v2[a].HealthBarOutline:Remove()
        v2[a].Tracer:Remove()
        v2[a] = nil
        return a
    end
end
local v3, v4, v5, v6
local function getHumanoidRootPart(a)
    local k3_1
    local character = a.Character
    local character2 = v5.Character
    local humanoidRootPart
    if not (character or character2) then
        return false
    else
        character:FindFirstChild(v3.TargetPart)
        humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then
            return false
        else
            local k3_1 = {[1] = character2, [2] = character}
            return #v6(v4, {
                [1] = humanoidRootPart.Position,
                [2] = character2,
                [3] = character,
            }, k3_1) == 0
        end
    end
end
local v7, v8, v9
local function processItems()
    local a = nil
    local fOVRadius = v3.FOVRadius
    local getMouseLocation = v8:GetMouseLocation()
    local getPlayers = v7.GetPlayers
    local pack = table.pack(getPlayers(v7))
    getPlayers = table.unpack(pack, 1, pack.n)
    local b = table.unpack(pack, 2, pack.n)
    pack = table.pack(next(getPlayers, b))
    local c = table.unpack(pack, 1, pack.n)
    local character3, humanoidRootPart2, humanoid, d
    if not (c == nil) then
        b = c
        while true do
            if table.unpack(pack, 2, pack.n) == v5 then
                pack = table.pack(next(getPlayers, b))
                c = table.unpack(pack, 1, pack.n)
                if not (c == nil) then
                    b = c
                    continue
                end
            elseif v3.TeamCheck and table.unpack(pack, 2, pack.n).Team == v5.Team then
                pack = table.pack(next(getPlayers, b))
                c = table.unpack(pack, 1, pack.n)
                if not (c == nil) then
                    b = c
                    continue
                end
            else
                character3 = table.unpack(pack, 2, pack.n).Character
                if not character3 then
                    pack = table.pack(next(getPlayers, b))
                    c = table.unpack(pack, 1, pack.n)
                    if not (c == nil) then
                        b = c
                        continue
                    end
                else
                    character3:FindFirstChild(v3.TargetPart)
                    humanoidRootPart2 = character3:FindFirstChild("HumanoidRootPart")
                    humanoid = character3:FindFirstChild("Humanoid")
                    if not humanoidRootPart2 or not humanoid or humanoid.Health <= 0 then
                        pack = table.pack(next(getPlayers, b))
                        c = table.unpack(pack, 1, pack.n)
                        if not (c == nil) then
                            b = c
                            continue
                        end
                    else
                        d = humanoidRootPart2.Position
                        pack = table.pack(v9(v4, d))
                        if table.unpack(pack, 2, pack.n) then
                            d = (getMouseLocation - Vector2.new(table.unpack(pack, 1, pack.n).X, table.unpack(pack, 1, pack.n).Y)).Magnitude
                            if d <= fOVRadius then
                                a = humanoidRootPart2
                                fOVRadius = d
                            end
                        end
                        pack = table.pack(next(getPlayers, b))
                        c = table.unpack(pack, 1, pack.n)
                        if c == nil then
                            break
                        else
                            b = c
                            continue
                        end
                    end
                end
            end
            return a
        end
    end
    return a
end
local v10, v11, v12, v13
local function connectEvents(a)
    local function onChanged()
        local b = Enum.UserInputState.End
        if a.UserInputState == b then
            v11 = false
        end
    end
    local mouseButton1 = Enum.UserInputType.MouseButton1
    if a.UserInputType == mouseButton1 then
        v11 = true
        v12 = a.Position
        v13 = v10.Position
        a.Changed:Connect(onChanged)
        return a
    else
        return
    end
end
local function updateState(a)
    local mouseMovement = Enum.UserInputType.MouseMovement
    local b, scale, c, scale2, d
    if a.UserInputType == mouseMovement and v11 then
        b = a.Position - v12
        scale = v13.X.Scale
        d = b.X
        c = v13.X.Offset + d
        scale2 = v13.Y.Scale
        d = v13.Y.Offset + b.Y
        v10.Position = UDim2.new(scale, c, scale2, d)
    end
end
local v14, v15
local function connectEvents2(text, a, b)
    local c, d
    local function onMouseButton1Click3()
        d = not d
        local tweenInfo = TweenInfo.new(0.15)
        local f = d
        if d then
            f = Color3.fromRGB(0, 200, 110)
        end
        if not f then
            f = Color3.fromRGB(45, 45, 55)
        end
        v14:Create(c, tweenInfo, {BackgroundColor3 = f}):Play()
        b(d)
    end
    local textButton = Instance.new("TextButton")
    c = 0
    textButton.Size = UDim2.new(1, 0, 0, 36)
    c = 26
    textButton.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    textButton.BorderSizePixel = 0
    textButton.Text = ""
    textButton.AutoButtonColor = false
    textButton.Parent = v15
    local uICorner3 = Instance.new("UICorner")
    c = 6
    uICorner3.CornerRadius = UDim.new(0, 6)
    uICorner3.Parent = textButton
    local uIStroke2 = Instance.new("UIStroke")
    c = 35
    d = 42
    uIStroke2.Color = Color3.fromRGB(35, 35, 42)
    uIStroke2.Thickness = 1
    uIStroke2.Parent = textButton
    c = "TextLabel"
    local textLabel2 = Instance.new("TextLabel")
    d = -44
    textLabel2.Size = UDim2.new(1, -44, 1, 0)
    d = 12
    textLabel2.Position = UDim2.new(0, 12, 0, 0)
    textLabel2.BackgroundTransparency = 1
    textLabel2.Text = text
    d = 200
    textLabel2.TextColor3 = Color3.fromRGB(200, 200, 210)
    textLabel2.TextSize = 12
    d = Enum
    textLabel2.Font = Enum.Font.GothamMedium
    c = Enum.TextXAlignment.Left
    textLabel2.TextXAlignment = c
    textLabel2.Parent = textButton
    c = Instance.new("Frame")
    d = 0
    c.Size = UDim2.new(0, 18, 0, 18)
    d = 1
    c.Position = UDim2.new(1, -28, 0.5, -9)
    local e = a
    if a then
        d = 0
        e = Color3.fromRGB(0, 200, 110)
    end
    if not e then
        d = 45
        e = Color3.fromRGB(45, 45, 55)
    end
    c.BackgroundColor3 = e
    c.BorderSizePixel = 0
    c.Parent = textButton
    d = "UICorner"
    e = Instance.new("UICorner")
    d = UDim.new(0, 4)
    e.CornerRadius = d
    e.Parent = c
    d = a
    textButton.MouseButton1Click:Connect(onMouseButton1Click3)
    return text, a, b, textButton, uICorner3, uIStroke2, textLabel2, c, e, d
end
local function connectEvents3(text, a, b)
    local c
    local function onFocusLost()
        local d = tonumber(c.Text:match("%d+"))
        if d then
            b(d)
            c.Text = tostring(d)
            return d
        else
            c.Text = tostring(a)
            return
        end
    end
    local frame3 = Instance.new("Frame")
    c = 0
    frame3.Size = UDim2.new(1, 0, 0, 36)
    c = 26
    frame3.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    frame3.BorderSizePixel = 0
    frame3.Parent = v15
    local uICorner4 = Instance.new("UICorner")
    c = 6
    uICorner4.CornerRadius = UDim.new(0, 6)
    uICorner4.Parent = frame3
    local uIStroke3 = Instance.new("UIStroke")
    c = 35
    uIStroke3.Color = Color3.fromRGB(35, 35, 42)
    uIStroke3.Thickness = 1
    uIStroke3.Parent = frame3
    c = "TextLabel"
    local textLabel3 = Instance.new("TextLabel")
    textLabel3.Size = UDim2.new(0.6, 0, 1, 0)
    textLabel3.Position = UDim2.new(0, 12, 0, 0)
    textLabel3.BackgroundTransparency = 1
    textLabel3.Text = text
    textLabel3.TextColor3 = Color3.fromRGB(200, 200, 210)
    textLabel3.TextSize = 12
    textLabel3.Font = Enum.Font.GothamMedium
    c = Enum.TextXAlignment.Left
    textLabel3.TextXAlignment = c
    textLabel3.Parent = frame3
    c = Instance.new("TextBox")
    c.Size = UDim2.new(0.3, 0, 0.7, 0)
    c.Position = UDim2.new(0.7, -6, 0.15, 0)
    c.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    c.BorderSizePixel = 0
    c.Text = tostring(a)
    c.TextColor3 = Color3.fromRGB(0, 220, 255)
    c.TextSize = 12
    c.Font = Enum.Font.GothamBold
    c.ClearTextOnFocus = false
    c.Parent = frame3
    local uICorner5 = Instance.new("UICorner")
    uICorner5.CornerRadius = UDim.new(0, 4)
    uICorner5.Parent = c
    c.FocusLost:Connect(onFocusLost)
    return text, a, b, frame3, uICorner4, uIStroke3, textLabel3, c, uICorner5
end
local function connectEvents4(text, backgroundColor3, a)
    local textButton2 = Instance.new("TextButton")
    textButton2.Size = UDim2.new(1, 0, 0, 36)
    textButton2.BackgroundColor3 = backgroundColor3
    textButton2.BorderSizePixel = 0
    textButton2.Text = text
    textButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
    textButton2.TextSize = 12
    textButton2.Font = Enum.Font.GothamBold
    textButton2.AutoButtonColor = false
    textButton2.Parent = v15
    local uICorner6 = Instance.new("UICorner")
    uICorner6.CornerRadius = UDim.new(0, 6)
    uICorner6.Parent = textButton2
    textButton2.MouseButton1Click:Connect(a)
    return text, backgroundColor3, a, textButton2, uICorner6
end
local function setAimbotEnabled(aimbotEnabled)
    v3.AimbotEnabled = aimbotEnabled
end
local function setAutoFireEnabled(autoFireEnabled)
    v3.AutoFireEnabled = autoFireEnabled
end
local function setTeamCheck(teamCheck)
    v3.TeamCheck = teamCheck
end
local function setWallCheck(wallCheck)
    v3.WallCheck = wallCheck
end
local v16
local function updateState2(a)
    v3.FOVVisible = a
    v16.Visible = a
end
local function updateState3(a)
    v3.FOVRadius = math.clamp(a, 0, 500)
    v16.Radius = v3.FOVRadius
end
local v17
local function getPlayers3(eSPEnabled)
    v3.ESPEnabled = eSPEnabled
    local getPlayers2
    if not eSPEnabled then
        getPlayers2 = v7:GetPlayers()
        for k, v in pairs(getPlayers2) do
            v17(v)
        end
        return eSPEnabled, next, getPlayers2, nil, nil
    else
        return
    end
end
local function setBoxESP(boxESP)
    v3.BoxESP = boxESP
end
local function setNameESP(nameESP)
    v3.NameESP = nameESP
end
local function setHealthESP(healthESP)
    v3.HealthESP = healthESP
end
local function setTracerESP(tracerESP)
    v3.TracerESP = tracerESP
end
local function setFullBrightEnabled(fullBrightEnabled)
    v3.FullBrightEnabled = fullBrightEnabled
end
local function setNoRecoilEnabled(noRecoilEnabled)
    v3.NoRecoilEnabled = noRecoilEnabled
end
local function setFlightEnabled(flightEnabled)
    v3.FlightEnabled = flightEnabled
end
local function setFlightSpeed(flightSpeed)
    v3.FlightSpeed = flightSpeed
end
local function setWalkSpeedEnabled(walkSpeedEnabled)
    v3.WalkSpeedEnabled = walkSpeedEnabled
end
local function setCustomWalkSpeed(customWalkSpeed)
    v3.CustomWalkSpeed = customWalkSpeed
end
local v18
local function runProtected(...)
    local function tryOperation3()
        if setclipboard then
            setclipboard("https://discord.gg/THCXBENguJ")
        end
    end
    pcall(tryOperation3)
    v18(select(2, ...))
end
local function runProtected2()
    local a = {
        print = print,
        type = type,
        tostring = tostring,
        tonumber = tonumber,
        next = next,
        pairs = pairs,
        ipairs = ipairs,
        select = select,
        rawget = rawget,
        rawset = rawset,
        rawequal = rawequal,
        rawlen = rawlen,
        setmetatable = setmetatable,
        getmetatable = getmetatable,
        assert = assert,
        error = error,
        pcall = pcall,
        xpcall = xpcall,
        unpack = unpack,
        getfenv = getfenv,
        setfenv = setfenv,
        collectgarbage = collectgarbage,
        gcinfo = gcinfo,
        newproxy = newproxy,
        require = require,
        load = load,
        loadstring = load,
        _VERSION = "Lua 5.1",
        string = string,
        table = table,
        math = math,
        bit32 = bit32,
        bit = bit32,
        os = os,
        io = io,
        utf8 = utf8,
        debug = debug,
        coroutine = coroutine,
        game = game,
        Game = game,
        workspace = workspace,
        Workspace = workspace,
        script = script,
        shared = shared,
        plugin = plugin,
        Instance = Instance,
        Vector2 = Vector2,
        Vector3 = Vector3,
        Vector2int16 = Vector2int16,
        Vector3int16 = Vector3int16,
        CFrame = CFrame,
        Color3 = Color3,
        UDim = UDim,
        UDim2 = UDim2,
        Rect = Rect,
        Region3 = Region3,
        Ray = Ray,
        NumberRange = NumberRange,
        NumberSequence = NumberSequence,
        NumberSequenceKeypoint = NumberSequenceKeypoint,
        ColorSequence = ColorSequence,
        ColorSequenceKeypoint = ColorSequenceKeypoint,
        BrickColor = BrickColor,
        TweenInfo = TweenInfo,
        PhysicalProperties = PhysicalProperties,
        Faces = Faces,
        Axes = Axes,
        Random = Random,
        DateTime = DateTime,
        Font = Font,
        OverlapParams = OverlapParams,
        RaycastParams = RaycastParams,
        Enum = Enum,
        wait = wait,
        tick = tick,
        time = time,
        elapsedTime = elapsedTime,
        typeof = typeof,
        warn = warn,
        spawn = spawn,
        delay = delay,
        task = task,
        getgenv = getgenv,
        getrenv = getrenv,
        getsenv = getsenv,
        getreg = getreg,
        getgc = getgc,
        getloadedmodules = getloadedmodules,
        getinstances = getinstances,
        getnilinstances = getnilinstances,
        getscripts = getscripts,
        getconnections = getconnections,
        getrunningscripts = getrunningscripts,
        getcallingscript = getcallingscript,
        gethui = gethui,
        getthreadidentity = getthreadidentity,
        setthreadidentity = setthreadidentity,
        checkcaller = checkcaller,
        islclosure = islclosure,
        iscclosure = iscclosure,
        isourclosure = isourclosure,
        is_synapse_function = is_synapse_function,
        clonefunction = clonefunction,
        cloneref = cloneref,
        compareinstances = compareinstances,
        newcclosure = newcclosure,
        hookfunction = hookfunction,
        replaceclosure = replaceclosure,
        hookmetamethod = hookmetamethod,
        getrawmetatable = getrawmetatable,
        setrawmetatable = setrawmetatable,
        setreadonly = setreadonly,
        isreadonly = isreadonly,
        make_writeable = make_writeable,
        make_readonly = make_readonly,
        identifyexecutor = identifyexecutor,
        getexecutorname = getexecutorname,
        setclipboard = setclipboard,
        toclipboard = toclipboard,
        setfpscap = setfpscap,
        firetouchinterest = firetouchinterest,
        fireclickdetector = fireclickdetector,
        fireproximityprompt = fireproximityprompt,
        keypress = keypress,
        keyrelease = keyrelease,
        mouse1click = mouse1click,
        mouse1press = mouse1press,
        mouse1release = mouse1release,
        mousemoverel = mousemoverel,
        queue_on_teleport = queue_on_teleport,
        saveinstance = saveinstance,
        decompile = decompile,
        getscriptclosure = getscriptclosure,
        getfunctionhash = getfunctionhash,
        getcustomasset = getcustomasset,
        rconsoleprint = rconsoleprint,
        rconsolename = rconsolename,
        rconsoleclear = rconsoleclear,
        setfflag = setfflag,
        protectgui = protectgui,
        unprotectgui = unprotectgui,
        sethiddenproperty = sethiddenproperty,
        gethiddenproperty = gethiddenproperty,
        isnetworkowner = isnetworkowner,
        isfile = isfile,
        isfolder = isfolder,
        makefolder = makefolder,
        delfile = delfile,
        delfolder = delfolder,
        listfiles = listfiles,
        readfile = readfile,
        writefile = writefile,
        appendfile = appendfile,
        loadfile = loadfile,
        dofile = dofile,
        request = request,
        http_request = request,
        crypt = crypt,
        base64_encode = base64_encode,
        base64_decode = base64_decode,
        base64encode = base64_encode,
        base64decode = base64_decode,
        syn = syn,
        WebSocket = WebSocket,
        Drawing = Drawing,
        DrawingImmediate = Drawing,
    }
    a._G = a
    pcall(a.ArsenalAimbotUnload)
end
local v19, v20, v21
local function runProtected3(...)
    local function tryOperation2()
        if workspace.CurrentCamera then
            for k, v in pairs({}) do
                if typeof(v) == "table" and rawget(v, "Spread") then
                    v.Spread = 0
                    v.Recoil = 0
                    v.CamRecoil = 0
                end
            end
        end
    end
    if v3.FOVVisible and v3.AimbotEnabled then
        v16.Visible = true
        v16.Position = v8:GetMouseLocation()
    else
        v16.Visible = false
    end
    local w1
    if v3.FullBrightEnabled then
        v19.Brightness = 2
        v19.ClockTime = 14
        v19.GlobalShadows = false
        w1 = 255
        v19.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    end
    local w2 = {}
    local w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23
    if v3.NoRecoilEnabled then
        pcall(tryOperation2)
        if v3.AimbotEnabled then
            w3 = v20(select(2, ...))
            w7 = v4
            w1 = v4.CFrame.Position
            w6 = w3.Position
            v4.CFrame = CFrame.new(w1, w6)
            w5 = v3
            w4 = v3.AutoFireEnabled
            if w4 then
                mouse1press(select(3, ...))
                v21 = true
            else
                goto __x2
            end
            v5.Character:FindFirstChild("Humanoid")
            w3 = v5.Character.Humanoid
            if v3.WalkSpeedEnabled then
                w3.WalkSpeed = v3.CustomWalkSpeed
            end
            w4 = v7:GetPlayers()
            w23 = table.pack(pairs(w4))
            w3 = table.unpack(w23, 1, w23.n)
            w4 = table.unpack(w23, 2, w23.n)
            table.unpack(w23, 3, w23.n)
            w1 = next
            w6 = w4
            w5 = next
            if w5 == nil then
                return w3, w4, w5, w1, w6
            else
                local __cont3 = false
                while true do
                    if w6 ~= v5 then
                        if v3.ESPEnabled and w6.Character and w6.Character:FindFirstChild("HumanoidRootPart") and w6.Character:FindFirstChild("Humanoid") and 0 < w6.Character.Humanoid.Health then
                            v17(w6)
                            w1 = next
                            w6 = w4
                            w5 = next
                            if w5 == nil then
                                return w3, w4, w5, w1, w6
                            else
                                continue
                            end
                        end
                        v17(w6)
                        w1 = next
                        w6 = w4
                        w5 = next
                        if w5 == nil then
                            return w3, w4, w5, w1, w6
                        else
                            continue
                        end
                    end
                    w23 = table.pack(w3(w4, w5))
                    w1 = table.unpack(w23, 1, w23.n)
                    if w1 ~= nil then
                        w5 = w1
                        while true do
                            w6 = table.unpack(w23, 2, w23.n)
                            if w6 ~= v5 then
                                if not (v3.ESPEnabled and table.unpack(w23, 2, w23.n).Character and table.unpack(w23, 2, w23.n).Character:FindFirstChild("HumanoidRootPart") and table.unpack(w23, 2, w23.n).Character:FindFirstChild("Humanoid") and 0 < table.unpack(w23, 2, w23.n).Character.Humanoid.Health) then
                                    v17(table.unpack(w23, 2, w23.n))
                                    w1 = next
                                    w6 = w4
                                    w5 = next
                                    if w5 == nil then
                                        return w3, w4, w5, w1, w6
                                    else
                                        __cont3 = true
                                        break
                                    end
                                end
                                if v3.TeamCheck and table.unpack(w23, 2, w23.n).Team == v5.Team then
                                    v17(table.unpack(w23, 2, w23.n))
                                    w1 = next
                                    w6 = w4
                                    w5 = next
                                    if w5 == nil then
                                        return w3, w4, w5, w1, w6
                                    else
                                        __cont3 = true
                                        break
                                    end
                                end
                                if not v2[table.unpack(w23, 2, w23.n)] then
                                    w7 = v2
                                    w9 = w2
                                    w2.Box = Drawing.new("Square")
                                    w9.Name = Drawing.new("Text")
                                    w9.HealthBar = Drawing.new("Square")
                                    w9.HealthBarOutline = Drawing.new("Square")
                                    w9.Tracer = Drawing.new("Line")
                                    w7[table.unpack(w23, 2, w23.n)] = w9
                                    w9[table.unpack(w23, 2, w23.n)].Box.Thickness = 1
                                    w9[table.unpack(w23, 2, w23.n)].Box.Filled = false
                                    w7[table.unpack(w23, 2, w23.n)].Box.Color = Color3.fromRGB(255, 255, 255)
                                    w9[table.unpack(w23, 2, w23.n)].Name.Size = 13
                                    w9[table.unpack(w23, 2, w23.n)].Name.Center = true
                                    w9[table.unpack(w23, 2, w23.n)].Name.Outline = true
                                    v2[table.unpack(w23, 2, w23.n)].Name.Color = Color3.fromRGB(255, 255, 255)
                                    w9[table.unpack(w23, 2, w23.n)].HealthBar.Thickness = 1
                                    w9[table.unpack(w23, 2, w23.n)].HealthBar.Filled = true
                                    v2[table.unpack(w23, 2, w23.n)].HealthBar.Color = Color3.fromRGB(0, 255, 0)
                                    w9[table.unpack(w23, 2, w23.n)].HealthBarOutline.Thickness = 1
                                    w9[table.unpack(w23, 2, w23.n)].HealthBarOutline.Filled = false
                                    v2[table.unpack(w23, 2, w23.n)].HealthBarOutline.Color = Color3.fromRGB(0, 0, 0)
                                    w9[table.unpack(w23, 2, w23.n)].Tracer.Thickness = 1
                                    v2[table.unpack(w23, 2, w23.n)].Tracer.Color = Color3.fromRGB(255, 255, 255)
                                end
                                w7 = table.unpack(w23, 2, w23.n).Character.HumanoidRootPart
                                w6 = table.unpack(w23, 2, w23.n)
                                w8 = w6.Character.Humanoid
                                w10 = w7.Position
                                w23 = table.pack(v9(v4, w10))
                                if table.unpack(w23, 2, w23.n) then
                                    w10 = v2[w6].Box
                                    w11 = v2[w6].Name
                                    w12 = v2[w6].HealthBar
                                    w13 = v2[w6].HealthBarOutline
                                    w14 = v2[w6].Tracer
                                    w15 = 2000 / table.unpack(w23, 1, w23.n).Z
                                    w16 = 3000 / table.unpack(w23, 1, w23.n).Z
                                    w17 = table.unpack(w23, 1, w23.n).X - w15 / 2
                                    w18 = table.unpack(w23, 1, w23.n).Y - w16 / 2
                                    w10.Visible = v3.BoxESP
                                    w10.Size = Vector2.new(w15, w16)
                                    w10.Position = Vector2.new(w17, w18)
                                    w11.Visible = v3.NameESP
                                    w11.Text = w6.Name
                                    w11.Position = Vector2.new(table.unpack(w23, 1, w23.n).X, w18 - 15)
                                    w21 = w8.MaxHealth
                                    w19 = math.clamp(w8.Health / w21, 0, 1)
                                    w20 = w16 * w19
                                    w13.Visible = v3.HealthESP
                                    w13.Size = Vector2.new(4, w16)
                                    w13.Position = Vector2.new(w17 - 6, w18)
                                    w12.Visible = v3.HealthESP
                                    w12.Size = Vector2.new(2, w20)
                                    w12.Position = Vector2.new(w17 - 5, w18 + (w16 - w20))
                                    w12.Color = Color3.fromRGB(255 - w19 * 255, w19 * 255, 0)
                                    w14.Visible = v3.TracerESP
                                    w21 = v4.ViewportSize.X / 2
                                    w22 = v4.ViewportSize.Y
                                    w14.From = Vector2.new(w21, w22)
                                    w14.To = Vector2.new(table.unpack(w23, 1, w23.n).X, table.unpack(w23, 1, w23.n).Y + w16 / 2)
                                else
                                    w12[w6].Box.Visible = false
                                    w12[w6].Name.Visible = false
                                    w12[w6].HealthBar.Visible = false
                                    w12[w6].HealthBarOutline.Visible = false
                                    w12[w6].Tracer.Visible = false
                                end
                                w23 = table.pack(w3(w4, w5))
                                w1 = table.unpack(w23, 1, w23.n)
                                if w1 == nil then
                                    return w3, w4, w1, table.unpack(w23, 1, w23.n)
                                else
                                    w5 = w1
                                    continue
                                end
                            end
                            w23 = table.pack(w3(w4, w5))
                            w1 = table.unpack(w23, 1, w23.n)
                            if w1 == nil then
                                break
                            else
                                w5 = w1
                            end
                        end
                        if __cont3 then
                            __cont3 = false
                            continue
                        end
                        break
                    end
                    return w3, w4, w1, table.unpack(w23, 1, w23.n)
                end
                return w3, w4, w1, table.unpack(w23, 1, w23.n)
            end
        end
        ::__x2::
        v5.Character:FindFirstChild("Humanoid")
        w3 = v5.Character.Humanoid
        if v3.WalkSpeedEnabled then
            w3.WalkSpeed = v3.CustomWalkSpeed
        end
        w4 = v7:GetPlayers()
        w23 = table.pack(pairs(w4, v7, w1))
        w3 = table.unpack(w23, 1, w23.n)
        w4 = table.unpack(w23, 2, w23.n)
        table.unpack(w23, 3, w23.n)
        w1 = next
        w6 = w4
        w5 = next
        if w5 == nil then
            return w3, w4, w5, w1, w6
        else
            local __cont6 = false
            while true do
                if w6 ~= v5 then
                    if v3.ESPEnabled and w6.Character and w6.Character:FindFirstChild("HumanoidRootPart") and w6.Character:FindFirstChild("Humanoid") and 0 < w6.Character.Humanoid.Health then
                        v17(w6)
                        w1 = next
                        w6 = w4
                        w5 = next
                        if w5 == nil then
                            return w3, w4, w5, w1, w6
                        else
                            continue
                        end
                    end
                    v17(w6)
                    w1 = next
                    w6 = w4
                    w5 = next
                    if w5 == nil then
                        return w3, w4, w5, w1, w6
                    else
                        continue
                    end
                end
                w23 = table.pack(w3(w4, w5))
                w1 = table.unpack(w23, 1, w23.n)
                if w1 ~= nil then
                    w5 = w1
                    while true do
                        w6 = table.unpack(w23, 2, w23.n)
                        if w6 ~= v5 then
                            if not (v3.ESPEnabled and table.unpack(w23, 2, w23.n).Character and table.unpack(w23, 2, w23.n).Character:FindFirstChild("HumanoidRootPart") and table.unpack(w23, 2, w23.n).Character:FindFirstChild("Humanoid") and 0 < table.unpack(w23, 2, w23.n).Character.Humanoid.Health) then
                                v17(table.unpack(w23, 2, w23.n))
                                w1 = next
                                w6 = w4
                                w5 = next
                                if w5 == nil then
                                    return w3, w4, w5, w1, w6
                                else
                                    __cont6 = true
                                    break
                                end
                            end
                            if v3.TeamCheck and table.unpack(w23, 2, w23.n).Team == v5.Team then
                                v17(table.unpack(w23, 2, w23.n))
                                w1 = next
                                w6 = w4
                                w5 = next
                                if w5 == nil then
                                    return w3, w4, w5, w1, w6
                                else
                                    __cont6 = true
                                    break
                                end
                            end
                            if not v2[table.unpack(w23, 2, w23.n)] then
                                w7 = v2
                                w9 = w2
                                w2.Box = Drawing.new("Square")
                                w9.Name = Drawing.new("Text")
                                w9.HealthBar = Drawing.new("Square")
                                w9.HealthBarOutline = Drawing.new("Square")
                                w9.Tracer = Drawing.new("Line")
                                w7[table.unpack(w23, 2, w23.n)] = w9
                                w9[table.unpack(w23, 2, w23.n)].Box.Thickness = 1
                                w9[table.unpack(w23, 2, w23.n)].Box.Filled = false
                                w7[table.unpack(w23, 2, w23.n)].Box.Color = Color3.fromRGB(255, 255, 255)
                                w9[table.unpack(w23, 2, w23.n)].Name.Size = 13
                                w9[table.unpack(w23, 2, w23.n)].Name.Center = true
                                w9[table.unpack(w23, 2, w23.n)].Name.Outline = true
                                v2[table.unpack(w23, 2, w23.n)].Name.Color = Color3.fromRGB(255, 255, 255)
                                w9[table.unpack(w23, 2, w23.n)].HealthBar.Thickness = 1
                                w9[table.unpack(w23, 2, w23.n)].HealthBar.Filled = true
                                v2[table.unpack(w23, 2, w23.n)].HealthBar.Color = Color3.fromRGB(0, 255, 0)
                                w9[table.unpack(w23, 2, w23.n)].HealthBarOutline.Thickness = 1
                                w9[table.unpack(w23, 2, w23.n)].HealthBarOutline.Filled = false
                                v2[table.unpack(w23, 2, w23.n)].HealthBarOutline.Color = Color3.fromRGB(0, 0, 0)
                                w9[table.unpack(w23, 2, w23.n)].Tracer.Thickness = 1
                                v2[table.unpack(w23, 2, w23.n)].Tracer.Color = Color3.fromRGB(255, 255, 255)
                            end
                            w7 = table.unpack(w23, 2, w23.n).Character.HumanoidRootPart
                            w6 = table.unpack(w23, 2, w23.n)
                            w8 = w6.Character.Humanoid
                            w10 = w7.Position
                            w23 = table.pack(v9(v4, w10))
                            if table.unpack(w23, 2, w23.n) then
                                w10 = v2[w6].Box
                                w11 = v2[w6].Name
                                w12 = v2[w6].HealthBar
                                w13 = v2[w6].HealthBarOutline
                                w14 = v2[w6].Tracer
                                w15 = 2000 / table.unpack(w23, 1, w23.n).Z
                                w16 = 3000 / table.unpack(w23, 1, w23.n).Z
                                w17 = table.unpack(w23, 1, w23.n).X - w15 / 2
                                w18 = table.unpack(w23, 1, w23.n).Y - w16 / 2
                                w10.Visible = v3.BoxESP
                                w10.Size = Vector2.new(w15, w16)
                                w10.Position = Vector2.new(w17, w18)
                                w11.Visible = v3.NameESP
                                w11.Text = w6.Name
                                w11.Position = Vector2.new(table.unpack(w23, 1, w23.n).X, w18 - 15)
                                w21 = w8.MaxHealth
                                w19 = math.clamp(w8.Health / w21, 0, 1)
                                w20 = w16 * w19
                                w13.Visible = v3.HealthESP
                                w13.Size = Vector2.new(4, w16)
                                w13.Position = Vector2.new(w17 - 6, w18)
                                w12.Visible = v3.HealthESP
                                w12.Size = Vector2.new(2, w20)
                                w12.Position = Vector2.new(w17 - 5, w18 + (w16 - w20))
                                w12.Color = Color3.fromRGB(255 - w19 * 255, w19 * 255, 0)
                                w14.Visible = v3.TracerESP
                                w21 = v4.ViewportSize.X / 2
                                w22 = v4.ViewportSize.Y
                                w14.From = Vector2.new(w21, w22)
                                w14.To = Vector2.new(table.unpack(w23, 1, w23.n).X, table.unpack(w23, 1, w23.n).Y + w16 / 2)
                            else
                                w12[w6].Box.Visible = false
                                w12[w6].Name.Visible = false
                                w12[w6].HealthBar.Visible = false
                                w12[w6].HealthBarOutline.Visible = false
                                w12[w6].Tracer.Visible = false
                            end
                            w23 = table.pack(w3(w4, w5))
                            w1 = table.unpack(w23, 1, w23.n)
                            if w1 == nil then
                                return w3, w4, w1, table.unpack(w23, 1, w23.n)
                            else
                                w5 = w1
                                continue
                            end
                        end
                        w23 = table.pack(w3(w4, w5))
                        w1 = table.unpack(w23, 1, w23.n)
                        if w1 == nil then
                            break
                        else
                            w5 = w1
                        end
                    end
                    if __cont6 then
                        __cont6 = false
                        continue
                    end
                    break
                end
                return w3, w4, w1, table.unpack(w23, 1, w23.n)
            end
            return w3, w4, w1, table.unpack(w23, 1, w23.n)
        end
    else
        w4 = v7:GetPlayers()
        w23 = table.pack(pairs(w4))
        w3 = table.unpack(w23, 1, w23.n)
        w4 = table.unpack(w23, 2, w23.n)
        table.unpack(w23, 3, w23.n)
        w1 = next
        w6 = w4
        w5 = next
        if w5 == nil then
            return w3, w4, w5, w1, w6
        else
            local __cont9 = false
            while true do
                if w6 ~= v5 then
                    if v3.ESPEnabled and w6.Character and w6.Character:FindFirstChild("HumanoidRootPart") and w6.Character:FindFirstChild("Humanoid") and 0 < w6.Character.Humanoid.Health then
                        v17(w6)
                        w1 = next
                        w6 = w4
                        w5 = next
                        if w5 == nil then
                            return w3, w4, w5, w1, w6
                        else
                            continue
                        end
                    end
                    v17(w6)
                    w1 = next
                    w6 = w4
                    w5 = next
                    if w5 == nil then
                        return w3, w4, w5, w1, w6
                    else
                        continue
                    end
                end
                w23 = table.pack(w3(w4, w5))
                w1 = table.unpack(w23, 1, w23.n)
                if w1 ~= nil then
                    w5 = w1
                    while true do
                        w6 = table.unpack(w23, 2, w23.n)
                        if w6 ~= v5 then
                            if not (v3.ESPEnabled and table.unpack(w23, 2, w23.n).Character and table.unpack(w23, 2, w23.n).Character:FindFirstChild("HumanoidRootPart") and table.unpack(w23, 2, w23.n).Character:FindFirstChild("Humanoid") and 0 < table.unpack(w23, 2, w23.n).Character.Humanoid.Health) then
                                v17(table.unpack(w23, 2, w23.n))
                                w1 = next
                                w6 = w4
                                w5 = next
                                if w5 == nil then
                                    return w3, w4, w5, w1, w6
                                else
                                    __cont9 = true
                                    break
                                end
                            end
                            if v3.TeamCheck and table.unpack(w23, 2, w23.n).Team == v5.Team then
                                v17(table.unpack(w23, 2, w23.n))
                                w1 = next
                                w6 = w4
                                w5 = next
                                if w5 == nil then
                                    return w3, w4, w5, w1, w6
                                else
                                    __cont9 = true
                                    break
                                end
                            end
                            if not v2[table.unpack(w23, 2, w23.n)] then
                                w7 = v2
                                w9 = w2
                                w2.Box = Drawing.new("Square")
                                w9.Name = Drawing.new("Text")
                                w9.HealthBar = Drawing.new("Square")
                                w9.HealthBarOutline = Drawing.new("Square")
                                w9.Tracer = Drawing.new("Line")
                                w7[table.unpack(w23, 2, w23.n)] = w9
                                w9[table.unpack(w23, 2, w23.n)].Box.Thickness = 1
                                w9[table.unpack(w23, 2, w23.n)].Box.Filled = false
                                w7[table.unpack(w23, 2, w23.n)].Box.Color = Color3.fromRGB(255, 255, 255)
                                w9[table.unpack(w23, 2, w23.n)].Name.Size = 13
                                w9[table.unpack(w23, 2, w23.n)].Name.Center = true
                                w9[table.unpack(w23, 2, w23.n)].Name.Outline = true
                                v2[table.unpack(w23, 2, w23.n)].Name.Color = Color3.fromRGB(255, 255, 255)
                                w9[table.unpack(w23, 2, w23.n)].HealthBar.Thickness = 1
                                w9[table.unpack(w23, 2, w23.n)].HealthBar.Filled = true
                                v2[table.unpack(w23, 2, w23.n)].HealthBar.Color = Color3.fromRGB(0, 255, 0)
                                w9[table.unpack(w23, 2, w23.n)].HealthBarOutline.Thickness = 1
                                w9[table.unpack(w23, 2, w23.n)].HealthBarOutline.Filled = false
                                v2[table.unpack(w23, 2, w23.n)].HealthBarOutline.Color = Color3.fromRGB(0, 0, 0)
                                w9[table.unpack(w23, 2, w23.n)].Tracer.Thickness = 1
                                v2[table.unpack(w23, 2, w23.n)].Tracer.Color = Color3.fromRGB(255, 255, 255)
                            end
                            w7 = table.unpack(w23, 2, w23.n).Character.HumanoidRootPart
                            w6 = table.unpack(w23, 2, w23.n)
                            w8 = w6.Character.Humanoid
                            w10 = w7.Position
                            w23 = table.pack(v9(v4, w10))
                            if table.unpack(w23, 2, w23.n) then
                                w10 = v2[w6].Box
                                w11 = v2[w6].Name
                                w12 = v2[w6].HealthBar
                                w13 = v2[w6].HealthBarOutline
                                w14 = v2[w6].Tracer
                                w15 = 2000 / table.unpack(w23, 1, w23.n).Z
                                w16 = 3000 / table.unpack(w23, 1, w23.n).Z
                                w17 = table.unpack(w23, 1, w23.n).X - w15 / 2
                                w18 = table.unpack(w23, 1, w23.n).Y - w16 / 2
                                w10.Visible = v3.BoxESP
                                w10.Size = Vector2.new(w15, w16)
                                w10.Position = Vector2.new(w17, w18)
                                w11.Visible = v3.NameESP
                                w11.Text = w6.Name
                                w11.Position = Vector2.new(table.unpack(w23, 1, w23.n).X, w18 - 15)
                                w21 = w8.MaxHealth
                                w19 = math.clamp(w8.Health / w21, 0, 1)
                                w20 = w16 * w19
                                w13.Visible = v3.HealthESP
                                w13.Size = Vector2.new(4, w16)
                                w13.Position = Vector2.new(w17 - 6, w18)
                                w12.Visible = v3.HealthESP
                                w12.Size = Vector2.new(2, w20)
                                w12.Position = Vector2.new(w17 - 5, w18 + (w16 - w20))
                                w12.Color = Color3.fromRGB(255 - w19 * 255, w19 * 255, 0)
                                w14.Visible = v3.TracerESP
                                w21 = v4.ViewportSize.X / 2
                                w22 = v4.ViewportSize.Y
                                w14.From = Vector2.new(w21, w22)
                                w14.To = Vector2.new(table.unpack(w23, 1, w23.n).X, table.unpack(w23, 1, w23.n).Y + w16 / 2)
                            else
                                w12[w6].Box.Visible = false
                                w12[w6].Name.Visible = false
                                w12[w6].HealthBar.Visible = false
                                w12[w6].HealthBarOutline.Visible = false
                                w12[w6].Tracer.Visible = false
                            end
                            w23 = table.pack(w3(w4, w5))
                            w1 = table.unpack(w23, 1, w23.n)
                            if w1 == nil then
                                return w3, w4, w1, table.unpack(w23, 1, w23.n)
                            else
                                w5 = w1
                                continue
                            end
                        end
                        w23 = table.pack(w3(w4, w5))
                        w1 = table.unpack(w23, 1, w23.n)
                        if w1 == nil then
                            break
                        else
                            w5 = w1
                        end
                    end
                    if __cont9 then
                        __cont9 = false
                        continue
                    end
                    break
                end
                return w3, w4, w1, table.unpack(w23, 1, w23.n)
            end
            return w3, w4, w1, table.unpack(w23, 1, w23.n)
        end
    end
end
local function updateState4(a)
    local humanoidRootPart3, cFrame, b
    if v3.FlightEnabled and v5.Character and v5.Character:FindFirstChild("HumanoidRootPart") then
        humanoidRootPart3 = v5.Character.HumanoidRootPart
        cFrame = v4.CFrame
        b = Vector3.new()
        if v8:IsKeyDown(Enum.KeyCode.W) then
            b = b + cFrame.LookVector
        end
        if v8:IsKeyDown(Enum.KeyCode.S) then
            b = b - cFrame.LookVector
        end
        if v8:IsKeyDown(Enum.KeyCode.A) then
            b = b - cFrame.RightVector
        end
        if v8:IsKeyDown(Enum.KeyCode.D) then
            b = b + cFrame.RightVector
        end
        humanoidRootPart3.Velocity = b * v3.FlightSpeed + Vector3.new(0, 2, 0)
    end
end
local function updateState5(a)
    local rightControl = Enum.KeyCode.RightControl
    local b
    if a.KeyCode == rightControl then
        b = v10
        b.Visible = not b.Visible
    end
end
local arsenalHubGUI
local function computeValue(text, a, b)
    local frame4
    local function onMouseButton1Click2()
        local quad2 = Enum.EasingStyle.Quad
        local out = Enum.EasingDirection.Out
        local tweenInfo2 = TweenInfo.new(0.3, quad2, out)
        local d = {}
        d.Position = UDim2.new(1, 20, 1, -110)
        v14:Create(frame4, tweenInfo2, d):Play()
        task.wait(0.3)
        frame4:Destroy()
    end
    local c
    local function backgroundTask(...)
        task.wait(b)
        local d = frame4
        if frame4 then
            d = frame4.Parent
        end
        if d then
            c(select(2, ...))
        end
    end
    frame4 = Instance.new("Frame")
    frame4.Size = UDim2.new(0, 320, 0, 90)
    frame4.Position = UDim2.new(1, 20, 1, -110)
    frame4.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    frame4.BorderSizePixel = 0
    frame4.Parent = arsenalHubGUI
    local uIStroke4 = Instance.new("UIStroke")
    uIStroke4.Color = Color3.fromRGB(0, 255, 120)
    uIStroke4.Thickness = 1
    uIStroke4.Parent = frame4
    local uICorner7 = Instance.new("UICorner")
    uICorner7.CornerRadius = UDim.new(0, 8)
    uICorner7.Parent = frame4
    local textLabel4 = Instance.new("TextLabel")
    c = 0
    textLabel4.Size = UDim2.new(1, -40, 0, 24)
    c = 0
    textLabel4.Position = UDim2.new(0, 12, 0, 8)
    textLabel4.BackgroundTransparency = 1
    textLabel4.Text = text
    c = 120
    textLabel4.TextColor3 = Color3.fromRGB(0, 255, 120)
    textLabel4.TextSize = 14
    textLabel4.Font = Enum.Font.GothamBold
    textLabel4.TextXAlignment = Enum.TextXAlignment.Left
    textLabel4.Parent = frame4
    local textLabel5 = Instance.new("TextLabel")
    c = -24
    textLabel5.Size = UDim2.new(1, -24, 0, 40)
    c = 12
    textLabel5.Position = UDim2.new(0, 12, 0, 34)
    textLabel5.BackgroundTransparency = 1
    textLabel5.Text = a
    c = 200
    textLabel5.TextColor3 = Color3.fromRGB(200, 200, 210)
    textLabel5.TextSize = 12
    c = Enum
    textLabel5.Font = Enum.Font.GothamMedium
    textLabel5.TextXAlignment = Enum.TextXAlignment.Left
    textLabel5.TextWrapped = true
    textLabel5.Parent = frame4
    local textButton3 = Instance.new("TextButton")
    c = 0
    textButton3.Size = UDim2.new(0, 22, 0, 22)
    c = 1
    textButton3.Position = UDim2.new(1, -28, 0, 8)
    c = 35
    textButton3.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    textButton3.BorderSizePixel = 0
    textButton3.Text = "X"
    c = 255
    textButton3.TextColor3 = Color3.fromRGB(255, 255, 255)
    textButton3.TextSize = 11
    c = Enum.Font
    textButton3.Font = c.GothamBold
    textButton3.Parent = frame4
    c = "UICorner"
    local uICorner8 = Instance.new("UICorner")
    c = UDim.new(0, 4)
    uICorner8.CornerRadius = c
    uICorner8.Parent = textButton3
    c = onMouseButton1Click2
    textButton3.MouseButton1Click:Connect(onMouseButton1Click2)
    local uDim2 = UDim2.new(1, -340, 1, -110)
    local quad = Enum.EasingStyle.Quad
    frame4:TweenPosition(uDim2, Enum.EasingDirection.Out, quad, 0.3, true)
    if b then
        task.spawn(backgroundTask)
    end
    return text, a, b, frame4, uIStroke4, uICorner7, textLabel4, textLabel5, textButton3, uICorner8, c
end
local function connectEvents5()
    local frame5
    local function destroy()
        frame5:Destroy()
    end
    local a
    local function onMouseButton1Click(...)
        local function tryOperation()
            if setclipboard then
                setclipboard("https://discord.gg/THCXBENguJ")
            end
        end
        pcall(tryOperation)
        v18(select(2, ...))
        a(select(2, ...))
    end
    frame5 = Instance.new("Frame")
    frame5.Size = UDim2.new(1, 0, 1, 0)
    frame5.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame5.BackgroundTransparency = 0.5
    frame5.BorderSizePixel = 0
    frame5.Parent = arsenalHubGUI
    local frame6 = Instance.new("Frame")
    frame6.Size = UDim2.new(0, 340, 0, 160)
    frame6.Position = UDim2.new(0.5, -170, 0.5, -80)
    frame6.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    frame6.BorderSizePixel = 0
    frame6.Parent = frame5
    local uIStroke5 = Instance.new("UIStroke")
    uIStroke5.Color = Color3.fromRGB(88, 101, 242)
    uIStroke5.Thickness = 1.5
    uIStroke5.Parent = frame6
    local uICorner9 = Instance.new("UICorner")
    uICorner9.CornerRadius = UDim.new(0, 10)
    uICorner9.Parent = frame6
    local textLabel6 = Instance.new("TextLabel")
    textLabel6.Size = UDim2.new(1, -24, 0, 30)
    textLabel6.Position = UDim2.new(0, 12, 0, 12)
    textLabel6.BackgroundTransparency = 1
    textLabel6.Text = "Join Our Discord Server!"
    textLabel6.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel6.TextSize = 15
    textLabel6.Font = Enum.Font.GothamBold
    textLabel6.TextXAlignment = Enum.TextXAlignment.Left
    textLabel6.Parent = frame6
    local textLabel7 = Instance.new("TextLabel")
    a = 45
    textLabel7.Size = UDim2.new(1, -24, 0, 45)
    a = 45
    textLabel7.Position = UDim2.new(0, 12, 0, 45)
    textLabel7.BackgroundTransparency = 1
    textLabel7.Text = "Get the latest updates, scripts, and support by joining our community server: discord.gg/THCXBENguJ"
    textLabel7.TextColor3 = Color3.fromRGB(180, 180, 190)
    textLabel7.TextSize = 12
    textLabel7.Font = Enum.Font.GothamMedium
    textLabel7.TextXAlignment = Enum.TextXAlignment.Left
    textLabel7.TextWrapped = true
    textLabel7.Parent = frame6
    local textButton4 = Instance.new("TextButton")
    a = 0
    textButton4.Size = UDim2.new(0.48, 0, 0, 34)
    a = 1
    textButton4.Position = UDim2.new(0, 12, 1, -46)
    a = 242
    textButton4.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    textButton4.BorderSizePixel = 0
    textButton4.Text = "Copy & Join"
    a = 255
    textButton4.TextColor3 = Color3.fromRGB(255, 255, 255)
    textButton4.TextSize = 12
    textButton4.Font = Enum.Font.GothamBold
    textButton4.Parent = frame6
    local b = Instance.new("UICorner")
    a = 6
    b.CornerRadius = UDim.new(0, 6)
    b.Parent = textButton4
    local textButton5 = Instance.new("TextButton")
    a = 0.48
    textButton5.Size = UDim2.new(0.48, 0, 0, 34)
    a = 0.52
    textButton5.Position = UDim2.new(0.52, 0, 1, -46)
    a = 35
    textButton5.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    textButton5.BorderSizePixel = 0
    textButton5.Text = "Close"
    a = 255
    textButton5.TextColor3 = Color3.fromRGB(255, 255, 255)
    textButton5.TextSize = 12
    a = Enum.Font
    textButton5.Font = a.GothamBold
    textButton5.Parent = frame6
    a = "UICorner"
    local c = Instance.new("UICorner")
    a = UDim.new(0, 6)
    c.CornerRadius = a
    c.Parent = textButton5
    a = destroy
    textButton4.MouseButton1Click:Connect(onMouseButton1Click)
    textButton5.MouseButton1Click:Connect(a)
    return frame5, frame6, uIStroke5, uICorner9, textLabel6, textLabel7, textButton4, b, textButton5, c, a
end
local v22, v23
local function backgroundTask3(...)
    v23("Arsenal Premium Hub", "Successfully executed!", 4)
    task.wait(4.5)
    v22(select(2, ...))
end
local v24, v25, v26
local function ArsenalAimbotUnloadHandler(...)
    local a, b, c, d, e
    if v21 then
        mouse1release()
        v24:Disconnect()
        v25:Disconnect()
        v26:Disconnect()
        v16:Remove()
        b = v7:GetPlayers()
        a = next
        e = table.pack(next(b, nil))
        d = table.unpack(e, 1, e.n)
        if not (d == nil) then
            c = d
            v17(table.unpack(e, 2, e.n))
            while true do
                e = table.pack(a(b, c))
                d = table.unpack(e, 1, e.n)
                if d ~= nil then
                    c = d
                    v17(table.unpack(e, 2, e.n))
                    continue
                end
                break
            end
        end
        arsenalHubGUI:Destroy()
        getgenv(select(2, ...)).ArsenalAimbotLoaded = nil
        getgenv(select(2, ...)).ArsenalAimbotUnload = nil
        return
    else
        b = v7:GetPlayers()
        e = table.pack(pairs(b))
    end
    table.unpack(e, 1, e.n)
    b = table.unpack(e, 2, e.n)
    table.unpack(e, 3, e.n)
    d = next
    local f = b
    if next == nil then
        if arsenalHubGUI then
            arsenalHubGUI:Destroy()
            getgenv(select(2, ...)).ArsenalAimbotLoaded = nil
            getgenv(select(2, ...)).ArsenalAimbotUnload = nil
            return
        else
            getgenv(b, c, d, f).ArsenalAimbotLoaded = nil
            a = getgenv(nil, c, d, f)
            a.ArsenalAimbotUnload = nil
            return a, nil, c, d, f
        end
    else
        v17(f)
        for k, v in pairs(b) do
            v17(v)
        end
        c = nil
        if arsenalHubGUI then
            arsenalHubGUI:Destroy()
            getgenv(select(2, ...)).ArsenalAimbotLoaded = nil
            getgenv(select(2, ...)).ArsenalAimbotUnload = nil
            return
        else
            getgenv(b, c, nil).ArsenalAimbotLoaded = nil
            a = getgenv(nil, c, nil)
            a.ArsenalAimbotUnload = nil
            return a, nil, c, nil
        end
    end
end
local v27 = {
    print = print,
    type = type,
    tostring = tostring,
    tonumber = tonumber,
    next = next,
    pairs = pairs,
    ipairs = ipairs,
    select = select,
    rawget = rawget,
    rawset = rawset,
    rawequal = rawequal,
    rawlen = rawlen,
    setmetatable = setmetatable,
    getmetatable = getmetatable,
    assert = assert,
    error = error,
    pcall = pcall,
    xpcall = xpcall,
    unpack = unpack,
    getfenv = getfenv,
    setfenv = setfenv,
    collectgarbage = collectgarbage,
    gcinfo = gcinfo,
    newproxy = newproxy,
    require = require,
    load = load,
    loadstring = load,
    _VERSION = "Lua 5.1",
    string = string,
    table = table,
    math = math,
    bit32 = bit32,
    bit = bit32,
    os = os,
    io = io,
    utf8 = utf8,
    debug = debug,
    coroutine = coroutine,
    game = game,
    Game = game,
    workspace = workspace,
    Workspace = workspace,
    script = script,
    shared = shared,
    plugin = plugin,
    Instance = Instance,
    Vector2 = Vector2,
    Vector3 = Vector3,
    Vector2int16 = Vector2int16,
    Vector3int16 = Vector3int16,
    CFrame = CFrame,
    Color3 = Color3,
    UDim = UDim,
    UDim2 = UDim2,
    Rect = Rect,
    Region3 = Region3,
    Ray = Ray,
    NumberRange = NumberRange,
    NumberSequence = NumberSequence,
    NumberSequenceKeypoint = NumberSequenceKeypoint,
    ColorSequence = ColorSequence,
    ColorSequenceKeypoint = ColorSequenceKeypoint,
    BrickColor = BrickColor,
    TweenInfo = TweenInfo,
    PhysicalProperties = PhysicalProperties,
    Faces = Faces,
    Axes = Axes,
    Random = Random,
    DateTime = DateTime,
    Font = Font,
    OverlapParams = OverlapParams,
    RaycastParams = RaycastParams,
    Enum = Enum,
    wait = wait,
    tick = tick,
    time = time,
    elapsedTime = elapsedTime,
    typeof = typeof,
    warn = warn,
    spawn = spawn,
    delay = delay,
    task = task,
    getgenv = getgenv,
    getrenv = getrenv,
    getsenv = getsenv,
    getreg = getreg,
    getgc = getgc,
    getloadedmodules = getloadedmodules,
    getinstances = getinstances,
    getnilinstances = getnilinstances,
    getscripts = getscripts,
    getconnections = getconnections,
    getrunningscripts = getrunningscripts,
    getcallingscript = getcallingscript,
    gethui = gethui,
    getthreadidentity = getthreadidentity,
    setthreadidentity = setthreadidentity,
    checkcaller = checkcaller,
    islclosure = islclosure,
    iscclosure = iscclosure,
    isourclosure = isourclosure,
    is_synapse_function = is_synapse_function,
    clonefunction = clonefunction,
    cloneref = cloneref,
    compareinstances = compareinstances,
    newcclosure = newcclosure,
    hookfunction = hookfunction,
    replaceclosure = replaceclosure,
    hookmetamethod = hookmetamethod,
    getrawmetatable = getrawmetatable,
    setrawmetatable = setrawmetatable,
    setreadonly = setreadonly,
    isreadonly = isreadonly,
    make_writeable = make_writeable,
    make_readonly = make_readonly,
    identifyexecutor = identifyexecutor,
    getexecutorname = getexecutorname,
    setclipboard = setclipboard,
    toclipboard = toclipboard,
    setfpscap = setfpscap,
    firetouchinterest = firetouchinterest,
    fireclickdetector = fireclickdetector,
    fireproximityprompt = fireproximityprompt,
    keypress = keypress,
    keyrelease = keyrelease,
    mouse1click = mouse1click,
    mouse1press = mouse1press,
    mouse1release = mouse1release,
    mousemoverel = mousemoverel,
    queue_on_teleport = queue_on_teleport,
    saveinstance = saveinstance,
    decompile = decompile,
    getscriptclosure = getscriptclosure,
    getfunctionhash = getfunctionhash,
    getcustomasset = getcustomasset,
    rconsoleprint = rconsoleprint,
    rconsolename = rconsolename,
    rconsoleclear = rconsoleclear,
    setfflag = setfflag,
    protectgui = protectgui,
    unprotectgui = unprotectgui,
    sethiddenproperty = sethiddenproperty,
    gethiddenproperty = gethiddenproperty,
    isnetworkowner = isnetworkowner,
    isfile = isfile,
    isfolder = isfolder,
    makefolder = makefolder,
    delfile = delfile,
    delfolder = delfolder,
    listfiles = listfiles,
    readfile = readfile,
    writefile = writefile,
    appendfile = appendfile,
    loadfile = loadfile,
    dofile = dofile,
    request = request,
    http_request = request,
    crypt = crypt,
    base64_encode = base64_encode,
    base64_decode = base64_decode,
    base64encode = base64_encode,
    base64decode = base64_decode,
    syn = syn,
    WebSocket = WebSocket,
    Drawing = Drawing,
    DrawingImmediate = Drawing,
}
v27._G = v27
v18 = v27
v1 = v27.ArsenalAimbotLoaded
if v1 then
    v1 = pcall
    v27 = {
        print = print,
        type = type,
        tostring = tostring,
        tonumber = tonumber,
        next = next,
        pairs = pairs,
        ipairs = ipairs,
        select = select,
        rawget = rawget,
        rawset = rawset,
        rawequal = rawequal,
        rawlen = rawlen,
        setmetatable = setmetatable,
        getmetatable = getmetatable,
        assert = assert,
        error = error,
        pcall = pcall,
        xpcall = xpcall,
        unpack = unpack,
        getfenv = getfenv,
        setfenv = setfenv,
        collectgarbage = collectgarbage,
        gcinfo = gcinfo,
        newproxy = newproxy,
        require = require,
        load = load,
        loadstring = load,
        _VERSION = "Lua 5.1",
        string = string,
        table = table,
        math = math,
        bit32 = bit32,
        bit = bit32,
        os = os,
        io = io,
        utf8 = utf8,
        debug = debug,
        coroutine = coroutine,
        game = game,
        Game = game,
        workspace = workspace,
        Workspace = workspace,
        script = script,
        shared = shared,
        plugin = plugin,
        Instance = Instance,
        Vector2 = Vector2,
        Vector3 = Vector3,
        Vector2int16 = Vector2int16,
        Vector3int16 = Vector3int16,
        CFrame = CFrame,
        Color3 = Color3,
        UDim = UDim,
        UDim2 = UDim2,
        Rect = Rect,
        Region3 = Region3,
        Ray = Ray,
        NumberRange = NumberRange,
        NumberSequence = NumberSequence,
        NumberSequenceKeypoint = NumberSequenceKeypoint,
        ColorSequence = ColorSequence,
        ColorSequenceKeypoint = ColorSequenceKeypoint,
        BrickColor = BrickColor,
        TweenInfo = TweenInfo,
        PhysicalProperties = PhysicalProperties,
        Faces = Faces,
        Axes = Axes,
        Random = Random,
        DateTime = DateTime,
        Font = Font,
        OverlapParams = OverlapParams,
        RaycastParams = RaycastParams,
        Enum = Enum,
        wait = wait,
        tick = tick,
        time = time,
        elapsedTime = elapsedTime,
        typeof = typeof,
        warn = warn,
        spawn = spawn,
        delay = delay,
        task = task,
        getgenv = getgenv,
        getrenv = getrenv,
        getsenv = getsenv,
        getreg = getreg,
        getgc = getgc,
        getloadedmodules = getloadedmodules,
        getinstances = getinstances,
        getnilinstances = getnilinstances,
        getscripts = getscripts,
        getconnections = getconnections,
        getrunningscripts = getrunningscripts,
        getcallingscript = getcallingscript,
        gethui = gethui,
        getthreadidentity = getthreadidentity,
        setthreadidentity = setthreadidentity,
        checkcaller = checkcaller,
        islclosure = islclosure,
        iscclosure = iscclosure,
        isourclosure = isourclosure,
        is_synapse_function = is_synapse_function,
        clonefunction = clonefunction,
        cloneref = cloneref,
        compareinstances = compareinstances,
        newcclosure = newcclosure,
        hookfunction = hookfunction,
        replaceclosure = replaceclosure,
        hookmetamethod = hookmetamethod,
        getrawmetatable = getrawmetatable,
        setrawmetatable = setrawmetatable,
        setreadonly = setreadonly,
        isreadonly = isreadonly,
        make_writeable = make_writeable,
        make_readonly = make_readonly,
        identifyexecutor = identifyexecutor,
        getexecutorname = getexecutorname,
        setclipboard = setclipboard,
        toclipboard = toclipboard,
        setfpscap = setfpscap,
        firetouchinterest = firetouchinterest,
        fireclickdetector = fireclickdetector,
        fireproximityprompt = fireproximityprompt,
        keypress = keypress,
        keyrelease = keyrelease,
        mouse1click = mouse1click,
        mouse1press = mouse1press,
        mouse1release = mouse1release,
        mousemoverel = mousemoverel,
        queue_on_teleport = queue_on_teleport,
        saveinstance = saveinstance,
        decompile = decompile,
        getscriptclosure = getscriptclosure,
        getfunctionhash = getfunctionhash,
        getcustomasset = getcustomasset,
        rconsoleprint = rconsoleprint,
        rconsolename = rconsolename,
        rconsoleclear = rconsoleclear,
        setfflag = setfflag,
        protectgui = protectgui,
        unprotectgui = unprotectgui,
        sethiddenproperty = sethiddenproperty,
        gethiddenproperty = gethiddenproperty,
        isnetworkowner = isnetworkowner,
        isfile = isfile,
        isfolder = isfolder,
        makefolder = makefolder,
        delfile = delfile,
        delfolder = delfolder,
        listfiles = listfiles,
        readfile = readfile,
        writefile = writefile,
        appendfile = appendfile,
        loadfile = loadfile,
        dofile = dofile,
        request = request,
        http_request = request,
        crypt = crypt,
        base64_encode = base64_encode,
        base64_decode = base64_decode,
        base64encode = base64_encode,
        base64decode = base64_decode,
        syn = syn,
        WebSocket = WebSocket,
        Drawing = Drawing,
        DrawingImmediate = Drawing,
    }
    v27._G = v27
    v18 = v27.ArsenalAimbotUnload
    pcall(v18)
end
v18 = game
v1 = game:GetService("HttpService")
v18 = backgroundTask2
v3 = backgroundTask2
task.spawn(backgroundTask2)
v3 = 286090429
local players, v28, uIStroke, uICorner, frame, uICorner2, frame2, textLabel, v29, v30, v31, v32
if game.PlaceId ~= 286090429 then
    v3 = v18
    task.spawn(v18)
    v3 = 0.6
    task.wait(0.6)
    v4 = "Players"
    v3 = game
    players = game:GetService("Players")
    v3 = players.LocalPlayer
    if not v3 then
        v7 = "LocalPlayer"
        v4 = players
        v3 = players:GetPropertyChangedSignal("LocalPlayer")
        v4 = v3
        v3 = v3.Wait(v4)
    end
    if v3 then
        v7 = v3
        v4 = v3.Kick
        v4(v3, "Incorrect Game Detected! Join the Discord to report or check for updates.")
    else
        v7 = game
        v4 = game.Shutdown
        v4(game)
    end
else
    v3 = true
    getgenv(select(2, ...)).ArsenalAimbotLoaded = true
    v3 = game
    v3 = not game:IsLoaded()
    if v3 then
        v3 = game.Loaded
        v4 = v3
        v3 = v3.Wait
        v3(v4)
        local k0_1 = {}
        v4 = k0_1
        k0_1.AimbotEnabled = false
        k0_1.AutoFireEnabled = false
        k0_1.TeamCheck = true
        k0_1.WallCheck = true
        k0_1.TargetPart = "Head"
        k0_1.FOVRadius = 130
        k0_1.FOVVisible = true
        k0_1.ESPEnabled = false
        k0_1.BoxESP = true
        k0_1.NameESP = true
        k0_1.HealthESP = true
        k0_1.TracerESP = true
        k0_1.FlightEnabled = false
        k0_1.FlightSpeed = 50
        v4.WalkSpeedEnabled = false
        v4.CustomWalkSpeed = 24
        v4.JumpPowerEnabled = false
        v4.CustomJumpPower = 50
        v7 = false
        v4.FullBrightEnabled = false
        v4.NoRecoilEnabled = false
        v3 = v4
        getgenv(select(3, ...)).ArsenalSettings = v3
        v4 = workspace.CurrentCamera
        v8 = "Players"
        v7 = game:GetService("Players")
        v14 = "RunService"
        v8 = game
        v28 = game:GetService("RunService")
        v19 = "UserInputService"
        v14 = game
        v8 = game:GetService("UserInputService")
        v5 = "TweenService"
        v19 = game
        v14 = game:GetService("TweenService")
        v9 = "Lighting"
        v5 = game
        v19 = game:GetService("Lighting")
        v5 = v7.LocalPlayer
        v9 = v4.WorldToScreenPoint
        v6 = v4.GetPartsObscuringTarget
        v2 = "Circle"
        v16 = Drawing.new("Circle")
        v16.Thickness = 1
        v16.NumSides = 100
        v16.Radius = v3.FOVRadius
        v16.Filled = false
        v16.Visible = v3.FOVVisible
        v16.ZIndex = 999
        v16.Transparency = 1
        v17 = 0
        v20 = 255
        v16.Color = Color3.fromRGB(0, 220, 255)
        local k0_3 = {}
        v2 = k0_3
    else
        v4 = {}
        x3.AimbotEnabled = false
        x3.AutoFireEnabled = false
        x3.TeamCheck = true
        x3.WallCheck = true
        x3.TargetPart = "Head"
        x3.FOVRadius = 130
        x3.FOVVisible = true
        x3.ESPEnabled = false
        x3.BoxESP = true
        x3.NameESP = true
        x3.HealthESP = true
        x3.TracerESP = true
        x3.FlightEnabled = false
        x3.FlightSpeed = 50
        v4.WalkSpeedEnabled = false
        v4.CustomWalkSpeed = 24
        v4.JumpPowerEnabled = false
        v4.CustomJumpPower = 50
        v7 = false
        v4.FullBrightEnabled = false
        v4.NoRecoilEnabled = false
        v3 = v4
        getgenv(select(4, ...)).ArsenalSettings = v3
        v4 = workspace.CurrentCamera
        v8 = "Players"
        v7 = game:GetService("Players")
        v14 = "RunService"
        v8 = game
        v28 = game:GetService("RunService")
        v19 = "UserInputService"
        v14 = game
        v8 = game:GetService("UserInputService")
        v5 = "TweenService"
        v19 = game
        v14 = game:GetService("TweenService")
        v9 = "Lighting"
        v5 = game
        v19 = game:GetService("Lighting")
        v5 = v7.LocalPlayer
        v9 = v4.WorldToScreenPoint
        v6 = v4.GetPartsObscuringTarget
        v2 = "Circle"
        v16 = Drawing.new("Circle")
        v16.Thickness = 1
        v16.NumSides = 100
        v16.Radius = v3.FOVRadius
        v16.Filled = false
        v16.Visible = v3.FOVVisible
        v16.ZIndex = 999
        v16.Transparency = 1
        v17 = 0
        v20 = 255
        v16.Color = Color3.fromRGB(0, 220, 255)
        v2 = {}
    end
    v17 = transformValue
    v20 = processItems
    v10 = "ScreenGui"
    arsenalHubGUI = Instance.new("ScreenGui")
    arsenalHubGUI.Name = "ArsenalHubGUI"
    arsenalHubGUI.ResetOnSpawn = false
    v10 = syn and syn.protect_gui
    if v10 then
        v10 = syn.protect_gui
        v10(arsenalHubGUI)
        arsenalHubGUI.Parent = gethui(game, "CoreGui")
    else
        arsenalHubGUI.Parent = game:GetService("CoreGui")
    end
    v10 = Instance.new("Frame")
    v10.Name = "MainFrame"
    v10.Size = UDim2.new(0, 320, 0, 560)
    v10.Position = UDim2.new(0.5, -160, 0.5, -280)
    v10.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    v10.BorderSizePixel = 0
    v10.Parent = arsenalHubGUI
    uIStroke = Instance.new("UIStroke")
    uIStroke.Color = Color3.fromRGB(45, 45, 55)
    uIStroke.Thickness = 1
    uIStroke.Parent = v10
    uICorner = Instance.new("UICorner")
    uICorner.CornerRadius = UDim.new(0, 10)
    uICorner.Parent = v10
    frame = Instance.new("Frame")
    v11 = 0
    v12 = 40
    frame.Size = UDim2.new(1, 0, 0, 40)
    v11 = 26
    frame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    frame.BorderSizePixel = 0
    frame.Parent = v10
    uICorner2 = Instance.new("UICorner")
    v11 = 10
    uICorner2.CornerRadius = UDim.new(0, 10)
    uICorner2.Parent = frame
    frame2 = Instance.new("Frame")
    v11 = 1
    v12 = 0
    v13 = 0
    v15 = 10
    frame2.Size = UDim2.new(1, 0, 0, 10)
    v11 = 0
    v12 = 0
    v13 = 1
    v15 = -10
    frame2.Position = UDim2.new(0, 0, 1, -10)
    v11 = 22
    v12 = 22
    v13 = 26
    frame2.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    frame2.BorderSizePixel = 0
    frame2.Parent = frame
    v11 = "TextLabel"
    textLabel = Instance.new("TextLabel")
    v12 = 1
    v13 = -20
    v15 = 1
    textLabel.Size = UDim2.new(1, -20, 1, 0)
    v12 = 0
    v13 = 14
    v15 = 0
    textLabel.Position = UDim2.new(0, 14, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "Arsenal <font color='#00dfff'>Premium Hub</font>"
    textLabel.RichText = true
    v12 = 240
    v13 = 240
    v15 = 240
    textLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
    textLabel.TextSize = 14
    v12 = Enum.Font
    v11 = v12.GothamBold
    textLabel.Font = v11
    v12 = Enum.TextXAlignment
    v11 = v12.Left
    textLabel.TextXAlignment = v11
    textLabel.Parent = frame
    v11 = nil
    v12 = nil
    v13 = nil
    v15 = frame.InputBegan
    v29 = v15
    v15 = v15.Connect
    v15(v29, connectEvents)
    v15 = v8.InputChanged
    v29 = v15
    v15 = v15.Connect
    v15(v29, updateState)
    v15 = Instance.new("ScrollingFrame")
    v22 = -54
    v15.Size = UDim2.new(1, -20, 1, -54)
    v22 = 46
    v15.Position = UDim2.new(0, 10, 0, 46)
    v15.BackgroundTransparency = 1
    v15.BorderSizePixel = 0
    v22 = 820
    v15.CanvasSize = UDim2.new(0, 0, 0, 820)
    v15.ScrollBarThickness = 3
    v15.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 75)
    v15.Parent = v10
    v29 = Instance.new("UIListLayout")
    v29.SortOrder = Enum.SortOrder.LayoutOrder
    v29.Padding = UDim.new(0, 8)
    v29.Parent = v15
    v30 = connectEvents2
    v31 = connectEvents3
    v32 = connectEvents4
    v22 = connectEvents2
    v21 = "Aimbot Enabled"
    v24 = v3.AimbotEnabled
    v25 = setAimbotEnabled
    connectEvents2("Aimbot Enabled", v24, setAimbotEnabled)
    v22 = v30
    v21 = "Auto-Fire"
    v24 = v3.AutoFireEnabled
    v25 = setAutoFireEnabled
    v30("Auto-Fire", v24, setAutoFireEnabled)
    v22 = v30
    v21 = "Team Check"
    v24 = v3.TeamCheck
    v25 = setTeamCheck
    v30("Team Check", v24, setTeamCheck)
    v22 = v30
    v21 = "Wall Check"
    v24 = v3.WallCheck
    v25 = setWallCheck
    v30("Wall Check", v24, setWallCheck)
    v22 = v30
    v21 = "FOV Circle"
    v24 = v3.FOVVisible
    v25 = updateState2
    v30("FOV Circle", v24, updateState2)
    v22 = v31
    v21 = "FOV Radius"
    v24 = v3.FOVRadius
    v25 = updateState3
    v31("FOV Radius", v24, updateState3)
    v22 = v30
    v21 = "ESP Enabled"
    v24 = v3.ESPEnabled
    v25 = getPlayers3
    v30("ESP Enabled", v24, getPlayers3)
    v22 = v30
    v21 = "Box ESP"
    v24 = v3.BoxESP
    v25 = setBoxESP
    v30("Box ESP", v24, setBoxESP)
    v22 = v30
    v21 = "Name ESP"
    v24 = v3.NameESP
    v25 = setNameESP
    v30("Name ESP", v24, setNameESP)
    v22 = v30
    v21 = "Health ESP"
    v24 = v3.HealthESP
    v25 = setHealthESP
    v30("Health ESP", v24, setHealthESP)
    v22 = v30
    v21 = "Tracer ESP"
    v24 = v3.TracerESP
    v25 = setTracerESP
    v30("Tracer ESP", v24, setTracerESP)
    v22 = v30
    v21 = "FullBright"
    v24 = v3.FullBrightEnabled
    v25 = setFullBrightEnabled
    v30("FullBright", v24, setFullBrightEnabled)
    v22 = v30
    v21 = "No Recoil / Spread"
    v24 = v3.NoRecoilEnabled
    v25 = setNoRecoilEnabled
    v30("No Recoil / Spread", v24, setNoRecoilEnabled)
    v22 = v30
    v21 = "Flight Enabled"
    v24 = v3.FlightEnabled
    v25 = setFlightEnabled
    v30("Flight Enabled", v24, setFlightEnabled)
    v22 = v31
    v21 = "Flight Speed"
    v24 = v3.FlightSpeed
    v25 = setFlightSpeed
    v31("Flight Speed", v24, setFlightSpeed)
    v22 = v30
    v21 = "WalkSpeed Mod"
    v24 = v3.WalkSpeedEnabled
    v25 = setWalkSpeedEnabled
    v30("WalkSpeed Mod", v24, setWalkSpeedEnabled)
    v22 = v31
    v21 = "WalkSpeed Value"
    v24 = v3.CustomWalkSpeed
    v25 = setCustomWalkSpeed
    v31("WalkSpeed Value", v24, setCustomWalkSpeed)
    v22 = nil
    v21 = v32
    v24 = "JOIN DISCORD"
    v26 = 88
    v23 = 101
    v25 = Color3.fromRGB(88, 101, 242)
    v26 = runProtected
    v21("JOIN DISCORD", v25, runProtected)
    v21 = v32
    v24 = "Unload Hub"
    v26 = 180
    v23 = 45
    v25 = Color3.fromRGB(180, 45, 45)
    v26 = runProtected2
    v21("Unload Hub", v25, runProtected2)
    v21 = false
    v24 = nil
    v25 = v28.RenderStepped
    v23 = runProtected3
    v26 = v25
    v24 = v25.Connect(v26, runProtected3)
    v25 = nil
    v26 = v28.Heartbeat
    v23 = v26
    v25 = v26.Connect(v23, updateState4)
    v26 = nil
    v23 = v8.InputBegan
    v26 = v23:Connect(updateState5)
    v23 = computeValue
    v22 = connectEvents5
    task.spawn(backgroundTask3)
    getgenv(select(2, ...)).ArsenalAimbotUnload = ArsenalAimbotUnloadHandler
end
