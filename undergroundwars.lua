-- Custom Professional UI Library & Script Setup
local Players = game.Players
local plr = Players.LocalPlayer
local loop = false 
local retry = false
_G.name = "sword"
_G.enemOnly = true
local reach = 150

-- Feature Flags & Connections
local customTagsEnabled = false
local killFeedEnabled = false
local speedBypassEnabled = false
local customSpeedValue = 50
local cframeLoopConnection = nil

-- Create Professional Custom UI (Replacing Rayfield)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ProCombatUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- Main Frame (Dark Theme with Rounded Corners)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Top Bar / Header
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 8)
TopBarCorner.Parent = TopBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -20, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "⚡ UNDERGROUND WAR 2.0"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

-- Notification System Function
local function notify(title, content)
    local Notif = Instance.new("Frame")
    Notif.Size = UDim2.new(0, 220, 0, 50)
    Notif.Position = UDim2.new(1, -230, 1, -70)
    Notif.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    Notif.BorderSizePixel = 0
    Notif.Parent = ScreenGui

    local nCorner = Instance.new("UICorner")
    nCorner.CornerRadius = UDim.new(0, 6)
    nCorner.Parent = Notif

    local nTitle = Instance.new("TextLabel")
    nTitle.Size = UDim2.new(1, -10, 0, 20)
    nTitle.Position = UDim2.new(0, 8, 0, 5)
    nTitle.BackgroundTransparency = 1
    nTitle.Font = Enum.Font.GothamBold
    nTitle.Text = title
    nTitle.TextColor3 = Color3.fromRGB(0, 220, 130)
    nTitle.TextSize = 13
    nTitle.TextXAlignment = Enum.TextXAlignment.Left
    nTitle.Parent = Notif

    local nText = Instance.new("TextLabel")
    nText.Size = UDim2.new(1, -10, 0, 20)
    nText.Position = UDim2.new(0, 8, 0, 23)
    nText.BackgroundTransparency = 1
    nText.Font = Enum.Font.Gotham
    nText.Text = content
    nText.TextColor3 = Color3.fromRGB(200, 200, 200)
    nText.TextSize = 11
    nText.TextXAlignment = Enum.TextXAlignment.Left
    nText.Parent = Notif

    task.delay(4, function()
        Notif:Destroy()
    end)
end

notify("Script Loaded", "Custom UI Active & Ready.")

-- Navigation Container Tabs
local TabContainer = Instance.new("ScrollingFrame")
TabContainer.Size = UDim2.new(1, -20, 1, -60)
TabContainer.Position = UDim2.new(0, 10, 0, 52)
TabContainer.BackgroundTransparency = 1
TabContainer.BorderSizePixel = 0
TabContainer.CanvasSize = UDim2.new(0, 0, 1.5, 0)
TabContainer.ScrollBarThickness = 4
TabContainer.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 12)
UIListLayout.Parent = TabContainer

-- UI Component Helper Builder Functions
local function createHeader(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 24)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.Text = text
    label.TextColor3 = Color3.fromRGB(150, 150, 165)
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = TabContainer
end

local function createToggle(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
    btn.AutoButtonColor = false
    btn.Font = Enum.Font.GothamMedium
    btn.Text = "  " .. name .. " [ OFF ]"
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = TabContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        if active then
            btn.Text = "  " .. name .. " [ ON ]"
            btn.TextColor3 = Color3.fromRGB(0, 255, 140)
            btn.BackgroundColor3 = Color3.fromRGB(32, 48, 40)
        else
            btn.Text = "  " .. name .. " [ OFF ]"
            btn.TextColor3 = Color3.fromRGB(200, 200, 200)
            btn.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
        end
        callback(active)
    end)
end

