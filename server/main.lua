ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('oph3z-orange:GiveOrange')
AddEventHandler('oph3z-orange:GiveOrange', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.addInventoryItem('orange', 8)
    TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = _U('you_picked_oranges')}, 5000)
end)

RegisterServerEvent('oph3z-orange:ProcessOrange')
AddEventHandler('oph3z-orange:ProcessOrange', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local x = xPlayer.getQuantity('orange', 4)

    if 4 <= x then
        xPlayer.removeInventoryItem('orange', 4)
        xPlayer.addInventoryItem('orange_juice', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = _U('oranges_processed')}, 5000)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = _U('not_enough_items')}, 5000)
    end
end)

RegisterServerEvent('oph3z-orange:SellOrange')
AddEventHandler('oph3z-orange:SellOrange', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local x = xPlayer.getQuantity('orange_juice')

    if x > 0 then
        xPlayer.removeInventoryItem('orange_juice', x)
        xPlayer.addInventoryItem('cash', x * Config.OneOrangePrice)
        if Config.Locale == 'tr' then
            TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Üzerindeki bütün portakal sularını sattın ve ' ..x * Config.OneOrangePrice.. '$ elde ettin', 8000})
            dclog(xPlayer, x.. ' tane portakal suyu sattı ve ' ..x * Config.OneOrangePrice.. '$ elde etti')
        elseif Config.Locale == 'en' then
            TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'You sold all the orange juice on your inventory and you got ' ..x * Config.OneOrangePrice.. '$', 8000})
            dclog(xPlayer, 'Sold' ..x.. 'x orange juice and got ' ..x * Config.OneOrangePrice.. '$')
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = _U('not_enough_items')}, 5000)
    end
end)

function dclog(xPlayer, text)
    local playerName = Sanitize(xPlayer.getName())
    
    for k, v in ipairs(GetPlayerIdentifiers(xPlayer.source)) do
        if string.match(v, 'discord:') then
            identifierDiscord = v
        end
        if string.match(v, 'ip:') then
            identifierIp = v
        end
    end
    
    local discord_webhook = GetConvar('discord_webhook', Config.DiscordWebhook)
    if discord_webhook == '' then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ['username'] = 'oph3z-orange | Orange Script',
      ['avatar_url'] = Config.AwatarURL,
      ['embeds'] = {{
        ['author'] = {
          ['name'] = 'oph3z-orange',
          ['icon_url'] = Config.IconURL
        },
        ['footer'] = {
            ['text'] = 'oph3z-orange Discord Log System'
        },
        ['color'] = 1942002,
        ['timestamp'] = os.date('!%Y-%m-%dT%H:%M:%SZ')
      }}
    }
    text = '**Description:** ' ..text..'\n**ID**: '..tonumber(xPlayer.source)..'\n**Steam ID(HEX):** '..xPlayer.identifier..'\n **In Game Name:** '..xPlayer.getName()
    if identifierDiscord ~= nil then
        text = text..'\n**Discord:** <@'..string.sub(identifierDiscord, 9)..'>'
        identifierDiscord = nil
    end
    --[[if identifierIp ~= nil then
        text = text..'\n**Ip:** '..string.sub(identifierIp, 4)
        identifierIp = nil
    end--]]
    data['embeds'][1]['description'] = text
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end

function Sanitize(str)
    local replacements = {
        ['&' ] = '&amp;',
        ['<' ] = '&lt;',
        ['>' ] = '&gt;',
        ['\n'] = '<br/>'
    }

    return str
    :gsub('[&<>\n]', replacements)
    :gsub(' +', function(s)
        return ' '..('&nbsp;'):rep(#s-1)
    end)
end