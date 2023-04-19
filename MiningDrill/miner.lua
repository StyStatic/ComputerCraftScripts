rednet.open("left")
blocksfromlastmine = 64

function broadcastProceed() 
    while true do
        rednet.broadcast("proceed")
    end
end

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

function moveLogic()
    thread = coroutine.create(broadcastProceed)
    coroutine.resume(thread)

    while true do
        id, message = rednet.receive()
        if message == "chunksafe" then
            coroutine.yield(thread)
            break
        end

        sleep(0)
    end

    for distance = 16, 1, -1 do
        turtle.forward()
        blocksfromlastmine = blocksfromlastmine + 1
    end
end

function startMine()
    slot = findItem("mekanism:digital_miner")
    turtle.select(slot)

    turtle.placeUp()
    turtle.turnLeft()
    turtle.forward()
    turtle.forward()

    turtle.select(findItem("fluxnetworks:flux_point"))
    turtle.placeUp()

    turtle.back()
    turtle.back()

    turtle.turnRight()

    turtle.forward()
    turtle.forward()
    turtle.forward()

    turtle.up()
    turtle.up()

    turtle.turnLeft()
    turtle.turnLeft()

    turtle.select(findItem("mekanism:qio_importer"))
    turtle.place()

    turtle.down()
    turtle.down()

    turtle.forward()
    turtle.forward()
    turtle.forward()

    turtle.turnLeft()
    turtle.turnLeft()

    miner = peripheral.wrap("top")
    blocksfromlastmine = 0
    miner.start()

    while true do
        if miner.getToMine() == 0 then
            miner.stop()

            turtle.digUp() -- Digital Miner
            turtle.turnLeft()
            turtle.forward()
            turtle.forward()

            turtle.digUp() -- Flux Point

            turtle.back()
            turtle.back()

            turtle.turnRight()

            turtle.forward()
            turtle.forward()
            turtle.forward()

            turtle.up()
            turtle.up()

            turtle.turnLeft()
            turtle.turnLeft()

            turtle.dig() -- QIO Importer

            turtle.down()
            turtle.down()

            turtle.forward()
            turtle.forward()
            turtle.forward()

            turtle.turnLeft()
            turtle.turnLeft()
            break
        end
    end
end

while true do
    if blocksfromlastmine >= 64 then
        startMine()
    end

    moveLogic()
end