local PlayerModule = {}

--SERVCIES
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

-- CONSTANTS
local PLAYER_DEFAULT_DATA = {
    hunger = 50,
    inventory = {},
    level = 1,
}

-- MEMBERS
local playersCached = {} --- Dictionary with all players in the game]
local database = DataStoreService:GetDataStore("Survival")

function PlayerModule.IsLoaded(player: Player): boolean
    local isLoaded = playersCached[player.UserId] and true or false
    return isLoaded
end

--- Gets hunger of given player
function PlayerModule.SetHunger(player: Player, hunger: number)
    playersCached[player.UserId].hunger = hunger
end
--- Gets hunger of given player
function PlayerModule.GetHunger(player: Player): number
    return playersCached[player.UserId].hunger
end

local function onPlayerAdded(player: Player)
    player.CharacterAdded:Connect(function(_)
        local data = database:GetAsync(player.UserId)
        if not data then
            data = PLAYER_DEFAULT_DATA
        end
        playersCached[player.UserId] = data
    end)
end

local function onPlayerRemoving(player: Player)
    database:SetAsync(player.UserId, playersCached[player.UserId])
    playersCached[player.UserId] =  nil
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

return PlayerModule