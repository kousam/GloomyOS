local winTools = require("winTools")
local oscmd = require("oscmd")

local chat = {}

local title = "chat"
local topbar_text = "Giddy"
local topbar_background_color = colors.green
local topbar_text_color = colors.white
local background_color = colors.white
local text_color = colors.black

local w,h = term.getSize()


--__________________________________
--COMMANDS HERE




--__________________________________


local home.setTools(wt, b, em)
    winTools = wt
    buttons = b
    eventMgr = em
end



local function draw()
    term.setBackgroundColor(background_color)
    term.clear()
    winTools.drawTopBar(topbar_text, topbar_text_color, topbar_background_color)
    buttons.draw(title, value)
end


function chat.init()

    buttons.new(title, "back", 1, h, 6, 1, "Back", background_color, text_color)
    buttons.new(title, "home",11, h, 6, 1, "HOME", background_color, text_color)
    buttons.new(title,"power", w - 5, h, 7, 1, "Power", background_color, colors.red)

    
end



function chat.main()
    local quit = false
    local continue_value
    
    while not quit do
        continue_value = 1
        
        eventMgr.setScene(title)
        
        draw()
        continue_value = eventMgr.listen()
        
        if continue_value == 2 then
            continue_value = 1
            quit = true
                
        elseif continue_value == 3 or  continue_value == 4 then
            quit = true
        end
    end
    
    return continue_value
    
end	



return chat




