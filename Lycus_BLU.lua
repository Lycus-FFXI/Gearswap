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
	
	Ishvara_Skills = S{'Expiacion', 'Savage Blade'}
	
	weapon_list = S{'Tizona', 'Almace'}
	current_weapon = ""
	
	state.Buff = {}	
end

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Acc') --Normal, Acc/Atk Starved
	state.CastingMode:options('Normal', 'Acc') --Normal, Acc/Atk Starved
	state.WeaponskillMode:options('Normal', 'Hi', 'Acc') 
    state.DefenseMode:options('None', 'Active')
	state.ActiveDefenseMode = M{['description'] = 'Damage Taken Mode', 'DT', 'Turtle'}	
	
	send_command('bind f9 gs c cycle OffenseMode')
	send_command('bind ^f9 gs c cycle CastingMode')
	send_command('bind f10 gs c set DefenseMode Active')
	send_command('bind ^f10 gs c cycle ActiveDefenseMode')	
	send_command('bind !f10 gs c reset DefenseMode')
	send_command('bind f11 gs c cycle WeaponskillMode')
	send_command('bind ^f12 gs c toggle Kiting')
	
	map_spells()
	
	select_default_macro_book(10, 7)	
	get_combat_form()
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
	send_command('unbind f9')
	send_command('unbind ^f9')
	send_command('unbind f10')
	send_command('unbind ^f10')
	send_command('unbind !f10')
	send_command('unbind ^f11')
	send_command('unbind f12')
	send_command('unbind ^f12')
	send_command('unbind !f12')
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	--===========================================================[AUGMENTED ITEMS]===========================================================
	AdhemarJacket = {}
	AdhemarJacket.Acc = { name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
	AdhemarJacket.Atk = { name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}}
	
	CarmineMask = {}
	CarmineMask.FC = { name = "Carmine Mask +1", augments = { 'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4', } }
	
    HerculeanHelm = {}
	HerculeanHelm.TA = {}
    HerculeanHelm.WSD = { name = "Herculean Helm",augments={'Accuracy+27','Weapon skill damage +4%',}}
	
    HerculeanVest = {}
    HerculeanVest.CDC  = { name="Herculean Vest", augments={'Weapon skill damage +5%','Accuracy+4','Crit.hit rate+5','Accuracy+10 Attack+10','Mag. Acc.+2 "Mag.Atk.Bns."+2',}}
	HerculeanVest.TA = { name="Herculean Vest", augments={'Accuracy+23 Attack+23','"Triple Atk."+4','DEX+2',}}
    
    TaeonBody = {}
    TaeonBody.SIR = {name="Taeon Tabard", augments = {'Spell interruption rate down -8%','STR+7 VIT+7'} }
    
	AdhemarWrists = {}
	AdhemarWrists.Atk = { name="Adhemar Wrist. +1", augments = {'STR+12','DEX+12','Attack+20',} }
	AdhemarWrists.Acc = { name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',} }
	
    HerculeanGloves = {}
    HerculeanGloves.WSD = { name = "Herculean Gloves", augments = { 'Accuracy+21 Attack+21', 'Weapon skill damage +4%', 'Accuracy+9', 'Attack+10', } }
  
    HerculeanLegs = {}
    HerculeanLegs.WSD = { name = "Herculean Trousers", augments = { 'Attack+28', 'Weapon skill damage +3%', 'STR+10', 'Accuracy+9', } }
	
    HerculeanFeet = {}
    HerculeanFeet.QA = { name = "Herculean Boots", augments = { 'AGI+4', '"Dbl.Atk."+2', 'Quadruple Attack +3', 'Accuracy+4 Attack+4', } }
    HerculeanFeet.TA = {name="Herculean Boots", augments={'Accuracy+25','"Triple Atk."+4','STR+3','Attack+10',}}
    HerculeanFeet.DT = { name = "Herculean Boots", augments = { 'Accuracy+23', 'Damage taken -3%' } }
    HerculeanFeet.Idle = { name = "Herculean Boots", augments = { 'Crit. hit damage +1%','STR+10','"Refresh"+2','Accuracy+15 Attack+15','Mag. Acc.+17 "Mag.Atk.Bns."+17', } }
    HerculeanFeet.CritDmg = { name = "Herculean Boots", augments = { 'Accuracy+28', 'Crit. hit damage +5%', 'DEX+9' } }
    HerculeanFeet.WSD = { name="Herculean Boots", augments={'Accuracy+27','Weapon skill damage +3%','AGI+13',}}
    HerculeanFeet.DW = { name = "Herculean Boots", augments = { 'Accuracy+3 Attack+3','"Dual Wield"+4','AGI+3','Accuracy+14', } }
    HerculeanFeet.Phalanx = { name = "Herculean Boots", augments = { '"Store TP"+1','INT+10','Phalanx +3','Accuracy+16 Attack+16','Mag. Acc.+19 "Mag.Atk.Bns."+19' } }
    HerculeanFeet.TH = { name="Herculean Boots", augments = { 'Phys. dmg. taken -2%','Pet: Phys. dmg. taken -2%','"Treasure Hunter"+2','Accuracy+16 Attack+16','Mag. Acc.+18 "Mag.Atk.Bns."+18', } }
    
    Rosmerta = {}
    Rosmerta.Crit = { name = "Rosmerta's Cape", augments = { 'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10', } }
    Rosmerta.WSD = { name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10', } }
    Rosmerta.STP = {name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+4','"Store TP"+10','Damage taken-5%', } }
    Rosmerta.DA = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',} }
    Rosmerta.DW = { name = "Rosmerta's Cape", augments = { 'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%', } }
	Rosmerta.FC = { name = "Rosmerta's Cape", augments = { 'Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc+10','"Fast Cast"+10%' } }
    Rosmerta.Nuke = { name = "Rosmerta's Cape", augments = { 'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10', } }
    Rosmerta.Cure = { name = "Rosmerta's Cape", augments = { 'MND+20','Eva.+20 /Mag. Eva.+20','"Cure" potency +10%' } }
    Rosmerta.MagicEva = { name = "Rosmerta's Cape", augments = { 'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Mag. Evasion+15' } }
    
	--===========================================================[Precast/Buff]===========================================================

	sets.Enmity = {
        ammo = "Sapience Orb",
        ear1 = "Friomisi Earring",
        ear2 = "Cryptic Earring",
        body = "Emet Harness +1",
        ring1 = "Supershear Ring",
        ring2 = "Eihwaz Ring",
        back = "Reiki Cloak",
        waist = "Kasiri Belt",
        legs = "Obatala Subligar",
        Feet = "Ahosi Leggings"}
	
    sets.Buff = {}
	sets.Buff['Chain Affinitty'] = {}
	sets.Buff['Burst Affinity'] = {}
	sets.Buff['Efflux'] = {}
	
	sets.precast.JA['Azure Lore'] = {}
	sets.precast.JA['Diffusion'] = {}
	
    sets.precast.JA.Provoke = set_combine(sets.Enmity, {})

    sets.precast.JA.Warcry = set_combine(sets.Enmity, {})
	
	sets.precast.FC = { 
	    head="Carmine Mask +1",
		body="Luhlaza Jubbah +3",
		hands="Leyline Gloves",
		legs="Enif Cosciales",
		feet="Carmine Greaves +1",
		waist="Witful Belt",
		left_ear="Loquac. Earring",right_ear="Etiolation Earring",
		left_ring="Kishar Ring",
		right_ring="Prolix Ring",
		back=Rosmerta.FC}
	
	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {
       body = "Hashishin Mintan +2"
    })
	
	sets.precast.FC['Stoneskin'] = {}
	
	--===========================================================[WEAPON SKILLS]===========================================================

	sets.precast.WS = {}
	
	--Sword WS
	sets.precast.WS['Expiacion'] = {
	     ammo="Aurgelmir Orb +1",
		 head='Nyame Helm',neck="Mirage Stole +2",ear2="Ishvara Earring",ear1="Moonshade Earring",
		 body="Assimilator's Jubbah +3",hands="Nyame Gauntlets",ring1="Epaminondas's Ring",ring2="Karieyh Ring",
		 back=Rosmerta.WSD,waist="Sailfi Belt +1",legs="Luhlaza Shalwar +3",feet='Nyame Sollerets'}
		 
	sets.precast.WS['Expiacion'].Hi = set_combine(sets.precast.WS['Expiacion'],{
	     ammo="Crepuscular Pebble",body="Gleti's Cuirass",legs="Gleti's Breeches"})
	
	sets.precast.WS['Chant du Cygne'] = {
	     ammo="Aurgelmir Orb +1",
		head="Adhemar Bonnet +1",neck="Mirage Stole +2",rear="Brutal Earring",lear="Telos Earring",
		body="Abnoba Kaftan",hands=AdhemarWrists.Atk,ring1="Begrudging Ring",ring2="Ilabrat ring",
		back=Rosmerta.Crit,waist="Fotia Belt",legs="Samnuha Tights",feet="Thereoid greaves"}
	
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS['Expiacion'],{})
	
	sets.precast.WS['Sanguine Blade'] = {
		 ammo="Pemphredo Tathlum",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Jhakri Cuffs +2",
    legs="Luhlaza Shalwar +3",
    feet="Nyame Sollerets", 
    neck="Sanctity Necklace",
    waist="Orpheus's Sash",
    left_ear="Regal Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Epaminondas's Ring",
    back=Rosmerta.Nuke}
	
	sets.precast.WS['Red Lotus Blade'] = set_combine(sets.precast.WS['Sanguine Blade'],{})
	
	sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.WS['Sanguine Blade'],{})
	
	sets.precast.WS['Circle Blade'] = set_combine(sets.precast.WS,{})
	
	sets.precast.WS['Requiescat'] = {
	  head="Despair Helm",neck="Fotia Gorget",ear1="Steelflash earring",ear2="Bladeborn earring",
	  body="Rawhide Vest",hands=AdhemarWrists.Atk,ring1="Rufescent Ring", ring2="Karieyh Ring",
	  back=Rosmerta.DA,waist="Fotia Belt",legs="Quiahuiz Trousers",feet="Hagondes sabots"}
	
	--Club WS
	sets.precast.WS['Black Halo'] = {  
		ammo = "Floestone",
        head = HerculeanHelm.WSD,
        neck = "Mirage Stole +2",
        ear1 = "Moonshade Earring",
        ear2 = "Regal Earring",
        body = "Assim. Jubbah +3",
        hands = "Jhakri Cuffs +2",
        ring1 = "Rufescent Ring",
		ring2 = "Karieyh Ring +1",
        back = Rosmerta.WSD,
        waist = "Prosilio Belt +1",
        legs = "Luhlaza Shalwar +3",
        feet = HerculeanFeet.WSD}
	
	--===========================================================[Midcast]===========================================================
	sets.midcast['Blue Magic'] = {body="Malignance Tabard"}
	sets.midcast['BluePhysical'] = {body="Assimilator's Jubbah +3"}
	sets.midcast['PhysicalSTR'] = set_combine(sets.midcast['BluePhysical'],{})
	sets.midcast['PhysicalDEX'] = set_combine(sets.midcast['BluePhysical'],{})
	sets.midcast['PhysicalVIT'] = set_combine(sets.midcast['BluePhysical'],{})
	sets.midcast['PhysicalAGI'] = set_combine(sets.midcast['BluePhysical'],{})
	
	sets.midcast['BlueMagical'] =
	{ammo="Pemphredo Tathlum",
	  head="Amalric Coif +1",neck="Sanctity Necklace", ear1="Regal Earring", ear2="Friomisi Earring",
	  body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Strendu Ring",
	  back="Cornflower Cape",waist="Orpheus's Sash",legs="Luhlaza Shalwar +3",feet="Amalric Nails +1"}
	
	sets.midcast['MagicalINT'] = { ammo="Pemphredo Tathlum",
	  head="Jhakri Coronal +2",neck="Sanctity Necklace", ear1="Regal Earring", ear2="Friomisi Earring",
	  body="Hashishin Mintan +2",hands="Hashishin Bazubands +2",ring1="Shiva Ring +1",ring2="Acumen Ring",
	  back="Cornflower Cape",waist="Orpheus's Sash",legs="Luhlaza Shalwar +3",feet="Amalric Nails +1"}
	  
	sets.midcast['MagicalINT'].Acc = {
		ammo="Hydrocera",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Ayanmo Gambieras +2",
		neck="Mirage Stole +2",
		waist="Salire Belt",
		left_ear="Lifestorm Earring",
		right_ear="Psystorm Earring",
		left_ring="Kishar Ring",
		right_ring="Stikini Ring",
		back="Cornflower Cape"}
	
	sets.midcast['BluACC'] = {
		ammo="Hydrocera",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Ayanmo Gambieras +2",
		neck="Mirage Stole +2",
		waist="Salire Belt",
		left_ear="Lifestorm Earring",
		right_ear="Psystorm Earring",
		left_ring="Kishar Ring",
		right_ring="Stikini Ring",
		back=Rosmerta.FC}
		
	sets.midcast['Breath'] = {}
	sets.midcast['BlueHP'] = {}
	
	sets.midcast['BlueSkill'] = {
		ammo="Mavi tathlum",
		ear1="Loquac. earring",
		body="Assimilator's Jubbah", hands="Rawhide Gloves",
		back="Cornflower cape",waist="Twilight Belt",legs="Hashishin Tayt"}
	
	sets.midcast['Cure'] = {
	  head="Herculean Helm",neck="Morgana's Choker",ear1="Loquac. earring",ear2="Star earring",
	  body="Telchine Chasuble",hands="Serpentes Cuffs",ring1="Sirona's Ring",ring2="Lebeche ring",
	  back="Solemnity cape",waist="Cascade Belt",legs="Praeco Slacks",feet="Serpentes Sabots"}
	
	sets.midcast['Curaga'] = {
	   head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	   body={ name="Despair Mail", augments={'STR+12','VIT+7','Haste+2%',}},
	   hands={ name="Telchine Gloves", augments={'"Dbl.Atk."+2',}},
	   legs="Gyve Trousers",
		feet={name="Medium's Sabots", augments={'MP+50','MND+8','"Conserve MP"+6','"Cure" potency +3%',}},
		left_ring="Stikini Ring",
		back="Solemnity Cape"
	}	
	sets.midcast['Stun'] = {
		ammo="Hydrocera",
		head="Carmine Mask +1",
		body="Luhlaza Jubbah +3",
		hands="Jhakri Cuffs +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Mirage Stole +2",
		waist="Salire Belt",
		left_ear="Lifestorm Earring",
		right_ear="Psystorm Earring",
		left_ring="Kishar Ring",
		right_ring="Stikini Ring",
		back=Rosmerta.FC}
	
	sets.midcast['Occultation']= {
        ammo = "Sapience Orb", --2%
        head = CarmineMask.FC, --14%
        neck = "Incanter's Torque",
        ear1 = "Loquac. Earring", --2%
        ear2 = "Etiolation Earring", --1%
        body = "Assim. Jubbah +3",
        hands = "Hashishin Bazubands +1",
        ring1 = "Kishar Ring", --4%
        ring2 = "Rahab Ring",
        back = Rosmerta.FC,
        waist = "Witful Belt", --3%
        legs = "Hashishin Tayt +1",
        feet = "Luhlaza Charuqs +3"
    }
	
	--White Wind
	sets.midcast['White Wind'] = {
	   head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	   body={ name="Despair Mail", augments={'STR+12','VIT+7','Haste+2%',}},
	   hands={ name="Telchine Gloves", augments={'"Dbl.Atk."+2',}},
	   legs="Gyve Trousers",
		feet={name="Medium's Sabots", augments={'MP+50','MND+8','"Conserve MP"+6','"Cure" potency +3%',}},
		left_ring="Stikini Ring",
		back="Solemnity Cape"
	}	
	sets.midcast['Battery Charge'] = set_combine(sets.midcast['BlueSkill'], {
        head = "Amalric Coif +1",
        waist = "Gishdubar Sash",
		back="Grapevine Cape"
    })
	
	sets.midcast['Utsusemi']={}
	
	sets.midcast['Enhancing Magic'] = {}
	sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'], {
        head = "Amalric Coif +1",
		legs = "Shedir Seraweels"
    })
	
	sets.midcast.FastRecast =	{ head="Carmine Mask +1",
		body="Luhlaza Jubbah +3",
		hands="Leyline Gloves",
		legs="Enif Cosciales",
		feet="Carmine Greaves +1",
		waist="Witful Belt",
		right_ear="Etiolation Earring",
		left_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Prolix Ring",
		back=Rosmerta.FC}
	
	--===========================================================[Idle]===========================================================	
	sets.idle = { head="Rawhide mask",neck="Mirage Stole +2", ear1="Ethereal earring", 
	  body="Hashishin Mintan +2",hands="Ayanmo Manopolas +2",ring1="Defending ring",ring2="Karieyh Ring",
	  back="Solemnity Cape",waist="Fucho-No-Obi",legs="Carmine Cuisses +1",feet="Ayanmo Gambieras +2"}
	
	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle.Town = set_combine(sets.idle,{ body="Councilor's Garb", legs="Carmine Cuisses +1"})		
	
	sets.idle.Field = set_combine(sets.idle.Town, {
	  head="Rawhide mask",neck="Mirage Stole +2", ear1="Ethereal earring", 
	  body="Jhakri Robe +2",hands="Ayanmo Manopolas +2",ring1="Defending ring",ring2="Karieyh Ring",
	  back="Solemnity Cape",waist="Fucho-No-Obi",legs="Carmine Cuisses +1",feet="Ayanmo Gambieras +2"})
	
	sets.idle.Field.DT = {
		ammo="Staunch Tathlum",
		head="Malignance Chapeau",neck="Loricate Torque", ear1="Ethereal earring", ear2="Odnowa Earring +1",
	    body="Hashishin Mintan +2",hands="Nyame Gauntlets",ring2="Dark ring",ring1="Defending Ring",
	    back="Moonbeam Cape",waist="Flume Belt",legs="Nyame Flanchard",feet="Malignance Boots"}
	sets.Kiting = { }
	--===========================================================[Engaged]===========================================================
	
	sets.engaged = {}
	sets.engaged.Acc = {}
	sets.engaged.DT = {}
	sets.engaged.Turtle = {}
	
	sets.engaged['Tizona'] = {main="Tizona", ammo="Ginsen",
		head="Adhemar Bonnet +1",neck="Mirage Stole +2", ear1="Telos Earring", ear2="Cessance Earring",
		body=AdhemarJacket.Acc,hands=AdhemarWrists.Acc,ring1="Epona's ring",ring2="Ilabrat ring",
		back=Rosmerta.DA,waist="Sailfi Belt +1",legs="Samnuha Tights",feet=HerculeanFeet.TA}
		
	sets.engaged['Tizona'].AM3 = set_combine(sets.engaged['Tizona'],{
	    head="Malignance Chapeau",
		neck = "Mirage Stole +2",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		waist="Reiki Yotai",
        back = Rosmerta.STP})
		
	sets.engaged['Tizona'].Acc = {main="Tizona",}
	sets.engaged['Tizona'].DT = {
		main="Tizona",ammo="Ginsen",
		head="Malignance Chapeau",
		neck = "Mirage Stole +2",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		waist="Flume Belt",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Defending Ring",
		right_ring="Ilabrat Ring",
		back=Rosmerta.DA}
	sets.engaged['Tizona'].Turtle = {main="Tizona",}	
	
	sets.engaged['Almace'] = {main="Almace", ammo="Ginsen",
		head="Adhemar Bonnet +1", neck="Mirage Stole +2", lear="Brutal Earring", rear="Cessance Earring",
		body=AdhemarJacket.Atk, hands=AdhemarWrists.Atk, ring1="Epona's Ring", ring2="Ilabrat Ring",
		back=Rosmerta.DA, waist="Windbuffet Belt", legs="Samnuha Tights", feet=HerculeanFeet.TA}
	
	sets.engaged['Almace'].Acc = {main="Almace", ammo="Ginsen",
		head="Adhemar Bonnet +1", neck="Mirage Stole +2", lear="Brutal Earring", rear="Cessance Earring",
		body=AdhemarJacket.Acc, hands=AdhemarWrists.Acc, ring1="Epona's Ring", ring2="Ilabrat Ring",
		back=Rosmerta.DA, waist="Windbuffet Belt", legs="Samnuha Tights", feet=HerculeanFeet.TA}
	
	sets.engaged['Almace'].DT = {main="Almace", ammo="Ginsen",
	head="Malignance Chapeau", neck="Mirage Stole +2", lear="Brutal Earring", rear="Cessance Earring",
	body="Malignance Tabard", hands=AdhemarWrists.Atk, ring1="Epona's Ring", ring2="Ilabrat Ring",
	back=Rosmerta.DA, waist='Reiki Yotai', legs="Samnuha Tights", feet="Malignance Boots"}
	sets.engaged['Almace'].Turtle = {main="Almace",}	
	
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

