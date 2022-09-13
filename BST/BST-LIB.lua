--[[===================================================================================================================
											Library side-car file for BST.lua

							IMPORTANT: DO NOT MODIFY THIS UNLESS YOU KNOW WHAT YOU ARE DOING
========================================================================================================================]]--


texts = require('texts')
res = require('resources')
require('queues')

include('BST-PETS.lua')

local Ready_Moves = T{}
local selected_jug_count = 0
local selected_reward_count = 0

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.english == 'Reward' then
		equip({ammo=state.RewardItem.value})
	end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.english == 'Call Beast' or spell.english == 'Bestial Loyalty' then
		equip({ammo=state.SelectedJug})
	elseif spell.type == 'WeaponSkill' and sroda_earring_weaponskills:contains(spell.english) and pet.isvalid then
		equip(gear.sroda_earring)
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)


end

-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)

end


-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)

end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)	
	
end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)
	
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
	
end

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, spellMap)
	
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if pet.isvalid then
		if pet.status == 'Engaged' then
			if state.DefenseMode.Value == 'None' then
				idleSet = set_combine(idleSet, sets.idle.Field.Pet.engaged)
			else
				idleSet = set_combine(idleSet, sets.idle.Field.Pet.engaged[state.ActiveDefenseMode.Value])
			end
		end
	end
	if state.LockMain.value ~= 'disabled' or player.equipment.main == '' then
		idleSet = set_combine(idleSet, {main=state.Main.value})
	end
	if (state.LockSub.value ~= 'disabled' or player.equipment.sub == '') and state.Dualwield.value > 0  then
		idleSet = set_combine(idleSet, {sub=state.Sub.value})
	end
	
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.LockMain.value ~= 'disabled' or player.equipment.main == '' then
		meleeSet = set_combine(meleeSet, {main=state.Main.value})
	end
	if (state.LockSub.value ~= 'disabled' or player.equipment.sub == '') and state.Dualwield.value > 0  then
		meleeSet = set_combine(meleeSet, {sub=state.Sub.value})
	end
	return meleeSet
end

function customize_defense_set(defenseSet)	
	if state.LockMain.value ~= 'disabled' or player.equipment.main == '' then
		defenseSet = set_combine(defenseSet, {main=state.Main.value})
	end
	if (state.LockSub.value ~= 'disabled' or player.equipment.sub == '') and state.Dualwield.value > 0  then
		defenseSet = set_combine(defenseSet, {sub=state.Sub.value})
	end
   return defenseSet
end
-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
	if newStatus == 'Engaged' then
        get_combat_form()
    end
	handle_equipping_gear(player.status)
end

function job_state_change(field, new_value, old_value)
	if field == 'Main-hand' then
		if new_value=='disabled' then
			disable('main')
		else
			enable('main')
		end
	elseif field == 'Off-hand' then
		if new_value=='disabled' then
			disable('sub')
		else
			enable('sub')
		end
	elseif field == 'Main-hand Mode' and state.Sub.value ~= 'None' then
		if state.Sub.value == new_value then
			send_command("gs c cycle Main")
		end
	elseif field == 'Off-hand Mode'  then
		if state.Dualwield.value > 0  then
			if state.Main.value == new_value then
				send_command("gs c cycle Sub")
			end
		--else
		 --send_command('gs c set Sub Empty')
		end
	elseif field == 'HUD' then
		hideTextSections()
	end
    get_combat_form()
    handle_equipping_gear(player.status)
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)	
	if buff:contains("Aftermath") or T{'haste', 'march', 'mighty guard', 'embrava', 'geo-haste', 'indi-haste', 'haste samba'}:contains(buff:lower()) then
		get_combat_form()
		if not midaction() then
			handle_equipping_gear(player.status)
		end		
	end
end

-- Called when the player's pet's status changes.
-- This is also called after pet_change after a pet is released.  Check for pet validity.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
    if pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
        handle_equipping_gear(player.status, newStatus)
    end
end

function job_pet_change(petparam, gain)
	setTextWindowInfo()
	get_ready_moves()
end

function buff_refresh(name,buff_details)
	
end

function job_update(cmdParams, eventArgs)
	--check_dual_wield()
	if is_trust_party() then
		state.Support:Set('Party')
	end
	get_ready_moves()
	get_combat_form()
