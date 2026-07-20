-- Modern Rayfield UI Library Setup
local Rayfield = loadstring(game:HttpGet('https://sirius.menu'))()

-- Script Notification (Runs instantly when executed)
Rayfield:Notify({
    Title = "Script Loaded!",
    Content = "Underground War 2.0 Hack is active and ready.",
    Duration = 5,
    Image = 4483362458, -- Built-in checkmark icon
})

-- Core Variables
local Players = game.Players
local plr = Players.LocalPlayer
local loop = false 
local retry = false
_G.name = "sword"
_G.enemOnly = true
local reach = 150

-- Create Main Clean Window
local Window = Rayfield:CreateWindow({
    Name = "⚡ Underground War 2.0",
    LoadingTitle = "Loading System...",
    LoadingSubtitle = "by Rohannuman",
    ConfigurationSaving = {
        Enabled = false
    },
    KeySystem = false
})

-- Create a Clean Main Tab
local MainTab = Window:CreateTab("Combat", 4483362458) -- Weapon/Combat Icon

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

-- Clean UI Section Header
MainTab:CreateSection("Kill Aura Settings")

-- Modernized Toggle Switch for KillAura (Replaces separate On/Off buttons)
local AuraToggle = MainTab:CreateToggle({
    Name = "Enable Kill Aura",
    CurrentValue = false,
    Flag = "KillAuraToggle",
    Callback = function(Value)
        loop = Value
        retry = Value
        if Value then
            task.spawn(KillAura) -- Runs function in background safely without freezing UI
        end
    end,
})

-- Clean Dropdown Menu
local ModeDropdown = MainTab:CreateDropdown({
    Name = "Target Mode",
    Options = {"Enemies Only", "Everyone"},
    CurrentOption = {"Enemies Only"},
    MultipleOptions = false,
    Flag = "TargetMode",
    Callback = function(Option)
        if typeof(Option) == "table" then Option = Option[1] end -- Handle structural array formatting safely
        if Option == "Enemies Only" then
            _G.enemOnly = true
        else
            _G.enemOnly = false
        end
    end,
})

-- Modern Dynamic Slider (Replaces the old typing text box for reach)
local ReachSlider = MainTab:CreateSlider({
    Name = "Attack Reach",
    Min = 10,
    Max = 150,
    CurrentValue = 150,
    Flag = "ReachSlider",
    Callback = function(Value)
        reach = Value
    end,
})
