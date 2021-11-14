# nh-context
Simple, minimalistic event firing context menu for RedM and FiveM

# Information
I really liked the look of these dark themed context menus but haven't seen alot released, now I'm sure mine isn't the best it's one of my first few public scripts and I feel it's really user friendly, I hope you all find a use for this and enjoy it!

![ShowCase](https://lithi.io/file/LY0d.png)
![ShowCase](https://lithi.io/file/60f7.png)
![ShowCase](https://lithi.io/file/dDnO.png)



# Setup
It's pretty simple, once you drop the nh-context resource into your resources folder just make sure you put

ensure nh-context

in your server.cfg. 


# Usage

https://streamable.com/w04k9z

Here is a base menu to show how it works, this is a kinda "figure it out" type of situation but I hope my examples work, the code below is what made the video above!
```
RegisterCommand("testcontext", function()
    TriggerEvent("nh-context:testmenu")
end)

RegisterNetEvent("nh-context:testMenu", function()
    TriggerEvent("nh-context:createMenu", {
        [1] = {
            header = "Main Title",
        },
        [2] = {
            header = "Sub Menu Button",
            context = "This goes to a sub menu",
            event = "nh-context:testMenu2",
            image = "https://i.imgur.com/xO1mXkX.png",
            args = {
                number = 1,
                id = 2
            }
        }
    })
end)

RegisterNetEvent('nh-context:testMenu2', function(data)
    local id = data.id
    local number = data.number
    TriggerEvent('nh-context:createMenu', {
        [1] = {
            header = "< Go Back",
            context = "",
            event = "nh-context:testMenu"
        },
        [2] = {
            header = "Number: " .. number,
            context = "ID: " .. id
        },
    })
end)

```

Note: Anything not marked "Required" below you don't even have to include if you don't want to.
```
[1] = -- The ID that controls the order of the menu as you send it, this is assigned as an object now to make it easier to understand -- Required
    {
        header = "The Header, whatever you want to put" -- Required
        context = "The base of the text in the button",
        server = "pass "true" if you want the button to trigger a server event"
        image = "add an image url here and itll show off to the left side when you hover over this button, example below"
        event = "the event you actually want to trigger, remember if you set it server = true this will pass to the server side"
        args = { -- These are the arguments you send with the event
            arg1 = table,
            args2 = integar,
            args3 = boolean -- you don't have to actually pass these in any order, just showing they can pass anything
        }

    }
```

[Image Usage Example](https://lithi.io/file/uS4x.png)


Example of using a table to build a menu:

```

local menu = {
    [1] = {
        header = "Title Here",
        context = ""
    }
}

for k, v in pairs(randomTable) do

    local key = #menu + 1
    menu[key] = {
        header = "Random Title " .. key .. " data: " .. k,
        context = "Random context " .. key .. " data: " .. v,
        server = true -- this passes the event below to the server instead of client
        image = "show a cool image ending in jpg, png, gif, etc"
        event = "this fires some event"
    }

end

TriggerEvent('nh-context:createMenu', menu)

```

Exmaple of using the Function to build an asyncronous menu

```
    local accept = exports["nh-context"]:ContextMenu({
        [1] = {
            header = "Pick One",
        },
        [2] = {
            header = "Number: " .. number,
            context = "ID: " .. id
            returnValue = "1"
        },
        [3] = {
            header = "Number: " .. number,
            context = "ID: " .. id
            returnValue = "2"
        },
    })
    if accept ~= nil then
        if accept == "1" then
            -- do something
        elseif accept == "2" then
            -- do something else
        end
    end

```

# Known Bugs
No known bugs

# Support
Feel free to report any issues you have in the GitHub [Issues](https://github.com/nerohiro/nh-context/issues)

if you wish to add something to it, do a pull request on the github [Pull Requests](https://github.com/nerohiro/nh-context/pulls)

