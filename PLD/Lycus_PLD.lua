-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.

res = require('resources')
spells = res.spells:type('BlueMagic')

function get_sets()
    mote_include_version = 2
	-- Load and initialize the include file.
	include('Mote-Include.lua')	
	set_bindings()
end
-- Setup vars that are user-independent.
function job_setup()	
	-- Table of entries

	state.Buff = {}
	state.Buff.Doom = buffactive.doom or false	
	state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
	
	state.Buff.Crusade = buffactive[289] or false	
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'Acc')
	--state.AccuracyMode = M{['description'] = 'Accuracy Mode', 'Normal', 'Acc'}
	
	state.Shield = M{['description']='Shield Mode', 'Aegis', 'Ochain', 'Srivatsa', 'Blurred Shield +1'}
	state.Weapon = M{['description']='Weapon Mode', 'Burtgang', 'Excalibur', 'Naegling'}
	
	state.LockShield = M{['description']='Shield','enabled', 'disabled'}
	state.LockWeapon = M{['description']='Weapon', 'disabled', 'enabled'}
	
	state.DefenseMode:options('None', 'Active')
	state.ActiveDefenseMode = M{['description'] = 'Damage Taken Mode', 'PDT', 'MDT', 'Shield', 'Reraise'}		
	
	--enable('main', 'sub')
	
	select_default_macro_book()	
	get_combat_form()
	check_majesty()
	--disable('main')
	
	set_spells()
	
end
--For some reason setting the bindings in the user_setup wasn't working when gearswap first loads.
function set_bindings()
	send_command('bind Home gs c update user')
	send_command('bind f9 gs c reset DefenseMode')
	send_command('bind !f9 gs c cycle OffenseMode')
	send_command('unbind ^f9')	
	send_command('unbind @f9')
	
	send_command('bind f10 gs c set DefenseMode Active')
	send_command('bind ^f10 gs c cycle ActiveDefenseMode')
	send_command('unbind !f10')
	
	send_command('bind f12 gs c cycle Shield')
	send_command('bind ^f12 gs c cycle LockShield')
	send_command('bind !f12 gs c toggle Kiting')
	
	send_command('bind f11 gs c cycle Weapon')
	send_command('bind ^f11 gs c cycle LockWeapon')
