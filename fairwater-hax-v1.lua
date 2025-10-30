--// Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--// Create Main Window
local Window = Rayfield:CreateWindow({
   Name = "fairwater hax v1",
   Icon = 0,
   LoadingTitle = "loading lmao",
   LoadingSubtitle = "pluh",
   ShowText = "fairwater hax v1",
   Theme = "DarkTheme",
   ToggleUIKeybind = Enum.KeyCode.RightShift,

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "fairwater",
      FileName = "fairwater_config"
   },
})

--// Create Main Tab
local MainTab = Window:CreateTab("main", 4483362458)

--// WalkSpeed Slider
MainTab:CreateSlider({
   Name = "walkspeed",
   Range = {16, 100},
   Increment = 1,
   Suffix = "speed",
   CurrentValue = 16,
   Flag = "WalkSpeedSlider",
   Callback = function(Value)
      local player = game.Players.LocalPlayer
      if player and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
         player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Value
      end
   end,
})

--// Delete SFWall Button
MainTab:CreateButton({
   Name = "delete sfwall",
   Callback = function()
      local wall = workspace:FindFirstChild("SFWall")
      if wall then
         wall:Destroy()
         Rayfield:Notify({
            Title = "success",
            Content = "sfwall deleted",
            Duration = 3,
         })
      else
         Rayfield:Notify({
            Title = "failed",
            Content = "sfwall not found",
            Duration = 3,
         })
      end
   end,
})

--// Get Jacket Button
MainTab:CreateButton({
   Name = "get jacket",
   Callback = function()
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local hrp = char:WaitForChild("HumanoidRootPart")

      local originalCFrame = hrp.CFrame
      hrp.CFrame = CFrame.new(-205.28, 41.12, -131.70)
      task.wait(0.1)
      hrp.CFrame = originalCFrame

      Rayfield:Notify({
         Title = "jacket retrieved",
         Content = "teleported to jacket and back",
         Duration = 3,
      })
   end,
})

--// Reset Character Button
MainTab:CreateButton({
   Name = "reset character",
   Callback = function()
      local player = game.Players.LocalPlayer
      if player and player.Character then
         player.Character:BreakJoints()
         Rayfield:Notify({
            Title = "reset",
            Content = "character reset",
            Duration = 3,
         })
      end
   end,
})

--// Dex Button
MainTab:CreateButton({
   Name = "dex",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
      Rayfield:Notify({
         Title = "dex loaded",
         Content = "dark dex v3 injected",
         Duration = 4,
      })
   end,
})

--// Chat Log System
local ChatLogs = {}
local ChatLogEnabled = false
local ChatLogWindow = nil

