rednet.open("left")

function findItem(name)
    for search = 16, 1, -1 do
        turtle.select(search)
        if turtle.getItemDetail() ~= nil then
            if turtle.getItemDetail().name == name then -- block
                return search
            end
        end
    end

    return 1
end

function checkFuel()
    if (turtle.getFuelLevel() / turtle.getFuelLimit()) <= 0.5 then
        turtle.select(findItem("linkedstorage:ender_chest"))
        turtle.place()

        turtle.suck(64)
        turtle.select(findItem("minecraft:coal"))
        turtle.refuel()
        turtle.dig()
    end
end

function placeLoader() 
    for search = 16, 1, -1 do
        turtle.select(search)
        if turtle.getItemDetail() ~= nil then
            if turtle.getItemDetail().name == "mekanism:quantum_entangloporter" then -- Chunk loader
                turtle.place()
                break
            end
        end
    end
end

function crossChunk() -- Use when L shape away from chunk loader, loader on the right
    turtle.forward()
    turtle.turnRight()
    placeLoader()

    turtle.turnLeft()
    turtle.forward()
    turtle.turnRight()
    turtle.dig()

    turtle.forward()
    turtle.turnLeft()
    turtle.turnLeft()
    placeLoader()

    turtle.turnLeft()
    turtle.dig()

    turtle.turnLeft()
    turtle.turnLeft()
    placeLoader()

    sleep(5)
    rednet.broadcast("chunksafe")
    permission = false

    turtle.up()
    turtle.forward()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnLeft()
    turtle.down()
    turtle.dig()

    turtle.turnLeft()
    turtle.turnLeft()

    for distance = 15, 1, -1 do
        turtle.forward()
    end

    turtle.turnRight()
    placeLoader()

    turtle.turnRight()
    for distance = 15, 1, -1 do
        turtle.forward()
    end

    turtle.turnLeft()
    turtle.dig()
    turtle.turnLeft()

    for distance = 13, 1, -1 do
        turtle.forward()
    end
end

while true do
    while true do
        rednet.broadcast("relayproceed")
        
        id, message = rednet.receive()
        if message == "proceedrelay" then
            rednet.broadcast("resetproceed")
            break
        end

        sleep(0)
    end
    
    crossChunk()
    checkFuel()
    
    sleep(0)
end