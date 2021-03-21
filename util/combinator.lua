local function add_hud_combinator_ref(hud_combinator)
	global.hud_combinators[hud_combinator.unit_number] = {
		["entity"] = hud_combinator,
		["name"] = "HUD Combinator #" .. hud_combinator.unit_number,
		["filters"] = {},
		["unit_number"] = hud_combinator.unit_number
	}
end

local function remove_hud_combinator_ref(unit_number)
	global.hud_combinators[unit_number] = nil
end

function get_hud_combinator(unit_number)
	local hud_combinator = global.hud_combinators[unit_number]
	if hud_combinator then
		return hud_combinator["entity"]
	end
	return nil
end

function get_hud_combinator_name(unit_number)
	local hud_combinator = global.hud_combinators[unit_number]
	if hud_combinator then
		return hud_combinator["name"]
	end
	return nil
end

function set_hud_combinator_name(unit_number, name)
	local hud_combinator = global.hud_combinators[unit_number]
	if hud_combinator then
		hud_combinator["name"] = name
	end
end

function set_hud_combinator_filter(unit_number, index, filter_signal)
	local hud_combinator = global.hud_combinators[unit_number]
	if hud_combinator then
		hud_combinator["filters"][index] = filter_signal
	end
end

-- Check if this HUD Combinator has any signals coming in to show in the HUD.
-- @param entity The HUD Combinator
function has_network_signals(entity)
	local red_network = entity.get_circuit_network(defines.wire_type.red)
	local green_network = entity.get_circuit_network(defines.wire_type.green)

	if not (red_network == nil or red_network.signals == nil) then
		return true
	end

	if not (green_network == nil or green_network.signals == nil) then
		return true
	end

	return false
end

-- Checks if the signal coming into our HUD-Combinator contains our custom "Hide HUD Combinator Signal" and should therefore not show.
-- Will return true if this network should show  and false if the "Hide HUD Combinator Signal" is found.
-- @param entity The HUD Combinator
function should_show_network(entity)
	-- Get both the red and green circuit networks
	local red_network = entity.get_circuit_network(defines.wire_type.red)
	local green_network = entity.get_circuit_network(defines.wire_type.green)

	if red_network and red_network.signals then
		for _, signal in pairs(red_network.signals) do
			if signal.signal.name == "signal-hide-hud-comparator" then
				return false
			end
		end
	end

	if green_network and green_network.signals then
		for _, signal in pairs(green_network.signals) do
			if signal.signal.name == "signal-hide-hud-comparator" then
				return false
			end
		end
	end

	-- No "Hide HUD Combinator Signal" found
	return true
end

function check_combinator_registrations()
	-- clean the map for invalid entities
	for key, meta_entity in pairs(global.hud_combinators) do
		if (not meta_entity.entity) or (not meta_entity.entity.valid) then
			remove_hud_combinator_ref(key)
		end
	end

	-- find entities not discovered
	for i, surface in pairs(game.surfaces) do
		-- find all hud combinator
		local hud_combinators = surface.find_entities_filtered {name = HUD_COMBINATOR_NAME}

		if hud_combinators then
			for _, hud_combinator in pairs(hud_combinators) do
				if not global.hud_combinators[hud_combinator.unit_number] then
					add_hud_combinator_ref(hud_combinator)
				end
			end
		end
	end
end

function register_combinator(entity)
	add_hud_combinator_ref(entity)

	for k, player in pairs(game.players) do
		-- Uncollapse the HUD when a new combinator is registered
		if get_uncollapse_hud_on_register_combinator_setting(player.index) then
			update_collapse_state(player.index, false)
		end
	end
end

function unregister_combinator(entity)
	remove_hud_combinator_ref(entity.unit_number)
end
