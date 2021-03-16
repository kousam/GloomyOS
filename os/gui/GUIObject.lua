

local GUIObject = {}
GUIObject.__index = GUIObject



function GUIObject.new(class, pos, size)
    local self = setmetatable({}, class)

    
    self.type = "GUIObject"
    self.title = "GUIObject"
    

    self.x, self.y          = unpack(pos)
    self.x_init             = self.x                                     --x_init, y_init is used for scrolling
    self.y_init             = self.y
    self.z                  = 1                                     --z value determines draw order. default = 1
    self.w, self.h          = unpack(size)
    
    self.active = false
    
    return self
end


--___________________________________
--SETTERS


function GUIObject:setPos(x,y)
    self.x = x
    self.y = y
end

function GUIObject:setZ(z)
    self.z = z
end

function GUIObject:setSize(w,h)
    self.w = w
    self.h = h
end

function GUIObject:setActive(boolean)
    self.active = bool
end

function GUIObject:setTitle(title)
    self.title = title
end

--___________________________________
--GETTERS

function GUIObject:getType()
    return self.type
end

function GUIObject:getPos()
    return {self.x, self.y}
end

function GUIObject:getSize()
    return {self.w, self.h}
    
end


function GUIObject:getZ()
    return self.z
end

function GUIObject:getActive()
    return self.active
end

function GUIObject:getTitle()
    return self.title
end





return GUIObject










