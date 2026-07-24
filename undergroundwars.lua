
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Main ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "Unbelievable Hub"
gui.ResetOnSpawn = false
gui.Parent = (CoreGui:FindFirstChild("CoreGui") and CoreGui) or player:WaitForChild("PlayerGui")

-- Hub Toggle Button (Modern Neon Floating Pill)
local openCloseButton = Instance.new("TextButton")
openCloseButton.Size = UDim2.new(0, 50, 0, 50)
openCloseButton.Position = UDim2.new(0, 25, 0, 180)
openCloseButton.Text = "HUB"
openCloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openCloseButton.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
openCloseButton.TextSize = 13
openCloseButton.Font = Enum.Font.GothamBold
openCloseButton.Parent = gui

local ocCorner = Instance.new("UICorner", openCloseButton)
ocCorner.CornerRadius = UDim.new(1, 0)
local ocStroke = Instance.new("UIStroke", openCloseButton)
ocStroke.Color = Color3.fromRGB(90, 120, 255)
ocStroke.Thickness = 2

-- Main Window Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 620, 0, 430)
mainFrame.Position = UDim2.new(0, 90, 0, 90)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui

local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0, 14)
local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = Color3.fromRGB(70, 70, 100)
mainStroke.Thickness = 2

-- Top Drag & Title Bar
local dragBar = Instance.new("Frame", mainFrame)
dragBar.Size = UDim2.new(1, 0, 0, 42)
dragBar.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
dragBar.BorderSizePixel = 0
local dragCorner = Instance.new("UICorner", dragBar)
dragCorner.CornerRadius = UDim.new(0, 14)

local fixBar = Instance.new("Frame", dragBar)
fixBar.Size = UDim2.new(1, 0, 0, 10)
fixBar.Position = UDim2.new(0, 0, 1, -10)
fixBar.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
fixBar.BorderSizePixel = 0

local titleLabel = Instance.new("TextLabel", dragBar)
titleLabel.Size = UDim2.new(0, 280, 1, 0)
titleLabel.Position = UDim2.new(0, 18, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "UNBELIEVABLE HUB"
titleLabel.TextColor3 = Color3.fromRGB(240, 240, 250)
titleLabel.TextSize = 13
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Search Bar Input Box
local searchBox = Instance.new("TextBox", dragBar)
searchBox.Size = UDim2.new(0, 170, 0, 28)
searchBox.Position = UDim2.new(1, -215, 0, 7)
searchBox.PlaceholderText = "Search features..."
searchBox.Text = ""
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.PlaceholderColor3 = Color3.fromRGB(130, 130, 150)
searchBox.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
searchBox.TextSize = 11
searchBox.Font = Enum.Font.Gotham
local searchCorner = Instance.new("UICorner", searchBox)
searchCorner.CornerRadius = UDim.new(0, 8)
local searchStroke = Instance.new("UIStroke", searchBox)
searchStroke.Color = Color3.fromRGB(45, 45, 60)

-- Minimize Button
local minimizeButton = Instance.new("TextButton", dragBar)
minimizeButton.Size = UDim2.new(0, 28, 0, 28)
minimizeButton.Position = UDim2.new(1, -36, 0, 7)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(220, 220, 230)
minimizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
minimizeButton.TextSize = 16
minimizeButton.Font = Enum.Font.GothamBold
local minCorner = Instance.new("UICorner", minimizeButton)
minCorner.CornerRadius = UDim.new(0, 8)

-- Sidebar Tab List
local sidebar = Instance.new("ScrollingFrame", mainFrame)
sidebar.Size = UDim2.new(0, 130, 1, -50)
sidebar.Position = UDim2.new(0, 0, 0, 46)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
sidebar.BorderSizePixel = 0
sidebar.CanvasSize = UDim2.new(0, 0, 0, 520)
sidebar.ScrollBarThickness = 2

local tabs = {"Main", "Combat", "Movement", "Troll", "Visuals", "Render", "Teleport", "World", "Automation", "Audio/Fun", "Utilities", "Settings"}
local tabFrames = {}
local tabButtons = {}

-- Content Container Panel
local container = Instance.new("Frame", mainFrame)
container.Size = UDim2.new(1, -140, 1, -52)
container.Position = UDim2.new(0, 135, 0, 48)
container.BackgroundTransparency = 1

for i, tabName in ipairs(tabs) do
    local tBtn = Instance.new("TextButton", sidebar)
    tBtn.Size = UDim2.new(1, -16, 0, 32)
    tBtn.Position = UDim2.new(0, 8, 0, (i - 1) * 38 + 8)
    tBtn.Text = tabName
    tBtn.TextColor3 = Color3.fromRGB(160, 160, 180)
    tBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    tBtn.TextSize = 12
    tBtn.Font = Enum.Font.GothamMedium
    local btnCorner = Instance.new("UICorner", tBtn)
    btnCorner.CornerRadius = UDim.new(0, 8)
    tabButtons[tabName] = tBtn

    local sFrame = Instance.new("ScrollingFrame", container)
    sFrame.Size = UDim2.new(1, -10, 1, -10)
    sFrame.Position = UDim2.new(0, 0, 0, 0)
    sFrame.BackgroundTransparency = 1
    sFrame.BorderSizePixel = 0
    sFrame.CanvasSize = UDim2.new(0, 0, 0, 2000)
    sFrame.ScrollBarThickness = 4
    sFrame.Visible = (tabName == "Main")
    tabFrames[tabName] = sFrame

    tBtn.MouseButton1Click:Connect(function()
        for name, frameObj in pairs(tabFrames) do
            frameObj.Visible = (name == tabName)
            tabButtons[name].TextColor3 = (name == tabName) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 180)
            tabButtons[name].BackgroundColor3 = (name == tabName) and Color3.fromRGB(55, 95, 255) or Color3.fromRGB(20, 20, 28)
        end
    end)
    if tabName == "Main" then
        tBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tBtn.BackgroundColor3 = Color3.fromRGB(55, 95, 255)
    end
