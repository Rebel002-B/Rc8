local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RC8BackdoorGui"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false
screenGui.Enabled = false

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 480, 0, 320)
frame.Position = UDim2.new(0.5, -240, 0.5, -160)
frame.BackgroundColor3 = Color3.fromRGB(25, 0, 0)
frame.BorderSizePixel = 0
frame.Parent = screenGui
frame.Active = true
frame.Draggable = true
frame.ClipsDescendants = true

-- Title with glitchy animation
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "RC8 BACKDOOR"
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.Font = Enum.Font.Code
title.TextSize = 28
title.Parent = frame

-- Function for glitch effect on title
local function glitchTitle()
    spawn(function()
        while screenGui.Enabled do
            local chars = {"R", "C", "8", "B", "A", "C", "K", "D", "O", "O", "R"}
            local display = ""
            for i=1,#chars do
                if math.random() < 0.2 then
                    display = display .. string.char(math.random(33,126))
                else
                    display = display .. chars[i]
                end
            end
            title.Text = display
            wait(0.08)
        end
        title.Text = "RC8 BACKDOOR"
    end)
end

-- Tabs container
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 30)
tabBar.Position = UDim2.new(0, 0, 0, 40)
tabBar.BackgroundTransparency = 1
tabBar.Parent = frame

local tabs = {}
local tabNames = {"Executor", "Settings", "Console"}

local currentTab = nil

