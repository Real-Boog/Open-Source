-- Universal

local players = game:GetService("Players")
local coreGui = game:GetService("CoreGui")
local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local httpService = game:GetService("HttpService")
local statsService = game:GetService("Stats")
local teleportService = game:GetService("TeleportService")
local guiService = game:GetService("GuiService")

_G.Translations = {
  en = {
    TabUniversal = "Universal",
    TabGames = "Games",
    TabFavorites = "Favorites",
    TabServer = "Server",
    TabLanguage = "Language",
    SectionUniversal = "Universal Scripts",
    SectionGames = "Games",
    SectionServerMgmt = "Server Management",
    SectionJoinJob = "Join by JobId",
    BtnFly = "Fly, jump, noclip",
    BtnFling = "Fling",
    BtnRivals = "Rivals",
    BtnPhfr = "Phantom Forces",
    BtnApoc = "Apocalypse rising 2",
    BtnBloxstrike = "Bloxstrike",
    BtnJailbird = "Jailbird",
    BtnMM2 = "MM2",
    BtnMurder = "Murder VS Sheriff",
    BtnRejoin = "RE-JOIN SERVER",
    BtnCopyJob = "COPY SERVER JOBID",
    BtnAutoRejoin = "AUTO-REJOIN ON CRASH",
    BtnJoinJob = "TELEPORT TO JOBID",
    BtnMask = "MASK DATA",
    BtnUnmask = "UNMASK",
    PlaceholderJob = "PASTE JOBID HERE...",
    PlaceholderSearch = " SEARCH SCRIPTS...",
    KeyTitle = "KEY REQUIRED",
    KeySub = "Enter the key from our Discord server:",
    KeyPlaceholder = "Enter key here...",
    KeyCheck = "VERIFY KEY",
    KeyDiscord = "GET DISCORD",
    KeyStatusCorrect = "KEY CORRECT! LOADING...",
    KeyStatusInvalid = "INVALID KEY! TRY AGAIN.",
    KeyStatusCopied = "DISCORD LINK COPIED!",
    KeyStatusJoin = "JOIN: discord.gg/VrQtWF9tj",
    CopyJobSuccess = " COPIED JOBID!",
    CopyJobDefault = " COPY SERVER JOBID",
    AnonIdentity = "IDENTITY: HIDDEN",
    AnonSoftware = "SOFTWARE: HIDDEN",
    Identity = "IDENTITY: ",
    Software = "SOFTWARE: ",
    RejoinOn = " AUTO-REJOIN ON CRASH: [ ON ]",
    RejoinOff = " AUTO-REJOIN ON CRASH: [ OFF ]",
    ExecuteText = " EXECUTE: ",
    NameLabel = "ZHOAN HUB",
    FPSLabel = "FPS: 00 | MS: 00.0",
    DiscordLabel = " GET DISCORD",
    LanguageLabel = "Language",
    Lang_en = "English",
    Lang_fr = "Français",
    Lang_es = "Español",
    Lang_pt = "Português",
    Lang_it = "Italiano",
  },
  fr = {
    TabUniversal = "Universel",
    TabGames = "Jeux",
    TabFavorites = "Favoris",
    TabServer = "Serveur",
    TabLanguage = "Langue",
    SectionUniversal = "Scripts Universels",
    SectionGames = "Jeux",
    SectionServerMgmt = "Gestion du serveur",
    SectionJoinJob = "Rejoindre par JobId",
    BtnFly = "Voler, sauter, noclip",
    BtnFling = "Fling",
    BtnRivals = "Rivals",
    BtnPhfr = "Phantom Forces",
    BtnApoc = "Apocalypse rising 2",
    BtnBloxstrike = "Bloxstrike",
    BtnJailbird = "Jailbird",
    BtnMM2 = "MM2",
    BtnMurder = "Murder VS Sheriff",
    BtnRejoin = "REJOINDRE LE SERVEUR",
    BtnCopyJob = "COPIER LE JOBID",
    BtnAutoRejoin = "REJOINDRE AUTO EN CAS DE CRASH",
    BtnJoinJob = "TÉLÉPORTER VERS JOBID",
    BtnMask = "MASQUER LES DONNÉES",
    BtnUnmask = "DÉMASQUER",
    PlaceholderJob = "COLLEZ LE JOBID ICI...",
    PlaceholderSearch = " RECHERCHER DES SCRIPTS...",
    KeyTitle = "CLÉ REQUISE",
    KeySub = "Entrez la clé depuis notre serveur Discord :",
    KeyPlaceholder = "Entrez la clé ici...",
    KeyCheck = "VÉRIFIER LA CLÉ",
    KeyDiscord = "OBTENIR DISCORD",
    KeyStatusCorrect = "CLÉ CORRECTE ! CHARGEMENT...",
    KeyStatusInvalid = "CLÉ INVALIDE ! RÉESSAYEZ.",
    KeyStatusCopied = "LIEN DISCORD COPIÉ !",
    KeyStatusJoin = "REJOIGNEZ : discord.gg/VrQtWF9tj",
    CopyJobSuccess = " JOBID COPIÉ !",
    CopyJobDefault = " COPIER LE JOBID",
    AnonIdentity = "IDENTITÉ : CACHÉE",
    AnonSoftware = "LOGICIEL : CACHÉ",
    Identity = "IDENTITÉ : ",
    Software = "LOGICIEL : ",
    RejoinOn = " REJOINDRE AUTO EN CAS DE CRASH : [ ON ]",
    RejoinOff = " REJOINDRE AUTO EN CAS DE CRASH : [ OFF ]",
    ExecuteText = " EXÉCUTER : ",
    NameLabel = "ZHOAN HUB",
    FPSLabel = "FPS : 00 | MS : 00.0",
    DiscordLabel = " OBTENIR DISCORD",
    LanguageLabel = "Langue",
    Lang_en = "Anglais",
    Lang_fr = "Français",
    Lang_es = "Espagnol",
    Lang_pt = "Portugais",
    Lang_it = "Italien",
  },
  es = {
    TabUniversal = "Universal",
    TabGames = "Juegos",
    TabFavorites = "Favoritos",
    TabServer = "Servidor",
    TabLanguage = "Idioma",
    SectionUniversal = "Scripts Universales",
    SectionGames = "Juegos",
    SectionServerMgmt = "Gestión del servidor",
    SectionJoinJob = "Unirse por JobId",
    BtnFly = "Volar, saltar, noclip",
    BtnFling = "Fling",
    BtnRivals = "Rivals",
    BtnPhfr = "Phantom Forces",
    BtnApoc = "Apocalypse rising 2",
    BtnBloxstrike = "Bloxstrike",
    BtnJailbird = "Jailbird",
    BtnMM2 = "MM2",
    BtnMurder = "Murder VS Sheriff",
    BtnRejoin = "REUNIRSE AL SERVIDOR",
    BtnCopyJob = "COPIAR JOBID",
    BtnAutoRejoin = "REUNIRSE AUTO EN CRASH",
    BtnJoinJob = "TELEPORTAR A JOBID",
    BtnMask = "OCULTAR DATOS",
    BtnUnmask = "MOSTRAR",
    PlaceholderJob = "PEGUE EL JOBID AQUÍ...",
    PlaceholderSearch = " BUSCAR SCRIPTS...",
    KeyTitle = "CLAVE REQUERIDA",
    KeySub = "Ingrese la clave de nuestro servidor Discord:",
    KeyPlaceholder = "Ingrese la clave aquí...",
    KeyCheck = "VERIFICAR CLAVE",
    KeyDiscord = "OBTENER DISCORD",
    KeyStatusCorrect = "¡CLAVE CORRECTA! CARGANDO...",
    KeyStatusInvalid = "¡CLAVE INVÁLIDA! INTENTE DE NUEVO.",
    KeyStatusCopied = "¡ENLACE DE DISCORD COPIADO!",
    KeyStatusJoin = "ÚNASE: discord.gg/VrQtWF9tj",
    CopyJobSuccess = " ¡JOBID COPIADO!",
    CopyJobDefault = " COPIAR JOBID",
    AnonIdentity = "IDENTIDAD: OCULTA",
    AnonSoftware = "SOFTWARE: OCULTO",
    Identity = "IDENTIDAD: ",
    Software = "SOFTWARE: ",
    RejoinOn = " REUNIRSE AUTO EN CRASH: [ ON ]",
    RejoinOff = " REUNIRSE AUTO EN CRASH: [ OFF ]",
    ExecuteText = " EJECUTAR: ",
    NameLabel = "ZHOAN HUB",
    FPSLabel = "FPS: 00 | MS: 00.0",
    DiscordLabel = " OBTENER DISCORD",
    LanguageLabel = "Idioma",
    Lang_en = "Inglés",
    Lang_fr = "Francés",
    Lang_es = "Español",
    Lang_pt = "Portugués",
    Lang_it = "Italiano",
  },
  pt = {
    TabUniversal = "Universal",
    TabGames = "Jogos",
    TabFavorites = "Favoritos",
    TabServer = "Servidor",
    TabLanguage = "Idioma",
    SectionUniversal = "Scripts Universais",
    SectionGames = "Jogos",
    SectionServerMgmt = "Gestão do servidor",
    SectionJoinJob = "Entrar por JobId",
    BtnFly = "Voar, saltar, noclip",
    BtnFling = "Fling",
    BtnRivals = "Rivals",
    BtnApoc = "Apocalypse rising 2",
    BtnBloxstrike = "Bloxstrike",
    BtnJailbird = "Jailbird",
    BtnMM2 = "MM2",
    BtnMurder = "Murder VS Sheriff",
    BtnRejoin = "REENTRAR NO SERVIDOR",
    BtnCopyJob = "COPIAR JOBID",
    BtnAutoRejoin = "REENTRAR AUTO EM CRASH",
    BtnJoinJob = "TELEPORTAR PARA JOBID",
    BtnMask = "OCULTAR DADOS",
    BtnUnmask = "MOSTRAR",
    PlaceholderJob = "COLE O JOBID AQUI...",
    PlaceholderSearch = " PESQUISAR SCRIPTS...",
    KeyTitle = "CHAVE NECESSÁRIA",
    KeySub = "Digite a chave do nosso servidor Discord:",
    KeyPlaceholder = "Digite a chave aqui...",
    KeyCheck = "VERIFICAR CHAVE",
    KeyDiscord = "OBTER DISCORD",
    KeyStatusCorrect = "CHAVE CORRETA! CARREGANDO...",
    KeyStatusInvalid = "CHAVE INVÁLIDA! TENTE NOVAMENTE.",
    KeyStatusCopied = "LINK DO DISCORD COPIADO!",
    KeyStatusJoin = "ENTRE: discord.gg/VrQtWF9tj",
    CopyJobSuccess = " JOBID COPIADO!",
    CopyJobDefault = " COPIAR JOBID",
    AnonIdentity = "IDENTIDADE: OCULTA",
    AnonSoftware = "SOFTWARE: OCULTO",
    Identity = "IDENTIDADE: ",
    Software = "SOFTWARE: ",
    RejoinOn = " REENTRAR AUTO EM CRASH: [ ON ]",
    RejoinOff = " REENTRAR AUTO EM CRASH: [ OFF ]",
    ExecuteText = " EXECUTAR: ",
    NameLabel = "ZHOAN HUB",
    FPSLabel = "FPS: 00 | MS: 00.0",
    DiscordLabel = " OBTER DISCORD",
    LanguageLabel = "Idioma",
    Lang_en = "Inglês",
    Lang_fr = "Francês",
    Lang_es = "Espanhol",
    Lang_pt = "Português",
    Lang_it = "Italiano",
  },
  it = {
    TabUniversal = "Universale",
    TabGames = "Giochi",
    TabFavorites = "Preferiti",
    TabServer = "Server",
    TabLanguage = "Lingua",
    SectionUniversal = "Script Universali",
    SectionGames = "Giochi",
    SectionServerMgmt = "Gestione Server",
    SectionJoinJob = "Unisciti tramite JobId",
    BtnFly = "Volare, saltare, noclip",
    BtnFling = "Fling",
    BtnRivals = "Rivals",
    BtnApoc = "Apocalypse rising 2",
    BtnBloxstrike = "Bloxstrike",
    BtnJailbird = "Jailbird",
    BtnMM2 = "MM2",
    BtnMurder = "Murder VS Sheriff",
    BtnRejoin = "RIENTRA NEL SERVER",
    BtnCopyJob = "COPIA JOBID",
    BtnAutoRejoin = "RIENTRA AUTO IN CASO DI CRASH",
    BtnJoinJob = "TELEPORTA A JOBID",
    BtnMask = "NASCONDI DATI",
    BtnUnmask = "MOSTRA",
    PlaceholderJob = "INCOLLA JOBID QUI...",
    PlaceholderSearch = " CERCA SCRIPT...",
    KeyTitle = "CHIAVE RICHIESTA",
    KeySub = "Inserisci la chiave dal nostro server Discord:",
    KeyPlaceholder = "Inserisci la chiave qui...",
    KeyCheck = "VERIFICA CHIAVE",
    KeyDiscord = "OTTIENI DISCORD",
    KeyStatusCorrect = "CHIAVE CORRETTA! CARICAMENTO...",
    KeyStatusInvalid = "CHIAVE NON VALIDA! RIPROVA.",
    KeyStatusCopied = "LINK DISCORD COPIATO!",
    KeyStatusJoin = "UNISCITI: discord.gg/VrQtWF9tj",
    CopyJobSuccess = " JOBID COPIATO!",
    CopyJobDefault = " COPIA JOBID",
    AnonIdentity = "IDENTITÀ: NASCOSTA",
    AnonSoftware = "SOFTWARE: NASCOSTO",
    Identity = "IDENTITÀ: ",
    Software = "SOFTWARE: ",
    RejoinOn = " RIENTRA AUTO IN CASO DI CRASH: [ ON ]",
    RejoinOff = " RIENTRA AUTO IN CASO DI CRASH: [ OFF ]",
    ExecuteText = " ESEGUI: ",
    NameLabel = "ZHOAN HUB",
    FPSLabel = "FPS: 00 | MS: 00.0",
    DiscordLabel = " OTTIENI DISCORD",
    LanguageLabel = "Lingua",
    Lang_en = "Inglese",
    Lang_fr = "Francese",
    Lang_es = "Spagnolo",
    Lang_pt = "Portoghese",
    Lang_it = "Italiano",
  },
}

