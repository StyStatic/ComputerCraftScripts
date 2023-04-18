-- Autocrafting by StyStatic

checkspassed = 0
checksneeded = 1 -- Set number of ingredients here

-- Define items and count
table = {}
function resetTable()
    table["minecraft:diamond"] = 5 -- Example ingredient
end

-- Craft Function
function AttemptCraft()
    local chest = peripheral.wrap("minecraft:chest_0") -- Works with any container that .list works on
    local chest2 = peripheral.wrap("minecraft:chest_1")

    for slot, item in pairs(chest.list()) do -- loop through chest
        if table[item.name] ~= nil then -- Make sure item is on list
            if item.count >= table[item.name] then -- compare count to amount required
                table[item.name] = -1
                checkspassed = checkspassed+1
            end
        end
    end

    if checkspassed >= checksneeded then
        resetTable()
        for slot, item in pairs(chest.list()) do -- loop through chest
            if table[item.name] ~= nil then -- Make sure item is on list
                if item.count >= table[item.name] then -- compare count to amount required
                    chest.pushItems(peripheral.getName(chest2), slot, table[item.name])
                    table[item.name] = -1
                    checkspassed = checkspassed+1
                end
            end
        end
    else
        print("Invalid Ingredients")
    end
end

resetTable()
AttemptCraft()