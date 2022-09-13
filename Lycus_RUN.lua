-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
require("queues.lua")

function get_sets()
    mote_include_version = 2
	-- Load and initialize the include file.
	include('Mote-Include.lua')	
end
-- Setup vars that are user-independent.
function job_setup()	
	-- Table of entries

	state.Buff = {}
	state.Buff.Doom = buffactive.doom or false
	
	state.Buff.Swordplay = buffactive.Swordplay or false
	state.Buff.Embolden = buffactive.Embolden or false
	state.Buff.Vallation = buffactive.Vallation or false
	state.Buff.Pflug = buffactive.Pflug or false
	state.Buff.Valiance = buffactive.Valiance or false
	state.Buff.Liement = buffactive.Liement or false
	state.Buff.Battuta = buffactive.Battuta or false
	
	state.Buff.Temper = buffactive[432] or false
	state.Buff.Crusade = buffactive[289] or false
	
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'DPS')
	state.AccuracyMode = M{['description'] = 'Accuracy Mode', 'Normal', 'Acc'}
	state.StandardDefenseMode = M{['description'] = 'Standard Defense Mode', 'DT', 'HP'}
    state.PhysicalDefenseMode:options('PDT', 'Evasion', 'Parry')
    state.MagicalDefenseMode:options('MDT', 'MEvasion', 'Charm')
	state.DefenseMode:options('None', 'Standard', 'Physical', 'Magical')
	
	send_command('bind Home gs c update user')
	send_command('bind f9 gs c reset DefenseMode')
	send_command('bind !f9 gs c cycle OffenseMode')
	send_command('bind ^f9 gs c cycle AccuracyMode')
	send_command('bind f10 gs c set DefenseMode Standard')
	send_command('bind ^f10 gs c cycle StandardDefenseMode')
	send_command('bind f11 gs c set DefenseMode Physical')
	send_command('bind ^f11 gs c cycle PhysicalDefenseMode')
	send_command('bind f12 gs c set DefenseMode Magical')
	send_command('bind ^f12 gs c cycle MagicalDefenseMode')
	
	
	--send_command('bind End gs c -Rune')
	--send_command('bind @` gs c -ALL')
	--send_command('bind @1 gs c cycle Rune1')
	--send_command('bind @2 gs c cycle Rune2')
	--send_command('bind @3 gs c cycle Rune3')
	--send_command('bind End input /ja '..state.Rune.Value..' <me>')
	
	-- q_runes.push(q_runes, state.Rune1)
	-- q_runes.push(q_runes, state.Rune2)
	-- q_runes.push(q_runes, state.Rune3)
	-- next_rune = q_runes[1]
	
	select_default_macro_book(1, 16)
	get_combat_form()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	-- send_command('unbind End')
	send_command('unbind Home')
	-- send_command('unbind @1')
	-- send_command('unbind @2')
	-- send_command('unbind @3')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	gear.cape = { }
	gear.cape.DA = {name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	gear.cape.STP = {name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	gear.cape.WSD = {name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}
	gear.cape.SIR = {name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Spell interruption rate down-10%',}}
	gear.cape.FC = {name="Ogma's cape", augments={'"Fast Cast"+10%',}}
	gear.cape.ACC = {name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	gear.cape.MEVA = {name="Ogma's cape", augments={'Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Dbl.Atk."+10','Mag. Evasion+15',}}
	
	
	AdhemarJacket = {}
	AdhemarJacket.Acc = { name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
	AdhemarJacket.Atk = { name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}}
	
	AdhemarWrists = {}
	AdhemarWrists.Atk = { name="Adhemar Wrist. +1", augments = {'STR+12','DEX+12','Attack+20',} }
	AdhemarWrists.Acc = { name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',} }
	
	HerculeanHelm = {}
	HerculeanHelm.TA = { name="Herculean Helm", augments={'Accuracy+25','"Triple Atk."+4','DEX+1',} }
    HerculeanHelm.WSD = { name = "Herculean Helm",augments={'Accuracy+27','Weapon skill damage +4%',}}
    
    HerculeanVest = {}
    HerculeanVest.WSD  = { nname="Herculean Vest", augments={'Weapon skill damage +5%','Accuracy+4','Crit.hit rate+5','Accuracy+10 Attack+10','Mag. Acc.+2 "Mag.Atk.Bns."+2',}}
	HerculeanVest.TA = { name="Herculean Vest", augments={'Accuracy+23 Attack+23','"Triple Atk."+4','DEX+2',}}
        
    HerculeanFeet = {}
    HerculeanFeet.TA = { name = "Herculean Boots", augments={'Accuracy+25','"Triple Atk."+4','STR+3','Attack+10',}}
    HerculeanFeet.WSD = { name="Herculean Boots", augments={'Accuracy+27','Weapon skill damage +3%','AGI+13',}}	
	
	TaeonHead = {}
	TaeonHead.SIR = { name="Taeon Chapeau", augments={'Spell interruption rate down -10%','Phalanx +3',}}
	
    TaeonBody = {}
    TaeonBody.FC = { name="Taeon Tabard", augments = {'Accuracy+23','"Fast Cast"+5','HP+36',} }
    TaeonBody.SIR = { name="Taeon Tabard", augments={'Spell interruption rate down -10%','Phalanx +3',}}

	TaeonHands = {}
	TaeonHands.Phalanx = { name="Taeon Gloves", augments={'Spell interruption rate down -9%','Phalanx +3',}}
	
	TaeonFeet = {}
	TaeonFeet.SIR = { name="Taeon Boots", augments={'Spell interruption rate down -10%','Phalanx +3',}}
	
	
	sets.Enmity = {ammo="Iron Gobbet",
	head="Despair helm", neck="Moonlight Necklace", lear="Trux Earring", rear="Friomisi Earring",
	body="Emet Harness +1",	hands='Kurys Gloves', lring="Supershear Ring", rring="Vengeful Ring",
	back=gear.cape.SIR, waist="Kasiri Belt", legs="Erilaz Leg Guards +1",  feet="Ahosi Leggings"}
	
	sets.SIR = {ammo='Staunch Tathlum',
	head=TaeonHead.SIR, neck='Moonlight Necklace',rear="Halasz Earring",
	body=TaeonBody.SIR, hands='Regal Gauntlets', rring="Evanescence Ring",
	back=gear.cape.SIR, waist="Gold Obi +1", legs='Carmine Cuisses +1', feet=TaeonFeet.SIR}
	
	sets.Buff = {}
	sets.Buff['Doom'] = {}
	
	sets.Buff['Battuta'] = { hands="Turms Mittens +1", legs="Erilaz Leg Guards +1", feet="Futhark Boots +2" }
	
	-- Precast Sets
	-- Precast sets to enhance JAs
	
	sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity,{body="Futhark Coat +3" })
	sets.precast.JA['Swordplay'] = set_combine(sets.Enmity,{ hands="Futhark Mitons +1" })
	sets.precast.JA['Embolden'] = set_combine(sets.Enmity,{ back="Evasionist's Cape" })
	sets.precast.JA['One for All'] = {ammo="Yamarang",
		head="ERilaz Galea +1", neck="Runeist Torque +2", lear="Etiolation Earring", rear="Odnowa Earring +1",
		body="Runeist Coat +3", hands="Regal Gauntlets", lring="Moonbeam Ring", rring="Moonbeam Ring",
		back="Moonbeam Cape", waist="Kasiri Belt", legs="Carmine Cuisses +1", feet="Carmine Greaves +1"} --HP Set
	sets.precast.JA['Vivacious Pulse'] = set_combine(sets.Enmity,{ head="Erilaz Galea +1", neck="Henic Torque",  
	lring="Stikini Ring", rring="Stikini Ring +1", waist="Bishop's Sash", legs="Runeist Trousers +1", }) --Divine Skill
	
	sets.precast.JA['Vallation'] = set_combine(sets.Enmity,{ body="Runeist Coat +3", back="Ogma's Cape"})
	sets.precast.JA['Pflug'] = set_combine(sets.Enmity,{ feet="Runeist Bottes +1" })
	sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
	sets.precast.JA['Liement'] = set_combine(sets.Enmity,{ body="Futhark Coat +3" }	)		
	sets.precast.JA['Battuta'] = set_combine(sets.Enmity,{ head="Futhark Bandeau +3" })
	
	sets.precast.JA['Swipe'] = { ammo="Grenade Core",
		head=HerculeanHelm.TA, neck="Combatant's Torque", lear="Novio Earring", rear="Friomisi Earring",
		body="Samnuha Coat", hands="Leyline Gloves", lring="Acumen Ring", rring="Stikini Ring",
		back="Evasionist's Cape", waist="Salire Belt", legs="Ayanmo Cosciales +2", feet=HerculeanFeet.TA}
		
	sets.precast.JA['Lunge'] = sets.precast.JA['Swipe']
	sets.precast.JA['Gambit'] = set_combine(sets.Enmity,{ hands="Runeist Mitons +1" })
	sets.precast.JA['Rayke'] = set_combine(sets.Enmity,{ feet="Futhark Boots +2" })
	
	-- Fast cast sets for spells
	sets.precast.FC = { ammo="Impatiens",
		head="Carmine Mask +1", neck='Voltsurge Torque',lear="Etiolation Earring", rear="Loquac. Earring",
		body="Vrikodara Jupon", hands="Leyline Gloves", lring="Kishar Ring", rring="Prolix Ring",
		back=gear.cape.FC,  						legs="Ayanmo Cosciales +2", feet="Carmine Greaves +1"}
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,{waist="Siegel Sash", legs="Futhark Trousers +2" })
	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{ waist='Goading Belt' })
	
	sets.midcast['Enhancing Magic'] = set_combine(sets.Enmity,{head='Erilaz Galea +1',neck="Incanter's Torque",hands='Regal Gauntlets',rring='Stikini Ring', lring='Stikini Ring +1', legs='Futhark Trousers +2'})
	sets.midcast['Stoneskin'] = set_combine(sets.Enmity,sets.SIR,{waist='Siegel Sash'})	
	sets.midcast['Blink'] = set_combine(sets.Enmity, sets.SIR, {body='Emet Harness +1', waist='Gold Obi +1'})
	sets.midcast['Aquaveil'] = set_combine(sets.midcast['Blink'],{})
	sets.midcast['Foil'] = set_combine(sets.midcast.FastRecast, sets.Enmity, {hands='Regal Gauntlets'})
	sets.midcast['Crusade'] = set_combine(sets.Enmity,{head='Erilaz Galea +1', hands='Regal Gauntlets',legs='Futhark Trousers +2'})
	sets.midcast['Phalanx'] = set_combine(sets.Enmity,sets.SIR,{head='Futhark Bandeau +3', hands=TaeonHands.Phalanx ,waist='Gold Obi +1'})
	sets.midcast['Refresh'] = set_combine(sets.Enmity, sets.SIR,{head='Erilaz Galea +1', waist='Gold Obi +1'})
	sets.midcast['Regen'] = set_combine(sets.Enmity, sets.SIR, {head='Runeist Bandeau +1', waist='Gold Obi +1'})

	
	sets.midcast['Flash'] = set_combine(sets.midcast.FastRecast,sets.Enmity,{head='Carmine Mask +1', feet='Carmine Greaves +1'})
	sets.midcast['Stun'] = set_combine(sets.midcast.FastRecast,sets.Enmity,{head='Carmine Mask +1', feet='Carmine Greaves +1'})
	sets.midcast['Poisonga'] = set_combine(sets.Enmity, sets.SIR)
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, sets.SIR)


	-- Midcast sets for when Aquaviel is up OR when we're not in combat for MAX POTENCY
	sets.Stoneskin = set_combine(sets.Enmity, {hands='Regal Gauntlets', waist='Siegel Sash'})
	
	sets.Phalanx = {head='Futhark Bandeau +3', neck="Incanter's Torque", body='Taeon Tabard', hands='Taeon Gloves', 
	ring1='Stikini Ring', ring2='Stikini Ring +1', back=gear.cape.FC, waist='Siegel Sash',legs='Futhark Trousers +2', feet='Taeon Boots'}
	
	sets.Refresh = set_combine(sets.midcast.FastRecast,{head='Erilaz Galea +1', hands='Regal Gauntlets', legs='Futhark Trousers +2' })
	
	sets.Regen = set_combine(sets.midcast.FastRecast,{head='Runeist Bandeu +1', hands='Regal Gauntlets', legs='Futhark Trousers +2'})
	
	
	
	
	
	---------------------------------------------------------------------------------------------------------------
	
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined

	sets.precast.WS = { ammo="Knobkierrie",
		head="Nyame Helm", neck="Fotia Gorget", lear="Moonshade Earring", rear="Ishvar Earring",
		body="Nyame Mail", hands="Nyame Gauntlets", lring="Epaminondas's Ring", rring="Karieyh Ring",
		back=gear.cape.WSD, waist="Fotia Belt", legs="Nyame Flanchard", feet="Nyame Sollerets"}
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS,{ammo="Aurgelmir Orb +1", head="Adhemar Bonnet +1", body=AdhemarJacket.Atk, hands=AdhemarWrists.Atk, legs='Samnuha Tights', rring='Regal Ring', feet=HerculeanFeet.TA})
	--	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS,{head=HerculeanHelm.TA, body=AdhemarJacket.Atk, hands=AdhemarWrists.Atk, legs='Meghanada Chausses +2', rring='Regal Ring', feet=HerculeanFeet.TA})
	sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'], {body=AdhemarJacket.Acc, hands=AdhemarWrists.Acc, legs='Meghanada Chausses +2'})
	
	sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS,{neck='Caro Necklace',rear='Sherida Earring', rring = "Ilabrat Ring", back=gear.cape.WSD })
	
	--sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS,{neck='Caro Necklace', lear='Mache Earring +1', rear='Mache Earring +1', 
	--body=AdhemarJacket.Atk, hands='Meghanada Gloves +2', legs='Lustratio Subligar +1', back=gear.cape.WSD, waist="Cuchulain's Belt"})
	
	sets.precast.WS['Spinning Slash'] = set_combine(sets.precast.WS,{head='Lustratio Cap', rear='Ishvara Earring', rring='Ifrit Ring +1',
	back=gear.cape.WSD, waist='Prosilio Belt'})

	sets.precast.WS['Ground Strike'] = set_combine(sets.precast.WS['Spinning Slash'],{})
	sets.precast.WS['Shockwave'] = set_combine(sets.precast.WS['Spinning Slash'],{})
	
	sets.precast.WS['Steel Cyclone'] = {ammo="Knobkierrie",
    head="Blistering Sallet +1",
    body="Runeist's Coat +3",
    hands="Meg. Gloves +2",
    legs="Meg. Chausses +2",
    feet="Nyame Sollerets",
    neck="Fotia Gorget",
    waist="Sailfi Belt +1",
    left_ear="Moonshade Earring", 
    right_ear="Sherida Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
    back=gear.cape.WSD}
	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {  }	

	-- Idle sets
	sets.idle = { ammo="Staunch Tathlum",
		head="Rawhide Mask", neck="Futhark Torque +2", lear="Etiolation Earring", rear="Ethereal Earring",
		body="Runeist Coat +3", hands="Erilaz Gauntlets +1", lring="Moonbeam Ring", rring="Defending Ring",
		back="Solemnity Cape", waist="Flume Belt", legs="Runeist Trousers +1", feet="Ayanmo Gambieras +2"} 

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle.Town = set_combine(sets.idle,{ body="Councilor's Garb", legs="Carmine Cuisses +1" })		
	
	sets.idle.Field = set_combine(sets.idle.Town, {head='Turms Cap', neck="Futhark Torque +2", body='Futhark Coat +3', hands='Regal Gauntlets', back='Moonbeam Cape', waist='Fucho-no-Obi', Feet='Turms Leggings +1'})
	
	sets.idle.Weak = set_combine(sets.idle, { })
	-- Defense sets 
	-- In Gearswap defense sets are equipped no matter the situation, which I don't personally like - therefore I have retooled the functionality to differentiate between engaged and idle
	sets.defense = { }	
	sets.idle.Field.DT = {     
		ammo="Staunch Tathlum",
		head="Nyame Helm",
		body="Ashera Harness",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets", 
		neck="Futhark Torque +2",
		waist="Flume Belt",
		left_ear="Etiolation Earring",
		right_ear="Eabani Earring",
		left_ring="Moonbeam Ring",
		right_ring="Defending Ring",
		back=gear.cape.MEVA}
	sets.idle.Field.PDT = sets.idle.Field.DT
	sets.idle.Field.MDT = sets.idle.Field.DT
	
	 sets.idle.Field.HP = sets.idle.Field.DT
	-- sets.defense.PDT = { }
    sets.idle.Field.Evasion = sets.idle.Field.DT
	-- sets.defense.Parry = { }
	-- sets.defense.MDT = { }
	sets.idle.Field.MEvasion = sets.idle.Field.DT
	-- sets.defense.Charm = { }
	
	sets.Kiting = { legs="Carmine Cuisses +1" }
	
	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group		
	
	sets.engaged = {main='Epeolatry', sub='Utu Grip', ammo="Staunch Tathlum",
		head="Adhemar Bonnet +1", neck="Futhark Torque +2", lear="Brutal Earring", rear="Sherida Earring",
		body="Ayanmo Corazza +2", hands=AdhemarWrists.Acc, lring="Niqmaddu Ring", rring="Moonbeam Ring",
		back=gear.cape.DA, waist="Ioskeha Belt +1", legs="Meghanada Chausses +2", feet=HerculeanFeet.TA}
		
	sets.engaged.Acc = set_combine(sets.engaged,{ammo="Yamarang", head="Ayanmo Zucchetto +2", neck="Combatant's Torque", lear="Telos Earring", rear="Cessance Earring", back=gear.cape.ACC})

	sets.engaged.AM3 = { main='Epeolatry', sub='Utu Grip', ammo='Yamarang',
		head='Ayanmo Zucchetto +2',  neck="Futhark Torque +2", ear1='Telos Earring', ear2='Sherida Earring',
		body="Ashera Harness", hands='Adhemar Wristbands +1', ring1='Ilabrat Ring', ring2='Chirich Ring +1',
		back=gear.cape.STP, waist='Ioskeha Belt +1', legs='Samnuha Tights', feet="Carmine Greaves +1"}
		
	--Standard Defense
	sets.engaged.DT =
		{main='Epeolatry', sub='Utu Grip', ammo='Staunch Tathlum',
		head="Nyame Helm", neck="Futhark Torque +2",  lear="Brutal Earring", rear="Sherida Earring",
		body="Ashera Harness", hands="Nyame Gauntlets", lring="Defending Ring", rring="Moonbeam Ring",
		back=gear.cape.DA, waist="Ioskeha Belt +1", legs="Meghanada Chausses +2", feet="Nyame Sollerets"}
	sets.engaged.HP = { ammo="Yamarang",
		head="Ayanmo Zucchetto +2", neck="Sanctity necklace", lear="Etiolation Earring", rear="Odnowa Earring +1",
		body="Futhark Coat +3", hands="Meghanada Gloves +2", lring="Moonbeam Ring", rring="Moonbeam Ring",
		back="Moonbeam Cape", waist="Ioskeha Belt +1", legs="Carmine Cuisses +1", feet="Ayanmo Gambieras +2"}
	
	--Physical Defense
	sets.engaged.PDT = set_combine(sets.engaged,
		{head="Meghanada Visor +2", neck="Loricate Torque", lear="Cessance Earring",
		hands="Meghanada Gloves +2", rring="Defending Ring"})
	sets.engaged.Evasion = {  ammo="Yamarang",
		head="Adhemar Bonnet +1", neck="Bathy Choker", lear="Ethereal Earring", rear="Sherida Earring",
		body="Adhemar Jacket +1", hands="Adhemar Wristbands +1", lring="Vengeful Ring", rring="Ilabrat Ring",
		back=gear.cape.SIR, waist="Kasiri Belt", legs="Erilaz Leg Guards +1", feet=HerculeanFeet.TA}
	sets.engaged.Parry = {   
    ammo="Staunch Tathlum",
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Turms Mittens +1",
    legs="Eri. Leg Guards +1",
    feet="Turms Leggings +1",
    neck="Combatant's Torque",
    waist="Ioskeha Belt +1",
    left_ear="Cessance Earring",
    right_ear="Sherida Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Moonbeam Ring",}
	
	--Magical Defense
	sets.engaged.MDT = { }
	sets.engaged.MEvasion = {
	    ammo="Yamarang",
		head="Turms Cap",
		body="Runeist's Coat +3",
		hands="Turms Mittens +1",
		legs="Eri. Leg Guards +1",
		feet="Turms Leggings +1",
		neck="Futhark Torque +2",
		waist="Ioskeha Belt +1",
		left_ear="Eabani Earring",
		right_ear="Sherida Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Vengeful Ring",
		back=gear.cape.MEVA}
	sets.engaged.Charm = { }
	
	sets.engaged.Acc.DT = set_combine(sets.engaged.DT,{back=gear.cape.ACC})
	sets.engaged.Acc.HP = set_combine(sets.engaged.HP,{})	
	
	--DPS engaged sets.
	--DPS sets don't have as many defense options, since it's not the priority for it.
	sets.engaged.DPS = {main="Lionheart", sub="Utu Grip", ammo="Aurgelmir Orb +1",
		head="Adhemar Bonnet +1", neck="Anu Torque", lear="Telos Earring", rear="Sherida Earring",
		body=HerculeanVest.TA, hands=AdhemarWrists.Acc, lring="Niqmaddu Ring", rring="Epona's Ring",
		back=gear.cape.DA, waist="Ioskeha Belt +1", legs="Samnuha Tights", feet=HerculeanFeet.TA}
		
	sets.engaged.DPS.Acc = set_combine(sets.engaged.DPS,{head="Ayanmo Zucchetto +2",neck="Combatant's Torque",lear="Telos Earring", rring="Illabrat Ring", back=gear.cape.ACC })
	sets.engaged.DPS.DT = set_combine(sets.engaged.DPS,{ })
	sets.engaged.DPS.Acc.DT = set_combine(sets.engaged.DPS.DT,{ })
	
	sets.engaged.DPS.Evasion = { }
	sets.engaged.DPS.Parry = { }
	
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

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)

