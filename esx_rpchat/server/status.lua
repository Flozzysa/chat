local playerStatus = {}

AddEventHandler('playerDropped', function (reason)
    if playerStatus[source] then
        TriggerClientEvent('wx_rpchat:RemovePlayerStatus', -1, source)
    end
end)

RegisterCommand(wx.Commands['Status'], function(source, args, rawCommand)
    local ESX = exports["es_extended"]:getSharedObject()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local discord = "Not Found"
    local ip = "Not Found"
    local steam = "Not Found"
    for k, v in pairs(GetPlayerIdentifiers(source)) do
      if string.sub(v, 1, string.len("steam:")) == "steam:" then
        steam = v
      elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
        discord = v
      elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
        ip = v
      end
    end
    if xPlayer then
        if playerStatus[_source] then
            playerStatus[_source] = nil
            TriggerClientEvent('wx_rpchat:RemovePlayerStatus', -1, _source)
            Notify('Success',"You have removed your status")
        else
            local message = table.concat(args, ' ', 1)
            playerStatus[_source] = message
            TriggerClientEvent('wx_rpchat:SetPlayerStatus', -1, _source, message)
            log("**/status**", source,GetPlayerName(source), message,steam,discord,ip,stavwebhook)
            Notify('Success',"You are now showing your status: "..message)
            local playerName = GetPlayerName(_source)
            local steam = GetPlayerIdentifiers(_source)[1]
        end
    end
end, false)