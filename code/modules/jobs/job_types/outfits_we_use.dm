/* 
 * File:   outfits_we_use.dm
 * Author: werty and the GoonSquad
 * Date: 2010-07-07
 * License: AeFalleToTheMoon
 * 
 * Description: This file contains the code for the outfits that we use for our folkers
 * Purpose: To make it so these damn outfits arent blended in with the job datums and
 * make it so us illiterate folk can actually know the what the heck is going on
 * So suck it
 */

////////////////////////
// Base Wasteland Outfit
// This is the base default outfit for just about everyone
// please please please base everything off this
/datum/outfit/job/cb	
	name = "Wastelander"
	jobtype = /datum/job/wasteland/f13wastelander

	uniform = list(
		/obj/item/clothing/under/f13/settler,
		/obj/item/clothing/under/f13/brahminm,
		/obj/item/clothing/under/f13/lumberjack,
		/obj/item/clothing/under/f13/roving,
		/obj/item/clothing/under/f13/gentlesuit,
		/obj/item/clothing/under/f13/formal,
		/obj/item/clothing/under/f13/spring,
		/obj/item/clothing/under/f13/relaxedwear,
		/obj/item/clothing/under/f13/machinist,
		/obj/item/clothing/under/f13/brahminf,
		/obj/item/clothing/under/f13/cowboyb,
		/obj/item/clothing/under/f13/cowboyg,
		/obj/item/clothing/under/f13/cowboyt,
	)
	id = null // /obj/item/pda
	ears     = /obj/item/radio/headset/headset_town
	belt     = /obj/item/supplykit
	backpack = /obj/item/storage/backpack
	satchel  = /obj/item/storage/backpack/satchel/leather
	shoes    = list(
		/obj/item/clothing/shoes/workboots,
		/obj/item/clothing/shoes/jackboots,
	)
	l_pocket = null // /obj/item/storage/survivalkit
	r_pocket = null // /obj/item/storage/survivalkit/medical
	pda = null //  /obj/item/pda
	//backpack_contents null //  = list(
	// 	/obj/item/storage/wallet/stash/low
	// )
	stuff_we_all_get = null //  list(
	// /obj/item/card/id/selfassign
	// )

/datum/outfit/job/cb/pre_equip(mob/living/carbon/human/H)
	. = ..()
	// if(isrobotic(H))
		// box = /obj/item/storage/survivalkit/medical/synth

/datum/outfit/job/cb/catgirl
	name = "catgirl base"
	
/datum/outfit/job/cb/catgirl/warrior
	name = "warrior"
	head = /obj/item/clothing/head/helmet/f13/wayfarer/antler 
	backpack = /obj/item/storage/backpack/trekker
	uniform = /obj/item/clothing/under/civ/mayan_loincloth
	suit = /obj/item/clothing/suit/armor/light/tribal/bone
	shoes = /obj/item/clothing/shoes/sandal
	belt = /obj/item/storage/belt/utility/mining/primitive
	gloves = /obj/item/clothing/gloves/thief
	tribal = TRUE
	cat = TRUE
	backpack_contents   = list(
	/obj/item/melee/classic_baton/coyote/oldquarterstaff/disputestick,
	/obj/item/warpaint_bowl,
	/obj/item/restraints/legcuffs/bola = 2,
	/obj/item/gun/energy/kinetic_accelerator/crossbow/sling,
	)

/datum/outfit/job/cb/catgirl/jagnyarwarrior
	name = "Jagnyar Warrior"
	head = /obj/item/clothing/head/helmet/f13/wayfarer/antler 
	backpack = /obj/item/storage/backpack/trekker
	uniform = /obj/item/clothing/under/civ/mayan_loincloth
	suit = /obj/item/clothing/suit/armor/light/tribal/bone/jagnyar
	shoes = /obj/item/clothing/shoes/sandal
	belt = /obj/item/storage/belt/utility/mining/primitive
	gloves = /obj/item/clothing/gloves/thief
	tribal = TRUE
	cat = TRUE
	superzoomies = TRUE
	backpack_contents   = list(
		/obj/item/melee/coyote/macuahuitl/nya = 1,
		/obj/item/warpaint_bowl,
		/obj/item/restraints/legcuffs/bola = 2,
		/obj/item/gun/energy/kinetic_accelerator/crossbow/sling,
	)

