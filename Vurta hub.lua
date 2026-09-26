-- this is for TPS: Street Soccer

local k0_1, k0_3, k0_5, k0_7, k0_9, k0_11, k0_13, k0_15, k0_17, k0_19, k0_21, k0_23, k0_25, k0_27, k0_29, k0_31, k0_33, k0_35, k0_37, k0_39, k0_41, k0_43, k0_45, k0_47
local k0_49
local function tryOperation33()
    loadstring(game:HttpGet("https://sirius.menu/rayfield"))
    return nil, "bad argument #1 to load"
end
local v1
local function createPart()
    local part = Instance.new("Part")
    part.Shape = Enum.PartType.Ball
    part.Color = Color3.fromRGB(255, 0, 0)
    part.Material = Enum.Material.Neon
    part.Transparency = 0.5
    part.CanCollide = false
    part.Anchored = true
    part.Parent = v1
    return part
end
local function tryOperation34()
    local a
    local function tryOperation32()
        local function checkCondition()
            return true
        end
        hookfunction(a, checkCondition)
    end
    if getgenv then
        pairs().SecureMode = true
    end
    local b = getgc(true)
    local c = table.pack(pairs(b))
    table.unpack(c, 1, c.n)
    b = table.unpack(c, 2, c.n)
    table.unpack(c, 3, c.n)
    a = b
    local getinfo
    if next ~= nil then
        while true do
            getinfo = debug.getinfo(a)
            if getinfo and getinfo.name and getinfo.name:find("Check") then
                pcall(tryOperation32)
            end
            a = b
            if next == nil then
                break
            end
        end
    end
end
local v2
local function tryOperation35()
    if identifyexecutor then
        v2 = identifyexecutor()
    end
end
local v3, v4
local function computeValue(a, b)
    local function backgroundTask7()
        local function tryOperation31()
            local function processValues(f)
                getnamecallmethod()
            end
            local c = v3.Character or v3.CharacterAdded:Wait()
            hookmetamethod(game, "__namecall", processValues)
            local humanoidRootPart, vurtaHubCustomEffect, e
            if c then
                humanoidRootPart = c:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    vurtaHubCustomEffect = humanoidRootPart:FindFirstChild("VurtaHubCustomEffect")
                    if vurtaHubCustomEffect then
                        vurtaHubCustomEffect:Destroy()
                    end
                    e = Instance.new("ParticleEmitter")
                    e.Name = "VurtaHubCustomEffect"
                    e.Color = ColorSequence.new(a, b)
                    e.Size = NumberSequence.new(1.5, 0)
                    e.Rate = 35
                    e.Speed = NumberRange.new(5, 10)
                    e.Parent = humanoidRootPart
                    return
                end
            end
        end
        pcall(tryOperation31)
    end
    v4 = {[1] = a, [2] = b}
    task.spawn(backgroundTask7)
    return a, b
end
local function runProtected2(a)
    local function findChild2()
        if a then
            a:FindFirstChild("Head")
            return
        end
    end
    pcall(findChild2)
    return a
end
local function runProtected3(a)
    local function tryOperation30()
        local rightLowerLeg, rightFoot, e
        if a then
            a:FindFirstChild("RightUpperLeg")
            rightLowerLeg = a:FindFirstChild("RightLowerLeg")
            rightFoot = a:FindFirstChild("RightFoot")
            if rightLowerLeg then
                rightLowerLeg.Transparency = 1
            end
            if rightFoot then
                rightFoot.Transparency = 1
            end
            for k, v in ipairs(a:GetDescendants()) do
                e = v:IsA("MeshPart")
                if e then
                    v.Name:lower():find("right")
                    e = v.Name:lower():find("leg")
                end
                if e then
                    v.Transparency = 1
                end
            end
            return
        end
    end
    pcall(tryOperation30)
    return a
end
local function runProtected4(a)
    local function tryOperation29()
        local leftLowerLeg, leftFoot, e
        if a then
            a:FindFirstChild("LeftUpperLeg")
            leftLowerLeg = a:FindFirstChild("LeftLowerLeg")
            leftFoot = a:FindFirstChild("LeftFoot")
            if leftLowerLeg then
                leftLowerLeg.Transparency = 1
            end
            if leftFoot then
                leftFoot.Transparency = 1
            end
            for k, v in ipairs(a:GetDescendants()) do
                e = v:IsA("MeshPart")
                if e then
                    v.Name:lower():find("left")
                    e = v.Name:lower():find("leg")
                end
                if e then
                    v.Transparency = 1
                end
            end
            return
        end
    end
    pcall(tryOperation29)
    return a
