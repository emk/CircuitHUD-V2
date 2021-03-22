local const = {}

const.SHORT_PREFIX = "chv2_"
const.HUD_COMBINATOR_NAME = "hud-combinator"
const.HIDE_SIGNAL_NAME = "signal-hide-hud-comparator"

const.HUD_NAMES = {
	hud_root_frame = const.SHORT_PREFIX .. "hud_root_frame",
	hud_header_flow = const.SHORT_PREFIX .. "hud_header_flow",
	hud_scroll_pane = const.SHORT_PREFIX .. "hud_scroll_pane",
	hud_scroll_pane_frame = const.SHORT_PREFIX .. "hud_scroll_pane_frame",
	hud_toggle_button = const.SHORT_PREFIX .. "hud_toggle_button",
	hud_settings_button = const.SHORT_PREFIX .. "hud_settings_button",
	hud_title_label = const.SHORT_PREFIX .. "hud_title_label",
	hud_header_spacer = const.SHORT_PREFIX .. "hud_header_spacer",
	hud_search_text_field = const.SHORT_PREFIX .. "hud_search_textfield",
	hud_search_button = const.SHORT_PREFIX .. "hud_search_button",
	combinator_root_frame = const.SHORT_PREFIX .. "combinator_root_frame",
	combinator_name_textfield = const.SHORT_PREFIX .. "combinator_name_textfield",
	settings_root_frame = const.SHORT_PREFIX .. "settings_root_frame",
	settings_hud_columns_slider = const.SHORT_PREFIX .. "settings_hud_columns_slider",
	settings_hud_columns_value = const.SHORT_PREFIX .. "settings_hud_columns_value",
	settings_hud_max_height_slider = const.SHORT_PREFIX .. "settings_hud_max_height_slider",
	settings_hud_max_height_value = const.SHORT_PREFIX .. "settings_hud_max_height_value",
	settings_hud_refresh_rate_slider = const.SHORT_PREFIX .. "settings_hud_refresh_rate_slider",
	settings_hud_refresh_rate_value = const.SHORT_PREFIX .. "settings_hud_refresh_rate_value"
}

const.GUI_TYPES = {
	combinator = "COMBINATOR_GUI",
	hud = "HUD_GUI",
	settings = "SETTINGS_GUI"
}

const.SETTINGS = {
	prefix = "CircuitHUD_",
	hide_hud_header = "hide_hud_header",
	hud_title = "hud_title",
	hud_position = "hud_position",
	hud_columns = "hud_columns",
	hud_refresh_rate = "hud_refresh_rate",
	hud_max_height = "hud_max_height",
	hud_sort = "hud_sort",
	uncollapse_hud_on_register_combinator = "uncollapse_hud_on_register_combinator",
	debug_mode = "debug_mode"
}

const.HUD_POSITION_INDEX = {
	[1] = "top",
	[2] = "left",
	[3] = "goal",
	[4] = "bottom-right",
	[5] = "draggable"
}

const.HUD_POSITION = {
	top = const.HUD_POSITION_INDEX[1],
	left = const.HUD_POSITION_INDEX[2],
	goal = const.HUD_POSITION_INDEX[3],
	bottom_right = const.HUD_POSITION_INDEX[4],
	draggable = const.HUD_POSITION_INDEX[5]
}

const.HUD_SORT_INDEX = {
	[1] = "none",
	[2] = "ascending",
	[3] = "descending",
	[4] = "build-order-ascending",
	[5] = "build-order-descending"
}

const.HUD_SORT = {
	none = const.HUD_SORT_INDEX[1],
	ascending = const.HUD_SORT_INDEX[2],
	descending = const.HUD_SORT_INDEX[3],
	build_order_ascending = const.HUD_SORT_INDEX[4],
	build_order_descending = const.HUD_SORT_INDEX[5]
}

const.SIGNAL_TYPE_MAP = {
	["item"] = "item",
	["virtual"] = "virtual-signal",
	["fluid"] = "fluid"
}

const.GUI_ACTIONS = {
	toggle = "TOGGLE",
	toggle_search_bar = "TOGGLE_SEARCH_BAR",
	close = "CLOSE",
	name_change = "NAME_CHANGED",
	search_bar_change = "SEARCH_BAR_CHANGED",
	open_combinator = "OPEN_COMBINATOR",
	open_settings = "OPEN_SETTINGS",
	update_settings = "UPDATE_SETTING",
	go_to_combinator = "GO_TO_COMBINATOR",
	filter_signal_update = "FILTER_SIGNAL_UPDATE",
	switch_filter_state = "SWITCH_FILTER_STATE",
	name_change_confirm = "NAME_CHANGE_CONFIRM"
}

const.STYLES = {
	settings_title_label = const.SHORT_PREFIX .. "settings_title_label",
	settings_slider = const.SHORT_PREFIX .. "settings_slider_style"
}

const.EVENTS = {
	gui_hud_create = const.SHORT_PREFIX .. "gui_hud_create",
	gui_hud_toggle = const.SHORT_PREFIX .. "gui_hud_toggle",
	gui_hud_collapse_switch = const.SHORT_PREFIX .. "gui_hud_collapse_switch",
	gui_hud_reset_all_players = const.SHORT_PREFIX .. "gui_hud_reset_all_players",
	gui_combinator_create = const.SHORT_PREFIX .. "gui_combinator_create",
	gui_settings_open = const.SHORT_PREFIX .. "gui_settings_open",
	gui_settings_create = const.SHORT_PREFIX .. "gui_settings_create"
}

return const
