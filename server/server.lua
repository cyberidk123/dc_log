local webhook = {
    logging = "https://discord.com/api/webhooks/1323524281484836884/AuWUZ7ZA7IJTKETcJ6LQ8qrFHxlWMuedoOGntvb5udQVGyyeMhMrB-D5zLQWQtwPSObN",
}

local image = {
    logging = "https://discord.com/api/webhooks/1323524281484836884/AuWUZ7ZA7IJTKETcJ6LQ8qrFHxlWMuedoOGntvb5udQVGyyeMhMrB-D5zLQWQtwPSObN",
}

AddEventHandler('connecting', function ()
    LogToDiscord("log", "Connection", "**" .. GetPlayerName(source) .. "**", 65280)
end)
AddEventHandler('playerDropped', function(reason) 
    LogToDiscord("log", "Disconnection", "**" .. GetPlayerName(source) .. "** *( " .. reason.." )*", 16711680) 
    end)


RegisterServerEvent('playerDeath')
AddEventHandler('playerDeath',function(msg)
    LogToDiscord("log", "Dead", msg, 16711680)
end)


function GetIdFromSource(Type, ID)
    local ID = GetPlayerIdentifier(ID)
    for i, CurrentID in pairs(ID)  do
        local SID = stringsplit(CurrentID, ":")
        if (ID[1]:lower() == string.lower(Type)) then
            return ID[2]:lower()
        end
    end
    return nil
end

function stringsplit(input, seperator)
	if seperator == nil then seperator = '%s' end 
	local t={} ; i=1
	for str in string.gmatch(input, '([^'..seperator..']+)') do 
        t[i] = str i = i + 1
        end
	return t
end

function LogToDiscord(hook, name, msg, color)
    local connect = { { ["color"] = color, ["title"] = "**"..name.."** - " ..msg}}

    print('^4[Webhook '..hook..'] : '..name.." - "..msg)
    PerformHttpRequest(webhook[hook], function(err, text, headers) end, 'POST', json.encode({username = "Holliday\'s", embeds = connect, avatar_url = image[hook]}), { ['Content-Type'] = 'application/json' })
end

LogToDiscord("log", "Reboot", "Server On", 65280)

exports("LogToDiscord", LogToDiscord)

RegisterServerEvent('LogToDiscordSRV')
AddEventHandler('LogToDiscordSRV', function(hook, name, message, color) 
    LogToDiscord(hook, name, message, color) 
end)