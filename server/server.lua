Config = {}

function SendWebHook(link, title, color, message)
    local embedMsg = {}
    timestamp = os.date("%c")
    embedMsg = {
        {
            ["color"] = color,
            ["title"] = title,
            ["description"] =  ""..message.."",
            ["footer"] ={
                ["text"] = timestamp.." (Server Time).",
            },
        }
    }
    PerformHttpRequest(link,
    function(err, text, headers)end, 'POST', json.encode({username = Config.name, avatar_url= Config.logo ,embeds = embedMsg}), { ['Content-Type']= 'application/json' })
end


AddEventHandler('z64_logs:sendWebhook', function(data)
    if data.link == nil then
        link = Config.hLink
    else
        link = data.link
    end
    title = data.title
    color = data.color
    message = data.message
    SendWebHook(link, title, color, message)
end)

Citizen.CreateThread(function()
    if Config.joinLeaveLog then
        if Config.joinLeaveLogLink == '' then
            print('^7[^1INFO^7]: Please set a WebHook URL in the config.lua to log players joining and leaving.')
        else
            print('test 1')
        AddEventHandler('playerJoining', function()
            local id = source
            local ids = GetPlayerIdentifier(id, steam)
            local plyName = GetPlayerName(id)
            local whData = {
                link = Config.joinLeaveLogLink,
                title = plyName.." JOINING",
                color = 655104,
                message = 
                '**[User]: **'..plyName..'\n'..
                '**[Identifier]: **'..ids..'\n'..
                '**[Asigned ID]: **'..id..'\n'
            }
            TriggerEvent('z64_logs:sendWebhook', whData)
        end)

        AddEventHandler('playerDropped', function(reason)
            local id = source
            local ids = GetPlayerIdentifier(id, steam)
            local plyName = GetPlayerName(id)
            local reason = reason
            local whData = {
                link = Config.joinLeaveLogLink,
                title = plyName.." LEFT",
                color = 16711689,
                message = 
                '**[User]: **'..plyName..'\n'..
                '**[Identifier]: **'..ids..'\n'..
                '**[Reason]: **'..reason..'\n'
            }
            TriggerEvent('z64_logs:sendWebhook', whData)
        end)
        end
    end
end)

AddEventHandler('onResourceStart', function(resource)
    resName = GetCurrentResourceName()
    if resource == resName then
        if Config.hlink == '' then
            print('^7[^1INFO^7]: No default WebHook URL detected. Please configure the script correctly.')
        else 
            print('^7[^2INFO^7]: '..resName..' initiated succesfully.')
            local whData = {
                link = Config.hlink,
                title = "LOGGER STARTED",
                color = 4521728,
                message = 
                '**'..resName..'** HAS STARTED SUCCESFULLY.'
            }
            TriggerEvent('z64_logs:sendWebhook', whData)
        end
    end
end)