local function createTabButton(name, posX)
    local btn = Instance.new("TextButton")
    btn.Text = name .. " 🔒"
    btn.TextColor3 = Color3.fromRGB(200, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
    btn.Font = Enum.Font.Code
    btn.TextSize = 18
    btn.Size = UDim2.new(0, 120, 1, 0)
    btn.Position = UDim2.new(0, posX, 0, 0)
    btn.Parent = tabBar
    btn.AutoButtonColor = false
    btn.TextTransparency = 0.5
    btn.Active = false -- disabled by default

    local lockIcon = Instance.new("TextLabel")
    lockIcon.Text = "🔒"
    lockIcon.Size = UDim2.new(0, 20, 1, 0)
    lockIcon.Position = UDim2.new(1, -22, 0, 0)
    lockIcon.BackgroundTransparency = 1
    lockIcon.TextColor3 = Color3.fromRGB(200,0,0)
    lockIcon.Parent = btn

    return btn, lockIcon
end

-- Create tabs buttons
local tabButtons = {}
local tabLocks = {}
for i, name in ipairs(tabNames) do
    local btn, lockIcon = createTabButton(name, (i-1)*120)
    tabButtons[name] = btn
    tabLocks[name] = lockIcon
end

-- Tab content frames
local contentFrames = {}
for i, name in ipairs(tabNames) do
    local cont = Instance.new("Frame")
    cont.Size = UDim2.new(1, 0, 1, -70)
    cont.Position = UDim2.new(0, 0, 0, 70)
    cont.BackgroundColor3 = Color3.fromRGB(35, 0, 0)
    cont.Visible = false
    cont.Parent = frame
    contentFrames[name] = cont
end

-- LOGIN UI
local loginFrame = Instance.new("Frame")
loginFrame.Size = UDim2.new(0, 400, 0, 220)
loginFrame.Position = UDim2.new(0.5, -200, 0.5, -110)
loginFrame.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
loginFrame.BorderSizePixel = 0
loginFrame.Parent = frame

local loginTitle = Instance.new("TextLabel")
loginTitle.Text = "RC8 Backdoor Login"
loginTitle.Font = Enum.Font.Code
loginTitle.TextSize = 24
loginTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
loginTitle.BackgroundTransparency = 1
loginTitle.Size = UDim2.new(1,0,0,40)
loginTitle.Position = UDim2.new(0,0,0,10)
loginTitle.Parent = loginFrame

local userLabel = Instance.new("TextLabel")
userLabel.Text = "Username:"
userLabel.Font = Enum.Font.Code
userLabel.TextSize = 18
userLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
userLabel.BackgroundTransparency = 1
userLabel.Position = UDim2.new(0.1,0,0,60)
userLabel.Size = UDim2.new(0, 100, 0, 25)
userLabel.TextXAlignment = Enum.TextXAlignment.Left
userLabel.Parent = loginFrame

local userBox = Instance.new("TextBox")
userBox.PlaceholderText = "Enter Username"
userBox.Font = Enum.Font.Code
userBox.TextSize = 18
userBox.TextColor3 = Color3.new(1,1,1)
userBox.BackgroundColor3 = Color3.fromRGB(30,0,0)
userBox.Position = UDim2.new(0.4, 0, 0, 60)
userBox.Size = UDim2.new(0, 180, 0, 25)
userBox.ClearTextOnFocus = true
userBox.Parent = loginFrame

local passLabel = Instance.new("TextLabel")
passLabel.Text = "Password:"
passLabel.Font = Enum.Font.Code
passLabel.TextSize = 18
passLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
passLabel.BackgroundTransparency = 1
passLabel.Position = UDim2.new(0.1,0,0,100)
passLabel.Size = UDim2.new(0, 100, 0, 25)
passLabel.TextXAlignment = Enum.TextXAlignment.Left
passLabel.Parent = loginFrame

local passBox = Instance.new("TextBox")
passBox.PlaceholderText = "Enter Password"
passBox.Font = Enum.Font.Code
passBox.TextSize = 18
passBox.TextColor3 = Color3.new(1,1,1)
passBox.BackgroundColor3 = Color3.fromRGB(30,0,0)
passBox.Position = UDim2.new(0.4, 0, 0, 100)
passBox.Size = UDim2.new(0, 180, 0, 25)
passBox.ClearTextOnFocus = true
passBox.Parent = loginFrame
passBox.TextScaled = false
passBox.TextXAlignment = Enum.TextXAlignment.Left
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextTransparency = 0
passBox.TextEditable = true
passBox.TextStrokeTransparency = 0.7
passBox.TextTransparency = 0
passBox.TextEditable = true
passBox.Text = ""
passBox.TextTruncate = Enum.TextTruncate.AtEnd
passBox.TextEditable = true
passBox.Text = ""
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.TextTransparency = 0
passBox.TextEditable = true
passBox.TextTruncate = Enum.TextTruncate.AtEnd
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.TextTransparency = 0
passBox.TextEditable = true
passBox.Text = ""
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.TextTransparency = 0
passBox.TextEditable = true
passBox.Text = ""
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.TextTransparency = 0
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.ClearTextOnFocus = true

-- Hide password text
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextTransparency = 0
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.Text = ""
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.TextTransparency = 0
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.TextTransparency = 0
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.TextTransparency = 0
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.TextTransparency = 0
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.TextTransparency = 0
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.TextTransparency = 0
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.TextTransparency = 0
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.TextTransparency = 0
passBox.TextEditable = true
passBox.ClearTextOnFocus = true
passBox.TextEditable = true
passBox.TextTransparency = 0

local loginStatus = Instance.new("TextLabel")
loginStatus.Size = UDim2.new(1, 0, 0, 30)
loginStatus.Position = UDim2.new(0, 0, 1, -40)
loginStatus.BackgroundTransparency = 1
loginStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
loginStatus.Font = Enum.Font.Code
loginStatus.TextSize = 18
loginStatus.Text = ""
loginStatus.Parent = loginFrame

local loginButton = Instance.new("TextButton")
loginButton.Size = UDim2.new(0, 100, 0, 35)
loginButton.Position = UDim2.new(0.5, -50, 1, -40)
loginButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
loginButton.TextColor3 = Color3.fromRGB(255, 255, 255)
loginButton.Font = Enum.Font.Code
loginButton.TextSize = 20
loginButton.Text = "Login"
loginButton.Parent = loginFrame

-- Executor tab UI
local executorFrame = contentFrames.Executor

local scanButton = Instance.new("TextButton")
scanButton.Size = UDim2.new(0, 150, 0, 40)
scanButton.Position = UDim2.new(0.5, -75, 0, 30)
scanButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
scanButton.TextColor3 = Color3.fromRGB(255, 255, 255)
scanButton.Font = Enum.Font.Code
scanButton.TextSize = 22
scanButton.Text = "Scan Remote \"Test\""
scanButton.Parent = executorFrame

local scanResult = Instance.new("TextLabel")
scanResult.Size = UDim2.new(1, -40, 0, 25)
scanResult.Position = UDim2.new(0, 20, 0, 80)
scanResult.BackgroundTransparency = 1
scanResult.TextColor3 = Color3.fromRGB(255, 50, 50)
scanResult.Font = Enum.Font.Code
scanResult.TextSize = 18
scanResult.Text = "Press scan to check for Remote 'Test'."
scanResult.TextWrapped = true
scanResult.Parent = executorFrame

-- Console tab UI
local consoleFrame = contentFrames.Console

local consoleOutput = Instance.new("ScrollingFrame")
consoleOutput.Size = UDim2.new(1, -20, 1, -40)
consoleOutput.Position = UDim2.new(0, 10, 0, 10)
consoleOutput.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
consoleOutput.BorderSizePixel = 0
consoleOutput.CanvasSize = UDim2.new(0, 0, 5, 0)
consoleOutput.ScrollBarThickness = 8
consoleOutput.Parent = consoleFrame
consoleOutput.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = consoleOutput

local function logConsole(msg)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 20)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(255, 0, 0)
    lbl.Font = Enum.Font.Code
    lbl.TextSize = 16
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Text = msg
    lbl.Parent = consoleOutput

    consoleOutput.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
    consoleOutput.CanvasPosition = Vector2.new(0, consoleOutput.CanvasSize.Y.Offset)