end

function sup_job_change(new, old)
	check_dual_wield()
end

function check_dual_wield()
	if not buffactive[157] then
		if player.sub_job == 'NIN' then
			state.Dualwield:Set(25)
			state.CombatForm:Set('NIN')
		elseif player.sub_job == 'DNC' then
			state.Dualwield:Set(15)
			state.CombatForm:Set('DNC')
		end
		check_weapons()
	else
		state.Dualwield:Set(0)
		state.CombatForm:clear()
		state.Sub:Set('Empty')
	end
end

function check_weapons()
	if state.Main:contains(player.equipment.main) then 
		state.Main:Set(player.equipment.main)
	end
	if state.Sub:contains(player.equipment.sub) then 
		state.Sub:Set(player.equipment.sub)
	end
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell)
	if spell.type == "Monster" or spell.name == "Sic" then
		return 'Ready'
	elseif spell.type == nil then
		if Physical_ready_moves:contains(spell.english) then			
			if Multi_hit_ready_moves:contains(spell.english) then			
				return 'MultiHitReady'		
			elseif TP_based_ready_moves:contains(spell.english) then
				return 'TPBonusReady'		
			end			
			return 'PhysicalReady'		
		elseif Magic_atk_ready_moves:contains(spell.english) then			
			return 'MagicAtkReady'
		elseif Magic_acc_ready_moves:contains(spell.english) then
			return 'MagicAccReady'		
		elseif Pet_buff_moves:contains(spell.english) then
			return 'PetBuffReady'
		end
  end
end

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

end

function get_combat_form()	
	classes.CustomMeleeGroups:clear()	
	classes.CustomDefenseGroups:clear()
	classes.CustomIdleGroups:clear()
	
	check_haste()
	classes.CustomMeleeGroups:append(state.DWHaste.value)
	
	if state.DefenseMode.value ~= 'None' then	
		classes.CustomMeleeGroups:append(state.ActiveDefenseMode.value)
		classes.CustomIdleGroups:append(state.ActiveDefenseMode.value)
	end		
	
	if state.DefenseMode.value ~= 'DT' then
		get_aftermath()
	end
	
	
end


-- Job-specific toggles.
function job_toggle(field)

end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

	if is_trust_party() then
		state.Support:Set('Party')
	end
	local msg = 'Mode: '.. state.OffenseMode.value
	 
	if state.DefenseMode.value ~= 'None' then
		msg = msg .. ', Defense: ' .. state[state.DefenseMode.value .. 'DefenseMode'].value 		
	end
	
	msg = msg .. ', Main['.. state.LockMain.value ..']: ' .. state.Main.value 
	msg = msg .. ', Sub['.. state.LockSub.value ..']: ' .. state.Sub.value 

    add_to_chat(8, msg)

	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.Buff[buff_name] or {})
        eventArgs.handled = true
    end
end