end
local v5, v6, v7, v8, v9, v10, v11, v12
local function onCharacterAdded(a)
    local function backgroundTask2()
        local function tryOperation28()
            local humanoidRootPart2 = a:WaitForChild("HumanoidRootPart", 5)
            local vurtaHubCustomEffect2, b, c, d
            if humanoidRootPart2 then
                vurtaHubCustomEffect2 = humanoidRootPart2:FindFirstChild("VurtaHubCustomEffect")
                if vurtaHubCustomEffect2 then
                    vurtaHubCustomEffect2:Destroy()
                end
                b = Instance.new("ParticleEmitter")
                b.Name = "VurtaHubCustomEffect"
                c = v4[1]
                d = v4[2]
                b.Color = ColorSequence.new(c, d)
                b.Size = NumberSequence.new(1.5, 0)
                b.Rate = 35
                b.Speed = NumberRange.new(5, 10)
                b.Parent = humanoidRootPart2
                return
            end
        end
        pcall(tryOperation28)
    end
    local function backgroundTask3()
        local function clearChildren()
            local function tryOperation27()
                return v5:GetCharacterAppearanceAsync(v12)
            end
            local getChildren = a:GetChildren()
            local b = table.pack(ipairs(getChildren))
            table.unpack(b, 1, b.n)
            getChildren = table.unpack(b, 2, b.n)
            local c = table.unpack(b, 3, b.n)
            b = table.pack(ipairs(getChildren, c))
            local d = table.unpack(b, 1, b.n)
            local e, f, g
            if d ~= nil then
                c = d
                if table.unpack(b, 2, b.n):IsA("Accessory") or table.unpack(b, 2, b.n):IsA("Shirt") or table.unpack(b, 2, b.n):IsA("Pants") or table.unpack(b, 2, b.n):IsA("ShirtGraphic") or table.unpack(b, 2, b.n):IsA("BodyColors") or table.unpack(b, 2, b.n):IsA("WrapLayer") or table.unpack(b, 2, b.n):IsA("WrapDeform") or table.unpack(b, 2, b.n):IsA("Clothing") or table.unpack(b, 2, b.n):IsA("CharacterMesh") then
                    table.unpack(b, 2, b.n):Destroy()
                    local __cont1 = false
                    while true do
                        b = table.pack(pcall(getChildren, c))
                        d = table.unpack(b, 1, b.n)
                        if not (d == nil) then
                            c = d
                            while true do
                                if table.unpack(b, 2, b.n):IsA("Accessory") or table.unpack(b, 2, b.n):IsA("Shirt") or table.unpack(b, 2, b.n):IsA("Pants") or table.unpack(b, 2, b.n):IsA("ShirtGraphic") or table.unpack(b, 2, b.n):IsA("BodyColors") or table.unpack(b, 2, b.n):IsA("WrapLayer") or table.unpack(b, 2, b.n):IsA("WrapDeform") or table.unpack(b, 2, b.n):IsA("Clothing") or table.unpack(b, 2, b.n):IsA("CharacterMesh") then
                                    table.unpack(b, 2, b.n):Destroy()
                                    __cont1 = true
                                    break
                                else
                                    b = table.pack(pcall(getChildren, c))
                                    d = table.unpack(b, 1, b.n)
                                    if d == nil then
                                        break
                                    else
                                        c = d
                                    end
                                end
                            end
                            if __cont1 then
                                __cont1 = false
                                continue
                            end
                            break
                        end
                        break
                    end
                else
                    b = table.pack(pcall(getChildren, c))
                    d = table.unpack(b, 1, b.n)
                    if not (d == nil) then
                        c = d
                        while true do
                            if table.unpack(b, 2, b.n):IsA("Accessory") or table.unpack(b, 2, b.n):IsA("Shirt") or table.unpack(b, 2, b.n):IsA("Pants") or table.unpack(b, 2, b.n):IsA("ShirtGraphic") or table.unpack(b, 2, b.n):IsA("BodyColors") or table.unpack(b, 2, b.n):IsA("WrapLayer") or table.unpack(b, 2, b.n):IsA("WrapDeform") or table.unpack(b, 2, b.n):IsA("Clothing") or table.unpack(b, 2, b.n):IsA("CharacterMesh") then
                                table.unpack(b, 2, b.n):Destroy()
                                b = table.pack(pcall(getChildren, c))
                                d = table.unpack(b, 1, b.n)
                                if not (d == nil) then
                                    c = d
                                    continue
                                end
                            else
                                b = table.pack(pcall(getChildren, c))
                                d = table.unpack(b, 1, b.n)
                                if d == nil then
                                    break
                                else
                                    c = d
                                    continue
                                end
                            end
                            break
                        end
                    end
                end
            end
            b = table.pack(pcall(tryOperation27))
            x1 = table.unpack(b, 1, b.n)
            c = x1
            if x1 then
                c = table.unpack(b, 2, b.n)
            end
            if c then
                getChildren = table.unpack(b, 2, b.n)
                d = getChildren:GetChildren()
                b = table.pack(ipairs(d))
                c = table.unpack(b, 1, b.n)
                d = table.unpack(b, 2, b.n)
                e = table.unpack(b, 3, b.n)
                b = table.pack(ipairs(d, e))
                f = table.unpack(b, 1, b.n)
                if f ~= nil then
                    if table.unpack(b, 2, b.n):IsA("Accessory") or table.unpack(b, 2, b.n):IsA("Shirt") or table.unpack(b, 2, b.n):IsA("Pants") or table.unpack(b, 2, b.n):IsA("ShirtGraphic") or table.unpack(b, 2, b.n):IsA("BodyColors") or table.unpack(b, 2, b.n):IsA("WrapLayer") or table.unpack(b, 2, b.n):IsA("WrapDeform") or table.unpack(b, 2, b.n):IsA("Clothing") or table.unpack(b, 2, b.n):IsA("CharacterMesh") then
                        table.unpack(b, 2, b.n)
                        g:Clone().Parent = a
                    else
                        table.unpack(b, 2, b.n):IsA("Model")
                    end
                    b = table.pack(c(d, f))
                    f = table.unpack(b, 1, b.n)
                    if not (f == nil) then
                        e = f
                        while true do
                            if table.unpack(b, 2, b.n):IsA("Accessory") or table.unpack(b, 2, b.n):IsA("Shirt") or table.unpack(b, 2, b.n):IsA("Pants") or table.unpack(b, 2, b.n):IsA("ShirtGraphic") or table.unpack(b, 2, b.n):IsA("BodyColors") or table.unpack(b, 2, b.n):IsA("WrapLayer") or table.unpack(b, 2, b.n):IsA("WrapDeform") or table.unpack(b, 2, b.n):IsA("Clothing") or table.unpack(b, 2, b.n):IsA("CharacterMesh") then
                                table.unpack(b, 2, b.n):Clone().Parent = a
                            else
                                table.unpack(b, 2, b.n):IsA("Model")
                            end
                            b = table.pack(c(d, e))
                            f = table.unpack(b, 1, b.n)
                            if not (f == nil) then
                                e = f
                                continue
                            end
                            break
                        end
                    end
                end
                getChildren:Destroy()
                return x1, getChildren
            else
                return table.unpack(b, 1, b.n)
            end
        end
        pcall(clearChildren)
    end
    local function backgroundTask4()
        task.wait(0.2)
        v7(a)
    end
    local function backgroundTask5()
        task.wait(0.2)
        v10(a)
    end
    local function backgroundTask6()
        task.wait(0.2)
        v11(a)
    end
    task.wait(1)
    if v4 then
        task.spawn(backgroundTask2)
    end
    if v12 then
        task.spawn(backgroundTask3)
    end
    if v6 then
        task.spawn(backgroundTask4)
    end
    if v8 then
        task.spawn(backgroundTask5)
    end
    if v9 then
        task.spawn(backgroundTask6)
    end
    return a
end
local v13, v14, v15, v16, v17
local function CallbackHandler(showHitbox)
    v17.ShowHitbox = showHitbox
    if not showHitbox then
        v13.Size = Vector3.new(0, 0, 0)
        v14.Size = Vector3.new(0, 0, 0)
        v15.Size = Vector3.new(0, 0, 0)
        v16.Size = Vector3.new(0, 0, 0)
    end
end
local function CallbackHandler2(leftReachEnabled)
    v17.LeftReachEnabled = leftReachEnabled
end
local v18
local function CallbackHandler3(a)
    v18 = a
end
local function CallbackHandler4(rightReachEnabled)
    v17.RightReachEnabled = rightReachEnabled
end
local v19
local function CallbackHandler5(a)
    v19 = a
end
local function CallbackHandler6(headReachEnabled)
    v17.HeadReachEnabled = headReachEnabled
end
local v20
local function CallbackHandler7(a)
    v20 = a
end
local function CallbackHandler8(ballReachEnabled)
    v17.BallReachEnabled = ballReachEnabled
end
local v21
local function CallbackHandler9(a)
    v21 = a
end
local function CallbackHandler10(armReachEnabled)
    v17.ArmReachEnabled = armReachEnabled
end
local v22
local function CallbackHandler11(a)
    v22 = a
end
local v23
local function callback(a)
    v23 = a
end
local v24
local function callback2()
    local k22_1, k22_3
    local a, b
    local function tryOperation26()
        setfflag(a, b)
    end
    local c, d, e, f, g, h
    if setfflag then
        c = v23.gmatch
        h = table.pack(c(v23, "[^\r\n]+"))
        c = table.unpack(h, 1, h.n)
        d = table.unpack(h, 2, h.n)
        f = next(d, table.unpack(h, 3, h.n))
        repeat
            local shouldExit = false
            if f ~= nil then
                e = f
                g = "([^%s=]+)%s+([^%s=]+)"
                b = f
                a = f.match
                local k22_3 = {}
                while true do
                    h = table.pack(a(b, g))
                    while true do
                        a = table.unpack(h, 1, h.n)
                        g = a
                        if g then
                            b = table.unpack(h, 2, h.n)
                            g = b
                        end
                        if g then
                            pcall(tryOperation26)
                            f = c(d, e)
                            if f == nil then
                                e = k22_3
                                k22_3.Title = "FFlags"
                                k22_3.Content = "Injected successfully!"
                                f = 3
                                k22_3.Duration = 3
                                d = v24
                                c = v24.Notify
                                c(v24, k22_3)
                            else
                                e = f
                                b = f
                                a = f.match
                                h = table.pack(a(f, "([^%s=]+)%s+([^%s=]+)"))
                                continue
                            end
                        else
                            break
                        end
                        shouldExit = true
                        break
                    end
                    if shouldExit then
                        break
                    end
                    f = c(d, e)
                    if f == nil then
                        break
                    else
                        e = f
                        g = "([^%s=]+)%s+([^%s=]+)"
                        b = f
                        a = f.match
                    end
                end
                if shouldExit then
                    break
                end
                v24:Notify({
                    Title = "FFlags",
                    Content = "Injected successfully!",
                    Duration = 3,
                })
            else
                local k22_1 = {
                    Title = "FFlags",
                    Content = "Injected successfully!",
                    Duration = 3,
                }
                v24:Notify(k22_1)
            end
        until true
    else
        v24:Notify({
            Title = "FFlags",
            Content = "Not Supported by your executor!",
            Duration = 3,
        })
    end
end
local function callback3(fly)
    v17.Fly = fly
end
local function callback4(speedEnabled)
    v17.SpeedEnabled = speedEnabled
end
local v25
local function CallbackHandler12(a)
    v25 = a
end
local v26
local function callback5(a)
    v26 = a
