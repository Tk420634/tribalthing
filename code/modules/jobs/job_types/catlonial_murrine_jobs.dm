//////////////////////////////
/// sheriff
/// A sheriff, here to serve drinks and listen to people's problems
/datum/job/townfolk/f13sheriff
	title = "Squad Leader"
	flag = F13BARKEEP	
	total_positions = 1
	spawn_positions = 1
	description = "You are the Squad Leader. You lead the catlonial murrines into capturing catgirls for to be made into maids. Your work is essential to the survival of the town."
	supervisors = "the Adventurers Guild"
	outfit = /datum/outfit/job/cb/guild/deputy/sheriff
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	faction = "murrine"
//////////////////////////////
/// Deputy
/// A Deputy, here to serve drinks and listen to people's problems
/datum/job/townfolk/f13deputy
	title = "Trooper"
	flag = F13BARKEEP	
	description = "You are a Trooper. You are the backbone of the settlement, here to capture catgirls to be made into maids. Your work is essential to the survival of the town."
	supervisors = "The Squad Leaders"
	outfit = /datum/outfit/job/cb/guild/deputy
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	faction = "murrine"
//////////////////////////////
/// Deputy
/// A Deputy, here to serve drinks and listen to people's problems
/datum/job/townfolk/murrinegunner
	title = "Dartgunner"
	flag = F13BARKEEP	
	total_positions = 2
	spawn_positions = 2
	description = "You are a Murrine Gunner, armed with a dart machinegun capable of mobile supressing fire."
	supervisors = "The Squad Leaders"
	outfit = /datum/outfit/job/cb/guild/deputy/gunner
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	faction = "murrine"

/datum/job/townfolk/murrineengineer
	title = "Murrine Engineer"
	flag = F13BARKEEP
	total_positions = 2
	spawn_positions = 2
	description = "You are a Murrine Engineer, a master of mechanical turrets and area denial."
	supervisors = "The Squad Leaders"
	outfit = /datum/outfit/job/cb/guild/deputy/engineer
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	faction = "murrine"

/datum/job/townfolk/murrineranger
	title = "Murrine Ranger"
	flag = F13BARKEEP
	total_positions = 2
	spawn_positions = 2
	description = "You are a Murrine Ranger, master of speed and the best of the worst."
	supervisors = "The Squad Leaders"
	outfit = /datum/outfit/job/cb/guild/deputy/ranger
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	faction = "murrine"

/datum/job/townfolk/murrinebruiser
	title = "Murrine Bruiser"
	flag = F13BARKEEP
	total_positions = 2
	spawn_positions = 2
	description = "You are a Murrine Bruiser, the bulwark of the corp."
	supervisors = "The Squad Leaders"
	outfit = /datum/outfit/job/cb/guild/deputy/bruiser
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	faction = "murrine"


/datum/job/townfolk/murrinegrenadier
	title = "Murrine Grenadier"
	flag = F13BARKEEP
	total_positions = 2
	spawn_positions = 2
	description = "You are a Murrine Grenadier, a real tosser."
	supervisors = "The Squad Leaders"
	outfit = /datum/outfit/job/cb/guild/deputy/grenadier
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	faction = "murrine"
//////////////////////////////
/// Deputy
/// A Deputy, here to serve drinks and listen to people's problems
/datum/job/townfolk/f13deputy/capturedcatgirl
	title = "Captured Native"
	description = "You were captured by the invading Murrines, they dressed you in a maid outfit and have been trying to teach you to clean."
	supervisors = "None, sorta.  The marines if you want to be technical."
	enforces = "Not much in particular, but like.  If you wanna try to escape go ahead."
	forbids = "Not a whole lot of much. Live your life, crechor."
	outfit = /datum/outfit/job/cb/capturedcatgirl
	faction = list("murrine", "cat")


/datum/job/townfolk/f13deputy/teacher
	title = "Housekeeping Specialist"
	flag = F13BARKEEP
	total_positions = 2
	spawn_positions = 2
	description = "You are a Murrines specialist trained in teaching the Nyampire captives how to be proper maids."
	supervisors = "The Squad Leaders"
	outfit = /datum/outfit/job/cb/guild/deputy/housekeeping
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	faction = "murrine"



