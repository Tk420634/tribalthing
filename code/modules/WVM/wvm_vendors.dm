/obj/structure/wasteland_vendor/coolvendor
	name = "Sneed Galliway, the Coolvendor Template"
	desc = "Just your friendly merchant, here to have his vars overridden to inject some flavor into this soulless capitalistic vending machine."
	icon_state = "numed_idle"
	/// Can use tokens!
	/// * %PLAYERNAME is replaced with the player interacting's name (only usable in welcome, sale, and cantafford)
	/// * %A_RANDOM_STOCK is replace with "a(n) random thing I sell" (usable anywhere, but only really makes sense in idle and welcome)
	messages_idle = list(
		"Hey, come buy %A_RANDOM_STOCK!"
	)
	messages_welcome = list(
		"Welcome to my shop, %PLAYERNAME! You would probably find %A_RANDOM_STOCK handy."
	)
	messages_sale = list(
		"Here you go, %PLAYERNAME!"
	)
	messages_cantafford = list(
		"I'm sorry, %PLAYERNAME! I can't give credit!"
	)
	messages_badfaction = list(
		"Get out, %PLAYERNAME! Youre bad news!"
	)
	chatcolor = "#BEEDAD" // ferros
	
	
	prize_list = list(
		new /datum/data/wasteland_equipment("Syringe",                   /obj/item/reagent_containers/syringe,                    5),
		new /datum/data/wasteland_equipment("Radiation Blocker Bottle",  /obj/item/storage/pill_bottle/chem_tin/radx,             150),
		new /datum/data/wasteland_equipment("Radiation Purge",           /obj/item/reagent_containers/blood/radaway,              300),
		new /datum/data/wasteland_equipment("Stimpack",                  /obj/item/reagent_containers/hypospray/medipen/stimpak,  300),
		new /datum/data/wasteland_equipment("Basic Bandages",            /obj/item/stack/medical/gauze/improvised,                250),
		new /datum/data/wasteland_equipment("Basic Stitches",            /obj/item/stack/medical/suture/emergency/fifteen,        500),
		new /datum/data/wasteland_equipment("Healing Powder",            /obj/item/reagent_containers/pill/healingpowder,         250),
		new /datum/data/wasteland_equipment("Survival Medipen",          /obj/item/reagent_containers/hypospray/medipen/survival, 120),
		new /datum/data/wasteland_equipment("Improvised Defibrillator",  /obj/item/defibrillator/primitive,                       1000),
		)

//Tribal NPC
/obj/structure/wasteland_vendor/coolvendor/tribal/generic
	name = "Cookies-And-Cream"
	desc = "A curvy, short, nyampire merchant.  Here to sell supplies to the warriors!"
	icon_state = "tribalskunknpc"
	/// Can use tokens!
	/// * %PLAYERNAME is replaced with the player interacting's name (only usable in welcome, sale, and cantafford)
	/// * %A_RANDOM_STOCK is replace with "a(n) random thing I sell" (usable anywhere, but only really makes sense in idle and welcome)
	messages_idle = list(
		"Nyampires finest wears, such as a %A_RANDOM_STOCK!"
	)
	messages_welcome = list(
		"Greetings, %PLAYERNAME! Would you like a %A_RANDOM_STOCK?"
	)
	messages_sale = list(
		"Nyamaste, %PLAYERNAME!"
	)
	messages_cantafford = list(
		"I'm sorry, %PLAYERNAME! I can't give credit, go do some work!"
	)
	messages_badfaction = list(
		"Guards help, a murrine!!"
	)
	chatcolor = "#BEEDAD" // ferros
	
	
	prize_list = list(
		new /datum/data/wasteland_equipment("Torch",			/obj/item/flashlight/flare/torch, 					10),
		new /datum/data/wasteland_equipment("Sinew Cuffs",	       /obj/item/restraints/handcuffs/sinew, 						10),
		new /datum/data/wasteland_equipment("Snack Stick",	       /obj/item/reagent_containers/food/snacks/kebab, 						20),
		new /datum/data/wasteland_equipment("Dispute Stick",       /obj/item/melee/classic_baton/coyote/oldquarterstaff/disputestick, 	50),
		new /datum/data/wasteland_equipment("Sling",               /obj/item/gun/energy/kinetic_accelerator/crossbow/sling,           	75),
		new /datum/data/wasteland_equipment("Bola",                /obj/item/restraints/legcuffs/bola,                                	30),
		new /datum/data/wasteland_equipment("Nyacuahuitl",         /obj/item/melee/coyote/macuahuitl/nya,                             	100),
		new /datum/data/wasteland_equipment("Quartersnyaff",       /obj/item/melee/classic_baton/coyote/oldquarterstaff/nya,          	100),
		new /datum/data/wasteland_equipment("Brass Knyackles",     /obj/item/melee/unarmed/brass/knyackles,                           	100),
		new /datum/data/wasteland_equipment("Kittycat Gripwire",   /obj/item/restraints/legcuffs/beartrap,                            	50),
		new /datum/data/wasteland_equipment("Dart Musket",         /obj/item/gun/flintlock/musket/catgirl,                            	50),
		new /datum/data/wasteland_equipment("Dart Box",               /obj/item/ammo_box/foambox/catbox,                                 	20),
		
		)
 
	

//Murrine NPC
/obj/structure/wasteland_vendor/coolvendor/murrine/generic
	name = "Armory Sergeant Mick Fowler"
	desc = "A rough and ready Murrine Non-Commissioned soldier that runs the armory. He hates everyone, don't think it's just you."
	icon_state = "murrinedudenpc"
	/// Can use tokens!
	/// * %PLAYERNAME is replaced with the player interacting's name (only usable in welcome, sale, and cantafford)
	/// * %A_RANDOM_STOCK is replace with "a(n) random thing I sell" (usable anywhere, but only really makes sense in idle and welcome)
	messages_idle = list(
		"Buy %A_RANDOM_STOCK or go to hell!"
	)
	messages_welcome = list(
		"Hello %PLAYERNAME! Would you like a %A_RANDOM_STOCK? No? Tough shit, buy it anyway."
	)
	messages_sale = list(
		"Get outta my sight, %PLAYERNAME!"
	)
	messages_cantafford = list(
		"HHAHAHAHAHAHAHA, %PLAYERNAME! Do some WORK!"
	)
	messages_badfaction = list(
		"You'd look real good in a maid outfit, %PLAYERNAME! Want me to call the guards and hook you up?"
	)
	chatcolor = "#BEEDAD" // ferros
	
	
	prize_list = list(
		new /datum/data/wasteland_equipment("Flare",			/obj/item/flashlight/flare, 					10),
		new /datum/data/wasteland_equipment("Handcuffs",	       /obj/item/restraints/handcuffs/, 					10),
		new /datum/data/wasteland_equipment("Batong",			/obj/item/melee/classic_baton/telescopic, 					50),
		new /datum/data/wasteland_equipment("Disabler",			/obj/item/gun/energy/disabler,								75),
		new /datum/data/wasteland_equipment("Flashbang",		/obj/item/grenade/flashbang,                                30),
		new /datum/data/wasteland_equipment("Smoke Grenade",		/obj/item/grenade/smokebomb,                                30),
		new /datum/data/wasteland_equipment("Donksoft LMG",		/obj/item/gun/ballistic/automatic/lewis/murr,				150),
		new /datum/data/wasteland_equipment("Donksoft Turret",	/obj/item/turret_box/foam,                           		100),
		new /datum/data/wasteland_equipment("Crank Laser",		/obj/item/gun/energy/laser/cranklasergun/tg/spamlaser,		150),
		new /datum/data/wasteland_equipment("Shield",			/obj/item/shield/coyote/kiteshield,							50),
		new /datum/data/wasteland_equipment("Darts",			/obj/item/ammo_box/foambox/catbox,							20),
		)















