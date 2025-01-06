ESX = exports["es_extended"]:getSharedObject()

-- Event to store a vehicle
RegisterServerEvent('esx_garage:storeVehicle')
AddEventHandler('esx_garage:storeVehicle', function(vehicleProps)
    local xPlayer = ESX.GetPlayerFromId(source)
    local vehiclePlate = vehicleProps.plate

    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = vehiclePlate,
        ['@vehicle'] = json.encode(vehicleProps)
    }, function(rowsChanged)
        if rowsChanged > 0 then
            TriggerClientEvent('esx:showNotification', source, 'Vehicle stored successfully!')
        else
            TriggerClientEvent('esx:showNotification', source, 'Failed to store vehicle.')
        end
    end)
end)

-- Event to recover a vehicle
RegisterServerEvent('esx_garage:recoverVehicle')
AddEventHandler('esx_garage:recoverVehicle', function(plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local recoveryCost = 500 -- Example recovery cost

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = plate
    }, function(result)
        if result[1] then
            if xPlayer.getMoney() >= recoveryCost then
                xPlayer.removeMoney(recoveryCost)
                TriggerClientEvent('esx_garage:spawnVehicle', source, json.decode(result[1].vehicle))
                TriggerClientEvent('esx:showNotification', source, 'Vehicle recovered for $' .. recoveryCost)
            else
                TriggerClientEvent('esx:showNotification', source, 'Not enough money to recover vehicle.')
            end
        else
            TriggerClientEvent('esx:showNotification', source, 'Vehicle not found.')
        end
    end)
end)

-- Ensure data persistence by checking vehicle ownership
ESX.RegisterServerCallback('esx_garage:getOwnedVehicles', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {
        ['@owner'] = xPlayer.identifier
    }, function(result)
        local vehicles = {}

        for i = 1, #result, 1 do
            table.insert(vehicles, {
                plate = result[i].plate,
                vehicle = json.decode(result[i].vehicle)
            })
        end

        cb(vehicles)
    end)
end)