//////////////////////////////
/// Tribal Head Forager
/// The head forager of the tribe, who leads the hunters to find cute tribal furries
/datum/job/tribal/head_forager
	title = "Head Warrior"
	flag = F13HHUNTER
	total_positions = 2
	spawn_positions = 2
	supervisors = "The Nyan-Nyan Neko Gods and your instincts."
	enforces = "The will of the gods and the Nyampire."
	forbids = "Nothing in particular, victory must be found. Honor can be restored later."
	description = "The Gods have chosen you to be a Warleader for our warriors, only you can prove if you're fit for this position.  Capture the invaders and integrate them into the Nyampire."
	outfit = /datum/outfit/job/cb/catgirl/warrior/head
	paycheck = COINS_TO_CREDITS(100) // 100 copper per hour
	faction = "cat"

//////////////////////////////
/// Tribal Forager
/// A forager of the tribe, who helps the head forager find cute tribal furries
/datum/job/tribal/f13hunter
	title = "Warrior"
	flag = F13HUNTER
	total_positions = 999
	spawn_positions = 999
	supervisors = "The Nyan-Nyan Neko Gods, the Head Hunter and your instincts."
	enforces = "The ways of the Nyan-Nyan Neko Nyampire."
	forbids = "Nothing in particular, your victory is utmost over the foe."
	description = "You are a warrior of the Nyan-Nyan Neko Nyampire, one of the greatest warriors this planet has to offer.  Clad in bones of monsters these invaders would cower before and gifted with skills untold."
	outfit = /datum/outfit/job/cb/catgirl/warrior
	paycheck = COINS_TO_CREDITS(75) // 75 copper per hour
	faction = "cat"
//////////////////////////////
/// Tribal Forager
/// A forager of the tribe, who helps the head forager find cute tribal furries
/datum/job/tribal/snipergunter
	title = "Blowsniper"
	flag = F13HUNTER
	total_positions = 2
	spawn_positions = 2
	supervisors = "The Nyan-Nyan Neko Gods, the Head Hunter and your instincts."
	enforces = "The ways of the Nyan-Nyan Neko Nyampire."
	forbids = "Nothing in particular, your victory is utmost over the foe."
	description = "You are a sniper, trained with a blow dart gun and taught in the ways of being a bush."
	outfit = /datum/outfit/job/cb/catgirl/warrior/sniper
	paycheck = COINS_TO_CREDITS(75) // 75 copper per hour
	faction = "cat"

/datum/job/tribal/nyanfiltrator
	title = "Nyanfiltrator"
	flag = F13HUNTER
	total_positions = 2
	spawn_positions = 2
	supervisors = "The Nyan-Nyan Neko Gods, the Head Hunter and your instincts."
	enforces = "The ways of the Nyan-Nyan Neko Nyampire."
	forbids = "Nothing in particular, your victory is utmost over the foe."
	description = "A high class warrior, gifted with magical tech rendered from the ancients to hide yourself on the move and trained to use brass knyackles to down foes rapidly from behind."
	outfit = /datum/outfit/job/cb/catgirl/warrior/nyanfiltrator
	paycheck = COINS_TO_CREDITS(75) // 75 copper per hour
	faction = "cat"

/datum/job/tribal/jagnyarwarrior
	title = "Jagnyar Warrior"
	flag = F13HUNTER
	total_positions = 2
	spawn_positions = 2
	supervisors = "The Nyan-Nyan Neko Gods, the Head Hunter and your instincts."
	enforces = "The ways of the Nyan-Nyan Neko Nyampire."
	forbids = "Nothing in particular, your victory is utmost over the foe."
	description = "The Nyampires most decorated warriors, raised from birth to be the fastest and bestest, better than all the restest."
	outfit = /datum/outfit/job/cb/catgirl/jagnyarwarrior
	paycheck = COINS_TO_CREDITS(75) // 75 copper per hour
	faction = "cat"

