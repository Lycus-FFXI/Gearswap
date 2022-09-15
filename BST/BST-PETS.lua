--[[===================================================================================================================
											Library file for BST.lua
											
						I have only included the level 99+ pets in this file because I am lazy.
				    If you want to add more, feel free. Let me know if there are any inaccuracies too.
========================================================================================================================]]--


--[[ 
	[Pet name]=T{
		['Jug']=Jug Name,
		['Charges']={[1]=Ready Ability #1 number of charges,[2]=Ready Ability #2 number of charges}, etc.
		['Type']=Monster type, ['Family']=Monster Family}
		
	See below for numerous examples
]]--
Pets = T{		
	['RhymingShizuna']=T{
		['Jug']='Lyrical Broth',
		['Charges']={[1]=1,[2]=2,[3]=1,[4]=2},
		['Type']='Beast', ['Family']='Sheep'},
	['AgedAngus']=T{
		['Jug']='Ferm. Broth',
		['Charges']={[1]=1,[2]=3,[3]=1,[4]=2,[5]=1},
		['Type']='Aquan',['Family']='Crab'},
	['GenerousArthur'] = T{
		['Jug']='Dire Broth',
		['Charges']={[1]=2,[2]=3},
		['Type']='Amorph', ['Family']='Slug'},	
	['AmiableRoche'] = T{
		['Jug']='Airy Broth',
		['Charges']={[1]=2,[2]=1,[3]=3},
		['Type']='Aquan', ['Family']='Pugil'},
	['SweetCaroline'] = T{
		['Jug']='Aged Humus',
		['Charges']={[1]=1,[2]=1,[3]=1,[4]=1},
		['Type']='Plantoid', ['Family']='Mandragora'},
	['HeartbreakerKen'] = T{
		['Jug']='Blackwater Broth',
		['Charges']={[1]=1,[2]=1,[3]=1},
		['Type']='Vermin', ['Family']='Fly'},
	['AnklebiterJedd'] = T{
		['Jug']='Anklebiter Jedd',
		['Charges']={[1]=1,[2]=1,[3]=1,[4]=2},
		['Type']='Vermin', ['Family']='Diremite'},		
	['CursedAnnabelle'] = T{
		['Jug']='Creepy Broth',
		['Charges']={[1]=1,[2]=2,[3]=1,[4]=2},
		['Type']='Vermin', ['Family']='Antlion'},
	['BrainyWaluis'] = T{
		['Jug']='Crumbly Soil',
		['Charges']={[1]=1,[2]=1,[3]=2,[4]=2,[5]=2,[6]=3,[7]=3},
		['Type']='Plantoid', ['Family']='Funguar'},
	['Slime Familiar'] = T{
		['Jug']='Decaying Broth',
		['Charges']={[1]=1,[2]=2,[3]=1},
		['Type']='Amorph', ['Family']='Slime'},
	['SultryPatrice'] = T{
		['Jug']='Putrescent Broth',
		['Charges']={[1]=1,[2]=2,[3]=1},
		['Type']='Amorph', ['Family']='Slime'},
	['RedolentCandi'] = T{
		['Jug']='Electrified Broth',
		['Charges']={[1]=1,[2]=2,[3]=2,[4]=3},
		['Type']='Plantoid', ['Family']='Snapweed'},
	['AlluringHoney'] = T{
		['Jug']='Bug-Ridden Broth',
		['Charges']={[1]=1,[2]=2,[3]=2,[4]=3},
		['Type']='Plantoid', ['Family']='Snapweed'},		
	['LynxFamiliar'] = T{
		['Jug']='',
		['Charges']={[1]=1,[2]=2},
		['Type']='Beast', ['Family']='Coeurl'},
	['VivaciousGaston'] = T{
		['Jug']='Frizzante Broth',
		['Charges']={[1]=1,[2]=2},
		['Type']='Beast', ['Family']='Coeurl'},
	['CaringKiyomaro'] = T{
		['Jug']='Spumante Broth',
		['Charges']={[1]=1,[2]=3},
		['Type']='Beast', ['Family']='Raaz'},
	['VivaciousVickie'] = T{
		['Jug']='Tant. Broth',
		['Charges']={[1]=1,[2]=3},
		['Type']='Beast', ['Family']='Raaz'},
	['SuspiciousAlice'] = T{
		['Jug']='Furious Broth',
		['Charges']={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1},
		['Type']='Lizard', ['Family']='Eft'},
	['SuringStorm'] = T{
		['Jug']='Insipid Broth',
		['Charges']={[1]=2,[2]=1},
		['Type']='Bird', ['Family']='Apkallu'},		
	['SubmergedIyo'] = T{
		['Jug']='Deepwater Broth',
		['Charges']={[1]=2,[2]=1},
		['Type']='Bird', ['Family']='Apkallu'},
	['WarlikePatrick'] = T{
		['Jug']='Livid Broth',
		['Charges']={[1]=1,[2]=1,[3]=1,[4]=1,[5]=2,[6]=1},
		['Type']='Lizard', ['Family']='Lizard'},
	['BlackbeardRandy'] = T{
		['Jug']='Meaty Broth',
		['Charges']={[1]=2,[2]=1,[3]=1,[4]=2,[5]=2},
		['Type']='Beast', ['Family']='Tiger'},
	['ThreestarLynn'] = T{
		['Jug']='Muddy Broth',
		['Charges']={[1]=1,[2]=1,[3]=2},
		['Type']='Vermin', ['Family']='Ladybug'},
	['HurlerPercival'] = T{
		['Jug']='Pale Sap',
		['Charges']={[1]=1,[2]=2,[3]=1,[4]=1,[5]=1},
		['Type']='Vermin', ['Family']='Beetle'},
	['AcuexFamiliar'] = T{
		['Jug']='Poisonous Broth',
		['Charges']={[1]=2,[2]=2},
		['Type']='Amorph', ['Family']='Acuex'},		
	['FluffyBredo'] = T{
		['Jug']='Venomous Broth',
		['Charges']={[1]=2,[2]=2},
		['Type']='Amorph', ['Family']='Acuex'},
	['WeevilFamiliar'] = T{
		['Jug']='Pristine Sap',
		['Charges']={[1]=1,[2]=1,[3]=1},
		['Type']='Vermin', ['Family']='Lucani'},
	['StalwartAngelina'] = T{
		['Jug']='Truly Pristine Sap',
		['Charges']={[1]=1,[2]=1,[3]=1},
		['Type']='Vermin', ['Family']='Lucani'},
	['FleetReinhard'] = T{
		['Jug']='Rapid Broth',
		['Charges']={[1]=1,[2]=1,[3]=3},
		['Type']='Lizard', ['Family']='Raptor'},
	['SharpwitHermes'] = T{
		['Jug']='Saline Broth',
		['Charges']={[1]=1,[2]=1,[3]=1,[4]=1},
		['Type']='Plantoid', ['Family']='Mandragora'},
	['PorterCrabFamiliar'] = T{
		['Jug']='Rancid Broth',
		['Charges']={[1]=1,[2]=3,[3]=1,[4]=2,[5]=1},
		['Type']='Aquan', ['Family']='Crab'},		
	['JovialEdwin'] = T{
		['Jug']='Pungent Broth',
		['Charges']={[1]=1,[2]=3,[3]=1,[4]=2,[5]=1},
		['Type']='Aquan', ['Family']='Crab'},
	['AttentiveIbuki'] = T{
		['Jug']='Salubrious Broth',
		['Charges']={[1]=1,[2]=2,[3]=3},
		['Type']='Bird', ['Family']='Tulfaire'},
	['SwoopingZhivago'] = T{
		['Jug']='Windy Greens',
		['Charges']={[1]=1,[2]=2,[3]=3},
		['Type']='Bird', ['Family']='Tulfaire'},
	['StarburtMalfik'] = T{
		['Jug']='Shimmering Broth',
		['Charges']={[1]=1,[2]=3,[3]=1,[4]=2,[5]=1},
		['Type']='Aquan', ['Family']='Crab'},
	['ScissorlegXerin'] = T{
		['Jug']='Spicy Broth',
		['Charges']={[1]=1,[2]=2},
		['Type']='Vermin', ['Family']='Chapuli'},
	['BouncingBertha'] = T{
		['Jug']='Bubbly Broth',
		['Charges']={[1]=1,[2]=2},
		['Type']='Vermin', ['Family']='Chapuli'},		
	['SpiderFamiliar'] = T{
		['Jug']='Sticky Webbing',
		['Charges']={[1]=1,[2]=1,[3]=2},
		['Type']='Vermin', ['Family']='Spider'},
	['GussyHachirobe'] = T{
		['Jug']='Slimy Webbing',
		['Charges']={[1]=1,[2]=1,[3]=2},
		['Type']='Vermin', ['Family']='Spider'},
	['ColibriFamiliar'] = T{
		['Jug']='Sugary Broth',
		['Charges']={[1]=1},
		['Type']='Bird', ['Family']='Colibri'},
	['ChoralLeera'] = T{
		['Jug']='Glazed Broth',
		['Charges']={[1]=1},
		['Type']='Bird', ['Family']='Colibri'},		
	['DroopyDortwin'] = T{
		['Jug']='Swirling Broth',
		['Charges']={[1]=1,[2]=1,[3]=1,[4]=2},
		['Type']='Beast', ['Family']='Rabbit'},
	['PonderingPeter'] = T{
		['Jug']='Vis. Broth',
		['Charges']={[1]=1,[2]=1,[3]=1,[4]=2},
		['Type']='Beast', ['Family']='Rabbit'},
	['HeraldHenry'] = T{
		['Jug']='Trans. Broth',
		['Charges']={[1]=1,[2]=3,[3]=1,[4]=2,[5]=1},
		['Type']='Aquan', ['Family']='Crab'},
	['HippogryphFamiliar'] = T{
		['Jug']='Turpid Broth',
		['Charges']={[1]=1,[2]=3,[3]=1,[4]=1,[5]=2,[6]=3},
		['Type']='Bird', ['Family']='Hippogryph'},
	['DaringRoland'] = T{
		['Jug']='Feculent Broth',
		['Charges']={[1]=1,[2]=3,[3]=1,[4]=2,[5]=3,[6]=1},
		['Type']='Bird', ['Family']='Hippogryph'},
	['MosquitoFamiliar'] = T{
		['Jug']='Wetlands Broth',
		['Charges']={[1]=1,[2]=2},
		['Type']='Vermin', ['Family']='Moquito'},		
	['Left-HandedYoko'] = T{
		['Jug']='Heavenly Broth',
		['Charges']={[1]=1,[2]=2},
		['Type']='Vermin', ['Family']='Mosquito'},
	['Fatso Fargann'] = T{
		['Jug']='C. Plasma Broth',
		['Charges']= {[1]=1,[2]=1,[3]=2,[4]=3},
		['Type']='Amorph', ['Family']='Leech'},
	['BraveHeroGlenn'] = T{
		['Jug']='Wispy Broth',
		['Charges']={},
		['Type']='Aquan', ['Family']='Frog'},
	['YellowBeetleFamiliar']= T{
		['Jug']='Zestful Sap',
		['Charges']={[1]=1,[2]=2,[3]=1,[4]=1,[5]=1},
		['Type']='Vermin', ['Family']='Beetle'},
	['EnergizedSefina']= T{
		['Jug']='Gassy Sap',
		['Charges']={[1]=1,[2]=2,[3]=1,[4]=1,[5]=1},
		['Type']='Vermin', ['Family']='Beetle'},
	['DapperMac'] = T{
		['Jug']='Briny Broth',
		['Charges']={[1]=2,[2]=1},
		['Type']='Bird', ['Family']='Apkallu'},
	['CraftyClyvonne'] = T{
		['Jug']='Cng. Brain Broth',
		['Charges']={[1]=1,[2]=2},
		['Type']='Beast', ['Family']='Coeurl'},
	['NurseryNazuna'] = T{
		['Jug']='D. Herbal Broth',
		['Charges']={[1]=1,[2]=2,[3]=1,[4]=2},
		['Type']='Beast', ['Family']='Sheep'},
	['LuckyLulush'] = T{
		['Jug']='L. Carrot Broth',
		['Charges']={[1]=1,[2]=1,[3]=1,[4]=2},
		['Type']='Beast', ['Family']='Rabbit'},
	['FlowerpotMerle'] = T{
		['Jug']='Vermihumus',
		['Charges']={[1]=1,[2]=1,[3]=1,[4]=1},
		['Type']='Plantoid', ['Family']='Madragora'},
	['DipperYuly'] = T{
		['Jug']='Wool Grease',
		['Charges']={[1]=1,[2]=1,[3]=2},
		['Type']='Vermin', ['Family']='Ladybug'},
	['DiscreetLouise'] = T{
		['Jug']='Deepbed Soil',
		['Charges']={[1]=1,[2]=1,[3]=2,[4]=2,[5]=2,[6]=3,[7]=3},
		['Type']='Plantoid', ['Family']='Funguar'},
	['Presto Julio'] = T{
		['Jug']='C. Grass. Broth',
		['Charges']={[1]=1,[2]=2,[3]=1},
		['Type']='Plantoid', ['Family']='Flytrap'},
	['Audacious Anna'] = T{
		['Jug']='Bub. Carrion Broth',
		['Charges']={[1]=1,[2]=1,[3]=1,[4]=1,[5]=2,[6]=1},
		['Type']='Lizard', ['Family']='Hill Lizard'},
	['Mailbuster Cetas'] = T{
		['Jug']='Gob. Bug Broth',
		['Charges']={[1]=1,[2]=1,[3]=1},
		['Type']='Vermin', ['Family']='Fly'},
	['FaithfulFalcorr'] = T{
		['Jug']='Lucky Broth',
		['Charges']={[1]=1,[2]=3,[3]=1,[4]=1,[5]=2,[6]=3},
		['Type']='Bird', ['Family']='Hippogryph'},
	['SwiftSieghard'] = T{
		['Jug']='Mlw. Bird Broth',
		['Charges']={[1]=1,[2]=1,[3]=3},
		['Type']='Lizard', ['Family']='Raptor'},
	['BugeyedBroncha'] = T{
		['Jug']='Svg. Mole Broth',
		['Charges']={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1},
		['Type']='Lizard', ['Family']='Eft'},
	['GorefangHobs'] = T{
		['Jug']='Bur. Carrion Broth',
		['Charges']={[1]=2,[2]=1,[3]=1,[4]=2,[5]=2},
		['Type']='Beast', ['Family']='Tiger'},
	['GooeyGerard'] = T{
		['Jug']='Cl. Wheat Broth',
		['Charges']={[1]=2,[2]=3},
		['Type']='Amorph', ['Family']='Slug'},
	['CrudeRaphie'] = T{
		['Jug']='Shadowy Broth',
		['Charges']={[1]=1,[2]=1,[3]=3},
		['Type']='Lizard', ['Family']='Adamantoise'}
}

--So I don't have to define each and every correlation for each Pet
Correlation = T{
	['Beast']={['Strong']='Lizards',['Weak']='Plantoids'},
	['Lizard']={['Strong']='Vermin',['Weak']='Beasts'},
	['Vermin']={['Strong']='Plantoids',['Weak']='Lizards'},
	['Plantoid']={['Strong']='Beasts',['Weak']='Vermin'},	
	['Aquan']={['Strong']='Amorphs',['Weak']='Birds'},
	['Amorph']={['Strong']='Birds',['Weak']='Aquan'},
	['Bird']={['Strong']='Aquans',['Weak']='Amorphs'}	
 }
 
 
Jugs = S{'Alchemist Water', 'Carrot Broth', 'F. Carrot Broth', 'Famous Carrot Broth', 'Fish Broth', 'Fish Oil Broth',
		'Herbal Broth', 'S. Herbal Broth', 'Singing Herbal Broth', 'Wormy Broth', 'Grasshopper Broth', 'Noisy Grasshopper Broth',
		'Humus', 'Rich Humus', 'Meat Broth', 'Warm Meat Broth', 'Bug Broth', 'Qdv. Bug Broth', 'Quadav Bug Broth', 'Carrion Broth',
		'Cold Carrion Broth', 'Mole Broth', 'L. Mole Broth', 'Lively Mole Broth', 'Seedbed Soil', 'Antica Broth', 'Fragrant Antica Broth',
		'Tree Sap', 'Scarlet Sap', 'Blood Broth', 'Clear Blood Broth', 'Auroral Broth', 'Sun Water', 'Briny Broth', 'Cng. Brain Broth',
		'Cunning Brain Broth', 'D. Herbal Broth', 'Dancing Herbal Broth', 'L. Carrot Broth', 'Lucky Carrot Broth', 'Vermihumus',
		'Wool Grease', 'Deepbed Soil', 'C. Plasma Broth', 'Clot Plasma Broth', 'C. Grass. Broth', 'Chirping Grasshopper Broth',
		'Bub. Carrion Broth', 'Bubbling Carrion Broth', 'Gob. Bug Broth', 'Goblin Bug Broth', 'Lucky Broth', 'Mlw. Bird Broth',
		'Mellow Bird Broth', 'Rzr. Brain Broth', 'Razor Brain Broth', 'Svg. Mole Broth', 'Savage Mole Broth', 'Bur. Carrion Broth',
		'Burning Carrion Broth', 'Cl. Wheat Broth', 'Cloudy Wheat Broth', 'Shadowy Broth', 'Airy Broth', 'Aged Humus', 'Blackwater Broth',
		'Crackling Broth', 'Creepy Broth', 'Crumbly Soil', 'Dire Broth', 'Electrified Broth', 'Bug-Ridden Broth', 'Fizzy Broth',
		'Tantalizing Broth', 'Tant. Broth', 'Furious Broth', 'Insipid Broth', 'Deepwater Broth', 'Livid Broth', 'Lyrical Broth', 'Meaty Broth',
		'Muddy Broth', 'Pale Sap', 'Poisonous Broth', 'Venomous Broth', 'Pristine Sap', 'T. Pristine Sap', 'Truly Pristine Sap',
		'Rapid Broth', 'Saline Broth', 'Salubrious Broth', 'Windy Greens', 'Shimmering Broth', 'Ferm. Broth', 'Fermented Broth', 
		'Spicy Broth', 'Bubbly Broth', 'Sticky Webbing', 'Slimy Webbing', 'Sugary Broth', 'Glazed Broth', 'Swirling Broth', 'Vis. Broth',
		'Viscous Broth', 'Trans. Broth', 'Translucent Broth', 'Wetlands Broth', 'Heavenly Broth', 'Wispy Broth', 'Aged Humus', 
		'Rancid Broth', 'Pungent Broth', 'Zestful Sap', 'Gassy Sap', 'Frizzante Broth', 'Spumante Broth', 'Turpid Broth', 'Feculent Broth',
		'Decaying Broth', 'Putrescent Broth'}

--Used to get basic jug to pet info
JugInfo = T{
	['Airy Broth']='Amiable Roche',
	['Aged Humus']='Sweet Caroline',
	['Blackwater Broth']='Headbreaker Ken',
	['Crackling Broth']='Anklebiter Jedd',
	['Creepy Broth']='Cursed Annabelle',
	['Crumbly Soil']='Brainy Waluis',
	['Decaying Broth']='Slime Familiar',
	['Putrescent Broth']='Sultry Patrice',
	['Dire Broth']='Generous Arthur',
	['Electrified Broth']='Redolent Candi',
	['Bug-Ridden Broth']='Alluring Honey',
	['Frizzante Broth']='Lynx Familiar',
	['Spumante Broth']='Vivacious Gaston',
	['Fizzy Broth']='Caring Kiyomaro',
	['Tant. Broth']='Vivacious Vickie',
	['Furious Broth']='Suspicious Alice',
	['Insipid Broth']='Surging Storm',
	['Deepwater Broth']='Submerged Iyo',
	['Livid Broth']='Warlike Patrick',
	['Lyrical Broth']='Rhyming Shizuna',
	['Meaty Broth']='Blackbeard Randy',
	['Muddy Broth']='Threestar Lynn',
	['Pale Sap']='Hurler Percival',
	['Poisonous Broth']='Acuex Familiar',
	['Venomous Broth']='Fluffy Bredo',
	['Pristine Sap']='Weevil Familiar',
	['Truly Pristine Sap']='Stalwart Angelina',
	['Rapid Broth']='Fleet Reinhard',
	['Saline Broth']='Sharpwith Hermes',
	['Rancid Broth']='Porter Crab Familiar',
	['Pungent Broth']='Jovial Edwin',
	['Salubrious Broth']='Attentive Ibuki',
	['Windy Greens']='Swooping Zhivago',
	['Shimmering Broth']='Sunburst Malfik',
	['Ferm. Broth']='Aged Angus',
	['Spicy Broth']='Scissorleg Xerin',
	['Bubbly Broth']='Bouncing Bertha',
	['Sticky Webbing']='Spider Familiar',
	['Slimy Webbing']='Gussy Hachirobe',
	['Sugary Broth']='Colibri Familiar',
	['Glazed Broth']='Choral Leera',
	['Swirling Broth']='Droopy Dortwin',
	['Vis. Broth']='Pondering Peter',
	['Trans. Broth']='Herald Henry',
	['Turpid Broth']='Hippogryph Familiar',
	['Feculent Broth']='Daring Roland',
	['Wetland Broth']='Mosquito Familiar',
	['Heavenly Broth']='Left-Handed Yoko',
	['Wispy Broth']='Brave Hero Glenn',
	['Briny Broth']='Dapper Mac',
	['Cng. Brain Broth']='Crafty Clyvonne',
	['D. Herbal Broth']='Nursery Nazuna',
	['L. Carrot Broth']='Lucky Lulush',
	['Vermihumus']='Flowerpot Merle',
	['Wool Grease']='Dipper Yuly',
	['Deepbed Soil']='Discreet Louise',
	['C. Plasma Broth']='Fatso Fargann',
	['C. Grass Broth']='Presto Julio',
	['Bub. Carrion Broth']='Audacious Anna',
	['Gob. Bug Broth']='Mailbuster Cetas',
	['Lucky Broth']='Faithful Falcorr',
	['Mlw. Bird Broth']='Swift Sieghard',
	['Rzr. Brain Broth']='Bloodclaw Shasra',
	['Svg. Mole Broth']='Bugeyed Broncha',
	['Bur. Carrion Broth']='Gorefang Hobs',
	['Cl. Wheat Broth']='Gooey Gerard',
	['Shadowy Broth']='Crude Raphie',
	['Zestful Sap']='Yellow Beetle Familiar',
	['Gassy Sap']='Energized Sefina'
}

HQ_Jugs = T{
	['Putrescent Broth']='Decaying Broth',
	['Bug-Ridden Broth']='Electrified Broth',
	['Spumante Broth']='Frizzane Broth',
	['Tant. Broth']='Fizzy Broth',
	['Deepwater Broth']='Insipid Broth',
	['Venemous Broth']='Poisonous Broth',
	['Truly Pristine Sap']='Pristine Sap',
	['Pungent Broth']='Rancid Broth',
	['Windy Greens']='Salubrious Broth',
	['Ferm. Broth']='Shimmering Broth',
	['Bubbly Broth']='Spicy Broth',
	['Slimy Webbing']='Sticky Webbing',
	['Glazed Broth']='Sugary Broth',
	['Vis. Broth']='Swirling Broth',
	['Feculent Broth']='Trupid Broth',
	['Heavenly Broth']='Wetlands Broth',
	['Gassy Sap']='Zestful Sap'
}