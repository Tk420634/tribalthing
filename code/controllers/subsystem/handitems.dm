#define LICK_LOCATION "lick_location"
#define LICK_INTENT "lick_intent"
#define LICK_CANCEL "dont_lick"
/// Sounds and text for licking have this range
#define LICK_SOUND_TEXT_RANGE 2

GLOBAL_LIST_INIT(outdoor_tiles, list(
	/turf/open/indestructible/ground,
	/turf/open/floor/plating/f13/outside,
	/turf/open/lava,
	/turf/open/water,
))

/proc/is_outdoors(atom/A)
	var/turf/T = get_turf(A)
	if(!T)
		return FALSE
	var/area/areo = get_area(T)
	if(!areo)
		return FALSE
	if(areo.outdoors)
		return TRUE
	for(var/outdoor_path in GLOB.outdoor_tiles)
		var/turf/T_est = outdoor_path
		if(istype(T, T_est))
			return TRUE
	return FALSE

SUBSYSTEM_DEF(handitems)
	name = "HandItems"
	flags = SS_NO_FIRE

	/// our loaded hand items, keyed cutely
	/// list(/path/to/hand/item = /instantiated/hand/item)
	var/list/hand_items = list()
	var/list/gropekissers = list()
	var/allow_hud_buttons = TRUE

/datum/controller/subsystem/handitems/Initialize(start_timeofday)
	generate_hand_items()
	generate_grope_kissers()
	. = ..()
	to_chat(world, span_abductor("Initialized [LAZYLEN(hand_items)] hand items and [LAZYLEN(gropekissers)]-ish ways to fondle your friends!"))

/// Generate our hand items, and store them in our list for later use
/datum/controller/subsystem/handitems/proc/generate_hand_items()
	if(LAZYLEN(hand_items))
		QDEL_LIST_ASSOC_VAL(hand_items)
	for(var/gooby in typesof(/obj/item/hand_item))
		var/obj/item/hand_item/hi = new gooby(null, TRUE)
		hand_items[hi.type] = hi

/datum/controller/subsystem/handitems/proc/generate_grope_kissers()
	if(LAZYLEN(gropekissers))
		QDEL_LIST_ASSOC_VAL(gropekissers)
	for(var/booby in typesof(/datum/grope_kiss_MERP))
		var/datum/grope_kiss_MERP/gkm = new booby()
		gropekissers[gkm.type] = gkm

/datum/controller/subsystem/handitems/proc/grope_kiss(obj/item/hand_item/tactile/hitem, mob/living/user, mob/living/target)
	if(!istype(hitem))
		return FALSE
	if(!hitem.horny_mode)
		return FALSE
	if(!LAZYLEN(gropekissers))
		return FALSE
	var/datum/grope_kiss_MERP/grope = LAZYACCESS(gropekissers, hitem.grope)
	if(!grope)
		return FALSE
	var/list/used_grope = grope.make_visible_message(user, target, hitem.lastgrope)
	if(used_grope)
		hitem.lastgrope = used_grope
		return TRUE

/datum/controller/subsystem/handitems/proc/give_hand_item(mob/living/user, obj/item/hand_item/hitem)
	if(!user)
		return FALSE
	if(!isliving(user))
		to_chat(user, span_alert("You're a ghost (or something), shoo!"))
		return FALSE
	if(istype(hitem, /obj/item/hand_item))
		hitem = hitem.type
	if(!ispath(hitem))
		to_chat(user, span_phobia("[hitem] is not a valid path to a hand item! Call 1-800-IM-CODER and tell them error code BIG-STRONG-ALPHA-THRUMBO"))
		stack_trace("Invalid hand item path given to give_hand_item: [hitem]")
		return FALSE
	var/obj/item/hand_item/hi_temp = get_hand_item_template(hitem)
	if(!hi_temp)
		to_chat(user, span_phobia("No template found for [hitem]! Call 1-800-IM-CODER and tell them error code WILD-SLEEPY-BOOMRAT"))
		stack_trace("No template found for [hitem] in give_hand_item: [hitem]")
		return FALSE
	return hi_temp.give_to_user(user)

/datum/controller/subsystem/handitems/proc/get_hand_item_template(obj/item/hand_item/hi_path)
	if(istype(hi_path, /obj/item/hand_item))
		hi_path = hi_path.type
	if(!ispath(hi_path))
		to_chat(world, span_phobia("[hi_path] is not a valid path to a hand item! Call 1-800-IM-CODER and tell them error code BIG-STRONG-ALPHA-THRUMBO"))
		stack_trace("Invalid hand item path given to get_hand_item_template: [hi_path]")
		return null
	var/obj/item/hand_item/hi_temp = LAZYACCESS(hand_items, hi_path)
	if(!hi_temp)
		to_chat(world, span_phobia("No template found for [hi_path]! Call 1-800-IM-CODER and tell them error code WILD-SLEEPY-BOOMRAT"))
		stack_trace("No template found for [hi_path] in get_hand_item_template: [hi_path]")
		return null
	return hi_temp

/datum/controller/subsystem/handitems/proc/get_cooldown_time_left(mob/living/user, obj/item/hand_item/hi)
	if(!user || !hi)
		return 0
	if(!istype(hi))
		return 0
	var/datum/weakref/user_ref = WEAKREF(user)
	var/obj/item/hand_item/hi_temp = get_hand_item_template(hi.type)
	var/time_can_use_it = LAZYACCESS(hi_temp.cooldowns, user_ref)
	if(time_can_use_it > world.time)
		return time_can_use_it - world.time
	else
		return 0

/// generates the popup thingy for the hand items on the ui doodle
/datum/controller/subsystem/handitems/proc/get_hand_item_popup(mob/living/user, atom/origin)
	if(!user)
		return null
	var/list/hi_candidates = list()
	for(var/hi in hand_items)
		var/obj/item/hand_item/hi_temp = get_hand_item_template(hi)
		if(hi_temp.should_show_up_in_ui_menu(user))
			hi_candidates |= hi_temp
	if(!LAZYLEN(hi_candidates))
		return null
	// weed out any 'duplicates', such as multiple hand items in the same category, if applicable
	// format: list(/base/path = obj/item/hand_item)
	var/list/true_candidates = list()
	var/list/dupes = list()
	for(var/obj/item/hand_item/hi_cand in hi_candidates)
		if(!ispath(hi_cand.category_base_path))
			true_candidates |= hi_cand
			continue
		if(!dupes[hi_cand.category_base_path])
			dupes[hi_cand.category_base_path] = list()
		dupes[hi_cand.category_base_path] |= hi_cand
		if(LAZYLEN(dupes[hi_cand.category_base_path]) > 1)
			for(var/obj/item/hand_item/hi_dupe in dupes[hi_cand.category_base_path])
				if(hi_dupe.type == hi_dupe.category_base_path)
					dupes[hi_cand.category_base_path] -= hi_dupe // prioritize the special ones over the base ones
	for(var/hi_dupe_test in dupes)
		if(LAZYLEN(dupes[hi_dupe_test]) >= 1)
			true_candidates |= dupes[hi_dupe_test][1] // screw it, first one's the best
	// sort candidates by name, alphabetically
	hi_candidates = sort_list(true_candidates, /proc/cmp_name_asc)
	// got the stuff, now to make the popup
	var/list/popup_choices = list()
	var/list/popup_decoder = list()
	for(var/obj/item/hand_item/hi_cand in hi_candidates)
		var/icon/ico_use = hi_cand.hud_icon || hi_cand.icon
		var/ico_state_use = hi_cand.hud_icon_state || hi_cand.icon_state
		popup_choices["[hi_cand.name]"] = image(icon = ico_use, icon_state = ico_state_use)
		popup_decoder["[hi_cand.name]"] = hi_cand
	var/choice = show_radial_menu(user, origin, popup_choices, radius = 28, ultradense = TRUE, linedir = NORTH)
	if(!choice || !isliving(user))
		return
	var/obj/item/hand_item/true_hi_cand = popup_decoder[choice]
	return SShanditems.give_hand_item(user, true_hi_cand.type)



/// / / / / / / ///
/// HAND ITEMS! ///
/// For all of the items that are really just the user's hand used in different ways, mostly (all, really) from emotes
/obj/item/hand_item
	name = "your hand"
	desc = "Gimme five (or however many fingers you have, if you have any)!"
	force = 0
	throwforce = 0
	item_flags = DROPDEL | HAND_ITEM
	resistance_flags = FIRE_PROOF | ACID_PROOF
	rad_flags = RAD_NO_CONTAMINATE
	slot_flags = INV_SLOTBIT_DENYPOCKET
	block_parry_data = /datum/block_parry_data/bokken //release the butt parries
	/// UI stuff
	var/hud_icon // override this please
	var/hud_icon_state // this too
	var/hud_use = FALSE
	var/hud_desc = "Just a normal every day hand for doing handy things for handy people!"
	// i wish this game supported abstracts // dan only var, ask before messing with
	var/obj/item/hand_item/abstract = /obj/item/hand_item
	/// if set, if you have a certain trait, it'll search the child objects for that trait and spawn that
	var/user_trait_can_spawn_associated_item = FALSE
	var/associated_trait
	var/required_trait // if set, can only be given if the user has this trait
	var/inventoryable = FALSE
	var/just_one = FALSE // if you should only have one at a time, so you cant dual wield your own butt
	/// this sets a base path for a category of hand items, for various uses
	var/obj/item/hand_item/category_base_path
	var/del_on_fail = TRUE
	var/outside_only = FALSE // if TRUE, can only be gotten in an outside area
	// template only stuff
	var/template = FALSE
	/// format: list(/datum/weakref = time when you can use it again)
	var/list/cool_cooldowns = list() // for things that have cooldowns on their use
	var/cooldown_time = 0 // how long the cooldown is, in seconds. If 0, no cooldown will be applied
	var/cooldown_override_trait // if the user has this trait, cooldowns will not be applied to them
	/// seasonal stuff i guess
	var/list/required_months = list() // if set, only spawns in these months (1-12)
	/// more trait stuff