/datum/outfit/job/cb/catgirl/stickspinner
	name = "Stick-Spinner"
	head = /obj/item/clothing/head/helmet/f13/wayfarer/antler 
	backpack = /obj/item/storage/backpack/trekker
	uniform = /obj/item/clothing/under/civ/mayan_loincloth
	suit = /obj/item/clothing/suit/armor/light/tribal/bone/stickspinner
	shoes = /obj/item/clothing/shoes/sandal
	belt = /obj/item/storage/belt/utility/mining/primitive
	gloves = /obj/item/clothing/gloves/thief
	tribal = TRUE
	cat = TRUE
	backpack_contents   = list(
	/obj/item/melee/classic_baton/coyote/oldquarterstaff/nya = 1,
	/obj/item/warpaint_bowl,
	)

/datum/outfit/job/cb/catgirl/warrior/nyanfiltrator
	name = "Nyanfiltrator"
	head = null
	suit = null
	backpack = null
	uniform = /obj/item/clothing/under/civ/mayan_loincloth
	shoes = /obj/item/clothing/shoes/sandal
	belt = /obj/item/stealthboy
	gloves = /obj/item/clothing/gloves/thief
	l_pocket = /obj/item/melee/unarmed/brass/knyackles
	r_pocket = /obj/item/melee/unarmed/brass/knyackles
	tribal = TRUE
	cat = TRUE

/datum/outfit/job/cb/catgirl/warrior/catnapper
	name = "Catnapper"
	head = /obj/item/clothing/head/helmet/f13/deathskull
	suit = null
	backpack = /obj/item/storage/backpack/trekker
	uniform = /obj/item/clothing/under/civ/mayan_loincloth
	shoes = /obj/item/clothing/shoes/sandal
	belt = null
	gloves = /obj/item/clothing/gloves/thief
	backpack_contents   = list(
		/obj/item/restraints/legcuffs/beartrap = 6,
		/obj/item/melee/classic_baton/coyote/oldquarterstaff/disputestick,
		/obj/item/warpaint_bowl,
		/obj/item/restraints/legcuffs/bola = 4,
		)
	tribal = TRUE
	cat = TRUE

/datum/outfit/job/cb/catgirl/warrior/influencer
	name = "Influencer"
	head = null
	suit = null
	backpack = null
	uniform = /obj/item/clothing/under/civ/mayan_loincloth
	shoes = /obj/item/clothing/shoes/sandal
	belt = null
	gloves = /obj/item/clothing/gloves/thief
	tribal = TRUE
	cat = TRUE

/datum/outfit/job/cb/catgirl/warrior/sniper
	name = "cat sniper"
	head = /obj/item/clothing/head/kevlarhelmet/ghillie
	backpack = /obj/item/storage/backpack/trekker
	uniform = /obj/item/clothing/under/civ/mayan_loincloth
	suit = /obj/item/clothing/suit/civ13/coat/ghillie
	shoes = /obj/item/clothing/shoes/sandal
	belt = /obj/item/storage/bag/casings
	gloves = /obj/item/clothing/gloves/thief
	tribal = TRUE
	cat = TRUE
	backpack_contents   = list(
	/obj/item/warpaint_bowl,
	/obj/item/gun/flintlock/musket/catgirl,
	/obj/item/ammo_box/foambox/catbox
		)

/datum/outfit/job/cb/catgirl/warrior/head
	name = "head warrior"
	head = /obj/item/clothing/head/poppycrown
	tribal = TRUE
	cat = TRUE

/datum/outfit/job/cb/catgirl/warrior/captured
	name = "captured murrine"
	uniform = /obj/item/clothing/under/f13/exile/tribal/shimsusa_loincloth
	tribal = FALSE
	head = null
	backpack = null
	suit = null
	shoes = null
	belt = null
	gloves = null
	backpack_contents = list()
	murrine = TRUE


/datum/outfit/job/cb/guild
	name = "Guild Base"
	ears = /obj/item/radio/headset/headset_town/guild
	id = null

/datum/outfit/job/cb/guild/barkeep
	name = "Barkeep"
	jobtype = /datum/job/townfolk/f13barkeep
	uniform = /obj/item/clothing/under/f13/bartenderalt

