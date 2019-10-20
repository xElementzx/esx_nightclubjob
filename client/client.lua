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
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAACXBIWXMAAC4jAAAuIwF4pT92AAAF+mlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMxNDUgNzkuMTYzNDk5LCAyMDE4LzA4LzEzLTE2OjQwOjIyICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdEV2dD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlRXZlbnQjIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ0MgMjAxOSAoV2luZG93cykiIHhtcDpDcmVhdGVEYXRlPSIyMDE5LTEwLTE3VDE4OjA4OjA0KzExOjAwIiB4bXA6TWV0YWRhdGFEYXRlPSIyMDE5LTEwLTE3VDE4OjA4OjA0KzExOjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAxOS0xMC0xN1QxODowODowNCsxMTowMCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo3YWMxOTFiNS02ZGViLWYzNGYtOGQwNi1mM2VkNGFiMTZlNDkiIHhtcE1NOkRvY3VtZW50SUQ9ImFkb2JlOmRvY2lkOnBob3Rvc2hvcDo2MjYzMDM5Yy03OWY4LTUxNDctOTMyZC0zY2Y0NThiYmU1ZjYiIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDplYWI0MDM2MS1lMTYyLTRhNGMtOWM2ZC04YzJkZWNhZTAxODYiIGRjOmZvcm1hdD0iaW1hZ2UvcG5nIiBwaG90b3Nob3A6Q29sb3JNb2RlPSIzIiBwaG90b3Nob3A6SUNDUHJvZmlsZT0ic1JHQiBJRUM2MTk2Ni0yLjEiPiA8eG1wTU06SGlzdG9yeT4gPHJkZjpTZXE+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJjcmVhdGVkIiBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOmVhYjQwMzYxLWUxNjItNGE0Yy05YzZkLThjMmRlY2FlMDE4NiIgc3RFdnQ6d2hlbj0iMjAxOS0xMC0xN1QxODowODowNCsxMTowMCIgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTkgKFdpbmRvd3MpIi8+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJzYXZlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDo3YWMxOTFiNS02ZGViLWYzNGYtOGQwNi1mM2VkNGFiMTZlNDkiIHN0RXZ0OndoZW49IjIwMTktMTAtMTdUMTg6MDg6MDQrMTE6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE5IChXaW5kb3dzKSIgc3RFdnQ6Y2hhbmdlZD0iLyIvPiA8L3JkZjpTZXE+IDwveG1wTU06SGlzdG9yeT4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz7Wf+8uAAASXklEQVR4nL2bWXRd1XnH/9/e+0zSla6uZmuwPGJjGw8y2MGF4CQGwpSB1TQJq0CG1TaBDE1W2zyENFkhfWhWHkiylpOWrqx0SBMSSBhKGwJkAOSY2GYweAB5kGzNur6S7nTuOXvqw5WNjSXZ2FfWyz3rr3P2+e/v7PPb39kDbdu2FQA4AIPyHwOgp39tpTVlua1hheRfL3v5Kx115mOFIjB4wvz0kfSGf87oRBb20nkBYPmSJYv4tGAAuNMn8NOCUjHNWKY9RNWf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'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer
  TriggerServerEvent('esx_nightclubjob:offduty')
end)
  
-- Draw Marker/Enter Exit Events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == "nightclub" or ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == "offnightclub") then
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
				elseif(k == 'nightclub_weapons' and ESX.PlayerData.job.grade_name == 'manager' and ESX.PlayerData.job.name == 'nightclub' or k == 'nightclub_weapons' and ESX.PlayerData.job.grade_name == 'boss' and ESX.PlayerData.job.name == 'nightclub') then
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

-- Draw Blip
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500) -- Put a wait here because otherwise ESX was equal to Nil randomly?
		if(ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == "nightclub" or ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == "offnightclub") then
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
		Citizen.Wait(500)
	end
end)

-- Key Actions
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)
			if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'nightclub' or IsControlJustReleased(0, 38) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == "offnightclub" then
				if CurrentAction == 'nightclub_actions_menu' then
					OpenJobMenu()
					CurrentAction = nil
				elseif CurrentAction == 'nightclub_weapon_menu' then
					OpenWeaponMenu(CurrentActionZone)
					CurrentAction = nil
				end
			end
		end
		if IsControlJustReleased(0, 167) and not isDead and ESX.PlayerData.job and ESX.PlayerData.job.name == 'nightclub' then
			OpenActionsMenu()
		end
	end
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

--Open Job menu for on/offduty/boss actions
function OpenJobMenu()
	local elements = {
		{label = _U('onduty'),      value = 'cloakroom'},
		{label = _U('offduty'),       value = 'cloakroom2'}
	}

	if ESX.PlayerData.job.grade_name == 'boss' and ESX.PlayerData.job.name == 'nightclub' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'nightclub_actions', {
		title    = _U('name'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
			if data.current.value == 'cloakroom' then
			menu.close()
			TriggerServerEvent('esx_nightclubjob:onduty')
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end
			end)
		elseif data.current.value == 'cloakroom2' then
			menu.close()
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
		menu.close()

		CurrentAction     = 'nightclub_actions_menu'
		CurrentActionMsg  = _U('open_menu')
		CurrentActionData = {}
	end)
end

--open F6 menu
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

--open Weapon Menu
function OpenWeaponMenu(zone)
	if (ESX.PlayerData.job.name == "nightclub" and ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.name == "nightclub" and ESX.PlayerData.job.grade_name == "manager") then
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
					CurrentAction     = 'nightclub_weapon_menu'
					CurrentActionMsg  = _U('open_menu')
					CurrentActionData = { zone = zone }
				else
					PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
					CurrentAction     = 'nightclub_weapon_menu'
					CurrentActionMsg  = _U('open_menu')
					CurrentActionData = { zone = zone }
				end
			end, data.current.weaponName, zone)
			menu.close()
		end, function(data, menu)
			PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)
			menu.close()
			CurrentAction     = 'nightclub_weapon_menu'
			CurrentActionMsg  = _U('open_menu')
			CurrentActionData = { zone = zone }
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