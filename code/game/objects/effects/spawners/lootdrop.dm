/obj/effect/spawner/lootdrop
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "random_loot"
	layer = OBJ_LAYER
	var/spawn_on_turf = TRUE
	var/lootcount = 1		//how many items will be spawned
	var/lootdoubles = TRUE	//if the same item can be spawned twice
	var/list/loot			//a list of possible items to spawn e.g. list(/obj/item, /obj/structure, /obj/effect)
	var/fan_out_items = FALSE //Whether the items should be distributed to offsets 0,1,-1,2,-2,3,-3.. This overrides pixel_x/y on the spawner itself
	var/delay_spawn = FALSE // allows trash spawners to know what it spawned
	/// Chance of going up a tier. 0-100
	var/uptier_chance = 0
	/// List of items to pick from if the spawner rolled to go up a tier
	var/list/uptier_list
	/// Chance of going down a tier. 0-100
	var/downtier_chance = 0
	/// List of items to pick from if the spawner rolled to go down a tier
	var/list/downtier_list
	/// did we adjust tier?
	var/tier_adjusted = FALSE
	/// Will we be subject to The Loot Snap? If so, what category of snap?
	var/snap_category
	/// Should we spread our loot to adjacent tiles? Set to 0 or null to disable.
	var/fan_out_turfs_range
	/// This is the ckey of the player who spawned this lootdrop (if any). Used for quests and other stuff like that where the player needs to do something themself. Copied to the looted_by var in conjunction with looted_when and looted_coordinates for this purpose.
	var/mylooter
	/// we use trash piles now! which should this turn into?
	var/obj/item/storage/trash_stack/lootpile
/*
/obj/effect/spawner/lootdrop/New(loc, looter)
	mylooter = looter
	..()
*/
/obj/effect/spawner/lootdrop/Initialize(mapload, block_tier_swap, survived_snap)
	. = ..()
	if(!mapload)
		lootpile = null
	if(!mapload && ismob(usr))
		var/mob/U = usr
		mylooter = ckey(U?.ckey)
	return startup_procedure(mapload, block_tier_swap, survived_snap)

/obj/effect/spawner/lootdrop/proc/startup_procedure(mapload, block_tier_swap, survived_snap)
	adjust_tier(block_tier_swap)
	if(cull_spawners(mapload, block_tier_swap, survived_snap))
		return INITIALIZE_HINT_NORMAL
	if(mapload && lootpile)
		if(locate(/obj/item/storage/trash_stack) in get_turf(src))
			return INITIALIZE_HINT_QDEL
		new lootpile(get_turf(src))
		return INITIALIZE_HINT_QDEL
	if(delay_spawn) // you have *checks watch* until the end of this frame to spawn the stuff. Otherwise it'll look wierd
		RegisterSignal(src, COMSIG_ATOM_POST_ADMIN_SPAWN,PROC_REF(spawn_the_stuff))
		return INITIALIZE_HINT_NORMAL // have fun!
	spawn_the_stuff() // lov dan
	return INITIALIZE_HINT_QDEL

/obj/effect/spawner/lootdrop/proc/cull_spawners(mapload)
	if(!mapload || tier_adjusted)
		snap_category = null
		return
	if(snap_category)
		icon = 'icons/effects/effects.dmi'
		icon_state = "nothing" // hide it!
		SSitemspawners.add_to_culling(src, snap_category)
		return TRUE

/obj/effect/spawner/lootdrop/proc/adjust_tier(block_tier_swap)
	if(block_tier_swap)
		return
	if(LAZYLEN(uptier_list) && prob(uptier_chance))
		loot = uptier_list
		tier_adjusted = TRUE
	else if(LAZYLEN(downtier_list) && prob(downtier_chance))
		loot = downtier_list
		tier_adjusted = TRUE

/obj/effect/spawner/lootdrop/proc/spawn_the_stuff(list/listhack, looter)
	if(!LAZYLEN(loot))
		qdel(src)
		return
	var/atom/A = spawn_on_turf ? get_turf(src) : loc
	. = list()
	for(var/tospawn in 1 to min(lootcount, LAZYLEN(loot)))
		var/lootspawn = pickweight(loot)
		if(!lootspawn)
			qdel(src)
			return
		if(!lootdoubles)
			loot.Remove(lootspawn)
		if(lootspawn)
			var/atom/movable/spawned_loot
			if(fan_out_turfs_range > 0 && isturf(A))
				var/turf/AT = find_obstruction_free_location(fan_out_turfs_range, A)
				if(isturf(AT))
					spawned_loot = SpawnTheLootDrop(AT, lootspawn)
				else
					spawned_loot = SpawnTheLootDrop(A, lootspawn)
			else
				spawned_loot = SpawnTheLootDrop(A, lootspawn)
			. |= spawned_loot
			if(fan_out_items && isobj(spawned_loot))
				var/obj/L = spawned_loot
				L.pixel_x = rand(-12,12)
				L.pixel_y = rand(-12,12)
			else
				if(pixel_x != 0)
					spawned_loot.pixel_x = pixel_x
				if(pixel_y != 0)
					spawned_loot.pixel_y = pixel_y
			if(isitem(spawned_loot))
				var/obj/item/I = spawned_loot
				I.looted_when = world.time
				I.looted_coordinates = "[x];[y];[z]"
				I.looted_by = mylooter
	if(delay_spawn)
		qdel(src)