end
-- Called when this job file is unloaded (eg: job change)
function file_unload()
	send_command('unbind Home')
	send_command('unbind f9')
	send_command('unbind !f9')
	send_command('unbind ^f9')
	send_command('unbind f10')
	send_command('unbind ^f10')
	send_command('unbind !f10')
	send_command('unbind f11')
	send_command('unbind ^f11')
	send_command('unbind !f11')
	send_command('unbind f12')
	send_command('unbind ^f12')
	send_command('unbind !f12')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- -- Start defining the sets
	--------------------------------------	
	
	Capes = {}
	Capes.Engaged = {name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken -10%'}}
	Capes.WSD = {name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	Capes.FC = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Spell interruption rate down-10%',}}
	
	
	sets.SIR = {ammo="Staunch Tathlum",
				head="Souveran Schaller +1",neck="Moonlight Necklace",ear2="Knightly Earring",
				hands="Regal Gauntlets",
				back=Capes.FC,legs="Founder's Hose"}

    
	sets.Enmity = {ammo="Iron Gobbet",
        head="Loess Barbuta +1",neck="Moonlight Necklace",ear2="Friomisi Earring",ear1="Trux Earring",
        body="Souveran Cuirass +1",hands="Caballarius Gauntlets +3",ring1="Apeile Ring",ring2="Supershear Ring",
        back="Weard Mantle",waist="Goading Belt",legs="Souveran Diechlings +1",feet="Chevalier's Sabatons"}
	--------------------------------------
    -- Precast sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
	
    sets.precast.JA['Invincible'] = {legs="Caballarius Breeches +3"}
    sets.precast.JA['Holy Circle'] = {feet="Reverence Leggings +3"}
    sets.precast.JA['Shield Bash'] = {hands="Caballarius Gauntlets +3"}
    sets.precast.JA['Sentinel'] = {feet="Caballarius Leggings +3"}
    sets.precast.JA['Rampart'] = {head="Caballarius Coronet +3"}
    sets.precast.JA['Fealty'] = {body="Caballarius Surcoat +3"}
    sets.precast.JA['Divine Emblem'] = {feet="Chevalier's Sabatons"}
    sets.precast.JA['Cover'] = {head="Reverence Coronet +2"}

	sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	
	sets.Buff = {}
	sets.Buff['Doom'] = {legs="Shatbi Cuisses",ring1="Blenmot's Ring",ring2="Saida Ring",waist="Gishdubar Sash"}	
	sets.Buff['Cover'] = {body="Caballarius Surcoat +3"}	
	
    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
        head="Reverence Coronet +2",ear1="Pensee Earring",
        body="Reverence Surcoat +3",hands="Caballarius Gauntlets +3",ring1="Karka Ring",ring2="Aquasoul Ring",
        back="Weard Mantle",waist="Pythia Sash +1",legs="Reverence Breeches",feet="Sulevia's Leggings +2"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Incantor Stone",
        head="Carmine Mask +1",
		neck="Voltsurge Torque",
		body="Reverence Surcoat +3",		
		hands="Leyline Gloves",
		ear1="Odnowa earring +1",
		ear2="Loquacious Earring",
		ring2="Prolix Ring",
		ring1="Kishar Ring",
		legs="Enif Cosciales",
		feet='Carmine Greaves +1',
		back=Capes.FC}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {body="Jumalik Mail"})
 
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Aurgelmir Orb +1",
        head="Nyame Helm",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Ishvara Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Epaminondas's Ring",ring2="Karieyh Ring",
        back=Capes.WSD,waist="Fotia Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    sets.precast.WS.Acc = {ammo="Aurgelmir Orb +1",
        head="Nyame Helm",neck="Fotia Gorget",ear1="Telos Earring",ear2="Ishvara Earring",
        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Epaminondas's Ring",ring2="Kariyeh Ring",
        back=Capes.WSD,waist="Fotia Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {head="Sakpata's Helm", body="Sakpata's Breastplate", hands="Sakpata's Gauntlets", legs="Sakpata's Cuisses", ring1="Epiamondas's Ring", ring2="Regal Ring"})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {ring1="Ifrit Ring",ring2="Rufescent Ring"})
	
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {head="Nyame Helm", body="Nyame Mail", hands='Nyame Gauntlets',lear='Moonshade Earring',rear="Thrud Earring", lring="Epaminondas's Ring", rring='Regal Ring', waist="Sailfi Belt +1",legs="Nyame Flanchard", })

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
	head="Flamma Zucchetto +2",
	body="Hjarrandi Breastplate",
	hands='Flamma Manopolas +2',
	ring1="Begrudging Ring",
	ring2="Regal Ring",back=Capes.Engaged,legs='Lustratio Subligar +1',})

    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS,{neck="Sactity Necklace", lear="Novio Earring", rear="Friomisi Earring", rring="Acumen Ring", waist="Orpheus's Sash"})
    
    sets.precast.WS['Atonement'] = set_combine(sets.precast.WS,sets.Enmity)
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {    
		ammo="Incantor Stone",
		head="Carmine Mask +1",
		body="Reverence Surcoat +3",
		hands="Leyline Gloves",
		legs="Enif Cosciales",
		feet="Carmine Greaves +1",
		waist="Tempus Fugit",
		left_ear="Etiolation earring",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Prolix Ring",
		back=Capes.FC}
    
	


    sets.midcast.Flash = set_combine(sets.midcast.FastRecast, sets.Enmity)
    
    --sets.midcast.Stun = sets.midcast.Flash
    
    sets.midcast.Cure = {
        head="Souveran Schaller +1",neck="Colossus's Torque",ear1="Nourishing Earring",ear2="Nourishing Earring +1",
        body="Jumalik mail",hands="Eschite Gauntlets",ring1="Sirona's Ring",ring2="Kunaji Ring",
        back=Capes.FC,waist="Asklepian Belt",legs="Founder's Hose",feet="Carmine Greaves +1"}

    sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast,sets.SIR,{body="Shabti Cuirass +1",hands="Regal Gauntlets"})
	
    sets.midcast.Phalanx = set_combine(sets.midcast.FastRecast,sets.midcast['Enhancing Magic'],{head="Yorium Barbuta", body="Yorium Cuirass", hands="Souveran Handschuhs +1", back="Weard Mantle", legs="Sakpata's Cuisses", feet="Souveran Schuhs +1"})
	
    sets.midcast['Divine Magic'] = {
	head="Jumalik Helm",neck="Henic Torque",body="Reverence Surcoat +3",hands="Eschite Gauntlets",
	feet="Templar Sabatons",ring1="Stikini Ring +1",ring2="Stikini Ring",ear1="Novio Earring",ear2="Friomisi Earring", waist="Asklepian Belt"}
	
	sets.midcast['Blue Magic'] =  set_combine(sets.Enmity,sets.SIR)
	
    sets.midcast.Holy = set_combine(sets.midcast['Divine Magic'], {body="Terminal Plate",
	head="Jumalik Helm",hands="Leyline Gloves"})
    
	sets.midcast['Reprisal'] = set_combine(sets.midcast.FastRecast,sets.SIR,{body="Shabti Cuirass +1",hands="Regal Gauntlets"})
	
    sets.midcast.Protect = set_combine(sets.midcast.FastRecast,sets.SIR,{body="Shabti Cuirass +1",hands="Regal Gauntlets",ring1="Sheltered Ring"})
    sets.midcast.Shell = set_combine(sets.midcast.FastRecast,sets.SIR,{body="Shabti Cuirass +1",hands="Regal Gauntlets",ring1="Sheltered Ring"})
    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
	
	-- -- Sets to return to when not performing an action.
	
	-- -- Resting sets
	sets.resting = {  }		
	
	
	--Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {ammo="Homiliary",
		head="Hjarrandi Helm",neck="Knight's Bead Necklace +1",ear1="Ethereal Earring",ear2="Odnowa earring +1",
		body="Hjarrandi Breastplate",hands="Regal Gauntlets",ring1="Moonbeam Ring",ring2="Moonbeam Ring",
		back="Moonbeam Cape",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Reverence Leggings +3"}

	sets.idle.Town = {ammo="Homiliary",
		head="Loess Barbuta +1",neck="Knight's Bead Necklace +1",ear1="Ethereal Earring",ear2="Telos earring",
		body="Councilor's Garb",hands="Sulevia's Gauntlets +2",ring1="Shadow Ring",ring2="Defending Ring",
		back="Moonbeam Cape",waist="Nierenschutz",legs="Carmine Cuisses +1",feet="Volte Sollerets"}
		
	sets.idle.Weak = {    
		ammo="Staunch Tathlum",
		head="Twilight Helm",
		body="Twilight Mail",
		hands="Sulev. Gauntlets +2",
		legs="Carmine Cuisses +1",
		feet="Sulev. Leggings +2",
		neck="Knight's Bead Necklace +1",
		waist="Flume Belt",
		left_ear="Etiolation Earring",
		right_ear="Odnowa earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Defending Ring",
		back="Moonbeam Cape",}

	sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)	
		
	sets.idle.Field = set_combine(sets.idle, { })	
	sets.idle.Field.PDT = {ammo="Staunch Tathlum",
		head="Chevalier's Armet +2",
		body="Sakpata's Breastplate",
		hands="Regal Gauntlets",
		legs="Volte Brayettes",
		feet="Rev. Leggings +3",
		neck="Kgt. Beads +1",
		waist="Flume Belt",
		left_ear="Ethereal Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back=Capes.Engaged}	
	sets.idle.Field.MDT = set_combine(sets.idle.Field,{ })
	sets.idle.Field.Shield = set_combine(sets.idle.Field,{ })
	sets.idle.Field.Reraise = set_combine(sets.idle.Field.PDT, sets.Reraise)
	
	
	sets.Kiting = {legs="Carmine Cuisses +1"}
	
	-- -- Defense sets 
	-- -- In Gearswap defense sets are equipped no matter the situation, which I don't personally like - therefore I have retooled the functionality to differentiate between engaged and idle
	sets.defense = { }		

	-- -- Engaged sets

	-- -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- -- sets if more refined versions aren't defined.
	-- -- If you create a set with both offense and defense modes, the offense mode should be first.
	-- -- EG: sets.engaged.Dagger.Accuracy.Evasion
	
    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
	sets.engaged = {   
		ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",
		body="Sakpata's Breastplate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Flam. Gambieras +2",
		neck="Combatant's Torque",
		waist="Sailfi Belt +1",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Petrov Ring",
		right_ring="Flamma Ring",
		back=Capes.Engaged}

    sets.engaged.Acc = {    
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body="Hjarrandi Breastplate",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Flam. Gambieras +2",
		neck="Combatant's Torque",
		waist="Tempus Fugit",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring",
		right_ring="Flamma Ring",				
		back=Capes.Engaged}
		
	sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)
	
	-- --Physical Defense
	sets.engaged.PDT = set_combine(sets.engaged, {body="Hjarrandi Breastplate", neck="Knight's Bead Necklace +1",ring1="Defending Ring",ring2="Moonbeam Ring"})
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {body="Souveran Cuirass +1",neck="Twilight Torque",back="Weard Mantle",ring1="Defending Ring",ring2="Vocane Ring"})
	
	sets.engaged.Shield = {}
	
	-- --Magical Defense
	sets.engaged.MDT = { }
	sets.engaged.Acc.MDT = {}
	 
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if (spell.english:contains('Cure') or spell.english:contains('Protect')) and not buffactive['Majesty'] then
		cast_delay(1)
		check_majesty()	
	end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)