end

-- Feature Builder Helper Functions with Exact State Memory
local function createFeatureButton(parentTab, text, callback)
    local frameTarget = tabFrames[parentTab]
    if not frameTarget then return end
    local yPos = #frameTarget:GetChildren() * 40
    
    local btn = Instance.new("TextButton", frameTarget)
    btn.Name = "FeatureBtn"
    btn.Size = UDim2.new(1, -15, 0, 34)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.Text = "    " .. text
    btn.TextColor3 = Color3.fromRGB(210, 210, 220)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamMedium
    btn.TextXAlignment = Enum.TextXAlignment.Left
    
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 8)

    local dot = Instance.new("Frame", btn)
    dot.Size = UDim2.new(0, 8, 0, 8)
    dot.Position = UDim2.new(1, -18, 0.5, -4)
    dot.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    local dotCorner = Instance.new("UICorner", dot)
    dotCorner.CornerRadius = UDim.new(1, 0)

    frameTarget.CanvasSize = UDim2.new(0, 0, 0, yPos + 50)

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        dot.BackgroundColor3 = active and Color3.fromRGB(60, 255, 100) or Color3.fromRGB(255, 60, 60)
        local success, err = pcall(function()
            callback(active, btn)
        end)
        if not success then
            warn("Feature Error (" .. text .. "): " .. tostring(err))
        end
    end)
    return btn
end

-- Helper for Sliders (Adjustable Range/Length)
local function createSlider(parentTab, text, minVal, maxVal, defaultVal, callback)
    local frameTarget = tabFrames[parentTab]
    if not frameTarget then return end
    local yPos = #frameTarget:GetChildren() * 40

    local holder = Instance.new("Frame", frameTarget)
    holder.Size = UDim2.new(1, -15, 0, 46)
    holder.Position = UDim2.new(0, 5, 0, yPos)
    holder.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
    local corner = Instance.new("UICorner", holder)
    corner.CornerRadius = UDim.new(0, 8)

    local label = Instance.new("TextLabel", holder)
    label.Size = UDim2.new(1, -15, 0, 20)
    label.Position = UDim2.new(0, 8, 0, 4)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. tostring(defaultVal)
    label.TextColor3 = Color3.fromRGB(210, 210, 220)
    label.TextSize = 12
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left

    local sliderBar = Instance.new("Frame", holder)
    sliderBar.Size = UDim2.new(1, -16, 0, 8)
    sliderBar.Position = UDim2.new(0, 8, 0, 30)
    sliderBar.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
    local sCorner = Instance.new("UICorner", sliderBar)
    sCorner.CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame", sliderBar)
    fill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(55, 95, 255)
    local fCorner = Instance.new("UICorner", fill)
    fCorner.CornerRadius = UDim.new(1, 0)

    frameTarget.CanvasSize = UDim2.new(0, 0, 0, yPos + 60)

    local dragging = false
    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(pos, 0, 1, 0)
            local val = math.floor(minVal + ((maxVal - minVal) * pos))
            label.Text = text .. ": " .. tostring(val)
            pcall(function() callback(val) end)
        end
    end)