/obj/item/hand_item/Initialize(mapload, is_template, mob/handholder)
	if(is_template)
		item_flags = NONE
		resistance_flags |= INDESTRUCTIBLE
		template = TRUE
	. = ..()
	if(!inventoryable) // cant stuff your butt in your backpack... i guess?
		ADD_TRAIT(src, TRAIT_NO_STORAGE_INSERT, TRAIT_GENERIC)
	if(handholder)
		customize_to_user(handholder)

/// run by template
/obj/item/hand_item/proc/give_to_user(mob/living/user, just_checking = FALSE)
	if(!user)
		return FALSE
	var/obj/item/hand_item/instead = on_check_for_instead(user)
	if(instead)
		return instead.give_to_user(user)
	if(type == abstract)
		return FALSE
	if(!in_season(user, just_checking))
		return FALSE
	if(!outside_check(user, just_checking))
		return FALSE
	if(!has_required_trait(user, just_checking))
		return FALSE
	if(on_cooldown_check(user, just_checking))
		return FALSE
	if(on_hands_check(user, just_checking))
		return FALSE
	if(on_user_has_one_check(user, just_checking))
		return FALSE
	if(just_checking)
		return TRUE
	var/obj/item/hand_item/new_thing = new src.type(user, FALSE, user)
	if(new_thing.on_pre_spawn(user))
		return FALSE
	return new_thing.on_post_spawn(user)

/obj/item/hand_item/proc/should_show_up_in_ui_menu(mob/living/user)
	if(!user)
		return FALSE
	if(!hud_use)
		return FALSE
	if(type == abstract)
		return FALSE
	if(!has_required_trait(user, TRUE))
		return FALSE
	if(!in_season(user, TRUE))
		return FALSE
	if(!outside_check(user, TRUE))
		return FALSE
	return TRUE

/obj/item/hand_item/proc/outside_check(mob/living/user, just_checking = FALSE)
	if(!outside_only)
		return TRUE
	if(is_outdoors(user))
		return TRUE
	if(!just_checking)
		on_failed_give(user, HI_OUTSIDE_ONLY)
	return FALSE

/obj/item/hand_item/proc/in_season(mob/living/user, just_checking = FALSE)
	if(!LAZYLEN(required_months))
		return TRUE
	var/time = world.timeofday
	var/MM = text2num(time2text(time, "MM"))
	if(MM in required_months)
		return TRUE
	if(!just_checking)
		on_failed_give(user, HI_OUT_OF_SEASON)
	return FALSE

/obj/item/hand_item/proc/on_cooldown_check(mob/living/user, just_checking = FALSE)
	if(!cooldown_time)
		return FALSE
	if(cooldown_override_trait && HAS_TRAIT(user, cooldown_override_trait))
		return FALSE
	var/datum/weakref/user_ref = WEAKREF(user)
	var/time_can_use_it = LAZYACCESS(cool_cooldowns, user_ref)
	if(time_can_use_it > world.time)
		if(!just_checking)
			on_failed_give(user, HI_ON_COOLDOWN)
		return TRUE
	return FALSE

/obj/item/hand_item/proc/on_check_for_instead(mob/living/user, ui_checking)
	if(!user_trait_can_spawn_associated_item)
		return null
	if(!associated_trait)
		to_chat(world, span_phobia("Hand item [src] is set to spawn an associated item based on a user trait, but has no associated trait set! Call 1-800-IM-CODER and tell them error code MOOSHY-BINGUS-SUPREME"))
		stack_trace("Hand item [src] is set to spawn an associated item based on a user trait, but has no associated trait set! Check the hand item definition for [src]")
		return null
	if(HAS_TRAIT(user, associated_trait))
		return null // means just to use this
	else if(ui_checking)
		return TRUE // yes means no
	return get_associated_item_for_user_trait(user, src)

/obj/item/hand_item/proc/get_associated_item_for_user_trait(mob/living/user)
	if(!istype(user))
		stack_trace("Invalid arguments given to get_associated_item_for_user_trait: [user], [src]")
		return
	if(!ispath(category_base_path))
		to_chat(world, span_phobia("Hand item [src] is set to spawn an associated item based on a user trait, but has an invalid base path! Call 1-800-IM-CODER and tell them error code SQUISHY-CHERRIES"))
		stack_trace("Invalid hand item template given to get_associated_item_for_user_trait: [src]. Base path must be set and be a valid path! Check the hand item definition for [src]")
		return
	if(!associated_trait)
		to_chat(world, span_phobia("Hand item [src] is set to spawn an associated item based on a user trait, but has no associated trait set! Call 1-800-IM-CODER and tell them error code SQUASHY-GRAPES"))
		stack_trace("Hand item [src] is set to spawn an associated item based on a user trait, but has no associated trait set! Check the hand item definition for [src]")
		return
	/// list of items to check through
	var/list/candidates = list()
	for(var/hi_pat in typesof(category_base_path))
		candidates |= SShanditems.get_hand_item_template(hi_pat)
	if(!LAZYLEN(candidates))
		stack_trace("Hand item [src] is set to spawn an associated item based on a user trait, but no candidates were found! Check that there are hand items with a base path of [category_base_path] in the hand item definitions.")
		return
	for(var/obj/item/hand_item/hi_cand in candidates)
		if(HAS_TRAIT(user, hi_cand.associated_trait))
			return hi_cand

/obj/item/hand_item/proc/has_required_trait(mob/living/user, just_checking = FALSE)
	if(!required_trait)
		return TRUE
	if(HAS_TRAIT(user, required_trait))
		return TRUE
	if(!just_checking)
		on_failed_give(user, HI_MISSING_REQUIRED_TRAIT)
	return FALSE

// does something if we already have one of these, returns FALSE to proceed with normal giving, TRUE to stop it
/obj/item/hand_item/proc/on_already_has_one(mob/living/user, obj/item/hand_item/existing, just_checking = FALSE)
	if(!just_one)
		return FALSE
	if(!just_checking)
		on_failed_give(user, HI_ALREADY_HAVE_ONE)
	return TRUE

// checks if either hand is empty, returns FALSE to proceed with giving, TRUE to stop it
/obj/item/hand_item/proc/on_hands_check(mob/living/user, just_checking = FALSE)
	if(user.get_active_held_item() && user.get_inactive_held_item())
		if(!just_checking)
			on_failed_give(user, HI_HANDS_FULL)
		return TRUE
	return FALSE

// happens after the item is created, but before it is given to user
// returns TRUE to stop the give, FALSE to continue with normal giving
// can be used to spawn something else instead, or to cancel giving entirely
/obj/item/hand_item/proc/on_pre_spawn(mob/living/user)
	return FALSE

// happens after the item is done spawning and is, ideally, in the players hands
// returns TRUE if the thing was given, FALSE if it wasnt
/obj/item/hand_item/proc/on_post_spawn(mob/living/user)
	if(user.put_in_hands(src))
		return on_successful_give(user, HI_GAVE)
	else
		return on_failed_give(user, HI_HANDS_FULL)

// false lets the subsystem proceed with normal spawnage
/obj/item/hand_item/proc/on_user_has_one_check(mob/living/user, just_checking = FALSE)
	if(!just_one)
		return FALSE
	var/loose_pathing = get_path_looseness(user)
	var/obj/item/path_to_check = get_path_to_check(user)
	var/obj/item/existing
	for(var/obj/item/AM as anything in (get_nested_locs(user) + user))
		if(loose_pathing)
			if(ispath(AM.type, path_to_check))
				existing = AM
				break
		else
			if(AM.type == path_to_check)
				existing = AM
				break
	if(existing)
		return on_already_has_one(user, existing, just_checking)
	else
		return FALSE


/obj/item/hand_item/proc/get_path_to_check(mob/living/user)
	return type

/obj/item/hand_item/proc/get_path_looseness(mob/living/user)
	return TRUE

/obj/item/hand_item/proc/customize_to_user(mob/user)

/obj/item/hand_item/proc/on_successful_give(mob/user, reason)
	on_successful_give_message(user, reason)
	return TRUE

/obj/item/hand_item/proc/on_successful_give_message(mob/user, reason)
	switch(reason)
		if(HI_GAVE)
			to_chat(user, span_notice("You ready your [src]!"))
		else
			to_chat(user, span_notice("You got ye [src]!"))

/obj/item/hand_item/proc/on_failed_give(mob/user, reason)
	on_failed_give_message(user, reason)
	if(del_on_fail)
		qdel(src)
	return TRUE

