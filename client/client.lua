local player = PlayerPedId()
local id = PlayerId()

function hash(raw)
    GetHashKey(raw)
end

Citizen.CreateThread(function()
    local Death
    local Killer
    local DeathCause
    local Weapon

    while true do
        Wait(0)

        if IsEntityDead(player) then
            Wait(500)
            local PlayerKiller = GetPedSourceOfDeath(player)
            DeathCause = GetPedCauseOfDeath(player)

            Weapon = Names[tostring(DeathCause)]

            if IsEntityAPed(PlayerKiller) and IsPedAPlayer(PlayerKiller) then
                killer = NetWorkGetPlayerIndexFromPed(PlayerKiller)

            elseif IsEntityAVehicle(PlayerKiller) and IsEntityAPed(GetPedInVehicleSeat(PedKiller, -1)) and IsPedAPlayer(GetPedInVehicleSeat(PedKiller, -1)) then
                killer = NetWorkGetPlayerIndexFromPed(GetPedInVehicleSeat(PedKiller, -1))
            end

            if(killer == id) then
                Death = 'Committed Suicide'
            elseif (killer == nil) then
                Death = 'Died'

            else
                if IsMelee(DeathCause) then
					Death = 'killed'
				elseif IsTorch(DeathCause) then
					Death = 'killed'
				elseif IsKnife(DeathCause) then
					Death = 'killed'
				elseif IsPistol(DeathCause) then
					Death = 'killed'
				elseif IsSub(DeathCause) then
					Death = 'killed'
				elseif IsRifle(DeathCause) then
					Death = 'killed'
				elseif IsLight(DeathCause) then
					Death = 'killed'
				elseif IsShotgun(DeathCause) then
					Death = 'killed'
				elseif IsSniper(DeathCause) then
					Death = 'killed'
				elseif IsHeavy(DeathCause) then
					Death = 'killed'
				elseif IsMinigun(DeathCause) then
					Death = 'killed'
				elseif IsBomb(DeathCause) then
					Death = 'killed'
				elseif IsVeh(DeathCause) then
					Death = 'killed'
				elseif IsVK(DeathCause) then
					Death = 'killed'
				else
					Death = 'killed'
				end
            end

            if Death == 'Committed Suiceide' or Death == 'Died' then
                TriggerServerEvent('logs:playerDeath', GetPlayerName(id) .. ' ' .. Death .. '.', Weapon)
            else 
                TriggerServerEvent('logs:playerDeath', GetPlayerName(killer) .. Death ..''.. GetPlayerName(id)..' '.. Death .. '.', Weapon)
            end
            Killer = nil
            Death = nil
            DeathCause = nil
            Weapon = nil
        end
        
        while IsEntityDead(player) do
            Wait(0)
        end
    end
end)

function IsMelee(Weapon)
    local Weapons = {'WEAPON_UNARMED', 'WEAPON_BAT', 'WEAPON_CROWBAR', 'WEAPON_GOLFCLUB', 'WEAPON_HAMMER', 'WEAPON_NIGHTSTICK'}
    for i, CurWeapon in pair(Weapons) do 
        if hash(CurWeapon) == Weapon then
            return true
        end
    end
    return false
end

function IsTorch(Weapon)
    local Weapons = {'WEAPON_MOLOTOV'}
    for i, CurWeapon in pair(Weapons) do 
        if hash(CurWeapon) == Weapon then
            return true
        end
    end
    return false
end

exports("LogToDiscord", LogToDiscord)

function LogToDiscord(hook, name, message, color)

	TriggerServerEvent('LogToDiscordSRV', hook, name, msg, color)
end