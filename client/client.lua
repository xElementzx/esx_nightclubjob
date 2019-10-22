ESX                             = nil
local PlayerData 				= nil
local HasAlreadyEnteredMarker, LastZone = false, nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    ESX.TriggerServerCallback('esx_nightclubjob:getShop', function(nightclubItems)
        for k,v in pairs(nightclubItems) do
            Config.Zones[k].Items = v
        end
    end)
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx_nightclubjob:sendShop')
AddEventHandler('esx_nightclubjob:sendShop', function(nightclubItems)
    for k,v in pairs(nightclubItems) do
        Config.Zones[k].Items = v
    end
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
    local specialContact = {
        name       = _U('nightclub'),
        number     = 'nightclub',
        base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAACXBIWXMAAAsTAAALEwEAmpwYAAAFHGlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMxNDUgNzkuMTYzNDk5LCAyMDE4LzA4LzEzLTE2OjQwOjIyICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOSAoV2luZG93cykiIHhtcDpDcmVhdGVEYXRlPSIyMDE5LTEwLTIwVDE1OjIwOjIzKzExOjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAxOS0xMC0yMFQxNToyMToxMSsxMTowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAxOS0xMC0yMFQxNToyMToxMSsxMTowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo4MzZkZjNhNC02N2Y3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'
    }

    TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer
  TriggerServerEvent('esx_nightclubjob:offduty')
end)

AddEventHandler('esx_nightclubjob:hasEnteredMarker', function(zone)
    if zone == 'nightclub' then
        CurrentAction     = 'nightclub_actions_menu'
        CurrentActionMsg  = _U('open_menu')
        CurrentActionData = {}
        CurrentActionZone = zone
    elseif zone == 'nightclub_weapons' then
        CurrentAction     = 'nightclub_weapon_menu'
        CurrentActionMsg  = _U('open_menu')
        CurrentActionData = {}
        CurrentActionZone = zone
    end
end)

AddEventHandler('esx_nightclubjob:hasExitedMarker', function(zone)
    CurrentAction = nil
    ESX.UI.Menu.CloseAll()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)
  
-- Draw Marker/Enter Exit Events
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if(ESX.PlayerData.job ~= nil and IsNightclubStaff()) then
            local isInMarker = false
            local currentZone = nil
            local coords = GetEntityCoords(PlayerPedId())
            for k,v in pairs(Config.Zones) do
                if(k ~= 'nightclub_weapons') then
                    DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z,0,0,0,0,0,0,1.0,1.0,1.0,v.Color.r,v.Color.g,v.Color.b,200,0,true,0,0)
                    if(GetDistanceBetweenCoords(v.Pos.x, v.Pos.y, v.Pos.z,  coords, true) < v.Size.x-2) then 
                        isInMarker = true
                        currentZone = k
                    end
                elseif(k == 'nightclub_weapons' and IsBoss()) then
                    DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z,0,0,0,0,0,0,1.0,1.0,1.0,v.Color.r,v.Color.g,v.Color.b,200,0,true,0,0)
                    if(GetDistanceBetweenCoords(v.Pos.x, v.Pos.y, v.Pos.z,  coords, true) < v.Size.x-2) then 
                        isInMarker = true
                        currentZone = k
                    end
                end
            end
            if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
                HasAlreadyEnteredMarker = true
                LastZone                = currentZone
                TriggerEvent('esx_nightclubjob:hasEnteredMarker', currentZone)
            end
            if (not isInMarker and HasAlreadyEnteredMarker) then
                HasAlreadyEnteredMarker = false
                TriggerEvent('esx_nightclubjob:hasExitedMarker', LastZone)
            end
        end
    end
end)

-- Key Actions Thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if CurrentAction then
            ESX.ShowHelpNotification(CurrentActionMsg)
            if (IsControlJustReleased(0, 38) and IsNightclubStaff()) then
                if CurrentAction == 'nightclub_actions_menu' then
                    OpenJobMenu()
                    CurrentAction = nil
                elseif CurrentAction == 'nightclub_weapon_menu' then
                    OpenWeaponMenu(CurrentActionZone)
                    CurrentAction = nil
                end
            end
        end
        if IsControlJustReleased(0, 167) and not isDead and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'nightclub' then
            OpenActionsMenu()
        end
    end
end)

-- Draw Blip
Citizen.CreateThread(function()
    Citizen.Wait(500)
    if(ESX.PlayerData.job ~= nil and IsNightclubStaff()) then
        for k,v in pairs(Config.Zones) do
            if(k ~= 'nightclub_weapons') then
                local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
                SetBlipSprite (blip, 279)
                SetBlipDisplay(blip, 4)
                SetBlipScale  (blip, 1.1)
                SetBlipColour (blip, 79)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentSubstringPlayerName(v.Name)
                EndTextCommandSetBlipName(blip)
            end
        end
    end
end)