/obj/item/hand_item/proc/on_failed_give_message(mob/user, reason)
	switch(reason)
		if(HI_OUTSIDE_ONLY)
			to_chat(user, span_alert("You can't get ye [src] here! Try going outside?"))
		if(HI_OUT_OF_SEASON)
			to_chat(user, span_alert("You can't get ye [src] right now! Maybe try again in a different season?"))
		if(HI_ON_COOLDOWN)
			var/time_left = SShanditems.get_cooldown_time_left(user, src)
			to_chat(user, span_alert("You can't get ye [src] right now! Try again in [DisplayTimeText(time_left)]?"))
		if(HI_MISSING_REQUIRED_TRAIT)
			to_chat(user, span_alert("You can't get ye [src]! You lack the necessary trait to use it!"))
		if(HI_ALREADY_HAVE_ONE)
			to_chat(user, span_alert("You can't get ye [src]! You already have one!"))
		if(HI_HANDS_FULL)
			to_chat(user, span_alert("You can't get ye [src]! Your hands are full! Try emptying one of them?"))
		else
			to_chat(user, span_alert("You can't get ye [src]!"))

/// Tactile hand item, for all your tactile needs
/// It can be used for things like licking, groping, kissing, and... healing!
/// middleclick to make it horny
/obj/item/hand_item/tactile
	var/obj/item/stack/medical/healthing
	var/required_organ_slot
	/// are we licking something?
	var/needed_trait_to_heal
	var/tend_word = "licking"
	var/action_verb = "lick"
	var/action_verb_s = "licks"
	var/action_verb_ing = "licking"
	var/datum/grope_kiss_MERP/grope
	var/list/lastgrope
	var/horny_mode = FALSE
	var/medical_mode = FALSE
	var/working = FALSE
	var/text_range = 3
	var/can_taste = FALSE
	abstract = /obj/item/hand_item/tactile

/obj/item/hand_item/tactile/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_LICK_RETURN,PROC_REF(perform_tactile_action))

/obj/item/hand_item/tactile/examine(mob/user)
	. = ..()
	if(grope)
		. += "Ctrl-Shift-click to toggle horny mode for this item! It is currently [horny_mode?"on":"off"]."
	if(healthing)
		. += "Alt-click to toggle medical mode for this item! It is currently [medical_mode?"on":"off"]."
		if(needed_trait_to_heal)
			if(!HAS_TRAIT(user, needed_trait_to_heal))
				. += "However, you lack the necessary trait to use this item for healing."

/obj/item/hand_item/tactile/on_pre_spawn()
	if(ispath(healthing))
		healthing = new(src)

/obj/item/hand_item/tactile/update_icon()
	if(horny_mode)
		color = "#FF69B4"
	else
		color = initial(color)
	var/matrix/tf = initial(transform)
	if(medical_mode)
		transform = tf.Turn(90)
	else
		transform = tf

/obj/item/hand_item/tactile/CtrlShiftClick(mob/user)
	if(!grope)
		to_chat(user, span_alert("Your [src] can't exactly be used for horny purposes! (at least not *this* way!)"))
		horny_mode = FALSE
		update_icon()
		return COMSIG_MOB_CANCEL_CLICKON
	if(horny_mode)
		horny_mode = FALSE
		to_chat(user, span_love("Your [src]'s horny mode deactivated."))
	else
		horny_mode = TRUE
		to_chat(user, span_love("Your [src]'s horny mode activated!"))
		to_chat(user, span_love("Be sure to consider their preferences and consent!"))
	update_icon()
	return COMSIG_MOB_CANCEL_CLICKON

/obj/item/hand_item/tactile/AltClick(mob/user)
	. = ..()
	if(!healthing)
		to_chat(user, span_alert("Your [src] can't exactly be used to heal anything! (At least not medically!)"))
		medical_mode = FALSE
		update_icon()
		return COMSIG_MOB_CANCEL_CLICKON
	if(!HAS_TRAIT(user, needed_trait_to_heal))
		to_chat(user, span_alert("You lack the ability to heal anything with your [src]!"))
		medical_mode = FALSE
		update_icon()
		return FALSE
	if(medical_mode)
		medical_mode = FALSE
		to_chat(user, span_notice("Your [src]'s medical mode deactivated."))
	else
		medical_mode = TRUE
		to_chat(user, span_notice("Your [src]'s medical mode activated!"))
	update_icon()
	return COMSIG_MOB_CANCEL_CLICKON

/// / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / ///
/// Forces this thing to do its tactile action instead of bapping ///
/obj/item/hand_item/tactile/attack(mob/living/L, mob/living/carbon/user)
	INVOKE_ASYNC(src, PROC_REF(handle_hand_item_use), src, user, L)

/obj/item/hand_item/tactile/attack_obj(obj/O, mob/living/user)
	INVOKE_ASYNC(src, PROC_REF(handle_hand_item_use), src, user, O)

/obj/item/hand_item/tactile/attack_obj_nohit(obj/O, mob/living/user)
	INVOKE_ASYNC(src, PROC_REF(handle_hand_item_use), src, user, O)

/// / / / / / / / / / / / / / / / / / / / / / / / / / / / / ///
/// Common hand item use handler for tactile touchy things  ///
/obj/item/hand_item/tactile/proc/handle_hand_item_use(atom/source, mob/living/user, atom/licked)
	if(!isliving(user))
		return FALSE
	if(required_organ_slot && iscarbon(user))
		var/mob/living/carbon/C = user
		if(!C.getorganslot(required_organ_slot))
			to_chat(user, span_alert("WHOA, you dont have the right body part to use this! How did you even get this??"))
			qdel(src)
			return FALSE
	if(working)
		to_chat(user, span_alert("You're already [action_verb_ing] something!"))
		return FALSE
	if(!licked)
		return FALSE
	if(horny_mode)
		if(perform_horny_action(user, licked))
			if(!medical_mode)
				return TRUE
	if(medical_mode)
		if(perform_medical_action(user, licked))
			return TRUE
	return perform_tactile_action(user, licked)

/obj/item/hand_item/tactile/proc/perform_medical_action(mob/living/user, mob/living/target)
	if(!healthing)
		medical_mode = FALSE
		return FALSE
	if(!isliving(user) || !isliving(target))
		return
	var/mob/living/mlemmed = target
	if(iscarbon(mlemmed) && !mlemmed.get_bodypart(user.zone_selected))
		return FALSE
	if(!istype(healthing))
		healthing = new healthing(src)
		if(!istype(healthing))
			return FALSE
	if(!healthing.try_heal(mlemmed, user))
		return FALSE
	return TRUE

/obj/item/hand_item/tactile/proc/perform_horny_action(mob/living/user, mob/living/target)
	return SShanditems.grope_kiss(src, user, target)

/obj/item/hand_item/tactile/proc/perform_tactile_action(mob/living/user, atom/target)
	do_message(user, target)
	do_sounds(user, target)
	if(can_taste)
		taste_if_possible(user, target)
	return TRUE

// non-horny, non-medical tactile action message 
/obj/item/hand_item/tactile/proc/do_message(mob/living/user, atom/target)
	user.visible_message(
		"[user] [action_verb_s] [target].",
		"You [action_verb] [target].",
		"You hear [action_verb_ing].",
		text_range
	)

/obj/item/hand_item/tactile/proc/do_sounds(mob/living/user, atom/target)
	var/list/sounds2play = list()
	// sounds2play += hitsound
	sounds2play += pokesound
	playsound(target, safepick(sounds2play), 85, TRUE)


/obj/item/hand_item/tactile/licker/perform_tactile_action(mob/living/user, atom/target)
	/// give other things a chance to handle being licked, and if they did, stop here cus they do it
	var/lick_ret = SEND_SIGNAL(target, COMSIG_LICK_RETURN, user, target)
	if(lick_ret)
		return lick_ret
	. = ..()

/obj/item/hand_item/tactile/licker/do_message(mob/living/user, atom/licked)
	var/list/lick_words = get_lick_words(user)
	var/line_others
	var/line_self
	var/line_heard
	var/subj_third
	var/subj_second
	if(user == licked)
		subj_third = "[user.p_their()]"
		subj_second = "your"
	else
		subj_third = "[licked.p_their()]"
		subj_second = "[licked.p_their()]"
	line_others = "[user] [lick_words[LICK_INTENT]] [action_verb_s] [subj_third] [lick_words[LICK_LOCATION]]."
	line_self = "You [lick_words[LICK_INTENT]] [action_verb] [subj_second] [lick_words[LICK_LOCATION]]."
	line_heard = "You hear [action_verb_ing]."
	user.visible_message(
		line_others,
		line_self,
		line_heard,
		LICK_SOUND_TEXT_RANGE
	)

/obj/item/hand_item/tactile/proc/get_lick_words(mob/living/user)
	if(!user)
		return
	. = list(LICK_LOCATION = "spot", LICK_INTENT = "like a dork") //👀 Dan I swear to god.
	switch(user.zone_selected)
		if(BODY_ZONE_CHEST)
			.[LICK_LOCATION] = "chest"
		if(BODY_ZONE_HEAD)
			.[LICK_LOCATION] = "face"
		if(BODY_ZONE_L_ARM)
			.[LICK_LOCATION] = "left arm"
		if(BODY_ZONE_R_ARM)
			.[LICK_LOCATION] = "right arm"
		if(BODY_ZONE_L_LEG)
			.[LICK_LOCATION] = "left leg"
		if(BODY_ZONE_R_LEG)
			.[LICK_LOCATION] = "right leg"
		if(BODY_ZONE_PRECISE_EYES)
			.[LICK_LOCATION] = "eyes"
		if(BODY_ZONE_PRECISE_MOUTH)
			.[LICK_LOCATION] = "lips"
		if(BODY_ZONE_PRECISE_GROIN)
			.[LICK_LOCATION] = "butt"
		if(BODY_ZONE_PRECISE_L_HAND)
			.[LICK_LOCATION] = "left hand"
		if(BODY_ZONE_PRECISE_R_HAND)
			.[LICK_LOCATION] = "right hand"
		if(BODY_ZONE_PRECISE_L_FOOT)
			.[LICK_LOCATION] = "left foot"
		if(BODY_ZONE_PRECISE_R_FOOT)
			.[LICK_LOCATION] = "right foot"
	switch(user.a_intent)
		if(INTENT_HELP)
			.[LICK_INTENT] = "gently"
		if(INTENT_DISARM)
			.[LICK_INTENT] = "briskly"
		if(INTENT_GRAB)
			.[LICK_INTENT] = "aggressively"
		if(INTENT_HARM)
			.[LICK_INTENT] = "very aggressively"

