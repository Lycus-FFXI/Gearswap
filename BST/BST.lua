-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
--[[
	IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

!!!!!!!!!!!!!!!!    THIS FILE REQUIRES BST-LIB.lua AND BST-PETS.lua TO BE IN THE SAME DIRECTORY  !!!!!!!!!!!!!!!!!!
===================================================================================================================
	Features:
	* Variable Main-Hand / Off-Hand Modes
	* Automatic Dual Wield Detection
	* Automatic Pet-Jug Swapping
	* Automatic Reward Item Swapping
	* Ready Move Bindings
	* Heads Up Display (toggleable)
		* Master Info Tracking
		* Pet Info & Status Tracking
		* Ready Moves & Charges
		* Pet-Jug & Reward Item Tracking
		* Display Keybinds
	
	KeyBinds:
		F9 ........... Cycle Offense Mode
		Alt+F9 ....... Cycle Haste Mode (What kind of haste spell is being cast on you)
		Ctrl+F9 ...... Toggle Solo / Party Mode (For determining whether or not your buffs are coming from Trusts)
		
		F10 .......... Toggle Defense Mode
		Alt+F10 ...... Reset Defense Mode
		Ctrl+F10 ..... Cycle Defense Mode Options
		
		F11 .......... Cycle Main-Hand
		Ctrl+F11 ..... Toggle Main Weapon enable/disable
		
		F12 .......... Cycle Off-Hand
		Ctrl+F12 ..... Toggle Off-Hand enable/disable
		Alt+F12 ...... Toggle Kiting
		
		Home ......... Cycle Jugs List (List is obtained from your current inventory & wardrobes)
		End .......... Cycle Reward Item 
		
		Ctrl+PageUp .. Toggle Showing Keybinds In HUD
		Ctrl+PageDn .. Toggle HUD On/Off
		
		Windows+1~7 .. Use Ready Move for # (/bstpet #)

================================================================================================================== ]]--
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	-- Load and initialize the include file.
	include('Mote-Include.lua')	
	set_bindings()
end
-- Setup vars that are user-independent.
function job_setup()
	include('BST-LIB.lua')	
	map_ready_moves()
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()

	state.OffenseMode:options('Master', 'Pet')
	state.DefenseMode:options('None', 'Active')
	state.ActiveDefenseMode = M{['description'] = 'Damage Taken Mode', 'DT', 'PetDT', 'MixDT'}
	
	--Weapon lists. Feel free to customize
	state.Main = M{['description']='Main-hand Mode', "Aymur", "Naegling", "Ankusa Axe", "Dolichenus", "Agwu's Axe"}
	state.Sub = M{['description']='Off-hand Mode', 'Empty', "Ankusa Axe", "Dolichenus", "Agwu's Axe", "Ikenga's Axe"}
	
	--By default weapons/shield swaps are enabled
	state.LockMain = M{['description']='Main-hand', 'enabled', 'disabled'}
	state.LockSub = M{['description']='Off-hand', 'enabled', 'disabled'}
	
	state.RewardItem = M{['description']='Reward Item', 'Pet Food Theta', 'Pet Roborant', 'Pet Poultice'}	
	
	--Used for determining what kind of haste buffs you are recieving
	state.Support = M{'Solo','Party'}
	state.Haste = M{['description']='Haste Mode', 15, 25, 30}	
	
	--Used for determining what dual wield set to equip
	--DO NOT MODIFY
	state.Dualwield = M{['description']='Dual Wield Mode', 0, 15, 25}
	state.DWHaste = M{['description']='Dual Wield Haste Amount','NONE', '10', '15', '25', '30', 'MAX', 'MAX+Samba'}

	--If your pet is alive then use the Sroda Earring (Double Atk +7%)
	sroda_earring_weaponskills = T{'Decimation', 'Ruinator'}
	
	--[[============================================================================
	DO NOT MODIFY. THESE ARE AUTOMATICALLY POPULATED BASED ON YOUR INVENTORY AND PET
	================================================================================]]--
	state.JugsInInventory = Q{}	
	state.SelectedJug = 'NONE'
	--===============================================================================--
	
	--HUD Specific states
	state.ShowUI = M(true, 'HUD')
	state.ShowUIHotkeys = M(false)

	select_default_macro_book(1, 10)
	
	pos_x=0
	pos_y=0	
	--setupTextWindow at position, and define text size (default is 12 if not included)
	setupTextWindow(pos_x, pos_y, 10)	
	
	--perform some final setup
	check_dual_wield()
	get_ready_moves()	
	get_combat_form()
