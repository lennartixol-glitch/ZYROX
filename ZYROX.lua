
-- ZYROX V4
-- Safe Lua UI

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local active = false
local range = 12
local speed = 0.1

local gui = Instance.new("ScreenGui")
gui.Name = "ZYROX_V4"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(280, 230)
main.Position = UDim2.fromOffset(30, 100)
main.BackgroundColor3 = Color3.fromRGB(15,15,19)
main.Active = true
main.Parent = gui

Instance.new("UICorner", main).CornerRadius =
    UDim.new(0,12)

local stroke = Instance.new("UIStroke", main)
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
status.Size = UDim2.new(1,0,0,30)
status.Position = UDim2.fromOffset(0,55)
status.BackgroundTransparency = 1
status.Text = "STATUS: OFF"
status.TextColor3 = Color3.fromRGB(220,70,70)
status.Font = Enum.Font.GothamBold
status.TextSize = 14
status.Parent = main

local button = Instance.new("TextButton")
button.Size = UDim2.new(1,-30,0,42)
button.Position = UDim2.fromOffset(15,95)
button.BackgroundColor3 = Color3.fromRGB(160,15,30)
button.Text = "AUTO GRAB: OFF"
button.TextColor3 = Color3.new(1,1,1)
button.Font = Enum.Font.GothamBold
button.TextSize = 14
button.Parent = main

Instance.new("UICorner",button).CornerRadius =
    UDim.new(0,8)

local info = Instance.new("TextLabel")
info.Size = UDim2.new(1,0,0,50)
info.Position = UDim2.fromOffset(0,155)
info.BackgroundTransparency = 1
info.Text = "RANGE: 12 | SPEED: 0.1"
info.TextColor3 = Color3.fromRGB(220,220,220)
info.Font = Enum.Font.Gotham
info.TextSize = 12
info.Parent = main

button.MouseButton1Click:Connect(function()
    active = not active

    if active then
        button.Text = "AUTO GRAB: ON"
        button.BackgroundColor3 = Color3.fromRGB(20,130,65)
        status.Text = "STATUS: ACTIVE"
        status.TextColor3 = Color3.fromRGB(70,220,120)
    else
        button.Text = "AUTO GRAB: OFF"
        button.BackgroundColor3 = Color3.fromRGB(160,15,30)
        status.Text = "STATUS: OFF"
        status.TextColor3 = Color3.fromRGB(220,70,70)
    end
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
