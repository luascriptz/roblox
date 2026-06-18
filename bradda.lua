-- ===================================================== --
-- Services & Konstanten
-- ===================================================== --
local Players             = game:GetService("Players")
local RunService          = game:GetService("RunService")
local UserInputService    = game:GetService("UserInputService")
local TweenService        = game:GetService("TweenService")
local TeleportService     = game:GetService("TeleportService")
local CoreGui             = game:GetService("CoreGui")
local VIM                 = game:GetService("VirtualInputManager")
local ContextActionService= game:GetService("ContextActionService")
local LocalPlayer         = Players.LocalPlayer
local Camera              = workspace.CurrentCamera

local DRAWING_SUPPORTED   = (typeof(Drawing) == "table" and typeof(Drawing.new) == "function")

-- ===================================================== --
-- Sprachdatei
-- ===================================================== --
local Languages = {
    English = {
        MenuTitle = "Bradda Cheat v3",
        ToggleOn = "ON", ToggleOff = "OFF",
        Notifications = "Notifications",  MenuKey = "Menu Key",
        FPSDisplay = "FPS Counter",        Language = "Language",
        TabESP = "ESP", TabAimbot = "AIMBOT", TabCombat = "COMBAT",
        TabMovement = "MOVEMENT",          TabOthers = "OTHERS",
        -- ESP
        ESP_Box2D = "2D Box",             ESP_Outline = "Outline",
        ESP_Name = "Name",                ESP_Healthbar = "Healthbar",
        ESP_Tracer = "Tracer",            ESP_Rainbow = "Rainbow",
        ESP_TeamCheck = "Team Check",     ESP_TracerStart = "Tracer Start",
        ESP_RainbowSpeed = "Rainbow Speed",
        -- Aimbot
        Aimbot_Enabled = "Aimbot",        Aimbot_TeamCheck = "Team Check",
        Aimbot_VisibleCheck = "Visible Check", Aimbot_UseFovCircle = "Use FOV Circle",
        Aimbot_ShowFovCircle = "Show FOV Circle", Aimbot_FovPosition = "FOV Position",
        Aimbot_FovSize = "FOV Size",      Aimbot_Smoothness = "Smoothness",
        Aimbot_Triggerbot = "Triggerbot", Aimbot_TriggerbotDelay = "Triggerbot Delay",
        -- Combat
        Combat_Spinbot = "Spinbot",       Combat_SpinSpeed = "Spin Speed",
        Combat_KillAll = "Kill All",      Combat_KillAllRunning = "STOP Kill All",
        Combat_KillTeam = "Target Team",  Combat_KillDelay = "Shot Delay",
        Combat_TeleportDelay = "Teleport Delay",
        -- Movement
        Move_Speed = "Speedhack",         Move_SpeedVal = "Speed Multiplier",
        Move_Jump = "Jumphack",           Move_JumpVal = "Jump Power",
        Move_Fly = "Fly",                 Move_FlySpeed = "Fly Speed",
        Move_FlyUp = "Fly Up Key",        Move_FlyDown = "Fly Down Key",
        Move_AntiAfk = "Anti-AFK",
        -- Others
        Others_Teleport = "Teleport to Player", Others_Rejoin = "Rejoin",
        Others_Serverhop = "Serverhop",   Others_NoPlayers = "No other players",
        -- Notifications
        Notify_Enabled = "enabled",       Notify_Disabled = "disabled",
        Notify_Teleporting = "Flying to %s (%.1fs)", Notify_Arrived = "Arrived at %s",
        Notify_InvalidTarget = "Invalid target", Notify_InvalidSelf = "Own char invalid",
        Notify_AlreadyFlying = "Already flying", Notify_Rejoining = "Rejoining...",
        Notify_Serverhop = "Serverhop...", Notify_KeyChanged = "Menu key: %s",
        Notify_InvalidKey = "Invalid key!", Notify_Loaded = "Modern Menu v3 | ALT = toggle",
        Notify_KillAllStart = "Kill All started", Notify_KillAllStop = "Kill All stopped",
        Notify_KillingPlayer = "Targeting: %s", Notify_PlayerDead = "%s eliminated",
        Notify_KillAllDone = "Kill All done!",
        -- Options
        Option_Bottom = "Bottom", Option_Mouse = "Mouse", Option_Center = "Center",
        Option_English = "English", Option_Deutsch = "German",
        Option_Enemies = "Enemies", Option_AllTeams = "All Teams", Option_OwnTeam = "Own Team",
        Option_E = "E", Option_Q = "Q", Option_R = "R", Option_F = "F",
        Option_Space = "Space", Option_X = "X", Option_Z = "Z",
    },
    Deutsch = {
        MenuTitle = "Bradda Cheat v3",
        ToggleOn = "AN", ToggleOff = "AUS",
        Notifications = "Benachrichtigungen", MenuKey = "Menü-Taste",
        FPSDisplay = "FPS Anzeige",        Language = "Sprache",
        TabESP = "ESP", TabAimbot = "ZIELHILFE", TabCombat = "KAMPF",
        TabMovement = "BEWEGUNG",          TabOthers = "SONSTIGES",
        ESP_Box2D = "2D Box",              ESP_Outline = "Umriss",
        ESP_Name = "Name",                 ESP_Healthbar = "Lebensbalken",
        ESP_Tracer = "Linie",              ESP_Rainbow = "Regenbogen",
        ESP_TeamCheck = "Team-Prüfung",    ESP_TracerStart = "Linienstart",
        ESP_RainbowSpeed = "Regenbogen-Geschw.",
        Aimbot_Enabled = "Zielhilfe",      Aimbot_TeamCheck = "Team-Prüfung",
        Aimbot_VisibleCheck = "Sichtbarkeit", Aimbot_UseFovCircle = "FOV-Kreis verwenden",
        Aimbot_ShowFovCircle = "FOV-Kreis anzeigen", Aimbot_FovPosition = "FOV-Position",
        Aimbot_FovSize = "FOV-Größe",      Aimbot_Smoothness = "Geschmeidigkeit",
        Aimbot_Triggerbot = "Triggerbot",  Aimbot_TriggerbotDelay = "Triggerbot-Verzögerung",
        Combat_Spinbot = "Spinbot",        Combat_SpinSpeed = "Drehgeschwindigkeit",
        Combat_KillAll = "Alle Töten",     Combat_KillAllRunning = "STOPP",
        Combat_KillTeam = "Ziel-Team",     Combat_KillDelay = "Schuss-Verzögerung",
        Combat_TeleportDelay = "Teleport-Verzögerung",
        Move_Speed = "Speedhack",          Move_SpeedVal = "Geschwindigkeits-Multi",
        Move_Jump = "Sprunghack",          Move_JumpVal = "Sprungkraft",
        Move_Fly = "Fliegen",              Move_FlySpeed = "Flug-Geschwindigkeit",
        Move_FlyUp = "Hoch-Taste",         Move_FlyDown = "Runter-Taste",
        Move_AntiAfk = "Anti-AFK",
        Others_Teleport = "Zu Spieler teleportieren", Others_Rejoin = "Neu verbinden",
        Others_Serverhop = "Server wechseln", Others_NoPlayers = "Keine anderen Spieler",
        Notify_Enabled = "aktiviert",      Notify_Disabled = "deaktiviert",
        Notify_Teleporting = "Fliege zu %s (%.1fs)", Notify_Arrived = "Angekommen bei %s",
        Notify_InvalidTarget = "Ungültiges Ziel", Notify_InvalidSelf = "Eigener Char ungültig",
        Notify_AlreadyFlying = "Bereits am fliegen", Notify_Rejoining = "Verbinde neu...",
        Notify_Serverhop = "Serverwechsel...", Notify_KeyChanged = "Menü-Taste: %s",
        Notify_InvalidKey = "Ungültiger Key!", Notify_Loaded = "Modernes Menü v3 | ALT = toggle",
        Notify_KillAllStart = "Alle Töten gestartet", Notify_KillAllStop = "Alle Töten gestoppt",
        Notify_KillingPlayer = "Ziel: %s", Notify_PlayerDead = "%s eliminiert",
        Notify_KillAllDone = "Alle Töten fertig!",
        Option_Bottom = "Unten",           Option_Mouse = "Maus",
        Option_Center = "Mitte",           Option_English = "Englisch",
        Option_Deutsch = "Deutsch",        Option_Enemies = "Feinde",
        Option_AllTeams = "Alle Teams",    Option_OwnTeam = "Eigenes Team",
        Option_E = "E", Option_Q = "Q",    Option_R = "R", Option_F = "F",
        Option_Space = "Leertaste",        Option_X = "X", Option_Z = "Z",
    }
}
local Lang = Languages.English

-- ===================================================== --
-- Einstellungen
-- ===================================================== --
local Settings = {
    MenuKey  = Enum.KeyCode.LeftAlt,
    Language = "English",
    ShowFPS  = false,
    Notifications = true,
    ESP = {
        Box2D = false, Outline = false, Name = false, Healthbar = false,
        Tracer = false, Rainbow = false, TeamCheck = false,
        TracerStart = "Bottom", RainbowSpeed = 0.01,
    },
    Aimbot = {
        Enabled = false, TeamCheck = true, VisibleCheck = true,
        UseFovCircle = true, ShowFovCircle = true,
        FovPosition = "Center", FovSize = 150, Smoothness = 0.15,
        Triggerbot = false, TriggerbotDelay = 0.08,
    },
    Combat = {
        Spinbot = false, SpinSpeed = 15,
        KillAll = false, KillTeam = "Enemies",
        KillDelay = 0.05, TeleportDelay = 0.5,
    },
    Movement = {
        Speed    = false, SpeedMult = 2.0,   -- Multiplikator (1 = normal = 16 ws)
        Jump     = false, JumpPower = 120,    -- Echter JumpPower-Wert (50 = default)
        Fly      = false, FlySpeed  = 60,
        FlyUp    = "E",   FlyDown   = "Q",
        AntiAfk  = false,
    },
}