/datum/job/tribal/stickspinner
	title = "Stick-Spinner"
	flag = F13HUNTER
	total_positions = 2
	spawn_positions = 2
	supervisors = "The Nyan-Nyan Neko Gods, the Head Hunter and your instincts."
	enforces = "The ways of the Nyan-Nyan Neko Nyampire."
	forbids = "Nothing in particular, your victory is utmost over the foe."
	description = "A warrior dedicated to the defense of the Nyampire, your skills with the Quartersnyaff are legendary."
	outfit = /datum/outfit/job/cb/catgirl/stickspinner
	paycheck = COINS_TO_CREDITS(75) // 75 copper per hour
	faction = "cat"

/datum/job/tribal/catnapper
	title = "Catnapper"
	flag = F13HUNTER
	total_positions = 2
	spawn_positions = 2
	supervisors = "The Nyan-Nyan Neko Gods, the Head Hunter and your instincts."
	enforces = "The ways of the Nyan-Nyan Neko Nyampire."
	forbids = "Nothing in particular, your victory is utmost over the foe."
	description = "Trained in the arts of the gripwire and its finer uses your purpose is area de-nyial."
	outfit = /datum/outfit/job/cb/catgirl/warrior/catnapper
	paycheck = COINS_TO_CREDITS(75) // 75 copper per hour
	faction = "cat"

/datum/job/tribal/influencer
	title = "Influencer"
	flag = F13HUNTER
	total_positions = 2
	spawn_positions = 2
	supervisors = "The Nyan-Nyan Neko Gods, the Head Hunter and your instincts."
	enforces = "Teaching the ways of the Nyan-Nyan Neko Nyampire to the captured Murrines."
	forbids = "Nothing in particular, your victory is utmost over the foe."
	description = "A priest, or some sort of well trained individual taught to indoctrinate Murrine captives to the Nyampires ways."
	outfit = /datum/outfit/job/cb/catgirl/warrior/influencer
	paycheck = COINS_TO_CREDITS(75) // 75 copper per hour
	faction = "cat"

/datum/job/tribal/head_forager/captured
	title = "Captured Murrine"
	total_positions = -1
	spawn_positions = -1
	supervisors = "Technically your supervisors are your captors, but that's kind of up to you."
	enforces = "Not much in particular."
	forbids = "Nothing in particular."
	description = "You've been captured by the enemy. You probably want to escape, but maybe you don't."
	outfit = /datum/outfit/job/cb/catgirl/warrior/captured
	faction = list("murrine", "cat")








/obj/item/gun/flintlock/musket/catgirl
	name = "catgirl tribal dart musket"
	desc = "An ancient but well kept Nyanpire black powder dartgun."
	icon = 'modular_coyote/icons/objects/ancient.dmi'
	icon_state = "musket1"
	inhand_icon_state = "308"
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY //need both hands to fire
	added_spread = 0
	damage_multiplier = 9 //nyan times
	dryfire_text = "*not loaded*"
	init_firemodes = list(
		/datum/firemode/semi_auto/slow //slow for the sake of macros, but not toooo slow
	)
	my_caliber = CALIBER_FOAM
	load_time = FLINTLOCK_PISTOL_RELOAD_TIME
	prefire_time = FLINTLOCK_PISTOL_PREFIRE_TIME
	prefire_randomness = FLINTLOCK_MUSKET_PREFIRE_STD
	baseload = /obj/item/ammo_casing/caseless/foam_dart/riot
	fire_sound = 'sound/items/syringeproj.ogg'
	zoom_factor = 2
	berryable = TRUE
	// ramp_up_max = 20 // 4x
	// ramp_up_start = 7 // tiles
	// ramp_up_end = 15 // also tiles


