wget run https://github.com/Aharhour/Computercraft/blob/main/install.lua

local github_repository_url = "https://github.com/Aharhour/computercraft"

local function downloadFile(url, path)
    local response = http.get(url)
    if response and response.getResponseCode() == 200 then
        local content = response.readAll()
        local file = fs.open(path, "w")
        file.write(content)
        file.close()
        print("File " .. path .. " downloaded successfully.")
    else
        print("Failed to download " .. path)
    end
end

downloadFile(github_repository_url .. "chest_monitor.lua", "chest_monitor.lua")

local startupScript = [[
    os.run({}, "chest_monitor.lua")
]]
local startupFile = fs.open("startup.lua", "w")
startupFile.write(startupScript)
startupFile.close()

print("Installation completed successfully.")