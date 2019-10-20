ESX = nil
local nightclubItems = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'nightclub', _U('alert_nightclub'), true, true)
TriggerEvent('esx_society:registerSociety', 'nightclub', 'Nightclub', 'society_nightclub', 'society_nightclub', 'society_nightclub', {type = 'private'})
RegisterServerEvent('esx_nightclubjob:onduty')
AddEventHandler('esx_nightclubjob:onduty', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    if job == 'offnightclub' then
        xPlayer.setJob('nightclub', grade)
        TriggerClientEvent('esx:showNotification', _source, _U('now_on_duty'))
    elseif job == 'nightclub' then
        TriggerClientEvent('esx:showNotification', _source, _U('already_on_duty'))
    end
end)
RegisterServerEvent('esx_nightclubjob:offduty')
AddEventHandler('esx_nightclubjob:offduty', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    if job == 'nightclub' then
        xPlayer.setJob('offnightclub', grade)
        TriggerClientEvent('esx:showNotification', _source, _U('now_off_duty'))
    elseif job == 'offnightclub' then
        TriggerClientEvent('esx:showNotification', _source, _U('already_off_duty'))
    end
end)

MySQL.ready(function()

	MySQL.Async.fetchAll('SELECT * FROM nightclub_store', {}, function(result)
		for i=1, #result, 1 do
			if nightclubItems[result[i].zone] == nil then
				nightclubItems[result[i].zone] = {}
			end

			table.insert(nightclubItems[result[i].zone], {
				item  = result[i].item,
				price = result[i].price,
				label = ESX.GetWeaponLabel(result[i].item)
			})
		end

		TriggerClientEvent('esx_nightclubjob:sendShop', -1, nightclubItems)
	end)

end)

ESX.RegisterServerCallback('esx_nightclubjob:getShop', function(source, cb)
	cb(nightclubItems)
end)

ESX.RegisterServerCallback('esx_nightclubjob:buyWeapon', function(source, cb, weaponName, zone)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = GetPrice(weaponName, zone)
    local societyAccount = nil

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_nightclub', function(account)
        societyAccount = account
      end)

	if price == 0 then
		print(('esx_nightclubjob: %s attempted to buy a unknown weapon!'):format(xPlayer.identifier))
		cb(false)
	end

	if xPlayer.hasWeapon(weaponName) then
		TriggerClientEvent('esx:showNotification', source, _U('already_owned'))
		cb(false)
	else
		if societyAccount ~= nil and societyAccount.money >= price then
            societyAccount.removeMoney(price)
			xPlayer.addWeapon(weaponName, 42)
			cb(true)
		else
			TriggerClientEvent('esx:showNotification', source, _U('not_enough'))
			cb(false)
		end
	end
end)

function GetPrice(weaponName, zone)
	local price = MySQL.Sync.fetchScalar('SELECT price FROM nightclub_store WHERE zone = @zone AND item = @item', {
		['@zone'] = zone,
		['@item'] = weaponName
	})

	if price then
		return price
	else
		return 0
	end
end