local function f1(p1)
  return (_G.Translations[_G.CurrentLanguage] or _G.Translations.en)[p1]
    or _G.Translations.en[p1] or p1
end

local zhoanVANTA = Instance.new("ScreenGui")
zhoanVANTA.Name = "ZHOAN_VANTA"
zhoanVANTA.ResetOnSpawn = false
zhoanVANTA.ZIndexBehavior = Enum.ZIndexBehavior.Global

pcall(function() zhoanVANTA.Parent = coreGui end)

if not zhoanVANTA.Parent then
  zhoanVANTA.Parent = players.LocalPlayer:WaitForChild("PlayerGui")
end

local v1 = false
local v2 = "ZhoanHub_Config_" .. players.LocalPlayer.Name .. ".json"
_G.CurrentLanguage = "en"
local savedKey

local function f2()
  if readfile and isfile and isfile(v2) then
    pcall(function()
      local jsonDecode = httpService:JSONDecode((readfile(v2)))

      if type(jsonDecode) == "table" then
        if jsonDecode.SavedKey then
          savedKey = jsonDecode.SavedKey
        end

        if jsonDecode.Language then
          _G.CurrentLanguage = jsonDecode.Language
        end
      end
    end)
  end
end

f2()

if savedKey and savedKey == "RONALDO" then
  v1 = true
end

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 560, 0, 380)
mainFrame.Position = UDim2.new(0.5, -280, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
mainFrame.BorderColor3 = Color3.fromRGB(255, 100, 0)
mainFrame.BorderSizePixel = 1
mainFrame.Active = true
mainFrame.ZIndex = 1
mainFrame.Visible = v1
mainFrame.Parent = zhoanVANTA

local lockFrame = Instance.new("Frame")
lockFrame.Name = "LockFrame"
lockFrame.Size = UDim2.new(0, 350, 0, 250)
lockFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
lockFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
lockFrame.BorderColor3 = Color3.fromRGB(255, 100, 0)
lockFrame.BorderSizePixel = 1
lockFrame.Active = true
lockFrame.ZIndex = 10
lockFrame.Visible = not v1
lockFrame.Parent = zhoanVANTA

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 0, 50)
textLabel.Position = UDim2.new(0, 0, 0, 10)
textLabel.BackgroundTransparency = 1
textLabel.Text = f1("KeyTitle")
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextSize = 16
textLabel.Font = Enum.Font.Code
textLabel.TextXAlignment = Enum.TextXAlignment.Center
textLabel.ZIndex = 11
textLabel.Parent = lockFrame

