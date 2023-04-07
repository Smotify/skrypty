local currentVersion = "1.0" -- tutaj wprowadź aktualną wersję twojego skryptu
local githubUrl = "https://github.com/Smotify/skrypty.git" -- tutaj wprowadź adres URL Twojego pliku skryptu na GitHubie

local function download(url, path)
    local content = http.get(url).readAll()
    local file = fs.open(path, "w")
    file.write(content)
    file.close()
end

local function getVersion(url)
    local content = http.get(url).readAll()
    local version = content:match('local currentVersion = "(.-)"')
    return version
end

local function install(url)
    download(url, "skrypt.lua")
    print("Pobrano nowszą wersję skryptu!")
end

local githubVersion = getVersion(githubUrl)

if currentVersion < githubVersion then
    install(githubUrl)
else
    print("Masz już najnowszą wersję skryptu!")
end