/obj/item/gun/ballistic/automatic/lewis/murr
	name = "Leeroy automatic dartling gun"
	desc = "A big heavy automatic dart shooter, designed for hosing down catgirls with hot foam."
	icon = 'icons/fallout/objects/guns/longguns.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/64x64_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/64x64_righthand.dmi'
	icon_state = "lewis"
	inhand_icon_state = "lewis"
	mag_type = /obj/item/ammo_box/magazine/lewis/foam
	init_mag_type = /obj/item/ammo_box/magazine/lewis/foam
	weapon_class = WEAPON_CLASS_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	init_recoil = LMG_RECOIL(1.2, 1.2)
	slowdown = GUN_SLOWDOWN_RIFLE_LMG * 1.5
	damage_multiplier = 0.8
	init_firemodes = list(
		/datum/firemode/automatic/rpm150
	)
	// ramp_up_max = 0.33 // damage multi
	// ramp_up_start = 15 // tiles
	// ramp_up_end = 15 // also tiles
	fire_sound = 'sound/items/syringeproj.ogg'

/obj/item/ammo_box/magazine/lewis/foam
	name = "huge foamdish"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "lanoe"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/riot
	caliber = list(CALIBER_FOAM)
	max_ammo = 97
	w_class = WEIGHT_CLASS_NORMAL // suffer
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_MEGA_CAN_MAGAZINE)

/obj/item/ammo_box/magazine/lewis/foam/empty
	start_empty = 1

/// A packed up turrent
/obj/item/turret_box/foam
	name = "packaged auto-dartling gun"
	desc = "A turret, packed up and ready to deploy. Ammo not included, unless repackaged."
	icon = 'icons/obj/objects.dmi'
	icon_state = "hivebot_fab_on"
	w_class = WEIGHT_CLASS_NORMAL
	turret_type = /obj/machinery/porta_turret/f13/nash/foam

/obj/item/ammo_box/magazine/internal/turret/foam
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/riot
	caliber = list(CALIBER_FOAM)

/// Nash's Friendliest Autogun
/// needs ammo~
/obj/machinery/porta_turret/f13/nash/foam
	name = "portable YiffSoft Point Defense Playset"
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	desc = "<i>Calling all Yiffers!</i> Are YOU tired of <i><u>girrrrls</u></i> breaking into YOUR BattleFort{tm}?? YiffSoft's \
		got your back, soldier! It can hold UP TO 300 YiffSoft TurboFoxy UltraDarts in its MEGA EXTENDED HOPPER, to unleash \
		HOT FOAM on ANYONE brave enough to stand within 11 meters of YOUR YiffSoft Point Defense Playset!! Made of \
		SPACE AGE YIFFER-TUFF plastic that can take a BEATING and be DEPLOYABLE again!! Ages 30 and up. \
		Keep out of reach of catgirls, it'll serve them if they deploy it!! \
		<br><br>\
		This turret comes pre-loaded with 50-100 <b>Foam Darts</b>, which will need to be manually reloaded into this thing \
		if you want it to keep shooting. \
		This is a 'portable' turret, in that it can be packaged back up into a handy carrying case if hit with a <b>multitool</b>.\
		It can be repaired by stuffing <b>Foam Darts<b> into it. Unload all the darts loaded inside by <b>alt-clicking</b> it.\
		Yes it accepts casing bags, just smack this with that to load whatever's in there."
	scan_range = 11
	turret_flags = TURRET_DEFAULT_TARGET_FLAGS | TURRET_DEFAULT_UTILITY
	stun_projectile = /obj/item/ammo_casing/caseless/foam_dart/riot
	lethal_projectile = /obj/item/ammo_casing/caseless/foam_dart/riot
	lethal_projectile_sound = 'sound/items/syringeproj.ogg'
	stun_projectile_sound = 'sound/items/syringeproj.ogg'
	faction = list("murrine")
	our_mag = /obj/item/ammo_box/magazine/internal/turret/foam
	integrity_failure = 0.01

/obj/machinery/porta_turret/f13/nash/foam/obj_break(damage_flag)
	if(!(flags_1 & NODECONSTRUCT_1))
		stat |= BROKEN
	playsound(get_turf(src), 'sound/machines/machinery_break_1.ogg', 80, 1, SOUND_DISTANCE(10), ignore_walls = TRUE)
	unload_all_ammo()
	var/obj/item/turret_box/foam/D = new(get_turf(src))
	D.noammo = TRUE
	qdel(src)