end
local function computeValue2(a, b)
    local function backgroundTask()
        local function tryOperation24()
            return v5:GetUserIdFromNameAsync(b)
        end
        local c
        local function tryOperation25()
            return v5:GetCharacterAppearanceAsync(c)
        end
        local d = a.Character or a.CharacterAdded:Wait()
        c = 0.3
        task.wait(0.3)
        c = b
        b = b:match("^%s*(.-)%s*$")
        c = tryOperation24
        local e = table.pack(pcall(tryOperation24))
        local f = table.unpack(e, 1, e.n)
        local g = not f
        if not g then
            c = table.unpack(e, 2, e.n)
            g = not c
        end
        local h, i, j, k, l, m
        if g then
            return d, table.unpack(e, 1, e.n)
        else
            c = table.unpack(e, 2, e.n)
            v12 = c
            h = d:GetChildren()
            e = table.pack(ipairs(h))
            table.unpack(e, 1, e.n)
            h = table.unpack(e, 2, e.n)
            i = table.unpack(e, 3, e.n)
            e = table.pack(ipairs(h, i))
            j = table.unpack(e, 1, e.n)
            if j ~= nil then
                i = j
                if table.unpack(e, 2, e.n):IsA("Accessory") or table.unpack(e, 2, e.n):IsA("Shirt") or table.unpack(e, 2, e.n):IsA("Pants") or table.unpack(e, 2, e.n):IsA("ShirtGraphic") or table.unpack(e, 2, e.n):IsA("BodyColors") or table.unpack(e, 2, e.n):IsA("WrapLayer") or table.unpack(e, 2, e.n):IsA("WrapDeform") or table.unpack(e, 2, e.n):IsA("Clothing") or table.unpack(e, 2, e.n):IsA("CharacterMesh") then
                    table.unpack(e, 2, e.n):Destroy()
                    local __cont1 = false
                    while true do
                        e = table.pack(pcall(h, i))
                        j = table.unpack(e, 1, e.n)
                        if not (j == nil) then
                            i = j
                            while true do
                                if table.unpack(e, 2, e.n):IsA("Accessory") or table.unpack(e, 2, e.n):IsA("Shirt") or table.unpack(e, 2, e.n):IsA("Pants") or table.unpack(e, 2, e.n):IsA("ShirtGraphic") or table.unpack(e, 2, e.n):IsA("BodyColors") or table.unpack(e, 2, e.n):IsA("WrapLayer") or table.unpack(e, 2, e.n):IsA("WrapDeform") or table.unpack(e, 2, e.n):IsA("Clothing") or table.unpack(e, 2, e.n):IsA("CharacterMesh") then
                                    table.unpack(e, 2, e.n):Destroy()
                                    __cont1 = true
                                    break
                                else
                                    e = table.pack(pcall(h, i))
                                    j = table.unpack(e, 1, e.n)
                                    if j == nil then
                                        break
                                    else
                                        i = j
                                    end
                                end
                            end
                            if __cont1 then
                                __cont1 = false
                                continue
                            end
                            break
                        end
                        break
                    end
                else
                    e = table.pack(pcall(h, i))
                    j = table.unpack(e, 1, e.n)
                    if not (j == nil) then
                        i = j
                        while true do
                            if table.unpack(e, 2, e.n):IsA("Accessory") or table.unpack(e, 2, e.n):IsA("Shirt") or table.unpack(e, 2, e.n):IsA("Pants") or table.unpack(e, 2, e.n):IsA("ShirtGraphic") or table.unpack(e, 2, e.n):IsA("BodyColors") or table.unpack(e, 2, e.n):IsA("WrapLayer") or table.unpack(e, 2, e.n):IsA("WrapDeform") or table.unpack(e, 2, e.n):IsA("Clothing") or table.unpack(e, 2, e.n):IsA("CharacterMesh") then
                                table.unpack(e, 2, e.n):Destroy()
                                e = table.pack(pcall(h, i))
                                j = table.unpack(e, 1, e.n)
                                if not (j == nil) then
                                    i = j
                                    continue
                                end
                            else
                                e = table.pack(pcall(h, i))
                                j = table.unpack(e, 1, e.n)
                                if j == nil then
                                    break
                                else
                                    i = j
                                    continue
                                end
                            end
                            break
                        end
                    end
                end
            end
            e = table.pack(pcall(tryOperation25))
            g = table.unpack(e, 1, e.n)
            if g and table.unpack(e, 2, e.n) then
                h = table.unpack(e, 2, e.n)
                j = h:GetChildren()
                e = table.pack(ipairs(j))
                i = table.unpack(e, 1, e.n)
                j = table.unpack(e, 2, e.n)
                k = table.unpack(e, 3, e.n)
                e = table.pack(ipairs(j, k))
                l = table.unpack(e, 1, e.n)
                if l ~= nil then
                    if table.unpack(e, 2, e.n):IsA("Accessory") or table.unpack(e, 2, e.n):IsA("Shirt") or table.unpack(e, 2, e.n):IsA("Pants") or table.unpack(e, 2, e.n):IsA("ShirtGraphic") or table.unpack(e, 2, e.n):IsA("BodyColors") or table.unpack(e, 2, e.n):IsA("WrapLayer") or table.unpack(e, 2, e.n):IsA("WrapDeform") or table.unpack(e, 2, e.n):IsA("Clothing") or table.unpack(e, 2, e.n):IsA("CharacterMesh") then
                        table.unpack(e, 2, e.n)
                        m:Clone().Parent = d
                    else
                        table.unpack(e, 2, e.n):IsA("Model")
                    end
                    e = table.pack(i(j, l))
                    l = table.unpack(e, 1, e.n)
                    if not (l == nil) then
                        k = l
                        while true do
                            if table.unpack(e, 2, e.n):IsA("Accessory") or table.unpack(e, 2, e.n):IsA("Shirt") or table.unpack(e, 2, e.n):IsA("Pants") or table.unpack(e, 2, e.n):IsA("ShirtGraphic") or table.unpack(e, 2, e.n):IsA("BodyColors") or table.unpack(e, 2, e.n):IsA("WrapLayer") or table.unpack(e, 2, e.n):IsA("WrapDeform") or table.unpack(e, 2, e.n):IsA("Clothing") or table.unpack(e, 2, e.n):IsA("CharacterMesh") then
                                table.unpack(e, 2, e.n)
                                m:Clone().Parent = d
                            else
                                table.unpack(e, 2, e.n):IsA("Model")
                            end
                            e = table.pack(i(j, k))
                            l = table.unpack(e, 1, e.n)
                            if not (l == nil) then
                                k = l
                                continue
                            end
                            break
                        end
                    end
                end
                h:Destroy()
                return d, f, c, g, h
            else
                return d, f, c, table.unpack(e, 1, e.n)
            end
        end
    end
    task.spawn(backgroundTask)
    return a, b
end
local v27
local function callback6()
    local k28_1
    local gsub = v26:gsub("@", "")
    local a = gsub
    if gsub then
        a = gsub ~= ""
    end
    if a then
        v27(v3, gsub)
        local k28_1 = {
            Title = "Avatar Stolen",
            Content = "Successfully applied avatar!",
            Duration = 3,
        }
        v24:Notify(k28_1)
    else
        v24:Notify({
            Title = "Error",
            Content = "Enter a valid username!",
            Duration = 3,
        })
    end
    return gsub
end
local function callback7(a)
    local k29_1
    local function tryOperation23()
        local character = v3.Character
        local head
        if character then
            head = character:FindFirstChild("Head")
            if head then
                head.Transparency = 0
                for k, v in ipairs(head:GetChildren()) do
                    if v:IsA("Decal") then
                        v.Transparency = 0
                    end
                end
                return
            end
        end
    end
    v6 = a
    if v6 then
        pcall(v3.Character)
        v24:Notify({
            Title = "Fake Headless",
            Content = "Headless activated!",
            Duration = 3,
        })
    else
        pcall(tryOperation23)
        local k29_1 = {
            Title = "Fake Headless",
            Content = "Headless deactivated!",
            Duration = 3,
        }
        v24:Notify(k29_1)
    end
    return a