/obj/effect/spawner/lootdrop/proc/SpawnTheLootDrop(loc, path) // This makes sure the item is properly casted to the correct type, as /obj/item/stack doesn't like new() when you cast it as atom/movable :(
	if(ispath(path, /obj/item/stack))
		var/amount = rand(1,3)
		var/obj/item/stack/S = new path(loc, amount)
		return S
	
	var/block_recursive_tier_swap = (tier_adjusted && ispath(path, /obj/effect/spawner/lootdrop))
	var/atom/movable/spawned_loot = new path(loc, block_recursive_tier_swap)
	return spawned_loot


/obj/effect/spawner/lootdrop/bedsheet
	icon = 'icons/obj/bedsheets.dmi'
	icon_state = "random_bedsheet"
	name = "random dorms bedsheet"
	loot = list(/obj/item/bedsheet = 8, /obj/item/bedsheet/blue = 8, /obj/item/bedsheet/green = 8,
				/obj/item/bedsheet/grey = 8, /obj/item/bedsheet/orange = 8, /obj/item/bedsheet/purple = 8,
				/obj/item/bedsheet/red = 8, /obj/item/bedsheet/yellow = 8, /obj/item/bedsheet/brown = 8,
				/obj/item/bedsheet/black = 8, /obj/item/bedsheet/patriot = 3, /obj/item/bedsheet/rainbow = 3,
				/obj/item/bedsheet/ian = 3, /obj/item/bedsheet/runtime = 3, /obj/item/bedsheet/nanotrasen = 3,
				/obj/item/bedsheet/pirate = 1, /obj/item/bedsheet/gondola = 1
				)

/obj/effect/spawner/lootdrop/armory_contraband
	name = "armory contraband gun spawner"
	lootdoubles = FALSE
	loot = list(
				/obj/item/gun/ballistic/automatic/pistol = 8,
				/obj/item/gun/ballistic/shotgun/automatic/combat = 5,
				/obj/item/gun/ballistic/revolver/m29/snub,
				/obj/item/gun/ballistic/automatic/pistol/deagle
				)

/obj/effect/spawner/lootdrop/armory_contraband/metastation
	loot = list(/obj/item/gun/ballistic/automatic/pistol = 5,
				/obj/item/gun/ballistic/shotgun/automatic/combat = 5,
				/obj/item/gun/ballistic/revolver/m29/snub,
				/obj/item/gun/ballistic/automatic/pistol/deagle,
				/obj/item/storage/box/syndie_kit/throwing_weapons = 3)

/obj/effect/spawner/lootdrop/gambling
	name = "gambling valuables spawner"
	loot = list(
				/obj/item/gun/ballistic/revolver/russian = 5,
				/obj/item/storage/box/syndie_kit/throwing_weapons = 1,
				/obj/item/toy/cards/deck/syndicate = 2
				)

/obj/effect/spawner/lootdrop/grille_or_trash
	name = "maint grille or trash spawner"
	loot = list(/obj/structure/grille = 5,
			/obj/item/cigbutt = 1,
			/obj/item/trash/cheesie = 1,
			/obj/item/trash/candy = 1,
			/obj/item/trash/chips = 1,
			/obj/item/reagent_containers/food/snacks/deadmouse = 1,
			/obj/item/trash/pistachios = 1,
			/obj/item/trash/plate = 1,
			/obj/item/trash/popcorn = 1,
			/obj/item/trash/raisins = 1,
			/obj/item/trash/sosjerky = 1,
			/obj/item/trash/syndi_cakes = 1)