/obj/item/hand_item/tactile/proc/taste_if_possible(mob/living/user, atom/target)
	if(!can_taste)
		return
	if(!iscarbon(user))
		return
	var/mob/living/carbon/C = user
	C.taste(null, target)

/// / / / / ///
/// LICKER  ///
/// Course our first hand item would be a tongue
/obj/item/hand_item/tactile/licker
	name = "tongue"
	desc = "Mlem."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "tonguenormal"
	attack_verb = list("licked", "lapped", "mlemmed")
	pokesound = 'sound/effects/lick.ogg'
	siemens_coefficient = 5 // hewwo mistow ewectwic fence mlem mlem
	hud_icon = 'icons/mob/screen_gen.dmi'
	hud_icon_state = "lick"
	healthing = /obj/item/stack/medical/bruise_pack/lick
	needed_trait_to_heal = TRAIT_HEAL_TONGUE
	tend_word = "licking"
	action_verb = "lick"
	action_verb_s = "licks"
	action_verb_ing = "licking"
	can_taste = FALSE
	grope = /datum/grope_kiss_MERP/lick
	hud_use = TRUE

/obj/item/hand_item/tactile/licker/on_failed_give_message(mob/user, reason)
	if(reason == HI_HANDS_FULL)
		to_chat(user, span_alert("Your hands are too full to lick anything!"))
		return TRUE
	. = ..()

////////////////////////
/obj/item/hand_item/tactile/triage //chimken
	name = "triage kit"
	desc = "A small collection of vital medical supplies."
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "traumapack"
	attack_verb = list("tended", "treated", "healed")
	pokesound = 'sound/items/tendingwounds.ogg'
	hud_icon = 'icons/mob/screen_gen.dmi'
	hud_icon_state = "tend"
	healthing = /obj/item/stack/medical/bruise_pack/lick/tend
	needed_trait_to_heal = TRAIT_HEAL_TEND
	required_trait = TRAIT_HEAL_TEND
	tend_word = "tending"
	action_verb = "tend"
	action_verb_s = "tends"
	action_verb_ing = "tending"
	can_taste = FALSE
	hud_use = TRUE

/obj/item/hand_item/tactile/triage/on_failed_give_message(mob/user, reason)
	if(reason == HI_HANDS_FULL)
		to_chat(user, span_alert("Your hands are too full to tend anything!"))
		return TRUE
	. = ..()

////////////////////////
/obj/item/hand_item/tactile/toucher //being repurposed as a way to 'feel' the world around the player.  Specifically other players though, lets be real.
	name = "touch"
	desc = "A finger, for touching things."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "feeder"
	attack_verb = list("touched", "poked", "prodded")
	pokesound = 'sound/items/tendingwounds.ogg'
	hud_icon = 'icons/mob/screen_gen.dmi'
	hud_icon_state = "touch"
	healthing = /obj/item/stack/medical/bruise_pack/lick/touch
	needed_trait_to_heal = TRAIT_HEAL_TOUCH
	tend_word = "touching"
	action_verb = "touch"
	action_verb_s = "touches"
	action_verb_ing = "touching"
	grope = /datum/grope_kiss_MERP
	can_taste = FALSE
	hud_use = TRUE

/obj/item/hand_item/tactile/toucher/on_failed_give_message(mob/user, reason)
	if(reason == HI_HANDS_FULL)
		to_chat(user, span_alert("Your hands are too full to touch anything!"))
		return TRUE
	. = ..()

////////////////////////
/obj/item/hand_item/tactile/kisser
	name = "kisser"
	desc = "A kisser, for smooching things."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "kisser"
	attack_verb = list("kissed", "smooched", "snogged")
	pokesound = list(
		'sound/effects/kiss.ogg',
		'modular_splurt/sound/interactions/kiss/kiss1.ogg',
		'modular_splurt/sound/interactions/kiss/kiss2.ogg',
		'modular_splurt/sound/interactions/kiss/kiss3.ogg',
		'modular_splurt/sound/interactions/kiss/kiss4.ogg',
	)
	healthing = /obj/item/stack/medical/bruise_pack/lick/touch
	hud_icon = 'icons/mob/screen_gen.dmi'
	hud_icon_state = "kiss"
	needed_trait_to_heal = TRAIT_HEAL_TOUCH
	tend_word = "smooching"
	action_verb = "kiss"
	action_verb_s = "kisses"
	action_verb_ing = "kissing"
	can_taste = FALSE
	grope = /datum/grope_kiss_MERP/kiss
	hud_use = TRUE
	can_taste = TRUE // a good kiss is one you can *taste*

/obj/item/hand_item/tactile/kisser/on_failed_give_message(mob/user, reason)
	if(reason == HI_HANDS_FULL)
		to_chat(user, span_alert("Your hands are too full to kiss anything!"))
		return TRUE
	. = ..()

/// / / / / / / / / / / / / / / / / / / / / / / / / / / ///
/// hand items used primarily as a way to attack things ///
/// generally for things you whack other things with    ///
/obj/item/hand_item/weapon
	name = "attack thing"
	desc = "Use it to attack things, probably. May or may not be part of your body."
	force = 15
	w_class = WEIGHT_CLASS_TINY
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_GLOVES
	backstab_multiplier = 1.8
	throwforce = 0
	sharpness = SHARP_POINTY
	attack_speed = CLICK_CD_MELEE
	item_flags = PERSONAL_ITEM | ABSTRACT | HAND_ITEM
	weapon_special_component = /datum/component/weapon_special/single_turf
	block_parry_data = /datum/block_parry_data/bokken
	hud_use = TRUE
	var/obj/item/hand_item/weapon/for_creatures
	var/extra_force_as_glove = 0
	var/extra_damage = 0
	var/extra_damage_type = STAMINA
	var/can_knockback = FALSE
	var/spin_attack = FALSE
	var/use_bodypart_image_slot
	var/list/bodypart_images = list()
	abstract = /obj/item/hand_item/weapon

/obj/item/hand_item/weapon/ComponentInitialize()
	. = ..()
	if(can_knockback)
		AddComponent(/datum/component/knockback, 1, FALSE, TRUE)

/obj/item/hand_item/weapon/afterattack(mob/living/M, mob/living/user)
	. = ..()
	if(spin_attack)
		user.spin(4, 1) // SPEEN

/obj/item/hand_item/weapon/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/H = user
	if(ishuman(user) && slot == SLOT_GLOVES)
		ADD_TRAIT(user, TRAIT_UNARMED_WEAPON, "glove")
		if(HAS_TRAIT(user, TRAIT_UNARMED_WEAPON))
			H.dna.species.punchdamagehigh += force + extra_force_as_glove //Work around for turbo bad code here. Makes this correctly stack with your base damage. No longer makes ghouls the kings of melee.
			H.dna.species.punchdamagelow += force + extra_force_as_glove
			H.dna.species.attack_sound = hitsound
			if(sharpness == SHARP_POINTY || sharpness ==  SHARP_EDGED)
				H.dna.species.attack_verb = safepick(attack_verb) || "blapped"
	if(ishuman(user) && slot != SLOT_GLOVES && !H.gloves)
		REMOVE_TRAIT(user, TRAIT_UNARMED_WEAPON, "glove")
		if(!HAS_TRAIT(user, TRAIT_UNARMED_WEAPON)) //removing your funny trait shouldn't make your fists infinitely stack damage.
			H.dna.species.punchdamagehigh = 10
			H.dna.species.punchdamagelow = 1
		if(HAS_TRAIT(user, TRAIT_IRONFIST))
			H.dna.species.punchdamagehigh = 12
			H.dna.species.punchdamagelow = 6
		if(HAS_TRAIT(user, TRAIT_STEELFIST))
			H.dna.species.punchdamagehigh = 16
			H.dna.species.punchdamagelow = 10
		H.dna.species.attack_sound = initial(H.dna.species.attack_sound)
		H.dna.species.attack_verb = initial(H.dna.species.attack_verb)
	transmute_into_bodypart(user)

/obj/item/hand_item/weapon/pickup(mob/living/user)
	. = ..()
	transmute_into_bodypart(user)

/obj/item/hand_item/weapon/get_associated_item_for_user_trait(mob/living/user)
	if(ispath(for_creatures) && isanimal(user) && !isadvancedmob(user))
		return SShanditems.get_hand_item_template(for_creatures)
	. = ..()

