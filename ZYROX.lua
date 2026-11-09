
-- ZYROX AUTO GRAB
-- Für eine eigene Roblox-Testmap

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local enabled = false
local interval = 0.1

local gui = Instance.new("ScreenGui")
gui.Name = "ZYROX"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 160)
frame.Position = UDim2.new(0.5, -130, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
title.Text = "ZYROX AUTO GRAB"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 20
title.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0.8, 0, 0, 40)
button.Position = UDim2.new(0.1, 0, 0, 60)
button.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
button.TextColor3 = Color3.new(1, 1, 1)
button.Text = "AUTO GRAB: OFF"
button.Parent = frame

button.MouseButton1Click:Connect(function()
    enabled = not enabled
    button.Text = enabled and "AUTO GRAB: ON" or "AUTO GRAB: OFF"
end)

task.spawn(function()
    while true do
        if enabled then
            local folder = workspace:FindFirstChild("Brainrots")

            if folder then
                for _, object in ipairs(folder:GetDescendants()) do
                    if not enabled then break end

                    if object:IsA("ProximityPrompt") then
                        local character = player.Character
                        local root = character and character:FindFirstChild("HumanoidRootPart")
                        local part = object.Parent

                        if root and part:IsA("BasePart")
                            and (root.Position - part.Position).Magnitude < 12 then
                            object:InputHoldBegin()
                            task.wait(0.1)
                            object:InputHoldEnd()
                        end
                    end
                end
            end
        end

        task.wait(interval)
    end
end)