-- ===================================================== --
-- Globale Variablen
-- ===================================================== --
local MenuGUI           = nil
local ESPObjects        = {}
local IsMenuOpen        = false
local RainbowHue        = 0
local FPSLabel          = nil
local LastFrameTime     = tick()
local FrameCount        = 0
local CurrentFPS        = 0
local IsFlying_TP       = false   -- für SafeTeleport-Lock
local NotificationGui   = nil
local ActiveNotifications = {}
local FovCircle         = nil
local LastTriggerTime   = 0
local AimTarget         = nil
local CurrentTab        = "ESP"
local Dragging          = false
local DragOffset        = Vector2.new()
local SpinAngle         = 0
local KillAllRunning    = false

-- Movement State
local FlyActive         = false
local FlyBodyPos        = nil
local FlyBodyGyro       = nil
local LastJumpTime      = 0
local SpeedConn         = nil   -- Heartbeat-Connection für Speed
local AntiAfkConn       = nil
local CharacterAddedConn= nil

-- Forward Declarations
local CreateMenu
local updateCanvasSize
local ShowNotification
local SetupCharacterMovement  -- wird nach Charakter-Spawn neu gesetzt

-- ===================================================== --
-- Hilfsfunktionen
-- ===================================================== --
local function GetChar()
    return LocalPlayer.Character
end
local function GetHRP()
    local c = GetChar()
    return c and c:FindFirstChild("HumanoidRootPart")
end
local function GetHum()
    local c = GetChar()
    return c and c:FindFirstChildOfClass("Humanoid")
end

local function GetPlayerTeam(p)
    return p and p.Team or nil
end
local function IsSameTeam(p)
    if p == LocalPlayer then return true end
    local a, b = GetPlayerTeam(LocalPlayer), GetPlayerTeam(p)
    return a and b and a == b or false
end
local function GetTeamName(p)
    local t = GetPlayerTeam(p)
    return (t and typeof(t) == "Instance") and t.Name or "No Team"
end
local function GetTeamColor(p)
    local t = GetPlayerTeam(p)
    if t and typeof(t) == "Instance" and t.TeamColor then return t.TeamColor.Color end
    return Color3.new(1,1,1)
end
local function IsVisible(part)
    if not part then return false end
    local o = Camera.CFrame.Position
    local d = (part.Position - o).Unit * 1000
    local rp = RaycastParams.new()
    rp.FilterType = Enum.RaycastFilterType.Blacklist
    rp.FilterDescendantsInstances = {LocalPlayer.Character, part.Parent}
    local r = workspace:Raycast(o, d, rp)
    return not r or r.Instance == part or r.Instance:IsDescendantOf(part.Parent)
end
local function IsKillTarget(p)
    if p == LocalPlayer then return false end
    if not (p and p.Character) then return false end
    local h = p.Character:FindFirstChildOfClass("Humanoid")
    if not h or h.Health <= 0 then return false end
    local m = Settings.Combat.KillTeam
    if m == "Enemies"  then return not IsSameTeam(p) end
    if m == "OwnTeam"  then return IsSameTeam(p) end
    return true
end

-- KeyCode-String → Enum.KeyCode
local KEY_MAP = {
    E = Enum.KeyCode.E, Q = Enum.KeyCode.Q, R = Enum.KeyCode.R,
    F = Enum.KeyCode.F, X = Enum.KeyCode.X, Z = Enum.KeyCode.Z,
    Space = Enum.KeyCode.Space, C = Enum.KeyCode.C, V = Enum.KeyCode.V,
}
local function StrToKey(s) return KEY_MAP[s] or Enum.KeyCode.E end

-- ===================================================== --
-- FPS Display
-- ===================================================== --
local function InitFPSDisplay()
    if not DRAWING_SUPPORTED or FPSLabel then return end
    FPSLabel = Drawing.new("Text")
    FPSLabel.Size = 17
    FPSLabel.Color = Color3.fromRGB(0, 230, 90)
    FPSLabel.Outline = true
    FPSLabel.OutlineColor = Color3.new(0,0,0)
    FPSLabel.Position = Vector2.new(12, 12)
    FPSLabel.Text = "FPS: 0"
    FPSLabel.Visible = false
    FPSLabel.Font = 2
end

-- ===================================================== --
-- Benachrichtigungen
-- ===================================================== --
local function InitNotifications()
    if NotificationGui then return end
    NotificationGui = Instance.new("ScreenGui")
    NotificationGui.Name = "ModMenuNotify"
    NotificationGui.ResetOnSpawn = false
    NotificationGui.Parent = CoreGui
    NotificationGui.DisplayOrder = 100
    NotificationGui.IgnoreGuiInset = true
end