local function createChatLogWindow()
   local screenGui = Instance.new("ScreenGui")
   screenGui.Name = "ChatLogWindow"
   screenGui.ResetOnSpawn = false
   screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
   
   local mainFrame = Instance.new("Frame")
   mainFrame.Name = "MainFrame"
   mainFrame.Size = UDim2.new(0, 500, 0, 400)
   mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
   mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
   mainFrame.BorderSizePixel = 1
   mainFrame.BorderColor3 = Color3.fromRGB(100, 100, 150)
   mainFrame.Parent = screenGui
   
   local dragging = false
   local dragStart = nil
   local startPos = nil
   
   mainFrame.InputBegan:Connect(function(input)
      if input.UserInputType == Enum.UserInputType.MouseButton1 then
         dragging = true
         dragStart = input.Position
         startPos = mainFrame.Position
      end
   end)
   
   mainFrame.InputChanged:Connect(function(input)
      if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
         local delta = input.Position - dragStart
         mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
      end
   end)
   
   mainFrame.InputEnded:Connect(function(input)
      if input.UserInputType == Enum.UserInputType.MouseButton1 then
         dragging = false
      end
   end)
   
   local titleBar = Instance.new("Frame")
   titleBar.Name = "TitleBar"
   titleBar.Size = UDim2.new(1, 0, 0, 30)
   titleBar.Position = UDim2.new(0, 0, 0, 0)
   titleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
   titleBar.BorderSizePixel = 0
   titleBar.Parent = mainFrame
   
   local titleLabel = Instance.new("TextLabel")
   titleLabel.Name = "TitleLabel"
   titleLabel.Size = UDim2.new(1, -30, 1, 0)
   titleLabel.Position = UDim2.new(0, 5, 0, 0)
   titleLabel.BackgroundTransparency = 1
   titleLabel.Text = "fairwater chat log"
   titleLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
   titleLabel.TextScaled = true
   titleLabel.Font = Enum.Font.GothamBold
   titleLabel.TextXAlignment = Enum.TextXAlignment.Left
   titleLabel.Parent = titleBar
   
   local closeButton = Instance.new("TextButton")
   closeButton.Name = "CloseButton"
   closeButton.Size = UDim2.new(0, 25, 0, 25)
   closeButton.Position = UDim2.new(1, -30, 0, 2.5)
   closeButton.BackgroundColor3 = Color3.fromRGB(150, 50, 100)
   closeButton.BorderSizePixel = 1
   closeButton.BorderColor3 = Color3.fromRGB(200, 100, 150)
   closeButton.Text = "x"
   closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
   closeButton.TextScaled = true
   closeButton.Font = Enum.Font.GothamBold
   closeButton.Parent = titleBar
   
   closeButton.MouseButton1Click:Connect(function()
      screenGui:Destroy()
      ChatLogWindow = nil
   end)
   
   local searchFrame = Instance.new("Frame")
   searchFrame.Name = "SearchFrame"
   searchFrame.Size = UDim2.new(1, -10, 0, 30)
   searchFrame.Position = UDim2.new(0, 5, 0, 35)
   searchFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
   searchFrame.BorderSizePixel = 1
   searchFrame.BorderColor3 = Color3.fromRGB(80, 80, 120)
   searchFrame.Parent = mainFrame
   
   local searchBox = Instance.new("TextBox")
   searchBox.Name = "SearchBox"
   searchBox.Size = UDim2.new(1, -10, 1, -5)
   searchBox.Position = UDim2.new(0, 5, 0, 2.5)
   searchBox.BackgroundTransparency = 1
   searchBox.Text = "search chat..."
   searchBox.TextColor3 = Color3.fromRGB(180, 180, 220)
   searchBox.TextScaled = true
   searchBox.Font = Enum.Font.Gotham
   searchBox.TextXAlignment = Enum.TextXAlignment.Left
   searchBox.Parent = searchFrame
   
   local chatFrame = Instance.new("ScrollingFrame")
   chatFrame.Name = "ChatFrame"
   chatFrame.Size = UDim2.new(1, -10, 1, -110)
   chatFrame.Position = UDim2.new(0, 5, 0, 70)
   chatFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
   chatFrame.BorderSizePixel = 1
   chatFrame.BorderColor3 = Color3.fromRGB(60, 60, 100)
   chatFrame.ScrollBarThickness = 8
   chatFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 150)
   chatFrame.Parent = mainFrame
   
   local filterFrame = Instance.new("Frame")
   filterFrame.Name = "FilterFrame"
   filterFrame.Size = UDim2.new(1, -10, 0, 30)
   filterFrame.Position = UDim2.new(0, 5, 1, -35)
   filterFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
   filterFrame.BorderSizePixel = 1
   filterFrame.BorderColor3 = Color3.fromRGB(80, 80, 120)
   filterFrame.Parent = mainFrame
   
   local allButton = Instance.new("TextButton")
   allButton.Name = "AllButton"
   allButton.Size = UDim2.new(0.25, -2.5, 1, -5)
   allButton.Position = UDim2.new(0, 2.5, 0, 2.5)
   allButton.BackgroundColor3 = Color3.fromRGB(80, 80, 150)
   allButton.BorderSizePixel = 1
   allButton.BorderColor3 = Color3.fromRGB(120, 120, 200)
   allButton.Text = "all"
   allButton.TextColor3 = Color3.fromRGB(255, 255, 255)
   allButton.TextScaled = true
   allButton.Font = Enum.Font.Gotham
   allButton.Parent = filterFrame
   
   local teamButton = Instance.new("TextButton")
   teamButton.Name = "TeamButton"
   teamButton.Size = UDim2.new(0.25, -2.5, 1, -5)
   teamButton.Position = UDim2.new(0.25, 2.5, 0, 2.5)
   teamButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
   teamButton.BorderSizePixel = 1
   teamButton.BorderColor3 = Color3.fromRGB(80, 80, 120)
   teamButton.Text = "team"
   teamButton.TextColor3 = Color3.fromRGB(200, 200, 255)
   teamButton.TextScaled = true
   teamButton.Font = Enum.Font.Gotham
   teamButton.Parent = filterFrame
   
   local systemButton = Instance.new("TextButton")
   systemButton.Name = "SystemButton"
   systemButton.Size = UDim2.new(0.25, -2.5, 1, -5)
   systemButton.Position = UDim2.new(0.5, 2.5, 0, 2.5)
   systemButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
   systemButton.BorderSizePixel = 1
   systemButton.BorderColor3 = Color3.fromRGB(80, 80, 120)
   systemButton.Text = "system"
   systemButton.TextColor3 = Color3.fromRGB(200, 200, 255)
   systemButton.TextScaled = true
   systemButton.Font = Enum.Font.Gotham
   systemButton.Parent = filterFrame
   
   local clearButton = Instance.new("TextButton")
   clearButton.Name = "ClearButton"
   clearButton.Size = UDim2.new(0.25, -2.5, 1, -5)
   clearButton.Position = UDim2.new(0.75, 2.5, 0, 2.5)
   clearButton.BackgroundColor3 = Color3.fromRGB(120, 50, 80)
   clearButton.BorderSizePixel = 1
   clearButton.BorderColor3 = Color3.fromRGB(160, 80, 120)
   clearButton.Text = "clear"
   clearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
   clearButton.TextScaled = true
   clearButton.Font = Enum.Font.Gotham
   clearButton.Parent = filterFrame
   
   local currentFilter = "All"
   
   local function updateChatDisplay()
      for _, child in pairs(chatFrame:GetChildren()) do
         if child:IsA("TextLabel") then
            child:Destroy()
         end
      end
      
      local yOffset = 0
      local searchTerm = searchBox.Text:lower()
      if searchTerm == "search chat..." then searchTerm = "" end
      
      for _, chatData in pairs(ChatLogs) do
         local shouldShow = false
         
         if currentFilter == "All" then
            shouldShow = true
         elseif currentFilter == "Team" and chatData.isTeam then
            shouldShow = true
         elseif currentFilter == "System" and chatData.isSystem then
            shouldShow = true
         end
         
         if shouldShow and searchTerm ~= "" then
            shouldShow = chatData.message:lower():find(searchTerm) or chatData.player:lower():find(searchTerm)
         end
         
         if shouldShow then
            local chatLabel = Instance.new("TextLabel")
            chatLabel.Size = UDim2.new(1, -10, 0, 20)
            chatLabel.Position = UDim2.new(0, 5, 0, yOffset)
            chatLabel.BackgroundTransparency = 1
            chatLabel.Text = chatData.fullText
            chatLabel.TextColor3 = chatData.color
            chatLabel.TextScaled = true
            chatLabel.Font = Enum.Font.Gotham
            chatLabel.TextXAlignment = Enum.TextXAlignment.Left
            chatLabel.Parent = chatFrame
            
            yOffset = yOffset + 25
         end
      end
      
      chatFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
      chatFrame.CanvasPosition = Vector2.new(0, chatFrame.CanvasSize.Y.Offset)
   end
   
   searchBox.FocusLost:Connect(function()
      updateChatDisplay()
   end)
   
   searchBox.Focused:Connect(function()
      if searchBox.Text == "search chat..." then
         searchBox.Text = ""
      end
   end)
   
   allButton.MouseButton1Click:Connect(function()
      currentFilter = "All"
      allButton.BackgroundColor3 = Color3.fromRGB(80, 80, 150)
      teamButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
      systemButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
      updateChatDisplay()
   end)
   
   teamButton.MouseButton1Click:Connect(function()
      currentFilter = "Team"
      allButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
      teamButton.BackgroundColor3 = Color3.fromRGB(80, 80, 150)
      systemButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
      updateChatDisplay()
   end)
   
   systemButton.MouseButton1Click:Connect(function()
      currentFilter = "System"
      allButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
      teamButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
      systemButton.BackgroundColor3 = Color3.fromRGB(80, 80, 150)
      updateChatDisplay()
   end)
   
   clearButton.MouseButton1Click:Connect(function()
      ChatLogs = {}
      updateChatDisplay()
   end)
   
   ChatLogWindow = {
      screenGui = screenGui,
      updateDisplay = updateChatDisplay
   }
   
   updateChatDisplay()