/datum/outfit/job/cb/guild/curator
	name = "Curator"
	jobtype = /datum/job/townfolk/librarian

/datum/outfit/job/cb/guild/preacher
	name = "Preacher"
	jobtype = /datum/job/townfolk/preacher
	uniform  = /obj/item/clothing/under/f13/chaplain
	suit_store = /obj/item/nullrod
	l_pocket = /obj/item/storage/fancy/candle_box
	r_pocket = /obj/item/storage/book/bible

/datum/outfit/job/cb/guild/club
	name = "Club Worker"
	jobtype = /datum/job/townfolk/club_worker
	l_pocket = /obj/item/cool_book/hnguide

/datum/outfit/job/cb/guild/club/manager
	name = "Club Manager"
	jobtype = /datum/job/townfolk/club_manager
	id = /obj/item/storage/wallet/stash/high
	card = /obj/item/card/id/silver
	pda = /obj/item/pda

/datum/outfit/job/cb/capturedcatgirl
	uniform = /obj/item/clothing/under/skyrat/maid
	head = null
	backpack = null
	suit = null
	shoes = null
	belt = null
	gloves = null
	backpack_contents = list()
	tribal = TRUE
	cat = TRUE

/datum/outfit/job/cb/guild/deputy
	name = "Trooper"
	jobtype = /datum/job/townfolk/f13deputy
	head = /obj/item/clothing/head/helmet/swat
	belt = /obj/item/storage/belt/army
	uniform = /obj/item/clothing/under/f13/enclave/peacekeeper
	suit = /obj/item/clothing/suit/armor/light/leather
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	shoes = /obj/item/clothing/shoes/jackboots
	backpack_contents = list(
		/obj/item/grenade/flashbang = 3,
		/obj/item/melee/classic_baton/telescopic = 1,
		/obj/item/gun/energy/disabler = 1,
		/obj/item/flashlight/seclite = 1
	)
	murrine = TRUE

/datum/outfit/job/cb/guild/deputy/housekeeping
	name = "Housekeeping Specialist"
	head = /obj/item/clothing/head/beret/purple
	belt = /obj/item/storage/belt/army
	uniform = /obj/item/clothing/under/f13/enclave/peacekeeper
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	shoes = /obj/item/clothing/shoes/jackboots
	backpack_contents = list(
		/obj/item/melee/classic_baton/telescopic = 1,
		/obj/item/flashlight/seclite = 1
	)
	murrine = TRUE

/datum/outfit/job/cb/guild/deputy/gunner
	name = "Dart Gunner"
	jobtype = /datum/job/townfolk/f13deputy
	head = /obj/item/clothing/head/beret/enclave
	belt = /obj/item/storage/bag/casings
	uniform = /obj/item/clothing/under/f13/enclave/peacekeeper
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	shoes = /obj/item/clothing/shoes/jackboots
	suit_store = /obj/item/gun/ballistic/automatic/lewis/murr
	backpack_contents = list(
		/obj/item/melee/classic_baton/telescopic = 1,
		/obj/item/flashlight/seclite = 1
	)
	murrine = TRUE

/datum/outfit/job/cb/guild/deputy/engineer
	name = "Murrine Engineer"
	jobtype = /datum/job/townfolk/f13deputy
	head = /obj/item/clothing/head/beret/eng
	belt = /obj/item/storage/bag/casings
	uniform = /obj/item/clothing/under/f13/enclave/peacekeeper
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	shoes = /obj/item/clothing/shoes/jackboots
	suit_store = null
	backpack_contents = list(
		/obj/item/melee/classic_baton/telescopic = 1,
		/obj/item/flashlight/seclite = 1,
		/obj/item/ammo_box/foambox/catbox = 2,
		/obj/item/turret_box/foam,
	)
	l_pocket = /obj/item/multitool
	murrine = TRUE

/datum/outfit/job/cb/guild/deputy/ranger
	name = "Murrine Ranger"
	jobtype = /datum/job/townfolk/f13deputy
	head = /obj/item/clothing/head/beret/ncr/ncr_sof
	belt = null
	uniform = /obj/item/clothing/under/f13/enclave/peacekeeper
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	shoes = /obj/item/clothing/shoes/jackboots/fast
	suit_store = /obj/item/gun/energy/laser/cranklasergun/tg/spamlaser
	backpack_contents = list(
		/obj/item/melee/classic_baton/telescopic = 1,
		/obj/item/flashlight/seclite = 1,
	)
	murrine = TRUE