/obj/effect/spawner/lootdrop/three_course_meal
	name = "three course meal spawner"
	lootcount = 3
	lootdoubles = FALSE
	var/soups = list(
			/obj/item/reagent_containers/food/snacks/soup/beet,
			/obj/item/reagent_containers/food/snacks/soup/sweetpotato,
			/obj/item/reagent_containers/food/snacks/soup/stew,
			/obj/item/reagent_containers/food/snacks/soup/hotchili,
			/obj/item/reagent_containers/food/snacks/soup/nettle,
			/obj/item/reagent_containers/food/snacks/soup/meatball)
	var/salads = list(
			/obj/item/reagent_containers/food/snacks/salad/herbsalad,
			/obj/item/reagent_containers/food/snacks/salad/validsalad,
			/obj/item/reagent_containers/food/snacks/salad/fruit,
			/obj/item/reagent_containers/food/snacks/salad/jungle,
			/obj/item/reagent_containers/food/snacks/salad/aesirsalad)
	var/mains = list(
			/obj/item/reagent_containers/food/snacks/bearsteak,
			/obj/item/reagent_containers/food/snacks/enchiladas,
			/obj/item/reagent_containers/food/snacks/stewedsoymeat,
			/obj/item/reagent_containers/food/snacks/burger/bigbite,
			/obj/item/reagent_containers/food/snacks/burger/superbite,
			/obj/item/reagent_containers/food/snacks/burger/fivealarm)

/obj/effect/spawner/lootdrop/three_course_meal/Initialize(mapload)
	loot = list(pick(soups) = 1,pick(salads) = 1,pick(mains) = 1)
	. = ..()

/obj/effect/spawner/lootdrop/maintenance
	name = "maintenance loot spawner"
	// see code/_globalvars/lists/maintenance_loot.dm for loot table

/obj/effect/spawner/lootdrop/maintenance/Initialize(mapload)
	loot = GLOB.maintenance_loot
	. = ..()

/obj/effect/spawner/lootdrop/glowstick
	name = "random colored glowstick"
	icon = 'icons/obj/lighting.dmi'
	icon_state = "random_glowstick"

/obj/effect/spawner/lootdrop/glowstick/Initialize()
	loot = typesof(/obj/item/flashlight/glowstick)
	. = ..()

/obj/effect/spawner/lootdrop/gloves
	name = "random gloves"
	desc = "These gloves are supposed to be a random color..."
	icon = 'icons/obj/clothing/gloves.dmi'
	icon_state = "random_gloves"
	loot = list(
		/obj/item/clothing/gloves/color/orange = 1,
		/obj/item/clothing/gloves/color/red = 1,
		/obj/item/clothing/gloves/color/blue = 1,
		/obj/item/clothing/gloves/color/purple = 1,
		/obj/item/clothing/gloves/color/green = 1,
		/obj/item/clothing/gloves/color/grey = 1,
		/obj/item/clothing/gloves/color/light_brown = 1,
		/obj/item/clothing/gloves/color/brown = 1,
		/obj/item/clothing/gloves/color/white = 1,
		/obj/item/clothing/gloves/color/rainbow = 1)

/obj/effect/spawner/lootdrop/crate_spawner
	name = "lootcrate spawner" //USE PROMO CODE "SELLOUT" FOR 20% OFF!
	lootdoubles = FALSE
	loot = list(
				/obj/structure/closet/crate/secure/loot = 20,
				"" = 80
				)

/obj/effect/spawner/lootdrop/organ_spawner
	name = "organ spawner"
	loot = list(
		/obj/item/organ/heart/gland/electric = 3,
		/obj/item/organ/heart/gland/trauma = 4,
		/obj/item/organ/heart/gland/egg = 7,
		/obj/item/organ/heart/gland/chem = 5,
		/obj/item/organ/heart/gland/mindshock = 5,
		/obj/item/organ/heart/gland/plasma = 7,
		/obj/item/organ/heart/gland/transform = 5,
		/obj/item/organ/heart/gland/slime = 4,
		/obj/item/organ/heart/gland/spiderman = 5,
		/obj/item/organ/heart/gland/ventcrawling = 1,
		/obj/item/organ/body_egg/alien_embryo = 1,
		/obj/item/organ/regenerative_core = 2)
	lootcount = 3

/obj/effect/spawner/lootdrop/two_percent_xeno_egg_spawner
	name = "2% chance xeno egg spawner"
	loot = list(
		/obj/effect/decal/remains/xeno = 49,
		/obj/effect/spawner/xeno_egg_delivery = 1)

/obj/effect/spawner/lootdrop/costume
	name = "random costume spawner"

/obj/effect/spawner/lootdrop/costume/Initialize()
	loot = list()
	for(var/path in subtypesof(/obj/effect/spawner/bundle/costume))
		loot[path] = TRUE
	. = ..()

// Minor lootdrops follow

/obj/effect/spawner/lootdrop/minor/beret_or_rabbitears
	name = "beret or rabbit ears spawner"
	loot = list(
		/obj/item/clothing/head/beret = 1,
		/obj/item/clothing/head/rabbitears = 1)