end

local function logChat(player, message, messageType)
   if not ChatLogEnabled then return end
   
   local timestamp = os.date("[%H:%M:%S]")
   local isTeam = messageType == "Team"
   local isSystem = messageType == "System"
   local color = Color3.fromRGB(220, 220, 255)
   
   if isTeam then
      color = Color3.fromRGB(150, 255, 200)
   elseif isSystem then
      color = Color3.fromRGB(255, 220, 150)
   end
   
   local fullText = timestamp .. " [" .. (messageType or "All") .. "] " .. player .. ": " .. message
   
   table.insert(ChatLogs, {
      player = player,
      message = message,
      fullText = fullText,
      timestamp = timestamp,
      isTeam = isTeam,
      isSystem = isSystem,
      color = color
   })
   
   if #ChatLogs > 200 then
      table.remove(ChatLogs, 1)
   end
   
   if ChatLogWindow then
      ChatLogWindow.updateDisplay()
   end
end

game.Players.PlayerAdded:Connect(function(player)
   player.Chatted:Connect(function(message)
      logChat(player.Name, message, "All")
   end)
end)

for _, player in pairs(game.Players:GetPlayers()) do
   player.Chatted:Connect(function(message)
      logChat(player.Name, message, "All")
   end)
end

--// Chat Log Button
MainTab:CreateButton({
   Name = "chat log",
   Callback = function()
      ChatLogEnabled = true
      if not ChatLogWindow then
         createChatLogWindow()
         Rayfield:Notify({
            Title = "chat log opened",
            Content = "chat logging enabled",
            Duration = 3,
         })
      else
         Rayfield:Notify({
            Title = "chat log",
            Content = "chat log window already open",
            Duration = 2,
         })
      end
   end,
})

--// Bypass Tag System
local BypassEnabled = false
local bypassWords = {
   ["hoe"] = "h0e",
   ["damn"] = "d4mn", 
   ["shit"] = "sh1t",
   ["fuck"] = "f*ck",
   ["bitch"] = "b1tch",
   ["ass"] = "a$$",
   ["hell"] = "h3ll",
   ["gay"] = "g4y",
   ["stupid"] = "stup1d",
   ["idiot"] = "1diot",
   ["retard"] = "r3tard",
   ["kill"] = "k1ll",
   ["die"] = "d1e",
   ["noob"] = "n00b",
   ["loser"] = "l0ser",
   ["fat"] = "f4t",
   ["ugly"] = "ugl7",
   ["hate"] = "h4te",
   ["suck"] = "suk",
   ["wtf"] = "wt7",
   ["stfu"] = "stf*",
   ["shut up"] = "shut *p",
   ["kys"] = "k7s",
   ["discord"] = "d1scord",
   ["youtube"] = "y0utube",
   ["roblox"] = "r0blox"
}

local function bypassText(text)
   if not BypassEnabled then return text end
   
   local result = text:lower()
   for word, replacement in pairs(bypassWords) do
      result = result:gsub(word, replacement)
   end
   
   return result
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local originalChat = nil
if ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") then
   local chatEvents = ReplicatedStorage.DefaultChatSystemChatEvents
   if chatEvents:FindFirstChild("SayMessageRequest") then
      originalChat = chatEvents.SayMessageRequest
   end
