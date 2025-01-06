ESX = exports["es_extended"]:getSharedObject()


local playerLoaded = false
Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do -- Wait for player to choose character
		Citizen.Wait(100)
	end
    playerLoaded = true
end)

local displayedMessages = {}

RegisterNetEvent('chat:SetMessage')
AddEventHandler('chat:SetMessage', function(message, coords)

    displayedMessages[coords] = message

end)

RegisterNetEvent('chat:removeMessage')
AddEventHandler('chat:removeMessage', function(coords)

    displayedMessages[coords] = nil

end)

local playerStatuses = {}

RegisterNetEvent('wx_rpchat:SetMessages')
AddEventHandler('wx_rpchat:SetMessages', function(heres, statuses)

    playerStatuses = statuses
    displayedMessages = heres

end)

RegisterNetEvent('wx_rpchat:SetPlayerStatus')
AddEventHandler('wx_rpchat:SetPlayerStatus', function(playerId, message)

    playerStatuses[playerId] = message

end)

RegisterNetEvent('wx_rpchat:RemovePlayerStatus')
AddEventHandler('wx_rpchat:RemovePlayerStatus', function(playerId)

    playerStatuses[playerId] = nil

end)

Citizen.CreateThread(function()
    local myServerId = GetPlayerServerId(PlayerId())
    while true do
        Wait(0)
        local letSleep = true
        local pedCoords = GetEntityCoords(PlayerPedId())
        if playerStatuses[myServerId] then
            DrawText3DsS(pedCoords.x, pedCoords.y, pedCoords.z, playerStatuses[myServerId])
            letSleep = false
        end
        for k, v in pairs(playerStatuses) do
            local player = GetPlayerFromServerId(k)
            if player ~= -1 and player ~= myServerId then
                local targetCoords = GetEntityCoords(GetPlayerPed(player))
                local dist = #(targetCoords - pedCoords)
                if dist < 8.0 then
                    DrawText3DsS(targetCoords.x, targetCoords.y, targetCoords.z, v)
                    letSleep = false
                end
            end
        end
        if letSleep then
            Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    TriggerServerEvent('wx_rpchat:RequestMessages')
    while true do
        Wait(0)
        local letSleep = true
        local pedCoords = GetEntityCoords(PlayerPedId())
        for k, v in pairs(displayedMessages) do
            local dist = #(v.coords - pedCoords)
            if dist < 5.5 then
                letSleep = false
                DrawText3DsH(v.coords.x, v.coords.y, v.coords.z, v.message)
            end
        end
        if letSleep then Wait(135) end
    end

end)

function DrawText3DsH(x,y,z, text)
    local _, x1, y1 = World3dToScreen2d(x, y, z)
    RegisterFontFile('BBN')
    local fontId = RegisterFontId('BBN')
    SetTextScale(0.55, 0.31)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(true)
    SetTextDropshadow(10, 100, 100, 100, 255)
    SetTextColour(255, 255, 255, 215)
    AddTextComponentString(text)
    
    DrawText(x1, y1)
    local factor = (string.len(text)) / 320
    if not wx.TransparentStatusHere then
        DrawRect(x1,y1+0.0135, 0.025+ factor, 0.03, 0, 0, 0, 68)
    end
end

function DrawText3DsS(x,y,z, text)
    local _, _x, _y = World3dToScreen2d(x, y, z)
    RegisterFontFile('BBN')
    local fontId = RegisterFontId('BBN')
    SetTextScale(0.55, 0.31)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(true)
    SetTextDropshadow(10, 100, 100, 100, 255)
    SetTextColour(255, 255, 255, 215)
    AddTextComponentString(text)
    
    DrawText(_x, _y)
    local factor = (string.len(text)) / 320
    if wx.TransparentStatusHere then
        DrawRect(_x,_y+0.0135, 0.025+ factor, 0.03, 0, 0, 0, 68)
    end
end