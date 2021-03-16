local GUIObject = require("gui/GUIObject")
local Button = require("gui/Button")
local Label = require("gui/Label")
local Frame = require("gui/Frame")
local Rect = require("gui/Rect")
local oscmd = require("oscmd")

local Scene = {}
Scene.__index = Scene
setmetatable(Scene, {__index = GUIObject}) 

local term_w, term_h = term.getSize()



--SCENE IS A SUPERCLASS AND SHOULD BE INHERITED
--scenes diplay a programs gui on the terminal
--contain guiObjs/guiobjects
--scenes handle drawing 
--have a size
--can be placed anywhere on display
--scenes can contain sub scenes

--__________________________________

function Scene.new(class, program, pos, size)   

    local self = GUIObject:new(pos, size)
    setmetatable(self, class)
    
    
    
    self.program            = program                   -- set parent program
    self.type               = "Scene"                                              
    self.title              = ""                        
    self.background_color   = colors.black              
    self.text_color         = colors.white              
    self.topbar_color       = colors.white
    self.topbar_text        = ""
    self.topbar_text_color  = colors.black
    self.show_topbar        = true
    self.show_botbar        = true
    

    
    
    self.scene_frame = Frame:new({1,1}, size, self.text_color, self.background_color)
    

    
    return self
end


--__________________________________
--SETTERS


function Scene:setBackgroundColor(color)
    self.background_color = color
    self.scene_frame:setBackgroundColor(color)
end

function Scene:setTextColor(color)
    self.text_color = color
end

function Scene:setTopbarText(text)
    self.topbar_text = text
    if self.topbar_label ~= nil then
        self.topbar_label:setText(self.topbar_text)
    end
end

function Scene:setTopbarColor(color)
    self.topbar_color = color
end

function Scene:setTopbarTextColor(color)
    self.topbar_text_color = color
end

function Scene:showTopbar(bool)
    self.show_topbar = bool
end

function Scene:showBottombar(bool)                              -- this does not work yet
    if bool and not self.show_bottombar then
        self.add(back_button)
        self.add(home_button)
        self.add(power_button)
    end
    
    if not bool and self.show_bottombar then
        self.remove(back_button)
        self.remove(home_button)
        self.remove(power_button)
    end
    
    
    self.show_bottombar = bool
end


--__________________________________
--GETTERS



function Scene:getContent()
    return self.scene_frame:getContent()
end



--__________________________________
--DRAW




function Scene:draw(root_x, root_y)


    --winTools.drawTopBar(title, title_color, topbar_color)
    

    
    
    for key, guiObj in pairs(self:getContent()) do                      -- draw guiObjs
        local x = root_x + self.x - 1
        local y = root_y + self.y - 1
        guiObj:draw(x,y)
        
        
    end
    

end


--_________________________________________
--ADD ITEMS

function Scene:addRaw(guiObj)                                           --addRaw does not send logs to debugWin
    self.scene_frame:addRaw(guiObj)
end

function Scene:add(guiObj)                                              --adds guiObj to content list
    local key = self.scene_frame:add(guiObj)

    return key
end

function Scene:remove(key)                                              --removes guiObj from content list
    self.scene_frame:remove(key)
end






function Scene:addBottomBar()
    self.back_button    = Button:new("Back", 
                                    {2, self.h}, 
                                    {4, 1}, 
                                    self.text_color,
                                    self.background_color) 
                                        
    self.home_button    = Button:new("HOME", 
                                    {math.floor(self.w/2) - 1, self.h}, 
                                    {4, 1},
                                    self.text_color,
                                    self.background_color) 
                                    
    self.power_button   = Button:new("Power", 
                                    {self.w - 5, self.h}, 
                                    {5, 1},
                                    colors.red,
                                    self.background_color)                 
    

    self.back_button:setAnchor("w")
    self.home_button:setAnchor("w")
    self.power_button:setAnchor("w")
    
    self.back_button:setCommand(oscmd.shutdown)
    self.home_button:setCommand(oscmd.launch, {"Home", self.title})
    self.power_button:setCommand(oscmd.shutdown)
    
    self.scene_frame:add(self.back_button)
    self.scene_frame:add(self.home_button)
    self.scene_frame:add(self.power_button)
end


function Scene:addTopBar()
    self.topbar_label = Label:new(self.topbar_text, 
                                    {self.x, self.y}, 
                                    {self.w, 1}, 
                                    topbar_text_color, 
                                    self.topbar_color)
    self.scene_frame:add(self.topbar_label)
end

--_________________________________________
--
    



return Scene
