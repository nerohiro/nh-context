# nh-context
Simple, minimalistic event firing context menu for RedM and FiveM

# Information
I really liked the look of these dark themed context menus but haven't seen a lot released, now I'm sure mine isn't the best it's one of my first few public scripts and I feel it's really user friendly, I hope you all find a use for this and enjoy it!


# Setup
It's pretty simple, once you drop the nh-context resource into your resources folder just make sure you put

ensure nh-context

in your server.cfg. 


# Usage

https://streamable.com/j4wkwi

Here is a base menu to show how it works, this is a kind of a "figure it out" type of situation but I hope my examples help, the code below is what made the video above!
```
RegisterCommand("testcontext", function()
    TriggerEvent("nh-context:testmenu")
end)

RegisterNetEvent("nh-context:testMenu", function()
    TriggerEvent("nh-context:createMenu", {
        {
            header = "Main Title",
        },
        {
            header = "Sub Menu Button",
            context = "This goes to a sub menu",
            event = "nh-context:testMenu2",
            image = "https://i.imgur.com/xO1mXkX.png",
            args = {1,2}
        }
    })
end)

RegisterNetEvent('nh-context:testMenu2', function(id, number)
    TriggerEvent('nh-context:createMenu', {
        {
            header = "< Go Back",
            event = "nh-context:testMenu"
        },
        {
            header = "Number: " .. number,
            context = "ID: " .. id
        },
    })
end)

```

Note: Anything not marked "Required" below you don't even have to include if you don't want to.
```
    {
        header = "The Header, whatever you want to put", -- Required
        context = "The base of the text in the button",
        server = "pass "true" if you want the button to trigger a server event"
        image = "add an image url here and itll show off to the left side when you hover over this button, example below"
        event = "the event you actually want to trigger, remember if you set it server = true this will pass to the server side"
        args = { -- These are the arguments you send with the event
            table,
            integer,
            boolean -- the order you put these in will be the order they kick out thru the receiving event function(table, integer, boolean)
        }
    }
```

[Image Usage Example](https://lithi.io/file/uS4x.png)


Example of using a table to build a menu:

```

local menu = {
    {
        header = "Title Here",
        context = ""
    }
}

for k, v in pairs(randomTable) do
    table.insert(menu,  {
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
        {
            header = "Pick One",
        },
        {
            header = "Number: " .. number,
            context = "ID: " .. id
            returnValue = "1"
        },
        {
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

