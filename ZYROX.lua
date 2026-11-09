
-- ZYROX UI - DRAGGABLE VERSION
-- Für Roblox Studio / eigene Testmap

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local enabled = false
local dragging = false
local dragStart, startPos

local gui = Instance.new("ScreenGui")
gui.Name = "ZYROX"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(290, 190)
frame.Position = UDim2.new(0, 25, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius =
    UDim.new(0, 12)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(190, 25, 40)
stroke.Thickness = 1.5

-- HEADER
local header = Instance.new("TextButton")
header.Size = UDim2.new(1, 0, 0, 48)
header.BackgroundColor3 = Color3.fromRGB(130, 15, 28)
header.Text = "  ZYROX     |     DRAG TO MOVE"
header.TextColor3 = Color3.new(1, 1, 1)
header.TextSize = 15
header.Font = Enum.Font.GothamBold
header.Parent = frame

Instance.new("UICorner", header).CornerRadius =
    UDim.new(0, 12)

-- DRAG FUNCTION
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart

        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
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
status.Size = UDim2.new(1, -30, 0, 30)
status.Position = UDim2.fromOffset(15, 60)
status.BackgroundTransparency = 1
status.Text = "STATUS: OFFLINE"
status.TextColor3 = Color3.fromRGB(220, 70, 70)
status.Font = Enum.Font.GothamBold
status.TextSize = 14
status.Parent = frame

-- TOGGLE
local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -30, 0, 42)
button.Position = UDim2.fromOffset(15, 105)
button.BackgroundColor3 = Color3.fromRGB(155, 20, 35)
button.Text = "AUTO GRAB: OFF"
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.GothamBold
button.TextSize = 14
button.Parent = frame

Instance.new("UICorner", button).CornerRadius =
    UDim.new(0, 8)

button.MouseButton1Click:Connect(function()
    enabled = not enabled

    if enabled then
        button.Text = "AUTO GRAB: ON"
        status.Text = "STATUS: ACTIVE"
        status.TextColor3 = Color3.fromRGB(70, 220, 120)
    else
        button.Text = "AUTO GRAB: OFF"
        status.Text = "STATUS: OFFLINE"
        status.TextColor3 = Color3.fromRGB(220, 70, 70)
    end
end)

-- FOOTER
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 22)
footer.Position = UDim2.new(0, 0, 1, -25)
footer.BackgroundTransparency = 1
footer.Text = "ZYROX  •  PRIVATE TEST BUILD"
footer.TextColor3 = Color3.fromRGB(120, 120, 130)
footer.TextSize = 10
footer.Font = Enum.Font.Gotham
footer.Parent = frame