--Open Job menu for on/offduty/boss actions
function OpenJobMenu()
    local elements = {
        {label = _U('onduty'),      value = 'cloakroom'},
        {label = _U('offduty'),       value = 'cloakroom2'}
    }

    if(ESX.PlayerData.job.grade_name == 'boss' and ESX.PlayerData.job.name == 'nightclub') then
        table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'nightclub_actions', {
        title    = _U('name'),
        align    = 'bottom-right',
        elements = elements
    }, function(data, menu)
            if data.current.value == 'cloakroom' then
                CloseActionsMenu(menu)
                TriggerServerEvent('esx_nightclubjob:onduty')
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                if skin.sex == 0 then
                    TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
                else
                    TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
                end
            end)
            elseif data.current.value == 'cloakroom2' then
                CloseActionsMenu(menu)
                TriggerServerEvent('esx_nightclubjob:offduty')
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)
            elseif data.current.value == 'boss_actions' then
                TriggerEvent('esx_society:openBossMenu', 'nightclub', function(data, menu)
                menu.close()
            end)
        end
    end, function(data, menu)
        CloseActionsMenu(menu)
    end)
end

--Open F6 menu
function OpenActionsMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'nightclub_job_actions', {
        title	= _U('name'),
        align	= 'bottom-right',
        elements = {
            {label = _U('billing'),    value= 'billing'}
        }
    }, function(data, menu)
        if isBusy then return end
        if data.current.value == 'billing' then
            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
                title = _U('invoice_amount')
            }, function(data, menu)
                local amount = tonumber(data.value)

                if amount == nil or amount < 0 then
                    ESX.ShowNotification(_U('amount_invalid'))
                else
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification(_U('no_players_nearby'))
                    else
                        menu.close()
                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_nightclub', _U('nightclub'), amount)
                    end
                end
            end, function(data, menu)
                menu.close()
            end)
        end
    end, function(data, menu)
        menu.close()
    end)
end

--Open Weapon Menu
function OpenWeaponMenu(zone)
    if (IsBoss()) then
        local elements = {}
        for i=1, #Config.Zones[zone].Items, 1 do
            local item = Config.Zones[zone].Items[i]

            table.insert(elements, {
                label = ('%s - <span style="color: green;">%s</span>'):format(item.label, _U('shop_menu_item', ESX.Math.GroupDigits(item.price))),
                price = item.price,
                weaponName = item.item
            })
        end
        ESX.UI.Menu.CloseAll()
        PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop', {
            title = _U('shop_title'),
            align = 'bottom-right',
            elements = elements
        }, function(data, menu)
            ESX.TriggerServerCallback('esx_nightclubjob:buyWeapon', function(bought)
                if bought then
                    DisplayBoughtScaleform(data.current.weaponName, data.current.price)
                else
                    PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
                end
            end, data.current.weaponName, zone)
            CloseWeaponMenu(menu)
        end, function(data, menu)
            PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)
            CloseWeaponMenu(menu)
        end, function(data, menu)
            PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET', false)
        end)
    else
        if (ESX.PlayerData.job.name ~= "nightclub") then
            TriggerEvent('esx:showNotification', _U('not_on_duty'))
        else
            TriggerEvent('esx:showNotification', _U('not_high_enough'))
        end
    end
end

--Scaleform for buying gun
function DisplayBoughtScaleform(weaponName, price)
    local scaleform = ESX.Scaleform.Utils.RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')
    local sec = 4

    BeginScaleformMovieMethod(scaleform, 'SHOW_WEAPON_PURCHASED')

    PushScaleformMovieMethodParameterString(_U('weapon_bought', ESX.Math.GroupDigits(price)))
    PushScaleformMovieMethodParameterString(ESX.GetWeaponLabel(weaponName))
    PushScaleformMovieMethodParameterInt(GetHashKey(weaponName))
    PushScaleformMovieMethodParameterString('')
    PushScaleformMovieMethodParameterInt(100)

    EndScaleformMovieMethod()

    PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)

    Citizen.CreateThread(function()
        while sec > 0 do
            Citizen.Wait(0)
            sec = sec - 0.01
    
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
        end
    end)
end

--Close actions menu func
function CloseActionsMenu(menu)
    menu.close()
    CurrentAction     = 'nightclub_actions_menu'
    CurrentActionMsg  = _U('open_menu')
    CurrentActionData = {}
end

--Close weapon menu func
function CloseWeaponMenu(menu)
    menu.close()
    CurrentAction     = 'nightclub_weapon_menu'
    CurrentActionMsg  = _U('open_menu')
    CurrentActionData = { zone = zone }
end

--Check if boss
function IsBoss()
    return ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'manager'
end

--Check if nightclub staff
function IsNightclubStaff()
    return ESX.PlayerData.job.name == 'nightclub' or ESX.PlayerData.job.name == 'offnightclub'
end