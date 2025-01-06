ESX = exports["es_extended"]:getSharedObject()

local garageLocations = {
    {x = 220.1418, y = -800.1686, z = 30.7227, type = 'car', interior = 'large'},
    {x = 273.0, y = -343.85, z = 44.91, type = 'car', interior = 'large'},
    {x = -71.46, y = -1821.83, z = 26.94, type = 'car', interior = 'large'},
    {x = 1032.84, y = -765.1, z = 58.18, type = 'car', interior = 'large'},
    {x = -1248.69, y = -1425.71, z = 4.32, type = 'car', interior = 'large'},
    {x = -2961.58, y = 375.93, z = 15.02, type = 'car', interior = 'small'},
    {x = 217.33, y = 2605.65, z = 46.04, type = 'car', interior = 'small'},
    {x = 1878.44, y = 3760.1, z = 32.94, type = 'car', interior = 'small'},
    {x = 365.21, y = 295.6, z = 103.46, type = 'car', interior = 'large'},
    {x = 1713.06, y = 4745.32, z = 41.96, type = 'car', interior = 'small'},
    {x = 107.32, y = 6611.77, z = 31.98, type = 'car', interior = 'small'},
    {x = 328.6457, y = -210.4855, z = 54.0863, type = 'car', interior = 'large'},
    {x = -176.8074, y = -1305.2096, z = 31.2980, type = 'car', interior = 'large'},
    {x = 408.0792, y = -998.0554, z = 29.2663, type = 'car', interior = 'large'},
    {x = 2422.3440, y = 4959.5835, z = 45.9706, type = 'car', interior = 'small'},
    {x = -608.2778, y = -875.6619, z = 25.2812, type = 'car', interior = 'large'},
    {x = -1480.0311, y = -496.4789, z = 32.8068, type = 'car', interior = 'large'},
    {x = -1667.8083, y = 72.3026, z = 63.5343, type = 'car', interior = 'large'},
    {x = -387.9319, y = -107.0117, z = 38.6853, type = 'car', interior = 'large'},
    {x = -1182.7245, y = -2852.9495, z = 14.0404, type = 'air'},
    {x = -850.1674, y = -1498.1183, z = 1.6342, type = 'boat'}
}

local function isPlayerNearGarage()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    for _, garage in ipairs(garageLocations) do
        local distance = GetDistanceBetweenCoords(playerCoords, garage.x, garage.y, garage.z, true)
        if distance < 10.0 then
            return true, garage
        end
    end
    return false, nil
end

local function openGarageMenu(garage)
    ESX.UI.Menu.CloseAll()

    local elements = {
        {label = "Retrieve Vehicle", value = "retrieve_vehicle"},
        {label = "Cancel", value = "cancel"}
    }

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage_menu', {
        title = "Garage",
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'retrieve_vehicle' then
            TriggerServerEvent('esx_garage:retrieveVehicle', garage)
            menu.close()
        elseif data.current.value == 'cancel' then
            menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local isNear, garage = isPlayerNearGarage()
        if isNear then
            ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to open the garage")
            if IsControlJustReleased(0, 38) then
                openGarageMenu(garage)
            end
        else
            Citizen.Wait(500)
        end
    end
end)

RegisterNetEvent('esx_garage:vehicleRetrieved')
AddEventHandler('esx_garage:vehicleRetrieved', function(vehicle)
    ESX.Game.SpawnVehicle(vehicle.model, {
        x = vehicle.spawn.x,
        y = vehicle.spawn.y,
        z = vehicle.spawn.z
    }, vehicle.spawn.heading, function(spawnedVehicle)
        TaskWarpPedIntoVehicle(PlayerPedId(), spawnedVehicle, -1)
    end)
end)

RegisterNetEvent('esx_garage:paymentFailed')
AddEventHandler('esx_garage:paymentFailed', function()
    ESX.ShowNotification("You do not have enough money to retrieve your vehicle.")
end)