/obj/structure/wasteland_vendor/medical
	name = "Wasteland Vending Machine - Medical"
	icon_state = "numed_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Radiation Blocker Bottle",  /obj/item/storage/pill_bottle/chem_tin/radx,             150),
		new /datum/data/wasteland_equipment("Radiation Purge",           /obj/item/reagent_containers/blood/radaway,              300),
		new /datum/data/wasteland_equipment("Stimpack",                  /obj/item/reagent_containers/hypospray/medipen/stimpak,  300),
		new /datum/data/wasteland_equipment("Basic Bandages",            /obj/item/stack/medical/gauze/improvised,                250),
		new /datum/data/wasteland_equipment("Basic Stitches",            /obj/item/stack/medical/suture/emergency/fifteen,        500),
		new /datum/data/wasteland_equipment("Healing Powder",            /obj/item/reagent_containers/pill/healingpowder,         250),
		new /datum/data/wasteland_equipment("Survival Medipen",          /obj/item/reagent_containers/hypospray/medipen/survival, 120),
		new /datum/data/wasteland_equipment("Improvised Defibrillator",  /obj/item/defibrillator/primitive,                       1000),
		)

/obj/structure/wasteland_vendor/supermedical
	name = "Clinic Vending Machine - Medical"
	icon_state = "numed_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Syringe",                           /obj/item/reagent_containers/syringe,              5),
		new /datum/data/wasteland_equipment("Rad-X Bottle",                      /obj/item/storage/pill_bottle/chem_tin/radx,       5),
		new /datum/data/wasteland_equipment("RadAway",                           /obj/item/reagent_containers/blood/radaway,        15),
		new /datum/data/wasteland_equipment("Standard Bandages",                 /obj/item/stack/medical/gauze,                     15),
		new /datum/data/wasteland_equipment("Standard Stitches",                 /obj/item/stack/medical/suture,                    15),
		new /datum/data/wasteland_equipment("Healing Powder Pack",               /obj/item/storage/box/medicine/powder5,            15),
		new /datum/data/wasteland_equipment("Bitter Drink Pack",                 /obj/item/storage/box/medicine/bitterdrink5,       20),
		new /datum/data/wasteland_equipment("Stimpak Pack",                      /obj/item/storage/box/medicine/stimpaks/stimpaks5, 30),
		new /datum/data/wasteland_equipment("Improvised Defibrillator",          /obj/item/defibrillator,                           75),
		new /datum/data/wasteland_equipment("Surgery for Wastelanders",          /obj/item/book/granter/trait/lowsurgery,           150),
		new /datum/data/wasteland_equipment("D.C. Journal of Internal Medicine", /obj/item/book/granter/trait/midsurgery,           500),
		new /datum/data/wasteland_equipment("Chemistry for Wastelanders",        /obj/item/book/granter/trait/chemistry,            1000)
		)

/obj/structure/wasteland_vendor/khanchem
	name = "P.A.P.A"
	icon_state = "khan_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Jet",                           /obj/item/reagent_containers/pill/patch/jet,                30),
		new /datum/data/wasteland_equipment("Psycho",                        /obj/item/reagent_containers/pill/patch/psycho,             30),
		new /datum/data/wasteland_equipment("Turbo",                         /obj/item/reagent_containers/pill/patch/turbo,              30),
		new /datum/data/wasteland_equipment("Mentats",                       /obj/item/storage/pill_bottle/chem_tin/mentats,             30),
		new /datum/data/wasteland_equipment("Buffout",                       /obj/item/storage/pill_bottle/chem_tin/buffout,             30),
		new /datum/data/wasteland_equipment("Med-X",                         /obj/item/reagent_containers/pill/patch/medx,               80),
		new /datum/data/wasteland_equipment("Fixer",                         /obj/item/storage/pill_bottle/chem_tin/fixer,               90),
		new /datum/data/wasteland_equipment("Great Khan helmet",             /obj/item/clothing/head/helmet/f13/khan,                    20),
		new /datum/data/wasteland_equipment("Great Khan bandana",            /obj/item/clothing/head/helmet/f13/khan/bandana,            20),
		new /datum/data/wasteland_equipment("Great Khan fur-trimmed helmet", /obj/item/clothing/head/helmet/f13/khan/pelt,               20),
		new /datum/data/wasteland_equipment("Great Khan full helmet",        /obj/item/clothing/head/helmet/f13/khan/fullhelm,           100),
		new /datum/data/wasteland_equipment("Great Khan battlecoat",         /obj/item/clothing/suit/toggle/labcoat/khan_jacket/coat,    300),
		new /datum/data/wasteland_equipment("Great Khan armored jacket",     /obj/item/clothing/suit/toggle/labcoat/khan_jacket/armored, 100),
		new /datum/data/wasteland_equipment("Great Khan jacket",             /obj/item/clothing/suit/toggle/labcoat/khan_jacket,         50),
		new /datum/data/wasteland_equipment("Great Khan uniform",            /obj/item/clothing/under/f13/khan,                          10),
		new /datum/data/wasteland_equipment("Great Khan Jorts",              /obj/item/clothing/under/f13/khan/shorts,                   10),
		new /datum/data/wasteland_equipment("Great Khan Booty Shorts",       /obj/item/clothing/under/f13/khan/booty,                    10),
		new /datum/data/wasteland_equipment("Great Khan boots",              /obj/item/clothing/shoes/f13/military/khan,                 15),
		new /datum/data/wasteland_equipment("Great Khan pelt boots",         /obj/item/clothing/shoes/f13/military/khan_pelt,            15)
		)

