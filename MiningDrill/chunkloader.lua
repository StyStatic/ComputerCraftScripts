rednet.open("left") 

permission = false

function awaitPermission()
    while true do
        id, message = rednet.receive()
        if message == "proceed" then
            permission = true
            break
        end

        sleep(0)
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


thread = coroutine.create(awaitPermission) -- Starts Coroutine
coroutine.resume(thread)

while true do
    if permission == true then
        permission = false
        crossChunk()
    end
end