end
local function callback8(a)
    local k30_1
    local function tryOperation22()
        local character2 = v3.Character
        local e
        if character2 then
            for k, v in ipairs(character2:GetDescendants()) do
                e = v:IsA("BasePart")
                if e then
                    v.Name:lower():find("right")
                    e = v.Name:lower():find("leg")
                end
                if e then
                    v.Transparency = 0
                end
            end
        end
    end
    v8 = a
    if v8 then
        pcall(v3.Character)
        v24:Notify({
            Title = "Korblox",
            Content = "Fake Right Leg activated!",
            Duration = 3,
        })
    else
        pcall(tryOperation22)
        local k30_1 = {
            Title = "Korblox",
            Content = "Fake Right Leg deactivated!",
            Duration = 3,
        }
        v24:Notify(k30_1)
    end
    return a
end
local function callback9(a)
    local k31_1
    local function tryOperation21()
        local character3 = v3.Character
        local e
        if character3 then
            for k, v in ipairs(character3:GetDescendants()) do
                e = v:IsA("BasePart")
                if e then
                    v.Name:lower():find("left")
                    e = v.Name:lower():find("leg")
                end
                if e then
                    v.Transparency = 0
                end
            end
        end
    end
    v9 = a
    if v9 then
        pcall(v3.Character)
        v24:Notify({
            Title = "Korblox",
            Content = "Fake Left Leg activated!",
            Duration = 3,
        })
    else
        pcall(tryOperation21)
        local k31_1 = {
            Title = "Korblox",
            Content = "Fake Left Leg deactivated!",
            Duration = 3,
        }
        v24:Notify(k31_1)
    end
    return a
end
local v28
local function callback10(a)
    local function tryOperation20()
        v3.Character.Humanoid.AutoRotate = true
        v3.Character.Humanoid.CameraOffset = Vector3.new(0, 0, 0)
    end
    v28 = a
    v17.MobileLockEnabled = a
    if not v28 then
        pcall(tryOperation20)
        return a
    else
        return
    end
end
local function callback11(bestReactEnabled)
    v17.BestReactEnabled = bestReactEnabled
end
local v29
local function callback12()
    v29(Color3.fromRGB(0, 150, 255), Color3.fromRGB(0, 200, 255))
    v24:Notify({
        Title = "Effect",
        Content = "Blue activated & integrated!",
        Duration = 3,
    })
end
local function callback13()
    v29(Color3.fromRGB(255, 105, 180), Color3.fromRGB(255, 182, 193))
    v24:Notify({
        Title = "Effect",
        Content = "Pink activated & integrated!",
        Duration = 3,
    })
end
local function callback14()
    v29(Color3.fromRGB(255, 255, 0), Color3.fromRGB(255, 215, 0))
    v24:Notify({
        Title = "Effect",
        Content = "Yellow activated & integrated!",
        Duration = 3,
    })
end
local function callback15()
    v29(Color3.fromRGB(0, 255, 0), Color3.fromRGB(50, 205, 50))
    v24:Notify({
        Title = "Effect",
        Content = "Green activated & integrated!",
        Duration = 3,
    })
end
local function callback16()
    v29(Color3.fromRGB(20, 20, 20), Color3.fromRGB(50, 50, 50))
    v24:Notify({
        Title = "Effect",
        Content = "Black activated & integrated!",
        Duration = 3,
    })
end
local function callback17()
    v29(Color3.fromRGB(255, 255, 255), Color3.fromRGB(220, 220, 220))
    v24:Notify({
        Title = "Effect",
        Content = "White activated & integrated!",
        Duration = 3,
    })
end
local function callback18()
    v29(Color3.fromRGB(128, 0, 128), Color3.fromRGB(186, 85, 211))
    v24:Notify({
        Title = "Effect",
        Content = "Purple activated & integrated!",
        Duration = 3,
    })
end
local function callback19()
    v29(Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 69, 0))
    v24:Notify({
        Title = "Effect",
        Content = "Red activated & integrated!",
        Duration = 3,
    })
end
local function callback20()
    v29(Color3.fromRGB(128, 128, 128), Color3.fromRGB(192, 192, 192))
    v24:Notify({
        Title = "Effect",
        Content = "Grey activated & integrated!",
        Duration = 3,
    })
end
local function callback21()
    v29(Color3.fromRGB(255, 128, 0), Color3.fromRGB(255, 165, 0))
    v24:Notify({
        Title = "Effect",
        Content = "Orange activated & integrated!",
        Duration = 3,
    })
end
local function callback22()
    v29(Color3.fromRGB(139, 69, 19), Color3.fromRGB(165, 42, 42))
    v24:Notify({
        Title = "Effect",
        Content = "Brown activated & integrated!",
        Duration = 3,
    })
end
local v30
local function callback23()
    local function tryOperation19()
        local getDescendants = v30:GetDescendants()
        local a = table.pack(ipairs(getDescendants))
        local b = table.unpack(a, 1, a.n)
        getDescendants = table.unpack(a, 2, a.n)
        local c = table.unpack(a, 3, a.n)
        a = table.pack(ipairs(getDescendants, c))
        local d = table.unpack(a, 1, a.n)
        local e, f
        if d ~= nil then
            c = d
            if table.unpack(a, 2, a.n):IsA("Decal") or table.unpack(a, 2, a.n):IsA("Texture") then
                table.unpack(a, 2, a.n):Destroy()
                local __cont1 = false
                while true do
                    a = table.pack(b(getDescendants, c))
                    d = table.unpack(a, 1, a.n)
                    if not (d == nil) then
                        c = d
                        while true do
                            if table.unpack(a, 2, a.n):IsA("Decal") or table.unpack(a, 2, a.n):IsA("Texture") then
                                table.unpack(a, 2, a.n):Destroy()
                                __cont1 = true
                                break
                            else
                                table.unpack(a, 2, a.n):IsA("BasePart")
                                a = table.pack(b(getDescendants, c))
                                d = table.unpack(a, 1, a.n)
                                if d == nil then
                                    break
                                else
                                    c = d
                                end
                            end
                        end
                        if __cont1 then
                            __cont1 = false
                            continue
                        end
                        break
                    end
                    break
                end
            else
                table.unpack(a, 2, a.n):IsA("BasePart")
                a = table.pack(b(getDescendants, c))
                d = table.unpack(a, 1, a.n)
                if not (d == nil) then
                    c = d
                    while true do
                        if table.unpack(a, 2, a.n):IsA("Decal") or table.unpack(a, 2, a.n):IsA("Texture") then
                            table.unpack(a, 2, a.n):Destroy()
                            a = table.pack(b(getDescendants, c))
                            d = table.unpack(a, 1, a.n)
                            if not (d == nil) then
                                c = d
                                continue
                            end
                        else
                            table.unpack(a, 2, a.n):IsA("BasePart")
                            a = table.pack(b(getDescendants, c))
                            d = table.unpack(a, 1, a.n)
                            if d == nil then
                                break
                            else
                                c = d
                                continue
                            end
                        end
                        break
                    end
                end
            end
        end
        b = v30:FindFirstChild("TPSSystem")
        getDescendants = b
        if getDescendants then
            d = "TPS"
        else
            return b, getDescendants, "TPSSystem", table.unpack(a, 1, a.n)
        end
        getDescendants = b:FindFirstChild(d)
        if getDescendants then
            d = getDescendants:GetDescendants()
            a = table.pack(ipairs(d))
            c = table.unpack(a, 1, a.n)
            d = table.unpack(a, 2, a.n)
            e = table.unpack(a, 3, a.n)
            a = table.pack(ipairs(d, e))
            f = table.unpack(a, 1, a.n)
            if f ~= nil then
                e = f
                while true do
                    if not (table.unpack(a, 2, a.n):IsA("Decal") or table.unpack(a, 2, a.n):IsA("Texture") or table.unpack(a, 2, a.n):IsA("ParticleEmitter")) then
                        a = table.pack(ipairs(d, e))
                        f = table.unpack(a, 1, a.n)
                        if f ~= nil then
                            e = f
                            continue
                        end
                        break
                    end
                    table.unpack(a, 2, a.n):Destroy()
                    local __cont6 = false
                    while true do
                        a = table.pack(c(d, e))
                        f = table.unpack(a, 1, a.n)
                        if f == nil then
                            e = f
                        else
                            e = f
                            while true do
                                if table.unpack(a, 2, a.n):IsA("Decal") or table.unpack(a, 2, a.n):IsA("Texture") or table.unpack(a, 2, a.n):IsA("ParticleEmitter") then
                                    table.unpack(a, 2, a.n):Destroy()
                                    __cont6 = true
                                    break
                                else
                                    a = table.pack(c(d, e))
                                    f = table.unpack(a, 1, a.n)
                                    if f == nil then
                                        break
                                    else
                                        e = f
                                    end
                                end
                            end
                            if __cont6 then
                                __cont6 = false
                                continue
                            end
                            break
                        end
                        return b, getDescendants, c, d, e, table.unpack(a, 1, a.n)
                    end
                    return b, getDescendants, c, d, f, table.unpack(a, 1, a.n)
                end
            end
            return b, getDescendants, c, d, f, table.unpack(a, 1, a.n)
        else
            return
        end
    end
    pcall(tryOperation19)
    v24:Notify({
        Title = "Optimization",
        Content = "FPS Boost applied (Ground, walls, ball graphics cleared)!",
        Duration = 3,
    })
