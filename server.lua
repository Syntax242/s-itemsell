local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('s-itemsell:server:SellItem', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local item = Player.Functions.GetItemByName(data.item)
    if item then
        local count = item.amount
        local totalPrice = data.price * count

        Player.Functions.RemoveItem(data.item, count)

        local moneyItem = "cash"
        if data.seller and data.seller.moneyType == "black_money" then
            moneyItem = "black_money"
        end

        Player.Functions.AddItem(moneyItem, totalPrice)

        local message = Config.Locale.notify_sell_success
        message = message:gsub("%%{count}", count)
        message = message:gsub("%%{item}", data.name or data.item)
        message = message:gsub("%%{price}", totalPrice)

        TriggerClientEvent('QBCore:Notify', src, message, "success")

        if data.seller and data.seller.alertPolice and data.seller.alertPolice.enable then
            local chance = data.seller.alertPolice.chance or 0
            local randomNumber = math.random(1, 100)

            if randomNumber <= chance then
                TriggerPoliceAlert(GetEntityCoords(GetPlayerPed(src)))
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Config.Locale.notify_sell_fail, "error")
    end
end)

function TriggerPoliceAlert(coords)
    local players = QBCore.Functions.GetPlayers()
    for _, playerId in ipairs(players) do
        local Player = QBCore.Functions.GetPlayer(playerId)
        if Player and IsJobInPoliceJobs(Player.PlayerData.job.name) then
            TriggerClientEvent('QBCore:Notify', playerId, Config.Locale.notify_police_alert, "error")
            TriggerClientEvent('s-itemsell:client:SetPoliceBlip', playerId, coords)
        end
    end
end

function IsJobInPoliceJobs(jobName)
    for _, allowedJob in ipairs(Config.PoliceJobs) do
        if jobName == allowedJob then
            return true
        end
    end
    return false
end