/datum/outfit/job/cb/guild/deputy/bruiser
	name = "Murrine Bruiser"
	jobtype = /datum/job/townfolk/f13deputy
	head = /obj/item/clothing/head/beret/ncr/ncr_sof/bruiser
	belt = null
	uniform = /obj/item/clothing/under/f13/enclave/peacekeeper
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	shoes = /obj/item/clothing/shoes/jackboots
	suit_store = null
	backpack_contents = list(
		/obj/item/melee/coyote/club/whomper = 1,
		/obj/item/shield/coyote/kiteshield = 1,
	)
	murrine = TRUE


/datum/outfit/job/cb/guild/deputy/grenadier
	name = "Murrine Grenadier"
	jobtype = /datum/job/townfolk/f13deputy
	head = /obj/item/clothing/head/f13/army/beret
	belt = null
	uniform = /obj/item/clothing/under/f13/enclave/peacekeeper
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	shoes = /obj/item/clothing/shoes/jackboots
	suit_store = null
	backpack_contents = list(
		/obj/item/melee/classic_baton/telescopic = 1,
		/obj/item/gun/energy/disabler = 1,
		/obj/item/grenade/smokebomb = 4,
		/obj/item/grenade/barrier = 2,
		/obj/item/grenade/flashbang = 4,
	)
	murrine = TRUE


/datum/outfit/job/cb/guild/deputy/sheriff
	name = "Squad Leader"
	jobtype = /datum/job/townfolk/f13sheriff
	head = /obj/item/clothing/head/beret
	belt = /obj/item/storage/belt/army
	uniform = /obj/item/clothing/under/f13/enclave/peacekeeper
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	shoes = /obj/item/clothing/shoes/jackboots
	backpack_contents = list(
		/obj/item/melee/classic_baton/telescopic = 1,
		/obj/item/gun/energy/disabler = 1,
		/obj/item/flashlight/seclite = 1
	)
	murrine = TRUE

/datum/outfit/job/cb/guild/radio
	name = "Radio Operator"
	jobtype = /datum/job/townie/radiooperator
	card =	/obj/item/card/id/silver
	stuff_we_all_get = list(
		/obj/item/card/id/selfassign,
		/obj/item/clothing/mask/chameleon,
	)

