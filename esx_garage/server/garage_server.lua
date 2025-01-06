ESX = exports["es_extended"]:getSharedObject()

-- Table to store vehicle data
local storedVehicles = {}

-- Event to handle vehicle retrieval request
RegisterServerEvent('esx_garage:retrieveVehicle')
AddEventHandler('esx_garage:retrieveVehicle', function(garage)
    local xPlayer = ESX.GetPlayerFromId(source)
    local vehicleData = storedVehicles[xPlayer.identifier]

    if vehicleData then
        local retrievalCost = 500 -- Example cost for vehicle retrieval
        if xPlayer.getMoney() >= retrievalCost then
            xPlayer.removeMoney(retrievalCost)
            TriggerClientEvent('esx_garage:vehicleRetrieved', source, vehicleData)
            storedVehicles[xPlayer.identifier] = nil
        else
            TriggerClientEvent('esx_garage:paymentFailed', source)
        end
    else
        TriggerClientEvent('esx_garage:paymentFailed', source)
    end
end)

-- Function to store vehicle data
function StoreVehicleData(playerId, vehicle)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    storedVehicles[xPlayer.identifier] = vehicle
end

-- Example function to simulate storing a vehicle
RegisterCommand('storeVehicle', function(source, args, rawCommand)
    local vehicle = {
        model = 'adder', -- Example vehicle model
        spawn = {x = 220.1418, y = -800.1686, z = 30.7227, heading = 161.8591} -- Example spawn position
    }
    StoreVehicleData(source, vehicle)
    TriggerClientEvent('esx:showNotification', source, "Vehicle stored successfully!")
end, false)