end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	-- if spell.skill == 'Enhancing Magic' then
		-- if sets[spell.en] and (buffactive.Aquaveil or player.in_combat == false) then
			-- equip(sets[spell.en])
			-- eventArgs.handled = true			
		-- end
	-- end
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
	if state.Buff.Cover then
        idleSet = set_combine(idleSet, sets.Buff['Cover'])
    end
	if state.Buff.Doom then
       idleSet = set_combine(idleSet, sets.Buff['Doom'])
    end
	
	if state.LockWeapon.value ~= 'disabled' or player.equipment.main == '' then
		idleSet = set_combine(idleSet, {main=state.Weapon.value})
	end
	if state.LockShield.value ~= 'disabled' or player.equipment.sub == '' then
		idleSet = set_combine(idleSet, {sub=state.Shield.value})
	end
	
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)

	if state.Buff.Cover then
        meleeSet = set_combine(meleeSet, sets.Buff['Cover'])
    end
	
	if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.Buff['Doom'])
    end    
	
	if state.LockWeapon.value ~= 'disabled' or player.equipment.main == '' then
		meleeSet = set_combine(meleeSet, {main=state.Weapon.value})
	end
	if state.LockShield.value ~= 'disabled' or player.equipment.sub == '' then
		meleeSet = set_combine(meleeSet, {sub=state.Shield.value})
	end
	return meleeSet