local textLabel2 = Instance.new("TextLabel")
textLabel2.Size = UDim2.new(1, -40, 0, 40)
textLabel2.Position = UDim2.new(0, 20, 0, 45)
textLabel2.BackgroundTransparency = 1
textLabel2.Text = f1("KeySub")
textLabel2.TextColor3 = Color3.fromRGB(120, 125, 140)
textLabel2.TextSize = 12
textLabel2.Font = Enum.Font.Code
textLabel2.TextWrapped = true
textLabel2.TextXAlignment = Enum.TextXAlignment.Center
textLabel2.ZIndex = 11
textLabel2.Parent = lockFrame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -40, 0, 35)
textBox.Position = UDim2.new(0, 20, 0, 95)
textBox.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
textBox.BorderColor3 = Color3.fromRGB(255, 100, 0)
textBox.BorderSizePixel = 1
textBox.Text = ""
textBox.PlaceholderText = f1("KeyPlaceholder")
textBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 110)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.TextSize = 13
textBox.Font = Enum.Font.Code
textBox.TextXAlignment = Enum.TextXAlignment.Center
textBox.ZIndex = 11
textBox.Parent = lockFrame

local textButton = Instance.new("TextButton")
textButton.Size = UDim2.new(0, 145, 0, 35)
textButton.Position = UDim2.new(0, 20, 0, 145)
textButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
textButton.BorderSizePixel = 0
textButton.Text = f1("KeyCheck")
textButton.TextColor3 = Color3.fromRGB(10, 10, 12)
textButton.TextSize = 13
textButton.Font = Enum.Font.Code
textButton.ZIndex = 11
textButton.Parent = lockFrame

local textButton2 = Instance.new("TextButton")
textButton2.Size = UDim2.new(0, 145, 0, 35)
textButton2.Position = UDim2.new(1, -165, 0, 145)
textButton2.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
textButton2.BorderColor3 = Color3.fromRGB(255, 100, 0)
textButton2.BorderSizePixel = 1
textButton2.Text = f1("KeyDiscord")
textButton2.TextColor3 = Color3.fromRGB(255, 100, 0)
textButton2.TextSize = 13
textButton2.Font = Enum.Font.Code
textButton2.ZIndex = 11
textButton2.Parent = lockFrame

local textLabel3 = Instance.new("TextLabel")
textLabel3.Size = UDim2.new(1, 0, 0, 30)
textLabel3.Position = UDim2.new(0, 0, 0, 195)
textLabel3.BackgroundTransparency = 1
textLabel3.Text = ""
textLabel3.TextColor3 = Color3.fromRGB(255, 100, 0)
textLabel3.TextSize = 12
textLabel3.Font = Enum.Font.Code
textLabel3.TextXAlignment = Enum.TextXAlignment.Center
textLabel3.ZIndex = 11
textLabel3.Parent = lockFrame

local v3, position, position2

lockFrame.InputBegan:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
    v3 = true
    position = input.Position
    position2 = lockFrame.Position

    input.Changed:Connect(function()
      if input.UserInputState == Enum.UserInputState.End then
        v3 = false
      end
    end)
  end
end)

local v4

lockFrame.InputChanged:Connect(function(input2)
  if input2.UserInputType == Enum.UserInputType.MouseMovement
    or input2.UserInputType == Enum.UserInputType.Touch then
    v4 = input2
  end
end)

userInputService.InputChanged:Connect(function(input3)
  if input3 == v4 and v3 then
    local v5 = input3.Position - position

    lockFrame.Position = UDim2.new(
      position2.X.Scale, position2.X.Offset + v5.X, position2.Y.Scale, position2.Y.Offset + v5.Y
    )
  end
end)

textButton.MouseButton1Click:Connect(function()
  if textBox.Text:upper():gsub("%s+", "") == "RONALDO" then
    textLabel3.Text = f1("KeyStatusCorrect")
    textLabel3.TextColor3 = Color3.fromRGB(0, 255, 120)

    v1 = true
    lockFrame.Visible = false
    mainFrame.Visible = true
    task.delay(1, function() textLabel3.Text = "" end)
  else
    textLabel3.Text = f1("KeyStatusInvalid")
    textLabel3.TextColor3 = Color3.fromRGB(255, 53, 53)

    textBox.Text = ""
    task.delay(3, function() textLabel3.Text = "" end)
  end
end)

textButton2.MouseButton1Click:Connect(function()
  local v6 = setclipboard or toclipboard or Clipboard and Clipboard.set
    or syn and syn.write_to_clipboard

  if v6 then
    v6("https://discord.gg/VrQtWF9tj")

    textLabel3.Text = f1("KeyStatusCopied")
    textLabel3.TextColor3 = Color3.fromRGB(0, 220, 255)

    task.delay(2, function() textLabel3.Text = "" end)
  else
    textLabel3.Text = f1("KeyStatusJoin")
    textLabel3.TextColor3 = Color3.fromRGB(255, 165, 0)
    task.delay(3, function() textLabel3.Text = "" end)
  end
end)

local position3, position4

local function f3(p2)
  local v7 = p2.Position - position3

  local udim = UDim2.new(
    position4.X.Scale, position4.X.Offset + v7.X, position4.Y.Scale, position4.Y.Offset + v7.Y
  )

  tweenService:Create(mainFrame, TweenInfo.new(0.08, Enum.EasingStyle.Linear), {
    Position = udim,
  }):Play()
end

local v8

mainFrame.InputBegan:Connect(function(input4)
  if input4.UserInputType == Enum.UserInputType.MouseButton1
    or input4.UserInputType == Enum.UserInputType.Touch then
    v8 = true
    position3 = input4.Position
    position4 = mainFrame.Position

    input4.Changed:Connect(function()
      if input4.UserInputState == Enum.UserInputState.End then
        v8 = false
      end
    end)
  end
end)

local v9

mainFrame.InputChanged:Connect(function(input5)
  if input5.UserInputType == Enum.UserInputType.MouseMovement
    or input5.UserInputType == Enum.UserInputType.Touch then
    v9 = input5
  end
end)

userInputService.InputChanged:Connect(function(input6)
  if input6 == v9 and v8 then
    f3(input6)
  end
end)

local topLine = Instance.new("Frame")
topLine.Name = "TopLine"
topLine.Size = UDim2.new(1, 0, 0, 2)
topLine.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
topLine.BorderSizePixel = 0
topLine.ZIndex = 2
topLine.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(0, 120, 0, 40)
title.Position = UDim2.new(0, 15, 0, 2)
title.BackgroundTransparency = 1
title.Text = f1("NameLabel")
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.Code
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 2
title.Parent = mainFrame

local performanceLabel = Instance.new("TextLabel")
performanceLabel.Name = "PerformanceLabel"
performanceLabel.Size = UDim2.new(0, 180, 0, 40)
performanceLabel.Position = UDim2.new(0.5, -90, 0, 2)
performanceLabel.BackgroundTransparency = 1
performanceLabel.Text = f1("FPSLabel")
performanceLabel.TextColor3 = Color3.fromRGB(0, 220, 255)
performanceLabel.TextSize = 12
performanceLabel.Font = Enum.Font.Code
performanceLabel.TextXAlignment = Enum.TextXAlignment.Center
performanceLabel.ZIndex = 2
performanceLabel.Parent = mainFrame

local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 130, 1, -150)
sidebar.Position = UDim2.new(0, 15, 0, 50)
sidebar.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
sidebar.BorderColor3 = Color3.fromRGB(30, 30, 35)
sidebar.BorderSizePixel = 1
sidebar.ZIndex = 2
sidebar.Parent = mainFrame

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0, 4)
uiListLayout.Parent = sidebar

local contentContainer = Instance.new("Frame")
contentContainer.Name = "ContentContainer"
contentContainer.Size = UDim2.new(1, -180, 1, -150)
contentContainer.Position = UDim2.new(0, 160, 0, 50)
contentContainer.BackgroundTransparency = 1
contentContainer.ZIndex = 2
contentContainer.Parent = mainFrame

local universalPage = Instance.new("ScrollingFrame")
universalPage.Name = "UniversalPage"
universalPage.Size = UDim2.new(1, 0, 1, 0)
universalPage.BackgroundTransparency = 1
universalPage.ScrollBarThickness = 2
universalPage.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 0)
universalPage.Visible = true
universalPage.ZIndex = 3
universalPage.Parent = contentContainer

