local MenuOpen = false

RegisterNUICallback("dataPost", function(data, cb)
    SetNuiFocus(false)
    TriggerEvent(data.event, data.args)
    cb('ok')
end)

RegisterNUICallback("cancel", function()
    SetNuiFocus(false)
end)


RegisterNetEvent('nh-context:sendMenu', function(data)
    if not data then return end
    if not MenuOpen then
        SetNuiFocus(true, true)
        MenuOpen = true
        SendNUIMessage({
            action = "OPEN_MENU",
            data = data
        })
    else
        print('A menu is already open to do this action')
    end
end)