/obj/item/hand_item/weapon/proc/transmute_into_bodypart(mob/user)
	if(!use_bodypart_image_slot)
		return
	if(!iscarbon(user))
		return
	var/datum/genital_images/mynt = SSpornhud.get_genital_datum(user)
	bodypart_images.Cut()
	if(mynt)
		switch(use_bodypart_image_slot)
			if(PHUD_TAIL)
				bodypart_images = mynt.tail.Copy()
			if(PHUD_BUTT)
				bodypart_images = mynt.butt.Copy()
	if(!LAZYLEN(bodypart_images))
		return // use default icon
	icon = "icons/effects/effects.dmi"
	icon = "nothing"
	overlays.Cut()
	for(var/whatever in bodypart_images)
		var/image/I = whatever
		I.dir = NORTH
		overlays += I

/obj/item/hand_item/weapon/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!.)
		return
	if(!istype(M))
		return
	if(!extra_damage)
		return
	M.apply_damage(extra_damage, extra_damage_type, "chest", M.run_armor_check("chest", "melee"))

/// / / / / ///
/// BITERS  ///
// todo: make biting metal things hurt a lot
/obj/item/hand_item/weapon/biter
	name = "Biter"
	desc = "Talk shit, get bit."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "biter"
	attack_verb = list("chomped", "gnawed", "bit", "crunched", "nommed")
	hitsound = "sound/weapons/bite.ogg"
	hud_icon = 'icons/mob/screen_gen.dmi'
	hud_icon_state = "bite"
	just_one = TRUE
	user_trait_can_spawn_associated_item = TRUE
	associated_trait = TRAIT_BITE
	required_trait = TRAIT_BITE
	category_base_path = /obj/item/hand_item/weapon/biter
	// for_creatures = /obj/item/hand_item/weapon/biter/creature

/obj/item/hand_item/weapon/biter/on_successful_give(mob/living/user, reason)
	to_chat(user, span_notice("You bare your fangs, ready to chomp through anything in your path!"))

// /obj/item/hand_item/weapon/biter/creature
// 	force = 35
// 	force_wielded = 45
// 	force_unwielded = 35
// 	associated_trait = "trait_creature_bite"

/obj/item/hand_item/weapon/biter/big
	name = "Big Biter"
	desc = "Talk shit, get BIG bit."
	color = "#884444"
	force = 40
	force_wielded = 50
	force_unwielded = 40
	attack_speed = CLICK_CD_MELEE
	associated_trait = TRAIT_BIGBITE
	required_trait = TRAIT_BIGBITE

/obj/item/hand_item/weapon/biter/big/on_successful_give(mob/living/user, reason)
	to_chat(user, span_notice("Your lips part, revealing a set of massive, razor-sharp fangs!"))

/obj/item/hand_item/weapon/biter/sabre
	name = "Sabre Toothed Biter"
	desc = "Damn bitch, you eat with them teeth?"
	color = "#FF4444"
	force = 45
	force_wielded = 55
	force_unwielded = 45
	attack_speed = CLICK_CD_MELEE * 1.2
	associated_trait = TRAIT_SABREBITE
	required_trait = TRAIT_SABREBITE

/obj/item/hand_item/weapon/biter/sabre/on_successful_give(mob/living/user, reason)
	to_chat(user, span_notice("You slide your long sabreteeth against your lower lip, ready to impale whatever crosses your path!"))

/obj/item/hand_item/weapon/biter/fast
	name = "Fast Biter"
	desc = "Talk shit, get SPEED bit."
	color = "#448844"
	force = 25
	force_wielded = 30
	force_unwielded = 25
	attack_speed = CLICK_CD_MELEE * 0.5
	associated_trait = TRAIT_FASTBITE
	required_trait = TRAIT_FASTBITE

/obj/item/hand_item/weapon/biter/fast/on_successful_give(mob/living/user, reason)
	to_chat(user, span_notice("You click your teeth together, ready to strike with lightning speed!"))

/obj/item/hand_item/weapon/biter/play
	name = "Play Biter"
	desc = "Someone really should just muzzle you."
	color = "#ff44ff"
	force = 0
	force_wielded = 0
	force_unwielded = 0
	attack_speed = 1
	associated_trait = TRAIT_PLAYBITE
	required_trait = TRAIT_PLAYBITE

/obj/item/hand_item/weapon/biter/play/on_successful_give(mob/living/user, reason)
	to_chat(user, span_notice("You bare your teeth with such ferocity! Such a mighty killer!"))

/obj/item/hand_item/weapon/biter/spicy
	name = "Spicy Biter"
	desc = "Your sickly little nibbler, good for dropping fools."
	color = "#44FF44"
	force = 35
	force_wielded = 45
	force_unwielded = 35
	extra_damage = 30
	extra_damage_type = STAMINA
	associated_trait = TRAIT_SPICYBITE
	required_trait = TRAIT_SPICYBITE

/obj/item/hand_item/weapon/biter/spicy/on_successful_give(mob/living/user, reason)
	to_chat(user, span_notice("You bare your fangs, dripping with venom!"))

/// / / / ///
/// CLAWS ///
/obj/item/hand_item/weapon/clawer
	name = "Clawer"
	desc = "Thems some claws."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "clawer"
	slot_flags = INV_SLOTBIT_GLOVES
	w_class = WEIGHT_CLASS_TINY
	flags_1 = CONDUCT_1
	sharpness = SHARP_EDGED
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	force = 30
	force_wielded = 40
	force_unwielded = 30
	sharpness = SHARP_EDGED
	item_flags = PERSONAL_ITEM | ABSTRACT | HAND_ITEM
	weapon_special_component = /datum/component/weapon_special/single_turf
	block_parry_data = /datum/block_parry_data/bokken
	hud_icon = 'icons/mob/screen_gen.dmi'
	hud_icon_state = "claw"
	user_trait_can_spawn_associated_item = TRUE
	associated_trait = TRAIT_CLAW
	required_trait = TRAIT_CLAW
	category_base_path = /obj/item/hand_item/weapon/clawer
	// for_creatures = /obj/item/hand_item/weapon/clawer/creature

/obj/item/hand_item/weapon/clawer/on_successful_give(mob/living/user, reason)
	to_chat(user, span_notice("You ready your claws, ready to rip and tear at anything that gets in your way!"))

// /obj/item/hand_item/weapon/clawer/creature
// 	force = 30
// 	force_wielded = 40
// 	force_unwielded = 30
// 	associated_trait = "trait_creature_claw"

/obj/item/hand_item/weapon/clawer/big
	name = "Big Clawer"
	desc = "Thems some BIG ASS claws."
	color = "#884444"
	force = 35
	force_wielded = 45
	force_unwielded = 35
	attack_speed = CLICK_CD_MELEE * 1.5
	associated_trait = TRAIT_BIGCLAW
	required_trait = TRAIT_BIGCLAW

/obj/item/hand_item/weapon/clawer/big/on_successful_give(mob/living/user, reason)
	to_chat(user, span_notice("You ready your long deadly claws! Goodness they're heavy!"))

/obj/item/hand_item/weapon/clawer/razor
	name = "Razor Sharp Clawers"
	desc = "RIP AND TEAR."
	color = "#FF4444"
	force = 40
	force_wielded = 50
	force_unwielded = 40
	attack_speed = CLICK_CD_MELEE * 1.2
	associated_trait = TRAIT_RAZORCLAW
	required_trait = TRAIT_RAZORCLAW

/obj/item/hand_item/weapon/clawer/razor/on_successful_give(mob/living/user, reason)
	to_chat(user, span_notice("You ready your razor sharp claws! The wind whistles through them."))

/obj/item/hand_item/weapon/clawer/fast
	name = "Fast Clawer"
	desc = "Thems some FAST ASS claws."
	color = "#448844"
	force = 30
	force_wielded = 40
	force_unwielded = 30
	attack_speed = CLICK_CD_MELEE * 0.5
	associated_trait = TRAIT_FASTCLAW
	required_trait = TRAIT_FASTCLAW

/obj/item/hand_item/weapon/clawer/fast/on_successful_give(mob/living/user, reason)
	to_chat(user, span_notice("You ready your claws, light and agile!"))

/obj/item/hand_item/weapon/clawer/play
	name = "Play Clawer"
	desc = "Basically just a bean thwapper."
	color = "#FF88FF"
	force = 0
	force_wielded = 0
	force_unwielded = 0
	attack_speed = 1
	associated_trait = TRAIT_PLAYCLAW // you dont want to know how this claw plays
	required_trait = TRAIT_PLAYCLAW

/obj/item/hand_item/weapon/clawer/play/on_successful_give(mob/living/user, reason)
	to_chat(user, span_notice("You ready your harmless claws, ready to play!"))

/obj/item/hand_item/weapon/clawer/spicy
	name = "Spicy Clawer"
	desc = "My gross little litter box rakes, good for puttings idiots on the ground."
	color = "#44FF44"
	force = 30
	force_wielded = 40
	force_unwielded = 30
	extra_damage = 30
	extra_damage_type = STAMINA
	associated_trait = TRAIT_SPICYCLAW
	required_trait = TRAIT_SPICYCLAW

/obj/item/hand_item/weapon/clawer/spicy/on_successful_give(mob/living/user, reason)
	to_chat(user, span_notice("You ready your claws, dripping with venom!"))

/// / / / / / / ///
/// ARM BLADES  ///
/obj/item/hand_item/weapon/arm_blade
	name = "arm blade"
	desc = "A grotesque blade made out of bone and flesh that cleaves through people as a hot knife through butter."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "arm_blade"
	inhand_icon_state = "arm_blade"
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	force = 40
	force_wielded = 50
	force_unwielded = 40
	backstab_multiplier = 1.5
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	sharpness = SHARP_EDGED
	user_trait_can_spawn_associated_item = TRUE
	associated_trait = TRAIT_ARMBLADE
	required_trait = TRAIT_ARMBLADE
	category_base_path = /obj/item/hand_item/weapon/arm_blade

