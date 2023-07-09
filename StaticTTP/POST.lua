rednet.open("top")
 
local chest = peripheral.wrap("minecraft:chest_3")
local chest2 = peripheral.wrap("minecraft:chest_4")
 
function set(name)
    for slot, item in pairs(chest.list()) do -- loop through chest
        if item.name == name then
            chest.pushItems(peripheral.getName(chest2), slot, 1)
        end
    end
end
 
function reset(name)
    for slot, item in pairs(chest2.list()) do -- loop through chest
        if item.name == name then
            chest2.pushItems(peripheral.getName(chest), slot, 1)
        end
    end
end
 
reset("minecraft:diamond")
reset("minecraft:gold_ingot")

while true do
    id, message, protocol = rednet.receive("POST")
    if message == "proceed" then
        set("minecraft:gold_ingot")
    elseif message == "chunksafe" then
        set("minecraft:diamond")
    elseif message == "resetchunk" then
        reset("minecraft:diamond")
    elseif message == "resetproceed" then
        reset("minecraft:gold_ingot")
    end
    sleep(0)
end