/obj/effect/spawner/lootdrop/minor/bowler_or_that
	name = "bowler or top hat spawner"
	loot = list(
		/obj/item/clothing/head/bowler = 1,
		/obj/item/clothing/head/that = 1)

/obj/effect/spawner/lootdrop/minor/kittyears_or_rabbitears
	name = "kitty ears or rabbit ears spawner"
	loot = list(
		/obj/item/clothing/head/simplekitty = 1,
		/obj/item/clothing/head/rabbitears = 1)

/obj/effect/spawner/lootdrop/minor/pirate_or_bandana
	name = "pirate hat or bandana spawner"
	loot = list(
		/obj/item/clothing/head/pirate = 1,
		/obj/item/clothing/head/bandana = 1)

/obj/effect/spawner/lootdrop/minor/twentyfive_percent_cyborg_mask
	name = "25% cyborg mask spawner"
	loot = list(
		/obj/item/clothing/mask/gas/cyborg = 25,
		"" = 75)

/obj/effect/spawner/lootdrop/aimodule_harmless // These shouldn't allow the AI to start butchering people
	name = "harmless AI module spawner"
	loot = list(
				/obj/item/aiModule/core/full/asimov,
				/obj/item/aiModule/core/full/asimovpp,
				/obj/item/aiModule/core/full/hippocratic,
				/obj/item/aiModule/core/full/paladin_devotion,
				/obj/item/aiModule/core/full/paladin
				)

/obj/effect/spawner/lootdrop/aimodule_neutral // These shouldn't allow the AI to start butchering people without reason
	name = "neutral AI module spawner"
	loot = list(
				/obj/item/aiModule/core/full/corp,
				/obj/item/aiModule/core/full/maintain,
				/obj/item/aiModule/core/full/drone,
				/obj/item/aiModule/core/full/peacekeeper,
				/obj/item/aiModule/core/full/reporter,
				/obj/item/aiModule/core/full/robocop,
				/obj/item/aiModule/core/full/liveandletlive,
				/obj/item/aiModule/core/full/hulkamania
				)

/obj/effect/spawner/lootdrop/aimodule_harmful // These will get the shuttle called
	name = "harmful AI module spawner"
	loot = list(
				/obj/item/aiModule/core/full/antimov,
				/obj/item/aiModule/core/full/balance,
				/obj/item/aiModule/core/full/tyrant,
				/obj/item/aiModule/core/full/thermurderdynamic,
				/obj/item/aiModule/core/full/damaged
				)

/obj/effect/spawner/lootdrop/mre
	name = "random MRE"
	icon = 'icons/obj/storage.dmi'
	icon_state = "mre"

/obj/effect/spawner/lootdrop/mre/Initialize()
	for(var/A in subtypesof(/obj/item/storage/box/mre))
		var/obj/item/storage/box/mre/M = A
		var/our_chance = initial(M.spawner_chance)
		if(our_chance)
			LAZYSET(loot, M, our_chance)
	return ..()

// Tech storage circuit board spawners
// For these, make sure that lootcount equals the number of list items

/obj/effect/spawner/lootdrop/techstorage
	name = "generic circuit board spawner"
	lootdoubles = FALSE
	fan_out_items = TRUE

/obj/effect/spawner/lootdrop/techstorage/service
	name = "service circuit board spawner"
	lootcount = 10
	loot = list(
				/obj/item/circuitboard/computer/arcade/battle,
				/obj/item/circuitboard/computer/arcade/orion_trail,
				/obj/item/circuitboard/machine/autolathe,
				/obj/item/circuitboard/computer/mining,
				/obj/item/circuitboard/machine/ore_redemption,
				/obj/item/circuitboard/machine/mining_equipment_vendor,
				/obj/item/circuitboard/machine/microwave,
				/obj/item/circuitboard/machine/chem_dispenser/drinks,
				/obj/item/circuitboard/machine/chem_dispenser/drinks/beer,
				/obj/item/circuitboard/computer/slot_machine
				)

/obj/effect/spawner/lootdrop/techstorage/rnd
	name = "RnD circuit board spawner"
	lootcount = 8
	loot = list(
				/obj/item/circuitboard/computer/aifixer,
				/obj/item/circuitboard/machine/rdserver,
				/obj/item/circuitboard/computer/pandemic,
				/obj/item/circuitboard/machine/mechfab,
				/obj/item/circuitboard/machine/circuit_imprinter/department,
				/obj/item/circuitboard/computer/teleporter,
				/obj/item/circuitboard/machine/destructive_analyzer,
				/obj/item/circuitboard/computer/rdconsole
				)

/obj/effect/spawner/lootdrop/techstorage/security
	name = "security circuit board spawner"
	lootcount = 3
	loot = list(
				/obj/item/circuitboard/computer/secure_data,
				/obj/item/circuitboard/computer/security,
				/obj/item/circuitboard/computer/prisoner
				)