function job_post_precast(spell, action, spellMap, eventArgs)
	if Ishvara_Skills:contains(spell.english) and player.tp > 2000 then
		equip({ear1="Ishvara Earring"})
		add_to_chat(122, 'Equiped ISHVARA!')
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
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	return meleeSet
end

function customize_defense_set(defenseSet)
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
end
function job_state_change(field, new_value, old_value)
	get_combat_form()
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff:contains("Aftermath") then
		get_combat_form()
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	elseif buff:lower():contains("Doom") then
		if gain then
			send_command("input /p SOMEBODY SAVE ME! DOOM!")
		elseif not gain and not buffactive[0] then
			send_command("input /p No longer doomed.")
		end		
	elseif buff:lower():contains("charm") then
		if gain then
			send_command("input /p WATCH OUT, I'M CHARMED <3")
		elseif not gain and not buffactive[0] then
			send_command("input /p No longer charmed </3")		
		end
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
	if cmdParams[1]:lower() == "getweapon" then
		get_main_hand()
	end
end

function get_combat_form()	
	classes.CustomDefenseGroups:clear()
	classes.CustomIdleGroups:clear()
	classes.CustomMeleeGroups:clear()	

	get_main_hand()
	if state.DefenseMode.value ~= 'None' then	
		classes.CustomMeleeGroups:append(state.ActiveDefenseMode.value)
		classes.CustomIdleGroups:append(state.ActiveDefenseMode.value)	
	else
		get_aftermath()
	end
