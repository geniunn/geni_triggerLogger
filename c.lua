for k in pairs(Config.Triggers) do
    AddEventHandler(Config.Triggers[k].trigger, function()
        if Config.Triggers[k].type == "client" then
            TriggerServerEvent('geni_triggerLogger:discordLog', GetPlayerServerId(PlayerId()), Config.Triggers[k].title, Config.Triggers[k].message, Config.Triggers[k].webhook, Config.Triggers[k].trigger, Config.Triggers[k].type)
        end
    end)
end