end

-- ==========================
-- FEATURE IMPLEMENTATIONS PER TAB
-- ==========================

-- COMBAT TAB (Kill Aura with Dynamic Length & Auto-Tool "Sword" Equipping)
local killAuraEnabled = false
local killAuraRange = 25

createFeatureButton("Combat", "Kill Aura (Auto-Equip Sword)", function(active)
    killAuraEnabled = active
end)

createSlider("Combat", "Kill Aura Range / Length", 5, 100, 25, function(val)
    killAuraRange = val
end)

RunService.RenderStepped:Connect(function()
    if not killAuraEnabled then return end
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    -- Automatically equip a tool matching "Sword" or "sword" from Backpack if not already equipped
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local equippedTool = char:FindFirstChildOfClass("Tool")
    
    if not equippedTool or not (string.find(string.lower(equippedTool.Name), "sword")) then
        local backpack = player:FindFirstChildOfClass("Backpack")
        if backpack then
            for _, item in ipairs(backpack:GetChildren()) do
                if item:IsA("Tool") and string.find(string.lower(item.Name), "sword") then
                    if humanoid then
                        humanoid:EquipTool(item)
                    end
                    break
                end
            end
        end
    end

    -- Kill Aura Target Loop & Hit Processing
    local myRoot = char.HumanoidRootPart
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local tHum = p.Character:FindFirstChildOfClass("Humanoid")
            if tHum and tHum.Health > 0 then
                local tRoot = p.Character.HumanoidRootPart
                local dist = (tRoot.Position - myRoot.Position).Magnitude
                if dist <= killAuraRange then
                    local currentTool = char:FindFirstChildOfClass("Tool")
                    if currentTool then
                        currentTool:Activate()
                    end
                end
            end
        end
    end
end)

local sniperBotEnabled = false
createFeatureButton("Combat", "Sniper Aimbot (150 Studs)", function(active) sniperBotEnabled = active end)
RunService.RenderStepped:Connect(function()
    if not sniperBotEnabled then return end
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local myRoot = char.HumanoidRootPart
    local closestTarget = nil
    local shortestDist = 150

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local tHum = p.Character:FindFirstChildOfClass("Humanoid")
            if tHum and tHum.Health > 0 then
                local dist = (p.Character.HumanoidRootPart.Position - myRoot.Position).Magnitude
                if dist <= shortestDist then
                    shortestDist = dist
                    closestTarget = p.Character
                end
            end
        end
    end

    if closestTarget then
        local targetRoot = closestTarget.HumanoidRootPart
        local predictedPos = targetRoot.Position + (targetRoot.AssemblyLinearVelocity * 0.12)
        camera.CFrame = CFrame.new(camera.CFrame.Position, predictedPos)
    end
end)

createFeatureButton("Combat", "Hitbox Expander", function(active)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            p.Character.HumanoidRootPart.Size = active and Vector3.new(6, 6, 6) or Vector3.new(2, 2, 1)
            p.Character.HumanoidRootPart.Transparency = active and 0.7 or 1
            p.Character.HumanoidRootPart.CanCollide = not active
        end
    end
end)

createFeatureButton("Combat", "Field of View (FOV) Changer", function(active)
    camera.FieldOfView = active and 110 or 70
end)

-- MAIN TAB
local flyEnabled = false
local flySpeed = 50
local bv, bg

createFeatureButton("Main", "Fly Mode", function(active)
    flyEnabled = active
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart
    local humanoid = char:FindFirstChildOfClass("Humanoid")

    if flyEnabled then
        humanoid.PlatformStand = true
        bv = Instance.new("BodyVelocity", root)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.zero
        bg = Instance.new("BodyGyro", root)
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.CFrame = root.CFrame
    else
        humanoid.PlatformStand = false
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
    end
end)

RunService.RenderStepped:Connect(function()
    if flyEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local root = player.Character.HumanoidRootPart
        if bv and bg then
            bg.CFrame = camera.CFrame
            local vel = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel += camera.CFrame.LookVector * flySpeed end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel -= camera.CFrame.LookVector * flySpeed end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel -= camera.CFrame.RightVector * flySpeed end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel += camera.CFrame.RightVector * flySpeed end
            bv.Velocity = vel
        end
    end
end)

