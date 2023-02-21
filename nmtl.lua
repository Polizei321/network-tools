-- Auto Updater from https://github.com/hexarobi/stand-lua-auto-updater
local status, auto_updater = pcall(require, "auto-updater")
if not status then
    local auto_update_complete = nil util.toast("Installing auto-updater...", TOAST_ALL)
    async_http.init("raw.githubusercontent.com", "/hexarobi/stand-lua-auto-updater/main/auto-updater.lua",
        function(result, headers, status_code)
            local function parse_auto_update_result(result, headers, status_code)
                local error_prefix = "Error downloading auto-updater: "
                if status_code ~= 200 then util.toast(error_prefix..status_code, TOAST_ALL) return false end
                if not result or result == "" then util.toast(error_prefix.."Found empty file.", TOAST_ALL) return false end
                filesystem.mkdir(filesystem.scripts_dir() .. "lib")
                local file = io.open(filesystem.scripts_dir() .. "lib\\auto-updater.lua", "wb")
                if file == nil then util.toast(error_prefix.."Could not open file for writing.", TOAST_ALL) return false end
                file:write(result) file:close() util.toast("Successfully installed auto-updater lib", TOAST_ALL) return true
            end
            auto_update_complete = parse_auto_update_result(result, headers, status_code)
        end, function() util.toast("Error downloading auto-updater lib. Update failed to download.", TOAST_ALL) end)
    async_http.dispatch() local i = 1 while (auto_update_complete == nil and i < 40) do util.yield(250) i = i + 1 end
    if auto_update_complete == nil then error("Error downloading auto-updater lib. HTTP Request timeout") end
    auto_updater = require("auto-updater")
end
if auto_updater == true then error("Invalid auto-updater lib. Please delete your Stand/Lua Scripts/lib/auto-updater.lua and try again") end
auto_updater.run_auto_update({
    check_interval= 1,
    source_url="https://raw.githubusercontent.com/Polizei321/network-tools/main/nmtl.lua",
    script_relpath=SCRIPT_RELPATH,
    verify_file_begins_with="--"
})
menu.action(menu.my_root(), "Return to the Network Menu", {}, "Sends you back to the main menu.", function()
    menu.trigger_commands("luanetworkmenu")
end, true)
util.toast("[LEVEL] Starting Network Menu if it isnt already loaded.")
local function on_player_join(player_id)
    local player_name = players.get_name(player_id)
    local player_rank = players.get_rank(player_id)

    util.toast(player_name .. " joined with level " .. player_rank)
    util.log(player_name .. " joined with level " .. player_rank)
end
util.toast("Plugin Loaded.")
