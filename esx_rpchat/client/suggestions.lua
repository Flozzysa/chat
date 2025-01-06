Citizen.CreateThread(function()
    for command, options in pairs(wx.Suggestions) do
        if command ~= wx.Commands["Twitter"] and command ~= wx.Commands["Advertisement"] and command ~= wx.Commands["EMS"] and command ~= wx.Commands["Police"] and command ~= wx.Commands["Sheriff"] and command ~= wx.Commands["Here"] then
            for k,v in pairs(options.argument) do
                TriggerEvent('chat:addSuggestion', command, options.description,  { { name = k, help = v } } )
            end
        end
    end
end)

-- @todo: rewrite. works, but could be done better