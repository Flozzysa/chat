ESX = exports["es_extended"]:getSharedObject()

local loocwebhook = Webhooks['looc']
local mewebhook = Webhooks['me']
local dowebhook = Webhooks['do']
local trywebhook = Webhooks['try']
local staffwebhook = Webhooks['staff']
local blackmarketwebhook = Webhooks['blackmarket']


function GetRealPlayerName(playerId)
  local xPlayer = ESX.GetPlayerFromId(playerId)

  if xPlayer then
      if wx.OnlyInicials then
          local name = xPlayer.get('firstName')
          name = string.sub(name, 1, 1)
          local surname = xPlayer.get('lastName')
          surname = string.sub(surname, 1, 1)
          local shortName = name..". "..surname..". "
          return shortName
      else
          return xPlayer.getName()
      end
  else
      return GetPlayerName(playerId)
  end
end

function ExtractIdentifiers(src)
  local identifiers = {
      steam = "Not Found",
      ip = "Not Found",
      discord = "Not Found",
      license = "Not Found",
      xbl = "Not Found",
      live = "Not Found"
  }

  --Loop over all identifiers
  for i = 0, GetNumPlayerIdentifiers(src) - 1 do
      local id = GetPlayerIdentifier(src, i)

      --Convert it to a nice table.
      if string.find(id, "steam") then
          identifiers.steam = id
      elseif string.find(id, "ip") then
          identifiers.ip = id
      elseif string.find(id, "discord") then
          identifiers.discord = id
      elseif string.find(id, "license") then
          identifiers.license = id
      elseif string.find(id, "xbl") then
          identifiers.xbl = id
      elseif string.find(id, "live") then
          identifiers.live = id
      elseif string.find(id, "fivem") then
          identifiers.fivem = id
      end
  end

  return identifiers
end



AddEventHandler('chatMessage', function(source, name, message)
  if string.sub(message, 1, string.len('/')) ~= '/' then CancelEvent()
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
    log("L-OOC", source, name, message,steam,discord,ip,loocwebhook)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = GetPlayerName(source)
    local admin = false
    if wx.LOOCAdminPrefixes then
      if wx.AdminGroups[xPlayer.getGroup()] then admin = true end
    end
    TriggerClientEvent('wx_rpchat:sendLocalOOC', -1, source, name, message, admin);
  end

end)


RegisterCommand(wx.Commands['Staff Announcement'], function(source,args,raw)
  local xPlayer = ESX.GetPlayerFromId(source)
  local toSay = ''
    for i=1,#args do
     toSay = toSay .. args[i] .. ' ' 
   end

   if wx.AdminGroups[xPlayer.getGroup()] == true then
    TriggerClientEvent('chat:addMessage', -1, {
      template = [[
        <div style="padding: 0.3vw; height: 1.5vw; margin: 0.5vw; background-color: #222228ec; border-radius: 10px; padding-top: 0.35vw; border: 0.11vw solid #414146; box-shadow: 0px 0px 11px rgba(158, 158, 158, 0.35)">
        <font style="padding: 0.15vw; margin: 0.22vw; background-color: #626066; padding-left: 1%; border-radius: 8px; border: #9e9e9e solid 0.11vw; font-size: 12px; box-shadow: 0px 0px 11px rgba(158, 158, 158, 0.55)">
            <font style="font-weight: 600;">ANNOUNCEMENT</font>
        </font>
        <font style="font-size: 14px; padding-left: 5px; color: #c7c5c5; margin: auto; font-weight:400"></font>
        <font class="message" style="font-size: 14px; color: #a8a7a7; margin: auto; font-weight:400"> {0}</font>
    </div>
      ]],
      args = { toSay }
  })
  end
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
  log("**/staff** Announcement", source, GetPlayerName(source), toSay,steam,discord,ip,staffwebhook)
end,false)


RegisterCommand('id', function(source,args,raw)
    TriggerClientEvent('chat:addMessage', source, {
      template = [[
        <div style="padding: 0.3vw; height: 1.5vw; margin: 0.5vw;  background-color: #222228ec; border-radius: 10px; padding-top: 0.35vw; border: 0.11vw solid #414146; box-shadow: 0px 0px 11px rgba(158, 158, 158, 0.35)">
        <font style="padding: 0.15vw; margin: 0.22vw; background-color: #581845; padding-left: 1%; border-radius: 8px; border: #781C5D solid 0.11vw; font-size: 12px; box-shadow: 0px 0px 11px rgba(120, 20, 90, 0.55)">
            <font style="font-weight: 600;">SERVER</font>
        </font>
        <font style="font-size: 14px; padding-left: 5px; color: #c7c5c5; margin: auto; font-weight:400">Your current server ID:</font>
        <font class="message" style="font-size: 14px; color: #a8a7a7; margin: auto; font-weight:400"> {0}</font>
    </div>
      ]],
    args = { source }
  })
end,false)