end
--For some reason setting the bindings in the user_setup wasn't working when gearswap first loads.
--
function set_bindings()
	send_command('bind ^Home gs c update user')
	send_command('bind Home gs c SelectJug')
	send_command('bind End gs c cycle RewardItem')

	send_command('bind f9 gs c cycle OffenseMode')
	send_command('bind ^f9 gs c cycle Support')
	send_command('bind !f9 gs c cycle Haste')	
	
	send_command('unbind @f9')
	
	send_command('bind f10 gs c cycle DefenseMode')
	send_command('bind !f10 gs c reset DefenseMode')
	send_command('bind ^f10 gs c cycle ActiveDefenseMode')
	
	send_command('bind f11 gs c cycle Main')
	send_command('bind ^f11 gs c cycle LockMain')
	
	send_command('bind f12 gs c cycle Sub')
	send_command('bind ^f12 gs c cycle LockSub')	
	send_command('bind !f12 gs c toggle Kiting')
	
	send_command('bind ^PageDown gs c cycle ShowUI')
	send_command('bind ^PageUp gs c cycle ShowUIHotkeys')
	
	
	send_command('bind @1 bstpet 1')
	send_command('bind @2 bstpet 2')
	send_command('bind @3 bstpet 3')
	send_command('bind @4 bstpet 4')
	send_command('bind @5 bstpet 5')
	send_command('bind @6 bstpet 6')
	send_command('bind @7 bstpet 7')
	