/obj/structure/wasteland_vendor/denchem
	name = "Chem Dispenser"
	icon_state = "med_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Jet",     /obj/item/reagent_containers/pill/patch/jet,    60),
		new /datum/data/wasteland_equipment("Psycho",  /obj/item/reagent_containers/pill/patch/psycho, 60),
		new /datum/data/wasteland_equipment("Turbo",   /obj/item/reagent_containers/pill/patch/turbo,  60),
		new /datum/data/wasteland_equipment("Mentats", /obj/item/storage/pill_bottle/chem_tin/mentats, 60),
		new /datum/data/wasteland_equipment("Buffout", /obj/item/storage/pill_bottle/chem_tin/buffout, 60),
		new /datum/data/wasteland_equipment("Med-X",   /obj/item/reagent_containers/pill/patch/medx,   60),
		new /datum/data/wasteland_equipment("Fixer",   /obj/item/storage/pill_bottle/chem_tin/fixer,   200)
		)

/obj/structure/wasteland_vendor/followerterminal
	name = "Follower's Resupply Terminal"
	desc = "a vending machine stocked with imported medical supplies. The pricing is to cover the cost of shipping and handling."
	icon_state = "med_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Soap",                       /obj/item/soap/syndie,                          5),
		new /datum/data/wasteland_equipment("Gas Mask",                   /obj/item/clothing/mask/gas,                    15),
		new /datum/data/wasteland_equipment("Advanced Mop",               /obj/item/mop/advanced,                         50),
		new /datum/data/wasteland_equipment("Fixer",                      /obj/item/storage/pill_bottle/chem_tin/fixer,   75),
		new /datum/data/wasteland_equipment("Metamaterial Beaker",        /obj/item/reagent_containers/glass/beaker/meta, 125),
		new /datum/data/wasteland_equipment("Medical HUD",                /obj/item/clothing/glasses/hud/health,          125),
		new /datum/data/wasteland_equipment("Prosthetic Left Arm",        /obj/item/bodypart/l_arm/robot,                 125),
		new /datum/data/wasteland_equipment("Prosthetic Right Arm",       /obj/item/bodypart/r_arm/robot,                 125),
		new /datum/data/wasteland_equipment("Prosthetic Left Leg",        /obj/item/bodypart/l_leg/robot,                 125),
		new /datum/data/wasteland_equipment("Prosthetic Right Leg",       /obj/item/bodypart/r_leg/robot,                 125),
		new /datum/data/wasteland_equipment("Integrated Toolset Implant", /obj/item/organ/cyberimp/arm/toolset,           150),
		new /datum/data/wasteland_equipment("Defibrillator",              /obj/item/defibrillator,                        175),
		new /datum/data/wasteland_equipment("Chest reviver Implant",      /obj/item/organ/cyberimp/chest/reviver,         250),
		new /datum/data/wasteland_equipment("Upgraded Prosthetic Limbs",  /obj/item/storage/box/sparelimbs,               300),
		new /datum/data/wasteland_equipment("Cat",                        /mob/living/simple_animal/pet/cat/Runtime,      2000),
		new /datum/data/wasteland_equipment("Portable Cell Charger",      /obj/item/storage/battery_box,                  50),
		)

/obj/structure/wasteland_vendor/weapons
	name = "Wasteland Vending Machine - Weapons"
	icon_state = "nuweapon_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("(1H Recoil I) Mesh Grip",	/obj/item/gun_upgrade/gripone,									150),
		new /datum/data/wasteland_equipment("(1H Recoil II) Styrene-Butadiene Grip",	/obj/item/gun_upgrade/griptwo,					250),
		new /datum/data/wasteland_equipment("(1H Recoil III) Gyration Stabilization Sleeve",	/obj/item/gun_upgrade/gripthree,		350),
		new /datum/data/wasteland_equipment("(2H Recoil I) Mesh Grip",		/obj/item/gun_upgrade/muzzleone,							150),
		new /datum/data/wasteland_equipment("(2H Recoil II) Mesh Grip",		/obj/item/gun_upgrade/muzzletwo,							150),
		new /datum/data/wasteland_equipment("(2H Recoil III) Mesh Grip",	/obj/item/gun_upgrade/muzzlethree,							150),
		new /datum/data/wasteland_equipment("(Fire Delay I) Match Trigger",		/obj/item/gun_upgrade/triggerone,						250),
		new /datum/data/wasteland_equipment("(Fire Delay II) Military Trigger",		/obj/item/gun_upgrade/triggertwo,					450),
		new /datum/data/wasteland_equipment("(Fire Delay III) Pristine Trigger",	/obj/item/gun_upgrade/triggerthree,					650),
		new /datum/data/wasteland_equipment("(Scope I) Reflex Sight",		/obj/item/gun_upgrade/sightone,								250),
		new /datum/data/wasteland_equipment("(Scope II) Old Scope",		/obj/item/gun_upgrade/sighttwo,									350),
		new /datum/data/wasteland_equipment("(Scope III) Pristine Scope",	/obj/item/gun_upgrade/sightthree,							550),
		)