end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Enhancing Magic' then
		if sets[spell.en] and (buffactive.Aquaveil or player.in_combat == false) then
			equip(sets[spell.en])
			eventArgs.handled = true			
		end
	
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)

end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)	
	if not spell.interrupted then
        if spell.name == "Gambit" then
			send_command('timers create "Gambit Duration" 92 down')
		elseif	spell.name == 'Rayke' then
           send_command('timers create "Rayke Duration" 50 down')
        end
		
    end	
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
	if state.Buff.Doom then
       idleSet = set_combine(idleSet, sets.Buff['Doom'])
    end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.Buff.Battuta then
		meleeSet = set_combine(meleeSet, sets.Buff['Battuta'])
	end
	if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.Buff['Doom'])
    end    
	return meleeSet
end

function customize_defense_set(defenseSet)
	if state.Buff.Battuta then
		defenseSet = set_combine(defenseSet, sets.Buff['Battuta'])
	end
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.Buff['Doom'])
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
	get_combat_form()
	check_hasso()
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff == 'Multi Strikes' then
		if gain then
			send_command('timers create "Temper" 240 down')
		else
			send_command('timers delete "Temper"')			
			add_to_chat(8, 'Temper Lost!')
		end
	elseif buff == 'Enmity Boost' then
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
	elseif buff:contains("Aftermath") then
		get_combat_form()
	end	
	check_hasso()
