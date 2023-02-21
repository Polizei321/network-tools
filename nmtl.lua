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