/obj/structure/wasteland_vendor/ammo
	name = "Wasteland Vending Machine - Ammunition"
	icon_state = "nuammo_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment(".22lr BP Box (120 Bullets)",      /obj/item/ammo_box/b22,                     120),
		new /datum/data/wasteland_equipment(".22lr BP Crate (400 Bullets)",    /obj/item/ammo_box/b22/crate,               400),
		new /datum/data/wasteland_equipment("9mm BP Box (90 Bullets)",         /obj/item/ammo_box/b9mm,                    270),
		new /datum/data/wasteland_equipment("9mm BP Crate (360 Bullets)",      /obj/item/ammo_box/b9mm/crate,              700),
		new /datum/data/wasteland_equipment(".357 BP Box (90 Bullets)",        /obj/item/ammo_box/b357,                    270),
		new /datum/data/wasteland_equipment(".357 BP Crate (360 Bullets)",     /obj/item/ammo_box/b357/crate,              700),
		new /datum/data/wasteland_equipment(".44 BP Box (90 Bullets)",         /obj/item/ammo_box/b44,                     270),
		new /datum/data/wasteland_equipment(".44 BP Crate (360 Bullets)",      /obj/item/ammo_box/b44/crate,               700),
		new /datum/data/wasteland_equipment(".45 BP Box (90 Bullets)",         /obj/item/ammo_box/b45,                     270),
		new /datum/data/wasteland_equipment(".45 BP Crate (360 Bullets)",      /obj/item/ammo_box/b45/crate,               700),
		new /datum/data/wasteland_equipment("5.56 SL Box (60 Bullets)",        /obj/item/ammo_box/s556,                    330),
		new /datum/data/wasteland_equipment("5.56 SL Crate (240 Bullets)",     /obj/item/ammo_box/s556/crate,              900),
		new /datum/data/wasteland_equipment("7.62x39 SL Box (60 Bullets)",     /obj/item/ammo_box/s762by39,                330),
		new /datum/data/wasteland_equipment("7.62x39 SL Crate (240 Bullets)",  /obj/item/ammo_box/s762by39/crate,          900),
		new /datum/data/wasteland_equipment(".308 SL Box (30 Bullets)",        /obj/item/ammo_box/s308,                    400),
		new /datum/data/wasteland_equipment(".308 SL Crate (120 Bullets)",     /obj/item/ammo_box/s308/crate,              1000),
		new /datum/data/wasteland_equipment(".30-06 SL Box (30 Bullets)",      /obj/item/ammo_box/s3006,                   400),
		new /datum/data/wasteland_equipment(".30-06 SL Crate (120 Bullets)",   /obj/item/ammo_box/s3006/crate,             1000),
		new /datum/data/wasteland_equipment("Buckshot BP Box (60 Bullets)",    /obj/item/ammo_box/bbuckshot,               275),
		new /datum/data/wasteland_equipment("Buckshot SL Crate (240 Bullets)", /obj/item/ammo_box/sbuckshot/crate,         550),
		new /datum/data/wasteland_equipment("Field Arrow (1 arrow)",           /obj/item/ammo_casing/caseless/arrow/field, 100),
		new /datum/data/wasteland_equipment("Minie Ball Ammo",                 /obj/item/ammo_box/flintlock/minie,         500),
		)

/obj/structure/wasteland_vendor/badammo
	name = "Wasteland Vending Machine - Handloaded Ammunition"
	icon_state = "nuammo_idle"
	color = "#653800"
	prize_list = list(
		new /datum/data/wasteland_equipment(".22lr Box",                          /obj/item/ammo_box/m22,                     30),
		new /datum/data/wasteland_equipment("9mm Bag",                            /obj/item/ammo_box/c9mm/improvised,         30),
		new /datum/data/wasteland_equipment("10mm Bag",                           /obj/item/ammo_box/c10mm/improvised,        30),
		new /datum/data/wasteland_equipment(".45 Bag",                            /obj/item/ammo_box/c45/improvised,          30),
		new /datum/data/wasteland_equipment(".357 Bag",                           /obj/item/ammo_box/a357box/improvised,      30),
		new /datum/data/wasteland_equipment(".44 Bag",                            /obj/item/ammo_box/m44box/improvised,       30),
		new /datum/data/wasteland_equipment("5mm Bag",                            /obj/item/ammo_box/m5mmbox/improvised,      30),
		new /datum/data/wasteland_equipment("5.56x45 Bag",                        /obj/item/ammo_box/a556/improvised,         30),
		new /datum/data/wasteland_equipment(".308 Bag",                           /obj/item/ammo_box/a308box/improvised,      30),
		new /datum/data/wasteland_equipment("14mm Bag",                           /obj/item/ammo_box/m14mm/improvised,        30),
		new /datum/data/wasteland_equipment(".30-06 Bag",                         /obj/item/ammo_box/a3006box/improvised,     30),
		new /datum/data/wasteland_equipment("45-70 Bag",                          /obj/item/ammo_box/c4570box/improvised,     30),
		new /datum/data/wasteland_equipment("12 Gauge Buckshot box (12 shells)",  /obj/item/ammo_box/shotgun/buck,            30),
		new /datum/data/wasteland_equipment("12 Gauge Slug box  (12 shells)",     /obj/item/ammo_box/shotgun/slug,            30),
		new /datum/data/wasteland_equipment("Shoddy Energy Cell",                 /obj/item/stock_parts/cell/ammo/ec/bad,     30),
		new /datum/data/wasteland_equipment("Shoddy Microfusion Cell",            /obj/item/stock_parts/cell/ammo/mfc/bad,    30),
		new /datum/data/wasteland_equipment("Shoddy Electron Charge Pack",        /obj/item/stock_parts/cell/ammo/ecp/bad,    30),
		new /datum/data/wasteland_equipment("Laser Batteries (18 batteries)",     /obj/item/ammo_box/lasmusket,               30),
		new /datum/data/wasteland_equipment("Plasma Canisters (6 canisters)",     /obj/item/ammo_box/plasmamusket,            30),
		new /datum/data/wasteland_equipment("Black Powder Ammo",                  /obj/item/ammo_box/flintlock,               30),
		new /datum/data/wasteland_equipment("Portable Cell Charger",              /obj/item/storage/battery_box,              60),
		new /datum/data/wasteland_equipment("Field Arrow (1 arrow)",              /obj/item/ammo_casing/caseless/arrow/field, 7),
		)
	

/obj/structure/wasteland_vendor/clothing
	name = "Wasteland Vending Machine - Clothing"
	icon_state = "armor_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Worn outft",       /obj/item/clothing/under/f13/worn,      5),
		new /datum/data/wasteland_equipment("Settler outfit",   /obj/item/clothing/under/f13/settler,   15),
		new /datum/data/wasteland_equipment("Merchant outfit",  /obj/item/clothing/under/f13/merchant,  30),
		new /datum/data/wasteland_equipment("Followers outfit", /obj/item/clothing/under/f13/followers, 40),
		new /datum/data/wasteland_equipment("Combat uniform",   /obj/item/clothing/under/f13/combat,    50),
		// new /datum/data/wasteland_equipment("Ranger's Guide to the Wasteland",	/obj/item/book/granter/trait/trekking,							150)
		)