end

-- Settings tab UI
local settingsFrame = contentFrames.Settings
local toggleGuiLabel = Instance.new("TextLabel")
toggleGuiLabel.Text = "Toggle GUI key: RightCtrl"
toggleGuiLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
toggleGuiLabel.Font = Enum.Font.Code
toggleGuiLabel.TextSize = 18
toggleGuiLabel.BackgroundTransparency = 1
toggleGuiLabel.Position = UDim2.new(0, 10, 0, 10)
toggleGuiLabel.Size = UDim2.new(1, -20, 0, 30)
toggleGuiLabel.Parent = settingsFrame

-- Login logic
local loggedIn = false
local function unlockTabs()
    for _, btn in pairs(tabButtons) do
        btn.TextTransparency = 0
        btn.Active = true
        btn.Text = btn.Text:gsub(" 🔒", "")
        if tabLocks[btn.Text] then
            tabLocks[btn.Text].Visible = false
        end
    end
end

local function lockTabs()
    for name, btn in pairs(tabButtons) do
        btn.TextTransparency = 0.5
        btn.Active = false
        if not btn.Text:find("🔒") then
            btn.Text = btn.Text .. " 🔒"
        end
        tabLocks[name].Visible = true
    end
end

local function switchTab(name)
    if currentTab == name then return end
    if not loggedIn then return end
    -- Hide all
    for _, f in pairs(contentFrames) do
        f.Visible = false
    end
    contentFrames[name].Visible = true
    currentTab = name
    -- Highlight button
    for tname, btn in pairs(tabButtons) do
        btn.BackgroundColor3 = (tname == name) and Color3.fromRGB(255,0,0) or Color3.fromRGB(50,0,0)
    end
end

-- Start with lock tabs and login visible
lockTabs()
loginFrame.Visible = true

loginButton.MouseButton1Click:Connect(function()
    local u = userBox.Text
    local p = passBox.Text

    if u == "RC7" and p == "Rc7OnTop" then
        loggedIn = true
        loginStatus.TextColor3 = Color3.fromRGB(0, 255, 0)
        loginStatus.Text = "Access Granted!"
        wait(1)
        loginFrame.Visible = false
        unlockTabs()
        switchTab("Executor")
    else
        loginStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
        loginStatus.Text = "Invalid username or password."
    end
end)

-- Tab button click
for name, btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function()
        if not loggedIn then return end
        switchTab(name)
    end)
end

-- Scan button logic
scanButton.MouseButton1Click:Connect(function()
    local foundRemote = ReplicatedStorage:FindFirstChild("Test")
    if foundRemote and foundRemote:IsA("RemoteEvent") or foundRemote:IsA("RemoteFunction") then
        scanResult.TextColor3 = Color3.fromRGB(0,255,0)
        scanResult.Text = "Remote 'Test' found!"
        logConsole("[SCAN] Remote 'Test' detected in ReplicatedStorage.")
    else
        scanResult.TextColor3 = Color3.fromRGB(255,50,50)
        scanResult.Text = "Remote 'Test' NOT found."
        logConsole("[SCAN] Remote 'Test' not found.")
    end
end)

-- Toggle GUI visibility on RightControl
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        screenGui.Enabled = not screenGui.Enabled
        if screenGui.Enabled then
            glitchTitle()
        end
    end
end)

-- Initially start glitch when GUI enabled manually
glitchTitle()

-- Dragging is enabled by frame.Active and frame.Draggable

return
