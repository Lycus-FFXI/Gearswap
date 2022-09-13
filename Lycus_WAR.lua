-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	-- Load and initialize the include file.
	include('Mote-Include.lua')	
end

-- Setup vars that are user-independent.
function job_setup()	
	state.Buff = {}	
	state.Twilight = M(false, 'Twilight')
end

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
		
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Max', 'Acc') --No buffs, Max Attack, Acc/Atk Starved
	state.AutoOffenseMode = M(true, 'Auto')
	
	state.WeaponskillMode:options('Normal', 'Max', 'Acc') 
    state.DefenseMode:options('None', 'Active')
	state.ActiveDefenseMode = M{['description'] = 'Damage Taken Mode', 'DT', 'Turtle'}	
	
	state.weapon_list = M{['description']='Current Weapon', 'Chango', 'Bravura', 'Ragnarok', 'Shining One', 'Naegling', 'Loxotic Mace +1' }
	
	--When we auto-equip the weapons what grip/shield do you want to use?
	offhand_list= T{
	['Bravura']='Utu Grip',
	['Ragnarok']='Utu Grip',
	['Chango']='Utu Grip',
	['Shining One']='Utu Grip',
	['Naegling']='Blurred Shield +1',
	['Loxotic Mace +1']='Blurred Shield +1'}
	
	--For auto-hasso
	one_handed_list = T{'Naegling', 'Loxotic Mace +1', 'Karambit'}
	
	MacroBook = 14
	MacroPage = {}
	MacroPage['Bravura'] = 1
	MacroPage['Ragnarok'] = 2
	MacroPage['Loxotic Mace +1'] = 4
	MacroPage['Shining One'] = 5
	MacroPage['Naegling'] = 3
	MacroPage['Chango'] = 1	
	
	send_command('bind f9 gs c cycle OffenseMode')
	send_command('bind !f9 gs c toggle AutoOffenseMode')
	send_command('bind ^f9 gs c cycle weapon_list')
	send_command('bind f10 gs c set DefenseMode Active')
	send_command('bind ^f10 gs c cycle ActiveDefenseMode')	
	send_command('bind !f10 gs c reset DefenseMode')
	send_command('bind f11 gs c cycle WeaponskillMode')
	send_command('bind ^f12 gs c toggle Kiting')
	send_command('bind !f12 gs c toggle Twilight')
	
	get_main_hand()
	get_combat_form()
	select_default_macro_book(MacroPage[state.weapon_list.value], MacroBook)	
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
	send_command('unbind f9')
	send_command('unbind ^f9')
	send_command('unbind !f9')
	send_command('unbind f10')
	send_command('unbind ^f10')
	send_command('unbind !f10')
	send_command('unbind ^f11')
	send_command('unbind !f11')
	send_command('unbind ^f11')
	send_command('unbind f12')
	send_command('unbind ^f12')
	send_command('unbind !f12')
end


-- Define sets and vars used by this job file.

