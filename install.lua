-- Definiujemy adres URL do pliku z numerem najnowszej wersji na GitHubie
local latest_version_url = "https://raw.githubusercontent.com/Smotify/Arka_eventy/main/version.txt"

-- Definiujemy funkcję pobierającą numer najnowszej wersji z pliku tekstowego na GitHubie
function get_latest_version()
    local latest_version = nil
    -- Pobieramy plik z numerem najnowszej wersji
    local response = http.get(latest_version_url)
    if response then
        latest_version = response.readAll()
        response.close()
    end
    return latest_version
end

-- Definiujemy funkcję pobierającą numer aktualnie zainstalowanej wersji
function get_installed_version()
    return "1.0" -- Tutaj należy wpisać kod pobierający numer aktualnie zainstalowanej wersji
end

-- Definiujemy funkcję instalującą nowszą wersję modułu
function install_latest_version()
    -- Pobieramy plik z nowszą wersją modułu z GitHuba
    local response = http.get("https://raw.githubusercontent.com/Smotify/Arka_eventy/main/Arka_eventy.lua")
    if response then
        local contents = response.readAll()
        response.close()
        -- Zapisujemy nowszą wersję modułu
        local file = io.open("Arka_eventy.lua", "w")
        if file then
            file:write(contents)
            file:close()
            print("Zainstalowano nowszą wersję modułu.")
        end
    end
end

-- Pobieramy numer najnowszej wersji i numer aktualnie zainstalowanej wersji
local latest_version = get_latest_version()
local installed_version = get_installed_version()

-- Porównujemy numery wersji i instalujemy nowszą wersję, jeśli jest dostępna
if latest_version and latest_version > installed_version then
    print("Dostępna jest nowsza wersja modułu. Aktualna wersja: " .. installed_version .. ", najnowsza wersja: " .. latest_version)
    install_latest_version()
else
    print("Aktualnie zainstalowana wersja modułu jest aktualna.")
end
