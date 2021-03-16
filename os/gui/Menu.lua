local Scene = require("gui/Scene")
local Button = require("gui/Button")
local Label = require("gui/Label")
local oscmd = require("oscmd")

local Menu = {}
Menu.__index = Menu
setmetatable(Menu, {__index = Scene}) 



local term_w, term_h = term.getSize()
local pos_init = {1,1}
local size_init = {term_w, 1}



function Menu.new(class, program, mouse_pos)
    local self = Scene:new(program, pos_init, size_init)
    setmetatable(self, class)
    
    self.title = "Menu"
    self.topbar_text = "Menu"
    self.background_color = colors.gray
    self.text_color = colors.white


    
    return self
    
    
end