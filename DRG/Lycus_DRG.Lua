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
    -- list of weaponskills that make better use of otomi helm in low acc situations
    wsList = S{'Drakesbane'}
	

	state.Buff = {}
	
	state.Twilight = M(false, 'Twilight')
	
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Min', 'Max','Acc') --Unbuffed, Capped Haste, Capped Buffs, Acc/Atk Starved
	state.AutoOffenseMode = M(true, 'Auto')
	
	state.WeaponskillMode:options('Normal', 'Max', 'Acc') 
    state.DefenseMode:options('None', 'Active')
	state.ActiveDefenseMode = M{['description'] = 'Damage Taken Mode', 'Mid', 'Turtle'}	
	state.IdleMode:options('Normal', 'PetHP')
	
	OffensiveBreaths = S{'Flame Breath', 'Frost Breath', 'Sand Breath', 'Hydro Breath', 'Gust Breath', 'Lightning Breath'}

	state.weapon_list = M{['description']='Current Weapon','Trishula', 'Rhongomiant', 'Shining One', 'Naegling'}
	offhand_list= T{
	['Trishula']='Utu Grip',
	['Rhongomiant']='Utu Grip',
	['Ryunohige']='Utu Grip',
	['Shining One']='Utu Grip',
	['Naegling']=empty}
	
	--For auto-hasso
	one_handed_list = T{'Naegling', 'Loxotic Mace +1', 'Karambit'}
	
	send_command('bind f9 gs c cycle OffenseMode')
	send_command('bind ^f9 gs c cycle WeaponskillMode')
	send_command('bind !f9 gs c toggle AutoOffenseMode')
	send_command('bind f10 gs c set DefenseMode Active')
	send_command('bind ^f10 gs c cycle ActiveDefenseMode')
	send_command('bind !f10 gs c reset DefenseMode')
	send_command('bind f11 gs c cycle PetDamageTakenMode')
	send_command('bind !f11 gs c reset PetDamageTakenMode')
	send_command('bind ^f12 gs c toggle Kiting')
	send_command('bind !f12 gs c toggle Twilight')
	send_command('bind home gs c cycle weapon_list')
	select_default_macro_book(1, 3)
	
	get_main_hand()
	get_combat_form()
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
	send_command('unbind Home')	
end


