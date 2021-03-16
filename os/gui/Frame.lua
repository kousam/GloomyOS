local GUIObject = require("gui/GUIObject")
local Rect = require("gui/Rect")
local oscmd = require("oscmd")

local Frame = {}
Frame.__index = Frame
setmetatable(Frame, {__index = GUIObject}) 




function Frame.new(class, pos, size, txt_color, bg_color)
    local self = GUIObject:new(pos, size)       -- inherit Label
    setmetatable(self, class)
    
    self.type           = "Frame"
    self.title          = "Frame"

    self.content_list   = {}
    
    self.text_color     = txt_color or colors.black
    
    self.rect           = Rect:new(pos, size, bg_color)
    
    self:add(self.rect)
    

    
    return self

end


function Frame:draw(root_x, root_y)
    
    for key, guiObj in pairs(self.content_list) do                      -- draw guiObjs
        local x = root_x + self.x - 1
        local y = root_y + self.y - 1
        guiObj:draw(x,y)
        

        
    end
end


function Frame:setTextColor(color)
    self.text_color = color
end

function Frame:setBackgroundColor(color)
    self.background_color = color
    self.rect:setColor(color)
end



function Frame:addRaw(guiObj)                                           --addRaw does not send logs to debugWin
    table.insert(self.content_list, guiObj)
end

function Frame:add(guiObj)                                              --adds guiObj to content list
    oscmd.log(self.type .. " <- " .. guiObj:getTitle())
    local key = #self.content_list + 1
    self.content_list[key] = guiObj

    
    return key
end

function Frame:remove(key)                                              --removes guiObj from content list
    if self.content_list[key] ~= nil then
        oscmd.log("Frame -: " .. self.content_list[key]:getTitle())
        self.content_list[key] = nil
    else
        oscmd.log("Remove failed: guiObj not found")
    end
end


function Frame:getContent()
    
    content = {}
    
    for i, guiObj in ipairs(self.content_list) do
        
        if is_instance(guiObj, Frame) then
            content[#content + 1] = guiObj
            content = tableConcat(content, guiObj:getContent())
        else
            content[#content + 1] = guiObj
        end
    
    end

    
    return content
end


function is_instance(o, class)
    while o do
        o = getmetatable(o)
        if class == o then return true end
    end
    return false
end

function tableConcat(t1,t2)
    for i, guiObj in ipairs(t2) do
        t1[#t1 + i] = t2[i]
    end
   
    
    return t1
end


    
return Frame
