local server = false
local menuOpen = false

RegisterNUICallback("dataPost", function(data, cb)
    SetNuiFocus(false)
    if server then
        TriggerServerEvent(data.event, data.args)
        server = false
    else
        TriggerEvent(data.event, data.args)
    end
    menuOpen = false
    cb('ok')
end)

RegisterNUICallback("cancel", function()
    SetNuiFocus(false)
end)


RegisterNetEvent('nh-context:sendMenu', function(data, toServer)
    if not data then return end
    if toServer then server = true end
    if not menuOpen then
        SetNuiFocus(true, true)
        menuOpen = true
        SendNUIMessage({
            action = "OPEN_MENU",
            data = data
        })
    else
       print('A menu of this type is already open.')
    end
end)
