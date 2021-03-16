local GUIObject = require("gui/GUIObject")
local winTools = require("winTools")
local Rect = require("gui/Rect")

local Label = {}
Label.__index = Label
setmetatable(Label, {__index = Rect}) 




function Label.new(class, text, pos, size, txt_color, bg_color)
    local self = Rect:new(pos, size, bg_color)
    setmetatable(self, class)
    
    self.type   = "Label"
    self.title  = "Label"
    --self.clickable = false                                          --i should create an Item/GUIObject class
    
    self.text               = text
    
    self.text_color         = txt_color or colors.black
    self.background_color   = bg_color or colors.white
    
    self.anchor = "center"                                          --center, n, s, w, e, nw, ne, sw, se
    

    

    return self
    
end

--___________________________________
--SETTERS

function Label:setText(text)
    self.text = text
end

function Label:setBackgroundColor(color)
    self.background_color = color
    Rect:setColor(self, color)
end

function Label:setTextColor(color)
    self.text_color = color
end

function Label:setAnchor(value)
    self.anchor = value
end

function Label:setScroll(value)
    self.y = self.y_init + value
end


--___________________________________
--GETTERS




function Label:getClickable()
    return self.clickable
end


function Label:getTextPos()
    local x
    local y
    

    if self.anchor == "center" then
        x = math.floor((self.w - string.len(self.text)) /2) + self.x
        y = math.floor(self.h/2) + self.y
        
        
    elseif self.anchor == "w" then
        x = self.x
        y = math.floor(self.h/2) + self.y
    end
        
    
    return {x,y}
end





--___________________________________
--DRAW


function Label:draw(root_x, root_y)
    
    if winTools.inWindow(root_x + self.x - 1, root_y + self.y - 1) then
        
        
        
        
        Rect.draw(self, root_x, root_y)
        
        term.setTextColor(self.text_color)
        
        
        
        
        local text_x, text_y = unpack(self:getTextPos())    --get text position depending on anchoring
        local x = root_x + text_x - 1
        local y = root_y + text_y - 1
        
        local function split (inputstr)
            local t = {}
            for str in string.gmatch(inputstr, "([^%s]+)") do
                t[#t + 1] = str
            end
            return t
        end
        
        
        
        term.setCursorPos(x,y)
        write(self.text)                                    --write text
     
    end

    
end







return Label