ShowNotification = function(text, duration)
    if not Settings.Notifications then return end
    duration = duration or 3
    InitNotifications()
    task.spawn(function()
        local f = Instance.new("Frame")
        f.Size = UDim2.new(0,270,0,50)
        f.Position = UDim2.new(0.5,-135, 0, 10 + #ActiveNotifications*60)
        f.BackgroundColor3 = Color3.fromRGB(18,18,24)
        f.BorderSizePixel = 0; f.Parent = NotificationGui
        local s = Instance.new("UIStroke")
        s.Color = Color3.fromRGB(0,150,255); s.Thickness = 1.5; s.Parent = f
        local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,10); c.Parent = f
        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(1,-20,1,-10); l.Position = UDim2.new(0,10,0,5)
        l.BackgroundTransparency = 1; l.TextColor3 = Color3.new(1,1,1)
        l.Text = text; l.TextSize = 14; l.Font = Enum.Font.GothamSemibold
        l.TextWrapped = true; l.Parent = f
        table.insert(ActiveNotifications, f)
        f.BackgroundTransparency = 1; l.TextTransparency = 1
        TweenService:Create(f, TweenInfo.new(0.2), {BackgroundTransparency=0}):Play()
        TweenService:Create(l, TweenInfo.new(0.2), {TextTransparency=0}):Play()
        task.wait(duration)
        TweenService:Create(f, TweenInfo.new(0.2), {BackgroundTransparency=1}):Play()
        TweenService:Create(l, TweenInfo.new(0.2), {TextTransparency=1}):Play()
        task.wait(0.25)
        for i,v in ipairs(ActiveNotifications) do
            if v == f then table.remove(ActiveNotifications,i); break end
        end
        f:Destroy()
        for i,v in ipairs(ActiveNotifications) do
            pcall(function()
                v:TweenPosition(UDim2.new(0.5,-135,0,10+(i-1)*60),
                    Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
            end)
        end
    end)
end

-- ===================================================== --
-- Sprache
-- ===================================================== --
local function SetLanguage(lang)
    Settings.Language = lang
    Lang = lang == "English" and Languages.English or Languages.Deutsch
    if MenuGUI then MenuGUI:Destroy(); MenuGUI = nil end
    CreateMenu()
end

-- ===================================================== --
-- ╔══════════════════════════════════════════════╗
-- ║           MOVEMENT SYSTEM                    ║
-- ╚══════════════════════════════════════════════╝
-- Alle Methoden sind darauf ausgelegt, Server-seitige
-- Checks zu umgehen:
--   Speed:  WalkSpeed wird im Heartbeat sanft auf den
--           Zielwert gesetzt, aber mit leichtem Jitter
--           (±0.5) damit Anti-Cheat keine konstante
--           Über-Geschwindigkeit erkennt.
--           Beim Deaktivieren sofort zurück auf 16.
--   Jump:   JumpPower wird NUR für ~0.05s beim
--           tatsächlichen Sprung erhöht und dann
--           sofort zurückgesetzt. BodyVelocity-Burst
--           als Alternative.
--   Fly:    BodyGyro + BodyPosition auf HRP.
--           Humanoid.PlatformStand = true nur während
--           des Fluges. Keine konstante Noclip-Flag.
--           FlySpeed-Limit damit Bewegung organisch wirkt.
-- ===================================================== --

-- ---------- SPEED ----------
local SpeedHBConn = nil
local BASE_WALKSPEED = 16

local function ApplySpeed()
    local hum = GetHum()
    if not hum then return end
    if Settings.Movement.Speed then
        -- Sanfter Jitter verhindert konstante-Geschwindigkeit-Detection
        local target = BASE_WALKSPEED * Settings.Movement.SpeedMult
        local jitter = (math.random() - 0.5) * 0.8  -- ±0.4 Jitter
        hum.WalkSpeed = target + jitter
    else
        hum.WalkSpeed = BASE_WALKSPEED
    end
end

local function StartSpeed()
    if SpeedHBConn then SpeedHBConn:Disconnect() end
    SpeedHBConn = RunService.Heartbeat:Connect(function()
        if Settings.Movement.Speed then
            ApplySpeed()
        else
            -- Reset und Connection schließen
            local hum = GetHum()
            if hum then hum.WalkSpeed = BASE_WALKSPEED end
            SpeedHBConn:Disconnect()
            SpeedHBConn = nil
        end
    end)
end

local function StopSpeed()
    if SpeedHBConn then SpeedHBConn:Disconnect(); SpeedHBConn = nil end
    local hum = GetHum()
    if hum then hum.WalkSpeed = BASE_WALKSPEED end
end

-- ---------- JUMP ----------
local BASE_JUMPPOWER = 50
local JumpConn = nil

local function SetupJumpHack()
    -- Disconnect alten Listener
    if JumpConn then JumpConn:Disconnect(); JumpConn = nil end
    if not Settings.Movement.Jump then
        local hum = GetHum()
        if hum then hum.JumpPower = BASE_JUMPPOWER end
        return
    end
    -- Horche auf den Jumping-State
    local hum = GetHum()
    if not hum then return end
    JumpConn = hum.StateChanged:Connect(function(_, new)
        if new == Enum.HumanoidStateType.Jumping then
            -- Erhöhe JumpPower kurz für diesen Sprung
            hum.JumpPower = Settings.Movement.JumpPower
            -- Sofortiger Reset nach einem Frame damit Server
            -- nie einen dauerhaft hohen JumpPower-Wert sieht
            task.defer(function()
                task.wait(0.08)
                if not Settings.Movement.Jump then
                    hum.JumpPower = BASE_JUMPPOWER
                end
            end)
        elseif new == Enum.HumanoidStateType.Freefall or
               new == Enum.HumanoidStateType.Landed then
            -- Nach Landung zurücksetzen
            if not Settings.Movement.Jump then
                hum.JumpPower = BASE_JUMPPOWER
            end
        end
    end)
end

local function StopJumpHack()
    if JumpConn then JumpConn:Disconnect(); JumpConn = nil end
    local hum = GetHum()
    if hum then hum.JumpPower = BASE_JUMPPOWER end
end

-- ---------- FLY ----------
-- Stealth-Technik:
--   - BodyPosition + BodyGyro werden einmalig erstellt
--   - Humanoid.PlatformStand = true (unsichtbar für Server
--     da es ein normaler Roblox-State ist)
--   - Bewegung erfolgt relativ zur Kamera
--   - MaxForce begrenzt um schnelle Teleportation zu vermeiden
--   - Periodisches kurzes "Ausschalten" simuliert Gravity-Checks

local FLY_MAX_FORCE = Vector3.new(1e5, 1e5, 1e5)
local FlyConn = nil
local FlyAntiDetectTimer = 0

local function StopFly()
    FlyActive = false
    Settings.Movement.Fly = false

    if FlyConn then FlyConn:Disconnect(); FlyConn = nil end

    local hrp = GetHRP()
    if hrp then
        if FlyBodyPos  and FlyBodyPos.Parent  then FlyBodyPos:Destroy();  FlyBodyPos = nil end
        if FlyBodyGyro and FlyBodyGyro.Parent then FlyBodyGyro:Destroy(); FlyBodyGyro = nil end
    end
    local hum = GetHum()
    if hum then
        hum.PlatformStand = false
        -- WalkSpeed + JumpPower wiederherstellen
        hum.WalkSpeed = Settings.Movement.Speed and BASE_WALKSPEED * Settings.Movement.SpeedMult or BASE_WALKSPEED
        hum.JumpPower = BASE_JUMPPOWER
    end
end

local function StartFly()
    local hrp = GetHRP()
    local hum = GetHum()
    if not (hrp and hum) then return end

    FlyActive = true
    Settings.Movement.Fly = true
    FlyAntiDetectTimer = 0

    -- Aufräumen falls schon vorhanden
    if FlyBodyPos  and FlyBodyPos.Parent  then FlyBodyPos:Destroy() end
    if FlyBodyGyro and FlyBodyGyro.Parent then FlyBodyGyro:Destroy() end

    FlyBodyPos = Instance.new("BodyPosition")
    FlyBodyPos.MaxForce = FLY_MAX_FORCE
    FlyBodyPos.P = 1e4
    FlyBodyPos.D = 500
    FlyBodyPos.Position = hrp.Position
    FlyBodyPos.Parent = hrp

    FlyBodyGyro = Instance.new("BodyGyro")
    FlyBodyGyro.MaxTorque = FLY_MAX_FORCE
    FlyBodyGyro.P = 1e4
    FlyBodyGyro.CFrame = hrp.CFrame
    FlyBodyGyro.Parent = hrp

    hum.PlatformStand = true

    local upKey   = StrToKey(Settings.Movement.FlyUp)
    local downKey = StrToKey(Settings.Movement.FlyDown)

    if FlyConn then FlyConn:Disconnect() end
    FlyConn = RunService.RenderStepped:Connect(function(dt)
        if not FlyActive or not Settings.Movement.Fly then
            StopFly(); return
        end

        local hrpNow = GetHRP()
        local humNow = GetHum()
        if not (hrpNow and humNow) then StopFly(); return end

        -- Sicherstellen PlatformStand aktiv bleibt
        if not humNow.PlatformStand then humNow.PlatformStand = true end

        -- Tasteneingabe
        local fwd  = UserInputService:IsKeyDown(Enum.KeyCode.W)
        local back = UserInputService:IsKeyDown(Enum.KeyCode.S)
        local left = UserInputService:IsKeyDown(Enum.KeyCode.A)
        local rght = UserInputService:IsKeyDown(Enum.KeyCode.D)
        local up   = UserInputService:IsKeyDown(upKey)
        local down = UserInputService:IsKeyDown(downKey)

        local camCF = Camera.CFrame
        local moveVec = Vector3.new()

        if fwd  then moveVec = moveVec + camCF.LookVector end
        if back then moveVec = moveVec - camCF.LookVector end
        if left then moveVec = moveVec - camCF.RightVector end
        if rght then moveVec = moveVec + camCF.RightVector end
        if up   then moveVec = moveVec + Vector3.new(0,1,0) end
        if down then moveVec = moveVec - Vector3.new(0,1,0) end

        -- Normalisieren wenn Bewegung vorhanden
        if moveVec.Magnitude > 0.01 then
            moveVec = moveVec.Unit
        end

        local spd = Settings.Movement.FlySpeed

        -- Anti-Detect: Alle 8-12s kurz PlatformStand ausschalten
        -- (simuliert normalen Sprung/Landing Cycle)
        FlyAntiDetectTimer = FlyAntiDetectTimer + dt
        local detectInterval = 8 + math.random() * 4
        if FlyAntiDetectTimer >= detectInterval then
            FlyAntiDetectTimer = 0
            humNow.PlatformStand = false
            task.wait(0.05)
            if FlyActive then humNow.PlatformStand = true end
        end

        -- Zielposition
        local targetPos = hrpNow.Position + moveVec * spd * dt * 60
        FlyBodyPos.Position = targetPos
        FlyBodyGyro.CFrame = camCF

        -- Sanfte Gyro-Rotation (kein abruptes Drehen)
        FlyBodyGyro.CFrame = CFrame.new(hrpNow.Position) * CFrame.Angles(0, camCF:ToEulerAnglesYXZ(), 0)
    end)
end

local function ToggleFly()
    if FlyActive then
        StopFly()
        ShowNotification("Fly " .. Lang.Notify_Disabled, 2)
    else
        StartFly()
        ShowNotification("Fly " .. Lang.Notify_Enabled, 2)
    end
end

-- ---------- ANTI-AFK ----------
-- Verhindert Auto-Kick durch:
--   1. Periodisch simulierte Tasteneingaben (unsichtbar)
--   2. ContextActionService Bind der nichts tut (verhindert idle-Erkennung)
--   3. Kleine zufällige CFrame Rotationen am HRP

local ANTI_AFK_ACTION = "ModMenuAntiAFK_v3"

local function StartAntiAfk()
    if AntiAfkConn then AntiAfkConn:Disconnect() end

    -- Bind: Verhindert dass Roblox "No Input" erkennt
    pcall(function()
        ContextActionService:BindAction(ANTI_AFK_ACTION, function() end, false,
            Enum.UserInputType.Gamepad1)
    end)

    local timer = 0
    AntiAfkConn = RunService.Heartbeat:Connect(function(dt)
        if not Settings.Movement.AntiAfk then
            AntiAfkConn:Disconnect(); AntiAfkConn = nil
            pcall(function() ContextActionService:UnbindAction(ANTI_AFK_ACTION) end)
            return
        end

        timer = timer + dt
        -- Alle ~55s eine kleine simulierte Bewegung
        if timer >= 55 + math.random() * 10 then
            timer = 0
            -- Simuliere Tastendruck (W für <1 Frame)
            pcall(function()
                VIM:SendKeyEvent(true,  Enum.KeyCode.W, false, game)
                task.wait(0.05)
                VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
            end)
            -- Kleiner CFrame-Jitter am Charakter
            local hrp = GetHRP()
            if hrp then
                local orig = hrp.CFrame
                hrp.CFrame = orig * CFrame.Angles(0, math.rad(math.random(-2,2)), 0)
                task.wait(0.1)
                if Settings.Movement.AntiAfk and hrp and hrp.Parent then
                    hrp.CFrame = orig
                end
            end
        end
    end)
end

local function StopAntiAfk()
    if AntiAfkConn then AntiAfkConn:Disconnect(); AntiAfkConn = nil end
    pcall(function() ContextActionService:UnbindAction(ANTI_AFK_ACTION) end)
end

-- ===================================================== --
-- Character Respawn Handler
-- (Speed/Jump/Fly nach Respawn neu einrichten)
-- ===================================================== --
local function OnCharacterAdded(char)
    -- Kurz warten bis Humanoid vollständig geladen
    task.wait(0.5)

    -- Fly-Objekte sauber entfernen
    if FlyActive then
        FlyActive = false
        if FlyConn then FlyConn:Disconnect(); FlyConn = nil end
        FlyBodyPos = nil; FlyBodyGyro = nil
        Settings.Movement.Fly = false
    end

    -- Speed neu einrichten wenn aktiv
    if Settings.Movement.Speed then
        StartSpeed()
    end
    -- Jump neu einrichten wenn aktiv
    if Settings.Movement.Jump then
        SetupJumpHack()
    end
end

LocalPlayer.CharacterAdded:Connect(OnCharacterAdded)

-- ===================================================== --
-- Teleport Helpers
-- ===================================================== --
local function TeleportToPos(targetPos, duration)
    local hrp = GetHRP(); if not hrp then return false end
    local startPos = hrp.Position
    local startTime = tick(); local done = false; local conn
    conn = RunService.Heartbeat:Connect(function()
        local c = GetChar()
        if not (c and c:FindFirstChild("HumanoidRootPart")) then
            conn:Disconnect(); done = true; return
        end
        local alpha = math.min((tick()-startTime)/duration, 1)
        c.HumanoidRootPart.CFrame = CFrame.new(startPos:Lerp(targetPos, alpha))
        if alpha >= 1 then conn:Disconnect(); done = true end
    end)
    local t = 0
    while not done and t < duration+0.5 do task.wait(0.05); t=t+0.05 end
    return true
end

local function SafeTeleportToPlayer(targetPlayer, silent)
    if IsFlying_TP and not silent then
        ShowNotification(Lang.Notify_AlreadyFlying, 2); return false
    end
    if not (targetPlayer and targetPlayer.Character
        and targetPlayer.Character:FindFirstChild("HumanoidRootPart")) then
        if not silent then ShowNotification(Lang.Notify_InvalidTarget, 2) end; return false
    end
    if not GetHRP() then
        if not silent then ShowNotification(Lang.Notify_InvalidSelf, 2) end; return false
    end
    local tp = targetPlayer.Character.HumanoidRootPart.Position + Vector3.new(0,2,2)
    local dist = (tp - GetHRP().Position).Magnitude
    local dur  = math.clamp(dist/80, 0.3, 4)
    if not silent then
        IsFlying_TP = true
        ShowNotification(string.format(Lang.Notify_Teleporting, targetPlayer.Name, dur), 2)
    end
    TeleportToPos(tp, dur)
    if not silent then
        IsFlying_TP = false
        ShowNotification(string.format(Lang.Notify_Arrived, targetPlayer.Name), 2)
    end
    return true
end

-- ===================================================== --
-- Schießen
-- ===================================================== --
local function DoClick()
    if typeof(mouse1click) == "function" then
        mouse1click()
    elseif typeof(mouse1press) == "function" and typeof(mouse1release) == "function" then
        mouse1press(); task.wait(0.03); mouse1release()
    else
        pcall(function()
            VIM:SendMouseButtonEvent(0,0,0,true,game,1)
            task.wait(0.03)
            VIM:SendMouseButtonEvent(0,0,0,false,game,1)
        end)
    end
end

-- ===================================================== --
-- Spinbot
-- ===================================================== --
local function UpdateSpinbot(dt)
    if not Settings.Combat.Spinbot then return end
    local hrp = GetHRP(); if not hrp then return end
    SpinAngle = (SpinAngle + Settings.Combat.SpinSpeed) % 360
    hrp.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(0, math.rad(SpinAngle), 0)
end

-- ===================================================== --
-- Kill All
-- ===================================================== --
local function StopKillAll()
    KillAllRunning = false; Settings.Combat.KillAll = false
    ShowNotification(Lang.Notify_KillAllStop, 2)
end

local function StartKillAll()
    if KillAllRunning then StopKillAll(); return end
    KillAllRunning = true; Settings.Combat.KillAll = true
    ShowNotification(Lang.Notify_KillAllStart, 2)
    task.spawn(function()
        while KillAllRunning do
            local targets = {}
            for _, p in ipairs(Players:GetPlayers()) do
                if IsKillTarget(p) then table.insert(targets, p) end
            end
            if #targets == 0 then
                ShowNotification(Lang.Notify_KillAllDone, 3)
                KillAllRunning = false; Settings.Combat.KillAll = false; break
            end
            for _, target in ipairs(targets) do
                if not KillAllRunning then break end
                if not IsKillTarget(target) then continue end
                ShowNotification(string.format(Lang.Notify_KillingPlayer, target.Name), 2)
                if not (target.Character and target.Character:FindFirstChild("HumanoidRootPart")) then continue end
                local tp = target.Character.HumanoidRootPart.Position + Vector3.new(0,2,2)
                TeleportToPos(tp, math.clamp((tp - (GetHRP() and GetHRP().Position or tp)).Magnitude/80, 0.2, 3))
                task.wait(Settings.Combat.TeleportDelay)
                local shots = 0
                while KillAllRunning and IsKillTarget(target) and shots < 200 do
                    if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                        local tp2 = target.Character.HumanoidRootPart.Position + Vector3.new(0,2,2)
                        local hrp = GetHRP()
                        if hrp and (tp2 - hrp.Position).Magnitude > 6 then
                            hrp.CFrame = CFrame.new(tp2)
                        end
                    end
                    DoClick(); shots = shots + 1
                    task.wait(Settings.Combat.KillDelay)
                end
                if not IsKillTarget(target) then
                    ShowNotification(string.format(Lang.Notify_PlayerDead, target.Name), 1.5)
                end
                task.wait(0.2)
            end
            task.wait(0.5)
        end
    end)
end

-- ===================================================== --
-- ESP
-- ===================================================== --
local ESP = {}
function ESP.Create(player)
    if player == LocalPlayer or not DRAWING_SUPPORTED then return end
    if ESPObjects[player] then return end
    local e = {
        Box      = Drawing.new("Square"), Outline = Drawing.new("Square"),
        Name     = Drawing.new("Text"),   HealthBg= Drawing.new("Square"),
        HealthFg = Drawing.new("Square"), Tracer  = Drawing.new("Line"),
    }
    e.Box.Thickness=2; e.Box.Filled=false; e.Box.Visible=false
    e.Outline.Thickness=4; e.Outline.Filled=false; e.Outline.Color=Color3.new(0,0,0); e.Outline.Visible=false
    e.Name.Size=16; e.Name.Center=true; e.Name.Outline=true; e.Name.Visible=false
    e.HealthBg.Filled=true; e.HealthBg.Color=Color3.new(0,0,0); e.HealthBg.Visible=false
    e.HealthFg.Filled=true; e.HealthFg.Visible=false
    e.Tracer.Thickness=2; e.Tracer.Visible=false
    ESPObjects[player] = e
end
function ESP.Remove(player)
    local e = ESPObjects[player]
    if e then for _,o in pairs(e) do pcall(function() o:Remove() end) end; ESPObjects[player]=nil end
end
function ESP.Update()
    if not DRAWING_SUPPORTED then return end
    if Settings.ESP.Rainbow then RainbowHue=(RainbowHue+Settings.ESP.RainbowSpeed)%1 end
    for player, e in pairs(ESPObjects) do
        local function hide() for _,o in pairs(e) do o.Visible=false end end
        if Settings.ESP.TeamCheck and IsSameTeam(player) then hide(); continue end
        if not (player and player.Parent==Players and player.Character) then hide(); continue end
        local ch = player.Character
        local root = ch:FindFirstChild("HumanoidRootPart")
        local head = ch:FindFirstChild("Head")
        if not (root and head) then hide(); continue end
        local v, onS = Camera:WorldToViewportPoint(root.Position)
        local hv     = Camera:WorldToViewportPoint(head.Position)
        if not onS then hide(); continue end
        local dist  = (Camera.CFrame.Position - root.Position).Magnitude
        local scale = math.clamp(300/dist, 0.5, 3)
        local bH = math.abs(hv.Y-v.Y)*2.2*scale; local bW=bH*0.6
        local bX,bY = v.X-bW/2, v.Y-bH/2
        local col = Settings.ESP.Rainbow and Color3.fromHSV(RainbowHue,1,1) or Color3.new(1,1,1)
        if Settings.ESP.Box2D   then e.Box.Visible=true; e.Box.Color=col; e.Box.Position=Vector2.new(bX,bY); e.Box.Size=Vector2.new(bW,bH)
        else e.Box.Visible=false end
        if Settings.ESP.Outline then e.Outline.Visible=true; e.Outline.Position=Vector2.new(bX-1,bY-1); e.Outline.Size=Vector2.new(bW+2,bH+2)
        else e.Outline.Visible=false end
        if Settings.ESP.Name    then e.Name.Visible=true; e.Name.Color=col; e.Name.Position=Vector2.new(v.X,hv.Y-22); e.Name.Text=player.Name
        else e.Name.Visible=false end
        local hum = ch:FindFirstChildOfClass("Humanoid")
        if Settings.ESP.Healthbar and hum then
            local hp=hum.Health/math.max(hum.MaxHealth,1)
            local bw2,bh2=50*scale,5*scale; local bx2,by2=v.X-bw2/2, hv.Y-32
            e.HealthBg.Visible=true; e.HealthBg.Position=Vector2.new(bx2,by2); e.HealthBg.Size=Vector2.new(bw2,bh2)
            e.HealthFg.Visible=true; e.HealthFg.Color=Color3.fromHSV(hp*0.33,1,1)
            e.HealthFg.Position=Vector2.new(bx2,by2); e.HealthFg.Size=Vector2.new(bw2*hp,bh2)
        else e.HealthBg.Visible=false; e.HealthFg.Visible=false end
        if Settings.ESP.Tracer then
            e.Tracer.Visible=true; e.Tracer.Color=col
            local from = Settings.ESP.TracerStart=="Mouse" and UserInputService:GetMouseLocation()
                         or Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
            e.Tracer.From=from; e.Tracer.To=Vector2.new(v.X,v.Y)
        else e.Tracer.Visible=false end
    end
end

-- ===================================================== --
-- Aimbot
-- ===================================================== --
local function GetFovCenter()
    return Settings.Aimbot.FovPosition=="Center"
        and Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        or  UserInputService:GetMouseLocation()
end
local function FindBestTarget()
    local best, bDist = nil, math.huge
    local fc = GetFovCenter()
    for p in pairs(ESPObjects) do
        if not (p and p.Character) then continue end
        if Settings.Aimbot.TeamCheck and IsSameTeam(p) then continue end
        local head = p.Character:FindFirstChild("Head"); if not head then continue end
        local hp, onS = Camera:WorldToViewportPoint(head.Position)
        if not onS then continue end
        local d = (Vector2.new(hp.X,hp.Y)-fc).Magnitude
        if d > Settings.Aimbot.FovSize then continue end
        if Settings.Aimbot.VisibleCheck and not IsVisible(head) then continue end
        if d < bDist then bDist=d; best=p end
    end
    return best
end
local function AimAtTarget(t)
    if not (t and t.Character) then return end
    local head = t.Character:FindFirstChild("Head"); if not head then return end
    local hs, onS = Camera:WorldToViewportPoint(head.Position); if not onS then return end
    local fc = GetFovCenter()
    local delta = Vector2.new(hs.X,hs.Y) - fc
    local s = math.clamp(1 - Settings.Aimbot.Smoothness, 0.05, 1)
    if typeof(mousemoverel) == "function" then
        mousemoverel(delta.X*s, delta.Y*s)
    else
        pcall(function()
            local mp = UserInputService:GetMouseLocation()
            VIM:SendMouseMoveEvent(mp.X+delta.X*s, mp.Y+delta.Y*s, game)
        end)
    end
end
local function TriggerbotCheck()
    if not Settings.Aimbot.Triggerbot then return end
    if tick()-LastTriggerTime < Settings.Aimbot.TriggerbotDelay then return end
    if not AimTarget then return end
    if not (AimTarget.Character and AimTarget.Character:FindFirstChild("Head")) then return end
    local hp, onS = Camera:WorldToViewportPoint(AimTarget.Character.Head.Position)
    if not onS then return end
    if (Vector2.new(hp.X,hp.Y)-GetFovCenter()).Magnitude <= 15 then
        DoClick(); LastTriggerTime=tick()
    end
end

-- ===================================================== --
-- GUI Hilfsfunktionen
-- ===================================================== --
local function MakeCorner(p, r)
    local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,r or 10); c.Parent=p; return c