end



function get_main_hand()
	local mainhand = player.equipment.main
	
	if weapon_list:contains(mainhand) then
		if(current_weapon ~= mainhand) then
			current_weapon = mainhand
			add_to_chat(122, 'Combat Weapon Changed To '..mainhand)
			state.CombatWeapon:Set(mainhand)			
		
		end
	end
end

function get_aftermath()
	if buffactive[272] then
		classes.CustomMeleeGroups:append("AM3")
	end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
	local msg = 'Melee: '.. state.OffenseMode.value
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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
   set_macro_page(1, 7)
end
function map_spells()
	--=============================================================[Physical Spells]============================================================
	
	spell_maps['Asuran Claws']='BluePhysical'
	spell_maps['Bilgestorm']='BluePhysical'
	spell_maps['Bludgeon']='BluePhysical'
	spell_maps['Body Slam']='BluePhysical'
	spell_maps['Feather Storm']='BluePhysical'
	spell_maps['Mandibular Bite']='BluePhysical'
	spell_maps['Queasyshroom']='BluePhysical'
	spell_maps['Power Attack']='BluePhysical'
	spell_maps['Ram Charge']='BluePhysical'
	spell_maps['Saurian Slide']='BluePhysical'
	spell_maps['Screwdriver']='BluePhysical'
	spell_maps['Sickle Slash']='BluePhysical'
	spell_maps['Smite of Rage']='BluePhysical'
	spell_maps['Spinal Cleave']='BluePhysical'
	spell_maps['Spiral Spin']='BluePhysical'
	spell_maps['Sweeping Gouge']='BluePhysical'
	spell_maps['Terror Touch']='BluePhysical'
	spell_maps['Battle Dance']='BluePhysical'
	spell_maps['Bloodrake']='BluePhysical'
	spell_maps['Death Scissors']='BluePhysical'
	spell_maps['Dimensional Death']='BluePhysical'
	spell_maps['Empty Thrash']='BluePhysical'
	spell_maps['Quadrastrike']='BluePhysical'
	spell_maps['Uppercut']='BluePhysical'	
	spell_maps['Tourbillion']='BluePhysical'
	spell_maps['Thrashing Assault']='BluePhysical'
	spell_maps['Vertical Cleave']='BluePhysical'
	spell_maps['Whirl of Rage']='BluePhysical'
	spell_maps['Amorphic Spikes']='BluePhysical'
	spell_maps['Barbed Crescent']='BluePhysical'
	spell_maps['Claw Cyclone']='BluePhysical'
	spell_maps['Disseverment']='BluePhysical'
	spell_maps['Foot Kick']='BluePhysical'
	spell_maps['Frenetic Rip']='BluePhysical'
	spell_maps['Goblin Rush']='BluePhysical'
	spell_maps['Hysteric Barrage']='BluePhysical'
	spell_maps['Paralyzing Triad']='BluePhysical'
	spell_maps['Seedspray']='BluePhysical'
	spell_maps['Sinker Drill']='BluePhysical'	
	spell_maps['Vanity Dive']='BluePhysical'
	spell_maps['Cannonball']='BluePhysical'
	spell_maps['Delta Thrust']='BluePhysical'
	spell_maps['Glutinous Dart']='BluePhysical'
	spell_maps['Grand Slam']='BluePhysical'
	spell_maps['Quad. Continuum']='BluePhysical'
	spell_maps['Benthic Typhoon']='BluePhysical'	
	spell_maps['Helldive']='BluePhysical'
	spell_maps['Hydro Shot']='BluePhysical'
	spell_maps['Jet Stream']='BluePhysical'
	spell_maps['Pinecone Bomb']='BluePhysical'
	spell_maps['Wild Oats']='BluePhysical'
	spell_maps['Heavy Strike']='BluePhysical'

	
	--=============================================================[Physical STR]============================================================
	spell_maps['Asuran Claws']='PhysicalSTR'
	spell_maps['Bilgestorm']='PhysicalSTR'
	spell_maps['Battle Dance']='PhysicalSTR'
	spell_maps['Bludgeon']='PhysicalSTR'
	spell_maps['Bloodrake']='PhysicalSTR'
	spell_maps['Death Scissors']='PhysicalSTR'
	spell_maps['Dimensional Death']='PhysicalSTR'
	spell_maps['Empty Thrash']='PhysicalSTR'
	spell_maps['Quadrastrike']='PhysicalSTR'
	spell_maps['Uppercut']='PhysicalSTR'
	spell_maps['Tourbillion']='PhysicalSTR'
	spell_maps['Sinker Drill']='PhysicalSTR'
	spell_maps['Thrashing Assault']='PhysicalSTR'
	spell_maps['Vertical Cleave']='PhysicalSTR'
	spell_maps['Whirl of Rage']='PhysicalSTR'
	spell_maps['Saurian Slide']='PhysicalSTR'
	spell_maps['Spinal Cleave']='PhysicalSTR'
	spell_maps['Paralyzing Triad']='PhysicalSTR'

	
	--=============================================================[Physical DEX]============================================================
	
	spell_maps['Amorphic Spikes']='PhysicalDEX'
	spell_maps['Barbed Crescent']='PhysicalDEX'
	spell_maps['Claw Cyclone']='PhysicalDEX'
	spell_maps['Disseverment']='PhysicalDEX'
	spell_maps['Foot Kick']='PhysicalDEX'
	spell_maps['Frenetic Rip']='PhysicalDEX'
	spell_maps['Goblin Rush']='PhysicalDEX'
	spell_maps['Hysteric Barrage']='PhysicalDEX'
	spell_maps['Seedspray']='PhysicalDEX'
	spell_maps['Vanity Dive']='PhysicalDEX'

	--=============================================================[Physical VIT]============================================================
		
	spell_maps['Cannonball']='PhysicalVIT'
	spell_maps['Delta Thrust']='PhysicalVIT'
	spell_maps['Glutinous Dart']='PhysicalVIT'
	spell_maps['Grand Slam']='PhysicalVIT'
	spell_maps['Quad. Continuum']='PhysicalVIT'
	spell_maps['Sprout Smack']='PhysicalVIT'

	--=============================================================[Physical AGI]============================================================
	
	spell_maps['Benthic Typhoon']='PhysicalAGI'
	spell_maps['Helldive']='PhysicalAGI'
	spell_maps['Hydro Shot']='PhysicalAGI'
	spell_maps['Jet Stream']='PhysicalAGI'
	spell_maps['Pinecone Bomb']='PhysicalAGI'
	spell_maps['Wild Oats']='PhysicalAGI'
	spell_maps['Spiral Spin']='PhysicalAGI'

	
	--=============================================================[Blue Magical]============================================================
	spell_maps['Acrid Stream']='BlueMagical'
	spell_maps['Anvil Lightning']='BlueMagical'
	spell_maps['Crashing Thunder']='BlueMagical'
	spell_maps['Charged Whisker']='BlueMagical'
	spell_maps['Droning Whirlwind']='BlueMagical'
	spell_maps['Firespit']='BlueMagical'
	spell_maps['Foul Waters']='BlueMagical'
	spell_maps['Gates of Hades']='BlueMagical'
	spell_maps['Molting Plumage']='BlueMagical'
	spell_maps['Leafstorm']='BlueMagical'
	spell_maps['Magic Barrier']='BlueMagical'
	spell_maps['Nectarous Deluge']='BlueMagical'
	spell_maps['Polar Roar']='BlueMagical'
	spell_maps['Regurgitation']='BlueMagical'
	spell_maps['Rending Deluge']='BlueMagical'
	spell_maps['Scouring Spate']='BlueMagical'
	spell_maps['Searing Tempest']='BlueMagical'
	spell_maps['Silent Storm']='BlueMagical'
	spell_maps['Spectral Floe']='BlueMagical'
	spell_maps['Subduction']='BlueMagical'
	spell_maps['Sudden Lunge']='BlueMagical'
	spell_maps['Tem. Upheaval']='BlueMagical'
	spell_maps['Thermal Pulse']='BlueMagical'
	spell_maps['Thunderbolt']='BlueMagical'
	spell_maps['Uproot']='BlueMagical'
	spell_maps['Water Bomb']='BlueMagical'
	spell_maps['Atra. Libations']='BlueMagical'
	spell_maps['Blood Saber']='BlueMagical'
	spell_maps['Dark Orb']='BlueMagical'
	spell_maps['Death Ray']='BlueMagical'
	spell_maps['Eyes On Me']='BlueMagical'
	spell_maps['Blazing Bound']='BlueMagical'	
	spell_maps['Evryone. Grudge']='BlueMagical'
	spell_maps['Palling Salvo']='BlueMagical'
	spell_maps['Tenebral Crush']='BlueMagical'
	spell_maps['Blinding Fulgor']='BlueMagical'
	spell_maps['Diffusion Ray']='BlueMagical'
	spell_maps['Ice Break']='BlueMagical'
	spell_maps['Magic Hammer']='BlueMagical'	
	spell_maps['Rail Cannon']='BlueMagical'
	spell_maps['Retinal Glare']='BlueMagical'
	spell_maps['Embalming Earth']='BlueMagical'
	spell_maps['Entomb']='BlueMagical'
	spell_maps['Sandspin']='BlueMagical'
	spell_maps['Vapor Spray']='BlueMagical'
	
	--=============================================================[Magical INT]============================================================
	
	spell_maps['Acrid Stream']='MagicalINT'
	spell_maps['Anvil Lightning']='MagicalINT'
	spell_maps['Crashing Thunder']='MagicalINT'
	spell_maps['Charged Whisker']='MagicalINT'
	spell_maps['Droning Whirlwind']='MagicalINT'	
	spell_maps['Firespit']='MagicalINT'
	spell_maps['Foul Waters']='MagicalINT'
	spell_maps['Gates of Hades']='MagicalINT'
	spell_maps['Leafstorm']='MagicalINT'
	spell_maps['Molting Plumage']='MagicalINT'	
	spell_maps['Nectarous Deluge']='MagicalINT'
	spell_maps['Polar Roar']='MagicalINT'
	spell_maps['Regurgitation']='MagicalINT'
	spell_maps['Rending Deluge']='MagicalINT'
	spell_maps['Scouring Spate']='MagicalINT'		
	spell_maps['Searing Tempest']='MagicalINT'	
	spell_maps['Silent Storm']='MagicalINT'	
	spell_maps['Spectral Floe']='MagicalINT'	
	spell_maps['Subduction']='MagicalINT'	
	spell_maps['Tem. Upheaval']='MagicalINT'	
	spell_maps['Thermal Pulse']='MagicalINT'		
	spell_maps['Thunderbolt']='MagicalINT'	
	spell_maps['Uproot']='MagicalINT'
	spell_maps['Water Bomb']='MagicalINT'	

	--=============================================================[Magic Acc]============================================================
	
	spell_maps['1000 Needles']='BluACC'
	spell_maps['Absolute Terror']='BluACC'
	spell_maps['Auroral Drape']='BluACC'
	spell_maps['Awful Eye']='BluACC'
	spell_maps['Blastbomb']='BluACC'
	spell_maps['Blank Gaze']='BluACC'
	spell_maps['Blistering Roar']='BluACC'
	spell_maps['Blitzstrahl']='BluACC'
	spell_maps['Blood Drain']='BluACC'
	spell_maps['Blood Saber']='BluACC'
	spell_maps['Chaotic Eye']='BluACC'
	spell_maps['Cimicine Discharge']='BluACC'
	spell_maps['Cold Wave']='BluACC'
	spell_maps['Digest']='BluACC'
    spell_maps['Corrosive Ooze']='BluACC'
	spell_maps['Demoralizing Roar']='BluACC'
	spell_maps['Dream Flower']='BluACC'
	spell_maps['Enervation']='BluACC'
	spell_maps['Filamented Hold']='BluACC'
	spell_maps['Frightful Roar']='BluACC'
	spell_maps['Geist Wall']='BluACC'
	spell_maps['Hecatomb Wave']='BluACC'
	spell_maps['Infrasonics']='BluACC'
	spell_maps['Light of Penance']='BluACC'
	spell_maps['Lowing']='BluACC'
	spell_maps['Mind Blast']='BluACC'
	spell_maps['Mortal Ray']='BluACC'
	spell_maps['MP Drainkiss']='BluACC'
	spell_maps['Sheep Song']='BluACC'
	spell_maps['Soporific']='BluACC'
	spell_maps['Sound Blast']='BluACC'
	spell_maps['Sprout Smack']='BluACC'
	spell_maps['Stinking Gas']='BluACC'
	spell_maps['Venom Shell']='BluACC'
	spell_maps['Voracious Trunk']='BluACC'
	spell_maps['Yawn']='BluACC'
	
	--=============================================================[Breath]============================================================
	
	spell_maps['Bad Breath']='Breath'
	spell_maps['Frost Breath']='Breath'
	spell_maps['Heat Breath']='Breath'
	spell_maps['Magnetite Cloud']='Breath'
	spell_maps['Poison Breath']='Breath'
	spell_maps[ 'Radiant Breath']='Breath'
	spell_maps['Thunder Breath']='Breath'
	spell_maps['Vapor Spray']='Breath'
	spell_maps['Wind Breath']='Breath'
	
	--=============================================================[HP]============================================================
		
	spell_maps['Flying Hip Press']='BlueHP'
	spell_maps['Final Sting']='BlueHP'
	spell_maps['Self Destruct']='BlueHP'	
	
	
	--=============================================================[Bluemagic Skill]============================================================
	
	spell_maps['Barrier Tusk']='BlueSkill'	
	spell_maps['Cocoon']='BlueSkill'	
	spell_maps['Carcharian Verve']='BlueSkill'	
	spell_maps['Erratic Flutter']='BlueSkill'	
	spell_maps['Harden Shell']='BlueSkill'	
	spell_maps['Orcish Counterstance']='BlueSkill'	
	spell_maps['Plasma Charge']='BlueSkill'	
	spell_maps['Pyric Bulwark']='BlueSkill'	
	spell_maps['Memento Mori']='BlueSkill'	
	spell_maps['Mighty Guard']='BlueSkill'	
	spell_maps['Nat. Meditation']='BlueSkill'	
	spell_maps['Reactor Cool']='BlueSkill'		
	spell_maps['Saline Coat']='BlueSkill'	
	spell_maps['Feather Barrier']='BlueSkill'	
	spell_maps['Refueling']='BlueSkill'	
	spell_maps['Warm-Up']='BlueSkill'	
	spell_maps['Zephyr Mantle']='BlueSkill'	
	spell_maps['Reactor Cool']='BlueSkill'			
	spell_maps['Plasma Charge']='BlueSkill'	
	spell_maps['Amplification']='BlueSkill'		
	spell_maps['Diamondhide']='BlueSkill'		
	spell_maps['Metallic Body']='BlueSkill'		
	spell_maps['Magic Barrier']='BlueSkill'		
	spell_maps['Atra. Libations']='BlueSkill'					

	
	--=============================================================[Cures]============================================================
	
	spell_maps['Healing Breeze']='Curaga'
	spell_maps['Magic Fruit']='Cure'	
	spell_maps['Plenilune Embrace']='Cure'	
	spell_maps['Pollen']='Cure'	
	spell_maps['Restoral']='Cure'	
	spell_maps['Wild Carrot']='Cure'		
	
	--=============================================================[Stun]============================================================
	
	spell_maps['Frypan'] = 'Stun'
	spell_maps['Head Butt'] = 'Stun'
	spell_maps['Sudden Lunge'] = 'Stun'
	spell_maps['Tail slap'] = 'Stun'
	spell_maps['Sub-zero Smash'] = 'Stun'
	spell_maps['Sweeping Gouge'] = 'Stun'

	--=============================================================[Enmity]============================================================
	
	-- spell_maps[] = 'Stun'		
    -- BlueMagic_Enmity = S {
        -- 'Actinic Burst', 'Exuviation', 'Fantod', 'Jettatura', 'Temporal Shift'
    -- }
	
	-- BlueMagic_FastRecast = S {'Osmosis', 'Feather Tickle', 'Reaving Wind',}
end