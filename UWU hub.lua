-- this is for Anomaly Watch

local v1 = game:GetService("RunService")
local v2 = game:GetService("UserInputService")
local v3 = game:GetService("TweenService")
local v4 = game:GetService("StarterGui")
local v5 = game:GetService("Lighting")
local v6 = Instance.new("ScreenGui")
Instance.new("ScreenGui").Name = "KeySystem"
v6.ResetOnSpawn = false
v6.IgnoreGuiInset = true
v6.Parent = (game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
local v7 = Instance.new("Frame")
Instance.new("Frame").Size = UDim2.fromOffset(350, 300)
v7.Position = UDim2.fromScale(0.5, 0.5)
v7.AnchorPoint = Vector2.new(0.5, 0.5)
v7.BackgroundColor3 = Color3.fromRGB(14, 15, 20)
v7.BorderSizePixel = 0
v7.Parent = v6
Instance.new("UICorner", v7).CornerRadius = UDim.new(0, 16)
local v8 = Instance.new("UIStroke")
Instance.new("UIStroke").Color = Color3.fromRGB(255, 150, 190)
local A = Instance.new("TextLabel")
Instance.new("TextLabel").Size = UDim2.new(1, 0, 0, 40)
A.Position = UDim2.fromOffset(0, 20)
A.TextColor3 = Color3.fromRGB(245, 245, 250)
local B = Instance.new("TextButton")
Instance.new("TextButton").Size = UDim2.new(1, -40, 0, 35)
B.Position = UDim2.fromOffset(20, 70)
B.Text = "🔑 GET KEY"
B.Font = Enum.Font.GothamBold
B.TextSize = 13
B.TextColor3 = Color3.fromRGB(255, 255, 255)
B.BackgroundColor3 = Color3.fromRGB(255, 150, 190)
B.BorderSizePixel = 0
B.Parent = v7
Instance.new("UICorner", B).CornerRadius = UDim.new(0, 8)
B.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://guns.lol/sqworexo")
        v4:SetCore("SendNotification", {Title = "UWU HUB", Text = "Get Key link copied!", Duration = 2})
    end
end)
local C = Instance.new("TextButton")
Instance.new("TextButton").Size = UDim2.new(1, -40, 0, 35)
C.Position = UDim2.fromOffset(20, 112)
C.Text = "📱 TELEGRAM"
C.Font = Enum.Font.GothamBold
C.TextSize = 13
C.TextColor3 = Color3.fromRGB(255, 255, 255)
C.BackgroundColor3 = Color3.fromRGB(0, 136, 204)
C.BorderSizePixel = 0
C.Parent = v7
Instance.new("UICorner", C).CornerRadius = UDim.new(0, 8)
C.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://t.me/dd_left_dd")
        v4:SetCore("SendNotification", {Title = "UWU HUB", Text = "Telegram link copied!", Duration = 2})
    end
end)
local D = Instance.new("TextBox")
Instance.new("TextBox").Size = UDim2.new(1, -40, 0, 40)
D.Position = UDim2.fromOffset(20, 162)
D.PlaceholderText = "Enter key..."
D.Text = ""
D.Font = Enum.Font.Gotham
D.TextSize = 16
D.TextColor3 = Color3.fromRGB(245, 245, 250)
D.BackgroundColor3 = Color3.fromRGB(30, 33, 40)
D.BorderSizePixel = 0
D.Parent = v7
Instance.new("UICorner", D).CornerRadius = UDim.new(0, 10)
local E = Instance.new("TextButton")
Instance.new("TextButton").Size = UDim2.new(1, -40, 0, 40)
E.Position = UDim2.fromOffset(20, 215)
E.Text = "ACTIVATE"
E.Font = Enum.Font.GothamBold
E.TextSize = 14
E.TextColor3 = Color3.fromRGB(245, 245, 250)
E.BackgroundColor3 = Color3.fromRGB(255, 150, 190)
E.BorderSizePixel = 0
E.Parent = v7
Instance.new("UICorner", E).CornerRadius = UDim.new(0, 10)
local F = Instance.new("TextLabel")
Instance.new("TextLabel").Size = UDim2.new(1, 0, 0, 20)
F.Position = UDim2.fromOffset(0, 265)
F.TextColor3 = Color3.fromRGB(255, 80, 80)
local function G()
    if D.Text == v56 then
        v6:Destroy()
        v4:SetCore("SendNotification", {Title = "UWU HUB", Text = "Key activated! Access granted.", Duration = 3})
        InitHub()
    else
        task.wait(1)
    end
