local Button = require("gui/Button")
local oscmd = require("oscmd")

local CheckBox = {}
CheckBox.__index = CheckBox
setmetatable(CheckBox, {__index = Button}) 

local size = {1,1}
local text = ""


function CheckBox.new(class, pos, tick_color, bg_color)
    local self = Button:new(text, pos, size, tick_color, bg_color)       -- inherit Label
    setmetatable(self, class)
    
    self.type   = "CheckBox"
    self.title  = "CheckBox"
    self.value  = false
    
    self:setCommand(self.changeValue, {self})

    return self
    
end

function CheckBox:changeValue()
    if self.value then
        self.value = false
     
    else 
        self.value = true
    end
    
    local log_txt = "false"
    if self.value then
        log_txt = "true"
    end
    oscmd.log(self.type .. ": " .. log_txt)
    
    self:setTick()
end


--___________________________________________
--SETTERS

function CheckBox:setTick()
    if self.value then
        self:setText("x")
    else
        self:setText("")
    end
end


--___________________________________________
--GETTERS

function CheckBox:getValue()
    return self.value
end







return CheckBox


