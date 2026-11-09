
-- ZYROX AUTO GRAB
-- Nur für deine eigene Roblox-Testmap

local Players = game:GetService("Players")
local folder = workspace:WaitForChild("Brainrots")

local INTERVAL = 0.1
local MAX_DISTANCE = 12

local function grabBrainrot(player, brainrot)
    if not brainrot or not brainrot:IsA("BasePart") then
        return
    end

    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")

    if not root then return end

    if (root.Position - brainrot.Position).Magnitude > MAX_DISTANCE then
        return
    end

    if brainrot:GetAttribute("Grabbed") then
        return
    end

    brainrot:SetAttribute("Grabbed", true)
    brainrot:SetNetworkOwner(nil)

    brainrot.Anchored = false
    brainrot.CanCollide = false

    local weld = Instance.new("WeldConstraint")
    weld.Part0 = root
    weld.Part1 = brainrot
    weld.Parent = brainrot

    brainrot.CFrame = root.CFrame * CFrame.new(0, 0, -3)
end

while true do
    for _, player in ipairs(Players:GetPlayers()) do
        for _, brainrot in ipairs(folder:GetChildren()) do
            if brainrot:IsA("BasePart") then
                grabBrainrot(player, brainrot)
            end
        end
    end

    task.wait(INTERVAL)
end