/obj/effect/spawner/lootdrop/techstorage/engineering
	name = "engineering circuit board spawner"
	lootcount = 3
	loot = list(
				/obj/item/circuitboard/computer/atmos_alert,
				/obj/item/circuitboard/computer/stationalert,
				/obj/item/circuitboard/computer/powermonitor
				)

/obj/effect/spawner/lootdrop/techstorage/tcomms
	name = "tcomms circuit board spawner"
	lootcount = 9
	loot = list(
				/obj/item/circuitboard/computer/message_monitor,
				/obj/item/circuitboard/machine/telecomms/broadcaster,
				/obj/item/circuitboard/machine/telecomms/bus,
				/obj/item/circuitboard/machine/telecomms/server,
				/obj/item/circuitboard/machine/telecomms/receiver,
				/obj/item/circuitboard/machine/telecomms/processor,
				/obj/item/circuitboard/machine/announcement_system,
				/obj/item/circuitboard/computer/comm_server,
				/obj/item/circuitboard/computer/comm_monitor
				)

/obj/effect/spawner/lootdrop/techstorage/medical
	name = "medical circuit board spawner"
	lootcount = 8
	loot = list(
				/obj/item/circuitboard/computer/cloning,
				/obj/item/circuitboard/machine/clonepod,
				/obj/item/circuitboard/machine/chem_dispenser,
				/obj/item/circuitboard/computer/scan_consolenew,
				/obj/item/circuitboard/computer/med_data,
				/obj/item/circuitboard/machine/smoke_machine,
				/obj/item/circuitboard/machine/chem_master,
				/obj/item/circuitboard/machine/clonescanner
				)

/obj/effect/spawner/lootdrop/techstorage/AI
	name = "secure AI circuit board spawner"
	lootcount = 3
	loot = list(
				/obj/item/circuitboard/computer/aiupload,
				/obj/item/circuitboard/computer/borgupload,
				/obj/item/circuitboard/aicore
				)

/obj/effect/spawner/lootdrop/techstorage/RnD_secure
	name = "secure RnD circuit board spawner"
	lootcount = 3
	loot = list(
				/obj/item/circuitboard/computer/mecha_control,
				/obj/item/circuitboard/computer/apc_control,
				/obj/item/circuitboard/computer/robotics
				)

/obj/effect/spawner/lootdrop/keg
	name = "random keg spawner"
	lootcount = 1
	loot = list(/obj/structure/reagent_dispensers/keg/mead = 5,
		/obj/structure/reagent_dispensers/keg/gargle = 1)

/obj/effect/spawner/lootdrop/coin
	lootcount = 1
	loot = list(
				/obj/item/coin/silver = 30,
				/obj/item/coin/iron = 30,
				/obj/item/coin/gold = 10,
				/obj/item/coin/diamond = 10,
				/obj/item/coin/plasma = 10,
				/obj/item/coin/uranium = 10,
				)

/obj/effect/spawner/lootdrop/cig_packs
	lootcount = 1
	loot = list(
				/obj/item/storage/fancy/cigarettes = 20,
				/obj/item/storage/fancy/cigarettes/dromedaryco = 10,
				/obj/item/storage/fancy/cigarettes/cigpack_robust = 5,
				/obj/item/storage/fancy/cigarettes/cigpack_robustgold = 5,
				/obj/item/storage/fancy/cigarettes/cigpack_carp = 15,
				/obj/item/storage/fancy/cigarettes/cigpack_syndicate = 2,
				/obj/item/storage/fancy/cigarettes/cigpack_midori = 10,
				/obj/item/storage/fancy/cigarettes/cigpack_shadyjims = 5,
				/obj/item/storage/fancy/cigarettes/cigpack_xeno = 3,
				/obj/item/storage/fancy/cigarettes/cigpack_cannabis = 10,
				/obj/item/storage/fancy/cigarettes/cigpack_mindbreaker = 10,
				/obj/item/storage/fancy/rollingpapers = 10
				)

/obj/effect/spawner/lootdrop/cigars_cases
	lootcount = 1
	loot = list(
				/obj/item/storage/fancy/cigarettes/cigars = 50,
				/obj/item/storage/fancy/cigarettes/cigars/cohiba = 25,
				/obj/item/storage/fancy/cigarettes/cigars/havana = 25,
				)

/obj/effect/spawner/lootdrop/lighter
	lootcount = 1
	loot = list(
				/obj/item/lighter/slime = 10,
				/obj/item/lighter/fusion = 10,
				/obj/item/lighter/royalgold = 5,
				/obj/item/lighter/iconic = 10,
				/obj/item/lighter/ian = 10,
				/obj/item/lighter/holy = 5,
				/obj/item/lighter/fox = 10,
				/obj/item/lighter/rainbow = 10,
				/obj/item/lighter/heart = 10,
				/obj/item/lighter/moff = 10,
				/obj/item/lighter/bullet = 10,
				)

