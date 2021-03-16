
local oscmd = {}


-- this is a tool that lets any file access to Main, winMgr and eventMgr




local Main
local winMgr
local eventMgr

--_________________________
--SETTERS


function oscmd.setMain(_Main)
    Main = _Main
end

function oscmd.setWinMgr(_winMgr)
    winMgr = _winMgr
end

function oscmd.setEventMgr(_eventMgr)
    eventMgr = _eventMgr
end


--_________________________
--GETTERS





--_________________________
--COMMANDS

function oscmd.launch(title, parent)
    Main.launch(title, parent)
end


function oscmd.log(text)

    Main.log(text)
end


function oscmd.onClick(x,y)
    winMgr.onClick(x,y)
end

function oscmd.exit()
    winMgr.exit()
end

function oscmd.setScene(title)
    winMgr.setScene(title)
end

function oscmd.restart()
    Main.restart()
end

function oscmd.shutdown()
    Main.shutdown()
end



return oscmd



