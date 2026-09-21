--========================================================--
-- WcodeCheats
-- Roblox Studio LocalScript
-- StarterPlayer > StarterPlayerScripts
-- KEY: LARP
--========================================================--

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local CORRECT_KEY = "LARP"

--========================================================--
-- STATE
--========================================================--

local State = {
    Authorized = false,
    MenuOpen = false,

    Fly = false,
    Noclip = false,
    AirJump = false,

    Speed = 16,
    JumpPower = 50,
    FlySpeed = 70,

    ESP = false,
    Chams = false,
}

local Character
local Humanoid
local RootPart

local function UpdateCharacter()
    Character = LocalPlayer.Character

    if not Character then
        return
    end

    Humanoid = Character:FindFirstChildOfClass("Humanoid")
    RootPart = Character:FindFirstChild("HumanoidRootPart")
end

UpdateCharacter()

LocalPlayer.CharacterAdded:Connect(function(character)
    Character = character

    Humanoid = character:WaitForChild("Humanoid", 10)
    RootPart = character:WaitForChild("HumanoidRootPart", 10)

    if Humanoid then
        Humanoid.UseJumpPower = true
    end
end)

--========================================================--
-- COLORS
--========================================================--

local GREEN = Color3.fromRGB(0, 255, 100)
local DARK = Color3.fromRGB(7, 9, 8)
local DARK2 = Color3.fromRGB(13, 17, 14)
local WHITE = Color3.fromRGB(230, 235, 231)
local GRAY = Color3.fromRGB(110, 120, 113)
local RED = Color3.fromRGB(255, 70, 70)

--========================================================--
-- HELPERS
--========================================================--

local function AddCorner(object, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = object
end

local function AddStroke(object, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness or 1
    stroke.Parent = object
end

local function Create(className, properties, parent)
    local object = Instance.new(className)

    for property, value in pairs(properties or {}) do
        object[property] = value
    end

    object.Parent = parent

    return object
end

--========================================================--
-- ROOT GUI
--========================================================--

local ScreenGui = Create("ScreenGui", {
    Name = "WcodeCheats",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 999999,
}, PlayerGui)

--========================================================--
-- KEY WINDOW
--========================================================--

local KeyWindow = Create("Frame", {
    Name = "KeyWindow",
    Size = UDim2.fromOffset(300, 160),
    Position = UDim2.fromScale(0.5, 0.5),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = DARK,
}, ScreenGui)

AddCorner(KeyWindow, 9)
AddStroke(KeyWindow, GREEN, 1)

Create("TextLabel", {
    Name = "Title",
    Size = UDim2.new(1, 0, 0, 40),
    BackgroundTransparency = 1,
    Text = "WcodeCheats",
    TextColor3 = GREEN,
    Font = Enum.Font.GothamBold,
    TextSize = 20,
}, KeyWindow)

Create("TextLabel", {
    Name = "Info",
    Size = UDim2.new(1, -30, 0, 20),
    Position = UDim2.fromOffset(15, 38),
    BackgroundTransparency = 1,
    Text = "Enter access key",
    TextColor3 = WHITE,
    Font = Enum.Font.Gotham,
    TextSize = 12,
}, KeyWindow)

local KeyBox = Create("TextBox", {
    Name = "KeyBox",
    Size = UDim2.new(1, -30, 0, 34),
    Position = UDim2.fromOffset(15, 63),
    BackgroundColor3 = DARK2,
    Text = "",
    PlaceholderText = "LARP",
    PlaceholderColor3 = GRAY,
    TextColor3 = WHITE,
    Font = Enum.Font.GothamBold,
    TextSize = 13,
    ClearTextOnFocus = false,
    TextXAlignment = Enum.TextXAlignment.Center,
}, KeyWindow)

AddCorner(KeyBox, 6)
AddStroke(KeyBox, Color3.fromRGB(35, 70, 45), 1)

local UnlockButton = Create("TextButton", {
    Name = "Unlock",
    Size = UDim2.new(1, -30, 0, 32),
    Position = UDim2.fromOffset(15, 110),
    BackgroundColor3 = GREEN,
    Text = "UNLOCK",
    TextColor3 = Color3.fromRGB(0, 20, 5),
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    AutoButtonColor = true,
}, KeyWindow)

AddCorner(UnlockButton, 6)

--========================================================--
-- MAIN MENU
-- СОЗДАЁТСЯ СРАЗУ, НО ПОЛНОСТЬЮ СКРЫТО
--========================================================--

local Main = Create("Frame", {
    Name = "MainMenu",
    Size = UDim2.fromOffset(250, 300),
    Position = UDim2.new(0, 75, 0.5, -150),
    BackgroundColor3 = DARK,
    Visible = false,
}, ScreenGui)

AddCorner(Main, 8)
AddStroke(Main, GREEN, 1)

local Header = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 38),
    BackgroundColor3 = DARK2,
}, Main)

