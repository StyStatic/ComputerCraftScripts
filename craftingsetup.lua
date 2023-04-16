-- Autocrafting by StyStatic

checkspassed = 0
checksneeded = 4

-- Define items and count
table = {}
function resetTable()
    table["minecraft:diamond"] = 5 -- 4 for Diamond Alloy, 1 for Refined Obsidian
    table["minecraft:iron_ingot"] = 16 -- Magic Number
    table["minecraft:obsidian"] = 2 -- 2 makes 8 dust makes 8 refined which makes 16 atomic
    table["minecraft:redstone"] = 2 -- 2 makes 160 redstone infusion makes 16 redstone alloy
end

-- Craft Function
function AttemptCraft()
    local chest = peripheral.wrap("minecraft:chest_0")
    local chest2 = peripheral.wrap("minecraft:chest_1")

    for slot, item in pairs(chest.list()) do -- loop through chest
        if table[item.name] ~= nil then -- Make sure item is on list
            if item.count >= table[item.name] then -- compare count to amount required
                table[item.name] = -1
                checkspassed = checkspassed+1
            end
        end
    end

    if checkspassed == checksneeded then
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