
    local colourMan = require("colourManager")
    local displayMan = require("displayManager")

    local obstacleFuncs = {}
    local obstacleCollisionFilter = {categoryBits=2, maskBits=9}    --Obstacles (2) collides with player (1) and playerBullets (8)

    local obGfxTable = {
        ["White"] = "Resources/Gfx/rock.png",
        ["Green"] = "Resources/Gfx/bush.png",
        ["Blue"] = "Resources/Gfx/water.png",
        ["Red"] = "Resources/Gfx/lava.png",
        ["Yellow"] = "Resources/Gfx/danger.png",
        ["Cyan"] = "Resources/Gfx/ice.png",
        ["Magenta"] = "Resources/Gfx/poison.png",
    }

    local obArray = {}

    local function obstacles_SpawnAll(fileName)
        while (#obArray < 6) do --spawn 6 obstacles
            local dimensions = math.random(100, 200)
            local ob = displayMan.newRandomImageRect(fileName, dimensions, dimensions)
            physics.addBody(ob, "static", {density=1.0, filter=obstacleCollisionFilter})
            table.insert(obArray, ob)       
        end	
    end
    
    local function obstacles_RemoveAll()
        for i,v in ipairs(obArray) do
            v.isVisible = false
            displayMan.remove(v)
            v = nil
        end
        obArray = {}
    end

    --to be used as a callback
    local function updateObstacles()
        obstacles_RemoveAll()
        obstacles_SpawnAll(obGfxTable[colourMan.getColourString()])
    end
    
    function obstacleFuncs.Setup()
        obstacles_RemoveAll()
        colourMan.addCallback(function()updateObstacles()end)
    end
    
    function obstacleFuncs.Cleanup()
        obstacles_RemoveAll()
    end


return obstacleFuncs