/obj/effect/spawner/lootdrop/implants
	lootcount = 1
	loot = list(
				/obj/item/organ/eyes/robotic/shield = 20,
				/obj/item/organ/cyberimp/brain/anti_drop = 20,
				/obj/item/organ/cyberimp/brain/anti_stun = 10,
				/obj/item/organ/cyberimp/chest/nutriment/plus = 10,
				/obj/item/organ/cyberimp/chest/reviver = 10,
				/obj/item/organ/heart/cybernetic/upgraded = 5,
				/obj/item/organ/liver/cybernetic/upgraded = 10,
				/obj/item/organ/ears/cybernetic/upgraded =15,
				)

/obj/effect/spawner/lootdrop/space_cash
	lootcount = 1
	loot = list(
				/obj/item/stack/spacecash/c1    = 1,
				/obj/item/stack/spacecash/c10   = 9,
				/obj/item/stack/spacecash/c20   = 10,
				/obj/item/stack/spacecash/c50   = 15,
				/obj/item/stack/spacecash/c100  = 25,
				/obj/item/stack/spacecash/c200  = 20,
				/obj/item/stack/spacecash/c500  = 19,
				/obj/item/stack/spacecash/c1000 = 1,
				)

/obj/effect/spawner/lootdrop/druggie_pill
	lootcount = 1
	loot = list(
				/obj/item/reagent_containers/pill/stimulant    = 1,
				/obj/item/reagent_containers/pill/zoom   = 9,
				/obj/item/reagent_containers/pill/happy   = 10,
				/obj/item/reagent_containers/pill/lsd   = 15,
				/obj/item/reagent_containers/pill/aranesp  = 25,
				/obj/item/reagent_containers/pill/mannitol  = 19,
				/obj/item/reagent_containers/pill/happiness = 1,
				)

// ^^^ 				/obj/item/reagent_containers/pill/psicodine  = 20, was in this

/obj/effect/spawner/lootdrop/low_loot_toilet
	name = "random low toilet spawner"
	lootcount = 1
	spawn_on_turf = FALSE
//Note this is out of a 100 - Meaning the number you see is also the percent its going to pick that
//This is meant for "low" loot that anyone could find in a toilet, for better gear use high loot toilet
	loot = list("" = 30,
		/obj/item/lighter = 2,
		/obj/item/tape/random = 1,
		/obj/item/poster/random_contraband = 1,
		/obj/item/clothing/glasses/sunglasses/blindfold = 4,
		/obj/item/clothing/glasses/sunglasses = 1,
		/obj/effect/spawner/lootdrop/plush = 5,
		/obj/effect/spawner/lootdrop/gloves/no_turf = 5,
		/obj/effect/spawner/lootdrop/glowstick/no_turf = 5,
		/obj/effect/spawner/lootdrop/coin/no_turf = 3,
		/obj/effect/spawner/lootdrop/cig_packs/no_turf = 10,
		/obj/effect/spawner/lootdrop/cigars_cases/no_turf = 2,
		/obj/effect/spawner/lootdrop/space_cash/no_turf = 5,
		/obj/item/reagent_containers/food/snacks/grown/cannabis = 5,
		/obj/item/storage/box/dice = 5,
		/obj/item/toy/cards/deck = 5,
		/obj/effect/spawner/lootdrop/druggie_pill/no_turf = 5
		)

/obj/effect/spawner/lootdrop/prison_loot_toilet
	name = "random prison toilet spawner"
	lootcount = 1
	spawn_on_turf = FALSE
//Note this is out of a 100 - Meaning the number you see is also the percent its going to pick that
//This is meant for "prison" loot that is rather rare and meant for "prisoners if they get a crowbar to fine, or sec.
	loot = list("" = 10,
		/obj/item/lighter = 5,
		/obj/item/poster/random_contraband = 5,
		/obj/item/clothing/glasses/sunglasses = 5,
		/obj/effect/spawner/lootdrop/coin/no_turf = 5,
		/obj/effect/spawner/lootdrop/cig_packs/no_turf = 10,
		/obj/effect/spawner/lootdrop/cigars_cases/no_turf = 5,
		/obj/item/reagent_containers/food/snacks/grown/cannabis = 5,
		/obj/item/storage/box/dice = 5,
		/obj/item/toy/cards/deck = 5,
		/obj/effect/spawner/lootdrop/druggie_pill/no_turf = 5,
		/obj/item/kitchen/knife = 5,
		/obj/item/screwdriver = 5,
		/obj/item/crowbar/red = 1, //Dont you need a crowbar to open this?
		/obj/item/stack/medical/suture = 3,
		/obj/item/reagent_containers/food/drinks/bottle/vodka = 2,
		/obj/item/radio = 5,
		/obj/item/flashlight = 4,
		/obj/item/clothing/mask/breath = 2,
		/obj/item/tank/internals/emergency_oxygen = 3,
		/obj/item/storage/box/mre/menu4/safe = 3,
		/obj/item/grenade/smokebomb = 2
		)