-- Define sets and vars used by this job file.

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	Brigantia = {}
	Brigantia.STR = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken -10%'}}
	Brigantia.DEX = { name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken -10%'}}
	Brigantia.STP = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Store TP"+10',}}
	Brigantia.WSD = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	Brigantia.Crit = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Critical hit rate +10%',}}
	
	Valorus = {}
	Valorus.Head = {}
	Valorus.Head.WSD = {name="Valorous Mask", augments={'Attack+19','Weapon skill damage +4%','AGI+5',}}
	Valorus.Body = {}
	Valorus.Body.STP = {name="Valorous Mail", augments={'Accuracy+19','"Store TP"+6','STR+7','Attack+8',}}
	Valorus.Body.DA = { name="Valorous Mail", augments={'Accuracy+13','"Dbl.Atk."+5','VIT+10',}}
	Valorus.Body.WSD = { name="Valorous Mail", augments={'"Mag.Atk.Bns."+14','"Store TP"+1','Weapon skill damage +7%','Accuracy+16 Attack+16',}}
	Valorus.Legs = {}
	Valorus.Legs.TP = { name="Valorous Hose", augments={'Accuracy+28','"Store TP"+7','VIT+3','Attack+10',}}
	Valorus.Legs.WS = { name="Valor. Hose", augments={'Attack+24','Weapon skill damage +4%','AGI+13','Accuracy+13',}}
	
	Acro = {}
	Acro.Hands = {}
	Acro.Hands.STP = {name="Acro Gauntlets", augments={'STR+7 DEX+7', 'Accuracy+19 Attack+19', '"Store TP"+6'}}
	
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Angon = {ammo="Angon",ear1="Dragoon's Earring",hands="Pteroslaver Finger Gauntlets +1"}
   
    sets.CapacityMantle = { back="Mecistopins Mantle" }
    sets.WSDayBonus     = { head="Gavialis Helm" }

	sets.precast.JA['Jump'] = {
	    sub="Utu Grip",
        ammo="Ginsen",
		head="Flamma Zucchetto +2",
        neck="Anu Torque",
        ear1="Telos Earring",
        ear2="Sherida Earring",
		body="Ptero. Mail +3",
        ring1="Petrov Ring",
        ring2="Niqmaddu Ring",
		back=Brigantia.STP,
		waist="Ioskeha Belt +1",
        legs="Ptero. Brais +3",     
		hands="Vishap F. G. +3",
		feet="Ostro Greaves"
    }
	sets.precast.JA['Ancient Circle'] = { legs="Vishap Brais +3" }

	sets.precast.JA['High Jump'] = set_combine(sets.precast.JA['Jump'] , { }) 
	sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA['Jump'] , {
		body="Vishap Mail +2",		
		hands=Acro.Hands.STP
    })
	sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA['Jump'] , { feet="Peltast's Schynbalds +1" })
	sets.precast.JA['Spirit Link'] = {
        hands="Peltast's Vambraces", 
        head="Vishap Armet",
		feet="Pteroslaver Greaves +3"
    }
	sets.precast.JA['Call Wyvern'] = {body="Pteroslaver Mail +3"}
	sets.precast.JA['Deep Breathing'] = {head="Petroslaver Armet +3"}
	sets.precast.JA['Spirit Surge'] = {body="Pteroslaver Mail +3"}
	
	-- Healing Breath sets
	sets.HB = 
		{     
			head="Ptero. Armet +3", neck="Adad Amulet", lear="Enmerkar Earring",
			body="Acro Surcoat", hands="Despair Finger Gauntlets", 
			back="Updraft Mantle", waist="Incarnation Sash", feet="Acro Leggings"	
		}

	sets.OB = 
		{     
			head="Ptero. Armet +3", neck="Adad Amulet", lear="Enmerkar Earring",
			body="Acro Surcoat", hands="Despair Finger Gauntlets", 
			back="Updraft Mantle", waist="Incarnation Sash", feet="Acro Leggings"
		}
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {  }
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	sets.precast.FC = {  }
    
	-- Midcast Sets
	sets.midcast.FastRecast = {   }	
		
	sets.midcast.Breath = set_combine(sets.midcast.FastRecast, { 
	head="Ptero. Armet +3", neck="Adad Amulet", lear="Enmerkar Earring",
	body="Acro Surcoat", hands="Despair Finger Gauntlets", 
	back="Updraft Mantle", waist="Incarnation Sash", legs='Acro Breeches', feet="Acro Leggings"})
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined

	sets.precast.WS = {
		sub="Utu Grip",
		ammo="Knobkierrie",
		head="Pteroslaver Armet +3",
		body="Pteroslaver Mail +3",
		hands="Ptero. Fin. G. +3",
		legs="Sulevia's Cuisses +2",
		feet="Sulevia's Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Telos Earring",
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back=Brigantia.WSD }
		
	sets.precast.WS.Max = set_combine(sets.precast.WS, {    })
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {	})
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {body="Dagon Breastplate", lear='Moonshade Earring', rear='Sherida Earring',hands="Sulevia's Gauntlets +2", legs='Nyame Flanchard',feet="Lustratio Leggings +1", back=Brigantia.STR})
	
	sets.precast.WS['Stardiver'].Max = set_combine(sets.precast.WS, 
		{ammo="Crepsecular Pebble", 
		head="Flamma Zucchetto +2",
		neck="Dragoon's Collar +2", 
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		ear1="Moonshade Earring",
		ear2="Sherida Earring",
		legs="Gleti's Greaves",
		feet='Flamma Gambieras +2', 
		back=Brigantia.STR})
	
	sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS['Stardiver'], { })
	
    sets.precast.WS["Camlann's Torment"] = set_combine(sets.precast.WS, {head=Valorus.Head.WSD, body=Valorus.Body.WSD, ear1="Ishvara Earring", ear2="Sherida Earring", ring1="Karieyh Ring", legs="Vishap Brais +3"})
	sets.precast.WS["Camlann's Torment"].Max = set_combine(sets.precast.WS["Camlann's Torment"], { })
	sets.precast.WS["Camlann's Torment"].Acc = set_combine(sets.precast.WS["Camlann's Torment"], { })

	sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {	neck="Dragoon's Collar +2", ear2='Brutal Earring', body="Hjarrandi Breastplate",hands="Flamma Manopolas +2", ring1="Begrudging Ring", waist="Ioskeha Belt +1",  feet="Thereoid Greaves", Brigantia.Crit })
	sets.precast.WS['Drakesbane'].Max = set_combine(sets.precast.WS['Drakesbane'], {  })
	sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS['Drakesbane'], {   })
	
	sets.precast.WS['Geirskogul'] = set_combine(sets.precast.WS, {
		lear="Ishvara Earring", rear="Sherida Earring",
		ring1="Karieyh Ring", legs = "Vishap Brais +3",
		back=Brigantia.DEX	})
	sets.precast.WS['Geirskogul'].Max = set_combine(sets.precast.WS['Geirskogul'], { })
	sets.precast.WS['Geirskogul'].Acc = set_combine(sets.precast.WS['Geirskogul'], { })
	
	sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {head="Ptero. Armet +3", body="Dagon Breastplat", neck="Dgn. Collar +2", ear1="Moonshade Earring", ear2="Sherida Earring", ring1="Epaminondas's Ring", waist="Sailfi Belt +1"})
	sets.precast.WS['Impulse Drive'].Max = 	set_combine(sets.precast.WS['Impulse Drive'], {head="Gleti's Mask", body="Gleti's Cuirass", hands="Gleti's Gauntlets", legs="Gleti's Greaves", feet="Gleti's Boots" })
	sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS['Impulse Drive'], { })
	
	sets.precast.WS['Sonic Thrust'] = set_combine(sets.precast.WS["Camlann's Torment"], {lear="Moonshade Earring"})
	
	
	sets.precast.WS['Savage Blade'] =  { ammo="Knobkierrie",
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands={ name="Ptero. Fin. G. +3", augments={'Enhances "Angon" effect',}},
		legs="Gleti's Greaves",
		feet="Sulev. Leggings +2",
		neck={ name="Dgn. Collar +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring",
		back=Brigantia.WSD}
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {    }	

	-- Idle sets
	sets.idle = {
		ammo="Ginsen",
		head="Sulevia's Mask +2",
		body="Sulevia's Platemail +2",
		hands="Sulevia's Gauntlets +2",
		feet="Sulevia's Leggings +2",
		neck="Asperity Necklace",
		waist="Nierenschutz",
		left_ear="Telos Earring",
		right_ear="Brutal Earring",
		left_ring="Rajas Ring",
		right_ring="Chirich Ring +1",
		back="Brigantia's Mantle"}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle.Town = set_combine(sets.idle,{ body="Councilor's Garb", legs="Carmine Cuisses +1" })		
	
	sets.idle.Field = set_combine(sets.idle.Town, {
	    ammo="Staunch Tathlum",
		head="Valorous Mask",
		body="Hjarrandi Breastplate",
		hands="Sulevia's Gauntlets +2",
		legs="Carmine Cuisses +1",
		feet="Sulevia's Leggings +2",
		neck="Dragoon's Collar +2",
		ring2="Karieyh Ring",
		ring1="Defending Ring",
		back=Brigantia.STR})
	
	sets.idle.Field.PetHP = set_combine(sets.idle.Field,
		{neck="Dragoon's Collar +2", 
		body="Vishap Mail +3",
		hands="Despair Fin. Gaunt.",
		legs="Vishap Brais +3",
		feet="Pteroslaver Greaves +3",
		back="Updraft Mantle"
		})	
	
	sets.idle.Weak = set_combine(sets.idle, { })
	
	sets.Kiting = { legs="Carmine Cuisses +1" }
	sets.Twilight = {head="Twilight Helm",body="Twilight Mail"}

	-- Engaged sets
	-- sets.engaged[state.CombatForm][state.CombatWeapon][state.OffenseMode][state.HybridMode][classes.CustomMeleeGroups (any number)]
	-- With a max-level Wyvern + Hasso + capped Magic Haste you only need 17% gear haste to achieve capped delay.
	
	--=============================================================================================================
	-- Normal melee group		
	sets.engaged = {sub="Utu Grip",
		ammo="Ginsen",
		head="Flamma Zucchetto +2",
		body=Valorus.Body.STP,
		hands=Acro.Hands.STP,
		legs=Valorus.Legs.TP,
		feet="Flam. Gambieras +2",
		neck="Anu Torque",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Petrov Ring",
		right_ring="Niqmaddu Ring",
		back=Brigantia.STR }
	sets.engaged.NoPet = {} --Loss of Wyvern, add more attack and haste.
	sets.engaged.Buffed = {}
	sets.engaged.Acc = {}
	sets.engaged.Mid = {}	
	sets.engaged.Turtle = {}	
	
	--=============================================================================================================
	--Trishula
	sets.engaged['Trishula'] = {
		main="Trishula",
		sub="Utu Grip",
		ammo="Coiste Bodhar",
		head="Flamma Zucchetto +2",
		body=Valorus.Body.STP,
		hands=Acro.Hands.STP,
		legs="Pteroslaver Brais +3",
		feet="Flam. Gambieras +2",
		neck="Anu Torque",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Petrov Ring",
		right_ring="Niqmaddu Ring",
		back=Brigantia.STR }
		
	sets.engaged.NoPet['Trishula'] = {}
	
	--Capped Magical Haste
	sets.engaged['Trishula'].Min = set_combine(sets.engaged['Trishula'],{
		body='Hjarrandi Breastplate'
		})
		
	sets.engaged['Trishula'].Max = set_combine(sets.engaged['Trishula'],{
		head="Hjarrandi Helm",
		body="Gleti's Cuirass",
		legs=Valorus.Legs.TP})
	
	--Attack/Accuracy Starved set. Usually if you need one, you also the need other.
	sets.engaged['Trishula'].Acc = {}
	
	--Defense sets.
	sets.engaged['Trishula'].Mid = {}
	sets.engaged['Trishula'].Turtle	 = {}
	
	--=============================================================================================================
	--Shining One
	sets.engaged['Shining One'] = {
		main="Shining One",
		sub="Utu Grip",
		ammo="Aurgelmir Orb +1",
		head="Flamma Zucchetto +2",
		body=Valorus.Body.STP,
		hands=Acro.Hands.STP,
		legs=Valorus.Legs.TP,
		feet="Flam. Gambieras +2",
		neck="Anu Torque",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Petrov Ring",
		right_ring="Niqmaddu Ring",
		back=Brigantia.STR }
		
	sets.engaged.NoPet['Shining One'] = {}
	
	--Capped Magical Haste
	sets.engaged['Shining One'].Min = set_combine(sets.engaged['Shining One'],{
		body='Hjarrandi Breastplate'
		})
		
	sets.engaged['Shining One'].Max = set_combine(sets.engaged['Shining One'],{
		head="Hjarrandi Helm",
		body="Gleti's Cuirass",
		legs=Valorus.Legs.TP})
	
	--Attack/Accuracy Starved set. Usually if you need one, you also the need other.
	sets.engaged['Shining One'].Acc = {}
	
	--Defense sets.
	sets.engaged['Shining One'].Mid = {}
	sets.engaged['Shining One'].Turtle	 = {}
	
	--===========================================================================================================
	--Ryunohige
	

	sets.engaged['Ryunohige'] = {
		main='Ryunohige', sub='Utu Grip',
	}
	sets.engaged['Ryunohige'].AM3 = {}
	
	sets.engaged.NoPet['Ryunohige'] = {}	
	
	sets.engaged['Ryunohige'].AM3 = {}
	sets.engaged['Ryunohige'].Max = {}	
	sets.engaged['Ryunohige'].Max.AM3 = {}	
	sets.engaged['Ryunohige'].Acc = {}
	
	
	sets.engaged['Ryunohige'].Mid = {}
	sets.engaged['Ryunohige'].Turtle = {}
	
	--===================================================================================================
	--Rhongomiant
	sets.engaged['Rhongomiant'] = {
		main='Rhongomiant', sub='Utu Grip',
		ammo="Ginsen",
		head="Flamma Zucchetto +2",
		body=Valorus.Body.STP,
		hands=Acro.Hands.STP,
		legs=Valorus.Legs.TP,
		feet="Flam. Gambieras +2",
		neck="Anu Torque",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Petrov Ring",
		right_ring="Niqmaddu Ring",
		back=Brigantia.STR 	}
		
	sets.engaged['Rhongomiant'].AM2 = {	
		main='Rhongomiant', sub='Utu Grip',
		ammo='Focal Orb',
		head='Flamma Zucchetto +2',
		neck='Dgn. Collar +2',
		lear='Brutal Earring',
		rear='Sherida Earring',
		body='Hjarrandi Breastplate',
		hands="Sulevia's Gauntlets +2",
		lring='Petrov Ring',
		rring='Niqmaddur Ring',
		back=Brigantia.DEX,
		waist='Ioskeha Belt',
		legs="Sulevia's Cuisses +2",
		feet='Flamma Gambieras +2'		
	}
	sets.engaged['Rhongomiant'].AM3 = set_combine(sets.engaged['Rhongomiant'].AM2,{})
	
	sets.engaged.NoPet['Rhongomiant']= {}
	
	sets.engaged.NoPet['Rhongomiant'].AM2 = {}
	sets.engaged.NoPet['Rhongomiant'].AM3 = set_combine(sets.engaged.NoPet['Rhongomiant'].AM2,{})
	
	sets.engaged['Rhongomiant'].Max = {}
	sets.engaged['Rhongomiant'].Max.AM2 = {}
	sets.engaged['Rhongomiant'].Max.AM3 = {}
	sets.engaged['Rhongomiant'].Acc = {}
	sets.engaged['Rhongomiant'].Mid = {}
	sets.engaged['Rhongomiant'].Turtle = {}
	
		--===================================================================================================
	--Naegling
	sets.engaged['Naegling'] = {
		main='Naegling',
		ammo="Aurgelmir Orb +1",
		head="Flamma Zucchetto +2",
		body="Dagon Breast.",
		hands="Sulev. Gauntlets +2",
		legs="Ptero. Brais +3",
		feet="Flam. Gambieras +2",
		neck="Ganesha's Mala",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Petrov Ring",
		right_ring="Niqmaddu Ring",
		back=Brigantia.STR }
		
	
	sets.engaged.NoPet['Naegling']= {}
	
	--Capped Magical Haste
	sets.engaged['Naegling'].Min = set_combine(sets.engaged['Naegling'],{
		body='Hjarrandi Breastplate'
		})
		
	sets.engaged['Shining One'].Max = set_combine(sets.engaged['Naegling'],{
		head="Hjarrandi Helm",
		body="Gleti's Cuirass",
		legs=Valorus.Legs.TP})
		
	sets.engaged['Naegling'].Acc = {}
	sets.engaged['Naegling'].Mid = {}
	sets.engaged['Naegling'].Turtle = {}
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
	if player.hpp < 51 then
		classes.CustomClass = "Breath" 
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
	    equip(sets.midcast.FastRecast)
	    if player.hpp < 51 then
		    classes.CustomClass = "Breath" 
	    end
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
end

function job_pet_precast(spell, action, spellMap, eventArgs)
	if OffensiveBreaths:contains(spell.english) and not midaction() then
		equip(sets.OB)
	end
end
-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)
    if spell.english:startswith('Healing Breath') or spell.english == 'Restoring Breath' then
		equip(sets.HB)
	elseif OffensiveBreaths:contains(spell.english) then
		equip(sets.OB)
	end