/obj/structure/wasteland_vendor/general
	name = "Wasteland Vending Machine - Adventuring"
	icon_state = "generic_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Drinking glass",							/obj/item/reagent_containers/food/drinks/drinkingglass,				5),
		new /datum/data/wasteland_equipment("Zippo",									/obj/item/lighter,													10),
		new /datum/data/wasteland_equipment("Explorer satchel",							/obj/item/storage/backpack/satchel/explorer,						15),
		new /datum/data/wasteland_equipment("Spray bottle",								/obj/item/reagent_containers/spray,									15),
		new /datum/data/wasteland_equipment("Bottle of E-Z-Nutrient",					/obj/item/reagent_containers/glass/bottle/nutrient/ez,				20),
		// new /datum/data/wasteland_equipment("Craftsmanship Monthly",					/obj/item/book/granter/trait/techno,								150),
		// new /datum/data/wasteland_equipment("Scav! Vol.1",								/obj/item/book/granter/crafting_recipe/scav_one,					250),
		// new /datum/data/wasteland_equipment("Portable Cell Charger",					/obj/item/storage/battery_box,										50),
		// new /datum/data/wasteland_equipment("Weapons of Texarkana", 					/obj/item/book/granter/crafting_recipe/ODF,							150),
		// new /datum/data/wasteland_equipment("Ranger's Guide to the Wasteland",			/obj/item/book/granter/trait/trekking,								350),
		new /datum/data/wasteland_equipment("Rift Repelling Machine",					/obj/item/packaged_respawner_blocker,								100), 
		new /datum/data/wasteland_equipment("Glowstick Pouch",							/obj/item/storage/fancy/flare_pouch/glowstick,						150), 
		new /datum/data/wasteland_equipment("Flare Pouch",								/obj/item/storage/fancy/flare_pouch,								150), // larp
		new /datum/data/wasteland_equipment("Hand teleporter",							/obj/item/hand_tele,												1000),
		new /datum/data/wasteland_equipment("Blue Flashlight (Tier 2)",					/obj/item/flashlight/blue,											150),
		new /datum/data/wasteland_equipment("Seclite (Tier 3)",							/obj/item/flashlight/seclite,										300),
		new /datum/data/wasteland_equipment("Prospector Lamp (Tier 2)",					/obj/item/flashlight/lantern/mining,								500),
		new /datum/data/wasteland_equipment("Lantern (Tier 3)",							/obj/item/flashlight/lantern,										500),
		new /datum/data/wasteland_equipment("Fulton Pack",								/obj/item/extraction_pack,											500),
		new /datum/data/wasteland_equipment("Fulton Core",								/obj/item/fulton_core,												400),
		)


/* These are shit, don't add them.

/obj/structure/wasteland_vendor/camp
	name = "Wasteland Camp-O-Vend"
	icon_state = "generic_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Basic Edition",			/obj/item/survivalcapsule,								50),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Premium Edition",		/obj/item/survivalcapsule/premium,						100),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Expanded Edition",		/obj/item/survivalcapsule/quad,							150),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Merchant Edition",		/obj/item/survivalcapsule/merchant,						300),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Party-Tent Edition",	/obj/item/survivalcapsule/party,						150),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Mess-Hall Edition",		/obj/item/survivalcapsule/kitchen,						250),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Farm-N-Go Edition",		/obj/item/survivalcapsule/farm,							200),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Occult Edition",		/obj/item/survivalcapsule/fortuneteller,				125),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Smithery Edition",		/obj/item/survivalcapsule/blacksmith,					400),
		new /datum/data/wasteland_equipment("Vault-Tec C.A.M.P. Ultra-Deluxe Edition",	/obj/item/survivalcapsule/super_deluxe,					600),
		new /datum/data/wasteland_equipment("Keep your C.A.M.P. Clean: Trashbag",		/obj/item/storage/bag/trash,							30),
		new /datum/data/wasteland_equipment("Keep your C.A.M.P. Clean: Soap",			/obj/item/soap/homemade,								25)
		)

*/

/obj/structure/wasteland_vendor/pipboy
	name = "New Boston Vending Machine - Identification"
	icon_state = "pipboy"
	prize_list = list(
		new /datum/data/wasteland_equipment("Datapal PDA",			/obj/item/pda,																25),
		new /datum/data/wasteland_equipment("Reprogrammable ID",	/obj/item/card/id/selfassign,												20),
		new /datum/data/wasteland_equipment("E.N.H.A.N.C.E. Your Datapal: Reagent Scanner",	/obj/item/cartridge/chemistry,						10),
		new /datum/data/wasteland_equipment("E.N.H.A.N.C.E. Your Datapal: Health Scanner",	/obj/item/cartridge/medical,						10),
		new /datum/data/wasteland_equipment("E.N.H.A.N.C.E. Your Datapal: Signaler",	/obj/item/cartridge/signal,								10),
		new /datum/data/wasteland_equipment("V270-Band Signal Divination Device",	/obj/item/pinpointer/validball_finder,						10),
		)


/obj/structure/wasteland_vendor/special
	name = "New Boston Vending Machine - Money Exchanger"
	desc = "An automated machine that exhanges copper coins for more valuable ones. However, it takes a 10% cut."
	icon_state = "liberationstation_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Oobie Biddilets", 			/obj/item/toy/plush/lizardplushie/kobold/scrip, 						50000),
		// new /datum/data/wasteland_equipment("Union Scrip x20", 			/obj/item/stack/f13Cash/ncr/twenty, 						11),
		// new /datum/data/wasteland_equipment("Union Scrip x40", 			/obj/item/stack/f13Cash/ncr/fourty, 						22),
		// new /datum/data/wasteland_equipment("Union Scrip x80", 			/obj/item/stack/f13Cash/ncr/eighty, 						44),
		// new /datum/data/wasteland_equipment("Union Scrip x200", 		/obj/item/stack/f13Cash/ncr/twohundo, 						110),
		// new /datum/data/wasteland_equipment("Union Scrip x1000", 		/obj/item/stack/f13Cash/ncr/onekay, 						550),
		// new /datum/data/wasteland_equipment("Union Scrip x5000", 		/obj/item/stack/f13Cash/ncr/fivegees, 						2750),
		new /datum/data/wasteland_equipment("Silver Dollar x1", 		/obj/item/stack/f13Cash/denarius, 							11),
		new /datum/data/wasteland_equipment("Silver Dollar x5", 		/obj/item/stack/f13Cash/denarius/five, 						55),
		new /datum/data/wasteland_equipment("Silver Dollar x10", 		/obj/item/stack/f13Cash/denarius/ten, 						110),
		new /datum/data/wasteland_equipment("Silver Dollar x20", 		/obj/item/stack/f13Cash/denarius/twenty, 					220),
		new /datum/data/wasteland_equipment("Silver Dollar x100", 		/obj/item/stack/f13Cash/denarius/hundo, 					1100),
		new /datum/data/wasteland_equipment("Golden Thaler x1", 		/obj/item/stack/f13Cash/aureus, 							110),
		new /datum/data/wasteland_equipment("Golden Thaler x5", 		/obj/item/stack/f13Cash/aureus/five, 						550),
		new /datum/data/wasteland_equipment("Golden Thaler x10", 		/obj/item/stack/f13Cash/aureus/ten, 						1100),
		new /datum/data/wasteland_equipment("Golden Thaler x100", 		/obj/item/stack/f13Cash/aureus/hundo, 						11000),
		/*new /datum/data/wasteland_equipment("Low Roller Bounty Ticket", 			/obj/item/card/lowbounty,						120), // Disabled to prevent money duping through cargo
		new /datum/data/wasteland_equipment("Medium Roller Bounty Ticket", 			/obj/item/card/midbounty, 						240),
		new /datum/data/wasteland_equipment("High Roller Bounty Ticket", 			/obj/item/card/highbounty, 						480),
		new /datum/data/wasteland_equipment("King's Bounty Ticket", 				/obj/item/card/kingbounty, 						960)*/
		)
	

