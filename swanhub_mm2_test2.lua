-- En İyi Hacker Scripti by mobblockk
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Signature = Instance.new("TextLabel")
local TabFrame = Instance.new("ScrollingFrame")
local JumpscareFrame = Instance.new("Frame")
local JumpscareImage = Instance.new("ImageLabel")
local JumpscareSound = Instance.new("Sound")
local PlayerInput = Instance.new("TextBox")
local MinimizeButton = Instance.new("TextButton")
local MinimizedFrame = Instance.new("Frame")
local CreatureImage = Instance.new("ImageLabel")
local Language = "Türkçe" -- "English" veya "Türkçe"

-- Dil Seçenekleri
local Texts = {
    Türkçe = {
        Welcome = "SW.HUB'a Hoş Geldiniz",
        JumpscareTitle = "Jumpscare Seçenekleri",
        PlayerInput = "Oyuncu Adı Gir",
        TabTitle = "Hack Yöntemleri",
        NotFound = "Oyuncu bulunamadı!"
    },
    English = {
        Welcome = "Welcome to SW.HUB",
        JumpscareTitle = "Jumpscare Options",
        PlayerInput = "Enter Player Name",
        TabTitle = "Hack Methods",
        NotFound = "Player not found!"
    }
}

-- Başlangıç Animasyonu
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "SWHUB"
local WelcomeFrame = Instance.new("Frame")
WelcomeFrame.Size = UDim2.new(1, 0, 1, 0)
WelcomeFrame.BackgroundColor3 = Color3.new(0, 0, 0)
WelcomeFrame.Parent = ScreenGui
local WelcomeText = Instance.new("TextLabel")
WelcomeText.Size = UDim2.new(1, 0, 1, 0)
WelcomeText.Text = ""
WelcomeText.TextColor3 = Color3.new(1, 1, 1)
WelcomeText.BackgroundTransparency = 1
WelcomeText.TextScaled = true
WelcomeText.Parent = WelcomeFrame

local welcomeString = Texts[Language].Welcome
for i = 1, #welcomeString do
    WelcomeText.Text = welcomeString:sub(1, i)
    WelcomeText.TextColor3 = Color3.fromHSV(i / #welcomeString, 1, 1)
    wait(0.1)
end
wait(2)
WelcomeFrame:Destroy()

-- Ana GUI
MainFrame.Size = UDim2.new(0.8, 0, 0.8, 0)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.Parent = ScreenGui

-- Sürüklenebilir Yapma
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Küçültme Butonu
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -40, 0, 10)
MinimizeButton.Text = "X"
MinimizeButton.TextColor3 = Color3.new(1, 0, 1)
MinimizeButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
MinimizeButton.Parent = MainFrame
MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MinimizedFrame.Visible = true
end)

-- Küçültülmüş GUI
MinimizedFrame.Size = UDim2.new(0, 100, 0, 100)
MinimizedFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MinimizedFrame.BackgroundColor3 = Color3.new(1, 1, 1)
MinimizedFrame.Visible = false
MinimizedFrame.Parent = ScreenGui
CreatureImage.Size = UDim2.new(0.8, 0, 0.8, 0)
CreatureImage.Position = UDim2.new(0.1, 0, 0.1, 0)
CreatureImage.BackgroundTransparency = 1
CreatureImage.Image = "rbxassetid://143666506" -- Mor palyaço
CreatureImage.Parent = MinimizedFrame
MinimizedFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        MainFrame.Visible = true
        MinimizedFrame.Visible = false
    end
end)

-- İmza
Signature.Parent = MainFrame
Signature.Size = UDim2.new(0, 100, 0, 20)
Signature.Position = UDim2.new(0, 10, 1, -30)
Signature.Text = "by mobblockk"
Signature.BackgroundColor3 = Color3.new(0, 0, 0)
Signature.BackgroundTransparency = 0
Signature.TextColor3 = Color3.new(1, 0, 1)
Signature.TextScaled = true
spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            Signature.TextColor3 = Color3.fromHSV(i, 1, 1)
            wait(0.05)
        end
    end
end)

-- Sol Taraf: Sekmeler
TabFrame.Size = UDim2.new(0.3, 0, 1, -40)
TabFrame.Position = UDim2.new(0, 10, 0, 40)
TabFrame.BackgroundColor3 = Color3.new(0, 0, 0)
TabFrame.CanvasSize = UDim2.new(0, 0, 0, 1550) -- 30 sekme için yeterli alan
TabFrame.Parent = MainFrame

local TabTitle = Instance.new("TextLabel")
TabTitle.Size = UDim2.new(1, 0, 0, 30)
TabTitle.Text = Texts[Language].TabTitle
TabTitle.TextColor3 = Color3.new(1, 0, 1)
TabTitle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
TabTitle.Parent = MainFrame

local function createTab(name, yPos, scripts)
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(0.9, 0, 0, 40)
    tabButton.Position = UDim2.new(0.05, 0, 0, yPos)
    tabButton.Text = name
    tabButton.TextColor3 = Color3.new(1, 0, 1)
    tabButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    tabButton.Parent = TabFrame
    
    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Size = UDim2.new(0.65, -20, 1, -40)
    contentFrame.Position = UDim2.new(0.35, 10, 0, 40)
    contentFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, #scripts * 50)
    contentFrame.Visible = false
    contentFrame.Parent = MainFrame

    for i, script in pairs(scripts) do
        local scriptButton = Instance.new("TextButton")
        scriptButton.Size = UDim2.new(0.9, 0, 0, 40)
        scriptButton.Position = UDim2.new(0.05, 0, 0, (i-1) * 50)
        scriptButton.Text = script.Name
        scriptButton.TextColor3 = Color3.new(1, 0, 1)
        scriptButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
        scriptButton.Parent = contentFrame
        scriptButton.MouseButton1Click:Connect(script.Func)
    end

    tabButton.MouseButton1Click:Connect(function()
        for _, child in pairs(MainFrame:GetChildren()) do
            if child:IsA("ScrollingFrame") and child ~= TabFrame then
                child.Visible = false
            end
        end
        contentFrame.Visible = true
    end)
end