local gamesPage = Instance.new("ScrollingFrame")
gamesPage.Name = "GamesPage"
gamesPage.Size = UDim2.new(1, 0, 1, 0)
gamesPage.BackgroundTransparency = 1
gamesPage.ScrollBarThickness = 2
gamesPage.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 0)
gamesPage.Visible = false
gamesPage.ZIndex = 3
gamesPage.Parent = contentContainer

local favoritesPage = Instance.new("ScrollingFrame")
favoritesPage.Name = "FavoritesPage"
favoritesPage.Size = UDim2.new(1, 0, 1, 0)
favoritesPage.BackgroundTransparency = 1
favoritesPage.ScrollBarThickness = 2
favoritesPage.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 0)
favoritesPage.Visible = false
favoritesPage.ZIndex = 3
favoritesPage.Parent = contentContainer

local serverPage = Instance.new("ScrollingFrame")
serverPage.Name = "ServerPage"
serverPage.Size = UDim2.new(1, 0, 1, 0)
serverPage.BackgroundTransparency = 1
serverPage.ScrollBarThickness = 2
serverPage.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 0)
serverPage.Visible = false
serverPage.ZIndex = 3
serverPage.Parent = contentContainer

local languagePage = Instance.new("ScrollingFrame")
languagePage.Name = "LanguagePage"
languagePage.Size = UDim2.new(1, 0, 1, 0)
languagePage.BackgroundTransparency = 1
languagePage.ScrollBarThickness = 2
languagePage.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 0)
languagePage.Visible = false
languagePage.ZIndex = 3
languagePage.Parent = contentContainer

local uiListLayout2 = Instance.new("UIListLayout")
uiListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout2.Padding = UDim.new(0, 10)
uiListLayout2.Parent = universalPage

local uiListLayout3 = Instance.new("UIListLayout")
uiListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout3.Padding = UDim.new(0, 10)
uiListLayout3.Parent = gamesPage

local uiListLayout4 = Instance.new("UIListLayout")
uiListLayout4.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout4.Padding = UDim.new(0, 10)
uiListLayout4.Parent = favoritesPage

local uiListLayout5 = Instance.new("UIListLayout")
uiListLayout5.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout5.Padding = UDim.new(0, 10)
uiListLayout5.Parent = serverPage

local uiListLayout6 = Instance.new("UIListLayout")
uiListLayout6.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout6.Padding = UDim.new(0, 10)
uiListLayout6.Parent = languagePage

local v10 = {}
local v11 = { Favorites = {}, AutoRejoin = false }

local function f4()
  if readfile and isfile and isfile(v2) then
    pcall(function()
      local jsonDecode2 = httpService:JSONDecode((readfile(v2)))

      if type(jsonDecode2) == "table" then
        if jsonDecode2.Favorites then
          v11.Favorites = jsonDecode2.Favorites
        end

        if jsonDecode2.AutoRejoin ~= nil then
          v11.AutoRejoin = jsonDecode2.AutoRejoin
        end

        if jsonDecode2.Language then
          _G.CurrentLanguage = jsonDecode2.Language
        end
      end
    end)
  end
end

f4()

local function f5(p3)
  local searchBar = Instance.new("TextBox")
  searchBar.Name = "SearchBar"
  searchBar.Size = UDim2.new(1, -5, 0, 28)
  searchBar.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
  searchBar.BorderColor3 = Color3.fromRGB(255, 100, 0)
  searchBar.BorderSizePixel = 1
  searchBar.Text = ""
  searchBar.PlaceholderText = f1("PlaceholderSearch")
  searchBar.PlaceholderColor3 = Color3.fromRGB(100, 100, 110)
  searchBar.TextColor3 = Color3.fromRGB(255, 255, 255)
  searchBar.TextSize = 11
  searchBar.Font = Enum.Font.Code
  searchBar.TextXAlignment = Enum.TextXAlignment.Left
  searchBar.LayoutOrder = -1
  searchBar.ZIndex = 4
  searchBar.Parent = p3

  searchBar:GetPropertyChangedSignal("Text"):Connect(function()
    local lower = searchBar.Text:lower()

    for key, value in pairs(p3:GetChildren()) do
      if value:IsA("Frame") and value.Name:find("Section") then
        local content = value:FindFirstChild("Content")

        if content then
          for key2, value2 in pairs(content:GetChildren()) do
            if value2:IsA("Frame") and value2.Name == "ButtonRow" then
              local textButton3 = value2:FindFirstChildOfClass("TextButton")

              if textButton3 then
                local lower2 = textButton3.Text:lower()

                if lower == "" or lower2:find(lower) then
                  value2.Visible = true
                else
                  value2.Visible = false
                end
              end
            end
          end
        end
      end
    end
  end)
end

f5(universalPage)
f5(gamesPage)

local function f6(p4, p5)
  local frame = Instance.new("Frame")
  frame.Name = p5:upper():gsub(" ", "") .. "Section"
  frame.Size = UDim2.new(1, -5, 0, 0)
  frame.AutomaticSize = Enum.AutomaticSize.Y
  frame.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
  frame.BorderColor3 = Color3.fromRGB(30, 30, 35)
  frame.BorderSizePixel = 1
  frame.ZIndex = 4
  frame.Parent = p4

  local textLabel4 = Instance.new("TextLabel")
  textLabel4.Size = UDim2.new(1, -10, 0, 24)
  textLabel4.Position = UDim2.new(0, 10, 0, 2)
  textLabel4.BackgroundTransparency = 1
  textLabel4.Text = string.upper(f1(p5))
  textLabel4.TextColor3 = Color3.fromRGB(0, 220, 255)
  textLabel4.TextSize = 11
  textLabel4.Font = Enum.Font.Code
  textLabel4.TextXAlignment = Enum.TextXAlignment.Left
  textLabel4.ZIndex = 5
  textLabel4.Parent = frame

  local content2 = Instance.new("Frame")
  content2.Name = "Content"
  content2.Size = UDim2.new(1, -20, 0, 0)
  content2.Position = UDim2.new(0, 10, 0, 30)
  content2.AutomaticSize = Enum.AutomaticSize.Y
  content2.BackgroundTransparency = 1
  content2.ZIndex = 5
  content2.Parent = frame

  local uiListLayout7 = Instance.new("UIListLayout")
  uiListLayout7.SortOrder = Enum.SortOrder.LayoutOrder
  uiListLayout7.Padding = UDim.new(0, 6)
  uiListLayout7.Parent = content2

  local function f7()
    local v12 = 0
    local count = 0

    for key3, value3 in pairs(content2:GetChildren()) do
      if (value3:IsA("Frame") or value3:IsA("TextBox") or value3:IsA("TextButton"))
        and value3.Visible then
        v12 = v12 + value3.AbsoluteSize.Y + uiListLayout7.Padding.Offset
        count = count + 1
      end
    end

    if count == 0 and (p4 == favoritesPage or p4 == languagePage) then
      frame.Visible = false
    else
      frame.Visible = true
      frame.Size = UDim2.new(1, -5, 0, v12 + 40)
    end
  end

  uiListLayout7:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(f7)
  content2.ChildRemoved:Connect(f7)
  return content2
end

local function f8(p6, p7, p8)
  local textButton4 = Instance.new("TextButton")
  textButton4.Name = p6 .. "Tab"
  textButton4.Size = UDim2.new(1, 0, 0, 34)

  textButton4.BackgroundColor3 = p8 == 1 and Color3.fromRGB(20, 20, 25)
    or Color3.fromRGB(14, 14, 16)

  textButton4.BorderSizePixel = 0
  textButton4.Text = " " .. f1(p6):upper()

  textButton4.TextColor3 = p8 == 1 and Color3.fromRGB(255, 100, 0)
    or Color3.fromRGB(140, 140, 150)

  textButton4.TextSize = 12
  textButton4.Font = Enum.Font.Code
  textButton4.TextXAlignment = Enum.TextXAlignment.Left
  textButton4.LayoutOrder = p8
  textButton4.ZIndex = 4
  textButton4.Parent = sidebar

  local frame2 = Instance.new("Frame")
  frame2.Size = UDim2.new(0, 2, 1, 0)
  frame2.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
  frame2.BorderSizePixel = 0
  frame2.Visible = p8 == 1
  frame2.ZIndex = 5
  frame2.Parent = textButton4

  table.insert(v10, {
    Btn = textButton4,
    Indicator = frame2,
    Page = p7,
    NameKey = p6,
  })

  textButton4.MouseEnter:Connect(function()
    if p7.Visible == false then
      tweenService:Create(textButton4, TweenInfo.new(0.1), {
        TextColor3 = Color3.fromRGB(255, 255, 255),
      }):Play()
    end
  end)

  textButton4.MouseLeave:Connect(function()
    if p7.Visible == false then
      tweenService:Create(textButton4, TweenInfo.new(0.1), {
        TextColor3 = Color3.fromRGB(140, 140, 150),
      }):Play()
    end
  end)

  textButton4.MouseButton1Click:Connect(function()
    for key4, value4 in pairs(v10) do
      value4.Btn.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
      value4.Btn.TextColor3 = Color3.fromRGB(140, 140, 150)
      value4.Indicator.Visible = false
      value4.Page.Visible = false
    end

    textButton4.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    textButton4.TextColor3 = Color3.fromRGB(255, 100, 0)

    frame2.Visible = true
    p7.Visible = true
  end)

  return textButton4