end

--// Bypass Toggle
MainTab:CreateToggle({
   Name = "bypass tags",
   CurrentValue = false,
   Flag = "BypassTagsToggle",
   Callback = function(Value)
      BypassEnabled = Value
      if Value then
         Rayfield:Notify({
            Title = "bypass enabled",
            Content = "messages will be bypassed",
            Duration = 3,
         })
      else
         Rayfield:Notify({
            Title = "bypass disabled", 
            Content = "normal chat restored",
            Duration = 2,
         })
      end
   end,
})

--// Disguise Button
MainTab:CreateButton({
   Name = "disguise",
   Callback = function()
      local Players = game:GetService("Players")
      local players = {}
      
      for _, player in pairs(Players:GetPlayers()) do
         if player ~= Players.LocalPlayer then
            table.insert(players, player)
         end
      end
      
      if #players == 0 then
         Rayfield:Notify({
            Title = "no players",
            Content = "no other players found to disguise as",
            Duration = 3,
         })
         return
      end
      
      local randomPlayer = players[math.random(1, #players)]
      local disguiseCommand = "!name " .. randomPlayer.Name
      
      if game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents") then
         local chatEvents = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents
         if chatEvents:FindFirstChild("SayMessageRequest") then
            chatEvents.SayMessageRequest:FireServer(disguiseCommand, "All")
         end
      end
      
      Rayfield:Notify({
         Title = "disguise applied",
         Content = "disguised as: " .. randomPlayer.Name,
         Duration = 4,
      })
   end,
})

--// Create Inject Tab
local InjectTab = Window:CreateTab("inject", 4483362458)

--// Infinite Yield Button
InjectTab:CreateButton({
   Name = "inject infinite yield",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
      Rayfield:Notify({
         Title = "injection complete",
         Content = "infinite yield injected",
         Duration = 4,
      })
   end,
})

--// Create Fun Tab
local FunTab = Window:CreateTab("fun", 4483362458)

--// TP to Random Teacher Button
FunTab:CreateButton({
   Name = "tp to random teacher",
   Callback = function()
      local Players = game:GetService("Players")
      local staffPlayers = {}

      for _, plr in pairs(Players:GetPlayers()) do
         if plr.Team and plr.Team.Name == "Staff" and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            table.insert(staffPlayers, plr)
         end
      end

      if #staffPlayers == 0 then
         Rayfield:Notify({
            Title = "no teachers found",
            Content = "no staff team players found",
            Duration = 3,
         })
         return
      end

      local target = staffPlayers[math.random(1, #staffPlayers)]
      local localPlayer = Players.LocalPlayer
      local myChar = localPlayer.Character or localPlayer.CharacterAdded:Wait()
      local myHRP = myChar:WaitForChild("HumanoidRootPart")

      myHRP.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(2, 0, 0)
      Rayfield:Notify({
         Title = "teleported",
         Content = "teleported to: " .. target.Name,
         Duration = 3,
      })
   end,
})

--// Give Jerk Tool Button
FunTab:CreateButton({
   Name = "give jerk tool",
   Callback = function()
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local humanoid = char:WaitForChild("Humanoid")
      
      local tool = Instance.new("Tool")
      tool.Name = "jerk tool"
      tool.RequiresHandle = false
      
      local animationId = "rbxassetid://148840371"
      
      local function createAnimation()
         local animation = Instance.new("Animation")
         animation.AnimationId = animationId
         return animation
      end
      
      local animTrack = nil
      
      tool.Activated:Connect(function()
         if animTrack then
            animTrack:Stop()
         end
         
         local anim = createAnimation()
         animTrack = humanoid:LoadAnimation(anim)
         animTrack.Looped = true
         animTrack:Play()
         animTrack:AdjustSpeed(2)
         
         Rayfield:Notify({
            Title = "animation started",
            Content = "jerk animation activated",
            Duration = 2,
         })
      end)
      
      tool.Deactivated:Connect(function()
         if animTrack then
            animTrack:Stop()
            animTrack = nil
         end
      end)
      
      tool.Parent = player.Backpack
      
      Rayfield:Notify({
         Title = "tool given",
         Content = "jerk tool added to backpack",
         Duration = 3,
      })
   end,
})

--// Activate Avocor Boards Button
FunTab:CreateButton({
   Name = "activate avocor boards",
   Callback = function()
      local activatedCount = 0
      local foundBoards = 0
      local debugInfo = {}
      
      for _, obj in pairs(workspace:GetDescendants()) do
         if obj.Name == "Avocor S-Series Board" then
            foundBoards = foundBoards + 1
            table.insert(debugInfo, "found avocor board: " .. obj:GetFullName())
            
            local screen = obj:FindFirstChild("Screen")
            if screen then
               table.insert(debugInfo, "found screen in: " .. obj.Name)
               
               local interface = screen:FindFirstChild("Interface")
               if interface then
                  table.insert(debugInfo, "found interface in: " .. obj.Name .. " -> screen")
                  
                  if interface:IsA("BoolValue") then
                     interface.Value = true
                     activatedCount = activatedCount + 1
                     table.insert(debugInfo, "activated interface (boolvalue): " .. tostring(interface.Value))
                  elseif interface:IsA("IntValue") then
                     interface.Value = 1
                     activatedCount = activatedCount + 1
                     table.insert(debugInfo, "activated interface (intvalue): " .. interface.Value)
                  elseif interface:IsA("StringValue") then
                     interface.Value = "true"
                     activatedCount = activatedCount + 1
                     table.insert(debugInfo, "activated interface (stringvalue): " .. interface.Value)
                  end
                  
                  local activationTargets = {"active", "Active", "enabled", "Enabled", "on", "On", "power", "Power", "state", "State"}
                  
                  for _, target in pairs(activationTargets) do
                     local prop = interface:FindFirstChild(target)
                     if prop then
                        table.insert(debugInfo, "found property: " .. target .. " (type: " .. prop.ClassName .. ")")
                        if prop:IsA("BoolValue") then
                           local oldValue = prop.Value
                           prop.Value = true
                           activatedCount = activatedCount + 1
                           table.insert(debugInfo, "activated " .. target .. " (boolvalue): " .. tostring(oldValue) .. " -> " .. tostring(prop.Value))
                        elseif prop:IsA("IntValue") then
                           local oldValue = prop.Value
                           prop.Value = 1
                           activatedCount = activatedCount + 1
                           table.insert(debugInfo, "activated " .. target .. " (intvalue): " .. oldValue .. " -> " .. prop.Value)
                        elseif prop:IsA("StringValue") then
                           local oldValue = prop.Value
                           prop.Value = "true"
                           activatedCount = activatedCount + 1
                           table.insert(debugInfo, "activated " .. target .. " (stringvalue): " .. oldValue .. " -> " .. prop.Value)
                        end
                     end
                  end
                  
                  for _, child in pairs(interface:GetChildren()) do
                     table.insert(debugInfo, "interface child: " .. child.Name .. " (type: " .. child.ClassName .. ")")
                     if child:IsA("BoolValue") then
                        local oldValue = child.Value
                        child.Value = true
                        activatedCount = activatedCount + 1
                        table.insert(debugInfo, "activated " .. child.Name .. " (boolvalue): " .. tostring(oldValue) .. " -> " .. tostring(child.Value))
                     elseif child:IsA("IntValue") then
                        local oldValue = child.Value
                        child.Value = 1
                        activatedCount = activatedCount + 1
                        table.insert(debugInfo, "activated " .. child.Name .. " (intvalue): " .. oldValue .. " -> " .. child.Value)
                     elseif child:IsA("StringValue") then
                        local oldValue = child.Value
                        child.Value = "active"
                        activatedCount = activatedCount + 1
                        table.insert(debugInfo, "activated " .. child.Name .. " (stringvalue): " .. oldValue .. " -> " .. child.Value)
                     elseif child.ClassName == "CanvasGroup" or child.ClassName == "Frame" or child.ClassName == "Container" then
                        pcall(function()
                           if child:FindFirstChild("Visible") then
                              child.Visible = true
                              activatedCount = activatedCount + 1
                              table.insert(debugInfo, "activated " .. child.Name .. " container - set visible = true")
                           elseif child:GetAttribute("Active") ~= nil then
                              child:SetAttribute("Active", true)
                              activatedCount = activatedCount + 1
                              table.insert(debugInfo, "activated " .. child.Name .. " container - set active attribute = true")
                           else
                              activatedCount = activatedCount + 1
                              table.insert(debugInfo, "activated " .. child.Name .. " container - interface structure detected")
                           end
                        end)
                     end
                  end
               else
                  table.insert(debugInfo, "no interface found in screen of: " .. obj.Name)
               end
            else
               table.insert(debugInfo, "no screen found in: " .. obj.Name)
            end
         end
      end
      
      for _, obj in pairs(workspace:GetDescendants()) do
         if obj.Name == "Interface" and obj.Parent and obj.Parent.Name == "Screen" and obj.Parent.Parent and obj.Parent.Parent.Name:find("Avocor") then
            table.insert(debugInfo, "found standalone interface: " .. obj:GetFullName())
            if obj:IsA("BoolValue") then
               obj.Value = true
               activatedCount = activatedCount + 1
               table.insert(debugInfo, "activated standalone interface (boolvalue)")
            end
         end
      end
      
      if activatedCount > 0 then
         Rayfield:Notify({
            Title = "avocor activated",
            Content = "activated " .. activatedCount .. " components across " .. foundBoards .. " boards",
            Duration = 4,
         })
      else
         local message = foundBoards > 0 and 
            "found " .. foundBoards .. " avocor boards but couldnt activate interface" or
            "no avocor boards found"
         
         Rayfield:Notify({
            Title = "activation status",
            Content = message,
            Duration = 4,
         })
      end
      
      print("=== avocor board activation debug ===")
      for _, info in pairs(debugInfo) do
         print(info)
      end
      print("=== summary ===")
      print("avocor boards found: " .. foundBoards)
      print("total activations: " .. activatedCount)
      print("=== end debug ===")
   end,
})

--// Welcome Notification
Rayfield:Notify({
   Title = "fairwater loaded",
   Content = "all tabs active: main, inject, fun, universal, teleport",
   Duration = 6,
})

if not Window then
    return
end

--// Create Universal Tab
local UniversalTab = Window:CreateTab("universal", 4483362458)

--// Create Teleport Tab
local TeleportTab = Window:CreateTab("teleport", 4483362458)

--// misc teleports
TeleportTab:CreateButton({
   Name = "spawn",
   Callback = function()
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local hrp = char:WaitForChild("HumanoidRootPart")
      hrp.CFrame = CFrame.new(-326, 10, 130)
      Rayfield:Notify({Title = "teleported", Content = "teleported to spawn", Duration = 2})
   end,
})

TeleportTab:CreateButton({
   Name = "first gate",
   Callback = function()
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local hrp = char:WaitForChild("HumanoidRootPart")
      hrp.CFrame = CFrame.new(-277, 11, 60)
      Rayfield:Notify({Title = "teleported", Content = "teleported to first gate", Duration = 2})
   end,
})

TeleportTab:CreateButton({
   Name = "second gate (front)",
   Callback = function()
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local hrp = char:WaitForChild("HumanoidRootPart")
      hrp.CFrame = CFrame.new(-193, 14, -58)
      Rayfield:Notify({Title = "teleported", Content = "teleported to second gate", Duration = 2})
   end,
})

TeleportTab:CreateButton({
   Name = "second gate (at school)",
   Callback = function()
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local hrp = char:WaitForChild("HumanoidRootPart")
      hrp.CFrame = CFrame.new(-190, 14, -68)
      Rayfield:Notify({Title = "teleported", Content = "teleported to second gate", Duration = 2})
   end,
})

TeleportTab:CreateButton({
   Name = "front doors (in school)",
   Callback = function()
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local hrp = char:WaitForChild("HumanoidRootPart")
      hrp.CFrame = CFrame.new(-182, 14, -180)
      Rayfield:Notify({Title = "teleported", Content = "teleported to front doors", Duration = 2})
   end,
})

TeleportTab:CreateButton({
   Name = "drama studio (103)",
   Callback = function()
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local hrp = char:WaitForChild("HumanoidRootPart")
      hrp.CFrame = CFrame.new(-234, 14, -270)
      Rayfield:Notify({Title = "teleported", Content = "teleported to drama studio", Duration = 2})
   end,
})

TeleportTab:CreateButton({
   Name = "cafeteria",
   Callback = function()
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local hrp = char:WaitForChild("HumanoidRootPart")
      hrp.CFrame = CFrame.new(-131, 27, -245)
      Rayfield:Notify({Title = "teleported", Content = "teleported to cafeteria", Duration = 2})
   end,
})

TeleportTab:CreateButton({
   Name = "assembly hall",
   Callback = function()
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local hrp = char:WaitForChild("HumanoidRootPart")
      hrp.CFrame = CFrame.new(-187, 14, -219)
      Rayfield:Notify({Title = "teleported", Content = "teleported to assembly hall", Duration = 2})
   end,
})

TeleportTab:CreateButton({
   Name = "assembly hall stage",
   Callback = function()
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local hrp = char:WaitForChild("HumanoidRootPart")
      hrp.CFrame = CFrame.new(-197, 15, -246)
      Rayfield:Notify({Title = "teleported", Content = "teleported to stage", Duration = 2})
   end,
})

TeleportTab:CreateButton({
   Name = "roof",
   Callback = function()
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local hrp = char:WaitForChild("HumanoidRootPart")
      hrp.CFrame = CFrame.new(-171, 59, -192)
      Rayfield:Notify({Title = "teleported", Content = "teleported to roof", Duration = 2})
   end,
})

TeleportTab:CreateButton({
   Name = "garden",
   Callback = function()
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local hrp = char:WaitForChild("HumanoidRootPart")
      hrp.CFrame = CFrame.new(-170, 14, -284)
      Rayfield:Notify({Title = "teleported", Content = "teleported to garden", Duration = 2})
   end,
})

TeleportTab:CreateButton({
   Name = "pe area",
   Callback = function()
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local hrp = char:WaitForChild("HumanoidRootPart")
      hrp.CFrame = CFrame.new(-62, 27, -91)
      Rayfield:Notify({Title = "teleported", Content = "teleported to pe area", Duration = 2})
   end,
})

TeleportTab:CreateButton({
   Name = "reception office (210)",
   Callback = function()
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local hrp = char:WaitForChild("HumanoidRootPart")
      hrp.CFrame = CFrame.new(-123, 27, -208)
      Rayfield:Notify({Title = "teleported", Content = "teleported to reception", Duration = 2})
   end,
})

TeleportTab:CreateButton({
   Name = "library (315)",
   Callback = function()
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local hrp = char:WaitForChild("HumanoidRootPart")
      hrp.CFrame = CFrame.new(-112, 41, -182)
      Rayfield:Notify({Title = "teleported", Content = "teleported to library", Duration = 2})
   end,
})

TeleportTab:CreateButton({
   Name = "staff room (317)",
   Callback = function()
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local hrp = char:WaitForChild("HumanoidRootPart")
      hrp.CFrame = CFrame.new(-210, 41, -160)
      Rayfield:Notify({Title = "teleported", Content = "teleported to staff room", Duration = 2})
   end,
})

--// noclip
local NoclipEnabled = false
UniversalTab:CreateToggle({
   Name = "noclip",
   CurrentValue = false,
   Flag = "NoclipToggle",
   Callback = function(Value)
      NoclipEnabled = Value
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local function noclipLoop()
         for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
               part.CanCollide = not NoclipEnabled
            end
         end
      end
      task.spawn(function()
         while NoclipEnabled do
            noclipLoop()
            task.wait(0.1)
         end
      end)
      noclipLoop()
   end,
})

--// bang system
local BangEnabled = false
local BangTarget = nil

local function selectRandomPlayer()
   local Players = game:GetService("Players")
   local plrs = {}
   for _, plr in pairs(Players:GetPlayers()) do
      if plr ~= Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
         table.insert(plrs, plr)
      end
   end
   if #plrs > 0 then
      return plrs[math.random(1, #plrs)]
   end
   return nil
end

local function performBang()
   if not BangTarget or not BangTarget.Character or not BangTarget.Character:FindFirstChild("HumanoidRootPart") then
      BangTarget = selectRandomPlayer()
      if not BangTarget then return end
   end
   
   local player = game.Players.LocalPlayer
   local char = player.Character or player.CharacterAdded:Wait()
   local hrp = char:WaitForChild("HumanoidRootPart")
   local targetHRP = BangTarget.Character.HumanoidRootPart
   
   local behindPos = targetHRP.CFrame * CFrame.new(0, 0, 2)
   hrp.CFrame = behindPos
   hrp.CFrame = behindPos * CFrame.new(0, 0, -1.5)
   task.wait(0.1)
   hrp.CFrame = behindPos
   task.wait(0.1)
end

UniversalTab:CreateToggle({
   Name = "auto bang",
   CurrentValue = false,
   Flag = "AutoBangToggle",
   Callback = function(Value)
      BangEnabled = Value
      if BangEnabled then
         BangTarget = selectRandomPlayer()
         if BangTarget then
            Rayfield:Notify({
               Title = "auto bang started",
               Content = "now banging: " .. BangTarget.Name,
               Duration = 3,
            })
         end
         task.spawn(function()
            while BangEnabled do
               performBang()
               task.wait(0.2)
            end
         end)
      else
         Rayfield:Notify({
            Title = "auto bang stopped",
            Content = "bang mode disabled",
            Duration = 2,
         })
      end
   end,
})

--// go to random player
UniversalTab:CreateButton({
   Name = "go to random player",
   Callback = function()
      local Players = game:GetService("Players")
      local plrs = {}
      for _, plr in pairs(Players:GetPlayers()) do
         if plr ~= Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            table.insert(plrs, plr)
         end
      end
      if #plrs == 0 then
         Rayfield:Notify({
            Title = "no players found",
            Content = "no other players available",
            Duration = 3,
         })
         return
      end
      local target = plrs[math.random(1, #plrs)]
      local localPlayer = Players.LocalPlayer
      local myHRP = localPlayer.Character.HumanoidRootPart
      myHRP.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(2,0,0)
      Rayfield:Notify({
         Title = "teleported",
         Content = "teleported to " .. target.Name,
         Duration = 3,
      })
   end,
})

--// esp system
local ESPEnabled = false
local ESPShowNames = true
local ESPShowTeam = true
local ESPShowDistance = true
local ESPObjects = {}

local function getRainbowColor()
   local time = tick() % 6
   local r, g, b = 1, 1, 1
   
   if time < 1 then
      r, g, b = 1, time, 0
   elseif time < 2 then
      r, g, b = 2 - time, 1, 0
   elseif time < 3 then
      r, g, b = 0, 1, time - 2
   elseif time < 4 then
      r, g, b = 0, 4 - time, 1
   elseif time < 5 then
      r, g, b = time - 4, 0, 1
   else
      r, g, b = 1, 0, 6 - time
   end
   
   return Color3.fromRGB(r * 255, g * 255, b * 255)
end

local function getTeamColor(player)
   return getRainbowColor()
end

local function createESPUI(player)
   if player == game.Players.LocalPlayer then return end
   if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
   
   local char = player.Character
   local hrp = char.HumanoidRootPart
   
   local billboard = Instance.new("BillboardGui")
   billboard.Name = "ESP_" .. player.Name
   billboard.Adornee = hrp
   billboard.Size = UDim2.new(0, 200, 0, 100)
   billboard.StudsOffset = Vector3.new(0, 4, 0)
   billboard.AlwaysOnTop = true
   billboard.LightInfluence = 0
   billboard.Parent = hrp
   
   local frame = Instance.new("Frame")
   frame.Name = "ESPFrame"
   frame.Size = UDim2.new(1, 0, 1, 0)
   frame.BackgroundTransparency = 1
   frame.Parent = billboard
   
   local nameLabel = Instance.new("TextLabel")
   nameLabel.Name = "NameLabel"
   nameLabel.Size = UDim2.new(1, 0, 0.3, 0)
   nameLabel.Position = UDim2.new(0, 0, 0, 0)
   nameLabel.BackgroundTransparency = 1
   nameLabel.Text = player.Name
   nameLabel.TextColor3 = getTeamColor(player)
   nameLabel.TextStrokeTransparency = 0
   nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
   nameLabel.TextScaled = true
   nameLabel.Font = Enum.Font.GothamBold
   nameLabel.Visible = ESPShowNames
   nameLabel.Parent = frame
   
   local teamLabel = Instance.new("TextLabel")
   teamLabel.Name = "TeamLabel"
   teamLabel.Size = UDim2.new(1, 0, 0.3, 0)
   teamLabel.Position = UDim2.new(0, 0, 0.3, 0)
   teamLabel.BackgroundTransparency = 1
   teamLabel.Text = player.Team and player.Team.Name or "no team"
   teamLabel.TextColor3 = getTeamColor(player)
   teamLabel.TextStrokeTransparency = 0
   teamLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
   teamLabel.TextScaled = true
   teamLabel.Font = Enum.Font.Gotham
   teamLabel.Visible = ESPShowTeam
   teamLabel.Parent = frame
   
   local distanceLabel = Instance.new("TextLabel")
   distanceLabel.Name = "DistanceLabel"
   distanceLabel.Size = UDim2.new(1, 0, 0.3, 0)
   distanceLabel.Position = UDim2.new(0, 0, 0.6, 0)
   distanceLabel.BackgroundTransparency = 1
   distanceLabel.Text = "0 studs"
   distanceLabel.TextColor3 = Color3.new(1, 1, 1)
   distanceLabel.TextStrokeTransparency = 0
   distanceLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
   distanceLabel.TextScaled = true
   distanceLabel.Font = Enum.Font.Gotham
   distanceLabel.Visible = ESPShowDistance
   distanceLabel.Parent = frame
   
   local outlineColor = getTeamColor(player)
   for _, part in pairs(char:GetChildren()) do
      if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
         local highlight = Instance.new("BoxHandleAdornment")
         highlight.Name = "ESPOutline"
         highlight.Adornee = part
         highlight.Size = part.Size + Vector3.new(0.1, 0.1, 0.1)
         highlight.Color3 = outlineColor
         highlight.AlwaysOnTop = true
         highlight.ZIndex = 1
         highlight.Transparency = 0.5
         highlight.Parent = part
      end
   end
   
   ESPObjects[player] = {
      billboard = billboard,
      nameLabel = nameLabel,
      teamLabel = teamLabel,
      distanceLabel = distanceLabel,
      player = player
   }
end

local function updateESP()
   local localPlayer = game.Players.LocalPlayer
   if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
   
   local localHRP = localPlayer.Character.HumanoidRootPart
   local rainbowColor = getRainbowColor()
   
   for player, espData in pairs(ESPObjects) do
      if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
         local distance = (localHRP.Position - player.Character.HumanoidRootPart.Position).Magnitude
         espData.distanceLabel.Text = math.floor(distance) .. " studs"
         
         espData.nameLabel.TextColor3 = rainbowColor
         espData.teamLabel.TextColor3 = rainbowColor
         espData.teamLabel.Text = player.Team and player.Team.Name or "no team"
         
         if player.Character then
            for _, part in pairs(player.Character:GetChildren()) do
               if part:IsA("BasePart") then
                  local outline = part:FindFirstChild("ESPOutline")
                  if outline then
                     outline.Color3 = rainbowColor
                  end
               end
            end
         end
      end
   end
end

local function removeESP(player)
   if ESPObjects[player] then
      if ESPObjects[player].billboard then
         ESPObjects[player].billboard:Destroy()
      end
      
      if player.Character then
         for _, part in pairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") then
               local outline = part:FindFirstChild("ESPOutline")
               if outline then outline:Destroy() end
            end
         end
      end
      
      ESPObjects[player] = nil
   end
end

local function toggleESP(enabled)
   ESPEnabled = enabled
   
   if enabled then
      for _, player in pairs(game.Players:GetPlayers()) do
         createESPUI(player)
      end
      
      task.spawn(function()
         while ESPEnabled do
            updateESP()
            task.wait(0.1)
         end
      end)
   else
      for player, _ in pairs(ESPObjects) do
         removeESP(player)
      end
      ESPObjects = {}
   end
end

game.Players.PlayerAdded:Connect(function(player)
   if ESPEnabled then
      player.CharacterAdded:Connect(function()
         task.wait(1)
         if ESPEnabled then
            createESPUI(player)
         end
      end)
      
      if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
         task.wait(0.5)
         createESPUI(player)
      end
   end
end)

game.Players.PlayerRemoving:Connect(function(player)
   removeESP(player)
end)

for _, player in pairs(game.Players:GetPlayers()) do
   if player ~= game.Players.LocalPlayer then
      player.CharacterAdded:Connect(function()
         task.wait(1)
         if ESPEnabled then
            removeESP(player)
            createESPUI(player)
         end
      end)
      
      player.CharacterRemoving:Connect(function()
         if ESPEnabled then
            removeESP(player)
         end
      end)
   end
end

UniversalTab:CreateToggle({
   Name = "advanced esp",
   CurrentValue = false,
   Flag = "AdvancedESPToggle",
   Callback = function(Value)
      toggleESP(Value)
   end,
})

UniversalTab:CreateToggle({
   Name = "esp show names",
   CurrentValue = true,
   Flag = "ESPShowNamesToggle",
   Callback = function(Value)
      ESPShowNames = Value
      for _, espData in pairs(ESPObjects) do
         if espData.nameLabel then
            espData.nameLabel.Visible = Value
         end
      end
   end,
})

UniversalTab:CreateToggle({
   Name = "esp show teams",
   CurrentValue = true,
   Flag = "ESPShowTeamsToggle",
   Callback = function(Value)
      ESPShowTeam = Value
      for _, espData in pairs(ESPObjects) do
         if espData.teamLabel then
            espData.teamLabel.Visible = Value
         end
      end
   end,
})

UniversalTab:CreateToggle({
   Name = "esp show distance",
   CurrentValue = true,
   Flag = "ESPShowDistanceToggle",
   Callback = function(Value)
      ESPShowDistance = Value
      for _, espData in pairs(ESPObjects) do
         if espData.distanceLabel then
            espData.distanceLabel.Visible = Value
         end
      end
   end,
})