end
local function callback24()
    local function tryOperation18()
        local k67_1
        local character4 = v3.Character
        local a = character4
        if character4 then
            a = character4:FindFirstChild("HumanoidRootPart")
        end
        local b = character4
        if character4 then
            b = character4:FindFirstChildOfClass("Humanoid")
        end
        local c = nil
        local tPSSystem = v30:FindFirstChild("TPSSystem")
        if tPSSystem then
            c = tPSSystem:FindFirstChild("TPS")
        end
        if not c then
            c = v30:FindFirstChild("TPS")
        end
        local d = a
        if a then
            d = c
        end
        if d then
            d = c:IsA("BasePart")
        end
        local e, position, position2, x, z
        if d then
            a.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            a.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            if b then
                b.PlatformStand = false
                b.Sit = false
            end
            position = c.Position
            d = (a.Position - position).Unit
            if d.Magnitude == 0 then
                d = Vector3.new(1, 0, 0)
            end
            x = d.X
            z = d.Z
            e = c.Position + Vector3.new(x, 0, z).Unit * 2.5 + Vector3.new(0, 1.5, 0)
            position2 = c.Position
            a.CFrame = CFrame.new(e, position2)
            local k67_1 = {
                Title = "Tp Ball",
                Content = "Teleported right next to the ball safely!",
                Duration = 3,
            }
            v24:Notify(k67_1)
        else
            v24:Notify({
                Title = "Error",
                Content = "Ball could not be found!",
                Duration = 3,
            })
        end
    end
    pcall(tryOperation18)
end
local v31
local function CallbackHandler13(a)
    local function tryOperation17()
        local tPSSystem2 = v30:FindFirstChild("TPSSystem")
        local b = tPSSystem2
        if tPSSystem2 then
            b = tPSSystem2:FindFirstChild("TPS")
        end
        if not b then
            b = v30:FindFirstChild("TPS")
        end
        local c = b
        if b then
            c = b:IsA("BasePart")
        end
        if c then
            c = v3.Character
        end
        if c then
            c = v3.Character:FindFirstChild("HumanoidRootPart")
        end
        local position3
        if c then
            position3 = b.Position
            b.AssemblyLinearVelocity = (v3.Character.HumanoidRootPart.Position - position3).Unit * v31 + Vector3.new(0, 5, 0)
        end
    end
    v31 = a
    pcall(tryOperation17)
    return a