end

local v13 = f6(favoritesPage, "SectionUniversal")
local v14 = f6(favoritesPage, "SectionGames")
local v15 = f6(languagePage, "LanguageLabel")

local function f9(parent, p9)
  local frame3 = Instance.new("Frame")
  frame3.Name = "LangRow_" .. p9
  frame3.Size = UDim2.new(1, 0, 0, 26)
  frame3.BackgroundTransparency = 1
  frame3.ZIndex = 5
  frame3.Parent = parent

  local textButton5 = Instance.new("TextButton")
  textButton5.Size = UDim2.new(1, 0, 1, 0)
  textButton5.BackgroundTransparency = 1
  textButton5.BorderColor3 = Color3.fromRGB(35, 35, 40)
  textButton5.BorderSizePixel = 1
  textButton5.Text = " " .. f1("Lang_" .. p9)

  textButton5.TextColor3 = _G.CurrentLanguage == p9 and Color3.fromRGB(255, 100, 0)
    or Color3.fromRGB(200, 200, 200)

  textButton5.TextSize = 11
  textButton5.Font = Enum.Font.Code
  textButton5.TextXAlignment = Enum.TextXAlignment.Left
  textButton5.ZIndex = 6
  textButton5.Parent = frame3

  local textLabel5 = Instance.new("TextLabel")
  textLabel5.Size = UDim2.new(0, 30, 1, 0)
  textLabel5.Position = UDim2.new(1, -30, 0, 0)
  textLabel5.BackgroundTransparency = 1
  textLabel5.Text = _G.CurrentLanguage == p9 and "✓" or ""
  textLabel5.TextColor3 = Color3.fromRGB(255, 100, 0)
  textLabel5.TextSize = 13
  textLabel5.Font = Enum.Font.Code
  textLabel5.TextXAlignment = Enum.TextXAlignment.Center
  textLabel5.ZIndex = 6
  textLabel5.Parent = frame3

  textButton5.MouseEnter:Connect(function()
    textButton5.BackgroundTransparency = 0

    tweenService:Create(textButton5, TweenInfo.new(0.08), {
      BackgroundColor3 = Color3.fromRGB(255, 100, 0),
      BorderColor3 = Color3.fromRGB(255, 255, 255),
      TextColor3 = Color3.fromRGB(10, 10, 12),
    }):Play()
  end)

  textButton5.MouseLeave:Connect(function()
    if _G.CurrentLanguage ~= p9 then
      tweenService:Create(textButton5, TweenInfo.new(0.08), {
        BorderColor3 = Color3.fromRGB(35, 35, 40),
        TextColor3 = Color3.fromRGB(200, 200, 200),
      }):Play()

      task.wait(0.08)

      if textButton5.Parent then
        textButton5.BackgroundTransparency = 1
      end
    else
      tweenService:Create(textButton5, TweenInfo.new(0.08), {
        BorderColor3 = Color3.fromRGB(35, 35, 40),
        TextColor3 = Color3.fromRGB(255, 100, 0),
      }):Play()

      task.wait(0.08)

      if textButton5.Parent then
        textButton5.BackgroundTransparency = 1
      end
    end
  end)

  textButton5.MouseButton1Click:Connect(function()
    _G.CurrentLanguage = p9

    for key5, value5 in pairs(v15:GetChildren()) do
      if value5:IsA("Frame") then
        local textButton6 = value5:FindFirstChildOfClass("TextButton")
        local textLabel6 = value5:FindFirstChildOfClass("TextLabel")

        if textButton6 and textLabel6 then
          local gsub = value5.Name:gsub("LangRow_", "")
          textButton6.Text = " " .. f1("Lang_" .. gsub)

          if gsub == p9 then
            textButton6.TextColor3 = Color3.fromRGB(255, 100, 0)
            textLabel6.Text = "✓"
          else
            textButton6.TextColor3 = Color3.fromRGB(200, 200, 200)
            textLabel6.Text = ""
          end
        end
      end
    end

    for key6, value6 in pairs(v10) do
      local v16 = f1(value6.NameKey)
      value6.Btn.Text = " " .. v16:upper()
    end

    for key7, value7 in pairs({
      universalPage, gamesPage, favoritesPage, serverPage, languagePage,
    }) do
      for key8, value8 in pairs(value7:GetChildren()) do
        if value8:IsA("Frame") and value8.Name:find("Section") then
          local textLabel7 = value8:FindFirstChildOfClass("TextLabel")

          if textLabel7 then
            local gsub2 = value8.Name:gsub("Section", "")

            for key9, value9 in pairs(_G.Translations.en) do
              if key9:upper():gsub(" ", "") == gsub2 then
                textLabel7.Text = string.upper(f1(key9))
                break
              end
            end
          end

          local content3 = value8:FindFirstChild("Content")

          if content3 then
            for key10, value10 in pairs(content3:GetChildren()) do
              if value10:IsA("Frame") and value10.Name == "ButtonRow" then
                local textButton7 = value10:FindFirstChildOfClass("TextButton")

                if textButton7 then
                  local v17 = nil

                  for key11, value11 in pairs(_G.Translations.en) do
                    if key11:find("Btn") and _G.Translations.en[key11]
                      and textButton7.Text:find(_G.Translations.en[key11]) then
                      v17 = key11
                      break
                    end
                  end

                  if v17 then
                    textButton7.Text = f1("ExecuteText") .. string.upper(f1(v17))
                  end
                end
              end
            end
          end
        end
      end
    end

    title.Text = f1("NameLabel")
    performanceLabel.Text = f1("FPSLabel")
    SearchBox = universalPage:FindFirstChild("SearchBar")

    if SearchBox then
      SearchBox.PlaceholderText = f1("PlaceholderSearch")
    end

    SearchBox = gamesPage:FindFirstChild("SearchBar")

    if SearchBox then
      SearchBox.PlaceholderText = f1("PlaceholderSearch")
    end

    local rejoinBtn = serverPage:FindFirstChild("RejoinBtn")

    if rejoinBtn then
      rejoinBtn.Text = f1("BtnRejoin")
    end

    local copyBtn = serverPage:FindFirstChild("CopyBtn")

    if copyBtn then
      copyBtn.Text = f1("BtnCopyJob")
    end

    local autoBtn = serverPage:FindFirstChild("AutoBtn")

    if autoBtn then
      if v11.AutoRejoin then
        autoBtn.Text = f1("RejoinOn")
        autoBtn.TextColor3 = Color3.fromRGB(0, 220, 255)
      else
        autoBtn.Text = f1("RejoinOff")
        autoBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
      end
    end

    local jobInput = serverPage:FindFirstChild("JobInput")

    if jobInput then
      jobInput.PlaceholderText = f1("PlaceholderJob")
    end

    local joinBtn = serverPage:FindFirstChild("JoinBtn")

    if joinBtn then
      joinBtn.Text = f1("BtnJoinJob")
    end

    local anonBtn = mainFrame:FindFirstChild("AnonBtn")

    if anonBtn then
      if isAnon then
        anonBtn.Text = "[ " .. f1("BtnUnmask") .. " ]"
      else
        anonBtn.Text = "[ " .. f1("BtnMask") .. " ]"
      end
    end
  end)
end

