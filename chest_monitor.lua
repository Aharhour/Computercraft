function print_inventory_on_monitor(chest, monitor)
    local inventory = chest.list()
    local items = {}

    for _, slot in pairs(inventory) do
        if slot.name then
            if items[slot.name] then
                items[slot.name] = items[slot.name] + slot.count
            else
                items[slot.name] = slot.count
            end
        end
    end

    monitor.clear()

    local width, height = monitor.getSize()

    local startY = math.floor((height - #items * 2) / 2)

    local currentY = startY
    for name, count in pairs(items) do
        local itemName = string.gsub(name, "minecraft:", "")
        local startX = math.floor((width - #itemName) / 2)
        monitor.setCursorPos(startX, currentY)
        monitor.write(itemName)

        startX = math.floor((width - string.len(count .. "x")) / 2)
        monitor.setTextColor(colors.gray)
        monitor.setCursorPos(startX, currentY + 1)
        monitor.write(count .. "x")
        monitor.setTextColor(colors.white)

        currentY = currentY + 2
    end
end

while true do
    local monitor = peripheral.find("monitor")
    local chest = peripheral.find("chest")

    print_inventory_on_monitor(chest, monitor)

    sleep(10)
end