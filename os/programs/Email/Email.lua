local Scene = require("Scene")
local Button = require("Button")
local oscmd = require("oscmd")

local Email = {}
Email.__index = Email
setmetatable(Email, {__index = Scene}) 

local title = "Email"
local topbar_text = "Email"
local topbar_background_color = colors.lightBlue
local topbar_text_color = colors.black
local background_color = colors.white
local text_color = colors.white

local scene


function Email.new(class)
    local self = Scene:new()
    setmetatable(self, class)
    
    local button_w = 10
    local button_h = 3

    self.email_button = Button:new("Email", 3, 2, button_w, button_h, colors.red, text_color)
    self.chat_button = Button:new("Chat", 3, 6, button_w, button_h, colors.green, text_color)

    

    self:add(self.email_button)
    self:add(self.chat_button)

    
    return self
    
    
end







return Email
