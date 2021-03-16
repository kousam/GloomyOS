local oscmd = require("oscmd")




local Program = {}
Program.__index = Program




--__________________________________

function Program.new(class, winMgr, path)
    local self = setmetatable({}, class)
    
    self.winMgr = winMgr
    self.title = ""
    self.path = path                                    -- path to program folder
    self.scene_list = {}                                -- scene_list contains all loaded scenes
    
    self.start_scene_title = ""
    
    return self
end

function Program:init()
    local scene_title
    if self.curr_scene == nil then
        scene_title = self.start_scene_title
    else
        scene_title = self.curr_scene
    end
    self:setScene(scene_title)
    
end

--__________________________________
--SETTERS

function Program:loadScene(title)
    local scene_module = require(self.path .. title)    --get Scene module
    local scene = scene_module:new(self)                --initiate new Scene object                    
    self.scene_list[title] = scene                      --add to scene_list
end


function Program:setScene(title)
    if self.scene_list[title] == nil then               --if not found in scene_list -> load it
        self:loadScene(title)
    end
    
    local scene = self.scene_list[title]
     
    if self.curr_scene ~= nil then                      --if not first launch
        self.winMgr.removeScene(title)                  --remove curr_scene from window
    end
    
    self.curr_scene = title                             --set new scene
    self.winMgr.setScene(scene)
end


function Program:setTile()
    self.title = title
end

--__________________________________
--GETTERS

function Program:getTitle()
    return self.title
end



function Program:getScene(title)
    return self.scene_list[title]
end





return Program