AddCorner(Header, 8)

Create("TextLabel", {
    Size = UDim2.new(1, -40, 1, 0),
    Position = UDim2.fromOffset(12, 0),
    BackgroundTransparency = 1,
    Text = "WcodeCheats",
    TextColor3 = GREEN,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBold,
    TextSize = 15,
}, Header)

local CloseButton = Create("TextButton", {
    Size = UDim2.fromOffset(30, 30),
    Position = UDim2.new(1, -34, 0, 4),
    BackgroundTransparency = 1,
    Text = "×",
    TextColor3 = WHITE,
    Font = Enum.Font.GothamBold,
    TextSize = 20,
}, Header)

local Content = Create("ScrollingFrame", {
    Size = UDim2.new(1, -12, 1, -46),
    Position = UDim2.fromOffset(6, 43),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = GREEN,
    CanvasSize = UDim2.fromOffset(0, 0),
}, Main)

local Layout = Create("UIListLayout", {
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, Content)

Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Content.CanvasSize = UDim2.fromOffset(
        0,
        Layout.AbsoluteContentSize.Y + 10
    )
end)

--========================================================--
-- MENU BUTTONS
--========================================================--

local function AddButton(text, callback)
    local button = Create("TextButton", {
        Size = UDim2.new(1, -4, 0, 32),
        BackgroundColor3 = DARK2,
        Text = text,
        TextColor3 = WHITE,
        Font = Enum.Font.Gotham,
        TextSize = 12,
        AutoButtonColor = false,
    }, Content)

    AddCorner(button, 5)
    AddStroke(button, Color3.fromRGB(30, 55, 35), 1)

    button.Activated:Connect(callback)

    return button
end

local function AddToggle(name, getter, setter)
    local button

    local function Refresh()
        local enabled = getter()

        button.Text = name .. "  [" .. (enabled and "ON" or "OFF") .. "]"
        button.TextColor3 = enabled and GREEN or WHITE
    end

    button = AddButton(name, function()
        setter(not getter())
        Refresh()
    end)

    Refresh()

    return button
end

AddToggle(
    "Fly",
    function()
        return State.Fly
    end,
    function(value)
        State.Fly = value
    end
)

AddToggle(
    "Noclip",
    function()
        return State.Noclip
    end,
    function(value)
        State.Noclip = value
    end
)

AddToggle(
    "Air Jump",
    function()
        return State.AirJump
    end,
    function(value)
        State.AirJump = value
    end
)

AddButton("Speed: 16", function(button)
    State.Speed += 25

    if State.Speed > 1000 then
        State.Speed = 1
    end

    button.Text = "Speed: " .. State.Speed
end)

AddButton("Jump Power: 50", function(button)
    State.JumpPower += 25

    if State.JumpPower > 300 then
        State.JumpPower = 25
    end

    button.Text = "Jump Power: " .. State.JumpPower
end)

AddButton("Fly Speed: 70", function(button)
    State.FlySpeed += 25

    if State.FlySpeed > 300 then
        State.FlySpeed = 25
    end

    button.Text = "Fly Speed: " .. State.FlySpeed
end)

AddToggle(
    "ESP",
    function()
        return State.ESP
    end,
    function(value)
        State.ESP = value
    end
)

