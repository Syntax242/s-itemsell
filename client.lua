local QBCore = exports['qb-core']:GetCoreObject()
local spawnedNPCs = {}

CreateThread(function()
    while true do
        for k, v in pairs(Config.Sellers) do
            local shouldBeActive = IsSellerActive(v)

            if shouldBeActive and not spawnedNPCs[k] then
                SpawnSellerNPC(k, v)
            elseif not shouldBeActive and spawnedNPCs[k] then
                DeleteSellerNPC(k)
            end
        end
        Wait(30000)
    end
end)

function SpawnSellerNPC(id, data)
    RequestModel(data.npcModel)
    while not HasModelLoaded(data.npcModel) do
        Wait(10)
    end

    local npc = CreatePed(4, data.npcModel, data.coords.x, data.coords.y, data.coords.z - 1, data.coords.w, false, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    FreezeEntityPosition(npc, true)

    exports['qb-target']:AddTargetEntity(npc, {
        options = {
            {
                label = data.targetLabel or data.name,
                icon = "fas fa-dollar-sign",
                action = function()
                    local playerJob = QBCore.Functions.GetPlayerData().job.name
                    if not data.job or data.job == false or playerJob == data.job then
                        OpenSellMenu(data)
                    else
                        QBCore.Functions.Notify(Config.Locale.notify_no_access, "error")
                    end
                end,
            },
        },
        distance = 2.0
    })

    spawnedNPCs[id] = npc

    if data.blip and data.blip.enable then
        local blip = AddBlipForCoord(data.coords.x, data.coords.y, data.coords.z)
        SetBlipSprite(blip, data.blip.sprite or 500)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, data.blip.scale or 0.7)
        SetBlipColour(blip, data.blip.color or 2)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(data.blip.name or "Seller")
        EndTextCommandSetBlipName(blip)
    end
end

function DeleteSellerNPC(id)
    if spawnedNPCs[id] then
        DeleteEntity(spawnedNPCs[id])
        spawnedNPCs[id] = nil
    end
end

function IsSellerActive(sellerData)
    if not sellerData.activeHours or not sellerData.activeHours.enable then
        return true
    end

    local hour = GetClockHours()

    if sellerData.activeHours.start < sellerData.activeHours.stop then
        return hour >= sellerData.activeHours.start and hour < sellerData.activeHours.stop
    else
        return hour >= sellerData.activeHours.start or hour < sellerData.activeHours.stop
    end
end

function OpenSellMenu(sellerData)
    local menu = {
        {
            header = sellerData.menuHeader or Config.Locale.sell_menu_header,
            isMenuHeader = true
        }
    }

    for _, itemData in ipairs(sellerData.items) do
        menu[#menu+1] = {
            header = (itemData.name or itemData.item),
            txt = (Config.Locale.price_prefix or "Price: ") .. "$" .. itemData.price,
            params = {
                event = "s-itemsell:client:SellItem",
                args = {
                    item = itemData.item,
                    name = itemData.name,
                    price = itemData.price,
                    progressTime = sellerData.progressTime or 5000,
                    seller = sellerData
                }
            }
        }
    end

    menu[#menu+1] = {
        header = Config.Locale.sell_menu_exit,
        txt = Config.Locale.sell_menu_exit_desc,
        params = {
            event = "qb-menu:client:closeMenu"
        }
    }

    exports['qb-menu']:openMenu(menu)
end

RegisterNetEvent('s-itemsell:client:SellItem', function(data)
    local playerPed = PlayerPedId()

    RequestAnimDict('mp_common')
    while not HasAnimDictLoaded('mp_common') do
        Wait(10)
    end
    TaskPlayAnim(playerPed, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 48, 0, false, false, false)

    QBCore.Functions.Progressbar("selling_item", Config.Locale.selling_progress, data.progressTime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        ClearPedTasks(playerPed)

        if data.seller and data.seller.effect then
            StartScreenEffect("DrugsTrevorClownsFight", 0, false)
            PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", true)

            SetTimeout(5000, function()
                StopScreenEffect("DrugsTrevorClownsFight")
            end)
        end

        TriggerServerEvent('s-itemsell:server:SellItem', {
            item = data.item,
            name = data.name,
            price = data.price,
            seller = data.seller
        })
    end, function()
        ClearPedTasks(playerPed)
        QBCore.Functions.Notify(Config.Locale.notify_sell_cancel, "error")
    end)
end)

RegisterNetEvent('s-itemsell:client:SetPoliceBlip', function(coords)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, Config.PoliceBlip.sprite or 161)
    SetBlipScale(blip, Config.PoliceBlip.scale or 1.2)
    SetBlipColour(blip, Config.PoliceBlip.color or 1)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Locale.blip_police_alert or "Suspicious Activity")
    EndTextCommandSetBlipName(blip)

    SetTimeout(Config.PoliceBlip.time or 30000, function()
        RemoveBlip(blip)
    end)
end)
