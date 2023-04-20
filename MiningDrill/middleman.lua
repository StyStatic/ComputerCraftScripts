rednet.open("back")

proceed = false
chunksafe = false

while true do
    id, message = rednet.receive()
    if message == "proceed" then
        proceed = true
    elseif message == "chunksafe" then
        chunksafe = true
    elseif message == "relaychunk" then
        if chunksafe then
            rednet.broadcast("chunksaferelay")
        end
    elseif message == "relayproceed" then
        if proceed then
            rednet.broadcast("proceedrelay")
        end
    elseif message == "resetchunk" then
        chunksafe = false
    elseif message == "resetproceed" then
        proceed = false
    end
    sleep(0)
end