/obj/item/stealthboy
	name = "Nyampire Sneak-box Mk. II"
	desc = "Something that looks suspiciously like a pda, but works to hide you from critters. It takes a few seconds to turn on, and will recharge while its off. ALT+click to activate!"
	icon = 'icons/obj/pda_rugged.dmi' //Placeholder till ones sprited
	icon_state = "pda-neko" //Placeholder till ones sprited
	item_flags = NOBLUDGEON
	slot_flags = INV_SLOTBIT_BELT
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	var/obj/item/stock_parts/cell/cell = /obj/item/stock_parts/cell/high/slime
	var/use_per_tick = 1000 // normal cell has 10000 charge, 200 charge/second = 50 seconds of stealth //if the previous comment is correct this is 25 seconds of stealth	
	actions_types = list(/datum/action/item_action/stealthboy_cloak)
	var/mybar
	var/mob/applying_to
	var/do_boop = FALSE
	var/do_warn = TRUE
	var/on = FALSE
	var/warn_time = 1 SECONDS
	var/max_time_left = 20 SECONDS
	var/time_left = 20 SECONDS
	var/min_time_left = 15 SECONDS
	var/last_tick = 0
	var/list/factionlist = list(
		"supermutant",
		"raider",
		"china",
		"enclave",
		"wastebot",
		"ghoul",
		"cazador",
		"bs",
		"vault",
		"city",
		"tribe",
		"Legion",
		"NCR",
		"gecko",
		"rat",
		"ant",
		"radscorpion",
		"crabs", 
		"trog",
		"plants",
		"tunneller",
		"wolf",
		"hostile",
		"russian", 
		"yaoguai",
		"carp",
		"duck",
		"spooky",
		"faithless",
		"vines",
	)
	factionbound = list("cat")

/obj/item/stealthboy/Destroy()
	Deactivate()
	. = ..()

/obj/item/stealthboy/ui_action_click(mob/user)
	Toggle(user)

// /obj/item/stealthboy/item_action_slot_check(slot, mob/user)
// 	if(slot == SLOT_BELT)
// 		return 1

/obj/item/stealthboy/examine(mob/user)
	. = ..()
	. += span_notice("The meter thingy says that it has around [round(time_left / 10)] seconds of charge left.")
	if(time_left < min_time_left)
		if(on)
			. += span_alert("The low battery thingy is flashing red! If deactivated, it won't have enough charge to activate!")
		else
			. += span_alert("The low battery thingy is flashing red! It doesn't have enough charge to activate!")

/obj/item/stealthboy/AltClick(mob/user)
	. = ..()
	Toggle(user)

/obj/item/stealthboy/proc/Toggle(mob/living/carbon/human/user)
	if(on)
		Deactivate(user)
		return
	if(HAS_TRAIT(user, "stealthinvis"))
		Deactivate(user)
		return
	if(CanActivate(user, TRUE))
		StartActivating(user)
	else
		user.playsound_local(get_turf(src), 'sound/effects/stealthcock_cant.ogg', 15, FALSE)

/obj/item/stealthboy/proc/CanActivate(mob/living/carbon/human/user, msg)
	if(!user)
		user = applying_to
	if(!user)
		return FALSE
	if(time_left < min_time_left)
		if(msg)
			to_chat(user, span_alert("The [src] doesn't have enough charge left to activate!"))
		return FALSE
	if(user.stat != CONSCIOUS)
		if(msg)
			to_chat(user, span_alert("You're too messed up to activate \The [src]!"))
		return FALSE
	if(user.get_item_by_slot(SLOT_BELT) != src)
		if(msg)
			to_chat(user, span_alert("You need to be wearing \The [src] on your belt to activate it!"))
		return FALSE
	return TRUE

/obj/item/stealthboy/proc/CanRemainActive()
	if(!applying_to)
		return FALSE
	if(!on)
		return FALSE
	if(time_left <= 0)
		return FALSE
	if(applying_to.stat != CONSCIOUS)
		return FALSE
	if(applying_to.get_item_by_slot(SLOT_BELT) != src)
		return FALSE
	return TRUE