/obj/structure/wasteland_vendor/specialplus
	name = "Automatic Teller Machine"
	desc = "An automated machine that exhanges copper coins for more valuable currency. This teller is specialized for bankers to provide better exchange rates."
	icon_state = "liberationstation_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Oobie Biddilets", 			/obj/item/toy/plush/lizardplushie/kobold/scrip, 						50000),
		// new /datum/data/wasteland_equipment("Union Scrip x20", 			/obj/item/stack/f13Cash/ncr/twenty, 						10),
		// new /datum/data/wasteland_equipment("Union Scrip x40", 			/obj/item/stack/f13Cash/ncr/fourty, 						20),
		// new /datum/data/wasteland_equipment("Union Scrip x80", 			/obj/item/stack/f13Cash/ncr/eighty, 						40),
		// new /datum/data/wasteland_equipment("Union Scrip x200", 		/obj/item/stack/f13Cash/ncr/twohundo, 						100),
		// new /datum/data/wasteland_equipment("Union Scrip x1000", 		/obj/item/stack/f13Cash/ncr/onekay, 						500),
		// new /datum/data/wasteland_equipment("Union Scrip x5000", 		/obj/item/stack/f13Cash/ncr/fivegees, 						2500),
		new /datum/data/wasteland_equipment("Silver Dollar x5", 		/obj/item/stack/f13Cash/denarius/five, 						50),
		new /datum/data/wasteland_equipment("Silver Dollar x10", 		/obj/item/stack/f13Cash/denarius/ten, 						100),
		new /datum/data/wasteland_equipment("Silver Dollar x20", 		/obj/item/stack/f13Cash/denarius/twenty, 					200),
		new /datum/data/wasteland_equipment("Silver Dollar x100", 		/obj/item/stack/f13Cash/denarius/hundo, 					1000),
		new /datum/data/wasteland_equipment("Golden Thaler x1", 		/obj/item/stack/f13Cash/aureus, 							100),
		new /datum/data/wasteland_equipment("Golden Thaler x5", 		/obj/item/stack/f13Cash/aureus/five, 						500),
		new /datum/data/wasteland_equipment("Golden Thaler x10", 		/obj/item/stack/f13Cash/aureus/ten, 						1000),
		new /datum/data/wasteland_equipment("Golden Thaler x100", 		/obj/item/stack/f13Cash/aureus/hundo, 						10000),
		)
	

/obj/structure/wasteland_vendor/traderspecial
	name = "Union Vending Machine - Matvend"
	desc = "An automated machine that exchanges currency for raw materials."
	icon_state = "trade_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Oobie Biddilets", 			/obj/item/toy/plush/lizardplushie/kobold/scrip, 							50000),
		new /datum/data/wasteland_equipment("Plasma x1",						/obj/item/stack/sheet/mineral/plasma,								200),
		new /datum/data/wasteland_equipment("Diamond x1",						/obj/item/stack/sheet/mineral/diamond,								150),
		new /datum/data/wasteland_equipment("Gold x1",							/obj/item/stack/sheet/mineral/gold,									100),
		new /datum/data/wasteland_equipment("Silver x1",						/obj/item/stack/sheet/mineral/silver,								10),
		new /datum/data/wasteland_equipment("Uranium x1",						/obj/item/stack/sheet/mineral/uranium,								30),
		new /datum/data/wasteland_equipment("Netherium Crystal x1",				/obj/item/stack/ore/bluespace_crystal,								300),
		new /datum/data/wasteland_equipment("Titanium x1",						/obj/item/stack/sheet/mineral/titanium,								30),
		new /datum/data/wasteland_equipment("Metal x20",						/obj/item/stack/sheet/metal/twenty,									10),
		new /datum/data/wasteland_equipment("Glass x10",						/obj/item/stack/sheet/glass/ten,									5),
		new /datum/data/wasteland_equipment("Plasteel x5",						/obj/item/stack/sheet/plasteel/five,								200),
		new /datum/data/wasteland_equipment("Plastic x5",						/obj/item/stack/sheet/plastic/five,									25),
		new /datum/data/wasteland_equipment("Electronic Parts x3",				/obj/item/stack/crafting/electronicparts/three,						3),
		new /datum/data/wasteland_equipment("Metal Parts x5",					/obj/item/stack/crafting/metalparts/five,							5),
		new /datum/data/wasteland_equipment("Good Metal Parts x3",				/obj/item/stack/crafting/goodparts/three,							6),
		new /datum/data/wasteland_equipment("Cardboard x20",					/obj/item/stack/sheet/cardboard/twenty,								20),
		new /datum/data/wasteland_equipment("(T1) Black Bronze x1",				/obj/item/ingot/bronze,												350), // 40 coins more expensive than hand making to buy
		new /datum/data/wasteland_equipment("(T2) Mythril x1",					/obj/item/ingot/mythril,											600), // 350 + 200 = 550, add another 50 as tax
		new /datum/data/wasteland_equipment("(T3) Adamantine x1",				/obj/item/ingot/adamantine,											800), // 600 + 200, cost of superlight Pre-Cataclysm alloys, no more tax
		new /datum/data/wasteland_equipment("Lollipop x1",						/obj/item/reagent_containers/food/snacks/lollipop,					2),
		new /datum/data/wasteland_equipment("Gumball x1",						/obj/item/reagent_containers/food/snacks/gumball,					4),
		new /datum/data/wasteland_equipment("Butter x1",						/obj/item/reagent_containers/food/snacks/butter,					5),
		new /datum/data/wasteland_equipment("Deluxe Stock Part Box x1",			/obj/item/storage/box/stockparts/deluxe,							1000),
		new /datum/data/wasteland_equipment("Advanced Modular Receiver",		/obj/item/advanced_crafting_components/receiver,					250),
		new /datum/data/wasteland_equipment("Weapon Assembly",					/obj/item/advanced_crafting_components/assembly,					250),
		new /datum/data/wasteland_equipment("Superconductor Coils",				/obj/item/advanced_crafting_components/conductors,					250),
		new /datum/data/wasteland_equipment("Focused crystal lenses",			/obj/item/advanced_crafting_components/lenses,						250),
		new /datum/data/wasteland_equipment("Flux capacitator",					/obj/item/advanced_crafting_components/flux,						250),
		new /datum/data/wasteland_equipment("Superlight Alloys",				/obj/item/advanced_crafting_components/alloys,						250),
		)
	

