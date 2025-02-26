/datum/hud/var/atom/movable/screen/staminas/staminas
/datum/hud/var/atom/movable/screen/staminabuffer/staminabuffer

/atom/movable/screen/staminas
	icon = 'modular_citadel/icons/ui/screen_gen.dmi'
	name = "stamina"
	icon_state = "stamina0"
	screen_loc = ui_stamina
	mouse_opacity = 1

/atom/movable/screen/staminas/Click(location,control,params)
	if(isliving(usr))
		var/mob/living/L = usr
		var/stamheal = SSmobs.stat_roll_stamina_recovery_per_tick(L)
		var/timeout = SSmobs.stat_roll_stamcrit_timeout(L)
		var/end_mod = SSmobs.stat_roll_incoming_stamina_damage(L)
		var/list/words = list()
		words += "You have around <b>[STAMINA_CRIT - L.getStaminaLoss()]</b> stamina."
		words += "You'll normally restore [stamheal] stamina every 2-ish seconds."
		words += "If this goes below zero-ish, you'll be helpless and unable to restore stamina for around <b>[round(timeout*0.1, 0.5)]</b> seconds"
		var/moreless = end_mod > 1 ? "[span_alert("[end_mod]x")]" : "[span_green("[end_mod]x")]"
		words += "You also take [moreless] stamina damage, due to your robust toughness and physique."
		if(prob(0.5))
			words += "bitch"
		var/werds = words.Join("<br>")
		to_chat(L, span_notice("[werds]"))

/atom/movable/screen/staminas/update_icon_state()
	var/mob/living/carbon/user = hud?.mymob
	if(!user)
		return
	if(user.stat == DEAD || (user.combat_flags & COMBAT_FLAG_HARD_STAMCRIT) || (user.hal_screwyhud in 1 to 2))
		icon_state = "staminacrit"
	else if(user.hal_screwyhud == 5)
		icon_state = "stamina0"
	else
		icon_state = "stamina[clamp(FLOOR(user.getStaminaLoss() /20, 1), 0, 6)]"

//stam buffer
/atom/movable/screen/staminabuffer
	icon = 'modular_citadel/icons/ui/screen_gen.dmi'
	name = "stamina buffer"
	icon_state = "stambuffer0"
	screen_loc = ui_stamina
	layer = 3
	mouse_opacity = 0

/atom/movable/screen/staminabuffer/update_icon_state()
	var/mob/living/carbon/user = hud?.mymob
	if(!user)
		return
	if(user.stat == DEAD || (user.combat_flags & COMBAT_FLAG_HARD_STAMCRIT) || (user.hal_screwyhud in 1 to 2))
		icon_state = "stambuffer7"
	else if(user.hal_screwyhud == 5)
		icon_state = "stambuffer0"
	else
		switch(user.bufferedstam / user.stambuffer)
			if(0.95 to INFINITY)
				icon_state = "stambuffer7"
			if(0.9 to 0.95)
				icon_state = "stambuffer6"
			if(0.8 to 0.9)
				icon_state = "stambuffer5"
			if(0.6 to 0.8)
				icon_state = "stambuffer4"
			if(0.4 to 0.6)
				icon_state = "stambuffer3"
			if(0.2 to 0.4)
				icon_state = "stambuffer2"
			if(0.05 to 0.2)
				icon_state = "stambuffer1"
			else
				icon_state = "stambuffer0"