function check_haste()
	if state.Dualwield.value ~= 0 then
		local haste_value = 0
		
		if buffactive[33] then
			haste_value = state.Haste.value
		end
		
		if state.Support == 'Solo' then --Assume trust buffs
			
			if buffactive[580] then haste_value = haste_value + 30 end --GEO Haste
			if buffactive[214]==1 then haste_value = haste_value + 15 end --Single March
			if buffactive[214]==2 then haste_value = haste_value + 25 end -- Double March
		
		else --Assume GOOD buffs
		
			if buffactive[214]==1 then haste_value = haste_value + 17 end --Single March
			if buffactive[214]==2 then 
				haste_value = haste_value + 45  --Double March (Don't bother calculating anything else)
			else
				if buffactive[580] then haste_value = haste_value + 30 end--GEO Haste
				if buffactive[228] then haste_value = haste_value + 30 end --Embrava
				if buffactive[604] then haste_value = haste_value + 15 end --Mighty Guard
			end
		end	
		
		if buffactive['Haste Samba'] then
			haste_value = haste_value + 5
		end
		
		if haste_value >= 40 and buffactive['Haste Samba'] then
			state.DWHaste:Set('MAX+Samba')
		elseif haste_value >= 40 then
			state.DWHaste:Set('MAX')
		elseif haste_value >= 30 then
			state.DWHaste:Set('30')
		elseif haste_value >= 25 then
			state.DWHaste:Set('25')
		elseif haste_value >= 15 then				
			state.DWHaste:Set('15')
		elseif haste_value >= 10 then	
			state.DWHaste:Set('10')
		else
			state.DWHaste:Set('NONE')
		end
	end
end

function get_aftermath()
	if buffactive[272] then
		classes.CustomMeleeGroups:append("AM3")
	end
end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book(page, book)
    set_macro_page(page, book)
end

windower.register_event('zone change',function(new, old)
 
  if handle_equipping_gear then handle_equipping_gear() end
 
end)

function map_ready_moves()

	Physical_ready_moves = S{
		'Foot Kick','Whirl Claws','Sheep Charge','Lamb Chop','Head Butt','Wild Oats',
		'Leaf Dagger','Claw Cyclone','Razor Fang','Crossthrash','Nimble Snap','Cyclotail','Rhino Attack',
		'Power Attack','Mandibular Bite','Big Scissors','Grapple','Spinning Top','Double Claw','Frogkick',
		'Blockhead','Brain Crush','Tail Blow','Scythe Tail','Ripper Fang','Chomp Rush','Needleshot',
		'Recoil Dive','Sudden Lunge','Spiral Spin','Wing Slap','Beak Lunge','Suction','Back Heel',
		'Fantod','Tortoise Stomp','Sensilla Blades','Tegmina Buffet','Pentapeck','Sweeping Gouge',
		'Somersault','Tickling Tendrils','Pecking Flurry','Sickle Slash','Disembowel','Extirpating Salvo',
		'Mega Scissors','Rhinowrecker','Hoof Volley','Fluid Toss','Fluid Spread'}

	Magic_atk_ready_moves = S{
		'Dust Cloud','Cursed Sphere','Venom','Toxic Spit','Bubble Shower','Drainkiss',
		'Silence Gas','Dark Spore','Fireball','Plague Breath','Snow Cloud','Charged Whisker','Corrosive Ooze',
		'Aqua Breath','Stink Bomb','Nectarous Deluge','Nepenthic Plunge','Pestilent Plume','Foul Waters',
		'Acid Spray','Infected Leech','Gloom Spray','Venom Shower'}

	Magic_acc_ready_moves = S{
		'Sheep Song','Scream','Dream Flower','Roar','Predatory Glare','Gloeosuccus',
		'Palsy Pollen','Soporific','Geist Wall','Toxic Spit','Numbing Noise','Spoil','Hi-Freq Field',
		'Sandpit','Sandblast','Venom Spray','Filamented Hold','Queasyshroom','Numbshroom','Spore','Shakeshroom',
		'Infrasonics','Chaotic Eye','Blaster','Purulent Ooze','Intimidate','Noisome Powder','Acid Mist',
		'Choke Breath','Jettatura','Nihility Song','Molting Plumage','Swooping Frenzy','Spider Web'}

	Multi_hit_ready_moves = S{
		'Pentapeck','Tickling Tendrils','Sweeping Gouge','Chomp Rush','Wing Slap', 'Pecking Flurry'}

	TP_based_ready_moves = S{
		'Foot Kick','Dust Cloud','Snow Cloud','Sheep Song','Sheep Charge','Lamb Chop',
		'Head Butt','Scream','Dream Flower','Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang','Roar',
		'Gloeosuccus','Palsy Pollen','Soporific','Cursed Sphere','Somersault','Geist Wall','Numbing Noise',
		'Frogkick','Nimble Snap','Cyclotail','Spoil','Rhino Attack','Hi-Freq Field','Sandpit','Sandblast',
		'Mandibular Bite','Metallic Body','Bubble Shower','Grapple','Spinning Top','Double Claw','Spore',
		'Filamented Hold','Blockhead','Fireball','Tail Blow','Plague Breath','Brain Crush','Infrasonics',
		'Needleshot','Chaotic Eye','Blaster','Ripper Fang','Intimidate','Recoil Dive','Water Wall',
		'Sudden Lunge','Noisome Powder','Wing Slap','Beak Lunge','Suction','Drainkiss','Acid Mist',
		'TP Drainkiss','Back Heel','Jettatura','Choke Breath','Fantod','Charged Whisker','Purulent Ooze',
		'Corrosive Ooze','Tortoise Stomp','Aqua Breath','Sensilla Blades','Tegmina Buffet','Sweeping Gouge',
		'Tickling Tendrils','Pecking Flurry','Pestilent Plume','Foul Waters','Spider Web','Gloom Spray',
		'Disembowel','Extirpating Salvo','Rhinowrecker','Venom Shower','Fluid Toss','Fluid Spread','Digest'}
		
	-- List of Pet Buffs and Ready moves exclusively modified by Pet TP Bonus gear.
	Pet_buff_moves = S{'Wild Carrot','Bubble Curtain','Scissor Guard','Secretion','Rage','Harden Shell',
		'TP Drainkiss','Fantod','Rhino Guard','Zealous Snort','Frenzied Rage','Digest'}
end



------------------------------------
------------Text Window-------------
------------------------------------
--define constants for coloring the text in the HUD
local const_text_header = '\\cs(255,253,219)'
local const_text_red = '\\cs(214, 101, 101)'
local const_text_green = '\\cs(101, 214, 127)'
local const_text_white = '\\cs(255, 255, 255)'
local const_text_blue = '\\cs(67, 154, 224)'
local const_text_yellow = '\\cs(255, 238, 0)'
local const_text_orange = '\\cs(247, 166, 2)'
local const_text_cyan = '\\cs(90, 232, 218)'
local const_text_gold = '\\cs(245, 232, 152)'

keybinds_on = {}
keybinds_off = {}
function fill_keybind_strings()
--[[
    This gets passed in when the Keybinds is turned on.
    Each one matches to a given variable within the text object
]]
	keybinds_on['keybind_master_mainhand'] = add_color('(F11)', const_text_blue)
	keybinds_on['keybind_master_offhand'] = add_color(' (F12)', const_text_blue)
	keybinds_on['keybind_support'] = add_color(' (CTRL+F9)', const_text_blue)
	keybinds_on['keybind_hastemode'] = add_color('(ALT+F9)', const_text_blue)
	keybinds_on['keybind_offense'] = add_color('(F9)', const_text_blue)
	keybinds_on['keybind_defense'] = add_color('(F10)', const_text_blue)
	keybinds_on['keybind_ready'] = add_color(' (WIN+1~7)', const_text_blue)

	keybinds_on['keybind_jug'] = add_color(' (Home)', const_text_blue)
	keybinds_on['keybind_reward'] = add_color(' (End)', const_text_blue)

	keybinds_on['pet_header'] = add_color('================== Pet =================', const_text_header)
	keybinds_on['pet_info_header']= add_color('============== Pet Settings ==============', const_text_header)

--[[
    This gets passed in when the Keybinds are turned off.
    For not it simply sets the variable to an empty string
    (Researching better way to handle this)
]]
	keybinds_off['keybind_master_mainhand'] = ''
	keybinds_off['keybind_master_offhand'] = ' '
	keybinds_off['keybind_support'] = ''
	keybinds_off['keybind_hastemode'] = ''
	keybinds_off['keybind_offense'] = ''
	keybinds_off['keybind_defense'] = ''
	keybinds_off['keybind_ready'] = ''

	keybinds_off['keybind_jug'] = ''
	keybinds_off['keybind_reward'] = ''

	keybinds_off['pet_header'] = add_color('============= Pet =============', const_text_header)
	keybinds_off['pet_info_header']= add_color('========== Pet Settings ==========', const_text_header)
end

--[[
    These below are used to fill in the different sections on the HUB window
    It places varibles within the text object we can access instead of redrawing
    the entire text window everytime

    Variables are placed within a ${variableName|DefaultValue|Format}
    Format can be nil.
    
    _std stands for standard version
]]


hub_master_info_std = 
[[\cs(255,253,219)========= Master (\cr${master_support_status|SOLO}${keybind_support}\cs(255,253,219)) =========\cr
- \cs(255,255,255)Mainhand\cr ${keybind_master_mainhand} \cs(255,255,255):\cr ${master_mainhand|Empty}
- \cs(255,255,255)Offhand\cr   ${keybind_master_offhand} \cs(255,255,255):\cr ${master_offhand|Empty} 

- \cs(255,255,255)Haste Mode\cr ${keybind_hastemode} \cs(255,255,255):\cr \cs(101, 214, 127)${master_hastemode|10}%\cr
- \cs(255,255,255)Dual Wield Set :\cr ${master_dw_set}

- \cs(255,255,255)Offense\cr ${keybind_offense}\cs(255,255,255):\cr ${master_offense_mode} \cs(255,255,255)| Defense\cr ${keybind_defense}\cs(255,255,255):\cr ${master_defense_mode}
  
]]

hub_pet_info_std = 
[[${pet_header}
- ${pet_name|NO PET}
- \cs(255,255,255)HP :\cr ${pet_current_hp|0}% \cs(255,253,219)|\cr \cs(255,255,255)TP :\cr ${pet_current_tp}

- \cs(255,255,255)Strong Against :\cr \cs(101, 214, 127)${pet_killer}\cr
- \cs(255,255,255)Weak Against :\cr \cs(214, 101, 101)${pet_weakness}\cr

- \cs(255,255,255)Ready Abilities (\cr${ready_charges}\cs(255,255,255))\cr${keybind_ready} \cs(255,255,255):\cr
${pet_ready_abilities_list}
]]

hub_pet_info_nopet = 
[[${pet_header}
- \cs(214, 101, 101)NO PET\cr
]]

hub_pet_settings = 
[[${pet_info_header}
- \cs(255,255,255)Jug\cr${keybind_jug} \cs(255,255,255):\cr ${pet_jug_selection|NONE} \cs(255,255,255)Count: \cr ${pet_jug_inventory}
- \cs(255,255,255)Jug Info :\cr ${pet_jug_name} (${pet_jug_family})
- \cs(255,255,255)Reward\cr${keybind_reward} \cs(255,255,255):\cr ${pet_reward_item} \cs(255,255,255)Count :\cr ${pet_reward_inventory|0}

 CTRL+PageUp display hotkeys
 CTRL+PageDn hide HUD]]

--Default To Set Up the Text Window
function setupTextWindow(pos_x, pos_y, text_size)
    if main_text_hub ~= nil then
        return
    end
	text_size = text_size or 12
    
    local default_settings = T{}
    default_settings.pos = {}
    default_settings.pos.x = pos_x
    default_settings.pos.y = pos_y
    default_settings.bg = {}
    default_settings.bg.alpha = 200
    default_settings.bg.red = 40
    default_settings.bg.green = 40
    default_settings.bg.blue = 55
    default_settings.bg.visible = true
    default_settings.flags = {}
    default_settings.flags.right = false
    default_settings.flags.bottom = false
    default_settings.flags.bold = true
    default_settings.flags.draggable = true
    default_settings.flags.italic = false
    default_settings.padding = 10
    default_settings.text = {}
    default_settings.text.size = text_size
    default_settings.text.font = 'Arial'
    default_settings.text.fonts = {}
    default_settings.text.alpha = 255
    default_settings.text.red = 147
    default_settings.text.green = 161
    default_settings.text.blue = 161
    default_settings.text.stroke = {}
    default_settings.text.stroke.width = 0
    default_settings.text.stroke.alpha = 255
    default_settings.text.stroke.red = 0
    default_settings.text.stroke.green = 0
    default_settings.text.stroke.blue = 0

    --Creates the initial Text Object will use to create the different sections in
    main_text_hub = texts.new('', default_settings)

    --Appends the different sections to the main_text_hub
	setTextWindowInfo()

    --We then do a quick validation
    validateTextInformation()
    --Finally we show this to the user
    main_text_hub:show()
    hideTextSections()
end

function setTextWindowInfo()

	texts.clear(main_text_hub)
	texts.append(main_text_hub, hub_master_info_std)
	
	if pet.isvalid then
		texts.append(main_text_hub, hub_pet_info_std)
	else
		texts.append(main_text_hub, hub_pet_info_nopet)	
	end
	
    texts.append(main_text_hub, hub_pet_settings)
end



--[[
    Used to validate that information in the HUB is up to date
]]
function validateTextInformation()

    --State Information
	main_text_hub.master_support_status = add_color(state.Support.current, const_text_green)
	
	if state.LockMain.current ~= 'enabled'then
		main_text_hub.master_mainhand = add_color(state.Main.current, const_text_red)
	else
		main_text_hub.master_mainhand = add_color(state.Main.current, const_text_green)
	end
	
	if state.LockSub.current ~= 'enabled'then
		main_text_hub.master_offhand = add_color(state.Sub.current, const_text_red)
	else
		main_text_hub.master_offhand = add_color(state.Sub.current, const_text_green)
	end
	
	main_text_hub.master_hastemode = state.Haste.current	

	if  state.DWHaste.current ~= 'NONE' then
		main_text_hub.master_dw_set = add_color(state.DWHaste.current, const_text_green)	
	else
		main_text_hub.master_dw_set = add_color(state.DWHaste.current, const_text_red)
	end
	
	main_text_hub.master_offense_mode = add_color(state.OffenseMode.current, const_text_gold)
	
	if state.DefenseMode.current == 'None' then
		main_text_hub.master_defense_mode = state.ActiveDefenseMode.current
	else
		main_text_hub.master_defense_mode = add_color(state.ActiveDefenseMode.current, const_text_green)
	end
	
	
	--Pet info
	-- Updates Pet Info and Pet Skills
	update_pet_info()
	
	--Job Pet Settings
	update_pet_settings_info()
	
	if state.ShowUIHotkeys.value then
        texts.update(main_text_hub, keybinds_on)
    else 
        texts.update(main_text_hub, keybinds_off)
    end
end

function get_ready_charges()	
	local charges = 3
	local ready = windower.ffxi.get_ability_recasts()[102]
	
	if ready ~= 0 then
	    charges = math.floor(((30 - ready) / 10))
	end
	return charges
end

function update_pet_info()

    --As long as we have a pet and player is not dead lets update
    if pet.isvalid and player.hpp > 0 then
        
		main_text_hub.pet_name = add_color(pet.name, const_text_gold)
		
		local hp = pet.hpp
		if hp > 75 then
			main_text_hub.pet_current_hp = add_color(pet.hpp, const_text_green)
		elseif hp > 50 then
			main_text_hub.pet_current_hp = add_color(pet.hpp, const_text_yellow)
		elseif hp > 25 then
			main_text_hub.pet_current_hp = add_color(pet.hpp, const_text_orange)
		else
			main_text_hub.pet_current_hp = add_color(pet.hpp, const_text_red)
		end 

        local current_pet_tp = pet.tp
        if current_pet_tp ~= nil then
			if current_pet_tp >= 1000 then
				main_text_hub.pet_current_tp = add_color(current_pet_tp, const_text_cyan)
			else
				main_text_hub.pet_current_tp = current_pet_tp
			end
        end
			
		
		if Pets[pet.name] then
			main_text_hub.pet_killer = Correlation[Pets[pet.name].Type].Strong
			main_text_hub.pet_weakness = Correlation[Pets[pet.name].Type].Weak		
		end
		
		local charges = get_ready_charges()
		if charges == 0 then
			main_text_hub.ready_charges = add_color(charges, const_text_red)
		else
			main_text_hub.ready_charges = add_color(charges, const_text_green)
		end
		update_ready_info(charges)
		
	else
		main_text_hub.pet_name = add_color('NO PET', const_text_red)
		main_text_hub.pet_current_hp = '--'

		main_text_hub.pet_killer = '--'
		main_text_hub.pet_weakness = '--'
    end

end

function update_pet_settings_info()
	if state.SelectedJug and state.SelectedJug ~= '' and state.SelectedJug ~= 'NONE' then
		
		main_text_hub.pet_jug_selection= add_color(state.SelectedJug, const_text_gold)
		
		if selected_jug_count == 1 then
			main_text_hub.pet_jug_inventory = add_color(selected_jug_count, const_text_orange)
		elseif selected_jug_count == 0 then
			main_text_hub.pet_jug_inventory = add_color(selected_jug_count, const_text_red)
		else
			main_text_hub.pet_jug_inventory = add_color(selected_jug_count, const_text_green)
		end
		
		if JugInfo[state.SelectedJug] then
			local pet_name = string.gsub(JugInfo[state.SelectedJug],"%s+", "")
			local pet_info = Pets[pet_name]
			--add_to_chat(155, pet_name)
			main_text_hub.pet_jug_name =  add_color(JugInfo[state.SelectedJug], const_text_gold)
			if pet_info then
				main_text_hub.pet_jug_family = add_color(pet_info['Family'],  const_text_gold)
			else
				main_text_hub.pet_jug_family = '???'				
			end
		else
			main_text_hub.pet_jug_name = 'UNKNOWN'			
			main_text_hub.pet_jug_family = '???'
		end
	else
		main_text_hub.pet_jug_selection= add_color('NONE', const_text_red)
	end
	
	main_text_hub.pet_reward_item = add_color(state.RewardItem.value, const_text_gold)
	
	--local reward_count = get_item_count(state.RewardItem.value:lower())
	if selected_reward_count == 1 then
		main_text_hub.pet_reward_inventory = add_color(selected_reward_count, const_text_orange)
	elseif selected_reward_count == 0 then
		main_text_hub.pet_reward_inventory = add_color(selected_reward_count, const_text_red)
	else
		main_text_hub.pet_reward_inventory = add_color(selected_reward_count, const_text_green)
	end
end

function update_ready_info(charges)
					
	--get ready moves
	if not charges then
		charges = 0
	end
	local _ready = ''
	for k,v in pairs(Ready_Moves) do
		local ready_charge = Pets[pet.name].Charges[k]
		if ready_charge > charges then
			_ready = _ready .. k ..') '..v..'  ('..ready_charge..')\n'
		else
			_ready = _ready .. k ..') '..add_color(v..'  ('..ready_charge..')\n', const_text_white)			
		end
	end		
	main_text_hub.pet_ready_abilities_list = _ready
	
end

function get_ready_moves()	
	Ready_Moves = T{}
	local index = 1
	for k,v in pairs(windower.ffxi.get_abilities().job_abilities) do
		local ja = res.job_abilities[v]
		if ja.type == 'Monster' then
			table.insert(Ready_Moves, index, ja.english)
			index = index + 1
		end
	end
end
--[[
    This handles hiding the different sections
]]
function hideTextSections()

    if state.ShowUI.value ~= true then
        texts.hide(main_text_hub)
    else 
        texts.show(main_text_hub)
    end
	
end

function add_color(in_str, const_color)
	in_str = in_str or 'Null'
	return const_color..in_str..'\\cr'	
end

local fps = 0
windower.register_event("prerender",function()
	
	validateTextInformation()            
	
	--check inventory once every second.
	if fps >= 30 then
		get_jugs()
		check_item_counts()
		fps = 0
	else
		fps = fps + 1
	end	
	
end)


function check_item_counts()
	if state.SelectedJug and state.selected_jug ~= '' or state.selected_jug ~= '' then
		selected_jug_count = get_item_count(state.SelectedJug)
	end
	
	if state.RewardItem then
		selected_reward_count = get_item_count(state.RewardItem.value)
	end
end

--Update what jugs are in our inventory
function get_jugs()

	local temp_jugs = T(state.JugsInInventory['data'])
	for k,_ in pairs(Jugs) do
	
		--don't add our selected jug to the queue, we'll have to check if it exists before adding it back in
		if not state.SelectedJug or state.SelectedJug ~= k then
			local str = string.lower(k)		
			
			--does the inventory have the jug?
			if player.inventory[str] then
				--does the queue already have the jug in it?
				if not temp_jugs:contains(k) then
					state.JugsInInventory:push(k)
				end
			end
			if player.wardrobe[str] then
				if not temp_jugs:contains(k) then
					state.JugsInInventory:push(k)
				end
			end
			if player.wardrobe2[str] then
				if not temp_jugs:contains(k) then
					state.JugsInInventory:push(k)
				end
			end
			if player.wardrobe3[str] then
				if not temp_jugs:contains(k) then
					state.JugsInInventory:push(k)
				end
			end
			if player.wardrobe4[str] then
				if not temp_jugs:contains(k) then
					state.JugsInInventory:push(k)
				end
			end
			if player.wardrobe5[str] then
				if not temp_jugs:contains(k) then
					state.JugsInInventory:push(k)
				end
			end
			if player.wardrobe6[str] then
				if not temp_jugs:contains(k) then
					state.JugsInInventory:push(k)
				end
			end
			if player.wardrobe7[str] then
				if not temp_jugs:contains(k) then
					state.JugsInInventory:push(k)
				end
			end
			if player.wardrobe8[str] then
				if not temp_jugs:contains(k) then
					state.JugsInInventory:push(k)
				end
			end
		end
	end
	
	--Sanitize queue
	local i = 1
	for k,v in pairs(state.JugsInInventory['data']) do
		local str = string.lower(v)		
		if not player.inventory[v] and
		   not player.wardrobe[v] and
		   not player.wardrobe2[v] and
		   not player.wardrobe3[v] and
		   not player.wardrobe4[v] and
		   not player.wardrobe5[v] and
		   not player.wardrobe6[v] and
		   not player.wardrobe7[v] and
		   not player.wardrobe8[v] then
		
			--Queue contains a value that is no longer in inventory
			state.JugsInInventory:remove(i)
		end
		i = i + 1
	end

	local selected_jug = state.SelectedJug
	
	--set the selected jug, if it hasn't already been set
	if (not selected_jug or (selected_jug == '' or selected_jug == 'NONE')) then
		if state.JugsInInventory['data']:length() > 0 then		
			if pet.isvalid then
				local pet_jug = Pets[pet.name].Jug				
				if state.JugsInInventory['data']:contains(pet_jug) then					
					local index = indexOf(state.JugsInInventory['data'], pet_jug)
					if index then
						state.SelectedJug = pet_jug
						state.JugsInInventory:remove(index)
					else
						state.SelectedJug = state.JugsInInventory:pop()
					end
				else
					state.SelectedJug = state.JugsInInventory:pop()			
				end		
				
			else
				state.SelectedJug = state.JugsInInventory:pop()
			end
		end
	end
end

function job_self_command(command, eventArgs)
	if command[1]:lower() == 'selectjug' then
		if state.JugsInInventory:length() > 0 then
			if state.SelectedJug ~= '' or state.SelectedJug ~= 'NONE' then
				if get_item_count(state.SelectedJug) > 0 then
					state.JugsInInventory:push(state.SelectedJug)
				end
				state.SelectedJug = state.JugsInInventory:pop()
			else
				state.SelectedJug = state.JugsInInventory:pop()
			end
		else
			add_to_chat(155, 'NO JUGS IN INVENTORY')
		end
	end
end

--Get the current # of any given item from your EQUIPABLE INVENTORY
function get_item_count(item)
	local return_val = 0

	if player.inventory[item] then
		return_val = return_val + player.inventory[item].count 
	end
	if player.wardrobe[item] then
		return_val = return_val + player.wardrobe[item].count 
	end
	if player.wardrobe2[item] then
		return_val = return_val + player.wardrobe2[item].count 
	end
	if player.wardrobe3[item] then
		return_val = return_val + player.wardrobe3[item].count 
	end
	if player.wardrobe4[item] then
		return_val = return_val + player.wardrobe4[item].count 
	end
	if player.wardrobe5[item] then
		return_val = return_val + player.wardrobe5[item].count 
	end
	if player.wardrobe6[item] then
		return_val = return_val + player.wardrobe6[item].count 
	end
	if player.wardrobe7[item] then
		return_val = return_val + player.wardrobe7[item].count 
	end
	if player.wardrobe8[item] then
		return_val = return_val + player.wardrobe8[item].count 
	end
	return return_val
end

-- Returns true if you're in a party solely comprised of Trust NPCs.
-- TODO: Do we need a check to see if we're in a party partly comprised of Trust NPCs?
function is_trust_party()
    -- Check if we're solo
    if party.count == 1 then
        return false
    end
	
    -- If we're in an alliance, can't be a Trust party.
    if alliance[2].count > 0 or alliance[3].count > 0 then
        return false
    end
    
    -- Check that, for each party position aside from our own, the party
    -- member has one of the Trust NPC names, and that those party members
    -- are flagged is_npc.
    for i = 2,6 do
        if party[i] then
            if not npcs.Trust:contains(party[i].name) then
                return false
            end
            if party[i].mob and party[i].mob.is_npc == false then
                return false
            end
        end
    end
    
    -- If it didn't fail any of the above checks, return true.
    return true
end

function indexOf(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end
--check_dual_wield()
fill_keybind_strings()