end
-- Called when this job file is unloaded (eg: job change)
function file_unload()
	send_command('unbind Home')
	send_command('unbind End')
	send_command('unbind ^PageDown')
	send_command('unbind ^PageUp')

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
	
	send_command('unbind @1')
	send_command('unbind @2')
	send_command('unbind @3')
	send_command('unbind @4')
	send_command('unbind @5')
	send_command('unbind @6')
	send_command('unbind @7')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- -- Start defining the sets
	--------------------------------------	
	Artio = {}
	Artio.Idle = { name="Artio's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Mag. Evasion+15',}}
	
	Artio.STP = { name="Artio's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	Artio.DW = { name="Artio's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}}
	Artio.DA = { name="Artio's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	
	Artio.Counter = { name="Artio's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','System: 1 ID: 640 Val: 4',}}
	
	Artio.Idle_pet = { name="Artio's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: Haste+10','Pet: Damage taken -5%',}}
	Artio.Macc_pet = { name="Artio's Mantle", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10'}}
	
	Artio.MND_WSD = { name="Artio's Mantle", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}}
	
	Artio.CHR_WSD = { name="Artio's Mantle", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+5','Weapon skill damage +10%',}}
	Artio.STR_DA = { name="Artio's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%'}}
	Artio.STR_WSD = { name="Artio's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	
	Emicho = {}
	Emicho.Hands = {}
	Emicho.Hands.DW = {name="Emi. Gauntlets +1", augments={'Accuracy+25','"Dual Wield"+6','Pet: Accuracy+25',}}
	Emicho.Hands.Pet = {name="Emi. Gauntlets +1", augments={'Pet: Accuracy+20','Pet: Attack+20','Pet: "Dbl. Atk."+4',}}
	
	Taeon = {['Head'] = {},		['Body'] = {},		['Hands'] = {},		['Legs'] = {},		['Feet'] = {}}
	Taeon.Head.DW = { name="Taeon Chapeau", augments={'Accuracy+24','"Dual Wield"+5','STR+7 DEX+7',}}
	Taeon.Body.DW = { name="Taeon Tabard", augments={'Accuracy+23','"Dual Wield"+5','DEX+10',}}	
	Taeon.Legs.DW = { name="Taeon Tights", augments={'Accuracy+23','"Dual Wield"+5','DEX+9',}}	
	Taeon.Legs.PetAtk = { name="Taeon Tights", augments={'Pet: Attack+25 Pet: Rng.Atk.+25','Pet: "Dbl. Atk."+3','Pet: Damage taken -4%',}}
	
	Taeon.Feet.DW = { name="Taeon Boots", augments={'Accuracy+23','"Dual Wield"+5','DEX+10',}}
	Taeon.Feet.PetAtk = { name="Taeon Boots", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+4','Pet: Damage taken -2%',}}
	
	Valorous = {['Head'] = {},		['Body'] = {},		['Hands'] = {},		['Legs'] = {},		['Feet'] = {}}
	Valorous.Body.PetAtk = { name="Valorous Mail", augments={'Pet: Attack+25 Pet: Rng.Atk.+25','Pet: "Dbl. Atk."+4','Pet: STR+4',}}
	
	Valorous.Head.PetMAB = { name="Valorous Mask", augments={'Pet: "Mag.Atk.Bns."+25','Pet: "Regen"+2','Pet: INT+13','Pet: Accuracy+8 Pet: Rng. Acc.+8',}}
	Valorous.Legs.PetMAB = { name="Valorous Hose", augments={'Pet: "Mag.Atk.Bns."+22','Pet: "Regen"+3','Pet: INT+14','Pet: Accuracy+15 Pet: Rng. Acc.+15','Pet: Attack+10 Pet: Rng.Atk.+10',}}
    Valorous.Feet.PetMAB ={ name="Valorous Greaves", augments={'Pet: "Mag.Atk.Bns."+26','Pet: Haste+1','Pet: INT+7','Pet: Accuracy+4 Pet: Rng. Acc.+4',}}
	
	gear.sroda_earring = {lear='Sroda Earring'}
	
	--------------------------------------
    -- Precast sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
	
	sets.Buff = {}
	
	sets.precast.JA['Familiar'] = {legs='Ankusa Trousers +3'}

	sets.precast.JA['Reward'] = {head='Stout Bonnet', body='Ankusa Jackcoat +3', legs='Ankusa Trousers +3'}
	sets.precast.JA['Call Beast'] = {hands='Ankusa Gloves +3'}
	sets.precast.JA['Bestial Loyalty'] = set_combine(sets.precast.JA['Call Beast'], { })
	
	sets.precast.JA['Killer Instinct'] = {head='Ankusa Helm'}
	
	sets.precast.JA['Spur'] = {main='Skullrender', sub='Skullrender', back=Artio.STP, feet='Nukumi Ocrea'}
	
	sets.precast.JA.Ready = {main='Aymur', hands='Nukumi Manoplas', legs="Gleti's Breeches" }
	
	sets.precast.JA['Charm'] = {}
	sets.precast.JA['Tame'] = {}
    -- Fast cast sets for spells
    
    sets.precast.FC = {}


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Crepuscular Pebble",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Gere Ring",
		back=Artio.STR_WSD}
	
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
   
    --40% MND / 40% STR (Thunder) Damage varies with TP [3.75, 6.7, 8.5] -- Darkness/Gravitation
	sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS,
		{ammo='Pemphredo Tathlum', 
		neck='Sanctity Necklace',
		rear='Friomisi Earring', 
		rring='Acumen Ring',
		back=Artio.CHR_WSD, 
		waist="Orpheus's Sash"})
	
	--30% DEX / 60% CHR (Light) Damage varies with TP [3.06, 5.84, 7.56] -- Gravitation/Reverberation
	sets.precast.WS['Primal Rend'] = set_combine(sets.precast.WS,
		{ammo='Pemphredo Tathlum', 
		neck='Sanctity Necklace',
		rear='Friomisi Earring', 
		rring='Acumen Ring',
		back=Artio.CHR_WSD, 
		waist="Orpheus's Sash"})
	
	--73~85% STR (Physical) Accuracy varies with TP -- [Darkness]/Distortion/Detonation
	sets.precast.WS['Ruinator'] = {
		ammo="Coiste Bodhar",
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Gere Ring",
		back=Artio.STR_DA}
	
	--100% DEX (Physical) Binds Target -- Scission/Detonation
	sets.precast.WS['Bora Axe'] = {}
	
	--50% STR (Physical) Accuracy varies with TP -- Fusion/Reverberation
	sets.precast.WS['Decimation'] = {
		ammo="Coiste Bodhar",
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Thrud Earring",
		left_ring="Epona's Ring",
		right_ring="Gere Ring",
		back=Artio.STR_DA}		
	
	sets.precast.WS['Calamity'] = set_combine(sets.precast.WS,
		{body="Gleti's Cuirass",
		neck='Bst. Collar +2',
		lear='Moonshade Earring',
		rring='Regal Ring',
		waist='Sailfi Belt +1',
		legs="Gleti's Breeches",
		feet="Gleti's Trousers"})		

	sets.precast.WS['Rampage'] = 
		{ammo="Aurgelmir Orb +1",
		head="Blistering Sallet +1", 
		body="Gleti's Cuirass", 
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring", 
		left_ring="Begrudging Ring",
		right_ring="Regal Ring",
		back=Artio.STR_WSD}
	--50% STR (Physical) Damage varies with TP [4, 10.5, 13.625] -- Fusion/Reverberation
	sets.precast.WS['Mistral Axe'] = set_combine(sets.precast.WS,
		{body="Gleti's Cuirass",
		neck='Bst. Collar +2',
		lear='Moonshade Earring',
		rring='Regal Ring',
		waist='Sailfi Belt +1',
		legs="Gleti's Breeches",
		feet="Gleti's Trousers"})	
	
	--50% STR / 50% MND (Physical) Damage varies with TP [4, 10.25, 13.75] -- Fragmentation/Scission/Detonation
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS,{})
	
	
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {}
	
	
	--Ready Sets
	sets.midcast.Pet.PhysicalReady = {
		main='Aymur',
		sub="Agwu's Axe",
		ammo="Hesperiidae",
		head="Emicho Coronet +1",
		body=Valorous.Body.PetAtk,
		hands="Nukumi Manoplas",
		legs=Taeon.Legs.PetAtk,
		feet="Gleti's Boots",
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Sroda Earring",
		right_ear="Domes. Earring",
		left_ring={name="Varar Ring +1", bag='wardrobe1'},
		right_ring={name="Varar Ring +1", bag='wardrobe2'},
		back=Artio.Idle_pet}
	
	sets.midcast.Pet.MagicAtkReady = { 
		ammo="Hesperiidae",
		head=Valorous.Head.PetMAB,
		body="Udug Jacket",
		hands="Nukumi Manoplas",
		legs=Valorous.Legs.PetMAB,
		feet=Valorous.Feet.PetMAB,
		neck="Adad Amulet",
		waist="Incarnation Sash",
		left_ear="Enmerkar Earring",
		right_ear="Crep. Earring",
		left_ring="Varar Ring +1",
		right_ring="Varar Ring +1",
		back=Artio.Macc_pet}
	
	sets.midcast.Pet.MagicAccReady = {
		main="Ankusa Axe",
		sub="Agwu's Axe",
		ammo="Hesperiidae",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets", 
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Bst. Collar +2",
		waist="Incarnation Sash",
		left_ear="Enmerkar Earring",
		right_ear="Crep. Earring",
		back=Artio.Macc_pet}
	
	sets.midcast.Pet.MultiHitReady = set_combine(sets.midcast.Pet.PhysicalReady, {legs='Emicho Hose +1', neck="Bst. Collar +2"})
	
	sets.midcast.Pet.TPBonusReady = set_combine(sets.midcast.Pet.PhysicalReady, {})
	
	sets.midcast.Pet.PetBuffReady = {hands='Nukumi Manoplas'}
	
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

	
	-- -- Sets to return to when not performing an action.
	
	-- -- Resting sets
	sets.resting = {  }		
	
	
	--Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
		ammo="Staunch Tathlum",
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck="Empath Necklace",
		waist="Isa Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Handler's Earring +1",
		left_ring="Sheltered Ring",
		right_ring="Karieyh Ring",
		back=Artio.Idle_pet}

	sets.idle.Town = {body="Councilor's Garb", feet="Skadi's Jambeaux +1"}
		
	sets.idle.Weak = {}
	sets.idle.Field = set_combine(sets.idle, { })	
	sets.idle.Field.DT = set_combine(sets.idle, 
		{head='Nyame Helm', body='Nyame Mail', hands='Nyame Gauntlets', legs='Nyame Flanchard', feet='Nyame Sollerets',
		lring='Defending Ring', rring='Moonbeam Ring'})
	sets.idle.Field.MixDT = set_combine(sets.idle, { })	
	sets.idle.Field.PetDT = set_combine(sets.idle.Field.DT, { })	--If we were in pet DT gear and the pet dies, sub in master DT

	sets.idle.Field.Pet = set_combine(sets.idle,{})

	--Pet engaged sets
	
	sets.idle.Field.Pet.engaged = {
		main='Skullrender',
		sub='Skullrender',		
		ammo="Hesperiidae", 
		head="Tali'ah Turban +2",
		body="An. Jackcoat +3", 
		hands=Emicho.Hands.Pet,
		legs="Ankusa Trousers +3", 
		feet= Taeon.Feet.PetAtk,
		neck="Bst. Collar +2",
		waist="Incarnation Sash",
		left_ear="Domes. Earring",
		right_ear="Enmerkar Earring",
		left_ring={name="Varar Ring +1", bag='wardrobe1'},
		right_ring={name="Varar Ring +1", bag='wardrobe2'},
		back=Artio.Idle_pet}
	
	sets.idle.Field.Pet.engaged.DT = set_combine(sets.idle.Field.DT,{})
	sets.idle.Field.Pet.engaged.PetDT = set_combine(sets.idle.Field.Pet.engaged,
		{main='Ankusa Axe', head='Anwig Salade', neck='Empath Necklace', rear="Handler's Earring +1",
		body='Totemic Jackcoat +2', hands="Gleti's Gauntlets", waist='Isa Belt', legs= Taeon.Legs.PetAtk})
	sets.idle.Field.Pet.engaged.MixDT	= set_combine(sets.idle.Field.Pet.engaged.PetDT,
		{ammo='Crepsecular Pebble',neck='Loricate Torque', lring='Defending Ring', rring='Moonbeam Ring'})
	
	sets.idle.Field.Pet.DT = set_combine(sets.idle.Field.DT,{})
	sets.idle.Field.Pet.PetDT = set_combine(sets.idle.Field.Pet.engaged,
		{main='Ankusa Axe', head='Anwig Salade', neck='Empath Necklace', rear="Handler's Earring +1",
		body='Totemic Jackcoat +2', hands="Gleti's Gauntlets", waist='Isa Belt', legs= Taeon.Legs.PetAtk})
	sets.idle.Field.Pet.MixDT = set_combine(sets.idle.Field.Pet.engaged.PetDT,
		{ammo='Crepsecular Pebble',neck='Loricate Torque', lring='Defending Ring', rring='Moonbeam Ring'})
	
	sets.Kiting = {feet="Skadi's Jambeaux +1"}
	
	-- -- Defense sets 
	-- -- In Gearswap defense sets are equipped no matter the situation, which I don't personally like 
	-- -- Therefore I have retooled the functionality to differentiate between engaged and idle
	-- -- Do not fill this in or delete it
	sets.defense = { }		

	-- -- Engaged sets

	-- -- Variations for TP weapon and (optional) offense/defense modes.  
	-- -- Code will fall back on previous sets if more refined versions aren't defined.
	-- -- If you create a set with both offense and defense modes, the offense mode should be first.
	-- -- EG: sets.engaged.Dagger.Accuracy.Evasion
	
    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
	sets.engaged = {
		ammo='Coiste Bodhar', 
		head='Malignance Chapeau', neck='Anu Torque', lear='Sherida Earring', rear='Cessance Earring',
		body="Gleti's Cuirass", hands='Malignance Gloves', lring="Epona's Ring", rring='Gere Ring',
		back=Artio.STP, waist='Sailfi Belt +1', legs='Malignance Tights', feet='Malignance Boots'}
	
	sets.engaged.DT = set_combine(sets.engaged,{neck='Loricate Torque', body='Malignance Tabard'})
	sets.engaged.PetDT = {}
	sets.engaged.MixDT = {}


	-----------------------------------------------NINJA SUB----------------------------------------------------

	--0% haste | max dual wield (49 DW) [51/hit]
	sets.engaged.NIN = set_combine(sets.engaged,{ 
		 neck='Beastmaster Collar +2', lear='Suppanomimi', rear='Eabani Earring',
		 body=Taeon.Body.DW, hands=Emicho.Hands.DW, 
		 back=Artio.DW, waist='Reiki Yotai', legs=Taeon.Legs.DW, feet=Taeon.Feet.DW})
		 
	sets.engaged.NIN.DT = set_combine(sets.engaged.NIN, {neck='Loricate Torque', body='Malignance Tabard'})
	sets.engaged.NIN.MixDT  = {}
	sets.engaged.NIN.PetDT = {}
	
	--10% haste | single advancing march from trusts (45 DW) [58/hit]
	sets.engaged.NIN['10'] = set_combine(sets.engaged.NIN,{neck="Anu Torque", body="Gleti's Cuirass"})
	sets.engaged.NIN['10'].DT = set_combine(sets.engaged.NIN['10'],
		 {ammo='Staunch Tathlum', neck='Loricate Torque', lring='Defending Ring', rring='Moonbeam Ring'})	
	sets.engaged.NIN['10'].MixDT  = {}	
	sets.engaged.NIN['10'].PetDT = {}

	--15% regular haste (42 DW) [62/hit]
	sets.engaged.NIN['15'] = set_combine(sets.engaged,{ 
		 lear='Suppanomimi',rear='Eabani Earring', hands=Emicho.Hands.DW, 
		 back=Artio.DW, waist='Reiki Yotai', legs=Taeon.Legs.DW, feet=Taeon.Feet.DW})
	sets.engaged.NIN['15'].DT = {}	
	sets.engaged.NIN['15'].MixDT  = {}	
	sets.engaged.NIN['15'].PetDT = {}
	
	--25% double march from trusts, zealous snort (~35 DW) [72/hit]
	sets.engaged.NIN['25'] = set_combine(sets.engaged,{ 
		 rear='Eabani Earring', hands=Emicho.Hands.DW, 
		 back=Artio.DW, waist='Reiki Yotai', feet=Taeon.Feet.DW})
	sets.engaged.NIN['25'].DT = {}	
	sets.engaged.NIN['25'].MixDT  = {}	
	sets.engaged.NIN['25'].PetDT = {}
	
	--30% haste 2 (31 DW) [76/hit]
	sets.engaged.NIN['30'] = set_combine(sets.engaged,{ 
		hands=Emicho.Hands.DW, back=Artio.DW, waist='Reiki Yotai', feet=Taeon.Feet.DW})
	sets.engaged.NIN['30'].DT = {}	
	sets.engaged.NIN['30'].MixDT  = {}	
	sets.engaged.NIN['30'].PetDT = {}		
	
	--capped haste (11 DW) [97/hit]
	sets.engaged.NIN['MAX'] = set_combine(sets.engaged,{rear='Eabani Earring', waist='Reiki Yotai'})
	sets.engaged.NIN['MAX'].DT = {}	
	sets.engaged.NIN['MAX'].MixDT = {}	
	sets.engaged.NIN['MAX'].PetDT = {}	
	
    --capped haste + samba (0 DW) [116/hit]
	sets.engaged.NIN['MAX+Samba'] = set_combine(sets.engaged,{})
	sets.engaged.NIN['MAX+Samba'].DT = set_combine(sets.engaged.DT,{})
	sets.engaged.NIN['MAX+Samba'].MixDT = set_combine(sets.engaged.MixDT,{})	
	sets.engaged.NIN['MAX+Samba'].PetDT = set_combine(sets.engaged.PetDT,{})
	
	-----------------------------------------------DANCER SUB----------------------------------------------------

	--0% haste | max dual wield (59 DW)
	sets.engaged.DNC = {}
	sets.engaged.DNC.DT = {}
	sets.engaged.DNC.MixDT  = {}
	sets.engaged.DNC.PetDT = {}
	
	--10% haste | single advancing march from trusts (55 DW)
	sets.engaged.DNC['10'] = {}
	sets.engaged.DNC['10'].DT = {}	
	sets.engaged.DNC['10'].MixDT  = {}	
	sets.engaged.DNC['10'].PetDT = {}
	
	--15% regular haste (52 DW)	
	sets.engaged.DNC['15'] = {}
	sets.engaged.DNC['15'].DT = {}	
	sets.engaged.DNC['15'].MixDT  = {}	
	sets.engaged.DNC['15'].PetDT = {}	
	
	--25% double march from trusts, zealous snort (~45 DW)
	sets.engaged.DNC['25'] = {}
	sets.engaged.DNC['25'].DT = {}	
	sets.engaged.DNC['25'].MixDT  = {}	
	sets.engaged.DNC['25'].PetDT = {}	
	
	--30% haste 2 (41 DW)
	sets.engaged.DNC['30'] = {}
	sets.engaged.DNC['30'].DT = {}	
	sets.engaged.DNC['30'].MixDT  = {}	
	sets.engaged.DNC['30'].PetDT = {}	
	
	--capped haste (21 DW)	
	sets.engaged.DNC['MAX'] = set_combine(sets.engaged,{})
	sets.engaged.DNC['MAX'].DT = {}	
	sets.engaged.DNC['MAX'].MixDT = {}	
	sets.engaged.DNC['MAX'].PetDT = {}
	
	--capped haste + Samba (9 DW)	
	sets.engaged.DNC['MAX+Samba']= set_combine(sets.engaged,{})
	sets.engaged.DNC['MAX+Samba'].DT = {}	
	sets.engaged.DNC['MAX+Samba'].MixDT = {}	
	sets.engaged.DNC['MAX+Samba'].PetDT = {}
	
	-------------------------------------------------- AM3 Sets (Aymur) -------------------------------------------------- 
		
	sets.engaged.AM3 = {}
	sets.engaged.AM3.PetDT = {}		

	--0% haste | max dual wield (49 DW)	
	sets.engaged.NIN.AM3 = set_combine(sets.engaged.NIN,
		{ammo='Aurgelmir Orb +1', 
		rring={name='Chirich Ring +1', bag='Wardrobe2'}, lring={name='Chirich Ring +1', bag='Wardrobe3'}})
	sets.engaged.NIN.AM3.PetDT = {}		
	
	--10% haste | single advancing march from trusts (45 DW)
	sets.engaged.NIN['10'].AM3 = set_combine(sets.engaged.NIN['10'],{ammo='Aurgelmir Orb +1', body='Malignance Tabard',
		rring={name='Chirich Ring +1', bag='wardrobe2'}, lring={name='Chirich Ring +1', bag='wardrobe3'}})
	sets.engaged.NIN['10'].AM3.PetDT = {}

	--15% regular haste (42 DW)
	sets.engaged.NIN['15'].AM3 = set_combine(sets.engaged.NIN['15'],{ammo='Aurgelmir Orb +1', body='Malignance Tabard',
		rring={name='Chirich Ring +1', bag='Wardrobe2'}, lring={name='Chirich Ring +1', bag='Wardrobe3'}})
	sets.engaged.NIN['15'].AM3.PetDT = {}

	--25% double march from trusts, zealous snort (~35 DW)	
	sets.engaged.NIN['25'].AM3 = set_combine(sets.engaged.NIN['25'],
		{ammo='Aurgelmir Orb +1', lear='Suppanomimi', body='Malignance Tabard', hands='Malignance Gloves',
		rring={name='Chirich Ring +1', bag='Wardrobe2'}, lring={name='Chirich Ring +1', bag='Wardrobe3'}})
	sets.engaged.NIN['25'].AM3.PetDT = {}
	
	--30% haste 2 (31 DW)	
	sets.engaged.NIN['30'].AM3 = set_combine(sets.engaged.NIN['30'],
		{ammo='Aurgelmir Orb +1', rear='Eabani Earring', body='Malignance Tabard', hands='Malignance Gloves',
		rring={name='Chirich Ring +1', bag='Wardrobe2'}, lring={name='Chirich Ring +1', bag='Wardrobe3'}})
	sets.engaged.NIN['30'].AM3.PetDT = {}

	--capped haste (11 DW)	
	sets.engaged.NIN['MAX'].AM3 = set_combine(sets.engaged.NIN['MAX'],
		{ammo='Aurgelmir Orb +1', body='Malignance Tabard',
		rring={name='Chirich Ring +1', bag='Wardrobe2'}, lring={name='Chirich Ring +1', bag='Wardrobe3'}})
	sets.engaged.NIN['MAX'].AM3.PetDT = {}
	
    --capped haste + samba (0 DW)	
	sets.engaged.NIN['MAX+Samba'].AM3 = set_combine(sets.engaged.NIN['MAX+Samba'],
		{ammo='Aurgelmir Orb +1', body='Malignance Tabard',
		rring={name='Chirich Ring +1', bag='Wardrobe2'}, lring={name='Chirich Ring +1', bag='Wardrobe3'}})
	sets.engaged.NIN['MAX+Samba'].AM3.PetDT = {}
	
	--0% haste | max dual wield (59 DW)
	sets.engaged.DNC.AM3 = {}
	sets.engaged.DNC.AM3.PetDT = {}		
	
	--10% haste | single advancing march from trusts (55 DW)
	sets.engaged.DNC['10'].AM3 = {}
	sets.engaged.DNC['10'].AM3.PetDT = {}

	--15% regular haste (52 DW)	
	sets.engaged.DNC['15'].AM3 = {}
	sets.engaged.DNC['15'].AM3.PetDT = {}

	--25% double march from trusts, zealous snort (~45 DW)
	sets.engaged.DNC['25'].AM3 = {}
	sets.engaged.DNC['25'].AM3.PetDT = {}

	--30% haste 2 (41 DW)
	sets.engaged.DNC['30'].AM3 = {}
	sets.engaged.DNC['30'].AM3.PetDT = {}

	--capped haste (21 DW)	
	sets.engaged.DNC['MAX'].AM3 = set_combine(sets.engaged.NIN['MAX'],
		{ammo='Aurgelmir Orb +1', body='Malignance Tabard',
		rring={name='Chirich Ring +1', bag='Wardrobe2'}, lring={name='Chirich Ring +1', bag='Wardrobe3'}})	
	sets.engaged.DNC['MAX'].AM3.PetDT = {}	

	--capped haste + Samba (9 DW)	
	sets.engaged.DNC['MAX+Samba'].AM3 = set_combine(sets.engaged.NIN['MAX+Samba'],
		{ammo='Aurgelmir Orb +1', body='Malignance Tabard',
		rring={name='Chirich Ring +1', bag='Wardrobe2'}, lring={name='Chirich Ring +1', bag='Wardrobe3'}})
	sets.engaged.DNC['MAX+Samba'].AM3.PetDT = {}	
end
	
	
