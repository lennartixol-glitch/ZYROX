
-- ZYROX V2
-- Für eigene Roblox-Testmaps

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

local active = false
local interval = 0.1

local gui = Instance.new("ScreenGui")
gui.Name = "ZYROX"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(280, 185)
main.Position = UDim2.new(0, 30, 0, 100)
main.BackgroundColor3 = Color3.fromRGB(15,15,19)
main.Active = true
main.Parent = gui

Instance.new("UICorner", main).CornerRadius =
    UDim.new(0,12)

local border = Instance.new("UIStroke", main)
border.Color = Color3.fromRGB(190,20,35)
border.Thickness = 2

-- HEADER
local header = Instance.new("TextButton")
header.Size = UDim2.new(1,0,0,45)
header.BackgroundColor3 = Color3.fromRGB(130,10,25)
header.Text = "ZYROX V2  |  DRAG HERE"
header.TextColor3 = Color3.new(1,1,1)
header.Font = Enum.Font.GothamBold
header.TextSize = 15
header.Parent = main

Instance.new("UICorner",header).CornerRadius =
    UDim.new(0,10)

-- DRAG
local dragging = false
local dragStart
local startPosition
local dragInput

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
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
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- STATUS
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1,-20,0,30)
status.Position = UDim2.fromOffset(10,55)
status.BackgroundTransparency = 1
status.Text = "STATUS: OFF"
status.TextColor3 = Color3.fromRGB(220,70,70)
status.Font = Enum.Font.GothamBold
status.TextSize = 14
status.Parent = main

-- BUTTON
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

-- TEST GRAB LOOP
button.MouseButton1Click:Connect(function()
    active = not active

    button.Text = active and "AUTO GRAB: ON"
        or "AUTO GRAB: OFF"

    status.Text = active and "STATUS: ACTIVE"
        or "STATUS: OFF"

    status.TextColor3 = active
        and Color3.fromRGB(70,220,120)
        or Color3.fromRGB(220,70,70)
end)

-- Testintervall für eigene Testlogik
task.spawn(function()
    while gui.Parent do
        if active then
            local folder = workspace:FindFirstChild("Brainrots")

            if folder then
                for _, object in ipairs(folder:GetDescendants()) do
                    if not active then break end

                    if object:IsA("ProximityPrompt") then
                        -- Nur Testobjekte anzeigen.
                        -- Keine fremden Spielmechaniken auslösen.
                    end
                end
            end
        end

        task.wait(interval)
    end
end)