/obj/effect/spawner/lootdrop/high_loot_toilet
	name = "random high toilet spawner"
	lootcount = 1
	spawn_on_turf = FALSE
//Note this is out of a 100 - Meaning the number you see is also the percent its going to pick that
//The items inside are always going to be something usefull, illegal and likely traitorous.
	loot = list(
		/obj/item/clothing/glasses/sunglasses = 5,
		/obj/effect/spawner/lootdrop/coin/no_turf = 5,
		/obj/effect/spawner/lootdrop/space_cash/no_turf = 5,
		/obj/effect/spawner/lootdrop/druggie_pill/no_turf = 5,
		/obj/item/storage/fancy/cigarettes/cigpack_syndicate = 5,
		/obj/item/toy/cards/deck/syndicate = 5,
		/obj/item/clothing/under/syndicate = 5,
		/obj/item/clothing/mask/gas/syndicate = 5,
		/obj/item/grenade/smokebomb = 10,
		/obj/item/gun/ballistic/automatic/toy/pistol = 5,
		/obj/item/firing_pin = 5,
		/obj/item/grenade/empgrenade = 15,
		/obj/item/clothing/gloves/tackler/combat/insulated = 10,
		/obj/item/clothing/shoes/sneakers/noslip = 10
		)

/obj/effect/spawner/lootdrop/low_tools
	name = "random basic tool(s) spawner"
	lootcount = 1
	loot = list(
		/obj/item/screwdriver = 1,
		/obj/item/wrench = 1,
		/obj/item/weldingtool/mini = 1,
		/obj/item/crowbar = 1,
		/obj/item/wirecutters = 1,
		/obj/item/analyzer = 1,
		/obj/item/t_scanner = 1
		)

/obj/effect/spawner/lootdrop/high_tools
	name = "random adv tool(s) spawner"
	lootcount = 1
	loot = list(
		/obj/item/screwdriver/power = 1,
		/obj/item/weldingtool/experimental = 1,
		/obj/item/crowbar/power = 1,
		/obj/item/analyzer = 1,
		/obj/item/multitool = 1
		)

/obj/effect/spawner/lootdrop/welder_tools
	name = "random safe welder tool(s) spawner"
	lootcount = 1
	loot = list(
		/obj/item/weldingtool = 1,
		/obj/item/weldingtool/mini = 1,
		/obj/item/weldingtool/hugetank = 1,
		/obj/item/weldingtool/largetank = 1
		)

/obj/effect/spawner/lootdrop/tool_box
	name = "random safe tool box(es) spawner"
	lootcount = 1
	loot = list(
		/obj/item/storage/toolbox/mechanical = 1,
		/obj/item/storage/toolbox/mechanical/old = 1,
		/obj/item/storage/toolbox/emergency = 1,
		/obj/item/storage/toolbox/emergency/old = 1,
		/obj/item/storage/toolbox/electrical = 1,
		/obj/item/storage/toolbox/artistic = 1,
		/obj/item/storage/toolbox/rubber = 1
		)

/obj/effect/spawner/lootdrop/healing_kits
	name = "random safe medical kit(s) spawner"
	lootcount = 1
	loot = list(
		/obj/item/storage/firstaid/regular = 1,
		/obj/item/storage/firstaid/ancient = 1,
		/obj/item/storage/firstaid/fire = 1,
		/obj/item/storage/firstaid/toxin = 1,
		/obj/item/storage/firstaid/radbgone = 1,
		/obj/item/storage/firstaid/o2 = 1,
		/obj/item/storage/firstaid/brute = 1
		)

/obj/effect/spawner/lootdrop/breathing_tanks
	name = "random internal tank(s) spawner"
	lootcount = 1
	loot = list(
		/obj/item/tank/internals/oxygen = 1,
		/obj/item/tank/internals/oxygen/yellow = 1,
		/obj/item/tank/internals/oxygen/red = 1,
		/obj/item/tank/internals/air = 1,
		/obj/item/tank/internals/plasmaman = 1,
		/obj/item/tank/internals/plasmaman/belt = 1,
		/obj/item/tank/internals/emergency_oxygen = 1,
		/obj/item/tank/internals/emergency_oxygen/engi = 1,
		/obj/item/tank/internals/emergency_oxygen/double = 1
		)

