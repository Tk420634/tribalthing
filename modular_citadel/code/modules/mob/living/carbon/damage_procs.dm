/mob/living/carbon/adjustStaminaLossBuffered(amount, updating_health = 1)
	if(status_flags & GODMODE)
		return 0
	if(SSmobs.disable_stambuffer)
		return adjustStaminaLoss(amount, updating_health)
	if(CONFIG_GET(flag/disable_stambuffer))
		return
	var/directstamloss = (bufferedstam + amount) - stambuffer
	if(directstamloss > 0)
		adjustStaminaLoss(directstamloss)
	bufferedstam = clamp(bufferedstam + amount, 0, stambuffer)
	stambufferregentime = world.time + 10
	if(updating_health)
		update_health_hud()

/mob/living/carbon/adjustStaminaLoss(amount, updating_health = TRUE, forced = FALSE, affected_zone = BODY_ZONE_CHEST)
	if(!forced && (status_flags & GODMODE))
		return FALSE
	var/end_mod = 1
	if(amount > 1)
		amount *= end_mod
	var/obj/item/bodypart/BP = isbodypart(affected_zone)? affected_zone : (get_bodypart(check_zone(affected_zone)) || bodyparts[1])
	if(amount > 0? BP.receive_damage(0, 0, amount * incomingstammult) : BP.heal_damage(0, 0, abs(amount), FALSE, FALSE))
		update_damage_overlays()
	if(updating_health)
		updatehealth()
	update_stamina()
	if((combat_flags & COMBAT_FLAG_HARD_STAMCRIT) && amount > 20)
		incomingstammult = max(0.01, incomingstammult/(amount*0.05))
	return amount