end
local function MakeStroke(p, col, thickness)
    local s=Instance.new("UIStroke"); s.Color=col or Color3.fromRGB(0,140,255)
    s.Thickness=thickness or 1; s.Parent=p; return s
end
local function MakeFrame(parent, size, pos, color, transp)
    local f=Instance.new("Frame"); f.Size=size; f.Position=pos
    f.BackgroundColor3=color or Color3.fromRGB(25,25,30)
    f.BackgroundTransparency=transp or 0; f.BorderSizePixel=0; f.Parent=parent
    MakeCorner(f, 10); return f
end

local function SectionLabel(parent, text, yOffset)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,-20,0,24); f.Position = UDim2.new(0,10,0,yOffset)
    f.BackgroundColor3 = Color3.fromRGB(28,28,36); f.BorderSizePixel=0; f.Parent=parent
    MakeCorner(f, 5)
    local l=Instance.new("TextLabel"); l.Size=UDim2.new(1,0,1,0)
    l.BackgroundTransparency=1; l.Text=text
    l.TextColor3=Color3.fromRGB(0,170,255); l.TextSize=13; l.Font=Enum.Font.GothamBold; l.Parent=f
    return f
end

local function CreateToggle(parent, labelText, settingPath, yOffset)
    local frame=Instance.new("Frame"); frame.Size=UDim2.new(1,-20,0,36)
    frame.Position=UDim2.new(0,10,0,yOffset); frame.BackgroundColor3=Color3.fromRGB(30,30,38)
    frame.BorderSizePixel=0; frame.Parent=parent; MakeCorner(frame,8)
    local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,-70,1,0)
    lbl.Position=UDim2.new(0,12,0,0); lbl.BackgroundTransparency=1; lbl.Text=labelText
    lbl.TextColor3=Color3.fromRGB(215,215,220); lbl.TextSize=14; lbl.Font=Enum.Font.Gotham
    lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Parent=frame
    local bg=Instance.new("Frame"); bg.Size=UDim2.new(0,44,0,22); bg.Position=UDim2.new(1,-54,0.5,-11)
    bg.BorderSizePixel=0; bg.Parent=frame; MakeCorner(bg,11)
    local circle=Instance.new("Frame"); circle.Size=UDim2.new(0,18,0,18)
    circle.Position=UDim2.new(0,2,0.5,-9); circle.BackgroundColor3=Color3.new(1,1,1)
    circle.BorderSizePixel=0; circle.Parent=bg; MakeCorner(circle,9)
    local keys={}; for p in string.gmatch(settingPath,"[^.]+") do table.insert(keys,p) end
    local function getVal() local c=Settings; for i=1,#keys do c=c[keys[i]] end; return c end
    local function refresh()
        local on=getVal()
        TweenService:Create(bg,TweenInfo.new(0.15),{BackgroundColor3=on and Color3.fromRGB(0,150,255) or Color3.fromRGB(50,50,58)}):Play()
        TweenService:Create(circle,TweenInfo.new(0.15),{Position=on and UDim2.new(1,-20,0.5,-9) or UDim2.new(0,2,0.5,-9)}):Play()
    end
    refresh()
    local btn=Instance.new("TextButton"); btn.Size=UDim2.new(1,0,1,0); btn.BackgroundTransparency=1
    btn.Text=""; btn.Parent=frame
    btn.MouseButton1Click:Connect(function()
        local c=Settings; for i=1,#keys-1 do c=c[keys[i]] end
        local lk=keys[#keys]; c[lk]=not c[lk]; refresh()
        -- Seiteneffekte
        if settingPath=="Movement.Speed" then
            if c[lk] then StartSpeed() else StopSpeed() end
        elseif settingPath=="Movement.Jump" then
            if c[lk] then SetupJumpHack() else StopJumpHack() end
        elseif settingPath=="Movement.Fly" then
            if c[lk] then StartFly() else StopFly() end
        elseif settingPath=="Movement.AntiAfk" then
            if c[lk] then StartAntiAfk() else StopAntiAfk() end
        end
        ShowNotification(lbl.Text.." "..(c[lk] and Lang.Notify_Enabled or Lang.Notify_Disabled), 1.5)
    end)
    return frame
end

local function CreateSlider(parent, labelText, settingPath, minV, maxV, isFloat, yOffset)
    local frame=Instance.new("Frame"); frame.Size=UDim2.new(1,-20,0,52)
    frame.Position=UDim2.new(0,10,0,yOffset); frame.BackgroundColor3=Color3.fromRGB(30,30,38)
    frame.BorderSizePixel=0; frame.Parent=parent; MakeCorner(frame,8)
    local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(0.6,0,0,22); lbl.Position=UDim2.new(0,12,0,4)
    lbl.BackgroundTransparency=1; lbl.Text=labelText; lbl.TextColor3=Color3.fromRGB(215,215,220)
    lbl.TextSize=14; lbl.Font=Enum.Font.Gotham; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Parent=frame
    local valLbl=Instance.new("TextLabel"); valLbl.Size=UDim2.new(0.35,0,0,22); valLbl.Position=UDim2.new(0.62,0,0,4)
    valLbl.BackgroundTransparency=1; valLbl.TextColor3=Color3.fromRGB(0,170,255); valLbl.TextSize=14
    valLbl.Font=Enum.Font.GothamBold; valLbl.TextXAlignment=Enum.TextXAlignment.Right; valLbl.Parent=frame
    local track=Instance.new("Frame"); track.Size=UDim2.new(1,-24,0,5); track.Position=UDim2.new(0,12,0,37)
    track.BackgroundColor3=Color3.fromRGB(50,50,60); track.BorderSizePixel=0; track.Parent=frame; MakeCorner(track,3)
    local fill=Instance.new("Frame"); fill.Size=UDim2.new(0,0,1,0); fill.BackgroundColor3=Color3.fromRGB(0,150,255)
    fill.BorderSizePixel=0; fill.Parent=track; MakeCorner(fill,3)
    local knob=Instance.new("TextButton"); knob.Size=UDim2.new(0,16,0,16); knob.Position=UDim2.new(0,-8,0.5,-8)
    knob.BackgroundColor3=Color3.new(1,1,1); knob.Text=""; knob.BorderSizePixel=0; knob.Parent=track; MakeCorner(knob,8)
    local keys={}; for p in string.gmatch(settingPath,"[^.]+") do table.insert(keys,p) end
    local function getVal() local c=Settings; for i=1,#keys do c=c[keys[i]] end; return c end
    local function setVal(v)
        v=math.clamp(v,minV,maxV); local c=Settings; for i=1,#keys-1 do c=c[keys[i]] end; c[keys[#keys]]=v
        local pct=(v-minV)/(maxV-minV); fill.Size=UDim2.new(pct,0,1,0); knob.Position=UDim2.new(pct,-8,0.5,-8)
        valLbl.Text=isFloat and string.format("%.2f",v) or tostring(math.floor(v))
    end
    setVal(getVal())
    local dragging=false
    knob.MouseButton1Down:Connect(function() dragging=true end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then
            local mx=UserInputService:GetMouseLocation().X; local ax=track.AbsolutePosition.X
            setVal(minV+math.clamp((mx-ax)/track.AbsoluteSize.X,0,1)*(maxV-minV))
        end
    end)
    return frame
end

local function CreateDropdown(parent, labelText, settingPath, options, yOffset)
    local frame=Instance.new("Frame"); frame.Size=UDim2.new(1,-20,0,36)
    frame.Position=UDim2.new(0,10,0,yOffset); frame.BackgroundColor3=Color3.fromRGB(30,30,38)
    frame.BorderSizePixel=0; frame.Parent=parent; MakeCorner(frame,8)
    local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(0.55,0,1,0); lbl.Position=UDim2.new(0,12,0,0)
    lbl.BackgroundTransparency=1; lbl.Text=labelText; lbl.TextColor3=Color3.fromRGB(215,215,220)
    lbl.TextSize=14; lbl.Font=Enum.Font.Gotham; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Parent=frame
    local btn=Instance.new("TextButton"); btn.Size=UDim2.new(0,110,0,26); btn.Position=UDim2.new(1,-118,0.5,-13)
    btn.BackgroundColor3=Color3.fromRGB(45,45,55); btn.TextColor3=Color3.fromRGB(0,170,255)
    btn.Font=Enum.Font.GothamSemibold; btn.TextSize=13; btn.BorderSizePixel=0; btn.Parent=frame; MakeCorner(btn,6)
    local keys={}; for p in string.gmatch(settingPath,"[^.]+") do table.insert(keys,p) end
    local function getCur() local c=Settings; for i=1,#keys do c=c[keys[i]] end; return c end
    btn.Text=getCur()
    btn.MouseButton1Click:Connect(function()
        local c=Settings; for i=1,#keys-1 do c=c[keys[i]] end; local lk=keys[#keys]
        local idx=1; for i,v in ipairs(options) do if v==c[lk] then idx=i; break end end
        idx=idx%#options+1; c[lk]=options[idx]; btn.Text=c[lk]
        ShowNotification(lbl.Text..": "..c[lk], 1.5)
        if settingPath=="Language" then SetLanguage(c[lk]) end
    end)
    return frame
end

local function CreateActionButton(parent, text, color, yOffset, callback)
    local btn=Instance.new("TextButton"); btn.Size=UDim2.new(1,-20,0,38)
    btn.Position=UDim2.new(0,10,0,yOffset); btn.BackgroundColor3=color
    btn.Text=text; btn.TextColor3=Color3.new(1,1,1); btn.Font=Enum.Font.GothamBold
    btn.TextSize=15; btn.BorderSizePixel=0; btn.Parent=parent; MakeCorner(btn,8)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- ===================================================== --
-- Hauptmenü
-- ===================================================== --
CreateMenu = function()
    local gui = Instance.new("ScreenGui"); gui.Name = "ModernMenuV3"
    gui.ResetOnSpawn=false; gui.Parent=CoreGui; gui.IgnoreGuiInset=true; gui.DisplayOrder=50

    local W, H = 580, 510
    local main = MakeFrame(gui, UDim2.new(0,W,0,H), UDim2.new(0.5,-W/2,0.5,-H/2), Color3.fromRGB(18,18,24))
    main.ClipsDescendants=false; main.Active=true
    MakeStroke(main, Color3.fromRGB(0,120,220), 1.5)

    -- Glow shadow
    local glow = Instance.new("ImageLabel"); glow.Size=UDim2.new(1,60,1,60)
    glow.Position=UDim2.new(0,-30,0,-30); glow.BackgroundTransparency=1
    glow.Image="rbxassetid://5554236805"; glow.ImageColor3=Color3.fromRGB(0,100,255)
    glow.ImageTransparency=0.75; glow.ScaleType=Enum.ScaleType.Slice
    glow.SliceCenter=Rect.new(23,23,277,277); glow.ZIndex=-1; glow.Parent=main

    -- Titlebar
    local tbar = Instance.new("Frame"); tbar.Size=UDim2.new(1,0,0,44)
    tbar.BackgroundColor3=Color3.fromRGB(24,24,30); tbar.BorderSizePixel=0; tbar.Active=true; tbar.Parent=main
    MakeCorner(tbar,10)
    local tmask=Instance.new("Frame"); tmask.Size=UDim2.new(1,0,0.5,0); tmask.Position=UDim2.new(0,0,0.5,0)
    tmask.BackgroundColor3=Color3.fromRGB(24,24,30); tmask.BorderSizePixel=0; tmask.Parent=tbar

    local tlbl=Instance.new("TextLabel"); tlbl.Size=UDim2.new(1,-50,1,0); tlbl.Position=UDim2.new(0,14,0,0)
    tlbl.BackgroundTransparency=1; tlbl.Text="⚡ "..Lang.MenuTitle
    tlbl.TextColor3=Color3.fromRGB(0,170,255); tlbl.TextSize=18; tlbl.Font=Enum.Font.GothamBold
    tlbl.TextXAlignment=Enum.TextXAlignment.Left; tlbl.Parent=tbar

    local xbtn=Instance.new("TextButton"); xbtn.Size=UDim2.new(0,28,0,28); xbtn.Position=UDim2.new(1,-34,0.5,-14)
    xbtn.BackgroundColor3=Color3.fromRGB(190,40,40); xbtn.Text="✕"; xbtn.TextColor3=Color3.new(1,1,1)
    xbtn.TextSize=15; xbtn.Font=Enum.Font.GothamBold; xbtn.BorderSizePixel=0; xbtn.Parent=tbar; MakeCorner(xbtn,6)
    xbtn.MouseButton1Click:Connect(function() IsMenuOpen=false; main.Visible=false end)

    -- Drag
    tbar.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then
            Dragging=true; local m=UserInputService:GetMouseLocation()
            DragOffset=Vector2.new(m.X-main.AbsolutePosition.X, m.Y-main.AbsolutePosition.Y)
        end
    end)
    tbar.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then Dragging=false end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if Dragging and i.UserInputType==Enum.UserInputType.MouseMovement then
            local m=UserInputService:GetMouseLocation()
            main.Position=UDim2.new(0,m.X-DragOffset.X,0,m.Y-DragOffset.Y)
        end
    end)

    -- Tab Bar
    local tabbar=Instance.new("Frame"); tabbar.Size=UDim2.new(1,0,0,36); tabbar.Position=UDim2.new(0,0,0,44)
    tabbar.BackgroundColor3=Color3.fromRGB(22,22,28); tabbar.BorderSizePixel=0; tabbar.Parent=main
    local tabline=Instance.new("Frame"); tabline.Size=UDim2.new(1,0,0,2); tabline.Position=UDim2.new(0,0,1,-2)
    tabline.BackgroundColor3=Color3.fromRGB(0,130,255); tabline.BorderSizePixel=0; tabline.Parent=tabbar

    -- Scroll container
    local scroll=Instance.new("ScrollingFrame"); scroll.Size=UDim2.new(1,0,1,-90)
    scroll.Position=UDim2.new(0,0,0,80); scroll.BackgroundTransparency=1
    scroll.ScrollBarThickness=4; scroll.ScrollBarImageColor3=Color3.fromRGB(0,130,255)
    scroll.CanvasSize=UDim2.new(0,0,0,0); scroll.BorderSizePixel=0; scroll.Parent=main

    -- Status bar
    local sbar=Instance.new("Frame"); sbar.Size=UDim2.new(1,0,0,24); sbar.Position=UDim2.new(0,0,1,-24)
    sbar.BackgroundColor3=Color3.fromRGB(14,14,18); sbar.BorderSizePixel=0; sbar.Parent=main
    local slbl=Instance.new("TextLabel"); slbl.Size=UDim2.new(1,-10,1,0); slbl.Position=UDim2.new(0,10,0,0)
    slbl.BackgroundTransparency=1; slbl.Text="v3 | Speed/Jump/Fly/AntiAFK"
    slbl.TextColor3=Color3.fromRGB(70,70,80); slbl.TextSize=11; slbl.Font=Enum.Font.Gotham
    slbl.TextXAlignment=Enum.TextXAlignment.Left; slbl.Parent=sbar

    -- ═══════════════════════════════════════════
    -- TAB INHALTE
    -- ═══════════════════════════════════════════

    -- ────────── ESP Tab ──────────
    local tabESP=Instance.new("Frame"); tabESP.Size=UDim2.new(1,0,0,0)
    tabESP.BackgroundTransparency=1; tabESP.Parent=scroll; tabESP.Visible=true
    local eY=10
    local function eA(h) eY=eY+h+5 end
    CreateToggle(tabESP,Lang.ESP_Box2D,   "ESP.Box2D",   eY); eA(36)
    CreateToggle(tabESP,Lang.ESP_Outline, "ESP.Outline",  eY); eA(36)
    CreateToggle(tabESP,Lang.ESP_Name,    "ESP.Name",     eY); eA(36)
    CreateToggle(tabESP,Lang.ESP_Healthbar,"ESP.Healthbar",eY); eA(36)
    CreateToggle(tabESP,Lang.ESP_Tracer,  "ESP.Tracer",   eY); eA(36)
    CreateToggle(tabESP,Lang.ESP_Rainbow, "ESP.Rainbow",  eY); eA(36)
    CreateToggle(tabESP,Lang.ESP_TeamCheck,"ESP.TeamCheck",eY); eA(36)
    CreateDropdown(tabESP,Lang.ESP_TracerStart,"ESP.TracerStart",{"Bottom","Mouse"},eY); eA(36)
    CreateSlider(tabESP,Lang.ESP_RainbowSpeed,"ESP.RainbowSpeed",0.001,0.05,true,eY); eA(52)
    tabESP.Size=UDim2.new(1,0,0,eY+10)

    -- ────────── Aimbot Tab ──────────
    local tabAim=Instance.new("Frame"); tabAim.Size=UDim2.new(1,0,0,0)
    tabAim.BackgroundTransparency=1; tabAim.Parent=scroll; tabAim.Visible=false
    local aY=10
    local function aA(h) aY=aY+h+5 end
    CreateToggle(tabAim,Lang.Aimbot_Enabled,    "Aimbot.Enabled",    aY); aA(36)
    CreateToggle(tabAim,Lang.Aimbot_TeamCheck,  "Aimbot.TeamCheck",  aY); aA(36)
    CreateToggle(tabAim,Lang.Aimbot_VisibleCheck,"Aimbot.VisibleCheck",aY); aA(36)
    CreateToggle(tabAim,Lang.Aimbot_UseFovCircle,"Aimbot.UseFovCircle",aY); aA(36)
    CreateToggle(tabAim,Lang.Aimbot_ShowFovCircle,"Aimbot.ShowFovCircle",aY); aA(36)
    CreateDropdown(tabAim,Lang.Aimbot_FovPosition,"Aimbot.FovPosition",{"Center","Mouse"},aY); aA(36)
    CreateSlider(tabAim,Lang.Aimbot_FovSize,    "Aimbot.FovSize",    30,500,false,aY); aA(52)
    CreateSlider(tabAim,Lang.Aimbot_Smoothness, "Aimbot.Smoothness", 0,0.95,true,aY); aA(52)
    CreateToggle(tabAim,Lang.Aimbot_Triggerbot,  "Aimbot.Triggerbot", aY); aA(36)
    CreateSlider(tabAim,Lang.Aimbot_TriggerbotDelay,"Aimbot.TriggerbotDelay",0.02,0.5,true,aY); aA(52)
    tabAim.Size=UDim2.new(1,0,0,aY+10)

    -- ────────── Movement Tab (NEU) ──────────
    local tabMov=Instance.new("Frame"); tabMov.Size=UDim2.new(1,0,0,0)
    tabMov.BackgroundTransparency=1; tabMov.Parent=scroll; tabMov.Visible=false
    local mY=10
    local function mA(h) mY=mY+h+5 end

    -- SPEED
    SectionLabel(tabMov,"⚡ SPEEDHACK",mY); mA(24)
    CreateToggle(tabMov,Lang.Move_Speed, "Movement.Speed",  mY); mA(36)
    CreateSlider(tabMov,Lang.Move_SpeedVal,"Movement.SpeedMult",1,10,true,mY); mA(52)
    -- Info-Label für Speed
    local sInfo=Instance.new("TextLabel"); sInfo.Size=UDim2.new(1,-20,0,28); sInfo.Position=UDim2.new(0,10,0,mY)
    sInfo.BackgroundColor3=Color3.fromRGB(24,30,24); sInfo.BorderSizePixel=0
    sInfo.Text="  WalkSpeed = 16 × Multiplier  |  Jitter-Stealth aktiv"; sInfo.TextColor3=Color3.fromRGB(80,200,80)
    sInfo.TextSize=11; sInfo.Font=Enum.Font.Gotham; sInfo.TextXAlignment=Enum.TextXAlignment.Left
    sInfo.Parent=tabMov; MakeCorner(sInfo,5); mA(28)

    -- JUMP
    SectionLabel(tabMov,"🦘 JUMPHACK",mY); mA(24)
    CreateToggle(tabMov,Lang.Move_Jump, "Movement.Jump",   mY); mA(36)
    CreateSlider(tabMov,Lang.Move_JumpVal,"Movement.JumpPower",50,500,false,mY); mA(52)
    local jInfo=Instance.new("TextLabel"); jInfo.Size=UDim2.new(1,-20,0,28); jInfo.Position=UDim2.new(0,10,0,mY)
    jInfo.BackgroundColor3=Color3.fromRGB(24,30,24); jInfo.BorderSizePixel=0
    jInfo.Text="  JumpPower nur für 80ms erhöht  |  Server sieht Standard-Wert"
    jInfo.TextColor3=Color3.fromRGB(80,200,80); jInfo.TextSize=11; jInfo.Font=Enum.Font.Gotham
    jInfo.TextXAlignment=Enum.TextXAlignment.Left; jInfo.Parent=tabMov; MakeCorner(jInfo,5); mA(28)

    -- FLY
    SectionLabel(tabMov,"🛸 FLY",mY); mA(24)
    CreateToggle(tabMov,Lang.Move_Fly,  "Movement.Fly",    mY); mA(36)
    CreateSlider(tabMov,Lang.Move_FlySpeed,"Movement.FlySpeed",5,200,false,mY); mA(52)
    CreateDropdown(tabMov,Lang.Move_FlyUp,  "Movement.FlyUp",  {"E","Q","R","F","Space","X","Z"},mY); mA(36)
    CreateDropdown(tabMov,Lang.Move_FlyDown,"Movement.FlyDown",{"Q","E","R","F","Space","X","Z"},mY); mA(36)
    local fInfo=Instance.new("TextLabel"); fInfo.Size=UDim2.new(1,-20,0,28); fInfo.Position=UDim2.new(0,10,0,mY)
    fInfo.BackgroundColor3=Color3.fromRGB(24,30,24); fInfo.BorderSizePixel=0
    fInfo.Text="  BodyPos+BodyGyro  |  PlatformStand-Cycle  |  WASD+Hoch/Runter"
    fInfo.TextColor3=Color3.fromRGB(80,200,80); fInfo.TextSize=11; fInfo.Font=Enum.Font.Gotham
    fInfo.TextXAlignment=Enum.TextXAlignment.Left; fInfo.Parent=tabMov; MakeCorner(fInfo,5); mA(28)

    -- ANTI-AFK
    SectionLabel(tabMov,"💤 ANTI-AFK",mY); mA(24)
    CreateToggle(tabMov,Lang.Move_AntiAfk,"Movement.AntiAfk",mY); mA(36)
    local aInfo=Instance.new("TextLabel"); aInfo.Size=UDim2.new(1,-20,0,28); aInfo.Position=UDim2.new(0,10,0,mY)
    aInfo.BackgroundColor3=Color3.fromRGB(24,30,24); aInfo.BorderSizePixel=0
    aInfo.Text="  VIM-Input alle ~60s  |  Verhindert Auto-Kick"
    aInfo.TextColor3=Color3.fromRGB(80,200,80); aInfo.TextSize=11; aInfo.Font=Enum.Font.Gotham
    aInfo.TextXAlignment=Enum.TextXAlignment.Left; aInfo.Parent=tabMov; MakeCorner(aInfo,5); mA(28)

    tabMov.Size=UDim2.new(1,0,0,mY+10)

    -- ────────── Combat Tab ──────────
    local tabCom=Instance.new("Frame"); tabCom.Size=UDim2.new(1,0,0,0)
    tabCom.BackgroundTransparency=1; tabCom.Parent=scroll; tabCom.Visible=false
    local cY=10
    local function cA(h) cY=cY+h+5 end

    SectionLabel(tabCom,"🌀 SPINBOT",cY); cA(24)
    CreateToggle(tabCom,Lang.Combat_Spinbot,  "Combat.Spinbot",  cY); cA(36)
    CreateSlider(tabCom,Lang.Combat_SpinSpeed,"Combat.SpinSpeed",1,50,false,cY); cA(52)

    SectionLabel(tabCom,"💀 KILL ALL",cY); cA(24)
    CreateDropdown(tabCom,Lang.Combat_KillTeam,"Combat.KillTeam",{"Enemies","OwnTeam","AllTeams"},cY); cA(36)
    CreateSlider(tabCom,Lang.Combat_KillDelay,    "Combat.KillDelay",    0.01,0.5,true,cY); cA(52)
    CreateSlider(tabCom,Lang.Combat_TeleportDelay,"Combat.TeleportDelay",0.1,2,true,cY); cA(52)

    local killBtn=CreateActionButton(tabCom,"💀 "..Lang.Combat_KillAll,Color3.fromRGB(185,35,35),cY,function()
        if KillAllRunning then StopKillAll() else StartKillAll() end
    end); cA(38)
    task.spawn(function()
        while MenuGUI do
            if not killBtn or not killBtn.Parent then break end
            killBtn.Text = KillAllRunning and ("⏹ "..Lang.Combat_KillAllRunning) or ("💀 "..Lang.Combat_KillAll)
            killBtn.BackgroundColor3 = KillAllRunning and Color3.fromRGB(130,20,20) or Color3.fromRGB(185,35,35)
            task.wait(0.25)
        end
    end)
    tabCom.Size=UDim2.new(1,0,0,cY+10)

    -- ────────── Others Tab ──────────
    local tabOth=Instance.new("Frame"); tabOth.Size=UDim2.new(1,0,0,0)
    tabOth.BackgroundTransparency=1; tabOth.Parent=scroll; tabOth.Visible=false
    local oY=10
    local function oA(h) oY=oY+h+5 end

    CreateToggle(tabOth,Lang.FPSDisplay,  "ShowFPS",      oY); oA(36)
    CreateToggle(tabOth,Lang.Notifications,"Notifications",oY); oA(36)
    CreateDropdown(tabOth,Lang.Language,  "Language",{"English","Deutsch"},oY); oA(36)

    -- Menu Key Box
    local kf=Instance.new("Frame"); kf.Size=UDim2.new(1,-20,0,36); kf.Position=UDim2.new(0,10,0,oY)
    kf.BackgroundColor3=Color3.fromRGB(30,30,38); kf.BorderSizePixel=0; kf.Parent=tabOth; MakeCorner(kf,8)
    local kl=Instance.new("TextLabel"); kl.Size=UDim2.new(0.55,0,1,0); kl.Position=UDim2.new(0,12,0,0)
    kl.BackgroundTransparency=1; kl.Text=Lang.MenuKey; kl.TextColor3=Color3.fromRGB(215,215,220)
    kl.TextSize=14; kl.Font=Enum.Font.Gotham; kl.TextXAlignment=Enum.TextXAlignment.Left; kl.Parent=kf
    local kb=Instance.new("TextBox"); kb.Size=UDim2.new(0,110,0,26); kb.Position=UDim2.new(1,-118,0.5,-13)
    kb.BackgroundColor3=Color3.fromRGB(45,45,55); kb.TextColor3=Color3.fromRGB(0,170,255)
    kb.Font=Enum.Font.GothamSemibold; kb.TextSize=13; kb.PlaceholderText="LeftAlt"; kb.Text="LeftAlt"
    kb.BorderSizePixel=0; kb.Parent=kf; MakeCorner(kb,6)
    kb.FocusLost:Connect(function(enter)
        if enter then
            local ok,key=pcall(function() return Enum.KeyCode[kb.Text] end)
            if ok and key then Settings.MenuKey=key; ShowNotification(string.format(Lang.Notify_KeyChanged,kb.Text),2)
            else ShowNotification(Lang.Notify_InvalidKey,2); kb.Text="LeftAlt" end
        end
    end)
    oA(36)

    -- Teleport Button
    CreateActionButton(tabOth,"🚀 "..Lang.Others_Teleport,Color3.fromRGB(0,100,185),oY,function()
        local popup=MakeFrame(main,UDim2.new(0,270,0,330),UDim2.new(0.5,-135,0.5,-165),Color3.fromRGB(18,18,26))
        popup.ZIndex=10; MakeStroke(popup,Color3.fromRGB(0,130,255),1.5)
        local pc=Instance.new("TextButton"); pc.Size=UDim2.new(0,26,0,26); pc.Position=UDim2.new(1,-30,0,4)
        pc.BackgroundColor3=Color3.fromRGB(180,40,40); pc.Text="✕"; pc.TextColor3=Color3.new(1,1,1)
        pc.TextSize=13; pc.Font=Enum.Font.GothamBold; pc.BorderSizePixel=0; pc.ZIndex=11; pc.Parent=popup; MakeCorner(pc,5)
        pc.MouseButton1Click:Connect(function() popup:Destroy() end)
        local pt=Instance.new("TextLabel"); pt.Size=UDim2.new(1,-36,0,34); pt.Position=UDim2.new(0,10,0,0)
        pt.BackgroundTransparency=1; pt.Text="🚀 "..Lang.Others_Teleport
        pt.TextColor3=Color3.fromRGB(0,160,255); pt.TextSize=14; pt.Font=Enum.Font.GothamBold
        pt.TextXAlignment=Enum.TextXAlignment.Left; pt.ZIndex=11; pt.Parent=popup
        local pl=Instance.new("ScrollingFrame"); pl.Size=UDim2.new(1,-10,1,-44); pl.Position=UDim2.new(0,5,0,40)
        pl.BackgroundTransparency=1; pl.ScrollBarThickness=4; pl.ZIndex=11; pl.Parent=popup
        local py2=0
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LocalPlayer then
                local tc=GetTeamColor(p); local tn=GetTeamName(p)
                local pb=Instance.new("TextButton"); pb.Size=UDim2.new(1,-8,0,38); pb.Position=UDim2.new(0,4,0,py2)
                pb.BackgroundColor3=tc:Lerp(Color3.fromRGB(22,22,30),0.55)
                pb.Text="  "..p.Name.."\n  "..tn; pb.TextColor3=Color3.new(1,1,1)
                pb.Font=Enum.Font.Gotham; pb.TextSize=13; pb.TextXAlignment=Enum.TextXAlignment.Left
                pb.BorderSizePixel=0; pb.ZIndex=12; pb.Parent=pl; MakeCorner(pb,6)
                pb.MouseButton1Click:Connect(function() SafeTeleportToPlayer(p,false); popup:Destroy() end)
                py2=py2+44
            end
        end
        pl.CanvasSize=UDim2.new(0,0,0,py2)
        if py2==0 then
            local el=Instance.new("TextLabel"); el.Size=UDim2.new(1,0,0,40); el.BackgroundTransparency=1
            el.Text=Lang.Others_NoPlayers; el.TextColor3=Color3.fromRGB(130,130,140)
            el.Font=Enum.Font.Gotham; el.TextSize=13; el.ZIndex=12; el.Parent=pl
        end
    end); oA(38)

    -- Rejoin / Serverhop
    local rb=Instance.new("TextButton"); rb.Size=UDim2.new(0.5,-14,0,36); rb.Position=UDim2.new(0,10,0,oY)
    rb.BackgroundColor3=Color3.fromRGB(180,100,0); rb.Text="🔄 "..Lang.Others_Rejoin
    rb.TextColor3=Color3.new(1,1,1); rb.Font=Enum.Font.GothamBold; rb.TextSize=13
    rb.BorderSizePixel=0; rb.Parent=tabOth; MakeCorner(rb,8)
    rb.MouseButton1Click:Connect(function() ShowNotification(Lang.Notify_Rejoining,2); TeleportService:Teleport(game.PlaceId,LocalPlayer) end)

    local sb=Instance.new("TextButton"); sb.Size=UDim2.new(0.5,-14,0,36); sb.Position=UDim2.new(0.5,4,0,oY)
    sb.BackgroundColor3=Color3.fromRGB(180,100,0); sb.Text="🌐 "..Lang.Others_Serverhop
    sb.TextColor3=Color3.new(1,1,1); sb.Font=Enum.Font.GothamBold; sb.TextSize=13
    sb.BorderSizePixel=0; sb.Parent=tabOth; MakeCorner(sb,8)
    sb.MouseButton1Click:Connect(function() ShowNotification(Lang.Notify_Serverhop,2); TeleportService:Teleport(game.PlaceId,LocalPlayer) end)
    oA(36)

    tabOth.Size=UDim2.new(1,0,0,oY+10)

    -- ═══ updateCanvasSize ═══
    updateCanvasSize = function()
        local map={ESP=tabESP,AIMBOT=tabAim,MOVEMENT=tabMov,COMBAT=tabCom,OTHERS=tabOth}
        local t = map[CurrentTab] or tabESP
        scroll.CanvasSize = UDim2.new(0,0,0, t.Size.Y.Offset+20)
    end

    -- ═══ Tab Buttons ═══
    local tabDefs = {
        {name=Lang.TabESP,      key="ESP",      frame=tabESP},
        {name=Lang.TabAimbot,   key="AIMBOT",   frame=tabAim},
        {name=Lang.TabMovement, key="MOVEMENT", frame=tabMov},
        {name=Lang.TabCombat,   key="COMBAT",   frame=tabCom},
        {name=Lang.TabOthers,   key="OTHERS",   frame=tabOth},
    }
    local tbW = math.floor((W-10) / #tabDefs)
    for i, def in ipairs(tabDefs) do
        local tb=Instance.new("TextButton"); tb.Size=UDim2.new(0,tbW-2,1,-4)
        tb.Position=UDim2.new(0,(i-1)*tbW+4,0,2)
        tb.BackgroundColor3=(CurrentTab==def.key) and Color3.fromRGB(0,140,255) or Color3.fromRGB(28,28,36)
        tb.Text=def.name; tb.TextColor3=Color3.new(1,1,1); tb.TextSize=13; tb.Font=Enum.Font.GothamBold
        tb.BorderSizePixel=0; tb.Parent=tabbar; MakeCorner(tb,6)
        tb.MouseButton1Click:Connect(function()
            CurrentTab=def.key
            for _,c in ipairs(tabbar:GetChildren()) do
                if c:IsA("TextButton") then c.BackgroundColor3=Color3.fromRGB(28,28,36) end
            end
            tb.BackgroundColor3=Color3.fromRGB(0,140,255)
            for _,d in ipairs(tabDefs) do d.frame.Visible=(d.key==CurrentTab) end
            scroll.CanvasPosition=Vector2.new(0,0)
            updateCanvasSize()
        end)
    end

    task.wait(0.1); updateCanvasSize()
    main.Visible = false
    MenuGUI = gui
end

-- ===================================================== --
-- Events
-- ===================================================== --
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode==Settings.MenuKey and MenuGUI then
        IsMenuOpen=not IsMenuOpen
        local mf=MenuGUI:FindFirstChildOfClass("Frame")
        if mf then
            mf.Visible=IsMenuOpen
            if IsMenuOpen then
                mf.BackgroundTransparency=1
                TweenService:Create(mf,TweenInfo.new(0.18),{BackgroundTransparency=0}):Play()
            end
        end
    end
end)