RegisterCommand(wx.Commands['Job'], function(source,args,raw)
    local fal = GetRealPlayerName(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('chat:addMessage', source, {
      template = [[
        <div style="padding: 0.3vw; height: 1.5vw; margin: 0.5vw;  background-color: #222228ec; border-radius: 10px; padding-top: 0.35vw; border: 0.11vw solid #414146; box-shadow: 0px 0px 11px rgba(158, 158, 158, 0.35)">
        <font style="padding: 0.15vw; margin: 0.22vw; background-color: #B05DCB; padding-left: 1%; border-radius: 8px; border: #CD4DF7 solid 0.11vw; font-size: 12px; box-shadow: 0px 0px 11px rgba(200, 90, 225, 0.55)">
            <font style="font-weight: 600;">SERVER</font>
        </font>
        <font style="font-size: 14px; padding-left: 5px; color: #c7c5c5; margin: auto; font-weight:400"></font>
        <font class="message" style="font-size: 14px; color: #a8a7a7; margin: auto; font-weight:400"> {0}</font>
    </div>
      ]],      args = { fal..", you're employed as "..xPlayer.job.label.." - "..xPlayer.job.grade_label }
  })
end,false)

if wx.AutoMessages then
  Citizen.CreateThread(function()
    while true do
    TriggerClientEvent('chat:addMessage', -1, {
      template = [[
        <div style="padding: 0.3vw; height: 1.5vw; margin: 0.5vw;  background-color: #222228ec; border-radius: 10px; padding-top: 0.35vw; border: 0.11vw solid #414146; box-shadow: 0px 0px 11px rgba(158, 158, 158, 0.35)">
        <font style="padding: 0.15vw; margin: 0.22vw; background-color: #B05DCB; padding-left: 1%; border-radius: 8px; border: #CD4DF7 solid 0.11vw; font-size: 12px; box-shadow: 0px 0px 11px rgba(200, 90, 225, 0.55)">
            <font style="font-weight: 600;">SYSTEM</font>
        </font>
        <font style="font-size: 14px; padding-left: 5px; color: #c7c5c5; margin: auto; font-weight:400"></font>
        <font class="message" style="font-size: 14px; color: #a8a7a7; margin: auto; font-weight:400"> {0}</font>
    </div>
      ]],      args = { wx.AutoMessagesList[math.random(#wx.AutoMessagesList)] }
    })
    Citizen.Wait(wx.AutoMessageInterval*60*1000)
  end
  end)
end


RegisterCommand('me', function(source, args, raw)
  local args = table.concat(args, ' ')
  local name = GetRealPlayerName(source)
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
  log("**/me**", source, GetPlayerName(source), args,steam,discord,ip,mewebhook)

  TriggerClientEvent('wx_rpchat:sendMe', -1, source, name, args, { 196, 33, 246 })
  TriggerClientEvent('3dme:triggerDisplay', -1, args, source)
end,false)

RegisterCommand('do', function(source, args, raw)
  local args = table.concat(args, ' ')
  local name = GetRealPlayerName(source)
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
  log("**/do**", source, GetPlayerName(source), args,steam,discord,ip,dowebhook)

  TriggerClientEvent('wx_rpchat:sendDo', -1, source, name, args, { 255, 198, 0 })
  TriggerClientEvent('3ddo:triggerDisplay', -1, "* "..args.." *", source)
end,false)

RegisterCommand('try', function(source, args, raw)
  local result = "NO"
  local name = GetRealPlayerName(source)
  local random = math.random(1,2)
  if random == 1 then
    result = "YES"
    TriggerClientEvent('wx_rpchat:sendTry', -1, source, name, result, { 255, 198, 0 })
    TriggerClientEvent('3dme:triggerDisplay', -1, "* "..result.." *", source)
  else
    TriggerClientEvent('wx_rpchat:sendTry', -1, source, name, result, { 255, 198, 0 })
    TriggerClientEvent('3dme:triggerDisplay', -1, "* "..result.." *", source)
  end
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
  log("**/try**", source, GetPlayerName(source), result,steam,discord,ip,trywebhook)
end,false)

RegisterCommand('doc', function(source, args, raw)
  local name = GetRealPlayerName(source)
  if args[1] ~= nil then 
    local c = 0
    local count = tonumber(args[1])
    if count < wx.MaxDocCount then
      while c < count do
          c = c + 1 
          TriggerClientEvent('wx_rpchat:sendDoc', -1, source, name, c .. "/" .. count , { 255, 198, 0 })
          TriggerClientEvent('3ddoa:triggerDisplay', -1, c .. "/" .. count, source)
          Wait(1518)
      end
    end
  end
end,false)