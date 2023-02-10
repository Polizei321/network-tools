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
    source_url="https://github.com/Polizei123/network-tools-lua",
    script_relpath=SCRIPT_RELPATH,
    verify_file_begins_with="--"
})
util.keep_running()util.toast("Welcome to the Network Menu.")util.log("Welcome to the Network Menu.")menu.toggle_loop(menu.my_root(),"Remote Ban",{"remoteban"},"Will send continuous remote kicks, this causes a soft ban for your target leaving them unable to stay in a public lobby.",function(a)menu.trigger_command(menu.ref_by_path("Online>Player History>Qf830869 [Public]>Blind-Fire Kick>Breakup"))end,true)menu.action(menu.my_root(),"Remote Ban Test",{"remotebantest"},"Will send a single remote kick. (Use this to attempt a successful connection)",function()menu.trigger_command(menu.ref_by_path("Online>Player History>Qf830869 [Public]>Blind-Fire Kick>Breakup"))util.log("[NETWORK TOOLS] Sending a manual remote kick.")util.toast("[NETWORK TOOLS] Sending a manual remote kick.")end,true)menu.action(menu.my_root(),"Lock Server Down",{"lockserver"},"Will lock the session you are in making it impossible for adversaries to join. (Use this to block retalitory kicks / block any stalkers from joining.)",function()menu.trigger_command(menu.ref_by_path("Online>Session>Block Joins>From Non-Whitelisted"))menu.trigger_command(menu.ref_by_path("Online>Spoofing>Session Spoofing>Hide Session>Non-Existent Session"))menu.trigger_command(menu.ref_by_path("Online>Session>Set Session Type>Closed Friend"))menu.trigger_command(menu.ref_by_path("Online>Spoofing>Session Spoofing>Session Type>Invalid"))menu.trigger_commands("spoofhost on")menu.trigger_commands("spoofedhostname invalid")util.yield(1000)util.toast("[NETWORK TOOLS] Successfully locked the server.")util.log("[NETWORK TOOLS] Server has been locked.")end,true)menu.action(menu.my_root(),"Unlock Server",{"unlockserver"},"Will unlock the server.",function()menu.trigger_command(menu.ref_by_path("Online>Session>Block Joins>From Non-Whitelisted"))menu.trigger_command(menu.ref_by_path("Online>Spoofing>Session Spoofing>Hide Session>Disabled"))menu.trigger_command(menu.ref_by_path("Online>Session>Set Session Type>Public"))menu.trigger_command(menu.ref_by_path("Online>Spoofing>Session Spoofing>Session Type>Not Spoofed"))menu.trigger_commands("spoofhost off")util.yield(1000)util.toast("[NETWORK TOOLS] Successfully unlocked the server.")util.log("[NETWORK TOOLS] Server has been unlocked.")end,true)menu.action(menu.my_root(),"Break Lobby",{"breaklobby"},"Will cause the lobby to remain in a permanent broken state. (This cannot be undone, only use this if you have a good reason)",function()menu.trigger_command(menu.ref_by_path("Online>Session>Session Scripts>Run Scrips>Session Breaking>GTA Online Intro"))menu.trigger_command(menu.ref_by_path("Online>Session>Session Scripts>Run Script>Session Breaking>fm_mission_controller"))menu.trigger_command(menu.ref_by_path("Online>Session>Session Scripts>Run Script>Session Breaking>golf_mp"))menu.trigger_command(menu.ref_by_path("Online>Session>Session Scripts>Run Script>Session Breaking>FM_Survival_Controller"))menu.trigger_command(menu.ref_by_path("Online>Session>Session Scripts>Run Script>Session Breaking>fm_deathmatch_controler"))menu.trigger_command(menu.ref_by_path("Online>Session>Session Scripts>Run Script>Session Breaking>tennis_network_mp"))menu.trigger_command(menu.ref_by_path("Online>Session>Session Scripts>Run Script>Session Breaking>Range_Modern_MP"))menu.trigger_command(menu.ref_by_path("Online>Session>Session Scripts>Run Script>Session Breaking>FM_Race_Controler"))util.toast("[NETWORK TOOLS] Session Breaking executed successfully.")util.log("[NETWORK TOOLS] Session Breaking executed successfully.")end,true)menu.action(menu.my_root(),"Panic Button",{"pb"},"Will activate Panic Mode. (Use this to discard all network traffic to and from you, and protect against bad objects / excessive objects from being spawned.)",function()util.toast("Panic Button Pressed!")util.log("Panic Button Was Pressed!")menu.trigger_commands("clearproximity 100")menu.trigger_commands("lualancescriptreloaded")util.yield(100)menu.trigger_commands("supercleanse")menu.trigger_commands("noblame")menu.trigger_commands("anticrash")menu.trigger_commands("cleararea")menu.trigger_commands("desyncall")menu.trigger_commands("norender")menu.trigger_commands("infopeds")menu.trigger_commands("infovehicles")menu.trigger_commands("infopickups")menu.trigger_commands("infoobjects")menu.trigger_commands("blockjoins")menu.trigger_commands("luaAAAnewlua")util.log("Panic Button Ran Successfully.")util.toast("[NETWORK TOOLS] Sending a manual remote kick.")end,true)