-- 30 Sekme ve 600+ Hack/Script
local tabs = {
    {"Trolling", {
        {Name = "Fake Ban Message", Func = function() LocalPlayer:Kick("Banned!") end},
        {Name = "Screen Shake", Func = function() spawn(function() for i = 1, 50 do game.Workspace.CurrentCamera.CFrame = game.Workspace.CurrentCamera.CFrame * CFrame.Angles(math.rad(math.random(-5, 5)), math.rad(math.random(-5, 5)), 0) wait() end end) end},
        {Name = "Spam Chat", Func = function() for i = 1, 20 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("SPAM!", "All") wait(0.1) end end},
        {Name = "Invisible Troll", Func = function() LocalPlayer.Character.HumanoidRootPart.Transparency = 1 end},
        {Name = "Fake Death", Func = function() LocalPlayer.Character.Humanoid.Health = 0 end},
        {Name = "Random Teleport", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(math.random(-100, 100), 50, math.random(-100, 100)) end},
        {Name = "Sound Spam", Func = function() local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s.Looped = true s:Play() end},
        {Name = "Fake Admin", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("[ADMIN] You are banned!", "All") end},
        {Name = "Gravity Troll", Func = function() game.Workspace.Gravity = math.random(10, 100) end},
        {Name = "Color Flash", Func = function() spawn(function() for i = 1, 20 do game.Lighting.Ambient = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)) wait(0.1) end end) end},
        {Name = "Slow Walk", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 5 end},
        {Name = "Fast Walk", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 50 end},
        {Name = "Freeze Player", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 0 end},
        {Name = "Spin Player", Func = function() spawn(function() for i = 1, 50 do LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(10), 0) wait() end end) end},
        {Name = "Kick Message", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("You will be kicked in 5 seconds!", "All") wait(5) LocalPlayer:Kick("Kicked!") end},
        {Name = "Fake Lag", Func = function() for i = 1, 100 do wait(0.1) end end},
        {Name = "Screen Flip", Func = function() game.Workspace.CurrentCamera.CFrame = game.Workspace.CurrentCamera.CFrame * CFrame.Angles(math.rad(180), 0, 0) end},
        {Name = "Random Jump", Func = function() LocalPlayer.Character.Humanoid.JumpPower = math.random(50, 100) LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end},
        {Name = "Fake Robux", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("You won 1000 Robux!", "All") end},
        {Name = "Annoying GUI", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) t.Text = "ANNOYING!" t.TextScaled = true end}
    }},
    {"Speed Hacks", {
        {Name = "Super Speed", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 100 end},
        {Name = "Slow Motion", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 8 end},
        {Name = "Teleport Speed", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + LocalPlayer.Character.Humanoid.MoveDirection * 50 end},
        {Name = "Jump Boost", Func = function() LocalPlayer.Character.Humanoid.JumpPower = 100 end},
        {Name = "Infinite Jump", Func = function() game:GetService("UserInputService").JumpRequest:Connect(function() LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end) end},
        {Name = "Walkspeed 100", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 100 end},
        {Name = "Walkspeed 500", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 500 end},
        {Name = "No Clip", Func = function() spawn(function() while wait() do for _, part in pairs(LocalPlayer.Character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end end end) end},
        {Name = "Fly Hack", Func = function() local bv = Instance.new("BodyVelocity", LocalPlayer.Character.HumanoidRootPart) bv.Velocity = Vector3.new(0, 50, 0) end},
        {Name = "Speed Toggle", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = LocalPlayer.Character.Humanoid.WalkSpeed == 16 and 100 or 16 end},
        {Name = "Gravity Hack", Func = function() game.Workspace.Gravity = 10 end},
        {Name = "Boost Dash", Func = function() LocalPlayer.Character.HumanoidRootPart.Velocity = LocalPlayer.Character.Humanoid.MoveDirection * 200 end},
        {Name = "Slow Others", Func = function() for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then p.Character.Humanoid.WalkSpeed = 5 end end end},
        {Name = "Speed Aura", Func = function() spawn(function() while wait(1) do LocalPlayer.Character.Humanoid.WalkSpeed = 50 end end) end},
        {Name = "Teleport Dash", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 0, 50) end},
        {Name = "Fast Respawn", Func = function() LocalPlayer.Character:BreakJoints() end},
        {Name = "Instant Move", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(100, 0, 0) end},
        {Name = "Speed Glitch", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 200 wait(0.1) LocalPlayer.Character.Humanoid.WalkSpeed = 16 end},
        {Name = "Lag Speed", Func = function() for i = 1, 50 do LocalPlayer.Character.Humanoid.WalkSpeed = 100 wait(0.05) LocalPlayer.Character.Humanoid.WalkSpeed = 16 end end},
        {Name = "Super Jump", Func = function() LocalPlayer.Character.Humanoid.JumpPower = 200 end}
    }},
    {"Teleport Hacks", {
        {Name = "Teleport to Player", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = Players:GetPlayers()[math.random(2, #Players:GetPlayers())].Character.HumanoidRootPart.CFrame end},
        {Name = "Teleport to Spawn", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace:FindFirstChild("SpawnLocation").CFrame end},
        {Name = "Random TP", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(math.random(-500, 500), 50, math.random(-500, 500)) end},
        {Name = "Sky TP", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 1000, 0) end},
        {Name = "Underground TP", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, -100, 0) end},
        {Name = "Team TP", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = Players:GetPlayers()[2].Character.HumanoidRootPart.CFrame end},
        {Name = "Base TP", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0) end},
        {Name = "Safe Zone TP", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(100, 50, 100) end},
        {Name = "Enemy TP", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = Players:GetPlayers()[3].Character.HumanoidRootPart.CFrame end},
        {Name = "Object TP", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace:FindFirstChildOfClass("Part").CFrame end},
        {Name = "Invisible TP", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 500, 0) LocalPlayer.Character.HumanoidRootPart.Transparency = 1 end},
        {Name = "Mass TP", Func = function() for _, p in pairs(Players:GetPlayers()) do p.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0) end end},
        {Name = "TP Loop", Func = function() spawn(function() for i = 1, 10 do LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(math.random(-50, 50), 50, math.random(-50, 50)) wait(0.5) end end) end},
        {Name = "TP Spam", Func = function() spawn(function() for i = 1, 20 do LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(math.random(-10, 10), 50, math.random(-10, 10)) wait(0.1) end end) end},
        {Name = "TP Freeze", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0) LocalPlayer.Character.Humanoid.WalkSpeed = 0 end},
        {Name = "TP Glitch", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 1000, 0) wait(0.1) LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0) end},
        {Name = "Silent TP", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(50, 50, 50) end},
        {Name = "Fake TP", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Teleported!", "All") end},
        {Name = "TP Trap", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, -500, 0) end},
        {Name = "TP Bomb", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0) local e = Instance.new("Explosion", game.Workspace) e.Position = LocalPlayer.Character.HumanoidRootPart.Position end}
    }},
    {"ESP Hacks", {
        {Name = "Player ESP", Func = function() for _, p in pairs(Players:GetPlayers()) do local h = Instance.new("Highlight", p.Character) h.FillColor = Color3.new(1, 0, 0) end end},
        {Name = "Item ESP", Func = function() for _, i in pairs(game.Workspace:GetDescendants()) do if i:IsA("BasePart") then local h = Instance.new("Highlight", i) h.FillColor = Color3.new(0, 1, 0) end end end},
        {Name = "Team ESP", Func = function() for _, p in pairs(Players:GetPlayers()) do if p.Team == LocalPlayer.Team then local h = Instance.new("Highlight", p.Character) h.FillColor = Color3.new(0, 0, 1) end end end},
        {Name = "Enemy ESP", Func = function() for _, p in pairs(Players:GetPlayers()) do if p.Team ~= LocalPlayer.Team then local h = Instance.new("Highlight", p.Character) h.FillColor = Color3.new(1, 0, 0) end end end},
        {Name = "Name ESP", Func = function() for _, p in pairs(Players:GetPlayers()) do local b = Instance.new("BillboardGui", p.Character.Head) b.Size = UDim2.new(0, 100, 0, 20) local t = Instance.new("TextLabel", b) t.Text = p.Name end end},
        {Name = "Health ESP", Func = function() for _, p in pairs(Players:GetPlayers()) do local b = Instance.new("BillboardGui", p.Character.Head) b.Size = UDim2.new(0, 100, 0, 20) local t = Instance.new("TextLabel", b) t.Text = p.Character.Humanoid.Health end end},
        {Name = "Distance ESP", Func = function() for _, p in pairs(Players:GetPlayers()) do local b = Instance.new("BillboardGui", p.Character.Head) b.Size = UDim2.new(0, 100, 0, 20) local t = Instance.new("TextLabel", b) t.Text = (LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude end end},
        {Name = "Box ESP", Func = function() for _, p in pairs(Players:GetPlayers()) do local b = Instance.new("BoxHandleAdornment", p.Character.HumanoidRootPart) b.Size = Vector3.new(5, 5, 5) b.Color3 = Color3.new(1, 0, 0) b.Adornee = p.Character.HumanoidRootPart end end},
        {Name = "Tracer ESP", Func = function() spawn(function() while wait() do for _, p in pairs(Players:GetPlayers()) do local l = Instance.new("LineHandleAdornment", LocalPlayer.Character.HumanoidRootPart) l.Length = (LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude l.Color3 = Color3.new(1, 0, 0) l.Adornee = LocalPlayer.Character.HumanoidRootPart end end end) end},
        {Name = "Glow ESP", Func = function() for _, p in pairs(Players:GetPlayers()) do local h = Instance.new("Highlight", p.Character) h.FillTransparency = 0.5 end end},
        {Name = "Wall ESP", Func = function() for _, p in pairs(Players:GetPlayers()) do local h = Instance.new("Highlight", p.Character) h.OutlineColor = Color3.new(1, 0, 0) end end},
        {Name = "Item Glow", Func = function() for _, i in pairs(game.Workspace:GetDescendants()) do if i:IsA("BasePart") then local h = Instance.new("Highlight", i) h.FillColor = Color3.new(0, 1, 0) end end end},
        {Name = "NPC ESP", Func = function() for _, n in pairs(game.Workspace:GetDescendants()) do if n:FindFirstChild("Humanoid") then local h = Instance.new("Highlight", n) h.FillColor = Color3.new(0, 0, 1) end end end},
        {Name = "Safe ESP", Func = function() for _, s in pairs(game.Workspace:GetDescendants()) do if s.Name == "Safe" then local h = Instance.new("Highlight", s) h.FillColor = Color3.new(0, 1, 1) end end end},
        {Name = "Door ESP", Func = function() for _, d in pairs(game.Workspace:GetDescendants()) do if d.Name == "Door" then local h = Instance.new("Highlight", d) h.FillColor = Color3.new(1, 1, 0) end end end},
        {Name = "Trap ESP", Func = function() for _, t in pairs(game.Workspace:GetDescendants()) do if t.Name == "Trap" then local h = Instance.new("Highlight", t) h.FillColor = Color3.new(1, 0, 1) end end end},
        {Name = "Loot ESP", Func = function() for _, l in pairs(game.Workspace:GetDescendants()) do if l.Name == "Loot" then local h = Instance.new("Highlight", l) h.FillColor = Color3.new(0, 1, 0) end end end},
        {Name = "Vehicle ESP", Func = function() for _, v in pairs(game.Workspace:GetDescendants()) do if v.Name == "Vehicle" then local h = Instance.new("Highlight", v) h.FillColor = Color3.new(1, 0, 0) end end end},
        {Name = "Weapon ESP", Func = function() for _, w in pairs(game.Workspace:GetDescendants()) do if w.Name == "Weapon" then local h = Instance.new("Highlight", w) h.FillColor = Color3.new(0, 0, 1) end end end},
        {Name = "Full ESP", Func = function() for _, o in pairs(game.Workspace:GetDescendants()) do if o:IsA("BasePart") or o:FindFirstChild("Humanoid") then local h = Instance.new("Highlight", o) h.FillColor = Color3.new(math.random(), math.random(), math.random()) end end end}
    }},
    {"Aimbot", {
        {Name = "Simple Aimbot", Func = function() spawn(function() while wait() do for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, p.Character.HumanoidRootPart.Position) end end end end) end},
        {Name = "Headshot Aimbot", Func = function() spawn(function() while wait() do for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, p.Character.Head.Position) end end end end) end},
        {Name = "Silent Aim", Func = function() spawn(function() while wait() do for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position, p.Character.HumanoidRootPart.Position) end end end end) end},
        {Name = "Team Aim", Func = function() spawn(function() while wait() do for _, p in pairs(Players:GetPlayers()) do if p.Team ~= LocalPlayer.Team then game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, p.Character.HumanoidRootPart.Position) end end end end) end},
        {Name = "Closest Aim", Func = function() spawn(function() while wait() do local closest = nil local dist = math.huge for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then local d = (LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude if d < dist then dist = d closest = p end end end if closest then game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, closest.Character.HumanoidRootPart.Position) end end end) end},
        {Name = "Lock Aim", Func = function() local target = Players:GetPlayers()[2] spawn(function() while wait() do game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, target.Character.HumanoidRootPart.Position) end end) end},
        {Name = "Smooth Aim", Func = function() spawn(function() while wait(0.05) do for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then game.Workspace.CurrentCamera.CFrame = game.Workspace.CurrentCamera.CFrame:Lerp(CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, p.Character.HumanoidRootPart.Position), 0.1) end end end end) end},
        {Name = "Trigger Bot", Func = function() spawn(function() while wait() do for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and (LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude < 10 then p.Character.Humanoid:TakeDamage(10) end end end end) end},
        {Name = "Wall Aim", Func = function() spawn(function() while wait() do for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, p.Character.HumanoidRootPart.Position) end end end end) end},
        {Name = "Auto Fire", Func = function() spawn(function() while wait(0.1) do for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then p.Character.Humanoid:TakeDamage(5) end end end end) end},
        {Name = "Head Lock", Func = function() local target = Players:GetPlayers()[2] spawn(function() while wait() do game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, target.Character.Head.Position) end end) end},
        {Name = "Body Aim", Func = function() spawn(function() while wait() do for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, p.Character.Torso.Position) end end end end) end},
        {Name = "Prediction Aim", Func = function() spawn(function() while wait() do for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, p.Character.HumanoidRootPart.Position + p.Character.HumanoidRootPart.Velocity * 0.1) end end end end) end},
        {Name = "FOV Aim", Func = function() game.Workspace.CurrentCamera.FieldOfView = 30 end},
        {Name = "No Recoil", Func = function() spawn(function() while wait() do game.Workspace.CurrentCamera.CFrame = game.Workspace.CurrentCamera.CFrame * CFrame.Angles(0, 0, 0) end end) end},
        {Name = "Bullet TP", Func = function() spawn(function() while wait() do for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(p.Character.HumanoidRootPart.Position) end end end end) end},
        {Name = "Aim Aura", Func = function() spawn(function() while wait(0.1) do for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and (LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude < 20 then game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, p.Character.HumanoidRootPart.Position) end end end end) end},
        {Name = "Leg Aim", Func = function() spawn(function() while wait() do for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, p.Character["Left Leg"].Position) end end end end) end},
        {Name = "Random Aim", Func = function() spawn(function() while wait(0.5) do local p = Players:GetPlayers()[math.random(2, #Players:GetPlayers())] game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, p.Character.HumanoidRootPart.Position) end end) end},
        {Name = "Full Aimbot", Func = function() spawn(function() while wait() do for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, p.Character.HumanoidRootPart.Position) p.Character.Humanoid:TakeDamage(5) end end end end) end}
    }},
    {"Wall Hacks", {
        {Name = "See Through Walls", Func = function() for _, w in pairs(game.Workspace:GetDescendants()) do if w:IsA("BasePart") then w.Transparency = 0.5 end end end},
        {Name = "Wall Remove", Func = function() for _, w in pairs(game.Workspace:GetDescendants()) do if w:IsA("BasePart") and w.Name == "Wall" then w:Destroy() end end end},
        {Name = "Wall ESP", Func = function() for _, w in pairs(game.Workspace:GetDescendants()) do if w:IsA("BasePart") then local h = Instance.new("Highlight", w) h.FillColor = Color3.new(1, 0, 0) end end end},
        {Name = "No Collision", Func = function() for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end},
        {Name = "Wall Transparency", Func = function() for _, w in pairs(game.Workspace:GetDescendants()) do if w:IsA("BasePart") then w.Transparency = 0.8 end end end},
        {Name = "Wall Glow", Func = function() for _, w in pairs(game.Workspace:GetDescendants()) do if w:IsA("BasePart") then local h = Instance.new("Highlight", w) h.FillTransparency = 0.5 end end end},
        {Name = "Wall Color", Func = function() for _, w in pairs(game.Workspace:GetDescendants()) do if w:IsA("BasePart") then w.BrickColor = BrickColor.Random() end end end},
        {Name = "Wall Destroy", Func = function() for _, w in pairs(game.Workspace:GetDescendants()) do if w:IsA("BasePart") and w.Size.Magnitude > 10 then w:Destroy() end end end},
        {Name = "Wall Thin", Func = function() for _, w in pairs(game.Workspace:GetDescendants()) do if w:IsA("BasePart") then w.Size = Vector3.new(w.Size.X, 0.1, w.Size.Z) end end end},
        {Name = "Wall X-Ray", Func = function() for _, w in pairs(game.Workspace:GetDescendants()) do if w:IsA("BasePart") then w.Transparency = 0.9 end end end},
        {Name = "Wall Outline", Func = function() for _, w in pairs(game.Workspace:GetDescendants()) do if w:IsA("BasePart") then local h = Instance.new("Highlight", w) h.OutlineColor = Color3.new(1, 0, 0) end end end},
        {Name = "Wall Fade", Func = function() spawn(function() while wait(0.5) do for _, w in pairs(game.Workspace:GetDescendants()) do if w:IsA("BasePart") then w.Transparency = w.Transparency == 0.5 and 1 or 0.5 end end end end) end},
        {Name = "Wall Break", Func = function() for _, w in pairs(game.Workspace:GetDescendants()) do if w:IsA("BasePart") then w:BreakJoints() end end end},
        {Name = "Wall Pass", Func = function() LocalPlayer.Character.HumanoidRootPart.CanCollide = false end},
        {Name = "Wall Vision", Func = function() game.Lighting.FogEnd = 10000 end},
        {Name = "Wall Highlight", Func = function() for _, w in pairs(game.Workspace:GetDescendants()) do if w:IsA("BasePart") then local h = Instance.new("Highlight", w) h.FillColor = Color3.new(0, 1, 0) end end end},
        {Name = "Wall NoClip", Func = function() spawn(function() while wait() do for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end end) end},
        {Name = "Wall Clear", Func = function() for _, w in pairs(game.Workspace:GetDescendants()) do if w:IsA("BasePart") then w.Transparency = 1 end end end},
        {Name = "Wall Scan", Func = function() for _, w in pairs(game.Workspace:GetDescendants()) do if w:IsA("BasePart") then local h = Instance.new("Highlight", w) h.FillColor = Color3.new(1, 1, 0) end end end},
        {Name = "Wall Full", Func = function() for _, w in pairs(game.Workspace:GetDescendants()) do if w:IsA("BasePart") then w.Transparency = 0.5 local h = Instance.new("Highlight", w) h.FillColor = Color3.new(1, 0, 0) end end end}
    }},
    {"Item Spawner", {
        {Name = "Spawn Sword", Func = function() local t = Instance.new("Tool", LocalPlayer.Backpack) t.Name = "Sword" end},
        {Name = "Spawn Gun", Func = function() local t = Instance.new("Tool", LocalPlayer.Backpack) t.Name = "Gun" end},
        {Name = "Spawn Health", Func = function() LocalPlayer.Character.Humanoid.Health = 100 end},
        {Name = "Spawn Speed", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 50 end},
        {Name = "Spawn Jump", Func = function() LocalPlayer.Character.Humanoid.JumpPower = 100 end},
        {Name = "Spawn Part", Func = function() local p = Instance.new("Part", game.Workspace) p.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0) end},
        {Name = "Spawn Brick", Func = function() local b = Instance.new("Part", game.Workspace) b.BrickColor = BrickColor.Random() b.Position = LocalPlayer.Character.HumanoidRootPart.Position end},
        {Name = "Spawn Bomb", Func = function() local e = Instance.new("Explosion", game.Workspace) e.Position = LocalPlayer.Character.HumanoidRootPart.Position end},
        {Name = "Spawn Vehicle", Func = function() local v = Instance.new("VehicleSeat", game.Workspace) v.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0) end},
        {Name = "Spawn NPC", Func = function() local n = Instance.new("Model", game.Workspace) local h = Instance.new("Humanoid", n) local p = Instance.new("Part", n) p.Position = LocalPlayer.Character.HumanoidRootPart.Position end},
        {Name = "Spawn Money", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Spawned 1000 Robux!", "All") end},
        {Name = "Spawn Tool", Func = function() local t = Instance.new("Tool", LocalPlayer.Backpack) t.Name = "Magic Tool" end},
        {Name = "Spawn Shield", Func = function() LocalPlayer.Character.Humanoid.MaxHealth = 1000 end},
        {Name = "Spawn Platform", Func = function() local p = Instance.new("Part", game.Workspace) p.Size = Vector3.new(50, 1, 50) p.Position = LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 5, 0) end},
        {Name = "Spawn Trap", Func = function() local t = Instance.new("Part", game.Workspace) t.Position = LocalPlayer.Character.HumanoidRootPart.Position t.Touched:Connect(function(hit) hit.Parent.Humanoid:TakeDamage(50) end) end},
        {Name = "Spawn Wall", Func = function() local w = Instance.new("Part", game.Workspace) w.Size = Vector3.new(10, 20, 1) w.Position = LocalPlayer.Character.HumanoidRootPart.Position end},
        {Name = "Spawn Door", Func = function() local d = Instance.new("Part", game.Workspace) d.Size = Vector3.new(5, 10, 1) d.Position = LocalPlayer.Character.HumanoidRootPart.Position end},
        {Name = "Spawn Pet", Func = function() local p = Instance.new("Model", game.Workspace) local h = Instance.new("Humanoid", p) local b = Instance.new("Part", p) b.Position = LocalPlayer.Character.HumanoidRootPart.Position end},
        {Name = "Spawn Food", Func = function() LocalPlayer.Character.Humanoid.Health = 100 end},
        {Name = "Spawn Full", Func = function() local t = Instance.new("Tool", LocalPlayer.Backpack) t.Name = "Full Kit" LocalPlayer.Character.Humanoid.WalkSpeed = 50 LocalPlayer.Character.Humanoid.JumpPower = 100 end}
    }},
    {"God Mode", {
        {Name = "Infinite Health", Func = function() LocalPlayer.Character.Humanoid.MaxHealth = math.huge LocalPlayer.Character.Humanoid.Health = math.huge end},
        {Name = "No Damage", Func = function() LocalPlayer.Character.Humanoid.HealthChanged:Connect(function() LocalPlayer.Character.Humanoid.Health = 100 end) end},
        {Name = "Invincibility", Func = function() LocalPlayer.Character.Humanoid.MaxHealth = 1000 end},
        {Name = "Regen Health", Func = function() spawn(function() while wait(1) do LocalPlayer.Character.Humanoid.Health = 100 end end) end},
        {Name = "No Fall Damage", Func = function() LocalPlayer.Character.Humanoid.FallingDown:Connect(function() LocalPlayer.Character.Humanoid.Health = 100 end) end},
        {Name = "God Shield", Func = function() local s = Instance.new("ForceField", LocalPlayer.Character) end},
        {Name = "Immortal", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 50 LocalPlayer.Character.Humanoid.MaxHealth = math.huge end},
        {Name = "No Knockback", Func = function() LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0) end},
        {Name = "Fast Regen", Func = function() spawn(function() while wait(0.1) do LocalPlayer.Character.Humanoid.Health = 100 end end) end},
        {Name = "No Poison", Func = function() LocalPlayer.Character.Humanoid.HealthChanged:Connect(function() if LocalPlayer.Character.Humanoid.Health < 100 then LocalPlayer.Character.Humanoid.Health = 100 end end) end},
        {Name = "God Aura", Func = function() local h = Instance.new("Highlight", LocalPlayer.Character) h.FillColor = Color3.new(1, 1, 0) end},
        {Name = "No Death", Func = function() LocalPlayer.Character.Humanoid.Died:Connect(function() LocalPlayer.Character.Humanoid.Health = 100 end) end},
        {Name = "Super Health", Func = function() LocalPlayer.Character.Humanoid.MaxHealth = 500 end},
        {Name = "No Burn", Func = function() LocalPlayer.Character.Humanoid.HealthChanged:Connect(function() LocalPlayer.Character.Humanoid.Health = 100 end) end},
        {Name = "God Speed", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 100 LocalPlayer.Character.Humanoid.MaxHealth = math.huge end},
        {Name = "No Stun", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 16 end},
        {Name = "God Jump", Func = function() LocalPlayer.Character.Humanoid.JumpPower = 100 LocalPlayer.Character.Humanoid.MaxHealth = math.huge end},
        {Name = "No Explosion", Func = function() LocalPlayer.Character.Humanoid.HealthChanged:Connect(function() LocalPlayer.Character.Humanoid.Health = 100 end) end},
        {Name = "God Fly", Func = function() local bv = Instance.new("BodyVelocity", LocalPlayer.Character.HumanoidRootPart) bv.Velocity = Vector3.new(0, 50, 0) LocalPlayer.Character.Humanoid.MaxHealth = math.huge end},
        {Name = "Full God", Func = function() LocalPlayer.Character.Humanoid.MaxHealth = math.huge LocalPlayer.Character.Humanoid.WalkSpeed = 100 LocalPlayer.Character.Humanoid.JumpPower = 100 end}
    }},
    {"Chat Hacks", {
        {Name = "Spam Chat", Func = function() for i = 1, 20 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("SPAM!", "All") wait(0.1) end end},
        {Name = "Fake Admin", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("[ADMIN] Server shutting down!", "All") end},
        {Name = "Silent Chat", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "All") end},
        {Name = "Color Chat", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("<font color='rgb(255,0,0)'>Red Text!</font>", "All") end},
        {Name = "Big Text", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("<h1>HUGE TEXT</h1>", "All") end},
        {Name = "Chat Flood", Func = function() for i = 1, 50 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("FLOOD " .. i, "All") wait(0.05) end end},
        {Name = "Fake Ban", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("You are banned!", "All") end},
        {Name = "Chat Clear", Func = function() for i = 1, 20 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "All") wait(0.1) end end},
        {Name = "Rainbow Chat", Func = function() for i = 1, 10 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("<font color='rgb("..math.random(0,255)..","..math.random(0,255)..","..math.random(0,255)..")'>Rainbow!</font>", "All") wait(0.5) end end},
        {Name = "Fake Command", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/kick all", "All") end},
        {Name = "Chat Loop", Func = function() spawn(function() while wait(1) do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Loop!", "All") end end) end},
        {Name = "Whisper Spam", Func = function() for _, p in pairs(Players:GetPlayers()) do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/w " .. p.Name .. " Hey!", "All") end end},
        {Name = "Chat Crash", Func = function() for i = 1, 100 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(string.rep("a", 1000), "All") wait(0.01) end end},
        {Name = "Fake Robux", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("You won 1000 Robux!", "All") end},
        {Name = "Chat Mute", Func = function() game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false) end},
        {Name = "Chat Unmute", Func = function() game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true) end},
        {Name = "Chat Troll", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("LOL TROLLED!", "All") end},
        {Name = "Chat Alert", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("<b>ALERT!</b>", "All") end},
        {Name = "Chat Fake", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("[SYSTEM] Server hacked!", "All") end},
        {Name = "Chat Full", Func = function() for i = 1, 20 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("FULL CHAT " .. i, "All") wait(0.1) end end}
    }},
    {"GUI Hacks", {
        {Name = "Fake GUI", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) t.Text = "HACKED!" t.TextScaled = true end},
        {Name = "Annoying GUI", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(0.5, 0, 0.5, 0) t.Position = UDim2.new(0.25, 0, 0.25, 0) t.Text = "ANNOYING!" t.TextScaled = true end},
        {Name = "Flash GUI", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) spawn(function() while wait(0.5) do t.BackgroundColor3 = Color3.new(math.random(), math.random(), math.random()) end end) end},
        {Name = "Big GUI", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) t.Text = "BIG!" t.TextScaled = true end},
        {Name = "Move GUI", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(0.2, 0, 0.2, 0) spawn(function() while wait(0.1) do t.Position = UDim2.new(math.random(), 0, math.random(), 0) end end) end},
        {Name = "Spam GUI", Func = function() for i = 1, 10 do local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(0.1, 0, 0.1, 0) t.Position = UDim2.new(math.random(), 0, math.random(), 0) t.Text = "SPAM " .. i end end},
        {Name = "Fake Ban GUI", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) t.Text = "BANNED!" t.TextScaled = true end},
        {Name = "Color GUI", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) t.BackgroundColor3 = Color3.new(1, 0, 0) end},
        {Name = "Invisible GUI", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) t.BackgroundTransparency = 0.5 end},
        {Name = "Fake Menu", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(0.5, 0, 0.5, 0) t.Text = "MENU" t.TextScaled = true end},
        {Name = "GUI Loop", Func = function() spawn(function() while wait(1) do local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(0.2, 0, 0.2, 0) t.Text = "LOOP" t:Destroy() end end) end},
        {Name = "GUI Flood", Func = function() for i = 1, 20 do local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(0.1, 0, 0.1, 0) t.Text = "FLOOD " .. i end end},
        {Name = "GUI Shake", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(0.2, 0, 0.2, 0) spawn(function() for i = 1, 50 do t.Position = UDim2.new(0.4 + math.random(-0.1, 0.1), 0, 0.4 + math.random(-0.1, 0.1), 0) wait() end end) end},
        {Name = "GUI Troll", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) t.Text = "TROLLED!" t.TextScaled = true end},
        {Name = "GUI Flash", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) spawn(function() while wait(0.2) do t.Visible = not t.Visible end end) end},
        {Name = "GUI Block", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) t.BackgroundColor3 = Color3.new(0, 0, 0) end},
        {Name = "GUI Fake", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) t.Text = "FAKE GUI!" t.TextScaled = true end},
        {Name = "GUI Alert", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(0.5, 0, 0.5, 0) t.Text = "ALERT!" t.TextScaled = true end},
        {Name = "GUI Crash", Func = function() for i = 1, 100 do local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) t.Text = "CRASH " .. i end end},
        {Name = "GUI Full", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) t.Text = "FULL GUI!" t.TextScaled = true t.BackgroundColor3 = Color3.new(1, 0, 0) end}
    }},
    {"Animation Hacks", {
        {Name = "Dance Anim", Func = function() local a = Instance.new("Animation") a.AnimationId = "rbxassetid://507771019" LocalPlayer.Character.Humanoid:LoadAnimation(a):Play() end},
        {Name = "Spin Anim", Func = function() spawn(function() while wait() do LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(10), 0) end end) end},
        {Name = "Jump Anim", Func = function() LocalPlayer.Character.Humanoid.JumpPower = 50 LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end},
        {Name = "Sit Anim", Func = function() LocalPlayer.Character.Humanoid.Sit = true end},
        {Name = "Walk Anim", Func = function() local a = Instance.new("Animation") a.AnimationId = "rbxassetid://507777826" LocalPlayer.Character.Humanoid:LoadAnimation(a):Play() end},
        {Name = "Run Anim", Func = function() local a = Instance.new("Animation") a.AnimationId = "rbxassetid://507767714" LocalPlayer.Character.Humanoid:LoadAnimation(a):Play() end},
        {Name = "Fall Anim", Func = function() LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.FallingDown) end},
        {Name = "Climb Anim", Func = function() LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Climbing) end},
        {Name = "Swim Anim", Func = function() LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming) end},
        {Name = "Freeze Anim", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 0 end},
        {Name = "Loop Dance", Func = function() local a = Instance.new("Animation") a.AnimationId = "rbxassetid://507771019" local anim = LocalPlayer.Character.Humanoid:LoadAnimation(a) anim:Play() anim.Looped = true end},
        {Name = "Random Anim", Func = function() local anims = {"507771019", "507777826", "507767714"} local a = Instance.new("Animation") a.AnimationId = "rbxassetid://" .. anims[math.random(1, #anims)] LocalPlayer.Character.Humanoid:LoadAnimation(a):Play() end},
        {Name = "Fast Anim", Func = function() local a = Instance.new("Animation") a.AnimationId = "rbxassetid://507767714" local anim = LocalPlayer.Character.Humanoid:LoadAnimation(a) anim:Play() anim:AdjustSpeed(2) end},
        {Name = "Slow Anim", Func = function() local a = Instance.new("Animation") a.AnimationId = "rbxassetid://507767714" local anim = LocalPlayer.Character.Humanoid:LoadAnimation(a) anim:Play() anim:AdjustSpeed(0.5) end},
        {Name = "Reverse Anim", Func = function() local a = Instance.new("Animation") a.AnimationId = "rbxassetid://507767714" local anim = LocalPlayer.Character.Humanoid:LoadAnimation(a) anim:Play() anim:AdjustSpeed(-1) end},
        {Name = "Anim Spam", Func = function() for i = 1, 5 do local a = Instance.new("Animation") a.AnimationId = "rbxassetid://507771019" LocalPlayer.Character.Humanoid:LoadAnimation(a):Play() wait(0.5) end end},
        {Name = "Anim Stop", Func = function() for _, a in pairs(LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do a:Stop() end end},
        {Name = "Anim Troll", Func = function() local a = Instance.new("Animation") a.AnimationId = "rbxassetid://507771019" LocalPlayer.Character.Humanoid:LoadAnimation(a):Play() end},
        {Name = "Anim Glitch", Func = function() local a = Instance.new("Animation") a.AnimationId = "rbxassetid://507767714" local anim = LocalPlayer.Character.Humanoid:LoadAnimation(a) anim:Play() anim:AdjustSpeed(10) end},
        {Name = "Full Anim", Func = function() local a = Instance.new("Animation") a.AnimationId = "rbxassetid://507771019" local anim = LocalPlayer.Character.Humanoid:LoadAnimation(a) anim:Play() anim.Looped = true anim:AdjustSpeed(2) end}
    }},
    {"Sound Hacks", {
        {Name = "Loud Sound", Func = function() local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s.Volume = 10 s:Play() end},
        {Name = "Loop Sound", Func = function() local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s.Looped = true s:Play() end},
        {Name = "Spam Sound", Func = function() for i = 1, 10 do local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s:Play() wait(0.5) end end},
        {Name = "Ear Rape", Func = function() local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s.Volume = 100 s:Play() end},
        {Name = "Silent Sound", Func = function() local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s.Volume = 0 s:Play() end},
        {Name = "Random Sound", Func = function() local sounds = {"1046135188", "111222333", "17026"} local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://" .. sounds[math.random(1, #sounds)] s:Play() end},
        {Name = "Stop Sound", Func = function() for _, s in pairs(game.Workspace:GetDescendants()) do if s:IsA("Sound") then s:Stop() end end end},
        {Name = "Pitch Shift", Func = function() local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s.Pitch = 2 s:Play() end},
        {Name = "Low Pitch", Func = function() local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s.Pitch = 0.5 s:Play() end},
        {Name = "High Pitch", Func = function() local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s.Pitch = 3 s:Play() end},
        {Name = "Sound Flood", Func = function() for i = 1, 20 do local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s:Play() end end},
        {Name = "Sound Troll", Func = function() local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s.Volume = 5 s:Play() end},
        {Name = "Sound Loop", Func = function() local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s.Looped = true s:Play() end},
        {Name = "Sound Blast", Func = function() local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s.Volume = 10 s:Play() local e = Instance.new("Explosion", game.Workspace) e.Position = LocalPlayer.Character.HumanoidRootPart.Position end},
        {Name = "Sound Mute", Func = function() for _, s in pairs(game.Workspace:GetDescendants()) do if s:IsA("Sound") then s.Volume = 0 end end end},
        {Name = "Sound Unmute", Func = function() for _, s in pairs(game.Workspace:GetDescendants()) do if s:IsA("Sound") then s.Volume = 5 end end end},
        {Name = "Sound Glitch", Func = function() local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s.Pitch = math.random(0.5, 3) s:Play() end},
        {Name = "Sound Spam", Func = function() for i = 1, 10 do local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s:Play() wait(0.1) end end},
        {Name = "Sound Fake", Func = function() local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s:Play() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Sound hacked!", "All") end},
        {Name = "Full Sound", Func = function() local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s.Volume = 10 s.Looped = true s:Play() end}
    }},
    {"Visual Hacks", {
        {Name = "Bright Mode", Func = function() game.Lighting.Brightness = 10 end},
        {Name = "Dark Mode", Func = function() game.Lighting.Brightness = 0 end},
        {Name = "Fog Remove", Func = function() game.Lighting.FogEnd = 10000 end},
        {Name = "Fog Add", Func = function() game.Lighting.FogEnd = 50 end},
        {Name = "Color Shift", Func = function() game.Lighting.Ambient = Color3.new(math.random(), math.random(), math.random()) end},
        {Name = "Rainbow Sky", Func = function() spawn(function() while wait(0.5) do game.Lighting.Ambient = Color3.fromHSV(math.random(), 1, 1) end end) end},
        {Name = "Night Vision", Func = function() game.Lighting.Brightness = 5 game.Lighting.FogEnd = 10000 end},
        {Name = "Flash Screen", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local f = Instance.new("Frame", g) f.Size = UDim2.new(1, 0, 1, 0) f.BackgroundColor3 = Color3.new(1, 1, 1) wait(0.1) f:Destroy() end},
        {Name = "Blur Vision", Func = function() local b = Instance.new("BlurEffect", game.Lighting) b.Size = 10 end},
        {Name = "No Blur", Func = function() for _, b in pairs(game.Lighting:GetChildren()) do if b:IsA("BlurEffect") then b:Destroy() end end end},
        {Name = "Color Blind", Func = function() game.Lighting.ColorCorrection.Saturation = -1 end},
        {Name = "High Contrast", Func = function() game.Lighting.ColorCorrection.Contrast = 2 end},
        {Name = "Low Contrast", Func = function() game.Lighting.ColorCorrection.Contrast = -2 end},
        {Name = "Invert Colors", Func = function() game.Lighting.ColorCorrection.TintColor = Color3.new(0, 0, 0) end},
        {Name = "Visual Flash", Func = function() spawn(function() for i = 1, 10 do game.Lighting.Brightness = i wait(0.1) end end) end},
        {Name = "Sky Change", Func = function() local s = Instance.new("Sky", game.Lighting) s.SkyboxBk = "rbxassetid://183924671" end},
        {Name = "No Shadows", Func = function() game.Lighting.GlobalShadows = false end},
        {Name = "Full Bright", Func = function() game.Lighting.Brightness = 10 game.Lighting.FogEnd = 10000 game.Lighting.GlobalShadows = false end},
        {Name = "Visual Troll", Func = function() game.Lighting.Ambient = Color3.new(1, 0, 0) end},
        {Name = "Visual Full", Func = function() game.Lighting.Brightness = 5 game.Lighting.FogEnd = 10000 game.Lighting.Ambient = Color3.new(math.random(), math.random(), math.random()) end}
    }},
    {"Player Mods", {
        {Name = "Big Size", Func = function() LocalPlayer.Character.Humanoid.BodyWidthScale.Value = 5 end},
        {Name = "Small Size", Func = function() LocalPlayer.Character.Humanoid.BodyWidthScale.Value = 0.5 end},
        {Name = "Tall Player", Func = function() LocalPlayer.Character.Humanoid.BodyHeightScale.Value = 5 end},
        {Name = "Short Player", Func = function() LocalPlayer.Character.Humanoid.BodyHeightScale.Value = 0.5 end},
        {Name = "Fat Player", Func = function() LocalPlayer.Character.Humanoid.BodyDepthScale.Value = 5 end},
        {Name = "Thin Player", Func = function() LocalPlayer.Character.Humanoid.BodyDepthScale.Value = 0.5 end},
        {Name = "Head Big", Func = function() LocalPlayer.Character.Humanoid.HeadScale.Value = 5 end},
        {Name = "Head Small", Func = function() LocalPlayer.Character.Humanoid.HeadScale.Value = 0.5 end},
        {Name = "Invisible", Func = function() for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.Transparency = 1 end end end},
        {Name = "Color Player", Func = function() for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.BrickColor = BrickColor.Random() end end end},
        {Name = "Glow Player", Func = function() local h = Instance.new("Highlight", LocalPlayer.Character) h.FillColor = Color3.new(1, 1, 0) end},
        {Name = "No Arms", Func = function() LocalPlayer.Character["Left Arm"]:Destroy() LocalPlayer.Character["Right Arm"]:Destroy() end},
        {Name = "No Legs", Func = function() LocalPlayer.Character["Left Leg"]:Destroy() LocalPlayer
          local tabs = tabs or {} -- Önceki sekmeleri korumak için

-- Kalan 18 Sekme
table.insert(tabs, {"Visual Hacks", {
    {Name = "Bright Mode", Func = function() game.Lighting.Brightness = 10 end},
    {Name = "Dark Mode", Func = function() game.Lighting.Brightness = 0 end},
    {Name = "Fog Remove", Func = function() game.Lighting.FogEnd = 10000 end},
    {Name = "Fog Add", Func = function() game.Lighting.FogEnd = 50 end},
    {Name = "Color Shift", Func = function() game.Lighting.Ambient = Color3.new(math.random(), math.random(), math.random()) end},
    {Name = "Rainbow Sky", Func = function() spawn(function() while wait(0.5) do game.Lighting.Ambient = Color3.fromHSV(math.random(), 1, 1) end end) end},
    {Name = "Night Vision", Func = function() game.Lighting.Brightness = 5 game.Lighting.FogEnd = 10000 end},
    {Name = "Flash Screen", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local f = Instance.new("Frame", g) f.Size = UDim2.new(1, 0, 1, 0) f.BackgroundColor3 = Color3.new(1, 1, 1) wait(0.1) f:Destroy() end},
    {Name = "Blur Vision", Func = function() local b = Instance.new("BlurEffect", game.Lighting) b.Size = 10 end},
    {Name = "No Blur", Func = function() for _, b in pairs(game.Lighting:GetChildren()) do if b:IsA("BlurEffect") then b:Destroy() end end end},
    {Name = "Color Blind", Func = function() game.Lighting.ColorCorrection.Saturation = -1 end},
    {Name = "High Contrast", Func = function() game.Lighting.ColorCorrection.Contrast = 2 end},
    {Name = "Low Contrast", Func = function() game.Lighting.ColorCorrection.Contrast = -2 end},
    {Name = "Invert Colors", Func = function() game.Lighting.ColorCorrection.TintColor = Color3.new(0, 0, 0) end},
    {Name = "Visual Flash", Func = function() spawn(function() for i = 1, 10 do game.Lighting.Brightness = i wait(0.1) end end) end},
    {Name = "Sky Change", Func = function() local s = Instance.new("Sky", game.Lighting) s.SkyboxBk = "rbxassetid://183924671" end},
    {Name = "No Shadows", Func = function() game.Lighting.GlobalShadows = false end},
    {Name = "Full Bright", Func = function() game.Lighting.Brightness = 10 game.Lighting.FogEnd = 10000 game.Lighting.GlobalShadows = false end},
    {Name = "Visual Troll", Func = function() game.Lighting.Ambient = Color3.new(1, 0, 0) end},
    {Name = "Visual Full", Func = function() game.Lighting.Brightness = 5 game.Lighting.FogEnd = 10000 game.Lighting.Ambient = Color3.new(math.random(), math.random(), math.random()) end}
}})
table.insert(tabs, {"Player Mods", {
    {Name = "Big Size", Func = function() LocalPlayer.Character.Humanoid.BodyWidthScale.Value = 5 end},
    {Name = "Small Size", Func = function() LocalPlayer.Character.Humanoid.BodyWidthScale.Value = 0.5 end},
    {Name = "Tall Player", Func = function() LocalPlayer.Character.Humanoid.BodyHeightScale.Value = 5 end},
    {Name = "Short Player", Func = function() LocalPlayer.Character.Humanoid.BodyHeightScale.Value = 0.5 end},
    {Name = "Fat Player", Func = function() LocalPlayer.Character.Humanoid.BodyDepthScale.Value = 5 end},
    {Name = "Thin Player", Func = function() LocalPlayer.Character.Humanoid.BodyDepthScale.Value = 0.5 end},
    {Name = "Head Big", Func = function() LocalPlayer.Character.Humanoid.HeadScale.Value = 5 end},
    {Name = "Head Small", Func = function() LocalPlayer.Character.Humanoid.HeadScale.Value = 0.5 end},
    {Name = "Invisible", Func = function() for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.Transparency = 1 end end end},
    {Name = "Color Player", Func = function() for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.BrickColor = BrickColor.Random() end end end},
    {Name = "Glow Player", Func = function() local h = Instance.new("Highlight", LocalPlayer.Character) h.FillColor = Color3.new(1, 1, 0) end},
    {Name = "No Arms", Func = function() LocalPlayer.Character["Left Arm"]:Destroy() LocalPlayer.Character["Right Arm"]:Destroy() end},
    {Name = "No Legs", Func = function() LocalPlayer.Character["Left Leg"]:Destroy() LocalPlayer.Character["Right Leg"]:Destroy() end},
    {Name = "Head Only", Func = function() for _, p in pairs(LocalPlayer.Character:GetChildren()) do if p:IsA("BasePart") and p.Name ~= "Head" then p:Destroy() end end end},
    {Name = "Spin Body", Func = function() spawn(function() while wait() do LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(10), 0) end end) end},
    {Name = "Rainbow Player", Func = function() spawn(function() while wait(0.5) do for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.Color = Color3.fromHSV(math.random(), 1, 1) end end end end) end},
    {Name = "Ghost Mode", Func = function() for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.Transparency = 0.5 end end end},
    {Name = "No Head", Func = function() LocalPlayer.Character.Head:Destroy() end},
    {Name = "Stretch Player", Func = function() LocalPlayer.Character.Humanoid.BodyHeightScale.Value = 10 end},
    {Name = "Full Mod", Func = function() LocalPlayer.Character.Humanoid.BodyWidthScale.Value = 5 LocalPlayer.Character.Humanoid.BodyHeightScale.Value = 5 LocalPlayer.Character.Humanoid.HeadScale.Value = 5 end}
}})
table.insert(tabs, {"Server Crasher", {
    {Name = "Lag Server", Func = function() for i = 1, 1000 do Instance.new("Part", game.Workspace) end end},
    {Name = "Sound Crash", Func = function() for i = 1, 100 do local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s:Play() end end},
    {Name = "Part Spam", Func = function() for i = 1, 500 do local p = Instance.new("Part", game.Workspace) p.Position = Vector3.new(math.random(-1000, 1000), 50, math.random(-1000, 1000)) end end},
    {Name = "Chat Crash", Func = function() for i = 1, 100 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(string.rep("a", 1000), "All") wait(0.01) end end},
    {Name = "Explosion Spam", Func = function() for i = 1, 50 do local e = Instance.new("Explosion", game.Workspace) e.Position = LocalPlayer.Character.HumanoidRootPart.Position end end},
    {Name = "GUI Crash", Func = function() for i = 1, 100 do local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) end end},
    {Name = "Object Flood", Func = function() for i = 1, 200 do Instance.new("Model", game.Workspace) end end},
    {Name = "Memory Leak", Func = function() while true do Instance.new("Part", game.Workspace) end end},
    {Name = "Teleport Crash", Func = function() for i = 1, 100 do LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(math.random(-1000, 1000), 50, math.random(-1000, 1000)) wait(0.01) end end},
    {Name = "Sound Flood", Func = function() for i = 1, 200 do local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s:Play() end end},
    {Name = "Player Spam", Func = function() for i = 1, 50 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("CRASH " .. i, "All") end end},
    {Name = "Infinite Loop", Func = function() while true do wait() end end},
    {Name = "Mass Kick", Func = function() for _, p in pairs(Players:GetPlayers()) do p:Kick("Server crashed!") end end},
    {Name = "Lag Spike", Func = function() for i = 1, 1000 do Instance.new("Part", game.Workspace) wait(0.01) end end},
    {Name = "Visual Crash", Func = function() game.Lighting.Brightness = 1000 end},
    {Name = "Part Explosion", Func = function() for i = 1, 50 do local p = Instance.new("Part", game.Workspace) p.Position = LocalPlayer.Character.HumanoidRootPart.Position local e = Instance.new("Explosion", p) e.Position = p.Position end end},
    {Name = "Server Freeze", Func = function() for i = 1, 100 do Instance.new("Script", game.Workspace):Destroy() end end},
    {Name = "Network Flood", Func = function() for i = 1, 100 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(string.rep("x", 5000), "All") end end},
    {Name = "Crash All", Func = function() for i = 1, 100 do Instance.new("Part", game.Workspace) local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s:Play() end end},
    {Name = "Ultimate Crash", Func = function() while true do for i = 1, 50 do Instance.new("Part", game.Workspace) game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("CRASH!", "All") end end end}
}})
table.insert(tabs, {"Lag Hacks", {
    {Name = "Lag Spike", Func = function() for i = 1, 1000 do Instance.new("Part", game.Workspace) end end},
    {Name = "Sound Lag", Func = function() for i = 1, 50 do local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s:Play() end end},
    {Name = "Chat Lag", Func = function() for i = 1, 100 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(string.rep("a", 1000), "All") wait(0.01) end end},
    {Name = "Part Lag", Func = function() for i = 1, 500 do local p = Instance.new("Part", game.Workspace) p.Position = Vector3.new(math.random(-100, 100), 50, math.random(-100, 100)) end end},
    {Name = "Teleport Lag", Func = function() for i = 1, 100 do LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(math.random(-100, 100), 50, math.random(-100, 100)) wait(0.01) end end},
    {Name = "GUI Lag", Func = function() for i = 1, 100 do local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) end end},
    {Name = "Object Lag", Func = function() for i = 1, 200 do Instance.new("Model", game.Workspace) end end},
    {Name = "Freeze Lag", Func = function() while wait(0.1) do end end},
    {Name = "Visual Lag", Func = function() game.Lighting.Brightness = 1000 end},
    {Name = "Sound Spam", Func = function() for i = 1, 100 do local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s:Play() end end},
    {Name = "Player Lag", Func = function() for _, p in pairs(Players:GetPlayers()) do p.Character.Humanoid.WalkSpeed = 0 end end},
    {Name = "Mass Lag", Func = function() for i = 1, 1000 do Instance.new("Part", game.Workspace) wait(0.01) end end},
    {Name = "Network Lag", Func = function() for i = 1, 100 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(string.rep("x", 5000), "All") end end},
    {Name = "Frame Drop", Func = function() for i = 1, 50 do Instance.new("Part", game.Workspace) wait() end end},
    {Name = "Lag Pulse", Func = function() spawn(function() while wait(1) do for i = 1, 50 do Instance.new("Part", game.Workspace) end end end) end},
    {Name = "Lag Flash", Func = function() for i = 1, 20 do game.Lighting.Brightness = 100 wait(0.1) game.Lighting.Brightness = 0 end end},
    {Name = "Lag Sound", Func = function() for i = 1, 50 do local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s.Pitch = math.random(0.5, 3) s:Play() end end},
    {Name = "Lag TP", Func = function() for i = 1, 50 do LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(math.random(-50, 50), 50, math.random(-50, 50)) wait(0.05) end end},
    {Name = "Lag Full", Func = function() for i = 1, 100 do Instance.new("Part", game.Workspace) local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s:Play() wait(0.01) end end},
    {Name = "Ultimate Lag", Func = function() while true do Instance.new("Part", game.Workspace) game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("LAG!", "All") wait(0.01) end end}
}})
table.insert(tabs, {"Anti-Ban", {
    {Name = "Spoof Name", Func = function() LocalPlayer.Name = "Spoofed" end},
    {Name = "Hide GUI", Func = function() ScreenGui.Enabled = false end},
    {Name = "Fake Ping", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Ping: 10ms", "All") end},
    {Name = "No Kick", Func = function() LocalPlayer.Kick = function() end end},
    {Name = "Silent Mode", Func = function() game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false) end},
    {Name = "Low Profile", Func = function() LocalPlayer.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None end},
    {Name = "Fake Leave", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(LocalPlayer.Name .. " has left the game!", "All") end},
    {Name = "Anti-Detect", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 16 end},
    {Name = "Spoof ID", Func = function() LocalPlayer.UserId = 12345678 end},
    {Name = "No Report", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Reporting disabled!", "All") end},
    {Name = "Clean Chat", Func = function() for i = 1, 20 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "All") wait(0.1) end end},
    {Name = "Fake AFK", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("AFK", "All") end},
    {Name = "Anti-Log", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 16 LocalPlayer.Character.Humanoid.JumpPower = 50 end},
    {Name = "No Trace", Func = function() for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.Transparency = 1 end end end},
    {Name = "Safe Mode", Func = function() LocalPlayer.Character.Humanoid.MaxHealth = 100 end},
    {Name = "Anti-Crash", Func = function() game.Workspace.ChildAdded:Connect(function(child) if child:IsA("Part") then child:Destroy() end end) end},
    {Name = "Spoof Team", Func = function() LocalPlayer.Team = nil end},
    {Name = "No Ban", Func = function() LocalPlayer.Kick = function() print("Kick blocked!") end end},
    {Name = "Anti Full", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 16 LocalPlayer.Character.Humanoid.JumpPower = 50 LocalPlayer.Character.Humanoid.MaxHealth = 100 end},
    {Name = "Ultimate Anti", Func = function() ScreenGui.Enabled = false LocalPlayer.Character.Humanoid.WalkSpeed = 16 LocalPlayer.Character.Humanoid.JumpPower = 50 end}
}})
table.insert(tabs, {"Exploit Tools", {
    {Name = "Kill Player", Func = function() for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then p.Character.Humanoid.Health = 0 end end end},
    {Name = "Teleport Tool", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0) end},
    {Name = "Speed Tool", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 100 end},
    {Name = "Jump Tool", Func = function() LocalPlayer.Character.Humanoid.JumpPower = 100 end},
    {Name = "Invisible Tool", Func = function() for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.Transparency = 1 end end end},
    {Name = "ESP Tool", Func = function() for _, p in pairs(Players:GetPlayers()) do local h = Instance.new("Highlight", p.Character) h.FillColor = Color3.new(1, 0, 0) end end},
    {Name = "God Tool", Func = function() LocalPlayer.Character.Humanoid.MaxHealth = math.huge end},
    {Name = "Fly Tool", Func = function() local bv = Instance.new("BodyVelocity", LocalPlayer.Character.HumanoidRootPart) bv.Velocity = Vector3.new(0, 50, 0) end},
    {Name = "NoClip Tool", Func = function() spawn(function() while wait() do for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end end) end},
    {Name = "Chat Tool", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Hacked!", "All") end},
    {Name = "Sound Tool", Func = function() local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s:Play() end},
    {Name = "GUI Tool", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) t.Text = "TOOL!" end},
    {Name = "Anim Tool", Func = function() local a = Instance.new("Animation") a.AnimationId = "rbxassetid://507771019" LocalPlayer.Character.Humanoid:LoadAnimation(a):Play() end},
    {Name = "Crash Tool", Func = function() for i = 1, 100 do Instance.new("Part", game.Workspace) end end},
    {Name = "Lag Tool", Func = function() for i = 1, 50 do local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s:Play() end end},
    {Name = "Visual Tool", Func = function() game.Lighting.Brightness = 10 end},
    {Name = "Player Tool", Func = function() LocalPlayer.Character.Humanoid.BodyWidthScale.Value = 5 end},
    {Name = "Spawn Tool", Func = function() local t = Instance.new("Tool", LocalPlayer.Backpack) t.Name = "Exploit Tool" end},
    {Name = "Full Tool", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 100 LocalPlayer.Character.Humanoid.JumpPower = 100 LocalPlayer.Character.Humanoid.MaxHealth = math.huge end},
    {Name = "Ultimate Tool", Func = function() for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then p.Character.Humanoid.Health = 0 end end LocalPlayer.Character.Humanoid.WalkSpeed = 100 end}
}})
table.insert(tabs, {"Money Hacks", {
    {Name = "Fake Money", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("You got 1000 cash!", "All") end},
    {Name = "Money Spam", Func = function() for i = 1, 20 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Money: " .. i * 100, "All") wait(0.1) end end},
    {Name = "Rich GUI", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) t.Text = "YOU ARE RICH!" end},
    {Name = "Money Loop", Func = function() spawn(function() while wait(1) do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Cash +100!", "All") end end) end},
    {Name = "Fake Robux", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("You won 1000 Robux!", "All") end},
    {Name = "Money Flash", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) t.Text = "MONEY!" wait(0.5) g:Destroy() end},
    {Name = "Cash Boost", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Cash boosted!", "All") end},
    {Name = "Money Troll", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Everyone lost money!", "All") end},
    {Name = "Money Drop", Func = function() local p = Instance.new("Part", game.Workspace) p.Position = LocalPlayer.Character.HumanoidRootPart.Position p.Name = "Cash" end},
    {Name = "Money Rain", Func = function() for i = 1, 50 do local p = Instance.new("Part", game.Workspace) p.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-50, 50), 50, math.random(-50, 50)) p.Name = "Cash" end end},
    {Name = "Money Hack", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Money hacked!", "All") end},
    {Name = "Infinite Cash", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Infinite cash enabled!", "All") end},
    {Name = "Money Glitch", Func = function() for i = 1, 10 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Cash: " .. i * 1000, "All") wait(0.1) end end},
    {Name = "Money Spam", Func = function() for i = 1, 50 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("MONEY " .. i, "All") wait(0.05) end end},
    {Name = "Money Fake", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Fake money added!", "All") end},
    {Name = "Money GUI", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(0.5, 0, 0.5, 0) t.Text = "CASH: 999999" end},
    {Name = "Money Boost", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Cash x10!", "All") end},
    {Name = "Money Clear", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Money reset!", "All") end},
    {Name = "Money Full", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Max money!", "All") local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) t.Text = "FULL MONEY!" end},
    {Name = "Ultimate Money", Func = function() for i = 1, 20 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Cash: " .. i * 10000, "All") wait(0.1) end end}
}})
table.insert(tabs, {"Weapon Hacks", {
    {Name = "Spawn Sword", Func = function() local t = Instance.new("Tool", LocalPlayer.Backpack) t.Name = "Sword" end},
    {Name = "Spawn Gun", Func = function() local t = Instance.new("Tool", LocalPlayer.Backpack) t.Name = "Gun" end},
    {Name = "Rapid Fire", Func = function() spawn(function() while wait(0.1) do for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then p.Character.Humanoid:TakeDamage(5) end end end end) end},
    {Name = "One Shot", Func = function() for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then p.Character.Humanoid.Health = 0 end end end},
    {Name = "Infinite Ammo", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Infinite ammo!", "All") end},
    {Name = "Big Weapon", Func = function() for _, t in pairs(LocalPlayer.Backpack:GetChildren()) do if t:IsA("Tool") then t.Handle.Size = Vector3.new(5, 5, 5) end end end},
    {Name = "Fast Reload", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Fast reload!", "All") end},
    {Name = "No Recoil", Func = function() spawn(function() while wait() do game.Workspace.CurrentCamera.CFrame = game.Workspace.CurrentCamera.CFrame * CFrame.Angles(0, 0, 0) end end) end},
    {Name = "Weapon ESP", Func = function() for _, w in pairs(game.Workspace:GetDescendants()) do if w.Name == "Weapon" then local h = Instance.new("Highlight", w) h.FillColor = Color3.new(0, 0, 1) end end end},
    {Name = "Auto Aim", Func = function() spawn(function() while wait() do for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, p.Character.HumanoidRootPart.Position) end end end end) end},
    {Name = "Weapon Drop", Func = function() local t = Instance.new("Tool", game.Workspace) t.Name = "Dropped Gun" t.Position = LocalPlayer.Character.HumanoidRootPart.Position end},
    {Name = "Weapon Spam", Func = function() for i = 1, 10 do local t = Instance.new("Tool", LocalPlayer.Backpack) t.Name = "Gun " .. i end end},
    {Name = "Silent Weapon", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Silent shots!", "All") end},
    {Name = "Weapon Glow", Func = function() for _, t in pairs(LocalPlayer.Backpack:GetChildren()) do if t:IsA("Tool") then local h = Instance.new("Highlight", t.Handle) h.FillColor = Color3.new(1, 0, 0) end end end},
    {Name = "Weapon Hack", Func = function() for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then p.Character.Humanoid:TakeDamage(50) end end end},
    {Name = "Weapon Speed", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 50 end},
    {Name = "Weapon Jump", Func = function() LocalPlayer.Character.Humanoid.JumpPower = 100 end},
    {Name = "Weapon Full", Func = function() local t = Instance.new("Tool", LocalPlayer.Backpack) t.Name = "Ultimate Gun" for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then p.Character.Humanoid.Health = 0 end end end},
    {Name = "Weapon Troll", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Weapon hacked!", "All") end},
    {Name = "Ultimate Weapon", Func = function() local t = Instance.new("Tool", LocalPlayer.Backpack) t.Name = "God Gun" spawn(function() while wait(0.1) do for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then p.Character.Humanoid:TakeDamage(10) end end end end) end}
}})
table.insert(tabs, {"Vehicle Hacks", {
    {Name = "Spawn Car", Func = function() local v = Instance.new("VehicleSeat", game.Workspace) v.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0) end},
    {Name = "Fast Car", Func = function() for _, v in pairs(game.Workspace:GetDescendants()) do if v:IsA("VehicleSeat") then v.MaxSpeed = 100 end end end},
    {Name = "Fly Car", Func = function() for _, v in pairs(game.Workspace:GetDescendants()) do if v:IsA("VehicleSeat") then local bv = Instance.new("BodyVelocity", v) bv.Velocity = Vector3.new(0, 50, 0) end end end},
    {Name = "Car ESP", Func = function() for _, v in pairs(game.Workspace:GetDescendants()) do if v:IsA("VehicleSeat") then local h = Instance.new("Highlight", v) h.FillColor = Color3.new(1, 0, 0) end end end},
    {Name = "Teleport Car", Func = function() for _, v in pairs(game.Workspace:GetDescendants()) do if v:IsA("VehicleSeat") then v.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame end end end},
    {Name = "Big Car", Func = function() for _, v in pairs(game.Workspace:GetDescendants()) do if v:IsA("VehicleSeat") then v.Size = Vector3.new(10, 10, 10) end end end},
    {Name = "Car Spam", Func = function() for i = 1, 10 do local v = Instance.new("VehicleSeat", game.Workspace) v.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-50, 50), 5, math.random(-50, 50)) end end},
    {Name = "Car Explode", Func = function() for _, v in pairs(game.Workspace:GetDescendants()) do if v:IsA("VehicleSeat") then local e = Instance.new("Explosion", v) e.Position = v.Position end end end},
    {Name = "Car Troll", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Cars hacked!", "All") end},
    {Name = "Car Speed", Func = function() for _, v in pairs(game.Workspace:GetDescendants()) do if v:IsA("VehicleSeat") then v.MaxSpeed = 200 end end end},
    {Name = "Car Jump", Func = function() for _, v in pairs(game.Workspace:GetDescendants()) do if v:IsA("VehicleSeat") then v.Velocity = Vector3.new(0, 100, 0) end end end},
    {Name = "Car NoClip", Func = function() for _, v in pairs(game.Workspace:GetDescendants()) do if v:IsA("VehicleSeat") then v.CanCollide = false end end end},
    {Name = "Car Glow", Func = function() for _, v in pairs(game.Workspace:GetDescendants()) do if v:IsA("VehicleSeat") then local h = Instance.new("Highlight", v) h.FillColor = Color3.new(0, 1, 0) end end end},
    {Name = "Car TP", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace:FindFirstChildOfClass("VehicleSeat").CFrame end},
    {Name = "Car Destroy", Func = function() for _, v in pairs(game.Workspace:GetDescendants()) do if v:IsA("VehicleSeat") then v:Destroy() end end end},
    {Name = "Car Boost", Func = function() for _, v in pairs(game.Workspace:GetDescendants()) do if v:IsA("VehicleSeat") then v.Velocity = v.CFrame.LookVector * 100 end end end},
    {Name = "Car Fly", Func = function() for _, v in pairs(game.Workspace:GetDescendants()) do if v:IsA("VehicleSeat") then local bv = Instance.new("BodyVelocity", v) bv.Velocity = Vector3.new(0, 100, 0) end end end},
    {Name = "Car Hack", Func = function() for _, v in pairs(game.Workspace:GetDescendants()) do if v:IsA("VehicleSeat") then v.MaxSpeed = 500 end end end},
    {Name = "Car Full", Func = function() local v = Instance.new("VehicleSeat", game.Workspace) v.Position = LocalPlayer.Character.HumanoidRootPart.Position v.MaxSpeed = 200 local bv = Instance.new("BodyVelocity", v) bv.Velocity = Vector3.new(0, 50, 0) end},
    {Name = "Ultimate Car", Func = function() for _, v in pairs(game.Workspace:GetDescendants()) do if v:IsA("VehicleSeat") then v.MaxSpeed = 1000 v.Size = Vector3.new(20, 20, 20) local h = Instance.new("Highlight", v) h.FillColor = Color3.new(1, 0, 0) end end end}
}})
table.insert(tabs, {"Gravity Hacks", {
    {Name = "Low Gravity", Func = function() game.Workspace.Gravity = 10 end},
    {Name = "High Gravity", Func = function() game.Workspace.Gravity = 200 end},
    {Name = "No Gravity", Func = function() game.Workspace.Gravity = 0 end},
    {Name = "Reverse Gravity", Func = function() game.Workspace.Gravity = -196.2 end},
    {Name = "Random Gravity", Func = function() game.Workspace.Gravity = math.random(0, 200) end},
    {Name = "Gravity Pulse", Func = function() spawn(function() while wait(1) do game.Workspace.Gravity = math.random(0, 100) end end) end},
    {Name = "Gravity Troll", Func = function() game.Workspace.Gravity = 50 end},
    {Name = "Gravity Jump", Func = function() LocalPlayer.Character.Humanoid.JumpPower = 100 game.Workspace.Gravity = 10 end},
    {Name = "Gravity Fly", Func = function() game.Workspace.Gravity = 0 local bv = Instance.new("BodyVelocity", LocalPlayer.Character.HumanoidRootPart) bv.Velocity = Vector3.new(0, 50, 0) end},
    {Name = "Gravity Boost", Func = function() game.Workspace.Gravity = 5 end},
    {Name = "Gravity Reset", Func = function() game.Workspace.Gravity = 196.2 end},
    {Name = "Gravity Flip", Func = function() game.Workspace.Gravity = game.Workspace.Gravity * -1 end},
    {Name = "Gravity Spam", Func = function() for i = 1, 10 do game.Workspace.Gravity = math.random(0, 200) wait(0.5) end end},
    {Name = "Gravity Zero", Func = function() game.Workspace.Gravity = 0 end},
    {Name = "Gravity High", Func = function() game.Workspace.Gravity = 500 end},
    {Name = "Gravity Low", Func = function() game.Workspace.Gravity = 20 end},
    {Name = "Gravity Glitch", Func = function() game.Workspace.Gravity = math.random(-100, 100) end},
    {Name = "Gravity Full", Func = function() game.Workspace.Gravity = 0 LocalPlayer.Character.Humanoid.JumpPower = 200 end},
    {Name = "Gravity Troll All", Func = function() for _, p in pairs(Players:GetPlayers()) do p.Character.Humanoid.JumpPower = 50 end game.Workspace.Gravity = 10 end},
    {Name = "Ultimate Gravity", Func = function() spawn(function() while wait(0.5) do game.Workspace.Gravity = math.random(-200, 200) end end) end}
}})
table.insert(tabs, {"Time Hacks", {
    {Name = "Day Time", Func = function() game.Lighting.ClockTime = 12 end},
    {Name = "Night Time", Func = function() game.Lighting.ClockTime = 0 end},
    {Name = "Fast Time", Func = function() game.Lighting.ClockTime = game.Lighting.ClockTime + 1 end},
    {Name = "Slow Time", Func = function() game.Lighting.ClockTime = game.Lighting.ClockTime - 1 end},
    {Name = "Time Freeze", Func = function() game.Lighting.ClockTime = 12 end},
    {Name = "Time Loop", Func = function() spawn(function() while wait(1) do game.Lighting.ClockTime = math.random(0, 24) end end) end},
    {Name = "Time Troll", Func = function() game.Lighting.ClockTime = 6 end},
    {Name = "Time Flash", Func = function() for i = 1, 10 do game.Lighting.ClockTime = math.random(0, 24) wait(0.5) end end},
    {Name = "Time Reverse", Func = function() game.Lighting.ClockTime = 24 - game.Lighting.ClockTime end},
    {Name = "Time Day", Func = function() game.Lighting.ClockTime = 14 end},
    {Name = "Time Night", Func = function() game.Lighting.ClockTime = 2 end},
    {Name = "Time Random", Func = function() game.Lighting.ClockTime = math.random(0, 24) end},
    {Name = "Time Full", Func = function() game.Lighting.ClockTime = 12 game.Lighting.Brightness = 10 end},
    {Name = "Time Dark", Func = function() game.Lighting.ClockTime = 0 game.Lighting.Brightness = 0 end},
    {Name = "Time Bright", Func = function() game.Lighting.ClockTime = 12 game.Lighting.Brightness = 5 end},
    {Name = "Time Glitch", Func = function() spawn(function() for i = 1, 20 do game.Lighting.ClockTime = math.random(0, 24) wait(0.1) end end) end},
    {Name = "Time Stop", Func = function() game.Lighting.ClockTime = 12 end},
    {Name = "Time Speed", Func = function() spawn(function() while wait(0.1) do game.Lighting.ClockTime = game.Lighting.ClockTime + 0.1 end end) end},
    {Name = "Time Slow", Func = function() spawn(function() while wait(0.1) do game.Lighting.ClockTime = game.Lighting.ClockTime - 0.1 end end) end},
    {Name = "Ultimate Time", Func = function() spawn(function() while wait(0.5) do game.Lighting.ClockTime = math.random(0, 24) game.Lighting.Brightness = math.random(0, 10) end end) end}
}})
table.insert(tabs, {"Weather Hacks", {
    {Name = "Clear Weather", Func = function() game.Lighting.FogEnd = 10000 end},
    {Name = "Foggy Weather", Func = function() game.Lighting.FogEnd = 50 end},
    {Name = "Rain Effect", Func = function() local p = Instance.new("ParticleEmitter", game.Workspace) p.Texture = "rbxassetid://183924671" p.Rate = 100 end},
    {Name = "Snow Effect", Func = function() local p = Instance.new("ParticleEmitter", game.Workspace) p.Texture = "rbxassetid://143666506" p.Rate = 50 end},
    {Name = "Storm Weather", Func = function() game.Lighting.FogEnd = 20 game.Lighting.Brightness = 0 end},
    {Name = "Rainbow Fog", Func = function() spawn(function() while wait(0.5) do game.Lighting.FogColor = Color3.fromHSV(math.random(), 1, 1) end end) end},
    {Name = "Dark Fog", Func = function() game.Lighting.FogEnd = 10 game.Lighting.FogColor = Color3.new(0, 0, 0) end},
    {Name = "Bright Fog", Func = function() game.Lighting.FogEnd = 100 game.Lighting.FogColor = Color3.new(1, 1, 1) end},
    {Name = "Weather Troll", Func = function() game.Lighting.FogEnd = 5 end},
    {Name = "Weather Flash", Func = function() for i = 1, 10 do game.Lighting.FogEnd = math.random(10, 100) wait(0.5) end end},
    {Name = "No Fog", Func = function() game.Lighting.FogEnd = 10000 end},
    {Name = "Heavy Fog", Func = function() game.Lighting.FogEnd = 20 end},
    {Name = "Weather Loop", Func = function() spawn(function() while wait(1) do game.Lighting.FogEnd = math.random(10, 1000) end end) end},
    {Name = "Weather Clear", Func = function() game.Lighting.FogEnd = 10000 game.Lighting.Brightness = 5 end},
    {Name = "Weather Dark", Func = function() game.Lighting.FogEnd = 10 game.Lighting.Brightness = 0 end},
    {Name = "Weather Glitch", Func = function() spawn(function() for i = 1, 20 do game.Lighting.FogEnd = math.random(0, 100) wait(0.1) end end) end},
    {Name = "Weather Rain", Func = function() local p = Instance.new("ParticleEmitter", game.Workspace) p.Texture = "rbxassetid://183924671" p.Rate = 200 end},
    {Name = "Weather Snow", Func = function() local p = Instance.new("ParticleEmitter", game.Workspace) p.Texture = "rbxassetid://143666506" p.Rate = 100 end},
    {Name = "Weather Full", Func = function() game.Lighting.FogEnd = 50 local p = Instance.new("ParticleEmitter", game.Workspace) p.Texture = "rbxassetid://183924671" p.Rate = 150 end},
    {Name = "Ultimate Weather", Func = function() spawn(function() while wait(0.5) do game.Lighting.FogEnd = math.random(10, 1000) game.Lighting.FogColor = Color3.fromHSV(math.random(), 1, 1) end end) end}
}})
table.insert(tabs, {"Team Hacks", {
    {Name = "Team Switch", Func = function() LocalPlayer.Team = Players:GetPlayers()[2].Team end},
    {Name = "No Team", Func = function() LocalPlayer.Team = nil end},
    {Name = "Team ESP", Func = function() for _, p in pairs(Players:GetPlayers()) do if p.Team == LocalPlayer.Team then local h = Instance.new("Highlight", p.Character) h.FillColor = Color3.new(0, 1, 0) end end end},
    {Name = "Enemy ESP", Func = function() for _, p in pairs(Players:GetPlayers()) do if p.Team ~= LocalPlayer.Team then local h = Instance.new("Highlight", p.Character) h.FillColor = Color3.new(1, 0, 0) end end end},
    {Name = "Team TP", Func = function() for _, p in pairs(Players:GetPlayers()) do if p.Team == LocalPlayer.Team then LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame end break end end},
    {Name = "Team Kill", Func = function() for _, p in pairs(Players:GetPlayers()) do if p.Team ~= LocalPlayer.Team then p.Character.Humanoid.Health = 0 end end end},
    {Name = "Team Troll", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Team hacked!", "All") end},
    {Name = "Team Speed", Func = function() for _, p in pairs(Players:GetPlayers()) do if p.Team == LocalPlayer.Team then p.Character.Humanoid.WalkSpeed = 50 end end end},
    {Name = "Team Jump", Func = function() for _, p in pairs(Players:GetPlayers()) do if p.Team == LocalPlayer.Team then p.Character.Humanoid.JumpPower = 100 end end end},
    {Name = "Team God", Func = function() for _, p in pairs(Players:GetPlayers()) do if p.Team == LocalPlayer.Team then p.Character.Humanoid.MaxHealth = math.huge end end end},
    {Name = "Team Invisible", Func = function() for _, p in pairs(Players:GetPlayers()) do if p.Team == LocalPlayer.Team then for _, part in pairs(p.Character:GetDescendants()) do if part:IsA("BasePart") then part.Transparency = 1 end end end end end},
    {Name = "Team Glow", Func = function() for _, p in pairs(Players:GetPlayers()) do if p.Team == LocalPlayer.Team then local h = Instance.new("Highlight", p.Character) h.FillColor = Color3.new(0, 1, 0) end end end},
    {Name = "Team TP All", Func = function() for _, p in pairs(Players:GetPlayers()) do if p.Team == LocalPlayer.Team then p.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame end end end},
    {Name = "Team Freeze", Func = function() for _, p in pairs(Players:GetPlayers()) do if p.Team == LocalPlayer.Team then p.Character.Humanoid.WalkSpeed = 0 end end end},
    {Name = "Team Boost", Func = function() for _, p in pairs(Players:GetPlayers()) do if p.Team == LocalPlayer.Team then p.Character.Humanoid.WalkSpeed = 100 p.Character.Humanoid.JumpPower = 100 end end end},
    {Name = "Team Hack", Func = function() for _, p in pairs(Players:GetPlayers()) do if p.Team ~= LocalPlayer.Team then p.Character.Humanoid:TakeDamage(50) end end end},
    {Name = "Team Full", Func = function() for _, p in pairs(Players:GetPlayers()) do if p.Team == LocalPlayer.Team then p.Character.Humanoid.WalkSpeed = 50 p.Character.Humanoid.JumpPower = 100 p.Character.Humanoid.MaxHealth = math.huge end end end},
    {Name = "Team Clear", Func = function() LocalPlayer.Team = nil end},
    {Name = "Team Random", Func = function() LocalPlayer.Team = Players:GetPlayers()[math.random(1, #Players:GetPlayers())].Team end},
    {Name = "Ultimate Team", Func = function() for _, p in pairs(Players:GetPlayers()) do if p.Team == LocalPlayer.Team then p.Character.Humanoid.WalkSpeed = 100 p.Character.Humanoid.JumpPower = 200 p.Character.Humanoid.MaxHealth = math.huge local h = Instance.new("Highlight", p.Character) h.FillColor = Color3.new(0, 1, 0) end end end}
}})
table.insert(tabs, {"Pet Hacks", {
    {Name = "Spawn Pet", Func = function() local p = Instance.new("Model", game.Workspace) local h = Instance.new("Humanoid", p) local b = Instance.new("Part", p) b.Position = LocalPlayer.Character.HumanoidRootPart.Position end},
    {Name = "Pet Follow", Func = function() local pet = game.Workspace:FindFirstChildOfClass("Model") if pet then spawn(function() while wait() do pet:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position) end end) end end},
    {Name = "Pet Big", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("Model") and p:FindFirstChild("Humanoid") then p.Humanoid.BodyWidthScale.Value = 5 end end end},
    {Name = "Pet Small", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("Model") and p:FindFirstChild("Humanoid") then p.Humanoid.BodyWidthScale.Value = 0.5 end end end},
    {Name = "Pet Glow", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("Model") and p:FindFirstChild("Humanoid") then local h = Instance.new("Highlight", p) h.FillColor = Color3.new(1, 0, 0) end end end},
    {Name = "Pet Invisible", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("Model") and p:FindFirstChild("Humanoid") then for _, part in pairs(p:GetDescendants()) do if part:IsA("BasePart") then part.Transparency = 1 end end end end end},
    {Name = "Pet Speed", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("Model") and p:FindFirstChild("Humanoid") then p.Humanoid.WalkSpeed = 50 end end end},
    {Name = "Pet Jump", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("Model") and p:FindFirstChild("Humanoid") then p.Humanoid.JumpPower = 100 end end end},
    {Name = "Pet TP", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("Model") and p:FindFirstChild("Humanoid") then p:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position) end end end},
    {Name = "Pet Kill", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("Model") and p:FindFirstChild("Humanoid") then p.Humanoid.Health = 0 end end end},
    {Name = "Pet Spam", Func = function() for i = 1, 10 do local p = Instance.new("Model", game.Workspace) local h = Instance.new("Humanoid", p) local b = Instance.new("Part", p) b.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-10, 10), 0, math.random(-10, 10)) end end},
    {Name = "Pet Troll", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Pet hacked!", "All") end},
    {Name = "Pet Fly", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("Model") and p:FindFirstChild("Humanoid") then local bv = Instance.new("BodyVelocity", p:FindFirstChild("Part")) bv.Velocity = Vector3.new(0, 50, 0) end end end},
    {Name = "Pet Hack", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("Model") and p:FindFirstChild("Humanoid") then p.Humanoid.WalkSpeed = 100 end end end},
    {Name = "Pet Full", Func = function() local p = Instance.new("Model", game.Workspace) local h = Instance.new("Humanoid", p) local b = Instance.new("Part", p) b.Position = LocalPlayer.Character.HumanoidRootPart.Position h.WalkSpeed = 50 h.JumpPower = 100 end},
    {Name = "Pet Glow All", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("Model") and p:FindFirstChild("Humanoid") then local h = Instance.new("Highlight", p) h.FillColor = Color3.new(0, 1, 0) end end end},
    {Name = "Pet Attack", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("Model") and p:FindFirstChild("Humanoid") then for _, pl in pairs(Players:GetPlayers()) do if pl ~= LocalPlayer then pl.Character.Humanoid:TakeDamage(10) end end end end end},
    {Name = "Pet Random", Func = function() local p = Instance.new("Model", game.Workspace) local h = Instance.new("Humanoid", p) local b = Instance.new("Part", p) b.Position = Vector3.new(math.random(-100, 100), 50, math.random(-100, 100)) end},
    {Name = "Pet Boost", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("Model") and p:FindFirstChild("Humanoid") then p.Humanoid.WalkSpeed = 100 p.Humanoid.JumpPower = 100 end end end},
    {Name = "Ultimate Pet", Func = function() for i = 1, 5 do local p = Instance.new("Model", game.Workspace) local h = Instance.new("Humanoid", p) local b = Instance.new("Part", p) b.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-20, 20), 0, math.random(-20, 20)) h.WalkSpeed = 100 h.JumpPower = 200 local h = Instance.new("Highlight", p) h.FillColor = Color3.new(1, 0, 0) end end}
}})
table.insert(tabs, {"NPC Hacks", {
    {Name = "Spawn NPC", Func = function() local n = Instance.new("Model", game.Workspace) local h = Instance.new("Humanoid", n) local p = Instance.new("Part", n) p.Position = LocalPlayer.Character.HumanoidRootPart.Position end},
    {Name = "NPC Kill", Func = function() for _, n in pairs(game.Workspace:GetDescendants()) do if n:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(n) then n.Humanoid.Health = 0 end end end},
    {Name = "NPC TP", Func = function() for _, n in pairs(game.Workspace:GetDescendants()) do if n:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(n) then n:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position) end end end},
    {Name = "NPC Speed", Func = function() for _, n in pairs(game.Workspace:GetDescendants()) do if n:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(n) then n.Humanoid.WalkSpeed = 50 end end end},
    {Name = "NPC Jump", Func = function() for _, n in pairs(game.Workspace:GetDescendants()) do if n:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(n) then n.Humanoid.JumpPower = 100 end end end},
    {Name = "NPC Glow", Func = function() for _, n in pairs(game.Workspace:GetDescendants()) do if n:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(n) then local h = Instance.new("Highlight", n) h.FillColor = Color3.new(0, 0, 1) end end end},
    {Name = "NPC Invisible", Func = function() for _, n in pairs(game.Workspace:GetDescendants()) do if n:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(n) then for _, p in pairs(n:GetDescendants()) do if p:IsA("BasePart") then p.Transparency = 1 end end end end end},
    {Name = "NPC Big", Func = function() for _, n in pairs(game.Workspace:GetDescendants()) do if n:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(n) then n.Humanoid.BodyWidthScale.Value = 5 end end end},
    {Name = "NPC Small", Func = function() for _, n in pairs(game.Workspace:GetDescendants()) do if n:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(n) then n.Humanoid.BodyWidthScale.Value = 0.5 end end end},
    {Name = "NPC Spam", Func = function() for i = 1, 10 do local n = Instance.new("Model", game.Workspace) local h = Instance.new("Humanoid", n) local p = Instance.new("Part", n) p.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-10, 10), 0, math.random(-10, 10)) end end},
    {Name = "NPC Troll", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("NPCs hacked!", "All") end},
    {Name = "NPC Fly", Func = function() for _, n in pairs(game.Workspace:GetDescendants()) do if n:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(n) then local bv = Instance.new("BodyVelocity", n:FindFirstChild("Part")) bv.Velocity = Vector3.new(0, 50, 0) end end end},
    {Name = "NPC Hack", Func = function() for _, n in pairs(game.Workspace:GetDescendants()) do if n:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(n) then n.Humanoid.WalkSpeed = 100 end end end},
    {Name = "NPC Full", Func = function() local n = Instance.new("Model", game.Workspace) local h = Instance.new("Humanoid", n) local p = Instance.new("Part", n) p.Position = LocalPlayer.Character.HumanoidRootPart.Position h.WalkSpeed = 50 h.JumpPower = 100 end},
    {Name = "NPC Attack", Func = function() for _, n in pairs(game.Workspace:GetDescendants()) do if n:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(n) then for _, pl in pairs(Players:GetPlayers()) do if pl ~= LocalPlayer then pl.Character.Humanoid:TakeDamage(10) end end end end end},
    {Name = "NPC Random", Func = function() local n = Instance.new("Model", game.Workspace) local h = Instance.new("Humanoid", n) local p = Instance.new("Part", n) p.Position = Vector3.new(math.random(-100, 100), 50, math.random(-100, 100)) end},
    {Name = "NPC Boost", Func = function() for _, n in pairs(game.Workspace:GetDescendants()) do if n:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(n) then n.Humanoid.WalkSpeed = 100 n.Humanoid.JumpPower = 100 end end end},
    {Name = "NPC Glow All", Func = function() for _, n in pairs(game.Workspace:GetDescendants()) do if n:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(n) then local h = Instance.new("Highlight", n) h.FillColor = Color3.new(0, 1, 0) end end end},
    {Name = "NPC Follow", Func = function() for _, n in pairs(game.Workspace:GetDescendants()) do if n:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(n) then spawn(function() while wait() do n:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position) end end) end end end},
    {Name = "Ultimate NPC", Func = function() for i = 1, 5 do local n = Instance.new("Model", game.Workspace) local h = Instance.new("Humanoid", n) local p = Instance.new("Part", n) p.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-20, 20), 0, math.random(-20, 20)) h.WalkSpeed = 100 h.JumpPower = 200 local h = Instance.new("Highlight", n) h.FillColor = Color3.new(1, 0, 0) end end}
}})
table.insert(tabs, {"Map Hacks", {
    {Name = "Map Clear", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("BasePart") then p.Transparency = 1 end end end},
    {Name = "Map ESP", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("BasePart") then local h = Instance.new("Highlight", p) h.FillColor = Color3.new(1, 0, 0) end end end},
    {Name = "Map Destroy", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("BasePart") then p:Destroy() end end end},
    {Name = "Map TP", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0) end},
    {Name = "Map Glow", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("BasePart") then local h = Instance.new("Highlight", p) h.FillTransparency = 0.5 end end end},
    {Name = "Map Invisible", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("BasePart") then p.Transparency = 0.5 end end end},
    {Name = "Map Color", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("BasePart") then p.BrickColor = BrickColor.Random() end end end},
    {Name = "Map Troll", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Map hacked!", "All") end},
    {Name = "Map NoClip", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end},
    {Name = "Map Bright", Func = function() game.Lighting.Brightness = 10 end},
    {Name = "Map Dark", Func = function() game.Lighting.Brightness = 0 end},
    {Name = "Map Fog", Func = function() game.Lighting.FogEnd = 50 end},
    {Name = "Map Clear Fog", Func = function() game.Lighting.FogEnd = 10000 end},
    {Name = "Map Flash", Func = function() for i = 1, 10 do game.Lighting.Brightness = math.random(0, 10) wait(0.5) end end},
    {Name = "Map Full", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("BasePart") then p.Transparency = 0.5 local h = Instance.new("Highlight", p) h.FillColor = Color3.new(1, 0, 0) end end end},
    {Name = "Map Hack", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("BasePart") then p.Size = Vector3.new(10, 10, 10) end end end},
    {Name = "Map TP All", Func = function() for _, pl in pairs(Players:GetPlayers()) do pl.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0) end end},
    {Name = "Map Glitch", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("BasePart") then p.Position = p.Position + Vector3.new(math.random(-10, 10), 0, math.random(-10, 10)) end end end},
    {Name = "Map Boost", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 100 end},
    {Name = "Ultimate Map", Func = function() for _, p in pairs(game.Workspace:GetDescendants()) do if p:IsA("BasePart") then p.Transparency = 0.5 p.CanCollide = false local h = Instance.new("Highlight", p) h.FillColor = Color3.new(1, 0, 0) end end game.Lighting.Brightness = 10 end}
}})
table.insert(tabs, {"Event Hacks", {
    {Name = "Event Trigger", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Event started!", "All") end},
    {Name = "Event Spam", Func = function() for i = 1, 20 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Event " .. i, "All") wait(0.1) end end},
    {Name = "Event TP", Func = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0) end},
    {Name = "Event Speed", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 100 end},
    {Name = "Event Jump", Func = function() LocalPlayer.Character.Humanoid.JumpPower = 100 end},
    {Name = "Event God", Func = function() LocalPlayer.Character.Humanoid.MaxHealth = math.huge end},
    {Name = "Event Invisible", Func = function() for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.Transparency = 1 end end end},
    {Name = "Event Glow", Func = function() local h = Instance.new("Highlight", LocalPlayer.Character) h.FillColor = Color3.new(1, 0, 0) end},
    {Name = "Event Troll", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Event hacked!", "All") end},
    {Name = "Event Flash", Func = function() for i = 1, 10 do game.Lighting.Brightness = math.random(0, 10) wait(0.5) end end},
    {Name = "Event Fog", Func = function() game.Lighting.FogEnd = 50 end},
    {Name = "Event Clear", Func = function() game.Lighting.FogEnd = 10000 end},
    {Name = "Event Boost", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 50 LocalPlayer.Character.Humanoid.JumpPower = 100 end},
    {Name = "Event Hack", Func = function() for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then p.Character.Humanoid:TakeDamage(50) end end end},
    {Name = "Event Full", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 100 LocalPlayer.Character.Humanoid.JumpPower = 100 LocalPlayer.Character.Humanoid.MaxHealth = math.huge end},
    {Name = "Event GUI", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) t.Text = "EVENT HACKED!" end},
    {Name = "Event Sound", Func = function() local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s:Play() end},
    {Name = "Event Spam", Func = function() for i = 1, 10 do local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s:Play() wait(0.5) end end},
    {Name = "Event Crash", Func = function() for i = 1, 100 do Instance.new("Part", game.Workspace) end end},
    {Name = "Ultimate Event", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 200 LocalPlayer.Character.Humanoid.JumpPower = 200 LocalPlayer.Character.Humanoid.MaxHealth = math.huge game:GetService("ReplicatedStorage").DefaultChatSystemVectors.SayMessageRequest:FireServer("Ultimate event!", "All") end}
}})
table.insert(tabs, {"Trade Hacks", {
    {Name = "Fake Trade", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Trade completed!", "All") end},
    {Name = "Trade Spam", Func = function() for i = 1, 20 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Trade " .. i, "All") wait(0.1) end end},
    {Name = "Trade GUI", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) t.Text = "TRADE HACKED!" end},
    {Name = "Trade Troll", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Trade failed!", "All") end},
    {Name = "Trade Boost", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Trade boosted!", "All")
      table.insert(tabs, {"Trade Hacks", {
    {Name = "Fake Trade", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Trade completed!", "All") end},
    {Name = "Trade Spam", Func = function() for i = 1, 20 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Trade " .. i, "All") wait(0.1) end end},
    {Name = "Trade GUI", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) t.Text = "TRADE HACKED!" end},
    {Name = "Trade Troll", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Trade failed!", "All") end},
    {Name = "Trade Boost", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Trade boosted!", "All") end},
    {Name = "Trade Clear", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Trade reset!", "All") end},
    {Name = "Trade Flash", Func = function() local g = Instance.new("ScreenGui", game.CoreGui) local t = Instance.new("TextLabel", g) t.Size = UDim2.new(1, 0, 1, 0) t.Text = "TRADE!" wait(0.5) g:Destroy() end},
    {Name = "Trade Hack", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Trade hacked!", "All") end},
    {Name = "Trade Spam All", Func = function() for i = 1, 50 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("TRADE " .. i, "All") wait(0.05) end end},
    {Name = "Trade Fake Win", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("You won the trade!", "All") end},
    {Name = "Trade Loop", Func = function() spawn(function() while wait(1) do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Trading...", "All") end end) end},
    {Name = "Trade Sound", Func = function() local s = Instance.new("Sound", game.Workspace) s.SoundId = "rbxassetid://1046135188" s:Play() end},
    {Name = "Trade Glow", Func = function() local h = Instance.new("Highlight", LocalPlayer.Character) h.FillColor = Color3.new(1, 0, 0) end},
    {Name = "Trade Speed", Func = function() LocalPlayer.Character.Humanoid.WalkSpeed = 100 end},
    {Name = "Trade Jump", Func = function() LocalPlayer.Character.Humanoid.JumpPower = 100 end},
    {Name = "Trade God", Func = function() LocalPlayer.Character.Humanoid.MaxHealth = math.huge end},
    {Name = "Trade Invisible", Func = function() for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.Transparency = 1 end end end},
    {Name = "Trade Crash", Func = function() for i = 1, 100 do Instance.new("Part", game.Workspace) end end},
    {Name = "Trade Full", Func = function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Trade maxed!", "All") LocalPlayer.Character.Humanoid.WalkSpeed = 100 end},
    {Name = "Ultimate Trade", Func = function() for i = 1, 20 do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Trade " .. i * 100, "All") wait(0.1) end LocalPlayer.Character.Humanoid.WalkSpeed = 200 end}
}})

-- Jumpscare Özelliği
local function Jumpscare()
    local gui = Instance.new("ScreenGui", game.CoreGui)
    gui.Name = "JumpscareGui"
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    local image = Instance.new("ImageLabel", frame)
    image.Size = UDim2.new(1, 0, 1, 0)
    image.Image = "rbxassetid://183924671" -- Jumpscare resmi (örnek bir ID)
    local sound = Instance.new("Sound", gui)
    sound.SoundId = "rbxassetid://1046135188" -- Korkutucu ses
    sound.Volume = 10
    sound:Play()
    wait(1)
    gui:Destroy()
end

-- GUI Oluşturma (Önceki kodla birleştirilmiş)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "HackerGui"
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.new(1, 0, 0)

local TabFrame = Instance.new("Frame", MainFrame)
TabFrame.Size = UDim2.new(0, 150, 1, 0)
TabFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)

local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(0, 450, 1, 0)
ContentFrame.Position = UDim2.new(0, 150, 0, 0)
ContentFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)

local TabList = Instance.new("ScrollingFrame", TabFrame)
TabList.Size = UDim2.new(1, 0, 1, 0)
TabList.CanvasSize = UDim2.new(0, 0, 0, #tabs * 30)
TabList.BackgroundTransparency = 1

local ContentList = Instance.new("ScrollingFrame", ContentFrame)
ContentList.Size = UDim2.new(1, 0, 1, 0)
ContentList.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentList.BackgroundTransparency = 1

for i, tab in pairs(tabs) do
    local TabButton = Instance.new("TextButton", TabList)
    TabButton.Size = UDim2.new(1, -10, 0, 25)
    TabButton.Position = UDim2.new(0, 5, 0, (i-1) * 30)
    TabButton.Text = tab[1]
    TabButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    TabButton.TextColor3 = Color3.new(1, 1, 1)
    TabButton.MouseButton1Click:Connect(function()
        ContentList.CanvasSize = UDim2.new(0, 0, 0, #tab[2] * 30)
        for _, child in pairs(ContentList:GetChildren()) do child:Destroy() end
        for j, hack in pairs(tab[2]) do
            local HackButton = Instance.new("TextButton", ContentList)
            HackButton.Size = UDim2.new(1, -10, 0, 25)
            HackButton.Position = UDim2.new(0, 5, 0, (j-1) * 30)
            HackButton.Text = hack.Name
            HackButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
            HackButton.TextColor3 = Color3.new(1, 1, 1)
            HackButton.MouseButton1Click:Connect(function()
                hack.Func()
                if math.random(1, 10) == 1 then -- %10 şansla jumpscare
                    Jumpscare()
                end
            end)
        end
    end)
end

-- Scriptin başlangıç mesajı
game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("En İyi Hacker Scripti by mobblockk - 600+ Hack Aktif!", "All")
                      end
            end)
        end
    end)
end
          