end

function customize_defense_set(defenseSet)

	if state.Buff.Cover then
        defenseSet = set_combine(defenseSet, sets.Buff['Cover'])
    end
	
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.Buff['Doom'])
    end
	
	if state.LockWeapon.value ~= 'disabled' or player.equipment.main == '' then
		defenseSet = set_combine(defenseSet, {main=state.Weapon.value})
	end
	if state.LockShield.value ~= 'disabled' or player.equipment.sub == '' then
		defenseSet = set_combine(defenseSet, {sub=state.Shield.value})
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
		display_current_job_state(eventArgs)
    end
	handle_equipping_gear(player.status)
	check_majesty()
end

function job_state_change(field, new_value, old_value)
	-- if field == 'Weapon' then
		-- if new_value=='disabled' then
			-- disable('main')
		-- else
			-- enable('main')
		-- end
	-- elseif field == 'Shield' then
		-- if new_value=='disabled' then
			-- disable('sub')
		-- else
			-- enable('sub')
		-- end
	-- end
    get_combat_form()
    handle_equipping_gear(player.status)
    check_majesty()
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff == 'Enmity Boost' then
		if gain then
			send_command('timers create "Crusade" 384 down')
		else
			send_command('timers delete "Crusade"')			
			add_to_chat(8, 'Crusade Lost!')
		end		
	elseif buff == 'Phalanx' then
		if gain then
			send_command('timers create "Phalanx" 180 down')
		else
			send_command('timers delete "Phalanx"')			
			add_to_chat(8, 'Phalanx Lost!')
		end
	elseif buff == 'Majesty' and not gain then
		check_majesty()
	end	
	handle_equipping_gear(player.status)
end

function buff_refresh(name,buff_details)
	if name == 'Enmity Boost' then
		send_command('timers create "Crusade" 384 down')
	elseif name == 'Phalanx' then
		send_command('timers create "Phalanx" 180 down')
	elseif name == 'Reprisal' then
		send_command('timers create "Reprisal" 60 down')		
	end		
end

function job_update(cmdParams, eventArgs)
	get_combat_form()
	check_majesty()
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
end

function get_combat_form()	
	classes.CustomMeleeGroups:clear()	
	classes.CustomDefenseGroups:clear()
	classes.CustomIdleGroups:clear()
	
	if state.DefenseMode.value ~= 'None' then	
		classes.CustomMeleeGroups:append(state.ActiveDefenseMode.value)
		classes.CustomIdleGroups:append(state.ActiveDefenseMode.value)	
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
	local msg = 'Mode: '.. state.OffenseMode.value
    --msg = msg .. ', Acc: ' .. state.AccuracyMode.value		
	if state.DefenseMode.value ~= 'None' then
		msg = msg .. ', Defense: ' .. state[state.DefenseMode.value .. 'DefenseMode'].value 		
	end
	
	msg = msg .. ', Weapon['.. state.LockWeapon.value ..']: ' .. state.Weapon.value 
	msg = msg .. ', Shield['.. state.LockShield.value ..']: ' .. state.Shield.value 
	
	msg = msg .. ', Majesty: ' .. (buffactive['Majesty'] and 'ON' or 'OFF')
	
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end
	
    add_to_chat(8, msg)

    eventArgs.handled = true
