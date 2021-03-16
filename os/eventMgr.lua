local oscmd = require("oscmd")

local eventMgr = {}

local main
local winMgr

function eventMgr.setWinMgr(_winMgr)
    winMgr = _winMgr
end


-- key events
function keyEvents(key)                                         --currently just logs keys to debugWin
	if key == 28 then
        main.log("Key Press: Enter")
        
    elseif key == keys.up then                                  --arrowkeys up/down scrolls debugWin 
        main.onScroll(1)                                      --(os.event("mouse_scroll") is fucked)
        
    elseif key == keys.down then
        main.onScroll(-1)
    
    else 
        main.log("Key Press: " .. keys.getName(key))          
    end
end





function eventMgr.listen()
	local event, param1, param2, param3 = os.pullEvent()
	
	if event == "key" then                                      --keyboard key event
		keyEvents(param1)
        
    elseif event == "mouse_click" then                          --mouse_click event
        oscmd.log("Click: "..param2 ..","..param3)            --currently does noit distinguish between left, right, middle
        winMgr.onClick(param2, param3)
        
    elseif event == "mouse_scroll" then
        --winMgr.onScroll(param1, param2, param3)                 --this shit just doesnt work wtf

    end
    
end


function eventMgr.init(_main, _winMgr)
    main = _main                                                --let eventMgr know Main, could be useful in the future
    winMgr = _winMgr    
end


return eventMgr






