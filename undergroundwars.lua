-- Modern Rayfield UI Library Setup
local Rayfield = loadstring(game:GetService("HttpService"):GetAsync('https://sirius.menu'))()

-- Script Notification (Runs instantly when executed)
Rayfield:Notify({
    Title = "Script Loaded!",
    Content = "Underground War 2.0 Hack is active and ready.",
    Duration = 5,
    Image = 4483362458,
})

-- Core Variables
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

-- Create Main Clean Window
local Window = Rayfield:CreateWindow({
    Name = "⚡ Underground War 2.0",
    LoadingTitle = "Loading System...",
    LoadingSubtitle = "by Rohannuman",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false
})

-- Create Clean Tabs
local MainTab = Window:CreateTab("Combat", 4483362458)
local MoveTab = Window:CreateTab("Movement Bypass", 4483424424)
local FunTab = Window:CreateTab("Visuals & Fun", 4483345906)

-- Helper Functions for Tools
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
                    if v ~= game.Players.LocalPlayer and v.TeamColor.Name ~= plr.TeamColor.Name and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChildOfClass"ForceField" == nil then
                        local Distance = (v.Character:FindFirstChildOfClass("Part").Position - game.Players.LocalPlayer.Character:FindFirstChildOfClass("Part").Position).magnitude
                        if Distance <= reach then
                            for i = 1, 25 do
                                if not loop then break end
                                plr.Character.Humanoid.RootPart.CFrame = v.Character.Humanoid.RootPart.CFrame * CFrame.new(-1.6, 0, 1.8)
                                local h = getTool()
                                if h then
                                    h.Parent = plr.Character
                                    h:Activate()
                                    if plr.Character:FindFirstChildOfClass"Tool".Name ~= getTool().Name then
                                        plr.Character:FindFirstChildOfClass"Humanoid":UnequipTools()
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
                    if v ~= game.Players.LocalPlayer and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChildOfClass"ForceField" == nil then
                        local Distance = (v.Character:FindFirstChildOfClass("Part").Position - game.Players.LocalPlayer.Character:FindFirstChildOfClass("Part").Position).magnitude
                        if Distance <= reach then
                            for i = 1, 25 do
                                if not loop then break end
                                plr.Character.Humanoid.RootPart.CFrame = v.Character.Humanoid.RootPart.CFrame * CFrame.new(-1.6, 0, 1.8)
                                local h = getTool()
                                if h then
                                    h.Parent = plr.Character
                                    h:Activate()
                                    if plr.Character:FindFirstChildOfClass"Tool".Name ~= getTool().Name then
                                        plr.Character:FindFirstChildOfClass"Humanoid":UnequipTools()
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

-- ==================== TAB 1: COMBAT DESIGN ====================
MainTab:CreateSection("Kill Aura Settings")

local AuraToggle = MainTab:CreateToggle({
    Name = "Enable Kill Aura",
    CurrentValue = false,
    Flag = "KillAuraToggle",
    Callback = function(Value)
        loop = Value
        retry = Value
        if Value then task.spawn(KillAura) end
    end,
})

local ModeDropdown = MainTab:CreateDropdown({
    Name = "Target Mode",
    Options = {"Enemies Only", "Everyone"},
    CurrentOption = {"Enemies Only"},
    MultipleOptions = false,
    Flag = "TargetMode",
    Callback = function(Option)
        if Option == "Enemies Only" then _G.enemOnly = true else _G.enemOnly = false end
    end,
})

local ReachSlider = MainTab:CreateSlider({
    Name = "Attack Reach",
    Min = 10,
    Max = 150,
    CurrentValue = 150,
    Flag = "ReachSlider",
    Callback = function(Value) reach = Value end,
})

-- ==================== TAB 2: SPEED BYPASS DESIGN ====================
MoveTab:CreateSection("Velocity & CFrame Bypasses")

local SpeedToggle = MoveTab:CreateToggle({
    Name = "CFrame Speed Bypass",
    CurrentValue = false,
    Flag = "CFrameSpeedToggle",
    Callback = function(state)
        speedBypassEnabled = state
        if speedBypassEnabled then
            cframeLoopConnection = game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
                pcall(function()
                    local character = plr.Character
                    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                    if rootPart and humanoid and humanoid.MoveDirection.Magnitude > 0 then
                        local newPosition = rootPart.Position + (humanoid.MoveDirection * (customSpeedValue - humanoid.WalkSpeed) * deltaTime)
                        rootPart.CFrame = CFrame.new(newPosition) * CFrame.Angles(rootPart.CFrame:ToEulerAnglesXYZ())
                    end
                end)
            end)
        else
            if cframeLoopConnection then
                cframeLoopConnection:Disconnect()
                cframeLoopConnection = nil
            end
        end
    end,
})

local SpeedSlider = MoveTab:CreateSlider({
    Name = "Bypass Speed Mult",
    Min = 16,
    Max = 120,
    CurrentValue = 50,
    Flag = "BypassSpeedSlider",
    Callback = function(value) customSpeedValue = value end,
})

-- ==================== TAB 3: VISUALS & FUN ====================
FunTab:CreateSection("Custom Tags & Chat Settings")

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

FunTab:CreateToggle({
    Name = "Overhead Custom Tags",
    CurrentValue = false,
    Flag = "CustomTagsToggle",
    Callback = function(state)
        customTagsEnabled = state
        if customTagsEnabled then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= plr then manageTags(p) end
            end
            Players.PlayerAdded:Connect(function(p)
                if customTagsEnabled then manageTags(p) end
            end)
        end
    end,
})

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

FunTab:CreateToggle({
    Name = "Kill Feed Chat Announcer",
    CurrentValue = false,
    Flag = "KillFeedToggle",
    Callback = function(state)
        killFeedEnabled = state
        if killFeedEnabled then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= plr then trackKillFeed(p) end
            end
            Players.PlayerAdded:Connect(trackKillFeed)
        end
    end,
})