///////////////////////////////
/// REDWATER OUTFITS
/datum/outfit/job/cb/redwater
	name = "Redwater Townie"
	jobtype = /datum/job/redwater/townie
	uniform = list(
		/obj/item/clothing/under/f13/settler,
		/obj/item/clothing/under/f13/brahminm,
		/obj/item/clothing/under/f13/lumberjack,
		/obj/item/clothing/under/f13/roving,
		/obj/item/clothing/under/f13/gentlesuit,
		/obj/item/clothing/under/f13/formal,
		/obj/item/clothing/under/f13/spring,
		/obj/item/clothing/under/f13/relaxedwear,
		/obj/item/clothing/under/f13/machinist,
		/obj/item/clothing/under/f13/brahminf,
		/obj/item/clothing/under/f13/cowboyb,
		/obj/item/clothing/under/f13/cowboyg,
		/obj/item/clothing/under/f13/cowboyt,
		/obj/item/clothing/under/f13/merca,
		/obj/item/clothing/under/f13/mercc,
		/obj/item/clothing/under/f13/cowboyb,
		/obj/item/clothing/under/f13/cowboyg,
		/obj/item/clothing/under/f13/raider_leather,
		/obj/item/clothing/under/f13/raiderrags,
		/obj/item/clothing/under/pants/f13/ghoul,
		/obj/item/clothing/under/jabroni,
	)
	suit = list(
		/obj/item/clothing/suit/armor/light/raider/supafly,
		/obj/item/clothing/suit/armor/medium/raider/yankee,
		/obj/item/clothing/suit/armor/light/raider/sadist,
		/obj/item/clothing/suit/armor/medium/raider/blastmaster,
		/obj/item/clothing/suit/armor/medium/raider/badlands,
		/obj/item/clothing/suit/armor/light/raider/painspike,
	)
	mask = list(
		/obj/item/clothing/mask/bandana/red,
		/obj/item/clothing/mask/bandana/blue,
		/obj/item/clothing/mask/bandana/green,
		/obj/item/clothing/mask/bandana/gold,
		/obj/item/clothing/mask/bandana/black,
		/obj/item/clothing/mask/bandana/skull,
	)
	neck = list(
		/obj/item/clothing/neck/mantle/peltfur,
		/obj/item/clothing/neck/mantle/peltmountain,
		/obj/item/clothing/neck/mantle/poncho,
		/obj/item/clothing/neck/mantle/ragged,
		/obj/item/clothing/neck/mantle/brown,
		/obj/item/clothing/neck/mantle/gecko,
		/obj/item/clothing/neck/garlic_necklace,
	)
	head = list(
		/obj/item/clothing/head/sombrero,
		/obj/item/clothing/head/helmet/f13/raider,
		/obj/item/clothing/head/helmet/f13/raider/eyebot,
		/obj/item/clothing/head/helmet/f13/raider/arclight,
		/obj/item/clothing/head/helmet/f13/raider/blastmaster,
		/obj/item/clothing/head/helmet/f13/raider/yankee,
		/obj/item/clothing/head/helmet/f13/raider/psychotic,
		/obj/item/clothing/head/helmet/f13/fiend,
		/obj/item/clothing/head/helmet/f13/hoodedmask,
		/obj/item/clothing/head/helmet/f13/motorcycle,
		/obj/item/clothing/head/helmet/f13/wastewarhat,
		/obj/item/clothing/head/helmet/f13/fiend,
		/obj/item/clothing/head/f13/bandit,
		/obj/item/clothing/head/f13/ranger_hat/banded,
		/obj/item/clothing/head/helmet/rus_ushanka,
		/obj/item/clothing/head/helmet/skull,
		/obj/item/clothing/head/collectable/petehat/gang,
		/obj/item/clothing/head/hunter,
		/obj/item/clothing/head/rice_hat,
		/obj/item/clothing/head/papersack/smiley,
		/obj/item/clothing/head/f13/pot,
		/obj/item/clothing/head/cone,
		/obj/item/clothing/head/kabuto,
		/obj/item/clothing/head/cowboyhat/sec,
		/obj/item/clothing/head/bomb_hood,
		/obj/item/clothing/head/cardborg,
		/obj/item/clothing/head/assu_helmet,
		/obj/item/clothing/head/chefhat,
		/obj/item/clothing/head/beret/headband,
		/obj/item/clothing/head/fedora,
		/obj/item/clothing/head/bowler,
	)
	shoes = /obj/item/clothing/shoes/f13/raidertreads
	stuff_we_all_get = list(
		/obj/item/restraints/handcuffs = 2,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 1,
		/obj/item/radio/redwater = 1,
	)

///////////////////////////////
/// ASHDOWNS OUTFITS
/datum/outfit/job/cb/ashdown
	name = "Ashdown Citizen"
	jobtype = /datum/job/wasteland/f13wastelander

	uniform = list(
		/obj/item/clothing/under/f13/settler,
		/obj/item/clothing/under/f13/brahminm,
		/obj/item/clothing/under/f13/lumberjack,
		/obj/item/clothing/under/f13/roving
	)
	ears     = /obj/item/radio/headset/headset_town
	belt     = /obj/item/supplykit
	backpack = /obj/item/storage/backpack
	satchel  = /obj/item/storage/backpack/satchel/leather
	shoes    = /obj/item/clothing/shoes/workboots
	backpack_contents = list(
		/obj/item/card/id/selfassign = 1,
		/obj/item/storage/wallet/stash/low = 1,
		// /obj/item/cool_book/ashdowncit = 1,
	)