/obj/item/hand_item/weapon/arm_blade/on_successful_give(mob/living/user, reason)
	to_chat(user, span_notice("Your arm crunches into a horrifying, deadly blade!"))

/obj/item/hand_item/weapon/arm_blade/cyber
	name = "Cyber blade"
	desc = "A advanced cybernetic blade made out of numerous materials that cleaves through people as a hot knife through butter."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "cyber_blade"
	inhand_icon_state = "cyber_blade"
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	associated_trait = TRAIT_CYBERKNIFE
	required_trait = TRAIT_CYBERKNIFE

/obj/item/hand_item/weapon/arm_blade/cyber/on_successful_give(mob/living/user, reason)
	to_chat(user, span_notice("Your arm re-forges itself into a sleek cybernetic blade!"))

/// / / / / ///
/// SHOVERS ///
/obj/item/hand_item/weapon/shover // pak chooie unf
	name = "shover"
	desc = "Stay back!"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "latexballon"
	inhand_icon_state = "nothing"
	attack_verb = list("shoved", "pushed")
	hitsound = "sound/weapons/thudswoosh.ogg"
	force = 0
	force_wielded = 0
	throwforce = 0
	wound_bonus = 0
	can_knockback = TRUE
	hud_use = FALSE

/obj/item/hand_item/weapon/shover/on_successful_give(mob/living/user, reason)
	to_chat(user, span_notice("You hold a hand up, ready to shove something around!"))

/// / / / ///
/// TAILS ///
/obj/item/hand_item/weapon/tail
	name = "tailwhack"
	desc = "A tail. Good for whacking."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "severedtail"
	w_class = WEIGHT_CLASS_TINY
	force = 15
	backstab_multiplier = 1.8
	weapon_special_component = /datum/component/weapon_special/single_turf
	block_parry_data = /datum/block_parry_data/bokken
	can_knockback = TRUE
	spin_attack = TRUE
	use_bodypart_image_slot = PHUD_TAIL
	just_one = TRUE
	hud_icon = 'icons/mob/screen_gen.dmi'
	hud_icon_state = "tail"
	category_base_path = /obj/item/hand_item/weapon/tail
	user_trait_can_spawn_associated_item = TRUE
	associated_trait = TRAIT_TAIL
	required_trait = TRAIT_TAIL

/obj/item/hand_item/weapon/tail/on_successful_give(mob/living/user, reason)
	to_chat(user, span_notice("You swish your tail, ready to smack it into something!"))

/obj/item/hand_item/weapon/tail/playful
	name = "playful tail"
	desc = "A playful tail, good for teasing."
	force = 0
	force_wielded = 0
	attack_speed = 3
	weapon_special_component = /datum/component/weapon_special/single_turf
	associated_trait = TRAIT_TAILPLAY // yeah im into tailplay, what of it?
	required_trait = TRAIT_TAILPLAY

/obj/item/hand_item/weapon/tail/playful/on_successful_give(mob/living/user, reason)
	to_chat(user, span_notice("You ready your soft, harmless tail, ready to give someone a cute lil whap!"))

/obj/item/hand_item/weapon/tail/fast
	name = "fast tail"
	desc = "A speedy tail that's very good at whackin' fast."
	color = "#448844"
	force = 18
	attack_speed = CLICK_CD_MELEE * 0.6
	associated_trait = TRAIT_TAILWHIP
	required_trait = TRAIT_TAILWHIP

/obj/item/hand_item/weapon/tail/fast/on_successful_give(mob/living/user, reason)
	to_chat(user, span_notice("You swish your tail! It moves gracefully through the air."))

/obj/item/hand_item/weapon/tail/big
	name = "big tail"
	desc = "A big tail that whacks hard."
	color = "#884444"
	force = 25
	associated_trait = TRAIT_TAILSMASH
	required_trait = TRAIT_TAILSMASH

/obj/item/hand_item/weapon/tail/big/on_successful_give(mob/living/user, reason)
	to_chat(user, span_notice("You give your tail a wiggle, rippling with brute force!"))

/obj/item/hand_item/weapon/tail/spicy
	name = "spicy tail"
	desc = "A tail with something that can inject venom on it."
	color = "#44FF44"
	force = 15
	extra_damage = 30
	extra_damage_type = STAMINA
	associated_trait = TRAIT_TAILSPICY
	required_trait = TRAIT_TAILSPICY

/obj/item/hand_item/weapon/tail/spicy/on_successful_give(mob/living/user, reason)
	to_chat(user, span_notice("You extend your tail's venomous tip, ready to inject."))

/obj/item/hand_item/weapon/tail/thago
	name = "dangerous tail"
	desc = "A god damn mighty tail that would kill an allosaurus.  Maybe."
	color = "#FF4444"
	force = 40
	attack_speed = CLICK_CD_MELEE * 1.2
	associated_trait = TRAIT_TAILTHAGO
	required_trait = TRAIT_TAILTHAGO

/obj/item/hand_item/weapon/tail/thago/on_successful_give(mob/living/user, reason)
	to_chat(user, span_notice("Your mighty tail thumps against the ground with a dull thud, ready to pulverize anything in its path!"))

/// / / / ///
/// BEANS ///
/obj/item/hand_item/weapon/beans
	name = "beans"
	desc = "Them's ya' beans. Touch em' to things."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "bean"
	color = "#ff88bb"
	attack_verb = list()
	hitsound = "sound/effects/attackblob.ogg"
	force = 0
	force_wielded = 0
	throwforce = 0
	attack_speed = 0
	extra_damage = 1 // its mildly annoying!
	extra_damage_type = STAMINA
	hud_icon = 'icons/mob/screen_gen.dmi'
	hud_icon_state = "beans"
	required_trait = TRAIT_BEANS

/obj/item/hand_item/weapon/beans/on_successful_give(mob/user, reason)
	to_chat(user, span_notice("You ready your beans for WAR!!"))
	return TRUE

/obj/item/hand_item/weapon/beans/war
	name = "war beans"
	desc = "Them's ya' war beans. Touch em' to things you want dead."
	color = "#ff4444"
	force = 4
	force_wielded = 8
	backstab_multiplier = 3 //OBLITERATE THEM, BOYKISSER. ~TK
	required_trait = TRAIT_WARBEANS

/obj/item/hand_item/weapon/beans/on_successful_give(mob/user, reason)
	to_chat(user, span_notice("You ready your warbeans for REAL WAR!!"))
	return TRUE

/// / / / ///
/// BUTT  ///
/obj/item/hand_item/weapon/butt
	name = "butt"
	desc = "Very smoochable."
	icon = 'icons/ass/assfemale.png' // rofl
	attack_verb = list("smecked", "bwapped", "bumped", "clapped", "quapped", "vooped", "whomped")
	w_class = WEIGHT_CLASS_GIGANTIC // your butt is HUGE!!!!
	force = 15
	weapon_special_component = /datum/component/weapon_special/single_turf
	block_parry_data = /datum/block_parry_data/bokken
	use_bodypart_image_slot = PHUD_BUTT
	spin_attack = TRUE
	just_one = TRUE
	category_base_path = /obj/item/hand_item/weapon/butt
	hud_icon = 'icons/mob/screen_gen.dmi'
	hud_icon_state = "butt"
	required_trait = TRAIT_BUTT

/obj/item/hand_item/weapon/butt/on_successful_give(mob/living/user, reason)
	var/mob/living/carbon/human/H = user
	if(!H.has_butt())
		to_chat(user, span_notice("You give your rear end a wiggle, ready to thrust that thing into someone's face!"))
		return
	var/obj/item/organ/genital/butt/B = H.getorganslot(ORGAN_SLOT_BUTT)
	if(!B)
		to_chat(user, span_notice("You give your rear a wiggle, ready to thrust that thing into someone's face!"))
		return
	switch(B.size)
		if(1 to 2) // tiny butt
			to_chat(user, span_notice("You give your slender tushie a wiggle, ready to crack a few ribs!"))
		if(3) // small butt
			to_chat(user, span_notice("You give your modest behind a wiggle, ready to crack a few ribs!"))
		if(4) // average butt
			to_chat(user, span_notice("You give your ample backside a wiggle, ready to hip check something into the ground!"))
		if(5) // thicc butt
			to_chat(user, span_notice("You give your hefty booty a jiggle, ready to hip check something into the ground!"))
		if(6 to 7) // huge butt
			to_chat(user, span_notice("You give those massive wrecking balls of yours a powerful shake, ready to demolish anything that gets in their way!"))
		if(8 to INFINITY) // gargantuan hyper butt
			to_chat(user, span_notice("You give that colossal caboose of yours a thunderous quake, ready to flatten anything that gets in its way!"))
		else // invalid quantum state of a butt
			to_chat(user, span_notice("You give your rear end a wiggle, ready to thrust that thing into someone's face!"))

/obj/item/hand_item/weapon/butt/equipped(mob/user, slot)
	. = ..()
	buttify(user)

/obj/item/hand_item/weapon/butt/pickup(mob/living/user)
	. = ..()
	buttify(user)

