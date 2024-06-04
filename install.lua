local github_repository_url = "https://github.com/Aharhour/computercraft"

local file1 = "chest_monitor.lua"
local file2 = "link_naar_je_github_repository.md"
local file3 = "README.md"

local function downloadFile(url, path)
    local response = http.get(url)
    if response and response.getResponseCode() == 200 then
        local content = response.readAll()
        local file = fs.open(path, "w")
        file.write(content)
        file.close()
        print("- " .. path)
    else
        print("x " .. path)
    end
end

local download = textutils.unserialiseJSON(http.get(mpm_repository_url .. "download.json").readAll())

for _, file in ipairs(download) do
    downloadFile(github_repository_url .. file, "/computercraft/" .. file)
    if file == "instal.lua" then
        fs.move("/computercraft/instal.lua", "/" .. file)
    end
end

local startupScript = [[
    os.run({}, "chest_monitor.lua")
]]
local startupFile = fs.open("startup.lua", "w")
startupFile.write(startupScript)
startupFile.close()

print("Installation completed successfully.")