/obj/item/stealthboy/proc/StartActivating(mob/living/carbon/human/user)
	if(on)
		return
	user.playsound_local(get_turf(src), 'sound/effects/stealthcock_precum.ogg', 15, FALSE)
	var/fadetime = 1 SECONDS
	if(!check_faction(user))
		fadetime = 5 SECONDS
	if(!do_after(user, fadetime, TRUE, src, TRUE, null, null, null, TRUE, TRUE, TRUE, FALSE, FALSE))
		user.playsound_local(get_turf(src), 'sound/effects/stealthcock_cant.ogg', 15, FALSE)
		to_chat(user, span_alert("[src] failed to activate!"))
		return
	if(CanActivate(user, TRUE))
		Activate(user)

/obj/item/stealthboy/proc/Activate(mob/living/carbon/human/user)
	if(on)
		Deactivate(user)
		return
	if(HAS_TRAIT(user, "stealthinvis"))
		Deactivate(user)
		return
	if(applying_to)
		if(applying_to != user)
			Deactivate()
		else
			return
	var/fadetime = 0.5 SECONDS
	if(!check_faction(user))
		fadetime = 5 SECONDS
	animate(user, alpha = 0, time = fadetime SECONDS)
	ADD_TRAIT(user, "stealthinvis", src)
	applying_to = user
	to_chat(user, span_notice("You activate \The [src]."))
	last_tick = world.time
	user.faction += factionlist
	START_PROCESSING(SSfastprocess, src)
	on = TRUE
	do_sparks(1, TRUE, get_turf(src), /datum/effect_system/spark_spread/quantum)
	user.playsound_local(get_turf(src), 'sound/effects/stealthcock_cum.ogg', 15, FALSE)
	RegisterSignal(user, COMSIG_MOB_ITEM_ATTACK, PROC_REF(Deactivate), TRUE)

/obj/item/stealthboy/proc/Deactivate(mob/living/carbon/human/user, msg)
	if(!user)
		user = applying_to
	if(!user)
		CRASH("Deactivate called without a user or applying_to!")
	animate(user, alpha = initial(user.alpha), time = 0.5 SECONDS)
	to_chat(user, span_notice("\The [src] deactivates!"))
	user.faction -= factionlist
	REMOVE_TRAIT(user, "stealthinvis", src)
	// applying_to = null
	on = FALSE
	applying_to = null
	do_sparks(4, TRUE, get_turf(src), /datum/effect_system/spark_spread/quantum)
	user.playsound_local(get_turf(src), 'sound/effects/stealthcock_muc.ogg', 15, FALSE)
	UnregisterSignal(user, COMSIG_MOB_ITEM_ATTACK)

/obj/item/stealthboy/process()
	if(!on)
		ChargeTick()
	else
		StealthTick()
	UpdateProgBar()

/obj/item/stealthboy/proc/StealthTick()
	if(!last_tick)
		last_tick = world.time
		return
	if(!CanRemainActive())
		Deactivate()
		return
	if(!check_faction(loc))
		if(prob(2))
			Deactivate()
		if(prob(10))
			do_sparks(4, TRUE, get_turf(src), /datum/effect_system/spark_spread/quantum)
		if(prob(5))
			playsound(src, 'sound/f13effects/sunsetsounds/geck.ogg', 100, TRUE)
	var/delta = world.time - last_tick
	last_tick = world.time
	time_left -= delta
	if(time_left <= min_time_left)
		do_boop = TRUE
	if(time_left <= warn_time && do_warn)
		var/mob/user = loc
		if(ismob(user))
			user.playsound_local(get_turf(src), 'sound/effects/stealthcock_nearly_muc.ogg', 15, FALSE)
			do_warn = FALSE
	if(time_left <= 0)
		Deactivate()

/obj/item/stealthboy/proc/ChargeTick()
	if(!last_tick)
		last_tick = world.time
		return
	var/delta = world.time - last_tick
	last_tick = world.time
	if(!check_faction(loc))
		if(prob(80))
			return // lol
	time_left += (delta * 0.75)
	if(do_boop && time_left > min_time_left)
		var/mob/user = loc
		if(ismob(user))
			user.playsound_local(get_turf(src), 'sound/effects/stealthcock_can_work_now.ogg', 15, FALSE)
			do_boop = FALSE
	if(time_left > warn_time && !do_warn)
		do_warn = TRUE
	if(time_left > max_time_left)
		time_left = max_time_left

/obj/item/stealthboy/proc/UpdateProgBar()
	if(!mybar)
		mybar = SSprogress_bars.add_bar(src, list(), max_time_left, FALSE, FALSE)
	SSprogress_bars.update_bar(mybar, time_left)