/// modifies your butt's damage and attack speed based off its size
/// why yes this is in fact gameplay mechanics defined by ERP stuff
/obj/item/hand_item/weapon/butt/proc/buttify(mob/user)
	if(!iscarbon(user))
		return
	var/mob/living/carbon/human/H = user
	if(!H.has_butt())
		return
	var/obj/item/organ/genital/butt/B = H.getorganslot(ORGAN_SLOT_BUTT)
	force = 6 * B.size
	attack_speed = (CLICK_CD_MELEE / 3) * B.size
	switch(B.size)
		if(1 to 2)
			w_class = WEIGHT_CLASS_TINY
		if(3)
			w_class = WEIGHT_CLASS_SMALL
		if(4)
			w_class = WEIGHT_CLASS_NORMAL
		if(5)
			w_class = WEIGHT_CLASS_BULKY
		if(6 to 7)
			w_class = WEIGHT_CLASS_HUGE
		if(8 to INFINITY)
			w_class = WEIGHT_CLASS_GIGANTIC

// / / / / / / / / / / / / / / / / / / / / / / //
// hand items that instead spawn other things  //
/obj/item/hand_item/spawner
	name = "spawner item"
	desc = "Instead of giving the player this thing, it spawns something else and deletes itself!"
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "clawer"
	item_flags = PERSONAL_ITEM | ABSTRACT | HAND_ITEM
	var/atom/movable/thing_to_spawn
	var/del_on_ground = FALSE // if TRUE, the thing this spawns will be deleted if it fails to be put in someone's hands
	abstract = /obj/item/hand_item/spawner

/obj/item/hand_item/spawner/on_pre_spawn(mob/living/user)
	. = TRUE // stop the rest of the spawn code from running, since we dont actually want to spawn this thing!
	if(!ispath(thing_to_spawn))
		stack_trace("Invalid [thing_to_spawn] in [src] to spawn! Bad! Fix your code!")
		to_chat(user, span_alert("This thing isnt set up to spawn a thing! Call 1-800-IM-CODER with error code: FURRY-NAKED-EXPIE"))
		qdel(src)
		return
	var/atom/movable/spawned = new thing_to_spawn(get_turf(user))
	if(isitem(spawned))
		if(user.put_in_hands(spawned))
			on_spawner_put_in_hands(user, spawned)
		else
			on_spawner_put_on_ground(user, spawned)
	else
		on_spawner_put_on_ground(user, spawned)
	qdel(src) // delete the spawner item, since we dont actually want it to exist

// does something if we already have one of these, returns FALSE to proceed with normal giving, TRUE to stop it
/obj/item/hand_item/spawner/get_path_to_check(mob/living/user)
	return thing_to_spawn

/obj/item/hand_item/spawner/get_path_looseness(mob/living/user)
	return FALSE // strict nonlooseness

/obj/item/hand_item/spawner/proc/on_spawner_put_in_hands(mob/living/user, atom/movable/spawned)
	// override me!

/obj/item/hand_item/spawner/proc/on_spawner_put_on_ground(mob/living/user, atom/movable/spawned)
	if(del_on_ground)
		qdel(spawned)

// / / / / / / / / / //
// CUPHAND AND HEAD  //
/obj/item/hand_item/spawner/cuphand
	name = "your cupped hand"
	desc = "Cup your hand to hold liquids. Kinda gross ngl. if you can read this, call 1-800-IM-CODER with error code: OBESE-AVALI-TOIR"
	thing_to_spawn = /obj/item/reagent_containers/food/drinks/sillycup/handcup
	del_on_ground = TRUE // its your hand, if you drop it, it goes back to being your hand!
	hud_icon = 'icons/mob/screen_gen.dmi'
	hud_icon_state = "cuphand"
	// hud_use = TRUE

/obj/item/hand_item/spawner/cuphand/on_spawner_put_in_hands(mob/living/user, atom/movable/spawned)
	to_chat(user, span_notice("You cup your hands, ready to hold some liquids!"))

// / / / / / / / / / //
// rocks             //
/obj/item/hand_item/spawner/rock
	name = "rock"
	desc = "A simple rock. Probably not good for much, but you can try hitting things with it!"
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "rock"
	thing_to_spawn = /obj/item/ammo_casing/caseless/rock
	cooldown_time = 2.5 SECONDS
	cooldown_override_trait = TRAIT_MONKEYLIKE
	hud_icon = 'icons/mob/screen_gen.dmi'
	hud_icon_state = "rock"
	// hud_use = TRUE

/obj/item/hand_item/spawner/rock/on_spawner_put_in_hands(mob/living/user, atom/movable/spawned)
	to_chat(user, span_notice("You scoop up a hefty rock!"))

/obj/item/hand_item/spawner/rock/on_spawner_put_on_ground(mob/living/user, atom/movable/spawned)
	to_chat(user, span_notice("You find a hefty rock on the ground! Your hands are too full to pick it up, but it's there!"))

/obj/item/hand_item/spawner/rock/on_failed_give_message(mob/living/user, reason)
	if(reason == HI_ON_COOLDOWN)
		var/timeleft = SShanditems.get_cooldown_time_left(user, src)
		to_chat(user, span_alert("You scared all the rocks away! They'll be back in [DisplayTimeText(timeleft)] though."))
		return TRUE
	. = ..()

// / / / / / / / / //
// brick           //
/obj/item/hand_item/spawner/brick
	name = "brick"
	desc = "A simple brick. Probably not good for much, but you can try hitting things with it!"
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "brick"
	thing_to_spawn = /obj/item/ammo_casing/caseless/brick
	cooldown_time = 2.5 SECONDS
	cooldown_override_trait = TRAIT_QUICK_BUILD

/obj/item/hand_item/spawner/brick/on_spawner_put_in_hands(mob/living/user, atom/movable/spawned)
	to_chat(user, span_notice("You pick up a sturdy brick!"))

/obj/item/hand_item/spawner/brick/on_spawner_put_on_ground(mob/living/user, atom/movable/spawned)
	to_chat(user, span_notice("You find a sturdy brick on the ground! Your hands are too full to pick it up, but it's there!"))

/obj/item/hand_item/spawner/brick/on_failed_give_message(mob/living/user, reason)
	if(reason == HI_ON_COOLDOWN)
		var/timeleft = SShanditems.get_cooldown_time_left(user, src)
		to_chat(user, span_alert("You scared all the bricks away! They'll be back in [DisplayTimeText(timeleft)] though."))
		return TRUE
	. = ..()

/obj/item/hand_item/spawner/snowball
	name = "snowball"
	desc = "A simple snowball. Probably not good for much, but you can try hitting things with it!"
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "snowball"
	thing_to_spawn = /obj/item/toy/snowball
	required_months = list(12, 1, 2) // only available in december, january, and february!
	cooldown_time = 1 SECONDS

/obj/item/hand_item/spawner/snowball/on_spawner_put_in_hands(mob/living/user, atom/movable/spawned)
	to_chat(user, span_notice("You pack together a fluffy snowball!"))

/obj/item/hand_item/spawner/snowball/on_spawner_put_on_ground(mob/living/user, atom/movable/spawned)
	to_chat(user, span_notice("You nudge some snow on the gound into a snowball! Your hands are too full to pick it up, but it's there!"))

/obj/item/hand_item/spawner/snowball/on_failed_give_message(mob/living/user, reason)
	if(reason == HI_OUT_OF_SEASON)
		to_chat(user, span_alert("It's a little warm for snowballs, isn't it? You'll have to wait for the wintery months to get some!"))
		return TRUE
	if(reason == HI_ON_COOLDOWN)
		var/timeleft = SShanditems.get_cooldown_time_left(user, src)
		to_chat(user, span_alert("You scared all the snow away! They'll be back in [DisplayTimeText(timeleft)] though."))
		return TRUE



////// old code in case the above doesnt work
// /obj/item/hand_item/butt/proc/buttify(mob/user)
// 	if(!iscarbon(user))
// 		return
// 	var/mob/living/carbon/human/H = user
// 	if(!H.has_butt())
// 		return
// 	icon = "icons/effects/effects.dmi"
// 	icon = "nothing"
// 	var/obj/item/organ/genital/butt/B = H.getorganslot(ORGAN_SLOT_BUTT)
// 	var/datum/sprite_accessory/sprite_acc = B.get_sprite_accessory()
// 	icon = 'icons/obj/genitals/butt_onmob.dmi'
// 	icon_state = B.get_icon_state(user, sprite_acc, FALSE, "FRONT")
// 	dir = NORTH
// 	var/datum/preferences/P = extract_prefs(user)
// 	color = "#[P.features["butt_color"]]"
// 	force = 6 * B.size
// 	attack_speed = (CLICK_CD_MELEE / 3) * B.size
// 	switch(B.size)
// 		if(1 to 2)
// 			w_class = WEIGHT_CLASS_TINY
// 		if(3)
// 			w_class = WEIGHT_CLASS_SMALL
// 		if(4)
// 			w_class = WEIGHT_CLASS_NORMAL
// 		if(5)
// 			w_class = WEIGHT_CLASS_BULKY
// 		if(6 to 7)
// 			w_class = WEIGHT_CLASS_HUGE
// 		if(8 to INFINITY)
// 			w_class = WEIGHT_CLASS_GIGANTIC

/// / / / / / / / / / / / / / / / / / / / / / / / / / ///
/// And a bunch of stuff we probably dont use anymore ///


