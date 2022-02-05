local Promise, ActiveMenu = nil, false

RegisterNUICallback("dataPost", function(data, cb)
    local id = tonumber(data.id) + 1 or nil
    local rData = ActiveMenu[id]
    if rData then
        if Promise ~= nil then
            Promise:resolve(rData.args)
            Promise = nil
        end
        if rData.event and Promise == nil then
            if not rData.server then
                TriggerEvent(rData.event, UnpackParams(rData.args))
            else
                TriggerServerEvent(rData.event, UnpackParams(rData.args))
            end
        end
    end
    CloseMenu()
    cb("ok")
end)

RegisterNUICallback("cancel", function(data, cb)
    if Promise ~= nil then
        Promise:resolve(nil)
        Promise = nil
    end
    CloseMenu()
    cb("ok")
end)

CreateMenu = function(data)
    ActiveMenu = ProcessParams(data)
    SendNUIMessage({
        action = "OPEN_MENU",
        data = data
    })
    SetNuiFocus(true, true)
end

ContextMenu = function(data)
    if not data or Promise ~= nil then return end
    while ActiveMenu do Wait(0) end
    
    Promise = promise.new()
    
    CreateMenu(data)
    
    return UnpackParams(Citizen.Await(Promise))
end

CloseMenu = function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "CLOSE_MENU",
    })
    ActiveMenu = false
end

CancelMenu = function()
    SendNUIMessage({
        action = "CANCEL_MENU",
    })
end

ProcessParams = function(data)
    for _, v in pairs(data) do
        if v.args and type(v.args) == "table" and next(v.args) ~= nil then
            v.args = PackParams(v.args)
        end
    end
    return data
end

PackParams = function(arguments)
    local args, pack = arguments, {}
    
    for i = 1, 15, 1 do
        pack[i] = args[i]
    end
    return pack
end

UnpackParams = function(arguments, i)
    if not arguments then return end
    local index = i or 1
    
    if index <= #arguments then
        return arguments[index], UnpackParams(arguments, index + 1)
    end
end

exports("ContextMenu", ContextMenu)
exports("CancelMenu", CancelMenu)



RegisterNetEvent("nh-context:createMenu", function(data)
    if not data then return end
    while ActiveMenu do Wait(0) end
    CreateMenu(data)
end)

RegisterNetEvent("nh-context:cancelMenu", CancelMenu)
