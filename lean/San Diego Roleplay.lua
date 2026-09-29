-- my deobfuscator is so ass lmao

return ({
    Fa = function(amount, _)
        return function(taskFunction)
            _[1][3].FOV = taskFunction
        end
    end,
    jb = function(amount)
        return function(targetPlayer)
            local label = 135
            local deltaY, line, _, humanoid, identifier, humanoidRootPart, offset
            repeat
                if label < 105 then
                    if label < 87 then
                        if label > 6 then
                            return humanoid
                        else
                            humanoid = humanoidRootPart.Name
                            label = line <= offset and 87 or label + 99
                        end
                    elseif label > 87 then
                        label, humanoidRootPart = 210 - label, humanoidRootPart(humanoid, deltaY)
                    else
                        humanoidRootPart = targetPlayer.Character
                        deltaY = "Tool"
                        humanoid, label, humanoidRootPart = humanoidRootPart, label + 15, humanoidRootPart.FindFirstChildOfClass
                    end
                elseif label > 135 then
                    humanoid = "Unarmed"
                    label = identifier < _ and 49 or 193 or 193
                elseif label > 108 then
                    humanoidRootPart = targetPlayer.Character
                    label = humanoidRootPart and 87 or 108 or 108
                elseif label > 105 then
                    line = 181
                    humanoid = humanoidRootPart
                    offset = 126
                    label = humanoidRootPart and 6 or 105 or 105
                else
                    _ = 224
                    identifier = 46
                    label = humanoid and 154 - label or 193 or 193
                end
            until false
        end
    end,
    Mb = function(amount, gameProcessed)
        return function(targetPlayer)
            local label = 103
            local humanoid, rootPart, identifier
            while true do
                if label >= 119 then
                    if label > 119 then
                        label = 119
                        identifier = nil
                    else
                        rootPart[humanoid] = identifier
                        return
                    end
                else
                    identifier = targetPlayer
                    rootPart = gameProcessed[1][3].teams
                    humanoid = gameProcessed[2][3]
                    label = identifier and 119 or 252 or 252
                end
            end
        end
    end,
    kc = function(amount, _)
        return function(func)
            _[1][3].healthTextOutline = func
        end
    end,
    k = function(amount, gameProcessed)
        return function(targetPlayer)
            local label = 110
            local humanoid, rootPart
            while true do
                if label >= 158 then
                    if label > 158 then
                        label = 45
                        rootPart = pcall
                        humanoid = amount:Db({gameProcessed[2], targetPlayer,})
                    end
                elseif label <= 45 then
                    label = label + 113
                    rootPart(humanoid)
                else
                    targetPlayer = {[1] = 3, [3] = targetPlayer}
                    targetPlayer[2] = targetPlayer
                    humanoid = gameProcessed[1][3]
                    humanoid.shadows.tech = targetPlayer[3]
                    humanoid = humanoid.shadows
                    rootPart = humanoid.enabled
                    label = rootPart and 173 or 158 or 158
                end
            end
        end
    end,
    Cc = function(amount, _)
        return function(targetPlayer)
            local label = 43
            local humanoid, rootPart
            repeat
                if label <= 118 then
                    if label > 46 then
                        rootPart()
                        return
                    elseif label <= 43 then
                        humanoid = _[1][3]
                        rootPart = humanoid.Callback
                        label = rootPart and 209 or 46 or 46
                    else
                        label = 118
                        rootPart = _[2][3]
                    end
                elseif label <= 197 then
                    label = 9062 / label
                    rootPart(humanoid)
                else
                    label, humanoid = 406 - label, _[1][3]
                    rootPart, humanoid = humanoid.Callback, targetPlayer
                end
            until false
        end
    end,
    g = function(amount, _)
        return function(entity)
            _[1][3].ambient.a = entity
        end
    end,
    Xa = function(triangle, gameProcessed)
        return function()
            local total = 59
            local rootPart, identifier, _, offset, deltaZ, nearestDistance, button, deltaY, point, Lighting, humanoidRootPart
            repeat
                if total >= 66 then
                    if total < 167 then
                        if total >= 102 then
                            if total > 102 then
                                offset, identifier, _ = offset(identifier)
                                offset, identifier, _ = triangle.b(offset, identifier, _)
                                rootPart, button = offset(identifier, _)
                                _ = rootPart
                                total = rootPart == nil and total + -104 or 225 or 225
                            else
                                total, gameProcessed[5][3][deltaY].enabled = 150, false
                                identifier = deltaZ
                                offset = ipairs
                            end
                        else
                            Lighting, humanoidRootPart, nearestDistance = Lighting(humanoidRootPart)
                            Lighting, humanoidRootPart, nearestDistance = triangle.b(Lighting, humanoidRootPart, nearestDistance)
                            deltaY, deltaZ = Lighting(humanoidRootPart, nearestDistance)
                            nearestDistance = deltaY
                            total = deltaY == nil and 43 or 36 or 36
                        end
                    elseif total >= 225 then
                        if total <= 225 then
                            total = 39
                            point = gameProcessed[4][3][button]
                            gameProcessed[3][3][button] = point
                        else
                            total = 167
                            Lighting()
                            humanoidRootPart = gameProcessed[2][3]
                            Lighting = humanoidRootPart.Unload
                        end
                    else
                        Lighting()
                        Lighting = pairs
                        deltaY = {}
                        offset = {}
                        offset[1], offset[2] = "Ambient", "OutdoorAmbient"
                        deltaY.ambient = offset
                        offset = {}
                        offset[1], offset[2] = "ColorShift_Top", "ColorShift_Bottom"
                        deltaY.colorShift = offset
                        offset = {}
                        total = 66
                        offset[1] = "ClockTime"
                        deltaY.time = offset
                        offset = {}
                        offset[1], offset[2], offset[3] = "FogStart", "FogEnd", "FogColor"
                        deltaY.fog = offset
                        button = "EnvironmentSpecularScale"
                        offset = {}
                        offset[1], offset[2], offset[3], offset[4] =
                            "Brightness", "ExposureCompensation", "EnvironmentDiffuseScale",
                            "EnvironmentSpecularScale"
                        deltaY.light = offset
                        _ = "ShadowSoftness"
                        identifier = "GlobalShadows"
                        offset = {}
                        offset[1], offset[2] = "GlobalShadows", "ShadowSoftness"
                        deltaZ = offset
                        deltaY.shadows = offset
                        humanoidRootPart = deltaY
                    end
                elseif total > 43 then
                    if total > 46 then
                        total = 235
                        humanoidRootPart = gameProcessed[1][3]
                        Lighting = humanoidRootPart.Destroy
                    else
                        deltaY, deltaZ = Lighting(humanoidRootPart, nearestDistance)
                        nearestDistance = deltaY
                        total = deltaY == nil and 43 or 82 - total
                    end
                elseif total < 39 then
                    _ = gameProcessed[5][3]
                    identifier = _[deltaY]
                    offset = identifier.enabled
                    total = offset and 102 or 1656 / total
                elseif total <= 39 then
                    rootPart, button = offset(identifier, _)
                    _ = rootPart
                    total = rootPart == nil and total + 7 or 8775 / total
                else
                    return
                end
            until false
        end
    end,
    ya = function(amount, _)
        return function(nodeIdentifier)
            _[1][3].sharedSettings.textSize = nodeIdentifier
        end
    end,
    Fd = function(entity, amount, duration, targetPlayer)
        entity.Dd[targetPlayer] = entity.Oc(amount, duration)
        return entity.Dd[targetPlayer]
    end,
    Gc = function(amount, gameProcessed)
        return function(targetPlayer)
            local label = 244
            local humanoid, identifier, rootPart
            while true do
                if label >= 229 then
                    if label > 229 then
                        rootPart = gameProcessed[1][3].teams
                        identifier = targetPlayer
                        humanoid = gameProcessed[2][3]
                        label = identifier and 229 or 145 or 145
                    else
                        rootPart[humanoid] = identifier
                        return
                    end
                else
                    label, identifier = 33205 / label, nil
                end
            end
        end
    end,
    Pa = function(amount, _)
        return function(graph)
            _[1][3].sharedSettings.neutralColor = graph
        end
    end,
    Bb = function(amount, gameProcessed)
        return function(targetPlayer)
            local label = 243
            local _, deltaY, line, humanoid, rootPart
            repeat
                if label <= 180 then
                    if label >= 73 then
                        if label > 73 then
                            rootPart = rootPart(humanoid, deltaY)
                            label = rootPart and 73 or 14 or 14
                        else
                            label = 213
                            rootPart = gameProcessed[1][3]
                            humanoid = targetPlayer.Parent
                        end
                    else
                        return
                    end
                elseif label > 213 then
                    humanoid = targetPlayer
                    line = 14
                    label = 180
                    rootPart = targetPlayer.IsA
                    deltaY = "Humanoid"
                    _ = 244
                else
                    rootPart(humanoid)
                    label = line < _ and label + -199 or label + -140
                end
            until false
        end
    end,
    wa = function(amount, _)
        return function(callbackFunction)
            _[1][3].shadows.softness = callbackFunction
        end
    end,
    t = function(amount, _)
        return function(targetPlayer)
            local label = 97
            local humanoid, rootPart
            repeat
                if label > 97 then
                    rootPart(humanoid)
                    return
                else
                    humanoid = targetPlayer
                    label = 224
                    rootPart = _[1][3].Apply
                end
            until false
        end
    end,
    Ta = function(amount, _)
        return function(inputString)
            _[1][3].FOVColor = inputString
        end
    end,
    xb = function(amount, gameProcessed)
        return function(targetPlayer)
            local label = 51
            local line, humanoid, rootPart, _, deltaY
            while true do
                if label < 151 then
                    if label > 75 then
                        if label <= 81 then
                            return targetPlayer, 1
                        else
                            line = 0
                            label = 17
                            _ = 1
                        end
                    elseif label <= 51 then
                        if label <= 17 then
                            humanoid = table.pack(humanoid(deltaY, line, _))
                            return rootPart, table.unpack(humanoid, 1, humanoid.n)
                        else
                            humanoid = targetPlayer
                            label = 235
                            rootPart = typeof
                        end
                    else
                        return gameProcessed[1][3], 1
                    end
                elseif label <= 184 then
                    if label < 166 then
                        rootPart, label, humanoid = type, 25066 / label, targetPlayer
                    elseif label <= 166 then
                        rootPart = rootPart(humanoid)
                        humanoid = "table"
                        label = rootPart == "table" and 234 or 75 or 75
                    else
                        label, deltaY = label + -42, 1
                    end
                elseif label <= 234 then
                    rootPart = targetPlayer[1]
                    deltaY = targetPlayer[2]
                    humanoid = math.clamp
                    label = deltaY and 142 or 418 - label
                else
                    rootPart = rootPart(humanoid)
                    humanoid = "Color3"
                    label = rootPart == "Color3" and label + -154 or label + -84
                end
            end
        end
    end,
    wb = function(triangle, gameProcessed)
        return function(columnIndex, pattern, targetPosition, weight, vehicle)
            local progress = 170
            local offset, textLabel, humanoid, button, Scheduler, index, total, line, point, label, top, bestDistance, attachment, identifier, _, ok, rootPart, heap, start
            while true do
                if progress < 127 then
                    if progress <= 60 then
                        if progress >= 23 then
                            if progress >= 42 then
                                if progress <= 48 then
                                    if progress > 42 then
                                        textLabel = workspace
                                        button = {}
                                        label = columnIndex.model
                                        point = workspace.CurrentCamera
                                        button[1], button[2] = label, point
                                        rootPart, button = button, _
                                        progress = button and 5184 / progress or 132 - progress
                                    else
                                        _ = heap.enabled
                                        identifier = not _
                                        progress = identifier and 166 or 10710 / progress
                                    end
                                else
                                    index = index(line, Scheduler, total)
                                    progress, attachment.Transparency = 7020 / progress, offset - index
                                    offset = 0
                                    bestDistance = _ > 0
                                    attachment.Visible = bestDistance
                                end
                            elseif progress <= 29 then
                                if progress <= 23 then
                                    rootPart = rootPart(button)
                                    progress, gameProcessed[3][3] = 4301 / progress, rootPart
                                    rootPart = gameProcessed[3][3]
                                    rootPart.Name = "LeanNPCOverlayAnchor"
                                    label = 0.01
                                    button = Vector3.new
                                    point = 0.01
                                    textLabel = 0.01
                                else
                                    label = workspace
                                    progress = 158
                                    button = workspace.CurrentCamera
                                    gameProcessed[3][3].Parent = button
                                    button = columnIndex.parts
                                    rootPart = ipairs
                                end
                            else
                                return
                            end
                        elseif progress <= 3 then
                            if progress > 1 then
                                _ = _(rootPart)
                                heap = identifier[_]
                                identifier = not heap
                                progress = identifier and progress + 193 or 45 - progress
                            elseif progress <= 0 then
                                bestDistance, attachment = "LeanNPCChams", bestDistance(offset)
                                attachment.Name = "LeanNPCChams"
                                progress, attachment.Adornee = progress + 202, gameProcessed[3][3]
                                attachment.AlwaysOnTop = true
                                attachment.ZIndex = 3
                                attachment.Parent = gameProcessed[3][3]
                                bestDistance = columnIndex.adornments
                                bestDistance[point] = attachment
                            else
                                progress, offset = progress + -1, Instance
                                bestDistance, offset = offset.new, "BoxHandleAdornment"
                            end
                        elseif progress <= 4 then
                            progress, _ = progress + 196, heap.occludedIntensity
                        else
                            progress, rootPart = 69 - progress, identifier.Replicator
                            _ = rootPart.LocalActor
                        end
                    elseif progress <= 91 then
                        if progress >= 82 then
                            if progress > 84 then
                                progress, button = progress + -20, button(label, point, textLabel, attachment)
                                point = nil
                                label = button == nil
                                columnIndex.clear = label
                            elseif progress <= 82 then
                                progress = 251
                                identifier = heap.occludedColor
                            else
                                progress = button and 154 or 16380 / progress
                            end
                        elseif progress <= 69 then
                            if progress > 62 then
                                progress = 62
                                bestDistance = identifier
                            else
                                attachment.Color3 = bestDistance
                                offset = 1
                                line = _
                                progress = 60
                                index = math.clamp
                                Scheduler = 0
                                total = 1
                            end
                        else
                            humanoid = 211
                            identifier = columnIndex.clear
                            start = 39
                            progress = identifier and 132 or 231 or 231
                        end
                    elseif progress > 108 then
                        point, textLabel = rootPart(button, label)
                        label = point
                        progress = point == nil and 36 or 224 or 224
                    elseif progress <= 104 then
                        if progress > 103 then
                            _ = heap.visibleIntensity
                            progress = top > ok and 278 - progress or 140 - progress
                        else
                            progress = 207
                            _ = identifier.Replicator
                        end
                    else
                        progress = 84
                        button = _.Character
                    end
                elseif progress < 195 then
                    if progress <= 166 then
                        if progress < 157 then
                            if progress <= 132 then
                                if progress > 127 then
                                    identifier = heap.visibleColor
                                    progress = humanoid > start and 231 or 255 or 255
                                else
                                    identifier = identifier()
                                    _ = identifier
                                    progress = identifier and 103 or 207 or 207
                                end
                            else
                                point = 1
                                label = _.Character
                                button = #rootPart + 1
                                progress, rootPart[button] = 30030 / progress, label
                            end
                        elseif progress > 158 then
                            return
                        elseif progress <= 157 then
                            rootPart = 0.15
                            progress, columnIndex.nextRay = progress + -30, _() + 0.15
                            _ = gameProcessed[1][3]
                            identifier = _.Service
                        else
                            rootPart, button, label = rootPart(button)
                            rootPart, button, label = triangle.b(rootPart, button, label)
                            point, textLabel = rootPart(button, label)
                            label = point
                            progress = point == nil and 5688 / progress or 35392 / progress
                        end
                    elseif progress > 187 then
                        if progress > 191 then
                            progress = 23
                            rootPart = Instance.new
                            button = "Part"
                        else
                            attachment = columnIndex.adornments[point]
                            bestDistance = not attachment
                            progress = bestDistance and 1 or progress + 11
                        end
                    elseif progress >= 174 then
                        if progress <= 174 then
                            progress = _ and progress + 26 or 696 / progress
                        else
                            rootPart.Size = button(label, point, textLabel)
                            label = CFrame
                            rootPart.CFrame = CFrame.identity
                            rootPart.Transparency = 1
                            rootPart.Anchored = true
                            button = false
                            rootPart.CanCollide = false
                            rootPart.CanTouch = false
                            progress, rootPart.CanQuery = 29, false
                            rootPart.CastShadow = false
                        end
                    else
                        ok = 95
                        top = 221
                        progress = 3
                        _ = gameProcessed[1][3]
                        identifier = _.chams
                        rootPart, _ = columnIndex.actor, _.Kind
                    end
                elseif progress < 224 then
                    if progress > 200 then
                        if progress <= 202 then
                            attachment.Size = textLabel.Size
                            offset = textLabel.CFrame
                            attachment.CFrame = offset + targetPosition
                            bestDistance = vehicle
                            progress = vehicle and progress + -140 or 69 or 69
                        else
                            progress = _ and 228 - progress or 9936 / progress
                        end
                    elseif progress >= 196 then
                        if progress > 196 then
                            button = gameProcessed[3][3]
                            rootPart = not button
                            progress = rootPart and 194 or 5800 / progress
                        else
                            return
                        end
                    else
                        progress, button = 17745 / progress, gameProcessed[2][3]
                        button.FilterDescendantsInstances = rootPart
                        button = workspace
                        point = pattern.CFrame.Position
                        bestDistance = pattern.CFrame
                        textLabel, attachment, button, label = weight - bestDistance.Position, gameProcessed[2][3], button.Raycast, button
                    end
                elseif progress < 242 then
                    if progress <= 231 then
                        if progress <= 224 then
                            attachment = textLabel.Parent
                            progress = attachment and 42784 / progress or 26208 / progress
                        else
                            progress = identifier and 251 or 82 or 82
                        end
                    else
                        identifier = identifier()
                        _ = columnIndex.nextRay
                        progress = identifier >= _ and 242 or progress + -164
                    end
                elseif progress <= 251 then
                    if progress > 242 then
                        _ = columnIndex.clear
                        progress = _ and 26104 / progress or 43674 / progress
                    else
                        rootPart = os
                        progress = 157
                        _ = os.clock
                    end
                else
                    _ = os
                    progress, identifier = 490 - progress, os.clock
                end
            end
        end
    end,
    P = function(triangle)
        return function(columnIndex, value, targetPosition, weight, vehicle, initialCapacity, y)
            local progress = 57
            local humanoidRootPart, Lighting, playerPed, index, rootPart, label, bestDistance, identifier, sum, currentTime, count, source, attachment, offset, start, line, button, key, point, textLabel, total, ok, _, currentIndex, top, i
            while true do
                if progress <= 157 then
                    if progress < 85 then
                        if progress < 50 then
                            if progress <= 23 then
                                if progress > 21 then
                                    total = Lighting
                                    progress = ok >= identifier and 158 or 236 or 236
                                elseif progress > 16 then
                                    sum = bestDistance / 160
                                    start = 2
                                    source = playerPed
                                    progress = 105
                                    line = 20 * sum ^ 2
                                    total = line
                                elseif progress > 11 then
                                    progress = index > 0 and 238 or 250 or 250
                                else
                                    progress = start > count and 186 - progress or 181 - progress
                                end
                            elseif progress <= 24 then
                                progress = _ and 150 or 158 or 158
                            else
                                textLabel = line
                                attachment = source
                                progress = key >= currentTime and 225 - progress or 85 or 85
                            end
                        elseif progress <= 64 then
                            if progress >= 63 then
                                if progress > 63 then
                                    _ = {[1] = 3, [3] = _}
                                    _[2] = _
                                    i = y
                                    progress = y and 293 - progress or 9472 / progress
                                else
                                    progress = total and 10143 / progress or 104 - progress
                                end
                            elseif progress <= 50 then
                                humanoidRootPart = humanoidRootPart(rootPart)
                                rootPart = 0
                                progress = humanoidRootPart > 0 and 73 - progress or 67 or 67
                            else
                                top = 32
                                point = 135
                                weight = {[1] = 3, [3] = weight}
                                progress, weight[2] = 157, weight
                                i = type
                                button = weight[3]
                            end
                        elseif progress <= 67 then
                            progress, sum = 303 - progress, Lighting
                        else
                            i = 0
                            progress, _ = 1824 / progress, weight[3] <= 0
                        end
                    elseif progress <= 142 then
                        if progress >= 107 then
                            if progress < 119 then
                                if progress <= 107 then
                                    humanoidRootPart, progress, Lighting = playerPed, 5350 / progress, (total + sum) * 0.5
                                    rootPart = Lighting
                                else
                                    progress = index <= 0 and 372 - progress or 21 or 21
                                end
                            elseif progress > 119 then
                                progress = index <= 0 and 320 - progress or 235 or 235
                            else
                                progress = currentIndex <= 0 and 190 or progress + -12
                            end
                        elseif progress < 91 then
                            bestDistance = bestDistance + index
                            progress = index > 0 and 337 - progress or progress + 57
                        elseif progress > 91 then
                            source = source(total)
                            sum = 0
                            total = attachment >= 0
                            progress = total and 234 or 6615 / progress
                        else
                            progress = 107
                        end
                    elseif progress < 152 then
                        if progress > 148 then
                            return value, 0
                        else
                            key = 65
                            currentTime = 94
                            progress = i and 184 or 152 or 152
                        end
                    elseif progress >= 154 then
                        if progress <= 154 then
                            i = Vector3
                            progress = 64
                            _ = Vector3.zero
                        else
                            i = i(button)
                            button = "number"
                            _ = i ~= "number"
                            progress = _ and 181 - progress or 76 or 76
                        end
                    else
                        progress = 184
                        i = 0
                    end
                elseif progress <= 229 then
                    if progress <= 178 then
                        if progress > 170 then
                            if progress > 175 then
                                progress = bestDistance < offset and 159 or 235 or 235
                            elseif progress <= 171 then
                                progress = progress + -52
                            else
                                currentIndex = 0.5
                                count = total + sum
                                Lighting = label[3]
                                start = count * 0.5
                                progress = 203
                                humanoidRootPart = start
                            end
                        elseif progress > 161 then
                            progress = currentIndex <= 0 and 384 - progress or 15470 / progress
                        elseif progress > 159 then
                            start = 1
                            total = textLabel
                            sum = line
                            count = 20
                            ok = 124
                            identifier = 239
                            currentIndex = 1
                            progress = progress + 82
                        elseif progress <= 158 then
                            _ = initialCapacity
                            progress = initialCapacity and 38078 / progress or 246 or 246
                        else
                            return nil
                        end
                    elseif progress >= 203 then
                        if progress > 214 then
                            i = vehicle
                            progress = point >= top and 148 or 270 - progress
                        elseif progress > 203 then
                            progress = start < count and 175 or 19474 / progress
                        else
                            Lighting = Lighting(humanoidRootPart)
                            return columnIndex + Lighting, start
                        end
                    elseif progress <= 184 then
                        i = {[1] = 3, [3] = i}
                        i[2] = i
                        button = {[1] = 3, [3] = value - columnIndex,}
                        button[2] = button
                        label = {[1] = 3, [3] = label}
                        label[2] = label
                        label[3] = triangle:rc({button, _, i})
                        attachment = button[3].Magnitude
                        playerPed = triangle:qc({label, weight})
                        textLabel = 0
                        bestDistance = 1
                        offset = 160
                        index = 1
                        progress = progress + -168
                    else
                        progress = start < count and progress + -15 or progress + -83
                    end
                elseif progress <= 243 then
                    if progress > 238 then
                        if progress <= 241 then
                            progress = 246
                            _ = targetPosition
                        else
                            progress = currentIndex > 0 and 59535 / progress or 171 or 171
                        end
                    elseif progress < 236 then
                        if progress > 234 then
                            progress = progress + -214
                        else
                            sum = 0
                            progress, total = 14742 / progress, source <= 0
                        end
                    elseif progress > 236 then
                        progress = bestDistance > offset and 159 or 250 or 250
                    else
                        start = start + currentIndex
                        progress = currentIndex > 0 and progress + -225 or 40120 / progress
                    end
                elseif progress >= 250 then
                    if progress > 252 then
                        progress = bestDistance < offset and 413 - progress or 21 or 21
                    elseif progress > 250 then
                        progress = bestDistance > offset and 40068 / progress or 142 or 142
                    else
                        progress = 29500 / progress
                    end
                elseif progress > 245 then
                    progress = _ and 64 or 154 or 154
                else
                    progress = start > count and progress + -70 or 171 or 171
                end
            end
        end
    end,
    pa = function(amount, gameProcessed)
        return function()
            local total = 188
            local button, line, identifier, humanoidRootPart, point, offset, rootPart, humanoid, deltaY
            repeat
                if total > 157 then
                    if total <= 212 then
                        if total <= 201 then
                            if total <= 168 then
                                if total > 163 then
                                    total = point < humanoidRootPart and 17304 / total or 22344 / total
                                elseif total > 160 then
                                    deltaY = gameProcessed[1][3]
                                    humanoid = deltaY.service
                                    humanoid, humanoidRootPart = deltaY.routeWrapper, humanoid.TryShoot
                                    total, point = 33741 / total, humanoidRootPart == humanoid
                                else
                                    total = point > humanoidRootPart and total + -57 or 154 or 154
                                end
                            elseif total > 188 then
                                deltaY, line = point(humanoidRootPart, humanoid)
                                humanoid = deltaY
                                total = deltaY == nil and 95 or 67 or 67
                            else
                                button = 131
                                rootPart = 35
                                humanoid = gameProcessed[1][3]
                                humanoidRootPart = humanoid.active
                                point = not humanoidRootPart
                                total = point and 249 or 116 or 116
                            end
                        elseif total >= 207 then
                            if total > 207 then
                                line = gameProcessed[1][3]
                                deltaY = line.hooks
                                humanoid = -1
                                point = #deltaY
                                humanoidRootPart = 1
                                total = total + -159
                            else
                                total = point and 265 - total or 43884 / total
                            end
                        else
                            point = point + humanoid
                            total = humanoid > 0 and 32185 / total or total + -184
                        end
                    elseif total >= 237 then
                        if total > 249 then
                            point.contexts = humanoidRootPart(humanoid, deltaY)
                            return
                        elseif total > 237 then
                            return
                        else
                            point(humanoidRootPart)
                            humanoidRootPart = setmetatable
                            point = gameProcessed[1][3]
                            line, total, deltaY, humanoid = "k", total + 13, {}, {}
                            deltaY.__mode = "k"
                        end
                    elseif total > 225 then
                        total = humanoid <= 0 and 168 or 133 or 133
                    elseif total > 222 then
                        total = total + -92
                    else
                        total = 201
                        offset(identifier)
                    end
                elseif total > 96 then
                    if total < 133 then
                        if total >= 116 then
                            if total > 116 then
                                point, humanoidRootPart, humanoid = point(humanoidRootPart)
                                point, humanoidRootPart, humanoid = amount.b(point, humanoidRootPart, humanoid)
                                deltaY, line = point(humanoidRootPart, humanoid)
                                humanoid = deltaY
                                total = deltaY == nil and 11305 / total or 186 - total
                            else
                                gameProcessed[1][3].active = false
                                deltaY = gameProcessed[1][3]
                                point = ipairs
                                total = 119
                                humanoidRootPart = deltaY.connections
                            end
                        else
                            total = 237
                            point = table.clear
                            humanoidRootPart = gameProcessed[1][3].hooks
                        end
                    elseif total > 154 then
                        total = point > humanoidRootPart and total + -54 or 178 - total
                    elseif total >= 139 then
                        if total <= 139 then
                            total = 205
                            deltaY(line, offset)
                        else
                            total = 228
                        end
                    else
                        identifier = gameProcessed[1][3]
                        deltaY = pcall
                        line = restorefunction
                        total = 139
                        offset = identifier.hooks[point]
                    end
                elseif total >= 67 then
                    if total > 94 then
                        if total > 95 then
                            total, humanoidRootPart = 186 - total, gameProcessed[1][3]
                            point = humanoidRootPart.circle
                            humanoidRootPart, point = point, point.Remove
                        else
                            humanoidRootPart = gameProcessed[1][3]
                            point = humanoidRootPart.circle
                            total = point and 96 or 46 or 46
                        end
                    elseif total >= 90 then
                        if total <= 90 then
                            point(humanoidRootPart)
                            total = rootPart <= button and 46 or 249 or 249
                        else
                            total = point < humanoidRootPart and 9682 / total or 319 - total
                        end
                    else
                        total = 222
                        identifier = line
                        offset = line.Disconnect
                    end
                elseif total >= 53 then
                    if total > 53 then
                        humanoidRootPart = gameProcessed[1][3]
                        point = humanoidRootPart.service
                        humanoid = humanoidRootPart
                        humanoidRootPart = humanoidRootPart.route
                        total, point.TryShoot = 212, humanoidRootPart
                    else
                        total = humanoid > 0 and 160 or 207 - total
                    end
                elseif total > 21 then
                    humanoidRootPart = gameProcessed[1][3]
                    point = humanoidRootPart.service
                    total = point and total + 117 or 207 or 207
                else
                    total = humanoid <= 0 and 94 or 225 or 225
                end
            until false
        end
    end,
    ld = function(entity, amount, duration, targetPlayer)
        entity.hd[targetPlayer] = entity.a(amount, 2489) + duration
        return entity.hd[targetPlayer]
    end,
    Mc = function(amount, gameProcessed)
        return function()
            local label = 68
            local rootPart, humanoid, button
            repeat
                if label > 123 then
                    rootPart = rootPart(humanoid)
                    gameProcessed[1][3] = rootPart
                    return
                elseif label > 68 then
                    button = button(rootPart, humanoid)
                    label = 179
                    rootPart = button.Network.ServerStatsItem["Data Ping"]
                    humanoid, rootPart = rootPart, rootPart.GetValue
                else
                    label = 123
                    humanoid = "Stats"
                    button = game
                    rootPart, button = button, button.GetService
                end
            until false
        end
    end,
    Jd = function(entity, ...)
        entity.Qc, entity.Oc, entity.Sc = "", "", entity:Sc()
        return entity:f()(...)
    end,
    Ed = function(entity, amount, duration, targetPlayer)
        entity.Dd[targetPlayer] = amount - entity.a(duration, 3261)
        return entity.Dd[targetPlayer]
    end,
    Eb = function(amount, _)
        return function()
            local label = 196
            local button, rootPart
            repeat
                if label > 196 then
                    rootPart, label, button = 0, 238 - label, _[1][3].Button
                    button.TextTransparency = 0
                elseif label > 12 then
                    button = not _[1][3].Active
                    label = button and 226 or 12 or 12
                else
                    return
                end
            until false
        end
    end,
    vc = function(triangle, gameProcessed)
        return function(chunk, pattern)
            local progress = 178
            local Lighting, deltaZ, Scheduler, nearestDistance, rootPart, identifier, attachment, line, label, total, point, button, start, _, deltaY, textLabel
            repeat
                if progress <= 111 then
                    if progress < 48 then
                        if progress < 32 then
                            if progress > 26 then
                                point(textLabel, attachment)
                                progress = Scheduler < total and progress + -3 or 74 or 74
                            elseif progress >= 17 then
                                if progress <= 17 then
                                    deltaZ = deltaZ(start)
                                    start = "EnumItem"
                                    progress = deltaZ == "EnumItem" and 202 or 48 or 48
                                else
                                    button, label = identifier(_, rootPart)
                                    rootPart = button
                                    progress = button == nil and 66 or 88 - progress
                                end
                            else
                                textLabel = deltaZ[label]
                                progress = 74
                                point = not textLabel
                            end
                        elseif progress < 37 then
                            if progress > 32 then
                                progress = 73
                                button = "Hold"
                            else
                                progress, deltaY = 176 - progress, "MB1"
                            end
                        elseif progress > 37 then
                            start, identifier, _ = start(triangle.d(identifier))
                            start, identifier, _ = triangle.b(start, identifier, _)
                            rootPart, button = start(identifier, _)
                            _ = rootPart
                            progress = rootPart == nil and 252 or 245 or 245
                        else
                            point = point(textLabel, attachment)
                            progress = point and 148 / progress or progress + 37
                        end
                    elseif progress > 73 then
                        if progress <= 84 then
                            if progress > 74 then
                                progress = 144
                                deltaY = "Q"
                            else
                                progress = point and 250 - progress or 26 or 26
                            end
                        else
                            rootPart, button = start(identifier, _)
                            _ = rootPart
                            progress = rootPart == nil and 252 or 245 or 245
                        end
                    elseif progress >= 62 then
                        if progress > 66 then
                            rootPart.Mode, total, Scheduler = button, 175, 31
                            progress, attachment, label, point, textLabel = 299 - progress, "Toggle", {}, "Always", "Hold"
                            label[1], label[2], label[3] = "Always", "Hold", "Toggle"
                            rootPart.Modes = label
                            rootPart.SyncToggleState = false
                            button = pattern.Callback
                            rootPart.Callback = button
                            start = nearestDistance.AddKeyPicker
                            identifier = nearestDistance
                        elseif progress > 62 then
                            progress = 241
                            identifier = {[1] = 3, [3] = start.Update,}
                            identifier[2] = identifier
                            start.Update = triangle:Bc({identifier, gameProcessed[4],})
                            _ = gameProcessed[4][3]
                        else
                            progress, attachment, point, textLabel = 2294 / progress, "TextLabel", label.IsA, label
                        end
                    elseif progress <= 48 then
                        deltaZ = "MouseButton2"
                        progress = deltaY == "MouseButton2" and 84 or 198 or 198
                    else
                        deltaZ = typeof
                        deltaY = pattern.Default
                        progress, start = progress + -38, deltaY
                    end
                elseif progress < 202 then
                    if progress <= 176 then
                        if progress > 173 then
                            progress = 29
                            point = table.insert
                            attachment = {}
                            textLabel = gameProcessed[6][3]
                            attachment.picker = start
                            attachment.label = label
                            attachment.toggle = gameProcessed[1][3]
                        elseif progress < 152 then
                            deltaZ = {}
                            progress = 227
                            start = ipairs
                            identifier = gameProcessed[5][3].KeybindContainer
                            identifier, _ = identifier.GetChildren, identifier
                        elseif progress > 152 then
                            progress, nearestDistance = 9515 / progress, nearestDistance(deltaY, deltaZ)
                        else
                            identifier, _, rootPart = identifier(triangle.d(_))
                            identifier, _, rootPart = triangle.b(identifier, _, rootPart)
                            button, label = identifier(_, rootPart)
                            rootPart = button
                            progress = button == nil and 66 or 214 - progress
                        end
                    elseif progress <= 178 then
                        if progress > 177 then
                            line = 251
                            Lighting = 174
                            nearestDistance = gameProcessed[1][3]
                            progress = nearestDistance and 55 or 222 or 222
                        else
                            progress, _ = progress + -25, triangle.c(_(rootPart))
                        end
                    else
                        deltaZ = "MouseButton1"
                        progress = deltaY == "MouseButton1" and 32 or 28512 / progress
                    end
                elseif progress < 227 then
                    if progress > 222 then
                        start(identifier, _, rootPart)
                        start = gameProcessed[3][3][pattern.Flag]
                        progress = 177
                        identifier = ipairs
                        _ = gameProcessed[5][3].KeybindContainer
                        _, rootPart = _.GetChildren, _
                    elseif progress > 202 then
                        nearestDistance = gameProcessed[2][3]
                        progress = 173
                        deltaZ = pattern.Text
                        nearestDistance, deltaY = nearestDistance.AddLabel, nearestDistance
                    else
                        deltaY = deltaY.Name
                        progress = Lighting >= line and 74 or progress + -154
                    end
                elseif progress <= 245 then
                    if progress <= 241 then
                        if progress <= 227 then
                            progress, identifier = 9307 / progress, triangle.c(identifier(_))
                        else
                            _()
                            return start
                        end
                    else
                        label = true
                        progress, deltaZ[button] = 27195 / progress, true
                    end
                else
                    rootPart = {}
                    _ = pattern.Flag
                    rootPart.Text = pattern.Text
                    rootPart.Default = deltaY
                    button = pattern.Mode
                    progress = button and progress + -179 or 8820 / progress
                end
            until false
        end
    end,
    Tb = function(amount, _)
        return function(pointB)
            _[1][3].tracer = pointB
        end
    end,
    Cd = function(entity, amount, duration, targetPlayer)
        entity.md[targetPlayer] = amount + duration
        return entity.md[targetPlayer]
    end,
    hc = function(amount, _)
        return function(height)
            local label = 217
            local rootPart
            repeat
                if label >= 217 then
                    _[1][3].kind = height
                    label = 177
                    rootPart = _[2][3]
                else
                    rootPart()
                    return
                end
            until false
        end
    end,
    D = function(amount, _)
        return function(width)
            _[1][3].sharedSettings.limitDistance = width
        end
    end, a = bit32.bxor,
    bc = function(amount, gameProcessed)
        return function()
            local label = 46
            local button, identifier, humanoid, rootPart
            while true do
                if label < 207 then
                    if label > 46 then
                        button.box3d = rootPart
                        return
                    else
                        button = gameProcessed[1][3]
                        rootPart = gameProcessed[2][3].enabled
                        label = rootPart and 207 or 250 or 250
                    end
                elseif label > 224 then
                    button.box = rootPart
                    button = gameProcessed[1][3]
                    rootPart = gameProcessed[2][3].enabled
                    label = rootPart and 224 or 119 or 119
                elseif label <= 207 then
                    label, identifier = 457 - label, gameProcessed[2][3]
                    identifier, humanoid = "2D", identifier.kind
                    rootPart = humanoid == "2D"
                else
                    label = 119
                    rootPart = gameProcessed[2][3].kind == "3D"
                end
            end
        end
    end,
    zd = function(entity, amount, duration, targetPlayer)
        entity.yd[targetPlayer] = amount - duration
        return entity.yd[targetPlayer]
    end,
    db = function(amount, gameProcessed)
        return function(sourceString, pattern, duration, weight)
            local label = 101
            local line, identifier, rootPart, offset, _
            repeat
                if label <= 147 then
                    if label <= 101 then
                        if label > 57 then
                            offset = sourceString.drawings
                            line = offset[pattern]
                            label = line and 195 or 57 or 57
                        else
                            line, rootPart, offset, label, identifier, _ = gameProcessed[1][3], weight, sourceString, 8379 / label, pattern, duration
                        end
                    else
                        label, line = 195, line(offset, identifier, _, rootPart)
                    end
                else
                    return line
                end
            until false
        end
    end,
    td = function(entity, amount, duration, targetPlayer)
        entity.md[targetPlayer] = amount / duration
        return entity.md[targetPlayer]
    end,
    zc = function(amount, gameProcessed)
        return function(targetPlayer)
            local label = 12
            local deltaY, line, rootPart, humanoid
            while true do
                if label <= 144 then
                    if label > 59 then
                        label = 25
                        deltaY = 1 - gameProcessed[2][3].Transparency
                    elseif label <= 25 then
                        if label <= 12 then
                            humanoid = gameProcessed[1][3]
                            line, humanoid, rootPart = gameProcessed[1][3], targetPlayer, humanoid.Callback
                            deltaY, line = line.Transparency, nil
                            deltaY = deltaY ~= nil
                            label = deltaY and 144 or 25 or 25
                        else
                            label = deltaY and 59 or 238 or 238
                        end
                    else
                        label = 234 - label
                    end
                elseif label > 175 then
                    label = 59
                    deltaY = nil
                else
                    rootPart(humanoid, deltaY)
                    return
                end
            end
        end
    end,
    Ic = function(triangle, gameProcessed)
        return function(stack, pattern, ...)
            local total = 202
            local rootPart, nearestDistance, line, label, _, offset, button, textLabel, deltaY, command
            while true do
                if total >= 177 then
                    if total <= 226 then
                        if total >= 197 then
                            if total <= 202 then
                                if total <= 197 then
                                    deltaY = table.pack(deltaY(line, offset, triangle.d(command)))
                                    return table.unpack(deltaY, 1, deltaY.n)
                                else
                                    textLabel = 16
                                    deltaY = gameProcessed[1][3].contexts
                                    offset = coroutine
                                    total = 95
                                    line = coroutine.running
                                end
                            else
                                button = button(label)
                                total, label = 417 - total, "table"
                                rootPart = button == "table"
                            end
                        elseif total >= 186 then
                            if total <= 186 then
                                total = 22
                                button = pattern[command]
                                rootPart = table.clone
                            else
                                total = rootPart and 186 or 47559 / total
                            end
                        else
                            offset = 0
                            line = #nearestDistance.projectiles
                            deltaY = line > 0
                            total = textLabel >= 0 and 101 or total + 63
                        end
                    elseif total >= 242 then
                        if total <= 242 then
                            total, line = 141, line(offset)
                            offset = "table"
                            deltaY = line == "table"
                        else
                            command, _ = deltaY(line, offset)
                            offset = command
                            total = command == nil and 55 or 0 or 0
                        end
                    elseif total <= 234 then
                        deltaY, line, offset = deltaY(line)
                        deltaY, line, offset = triangle.b(deltaY, line, offset)
                        command, _ = deltaY(line, offset)
                        offset = command
                        total = command == nil and 55 or 0 or 0
                    else
                        offset = pattern
                        total = 242
                        line = type
                    end
                elseif total < 95 then
                    if total < 55 then
                        if total > 0 then
                            total, rootPart = 5478 / total, rootPart(button)
                            pattern[command] = rootPart
                            rootPart = pattern[command]
                            button = _.direction
                            rootPart.Direction = button
                        else
                            rootPart = _.direction
                            total = rootPart and 143 - total or 191 or 191
                        end
                    elseif total <= 55 then
                        deltaY = gameProcessed[2][3]
                        total = 197
                        command = triangle.c(...)
                        offset = pattern
                        line = stack
                    else
                        total, line, deltaY = 10488 / total, pattern, table.clone
                    end
                elseif total < 138 then
                    if total > 95 then
                        total = deltaY and 240 or total + 40
                    else
                        line = line()
                        nearestDistance = deltaY[line]
                        deltaY = nearestDistance
                        total = nearestDistance and 16815 / total or 101 or 101
                    end
                elseif total >= 141 then
                    if total <= 141 then
                        total = deltaY and 76 or total + -86
                    else
                        label = pattern[command]
                        total = 226
                        button = type
                    end
                else
                    total, pattern, deltaY, line = total + 96, deltaY(line), ipairs, nearestDistance.projectiles
                end
            end
        end
    end,
    rc = function(amount, gameProcessed)
        return function(stack)
            local line = gameProcessed[2][3] * stack
            local offset = 0.5 * gameProcessed[3][3] * stack * stack
            return gameProcessed[1][3] + line + Vector3.yAxis * offset
        end
    end,
    lb = function(amount, gameProcessed)
        return function()
            local label = 40
            local identifier, button, manager, rootPart, humanoid
            repeat
                if label >= 188 then
                    if label > 212 then
                        button(rootPart)
                        label = 188
                        button = gameProcessed[4][3].RenderStepped
                        humanoid = amount:Ab({gameProcessed[1],})
                        rootPart, button = button, button.Connect
                    elseif label <= 193 then
                        if label <= 188 then
                            button = button(rootPart, humanoid)
                            gameProcessed[3][3] = button
                            return
                        else
                            gameProcessed[1][3]._hasLoaded = true
                            label, rootPart = label + -107, table
                            rootPart, identifier, button = gameProcessed[2][3], workspace, rootPart.insert
                            manager = amount:Bb({gameProcessed[5],})
                            humanoid = identifier.DescendantAdded
                            identifier, humanoid = humanoid, humanoid.Connect
                        end
                    else
                        button(rootPart, amount.d(humanoid))
                        button, label, rootPart = task.spawn, 326 - label, amount:Cb({gameProcessed[1], gameProcessed[5],})
                    end
                elseif label < 86 then
                    if label <= 40 then
                        rootPart = gameProcessed[1][3]
                        button = rootPart._hasLoaded
                        label = button and 77 or 193 or 193
                    else
                        return
                    end
                elseif label > 86 then
                    label = 235
                    button(rootPart)
                    rootPart = true
                    button = gameProcessed[1][3].Sync
                else
                    label, humanoid = 212, amount.c(humanoid(identifier, manager))
                end
            until false
        end
    end,
    gb = function(amount, gameProcessed)
        return function(sourceString)
            local label = 3
            local line, _, rootPart, deltaY, humanoid, humanoidRootPart, offset
            repeat
                if label >= 143 then
                    if label >= 196 then
                        if label < 245 then
                            if label >= 224 then
                                if label <= 224 then
                                    label = deltaY and 245 or 31 or 31
                                else
                                    humanoidRootPart = humanoidRootPart()
                                    humanoid = humanoidRootPart
                                    label = humanoidRootPart and 433 - label or label + -59
                                end
                            else
                                label = 178
                                humanoid = humanoidRootPart.Replicator
                            end
                        elseif label <= 252 then
                            if label <= 245 then
                                offset = sourceString.Character
                                label = 187
                                line = typeof
                            else
                                label = deltaY and 82 or 441 - label
                            end
                        else
                            label = 86
                            offset = nil
                            line = sourceString.Owner
                            deltaY = line == nil
                        end
                    elseif label <= 180 then
                        if label >= 178 then
                            if label > 178 then
                                label = 252
                                deltaY = humanoid
                            else
                                label = humanoid and 18 or 236 - label
                            end
                        elseif label > 143 then
                            line = line(offset)
                            offset = "table"
                            deltaY = line == "table"
                            label = deltaY and 180 or label + 76
                        else
                            label = deltaY and label + 110 or 12298 / label
                        end
                    elseif label > 187 then
                        label = deltaY and 30 or 332 - label
                    else
                        line = line(offset)
                        label, offset = 218 - label, "Instance"
                        deltaY = line == "Instance"
                    end
                elseif label > 31 then
                    if label >= 82 then
                        if label < 86 then
                            deltaY = sourceString.UID
                            label = _ <= rootPart and 189 or 85 - label
                        elseif label <= 86 then
                            label = deltaY and 111 or label + 138
                        else
                            offset = true
                            label = 224
                            line = sourceString.IsLocalPlayer
                            deltaY = line ~= true
                        end
                    elseif label <= 58 then
                        label = 176
                        line = type
                        offset = sourceString
                    else
                        offset = "Model"
                        deltaY = sourceString.Character
                        line, label, deltaY = deltaY, 24, deltaY.IsA
                    end
                elseif label >= 24 then
                    if label <= 30 then
                        if label > 24 then
                            offset = sourceString.UID
                            line = humanoid[offset]
                            label, deltaY = 173 - label, line == sourceString
                        else
                            label, deltaY = 36 - label, deltaY(line, offset)
                        end
                    else
                        label = deltaY and 96 - label or 43 - label
                    end
                elseif label <= 12 then
                    if label <= 3 then
                        label = 237
                        _ = 39
                        rootPart = 250
                        humanoid = gameProcessed[1][3]
                        humanoidRootPart = humanoid.Service
                    else
                        return deltaY
                    end
                else
                    deltaY = humanoidRootPart.Replicator
                    label = 58
                    humanoid = deltaY.Actors
                end
            until false
        end
    end,
    tc = function(triangle, gameProcessed)
        return function(stack, pattern)
            local total = 75
            local _, textLabel, identifier, line, nearestDistance, deltaY, point, offset
            repeat
                if total >= 117 then
                    if total > 154 then
                        if total > 223 then
                            total = _ and 151 or 335 - total
                        else
                            total, _ = 449 - total, 1 - pattern[3].Transparency
                        end
                    elseif total > 152 then
                        total = 32
                        identifier = triangle:zc({pattern, deltaY})
                        offset = deltaY[3]
                        line = deltaY[3].OnChanged
                    elseif total >= 151 then
                        if total <= 151 then
                            identifier.Transparency, textLabel, point = _, 187, 196
                            line = nearestDistance
                            total = 107
                            deltaY = nearestDistance.AddColorPicker
                        else
                            line, total, nearestDistance = pattern[3].Text, 196 - total, gameProcessed[2][3]
                            nearestDistance, deltaY = nearestDistance.AddLabel, nearestDistance
                        end
                    else
                        identifier = {}
                        offset = pattern[3].Flag
                        identifier.Title = pattern[3].Text
                        identifier.Default = pattern[3].Default
                        _ = pattern[3].Transparency ~= nil
                        total = _ and 223 or total + 109
                    end
                elseif total <= 91 then
                    if total > 75 then
                        line = triangle:Ac()
                        deltaY[3].SetVisible = line
                        return deltaY[3]
                    elseif total <= 44 then
                        if total > 32 then
                            total, nearestDistance = 161 - total, nearestDistance(deltaY, line)
                        else
                            line(offset, identifier)
                            total = point <= textLabel and 152 or 91 or 91
                        end
                    else
                        pattern = {[1] = 3, [3] = pattern}
                        pattern[2] = pattern
                        nearestDistance = gameProcessed[1][3]
                        total = nearestDistance and 117 or 152 or 152
                    end
                elseif total > 107 then
                    total, _ = 260 - total, nil
                else
                    deltaY(line, offset, identifier)
                    offset = pattern[3].Flag
                    deltaY = {[1] = 3, [3] = gameProcessed[3][3][offset],}
                    deltaY[2] = deltaY
                    line = pattern[3].Callback
                    total = line and 154 or total + -16
                end
            until false
        end
    end,
    id = function(entity, amount, duration, targetPlayer)
        entity.hd[targetPlayer] = entity.Oc(amount, duration)
        return entity.hd[targetPlayer]
    end,
    ob = function(amount, gameProcessed)
        return function(stack)
            local total = 136
            local _, identifier, humanoid, rootPart, deltaY, line, offset, humanoidRootPart
            while true do
                if total < 106 then
                    if total >= 55 then
                        if total <= 82 then
                            if total < 79 then
                                if total <= 55 then
                                    identifier = identifier(_)
                                    _ = "BrickColor"
                                    total = identifier == "BrickColor" and 5 or 222 - total
                                else
                                    return offset.Color
                                end
                            elseif total > 79 then
                                humanoidRootPart = humanoidRootPart(humanoid)
                                total = humanoidRootPart and 171 or 45 or 45
                            else
                                total, identifier = 176 - total, identifier(_, rootPart)
                            end
                        elseif total < 97 then
                            return offset.TeamColor.Color
                        elseif total > 97 then
                            rootPart = stack.Faction
                            offset = stack.TeamColor
                            identifier = stack.FactionColor
                            humanoidRootPart = pairs
                            _ = stack.Team
                            total = 178
                            line = {}
                            line[1], line[2], line[3], line[4], line[5] = offset, identifier, _, rootPart, stack.Company
                            humanoid = line
                        else
                            total = identifier and 84 or 44 or 44
                        end
                    elseif total < 22 then
                        if total >= 5 then
                            if total > 5 then
                                identifier = identifier(_)
                                _ = "Color3"
                                total = identifier == "Color3" and total + 58 or 106 or 106
                            else
                                return offset.Color
                            end
                        else
                            identifier = identifier(_)
                            _ = "Color3"
                            total = identifier == "Color3" and 484 / total or 164 / total
                        end
                    elseif total <= 44 then
                        if total > 41 then
                            _, total, identifier = offset, 9108 / total, type
                        elseif total > 22 then
                            total = 55
                            _ = offset
                            identifier = typeof
                        else
                            identifier, total, _ = typeof, 26 - total, offset
                        end
                    else
                        total = humanoidRootPart and 116 or 4590 / total
                    end
                elseif total > 171 then
                    if total < 207 then
                        if total < 188 then
                            humanoidRootPart, humanoid, deltaY = humanoidRootPart(humanoid)
                            humanoidRootPart, humanoid, deltaY = amount.b(humanoidRootPart, humanoid, deltaY)
                            line, offset = humanoidRootPart(humanoid, deltaY)
                            deltaY = line
                            total = line == nil and 197 or 22 or 22
                        elseif total > 188 then
                            return gameProcessed[1][3].sharedSettings.neutralColor
                        else
                            line, offset = humanoidRootPart(humanoid, deltaY)
                            deltaY = line
                            total = line == nil and total + 9 or total + -166
                        end
                    elseif total >= 213 then
                        if total > 213 then
                            total, _, identifier, rootPart = total + -155, offset, offset.IsA, "Team"
                        else
                            _ = _(rootPart)
                            rootPart = "Instance"
                            identifier = _ == "Instance"
                            total = identifier and 234 or 97 or 97
                        end
                    elseif total <= 207 then
                        identifier = identifier(_)
                        _ = "table"
                        total = identifier == "table" and total + 5 or 188 or 188
                    else
                        total, identifier, _ = total + -194, typeof, offset.Color
                    end
                elseif total > 145 then
                    if total >= 167 then
                        if total > 167 then
                            humanoid = stack.Owner
                            total = 45
                            humanoidRootPart = humanoid.Team
                        else
                            rootPart = offset
                            total = 213
                            _ = typeof
                        end
                    else
                        identifier = identifier(_)
                        _ = "BrickColor"
                        total = identifier == "BrickColor" and 145 or 188 or 188
                    end
                elseif total > 121 then
                    if total > 136 then
                        return offset.TeamColor.Color
                    else
                        total = 82
                        humanoid = stack
                        humanoidRootPart = gameProcessed[1][3].IsPlayer
                    end
                elseif total > 116 then
                    return offset
                elseif total > 106 then
                    return stack.Owner.Team.TeamColor.Color
                else
                    _, total, identifier = offset.TeamColor, 16748 / total, typeof
                end
            end
        end
    end,
    u = function(amount, _)
        return function(amount)
            _[1][3].ambient.b = amount
        end
    end,
    pb = function(triangle, gameProcessed)
        return function(stack)
            local total = 252
            local label, line, rootPart, _, button, deltaY, nearestDistance, humanoidRootPart, offset, point, textLabel
            while true do
                if total > 112 then
                    if total <= 210 then
                        if total <= 141 then
                            if total >= 125 then
                                if total >= 131 then
                                    if total > 131 then
                                        offset = stack.Character
                                        total = 47
                                        line = typeof
                                    else
                                        textLabel = 185
                                        point = 83
                                        total = deltaY and 141 or 244 - total
                                    end
                                else
                                    total, deltaY = total + -125, nearestDistance
                                end
                            elseif total <= 113 then
                                total = deltaY and 190 - total or 226 or 226
                            else
                                line = line(offset)
                                offset = "table"
                                deltaY = line == "table"
                                total = deltaY and 125 or 0 or 0
                            end
                        elseif total <= 192 then
                            if total < 159 then
                                _, line, total, offset, button, label, rootPart = 184, type, 18972 / total, stack, 63, 193, 59
                            elseif total > 159 then
                                total = nearestDistance and 11 or 345 - total
                            else
                                humanoidRootPart = humanoidRootPart()
                                nearestDistance = humanoidRootPart
                                total = humanoidRootPart and 168 - total or total + 33
                            end
                        else
                            total = deltaY and 243 or 292 - total
                        end
                    elseif total >= 231 then
                        if total < 243 then
                            if total <= 231 then
                                line, total, offset = stack.Owner.Character, 15708 / total, stack.Character
                                deltaY = line == offset
                            else
                                total = deltaY and total + -198 or 30392 / total
                            end
                        elseif total <= 243 then
                            offset = "Player"
                            deltaY = stack.Owner
                            deltaY, total, line = deltaY.IsA, 109, deltaY
                        else
                            total = 159
                            nearestDistance = gameProcessed[1][3]
                            humanoidRootPart = nearestDistance.Service
                        end
                    elseif total > 225 then
                        return deltaY
                    elseif total <= 215 then
                        line = line(offset)
                        offset = "Instance"
                        deltaY = line == "Instance"
                        total = button < label and 210 or total + -134
                    else
                        total = 215
                        line = typeof
                        offset = stack.Owner
                    end
                elseif total < 47 then
                    if total <= 11 then
                        if total < 8 then
                            if total <= 0 then
                                total = deltaY and total + 81 or 110 or 110
                            else
                                line, total, offset = stack.Owner, 1392 / total, gameProcessed[3][3]
                                deltaY = line ~= offset
                            end
                        elseif total < 9 then
                            total = deltaY and 225 or 210 or 210
                        elseif total <= 9 then
                            total, nearestDistance = total + 183, humanoidRootPart.Replicator
                        else
                            deltaY = humanoidRootPart.Replicator
                            total, nearestDistance = 1683 / total, deltaY.Actors
                        end
                    elseif total > 26 then
                        offset = true
                        total = 131
                        line = stack.IsLocalPlayer
                        deltaY = line ~= true
                    elseif total > 15 then
                        total = deltaY and 257 - total or 68 or 68
                    else
                        offset = stack.Owner
                        total, offset, line = 26, gameProcessed[2][3], offset.Parent
                        deltaY = line == offset
                    end
                elseif total < 81 then
                    if total >= 76 then
                        if total <= 76 then
                            offset = stack.UID
                            total, line = 84 - total, nearestDistance[offset]
                            deltaY = line == stack
                        else
                            total = 112
                            deltaY = stack.Character
                            offset = "Model"
                            deltaY, line = deltaY.IsA, deltaY
                        end
                    elseif total > 47 then
                        total = deltaY and total + -62 or 232 or 232
                    else
                        line = line(offset)
                        offset = "Instance"
                        deltaY = line == "Instance"
                        total = point < textLabel and 5311 / total or 231 or 231
                    end
                elseif total < 109 then
                    if total > 81 then
                        total = deltaY and total + -67 or 2132 / total
                    else
                        deltaY = stack.UID
                        total = _ > rootPart and 8910 / total or 77 or 77
                    end
                elseif total > 110 then
                    total, deltaY = 338 - total, deltaY(line, offset)
                elseif total <= 109 then
                    total, deltaY = 82, deltaY(line, offset)
                else
                    total = deltaY and total + -34 or 8 or 8
                end
            end
        end
    end,
    nc = function(amount, _)
        return function(input)
            _[1][3].distanceOutline = input
        end
    end,
    O = function(amount, gameProcessed)
        return function(targetPlayer)
            local label = 169
            local line, rootPart, identifier, humanoid
            repeat
                if label > 169 then
                    rootPart(humanoid, identifier, line)
                    return
                else
                    identifier = targetPlayer
                    line = nil
                    rootPart = gameProcessed[1][3]
                    label = 248
                    humanoid = "Sub"
                end
            until false
        end
    end,
    vd = function(entity, amount, duration, targetPlayer)
        entity.ud[targetPlayer] = entity.a(amount, 51727) - duration
        return entity.ud[targetPlayer]
    end,
    aa = function(amount, gameProcessed)
        return function(targetPlayer)
            local label = 20
            local offset, deltaY, _, line, humanoidRootPart, identifier, humanoid
            while true do
                if label <= 166 then
                    if label > 106 then
                        return
                    elseif label <= 97 then
                        if label > 20 then
                            _, label, identifier, deltaY, offset = humanoid, label + 9, tostring, gameProcessed[2][3], "Font could not be loaded: "
                        else
                            humanoidRootPart = pcall
                            label = 227
                            humanoid = gameProcessed[1][3].SetUI
                            deltaY = targetPlayer
                        end
                    else
                        identifier = identifier(_)
                        deltaY, label, line, offset = deltaY.Notify, 320 - label, deltaY, offset .. identifier
                    end
                elseif label <= 214 then
                    label = 166
                    deltaY(line, offset)
                else
                    humanoidRootPart, humanoid = humanoidRootPart(humanoid, deltaY)
                    deltaY = not humanoidRootPart
                    label = deltaY and 324 - label or 166 or 166
                end
            end
        end
    end,
    ca = function(amount, _)
        return function()
            local label = 197
            local rootPart, button
            while true do
                if label >= 165 then
                    if label > 165 then
                        rootPart = _[1][3]
                        button = rootPart.Unloaded
                        label = button and 165 or 88 or 88
                    else
                        return
                    end
                elseif label > 80 then
                    label = 80
                    button = pcall
                    rootPart = amount:Fc({_[2], _[3],})
                else
                    button(rootPart)
                    return
                end
            end
        end
    end,
    oc = function(amount, _)
        return function(v)
            _[1][3].tracerOrigin = v
        end
    end,
    Ab = function(amount, _)
        return function()
            local label = 241
            local button
            while true do
                if label >= 241 then
                    label = 101
                    button = _[1][3].Render
                else
                    button()
                    return
                end
            end
        end
    end,
    Sc = function(amount)
        local parts = string.gsub
        local button = {[1] = 3, [3] = string.char,}
        button[2] = button
        parts = {[1] = 3, [3] = parts}
        parts[2] = parts
        local keys = bit32.band
        local humanoid = {[1] = 3, [3] = bit32.rshift,}
        humanoid[2] = humanoid
        keys = {[1] = 3, [3] = keys}
        keys[2] = keys
        return amount:Tc({parts, button, keys, humanoid})
    end,
    Ec = function(amount, gameProcessed)
        return function()
            local label = 233
            local line, button, rootPart, offset, deltaY, humanoid
            while true do
                if label > 127 then
                    deltaY = gameProcessed[2][3]
                    button = gameProcessed[1][3]
                    offset, deltaY, humanoid = gameProcessed[2][3], {}, deltaY.Flag
                    deltaY.Text = offset.Text
                    deltaY.Values = offset.Options
                    deltaY.Default = offset.Default
                    line = offset.Multi
                    label = line and 35 or 127 or 127
                elseif label >= 112 then
                    if label <= 112 then
                        button = table.pack(button(rootPart, humanoid, deltaY))
                        return table.unpack(button, 1, button.n)
                    else
                        label = 35
                        line = false
                    end
                else
                    label, deltaY.Multi = 3920 / label, line
                    button, rootPart = button.AddDropdown, button
                end
            end
        end
    end,
    ic = function(amount, _)
        return function(firstVector)
            _[1][3].offScreenArrowSize = firstVector
        end
    end,
    z = function(triangle)
        return function(target)
            local total = 134
            local identifier, button, deltaZ, _, humanoidRootPart, label, humanoid, line, nearestDistance, deltaY, rootPart, point, start
            repeat
                if total >= 134 then
                    if total < 203 then
                        if total > 134 then
                            identifier, _ = deltaY(deltaZ, start)
                            start = identifier
                            total = identifier == nil and 240 - total or 429 - total
                        else
                            line = 62
                            humanoidRootPart = filtergc
                            deltaZ = {}
                            humanoid = 240
                            nearestDistance = "function"
                            deltaZ.Name = target
                            start = true
                            total, deltaZ.IgnoreExecutor = 18, true
                            deltaZ, deltaY = false, deltaZ
                        end
                    elseif total <= 207 then
                        if total > 203 then
                            deltaY(deltaZ, start)
                            return nearestDistance
                        else
                            deltaY, deltaZ, start = deltaY(deltaZ)
                            deltaY, deltaZ, start = triangle.b(deltaY, deltaZ, start)
                            identifier, _ = deltaY(deltaZ, start)
                            start = identifier
                            total = identifier == nil and total + -159 or 233 or 233
                        end
                    else
                        total = 126
                        button = _
                        rootPart = debug.getinfo
                    end
                elseif total <= 67 then
                    if total < 44 then
                        humanoidRootPart = humanoidRootPart(nearestDistance, deltaY, deltaZ)
                        nearestDistance = nil
                        deltaY = ipairs
                        total = 203
                        deltaZ = humanoidRootPart
                    elseif total <= 44 then
                        deltaY = assert
                        deltaZ = nearestDistance
                        total, start = 251 - total, "GunController function not loaded: " .. target
                    else
                        button(label, point)
                        nearestDistance = _
                        total = humanoid <= line and 5092 / total or 196 or 196
                    end
                elseif total > 76 then
                    rootPart = rootPart(button)
                    label = "=ReplicatedStorage.ClientModules.GunController"
                    button = rootPart.source
                    total = button == "=ReplicatedStorage.ClientModules.GunController" and 76 or 322 - total
                else
                    button = assert
                    label = not nearestDistance
                    total = 67
                    point = "Ambiguous GunController function: " .. target
                end
            until false
        end
    end,
    x = function(amount, _)
        return function(event)
            _[1][3].sharedSettings.teamBasedColor = event
        end
    end,
    fc = function(amount, _)
        return function(xCoordinate)
            _[1][3].healthBar = xCoordinate
        end
    end,
    b = (function()
        local deltaZ, deltaY, ok = type, getmetatable, pairs
        return function(actionName, eventData, zCoordinate)
            if deltaZ(actionName) ~= "function" then
                local nearestDistance = deltaY(actionName)
                if nearestDistance ~= nil and nearestDistance.__iter ~= nil then
                    return nearestDistance.__iter(actionName)
                elseif (nearestDistance and nearestDistance.__call) == nil and deltaZ(actionName) == "table" then
                    return ok(actionName)
                end
            end
            return actionName, eventData, zCoordinate
        end
    end)(),
    kb = function(triangle, gameProcessed)
        return function(chunk)
            local total = 103
            local _, humanoid, humanoidRootPart, rootPart, deltaZ, start, bestDistance, textLabel, label, Lighting, point, deltaY, identifier, nearestDistance, button, offset
            repeat
                if total < 128 then
                    if total <= 85 then
                        if total < 56 then
                            if total <= 46 then
                                if total > 29 then
                                    deltaZ = nearestDistance.Replicator
                                    total = 47
                                    deltaY = deltaZ.LocalActor
                                elseif total <= 5 then
                                    total = deltaY and 46 or 47 or 47
                                else
                                    label = pcall
                                    total, humanoid, bestDistance, point, textLabel = 3016 / total, humanoidRootPart, deltaZ, gameProcessed[1][3].RenderActor, button
                                end
                            else
                                deltaZ = deltaY
                                total = deltaY and 123 or 118 - total
                            end
                        elseif total <= 71 then
                            if total < 57 then
                                total = 279 - total
                                textLabel(humanoid, bestDistance)
                            elseif total <= 57 then
                                humanoid = button
                                total = 139
                                textLabel = gameProcessed[2][3]
                            else
                                total = deltaZ and 309 - total or 14910 / total
                            end
                        else
                            nearestDistance = not humanoidRootPart
                            total = nearestDistance and 135 or 176 - total
                        end
                    elseif total >= 108 then
                        if not (total < 113 or total <= 113) then
                            total = 71
                            deltaZ = deltaY.Position
                        end
                    elseif total < 103 then
                        total, deltaY = total + 47, gameProcessed[1][3]
                        nearestDistance = deltaY.Service
                    elseif total > 103 then
                        label, point = label(point, textLabel, humanoid, bestDistance)
                        textLabel = not label
                        total = textLabel and 5928 / total or 223 or 223
                    else
                        nearestDistance = gameProcessed[1][3]
                        humanoidRootPart = nearestDistance.Paused
                        total = humanoidRootPart and 108 or 151 or 151
                    end
                elseif total <= 174 then
                    if total < 151 then
                        if total > 138 then
                            total = 24186 / total
                            textLabel(humanoid)
                            Lighting = point
                            offset = tostring
                            bestDistance = gameProcessed[1][3].errors
                        elseif total >= 135 then
                            if total > 135 then
                                nearestDistance = nearestDistance()
                                deltaY = nearestDistance
                                total = nearestDistance and 128 or 5 or 5
                            end
                        else
                            total, deltaY = total + -123, nearestDistance.Replicator
                        end
                    elseif total <= 163 then
                        if total <= 154 then
                            if total <= 151 then
                                nearestDistance = gameProcessed[1][3]
                                total = 235
                                humanoidRootPart = nearestDistance.Sync
                            else
                                nearestDistance = workspace
                                total = 85
                                humanoidRootPart = workspace.CurrentCamera
                            end
                        else
                            start, identifier, _ = start(identifier)
                            start, identifier, _ = triangle.b(start, identifier, _)
                            rootPart, button = start(identifier, _)
                            _ = rootPart
                            total = rootPart == nil and 113 or 29 or 29
                        end
                    else
                        offset = offset(Lighting)
                        humanoid = bestDistance[offset]
                        textLabel = not humanoid
                        total = textLabel and total + 40 or total + 49
                    end
                elseif total >= 223 then
                    if total > 235 then
                        start = pairs
                        total, identifier = 38794 / total, gameProcessed[1][3].objects
                    elseif total > 223 then
                        humanoidRootPart()
                        humanoidRootPart = chunk
                        total = chunk and 19975 / total or total + -81
                    else
                        rootPart, button = start(identifier, _)
                        _ = rootPart
                        total = rootPart == nil and 25199 / total or 29 or 29
                    end
                elseif total < 210 then
                    humanoid = humanoid(bestDistance)
                    total, bestDistance = total + -142, true
                    textLabel[humanoid] = true
                    textLabel = warn
                    bestDistance = point
                    humanoid = "[NPC ESP]"
                elseif total > 210 then
                    total, humanoid = 42372 / total, gameProcessed[1][3]
                    humanoid, bestDistance, textLabel = tostring, point, humanoid.errors
                else
                    total = 238
                    start = humanoidRootPart.CFrame
                    deltaZ = start.Position
                end
            until false
        end
    end,
    Rc = function(triangle, gameProcessed)
        return function(stack, pattern)
            local deltaY = 0
            local nearestDistance = ""
            local deltaZ = #stack - 1
            local identifier, rootPart, button, _
            if 0 <= deltaZ then
                while true do
                    _ = gameProcessed[2][3]
                    identifier = gameProcessed[1][3]
                    rootPart = gameProcessed[3][3](stack, deltaY + 1)
                    button = gameProcessed[3][3]
                    button = table.pack(button(pattern, #pattern - deltaY % #pattern))
                    _ = table.pack(_(rootPart, table.unpack(button, 1, button.n)))
                    nearestDistance = nearestDistance .. identifier(table.unpack(_, 1, _.n))
                    deltaY = deltaY + 1
                    if deltaY > deltaZ then
                        break
                    end
                end
            end
            return nearestDistance
        end
    end,
    X = function(amount)
        return function() end
    end,
    Ra = function(amount, _)
        return function(entityIdentifier)
            _[1][3].Prediction = entityIdentifier
        end
    end,
    Ca = function(amount, _)
        return function(playerEntity)
            _[1][3].fog.color = playerEntity
        end
    end,
    ea = function(triangle, gameProcessed)
        return function(stack, pattern, duration)
            local total = 252
            local deltaY, point, label, offset, rootPart, line, button
            repeat
                if total >= 133 then
                    if total >= 210 then
                        if total >= 237 then
                            if total <= 237 then
                                return nil
                            else
                                label = 231
                                button = 79
                                rootPart = 90
                                point = 140
                                offset = gameProcessed[1][3]
                                line = offset.active
                                total = line and 142 or 25 or 25
                            end
                        else
                            return nil
                        end
                    elseif total >= 142 then
                        if total > 142 then
                            total, line = 7800 / total, duration.allowed
                        else
                            offset = gameProcessed[2][3]
                            line = offset.Enabled
                            total = rootPart > button and 25 or 237 or 237
                        end
                    else
                        deltaY = deltaY(line, offset)
                        line = not deltaY
                        total = line and 27930 / total or 163 - total
                    end
                elseif total > 40 then
                    if total <= 55 then
                        total = line and 250 - total or 40 or 40
                    else
                        total, line = 211 - total, gameProcessed[1][3]
                        deltaY, line, offset = line.Select, stack, pattern
                    end
                elseif total < 30 then
                    if total > 5 then
                        total = line and 5 or 55 or 55
                    else
                        line = duration
                        total = label >= point and 55 or 252 or 252
                    end
                elseif total <= 30 then
                    line = gameProcessed[1][3]
                    line.target = deltaY
                    line = line.diagnostics
                    line.redirected = line.redirected + 1
                    return (deltaY.point - stack).Unit
                else
                    deltaY = not line
                    total = deltaY and total + 197 or 78 or 78
                end
            until false
        end
    end,
    xd = function(entity, amount, duration, targetPlayer)
        entity.ud[targetPlayer] = amount / duration
        return entity.ud[targetPlayer]
    end,
    sc = function(amount, gameProcessed)
        return function(targetPlayer, yCoordinate)
            local label = 234
            local deltaY, humanoid, line, offset
            repeat
                if label < 146 then
                    if label > 94 then
                        label = humanoid and 130 - label or 218 or 218
                    elseif label > 84 then
                        label, humanoid = label + 18, humanoid(deltaY, line)
                    elseif label > 18 then
                        deltaY(line, offset)
                        deltaY = {}
                        line = {[1] = 3, [3] = nil}
                        line[2] = line
                        deltaY.AddToggle = amount:wc({humanoid, gameProcessed[2], line,})
                        deltaY.AddSlider = amount:xc({gameProcessed[5], humanoid,})
                        deltaY.AddDropdown = amount:yc({gameProcessed[5], humanoid,})
                        deltaY.AddColorPicker = amount:tc({line, humanoid, gameProcessed[3],})
                        deltaY.AddKeyPicker = amount:vc({line, humanoid, gameProcessed[3], gameProcessed[2], gameProcessed[6], gameProcessed[4],})
                        deltaY.AddButton = amount:uc({humanoid})
                        return deltaY
                    else
                        humanoid = {[1] = 3, [3] = humanoid}
                        humanoid[2] = humanoid
                        label, line = 1512 / label, table
                        line, deltaY, offset = targetPlayer.Groups, line.insert, humanoid[3]
                    end
                elseif label > 218 then
                    deltaY = yCoordinate.Side
                    line = "Right"
                    humanoid = deltaY == "Right"
                    label = humanoid and 173 or 112 or 112
                elseif label > 173 then
                    label, humanoid, line = label + -72, gameProcessed[1][3], yCoordinate.Title
                    deltaY, humanoid = humanoid, humanoid.AddLeftGroupbox
                elseif label > 146 then
                    humanoid = gameProcessed[1][3]
                    line = yCoordinate.Title
                    humanoid, label, deltaY = humanoid.AddRightGroupbox, 16262 / label, humanoid
                else
                    label, humanoid = label + -128, humanoid(deltaY, line)
                end
            until false
        end
    end,
    Ya = function(amount, _)
        return function(targetPlayer)
            local label = 147
            local humanoid, identifier, rootPart
            repeat
                if label >= 147 then
                    label = 116
                    humanoid = "Sub"
                    rootPart = _[1][3]
                    identifier = targetPlayer
                else
                    rootPart(humanoid, identifier)
                    return
                end
            until false
        end
    end,
    _c = function(amount, _)
        return function(minimum)
            _[1][3].skeleton = minimum
        end
    end,
    Kb = function(amount, gameProcessed)
        return function(targetPlayer, quantity)
            local label = 43
            local offset, line, humanoid, identifier, deltaY
            while true do
                if label >= 104 then
                    if label > 150 then
                        label, humanoid = 20293 / label, gameProcessed[2][3]
                        deltaY, humanoid = humanoid, humanoid.Resize
                    elseif label > 104 then
                        humanoid, deltaY, line = humanoid(deltaY)
                        humanoid, deltaY, line = amount.b(humanoid, deltaY, line)
                        offset, identifier = humanoid(deltaY, line)
                        line = offset
                        label = offset == nil and 223 or label + -46
                    else
                        label, identifier.Visible = 6240 / label, quantity
                    end
                elseif label <= 60 then
                    if label <= 43 then
                        label = 150
                        humanoid = ipairs
                        deltaY = gameProcessed[1][3]
                    else
                        offset, identifier = humanoid(deltaY, line)
                        line = offset
                        label = offset == nil and 223 or 6240 / label
                    end
                else
                    humanoid(deltaY)
                    return
                end
            end
        end
    end,
    _a = function(amount, gameProcessed)
        return function(targetPlayer, yCoordinate, duration)
            local label = 0
            local offset, identifier, deltaY, line
            repeat
                if label <= 86 then
                    if label <= 0 then
                        identifier = duration
                        line = targetPlayer
                        deltaY = gameProcessed[1][3]
                        label = 187
                        offset = yCoordinate
                    else
                        line(offset)
                        return deltaY
                    end
                else
                    deltaY = deltaY(line, offset, identifier)
                    label = 86
                    offset = deltaY
                    line = gameProcessed[2][3].Apply
                end
            until false
        end
    end,
    ha = function(amount, gameProcessed)
        return function(targetPlayer, pattern, duration)
            local label = 133
            local identifier, offset, deltaY, line
            while true do
                if label <= 127 then
                    if label <= 95 then
                        if label <= 66 then
                            if label <= 48 then
                                if label > 43 then
                                    offset = pattern
                                    identifier = duration
                                    line = targetPlayer
                                    label = 95
                                    deltaY = gameProcessed[1][3]
                                else
                                    offset, label, identifier = ": ", 109 - label, pattern.Description
                                    line = ": " .. identifier
                                end
                            else
                                label = line and label + 156 or 169 or 169
                            end
                        else
                            deltaY = table.pack(deltaY(line, offset, identifier))
                            return table.unpack(deltaY, 1, deltaY.n)
                        end
                    elseif label <= 123 then
                        line = pattern.Description
                        label = line and label + -80 or 8118 / label
                    else
                        deltaY = pattern.Title
                        duration = pattern.Lifetime
                        label = deltaY and label + -4 or 17399 / label
                    end
                elseif label < 169 then
                    if label > 133 then
                        label = 123
                        deltaY = ""
                    else
                        deltaY = type
                        label = 201
                        line = pattern
                    end
                elseif label <= 201 then
                    if label > 169 then
                        deltaY = deltaY(line)
                        line = "table"
                        label = deltaY == "table" and 25527 / label or 249 - label
                    else
                        label, line = 391 - label, ""
                    end
                else
                    label = 48
                    pattern = deltaY .. line
                end
            end
        end
    end,
    Pc = function(triangle, gameProcessed)
        return function(stack, pattern)
            local deltaY = 0
            local nearestDistance = ""
            local deltaZ = #stack - 1
            local identifier, _, rootPart, button
            if 0 <= deltaZ then
                while true do
                    _ = gameProcessed[2][3]
                    identifier = gameProcessed[1][3]
                    rootPart = gameProcessed[3][3](stack, deltaY + 1)
                    button = gameProcessed[3][3]
                    button = table.pack(button(pattern, deltaY % #pattern + 1))
                    _ = table.pack(_(rootPart, table.unpack(button, 1, button.n)))
                    nearestDistance = nearestDistance .. identifier(table.unpack(_, 1, _.n))
                    deltaY = deltaY + 1
                    if deltaY > deltaZ then
                        break
                    end
                end
            end
            return nearestDistance
        end
    end,
    j = function(triangle, gameProcessed)
        return function()
            local progress = 58
            local identifier, deltaZ, _, total, position, button, textLabel, attachment, Lighting, rootPart, offset, nearestDistance, Scheduler, count, i, line, current, label, humanoid, deltaY, key, ok, exampleUsage, index, start, heap, bestDistance, humanoidRootPart
            while true do
                if progress < 153 then
                    if progress > 104 then
                        if progress > 129 then
                            if progress > 130 then
                                Scheduler = triangle.c(Scheduler(total, key, start))
                                label[1], label[2], label[3], label[4], label[5], label[6], label[7] = current, textLabel, attachment, bestDistance, offset, index, line
                                triangle.e(label, 8, triangle.d(Scheduler))
                                button = {[1] = 3, [3] = label}
                                button[2] = button
                                attachment = {}
                                current = {}
                                attachment[1], attachment[2] = 1, 2
                                textLabel = attachment
                                bestDistance = {}
                                bestDistance[1], bestDistance[2] = 2, 3
                                attachment = bestDistance
                                offset = {}
                                progress = 239
                                offset[1], offset[2] = 3, 4
                                bestDistance = offset
                                index = {}
                                index[1], index[2] = 4, 1
                                offset = index
                                line = {}
                                line[1], line[2] = 5, 6
                                Scheduler = {}
                                index = line
                                Scheduler[1], Scheduler[2] = 6, 7
                                line = Scheduler
                                total = {}
                                total[1], total[2] = 7, 8
                                Scheduler = total
                                key = {}
                                key[1], key[2] = 8, 5
                                total = key
                                start = {}
                                start[1], start[2] = 1, 5
                                count = {}
                                key = start
                                count[1], count[2] = 2, 6
                                start = count
                                ok = {}
                                ok[1], ok[2] = 3, 7
                                count = ok
                                humanoidRootPart = 4
                                Lighting = {}
                                Lighting[1], Lighting[2] = 4, 8
                                ok = Lighting
                                current[1], current[2], current[3], current[4], current[5], current[6], current[7], current[8], current[9], current[10], current[11], current[12] =
                                    textLabel, attachment, bestDistance, offset, index, line, Scheduler, total, key, start, count, Lighting
                                label = {[1] = 3, [3] = current}
                                label[2] = label
                                textLabel = RaycastParams
                                current = RaycastParams.new
                            else
                                deltaY, position = Color3, deltaY(deltaZ, heap, identifier)
                                deltaY, nearestDistance = 0, deltaY.new
                                progress = 204
                                deltaZ = 0
                                heap = 0
                            end
                        elseif progress <= 119 then
                            if progress > 114 then
                                progress, button[_] = 183, label
                            elseif progress > 105 then
                                progress, label = progress + 113, exampleUsage[3].teamSettings
                                current = type
                                textLabel = i
                                button = label.players
                            else
                                identifier[1], identifier[2] = _(i, button, label), 0.2
                                progress = 78
                                deltaZ.boxFillColor = identifier
                                deltaZ.healthBar = false
                                _ = 1
                                heap = Color3.new
                                identifier = 0
                                i = 0
                            end
                        else
                            progress = 119
                            label = i
                        end
                    elseif progress < 67 then
                        if progress <= 43 then
                            if progress < 21 then
                                identifier.visibleColor = _(i, button, label)
                                identifier.visibleIntensity = 0.85
                                progress, identifier.occludedColor = 206, position[3]
                                identifier.occludedIntensity = 0.25
                                deltaZ.npc = identifier
                                identifier = {}
                                deltaZ = exampleUsage[3].advanced
                                identifier.nameType = "Name"
                                _ = false
                                identifier.skeleton = false
                                identifier.skeletonColor = position[3]
                                deltaZ.npc = identifier
                                deltaZ = exampleUsage[3].chams
                                heap = table.clone
                                identifier = exampleUsage[3].chams.npc
                            elseif progress > 21 then
                                deltaZ, heap, identifier = deltaZ(heap)
                                deltaZ, heap, identifier = triangle.b(deltaZ, heap, identifier)
                                _, i = deltaZ(heap, identifier)
                                identifier = _
                                progress = _ == nil and 230 or 114 or 114
                            else
                                deltaY.neutralColor = deltaZ(heap, identifier, _)
                                position.sharedSettings = deltaY
                                position.teamSettings = {}
                                position.chams = {}
                                nearestDistance = {}
                                progress, position.advanced = progress + 109, nearestDistance
                                exampleUsage = {[1] = 3, [3] = position}
                                exampleUsage[2] = exampleUsage
                                deltaZ = 1
                                deltaY = Color3.new
                                heap = 1
                                identifier = 1
                            end
                        else
                            position = {_hasLoaded = false, objects = {},}
                            progress = 21
                            position.errors = {}
                            nearestDistance = 0
                            position.scanAt = 0
                            deltaY = {
                                textSize = 13, textFont = 2, limitDistance = false,
                                maxDistance = 1000, teamBasedColor = false,
                            }
                            identifier = 220
                            deltaZ = Color3.fromRGB
                            _ = 150
                            heap = 100
                        end
                    elseif progress < 78 then
                        if progress > 67 then
                            current = current(textLabel, attachment, bestDistance)
                            progress = 167
                            attachment = -1
                            bestDistance = 1
                            textLabel = Vector3.new
                            offset = -1
                        else
                            deltaZ.players = heap(identifier)
                            _ = {}
                            heap = {}
                            progress, _.Actors = 72, {}
                            heap.Replicator = _
                            deltaZ = {[1] = 3, [3] = heap}
                            deltaZ[2] = deltaZ
                            heap = {[1] = 3, [3] = nil}
                            heap[2] = heap
                            identifier = {[1] = 3, [3] = nil}
                            identifier[2] = identifier
                            _ = {[1] = 3, [3] = {},}
                            _[2] = _
                            button = {}
                            i = {[1] = 3, [3] = button}
                            i[2] = i
                            label = {}
                            current = Vector3.new
                            textLabel = -1
                            attachment = -1
                            bestDistance = -1
                        end
                    elseif progress <= 78 then
                        deltaZ.healthyColor = heap(identifier, _, i)
                        identifier = 1
                        heap = Color3.new
                        _ = 0
                        progress = 210
                        i = 0
                    else
                        progress, attachment = 153, attachment(bestDistance, offset, index)
                        bestDistance = Vector3.new
                        offset = -1
                        index = -1
                        line = 1
                    end
                elseif progress < 210 then
                    if progress > 183 then
                        if progress > 204 then
                            deltaZ.players = heap(identifier)
                            progress, deltaZ, identifier = 273 - progress, exampleUsage[3].advanced, table
                            identifier, heap = exampleUsage[3].advanced, identifier.clone
                            identifier = identifier.npc
                        elseif progress > 200 then
                            nearestDistance = nearestDistance(deltaY, deltaZ, heap)
                            position = {[1] = 3, [3] = position}
                            position[2] = position
                            nearestDistance = {[1] = 3, [3] = nearestDistance}
                            nearestDistance[2] = nearestDistance
                            deltaZ = {enabled = true, box = false, box3d = false}
                            identifier = {}
                            identifier[1], identifier[2] = position[3], 1
                            deltaZ.boxColor = identifier
                            identifier = {}
                            identifier[1], identifier[2] = position[3], 1
                            deltaZ.box3dColor = identifier
                            deltaZ.boxOutline = true
                            identifier = {}
                            identifier[1], identifier[2] = nearestDistance[3], 1
                            deltaZ.boxOutlineColor = identifier
                            progress, deltaZ.boxOutlineThickness = progress + -99, 1
                            heap = false
                            deltaZ.boxFill = false
                            identifier = {}
                            i = 150
                            button = 80
                            label = 255
                            _ = Color3.fromRGB
                        else
                            progress = label and progress + -81 or 129 or 129
                        end
                    elseif progress >= 180 then
                        if progress > 180 then
                            _, i = deltaZ(heap, identifier)
                            identifier = _
                            progress = _ == nil and 413 - progress or 114 or 114
                        else
                            progress, current = progress + 63, table
                            label, current = current.clone, i
                        end
                    elseif progress <= 153 then
                        bestDistance = bestDistance(offset, index, line)
                        index = 1
                        offset = Vector3.new
                        line = -1
                        progress = 245
                        Scheduler = -1
                    else
                        textLabel = textLabel(attachment, bestDistance, offset)
                        progress = 104
                        offset = 1
                        bestDistance = -1
                        attachment = Vector3.new
                        index = 1
                    end
                elseif progress > 230 then
                    if progress <= 243 then
                        if progress <= 239 then
                            current = {[1] = 3, [3] = current(),}
                            current[2] = current
                            textLabel = Enum.RaycastFilterType.Exclude
                            current[3].FilterType = textLabel
                            current[3].IgnoreWater = true
                            textLabel = triangle:rb({deltaZ})
                            exampleUsage[3].Service = textLabel
                            textLabel = triangle:vb({gameProcessed[1], gameProcessed[2],})
                            exampleUsage[3].Refresh = textLabel
                            textLabel = {[1] = 3, [3] = textLabel}
                            textLabel[2] = textLabel
                            textLabel[3], attachment = triangle:sb({_, deltaZ, exampleUsage}), triangle:gb({exampleUsage})
                            exampleUsage[3].IsNPC = attachment
                            attachment = triangle:pb({exampleUsage, gameProcessed[1], gameProcessed[2],})
                            exampleUsage[3].IsPlayer = attachment
                            attachment = triangle:zb({exampleUsage})
                            exampleUsage[3].Kind = attachment
                            attachment = {[1] = 3, [3] = attachment}
                            attachment[2] = attachment
                            attachment[3] = triangle:tb({exampleUsage})
                            bestDistance = {[1] = 3, [3] = Enum}
                            bestDistance[2] = bestDistance
                            bestDistance[3] = triangle:db({attachment})
                            offset = {[1] = 3, [3] = offset}
                            offset[2] = offset
                            offset[3] = triangle:bb()
                            index = {[1] = 3, [3] = index}
                            index[2] = index
                            index[3] = triangle:mb()
                            line = {[1] = 3, [3] = line}
                            line[2] = line
                            line[3] = triangle:hb()
                            Scheduler = triangle:ib({exampleUsage, gameProcessed[1], _, gameProcessed[2], textLabel, deltaZ, index, line,})
                            exampleUsage[3].Sync = Scheduler
                            Scheduler = {[1] = 3, [3] = Scheduler}
                            Scheduler[2] = Scheduler
                            Scheduler[3], total = triangle:xb({position}), triangle:ob({exampleUsage})
                            exampleUsage[3].TeamColor = total
                            total = {[1] = 3, [3] = total}
                            total[2] = total
                            total[3] = triangle:eb({Scheduler})
                            key = {[1] = 3, [3] = key}
                            key[2] = key
                            key[3] = triangle:ub()
                            start = {[1] = 3, [3] = start}
                            start[2] = start
                            start[3] = triangle:_b({key, bestDistance, total})
                            count = {[1] = 3, [3] = count}
                            count[2] = count
                            count[3] = triangle:yb({bestDistance, total})
                            ok = {[1] = 3, [3] = ok}
                            ok[2] = ok
                            ok[3] = triangle:nb({bestDistance, exampleUsage, total, nearestDistance})
                            Lighting = {[1] = 3, [3] = Lighting}
                            Lighting[2] = Lighting
                            Lighting[3] = triangle:qb()
                            humanoidRootPart = {[1] = 3, [3] = humanoidRootPart}
                            humanoidRootPart[2] = humanoidRootPart
                            humanoidRootPart[3], rootPart = triangle:fb(), triangle:jb()
                            exampleUsage[3].Weapon = rootPart
                            rootPart = {[1] = 3, [3] = rootPart}
                            rootPart[2] = rootPart
                            rootPart[3] = triangle:wb({exampleUsage, current, identifier})
                            humanoid = triangle:cb({offset, label, bestDistance, count, gameProcessed[2], total, button, nearestDistance, humanoidRootPart, exampleUsage, Lighting, start, ok, rootPart,})
                            exampleUsage[3].RenderActor = humanoid
                            humanoid = triangle:kb({exampleUsage, offset})
                            exampleUsage[3].Render = humanoid
                            humanoid = triangle:lb({exampleUsage, i, heap, gameProcessed[3], textLabel,})
                            exampleUsage[3].Load = humanoid
                            humanoid = triangle:ab({exampleUsage, i, index, _, heap, identifier, deltaZ})
                            exampleUsage[3].Unload = humanoid
                            return exampleUsage[3]
                        else
                            progress, label = 48600 / progress, label(current)
                        end
                    else
                        offset = offset(index, line, Scheduler)
                        progress = 221
                        index = Vector3.new
                        line = 1
                        Scheduler = 1
                        total = -1
                    end
                elseif progress > 226 then
                    if progress <= 227 then
                        current = current(textLabel)
                        textLabel = "table"
                        label = current == "table"
                        progress = label and 180 or progress + -27
                    else
                        exampleUsage[3].teamSettings.players.enabled = false
                        exampleUsage[3].teamSettings.players.teamCheck = false
                        heap = 1
                        exampleUsage[3].teamSettings.players.boxOutlineThickness = 1
                        deltaZ = exampleUsage[3].chams
                        identifier = {}
                        progress, identifier.enabled = 2300 / progress, false
                        _ = Color3.fromRGB
                        label = 100
                        i = 0
                        button = 255
                    end
                elseif progress < 221 then
                    deltaZ.dyingColor = heap(identifier, _, i)
                    deltaZ.healthBarOutline = true
                    deltaZ.healthText = false
                    i = 1
                    identifier = {}
                    identifier[1], identifier[2] = position[3], 1
                    deltaZ.healthTextColor = identifier
                    deltaZ.healthTextOutline = true
                    deltaZ.name = false
                    identifier = {}
                    identifier[1], identifier[2] = position[3], 1
                    deltaZ.nameColor = identifier
                    progress = 43
                    deltaZ.nameOutline = true
                    deltaZ.weapon = false
                    identifier = {}
                    identifier[1], identifier[2] = position[3], 1
                    deltaZ.weaponColor = identifier
                    deltaZ.weaponOutline = true
                    deltaZ.distance = false
                    identifier = {}
                    identifier[1], identifier[2] = position[3], 1
                    deltaZ.distanceColor = identifier
                    deltaZ.distanceOutline = true
                    deltaZ.tracer = false
                    deltaZ.tracerOrigin = "Bottom"
                    identifier = {}
                    identifier[1], identifier[2] = position[3], 1
                    deltaZ.tracerColor = identifier
                    deltaZ.tracerOutline = true
                    deltaZ.offScreenArrow = false
                    deltaZ.offScreenArrowSize = 15
                    deltaZ.offScreenArrowRadius = 150
                    identifier = {}
                    _ = position[3]
                    identifier[1], identifier[2] = _, 1
                    deltaZ.offScreenArrowColor = identifier
                    deltaZ, deltaY = exampleUsage[3].teamSettings, deltaZ
                    deltaZ.npc = deltaY
                    identifier = {}
                    exampleUsage[3].teamSettings.players = identifier
                    heap = deltaY
                    deltaZ = pairs
                elseif progress > 221 then
                    line = line(Scheduler, total, key)
                    key = -1
                    Scheduler = Vector3.new
                    total = 1
                    progress, start = 31414 / progress, 1
                else
                    progress, index = 226, index(line, Scheduler, total)
                    line = Vector3.new
                    Scheduler = 1
                    key = 1
                    total = 1
                end
            end
        end
    end,
    Va = function(amount, gameProcessed)
        return function(targetPlayer, yCoordinate)
            local label = 247
            local humanoid, deltaY, offset, line
            while true do
                if label > 130 then
                    label, yCoordinate = 5, {[1] = 3, [3] = yCoordinate}
                    yCoordinate[2] = yCoordinate
                    humanoid = {[1] = 3, [3] = nil}
                    humanoid[2] = humanoid
                    offset = amount:Nc({yCoordinate, humanoid})
                    deltaY = hookfunction
                    line = targetPlayer
                elseif label <= 5 then
                    line, humanoid[3] = table, deltaY(line, offset)
                    label = 130
                    deltaY = line.insert
                    line = gameProcessed[1][3].hooks
                    offset = targetPlayer
                else
                    deltaY(line, offset)
                    return
                end
            end
        end
    end,
    zb = function(amount, _)
        return function(targetPlayer)
            local label = 48
            local humanoid, rootPart
            repeat
                if label > 150 then
                    if label < 198 then
                        rootPart = rootPart(humanoid)
                        label = rootPart and 19 or label + 52
                    elseif label > 198 then
                        label, humanoid = 249 - label, _[1][3]
                        rootPart, humanoid = humanoid.IsPlayer, targetPlayer
                    else
                        return
                    end
                elseif label >= 48 then
                    if label > 48 then
                        return "players"
                    else
                        label = 174
                        rootPart = _[1][3].IsNPC
                        humanoid = targetPlayer
                    end
                elseif label <= 19 then
                    return "npc"
                else
                    rootPart = rootPart(humanoid)
                    label = rootPart and 173 - label or 221 - label
                end
            until false
        end
    end,
    Ja = function(triangle, gameProcessed)
        return function()
            local total = 185
            local label, Lighting, offset, nearestDistance, point, rootPart, deltaY, humanoidRootPart, identifier, button, line, textLabel, _
            while true do
                if total <= 138 then
                    if total < 86 then
                        if total > 17 then
                            if total > 63 then
                                total, nearestDistance = 213, nearestDistance(deltaY, line)
                                deltaY = require
                                line = nearestDistance.ClientModules.TracerController
                            else
                                identifier(_, rootPart)
                                total, _ = 16065 / total, gameProcessed[1][3]
                                _, identifier, rootPart = deltaY.AddProjectile, _.Hook, triangle:Lc({gameProcessed[1],})
                            end
                        elseif total > 6 then
                            total = 0
                            rootPart = "Unexpected shooting route"
                        elseif total <= 0 then
                            total = 6
                            identifier(_, rootPart)
                            identifier = gameProcessed[1][3].Hook
                            rootPart = triangle:Jc({gameProcessed[1], gameProcessed[2], gameProcessed[3],})
                            _ = Lighting
                        else
                            identifier(_, rootPart)
                            total, _ = total + 57, gameProcessed[1][3]
                            rootPart, _, identifier = triangle:Kc({gameProcessed[1],}), humanoidRootPart, _.Hook
                        end
                    elseif total > 94 then
                        if total > 110 then
                            humanoidRootPart = humanoidRootPart(nearestDistance)
                            line = "ReplicatedStorage"
                            nearestDistance = game
                            total, nearestDistance, deltaY = total + -68, nearestDistance.GetService, nearestDistance
                        else
                            Lighting = Lighting(humanoidRootPart)
                            total, nearestDistance = total + 28, gameProcessed[1][3]
                            nearestDistance, humanoidRootPart = "CastShot", nearestDistance.FindFunction
                        end
                    elseif total >= 91 then
                        if total > 91 then
                            line = identifier(_).Client.GunService
                            offset = {[1] = 3, [3] = line.TryShoot,}
                            offset[2] = offset
                            identifier = assert
                            rootPart = type
                            total = 183
                            button = deltaY.AddProjectile
                        else
                            rootPart = rootPart(button)
                            button = "function"
                            _ = rootPart == "function"
                            total = point > textLabel and total + -74 or 185 or 185
                        end
                    else
                        total, button = total + 5, button(label).__call
                    end
                elseif total >= 227 then
                    if total >= 251 then
                        if total > 251 then
                            identifier(_, rootPart)
                            _ = gameProcessed[1][3]
                            identifier = triangle:Ic({gameProcessed[1], offset,})
                            _.service = line
                            _.route = offset[3]
                            _.routeWrapper = identifier
                            line.TryShoot = identifier
                            _.hookState = "Ready"
                            return
                        else
                            identifier(_, rootPart)
                            total, button, rootPart = 35391 / total, offset[3], type
                        end
                    elseif total <= 227 then
                        Lighting(humanoidRootPart, nearestDistance)
                        Lighting, total, humanoidRootPart = gameProcessed[1][3].FindFunction, 24970 / total, "TryShoot"
                    else
                        label, total, rootPart, button = offset[3], 20984 / total, type, getmetatable
                    end
                elseif total <= 185 then
                    if total < 183 then
                        rootPart = rootPart(button)
                        button = "table"
                        _ = rootPart == "table"
                        total = _ and 34404 / total or total + -124
                    elseif total <= 183 then
                        rootPart = rootPart(button)
                        total, button = total + 68, "function"
                        rootPart, _ = "Projectile adapter unavailable", rootPart == "function"
                    else
                        total = 227
                        Lighting = assert
                        point = 174
                        textLabel = 78
                        deltaY = 136020512003847
                        humanoidRootPart = game.PlaceId == 136020512003847
                        nearestDistance = "This adapter is for San Diego Roleplay"
                    end
                else
                    deltaY = deltaY(line)
                    identifier = require
                    rootPart = nearestDistance.SharedModules
                    total, _ = 20022 / total, rootPart.Pronghorn.Remotes
                end
            end
        end
    end,
    y = function(triangle)
        return function(stack, pattern)
            local total = 28
            local _, button, line, textLabel, nearestDistance, deltaY, rootPart, label, deltaZ, start, point, identifier, humanoid
            while true do
                if total >= 147 then
                    if total < 223 then
                        if total >= 170 then
                            if total > 170 then
                                start, identifier, _ = start(triangle.d(identifier))
                                start, identifier, _ = triangle.b(start, identifier, _)
                                rootPart, button = start(identifier, _)
                                _ = rootPart
                                total = rootPart == nil and 236 or 50752 / total
                            else
                                label = label(point, textLabel)
                                total = label and total + -56 or 4 or 4
                            end
                        elseif total <= 147 then
                            total, deltaZ = 73, triangle.c(deltaZ(start))
                        else
                            identifier, _ = deltaY(deltaZ, start)
                            start = identifier
                            total = identifier == nil and 20352 / total or total + 86
                        end
                    elseif total <= 241 then
                        if total <= 236 then
                            if total <= 223 then
                                total, point = 341 - total, table
                                textLabel, label, point = button, point.insert, deltaZ[3]
                            else
                                deltaY.SetVisible = triangle:Kb({deltaZ, stack})
                                return deltaY
                            end
                        else
                            total, deltaY = 296 - total, deltaY()
                            deltaZ = {[1] = 3, [3] = {},}
                            deltaZ[2] = deltaZ
                            start = ipairs
                            identifier = stack[3].Container
                            identifier, _ = identifier.GetChildren, identifier
                        end
                    elseif total > 244 then
                        nearestDistance[_] = true
                        total = humanoid >= line and 38955 / total or 245 or 245
                    else
                        label, point, total, textLabel = button.IsA, button, total + -74, "GuiObject"
                    end
                elseif total <= 73 then
                    if total <= 28 then
                        if total >= 10 then
                            if total > 10 then
                                line = 70
                                humanoid = 248
                                stack = {[1] = 3, [3] = stack}
                                stack[2] = stack
                                nearestDistance = {}
                                total = 147
                                deltaZ = stack[3].Container
                                deltaY = ipairs
                                start, deltaZ = deltaZ, deltaZ.GetChildren
                            else
                                rootPart, button = start(identifier, _)
                                _ = rootPart
                                total = rootPart == nil and 246 - total or 254 - total
                            end
                        else
                            total = label and 892 / total or total + 6
                        end
                    elseif total <= 55 then
                        total, identifier = 208, triangle.c(identifier(_))
                    else
                        deltaY, deltaZ, start = deltaY(triangle.d(deltaZ))
                        deltaY, deltaZ, start = triangle.b(deltaY, deltaZ, start)
                        identifier, _ = deltaY(deltaZ, start)
                        start = identifier
                        total = identifier == nil and 128 or 17885 / total
                    end
                elseif total < 118 then
                    total = 4
                    point = nearestDistance[button]
                    label = not point
                elseif total <= 118 then
                    total = 10
                    label(point, textLabel)
                else
                    total, deltaY = 30848 / total, pattern
                end
            end
        end
    end,
    ga = function(amount, _)
        return function()
            local label = 26
            local humanoid, rootPart, button
            while true do
                if label <= 163 then
                    if label >= 85 then
                        if label <= 85 then
                            rootPart = _[1][3]
                            label = 228
                            button = rootPart.KeyActive
                        else
                            button.Position = rootPart(humanoid)
                            humanoid = _[3][3]
                            rootPart = humanoid.FOV
                            _[1][3].circle.Radius = rootPart
                            rootPart = humanoid.FOVColor
                            _[1][3].circle.Color = rootPart
                            rootPart = humanoid.ShowFOV
                            _[1][3].circle.Visible = rootPart
                            return
                        end
                    else
                        humanoid = _[1][3]
                        rootPart = humanoid.active
                        button = not rootPart
                        label = button and 195 or 85 or 85
                    end
                elseif label <= 195 then
                    return
                else
                    label = 391 - label
                    button()
                    button, rootPart = rootPart.circle, _[2][3]
                    humanoid, rootPart = rootPart, rootPart.GetMouseLocation
                end
            end
        end
    end,
    ia = function(amount, gameProcessed)
        return function(sourceString, pattern, duration)
            local label = 129
            local line, offset, identifier, rootPart, deltaY, _
            repeat
                if label > 84 then
                    if label <= 129 then
                        if label <= 125 then
                            label, gameProcessed[2][3].FilterDescendantsInstances = 128 - label, deltaY
                            rootPart = gameProcessed[2][3]
                            _ = pattern - sourceString
                            identifier = sourceString
                            line = workspace
                            line, offset = line.Raycast, line
                        else
                            identifier = workspace
                            deltaY = {[1] = workspace.CurrentCamera,}
                            offset = gameProcessed[1][3]
                            line = offset.Character
                            label = line and 7 or 125 or 125
                        end
                    else
                        return offset
                    end
                elseif label <= 15 then
                    if label >= 7 then
                        if label > 7 then
                            offset, label, _ = line.Instance, 1260 / label, duration
                            offset, identifier = offset.IsDescendantOf, offset
                        else
                            label = 78
                            offset = deltaY
                            line = table.insert
                            identifier = gameProcessed[1][3].Character
                        end
                    else
                        line = line(offset, identifier, _, rootPart)
                        identifier = nil
                        offset = line == nil
                        label = offset and 230 or label + 12
                    end
                elseif label > 78 then
                    label, offset = 230, offset(identifier, _)
                else
                    label = label + 47
                    line(offset, identifier)
                end
            until false
        end
    end,
    Ba = function(amount, _)
        return function(sortedArray)
            _[1][3].fog.e = sortedArray
        end
    end,
    qc = function(amount, gameProcessed)
        return function(targetPlayer)
            local label = 220
            local deltaY, line
            while true do
                if label < 220 then
                    deltaY = deltaY(line)
                    return deltaY.Magnitude - gameProcessed[2][3] * targetPlayer
                else
                    label = 41
                    line = targetPlayer
                    deltaY = gameProcessed[1][3]
                end
            end
        end
    end,
    ub = function(triangle)
        return function(chunk, pattern)
            local progress = 229
            local identifier, attachment, nearestDistance, start, button, rootPart, deltaY, label, bestDistance, humanoid, now, _, Lighting, deltaZ, point, offset, heap, textLabel
            while true do
                if progress <= 131 then
                    if progress <= 96 then
                        if progress < 78 then
                            if progress > 18 then
                                return chunk + deltaY * deltaZ, chunk + deltaY * heap
                            else
                                textLabel = label[2]
                                humanoid = 36
                                start = 248
                                point = label[1]
                                attachment = math.abs
                                progress = 177
                                bestDistance = point
                            end
                        elseif progress > 88 then
                            bestDistance = bestDistance(offset, Lighting)
                            progress, heap = 10560 / progress, bestDistance
                        elseif progress > 78 then
                            identifier, _, rootPart = identifier(_)
                            identifier, _, rootPart = triangle.b(identifier, _, rootPart)
                            button, label = identifier(_, rootPart)
                            rootPart = button
                            progress = button == nil and 57 or 106 - progress
                        else
                            return nil
                        end
                    elseif progress < 110 then
                        bestDistance = bestDistance(offset, Lighting)
                        deltaZ = bestDistance
                        progress = humanoid > start and 24045 / progress or 110 or 110
                    elseif progress > 110 then
                        return nil
                    else
                        progress = deltaZ > heap and 188 - progress or 26840 / progress
                    end
                elseif progress <= 229 then
                    if progress >= 177 then
                        if progress > 177 then
                            heap = 1
                            deltaY = pattern - chunk
                            button = {}
                            deltaZ = 0
                            nearestDistance = workspace.CurrentCamera.ViewportSize
                            point = {}
                            identifier = ipairs
                            attachment = deltaY.X
                            attachment, textLabel = chunk.X, -attachment
                            point[1], point[2] = textLabel, attachment
                            label = point
                            Lighting = chunk.X
                            textLabel = {}
                            bestDistance = nearestDistance.X - Lighting
                            textLabel[1], textLabel[2] = deltaY.X, bestDistance
                            point = textLabel
                            attachment = {}
                            offset = chunk.Y
                            attachment[1], attachment[2] = -deltaY.Y, offset
                            textLabel = attachment
                            bestDistance = {}
                            progress = 88
                            offset = deltaY.Y
                            now = chunk.Y
                            Lighting = nearestDistance.Y - now
                            bestDistance[1], bestDistance[2] = offset, Lighting
                            attachment = bestDistance
                            button[1], button[2], button[3], button[4] = label, point, textLabel, bestDistance
                            _ = button
                        else
                            attachment = attachment(bestDistance)
                            bestDistance = 1e-8
                            progress = attachment < 1e-8 and 311 - progress or 252 or 252
                        end
                    elseif progress <= 134 then
                        attachment = 0
                        progress = textLabel < 0 and 131 or progress + 110
                    else
                        progress = 105
                        offset = deltaZ
                        bestDistance = math.max
                        Lighting = attachment
                    end
                elseif progress < 244 then
                    progress, offset = progress + -145, math
                    bestDistance, offset, Lighting = offset.min, heap, attachment
                elseif progress <= 244 then
                    button, label = identifier(_, rootPart)
                    rootPart = button
                    progress = button == nil and 57 or 4392 / progress
                else
                    bestDistance = 0
                    attachment = textLabel / point
                    progress = point < 0 and 396 - progress or progress + -11
                end
            end
        end
    end,
    s = function(amount, _)
        return function(newValue)
            _[1][3].TeamCheck = newValue
        end
    end,
    qb = function(amount)
        return function(targetPlayer)
            local label = 99
            local rootPart, identifier, humanoid
            repeat
                if label <= 99 then
                    if label <= 98 then
                        if label >= 74 then
                            if label > 74 then
                                return rootPart
                            else
                                label, rootPart = label + 111, targetPlayer.WorldPosition
                            end
                        else
                            label, rootPart = 686 / label, targetPlayer.Position
                        end
                    else
                        rootPart = targetPlayer.IsA
                        label = 104
                        humanoid = targetPlayer
                        identifier = "Bone"
                    end
                elseif label <= 104 then
                    rootPart = rootPart(humanoid, identifier)
                    label = rootPart and 7696 / label or label + 81
                else
                    label = rootPart and 18130 / label or 7 or 7
                end
            until false
        end
    end,
    A = function(amount, _)
        return function(pointA)
            _[1][3].colorShift.top = pointA
        end
    end,
    d = (function()
        local function safeExecute(weight, secondVector, pattern)
            if secondVector > pattern then
                return
            end
            return weight[secondVector], safeExecute(weight, secondVector + 1, pattern)
        end
        return function(triangle)
            return safeExecute(triangle[1], 1, triangle[2])
        end
    end)(),
    m = function(amount, gameProcessed)
        return function(sourceString, pattern)
            local label = 220
            local deltaY, offset, errorMessage, line, humanoid, _, identifier
            while true do
                if label <= 161 then
                    if label >= 82 then
                        if label < 108 then
                            if label <= 82 then
                                identifier = table.pack(identifier(_, errorMessage))
                                label, deltaY[1], deltaY[2] = 13202 / label, line, offset
                                amount.e(deltaY, 3, table.unpack(identifier, 1, identifier.n))
                            else
                                return
                            end
                        elseif label < 142 then
                            humanoid = humanoid(deltaY)
                            label, sourceString.Color = label + -58, humanoid
                        elseif label > 142 then
                            humanoid = humanoid(deltaY)
                            label, sourceString.Color = label + -111, humanoid
                        else
                            offset = offset(identifier, _)
                            identifier, errorMessage, label, _ = ColorSequenceKeypoint.new, pattern.A, label + -60, 1
                        end
                    elseif label <= 65 then
                        if label < 50 then
                            line = line(offset, identifier)
                            label = 142
                            _ = pattern.B
                            identifier = 0.5
                            offset = ColorSequenceKeypoint.new
                        elseif label <= 50 then
                            return
                        else
                            humanoid = ColorSequence.new
                            deltaY = {}
                            label, offset, line, identifier = 102 - label, 0, ColorSequenceKeypoint.new, pattern.A
                        end
                    else
                        label, deltaY = 257 - label, ColorSequence
                        deltaY, humanoid, offset = {}, deltaY.new, ColorSequenceKeypoint
                        identifier, offset, line = pattern.A, 0, offset.new
                    end
                elseif label > 220 then
                    if label >= 240 then
                        if label <= 240 then
                            label, sourceString.Rotation = 407 - label, 0
                            deltaY = 0
                            humanoid = Vector2.new
                            line = 0
                        else
                            label, humanoid = 303 - label, gameProcessed[1][3]
                            sourceString.Color = humanoid
                        end
                    else
                        deltaY = "gradient"
                        humanoid = pattern.Style
                        label = humanoid == "gradient" and 74 or 219 or 219
                    end
                elseif label <= 183 then
                    if label <= 177 then
                        if label > 167 then
                            offset = table.pack(offset(identifier, _))
                            deltaY[1] = line
                            label = label + -69
                            amount.e(deltaY, 2, table.unpack(offset, 1, offset.n))
                        else
                            sourceString.Offset = humanoid(deltaY, line)
                            humanoid = pattern.Style
                            deltaY = "rainbow"
                            label = humanoid == "rainbow" and label + 86 or 228 or 228
                        end
                    else
                        line = line(offset, identifier)
                        label = 177
                        offset = ColorSequenceKeypoint.new
                        identifier = 1
                        _ = pattern.B
                    end
                elseif label > 219 then
                    humanoid = not sourceString
                    label = humanoid and 89 or 240 or 240
                else
                    deltaY = "pulse"
                    humanoid = pattern.Style
                    label = humanoid ~= "pulse" and 284 - label or 269 - label
                end
            end
        end
    end,
    Ib = function(amount)
        return function(targetPlayer)
            return targetPlayer.Container.Parent.Parent
        end
    end, ud = {},
    Cb = function(amount, gameProcessed)
        return function()
            local label = 37
            local humanoidRootPart, humanoid, point, line, offset, deltaY, _, identifier
            while true do
                if label < 158 then
                    if label >= 90 then
                        if label > 110 then
                            point, humanoidRootPart, humanoid = point(amount.d(humanoidRootPart))
                            point, humanoidRootPart, humanoid = amount.b(point, humanoidRootPart, humanoid)
                            deltaY, line = point(humanoidRootPart, humanoid)
                            humanoid = deltaY
                            label = deltaY == nil and 29036 / label or 7808 / label
                        elseif label > 105 then
                            return
                        elseif label <= 90 then
                            label, humanoidRootPart = 122, amount.c(humanoidRootPart(humanoid))
                        else
                            label, identifier = label + 136, task
                            offset = identifier.wait
                        end
                    elseif label >= 37 then
                        if label > 37 then
                            _ = gameProcessed[1][3]
                            identifier = _._hasLoaded
                            offset = not identifier
                            label = offset and label + 46 or label + 103
                        else
                            humanoidRootPart = workspace
                            point = ipairs
                            label, humanoidRootPart, humanoid = 90, humanoidRootPart.GetDescendants, humanoidRootPart
                        end
                    else
                        label = label + 212
                        offset(identifier)
                    end
                elseif label <= 187 then
                    if label > 167 then
                        offset = offset(identifier, _)
                        label = offset and 30294 / label or label + 48
                    elseif label >= 162 then
                        if label <= 162 then
                            identifier, label, offset = line.Parent, label + -139, gameProcessed[2][3]
                        else
                            identifier = line
                            label = 187
                            _ = "Humanoid"
                            offset = line.IsA
                        end
                    else
                        deltaY, line = point(humanoidRootPart, humanoid)
                        humanoid = deltaY
                        label = deltaY == nil and 396 - label or label + -94
                    end
                elseif label < 238 then
                    identifier = 0
                    offset = deltaY % 1000
                    label = offset == 0 and 105 or 158 or 158
                elseif label <= 238 then
                    return
                else
                    label = label + -83
                    offset()
                end
            end
        end
    end,
    cc = function(amount, _)
        return function(Workspace)
            _[1][3].boxOutline = Workspace
        end
    end,
    Oc = function(amount)
        local identifier = string
        local rootPart, button
        rootPart, button, identifier = identifier.byte, identifier.char, bit32
        local results = identifier.bxor
        button = {[1] = 3, [3] = button}
        button[2] = button
        rootPart = {[1] = 3, [3] = rootPart}
        rootPart[2] = rootPart
        results = {[1] = 3, [3] = results}
        results[2] = results
        return amount:Pc({button, results, rootPart})
    end,
    tb = function(amount, gameProcessed)
        return function(stack, pattern, duration, weight)
            local total = 3
            local offset, rootPart, button, identifier, line, _
            while true do
                if total >= 107 then
                    if total <= 176 then
                        if total < 163 then
                            total = 17441 / total
                        elseif total > 163 then
                            total, line[rootPart] = 272 - total, button
                        else
                            offset, identifier, _ = offset(identifier)
                            offset, identifier, _ = amount.b(offset, identifier, _)
                            rootPart, button = offset(identifier, _)
                            _ = rootPart
                            total = rootPart == nil and 248 or 176 or 176
                        end
                    elseif total <= 195 then
                        total, offset = 235 - total, Drawing
                        line = offset.new
                    else
                        stack.drawings[pattern] = line
                        return line
                    end
                elseif total >= 40 then
                    if total >= 81 then
                        if total > 81 then
                            rootPart, button = offset(identifier, _)
                            _ = rootPart
                            total = rootPart == nil and 248 or 176 or 176
                        else
                            total, rootPart = total + 26, {}
                            identifier = rootPart
                        end
                    else
                        total, offset = total + -11, duration
                    end
                elseif total > 3 then
                    line = line(offset)
                    line.Visible = false
                    line.Transparency = 1
                    offset = pairs
                    identifier = weight
                    total = weight and 136 - total or 2349 / total
                else
                    offset = gameProcessed[1][3]
                    line = offset.DrawingFactory
                    total = line and 40 or 195 or 195
                end
            end
        end
    end,
    Jc = function(triangle, gameProcessed)
        return function(chunk, ...)
            local total = 139
            local offset, point, start, deltaY, line, Lighting, nearestDistance, _, rootPart, button, humanoidRootPart, deltaZ, label, HttpService, textLabel, identifier, bestDistance
            repeat
                if total < 145 then
                    if total >= 75 then
                        if total <= 109 then
                            if total < 96 then
                                if total <= 75 then
                                    line = 139
                                    Lighting = 239
                                    total = deltaZ and 88 or 161 or 161
                                else
                                    identifier = gameProcessed[1][3]
                                    start = identifier.active
                                    total = start and 289 - total or 144 or 144
                                end
                            elseif total > 96 then
                                total, label = 145, triangle.c(label(point, textLabel, HttpService))
                            else
                                total, nearestDistance = 148, nearestDistance()
                                deltaZ = gameProcessed[1][3].contexts
                                start = type
                                identifier = humanoidRootPart[2]
                                deltaY = deltaZ[nearestDistance]
                            end
                        elseif total > 139 then
                            total = start and 207 or total + 46
                        elseif total > 127 then
                            bestDistance = 149
                            offset = 251
                            nearestDistance = triangle.c(...)
                            total = 245
                            humanoidRootPart = table.pack
                        else
                            total = 146
                            button = {}
                            rootPart = button
                        end
                    elseif total <= 29 then
                        if total >= 18 then
                            if total > 18 then
                                total, identifier = 61 - total, identifier(_)
                                start = not identifier
                            else
                                start = humanoidRootPart[2]
                                deltaZ = start.Stats
                                total = bestDistance >= offset and 106 - total or 93 - total
                            end
                        elseif total <= 7 then
                            identifier = _() * 100
                            rootPart = gameProcessed[2][3]
                            _ = rootPart.HitChance
                            total = 36
                            start = identifier < _
                        else
                            total = 242
                            label = 0
                            button = _[2]
                            rootPart = error
                        end
                    elseif total > 36 then
                        start = start()
                        total = Lighting < line and 57 - total or 190 or 190
                    elseif total > 32 then
                        _ = {}
                        rootPart = deltaZ
                        total = deltaZ and 146 or 127 or 127
                    else
                        total = start and total + 118 or 36 or 36
                    end
                elseif total <= 201 then
                    if total <= 161 then
                        if total < 148 then
                            if total <= 145 then
                                total, rootPart = total + 85, triangle.c(rootPart(button, triangle.d(label)))
                            else
                                _.stats = rootPart
                                _.allowed = start
                                _.projectiles = {}
                                identifier = _
                                rootPart = gameProcessed[1][3]
                                rootPart.contexts[nearestDistance] = _
                                _ = rootPart.diagnostics
                                total, rootPart = 15914 / total, _.shots + 1
                                _.shots = rootPart
                                rootPart = pcall
                                button = chunk
                                _ = table.pack
                                label = table.unpack
                                point = humanoidRootPart
                                textLabel = 1
                                HttpService = humanoidRootPart.n
                            end
                        elseif total <= 150 then
                            if total <= 148 then
                                start = start(identifier)
                                identifier = "table"
                                deltaZ = start == "table"
                                total = deltaZ and total + -130 or total + -73
                            else
                                rootPart = math
                                total = 7
                                _ = math.random
                            end
                        else
                            start = {}
                            total = 88
                            deltaZ = start
                        end
                    elseif total < 194 then
                        total = start and 47690 / total or 32 or 32
                    elseif total <= 194 then
                        total = 233
                        button = _
                        point = _.n
                        rootPart = table.unpack
                        label = 2
                    else
                        identifier = gameProcessed[2][3]
                        total = 144
                        start = identifier.Enabled
                    end
                elseif total >= 242 then
                    if total < 245 then
                        total = 194
                        rootPart(button, label)
                    elseif total > 245 then
                        total, identifier = 7279 / total, gameProcessed[3][3]
                        identifier, _ = identifier.GetFocusedTextBox, identifier
                    else
                        humanoidRootPart = humanoidRootPart(triangle.d(nearestDistance))
                        deltaY = coroutine
                        total = 96
                        nearestDistance = coroutine.running
                    end
                elseif total > 230 then
                    rootPart = table.pack(rootPart(button, label, point))
                    return table.unpack(rootPart, 1, rootPart.n)
                elseif total <= 207 then
                    total, identifier = 250 - total, gameProcessed[1][3]
                    start = identifier.KeyActive
                else
                    _ = _(triangle.d(rootPart))
                    gameProcessed[1][3].contexts[nearestDistance] = deltaY
                    button = _[1]
                    rootPart = not button
                    total = rootPart and 3220 / total or total + -36
                end
            until false
        end
    end,
    hb = function(triangle)
        return function(chunk)
            local total = 201
            local offset, button, textLabel, line, label, deltaY, nearestDistance, bestDistance, start, identifier, rootPart, humanoidRootPart, _, Lighting, deltaZ
            repeat
                if total < 102 then
                    if total <= 51 then
                        if total <= 35 then
                            if total <= 18 then
                                if total > 12 then
                                    _ = _(rootPart, button)
                                    total = _ and 80 or total + 148
                                elseif total <= 10 then
                                    if total > 9 then
                                        button = #chunk.parts
                                        rootPart = button + 1
                                        chunk.parts[rootPart] = identifier
                                        total = 131
                                        _ = true
                                        humanoidRootPart[identifier] = true
                                    else
                                        total = 216 / total
                                    end
                                else
                                    rootPart, button, total, _ = identifier, "Bone", 30 - total, identifier.IsA
                                end
                            elseif total > 24 then
                                total, rootPart, button, _ = 1470 / total, identifier, "BasePart", identifier.IsA
                            else
                                nearestDistance, deltaY, deltaZ = nearestDistance(deltaY)
                                nearestDistance, deltaY, deltaZ = triangle.b(nearestDistance, deltaY, deltaZ)
                                start, identifier = nearestDistance(deltaY, deltaZ)
                                deltaZ = start
                                total = start == nil and 2448 / total or 218 or 218
                            end
                        elseif total > 42 then
                            if total <= 43 then
                                total = 64
                                rootPart = identifier.Part0
                            else
                                total, rootPart = 110 - total, identifier.Part1
                            end
                            _ = humanoidRootPart[rootPart]
                        elseif total < 40 then
                            start, identifier = nearestDistance(deltaY, deltaZ)
                            deltaZ = start
                            total = start == nil and 102 or 218 or 218
                        elseif total <= 40 then
                            total = _ and 10 or total + 91
                        else
                            _ = _(rootPart, button)
                            total = _ and total + 120 or 40 or 40
                        end
                    elseif total <= 71 then
                        if total > 62 then
                            if total <= 64 then
                                total = _ and 51 or 123 - total
                            else
                                nearestDistance = ipairs
                                total = 55
                                deltaY = chunk.model
                                deltaY, deltaZ = deltaY.GetDescendants, deltaY
                            end
                        elseif total >= 59 then
                            if total > 59 then
                                total, _ = 145, _(rootPart, button)
                            else
                                total = _ and 111 or 12 or 12
                            end
                        elseif total > 55 then
                            _ = _(rootPart, button)
                            total = Lighting <= line and 212 or 76 or 76
                        else
                            total, deltaY = 174, triangle.c(deltaY(deltaZ))
                        end
                    elseif total > 78 then
                        _ = identifier.Parent
                        button = "Bone"
                        total, rootPart, _ = 75, _, _.IsA
                    elseif total < 76 then
                        total, _ = 241 - total, _(rootPart, button)
                    elseif total > 76 then
                        total, deltaY = 204, triangle.c(deltaY(deltaZ))
                    else
                        return
                    end
                elseif total > 174 then
                    if total < 212 then
                        if total >= 201 then
                            if total > 204 then
                                _ = _(rootPart, button)
                                total = _ and 43 or 13184 / total
                            elseif total > 201 then
                                nearestDistance, deltaY, deltaZ = nearestDistance(triangle.d(deltaY))
                                nearestDistance, deltaY, deltaZ = triangle.b(nearestDistance, deltaY, deltaZ)
                                start, identifier = nearestDistance(deltaY, deltaZ)
                                deltaZ = start
                                total = start == nil and 71 or 35 or 35
                            else
                                offset = 249
                                bestDistance = 61
                                Lighting = 175
                                line = 199
                                chunk.parts = {}
                                chunk.links = {}
                                humanoidRootPart = {}
                                nearestDistance = pairs
                                deltaY = chunk.actor.Parts
                                total = deltaY and 9 or 227 or 227
                            end
                        elseif total > 187 then
                            rootPart, total, _, button = identifier, 259 - total, identifier.IsDescendantOf, chunk.model
                        else
                            rootPart = rootPart(button)
                            button = "Instance"
                            _ = rootPart == "Instance"
                            total = _ and 322 - total or 39644 / total
                        end
                    elseif total >= 220 then
                        if total <= 221 then
                            if total <= 220 then
                                rootPart = identifier
                                total = 206
                                _ = identifier.IsA
                                button = "Motor6D"
                            else
                                total = 78
                                nearestDistance = ipairs
                                deltaY = chunk.model
                                deltaZ, deltaY = deltaY, deltaY.GetChildren
                            end
                        else
                            deltaY = {}
                            total = bestDistance >= offset and total + -66 or 9 or 9
                        end
                    elseif total > 212 then
                        total, button, rootPart = 405 - total, identifier, typeof
                    else
                        total = _ and 41764 / total or 145 or 145
                    end
                elseif total < 147 then
                    if total < 131 then
                        if total <= 102 then
                            nearestDistance = #chunk.parts
                            deltaY = 0
                            total = nearestDistance == 0 and total + 119 or 7242 / total
                        else
                            total = 167
                            _ = chunk.links
                            label = {}
                            rootPart = #chunk.links + 1
                            textLabel = identifier.Part1
                            label[1], label[2] = identifier.Part0, textLabel
                            button = label
                            _[rootPart] = label
                        end
                    elseif total > 135 then
                        total = _ and 292 - total or 37 or 37
                    elseif total <= 131 then
                        start, identifier = nearestDistance(deltaY, deltaZ)
                        deltaZ = start
                        total = start == nil and 71 or 4585 / total
                    else
                        rootPart, button, total, _ = identifier, "BasePart", total + -79, identifier.IsA
                    end
                elseif total > 166 then
                    if total <= 167 then
                        start, identifier = nearestDistance(deltaY, deltaZ)
                        deltaZ = start
                        total = start == nil and 243 - total or 220 or 220
                    else
                        nearestDistance, deltaY, deltaZ = nearestDistance(triangle.d(deltaY))
                        nearestDistance, deltaY, deltaZ = triangle.b(nearestDistance, deltaY, deltaZ)
                        start, identifier = nearestDistance(deltaY, deltaZ)
                        deltaZ = start
                        total = start == nil and 76 or 38280 / total
                    end
                elseif total <= 162 then
                    if total >= 161 then
                        if total <= 161 then
                            _ = chunk.links
                            label = {}
                            rootPart = #chunk.links + 1
                            label[1], total, label[2] = identifier.Parent, 328 - total, identifier
                            button = label
                            _[rootPart] = label
                        else
                            button = chunk.actor
                            total = 40
                            rootPart = button.RootPart
                            _ = identifier ~= rootPart
                        end
                    else
                        button = #chunk.parts
                        rootPart = button + 1
                        chunk.parts[rootPart] = identifier
                        total = 37
                        _ = true
                        humanoidRootPart[identifier] = true
                    end
                else
                    total = _ and total + -5 or 333 - total
                end
            until false
        end
    end,
    fa = function(amount, gameProcessed)
        return function(fileHandle)
            local label = 250
            local identifier, offset, rootPart, deltaY
            while true do
                if label > 158 then
                    offset = 92
                    identifier = 118
                    gameProcessed[1][3].ambient.enabled = fileHandle
                    label = not fileHandle and 158 or 1 or 1
                elseif label <= 1 then
                    return
                else
                    deltaY = gameProcessed[3][3]
                    rootPart = gameProcessed[2][3]
                    rootPart.Ambient = deltaY.Ambient
                    rootPart.OutdoorAmbient = deltaY.OutdoorAmbient
                    label = offset < identifier and 1 or 158 or 158
                end
            end
        end
    end,
    ja = function(amount)
        return function(targetPlayer, yCoordinate)
            targetPlayer = {[1] = 3, [3] = targetPlayer}
            targetPlayer[2] = targetPlayer
            yCoordinate = {[1] = 3, [3] = yCoordinate}
            yCoordinate[2] = yCoordinate
            return amount:Hc({targetPlayer, yCoordinate})
        end
    end,
    i = function(amount, gameProcessed)
        return function(targetPlayer)
            local label = 183
            local humanoid, rootPart
            while true do
                if label <= 223 then
                    if label > 183 then
                        label = 239
                        humanoid = 2
                    else
                        rootPart = gameProcessed[1][3].sharedSettings
                        humanoid = gameProcessed[2][3][targetPlayer]
                        label = humanoid and 239 or 223 or 223
                    end
                else
                    rootPart.textFont = humanoid
                    return
                end
            end
        end
    end,
    Ad = function(entity, amount, duration, targetPlayer)
        entity.yd[targetPlayer] = entity.a(amount, 38406) / entity.a(duration, 12867)
        return entity.yd[targetPlayer]
    end,
    Hc = function(amount, gameProcessed)
        return function(targetPlayer, yCoordinate)
            local label = 36
            local humanoid, deltaY
            while true do
                if label > 117 then
                    if label <= 169 then
                        label = 197
                        deltaY = gameProcessed[1][3]
                        humanoid = deltaY[gameProcessed[2][3]]
                        humanoid[2] = yCoordinate
                    end
                elseif label < 104 then
                    if label <= 22 then
                        deltaY = gameProcessed[1][3]
                        deltaY[gameProcessed[2][3]][1] = targetPlayer
                        humanoid = nil
                        label = yCoordinate ~= nil and 169 or 197 or 197
                    else
                        humanoid = type
                        label = 104
                        deltaY = gameProcessed[1][3][gameProcessed[2][3]]
                    end
                elseif label <= 104 then
                    humanoid = humanoid(deltaY)
                    deltaY = "table"
                    label = humanoid == "table" and label + -82 or 12168 / label
                else
                    humanoid = gameProcessed[1][3]
                    deltaY = gameProcessed[2][3]
                    label, humanoid[deltaY] = label + 80, targetPlayer
                end
            end
        end
    end,
    n = function(triangle, gameProcessed)
        return function(columnIndex, value)
            local progress = 241
            local _, humanoid, Lighting, start, total, identifier, button, textLabel, label, bestDistance, nearestDistance, i, index, line, ok, heap, attachment, top, Scheduler, point, deltaZ, deltaY, offset
            repeat
                if progress >= 134 then
                    if progress < 199 then
                        if progress >= 161 then
                            if progress <= 174 then
                                if progress >= 172 then
                                    if progress > 172 then
                                        identifier(_, i, button)
                                        i = "Frame"
                                        button = {}
                                        identifier = gameProcessed[1][3]
                                        button.Name = "SubtabDivider"
                                        button.BackgroundColor3 = identifier.OutlineColor
                                        button.BorderSizePixel = 0
                                        progress, textLabel, label, point = 44022 / progress, 33, UDim2.fromOffset, 7
                                    else
                                        _ = {[1] = 3, [3] = _}
                                        progress, _[2] = 95, _
                                        button, i, _[3] = value[3], ipairs, triangle:Fb({value, nearestDistance, gameProcessed[1],})
                                    end
                                else
                                    progress, i = 134, triangle.c(i(button))
                                end
                            elseif progress > 176 then
                                button, progress, i = value[3][1], 234 - progress, _[3]
                            else
                                progress, attachment = 352 / progress, attachment(bestDistance, offset, index)
                                textLabel[3].Button = attachment
                                attachment = gameProcessed[1][3]
                                index = {}
                                offset = textLabel[3].Button
                                index.BackgroundColor3 = "BackgroundColor"
                                line = "FontColor"
                                index.TextColor3 = "FontColor"
                                attachment, bestDistance = attachment.AddToRegistry, attachment
                            end
                        elseif progress < 142 then
                            if progress > 134 then
                                label, point = _(i, button)
                                button = label
                                progress = label == nil and 23908 / progress or 111 or 111
                            else
                                _, i, button = _(triangle.d(i))
                                _, i, button = triangle.b(_, i, button)
                                label, point = _(i, button)
                                button = label
                                progress = label == nil and 306 - progress or 111 or 111
                            end
                        elseif progress > 153 then
                            textLabel = {[1] = 3, [3] = textLabel}
                            textLabel[2] = textLabel
                            attachment = gameProcessed[1][3]
                            offset = "TextButton"
                            index = {}
                            progress, index.Text = 31200 / progress, textLabel[3].Name
                            index.Font = attachment.Font
                            index.TextSize = 14
                            index.AutoButtonColor = false
                            index.BackgroundColor3 = attachment.BackgroundColor
                            index.TextColor3 = attachment.FontColor
                            index.BorderSizePixel = 0
                            line = UDim2.fromOffset
                            Scheduler = math.max
                            humanoid = attachment
                            top = textLabel[3].Name
                            total = 80
                            start, ok, Lighting, humanoid = humanoid, attachment.Font, 14, humanoid.GetTextBounds
                        elseif progress > 142 then
                            progress = progress + -71
                            attachment(bestDistance, triangle.d(offset))
                            attachment = gameProcessed[1][3]
                            index = textLabel[3].Button
                            line = triangle:Hb({gameProcessed[1], _, textLabel,})
                            offset = index.MouseButton1Click
                            index, offset = offset, offset.Connect
                        else
                            attachment(bestDistance, offset, index)
                            attachment = gameProcessed[1][3]
                            index = textLabel[3].Button
                            line = triangle:Eb({textLabel})
                            offset = index.MouseEnter
                            progress, index, offset = 61, offset, offset.Connect
                        end
                    elseif progress >= 231 then
                        if progress >= 250 then
                            if progress >= 251 then
                                if progress > 251 then
                                    button.Position = label(point, textLabel)
                                    progress, point = progress + -169, UDim2
                                    label, attachment, point, textLabel = point.new, 0, 1, -14
                                    bestDistance = 1
                                else
                                    _(i, button, label)
                                    progress = 161
                                    _ = ipairs
                                    button = deltaZ
                                    i = deltaZ.GetChildren
                                end
                            else
                                heap = heap(identifier, _, i)
                                button = {}
                                identifier = gameProcessed[1][3]
                                i = "UIListLayout"
                                progress = 120
                                button.FillDirection = Enum.FillDirection.Horizontal
                                button.SortOrder = Enum.SortOrder.LayoutOrder
                                textLabel = 6
                                point = 0
                                label = UDim.new
                            end
                        elseif progress <= 236 then
                            if progress > 231 then
                                identifier = identifier(_, i, button)
                                label = {}
                                button = identifier
                                _ = gameProcessed[1][3]
                                point = "OutlineColor"
                                progress, label.BackgroundColor3 = 59236 / progress, "OutlineColor"
                                _, i = _.AddToRegistry, _
                            else
                                deltaY = deltaY(deltaZ)
                                deltaZ = deltaY.Parent.Parent
                                i = {}
                                heap = gameProcessed[1][3]
                                _ = "Frame"
                                progress, button = progress + -192, columnIndex .. "Subtabs"
                                i.Name = button
                                i.BackgroundTransparency = 1
                                point = 4
                                label = 7
                                button = UDim2.fromOffset
                            end
                        else
                            value = {[1] = 3, [3] = value}
                            value[2] = value
                            nearestDistance = {[1] = 3, [3] = nearestDistance}
                            nearestDistance[2] = nearestDistance
                            progress, nearestDistance[3] = 231, triangle:Ib()
                            heap = value[3][1]
                            deltaY = nearestDistance[3]
                            deltaZ = heap.Groups[1]
                        end
                    elseif progress <= 203 then
                        if progress > 200 then
                            offset = triangle.c(offset(index, line))
                            attachment, progress, bestDistance = attachment.GiveSignal, 31059 / progress, attachment
                        elseif progress > 199 then
                            humanoid = humanoid(start, top, ok, Lighting)
                            start = 20
                            progress, humanoid = 0, humanoid + 20
                        else
                            attachment = attachment(bestDistance, offset, index)
                            textLabel[3].Indicator = attachment
                            index = {}
                            line = "AccentColor"
                            offset = textLabel[3].Indicator
                            attachment = gameProcessed[1][3]
                            index.BackgroundColor3 = "AccentColor"
                            progress, attachment, bestDistance = progress + -57, attachment.AddToRegistry, attachment
                        end
                    elseif progress <= 214 then
                        index.Size = line(Scheduler, total, humanoid, start)
                        index.Visible = false
                        index.ZIndex = 5
                        line = textLabel[3].Button
                        index.Parent = line
                        progress, bestDistance, attachment = progress + -15, attachment, attachment.Create
                    else
                        attachment(bestDistance, triangle.d(offset))
                        attachment, progress, index = gameProcessed[1][3], 425 - progress, textLabel[3].Button
                        line = triangle:Gb({textLabel})
                        offset = index.MouseLeave
                        index, offset = offset, offset.Connect
                    end
                elseif progress <= 82 then
                    if progress >= 39 then
                        if progress >= 61 then
                            if progress >= 67 then
                                if progress <= 67 then
                                    bestDistance = bestDistance(offset, index)
                                    progress = 139
                                    textLabel = attachment - bestDistance
                                    point.Size = textLabel
                                else
                                    progress, offset = 106, triangle.c(offset(index, line))
                                    attachment, bestDistance = attachment.GiveSignal, attachment
                                end
                            else
                                progress, offset = 222, triangle.c(offset(index, line))
                                bestDistance, attachment = attachment, attachment.GiveSignal
                            end
                        elseif progress > 45 then
                            index.Size = line(Scheduler, total)
                            index.LayoutOrder = point
                            line = 4
                            index.ZIndex = 4
                            progress, index.Parent = progress + 122, heap
                            bestDistance, attachment = attachment, attachment.Create
                        elseif progress <= 39 then
                            progress, button = 1755 / progress, button(label, point)
                            i.Position = button
                            textLabel = 0
                            button = UDim2.new
                            label = 1
                            point = -14
                            attachment = 30
                        else
                            i.Size = button(label, point, textLabel, attachment)
                            button = 3
                            i.ZIndex = 3
                            progress, i.Parent = 250, deltaZ
                            identifier, heap = heap, heap.Create
                        end
                    elseif progress <= 3 then
                        if progress < 2 then
                            Scheduler = Scheduler(total, humanoid)
                            progress, total = progress + 54, 30
                        elseif progress <= 2 then
                            attachment(bestDistance, offset, index)
                            offset = "Frame"
                            attachment = gameProcessed[1][3]
                            index = {
                                Name = "ActiveIndicator", BackgroundColor3 = attachment.AccentColor,
                                BorderSizePixel = 0,
                            }
                            progress, Scheduler = progress + 1, Vector2
                            total, line, Scheduler = 1, Scheduler.new, 0
                        else
                            progress, index.AnchorPoint = 327 / progress, line(Scheduler, total)
                            total = 1
                            line = UDim2.fromScale
                            Scheduler = 0
                        end
                    elseif progress <= 13 then
                        point, textLabel = i(button, label)
                        label = point
                        progress = point == nil and progress + 183 or progress + 143
                    else
                        i(button)
                        return
                    end
                elseif progress >= 109 then
                    if progress <= 120 then
                        if progress >= 111 then
                            if progress <= 111 then
                                progress, attachment, textLabel, bestDistance = 237 - progress, point, point.IsA, "ScrollingFrame"
                            else
                                label = label(point, textLabel)
                                progress, button.Padding = 20880 / progress, label
                                button.Parent = heap
                                identifier, _ = identifier.Create, identifier
                            end
                        else
                            index.Position = line(Scheduler, total)
                            progress, Scheduler = 23326 / progress, UDim2
                            Scheduler, total, line = 1, 0, Scheduler.new
                            humanoid = 0
                            start = 2
                        end
                    elseif progress <= 126 then
                        textLabel = textLabel(attachment, bestDistance)
                        progress = textLabel and 127 or 139 or 139
                    else
                        attachment = point.Position
                        index = 36
                        progress = 104
                        offset = 0
                        bestDistance = UDim2.fromOffset
                    end
                elseif progress > 104 then
                    progress = 13
                    attachment(bestDistance, triangle.d(offset))
                elseif progress < 95 then
                    button.Size = label(point, textLabel, attachment, bestDistance)
                    label = 3
                    button.ZIndex = 3
                    button.Parent = deltaZ
                    progress, identifier, _ = progress + 152, identifier.Create, identifier
                elseif progress > 95 then
                    textLabel = attachment + bestDistance(offset, index)
                    point.Position = textLabel
                    attachment, progress, offset = point.Size, 171 - progress, UDim2
                    bestDistance, index, offset = offset.fromOffset, 36, 0
                else
                    i, button, label = i(button)
                    i, button, label = triangle.b(i, button, label)
                    point, textLabel = i(button, label)
                    label = point
                    progress = point == nil and 18620 / progress or 156 or 156
                end
            until false
        end
    end,
    Tc = function(amount, gameProcessed)
        return function(sourceString)
            local humanoidRootPart = #sourceString % 5
            if humanoidRootPart > 0 then
                sourceString = sourceString .. ("~"):rep(5 - humanoidRootPart)
            end
            local coroutineHandle = amount:Uc({gameProcessed[2], gameProcessed[4], gameProcessed[3],})
            local humanoid = gameProcessed[1][3](sourceString, ".....", coroutineHandle)
            local deltaY
            deltaY, humanoid = humanoid, humanoid.sub
            humanoid = table.pack(humanoid(deltaY, 1, humanoidRootPart > 0 and -(5 - humanoidRootPart) - 1 or -1))
            return table.unpack(humanoid, 1, humanoid.n)
        end
    end,
    Fb = function(triangle, gameProcessed)
        return function(stack)
            local total = 222
            local point, textLabel, humanoid, nearestDistance, label, rootPart, line, identifier, start, button, deltaY, humanoidRootPart, deltaZ, _
            while true do
                if total <= 152 then
                    if total > 113 then
                        if total < 138 then
                            if total > 122 then
                                humanoidRootPart, nearestDistance, deltaY = humanoidRootPart(nearestDistance)
                                humanoidRootPart, nearestDistance, deltaY = triangle.b(humanoidRootPart, nearestDistance, deltaY)
                                deltaZ, start = humanoidRootPart(nearestDistance, deltaY)
                                deltaY = deltaZ
                                total = deltaZ == nil and 32562 / total or 224 or 224
                            elseif total > 121 then
                                rootPart = 0.3
                                total = line >= 0.3 and 51 or 260 - total
                            else
                                total = 57
                                rootPart = "FontColor"
                            end
                        elseif total < 139 then
                            total = rootPart and 57 or total + -17
                        elseif total <= 139 then
                            label, point = _(rootPart, button)
                            button = label
                            total = label == nil and 29329 / total or 201 - total
                        else
                            deltaZ, start = humanoidRootPart(nearestDistance, deltaY)
                            deltaY = deltaZ
                            total = deltaZ == nil and 395 - total or total + 72
                        end
                    elseif total < 62 then
                        if total < 51 then
                            if total <= 31 then
                                rootPart = identifier
                                total = identifier and 192 or 4278 / total
                            else
                                total = 31
                                _ = "BackgroundColor"
                            end
                        elseif total <= 51 then
                            _.TextTransparency = rootPart
                            _ = ipairs
                            total = 240
                            rootPart = start.Groups
                        else
                            point = gameProcessed[3][3]
                            label = point[_]
                            start.Button.BackgroundColor3 = label
                            start.Button.TextColor3 = point[rootPart]
                            textLabel, point = start.Button, point.RegistryMap
                            total = 152
                            point[textLabel].Properties.BackgroundColor3 = _
                            textLabel = gameProcessed[3][3]
                            textLabel, point = start.Button, textLabel.RegistryMap
                            button = point[textLabel].Properties
                            button.TextColor3 = rootPart
                        end
                    elseif total > 112 then
                        total, rootPart = 176 - total, 1
                    elseif total <= 63 then
                        if total > 62 then
                            _.BackgroundTransparency = rootPart
                            rootPart = identifier
                            _ = start.Button
                            total = identifier and 11403 / total or 154 or 154
                        else
                            humanoid = point
                            total = 217
                            textLabel = gameProcessed[2][3]
                        end
                    else
                        total = 167
                        _ = "MainColor"
                    end
                elseif total <= 217 then
                    if total >= 181 then
                        if total > 211 then
                            total, textLabel = 139, textLabel(humanoid)
                            textLabel.Visible = identifier
                        elseif total <= 192 then
                            if total > 181 then
                                total, rootPart = 330 - total, "AccentColor"
                            else
                                total, rootPart = 335 - total, 0
                            end
                        else
                            _ = identifier
                            total = identifier and 323 - total or 167 or 167
                        end
                    elseif total >= 167 then
                        if total > 167 then
                            total = rootPart and total + -109 or 113 or 113
                        else
                            total = _ and 5177 / total or 44 or 44
                        end
                    else
                        total = rootPart and 51 or 122 or 122
                    end
                elseif total > 240 then
                    if total > 243 then
                        total = 172
                        rootPart = 0
                    end
                elseif total < 224 then
                    total = 134
                    line = 134
                    nearestDistance = gameProcessed[1][3]
                    humanoidRootPart = ipairs
                elseif total <= 224 then
                    identifier = start == stack
                    start.Active = identifier
                    start.Indicator.Visible = identifier
                    rootPart = identifier
                    _ = start.Button
                    total = identifier and 254 or 396 - total
                else
                    _, rootPart, button = _(rootPart)
                    _, rootPart, button = triangle.b(_, rootPart, button)
                    label, point = _(rootPart, button)
                    button = label
                    total = label == nil and total + -29 or 62 or 62
                end
            end
        end
    end,
    G = function(amount, gameProcessed)
        return function(fileHandle)
            local label = 70
            local rootPart, identifier
            while true do
                if label > 70 then
                    identifier = gameProcessed[3][3]
                    rootPart = gameProcessed[2][3]
                    label, rootPart.ColorShift_Top = 154 - label, identifier.ColorShift_Top
                    rootPart.ColorShift_Bottom = identifier.ColorShift_Bottom
                elseif label > 53 then
                    gameProcessed[1][3].colorShift.enabled = fileHandle
                    label = not fileHandle and 101 or 53 or 53
                else
                    return
                end
            end
        end
    end,
    Ea = function(amount, _)
        return function(payload)
            _[1][3].sharedSettings.maxDistance = payload
        end
    end,
    cb = function(triangle, args)
        return function(columnIndex, arguments, targetPosition)
            local progress = 173
            local
                hash, elapsed, MAX_ITERATIONS, entry, delta, playerId, startTime, vectorA, i, neighborX, record, right, label, onPlayerAdded, point, resourceName, Graph, smallest, count,
                status, x, line, deltaZ, direction, prefix, middle, speed, offset, angle, deltaY, currentIndex, identifier, success, Scheduler, currentTime, points, position, iteration, top, start, source, file, current, textLabel,
                endTime, _, deltaTime, rootPart, playerIdentifier, deltaX, j, serialized, sourcePlayer, length, key, button, Lighting, dummy, total, humanoidRootPart, queue, attachment, heap, main, humanoid
            repeat
                if progress > 210 then
                    if progress > 545 then
                        if progress >= 734 then
                            if progress <= 886 then
                                if progress < 804 then
                                    if progress <= 752 then
                                        if progress <= 749 then
                                            if progress <= 748 then
                                                if progress > 734 then
                                                    key, progress, deltaTime = Vector2, progress + -449, key(angle, deltaX)
                                                    angle, key, top = delta.Y, endTime, key.new
                                                else
                                                    top = top(key, angle)
                                                    progress = iteration < elapsed and progress + -726 or progress + -607
                                                end
                                            else
                                                angle = angle(deltaX)
                                                deltaX, angle, file, progress, Scheduler = angle, angle.sub, 1, 714, 6
                                            end
                                        else
                                            onPlayerAdded, offset = onPlayerAdded(offset, right)
                                            right = not offset
                                            progress = right and 253 or 842 - progress
                                        end
                                    elseif progress < 775 then
                                        progress, resourceName = progress + -551, resourceName(length)
                                        success = not resourceName
                                    elseif progress <= 775 then
                                        progress = 141
                                        key(angle, deltaX, file, Scheduler, i, record, MAX_ITERATIONS)
                                    else
                                        j(speed, middle, direction, vectorA, deltaTime, top, key, angle)
                                        progress = rootPart < key and 944 - progress or 215 or 215
                                    end
                                elseif progress <= 845 then
                                    if progress >= 832 then
                                        if progress < 839 then
                                            vectorA = "players"
                                            direction = smallest == "players"
                                            progress = direction and 273 or 1543 - progress
                                        elseif progress <= 839 then
                                            heap = heap(success)
                                            smallest = not heap
                                            progress = smallest and 947 - progress or progress + -592
                                        else
                                            top = "distance"
                                            deltaTime = columnIndex
                                            vectorA = args[13][3]
                                            deltaX, angle, progress, key = length, "%.0f studs", 450385 / progress, string.format
                                        end
                                    elseif progress <= 804 then
                                        vectorA = heap.distance
                                        progress = vectorA and progress + 41 or 1090 - progress
                                    else
                                        Scheduler = Scheduler(i, record)
                                        progress = 775
                                        MAX_ITERATIONS = dummy
                                        i = label.skeletonColor
                                        record = 1
                                    end
                                elseif progress >= 866 then
                                    if progress > 866 then
                                        progress, deltaTime = 477, deltaTime(top)
                                        vectorA, direction, deltaTime = arguments, arguments.WorldToViewportPoint, deltaTime + textLabel
                                    else
                                        progress, delta = 72744 / progress, delta(total, x)
                                        line = delta
                                    end
                                else
                                    deltaTime = startTime.Y
                                    top = 0.5
                                    progress = 144
                                    vectorA = deltaTime * 0.5
                                end
                            elseif progress < 957 then
                                if progress <= 917 then
                                    if progress <= 912 then
                                        if progress >= 906 then
                                            if progress > 906 then
                                                progress, key = 606, key(angle)
                                                angle = Vector2.new
                                                file = direction
                                                deltaX = endTime
                                            else
                                                middle = middle(direction, vectorA, deltaTime)
                                                direction = heap.healthBar
                                                progress = direction and 963 - progress or 224688 / progress
                                            end
                                        else
                                            progress, angle = 397, angle(deltaX, file)
                                            file = heap.nameOutline
                                            deltaX = heap.nameColor
                                            Scheduler = dummy
                                        end
                                    else
                                        vectorA = deltaY.Zombie
                                        progress = vectorA and progress + -736 or 324 or 324
                                    end
                                elseif progress <= 939 then
                                    if progress > 918 then
                                        x, start = x(start, endTime, j)
                                        progress, endTime = 403770 / progress, {}
                                        j, endTime, total = args[7][3], ipairs, endTime
                                    else
                                        deltaTime, top = deltaTime(top, key)
                                        deltaX = 0.05
                                        angle = direction.Z
                                        key = angle > 0.05
                                        progress = key and 162 or 0 or 0
                                    end
                                else
                                    angle = angle(deltaX, file)
                                    deltaX = heap.boxOutline
                                    progress = deltaX and progress + -323 or 984 or 984
                                end
                            elseif progress >= 984 then
                                if progress >= 1005 then
                                    if progress <= 1005 then
                                        progress = 458
                                        vectorA = 0
                                    else
                                        deltaX = deltaX(file, Scheduler, i)
                                        progress, file = 1681 - progress, 2
                                    end
                                elseif progress <= 984 then
                                    deltaX = args[12][3]
                                    file = columnIndex
                                    progress = 732
                                    Scheduler = "edge" .. direction
                                    record = angle
                                    MAX_ITERATIONS = heap.box3dColor
                                    prefix = dummy
                                    playerId = 1
                                    i = key
                                else
                                    deltaTime = "players"
                                    vectorA = smallest == "players"
                                    progress = vectorA and 137 or 1311 - progress
                                end
                            elseif progress > 960 then
                                progress, angle = 1014, angle(deltaX, file)
                                Scheduler = heap.healthyColor
                                i = middle
                                deltaX = heap.dyingColor
                                deltaX, file = deltaX.Lerp, deltaX
                            elseif progress <= 957 then
                                direction = direction(vectorA, deltaTime)
                                vectorA = heap.healthBarOutline
                                progress = vectorA and 206 or 25 or 25
                            else
                                j, speed, middle = j(speed)
                                j, speed, middle = triangle.b(j, speed, middle)
                                direction, vectorA = j(speed, middle)
                                middle = direction
                                progress = direction == nil and 67 or 191 or 191
                            end
                        elseif progress <= 648 then
                            if progress < 592 then
                                if progress < 561 then
                                    if progress <= 556 then
                                        if progress <= 550 then
                                            progress, top = 147, top(key, angle)
                                        else
                                            progress = progress + -507
                                            key(angle, deltaX, file, Scheduler, i, record, MAX_ITERATIONS)
                                        end
                                    else
                                        vectorA, top, deltaTime, deltaX, progress, key =
                                            args[13][3], "name", columnIndex, Vector2, 504218 / progress, direction
                                        deltaX, Scheduler, i, angle = endTime, line.Y, queue.textSize, deltaX.new
                                        Scheduler, file = 3, Scheduler - i
                                        file = file - 3
                                    end
                                elseif progress < 581 then
                                    if progress <= 561 then
                                        deltaY(smallest)
                                        deltaY = columnIndex.actor
                                        progress = 839
                                        success = deltaY
                                        heap = args[10][3].Refresh
                                    else
                                        line = line(delta, total)
                                        delta = line.Magnitude
                                        total = 0.0001
                                        progress = delta < 0.0001 and 123170 / progress or 101 or 101
                                    end
                                elseif progress > 581 then
                                    progress, angle = 712, angle(deltaX, file)
                                    Scheduler = dummy
                                    deltaX = heap.distanceColor
                                    file = heap.distanceOutline
                                else
                                    top = "Top"
                                    deltaTime = heap.tracerOrigin
                                    vectorA = deltaTime == "Top"
                                    progress = vectorA and 1005 or 458 or 458
                                end
                            elseif progress >= 629 then
                                if progress <= 643 then
                                    if progress <= 636 then
                                        if progress <= 629 then
                                            deltaX = args[12][3]
                                            file = columnIndex
                                            i = key
                                            record = angle
                                            MAX_ITERATIONS = heap.boxOutlineColor
                                            Scheduler = "edgeOutline" .. direction
                                            progress = 418
                                            prefix = 2 * heap.boxOutlineThickness
                                            playerId = 1 + prefix
                                        else
                                            deltaTime = heap.tracerOrigin
                                            top = "Middle"
                                            vectorA = deltaTime == "Middle"
                                            progress = vectorA and 847 or 144 or 144
                                        end
                                    else
                                        angle = angle(deltaX, file)
                                        progress = 460
                                        deltaX = args[8][3]
                                        file = 4
                                    end
                                else
                                    progress, vectorA = 638928 / progress, columnIndex.model
                                    direction = vectorA.Name
                                end
                            elseif progress > 608 then
                                progress, angle = progress + 29, angle(deltaX, file)
                                key = direction + angle
                                angle = Vector2.new
                                deltaX = line.X - 5
                                Scheduler = 1
                                file = line.Y - 1
                            elseif progress >= 606 then
                                if progress <= 606 then
                                    angle = angle(deltaX, file)
                                    file = heap.weaponOutline
                                    progress = 592
                                    deltaX = heap.weaponColor
                                    Scheduler = dummy
                                else
                                    progress = 117
                                    j(speed, middle, direction, vectorA, deltaTime, top, key, angle)
                                end
                            else
                                vectorA(deltaTime, top, key, angle, deltaX, file, Scheduler)
                                deltaTime = queue.textSize
                                top = 2
                                progress = 804
                                vectorA = deltaTime + 2
                                direction = direction + vectorA
                            end
                        elseif progress >= 688 then
                            if progress < 712 then
                                if progress <= 702 then
                                    if progress <= 688 then
                                        progress = 232
                                        vectorA = "NPC"
                                    else
                                        progress, vectorA = progress + -539, heap.weapon
                                    end
                                else
                                    progress = direction and 986 or 460728 / progress
                                end
                            elseif progress < 726 then
                                if progress > 712 then
                                    progress, angle = 559, angle(deltaX, file, Scheduler)
                                    deltaX = "]"
                                    key = angle .. "]"
                                    deltaTime = top .. key
                                    direction = vectorA .. deltaTime
                                else
                                    vectorA(deltaTime, top, key, angle, deltaX, file, Scheduler)
                                    progress = entry < hash and progress + 133 or 998 - progress
                                end
                            elseif progress <= 726 then
                                progress = 109
                                j(speed, middle, direction, vectorA, deltaTime, top, key)
                            else
                                progress = progress + -594
                                deltaX(file, Scheduler, i, record, MAX_ITERATIONS, playerId, prefix)
                            end
                        elseif progress > 665 then
                            if progress >= 672 then
                                if progress > 672 then
                                    progress = 31
                                    direction(vectorA, deltaTime, top, key, angle, deltaX)
                                else
                                    right = right(line, delta)
                                    progress = 565
                                    total = right.Z
                                    line = Vector2.new
                                    delta = right.X
                                end
                            else
                                progress = 248
                                vectorA(deltaTime, top, key, angle, deltaX, file)
                            end
                        elseif progress >= 664 then
                            if progress > 664 then
                                progress, key = 685, key(angle, deltaX)
                                angle = heap.healthTextColor
                                deltaX = heap.healthTextOutline
                            else
                                vectorA = deltaY.DisplayName
                                progress = vectorA and 274 or 241032 / progress
                            end
                        elseif progress <= 659 then
                            key, deltaX = deltaX(file, Scheduler), Vector2
                            progress, deltaX, file, angle = progress + 293, top.X, top.Y, deltaX.new
                        else
                            progress, vectorA = 115014 / progress, startTime.Y
                        end
                    elseif progress > 323 then
                        if progress <= 418 then
                            if progress <= 363 then
                                if progress <= 347 then
                                    if progress < 338 then
                                        if progress > 324 then
                                            progress = vectorA and 338 or 282 or 282
                                        else
                                            progress = vectorA and 232 or 688 or 688
                                        end
                                    elseif progress >= 341 then
                                        if progress <= 341 then
                                            vectorA = vectorA(deltaTime, top)
                                            total[middle] = vectorA
                                            top = 0.05
                                            deltaTime = vectorA.Z
                                            progress = deltaTime > 0.05 and 22 or 535 - progress
                                        else
                                            direction = delta.Y + 2
                                            deltaTime = "players"
                                            vectorA = smallest == "players"
                                            progress = vectorA and progress + 355 or 163 or 163
                                        end
                                    else
                                        progress, vectorA = progress + 221, deltaY.Owner
                                        direction = vectorA.DisplayName
                                    end
                                elseif progress < 352 then
                                    progress, j = progress + -156, j(speed, middle, direction)
                                    j.PointA = x
                                    j.PointB = start + endTime
                                    j.PointC = start - endTime
                                    j.Filled = true
                                    middle = j
                                    vectorA = dummy
                                    direction = heap.offScreenArrowColor
                                    speed = args[6][3]
                                elseif progress > 352 then
                                    deltaTime = deltaY.OwnerName
                                    top = "???"
                                    vectorA = deltaTime ~= "???"
                                    progress = vectorA and 386 or 274 or 274
                                else
                                    deltaTime = deltaTime(top, key)
                                    top = line
                                    progress = line and 77 or 499 - progress
                                end
                            elseif progress <= 394 then
                                if progress > 386 then
                                    progress = 39400 / progress
                                    start(endTime, j, speed, middle, direction)
                                elseif progress < 379 then
                                    progress, middle = progress + 126, middle(direction, vectorA)
                                    direction = 0.5
                                    speed, middle = middle * 0.5, heap.offScreenArrowSize
                                    j, speed = speed - middle, 4
                                    j = j - 4
                                elseif progress <= 379 then
                                    progress, dummy = 27, dummy(textLabel)
                                else
                                    progress, vectorA = 105764 / progress, deltaY.OwnerName
                                end
                            elseif progress > 399 then
                                progress = 984
                                deltaX(file, Scheduler, i, record, MAX_ITERATIONS, playerId)
                            elseif progress <= 397 then
                                progress = 744 - progress
                                vectorA(deltaTime, top, key, angle, deltaX, file, Scheduler)
                            else
                                length = length(queue)
                                queue = "Vector3"
                                progress = length ~= "Vector3" and 13566 / progress or progress + -249
                            end
                        elseif progress < 477 then
                            if progress < 434 then
                                if progress >= 430 then
                                    if progress > 430 then
                                        progress = 189
                                        key(angle, deltaX, file, Scheduler, i, record)
                                    else
                                        endTime, j, speed = endTime(j)
                                        endTime, j, speed = triangle.b(endTime, j, speed)
                                        middle, direction = endTime(j, speed)
                                        speed = middle
                                        progress = middle == nil and 246 or 78 or 78
                                    end
                                else
                                    progress, vectorA = 749, vectorA(deltaTime)
                                    angle = tostring
                                    top = " ["
                                    deltaX = deltaY.UID
                                end
                            elseif progress <= 458 then
                                if progress > 452 then
                                    progress = vectorA and 174 or 636 or 636
                                elseif progress <= 434 then
                                    angle = columnIndex
                                    key = args[12][3]
                                    deltaX = "bone" .. speed
                                    Scheduler = direction.X
                                    file = Vector2.new
                                    progress = 520
                                    i = direction.Y
                                else
                                    direction, vectorA, progress, deltaTime = j / vectorA(deltaTime, top), 0, 906, 1
                                end
                            else
                                progress = 485 - progress
                                vectorA(deltaTime, top, key, angle, deltaX, file)
                            end
                        elseif progress < 514 then
                            if progress <= 492 then
                                if progress <= 477 then
                                    progress = 980 - progress
                                    direction, vectorA = direction(vectorA, deltaTime)
                                    angle = middle[2]
                                    key = args[11][3]
                                else
                                    progress, start = 285, triangle.c(start(endTime, j))
                                end
                            else
                                key, top, progress, deltaTime = key(angle) + textLabel, arguments, 918, arguments.WorldToViewportPoint
                            end
                        elseif progress < 533 then
                            if progress > 514 then
                                file = file(Scheduler, i)
                                Scheduler = Vector2.new
                                record = deltaTime.Y
                                progress = 827
                                i = deltaTime.X
                            else
                                top, vectorA, deltaTime, progress, angle = "weapon", args[13][3], columnIndex, 468768 / progress, args[10][3]
                                key, angle = angle.Weapon, deltaY
                            end
                        elseif progress <= 533 then
                            progress, key = 582, key(angle, deltaX)
                            angle = Vector2.new
                            file = direction
                            deltaX = endTime
                        else
                            key = top
                            progress = main <= sourcePlayer and 176 or progress + -404
                        end
                    elseif progress <= 246 then
                        if progress < 231 then
                            if progress > 220 then
                                if progress > 226 then
                                    progress = right and 127 or 359 - progress
                                elseif progress <= 225 then
                                    progress = success and 35 or 167 or 167
                                else
                                    progress, length = 289 - progress, deltaY.Owner
                                    queue = args[5][3]
                                    resourceName = length.Team
                                    length = queue.Team
                                    success = resourceName == length
                                end
                            elseif progress < 218 then
                                if progress > 213 then
                                    j = heap.box
                                    progress = j and 112 or 25155 / progress
                                else
                                    progress = 172
                                    resourceName = success.Position
                                end
                            elseif progress < 219 then
                                x, total, progress, delta = 1, 0, 188788 / progress, Vector2.new
                            elseif progress > 219 then
                                endTime = 0
                                progress = 89
                                start = delta.Y
                                x = start >= 0
                            else
                                progress = 71
                                vectorA = middle[2]
                                direction = vectorA.Parent
                            end
                        elseif progress >= 239 then
                            if progress < 244 then
                                if progress <= 239 then
                                    progress = 351
                                    speed, j = 0.5, speed(middle, direction) * heap.offScreenArrowSize
                                    j, direction, endTime, speed, middle = args[3][3], "Triangle", j * 0.5, columnIndex, "arrow"
                                else
                                    right = heap.box
                                    progress = right and 20 or 120 or 120
                                end
                            elseif progress > 244 then
                                x = line
                                progress = line and 259 - progress or 192 or 192
                            else
                                speed = columnIndex
                                deltaTime = heap.boxOutlineColor
                                direction = line
                                top = false
                                vectorA = start
                                middle = "boxOutline"
                                deltaX = 2
                                j = args[4][3]
                                file = heap.boxOutlineThickness
                                progress = 726
                                angle = 2 * file
                                key = 1 + angle
                            end
                        elseif progress < 233 then
                            if progress > 231 then
                                progress, direction, vectorA = 97672 / progress, vectorA, tostring
                                deltaTime = direction
                            else
                                return
                            end
                        elseif progress <= 233 then
                            progress = success and progress + -2 or 74 or 74
                        else
                            start = x
                            progress = points >= serialized and progress + -94 or 42 or 42
                        end
                    elseif progress < 274 then
                        if progress < 252 then
                            if progress <= 248 then
                                if progress > 247 then
                                    direction = heap.healthText
                                    progress = direction and 313 - progress or 279 - progress
                                else
                                    progress, heap = 79781 / progress, args[10][3]
                                    heap, smallest = deltaY, heap.Kind
                                end
                            else
                                progress = textLabel and 69 or 83 or 83
                            end
                        elseif progress >= 255 then
                            if progress > 255 then
                                vectorA = deltaY.Owner
                                direction = vectorA.Name
                                progress = count >= Lighting and 711 or 105 or 105
                            else
                                progress, right = 13260 / progress, heap.boxFill
                            end
                        elseif progress > 252 then
                            progress = 90
                            right = heap.offScreenArrow
                        else
                            speed = args[2][3]
                            progress = 960
                            j = ipairs
                        end
                    elseif progress <= 286 then
                        if progress > 285 then
                            vectorA = heap.tracer
                            progress = vectorA and 867 - progress or 335 - progress
                        elseif progress <= 282 then
                            if progress > 274 then
                                vectorA = label.nameType
                                deltaTime = "Display Name"
                                progress = vectorA == "Display Name" and 946 - progress or progress + 277
                            else
                                progress = vectorA and 232 or 917 or 917
                            end
                        else
                            total = total(x, triangle.d(start))
                            progress, start = 524 - progress, line * total
                            j = heap.offScreenArrowSize
                            x = delta + start
                            endTime = line * j
                            start = x - endTime
                            direction = line.Y
                            speed = Vector2.new
                            direction, middle = line.X, -direction
                        end
                    elseif progress >= 306 then
                        if progress > 306 then
                            smallest = smallest(heap)
                            heap = not smallest
                            progress = heap and 14212 / progress or 12 or 12
                        else
                            start, endTime, j = start(endTime)
                            start, endTime, j = triangle.b(start, endTime, j)
                            speed, middle = start(endTime, j)
                            j = speed
                            progress = speed == nil and 193 or 42840 / progress
                        end
                    else
                        top = top(key, angle)
                        key = heap.tracerOutline
                        progress = key and progress + -114 or 189 or 189
                    end
                elseif progress >= 108 then
                    if progress < 156 then
                        if progress >= 133 then
                            if progress > 144 then
                                if progress > 150 then
                                    if progress >= 152 then
                                        if progress <= 152 then
                                            resourceName = deltaY.Alive
                                            length = false
                                            success = resourceName == false
                                            progress = position < humanoidRootPart and progress + -3 or 36784 / progress
                                        else
                                            length = 0
                                            progress, success = progress + 79, resourceName <= 0
                                        end
                                    else
                                        progress = 194
                                        delta = top
                                    end
                                elseif progress >= 149 then
                                    if progress > 149 then
                                        length = (resourceName - targetPosition).Magnitude
                                        queue = args[10][3].sharedSettings
                                        label = queue.limitDistance
                                        progress = label and 310 - progress or 336 - progress
                                    else
                                        progress = success and progress + 84 or progress + -13
                                    end
                                elseif progress > 145 then
                                    progress = top and progress + 9 or 11 or 11
                                else
                                    top = top(key)
                                    key = Vector2.new
                                    angle = line.X - 20
                                    file = delta.Y
                                    Scheduler = start.Y * middle
                                    i, Scheduler, progress, deltaX = 0.5, queue.textSize, 810 - progress, file - Scheduler
                                    file = Scheduler * 0.5
                                    deltaX = deltaX - file
                                end
                            elseif progress <= 140 then
                                if progress >= 137 then
                                    if progress > 138 then
                                        vectorA = middle[1]
                                        direction = vectorA.Parent
                                        progress = direction and progress + 79 or 71 or 71
                                    elseif progress <= 137 then
                                        top = "Display Name"
                                        deltaTime = label.nameType
                                        vectorA = deltaTime == "Display Name"
                                        progress = identifier >= source and progress + 499 or progress + 188
                                    else
                                        direction, vectorA = j(speed, middle)
                                        middle = direction
                                        progress = direction == nil and 9246 / progress or 329 - progress
                                    end
                                elseif progress > 133 then
                                    resourceName = deltaY.Health
                                    progress = resourceName and 154 or 116 or 116
                                else
                                    start = offset
                                    progress = offset and progress + -91 or 236 or 236
                                end
                            elseif progress > 142 then
                                progress = vectorA and 174 or progress + 517
                            elseif progress <= 141 then
                                speed, middle = start(endTime, j)
                                j = speed
                                progress = speed == nil and 193 or 281 - progress
                            else
                                x = args[9][3]
                                progress = 939
                                start = columnIndex
                                endTime = textLabel
                                j = resourceName
                            end
                        elseif progress < 117 then
                            if progress <= 111 then
                                if progress >= 110 then
                                    if progress <= 110 then
                                        right = heap.healthBar
                                        progress = currentIndex > _ and 195 - progress or 12100 / progress
                                    else
                                        angle = top.Z
                                        deltaX = 0.05
                                        progress = 128
                                        key = angle > 0.05
                                    end
                                elseif progress > 108 then
                                    direction = line
                                    key = 1
                                    speed = columnIndex
                                    progress = 608
                                    angle = dummy
                                    middle = "box"
                                    vectorA = start
                                    j = args[4][3]
                                    deltaTime = heap.boxColor
                                    top = false
                                else
                                    return
                                end
                            elseif progress > 113 then
                                resourceName = 0
                                progress = current >= 0 and 17864 / progress or 232 - progress
                            elseif progress > 112 then
                                progress = x and 333 - progress or 89 or 89
                            else
                                j = heap.boxOutline
                                progress = j and 244 or 12208 / progress
                            end
                        elseif progress >= 127 then
                            if progress <= 129 then
                                if progress >= 128 then
                                    if progress <= 128 then
                                        progress = key and 104 or progress + 10
                                    else
                                        right = heap.tracer
                                        progress = neighborX >= status and 20 or 127 or 127
                                    end
                                else
                                    delta = nil
                                    line = nil
                                    total = nil
                                    progress = right and 18034 / progress or 246 or 246
                                end
                            else
                                progress = x and 7260 / progress or 133 or 133
                            end
                        elseif progress >= 120 then
                            if progress > 120 then
                                right = heap.weapon
                                progress = playerIdentifier < deltaZ and 55 or progress + -84
                            else
                                right = heap.box3d
                                progress = Graph <= button and progress + -49 or 20 or 20
                            end
                        elseif progress <= 117 then
                            j = heap.box3d
                            progress = j and progress + 135 or 67 or 67
                        else
                            progress = 379
                            dummy = args[10][3].TeamColor
                            textLabel = deltaY
                        end
                    elseif progress >= 183 then
                        if progress < 193 then
                            if progress <= 189 then
                                if progress > 186 then
                                    file = deltaTime
                                    progress = 556
                                    key = args[12][3]
                                    angle = columnIndex
                                    i = heap.tracerColor
                                    MAX_ITERATIONS = dummy
                                    record = 1
                                    Scheduler = top
                                    deltaX = "tracer"
                                elseif progress <= 185 then
                                    if progress > 183 then
                                        i, key, record, progress, angle, file, deltaX, Scheduler =
                                            args[8][3], args[12][3], 3, 618 - progress, columnIndex, deltaTime, "tracerOutline", top
                                    else
                                        progress, success = 215 - progress, heap.teamCheck
                                    end
                                else
                                    progress = label and progress + -140 or progress + -165
                                end
                            elseif progress > 191 then
                                progress = x and 382 - progress or 21696 / progress
                            elseif progress <= 190 then
                                progress = 113
                                start = delta.X
                                endTime = 0
                                x = start >= 0
                            else
                                key = vectorA[1]
                                key, deltaTime = vectorA[2], total[key]
                                angle = deltaTime.Z
                                deltaX = 0.05
                                top = total[key]
                                key = angle > 0.05
                                progress = key and 111 or 128 or 128
                            end
                        elseif progress >= 201 then
                            if progress <= 206 then
                                if progress <= 205 then
                                    if progress <= 201 then
                                        endTime, j, middle, speed, progress, direction, start =
                                            columnIndex, arguments, resourceName, textLabel, 79194 / progress, dummy, args[14][3]
                                    else
                                        progress = success and 225 or progress + -154
                                    end
                                else
                                    progress = 614
                                    vectorA = args[12][3]
                                    deltaTime = columnIndex
                                    top = "hpOutline"
                                    deltaX = 0
                                    file = 1
                                    angle = Vector2.new
                                end
                            else
                                progress = right and 85 or 23100 / progress
                            end
                        elseif progress < 195 then
                            if progress > 193 then
                                middle, direction = endTime(j, speed)
                                speed = middle
                                progress = middle == nil and 246 or 78 or 78
                            else
                                return
                            end
                        elseif progress > 195 then
                            main = 97
                            sourcePlayer = 154
                            progress = right and 236 - progress or 123 or 123
                        else
                            progress = 287 - progress
                            speed(middle, direction, vectorA)
                        end
                    elseif progress <= 167 then
                        if progress > 162 then
                            if progress > 164 then
                                length = columnIndex.model
                                resourceName = length.Parent
                                progress = 35
                                success = not resourceName
                            elseif progress > 163 then
                                right = heap.healthText
                                progress = attachment >= point and 226 or 230 or 230
                            else
                                progress = vectorA and progress + 351 or 967 - progress
                            end
                        elseif progress <= 159 then
                            if progress >= 158 then
                                if progress > 158 then
                                    key, middle, direction, j, vectorA, speed, deltaTime, progress, angle, top =
                                        1, "fill", line, args[4][3], start, columnIndex, heap.boxFillColor, 956 - progress, dummy,
                                        true
                                else
                                    return
                                end
                            else
                                line, top = top, delta
                                progress = top and 180 or 8 or 8
                            end
                        elseif progress <= 160 then
                            dummy = queue.maxDistance
                            progress, label = progress + 26, length > dummy
                        else
                            progress, deltaX, angle = progress + -162, 0.05, deltaTime.Z
                            key = angle > 0.05
                        end
                    elseif progress > 176 then
                        if progress < 180 then
                            key = vectorA
                            progress = vectorA and progress + -1 or progress + 368
                        elseif progress > 180 then
                            progress, vectorA = 58644 / progress, "Zombie"
                        else
                            angle, key, progress, top = deltaTime, delta, 132120 / progress, delta.Max
                        end
                    elseif progress >= 174 then
                        if progress <= 174 then
                            progress = 748
                            file = 0.5
                            key = Vector2.new
                            angle = startTime.X * 0.5
                            deltaX = vectorA
                        else
                            progress = key and 434 or progress + -35
                        end
                    elseif progress > 172 then
                        deltaY = args[1][3]
                        progress = 561
                        smallest = columnIndex
                    else
                        progress = 399
                        queue = resourceName
                        length = typeof
                    end
                elseif progress < 52 then
                    if progress >= 29 then
                        if progress >= 42 then
                            if progress > 48 then
                                if progress >= 50 then
                                    if progress > 50 then
                                        resourceName, progress, length = deltaY.Character, 276 - progress, columnIndex.model
                                        success = resourceName ~= length
                                    else
                                        middle = delta.X
                                        start = delta - line
                                        speed = 0.5
                                        j = line.X + middle
                                        j, endTime = heap.boxFill, j * 0.5
                                        progress = j and progress + 109 or 265 - progress
                                    end
                                else
                                    start = label.skeleton
                                    progress = start and 98 or 193 or 193
                                end
                            elseif progress > 44 then
                                if progress > 46 then
                                    _ = 44
                                    currentIndex = 54
                                    progress = success and 226 or 63 or 63
                                end
                            elseif progress <= 43 then
                                if progress <= 42 then
                                    progress = start and 243 - progress or 100 or 100
                                else
                                    return
                                end
                            else
                                return
                            end
                        elseif progress >= 34 then
                            if progress <= 36 then
                                if progress <= 35 then
                                    if progress > 34 then
                                        progress = success and 5215 / progress or 5320 / progress
                                    end
                                else
                                    progress, length, resourceName = progress + 720, deltaY, args[10][3].Kind
                                end
                            else
                                progress = right and 210 or 5 or 5
                            end
                        elseif progress > 31 then
                            point = 237
                            position = 89
                            attachment = 137
                            status = 159
                            humanoidRootPart = 232
                            neighborX = 36
                            progress = success and 2592 / progress or 80 - progress
                        elseif progress > 29 then
                            direction = heap.name
                            progress = direction and progress + 801 or 378 - progress
                        else
                            right, progress, delta = arguments.CFrame, progress + 643, resourceName
                            line, right = right, right.PointToObjectSpace
                        end
                    elseif progress < 20 then
                        if progress > 11 then
                            if progress >= 13 then
                                if progress <= 13 then
                                    progress = 192
                                    x = delta
                                else
                                    progress, dummy = progress + 55, nil
                                end
                            else
                                playerIdentifier = 171
                                deltaZ = 141
                                current = 214
                                heap = args[10][3].teamSettings[smallest]
                                resourceName = "players"
                                success = smallest == "players"
                                progress = success and 195 - progress or progress + 20
                            end
                        elseif progress <= 8 then
                            if progress <= 5 then
                                if progress > 0 then
                                    progress, right = 215 - progress, heap.distance
                                else
                                    progress = key and progress + 177 or 176 - progress
                                end
                            else
                                progress = top and 151 or progress + 94
                            end
                        else
                            progress, top = 1716 / progress, deltaTime
                        end
                    elseif progress >= 24 then
                        if progress >= 26 then
                            if progress > 26 then
                                progress = dummy and 70 or 15 or 15
                            else
                                progress = 197
                                right = heap.name
                            end
                        elseif progress > 24 then
                            vectorA = args[12][3]
                            top = "hp"
                            deltaTime = columnIndex
                            key = direction
                            progress, file, Scheduler, angle = 999 - progress, line.X, 5, Vector2.new
                            deltaX, file, i = file - 5, delta.Y, start.Y
                            Scheduler = i * middle
                            file = file - Scheduler
                        else
                            progress = 886
                            deltaTime = args[11][3]
                            top = middle[1]
                        end
                    elseif progress <= 21 then
                        if progress <= 20 then
                            serialized = 224
                            points = 53
                            progress = right and 1040 / progress or 275 - progress
                        else
                            textLabel = args[10][3]
                            dummy = textLabel.advanced
                            dummy, label = queue.teamBasedColor, dummy[smallest]
                            progress = dummy and 2499 / progress or 48 - progress
                        end
                    else
                        progress, deltaTime, key, top = 7744 / progress, Vector2.new, vectorA.Y, vectorA.X
                    end
                elseif progress >= 81 then
                    if progress < 92 then
                        if progress <= 85 then
                            if progress < 84 then
                                if progress > 81 then
                                    startTime = Vector3
                                    progress = 69
                                    textLabel = Vector3.zero
                                else
                                    resourceName = args[5][3].Team
                                    length = nil
                                    progress, success = 3888 / progress, resourceName ~= nil
                                end
                            elseif progress > 84 then
                                humanoid = 1
                                currentTime = 242
                                progress = right and 230 or progress + 79
                            else
                                delta = startTime * 0.5
                                x = heap.offScreenArrowRadius
                                total = math.min
                                start = math.max
                                endTime = 0
                                middle, progress, vectorA, direction = math.min, progress + 282, startTime.Y, startTime.X
                            end
                        elseif progress <= 90 then
                            if progress <= 89 then
                                progress = x and 91 or 221 - progress
                            else
                                iteration = 85
                                elapsed = 230
                                progress = right and 29 or 8280 / progress
                            end
                        else
                            endTime, progress, start = startTime.X, 223 - progress, line.X
                            x = start <= endTime
                        end
                    elseif progress > 101 then
                        if progress >= 104 then
                            if progress > 104 then
                                source = 147
                                identifier = 64
                                direction = math
                                middle = math.clamp
                                progress = 452
                                top = speed
                                deltaTime = 1
                                vectorA = math.max
                            else
                                Scheduler = deltaTime.Y
                                progress = 659
                                file = deltaTime.X
                                deltaX = Vector2.new
                            end
                        else
                            progress, top = 253 - progress, deltaTime
                        end
                    elseif progress <= 99 then
                        if progress > 98 then
                            entry = 117
                            resourceName = heap.enabled
                            hash = 21
                            success = not resourceName
                            progress = success and 20295 / progress or 135 - progress
                        elseif progress > 92 then
                            progress = 306
                            start = ipairs
                            endTime = columnIndex.links
                        else
                            line = 0.05
                            right = onPlayerAdded.Z
                            progress = right <= 0.05 and 43 or progress + 150
                        end
                    elseif progress > 100 then
                        progress, line = 84, line.Unit
                    else
                        progress = x and 5000 / progress or 49 or 49
                    end
                elseif progress <= 67 then
                    if progress >= 57 then
                        if progress <= 65 then
                            if progress >= 63 then
                                if progress > 63 then
                                    direction = args[13][3]
                                    deltaTime = "hpText"
                                    vectorA = columnIndex
                                    progress = 145
                                    top = math.ceil
                                    key = j
                                else
                                    progress = success and 158 or 6237 / progress
                                end
                            else
                                direction = Vector2.new
                                top = 5
                                progress = 957
                                vectorA = line.X - 5
                                deltaTime = delta.Y
                            end
                        else
                            j = deltaY.Health
                            speed = deltaY.MaxHealth
                            progress = speed and progress + 38 or progress + -11
                        end
                    elseif progress <= 55 then
                        if progress >= 53 then
                            if progress > 53 then
                                endTime = startTime.Y
                                start = line.Y
                                x = start <= endTime
                                progress = humanoid >= currentTime and 122 - progress or 7315 / progress
                            else
                                resourceName = success
                                progress = success and 266 - progress or 9116 / progress
                            end
                        else
                            rootPart = 141
                            Lighting = 51
                            count = 87
                            progress = right and 197 or 26 or 26
                        end
                    else
                        progress = 105
                        speed = 100
                    end
                elseif progress > 73 then
                    if progress <= 77 then
                        if progress > 74 then
                            progress = 550
                            key = line
                            angle = deltaTime
                            top = line.Min
                        else
                            Graph = 97
                            success = deltaY.RootPart
                            resourceName = deltaY.Position
                            button = 78
                            progress = resourceName and 172 or progress + -21
                        end
                    else
                        angle = 0.5
                        key = start * 0.5
                        vectorA, progress, deltaTime, top = arguments.WorldToViewportPoint, 419 - progress, arguments, x + key * direction
                    end
                elseif progress < 71 then
                    if progress <= 69 then
                        onPlayerAdded, progress, startTime, offset, right =
                            arguments.WorldToViewportPoint, 51888 / progress, arguments.ViewportSize, arguments, resourceName
                    else
                        textLabel = success
                        progress = success and 73 or 251 or 251
                    end
                elseif progress <= 71 then
                    progress = direction and 24 or 141 or 141
                else
                    startTime = success.Position
                    progress = 251
                    textLabel = resourceName - startTime
                end
            until false
        end
    end,
    ra = function(amount, gameProcessed)
        return function(targetPlayer)
            local label = 32
            local line, _, humanoid, deltaY, rootPart
            while true do
                if label >= 102 then
                    if label > 173 then
                        if label <= 193 then
                            label, rootPart = 173, rootPart(humanoid, deltaY)
                        else
                            deltaY = "TextButton"
                            label = 193
                            rootPart = targetPlayer.IsA
                            humanoid = targetPlayer
                        end
                    elseif label >= 108 then
                        if label > 108 then
                            label = rootPart and label + -71 or 108 or 108
                        else
                            humanoid, rootPart, label, deltaY = targetPlayer, targetPlayer.IsA, 189 - label, "TextBox"
                        end
                    else
                        line = 194
                        _ = 53
                        label = rootPart and label + -52 or 9894 / label
                    end
                elseif label >= 81 then
                    if label < 96 then
                        label, rootPart = 102, rootPart(humanoid, deltaY)
                    elseif label > 96 then
                        return
                    else
                        rootPart = rootPart(humanoid, deltaY)
                        label = rootPart and 173 or 203 or 203
                    end
                elseif label > 32 then
                    humanoid = gameProcessed[1][3]
                    rootPart = humanoid.Face
                    targetPlayer.FontFace = rootPart
                    label = line > _ and 97 or 102 or 102
                else
                    rootPart = targetPlayer.IsA
                    humanoid = targetPlayer
                    label = 96
                    deltaY = "TextLabel"
                end
            end
        end
    end,
    Qc = function(amount)
        local identifier = string
        local button, rootPart
        rootPart, button, identifier = identifier.byte, identifier.char, bit32
        local ffi = identifier.bxor
        button = {[1] = 3, [3] = button}
        button[2] = button
        rootPart = {[1] = 3, [3] = rootPart}
        rootPart[2] = rootPart
        ffi = {[1] = 3, [3] = ffi}
        ffi[2] = ffi
        return amount:Rc({button, ffi, rootPart})
    end,
    f = function(triangle)
        return function(...)
            local progress = 223
            local
                points, rootPart, exampleUsage, top, total, sum, current, right, start, state, success, startTime, prefix, direction, low, screenGui, middle, point, array, matrix, priority, serialized, count, currentIndex, resourceName,
                iterator, textLabel, RunService, deltaY, iteration, elapsed, index, label, deltaTime, Graph, _, humanoid, result, playerId, deltaZ, message, high, main, sourcePlayer, humanoidRootPart, deltaX, line, i, instance,
                dummy, placeholder, hash, length, playerIdentifier, visited, position, queue, heap, currentNode, entry, identifier, frame, part, speed, neighborX, record, deepCopy, delta, ok, nearestDistance, copy, left,
                distance, player, Scheduler, attachment, Lighting, tweenInfo, MAX_ITERATIONS, x, bestDistance, character, safeCall, Players, j, angle, node, status, offset, file, data, key, currentTime, source, vectorA,
                endTime, smallest, button
            repeat
                if progress <= 222 then
                    if progress <= 123 then
                        if progress > 70 then
                            if progress > 94 then
                                if progress < 115 then
                                    if progress <= 109 then
                                        if progress < 103 then
                                            if progress > 100 then
                                                deltaX(file, Scheduler)
                                                Scheduler = {
                                                    Text = "Bullet Drop Compensation",
                                                    Flag = "sd_bullet_drop", Default = true,
                                                }
                                                i = triangle:za({middle})
                                                Scheduler.Callback = i
                                                progress = 109
                                                file = angle
                                                deltaX = angle.AddToggle
                                            else
                                                deltaTime = {[1] = 3, [3] = deltaTime(),}
                                                deltaTime[2] = deltaTime
                                                top = Enum.RaycastFilterType.Exclude
                                                deltaTime[3].FilterType = top
                                                deltaTime[3].IgnoreWater = true
                                                top = triangle:ia({node, deltaTime})
                                                direction[3].Clear = top
                                                top = triangle:P()
                                                direction[3].AimPoint = top
                                                top = triangle:J({endTime, middle, direction, data})
                                                direction[3].Select = top
                                                top = triangle:ea({direction, middle})
                                                direction[3].Direction = top
                                                top = triangle:z()
                                                progress, direction[3].FindFunction = progress + 25, top
                                                top = triangle:Va({direction})
                                                direction[3].Hook = top
                                                top = triangle:Ja({direction, middle, endTime})
                                                direction[3].Install = top
                                                top = triangle:pa({direction})
                                                direction[3].Destroy = top
                                                angle = {Title = "Silent Aim"}
                                                deltaX = "Left"
                                                angle.Side = "Left"
                                                key = total
                                                top = total.AddSection
                                            end
                                        elseif progress > 103 then
                                            deltaX(file, Scheduler)
                                            progress, i, Scheduler = progress + 60, "FOV", {}
                                            Scheduler.Title = "FOV"
                                            i = "Left"
                                            Scheduler.Side = "Left"
                                            deltaX = total.AddSection
                                            file = total
                                        else
                                            left = 62
                                            high = 115
                                            progress = smallest and 163 or 6901 / progress
                                        end
                                    elseif progress <= 112 then
                                        smallest = smallest()
                                        heap = type
                                        deltaY = smallest.STATE
                                        progress = 79
                                        success = deltaY
                                    else
                                        deepCopy(deltaZ, state)
                                        state = {Text = "NPCs Without Team", Flag = "esp_neutral_color"}
                                        progress = 64
                                        attachment = i[3].sharedSettings
                                        state.Default = attachment.neutralColor
                                        _ = triangle:Pa({i})
                                        state.Callback = _
                                        deepCopy = Graph.AddColorPicker
                                        deltaZ = Graph
                                    end
                                elseif progress > 118 then
                                    if progress >= 122 then
                                        if progress > 122 then
                                            index = "TextLabel"
                                            elapsed = playerIdentifier.IsA
                                            current = playerIdentifier
                                            progress = 512
                                            currentIndex = 130
                                            neighborX = 156
                                        else
                                            key(angle, deltaX)
                                            deltaX = {Text = "Max Distance", Flag = "sd_distance"}
                                            progress, file = progress + -104, 50
                                            deltaX.Min = 50
                                            deltaX.Max = 5000
                                            deltaX.Default = 1000
                                            deltaX.Rounding = 1
                                            deltaX.Suffix = " studs"
                                            file = triangle:ma({middle})
                                            deltaX.Callback = file
                                            key = top.AddSlider
                                            angle = top
                                        end
                                    else
                                        i()
                                        playerId = "Silent Aim"
                                        message = {Title = "Silent Aim"}
                                        low = Scheduler
                                        progress = 205
                                        prefix = "Adapter failed: "
                                        character = tostring
                                    end
                                elseif progress > 117 then
                                    instance = instance(Graph, button)
                                    deepCopy = {
                                        Text = "ESP Enabled", Flag = "players_enabled",
                                        Default = false
                                    }
                                    progress = 186
                                    deltaZ = triangle:F({i})
                                    deepCopy.Callback = deltaZ
                                    button = instance
                                    Graph = instance.AddToggle
                                elseif progress >= 116 then
                                    if progress <= 116 then
                                        points, serialized, status[3] = {}, "Fog End", humanoid(currentTime, points)
                                        points.Text = "Fog End"
                                        points.Flag = "wm_fog_end"
                                        points.Min = 0
                                        progress, points.Max = progress + 35, 10000
                                        points.Rounding = 0
                                        points.Default = 1000
                                        serialized = triangle:Ba({attachment})
                                        points.Callback = serialized
                                        currentTime = point
                                        humanoid = point.AddSlider
                                    else
                                        progress = 335
                                        speed = ColorSequence.new
                                        safeCall = index
                                    end
                                else
                                    tweenInfo = #index + 1
                                    progress = 972
                                    distance = ColorSequenceKeypoint.new
                                    MAX_ITERATIONS = speed / 6
                                    iterator = Color3.fromHSV
                                    result = 1
                                    visited = 0.75
                                    x = speed / 6
                                end
                            elseif progress <= 85 then
                                if progress <= 79 then
                                    if progress >= 74 then
                                        if progress <= 75 then
                                            if progress <= 74 then
                                                humanoidRootPart(instance, Graph)
                                                progress = 10
                                                humanoidRootPart = triangle:K({i, record, prefix, playerId, message})
                                                instance = humanoidRootPart
                                                button = "npc"
                                                Graph = character
                                            else
                                                exampleUsage = exampleUsage(part, nearestDistance)
                                                progress = exampleUsage and 15975 / progress or 45 or 45
                                            end
                                        else
                                            heap = heap(success)
                                            success = "table"
                                            smallest = heap == "table"
                                            progress = smallest and 266 - progress or 103 or 103
                                        end
                                    elseif progress <= 72 then
                                        MAX_ITERATIONS = nearestDistance[3].WatermarkText
                                        distance = nearestDistance[3].RegistryMap
                                        tweenInfo = distance[MAX_ITERATIONS]
                                        tweenInfo, progress, j = triangle:Na(), progress + -12, tweenInfo.Properties
                                        j.TextColor3 = tweenInfo
                                    else
                                        dummy(currentNode, triangle.d(startTime))
                                        dummy = triangle:n({nearestDistance})
                                        startTime = {}
                                        currentNode = {[1] = 3, [3] = startTime}
                                        currentNode[2] = currentNode
                                        startTime = {[1] = 3, [3] = startTime}
                                        startTime[2] = startTime
                                        right, startTime[3] = {}, triangle:o({currentNode, nearestDistance})
                                        bestDistance, right = right, {}
                                        bestDistance = {[1] = 3, [3] = bestDistance}
                                        bestDistance[2] = bestDistance
                                        offset = {[1] = 3, [3] = right}
                                        offset[2] = offset
                                        right = {[1] = 3, [3] = right}
                                        right[2] = right
                                        right[3], array = triangle:y(), {}
                                        copy = {[1] = 3, [3] = array}
                                        copy[2] = copy
                                        array = triangle:ba({bestDistance, label, startTime, currentNode, offset, heap, right, nearestDistance})
                                        copy[3].AddTab = array
                                        array = triangle:Da()
                                        nearestDistance[3].Connect = array
                                        array = {[1] = 3, [3] = nearestDistance[3].Notify,}
                                        array[2] = array
                                        total = triangle:ha({array})
                                        nearestDistance[3].Notify = total
                                        start = {}
                                        progress, start.Text = 138, "Combat"
                                        node = {}
                                        player = "Silent Aim"
                                        node[1] = "Silent Aim"
                                        endTime = node
                                        start.Pages = node
                                        data = copy[3]
                                        total = copy[3].AddTab
                                    end
                                elseif progress <= 82 then
                                    if progress > 80 then
                                        record, progress, i = Scheduler, 20172 / progress, tostring
                                    else
                                        queue.Face = label(dummy)
                                        queue.Cache = {}
                                        queue.Version = 0
                                        dummy = {}
                                        start = "Proggy Clean"
                                        copy = "Ubuntu"
                                        total = "Minecraftia"
                                        data = "Verdana"
                                        dummy[1], dummy[2], dummy[3], dummy[4], dummy[5], dummy[6], dummy[7], dummy[8], dummy[9], dummy[10] =
                                            "Code", "Arial", "Gotham", "Source Sans", "Roboto Mono",
                                            "Ubuntu", "Tahoma", "Minecraftia", "Verdana",
                                            "Proggy Clean"
                                        queue.Names = dummy
                                        queue.Builtins = {
                                            Code = Enum.Font.Code, Arial = Enum.Font.Arial,
                                            Gotham = Enum.Font.Gotham,
                                            ["Source Sans"] = Enum.Font.SourceSans,
                                            ["Roboto Mono"] = Enum.Font.RobotoMono,
                                            Ubuntu = Enum.Font.Ubuntu,
                                        }
                                        dummy = {
                                            Tahoma = "Tahoma-Modern.ttf",
                                            Minecraftia = "Minecraftia-Regular.ttf",
                                            Verdana = "Verdana-Font.ttf",
                                            ["Proggy Clean"] = "ProggyClean.ttf",
                                        }
                                        progress, queue.Files = 227, dummy
                                        length = {[1] = 3, [3] = queue}
                                        length[2] = length
                                        queue = triangle:B({length})
                                        length[3].Resolve = queue
                                        queue = triangle:ra({length})
                                        length[3].Apply = queue
                                        queue = triangle:h({length, nearestDistance})
                                        length[3].SetUI = queue
                                        queue = {[1] = 3, [3] = nearestDistance[3].Create,}
                                        queue[2] = queue
                                        label = triangle:_a({queue, length})
                                        nearestDistance[3].Create = label
                                        currentNode = {Title = "San Diego", Center = true, AutoShow = true}
                                        offset = 660
                                        bestDistance = 568
                                        startTime = UDim2.fromOffset
                                    end
                                else
                                    nearestDistance = assert
                                    heap = "LinoriaLib.luau"
                                    progress = 127
                                    deltaY = loadstring
                                    smallest = exampleUsage
                                end
                            elseif progress < 91 then
                                if progress > 89 then
                                    delta = {[1] = 3, [3] = delta}
                                    delta[2] = delta
                                    progress, delta[3] = progress + 793, triangle:l({Players, copy, sum})
                                    playerIdentifier = {[1] = 3, [3] = playerIdentifier}
                                    playerIdentifier[2] = playerIdentifier
                                    playerIdentifier[3] = triangle:w({Players, copy, sum})
                                    elapsed = {[1] = 3, [3] = elapsed}
                                    elapsed[2] = elapsed
                                    index, elapsed[3], current = offset[3], triangle:U({Players, copy, sum}), pairs
                                elseif progress > 88 then
                                    progress, nearestDistance = 144, nearestDistance(triangle.d(deltaY))
                                else
                                    index = copy[3].Items
                                    progress = 145
                                    current = index.SubTitleLabel
                                end
                            elseif progress < 92 then
                                progress, i = 157, triangle.c(i(record, message))
                            elseif progress > 92 then
                                position = position(humanoidRootPart, instance)
                                Graph = {Text = "ESP Enabled", Flag = "npc_enabled"}
                                progress = 74
                                Graph.Default = true
                                button = triangle:p({i})
                                Graph.Callback = button
                                instance = position
                                humanoidRootPart = position.AddToggle
                            else
                                status(iteration, priority)
                                priority = {
                                    Text = "World Time", Flag = "wm_time_value", Min = 0, Max = 24,
                                    Rounding = 1, Default = 14,
                                }
                                humanoid = triangle:H({attachment})
                                progress, priority.Callback = progress + 132, humanoid
                                iteration = point
                                status = point.AddSlider
                            end
                        elseif progress < 38 then
                            if progress <= 22 then
                                if progress >= 9 then
                                    if progress < 18 then
                                        if progress > 9 then
                                            instance(Graph, button)
                                            button = {Title = "General"}
                                            deepCopy = "Left"
                                            button.Side = "Left"
                                            instance, progress, Graph = low.AddSection, progress + 108, low
                                        else
                                            progress, nearestDistance, deltaY = 263 - progress, part.Unload, part
                                        end
                                    elseif progress > 18 then
                                        progress = progress + 153
                                        matrix(status, iteration)
                                        iteration = {
                                            Text = "Custom Color Shift", Flag = "wm_colorshift",
                                            Default = false
                                        }
                                        priority = triangle:G({attachment, deepCopy, _})
                                        iteration.Callback = priority
                                        matrix = point.AddToggle
                                        status = point
                                    else
                                        key(angle, deltaX)
                                        deltaX = {Title = "Checks"}
                                        file = "Right"
                                        deltaX.Side = "Right"
                                        progress, angle, key = 2916 / progress, total, total.AddSection
                                    end
                                elseif progress >= 6 then
                                    if progress <= 6 then
                                        iterator = j[1]
                                        progress, distance, MAX_ITERATIONS = progress + 162, #iterator.Groups, 0
                                        tweenInfo = distance > 0
                                    else
                                        progress, success = 234, success(triangle.d(resourceName))
                                    end
                                elseif progress <= 2 then
                                    progress, source = progress + 241, playerIdentifier
                                else
                                    progress = elapsed and progress + -1 or 63 or 63
                                end
                            elseif progress > 31 then
                                if progress > 32 then
                                    progress = 58
                                    angle(deltaX, file)
                                    file = {
                                        Text = "Visible Check", Flag = "sd_visible_check",
                                        Default = true
                                    }
                                    Scheduler = triangle:Ga({middle})
                                    file.Callback = Scheduler
                                    deltaX = key
                                    angle = key.AddToggle
                                else
                                    deltaY = part.Unloaded
                                    progress, nearestDistance = progress + 150, not deltaY
                                end
                            elseif progress >= 29 then
                                if progress <= 29 then
                                    progress, playerIdentifier, delta = 392 - progress, triangle:Wa({copy}), pcall
                                else
                                    progress = 166 - progress
                                    i(record, message)
                                end
                            elseif progress > 24 then
                                progress = 6214 / progress
                                matrix(status, iteration)
                                iteration = {Text = "Color Shift Bottom", Flag = "wm_colorshift_bottom"}
                                humanoid = attachment[3].colorShift
                                iteration.Default = humanoid.bottom
                                priority = triangle:v({attachment})
                                iteration.Callback = priority
                                status = point
                                matrix = point.AddColorPicker
                            else
                                angle = angle(deltaX, file)
                                progress, Scheduler, i = 2424 / progress, {}, "Auto Prediction"
                                Scheduler.Text = "Auto Prediction"
                                Scheduler.Flag = "sd_prediction"
                                Scheduler.Default = true
                                i = triangle:Ra({middle})
                                Scheduler.Callback = i
                                deltaX = angle.AddToggle
                                file = angle
                            end
                        elseif progress > 58 then
                            if progress > 64 then
                                if progress >= 67 then
                                    if progress <= 67 then
                                        progress = 155
                                        success = getgenv
                                    else
                                        index = "Lean v1.0 beta | San Diego Roleplay | "
                                        current = playerIdentifier.Text
                                        elapsed = current == "Lean v1.0 beta | San Diego Roleplay | "
                                        progress = currentIndex >= neighborX and 253 or progress + -67
                                    end
                                else
                                    progress, humanoid = progress + 632, humanoid(currentTime, points)
                                    humanoid, points, currentTime, priority[3] = state[3], false, status[3], humanoid
                                end
                            elseif progress < 63 then
                                if progress > 60 then
                                    progress = 737
                                    current = "TitleWaveGradient"
                                else
                                    progress = 920
                                    j = nearestDistance[3].KeybindFrame
                                    MAX_ITERATIONS = 16
                                    distance = 0
                                    iterator = 0.5
                                    tweenInfo = UDim2.new
                                    x = 0
                                end
                            elseif progress > 63 then
                                deepCopy(deltaZ, state)
                                state = {
                                    Text = "Box Outline Thickness",
                                    Flag = "npc_box_outline_thickness", Min = 1,
                                }
                                progress, state.Max = 240 - progress, 5
                                state.Default = 1
                                state.Suffix = "px"
                                _ = triangle:ua({i})
                                state.Callback = _
                                deltaZ = Graph
                                deepCopy = Graph.AddSlider
                            else
                                delta, playerIdentifier = entry(Players, sum)
                                sum = delta
                                progress = delta == nil and 243 or 123 or 123
                            end
                        elseif progress <= 46 then
                            if progress >= 42 then
                                if progress >= 45 then
                                    if progress <= 45 then
                                        progress = 188
                                        part = "LinoriaLib.luau"
                                        exampleUsage = readfile
                                    else
                                        data = {[1] = 3, [3] = data(start, endTime),}
                                        data[2] = data
                                        start, progress, node = game, progress + 93, "RunService"
                                        endTime, start = start, start.GetService
                                    end
                                else
                                    deepCopy(deltaZ, state)
                                    state = {Text = "Team Based Color", Flag = "esp_team_based_color"}
                                    progress, state.Default = 4746 / progress, false
                                    _ = triangle:x({i})
                                    state.Callback = _
                                    deltaZ = Graph
                                    deepCopy = Graph.AddToggle
                                end
                            elseif progress <= 38 then
                                Graph = Graph(button, deepCopy)
                                deltaZ = {Text = "Text Size", Flag = "esp_text_size", Min = 8}
                                progress, deltaZ.Max = 165, 24
                                _ = i[3].sharedSettings
                                deltaZ.Default = _.textSize
                                state = triangle:ya({i})
                                deltaZ.Callback = state
                                deepCopy = Graph
                                button = Graph.AddSlider
                            else
                                angle(deltaX, file)
                                file = {Title = "Prediction"}
                                Scheduler = "Right"
                                file.Side = "Right"
                                angle = total.AddSection
                                progress = 24
                                deltaX = total
                            end
                        elseif progress > 56 then
                            angle(deltaX, file)
                            file = {Text = "Hitscan", Flag = "sd_hitscan", Default = false}
                            Scheduler = triangle:Qa({middle})
                            progress, file.Callback = 2378 / progress, Scheduler
                            angle = key.AddToggle
                            deltaX = key
                        elseif progress <= 51 then
                            heap = heap(success)
                            success = "function"
                            progress, smallest = progress + 52, heap == "function"
                        else
                            part = nearestDistance().LinoriaMenuLibrary
                            nearestDistance = part
                            progress = part and 88 - progress or 182 or 182
                        end
                    elseif progress < 169 then
                        if progress < 144 then
                            if progress > 135 then
                                if progress < 139 then
                                    if progress > 137 then
                                        total = total(data, start)
                                        endTime = "Players"
                                        progress = 46
                                        data = game
                                        start, data = data, data.GetService
                                    elseif progress > 136 then
                                        progress, resourceName = 146, resourceName(triangle.d(length))
                                    else
                                        point = point(matrix, status)
                                        iteration = {
                                            Text = "Custom Ambient", Flag = "wm_ambient",
                                            Default = false
                                        }
                                        progress, priority = 29920 / progress, triangle:fa({attachment, deepCopy, _})
                                        iteration.Callback = priority
                                        matrix = point.AddToggle
                                        status = point
                                    end
                                elseif progress <= 141 then
                                    if progress > 139 then
                                        iterator(x, visited)
                                        progress, iterator, x, visited = progress + 446, success.SetLibrary, success, nearestDistance[3]
                                    else
                                        start = {[1] = 3, [3] = start(endTime, node),}
                                        start[2] = start
                                        progress, player, endTime = 388 - progress, "UserInputService", game
                                        endTime, node = endTime.GetService, endTime
                                    end
                                else
                                    file = file(Scheduler)
                                    direction[3].circle = file
                                    direction[3].circle.Filled = false
                                    direction[3].circle.Thickness = 1
                                    direction[3].circle.Transparency = 1
                                    Scheduler = direction[3].connections
                                    message = triangle:ga({direction, endTime, middle})
                                    file = table.insert
                                    i = start[3].RenderStepped
                                    i, progress, record = i.Connect, 91, i
                                end
                            elseif progress > 130 then
                                if progress >= 132 then
                                    if progress > 132 then
                                        progress, i = 33750 / progress, triangle:j({data, node, start})
                                    else
                                        deltaZ = deltaZ(state, _)
                                        state = {[1] = 3, [3] = state}
                                        state[2] = state
                                        point, attachment, state[3] = deepCopy[3].Ambient, {}, triangle:N()
                                        attachment.Ambient = point
                                        attachment.OutdoorAmbient = deepCopy[3].OutdoorAmbient
                                        attachment.ColorShift_Top = deepCopy[3].ColorShift_Top
                                        attachment.ColorShift_Bottom = deepCopy[3].ColorShift_Bottom
                                        attachment.ClockTime = deepCopy[3].ClockTime
                                        attachment.FogStart = deepCopy[3].FogStart
                                        attachment.FogEnd = deepCopy[3].FogEnd
                                        attachment.FogColor = deepCopy[3].FogColor
                                        attachment.Brightness = deepCopy[3].Brightness
                                        attachment.ExposureCompensation = deepCopy[3].ExposureCompensation
                                        attachment.EnvironmentDiffuseScale = deepCopy[3].EnvironmentDiffuseScale
                                        attachment.EnvironmentSpecularScale = deepCopy[3].EnvironmentSpecularScale
                                        attachment.GlobalShadows = deepCopy[3].GlobalShadows
                                        attachment.ShadowSoftness = deepCopy[3].ShadowSoftness
                                        _ = {[1] = 3, [3] = attachment}
                                        _[2] = _
                                        status = {}
                                        point = {}
                                        status.enabled = false
                                        status.a = deepCopy[3].Ambient
                                        status.b = deepCopy[3].OutdoorAmbient
                                        point.ambient = status
                                        point.colorShift = {
                                            enabled = false, top = deepCopy[3].ColorShift_Top,
                                            bottom = deepCopy[3].ColorShift_Bottom,
                                        }
                                        point.time = {enabled = false, value = deepCopy[3].ClockTime,}
                                        point.fog = {
                                            enabled = false, s = deepCopy[3].FogStart, e = deepCopy[3].FogEnd,
                                            color = deepCopy[3].FogColor,
                                        }
                                        status = {
                                            enabled = false, brightness = deepCopy[3].Brightness,
                                            exposure = deepCopy[3].ExposureCompensation,
                                            diffuse = deepCopy[3].EnvironmentDiffuseScale,
                                        }
                                        progress = 241
                                        status.specular = deepCopy[3].EnvironmentSpecularScale
                                        point.light = status
                                        point.shadows = {
                                            enabled = false, softness = deepCopy[3].ShadowSoftness,
                                            tech = "ShadowMap",
                                        }
                                        attachment = {[1] = 3, [3] = point}
                                        attachment[2] = attachment
                                        matrix = nearestDistance[3]
                                        iteration = triangle:va({attachment, deepCopy})
                                        point = nearestDistance[3].Connect
                                        status = start[3].RenderStepped
                                    end
                                else
                                    character, low, screenGui = character(low, screenGui)
                                    instance = {Title = "General"}
                                    progress = 94
                                    Graph = "Left"
                                    instance.Side = "Left"
                                    humanoidRootPart = character
                                    position = character.AddSection
                                end
                            elseif progress <= 128 then
                                if progress <= 127 then
                                    if progress <= 125 then
                                        progress, top = 355 - progress, top(key, angle)
                                        deltaX = {
                                            Text = "Enabled", Flag = "sd_silent_enabled",
                                            Default = false
                                        }
                                        file = triangle:R({middle})
                                        deltaX.Callback = file
                                        key = top.AddToggle
                                        angle = top
                                    else
                                        progress, deltaY = 89, triangle.c(deltaY(smallest, heap))
                                    end
                                else
                                    humanoid(currentTime, points)
                                    points = {
                                        Text = "Fog Start", Flag = "wm_fog_start", Min = 0,
                                        Max = 5000, Rounding = 0, Default = 0,
                                    }
                                    progress = 116
                                    serialized = triangle:ka({attachment})
                                    points.Callback = serialized
                                    humanoid = point.AddSlider
                                    currentTime = point
                                end
                            else
                                progress, heap = 359 - progress, success().Options
                                smallest = {[1] = 3, [3] = smallest}
                                smallest[2] = smallest
                                heap = {[1] = 3, [3] = heap}
                                heap[2] = heap
                                queue = "https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/ThemeManager.lua"
                                resourceName = game
                                success = loadstring
                                length, resourceName = resourceName, resourceName.HttpGet
                            end
                        elseif progress <= 155 then
                            if progress > 150 then
                                if progress >= 153 then
                                    if progress <= 153 then
                                        deepCopy = {[1] = 3, [3] = deepCopy(deltaZ, state),}
                                        progress, deepCopy[2] = 285 - progress, deepCopy
                                        _ = {Text = "Visuals"}
                                        point = {}
                                        matrix = "World Modulation"
                                        point[1] = "World Modulation"
                                        attachment = point
                                        _.Pages = point
                                        state = copy[3]
                                        deltaZ = copy[3].AddTab
                                    else
                                        success, progress, smallest = getgenv, 130, success().Toggles
                                    end
                                else
                                    iteration[3], points, serialized = humanoid(currentTime, points), {}, "Fog Color"
                                    points.Text = "Fog Color"
                                    points.Flag = "wm_fog_color"
                                    rootPart = attachment[3].fog
                                    progress, points.Default = 65, rootPart.color
                                    serialized = triangle:Ca({attachment})
                                    points.Callback = serialized
                                    currentTime = point
                                    humanoid = point.AddColorPicker
                                end
                            elseif progress > 146 then
                                if progress > 149 then
                                    distance, tweenInfo, progress, MAX_ITERATIONS = safeCall, dummy, 1135 - progress, j
                                else
                                    status(iteration, priority)
                                    status = {[1] = 3, [3] = nil}
                                    status[2] = status
                                    iteration = {[1] = 3, [3] = nil}
                                    iteration[2] = iteration
                                    priority = {[1] = 3, [3] = nil}
                                    priority[2] = priority
                                    points = {Text = "Custom Fog", Flag = "wm_fog", Default = false}
                                    serialized = triangle:S({attachment, state, iteration, deepCopy, status, priority, _})
                                    points.Callback = serialized
                                    currentTime, progress, humanoid = point, 277 - progress, point.AddToggle
                                end
                            elseif progress < 145 then
                                nearestDistance = {[1] = 3, [3] = nearestDistance(),}
                                progress, nearestDistance[2] = progress + 34, nearestDistance
                                deltaY = getgenv
                            elseif progress <= 145 then
                                progress, index = 114695 / progress, "SubWaveGradient"
                            else
                                resourceName = resourceName()
                                label = {}
                                startTime = {}
                                length = success.BuiltInThemes
                                startTime.FontColor = "E0E0E0"
                                startTime.MainColor = "191919"
                                startTime.BackgroundColor = "121212"
                                startTime.AccentColor = "BEBEBE"
                                bestDistance = "313131"
                                startTime.OutlineColor = "313131"
                                currentNode = startTime
                                label[1], label[2] = 0, startTime
                                length.Clean = label
                                length = "Clean"
                                progress, success.DefaultTheme = 226 - progress, "Clean"
                                queue = {UIName = "Code"}
                                label = Font.fromEnum
                                dummy = nearestDistance[3].Font
                            end
                        elseif progress >= 163 then
                            if progress <= 165 then
                                if progress > 163 then
                                    button(deepCopy, deltaZ)
                                    deepCopy = {UI = 0}
                                    progress = 211
                                    deepCopy.System = 1
                                    deepCopy.Plex = 2
                                    deepCopy.Monospace = 3
                                    button = {[1] = 3, [3] = deepCopy}
                                    button[2] = button
                                    state = {Text = "Font", Flag = "esp_text_font"}
                                    status = "Plex"
                                    point = "UI"
                                    matrix = "System"
                                    attachment = {}
                                    iteration = "Monospace"
                                    attachment[1], attachment[2], attachment[3], attachment[4] = "UI", "System", "Plex", "Monospace"
                                    state.Options = attachment
                                    state.Default = "Plex"
                                    _ = triangle:i({i, button})
                                    state.Callback = _
                                    deltaZ = Graph
                                    deepCopy = Graph.AddDropdown
                                else
                                    progress = 207
                                    smallest = deltaY.onCleanup
                                    heap = triangle:da({nearestDistance})
                                end
                            else
                                progress = tweenInfo and 318 - progress or 42504 / progress
                            end
                        elseif progress <= 161 then
                            if progress > 157 then
                                direction.FOVColor = vectorA(deltaTime, top, key)
                                direction.MaxDistance = 1000
                                direction.HitChance = 100
                                middle = {[1] = 3, [3] = direction}
                                progress, middle[2] = 225, middle
                                vectorA = {Silent = middle[3], active = true, connections = {}, hooks = {},}
                                deltaTime = setmetatable
                                angle = "k"
                                top = {}
                                key = {__mode = "k"}
                            else
                                progress = 38936 / progress
                                file(Scheduler, triangle.d(i))
                                file = pcall
                                Scheduler = direction[3].Install
                            end
                        else
                            progress, key = 33, key(angle, deltaX)
                            file = {Text = "Team Check", Flag = "sd_team_check", Default = true}
                            Scheduler = triangle:s({middle})
                            file.Callback = Scheduler
                            deltaX = key
                            angle = key.AddToggle
                        end
                    elseif progress < 195 then
                        if progress >= 179 then
                            if progress > 186 then
                                if progress < 188 then
                                    heap = type
                                    progress = 51
                                    success = deltaY.onCleanup
                                elseif progress <= 188 then
                                    progress, exampleUsage = 213, exampleUsage(part)
                                else
                                    key(angle, deltaX)
                                    deltaX = {
                                        Text = "Hit Chance", Flag = "sd_hit_chance", Min = 0,
                                        Max = 100, Default = 100,
                                    }
                                    progress, file = progress + -68, 1
                                    deltaX.Rounding = 1
                                    deltaX.Suffix = "%"
                                    file = triangle:Ka({middle})
                                    deltaX.Callback = file
                                    angle = top
                                    key = top.AddSlider
                                end
                            elseif progress < 184 then
                                if progress <= 179 then
                                    file(Scheduler, i)
                                    i = {Text = "Show FOV"}
                                    progress, i.Flag = 251, "sd_show_fov"
                                    i.Default = true
                                    record = triangle:Sa({middle})
                                    i.Callback = record
                                    file = deltaX.AddToggle
                                    Scheduler = deltaX
                                else
                                    progress = nearestDistance and 9 or 267 - progress
                                end
                            elseif progress > 184 then
                                Graph(button, deepCopy)
                                deepCopy = {
                                    Text = "Team Check", Flag = "players_team_check",
                                    Default = false
                                }
                                progress = 198
                                deltaZ = triangle:Q({i})
                                deepCopy.Callback = deltaZ
                                button = instance
                                Graph = instance.AddToggle
                            else
                                current = copy[3].Items
                                progress, elapsed = progress + -122, current.TitleLabel
                            end
                        elseif progress < 175 then
                            if progress <= 170 then
                                if progress <= 169 then
                                    deltaX = deltaX(file, Scheduler)
                                    i = {
                                        Text = "Radius", Flag = "sd_fov", Min = 10, Max = 600,
                                        Default = 120, Rounding = 1, Suffix = " px",
                                    }
                                    record = triangle:Fa({middle})
                                    i.Callback = record
                                    file = deltaX.AddSlider
                                    progress = 179
                                    Scheduler = deltaX
                                else
                                    deepCopy(deltaZ, state)
                                    state = {
                                        Text = "Max Distance", Flag = "esp_max_distance", Min = 50,
                                        Max = 2000,
                                    }
                                    attachment = i[3].sharedSettings
                                    progress, state.Default = progress + -128, attachment.maxDistance
                                    state.Suffix = " studs"
                                    _ = triangle:Ea({i})
                                    state.Callback = _
                                    deltaZ = Graph
                                    deepCopy = Graph.AddSlider
                                end
                            else
                                speed = speed + j
                                progress = j > 0 and 566 - progress or 918 - progress
                            end
                        elseif progress >= 177 then
                            if progress <= 177 then
                                label = {[1] = 3, [3] = label(dummy, currentNode),}
                                progress, label[2] = 235, label
                                dummy = label[3].Holder
                                startTime = "ScreenGui"
                                dummy, currentNode = dummy.FindFirstAncestorWhichIsA, dummy
                            else
                                progress, deltaY = 112, deltaY()
                                deltaY.LinoriaMenuLibrary = nearestDistance[3]
                                smallest = getfenv
                            end
                        elseif progress <= 175 then
                            matrix(status, iteration)
                            iteration = {Text = "Color Shift Top", Flag = "wm_colorshift_top"}
                            humanoid = attachment[3].colorShift
                            iteration.Default = humanoid.top
                            priority = triangle:A({attachment})
                            iteration.Callback = priority
                            progress, status, matrix = 4550 / progress, point, point.AddColorPicker
                        else
                            deepCopy(deltaZ, state)
                            direction[3].ESP = i[3]
                            progress = 153
                            deepCopy = game
                            state = "Lighting"
                            deepCopy, deltaZ = deepCopy.GetService, deepCopy
                        end
                    elseif progress < 211 then
                        if progress > 205 then
                            if progress > 209 then
                                progress, length = 137, triangle.c(length(queue, label))
                            elseif progress <= 207 then
                                smallest(heap)
                                progress = left > high and 90 or 67 or 67
                            else
                                progress, current, safeCall = progress + 48, bestDistance[3]["UI Settings"], "Menu"
                                index = current.AddLeftGroupbox
                                speed = current
                            end
                        elseif progress < 201 then
                            if progress <= 195 then
                                main(sourcePlayer, count)
                                progress = 212
                                count = false
                                main = state[3]
                                sourcePlayer = points[3]
                            else
                                Graph(button, deepCopy)
                                Graph = humanoidRootPart
                                deepCopy = "players"
                                progress = 226
                                button = low
                            end
                        elseif progress > 201 then
                            character = character(low)
                            message.Description = prefix .. character
                            playerId = 8
                            progress, message.Lifetime = 6355 / progress, 8
                            i = nearestDistance[3].Notify
                            record = nearestDistance[3]
                        else
                            matrix(status, iteration)
                            iteration = {Text = "Outdoor Ambient", Flag = "wm_ambient_b"}
                            humanoid = attachment[3].ambient
                            progress = 22
                            iteration.Default = humanoid.b
                            priority = triangle:u({attachment})
                            iteration.Callback = priority
                            status = point
                            matrix = point.AddColorPicker
                        end
                    elseif progress < 216 then
                        if progress >= 212 then
                            if progress > 212 then
                                progress = 56
                                nearestDistance = getgenv
                            else
                                progress = 109816 / progress
                                main(sourcePlayer, count)
                                count = false
                                main = state[3]
                                sourcePlayer = serialized[3]
                            end
                        else
                            deepCopy(deltaZ, state)
                            progress, _, state = 35870 / progress, "Limit Distance", {}
                            state.Text = "Limit Distance"
                            state.Flag = "esp_limit_distance"
                            attachment = i[3].sharedSettings
                            state.Default = attachment.limitDistance
                            _ = triangle:D({i})
                            state.Callback = _
                            deltaZ = Graph
                            deepCopy = Graph.AddToggle
                        end
                    elseif progress > 220 then
                        vectorA().LinoriaSanDiegoCombat = direction[3]
                        vectorA = {[1] = 3, [3] = nil}
                        vectorA[2] = vectorA
                        deltaTime = triangle:Oa({endTime, vectorA})
                        direction[3].KeyActive = deltaTime
                        deltaTime = triangle:La({node, data, player, middle})
                        direction[3].Allowed = deltaTime
                        top = RaycastParams
                        progress, deltaTime = 22200 / progress, RaycastParams.new
                    elseif progress >= 217 then
                        if progress > 217 then
                            matrix(status, iteration)
                            iteration = {}
                            progress, iteration.Text = 421 - progress, "Ambient"
                            iteration.Flag = "wm_ambient_a"
                            humanoid = attachment[3].ambient
                            iteration.Default = humanoid.a
                            priority = triangle:g({attachment})
                            iteration.Callback = priority
                            status = point
                            matrix = point.AddColorPicker
                        else
                            file(Scheduler, i)
                            progress = 143
                            Scheduler = "Circle"
                            file = Drawing.new
                        end
                    else
                        RunService = RunService(identifier, source)
                        entry = {Title = "Teams"}
                        Players = "Left"
                        progress, entry.Side = 593, "Left"
                        identifier = RunService.AddSection
                        source = RunService
                    end
                elseif progress <= 518 then
                    if progress < 286 then
                        if progress > 243 then
                            if progress <= 254 then
                                if progress >= 250 then
                                    if progress < 253 then
                                        if progress <= 250 then
                                            progress, i = progress + -119, i()
                                            i = {[1] = 3, [3] = i}
                                            i[2] = i
                                            message = i[3].advanced
                                            record = {[1] = 3, [3] = i[3].chams,}
                                            record[2] = record
                                            message = {[1] = 3, [3] = message}
                                            message[2] = message
                                            playerId = {[1] = 3, [3] = playerId}
                                            playerId[2] = playerId
                                            playerId[3] = triangle:ja()
                                            prefix = {[1] = 3, [3] = prefix}
                                            prefix[2] = prefix
                                            prefix[3], position, humanoidRootPart = triangle:C(), {}, "Esp"
                                            position.Text = "Esp"
                                            instance = {}
                                            button = "Players"
                                            deepCopy = "Settings"
                                            Graph = "NPCs"
                                            instance[1], instance[2], instance[3] = "NPCs", "Players", "Settings"
                                            humanoidRootPart = instance
                                            position.Pages = instance
                                            low = copy[3]
                                            character = copy[3].AddTab
                                            screenGui = position
                                        else
                                            file(Scheduler, i)
                                            i = {Text = "Color", Flag = "sd_fov_color"}
                                            progress, i.Default = 217, middle[3].FOVColor
                                            record = triangle:Ta({middle})
                                            i.Callback = record
                                            Scheduler = deltaX
                                            file = deltaX.AddColorPicker
                                        end
                                    elseif progress <= 253 then
                                        safeCall, j = current(index, speed)
                                        speed = safeCall
                                        progress = safeCall == nil and 462 - progress or 242 or 242
                                    else
                                        progress = 85
                                        nearestDistance(deltaY)
                                    end
                                elseif progress < 248 then
                                    progress, i = progress + -127, i(record)
                                    direction[3].hookState = i
                                    i = direction[3].Destroy
                                elseif progress <= 248 then
                                    file, Scheduler = file(Scheduler)
                                    i = not file
                                    progress = i and 82 or 135 or 135
                                else
                                    endTime = {[1] = 3, [3] = endTime(node, player),}
                                    endTime[2] = endTime
                                    node = {[1] = 3, [3] = data[3].LocalPlayer,}
                                    node[2] = node
                                    middle = {teams = {},}
                                    progress, direction = 410 - progress, true
                                    middle.silent = true
                                    middle.trigger = true
                                    middle._added = {}
                                    player = {[1] = 3, [3] = middle}
                                    player[2] = player
                                    direction = {
                                        Enabled = false, TeamCheck = true, VisibleCheck = true,
                                        Hitscan = false, Prediction = true, BulletDrop = true,
                                        HitPart = "Head", FOV = 120, ShowFOV = true,
                                    }
                                    top = 80
                                    vectorA = Color3.fromRGB
                                    key = 255
                                    deltaTime = 150
                                end
                            elseif progress >= 262 then
                                if progress > 270 then
                                    progress = 798
                                    humanoid(currentTime, points)
                                    points = {Title = "Lighting"}
                                    serialized = "Right"
                                    points.Side = "Right"
                                    currentTime = deltaZ
                                    humanoid = deltaZ.AddSection
                                elseif progress > 262 then
                                    speed = speed(safeCall, j)
                                    tweenInfo = "ui_font"
                                    distance = {}
                                    progress, distance.Text = 934 - progress, "UI Font"
                                    distance.Values = length[3].Names
                                    MAX_ITERATIONS = "Code"
                                    distance.Default = "Code"
                                    j = speed
                                    safeCall = speed.AddDropdown
                                else
                                    progress = progress + 602
                                    visited(result)
                                    visited = i[3].Load
                                end
                            elseif progress >= 257 then
                                if progress > 257 then
                                    RunService, serialized[3], count = "Environment Specular", main(sourcePlayer, count), {}
                                    count.Text = "Environment Specular"
                                    count.Flag = "wm_specular"
                                    progress, count.Min = progress + 510, 0
                                    count.Max = 1
                                    count.Rounding = 2
                                    identifier = attachment[3].light
                                    count.Default = identifier.specular
                                    RunService = triangle:la({attachment})
                                    count.Callback = RunService
                                    main = humanoid.AddSlider
                                    sourcePlayer = humanoid
                                else
                                    progress, index = 871 - progress, index(speed, safeCall)
                                    j = "ui_watermark"
                                    tweenInfo = {Text = "Watermark"}
                                    distance = true
                                    tweenInfo.Default = true
                                    safeCall = index
                                    speed = index.AddToggle
                                end
                            else
                                deltaX, vectorA[3], file = {}, key(angle, deltaX), "Hit Part"
                                deltaX.Text = "Hit Part"
                                deltaX.Flag = "sd_hit_part"
                                record, i, message, progress, Scheduler =
                                    "UpperTorso", "Head", "HumanoidRootPart", 445 - progress, {}
                                Scheduler[1], Scheduler[2], Scheduler[3] = "Head", "UpperTorso", "HumanoidRootPart"
                                deltaX.Options = Scheduler
                                deltaX.Default = "Head"
                                file = triangle:W({middle})
                                deltaX.Callback = file
                                key = top.AddDropdown
                                angle = top
                            end
                        elseif progress >= 234 then
                            if progress > 239 then
                                if progress > 242 then
                                    delta = {}
                                    Players = {}
                                    delta.Instance = source
                                    Players.TitleLabel = delta
                                    Players.SubTitleLabel = {Instance = nearestDistance[3].WatermarkText,}
                                    progress, copy[3].Items = 797, Players
                                    Players = {}
                                    playerIdentifier = "pulse"
                                    elapsed = "gradient"
                                    Players[1], Players[2], Players[3], Players[4] =
                                        "wave", "rainbow", "pulse", "gradient"
                                    delta = copy[3].WaveStyles
                                    sum = type
                                    entry = Players
                                elseif progress > 241 then
                                    distance = #j
                                    MAX_ITERATIONS = 0
                                    tweenInfo = distance > 0
                                    progress = tweenInfo and 1452 / progress or 168 or 168
                                else
                                    point(matrix, status, iteration)
                                    status = {Title = "World"}
                                    iteration = "Left"
                                    progress, status.Side = 377 - progress, "Left"
                                    point = deltaZ.AddSection
                                    matrix = deltaZ
                                end
                            elseif progress < 237 then
                                if progress > 234 then
                                    dummy = dummy(currentNode, startTime)
                                    length[3].Root = dummy
                                    progress, bestDistance = 472 - progress, length[3].Root
                                    offset = triangle:t({length})
                                    startTime = bestDistance.DescendantAdded
                                    startTime, bestDistance = startTime.Connect, startTime
                                else
                                    success = success()
                                    length = game
                                    label = "https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/SaveManager.lua"
                                    resourceName = loadstring
                                    queue, progress, length = length, 210, length.HttpGet
                                end
                            elseif progress > 237 then
                                matrix(status, iteration)
                                matrix = {[1] = 3, [3] = nil}
                                matrix[2] = matrix
                                progress, priority, humanoid = 331 - progress, {}, "Custom World Time"
                                priority.Text = "Custom World Time"
                                priority.Flag = "wm_time"
                                priority.Default = false
                                humanoid = triangle:Aa({attachment, state, deepCopy, _, matrix})
                                priority.Callback = humanoid
                                status = point.AddToggle
                                iteration = point
                            else
                                progress, startTime = 310 - progress, triangle.c(startTime(bestDistance, offset))
                                dummy = nearestDistance[3].GiveSignal
                                currentNode = nearestDistance[3]
                            end
                        elseif progress <= 226 then
                            if progress <= 225 then
                                if progress >= 224 then
                                    if progress > 224 then
                                        vectorA.contexts = deltaTime(top, key)
                                        progress, vectorA.hookState = 222, "Not installed"
                                        vectorA.keyState = {down = false, on = false}
                                        top = {}
                                        key = 0
                                        top.shots = 0
                                        top.redirected = 0
                                        top.projectiles = 0
                                        deltaTime = top
                                        vectorA.diagnostics = top
                                        direction = {[1] = 3, [3] = vectorA}
                                        direction[2] = direction
                                        direction[3].Library = nearestDistance[3]
                                        vectorA = getgenv
                                    else
                                        matrix[3], status = status(iteration, priority), state[3]
                                        progress, priority, iteration = progress + -75, false, matrix[3]
                                    end
                                else
                                    progress = 75
                                    placeholder = 125
                                    nearestDistance = "https://raw.githubusercontent.com/vcqz23/settings/refs/heads/main/Linoria%20Src"
                                    exampleUsage = game
                                    part, exampleUsage = exampleUsage, exampleUsage.HttpGet
                                end
                            else
                                Graph(button, deepCopy)
                                deepCopy = {Title = "Settings"}
                                progress, deltaZ = 264 - progress, "Left"
                                deepCopy.Side = "Left"
                                Graph = screenGui.AddSection
                                button = screenGui
                            end
                        elseif progress <= 229 then
                            if progress <= 227 then
                                currentNode.Size = startTime(bestDistance, offset)
                                currentNode.TabPadding = 6
                                startTime = 0.16
                                currentNode.MenuFadeTime = 0.16
                                progress, dummy, label = 40179 / progress, nearestDistance[3], nearestDistance[3].CreateWindow
                            else
                                progress, resourceName = progress + -222, triangle.c(resourceName(length, queue))
                            end
                        else
                            key(angle, deltaX)
                            deltaX = {Text = "Silent Aim Key", Flag = "sd_silent_key"}
                            i = Enum
                            Scheduler = Enum.UserInputType
                            deltaX.Default = Scheduler.MouseButton2
                            deltaX.Mode = "Hold"
                            file = triangle:X()
                            deltaX.Callback = file
                            progress, key, angle = 485 - progress, top.AddKeyPicker, top
                        end
                    elseif progress < 390 then
                        if progress >= 340 then
                            if progress <= 363 then
                                if progress > 359 then
                                    delta(playerIdentifier)
                                    progress, playerIdentifier = 1350 - progress, triangle:xa({copy})
                                elseif progress <= 358 then
                                    if progress <= 340 then
                                        main(sourcePlayer, count)
                                        progress, RunService, count = 268600 / progress, "World Brightness", {}
                                        count.Text = "World Brightness"
                                        count.Flag = "wm_brightness"
                                        count.Min = 0
                                        count.Max = 10
                                        count.Rounding = 2
                                        identifier = attachment[3].light
                                        count.Default = identifier.brightness
                                        RunService = triangle:T({attachment})
                                        count.Callback = RunService
                                        sourcePlayer = humanoid
                                        main = humanoid.AddSlider
                                    else
                                        elapsed.A = current(index, speed, safeCall)
                                        elapsed.B = nearestDistance[3].AccentColor
                                        elapsed.Speed = 1
                                        current = "wave"
                                        elapsed.Style = "wave"
                                        delta.Sub = elapsed
                                        playerIdentifier = triangle:V()
                                        delta.Rebuild = playerIdentifier
                                        sum = {[1] = 3, [3] = delta}
                                        sum[2] = sum
                                        delta = not Players[3]
                                        progress = delta and 29 or 90 or 90
                                    end
                                else
                                    iterator(x, visited)
                                    iterator = nearestDistance[3].OnUnload
                                    x = nearestDistance[3]
                                    progress = 141
                                    visited = triangle:Xa({direction, i, deepCopy, _, attachment})
                                end
                            elseif progress > 381 then
                                progress = 881
                                iterator(x, visited)
                                iterator = resourceName.BuildConfigSection
                                x = resourceName
                                visited = current
                            elseif progress <= 372 then
                                visited(result, Lighting, line)
                                return
                            else
                                iterator(x, visited)
                                iterator = smallest[3].ui_keybinds
                                visited = triangle:oa({nearestDistance})
                                iterator, progress, x = iterator.OnChanged, 359, iterator
                            end
                        elseif progress > 298 then
                            if progress < 335 then
                                count[3], RunService, identifier, progress, source = RunService(identifier, source), state[3], sourcePlayer[3], 998, false
                            elseif progress > 335 then
                                x = x(visited, result)
                                progress = 969
                                Lighting = "subFx_colorA"
                                line = {Title = "Gradient"}
                                ok = 1
                                frame = Color3.new
                                textLabel = 1
                                hash = 1
                            else
                                current[3] = speed(safeCall)
                                index = {[1] = 3, [3] = index}
                                index[2] = index
                                index[3] = triangle:m({current})
                                speed = triangle:Ia({index, playerIdentifier, elapsed, sum})
                                progress, sum[3].Rebuild = 824 - progress, speed
                                speed = sum[3].Rebuild
                            end
                        elseif progress <= 291 then
                            if progress <= 290 then
                                if progress <= 286 then
                                    progress, iterator = 241384 / progress, iterator(x, visited)
                                    Lighting = {}
                                    result = "subFx_style"
                                    Lighting.Text = "Style"
                                    Lighting.Values = entry
                                    line = "wave"
                                    Lighting.Default = "wave"
                                    visited = iterator
                                    x = iterator.AddDropdown
                                else
                                    visited(result, Lighting, line)
                                    progress, visited, Lighting = progress + 644, heap[3].subFx_colorA, triangle:O({elapsed})
                                    result, visited = visited, visited.OnChanged
                                end
                            else
                                iterator(x, visited, result)
                                visited = triangle:Ua({nearestDistance})
                                iterator = smallest[3].ui_watermark
                                progress, x, iterator = 381, iterator, iterator.OnChanged
                            end
                        else
                            progress = progress + -8
                            visited(result, Lighting, line)
                            line = {}
                            Lighting = "subFx_colorB"
                            line.Title = "Gradient"
                            frame = nearestDistance[3].AccentColor
                            line.Default = frame
                            visited = x.AddColorPicker
                            result = x
                        end
                    elseif progress >= 452 then
                        if progress <= 494 then
                            if progress < 489 then
                                if progress > 452 then
                                    j.Position = tweenInfo(distance, MAX_ITERATIONS)
                                    j = nearestDistance[3].WatermarkText
                                    tweenInfo = Color3.new
                                    distance = 1
                                    MAX_ITERATIONS = 1
                                    progress = 682
                                    iterator = 1
                                else
                                    source, sourcePlayer[3], entry = {}, RunService(identifier, source), "Graphics Technology"
                                    source.Text = "Graphics Technology"
                                    source.Flag = "wm_tech"
                                    current = "Compatibility"
                                    delta = "Unified"
                                    sum = "ShadowMap"
                                    Players = {}
                                    playerIdentifier = "Future"
                                    elapsed = "Voxel"
                                    Players[1], Players[2], Players[3], Players[4], Players[5] =
                                        "ShadowMap", "Unified", "Future", "Voxel", "Compatibility"
                                    source.Options = Players
                                    progress, entry = progress + -135, "ShadowMap"
                                    source.Default = "ShadowMap"
                                    entry = triangle:k({attachment, deepCopy})
                                    source.Callback = entry
                                    identifier = main
                                    RunService = main.AddDropdown
                                end
                            elseif progress > 489 then
                                progress = speed > safeCall and 117 or 893 or 893
                            else
                                progress = progress + 87
                                speed()
                                tweenInfo = {}
                                safeCall = {}
                                tweenInfo.grad = playerIdentifier[3]
                                tweenInfo.cfg = sum[3].Title
                                distance = {grad = elapsed[3],}
                                MAX_ITERATIONS = sum[3].Sub
                                distance.cfg = MAX_ITERATIONS
                                safeCall[1], safeCall[2] = tweenInfo, distance
                                speed = {[1] = 3, [3] = safeCall}
                                speed[2] = speed
                                tweenInfo = start[3].RenderStepped
                                j = nearestDistance[3]
                                safeCall = nearestDistance[3].Connect
                                distance = triangle:r({speed})
                            end
                        elseif progress <= 512 then
                            if progress <= 507 then
                                progress = 602
                                safeCall(j, tweenInfo)
                                safeCall = triangle:M({nearestDistance})
                                tweenInfo = nearestDistance[3].Watermark
                                j = safeCall
                            else
                                elapsed = elapsed(current, index)
                                progress = elapsed and 70 or 3 or 3
                            end
                        else
                            progress = 924
                            main(sourcePlayer, count)
                            main = state[3]
                            sourcePlayer = rootPart[3]
                            count = false
                        end
                    elseif progress >= 417 then
                        if progress <= 424 then
                            if progress > 419 then
                                source(entry, Players)
                                progress = 417
                                Players = triangle:ca({nearestDistance, player, identifier})
                                source = task.delay
                                entry = 2
                            elseif progress > 417 then
                                iterator(x)
                                visited = {}
                                result = "MenuKeybind"
                                visited[1] = "MenuKeybind"
                                x = resourceName
                                progress = 735
                                iterator = resourceName.SetIgnoreIndexes
                            else
                                source(entry, Players)
                                entry = label[3]
                                Players = "UI Settings"
                                progress = 900
                                source = label[3].AddTab
                            end
                        else
                            progress = speed < safeCall and 117 or 1437 - progress
                        end
                    elseif progress >= 395 then
                        if progress <= 395 then
                            progress = speed > safeCall and 117 or 747 or 747
                        else
                            RunService(identifier, source)
                            source = {
                                Text = "Shadow Softness", Flag = "wm_shadow_softness", Min = 0,
                                Max = 1,
                            }
                            progress, source.Rounding = 867 - progress, 2
                            Players = attachment[3].shadows
                            source.Default = Players.softness
                            entry = triangle:wa({attachment})
                            source.Callback = entry
                            identifier = main
                            RunService = main.AddSlider
                        end
                    else
                        j(tweenInfo)
                        tweenInfo = Vector2.zero
                        nearestDistance[3].Watermark.AnchorPoint = tweenInfo
                        progress = 486
                        j = nearestDistance[3].Watermark
                        MAX_ITERATIONS = 10
                        tweenInfo = UDim2.fromOffset
                        distance = 150
                    end
                elseif progress < 798 then
                    if progress <= 697 then
                        if progress < 614 then
                            if progress < 576 then
                                if progress < 544 then
                                    distance = distance(MAX_ITERATIONS, triangle.d(iterator))
                                    index[tweenInfo] = distance
                                    progress = placeholder <= result and 71820 / progress or 171 or 171
                                elseif progress > 544 then
                                    iterator(x, visited)
                                    x = resourceName
                                    progress = 388
                                    visited = "Lean/SanDiego"
                                    iterator = resourceName.SetFolder
                                else
                                    progress = 834
                                    speed(safeCall, j, tweenInfo)
                                    speed = index.AddLabel
                                    safeCall = index
                                    j = "Menu Key"
                                end
                            elseif progress <= 593 then
                                if progress < 587 then
                                    progress = 90
                                    safeCall(j, tweenInfo, distance)
                                elseif progress <= 587 then
                                    iterator(x, visited)
                                    progress = 777
                                    visited = nearestDistance[3]
                                    x = resourceName
                                    iterator = resourceName.SetLibrary
                                else
                                    identifier = {[1] = 3, [3] = identifier(source, entry),}
                                    identifier[2] = identifier
                                    Players = {Text = "Scan Teams"}
                                    progress, sum = 604267 / progress, triangle:I({nearestDistance, player, identifier})
                                    Players.Callback = sum
                                    source = identifier[3].AddButton
                                    entry = identifier[3]
                                end
                            else
                                progress = progress + -212
                                j(tweenInfo)
                                tweenInfo = nearestDistance[3].KeybindFrame
                                j = safeCall
                            end
                        elseif progress <= 664 then
                            if progress >= 638 then
                                if progress <= 638 then
                                    progress = progress + -301
                                    x(visited, result)
                                    result = "Gradient"
                                    visited = iterator
                                    x = iterator.AddLabel
                                else
                                    progress, safeCall = 507, safeCall(j, tweenInfo, distance)
                                    j, tweenInfo, safeCall = safeCall, triangle:aa({length, nearestDistance}), safeCall.OnChanged
                                end
                            elseif progress > 614 then
                                main = main(sourcePlayer, count)
                                progress = 415
                                sourcePlayer = {[1] = 3, [3] = nil}
                                sourcePlayer[2] = sourcePlayer
                                count = {[1] = 3, [3] = nil}
                                count[2] = count
                                source = {Text = "Global Shadows", Flag = "wm_shadows", Default = false}
                                entry = triangle:q({attachment, state, count, _, sourcePlayer, deepCopy})
                                source.Callback = entry
                                identifier = main
                                RunService = main.AddToggle
                            else
                                progress = 334016 / progress
                                speed(safeCall, j, tweenInfo)
                                j = "ui_keybinds"
                                tweenInfo = {Text = "Active Keybinds"}
                                distance = true
                                tweenInfo.Default = true
                                speed = index.AddToggle
                                safeCall = index
                            end
                        elseif progress >= 682 then
                            if progress > 682 then
                                humanoid(currentTime, points)
                                humanoid, progress, currentTime, points = state[3], 578510 / progress, iteration[3], false
                            else
                                j.TextColor3 = tweenInfo(distance, MAX_ITERATIONS, iterator)
                                tweenInfo = nearestDistance[3].RegistryMap
                                distance = nearestDistance[3].WatermarkText
                                j = tweenInfo[distance]
                                progress = j and 754 - progress or 60 or 60
                            end
                        else
                            progress = j > 0 and 494 or 1566 - progress
                        end
                    elseif progress > 747 then
                        if progress < 790 then
                            if progress <= 771 then
                                if progress > 758 then
                                    main = main(sourcePlayer, count)
                                    main, progress, count, sourcePlayer, rootPart[3] = state[3], 195, false, currentTime[3], main
                                else
                                    progress = 286
                                    iterator(x, visited)
                                    visited = "Watermark Effect"
                                    iterator = current.AddRightGroupbox
                                    x = current
                                end
                            else
                                progress = progress + -358
                                iterator(x, visited)
                                x = resourceName
                                iterator = resourceName.IgnoreThemeSettings
                            end
                        elseif progress <= 791 then
                            if progress > 790 then
                                elapsed = {[1] = 3, [3] = elapsed(current, index),}
                                elapsed[2] = elapsed
                                current = {[1] = 3, [3] = nil}
                                current[2] = current
                                speed = 0
                                j = 1
                                index = {}
                                safeCall = 6
                                progress = 1464 - progress
                            else
                                count, RunService, currentTime[3] = {}, "Exposure Compensation", main(sourcePlayer, count)
                                count.Text = "Exposure Compensation"
                                count.Flag = "wm_exposure"
                                count.Min = -5
                                progress = 725
                                count.Max = 5
                                count.Rounding = 2
                                identifier = attachment[3].light
                                count.Default = identifier.exposure
                                RunService = triangle:E({attachment})
                                count.Callback = RunService
                                main = humanoid.AddSlider
                                sourcePlayer = humanoid
                            end
                        else
                            sum = sum(delta)
                            Players = {[1] = 3, [3] = sum == "table",}
                            progress, Players[2] = 1662 - progress, Players
                            delta = {}
                            elapsed = {}
                            index = 1
                            current = Color3.new
                            safeCall = 1
                            speed = 1
                        end
                    elseif progress < 737 then
                        if progress >= 725 then
                            if progress <= 725 then
                                points[3], RunService, count = main(sourcePlayer, count), "Environment Diffuse", {}
                                count.Text = "Environment Diffuse"
                                count.Flag = "wm_diffuse"
                                count.Min = 0
                                progress = 261
                                count.Max = 1
                                count.Rounding = 2
                                identifier = attachment[3].light
                                count.Default = identifier.diffuse
                                RunService = triangle:L({attachment})
                                count.Callback = RunService
                                sourcePlayer = humanoid
                                main = humanoid.AddSlider
                            else
                                iterator(x, visited)
                                progress, x, visited, iterator = 1300 - progress, success, "Lean", success.SetFolder
                            end
                        else
                            progress = j <= 0 and 884 or 835 - progress
                        end
                    elseif progress <= 745 then
                        if progress < 740 then
                            playerIdentifier = {[1] = 3, [3] = playerIdentifier(elapsed, current),}
                            playerIdentifier[2] = playerIdentifier
                            current = copy[3].Items
                            elapsed = delta
                            progress = current and 88 or 145 or 145
                        elseif progress > 740 then
                            x(visited, result)
                            result = "subFx_speed"
                            Lighting = {}
                            progress, Lighting.Text = 718925 / progress, "Speed"
                            Lighting.Min = 0.05
                            Lighting.Max = 3
                            Lighting.Rounding = 2
                            line = 1
                            Lighting.Default = 1
                            visited = iterator
                            x = iterator.AddSlider
                        else
                            progress, Players = 862, triangle.c(Players(sum))
                        end
                    else
                        progress = j <= 0 and 437 or 1000 or 1000
                    end
                elseif progress <= 893 then
                    if progress < 864 then
                        if progress >= 834 then
                            if progress >= 844 then
                                if progress > 844 then
                                    entry, Players, sum = entry(triangle.d(Players))
                                    entry, Players, sum = triangle.b(entry, Players, sum)
                                    delta, playerIdentifier = entry(Players, sum)
                                    sum = delta
                                    progress = delta == nil and 243 or 985 - progress
                                else
                                    x = x(visited, result, Lighting)
                                    result, visited, progress, x = triangle:ta({delta}), x, 1589 - progress, x.OnChanged
                                end
                            elseif progress <= 834 then
                                speed = speed(safeCall, j)
                                tweenInfo = {}
                                j = "MenuKeybind"
                                tweenInfo.Text = "Menu Key"
                                progress, tweenInfo.Default = 809, "End"
                                distance = true
                                tweenInfo.NoUI = true
                                speed, safeCall = speed.AddKeyPicker, speed
                            else
                                progress = 226800 / progress
                                speed(safeCall, j, tweenInfo)
                                j = "Fonts"
                                safeCall = current
                                speed = current.AddLeftGroupbox
                            end
                        elseif progress > 809 then
                            progress = 277
                            humanoid(currentTime, points)
                            humanoid = state[3]
                            currentTime = priority[3]
                            points = false
                        elseif progress > 798 then
                            progress = 679560 / progress
                            speed(safeCall, j, tweenInfo)
                            speed = heap[3].MenuKeybind
                            nearestDistance[3].ToggleKeybind = speed
                            tweenInfo = triangle:na({nearestDistance})
                            safeCall = index
                            j = "Unload"
                            speed = index.AddButton
                        else
                            humanoid = humanoid(currentTime, points)
                            currentTime = {[1] = 3, [3] = nil}
                            currentTime[2] = currentTime
                            progress = 340
                            points = {[1] = 3, [3] = nil}
                            points[2] = points
                            serialized = {[1] = 3, [3] = nil}
                            serialized[2] = serialized
                            rootPart = {[1] = 3, [3] = nil}
                            rootPart[2] = rootPart
                            count = {Text = "Custom Lighting", Flag = "wm_light", Default = false}
                            RunService = triangle:sa({attachment, state, points, rootPart, currentTime, serialized, deepCopy, _})
                            count.Callback = RunService
                            sourcePlayer = humanoid
                            main = humanoid.AddToggle
                        end
                    elseif progress < 881 then
                        if progress <= 865 then
                            if progress <= 864 then
                                visited()
                                result = nearestDistance[3]
                                Lighting = "modules loaded"
                                progress = 372
                                line = 3
                                visited = nearestDistance[3].Notify
                            else
                                progress, elapsed.A = 309670 / progress, current(index, speed, safeCall)
                                elapsed.B = nearestDistance[3].AccentColor
                                elapsed.Speed = 1
                                elapsed.Style = "wave"
                                playerIdentifier = elapsed
                                delta.Title = elapsed
                                elapsed = {}
                                current = Color3.new
                                index = 1
                                speed = 1
                                safeCall = 1
                            end
                        else
                            RunService(identifier, source)
                            source = {Text = "Whitelist"}
                            progress, sum, Players = 1094 - progress, "Teams", {}
                            Players[1] = "Teams"
                            entry = Players
                            source.Pages = Players
                            identifier = copy[3]
                            RunService = copy[3].AddTab
                        end
                    elseif progress > 884 then
                        progress = 720
                    elseif progress < 883 then
                        iterator(x, visited)
                        x, progress, iterator, visited = success, 667798 / progress, success.ApplyToTab, current
                    elseif progress > 883 then
                        progress = speed < safeCall and 117 or progress + -769
                    else
                        current, index, speed = current(index)
                        current, index, speed = triangle.b(current, index, speed)
                        safeCall, j = current(index, speed)
                        speed = safeCall
                        progress = safeCall == nil and 209 or 213686 / progress
                    end
                elseif progress > 969 then
                    if progress < 998 then
                        if progress < 985 then
                            progress, iterator = 517104 / progress, triangle.c(iterator(x, visited, result))
                        elseif progress > 985 then
                            delta(playerIdentifier)
                            delta = triangle:qa()
                            playerIdentifier = delta
                            elapsed = copy[3].Items
                            progress = elapsed and progress + -803 or 1049 - progress
                        else
                            progress = progress + -732
                            tweenInfo(distance, MAX_ITERATIONS)
                        end
                    elseif progress > 1000 then
                        source(entry, Players)
                        Players = {}
                        progress, Players.Text = 424, "Clear All"
                        sum = triangle:Y({player, smallest, nearestDistance})
                        Players.Callback = sum
                        source = identifier[3].AddButton
                        entry = identifier[3]
                    elseif progress > 998 then
                        progress = 115
                    else
                        RunService(identifier, source)
                        identifier = count[3]
                        progress = 878
                        source = false
                        RunService = state[3]
                    end
                elseif progress > 933 then
                    if progress > 965 then
                        frame = frame(ok, textLabel, hash)
                        line.Default = frame
                        progress = 298
                        result = x
                        visited = x.AddColorPicker
                    elseif progress <= 934 then
                        progress = 933
                        visited(result, Lighting)
                        visited = heap[3].subFx_colorB
                        Lighting = triangle:Ha({elapsed})
                        visited, result = visited.OnChanged, visited
                    else
                        progress, x = progress + -327, x(visited, result, Lighting)
                        x, result, visited = x.OnChanged, triangle:Ya({playerIdentifier}), x
                    end
                elseif progress > 924 then
                    progress = 262
                    visited(result, Lighting)
                    visited = resourceName.LoadAutoloadConfig
                    result = resourceName
                elseif progress >= 920 then
                    if progress <= 920 then
                        j.Position = tweenInfo(distance, MAX_ITERATIONS, iterator, x)
                        MAX_ITERATIONS = nearestDistance[3].AccentColor
                        j = {[1] = 3, [3] = 0}
                        j[2] = j
                        tweenInfo = {[1] = 3, [3] = 0}
                        tweenInfo[2] = tweenInfo
                        distance = {[1] = 3, [3] = 60}
                        distance[2] = distance
                        progress, MAX_ITERATIONS = 291, {[1] = 3, [3] = MAX_ITERATIONS}
                        MAX_ITERATIONS[2] = MAX_ITERATIONS
                        x = nearestDistance[3]
                        visited = start[3].RenderStepped
                        iterator = nearestDistance[3].Connect
                        result = triangle:Ma({j, tweenInfo, nearestDistance, startTime, distance, smallest, MAX_ITERATIONS, sum})
                    else
                        progress = 615
                        main(sourcePlayer, count)
                        count = {Title = "Graphics"}
                        RunService = "Right"
                        count.Side = "Right"
                        sourcePlayer = deltaZ
                        main = deltaZ.AddSection
                    end
                else
                    progress, source = 740, source(entry, Players)
                    bestDistance[3]["UI Settings"] = source
                    source = nil
                    Players = label[3].Holder
                    entry = ipairs
                    sum, Players = Players, Players.GetDescendants
                end
            until false
        end
    end,
    F = function(amount, gameProcessed)
        return function(fileHandle)
            gameProcessed[1][3].teamSettings.players.enabled = fileHandle
        end
    end,
    Qb = function(amount, _)
        return function(maximum, element)
            local label = 114
            while true do
                if label < 114 then
                    return
                elseif label <= 114 then
                    _[1][3].occludedColor = maximum
                    label = element ~= nil and 207 or 77 or 77
                else
                    label, _[1][3].occludedIntensity = label + -130, element
                end
            end
        end
    end,
    nd = function(entity, amount, duration, targetPlayer)
        entity.md[targetPlayer] = amount - duration
        return entity.md[targetPlayer]
    end,
    ab = function(amount, gameProcessed)
        return function()
            local label = 153
            local humanoidRootPart, offset, identifier, humanoid, deltaY, line, button
            repeat
                if label > 122 then
                    if label > 216 then
                        if label < 249 then
                            if label <= 219 then
                                button(humanoidRootPart)
                                button = table.clear
                                humanoid = gameProcessed[7][3]
                                label, humanoidRootPart = 463 - label, humanoid.Replicator.Actors
                            else
                                button(humanoidRootPart)
                                return
                            end
                        elseif label > 249 then
                            deltaY, line = button(humanoidRootPart, humanoid)
                            humanoid = deltaY
                            label = deltaY == nil and 172 or 85 or 85
                        else
                            label = 219
                            gameProcessed[1][3]._hasLoaded = false
                            button = table.clear
                            humanoidRootPart = gameProcessed[4][3]
                        end
                    elseif label >= 172 then
                        if label >= 186 then
                            if label > 186 then
                                button = gameProcessed[6][3]
                                label = button and 338 - label or 53784 / label
                            else
                                button(humanoidRootPart)
                                label, button = label + 63, nil
                                gameProcessed[6][3] = nil
                            end
                        else
                            humanoidRootPart = gameProcessed[2][3]
                            label = 87
                            button = table.clear
                        end
                    elseif label <= 153 then
                        gameProcessed[1][3]._hasLoaded = false
                        label = 19
                        button = ipairs
                        humanoidRootPart = gameProcessed[2][3]
                    else
                        label = 84
                        button(humanoidRootPart)
                        button = nil
                        gameProcessed[5][3] = nil
                    end
                elseif label <= 84 then
                    if label < 33 then
                        if label > 4 then
                            button, humanoidRootPart, humanoid = button(humanoidRootPart)
                            button, humanoidRootPart, humanoid = amount.b(button, humanoidRootPart, humanoid)
                            deltaY, line = button(humanoidRootPart, humanoid)
                            humanoid = deltaY
                            label = deltaY == nil and 3268 / label or 85 or 85
                        elseif label <= 1 then
                            button, humanoidRootPart, humanoid = button(humanoidRootPart)
                            button, humanoidRootPart, humanoid = amount.b(button, humanoidRootPart, humanoid)
                            deltaY, line = button(humanoidRootPart, humanoid)
                            humanoid = deltaY
                            label = deltaY == nil and 216 or 96 - label
                        else
                            button = gameProcessed[5][3]
                            humanoidRootPart, label, button = button, 165, button.Disconnect
                        end
                    elseif label >= 54 then
                        if label > 54 then
                            label, button, deltaY = 84 / label, pairs, gameProcessed[1][3]
                            humanoidRootPart = deltaY.objects
                        else
                            deltaY, line = button(humanoidRootPart, humanoid)
                            humanoid = deltaY
                            label = deltaY == nil and 216 or 95 or 95
                        end
                    else
                        label = 1782 / label
                        offset(identifier)
                        offset = gameProcessed[1][3].objects
                        identifier = nil
                        offset[deltaY] = nil
                    end
                elseif label > 87 then
                    if label <= 95 then
                        identifier, label, offset = line, 128 - label, gameProcessed[3][3]
                    else
                        button = gameProcessed[6][3]
                        label, humanoidRootPart, button = label + 64, button, button.Destroy
                    end
                elseif label < 86 then
                    label, offset, identifier = 7310 / label, line.Disconnect, line
                elseif label <= 86 then
                    label = label + 168
                    offset(identifier)
                else
                    button(humanoidRootPart)
                    button = gameProcessed[5][3]
                    label = button and label + -83 or 84 or 84
                end
            until false
        end
    end,
    sd = function(entity, amount, duration, targetPlayer)
        entity.pd[targetPlayer] = amount - entity.a(duration, 54135)
        return entity.pd[targetPlayer]
    end,
    Q = function(amount, gameProcessed)
        return function(newValue)
            gameProcessed[1][3].teamSettings.players.teamCheck = newValue
        end
    end,
    jc = function(amount, _)
        return function(object)
            _[1][3].offScreenArrowRadius = object
        end
    end,
    lc = function(amount, _)
        return function(vehicleEntity)
            _[1][3].skeletonColor = vehicleEntity
        end
    end,
    Nc = function(amount, _)
        return function(...)
            local label = 218
            local rootPart, humanoid, button
            repeat
                if label >= 218 then
                    humanoid = amount.c(...)
                    button = _[1][3]
                    label = 55
                    rootPart = _[2][3]
                else
                    button = table.pack(button(rootPart, amount.d(humanoid)))
                    return table.unpack(button, 1, button.n)
                end
            until false
        end
    end,
    Oa = function(amount, _)
        return function()
            local label = 154
            local button, humanoid, rootPart
            while true do
                if label <= 154 then
                    if label >= 80 then
                        if label <= 80 then
                            label, rootPart = 208, rootPart(humanoid)
                            humanoid = true
                            button = rootPart == true
                        else
                            rootPart = _[1][3]
                            label, humanoid, rootPart = 220, rootPart, rootPart.GetFocusedTextBox
                        end
                    elseif label <= 22 then
                        label = button and label + 5 or 208 or 208
                    else
                        rootPart = _[2][3]
                        rootPart, label, humanoid = rootPart.GetState, 80, rootPart
                    end
                elseif label >= 220 then
                    if label > 220 then
                        humanoid = nil
                        rootPart = _[2][3]
                        label, button = 4950 / label, rootPart ~= nil
                    else
                        rootPart = rootPart(humanoid)
                        humanoid = nil
                        button = rootPart == nil
                        label = button and 445 - label or 242 - label
                    end
                else
                    return button
                end
            end
        end
    end,
    qa = function(amount)
        return function(sourceString, pattern)
            local label = 118
            local offset, rootPart, line, deltaY, humanoid, _
            repeat
                if label > 137 then
                    if label <= 202 then
                        if label <= 183 then
                            if label <= 180 then
                                return deltaY
                            else
                                deltaY = not humanoid
                                label = deltaY and 253 - label or 117 or 117
                            end
                        else
                            line = line(offset)
                            deltaY = line
                            line.Name = pattern
                            line.Parent = humanoid
                            label = _ >= rootPart and 382 - label or 118 or 118
                        end
                    else
                        deltaY = deltaY(line, offset)
                        line = not deltaY
                        label = line and 293 - label or 427 - label
                    end
                elseif label >= 117 then
                    if label < 118 then
                        line, label, offset, deltaY = humanoid, label + 130, pattern, humanoid.FindFirstChild
                    elseif label <= 118 then
                        humanoid = sourceString
                        _ = 247
                        rootPart = 52
                        label = sourceString and 137 or 183 or 183
                    else
                        label, humanoid = 25071 / label, sourceString.Instance
                    end
                elseif label <= 46 then
                    label, offset, line = 248 - label, "UIGradient", Instance.new
                else
                    return nil
                end
            until false
        end
    end,
    Ka = function(amount, _)
        return function(original)
            _[1][3].HitChance = original
        end
    end,
    eb = function(amount, gameProcessed)
        return function(targetPlayer, pattern, duration)
            local label = 163
            local deltaY, offset, line
            while true do
                if label <= 165 then
                    if label <= 163 then
                        if label > 51 then
                            label = 206
                            line = pattern
                            deltaY = gameProcessed[1][3]
                        else
                            label, offset = 8415 / label, deltaY
                        end
                    else
                        targetPlayer.Color = offset
                        targetPlayer.Transparency = line
                        targetPlayer.Visible = line > 0
                        return
                    end
                else
                    deltaY, line = deltaY(line)
                    offset = duration
                    label = duration and 33990 / label or 10506 / label
                end
            end
        end
    end,
    V = function(amount)
        return function() end
    end,
    ma = function(amount, _)
        return function(payload)
            _[1][3].MaxDistance = payload
        end
    end,
    Lb = function(amount, _)
        return function()
            local label = 154
            local humanoid, button, rootPart
            repeat
                if label <= 154 then
                    label = 161
                    humanoid = _[2][3]
                    button = _[1][3]
                    rootPart, button = button, button.GetTextBoundsAsync
                else
                    button = table.pack(button(rootPart, humanoid))
                    return table.unpack(button, 1, button.n)
                end
            until false
        end
    end,
    sa = function(amount, gameProcessed)
        return function(targetPlayer)
            local label = 221
            local humanoid, identifier, rootPart
            while true do
                if label <= 115 then
                    if label >= 72 then
                        if label > 72 then
                            rootPart(humanoid, identifier)
                            rootPart = not targetPlayer
                            label = rootPart and 16445 / label or label + -87
                        else
                            rootPart(humanoid, identifier)
                            label = 115
                            identifier = targetPlayer
                            humanoid = gameProcessed[4][3]
                        end
                    elseif label > 28 then
                        label = 233
                        rootPart(humanoid, identifier)
                        identifier = targetPlayer
                        humanoid = gameProcessed[3][3]
                    else
                        return
                    end
                elseif label >= 221 then
                    if label > 221 then
                        label = 72
                        rootPart(humanoid, identifier)
                        humanoid = gameProcessed[6][3]
                    else
                        gameProcessed[1][3].light.enabled = targetPlayer
                        rootPart = gameProcessed[2][3]
                        label = 63
                        humanoid = gameProcessed[5][3]
                    end
                    identifier = targetPlayer
                else
                    rootPart = gameProcessed[7][3]
                    identifier = gameProcessed[8][3]
                    rootPart.Brightness = identifier.Brightness
                    rootPart.ExposureCompensation = identifier.ExposureCompensation
                    label, rootPart.EnvironmentDiffuseScale = 171 - label, identifier.EnvironmentDiffuseScale
                    humanoid = identifier.EnvironmentSpecularScale
                    rootPart.EnvironmentSpecularScale = humanoid
                end
            end
        end
    end,
    Ub = function(amount, gameProcessed)
        return function(targetPlayer, yCoordinate)
            local label = 172
            local identifier, humanoid, line
            while true do
                if label < 189 then
                    if label <= 114 then
                        humanoid(identifier, line)
                        return
                    else
                        label = 211
                        line = "boxColor"
                        identifier = gameProcessed[2][3]
                        humanoid = gameProcessed[1][3]
                    end
                elseif label > 193 then
                    label, humanoid = label + -18, humanoid(identifier, line)
                    identifier = targetPlayer
                    line = yCoordinate
                elseif label > 189 then
                    label = 189
                    humanoid(identifier, line)
                    humanoid = gameProcessed[1][3]
                    identifier = gameProcessed[2][3]
                    line = "box3dColor"
                else
                    label, humanoid = 114, humanoid(identifier, line)
                    identifier = targetPlayer
                    line = yCoordinate
                end
            end
        end
    end,
    Ia = function(amount, _)
        return function()
            local label = 213
            local button, rootPart, humanoid
            while true do
                if label <= 213 then
                    if label <= 167 then
                        button(rootPart, humanoid)
                        return
                    else
                        button = _[1][3]
                        label = 222
                        rootPart = _[2][3]
                        humanoid = _[4][3].Title
                    end
                else
                    button(rootPart, humanoid)
                    label, humanoid, rootPart = label + -55, _[4][3], _[3][3]
                    humanoid = humanoid.Sub
                end
            end
        end
    end,
    Aa = function(amount, gameProcessed)
        return function(targetPlayer)
            local label = 150
            local rootPart, humanoid, identifier
            while true do
                if label > 150 then
                    identifier = gameProcessed[4][3]
                    rootPart = gameProcessed[3][3]
                    humanoid = identifier.ClockTime
                    label, rootPart.ClockTime = 43, humanoid
                elseif label < 91 then
                    return
                elseif label <= 91 then
                    rootPart(humanoid, identifier)
                    rootPart = not targetPlayer
                    label = rootPart and 273 - label or 134 - label
                else
                    label, gameProcessed[1][3].time.enabled = 91, targetPlayer
                    identifier = targetPlayer
                    humanoid = gameProcessed[5][3]
                    rootPart = gameProcessed[2][3]
                end
            end
        end
    end,
    Dc = function(triangle, gameProcessed)
        return function()
            local total = 81
            local _, label, rootPart, textLabel, line, deltaY, humanoid, nearestDistance, point, humanoidRootPart, deltaZ, start, identifier, Lighting
            repeat
                if total < 154 then
                    if total < 75 then
                        if total < 43 then
                            humanoidRootPart = table.pack(humanoidRootPart(nearestDistance, deltaY, deltaZ))
                            return table.unpack(humanoidRootPart, 1, humanoidRootPart.n)
                        elseif total <= 43 then
                            deltaZ.Suffix = start
                            humanoidRootPart, total, nearestDistance = humanoidRootPart.AddSlider, 24, humanoidRootPart
                        else
                            deltaZ.Rounding = start
                            identifier = gameProcessed[1][3]
                            start = identifier.Suffix
                            total = start and 43 or total + 96
                        end
                    elseif total >= 95 then
                        if total <= 95 then
                            line = 180
                            total = humanoidRootPart and total + 76 or 221 or 221
                        else
                            humanoidRootPart = false
                            total = total + 102
                        end
                    elseif total > 75 then
                        point = 31
                        textLabel = 61
                        Lighting = tonumber
                        humanoid = 142
                        label = 54
                        total = 75
                        humanoidRootPart = gameProcessed[1][3].Default
                    else
                        Lighting = Lighting(humanoidRootPart)
                        total = Lighting and 125 or 208 or 208
                    end
                elseif total <= 216 then
                    if total < 173 then
                        if total <= 154 then
                            total, start = 197 - total, ""
                        else
                            total = 221
                            humanoidRootPart = gameProcessed[1][3]
                            Lighting = humanoidRootPart.Max
                        end
                    elseif total > 208 then
                        deltaZ.Default = start(identifier, _, rootPart)
                        identifier = gameProcessed[1][3]
                        start = identifier.Rounding
                        total = start and total + -158 or 173 or 173
                    elseif total > 173 then
                        humanoidRootPart = gameProcessed[1][3]
                        Lighting = humanoidRootPart.Min
                        total = label >= point and 333 - total or 173 or 173
                    else
                        start = 0
                        total = line < 0 and 125 or total + -115
                    end
                elseif total > 227 then
                    nearestDistance = nearestDistance(deltaY)
                    deltaZ = math
                    deltaY = math.huge
                    humanoidRootPart = nearestDistance == deltaY
                    total = textLabel > humanoid and 466 - total or 340 - total
                elseif total <= 221 then
                    humanoidRootPart = gameProcessed[2][3]
                    deltaY = gameProcessed[1][3].Flag
                    deltaZ = {}
                    identifier = gameProcessed[1][3]
                    deltaZ.Text = identifier.Text
                    total, deltaZ.Min = 47736 / total, identifier.Min
                    deltaZ.Max = identifier.Max
                    identifier = Lighting
                    rootPart = gameProcessed[1][3]
                    start = math.clamp
                    _, rootPart = rootPart.Min, rootPart.Max
                else
                    total = 245
                    deltaY = Lighting
                    nearestDistance = math.abs
                end
            until false
        end
    end,
    Pb = function(amount, _)
        return function(depth, expectedType)
            local label = 123
            while true do
                if label < 170 then
                    _[1][3].visibleColor = depth
                    label = expectedType ~= nil and 222 or 170 or 170
                elseif label <= 170 then
                    return
                else
                    label, _[1][3].visibleIntensity = 170, expectedType
                end
            end
        end
    end,
    na = function(amount, _)
        return function()
            local label = 206
            local identifier, button
            while true do
                if label <= 206 then
                    button = _[1][3]
                    label, button, identifier = 229, button.Unload, button
                else
                    button(identifier)
                    return
                end
            end
        end
    end,
    Ob = function(amount, _)
        return function(action)
            _[1][3].tracerOutline = action
        end
    end,
    Bc = function(amount, _)
        return function(targetPlayer)
            local label = 187
            local rootPart, humanoid
            while true do
                if label < 129 then
                    rootPart(humanoid)
                    label, rootPart = label + 100, _[2][3]
                elseif label <= 129 then
                    rootPart()
                    return
                else
                    humanoid = targetPlayer
                    label = 29
                    rootPart = _[1][3]
                end
            end
        end
    end,
    c = function(...)
        return {[1] = {...}, [2] = select("#", ...),}
    end,
    S = function(amount, gameProcessed)
        return function(targetPlayer)
            local label = 163
            local humanoid, rootPart, identifier
            repeat
                if label <= 163 then
                    if label > 153 then
                        label = 175
                        gameProcessed[1][3].fog.enabled = targetPlayer
                        rootPart = gameProcessed[2][3]
                        humanoid = gameProcessed[5][3]
                        identifier = targetPlayer
                    elseif label < 150 then
                        rootPart = gameProcessed[4][3]
                        identifier = gameProcessed[7][3]
                        rootPart.FogStart = identifier.FogStart
                        rootPart.FogEnd = identifier.FogEnd
                        label = 150
                        humanoid = identifier.FogColor
                        rootPart.FogColor = humanoid
                    elseif label > 150 then
                        rootPart(humanoid, identifier)
                        identifier = targetPlayer
                        label = 230
                        humanoid = gameProcessed[6][3]
                    else
                        return
                    end
                elseif label <= 175 then
                    label = 153
                    rootPart(humanoid, identifier)
                    identifier = targetPlayer
                    humanoid = gameProcessed[3][3]
                else
                    rootPart(humanoid, identifier)
                    rootPart = not targetPlayer
                    label = rootPart and 26220 / label or 150 or 150
                end
            until false
        end
    end,
    p = function(amount, gameProcessed)
        return function(fileHandle)
            gameProcessed[1][3].teamSettings.npc.enabled = fileHandle
        end
    end,
    Da = function(amount)
        return function(targetPlayer, yCoordinate, duration)
            local label = 218
            local offset, line, deltaY, identifier
            repeat
                if label <= 218 then
                    if label <= 166 then
                        line(offset, identifier)
                        return deltaY
                    else
                        offset = duration
                        deltaY = yCoordinate.Connect
                        label = 220
                        line = yCoordinate
                    end
                else
                    deltaY = deltaY(line, offset)
                    line, identifier, label, offset = targetPlayer.GiveSignal, deltaY, 36520 / label, targetPlayer
                end
            until false
        end
    end,
    dc = function(amount, _)
        return function(reason)
            _[1][3].nameType = reason
        end
    end,
    K = function(triangle, gameProcessed)
        return function(chunk, pattern)
            local progress = 83
            local label, textLabel, line, total, attachment, heap, _, rootPart, deltaZ, point, button, deltaY, bestDistance, Lighting, humanoid, Scheduler, offset, nearestDistance, identifier
            while true do
                if progress > 130 then
                    if progress < 211 then
                        if progress > 169 then
                            if progress >= 193 then
                                if progress > 201 then
                                    if progress <= 203 then
                                        progress, line = 22533 / progress, triangle.c(line(Scheduler, total))
                                    else
                                        textLabel(attachment, bestDistance)
                                        bestDistance = {Title = "Tracer & Arrow"}
                                        offset = "Right"
                                        progress, bestDistance.Side = 137, "Right"
                                        attachment = chunk
                                        textLabel = chunk.AddSection
                                    end
                                elseif progress < 200 then
                                    attachment(bestDistance, offset)
                                    offset = {Text = "Tracer Color"}
                                    progress = 90
                                    offset.Flag = heap .. "tracerColor"
                                    Lighting = gameProcessed[3][3]
                                    line = nearestDistance[3]
                                    Scheduler = "tracerColor"
                                elseif progress > 200 then
                                    label = label(point, textLabel)
                                    attachment = {Text = "Skeleton"}
                                    offset = "skeleton"
                                    attachment.Flag = heap .. "skeleton"
                                    progress, attachment.Default = 69, false
                                    bestDistance = triangle:_c({deltaZ})
                                    attachment.Callback = bestDistance
                                    point = label.AddToggle
                                    textLabel = label
                                else
                                    point.Default = textLabel(attachment, bestDistance)
                                    progress, offset, bestDistance, Lighting, textLabel, attachment =
                                        325 - progress, nearestDistance[3], gameProcessed[3][3], "boxOutlineColor", select, 2
                                end
                            elseif progress >= 187 then
                                if progress > 190 then
                                    point.Transparency = textLabel(attachment, triangle.d(bestDistance))
                                    progress = 163
                                    bestDistance = "boxOutlineColor"
                                    textLabel = gameProcessed[4][3]
                                    attachment = nearestDistance[3]
                                elseif progress > 187 then
                                    attachment(bestDistance, offset)
                                    offset = {Text = "Tracer Origin", Flag = heap .. "tracer_origin",}
                                    total = "Middle"
                                    humanoid = "Bottom"
                                    Scheduler = "Top"
                                    line = {}
                                    line[1], line[2], line[3] = "Top", "Middle", "Bottom"
                                    offset.Options = line
                                    offset.Default = nearestDistance[3].tracerOrigin
                                    Lighting = triangle:oc({nearestDistance})
                                    offset.Callback = Lighting
                                    attachment = textLabel.AddDropdown
                                    progress = 193
                                    bestDistance = textLabel
                                else
                                    progress, bestDistance = 238, triangle.c(bestDistance(offset, Lighting))
                                end
                            elseif progress > 172 then
                                label(point, textLabel)
                                textLabel = {Text = "Health Bar Outline"}
                                bestDistance = "healthBarOutline"
                                textLabel.Flag = heap .. "healthBarOutline"
                                textLabel.Default = nearestDistance[3].healthBarOutline
                                progress, attachment = 44704 / progress, triangle:Wb({nearestDistance})
                                textLabel.Callback = attachment
                                point = button
                                label = button.AddToggle
                            else
                                textLabel(attachment, bestDistance)
                                bestDistance = {Text = "Distance Outline"}
                                Lighting = "distanceOutline"
                                progress, bestDistance.Flag = progress + 34, heap .. "distanceOutline"
                                bestDistance.Default = nearestDistance[3].distanceOutline
                                offset = triangle:nc({nearestDistance})
                                bestDistance.Callback = offset
                                attachment = point
                                textLabel = point.AddToggle
                            end
                        elseif progress > 152 then
                            if progress <= 163 then
                                if progress >= 158 then
                                    if progress <= 158 then
                                        progress, textLabel.Transparency = 75, attachment(bestDistance, triangle.d(offset))
                                        offset = "healthTextColor"
                                        attachment = gameProcessed[4][3]
                                        bestDistance = nearestDistance[3]
                                    else
                                        progress, textLabel = 39935 / progress, textLabel(attachment, bestDistance)
                                        point.Callback = textLabel
                                        button = rootPart.AddColorPicker
                                        label = rootPart
                                    end
                                else
                                    progress, textLabel = 23864 / progress, textLabel(attachment, triangle.d(bestDistance))
                                    point.Transparency = textLabel
                                    bestDistance = "boxFillColor"
                                    textLabel = gameProcessed[4][3]
                                    attachment = nearestDistance[3]
                                end
                            elseif progress > 168 then
                                button = button(label, point)
                                textLabel = {Text = "Health Bar"}
                                bestDistance = "healthBar"
                                textLabel.Flag = heap .. "healthBar"
                                progress = 108
                                textLabel.Default = nearestDistance[3].healthBar
                                attachment = triangle:fc({nearestDistance})
                                textLabel.Callback = attachment
                                label = button.AddToggle
                                point = button
                            else
                                textLabel.Default = attachment(bestDistance, offset)
                                progress = 130
                                bestDistance = nearestDistance[3]
                                offset = "dyingColor"
                                attachment = gameProcessed[4][3]
                            end
                        elseif progress >= 146 then
                            if progress > 149 then
                                progress, textLabel = 65, textLabel(attachment, bestDistance)
                                point.Callback = textLabel
                                button = rootPart.AddColorPicker
                                label = rootPart
                            elseif progress <= 146 then
                                progress, Lighting = 4526 / progress, Lighting(line, Scheduler)
                                offset.Default = Lighting
                                Lighting = select
                                humanoid = "offScreenArrowColor"
                                line = 2
                                Scheduler = gameProcessed[3][3]
                                total = nearestDistance[3]
                            else
                                label(point, textLabel)
                                textLabel = {Title = "Skeleton"}
                                attachment = "Left"
                                textLabel.Side = "Left"
                                point = chunk
                                progress = 201
                                label = chunk.AddSection
                            end
                        elseif progress > 137 then
                            progress, Scheduler = progress + -122, triangle.c(Scheduler(total, humanoid))
                        elseif progress > 136 then
                            textLabel = textLabel(attachment, bestDistance)
                            offset = {Text = "Tracer"}
                            line = "tracer"
                            progress, offset.Flag = 190, heap .. "tracer"
                            offset.Default = nearestDistance[3].tracer
                            Lighting = triangle:Tb({nearestDistance})
                            offset.Callback = Lighting
                            attachment = textLabel.AddToggle
                            bestDistance = textLabel
                        else
                            progress, line = progress + -20, triangle.c(line(Scheduler, total))
                        end
                    elseif progress <= 238 then
                        if progress <= 228 then
                            if progress >= 225 then
                                if progress > 226 then
                                    progress, offset = 136, offset(Lighting, line)
                                    bestDistance.Default = offset
                                    Lighting = 2
                                    offset = select
                                    line = gameProcessed[3][3]
                                    total = "nameColor"
                                    Scheduler = nearestDistance[3]
                                elseif progress > 225 then
                                    bestDistance.Default = offset(Lighting, line)
                                    progress, Lighting, Scheduler, total, offset, line =
                                        progress + -98, 2, nearestDistance[3], "distanceColor", select, gameProcessed[3][3]
                                else
                                    progress, offset = 172, offset(Lighting, line)
                                    bestDistance.Callback = offset
                                    attachment = point
                                    textLabel = point.AddColorPicker
                                end
                            elseif progress > 212 then
                                textLabel(attachment, bestDistance)
                                bestDistance = {Text = "Name Outline"}
                                Lighting = "nameOutline"
                                progress, bestDistance.Flag = 212, heap .. "nameOutline"
                                bestDistance.Default = nearestDistance[3].nameOutline
                                offset = triangle:Xb({nearestDistance})
                                bestDistance.Callback = offset
                                textLabel = point.AddToggle
                                attachment = point
                            elseif progress <= 211 then
                                rootPart = rootPart(button, label)
                                point = {}
                                progress, point.Text = 53, "Box"
                                attachment = "box"
                                point.Flag = heap .. "box"
                                point.Default = false
                                textLabel = triangle:Yb({identifier, _})
                                point.Callback = textLabel
                                label = rootPart
                                button = rootPart.AddToggle
                            else
                                textLabel(attachment, bestDistance)
                                textLabel = "players"
                                progress = pattern == "players" and 52 or 71 or 71
                            end
                        elseif progress < 235 then
                            if progress <= 230 then
                                point.Default = textLabel(attachment, bestDistance)
                                attachment = 2
                                textLabel = select
                                Lighting = "boxColor"
                                bestDistance = gameProcessed[3][3]
                                progress = 187
                                offset = nearestDistance[3]
                            else
                                offset = offset(Lighting, line)
                                bestDistance.Callback = offset
                                progress, attachment, textLabel = progress + -17, point, point.AddColorPicker
                            end
                        elseif progress > 237 then
                            progress, point.Transparency = 47, textLabel(attachment, triangle.d(bestDistance))
                            textLabel = triangle:Ub({gameProcessed[4], nearestDistance,})
                            point.Callback = textLabel
                            button = rootPart.AddColorPicker
                            label = rootPart
                        elseif progress > 235 then
                            progress, textLabel = progress + -144, textLabel(attachment, bestDistance)
                            point.Default = textLabel
                            textLabel = select
                            offset = nearestDistance[3]
                            bestDistance = gameProcessed[3][3]
                            attachment = 2
                            Lighting = "boxFillColor"
                        else
                            textLabel(attachment, bestDistance)
                            bestDistance = {Text = "Name Type"}
                            progress, offset = progress + 16, heap .. "name_type"
                            bestDistance.Flag = offset
                            Scheduler = "Display Name"
                            Lighting = {}
                            line = "Name"
                            Lighting[1], Lighting[2] = "Name", "Display Name"
                            bestDistance.Options = Lighting
                            bestDistance.Default = "Name"
                            offset = triangle:dc({deltaZ})
                            bestDistance.Callback = offset
                            textLabel = point.AddDropdown
                            attachment = point
                        end
                    elseif progress < 248 then
                        if progress >= 245 then
                            if progress <= 246 then
                                if progress <= 245 then
                                    button(label, point)
                                    point = {Text = "Box Fill"}
                                    attachment = "boxFill"
                                    point.Flag = heap .. "boxFill"
                                    progress, point.Default = progress + -143, nearestDistance[3].boxFill
                                    textLabel = triangle:Vb({nearestDistance})
                                    point.Callback = textLabel
                                    button = rootPart.AddToggle
                                    label = rootPart
                                else
                                    attachment(bestDistance, offset)
                                    offset = {Text = "Arrow Radius"}
                                    line = "arrow_radius"
                                    offset.Flag = heap .. "arrow_radius"
                                    offset.Min = 50
                                    offset.Max = 400
                                    progress, offset.Default = 325 - progress, nearestDistance[3].offScreenArrowRadius
                                    offset.Suffix = "px"
                                    Lighting = triangle:jc({nearestDistance})
                                    offset.Callback = Lighting
                                    bestDistance = textLabel
                                    attachment = textLabel.AddSlider
                                end
                            else
                                progress, textLabel.Default = 59, attachment(bestDistance, offset)
                                line = "healthTextColor"
                                Lighting = nearestDistance[3]
                                bestDistance = 2
                                offset = gameProcessed[3][3]
                                attachment = select
                            end
                        elseif progress > 242 then
                            progress = 24
                            attachment(bestDistance, offset)
                            offset = {Text = "Tracer Outline"}
                            line = "tracerOutline"
                            offset.Flag = heap .. "tracerOutline"
                            offset.Default = nearestDistance[3].tracerOutline
                            Lighting = triangle:Ob({nearestDistance})
                            offset.Callback = Lighting
                            attachment = textLabel.AddToggle
                            bestDistance = textLabel
                        else
                            textLabel(attachment, bestDistance)
                            bestDistance = {}
                            progress, bestDistance.Text = 259 - progress, "Weapon Outline"
                            Lighting = "weaponOutline"
                            bestDistance.Flag = heap .. "weaponOutline"
                            bestDistance.Default = nearestDistance[3].weaponOutline
                            offset = triangle:Sb({nearestDistance})
                            bestDistance.Callback = offset
                            attachment = point
                            textLabel = point.AddToggle
                        end
                    elseif progress > 251 then
                        if progress > 252 then
                            label(point, textLabel)
                            textLabel = {Text = "Health Text"}
                            bestDistance = "healthText"
                            textLabel.Flag = heap .. "healthText"
                            progress, textLabel.Default = 378 - progress, nearestDistance[3].healthText
                            attachment = triangle:pc({nearestDistance})
                            textLabel.Callback = attachment
                            point = button
                            label = button.AddToggle
                        else
                            progress, offset = 225, offset(Lighting, triangle.d(line))
                            bestDistance.Transparency = offset
                            offset = gameProcessed[4][3]
                            line = "distanceColor"
                            Lighting = nearestDistance[3]
                        end
                    elseif progress > 249 then
                        textLabel(attachment, bestDistance)
                        progress, bestDistance, offset = progress + -23, {}, "Name Color"
                        bestDistance.Text = "Name Color"
                        bestDistance.Flag = heap .. "nameColor"
                        offset = gameProcessed[3][3]
                        Lighting = nearestDistance[3]
                        line = "nameColor"
                    elseif progress <= 248 then
                        bestDistance(offset, Lighting)
                        return
                    else
                        label(point, textLabel)
                        textLabel = {}
                        progress, textLabel.Text = 149, "Health Text Outline"
                        bestDistance = "healthTextOutline"
                        textLabel.Flag = heap .. "healthTextOutline"
                        textLabel.Default = nearestDistance[3].healthTextOutline
                        attachment = triangle:kc({nearestDistance})
                        textLabel.Callback = attachment
                        label = button.AddToggle
                        point = button
                    end
                elseif progress < 83 then
                    if progress <= 47 then
                        if progress < 19 then
                            if progress > 13 then
                                if progress <= 15 then
                                    attachment(bestDistance, offset)
                                    offset = {Title = "Chams"}
                                    Lighting = "Right"
                                    offset.Side = "Right"
                                    progress = 36
                                    bestDistance = chunk
                                    attachment = chunk.AddSection
                                else
                                    progress = 71
                                    textLabel(attachment, bestDistance)
                                end
                            elseif progress >= 10 then
                                if progress > 10 then
                                    textLabel(attachment, bestDistance)
                                    bestDistance = {Text = "Distance Color"}
                                    progress, offset = 239 - progress, heap .. "distanceColor"
                                    bestDistance.Flag = offset
                                    line = "distanceColor"
                                    offset = gameProcessed[3][3]
                                    Lighting = nearestDistance[3]
                                else
                                    progress, attachment = 94 - progress, attachment(bestDistance, offset)
                                    textLabel.Default = attachment
                                    bestDistance = nearestDistance[3]
                                    offset = "healthyColor"
                                    attachment = gameProcessed[4][3]
                                end
                            else
                                Lighting = Lighting(line, Scheduler)
                                offset.Callback = Lighting
                                attachment, progress, bestDistance = textLabel.AddColorPicker, progress + 242, textLabel
                            end
                        elseif progress <= 31 then
                            if progress < 24 then
                                if progress <= 19 then
                                    button(label, point)
                                    point = {Text = "Outline Color"}
                                    progress, point.Flag = progress + 181, heap .. "boxOutlineColor"
                                    attachment = nearestDistance[3]
                                    bestDistance = "boxOutlineColor"
                                    textLabel = gameProcessed[3][3]
                                else
                                    progress, Lighting = 1, Lighting(line, triangle.d(Scheduler))
                                    offset.Transparency = Lighting
                                    Scheduler = "tracerColor"
                                    line = nearestDistance[3]
                                    Lighting = gameProcessed[4][3]
                                end
                            elseif progress > 24 then
                                progress, Scheduler = 3007 / progress, triangle.c(Scheduler(total, humanoid))
                            else
                                progress = progress + 89
                                attachment(bestDistance, offset)
                                offset = {Text = "Off Screen Arrow"}
                                line = "offScreenArrow"
                                offset.Flag = heap .. "offScreenArrow"
                                offset.Default = nearestDistance[3].offScreenArrow
                                Lighting = triangle:ac({nearestDistance})
                                offset.Callback = Lighting
                                bestDistance = textLabel
                                attachment = textLabel.AddToggle
                            end
                        elseif progress <= 36 then
                            attachment = attachment(bestDistance, offset)
                            Lighting = {Text = "Chams"}
                            Scheduler = "cs2_chams"
                            progress = 94
                            Lighting.Flag = heap .. "cs2_chams"
                            Lighting.Default = false
                            line = triangle:Rb({deltaY})
                            Lighting.Callback = line
                            offset = attachment
                            bestDistance = attachment.AddToggle
                        else
                            button(label, point)
                            point = {Text = "Box Outline"}
                            attachment = "boxOutline"
                            point.Flag = heap .. "boxOutline"
                            point.Default = nearestDistance[3].boxOutline
                            textLabel = triangle:cc({nearestDistance})
                            progress, point.Callback = progress + -28, textLabel
                            label = rootPart
                            button = rootPart.AddToggle
                        end
                    elseif progress <= 65 then
                        if progress <= 59 then
                            if progress > 57 then
                                progress, offset = 158, triangle.c(offset(Lighting, line))
                            elseif progress < 53 then
                                bestDistance = {}
                                progress, bestDistance.Text = 57, "Weapon"
                                Lighting = "weapon"
                                bestDistance.Flag = heap .. "weapon"
                                bestDistance.Default = nearestDistance[3].weapon
                                offset = triangle:ec({nearestDistance})
                                bestDistance.Callback = offset
                                attachment = point
                                textLabel = point.AddToggle
                            elseif progress <= 53 then
                                button(label, point)
                                point = {Text = "Box Type", Flag = heap .. "box_type",}
                                attachment = {}
                                bestDistance = "2D"
                                offset = "3D"
                                attachment[1], attachment[2] = "2D", "3D"
                                point.Options = attachment
                                progress, textLabel = progress + 73, "2D"
                                point.Default = "2D"
                                textLabel = triangle:hc({identifier, _})
                                point.Callback = textLabel
                                button = rootPart.AddDropdown
                                label = rootPart
                            else
                                textLabel(attachment, bestDistance)
                                progress, bestDistance, offset = progress + 49, {}, "Weapon Color"
                                bestDistance.Text = "Weapon Color"
                                bestDistance.Flag = heap .. "weaponColor"
                                line = "weaponColor"
                                offset = gameProcessed[3][3]
                                Lighting = nearestDistance[3]
                            end
                        elseif progress > 60 then
                            button(label, point)
                            point = {Title = "Health"}
                            progress, textLabel = 10985 / progress, "Left"
                            point.Side = "Left"
                            label = chunk
                            button = chunk.AddSection
                        else
                            label(point, textLabel)
                            textLabel = {Text = "Dying Color"}
                            progress, textLabel.Flag = 168, heap .. "dyingColor"
                            attachment = gameProcessed[3][3]
                            bestDistance = nearestDistance[3]
                            offset = "dyingColor"
                        end
                    elseif progress < 75 then
                        if progress <= 69 then
                            point(textLabel, attachment)
                            attachment = {Text = "Skeleton Color"}
                            offset = "skeleton_color"
                            attachment.Flag = heap .. "skeleton_color"
                            attachment.Default = deltaZ[3].skeletonColor
                            bestDistance = triangle:lc({deltaZ})
                            progress, attachment.Callback = 85, bestDistance
                            point = label.AddColorPicker
                            textLabel = label
                        else
                            bestDistance = {}
                            progress, bestDistance.Text = 923 / progress, "Distance"
                            Lighting = "distance"
                            bestDistance.Flag = heap .. "distance"
                            bestDistance.Default = nearestDistance[3].distance
                            offset = triangle:gc({nearestDistance})
                            bestDistance.Callback = offset
                            attachment = point
                            textLabel = point.AddToggle
                        end
                    elseif progress <= 75 then
                        attachment = attachment(bestDistance, offset)
                        progress, textLabel.Callback = 249, attachment
                        point = button
                        label = button.AddColorPicker
                    else
                        attachment(bestDistance, offset)
                        progress = 146
                        offset = {Text = "Arrow Color", Flag = heap .. "offScreenArrowColor",}
                        line = nearestDistance[3]
                        Scheduler = "offScreenArrowColor"
                        Lighting = gameProcessed[3][3]
                    end
                elseif progress > 106 then
                    if progress <= 124 then
                        if progress < 116 then
                            if progress < 111 then
                                label(point, textLabel)
                                progress = 10
                                textLabel = {Text = "Healthy Color", Flag = heap .. "healthyColor",}
                                bestDistance = nearestDistance[3]
                                attachment = gameProcessed[3][3]
                                offset = "healthyColor"
                            elseif progress <= 111 then
                                progress, offset = 123, offset(Lighting, triangle.d(line))
                                bestDistance.Transparency = offset
                                Lighting = nearestDistance[3]
                                line = "weaponColor"
                                offset = gameProcessed[4][3]
                            else
                                attachment(bestDistance, offset)
                                offset = {Text = "Arrow Size"}
                                progress, line = progress + 133, "arrow_size"
                                offset.Flag = heap .. "arrow_size"
                                offset.Min = 5
                                offset.Max = 40
                                offset.Default = nearestDistance[3].offScreenArrowSize
                                offset.Suffix = "px"
                                Lighting = triangle:ic({nearestDistance})
                                offset.Callback = Lighting
                                bestDistance = textLabel
                                attachment = textLabel.AddSlider
                            end
                        elseif progress > 123 then
                            progress = 247
                            label(point, textLabel)
                            textLabel = {Text = "Text Color", Flag = heap .. "healthTextColor",}
                            bestDistance = nearestDistance[3]
                            offset = "healthTextColor"
                            attachment = gameProcessed[3][3]
                        elseif progress <= 116 then
                            bestDistance.Transparency = offset(Lighting, triangle.d(line))
                            line = "nameColor"
                            Lighting = nearestDistance[3]
                            progress = 234
                            offset = gameProcessed[4][3]
                        else
                            offset = offset(Lighting, line)
                            bestDistance.Callback = offset
                            textLabel, progress, attachment = point.AddColorPicker, 29766 / progress, point
                        end
                    elseif progress <= 128 then
                        if progress >= 126 then
                            if progress <= 126 then
                                button(label, point)
                                point = {}
                                progress, point.Text = 230, "Box Color"
                                point.Flag = heap .. "boxColor"
                                attachment = nearestDistance[3]
                                textLabel = gameProcessed[3][3]
                                bestDistance = "boxColor"
                            else
                                progress, line = 380 - progress, triangle.c(line(Scheduler, total))
                            end
                        else
                            progress, bestDistance = 192, triangle.c(bestDistance(offset, Lighting))
                        end
                    else
                        attachment = attachment(bestDistance, offset)
                        textLabel.Callback = attachment
                        progress, label, point = 22880 / progress, button.AddColorPicker, button
                    end
                elseif progress >= 94 then
                    if progress >= 102 then
                        if progress > 105 then
                            progress, offset = 21518 / progress, offset(Lighting, line)
                            bestDistance.Default = offset
                            Scheduler = nearestDistance[3]
                            Lighting = 2
                            line = gameProcessed[3][3]
                            total = "weaponColor"
                            offset = select
                        elseif progress <= 102 then
                            button(label, point)
                            point = {Text = "Fill Color"}
                            progress = 237
                            point.Flag = heap .. "boxFillColor"
                            bestDistance = "boxFillColor"
                            textLabel = gameProcessed[3][3]
                            attachment = nearestDistance[3]
                        else
                            bestDistance(offset, Lighting)
                            Lighting = {Text = "Occluded (Ghost)"}
                            Scheduler = "cs2_occluded"
                            Lighting.Flag = heap .. "cs2_occluded"
                            Lighting.Default = deltaY[3].occludedColor
                            Lighting.Transparency = deltaY[3].occludedIntensity
                            line = triangle:Qb({deltaY})
                            Lighting.Callback = line
                            bestDistance = attachment.AddColorPicker
                            progress = 248
                            offset = attachment
                        end
                    elseif progress > 95 then
                        offset.Transparency = Lighting(line, triangle.d(Scheduler))
                        line, Lighting, progress, Scheduler = nearestDistance[3], gameProcessed[4][3], 188 - progress, "offScreenArrowColor"
                    elseif progress <= 94 then
                        progress = 105
                        bestDistance(offset, Lighting)
                        Lighting = {Text = "Visible (Neon)"}
                        Scheduler = "cs2_visible"
                        Lighting.Flag = heap .. "cs2_visible"
                        Lighting.Default = deltaY[3].visibleColor
                        Lighting.Transparency = deltaY[3].visibleIntensity
                        line = triangle:Pb({deltaY})
                        Lighting.Callback = line
                        offset = attachment
                        bestDistance = attachment.AddColorPicker
                    else
                        point = point(textLabel, attachment)
                        bestDistance = {Text = "Name"}
                        Lighting = "name"
                        progress = 235
                        bestDistance.Flag = heap .. "name"
                        bestDistance.Default = nearestDistance[3].name
                        offset = triangle:mc({nearestDistance})
                        bestDistance.Callback = offset
                        textLabel = point.AddToggle
                        attachment = point
                    end
                elseif progress > 90 then
                    if progress <= 91 then
                        Lighting = Lighting(line, Scheduler)
                        progress, offset.Callback = 15, Lighting
                        attachment = textLabel.AddColorPicker
                        bestDistance = textLabel
                    else
                        progress, bestDistance = 157, triangle.c(bestDistance(offset, Lighting))
                    end
                elseif progress >= 85 then
                    if progress > 85 then
                        progress, Lighting = 12960 / progress, Lighting(line, Scheduler)
                        offset.Default = Lighting
                        total = nearestDistance[3]
                        line = 2
                        Lighting = select
                        Scheduler = gameProcessed[3][3]
                        humanoid = "tracerColor"
                    else
                        point(textLabel, attachment)
                        progress, attachment, bestDistance = 8075 / progress, {}, "Text"
                        attachment.Title = "Text"
                        bestDistance = "Right"
                        attachment.Side = "Right"
                        point = chunk.AddSection
                        textLabel = chunk
                    end
                elseif progress <= 83 then
                    nearestDistance = {[1] = 3, [3] = gameProcessed[1][3].teamSettings[pattern],}
                    nearestDistance[2] = nearestDistance
                    deltaY = {[1] = 3, [3] = gameProcessed[2][3][pattern],}
                    deltaY[2] = deltaY
                    progress = 211
                    deltaZ = {[1] = 3, [3] = gameProcessed[5][3][pattern],}
                    deltaZ[2] = deltaZ
                    heap = pattern .. "_"
                    _ = {enabled = false, kind = "2D"}
                    identifier = {[1] = 3, [3] = _}
                    identifier[2] = identifier
                    _ = {[1] = 3, [3] = _}
                    _[2] = _
                    _[3], label, point = triangle:bc({nearestDistance, identifier}), {}, "Boxes"
                    label.Title = "Boxes"
                    point = "Left"
                    label.Side = "Left"
                    rootPart = chunk.AddSection
                    button = chunk
                else
                    attachment = attachment(bestDistance, offset)
                    progress, textLabel.Callback = 5040 / progress, attachment
                    point = button
                    label = button.AddColorPicker
                end
            end
        end
    end,
    Db = function(amount, gameProcessed)
        return function()
            local identifier = gameProcessed[2][3]
            local rootPart = Enum.Technology[identifier]
            gameProcessed[1][3].Technology = rootPart
        end
    end,
    Hd = function(entity, amount, duration, targetPlayer)
        entity.yd[targetPlayer] = entity.a(amount, 35243) + entity.a(duration, 25031)
        return entity.yd[targetPlayer]
    end,
    ba = function(triangle, gameProcessed)
        return function(stack, pattern)
            local total = 50
            local _, textLabel, rootPart, button, nearestDistance, deltaZ, label, deltaY, identifier, start, point, humanoid
            while true do
                if total >= 76 then
                    if total < 122 then
                        if total < 106 then
                            if total <= 76 then
                                point = {Name = button}
                                total, textLabel = total + -71, {}
                                point.Groups = textLabel
                                label = point
                                point = table.insert
                                humanoid = label
                                textLabel = gameProcessed[5][3][nearestDistance]
                            else
                                total = 117
                                nearestDistance = pattern.Text
                            end
                        elseif total <= 110 then
                            if total > 106 then
                                start = table.pack(start(identifier))
                                return table.unpack(start, 1, start.n)
                            else
                                total = nearestDistance and 274 - total or 15 or 15
                            end
                        else
                            deltaY = {[1] = 3, [3] = gameProcessed[1][3][nearestDistance],}
                            deltaY[2] = deltaY
                            deltaZ = not deltaY[3]
                            total = deltaZ and 136 or 8190 / total
                        end
                    elseif total >= 168 then
                        if total >= 173 then
                            if total > 173 then
                                total, nearestDistance = 42000 / total, "World"
                            else
                                deltaY[3], total, deltaZ = deltaZ(start, identifier), 70, gameProcessed[1][3]
                                deltaZ[nearestDistance] = deltaY[3]
                                identifier = {}
                                deltaZ = gameProcessed[5][3]
                                start = identifier
                                deltaZ[nearestDistance] = identifier
                            end
                        else
                            total = nearestDistance and 19656 / total or 78 or 78
                        end
                    elseif total > 122 then
                        identifier = nearestDistance
                        deltaZ = gameProcessed[2][3]
                        start, total, deltaZ = deltaZ, 173, deltaZ.AddTab
                    else
                        point(textLabel, humanoid)
                        total, point = total + -66, triangle:sc({deltaY, gameProcessed[3], gameProcessed[6], gameProcessed[4], gameProcessed[7], gameProcessed[8],})
                        label.AddSection = point
                    end
                elseif total < 26 then
                    if total <= 5 then
                        if total >= 4 then
                            if total > 4 then
                                point(textLabel, humanoid)
                                total = 122
                                point = table.insert
                                humanoid = label
                                textLabel = deltaZ
                            else
                                total = 14 - total
                            end
                        else
                            total = 106
                            nearestDistance = "Visuals"
                        end
                    elseif total > 10 then
                        deltaZ = "Visuals"
                        deltaY = pattern.Text
                        nearestDistance = deltaY == "Visuals"
                        total = nearestDistance and 250 or 183 - total
                    else
                        start, identifier, _ = start(identifier)
                        start, identifier, _ = triangle.b(start, identifier, _)
                        rootPart, button = start(identifier, _)
                        _ = rootPart
                        total = rootPart == nil and 36 - total or 76 or 76
                    end
                elseif total > 50 then
                    if total > 56 then
                        start = ipairs
                        identifier = pattern.Pages
                        deltaZ = {}
                        total = identifier and 280 / total or 2100 / total
                    else
                        rootPart, button = start(identifier, _)
                        _ = rootPart
                        total = rootPart == nil and 82 - total or 76 or 76
                    end
                elseif total <= 30 then
                    if total > 26 then
                        total = 4
                        rootPart = {}
                        button = nearestDistance
                        rootPart[1] = nearestDistance
                        identifier = rootPart
                    else
                        total = 110
                        identifier = deltaZ
                        start = table.unpack
                    end
                else
                    deltaY = pattern.Text
                    deltaZ = "Esp"
                    nearestDistance = deltaY == "Esp"
                    total = nearestDistance and 1 or 106 or 106
                end
            end
        end
    end,
    da = function(amount, _)
        return function()
            local label = 22
            local rootPart, button
            repeat
                if label <= 22 then
                    if label < 20 then
                        label = 186 - label
                        button(rootPart)
                    elseif label > 20 then
                        rootPart = _[1][3].Unloaded
                        button = not rootPart
                        label = button and 20 or 178 or 178
                    else
                        button = _[1][3]
                        label, button, rootPart = 8, button.Unload, button
                    end
                else
                    return
                end
            until false
        end
    end,
    R = function(amount, _)
        return function(fileHandle)
            _[1][3].Enabled = fileHandle
        end
    end,
    e = function(sortedArray, yCoordinate, ...)
        local main = {...}
        for rowIndex = 1, select("#", ...) do
            sortedArray[yCoordinate + rowIndex - 1] = main[rowIndex]
        end
    end,
    nb = function(triangle, gameProcessed)
        return function(stack, pattern, targetPosition, vectorB, color, t, entity)
            local total = 183
            local _, point, textLabel, label, button, rootPart
            repeat
                if total >= 158 then
                    if total >= 183 then
                        if total > 201 then
                            total = 180
                            button = vectorB.Y
                            label = _.Y
                            rootPart = button > label
                        elseif total <= 183 then
                            button = vectorB.X
                            label = 0
                            _ = workspace.CurrentCamera.ViewportSize
                            rootPart = button < 0
                            total = rootPart and 141 or 179 or 179
                        else
                            return
                        end
                    elseif total > 179 then
                        total = rootPart and 201 or 84 or 84
                    elseif total > 158 then
                        button = vectorB.Y
                        label = 0
                        total, rootPart = 25239 / total, button < 0
                    else
                        rootPart = rootPart(button, label, point)
                        button = tostring
                        total = 88
                        label = targetPosition
                    end
                elseif total >= 112 then
                    if total <= 125 then
                        if total > 112 then
                            label = _.X
                            button = vectorB.X
                            total = 112
                            rootPart = button > label
                        else
                            total = rootPart and total + 68 or total + 99
                        end
                    else
                        total = rootPart and 112 or 125 or 125
                    end
                elseif total > 84 then
                    rootPart.Text = button(label)
                    rootPart.Position = vectorB
                    point = gameProcessed[2][3]
                    total = 75
                    rootPart.Size = point.sharedSettings.textSize
                    rootPart.Font = point.sharedSettings.textFont
                    rootPart.Center = true
                    rootPart.Outline = t
                    rootPart.OutlineColor = gameProcessed[4][3]
                    button = gameProcessed[3][3]
                    label = rootPart
                    textLabel = entity
                    point = color
                elseif total > 75 then
                    point, total, button, label, rootPart = "Text", 242 - total, stack, pattern, gameProcessed[1][3]
                else
                    button(label, point, textLabel)
                    return
                end
            until false
        end
    end,
    jd = function(entity, amount, duration, targetPlayer)
        entity.hd[targetPlayer] = entity.a(amount, 52209) - duration
        return entity.hd[targetPlayer]
    end,
    ua = function(amount, gameProcessed)
        return function(ReplicatedStorage)
            local identifier = gameProcessed[1][3]
            identifier.teamSettings.npc.boxOutlineThickness = ReplicatedStorage
            identifier.teamSettings.players.boxOutlineThickness = ReplicatedStorage
        end
    end,
    va = function(amount, gameProcessed)
        return function()
            local total = 155
            local label, button, rootPart, humanoidRootPart, identifier, deltaY, Lighting, _, offset
            while true do
                if total >= 75 then
                    if total >= 155 then
                        if total > 175 then
                            Lighting = gameProcessed[1][3].fog.enabled
                            total = Lighting and 423 - total or 385 - total
                        elseif total < 162 then
                            button = 132
                            label = 132
                            identifier = 217
                            rootPart = 143
                            _ = 19
                            offset = 224
                            Lighting = gameProcessed[1][3].ambient.enabled
                            total = Lighting and 53 or 5 or 5
                        elseif total <= 162 then
                            Lighting = gameProcessed[2][3]
                            total, Lighting.GlobalShadows = 81, true
                            Lighting.ShadowSoftness = gameProcessed[1][3].shadows.softness
                        else
                            deltaY = gameProcessed[1][3]
                            Lighting = gameProcessed[2][3]
                            Lighting.FogStart = deltaY.fog.s
                            Lighting.FogEnd = deltaY.fog.e
                            Lighting.FogColor = deltaY.fog.color
                            total = button <= label and 23975 / total or total + -100
                        end
                    elseif total < 81 then
                        total = 64
                        deltaY = gameProcessed[1][3]
                        Lighting = gameProcessed[2][3]
                        Lighting.Brightness = deltaY.light.brightness
                        Lighting.ExposureCompensation = deltaY.light.exposure
                        Lighting.EnvironmentDiffuseScale = deltaY.light.diffuse
                        Lighting.EnvironmentSpecularScale = deltaY.light.specular
                    elseif total <= 81 then
                        return
                    else
                        Lighting = gameProcessed[1][3].light.enabled
                        total = Lighting and 75 or 64 or 64
                    end
                elseif total >= 50 then
                    if total < 53 then
                        deltaY = gameProcessed[1][3]
                        Lighting = gameProcessed[2][3]
                        Lighting.ColorShift_Top = deltaY.colorShift.top
                        total, humanoidRootPart = 2200 / total, deltaY.colorShift.bottom
                        Lighting.ColorShift_Bottom = humanoidRootPart
                    elseif total <= 53 then
                        Lighting = gameProcessed[2][3]
                        deltaY = gameProcessed[1][3]
                        Lighting.Ambient = deltaY.ambient.a
                        Lighting.OutdoorAmbient = deltaY.ambient.b
                        total = offset <= identifier and 2650 / total or 5 or 5
                    else
                        Lighting = gameProcessed[1][3].shadows.enabled
                        total = Lighting and 162 or 81 or 81
                    end
                elseif total <= 36 then
                    if total <= 5 then
                        Lighting = gameProcessed[1][3].colorShift.enabled
                        total = Lighting and 55 - total or 44 or 44
                    else
                        humanoidRootPart = gameProcessed[1][3].time.value
                        gameProcessed[2][3].ClockTime = humanoidRootPart
                        total = _ > rootPart and 5832 / total or total + 212
                    end
                else
                    Lighting = gameProcessed[1][3].time.enabled
                    total = Lighting and 80 - total or total + 204
                end
            end
        end
    end,
    Nb = function(amount)
        return function()
            local label = 244
            local humanoid, button, rootPart
            repeat
                if label <= 108 then
                    if label <= 45 then
                        button = table.pack(button(rootPart))
                        return table.unpack(button, 1, button.n)
                    else
                        label, button = label + -63, button(rootPart, humanoid)
                        rootPart, button = button, button.GetTeams
                    end
                else
                    button = game
                    humanoid = "Teams"
                    label, rootPart, button = 108, button, button.GetService
                end
            until false
        end
    end,
    Ga = function(amount, _)
        return function(number)
            _[1][3].VisibleCheck = number
        end
    end,
    mc = function(amount, _)
        return function(target)
            _[1][3].name = target
        end
    end,
    Ua = function(amount, _)
        return function(targetPlayer)
            local label = 19
            local identifier, humanoid, rootPart
            while true do
                if label > 19 then
                    rootPart(humanoid, identifier)
                    return
                else
                    rootPart = _[1][3]
                    identifier = targetPlayer
                    label, rootPart, humanoid = 70, rootPart.SetWatermarkVisibility, rootPart
                end
            end
        end
    end,
    Ma = function(triangle, gameProcessed)
        return function(stack)
            local total = 200
            local label, humanoid, _, line, point, offset, humanoidRootPart, identifier, deltaY, rootPart
            repeat
                if total > 128 then
                    if total <= 200 then
                        if total < 159 then
                            if total <= 138 then
                                humanoid(deltaY, line)
                                total = 49
                                line = offset.ui_keybinds
                                deltaY = line.Value
                                gameProcessed[3][3].KeybindFrame.Visible = deltaY
                                humanoid = gameProcessed[4][3]
                            else
                                total = 138
                                humanoid(deltaY, triangle.d(line))
                                offset = gameProcessed[6][3]
                                humanoid = gameProcessed[3][3]
                                deltaY, line, humanoid = humanoid, offset.ui_watermark.Value, humanoid.SetWatermarkVisibility
                            end
                        elseif total <= 159 then
                            total, _ = total + -120, triangle.c(_(rootPart))
                            offset, line = line, line.format
                        else
                            label = 203
                            point = 141
                            humanoidRootPart = gameProcessed[1][3] + stack
                            humanoid, humanoidRootPart, gameProcessed[1][3] = 1, gameProcessed[2][3], humanoidRootPart
                            humanoidRootPart, humanoid, gameProcessed[2][3] = gameProcessed[1][3], 0.25, humanoidRootPart + 1
                            total = humanoidRootPart >= 0.25 and 73 or 74 or 74
                        end
                    elseif total > 215 then
                        return
                    else
                        identifier = identifier(_)
                        total = 159
                        rootPart = humanoidRootPart[3]
                        _ = math.floor
                    end
                elseif total >= 68 then
                    if total < 74 then
                        if total > 68 then
                            deltaY, total, humanoid = gameProcessed[1][3], 141 - total, gameProcessed[2][3]
                            gameProcessed[5][3], humanoidRootPart = humanoid / deltaY, 0
                            gameProcessed[1][3], gameProcessed[2][3] = 0, 0
                            humanoidRootPart = {[1] = 3, [3] = 0}
                            humanoidRootPart[2] = humanoidRootPart
                            humanoid = pcall
                            deltaY = triangle:Mc({humanoidRootPart})
                        else
                            humanoid(deltaY)
                            line = "Lean | %d fps | %d ms"
                            humanoid = gameProcessed[3][3]
                            identifier, total, _ = math.floor, 283 - total, gameProcessed[5][3]
                        end
                    elseif total > 74 then
                        humanoidRootPart = gameProcessed[3][3].AccentColor
                        gameProcessed[7][3], humanoid = humanoidRootPart, gameProcessed[8][3]
                        humanoidRootPart, humanoid = humanoid.Sub, gameProcessed[7][3]
                        total, humanoidRootPart.B = 134 - total, humanoid
                        humanoid = gameProcessed[8][3]
                        humanoidRootPart = humanoid.Rebuild
                    else
                        deltaY = gameProcessed[3][3]
                        humanoidRootPart = gameProcessed[7][3]
                        humanoid = deltaY.AccentColor
                        total = humanoidRootPart ~= humanoid and total + 54 or 226 or 226
                    end
                elseif total > 39 then
                    humanoid()
                    total = label < point and 128 or 74 or 74
                elseif total <= 6 then
                    total = total + 220
                    humanoidRootPart()
                else
                    total, line = 157, triangle.c(line(offset, identifier, triangle.d(_)))
                    deltaY, humanoid = humanoid, humanoid.SetWatermark
                end
            until false
        end
    end,
    ec = function(amount, _)
        return function(origin)
            _[1][3].weapon = origin
        end
    end,
    gc = function(amount, _)
        return function(eventName)
            _[1][3].distance = eventName
        end
    end,
    Sb = function(amount, _)
        return function(config)
            _[1][3].weaponOutline = config
        end
    end,
    xa = function(amount, _)
        return function()
            local label = 116
            local humanoid, rootPart, button
            repeat
                if label >= 116 then
                    button = _[1][3]
                    humanoid = false
                    label, rootPart, button = 83, button, button.SetWaveEnabled
                else
                    button(rootPart, humanoid)
                    return
                end
            until false
        end
    end,
    yc = function(amount, gameProcessed)
        return function(targetPlayer, pattern)
            local label = 195
            local offset, humanoid, identifier, deltaY, line, _
            while true do
                if label >= 120 then
                    if label < 195 then
                        deltaY(line, offset)
                        label = identifier < _ and label + -11 or 195 or 195
                    elseif label <= 195 then
                        _ = 248
                        identifier = 216
                        label, pattern = 234, {[1] = 3, [3] = pattern}
                        pattern[2] = pattern
                        line = amount:Ec({gameProcessed[2], pattern,})
                        humanoid = gameProcessed[1][3]
                        deltaY = gameProcessed[2][3]
                    else
                        humanoid = humanoid(deltaY, line)
                        deltaY = pattern[3].Callback
                        label = deltaY and label + -216 or 109 or 109
                    end
                elseif label <= 18 then
                    offset, deltaY, label, line = pattern[3].Callback, humanoid.OnChanged, 2160 / label, humanoid
                else
                    return humanoid
                end
            end
        end
    end,
    M = function(amount, gameProcessed)
        return function(stack)
            local total = 110
            local humanoid, button, rootPart, humanoidRootPart, label, _, deltaY, line, identifier, offset
            repeat
                if total <= 124 then
                    if total >= 76 then
                        if total <= 110 then
                            if total >= 100 then
                                if total > 100 then
                                    total, stack.BorderSizePixel = 134, 0
                                    humanoid = gameProcessed[1][3]
                                    stack.BackgroundColor3 = humanoid.BackgroundColor
                                    deltaY = stack
                                    line = {}
                                    offset = "BackgroundColor"
                                    humanoidRootPart = humanoid
                                    line.BackgroundColor3 = "BackgroundColor"
                                    humanoidRootPart, humanoid = humanoidRootPart.AddToRegistry, humanoidRootPart
                                else
                                    line, offset = humanoidRootPart(humanoid, deltaY)
                                    deltaY = line
                                    total = line == nil and 5300 / total or 106 - total
                                end
                            else
                                total = identifier and 145 or total + 24
                            end
                        elseif total <= 114 then
                            button = offset.Size
                            rootPart = 1
                            _ = button.X.Scale
                            total = 129
                            identifier = _ == 1
                        else
                            total = 12400 / total
                            identifier(_, rootPart, button, label)
                        end
                    elseif total <= 38 then
                        if total >= 8 then
                            if total > 8 then
                                offset = false
                                total = 8
                                deltaY = stack
                                line = 3
                                humanoidRootPart = gameProcessed[1][3]
                                humanoidRootPart, humanoid = humanoidRootPart.StyleSurface, humanoidRootPart
                            else
                                total = 1992 / total
                                humanoidRootPart(humanoid, deltaY, line, offset)
                            end
                        else
                            identifier, _, total, rootPart = offset.IsA, offset, 142 - total, "Frame"
                        end
                    elseif total > 53 then
                        humanoidRootPart, humanoid, deltaY = humanoidRootPart(amount.d(humanoid))
                        humanoidRootPart, humanoid, deltaY = amount.b(humanoidRootPart, humanoid, deltaY)
                        line, offset = humanoidRootPart(humanoid, deltaY)
                        deltaY = line
                        total = line == nil and 53 or 6 or 6
                    else
                        return
                    end
                elseif total > 186 then
                    if total > 234 then
                        humanoidRootPart = ipairs
                        humanoid = stack.GetChildren
                        total = 186
                        deltaY = stack
                    elseif total > 226 then
                        identifier = gameProcessed[1][3]
                        label = false
                        rootPart = offset
                        button = 3
                        total, identifier, _ = 124, identifier.StyleSurface, identifier
                    else
                        button = offset.Size
                        total = 76
                        _ = button.Y.Scale
                        rootPart = 1
                        identifier = _ == 1
                    end
                elseif total > 136 then
                    if total > 145 then
                        total, humanoid = 72, amount.c(humanoid(deltaY))
                    else
                        offset.BorderSizePixel = 0
                        _ = gameProcessed[1][3]
                        identifier = _.StyleSurface
                        total = identifier and total + 89 or total + -45
                    end
                elseif total > 134 then
                    identifier = identifier(_, rootPart)
                    total = identifier and 250 - total or 129 or 129
                elseif total > 129 then
                    humanoidRootPart(humanoid, deltaY, line)
                    humanoid = gameProcessed[1][3]
                    humanoidRootPart = humanoid.StyleSurface
                    total = humanoidRootPart and 38 or 249 or 249
                else
                    total = identifier and 226 or 9804 / total
                end
            until false
        end
    end,
    fb = function(triangle)
        return function(columnIndex, pattern, targetPosition)
            local progress = 42
            local offset, rootPart, textLabel, point, humanoid, start, index, line, _, Scheduler, attachment, deltaY, bestDistance, top, deltaZ, heap, total, button, label, identifier
            repeat
                if progress < 117 then
                    if progress >= 45 then
                        if progress <= 90 then
                            if progress <= 81 then
                                if progress <= 46 then
                                    if progress > 45 then
                                        progress, line = 5796 / progress, index + offset
                                    else
                                        line, deltaY = deltaZ, line
                                        progress = line and 8235 / progress or 117 or 117
                                    end
                                else
                                    start = start(top)
                                    top = point.Y
                                    Scheduler = total + start * top
                                    humanoid, progress, start = math.abs, 20088 / progress, bestDistance.Z
                                end
                            else
                                total = total(humanoid)
                                Scheduler = total * point.Z
                                progress, index, start = 226 - progress, line + Scheduler, math
                                humanoid, start = start.abs, textLabel.Y
                            end
                        elseif progress <= 110 then
                            if progress > 92 then
                                humanoid = humanoid(start)
                                progress = 90
                                start = point.Y
                                line = Scheduler + humanoid * start
                                humanoid = bestDistance.X
                                total = math.abs
                            else
                                offset = offset(index, line, Scheduler)
                                index = button.Position + pattern
                                line = deltaY
                                progress = line and 147 or progress + -69
                            end
                        else
                            progress, line = 117, line(Scheduler, total)
                        end
                    elseif progress >= 23 then
                        if progress <= 34 then
                            if progress <= 27 then
                                if progress <= 23 then
                                    progress = line and 45 or progress + 227
                                else
                                    progress, total = 2970 / progress, total(humanoid)
                                    Scheduler = total * point.X
                                    humanoid = math.abs
                                    start = attachment.X
                                end
                            else
                                start = start(top)
                                top = point.Y
                                Scheduler = total + start * top
                                progress, humanoid, start = progress + -16, math.abs, bestDistance.Y
                            end
                        else
                            heap = ipairs
                            identifier = columnIndex.parts
                            progress = 217
                            deltaZ = nil
                            deltaY = nil
                        end
                    elseif progress > 14 then
                        progress, humanoid = 2484 / progress, humanoid(start)
                        total = humanoid * point.Z
                        line = Scheduler + total
                        humanoid = math.abs
                        start = textLabel.Z
                    elseif progress <= 11 then
                        progress, line = 34 - progress, line(Scheduler, total)
                    else
                        heap = not deltaY
                        progress = heap and progress + 119 or 131 or 131
                    end
                elseif progress > 153 then
                    if progress >= 218 then
                        if progress > 248 then
                            progress = 45
                            line = index - offset
                        elseif progress >= 247 then
                            if progress <= 247 then
                                label = button.CFrame
                                point = button.Size * 0.5
                                bestDistance = label.LookVector
                                textLabel = label.RightVector
                                attachment = label.UpVector
                                index = Vector3
                                offset = index.new
                                total, progress, humanoid = math.abs, progress + -220, textLabel.X
                            else
                                humanoid = humanoid(start)
                                start = point.Z
                                total = humanoid * start
                                progress, Scheduler = 92, Scheduler + total
                            end
                        else
                            identifier = table.pack(identifier(_, rootPart, button))
                            return heap, table.unpack(identifier, 1, identifier.n)
                        end
                    elseif progress > 190 then
                        heap, identifier, _ = heap(identifier)
                        heap, identifier, _ = triangle.b(heap, identifier, _)
                        rootPart, button = heap(identifier, _)
                        _ = rootPart
                        progress = rootPart == nil and 231 - progress or 153 or 153
                    elseif progress > 183 then
                        rootPart, button = heap(identifier, _)
                        _ = rootPart
                        progress = rootPart == nil and 14 or 153 or 153
                    else
                        line, Scheduler, progress, total = deltaZ.Max, deltaZ, 21228 / progress, index + offset
                    end
                elseif progress < 136 then
                    if progress >= 131 then
                        if progress > 131 then
                            heap = targetPosition
                            _ = 2
                            rootPart = 5
                            identifier = Vector3.new
                            progress, button = 28994 / progress, 2
                        else
                            return (deltaY + deltaZ) * 0.5, deltaZ - deltaY
                        end
                    elseif progress > 117 then
                        progress, deltaZ = progress + 64, line
                    else
                        progress = line and 243 - progress or 46 or 46
                    end
                elseif progress < 147 then
                    if progress > 136 then
                        progress, humanoid = 81, humanoid(start)
                        total = humanoid * point.X
                        start = math.abs
                        top = attachment.Z
                    else
                        humanoid = humanoid(start)
                        progress = 34
                        total = humanoid * point.X
                        top = attachment.Y
                        start = math.abs
                    end
                elseif progress > 147 then
                    label = button.Parent
                    progress = label and 247 or 190 or 190
                else
                    progress, Scheduler, total, line = 158 - progress, deltaY, index - offset, deltaY.Min
                end
            until false
        end
    end,
    Lc = function(triangle, gameProcessed)
        return function(stack, pattern, targetPosition, weight, ...)
            local total = 132
            local humanoid, offset, rootPart, deltaZ, button, identifier, _, point, label
            while true do
                if total < 132 then
                    if total <= 42 then
                        if total > 41 then
                            offset = stack
                            total = 154
                            button = triangle.c(...)
                            rootPart = weight
                            identifier = pattern
                            _ = targetPosition
                        elseif total <= 30 then
                            if total > 10 then
                                identifier = identifier()
                                deltaZ = offset[identifier]
                                offset = deltaZ
                                total = deltaZ and 1470 / total or 168 - total
                            else
                                total = 222
                                button = table.clone
                                label = weight
                            end
                        else
                            total = button and 51 - total or 1722 / total
                        end
                    elseif total <= 67 then
                        if total > 49 then
                            offset = offset(identifier)
                            offset.ProjectileSpeed = weight.Speed
                            total, identifier = 10586 / total, weight.Gravity
                            offset.ProjectileGravity = identifier
                            identifier = pcall
                            rootPart = gameProcessed[1][3]
                            rootPart, _, label, button = weight.Origin, rootPart.Direction, deltaZ, offset
                        else
                            total = 169
                            identifier = type
                            _ = weight
                        end
                    else
                        button(label, point)
                        button = identifier
                        total = identifier and 180 or 2788 / total
                    end
                elseif total <= 169 then
                    if total >= 154 then
                        if total < 158 then
                            offset = table.pack(offset(identifier, _, rootPart, triangle.d(button)))
                            return table.unpack(offset, 1, offset.n)
                        elseif total <= 158 then
                            identifier, _ = identifier(_, rootPart, button, label)
                            rootPart = {}
                            point, total, button, label = rootPart, total + -90, table.insert, deltaZ.projectiles
                        else
                            identifier = identifier(_)
                            total, _ = total + -31, "table"
                            offset = identifier == "table"
                        end
                    elseif total > 132 then
                        total = offset and 196 or 180 - total
                    else
                        humanoid = 38
                        total = 30
                        offset = gameProcessed[1][3].contexts
                        _ = coroutine
                        identifier = coroutine.running
                    end
                elseif total < 196 then
                    total, button = 7380 / total, _
                elseif total > 196 then
                    weight = button(label)
                    weight.Direction = _
                    rootPart.direction = _
                    button = gameProcessed[1][3].diagnostics
                    point = 1
                    label = button.projectiles + 1
                    button.projectiles = label
                    total = humanoid <= 1 and 180 or 9324 / total
                else
                    total, identifier = total + -129, table
                    identifier, offset = deltaZ.stats, identifier.clone
                end
            end
        end
    end,
    vb = function(triangle, gameProcessed)
        return function(stack)
            local total = 123
            local deltaY, point, humanoid, line, label, button, humanoidRootPart, _, rootPart, identifier, offset
            while true do
                if total <= 134 then
                    if total >= 89 then
                        if total <= 121 then
                            if total <= 100 then
                                if total < 96 then
                                    total = line and 11 or 145 or 145
                                elseif total > 96 then
                                    total = line and 96 or 240 or 240
                                else
                                    stack.DisplayName, point, label = line, 57, 99
                                    line = stack.Owner
                                    total = line and 177 or total + 116
                                end
                            elseif total > 114 then
                                total, deltaY = 255 - total, deltaY(line, offset)
                            else
                                stack.OwnerName = line
                                return true
                            end
                        elseif total > 129 then
                            total = deltaY and 217 or 200 or 200
                        elseif total >= 124 then
                            if total <= 124 then
                                stack.Owner = line
                                identifier = gameProcessed[2][3]
                                offset = stack.Owner
                                stack.IsLocalPlayer = offset == identifier
                                line = stack.Owner
                                total = line and 246 or 12400 / total
                            else
                                line = humanoidRootPart
                                total = 50
                                offset = "HumanoidRootPart"
                                deltaY = humanoidRootPart.FindFirstChild
                            end
                        else
                            humanoidRootPart = stack.Character
                            humanoid = humanoidRootPart
                            total = humanoidRootPart and 78 or 143 or 143
                        end
                    elseif total > 50 then
                        if total >= 78 then
                            if total > 78 then
                                total = 163
                                deltaY = humanoidRootPart.PrimaryPart
                            else
                                line = "Humanoid"
                                total = 210
                                deltaY = humanoidRootPart
                                humanoid = humanoidRootPart.FindFirstChildOfClass
                            end
                        else
                            total = line and 6141 / total or total + -23
                        end
                    elseif total < 21 then
                        if total > 0 then
                            stack.Alive = false
                            return false
                        else
                            line = line(offset, identifier)
                            total = line and 124 or total + 221
                        end
                    elseif total >= 46 then
                        if total <= 46 then
                            offset = deltaY.IsA
                            identifier = deltaY
                            total = 207
                            _ = "BasePart"
                        else
                            deltaY = deltaY(line, offset)
                            total = deltaY and 213 - total or 135 - total
                        end
                    else
                        total, line = 2394 / total, humanoidRootPart.Name
                    end
                elseif total >= 210 then
                    if total >= 230 then
                        if total <= 246 then
                            if total < 240 then
                                line = not deltaY
                                total = rootPart > button and total + 0 or 69 or 69
                            elseif total > 240 then
                                offset = stack.Owner
                                total = 100
                                line = offset.DisplayName
                            else
                                total = 96
                                line = humanoid.DisplayName
                            end
                        else
                            offset = "Torso"
                            total = 121
                            line = humanoidRootPart
                            deltaY = humanoidRootPart.FindFirstChild
                        end
                    elseif total >= 217 then
                        if total > 217 then
                            total, line = 27404 / total, stack.Owner
                        else
                            line = not humanoid
                            total = line and 69 or 447 - total
                        end
                    elseif total <= 210 then
                        total, humanoid = 353 - total, humanoid(deltaY, line)
                    else
                        total = line and 114 or 21 or 21
                    end
                elseif total < 163 then
                    if total < 145 then
                        deltaY = humanoidRootPart
                        button = 45
                        rootPart = 21
                        total = humanoidRootPart and 129 or 217 or 217
                    elseif total > 145 then
                        total, deltaY = 217, deltaY(line, offset)
                    else
                        stack.RootPart = deltaY
                        stack.Position = deltaY.Position
                        stack.Health = humanoid.Health
                        total = 0
                        stack.MaxHealth = humanoid.MaxHealth
                        stack.Alive = humanoid.Health > 0
                        identifier = humanoidRootPart
                        line = gameProcessed[1][3]
                        line, offset = line.GetPlayerFromCharacter, line
                    end
                elseif total <= 200 then
                    if total > 177 then
                        offset = "UpperTorso"
                        deltaY = humanoidRootPart.FindFirstChild
                        total = 159
                        line = humanoidRootPart
                    elseif total > 163 then
                        offset = stack.Owner
                        line = offset.Name
                        total = label > point and 212 or 177 or 177
                    else
                        total = deltaY and 21842 / total or 41565 / total
                    end
                else
                    total, offset = 296 - total, offset(identifier, _)
                    line = not offset
                end
            end
        end
    end,
    r = function(triangle, gameProcessed)
        return function()
            local total = 181
            local humanoidRootPart, ok, deltaY, label, Lighting, button, nearestDistance, deltaZ, _, humanoid, rootPart, point, offset, identifier, start, textLabel
            repeat
                if total >= 165 then
                    if total < 181 then
                        if total < 174 then
                            if total <= 165 then
                                button = button(triangle.d(label))
                                total, identifier.Color = 65, button
                            else
                                return
                            end
                        elseif total <= 174 then
                            rootPart = _.Style
                            button = "pulse"
                            total = rootPart == "pulse" and 34800 / total or 239 - total
                        else
                            button = _.Style
                            label = "rainbow"
                            rootPart = button == "rainbow"
                            total = offset < Lighting and 242 or 33 or 33
                        end
                    elseif total >= 203 then
                        if total > 203 then
                            total = rootPart and 33 or 174 or 174
                        else
                            total, ok = 20, ok()
                            nearestDistance = gameProcessed[1][3]
                            humanoidRootPart = ipairs
                        end
                    elseif total > 181 then
                        label = math.sin
                        humanoid = math
                        textLabel = math.pi
                        total = 92
                        point = ok * _.Speed * textLabel
                    else
                        total = 203
                        ok = tick
                    end
                elseif total < 65 then
                    if total <= 33 then
                        if total > 20 then
                            rootPart = Vector2.new
                            textLabel = 2
                            total, point, label = total + -15, 1, ok * _.Speed % 2
                            button, label = label - 1, 0
                        elseif total > 18 then
                            humanoidRootPart, nearestDistance, deltaY = humanoidRootPart(nearestDistance)
                            humanoidRootPart, nearestDistance, deltaY = triangle.b(humanoidRootPart, nearestDistance, deltaY)
                            deltaZ, start = humanoidRootPart(nearestDistance, deltaY)
                            deltaY = deltaZ
                            total = deltaZ == nil and 186 - total or 41 or 41
                        else
                            rootPart = rootPart(button, label)
                            total, identifier.Offset = 1170 / total, rootPart
                        end
                    else
                        identifier = start.grad
                        _ = start.cfg
                        total = identifier and 162 or 2665 / total
                    end
                elseif total < 110 then
                    if total <= 65 then
                        deltaZ, start = humanoidRootPart(nearestDistance, deltaY)
                        deltaY = deltaZ
                        total = deltaZ == nil and 231 - total or 41 or 41
                    else
                        total = 110
                        button, label = label(point) + 1, 2
                        rootPart = button / 2
                        humanoid = rootPart
                        label = _.A
                        button = ColorSequence.new
                        textLabel = _.B
                        point, label = label, label.Lerp
                    end
                elseif total > 110 then
                    label = "wave"
                    button = _.Style
                    offset = 170
                    Lighting = 191
                    rootPart = button == "wave"
                    total = rootPart and total + 80 or 28512 / total
                else
                    total, label = 275 - total, triangle.c(label(point, textLabel, humanoid))
                end
            until false
        end
    end,
    pc = function(amount, _)
        return function(size)
            _[1][3].healthText = size
        end
    end,
    Wa = function(amount, _)
        return function()
            local label = 28
            local button, rootPart, humanoid
            repeat
                if label <= 28 then
                    humanoid = false
                    label = 130
                    button = _[1][3]
                    rootPart, button = button, button.SetTitleWaveEnabled
                else
                    button(rootPart, humanoid)
                    return
                end
            until false
        end
    end,
    Hb = function(amount, _)
        return function()
            local label = 240
            local rootPart, button, humanoid
            while true do
                if label <= 131 then
                    if label > 129 then
                        label, button, rootPart = label + -2, _[2][3], _[3][3]
                    elseif label <= 125 then
                        return
                    else
                        label = 125
                        button(rootPart)
                    end
                elseif label <= 240 then
                    rootPart = _[1][3]
                    label, humanoid, rootPart = 241, rootPart, rootPart.MouseIsOverOpenedFrame
                else
                    rootPart = rootPart(humanoid)
                    button = not rootPart
                    label = button and 131 or 125 or 125
                end
            end
        end
    end,
    Y = function(amount, gameProcessed)
        return function()
            local total = 155
            local deltaY, label, line, humanoidRootPart, humanoid, Lighting, button, _, rootPart, identifier, offset
            while true do
                if total < 146 then
                    if total <= 58 then
                        if total < 47 then
                            offset(identifier, _)
                            total = button > label and 146 or total + 47
                        elseif total <= 47 then
                            deltaY, line = Lighting(humanoidRootPart, humanoid)
                            humanoid = deltaY
                            total = deltaY == nil and 146 or 58 or 58
                        else
                            rootPart = 8
                            offset = deltaY.sub
                            total = 242
                            identifier = deltaY
                            _ = 1
                        end
                    else
                        identifier, _, total, offset = line, false, 108 - total, line.SetValue
                    end
                elseif total <= 168 then
                    if total > 155 then
                        Lighting, humanoidRootPart, humanoid = Lighting(humanoidRootPart)
                        Lighting, humanoidRootPart, humanoid = amount.b(Lighting, humanoidRootPart, humanoid)
                        deltaY, line = Lighting(humanoidRootPart, humanoid)
                        humanoid = deltaY
                        total = deltaY == nil and 24528 / total or 58 or 58
                    elseif total <= 146 then
                        total = 210
                        humanoid = {}
                        Lighting = gameProcessed[3][3]
                        humanoid.Title = "Whitelist"
                        humanoid.Description = "All teams cleared."
                        deltaY = 3
                        humanoid.Lifetime = 3
                        Lighting, humanoidRootPart = Lighting.Notify, Lighting
                    else
                        label = 206
                        button = 100
                        humanoid = {}
                        total, gameProcessed[1][3].teams = 168, humanoid
                        Lighting = pairs
                        humanoidRootPart = gameProcessed[2][3]
                    end
                elseif total <= 210 then
                    Lighting(humanoidRootPart, humanoid)
                    return
                else
                    offset = offset(identifier, _, rootPart)
                    identifier = "wl_team_"
                    total = offset == "wl_team_" and 108 or 47 or 47
                end
            end
        end
    end,
    Qa = function(amount, _)
        return function(context)
            _[1][3].Hitscan = context
        end
    end,
    L = function(amount, _)
        return function(text)
            _[1][3].light.diffuse = text
        end
    end, yd = {},
    Ac = function(amount)
        return function(targetPlayer, quantity)
            targetPlayer.DisplayFrame.Visible = quantity
        end
    end,
    h = function(amount, gameProcessed)
        return function(sourceString)
            local total = 38
            local humanoid, humanoidRootPart, offset, identifier, _, line, deltaY, rootPart
            repeat
                if total >= 110 then
                    if total > 179 then
                        if total <= 203 then
                            total, deltaY = 39, amount.c(deltaY(line))
                        else
                            humanoid.Font = deltaY
                            humanoid, total, line = ipairs, 51156 / total, gameProcessed[1][3]
                            deltaY = line.Root
                            deltaY, line = deltaY.GetDescendants, deltaY
                        end
                    elseif total > 151 then
                        total = 68
                        _ = gameProcessed[1][3].Apply
                        rootPart = identifier
                    elseif total >= 126 then
                        if total <= 126 then
                            total = 252
                            line = Enum.Font
                            deltaY = line.Code
                        end
                    else
                        humanoid = gameProcessed[1][3]
                        humanoid.UIName = sourceString
                        humanoid.Face = humanoidRootPart
                        humanoid.Version = humanoid.Version + 1
                        humanoid = gameProcessed[2][3]
                        line = gameProcessed[1][3].Builtins
                        deltaY = line[sourceString]
                        total = deltaY and 362 - total or 13860 / total
                    end
                elseif total < 39 then
                    if total > 22 then
                        total = 5
                        humanoid = sourceString
                        humanoidRootPart = gameProcessed[1][3].Resolve
                    elseif total <= 5 then
                        humanoidRootPart = humanoidRootPart(humanoid)
                        deltaY = gameProcessed[2][3]
                        humanoid = deltaY.Unloaded
                        total = humanoid and 755 / total or 110 or 110
                    else
                        return
                    end
                elseif total >= 58 then
                    if total <= 58 then
                        offset, identifier = humanoid(deltaY, line)
                        line = offset
                        total = offset == nil and total + -36 or 179 or 179
                    else
                        total = 3944 / total
                        _(rootPart)
                    end
                else
                    humanoid, deltaY, line = humanoid(amount.d(deltaY))
                    humanoid, deltaY, line = amount.b(humanoid, deltaY, line)
                    offset, identifier = humanoid(deltaY, line)
                    line = offset
                    total = offset == nil and 61 - total or 179 or 179
                end
            until false
        end
    end,
    o = function(triangle, gameProcessed)
        return function()
            local total = 206
            local nearestDistance, deltaZ, button, line, label, humanoidRootPart, start, _, rootPart, textLabel, identifier, deltaY, ok, offset
            while true do
                if total > 154 then
                    if total < 195 then
                        if total > 182 then
                            _ = _(rootPart)
                            total = _ and 290 - total or 154 or 154
                        else
                            total, _ = 369 - total, identifier.picker
                            _, rootPart = _.GetState, _
                        end
                    elseif total > 206 then
                        rootPart, textLabel, total, button = math.max, identifier.label, 411 - total, ok
                        label = textLabel.TextBounds.X + 16
                    elseif total > 195 then
                        total = 152
                        ok = 180
                        humanoidRootPart = 0
                        nearestDistance = ipairs
                        deltaY = gameProcessed[1][3]
                    else
                        total, rootPart = 77, rootPart(button, label)
                        ok, rootPart = rootPart, 18
                        humanoidRootPart = humanoidRootPart + 18
                    end
                elseif total > 126 then
                    if total <= 152 then
                        if total > 148 then
                            nearestDistance, deltaY, deltaZ = nearestDistance(deltaY)
                            nearestDistance, deltaY, deltaZ = triangle.b(nearestDistance, deltaY, deltaZ)
                            start, identifier = nearestDistance(deltaY, deltaZ)
                            deltaZ = start
                            total = start == nil and 75 or 182 or 182
                        else
                            rootPart = identifier.toggle
                            _ = rootPart.Value
                            total = line > offset and total + 6 or 26936 / total
                        end
                    else
                        rootPart = identifier.label
                        rootPart.Visible = _
                        total = _ and 370 - total or total + -77
                    end
                elseif total >= 103 then
                    if total > 103 then
                        nearestDistance.Size = deltaY(deltaZ, start)
                        return
                    else
                        offset = 167
                        line = 180
                        rootPart = identifier.toggle
                        _ = not rootPart
                        total = _ and 154 or 148 or 148
                    end
                elseif total > 75 then
                    start, identifier = nearestDistance(deltaY, deltaZ)
                    deltaZ = start
                    total = start == nil and 5775 / total or 182 or 182
                else
                    total, deltaY = 201 - total, gameProcessed[2][3]
                    nearestDistance = deltaY.KeybindFrame
                    deltaZ = ok
                    deltaY = UDim2.fromOffset
                    start = humanoidRootPart + 28
                end
            end
        end
    end,
    N = function(amount)
        return function(targetPlayer, yCoordinate)
            local label = 254
            local line, humanoid, identifier
            repeat
                if label <= 177 then
                    if label < 108 then
                        if label > 35 then
                            label = 189
                            humanoid(identifier, line)
                        else
                            label = humanoid and 108 or label + 154
                        end
                    elseif label > 108 then
                        label, humanoid = 6195 / label, targetPlayer.SetVisible
                    else
                        humanoid = targetPlayer.SetVisible
                        label = 73
                        line = yCoordinate
                        identifier = targetPlayer
                    end
                elseif label <= 189 then
                    return
                else
                    humanoid = targetPlayer
                    label = targetPlayer and 177 or 35 or 35
                end
            until false
        end
    end,
    mb = function(amount)
        return function(sourceString)
            local total = 236
            local _, identifier, humanoidRootPart, button, line, deltaY, offset, rootPart, humanoid
            while true do
                if total < 162 then
                    if total < 59 then
                        if total <= 41 then
                            total, _, identifier = total + 191, offset, offset.Remove
                        end
                    elseif total <= 67 then
                        if total <= 59 then
                            line, offset = humanoidRootPart(humanoid, deltaY)
                            deltaY = line
                            total = line == nil and total + -3 or 5133 / total
                        else
                            humanoidRootPart, humanoid, deltaY = humanoidRootPart(humanoid)
                            humanoidRootPart, humanoid, deltaY = amount.b(humanoidRootPart, humanoid, deltaY)
                            line, offset = humanoidRootPart(humanoid, deltaY)
                            deltaY = line
                            total = line == nil and total + 95 or 41 or 41
                        end
                    else
                        total = 242
                        _ = offset
                        identifier = offset.Destroy
                    end
                elseif total <= 236 then
                    if total < 232 then
                        if total <= 162 then
                            total = 178
                            rootPart = 183
                            humanoid = sourceString.adornments
                            button = 219
                            humanoidRootPart = pairs
                        else
                            humanoidRootPart, humanoid, deltaY = humanoidRootPart(humanoid)
                            humanoidRootPart, humanoid, deltaY = amount.b(humanoidRootPart, humanoid, deltaY)
                            line, offset = humanoidRootPart(humanoid, deltaY)
                            deltaY = line
                            total = line == nil and 234 - total or 265 - total
                        end
                    elseif total <= 232 then
                        total = 477 - total
                        identifier(_)
                    else
                        humanoidRootPart = pairs
                        total = 67
                        humanoid = sourceString.drawings
                    end
                elseif total <= 242 then
                    identifier(_)
                    total = rootPart <= button and 59 or 404 - total
                else
                    line, offset = humanoidRootPart(humanoid, deltaY)
                    deltaY = line
                    total = line == nil and 162 or total + -204
                end
            end
        end
    end,
    od = function(entity, amount, duration, targetPlayer)
        entity.md[targetPlayer] = entity.Oc(amount, duration)
        return entity.md[targetPlayer]
    end,
    Gb = function(amount, gameProcessed)
        return function()
            local label = 118
            local button, line
            while true do
                if label < 118 then
                    return
                elseif label > 118 then
                    gameProcessed[1][3].Button.TextTransparency = 0.3
                    label = line < 0.3 and 118 or label + -127
                else
                    line = 85
                    button = not gameProcessed[1][3].Active
                    label = button and 240 or 113 or 113
                end
            end
        end
    end,
    E = function(amount, _)
        return function(filePath)
            _[1][3].light.exposure = filePath
        end
    end,
    oa = function(amount, _)
        return function(quantity)
            _[1][3].KeybindFrame.Visible = quantity
        end
    end,
    l = function(amount, gameProcessed)
        return function(targetPlayer, yCoordinate)
            local label = 219
            local offset, deltaY, identifier, line, humanoid
            while true do
                if label < 137 then
                    if label <= 47 then
                        if label <= 32 then
                            if label <= 5 then
                                humanoid(deltaY, line)
                                label = offset > identifier and 104 or 47 or 47
                            else
                                humanoid = "Title"
                                label = targetPlayer == "Title" and 194 or label + 159
                            end
                        else
                            return
                        end
                    else
                        label = 140
                        deltaY = gameProcessed[3][3]
                        deltaY[targetPlayer].Style = yCoordinate
                        humanoid = deltaY.Rebuild
                    end
                elseif label >= 191 then
                    if label > 194 then
                        offset = 89
                        humanoid = gameProcessed[1][3]
                        identifier = 96
                        label = humanoid and 32 or 104 or 104
                    elseif label > 191 then
                        label = 137
                        humanoid = gameProcessed[2][3]
                        line = yCoordinate
                        deltaY, humanoid = humanoid, humanoid.SetTitleWaveStyle
                    else
                        line = yCoordinate
                        humanoid = gameProcessed[2][3]
                        deltaY, label, humanoid = humanoid, 5, humanoid.SetWaveStyle
                    end
                elseif label > 137 then
                    label = 6580 / label
                    humanoid()
                else
                    label = label + -90
                    humanoid(deltaY, line)
                end
            end
        end
    end,
    Ha = function(amount, gameProcessed)
        return function(targetPlayer)
            local label = 225
            local rootPart, line, humanoid, identifier
            repeat
                if label < 225 then
                    rootPart(humanoid, identifier, line)
                    return
                else
                    rootPart = gameProcessed[1][3]
                    identifier = nil
                    label = 150
                    humanoid = "Sub"
                    line = targetPlayer
                end
            until false
        end
    end,
    ta = function(amount, _)
        return function(targetPlayer)
            local label = 97
            local rootPart, humanoid, identifier
            repeat
                if label < 97 then
                    rootPart(humanoid, identifier)
                    return
                else
                    identifier = targetPlayer
                    rootPart = _[1][3]
                    label = 15
                    humanoid = "Sub"
                end
            until false
        end
    end,
    Jb = function(amount, gameProcessed)
        return function()
            local deltaY = gameProcessed[2][3].shadows.tech
            local rootPart = Enum.Technology[deltaY]
            gameProcessed[1][3].Technology = rootPart
        end
    end,
    Bd = function(entity, amount, duration, targetPlayer)
        entity.yd[targetPlayer] = entity.Qc(amount, duration)
        return entity.yd[targetPlayer]
    end,
    qd = function(entity, amount, duration, targetPlayer)
        entity.pd[targetPlayer] = amount / duration
        return entity.pd[targetPlayer]
    end,
    bb = function(amount)
        return function(targetPlayer)
            local label = 98
            local humanoid, line, humanoidRootPart, offset, deltaY
            while true do
                if label < 134 then
                    if label < 80 then
                        if label > 10 then
                            humanoidRootPart, humanoid, deltaY = humanoidRootPart(humanoid)
                            humanoidRootPart, humanoid, deltaY = amount.b(humanoidRootPart, humanoid, deltaY)
                            line, offset = humanoidRootPart(humanoid, deltaY)
                            deltaY = line
                            label = line == nil and 148 or 10 or 10
                        else
                            label, offset.Visible = 140, false
                        end
                    elseif label <= 80 then
                        line, offset = humanoidRootPart(humanoid, deltaY)
                        deltaY = line
                        label = line == nil and label + 151 or 152 or 152
                    else
                        humanoidRootPart = pairs
                        label = 20
                        humanoid = targetPlayer.drawings
                    end
                elseif label <= 148 then
                    if label > 140 then
                        humanoid = targetPlayer.adornments
                        label = 134
                        humanoidRootPart = pairs
                    elseif label <= 134 then
                        humanoidRootPart, humanoid, deltaY = humanoidRootPart(humanoid)
                        humanoidRootPart, humanoid, deltaY = amount.b(humanoidRootPart, humanoid, deltaY)
                        line, offset = humanoidRootPart(humanoid, deltaY)
                        deltaY = line
                        label = line == nil and 231 or label + 18
                    else
                        line, offset = humanoidRootPart(humanoid, deltaY)
                        deltaY = line
                        label = line == nil and 148 or 10 or 10
                    end
                elseif label <= 152 then
                    label, offset.Visible = 80, false
                else
                    return
                end
            end
        end
    end,
    Id = function(entity, amount, duration, targetPlayer)
        entity.Dd[targetPlayer] = entity.a(amount, 30153) + duration
        return entity.Dd[targetPlayer]
    end,
    rd = function(entity, amount, duration, targetPlayer)
        entity.pd[targetPlayer] = entity.Qc(amount, duration)
        return entity.pd[targetPlayer]
    end,
    rb = function(amount, _)
        return function()
            return _[1][3]
        end
    end,
    Wb = function(amount, _)
        return function(itemName)
            _[1][3].healthBarOutline = itemName
        end
    end, hd = {},
    Xb = function(amount, _)
        return function(startPosition)
            _[1][3].nameOutline = startPosition
        end
    end,
    U = function(amount, gameProcessed)
        return function(stack, pattern, duration)
            local total = 4
            local line, rootPart, offset, identifier, label, _, button, deltaY
            repeat
                if total <= 86 then
                    if total < 47 then
                        if total > 25 then
                            total = 134
                            deltaY()
                        elseif total <= 4 then
                            deltaY = gameProcessed[1][3]
                            _ = 214
                            rootPart = 130
                            total = deltaY and 81 or 183 or 183
                        else
                            total = total + 109
                            deltaY(line, offset, identifier)
                        end
                    elseif total <= 81 then
                        if total <= 77 then
                            if total > 47 then
                                line = gameProcessed[3][3]
                                deltaY = line[stack]
                                deltaY.B = duration
                                total = button < label and 134 or 135 or 135
                            else
                                offset = pattern
                                deltaY = gameProcessed[2][3]
                                identifier = duration
                                line, total, deltaY = deltaY, 7426 / total, deltaY.SetWaveColors
                            end
                        else
                            deltaY = "Title"
                            total = stack == "Title" and total + 5 or 47 or 47
                        end
                    else
                        deltaY, offset, total, identifier = gameProcessed[2][3], pattern, 2150 / total, duration
                        line, deltaY = deltaY, deltaY.SetTitleWaveColors
                    end
                elseif total <= 158 then
                    if total > 143 then
                        total = total + -24
                        deltaY(line, offset, identifier)
                    elseif total >= 135 then
                        if total > 135 then
                            button = 217
                            label = 129
                            total = duration and 11011 / total or 135 or 135
                        else
                            line = gameProcessed[3][3]
                            total = 46
                            deltaY = line.Rebuild
                        end
                    else
                        return
                    end
                elseif total <= 183 then
                    total = pattern and 40077 / total or 26169 / total
                else
                    line = gameProcessed[3][3]
                    deltaY = line[stack]
                    deltaY.A = pattern
                    total = _ > rootPart and 143 or 353 - total
                end
            until false
        end
    end,
    ac = function(amount, _)
        return function(other)
            _[1][3].offScreenArrow = other
        end
    end,
    ka = function(amount, _)
        return function(chunk)
            _[1][3].fog.s = chunk
        end
    end,
    Fc = function(triangle, gameProcessed)
        return function()
            local total = 115
            local humanoidRootPart, deltaY, identifier, nearestDistance, textLabel, humanoid, button, point, _, start, Lighting, line, rootPart, label, deltaZ
            while true do
                if total < 87 then
                    if total > 26 then
                        if total > 60 then
                            gameProcessed[1][3]._added[identifier[3]] = true
                            button = identifier[3].gsub
                            rootPart = "wl_team_"
                            textLabel = "_"
                            point = "[^%w]"
                            total = 91
                            label = identifier[3]
                        else
                            Lighting = Lighting(humanoidRootPart)
                            total = 87
                            nearestDistance = Lighting
                            humanoidRootPart = ipairs
                        end
                    elseif total <= 18 then
                        if total > 7 then
                            total, Lighting = 78 - total, Lighting(humanoidRootPart, nearestDistance)
                            humanoidRootPart, Lighting = Lighting, Lighting.GetTeams
                        else
                            humanoid = 212
                            line = 198
                            identifier = {[1] = 3, [3] = start.Name,}
                            identifier[2] = identifier
                            label = gameProcessed[1][3]
                            button = label._added
                            rootPart = button[identifier[3]]
                            total = not rootPart and 75 or 255 or 255
                        end
                    else
                        total = 255
                        rootPart(button, label)
                    end
                elseif total > 135 then
                    if total > 205 then
                        total = humanoid < line and 262 - total or 135 or 135
                    end
                elseif total > 115 then
                    deltaZ, start = humanoidRootPart(nearestDistance, deltaY)
                    deltaY = deltaZ
                    total = deltaZ == nil and 205 or 142 - total
                elseif total < 91 then
                    humanoidRootPart, nearestDistance, deltaY = humanoidRootPart(nearestDistance)
                    humanoidRootPart, nearestDistance, deltaY = triangle.b(humanoidRootPart, nearestDistance, deltaY)
                    deltaZ, start = humanoidRootPart(nearestDistance, deltaY)
                    deltaY = deltaZ
                    total = deltaZ == nil and 205 or 7 or 7
                elseif total <= 91 then
                    label, _, rootPart = {}, rootPart .. button(label, point, textLabel), gameProcessed[2][3]
                    label.Text = identifier[3]
                    label.Flag = _
                    total = 26
                    label.Default = false
                    point = triangle:Gc({gameProcessed[1], identifier,})
                    label.Callback = point
                    rootPart, button = rootPart.AddToggle, rootPart
                else
                    nearestDistance = "Teams"
                    Lighting = game
                    Lighting, total, humanoidRootPart = Lighting.GetService, 18, Lighting
                end
            end
        end
    end,
    T = function(amount, _)
        return function(callback)
            _[1][3].light.brightness = callback
        end
    end,
    wc = function(amount, gameProcessed)
        return function(targetPlayer, pattern)
            local label = 96
            local line, humanoid, deltaY, offset
            repeat
                if label <= 96 then
                    if label <= 47 then
                        deltaY(line, offset)
                        gameProcessed[3][3] = humanoid
                        return humanoid
                    else
                        pattern = {[1] = 3, [3] = pattern}
                        label, pattern[2] = 207, pattern
                        offset = {}
                        humanoid = gameProcessed[1][3]
                        line = pattern[3].Flag
                        offset.Text = pattern[3].Text
                        offset.Default = pattern[3].Default
                        humanoid, deltaY = humanoid.AddToggle, humanoid
                    end
                else
                    label, humanoid = 47, humanoid(deltaY, line, offset)
                    deltaY = humanoid.OnChanged
                    offset = amount:Cc({pattern, gameProcessed[2],})
                    line = humanoid
                end
            until false
        end
    end,
    _b = function(triangle, gameProcessed)
        return function(stack, pattern, duration, weight, color, secondVector, entity)
            local total = 45
            local point, button, label, _, rootPart
            while true do
                if total < 112 then
                    if total > 81 then
                        rootPart = stack
                        label = "Line"
                        total = 151
                        button = pattern
                        _ = gameProcessed[2][3]
                    elseif total > 56 then
                        _, rootPart = _(rootPart, button)
                        duration = _
                        weight = rootPart
                        _ = not _
                        total = _ and 173 or 97 or 97
                    elseif total > 45 then
                        total = 176
                        rootPart = 1
                    else
                        _ = gameProcessed[1][3]
                        rootPart = duration
                        total = 81
                        button = weight
                    end
                elseif total < 173 then
                    if total > 112 then
                        _ = _(rootPart, button, label)
                        _.From = duration
                        _.To = weight
                        rootPart = secondVector
                        total = secondVector and 176 or 207 - total
                    else
                        rootPart(button, label, point)
                        return _
                    end
                elseif total <= 173 then
                    return nil
                else
                    total, _.Thickness = 19712 / total, rootPart
                    label = color
                    rootPart = gameProcessed[3][3]
                    button = _
                    point = entity
                end
            end
        end
    end,
    C = function(amount)
        return function(targetPlayer, yCoordinate)
            local label = 130
            local humanoid, deltaY
            repeat
                if label <= 195 then
                    if label <= 130 then
                        if label <= 45 then
                            return targetPlayer[yCoordinate], 1
                        else
                            label = 195
                            deltaY = targetPlayer[yCoordinate]
                            humanoid = type
                        end
                    else
                        humanoid = humanoid(deltaY)
                        deltaY = "table"
                        label = humanoid == "table" and label + 59 or 45 or 45
                    end
                else
                    deltaY = targetPlayer[yCoordinate][2]
                    return targetPlayer[yCoordinate][1], deltaY
                end
            until false
        end
    end,
    za = function(amount, _)
        return function(rawCommand)
            _[1][3].BulletDrop = rawCommand
        end
    end,
    wd = function(entity, amount, duration, targetPlayer)
        entity.ud[targetPlayer] = entity.Oc(amount, duration)
        return entity.ud[targetPlayer]
    end,
    Uc = function(triangle, gameProcessed)
        return function(stack)
            local nearestDistance = 1
            local humanoidRootPart = 0
            while true do
                humanoidRootPart = humanoidRootPart * 85 + ("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#$%&()*+-;<=>?@^_`{|}~"):find(
                    stack:sub(nearestDistance, nearestDistance), 1, true
                ) - 1
                nearestDistance = nearestDistance + 1
                if nearestDistance > 5 then
                    break
                end
            end
            nearestDistance = gameProcessed[1][3]
            local deltaY = gameProcessed[2][3](humanoidRootPart, 24)
            local line = gameProcessed[3][3](gameProcessed[2][3](humanoidRootPart, 16), 255)
            local offset = gameProcessed[3][3](gameProcessed[2][3](humanoidRootPart, 8), 255)
            local identifier = gameProcessed[3][3]
            identifier = table.pack(identifier(humanoidRootPart, 255))
            nearestDistance = table.pack(nearestDistance(deltaY, line, offset, table.unpack(identifier, 1, identifier.n)))
            return table.unpack(nearestDistance, 1, nearestDistance.n)
        end
    end,
    kd = function(entity, amount, duration, targetPlayer)
        entity.hd[targetPlayer] = entity.a(amount, 1835) / duration
        return entity.hd[targetPlayer]
    end,
    w = function(amount, gameProcessed)
        return function(targetPlayer, yCoordinate)
            local label = 131
            local line, identifier, humanoid, offset, deltaY
            while true do
                if label > 131 then
                    if label > 154 then
                        label = 149
                        humanoid(deltaY, line)
                    elseif label <= 149 then
                        return
                    else
                        humanoid(deltaY, line)
                        label = offset <= identifier and label + -5 or 239 - label
                    end
                elseif label <= 78 then
                    if label < 28 then
                        label, line, humanoid = 229 - label, yCoordinate, gameProcessed[2][3]
                        humanoid, deltaY = humanoid.SetWaveSpeed, humanoid
                    elseif label > 28 then
                        identifier = 236
                        humanoid = "Title"
                        offset = 151
                        label = targetPlayer == "Title" and 106 - label or 15 or 15
                    else
                        humanoid = gameProcessed[2][3]
                        line = yCoordinate
                        deltaY, label, humanoid = humanoid, 154, humanoid.SetTitleWaveSpeed
                    end
                elseif label > 85 then
                    humanoid = gameProcessed[1][3]
                    label = humanoid and 78 or 85 or 85
                else
                    deltaY = gameProcessed[3][3]
                    label = 149
                    humanoid = deltaY[targetPlayer]
                    humanoid.Speed = yCoordinate
                end
            end
        end
    end,
    la = function(amount, _)
        return function(startIndex)
            _[1][3].light.specular = startIndex
        end
    end,
    H = function(amount, _)
        return function(scalar)
            _[1][3].time.value = scalar
        end
    end,
    J = function(triangle, args)
        return function(columnIndex, arguments)
            local progress = 12
            local
                deltaTime, bestDistance, humanoid, button, _, total, humanoidRootPart, top, key, sum, currentIndex, Lighting, elapsed, deltaZ, heap, offset, identifier, attachment, index, source, playerId, nearestDistance, low, x, length, label, start, count,
                status, line, deltaY, points, hash, current, ok, main, position, point, currentTime, success, textLabel, right, startTime, rootPart, Scheduler
            repeat
                if progress <= 107 then
                    if progress <= 63 then
                        if progress < 34 then
                            if progress < 18 then
                                if progress >= 11 then
                                    if progress > 11 then
                                        main = 234
                                        low = 199
                                        index = 145
                                        sum = 155
                                        nearestDistance = workspace.CurrentCamera
                                        deltaY = not nearestDistance
                                        progress = deltaY and 73 or 199 or 199
                                    else
                                        bestDistance, offset, right = bestDistance(offset)
                                        bestDistance, offset, right = triangle.b(bestDistance, offset, right)
                                        line, source = bestDistance(offset, right)
                                        right = line
                                        progress = line == nil and 2618 / progress or 98 or 98
                                    end
                                else
                                    Lighting = currentIndex <= heap
                                    progress = index <= low and 31 or 57 - progress
                                end
                            elseif progress >= 28 then
                                if progress <= 28 then
                                    rootPart = args[2][3]
                                    status = rootPart.VisibleCheck
                                    Lighting = not status
                                    progress = Lighting and progress + 153 or 3136 / progress
                                else
                                    button = 28
                                    point = 232
                                    progress = Lighting and 50 - progress or 276 - progress
                                end
                            elseif progress > 18 then
                                rootPart = x - columnIndex
                                status = rootPart.Magnitude
                                progress, Lighting = 4655 / progress, status <= success
                            else
                                progress = 64
                                length = args[2][3].MaxDistance
                            end
                        elseif progress <= 54 then
                            if progress <= 51 then
                                if progress > 50 then
                                    start, progress, x, count = total, 202 - progress, total.IsA, "BasePart"
                                elseif progress > 34 then
                                    progress = x and progress + 79 or 209 or 209
                                else
                                    total = total(x, start)
                                    x = total
                                    progress = total and 1734 / progress or progress + 16
                                end
                            elseif progress <= 53 then
                                length = length(points)
                                progress = length and 3392 / progress or 71 - progress
                            else
                                progress = progress + 180
                                start, count = start(count, currentIndex)
                                humanoid = start.Y
                                rootPart = start.X
                                status = Vector2.new
                            end
                        elseif progress >= 59 then
                            if progress > 59 then
                                humanoid, deltaTime = humanoid(deltaTime, top, key, currentTime, elapsed, identifier, Scheduler)
                                top = humanoid
                                progress = humanoid and 185 or progress + 68
                            else
                                rootPart = rootPart(humanoid)
                                progress = rootPart and 211 or 202 or 202
                            end
                        else
                            x = textLabel
                            progress = 34
                            total = textLabel.FindFirstChild
                            start = source
                        end
                    elseif progress < 85 then
                        if progress > 80 then
                            if progress > 81 then
                                progress, startTime = 7626 / progress, args[3][3]
                                textLabel, startTime = startTime.Allowed, hash
                            else
                                rootPart = status.Magnitude
                                humanoid = 300
                                progress = rootPart > 300 and 172 - progress or 102 or 102
                            end
                        elseif progress < 73 then
                            if progress <= 64 then
                                progress = 311 - progress
                            else
                                bestDistance, line, total, progress, start, Lighting, currentIndex, x, status, count, source =
                                    ipairs, {}, "UpperTorso", progress + -54, "Torso", "LeftUpperLeg",
                                    "RightUpperArm", "LowerTorso", "RightUpperLeg", "LeftUpperArm",
                                    "Head"
                                line[1], line[2], line[3], line[4], line[5], line[6], line[7], line[8] =
                                    "Head", "UpperTorso", "LowerTorso", "Torso", "LeftUpperArm",
                                    "RightUpperArm", "LeftUpperLeg", "RightUpperLeg"
                                offset = line
                            end
                        elseif progress <= 73 then
                            return nil
                        else
                            status = Lighting.AssemblyLinearVelocity
                            progress = humanoidRootPart > current and progress + -25 or progress + 98
                        end
                    elseif progress >= 98 then
                        if progress >= 104 then
                            if progress <= 104 then
                                Lighting = Lighting(status, rootPart, humanoid)
                                progress = ok <= position and 50 or 181 or 181
                            else
                                _, length, points = _(triangle.d(length))
                                _, length, points = triangle.b(_, length, points)
                                label, hash = _(length, points)
                                points = label
                                progress = label == nil and 146 or 8774 / progress
                            end
                        elseif progress > 98 then
                            rootPart, progress, humanoid = tonumber, 6018 / progress, arguments.ProjectileGravity
                        else
                            x = args[2][3]
                            total = x.HitPart
                            progress = source ~= total and progress + 38 or 229 or 229
                        end
                    elseif progress <= 91 then
                        if progress > 85 then
                            rootPart = Vector3
                            status = Vector3.zero
                            progress = point <= button and 91 or 193 - progress
                        else
                            label, hash = _(length, points)
                            points = label
                            progress = label == nil and 146 or 82 or 82
                        end
                    else
                        textLabel = textLabel(startTime)
                        progress = textLabel and 239 or 85 or 85
                    end
                elseif progress < 185 then
                    if progress >= 136 then
                        if progress < 178 then
                            if progress >= 146 then
                                if progress > 146 then
                                    x = x(start, count)
                                    progress = playerId >= attachment and 50 or 282 - progress
                                else
                                    return deltaZ
                                end
                            else
                                progress = 208
                                start = source
                                x = startTime
                                total = table.insert
                            end
                        elseif progress < 182 then
                            if progress > 178 then
                                progress = Lighting and 132 or 209 or 209
                            else
                                progress = status and progress + -97 or progress + 4
                            end
                        elseif progress > 182 then
                            progress, length = 19688 / progress, triangle.c(length(points))
                        else
                            progress = 81
                            status = total.AssemblyLinearVelocity
                        end
                    elseif progress <= 129 then
                        if progress < 112 then
                            if progress <= 110 then
                                top = {player = hash, part = total, point = humanoid, time = deltaTime}
                                progress = 85
                                deltaZ = top
                                heap = currentIndex
                            else
                                bestDistance, offset, right = bestDistance(offset)
                                bestDistance, offset, right = triangle.b(bestDistance, offset, right)
                                line, source = bestDistance(offset, right)
                                right = line
                                progress = line == nil and 85 or 55 or 55
                            end
                        elseif progress > 112 then
                            ok = 203
                            x = total.Position
                            position = 202
                            start = nearestDistance.WorldToViewportPoint
                            progress = 54
                            count = nearestDistance
                            currentIndex = x
                        else
                            progress, status = progress + -8, args[3][3]
                            rootPart, Lighting, humanoid, status = x, status.Clear, textLabel, columnIndex
                        end
                    elseif progress > 131 then
                        rootPart = "HumanoidRootPart"
                        progress = 191
                        status = textLabel
                        Lighting = textLabel.FindFirstChild
                    else
                        progress = top and 110 or 209 or 209
                    end
                elseif progress >= 229 then
                    if progress >= 238 then
                        if progress <= 245 then
                            if progress <= 239 then
                                if progress <= 238 then
                                    progress = 111
                                    bestDistance = ipairs
                                    offset = startTime
                                else
                                    playerId = 193
                                    bestDistance = {}
                                    attachment = 147
                                    textLabel = hash.Character
                                    right = args[2][3]
                                    bestDistance[1] = right.HitPart
                                    offset = right
                                    startTime = bestDistance
                                    bestDistance = right.Hitscan
                                    progress = bestDistance and 304 - progress or 238 or 238
                                end
                            else
                                progress = Lighting and 28 or 181 or 181
                            end
                        else
                            success = success(_, length)
                            _ = ipairs
                            length = args[4][3]
                            progress, points, length = progress + -63, length, length.GetPlayers
                        end
                    elseif progress >= 233 then
                        if progress > 233 then
                            status = status(rootPart, humanoid)
                            Lighting = count
                            currentIndex = (status - deltaY).Magnitude
                            progress = Lighting and 2 or 265 - progress
                        else
                            deltaY = deltaY(deltaZ)
                            deltaZ = nil
                            progress = 53
                            heap = args[2][3].FOV
                            success = math.min
                            _ = args[2][3].MaxDistance
                            length = tonumber
                            points = arguments.Range
                        end
                    else
                        line, source = bestDistance(offset, right)
                        right = line
                        progress = line == nil and 238 or 327 - progress
                    end
                elseif progress < 202 then
                    if progress <= 191 then
                        if progress <= 185 then
                            key = (humanoid - columnIndex).Magnitude
                            currentTime = 0.001
                            progress, top = 316 - progress, key > 0.001
                        else
                            Lighting = Lighting(status, rootPart)
                            status = Lighting
                            progress = Lighting and 15280 / progress or 33998 / progress
                        end
                    else
                        deltaY = args[1][3]
                        humanoidRootPart = 79
                        current = 167
                        deltaY, progress, deltaZ = deltaY.GetMouseLocation, 233, deltaY
                    end
                elseif progress >= 209 then
                    if progress <= 209 then
                        line, source = bestDistance(offset, right)
                        right = line
                        progress = line == nil and 17765 / progress or 11495 / progress
                    else
                        deltaTime = args[3][3]
                        Scheduler, top, key, currentTime, humanoid, deltaTime, elapsed = args[2][3], x, status, arguments.ProjectileSpeed, deltaTime.AimPoint, columnIndex, rootPart
                        progress, identifier, Scheduler = 63, Scheduler.Prediction, Scheduler.BulletDrop
                    end
                elseif progress <= 202 then
                    progress = 211
                    humanoid = workspace
                    rootPart = workspace.Gravity
                else
                    total(x, start)
                    progress = sum < main and progress + 21 or 258 - progress
                end
            until false
        end
    end,
    xc = function(amount, gameProcessed)
        return function(targetPlayer, pattern)
            local label = 225
            local offset, line, _, humanoid, identifier, deltaY
            while true do
                if label > 135 then
                    if label > 225 then
                        offset = pattern[3].Callback
                        label = 96
                        deltaY = humanoid.OnChanged
                        line = humanoid
                    else
                        identifier = 165
                        _ = 76
                        pattern = {[1] = 3, [3] = pattern}
                        pattern[2] = pattern
                        label = 13
                        line = amount:Dc({pattern, gameProcessed[2],})
                        humanoid = gameProcessed[1][3]
                        deltaY = gameProcessed[2][3]
                    end
                elseif label > 96 then
                    return humanoid
                elseif label > 13 then
                    deltaY(line, offset)
                    label = identifier > _ and 231 - label or 225 or 225
                else
                    humanoid = humanoid(deltaY, line)
                    deltaY = pattern[3].Callback
                    label = deltaY and label + 222 or 135 or 135
                end
            end
        end
    end,
    La = function(triangle, gameProcessed)
        return function(stack)
            local total = 15
            local start, humanoidRootPart, deltaZ, textLabel, humanoid, _, line, nearestDistance, button, point, deltaY, label, rootPart
            repeat
                if total >= 178 then
                    if total > 202 then
                        if total >= 236 then
                            if total >= 239 then
                                if total > 239 then
                                    humanoid = 56
                                    line = 26
                                    humanoidRootPart = stack.Character
                                    nearestDistance = humanoidRootPart
                                    total = humanoidRootPart and 40 or 213 or 213
                                else
                                    nearestDistance = gameProcessed[3][3]
                                    humanoidRootPart = nearestDistance.silent
                                    total = humanoidRootPart and 122 or 417 - total
                                end
                            else
                                deltaY = gameProcessed[2][3]
                                nearestDistance = stack.Parent
                                humanoidRootPart = nearestDistance ~= deltaY
                                total = _ <= rootPart and total + -40 or 35 or 35
                            end
                        elseif total >= 215 then
                            if total <= 215 then
                                return false
                            else
                                start = 0
                                deltaZ = nearestDistance.Health
                                total, deltaY = total + -29, deltaZ > 0
                            end
                        else
                            deltaY = humanoidRootPart
                            total = humanoidRootPart and 409 - total or 54 or 54
                        end
                    elseif total < 196 then
                        if total <= 187 then
                            if total <= 185 then
                                if total > 178 then
                                    deltaY = deltaY(deltaZ, start)
                                    total = point < textLabel and total + -18 or 54 or 54
                                else
                                    textLabel = 9
                                    point = 148
                                    total = humanoidRootPart and 198 or 6 or 6
                                end
                            else
                                total = humanoidRootPart and 167 or 239 or 239
                            end
                        else
                            deltaY = nearestDistance
                            total = humanoid < line and 1134 / total or total + 11
                        end
                    elseif total > 200 then
                        return deltaY
                    elseif total < 198 then
                        total = 185
                        deltaZ = humanoidRootPart
                        start = workspace
                        deltaY = humanoidRootPart.IsDescendantOf
                    elseif total > 198 then
                        total = deltaY and 231 or 202 or 202
                    else
                        deltaZ = stack.Team
                        nearestDistance = gameProcessed[3][3].teams
                        deltaY = deltaZ.Name
                        total, humanoidRootPart = 1188 / total, nearestDistance[deltaY]
                    end
                elseif total > 54 then
                    if total > 144 then
                        if total > 156 then
                            return false
                        else
                            total = humanoidRootPart and 17316 / total or 187 or 187
                        end
                    elseif total >= 122 then
                        if total > 122 then
                            return false
                        else
                            humanoidRootPart = stack.Team
                            total = button >= label and 231 or total + 56
                        end
                    elseif total <= 93 then
                        total, nearestDistance = 19809 / total, nearestDistance(deltaY, deltaZ)
                    else
                        total = 187
                        nearestDistance = stack.Team
                        deltaZ = gameProcessed[1][3]
                        deltaY = deltaZ.Team
                        humanoidRootPart = nearestDistance == deltaY
                    end
                elseif total >= 18 then
                    if total <= 40 then
                        if total > 35 then
                            deltaZ, nearestDistance, total, deltaY = "Humanoid", humanoidRootPart.FindFirstChildOfClass, 133 - total, humanoidRootPart
                        elseif total > 18 then
                            total = humanoidRootPart and 144 or 350 / total
                        else
                            nearestDistance = gameProcessed[1][3]
                            total, humanoidRootPart = 174 - total, nearestDistance.Team
                        end
                    else
                        total = deltaY and 189 or total + 146
                    end
                elseif total <= 10 then
                    if total <= 6 then
                        total = humanoidRootPart and total + 209 or 256 - total
                    else
                        button = 195
                        nearestDistance = gameProcessed[4][3]
                        label = 210
                        humanoidRootPart = nearestDistance.TeamCheck
                        total = humanoidRootPart and 28 - total or 156 or 156
                    end
                else
                    nearestDistance = gameProcessed[1][3]
                    _ = 77
                    rootPart = 33
                    humanoidRootPart = stack == nearestDistance
                    total = humanoidRootPart and 35 or 236 or 236
                end
            until false
        end
    end,
    Na = function(amount)
        return function()
            local label = 132
            local identifier, humanoid, button, rootPart
            repeat
                if label > 132 then
                    button = table.pack(button(rootPart, humanoid, identifier))
                    return table.unpack(button, 1, button.n)
                else
                    label = 212
                    rootPart = 1
                    button = Color3.new
                    humanoid = 1
                    identifier = 1
                end
            until false
        end
    end,
    uc = function(amount, gameProcessed)
        return function(targetPlayer, yCoordinate)
            local label = 89
            local line, deltaY, humanoid, _
            repeat
                if label <= 89 then
                    humanoid = gameProcessed[1][3]
                    line = yCoordinate.Text
                    _ = yCoordinate.Callback
                    label, humanoid, deltaY = 217, humanoid.AddButton, humanoid
                else
                    humanoid = table.pack(humanoid(deltaY, line, _))
                    return table.unpack(humanoid, 1, humanoid.n)
                end
            until false
        end
    end,
    I = function(triangle, gameProcessed)
        return function()
            local total = 69
            local button, ok, offset, rootPart, nearestDistance, label, textLabel, Lighting, deltaY, characters, humanoid, point, bestDistance, start, identifier, deltaZ, _
            repeat
                if total <= 161 then
                    if total > 93 then
                        if total >= 124 then
                            if total <= 124 then
                                total, deltaY, nearestDistance, deltaZ = 359 - total, ipairs, 0, characters
                            else
                                nearestDistance = gameProcessed[1][3]
                                deltaZ = {Title = "Whitelist", Description = "No teams found."}
                                start = 3
                                deltaZ.Lifetime = 3
                                total, nearestDistance, deltaY = 117, nearestDistance.Notify, nearestDistance
                            end
                        elseif total > 100 then
                            nearestDistance(deltaY, deltaZ)
                            return
                        else
                            total = total + 144
                            deltaY(deltaZ, start)
                        end
                    elseif total < 76 then
                        if total > 59 then
                            ok = pcall
                            total = 76
                            characters = triangle:Nb()
                        elseif total > 22 then
                            deltaY = 0
                            total = nearestDistance > 0 and 197 or 244 or 244
                        else
                            total = 177
                            deltaZ = 0
                            deltaY = #characters
                            nearestDistance = deltaY == 0
                        end
                    elseif total < 82 then
                        ok, characters = ok(characters)
                        nearestDistance = not ok
                        total = nearestDistance and 177 or 22 or 22
                    elseif total > 82 then
                        total = 166
                        label(point, textLabel)
                    else
                        rootPart = {[1] = 3, [3] = _.Name,}
                        rootPart[2] = rootPart
                        textLabel = gameProcessed[2][3]
                        point = textLabel._added
                        label = point[rootPart[3]]
                        total = not label and total + 106 or 166 or 166
                    end
                elseif total >= 197 then
                    if total < 235 then
                        if total > 197 then
                            identifier, _ = deltaY(deltaZ, start)
                            start = identifier
                            total = identifier == nil and 281 - total or total + -140
                        else
                            start = {}
                            deltaY = gameProcessed[1][3]
                            start.Title = "Whitelist"
                            total, _, button = 19700 / total, "Added ", " team(s)."
                            rootPart = nearestDistance .. " team(s)."
                            start.Description = "Added " .. rootPart
                            start.Lifetime = 3
                            deltaZ, deltaY = deltaY, deltaY.Notify
                        end
                    elseif total <= 235 then
                        deltaY, deltaZ, start = deltaY(deltaZ)
                        deltaY, deltaZ, start = triangle.b(deltaY, deltaZ, start)
                        identifier, _ = deltaY(deltaZ, start)
                        start = identifier
                        total = identifier == nil and 13865 / total or total + -153
                    else
                        return
                    end
                elseif total < 183 then
                    if total <= 166 then
                        total = offset >= Lighting and 36852 / total or 244 or 244
                    else
                        offset = 91
                        Lighting = 20
                        total = nearestDistance and total + -16 or 124 or 124
                    end
                elseif total <= 183 then
                    button, label, textLabel = label .. point(textLabel, humanoid, bestDistance), gameProcessed[3][3], {}
                    textLabel.Text = rootPart[3]
                    total, textLabel.Flag = 17019 / total, button
                    textLabel.Default = false
                    humanoid = triangle:Mb({gameProcessed[2], rootPart,})
                    textLabel.Callback = humanoid
                    label, point = label.AddToggle, label
                else
                    gameProcessed[2][3]._added[rootPart[3]] = true
                    total, button = 371 - total, 1
                    label, textLabel, point, bestDistance, nearestDistance, humanoid = "wl_team_", rootPart[3], rootPart[3].gsub, "_", nearestDistance + 1, "[^%w]"
                end
            until false
        end
    end,
    yb = function(triangle, gameProcessed)
        return function(stack, pattern, targetPosition, mouseLocation, vehicle, alpha, entity, _)
            local total = 30
            local point, textLabel, humanoid, label, line, button
            repeat
                if total > 82 then
                    if total < 170 then
                        if total <= 132 then
                            button = button(label, point)
                            total, textLabel = 208 - total, Vector2
                            textLabel, point, label = textLabel.zero, targetPosition, targetPosition.Max
                        else
                            total = 211
                            point = 1
                        end
                    elseif total < 207 then
                        label, humanoid, total, textLabel, point = gameProcessed[1][3], "Square", total + -118, pattern, stack
                    elseif total <= 207 then
                        return nil
                    else
                        label.Thickness = point
                        line, textLabel, total, humanoid, point = _, label, 5064 / total, vehicle, gameProcessed[2][3]
                    end
                elseif total <= 67 then
                    if total > 52 then
                        point = mouseLocation.Y
                        textLabel = 0
                        total = 82
                        label = point <= 0
                    elseif total >= 30 then
                        if total > 30 then
                            label = label(point, textLabel, humanoid)
                            label.Position = targetPosition
                            label.Size = mouseLocation
                            label.Filled = alpha
                            point = entity
                            total = entity and 263 - total or 149 or 149
                        else
                            total = 132
                            button = targetPosition + mouseLocation
                            point, button, label = workspace.CurrentCamera.ViewportSize, button.Min, button
                        end
                    else
                        point(textLabel, humanoid, line)
                        return label
                    end
                elseif total <= 76 then
                    targetPosition = label(point, textLabel)
                    mouseLocation = button - targetPosition
                    textLabel = 0
                    point = mouseLocation.X
                    label = point <= 0
                    total = label and 82 or 67 or 67
                else
                    total = label and 207 or total + 88
                end
            until false
        end
    end,
    Gd = function(entity, amount, duration, targetPlayer)
        entity.Dd[targetPlayer] = entity.a(amount, 50036) / entity.a(duration, 27054)
        return entity.Dd[targetPlayer]
    end, pd = {},
    Yb = function(amount, _)
        return function(fileHandle)
            local label = 38
            local rootPart
            while true do
                if label <= 38 then
                    _[1][3].enabled = fileHandle
                    label = 53
                    rootPart = _[2][3]
                else
                    rootPart()
                    return
                end
            end
        end
    end,
    v = function(amount, _)
        return function(name)
            _[1][3].colorShift.bottom = name
        end
    end,
    Sa = function(amount, _)
        return function(item)
            _[1][3].ShowFOV = item
        end
    end,
    ib = function(triangle, gameProcessed)
        return function(chunk)
            local progress = 16
            local bestDistance, line, start, deltaZ, button, identifier, humanoidRootPart, nearestDistance, total, offset, deltaY, Lighting, textLabel, rootPart, attachment, Scheduler, _
            repeat
                if progress <= 117 then
                    if progress >= 41 then
                        if progress >= 90 then
                            if progress > 103 then
                                if progress >= 114 then
                                    if progress > 114 then
                                        identifier(_)
                                        identifier = gameProcessed[1][3].objects
                                        _ = nil
                                        progress, identifier[deltaZ] = 336 - progress, nil
                                    else
                                        gameProcessed[3][3][deltaZ] = nil
                                        rootPart = gameProcessed[6][3]
                                        _ = nil
                                        identifier = rootPart.Replicator.Actors
                                        identifier[deltaZ] = nil
                                        progress = bestDistance >= offset and 14 or progress + 32
                                    end
                                else
                                    _ = _(rootPart, button)
                                    identifier = not _
                                    progress = identifier and 24289 / progress or 13161 / progress
                                end
                            elseif progress < 94 then
                                if progress <= 90 then
                                    progress = 55
                                    _ = deltaZ
                                    identifier = gameProcessed[5][3]
                                else
                                    deltaZ = 0.4
                                    humanoidRootPart.scanAt = deltaY() + 0.4
                                    humanoidRootPart = ipairs
                                    progress = 136
                                    nearestDistance = gameProcessed[2][3]
                                    nearestDistance, deltaY = nearestDistance.GetPlayers, nearestDistance
                                end
                            elseif progress > 94 then
                                progress = _ and 8 or 13 or 13
                            else
                                progress, rootPart = 6956 / progress, gameProcessed[1][3]
                                rootPart, _ = identifier, rootPart.Kind
                            end
                        elseif progress < 58 then
                            if progress <= 53 then
                                if progress <= 41 then
                                    rootPart = start.model
                                    progress = 1
                                    _ = deltaZ.Character
                                    identifier = _ ~= rootPart
                                else
                                    rootPart, progress, _ = deltaZ, 13197 / progress, gameProcessed[1][3].Kind
                                end
                            else
                                progress = 14
                                identifier(_)
                            end
                        elseif progress >= 74 then
                            if progress > 74 then
                                _ = deltaZ.IsDescendantOf
                                rootPart = deltaZ
                                progress = 107
                                button = workspace
                            else
                                _ = _(rootPart)
                                progress = _ and 223 - progress or 103 or 103
                            end
                        elseif progress > 58 then
                            humanoidRootPart = humanoidRootPart()
                            deltaY = humanoidRootPart
                            nearestDistance = pairs
                            progress = humanoidRootPart and 226 or progress + 80
                        else
                            nearestDistance = nearestDistance()
                            deltaZ = gameProcessed[1][3]
                            deltaY = deltaZ.scanAt
                            progress = 235
                            humanoidRootPart = nearestDistance < deltaY
                        end
                    elseif progress > 17 then
                        if progress <= 35 then
                            if progress > 33 then
                                nearestDistance = gameProcessed[6][3]
                                start = gameProcessed[4][3]
                                progress = 199
                                deltaY = nearestDistance.Replicator.Actors
                                nearestDistance.Replicator.LocalActor = deltaY[start.Character]
                                deltaZ = gameProcessed[1][3]
                                humanoidRootPart = pairs
                                nearestDistance = deltaZ.objects
                            elseif progress > 30 then
                                deltaZ, start = humanoidRootPart(nearestDistance, deltaY)
                                deltaY = deltaZ
                                progress = deltaZ == nil and 163 or progress + 151
                            elseif progress > 27 then
                                _ = start
                                progress = 117
                                identifier = gameProcessed[7][3]
                            else
                                return
                            end
                        elseif progress > 36 then
                            rootPart = {actor = identifier, model = identifier.Character, drawings = {},}
                            progress, button = 193 - progress, {}
                            rootPart.adornments = button
                            rootPart.nextRay = 0
                            _ = rootPart
                            gameProcessed[1][3].objects[identifier] = rootPart
                            button = rootPart
                            rootPart = gameProcessed[8][3]
                        else
                            progress, button, rootPart = progress + 86, _, gameProcessed[8][3]
                        end
                    elseif progress <= 13 then
                        if progress < 8 then
                            if progress <= 1 then
                                progress = identifier and 246 or 251 or 251
                            else
                                _ = _(rootPart, button)
                                progress, identifier = 454 / progress, not _
                            end
                        elseif progress > 9 then
                            start, identifier = nearestDistance(deltaY, deltaZ)
                            deltaZ = start
                            progress = start == nil and 186 or 94 or 94
                        elseif progress <= 8 then
                            button = gameProcessed[1][3]
                            _ = button.objects[identifier]
                            rootPart = not _
                            progress = rootPart and 47 - progress or 36 or 36
                        else
                            start = {}
                            progress, deltaY = 2070 / progress, start
                        end
                    elseif progress < 16 then
                        deltaZ = humanoidRootPart(nearestDistance, deltaY)
                        deltaY = deltaZ
                        progress = deltaZ == nil and 490 / progress or 97 - progress
                    elseif progress > 16 then
                        progress = deltaY and 230 or progress + -8
                    else
                        total = 154
                        humanoidRootPart = not chunk
                        Scheduler = 39
                        progress = humanoidRootPart and 241 or 235 or 235
                    end
                elseif progress >= 199 then
                    if progress < 228 then
                        if progress > 225 then
                            if progress > 226 then
                                progress = identifier and 114 or 90 or 90
                            else
                                deltaY = humanoidRootPart.Replicator
                                progress = Lighting >= line and progress + 1 or progress + -81
                            end
                        elseif progress <= 219 then
                            if progress >= 212 then
                                if progress <= 212 then
                                    start = humanoidRootPart.Replicator
                                    deltaY = start.Actors
                                    progress = Scheduler <= total and 229 - progress or 442 - progress
                                else
                                    deltaZ, start = humanoidRootPart(nearestDistance, deltaY)
                                    deltaY = deltaZ
                                    progress = deltaZ == nil and 365 - progress or 53 or 53
                                end
                            else
                                humanoidRootPart, nearestDistance, deltaY = humanoidRootPart(nearestDistance)
                                humanoidRootPart, nearestDistance, deltaY = triangle.b(humanoidRootPart, nearestDistance, deltaY)
                                deltaZ, start = humanoidRootPart(nearestDistance, deltaY)
                                deltaY = deltaZ
                                progress = deltaZ == nil and 345 - progress or 53 or 53
                            end
                        else
                            humanoidRootPart, nearestDistance, deltaY = humanoidRootPart(triangle.d(nearestDistance))
                            humanoidRootPart, nearestDistance, deltaY = triangle.b(humanoidRootPart, nearestDistance, deltaY)
                            deltaZ, start = humanoidRootPart(nearestDistance, deltaY)
                            deltaY = deltaZ
                            progress = deltaZ == nil and 163 or 184 or 184
                        end
                    elseif progress > 241 then
                        if progress >= 249 then
                            if progress <= 249 then
                                _ = _(rootPart)
                                identifier = not _
                                progress = identifier and 1 or 41 or 41
                            else
                                rootPart = start.model
                                _ = rootPart.Parent
                                progress, identifier = 61746 / progress, not _
                            end
                        else
                            progress = identifier and 30 or 219 or 219
                        end
                    elseif progress > 235 then
                        progress = 58
                        deltaY = os
                        nearestDistance = os.clock
                    elseif progress >= 230 then
                        if progress > 230 then
                            textLabel = 133
                            attachment = 43
                            progress = humanoidRootPart and 27 or 415 - progress
                        else
                            progress = progress + -86
                        end
                    else
                        identifier(_)
                        progress = textLabel < attachment and 83 or 261 - progress
                    end
                elseif progress <= 146 then
                    if progress >= 142 then
                        if progress < 145 then
                            if progress > 142 then
                                nearestDistance, deltaY, deltaZ = nearestDistance(deltaY)
                                nearestDistance, deltaY, deltaZ = triangle.b(nearestDistance, deltaY, deltaZ)
                                start, identifier = nearestDistance(deltaY, deltaZ)
                                deltaZ = start
                                progress = start == nil and progress + 42 or 13536 / progress
                            else
                                humanoidRootPart, nearestDistance, deltaY = humanoidRootPart(nearestDistance)
                                humanoidRootPart, nearestDistance, deltaY = triangle.b(humanoidRootPart, nearestDistance, deltaY)
                                deltaZ = humanoidRootPart(nearestDistance, deltaY)
                                deltaY = deltaZ
                                progress = deltaZ == nil and progress + -107 or 83 or 83
                            end
                        elseif progress > 145 then
                            nearestDistance = gameProcessed[1][3]
                            progress = 65
                            humanoidRootPart = nearestDistance.Service
                        else
                            progress = deltaY and 212 or 17 or 17
                        end
                    elseif progress >= 123 then
                        if progress <= 123 then
                            progress = 2
                            button = "Humanoid"
                            _ = deltaZ.FindFirstChildOfClass
                            rootPart = deltaZ
                        else
                            progress, nearestDistance = 225, triangle.c(nearestDistance(deltaY))
                        end
                    else
                        progress = 13
                        rootPart(button)
                    end
                elseif progress >= 180 then
                    if progress < 184 then
                        bestDistance, deltaZ, offset, humanoidRootPart, progress, Lighting, line = 191, os, 59, gameProcessed[1][3], progress + -87, 48, 239
                        deltaY = deltaZ.clock
                    elseif progress <= 184 then
                        identifier, progress, _ = gameProcessed[5][3], 412 - progress, start.Character
                    else
                        return
                    end
                elseif progress < 154 then
                    progress, rootPart = 15347 / progress, identifier.Character
                    _ = rootPart.Parent
                elseif progress <= 154 then
                    progress = 13
                    rootPart(button)
                else
                    progress = 142
                    nearestDistance = gameProcessed[3][3]
                    humanoidRootPart = pairs
                end
            until false
        end
    end, md = {},
    Vb = function(amount, _)
        return function(parent)
            _[1][3].boxFill = parent
        end
    end,
    Kc = function(triangle, gameProcessed)
        return function(stack, pattern, duration, weight, ...)
            local total = 120
            local label, offset, line, _, TweenService, rootPart, button, identifier
            repeat
                if total <= 123 then
                    if total > 111 then
                        if total <= 120 then
                            total = 75
                            offset = gameProcessed[1][3].contexts
                            _ = coroutine
                            identifier = coroutine.running
                        else
                            total, _ = total + 87, identifier
                        end
                    elseif total <= 109 then
                        if total <= 75 then
                            line, offset, _ = offset[identifier()], pcall, gameProcessed[1][3]
                            rootPart, total, _, identifier, button = pattern.Stats, 241, duration, _.Direction, line
                        else
                            total, weight = total + 2, identifier
                        end
                    else
                        button = duration
                        rootPart = pattern
                        label = weight
                        _ = stack
                        total = 129
                        TweenService = triangle.c(...)
                    end
                elseif total <= 210 then
                    if total > 129 then
                        total = _ and 22890 / total or 111 or 111
                    else
                        _ = table.pack(_(rootPart, button, label, triangle.d(TweenService)))
                        return table.unpack(_, 1, _.n)
                    end
                else
                    offset, identifier = offset(identifier, _, rootPart, button)
                    _ = offset
                    total = offset and 123 or 210 or 210
                end
            until false
        end
    end,
    q = function(amount, gameProcessed)
        return function(targetPlayer)
            local label = 237
            local humanoid, rootPart, identifier
            repeat
                if label >= 183 then
                    if label > 200 then
                        label = 188
                        gameProcessed[1][3].shadows.enabled = targetPlayer
                        rootPart = gameProcessed[2][3]
                        humanoid = gameProcessed[5][3]
                        identifier = targetPlayer
                    elseif label < 188 then
                        return
                    elseif label > 188 then
                        label = 36600 / label
                        rootPart(humanoid)
                    else
                        rootPart(humanoid, identifier)
                        label = 51
                        humanoid = gameProcessed[3][3]
                        identifier = targetPlayer
                    end
                elseif label >= 165 then
                    if label <= 165 then
                        identifier = gameProcessed[4][3]
                        label = 183
                        rootPart = gameProcessed[6][3]
                        rootPart.GlobalShadows = identifier.GlobalShadows
                        humanoid = identifier.ShadowSoftness
                        rootPart.ShadowSoftness = humanoid
                    else
                        label = 200
                        humanoid = amount:Jb({gameProcessed[6], gameProcessed[1],})
                        rootPart = pcall
                    end
                else
                    rootPart(humanoid, identifier)
                    label = targetPlayer and 176 or 165 or 165
                end
            until false
        end
    end,
    sb = function(amount, gameProcessed)
        return function(targetPlayer)
            local label = 13
            local deltaY, line, offset, humanoid, rootPart
            repeat
                if label <= 155 then
                    if label < 72 then
                        if label <= 13 then
                            if label <= 8 then
                                if label <= 4 then
                                    humanoid = targetPlayer.IsA
                                    line = "Model"
                                    label = 233
                                    deltaY = targetPlayer
                                else
                                    line(offset)
                                    return
                                end
                            else
                                rootPart = not targetPlayer
                                label = rootPart and 222 or 4 or 4
                            end
                        else
                            humanoid = targetPlayer
                            label = 227
                            deltaY = "Humanoid"
                            rootPart = targetPlayer.FindFirstChildOfClass
                        end
                    elseif label <= 140 then
                        if label >= 87 then
                            if label > 87 then
                                gameProcessed[1][3][targetPlayer] = true
                                humanoid = gameProcessed[2][3].Replicator.Actors
                                deltaY = humanoid[targetPlayer]
                                line = not deltaY
                                label = line and 295 - label or 193 or 193
                            else
                                return
                            end
                        else
                            return
                        end
                    else
                        label, line = label + 38, {}
                        line.UID = targetPlayer
                        line.Character = targetPlayer
                        deltaY = line
                        humanoid[targetPlayer] = line
                    end
                elseif label >= 209 then
                    if label <= 227 then
                        if label < 222 then
                            label, deltaY, line, humanoid = label + -47, targetPlayer, workspace, targetPlayer.IsDescendantOf
                        elseif label > 222 then
                            rootPart = rootPart(humanoid, deltaY)
                            humanoid = not rootPart
                            label = humanoid and 72 or 140 or 140
                        else
                            label = rootPart and 383 - label or label + -13
                        end
                    else
                        label, humanoid = 222, humanoid(deltaY, line)
                        rootPart = not humanoid
                    end
                elseif label <= 162 then
                    if label > 161 then
                        humanoid = humanoid(deltaY, line)
                        label, rootPart = label + -1, not humanoid
                    else
                        label = rootPart and 87 or 177 - label
                    end
                else
                    label, offset = label + -185, gameProcessed[3][3]
                    line, offset = offset.Refresh, deltaY
                end
            until false
        end
    end,
    W = function(amount, _)
        return function(radius)
            _[1][3].HitPart = radius
        end
    end, Dd = {},
    Rb = function(amount, _)
        return function(fileHandle)
            _[1][3].enabled = fileHandle
        end
    end,
    B = function(triangle, gameProcessed)
        return function(columnIndex)
            local progress = 147
            local humanoidRootPart, total, rootPart, deltaZ, nearestDistance, identifier, heap, start, line, deltaY, bestDistance, _, offset, Scheduler, label, button, top, textLabel, Lighting, humanoid
            repeat
                if progress <= 151 then
                    if progress <= 70 then
                        if progress >= 27 then
                            if progress >= 40 then
                                if progress <= 50 then
                                    if progress <= 40 then
                                        deltaY = deltaY(deltaZ, heap)
                                        heap = getcustomasset
                                        deltaZ = assert
                                        progress = getcustomasset and 70 or 121 or 121
                                    else
                                        progress = 219
                                        identifier = "Custom font loading is unavailable"
                                    end
                                else
                                    heap = writefile
                                    progress = total >= humanoid and progress + 51 or 25 or 25
                                end
                            elseif progress < 36 then
                                progress = 156
                                deltaZ(heap)
                            elseif progress > 36 then
                                progress = heap and 25 or 1850 / progress
                            else
                                deltaZ = {[1] = 3, [3] = deltaZ(heap, identifier),}
                                progress, deltaZ[2] = 234, deltaZ
                                heap = pcall
                                identifier = triangle:Lb({deltaZ, deltaY})
                            end
                        elseif progress <= 12 then
                            if progress >= 9 then
                                if progress <= 9 then
                                    progress = heap and 154 - progress or 37 or 37
                                else
                                    return gameProcessed[1][3].Cache[columnIndex]
                                end
                            else
                                deltaY = {[1] = 3, [3] = deltaY(deltaZ),}
                                deltaY[2] = deltaY
                                deltaY[3].Font = nearestDistance
                                deltaY[3].Text = "Font"
                                deltaY[3].Size = 14
                                deltaY[3].Width = 200
                                progress = 36
                                deltaZ = game
                                identifier = "TextService"
                                deltaZ, heap = deltaZ.GetService, deltaZ
                            end
                        elseif progress > 13 then
                            progress, heap = 1250 / progress, isfolder
                        else
                            offset = offset(Lighting)
                            bestDistance.assetId = offset
                            progress, textLabel[1] = 170, bestDistance
                            label.faces = textLabel
                            rootPart, button = rootPart.JSONEncode, rootPart
                        end
                    elseif progress <= 134 then
                        if progress > 111 then
                            if progress <= 121 then
                                progress = heap and 154 or 1089 / progress
                            else
                                progress = 203
                                deltaZ = humanoidRootPart
                                deltaY = Font.fromEnum
                            end
                        elseif progress <= 106 then
                            if progress >= 103 then
                                if progress > 103 then
                                    _(rootPart)
                                    rootPart, button, _, progress, label = heap, tostring, assert, progress + -3, identifier
                                else
                                    progress, button = 351 - progress, triangle.c(button(label))
                                end
                            else
                                identifier = identifier(_)
                                heap = not identifier
                                progress = heap and 22700 / progress or 171 or 171
                            end
                        else
                            progress = 176
                            identifier(_, triangle.d(rootPart))
                            _ = getcustomasset
                            rootPart = heap
                            identifier = Font.new
                        end
                    elseif progress <= 147 then
                        if progress <= 146 then
                            if progress > 145 then
                                heap = heap(identifier)
                                deltaZ = not heap
                                progress = deltaZ and 180 or 156 or 156
                            else
                                progress = 37
                                heap = makefolder
                            end
                        else
                            deltaY = gameProcessed[1][3]
                            nearestDistance = deltaY.Cache
                            humanoidRootPart = nearestDistance[columnIndex]
                            progress = humanoidRootPart and 12 or 187 or 187
                        end
                    else
                        deltaY = Instance.new
                        progress = 6
                        deltaZ = "GetTextBoundsParams"
                    end
                elseif progress <= 187 then
                    if progress > 175 then
                        if progress <= 180 then
                            if progress < 179 then
                                progress, _ = 179, triangle.c(_(rootPart))
                            elseif progress > 179 then
                                heap = "LinoriaFonts"
                                progress = 27
                                deltaZ = makefolder
                            else
                                identifier = identifier(triangle.d(_))
                                nearestDistance = identifier
                                progress = start <= top and 134 or 151 or 151
                            end
                        else
                            deltaY = gameProcessed[1][3]
                            Scheduler = 2
                            line = 4
                            nearestDistance = nil
                            humanoidRootPart = deltaY.Builtins[columnIndex]
                            progress = humanoidRootPart and 134 or 42262 / progress
                        end
                    elseif progress <= 170 then
                        if progress < 156 then
                            if progress <= 154 then
                                progress = 9
                                heap = isfile
                            else
                                identifier = identifier(_)
                                progress, heap = progress + -115, heap .. identifier
                            end
                        elseif progress <= 156 then
                            heap = "LinoriaFonts"
                            start = 181
                            top = 27
                            deltaZ = "LinoriaFonts" .. "/" .. deltaY
                            identifier = isfile
                            progress = 100
                            _ = deltaZ
                        else
                            progress, rootPart = 281 - progress, triangle.c(rootPart(button, label))
                        end
                    elseif progress > 171 then
                        progress, heap = 404 - progress, heap(identifier, _)
                        identifier = assert
                        button = 1024
                        _ = #heap > 1024
                        rootPart = "Font download is incomplete"
                    else
                        identifier, progress, heap = writefile, 375 - progress, "LinoriaFonts" .. "/" .. deltaY .. ".json"
                        label = "HttpService"
                        _ = heap
                        rootPart = game
                        button, rootPart = rootPart, rootPart.GetService
                    end
                elseif progress <= 227 then
                    if progress >= 219 then
                        if progress > 226 then
                            heap = game
                            identifier, progress, heap, _ =
                                heap, progress + -52, heap.HttpGet,
                                "https://raw.githubusercontent.com/i77lhm/storage/f58e45bdfab788c545200318d764474cc7cc99a5/fonts/" .. deltaY
                        elseif progress <= 219 then
                            deltaZ(heap, identifier)
                            progress, heap, identifier = progress + -73, isfolder, "LinoriaFonts"
                        else
                            humanoid = 94
                            deltaY = assert
                            total = 233
                            deltaZ = gameProcessed[1][3].Files[columnIndex]
                            identifier = tostring
                            _ = columnIndex
                            progress = 155
                            heap = "Unknown font: "
                        end
                    elseif progress > 203 then
                        rootPart = rootPart(button, label)
                        label = {name = columnIndex}
                        textLabel = {}
                        bestDistance = {name = "Regular", weight = 400}
                        progress, offset = progress + -191, "normal"
                        bestDistance.style = "normal"
                        Lighting = deltaZ
                        offset = getcustomasset
                    else
                        deltaY = deltaY(deltaZ)
                        nearestDistance = deltaY
                        progress = line <= Scheduler and progress + -133 or 151 or 151
                    end
                elseif progress < 248 then
                    if progress <= 229 then
                        progress = progress + 24
                        identifier(_, rootPart)
                        identifier = writefile
                        rootPart = heap
                        _ = deltaZ
                    else
                        progress = progress + -128
                        heap, identifier = heap(identifier)
                        rootPart = deltaY[3]
                        _ = deltaY[3].Destroy
                    end
                elseif progress > 248 then
                    progress = 171
                    identifier(_, rootPart)
                else
                    _(rootPart, triangle.d(button))
                    gameProcessed[1][3].Cache[columnIndex] = nearestDistance
                    return nearestDistance
                end
            until false
        end
    end,
}):Jd(...)
