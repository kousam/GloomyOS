local Scene = require("gui/Scene")
local Button = require("gui/Button")
local Label = require("gui/Label")
local oscmd = require("oscmd")
local Frame = require("gui/Frame")

local DebugScene = {}
DebugScene.__index = DebugScene
setmetatable(DebugScene, {__index = Scene}) 



local term_w, term_h = term.getSize()
local pos_init = {27, 1}
local size_init = {term_w - 27 + 1, term_h}


function DebugScene.new(class, program)
    local self = Scene:new(program, pos_init, size_init)
    setmetatable(self, class)
    
    self:setTitle("Debug")
    self:setTopbarText("Debug")
    self:setBackgroundColor(colors.blue)
    self:setTextColor(colors.white)
    
    self.log_list = {}
    self.scroll = 0
    
    
   
    
    
    return self
    
    
end


function DebugScene:log(text, pos)
    local label_x = 2
    local label_y = pos
    
    

    local label = Label:new(text, {label_x, label_y}, {1, 1}, colors.white, colors.blue)
    label:setAnchor("w")

    self:addRaw(label)
    
    
    
    return label
end









return DebugScene
