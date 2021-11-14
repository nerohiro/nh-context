local Promise, ActiveMenu = nil, false

RegisterNUICallback("dataPost", function(data, cb)
    SetNuiFocus(false, false)
    if Promise ~= nil then
        if data.returnValue then
            Promise:resolve(data.returnValue)
        else
            Promise:resolve(true)
        end
        Promise = nil
    end
    if data.event and not data.returnValue then
        if not data.server then
            TriggerEvent(data.event, data.args)
        else
            TriggerNetEvent(data.event, data.args)
        end
    end
    ActiveMenu = false
end)

RegisterNUICallback("cancel", function()
    SetNuiFocus(false, false)
    if Promise ~= nil then
        Promise:resolve(nil)
        Promise = nil
    end
    ActiveMenu = false
end)

CreateMenu = function(data)
    ActiveMenu = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "OPEN_MENU",
        data = data
    })
end

ContextMenu = function(data)
    if not data or Promise ~= nil then return end
    while ActiveMenu do Wait(0) end

    Promise = promise.new()

    CreateMenu(data)

    return Citizen.Await(Promise)
end

CloseMenu = function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "CLOSE_MENU",
    })
    ActiveMenu = false
end

exports("ContextMenu", ContextMenu)
exports("CloseMenu", CloseMenu)



RegisterNetEvent('nh-context:createMenu', function(data)
    if not data then return end
    while ActiveMenu do Wait(0) end
    CreateMenu(data)
end)

RegisterNetEvent("nh-context:closeMenu", function()
    CloseMenu()
end)