local function createSlider(name, min, max, default, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 54)
    container.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
    container.Parent = TabContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = container

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 24)
    label.Position = UDim2.new(0, 10, 0, 4)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamMedium
    label.Text = name .. ": " .. default
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local sliderBg = Instance.new("TextButton")
    sliderBg.Size = UDim2.new(1, -20, 0, 8)
    sliderBg.Position = UDim2.new(0, 10, 0, 34)
    sliderBg.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    sliderBg.AutoButtonColor = false
    sliderBg.Text = ""
    sliderBg.Parent = container

    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(0, 4)
    sCorner.Parent = sliderBg

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    fill.BorderSizePixel = 0
    fill.Parent = sliderBg

    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 4)
    fCorner.Parent = fill

    local dragging = false
    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("RunService").RenderStepped:Connect(function()
        if dragging then
            local mousePos = game:GetService("UserInputService"):GetMouseLocation()
            local relativeX = math.clamp(mousePos.X - sliderBg.AbsolutePosition.X, 0, sliderBg.AbsoluteSize.X)
            local percentage = relativeX / sliderBg.AbsoluteSize.X
            local val = math.floor(min + (max - min) * percentage)
            fill.Size = UDim2.new(percentage, 0, 1, 0)
            label.Text = name .. ": " .. val
            callback(val)
        end
    end)
end

-- Tool Helper Functions
local function findTool(String)
    local strl = String:lower()
    for _, v in pairs(plr.Backpack:GetChildren()) do
        if v.Name:lower():match(strl) ~= nil then return v end
    end
    for _, v in pairs(plr.Character:GetChildren()) do
        if v.Name:lower():match(strl) ~= nil then return v end
    end
end

local function getTool() 
    return findTool(_G.name) 
end