end
E.MouseButton1Click:Connect(G)
D.FocusLost:Connect(function(H)
    if H then
        G()
    end
end)
function InitHub()
    local I = {BG = Color3.fromRGB(14, 15, 20), PANEL = Color3.fromRGB(22, 24, 30), CARD = Color3.fromRGB(30, 33, 40), ACCENT = Color3.fromRGB(255, 150, 190), TEXT = Color3.fromRGB(245, 245, 250), MUTED = Color3.fromRGB(150, 150, 165), RED = Color3.fromRGB(255, 80, 80), GREEN = Color3.fromRGB(100, 255, 100), YELLOW = Color3.fromRGB(255, 200, 100), CYAN = Color3.fromRGB(80, 200, 255), ORANGE = Color3.fromRGB(255, 150, 50), PURPLE = Color3.fromRGB(200, 100, 255)}
    local J = v2.TouchEnabled and not v2.KeyboardEnabled
    local K = {ESP_Monsters = false, ESP_Items = false, ESP_Tracers = false, ESP_Anomaly = false, ESP_AllObjects = false, AutoWin = false, Speed = false, Fly = false, Noclip = false, Fullbright = false, FOV = false, Hat = false, Trail = false}
    local L = v5.Brightness
    local M = v5.Ambient
    local N = v5.OutdoorAmbient
    local O = v5.ClockTime
    local P = v5.FogEnd
    local function Q(R)
        if R then
            v5.Brightness = 2
            v5.Ambient = Color3.fromRGB(60, 60, 60)
            v5.OutdoorAmbient = Color3.fromRGB(40, 40, 40)
            v5.ClockTime = 14
            v5.FogEnd = 99999
            v5.GlobalShadows = false
        else
            v5.Brightness = L
            v5.Ambient = M
            v5.OutdoorAmbient = N
            v5.ClockTime = O
            v5.FogEnd = P
            v5.GlobalShadows = true
        end
    end
    local function S(T)
        local U = v57.Character
        if U then
            local V = U:FindFirstChildOfClass("Humanoid")
            if V then
                V.WalkSpeed = T and 25 or 16
            end
        end
    end
    local W, X, Y
    local function _(v19)
        local v20 = v57.Character
        local v21 = v20:FindFirstChild("HumanoidRootPart")
        local v22 = v20:FindFirstChildOfClass("Humanoid")
        if v19 then
            if v22 then
                v22.PlatformStand = true
                v22.AutoRotate = false
            end
            W = Instance.new("BodyVelocity")
            W.Velocity = Vector3.zero
            W.MaxForce = Vector3.new(400000, 400000, 400000)
            W.P = 5000
            W.Parent = v21
            X = Instance.new("BodyGyro")
            X.MaxTorque = Vector3.new(400000, 400000, 400000)
            X.P = 3000
            X.D = 100
            X.Parent = v21
            Y = v1.RenderStepped:Connect(function()
                if not K.Fly then
                end
                if v2:IsKeyDown(Enum.KeyCode.W) then
                    v58 = Vector3.zero + v59.CFrame.LookVector
                end
                if v2:IsKeyDown(Enum.KeyCode.S) then
                    v58 = v58 - v59.CFrame.LookVector
                end
                if v2:IsKeyDown(Enum.KeyCode.A) then
                    v58 = v58 - v59.CFrame.RightVector
                end
                if v2:IsKeyDown(Enum.KeyCode.D) then
                    v58 = v58 + v59.CFrame.RightVector
                end
                if v2:IsKeyDown(Enum.KeyCode.Space) then
                    v58 = v58 + Vector3.new(0, 1, 0)
                end
                if v2:IsKeyDown(Enum.KeyCode.LeftShift) then
                    v58 = v58 - Vector3.new(0, 1, 0)
                end
                if J and v22 and v22.MoveDirection.Magnitude > 0 then
                    v58 = v22.MoveDirection
                end
                if v58.Magnitude > 0 then
                    v58 = v58.Unit
                end
                if v2:IsKeyDown(Enum.KeyCode.LeftControl) then
                end
                if W then
                    W.Velocity = v58 * v60
                end
                if X then
                    X.CFrame = v59.CFrame
                end
            end)
        else
            if W then
                W:Destroy()
                W = nil
            end
            if X then
                X:Destroy()
                X = nil
            end
            if Y then
                Y:Disconnect()
                Y = nil
            end
            if v22 then
                v22.PlatformStand = false
                v22.AutoRotate = true
            end
        end
    end
    local v9
    local function v10(v23)
        if v23 then
            v9 = v1.Stepped:Connect(function()
                if v57.Character then
                    for v24, aa in ipairs(v57.Character:GetDescendants()) do
                        if aa:IsA("BasePart") then
                            aa.CanCollide = false
                        end
                    end
                end
            end)
        else
            if v9 then
                v9:Disconnect()
                v9 = nil
            end
            if v57.Character then
                for ab, ac in ipairs(v57.Character:GetDescendants()) do
                    if ac:IsA("BasePart") then
                        ac.CanCollide = true
                    end
                end
            end
        end
    end
    local function ad(ae)
        v59.FieldOfView = ae and 100 or 70
    end
    local af = nil
    local function ag(ah)
        local ai = v57.Character
        local aj = ai:FindFirstChild("HumanoidRootPart")
        if ah then
            af = aj.CFrame
            aj.CFrame = CFrame.new(aj.Position.X, 250, aj.Position.Z)
        elseif af then
            aj.CFrame = af
            af = nil
        end
    end
    local ak = {Hat = false, Trail = false}
    local al
    local function am()
        if al then
            al:Destroy()
        end
        local an = v57.Character
        local ao = an:FindFirstChild("Head")
        al = Instance.new("Model")
        al.Name = "Hat"
        al.Parent = an
        local ap = Instance.new("Part")
        ap.Shape = Enum.PartType.Cone
        ap.Size = Vector3.new(3, 2.2, 3)
        ap.Color = Color3.fromRGB(255, 150, 200)
        ap.Transparency = 0.1
        ap.Material = Enum.Material.Neon
        ap.Anchored = false
        ap.CanCollide = false
        ap.Parent = al
        local aq = Instance.new("Part")
        aq.Shape = Enum.PartType.Ball
        aq.Size = Vector3.new(0.7, 0.7, 0.7)
        aq.Color = Color3.fromRGB(255, 100, 150)
        aq.Transparency = 0
        aq.Material = Enum.Material.Neon
        aq.Anchored = false
        aq.CanCollide = false
        aq.Parent = al
        local ar = Instance.new("Part")
        ar.Shape = Enum.PartType.Cylinder
        ar.Size = Vector3.new(4, 0.2, 4)
        ar.Color = Color3.fromRGB(255, 180, 220)
        ar.Transparency = 0.1
        ar.Material = Enum.Material.Neon
        ar.Anchored = false
        ar.CanCollide = false
        ar.Parent = al
        Instance.new("Weld")({Part0 = ao, Part1 = ap, C0 = CFrame.new(0, 2.5, 0), Parent = ap})
        Instance.new("Weld")({Part0 = ap, Part1 = aq, C0 = CFrame.new(0, 1.3, 0), Parent = aq})
        Instance.new("Weld")({Part0 = ap, Part1 = ar, C0 = CFrame.new(0, -1.1, 0), Parent = ar})
    end
    local function as()
        if al then
            al:Destroy()
            al = nil
        end
    end
    local at = {}
    local au = 15
    local function av()
        local aw = v57.Character
        local ax = aw:FindFirstChild("HumanoidRootPart")
        local ay = Instance.new("Part")
        ay.Size = Vector3.new(0.25, 0.25, 0.25)
        ay.Shape = Enum.PartType.Ball
        ay.Position = ax.Position - Vector3.new(0, 2.5, 0)
        ay.Color = Color3.fromRGB(255, 150, 200)
        ay.Transparency = 0.5
        ay.Material = Enum.Material.Neon
        ay.Anchored = true
        ay.CanCollide = false
        ay.Parent = workspace
        table.insert(at, ay)
        if #at > au then
            local az = table.remove(at, 1)
            if az then
                az:Destroy()
            end
        end
        task.delay(1.5, function()
            for v25 = 1, 8 do
                if not ay.Parent then
                    break
                end
                ay.Transparency = ay.Transparency + 0.06
                task.wait(0.04)
            end
            if ay then
                ay:Destroy()
            end
        end)
    end
    local function aA(aB)
        ak.Hat = aB
        if aB then
            am()
        else
            as()
        end
    end
    local function aC(aD)
        ak.Trail = aD
    end
    task.spawn(function()
        while true do
            task.wait(0.15)
            if ak.Trail then
                local aE = v57.Character
                if aE then
                    local aF = aE:FindFirstChildOfClass("Humanoid")
                    if (aE:FindFirstChildOfClass("Humanoid")) and aF.MoveDirection.Magnitude > 0 then
                        av()
                    end
                end
            end
        end
    end)
    v57.CharacterAdded:Connect(function()
        if ak.Hat then
            task.wait(0.5)
            am()
        end
    end)
    local function aG(aH)
        if aH:IsA("BasePart") then
            return aH
        end
        if aH:IsA("Model") then
            return aH.PrimaryPart or aH:FindFirstChildWhichIsA("BasePart")
        end
        return nil
    end
    local function aI(aJ)
        if aJ:IsA("BasePart") and aJ.Name == "TrailPart" then
            return true
        end
        if aJ:IsA("BasePart") and aJ.Color == Color3.fromRGB(255, 150, 200) and aJ.Material == Enum.Material.Neon and aJ.Size == Vector3.new(0.25, 0.25, 0.25) then
            return true
        end
        return false
    end
    local aK = {Case = true, Screen = true, Tablet = true}
    local function aL(aM)
        local aN = aM.Name
        local aO = aM.Parent
        while aO and aO ~= workspace do
            aN = aO.Name .. "." .. aN
            aO = aO.Parent
        end
        return aN
    end
    local aP = {}
    local aQ = {}
    local aR = {}
    local function aS(aT)
        if not aT:IsA("Model") then
            return false
        end
        if aT == v57.Character then
            return false
        end
        local aU = aT:FindFirstChildOfClass("Humanoid")
        if not aU then
            return false
        end
        if aU.Health <= 0 then
            return false
        end
        local aV = {Rig = true, Rig2 = true, Dummy = true}
        if aV[aT.Name] then
            return false
        end
        if aU.WalkSpeed <= 0 then
            return false
        end
        local aW = false
        for aX, aY in ipairs(aT:GetDescendants()) do
            if aY:IsA("Script") or aY:IsA("LocalScript") then
                local aZ = aY.Name:lower()
                if aZ:find("ai") or aZ:find("attack") or aZ:find("hunt") or aZ:find("chase") or aZ:find("kill") or aZ:find("monster") or aZ:find("enemy") then
                    aW = true
                    break
                end
            end
        end
        return aW or aU.WalkSpeed > 16
    end
    local function a_(v26)
        if aQ[v26] then
        end
        local v27 = v26:FindFirstChild("HumanoidRootPart") or v26:FindFirstChild("Torso") or v26.PrimaryPart
        local v28 = Instance.new("Highlight")
        v28.Name = "MonsterESP_Highlight"
        v28.FillColor = Color3.fromRGB(255, 0, 0)
        v28.FillTransparency = 0.6
        v28.OutlineColor = Color3.fromRGB(255, 0, 0)
        v28.OutlineTransparency = 0
        v28.Adornee = v26
        v28.Parent = v26
        aQ[v26] = v28
        local v29 = Instance.new("BillboardGui")
        v29.Name = "MonsterESP_Label"
        v29.Size = UDim2.new(0, 200, 0, 30)
        v29.StudsOffset = Vector3.new(0, 3, 0)
        v29.AlwaysOnTop = true
        v29.Parent = v26
        local v30 = Instance.new("TextLabel")
        v30.Size = UDim2.new(1, 0, 1, 0)
        v30.TextColor3 = Color3.fromRGB(255, 0, 0)
        aR[v26] = v29
        aP[v26] = {addedAt = tick()}
    end
    local function v11(v31)
        if aQ[v31] then
            aQ[v31]:Destroy()
            aQ[v31] = nil
        end
        if aR[v31] then
            aR[v31]:Destroy()
            aR[v31] = nil
        end
        aP[v31] = nil
    end
    local function v12()
        for v32, v33 in pairs(aP) do
            v11(v32)
        end
        aP = {}
    end
    local function v13()
        for ba, bb in ipairs(workspace:GetDescendants()) do
            if aS(bb) then
                if not aP[bb] then
                    a_(bb)
                end
            end
        end
    end
    local function bc(bd)
        if bd then
            v13()
        else
            v12()
        end
    end
    workspace.DescendantAdded:Connect(function(be)
        if not K.ESP_Monsters then
        end
        if be:IsA("Model") then
            task.wait(0.5)
            if aS(be) and not aP[be] then
                a_(be)
            end
        end
        if be:IsA("Humanoid") and be.Parent and be.Parent:IsA("Model") then
            task.wait(0.5)
            local bf = be.Parent
            if aS(bf) and not aP[bf] then
                a_(bf)
            end
        end
    end)
    workspace.DescendantRemoving:Connect(function(bg)
        if aP[bg] then
            v11(bg)
        end
    end)
    task.spawn(function()
        while true do
            task.wait(2)
            if K.ESP_Monsters then
                for bh, bi in pairs(aP) do
                    if not bh.Parent then
                        v11(bh)
                    else
                        local bj = bh:FindFirstChildOfClass("Humanoid")
                        if (bh:FindFirstChildOfClass("Humanoid")) and bj.Health <= 0 then
                            v11(bh)
                        end
                    end
                end
                v13()
            end
        end
    end)
    local bk = {}
    workspace.DescendantAdded:Connect(function(bl)
        if aS(bl) then
        end
        if aI(bl) then
        end
        if aK[bl.Name] then
        end
        bk[bl] = {time = tick(), pos = aG(bl) and aG(bl).Position or Vector3.zero, name = bl.Name}
    end)
    workspace.DescendantRemoving:Connect(function(bm)
        bk[bm] = nil
    end)
    local bn = {}
    workspace.DescendantAdded:Connect(function(bo)
        if aI(bo) then
        end
        bn[bo] = {time = tick(), pos = aG(bo) and aG(bo).Position or Vector3.zero, name = aL(bo)}
    end)
    workspace.DescendantRemoving:Connect(function(bp)
        bn[bp] = nil
    end)
    local bq = 0.25
    local br = {}
    br.__index = br
    br.new = function(bs)
        return setmetatable({obj = bs, last = nil, dirty = false, lastUpdate = tick(), lastFix = 0}, br)
    end
    br.Snapshot = function(bt, bu)
        bt.lastUpdate = tick()
    end
    br.MarkDirty = function(bv)
    end
    br.Repair = function(bw)
        local bx = bw.obj:IsA("BasePart") and bw.obj or bw.obj:FindFirstChildWhichIsA("BasePart")
        if bx and bw.last then
            bw.last.pos = bx.Position
            bw.last.size = bx.Size
            bw.lastFix = tick()
        end
    end
    local by = {
        MOVED = {label = "Moved", color = Color3.fromRGB(255, 0, 0)},
        SIZE = {label = "Size", color = Color3.fromRGB(255, 100, 0)},
        COLOR = {label = "Color", color = Color3.fromRGB(255, 255, 0)},
        MATERIAL = {label = "Material", color = Color3.fromRGB(200, 200, 0)},
        LIGHT = {label = "Light", color = Color3.fromRGB(0, 255, 255)},
        IMAGE = {label = "Image", color = Color3.fromRGB(255, 0, 255)},
        TV = {label = "TV", color = Color3.fromRGB(0, 255, 0)},
        NEW = {label = "New", color = Color3.fromRGB(255, 128, 0)},
        MISSING = {label = "Missing", color = Color3.fromRGB(255, 0, 0)},
        TRANSPARENCY = {label = "Transparency", color = Color3.fromRGB(200, 200, 255)},
        ANCHORED = {label = "Physics", color = Color3.fromRGB(255, 200, 100)},
        PARENT_CHANGED = {label = "Parent", color = Color3.fromRGB(255, 150, 150)},
        CHILD_COUNT = {label = "Children", color = Color3.fromRGB(200, 255, 200)},
    }
    local bz = {CheckerboardPoster = true, Soap = true, Sink = true, Monitor = true, MeshPart = true, Machine = true, Rockingmachine = true, Board = true, Image = true, MonaLisa = true, Mold = true, Bucket = true, DoorR = true, DoorL = true, Counter = true}
    local bA = {}
    local bB = 2
    local function bC(bD, bE)
        local bF = bD
        if not bA[bF] then
            bA[bF] = {}
        end
        local bG = bA[bF][bE]
        local bH = tick()
        if bG and (bH - bG) < bB then
            return false
        end
        bA[bF][bE] = bH
        return true
    end
    local function bI(bJ)
        local bK = v57.Character
        if not bK then
            return false
        end
        local bL = bK:FindFirstChild("HumanoidRootPart")
        if not bL then
            return false
        end
        local bM = aG(bJ)
        if not bM then
            return false
        end
        local bN = (bM.Position - bL.Position).Magnitude
        return bN < 2
    end
    local function bO(bP)
        if bz[bP.Name] then
            return true
        end
        if bP.Parent and bz[bP.Parent.Name] then
            return true
        end
        return false
    end
    local function bP(bQ, bR)
        local bS = aG(bQ)
        for bT, bU in ipairs(bS:GetChildren()) do
            if bU:IsA("BoxHandleAdornment") and bU.Name == "AnomalyHL" then
                bU:Destroy()
            end
        end
        local bV = Instance.new("BoxHandleAdornment")
        bV.Name = "AnomalyHL"
        bV.Adornee = bS
        bV.Size = bS.Size + Vector3.new(0.3, 0.3, 0.3)
        bV.Color3 = bR
        bV.AlwaysOnTop = true
        bV.ZIndex = 5
        bV.Parent = bS
        task.delay(8, function()
            if bV then
                bV:Destroy()
            end
        end)
    end
    local function bQ(bW, bX, bY)
        local bZ = aG(bW)
        for b_, v36 in ipairs(bZ:GetChildren()) do
            if v36:IsA("BillboardGui") and v36.Name == "AnomalyLbl" then
                v36:Destroy()
            end
        end
        local v34 = Instance.new("BillboardGui")
        v34.Name = "AnomalyLbl"
        v34.Size = UDim2.new(0, 200, 0, 50)
        v34.StudsOffset = Vector3.new(0, 2.5, 0)
        v34.AlwaysOnTop = true
        v34.Parent = bZ
        local v35 = Instance.new("TextLabel")
        v35.Size = UDim2.new(1, 0, 1, 0)
        v35.TextColor3 = bY or Color3.fromRGB(255, 255, 0)
        task.delay(8, function()
            if v34 then
                v34:Destroy()
            end
        end)
    end
    local v14 = {}
    local function v15(v37, v38)
        if not bC(v37, v38) then
        end
        if bI(v37) then
        end
        local v39 = by[v38]
        bP(v37, v39.color)
        bQ(v37, v39.label, v39.color)
    end
    local function v16(v40)
        local ca = aG(v40)
        if not v14[v40] then
            v14[v40] = br.new(v40)
        end
        v14[v40]:Snapshot({pos = ca.Position, size = ca.Size, color = ca:IsA("BasePart") and ca.Color or nil, material = ca:IsA("BasePart") and ca.Material or nil, transparency = ca:IsA("BasePart") and ca.Transparency or nil, anchored = ca:IsA("BasePart") and ca.Anchored or nil, texture = v40:IsA("Decal") and v40.Texture or v40:IsA("Texture") and v40.Texture or nil, brightness = v40:IsA("Light") and v40.Brightness or nil, soundId = v40:IsA("Sound") and v40.SoundId or nil, childCount = v40:IsA("Model") and #v40:GetChildren() or nil, parent = v40.Parent})
    end
    local function cb(cc)
        local cd = v14[cc]
        if not cc.Parent then
            v14[cc] = nil
        end
        local ce = aG(cc)
        local cf = cd.last
        if (ce.Position - cf.pos).Magnitude > 1 then
            v15(cc, "MOVED")
            cf.pos = ce.Position
        end
        if cf.size and (ce.Size - cf.size).Magnitude > 0.3 then
            v15(cc, "SIZE")
            cf.size = ce.Size
        end
        if cf.color and ce:IsA("BasePart") and ce.Color ~= cf.color then
            v15(cc, "COLOR")
            cf.color = ce.Color
        end
        if cf.material and ce:IsA("BasePart") and ce.Material ~= cf.material then
            v15(cc, "MATERIAL")
            cf.material = ce.Material
        end
        if cf.transparency and ce:IsA("BasePart") and math.abs(ce.Transparency - cf.transparency) > 0.05 then
            v15(cc, "TRANSPARENCY")
            cf.transparency = ce.Transparency
        end
        if cf.anchored ~= nil and ce:IsA("BasePart") and ce.Anchored ~= cf.anchored then
            v15(cc, "ANCHORED")
            cf.anchored = ce.Anchored
        end
        if cf.brightness and cc:IsA("Light") and math.abs(cc.Brightness - cf.brightness) > 0.2 then
            v15(cc, "LIGHT")
            cf.brightness = cc.Brightness
        end
        local cg = nil
        if cc:IsA("Decal") then
            cg = cc.Texture
        elseif cc:IsA("Texture") then
            cg = cc.Texture
        end
        if cg and cf.texture and cg ~= cf.texture then
            v15(cc, "IMAGE")
            cf.texture = cg
        end
        if cc:IsA("BasePart") then
            local ch = cc:FindFirstChildWhichIsA("SurfaceGui")
            if ch then
                local ci = ch:FindFirstChildWhichIsA("ImageLabel")
                if ci and cf.texture and ci.Image ~= cf.texture then
                    v15(cc, "TV")
                    cf.texture = ci.Image
                end
            end
        end
        if cf.parent and cc.Parent ~= cf.parent then
            v15(cc, "PARENT_CHANGED")
            cf.parent = cc.Parent
        end
        if cf.childCount and cc:IsA("Model") then
            local cj = #cc:GetChildren()
            if cj ~= cf.childCount then
                v15(cc, "CHILD_COUNT")
                cf.childCount = cj
            end
        end
    end
    local function ck(cl)
        if cl:IsA("BasePart") then
            cl:GetPropertyChangedSignal("Position"):Connect(function()
                task.delay(bq, function()
                    if v14[cl] then
                        cb(cl)
                    end
                end)
            end)
            cl:GetPropertyChangedSignal("Color"):Connect(function()
                task.delay(bq, function()
                    if v14[cl] then
                        cb(cl)
                    end
                end)
            end)
            cl:GetPropertyChangedSignal("Material"):Connect(function()
                task.delay(bq, function()
                    if v14[cl] then
                        cb(cl)
                    end
                end)
            end)
            cl:GetPropertyChangedSignal("Transparency"):Connect(function()
                task.delay(bq, function()
                    if v14[cl] then
                        cb(cl)
                    end
                end)
            end)
            cl:GetPropertyChangedSignal("Anchored"):Connect(function()
                task.delay(bq, function()
                    if v14[cl] then
                        cb(cl)
                    end
                end)
            end)
            cl:GetPropertyChangedSignal("Size"):Connect(function()
                task.delay(bq, function()
                    if v14[cl] then
                        cb(cl)
                    end
                end)
            end)
        end
        if cl:IsA("Light") then
            cl:GetPropertyChangedSignal("Brightness"):Connect(function()
                task.delay(bq, function()
                    if v14[cl] then
                        cb(cl)
                    end
                end)
            end)
        end
        if cl:IsA("Decal") or cl:IsA("Texture") then
            cl:GetPropertyChangedSignal("Texture"):Connect(function()
                task.delay(bq, function()
                    if v14[cl] then
                        cb(cl)
                    end
                end)
            end)
        end
        if cl:IsA("Sound") then
            cl:GetPropertyChangedSignal("SoundId"):Connect(function()
                task.delay(bq, function()
                    if v14[cl] then
                        cb(cl)
                    end
                end)
            end)
        end
        cl.AncestryChanged:Connect(function()
            task.delay(bq, function()
                if v14[cl] then
                    cb(cl)
                end
            end)
        end)
        cl.Destroying:Connect(function()
            if v14[cl] then
                v15(cl, "MISSING")
                v14[cl] = nil
            end
        end)
    end
    local function cm(cn)
        if v57.Character and cn:IsDescendantOf(v57.Character) then
            return true
        end
        if cn.Name == "HatCone" or cn.Name == "HatBall" or cn.Name == "HatBrim" or cn.Name == "TrailPart" or cn.Name == "Hat" or cn.Name == "ChineseHat" then
            return true
        end
        if aI(cn) then
            return true
        end
        return false
    end
    workspace.DescendantAdded:Connect(function(co)
        if cm(co) then
        end
        if aS(co) then
        end
        if aK[co.Name] then
        end
        if not bO(co) then
        end
        if not K.ESP_Anomaly then
        end
        task.delay(0.5, function()
            if not co.Parent then
            end
            if bI(co) then
            end
            if not v14[co] then
                v16(co)
                v15(co, "NEW")
                ck(co)
            end
        end)
    end)
    workspace.DescendantRemoving:Connect(function(cp)
        if v14[cp] then
            v15(cp, "MISSING")
            v14[cp] = nil
        end
    end)
    task.defer(function()
        task.wait(2)
        if K.ESP_Anomaly then
            for cq, cr in ipairs(workspace:GetDescendants()) do
                if cr:IsA("BasePart") or cr:IsA("Model") or cr:IsA("Sound") or cr:IsA("Light") then
                    if not cm(cr) and not aS(cr) and not bI(cr) and not aK[cr.Name] and bO(cr) and not v14[cr] then
                        v16(cr)
                        ck(cr)
                    end
                end
            end
        end
    end)
    task.spawn(function()
        while true do
            task.wait(3)
            for cs, ct in pairs(v14) do
                if ct then
                    ct:Repair()
                end
            end
        end
    end)
    if Drawing then
        local cu = {}
        local cv = {}
        local cw = {}
        function GC()
            for cx, cy in ipairs(cu) do
                if not cy.Visible then
                    return cy
                end
            end
            local cz = Drawing.new("Circle")
            cz.Thickness = 2
            cz.Filled = false
            cz.Transparency = 1
            cz.NumSides = 40
            table.insert(cu, cz)
            return cz
        end
        function GT()
            for cA, cB in ipairs(cv) do
                if not cB.Visible then
                    return cB
                end
            end
            local cC = Drawing.new("Text")
            cC.Size = 13
            cC.Center = true
            cC.Outline = true
            cC.OutlineColor = Color3.new()
            table.insert(cv, cC)
            return cC
        end
        function GL()
            for cD, cE in ipairs(cw) do
                if not cE.Visible then
                    return cE
                end
            end
            local cF = Drawing.new("Line")
            cF.Thickness = 1
            cF.Transparency = 1
            table.insert(cw, cF)
            return cF
        end
        v1.RenderStepped:Connect(function()
            for cG, cH in ipairs(cu) do
            end
            for cI, cJ in ipairs(cv) do
            end
            for cK, cL in ipairs(cw) do
            end
            local cM = v57.Character and v57.Character:FindFirstChild("HumanoidRootPart")
            local cN = tick()
            if K.ESP_AllObjects then
                for cO, cP in pairs(bn) do
                    if not cO.Parent then
                        bn[cO] = nil
                        continue;
                    end
                    if (tick()) - cP.time > 10 then
                        bn[cO] = nil
                        continue;
                    end
                    local cQ = aG(cO)
                    if (aG(cO)) then
                        cP.pos = cQ.Position
                    elseif cO:IsA("Tool") then
                        local cR = cO:FindFirstChild("Handle")
                        if (cO:FindFirstChild("Handle")) and cR:IsA("BasePart") then
                            cP.pos = cR.Position
                        else
                            continue;
                        end
                    else
                        continue;
                    end
                    local cS = (cP.pos - cM.Position).Magnitude
                    if cS > 500 then
                        continue;
                    end
                    local cT, cU = v59:WorldToViewportPoint(cP.pos)
                    if not cU then
                        continue;
                    end
                    local cV = GC()
                    local cW = GT()
                    if (GC()) then
                        cV.Position = Vector2.new(cT.X, cT.Y)
                        GT().Position = Vector2.new(cT.X, cT.Y - 16)
                        cW.Color = Color3.fromRGB(255, 255, 255)
                    end
                end
            end
            if K.ESP_Items then
                for cX, cY in pairs(bk) do
                    if not cX.Parent then
                        bk[cX] = nil
                        continue;
                    end
                    if cN - cY.time > 6 then
                        bk[cX] = nil
                        continue;
                    end
                    local cZ = aG(cX)
                    if (aG(cX)) then
                        cY.pos = cZ.Position
                    end
                    local c_ = (cY.pos - cM.Position).Magnitude
                    if c_ > 300 then
                        continue;
                    end
                    local v41, v42 = v59:WorldToViewportPoint(cY.pos)
                    if not v42 then
                        continue;
                    end
                    if K.ESP_Tracers then
                        local v45 = v59:WorldToViewportPoint(cM.Position)
                        local v46 = GL()
                        if (GL()) then
                            v46.From = Vector2.new(v45.X, v45.Y)
                            v46.To = Vector2.new(v41.X, v41.Y)
                            v46.Color = Color3.fromRGB(255, 150, 0)
                        end
                    end
                    local v43 = GC()
                    local v44 = GT()
                    if (GC()) then
                        local v47 = math.clamp(math.max(cZ and cZ.Size.X or 2, cZ and cZ.Size.Y or 2, cZ and cZ.Size.Z or 2) * 0.8, 3, 25)
                        v43.Position = Vector2.new(v41.X, v41.Y)
                        v43.Color = Color3.fromRGB(255, 150, 0)
                        GT().Position = Vector2.new(v41.X, v41.Y - v47 - 14)
                        v44.Color = Color3.fromRGB(255, 255, 255)
                    end
                end
            end
        end)
    end
    local v17 = Instance.new("ScreenGui")
    v17.Name = "UWU_Hub"
    v17.ResetOnSpawn = false
    v17.IgnoreGuiInset = true
    v17.Parent = v61
    local v18 = Instance.new("Frame")
    v18.Size = UDim2.fromOffset(520, 420)
    v18.Position = UDim2.fromScale(0.5, 0.5)
    v18.AnchorPoint = Vector2.new(0.5, 0.5)
    v18.BackgroundColor3 = I.BG
    v18.BorderSizePixel = 0
    v18.Active = true
    v18.Draggable = true
    v18.Visible = true
    v18.Parent = v17
    Instance.new("UICorner", v18).CornerRadius = UDim.new(0, 22)
    local ea = Instance.new("UIStroke")
    local eb = Instance.new("Frame")
    eb.Size = UDim2.new(1, 0, 0, 58)
    eb.BackgroundTransparency = 1
    eb.Parent = v18
    local ec = Instance.new("TextLabel")
    ec.Size = UDim2.new(1, -80, 1, 0)
    ec.Position = UDim2.fromOffset(24, 0)
    local ed = Instance.new("TextLabel")
    ed.Size = UDim2.new(1, -80, 0, 18)
    ed.Position = UDim2.fromOffset(24, 30)
    local ee
    local ef = {[[  ╱|、
 ( °  °)  
  |  ~ |   
  じしˍ,)ノ]], [[  ╱|、
 ( -  -)  
  |  ~ |   
  じしˍ,)ノ]], [[  ╱|、
 ( ◉  ◉)  
  |  ~ |   
  じしˍ,)ノ]], [[  ╱|、
 ( ˘  ˘)  
  |  ~ |   
  じしˍ,)ノ]]}
    local function eg()
        if ee then
            ee:Destroy()
        end
        ee = Instance.new("TextButton")
        ee.Size = UDim2.fromOffset(40, 40)
        ee.Position = UDim2.new(0.5, -20, 0.02, 0)
        ee.BackgroundColor3 = I.CARD
        ee.Text = ef[1]
        ee.TextColor3 = I.RED
        ee.Font = Enum.Font.GothamBold
        ee.TextSize = 7
        ee.BorderSizePixel = 0
        ee.Active = true
        ee.Draggable = true
        ee.Parent = v17
        Instance.new("UICorner", ee).CornerRadius = UDim.new(1, 0)
        local eh = Instance.new("Frame")
        eh.Size = UDim2.new(1, 6, 1, 6)
        eh.Position = UDim2.fromOffset(-3, -3)
        eh.BackgroundColor3 = I.RED
        eh.BackgroundTransparency = 0.6
        eh.BorderSizePixel = 0
        eh.ZIndex = 0
        eh.Parent = ee
        Instance.new("UICorner", eh).CornerRadius = UDim.new(1, 0)
        local ei = 1
        spawn(function()
            while ee and ee.Parent do
                ei = ei % #ef + 1
                ee.Text = ef[ei]
                wait(0.8)
            end
        end)
        ee.MouseButton1Click:Connect(function()
            ee:Destroy()
            v18.Visible = true
        end)
    end
    local ej = Instance.new("TextButton")
    ej.Size = UDim2.fromOffset(34, 34)
    ej.Position = UDim2.new(1, -54, 0.5, -17)
    ej.Text = "—"
    ej.Font = Enum.Font.GothamBold
    ej.TextColor3 = I.TEXT
    ej.BackgroundColor3 = I.CARD
    ej.Parent = eb
    Instance.new("UICorner", ej).CornerRadius = UDim.new(1, 0)
    ej.MouseButton1Click:Connect(function()
        v18.Visible = false
        eg()
    end)
    local ek = Instance.new("Frame")
    ek.Size = UDim2.new(0, 130, 1, -82)
    ek.Position = UDim2.fromOffset(18, 68)
    ek.BackgroundColor3 = I.PANEL
    ek.Parent = v18
    Instance.new("UICorner", ek).CornerRadius = UDim.new(0, 18)
    local el = Instance.new("UIListLayout")
    el.Padding = UDim.new(0, 8)
    local em = Instance.new("Frame")
    em.Size = UDim2.new(1, -160, 1, -82)
    em.Position = UDim2.fromOffset(150, 68)
    em.BackgroundColor3 = I.PANEL
    em.Parent = v18
    Instance.new("UICorner", em).CornerRadius = UDim.new(0, 18)
    local eo = {}
    local function ep(eq)
        local er = Instance.new("TextButton")
        er.Size = UDim2.new(1, -12, 0, 42)
        er.Position = UDim2.fromOffset(6, 0)
        er.Text = eq
        er.Font = Enum.Font.GothamBold
        er.TextSize = 13
        er.TextColor3 = I.MUTED
        er.BackgroundColor3 = I.CARD
        er.Parent = ek
        Instance.new("UICorner", er).CornerRadius = UDim.new(0, 14)
        local es = Instance.new("Frame")
        es.Visible = false
        es.Size = UDim2.new(1, 0, 1, 0)
        es.BackgroundTransparency = 1
        es.Parent = em
        eo[eq] = es
        er.MouseButton1Click:Connect(function()
            for et, eu in pairs(eo) do
            end
            es.Visible = true
            v3:Create(er, TweenInfo.new(0.18), {BackgroundColor3 = I.ACCENT}):Play()
            er.TextColor3 = I.TEXT
        end)
        return es
    end
    local ev = ep("Home")
    local ew = ep("ESP")
    local ex = ep("Player")
    local ey = ep("Visual")
    local function ez(eA, eB, eC)
        local eD = Instance.new("Frame")
        eD.Size = UDim2.new(1, -26, 0, 72)
        eD.Position = UDim2.fromOffset(13, 0)
        eD.BackgroundColor3 = I.CARD
        eD.Parent = eA
        Instance.new("UICorner", eD).CornerRadius = UDim.new(0, 16)
        local eE = Instance.new("TextLabel")
        eE.Size = UDim2.new(1, -30, 0, 22)
        eE.Position = UDim2.fromOffset(16, 14)
        local eF = Instance.new("TextLabel")
        eF.Size = UDim2.new(1, -30, 0, 24)
        eF.Position = UDim2.fromOffset(16, 38)
        return eD
    end
    local eG = Instance.new("UIListLayout")
    eG.Padding = UDim.new(0, 10)
    ez(ev, "✦ UWU HUB v70", "ESP Fully Independent\nAll systems separate")
    local eH = Instance.new("Frame")
    eH.Size = UDim2.new(1, -26, 0, 90)
    eH.Position = UDim2.fromOffset(13, 0)
    eH.BackgroundColor3 = I.CARD
    eH.Parent = ev
    Instance.new("UICorner", eH).CornerRadius = UDim.new(0, 16)
    local eI = Instance.new("TextLabel")
    eI.Size = UDim2.new(1, -20, 0, 20)
    eI.Position = UDim2.fromOffset(10, 8)
    local eJ = Instance.new("TextButton")
    eJ.Size = UDim2.new(1, -20, 0, 25)
    eJ.Position = UDim2.fromOffset(10, 32)
    eJ.Text = "🔑 GET KEY"
    eJ.Font = Enum.Font.GothamBold
    eJ.TextSize = 10
    eJ.TextColor3 = Color3.fromRGB(255, 255, 255)
    eJ.BackgroundColor3 = Color3.fromRGB(255, 150, 190)
    eJ.BorderSizePixel = 0
    eJ.Parent = eH
    Instance.new("UICorner", eJ).CornerRadius = UDim.new(0, 6)
    eJ.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard("https://guns.lol/sqworexo")
            v4:SetCore("SendNotification", {Title = "UWU HUB", Text = "Get Key link copied!", Duration = 2})
        end
    end)
    local eK = Instance.new("TextButton")
    eK.Size = UDim2.new(1, -20, 0, 25)
    eK.Position = UDim2.fromOffset(10, 60)
    eK.Text = "📱 TELEGRAM"
    eK.Font = Enum.Font.GothamBold
    eK.TextSize = 10
    eK.TextColor3 = Color3.fromRGB(255, 255, 255)
    eK.BackgroundColor3 = Color3.fromRGB(0, 136, 204)
    eK.BorderSizePixel = 0
    eK.Parent = eH
    Instance.new("UICorner", eK).CornerRadius = UDim.new(0, 6)
    eK.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard("https://t.me/dd_left_dd")
            v4:SetCore("SendNotification", {Title = "UWU HUB", Text = "Telegram link copied!", Duration = 2})
        end
    end)
    local function eL(eM, eN, eO, eP)
        local eQ = eO
        local eR = Instance.new("Frame")
        eR.Size = UDim2.new(1, -20, 0, 38)
        eR.Position = UDim2.fromOffset(10, 0)
        eR.BackgroundColor3 = I.CARD
        eR.Parent = eM
        Instance.new("UICorner", eR).CornerRadius = UDim.new(0, 12)
        local eS = Instance.new("TextLabel")
        eS.Size = UDim2.new(0.6, 0, 1, 0)
        eS.Position = UDim2.fromOffset(12, 0)
        local eT = Instance.new("TextButton")
        eT.Size = UDim2.fromOffset(44, 24)
        eT.Position = UDim2.new(1, -54, 0.5, -12)
        eT.Text = eQ and "ON" or "OFF"
        eT.BackgroundColor3 = eQ and I.ACCENT or I.CARD
        eT.TextColor3 = I.TEXT
        eT.Font = Enum.Font.GothamBold
        eT.TextSize = 10
        eT.Parent = eR
        Instance.new("UICorner", eT).CornerRadius = UDim.new(0, 10)
        eT.MouseButton1Click:Connect(function()
            eQ = not eQ
            eT.Text = eQ and "ON" or "OFF"
            eT.BackgroundColor3 = eQ and I.ACCENT or I.CARD
            eP(eQ)
        end)
        return eR
    end
    local eU = Instance.new("UIListLayout")
    eU.Padding = UDim.new(0, 8)
    eL(ew, "Monster ESP", false, function(eV)
        K.ESP_Monsters = eV
        bc(eV)
    end)
    eL(ew, "All Objects ESP", false, function(eW)
        K.ESP_AllObjects = eW
    end)
    eL(ew, "Item ESP", false, function(eX)
        K.ESP_Items = eX
    end)
    eL(ew, "Item Tracers", false, function(eY)
        K.ESP_Tracers = eY
    end)
    eL(ew, "Anomaly ESP", false, function(eZ)
        K.ESP_Anomaly = eZ
    end)
    local e_ = Instance.new("UIListLayout")
    e_.Padding = UDim.new(0, 8)
    eL(ex, "Auto Win", false, function(v48)
        K.AutoWin = v48
        ag(v48)
    end)
    eL(ex, "Speed (25)", false, function(v49)
        K.Speed = v49
        S(v49)
    end)
    eL(ex, "Fly (x2)", false, function(v50)
        K.Fly = v50
        _(v50)
    end)
    eL(ex, "Noclip", false, function(v51)
        K.Noclip = v51
        v10(v51)
    end)
    eL(ex, "Fullbright", false, function(v52)
        K.Fullbright = v52
        Q(v52)
    end)
    eL(ex, "FOV (100)", false, function(v53)
        K.FOV = v53
        ad(v53)
    end)
    local fa = Instance.new("UIListLayout")
    fa.Padding = UDim.new(0, 8)
    eL(ey, "Chinese Hat", false, function(v54)
        aA(v54)
    end)
    eL(ey, "Pink Trail", false, function(v55)
        aC(v55)
    end)
    eo.Home.Visible = true
end
