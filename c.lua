for k in pairs(Config.Triggers) do
    if Config.Triggers[k].type == "client" then
        AddEventHandler(Config.Triggers[k].trigger, function()
            TriggerServerEvent('geni_triggerLogger:discordLog', GetPlayerServerId(PlayerId()), Config.Triggers[k].title, Config.Triggers[k].message, Config.Triggers[k].webhook, Config.Triggers[k].trigger, Config.Triggers[k].type)
        end)
    end
end
