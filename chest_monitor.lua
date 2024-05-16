    function centerText(monitor, text, line)
    local width, _ = monitor.getSize()
    local textLength = string.len(text)
    local x = math.floor((width - textLength) / 2)
    monitor.setCursorPos(x, line)
    monitor.write(text)
end

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

    local _, height = monitor.getSize()
    local centerY = math.floor(height / 2)

    local line = centerY - math.floor(table.getn(items) / 2)
    for name, count in pairs(items) do
        local itemName = string.gsub(name, "minecraft:", "")
        centerText(monitor, count .. "x " .. itemName, line)
        line = line + 1
        monitor.setTextColor(colors.gray)
        centerText(monitor, tostring(count), line)
        monitor.setTextColor(colors.white)
        line = line + 1
    end
end

while true do
    local monitor = peripheral.find("monitor")
    local chest = peripheral.find("chest")

    if monitor and chest then
        print_inventory_on_monitor(chest, monitor)
    else
        print("Monitor or chest not found!")
    end

    sleep(10)
end