local function f10(p10, p11, p12)
  local buttonRow = Instance.new("Frame")
  buttonRow.Name = "ButtonRow"
  buttonRow.Size = UDim2.new(1, 0, 0, 26)
  buttonRow.BackgroundTransparency = 1
  buttonRow.ZIndex = 5
  buttonRow.Parent = p10

  local textButton8 = Instance.new("TextButton")
  textButton8.Size = UDim2.new(1, -30, 1, 0)
  textButton8.BackgroundTransparency = 1
  textButton8.BorderColor3 = Color3.fromRGB(35, 35, 40)
  textButton8.BorderSizePixel = 1
  textButton8.Text = f1("ExecuteText") .. string.upper(f1(p11))
  textButton8.TextColor3 = Color3.fromRGB(200, 200, 200)
  textButton8.TextSize = 11
  textButton8.Font = Enum.Font.Code
  textButton8.TextXAlignment = Enum.TextXAlignment.Left
  textButton8.ZIndex = 6
  textButton8.Parent = buttonRow

  local textButton9 = Instance.new("TextButton")
  textButton9.Size = UDim2.new(0, 26, 1, 0)
  textButton9.Position = UDim2.new(1, -26, 0, 0)
  textButton9.BackgroundTransparency = 1
  textButton9.BorderColor3 = Color3.fromRGB(35, 35, 40)
  textButton9.BorderSizePixel = 1
  textButton9.Text = "☆"
  textButton9.TextColor3 = Color3.fromRGB(150, 150, 150)
  textButton9.TextSize = 13
  textButton9.Font = Enum.Font.Code
  textButton9.ZIndex = 6
  textButton9.Parent = buttonRow

  local v18 = false

  local function f11(p13)
    local uiListLayout8 = p13:FindFirstChildOfClass("UIListLayout")

    if uiListLayout8 then
      local parent2 = p13.Parent
      local v19 = 0
      local count2 = 0

      for key12, value12 in pairs(p13:GetChildren()) do
        if value12:IsA("Frame") and value12.Visible then
          v19 = v19 + value12.AbsoluteSize.Y + uiListLayout8.Padding.Offset
          count2 = count2 + 1
        end
      end

      if count2 == 0 and p13.Parent.Parent == favoritesPage then
        parent2.Visible = false
      else
        parent2.Visible = true
        parent2.Size = UDim2.new(1, -5, 0, v19 + 40)
      end
    end
  end

  buttonRow:GetPropertyChangedSignal("Visible"):Connect(function() f11(p10) end)

  textButton8.MouseEnter:Connect(function()
    textButton8.BackgroundTransparency = 0

    tweenService:Create(textButton8, TweenInfo.new(0.08), {
      BackgroundColor3 = Color3.fromRGB(255, 100, 0),
      BorderColor3 = Color3.fromRGB(255, 255, 255),
      TextColor3 = Color3.fromRGB(10, 10, 12),
    }):Play()
  end)

  textButton8.MouseLeave:Connect(function()
    tweenService:Create(textButton8, TweenInfo.new(0.08), {
      BorderColor3 = Color3.fromRGB(35, 35, 40),
      TextColor3 = Color3.fromRGB(200, 200, 200),
    }):Play()

    task.wait(0.08)

    if buttonRow.Parent then
      textButton8.BackgroundTransparency = 1
    end
  end)

  textButton8.MouseButton1Click:Connect(function()
    pcall(function() loadstring(game:HttpGet(p12))() end)
  end)

  local buttonRow2

  local function f12(p14, p15)
    if p14 ~= nil then
      v18 = p14
    else
      v18 = not v18
    end

    local universal, clone

    if v18 then
      textButton9.Text = "⭐"
      v11.Favorites[p11] = p12
      universal = p10.Parent.Name:upper():gsub(" ", ""):find("UNIVERSAL") and v13 or v14

      if not buttonRow2 then
        buttonRow2 = Instance.new("Frame")
        buttonRow2.Name = "ButtonRow"
        buttonRow2.Size = UDim2.new(1, 0, 0, 26)
        buttonRow2.BackgroundTransparency = 1
        buttonRow2.ZIndex = 5
        buttonRow2.Parent = universal

        clone = textButton8:Clone()
        clone.Parent = buttonRow2
        clone.Text = f1("ExecuteText") .. string.upper(f1(p11))

        clone.MouseButton1Click:Connect(function()
          pcall(function() loadstring(game:HttpGet(p12))() end)
        end)

        clone.MouseEnter:Connect(function()
          clone.BackgroundTransparency = 0

          tweenService:Create(clone, TweenInfo.new(0.08), {
            BackgroundColor3 = Color3.fromRGB(255, 100, 0),
            BorderColor3 = Color3.fromRGB(255, 255, 255),
            TextColor3 = Color3.fromRGB(10, 10, 12),
          }):Play()
        end)

        clone.MouseLeave:Connect(function()
          tweenService:Create(clone, TweenInfo.new(0.08), {
            BorderColor3 = Color3.fromRGB(35, 35, 40),
            TextColor3 = Color3.fromRGB(200, 200, 200),
          }):Play()

          task.wait(0.08)

          if buttonRow2.Parent then
            clone.BackgroundTransparency = 1
          end
        end)

        local clone2 = textButton9:Clone()
        clone2.Parent = buttonRow2
        clone2.MouseButton1Click:Connect(function() f12(false) end)

        buttonRow2:GetPropertyChangedSignal("Visible"):Connect(function() f11(universal) end)
        f11(universal)
      end
    else
      textButton9.Text = "☆"
      v11.Favorites[p11] = nil

      if buttonRow2 then
        local parent3 = buttonRow2.Parent

        buttonRow2:Destroy()
        buttonRow2 = nil

        if parent3 then
          f11(parent3)
        end
      end
    end
  end

  textButton9.MouseButton1Click:Connect(function() f12(nil) end)

  task.defer(function()
    if v11.Favorites[p11] then
      f12(true, true)
    end
  end)
end

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0, 6)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(150, 150, 160)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.Code
closeBtn.ZIndex = 3
closeBtn.Parent = mainFrame

closeBtn.MouseEnter:Connect(function()
  tweenService:Create(closeBtn, TweenInfo.new(0.08), { TextColor3 = Color3.fromRGB(255, 0, 0) }):Play()
end)

closeBtn.MouseLeave:Connect(function()
  tweenService:Create(closeBtn, TweenInfo.new(0.08), {
    TextColor3 = Color3.fromRGB(150, 150, 160),
  }):Play()
end)

closeBtn.MouseButton1Click:Connect(function() zhoanVANTA:Destroy() end)

local frame4 = Instance.new("Frame")
frame4.Size = UDim2.new(1, -30, 0, 75)
frame4.Position = UDim2.new(0, 15, 1, -90)
frame4.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
frame4.BorderColor3 = Color3.fromRGB(30, 30, 35)
frame4.BorderSizePixel = 1
frame4.ZIndex = 2
frame4.Parent = mainFrame

local imageLabel = Instance.new("ImageLabel")
imageLabel.Size = UDim2.new(0, 55, 0, 55)
imageLabel.Position = UDim2.new(0, 10, 0.5, -27)
imageLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
imageLabel.BorderColor3 = Color3.fromRGB(255, 100, 0)
imageLabel.BorderSizePixel = 1
imageLabel.ZIndex = 3
imageLabel.Parent = frame4

pcall(function()
  local image, v20 = players:GetUserThumbnailAsync(
    players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150
  )

  if v20 then
    imageLabel.Image = image
  end
end)

local textLabel8 = Instance.new("TextLabel")
textLabel8.Size = UDim2.new(0, 220, 0, 16)
textLabel8.Position = UDim2.new(0, 75, 0, 6)
textLabel8.BackgroundTransparency = 1
textLabel8.Text = f1("Identity") .. players.LocalPlayer.Name:upper()
textLabel8.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel8.TextSize = 11
textLabel8.Font = Enum.Font.Code
textLabel8.TextXAlignment = Enum.TextXAlignment.Left
textLabel8.ZIndex = 3
textLabel8.Parent = frame4

local v21 = identifyexecutor and identifyexecutor() or getexecutorname and getexecutorname()
  or "Unknown"

local textLabel9 = Instance.new("TextLabel")
textLabel9.Size = UDim2.new(0, 220, 0, 16)
textLabel9.Position = UDim2.new(0, 75, 0, 24)
textLabel9.BackgroundTransparency = 1
textLabel9.Text = f1("Software") .. v21:upper()
textLabel9.TextColor3 = Color3.fromRGB(130, 130, 140)
textLabel9.TextSize = 11
textLabel9.Font = Enum.Font.Code
textLabel9.TextXAlignment = Enum.TextXAlignment.Left
textLabel9.ZIndex = 3
textLabel9.Parent = frame4

