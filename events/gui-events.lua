local Event = require("__stdlib__/stdlib/event/event")
local flib_gui = require("__flib__.gui-beta")
local std_string = require("__stdlib__/stdlib/utils/string")

local const = require("lib.constants")
local player_settings = require("globals.player-settings")
local player_data = require("globals.player-data")

local function gui_update(event)
	-- Check if the event is meant for us
	local action = flib_gui.read_action(event)
	if not action then
		return
	end

	if event.define_name == "on_gui_text_changed" and event.text ~= nil then
		action["value"] = event.text
	elseif event.define_name == "on_gui_elem_changed" and event.element.elem_value ~= nil then
		action["value"] = event.element.elem_value
	elseif event.define_name == "on_gui_value_changed" and event.element.slider_value ~= nil then
		action["value"] = event.element.slider_value
	elseif event.define_name == "on_gui_switch_state_changed" and event.element.switch_state ~= nil then
		-- Right/On is true, Left/Off is false
		action["value"] = event.element.switch_state == "right"
	end

	if action.gui == const.GUI_TYPES.combinator then
		handle_combinator_gui_events(event.player_index, action)
	end

	if action.gui == const.GUI_TYPES.hud then
		handle_hud_gui_events(event.player_index, action)
	end

	if action.gui == const.GUI_TYPES.settings then
		handle_settings_gui_events(event.player_index, action)
	end
end

--#region GUI interaction

Event.register(defines.events.on_gui_click, gui_update)
Event.register(defines.events.on_gui_text_changed, gui_update)
Event.register(defines.events.on_gui_elem_changed, gui_update)
Event.register(defines.events.on_gui_value_changed, gui_update)
Event.register(defines.events.on_gui_switch_state_changed, gui_update)

--#endregion

Event.register(
	defines.events.on_gui_location_changed,
	function(event)
		if event.element.name == const.HUD_NAMES.hud_root_frame then
			-- save the coordinates if the hud is draggable
			if player_settings.get_hud_position_setting(event.player_index) == "draggable" then
				player_data.set_hud_location(event.player_index, event.element.location)
			end
		end
	end
)

--#region On GUI Opened

Event.register(
	defines.events.on_gui_opened,
	function(event)
		if (not (event.entity == nil)) and (event.entity.name == const.HUD_COMBINATOR_NAME) then
			-- create the HUD Combinator Gui
			create_combinator_gui(event.player_index, event.entity.unit_number)
		end
	end
)

Event.register(
	defines.events.on_gui_closed,
	function(event)
		-- check if it's and HUD Combinator GUI and close that
		if (not (event.element == nil)) and std_string.starts_with(event.element.name, const.HUD_NAMES.combinator_root_frame) then
			-- create the HUD Combinator Gui
			destroy_combinator_gui(event.player_index, event.element.name)
		end
	end
)

--#endregion