Players.PlayerAdded:Connect(ESP.Create)
Players.PlayerRemoving:Connect(ESP.Remove)
for _,p in ipairs(Players:GetPlayers()) do ESP.Create(p) end

if DRAWING_SUPPORTED then
    FovCircle=Drawing.new("Circle"); FovCircle.Thickness=2; FovCircle.NumSides=64
    FovCircle.Color=Color3.fromRGB(255,50,50); FovCircle.Filled=false; FovCircle.Visible=false
end
InitFPSDisplay()

-- ===================================================== --
-- Haupt-Loop
-- ===================================================== --
RunService.RenderStepped:Connect(function(dt)
    -- FPS
    FrameCount=FrameCount+1; local now=tick()
    if now-LastFrameTime>=1 then CurrentFPS=FrameCount; FrameCount=0; LastFrameTime=now end
    if FPSLabel then
        FPSLabel.Visible=Settings.ShowFPS
        if Settings.ShowFPS then FPSLabel.Text="FPS: "..tostring(CurrentFPS) end
    end

    -- ESP
    ESP.Update()

    -- FOV Circle
    if DRAWING_SUPPORTED and FovCircle then
        if Settings.Aimbot.ShowFovCircle and Settings.Aimbot.UseFovCircle then
            FovCircle.Visible=true; FovCircle.Radius=Settings.Aimbot.FovSize
            FovCircle.Position=Settings.Aimbot.FovPosition=="Center"
                and Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)
                or UserInputService:GetMouseLocation()
        else FovCircle.Visible=false end
    end

    -- Aimbot
    if Settings.Aimbot.Enabled then
        AimTarget=FindBestTarget()
        if AimTarget then AimAtTarget(AimTarget) end
    else AimTarget=nil end

    -- Triggerbot
    if Settings.Aimbot.Triggerbot then TriggerbotCheck() end

    -- Spinbot
    UpdateSpinbot(dt)
end)

-- ===================================================== --
-- Start
-- ===================================================== --
SetLanguage(Settings.Language)
ShowNotification(Lang.Notify_Loaded, 4)
