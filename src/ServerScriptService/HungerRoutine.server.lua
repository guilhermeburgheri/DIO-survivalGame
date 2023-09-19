local Players = game:GetService("Players")
local PlayerModule = require(game.ServerStorage.Modules.PlayerModule)

-- CONSTANTS
local coreLoopInterval = 2
local hungerDecrement = 1

local function coreLoop(player)
    while true do
        if PlayerModule.IsLoaded(player) then
            local currentHunger = PlayerModule.GetHunger(player)
            PlayerModule.SetHunger(player, currentHunger - hungerDecrement)
        end
        wait(coreLoopInterval)
    end
end

local function onPlayerAdded(player: Player)
    spawn(function()
        coreLoop(player)
    end)
end

local function onPlayerRemoving(player: Player)
    print(PlayerModule.GetHunger(player))
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)