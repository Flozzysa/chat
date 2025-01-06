ESX = exports["es_extended"]:getSharedObject()

local garageLocations = {
    {x = 220.1418, y = -800.1686, z = 30.7227, type = 'car'},
    {x = 273.0, y = -343.85, z = 44.91, type = 'car'},
    {x = -71.46, y = -1821.83, z = 26.94, type = 'car'},
    {x = 1032.84, y = -765.1, z = 58.18, type = 'car'},
    {x = -1248.69, y = -1425.71, z = 4.32, type = 'car'},
    {x = -2961.58, y = 375.93, z = 15.02, type = 'car'},
    {x = 217.33, y = 2605.65, z = 46.04, type = 'car'},
    {x = 1878.44, y = 3760.1, z = 32.94, type = 'car'},
    {x = 365.21, y = 295.6, z = 103.46, type = 'car'},
    {x = 1713.06, y = 4745.32, z = 41.96, type = 'car'},
    {x = 107.32, y = 6611.77, z = 31.98, type = 'car'},
    {x = 328.6457, y = -210.4855, z = 54.0863, type = 'car'},
    {x = -176.8074, y = -1305.2096, z = 31.2980, type = 'car'},
    {x = 408.0792, y = -998.0554, z = 29.2663, type = 'car'},
    {x = 2422.3440, y = 4959.5835, z = 45.9706, type = 'car'},
    {x = -608.2778, y = -875.6619, z = 25.2812, type = 'car'},
    {x = -1480.0311, y = -496.4789, z = 32.8068, type = 'car'},
    {x = -1667.8083, y = 72.3026, z = 63.5343, type = 'car'},
    {x = -387.9319, y = -107.0117, z = 38.6853, type = 'car'},
    {x = -1182.7245, y = -2852.9495, z = 14.0404, type = 'air'},
    {x = -850.1674, y = -1498.1183, z = 1.6342, type = 'boat'}
}

local function openGarageMenu()
    -- Display garage menu to the player
    -- This function should be implemented to show a UI menu
end

local function storeVehicle()
    -- Logic to store the player's vehicle
    -- This function should interact with the server to store vehicle data
end

local function recoverVehicle()
    -- Logic to recover a vehicle with payment
    -- This function should handle payment and vehicle retrieval
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, location in ipairs(garageLocations) do
            local distance = #(playerCoords - vector3(location.x, location.y, location.z))
            if distance < 10.0 then
                DrawMarker(1, location.x, location.y, location.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, true, 2, false, false, false, false)
                if distance < 1.5 then
                    ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to open the garage")
                    if IsControlJustReleased(0, 38) then
                        openGarageMenu()
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('esx_garage:storeVehicle')
AddEventHandler('esx_garage:storeVehicle', function()
    storeVehicle()
end)

RegisterNetEvent('esx_garage:recoverVehicle')
AddEventHandler('esx_garage:recoverVehicle', function()
    recoverVehicle()
end)