local textButton10 = Instance.new("TextButton")
textButton10.Size = UDim2.new(0, 150, 0, 16)
textButton10.Position = UDim2.new(0, 75, 0, 42)
textButton10.BackgroundTransparency = 1
textButton10.Text = f1("DiscordLabel")
textButton10.TextColor3 = Color3.fromRGB(255, 100, 0)
textButton10.TextSize = 11
textButton10.Font = Enum.Font.Code
textButton10.TextXAlignment = Enum.TextXAlignment.Left
textButton10.ZIndex = 3
textButton10.Parent = frame4

textButton10.MouseButton1Click:Connect(function()
  local v22 = setclipboard or toclipboard or Clipboard and Clipboard.set
    or syn and syn.write_to_clipboard

  local text

  if v22 then
    v22("https://discord.gg/AR5NU2hQu")
    text = textButton10.Text

    textButton10.Text = " COPIED!"
    textButton10.TextColor3 = Color3.fromRGB(0, 220, 255)

    task.delay(1.5, function()
      textButton10.Text = text
      textButton10.TextColor3 = Color3.fromRGB(255, 100, 0)
    end)
  else
    textButton10.Text = " NOT SUPPORTED"
  end
end)

local textLabel10 = Instance.new("TextLabel")
textLabel10.Size = UDim2.new(0, 120, 0, 20)
textLabel10.Position = UDim2.new(1, -175, 0, 12)
textLabel10.BackgroundTransparency = 1
textLabel10.Text = "00:00:00"
textLabel10.TextColor3 = Color3.fromRGB(0, 220, 255)
textLabel10.TextSize = 13
textLabel10.Font = Enum.Font.Code
textLabel10.TextXAlignment = Enum.TextXAlignment.Right
textLabel10.ZIndex = 2
textLabel10.Parent = mainFrame

local v23 = false

local anonBtn2 = Instance.new("TextButton")
anonBtn2.Name = "AnonBtn"
anonBtn2.Size = UDim2.new(0, 100, 0, 22)
anonBtn2.Position = UDim2.new(1, -112, 0, 38)
anonBtn2.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
anonBtn2.BorderColor3 = Color3.fromRGB(255, 100, 0)
anonBtn2.BorderSizePixel = 1
anonBtn2.Text = "[ " .. f1("BtnMask") .. " ]"
anonBtn2.TextColor3 = Color3.fromRGB(255, 100, 0)
anonBtn2.TextSize = 10
anonBtn2.Font = Enum.Font.Code
anonBtn2.ZIndex = 3
anonBtn2.Parent = frame4

anonBtn2.MouseButton1Click:Connect(function()
  v23 = not v23

  if v23 then
    anonBtn2.Text = "[ " .. f1("BtnUnmask") .. " ]"
    anonBtn2.TextColor3 = Color3.fromRGB(0, 220, 255)
    anonBtn2.BorderColor3 = Color3.fromRGB(0, 220, 255)

    textLabel8.Text = f1("AnonIdentity")
    textLabel9.Text = f1("AnonSoftware")
    imageLabel.Image = "rbxassetid://0"
  else
    anonBtn2.Text = "[ " .. f1("BtnMask") .. " ]"
    anonBtn2.TextColor3 = Color3.fromRGB(255, 100, 0)
    anonBtn2.BorderColor3 = Color3.fromRGB(255, 100, 0)

    textLabel8.Text = f1("Identity") .. players.LocalPlayer.Name:upper()
    textLabel9.Text = f1("Software") .. v21:upper()

    pcall(function()
      imageLabel.Image = players:GetUserThumbnailAsync(
        players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150
      )
    end)
  end
end)

runService.RenderStepped:Connect(function()
  local t = os.date("*t")
  textLabel10.Text = string.format("%02d:%02d:%02d", t.hour, t.min, t.sec)
end)

task.spawn(function()
  local v24 = 0
  local v25 = 0
  local v26 = os.clock()
  local v27 = 60

  runService.RenderStepped:Connect(function()
    v25 = v25 + 1
    local v28 = os.clock()

    if v28 - v26 >= 0.25 then
      v27 = math.round(v25 / (v28 - v26))
      v25 = 0
      v26 = v28
    end
  end)

  while zhoanVANTA.Parent do
    local v29 = os.clock()

    if v29 - v24 >= 0.25 then
      v24 = v29
      local v30 = "00.0"

      pcall(function()
        local getValue = statsService.Network.ServerStatsItem["Data Ping"]:GetValue()
        v30 = string.format("%.1f", getValue)
      end)

      performanceLabel.Text = "FPS: " .. v27 .. " | MS: " .. v30
    end

    task.wait(0.05)
  end
end)

f8("TabUniversal", universalPage, 1)
f8("TabGames", gamesPage, 2)
f8("TabFavorites", favoritesPage, 3)
f8("TabServer", serverPage, 4)
f8("TabLanguage", languagePage, 5)

local v31 = f6(universalPage, "SectionUniversal")

f10(
  v31, "BtnFly",
  "https://raw.githubusercontent.com/GABLELE11/ZHOAN-HUB/refs/heads/main/fly%2Cnoclip%2Cinf%20jump.lua"
)

f10(
  v31, "BtnFling",
  "https://raw.githubusercontent.com/GABLELE11/ZHOAN-HUB/refs/heads/main/fling.lua"
)

local v32 = f6(gamesPage, "SectionGames")

f10(
  v32, "BtnPhfr",
  "https://raw.githubusercontent.com/ZHOANHUB/ZHOAN-HUB/refs/heads/main/PhantomForces.lua"
)

f10(
  v32, "BtnApoc",
  "https://raw.githubusercontent.com/GABLELE11/ZHOAN-HUB/refs/heads/main/AR2.lua"
)

f10(
  v32, "BtnRivals",
  "https://raw.githubusercontent.com/GABLELE11/ZHOAN-HUB/refs/heads/main/rivalsa.lua"
)

f10(
  v32, "BtnBloxstrike",
  "https://raw.githubusercontent.com/GABLELE11/ZHOAN-HUB/refs/heads/main/bloxstrike.lua"
)

f10(
  v32, "BtnJailbird",
  "https://raw.githubusercontent.com/GABLELE11/ZHOAN-HUB/refs/heads/main/jailbird.lua"
)

f10(
  v32, "BtnMM2", "https://raw.githubusercontent.com/GABLELE11/ZHOAN-HUB/refs/heads/main/mm2.lua"
)

f10(
  v32, "BtnMurder",
  "https://raw.githubusercontent.com/GABLELE11/ZHOAN-HUB/refs/heads/main/murder%20vs%20sheriff.lua"
)

local parent4 = f6(serverPage, "SectionServerMgmt")

local rejoinBtn2 = Instance.new("TextButton")
rejoinBtn2.Name = "RejoinBtn"
rejoinBtn2.Size = UDim2.new(1, 0, 0, 26)
rejoinBtn2.BackgroundTransparency = 1
rejoinBtn2.BorderColor3 = Color3.fromRGB(35, 35, 40)
rejoinBtn2.BorderSizePixel = 1
rejoinBtn2.Text = f1("BtnRejoin")
rejoinBtn2.TextColor3 = Color3.fromRGB(200, 200, 200)
rejoinBtn2.TextSize = 11
rejoinBtn2.Font = Enum.Font.Code
rejoinBtn2.TextXAlignment = Enum.TextXAlignment.Left
rejoinBtn2.ZIndex = 6
rejoinBtn2.Parent = parent4

rejoinBtn2.MouseEnter:Connect(function()
  rejoinBtn2.BackgroundTransparency = 0

  tweenService:Create(rejoinBtn2, TweenInfo.new(0.08), {
    BackgroundColor3 = Color3.fromRGB(255, 100, 0),
    BorderColor3 = Color3.fromRGB(255, 255, 255),
    TextColor3 = Color3.fromRGB(10, 10, 12),
  }):Play()
end)

rejoinBtn2.MouseLeave:Connect(function()
  tweenService:Create(rejoinBtn2, TweenInfo.new(0.08), {
    BorderColor3 = Color3.fromRGB(35, 35, 40),
    TextColor3 = Color3.fromRGB(200, 200, 200),
  }):Play()

  task.wait(0.08)

  if rejoinBtn2.Parent then
    rejoinBtn2.BackgroundTransparency = 1
  end
end)

