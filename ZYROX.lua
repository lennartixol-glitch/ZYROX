
-- ZYROX V3 - AUTO GRAB
-- Eigene Roblox-Testmap

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local active = false

local gui = Instance.new("ScreenGui")
gui.Name = "ZYROX"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(280, 190)
main.Position = UDim2.fromOffset(30, 100)
main.BackgroundColor3 = Color3.fromRGB(15,15,19)
main.Active = true
main.Parent = gui

Instance.new("UICorner",main).CornerRadius =
    UDim.new(0,12)

local border = Instance.new("UIStroke",main)
border.Color = Color3.fromRGB(190,20,35)
border.Thickness = 2

local header = Instance.new("TextButton")
header.Size = UDim2.new(1,0,0,45)
header.BackgroundColor3 = Color3.fromRGB(130,10,25)
header.Text = "ZYROX V3  |  DRAG HERE"
header.TextColor3 = Color3.new(1,1,1)
header.Font = Enum.Font.GothamBold
header.Parent = main

local dragging = false
local dragStart
local startPos

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1,0,0,35)
status.Position = UDim2.fromOffset(0,55)
status.BackgroundTransparency = 1
status.Text = "STATUS: OFF"
status.TextColor3 = Color3.fromRGB(220,70,70)
status.Parent = main

local button = Instance.new("TextButton")
button.Size = UDim2.new(1,-30,0,45)
button.Position = UDim2.fromOffset(15,105)
button.BackgroundColor3 = Color3.fromRGB(160,15,30)
button.Text = "AUTO GRAB: OFF"
button.TextColor3 = Color3.new(1,1,1)
button.Font = Enum.Font.GothamBold
button.Parent = main

Instance.new("UICorner",button).CornerRadius =
    UDim.new(0,8)

button.MouseButton1Click:Connect(function()
    active = not active
    button.Text = active and "AUTO GRAB: ON" or "AUTO GRAB: OFF"
    status.Text = active and "STATUS: ACTIVE" or "STATUS: OFF"
    status.TextColor3 = active
        and Color3.fromRGB(70,220,120)
        or Color3.fromRGB(220,70,70)
end)

