local winMgr = require("winMgr")
local eventMgr = require("eventMgr")
local oscmd = require("oscmd")


local Main = {}


local program_list = {}


local quit = false


function Main.log(text)
    program_list["Debug"]:log(text)
end


function Main.loadProgram(title)
    local path = "programs/" .. title .. "/"                    --path = programfolder (programs/title)
    local path_to_main = path .. title
    local program_module = require(path_to_main)                --get program module

    program_list[title] = program_module:new(winMgr, path)      --initiate program and save it to program_list
end

function Main.launch(title, parent)
    if program_list[title] == nil then                          --if program not in program_list -> load it
        Main.loadProgram(title)
    end
    
    if parent ~= nil then
        winMgr.removeScene(parent)
    end
    
    program_list[title]:launch()                                --launch program
end

function Main.stopProgram(title)
    if program_list[title] ~= nil and title ~= "Home" then                         
        program_list[title] = nil
        Main.log("Unloaded: " .. title)
    end

end

function Main.onScroll(value)
    program_list["Debug"]:onScroll(value)
end


--_________________________________________
--STOP COMMANDS

function Main.shutdown()
    quit = true
end

function Main.restart()
    sleep(0.01)
    term.clear()
    term.setCursorPos(1,1)
    shell.run("reboot")
end

--_________________________________________
--LOOPS

function Main.graphicsLoop()                                    
    while not quit do
        winMgr.draw()
        os.sleep(0.1)
    end
end

function Main.loop()
    while not quit do
        eventMgr.listen()
    end
end


--_________________________________________
--

function Main.main()                                            --should probably be called main.init()
    term.clear()

    oscmd.setMain(Main)
    oscmd.setWinMgr(winMgr)
    oscmd.setEventMgr(eventMgr)

    eventMgr.init(Main, winMgr)
    winMgr.init()
    
    Main.launch("Debug")
    Main.launch("Home")
    
    parallel.waitForAny(Main.loop, Main.graphicsLoop)
end



Main.main()


term.clear()
term.setCursorPos(1,1)
shell.run("shutdown")





