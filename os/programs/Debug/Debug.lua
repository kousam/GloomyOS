local Program = require("Program")




local Debug = {}
Debug.__index = Debug
setmetatable(Debug, {__index = Program}) 



function Debug.new(class, winMgr, path)
    local self = Program:new(winMgr, path)
    setmetatable(self, class)
    
    self.title = "Debug"
    self.start_scene_title = "DebugScene"
    
    
    self.log_list = {}
    
    self.scroll = 0

    return self
end


function Debug:launch()
    self:init()
end


function Debug:log(text)
    
    
    --text, x, y, w, h, txt_color, bg_color)
    if self.curr_scene ~= nil then
        local pos = #self.log_list + 1
    
        local label = self:getScene("DebugScene"):log(text, pos)
        self.log_list[pos] = label
        
        if pos > 19 then
        self.scroll = self.scroll - 1
        
            for key, value in pairs(self.log_list) do
                value:setScroll(self.scroll)
            end
        end
    end

    
    
    
    
    

end

function Debug:onScroll(value)
    local pos = #self.log_list + 1
    -- if more than 19 guiObjs
    if pos >= 20 then
    
        --add to scroll
        self.scroll = self.scroll + value
        

        for key, value in pairs(self.log_list) do
            value:setScroll(self.scroll)
        end
        
            
        if self.scroll > -1 then
            self.scroll = -1
            
        elseif self.scroll < - pos + 19 then
            self.scroll = - pos + 19
            
        end
    end
    
end







return Debug