end
local function onHeartbeat()
    local character5
    local function tryOperation16()
        local head2 = character5:FindFirstChild("Head")
        local l = head2
        if head2 then
            l = head2.Transparency ~= 1
        end
        local m, n
        if l then
            head2.Transparency = 1
            l, m, n = ipairs(head2:GetChildren())
            for k, v in l, m, n do
                if v:IsA("Decal") and v.Transparency ~= 1 then
                    v.Transparency = 1
                end
            end
        end
    end
    local a, b, c, d, e, f
    local function findChild()
        local k
        local function tryOperation5()
            if sethiddenproperty then
                sethiddenproperty(k, "NetworkOwner", v3)
            end
        end
        local function runProtected(p)
            local function tryOperation3()
                firetouchinterest(p, k, 0)
                firetouchinterest(p, k, 1)
            end
            local function tryOperation4()
                local position5 = p.Position
                k.AssemblyLinearVelocity = (k.Position - position5).Unit * (50 + v22 * 2) + Vector3.new(0, 12, 0)
            end
            local magnitude, q, position4
            if p then
                position4 = k.Position
                magnitude = (p.Position - position4).Magnitude
                q = v22 * 1.8 / 2
                if magnitude <= q + 2 then
                    pcall(tryOperation3)
                    if magnitude <= q then
                        pcall(tryOperation4)
                    end
                    return p, magnitude, q
                end
            end
        end
        local function tryOperation6()
            firetouchinterest(b, k, 0)
            firetouchinterest(b, k, 1)
        end
        local function tryOperation7()
            firetouchinterest(a, k, 1)
        end
        local function tryOperation8()
            local position6 = b.Position
            k.AssemblyLinearVelocity = (k.Position - position6).Unit * (80 + v19 * 3) + Vector3.new(0, 15, 0)
        end
        local function tryOperation9()
            firetouchinterest(c, k, 0)
            firetouchinterest(c, k, 1)
        end
        local function tryOperation10()
            local position7 = a.Position
            k.AssemblyLinearVelocity = (k.Position - position7).Unit * (80 + v18 * 3) + Vector3.new(0, 15, 0)
        end
        local function tryOperation11()
            firetouchinterest(f, k, 0)
            firetouchinterest(f, k, 1)
        end
        local l
        local function tryOperation12()
            firetouchinterest(l, k, 0)
            firetouchinterest(l, k, 1)
        end
        local function tryOperation13()
            local position8 = c.Position
            k.AssemblyLinearVelocity = (k.Position - position8).Unit * (40 + v20 * 1.5) + Vector3.new(0, 10, 0)
        end
        local function tryOperation14()
            local position9 = f.Position
            k.AssemblyLinearVelocity = (k.Position - position9).Unit * (70 + v21 * 3) + Vector3.new(0, 12, 0)
        end
        local function tryOperation15()
            firetouchinterest(f, k, 0)
            firetouchinterest(f, k, 1)
        end
        l = "TPSSystem"
        k = v30
        local tPSSystem3 = v30:FindFirstChild("TPSSystem")
        k = tPSSystem3
        if k then
            l = tPSSystem3
            k = tPSSystem3:FindFirstChild("TPS")
        end
        l = k and pcall(k, "BasePart")
        local m, n, o
        if l then
            l = pcall
            pcall(tryOperation5)
            n = k.Position
            l = (a.Position - n).Magnitude
            m = v18 * 1.8
            if l <= m + 2 then
                pcall(a, k, 0)
                pcall(tryOperation7)
                if l <= m then
                    pcall(tryOperation10)
                end
                n = k.Position
                l = (b.Position - n).Magnitude
                pcall(tryOperation6)
                if l <= v19 * 1.8 then
                    pcall(tryOperation8)
                end
                n = k.Position
                l = (c.Position - n).Magnitude
                pcall(tryOperation9)
                if l <= v20 * 1.8 / 2 then
                    pcall(tryOperation13)
                end
                l = runProtected
                runProtected(d)
                l(e)
                if f then
                    o = k.Position
                    if (f.Position - o).Magnitude <= v22 * 2 + 2 then
                        pcall(tryOperation15)
                        n = k.Position
                        l = (f.Position - n).Magnitude
                        if l <= v21 * 2.2 + 2 then
                            pcall(tryOperation11)
                            pcall(tryOperation14)
                            l = f
                            pcall(tryOperation12)
                            return
                        end
                        l = f
                        pcall(tryOperation12)
                        return
                    end
                end
                n = k.Position
                l = (f.Position - n).Magnitude
                if l <= v21 * 2.2 + 2 then
                    pcall(tryOperation11)
                    pcall(tryOperation14)
                    l = f
                    o = k.Position
                    if (f.Position - o).Magnitude <= 3.2 then
                        pcall(tryOperation12)
                    end
                    return
                end
                l = f
                o = k.Position
                if (f.Position - o).Magnitude <= 3.2 then
                    pcall(tryOperation12)
                    return
                end
                return
            end
            n = k.Position
            l = (b.Position - n).Magnitude
            m = v19 * 1.8
            if l <= m + 2 then
                pcall(tryOperation6)
                if l <= m then
                    pcall(tryOperation8)
                end
                n = k.Position
                l = (c.Position - n).Magnitude
                pcall(tryOperation9)
                if l <= v20 * 1.8 / 2 then
                    pcall(tryOperation13)
                end
                l = runProtected
                runProtected(d)
                l(e)
                if f then
                    o = k.Position
                    if (f.Position - o).Magnitude <= v22 * 2 + 2 then
                        pcall(tryOperation15)
                        n = k.Position
                        l = (f.Position - n).Magnitude
                        if l <= v21 * 2.2 + 2 then
                            pcall(tryOperation11)
                            pcall(tryOperation14)
                            l = f
                            pcall(tryOperation12)
                            return
                        end
                        l = f
                        pcall(tryOperation12)
                        return
                    end
                end
                n = k.Position
                l = (f.Position - n).Magnitude
                if l <= v21 * 2.2 + 2 then
                    pcall(tryOperation11)
                    pcall(tryOperation14)
                    l = f
                    o = k.Position
                    if (f.Position - o).Magnitude <= 3.2 then
                        pcall(tryOperation12)
                    end
                    return
                end
                l = f
                o = k.Position
                if (f.Position - o).Magnitude <= 3.2 then
                    pcall(tryOperation12)
                    return
                end
                return
            end
            n = k.Position
            l = (c.Position - n).Magnitude
            m = v20 * 1.8 / 2
            if l <= m + 1 then
                pcall(tryOperation9)
                if l <= m then
                    pcall(tryOperation13)
                end
                l = runProtected
                runProtected(d)
                l(e)
                if f then
                    o = k.Position
                    if (f.Position - o).Magnitude <= v22 * 2 + 2 then
                        pcall(tryOperation15)
                        n = k.Position
                        l = (f.Position - n).Magnitude
                        if l <= v21 * 2.2 + 2 then
                            pcall(tryOperation11)
                            pcall(tryOperation14)
                            l = f
                            pcall(tryOperation12)
                            return
                        end
                        l = f
                        pcall(tryOperation12)
                        return
                    end
                end
                n = k.Position
                l = (f.Position - n).Magnitude
                if l <= v21 * 2.2 + 2 then
                    pcall(tryOperation11)
                    pcall(tryOperation14)
                    l = f
                    o = k.Position
                    if (f.Position - o).Magnitude <= 3.2 then
                        pcall(tryOperation12)
                    end
                    return
                end
                l = f
                o = k.Position
                if (f.Position - o).Magnitude <= 3.2 then
                    pcall(tryOperation12)
                    return
                end
                return
            end
            l = runProtected
            runProtected(d)
            l(e)
            if f then
                o = k.Position
                if (f.Position - o).Magnitude <= v22 * 2 + 2 then
                    pcall(tryOperation15)
                    n = k.Position
                    l = (f.Position - n).Magnitude
                    if l <= v21 * 2.2 + 2 then
                        pcall(tryOperation11)
                        pcall(tryOperation14)
                        l = f
                        pcall(tryOperation12)
                        return
                    end
                    l = f
                    pcall(tryOperation12)
                    return
                end
            end
            n = k.Position
            l = (f.Position - n).Magnitude
            if l <= v21 * 2.2 + 2 then
                pcall(tryOperation11)
                pcall(tryOperation14)
                l = f
                o = k.Position
                if (f.Position - o).Magnitude <= 3.2 then
                    pcall(tryOperation12)
                end
                return
            end
            l = f
            o = k.Position
            if (f.Position - o).Magnitude <= 3.2 then
                pcall(tryOperation12)
                return
            end
        end
    end
    character5 = v3.Character
    a = not character5
    local g, h, i, j
    if not a then
        c = "Left Leg"
        b = character5
        c = "LeftFoot"
        b = character5
        c = "LowerTorso"
        b = character5
        c = "Left Upper Leg"
        b = character5
        a = character5:FindFirstChild("Left Upper Leg")
        d = "Right Leg"
        c = character5
        b = character5:FindFirstChild("Right Leg")
        if not b then
            d = "RightFoot"
            c = character5
            b = character5:FindFirstChild("RightFoot")
        end
        if not b then
            d = "LowerTorso"
            c = character5
            b = character5:FindFirstChild("LowerTorso")
        end
        if not b then
            d = "Right Upper Leg"
            c = character5
            b = character5:FindFirstChild("Right Upper Leg")
        end
        e = "Head"
        d = character5
        c = character5:FindFirstChild("Head")
        f = "Left Arm"
        e = character5
        d = character5:FindFirstChild("Left Arm")
        if not d then
            f = "LeftHand"
            e = character5
            d = character5:FindFirstChild("LeftHand")
        end
        if not d then
            f = "Left Lower Arm"
            e = character5
            d = character5:FindFirstChild("Left Lower Arm")
        end
        if not d then
            f = "Left Upper Arm"
            e = character5
            d = character5:FindFirstChild("Left Upper Arm")
        end
        f = character5
        e = character5:FindFirstChild("Right Arm")
        if not e then
            f = character5
            e = character5:FindFirstChild("RightHand")
        end
        if not e then
            f = character5
            e = character5:FindFirstChild("Right Lower Arm")
        end
        if not e then
            f = character5
            e = character5:FindFirstChild("Right Upper Arm")
        end
        f = character5:FindFirstChild("HumanoidRootPart")
        if v17.ShowHitbox and a and b and c then
            g = v18 * 1.8 + 2
            h = v19 * 1.8 + 2
            i = v20 * 1.8 / 2 + 1
            j = v22 * 1.8 / 2 + 1
            v13.Size = Vector3.new(g, g, g)
            v14.Size = Vector3.new(h, h, h)
            v15.Size = Vector3.new(i, i, i)
            v16.Size = Vector3.new(j, j, j)
            v13.CFrame = a.CFrame
            v14.CFrame = b.CFrame
            v15.CFrame = c.CFrame
            if d then
                v16.CFrame = d.CFrame
            end
        else
            v13.Size = Vector3.new(0, 0, 0)
            v14.Size = Vector3.new(0, 0, 0)
            v15.Size = Vector3.new(0, 0, 0)
            v16.Size = Vector3.new(0, 0, 0)
        end
        if v6 then
            pcall(tryOperation16)
            v10(character5)
            pcall(character5)
        end
        pcall(findChild)
        return character5, a, b, c, d, e, f
    end
end
local v32, v33, v34, v35
local function onRenderStepped()
    local a, b
    local function tryOperation()
        local moveDirection = a.MoveDirection
        local d, unit, x2, z2
        if 0 < moveDirection.Magnitude then
            d = v25 / 100
            x2 = moveDirection.X
            z2 = moveDirection.Z
            unit = Vector3.new(x2, 0, z2).Unit
            if 0 < unit.Magnitude then
                b.CFrame = b.CFrame + unit * d
            end
        end
    end
    local function tryOperation2()
        a.AutoRotate = false
        a.CameraOffset = Vector3.new(1.75, 0, 0)
        local rotation = v33.CFrame.Rotation
        local toEulerAnglesYXZ = rotation.ToEulerAnglesYXZ
        local d = table.pack(toEulerAnglesYXZ(rotation))
        local e = b.Position
        b.CFrame = CFrame.new(e) * CFrame.Angles(0, d[2], 0)
        return rotation, table.unpack(d, 1, d.n)
    end
    local character6 = v3.Character
    a = not character6
    local c
    if not a then
        b = character6
        a = character6:FindFirstChildOfClass("Humanoid")
        b = character6:FindFirstChild("HumanoidRootPart")
        if v17.SpeedEnabled and a and b then
            pcall(tryOperation)
            pcall(tryOperation2)
            a.PlatformStand = true
            v34 = Instance.new("BodyVelocity")
            v34.MaxForce = Vector3.new(100000, 100000, 100000)
            v34.Parent = b
            v35 = Instance.new("BodyGyro")
            v35.MaxTorque = Vector3.new(100000, 100000, 100000)
            v35.P = 10000
            v35.Parent = b
            c = Vector3.new(0, 0, 0)
            if v32:IsKeyDown(Enum.KeyCode.W) then
                c = c + v33.CFrame.LookVector
            end
            if v32:IsKeyDown(Enum.KeyCode.S) then
                c = c - v33.CFrame.LookVector
            end
            if v32:IsKeyDown(Enum.KeyCode.A) then
                c = c - v33.CFrame.RightVector
            end
            if v32:IsKeyDown(Enum.KeyCode.D) then
                c = c + v33.CFrame.RightVector
            end
            if v32:IsKeyDown(Enum.KeyCode.Space) then
                c = c + Vector3.new(0, 1, 0)
            end
            if v32:IsKeyDown(Enum.KeyCode.LeftShift) or v32:IsKeyDown(Enum.KeyCode.LeftControl) then
                c = c - Vector3.new(0, 1, 0)
            end
            if 0 < a.MoveDirection.Magnitude then
                c = c + a.MoveDirection
            end
            v34.Velocity = c * 50
            v35.CFrame = v33.CFrame
            return character6, a, b
        else
            return
        end
    end
