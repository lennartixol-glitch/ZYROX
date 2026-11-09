
-- ZYROX V4
-- Auto Grab für eigene Roblox-Testmap

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local active = false
local interval = 0.1
local maxDistance = 12

local gui = Instance.new("ScreenGui")
gui.Name = "ZYROX"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(280, 210)
main.Position = UDim2.fromOffset(30, 100)
main.BackgroundColor3 = Color3.fromRGB(15,15,19)
main.Active = true
main.Parent = gui

Instance.new("UICorner",main).CornerRadius =
    UDim.new(0,12)

local stroke = Instance.new("UIStroke",main)
stroke.Color = Color3.fromRGB(190,20,35)
stroke.Thickness = 2

local header = Instance.new("TextButton")
header.Size = UDim2.new(1,0,0,45)
header.BackgroundColor3 = Color3.fromRGB(130,10,25)
header.Text = "ZYROX V4"
header.TextColor3 = Color3.new(1,1,1)
header.Font = Enum.Font.GothamBold
header.TextSize = 16
header.Parent = main

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1,0,0,35)
status.Position = UDim2.fromOffset(0,55)
status.BackgroundTransparency = 1
status.Text = "STATUS: OFF"
status.TextColor3 = Color3.fromRGB(220,70,70)
status.Font = Enum.Font.GothamBold
status.TextSize = 14
status.Parent = main

local button = Instance.new("TextButton")
button.Size = UDim2.new(1,-30,0,45)
button.Position = UDim2.fromOffset(15,105)
button.BackgroundColor3 = Color3.fromRGB(160,15,30)
button.Text = "AUTO GRAB: OFF"
button.TextColor3 = Color3.new(1,1,1)
button.Font = Enum.Font.GothamBold
button.TextSize = 14
button.Parent = main

Instance.new("UICorner",button).CornerRadius =
    UDim.new(0,8)

local info = Instance.new("TextLabel")
info.Size = UDim2.new(1,0,0,30)
info.Position = UDim2.fromOffset(0,160)
info.BackgroundTransparency = 1
info.Text = "KEY: E | RANGE: 12 | SPEED: 0.1"
info.TextColor3 = Color3.new(1,1,1)
info.Font = Enum.Font.Gotham
info.TextSize = 10
info.Parent = main

button.MouseButton1Click:Connect(function()
    active = not active

    button.Text = active and "AUTO GRAB: ON"
        or "AUTO GRAB: OFF"

    button.BackgroundColor3 = active
        and Color3.fromRGB(20,130,65)
        or Color3.fromRGB(160,15,30)

    status.Text = active
        and "STATUS: ACTIVE"
        or "STATUS: OFF"

    status.TextColor3 = active
        and Color3.fromRGB(70,220,120)
        or Color3.fromRGB(220,70,70)
end)

-- Drag system
local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Auto Grab: eigene Testmap
task.spawn(function()
    local remote = ReplicatedStorage:WaitForChild("ZYROXGrab")
    local folder = workspace:WaitForChild("Brainrots")

    while gui.Parent do
        if active then
            local character = player.Character
            local root = character and character:FindFirstChild("HumanoidRootPart")

            if root then
                local nearest
                local shortest = maxDistance

                for _, object in ipairs(folder:GetChildren()) do
                    if object:IsA("BasePart")
                        and not object:GetAttribute("Grabbed") then

                        local distance =
                            (root.Position - object.Position).Magnitude

                        if distance < shortest then
                            shortest = distance
                            nearest = object
                        end
                    end
                end

                if nearest then
                    remote:FireServer(nearest)
                end
            end
        end

        task.wait(interval)
    end
end)
