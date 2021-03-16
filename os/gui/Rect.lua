local GUIObject = require("gui/GUIObject")




local Rect = {}
Rect.__index = Rect
setmetatable(Rect, {__index = GUIObject})



function Rect.new(class, pos, size, color)     
    local self = GUIObject:new(pos, size)
    setmetatable(self, class)
    
    self.color = color or colors.white
    
    return self
    
end



function Rect:setColor(color)
    self.color = color
end



function Rect:draw(root_x, root_y)
    term.setBackgroundColor(self.color)
    
    
    local y_count = self.y                                              -- clear scenes display area
    while y_count < self.y + self.h do
        local x_count = self.x
        while x_count < self.x + self.w do
            local x = x_count - 1 + root_x
            local y = y_count - 1 + root_y
            

            
            term.setCursorPos(x,y)
            write(" ")
            x_count = x_count + 1
        end
        y_count = y_count + 1
        
    end


end











return Rect