-- Core KillAura Logic Function
local function KillAura()
    if _G.enemOnly == true then
        repeat
            for _, v in pairs(game.Players:GetPlayers()) do
                pcall(function()
                    if v ~= game.Players.LocalPlayer and v.TeamColor.Name ~= plr.TeamColor.Name and v.Character and v.Character:FindFirstChildOfClass("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChildOfClass("ForceField") == nil then
                        local Distance = (v.Character:FindFirstChildOfClass("Part").Position - game.Players.LocalPlayer.Character:FindFirstChildOfClass("Part").Position).magnitude
                        if Distance <= reach then
                            for i = 1, 25 do
                                if not loop then break end
                                plr.Character.Humanoid.RootPart.CFrame = v.Character.Humanoid.RootPart.CFrame * CFrame.new(-1.6, 0, 1.8)
                                local h = getTool()
                                if h then
                                    h.Parent = plr.Character
                                    h:Activate()
                                    if plr.Character:FindFirstChildOfClass("Tool") and plr.Character:FindFirstChildOfClass("Tool").Name ~= getTool().Name then
                                        plr.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
                                    end
                                end
                                if v.Character.Humanoid.Health <= 0 then
                                    loop = false
                                    if retry == true then
                                        task.wait(1)
                                        KillAura()
                                    end
                                end
                            end
                        end 
                    end
                end)
            end
            game:GetService("RunService").Heartbeat:Wait()
        until loop == false
    else
        repeat
            for _, v in pairs(game.Players:GetPlayers()) do
                pcall(function()
                    if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChildOfClass("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChildOfClass("ForceField") == nil then
                        local Distance = (v.Character:FindFirstChildOfClass("Part").Position - game.Players.LocalPlayer.Character:FindFirstChildOfClass("Part").Position).magnitude
                        if Distance <= reach then
                            for i = 1, 25 do
                                if not loop then break end
                                plr.Character.Humanoid.RootPart.CFrame = v.Character.Humanoid.RootPart.CFrame * CFrame.new(-1.6, 0, 1.8)
                                local h = getTool()
                                if h then
                                    h.Parent = plr.Character
                                    h:Activate()
                                    if plr.Character:FindFirstChildOfClass("Tool") and plr.Character:FindFirstChildOfClass("Tool").Name ~= getTool().Name then
                                        plr.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
                                    end
                                end
                                if v.Character.Humanoid.Health <= 0 then
                                    loop = false
                                    if retry == true then
                                        task.wait(1)
                                        KillAura()
                                    end
                                end
                            end
                        end 
                    end
                end)
            end
            game:GetService("RunService").Heartbeat:Wait()
        until loop == false
    end
end

-- Populate Custom UI Elements
createHeader("--- COMBAT CONTROLS ---")
createToggle("Enable Kill Aura", function(Value)
    loop = Value
    retry = Value
    if Value then task.spawn(KillAura) end
end)

createSlider("Attack Reach", 10, 150, 150, function(Value)
    reach = Value
end)

createHeader("--- MOVEMENT BYPASS ---")
createToggle("CFrame Speed Bypass", function(state)
    speedBypassEnabled = state
    if speedBypassEnabled then
        cframeLoopConnection = game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
            pcall(function()
                local character = plr.Character
                local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                if rootPart and humanoid and humanoid.MoveDirection.Magnitude > 0 then
                    local newPosition = rootPart.Position + (humanoid.MoveDirection * (customSpeedValue - humanoid.WalkSpeed) * deltaTime)
                    rootPart.CFrame = CFrame.new(newPosition) * select(2, rootPart.CFrame:ToOrientation())
                end
            end)
        end)
    else
        if cframeLoopConnection then
            cframeLoopConnection:Disconnect()
            cframeLoopConnection = nil
        end
    end
end)

createSlider("Bypass Speed Mult", 16, 120, 50, function(value)
    customSpeedValue = value
end)

createHeader("--- VISUALS & FUN ---")
local function manageTags(targetPlayer)
    task.spawn(function()
        while customTagsEnabled and targetPlayer and targetPlayer.Parent do
            pcall(function()
                local char = targetPlayer.Character
                local head = char and char:FindFirstChild("Head")
                if head and not head:FindFirstChild("CustomEspTag") then
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "CustomEspTag"
                    billboard.Size = UDim2.new(0, 200, 0, 50)
                    billboard.AlwaysOnTop = true
                    billboard.ExtentsOffset = Vector3.new(0, 2.5, 0)
                    billboard.Parent = head

                    local textLabel = Instance.new("TextLabel")
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.BackgroundTransparency = 1
                    textLabel.Font = Enum.Font.SourceSansBold
                    textLabel.TextSize = 14
                    textLabel.Parent = billboard

                    task.spawn(function()
                        while customTagsEnabled and billboard and billboard.Parent do
                            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("HumanoidRootPart") then
                                local distance = math.floor((plr.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude)
                                textLabel.Text = "[THE HACKER] " .. targetPlayer.Name .. " (" .. tostring(distance) .. " studs)"
                                textLabel.TextColor3 = targetPlayer.TeamColor.Color
                            end
                            task.wait(0.5)
                        end
                        billboard:Destroy()
                    end)
                end
            end)
            task.wait(2)
        end
    end)
end

createToggle("Overhead Custom Tags", function(state)
    customTagsEnabled = state
    if customTagsEnabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= plr then manageTags(p) end
        end
        Players.PlayerAdded:Connect(function(p)
            if customTagsEnabled then manageTags(p) end
        end)
    end
end)

local function trackKillFeed(targetPlayer)
    targetPlayer.CharacterAdded:Connect(function(char)
        local humanoid = char:WaitForChild("Humanoid", 5)
        if humanoid then
            humanoid.Died:Connect(function()
                if killFeedEnabled and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        local distance = (plr.Character.HumanoidRootPart.Position - root.Position).Magnitude
                        if distance <= reach and loop then
                            local TextChatService = game:GetService("TextChatService")
                            local message = "ELIMINATED: " .. targetPlayer.Name .. " was taken down at a distance of " .. math.floor(distance) .. " studs!"
                            pcall(function()
                                if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
                                    TextChatService.TextChannels.RBXGeneral:SendAsync(message)
                                else
                                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
                                end
                            end)
                        end
                    end
                end
            end)
        end
    end)
end

createToggle("Kill Feed Chat Announcer", function(state)
    killFeedEnabled = state
    if killFeedEnabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= plr then trackKillFeed(p) end
        end
        Players.PlayerAdded:Connect(trackKillFeed)
    end
end)