rejoinBtn2.MouseButton1Click:Connect(function()
  if #players:GetPlayers() <= 1 then
    teleportService:Teleport(game.PlaceId, players.LocalPlayer)
  else
    teleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, players.LocalPlayer)
  end
end)

local copyBtn2 = Instance.new("TextButton")
copyBtn2.Name = "CopyBtn"
copyBtn2.Size = UDim2.new(1, 0, 0, 26)
copyBtn2.BackgroundTransparency = 1
copyBtn2.BorderColor3 = Color3.fromRGB(35, 35, 40)
copyBtn2.BorderSizePixel = 1
copyBtn2.Text = f1("BtnCopyJob")
copyBtn2.TextColor3 = Color3.fromRGB(200, 200, 200)
copyBtn2.TextSize = 11
copyBtn2.Font = Enum.Font.Code
copyBtn2.TextXAlignment = Enum.TextXAlignment.Left
copyBtn2.ZIndex = 6
copyBtn2.Parent = parent4

copyBtn2.MouseEnter:Connect(function()
  copyBtn2.BackgroundTransparency = 0

  tweenService:Create(copyBtn2, TweenInfo.new(0.08), {
    BackgroundColor3 = Color3.fromRGB(255, 100, 0),
    BorderColor3 = Color3.fromRGB(255, 255, 255),
    TextColor3 = Color3.fromRGB(10, 10, 12),
  }):Play()
end)

copyBtn2.MouseLeave:Connect(function()
  tweenService:Create(copyBtn2, TweenInfo.new(0.08), {
    BorderColor3 = Color3.fromRGB(35, 35, 40),
    TextColor3 = Color3.fromRGB(200, 200, 200),
  }):Play()

  task.wait(0.08)

  if copyBtn2.Parent then
    copyBtn2.BackgroundTransparency = 1
  end
end)

copyBtn2.MouseButton1Click:Connect(function()
  local v33 = setclipboard or toclipboard or Clipboard and Clipboard.set
    or syn and syn.write_to_clipboard

  if v33 then
    v33(tostring(game.JobId))

    copyBtn2.Text = f1("CopyJobSuccess")
    copyBtn2.TextColor3 = Color3.fromRGB(0, 220, 255)

    task.delay(1.5, function()
      copyBtn2.Text = f1("BtnCopyJob")
      copyBtn2.TextColor3 = Color3.fromRGB(200, 200, 200)
    end)
  end
end)

local autoBtn2 = Instance.new("TextButton")
autoBtn2.Name = "AutoBtn"
autoBtn2.Size = UDim2.new(1, 0, 0, 26)
autoBtn2.BackgroundTransparency = 1
autoBtn2.BorderColor3 = Color3.fromRGB(35, 35, 40)
autoBtn2.BorderSizePixel = 1
autoBtn2.Text = v11.AutoRejoin and f1("RejoinOn") or f1("RejoinOff")

autoBtn2.TextColor3 = v11.AutoRejoin and Color3.fromRGB(0, 220, 255)
  or Color3.fromRGB(200, 200, 200)

autoBtn2.TextSize = 11
autoBtn2.Font = Enum.Font.Code
autoBtn2.TextXAlignment = Enum.TextXAlignment.Left
autoBtn2.ZIndex = 6
autoBtn2.Parent = parent4

autoBtn2.MouseButton1Click:Connect(function()
  v11.AutoRejoin = not v11.AutoRejoin

  if v11.AutoRejoin then
    autoBtn2.Text = f1("RejoinOn")
    autoBtn2.TextColor3 = Color3.fromRGB(0, 220, 255)
  else
    autoBtn2.Text = f1("RejoinOff")
    autoBtn2.TextColor3 = Color3.fromRGB(200, 200, 200)
  end
end)

local parent5 = f6(serverPage, "SectionJoinJob")

local jobInput2 = Instance.new("TextBox")
jobInput2.Name = "JobInput"
jobInput2.Size = UDim2.new(1, 0, 0, 28)
jobInput2.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
jobInput2.BorderColor3 = Color3.fromRGB(255, 100, 0)
jobInput2.BorderSizePixel = 1
jobInput2.Text = ""
jobInput2.PlaceholderText = f1("PlaceholderJob")
jobInput2.PlaceholderColor3 = Color3.fromRGB(100, 100, 110)
jobInput2.TextColor3 = Color3.fromRGB(255, 255, 255)
jobInput2.TextSize = 11
jobInput2.Font = Enum.Font.Code
jobInput2.TextXAlignment = Enum.TextXAlignment.Center
jobInput2.ZIndex = 6
jobInput2.Parent = parent5

local joinBtn2 = Instance.new("TextButton")
joinBtn2.Name = "JoinBtn"
joinBtn2.Size = UDim2.new(1, 0, 0, 26)
joinBtn2.BackgroundTransparency = 1
joinBtn2.BorderColor3 = Color3.fromRGB(35, 35, 40)
joinBtn2.BorderSizePixel = 1
joinBtn2.Text = f1("BtnJoinJob")
joinBtn2.TextColor3 = Color3.fromRGB(200, 200, 200)
joinBtn2.TextSize = 11
joinBtn2.Font = Enum.Font.Code
joinBtn2.TextXAlignment = Enum.TextXAlignment.Left
joinBtn2.ZIndex = 6
joinBtn2.Parent = parent5

joinBtn2.MouseEnter:Connect(function()
  joinBtn2.BackgroundTransparency = 0

  tweenService:Create(joinBtn2, TweenInfo.new(0.08), {
    BackgroundColor3 = Color3.fromRGB(255, 100, 0),
    BorderColor3 = Color3.fromRGB(255, 255, 255),
    TextColor3 = Color3.fromRGB(10, 10, 12),
  }):Play()
end)

joinBtn2.MouseLeave:Connect(function()
  tweenService:Create(joinBtn2, TweenInfo.new(0.08), {
    BorderColor3 = Color3.fromRGB(35, 35, 40),
    TextColor3 = Color3.fromRGB(200, 200, 200),
  }):Play()

  task.wait(0.08)

  if joinBtn2.Parent then
    joinBtn2.BackgroundTransparency = 1
  end
end)

joinBtn2.MouseButton1Click:Connect(function()
  local gsub3 = jobInput2.Text:gsub("%s+", "")

  if #gsub3 > 0 then
    teleportService:TeleportToPlaceInstance(game.PlaceId, gsub3, players.LocalPlayer)
  end
end)

f9(v15, "en")
f9(v15, "fr")
f9(v15, "es")
f9(v15, "pt")
f9(v15, "it")

guiService.ErrorMessageChanged:Connect(function()
  if v11.AutoRejoin then
    task.wait(1)

    if #players:GetPlayers() <= 1 then
      teleportService:Teleport(game.PlaceId, players.LocalPlayer)
    else
      teleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, players.LocalPlayer)
    end
  end
end)

userInputService.InputBegan:Connect(function(input7, p16)
  if not p16 then
    if input7.KeyCode == Enum.KeyCode.RightControl then
      mainFrame.Visible = not mainFrame.Visible
    end
  end
end)

task.spawn(function()
  local function f13(p17, p18)
    local v34 = 0

    for key13, value13 in pairs(p17:GetChildren()) do
      if value13:IsA("Frame") and value13.Name:find("Section") then
        v34 = v34 + value13.AbsoluteSize.Y + p18.Padding.Offset
      end
    end

    p17.CanvasSize = UDim2.new(0, 0, 0, v34 + 60)
  end

  local function f14(p19, p20)
    p20:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() f13(p19, p20) end)
    p19.ChildAdded:Connect(function() f13(p19, p20) end)

    for key14, value14 in pairs(p19:GetChildren()) do
      if value14:IsA("Frame") and value14.Name:find("Section") then
        value14:GetPropertyChangedSignal("Size"):Connect(function() f13(p19, p20) end)
      end
    end
  end

  f14(universalPage, uiListLayout2)
  f14(gamesPage, uiListLayout3)
  f14(favoritesPage, uiListLayout4)
  f14(serverPage, uiListLayout5)
  f14(languagePage, uiListLayout6)

  f13(universalPage, uiListLayout2)
  f13(gamesPage, uiListLayout3)
  f13(favoritesPage, uiListLayout4)
  f13(serverPage, uiListLayout5)
  f13(languagePage, uiListLayout6)
end)