/obj/structure/wasteland_vendor/advcomponents
	name = "Wasteland Vending Machine - Components"
	icon_state = "generic_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Advanced Modular Receiver",		/obj/item/advanced_crafting_components/receiver,					50),
		new /datum/data/wasteland_equipment("Weapon Assembly",					/obj/item/advanced_crafting_components/assembly,					50),
		new /datum/data/wasteland_equipment("Superconductor Coils",				/obj/item/advanced_crafting_components/conductors,					50),
		new /datum/data/wasteland_equipment("Focused crystal lenses",			/obj/item/advanced_crafting_components/lenses,						50),
		new /datum/data/wasteland_equipment("Flux capacitator",					/obj/item/advanced_crafting_components/flux,						50),
		new /datum/data/wasteland_equipment("Superlight Alloys",				/obj/item/advanced_crafting_components/alloys,						50),
		new /datum/data/wasteland_equipment("Nest Repellant",					/obj/item/packaged_respawner_blocker,					0),
		)
	

/obj/structure/wasteland_vendor/attachments
	name = "Wasteland Vending Machine - Discount Armor and Better Attachments"
	icon_state = "seller_attachments"
	prize_list = list(
		new /datum/data/wasteland_equipment("Radiation Suit",										/obj/item/clothing/suit/radiation,								20),
		new /datum/data/wasteland_equipment("Radiation Suit Hood",									/obj/item/clothing/head/radiation,								20),
		new /datum/data/wasteland_equipment("Wasteland Explorer Armor",								/obj/item/clothing/suit/hooded/explorer,						40),
		new /datum/data/wasteland_equipment("SEVA Environment Suit",								/obj/item/clothing/suit/hooded/explorer/seva,					40),
		new /datum/data/wasteland_equipment("Military Gas Mask",									/obj/item/clothing/mask/gas/explorer,							20),
		new /datum/data/wasteland_equipment("(T1 Barrel) Heavy Barrel",								/obj/item/gun_upgrade/barrelone,								100),
		new /datum/data/wasteland_equipment("(T2 Barrel) Magnetic Accelerator Coil",				/obj/item/gun_upgrade/barreltwo,								150),
		new /datum/data/wasteland_equipment("(T3 Barrel) Polarized Magnetic Hyper-Accelerator",		/obj/item/gun_upgrade/barrelthree,								200),
		new /datum/data/wasteland_equipment("(T1 Chip) Reinforced Energy Pump",						/obj/item/gun_upgrade/chipone,									100),
		new /datum/data/wasteland_equipment("(T2 Chip) Dynamo Booster",								/obj/item/gun_upgrade/chiptwo,									150),
		new /datum/data/wasteland_equipment("(T3 Chip) Miniature Fusion Reactor",					/obj/item/gun_upgrade/chipthree,								200),
		new /datum/data/wasteland_equipment("(T1 Grip) Mesh Grip",									/obj/item/gun_upgrade/gripone,									100),
		new /datum/data/wasteland_equipment("(T2 Grip) Styrene-Butadiene Grip",						/obj/item/gun_upgrade/griptwo,									150),
		new /datum/data/wasteland_equipment("(T3 Grip) Gyration Stabilization Sleeve",				/obj/item/gun_upgrade/gripthree,								200),
		new /datum/data/wasteland_equipment("(T1 Muzzle) Muzzle Device",							/obj/item/gun_upgrade/muzzleone,								100),
		new /datum/data/wasteland_equipment("(T2 Muzzle) Military Muzzle Device",					/obj/item/gun_upgrade/muzzletwo,								150),
		new /datum/data/wasteland_equipment("(T3 Muzzle) Research Muzzle Device",					/obj/item/gun_upgrade/muzzlethree,								200),
		new /datum/data/wasteland_equipment("(T1 Trigger) Match Trigger",							/obj/item/gun_upgrade/triggerone,								100),
		new /datum/data/wasteland_equipment("(T2 Trigger) Military Trigger",						/obj/item/gun_upgrade/triggertwo,								150),
		new /datum/data/wasteland_equipment("(T3 Trigger) Pristine Trigger",						/obj/item/gun_upgrade/triggerthree,								200),
		new /datum/data/wasteland_equipment("(T1 Scope) Reflex Sight",								/obj/item/gun_upgrade/sightone,									100),
		new /datum/data/wasteland_equipment("(T2 Scope) Old Scope",									/obj/item/gun_upgrade/sighttwo,									150),
		new /datum/data/wasteland_equipment("(T3 Scope) Pristine Scope",							/obj/item/gun_upgrade/sightthree,								200),
		new /datum/data/wasteland_equipment("(T1 Paint) Red Paint",									/obj/item/gun_upgrade/paint/red,								100),
		new /datum/data/wasteland_equipment("(T1 Paint) Blue Paint",								/obj/item/gun_upgrade/paint/blue,								100),
		new /datum/data/wasteland_equipment("(T1 Paint) Yellow Paint",								/obj/item/gun_upgrade/paint/yellow,								100),
		)