/obj/effect/spawner/lootdrop/breathing_masks
	name = "random internal mask(s) spawner"
	lootcount = 1
	loot = list(
		/obj/item/clothing/mask/gas = 2,
		/obj/item/clothing/mask/gas/glass = 4,
		/obj/item/clothing/mask/breath = 5,
		/obj/item/clothing/mask/breath/medical = 1
		)

/obj/effect/spawner/lootdrop/welder_tools/no_turf
	spawn_on_turf = FALSE

/obj/effect/spawner/lootdrop/low_tools/no_turf
	spawn_on_turf = FALSE

/obj/effect/spawner/lootdrop/breathing_tanks/no_turf
	spawn_on_turf = FALSE

/obj/effect/spawner/lootdrop/breathing_masks/no_turf
	spawn_on_turf = FALSE

/obj/effect/spawner/lootdrop/coin/no_turf
	spawn_on_turf = FALSE

/obj/effect/spawner/lootdrop/space_cash/no_turf
	spawn_on_turf = FALSE

/obj/effect/spawner/lootdrop/druggie_pill/no_turf
	spawn_on_turf = FALSE

/obj/effect/spawner/lootdrop/gloves/no_turf
	spawn_on_turf = FALSE

/obj/effect/spawner/lootdrop/cig_packs/no_turf
	spawn_on_turf = FALSE

/obj/effect/spawner/lootdrop/cigars_cases/no_turf
	spawn_on_turf = FALSE

/obj/effect/spawner/lootdrop/glowstick/no_turf
	spawn_on_turf = FALSE

// Random Parts

/obj/effect/spawner/lootdrop/stock_parts
	name = "random stock parts spawner"
	lootcount = 1
	loot = list(
				/obj/item/stock_parts/capacitor/simple,
				/obj/item/stock_parts/scanning_module/simple,
				/obj/item/stock_parts/manipulator/simple,
				/obj/item/stock_parts/micro_laser/simple,
				/obj/item/stock_parts/matter_bin/simple,
				/obj/item/stock_parts/cell
				)

// Random Weapon Parts

/obj/effect/spawner/lootdrop/weapon_parts
	name = "random weapon parts spawner 50%"
	lootcount = 1
	spawn_on_turf = FALSE
	loot = list("" = 50,
		/obj/item/weaponcrafting/improvised_parts/rifle_receiver = 13,
		/obj/item/weaponcrafting/improvised_parts/shotgun_receiver = 13,
		/obj/item/weaponcrafting/improvised_parts/trigger_assembly = 12,
		)

/obj/effect/spawner/lootdrop/weapon_parts
	name = "random weapon parts spawner 20%"
	lootcount = 1
	spawn_on_turf = FALSE
	loot = list("" = 80,
		/obj/item/weaponcrafting/improvised_parts/rifle_receiver = 5,
		/obj/item/weaponcrafting/improvised_parts/trigger_assembly = 5,
		)

/obj/effect/spawner/lootdrop/ammo
	name = "random ammo 75%"
	lootcount = 1
	spawn_on_turf = FALSE
	loot = list("" = 25,
		/obj/item/ammo_box/magazine/wt550m9 = 1,
		/obj/item/ammo_casing/shotgun/buckshot = 7,
		/obj/item/ammo_casing/shotgun/rubbershot = 7,
		/obj/item/ammo_casing/a308 = 15,
		/obj/item/ammo_box/a308 = 15,
		)

/obj/effect/spawner/lootdrop/ammo/fiftypercent
	name = "random ammo 50%"
	lootcount = 1
	spawn_on_turf = FALSE
	loot = list("" = 50,
		/obj/item/ammo_box/magazine/wt550m9 = 2,
		/obj/item/ammo_casing/shotgun/buckshot = 10,
		/obj/item/ammo_casing/shotgun/rubbershot = 10,
		/obj/item/ammo_casing/a308 = 7,
		/obj/item/ammo_box/a308 = 7,
		)

/obj/effect/spawner/lootdrop/ammo/shotgun
	name = "random ammo 50%"
	lootcount = 1
	spawn_on_turf = FALSE
	loot = list("" = 50,
		/obj/item/ammo_box/shotgun/loaded/buckshot = 5,
		/obj/item/ammo_box/shotgun/loaded/beanbag = 5,
		/obj/item/ammo_box/shotgun/loaded/incendiary = 5,
		/obj/item/ammo_casing/shotgun/buckshot = 8,
		/obj/item/ammo_casing/shotgun/rubbershot = 9,
		/obj/item/ammo_casing/shotgun = 8,
		/obj/item/ammo_casing/shotgun/incendiary = 10,
		)
