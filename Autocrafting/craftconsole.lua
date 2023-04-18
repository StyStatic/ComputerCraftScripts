function craftLogic()
    term.setCursorPos(1,1)
    term.clear()
    io.write("What do you want to craft?\n\n")
    io.write("1. Atomic Alloy\n")
    io.write("2. Reinforced Alloy\n")
    io.write("3. Infused Alloy\n")
    io.write("4. Control Circuit\n")
    io.write("5. Steel\n")
 
    craftNumber = tonumber(io.read())
 
    if craftNumber == 1 then
        shell.run("atomic")
    elseif craftNumber == 2 then
        shell.run("reinforced")
    elseif craftNumber == 3 then
        shell.run("infused")
    elseif craftNumber == 4 then
        shell.run("control")
    elseif craftNumber == 5 then
        shell.run("steel")
    else 
        print("Index: " .. craftNumber .. " is Invalid, Please try again")
        sleep(3)
    end
end
 
while true do
    craftLogic()
end