end

function buff_refresh(name,buff_details)
	if name == 'Multi Strikes' then
		send_command('timers create "Temper" 240 down')		
	elseif name == 'Enmity Boost' then
		send_command('timers create "Crusade" 384 down')
	elseif name == 'Phalanx' then
		send_command('timers create "Phalanx" 180 down')		
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
end

function check_hasso()
	--if Hasso isnt up, and we're not in town and not dead, charmed, stunned, etc. put it back up
	if player.sub_job == 'SAM' and not (player.equipment.main == '' or player.equipment.main == 'Naegling') and not buffactive[353] and not areas.Cities:contains(world.area)then
		if not midaction() and not (buffactive[566] or buffactive[16] or buffactive[0] or buffactive[28] or buffactive[10] or buffactive[157] or buffactive[14] or buffactive[17] or buffactive[69] or buffactive[354])then
			send_command("input /ja Hasso <me>")
		end
	end   
end

function get_combat_form()	
	classes.CustomMeleeGroups:clear()	
	classes.CustomDefenseGroups:clear()
	classes.CustomIdleGroups:clear()
	
	if state.OffenseMode.value ~= 'Normal' then
		state.CombatForm:set('DPS')
	else
		state.CombatForm:reset()
	end	
	if state.AccuracyMode.value ~= 'Normal' then
		classes.CustomMeleeGroups:append(state.AccuracyMode.value)
	end
	if state.DefenseMode.value ~= 'None' then
		local custom_mode = state[state.DefenseMode.value .. 'DefenseMode'].value
		classes.CustomMeleeGroups:append(custom_mode)
		--classes.CustomDefenseGroups:append(custom_mode)
		classes.CustomIdleGroups:append(custom_mode)
	end	
	get_aftermath()
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
    msg = msg .. ', Acc: ' .. state.AccuracyMode.value		
		
	if state.DefenseMode.value ~= 'None' then
		msg = msg .. ', Defense: ' .. state[state.DefenseMode.value .. 'DefenseMode'].value 		
	end
	msg = msg .. ', Temper: ' .. (buffactive[432] and 'ON' or 'OFF')
	
	if state.OffenseMode.value ~= 'DPS' then
		msg = msg .. ', Crusade: ' .. (buffactive[289] and 'ON' or 'OFF')
	end
	
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end
	
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

function get_aftermath()
	if buffactive[272] then
		classes.CustomMeleeGroups:append("AM3")
	end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 5)
end