/obj/structure/wasteland_vendor/badattachments
	name = "Wasteland Vending Machine - Armor and Attachments"
	icon_state = "seller_attachments"
	color = "#684800"
	prize_list = list(
		new /datum/data/wasteland_equipment("Radiation Suit",							/obj/item/clothing/suit/radiation,								20),
		new /datum/data/wasteland_equipment("Radiation Suit Hood",						/obj/item/clothing/head/radiation,								20),
		new /datum/data/wasteland_equipment("Wasteland Explorer Armor",					/obj/item/clothing/suit/hooded/explorer,						40),
		new /datum/data/wasteland_equipment("SEVA Environment Suit",					/obj/item/clothing/suit/hooded/explorer/seva,					40),
		new /datum/data/wasteland_equipment("Military Gas Mask",						/obj/item/clothing/mask/gas/explorer,							20),
		new /datum/data/wasteland_equipment("Heavy Barrel",								/obj/item/gun_upgrade/barrelone,								100),
		new /datum/data/wasteland_equipment("Magnetic Accelerator Coil",				/obj/item/gun_upgrade/barreltwo,								150),
		new /datum/data/wasteland_equipment("Polarized Magnetic Hyper-Accelerator",		/obj/item/gun_upgrade/barrelthree,								200),
		new /datum/data/wasteland_equipment("Reinforced Energy Pump",					/obj/item/gun_upgrade/chipone,									100),
		new /datum/data/wasteland_equipment("Dynamo Booster",							/obj/item/gun_upgrade/chiptwo,									150),
		new /datum/data/wasteland_equipment("Miniature Fusion Reactor",					/obj/item/gun_upgrade/chipthree,								200),
		new /datum/data/wasteland_equipment("Mesh Grip",								/obj/item/gun_upgrade/gripone,									100),
		new /datum/data/wasteland_equipment("Styrene-Butadiene Grip",					/obj/item/gun_upgrade/griptwo,									150),
		new /datum/data/wasteland_equipment("Gyration Stabilization Sleeve",			/obj/item/gun_upgrade/gripthree,								200),
		new /datum/data/wasteland_equipment("Muzzle Device",							/obj/item/gun_upgrade/muzzleone,								100),
		new /datum/data/wasteland_equipment("Military Muzzle Device",					/obj/item/gun_upgrade/muzzletwo,								150),
		new /datum/data/wasteland_equipment("Research Muzzle Device",					/obj/item/gun_upgrade/muzzlethree,								200),
		new /datum/data/wasteland_equipment("Match Trigger",							/obj/item/gun_upgrade/triggerone,								100),
		new /datum/data/wasteland_equipment("Military Trigger",							/obj/item/gun_upgrade/triggertwo,								150),
		new /datum/data/wasteland_equipment("Pristine Trigger",							/obj/item/gun_upgrade/triggerthree,								200),
		new /datum/data/wasteland_equipment("Reflex Sight",								/obj/item/gun_upgrade/sightone,									100),
		new /datum/data/wasteland_equipment("Old Scope",								/obj/item/gun_upgrade/sighttwo,									150),
		new /datum/data/wasteland_equipment("Pristine Scope",							/obj/item/gun_upgrade/sightthree,								200),
		new /datum/data/wasteland_equipment("Red Paint",								/obj/item/gun_upgrade/paint/red,								100),
		new /datum/data/wasteland_equipment("Blue Paint",								/obj/item/gun_upgrade/paint/blue,								150),
		new /datum/data/wasteland_equipment("Yellow Paint",								/obj/item/gun_upgrade/paint/yellow,								150)
		)
	

/obj/structure/wasteland_vendor/crafting
	name = "Wasteland Vending Machine - Crafting"
	icon_state = "seller_crafting"
	prize_list = list(
		new /datum/data/wasteland_equipment("Metal Parts (x5)",					/obj/item/stack/crafting/metalparts/five,							100),
		new /datum/data/wasteland_equipment("High Quality Metal Parts (x5)",	/obj/item/stack/crafting/goodparts/five,							250),
		new /datum/data/wasteland_equipment("Electronic Parts (x5)",			/obj/item/stack/crafting/electronicparts/five,						250),
		new /datum/data/wasteland_equipment("Metal Sheets (x20)",				/obj/item/stack/sheet/metal/twenty,									300),
		new /datum/data/wasteland_equipment("Metal Sheets (x50)",				/obj/item/stack/sheet/metal/fifty,									650),
		new /datum/data/wasteland_equipment("Glass Sheets (x10)",				/obj/item/stack/sheet/glass/ten,									100),
		new /datum/data/wasteland_equipment("Glass Sheets (x50)",				/obj/item/stack/sheet/glass/fifty,									500),
		new /datum/data/wasteland_equipment("Sacks of Concrete (x50)",			/obj/item/stack/sheet/mineral/concrete/fifty,						200),
		new /datum/data/wasteland_equipment("Art Canvas 19x19",					/obj/item/canvas/nineteenXnineteen,									20),
		new /datum/data/wasteland_equipment("Art Canvas 23x19",					/obj/item/canvas/twentythreeXnineteen,								20),
		new /datum/data/wasteland_equipment("Art Canvas 23x23",					/obj/item/canvas/twentythreeXtwentythree,							20),
		new /datum/data/wasteland_equipment("Mechanical Toolbox",				/obj/item/storage/toolbox/mechanical,								150),
		new /datum/data/wasteland_equipment("Electrician Toolbox",				/obj/item/storage/toolbox/electrical,								150),
		new /datum/data/wasteland_equipment("Insulated Gloves",					/obj/item/clothing/gloves/color/yellow,								150)
		)
	

/obj/structure/wasteland_vendor/mining
	name = "Wasteland Vending Machine - Mining and Salvage"
	icon_state = "generic_idle"
	prize_list = list(
		new /datum/data/wasteland_equipment("Pickaxe",							/obj/item/pickaxe,											300),
		new /datum/data/wasteland_equipment("Mining drill",						/obj/item/pickaxe/drill,									600),
		new /datum/data/wasteland_equipment("Manual mining scanner",			/obj/item/mining_scanner,									200),
		new /datum/data/wasteland_equipment("Automatic mining scanner",			/obj/item/t_scanner/adv_mining_scanner/lesser,				400),
		new /datum/data/wasteland_equipment("Advanced mining scanner",			/obj/item/t_scanner/adv_mining_scanner,						600),
		new /datum/data/wasteland_equipment("Welding goggles",					/obj/item/clothing/glasses/welding,							200),
		new /datum/data/wasteland_equipment("Industrial welding tool",			/obj/item/weldingtool/largetank,							150),
		new /datum/data/wasteland_equipment("Upgraded industrial welding tool",	/obj/item/weldingtool/hugetank,								250),
		new /datum/data/wasteland_equipment("Experimental welding tool",		/obj/item/weldingtool/experimental,							1000),
		new /datum/data/wasteland_equipment("Hand drill",						/obj/item/screwdriver/power,								300),
		new /datum/data/wasteland_equipment("Jaws of life",						/obj/item/crowbar/power,									1000),
		new /datum/data/wasteland_equipment("ORM Board",						/obj/item/circuitboard/machine/ore_redemption,				300),
		)
	

/datum/data/wasteland_equipment
	var/equipment_name = "generic"
	var/atom/equipment_path = null
	var/cost = 0

/datum/data/wasteland_equipment/New(name, path, cost)
	src.equipment_name = name
	src.equipment_path = path
	src.cost = cost
