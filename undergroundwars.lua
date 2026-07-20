local Players = game.Players
local plr = Players.LocalPlayer
local loop = true
local retry = true
_G.name = "sword"
_G.enemOnly = true
local reach = 150

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/turtle"))()

local Window = library:Window("KillAura")

function findTool(String)
    local strl = String:lower()
    for i,v in pairs(plr.Backpack:GetChildren()) do
       if v.Name:lower():match(strl) ~= nil then
          return v
          end
       end
    for i,v in pairs(plr.Character:GetChildren()) do
       if v.Name:lower():match(strl) ~= nil then
          return v
          end
       end
    end

function getTool()
    return findTool(_G.name)
   
end

function KillAura()
    loop = true
    if _G.enemOnly == true then
    repeat
    for i,v in pairs(game.Players:GetPlayers()) do
	pcall(function()
	if v ~= game.Players.LocalPlayer and v.TeamColor.Name ~= plr.TeamColor.Name and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChildOfClass"ForceField" == nil then
	
	local Distance = (v.Character:FindFirstChildOfClass("Part").Position - game.Players.LocalPlayer.Character:FindFirstChildOfClass("Part").Position).magnitude
	if Distance <= reach then
	for i = 1,25 do
    plr.Character.Humanoid.RootPart.CFrame = v.Character.Humanoid.RootPart.CFrame * CFrame.new(-1.6,0,1.8)
    local h = getTool()
    h.Parent = plr.Character
    h:Activate()
    if plr.Character:FindFirstChildOfClass"Tool".Name ~= getTool().Name then
        plr.Character:FindFirstChildOfClass"Humanoid":UnequipTools()
        end
    if v.Character.Humanoid.Health <= 0 then
    loop = false
    if retry == true then
    wait(1)
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
    for i,v in pairs(game.Players:GetPlayers()) do
	pcall(function()
	if v ~= game.Players.LocalPlayer and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChildOfClass"ForceField" == nil then
	
	local Distance = (v.Character:FindFirstChildOfClass("Part").Position - game.Players.LocalPlayer.Character:FindFirstChildOfClass("Part").Position).magnitude
	if Distance <= reach then
	for i = 1,25 do
    plr.Character.Humanoid.RootPart.CFrame = v.Character.Humanoid.RootPart.CFrame * CFrame.new(-1.6,0,1.8)
    local h = getTool()
    h.Parent = plr.Character
    h:Activate()
    if plr.Character:FindFirstChildOfClass"Tool".Name ~= getTool().Name then
        plr.Character:FindFirstChildOfClass"Humanoid":UnequipTools()
        end
    if v.Character.Humanoid.Health <= 0 then
    loop = false
    if retry == true then
    wait(1)
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

  local function notify(Title, Text, Duration)
     Text = Text or "Text" 
     Title= Title or "Title"
     Duration = Duration or 5
    game:GetService("StarterGui"):SetCore("SendNotification",{
 Title = Title, 
 Text = Text,
 Duration = Duration,
})
    end

Window:Button("On", function()
    loop = true
    retry = true
    KillAura()
    
end)

Window:Button("Off", function()
    loop = false
    retry = false
    
    loop = false
    retry = false    
end)

Window:Box("Reach - 150", function(text, focuslost)
   if focuslost then
   local num = tonumber(text)
   if not num then
    notify("Error", "Please enter a valid number for reach.")
   elseif num < 10 then
    reach = 10
    notify("Minimum", "The minimum reach is 10, current reach: "..reach)
   elseif num > 150 then
    reach = 150
    notify("Maximum", "The maximum reach is 150, current reach: "..reach)
   else
    reach = num
    notify("Reach Updated", "Current reach set to: "..reach)
   end
   end
end)

local dropdown = Window:Dropdown("Mode", {"enemies only", "others"}, function(o)
    if o == "enemies only" then
    _G.enemOnly = true
    elseif o == "others" then
    _G.enemOnly = false
    end
end)
