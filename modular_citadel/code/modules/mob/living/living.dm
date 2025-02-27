/mob/living

/atom
	var/pseudo_z_axis

/atom/proc/get_fake_z()
	return pseudo_z_axis

/obj/structure/table
	pseudo_z_axis = 8

/turf/open/get_fake_z()
	var/objschecked
	for(var/obj/structure/structurestocheck in contents)
		objschecked++
		if(structurestocheck.pseudo_z_axis)
			return structurestocheck.pseudo_z_axis
		if(objschecked >= 25)
			break
	return pseudo_z_axis

/mob/living/Move(atom/newloc, direct, glide_size_override)
	. = ..()
	if(.)
		pseudo_z_axis = newloc.get_fake_z()
		pixel_z = pseudo_z_axis

/mob/living/carbon/update_stamina()
	var/stam_damage = getStaminaLoss()
	if(stam_damage >= STAMINA_SOFTCRIT)
		if(!(combat_flags & COMBAT_FLAG_SOFT_STAMCRIT))
			ENABLE_BITFIELD(combat_flags, COMBAT_FLAG_SOFT_STAMCRIT)
	else
		if(combat_flags & COMBAT_FLAG_SOFT_STAMCRIT)
			DISABLE_BITFIELD(combat_flags, COMBAT_FLAG_SOFT_STAMCRIT)
	if(stam_damage)
		if(!(combat_flags & COMBAT_FLAG_HARD_STAMCRIT) && stam_damage >= STAMINA_CRIT && !stat)
			set_resting(TRUE, FALSE, FALSE)
			SEND_SIGNAL(src, COMSIG_DISABLE_COMBAT_MODE)
			ENABLE_BITFIELD(combat_flags, COMBAT_FLAG_HARD_STAMCRIT)
			filters += CIT_FILTER_STAMINACRIT
			update_mobility()
			var/timeout = SSmobs.stat_roll_stamcrit_timeout(src)
			stamcrit_timeout = world.time + timeout
			to_chat(src, span_userdanger("You're knocked down and totally helpless~"))
			var/tmtt = round(timeout*0.1, 0.5)
			var/timez = span_green("[tmtt] seconds")
			to_chat(src, span_notice("If left alone, you should start feeling better in about [timez]!"))
			worth_critting = FALSE
			payout_attackers()
	if((combat_flags & COMBAT_FLAG_HARD_STAMCRIT) && stam_damage <= STAMINA_SOFTCRIT)
		to_chat(src, span_notice("You don't feel nearly as exhausted anymore."))
		DISABLE_BITFIELD(combat_flags, COMBAT_FLAG_HARD_STAMCRIT | COMBAT_FLAG_SOFT_STAMCRIT)
		filters -= CIT_FILTER_STAMINACRIT
		update_mobility()
	update_health_hud()

/mob/living/carbon/proc/payout_attackers()
	var/list/attackers = list()
	for(var/pkey in attacked_me)
		var/mob/doer = extract_mob(pkey)
		if(!doer)
			continue
		if(is_on_same_side(src, doer))
			continue
		var/howlongago = world.time - attacked_me[pkey]
		if(howlongago > 5 MINUTES)
			continue
		attackers |= pkey
	for(var/dinker in attackers)
		var/mob/living/doper = extract_mob(dinker)
		doper.paycash(SSmobs.cash_for_critting_someone)


/mob/living/proc/paycash(amount)
	var/amt = COINS_TO_CREDITS(amount)
	if(!SSeconomy.adjust_funds(src, amt))
		return
	var/cashdisplay = ""
	if(amt >= 0)
		cashdisplay += "+"
	else
		cashdisplay += "-"
	cashdisplay += "$[CREDITS_TO_COINS(amt)]"
	new /obj/effect/temp_visual/floaty_thing/cash(get_turf(src), cashdisplay)