/obj/item/hand_item/cantrip
	name = "Cantrip"
	desc = "it's magic yo."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "clawer"
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	force = 15
	backstab_multiplier = 1.8
	throwforce = 0
	wound_bonus = 4
	attack_speed = CLICK_CD_MELEE * 0.7
	item_flags = DROPDEL | HAND_ITEM
	weapon_special_component = /datum/component/weapon_special/single_turf


/obj/item/hand_item/cantrip/godhand
	icon_state = "disintegrate"
	inhand_icon_state = "disintegrate"
	icon = 'icons/obj/items_and_weapons.dmi'
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	name = "Shocking Grasp"
	desc = "A basic cantrip that allows the caster to inflict nasty shocks on touch"
	item_flags = ABSTRACT | DROPDEL
	force = 30
	backstab_multiplier = 1.6
	hitsound = 'sound/weapons/sear.ogg'
	damtype = BURN
	attack_verb = list("seared", "zapped", "fried", "shocked")


/obj/item/hand_item/merp_doer
	name = "MERP doer"
	desc = "Click someone with this thing to open the MERP interactions menu! From there, you can do all sorts of lewd or not-so-lewd things with them (or yourself!!)!"
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "blushfox"

/obj/item/hand_item/merp_doer/attack(mob/living/M, mob/living/user)
	SEND_SIGNAL(user, COMSIG_CLICK_CTRL_SHIFT, M)
	qdel(src)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/obj/item/hand_item/subtle_catapult
	name = "discrete action delivery system"
	desc = "Do lewd things in public, without anyone (but whoever you're doing it to) knowing!"
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "blushfox"
	item_flags = ABSTRACT | HAND_ITEM | NO_TURN
	max_reach = 70
	var/message
	var/aoe_range = 1

/obj/item/hand_item/subtle_catapult/examine(mob/user)
	. = ..()
	// . += span_green("AOE range: Your tile, plus [aoe_range] tiles in every direction.")
	. += span_green("Current message:")
	. += span_notice(message ? message : "None.")
	. += span_green("--")
	. += span_green("HOW 2 USE:")
	. += span_notice("1. Click it in hand to start writing a message.")
	. += span_notice("2. Click this on someone to send that message to them.")
	. += span_notice("3. Or CtrlShift click it to pick anyone in view")
	. += span_notice("You can also alt-click it to view your previous messages, and even select them to send!")
	. += span_notice("It will ask you to confirm before sending, so don't worry about accidentally sending something you didn't mean to!")
	. += span_notice("Also dont worry about dropping it or anything, it should still take whatever you wrote with it!")
	. += span_green("--")

/obj/item/hand_item/subtle_catapult/pre_attack(atom/A, mob/living/user, params, attackchain_flags, damage_multiplier)
	. = TRUE
	if(!extract_client(A))
		return
	if(message)
		StartSendMessage(user, A)
	else
		EditMessage(user, A)

/obj/item/hand_item/subtle_catapult/attack_self(mob/user)
	. = ..()
	EditMessage(user)

/obj/item/hand_item/subtle_catapult/AltClick(mob/user)
	. = ..()
	var/list/messages = SSchat.GetHornyHistory(user)
	if(!LAZYLEN(messages))
		to_chat(user, span_alert("You haven't made any messages yet!"))
		return
	var/selected = input(
		user, 
		"Here's a list of the messages you've made with this! Pick one to load it into this tool!", 
		"Select a message to send!", 
		message,
	) as null|anything in messages
	if(selected)
		message = selected
		to_chat(user, span_green("Message loaded!"))
	else
		to_chat(user, span_alert("Message selection cancelled!"))

/obj/item/hand_item/subtle_catapult/CtrlShiftClick(mob/user)
	. = ..()
	var/list/ppl = hearers(10, user)
	for(var/mob/M in ppl)
		if(!extract_client(M))
			ppl -= M
		if(!isliving(M))
			ppl -= M
		if(M == user)
			ppl -= M
	var/mob/whomst = input(
		user,
		"Who would you like to send a message to?",
		"Select a target!",
		null
	) as null|anything in ppl
	if(whomst)
		if(message)
			StartSendMessage(user, whomst)
		else
			EditMessage(user, whomst)
	else
		to_chat(user, span_alert("Message selection cancelled!"))

/obj/item/hand_item/subtle_catapult/dropped(mob/user)
	. = ..()
	SSchat.StashHornyThing(user)

/obj/item/hand_item/subtle_catapult/proc/EditMessage(mob/user, mob/living/M, and_send)
	var/head = M ? "Prepare a message for [M]!" : "Prepare a message!"
	var/msg = stripped_multiline_input_or_reflect(user, EMOTE_HEADER_TEXT, head, message, 99999)
	if(msg)
		to_chat(user, span_green("Message prepared:"))
		to_chat(user, span_notice(msg))
		to_chat(user, span_green("Click [M] to send it!"))
		message = msg
		SSchat.StoreHornyMessage(user, msg)
		if(M)
			StartSendMessage(user, M)
	else
		to_chat(user, span_alert("Message cancelled! Nothing's changed!!"))

/obj/item/hand_item/subtle_catapult/proc/StartSendMessage(mob/user, mob/living/M)
	if(!message)
		return
	if(!M || !user)
		return
	// if(M == user || !M.client)
	// 	return
	var/shomsg = message
	if(LAZYLEN(shomsg) > 700)
		shomsg = copytext(shomsg, 0, 700) + "..."
	// first we ask em, you sure you wanna do this?
	var/confirm = alert(user, "You are about to send this message to [M]:\n\n[message]\n\nAre you sure you want to do this?", "Send message?", "Yes", "No")
	if(confirm != "Yes")
		to_chat(user, span_alert("Okay nevermind!!"))
		return
	DeliverMessage(user, M)

/obj/item/hand_item/subtle_catapult/proc/DeliverMessage(mob/user, mob/living/M)
	var/original_message = message
	var/to_send = message

	user.log_message(to_send, LOG_SUBTLE)
	var/msg_check = user.say_narrate_replace(to_send, user)
	if(msg_check)
		to_send = span_subtle("<i>[msg_check]</i>")
	else
		to_send = span_subtle("<b>[user]</b> " + "<i>[user.say_emphasis(to_send)]</i>")

	var/datum/emote/E
	E = E.emote_list["subtle"]

	var/datum/rental_mommy/chat/mommy = E.BuildMommy(user, to_send)
	mommy.original_message = original_message
	mommy.exclusive_targets = list(M, user)

	// Visible to_send, as in only visible to you and them
	user.visible_message(
		message = to_send,
		data = list("mom" = mommy))

	//broadcast to ghosts, if they have a client, are dead, arent in the lobby, allow ghostsight, and, if subtler, are admemes
	user.emote_for_ghost_sight(mommy.message, TRUE, 0)
	mommy.checkin()
	user.playsound_local(get_turf(user), 'sound/f13effects/sunsetsounds/blush.ogg', 80, FALSE)
	M.playsound_local(get_turf(M), 'sound/f13effects/sunsetsounds/blush.ogg', 80, FALSE)

///////////////////////////////////////////////////
//// FLIRT ITEM ///////////////////////////////////
/obj/item/hand_item/flirter
	name = "Flirtation Device" // in the event of a crash, your hand can be used as a flirtation device
	desc = "This thing is used to flirt with people! Or it would if it initialized properly. Oops."
	icon = 'icons/mob/actions.dmi'
	icon_state = "velvet_chords"
	max_reach = 30 // love knows no bounds
	var/flirtkey = "hi"

/obj/item/hand_item/flirter/proc/flirtify(datum/flirt/F) // Fs in chat
	if(!istype(F))
		qdel(src) // dies of illiteracy
		return
	flirtkey = F.key
	name = F.flirtname
	desc = F.flirtdesc
	icon = F.flirticon
	icon_state = F.flirticon_state
	return TRUE

/obj/item/hand_item/flirter/pre_attack(atom/A, mob/living/user, params, attackchain_flags, damage_multiplier)
	. = STOP_ATTACK_PROC_CHAIN // never let this thing hit anyone ever for any ever anytime
	if(!isliving(A))
		return
	if(!SSchat.run_directed_flirt(user, A, flirtkey))
		return
	qdel(src)

/obj/item/hand_item/flirter/attack_self(mob/user)
	. = STOP_ATTACK_PROC_CHAIN // never let this thing hit anyone ever for any ever anytime
	if(!isliving(user))
		return
	if(!SSchat.run_aoe_flirt(user, flirtkey))
		return
	qdel(src)

////////////////////////////////////////////////////////
//// FLIRT TARGETTER ///////////////////////////////////
/obj/item/hand_item/flirt_targetter
	name = "Flirtation Targetter" // in the event of a crash, your hand can be used as a flirtation device
	desc = "Click someone with this, and the next Flirt button you press will be directed at them! There's no range restriction, so, yeah!"
	icon = 'icons/mob/actions.dmi'
	icon_state = "velvet_chords"
	max_reach = 30 // love knows no bounds

/obj/item/hand_item/flirt_targetter/pre_attack(atom/A, mob/living/user, params, attackchain_flags, damage_multiplier)
	. = STOP_ATTACK_PROC_CHAIN // never let this thing hit anyone ever for any ever anytime
	if(!isliving(A))
		return
	if(!SSchat.add_flirt_target(user, A))
		return
	to_chat(user, span_notice("You'll now send a flirt to [A] when you press the next Flirt button. Happy flirting!"))
	qdel(src)








#undef LICK_LOCATION
#undef LICK_INTENT
#undef LICK_CANCEL
