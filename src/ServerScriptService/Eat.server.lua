-- SERVICES
local ProximityPromptService = game:GetService("ProximityPromptService")

-- CONSTANT
local ProximityAction = "Eat"

-- MEMBERS
local PlayerModule = require(game.ServerStorage.Modules.PlayerModule)
local PlayerHungerUpdated:RemoteEvent = game.ReplicatedStorage.Network.PlayerHungerUpdated

-- Detect when prompt is triggered
local function onPromptTriggered(promptObject: ProximityPrompt, player)
    -- Check if prompt triggered is an Eat action
    if promptObject.Name ~= ProximityAction then
        return
    end

    local foodModel = promptObject.Parent

    local foodValue = foodModel.Food.Value
    local currentHunger = PlayerModule.GetHunger(player)
    PlayerModule.SetHunger(player, currentHunger + foodValue)
    PlayerHungerUpdated:FireClient(player, PlayerModule.GetHunger(player))

    foodModel:Destroy()
end

-- Connect prompt events to handling functions
ProximityPromptService.PromptTriggered:Connect(onPromptTriggered)