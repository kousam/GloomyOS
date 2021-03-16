local Label = require("gui/Label")
local oscmd = require("oscmd")

local Button = {}


Button.__index = Button
setmetatable(Button, {__index = Label}) 


function Button.new(class, text,  pos, size, txt_color, bg_color)
    local self = Label:new(text, pos, size, txt_color, bg_color)       -- inherit Label
    setmetatable(self, class)
    
    self.type       = "Button"
    self.title      = "Button"
    self.active     = true

    return self
    
end

--___________________________________
--SETTERS

function Button:setCommand(cmd, args)                                         -- sets a function as a command
    self.cmd = cmd                                                      -- in future maybe also args
    self.args = args
end




--___________________________________
--GETTERS

function Button:getCommand()
    return {self.cmd, self.args}
end


function Button:pressed(m_x, m_y)                                       --checks if button is pressed
    local hit = false                                                   --returns boolean value
    x,y = unpack(self:getPos())
    w,h = unpack(self:getSize())
         
    if x <= m_x and m_x < x + w and y <= m_y and m_y < y + h then
        hit = true
        self:log()
    end
    
    return hit
end



function Button:onClick()
    self.cmd(unpack(self.args))
end



function Button:log()
    oscmd.log(self:getTitle() .. ": Pressed")
end





return Button







