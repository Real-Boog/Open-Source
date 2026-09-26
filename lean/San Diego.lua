-- my deobfuscator sucks ass lmao

return ({
    Fa = function(b, _)
        return function(fOV)
            _[1][3].FOV = fOV
        end
    end,
    jb = function(b)
        return function(d)
            local e = 135
            local i, g, _, c, a, k, j
            repeat
                if e < 105 then
                    if e < 87 then
                        if e > 6 then
                            return c
                        else
                            c = k.Name
                            e = g <= j and 87 or e + 99
                        end
                    elseif e > 87 then
                        e, k = 210 - e, k(c, i)
                    else
                        k = d.Character
                        i = "Tool"
                        c, e, k = k, e + 15, k.FindFirstChildOfClass
                    end
                elseif e > 135 then
                    c = "Unarmed"
                    e = a < _ and 49 or 193 or 193
                elseif e > 108 then
                    k = d.Character
                    e = k and 87 or 108 or 108
                elseif e > 105 then
                    g = 181
                    c = k
                    j = 126
                    e = k and 6 or 105 or 105
                else
                    _ = 224
                    a = 46
                    e = c and 154 - e or 193 or 193
                end
            until false
        end
    end,
    Mb = function(b, h)
        return function(d)
            local e = 103
            local c, f, a
            while true do
                if e >= 119 then
                    if e > 119 then
                        e = 119
                        a = nil
                    else
                        f[c] = a
                        return
                    end
                else
                    a = d
                    f = h[1][3].teams
                    c = h[2][3]
                    e = a and 119 or 252 or 252
                end
            end
        end
    end,
    kc = function(b, _)
        return function(healthTextOutline)
            _[1][3].healthTextOutline = healthTextOutline
        end
    end,
    k = function(b, h)
        return function(d)
            local e = 110
            local c, f
            while true do
                if e >= 158 then
                    if e > 158 then
                        e = 45
                        f = pcall
                        c = b:Db({
                            h[2],
                            d,
                        })
                    end
                elseif e <= 45 then
                    e = e + 113
                    f(c)
                else
                    d = {[1] = 3, [3] = d}
                    d[2] = d
                    c = h[1][3]
                    c.shadows.tech = d[3]
                    c = c.shadows
                    f = c.enabled
                    e = f and 173 or 158 or 158
                end
            end
        end
    end,
    Cc = function(b, _)
        return function(d)
            local e = 43
            local c, f
            repeat
                if e <= 118 then
                    if e > 46 then
                        f()
                        return
                    elseif e <= 43 then
                        c = _[1][3]
                        f = c.Callback
                        e = f and 209 or 46 or 46
                    else
                        e = 118
                        f = _[2][3]
                    end
                elseif e <= 197 then
                    e = 9062 / e
                    f(c)
                else
                    e, c = 406 - e, _[1][3]
                    f, c = c.Callback, d
                end
            until false
        end
    end,
    g = function(b, _)
        return function(a)
            _[1][3].ambient.a = a
        end
    end,
    Xa = function(o, h)
        return function()
            local m = 59
            local f, a, _, j, q, p, d, i, l, n, k
            repeat
                if m >= 66 then
                    if m < 167 then
                        if m >= 102 then
                            if m > 102 then
                                j, a, _ = j(a)
                                j, a, _ = o.b(j, a, _)
                                f, d = j(a, _)
                                _ = f
                                m = f == nil and m + -104 or 225 or 225
                            else
                                m, h[5][3][i].enabled = 150, false
                                a = q
                                j = ipairs
                            end
                        else
                            n, k, p = n(k)
                            n, k, p = o.b(n, k, p)
                            i, q = n(k, p)
                            p = i
                            m = i == nil and 43 or 36 or 36
                        end
                    elseif m >= 225 then
                        if m <= 225 then
                            m = 39
                            l = h[4][3][d]
                            h[3][3][d] = l
                        else
                            m = 167
                            n()
                            k = h[2][3]
                            n = k.Unload
                        end
                    else
                        n()
                        n = pairs
                        i = {}
                        j = {}
                        j[1], j[2] = "Ambient", "OutdoorAmbient"
                        i.ambient = j
                        j = {}
                        j[1], j[2] = "ColorShift_Top", "ColorShift_Bottom"
                        i.colorShift = j
                        j = {}
                        m = 66
                        j[1] = "ClockTime"
                        i.time = j
                        j = {}
                        j[1], j[2], j[3] = "FogStart", "FogEnd", "FogColor"
                        i.fog = j
                        d = "EnvironmentSpecularScale"
                        j = {}
                        j[1], j[2], j[3], j[4] = "Brightness", "ExposureCompensation", "EnvironmentDiffuseScale", "EnvironmentSpecularScale"
                        i.light = j
                        _ = "ShadowSoftness"
                        a = "GlobalShadows"
                        j = {}
                        j[1], j[2] = "GlobalShadows", "ShadowSoftness"
                        q = j
                        i.shadows = j
                        k = i
                    end
                elseif m > 43 then
                    if m > 46 then
                        m = 235
                        k = h[1][3]
                        n = k.Destroy
                    else
                        i, q = n(k, p)
                        p = i
                        m = i == nil and 43 or 82 - m
                    end
                elseif m < 39 then
                    _ = h[5][3]
                    a = _[i]
                    j = a.enabled
                    m = j and 102 or 1656 / m
                elseif m <= 39 then
                    f, d = j(a, _)
                    _ = f
                    m = f == nil and m + 7 or 8775 / m
                else
                    return
                end
            until false
        end
    end,
    ya = function(b, _)
        return function(textSize)
            _[1][3].sharedSettings.textSize = textSize
        end
    end,
    Fd = function(a, b, c, d)
        a.Dd[d] = a.Oc(b, c)
        return a.Dd[d]
    end,
    Gc = function(b, h)
        return function(d)
            local e = 244
            local c, a, f
            while true do
                if e >= 229 then
                    if e > 229 then
                        f = h[1][3].teams
                        a = d
                        c = h[2][3]
                        e = a and 229 or 145 or 145
                    else
                        f[c] = a
                        return
                    end
                else
                    e, a = 33205 / e, nil
                end
            end
        end
    end,
    Pa = function(b, _)
        return function(neutralColor)
            _[1][3].sharedSettings.neutralColor = neutralColor
        end
    end,
    Bb = function(b, h)
        return function(d)
            local e = 243
            local _, i, g, c, f
            repeat
                if e <= 180 then
                    if e >= 73 then
                        if e > 73 then
                            f = f(c, i)
                            e = f and 73 or 14 or 14
                        else
                            e = 213
                            f = h[1][3]
                            c = d.Parent
                        end
                    else
                        return
                    end
                elseif e > 213 then
                    c = d
                    g = 14
                    e = 180
                    f = d.IsA
                    i = "Humanoid"
                    _ = 244
                else
                    f(c)
                    e = g < _ and e + -199 or e + -140
                end
            until false
        end
    end,
    wa = function(b, _)
        return function(softness)
            _[1][3].shadows.softness = softness
        end
    end,
    t = function(b, _)
        return function(d)
            local e = 97
            local c, f
            repeat
                if e > 97 then
                    f(c)
                    return
                else
                    c = d
                    e = 224
                    f = _[1][3].Apply
                end
            until false
        end
    end,
    Ta = function(b, _)
        return function(fOVColor)
            _[1][3].FOVColor = fOVColor
        end
    end,
    xb = function(b, h)
        return function(d)
            local e = 51
            local g, c, f, _, i
            while true do
                if e < 151 then
                    if e > 75 then
                        if e <= 81 then
                            return d, 1
                        else
                            g = 0
                            e = 17
                            _ = 1
                        end
                    elseif e <= 51 then
                        if e <= 17 then
                            c = b.c(c(i, g, _))
                            return f, b.d(c)
                        else
                            c = d
                            e = 235
                            f = typeof
                        end
                    else
                        return h[1][3], 1
                    end
                elseif e <= 184 then
                    if e < 166 then
                        f, e, c = type, 25066 / e, d
                    elseif e <= 166 then
                        f = f(c)
                        c = "table"
                        e = f == "table" and 234 or 75 or 75
                    else
                        e, i = e + -42, 1
                    end
                elseif e <= 234 then
                    f = d[1]
                    i = d[2]
                    c = math.clamp
                    e = i and 142 or 418 - e
                else
                    f = f(c)
                    c = "Color3"
                    e = f == "Color3" and e + -154 or e + -84
                end
            end
        end
    end,
    wb = function(o, h)
        return function(z, k, p, i, q)
            local v = 170
            local j, b, c, d, u, A, m, g, l, e, y, t, w, a, _, s, f, x, r
            while true do
                if v < 127 then
                    if v <= 60 then
                        if v >= 23 then
                            if v >= 42 then
                                if v <= 48 then
                                    if v > 42 then
                                        b = workspace
                                        d = {}
                                        e = z.model
                                        l = workspace.CurrentCamera
                                        d[1], d[2] = e, l
                                        f, d = d, _
                                        v = d and 5184 / v or 132 - v
                                    else
                                        _ = x.enabled
                                        a = not _
                                        v = a and 166 or 10710 / v
                                    end
                                else
                                    A = A(g, u, m)
                                    v, w.Transparency = 7020 / v, j - A
                                    j = 0
                                    t = _ > 0
                                    w.Visible = t
                                end
                            elseif v <= 29 then
                                if v <= 23 then
                                    f = f(d)
                                    v, h[3][3] = 4301 / v, f
                                    f = h[3][3]
                                    f.Name = "LeanNPCOverlayAnchor"
                                    e = 0.01
                                    d = Vector3.new
                                    l = 0.01
                                    b = 0.01
                                else
                                    e = workspace
                                    v = 158
                                    d = workspace.CurrentCamera
                                    h[3][3].Parent = d
                                    d = z.parts
                                    f = ipairs
                                end
                            else
                                return
                            end
                        elseif v <= 3 then
                            if v > 1 then
                                _ = _(f)
                                x = a[_]
                                a = not x
                                v = a and v + 193 or 45 - v
                            elseif v <= 0 then
                                t, w = "LeanNPCChams", t(j)
                                w.Name = "LeanNPCChams"
                                v, w.Adornee = v + 202, h[3][3]
                                w.AlwaysOnTop = true
                                w.ZIndex = 3
                                w.Parent = h[3][3]
                                t = z.adornments
                                t[l] = w
                            else
                                v, j = v + -1, Instance
                                t, j = j.new, "BoxHandleAdornment"
                            end
                        elseif v <= 4 then
                            v, _ = v + 196, x.occludedIntensity
                        else
                            v, f = 69 - v, a.Replicator
                            _ = f.LocalActor
                        end
                    elseif v <= 91 then
                        if v >= 82 then
                            if v > 84 then
                                v, d = v + -20, d(e, l, b, w)
                                l = nil
                                e = d == nil
                                z.clear = e
                            elseif v <= 82 then
                                v = 251
                                a = x.occludedColor
                            else
                                v = d and 154 or 16380 / v
                            end
                        elseif v <= 69 then
                            if v > 62 then
                                v = 62
                                t = a
                            else
                                w.Color3 = t
                                j = 1
                                g = _
                                v = 60
                                A = math.clamp
                                u = 0
                                m = 1
                            end
                        else
                            c = 211
                            a = z.clear
                            r = 39
                            v = a and 132 or 231 or 231
                        end
                    elseif v > 108 then
                        l, b = f(d, e)
                        e = l
                        v = l == nil and 36 or 224 or 224
                    elseif v <= 104 then
                        if v > 103 then
                            _ = x.visibleIntensity
                            v = y > s and 278 - v or 140 - v
                        else
                            v = 207
                            _ = a.Replicator
                        end
                    else
                        v = 84
                        d = _.Character
                    end
                elseif v < 195 then
                    if v <= 166 then
                        if v < 157 then
                            if v <= 132 then
                                if v > 127 then
                                    a = x.visibleColor
                                    v = c > r and 231 or 255 or 255
                                else
                                    a = a()
                                    _ = a
                                    v = a and 103 or 207 or 207
                                end
                            else
                                l = 1
                                e = _.Character
                                d = #f + 1
                                v, f[d] = 30030 / v, e
                            end
                        elseif v > 158 then
                            return
                        elseif v <= 157 then
                            f = 0.15
                            v, z.nextRay = v + -30, _() + 0.15
                            _ = h[1][3]
                            a = _.Service
                        else
                            f, d, e = f(d)
                            f, d, e = o.b(f, d, e)
                            l, b = f(d, e)
                            e = l
                            v = l == nil and 5688 / v or 35392 / v
                        end
                    elseif v > 187 then
                        if v > 191 then
                            v = 23
                            f = Instance.new
                            d = "Part"
                        else
                            w = z.adornments[l]
                            t = not w
                            v = t and 1 or v + 11
                        end
                    elseif v >= 174 then
                        if v <= 174 then
                            v = _ and v + 26 or 696 / v
                        else
                            f.Size = d(e, l, b)
                            e = CFrame
                            f.CFrame = CFrame.identity
                            f.Transparency = 1
                            f.Anchored = true
                            d = false
                            f.CanCollide = false
                            f.CanTouch = false
                            v, f.CanQuery = 29, false
                            f.CastShadow = false
                        end
                    else
                        s = 95
                        y = 221
                        v = 3
                        _ = h[1][3]
                        a = _.chams
                        f, _ = z.actor, _.Kind
                    end
                elseif v < 224 then
                    if v > 200 then
                        if v <= 202 then
                            w.Size = b.Size
                            j = b.CFrame
                            w.CFrame = j + p
                            t = q
                            v = q and v + -140 or 69 or 69
                        else
                            v = _ and 228 - v or 9936 / v
                        end
                    elseif v >= 196 then
                        if v > 196 then
                            d = h[3][3]
                            f = not d
                            v = f and 194 or 5800 / v
                        else
                            return
                        end
                    else
                        v, d = 17745 / v, h[2][3]
                        d.FilterDescendantsInstances = f
                        d = workspace
                        l = k.CFrame.Position
                        t = k.CFrame
                        b, w, d, e = i - t.Position, h[2][3], d.Raycast, d
                    end
                elseif v < 242 then
                    if v <= 231 then
                        if v <= 224 then
                            w = b.Parent
                            v = w and 42784 / v or 26208 / v
                        else
                            v = a and 251 or 82 or 82
                        end
                    else
                        a = a()
                        _ = z.nextRay
                        v = a >= _ and 242 or v + -164
                    end
                elseif v <= 251 then
                    if v > 242 then
                        _ = z.clear
                        v = _ and 26104 / v or 43674 / v
                    else
                        f = os
                        v = 157
                        _ = os.clock
                    end
                else
                    _ = os
                    v, a = 490 - v, os.clock
                end
            end
        end
    end,
    P = function(o)
        return function(z, B, p, i, q, x, J)
            local v = 57
            local k, n, qc, A, f, e, t, a, G, H, F, K, w, j, r, g, d, D, l, b, m, s, _, I, y, C
            while true do
                if v <= 157 then
                    if v < 85 then
                        if v < 50 then
                            if v <= 23 then
                                if v > 21 then
                                    m = n
                                    v = s >= a and 158 or 236 or 236
                                elseif v > 16 then
                                    G = t / 160
                                    r = 2
                                    K = qc
                                    v = 105
                                    g = 20 * G ^ 2
                                    m = g
                                elseif v > 11 then
                                    v = A > 0 and 238 or 250 or 250
                                else
                                    v = r > F and 186 - v or 181 - v
                                end
                            elseif v <= 24 then
                                v = _ and 150 or 158 or 158
                            else
                                b = g
                                w = K
                                v = D >= H and 225 - v or 85 or 85
                            end
                        elseif v <= 64 then
                            if v >= 63 then
                                if v > 63 then
                                    _ = {[1] = 3, [3] = _}
                                    _[2] = _
                                    C = J
                                    v = J and 293 - v or 9472 / v
                                else
                                    v = m and 10143 / v or 104 - v
                                end
                            elseif v <= 50 then
                                k = k(f)
                                f = 0
                                v = k > 0 and 73 - v or 67 or 67
                            else
                                y = 32
                                l = 135
                                i = {[1] = 3, [3] = i}
                                v, i[2] = 157, i
                                C = type
                                d = i[3]
                            end
                        elseif v <= 67 then
                            v, G = 303 - v, n
                        else
                            C = 0
                            v, _ = 1824 / v, i[3] <= 0
                        end
                    elseif v <= 142 then
                        if v >= 107 then
                            if v < 119 then
                                if v <= 107 then
                                    k, v, n = qc, 5350 / v, (m + G) * 0.5
                                    f = n
                                else
                                    v = A <= 0 and 372 - v or 21 or 21
                                end
                            elseif v > 119 then
                                v = A <= 0 and 320 - v or 235 or 235
                            else
                                v = I <= 0 and 190 or v + -12
                            end
                        elseif v < 91 then
                            t = t + A
                            v = A > 0 and 337 - v or v + 57
                        elseif v > 91 then
                            K = K(m)
                            G = 0
                            m = w >= 0
                            v = m and 234 or 6615 / v
                        else
                            v = 107
                        end
                    elseif v < 152 then
                        if v > 148 then
                            return B, 0
                        else
                            D = 65
                            H = 94
                            v = C and 184 or 152 or 152
                        end
                    elseif v >= 154 then
                        if v <= 154 then
                            C = Vector3
                            v = 64
                            _ = Vector3.zero
                        else
                            C = C(d)
                            d = "number"
                            _ = C ~= "number"
                            v = _ and 181 - v or 76 or 76
                        end
                    else
                        v = 184
                        C = 0
                    end
                elseif v <= 229 then
                    if v <= 178 then
                        if v > 170 then
                            if v > 175 then
                                v = t < j and 159 or 235 or 235
                            elseif v <= 171 then
                                v = v + -52
                            else
                                I = 0.5
                                F = m + G
                                n = e[3]
                                r = F * 0.5
                                v = 203
                                k = r
                            end
                        elseif v > 161 then
                            v = I <= 0 and 384 - v or 15470 / v
                        elseif v > 159 then
                            r = 1
                            m = b
                            G = g
                            F = 20
                            s = 124
                            a = 239
                            I = 1
                            v = v + 82
                        elseif v <= 158 then
                            _ = x
                            v = x and 38078 / v or 246 or 246
                        else
                            return nil
                        end
                    elseif v >= 203 then
                        if v > 214 then
                            C = q
                            v = l >= y and 148 or 270 - v
                        elseif v > 203 then
                            v = r < F and 175 or 19474 / v
                        else
                            n = n(k)
                            return z + n, r
                        end
                    elseif v <= 184 then
                        C = {[1] = 3, [3] = C}
                        C[2] = C
                        d = {
                            [1] = 3,
                            [3] = B - z,
                        }
                        d[2] = d
                        e = {[1] = 3, [3] = e}
                        e[2] = e
                        e[3] = o:rc({d, _, C})
                        w = d[3].Magnitude
                        qc = o:qc({e, i})
                        b = 0
                        t = 1
                        j = 160
                        A = 1
                        v = v + -168
                    else
                        v = r < F and v + -15 or v + -83
                    end
                elseif v <= 243 then
                    if v > 238 then
                        if v <= 241 then
                            v = 246
                            _ = p
                        else
                            v = I > 0 and 59535 / v or 171 or 171
                        end
                    elseif v < 236 then
                        if v > 234 then
                            v = v + -214
                        else
                            G = 0
                            v, m = 14742 / v, K <= 0
                        end
                    elseif v > 236 then
                        v = t > j and 159 or 250 or 250
                    else
                        r = r + I
                        v = I > 0 and v + -225 or 40120 / v
                    end
                elseif v >= 250 then
                    if v > 252 then
                        v = t < j and 413 - v or 21 or 21
                    elseif v > 250 then
                        v = t > j and 40068 / v or 142 or 142
                    else
                        v = 29500 / v
                    end
                elseif v > 245 then
                    v = _ and 64 or 154 or 154
                else
                    v = r > F and v + -70 or 171 or 171
                end
            end
        end
    end,
    pa = function(b, h)
        return function()
            local m = 188
            local d, g, a, k, l, j, f, c, i
            repeat
                if m > 157 then
                    if m <= 212 then
                        if m <= 201 then
                            if m <= 168 then
                                if m > 163 then
                                    m = l < k and 17304 / m or 22344 / m
                                elseif m > 160 then
                                    i = h[1][3]
                                    c = i.service
                                    c, k = i.routeWrapper, c.TryShoot
                                    m, l = 33741 / m, k == c
                                else
                                    m = l > k and m + -57 or 154 or 154
                                end
                            elseif m > 188 then
                                i, g = l(k, c)
                                c = i
                                m = i == nil and 95 or 67 or 67
                            else
                                d = 131
                                f = 35
                                c = h[1][3]
                                k = c.active
                                l = not k
                                m = l and 249 or 116 or 116
                            end
                        elseif m >= 207 then
                            if m > 207 then
                                g = h[1][3]
                                i = g.hooks
                                c = -1
                                l = #i
                                k = 1
                                m = m + -159
                            else
                                m = l and 265 - m or 43884 / m
                            end
                        else
                            l = l + c
                            m = c > 0 and 32185 / m or m + -184
                        end
                    elseif m >= 237 then
                        if m > 249 then
                            l.contexts = k(c, i)
                            return
                        elseif m > 237 then
                            return
                        else
                            l(k)
                            k = setmetatable
                            l = h[1][3]
                            g, m, i, c = "k", m + 13, {}, {}
                            i.__mode = "k"
                        end
                    elseif m > 225 then
                        m = c <= 0 and 168 or 133 or 133
                    elseif m > 222 then
                        m = m + -92
                    else
                        m = 201
                        j(a)
                    end
                elseif m > 96 then
                    if m < 133 then
                        if m >= 116 then
                            if m > 116 then
                                l, k, c = l(k)
                                l, k, c = b.b(l, k, c)
                                i, g = l(k, c)
                                c = i
                                m = i == nil and 11305 / m or 186 - m
                            else
                                h[1][3].active = false
                                i = h[1][3]
                                l = ipairs
                                m = 119
                                k = i.connections
                            end
                        else
                            m = 237
                            l = table.clear
                            k = h[1][3].hooks
                        end
                    elseif m > 154 then
                        m = l > k and m + -54 or 178 - m
                    elseif m >= 139 then
                        if m <= 139 then
                            m = 205
                            i(g, j)
                        else
                            m = 228
                        end
                    else
                        a = h[1][3]
                        i = pcall
                        g = restorefunction
                        m = 139
                        j = a.hooks[l]
                    end
                elseif m >= 67 then
                    if m > 94 then
                        if m > 95 then
                            m, k = 186 - m, h[1][3]
                            l = k.circle
                            k, l = l, l.Remove
                        else
                            k = h[1][3]
                            l = k.circle
                            m = l and 96 or 46 or 46
                        end
                    elseif m >= 90 then
                        if m <= 90 then
                            l(k)
                            m = f <= d and 46 or 249 or 249
                        else
                            m = l < k and 9682 / m or 319 - m
                        end
                    else
                        m = 222
                        a = g
                        j = g.Disconnect
                    end
                elseif m >= 53 then
                    if m > 53 then
                        k = h[1][3]
                        l = k.service
                        c = k
                        k = k.route
                        m, l.TryShoot = 212, k
                    else
                        m = c > 0 and 160 or 207 - m
                    end
                elseif m > 21 then
                    k = h[1][3]
                    l = k.service
                    m = l and m + 117 or 207 or 207
                else
                    m = c <= 0 and 94 or 225 or 225
                end
            until false
        end
    end,
    ld = function(a, b, c, d)
        a.hd[d] = a.a(b, 2489) + c
        return a.hd[d]
    end,
    Mc = function(b, h)
        return function()
            local e = 68
            local f, c, d
            repeat
                if e > 123 then
                    f = f(c)
                    h[1][3] = f
                    return
                elseif e > 68 then
                    d = d(f, c)
                    e = 179
                    f = d.Network.ServerStatsItem["Data Ping"]
                    c, f = f, f.GetValue
                else
                    e = 123
                    c = "Stats"
                    d = game
                    f, d = d, d.GetService
                end
            until false
        end
    end,
    Jd = function(a, ...)
        a.Qc, a.Oc, a.Sc = "", "", a:Sc()
        return a:f()(...)
    end,
    Ed = function(a, b, c, d)
        a.Dd[d] = b - a.a(c, 3261)
        return a.Dd[d]
    end,
    Eb = function(b, _)
        return function()
            local e = 196
            local d, f
            repeat
                if e > 196 then
                    f, e, d = 0, 238 - e, _[1][3].Button
                    d.TextTransparency = 0
                elseif e > 12 then
                    d = not _[1][3].Active
                    e = d and 226 or 12 or 12
                else
                    return
                end
            until false
        end
    end,
    vc = function(o, h)
        return function(s, k)
            local v = 178
            local n, q, u, p, f, a, w, g, e, m, l, d, r, _, i, b
            repeat
                if v <= 111 then
                    if v < 48 then
                        if v < 32 then
                            if v > 26 then
                                l(b, w)
                                v = u < m and v + -3 or 74 or 74
                            elseif v >= 17 then
                                if v <= 17 then
                                    q = q(r)
                                    r = "EnumItem"
                                    v = q == "EnumItem" and 202 or 48 or 48
                                else
                                    d, e = a(_, f)
                                    f = d
                                    v = d == nil and 66 or 88 - v
                                end
                            else
                                b = q[e]
                                v = 74
                                l = not b
                            end
                        elseif v < 37 then
                            if v > 32 then
                                v = 73
                                d = "Hold"
                            else
                                v, i = 176 - v, "MB1"
                            end
                        elseif v > 37 then
                            r, a, _ = r(o.d(a))
                            r, a, _ = o.b(r, a, _)
                            f, d = r(a, _)
                            _ = f
                            v = f == nil and 252 or 245 or 245
                        else
                            l = l(b, w)
                            v = l and 148 / v or v + 37
                        end
                    elseif v > 73 then
                        if v <= 84 then
                            if v > 74 then
                                v = 144
                                i = "Q"
                            else
                                v = l and 250 - v or 26 or 26
                            end
                        else
                            f, d = r(a, _)
                            _ = f
                            v = f == nil and 252 or 245 or 245
                        end
                    elseif v >= 62 then
                        if v > 66 then
                            f.Mode, m, u = d, 175, 31
                            v, w, e, l, b = 299 - v, "Toggle", {}, "Always", "Hold"
                            e[1], e[2], e[3] = "Always", "Hold", "Toggle"
                            f.Modes = e
                            f.SyncToggleState = false
                            d = k.Callback
                            f.Callback = d
                            r = p.AddKeyPicker
                            a = p
                        elseif v > 62 then
                            v = 241
                            a = {
                                [1] = 3,
                                [3] = r.Update,
                            }
                            a[2] = a
                            r.Update = o:Bc({
                                a,
                                h[4],
                            })
                            _ = h[4][3]
                        else
                            v, w, l, b = 2294 / v, "TextLabel", e.IsA, e
                        end
                    elseif v <= 48 then
                        q = "MouseButton2"
                        v = i == "MouseButton2" and 84 or 198 or 198
                    else
                        q = typeof
                        i = k.Default
                        v, r = v + -38, i
                    end
                elseif v < 202 then
                    if v <= 176 then
                        if v > 173 then
                            v = 29
                            l = table.insert
                            w = {}
                            b = h[6][3]
                            w.picker = r
                            w.label = e
                            w.toggle = h[1][3]
                        elseif v < 152 then
                            q = {}
                            v = 227
                            r = ipairs
                            a = h[5][3].KeybindContainer
                            a, _ = a.GetChildren, a
                        elseif v > 152 then
                            v, p = 9515 / v, p(i, q)
                        else
                            a, _, f = a(o.d(_))
                            a, _, f = o.b(a, _, f)
                            d, e = a(_, f)
                            f = d
                            v = d == nil and 66 or 214 - v
                        end
                    elseif v <= 178 then
                        if v > 177 then
                            g = 251
                            n = 174
                            p = h[1][3]
                            v = p and 55 or 222 or 222
                        else
                            v, _ = v + -25, o.c(_(f))
                        end
                    else
                        q = "MouseButton1"
                        v = i == "MouseButton1" and 32 or 28512 / v
                    end
                elseif v < 227 then
                    if v > 222 then
                        r(a, _, f)
                        r = h[3][3][k.Flag]
                        v = 177
                        a = ipairs
                        _ = h[5][3].KeybindContainer
                        _, f = _.GetChildren, _
                    elseif v > 202 then
                        p = h[2][3]
                        v = 173
                        q = k.Text
                        p, i = p.AddLabel, p
                    else
                        i = i.Name
                        v = n >= g and 74 or v + -154
                    end
                elseif v <= 245 then
                    if v <= 241 then
                        if v <= 227 then
                            v, a = 9307 / v, o.c(a(_))
                        else
                            _()
                            return r
                        end
                    else
                        e = true
                        v, q[d] = 27195 / v, true
                    end
                else
                    f = {}
                    _ = k.Flag
                    f.Text = k.Text
                    f.Default = i
                    d = k.Mode
                    v = d and v + -179 or 8820 / v
                end
            until false
        end
    end,
    Tb = function(b, _)
        return function(tracer)
            _[1][3].tracer = tracer
        end
    end,
    Cd = function(a, b, c, d)
        a.md[d] = b + c
        return a.md[d]
    end,
    hc = function(b, _)
        return function(kind)
            local e = 217
            local f
            repeat
                if e >= 217 then
                    _[1][3].kind = kind
                    e = 177
                    f = _[2][3]
                else
                    f()
                    return
                end
            until false
        end
    end,
    D = function(b, _)
        return function(limitDistance)
            _[1][3].sharedSettings.limitDistance = limitDistance
        end
    end,
    a = bit32.bxor,
    bc = function(b, h)
        return function()
            local e = 46
            local d, a, c, f
            while true do
                if e < 207 then
                    if e > 46 then
                        d.box3d = f
                        return
                    else
                        d = h[1][3]
                        f = h[2][3].enabled
                        e = f and 207 or 250 or 250
                    end
                elseif e > 224 then
                    d.box = f
                    d = h[1][3]
                    f = h[2][3].enabled
                    e = f and 224 or 119 or 119
                elseif e <= 207 then
                    e, a = 457 - e, h[2][3]
                    a, c = "2D", a.kind
                    f = c == "2D"
                else
                    e = 119
                    f = h[2][3].kind == "3D"
                end
            end
        end
    end,
    zd = function(a, b, c, d)
        a.yd[d] = b - c
        return a.yd[d]
    end,
    db = function(b, h)
        return function(l, k, c, i)
            local e = 101
            local g, a, f, j, _
            repeat
                if e <= 147 then
                    if e <= 101 then
                        if e > 57 then
                            j = l.drawings
                            g = j[k]
                            e = g and 195 or 57 or 57
                        else
                            g, f, j, e, a, _ = h[1][3], i, l, 8379 / e, k, c
                        end
                    else
                        e, g = 195, g(j, a, _, f)
                    end
                else
                    return g
                end
            until false
        end
    end,
    td = function(a, b, c, d)
        a.md[d] = b / c
        return a.md[d]
    end,
    zc = function(b, h)
        return function(d)
            local e = 12
            local i, g, f, c
            while true do
                if e <= 144 then
                    if e > 59 then
                        e = 25
                        i = 1 - h[2][3].Transparency
                    elseif e <= 25 then
                        if e <= 12 then
                            c = h[1][3]
                            g, c, f = h[1][3], d, c.Callback
                            i, g = g.Transparency, nil
                            i = i ~= nil
                            e = i and 144 or 25 or 25
                        else
                            e = i and 59 or 238 or 238
                        end
                    else
                        e = 234 - e
                    end
                elseif e > 175 then
                    e = 59
                    i = nil
                else
                    f(c, i)
                    return
                end
            end
        end
    end,
    Ic = function(o, h)
        return function(n, k, ...)
            local m = 202
            local f, p, g, e, _, j, d, b, i, c2
            while true do
                if m >= 177 then
                    if m <= 226 then
                        if m >= 197 then
                            if m <= 202 then
                                if m <= 197 then
                                    i = o.c(i(g, j, o.d(c2)))
                                    return o.d(i)
                                else
                                    b = 16
                                    i = h[1][3].contexts
                                    j = coroutine
                                    m = 95
                                    g = coroutine.running
                                end
                            else
                                d = d(e)
                                m, e = 417 - m, "table"
                                f = d == "table"
                            end
                        elseif m >= 186 then
                            if m <= 186 then
                                m = 22
                                d = k[c2]
                                f = table.clone
                            else
                                m = f and 186 or 47559 / m
                            end
                        else
                            j = 0
                            g = #p.projectiles
                            i = g > 0
                            m = b >= 0 and 101 or m + 63
                        end
                    elseif m >= 242 then
                        if m <= 242 then
                            m, g = 141, g(j)
                            j = "table"
                            i = g == "table"
                        else
                            c2, _ = i(g, j)
                            j = c2
                            m = c2 == nil and 55 or 0 or 0
                        end
                    elseif m <= 234 then
                        i, g, j = i(g)
                        i, g, j = o.b(i, g, j)
                        c2, _ = i(g, j)
                        j = c2
                        m = c2 == nil and 55 or 0 or 0
                    else
                        j = k
                        m = 242
                        g = type
                    end
                elseif m < 95 then
                    if m < 55 then
                        if m > 0 then
                            m, f = 5478 / m, f(d)
                            k[c2] = f
                            f = k[c2]
                            d = _.direction
                            f.Direction = d
                        else
                            f = _.direction
                            m = f and 143 - m or 191 or 191
                        end
                    elseif m <= 55 then
                        i = h[2][3]
                        m = 197
                        c2 = o.c(...)
                        j = k
                        g = n
                    else
                        m, g, i = 10488 / m, k, table.clone
                    end
                elseif m < 138 then
                    if m > 95 then
                        m = i and 240 or m + 40
                    else
                        g = g()
                        p = i[g]
                        i = p
                        m = p and 16815 / m or 101 or 101
                    end
                elseif m >= 141 then
                    if m <= 141 then
                        m = i and 76 or m + -86
                    else
                        e = k[c2]
                        m = 226
                        d = type
                    end
                else
                    m, k, i, g = m + 96, i(g), ipairs, p.projectiles
                end
            end
        end
    end,
    rc = function(b, h)
        return function(n)
            local g = h[2][3] * n
            local j = 0.5 * h[3][3] * n * n
            return h[1][3] + g + Vector3.yAxis * j
        end
    end,
    lb = function(b, h)
        return function()
            local e = 40
            local a, d, bb, f, c
            repeat
                if e >= 188 then
                    if e > 212 then
                        d(f)
                        e = 188
                        d = h[4][3].RenderStepped
                        c = b:Ab({
                            h[1],
                        })
                        f, d = d, d.Connect
                    elseif e <= 193 then
                        if e <= 188 then
                            d = d(f, c)
                            h[3][3] = d
                            return
                        else
                            h[1][3]._hasLoaded = true
                            e, f = e + -107, table
                            f, a, d = h[2][3], workspace, f.insert
                            bb = b:Bb({
                                h[5],
                            })
                            c = a.DescendantAdded
                            a, c = c, c.Connect
                        end
                    else
                        d(f, b.d(c))
                        d, e, f = task.spawn, 326 - e, b:Cb({
                            h[1],
                            h[5],
                        })
                    end
                elseif e < 86 then
                    if e <= 40 then
                        f = h[1][3]
                        d = f._hasLoaded
                        e = d and 77 or 193 or 193
                    else
                        return
                    end
                elseif e > 86 then
                    e = 235
                    d(f)
                    f = true
                    d = h[1][3].Sync
                else
                    e, c = 212, b.c(c(a, bb))
                end
            until false
        end
    end,
    gb = function(b, h)
        return function(l)
            local e = 3
            local g, _, f, i, c, k, j
            repeat
                if e >= 143 then
                    if e >= 196 then
                        if e < 245 then
                            if e >= 224 then
                                if e <= 224 then
                                    e = i and 245 or 31 or 31
                                else
                                    k = k()
                                    c = k
                                    e = k and 433 - e or e + -59
                                end
                            else
                                e = 178
                                c = k.Replicator
                            end
                        elseif e <= 252 then
                            if e <= 245 then
                                j = l.Character
                                e = 187
                                g = typeof
                            else
                                e = i and 82 or 441 - e
                            end
                        else
                            e = 86
                            j = nil
                            g = l.Owner
                            i = g == nil
                        end
                    elseif e <= 180 then
                        if e >= 178 then
                            if e > 178 then
                                e = 252
                                i = c
                            else
                                e = c and 18 or 236 - e
                            end
                        elseif e > 143 then
                            g = g(j)
                            j = "table"
                            i = g == "table"
                            e = i and 180 or e + 76
                        else
                            e = i and e + 110 or 12298 / e
                        end
                    elseif e > 187 then
                        e = i and 30 or 332 - e
                    else
                        g = g(j)
                        e, j = 218 - e, "Instance"
                        i = g == "Instance"
                    end
                elseif e > 31 then
                    if e >= 82 then
                        if e < 86 then
                            i = l.UID
                            e = _ <= f and 189 or 85 - e
                        elseif e <= 86 then
                            e = i and 111 or e + 138
                        else
                            j = true
                            e = 224
                            g = l.IsLocalPlayer
                            i = g ~= true
                        end
                    elseif e <= 58 then
                        e = 176
                        g = type
                        j = l
                    else
                        j = "Model"
                        i = l.Character
                        g, e, i = i, 24, i.IsA
                    end
                elseif e >= 24 then
                    if e <= 30 then
                        if e > 24 then
                            j = l.UID
                            g = c[j]
                            e, i = 173 - e, g == l
                        else
                            e, i = 36 - e, i(g, j)
                        end
                    else
                        e = i and 96 - e or 43 - e
                    end
                elseif e <= 12 then
                    if e <= 3 then
                        e = 237
                        _ = 39
                        f = 250
                        c = h[1][3]
                        k = c.Service
                    else
                        return i
                    end
                else
                    i = k.Replicator
                    e = 58
                    c = i.Actors
                end
            until false
        end
    end,
    tc = function(o, h)
        return function(n, k)
            local m = 75
            local _, b, a, g, p, i, l, j
            repeat
                if m >= 117 then
                    if m > 154 then
                        if m > 223 then
                            m = _ and 151 or 335 - m
                        else
                            m, _ = 449 - m, 1 - k[3].Transparency
                        end
                    elseif m > 152 then
                        m = 32
                        a = o:zc({k, i})
                        j = i[3]
                        g = i[3].OnChanged
                    elseif m >= 151 then
                        if m <= 151 then
                            a.Transparency, b, l = _, 187, 196
                            g = p
                            m = 107
                            i = p.AddColorPicker
                        else
                            g, m, p = k[3].Text, 196 - m, h[2][3]
                            p, i = p.AddLabel, p
                        end
                    else
                        a = {}
                        j = k[3].Flag
                        a.Title = k[3].Text
                        a.Default = k[3].Default
                        _ = k[3].Transparency ~= nil
                        m = _ and 223 or m + 109
                    end
                elseif m <= 91 then
                    if m > 75 then
                        g = o:Ac()
                        i[3].SetVisible = g
                        return i[3]
                    elseif m <= 44 then
                        if m > 32 then
                            m, p = 161 - m, p(i, g)
                        else
                            g(j, a)
                            m = l <= b and 152 or 91 or 91
                        end
                    else
                        k = {[1] = 3, [3] = k}
                        k[2] = k
                        p = h[1][3]
                        m = p and 117 or 152 or 152
                    end
                elseif m > 107 then
                    m, _ = 260 - m, nil
                else
                    i(g, j, a)
                    j = k[3].Flag
                    i = {
                        [1] = 3,
                        [3] = h[3][3][j],
                    }
                    i[2] = i
                    g = k[3].Callback
                    m = g and 154 or m + -16
                end
            until false
        end
    end,
    id = function(a, b, c, d)
        a.hd[d] = a.Oc(b, c)
        return a.hd[d]
    end,
    ob = function(b, h)
        return function(n)
            local m = 136
            local _, a, c, f, i, g, j, k
            while true do
                if m < 106 then
                    if m >= 55 then
                        if m <= 82 then
                            if m < 79 then
                                if m <= 55 then
                                    a = a(_)
                                    _ = "BrickColor"
                                    m = a == "BrickColor" and 5 or 222 - m
                                else
                                    return j.Color
                                end
                            elseif m > 79 then
                                k = k(c)
                                m = k and 171 or 45 or 45
                            else
                                m, a = 176 - m, a(_, f)
                            end
                        elseif m < 97 then
                            return j.TeamColor.Color
                        elseif m > 97 then
                            f = n.Faction
                            j = n.TeamColor
                            a = n.FactionColor
                            k = pairs
                            _ = n.Team
                            m = 178
                            g = {}
                            g[1], g[2], g[3], g[4], g[5] = j, a, _, f, n.Company
                            c = g
                        else
                            m = a and 84 or 44 or 44
                        end
                    elseif m < 22 then
                        if m >= 5 then
                            if m > 5 then
                                a = a(_)
                                _ = "Color3"
                                m = a == "Color3" and m + 58 or 106 or 106
                            else
                                return j.Color
                            end
                        else
                            a = a(_)
                            _ = "Color3"
                            m = a == "Color3" and 484 / m or 164 / m
                        end
                    elseif m <= 44 then
                        if m > 41 then
                            _, m, a = j, 9108 / m, type
                        elseif m > 22 then
                            m = 55
                            _ = j
                            a = typeof
                        else
                            a, m, _ = typeof, 26 - m, j
                        end
                    else
                        m = k and 116 or 4590 / m
                    end
                elseif m > 171 then
                    if m < 207 then
                        if m < 188 then
                            k, c, i = k(c)
                            k, c, i = b.b(k, c, i)
                            g, j = k(c, i)
                            i = g
                            m = g == nil and 197 or 22 or 22
                        elseif m > 188 then
                            return h[1][3].sharedSettings.neutralColor
                        else
                            g, j = k(c, i)
                            i = g
                            m = g == nil and m + 9 or m + -166
                        end
                    elseif m >= 213 then
                        if m > 213 then
                            m, _, a, f = m + -155, j, j.IsA, "Team"
                        else
                            _ = _(f)
                            f = "Instance"
                            a = _ == "Instance"
                            m = a and 234 or 97 or 97
                        end
                    elseif m <= 207 then
                        a = a(_)
                        _ = "table"
                        m = a == "table" and m + 5 or 188 or 188
                    else
                        m, a, _ = m + -194, typeof, j.Color
                    end
                elseif m > 145 then
                    if m >= 167 then
                        if m > 167 then
                            c = n.Owner
                            m = 45
                            k = c.Team
                        else
                            f = j
                            m = 213
                            _ = typeof
                        end
                    else
                        a = a(_)
                        _ = "BrickColor"
                        m = a == "BrickColor" and 145 or 188 or 188
                    end
                elseif m > 121 then
                    if m > 136 then
                        return j.TeamColor.Color
                    else
                        m = 82
                        c = n
                        k = h[1][3].IsPlayer
                    end
                elseif m > 116 then
                    return j
                elseif m > 106 then
                    return n.Owner.Team.TeamColor.Color
                else
                    _, m, a = j.TeamColor, 16748 / m, typeof
                end
            end
        end
    end,
    u = function(b, _)
        return function(b)
            _[1][3].ambient.b = b
        end
    end,
    pb = function(o, h)
        return function(n)
            local m = 252
            local e, g, f, _, d, i, p, k, j, l, b
            while true do
                if m > 112 then
                    if m <= 210 then
                        if m <= 141 then
                            if m >= 125 then
                                if m >= 131 then
                                    if m > 131 then
                                        j = n.Character
                                        m = 47
                                        g = typeof
                                    else
                                        b = 185
                                        l = 83
                                        m = i and 141 or 244 - m
                                    end
                                else
                                    m, i = m + -125, p
                                end
                            elseif m <= 113 then
                                m = i and 190 - m or 226 or 226
                            else
                                g = g(j)
                                j = "table"
                                i = g == "table"
                                m = i and 125 or 0 or 0
                            end
                        elseif m <= 192 then
                            if m < 159 then
                                _, g, m, j, d, e, f = 184, type, 18972 / m, n, 63, 193, 59
                            elseif m > 159 then
                                m = p and 11 or 345 - m
                            else
                                k = k()
                                p = k
                                m = k and 168 - m or m + 33
                            end
                        else
                            m = i and 243 or 292 - m
                        end
                    elseif m >= 231 then
                        if m < 243 then
                            if m <= 231 then
                                g, m, j = n.Owner.Character, 15708 / m, n.Character
                                i = g == j
                            else
                                m = i and m + -198 or 30392 / m
                            end
                        elseif m <= 243 then
                            j = "Player"
                            i = n.Owner
                            i, m, g = i.IsA, 109, i
                        else
                            m = 159
                            p = h[1][3]
                            k = p.Service
                        end
                    elseif m > 225 then
                        return i
                    elseif m <= 215 then
                        g = g(j)
                        j = "Instance"
                        i = g == "Instance"
                        m = d < e and 210 or m + -134
                    else
                        m = 215
                        g = typeof
                        j = n.Owner
                    end
                elseif m < 47 then
                    if m <= 11 then
                        if m < 8 then
                            if m <= 0 then
                                m = i and m + 81 or 110 or 110
                            else
                                g, m, j = n.Owner, 1392 / m, h[3][3]
                                i = g ~= j
                            end
                        elseif m < 9 then
                            m = i and 225 or 210 or 210
                        elseif m <= 9 then
                            m, p = m + 183, k.Replicator
                        else
                            i = k.Replicator
                            m, p = 1683 / m, i.Actors
                        end
                    elseif m > 26 then
                        j = true
                        m = 131
                        g = n.IsLocalPlayer
                        i = g ~= true
                    elseif m > 15 then
                        m = i and 257 - m or 68 or 68
                    else
                        j = n.Owner
                        m, j, g = 26, h[2][3], j.Parent
                        i = g == j
                    end
                elseif m < 81 then
                    if m >= 76 then
                        if m <= 76 then
                            j = n.UID
                            m, g = 84 - m, p[j]
                            i = g == n
                        else
                            m = 112
                            i = n.Character
                            j = "Model"
                            i, g = i.IsA, i
                        end
                    elseif m > 47 then
                        m = i and m + -62 or 232 or 232
                    else
                        g = g(j)
                        j = "Instance"
                        i = g == "Instance"
                        m = l < b and 5311 / m or 231 or 231
                    end
                elseif m < 109 then
                    if m > 81 then
                        m = i and m + -67 or 2132 / m
                    else
                        i = n.UID
                        m = _ > f and 8910 / m or 77 or 77
                    end
                elseif m > 110 then
                    m, i = 338 - m, i(g, j)
                elseif m <= 109 then
                    m, i = 82, i(g, j)
                else
                    m = i and m + -34 or 8 or 8
                end
            end
        end
    end,
    nc = function(b, _)
        return function(distanceOutline)
            _[1][3].distanceOutline = distanceOutline
        end
    end,
    O = function(b, h)
        return function(d)
            local e = 169
            local g, f, a, c
            repeat
                if e > 169 then
                    f(c, a, g)
                    return
                else
                    a = d
                    g = nil
                    f = h[1][3]
                    e = 248
                    c = "Sub"
                end
            until false
        end
    end,
    vd = function(a, b, c, d)
        a.ud[d] = a.a(b, 51727) - c
        return a.ud[d]
    end,
    aa = function(b, h)
        return function(d)
            local e = 20
            local j, i, _, g, k, a, c
            while true do
                if e <= 166 then
                    if e > 106 then
                        return
                    elseif e <= 97 then
                        if e > 20 then
                            _, e, a, i, j = c, e + 9, tostring, h[2][3], "Font could not be loaded: "
                        else
                            k = pcall
                            e = 227
                            c = h[1][3].SetUI
                            i = d
                        end
                    else
                        a = a(_)
                        i, e, g, j = i.Notify, 320 - e, i, j .. a
                    end
                elseif e <= 214 then
                    e = 166
                    i(g, j)
                else
                    k, c = k(c, i)
                    i = not k
                    e = i and 324 - e or 166 or 166
                end
            end
        end
    end,
    ca = function(b, _)
        return function()
            local e = 197
            local f, d
            while true do
                if e >= 165 then
                    if e > 165 then
                        f = _[1][3]
                        d = f.Unloaded
                        e = d and 165 or 88 or 88
                    else
                        return
                    end
                elseif e > 80 then
                    e = 80
                    d = pcall
                    f = b:Fc({
                        _[2],
                        _[3],
                    })
                else
                    d(f)
                    return
                end
            end
        end
    end,
    oc = function(b, _)
        return function(tracerOrigin)
            _[1][3].tracerOrigin = tracerOrigin
        end
    end,
    Ab = function(b, _)
        return function()
            local e = 241
            local d
            while true do
                if e >= 241 then
                    e = 101
                    d = _[1][3].Render
                else
                    d()
                    return
                end
            end
        end
    end,
    Sc = function(b)
        local gsub = string.gsub
        local d = {
            [1] = 3,
            [3] = string.char,
        }
        d[2] = d
        gsub = {[1] = 3, [3] = gsub}
        gsub[2] = gsub
        local band = bit32.band
        local c = {
            [1] = 3,
            [3] = bit32.rshift,
        }
        c[2] = c
        band = {[1] = 3, [3] = band}
        band[2] = band
        return b:Tc({gsub, d, band, c})
    end,
    Ec = function(b, h)
        return function()
            local e = 233
            local g, d, f, j, i, c
            while true do
                if e > 127 then
                    i = h[2][3]
                    d = h[1][3]
                    j, i, c = h[2][3], {}, i.Flag
                    i.Text = j.Text
                    i.Values = j.Options
                    i.Default = j.Default
                    g = j.Multi
                    e = g and 35 or 127 or 127
                elseif e >= 112 then
                    if e <= 112 then
                        d = b.c(d(f, c, i))
                        return b.d(d)
                    else
                        e = 35
                        g = false
                    end
                else
                    e, i.Multi = 3920 / e, g
                    d, f = d.AddDropdown, d
                end
            end
        end
    end,
    ic = function(b, _)
        return function(offScreenArrowSize)
            _[1][3].offScreenArrowSize = offScreenArrowSize
        end
    end,
    z = function(o)
        return function(name)
            local m = 134
            local a, d, q, _, k, e, c, g, p, i, f, l, r
            repeat
                if m >= 134 then
                    if m < 203 then
                        if m > 134 then
                            a, _ = i(q, r)
                            r = a
                            m = a == nil and 240 - m or 429 - m
                        else
                            g = 62
                            k = filtergc
                            q = {}
                            c = 240
                            p = "function"
                            q.Name = name
                            r = true
                            m, q.IgnoreExecutor = 18, true
                            q, i = false, q
                        end
                    elseif m <= 207 then
                        if m > 203 then
                            i(q, r)
                            return p
                        else
                            i, q, r = i(q)
                            i, q, r = o.b(i, q, r)
                            a, _ = i(q, r)
                            r = a
                            m = a == nil and m + -159 or 233 or 233
                        end
                    else
                        m = 126
                        d = _
                        f = debug.getinfo
                    end
                elseif m <= 67 then
                    if m < 44 then
                        k = k(p, i, q)
                        p = nil
                        i = ipairs
                        m = 203
                        q = k
                    elseif m <= 44 then
                        i = assert
                        q = p
                        m, r = 251 - m, "GunController function not loaded: " .. name
                    else
                        d(e, l)
                        p = _
                        m = c <= g and 5092 / m or 196 or 196
                    end
                elseif m > 76 then
                    f = f(d)
                    e = "=ReplicatedStorage.ClientModules.GunController"
                    d = f.source
                    m = d == "=ReplicatedStorage.ClientModules.GunController" and 76 or 322 - m
                else
                    d = assert
                    e = not p
                    m = 67
                    l = "Ambiguous GunController function: " .. name
                end
            until false
        end
    end,
    x = function(b, _)
        return function(teamBasedColor)
            _[1][3].sharedSettings.teamBasedColor = teamBasedColor
        end
    end,
    fc = function(b, _)
        return function(healthBar)
            _[1][3].healthBar = healthBar
        end
    end,
    b = (function()
        local q, i, s = type, getmetatable, pairs
        return function(u, v, w)
            if q(u) ~= "function" then
                local p = i(u)
                if p ~= nil and p.__iter ~= nil then
                    return p.__iter(u)
                elseif (p and p.__call) == nil and q(u) == "table" then
                    return s(u)
                end
            end
            return u, v, w
        end
    end)(),
    kb = function(o, h)
        return function(s)
            local m = 103
            local _, c, k, f, q, r, t, b, e, n, l, i, a, p, d, j
            repeat
                if m < 128 then
                    if m <= 85 then
                        if m < 56 then
                            if m <= 46 then
                                if m > 29 then
                                    q = p.Replicator
                                    m = 47
                                    i = q.LocalActor
                                elseif m <= 5 then
                                    m = i and 46 or 47 or 47
                                else
                                    e = pcall
                                    m, c, t, l, b = 3016 / m, k, q, h[1][3].RenderActor, d
                                end
                            else
                                q = i
                                m = i and 123 or 118 - m
                            end
                        elseif m <= 71 then
                            if m < 57 then
                                m = 279 - m
                                b(c, t)
                            elseif m <= 57 then
                                c = d
                                m = 139
                                b = h[2][3]
                            else
                                m = q and 309 - m or 14910 / m
                            end
                        else
                            p = not k
                            m = p and 135 or 176 - m
                        end
                    elseif m >= 108 then
                        if not (m < 113 or m <= 113) then
                            m = 71
                            q = i.Position
                        end
                    elseif m < 103 then
                        m, i = m + 47, h[1][3]
                        p = i.Service
                    elseif m > 103 then
                        e, l = e(l, b, c, t)
                        b = not e
                        m = b and 5928 / m or 223 or 223
                    else
                        p = h[1][3]
                        k = p.Paused
                        m = k and 108 or 151 or 151
                    end
                elseif m <= 174 then
                    if m < 151 then
                        if m > 138 then
                            m = 24186 / m
                            b(c)
                            n = l
                            j = tostring
                            t = h[1][3].errors
                        elseif m >= 135 then
                            if m > 135 then
                                p = p()
                                i = p
                                m = p and 128 or 5 or 5
                            end
                        else
                            m, i = m + -123, p.Replicator
                        end
                    elseif m <= 163 then
                        if m <= 154 then
                            if m <= 151 then
                                p = h[1][3]
                                m = 235
                                k = p.Sync
                            else
                                p = workspace
                                m = 85
                                k = workspace.CurrentCamera
                            end
                        else
                            r, a, _ = r(a)
                            r, a, _ = o.b(r, a, _)
                            f, d = r(a, _)
                            _ = f
                            m = f == nil and 113 or 29 or 29
                        end
                    else
                        j = j(n)
                        c = t[j]
                        b = not c
                        m = b and m + 40 or m + 49
                    end
                elseif m >= 223 then
                    if m > 235 then
                        r = pairs
                        m, a = 38794 / m, h[1][3].objects
                    elseif m > 223 then
                        k()
                        k = s
                        m = s and 19975 / m or m + -81
                    else
                        f, d = r(a, _)
                        _ = f
                        m = f == nil and 25199 / m or 29 or 29
                    end
                elseif m < 210 then
                    c = c(t)
                    m, t = m + -142, true
                    b[c] = true
                    b = warn
                    t = l
                    c = "[NPC ESP]"
                elseif m > 210 then
                    m, c = 42372 / m, h[1][3]
                    c, t, b = tostring, l, c.errors
                else
                    m = 238
                    r = k.CFrame
                    q = r.Position
                end
            until false
        end
    end,
    Rc = function(o, h)
        return function(n, k)
            local i = 0
            local p = ""
            local q = #n - 1
            local a, f, d, _
            if 0 <= q then
                while true do
                    _ = h[2][3]
                    a = h[1][3]
                    f = h[3][3](n, i + 1)
                    d = h[3][3]
                    d = o.c(d(k, #k - i % #k))
                    _ = o.c(_(f, o.d(d)))
                    p = p .. a(o.d(_))
                    i = i + 1
                    if i > q then
                        break
                    end
                end
            end
            return p
        end
    end,
    X = function(b)
        return function()
        end
    end,
    Ra = function(b, _)
        return function(prediction)
            _[1][3].Prediction = prediction
        end
    end,
    Ca = function(b, _)
        return function(color)
            _[1][3].fog.color = color
        end
    end,
    ea = function(o, h)
        return function(n, k, c)
            local m = 252
            local i, l, e, j, f, g, d
            repeat
                if m >= 133 then
                    if m >= 210 then
                        if m >= 237 then
                            if m <= 237 then
                                return nil
                            else
                                e = 231
                                d = 79
                                f = 90
                                l = 140
                                j = h[1][3]
                                g = j.active
                                m = g and 142 or 25 or 25
                            end
                        else
                            return nil
                        end
                    elseif m >= 142 then
                        if m > 142 then
                            m, g = 7800 / m, c.allowed
                        else
                            j = h[2][3]
                            g = j.Enabled
                            m = f > d and 25 or 237 or 237
                        end
                    else
                        i = i(g, j)
                        g = not i
                        m = g and 27930 / m or 163 - m
                    end
                elseif m > 40 then
                    if m <= 55 then
                        m = g and 250 - m or 40 or 40
                    else
                        m, g = 211 - m, h[1][3]
                        i, g, j = g.Select, n, k
                    end
                elseif m < 30 then
                    if m > 5 then
                        m = g and 5 or 55 or 55
                    else
                        g = c
                        m = e >= l and 55 or 252 or 252
                    end
                elseif m <= 30 then
                    g = h[1][3]
                    g.target = i
                    g = g.diagnostics
                    g.redirected = g.redirected + 1
                    return (i.point - n).Unit
                else
                    i = not g
                    m = i and m + 197 or 78 or 78
                end
            until false
        end
    end,
    xd = function(a, b, c, d)
        a.ud[d] = b / c
        return a.ud[d]
    end,
    sc = function(b, h)
        return function(d, f)
            local e = 234
            local i, c, g, j
            repeat
                if e < 146 then
                    if e > 94 then
                        e = c and 130 - e or 218 or 218
                    elseif e > 84 then
                        e, c = e + 18, c(i, g)
                    elseif e > 18 then
                        i(g, j)
                        i = {}
                        g = {[1] = 3, [3] = nil}
                        g[2] = g
                        i.AddToggle = b:wc({
                            c,
                            h[2],
                            g,
                        })
                        i.AddSlider = b:xc({
                            h[5],
                            c,
                        })
                        i.AddDropdown = b:yc({
                            h[5],
                            c,
                        })
                        i.AddColorPicker = b:tc({
                            g,
                            c,
                            h[3],
                        })
                        i.AddKeyPicker = b:vc({
                            g,
                            c,
                            h[3],
                            h[2],
                            h[6],
                            h[4],
                        })
                        i.AddButton = b:uc({c})
                        return i
                    else
                        c = {[1] = 3, [3] = c}
                        c[2] = c
                        e, g = 1512 / e, table
                        g, i, j = d.Groups, g.insert, c[3]
                    end
                elseif e > 218 then
                    i = f.Side
                    g = "Right"
                    c = i == "Right"
                    e = c and 173 or 112 or 112
                elseif e > 173 then
                    e, c, g = e + -72, h[1][3], f.Title
                    i, c = c, c.AddLeftGroupbox
                elseif e > 146 then
                    c = h[1][3]
                    g = f.Title
                    c, e, i = c.AddRightGroupbox, 16262 / e, c
                else
                    e, c = e + -128, c(i, g)
                end
            until false
        end
    end,
    Ya = function(b, _)
        return function(d)
            local e = 147
            local c, a, f
            repeat
                if e >= 147 then
                    e = 116
                    c = "Sub"
                    f = _[1][3]
                    a = d
                else
                    f(c, a)
                    return
                end
            until false
        end
    end,
    _c = function(b, _)
        return function(skeleton)
            _[1][3].skeleton = skeleton
        end
    end,
    Kb = function(b, h)
        return function(d, visible)
            local e = 43
            local j, g, c, a, i
            while true do
                if e >= 104 then
                    if e > 150 then
                        e, c = 20293 / e, h[2][3]
                        i, c = c, c.Resize
                    elseif e > 104 then
                        c, i, g = c(i)
                        c, i, g = b.b(c, i, g)
                        j, a = c(i, g)
                        g = j
                        e = j == nil and 223 or e + -46
                    else
                        e, a.Visible = 6240 / e, visible
                    end
                elseif e <= 60 then
                    if e <= 43 then
                        e = 150
                        c = ipairs
                        i = h[1][3]
                    else
                        j, a = c(i, g)
                        g = j
                        e = j == nil and 223 or 6240 / e
                    end
                else
                    c(i)
                    return
                end
            end
        end
    end,
    _a = function(b, h)
        return function(d, f, c)
            local e = 0
            local j, a, i, g
            repeat
                if e <= 86 then
                    if e <= 0 then
                        a = c
                        g = d
                        i = h[1][3]
                        e = 187
                        j = f
                    else
                        g(j)
                        return i
                    end
                else
                    i = i(g, j, a)
                    e = 86
                    j = i
                    g = h[2][3].Apply
                end
            until false
        end
    end,
    ha = function(b, h)
        return function(d, k, c)
            local e = 133
            local a, j, i, g
            while true do
                if e <= 127 then
                    if e <= 95 then
                        if e <= 66 then
                            if e <= 48 then
                                if e > 43 then
                                    j = k
                                    a = c
                                    g = d
                                    e = 95
                                    i = h[1][3]
                                else
                                    j, e, a = ": ", 109 - e, k.Description
                                    g = ": " .. a
                                end
                            else
                                e = g and e + 156 or 169 or 169
                            end
                        else
                            i = b.c(i(g, j, a))
                            return b.d(i)
                        end
                    elseif e <= 123 then
                        g = k.Description
                        e = g and e + -80 or 8118 / e
                    else
                        i = k.Title
                        c = k.Lifetime
                        e = i and e + -4 or 17399 / e
                    end
                elseif e < 169 then
                    if e > 133 then
                        e = 123
                        i = ""
                    else
                        i = type
                        e = 201
                        g = k
                    end
                elseif e <= 201 then
                    if e > 169 then
                        i = i(g)
                        g = "table"
                        e = i == "table" and 25527 / e or 249 - e
                    else
                        e, g = 391 - e, ""
                    end
                else
                    e = 48
                    k = i .. g
                end
            end
        end
    end,
    Pc = function(o, h)
        return function(n, k)
            local i = 0
            local p = ""
            local q = #n - 1
            local a, _, f, d
            if 0 <= q then
                while true do
                    _ = h[2][3]
                    a = h[1][3]
                    f = h[3][3](n, i + 1)
                    d = h[3][3]
                    d = o.c(d(k, i % #k + 1))
                    _ = o.c(_(f, o.d(d)))
                    p = p .. a(o.d(_))
                    i = i + 1
                    if i > q then
                        break
                    end
                end
            end
            return p
        end
    end,
    j = function(o, h)
        return function()
            local v = 58
            local a, q, _, m, B, d, b, w, n, f, j, p, u, F, C, g, E, e, c, i, D, s, z, A, r, x, t, k
            while true do
                if v < 153 then
                    if v > 104 then
                        if v > 129 then
                            if v > 130 then
                                u = o.c(u(m, D, r))
                                e[1], e[2], e[3], e[4], e[5], e[6], e[7] = E, b, w, t, j, A, g
                                o.e(e, 8, o.d(u))
                                d = {[1] = 3, [3] = e}
                                d[2] = d
                                w = {}
                                E = {}
                                w[1], w[2] = 1, 2
                                b = w
                                t = {}
                                t[1], t[2] = 2, 3
                                w = t
                                j = {}
                                v = 239
                                j[1], j[2] = 3, 4
                                t = j
                                A = {}
                                A[1], A[2] = 4, 1
                                j = A
                                g = {}
                                g[1], g[2] = 5, 6
                                u = {}
                                A = g
                                u[1], u[2] = 6, 7
                                g = u
                                m = {}
                                m[1], m[2] = 7, 8
                                u = m
                                D = {}
                                D[1], D[2] = 8, 5
                                m = D
                                r = {}
                                r[1], r[2] = 1, 5
                                F = {}
                                D = r
                                F[1], F[2] = 2, 6
                                r = F
                                s = {}
                                s[1], s[2] = 3, 7
                                F = s
                                k = 4
                                n = {}
                                n[1], n[2] = 4, 8
                                s = n
                                E[1], E[2], E[3], E[4], E[5], E[6], E[7], E[8], E[9], E[10], E[11], E[12] = b, w, t, j, A, g, u, m, D, r, F, n
                                e = {[1] = 3, [3] = E}
                                e[2] = e
                                b = RaycastParams
                                E = RaycastParams.new
                            else
                                i, B = Color3, i(q, x, a)
                                i, p = 0, i.new
                                v = 204
                                q = 0
                                x = 0
                            end
                        elseif v <= 119 then
                            if v > 114 then
                                v, d[_] = 183, e
                            elseif v > 105 then
                                v, e = v + 113, z[3].teamSettings
                                E = type
                                b = C
                                d = e.players
                            else
                                a[1], a[2] = _(C, d, e), 0.2
                                v = 78
                                q.boxFillColor = a
                                q.healthBar = false
                                _ = 1
                                x = Color3.new
                                a = 0
                                C = 0
                            end
                        else
                            v = 119
                            e = C
                        end
                    elseif v < 67 then
                        if v <= 43 then
                            if v < 21 then
                                a.visibleColor = _(C, d, e)
                                a.visibleIntensity = 0.85
                                v, a.occludedColor = 206, B[3]
                                a.occludedIntensity = 0.25
                                q.npc = a
                                a = {}
                                q = z[3].advanced
                                a.nameType = "Name"
                                _ = false
                                a.skeleton = false
                                a.skeletonColor = B[3]
                                q.npc = a
                                q = z[3].chams
                                x = table.clone
                                a = z[3].chams.npc
                            elseif v > 21 then
                                q, x, a = q(x)
                                q, x, a = o.b(q, x, a)
                                _, C = q(x, a)
                                a = _
                                v = _ == nil and 230 or 114 or 114
                            else
                                i.neutralColor = q(x, a, _)
                                B.sharedSettings = i
                                B.teamSettings = {}
                                B.chams = {}
                                p = {}
                                v, B.advanced = v + 109, p
                                z = {[1] = 3, [3] = B}
                                z[2] = z
                                q = 1
                                i = Color3.new
                                x = 1
                                a = 1
                            end
                        else
                            B = {
                                _hasLoaded = false,
                                objects = {},
                            }
                            v = 21
                            B.errors = {}
                            p = 0
                            B.scanAt = 0
                            i = {
                                textSize = 13,
                                textFont = 2,
                                limitDistance = false,
                                maxDistance = 1000,
                                teamBasedColor = false,
                            }
                            a = 220
                            q = Color3.fromRGB
                            _ = 150
                            x = 100
                        end
                    elseif v < 78 then
                        if v > 67 then
                            E = E(b, w, t)
                            v = 167
                            w = -1
                            t = 1
                            b = Vector3.new
                            j = -1
                        else
                            q.players = x(a)
                            _ = {}
                            x = {}
                            v, _.Actors = 72, {}
                            x.Replicator = _
                            q = {[1] = 3, [3] = x}
                            q[2] = q
                            x = {[1] = 3, [3] = nil}
                            x[2] = x
                            a = {[1] = 3, [3] = nil}
                            a[2] = a
                            _ = {
                                [1] = 3,
                                [3] = {},
                            }
                            _[2] = _
                            d = {}
                            C = {[1] = 3, [3] = d}
                            C[2] = C
                            e = {}
                            E = Vector3.new
                            b = -1
                            w = -1
                            t = -1
                        end
                    elseif v <= 78 then
                        q.healthyColor = x(a, _, C)
                        a = 1
                        x = Color3.new
                        _ = 0
                        v = 210
                        C = 0
                    else
                        v, w = 153, w(t, j, A)
                        t = Vector3.new
                        j = -1
                        A = -1
                        g = 1
                    end
                elseif v < 210 then
                    if v > 183 then
                        if v > 204 then
                            q.players = x(a)
                            v, q, a = 273 - v, z[3].advanced, table
                            a, x = z[3].advanced, a.clone
                            a = a.npc
                        elseif v > 200 then
                            p = p(i, q, x)
                            B = {[1] = 3, [3] = B}
                            B[2] = B
                            p = {[1] = 3, [3] = p}
                            p[2] = p
                            q = {enabled = true, box = false, box3d = false}
                            a = {}
                            a[1], a[2] = B[3], 1
                            q.boxColor = a
                            a = {}
                            a[1], a[2] = B[3], 1
                            q.box3dColor = a
                            q.boxOutline = true
                            a = {}
                            a[1], a[2] = p[3], 1
                            q.boxOutlineColor = a
                            v, q.boxOutlineThickness = v + -99, 1
                            x = false
                            q.boxFill = false
                            a = {}
                            C = 150
                            d = 80
                            e = 255
                            _ = Color3.fromRGB
                        else
                            v = e and v + -81 or 129 or 129
                        end
                    elseif v >= 180 then
                        if v > 180 then
                            _, C = q(x, a)
                            a = _
                            v = _ == nil and 413 - v or 114 or 114
                        else
                            v, E = v + 63, table
                            e, E = E.clone, C
                        end
                    elseif v <= 153 then
                        t = t(j, A, g)
                        A = 1
                        j = Vector3.new
                        g = -1
                        v = 245
                        u = -1
                    else
                        b = b(w, t, j)
                        v = 104
                        j = 1
                        t = -1
                        w = Vector3.new
                        A = 1
                    end
                elseif v > 230 then
                    if v <= 243 then
                        if v <= 239 then
                            E = {
                                [1] = 3,
                                [3] = E(),
                            }
                            E[2] = E
                            b = Enum.RaycastFilterType.Exclude
                            E[3].FilterType = b
                            E[3].IgnoreWater = true
                            b = o:rb({q})
                            z[3].Service = b
                            b = o:vb({
                                h[1],
                                h[2],
                            })
                            z[3].Refresh = b
                            b = {[1] = 3, [3] = b}
                            b[2] = b
                            b[3], w = o:sb({_, q, z}), o:gb({z})
                            z[3].IsNPC = w
                            w = o:pb({
                                z,
                                h[1],
                                h[2],
                            })
                            z[3].IsPlayer = w
                            w = o:zb({z})
                            z[3].Kind = w
                            w = {[1] = 3, [3] = w}
                            w[2] = w
                            w[3] = o:tb({z})
                            t = {[1] = 3, [3] = Enum}
                            t[2] = t
                            t[3] = o:db({w})
                            j = {[1] = 3, [3] = j}
                            j[2] = j
                            j[3] = o:bb()
                            A = {[1] = 3, [3] = A}
                            A[2] = A
                            A[3] = o:mb()
                            g = {[1] = 3, [3] = g}
                            g[2] = g
                            g[3] = o:hb()
                            u = o:ib({
                                z,
                                h[1],
                                _,
                                h[2],
                                b,
                                q,
                                A,
                                g,
                            })
                            z[3].Sync = u
                            u = {[1] = 3, [3] = u}
                            u[2] = u
                            u[3], m = o:xb({B}), o:ob({z})
                            z[3].TeamColor = m
                            m = {[1] = 3, [3] = m}
                            m[2] = m
                            m[3] = o:eb({u})
                            D = {[1] = 3, [3] = D}
                            D[2] = D
                            D[3] = o:ub()
                            r = {[1] = 3, [3] = r}
                            r[2] = r
                            r[3] = o:_b({D, t, m})
                            F = {[1] = 3, [3] = F}
                            F[2] = F
                            F[3] = o:yb({t, m})
                            s = {[1] = 3, [3] = s}
                            s[2] = s
                            s[3] = o:nb({t, z, m, p})
                            n = {[1] = 3, [3] = n}
                            n[2] = n
                            n[3] = o:qb()
                            k = {[1] = 3, [3] = k}
                            k[2] = k
                            k[3], f = o:fb(), o:jb()
                            z[3].Weapon = f
                            f = {[1] = 3, [3] = f}
                            f[2] = f
                            f[3] = o:wb({z, E, a})
                            c = o:cb({
                                j,
                                e,
                                t,
                                F,
                                h[2],
                                m,
                                d,
                                p,
                                k,
                                z,
                                n,
                                r,
                                s,
                                f,
                            })
                            z[3].RenderActor = c
                            c = o:kb({z, j})
                            z[3].Render = c
                            c = o:lb({
                                z,
                                C,
                                x,
                                h[3],
                                b,
                            })
                            z[3].Load = c
                            c = o:ab({z, C, A, _, x, a, q})
                            z[3].Unload = c
                            return z[3]
                        else
                            v, e = 48600 / v, e(E)
                        end
                    else
                        j = j(A, g, u)
                        v = 221
                        A = Vector3.new
                        g = 1
                        u = 1
                        m = -1
                    end
                elseif v > 226 then
                    if v <= 227 then
                        E = E(b)
                        b = "table"
                        e = E == "table"
                        v = e and 180 or v + -27
                    else
                        z[3].teamSettings.players.enabled = false
                        z[3].teamSettings.players.teamCheck = false
                        x = 1
                        z[3].teamSettings.players.boxOutlineThickness = 1
                        q = z[3].chams
                        a = {}
                        v, a.enabled = 2300 / v, false
                        _ = Color3.fromRGB
                        e = 100
                        C = 0
                        d = 255
                    end
                elseif v < 221 then
                    q.dyingColor = x(a, _, C)
                    q.healthBarOutline = true
                    q.healthText = false
                    C = 1
                    a = {}
                    a[1], a[2] = B[3], 1
                    q.healthTextColor = a
                    q.healthTextOutline = true
                    q.name = false
                    a = {}
                    a[1], a[2] = B[3], 1
                    q.nameColor = a
                    v = 43
                    q.nameOutline = true
                    q.weapon = false
                    a = {}
                    a[1], a[2] = B[3], 1
                    q.weaponColor = a
                    q.weaponOutline = true
                    q.distance = false
                    a = {}
                    a[1], a[2] = B[3], 1
                    q.distanceColor = a
                    q.distanceOutline = true
                    q.tracer = false
                    q.tracerOrigin = "Bottom"
                    a = {}
                    a[1], a[2] = B[3], 1
                    q.tracerColor = a
                    q.tracerOutline = true
                    q.offScreenArrow = false
                    q.offScreenArrowSize = 15
                    q.offScreenArrowRadius = 150
                    a = {}
                    _ = B[3]
                    a[1], a[2] = _, 1
                    q.offScreenArrowColor = a
                    q, i = z[3].teamSettings, q
                    q.npc = i
                    a = {}
                    z[3].teamSettings.players = a
                    x = i
                    q = pairs
                elseif v > 221 then
                    g = g(u, m, D)
                    D = -1
                    u = Vector3.new
                    m = 1
                    v, r = 31414 / v, 1
                else
                    v, A = 226, A(g, u, m)
                    g = Vector3.new
                    u = 1
                    D = 1
                    m = 1
                end
            end
        end
    end,
    Va = function(b, h)
        return function(d, f)
            local e = 247
            local c, i, j, g
            while true do
                if e > 130 then
                    e, f = 5, {[1] = 3, [3] = f}
                    f[2] = f
                    c = {[1] = 3, [3] = nil}
                    c[2] = c
                    j = b:Nc({f, c})
                    i = hookfunction
                    g = d
                elseif e <= 5 then
                    g, c[3] = table, i(g, j)
                    e = 130
                    i = g.insert
                    g = h[1][3].hooks
                    j = d
                else
                    i(g, j)
                    return
                end
            end
        end
    end,
    zb = function(b, _)
        return function(d)
            local e = 48
            local c, f
            repeat
                if e > 150 then
                    if e < 198 then
                        f = f(c)
                        e = f and 19 or e + 52
                    elseif e > 198 then
                        e, c = 249 - e, _[1][3]
                        f, c = c.IsPlayer, d
                    else
                        return
                    end
                elseif e >= 48 then
                    if e > 48 then
                        return "players"
                    else
                        e = 174
                        f = _[1][3].IsNPC
                        c = d
                    end
                elseif e <= 19 then
                    return "npc"
                else
                    f = f(c)
                    e = f and 173 - e or 221 - e
                end
            until false
        end
    end,
    Ja = function(o, h)
        return function()
            local m = 185
            local e, n, j, p, l, f, i, k, a, d, g, b, _
            while true do
                if m <= 138 then
                    if m < 86 then
                        if m > 17 then
                            if m > 63 then
                                m, p = 213, p(i, g)
                                i = require
                                g = p.ClientModules.TracerController
                            else
                                a(_, f)
                                m, _ = 16065 / m, h[1][3]
                                _, a, f = i.AddProjectile, _.Hook, o:Lc({
                                    h[1],
                                })
                            end
                        elseif m > 6 then
                            m = 0
                            f = "Unexpected shooting route"
                        elseif m <= 0 then
                            m = 6
                            a(_, f)
                            a = h[1][3].Hook
                            f = o:Jc({
                                h[1],
                                h[2],
                                h[3],
                            })
                            _ = n
                        else
                            a(_, f)
                            m, _ = m + 57, h[1][3]
                            f, _, a = o:Kc({
                                h[1],
                            }), k, _.Hook
                        end
                    elseif m > 94 then
                        if m > 110 then
                            k = k(p)
                            g = "ReplicatedStorage"
                            p = game
                            m, p, i = m + -68, p.GetService, p
                        else
                            n = n(k)
                            m, p = m + 28, h[1][3]
                            p, k = "CastShot", p.FindFunction
                        end
                    elseif m >= 91 then
                        if m > 91 then
                            g = a(_).Client.GunService
                            j = {
                                [1] = 3,
                                [3] = g.TryShoot,
                            }
                            j[2] = j
                            a = assert
                            f = type
                            m = 183
                            d = i.AddProjectile
                        else
                            f = f(d)
                            d = "function"
                            _ = f == "function"
                            m = l > b and m + -74 or 185 or 185
                        end
                    else
                        m, d = m + 5, d(e).__call
                    end
                elseif m >= 227 then
                    if m >= 251 then
                        if m > 251 then
                            a(_, f)
                            _ = h[1][3]
                            a = o:Ic({
                                h[1],
                                j,
                            })
                            _.service = g
                            _.route = j[3]
                            _.routeWrapper = a
                            g.TryShoot = a
                            _.hookState = "Ready"
                            return
                        else
                            a(_, f)
                            m, d, f = 35391 / m, j[3], type
                        end
                    elseif m <= 227 then
                        n(k, p)
                        n, m, k = h[1][3].FindFunction, 24970 / m, "TryShoot"
                    else
                        e, m, f, d = j[3], 20984 / m, type, getmetatable
                    end
                elseif m <= 185 then
                    if m < 183 then
                        f = f(d)
                        d = "table"
                        _ = f == "table"
                        m = _ and 34404 / m or m + -124
                    elseif m <= 183 then
                        f = f(d)
                        m, d = m + 68, "function"
                        f, _ = "Projectile adapter unavailable", f == "function"
                    else
                        m = 227
                        n = assert
                        l = 174
                        b = 78
                        i = 136020512003847
                        k = game.PlaceId == 136020512003847
                        p = "This adapter is for San Diego Roleplay"
                    end
                else
                    i = i(g)
                    a = require
                    f = p.SharedModules
                    m, _ = 20022 / m, f.Pronghorn.Remotes
                end
            end
        end
    end,
    y = function(o)
        return function(n, k)
            local m = 28
            local _, d, g, b, p, i, f, e, q, r, l, a, c
            while true do
                if m >= 147 then
                    if m < 223 then
                        if m >= 170 then
                            if m > 170 then
                                r, a, _ = r(o.d(a))
                                r, a, _ = o.b(r, a, _)
                                f, d = r(a, _)
                                _ = f
                                m = f == nil and 236 or 50752 / m
                            else
                                e = e(l, b)
                                m = e and m + -56 or 4 or 4
                            end
                        elseif m <= 147 then
                            m, q = 73, o.c(q(r))
                        else
                            a, _ = i(q, r)
                            r = a
                            m = a == nil and 20352 / m or m + 86
                        end
                    elseif m <= 241 then
                        if m <= 236 then
                            if m <= 223 then
                                m, l = 341 - m, table
                                b, e, l = d, l.insert, q[3]
                            else
                                i.SetVisible = o:Kb({q, n})
                                return i
                            end
                        else
                            m, i = 296 - m, i()
                            q = {
                                [1] = 3,
                                [3] = {},
                            }
                            q[2] = q
                            r = ipairs
                            a = n[3].Container
                            a, _ = a.GetChildren, a
                        end
                    elseif m > 244 then
                        p[_] = true
                        m = c >= g and 38955 / m or 245 or 245
                    else
                        e, l, m, b = d.IsA, d, m + -74, "GuiObject"
                    end
                elseif m <= 73 then
                    if m <= 28 then
                        if m >= 10 then
                            if m > 10 then
                                g = 70
                                c = 248
                                n = {[1] = 3, [3] = n}
                                n[2] = n
                                p = {}
                                m = 147
                                q = n[3].Container
                                i = ipairs
                                r, q = q, q.GetChildren
                            else
                                f, d = r(a, _)
                                _ = f
                                m = f == nil and 246 - m or 254 - m
                            end
                        else
                            m = e and 892 / m or m + 6
                        end
                    elseif m <= 55 then
                        m, a = 208, o.c(a(_))
                    else
                        i, q, r = i(o.d(q))
                        i, q, r = o.b(i, q, r)
                        a, _ = i(q, r)
                        r = a
                        m = a == nil and 128 or 17885 / m
                    end
                elseif m < 118 then
                    m = 4
                    l = p[d]
                    e = not l
                elseif m <= 118 then
                    m = 10
                    e(l, b)
                else
                    m, i = 30848 / m, k
                end
            end
        end
    end,
    ga = function(b, _)
        return function()
            local e = 26
            local c, f, d
            while true do
                if e <= 163 then
                    if e >= 85 then
                        if e <= 85 then
                            f = _[1][3]
                            e = 228
                            d = f.KeyActive
                        else
                            d.Position = f(c)
                            c = _[3][3]
                            f = c.FOV
                            _[1][3].circle.Radius = f
                            f = c.FOVColor
                            _[1][3].circle.Color = f
                            f = c.ShowFOV
                            _[1][3].circle.Visible = f
                            return
                        end
                    else
                        c = _[1][3]
                        f = c.active
                        d = not f
                        e = d and 195 or 85 or 85
                    end
                elseif e <= 195 then
                    return
                else
                    e = 391 - e
                    d()
                    d, f = f.circle, _[2][3]
                    c, f = f, f.GetMouseLocation
                end
            end
        end
    end,
    ia = function(b, h)
        return function(l, k, c)
            local e = 129
            local g, j, a, f, i, _
            repeat
                if e > 84 then
                    if e <= 129 then
                        if e <= 125 then
                            e, h[2][3].FilterDescendantsInstances = 128 - e, i
                            f = h[2][3]
                            _ = k - l
                            a = l
                            g = workspace
                            g, j = g.Raycast, g
                        else
                            a = workspace
                            i = {
                                [1] = workspace.CurrentCamera,
                            }
                            j = h[1][3]
                            g = j.Character
                            e = g and 7 or 125 or 125
                        end
                    else
                        return j
                    end
                elseif e <= 15 then
                    if e >= 7 then
                        if e > 7 then
                            j, e, _ = g.Instance, 1260 / e, c
                            j, a = j.IsDescendantOf, j
                        else
                            e = 78
                            j = i
                            g = table.insert
                            a = h[1][3].Character
                        end
                    else
                        g = g(j, a, _, f)
                        a = nil
                        j = g == nil
                        e = j and 230 or e + 12
                    end
                elseif e > 78 then
                    e, j = 230, j(a, _)
                else
                    e = e + 47
                    g(j, a)
                end
            until false
        end
    end,
    Ba = function(b, _)
        return function(e)
            _[1][3].fog.e = e
        end
    end,
    qc = function(b, h)
        return function(d)
            local e = 220
            local i, g
            while true do
                if e < 220 then
                    i = i(g)
                    return i.Magnitude - h[2][3] * d
                else
                    e = 41
                    g = d
                    i = h[1][3]
                end
            end
        end
    end,
    ub = function(o)
        return function(s, k)
            local v = 229
            local a, w, p, r, d, f, i, e, t, c, y2, _, n, q, l, j, x, b
            while true do
                if v <= 131 then
                    if v <= 96 then
                        if v < 78 then
                            if v > 18 then
                                return s + i * q, s + i * x
                            else
                                b = e[2]
                                c = 36
                                r = 248
                                l = e[1]
                                w = math.abs
                                v = 177
                                t = l
                            end
                        elseif v > 88 then
                            t = t(j, n)
                            v, x = 10560 / v, t
                        elseif v > 78 then
                            a, _, f = a(_)
                            a, _, f = o.b(a, _, f)
                            d, e = a(_, f)
                            f = d
                            v = d == nil and 57 or 106 - v
                        else
                            return nil
                        end
                    elseif v < 110 then
                        t = t(j, n)
                        q = t
                        v = c > r and 24045 / v or 110 or 110
                    elseif v > 110 then
                        return nil
                    else
                        v = q > x and 188 - v or 26840 / v
                    end
                elseif v <= 229 then
                    if v >= 177 then
                        if v > 177 then
                            x = 1
                            i = k - s
                            d = {}
                            q = 0
                            p = workspace.CurrentCamera.ViewportSize
                            l = {}
                            a = ipairs
                            w = i.X
                            w, b = s.X, -w
                            l[1], l[2] = b, w
                            e = l
                            n = s.X
                            b = {}
                            t = p.X - n
                            b[1], b[2] = i.X, t
                            l = b
                            w = {}
                            j = s.Y
                            w[1], w[2] = -i.Y, j
                            b = w
                            t = {}
                            v = 88
                            j = i.Y
                            y2 = s.Y
                            n = p.Y - y2
                            t[1], t[2] = j, n
                            w = t
                            d[1], d[2], d[3], d[4] = e, l, b, t
                            _ = d
                        else
                            w = w(t)
                            t = 1e-8
                            v = w < 1e-8 and 311 - v or 252 or 252
                        end
                    elseif v <= 134 then
                        w = 0
                        v = b < 0 and 131 or v + 110
                    else
                        v = 105
                        j = q
                        t = math.max
                        n = w
                    end
                elseif v < 244 then
                    v, j = v + -145, math
                    t, j, n = j.min, x, w
                elseif v <= 244 then
                    d, e = a(_, f)
                    f = d
                    v = d == nil and 57 or 4392 / v
                else
                    t = 0
                    w = b / l
                    v = l < 0 and 396 - v or v + -11
                end
            end
        end
    end,
    s = function(b, _)
        return function(teamCheck)
            _[1][3].TeamCheck = teamCheck
        end
    end,
    qb = function(b)
        return function(d)
            local e = 99
            local f, a, c
            repeat
                if e <= 99 then
                    if e <= 98 then
                        if e >= 74 then
                            if e > 74 then
                                return f
                            else
                                e, f = e + 111, d.WorldPosition
                            end
                        else
                            e, f = 686 / e, d.Position
                        end
                    else
                        f = d.IsA
                        e = 104
                        c = d
                        a = "Bone"
                    end
                elseif e <= 104 then
                    f = f(c, a)
                    e = f and 7696 / e or e + 81
                else
                    e = f and 18130 / e or 7 or 7
                end
            until false
        end
    end,
    A = function(b, _)
        return function(top)
            _[1][3].colorShift.top = top
        end
    end,
    d = (function()
        local function m(i, j, k)
            if j > k then
                return
            end
            return i[j], m(i, j + 1, k)
        end
        return function(o)
            return m(o[1], 1, o[2])
        end
    end)(),
    m = function(b, h)
        return function(l, k)
            local e = 220
            local i, j, a2, g, c, _, a
            while true do
                if e <= 161 then
                    if e >= 82 then
                        if e < 108 then
                            if e <= 82 then
                                a = b.c(a(_, a2))
                                e, i[1], i[2] = 13202 / e, g, j
                                b.e(i, 3, b.d(a))
                            else
                                return
                            end
                        elseif e < 142 then
                            c = c(i)
                            e, l.Color = e + -58, c
                        elseif e > 142 then
                            c = c(i)
                            e, l.Color = e + -111, c
                        else
                            j = j(a, _)
                            a, a2, e, _ = ColorSequenceKeypoint.new, k.A, e + -60, 1
                        end
                    elseif e <= 65 then
                        if e < 50 then
                            g = g(j, a)
                            e = 142
                            _ = k.B
                            a = 0.5
                            j = ColorSequenceKeypoint.new
                        elseif e <= 50 then
                            return
                        else
                            c = ColorSequence.new
                            i = {}
                            e, j, g, a = 102 - e, 0, ColorSequenceKeypoint.new, k.A
                        end
                    else
                        e, i = 257 - e, ColorSequence
                        i, c, j = {}, i.new, ColorSequenceKeypoint
                        a, j, g = k.A, 0, j.new
                    end
                elseif e > 220 then
                    if e >= 240 then
                        if e <= 240 then
                            e, l.Rotation = 407 - e, 0
                            i = 0
                            c = Vector2.new
                            g = 0
                        else
                            e, c = 303 - e, h[1][3]
                            l.Color = c
                        end
                    else
                        i = "gradient"
                        c = k.Style
                        e = c == "gradient" and 74 or 219 or 219
                    end
                elseif e <= 183 then
                    if e <= 177 then
                        if e > 167 then
                            j = b.c(j(a, _))
                            i[1] = g
                            e = e + -69
                            b.e(i, 2, b.d(j))
                        else
                            l.Offset = c(i, g)
                            c = k.Style
                            i = "rainbow"
                            e = c == "rainbow" and e + 86 or 228 or 228
                        end
                    else
                        g = g(j, a)
                        e = 177
                        j = ColorSequenceKeypoint.new
                        a = 1
                        _ = k.B
                    end
                elseif e > 219 then
                    c = not l
                    e = c and 89 or 240 or 240
                else
                    i = "pulse"
                    c = k.Style
                    e = c ~= "pulse" and 284 - e or 269 - e
                end
            end
        end
    end,
    Ib = function(b)
        return function(d)
            return d.Container.Parent.Parent
        end
    end,
    ud = {},
    Cb = function(b, h)
        return function()
            local e = 37
            local k, c, l, g, j, i, _, a
            while true do
                if e < 158 then
                    if e >= 90 then
                        if e > 110 then
                            l, k, c = l(b.d(k))
                            l, k, c = b.b(l, k, c)
                            i, g = l(k, c)
                            c = i
                            e = i == nil and 29036 / e or 7808 / e
                        elseif e > 105 then
                            return
                        elseif e <= 90 then
                            e, k = 122, b.c(k(c))
                        else
                            e, a = e + 136, task
                            j = a.wait
                        end
                    elseif e >= 37 then
                        if e > 37 then
                            _ = h[1][3]
                            a = _._hasLoaded
                            j = not a
                            e = j and e + 46 or e + 103
                        else
                            k = workspace
                            l = ipairs
                            e, k, c = 90, k.GetDescendants, k
                        end
                    else
                        e = e + 212
                        j(a)
                    end
                elseif e <= 187 then
                    if e > 167 then
                        j = j(a, _)
                        e = j and 30294 / e or e + 48
                    elseif e >= 162 then
                        if e <= 162 then
                            a, e, j = g.Parent, e + -139, h[2][3]
                        else
                            a = g
                            e = 187
                            _ = "Humanoid"
                            j = g.IsA
                        end
                    else
                        i, g = l(k, c)
                        c = i
                        e = i == nil and 396 - e or e + -94
                    end
                elseif e < 238 then
                    a = 0
                    j = i % 1000
                    e = j == 0 and 105 or 158 or 158
                elseif e <= 238 then
                    return
                else
                    e = e + -83
                    j()
                end
            end
        end
    end,
    cc = function(b, _)
        return function(boxOutline)
            _[1][3].boxOutline = boxOutline
        end
    end,
    Oc = function(b)
        local a = string
        local f, d
        f, d, a = a.byte, a.char, bit32
        local bxor = a.bxor
        d = {[1] = 3, [3] = d}
        d[2] = d
        f = {[1] = 3, [3] = f}
        f[2] = f
        bxor = {[1] = 3, [3] = bxor}
        bxor[2] = bxor
        return b:Pc({d, bxor, f})
    end,
    tb = function(b, h)
        return function(n, k, c, i)
            local m = 3
            local j, f, d, a, g, _
            while true do
                if m >= 107 then
                    if m <= 176 then
                        if m < 163 then
                            m = 17441 / m
                        elseif m > 163 then
                            m, g[f] = 272 - m, d
                        else
                            j, a, _ = j(a)
                            j, a, _ = b.b(j, a, _)
                            f, d = j(a, _)
                            _ = f
                            m = f == nil and 248 or 176 or 176
                        end
                    elseif m <= 195 then
                        m, j = 235 - m, Drawing
                        g = j.new
                    else
                        n.drawings[k] = g
                        return g
                    end
                elseif m >= 40 then
                    if m >= 81 then
                        if m > 81 then
                            f, d = j(a, _)
                            _ = f
                            m = f == nil and 248 or 176 or 176
                        else
                            m, f = m + 26, {}
                            a = f
                        end
                    else
                        m, j = m + -11, c
                    end
                elseif m > 3 then
                    g = g(j)
                    g.Visible = false
                    g.Transparency = 1
                    j = pairs
                    a = i
                    m = i and 136 - m or 2349 / m
                else
                    j = h[1][3]
                    g = j.DrawingFactory
                    m = g and 40 or 195 or 195
                end
            end
        end
    end,
    Jc = function(o, h)
        return function(s, ...)
            local m = 139
            local j, l, r, i, g, n, p, _, f, d, k, q, e, n2, b, a, t
            repeat
                if m < 145 then
                    if m >= 75 then
                        if m <= 109 then
                            if m < 96 then
                                if m <= 75 then
                                    g = 139
                                    n = 239
                                    m = q and 88 or 161 or 161
                                else
                                    a = h[1][3]
                                    r = a.active
                                    m = r and 289 - m or 144 or 144
                                end
                            elseif m > 96 then
                                m, e = 145, o.c(e(l, b, n2))
                            else
                                m, p = 148, p()
                                q = h[1][3].contexts
                                r = type
                                a = k[2]
                                i = q[p]
                            end
                        elseif m > 139 then
                            m = r and 207 or m + 46
                        elseif m > 127 then
                            t = 149
                            j = 251
                            p = o.c(...)
                            m = 245
                            k = table.pack
                        else
                            m = 146
                            d = {}
                            f = d
                        end
                    elseif m <= 29 then
                        if m >= 18 then
                            if m > 18 then
                                m, a = 61 - m, a(_)
                                r = not a
                            else
                                r = k[2]
                                q = r.Stats
                                m = t >= j and 106 - m or 93 - m
                            end
                        elseif m <= 7 then
                            a = _() * 100
                            f = h[2][3]
                            _ = f.HitChance
                            m = 36
                            r = a < _
                        else
                            m = 242
                            e = 0
                            d = _[2]
                            f = error
                        end
                    elseif m > 36 then
                        r = r()
                        m = n < g and 57 - m or 190 or 190
                    elseif m > 32 then
                        _ = {}
                        f = q
                        m = q and 146 or 127 or 127
                    else
                        m = r and m + 118 or 36 or 36
                    end
                elseif m <= 201 then
                    if m <= 161 then
                        if m < 148 then
                            if m <= 145 then
                                m, f = m + 85, o.c(f(d, o.d(e)))
                            else
                                _.stats = f
                                _.allowed = r
                                _.projectiles = {}
                                a = _
                                f = h[1][3]
                                f.contexts[p] = _
                                _ = f.diagnostics
                                m, f = 15914 / m, _.shots + 1
                                _.shots = f
                                f = pcall
                                d = s
                                _ = table.pack
                                e = table.unpack
                                l = k
                                b = 1
                                n2 = k.n
                            end
                        elseif m <= 150 then
                            if m <= 148 then
                                r = r(a)
                                a = "table"
                                q = r == "table"
                                m = q and m + -130 or m + -73
                            else
                                f = math
                                m = 7
                                _ = math.random
                            end
                        else
                            r = {}
                            m = 88
                            q = r
                        end
                    elseif m < 194 then
                        m = r and 47690 / m or 32 or 32
                    elseif m <= 194 then
                        m = 233
                        d = _
                        l = _.n
                        f = table.unpack
                        e = 2
                    else
                        a = h[2][3]
                        m = 144
                        r = a.Enabled
                    end
                elseif m >= 242 then
                    if m < 245 then
                        m = 194
                        f(d, e)
                    elseif m > 245 then
                        m, a = 7279 / m, h[3][3]
                        a, _ = a.GetFocusedTextBox, a
                    else
                        k = k(o.d(p))
                        i = coroutine
                        m = 96
                        p = coroutine.running
                    end
                elseif m > 230 then
                    f = o.c(f(d, e, l))
                    return o.d(f)
                elseif m <= 207 then
                    m, a = 250 - m, h[1][3]
                    r = a.KeyActive
                else
                    _ = _(o.d(f))
                    h[1][3].contexts[p] = i
                    d = _[1]
                    f = not d
                    m = f and 3220 / m or m + -36
                end
            until false
        end
    end,
    hb = function(o)
        return function(s)
            local m = 201
            local j, d, b, g, e, i, p, t, r, a, f, k, _, n, q
            repeat
                if m < 102 then
                    if m <= 51 then
                        if m <= 35 then
                            if m <= 18 then
                                if m > 12 then
                                    _ = _(f, d)
                                    m = _ and 80 or m + 148
                                elseif m <= 10 then
                                    if m > 9 then
                                        d = #s.parts
                                        f = d + 1
                                        s.parts[f] = a
                                        m = 131
                                        _ = true
                                        k[a] = true
                                    else
                                        m = 216 / m
                                    end
                                else
                                    f, d, m, _ = a, "Bone", 30 - m, a.IsA
                                end
                            elseif m > 24 then
                                m, f, d, _ = 1470 / m, a, "BasePart", a.IsA
                            else
                                p, i, q = p(i)
                                p, i, q = o.b(p, i, q)
                                r, a = p(i, q)
                                q = r
                                m = r == nil and 2448 / m or 218 or 218
                            end
                        elseif m > 42 then
                            if m <= 43 then
                                m = 64
                                f = a.Part0
                            else
                                m, f = 110 - m, a.Part1
                            end
                            _ = k[f]
                        elseif m < 40 then
                            r, a = p(i, q)
                            q = r
                            m = r == nil and 102 or 218 or 218
                        elseif m <= 40 then
                            m = _ and 10 or m + 91
                        else
                            _ = _(f, d)
                            m = _ and m + 120 or 40 or 40
                        end
                    elseif m <= 71 then
                        if m > 62 then
                            if m <= 64 then
                                m = _ and 51 or 123 - m
                            else
                                p = ipairs
                                m = 55
                                i = s.model
                                i, q = i.GetDescendants, i
                            end
                        elseif m >= 59 then
                            if m > 59 then
                                m, _ = 145, _(f, d)
                            else
                                m = _ and 111 or 12 or 12
                            end
                        elseif m > 55 then
                            _ = _(f, d)
                            m = n <= g and 212 or 76 or 76
                        else
                            m, i = 174, o.c(i(q))
                        end
                    elseif m > 78 then
                        _ = a.Parent
                        d = "Bone"
                        m, f, _ = 75, _, _.IsA
                    elseif m < 76 then
                        m, _ = 241 - m, _(f, d)
                    elseif m > 76 then
                        m, i = 204, o.c(i(q))
                    else
                        return
                    end
                elseif m > 174 then
                    if m < 212 then
                        if m >= 201 then
                            if m > 204 then
                                _ = _(f, d)
                                m = _ and 43 or 13184 / m
                            elseif m > 201 then
                                p, i, q = p(o.d(i))
                                p, i, q = o.b(p, i, q)
                                r, a = p(i, q)
                                q = r
                                m = r == nil and 71 or 35 or 35
                            else
                                j = 249
                                t = 61
                                n = 175
                                g = 199
                                s.parts = {}
                                s.links = {}
                                k = {}
                                p = pairs
                                i = s.actor.Parts
                                m = i and 9 or 227 or 227
                            end
                        elseif m > 187 then
                            f, m, _, d = a, 259 - m, a.IsDescendantOf, s.model
                        else
                            f = f(d)
                            d = "Instance"
                            _ = f == "Instance"
                            m = _ and 322 - m or 39644 / m
                        end
                    elseif m >= 220 then
                        if m <= 221 then
                            if m <= 220 then
                                f = a
                                m = 206
                                _ = a.IsA
                                d = "Motor6D"
                            else
                                m = 78
                                p = ipairs
                                i = s.model
                                q, i = i, i.GetChildren
                            end
                        else
                            i = {}
                            m = t >= j and m + -66 or 9 or 9
                        end
                    elseif m > 212 then
                        m, d, f = 405 - m, a, typeof
                    else
                        m = _ and 41764 / m or 145 or 145
                    end
                elseif m < 147 then
                    if m < 131 then
                        if m <= 102 then
                            p = #s.parts
                            i = 0
                            m = p == 0 and m + 119 or 7242 / m
                        else
                            m = 167
                            _ = s.links
                            e = {}
                            f = #s.links + 1
                            b = a.Part1
                            e[1], e[2] = a.Part0, b
                            d = e
                            _[f] = e
                        end
                    elseif m > 135 then
                        m = _ and 292 - m or 37 or 37
                    elseif m <= 131 then
                        r, a = p(i, q)
                        q = r
                        m = r == nil and 71 or 4585 / m
                    else
                        f, d, m, _ = a, "BasePart", m + -79, a.IsA
                    end
                elseif m > 166 then
                    if m <= 167 then
                        r, a = p(i, q)
                        q = r
                        m = r == nil and 243 - m or 220 or 220
                    else
                        p, i, q = p(o.d(i))
                        p, i, q = o.b(p, i, q)
                        r, a = p(i, q)
                        q = r
                        m = r == nil and 76 or 38280 / m
                    end
                elseif m <= 162 then
                    if m >= 161 then
                        if m <= 161 then
                            _ = s.links
                            e = {}
                            f = #s.links + 1
                            e[1], m, e[2] = a.Parent, 328 - m, a
                            d = e
                            _[f] = e
                        else
                            d = s.actor
                            m = 40
                            f = d.RootPart
                            _ = a ~= f
                        end
                    else
                        d = #s.parts
                        f = d + 1
                        s.parts[f] = a
                        m = 37
                        _ = true
                        k[a] = true
                    end
                else
                    m = _ and m + -5 or 333 - m
                end
            until false
        end
    end,
    fa = function(b, h)
        return function(enabled)
            local e = 250
            local a, j, f, i
            while true do
                if e > 158 then
                    j = 92
                    a = 118
                    h[1][3].ambient.enabled = enabled
                    e = not enabled and 158 or 1 or 1
                elseif e <= 1 then
                    return
                else
                    i = h[3][3]
                    f = h[2][3]
                    f.Ambient = i.Ambient
                    f.OutdoorAmbient = i.OutdoorAmbient
                    e = j < a and 1 or 158 or 158
                end
            end
        end
    end,
    ja = function(b)
        return function(d, f)
            d = {[1] = 3, [3] = d}
            d[2] = d
            f = {[1] = 3, [3] = f}
            f[2] = f
            return b:Hc({d, f})
        end
    end,
    i = function(b, h)
        return function(d)
            local e = 183
            local c, f
            while true do
                if e <= 223 then
                    if e > 183 then
                        e = 239
                        c = 2
                    else
                        f = h[1][3].sharedSettings
                        c = h[2][3][d]
                        e = c and 239 or 223 or 223
                    end
                else
                    f.textFont = c
                    return
                end
            end
        end
    end,
    Ad = function(a, b, c, d)
        a.yd[d] = a.a(b, 38406) / a.a(c, 12867)
        return a.yd[d]
    end,
    Hc = function(b, h)
        return function(d, f)
            local e = 36
            local c, i
            while true do
                if e > 117 then
                    if e <= 169 then
                        e = 197
                        i = h[1][3]
                        c = i[h[2][3]]
                        c[2] = f
                    end
                elseif e < 104 then
                    if e <= 22 then
                        i = h[1][3]
                        i[h[2][3]][1] = d
                        c = nil
                        e = f ~= nil and 169 or 197 or 197
                    else
                        c = type
                        e = 104
                        i = h[1][3][h[2][3]]
                    end
                elseif e <= 104 then
                    c = c(i)
                    i = "table"
                    e = c == "table" and e + -82 or 12168 / e
                else
                    c = h[1][3]
                    i = h[2][3]
                    e, c[i] = e + 80, d
                end
            end
        end
    end,
    n = function(o, h)
        return function(z, B)
            local v = 241
            local _, c, n, r, m, a, d, b, e, t, p, C, A, g, s, x, w, y, u, l, q, i, j
            repeat
                if v >= 134 then
                    if v < 199 then
                        if v >= 161 then
                            if v <= 174 then
                                if v >= 172 then
                                    if v > 172 then
                                        a(_, C, d)
                                        C = "Frame"
                                        d = {}
                                        a = h[1][3]
                                        d.Name = "SubtabDivider"
                                        d.BackgroundColor3 = a.OutlineColor
                                        d.BorderSizePixel = 0
                                        v, b, e, l = 44022 / v, 33, UDim2.fromOffset, 7
                                    else
                                        _ = {[1] = 3, [3] = _}
                                        v, _[2] = 95, _
                                        d, C, _[3] = B[3], ipairs, o:Fb({
                                            B,
                                            p,
                                            h[1],
                                        })
                                    end
                                else
                                    v, C = 134, o.c(C(d))
                                end
                            elseif v > 176 then
                                d, v, C = B[3][1], 234 - v, _[3]
                            else
                                v, w = 352 / v, w(t, j, A)
                                b[3].Button = w
                                w = h[1][3]
                                A = {}
                                j = b[3].Button
                                A.BackgroundColor3 = "BackgroundColor"
                                g = "FontColor"
                                A.TextColor3 = "FontColor"
                                w, t = w.AddToRegistry, w
                            end
                        elseif v < 142 then
                            if v > 134 then
                                e, l = _(C, d)
                                d = e
                                v = e == nil and 23908 / v or 111 or 111
                            else
                                _, C, d = _(o.d(C))
                                _, C, d = o.b(_, C, d)
                                e, l = _(C, d)
                                d = e
                                v = e == nil and 306 - v or 111 or 111
                            end
                        elseif v > 153 then
                            b = {[1] = 3, [3] = b}
                            b[2] = b
                            w = h[1][3]
                            j = "TextButton"
                            A = {}
                            v, A.Text = 31200 / v, b[3].Name
                            A.Font = w.Font
                            A.TextSize = 14
                            A.AutoButtonColor = false
                            A.BackgroundColor3 = w.BackgroundColor
                            A.TextColor3 = w.FontColor
                            A.BorderSizePixel = 0
                            g = UDim2.fromOffset
                            u = math.max
                            c = w
                            y = b[3].Name
                            m = 80
                            r, s, n, c = c, w.Font, 14, c.GetTextBounds
                        elseif v > 142 then
                            v = v + -71
                            w(t, o.d(j))
                            w = h[1][3]
                            A = b[3].Button
                            g = o:Hb({
                                h[1],
                                _,
                                b,
                            })
                            j = A.MouseButton1Click
                            A, j = j, j.Connect
                        else
                            w(t, j, A)
                            w = h[1][3]
                            A = b[3].Button
                            g = o:Eb({b})
                            j = A.MouseEnter
                            v, A, j = 61, j, j.Connect
                        end
                    elseif v >= 231 then
                        if v >= 250 then
                            if v >= 251 then
                                if v > 251 then
                                    d.Position = e(l, b)
                                    v, l = v + -169, UDim2
                                    e, w, l, b = l.new, 0, 1, -14
                                    t = 1
                                else
                                    _(C, d, e)
                                    v = 161
                                    _ = ipairs
                                    d = q
                                    C = q.GetChildren
                                end
                            else
                                x = x(a, _, C)
                                d = {}
                                a = h[1][3]
                                C = "UIListLayout"
                                v = 120
                                d.FillDirection = Enum.FillDirection.Horizontal
                                d.SortOrder = Enum.SortOrder.LayoutOrder
                                b = 6
                                l = 0
                                e = UDim.new
                            end
                        elseif v <= 236 then
                            if v > 231 then
                                a = a(_, C, d)
                                e = {}
                                d = a
                                _ = h[1][3]
                                l = "OutlineColor"
                                v, e.BackgroundColor3 = 59236 / v, "OutlineColor"
                                _, C = _.AddToRegistry, _
                            else
                                i = i(q)
                                q = i.Parent.Parent
                                C = {}
                                x = h[1][3]
                                _ = "Frame"
                                v, d = v + -192, z .. "Subtabs"
                                C.Name = d
                                C.BackgroundTransparency = 1
                                l = 4
                                e = 7
                                d = UDim2.fromOffset
                            end
                        else
                            B = {[1] = 3, [3] = B}
                            B[2] = B
                            p = {[1] = 3, [3] = p}
                            p[2] = p
                            v, p[3] = 231, o:Ib()
                            x = B[3][1]
                            i = p[3]
                            q = x.Groups[1]
                        end
                    elseif v <= 203 then
                        if v > 200 then
                            j = o.c(j(A, g))
                            w, v, t = w.GiveSignal, 31059 / v, w
                        elseif v > 199 then
                            c = c(r, y, s, n)
                            r = 20
                            v, c = 0, c + 20
                        else
                            w = w(t, j, A)
                            b[3].Indicator = w
                            A = {}
                            g = "AccentColor"
                            j = b[3].Indicator
                            w = h[1][3]
                            A.BackgroundColor3 = "AccentColor"
                            v, w, t = v + -57, w.AddToRegistry, w
                        end
                    elseif v <= 214 then
                        A.Size = g(u, m, c, r)
                        A.Visible = false
                        A.ZIndex = 5
                        g = b[3].Button
                        A.Parent = g
                        v, t, w = v + -15, w, w.Create
                    else
                        w(t, o.d(j))
                        w, v, A = h[1][3], 425 - v, b[3].Button
                        g = o:Gb({b})
                        j = A.MouseLeave
                        A, j = j, j.Connect
                    end
                elseif v <= 82 then
                    if v >= 39 then
                        if v >= 61 then
                            if v >= 67 then
                                if v <= 67 then
                                    t = t(j, A)
                                    v = 139
                                    b = w - t
                                    l.Size = b
                                else
                                    v, j = 106, o.c(j(A, g))
                                    w, t = w.GiveSignal, w
                                end
                            else
                                v, j = 222, o.c(j(A, g))
                                t, w = w, w.GiveSignal
                            end
                        elseif v > 45 then
                            A.Size = g(u, m)
                            A.LayoutOrder = l
                            g = 4
                            A.ZIndex = 4
                            v, A.Parent = v + 122, x
                            t, w = w, w.Create
                        elseif v <= 39 then
                            v, d = 1755 / v, d(e, l)
                            C.Position = d
                            b = 0
                            d = UDim2.new
                            e = 1
                            l = -14
                            w = 30
                        else
                            C.Size = d(e, l, b, w)
                            d = 3
                            C.ZIndex = 3
                            v, C.Parent = 250, q
                            a, x = x, x.Create
                        end
                    elseif v <= 3 then
                        if v < 2 then
                            u = u(m, c)
                            v, m = v + 54, 30
                        elseif v <= 2 then
                            w(t, j, A)
                            j = "Frame"
                            w = h[1][3]
                            A = {
                                Name = "ActiveIndicator",
                                BackgroundColor3 = w.AccentColor,
                                BorderSizePixel = 0,
                            }
                            v, u = v + 1, Vector2
                            m, g, u = 1, u.new, 0
                        else
                            v, A.AnchorPoint = 327 / v, g(u, m)
                            m = 1
                            g = UDim2.fromScale
                            u = 0
                        end
                    elseif v <= 13 then
                        l, b = C(d, e)
                        e = l
                        v = l == nil and v + 183 or v + 143
                    else
                        C(d)
                        return
                    end
                elseif v >= 109 then
                    if v <= 120 then
                        if v >= 111 then
                            if v <= 111 then
                                v, w, b, t = 237 - v, l, l.IsA, "ScrollingFrame"
                            else
                                e = e(l, b)
                                v, d.Padding = 20880 / v, e
                                d.Parent = x
                                a, _ = a.Create, a
                            end
                        else
                            A.Position = g(u, m)
                            v, u = 23326 / v, UDim2
                            u, m, g = 1, 0, u.new
                            c = 0
                            r = 2
                        end
                    elseif v <= 126 then
                        b = b(w, t)
                        v = b and 127 or 139 or 139
                    else
                        w = l.Position
                        A = 36
                        v = 104
                        j = 0
                        t = UDim2.fromOffset
                    end
                elseif v > 104 then
                    v = 13
                    w(t, o.d(j))
                elseif v < 95 then
                    d.Size = e(l, b, w, t)
                    e = 3
                    d.ZIndex = 3
                    d.Parent = q
                    v, a, _ = v + 152, a.Create, a
                elseif v > 95 then
                    b = w + t(j, A)
                    l.Position = b
                    w, v, j = l.Size, 171 - v, UDim2
                    t, A, j = j.fromOffset, 36, 0
                else
                    C, d, e = C(d)
                    C, d, e = o.b(C, d, e)
                    l, b = C(d, e)
                    e = l
                    v = l == nil and 18620 / v or 156 or 156
                end
            until false
        end
    end,
    Tc = function(b, h)
        return function(l)
            local k = #l % 5
            if k > 0 then
                l = l .. ("~"):rep(5 - k)
            end
            local uc = b:Uc({
                h[2],
                h[4],
                h[3],
            })
            local c = h[1][3](l, ".....", uc)
            local i
            i, c = c, c.sub
            c = b.c(c(i, 1, k > 0 and -(5 - k) - 1 or -1))
            return b.d(c)
        end
    end,
    Fb = function(o, h)
        return function(n)
            local m = 222
            local l, b, c, p, e, f, g, a, r, d, i, k, q, _
            while true do
                if m <= 152 then
                    if m > 113 then
                        if m < 138 then
                            if m > 122 then
                                k, p, i = k(p)
                                k, p, i = o.b(k, p, i)
                                q, r = k(p, i)
                                i = q
                                m = q == nil and 32562 / m or 224 or 224
                            elseif m > 121 then
                                f = 0.3
                                m = g >= 0.3 and 51 or 260 - m
                            else
                                m = 57
                                f = "FontColor"
                            end
                        elseif m < 139 then
                            m = f and 57 or m + -17
                        elseif m <= 139 then
                            e, l = _(f, d)
                            d = e
                            m = e == nil and 29329 / m or 201 - m
                        else
                            q, r = k(p, i)
                            i = q
                            m = q == nil and 395 - m or m + 72
                        end
                    elseif m < 62 then
                        if m < 51 then
                            if m <= 31 then
                                f = a
                                m = a and 192 or 4278 / m
                            else
                                m = 31
                                _ = "BackgroundColor"
                            end
                        elseif m <= 51 then
                            _.TextTransparency = f
                            _ = ipairs
                            m = 240
                            f = r.Groups
                        else
                            l = h[3][3]
                            e = l[_]
                            r.Button.BackgroundColor3 = e
                            r.Button.TextColor3 = l[f]
                            b, l = r.Button, l.RegistryMap
                            m = 152
                            l[b].Properties.BackgroundColor3 = _
                            b = h[3][3]
                            b, l = r.Button, b.RegistryMap
                            d = l[b].Properties
                            d.TextColor3 = f
                        end
                    elseif m > 112 then
                        m, f = 176 - m, 1
                    elseif m <= 63 then
                        if m > 62 then
                            _.BackgroundTransparency = f
                            f = a
                            _ = r.Button
                            m = a and 11403 / m or 154 or 154
                        else
                            c = l
                            m = 217
                            b = h[2][3]
                        end
                    else
                        m = 167
                        _ = "MainColor"
                    end
                elseif m <= 217 then
                    if m >= 181 then
                        if m > 211 then
                            m, b = 139, b(c)
                            b.Visible = a
                        elseif m <= 192 then
                            if m > 181 then
                                m, f = 330 - m, "AccentColor"
                            else
                                m, f = 335 - m, 0
                            end
                        else
                            _ = a
                            m = a and 323 - m or 167 or 167
                        end
                    elseif m >= 167 then
                        if m > 167 then
                            m = f and m + -109 or 113 or 113
                        else
                            m = _ and 5177 / m or 44 or 44
                        end
                    else
                        m = f and 51 or 122 or 122
                    end
                elseif m > 240 then
                    if m > 243 then
                        m = 172
                        f = 0
                    end
                elseif m < 224 then
                    m = 134
                    g = 134
                    p = h[1][3]
                    k = ipairs
                elseif m <= 224 then
                    a = r == n
                    r.Active = a
                    r.Indicator.Visible = a
                    f = a
                    _ = r.Button
                    m = a and 254 or 396 - m
                else
                    _, f, d = _(f)
                    _, f, d = o.b(_, f, d)
                    e, l = _(f, d)
                    d = e
                    m = e == nil and m + -29 or 62 or 62
                end
            end
        end
    end,
    G = function(b, h)
        return function(enabled)
            local e = 70
            local f, a
            while true do
                if e > 70 then
                    a = h[3][3]
                    f = h[2][3]
                    e, f.ColorShift_Top = 154 - e, a.ColorShift_Top
                    f.ColorShift_Bottom = a.ColorShift_Bottom
                elseif e > 53 then
                    h[1][3].colorShift.enabled = enabled
                    e = not enabled and 101 or 53 or 53
                else
                    return
                end
            end
        end
    end,
    Ea = function(b, _)
        return function(maxDistance)
            _[1][3].sharedSettings.maxDistance = maxDistance
        end
    end,
    cb = function(o, Y)
        return function(z, O, p)
            local v = 173
            local V, R, na, ca, ea, T, P, oa, C, sa, va, Q, e, worldToViewportPoint, l, ba, da, _a, F, U, M, g, q, ma, la, fa, qa, j, ja, i, I, a, J, u, H, X, B, ga, y, r, K, ra, E, b, pa, _, W, f, N, ha, aa, ta, ia, L, D, d, n, ua, m, k, ka, w, x, h, c
            repeat
                if v > 210 then
                    if v > 545 then
                        if v >= 734 then
                            if v <= 886 then
                                if v < 804 then
                                    if v <= 752 then
                                        if v <= 749 then
                                            if v <= 748 then
                                                if v > 734 then
                                                    D, v, W = Vector2, v + -449, D(ja, ha)
                                                    ja, D, y = ea.Y, pa, D.new
                                                else
                                                    y = y(D, ja)
                                                    v = ga < R and v + -726 or v + -607
                                                end
                                            else
                                                ja = ja(ha)
                                                ha, ja, ra, v, u = ja, ja.sub, 1, 714, 6
                                            end
                                        else
                                            worldToViewportPoint, j = worldToViewportPoint(j, Q)
                                            Q = not j
                                            v = Q and 253 or 842 - v
                                        end
                                    elseif v < 775 then
                                        v, ba = v + -551, ba(L)
                                        J = not ba
                                    elseif v <= 775 then
                                        v = 141
                                        D(ja, ha, ra, u, C, va, na)
                                    else
                                        aa(qa, fa, ma, oa, W, y, D, ja)
                                        v = f < D and 944 - v or 215 or 215
                                    end
                                elseif v <= 845 then
                                    if v >= 832 then
                                        if v < 839 then
                                            oa = "players"
                                            ma = _a == "players"
                                            v = ma and 273 or 1543 - v
                                        elseif v <= 839 then
                                            x = x(J)
                                            _a = not x
                                            v = _a and 947 - v or v + -592
                                        else
                                            y = "distance"
                                            W = z
                                            oa = Y[13][3]
                                            ha, ja, v, D = L, "%.0f studs", 450385 / v, string.format
                                        end
                                    elseif v <= 804 then
                                        oa = x.distance
                                        v = oa and v + 41 or 1090 - v
                                    else
                                        u = u(C, va)
                                        v = 775
                                        na = ua
                                        C = e.skeletonColor
                                        va = 1
                                    end
                                elseif v >= 866 then
                                    if v > 866 then
                                        v, W = 477, W(y)
                                        oa, ma, W = O, O.WorldToViewportPoint, W + b
                                    else
                                        v, ea = 72744 / v, ea(m, M)
                                        g = ea
                                    end
                                else
                                    W = P.Y
                                    y = 0.5
                                    v = 144
                                    oa = W * 0.5
                                end
                            elseif v < 957 then
                                if v <= 917 then
                                    if v <= 912 then
                                        if v >= 906 then
                                            if v > 906 then
                                                v, D = 606, D(ja)
                                                ja = Vector2.new
                                                ra = ma
                                                ha = pa
                                            else
                                                fa = fa(ma, oa, W)
                                                ma = x.healthBar
                                                v = ma and 963 - v or 224688 / v
                                            end
                                        else
                                            v, ja = 397, ja(ha, ra)
                                            ra = x.nameOutline
                                            ha = x.nameColor
                                            u = ua
                                        end
                                    else
                                        oa = i.Zombie
                                        v = oa and v + -736 or 324 or 324
                                    end
                                elseif v <= 939 then
                                    if v > 918 then
                                        M, r = M(r, pa, aa)
                                        v, pa = 403770 / v, {}
                                        aa, pa, m = Y[7][3], ipairs, pa
                                    else
                                        W, y = W(y, D)
                                        ha = 0.05
                                        ja = ma.Z
                                        D = ja > 0.05
                                        v = D and 162 or 0 or 0
                                    end
                                else
                                    ja = ja(ha, ra)
                                    ha = x.boxOutline
                                    v = ha and v + -323 or 984 or 984
                                end
                            elseif v >= 984 then
                                if v >= 1005 then
                                    if v <= 1005 then
                                        v = 458
                                        oa = 0
                                    else
                                        ha = ha(ra, u, C)
                                        v, ra = 1681 - v, 2
                                    end
                                elseif v <= 984 then
                                    ha = Y[12][3]
                                    ra = z
                                    v = 732
                                    u = "edge" .. ma
                                    va = ja
                                    na = x.box3dColor
                                    la = ua
                                    T = 1
                                    C = D
                                else
                                    W = "players"
                                    oa = _a == "players"
                                    v = oa and 137 or 1311 - v
                                end
                            elseif v > 960 then
                                v, ja = 1014, ja(ha, ra)
                                u = x.healthyColor
                                C = fa
                                ha = x.dyingColor
                                ha, ra = ha.Lerp, ha
                            elseif v <= 957 then
                                ma = ma(oa, W)
                                oa = x.healthBarOutline
                                v = oa and 206 or 25 or 25
                            else
                                aa, qa, fa = aa(qa)
                                aa, qa, fa = o.b(aa, qa, fa)
                                ma, oa = aa(qa, fa)
                                fa = ma
                                v = ma == nil and 67 or 191 or 191
                            end
                        elseif v <= 648 then
                            if v < 592 then
                                if v < 561 then
                                    if v <= 556 then
                                        if v <= 550 then
                                            v, y = 147, y(D, ja)
                                        else
                                            v = v + -507
                                            D(ja, ha, ra, u, C, va, na)
                                        end
                                    else
                                        oa, y, W, ha, v, D = Y[13][3], "name", z, Vector2, 504218 / v, ma
                                        ha, u, C, ja = pa, g.Y, ka.textSize, ha.new
                                        u, ra = 3, u - C
                                        ra = ra - 3
                                    end
                                elseif v < 581 then
                                    if v <= 561 then
                                        i(_a)
                                        i = z.actor
                                        v = 839
                                        J = i
                                        x = Y[10][3].Refresh
                                    else
                                        g = g(ea, m)
                                        ea = g.Magnitude
                                        m = 0.0001
                                        v = ea < 0.0001 and 123170 / v or 101 or 101
                                    end
                                elseif v > 581 then
                                    v, ja = 712, ja(ha, ra)
                                    u = ua
                                    ha = x.distanceColor
                                    ra = x.distanceOutline
                                else
                                    y = "Top"
                                    W = x.tracerOrigin
                                    oa = W == "Top"
                                    v = oa and 1005 or 458 or 458
                                end
                            elseif v >= 629 then
                                if v <= 643 then
                                    if v <= 636 then
                                        if v <= 629 then
                                            ha = Y[12][3]
                                            ra = z
                                            C = D
                                            va = ja
                                            na = x.boxOutlineColor
                                            u = "edgeOutline" .. ma
                                            v = 418
                                            la = 2 * x.boxOutlineThickness
                                            T = 1 + la
                                        else
                                            W = x.tracerOrigin
                                            y = "Middle"
                                            oa = W == "Middle"
                                            v = oa and 847 or 144 or 144
                                        end
                                    else
                                        ja = ja(ha, ra)
                                        v = 460
                                        ha = Y[8][3]
                                        ra = 4
                                    end
                                else
                                    v, oa = 638928 / v, z.model
                                    ma = oa.Name
                                end
                            elseif v > 608 then
                                v, ja = v + 29, ja(ha, ra)
                                D = ma + ja
                                ja = Vector2.new
                                ha = g.X - 5
                                u = 1
                                ra = g.Y - 1
                            elseif v >= 606 then
                                if v <= 606 then
                                    ja = ja(ha, ra)
                                    ra = x.weaponOutline
                                    v = 592
                                    ha = x.weaponColor
                                    u = ua
                                else
                                    v = 117
                                    aa(qa, fa, ma, oa, W, y, D, ja)
                                end
                            else
                                oa(W, y, D, ja, ha, ra, u)
                                W = ka.textSize
                                y = 2
                                v = 804
                                oa = W + 2
                                ma = ma + oa
                            end
                        elseif v >= 688 then
                            if v < 712 then
                                if v <= 702 then
                                    if v <= 688 then
                                        v = 232
                                        oa = "NPC"
                                    else
                                        v, oa = v + -539, x.weapon
                                    end
                                else
                                    v = ma and 986 or 460728 / v
                                end
                            elseif v < 726 then
                                if v > 712 then
                                    v, ja = 559, ja(ha, ra, u)
                                    ha = "]"
                                    D = ja .. "]"
                                    W = y .. D
                                    ma = oa .. W
                                else
                                    oa(W, y, D, ja, ha, ra, u)
                                    v = ca < V and v + 133 or 998 - v
                                end
                            elseif v <= 726 then
                                v = 109
                                aa(qa, fa, ma, oa, W, y, D)
                            else
                                v = v + -594
                                ha(ra, u, C, va, na, T, la)
                            end
                        elseif v > 665 then
                            if v >= 672 then
                                if v > 672 then
                                    v = 31
                                    ma(oa, W, y, D, ja, ha)
                                else
                                    Q = Q(g, ea)
                                    v = 565
                                    m = Q.Z
                                    g = Vector2.new
                                    ea = Q.X
                                end
                            else
                                v = 248
                                oa(W, y, D, ja, ha, ra)
                            end
                        elseif v >= 664 then
                            if v > 664 then
                                v, D = 685, D(ja, ha)
                                ja = x.healthTextColor
                                ha = x.healthTextOutline
                            else
                                oa = i.DisplayName
                                v = oa and 274 or 241032 / v
                            end
                        elseif v <= 659 then
                            D, ha = ha(ra, u), Vector2
                            v, ha, ra, ja = v + 293, y.X, y.Y, ha.new
                        else
                            v, oa = 115014 / v, P.Y
                        end
                    elseif v > 323 then
                        if v <= 418 then
                            if v <= 363 then
                                if v <= 347 then
                                    if v < 338 then
                                        if v > 324 then
                                            v = oa and 338 or 282 or 282
                                        else
                                            v = oa and 232 or 688 or 688
                                        end
                                    elseif v >= 341 then
                                        if v <= 341 then
                                            oa = oa(W, y)
                                            m[fa] = oa
                                            y = 0.05
                                            W = oa.Z
                                            v = W > 0.05 and 22 or 535 - v
                                        else
                                            ma = ea.Y + 2
                                            W = "players"
                                            oa = _a == "players"
                                            v = oa and v + 355 or 163 or 163
                                        end
                                    else
                                        v, oa = v + 221, i.Owner
                                        ma = oa.DisplayName
                                    end
                                elseif v < 352 then
                                    v, aa = v + -156, aa(qa, fa, ma)
                                    aa.PointA = M
                                    aa.PointB = r + pa
                                    aa.PointC = r - pa
                                    aa.Filled = true
                                    fa = aa
                                    oa = ua
                                    ma = x.offScreenArrowColor
                                    qa = Y[6][3]
                                elseif v > 352 then
                                    W = i.OwnerName
                                    y = "???"
                                    oa = W ~= "???"
                                    v = oa and 386 or 274 or 274
                                else
                                    W = W(y, D)
                                    y = g
                                    v = g and 77 or 499 - v
                                end
                            elseif v <= 394 then
                                if v > 386 then
                                    v = 39400 / v
                                    r(pa, aa, qa, fa, ma)
                                elseif v < 379 then
                                    v, fa = v + 126, fa(ma, oa)
                                    ma = 0.5
                                    qa, fa = fa * 0.5, x.offScreenArrowSize
                                    aa, qa = qa - fa, 4
                                    aa = aa - 4
                                elseif v <= 379 then
                                    v, ua = 27, ua(b)
                                else
                                    v, oa = 105764 / v, i.OwnerName
                                end
                            elseif v > 399 then
                                v = 984
                                ha(ra, u, C, va, na, T)
                            elseif v <= 397 then
                                v = 744 - v
                                oa(W, y, D, ja, ha, ra, u)
                            else
                                L = L(ka)
                                ka = "Vector3"
                                v = L ~= "Vector3" and 13566 / v or v + -249
                            end
                        elseif v < 477 then
                            if v < 434 then
                                if v >= 430 then
                                    if v > 430 then
                                        v = 189
                                        D(ja, ha, ra, u, C, va)
                                    else
                                        pa, aa, qa = pa(aa)
                                        pa, aa, qa = o.b(pa, aa, qa)
                                        fa, ma = pa(aa, qa)
                                        qa = fa
                                        v = fa == nil and 246 or 78 or 78
                                    end
                                else
                                    v, oa = 749, oa(W)
                                    ja = tostring
                                    y = " ["
                                    ha = i.UID
                                end
                            elseif v <= 458 then
                                if v > 452 then
                                    v = oa and 174 or 636 or 636
                                elseif v <= 434 then
                                    ja = z
                                    D = Y[12][3]
                                    ha = "bone" .. qa
                                    u = ma.X
                                    ra = Vector2.new
                                    v = 520
                                    C = ma.Y
                                else
                                    ma, oa, v, W = aa / oa(W, y), 0, 906, 1
                                end
                            else
                                v = 485 - v
                                oa(W, y, D, ja, ha, ra)
                            end
                        elseif v < 514 then
                            if v <= 492 then
                                if v <= 477 then
                                    v = 980 - v
                                    ma, oa = ma(oa, W)
                                    ja = fa[2]
                                    D = Y[11][3]
                                else
                                    v, r = 285, o.c(r(pa, aa))
                                end
                            else
                                D, y, v, W = D(ja) + b, O, 918, O.WorldToViewportPoint
                            end
                        elseif v < 533 then
                            if v > 514 then
                                ra = ra(u, C)
                                u = Vector2.new
                                va = W.Y
                                v = 827
                                C = W.X
                            else
                                y, oa, W, v, ja = "weapon", Y[13][3], z, 468768 / v, Y[10][3]
                                D, ja = ja.Weapon, i
                            end
                        elseif v <= 533 then
                            v, D = 582, D(ja, ha)
                            ja = Vector2.new
                            ra = ma
                            ha = pa
                        else
                            D = y
                            v = h <= ia and 176 or v + -404
                        end
                    elseif v <= 246 then
                        if v < 231 then
                            if v > 220 then
                                if v > 226 then
                                    v = Q and 127 or 359 - v
                                elseif v <= 225 then
                                    v = J and 35 or 167 or 167
                                else
                                    v, L = 289 - v, i.Owner
                                    ka = Y[5][3]
                                    ba = L.Team
                                    L = ka.Team
                                    J = ba == L
                                end
                            elseif v < 218 then
                                if v > 213 then
                                    aa = x.box
                                    v = aa and 112 or 25155 / v
                                else
                                    v = 172
                                    ba = J.Position
                                end
                            elseif v < 219 then
                                M, m, v, ea = 1, 0, 188788 / v, Vector2.new
                            elseif v > 219 then
                                pa = 0
                                v = 89
                                r = ea.Y
                                M = r >= 0
                            else
                                v = 71
                                oa = fa[2]
                                ma = oa.Parent
                            end
                        elseif v >= 239 then
                            if v < 244 then
                                if v <= 239 then
                                    v = 351
                                    qa, aa = 0.5, qa(fa, ma) * x.offScreenArrowSize
                                    aa, ma, pa, qa, fa = Y[3][3], "Triangle", aa * 0.5, z, "arrow"
                                else
                                    Q = x.box
                                    v = Q and 20 or 120 or 120
                                end
                            elseif v > 244 then
                                M = g
                                v = g and 259 - v or 192 or 192
                            else
                                qa = z
                                W = x.boxOutlineColor
                                ma = g
                                y = false
                                oa = r
                                fa = "boxOutline"
                                ha = 2
                                aa = Y[4][3]
                                ra = x.boxOutlineThickness
                                v = 726
                                ja = 2 * ra
                                D = 1 + ja
                            end
                        elseif v < 233 then
                            if v > 231 then
                                v, ma, oa = 97672 / v, oa, tostring
                                W = ma
                            else
                                return
                            end
                        elseif v <= 233 then
                            v = J and v + -2 or 74 or 74
                        else
                            r = M
                            v = X >= ta and v + -94 or 42 or 42
                        end
                    elseif v < 274 then
                        if v < 252 then
                            if v <= 248 then
                                if v > 247 then
                                    ma = x.healthText
                                    v = ma and 313 - v or 279 - v
                                else
                                    v, x = 79781 / v, Y[10][3]
                                    x, _a = i, x.Kind
                                end
                            else
                                v = b and 69 or 83 or 83
                            end
                        elseif v >= 255 then
                            if v > 255 then
                                oa = i.Owner
                                ma = oa.Name
                                v = F >= n and 711 or 105 or 105
                            else
                                v, Q = 13260 / v, x.boxFill
                            end
                        elseif v > 252 then
                            v = 90
                            Q = x.offScreenArrow
                        else
                            qa = Y[2][3]
                            v = 960
                            aa = ipairs
                        end
                    elseif v <= 286 then
                        if v > 285 then
                            oa = x.tracer
                            v = oa and 867 - v or 335 - v
                        elseif v <= 282 then
                            if v > 274 then
                                oa = e.nameType
                                W = "Display Name"
                                v = oa == "Display Name" and 946 - v or v + 277
                            else
                                v = oa and 232 or 917 or 917
                            end
                        else
                            m = m(M, o.d(r))
                            v, r = 524 - v, g * m
                            aa = x.offScreenArrowSize
                            M = ea + r
                            pa = g * aa
                            r = M - pa
                            ma = g.Y
                            qa = Vector2.new
                            ma, fa = g.X, -ma
                        end
                    elseif v >= 306 then
                        if v > 306 then
                            _a = _a(x)
                            x = not _a
                            v = x and 14212 / v or 12 or 12
                        else
                            r, pa, aa = r(pa)
                            r, pa, aa = o.b(r, pa, aa)
                            qa, fa = r(pa, aa)
                            aa = qa
                            v = qa == nil and 193 or 42840 / v
                        end
                    else
                        y = y(D, ja)
                        D = x.tracerOutline
                        v = D and v + -114 or 189 or 189
                    end
                elseif v >= 108 then
                    if v < 156 then
                        if v >= 133 then
                            if v > 144 then
                                if v > 150 then
                                    if v >= 152 then
                                        if v <= 152 then
                                            ba = i.Alive
                                            L = false
                                            J = ba == false
                                            v = B < k and v + -3 or 36784 / v
                                        else
                                            L = 0
                                            v, J = v + 79, ba <= 0
                                        end
                                    else
                                        v = 194
                                        ea = y
                                    end
                                elseif v >= 149 then
                                    if v > 149 then
                                        L = (ba - p).Magnitude
                                        ka = Y[10][3].sharedSettings
                                        e = ka.limitDistance
                                        v = e and 310 - v or 336 - v
                                    else
                                        v = J and v + 84 or v + -13
                                    end
                                elseif v > 145 then
                                    v = y and v + 9 or 11 or 11
                                else
                                    y = y(D)
                                    D = Vector2.new
                                    ja = g.X - 20
                                    ra = ea.Y
                                    u = r.Y * fa
                                    C, u, v, ha = 0.5, ka.textSize, 810 - v, ra - u
                                    ra = u * 0.5
                                    ha = ha - ra
                                end
                            elseif v <= 140 then
                                if v >= 137 then
                                    if v > 138 then
                                        oa = fa[1]
                                        ma = oa.Parent
                                        v = ma and v + 79 or 71 or 71
                                    elseif v <= 137 then
                                        y = "Display Name"
                                        W = e.nameType
                                        oa = W == "Display Name"
                                        v = a >= K and v + 499 or v + 188
                                    else
                                        ma, oa = aa(qa, fa)
                                        fa = ma
                                        v = ma == nil and 9246 / v or 329 - v
                                    end
                                elseif v > 133 then
                                    ba = i.Health
                                    v = ba and 154 or 116 or 116
                                else
                                    r = j
                                    v = j and v + -91 or 236 or 236
                                end
                            elseif v > 142 then
                                v = oa and 174 or v + 517
                            elseif v <= 141 then
                                qa, fa = r(pa, aa)
                                aa = qa
                                v = qa == nil and 193 or 281 - v
                            else
                                M = Y[9][3]
                                v = 939
                                r = z
                                pa = b
                                aa = ba
                            end
                        elseif v < 117 then
                            if v <= 111 then
                                if v >= 110 then
                                    if v <= 110 then
                                        Q = x.healthBar
                                        v = I > _ and 195 - v or 12100 / v
                                    else
                                        ja = y.Z
                                        ha = 0.05
                                        v = 128
                                        D = ja > 0.05
                                    end
                                elseif v > 108 then
                                    ma = g
                                    D = 1
                                    qa = z
                                    v = 608
                                    ja = ua
                                    fa = "box"
                                    oa = r
                                    aa = Y[4][3]
                                    W = x.boxColor
                                    y = false
                                else
                                    return
                                end
                            elseif v > 113 then
                                ba = 0
                                v = E >= 0 and 17864 / v or 232 - v
                            elseif v > 112 then
                                v = M and 333 - v or 89 or 89
                            else
                                aa = x.boxOutline
                                v = aa and 244 or 12208 / v
                            end
                        elseif v >= 127 then
                            if v <= 129 then
                                if v >= 128 then
                                    if v <= 128 then
                                        v = D and 104 or v + 10
                                    else
                                        Q = x.tracer
                                        v = sa >= U and 20 or 127 or 127
                                    end
                                else
                                    ea = nil
                                    g = nil
                                    m = nil
                                    v = Q and 18034 / v or 246 or 246
                                end
                            else
                                v = M and 7260 / v or 133 or 133
                            end
                        elseif v >= 120 then
                            if v > 120 then
                                Q = x.weapon
                                v = N < q and 55 or v + -84
                            else
                                Q = x.box3d
                                v = da <= d and v + -49 or 20 or 20
                            end
                        elseif v <= 117 then
                            aa = x.box3d
                            v = aa and v + 135 or 67 or 67
                        else
                            v = 379
                            ua = Y[10][3].TeamColor
                            b = i
                        end
                    elseif v >= 183 then
                        if v < 193 then
                            if v <= 189 then
                                if v > 186 then
                                    ra = W
                                    v = 556
                                    D = Y[12][3]
                                    ja = z
                                    C = x.tracerColor
                                    na = ua
                                    va = 1
                                    u = y
                                    ha = "tracer"
                                elseif v <= 185 then
                                    if v > 183 then
                                        C, D, va, v, ja, ra, ha, u = Y[8][3], Y[12][3], 3, 618 - v, z, W, "tracerOutline", y
                                    else
                                        v, J = 215 - v, x.teamCheck
                                    end
                                else
                                    v = e and v + -140 or v + -165
                                end
                            elseif v > 191 then
                                v = M and 382 - v or 21696 / v
                            elseif v <= 190 then
                                v = 113
                                r = ea.X
                                pa = 0
                                M = r >= 0
                            else
                                D = oa[1]
                                D, W = oa[2], m[D]
                                ja = W.Z
                                ha = 0.05
                                y = m[D]
                                D = ja > 0.05
                                v = D and 111 or 128 or 128
                            end
                        elseif v >= 201 then
                            if v <= 206 then
                                if v <= 205 then
                                    if v <= 201 then
                                        pa, aa, fa, qa, v, ma, r = z, O, ba, b, 79194 / v, ua, Y[14][3]
                                    else
                                        v = J and 225 or v + -154
                                    end
                                else
                                    v = 614
                                    oa = Y[12][3]
                                    W = z
                                    y = "hpOutline"
                                    ha = 0
                                    ra = 1
                                    ja = Vector2.new
                                end
                            else
                                v = Q and 85 or 23100 / v
                            end
                        elseif v < 195 then
                            if v > 193 then
                                fa, ma = pa(aa, qa)
                                qa = fa
                                v = fa == nil and 246 or 78 or 78
                            else
                                return
                            end
                        elseif v > 195 then
                            h = 97
                            ia = 154
                            v = Q and 236 - v or 123 or 123
                        else
                            v = 287 - v
                            qa(fa, ma, oa)
                        end
                    elseif v <= 167 then
                        if v > 162 then
                            if v > 164 then
                                L = z.model
                                ba = L.Parent
                                v = 35
                                J = not ba
                            elseif v > 163 then
                                Q = x.healthText
                                v = w >= l and 226 or 230 or 230
                            else
                                v = oa and v + 351 or 967 - v
                            end
                        elseif v <= 159 then
                            if v >= 158 then
                                if v > 158 then
                                    D, fa, ma, aa, oa, qa, W, v, ja, y = 1, "fill", g, Y[4][3], r, z, x.boxFillColor, 956 - v, ua, true
                                else
                                    return
                                end
                            else
                                g, y = y, ea
                                v = y and 180 or 8 or 8
                            end
                        elseif v <= 160 then
                            ua = ka.maxDistance
                            v, e = v + 26, L > ua
                        else
                            v, ha, ja = v + -162, 0.05, W.Z
                            D = ja > 0.05
                        end
                    elseif v > 176 then
                        if v < 180 then
                            D = oa
                            v = oa and v + -1 or v + 368
                        elseif v > 180 then
                            v, oa = 58644 / v, "Zombie"
                        else
                            ja, D, v, y = W, ea, 132120 / v, ea.Max
                        end
                    elseif v >= 174 then
                        if v <= 174 then
                            v = 748
                            ra = 0.5
                            D = Vector2.new
                            ja = P.X * 0.5
                            ha = oa
                        else
                            v = D and 434 or v + -35
                        end
                    elseif v > 172 then
                        i = Y[1][3]
                        v = 561
                        _a = z
                    else
                        v = 399
                        ka = ba
                        L = typeof
                    end
                elseif v < 52 then
                    if v >= 29 then
                        if v >= 42 then
                            if v > 48 then
                                if v >= 50 then
                                    if v > 50 then
                                        ba, v, L = i.Character, 276 - v, z.model
                                        J = ba ~= L
                                    else
                                        fa = ea.X
                                        r = ea - g
                                        qa = 0.5
                                        aa = g.X + fa
                                        aa, pa = x.boxFill, aa * 0.5
                                        v = aa and v + 109 or 265 - v
                                    end
                                else
                                    r = e.skeleton
                                    v = r and 98 or 193 or 193
                                end
                            elseif v > 44 then
                                if v > 46 then
                                    _ = 44
                                    I = 54
                                    v = J and 226 or 63 or 63
                                end
                            elseif v <= 43 then
                                if v <= 42 then
                                    v = r and 243 - v or 100 or 100
                                else
                                    return
                                end
                            else
                                return
                            end
                        elseif v >= 34 then
                            if v <= 36 then
                                if v <= 35 then
                                    if v > 34 then
                                        v = J and 5215 / v or 5320 / v
                                    end
                                else
                                    v, L, ba = v + 720, i, Y[10][3].Kind
                                end
                            else
                                v = Q and 210 or 5 or 5
                            end
                        elseif v > 31 then
                            l = 237
                            B = 89
                            w = 137
                            U = 159
                            k = 232
                            sa = 36
                            v = J and 2592 / v or 80 - v
                        elseif v > 29 then
                            ma = x.name
                            v = ma and v + 801 or 378 - v
                        else
                            Q, v, ea = O.CFrame, v + 643, ba
                            g, Q = Q, Q.PointToObjectSpace
                        end
                    elseif v < 20 then
                        if v > 11 then
                            if v >= 13 then
                                if v <= 13 then
                                    v = 192
                                    M = ea
                                else
                                    v, ua = v + 55, nil
                                end
                            else
                                N = 171
                                q = 141
                                E = 214
                                x = Y[10][3].teamSettings[_a]
                                ba = "players"
                                J = _a == "players"
                                v = J and 195 - v or v + 20
                            end
                        elseif v <= 8 then
                            if v <= 5 then
                                if v > 0 then
                                    v, Q = 215 - v, x.distance
                                else
                                    v = D and v + 177 or 176 - v
                                end
                            else
                                v = y and 151 or v + 94
                            end
                        else
                            v, y = 1716 / v, W
                        end
                    elseif v >= 24 then
                        if v >= 26 then
                            if v > 26 then
                                v = ua and 70 or 15 or 15
                            else
                                v = 197
                                Q = x.name
                            end
                        elseif v > 24 then
                            oa = Y[12][3]
                            y = "hp"
                            W = z
                            D = ma
                            v, ra, u, ja = 999 - v, g.X, 5, Vector2.new
                            ha, ra, C = ra - 5, ea.Y, r.Y
                            u = C * fa
                            ra = ra - u
                        else
                            v = 886
                            W = Y[11][3]
                            y = fa[1]
                        end
                    elseif v <= 21 then
                        if v <= 20 then
                            ta = 224
                            X = 53
                            v = Q and 1040 / v or 275 - v
                        else
                            b = Y[10][3]
                            ua = b.advanced
                            ua, e = ka.teamBasedColor, ua[_a]
                            v = ua and 2499 / v or 48 - v
                        end
                    else
                        v, W, D, y = 7744 / v, Vector2.new, oa.Y, oa.X
                    end
                elseif v >= 81 then
                    if v < 92 then
                        if v <= 85 then
                            if v < 84 then
                                if v > 81 then
                                    P = Vector3
                                    v = 69
                                    b = Vector3.zero
                                else
                                    ba = Y[5][3].Team
                                    L = nil
                                    v, J = 3888 / v, ba ~= nil
                                end
                            elseif v > 84 then
                                c = 1
                                H = 242
                                v = Q and 230 or v + 79
                            else
                                ea = P * 0.5
                                M = x.offScreenArrowRadius
                                m = math.min
                                r = math.max
                                pa = 0
                                fa, v, oa, ma = math.min, v + 282, P.Y, P.X
                            end
                        elseif v <= 90 then
                            if v <= 89 then
                                v = M and 91 or 221 - v
                            else
                                ga = 85
                                R = 230
                                v = Q and 29 or 8280 / v
                            end
                        else
                            pa, v, r = P.X, 223 - v, g.X
                            M = r <= pa
                        end
                    elseif v > 101 then
                        if v >= 104 then
                            if v > 104 then
                                K = 147
                                a = 64
                                ma = math
                                fa = math.clamp
                                v = 452
                                y = qa
                                W = 1
                                oa = math.max
                            else
                                u = W.Y
                                v = 659
                                ra = W.X
                                ha = Vector2.new
                            end
                        else
                            v, y = 253 - v, W
                        end
                    elseif v <= 99 then
                        if v > 98 then
                            ca = 117
                            ba = x.enabled
                            V = 21
                            J = not ba
                            v = J and 20295 / v or 135 - v
                        elseif v > 92 then
                            v = 306
                            r = ipairs
                            pa = z.links
                        else
                            g = 0.05
                            Q = worldToViewportPoint.Z
                            v = Q <= 0.05 and 43 or v + 150
                        end
                    elseif v > 100 then
                        v, g = 84, g.Unit
                    else
                        v = M and 5000 / v or 49 or 49
                    end
                elseif v <= 67 then
                    if v >= 57 then
                        if v <= 65 then
                            if v >= 63 then
                                if v > 63 then
                                    ma = Y[13][3]
                                    W = "hpText"
                                    oa = z
                                    v = 145
                                    y = math.ceil
                                    D = aa
                                else
                                    v = J and 158 or 6237 / v
                                end
                            else
                                ma = Vector2.new
                                y = 5
                                v = 957
                                oa = g.X - 5
                                W = ea.Y
                            end
                        else
                            aa = i.Health
                            qa = i.MaxHealth
                            v = qa and v + 38 or v + -11
                        end
                    elseif v <= 55 then
                        if v >= 53 then
                            if v > 53 then
                                pa = P.Y
                                r = g.Y
                                M = r <= pa
                                v = c >= H and 122 - v or 7315 / v
                            else
                                ba = J
                                v = J and 266 - v or 9116 / v
                            end
                        else
                            f = 141
                            n = 51
                            F = 87
                            v = Q and 197 or 26 or 26
                        end
                    else
                        v = 105
                        qa = 100
                    end
                elseif v > 73 then
                    if v <= 77 then
                        if v > 74 then
                            v = 550
                            D = g
                            ja = W
                            y = g.Min
                        else
                            da = 97
                            J = i.RootPart
                            ba = i.Position
                            d = 78
                            v = ba and 172 or v + -21
                        end
                    else
                        ja = 0.5
                        D = r * 0.5
                        oa, v, W, y = O.WorldToViewportPoint, 419 - v, O, M + D * ma
                    end
                elseif v < 71 then
                    if v <= 69 then
                        worldToViewportPoint, v, P, j, Q = O.WorldToViewportPoint, 51888 / v, O.ViewportSize, O, ba
                    else
                        b = J
                        v = J and 73 or 251 or 251
                    end
                elseif v <= 71 then
                    v = ma and 24 or 141 or 141
                else
                    P = J.Position
                    v = 251
                    b = ba - P
                end
            until false
        end
    end,
    ra = function(b, h)
        return function(d)
            local e = 32
            local g, _, c, i, f
            while true do
                if e >= 102 then
                    if e > 173 then
                        if e <= 193 then
                            e, f = 173, f(c, i)
                        else
                            i = "TextButton"
                            e = 193
                            f = d.IsA
                            c = d
                        end
                    elseif e >= 108 then
                        if e > 108 then
                            e = f and e + -71 or 108 or 108
                        else
                            c, f, e, i = d, d.IsA, 189 - e, "TextBox"
                        end
                    else
                        g = 194
                        _ = 53
                        e = f and e + -52 or 9894 / e
                    end
                elseif e >= 81 then
                    if e < 96 then
                        e, f = 102, f(c, i)
                    elseif e > 96 then
                        return
                    else
                        f = f(c, i)
                        e = f and 173 or 203 or 203
                    end
                elseif e > 32 then
                    c = h[1][3]
                    f = c.Face
                    d.FontFace = f
                    e = g > _ and 97 or 102 or 102
                else
                    f = d.IsA
                    c = d
                    e = 96
                    i = "TextLabel"
                end
            end
        end
    end,
    Qc = function(b)
        local a = string
        local d, f
        f, d, a = a.byte, a.char, bit32
        local bxor2 = a.bxor
        d = {[1] = 3, [3] = d}
        d[2] = d
        f = {[1] = 3, [3] = f}
        f[2] = f
        bxor2 = {[1] = 3, [3] = bxor2}
        bxor2[2] = bxor2
        return b:Rc({d, bxor2, f})
    end,
    f = function(o)
        return function(...)
            local v = 223
            local X, f, z, y, m, G, E, Q, r, Na, J, P, la, ma, S, Oa, fa, l, Ea, Ua, ya, ta, F, I, ba, Wa, b, La, i, ga, R, A, e, W, da, _, c, Aa, T, q, Ga, Ta, h, ia, k, ha, g, C, Ca, ua, Y, V, L, N, Ra, B, ka, x, Ja, ca, a, Sa, O, qa, sa, va, xa, ea, s, p, Ma, Pa, Fa, Ba, u, w, n, wa, na, M, t, Ha, za, Qa, aa, ja, Da, U, j, ra, Ia, D, H, K, oa, pa, _a, d
            repeat
                if v <= 222 then
                    if v <= 123 then
                        if v > 70 then
                            if v > 94 then
                                if v < 115 then
                                    if v <= 109 then
                                        if v < 103 then
                                            if v > 100 then
                                                ha(ra, u)
                                                u = {
                                                    Text = "Bullet Drop Compensation",
                                                    Flag = "sd_bullet_drop",
                                                    Default = true,
                                                }
                                                C = o:za({fa})
                                                u.Callback = C
                                                v = 109
                                                ra = ja
                                                ha = ja.AddToggle
                                            else
                                                W = {
                                                    [1] = 3,
                                                    [3] = W(),
                                                }
                                                W[2] = W
                                                y = Enum.RaycastFilterType.Exclude
                                                W[3].FilterType = y
                                                W[3].IgnoreWater = true
                                                y = o:ia({Da, W})
                                                ma[3].Clear = y
                                                y = o:P()
                                                ma[3].AimPoint = y
                                                y = o:J({pa, fa, ma, Ia})
                                                ma[3].Select = y
                                                y = o:ea({ma, fa})
                                                ma[3].Direction = y
                                                y = o:z()
                                                v, ma[3].FindFunction = v + 25, y
                                                y = o:Va({ma})
                                                ma[3].Hook = y
                                                y = o:Ja({ma, fa, pa})
                                                ma[3].Install = y
                                                y = o:pa({ma})
                                                ma[3].Destroy = y
                                                ja = {Title = "Silent Aim"}
                                                ha = "Left"
                                                ja.Side = "Left"
                                                D = m
                                                y = m.AddSection
                                            end
                                        elseif v > 103 then
                                            ha(ra, u)
                                            v, C, u = v + 60, "FOV", {}
                                            u.Title = "FOV"
                                            C = "Left"
                                            u.Side = "Left"
                                            ha = m.AddSection
                                            ra = m
                                        else
                                            Pa = 62
                                            Ta = 115
                                            v = _a and 163 or 6901 / v
                                        end
                                    elseif v <= 112 then
                                        _a = _a()
                                        x = type
                                        i = _a.STATE
                                        v = 79
                                        J = i
                                    else
                                        xa(q, Na)
                                        Na = {Text = "NPCs Without Team", Flag = "esp_neutral_color"}
                                        v = 64
                                        w = C[3].sharedSettings
                                        Na.Default = w.neutralColor
                                        _ = o:Pa({C})
                                        Na.Callback = _
                                        xa = da.AddColorPicker
                                        q = da
                                    end
                                elseif v > 118 then
                                    if v >= 122 then
                                        if v > 122 then
                                            A = "TextLabel"
                                            R = N.IsA
                                            E = N
                                            v = 512
                                            I = 130
                                            sa = 156
                                        else
                                            D(ja, ha)
                                            ha = {Text = "Max Distance", Flag = "sd_distance"}
                                            v, ra = v + -104, 50
                                            ha.Min = 50
                                            ha.Max = 5000
                                            ha.Default = 1000
                                            ha.Rounding = 1
                                            ha.Suffix = " studs"
                                            ra = o:ma({fa})
                                            ha.Callback = ra
                                            D = y.AddSlider
                                            ja = y
                                        end
                                    else
                                        C()
                                        T = "Silent Aim"
                                        Ga = {Title = "Silent Aim"}
                                        S = u
                                        v = 205
                                        la = "Adapter failed: "
                                        Ha = tostring
                                    end
                                elseif v > 117 then
                                    Ca = Ca(da, d)
                                    xa = {Text = "ESP Enabled", Flag = "players_enabled", Default = false}
                                    v = 186
                                    q = o:F({C})
                                    xa.Callback = q
                                    d = Ca
                                    da = Ca.AddToggle
                                elseif v >= 116 then
                                    if v <= 116 then
                                        X, ta, U[3] = {}, "Fog End", c(H, X)
                                        X.Text = "Fog End"
                                        X.Flag = "wm_fog_end"
                                        X.Min = 0
                                        v, X.Max = v + 35, 10000
                                        X.Rounding = 0
                                        X.Default = 1000
                                        ta = o:Ba({w})
                                        X.Callback = ta
                                        H = l
                                        c = l.AddSlider
                                    else
                                        v = 335
                                        qa = ColorSequence.new
                                        za = A
                                    end
                                else
                                    wa = #A + 1
                                    v = 972
                                    Fa = ColorSequenceKeypoint.new
                                    na = qa / 6
                                    Wa = Color3.fromHSV
                                    Aa = 1
                                    Ra = 0.75
                                    M = qa / 6
                                end
                            elseif v <= 85 then
                                if v <= 79 then
                                    if v >= 74 then
                                        if v <= 75 then
                                            if v <= 74 then
                                                k(Ca, da)
                                                v = 10
                                                k = o:K({C, va, la, T, Ga})
                                                Ca = k
                                                d = "npc"
                                                da = Ha
                                            else
                                                z = z(O, p)
                                                v = z and 15975 / v or 45 or 45
                                            end
                                        else
                                            x = x(J)
                                            J = "table"
                                            _a = x == "table"
                                            v = _a and 266 - v or 103 or 103
                                        end
                                    elseif v <= 72 then
                                        na = p[3].WatermarkText
                                        Fa = p[3].RegistryMap
                                        wa = Fa[na]
                                        wa, v, aa = o:Na(), v + -12, wa.Properties
                                        aa.TextColor3 = wa
                                    else
                                        ua(Ja, o.d(P))
                                        ua = o:n({p})
                                        P = {}
                                        Ja = {[1] = 3, [3] = P}
                                        Ja[2] = Ja
                                        P = {[1] = 3, [3] = P}
                                        P[2] = P
                                        Q, P[3] = {}, o:o({Ja, p})
                                        t, Q = Q, {}
                                        t = {[1] = 3, [3] = t}
                                        t[2] = t
                                        j = {[1] = 3, [3] = Q}
                                        j[2] = j
                                        Q = {[1] = 3, [3] = Q}
                                        Q[2] = Q
                                        Q[3], Ea = o:y(), {}
                                        Ma = {[1] = 3, [3] = Ea}
                                        Ma[2] = Ma
                                        Ea = o:ba({t, e, P, Ja, j, x, Q, p})
                                        Ma[3].AddTab = Ea
                                        Ea = o:Da()
                                        p[3].Connect = Ea
                                        Ea = {
                                            [1] = 3,
                                            [3] = p[3].Notify,
                                        }
                                        Ea[2] = Ea
                                        m = o:ha({Ea})
                                        p[3].Notify = m
                                        r = {}
                                        v, r.Text = 138, "Combat"
                                        Da = {}
                                        Ba = "Silent Aim"
                                        Da[1] = "Silent Aim"
                                        pa = Da
                                        r.Pages = Da
                                        Ia = Ma[3]
                                        m = Ma[3].AddTab
                                    end
                                elseif v <= 82 then
                                    if v > 80 then
                                        va, v, C = u, 20172 / v, tostring
                                    else
                                        ka.Face = e(ua)
                                        ka.Cache = {}
                                        ka.Version = 0
                                        ua = {}
                                        r = "Proggy Clean"
                                        Ma = "Ubuntu"
                                        m = "Minecraftia"
                                        Ia = "Verdana"
                                        ua[1], ua[2], ua[3], ua[4], ua[5], ua[6], ua[7], ua[8], ua[9], ua[10] = "Code", "Arial", "Gotham", "Source Sans", "Roboto Mono", "Ubuntu", "Tahoma", "Minecraftia", "Verdana", "Proggy Clean"
                                        ka.Names = ua
                                        ka.Builtins = {
                                            Code = Enum.Font.Code,
                                            Arial = Enum.Font.Arial,
                                            Gotham = Enum.Font.Gotham,
                                            ["Source Sans"] = Enum.Font.SourceSans,
                                            ["Roboto Mono"] = Enum.Font.RobotoMono,
                                            Ubuntu = Enum.Font.Ubuntu,
                                        }
                                        ua = {
                                            Tahoma = "Tahoma-Modern.ttf",
                                            Minecraftia = "Minecraftia-Regular.ttf",
                                            Verdana = "Verdana-Font.ttf",
                                            ["Proggy Clean"] = "ProggyClean.ttf",
                                        }
                                        v, ka.Files = 227, ua
                                        L = {[1] = 3, [3] = ka}
                                        L[2] = L
                                        ka = o:B({L})
                                        L[3].Resolve = ka
                                        ka = o:ra({L})
                                        L[3].Apply = ka
                                        ka = o:h({L, p})
                                        L[3].SetUI = ka
                                        ka = {
                                            [1] = 3,
                                            [3] = p[3].Create,
                                        }
                                        ka[2] = ka
                                        e = o:_a({ka, L})
                                        p[3].Create = e
                                        Ja = {Title = "San Diego", Center = true, AutoShow = true}
                                        j = 660
                                        t = 568
                                        P = UDim2.fromOffset
                                    end
                                else
                                    p = assert
                                    x = "LinoriaLib.luau"
                                    v = 127
                                    i = loadstring
                                    _a = z
                                end
                            elseif v < 91 then
                                if v > 89 then
                                    ea = {[1] = 3, [3] = ea}
                                    ea[2] = ea
                                    v, ea[3] = v + 793, o:l({Qa, Ma, G})
                                    N = {[1] = 3, [3] = N}
                                    N[2] = N
                                    N[3] = o:w({Qa, Ma, G})
                                    R = {[1] = 3, [3] = R}
                                    R[2] = R
                                    A, R[3], E = j[3], o:U({Qa, Ma, G}), pairs
                                elseif v > 88 then
                                    v, p = 144, p(o.d(i))
                                else
                                    A = Ma[3].Items
                                    v = 145
                                    E = A.SubTitleLabel
                                end
                            elseif v < 92 then
                                v, C = 157, o.c(C(va, Ga))
                            elseif v > 92 then
                                B = B(k, Ca)
                                da = {Text = "ESP Enabled", Flag = "npc_enabled"}
                                v = 74
                                da.Default = true
                                d = o:p({C})
                                da.Callback = d
                                Ca = B
                                k = B.AddToggle
                            else
                                U(ga, ya)
                                ya = {
                                    Text = "World Time",
                                    Flag = "wm_time_value",
                                    Min = 0,
                                    Max = 24,
                                    Rounding = 1,
                                    Default = 14,
                                }
                                c = o:H({w})
                                v, ya.Callback = v + 132, c
                                ga = l
                                U = l.AddSlider
                            end
                        elseif v < 38 then
                            if v <= 22 then
                                if v >= 9 then
                                    if v < 18 then
                                        if v > 9 then
                                            Ca(da, d)
                                            d = {Title = "General"}
                                            xa = "Left"
                                            d.Side = "Left"
                                            Ca, v, da = S.AddSection, v + 108, S
                                        else
                                            v, p, i = 263 - v, O.Unload, O
                                        end
                                    elseif v > 18 then
                                        v = v + 153
                                        Ua(U, ga)
                                        ga = {Text = "Custom Color Shift", Flag = "wm_colorshift", Default = false}
                                        ya = o:G({w, xa, _})
                                        ga.Callback = ya
                                        Ua = l.AddToggle
                                        U = l
                                    else
                                        D(ja, ha)
                                        ha = {Title = "Checks"}
                                        ra = "Right"
                                        ha.Side = "Right"
                                        v, ja, D = 2916 / v, m, m.AddSection
                                    end
                                elseif v >= 6 then
                                    if v <= 6 then
                                        Wa = aa[1]
                                        v, Fa, na = v + 162, #Wa.Groups, 0
                                        wa = Fa > 0
                                    else
                                        v, J = 234, J(o.d(ba))
                                    end
                                elseif v <= 2 then
                                    v, K = v + 241, N
                                else
                                    v = R and v + -1 or 63 or 63
                                end
                            elseif v > 31 then
                                if v > 32 then
                                    v = 58
                                    ja(ha, ra)
                                    ra = {Text = "Visible Check", Flag = "sd_visible_check", Default = true}
                                    u = o:Ga({fa})
                                    ra.Callback = u
                                    ha = D
                                    ja = D.AddToggle
                                else
                                    i = O.Unloaded
                                    v, p = v + 150, not i
                                end
                            elseif v >= 29 then
                                if v <= 29 then
                                    v, N, ea = 392 - v, o:Wa({Ma}), pcall
                                else
                                    v = 166 - v
                                    C(va, Ga)
                                end
                            elseif v > 24 then
                                v = 6214 / v
                                Ua(U, ga)
                                ga = {Text = "Color Shift Bottom", Flag = "wm_colorshift_bottom"}
                                c = w[3].colorShift
                                ga.Default = c.bottom
                                ya = o:v({w})
                                ga.Callback = ya
                                U = l
                                Ua = l.AddColorPicker
                            else
                                ja = ja(ha, ra)
                                v, u, C = 2424 / v, {}, "Auto Prediction"
                                u.Text = "Auto Prediction"
                                u.Flag = "sd_prediction"
                                u.Default = true
                                C = o:Ra({fa})
                                u.Callback = C
                                ha = ja.AddToggle
                                ra = ja
                            end
                        elseif v > 58 then
                            if v > 64 then
                                if v >= 67 then
                                    if v <= 67 then
                                        v = 155
                                        J = getgenv
                                    else
                                        A = "Lean v1.0 beta | San Diego Roleplay | "
                                        E = N.Text
                                        R = E == "Lean v1.0 beta | San Diego Roleplay | "
                                        v = I >= sa and 253 or v + -67
                                    end
                                else
                                    v, c = v + 632, c(H, X)
                                    c, X, H, ya[3] = Na[3], false, U[3], c
                                end
                            elseif v < 63 then
                                if v > 60 then
                                    v = 737
                                    E = "TitleWaveGradient"
                                else
                                    v = 920
                                    aa = p[3].KeybindFrame
                                    na = 16
                                    Fa = 0
                                    Wa = 0.5
                                    wa = UDim2.new
                                    M = 0
                                end
                            elseif v > 63 then
                                xa(q, Na)
                                Na = {
                                    Text = "Box Outline Thickness",
                                    Flag = "npc_box_outline_thickness",
                                    Min = 1,
                                }
                                v, Na.Max = 240 - v, 5
                                Na.Default = 1
                                Na.Suffix = "px"
                                _ = o:ua({C})
                                Na.Callback = _
                                q = da
                                xa = da.AddSlider
                            else
                                ea, N = ca(Qa, G)
                                G = ea
                                v = ea == nil and 243 or 123 or 123
                            end
                        elseif v <= 46 then
                            if v >= 42 then
                                if v >= 45 then
                                    if v <= 45 then
                                        v = 188
                                        O = "LinoriaLib.luau"
                                        z = readfile
                                    else
                                        Ia = {
                                            [1] = 3,
                                            [3] = Ia(r, pa),
                                        }
                                        Ia[2] = Ia
                                        r, v, Da = game, v + 93, "RunService"
                                        pa, r = r, r.GetService
                                    end
                                else
                                    xa(q, Na)
                                    Na = {Text = "Team Based Color", Flag = "esp_team_based_color"}
                                    v, Na.Default = 4746 / v, false
                                    _ = o:x({C})
                                    Na.Callback = _
                                    q = da
                                    xa = da.AddToggle
                                end
                            elseif v <= 38 then
                                da = da(d, xa)
                                q = {Text = "Text Size", Flag = "esp_text_size", Min = 8}
                                v, q.Max = 165, 24
                                _ = C[3].sharedSettings
                                q.Default = _.textSize
                                Na = o:ya({C})
                                q.Callback = Na
                                xa = da
                                d = da.AddSlider
                            else
                                ja(ha, ra)
                                ra = {Title = "Prediction"}
                                u = "Right"
                                ra.Side = "Right"
                                ja = m.AddSection
                                v = 24
                                ha = m
                            end
                        elseif v > 56 then
                            ja(ha, ra)
                            ra = {Text = "Hitscan", Flag = "sd_hitscan", Default = false}
                            u = o:Qa({fa})
                            v, ra.Callback = 2378 / v, u
                            ja = D.AddToggle
                            ha = D
                        elseif v <= 51 then
                            x = x(J)
                            J = "function"
                            v, _a = v + 52, x == "function"
                        else
                            O = p().LinoriaMenuLibrary
                            p = O
                            v = O and 88 - v or 182 or 182
                        end
                    elseif v < 169 then
                        if v < 144 then
                            if v > 135 then
                                if v < 139 then
                                    if v > 137 then
                                        m = m(Ia, r)
                                        pa = "Players"
                                        v = 46
                                        Ia = game
                                        r, Ia = Ia, Ia.GetService
                                    elseif v > 136 then
                                        v, ba = 146, ba(o.d(L))
                                    else
                                        l = l(Ua, U)
                                        ga = {Text = "Custom Ambient", Flag = "wm_ambient", Default = false}
                                        v, ya = 29920 / v, o:fa({w, xa, _})
                                        ga.Callback = ya
                                        Ua = l.AddToggle
                                        U = l
                                    end
                                elseif v <= 141 then
                                    if v > 139 then
                                        Wa(M, Ra)
                                        v, Wa, M, Ra = v + 446, J.SetLibrary, J, p[3]
                                    else
                                        r = {
                                            [1] = 3,
                                            [3] = r(pa, Da),
                                        }
                                        r[2] = r
                                        v, Ba, pa = 388 - v, "UserInputService", game
                                        pa, Da = pa.GetService, pa
                                    end
                                else
                                    ra = ra(u)
                                    ma[3].circle = ra
                                    ma[3].circle.Filled = false
                                    ma[3].circle.Thickness = 1
                                    ma[3].circle.Transparency = 1
                                    u = ma[3].connections
                                    Ga = o:ga({ma, pa, fa})
                                    ra = table.insert
                                    C = r[3].RenderStepped
                                    C, v, va = C.Connect, 91, C
                                end
                            elseif v > 130 then
                                if v >= 132 then
                                    if v > 132 then
                                        v, C = 33750 / v, o:j({Ia, Da, r})
                                    else
                                        q = q(Na, _)
                                        Na = {[1] = 3, [3] = Na}
                                        Na[2] = Na
                                        l, w, Na[3] = xa[3].Ambient, {}, o:N()
                                        w.Ambient = l
                                        w.OutdoorAmbient = xa[3].OutdoorAmbient
                                        w.ColorShift_Top = xa[3].ColorShift_Top
                                        w.ColorShift_Bottom = xa[3].ColorShift_Bottom
                                        w.ClockTime = xa[3].ClockTime
                                        w.FogStart = xa[3].FogStart
                                        w.FogEnd = xa[3].FogEnd
                                        w.FogColor = xa[3].FogColor
                                        w.Brightness = xa[3].Brightness
                                        w.ExposureCompensation = xa[3].ExposureCompensation
                                        w.EnvironmentDiffuseScale = xa[3].EnvironmentDiffuseScale
                                        w.EnvironmentSpecularScale = xa[3].EnvironmentSpecularScale
                                        w.GlobalShadows = xa[3].GlobalShadows
                                        w.ShadowSoftness = xa[3].ShadowSoftness
                                        _ = {[1] = 3, [3] = w}
                                        _[2] = _
                                        U = {}
                                        l = {}
                                        U.enabled = false
                                        U.a = xa[3].Ambient
                                        U.b = xa[3].OutdoorAmbient
                                        l.ambient = U
                                        l.colorShift = {
                                            enabled = false,
                                            top = xa[3].ColorShift_Top,
                                            bottom = xa[3].ColorShift_Bottom,
                                        }
                                        l.time = {
                                            enabled = false,
                                            value = xa[3].ClockTime,
                                        }
                                        l.fog = {
                                            enabled = false,
                                            s = xa[3].FogStart,
                                            e = xa[3].FogEnd,
                                            color = xa[3].FogColor,
                                        }
                                        U = {
                                            enabled = false,
                                            brightness = xa[3].Brightness,
                                            exposure = xa[3].ExposureCompensation,
                                            diffuse = xa[3].EnvironmentDiffuseScale,
                                        }
                                        v = 241
                                        U.specular = xa[3].EnvironmentSpecularScale
                                        l.light = U
                                        l.shadows = {
                                            enabled = false,
                                            softness = xa[3].ShadowSoftness,
                                            tech = "ShadowMap",
                                        }
                                        w = {[1] = 3, [3] = l}
                                        w[2] = w
                                        Ua = p[3]
                                        ga = o:va({w, xa})
                                        l = p[3].Connect
                                        U = r[3].RenderStepped
                                    end
                                else
                                    Ha, S, Oa = Ha(S, Oa)
                                    Ca = {Title = "General"}
                                    v = 94
                                    da = "Left"
                                    Ca.Side = "Left"
                                    k = Ha
                                    B = Ha.AddSection
                                end
                            elseif v <= 128 then
                                if v <= 127 then
                                    if v <= 125 then
                                        v, y = 355 - v, y(D, ja)
                                        ha = {Text = "Enabled", Flag = "sd_silent_enabled", Default = false}
                                        ra = o:R({fa})
                                        ha.Callback = ra
                                        D = y.AddToggle
                                        ja = y
                                    else
                                        v, i = 89, o.c(i(_a, x))
                                    end
                                else
                                    c(H, X)
                                    X = {
                                        Text = "Fog Start",
                                        Flag = "wm_fog_start",
                                        Min = 0,
                                        Max = 5000,
                                        Rounding = 0,
                                        Default = 0,
                                    }
                                    v = 116
                                    ta = o:ka({w})
                                    X.Callback = ta
                                    c = l.AddSlider
                                    H = l
                                end
                            else
                                v, x = 359 - v, J().Options
                                _a = {[1] = 3, [3] = _a}
                                _a[2] = _a
                                x = {[1] = 3, [3] = x}
                                x[2] = x
                                ka = "https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/ThemeManager.lua"
                                ba = game
                                J = loadstring
                                L, ba = ba, ba.HttpGet
                            end
                        elseif v <= 155 then
                            if v > 150 then
                                if v >= 153 then
                                    if v <= 153 then
                                        xa = {
                                            [1] = 3,
                                            [3] = xa(q, Na),
                                        }
                                        v, xa[2] = 285 - v, xa
                                        _ = {Text = "Visuals"}
                                        l = {}
                                        Ua = "World Modulation"
                                        l[1] = "World Modulation"
                                        w = l
                                        _.Pages = l
                                        Na = Ma[3]
                                        q = Ma[3].AddTab
                                    else
                                        J, v, _a = getgenv, 130, J().Toggles
                                    end
                                else
                                    ga[3], X, ta = c(H, X), {}, "Fog Color"
                                    X.Text = "Fog Color"
                                    X.Flag = "wm_fog_color"
                                    f = w[3].fog
                                    v, X.Default = 65, f.color
                                    ta = o:Ca({w})
                                    X.Callback = ta
                                    H = l
                                    c = l.AddColorPicker
                                end
                            elseif v > 146 then
                                if v > 149 then
                                    Fa, wa, v, na = za, ua, 1135 - v, aa
                                else
                                    U(ga, ya)
                                    U = {[1] = 3, [3] = nil}
                                    U[2] = U
                                    ga = {[1] = 3, [3] = nil}
                                    ga[2] = ga
                                    ya = {[1] = 3, [3] = nil}
                                    ya[2] = ya
                                    X = {Text = "Custom Fog", Flag = "wm_fog", Default = false}
                                    ta = o:S({w, Na, ga, xa, U, ya, _})
                                    X.Callback = ta
                                    H, v, c = l, 277 - v, l.AddToggle
                                end
                            elseif v < 145 then
                                p = {
                                    [1] = 3,
                                    [3] = p(),
                                }
                                v, p[2] = v + 34, p
                                i = getgenv
                            elseif v <= 145 then
                                v, A = 114695 / v, "SubWaveGradient"
                            else
                                ba = ba()
                                e = {}
                                P = {}
                                L = J.BuiltInThemes
                                P.FontColor = "E0E0E0"
                                P.MainColor = "191919"
                                P.BackgroundColor = "121212"
                                P.AccentColor = "BEBEBE"
                                t = "313131"
                                P.OutlineColor = "313131"
                                Ja = P
                                e[1], e[2] = 0, P
                                L.Clean = e
                                L = "Clean"
                                v, J.DefaultTheme = 226 - v, "Clean"
                                ka = {UIName = "Code"}
                                e = Font.fromEnum
                                ua = p[3].Font
                            end
                        elseif v >= 163 then
                            if v <= 165 then
                                if v > 163 then
                                    d(xa, q)
                                    xa = {UI = 0}
                                    v = 211
                                    xa.System = 1
                                    xa.Plex = 2
                                    xa.Monospace = 3
                                    d = {[1] = 3, [3] = xa}
                                    d[2] = d
                                    Na = {Text = "Font", Flag = "esp_text_font"}
                                    U = "Plex"
                                    l = "UI"
                                    Ua = "System"
                                    w = {}
                                    ga = "Monospace"
                                    w[1], w[2], w[3], w[4] = "UI", "System", "Plex", "Monospace"
                                    Na.Options = w
                                    Na.Default = "Plex"
                                    _ = o:i({C, d})
                                    Na.Callback = _
                                    q = da
                                    xa = da.AddDropdown
                                else
                                    v = 207
                                    _a = i.onCleanup
                                    x = o:da({p})
                                end
                            else
                                v = wa and 318 - v or 42504 / v
                            end
                        elseif v <= 161 then
                            if v > 157 then
                                ma.FOVColor = oa(W, y, D)
                                ma.MaxDistance = 1000
                                ma.HitChance = 100
                                fa = {[1] = 3, [3] = ma}
                                v, fa[2] = 225, fa
                                oa = {
                                    Silent = fa[3],
                                    active = true,
                                    connections = {},
                                    hooks = {},
                                }
                                W = setmetatable
                                ja = "k"
                                y = {}
                                D = {__mode = "k"}
                            else
                                v = 38936 / v
                                ra(u, o.d(C))
                                ra = pcall
                                u = ma[3].Install
                            end
                        else
                            v, D = 33, D(ja, ha)
                            ra = {Text = "Team Check", Flag = "sd_team_check", Default = true}
                            u = o:s({fa})
                            ra.Callback = u
                            ha = D
                            ja = D.AddToggle
                        end
                    elseif v < 195 then
                        if v >= 179 then
                            if v > 186 then
                                if v < 188 then
                                    x = type
                                    v = 51
                                    J = i.onCleanup
                                elseif v <= 188 then
                                    v, z = 213, z(O)
                                else
                                    D(ja, ha)
                                    ha = {
                                        Text = "Hit Chance",
                                        Flag = "sd_hit_chance",
                                        Min = 0,
                                        Max = 100,
                                        Default = 100,
                                    }
                                    v, ra = v + -68, 1
                                    ha.Rounding = 1
                                    ha.Suffix = "%"
                                    ra = o:Ka({fa})
                                    ha.Callback = ra
                                    ja = y
                                    D = y.AddSlider
                                end
                            elseif v < 184 then
                                if v <= 179 then
                                    ra(u, C)
                                    C = {Text = "Show FOV"}
                                    v, C.Flag = 251, "sd_show_fov"
                                    C.Default = true
                                    va = o:Sa({fa})
                                    C.Callback = va
                                    ra = ha.AddToggle
                                    u = ha
                                else
                                    v = p and 9 or 267 - v
                                end
                            elseif v > 184 then
                                da(d, xa)
                                xa = {Text = "Team Check", Flag = "players_team_check", Default = false}
                                v = 198
                                q = o:Q({C})
                                xa.Callback = q
                                d = Ca
                                da = Ca.AddToggle
                            else
                                E = Ma[3].Items
                                v, R = v + -122, E.TitleLabel
                            end
                        elseif v < 175 then
                            if v <= 170 then
                                if v <= 169 then
                                    ha = ha(ra, u)
                                    C = {
                                        Text = "Radius",
                                        Flag = "sd_fov",
                                        Min = 10,
                                        Max = 600,
                                        Default = 120,
                                        Rounding = 1,
                                        Suffix = " px",
                                    }
                                    va = o:Fa({fa})
                                    C.Callback = va
                                    ra = ha.AddSlider
                                    v = 179
                                    u = ha
                                else
                                    xa(q, Na)
                                    Na = {
                                        Text = "Max Distance",
                                        Flag = "esp_max_distance",
                                        Min = 50,
                                        Max = 2000,
                                    }
                                    w = C[3].sharedSettings
                                    v, Na.Default = v + -128, w.maxDistance
                                    Na.Suffix = " studs"
                                    _ = o:Ea({C})
                                    Na.Callback = _
                                    q = da
                                    xa = da.AddSlider
                                end
                            else
                                qa = qa + aa
                                v = aa > 0 and 566 - v or 918 - v
                            end
                        elseif v >= 177 then
                            if v <= 177 then
                                e = {
                                    [1] = 3,
                                    [3] = e(ua, Ja),
                                }
                                v, e[2] = 235, e
                                ua = e[3].Holder
                                P = "ScreenGui"
                                ua, Ja = ua.FindFirstAncestorWhichIsA, ua
                            else
                                v, i = 112, i()
                                i.LinoriaMenuLibrary = p[3]
                                _a = getfenv
                            end
                        elseif v <= 175 then
                            Ua(U, ga)
                            ga = {Text = "Color Shift Top", Flag = "wm_colorshift_top"}
                            c = w[3].colorShift
                            ga.Default = c.top
                            ya = o:A({w})
                            ga.Callback = ya
                            v, U, Ua = 4550 / v, l, l.AddColorPicker
                        else
                            xa(q, Na)
                            ma[3].ESP = C[3]
                            v = 153
                            xa = game
                            Na = "Lighting"
                            xa, q = xa.GetService, xa
                        end
                    elseif v < 211 then
                        if v > 205 then
                            if v > 209 then
                                v, L = 137, o.c(L(ka, e))
                            elseif v <= 207 then
                                _a(x)
                                v = Pa > Ta and 90 or 67 or 67
                            else
                                v, E, za = v + 48, t[3]["UI Settings"], "Menu"
                                A = E.AddLeftGroupbox
                                qa = E
                            end
                        elseif v < 201 then
                            if v <= 195 then
                                h(ia, F)
                                v = 212
                                F = false
                                h = Na[3]
                                ia = X[3]
                            else
                                da(d, xa)
                                da = k
                                xa = "players"
                                v = 226
                                d = S
                            end
                        elseif v > 201 then
                            Ha = Ha(S)
                            Ga.Description = la .. Ha
                            T = 8
                            v, Ga.Lifetime = 6355 / v, 8
                            C = p[3].Notify
                            va = p[3]
                        else
                            Ua(U, ga)
                            ga = {Text = "Outdoor Ambient", Flag = "wm_ambient_b"}
                            c = w[3].ambient
                            v = 22
                            ga.Default = c.b
                            ya = o:u({w})
                            ga.Callback = ya
                            U = l
                            Ua = l.AddColorPicker
                        end
                    elseif v < 216 then
                        if v >= 212 then
                            if v > 212 then
                                v = 56
                                p = getgenv
                            else
                                v = 109816 / v
                                h(ia, F)
                                F = false
                                h = Na[3]
                                ia = ta[3]
                            end
                        else
                            xa(q, Na)
                            v, _, Na = 35870 / v, "Limit Distance", {}
                            Na.Text = "Limit Distance"
                            Na.Flag = "esp_limit_distance"
                            w = C[3].sharedSettings
                            Na.Default = w.limitDistance
                            _ = o:D({C})
                            Na.Callback = _
                            q = da
                            xa = da.AddToggle
                        end
                    elseif v > 220 then
                        oa().LinoriaSanDiegoCombat = ma[3]
                        oa = {[1] = 3, [3] = nil}
                        oa[2] = oa
                        W = o:Oa({pa, oa})
                        ma[3].KeyActive = W
                        W = o:La({Da, Ia, Ba, fa})
                        ma[3].Allowed = W
                        y = RaycastParams
                        v, W = 22200 / v, RaycastParams.new
                    elseif v >= 217 then
                        if v > 217 then
                            Ua(U, ga)
                            ga = {}
                            v, ga.Text = 421 - v, "Ambient"
                            ga.Flag = "wm_ambient_a"
                            c = w[3].ambient
                            ga.Default = c.a
                            ya = o:g({w})
                            ga.Callback = ya
                            U = l
                            Ua = l.AddColorPicker
                        else
                            ra(u, C)
                            v = 143
                            u = "Circle"
                            ra = Drawing.new
                        end
                    else
                        La = La(a, K)
                        ca = {Title = "Teams"}
                        Qa = "Left"
                        v, ca.Side = 593, "Left"
                        a = La.AddSection
                        K = La
                    end
                elseif v <= 518 then
                    if v < 286 then
                        if v > 243 then
                            if v <= 254 then
                                if v >= 250 then
                                    if v < 253 then
                                        if v <= 250 then
                                            v, C = v + -119, C()
                                            C = {[1] = 3, [3] = C}
                                            C[2] = C
                                            Ga = C[3].advanced
                                            va = {
                                                [1] = 3,
                                                [3] = C[3].chams,
                                            }
                                            va[2] = va
                                            Ga = {[1] = 3, [3] = Ga}
                                            Ga[2] = Ga
                                            T = {[1] = 3, [3] = T}
                                            T[2] = T
                                            T[3] = o:ja()
                                            la = {[1] = 3, [3] = la}
                                            la[2] = la
                                            la[3], B, k = o:C(), {}, "Esp"
                                            B.Text = "Esp"
                                            Ca = {}
                                            d = "Players"
                                            xa = "Settings"
                                            da = "NPCs"
                                            Ca[1], Ca[2], Ca[3] = "NPCs", "Players", "Settings"
                                            k = Ca
                                            B.Pages = Ca
                                            S = Ma[3]
                                            Ha = Ma[3].AddTab
                                            Oa = B
                                        else
                                            ra(u, C)
                                            C = {Text = "Color", Flag = "sd_fov_color"}
                                            v, C.Default = 217, fa[3].FOVColor
                                            va = o:Ta({fa})
                                            C.Callback = va
                                            u = ha
                                            ra = ha.AddColorPicker
                                        end
                                    elseif v <= 253 then
                                        za, aa = E(A, qa)
                                        qa = za
                                        v = za == nil and 462 - v or 242 or 242
                                    else
                                        v = 85
                                        p(i)
                                    end
                                elseif v < 248 then
                                    v, C = v + -127, C(va)
                                    ma[3].hookState = C
                                    C = ma[3].Destroy
                                elseif v <= 248 then
                                    ra, u = ra(u)
                                    C = not ra
                                    v = C and 82 or 135 or 135
                                else
                                    pa = {
                                        [1] = 3,
                                        [3] = pa(Da, Ba),
                                    }
                                    pa[2] = pa
                                    Da = {
                                        [1] = 3,
                                        [3] = Ia[3].LocalPlayer,
                                    }
                                    Da[2] = Da
                                    fa = {
                                        teams = {},
                                    }
                                    v, ma = 410 - v, true
                                    fa.silent = true
                                    fa.trigger = true
                                    fa._added = {}
                                    Ba = {[1] = 3, [3] = fa}
                                    Ba[2] = Ba
                                    ma = {
                                        Enabled = false,
                                        TeamCheck = true,
                                        VisibleCheck = true,
                                        Hitscan = false,
                                        Prediction = true,
                                        BulletDrop = true,
                                        HitPart = "Head",
                                        FOV = 120,
                                        ShowFOV = true,
                                    }
                                    y = 80
                                    oa = Color3.fromRGB
                                    D = 255
                                    W = 150
                                end
                            elseif v >= 262 then
                                if v > 270 then
                                    v = 798
                                    c(H, X)
                                    X = {Title = "Lighting"}
                                    ta = "Right"
                                    X.Side = "Right"
                                    H = q
                                    c = q.AddSection
                                elseif v > 262 then
                                    qa = qa(za, aa)
                                    wa = "ui_font"
                                    Fa = {}
                                    v, Fa.Text = 934 - v, "UI Font"
                                    Fa.Values = L[3].Names
                                    na = "Code"
                                    Fa.Default = "Code"
                                    aa = qa
                                    za = qa.AddDropdown
                                else
                                    v = v + 602
                                    Ra(Aa)
                                    Ra = C[3].Load
                                end
                            elseif v >= 257 then
                                if v > 257 then
                                    La, ta[3], F = "Environment Specular", h(ia, F), {}
                                    F.Text = "Environment Specular"
                                    F.Flag = "wm_specular"
                                    v, F.Min = v + 510, 0
                                    F.Max = 1
                                    F.Rounding = 2
                                    a = w[3].light
                                    F.Default = a.specular
                                    La = o:la({w})
                                    F.Callback = La
                                    h = c.AddSlider
                                    ia = c
                                else
                                    v, A = 871 - v, A(qa, za)
                                    aa = "ui_watermark"
                                    wa = {Text = "Watermark"}
                                    Fa = true
                                    wa.Default = true
                                    za = A
                                    qa = A.AddToggle
                                end
                            else
                                ha, oa[3], ra = {}, D(ja, ha), "Hit Part"
                                ha.Text = "Hit Part"
                                ha.Flag = "sd_hit_part"
                                va, C, Ga, v, u = "UpperTorso", "Head", "HumanoidRootPart", 445 - v, {}
                                u[1], u[2], u[3] = "Head", "UpperTorso", "HumanoidRootPart"
                                ha.Options = u
                                ha.Default = "Head"
                                ra = o:W({fa})
                                ha.Callback = ra
                                D = y.AddDropdown
                                ja = y
                            end
                        elseif v >= 234 then
                            if v > 239 then
                                if v > 242 then
                                    ea = {}
                                    Qa = {}
                                    ea.Instance = K
                                    Qa.TitleLabel = ea
                                    Qa.SubTitleLabel = {
                                        Instance = p[3].WatermarkText,
                                    }
                                    v, Ma[3].Items = 797, Qa
                                    Qa = {}
                                    N = "pulse"
                                    R = "gradient"
                                    Qa[1], Qa[2], Qa[3], Qa[4] = "wave", "rainbow", "pulse", "gradient"
                                    ea = Ma[3].WaveStyles
                                    G = type
                                    ca = Qa
                                elseif v > 241 then
                                    Fa = #aa
                                    na = 0
                                    wa = Fa > 0
                                    v = wa and 1452 / v or 168 or 168
                                else
                                    l(Ua, U, ga)
                                    U = {Title = "World"}
                                    ga = "Left"
                                    v, U.Side = 377 - v, "Left"
                                    l = q.AddSection
                                    Ua = q
                                end
                            elseif v < 237 then
                                if v > 234 then
                                    ua = ua(Ja, P)
                                    L[3].Root = ua
                                    v, t = 472 - v, L[3].Root
                                    j = o:t({L})
                                    P = t.DescendantAdded
                                    P, t = P.Connect, P
                                else
                                    J = J()
                                    L = game
                                    e = "https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/SaveManager.lua"
                                    ba = loadstring
                                    ka, v, L = L, 210, L.HttpGet
                                end
                            elseif v > 237 then
                                Ua(U, ga)
                                Ua = {[1] = 3, [3] = nil}
                                Ua[2] = Ua
                                v, ya, c = 331 - v, {}, "Custom World Time"
                                ya.Text = "Custom World Time"
                                ya.Flag = "wm_time"
                                ya.Default = false
                                c = o:Aa({w, Na, xa, _, Ua})
                                ya.Callback = c
                                U = l.AddToggle
                                ga = l
                            else
                                v, P = 310 - v, o.c(P(t, j))
                                ua = p[3].GiveSignal
                                Ja = p[3]
                            end
                        elseif v <= 226 then
                            if v <= 225 then
                                if v >= 224 then
                                    if v > 224 then
                                        oa.contexts = W(y, D)
                                        v, oa.hookState = 222, "Not installed"
                                        oa.keyState = {down = false, on = false}
                                        y = {}
                                        D = 0
                                        y.shots = 0
                                        y.redirected = 0
                                        y.projectiles = 0
                                        W = y
                                        oa.diagnostics = y
                                        ma = {[1] = 3, [3] = oa}
                                        ma[2] = ma
                                        ma[3].Library = p[3]
                                        oa = getgenv
                                    else
                                        Ua[3], U = U(ga, ya), Na[3]
                                        v, ya, ga = v + -75, false, Ua[3]
                                    end
                                else
                                    v = 75
                                    Y = 125
                                    p = "https://raw.githubusercontent.com/vcqz23/settings/refs/heads/main/Linoria%20Src"
                                    z = game
                                    O, z = z, z.HttpGet
                                end
                            else
                                da(d, xa)
                                xa = {Title = "Settings"}
                                v, q = 264 - v, "Left"
                                xa.Side = "Left"
                                da = Oa.AddSection
                                d = Oa
                            end
                        elseif v <= 229 then
                            if v <= 227 then
                                Ja.Size = P(t, j)
                                Ja.TabPadding = 6
                                P = 0.16
                                Ja.MenuFadeTime = 0.16
                                v, ua, e = 40179 / v, p[3], p[3].CreateWindow
                            else
                                v, ba = v + -222, o.c(ba(L, ka))
                            end
                        else
                            D(ja, ha)
                            ha = {Text = "Silent Aim Key", Flag = "sd_silent_key"}
                            C = Enum
                            u = Enum.UserInputType
                            ha.Default = u.MouseButton2
                            ha.Mode = "Hold"
                            ra = o:X()
                            ha.Callback = ra
                            v, D, ja = 485 - v, y.AddKeyPicker, y
                        end
                    elseif v < 390 then
                        if v >= 340 then
                            if v <= 363 then
                                if v > 359 then
                                    ea(N)
                                    v, N = 1350 - v, o:xa({Ma})
                                elseif v <= 358 then
                                    if v <= 340 then
                                        h(ia, F)
                                        v, La, F = 268600 / v, "World Brightness", {}
                                        F.Text = "World Brightness"
                                        F.Flag = "wm_brightness"
                                        F.Min = 0
                                        F.Max = 10
                                        F.Rounding = 2
                                        a = w[3].light
                                        F.Default = a.brightness
                                        La = o:T({w})
                                        F.Callback = La
                                        ia = c
                                        h = c.AddSlider
                                    else
                                        R.A = E(A, qa, za)
                                        R.B = p[3].AccentColor
                                        R.Speed = 1
                                        E = "wave"
                                        R.Style = "wave"
                                        ea.Sub = R
                                        N = o:V()
                                        ea.Rebuild = N
                                        G = {[1] = 3, [3] = ea}
                                        G[2] = G
                                        ea = not Qa[3]
                                        v = ea and 29 or 90 or 90
                                    end
                                else
                                    Wa(M, Ra)
                                    Wa = p[3].OnUnload
                                    M = p[3]
                                    v = 141
                                    Ra = o:Xa({ma, C, xa, _, w})
                                end
                            elseif v > 381 then
                                v = 881
                                Wa(M, Ra)
                                Wa = ba.BuildConfigSection
                                M = ba
                                Ra = E
                            elseif v <= 372 then
                                Ra(Aa, n, g)
                                return
                            else
                                Wa(M, Ra)
                                Wa = _a[3].ui_keybinds
                                Ra = o:oa({p})
                                Wa, v, M = Wa.OnChanged, 359, Wa
                            end
                        elseif v > 298 then
                            if v < 335 then
                                F[3], La, a, v, K = La(a, K), Na[3], ia[3], 998, false
                            elseif v > 335 then
                                M = M(Ra, Aa)
                                v = 969
                                n = "subFx_colorA"
                                g = {Title = "Gradient"}
                                s = 1
                                Sa = Color3.new
                                b = 1
                                V = 1
                            else
                                E[3] = qa(za)
                                A = {[1] = 3, [3] = A}
                                A[2] = A
                                A[3] = o:m({E})
                                qa = o:Ia({A, N, R, G})
                                v, G[3].Rebuild = 824 - v, qa
                                qa = G[3].Rebuild
                            end
                        elseif v <= 291 then
                            if v <= 290 then
                                if v <= 286 then
                                    v, Wa = 241384 / v, Wa(M, Ra)
                                    n = {}
                                    Aa = "subFx_style"
                                    n.Text = "Style"
                                    n.Values = ca
                                    g = "wave"
                                    n.Default = "wave"
                                    Ra = Wa
                                    M = Wa.AddDropdown
                                else
                                    Ra(Aa, n, g)
                                    v, Ra, n = v + 644, x[3].subFx_colorA, o:O({R})
                                    Aa, Ra = Ra, Ra.OnChanged
                                end
                            else
                                Wa(M, Ra, Aa)
                                Ra = o:Ua({p})
                                Wa = _a[3].ui_watermark
                                v, M, Wa = 381, Wa, Wa.OnChanged
                            end
                        else
                            v = v + -8
                            Ra(Aa, n, g)
                            g = {}
                            n = "subFx_colorB"
                            g.Title = "Gradient"
                            Sa = p[3].AccentColor
                            g.Default = Sa
                            Ra = M.AddColorPicker
                            Aa = M
                        end
                    elseif v >= 452 then
                        if v <= 494 then
                            if v < 489 then
                                if v > 452 then
                                    aa.Position = wa(Fa, na)
                                    aa = p[3].WatermarkText
                                    wa = Color3.new
                                    Fa = 1
                                    na = 1
                                    v = 682
                                    Wa = 1
                                else
                                    K, ia[3], ca = {}, La(a, K), "Graphics Technology"
                                    K.Text = "Graphics Technology"
                                    K.Flag = "wm_tech"
                                    E = "Compatibility"
                                    ea = "Unified"
                                    G = "ShadowMap"
                                    Qa = {}
                                    N = "Future"
                                    R = "Voxel"
                                    Qa[1], Qa[2], Qa[3], Qa[4], Qa[5] = "ShadowMap", "Unified", "Future", "Voxel", "Compatibility"
                                    K.Options = Qa
                                    v, ca = v + -135, "ShadowMap"
                                    K.Default = "ShadowMap"
                                    ca = o:k({w, xa})
                                    K.Callback = ca
                                    a = h
                                    La = h.AddDropdown
                                end
                            elseif v > 489 then
                                v = qa > za and 117 or 893 or 893
                            else
                                v = v + 87
                                qa()
                                wa = {}
                                za = {}
                                wa.grad = N[3]
                                wa.cfg = G[3].Title
                                Fa = {
                                    grad = R[3],
                                }
                                na = G[3].Sub
                                Fa.cfg = na
                                za[1], za[2] = wa, Fa
                                qa = {[1] = 3, [3] = za}
                                qa[2] = qa
                                wa = r[3].RenderStepped
                                aa = p[3]
                                za = p[3].Connect
                                Fa = o:r({qa})
                            end
                        elseif v <= 512 then
                            if v <= 507 then
                                v = 602
                                za(aa, wa)
                                za = o:M({p})
                                wa = p[3].Watermark
                                aa = za
                            else
                                R = R(E, A)
                                v = R and 70 or 3 or 3
                            end
                        else
                            v = 924
                            h(ia, F)
                            h = Na[3]
                            ia = f[3]
                            F = false
                        end
                    elseif v >= 417 then
                        if v <= 424 then
                            if v > 419 then
                                K(ca, Qa)
                                v = 417
                                Qa = o:ca({p, Ba, a})
                                K = task.delay
                                ca = 2
                            elseif v > 417 then
                                Wa(M)
                                Ra = {}
                                Aa = "MenuKeybind"
                                Ra[1] = "MenuKeybind"
                                M = ba
                                v = 735
                                Wa = ba.SetIgnoreIndexes
                            else
                                K(ca, Qa)
                                ca = e[3]
                                Qa = "UI Settings"
                                v = 900
                                K = e[3].AddTab
                            end
                        else
                            v = qa < za and 117 or 1437 - v
                        end
                    elseif v >= 395 then
                        if v <= 395 then
                            v = qa > za and 117 or 747 or 747
                        else
                            La(a, K)
                            K = {
                                Text = "Shadow Softness",
                                Flag = "wm_shadow_softness",
                                Min = 0,
                                Max = 1,
                            }
                            v, K.Rounding = 867 - v, 2
                            Qa = w[3].shadows
                            K.Default = Qa.softness
                            ca = o:wa({w})
                            K.Callback = ca
                            a = h
                            La = h.AddSlider
                        end
                    else
                        aa(wa)
                        wa = Vector2.zero
                        p[3].Watermark.AnchorPoint = wa
                        v = 486
                        aa = p[3].Watermark
                        na = 10
                        wa = UDim2.fromOffset
                        Fa = 150
                    end
                elseif v < 798 then
                    if v <= 697 then
                        if v < 614 then
                            if v < 576 then
                                if v < 544 then
                                    Fa = Fa(na, o.d(Wa))
                                    A[wa] = Fa
                                    v = Y <= Aa and 71820 / v or 171 or 171
                                elseif v > 544 then
                                    Wa(M, Ra)
                                    M = ba
                                    v = 388
                                    Ra = "Lean/SanDiego"
                                    Wa = ba.SetFolder
                                else
                                    v = 834
                                    qa(za, aa, wa)
                                    qa = A.AddLabel
                                    za = A
                                    aa = "Menu Key"
                                end
                            elseif v <= 593 then
                                if v < 587 then
                                    v = 90
                                    za(aa, wa, Fa)
                                elseif v <= 587 then
                                    Wa(M, Ra)
                                    v = 777
                                    Ra = p[3]
                                    M = ba
                                    Wa = ba.SetLibrary
                                else
                                    a = {
                                        [1] = 3,
                                        [3] = a(K, ca),
                                    }
                                    a[2] = a
                                    Qa = {Text = "Scan Teams"}
                                    v, G = 604267 / v, o:I({p, Ba, a})
                                    Qa.Callback = G
                                    K = a[3].AddButton
                                    ca = a[3]
                                end
                            else
                                v = v + -212
                                aa(wa)
                                wa = p[3].KeybindFrame
                                aa = za
                            end
                        elseif v <= 664 then
                            if v >= 638 then
                                if v <= 638 then
                                    v = v + -301
                                    M(Ra, Aa)
                                    Aa = "Gradient"
                                    Ra = Wa
                                    M = Wa.AddLabel
                                else
                                    v, za = 507, za(aa, wa, Fa)
                                    aa, wa, za = za, o:aa({L, p}), za.OnChanged
                                end
                            elseif v > 614 then
                                h = h(ia, F)
                                v = 415
                                ia = {[1] = 3, [3] = nil}
                                ia[2] = ia
                                F = {[1] = 3, [3] = nil}
                                F[2] = F
                                K = {Text = "Global Shadows", Flag = "wm_shadows", Default = false}
                                ca = o:q({w, Na, F, _, ia, xa})
                                K.Callback = ca
                                a = h
                                La = h.AddToggle
                            else
                                v = 334016 / v
                                qa(za, aa, wa)
                                aa = "ui_keybinds"
                                wa = {Text = "Active Keybinds"}
                                Fa = true
                                wa.Default = true
                                qa = A.AddToggle
                                za = A
                            end
                        elseif v >= 682 then
                            if v > 682 then
                                c(H, X)
                                c, v, H, X = Na[3], 578510 / v, ga[3], false
                            else
                                aa.TextColor3 = wa(Fa, na, Wa)
                                wa = p[3].RegistryMap
                                Fa = p[3].WatermarkText
                                aa = wa[Fa]
                                v = aa and 754 - v or 60 or 60
                            end
                        else
                            v = aa > 0 and 494 or 1566 - v
                        end
                    elseif v > 747 then
                        if v < 790 then
                            if v <= 771 then
                                if v > 758 then
                                    h = h(ia, F)
                                    h, v, F, ia, f[3] = Na[3], 195, false, H[3], h
                                else
                                    v = 286
                                    Wa(M, Ra)
                                    Ra = "Watermark Effect"
                                    Wa = E.AddRightGroupbox
                                    M = E
                                end
                            else
                                v = v + -358
                                Wa(M, Ra)
                                M = ba
                                Wa = ba.IgnoreThemeSettings
                            end
                        elseif v <= 791 then
                            if v > 790 then
                                R = {
                                    [1] = 3,
                                    [3] = R(E, A),
                                }
                                R[2] = R
                                E = {[1] = 3, [3] = nil}
                                E[2] = E
                                qa = 0
                                aa = 1
                                A = {}
                                za = 6
                                v = 1464 - v
                            else
                                F, La, H[3] = {}, "Exposure Compensation", h(ia, F)
                                F.Text = "Exposure Compensation"
                                F.Flag = "wm_exposure"
                                F.Min = -5
                                v = 725
                                F.Max = 5
                                F.Rounding = 2
                                a = w[3].light
                                F.Default = a.exposure
                                La = o:E({w})
                                F.Callback = La
                                h = c.AddSlider
                                ia = c
                            end
                        else
                            G = G(ea)
                            Qa = {
                                [1] = 3,
                                [3] = G == "table",
                            }
                            v, Qa[2] = 1662 - v, Qa
                            ea = {}
                            R = {}
                            A = 1
                            E = Color3.new
                            za = 1
                            qa = 1
                        end
                    elseif v < 737 then
                        if v >= 725 then
                            if v <= 725 then
                                X[3], La, F = h(ia, F), "Environment Diffuse", {}
                                F.Text = "Environment Diffuse"
                                F.Flag = "wm_diffuse"
                                F.Min = 0
                                v = 261
                                F.Max = 1
                                F.Rounding = 2
                                a = w[3].light
                                F.Default = a.diffuse
                                La = o:L({w})
                                F.Callback = La
                                ia = c
                                h = c.AddSlider
                            else
                                Wa(M, Ra)
                                v, M, Ra, Wa = 1300 - v, J, "Lean", J.SetFolder
                            end
                        else
                            v = aa <= 0 and 884 or 835 - v
                        end
                    elseif v <= 745 then
                        if v < 740 then
                            N = {
                                [1] = 3,
                                [3] = N(R, E),
                            }
                            N[2] = N
                            E = Ma[3].Items
                            R = ea
                            v = E and 88 or 145 or 145
                        elseif v > 740 then
                            M(Ra, Aa)
                            Aa = "subFx_speed"
                            n = {}
                            v, n.Text = 718925 / v, "Speed"
                            n.Min = 0.05
                            n.Max = 3
                            n.Rounding = 2
                            g = 1
                            n.Default = 1
                            Ra = Wa
                            M = Wa.AddSlider
                        else
                            v, Qa = 862, o.c(Qa(G))
                        end
                    else
                        v = aa <= 0 and 437 or 1000 or 1000
                    end
                elseif v <= 893 then
                    if v < 864 then
                        if v >= 834 then
                            if v >= 844 then
                                if v > 844 then
                                    ca, Qa, G = ca(o.d(Qa))
                                    ca, Qa, G = o.b(ca, Qa, G)
                                    ea, N = ca(Qa, G)
                                    G = ea
                                    v = ea == nil and 243 or 985 - v
                                else
                                    M = M(Ra, Aa, n)
                                    Aa, Ra, v, M = o:ta({ea}), M, 1589 - v, M.OnChanged
                                end
                            elseif v <= 834 then
                                qa = qa(za, aa)
                                wa = {}
                                aa = "MenuKeybind"
                                wa.Text = "Menu Key"
                                v, wa.Default = 809, "End"
                                Fa = true
                                wa.NoUI = true
                                qa, za = qa.AddKeyPicker, qa
                            else
                                v = 226800 / v
                                qa(za, aa, wa)
                                aa = "Fonts"
                                za = E
                                qa = E.AddLeftGroupbox
                            end
                        elseif v > 809 then
                            v = 277
                            c(H, X)
                            c = Na[3]
                            H = ya[3]
                            X = false
                        elseif v > 798 then
                            v = 679560 / v
                            qa(za, aa, wa)
                            qa = x[3].MenuKeybind
                            p[3].ToggleKeybind = qa
                            wa = o:na({p})
                            za = A
                            aa = "Unload"
                            qa = A.AddButton
                        else
                            c = c(H, X)
                            H = {[1] = 3, [3] = nil}
                            H[2] = H
                            v = 340
                            X = {[1] = 3, [3] = nil}
                            X[2] = X
                            ta = {[1] = 3, [3] = nil}
                            ta[2] = ta
                            f = {[1] = 3, [3] = nil}
                            f[2] = f
                            F = {Text = "Custom Lighting", Flag = "wm_light", Default = false}
                            La = o:sa({w, Na, X, f, H, ta, xa, _})
                            F.Callback = La
                            ia = c
                            h = c.AddToggle
                        end
                    elseif v < 881 then
                        if v <= 865 then
                            if v <= 864 then
                                Ra()
                                Aa = p[3]
                                n = "modules loaded"
                                v = 372
                                g = 3
                                Ra = p[3].Notify
                            else
                                v, R.A = 309670 / v, E(A, qa, za)
                                R.B = p[3].AccentColor
                                R.Speed = 1
                                R.Style = "wave"
                                N = R
                                ea.Title = R
                                R = {}
                                E = Color3.new
                                A = 1
                                qa = 1
                                za = 1
                            end
                        else
                            La(a, K)
                            K = {Text = "Whitelist"}
                            v, G, Qa = 1094 - v, "Teams", {}
                            Qa[1] = "Teams"
                            ca = Qa
                            K.Pages = Qa
                            a = Ma[3]
                            La = Ma[3].AddTab
                        end
                    elseif v > 884 then
                        v = 720
                    elseif v < 883 then
                        Wa(M, Ra)
                        M, v, Wa, Ra = J, 667798 / v, J.ApplyToTab, E
                    elseif v > 883 then
                        v = qa < za and 117 or v + -769
                    else
                        E, A, qa = E(A)
                        E, A, qa = o.b(E, A, qa)
                        za, aa = E(A, qa)
                        qa = za
                        v = za == nil and 209 or 213686 / v
                    end
                elseif v > 969 then
                    if v < 998 then
                        if v < 985 then
                            v, Wa = 517104 / v, o.c(Wa(M, Ra, Aa))
                        elseif v > 985 then
                            ea(N)
                            ea = o:qa()
                            N = ea
                            R = Ma[3].Items
                            v = R and v + -803 or 1049 - v
                        else
                            v = v + -732
                            wa(Fa, na)
                        end
                    elseif v > 1000 then
                        K(ca, Qa)
                        Qa = {}
                        v, Qa.Text = 424, "Clear All"
                        G = o:Y({Ba, _a, p})
                        Qa.Callback = G
                        K = a[3].AddButton
                        ca = a[3]
                    elseif v > 998 then
                        v = 115
                    else
                        La(a, K)
                        a = F[3]
                        v = 878
                        K = false
                        La = Na[3]
                    end
                elseif v > 933 then
                    if v > 965 then
                        Sa = Sa(s, b, V)
                        g.Default = Sa
                        v = 298
                        Aa = M
                        Ra = M.AddColorPicker
                    elseif v <= 934 then
                        v = 933
                        Ra(Aa, n)
                        Ra = x[3].subFx_colorB
                        n = o:Ha({R})
                        Ra, Aa = Ra.OnChanged, Ra
                    else
                        v, M = v + -327, M(Ra, Aa, n)
                        M, Aa, Ra = M.OnChanged, o:Ya({N}), M
                    end
                elseif v > 924 then
                    v = 262
                    Ra(Aa, n)
                    Ra = ba.LoadAutoloadConfig
                    Aa = ba
                elseif v >= 920 then
                    if v <= 920 then
                        aa.Position = wa(Fa, na, Wa, M)
                        na = p[3].AccentColor
                        aa = {[1] = 3, [3] = 0}
                        aa[2] = aa
                        wa = {[1] = 3, [3] = 0}
                        wa[2] = wa
                        Fa = {[1] = 3, [3] = 60}
                        Fa[2] = Fa
                        v, na = 291, {[1] = 3, [3] = na}
                        na[2] = na
                        M = p[3]
                        Ra = r[3].RenderStepped
                        Wa = p[3].Connect
                        Aa = o:Ma({aa, wa, p, P, Fa, _a, na, G})
                    else
                        v = 615
                        h(ia, F)
                        F = {Title = "Graphics"}
                        La = "Right"
                        F.Side = "Right"
                        ia = q
                        h = q.AddSection
                    end
                else
                    v, K = 740, K(ca, Qa)
                    t[3]["UI Settings"] = K
                    K = nil
                    Qa = e[3].Holder
                    ca = ipairs
                    G, Qa = Qa, Qa.GetDescendants
                end
            until false
        end
    end,
    F = function(b, h)
        return function(enabled)
            h[1][3].teamSettings.players.enabled = enabled
        end
    end,
    Qb = function(b, _)
        return function(occludedColor, occludedIntensity)
            local e = 114
            while true do
                if e < 114 then
                    return
                elseif e <= 114 then
                    _[1][3].occludedColor = occludedColor
                    e = occludedIntensity ~= nil and 207 or 77 or 77
                else
                    e, _[1][3].occludedIntensity = e + -130, occludedIntensity
                end
            end
        end
    end,
    nd = function(a, b, c, d)
        a.md[d] = b - c
        return a.md[d]
    end,
    ab = function(b, h)
        return function()
            local e = 153
            local k, j, a, c, i, g, d
            repeat
                if e > 122 then
                    if e > 216 then
                        if e < 249 then
                            if e <= 219 then
                                d(k)
                                d = table.clear
                                c = h[7][3]
                                e, k = 463 - e, c.Replicator.Actors
                            else
                                d(k)
                                return
                            end
                        elseif e > 249 then
                            i, g = d(k, c)
                            c = i
                            e = i == nil and 172 or 85 or 85
                        else
                            e = 219
                            h[1][3]._hasLoaded = false
                            d = table.clear
                            k = h[4][3]
                        end
                    elseif e >= 172 then
                        if e >= 186 then
                            if e > 186 then
                                d = h[6][3]
                                e = d and 338 - e or 53784 / e
                            else
                                d(k)
                                e, d = e + 63, nil
                                h[6][3] = nil
                            end
                        else
                            k = h[2][3]
                            e = 87
                            d = table.clear
                        end
                    elseif e <= 153 then
                        h[1][3]._hasLoaded = false
                        e = 19
                        d = ipairs
                        k = h[2][3]
                    else
                        e = 84
                        d(k)
                        d = nil
                        h[5][3] = nil
                    end
                elseif e <= 84 then
                    if e < 33 then
                        if e > 4 then
                            d, k, c = d(k)
                            d, k, c = b.b(d, k, c)
                            i, g = d(k, c)
                            c = i
                            e = i == nil and 3268 / e or 85 or 85
                        elseif e <= 1 then
                            d, k, c = d(k)
                            d, k, c = b.b(d, k, c)
                            i, g = d(k, c)
                            c = i
                            e = i == nil and 216 or 96 - e
                        else
                            d = h[5][3]
                            k, e, d = d, 165, d.Disconnect
                        end
                    elseif e >= 54 then
                        if e > 54 then
                            e, d, i = 84 / e, pairs, h[1][3]
                            k = i.objects
                        else
                            i, g = d(k, c)
                            c = i
                            e = i == nil and 216 or 95 or 95
                        end
                    else
                        e = 1782 / e
                        j(a)
                        j = h[1][3].objects
                        a = nil
                        j[i] = nil
                    end
                elseif e > 87 then
                    if e <= 95 then
                        a, e, j = g, 128 - e, h[3][3]
                    else
                        d = h[6][3]
                        e, k, d = e + 64, d, d.Destroy
                    end
                elseif e < 86 then
                    e, j, a = 7310 / e, g.Disconnect, g
                elseif e <= 86 then
                    e = e + 168
                    j(a)
                else
                    d(k)
                    d = h[5][3]
                    e = d and e + -83 or 84 or 84
                end
            until false
        end
    end,
    sd = function(a, b, c, d)
        a.pd[d] = b - a.a(c, 54135)
        return a.pd[d]
    end,
    Q = function(b, h)
        return function(teamCheck)
            h[1][3].teamSettings.players.teamCheck = teamCheck
        end
    end,
    jc = function(b, _)
        return function(offScreenArrowRadius)
            _[1][3].offScreenArrowRadius = offScreenArrowRadius
        end
    end,
    lc = function(b, _)
        return function(skeletonColor)
            _[1][3].skeletonColor = skeletonColor
        end
    end,
    Nc = function(b, _)
        return function(...)
            local e = 218
            local f, c, d
            repeat
                if e >= 218 then
                    c = b.c(...)
                    d = _[1][3]
                    e = 55
                    f = _[2][3]
                else
                    d = b.c(d(f, b.d(c)))
                    return b.d(d)
                end
            until false
        end
    end,
    Oa = function(b, _)
        return function()
            local e = 154
            local d, c, f
            while true do
                if e <= 154 then
                    if e >= 80 then
                        if e <= 80 then
                            e, f = 208, f(c)
                            c = true
                            d = f == true
                        else
                            f = _[1][3]
                            e, c, f = 220, f, f.GetFocusedTextBox
                        end
                    elseif e <= 22 then
                        e = d and e + 5 or 208 or 208
                    else
                        f = _[2][3]
                        f, e, c = f.GetState, 80, f
                    end
                elseif e >= 220 then
                    if e > 220 then
                        c = nil
                        f = _[2][3]
                        e, d = 4950 / e, f ~= nil
                    else
                        f = f(c)
                        c = nil
                        d = f == nil
                        e = d and 445 - e or 242 - e
                    end
                else
                    return d
                end
            end
        end
    end,
    qa = function(b)
        return function(l, k)
            local e = 118
            local j, f, g, i, c, _
            repeat
                if e > 137 then
                    if e <= 202 then
                        if e <= 183 then
                            if e <= 180 then
                                return i
                            else
                                i = not c
                                e = i and 253 - e or 117 or 117
                            end
                        else
                            g = g(j)
                            i = g
                            g.Name = k
                            g.Parent = c
                            e = _ >= f and 382 - e or 118 or 118
                        end
                    else
                        i = i(g, j)
                        g = not i
                        e = g and 293 - e or 427 - e
                    end
                elseif e >= 117 then
                    if e < 118 then
                        g, e, j, i = c, e + 130, k, c.FindFirstChild
                    elseif e <= 118 then
                        c = l
                        _ = 247
                        f = 52
                        e = l and 137 or 183 or 183
                    else
                        e, c = 25071 / e, l.Instance
                    end
                elseif e <= 46 then
                    e, j, g = 248 - e, "UIGradient", Instance.new
                else
                    return nil
                end
            until false
        end
    end,
    Ka = function(b, _)
        return function(hitChance)
            _[1][3].HitChance = hitChance
        end
    end,
    eb = function(b, h)
        return function(d, k, c)
            local e = 163
            local i, j, g
            while true do
                if e <= 165 then
                    if e <= 163 then
                        if e > 51 then
                            e = 206
                            g = k
                            i = h[1][3]
                        else
                            e, j = 8415 / e, i
                        end
                    else
                        d.Color = j
                        d.Transparency = g
                        d.Visible = g > 0
                        return
                    end
                else
                    i, g = i(g)
                    j = c
                    e = c and 33990 / e or 10506 / e
                end
            end
        end
    end,
    V = function(b)
        return function()
        end
    end,
    ma = function(b, _)
        return function(maxDistance)
            _[1][3].MaxDistance = maxDistance
        end
    end,
    Lb = function(b, _)
        return function()
            local e = 154
            local c, d, f
            repeat
                if e <= 154 then
                    e = 161
                    c = _[2][3]
                    d = _[1][3]
                    f, d = d, d.GetTextBoundsAsync
                else
                    d = b.c(d(f, c))
                    return b.d(d)
                end
            until false
        end
    end,
    sa = function(b, h)
        return function(d)
            local e = 221
            local c, a, f
            while true do
                if e <= 115 then
                    if e >= 72 then
                        if e > 72 then
                            f(c, a)
                            f = not d
                            e = f and 16445 / e or e + -87
                        else
                            f(c, a)
                            e = 115
                            a = d
                            c = h[4][3]
                        end
                    elseif e > 28 then
                        e = 233
                        f(c, a)
                        a = d
                        c = h[3][3]
                    else
                        return
                    end
                elseif e >= 221 then
                    if e > 221 then
                        e = 72
                        f(c, a)
                        c = h[6][3]
                    else
                        h[1][3].light.enabled = d
                        f = h[2][3]
                        e = 63
                        c = h[5][3]
                    end
                    a = d
                else
                    f = h[7][3]
                    a = h[8][3]
                    f.Brightness = a.Brightness
                    f.ExposureCompensation = a.ExposureCompensation
                    e, f.EnvironmentDiffuseScale = 171 - e, a.EnvironmentDiffuseScale
                    c = a.EnvironmentSpecularScale
                    f.EnvironmentSpecularScale = c
                end
            end
        end
    end,
    Ub = function(b, h)
        return function(d, f)
            local e = 172
            local a, c, g
            while true do
                if e < 189 then
                    if e <= 114 then
                        c(a, g)
                        return
                    else
                        e = 211
                        g = "boxColor"
                        a = h[2][3]
                        c = h[1][3]
                    end
                elseif e > 193 then
                    e, c = e + -18, c(a, g)
                    a = d
                    g = f
                elseif e > 189 then
                    e = 189
                    c(a, g)
                    c = h[1][3]
                    a = h[2][3]
                    g = "box3dColor"
                else
                    e, c = 114, c(a, g)
                    a = d
                    g = f
                end
            end
        end
    end,
    Ia = function(b, _)
        return function()
            local e = 213
            local d, f, c
            while true do
                if e <= 213 then
                    if e <= 167 then
                        d(f, c)
                        return
                    else
                        d = _[1][3]
                        e = 222
                        f = _[2][3]
                        c = _[4][3].Title
                    end
                else
                    d(f, c)
                    e, c, f = e + -55, _[4][3], _[3][3]
                    c = c.Sub
                end
            end
        end
    end,
    Aa = function(b, h)
        return function(d)
            local e = 150
            local f, c, a
            while true do
                if e > 150 then
                    a = h[4][3]
                    f = h[3][3]
                    c = a.ClockTime
                    e, f.ClockTime = 43, c
                elseif e < 91 then
                    return
                elseif e <= 91 then
                    f(c, a)
                    f = not d
                    e = f and 273 - e or 134 - e
                else
                    e, h[1][3].time.enabled = 91, d
                    a = d
                    c = h[5][3]
                    f = h[2][3]
                end
            end
        end
    end,
    Dc = function(o, h)
        return function()
            local m = 81
            local _, e, f, b, g, i, c, p, l, k, q, r, a, n
            repeat
                if m < 154 then
                    if m < 75 then
                        if m < 43 then
                            k = o.c(k(p, i, q))
                            return o.d(k)
                        elseif m <= 43 then
                            q.Suffix = r
                            k, m, p = k.AddSlider, 24, k
                        else
                            q.Rounding = r
                            a = h[1][3]
                            r = a.Suffix
                            m = r and 43 or m + 96
                        end
                    elseif m >= 95 then
                        if m <= 95 then
                            g = 180
                            m = k and m + 76 or 221 or 221
                        else
                            k = false
                            m = m + 102
                        end
                    elseif m > 75 then
                        l = 31
                        b = 61
                        n = tonumber
                        c = 142
                        e = 54
                        m = 75
                        k = h[1][3].Default
                    else
                        n = n(k)
                        m = n and 125 or 208 or 208
                    end
                elseif m <= 216 then
                    if m < 173 then
                        if m <= 154 then
                            m, r = 197 - m, ""
                        else
                            m = 221
                            k = h[1][3]
                            n = k.Max
                        end
                    elseif m > 208 then
                        q.Default = r(a, _, f)
                        a = h[1][3]
                        r = a.Rounding
                        m = r and m + -158 or 173 or 173
                    elseif m > 173 then
                        k = h[1][3]
                        n = k.Min
                        m = e >= l and 333 - m or 173 or 173
                    else
                        r = 0
                        m = g < 0 and 125 or m + -115
                    end
                elseif m > 227 then
                    p = p(i)
                    q = math
                    i = math.huge
                    k = p == i
                    m = b > c and 466 - m or 340 - m
                elseif m <= 221 then
                    k = h[2][3]
                    i = h[1][3].Flag
                    q = {}
                    a = h[1][3]
                    q.Text = a.Text
                    m, q.Min = 47736 / m, a.Min
                    q.Max = a.Max
                    a = n
                    f = h[1][3]
                    r = math.clamp
                    _, f = f.Min, f.Max
                else
                    m = 245
                    i = n
                    p = math.abs
                end
            until false
        end
    end,
    Pb = function(b, _)
        return function(visibleColor, visibleIntensity)
            local e = 123
            while true do
                if e < 170 then
                    _[1][3].visibleColor = visibleColor
                    e = visibleIntensity ~= nil and 222 or 170 or 170
                elseif e <= 170 then
                    return
                else
                    e, _[1][3].visibleIntensity = 170, visibleIntensity
                end
            end
        end
    end,
    na = function(b, _)
        return function()
            local e = 206
            local a, d
            while true do
                if e <= 206 then
                    d = _[1][3]
                    e, d, a = 229, d.Unload, d
                else
                    d(a)
                    return
                end
            end
        end
    end,
    Ob = function(b, _)
        return function(tracerOutline)
            _[1][3].tracerOutline = tracerOutline
        end
    end,
    Bc = function(b, _)
        return function(d)
            local e = 187
            local f, c
            while true do
                if e < 129 then
                    f(c)
                    e, f = e + 100, _[2][3]
                elseif e <= 129 then
                    f()
                    return
                else
                    c = d
                    e = 29
                    f = _[1][3]
                end
            end
        end
    end,
    c = function(...)
        return {
            [1] = {...},
            [2] = select("#", ...),
        }
    end,
    S = function(b, h)
        return function(d)
            local e = 163
            local c, f, a
            repeat
                if e <= 163 then
                    if e > 153 then
                        e = 175
                        h[1][3].fog.enabled = d
                        f = h[2][3]
                        c = h[5][3]
                        a = d
                    elseif e < 150 then
                        f = h[4][3]
                        a = h[7][3]
                        f.FogStart = a.FogStart
                        f.FogEnd = a.FogEnd
                        e = 150
                        c = a.FogColor
                        f.FogColor = c
                    elseif e > 150 then
                        f(c, a)
                        a = d
                        e = 230
                        c = h[6][3]
                    else
                        return
                    end
                elseif e <= 175 then
                    e = 153
                    f(c, a)
                    a = d
                    c = h[3][3]
                else
                    f(c, a)
                    f = not d
                    e = f and 26220 / e or 150 or 150
                end
            until false
        end
    end,
    p = function(b, h)
        return function(enabled)
            h[1][3].teamSettings.npc.enabled = enabled
        end
    end,
    Da = function(b)
        return function(d, f, c)
            local e = 218
            local j, g, i, a
            repeat
                if e <= 218 then
                    if e <= 166 then
                        g(j, a)
                        return i
                    else
                        j = c
                        i = f.Connect
                        e = 220
                        g = f
                    end
                else
                    i = i(g, j)
                    g, a, e, j = d.GiveSignal, i, 36520 / e, d
                end
            until false
        end
    end,
    dc = function(b, _)
        return function(nameType)
            _[1][3].nameType = nameType
        end
    end,
    K = function(o, h)
        return function(s, k)
            local v = 83
            local e, b, g, m, w, x, _, f, q, l, d, i, t, n, c, u, j, p, a
            while true do
                if v > 130 then
                    if v < 211 then
                        if v > 169 then
                            if v >= 193 then
                                if v > 201 then
                                    if v <= 203 then
                                        v, g = 22533 / v, o.c(g(u, m))
                                    else
                                        b(w, t)
                                        t = {Title = "Tracer & Arrow"}
                                        j = "Right"
                                        v, t.Side = 137, "Right"
                                        w = s
                                        b = s.AddSection
                                    end
                                elseif v < 200 then
                                    w(t, j)
                                    j = {Text = "Tracer Color"}
                                    v = 90
                                    j.Flag = x .. "tracerColor"
                                    n = h[3][3]
                                    g = p[3]
                                    u = "tracerColor"
                                elseif v > 200 then
                                    e = e(l, b)
                                    w = {Text = "Skeleton"}
                                    j = "skeleton"
                                    w.Flag = x .. "skeleton"
                                    v, w.Default = 69, false
                                    t = o:_c({q})
                                    w.Callback = t
                                    l = e.AddToggle
                                    b = e
                                else
                                    l.Default = b(w, t)
                                    v, j, t, n, b, w = 325 - v, p[3], h[3][3], "boxOutlineColor", select, 2
                                end
                            elseif v >= 187 then
                                if v > 190 then
                                    l.Transparency = b(w, o.d(t))
                                    v = 163
                                    t = "boxOutlineColor"
                                    b = h[4][3]
                                    w = p[3]
                                elseif v > 187 then
                                    w(t, j)
                                    j = {
                                        Text = "Tracer Origin",
                                        Flag = x .. "tracer_origin",
                                    }
                                    m = "Middle"
                                    c = "Bottom"
                                    u = "Top"
                                    g = {}
                                    g[1], g[2], g[3] = "Top", "Middle", "Bottom"
                                    j.Options = g
                                    j.Default = p[3].tracerOrigin
                                    n = o:oc({p})
                                    j.Callback = n
                                    w = b.AddDropdown
                                    v = 193
                                    t = b
                                else
                                    v, t = 238, o.c(t(j, n))
                                end
                            elseif v > 172 then
                                e(l, b)
                                b = {Text = "Health Bar Outline"}
                                t = "healthBarOutline"
                                b.Flag = x .. "healthBarOutline"
                                b.Default = p[3].healthBarOutline
                                v, w = 44704 / v, o:Wb({p})
                                b.Callback = w
                                l = d
                                e = d.AddToggle
                            else
                                b(w, t)
                                t = {Text = "Distance Outline"}
                                n = "distanceOutline"
                                v, t.Flag = v + 34, x .. "distanceOutline"
                                t.Default = p[3].distanceOutline
                                j = o:nc({p})
                                t.Callback = j
                                w = l
                                b = l.AddToggle
                            end
                        elseif v > 152 then
                            if v <= 163 then
                                if v >= 158 then
                                    if v <= 158 then
                                        v, b.Transparency = 75, w(t, o.d(j))
                                        j = "healthTextColor"
                                        w = h[4][3]
                                        t = p[3]
                                    else
                                        v, b = 39935 / v, b(w, t)
                                        l.Callback = b
                                        d = f.AddColorPicker
                                        e = f
                                    end
                                else
                                    v, b = 23864 / v, b(w, o.d(t))
                                    l.Transparency = b
                                    t = "boxFillColor"
                                    b = h[4][3]
                                    w = p[3]
                                end
                            elseif v > 168 then
                                d = d(e, l)
                                b = {Text = "Health Bar"}
                                t = "healthBar"
                                b.Flag = x .. "healthBar"
                                v = 108
                                b.Default = p[3].healthBar
                                w = o:fc({p})
                                b.Callback = w
                                e = d.AddToggle
                                l = d
                            else
                                b.Default = w(t, j)
                                v = 130
                                t = p[3]
                                j = "dyingColor"
                                w = h[4][3]
                            end
                        elseif v >= 146 then
                            if v > 149 then
                                v, b = 65, b(w, t)
                                l.Callback = b
                                d = f.AddColorPicker
                                e = f
                            elseif v <= 146 then
                                v, n = 4526 / v, n(g, u)
                                j.Default = n
                                n = select
                                c = "offScreenArrowColor"
                                g = 2
                                u = h[3][3]
                                m = p[3]
                            else
                                e(l, b)
                                b = {Title = "Skeleton"}
                                w = "Left"
                                b.Side = "Left"
                                l = s
                                v = 201
                                e = s.AddSection
                            end
                        elseif v > 137 then
                            v, u = v + -122, o.c(u(m, c))
                        elseif v > 136 then
                            b = b(w, t)
                            j = {Text = "Tracer"}
                            g = "tracer"
                            v, j.Flag = 190, x .. "tracer"
                            j.Default = p[3].tracer
                            n = o:Tb({p})
                            j.Callback = n
                            w = b.AddToggle
                            t = b
                        else
                            v, g = v + -20, o.c(g(u, m))
                        end
                    elseif v <= 238 then
                        if v <= 228 then
                            if v >= 225 then
                                if v > 226 then
                                    v, j = 136, j(n, g)
                                    t.Default = j
                                    n = 2
                                    j = select
                                    g = h[3][3]
                                    m = "nameColor"
                                    u = p[3]
                                elseif v > 225 then
                                    t.Default = j(n, g)
                                    v, n, u, m, j, g = v + -98, 2, p[3], "distanceColor", select, h[3][3]
                                else
                                    v, j = 172, j(n, g)
                                    t.Callback = j
                                    w = l
                                    b = l.AddColorPicker
                                end
                            elseif v > 212 then
                                b(w, t)
                                t = {Text = "Name Outline"}
                                n = "nameOutline"
                                v, t.Flag = 212, x .. "nameOutline"
                                t.Default = p[3].nameOutline
                                j = o:Xb({p})
                                t.Callback = j
                                b = l.AddToggle
                                w = l
                            elseif v <= 211 then
                                f = f(d, e)
                                l = {}
                                v, l.Text = 53, "Box"
                                w = "box"
                                l.Flag = x .. "box"
                                l.Default = false
                                b = o:Yb({a, _})
                                l.Callback = b
                                e = f
                                d = f.AddToggle
                            else
                                b(w, t)
                                b = "players"
                                v = k == "players" and 52 or 71 or 71
                            end
                        elseif v < 235 then
                            if v <= 230 then
                                l.Default = b(w, t)
                                w = 2
                                b = select
                                n = "boxColor"
                                t = h[3][3]
                                v = 187
                                j = p[3]
                            else
                                j = j(n, g)
                                t.Callback = j
                                v, w, b = v + -17, l, l.AddColorPicker
                            end
                        elseif v > 237 then
                            v, l.Transparency = 47, b(w, o.d(t))
                            b = o:Ub({
                                h[4],
                                p,
                            })
                            l.Callback = b
                            d = f.AddColorPicker
                            e = f
                        elseif v > 235 then
                            v, b = v + -144, b(w, t)
                            l.Default = b
                            b = select
                            j = p[3]
                            t = h[3][3]
                            w = 2
                            n = "boxFillColor"
                        else
                            b(w, t)
                            t = {Text = "Name Type"}
                            v, j = v + 16, x .. "name_type"
                            t.Flag = j
                            u = "Display Name"
                            n = {}
                            g = "Name"
                            n[1], n[2] = "Name", "Display Name"
                            t.Options = n
                            t.Default = "Name"
                            j = o:dc({q})
                            t.Callback = j
                            b = l.AddDropdown
                            w = l
                        end
                    elseif v < 248 then
                        if v >= 245 then
                            if v <= 246 then
                                if v <= 245 then
                                    d(e, l)
                                    l = {Text = "Box Fill"}
                                    w = "boxFill"
                                    l.Flag = x .. "boxFill"
                                    v, l.Default = v + -143, p[3].boxFill
                                    b = o:Vb({p})
                                    l.Callback = b
                                    d = f.AddToggle
                                    e = f
                                else
                                    w(t, j)
                                    j = {Text = "Arrow Radius"}
                                    g = "arrow_radius"
                                    j.Flag = x .. "arrow_radius"
                                    j.Min = 50
                                    j.Max = 400
                                    v, j.Default = 325 - v, p[3].offScreenArrowRadius
                                    j.Suffix = "px"
                                    n = o:jc({p})
                                    j.Callback = n
                                    t = b
                                    w = b.AddSlider
                                end
                            else
                                v, b.Default = 59, w(t, j)
                                g = "healthTextColor"
                                n = p[3]
                                t = 2
                                j = h[3][3]
                                w = select
                            end
                        elseif v > 242 then
                            v = 24
                            w(t, j)
                            j = {Text = "Tracer Outline"}
                            g = "tracerOutline"
                            j.Flag = x .. "tracerOutline"
                            j.Default = p[3].tracerOutline
                            n = o:Ob({p})
                            j.Callback = n
                            w = b.AddToggle
                            t = b
                        else
                            b(w, t)
                            t = {}
                            v, t.Text = 259 - v, "Weapon Outline"
                            n = "weaponOutline"
                            t.Flag = x .. "weaponOutline"
                            t.Default = p[3].weaponOutline
                            j = o:Sb({p})
                            t.Callback = j
                            w = l
                            b = l.AddToggle
                        end
                    elseif v > 251 then
                        if v > 252 then
                            e(l, b)
                            b = {Text = "Health Text"}
                            t = "healthText"
                            b.Flag = x .. "healthText"
                            v, b.Default = 378 - v, p[3].healthText
                            w = o:pc({p})
                            b.Callback = w
                            l = d
                            e = d.AddToggle
                        else
                            v, j = 225, j(n, o.d(g))
                            t.Transparency = j
                            j = h[4][3]
                            g = "distanceColor"
                            n = p[3]
                        end
                    elseif v > 249 then
                        b(w, t)
                        v, t, j = v + -23, {}, "Name Color"
                        t.Text = "Name Color"
                        t.Flag = x .. "nameColor"
                        j = h[3][3]
                        n = p[3]
                        g = "nameColor"
                    elseif v <= 248 then
                        t(j, n)
                        return
                    else
                        e(l, b)
                        b = {}
                        v, b.Text = 149, "Health Text Outline"
                        t = "healthTextOutline"
                        b.Flag = x .. "healthTextOutline"
                        b.Default = p[3].healthTextOutline
                        w = o:kc({p})
                        b.Callback = w
                        e = d.AddToggle
                        l = d
                    end
                elseif v < 83 then
                    if v <= 47 then
                        if v < 19 then
                            if v > 13 then
                                if v <= 15 then
                                    w(t, j)
                                    j = {Title = "Chams"}
                                    n = "Right"
                                    j.Side = "Right"
                                    v = 36
                                    t = s
                                    w = s.AddSection
                                else
                                    v = 71
                                    b(w, t)
                                end
                            elseif v >= 10 then
                                if v > 10 then
                                    b(w, t)
                                    t = {Text = "Distance Color"}
                                    v, j = 239 - v, x .. "distanceColor"
                                    t.Flag = j
                                    g = "distanceColor"
                                    j = h[3][3]
                                    n = p[3]
                                else
                                    v, w = 94 - v, w(t, j)
                                    b.Default = w
                                    t = p[3]
                                    j = "healthyColor"
                                    w = h[4][3]
                                end
                            else
                                n = n(g, u)
                                j.Callback = n
                                w, v, t = b.AddColorPicker, v + 242, b
                            end
                        elseif v <= 31 then
                            if v < 24 then
                                if v <= 19 then
                                    d(e, l)
                                    l = {Text = "Outline Color"}
                                    v, l.Flag = v + 181, x .. "boxOutlineColor"
                                    w = p[3]
                                    t = "boxOutlineColor"
                                    b = h[3][3]
                                else
                                    v, n = 1, n(g, o.d(u))
                                    j.Transparency = n
                                    u = "tracerColor"
                                    g = p[3]
                                    n = h[4][3]
                                end
                            elseif v > 24 then
                                v, u = 3007 / v, o.c(u(m, c))
                            else
                                v = v + 89
                                w(t, j)
                                j = {Text = "Off Screen Arrow"}
                                g = "offScreenArrow"
                                j.Flag = x .. "offScreenArrow"
                                j.Default = p[3].offScreenArrow
                                n = o:ac({p})
                                j.Callback = n
                                t = b
                                w = b.AddToggle
                            end
                        elseif v <= 36 then
                            w = w(t, j)
                            n = {Text = "Chams"}
                            u = "cs2_chams"
                            v = 94
                            n.Flag = x .. "cs2_chams"
                            n.Default = false
                            g = o:Rb({i})
                            n.Callback = g
                            j = w
                            t = w.AddToggle
                        else
                            d(e, l)
                            l = {Text = "Box Outline"}
                            w = "boxOutline"
                            l.Flag = x .. "boxOutline"
                            l.Default = p[3].boxOutline
                            b = o:cc({p})
                            v, l.Callback = v + -28, b
                            e = f
                            d = f.AddToggle
                        end
                    elseif v <= 65 then
                        if v <= 59 then
                            if v > 57 then
                                v, j = 158, o.c(j(n, g))
                            elseif v < 53 then
                                t = {}
                                v, t.Text = 57, "Weapon"
                                n = "weapon"
                                t.Flag = x .. "weapon"
                                t.Default = p[3].weapon
                                j = o:ec({p})
                                t.Callback = j
                                w = l
                                b = l.AddToggle
                            elseif v <= 53 then
                                d(e, l)
                                l = {
                                    Text = "Box Type",
                                    Flag = x .. "box_type",
                                }
                                w = {}
                                t = "2D"
                                j = "3D"
                                w[1], w[2] = "2D", "3D"
                                l.Options = w
                                v, b = v + 73, "2D"
                                l.Default = "2D"
                                b = o:hc({a, _})
                                l.Callback = b
                                d = f.AddDropdown
                                e = f
                            else
                                b(w, t)
                                v, t, j = v + 49, {}, "Weapon Color"
                                t.Text = "Weapon Color"
                                t.Flag = x .. "weaponColor"
                                g = "weaponColor"
                                j = h[3][3]
                                n = p[3]
                            end
                        elseif v > 60 then
                            d(e, l)
                            l = {Title = "Health"}
                            v, b = 10985 / v, "Left"
                            l.Side = "Left"
                            e = s
                            d = s.AddSection
                        else
                            e(l, b)
                            b = {Text = "Dying Color"}
                            v, b.Flag = 168, x .. "dyingColor"
                            w = h[3][3]
                            t = p[3]
                            j = "dyingColor"
                        end
                    elseif v < 75 then
                        if v <= 69 then
                            l(b, w)
                            w = {Text = "Skeleton Color"}
                            j = "skeleton_color"
                            w.Flag = x .. "skeleton_color"
                            w.Default = q[3].skeletonColor
                            t = o:lc({q})
                            v, w.Callback = 85, t
                            l = e.AddColorPicker
                            b = e
                        else
                            t = {}
                            v, t.Text = 923 / v, "Distance"
                            n = "distance"
                            t.Flag = x .. "distance"
                            t.Default = p[3].distance
                            j = o:gc({p})
                            t.Callback = j
                            w = l
                            b = l.AddToggle
                        end
                    elseif v <= 75 then
                        w = w(t, j)
                        v, b.Callback = 249, w
                        l = d
                        e = d.AddColorPicker
                    else
                        w(t, j)
                        v = 146
                        j = {
                            Text = "Arrow Color",
                            Flag = x .. "offScreenArrowColor",
                        }
                        g = p[3]
                        u = "offScreenArrowColor"
                        n = h[3][3]
                    end
                elseif v > 106 then
                    if v <= 124 then
                        if v < 116 then
                            if v < 111 then
                                e(l, b)
                                v = 10
                                b = {
                                    Text = "Healthy Color",
                                    Flag = x .. "healthyColor",
                                }
                                t = p[3]
                                w = h[3][3]
                                j = "healthyColor"
                            elseif v <= 111 then
                                v, j = 123, j(n, o.d(g))
                                t.Transparency = j
                                n = p[3]
                                g = "weaponColor"
                                j = h[4][3]
                            else
                                w(t, j)
                                j = {Text = "Arrow Size"}
                                v, g = v + 133, "arrow_size"
                                j.Flag = x .. "arrow_size"
                                j.Min = 5
                                j.Max = 40
                                j.Default = p[3].offScreenArrowSize
                                j.Suffix = "px"
                                n = o:ic({p})
                                j.Callback = n
                                t = b
                                w = b.AddSlider
                            end
                        elseif v > 123 then
                            v = 247
                            e(l, b)
                            b = {
                                Text = "Text Color",
                                Flag = x .. "healthTextColor",
                            }
                            t = p[3]
                            j = "healthTextColor"
                            w = h[3][3]
                        elseif v <= 116 then
                            t.Transparency = j(n, o.d(g))
                            g = "nameColor"
                            n = p[3]
                            v = 234
                            j = h[4][3]
                        else
                            j = j(n, g)
                            t.Callback = j
                            b, v, w = l.AddColorPicker, 29766 / v, l
                        end
                    elseif v <= 128 then
                        if v >= 126 then
                            if v <= 126 then
                                d(e, l)
                                l = {}
                                v, l.Text = 230, "Box Color"
                                l.Flag = x .. "boxColor"
                                w = p[3]
                                b = h[3][3]
                                t = "boxColor"
                            else
                                v, g = 380 - v, o.c(g(u, m))
                            end
                        else
                            v, t = 192, o.c(t(j, n))
                        end
                    else
                        w = w(t, j)
                        b.Callback = w
                        v, e, l = 22880 / v, d.AddColorPicker, d
                    end
                elseif v >= 94 then
                    if v >= 102 then
                        if v > 105 then
                            v, j = 21518 / v, j(n, g)
                            t.Default = j
                            u = p[3]
                            n = 2
                            g = h[3][3]
                            m = "weaponColor"
                            j = select
                        elseif v <= 102 then
                            d(e, l)
                            l = {Text = "Fill Color"}
                            v = 237
                            l.Flag = x .. "boxFillColor"
                            t = "boxFillColor"
                            b = h[3][3]
                            w = p[3]
                        else
                            t(j, n)
                            n = {Text = "Occluded (Ghost)"}
                            u = "cs2_occluded"
                            n.Flag = x .. "cs2_occluded"
                            n.Default = i[3].occludedColor
                            n.Transparency = i[3].occludedIntensity
                            g = o:Qb({i})
                            n.Callback = g
                            t = w.AddColorPicker
                            v = 248
                            j = w
                        end
                    elseif v > 95 then
                        j.Transparency = n(g, o.d(u))
                        g, n, v, u = p[3], h[4][3], 188 - v, "offScreenArrowColor"
                    elseif v <= 94 then
                        v = 105
                        t(j, n)
                        n = {Text = "Visible (Neon)"}
                        u = "cs2_visible"
                        n.Flag = x .. "cs2_visible"
                        n.Default = i[3].visibleColor
                        n.Transparency = i[3].visibleIntensity
                        g = o:Pb({i})
                        n.Callback = g
                        j = w
                        t = w.AddColorPicker
                    else
                        l = l(b, w)
                        t = {Text = "Name"}
                        n = "name"
                        v = 235
                        t.Flag = x .. "name"
                        t.Default = p[3].name
                        j = o:mc({p})
                        t.Callback = j
                        b = l.AddToggle
                        w = l
                    end
                elseif v > 90 then
                    if v <= 91 then
                        n = n(g, u)
                        v, j.Callback = 15, n
                        w = b.AddColorPicker
                        t = b
                    else
                        v, t = 157, o.c(t(j, n))
                    end
                elseif v >= 85 then
                    if v > 85 then
                        v, n = 12960 / v, n(g, u)
                        j.Default = n
                        m = p[3]
                        g = 2
                        n = select
                        u = h[3][3]
                        c = "tracerColor"
                    else
                        l(b, w)
                        v, w, t = 8075 / v, {}, "Text"
                        w.Title = "Text"
                        t = "Right"
                        w.Side = "Right"
                        l = s.AddSection
                        b = s
                    end
                elseif v <= 83 then
                    p = {
                        [1] = 3,
                        [3] = h[1][3].teamSettings[k],
                    }
                    p[2] = p
                    i = {
                        [1] = 3,
                        [3] = h[2][3][k],
                    }
                    i[2] = i
                    v = 211
                    q = {
                        [1] = 3,
                        [3] = h[5][3][k],
                    }
                    q[2] = q
                    x = k .. "_"
                    _ = {enabled = false, kind = "2D"}
                    a = {[1] = 3, [3] = _}
                    a[2] = a
                    _ = {[1] = 3, [3] = _}
                    _[2] = _
                    _[3], e, l = o:bc({p, a}), {}, "Boxes"
                    e.Title = "Boxes"
                    l = "Left"
                    e.Side = "Left"
                    f = s.AddSection
                    d = s
                else
                    w = w(t, j)
                    v, b.Callback = 5040 / v, w
                    l = d
                    e = d.AddColorPicker
                end
            end
        end
    end,
    Db = function(b, h)
        return function()
            local a = h[2][3]
            local f = Enum.Technology[a]
            h[1][3].Technology = f
        end
    end,
    Hd = function(a, b, c, d)
        a.yd[d] = a.a(b, 35243) + a.a(c, 25031)
        return a.yd[d]
    end,
    ba = function(o, h)
        return function(n, k)
            local m = 50
            local _, b, f, d, p, q, e, i, a, r, l, c
            while true do
                if m >= 76 then
                    if m < 122 then
                        if m < 106 then
                            if m <= 76 then
                                l = {Name = d}
                                m, b = m + -71, {}
                                l.Groups = b
                                e = l
                                l = table.insert
                                c = e
                                b = h[5][3][p]
                            else
                                m = 117
                                p = k.Text
                            end
                        elseif m <= 110 then
                            if m > 106 then
                                r = o.c(r(a))
                                return o.d(r)
                            else
                                m = p and 274 - m or 15 or 15
                            end
                        else
                            i = {
                                [1] = 3,
                                [3] = h[1][3][p],
                            }
                            i[2] = i
                            q = not i[3]
                            m = q and 136 or 8190 / m
                        end
                    elseif m >= 168 then
                        if m >= 173 then
                            if m > 173 then
                                m, p = 42000 / m, "World"
                            else
                                i[3], m, q = q(r, a), 70, h[1][3]
                                q[p] = i[3]
                                a = {}
                                q = h[5][3]
                                r = a
                                q[p] = a
                            end
                        else
                            m = p and 19656 / m or 78 or 78
                        end
                    elseif m > 122 then
                        a = p
                        q = h[2][3]
                        r, m, q = q, 173, q.AddTab
                    else
                        l(b, c)
                        m, l = m + -66, o:sc({
                            i,
                            h[3],
                            h[6],
                            h[4],
                            h[7],
                            h[8],
                        })
                        e.AddSection = l
                    end
                elseif m < 26 then
                    if m <= 5 then
                        if m >= 4 then
                            if m > 4 then
                                l(b, c)
                                m = 122
                                l = table.insert
                                c = e
                                b = q
                            else
                                m = 14 - m
                            end
                        else
                            m = 106
                            p = "Visuals"
                        end
                    elseif m > 10 then
                        q = "Visuals"
                        i = k.Text
                        p = i == "Visuals"
                        m = p and 250 or 183 - m
                    else
                        r, a, _ = r(a)
                        r, a, _ = o.b(r, a, _)
                        f, d = r(a, _)
                        _ = f
                        m = f == nil and 36 - m or 76 or 76
                    end
                elseif m > 50 then
                    if m > 56 then
                        r = ipairs
                        a = k.Pages
                        q = {}
                        m = a and 280 / m or 2100 / m
                    else
                        f, d = r(a, _)
                        _ = f
                        m = f == nil and 82 - m or 76 or 76
                    end
                elseif m <= 30 then
                    if m > 26 then
                        m = 4
                        f = {}
                        d = p
                        f[1] = p
                        a = f
                    else
                        m = 110
                        a = q
                        r = table.unpack
                    end
                else
                    i = k.Text
                    q = "Esp"
                    p = i == "Esp"
                    m = p and 1 or 106 or 106
                end
            end
        end
    end,
    da = function(b, _)
        return function()
            local e = 22
            local f, d
            repeat
                if e <= 22 then
                    if e < 20 then
                        e = 186 - e
                        d(f)
                    elseif e > 20 then
                        f = _[1][3].Unloaded
                        d = not f
                        e = d and 20 or 178 or 178
                    else
                        d = _[1][3]
                        e, d, f = 8, d.Unload, d
                    end
                else
                    return
                end
            until false
        end
    end,
    R = function(b, _)
        return function(enabled)
            _[1][3].Enabled = enabled
        end
    end,
    e = function(e, f, ...)
        local h = {...}
        for i = 1, select("#", ...) do
            e[f + i - 1] = h[i]
        end
    end,
    nb = function(o, h)
        return function(n, k, p, position, g, outline, a)
            local m = 183
            local _, l, b, e, d, f
            repeat
                if m >= 158 then
                    if m >= 183 then
                        if m > 201 then
                            m = 180
                            d = position.Y
                            e = _.Y
                            f = d > e
                        elseif m <= 183 then
                            d = position.X
                            e = 0
                            _ = workspace.CurrentCamera.ViewportSize
                            f = d < 0
                            m = f and 141 or 179 or 179
                        else
                            return
                        end
                    elseif m > 179 then
                        m = f and 201 or 84 or 84
                    elseif m > 158 then
                        d = position.Y
                        e = 0
                        m, f = 25239 / m, d < 0
                    else
                        f = f(d, e, l)
                        d = tostring
                        m = 88
                        e = p
                    end
                elseif m >= 112 then
                    if m <= 125 then
                        if m > 112 then
                            e = _.X
                            d = position.X
                            m = 112
                            f = d > e
                        else
                            m = f and m + 68 or m + 99
                        end
                    else
                        m = f and 112 or 125 or 125
                    end
                elseif m > 84 then
                    f.Text = d(e)
                    f.Position = position
                    l = h[2][3]
                    m = 75
                    f.Size = l.sharedSettings.textSize
                    f.Font = l.sharedSettings.textFont
                    f.Center = true
                    f.Outline = outline
                    f.OutlineColor = h[4][3]
                    d = h[3][3]
                    e = f
                    b = a
                    l = g
                elseif m > 75 then
                    l, m, d, e, f = "Text", 242 - m, n, k, h[1][3]
                else
                    d(e, l, b)
                    return
                end
            until false
        end
    end,
    jd = function(a, b, c, d)
        a.hd[d] = a.a(b, 52209) - c
        return a.hd[d]
    end,
    ua = function(b, h)
        return function(boxOutlineThickness)
            local a
            a.teamSettings.npc.boxOutlineThickness = boxOutlineThickness
            a.teamSettings.players.boxOutlineThickness = boxOutlineThickness
        end
    end,
    va = function(b, h)
        return function()
            local m = 155
            local e, d, f, k, a, i, n, _, j
            while true do
                if m >= 75 then
                    if m >= 155 then
                        if m > 175 then
                            n = h[1][3].fog.enabled
                            m = n and 423 - m or 385 - m
                        elseif m < 162 then
                            d = 132
                            e = 132
                            a = 217
                            f = 143
                            _ = 19
                            j = 224
                            n = h[1][3].ambient.enabled
                            m = n and 53 or 5 or 5
                        elseif m <= 162 then
                            n = h[2][3]
                            m, n.GlobalShadows = 81, true
                            n.ShadowSoftness = h[1][3].shadows.softness
                        else
                            i = h[1][3]
                            n = h[2][3]
                            n.FogStart = i.fog.s
                            n.FogEnd = i.fog.e
                            n.FogColor = i.fog.color
                            m = d <= e and 23975 / m or m + -100
                        end
                    elseif m < 81 then
                        m = 64
                        i = h[1][3]
                        n = h[2][3]
                        n.Brightness = i.light.brightness
                        n.ExposureCompensation = i.light.exposure
                        n.EnvironmentDiffuseScale = i.light.diffuse
                        n.EnvironmentSpecularScale = i.light.specular
                    elseif m <= 81 then
                        return
                    else
                        n = h[1][3].light.enabled
                        m = n and 75 or 64 or 64
                    end
                elseif m >= 50 then
                    if m < 53 then
                        i = h[1][3]
                        n = h[2][3]
                        n.ColorShift_Top = i.colorShift.top
                        m, k = 2200 / m, i.colorShift.bottom
                        n.ColorShift_Bottom = k
                    elseif m <= 53 then
                        n = h[2][3]
                        i = h[1][3]
                        n.Ambient = i.ambient.a
                        n.OutdoorAmbient = i.ambient.b
                        m = j <= a and 2650 / m or 5 or 5
                    else
                        n = h[1][3].shadows.enabled
                        m = n and 162 or 81 or 81
                    end
                elseif m <= 36 then
                    if m <= 5 then
                        n = h[1][3].colorShift.enabled
                        m = n and 55 - m or 44 or 44
                    else
                        k = h[1][3].time.value
                        h[2][3].ClockTime = k
                        m = _ > f and 5832 / m or m + 212
                    end
                else
                    n = h[1][3].time.enabled
                    m = n and 80 - m or m + 204
                end
            end
        end
    end,
    Nb = function(b)
        return function()
            local e = 244
            local c, d, f
            repeat
                if e <= 108 then
                    if e <= 45 then
                        d = b.c(d(f))
                        return b.d(d)
                    else
                        e, d = e + -63, d(f, c)
                        f, d = d, d.GetTeams
                    end
                else
                    d = game
                    c = "Teams"
                    e, f, d = 108, d, d.GetService
                end
            until false
        end
    end,
    Ga = function(b, _)
        return function(visibleCheck)
            _[1][3].VisibleCheck = visibleCheck
        end
    end,
    mc = function(b, _)
        return function(name)
            _[1][3].name = name
        end
    end,
    Ua = function(b, _)
        return function(d)
            local e = 19
            local a, c, f
            while true do
                if e > 19 then
                    f(c, a)
                    return
                else
                    f = _[1][3]
                    a = d
                    e, f, c = 70, f.SetWatermarkVisibility, f
                end
            end
        end
    end,
    Ma = function(o, h)
        return function(n)
            local m = 200
            local e, c, _, g, l, j, k, a, i, f
            repeat
                if m > 128 then
                    if m <= 200 then
                        if m < 159 then
                            if m <= 138 then
                                c(i, g)
                                m = 49
                                g = j.ui_keybinds
                                i = g.Value
                                h[3][3].KeybindFrame.Visible = i
                                c = h[4][3]
                            else
                                m = 138
                                c(i, o.d(g))
                                j = h[6][3]
                                c = h[3][3]
                                i, g, c = c, j.ui_watermark.Value, c.SetWatermarkVisibility
                            end
                        elseif m <= 159 then
                            m, _ = m + -120, o.c(_(f))
                            j, g = g, g.format
                        else
                            e = 203
                            l = 141
                            k = h[1][3] + n
                            c, k, h[1][3] = 1, h[2][3], k
                            k, c, h[2][3] = h[1][3], 0.25, k + 1
                            m = k >= 0.25 and 73 or 74 or 74
                        end
                    elseif m > 215 then
                        return
                    else
                        a = a(_)
                        m = 159
                        f = k[3]
                        _ = math.floor
                    end
                elseif m >= 68 then
                    if m < 74 then
                        if m > 68 then
                            i, m, c = h[1][3], 141 - m, h[2][3]
                            h[5][3], k = c / i, 0
                            h[1][3], h[2][3] = 0, 0
                            k = {[1] = 3, [3] = 0}
                            k[2] = k
                            c = pcall
                            i = o:Mc({k})
                        else
                            c(i)
                            g = "Lean | %d fps | %d ms"
                            c = h[3][3]
                            a, m, _ = math.floor, 283 - m, h[5][3]
                        end
                    elseif m > 74 then
                        k = h[3][3].AccentColor
                        h[7][3], c = k, h[8][3]
                        k, c = c.Sub, h[7][3]
                        m, k.B = 134 - m, c
                        c = h[8][3]
                        k = c.Rebuild
                    else
                        i = h[3][3]
                        k = h[7][3]
                        c = i.AccentColor
                        m = k ~= c and m + 54 or 226 or 226
                    end
                elseif m > 39 then
                    c()
                    m = e < l and 128 or 74 or 74
                elseif m <= 6 then
                    m = m + 220
                    k()
                else
                    m, g = 157, o.c(g(j, a, o.d(_)))
                    i, c = c, c.SetWatermark
                end
            until false
        end
    end,
    ec = function(b, _)
        return function(weapon)
            _[1][3].weapon = weapon
        end
    end,
    gc = function(b, _)
        return function(distance)
            _[1][3].distance = distance
        end
    end,
    Sb = function(b, _)
        return function(weaponOutline)
            _[1][3].weaponOutline = weaponOutline
        end
    end,
    xa = function(b, _)
        return function()
            local e = 116
            local c, f, d
            repeat
                if e >= 116 then
                    d = _[1][3]
                    c = false
                    e, f, d = 83, d, d.SetWaveEnabled
                else
                    d(f, c)
                    return
                end
            until false
        end
    end,
    yc = function(b, h)
        return function(d, k)
            local e = 195
            local j, c, a, i, g, _
            while true do
                if e >= 120 then
                    if e < 195 then
                        i(g, j)
                        e = a < _ and e + -11 or 195 or 195
                    elseif e <= 195 then
                        _ = 248
                        a = 216
                        e, k = 234, {[1] = 3, [3] = k}
                        k[2] = k
                        g = b:Ec({
                            h[2],
                            k,
                        })
                        c = h[1][3]
                        i = h[2][3]
                    else
                        c = c(i, g)
                        i = k[3].Callback
                        e = i and e + -216 or 109 or 109
                    end
                elseif e <= 18 then
                    j, i, e, g = k[3].Callback, c.OnChanged, 2160 / e, c
                else
                    return c
                end
            end
        end
    end,
    M = function(b, h)
        return function(n)
            local m = 110
            local c, d, f, k, e, _, i, g, a, j
            repeat
                if m <= 124 then
                    if m >= 76 then
                        if m <= 110 then
                            if m >= 100 then
                                if m > 100 then
                                    m, n.BorderSizePixel = 134, 0
                                    c = h[1][3]
                                    n.BackgroundColor3 = c.BackgroundColor
                                    i = n
                                    g = {}
                                    j = "BackgroundColor"
                                    k = c
                                    g.BackgroundColor3 = "BackgroundColor"
                                    k, c = k.AddToRegistry, k
                                else
                                    g, j = k(c, i)
                                    i = g
                                    m = g == nil and 5300 / m or 106 - m
                                end
                            else
                                m = a and 145 or m + 24
                            end
                        elseif m <= 114 then
                            d = j.Size
                            f = 1
                            _ = d.X.Scale
                            m = 129
                            a = _ == 1
                        else
                            m = 12400 / m
                            a(_, f, d, e)
                        end
                    elseif m <= 38 then
                        if m >= 8 then
                            if m > 8 then
                                j = false
                                m = 8
                                i = n
                                g = 3
                                k = h[1][3]
                                k, c = k.StyleSurface, k
                            else
                                m = 1992 / m
                                k(c, i, g, j)
                            end
                        else
                            a, _, m, f = j.IsA, j, 142 - m, "Frame"
                        end
                    elseif m > 53 then
                        k, c, i = k(b.d(c))
                        k, c, i = b.b(k, c, i)
                        g, j = k(c, i)
                        i = g
                        m = g == nil and 53 or 6 or 6
                    else
                        return
                    end
                elseif m > 186 then
                    if m > 234 then
                        k = ipairs
                        c = n.GetChildren
                        m = 186
                        i = n
                    elseif m > 226 then
                        a = h[1][3]
                        e = false
                        f = j
                        d = 3
                        m, a, _ = 124, a.StyleSurface, a
                    else
                        d = j.Size
                        m = 76
                        _ = d.Y.Scale
                        f = 1
                        a = _ == 1
                    end
                elseif m > 136 then
                    if m > 145 then
                        m, c = 72, b.c(c(i))
                    else
                        j.BorderSizePixel = 0
                        _ = h[1][3]
                        a = _.StyleSurface
                        m = a and m + 89 or m + -45
                    end
                elseif m > 134 then
                    a = a(_, f)
                    m = a and 250 - m or 129 or 129
                elseif m > 129 then
                    k(c, i, g)
                    c = h[1][3]
                    k = c.StyleSurface
                    m = k and 38 or 249 or 249
                else
                    m = a and 226 or 9804 / m
                end
            until false
        end
    end,
    fb = function(o)
        return function(z, k, p)
            local v = 42
            local j, f, b, l, c, r, A, g, _, u, w, i, t, y, q, x, m, d, e, a
            repeat
                if v < 117 then
                    if v >= 45 then
                        if v <= 90 then
                            if v <= 81 then
                                if v <= 46 then
                                    if v > 45 then
                                        v, g = 5796 / v, A + j
                                    else
                                        g, i = q, g
                                        v = g and 8235 / v or 117 or 117
                                    end
                                else
                                    r = r(y)
                                    y = l.Y
                                    u = m + r * y
                                    c, v, r = math.abs, 20088 / v, t.Z
                                end
                            else
                                m = m(c)
                                u = m * l.Z
                                v, A, r = 226 - v, g + u, math
                                c, r = r.abs, b.Y
                            end
                        elseif v <= 110 then
                            if v > 92 then
                                c = c(r)
                                v = 90
                                r = l.Y
                                g = u + c * r
                                c = t.X
                                m = math.abs
                            else
                                j = j(A, g, u)
                                A = d.Position + k
                                g = i
                                v = g and 147 or v + -69
                            end
                        else
                            v, g = 117, g(u, m)
                        end
                    elseif v >= 23 then
                        if v <= 34 then
                            if v <= 27 then
                                if v <= 23 then
                                    v = g and 45 or v + 227
                                else
                                    v, m = 2970 / v, m(c)
                                    u = m * l.X
                                    c = math.abs
                                    r = w.X
                                end
                            else
                                r = r(y)
                                y = l.Y
                                u = m + r * y
                                v, c, r = v + -16, math.abs, t.Y
                            end
                        else
                            x = ipairs
                            a = z.parts
                            v = 217
                            q = nil
                            i = nil
                        end
                    elseif v > 14 then
                        v, c = 2484 / v, c(r)
                        m = c * l.Z
                        g = u + m
                        c = math.abs
                        r = b.Z
                    elseif v <= 11 then
                        v, g = 34 - v, g(u, m)
                    else
                        x = not i
                        v = x and v + 119 or 131 or 131
                    end
                elseif v > 153 then
                    if v >= 218 then
                        if v > 248 then
                            v = 45
                            g = A - j
                        elseif v >= 247 then
                            if v <= 247 then
                                e = d.CFrame
                                l = d.Size * 0.5
                                t = e.LookVector
                                b = e.RightVector
                                w = e.UpVector
                                A = Vector3
                                j = A.new
                                m, v, c = math.abs, v + -220, b.X
                            else
                                c = c(r)
                                r = l.Z
                                m = c * r
                                v, u = 92, u + m
                            end
                        else
                            a = o.c(a(_, f, d))
                            return x, o.d(a)
                        end
                    elseif v > 190 then
                        x, a, _ = x(a)
                        x, a, _ = o.b(x, a, _)
                        f, d = x(a, _)
                        _ = f
                        v = f == nil and 231 - v or 153 or 153
                    elseif v > 183 then
                        f, d = x(a, _)
                        _ = f
                        v = f == nil and 14 or 153 or 153
                    else
                        g, u, v, m = q.Max, q, 21228 / v, A + j
                    end
                elseif v < 136 then
                    if v >= 131 then
                        if v > 131 then
                            x = p
                            _ = 2
                            f = 5
                            a = Vector3.new
                            v, d = 28994 / v, 2
                        else
                            return (i + q) * 0.5, q - i
                        end
                    elseif v > 117 then
                        v, q = v + 64, g
                    else
                        v = g and 243 - v or 46 or 46
                    end
                elseif v < 147 then
                    if v > 136 then
                        v, c = 81, c(r)
                        m = c * l.X
                        r = math.abs
                        y = w.Z
                    else
                        c = c(r)
                        v = 34
                        m = c * l.X
                        y = w.Y
                        r = math.abs
                    end
                elseif v > 147 then
                    e = d.Parent
                    v = e and 247 or 190 or 190
                else
                    v, u, m, g = 158 - v, i, A - j, i.Min
                end
            until false
        end
    end,
    Lc = function(o, h)
        return function(n, k, p, i, ...)
            local m = 132
            local c, j, f, q, d, a, _, l, e
            while true do
                if m < 132 then
                    if m <= 42 then
                        if m > 41 then
                            j = n
                            m = 154
                            d = o.c(...)
                            f = i
                            a = k
                            _ = p
                        elseif m <= 30 then
                            if m > 10 then
                                a = a()
                                q = j[a]
                                j = q
                                m = q and 1470 / m or 168 - m
                            else
                                m = 222
                                d = table.clone
                                e = i
                            end
                        else
                            m = d and 51 - m or 1722 / m
                        end
                    elseif m <= 67 then
                        if m > 49 then
                            j = j(a)
                            j.ProjectileSpeed = i.Speed
                            m, a = 10586 / m, i.Gravity
                            j.ProjectileGravity = a
                            a = pcall
                            f = h[1][3]
                            f, _, e, d = i.Origin, f.Direction, q, j
                        else
                            m = 169
                            a = type
                            _ = i
                        end
                    else
                        d(e, l)
                        d = a
                        m = a and 180 or 2788 / m
                    end
                elseif m <= 169 then
                    if m >= 154 then
                        if m < 158 then
                            j = o.c(j(a, _, f, o.d(d)))
                            return o.d(j)
                        elseif m <= 158 then
                            a, _ = a(_, f, d, e)
                            f = {}
                            l, m, d, e = f, m + -90, table.insert, q.projectiles
                        else
                            a = a(_)
                            m, _ = m + -31, "table"
                            j = a == "table"
                        end
                    elseif m > 132 then
                        m = j and 196 or 180 - m
                    else
                        c = 38
                        m = 30
                        j = h[1][3].contexts
                        _ = coroutine
                        a = coroutine.running
                    end
                elseif m < 196 then
                    m, d = 7380 / m, _
                elseif m > 196 then
                    i = d(e)
                    i.Direction = _
                    f.direction = _
                    d = h[1][3].diagnostics
                    l = 1
                    e = d.projectiles + 1
                    d.projectiles = e
                    m = c <= 1 and 180 or 9324 / m
                else
                    m, a = m + -129, table
                    a, j = q.stats, a.clone
                end
            end
        end
    end,
    vb = function(o, h)
        return function(n)
            local m = 123
            local i, l, c, g, e, d, k, _, f, a, j
            while true do
                if m <= 134 then
                    if m >= 89 then
                        if m <= 121 then
                            if m <= 100 then
                                if m < 96 then
                                    m = g and 11 or 145 or 145
                                elseif m > 96 then
                                    m = g and 96 or 240 or 240
                                else
                                    n.DisplayName, l, e = g, 57, 99
                                    g = n.Owner
                                    m = g and 177 or m + 116
                                end
                            elseif m > 114 then
                                m, i = 255 - m, i(g, j)
                            else
                                n.OwnerName = g
                                return true
                            end
                        elseif m > 129 then
                            m = i and 217 or 200 or 200
                        elseif m >= 124 then
                            if m <= 124 then
                                n.Owner = g
                                a = h[2][3]
                                j = n.Owner
                                n.IsLocalPlayer = j == a
                                g = n.Owner
                                m = g and 246 or 12400 / m
                            else
                                g = k
                                m = 50
                                j = "HumanoidRootPart"
                                i = k.FindFirstChild
                            end
                        else
                            k = n.Character
                            c = k
                            m = k and 78 or 143 or 143
                        end
                    elseif m > 50 then
                        if m >= 78 then
                            if m > 78 then
                                m = 163
                                i = k.PrimaryPart
                            else
                                g = "Humanoid"
                                m = 210
                                i = k
                                c = k.FindFirstChildOfClass
                            end
                        else
                            m = g and 6141 / m or m + -23
                        end
                    elseif m < 21 then
                        if m > 0 then
                            n.Alive = false
                            return false
                        else
                            g = g(j, a)
                            m = g and 124 or m + 221
                        end
                    elseif m >= 46 then
                        if m <= 46 then
                            j = i.IsA
                            a = i
                            m = 207
                            _ = "BasePart"
                        else
                            i = i(g, j)
                            m = i and 213 - m or 135 - m
                        end
                    else
                        m, g = 2394 / m, k.Name
                    end
                elseif m >= 210 then
                    if m >= 230 then
                        if m <= 246 then
                            if m < 240 then
                                g = not i
                                m = f > d and m + 0 or 69 or 69
                            elseif m > 240 then
                                j = n.Owner
                                m = 100
                                g = j.DisplayName
                            else
                                m = 96
                                g = c.DisplayName
                            end
                        else
                            j = "Torso"
                            m = 121
                            g = k
                            i = k.FindFirstChild
                        end
                    elseif m >= 217 then
                        if m > 217 then
                            m, g = 27404 / m, n.Owner
                        else
                            g = not c
                            m = g and 69 or 447 - m
                        end
                    elseif m <= 210 then
                        m, c = 353 - m, c(i, g)
                    else
                        m = g and 114 or 21 or 21
                    end
                elseif m < 163 then
                    if m < 145 then
                        i = k
                        d = 45
                        f = 21
                        m = k and 129 or 217 or 217
                    elseif m > 145 then
                        m, i = 217, i(g, j)
                    else
                        n.RootPart = i
                        n.Position = i.Position
                        n.Health = c.Health
                        m = 0
                        n.MaxHealth = c.MaxHealth
                        n.Alive = c.Health > 0
                        a = k
                        g = h[1][3]
                        g, j = g.GetPlayerFromCharacter, g
                    end
                elseif m <= 200 then
                    if m > 177 then
                        j = "UpperTorso"
                        i = k.FindFirstChild
                        m = 159
                        g = k
                    elseif m > 163 then
                        j = n.Owner
                        g = j.Name
                        m = e > l and 212 or 177 or 177
                    else
                        m = i and 21842 / m or 41565 / m
                    end
                else
                    m, j = 296 - m, j(a, _)
                    g = not j
                end
            end
        end
    end,
    r = function(o, h)
        return function()
            local m = 181
            local k, s, i, e, n, d, p, q, _, c, f, l, j, a, r, b
            repeat
                if m >= 165 then
                    if m < 181 then
                        if m < 174 then
                            if m <= 165 then
                                d = d(o.d(e))
                                m, a.Color = 65, d
                            else
                                return
                            end
                        elseif m <= 174 then
                            f = _.Style
                            d = "pulse"
                            m = f == "pulse" and 34800 / m or 239 - m
                        else
                            d = _.Style
                            e = "rainbow"
                            f = d == "rainbow"
                            m = j < n and 242 or 33 or 33
                        end
                    elseif m >= 203 then
                        if m > 203 then
                            m = f and 33 or 174 or 174
                        else
                            m, s = 20, s()
                            p = h[1][3]
                            k = ipairs
                        end
                    elseif m > 181 then
                        e = math.sin
                        c = math
                        b = math.pi
                        m = 92
                        l = s * _.Speed * b
                    else
                        m = 203
                        s = tick
                    end
                elseif m < 65 then
                    if m <= 33 then
                        if m > 20 then
                            f = Vector2.new
                            b = 2
                            m, l, e = m + -15, 1, s * _.Speed % 2
                            d, e = e - 1, 0
                        elseif m > 18 then
                            k, p, i = k(p)
                            k, p, i = o.b(k, p, i)
                            q, r = k(p, i)
                            i = q
                            m = q == nil and 186 - m or 41 or 41
                        else
                            f = f(d, e)
                            m, a.Offset = 1170 / m, f
                        end
                    else
                        a = r.grad
                        _ = r.cfg
                        m = a and 162 or 2665 / m
                    end
                elseif m < 110 then
                    if m <= 65 then
                        q, r = k(p, i)
                        i = q
                        m = q == nil and 231 - m or 41 or 41
                    else
                        m = 110
                        d, e = e(l) + 1, 2
                        f = d / 2
                        c = f
                        e = _.A
                        d = ColorSequence.new
                        b = _.B
                        l, e = e, e.Lerp
                    end
                elseif m > 110 then
                    e = "wave"
                    d = _.Style
                    j = 170
                    n = 191
                    f = d == "wave"
                    m = f and m + 80 or 28512 / m
                else
                    m, e = 275 - m, o.c(e(l, b, c))
                end
            until false
        end
    end,
    pc = function(b, _)
        return function(healthText)
            _[1][3].healthText = healthText
        end
    end,
    Wa = function(b, _)
        return function()
            local e = 28
            local d, f, c
            repeat
                if e <= 28 then
                    c = false
                    e = 130
                    d = _[1][3]
                    f, d = d, d.SetTitleWaveEnabled
                else
                    d(f, c)
                    return
                end
            until false
        end
    end,
    Hb = function(b, _)
        return function()
            local e = 240
            local f, d, c
            while true do
                if e <= 131 then
                    if e > 129 then
                        e, d, f = e + -2, _[2][3], _[3][3]
                    elseif e <= 125 then
                        return
                    else
                        e = 125
                        d(f)
                    end
                elseif e <= 240 then
                    f = _[1][3]
                    e, c, f = 241, f, f.MouseIsOverOpenedFrame
                else
                    f = f(c)
                    d = not f
                    e = d and 131 or 125 or 125
                end
            end
        end
    end,
    Y = function(b, h)
        return function()
            local m = 155
            local i, e, g, k, c, n, d, _, f, a, j
            while true do
                if m < 146 then
                    if m <= 58 then
                        if m < 47 then
                            j(a, _)
                            m = d > e and 146 or m + 47
                        elseif m <= 47 then
                            i, g = n(k, c)
                            c = i
                            m = i == nil and 146 or 58 or 58
                        else
                            f = 8
                            j = i.sub
                            m = 242
                            a = i
                            _ = 1
                        end
                    else
                        a, _, m, j = g, false, 108 - m, g.SetValue
                    end
                elseif m <= 168 then
                    if m > 155 then
                        n, k, c = n(k)
                        n, k, c = b.b(n, k, c)
                        i, g = n(k, c)
                        c = i
                        m = i == nil and 24528 / m or 58 or 58
                    elseif m <= 146 then
                        m = 210
                        c = {}
                        n = h[3][3]
                        c.Title = "Whitelist"
                        c.Description = "All teams cleared."
                        i = 3
                        c.Lifetime = 3
                        n, k = n.Notify, n
                    else
                        e = 206
                        d = 100
                        c = {}
                        m, h[1][3].teams = 168, c
                        n = pairs
                        k = h[2][3]
                    end
                elseif m <= 210 then
                    n(k, c)
                    return
                else
                    j = j(a, _, f)
                    a = "wl_team_"
                    m = j == "wl_team_" and 108 or 47 or 47
                end
            end
        end
    end,
    Qa = function(b, _)
        return function(hitscan)
            _[1][3].Hitscan = hitscan
        end
    end,
    L = function(b, _)
        return function(diffuse)
            _[1][3].light.diffuse = diffuse
        end
    end,
    yd = {},
    Ac = function(b)
        return function(d, visible)
            d.DisplayFrame.Visible = visible
        end
    end,
    h = function(b, h)
        return function(l)
            local m = 38
            local c, k, j, a, _, g, i, f
            repeat
                if m >= 110 then
                    if m > 179 then
                        if m <= 203 then
                            m, i = 39, b.c(i(g))
                        else
                            c.Font = i
                            c, m, g = ipairs, 51156 / m, h[1][3]
                            i = g.Root
                            i, g = i.GetDescendants, i
                        end
                    elseif m > 151 then
                        m = 68
                        _ = h[1][3].Apply
                        f = a
                    elseif m >= 126 then
                        if m <= 126 then
                            m = 252
                            g = Enum.Font
                            i = g.Code
                        end
                    else
                        c = h[1][3]
                        c.UIName = l
                        c.Face = k
                        c.Version = c.Version + 1
                        c = h[2][3]
                        g = h[1][3].Builtins
                        i = g[l]
                        m = i and 362 - m or 13860 / m
                    end
                elseif m < 39 then
                    if m > 22 then
                        m = 5
                        c = l
                        k = h[1][3].Resolve
                    elseif m <= 5 then
                        k = k(c)
                        i = h[2][3]
                        c = i.Unloaded
                        m = c and 755 / m or 110 or 110
                    else
                        return
                    end
                elseif m >= 58 then
                    if m <= 58 then
                        j, a = c(i, g)
                        g = j
                        m = j == nil and m + -36 or 179 or 179
                    else
                        m = 3944 / m
                        _(f)
                    end
                else
                    c, i, g = c(b.d(i))
                    c, i, g = b.b(c, i, g)
                    j, a = c(i, g)
                    g = j
                    m = j == nil and 61 - m or 179 or 179
                end
            until false
        end
    end,
    o = function(o, h)
        return function()
            local m = 206
            local p, q, d, g, e, k, r, _, f, b, a, i, s, j
            while true do
                if m > 154 then
                    if m < 195 then
                        if m > 182 then
                            _ = _(f)
                            m = _ and 290 - m or 154 or 154
                        else
                            m, _ = 369 - m, a.picker
                            _, f = _.GetState, _
                        end
                    elseif m > 206 then
                        f, b, m, d = math.max, a.label, 411 - m, s
                        e = b.TextBounds.X + 16
                    elseif m > 195 then
                        m = 152
                        s = 180
                        k = 0
                        p = ipairs
                        i = h[1][3]
                    else
                        m, f = 77, f(d, e)
                        s, f = f, 18
                        k = k + 18
                    end
                elseif m > 126 then
                    if m <= 152 then
                        if m > 148 then
                            p, i, q = p(i)
                            p, i, q = o.b(p, i, q)
                            r, a = p(i, q)
                            q = r
                            m = r == nil and 75 or 182 or 182
                        else
                            f = a.toggle
                            _ = f.Value
                            m = g > j and m + 6 or 26936 / m
                        end
                    else
                        f = a.label
                        f.Visible = _
                        m = _ and 370 - m or m + -77
                    end
                elseif m >= 103 then
                    if m > 103 then
                        p.Size = i(q, r)
                        return
                    else
                        j = 167
                        g = 180
                        f = a.toggle
                        _ = not f
                        m = _ and 154 or 148 or 148
                    end
                elseif m > 75 then
                    r, a = p(i, q)
                    q = r
                    m = r == nil and 5775 / m or 182 or 182
                else
                    m, i = 201 - m, h[2][3]
                    p = i.KeybindFrame
                    q = s
                    i = UDim2.fromOffset
                    r = k + 28
                end
            end
        end
    end,
    N = function(b)
        return function(d, f)
            local e = 254
            local g, c, a
            repeat
                if e <= 177 then
                    if e < 108 then
                        if e > 35 then
                            e = 189
                            c(a, g)
                        else
                            e = c and 108 or e + 154
                        end
                    elseif e > 108 then
                        e, c = 6195 / e, d.SetVisible
                    else
                        c = d.SetVisible
                        e = 73
                        g = f
                        a = d
                    end
                elseif e <= 189 then
                    return
                else
                    c = d
                    e = d and 177 or 35 or 35
                end
            until false
        end
    end,
    mb = function(b)
        return function(l)
            local m = 236
            local _, a, k, d, g, i, j, f, c
            while true do
                if m < 162 then
                    if m < 59 then
                        if m <= 41 then
                            m, _, a = m + 191, j, j.Remove
                        end
                    elseif m <= 67 then
                        if m <= 59 then
                            g, j = k(c, i)
                            i = g
                            m = g == nil and m + -3 or 5133 / m
                        else
                            k, c, i = k(c)
                            k, c, i = b.b(k, c, i)
                            g, j = k(c, i)
                            i = g
                            m = g == nil and m + 95 or 41 or 41
                        end
                    else
                        m = 242
                        _ = j
                        a = j.Destroy
                    end
                elseif m <= 236 then
                    if m < 232 then
                        if m <= 162 then
                            m = 178
                            f = 183
                            c = l.adornments
                            d = 219
                            k = pairs
                        else
                            k, c, i = k(c)
                            k, c, i = b.b(k, c, i)
                            g, j = k(c, i)
                            i = g
                            m = g == nil and 234 - m or 265 - m
                        end
                    elseif m <= 232 then
                        m = 477 - m
                        a(_)
                    else
                        k = pairs
                        m = 67
                        c = l.drawings
                    end
                elseif m <= 242 then
                    a(_)
                    m = f <= d and 59 or 404 - m
                else
                    g, j = k(c, i)
                    i = g
                    m = g == nil and 162 or m + -204
                end
            end
        end
    end,
    od = function(a, b, c, d)
        a.md[d] = a.Oc(b, c)
        return a.md[d]
    end,
    Gb = function(b, h)
        return function()
            local e = 118
            local d, g
            while true do
                if e < 118 then
                    return
                elseif e > 118 then
                    h[1][3].Button.TextTransparency = 0.3
                    e = g < 0.3 and 118 or e + -127
                else
                    g = 85
                    d = not h[1][3].Active
                    e = d and 240 or 113 or 113
                end
            end
        end
    end,
    E = function(b, _)
        return function(exposure)
            _[1][3].light.exposure = exposure
        end
    end,
    oa = function(b, _)
        return function(visible)
            _[1][3].KeybindFrame.Visible = visible
        end
    end,
    l = function(b, h)
        return function(d, f)
            local e = 219
            local j, i, a, g, c
            while true do
                if e < 137 then
                    if e <= 47 then
                        if e <= 32 then
                            if e <= 5 then
                                c(i, g)
                                e = j > a and 104 or 47 or 47
                            else
                                c = "Title"
                                e = d == "Title" and 194 or e + 159
                            end
                        else
                            return
                        end
                    else
                        e = 140
                        i = h[3][3]
                        i[d].Style = f
                        c = i.Rebuild
                    end
                elseif e >= 191 then
                    if e > 194 then
                        j = 89
                        c = h[1][3]
                        a = 96
                        e = c and 32 or 104 or 104
                    elseif e > 191 then
                        e = 137
                        c = h[2][3]
                        g = f
                        i, c = c, c.SetTitleWaveStyle
                    else
                        g = f
                        c = h[2][3]
                        i, e, c = c, 5, c.SetWaveStyle
                    end
                elseif e > 137 then
                    e = 6580 / e
                    c()
                else
                    e = e + -90
                    c(i, g)
                end
            end
        end
    end,
    Ha = function(b, h)
        return function(d)
            local e = 225
            local f, g, c, a
            repeat
                if e < 225 then
                    f(c, a, g)
                    return
                else
                    f = h[1][3]
                    a = nil
                    e = 150
                    c = "Sub"
                    g = d
                end
            until false
        end
    end,
    ta = function(b, _)
        return function(d)
            local e = 97
            local f, c, a
            repeat
                if e < 97 then
                    f(c, a)
                    return
                else
                    a = d
                    f = _[1][3]
                    e = 15
                    c = "Sub"
                end
            until false
        end
    end,
    Jb = function(b, h)
        return function()
            local i = h[2][3].shadows.tech
            local f = Enum.Technology[i]
            h[1][3].Technology = f
        end
    end,
    Bd = function(a, b, c, d)
        a.yd[d] = a.Qc(b, c)
        return a.yd[d]
    end,
    qd = function(a, b, c, d)
        a.pd[d] = b / c
        return a.pd[d]
    end,
    bb = function(b)
        return function(d)
            local e = 98
            local c, g, k, j, i
            while true do
                if e < 134 then
                    if e < 80 then
                        if e > 10 then
                            k, c, i = k(c)
                            k, c, i = b.b(k, c, i)
                            g, j = k(c, i)
                            i = g
                            e = g == nil and 148 or 10 or 10
                        else
                            e, j.Visible = 140, false
                        end
                    elseif e <= 80 then
                        g, j = k(c, i)
                        i = g
                        e = g == nil and e + 151 or 152 or 152
                    else
                        k = pairs
                        e = 20
                        c = d.drawings
                    end
                elseif e <= 148 then
                    if e > 140 then
                        c = d.adornments
                        e = 134
                        k = pairs
                    elseif e <= 134 then
                        k, c, i = k(c)
                        k, c, i = b.b(k, c, i)
                        g, j = k(c, i)
                        i = g
                        e = g == nil and 231 or e + 18
                    else
                        g, j = k(c, i)
                        i = g
                        e = g == nil and 148 or 10 or 10
                    end
                elseif e <= 152 then
                    e, j.Visible = 80, false
                else
                    return
                end
            end
        end
    end,
    Id = function(a, b, c, d)
        a.Dd[d] = a.a(b, 30153) + c
        return a.Dd[d]
    end,
    rd = function(a, b, c, d)
        a.pd[d] = a.Qc(b, c)
        return a.pd[d]
    end,
    rb = function(b, _)
        return function()
            return _[1][3]
        end
    end,
    Wb = function(b, _)
        return function(healthBarOutline)
            _[1][3].healthBarOutline = healthBarOutline
        end
    end,
    hd = {},
    Xb = function(b, _)
        return function(nameOutline)
            _[1][3].nameOutline = nameOutline
        end
    end,
    U = function(b, h)
        return function(n, k, c)
            local m = 4
            local g, f, j, a, e, _, d, i
            repeat
                if m <= 86 then
                    if m < 47 then
                        if m > 25 then
                            m = 134
                            i()
                        elseif m <= 4 then
                            i = h[1][3]
                            _ = 214
                            f = 130
                            m = i and 81 or 183 or 183
                        else
                            m = m + 109
                            i(g, j, a)
                        end
                    elseif m <= 81 then
                        if m <= 77 then
                            if m > 47 then
                                g = h[3][3]
                                i = g[n]
                                i.B = c
                                m = d < e and 134 or 135 or 135
                            else
                                j = k
                                i = h[2][3]
                                a = c
                                g, m, i = i, 7426 / m, i.SetWaveColors
                            end
                        else
                            i = "Title"
                            m = n == "Title" and m + 5 or 47 or 47
                        end
                    else
                        i, j, m, a = h[2][3], k, 2150 / m, c
                        g, i = i, i.SetTitleWaveColors
                    end
                elseif m <= 158 then
                    if m > 143 then
                        m = m + -24
                        i(g, j, a)
                    elseif m >= 135 then
                        if m > 135 then
                            d = 217
                            e = 129
                            m = c and 11011 / m or 135 or 135
                        else
                            g = h[3][3]
                            m = 46
                            i = g.Rebuild
                        end
                    else
                        return
                    end
                elseif m <= 183 then
                    m = k and 40077 / m or 26169 / m
                else
                    g = h[3][3]
                    i = g[n]
                    i.A = k
                    m = _ > f and 143 or 353 - m
                end
            until false
        end
    end,
    ac = function(b, _)
        return function(offScreenArrow)
            _[1][3].offScreenArrow = offScreenArrow
        end
    end,
    ka = function(b, _)
        return function(s)
            _[1][3].fog.s = s
        end
    end,
    Fc = function(o, h)
        return function()
            local m = 115
            local k, i, a, p, b, c, d, l, _, r, n, g, f, e, q
            while true do
                if m < 87 then
                    if m > 26 then
                        if m > 60 then
                            h[1][3]._added[a[3]] = true
                            d = a[3].gsub
                            f = "wl_team_"
                            b = "_"
                            l = "[^%w]"
                            m = 91
                            e = a[3]
                        else
                            n = n(k)
                            m = 87
                            p = n
                            k = ipairs
                        end
                    elseif m <= 18 then
                        if m > 7 then
                            m, n = 78 - m, n(k, p)
                            k, n = n, n.GetTeams
                        else
                            c = 212
                            g = 198
                            a = {
                                [1] = 3,
                                [3] = r.Name,
                            }
                            a[2] = a
                            e = h[1][3]
                            d = e._added
                            f = d[a[3]]
                            m = not f and 75 or 255 or 255
                        end
                    else
                        m = 255
                        f(d, e)
                    end
                elseif m > 135 then
                    if m > 205 then
                        m = c < g and 262 - m or 135 or 135
                    end
                elseif m > 115 then
                    q, r = k(p, i)
                    i = q
                    m = q == nil and 205 or 142 - m
                elseif m < 91 then
                    k, p, i = k(p)
                    k, p, i = o.b(k, p, i)
                    q, r = k(p, i)
                    i = q
                    m = q == nil and 205 or 7 or 7
                elseif m <= 91 then
                    e, _, f = {}, f .. d(e, l, b), h[2][3]
                    e.Text = a[3]
                    e.Flag = _
                    m = 26
                    e.Default = false
                    l = o:Gc({
                        h[1],
                        a,
                    })
                    e.Callback = l
                    f, d = f.AddToggle, f
                else
                    p = "Teams"
                    n = game
                    n, m, k = n.GetService, 18, n
                end
            end
        end
    end,
    T = function(b, _)
        return function(brightness)
            _[1][3].light.brightness = brightness
        end
    end,
    wc = function(b, h)
        return function(d, k)
            local e = 96
            local g, c, i, j
            repeat
                if e <= 96 then
                    if e <= 47 then
                        i(g, j)
                        h[3][3] = c
                        return c
                    else
                        k = {[1] = 3, [3] = k}
                        e, k[2] = 207, k
                        j = {}
                        c = h[1][3]
                        g = k[3].Flag
                        j.Text = k[3].Text
                        j.Default = k[3].Default
                        c, i = c.AddToggle, c
                    end
                else
                    e, c = 47, c(i, g, j)
                    i = c.OnChanged
                    j = b:Cc({
                        k,
                        h[2],
                    })
                    g = c
                end
            until false
        end
    end,
    _b = function(o, h)
        return function(n, k, c, i, g, j, a)
            local m = 45
            local l, d, e, _, f
            while true do
                if m < 112 then
                    if m > 81 then
                        f = n
                        e = "Line"
                        m = 151
                        d = k
                        _ = h[2][3]
                    elseif m > 56 then
                        _, f = _(f, d)
                        c = _
                        i = f
                        _ = not _
                        m = _ and 173 or 97 or 97
                    elseif m > 45 then
                        m = 176
                        f = 1
                    else
                        _ = h[1][3]
                        f = c
                        m = 81
                        d = i
                    end
                elseif m < 173 then
                    if m > 112 then
                        _ = _(f, d, e)
                        _.From = c
                        _.To = i
                        f = j
                        m = j and 176 or 207 - m
                    else
                        f(d, e, l)
                        return _
                    end
                elseif m <= 173 then
                    return nil
                else
                    m, _.Thickness = 19712 / m, f
                    e = g
                    f = h[3][3]
                    d = _
                    l = a
                end
            end
        end
    end,
    C = function(b)
        return function(d, f)
            local e = 130
            local c, i
            repeat
                if e <= 195 then
                    if e <= 130 then
                        if e <= 45 then
                            return d[f], 1
                        else
                            e = 195
                            i = d[f]
                            c = type
                        end
                    else
                        c = c(i)
                        i = "table"
                        e = c == "table" and e + 59 or 45 or 45
                    end
                else
                    i = d[f][2]
                    return d[f][1], i
                end
            until false
        end
    end,
    za = function(b, _)
        return function(bulletDrop)
            _[1][3].BulletDrop = bulletDrop
        end
    end,
    wd = function(a, b, c, d)
        a.ud[d] = a.Oc(b, c)
        return a.ud[d]
    end,
    Uc = function(o, h)
        return function(n)
            local p = 1
            local k = 0
            while true do
                k = k * 85 + ("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#$%&()*+-;<=>?@^_`{|}~"):find(n:sub(p, p), 1, true) - 1
                p = p + 1
                if p > 5 then
                    break
                end
            end
            p = h[1][3]
            local i = h[2][3](k, 24)
            local g = h[3][3](h[2][3](k, 16), 255)
            local j = h[3][3](h[2][3](k, 8), 255)
            local a = h[3][3]
            a = o.c(a(k, 255))
            p = o.c(p(i, g, j, o.d(a)))
            return o.d(p)
        end
    end,
    kd = function(a, b, c, d)
        a.hd[d] = a.a(b, 1835) / c
        return a.hd[d]
    end,
    w = function(b, h)
        return function(d, f)
            local e = 131
            local g, a, c, j, i
            while true do
                if e > 131 then
                    if e > 154 then
                        e = 149
                        c(i, g)
                    elseif e <= 149 then
                        return
                    else
                        c(i, g)
                        e = j <= a and e + -5 or 239 - e
                    end
                elseif e <= 78 then
                    if e < 28 then
                        e, g, c = 229 - e, f, h[2][3]
                        c, i = c.SetWaveSpeed, c
                    elseif e > 28 then
                        a = 236
                        c = "Title"
                        j = 151
                        e = d == "Title" and 106 - e or 15 or 15
                    else
                        c = h[2][3]
                        g = f
                        i, e, c = c, 154, c.SetTitleWaveSpeed
                    end
                elseif e > 85 then
                    c = h[1][3]
                    e = c and 78 or 85 or 85
                else
                    i = h[3][3]
                    e = 149
                    c = i[d]
                    c.Speed = f
                end
            end
        end
    end,
    la = function(b, _)
        return function(specular)
            _[1][3].light.specular = specular
        end
    end,
    H = function(b, _)
        return function(value)
            _[1][3].time.value = value
        end
    end,
    J = function(o, Y)
        return function(z, O)
            local v = 12
            local W, t, c, d, _, m, k, y, D, G, I, n, R, q, x, j, a, w, A, K, T, p, S, M, L, e, r, F, U, g, i, X, V, E, s, h, B, l, H, J, b, Q, P, f, u
            repeat
                if v <= 107 then
                    if v <= 63 then
                        if v < 34 then
                            if v < 18 then
                                if v >= 11 then
                                    if v > 11 then
                                        h = 234
                                        S = 199
                                        A = 145
                                        G = 155
                                        p = workspace.CurrentCamera
                                        i = not p
                                        v = i and 73 or 199 or 199
                                    else
                                        t, j, Q = t(j)
                                        t, j, Q = o.b(t, j, Q)
                                        g, K = t(j, Q)
                                        Q = g
                                        v = g == nil and 2618 / v or 98 or 98
                                    end
                                else
                                    n = I <= x
                                    v = A <= S and 31 or 57 - v
                                end
                            elseif v >= 28 then
                                if v <= 28 then
                                    f = Y[2][3]
                                    U = f.VisibleCheck
                                    n = not U
                                    v = n and v + 153 or 3136 / v
                                else
                                    d = 28
                                    l = 232
                                    v = n and 50 - v or 276 - v
                                end
                            elseif v > 18 then
                                f = M - z
                                U = f.Magnitude
                                v, n = 4655 / v, U <= J
                            else
                                v = 64
                                L = Y[2][3].MaxDistance
                            end
                        elseif v <= 54 then
                            if v <= 51 then
                                if v > 50 then
                                    r, v, M, F = m, 202 - v, m.IsA, "BasePart"
                                elseif v > 34 then
                                    v = M and v + 79 or 209 or 209
                                else
                                    m = m(M, r)
                                    M = m
                                    v = m and 1734 / v or v + 16
                                end
                            elseif v <= 53 then
                                L = L(X)
                                v = L and 3392 / v or 71 - v
                            else
                                v = v + 180
                                r, F = r(F, I)
                                c = r.Y
                                f = r.X
                                U = Vector2.new
                            end
                        elseif v >= 59 then
                            if v > 59 then
                                c, W = c(W, y, D, H, R, a, u)
                                y = c
                                v = c and 185 or v + 68
                            else
                                f = f(c)
                                v = f and 211 or 202 or 202
                            end
                        else
                            M = b
                            v = 34
                            m = b.FindFirstChild
                            r = K
                        end
                    elseif v < 85 then
                        if v > 80 then
                            if v > 81 then
                                v, P = 7626 / v, Y[3][3]
                                b, P = P.Allowed, V
                            else
                                f = U.Magnitude
                                c = 300
                                v = f > 300 and 172 - v or 102 or 102
                            end
                        elseif v < 73 then
                            if v <= 64 then
                                v = 311 - v
                            else
                                t, g, m, v, r, n, I, M, U, F, K = ipairs, {}, "UpperTorso", v + -54, "Torso", "LeftUpperLeg", "RightUpperArm", "LowerTorso", "RightUpperLeg", "LeftUpperArm", "Head"
                                g[1], g[2], g[3], g[4], g[5], g[6], g[7], g[8] = "Head", "UpperTorso", "LowerTorso", "Torso", "LeftUpperArm", "RightUpperArm", "LeftUpperLeg", "RightUpperLeg"
                                j = g
                            end
                        elseif v <= 73 then
                            return nil
                        else
                            U = n.AssemblyLinearVelocity
                            v = k > E and v + -25 or v + 98
                        end
                    elseif v >= 98 then
                        if v >= 104 then
                            if v <= 104 then
                                n = n(U, f, c)
                                v = s <= B and 50 or 181 or 181
                            else
                                _, L, X = _(o.d(L))
                                _, L, X = o.b(_, L, X)
                                e, V = _(L, X)
                                X = e
                                v = e == nil and 146 or 8774 / v
                            end
                        elseif v > 98 then
                            f, v, c = tonumber, 6018 / v, O.ProjectileGravity
                        else
                            M = Y[2][3]
                            m = M.HitPart
                            v = K ~= m and v + 38 or 229 or 229
                        end
                    elseif v <= 91 then
                        if v > 85 then
                            f = Vector3
                            U = Vector3.zero
                            v = l <= d and 91 or 193 - v
                        else
                            e, V = _(L, X)
                            X = e
                            v = e == nil and 146 or 82 or 82
                        end
                    else
                        b = b(P)
                        v = b and 239 or 85 or 85
                    end
                elseif v < 185 then
                    if v >= 136 then
                        if v < 178 then
                            if v >= 146 then
                                if v > 146 then
                                    M = M(r, F)
                                    v = T >= w and 50 or 282 - v
                                else
                                    return q
                                end
                            else
                                v = 208
                                r = K
                                M = P
                                m = table.insert
                            end
                        elseif v < 182 then
                            if v > 178 then
                                v = n and 132 or 209 or 209
                            else
                                v = U and v + -97 or v + 4
                            end
                        elseif v > 182 then
                            v, L = 19688 / v, o.c(L(X))
                        else
                            v = 81
                            U = m.AssemblyLinearVelocity
                        end
                    elseif v <= 129 then
                        if v < 112 then
                            if v <= 110 then
                                y = {player = V, part = m, point = c, time = W}
                                v = 85
                                q = y
                                x = I
                            else
                                t, j, Q = t(j)
                                t, j, Q = o.b(t, j, Q)
                                g, K = t(j, Q)
                                Q = g
                                v = g == nil and 85 or 55 or 55
                            end
                        elseif v > 112 then
                            s = 203
                            M = m.Position
                            B = 202
                            r = p.WorldToViewportPoint
                            v = 54
                            F = p
                            I = M
                        else
                            v, U = v + -8, Y[3][3]
                            f, n, c, U = M, U.Clear, b, z
                        end
                    elseif v > 131 then
                        f = "HumanoidRootPart"
                        v = 191
                        U = b
                        n = b.FindFirstChild
                    else
                        v = y and 110 or 209 or 209
                    end
                elseif v >= 229 then
                    if v >= 238 then
                        if v <= 245 then
                            if v <= 239 then
                                if v <= 238 then
                                    v = 111
                                    t = ipairs
                                    j = P
                                else
                                    T = 193
                                    t = {}
                                    w = 147
                                    b = V.Character
                                    Q = Y[2][3]
                                    t[1] = Q.HitPart
                                    j = Q
                                    P = t
                                    t = Q.Hitscan
                                    v = t and 304 - v or 238 or 238
                                end
                            else
                                v = n and 28 or 181 or 181
                            end
                        else
                            J = J(_, L)
                            _ = ipairs
                            L = Y[4][3]
                            v, X, L = v + -63, L, L.GetPlayers
                        end
                    elseif v >= 233 then
                        if v > 233 then
                            U = U(f, c)
                            n = F
                            I = (U - i).Magnitude
                            v = n and 2 or 265 - v
                        else
                            i = i(q)
                            q = nil
                            v = 53
                            x = Y[2][3].FOV
                            J = math.min
                            _ = Y[2][3].MaxDistance
                            L = tonumber
                            X = O.Range
                        end
                    else
                        g, K = t(j, Q)
                        Q = g
                        v = g == nil and 238 or 327 - v
                    end
                elseif v < 202 then
                    if v <= 191 then
                        if v <= 185 then
                            D = (c - z).Magnitude
                            H = 0.001
                            v, y = 316 - v, D > 0.001
                        else
                            n = n(U, f)
                            U = n
                            v = n and 15280 / v or 33998 / v
                        end
                    else
                        i = Y[1][3]
                        k = 79
                        E = 167
                        i, v, q = i.GetMouseLocation, 233, i
                    end
                elseif v >= 209 then
                    if v <= 209 then
                        g, K = t(j, Q)
                        Q = g
                        v = g == nil and 17765 / v or 11495 / v
                    else
                        W = Y[3][3]
                        u, y, D, H, c, W, R = Y[2][3], M, U, O.ProjectileSpeed, W.AimPoint, z, f
                        v, a, u = 63, u.Prediction, u.BulletDrop
                    end
                elseif v <= 202 then
                    v = 211
                    c = workspace
                    f = workspace.Gravity
                else
                    m(M, r)
                    v = G < h and v + 21 or 258 - v
                end
            until false
        end
    end,
    xc = function(b, h)
        return function(d, k)
            local e = 225
            local j, g, _, c, a, i
            while true do
                if e > 135 then
                    if e > 225 then
                        j = k[3].Callback
                        e = 96
                        i = c.OnChanged
                        g = c
                    else
                        a = 165
                        _ = 76
                        k = {[1] = 3, [3] = k}
                        k[2] = k
                        e = 13
                        g = b:Dc({
                            k,
                            h[2],
                        })
                        c = h[1][3]
                        i = h[2][3]
                    end
                elseif e > 96 then
                    return c
                elseif e > 13 then
                    i(g, j)
                    e = a > _ and 231 - e or 225 or 225
                else
                    c = c(i, g)
                    i = k[3].Callback
                    e = i and e + 222 or 135 or 135
                end
            end
        end
    end,
    La = function(o, h)
        return function(n)
            local m = 15
            local r, k, q, b, c, _, g, p, d, l, i, e, f
            repeat
                if m >= 178 then
                    if m > 202 then
                        if m >= 236 then
                            if m >= 239 then
                                if m > 239 then
                                    c = 56
                                    g = 26
                                    k = n.Character
                                    p = k
                                    m = k and 40 or 213 or 213
                                else
                                    p = h[3][3]
                                    k = p.silent
                                    m = k and 122 or 417 - m
                                end
                            else
                                i = h[2][3]
                                p = n.Parent
                                k = p ~= i
                                m = _ <= f and m + -40 or 35 or 35
                            end
                        elseif m >= 215 then
                            if m <= 215 then
                                return false
                            else
                                r = 0
                                q = p.Health
                                m, i = m + -29, q > 0
                            end
                        else
                            i = k
                            m = k and 409 - m or 54 or 54
                        end
                    elseif m < 196 then
                        if m <= 187 then
                            if m <= 185 then
                                if m > 178 then
                                    i = i(q, r)
                                    m = l < b and m + -18 or 54 or 54
                                else
                                    b = 9
                                    l = 148
                                    m = k and 198 or 6 or 6
                                end
                            else
                                m = k and 167 or 239 or 239
                            end
                        else
                            i = p
                            m = c < g and 1134 / m or m + 11
                        end
                    elseif m > 200 then
                        return i
                    elseif m < 198 then
                        m = 185
                        q = k
                        r = workspace
                        i = k.IsDescendantOf
                    elseif m > 198 then
                        m = i and 231 or 202 or 202
                    else
                        q = n.Team
                        p = h[3][3].teams
                        i = q.Name
                        m, k = 1188 / m, p[i]
                    end
                elseif m > 54 then
                    if m > 144 then
                        if m > 156 then
                            return false
                        else
                            m = k and 17316 / m or 187 or 187
                        end
                    elseif m >= 122 then
                        if m > 122 then
                            return false
                        else
                            k = n.Team
                            m = d >= e and 231 or m + 56
                        end
                    elseif m <= 93 then
                        m, p = 19809 / m, p(i, q)
                    else
                        m = 187
                        p = n.Team
                        q = h[1][3]
                        i = q.Team
                        k = p == i
                    end
                elseif m >= 18 then
                    if m <= 40 then
                        if m > 35 then
                            q, p, m, i = "Humanoid", k.FindFirstChildOfClass, 133 - m, k
                        elseif m > 18 then
                            m = k and 144 or 350 / m
                        else
                            p = h[1][3]
                            m, k = 174 - m, p.Team
                        end
                    else
                        m = i and 189 or m + 146
                    end
                elseif m <= 10 then
                    if m <= 6 then
                        m = k and m + 209 or 256 - m
                    else
                        d = 195
                        p = h[4][3]
                        e = 210
                        k = p.TeamCheck
                        m = k and 28 - m or 156 or 156
                    end
                else
                    p = h[1][3]
                    _ = 77
                    f = 33
                    k = n == p
                    m = k and 35 or 236 or 236
                end
            until false
        end
    end,
    Na = function(b)
        return function()
            local e = 132
            local a, c, d, f
            repeat
                if e > 132 then
                    d = b.c(d(f, c, a))
                    return b.d(d)
                else
                    e = 212
                    f = 1
                    d = Color3.new
                    c = 1
                    a = 1
                end
            until false
        end
    end,
    uc = function(b, h)
        return function(d, f)
            local e = 89
            local g, i, c, _
            repeat
                if e <= 89 then
                    c = h[1][3]
                    g = f.Text
                    _ = f.Callback
                    e, c, i = 217, c.AddButton, c
                else
                    c = b.c(c(i, g, _))
                    return b.d(c)
                end
            until false
        end
    end,
    I = function(o, h)
        return function()
            local m = 69
            local d, s, j, f, p, e, b, n, i, nb, c, l, t, r, a, q, _
            repeat
                if m <= 161 then
                    if m > 93 then
                        if m >= 124 then
                            if m <= 124 then
                                m, i, p, q = 359 - m, ipairs, 0, nb
                            else
                                p = h[1][3]
                                q = {Title = "Whitelist", Description = "No teams found."}
                                r = 3
                                q.Lifetime = 3
                                m, p, i = 117, p.Notify, p
                            end
                        elseif m > 100 then
                            p(i, q)
                            return
                        else
                            m = m + 144
                            i(q, r)
                        end
                    elseif m < 76 then
                        if m > 59 then
                            s = pcall
                            m = 76
                            nb = o:Nb()
                        elseif m > 22 then
                            i = 0
                            m = p > 0 and 197 or 244 or 244
                        else
                            m = 177
                            q = 0
                            i = #nb
                            p = i == 0
                        end
                    elseif m < 82 then
                        s, nb = s(nb)
                        p = not s
                        m = p and 177 or 22 or 22
                    elseif m > 82 then
                        m = 166
                        e(l, b)
                    else
                        f = {
                            [1] = 3,
                            [3] = _.Name,
                        }
                        f[2] = f
                        b = h[2][3]
                        l = b._added
                        e = l[f[3]]
                        m = not e and m + 106 or 166 or 166
                    end
                elseif m >= 197 then
                    if m < 235 then
                        if m > 197 then
                            a, _ = i(q, r)
                            r = a
                            m = a == nil and 281 - m or m + -140
                        else
                            r = {}
                            i = h[1][3]
                            r.Title = "Whitelist"
                            m, _, d = 19700 / m, "Added ", " team(s)."
                            f = p .. " team(s)."
                            r.Description = "Added " .. f
                            r.Lifetime = 3
                            q, i = i, i.Notify
                        end
                    elseif m <= 235 then
                        i, q, r = i(q)
                        i, q, r = o.b(i, q, r)
                        a, _ = i(q, r)
                        r = a
                        m = a == nil and 13865 / m or m + -153
                    else
                        return
                    end
                elseif m < 183 then
                    if m <= 166 then
                        m = j >= n and 36852 / m or 244 or 244
                    else
                        j = 91
                        n = 20
                        m = p and m + -16 or 124 or 124
                    end
                elseif m <= 183 then
                    d, e, b = e .. l(b, c, t), h[3][3], {}
                    b.Text = f[3]
                    m, b.Flag = 17019 / m, d
                    b.Default = false
                    c = o:Mb({
                        h[2],
                        f,
                    })
                    b.Callback = c
                    e, l = e.AddToggle, e
                else
                    h[2][3]._added[f[3]] = true
                    m, d = 371 - m, 1
                    e, b, l, t, p, c = "wl_team_", f[3], f[3].gsub, "_", p + 1, "[^%w]"
                end
            until false
        end
    end,
    yb = function(o, h)
        return function(n, k, p, size, q, filled, a, _)
            local m = 30
            local l, b, c, e, g, d
            repeat
                if m > 82 then
                    if m < 170 then
                        if m <= 132 then
                            d = d(e, l)
                            m, b = 208 - m, Vector2
                            b, l, e = b.zero, p, p.Max
                        else
                            m = 211
                            l = 1
                        end
                    elseif m < 207 then
                        e, c, m, b, l = h[1][3], "Square", m + -118, k, n
                    elseif m <= 207 then
                        return nil
                    else
                        e.Thickness = l
                        g, b, m, c, l = _, e, 5064 / m, q, h[2][3]
                    end
                elseif m <= 67 then
                    if m > 52 then
                        l = size.Y
                        b = 0
                        m = 82
                        e = l <= 0
                    elseif m >= 30 then
                        if m > 30 then
                            e = e(l, b, c)
                            e.Position = p
                            e.Size = size
                            e.Filled = filled
                            l = a
                            m = a and 263 - m or 149 or 149
                        else
                            m = 132
                            d = p + size
                            l, d, e = workspace.CurrentCamera.ViewportSize, d.Min, d
                        end
                    else
                        l(b, c, g)
                        return e
                    end
                elseif m <= 76 then
                    p = e(l, b)
                    size = d - p
                    b = 0
                    l = size.X
                    e = l <= 0
                    m = e and 82 or 67 or 67
                else
                    m = e and 207 or m + 88
                end
            until false
        end
    end,
    Gd = function(a, b, c, d)
        a.Dd[d] = a.a(b, 50036) / a.a(c, 27054)
        return a.Dd[d]
    end,
    pd = {},
    Yb = function(b, _)
        return function(enabled)
            local e = 38
            local f
            while true do
                if e <= 38 then
                    _[1][3].enabled = enabled
                    e = 53
                    f = _[2][3]
                else
                    f()
                    return
                end
            end
        end
    end,
    v = function(b, _)
        return function(bottom)
            _[1][3].colorShift.bottom = bottom
        end
    end,
    Sa = function(b, _)
        return function(showFOV)
            _[1][3].ShowFOV = showFOV
        end
    end,
    ib = function(o, h)
        return function(s)
            local v = 16
            local t, g, r, q, d, a, k, p, m, j, i, n, b, f, w, u, _
            repeat
                if v <= 117 then
                    if v >= 41 then
                        if v >= 90 then
                            if v > 103 then
                                if v >= 114 then
                                    if v > 114 then
                                        a(_)
                                        a = h[1][3].objects
                                        _ = nil
                                        v, a[q] = 336 - v, nil
                                    else
                                        h[3][3][q] = nil
                                        f = h[6][3]
                                        _ = nil
                                        a = f.Replicator.Actors
                                        a[q] = nil
                                        v = t >= j and 14 or v + 32
                                    end
                                else
                                    _ = _(f, d)
                                    a = not _
                                    v = a and 24289 / v or 13161 / v
                                end
                            elseif v < 94 then
                                if v <= 90 then
                                    v = 55
                                    _ = q
                                    a = h[5][3]
                                else
                                    q = 0.4
                                    k.scanAt = i() + 0.4
                                    k = ipairs
                                    v = 136
                                    p = h[2][3]
                                    p, i = p.GetPlayers, p
                                end
                            elseif v > 94 then
                                v = _ and 8 or 13 or 13
                            else
                                v, f = 6956 / v, h[1][3]
                                f, _ = a, f.Kind
                            end
                        elseif v < 58 then
                            if v <= 53 then
                                if v <= 41 then
                                    f = r.model
                                    v = 1
                                    _ = q.Character
                                    a = _ ~= f
                                else
                                    f, v, _ = q, 13197 / v, h[1][3].Kind
                                end
                            else
                                v = 14
                                a(_)
                            end
                        elseif v >= 74 then
                            if v > 74 then
                                _ = q.IsDescendantOf
                                f = q
                                v = 107
                                d = workspace
                            else
                                _ = _(f)
                                v = _ and 223 - v or 103 or 103
                            end
                        elseif v > 58 then
                            k = k()
                            i = k
                            p = pairs
                            v = k and 226 or v + 80
                        else
                            p = p()
                            q = h[1][3]
                            i = q.scanAt
                            v = 235
                            k = p < i
                        end
                    elseif v > 17 then
                        if v <= 35 then
                            if v > 33 then
                                r = h[4][3]
                                v = 199
                                i = h[6][3].Replicator.Actors
                                p.Replicator.LocalActor = i[r.Character]
                                q = h[1][3]
                                k = pairs
                                p = q.objects
                            elseif v > 30 then
                                q, r = k(p, i)
                                i = q
                                v = q == nil and 163 or v + 151
                            elseif v > 27 then
                                _ = r
                                v = 117
                                a = h[7][3]
                            else
                                return
                            end
                        elseif v > 36 then
                            f = {
                                actor = a,
                                model = a.Character,
                                drawings = {},
                            }
                            v, d = 193 - v, {}
                            f.adornments = d
                            f.nextRay = 0
                            _ = f
                            h[1][3].objects[a] = f
                            d = f
                            f = h[8][3]
                        else
                            v, d, f = v + 86, _, h[8][3]
                        end
                    elseif v <= 13 then
                        if v < 8 then
                            if v <= 1 then
                                v = a and 246 or 251 or 251
                            else
                                _ = _(f, d)
                                v, a = 454 / v, not _
                            end
                        elseif v > 9 then
                            r, a = p(i, q)
                            q = r
                            v = r == nil and 186 or 94 or 94
                        elseif v <= 8 then
                            d = h[1][3]
                            _ = d.objects[a]
                            f = not _
                            v = f and 47 - v or 36 or 36
                        else
                            r = {}
                            v, i = 2070 / v, r
                        end
                    elseif v < 16 then
                        q = k(p, i)
                        i = q
                        v = q == nil and 490 / v or 97 - v
                    elseif v > 16 then
                        v = i and 230 or v + -8
                    else
                        m = 154
                        k = not s
                        u = 39
                        v = k and 241 or 235 or 235
                    end
                elseif v >= 199 then
                    if v < 228 then
                        if v > 225 then
                            if v > 226 then
                                v = a and 114 or 90 or 90
                            else
                                i = k.Replicator
                                v = n >= g and v + 1 or v + -81
                            end
                        elseif v <= 219 then
                            if v >= 212 then
                                if v <= 212 then
                                    r = k.Replicator
                                    i = r.Actors
                                    v = u <= m and 229 - v or 442 - v
                                else
                                    q, r = k(p, i)
                                    i = q
                                    v = q == nil and 365 - v or 53 or 53
                                end
                            else
                                k, p, i = k(p)
                                k, p, i = o.b(k, p, i)
                                q, r = k(p, i)
                                i = q
                                v = q == nil and 345 - v or 53 or 53
                            end
                        else
                            k, p, i = k(o.d(p))
                            k, p, i = o.b(k, p, i)
                            q, r = k(p, i)
                            i = q
                            v = q == nil and 163 or 184 or 184
                        end
                    elseif v > 241 then
                        if v >= 249 then
                            if v <= 249 then
                                _ = _(f)
                                a = not _
                                v = a and 1 or 41 or 41
                            else
                                f = r.model
                                _ = f.Parent
                                v, a = 61746 / v, not _
                            end
                        else
                            v = a and 30 or 219 or 219
                        end
                    elseif v > 235 then
                        v = 58
                        i = os
                        p = os.clock
                    elseif v >= 230 then
                        if v > 230 then
                            b = 133
                            w = 43
                            v = k and 27 or 415 - v
                        else
                            v = v + -86
                        end
                    else
                        a(_)
                        v = b < w and 83 or 261 - v
                    end
                elseif v <= 146 then
                    if v >= 142 then
                        if v < 145 then
                            if v > 142 then
                                p, i, q = p(i)
                                p, i, q = o.b(p, i, q)
                                r, a = p(i, q)
                                q = r
                                v = r == nil and v + 42 or 13536 / v
                            else
                                k, p, i = k(p)
                                k, p, i = o.b(k, p, i)
                                q = k(p, i)
                                i = q
                                v = q == nil and v + -107 or 83 or 83
                            end
                        elseif v > 145 then
                            p = h[1][3]
                            v = 65
                            k = p.Service
                        else
                            v = i and 212 or 17 or 17
                        end
                    elseif v >= 123 then
                        if v <= 123 then
                            v = 2
                            d = "Humanoid"
                            _ = q.FindFirstChildOfClass
                            f = q
                        else
                            v, p = 225, o.c(p(i))
                        end
                    else
                        v = 13
                        f(d)
                    end
                elseif v >= 180 then
                    if v < 184 then
                        t, q, j, k, v, n, g = 191, os, 59, h[1][3], v + -87, 48, 239
                        i = q.clock
                    elseif v <= 184 then
                        a, v, _ = h[5][3], 412 - v, r.Character
                    else
                        return
                    end
                elseif v < 154 then
                    v, f = 15347 / v, a.Character
                    _ = f.Parent
                elseif v <= 154 then
                    v = 13
                    f(d)
                else
                    v = 142
                    p = h[3][3]
                    k = pairs
                end
            until false
        end
    end,
    md = {},
    Vb = function(b, _)
        return function(boxFill)
            _[1][3].boxFill = boxFill
        end
    end,
    Kc = function(o, h)
        return function(n, k, c, i, ...)
            local m = 120
            local e, j, g, _, c3, f, d, a
            repeat
                if m <= 123 then
                    if m > 111 then
                        if m <= 120 then
                            m = 75
                            j = h[1][3].contexts
                            _ = coroutine
                            a = coroutine.running
                        else
                            m, _ = m + 87, a
                        end
                    elseif m <= 109 then
                        if m <= 75 then
                            g, j, _ = j[a()], pcall, h[1][3]
                            f, m, _, a, d = k.Stats, 241, c, _.Direction, g
                        else
                            m, i = m + 2, a
                        end
                    else
                        d = c
                        f = k
                        e = i
                        _ = n
                        m = 129
                        c3 = o.c(...)
                    end
                elseif m <= 210 then
                    if m > 129 then
                        m = _ and 22890 / m or 111 or 111
                    else
                        _ = o.c(_(f, d, e, o.d(c3)))
                        return o.d(_)
                    end
                else
                    j, a = j(a, _, f, d)
                    _ = j
                    m = j and 123 or 210 or 210
                end
            until false
        end
    end,
    q = function(b, h)
        return function(d)
            local e = 237
            local c, f, a
            repeat
                if e >= 183 then
                    if e > 200 then
                        e = 188
                        h[1][3].shadows.enabled = d
                        f = h[2][3]
                        c = h[5][3]
                        a = d
                    elseif e < 188 then
                        return
                    elseif e > 188 then
                        e = 36600 / e
                        f(c)
                    else
                        f(c, a)
                        e = 51
                        c = h[3][3]
                        a = d
                    end
                elseif e >= 165 then
                    if e <= 165 then
                        a = h[4][3]
                        e = 183
                        f = h[6][3]
                        f.GlobalShadows = a.GlobalShadows
                        c = a.ShadowSoftness
                        f.ShadowSoftness = c
                    else
                        e = 200
                        c = b:Jb({
                            h[6],
                            h[1],
                        })
                        f = pcall
                    end
                else
                    f(c, a)
                    e = d and 176 or 165 or 165
                end
            until false
        end
    end,
    sb = function(b, h)
        return function(d)
            local e = 13
            local i, g, j, c, f
            repeat
                if e <= 155 then
                    if e < 72 then
                        if e <= 13 then
                            if e <= 8 then
                                if e <= 4 then
                                    c = d.IsA
                                    g = "Model"
                                    e = 233
                                    i = d
                                else
                                    g(j)
                                    return
                                end
                            else
                                f = not d
                                e = f and 222 or 4 or 4
                            end
                        else
                            c = d
                            e = 227
                            i = "Humanoid"
                            f = d.FindFirstChildOfClass
                        end
                    elseif e <= 140 then
                        if e >= 87 then
                            if e > 87 then
                                h[1][3][d] = true
                                c = h[2][3].Replicator.Actors
                                i = c[d]
                                g = not i
                                e = g and 295 - e or 193 or 193
                            else
                                return
                            end
                        else
                            return
                        end
                    else
                        e, g = e + 38, {}
                        g.UID = d
                        g.Character = d
                        i = g
                        c[d] = g
                    end
                elseif e >= 209 then
                    if e <= 227 then
                        if e < 222 then
                            e, i, g, c = e + -47, d, workspace, d.IsDescendantOf
                        elseif e > 222 then
                            f = f(c, i)
                            c = not f
                            e = c and 72 or 140 or 140
                        else
                            e = f and 383 - e or e + -13
                        end
                    else
                        e, c = 222, c(i, g)
                        f = not c
                    end
                elseif e <= 162 then
                    if e > 161 then
                        c = c(i, g)
                        e, f = e + -1, not c
                    else
                        e = f and 87 or 177 - e
                    end
                else
                    e, j = e + -185, h[3][3]
                    g, j = j.Refresh, i
                end
            until false
        end
    end,
    W = function(b, _)
        return function(hitPart)
            _[1][3].HitPart = hitPart
        end
    end,
    Dd = {},
    Rb = function(b, _)
        return function(enabled)
            _[1][3].enabled = enabled
        end
    end,
    B = function(o, h)
        return function(z)
            local v = 147
            local k, m, f, q, p, a, x, r, g, i, t, _, j, u, e, d, y, b, n, c
            repeat
                if v <= 151 then
                    if v <= 70 then
                        if v >= 27 then
                            if v >= 40 then
                                if v <= 50 then
                                    if v <= 40 then
                                        i = i(q, x)
                                        x = getcustomasset
                                        q = assert
                                        v = getcustomasset and 70 or 121 or 121
                                    else
                                        v = 219
                                        a = "Custom font loading is unavailable"
                                    end
                                else
                                    x = writefile
                                    v = m >= c and v + 51 or 25 or 25
                                end
                            elseif v < 36 then
                                v = 156
                                q(x)
                            elseif v > 36 then
                                v = x and 25 or 1850 / v
                            else
                                q = {
                                    [1] = 3,
                                    [3] = q(x, a),
                                }
                                v, q[2] = 234, q
                                x = pcall
                                a = o:Lb({q, i})
                            end
                        elseif v <= 12 then
                            if v >= 9 then
                                if v <= 9 then
                                    v = x and 154 - v or 37 or 37
                                else
                                    return h[1][3].Cache[z]
                                end
                            else
                                i = {
                                    [1] = 3,
                                    [3] = i(q),
                                }
                                i[2] = i
                                i[3].Font = p
                                i[3].Text = "Font"
                                i[3].Size = 14
                                i[3].Width = 200
                                v = 36
                                q = game
                                a = "TextService"
                                q, x = q.GetService, q
                            end
                        elseif v > 13 then
                            v, x = 1250 / v, isfolder
                        else
                            j = j(n)
                            t.assetId = j
                            v, b[1] = 170, t
                            e.faces = b
                            f, d = f.JSONEncode, f
                        end
                    elseif v <= 134 then
                        if v > 111 then
                            if v <= 121 then
                                v = x and 154 or 1089 / v
                            else
                                v = 203
                                q = k
                                i = Font.fromEnum
                            end
                        elseif v <= 106 then
                            if v >= 103 then
                                if v > 103 then
                                    _(f)
                                    f, d, _, v, e = x, tostring, assert, v + -3, a
                                else
                                    v, d = 351 - v, o.c(d(e))
                                end
                            else
                                a = a(_)
                                x = not a
                                v = x and 22700 / v or 171 or 171
                            end
                        else
                            v = 176
                            a(_, o.d(f))
                            _ = getcustomasset
                            f = x
                            a = Font.new
                        end
                    elseif v <= 147 then
                        if v <= 146 then
                            if v > 145 then
                                x = x(a)
                                q = not x
                                v = q and 180 or 156 or 156
                            else
                                v = 37
                                x = makefolder
                            end
                        else
                            i = h[1][3]
                            p = i.Cache
                            k = p[z]
                            v = k and 12 or 187 or 187
                        end
                    else
                        i = Instance.new
                        v = 6
                        q = "GetTextBoundsParams"
                    end
                elseif v <= 187 then
                    if v > 175 then
                        if v <= 180 then
                            if v < 179 then
                                v, _ = 179, o.c(_(f))
                            elseif v > 179 then
                                x = "LinoriaFonts"
                                v = 27
                                q = makefolder
                            else
                                a = a(o.d(_))
                                p = a
                                v = r <= y and 134 or 151 or 151
                            end
                        else
                            i = h[1][3]
                            u = 2
                            g = 4
                            p = nil
                            k = i.Builtins[z]
                            v = k and 134 or 42262 / v
                        end
                    elseif v <= 170 then
                        if v < 156 then
                            if v <= 154 then
                                v = 9
                                x = isfile
                            else
                                a = a(_)
                                v, x = v + -115, x .. a
                            end
                        elseif v <= 156 then
                            x = "LinoriaFonts"
                            r = 181
                            y = 27
                            q = "LinoriaFonts" .. "/" .. i
                            a = isfile
                            v = 100
                            _ = q
                        else
                            v, f = 281 - v, o.c(f(d, e))
                        end
                    elseif v > 171 then
                        v, x = 404 - v, x(a, _)
                        a = assert
                        d = 1024
                        _ = #x > 1024
                        f = "Font download is incomplete"
                    else
                        a, v, x = writefile, 375 - v, "LinoriaFonts" .. "/" .. i .. ".json"
                        e = "HttpService"
                        _ = x
                        f = game
                        d, f = f, f.GetService
                    end
                elseif v <= 227 then
                    if v >= 219 then
                        if v > 226 then
                            x = game
                            a, v, x, _ = x, v + -52, x.HttpGet, "https://raw.githubusercontent.com/i77lhm/storage/f58e45bdfab788c545200318d764474cc7cc99a5/fonts/" .. i
                        elseif v <= 219 then
                            q(x, a)
                            v, x, a = v + -73, isfolder, "LinoriaFonts"
                        else
                            c = 94
                            i = assert
                            m = 233
                            q = h[1][3].Files[z]
                            a = tostring
                            _ = z
                            v = 155
                            x = "Unknown font: "
                        end
                    elseif v > 203 then
                        f = f(d, e)
                        e = {name = z}
                        b = {}
                        t = {name = "Regular", weight = 400}
                        v, j = v + -191, "normal"
                        t.style = "normal"
                        n = q
                        j = getcustomasset
                    else
                        i = i(q)
                        p = i
                        v = g <= u and v + -133 or 151 or 151
                    end
                elseif v < 248 then
                    if v <= 229 then
                        v = v + 24
                        a(_, f)
                        a = writefile
                        f = x
                        _ = q
                    else
                        v = v + -128
                        x, a = x(a)
                        f = i[3]
                        _ = i[3].Destroy
                    end
                elseif v > 248 then
                    v = 171
                    a(_, f)
                else
                    _(f, o.d(d))
                    h[1][3].Cache[z] = p
                    return p
                end
            until false
        end
    end,
}):Jd(...)
