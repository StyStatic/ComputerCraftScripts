rednet.open("top")
 
local chest = peripheral.wrap("minecraft:chest_3")
local chest2 = peripheral.wrap("minecraft:chest_4")
 
function checkfor(name, message, protocol)
    for slot, item in pairs(chest2.list()) do -- loop through chest
        if item.name == name then
            rednet.broadcast(message, protocol)
        end
    end
end

while true do
    id, message, protocol = rednet.receive()
    if message == "relaychunk" then
        checkfor("minecraft:diamond","chunksaferelay", "SENDMINER")
    elseif message == "relayproceed" then
        checkfor("minecraft:gold_ingot","proceedrelay", "SENDCHUNK")
    end
end