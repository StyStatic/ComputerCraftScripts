infuser1 = peripheral.wrap("metallurgicInfuser_1")
infuser2 = peripheral.wrap("metallurgicInfuser_2")
 
while true do
    if infuser1.getInfuseType().amount ~= 0 then -- Prevent ingredients from entering machines if we are out of infusion material
        rs.setOutput("right", true)
    else
        rs.setOutput("right", false)
    end
    if infuser2.getInfuseType().amount ~= 0 then
        rs.setOutput("left", true)
    else
        rs.setOutput("left", false)
    end

    if infuser1.getInfuseType().amount ~= 0 or infuser2.getInfuseType().amount ~= 0 then -- Send redstone signal to qio importer to allow resources to import
        rs.setOutput("back", false)
    else
        rs.setOutput("back", true)
    end
end