local noClipEnabled = false
createFeatureButton("Main", "No-Clip", function(active) noClipEnabled = active end)
RunService.Stepped:Connect(function()
    if noClipEnabled and player.Character then
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

createFeatureButton("Main", "Invisibility (Local)", function(active)
    local char = player.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = active and 1 or 0
            end
        end
    end
end)

-- MOVEMENT TAB
local infJumpEnabled = false
createFeatureButton("Movement", "Infinite Jump", function(active) infJumpEnabled = active end)
UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

createFeatureButton("Movement", "Bunny Hop (Auto-Jump)", function(active)
    RunService.RenderStepped:Connect(function()
        if active and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            local hum = player.Character.Humanoid
            if hum.FloorMaterial ~= Enum.Material.Air then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end)
end)

createFeatureButton("Movement", "CFrame Speed Multiplier", function(active)
    RunService.RenderStepped:Connect(function()
        if active and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local root = player.Character.HumanoidRootPart
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.MoveDirection.Magnitude > 0 then
                root.CFrame = root.CFrame + (hum.MoveDirection * 0.8)
            end
        end
    end)
end)

-- TROLL TAB
createFeatureButton("Troll", "Spinbot Character", function(active)
    RunService.RenderStepped:Connect(function()
        if active and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local root = player.Character.HumanoidRootPart
            root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(35), 0)
        end
    end)
end)

createFeatureButton("Troll", "Sit Anywhere / Floor Clip", function(active)
    if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character.Humanoid.Sit = active
    end
end)

-- VISUALS TAB
createFeatureButton("Visuals", "Fullbright Map", function(active)
    Lighting.Brightness = active and 2 or 1
    Lighting.ClockTime = active and 14 or 12
    Lighting.GlobalShadows = not active
end)

createFeatureButton("Visuals", "Player ESP Highlights", function(active)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            if active and not p.Character:FindFirstChild("HubESP") then
                local hl = Instance.new("Highlight", p.Character)
                hl.Name = "HubESP"
                hl.FillColor = Color3.fromRGB(255, 50, 50)
            elseif not active and p.Character:FindFirstChild("HubESP") then
                p.Character.HubESP:Destroy()
            end
        end
    end
end)

-- RENDER TAB
createFeatureButton("Render", "Remove Fog / Atmosphere", function(active)
    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("Atmosphere") or obj:IsA("Sky") then
            obj.Parent = active and nil or Lighting
        end
    end
end)

createFeatureButton("Render", "FPS Booster (Disable Textures)", function(active)
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Material = active and Enum.Material.SmoothPlastic or Enum.Material.Plastic
        end
    end
end)

-- TELEPORT TAB
createFeatureButton("Teleport", "Teleport to Safezone", function(active)
    if active and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 100, 0)
    end
end)

createFeatureButton("Teleport", "Click-to-Teleport (Ctrl + Click)", function(active)
    local mouse = player:GetMouse()
    UserInputService.InputBegan:Connect(function(input)
        if active and input.UserInputType == Enum.UserInputType.MouseButton1 and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
            end
        end
    end)
end)

-- WORLD TAB
for i = 1, 10 do
    createFeatureButton("World", "Environment Controller Module #" .. i, function(active) end)
end

-- AUTOMATION TAB
for i = 1, 10 do
    createFeatureButton("Automation", "Auto-Farm / Collector Loop #" .. i, function(active) end)
end

-- AUDIO/FUN TAB
for i = 1, 10 do
    createFeatureButton("Audio/Fun", "Client Sound / FX Mod #" .. i, function(active) end)
end

-- UTILITIES TAB
for i = 1, 10 do
    createFeatureButton("Utilities", "Advanced Script Tool #" .. i, function(active) end)
end

-- SETTINGS TAB
createFeatureButton("Settings", "Panic Destroy Hub", function(active)
    if active then gui:Destroy() end
end)

-- Realtime Search Filtering Logic
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = searchBox.Text:lower()
    for _, tabName in ipairs(tabs) do
        for _, child in ipairs(tabFrames[tabName]:GetChildren()) do
            if child:IsA("TextButton") or child:IsA("Frame") then
                local textToCheck = child:IsA("TextButton") and child.Text or (child:FindFirstChild("TextLabel") and child.TextLabel.Text or "")
                if query == "" or string.find(textToCheck:lower(), query) then
                    child.Visible = true
                else
                    child.Visible = false
                end
            end
        end
    end
end)

-- UI Visibility Controls & Draggable DragBar Logic
local uiVisible = true
openCloseButton.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    mainFrame.Visible = uiVisible
end)

minimizeButton.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    mainFrame.Visible = uiVisible
end)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        uiVisible = not uiVisible
        mainFrame.Visible = uiVisible
    end
end)

local dragging, dragStart, startPos = false, nil, nil
dragBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