function init_gear_sets()
	--------------------------------------
	-- Augmented Pieces
	--------------------------------------
	cape = {}
	cape.DA = {name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	cape.WSD = {name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}
	
	Valorous = {}
	Valorous.Head = {}
	Valorous.Head.WSD = {name="Valorous Mask", augments={'Attack+19','Weapon skill damage +4%','AGI+5',}}
	Valorous.Body = {}
	Valorous.Body.STP = {name="Valorous Mail", augments={'Accuracy+19','"Store TP"+6','STR+7','Attack+8',}}
	Valorous.Body.DA = { name="Valorous Mail", augments={'Accuracy+13','"Dbl.Atk."+5','VIT+10',}}
	
	Valorous.Legs = {}
	Valorous.Legs.TP = { name="Valor. Hose", augments={'Accuracy+28','"Store TP"+7','VIT+3','Attack+10',}}
	
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	sets.Buff = {}
	sets.Buff['Mighty Strikes'] = {}
	
	sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers"}
	sets.precast.JA.Berserk = {body="Pumm. Lorica +3",feet="Agoge Calligae +3",back=cape.DA}
	sets.precast.JA.Retaliation = {hands="Pumm. Mufflers +1",feet="Boii Calligae"}
	sets.precast.JA.Warcry = {head="Agoge Mask +3"}
	sets.precast.JA.Aggressor = {body="Agoge Lorica +3"}
	sets.precast.JA['Blood Rage'] = {body="Boii Lorica"}
	sets.precast.JA["Warrior's Charge"] = {legs="Agoge Cuisses"}
	sets.precast.JA.Tomahawk = {ammo="Thr. Tomahawk", feet="Agoge Calligae +3"}
	
	sets.precast.JA.Provoke = { ammo="Iron Gobbet",
		head="Souv. Schaller +1",
		body="Souv. Cuirass +1",
		hands="Eschite Gauntlets",
		legs="Souv. Diechlings +1",
		neck="Moonlight Necklace",
		waist="Goading Belt",
		left_ear="Trux Earring",
		left_ring="Begrudging Ring",
		right_ring="Supershear Ring"}
	
	sets.precast.WS ={ammo="Knobkierrie",
		head="Agoge Mask +3",
		neck="Warrior's Bead Necklace +2",
		lear="Ishvara Earring",
		rear="Thrud Earring",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		rring="Epaminondas's Ring",
		lring="Regal Ring",
		back=cape.WSD,
		waist="Sailfi Belt +1",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets"}
		
	sets.precast.WS.Max = set_combine(sets.precast.WS, {    })
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {	})
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	
	--================================================[WEAPON SKILLS - GREAT AXE]==========================================================
	sets.precast.WS['Metatron Torment'] = set_combine(sets.precast.WS,{})

	sets.precast.WS['Metatron Torment'].Acc = set_combine(sets.precast.WS['Metatron Torment'] ,{ }) --You can have a .Acc set for ANY of these WS sets

	sets.precast.WS['Metatron Torment'].Max = set_combine(sets.precast.WS['Metatron Torment'], {})	

	sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS,{lear="Moonshade Earring",legs="Odyssean Cuisses"})
	
	sets.precast.WS['Upheaval'] = 
	set_combine(sets.precast.WS,{lear="Moonshade Earring", rring="Niqmaddu Ring"})
	
	sets.precast.WS['Upheaval'].Max = set_combine(sets.precast.WS['Upheaval'], {head="Sakpata's Helm", hands="Sakpata's Gauntlets"})
	
	sets.precast.WS["Ukko's Fury"] = {ammo="Yetshila +1",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands="Flam. Manopolas +2",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}}
	
	sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, { })
	
	sets.precast.WS['Full Break'] =  set_combine(sets.precast.WS,{lear="Moonshade Earring",legs="Odyssean Cuisses"})

	--================================================[WEAPON SKILLS - SWORD/FENCER]=======================================================	
	sets.precast.WS['Savage Blade'] = {main="Naegling",
		sub="Blurred Shield +1",
		ammo="Knobkierrie",
		head="Agoge Mask +3",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="War. Beads +2",
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back=cape.WSD}
	
	sets.precast.WS['Savage Blade'].Max = set_combine(sets.precast.WS['Savage Blade'], {hands="Sakpata's Gauntlets"})	
	
	--================================================[WEAPON SKILLS - CLUB/FENCER]=======================================================	
	sets.precast.WS['Judgement'] = {main="Loxotic Mace +1",
		sub="Blurred Shield +1",
		ammo="Knobkierrie",
		head="Agoge Mask +3",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="War. Beads +2",
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back=cape.WSD}	
	
	sets.precast.WS['Judgement'].Max = set_combine(sets.precast.WS['Judgement'], {})
	
	sets.precast.WS['Black Halo'] = {main="Loxotic Mace +1",
		sub="Blurred Shield +1",
		ammo="Knobkierrie",
		head="Agoge Mask +3",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="War. Beads +2",
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back=cape.WSD}
		
	sets.precast.WS['Black Halo'].Max = set_combine(sets.precast.WS['Black Halo'], {})
	
	--================================================[WEAPON SKILLS - POLEARM]============================================================
	sets.precast.WS['Impulse Drive'] = {}
	
	sets.precast.WS['Impulse Drive'].Max = {}

	--================================================[WEAPON SKILLS - GREAT SWORD]============================================================		
	sets.precast.WS['Ground Strike'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Scourge'] = {main={ name="Ragnarok", augments={'Path: A',}},
		sub="Utu Grip",
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Odyssean Gauntlets", augments={'MND+8','STR+7','Weapon skill damage +8%','Accuracy+3 Attack+3',}},
		legs="Pumm. Cuisses +3",
		feet="Sulev. Leggings +2",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist="Prosilio Belt +1",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
	
	sets.precast.WS['Resolution'] = {
		sub="Utu Grip",
		ammo="Knobkierrie",
		head="Flamma Zuchetto",
		body="Dagon Breastplate",
		hands="Sulev. Gauntlets +2",
		legs="Pummeler's Cuisses +3",
		feet="Pummeler's Calligae +3",
		neck="Warrior's Bead Necklace +2",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		right_ring="Niqmaddu Ring",
		left_ring="Regal Ring",
		back=cape.DA}
	
	sets.precast.WS['Shockwave'] = {main={ name="Ragnarok", augments={'Path: A',}},
		sub="Utu Grip",
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Odyssean Gauntlets", augments={'MND+8','STR+7','Weapon skill damage +8%','Accuracy+3 Attack+3',}},
		legs="Pumm. Cuisses +3",
		feet="Sulev. Leggings +2",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist="Prosilio Belt +1",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
	
	sets.precast.WS['Herculean Slash'] = {main={ name="Ragnarok", augments={'Path: A',}},
		sub="Utu Grip",
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Pumm. Lorica +3",
		hands={ name="Odyssean Gauntlets", augments={'MND+8','STR+7','Weapon skill damage +8%','Accuracy+3 Attack+3',}},
		legs="Pumm. Cuisses +3",
		feet="Sulev. Leggings +2",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}}	

	--================================================================================================================================

	-- Sets to return to when not performing an action.
	
	sets.idle = { ammo="Staunch Tathlum",
		head=Valorous.Head.WSD,
		body="Hjarrandi Breast.",
		hands="Sulev. Gauntlets +2",
		legs="Volte Brayettes",
		feet="Volte Sollerets",
		neck="War. Beads +2",
		waist="Prosilio Belt +1",
		left_ear="Odnowa Earring",
		right_ear="Thrud Earring",
		left_ring="Moonbeam Ring",
		right_ring="Karieyh Ring",
		back=cape.DA}
	
	
	sets.idle.DT = set_combine(sets.idle,{head="Hjarrandi Helm", waist="Flume Belt"})
	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle.Town = set_combine(sets.idle,{ body="Councilor's Garb" })		
	
	sets.idle.Field = { ammo="Staunch Tathlum",
		head=Valorous.Head.WSD,
		body="Hjarrandi Breast.",
		hands="Sulev. Gauntlets +2",
		legs="Volte Brayettes",
		feet="Volte Sollerets",
		neck="War. Beads +2",
		waist="Prosilio Belt +1",
		left_ear="Odnowa Earring",
		right_ear="Thrud Earring",
		left_ring="Moonbeam Ring",
		right_ring="Karieyh Ring",
		back=cape.DA}
	
	sets.idle.Field.DT = set_combine(sets.idle.DT, {})
	sets.Kiting = {feet="Hermes' Sandals"}
	sets.Twilight = {head="Twilight Helm",body="Twilight Mail"}
	
	-- Engaged sets
	-- sets.engaged[state.CombatForm][state.CombatWeapon][state.OffenseMode][state.HybridMode][classes.CustomMeleeGroups (any number)]
	
	--=============================================================================================================
	-- Normal melee group	
	sets.engaged = {}
	sets.engaged.Acc = {}
	sets.engaged.DT = {}
	sets.engaged.Turtle = {}
	
	--=============================================================================================================	
	--Bravura
	sets.engaged['Bravura'] = {main="Bravura", sub="Utu Grip", 
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body="Dagon Breast.",
		hands="Argosy Mufflers +1",
		legs="Pummeler's Cuisses +3",
		feet="Pummeler's Caligae +3",
		neck="War. Beads +2",
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Chirich Ring +1",
		back=cape.DA}
	
	sets.engaged['Bravura'].AM3 = set_combine(sets.engaged['Bravura'],{})
	-- {main={ name="Bravura", augments={'Path: A',}},
    -- sub="Utu Grip",
    -- ammo="Aurgelmir Orb +1",
    -- head="Hjarrandi Helm",
    -- body="Hjarrandi Breast.",
    -- hands="Flam. Manopolas +2",
    -- legs="Jokushu Haidate",
    -- feet={ name="Valorous Greaves", augments={'Accuracy+24 Attack+24','"Store TP"+7','VIT+5','Accuracy+12','Attack+14',}},
    -- neck={ name="War. Beads +2", augments={'Path: A',}},
    -- waist="Ioskeha Belt +1",
    -- left_ear="Cessance Earring",
    -- right_ear="Telos Earring",
    -- left_ring="Chirich Ring +1",
    -- right_ring="Chirich Ring +1",
    -- back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}}}
	
	sets.engaged['Bravura'].Acc = {main="Bravura", sub="Utu Grip",}	
	
	sets.engaged['Bravura'].Max = set_combine(sets.engaged['Bravura'],{})
	
	sets.engaged['Bravura'].Max.AM3 = set_combine(sets.engaged['Bravura'].AM3,{})
	
	sets.engaged['Bravura'].DT = {main={ name="Bravura", augments={'Path: A',}},
    sub="Utu Grip",
    ammo="Aurgelmir Orb +1",
    head="Hjarrandi Helm",
    body="Hjarrandi Breast.",
    hands="Sulev. Gauntlets +2",
    legs="Jokushu Haidate",
    feet="Volte Sollerets",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Moonlight Ring",
    right_ring="Moonlight Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}}
	
	sets.engaged['Bravura'].Turtle = {main="Bravura", sub="Utu Grip",}
	
	--=============================================================================================================
	--Chango
	sets.engaged['Chango'] = {
		main="Chango",
		sub="Utu Grip",
		ammo="Aurgelmir Orb +1",
		head="Hjarrandi Helm",
		body="Argosy Hauberk +1",
		hands="Argosy Mufflers +1",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck="War. Beads +2",
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Petrov Ring",
		right_ring="Chirich Ring +1",
		back=cape.DA}
	
	sets.engaged['Chango'].Acc = {main="Chango", sub="Utu Grip",}

	sets.engaged['Chango'].Max = set_combine(sets.engaged['Chango'],{})
	
	sets.engaged['Chango'].DT = {main="Chango", sub="Utu Grip",
	ammo="Aurgelmir Orb +1",
    head="Hjarrandi Helm",
    body="Hjarrandi Breast.",
    hands="Sulev. Gauntlets +2",
    legs="Volte Brayettes",
    feet="Volte Sollerets",
    neck="War. Beads +2",
    waist="Ioskeha Belt +1",
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Moonbeam Ring",
    right_ring="Moonbeam Ring",
    back=cape.DA}
	
	sets.engaged['Chango'].Turtle = {main="Chango", sub="Utu Grip",}
	
	--=============================================================================================================
	sets.engaged['Nandaka'] = {main="Nanadaka",
    sub="Utu Grip",
    ammo="Ginsen",
    head="Hjarrandi Helm",
    body=Valorous.Body.DA,
    hands="Argosy Mufflers +1",
    legs="Flamma Dirs +2",
    feet="Flamma Gambieras +2",
    neck="War. Beads +2",
    waist="Ioskeha Belt +1",
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Petrov Ring",
    right_ring="Chirich Ring +1",
    back=cape.DA}
	
	--Ragnarok
	sets.engaged['Ragnarok'] = {main={ name="Ragnarok", augments={'Path: A',}},
    sub="Utu Grip",
    ammo="Aurgelmir Orb +1",
    head="Hjarrandi Helm",
    body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
    hands={ name="Argosy Mufflers +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs="Pumm. Cuisses +3",
    feet="Pumm. Calligae +3",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring +1",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}}}
	
	sets.engaged['Ragnarok'].AM3 = {main={ name="Ragnarok", augments={'Path: A',}},
    sub="Utu Grip",
    ammo="Yetshila +1",
    head="Hjarrandi Helm",
    body="Hjarrandi Breast.",
    hands="Flam. Manopolas +2",
    legs="Jokushu Haidate",
    feet={ name="Valorous Greaves", augments={'Accuracy+24 Attack+24','"Store TP"+7','VIT+5','Accuracy+12','Attack+14',}},
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring +1",
    back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','Crit.hit rate+10','Occ. inc. resist. to stat. ailments+10',}}}
	
	sets.engaged['Ragnarok'].Acc = {main="Ragnarok", sub="Utu Grip",}
	
	sets.engaged['Ragnarok'].DT = {main="Ragnarok", sub="Utu Grip",
	ammo="Aurgelmir Orb +1",
    head="Hjarrandi Helm",
    body="Hjarrandi Breast.",
    hands="Sulev. Gauntlets +2",
    legs="Jokushu Haidate",
    feet="Volte Sollerets",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Moonlight Ring",
    right_ring="Moonlight Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}}
	
	sets.engaged['Ragnarok'].Turtle = {main="Ragnarok", sub="Utu Grip",}
	
	--=============================================================================================================
	--Naegling
	sets.engaged['Naegling'] = {main="Naegling",
    sub="Blurred Shield +1",
	ammo="Ginsen",
	head="Hjarrandi Helm",
	neck="War. Beads +2",
	lear="Telos Earring",
	rear="Cessance Earring",
	body=Valorous.Body.DA,
	hands="Sulevia's Gauntlets +2",
	lring="Niqmaddu Ring",
	rring="Chirich Ring +1",
	back=cape.DA,
	waist="Ioskeha Belt +1",
	legs="Pummeler's Cuisses +3",
	feet="Pummeler's Calligae +3"}
	
	sets.engaged['Naegling'].Acc = {main="Naegling", sub="Blurred Shield +1",}
	
	sets.engaged['Naegling'].Max = set_combine(sets.engaged['Naegling'],{})
	
	sets.engaged['Naegling'].DT = {main="Naegling", sub="Blurred Shield +1",
	ammo="Aurgelmir Orb +1",
    head="Hjarrandi Helm",
    body="Hjarrandi Breast.",
    hands="Sulev. Gauntlets +2",
    legs="Jokushu Haidate",
    feet="Volte Sollerets",
    neck={ name="War. Beads +2", augments={'Path: A',}},
    waist="Ioskeha Belt +1",
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Moonlight Ring",
    right_ring="Moonlight Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}}
	
	sets.engaged['Naegling'].Turtle = {main="Naegling", sub="Blurred Shield +1",}	

	--=============================================================================================================
	--Loxotic Mace +1
	sets.engaged['Loxotic Mace +1'] = {main="Loxotic Mace +1",
    sub="Blurred Shield +1",
	ammo="Ginsen",
	head="Hjarrandi Helm",
	neck="War. Beads +2",
	lear="Telos Earring",
	rear="Schere Earring",
	body="Tatenashi Haramaki +1",
	hands="Sakpata's Gauntlets",
	lring="Niqmaddu Ring",
	rring="Chirich Ring +1",
	back=cape.DA,
	waist="Sailfi Belt +1",
	legs="Pummeler's Cuisses +3",
	feet="Pummeler's Calligae +3"}
	
	sets.engaged['Loxotic Mace +1'].Acc = {main="Loxotic Mace +1", sub="Blurred Shield +1",}

	sets.engaged['Loxotic Mace +1'].Max = set_combine(sets.engaged['Loxotic Mace +1'],{})

	sets.engaged['Loxotic Mace +1'].DT = {main="Loxotic Mace +1", sub="Blurred Shield +1",
	ammo="Aurgelmir Orb +1",
    head="Sakpata's Helm",
    body="Sakpata's Breastplate",
	hands="Sakpata's Gauntlets",
    legs="Tatenashi Haidate +1",
    feet="Volte Sollerets",
    neck="War. Beads +2",
    waist="Ioskeha Belt +1",
    left_ear="Schere Earring",
    right_ear="Telos Earring",
    left_ring="Moonlight Ring",
    right_ring="Moonlight Ring",
    back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}}
	
	sets.engaged['Loxotic Mace +1'].Turtle = {main="Loxotic Mace +1", sub="Blurred Shield +1",}	
	
	--=============================================================================================================
	--Shining One
	sets.engaged['Shining One'] = {main="Shining One"}
	
	sets.engaged['Shining One'].Acc = {main="Shining One"}
	
	sets.engaged['Shining One'].DT = {main="Shining One"}
	
	sets.engaged['Shining One'].Turtle = {main="Shining One"}	
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
	if state.Twilight.value ~= false then
		idleSet = set_combine(idleSet, sets.Twilight)
	end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.Twilight.value ~= false then
		meleeSet = set_combine(meleeSet, sets.Twilight)
	end
	
	if buffactive['Mighty Strikes'] and current_weapon == 'Ragnarok' then
		meleeSet = set_combine(meleeSet, sets.Buff['Mighty Strikes'])
	end
	return meleeSet
end

function customize_defense_set(defenseSet)
    if state.Twilight.value ~= false then
		defenseSet = set_combine(defenseSet, sets.Twilight)
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
	check_hasso()
end
function job_state_change(field, new_value, old_value)
	if field == 'Current Weapon' then	
		state.CombatWeapon:Set(new_value)	
		equip({main=new_value, sub=offhand_list[new_value] or empty})
		select_default_macro_book(MacroPage[state.weapon_list.value], MacroBook)
	end
	get_combat_form()
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff:contains("Aftermath") then
        get_combat_form()
	elseif buff:contains("Doom") then
		if gain then
			send_command("input /p SOMEBODY SAVE ME! DOOM!")
		elseif not gain and not buffactive[0] then
			send_command("input /p No longer doomed.")
		end		
	elseif buff:contains("Charm") then
		if gain then
			send_command("input /p WATCH OUT, I'M CHARMED <3")
		elseif not gain and not buffactive[0] then
			send_command("input /p No longer charmed </3")		
		end	
	elseif buff == 'Hasso' and not gain then
		check_hasso()
	end
end

function job_update(cmdParams, eventArgs)
	get_combat_form()
	check_hasso()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    -- if cmdParams[1]:lower() == "getweapon" then
        -- get_main_hand()
    -- end
end

function get_combat_form()	
	classes.CustomDefenseGroups:clear()
	classes.CustomIdleGroups:clear()
	classes.CustomMeleeGroups:clear()	

	if state.DefenseMode.value ~= 'None' then	
		classes.CustomMeleeGroups:append(state.ActiveDefenseMode.value)
		classes.CustomIdleGroups:append(state.ActiveDefenseMode.value)	
	else
		get_offense_mode()
		get_aftermath()
	end
	
	check_hasso()
	
	if not midaction then
		handle_equipping_gear()
	end
end

--If you are capped on haste AND 3+ attack buffs (indi-fury, Chaos Roll, Minuets, etc)
function get_offense_mode()
	if state.AutoOffenseMode.value == true then
		local hstCount = 0
		if buffactive[580] then hstCount = hstCount+1 end --indi: haste
		if buffactive[33] then hstCount = hstCount+1 end --Haste
		if buffactive[604] then hstCount = hstCount+1 end --Mighty Guard
		if buffactive.march then hstCount = hstCount+buffactive.march end --March
		
		--We can safely assume that if we have 2 of any haste type, we're capped on magical haste
		if state.OffenseMode.value ~='Acc' then			
			if hstCount >= 2 then 
				local atkCount = 0
				if buffactive[317] then atkCount = atkCount+1 end 	 --Chaos Roll
				if buffactive[198] then					--Minuet
					if buffactive[198]>=2 then atkCount = atkCount+2 
					else atkCount = atkCount+1 end
				end
				if buffactive[549] then atkCount = atkCount+1 end	 --Indi: Fury?
				
				if atkCount > 2 then					
					state.OffenseMode:set('Max')
					state.WeaponskillMode:set('Max')
				else
					state.OffenseMode:reset()
					state.WeaponskillMode:reset()
				end
			else
				state.OffenseMode:reset()	
				state.WeaponskillMode:reset()			
			end
		end  
	end
end


function get_main_hand()
	local mainhand = player.equipment.main
	
	if state.weapon_list:contains(mainhand) then
		state.weapon_list:set(mainhand)
	end
end

function get_aftermath()
	if buffactive[272] or buffactive [273] then
		classes.CustomMeleeGroups:append("AM3")
	end
end

function check_hasso()
	--if Hasso isnt up, and we're not in town and not dead, charmed, stunned, etc. put it back up
	if player.sub_job == 'SAM' and not (player.equipment.main == '' or one_handed_list:contains(player.equipment.main)) and not buffactive[353] and not areas.Cities:contains(world.area)then
		if not midaction() and not (buffactive[566] or buffactive[16] or buffactive[0] or buffactive[28] or buffactive[10] or buffactive[14] or buffactive[17] or buffactive[69] or buffactive[354])then
			send_command("input /ja Hasso <me>")
		end
	end   
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
	local msg = 'Weapon: '..state.weapon_list.value..', Melee: '.. state.OffenseMode.value
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
	
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', Defense: ' .. state[state.DefenseMode.value .. 'DefenseMode'].value 
    end
	
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end
	
    add_to_chat(122, msg)

    eventArgs.handled = true
end

function SaySomething()
	add_to_chat(122, "Kuz is a butt.")
end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book(page, book)
    set_macro_page(page, book)
end