AddToggle(
    "Chams",
    function()
        return State.Chams
    end,
    function(value)
        State.Chams = value
    end
)

--========================================================--
-- FLOATING W
-- ИЗНАЧАЛЬНО НЕ СУЩЕСТВУЕТ
--========================================================--

local FloatingW = nil

local function CreateFloatingW()
    if FloatingW and FloatingW.Parent then
        return
    end

    FloatingW = Create("TextButton", {
        Name = "FloatingW",
        Size = UDim2.fromOffset(46, 46),
        Position = UDim2.new(0, 18, 0.5, -23),
        BackgroundColor3 = Color3.fromRGB(4, 7, 5),
        Text = "W",
        TextColor3 = GREEN,
        Font = Enum.Font.GothamBlack,
        TextSize = 23,
        AutoButtonColor = false,
    }, ScreenGui)

    AddCorner(FloatingW, 10)
    AddStroke(FloatingW, GREEN, 1)

    FloatingW.Activated:Connect(function()
        if not State.Authorized then
            return
        end

        State.MenuOpen = not State.MenuOpen
        Main.Visible = State.MenuOpen
    end)

    -- Drag
    local dragging = false
    local dragStart
    local startPosition

    FloatingW.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            dragStart = input.Position
            startPosition = FloatingW.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then
            return
        end

        if input.UserInputType ~= Enum.UserInputType.MouseMovement
            and input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        local delta = input.Position - dragStart

        FloatingW.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            dragging = false
        end
    end)
end

--========================================================--
-- FLY
--========================================================--

local FlyVelocity

local function StopFly()
    if FlyVelocity then
        FlyVelocity:Destroy()
        FlyVelocity = nil
    end

    if Humanoid then
        Humanoid.PlatformStand = false
    end
end

local function StartFly()
    StopFly()

    if not RootPart or not Humanoid then
        return
    end

    FlyVelocity = Instance.new("BodyVelocity")
    FlyVelocity.MaxForce = Vector3.new(
        100000,
        100000,
        100000
    )
    FlyVelocity.Velocity = Vector3.zero
    FlyVelocity.Parent = RootPart

    Humanoid.PlatformStand = true
end

local function UpdateFly()
    if not State.Fly then
        if FlyVelocity then
            StopFly()
        end

        return
    end

    if not RootPart or not Humanoid then
        UpdateCharacter()
        return
    end

    if not FlyVelocity then
        StartFly()
    end

    local camera = workspace.CurrentCamera

    if not camera or not FlyVelocity then
        return
    end

    local direction = Vector3.zero

    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        direction += camera.CFrame.LookVector
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        direction -= camera.CFrame.LookVector
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        direction -= camera.CFrame.RightVector
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        direction += camera.CFrame.RightVector
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        direction += Vector3.new(0, 1, 0)
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        direction -= Vector3.new(0, 1, 0)
    end

    if direction.Magnitude > 0 then
        direction = direction.Unit
    end

    FlyVelocity.Velocity = direction * State.FlySpeed
end

--========================================================--
-- NOCLIP + MOVEMENT
--========================================================--

local function UpdateMovement()
    if not Humanoid then
        return
    end

    Humanoid.UseJumpPower = true
    Humanoid.WalkSpeed = State.Speed
    Humanoid.JumpPower = State.JumpPower

    if Character and State.Noclip then
        for _, object in ipairs(Character:GetDescendants()) do
            if object:IsA("BasePart") then
                object.CanCollide = false
            end
        end
    end
end

--========================================================--
-- AIR JUMP
--========================================================--

UserInputService.JumpRequest:Connect(function()
    if not State.Authorized then
        return
    end

    if not State.AirJump then
        return
    end

    if Humanoid then
        Humanoid:ChangeState(
            Enum.HumanoidStateType.Jumping
        )
    end
end)

--========================================================--
-- ESP
--========================================================--

local ESPObjects = {}

local function RemoveESP(player)
    local data = ESPObjects[player]

    if data then
        if data.Highlight then
            data.Highlight:Destroy()
        end

        if data.Billboard then
            data.Billboard:Destroy()
        end
    end

    ESPObjects[player] = nil
end