end

--Change to Majesty
function check_majesty()
	--local recasts = windower.ffxi.get_spell_recasts()	
	if not buffactive['Majesty'] and not areas.Cities:contains(world.area) then
		if not midaction() and not (buffactive[566] or buffactive[16] or buffactive[0] or buffactive[28] or buffactive[10] or buffactive[14] or buffactive[17] or buffactive[69] or buffactive[354])then
			send_command("input /ja Majesty <me>")
		end
	end
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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 4)
end

windower.register_event('zone change',function(new, old)
 
  handle_equipping_gear()
 
end)

--Functionality to automatically set Blue magic spells

function set_spells()

	local spellset = T{slot01='Jettatura', slot02='Sound Blast', slot03='Geist Wall',
	slot04='Refueling', slot05='Sheep Song', slot06='Blank Gaze', slot07='Stinking Gas',
	slot08='Cocoon', slot09='Head Butt', slot10='Metallic Body'}
	
    if windower.ffxi.get_player()['sub_job_id'] ~= 16 then        
        return
    end
	
	--------------------------MASTER LEVEL SPELLS BELOW--------------------------
	
	if windower.ffxi.get_player()['sub_job_level'] >= 50 then
		spellset['slot11']='Frightful Roar'
		if windower.ffxi.get_player()['sub_job_level'] >= 52 then
			spellset['slot12']='Filamented Hold'
		end
	end
   
   -------------------------------------------------------------------------------
   
    if is_spellset_equipped(spellset) then
        return
    end
	
    remove_all_spells()
    set_spells_from_spellset:schedule(1, spellset, 'add')
end

function remove_all_spells(trigger)
    windower.ffxi.reset_blue_magic_spells()
end

function is_spellset_equipped(spellset)
   return S(spellset):map(string.lower) == S(get_current_spellset())
end


function get_current_spellset()
    return T(windower.ffxi.get_sjob_data().spells)
    -- Returns all values but 512
    :filter(function(id) return id ~= 512 end)
    -- Transforms them from IDs to lowercase English names
    :map(function(id) return spells[id].english:lower() end)
    -- Transform the keys from numeric x or xx to string 'slot0x' or 'slotxx'
    :key_map(function(slot) return 'slot%02u':format(slot) end)
end

function set_spells_from_spellset(spellset, setPhase)
    local setToSet = spellset
    local currentSet = get_current_spellset()

    if setPhase == 'remove' then
        -- Remove Phase
        for k,v in pairs(currentSet) do
            if not setToSet:contains(v:lower()) then
                setSlot = k
                local slotToRemove = tonumber(k:sub(5, k:len()))

                windower.ffxi.remove_blue_magic_spell(slotToRemove)
                set_spells_from_spellset:schedule(1, spellset, 'remove')
                return
            end
        end
    end
    -- Did not find spell to remove. Start set phase
    -- Find empty slot:
    local slotToSetTo
    for i = 1, 20 do
        local slotName = 'slot%02u':format(i)
        if currentSet[slotName] == nil then
            slotToSetTo = i
            break
        end
    end

    if slotToSetTo ~= nil then
        -- We found an empty slot. Find a spell to set.
        for k,v in pairs(setToSet) do
            if not currentSet:contains(v:lower()) then
                if v ~= nil then
                    local spellID = find_spell_id_by_name(v)
                    if spellID ~= nil then
                        windower.ffxi.set_blue_magic_spell(spellID, tonumber(slotToSetTo))
                        --log('Set spell: '..v..' ('..spellID..') at: '..slotToSetTo)
                        set_spells_from_spellset:schedule(1, spellset, 'add')
                        return
                    end
                end
            end
        end
    end

    -- Unable to find any spells to set. Must be complete.
    --log(spellset..' has been equipped.')
    windower.send_command('@timers c "Blue Magic Cooldown" 60 up')
end

function find_spell_id_by_name(spellname)
    for spell in spells:it() do
        if spell['english']:lower() == spellname:lower() then
            return spell['id']
        end
    end
    return nil
end