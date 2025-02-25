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
			var/timeout = 7 SECONDS
			switch(get_stat(STAT_ENDURANCE)) // COOLSTAT IMPLEMENTATION: ENDURANCE
				if(0, 1)
					timeout *= 2
				if(2)
					timeout *= 1.8
				if(3)
					timeout *= 1.5
				if(4)
					timeout *= 1.25
				if(5)
					timeout *= 1
				if(6)
					timeout *= 0.9
				if(7)
					timeout *= 0.85
				if(8)
					timeout *= 0.80
				if(9)
					timeout *= 0.75
			stamcrit_timeout = world.time + timeout
			to_chat(src, span_userdanger("You're knocked down and totally helpless~"))
			var/timez = span_green("[round(timeout*0.1, 0.5)] seconds")
			to_chat(src, span_notice("If left alone, you should start feeling better in about [timez]!"))
	if((combat_flags & COMBAT_FLAG_HARD_STAMCRIT) && stam_damage <= STAMINA_SOFTCRIT)
		to_chat(src, span_notice("You don't feel nearly as exhausted anymore."))
		DISABLE_BITFIELD(combat_flags, COMBAT_FLAG_HARD_STAMCRIT | COMBAT_FLAG_SOFT_STAMCRIT)
		filters -= CIT_FILTER_STAMINACRIT
		update_mobility()
	update_health_hud()