end
v24 = tryOperation33
local pack = table.pack(pcall(tryOperation33))
local v36 = not table.unpack(pack, 1, pack.n)
if not v36 then
    v24 = table.unpack(pack, 2, pack.n)
    v36 = not v24
end
local runService, v37, v38, createTab, createTab2, createTab3, createTab4, createTab5, createTab6, createTab7, createTab8, createTab9, v39
if v36 then
    v5 = "Rayfield UI yuklenemedi!"
    warn("Rayfield UI yuklenemedi!")
else
    v30 = {}
    x3.Name = "VURTAHUB | TPS Street Soccer"
    x3.LoadingTitle = "VURTAHUB Loading..."
    x3.LoadingSubtitle = "by VURTAHUB"
    local k0_1 = {Enabled = false, FolderName = "VurtaHubTPS", FileName = "Config"}
    x3.ConfigurationSaving = k0_1
    x3.KeySystem = true
    local v40 = {
        Title = "VURTAHUB | Key System",
        Subtitle = "Key Required",
        FileName = "VurtaHubKey",
        SaveKey = true,
        GrabKeyFromSite = false,
    }
    v3 = "VWNUYURDCTMNAUHCUB"
    local k0_3 = {[1] = "VWNUYURDCTMNAUHCUB"}
    v40.Key = k0_3
    v32 = v40
    v30.KeySettings = v40
    v24 = table.unpack(pack, 2, pack.n)
    v5 = v24
    v36 = v24:CreateWindow(v30)
    v32 = "Players"
    v30 = game
    v5 = game:GetService("Players")
    v32 = game
    v30 = game:GetService("Workspace")
    v32 = game:GetService("UserInputService")
    runService = game:GetService("RunService")
    v3 = "MarketplaceService"
    game:GetService("MarketplaceService")
    v33 = "Lighting"
    v3 = game
    game:GetService("Lighting")
    v3 = v5.LocalPlayer
    if not v3 then
        v1 = "LocalPlayer"
        v33 = v5
        v3 = v5:WaitForChild("LocalPlayer", 10)
    end
    v33 = not v3
    if v33 then
        v33 = v5.PlayerAdded
        v1 = v33
        v33 = v33.Wait(v1)
        v3 = v33
    end
    v33 = v30.CurrentCamera
    v13 = v30
    v1 = Instance.new("Folder", v30)
    v1.Name = "VurtaHubHitboxes"
    v37 = createPart
    v13 = createPart(table.unpack(pack, 15, pack.n))
    v14 = v37(table.unpack(pack, 16, pack.n))
    v15 = v37(table.unpack(pack, 17, pack.n))
    v16 = v37(table.unpack(pack, 18, pack.n))
    pcall(tryOperation34)
    v17 = tryOperation35
    pcall(tryOperation35)
    v38 = v32.TouchEnabled
    if v38 then
        v17 = v32.KeyboardEnabled
        v38 = not v17
    end
    if v38 then
        v38 = "Mobile"
    end
    if not v38 then
        v38 = "PC"
    end
    v17 = {
        Fly = false,
        SpeedEnabled = false,
        LeftReachEnabled = false,
        RightReachEnabled = false,
        HeadReachEnabled = false,
        ArmReachEnabled = false,
        BallReachEnabled = false,
        MobileLockEnabled = false,
        ShowHitbox = false,
    }
    v25 = 16
    v18 = 1
    v19 = 1
    v20 = 1
    v22 = 1
    v21 = 1
    v31 = 100
    v34 = nil
    v35 = nil
    v28 = false
    v4 = nil
    v29 = computeValue
    v6 = false
    v7 = runProtected2
    v8 = false
    v9 = false
    v10 = runProtected3
    v11 = runProtected4
    v12 = nil
    v3.CharacterAdded:Connect(onCharacterAdded)
    createTab = v36:CreateTab("Home", 4483362458)
    createTab2 = v36:CreateTab("Reach", 4483362458)
    createTab3 = v36:CreateTab("FFlags", 4483362458)
    createTab4 = v36:CreateTab("Hacks", 4483362458)
    createTab5 = v36:CreateTab("Avatar Stolen", 4483362458)
    createTab6 = v36:CreateTab("Mobile Lock", 4483362458)
    createTab7 = v36:CreateTab("React", 4483362458)
    v23 = 4483362458
    createTab8 = v36:CreateTab("Effect", 4483362458)
    v23 = "Optimization"
    v26 = 4483362458
    createTab9 = v36:CreateTab("Optimization", 4483362458)
    v26 = "Ball"
    v27 = 4483362458
    v23 = v36
    v39 = v36:CreateTab("Ball", 4483362458)
    v27 = "Player Information"
    v26 = createTab
    v23 = createTab.CreateSection
    v23(createTab, "Player Information")
    local k0_5 = {}
    v27 = k0_5
    k0_5.Title = "Details"
    k0_5.Content = "Welcome to VurtaHub Tps\nStreet Soccer Script!\n\nPlayer Name: " .. v3.Name .. "\nExecutor: " .. "Unknown Executor" .. "\nDevice: " .. v38 .. "\nAccess: Full Anti-Ban & Reach Active\nScript Owner: VURTAHUB"
    v26 = createTab
    v23 = createTab.CreateParagraph
    v23(createTab, k0_5)
    v27 = "Hitbox Visualizer"
    v26 = createTab2
    v23 = createTab2.CreateSection
    v23(createTab2, "Hitbox Visualizer")
    local v41 = {}
    v27 = v41
    v41.Name = "Show Reach Hitbox"
    v41.CurrentValue = false
    v41.Flag = "ShowHitbox"
    v41.Callback = CallbackHandler
    v26 = createTab2
    v23 = createTab2.CreateToggle
    v23(createTab2, v41)
    v27 = "Legs Reach Settings (1-10)"
    v26 = createTab2
    v23 = createTab2.CreateSection
    v23(createTab2, "Legs Reach Settings (1-10)")
    local k0_7 = {}
    v27 = k0_7
    k0_7.Name = "Left Reach"
    k0_7.CurrentValue = false
    k0_7.Flag = "LeftReach"
    k0_7.Callback = CallbackHandler2
    v26 = createTab2
    v23 = createTab2.CreateToggle
    v23(createTab2, k0_7)
    local v42 = {}
    v27 = v42
    v42.Name = "Left Reach Range"
    local k0_9 = {[1] = 1, [2] = 10}
    v42.Range = k0_9
    v42.Increment = 1
    v42.CurrentValue = 1
    v42.Flag = "LeftSize"
    v42.Callback = CallbackHandler3
    v26 = createTab2
    v23 = createTab2.CreateSlider
    v23(createTab2, v42)
    local v43 = {}
    v27 = v43
    v43.Name = "Right Reach"
    v43.CurrentValue = false
    v43.Flag = "RightReach"
    v43.Callback = CallbackHandler4
    v26 = createTab2
    v23 = createTab2.CreateToggle
    v23(createTab2, v43)
    local k0_11 = {}
    v27 = k0_11
    k0_11.Name = "Right Reach Range"
    k0_11.Range = {[1] = 1, [2] = 10}
    k0_11.Increment = 1
    k0_11.CurrentValue = 1
    k0_11.Flag = "RightSize"
    k0_11.Callback = CallbackHandler5
    v26 = createTab2
    v23 = createTab2.CreateSlider
    v23(createTab2, k0_11)
    v27 = "Head Reach Settings (1-10)"
    v26 = createTab2
    v23 = createTab2.CreateSection
    v23(createTab2, "Head Reach Settings (1-10)")
    local k0_13 = {}
    v27 = k0_13
    k0_13.Name = "Head Reach"
    k0_13.CurrentValue = false
    k0_13.Flag = "HeadReach"
    k0_13.Callback = CallbackHandler6
    v26 = createTab2
    v23 = createTab2.CreateToggle
    v23(createTab2, k0_13)
    local v44 = {}
    v27 = v44
    v44.Name = "Head Reach Range"
    local k0_15 = {[1] = 1, [2] = 10}
    v44.Range = k0_15
    v44.Increment = 1
    v44.CurrentValue = 1
    v44.Flag = "HeadSize"
    v44.Callback = CallbackHandler7
    v26 = createTab2
    v23 = createTab2.CreateSlider
    v23(createTab2, v44)
    v27 = "Ball Reach Settings (1-10)"
    v26 = createTab2
    v23 = createTab2.CreateSection
    v23(createTab2, "Ball Reach Settings (1-10)")
    local v45 = {}
    v27 = v45
    v45.Name = "Ball Reach"
    v45.CurrentValue = false
    v45.Flag = "BallReach"
    v45.Callback = CallbackHandler8
    v26 = createTab2
    v23 = createTab2.CreateToggle
    v23(createTab2, v45)
    local k0_17 = {}
    v27 = k0_17
    k0_17.Name = "Ball Reach Range"
    k0_17.Range = {[1] = 1, [2] = 10}
    k0_17.Increment = 1
    k0_17.CurrentValue = 1
    k0_17.Flag = "BallSize"
    k0_17.Callback = CallbackHandler9
    v26 = createTab2
    v23 = createTab2.CreateSlider
    v23(createTab2, k0_17)
    v27 = "Arm Reach Settings (1-10)"
    v26 = createTab2
    v23 = createTab2.CreateSection
    v23(createTab2, "Arm Reach Settings (1-10)")
    local k0_19 = {}
    v27 = k0_19
    k0_19.Name = "Arm Reach"
    k0_19.CurrentValue = false
    k0_19.Flag = "ArmReach"
    k0_19.Callback = CallbackHandler10
    v26 = createTab2
    v23 = createTab2.CreateToggle
    v23(createTab2, k0_19)
    local v46 = {}
    v27 = v46
    v46.Name = "Arm Reach Range"
    local k0_21 = {[1] = 1, [2] = 10}
    v46.Range = k0_21
    v46.Increment = 1
    v46.CurrentValue = 1
    v46.Flag = "ArmSize"
    v46.Callback = CallbackHandler11
    v26 = createTab2
    v23 = createTab2.CreateSlider
    v23(createTab2, v46)
    v27 = "FFlag Editor"
    v26 = createTab3
    v23 = createTab3.CreateSection
    v23(createTab3, "FFlag Editor")
    v23 = ""
    v27 = createTab3
    v26 = createTab3.CreateInput
    v26(createTab3, {
        Name = "FFlags (e.g. FintRenderShadowIntensity 0)",
        PlaceholderText = "Write one per line",
        RemoveTextAfterFocusLost = false,
        Callback = callback,
    })
    local k0_23 = {Name = "Apply FFlags", Callback = callback2}
    v27 = createTab3
    v26 = createTab3.CreateButton
    v26(createTab3, k0_23)
    v27 = createTab4
    v26 = createTab4.CreateSection
    v26(createTab4, "Movement Hacks")
    v27 = createTab4
    v26 = createTab4.CreateToggle
    v26(createTab4, {
        Name = "Fly Hack",
        CurrentValue = false,
        Flag = "FlyHack",
        Callback = callback3,
    })
    local k0_25 = {
        Name = "Speed Hack (CFrame)",
        CurrentValue = false,
        Flag = "SpeedHack",
        Callback = callback4,
    }
    v27 = createTab4
    v26 = createTab4.CreateToggle
    v26(createTab4, k0_25)
    local k0_27 = {[1] = 1, [2] = 100}
    x4.Range = k0_27
    x4.Increment = 1
    x4.CurrentValue = 20
    x4.Flag = "SpeedVal"
    x4.Callback = CallbackHandler12
    v27 = createTab4
    v26 = createTab4.CreateSlider
    v26(createTab4, {Name = "Speed Multiplier"})
    v27 = createTab5
    v26 = createTab5.CreateSection
    v26(createTab5, "Complete Asset Clone")
    v26 = ""
    v27 = createTab5.CreateInput
    v27(createTab5, {
        Name = "Target Username",
        PlaceholderText = "e.g. jandel",
        RemoveTextAfterFocusLost = false,
        Callback = callback5,
    })
    v27 = computeValue2
    local k0_29 = {Name = "Steal Avatar", Callback = callback6}
    createTab5:CreateButton(k0_29)
    createTab5:CreateSection("Custom Visuals (Headless & Korblox)")
    createTab5:CreateToggle({
        Name = "Fake Headless",
        CurrentValue = false,
        Flag = "FakeHeadlessToggle",
        Callback = callback7,
    })
    local k0_31 = {
        Name = "Fake Right Leg (Korblox)",
        CurrentValue = false,
        Flag = "FakeRightLegToggle",
        Callback = callback8,
    }
    createTab5:CreateToggle(k0_31)
    createTab5:CreateToggle({
        Name = "Fake Left Leg (Korblox)",
        CurrentValue = false,
        Flag = "FakeLeftLegToggle",
        Callback = callback9,
    })
    createTab6:CreateSection("Shift Lock")
    local k0_33 = {
        Name = "Mobile ShiftLock",
        CurrentValue = false,
        Flag = "MobileLock",
        Callback = callback10,
    }
    createTab6:CreateToggle(k0_33)
    createTab7:CreateSection("Ball Capture & Ghost Touch Fix")
    createTab7:CreateToggle({
        Name = "Best React",
        CurrentValue = false,
        Flag = "BestReact",
        Callback = callback11,
    })
    createTab8:CreateSection("Particle Effects")
    local k0_35 = {Name = "Blue", Callback = callback12}
    createTab8:CreateButton(k0_35)
    createTab8:CreateButton({Name = "Pink", Callback = callback13})
    local k0_37 = {Name = "Yellow", Callback = callback14}
    createTab8:CreateButton(k0_37)
    createTab8:CreateButton({Name = "Green", Callback = callback15})
    local k0_39 = {Name = "Black", Callback = callback16}
    createTab8:CreateButton(k0_39)
    createTab8:CreateButton({Name = "White", Callback = callback17})
    local k0_41 = {Name = "Purple", Callback = callback18}
    createTab8:CreateButton(k0_41)
    createTab8:CreateButton({Name = "Red", Callback = callback19})
    local k0_43 = {Name = "Grey", Callback = callback20}
    createTab8:CreateButton(k0_43)
    createTab8:CreateButton({Name = "Orange", Callback = callback21})
    local k0_45 = {Name = "Brown", Callback = callback22}
    createTab8:CreateButton(k0_45)
    createTab9:CreateSection("Performance & Boost")
    createTab9:CreateButton({Name = "Fps Boost", Callback = callback23})
    v39:CreateSection("Ball Utilities")
    local k0_47 = {Name = "Tp Ball", Callback = callback24}
    v39:CreateButton(k0_47)
    local k0_49 = {[1] = 1, [2] = 2000}
    x5.Range = k0_49
    x5.Increment = 10
    x5.CurrentValue = 100
    x5.Flag = "BallVelocityFlag"
    x5.Callback = CallbackHandler13
    v39:CreateSlider({Name = "Ball Velocity"})
    runService.Heartbeat:Connect(onHeartbeat)
    runService.RenderStepped:Connect(onRenderStepped)
end