end

-- Run after the default pet midcast() is done.
-- eventArgs is the same one used in job_pet_midcast, in case information needs to be persisted.
function job_pet_post_midcast(spell, action, spellMap, eventArgs)
	
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	
end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_aftercast(spell, action, spellMap, eventArgs)

end

-- Run after the default pet aftercast() is done.
-- eventArgs is the same one used in job_pet_aftercast, in case information needs to be persisted.
function job_pet_post_aftercast(spell, action, spellMap, eventArgs)

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
end
function job_state_change(field, new_value, old_value)
	if field == 'Current Weapon' then	
		state.CombatWeapon:Set(new_value)	
		equip({main=new_value, sub=offhand_list[new_value] or empty})
	end
	get_combat_form()
end

-- Called when the player's pet's status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
	if not pet.isvalid then		
		state.CombatForm:set('NoPet')
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	else
		state.CombatForm:reset()
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	end
end

function job_pet_change(petparam, gain)
	if not pet.isvalid then		
		state.CombatForm:set('NoPet')
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	else
		state.CombatForm:reset()
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff:contains("Aftermath") then
		get_combat_form()
	elseif S{'haste', 'march', 'minuet', 'mighty guard', 'embrava', 'geo-haste', 'indi-haste', 'chaos roll', 'samurai roll'}:contains(buff:lower()) then
		--add_to_chat(155, buff)
		get_offense_mode()
		--send_command("input /echo "..buff.." "..tostring(gain))
		if not midaction() then
			handle_equipping_gear(player.status)
		end	
	elseif buff == 'Hasso' and not gain then
		check_hasso()
	end
