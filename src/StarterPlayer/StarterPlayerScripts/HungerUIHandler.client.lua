local PlayerHungerUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerHungerUpdated

-- SERVICES
local Players = game:GetService("Players")

-- CONSTANTS
local BarFullColor = Color3.fromRGB(68, 255, 0)
local BarLowCollor = Color3.fromRGB(255, 55, 48)

-- MEMBERS
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local hud: ScreenGui = PlayerGui:WaitForChild("HUD")
local leftBar: Frame = hud:WaitForChild("LeftBar")
local hungerUi: Frame = leftBar:WaitForChild("Hunger")
local hungerBar: Frame = hungerUi:WaitForChild("Bar")

PlayerHungerUpdated.OnClientEvent:Connect(function(hunger: number)
    -- Updates the hunger bar x axis size
    hungerBar.Size = UDim2.fromScale(hunger/100, hungerBar.Size.Y.Scale)

    -- Upadate the bar's color according to the hunger value
    if hungerBar.Size.X.Scale > 0.5 then
        hungerBar.BackgroundColor3 = BarFullColor
    else
        hungerBar.BackgroundColor3 = BarLowCollor
    end
end)