local function CreateESP(player)
    if player == LocalPlayer then
        return
    end

    if ESPObjects[player] then
        return
    end

    local character = player.Character

    if not character then
        return
    end

    local root = character:FindFirstChild("HumanoidRootPart")

    if not root then
        return
    end

    local data = {}

    data.Highlight = Create("Highlight", {
        Name = "WcodeESP",
        Adornee = character,
        FillColor = GREEN,
        OutlineColor = GREEN,
        FillTransparency = 0.82,
        OutlineTransparency = 0,
        DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
    }, ScreenGui)

    data.Billboard = Create("BillboardGui", {
        Name = "WcodeESPInfo",
        Adornee = root,
        Size = UDim2.fromOffset(130, 24),
        StudsOffset = Vector3.new(0, 3, 0),
        AlwaysOnTop = true,
    }, ScreenGui)

    data.Text = Create("TextLabel", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        TextColor3 = GREEN,
        TextStrokeTransparency = 0,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
    }, data.Billboard)

    ESPObjects[player] = data
end

local function UpdateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if State.ESP then
                CreateESP(player)

                local data = ESPObjects[player]

                if data and player.Character then
                    local hum =
                        player.Character:FindFirstChildOfClass(
                            "Humanoid"
                        )

                    if hum then
                        data.Text.Text =
                            player.Name
                            .. " | "
                            .. math.floor(hum.Health)
                            .. " HP"
                    end
                end
            else
                RemoveESP(player)
            end
        end
    end
end

Players.PlayerRemoving:Connect(RemoveESP)

--========================================================--
-- CHAMS
--========================================================--

local ChamsObjects = {}

local function RemoveChams(player)
    if ChamsObjects[player] then
        ChamsObjects[player]:Destroy()
        ChamsObjects[player] = nil
    end
end

local function UpdateChams()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if State.Chams then
                local character = player.Character

                if character and not ChamsObjects[player] then
                    ChamsObjects[player] = Create("Highlight", {
                        Name = "WcodeChams",
                        Adornee = character,
                        FillColor = GREEN,
                        OutlineColor = GREEN,
                        FillTransparency = 0.35,
                        OutlineTransparency = 0,
                        DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
                    }, ScreenGui)
                end
            else
                RemoveChams(player)
            end
        end
    end
end

Players.PlayerRemoving:Connect(RemoveChams)

--========================================================--
-- AUTHORIZATION
--========================================================--

local Unlocking = false

local function Unlock()
    if Unlocking then
        return
    end

    Unlocking = true

    local entered = tostring(KeyBox.Text or "")
    entered = entered:gsub("^%s+", "")
    entered = entered:gsub("%s+$", "")
    entered = string.upper(entered)

    if entered ~= string.upper(CORRECT_KEY) then
        KeyBox.Text = ""

        KeyBox.PlaceholderText = "INVALID KEY"

        Unlocking = false
        return
    end

    -- Авторизация
    State.Authorized = true
    State.MenuOpen = true

    -- Убираем окно ключа
    KeyWindow.Visible = false
    KeyWindow.Active = false

    -- Удаляем окно полностью
    task.defer(function()
        if KeyWindow then
            KeyWindow:Destroy()
        end
    end)

    -- Создаём W только сейчас
    CreateFloatingW()

    -- Показываем главное меню
    Main.Visible = true

    Unlocking = false
end

-- Activated работает и на ПК, и на телефоне
UnlockButton.Activated:Connect(Unlock)

-- Enter на клавиатуре
KeyBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        Unlock()
    end
end)

--========================================================--
-- CLOSE MENU
--========================================================--

CloseButton.Activated:Connect(function()
    if not State.Authorized then
        return
    end

    State.MenuOpen = false
    Main.Visible = false
end)

--========================================================--
-- UPDATE
--========================================================--

RunService.RenderStepped:Connect(function()
    if not State.Authorized then
        return
    end

    UpdateCharacter()
    UpdateMovement()
    UpdateFly()
    UpdateESP()
    UpdateChams()
end)

print("[WcodeCheats] Loaded")
print("[WcodeCheats] Waiting for key...")
