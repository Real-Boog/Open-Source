-- ts file was created by boog x XD | https://discord.gg/pAfq65sShf
-- this is for bloxstrike

if not game:IsLoaded() then
    game.Loaded:Wait()
end
local v1 = game:GetService("Workspace")
local v2 = game:GetService("RunService")
local v3 = game:GetService("UserInputService")
local v4 = game:GetService("HttpService")
local v5 = game:GetService("Lighting")
local v6 = game:GetService("CoreGui")
local v7 = v1:FindFirstChildOfClass("Terrain")
if ((getgenv and getgenv()) or _G).DeepHatSuiteUnload then
    pcall(((getgenv and getgenv()) or _G).DeepHatSuiteUnload)
end
if ((getgenv and getgenv()) or _G).VisualCatalogUnload then
    pcall(((getgenv and getgenv()) or _G).VisualCatalogUnload)
end
local v8 = game:GetService("ReplicatedStorage"):WaitForChild("Assets", 10)
local v9 = {Ambient = game:GetService("Lighting").Ambient, OutdoorAmbient = v5.OutdoorAmbient, Brightness = v5.Brightness, ClockTime = v5.ClockTime, FogEnd = v5.FogEnd, GlobalShadows = v5.GlobalShadows}
pcall(function()
    if ((type(Drawing) == "table") or (type(Drawing) == "userdata")) then
        local v136
        if (Drawing.new("Line")) then
            pcall(function()
                v136:Remove()
            end)
        end
    end
end)
local function v10(v137)
    local v138 = {}
    local v139 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    for v141 = 1, #v139 do
        v138[v139:byte(v141)] = v141 - (1)
    end
    local v140 = {}
    for v142 = 1, #v137, 4 do
        local v143, v144, v145, v146 = v137:byte(v142, v142 + (3))
        if (not v143 or not v144) then
            break
        end
        local v147 = (v138[v143] * (262144)) + (v138[v144] * (4096)) + ((v138[v145] or (0)) * (64)) + (v138[v146] or (0))
        local v148 = math.floor(v147 / (65536))
        local v149 = math.floor(v147 / (256)) % (256)
        local v150 = v147 % (256)
        if (v146 and (v146 ~= (61))) then
            v140[#v140 + (1)] = string.char(v148, v149, v150)
        elseif (v145 and (v145 ~= (61))) then
            v140[#v140 + 1] = string.char(v148, v149)
        else
            v140[#v140 + (1)] = string.char(v148)
        end
    end
    return table.concat(v140)
end
pcall(function()
    if ((type(writefile) == "function") and (typeof(((typeof(getcustomasset) == "function") and getcustomasset) or ((typeof(getsynasset) == "function") and getsynasset)) == "function")) then
        if ((type(isfolder) == "function") and (type(makefolder) == "function") and not isfolder("TG_cheatorgame0_Assets")) then
            makefolder("TG_cheatorgame0_Assets")
        end
        writefile("TG_cheatorgame0_Assets/Pumpkin.png", v10(v741))
        local v151 = (((typeof(getcustomasset) == "function") and getcustomasset) or ((typeof(getsynasset) == "function") and getsynasset))("TG_cheatorgame0_Assets/Pumpkin.png")
    end
end)
local v11 = {"Factory New", "Minimal Wear", "Field-Tested", "Well-Worn", "Battle-Scarred"}
local v12 = {"Karambit", "Butterfly Knife", "M9 Bayonet", "Skeleton Knife", "Gut Knife", "Flip Knife", "Stiletto Knife", "CT Knife", "T Knife"}
local v13 = {["CT Knife"] = true, ["T Knife"] = true, Knife = true}
local v14 = {Knife = true}
for v152, v153 in ipairs(v12) do
    v14[v153] = true
    v13[v153] = true
end
local v15 = {"Sports Gloves", "Operator Gloves", "Driver Gloves", "Hand Wraps", "Specialist Gloves", "Moto Gloves"}
local v16 = {}
for v154, v155 in ipairs(v15) do
    v16[v155] = true
end
local v17 = {["HE Grenade"] = true, ["Incendiary Grenade"] = true, Molotov = true, ["Smoke Grenade"] = true, Flashbang = true, ["Decoy Grenade"] = true, C4 = true, ["CT Glove"] = true, ["T Glove"] = true}
local v18 = {Gold = Color3.fromRGB(230, 170, 50), Red = Color3.fromRGB(225, 70, 75), Pink = Color3.fromRGB(215, 85, 220), Purple = Color3.fromRGB(145, 90, 240), Blue = Color3.fromRGB(80, 140, 245)}
local v19 = {"Fade", "Doppler", "Gamma Doppler", "Emerald", "Ruby", "Sapphire", "Dragon Lore", "Lore", "Printstream", "Neo-Noir", "Asiimov", "Crimson Web", "Slaughter", "Case Hardened", "Tiger Tooth", "Decimator", "Olympus", "Aloha", "Hyper Beast", "Vulcan", "Wildfire"}
local v20 = {
    {Name = "Тёмная Фиолетовая", WinBg = Color3.fromRGB(20, 16, 28), TopBg = Color3.fromRGB(28, 22, 38), CardBg = Color3.fromRGB(32, 26, 44), Stroke = Color3.fromRGB(68, 52, 92), Accent = Color3.fromRGB(190, 115, 255), Text = Color3.fromRGB(245, 240, 255), TextDim = Color3.fromRGB(155, 140, 175)},
    {Name = "Светлая Витрина", WinBg = Color3.fromRGB(244, 244, 248), TopBg = Color3.fromRGB(234, 234, 242), CardBg = Color3.fromRGB(255, 255, 255), Stroke = Color3.fromRGB(210, 212, 224), Accent = Color3.fromRGB(220, 75, 115), Text = Color3.fromRGB(40, 40, 52), TextDim = Color3.fromRGB(130, 130, 145)},
    {Name = "Полночь (Синяя)", WinBg = Color3.fromRGB(15, 19, 28), TopBg = Color3.fromRGB(21, 27, 40), CardBg = Color3.fromRGB(26, 33, 48), Stroke = Color3.fromRGB(48, 62, 90), Accent = Color3.fromRGB(95, 165, 255), Text = Color3.fromRGB(235, 242, 255), TextDim = Color3.fromRGB(130, 145, 170)},
    {Name = "Кровавый Багровый", WinBg = Color3.fromRGB(22, 13, 16), TopBg = Color3.fromRGB(32, 18, 22), CardBg = Color3.fromRGB(38, 22, 27), Stroke = Color3.fromRGB(82, 38, 48), Accent = Color3.fromRGB(245, 75, 95), Text = Color3.fromRGB(250, 235, 238), TextDim = Color3.fromRGB(165, 125, 135)},
    {Name = "Изумрудный Неон", WinBg = Color3.fromRGB(13, 22, 18), TopBg = Color3.fromRGB(18, 30, 25), CardBg = Color3.fromRGB(23, 38, 31), Stroke = Color3.fromRGB(42, 78, 62), Accent = Color3.fromRGB(0, 235, 145), Text = Color3.fromRGB(232, 250, 242), TextDim = Color3.fromRGB(125, 165, 145)},
}
local v21 = {
    masterEnabled = true,
    menuVisible = true,
    themeIdx = 1,
    activeCategory = "ALL",
    targetKnifeModel = "Karambit",
    targetKnifeSkin = "Fade",
    lastAppliedKnife = {weapon = "Karambit", skin = "Fade", label = "Karambit | Fade"},
    activeGloveWeapon = nil,
    activeGloveSkin = nil,
    activeGloveWear = "Factory New",
    gloveScaleMult = 1,
    gloveAnchorMode = true,
    selectedGunSkins = {},
    selectedGunWear = "Factory New",
    spectatorListEnabled = true,
    spectatorPos = UDim2.new(1, -275, 0.35, 0),
    spectatorWidth = 260,
    worldLighting = false,
    nightMode = false,
    cloudsEnabled = false,
    vmChamsEnabled = false,
    vmForceFieldArms = false,
    noFlashSmoke = false,
    customCrosshair = false,
    customFovEnabled = false,
    fovValue = 105,
    pumpkinsEnabled = true,
    hudKnifeIconEnabled = true,
}
local v22 = {
    Enabled = true,
    TeamCheck = false,
    Chams = true,
    ContourOnly = true,
    Boxes = true,
    Names = true,
    HealthBar = true,
    MaxDistance = 4000,
    Colors = {T_Contour = Color3.fromRGB(255, 145, 35), CT_Contour = Color3.fromRGB(55, 205, 255), HealthLow = Color3.fromRGB(255, 60, 60), HealthHigh = Color3.fromRGB(60, 255, 90)},
}
local v23 = {enabled = true, skeleton = true, box = true, names = true, distance = true, chams = true, maxDistance = 5000, textSize = 13, zombieColor = Color3.fromRGB(255, 60, 200), buriedColor = Color3.fromRGB(255, 200, 80)}
local v24 = {}
if v8 and v8:WaitForChild("Skins", 10) then
    local v156 = {}
    for v157, v158 in ipairs((v8 and v8:WaitForChild("Skins", 10)):GetChildren()) do
        local v159
        v159 = v158.Name
        if (not v17[v159] and not v14[v159] and not v16[v159] and not v156[v159]) then
            v156[v159] = true
            table.insert(v24, v159)
        end
    end
    table.sort(v24)
end
local function v25()
    local v160, v161 = pcall(function()
        return gethui and gethui()
    end)
    if (v160 and (typeof(v161) == "Instance")) then
        return v161
    end
    local v162, v163 = pcall(function()
        return v6
    end)
    if (v162 and (typeof(v163) == "Instance")) then
        return v163
    end
    return v742:WaitForChild("PlayerGui")
end
local function v26(v164)
    return (type(v164) == "string") and ((v13[v164] == true) or (v14[v164] == true) or (v164:find("Knife") ~= nil) or (v164:find("Bayonet") ~= nil) or (v164:find("Karambit") ~= nil))
end
local v27 = {["Left Arm"] = true, ["Right Arm"] = true, Glove = true, CG0_CustomGlove = true, LeftHand = true, RightHand = true, LeftLowerArm = true, RightLowerArm = true, LeftUpperArm = true, RightUpperArm = true}
local function v28(v165, v166)
    local v167
    if (not v165 or not v165:IsA("BasePart")) then
        return true
    end
    if v27[v165.Name] then
        return true
    end
    v167 = v165.Name:lower()
    if ((v167 == "sleeve") or (v167 == "left sleeve") or (v167 == "right sleeve")) then
        return true
    end
    if v166 then
        local v168 = v166:FindFirstChild("Left Arm")
        local v169 = v166:FindFirstChild("Right Arm")
        if ((v168 and v165:IsDescendantOf(v168)) or (v169 and v165:IsDescendantOf(v169))) then
            return true
        end
    end
    return false
end
local v29 = {}
local v30 = setmetatable({}, {__mode = "k"})
local v31 = setmetatable({}, {__mode = "k"})
pcall(function()
    for v170, v171 in ipairs(v12) do
        local v172
        v172 = v743:FindFirstChild(v171)
        if (v743:FindFirstChild(v171)) then
            for v173, v174 in ipairs(v172:GetDescendants()) do
                if (v174:IsA("MeshPart") and (v174.MeshId ~= "") and not v28(v174, v172)) then
                    v29[v174.MeshId] = v171
                end
            end
        end
    end
end)
local function v32(v175)
    if (not v175 or not v175:IsA("Model")) then
        return false
    end
    if v26(v175.Name) then
        return true
    end
    for v176, v177 in ipairs(v175:GetDescendants()) do
        if (v177:IsA("MeshPart") and (v29[v177.MeshId] ~= nil)) then
            return true
        end
    end
    return false
end
local function v33()
    local v178
    v178 = v742:GetAttribute("CurrentEquipped")
    if ((type(v178) == "string") and (v178 ~= "")) then
        local v179
        local v180
        v179, v180 = pcall(v4.JSONDecode, v4, v178)
        if (v179 and (type(v180) == "table")) then
            return v180.Weapon or v180.Name
        end
    end
    return nil
end
local function v34()
    local v181 = {}
    local function v182(v183)
        for v184, v185 in ipairs(v183:GetChildren()) do
            if v185:IsA("Model") then
                if (v185:FindFirstChild("Left Arm") or v185:FindFirstChild("Right Arm") or v185:FindFirstChild("DummyParts") or v185:FindFirstChild("Weapon") or (v744 and v744:FindFirstChild(v185.Name))) then
                    table.insert(v181, v185)
                end
            elseif (v185:IsA("Folder") and (v185.Name == "ViewmodelStash")) then
                v182(v185)
            end
        end
    end
    v182(v745)
    return v181
end
local function v35(v186, v187)
    local v188
    local v189
    if not v744 then
        return "Fade"
    end
    v188 = v744:FindFirstChild(v186)
    if not v188 then
        return (v187 and v187[1]) or "Fade"
    end
    v189 = v188:GetChildren()
    if (#v189 == (0)) then
        return "Vanilla"
    end
    for v190, v191 in ipairs(v187 or v19) do
        local v192
        v192 = v191:lower()
        for v193, v194 in ipairs(v189) do
            if (v194.Name:lower() == v192) then
                return v194.Name
            end
        end
        for v195, v196 in ipairs(v189) do
            if v196.Name:lower():find(v192, 1, true) then
                return v196.Name
            end
        end
    end
    return v189[1].Name
end
local function v36(v197, v198, v199, v200)
    if (not v744 or not v197 or not v198) then
        return nil
    end
    local v201 = v744:FindFirstChild(v197)
    if not v201 then
        for v204, v205 in ipairs(v744:GetChildren()) do
            if (v205.Name:lower() == tostring(v197):lower()) then
                v201 = v205
                break
            end
        end
    end
    if not v201 then
        return nil
    end
    local v202 = v201:FindFirstChild(v198)
    if not v202 then
        for v206, v207 in ipairs(v201:GetChildren()) do
            if (v207.Name:lower() == tostring(v198):lower()) then
                v202 = v207
                break
            end
        end
    end
    if not v202 then
        return nil
    end
    local v203 = v202:FindFirstChild(v200 or "Camera") or v202:FindFirstChild("Camera") or v202:FindFirstChild("Character") or v202
    if (v199 and v203:FindFirstChild(v199)) then
        return v203:FindFirstChild(v199)
    end
    for v208, v209 in ipairs(v11) do
        if v203:FindFirstChild(v209) then
            return v203[v209]
        end
    end
    return v203:FindFirstChildOfClass("Folder") or v203
end
local v37 = {BG = Color3.fromRGB(192, 192, 192), LightEdge = Color3.fromRGB(255, 255, 255), MidEdge = Color3.fromRGB(128, 128, 128), DarkEdge = Color3.fromRGB(0, 0, 0), TitleBar1 = Color3.fromRGB(0, 0, 128), TitleBar2 = Color3.fromRGB(16, 132, 208), TitleText = Color3.fromRGB(255, 255, 255), Text = Color3.fromRGB(0, 0, 0), TextDim = Color3.fromRGB(128, 128, 128)}
local v38 = {
    Root = nil,
    CountLabel = nil,
    ListContainer = nil,
    Rows = {},
    LastUpdate = 0,
}
local function v39(v210)
    local v211 = Instance.new("Frame", v210)
    v211.Size = UDim2.new(1, 0, 0, 1)
    v211.Position = UDim2.new(0, 0, 0, 0)
    local v212 = Instance.new("Frame", v210)
    v212.Size = UDim2.new(0, 1, 1, 0)
    v212.Position = UDim2.new(0, 0, 0, 0)
    local v213 = Instance.new("Frame", v210)
    v213.Size = UDim2.new(1, 0, 0, 1)
    v213.Position = UDim2.new(0, 0, 1, -1)
    local v214 = Instance.new("Frame", v210)
    v214.Size = UDim2.new(0, 1, 1, 0)
    v214.Position = UDim2.new(1, -1, 0, 0)
end
local function v40(v215)
    v746 = Instance.new("Frame", v215)
    v746.Size = UDim2.new(1, 0, 0, 1)
    v746.Position = UDim2.new(0, 0, 0, 0)
    v747 = Instance.new("Frame", v215)
    v747.Size = UDim2.new(0, 1, 1, 0)
    v747.Position = UDim2.new(0, 0, 0, 0)
    v748 = Instance.new("Frame", v215)
    v748.Size = UDim2.new(1, 0, 0, 1)
    v748.Position = UDim2.new(0, 0, 1, -1)
    v749 = Instance.new("Frame", v215)
    v749.Size = UDim2.new(0, 1, 1, 0)
    v749.Position = UDim2.new(1, -1, 0, 0)
end
local function v41(v216)
    local v217
    local v218
    local v219
    if (v216 == v742) then
        return false
    end
    v217 = v742.Name:lower()
    v218 = v742.DisplayName:lower()
    v219 = tostring(v742.UserId)
    for v220, v221 in ipairs({"SpectateTarget", "SpectatingTarget", "Spectating", "TargetPlayer", "Observing", "Spectate", "CameraTarget"}) do
        local v222
        v222 = v216:GetAttribute(v221)
        if (v222 ~= nil) then
            if (typeof(v222) == "Instance") then
                if ((v222 == v742) or (v222 == v742.Character)) then
                    return true
                end
            else
                local v223
                v223 = tostring(v222):lower()
                if ((v223 == v217) or (v223 == v218) or (v223 == v219)) then
                    return true
                end
            end
        end
    end
    for v224, v225 in ipairs(v216:GetChildren()) do
        local v226 = v225.Name:lower()
        if (v226:find("spectat") or v226:find("target") or v226:find("observ")) then
            if (v225:IsA("ObjectValue") and ((v225.Value == v742) or (v225.Value == v742.Character))) then
                return true
            elseif v225:IsA("StringValue") then
                local v227 = v225.Value:lower()
                if ((v227 == v217) or (v227 == v218)) then
                    return true
                end
            end
        end
    end
    return false
end
local function v42(v228)
    if (v38.Root and v38.Root.Parent) then
        return v38.Root
    end
    local v229 = Instance.new("Frame")
    v229.Name = "DeepHatSpectatorList"
    v229.Size = UDim2.new(0, v21.spectatorWidth, 0, 62)
    v229.Position = v21.spectatorPos
    v229.BackgroundColor3 = v37.BG
    v229.BorderSizePixel = 0
    v229.ZIndex = 10
    v229.Active = true
    v229.Parent = v228
    v39(v229)
    local v230, v231, v232
    v229.InputBegan:Connect(function(v239)
        if (v239.UserInputType == Enum.UserInputType.MouseButton1) then
            v231 = v239.Position
            v232 = v229.Position
            v239.Changed:Connect(function()
            end)
        end
    end)
    v3.InputChanged:Connect(function(v240)
        if (v230 and (v240.UserInputType == Enum.UserInputType.MouseMovement)) then
            local v241 = v240.Position - v231
            v229.Position = UDim2.new(v232.X.Scale, v232.X.Offset + v241.X, v232.Y.Scale, v232.Y.Offset + v241.Y)
            v21.spectatorPos = v229.Position
        end
    end)
    local v233 = Instance.new("Frame")
    v233.Size = UDim2.new(1, -8, 0, 22)
    v233.Position = UDim2.new(0, 4, 0, 4)
    v233.BackgroundColor3 = v37.TitleBar1
    v233.BorderSizePixel = 0
    v233.ZIndex = 12
    v233.Parent = v229
    Instance.new("UIGradient", v233).Color = ColorSequence.new({ColorSequenceKeypoint.new(0, v37.TitleBar1), ColorSequenceKeypoint.new(1, v37.TitleBar2)})
    local v234 = Instance.new("TextLabel")
    v234.Size = UDim2.new(1, -32, 1, 0)
    v234.Position = UDim2.new(0, 4, 0, 0)
    local v235 = Instance.new("TextButton")
    v235.Size = UDim2.new(0, 20, 0, 16)
    v235.Position = UDim2.new(1, -22, 0, 3)
    v235.BackgroundColor3 = v37.BG
    v235.BorderSizePixel = 0
    v235.Text = "X"
    v235.TextColor3 = v37.Text
    v235.Font = Enum.Font.SourceSansBold
    v235.TextSize = 13
    v235.ZIndex = 14
    v235.Parent = v233
    v39(v235)
    v235.MouseButton1Click:Connect(function()
        v21.spectatorListEnabled = false
        v229.Visible = false
    end)
    local v236 = Instance.new("TextLabel")
    v236.Size = UDim2.new(1, -16, 0, 22)
    v236.Position = UDim2.new(0, 8, 0, 30)
    v236.BackgroundTransparency = 1
    v236.Text = "Nobody is watching you"
    v236.TextColor3 = v37.TextDim
    v236.TextXAlignment = Enum.TextXAlignment.Left
    v236.Font = Enum.Font.SourceSansBold
    v236.TextSize = 14
    v236.ZIndex = 12
    v236.Parent = v229
    local v237 = Instance.new("Frame")
    v237.Size = UDim2.new(1, -16, 0, 0)
    v237.Position = UDim2.new(0, 8, 0, 54)
    v237.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    v237.BorderSizePixel = 0
    v237.ZIndex = 12
    v237.Visible = false
    v237.Parent = v229
    v40(v237)
    local v238 = Instance.new("UIListLayout", v237)
    v38.Root = v229
    v38.CountLabel = v236
    v38.ListContainer = v237
    return v229
end
local function v43(v242)
    if (not v21.masterEnabled or not v21.spectatorListEnabled) then
        if v38.Root then
            v38.Root.Visible = false
        end
    end
    local v243 = v42(v242)
    local v244 = os.clock()
    v38.LastUpdate = v244
    local v245 = 0
    pcall(function()
    end)
    local v246 = {}
    for v248, v249 in ipairs(v750:GetPlayers()) do
        if v41(v249) then
            table.insert(v246, v249.DisplayName .. " (@" .. v249.Name .. ")")
        end
    end
    local v247 = math.max(v245, #v246)
    if v38.CountLabel then
        if (v247 == (0)) then
            v38.CountLabel.Text = "Nobody is watching you"
            v38.CountLabel.TextColor3 = v37.TextDim
        elseif (v247 == (1)) then
            v38.CountLabel.Text = "1 spectator is watching"
            v38.CountLabel.TextColor3 = v37.Text
        else
            v38.CountLabel.Text = v247 .. " spectators are watching"
            v38.CountLabel.TextColor3 = v37.Text
        end
    end
    for v250, v251 in ipairs(v38.Rows) do
        v251:Destroy()
    end
    table.clear(v38.Rows)
    if ((v247 > (0)) and (#v246 > (0)) and v38.ListContainer) then
        local v252
        v38.ListContainer.Visible = true
        v252 = (#v246 * (18)) + (4)
        v38.ListContainer.Size = UDim2.new(1, -16, 0, v252)
        v243.Size = UDim2.new(0, v21.spectatorWidth, 0, (62) + v252)
        for v253, v254 in ipairs(v246) do
            local v255 = Instance.new("TextLabel")
            v255.Size = UDim2.new(1, -8, 0, 18)
            v255.BackgroundTransparency = 1
            v255.Font = Enum.Font.SourceSans
            v255.TextSize = 14
            v255.TextColor3 = v37.Text
            v255.TextXAlignment = Enum.TextXAlignment.Left
            v255.TextTruncate = Enum.TextTruncate.AtEnd
            v255.Text = "  " .. v254
            v255.LayoutOrder = v253
            v255.ZIndex = 13
            v255.Parent = v38.ListContainer
            table.insert(v38.Rows, v255)
        end
    else
        if v38.ListContainer then
            v38.ListContainer.Visible = false
        end
        v243.Size = UDim2.new(0, v21.spectatorWidth, 0, 62)
    end
end
local v44 = {}
local v45 = {}
local v46 = {}
local v47 = setmetatable({}, {__mode = "k"})
local v48 = {}
local v49 = {}
pcall(function()
    local v256 = v751:GetAttribute("AvaiableSkins")
    if ((type((v751:GetAttribute("AvaiableSkins"))) == "string") and (v256 ~= "")) then
        local v257
        v257 = v4:JSONDecode(v256)
        if (type((v4:JSONDecode(v256))) == "table") then
            for v258, v259 in pairs(v257) do
                v44[v258] = {}
                v45[v258] = {}
                if (type(v259) == "table") then
                    for v260, v261 in pairs(v259) do
                        if (type(v261) == "table") then
                            local v262
                            local v263
                            v262 = v261.wearImages
                            if ((type(v262) == "table") and (type(v262[1]) == "table") and v262[1].assetId) then
                                local v264 = tostring(v262[1].assetId)
                                if not v264:find("^rbxassetid://") then
                                    v264 = "rbxassetid://" .. v264:gsub("%D", "")
                                end
                                v44[v258][v260] = v264
                                if v13[v258] then
                                    v46[v264] = true
                                end
                            end
                            v263 = tostring(v261.rarity or "")
                            if ((v263 == "Forbidden") or (v263 == "Special")) then
                                v45[v258][v260] = v18.Gold
                            elseif (v263 == "Red") then
                                v45[v258][v260] = v18.Red
                            elseif (v263 == "Pink") then
                                v45[v258][v260] = v18.Pink
                            elseif (v263 == "Purple") then
                                v45[v258][v260] = v18.Purple
                            else
                                v45[v258][v260] = v18.Blue
                            end
                        end
                    end
                end
            end
        end
    end
end)
local function v50()
    local v265
    local v266
    v265 = v21.targetKnifeModel or "Karambit"
    v266 = v21.targetKnifeSkin or "Fade"
    if v44[v265] then
        if v44[v265][v266] then
            return v44[v265][v266]
        end
        if v44[v265].Vanilla then
            return v44[v265].Vanilla
        end
        for v267, v268 in pairs(v44[v265]) do
            return v268
        end
    end
    return nil
end
local function v51(v269)
    local v270 = v50()
    local v271 = v21.targetKnifeModel or "Karambit"
    local v272 = os.clock()
    if (v269 or ((#v48 == (0)) and ((v272 - v752) > (6)))) then
        v752 = v272
        table.clear(v48)
        table.clear(v49)
        local v273 = v742:FindFirstChildOfClass("PlayerGui")
        if v273 then
            for v274, v275 in ipairs(v273:GetChildren()) do
                if (v275:IsA("ScreenGui") and (v275.Name ~= "CG0_CatalogSuite") and (v275.Name ~= "CG0_ESP_Overlay") and v275.Enabled) then
                    for v276, v277 in ipairs(v275:GetDescendants()) do
                        if (v277:IsA("ImageLabel") or v277:IsA("ImageButton")) then
                            local v278
                            local v279
                            local v280
                            local v281
                            v278 = (v277.Parent and v277.Parent.Name:lower()) or ""
                            v279 = v277.Name:lower()
                            v280 = v277.AbsolutePosition.X > (v745.ViewportSize.X * (0.5))
                            v281 = v279:find("knife") or v279:find("melee") or v278:find("knife") or v278:find("melee") or (v278 == "3") or (v278 == "slot3") or (v46[v277.Image] == true)
                            if (v280 and v281 and (v277.Image ~= "")) then
                                table.insert(v48, v277)
                            end
                        elseif v277:IsA("TextLabel") then
                            local v282 = v277.Text
                            if ((v282 == "CT Knife") or (v282 == "T Knife") or (v282 == "Knife") or v47[v277]) then
                                table.insert(v49, v277)
                            end
                        end
                    end
                end
            end
        end
    end
    for v283, v284 in ipairs(v48) do
        if (v284 and v284.Parent and (v284.Image ~= v270)) then
            if not v47[v284] then
                v47[v284] = {Image = v284.Image}
            end
            v284.Image = v270
        end
    end
    for v285, v286 in ipairs(v49) do
        if (v286 and v286.Parent and (v286.Text ~= v271)) then
            if not v47[v286] then
                v47[v286] = {Text = v286.Text}
            end
            v286.Text = v271
        end
    end
end
local function v52()
    for v287, v288 in pairs(v47) do
        if ((typeof(v287) == "Instance") and v287.Parent) then
            pcall(function()
                if v288.Image then
                    v287.Image = v288.Image
                end
                if v288.Text then
                    v287.Text = v288.Text
                end
            end)
        end
    end
    table.clear(v47)
    table.clear(v48)
    table.clear(v49)
end
local v53 = {
    SkinsModule = nil,
    ViewmodelModule = nil,
    originalGetCamera = nil,
    originalGetChar = nil,
    originalVmNew = nil,
    activeKnifeVm = nil,
    activeKnifeVc = nil,
    activeKnifeArgs = {},
    lastGcScan = 0,
    installed = false,
}
local function v54(v289)
    local v290
    v290 = v751
    for v291, v292 in ipairs(v289) do
        v290 = v290 and v290:FindFirstChild(v292)
        if not v290 then
            return nil
        end
    end
    return v290
end
local function v55(v293)
    local v294
    local v295
    local v296
    v294 = os.clock()
    if (not v293 and ((v294 - v53.lastGcScan) < (8))) then
        return v53.activeKnifeVm
    end
    v53.lastGcScan = v294
    if (type(getgc) ~= "function") then
        return nil
    end
    v295, v296 = pcall(getgc, true)
    if (not v295 or (type(v296) ~= "table")) then
        return nil
    end
    for v297, v298 in ipairs(v296) do
        if (type(v298) == "table") then
            local v299 = rawget(v298, "Viewmodel") or rawget(v298, "viewmodel") or rawget(v298, "_viewmodel")
            local v300 = rawget(v298, "Name") or rawget(v298, "WeaponName") or rawget(v298, "Weapon")
            if (type(v299) == "table") then
                local v301
                v301 = rawget(v299, "Model") or rawget(v299, "model")
                if ((typeof(v301) == "Instance") and (v26(tostring(v300)) or v32(v301))) then
                    v53.activeKnifeVc = v298
                    v53.activeKnifeVm = v299
                    return v299
                end
            end
        end
    end
    return v53.activeKnifeVm
end
local function v56()
    if v53.installed then
        return true
    end
    local v302 = v54({"Database", "Components", "Libraries", "Skins"})
    local v303 = v54({"Classes", "WeaponComponent", "Classes", "Viewmodel"})
    if (not v302 or not v303) then
        return false
    end
    local v304, v305 = pcall(require, v302)
    local v306, v307 = pcall(require, v303)
    if (not v304 or (type(v305) ~= "table") or not v306 or (type(v307) ~= "table")) then
        return false
    end
    if (type(v305.GetCameraModel) == "function") then
        v53.originalGetCamera = v305.GetCameraModel
        v305.GetCameraModel = function(v308, v309, ...)
            if v21.masterEnabled then
                if (v26(v308) and v21.lastAppliedKnife) then
                    local v312, v313 = pcall(v53.originalGetCamera, v21.targetKnifeModel, v21.targetKnifeSkin, ...)
                    if (v312 and v313) then
                        return v313
                    end
                    local v314, v315 = pcall(v53.originalGetCamera, v21.targetKnifeModel, "Vanilla", ...)
                    if (v314 and v315) then
                        return v315
                    end
                elseif ((type(v308) == "string") and v21.selectedGunSkins[v308] and v21.selectedGunSkins[v308].skin) then
                    local v316, v317 = pcall(v53.originalGetCamera, v308, v21.selectedGunSkins[v308].skin, ...)
                    if (v316 and v317) then
                        return v317
                    end
                end
            end
            local v310, v311 = pcall(v53.originalGetCamera, v308, v309, ...)
            return (v310 and v311) or nil
        end
    end
    if (type(v305.GetCharacterModel) == "function") then
        v53.originalGetChar = v305.GetCharacterModel
        v305.GetCharacterModel = function(v318, v319, ...)
            local v320
            local v321
            if v21.masterEnabled then
                if (v26(v318) and v21.lastAppliedKnife) then
                    local v322, v323 = pcall(v53.originalGetChar, v21.targetKnifeModel, v21.targetKnifeSkin, ...)
                    if (v322 and v323) then
                        return v323
                    end
                elseif ((type(v318) == "string") and v21.selectedGunSkins[v318] and v21.selectedGunSkins[v318].skin) then
                    local v324
                    local v325
                    v324, v325 = pcall(v53.originalGetChar, v318, v21.selectedGunSkins[v318].skin, ...)
                    if (v324 and v325) then
                        return v325
                    end
                end
            end
            v320, v321 = pcall(v53.originalGetChar, v318, v319, ...)
            return (v320 and v321) or nil
        end
    end
    if (type(v307.new) == "function") then
        v53.originalVmNew = v307.new
        v307.new = function(v326, v327, v328, ...)
            if v26(v327) then
                v53.activeKnifeVc = v326
                v53.activeKnifeArgs = {...}
                if (v21.masterEnabled and v21.lastAppliedKnife) then
                    local v331
                    local v332
                    v331, v332 = pcall(v53.originalVmNew, v326, v21.targetKnifeModel, v21.targetKnifeSkin, ...)
                    if (v331 and v332) then
                        v53.activeKnifeVm = v332
                        return v332
                    end
                end
            elseif (v21.masterEnabled and (type(v327) == "string") and v21.selectedGunSkins[v327] and v21.selectedGunSkins[v327].skin) then
                local v333, v334 = pcall(v53.originalVmNew, v326, v327, v21.selectedGunSkins[v327].skin, ...)
                if (v333 and v334) then
                    return v334
                end
            end
            local v329, v330 = pcall(v53.originalVmNew, v326, v327, v328, ...)
            if (v329 and v330) then
                if v26(v327) then
                    v53.activeKnifeVm = v330
                end
                return v330
            end
            return nil
        end
    end
    v53.SkinsModule = v305
    v53.ViewmodelModule = v307
    v53.installed = true
    return true
end
local function v57()
    if not v53.installed then
    end
    pcall(function()
        if (v53.SkinsModule and v53.originalGetCamera) then
            v53.SkinsModule.GetCameraModel = v53.originalGetCamera
        end
    end)
    pcall(function()
        if (v53.SkinsModule and v53.originalGetChar) then
            v53.SkinsModule.GetCharacterModel = v53.originalGetChar
        end
    end)
    pcall(function()
        if (v53.ViewmodelModule and v53.originalVmNew) then
            v53.ViewmodelModule.new = v53.originalVmNew
        end
    end)
    v53.installed = false
end
local function v58(v335, v336)
    v21.targetKnifeModel = v335
    v21.targetKnifeSkin = v336
    v21.lastAppliedKnife = {weapon = v335, skin = v336, label = v335 .. " | " .. v336}
    v56()
    if (not v53.activeKnifeVm or not v53.activeKnifeVc) then
        v55(true)
    end
    local v337 = v53.activeKnifeVm
    local v338 = v53.activeKnifeVc
    if ((type(v337) == "table") and (type(v338) == "table") and v53.originalVmNew) then
        local v339 = rawget(v337, "Model") or rawget(v337, "model")
        if ((typeof(v339) == "Instance") and (v339.Parent ~= nil)) then
            local v340 = v339.Parent == v745
            local v341 = v339.Parent
            local v342 = ((#v53.activeKnifeArgs > (0)) and v53.activeKnifeArgs) or {"Factory New"}
            local v343, v344 = pcall(v53.originalVmNew, v338, v335, v336, unpack(v342))
            if (v343 and (type(v344) == "table")) then
                local v345 = rawget(v344, "Model") or rawget(v344, "model")
                if (typeof(v345) == "Instance") then
                    pcall(function()
                        if (type(rawget(v337, "Animations") or rawget(v337, "LoadedAnimations")) == "table") then
                            for v346, v347 in pairs(rawget(v337, "Animations") or rawget(v337, "LoadedAnimations")) do
                                if ((typeof(v347) == "Instance") or (type(v347) == "userdata")) then
                                    pcall(function()
                                        v347:Stop(0)
                                    end)
                                end
                            end
                        end
                    end)
                    v345.Parent = v341
                    pcall(function()
                        v339:Destroy()
                    end)
                    for v348, v349 in pairs(v344) do
                        rawset(v337, v348, v349)
                    end
                    if (rawget(v338, "Viewmodel") ~= nil) then
                        rawset(v338, "Viewmodel", v337)
                    end
                    if (rawget(v338, "Name") ~= nil) then
                        rawset(v338, "Name", v335)
                    end
                    if v340 then
                        pcall(function()
                            if (type(v337.Equip) == "function") then
                                v337:Equip()
                            elseif (type(v337.PlayAnimation) == "function") then
                                v337:PlayAnimation("Equip")
                            end
                        end)
                    end
                    v51(true)
                    return true, "Мгновенно собран нож: " .. v335 .. " | " .. v336
                end
            end
        end
    end
    v51(true)
    return true, "Выбран нож: " .. v335 .. " | " .. v336
end
local function v59(v350, v351, v352, v353, v354)
    local v355 = v36(v351, v352, v353, v354 or "Camera")
    if not v355 then
        return false
    end
    local v356 = v355:FindFirstChild("SurfaceAppearance") or v355:FindFirstChildOfClass("SurfaceAppearance")
    local v357 = false
    for v358, v359 in ipairs(v350:GetDescendants()) do
        if (v359:IsA("BasePart") and not v28(v359, v350)) then
            local v360
            local v361
            v360 = v359:FindFirstChildOfClass("SurfaceAppearance")
            v361 = v355:FindFirstChild(v359.Name)
            if not (v361 and v361:IsA("SurfaceAppearance")) then
                for v362, v363 in ipairs(v355:GetChildren()) do
                    if (v363:IsA("SurfaceAppearance") and (v363.Name:lower() == v359.Name:lower())) then
                        v361 = v363
                        break
                    end
                end
            end
            if (not (v361 and v361:IsA("SurfaceAppearance")) and v356 and ((v360 ~= nil) or v359:IsA("MeshPart"))) then
                v361 = v356
            end
            if (v361 and v361:IsA("SurfaceAppearance")) then
                if (v30[v359] == nil) then
                    v30[v359] = (v360 and (v360.Name ~= "CG0_SkinSA") and v360:Clone()) or false
                end
                for v365, v366 in ipairs(v359:GetChildren()) do
                    if v366:IsA("SurfaceAppearance") then
                        v366:Destroy()
                    end
                end
                local v364 = v361:Clone()
                v357 = true
            end
        end
    end
    return v357
end
local function v60(v367)
    if (not v367 or not v744) then
        return nil
    end
    if v744:FindFirstChild(v367.Name) then
        return v367.Name
    end
    local v368 = v33()
    if (v368 and v744:FindFirstChild(v368)) then
        return v368
    end
    return nil
end
local function v61(v369)
    if v745 then
        for v372, v373 in ipairs(v745:GetChildren()) do
            if (v373:IsA("Model") and not v26(v373.Name) and not v32(v373)) then
                local v374
                v374 = v60(v373)
                if (v374 and not v26(v374)) then
                    local v375
                    v375 = v21.selectedGunSkins[v374]
                    if (v375 and v375.skin) then
                        local v376 = v375.wear or v21.selectedGunWear
                        local v377 = v374 .. "|" .. v375.skin .. "|" .. v376
                        if (v369 or (v31[v373] ~= v377)) then
                            if v59(v373, v374, v375.skin, v376, "Camera") then
                                v31[v373] = v377
                            end
                        end
                    end
                end
            elseif (v373:IsA("Folder") and (v373.Name == "ViewmodelStash")) then
                for v378, v379 in ipairs(v373:GetChildren()) do
                    if (v379:IsA("Model") and v744:FindFirstChild(v379.Name) and not v26(v379.Name)) then
                        local v380
                        v380 = v21.selectedGunSkins[v379.Name]
                        if (v380 and v380.skin) then
                            local v381 = v380.wear or v21.selectedGunWear
                            local v382 = v379.Name .. "|" .. v380.skin .. "|" .. v381
                            if (v369 or (v31[v379] ~= v382)) then
                                if v59(v379, v379.Name, v380.skin, v381, "Camera") then
                                    v31[v379] = v382
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    local v370 = v1:FindFirstChild("Characters")
    local v371 = (v370 and v370:FindFirstChild(v742.Name)) or v742.Character
    if v371 then
        for v383, v384 in ipairs(v371:GetChildren()) do
            if (v384:IsA("Model") and v744:FindFirstChild(v384.Name) and not v26(v384.Name)) then
                local v385
                v385 = v21.selectedGunSkins[v384.Name]
                if (v385 and v385.skin) then
                    local v386 = v385.wear or v21.selectedGunWear
                    local v387 = v384.Name .. "|" .. v385.skin .. "|" .. v386
                    if (v369 or (v31[v384] ~= v387)) then
                        if v59(v384, v384.Name, v385.skin, v386, "Character") then
                            v31[v384] = v387
                        end
                    end
                end
            end
        end
    end
end
local function v62(v388, v389, v390, v391)
    local v392 = v388 and v388:FindFirstChild(v389)
    local v393 = v392 and v392:FindFirstChild(v390)
    return (v393 and v393:IsA("Vector3Value") and v393.Value) or v391
end
local function v63(v394, v395)
    local v396
    local v397
    v396 = v395:lower()
    v397 = nil
    for v398, v399 in ipairs(v394:GetChildren()) do
        if v399:IsA("SurfaceAppearance") then
            if not v397 then
                v397 = v399
            end
            if v399.Name:lower():find(v396, 1, true) then
                return v399
            end
        end
    end
    return v397
end
local function v64(v400)
    if (v400:GetAttribute("CG0_OrigTrans") == nil) then
        v400:SetAttribute("CG0_OrigTrans", v400.Transparency)
    end
    if (v400.Transparency ~= (1)) then
        v400.Transparency = 1
        v400.LocalTransparencyModifier = 1
    end
    for v401, v402 in ipairs(v400:GetDescendants()) do
        if v402:IsA("BasePart") then
            if (v402:GetAttribute("CG0_OrigTrans") == nil) then
                v402:SetAttribute("CG0_OrigTrans", v402.Transparency)
            end
            if (v402.Transparency ~= (1)) then
                v402.Transparency = 1
                v402.LocalTransparencyModifier = 1
            end
        end
    end
end
local function v65(v403, v404, v405, v406)
    local v407
    local v408
    local v409
    local v410
    local v411
    local v412
    local v413
    local v414
    local v415
    local v416
    local v417
    local v418
    v407 = v403:FindFirstChild("Glove")
    v64(v407)
    v408 = tostring(v21.activeGloveWeapon) .. "_" .. tostring(v21.activeGloveSkin) .. "_" .. v404
    v409 = v403:FindFirstChild("CG0_CustomGlove")
    if (v409 and v409:IsA("MeshPart")) then
        if (v409:GetAttribute("GloveKey") == v408) then
        else
            v409:Destroy()
        end
    end
    v410 = v405:FindFirstChild(v404)
    v411 = v63(v406, v404)
    v412 = v62(v410, "Scales", "Camera", Vector3.new(0.1, 0.1, 0.1))
    v413 = v62(v410, "Rotations", "Camera", Vector3.new(0, 0, 0))
    v414 = v62(v410, "Offsets", "Camera", Vector3.new(0, 0, -0.1560000000000059))
    v415 = v410:Clone()
    v415.Name = "CG0_CustomGlove"
    v415:SetAttribute("GloveKey", v408)
    for v419, v420 in ipairs(v415:GetDescendants()) do
        if (v420:IsA("Folder") or v420:IsA("SurfaceAppearance") or v420:IsA("Weld") or v420:IsA("Motor6D") or v420:IsA("WeldConstraint")) then
            v420:Destroy()
        elseif v420:IsA("BasePart") then
            v420.Anchored = false
            v420.CanCollide = false
            v420.CanQuery = false
            v420.CanTouch = false
            v420.Massless = true
        end
    end
    if v411 then
        local v421 = v411:Clone()
    end
    v415.CanCollide = false
    v415.CanQuery = false
    v415.CanTouch = false
    v415.Massless = true
    v415.Anchored = false
    v415.Transparency = 0
    v415.LocalTransparencyModifier = 0
    v416 = v410.Size
    v417 = ((v412.Magnitude > (0.0009999999999763531)) and (v412.X < (0.5)) and (Vector3.new(v416.X * v412.X, v416.Y * v412.Y, v416.Z * v412.Z) * v21.gloveScaleMult)) or (v407.Size * v21.gloveScaleMult)
    v415.Size = v417
    v418 = CFrame.Angles(math.rad(v413.X), math.rad(v413.Y), math.rad(v413.Z))
    v753 = Instance.new("Weld")
    v753.C0 = (v21.gloveAnchorMode and v418) or (CFrame.new(v414) * v418)
    v753.C1 = CFrame.new()
    v415.Parent = v403
end
local function v66()
    local v422 = v743:FindFirstChild(v21.activeGloveWeapon)
    local v423 = v36(v21.activeGloveWeapon, v21.activeGloveSkin, v21.activeGloveWear, "Camera")
    for v424, v425 in ipairs(v34()) do
        local v426
        local v427
        v426 = v425:FindFirstChild("Left Arm")
        v427 = v425:FindFirstChild("Right Arm")
        if (v426 and v426:IsA("BasePart")) then
            v65(v426, "Left Arm", v422, v423)
        end
        if (v427 and v427:IsA("BasePart")) then
            v65(v427, "Right Arm", v422, v423)
        end
    end
end
local function v67()
    local v428
    v428 = v20[v21.themeIdx].Accent
    for v429, v430 in ipairs(v34()) do
        local v431 = v430:FindFirstChild("CG0_VMChams")
        if (v21.masterEnabled and v21.vmChamsEnabled) then
            if not v431 then
                v431 = Instance.new("Highlight")
                v431.Name = "CG0_VMChams"
                v431.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                v431.Parent = v430
            end
            v431.Adornee = v430
            v431.Enabled = true
            v431.FillColor = v428
            v431.OutlineColor = Color3.new(1, 1, 1)
            v431.FillTransparency = 0.85
            v431.OutlineTransparency = 0
        elseif v431 then
            v431.Enabled = false
        end
        if (v21.masterEnabled and v21.vmForceFieldArms) then
            for v432, v433 in ipairs(v430:GetDescendants()) do
                if (v433:IsA("BasePart") and v28(v433, v430) and (v433.Transparency < (0.9))) then
                    v433.Material = Enum.Material.ForceField
                    v433.Color = v428
                end
            end
        end
    end
end
local function v68()
    for v435, v436 in ipairs(v5:GetChildren()) do
        if (v436.Name:lower():find("flash") or v436.Name:lower():find("blur")) then
            if v436:IsA("PostEffect") then
                v436.Enabled = false
            end
        end
    end
    local v434 = v1:FindFirstChild("Debris")
    if v434 then
        for v437, v438 in ipairs(v434:GetChildren()) do
            if v438.Name:lower():find("smoke") then
                for v439, v440 in ipairs(v438:GetDescendants()) do
                    if v440:IsA("ParticleEmitter") then
                        v440.Enabled = false
                    end
                    if v440:IsA("BasePart") then
                        v440.Transparency = 1
                        v440.CanQuery = false
                    end
                end
            end
        end
    end
end
local function v69()
    v21.activeGloveWeapon = nil
    v21.activeGloveSkin = nil
    v21.selectedGunSkins = {}
    v21.lastAppliedKnife = nil
    v57()
    if v745 then
        for v441, v442 in ipairs(v745:GetDescendants()) do
            if ((v442.Name == "CG0_CustomGlove") or (v442.Name == "CG0_VMChams") or (v442.Name == "CG0_VMHighlight")) then
                pcall(function()
                    v442:Destroy()
                end)
            elseif (v442:IsA("BasePart") and (v442:GetAttribute("CG0_OrigTrans") ~= nil)) then
                local v443 = v442:GetAttribute("CG0_OrigTrans")
                v442.Transparency = v443
                v442.LocalTransparencyModifier = v443
                v442:SetAttribute("CG0_OrigTrans", nil)
            end
        end
    end
    for v444, v445 in ipairs(v34()) do
        v31[v445] = nil
        for v446, v447 in ipairs(v445:GetDescendants()) do
            if v447:IsA("BasePart") then
                local v448
                for v449, v450 in ipairs(v447:GetChildren()) do
                    if (v450.Name == "CG0_SkinSA") then
                        v450:Destroy()
                    end
                end
                v448 = v30[v447]
                if (v448 and (typeof(v448) == "Instance") and not v447:FindFirstChildOfClass("SurfaceAppearance")) then
                    v448:Clone().Parent = v447
                end
            end
        end
    end
    v52()
end
local v70 = v25()
for v451, v452 in ipairs({"CG0_CatalogSuite", "CG0_ESP_Overlay", "ZombieESP_Overlay", "CG0_HalloweenSuite", "DeepHatLinoria", "DeepHatSpectatorList"}) do
    local v453
    v453 = v25():FindFirstChild(v452)
    if v25():FindFirstChild(v452) then
        v453:Destroy()
    end
end
local v71 = Instance.new("ScreenGui")
Instance.new("ScreenGui").Name = "CG0_ESP_Overlay"
v71.IgnoreGuiInset = true
v71.ResetOnSpawn = false
v71.DisplayOrder = 50
v71.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
v71.Parent = v70
local v72 = Instance.new("Frame")
Instance.new("Frame").AnchorPoint = Vector2.new(0.5, 0.5)
v72.Position = UDim2.fromScale(0.5, 0.5)
v72.Size = UDim2.fromOffset(24, 24)
v72.BackgroundTransparency = 1
v72.Visible = false
v72.Parent = v71
local v73 = Instance.new("Frame", v72)
Instance.new("Frame", v72).AnchorPoint = Vector2.new(0.5, 0.5)
v73.Position = UDim2.fromScale(0.5, 0.5)
v73.Size = UDim2.fromOffset(14, 2)
v73.BackgroundColor3 = Color3.fromRGB(0, 255, 160)
local v74 = Instance.new("Frame", v72)
Instance.new("Frame", v72).AnchorPoint = Vector2.new(0.5, 0.5)
v74.Position = UDim2.fromScale(0.5, 0.5)
v74.Size = UDim2.fromOffset(2, 14)
v74.BackgroundColor3 = Color3.fromRGB(0, 255, 160)
local v75 = {
    {"Head", "UpperTorso"},
    {"UpperTorso", "LowerTorso"},
    {"UpperTorso", "LeftUpperArm"},
    {"LeftUpperArm", "LeftLowerArm"},
    {"LeftLowerArm", "LeftHand"},
    {"UpperTorso", "RightUpperArm"},
    {"RightUpperArm", "RightLowerArm"},
    {"RightLowerArm", "RightHand"},
    {"LowerTorso", "LeftUpperLeg"},
    {"LeftUpperLeg", "LeftLowerLeg"},
    {"LeftLowerLeg", "LeftFoot"},
    {"LowerTorso", "RightUpperLeg"},
    {"RightUpperLeg", "RightLowerLeg"},
    {"RightLowerLeg", "RightFoot"},
}
local v76 = {}
local v77 = {}
local v78 = {}
local v79 = {}
local function v80(v454, v455, v456)
    return Color3.new(v454.R + ((v455.R - v454.R) * v456), v454.G + ((v455.G - v454.G) * v456), v454.B + ((v455.B - v454.B) * v456))
end
local function v81(v457, v458)
    if v458 then
        local v459 = v458:GetAttribute("Team") or v458:GetAttribute("Role")
        if v459 then
            local v460
            v460 = tostring(v459):lower()
            if (v460:find("counter") or (v460 == "ct")) then
                return "CT"
            end
            if (v460:find("terror") or (v460 == "t")) then
                return "T"
            end
        end
        if (v458.Team and v458.Team.Name) then
            local v461 = v458.Team.Name:lower()
            if (v461:find("counter") or (v461 == "ct")) then
                return "CT"
            end
            if (v461:find("terror") or (v461 == "t")) then
                return "T"
            end
        end
    end
    if v457 then
        local v462 = v457:GetAttribute("Team") or v457:GetAttribute("Role")
        if v462 then
            local v464 = tostring(v462):lower()
            if (v464:find("counter") or (v464 == "ct")) then
                return "CT"
            end
            if (v464:find("terror") or (v464 == "t")) then
                return "T"
            end
        end
        local v463 = v457:GetAttribute("CharacterName")
        if v463 then
            if (v463 == v1:GetAttribute("CTCharacter")) then
                return "CT"
            end
            if (v463 == v1:GetAttribute("TCharacter")) then
                return "T"
            end
        end
    end
    return nil
end
local function v82()
    local v465
    local v466
    v465 = {}
    v466 = v1:FindFirstChild("HordeShells")
    if not v466 then
        v79 = v465
        return v465
    end
    for v467, v468 in ipairs(v466:GetChildren()) do
        if v468:IsA("Model") then
            local v469
            local v470
            v469 = v468:FindFirstChild("HumanoidRootPart")
            v470 = v468:FindFirstChild("Head")
            if (v469 and v470 and (v469.Position.Y > -500) and (v468:GetAttribute("Dead") ~= true)) then
                table.insert(v465, v468)
            end
        end
    end
    v79 = v465
    return v465
end
local function v83(v471)
    local v472 = {}
    for v474, v475 in ipairs(v75) do
        local v476
        local v477
        v476 = v471:FindFirstChild(v475[1])
        v477 = v471:FindFirstChild(v475[2])
        if (v476 and v477) then
            v472[v474] = {v476, v477}
        end
    end
    local v473 = {
        hrp = v471:FindFirstChild("HumanoidRootPart"),
        head = v471:FindFirstChild("Head"),
        boneRefs = v472,
        isBuried = v471.Name:lower():find("buried") ~= nil,
        lines = {},
        nameTxt = (v754 and Drawing.new("Text")) or nil,
        distTxt = (v754 and Drawing.new("Text")) or nil,
        box = (v754 and Drawing.new("Square")) or nil,
        chams = Instance.new("Highlight"),
        chamsApplied = false,
    }
    if v473.nameTxt then
        v473.nameTxt.Size = v23.textSize
        v473.nameTxt.Center = true
        v473.nameTxt.Outline = true
        v473.nameTxt.Visible = false
    end
    if v473.distTxt then
        v473.distTxt.Size = v23.textSize - (2)
        v473.distTxt.Center = true
        v473.distTxt.Outline = true
        v473.distTxt.Visible = false
    end
    if v473.box then
        v473.box.Thickness = 1.5
        v473.box.Filled = false
        v473.box.Visible = false
    end
    v473.chams.Name = "CG0_ZombieChams"
    v473.chams.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    v473.chams.FillTransparency = 0.55
    v473.chams.OutlineTransparency = 0
    v473.chams.Enabled = false
    v473.chams.Parent = v71
    if v754 then
        for v478 = 1, #v75 do
            local v479
            v479 = Drawing.new("Line")
            v479.Thickness = 1.6
            v479.Visible = false
            table.insert(v473.lines, v479)
        end
    end
    return v473
end
local function v84(v480)
    for v481, v482 in ipairs(v480.lines) do
        pcall(function()
            v482:Remove()
        end)
    end
    if v480.nameTxt then
        pcall(function()
            v480.nameTxt:Remove()
        end)
    end
    if v480.distTxt then
        pcall(function()
            v480.distTxt:Remove()
        end)
    end
    if v480.box then
        pcall(function()
            v480.box:Remove()
        end)
    end
    if v480.chams then
        pcall(function()
            v480.chams:Destroy()
        end)
    end
end
local function v85()
    local v483
    local v484
    if (not v21.masterEnabled or not v23.enabled) then
        for v485, v486 in pairs(v78) do
            for v487, v488 in ipairs(v486.lines) do
            end
            if v486.nameTxt then
                v486.nameTxt.Visible = false
            end
            if v486.distTxt then
                v486.distTxt.Visible = false
            end
            if v486.box then
                v486.box.Visible = false
            end
            if (v486.chams and v486.chams.Enabled) then
                v486.chams.Enabled = false
            end
        end
    end
    v483 = v745.CFrame.Position
    v484 = {}
    for v489, v490 in ipairs(v79) do
        if (v490 and v490.Parent) then
            local v491
            local v492
            local v493
            v491 = v78[v490]
            if not v491 then
                v491 = v83(v490)
                v78[v490] = v491
            end
            v492 = v491.hrp
            v493 = v491.head
            if (v492 and v493 and (v492.Position.Y > -500) and (v490:GetAttribute("Dead") ~= true)) then
                local v494 = (v492.Position - v483).Magnitude
                if (v494 <= v23.maxDistance) then
                    v484[v490] = true
                    local v495 = (v491.isBuried and v23.buriedColor) or v23.zombieColor
                    if (v23.skeleton and v754) then
                        for v496 = 1, #v75 do
                            local v497
                            local v498
                            v497 = v491.lines[v496]
                            v498 = v491.boneRefs[v496]
                            if (v497 and v498) then
                                local v499
                                local v500
                                local v501
                                local v502
                                v499, v500 = v745:WorldToViewportPoint(v498[1].Position)
                                v501, v502 = v745:WorldToViewportPoint(v498[2].Position)
                                if (v500 and v502 and (v499.Z > (0)) and (v501.Z > (0))) then
                                    v497.From = Vector2.new(v499.X, v499.Y)
                                    v497.To = Vector2.new(v501.X, v501.Y)
                                    v497.Color = v495
                                    v497.Visible = true
                                else
                                    v497.Visible = false
                                end
                            elseif v497 then
                                v497.Visible = false
                            end
                        end
                    else
                        for v503, v504 in ipairs(v491.lines) do
                        end
                    end
                    if (v23.box and v491.box) then
                        local v505, v506 = v745:WorldToViewportPoint(v493.Position + Vector3.new(0, 0.5, 0))
                        local v507, v508 = v745:WorldToViewportPoint(v492.Position - Vector3.new(0, 2.8000000000000114, 0))
                        if (v506 and v508 and (v505.Z > (0)) and (v507.Z > (0))) then
                            local v509 = math.abs(v505.Y - v507.Y)
                            local v510 = v509 * (0.6)
                            v491.box.Position = Vector2.new(v505.X - (v510 * (0.5)), v505.Y)
                            v491.box.Size = Vector2.new(v510, v509)
                            v491.box.Color = v495
                            v491.box.Visible = true
                        else
                            v491.box.Visible = false
                        end
                    elseif v491.box then
                        v491.box.Visible = false
                    end
                    if (v491.nameTxt and v491.distTxt) then
                        local v511, v512 = v745:WorldToViewportPoint(v493.Position + Vector3.new(0, 2.2000000000000455, 0))
                        if (v512 and (v511.Z > (0))) then
                            if v23.names then
                                local v513
                                v513 = (v491.isBuried and "[Buried] ") or "[Zombie] "
                                v491.nameTxt.Text = v513 .. v490.Name
                                v491.nameTxt.Position = Vector2.new(v511.X, v511.Y - (16))
                                v491.nameTxt.Color = v495
                                v491.nameTxt.Visible = true
                            else
                                v491.nameTxt.Visible = false
                            end
                            if v23.distance then
                                v491.distTxt.Text = math.floor(v494) .. "m"
                                v491.distTxt.Position = Vector2.new(v511.X, v511.Y + (2))
                                v491.distTxt.Color = v495
                                v491.distTxt.Visible = true
                            else
                                v491.distTxt.Visible = false
                            end
                        else
                            v491.nameTxt.Visible = false
                            v491.distTxt.Visible = false
                        end
                    end
                    if v23.chams then
                        if (not v491.chamsApplied or not v491.chams.Enabled) then
                            v491.chams.Adornee = v490
                            v491.chams.FillColor = v495
                            v491.chams.OutlineColor = v495
                            v491.chams.Enabled = true
                            v491.chamsApplied = true
                        end
                    elseif v491.chams.Enabled then
                        v491.chams.Enabled = false
                    end
                end
            end
        end
    end
    for v514, v515 in pairs(v78) do
        if not v484[v514] then
            v84(v515)
            v78[v514] = nil
        end
    end
end
local function v86()
    local v516
    local v517
    local v518
    local v519
    local v520
    local v521
    v516 = Instance.new("Frame")
    v516.BackgroundTransparency = 1
    v516.BorderSizePixel = 0
    v516.Visible = false
    v516.Parent = v71
    v517 = Instance.new("UIStroke")
    v517.Thickness = 1.5
    v517.Color = v22.Colors.T_Contour
    v517.Parent = v516
    v518 = Instance.new("Frame")
    v518.AnchorPoint = Vector2.new(1, 0)
    v518.Position = UDim2.new(0, -4, 0, 0)
    v518.Size = UDim2.new(0, 3, 1, 0)
    v518.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    v518.BackgroundTransparency = 0.25
    v518.BorderSizePixel = 0
    v518.Parent = v516
    v519 = Instance.new("Frame")
    v519.AnchorPoint = Vector2.new(0, 1)
    v519.Position = UDim2.fromScale(0, 1)
    v519.Size = UDim2.fromScale(1, 1)
    v519.BackgroundColor3 = Color3.fromRGB(60, 255, 90)
    v519.BorderSizePixel = 0
    v519.Parent = v518
    v520 = Instance.new("TextLabel")
    v520.AnchorPoint = Vector2.new(0.5, 1)
    v520.Position = UDim2.new(0.5, 0, 0, -3)
    v520.Size = UDim2.fromOffset(220, 16)
    v520.BackgroundTransparency = 1
    v520.Font = Enum.Font.GothamBold
    v520.TextSize = 12
    v520.TextColor3 = Color3.new(1, 1, 1)
    v520.TextStrokeTransparency = 0.25
    v520.Parent = v516
    v521 = Instance.new("Highlight")
    v521.Name = "CG0_ContourChams"
    v521.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    v521.FillTransparency = 0.9200000000000728
    v521.OutlineTransparency = 0
    v521.Enabled = false
    v521.Parent = v71
    return {Box = v516, Stroke = v517, HpBack = v518, HpFill = v519, NameLbl = v520, Highlight = v521, lastCol = nil, lastContour = nil, lastDistInt = -1}
end
local function v87(v522)
    if v522.Box then
        pcall(function()
            v522.Box:Destroy()
        end)
    end
    if v522.Highlight then
        pcall(function()
            v522.Highlight:Destroy()
        end)
    end
end
local function v88()
    local v523
    local v524
    local v525
    local v526
    local v527
    local v528
    local v529
    if (not v21.masterEnabled or not v22.Enabled) then
        v77 = {}
    end
    v523 = v1:FindFirstChild("Characters")
    v524 = (v523 and v523:FindFirstChild(v742.Name)) or v742.Character
    v525 = v81(v524, v742)
    v526 = tostring(v1:GetAttribute("Gamemode") or ""):lower():find("deathmatch") ~= nil
    v527 = {}
    v528 = {}
    v529 = nil
    function v529(v530, v531)
        local v532 = v530:FindFirstChild("HumanoidRootPart") or v530.PrimaryPart or v530:FindFirstChild("UpperTorso") or v530:FindFirstChild("Torso")
        local v533 = v530:FindFirstChildOfClass("Humanoid")
        local v534 = tonumber(v530:GetAttribute("Health")) or tonumber(v531 and v531:GetAttribute("Health")) or (v533 and v533.Health) or (100)
        local v535 = tonumber(v530:GetAttribute("MaxHealth")) or (v533 and (v533.MaxHealth > (0)) and v533.MaxHealth) or (100)
        local v536 = (tostring(v530:GetAttribute("Dead")) == "true") or (v531 and (tostring(v531:GetAttribute("Dead")) == "true")) or (v534 <= (0))
        local v537 = v81(v530, v531)
        local v538 = not v526 and (v525 ~= nil) and (v537 ~= nil) and (v525 == v537)
        v527[v530] = true
        local v539 = v537 or ((v525 == "T") and "CT") or "T"
        table.insert(v528, {model = v530, hrp = v532, head = v530:FindFirstChild("Head") or v532, hp = v534, maxHp = v535, team = v539, displayName = (v531 and v531.DisplayName) or v530.Name})
    end
    if v523 then
        for v540, v541 in ipairs(v523:GetChildren()) do
            if v541:IsA("Model") then
                local v542 = v750:FindFirstChild(v541.Name) or v750:GetPlayerFromCharacter(v541)
                v529(v541, v542)
            end
        end
    end
    for v543, v544 in ipairs(v750:GetPlayers()) do
        if ((v544 ~= v742) and v544.Character) then
            v529(v544.Character, v544)
        end
    end
    v77 = v528
end
local function v89()
    if (not v21.masterEnabled or not v22.Enabled) then
        for v547, v548 in pairs(v76) do
            if v548.Box.Visible then
                v548.Box.Visible = false
            end
            if v548.Highlight.Enabled then
                v548.Highlight.Enabled = false
            end
        end
    end
    local v545 = v745.CFrame.Position
    local v546 = {}
    for v549, v550 in ipairs(v77) do
        local v551 = v550.model
        local v552 = v550.hrp
        if (v551 and v551.Parent and v552 and v552.Parent) then
            v546[v551] = true
            local v553 = v76[v551]
            if not v553 then
                v553 = v86()
                v76[v551] = v553
            end
            local v554 = ((v550.team == "CT") and v22.Colors.CT_Contour) or v22.Colors.T_Contour
            if v22.Chams then
                if ((v553.Highlight.Adornee ~= v551) or (v553.lastCol ~= v554) or (v553.lastContour ~= v22.ContourOnly) or not v553.Highlight.Enabled) then
                    v553.Highlight.Adornee = v551
                    v553.Highlight.OutlineColor = v554
                    v553.Highlight.FillColor = v554
                    v553.Highlight.OutlineTransparency = 0
                    v553.Highlight.FillTransparency = (v22.ContourOnly and (0.92)) or (0.65)
                    v553.Highlight.Enabled = true
                    v553.lastCol = v554
                    v553.lastContour = v22.ContourOnly
                end
            elseif v553.Highlight.Enabled then
                v553.Highlight.Enabled = false
            end
            local v555 = v552.Position
            local v556 = (v555 - v545).Magnitude
            local v557, v558 = v745:WorldToViewportPoint(v555)
            if (not v558 or (v557.Z <= 0) or (v556 > v22.MaxDistance)) then
                if v553.Box.Visible then
                    v553.Box.Visible = false
                end
            else
                local v559
                local v560
                local v561
                local v562
                local v563
                v559 = v745:WorldToViewportPoint(v550.head.Position + Vector3.new(0, 0.7, 0))
                v560 = v745:WorldToViewportPoint(v555 - Vector3.new(0, 2.9, 0))
                v561 = math.max(math.abs(v560.Y - v559.Y), 10)
                v562 = v561 * (0.62)
                v563 = v22.Boxes or v22.HealthBar or v22.Names
                v553.Box.Visible = v563
                if v563 then
                    v553.Box.Position = UDim2.fromOffset(v557.X - (v562 * (0.5)), v559.Y)
                    v553.Box.Size = UDim2.fromOffset(v562, v561)
                    v553.Stroke.Enabled = v22.Boxes
                    v553.Stroke.Color = v554
                    v553.HpBack.Visible = v22.HealthBar
                    if v22.HealthBar then
                        local v564
                        v564 = math.clamp(v550.hp / math.max(v550.maxHp, 1), 0, 1)
                        v553.HpFill.Size = UDim2.fromScale(1, v564)
                        v553.HpFill.BackgroundColor3 = v80(v22.Colors.HealthLow, v22.Colors.HealthHigh, v564)
                    end
                    v553.NameLbl.Visible = v22.Names
                    if v22.Names then
                        local v565 = math.floor(v556)
                        if (v553.lastDistInt ~= v565) then
                            v553.lastDistInt = v565
                            v553.NameLbl.Text = string.format("%s [%dm]", v550.displayName, v565)
                        end
                        v553.NameLbl.TextColor3 = v554
                    end
                end
            end
        end
    end
    for v566, v567 in pairs(v76) do
        if not v546[v566] then
            if not v566.Parent then
                v87(v567)
                v76[v566] = nil
            else
                if v567.Box.Visible then
                    v567.Box.Visible = false
                end
                if v567.Highlight.Enabled then
                    v567.Highlight.Enabled = false
                end
            end
        end
    end
end
local function v90(v568, v569)
    if (v45[v568] and v45[v568][v569]) then
        return v45[v568][v569]
    end
    if (v14[v568] or v16[v568]) then
        return v18.Red
    end
    local v570 = v569:lower()
    if (v570:find("fade") or v570:find("lore") or v570:find("doppler") or v570:find("printstream") or v570:find("neo%-noir")) then
        return v18.Red
    elseif (v570:find("decimator") or v570:find("olympus") or v570:find("aloha") or v570:find("asiimov")) then
        return v18.Pink
    end
    return v18.Blue
end
local function v91(v571, v572, v573)
    local v574
    local v575
    local v576
    local v577
    local v578
    local v579
    local v580
    local v581
    local v582
    if v573 then
        v571:PivotTo(CFrame.new(0, 0, 0))
    end
    v574 = nil
    v575 = -1
    for v583, v584 in ipairs(v571:GetDescendants()) do
        if v584:IsA("BasePart") then
            local v585
            v585 = math.max(v584.Size.X, v584.Size.Y, v584.Size.Z)
            if (v585 > v575) then
                v575 = v585
                v574 = v584
            end
        end
    end
    if v574 then
        v571.PrimaryPart = v574
        v571:PivotTo(CFrame.new(0, 0, 0))
    end
    v755, v576 = v571:GetBoundingBox()
    v577 = {
        {vec = Vector3.xAxis, len = v576.X},
        {vec = Vector3.yAxis, len = v576.Y},
        {vec = Vector3.zAxis, len = v576.Z},
    }
    table.sort(v577, function(v586, v587)
        return v586.len > v587.len
    end)
    v578 = v577[1].vec
    v579 = v577[2].vec
    v580 = v578:Cross(v579)
    v580 = ((v580.Magnitude < (0.0009999999999763531)) and v577[3].vec) or v580.Unit
    v581 = CFrame.fromMatrix(Vector3.zero, v578, v579, v580):Inverse()
    v582 = (v572 and (CFrame.Angles(0, 0, math.rad(-36)) * CFrame.Angles(math.rad(10), math.rad(-12), 0))) or (CFrame.Angles(0, 0, math.rad(-6)) * CFrame.Angles(math.rad(6), math.rad(-10), 0))
    v571:PivotTo(v582 * v581)
end
local function v92(v588, v589, v590)
    local v591 = v44[v589] and v44[v589][v590]
    if (v591 and (v591 ~= "")) then
        v756 = Instance.new("ImageLabel")
        v756.Size = UDim2.new(1, -12, 1, -26)
        v756.Position = UDim2.fromOffset(6, 2)
    end
    local v592 = Instance.new("ViewportFrame")
    v592.Size = UDim2.new(1, -8, 1, -26)
    v592.Position = UDim2.fromOffset(4, 2)
    v592.BackgroundTransparency = 1
    v592.Ambient = Color3.fromRGB(220, 220, 230)
    v592.LightColor = Color3.fromRGB(255, 255, 255)
    v592.LightDirection = Vector3.new(-0.40000000000009095, -0.6, -1)
    v592.ZIndex = 3
    v592.Parent = v588
    local v593 = Instance.new("WorldModel")
    v593.Parent = v592
    local v594 = Instance.new("Camera")
    v594.FieldOfView = 30
    v594.Parent = v592
    v592.CurrentCamera = v594
    pcall(function()
        local v595 = v743:FindFirstChild(v589)
        if not (v743:FindFirstChild(v589)) then
        end
        local v596 = Instance.new("Model")
        local v597 = v36(v589, v590, "Factory New", "Camera")
        if v16[v589] then
            local v602 = v595:FindFirstChild("Right Arm")
            if ((v595:FindFirstChild("Left Arm") or v595:FindFirstChildWhichIsA("MeshPart", true)) and (v595:FindFirstChild("Left Arm") or v595:FindFirstChildWhichIsA("MeshPart", true)):IsA("BasePart")) then
                for v603, v604 in ipairs((v595:FindFirstChild("Left Arm") or v595:FindFirstChildWhichIsA("MeshPart", true)):Clone():GetChildren()) do
                    if (v604:IsA("SurfaceAppearance") or v604:IsA("JointInstance") or v604:IsA("Folder")) then
                        v604:Destroy()
                    end
                end
                if (v36(v589, v590, "Factory New", "Camera")) and v63(v597, "Left Arm") then
                    ((v36(v589, v590, "Factory New", "Camera")) and v63(v597, "Left Arm")):Clone().Parent = v757
                end
                v757.Anchored = true
                v757.CFrame = CFrame.new(-v757.Size.X * (0.6199999999998909), 0, 0) * CFrame.Angles(math.rad(20), math.rad(25), 0)
                v757.Parent = (Instance.new("Model"))
            end
            if ((v595:FindFirstChild("Right Arm")) and v602:IsA("BasePart")) then
                local v605
                for v606, v607 in ipairs(v602:Clone():GetChildren()) do
                    if (v607:IsA("SurfaceAppearance") or v607:IsA("JointInstance") or v607:IsA("Folder")) then
                        v607:Destroy()
                    end
                end
                if v597 and v63(v597, "Right Arm") then
                    (v597 and v63(v597, "Right Arm")):Clone().Parent = v605
                end
                v605.Anchored = true
                v605.CFrame = CFrame.new(v605.Size.X * (0.62), 0, 0) * CFrame.Angles(math.rad(20), math.rad(-25), 0)
                v605.Parent = v596
            end
        else
            local v608 = (v595:FindFirstChild("Weapon") or v595:FindFirstChild("Camera") or v595):Clone()
            for v609, v610 in ipairs((v595:FindFirstChild("Weapon") or v595:FindFirstChild("Camera") or v595):Clone():GetDescendants()) do
                if v610:IsA("BasePart") then
                    if (v28(v610, v608) or (v610.Transparency >= (0.9500000000000455))) then
                        v610:Destroy()
                    else
                        v610.Anchored = true
                        v610.CanCollide = false
                    end
                elseif (v610:IsA("JointInstance") or v610:IsA("WeldConstraint")) then
                    v610:Destroy()
                end
            end
            v608.Parent = v596
            v59(v596, v589, v590, "Factory New", "Camera")
        end
        for v611, v612 in ipairs(v596:GetDescendants()) do
            if v612:IsA("BasePart") then
                v758 = v758 + (1)
            end
        end
        if (v758 == (0)) then
            v596:Destroy()
        end
        v596.Parent = v593
        v91(v596, v14[v589] == true, v16[v589] == true)
        local v598, v599 = v596:GetBoundingBox()
        local v600 = math.max(v599.X * (0.82), v599.Y * (1.15), 0.35)
        local v601 = (v600 / ((2) * math.tan(math.rad(v594.FieldOfView / (2))))) * (1.1799999999999997)
        v594.CFrame = CFrame.lookAt(v598.Position + Vector3.new(0, 0, v601), v598.Position)
    end)
end
local v93 = Instance.new("ScreenGui")
Instance.new("ScreenGui").Name = "CG0_CatalogSuite"
v93.IgnoreGuiInset = true
v93.ResetOnSpawn = false
v93.DisplayOrder = 99999
v93.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
v93.Parent = v70
v42(v93)
local v94 = v20[v21.themeIdx]
local v95 = Instance.new("Frame")
Instance.new("Frame").AnchorPoint = Vector2.new(0.5, 0)
v95.Position = UDim2.new(0.5, 0, 0, 8)
v95.Size = UDim2.fromOffset(340, 28)
v95.BackgroundColor3 = v94.TopBg
v95.BorderSizePixel = 0
v95.ZIndex = 20
v95.Parent = v93
Instance.new("UICorner", v95).CornerRadius = UDim.new(0, 7)
local v96 = Instance.new("UIStroke", v95)
Instance.new("UIStroke", v95).Color = v94.Accent
local v97 = Instance.new("TextLabel")
Instance.new("TextLabel").Size = UDim2.fromScale(1, 1)
local v98 = Instance.new("Frame")
Instance.new("Frame").AnchorPoint = Vector2.new(0.5, 0.5)
v98.Position = UDim2.fromScale(0.5, 0.52)
v98.Size = UDim2.fromOffset(750, 560)
v98.BackgroundColor3 = v94.WinBg
v98.BorderSizePixel = 0
v98.Active = true
v98.ClipsDescendants = true
v98.Parent = v93
Instance.new("UICorner", v98).CornerRadius = UDim.new(0, 8)
local v99 = Instance.new("UIStroke", v98)
Instance.new("UIStroke", v98).Color = v94.Stroke
local v100 = Instance.new("TextButton")
Instance.new("TextButton").Name = "CursorModalUnlocker"
v100.Size = UDim2.fromOffset(1, 1)
local v101 = Instance.new("Frame")
Instance.new("Frame").Name = "FallingPumpkinsLayer"
v101.Size = UDim2.fromScale(1, 1)
v101.BackgroundTransparency = 1
v101.ClipsDescendants = true
v101.ZIndex = 1
v101.Parent = v98
local v102 = {}
for v613 = 1, 16 do
    local v614
    local v615
    v614 = math.random(18, 32)
    if (false) then
        local v616 = Instance.new("ImageLabel")
        Instance.new("ImageLabel").Size = UDim2.fromOffset((math.random(18, 32)), v614)
    else
        local v617
        v617 = Instance.new("Frame")
        Instance.new("Frame").Size = UDim2.fromOffset(v614, math.floor(v614 * (0.82)))
        v617.BackgroundColor3 = Color3.fromRGB(255, 135, 35)
        v617.BackgroundTransparency = 0.6499999999999773
        v617.BorderSizePixel = 0
        v617.ZIndex = 1
        v617.Parent = v101
        Instance.new("UICorner", v617).CornerRadius = UDim.new(0.45, 0)
    end
    table.insert(v102, {inst = v615, x = math.random(20, 720), y = math.random(-560, 560), speedY = math.random(38, 78), swayAmp = math.random(12, 30), swayFreq = math.random(8, 18) / (10), phase = math.random() * (6.280000000000001), rot = math.random(0, 360), rotSpeed = math.random(-55, 55)})
end
local function v103(v618)
    if (not v21.menuVisible or not v21.pumpkinsEnabled) then
        v101.Visible = false
    end
    v101.Visible = true
    local v619 = os.clock()
    for v620, v621 in ipairs(v102) do
        local v622
        v621.y = v621.y + (v621.speedY * v618)
        v621.rot = (v621.rot + (v621.rotSpeed * v618)) % 360
        if (v621.y > (580)) then
            v621.y = -40
            v621.x = math.random(20, 720)
        end
        v622 = v621.x + (math.sin((v619 * v621.swayFreq) + v621.phase) * v621.swayAmp)
        v621.inst.Position = UDim2.fromOffset(v622, v621.y)
        v621.inst.Rotation = v621.rot
    end
end
local v104 = Instance.new("Frame")
Instance.new("Frame").Size = UDim2.new(1, 0, 0, 44)
v104.BackgroundColor3 = v94.TopBg
v104.BorderSizePixel = 0
v104.ZIndex = 3
v104.Parent = v98
local v105 = Instance.new("Frame")
Instance.new("Frame").AnchorPoint = Vector2.new(0, 1)
v105.Position = UDim2.fromScale(0, 1)
v105.Size = UDim2.new(1, 0, 0, 2)
local v106 = Instance.new("TextLabel")
Instance.new("TextLabel").AnchorPoint = Vector2.new(1, 0.5)
v106.Position = UDim2.new(1, -128, 0.5, 0)
v106.Size = UDim2.fromOffset(240, 24)
local v107 = Instance.new("TextButton")
Instance.new("TextButton").AnchorPoint = Vector2.new(1, 0.5)
v107.Position = UDim2.new(1, -10, 0.5, 0)
v107.Size = UDim2.fromOffset(110, 28)
v107.BackgroundColor3 = v94.CardBg
v107.BorderSizePixel = 0
v107.Font = Enum.Font.GothamBold
v107.TextSize = 11
v107.TextColor3 = v94.Text
v107.Text = "ТЕМА: 1/" .. tostring(#v20)
v107.ZIndex = 4
v107.Parent = v104
Instance.new("UICorner", v107).CornerRadius = UDim.new(0, 6)
local v108 = Instance.new("UIStroke", v107)
Instance.new("UIStroke", v107).Color = v94.Accent
do
    local v623, v624, v625
    v104.InputBegan:Connect(function(v626)
        if (v626.UserInputType == Enum.UserInputType.MouseButton1) then
            v624 = v626.Position
            v625 = v98.Position
        end
    end)
    game:GetService("UserInputService").InputEnded:Connect(function(v627)
    end)
    v3.InputChanged:Connect(function(v628)
        if (v623 and (v628.UserInputType == Enum.UserInputType.MouseMovement)) then
            local v629
            v629 = v628.Position - v624
            v98.Position = UDim2.new(v625.X.Scale, v625.X.Offset + v629.X, v625.Y.Scale, v625.Y.Offset + v629.Y)
        end
    end)
end
local v109 = {}
local v110 = {}
local function v111(v630)
    v759 = v630
    for v631, v632 in pairs(v110) do
    end
    for v633, v634 in pairs(v109) do
    end
end
local function v112(v635, v636, v637)
    local v638 = Instance.new("TextButton")
    v638.Position = UDim2.fromOffset(v636, 0)
    v638.Size = UDim2.new(0, v637 or 75, 1, 0)
    v638.BackgroundTransparency = 1
    v638.Font = Enum.Font.GothamBold
    v638.TextSize = 13
    v638.TextColor3 = v94.TextDim
    v638.Text = v635
    v638.ZIndex = 4
    v638.Parent = v104
    local v639 = Instance.new("Frame")
    v639.Position = UDim2.fromOffset(0, 46)
    v639.Size = UDim2.new(1, 0, 1, -46)
    v639.BackgroundTransparency = 1
    v639.Visible = false
    v639.ZIndex = 2
    v639.Parent = v98
    v109[v635] = v638
    v110[v635] = v639
    v638.MouseButton1Click:Connect(function()
        v111(v635)
    end)
    return v639
end
local v113 = v112("SKINS", 10, 68)
local v114 = v112("ESP", 80, 56)
local v115 = v112("EVENT", 138, 68)
local v116 = v112("WORLD", 208, 72)
local v117 = v112("SETTING", 282, 82)
local v118 = Instance.new("Frame")
Instance.new("Frame").Position = UDim2.fromOffset(12, 6)
v118.Size = UDim2.new(1, -24, 0, 30)
v118.BackgroundTransparency = 1
v118.ZIndex = 3
v118.Parent = (v112("SKINS", 10, 68))
local v119 = Instance.new("UIListLayout", v118)
Instance.new("UIListLayout", v118).FillDirection = Enum.FillDirection.Horizontal
v119.Padding = UDim.new(0, 6)
local v120 = Instance.new("TextBox")
Instance.new("TextBox").Size = UDim2.fromOffset(195, 28)
v120.BackgroundColor3 = v94.CardBg
v120.BorderSizePixel = 0
v120.Font = Enum.Font.Gotham
v120.TextSize = 12
v120.TextColor3 = v94.Text
v120.PlaceholderText = "Поиск ножа, перчаток, пушки..."
v120.PlaceholderColor3 = v94.TextDim
v120.Text = ""
v120.ClearTextOnFocus = false
v120.ZIndex = 3
v120.Parent = v118
Instance.new("UICorner", v120).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", v120).Color = v94.Stroke
Instance.new("UIPadding", v120).PaddingLeft = UDim.new(0, 8)
local v121 = Instance.new("ScrollingFrame")
Instance.new("ScrollingFrame").Position = UDim2.fromOffset(12, 42)
v121.Size = UDim2.new(1, -24, 1, -50)
v121.BackgroundTransparency = 1
v121.BorderSizePixel = 0
v121.ScrollBarThickness = 5
v121.ScrollBarImageColor3 = v94.Accent
v121.AutomaticCanvasSize = Enum.AutomaticSize.Y
v121.CanvasSize = UDim2.new()
v121.ZIndex = 3
v121.Parent = v113
local v122 = Instance.new("UIGridLayout", v121)
Instance.new("UIGridLayout", v121).CellSize = UDim2.fromOffset(230, 155)
v122.CellPadding = UDim2.fromOffset(10, 10)
local v123 = {}
if v8 and v8:WaitForChild("Skins", 10) then
    for v640, v641 in ipairs(v12) do
        local v642 = (v8 and v8:WaitForChild("Skins", 10)):FindFirstChild(v641)
        if (v8 and v8:WaitForChild("Skins", 10)):FindFirstChild(v641) then
            for v643, v644 in ipairs(v642:GetChildren()) do
                table.insert(v123, {kind = "KNIFE", category = "KNIVES", weapon = v641, skin = v644.Name, title = v641 .. " | " .. v644.Name, color = v18.Red})
            end
        end
    end
    for v645, v646 in ipairs(v15) do
        local v647 = (v8 and v8:WaitForChild("Skins", 10)):FindFirstChild(v646)
        if (v8 and v8:WaitForChild("Skins", 10)):FindFirstChild(v646) then
            for v648, v649 in ipairs(v647:GetChildren()) do
                table.insert(v123, {kind = "GLOVE", category = "GLOVES", weapon = v646, skin = v649.Name, title = v646 .. " | " .. v649.Name, color = v18.Gold})
            end
        end
    end
    for v650, v651 in ipairs(v24) do
        local v652
        v652 = (v8 and v8:WaitForChild("Skins", 10)):FindFirstChild(v651)
        if (v8 and v8:WaitForChild("Skins", 10)):FindFirstChild(v651) then
            for v653, v654 in ipairs(v652:GetChildren()) do
                table.insert(v123, {kind = "GUN", category = "GUNS", weapon = v651, skin = v654.Name, title = v651 .. " | " .. v654.Name, color = v90(v651, v654.Name)})
            end
        end
    end
end
local v124 = {}
local v125 = {}
local function v126()
    v760 = v760 + (1)
    local v655 = v760
    local v656 = v20[v21.themeIdx]
    for v660, v661 in ipairs(v124) do
        v661:Destroy()
    end
    table.clear(v124)
    local v657 = v120.Text:lower()
    local v658 = v21.activeCategory
    local v659 = {}
    for v662, v663 in ipairs(v123) do
        local v664 = (v658 == "ALL") or (v663.category == v658)
        local v665 = (v657 == "") or (v663.title:lower():find(v657, 1, true) ~= nil)
        if (v664 and v665) then
            table.insert(v659, v663)
        end
    end
    task.spawn(function()
        for v666, v667 in ipairs(v659) do
            if ((v666 > (66)) and (v657 == "") and (v658 == "ALL")) then
                break
            end
            local v668 = Instance.new("TextButton")
            Instance.new("TextButton").BackgroundColor3 = v656.CardBg
            v668.BorderSizePixel = 0
            v668.Text = ""
            v668.AutoButtonColor = false
            v668.ClipsDescendants = true
            v668.LayoutOrder = v666
            v668.ZIndex = 3
            v668.Parent = v121
            Instance.new("UICorner", v668).CornerRadius = UDim.new(0, 6)
            local v669 = Instance.new("UIStroke", v668)
            Instance.new("UIStroke", v668).Color = v656.Stroke
            local v670 = Instance.new("Frame")
            Instance.new("Frame").AnchorPoint = Vector2.new(0, 1)
            v670.Position = UDim2.new(0, 0, 1, -24)
            v670.Size = UDim2.new(1, 0, 0, 3)
            local v671 = Instance.new("TextLabel")
            Instance.new("TextLabel").AnchorPoint = Vector2.new(0, 1)
            v671.Position = UDim2.new(0, 6, 1, -2)
            v671.Size = UDim2.new(1, -12, 0, 20)
            table.insert(v124, v668)
            v92(v668, v667.weapon, v667.skin)
            v668.MouseButton1Click:Connect(function()
                if (v667.kind == "KNIFE") then
                    local v672 = v58(v667.weapon, v667.skin)
                elseif (v667.kind == "GLOVE") then
                    v21.activeGloveWeapon = v667.weapon
                    v21.activeGloveSkin = v667.skin
                    v66()
                else
                    v21.selectedGunSkins[v667.weapon] = {skin = v667.skin, wear = v21.selectedGunWear}
                    v61(true)
                end
            end)
            if ((v666 % (3)) == (0)) then
                task.wait()
            end
        end
    end)
end
local function v127()
    local v673
    v673 = v20[v21.themeIdx]
    v98.BackgroundColor3 = v673.WinBg
    v104.BackgroundColor3 = v673.TopBg
    v95.BackgroundColor3 = v673.TopBg
    v107.BackgroundColor3 = v673.CardBg
    v107.TextColor3 = v673.Text
    v107.Text = "ТЕМА: " .. tostring(v21.themeIdx) .. "/" .. tostring(#v20)
    v120.BackgroundColor3 = v673.CardBg
    v120.TextColor3 = v673.Text
    v120.PlaceholderColor3 = v673.TextDim
    v761.Color = v673.Stroke
    v121.ScrollBarImageColor3 = v673.Accent
    for v674, v675 in pairs(v109) do
    end
    for v676, v677 in ipairs(v118:GetChildren()) do
        if (v677:IsA("TextButton") and v677:GetAttribute("CatKey")) then
            local v678
            local v679
            v678 = v677:GetAttribute("CatKey") == v21.activeCategory
            v677.BackgroundColor3 = (v678 and v673.Accent) or v673.CardBg
            v677.TextColor3 = (v678 and Color3.fromRGB(255, 255, 255)) or v673.Text
            v679 = v677:FindFirstChildOfClass("UIStroke")
            if v679 then
                v679.Color = v673.Stroke
            end
        end
    end
    for v680, v681 in ipairs(v125) do
        v681.BackgroundColor3 = v673.CardBg
        v681.TextColor3 = v673.Text
        local v682 = v681:FindFirstChildOfClass("UIStroke")
        if v682 then
            v682.Color = v673.Stroke
        end
    end
    for v683, v684 in ipairs(v124) do
        if (v684 and v684.Parent) then
            local v685
            v684.BackgroundColor3 = v673.CardBg
            v685 = v684:FindFirstChildOfClass("UIStroke")
            if v685 then
                v685.Color = v673.Stroke
            end
        end
    end
    v67()
end
local function v128()
    v21.themeIdx = (v21.themeIdx % #v20) + (1)
    v127()
end
v107.MouseButton1Click:Connect(v128)
local function v129(v686, v687, v688)
    local v689
    local v690
    v689 = v20[v21.themeIdx]
    v690 = Instance.new("TextButton")
    v690.Size = UDim2.fromOffset(v688 or (68), 28)
    v690.BackgroundColor3 = ((v21.activeCategory == v687) and v689.Accent) or v689.CardBg
    v690.BorderSizePixel = 0
    v690.Font = Enum.Font.GothamBold
    v690.TextSize = 11
    v690.TextColor3 = ((v21.activeCategory == v687) and Color3.fromRGB(255, 255, 255)) or v689.Text
    v690.Text = v686
    v690.ZIndex = 3
    v690.Parent = v118
    Instance.new("UICorner", v690).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", v690).Color = v689.Stroke
    v690:SetAttribute("CatKey", v687)
    v690.MouseButton1Click:Connect(function()
        v21.activeCategory = v687
        v127()
        v126()
    end)
end
v129("ВСЕ", "ALL", 56)
v129("НОЖИ", "KNIVES", 74)
v129("ПЕРЧАТКИ", "GLOVES", 92)
v129("ПУШКИ", "GUNS", 78)
local v130 = Instance.new("TextButton")
Instance.new("TextButton").Size = UDim2.fromOffset(82, 28)
v130.BackgroundColor3 = Color3.fromRGB(235, 165, 45)
v130.BorderSizePixel = 0
v130.Font = Enum.Font.GothamBold
v130.TextSize = 11
v130.TextColor3 = Color3.fromRGB(255, 255, 255)
v130.Text = "ТОП ВСЁ"
v130.ZIndex = 3
v130.Parent = v118
Instance.new("UICorner", v130).CornerRadius = UDim.new(0, 6)
v130.MouseButton1Click:Connect(function()
    for v691, v692 in ipairs(v24) do
        local v693
        v693 = v35(v692, v19)
        if (v35(v692, v19)) then
            v21.selectedGunSkins[v692] = {skin = v693, wear = v21.selectedGunWear}
        end
    end
    v58("Karambit", v35("Karambit", v19))
    v21.activeGloveWeapon = "Sports Gloves"
    v21.activeGloveSkin = v35("Sports Gloves", v19)
    v66()
    v61(true)
end)
local v131 = Instance.new("TextButton")
Instance.new("TextButton").Size = UDim2.fromOffset(82, 28)
v131.BackgroundColor3 = Color3.fromRGB(115, 95, 235)
v131.BorderSizePixel = 0
v131.Font = Enum.Font.GothamBold
v131.TextSize = 11
v131.TextColor3 = Color3.fromRGB(255, 255, 255)
v131.Text = "РАНДОМ"
v131.ZIndex = 3
v131.Parent = v118
Instance.new("UICorner", v131).CornerRadius = UDim.new(0, 6)
v131.MouseButton1Click:Connect(function()
    local v694
    local v695
    for v696, v697 in ipairs(v24) do
        if (v744 and v744:FindFirstChild(v697) and (v744 and v744:FindFirstChild(v697)):GetChildren() and (#(v744 and v744:FindFirstChild(v697) and (v744 and v744:FindFirstChild(v697)):GetChildren()) > (0))) then
            v21.selectedGunSkins[v697] = {skin = (v744 and v744:FindFirstChild(v697) and (v744 and v744:FindFirstChild(v697)):GetChildren())[math.random(1, #(v744 and v744:FindFirstChild(v697) and (v744 and v744:FindFirstChild(v697)):GetChildren()))].Name, wear = v21.selectedGunWear}
        end
    end
    v694 = v12[math.random(1, 7)]
    v58(v694, (v744 and v744:FindFirstChild(v694) and (v744 and v744:FindFirstChild(v694)):GetChildren() and (#(v744 and v744:FindFirstChild(v694) and (v744 and v744:FindFirstChild(v694)):GetChildren()) > (0)) and (v744 and v744:FindFirstChild(v694) and (v744 and v744:FindFirstChild(v694)):GetChildren())[math.random(1, #(v744 and v744:FindFirstChild(v694) and (v744 and v744:FindFirstChild(v694)):GetChildren()))].Name) or "Fade")
    v695 = v15[math.random(1, #v15)]
    if (v744 and v744:FindFirstChild(v695) and (v744 and v744:FindFirstChild(v695)):GetChildren() and (#(v744 and v744:FindFirstChild(v695) and (v744 and v744:FindFirstChild(v695)):GetChildren()) > (0))) then
        v21.activeGloveWeapon = v695
        v21.activeGloveSkin = (v744 and v744:FindFirstChild(v695) and (v744 and v744:FindFirstChild(v695)):GetChildren())[math.random(1, #(v744 and v744:FindFirstChild(v695) and (v744 and v744:FindFirstChild(v695)):GetChildren()))].Name
        v66()
    end
    v61(true)
end)
v120:GetPropertyChangedSignal("Text"):Connect(v126)
local function v132(v698, v699, v700, v701)
    local v702 = v20[v21.themeIdx]
    local v703 = Instance.new("TextButton")
    v703.Position = UDim2.fromOffset(20, v699)
    v703.Size = UDim2.new(1, -40, 0, 38)
    v703.BackgroundColor3 = v702.CardBg
    v703.BorderSizePixel = 0
    v703.Font = Enum.Font.GothamBold
    v703.TextSize = 13
    v703.TextColor3 = v702.Text
    v703.Text = v700
    v703.ZIndex = 3
    v703.Parent = v698
    Instance.new("UICorner", v703).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", v703).Color = v702.Stroke
    v703.MouseButton1Click:Connect(function()
        v701(v703)
    end)
    table.insert(v125, v703)
    return v703
end
v132(v112("ESP", 80, 56), 20, "ESP на Людей: ВКЛ", function(v704)
    v22.Enabled = not v22.Enabled
    v88()
end)
v132(v114, 66, "Контурные Чамсы (Т - Оранжевый / КТ - Голубой): ВКЛ", function(v705)
    v22.Chams = not v22.Chams
end)
v132(v114, 112, "Режим Чамсов: ТОЛЬКО КОНТУР (Без заливки)", function(v706)
    v22.ContourOnly = not v22.ContourOnly
end)
v132(v114, 158, "2D Рамки (Boxes): ВКЛ", function(v707)
    v22.Boxes = not v22.Boxes
end)
v132(v114, 204, "Полоска здоровья (Health Bar): ВКЛ", function(v708)
    v22.HealthBar = not v22.HealthBar
end)
v132(v114, 250, "Имена и дистанция: ВКЛ", function(v709)
    v22.Names = not v22.Names
end)
v132(v114, 296, "Скрывать своих тиммейтов (Team Check): ВЫКЛ", function(v710)
    v22.TeamCheck = not v22.TeamCheck
    v88()
end)
local v133 = Instance.new("TextLabel")
Instance.new("TextLabel").Position = UDim2.fromOffset(20, 14)
v133.Size = UDim2.new(1, -40, 0, 28)
v133.TextColor3 = Color3.fromRGB(255, 60, 200)
v133.Parent = (v112("EVENT", 138, 68))
v762 = v132(v115, 50, "[J] Zombie ESP (HordeShells): ВКЛ", function(v711)
    v23.enabled = not v23.enabled
end)
v763 = v132(v115, 96, "[H] Скелет R15 Зомби (Skeleton): ВКЛ", function(v712)
    v23.skeleton = not v23.skeleton
end)
v764 = v132(v115, 142, "[B] 2D Рамка Зомби (Box): ВКЛ", function(v713)
    v23.box = not v23.box
end)
v765 = v132(v115, 188, "[N] Имена Зомби (Zombie / Buried): ВКЛ", function(v714)
    v23.names = not v23.names
end)
v766 = v132(v115, 234, "[D] Дистанция до Зомби (Distance): ВКЛ", function(v715)
    v23.distance = not v23.distance
end)
v767 = v132(v115, 280, "[C] Чамсы Зомби (Chams Highlight): ВКЛ", function(v716)
    v23.chams = not v23.chams
end)
v132(v112("WORLD", 208, 72), 16, "Контурная подсветка рук и оружия (Viewmodel Chams): ВЫКЛ", function(v717)
    v21.vmChamsEnabled = not v21.vmChamsEnabled
    v67()
end)
v132(v116, 60, "Неоновые руки (ForceField Arms): ВЫКЛ", function(v718)
    v21.vmForceFieldArms = not v21.vmForceFieldArms
    v67()
end)
v132(v116, 104, "Анти-Флеш и Анти-Дым (No Flash / No Smoke): ВЫКЛ", function(v719)
    v21.noFlashSmoke = not v21.noFlashSmoke
    v68()
end)
v132(v116, 148, "Кастомный прицел по центру (Crosshair): ВЫКЛ", function(v720)
    v21.customCrosshair = not v21.customCrosshair
    v72.Visible = v21.customCrosshair
end)
v132(v116, 192, "Широкий угол обзора (FOV 105): ВЫКЛ", function(v721)
    v21.customFovEnabled = not v21.customFovEnabled
end)
v132(v116, 236, "Фиолетовое освещение (DeepHat Galaxy): ВЫКЛ", function(v722)
    v21.worldLighting = not v21.worldLighting
    if v21.worldLighting then
        v5.Ambient = Color3.fromRGB(145, 125, 195)
        v5.OutdoorAmbient = Color3.fromRGB(160, 140, 210)
        v5.Brightness = 2.6
        v5.ClockTime = 14
        v5.GlobalShadows = false
    else
        v5.Ambient = v9.Ambient
        v5.OutdoorAmbient = v9.OutdoorAmbient
        v5.Brightness = v9.Brightness
        v5.ClockTime = v9.ClockTime
        v5.GlobalShadows = v9.GlobalShadows
    end
end)
v132(v116, 280, "Ночной режим (Night Mode): ВЫКЛ", function(v723)
    v21.nightMode = not v21.nightMode
    v5.ClockTime = (v21.nightMode and 0) or v9.ClockTime
end)
v132(v116, 324, "Красивые облака: ВЫКЛ", function(v724)
    v21.cloudsEnabled = not v21.cloudsEnabled
    if v7 then
        (v7:FindFirstChildOfClass("Clouds") or Instance.new("Clouds", v7)).Enabled = v21.cloudsEnabled
        ;(v7:FindFirstChildOfClass("Clouds") or Instance.new("Clouds", v7)).Cover = 0.65
        ;(v7:FindFirstChildOfClass("Clouds") or Instance.new("Clouds", v7)).Density = 0.7
    end
end)
v132(v112("SETTING", 282, 82), 20, "Сменить тему меню (" .. v20[v21.themeIdx].Name .. ")", function(v725)
    v128()
end)
v132(v117, 68, "Падающие тыквы на фоне меню: ВКЛ", function(v726)
    v21.pumpkinsEnabled = not v21.pumpkinsEnabled
end)
v132(v117, 116, "Замена иконки ножа справа в HUD: ВКЛ", function(v727)
    v21.hudKnifeIconEnabled = not v21.hudKnifeIconEnabled
    if v21.hudKnifeIconEnabled then
        v51(true)
    else
        v52()
    end
end)
v132(v117, 164, "Окно спектаторов Win95 (Только смотрящие за мной): ВКЛ", function(v728)
    v21.spectatorListEnabled = not v21.spectatorListEnabled
    v43(v93)
end)
v132(v117, 212, "[X] Полностью выгрузить скрипт (Сбросить все скины, перчатки и ножи)", function()
    if v768.DeepHatSuiteUnload then
        v768.DeepHatSuiteUnload()
    end
end)
local v134 = {}
local function v135(v729)
    v21.menuVisible = v729
    v98.Visible = v729
    if v729 then
        v3.MouseBehavior = Enum.MouseBehavior.Default
        v3.MouseIconEnabled = true
    end
end
table.insert(v134, v3.InputBegan:Connect(function(v730, v731)
    local v732
    v732 = v730.KeyCode
    if ((v732 == Enum.KeyCode.RightShift) or (v732 == Enum.KeyCode.Insert)) then
        v135(not v21.menuVisible)
    end
    if (v732 == Enum.KeyCode.J) then
        v23.enabled = not v23.enabled
    elseif (v732 == Enum.KeyCode.H) then
        v23.skeleton = not v23.skeleton
    elseif (v732 == Enum.KeyCode.B) then
        v23.box = not v23.box
    elseif (v732 == Enum.KeyCode.N) then
        v23.names = not v23.names
    elseif (v732 == Enum.KeyCode.D) then
        v23.distance = not v23.distance
    elseif (v732 == Enum.KeyCode.C) then
        v23.chams = not v23.chams
    end
end))
game:GetService("RunService"):BindToRenderStep("TG_CursorAndFOV", Enum.RenderPriority.Last.Value + 50, function()
    if not v21.masterEnabled then
    end
    if v21.menuVisible then
        v3.MouseBehavior = Enum.MouseBehavior.Default
        v3.MouseIconEnabled = true
    end
    if (v21.customFovEnabled and v745 and (v742:GetAttribute("IsSniperScoped") ~= true)) then
        v745.FieldOfView = v21.fovValue
    end
end)
table.insert(v134, v2.RenderStepped:Connect(function(v733)
    if not v21.masterEnabled then
    end
    v745 = v1.CurrentCamera
    pcall(v103, v733)
    pcall(v89)
    pcall(v85)
    pcall(v43, v93)
end))
v56()
task.spawn(function()
    v55(true)
    if v21.lastAppliedKnife then
        pcall(v58, v21.lastAppliedKnife.weapon, v21.lastAppliedKnife.skin)
    end
    pcall(v61, true)
    pcall(v51, true)
    pcall(v88)
    pcall(v82)
    while v93.Parent and v21.masterEnabled do
        local v734
        if (v21.activeGloveWeapon and v21.activeGloveSkin) then
            pcall(v66)
        end
        pcall(v61, false)
        pcall(v67)
        pcall(v68)
        pcall(v51, false)
        pcall(v88)
        v734 = v82()
        v133.Text = string.format("Zombie ESP v4 (HordeShells) | Зомби: %d | Wave: %s | %s", #(v82()), tostring(v1:GetAttribute("SurvivalWave") or "?"), tostring(v1:GetAttribute("Gamemode") or "BloxStrike"))
        if (#v734 > (0)) then
            v97.Text = string.format("TG cheatorgame0 | Зомби: %d | Wave %s", #v734, tostring(v1:GetAttribute("SurvivalWave") or "?"))
        end
        task.wait(0.25)
    end
end)
;((getgenv and getgenv()) or _G).DeepHatSuiteUnload = function()
    v21.masterEnabled = false
    v22.Enabled = false
    v23.enabled = false
    pcall(function()
        v2:UnbindFromRenderStep("TG_CursorAndFOV")
    end)
    for v735, v736 in ipairs(v134) do
        pcall(function()
            v736:Disconnect()
        end)
    end
    table.clear(v134)
    pcall(v69)
    pcall(function()
        v5.Ambient = v9.Ambient
        v5.OutdoorAmbient = v9.OutdoorAmbient
        v5.Brightness = v9.Brightness
        v5.ClockTime = v9.ClockTime
        v5.FogEnd = v9.FogEnd
        v5.GlobalShadows = v9.GlobalShadows
        if v7 then
            v769 = v7:FindFirstChildOfClass("Clouds")
            if (v7:FindFirstChildOfClass("Clouds")) then
            end
        end
    end)
    for v737, v738 in pairs(v76) do
        v87(v738)
    end
    table.clear(v76)
    table.clear(v77)
    for v739, v740 in pairs(v78) do
        v84(v740)
    end
    table.clear(v78)
    table.clear(v79)
    if v38.Root then
        pcall(function()
            v38.Root:Destroy()
        end)
        v38.Root = nil
    end
    if (v71 and v71.Parent) then
        pcall(function()
            v71:Destroy()
        end)
    end
    if (v93 and v93.Parent) then
        pcall(function()
            v93:Destroy()
        end)
    end
end
v135(true)
v111("SKINS")
v127()
v126()