end

function job_update(cmdParams, eventArgs)

	get_combat_form()
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
	
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
function get_main_hand()
	local mainhand = player.equipment.main
	
	if state.weapon_list:contains(mainhand) then
		state.weapon_list:set(mainhand)
	end
end

--DRG is weird in that it can cap weapon delay with a Wyvern + Magic Haste + Hasso + non-capped Gear haste
--We can also effectively increase our potential DPS by varying what gear we have based on what buffs are present
function get_offense_mode()
	if state.AutoOffenseMode.value == true then
		local hstCount = 0
		if buffactive[580] then hstCount = hstCount+1 end --indi: haste
		if buffactive[33] then hstCount = hstCount+1 end --Haste
		if buffactive[604] then hstCount = hstCount+1 end --Mighty Guard
		if buffactive.march then hstCount = hstCount+buffactive.march end --March
		
		--IF we're not set to Acc mode
		--We can safely assume that if we have 2 of any haste type, we're capped on magical haste
		if state.OffenseMode.value ~='Acc' then			
			if hstCount >= 2 and pet.isValid and player.hpp > 0 then 
				local atkCount = 0
				if buffactive[317] then atkCount = atkCount+1 end 	 --Chaos Roll
				if buffactive[198] then					--Minuet
					if buffactive[198]>=2 then atkCount = atkCount+2 
					else atkCount = atkCount+1 end
				end
				if buffactive[549] then atkCount = atkCount+1 end	 --Indi: Fury?
				
				if atkCount > 2 then
					state.WeaponskillMode:set('Max')
					
					if buffactive[321] then --Samurai Roll
						state.OffenseMode:set('Max')
					else 
						state.OffenseMode:set('Min') 
					end
				else
					state.OffenseMode:set('Min')
					state.WeaponskillMode:reset()
				end
			else
				state.OffenseMode:reset()
				state.WeaponskillMode:reset()			
			end		
		end  	 
	end
end
function check_hasso()
	--if Hasso isnt up, and we're not in town and not dead, charmed, stunned, etc. put it back up
	if player.sub_job == 'SAM' and not (player.equipment.main == '' or one_handed_list:contains(player.equipment.main)) and not buffactive[353] and not areas.Cities:contains(world.area)then
	if not midaction() and not (buffactive[566] or buffactive[16] or buffactive[0] or buffactive[28] or buffactive[10] or buffactive[157] or buffactive[14] or buffactive[17] or buffactive[69])then
			send_command("input /ja Hasso <me>")
		end
	end 
end
function get_aftermath()
	if buffactive[272] then
		classes.CustomMeleeGroups:append("AM3")
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
	local msg = 'Weapon: '..state.weapon_list.value..', Melee: '.. state.OffenseMode.value
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', Defense: ' .. state[state.DefenseMode.value .. 'DefenseMode'].value 
    end
	
    if pet.isvalid then 
		msg = msg .. ', ' .. pet.name ..': '.. pet.hpp..'%'
	else
		msg = msg ..', NO PET'
	end 
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end
	
    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
            equip(sets.buff[buff_name] or {})        
        eventArgs.handled = true
    end
end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book(page, book)
    set_macro_page(page, book)
end