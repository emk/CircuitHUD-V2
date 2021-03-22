local flib_gui = require("__flib__.gui-beta")

local const = require("lib.constants")
local common = require("lib.common")
local player_settings = require("globals.player-settings")
local player_data = require("globals.player-data")

local function get_settings_root_frame(player_index)
	return player_data.get_hud_ref(player_index, const.HUD_NAMES.settings_root_frame)
end

function create_settings_gui(player_index)
	if get_settings_root_frame(player_index) then
		return
	end
	local player = common.get_player(player_index)

	local refs =
		flib_gui.build(
		player.gui.screen,
		{
			{
				type = "frame",
				style_mods = {
					minimal_width = 500,
					maximal_width = 500
				},
				ref = {
					const.HUD_NAMES.settings_root_frame
				},
				direction = "vertical",
				children = {
					-- Titlebar
					{
						type = "flow",
						ref = {"titlebar_flow"},
						style = "flib_titlebar_flow",
						children = {
							{
								-- add the title label
								type = "label",
								style = "frame_title",
								caption = "Settings",
								ignored_by_interaction = true
							},
							{
								-- add a pusher (so the close button becomes right-aligned)
								type = "empty-widget",
								style = "flib_titlebar_drag_handle",
								ignored_by_interaction = true
							},
							{
								type = "sprite-button",
								style = "frame_action_button",
								sprite = "utility/close_white",
								actions = {
									on_click = {
										gui = const.GUI_TYPES.settings,
										action = const.GUI_ACTIONS.close
									}
								}
							}
						}
					},
					{
						type = "frame",
						style = "ch_settings_category_frame",
						direction = "vertical",
						children = {
							{
								type = "flow",
								style = "flib_titlebar_flow",
								children = {
									{
										type = "label",
										style = const.STYLES.settings_title_label,
										caption = {"chv2_settings_gui.hud_settings"},
										tooltip = {"chv2_settings_gui_tooltips.hud_settings"}
									},
									{
										type = "checkbox",
										state = player_settings.get_hide_hud_header_setting(player_index),
										actions = {
											on_click = {
												gui = const.GUI_TYPES.settings,
												action = const.GUI_ACTIONS.update_settings,
												name = const.SETTINGS.hide_hud_header
											}
										}
									}
								}
							},
							-- HUD Position setting
							{
								type = "flow",
								style = "flib_titlebar_flow",
								children = {
									{
										-- add the title label
										type = "label",
										style = const.STYLES.settings_title_label,
										caption = {"chv2_settings_name.hud_position"},
										ignored_by_interaction = true
									},
									{
										type = "drop-down",
										selected_index = 4,
										items = {
											{"chv2_settings_gui_dropdown.hud_position-top"},
											{"chv2_settings_gui_dropdown.hud_position-left"},
											{"chv2_settings_gui_dropdown.hud_position-goal"},
											{"chv2_settings_gui_dropdown.hud_position-bottom-right"},
											{"chv2_settings_gui_dropdown.hud_position-draggable"}
										},
										actions = {
											on_selection_state_changed = {
												gui = const.GUI_TYPES.settings,
												action = const.GUI_ACTIONS.update_settings,
												name = const.SETTINGS.hud_position
											}
										}
									}
								}
							},
							-- HUD Position setting
							{
								type = "flow",
								style = "flib_titlebar_flow",
								children = {
									{
										-- add the title label
										type = "label",
										style = const.STYLES.settings_title_label,
										caption = {"chv2_settings_name.hud_columns"},
										ignored_by_interaction = true
									},
									{
										type = "flow",
										style = "flib_titlebar_flow",
										style_mods = {
											top_margin = 8
										},
										children = {
											{
												type = "slider",
												style = const.STYLES.settings_slider,
												style_mods = {
													horizontally_stretchable = true,
													right_padding = 10
												},
												ref = {const.HUD_NAMES.settings_hud_columns_slider},
												value = player_settings.get_hud_columns_setting(player_index),
												minimum_value = 4,
												maximum_value = 30,
												actions = {
													on_value_changed = {
														gui = const.GUI_TYPES.settings,
														action = const.GUI_ACTIONS.update_settings,
														name = const.SETTINGS.hud_columns
													}
												}
											}
										}
									},
									{
										type = "label",
										caption = tostring(player_settings.get_hud_columns_setting(player_index)),
										style = const.STYLES.settings_title_label,
										ref = {const.HUD_NAMES.settings_hud_columns_value}
									}
								}
							}
						}
					}
				}
			}
		}
	)

	local root_frame = refs[const.HUD_NAMES.settings_root_frame]
	refs.titlebar_flow.drag_target = root_frame

	player_data.set_hud_element_ref(player_index, const.HUD_NAMES.settings_hud_columns_slider, refs[const.HUD_NAMES.settings_hud_columns_slider])
	player_data.set_hud_element_ref(player_index, const.HUD_NAMES.settings_hud_columns_value, refs[const.HUD_NAMES.settings_hud_columns_value])

	player_data.set_hud_element_ref(player_index, const.HUD_NAMES.settings_root_frame, root_frame)
	-- We need to overwrite the "to be opened GUI" with our own GUI
	player.opened = root_frame
	player.opened.force_auto_center()
end

function handle_settings_gui_events(player_index, action)
	local value = action["value"]
	-- Setting update
	if action.action == const.GUI_ACTIONS.update_settings then
		-- Hide HUD Setting
		if action.name == const.SETTINGS.hide_hud_header then
			local value = not player_settings.get_hide_hud_header_setting(player_index)
			player_settings.set_hide_hud_header_setting(player_index, value)
		end

		-- HUD Columns Setting
		if action.name == const.SETTINGS.hud_columns then
			player_settings.set_hud_columns_setting(player_index, value)
			local value_ref = player_data.get_hud_ref(player_index, const.HUD_NAMES.settings_hud_columns_value)
			value_ref.caption = tostring(value)
		end
	end

	if action.action == const.GUI_ACTIONS.close then
		destroy_settings_gui(player_index)
		return
	end
end

function destroy_settings_gui(player_index)
	local root_frame = get_settings_root_frame(player_index)
	if root_frame then
		root_frame.destroy()
		player_data.destroy_hud_ref(player_index, const.HUD_NAMES.settings_root_frame)
	end
end