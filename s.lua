RegisterNetEvent('geni_triggerLogger:discordLog')
AddEventHandler('geni_triggerLogger:discordLog', function(playerId, title, message, webhook, triggerName, triggerType)
    local hex = GetIdentifier(playerId, "steam:", 7)
    local discordId = GetIdentifier(playerId, "discord:", 9)
    local connect = {
        {
            ['color'] = 000000,
            ['title'] = title,
            ['description'] = message,
            ['footer'] = {
                ['text'] = "geniuN#9999 Event Logger",
                ['icon_url'] = 'https://cdn.discordapp.com/attachments/832221717115043870/834073441534738477/logo.png',
            },
            ['fields'] = {
                {
                    ['name'] = '**Trigger Name**',
                    ['value'] = triggerName,
                },
                {
                    ['name'] = '**Trigger Type**',
                    ['value'] = triggerType,
                },
                {
                    ['name'] = '**Player Name**',
                    ['value'] = GetPlayerName(playerId),
                },
                {
                    ['name'] = '**Player Steam Hex**',
                    ['value'] = hex,
                },
                {
                    ['name'] = '**Player Discord**',
                    ['value'] = '<@' .. discordId .. '>',
                },
            },
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "geniuN Event Logger", embeds = connect, avatar_url = "https://cdn.discordapp.com/attachments/832221717115043870/834073441534738477/logo.png"}), { ['Content-Type'] = 'application/json' })
end)

function GetIdentifier(playerId, identifierType, sSub, cb)
    for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
        if string.match(v, identifierType) then
            return string.sub(v, sSub)
        end
    end
end

for k in pairs(Config.Triggers) do
    if Config.Triggers[k].type == "server" then
        RegisterServerEvent(Config.Triggers[k].trigger)
        AddEventHandler(Config.Triggers[k].trigger, function()
            TriggerEvent('geni_triggerLogger:discordLog', source, Config.Triggers[k].title, Config.Triggers[k].message, Config.Triggers[k].webhook, Config.Triggers[k].trigger, Config.Triggers[k].type)
        end)
    end
end