/*
/datum/outfit/job/cb/ashdown/biker
	name     = "Hells Nomad"
	jobtype  = /datum/job/ashdown/biker
	suit     = /obj/item/clothing/suit/armor/light/duster/brahmin/biker
	ears     = /obj/item/radio/headset/headset_biker
	head     = /obj/item/clothing/head/helmet/f13/khan/bandana
	backpack = /obj/item/storage/backpack/satchel/explorer
	satchel  = /obj/item/storage/backpack/satchel/old
	uniform  = /obj/item/clothing/under/f13/khan/biker
	belt     = /obj/item/supplykit
	box      = /obj/item/storage/survivalkit
	box_two  = /obj/item/storage/survivalkit/medical
	backpack_contents = list(
		/obj/item/pda = 1,
		/obj/item/storage/wallet/stash/low = 1,
		/obj/item/cool_book/ashdowncit = 1
		)
	tattoos_they_get = list(/datum/tattoo/biker)

/datum/outfit/job/cb/ashdown/biker/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/gate_biker)
*/

/////////////////////////////
// BASE TUNNEL RAT OUTFIT //
///////////////////////////
/// machete, welding helmet, technophreak, better meds I guess???
/datum/outfit/job/cb/tunnelrats // clearly the best job
	name = "Tunnel Rats Base"
	jobtype = /datum/job/tunnelrats

	// box_two = /obj/item/storage/survivalkit/medical/follower
	head = /obj/item/clothing/head/welding/up
	suit_store = /obj/item/melee/onehanded/machete
	technophreak = TRUE

////////////////////////
// TUNNEL RAT BOSS OUTFIT
////////////////////////
/// machete, welding mask, technophreak, better meds I guess???
/datum/outfit/job/cb/tunnelrats/boss
	name = "Tunnel Rats Giant Rat"
	jobtype = /datum/job/tunnelrats/bigratthatmakestherules

	// box_two = /obj/item/storage/survivalkit/medical/follower
	head = null
	mask = /obj/item/clothing/mask/gas/welding/up
	suit_store = /obj/item/melee/onehanded/machete/forgedmachete

////////////////////////
// TRIBAL BASIC

/datum/outfit/job/cb/tribal
	name = "Far-Lands Tribal"
	jobtype = /datum/job/wasteland/f13tribal

	belt = /obj/item/supplykit
	uniform = /obj/item/clothing/under/f13/settler
	shoes = /obj/item/clothing/shoes/sandal
	backpack = /obj/item/storage/backpack/satchel/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	box = /obj/item/storage/survivalkit/tribal
	// box_two = /obj/item/storage/survivalkit/medical/tribal
	backpack_contents = list(
		/obj/item/pda = 1,
		/obj/item/card/id/selfassign,
		/obj/item/flashlight/flare/torch,
	)



////// LOADOUTS for jobs with extra equipment
/datum/outfit/loadout/miner
	name = "Loadout Miner"
	backpack_contents = list(
		/obj/item/storage/bag/ore = 1,
		/obj/item/weldingtool/largetank = 1,
		/obj/item/pickaxe/mini = 1,
		/obj/item/shovel = 1,
		/obj/item/storage/bag/salvage = 1,
		/obj/item/clothing/mask/gas/welding = 1,
		/obj/item/t_scanner/adv_mining_scanner/lesser = 1,
	)

/datum/outfit/loadout/farmer
	name = "Loadout Farmer"
	backpack_contents = list(
		/obj/item/storage/bag/plants/portaseeder = 1,
		/obj/item/cultivator=1,
		/obj/item/hatchet=1,
		/obj/item/shovel/spade=1,
	)

/datum/outfit/loadout/diner
	name = "Diner"
	backpack_contents = list(
		/obj/item/clothing/neck/apron/chef = 1,
		/obj/item/book/manual/nuka_recipes = 1,
		/obj/item/storage/box/ingredients/wildcard = 1,
		/obj/item/storage/box/ingredients/fiesta = 1,
		/obj/item/storage/box/ingredients/italian = 1,
		/obj/item/storage/box/ingredients/vegetarian = 1,
		/obj/item/storage/box/ingredients/american = 1,
		/obj/item/storage/box/ingredients/fruity = 1,
		/obj/item/storage/box/ingredients/sweets = 1,
		/obj/item/storage/box/ingredients/delights = 1,
		/obj/item/storage/box/ingredients/grains = 1,
		/obj/item/storage/box/ingredients/carnivore = 1,
		/obj/item/storage/box/ingredients/exotic = 1,
		/obj/item/storage/box/ingredients/sushi = 1
	)




