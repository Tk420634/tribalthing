/datum/martial_art/krav_maga
	name = "Krav Maga"
	id = MARTIALART_KRAVMAGA
	pugilist = TRUE
	var/datum/action/neck_chop/neckchop = new/datum/action/neck_chop()
	var/datum/action/leg_sweep/legsweep = new/datum/action/leg_sweep()
	var/datum/action/lung_punch/lungpunch = new/datum/action/lung_punch()

/datum/action/neck_chop
	name = "Neck Chop - Injures the neck, stopping the victim from speaking for a while."
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "neckchop"

/datum/action/neck_chop/Trigger()
	if(owner.incapacitated())
		to_chat(owner, span_warning("You can't use [name] while you're incapacitated."))
		return
	var/mob/living/carbon/human/H = owner
	if (H.mind.martial_art.streak == "neck_chop")
		owner.visible_message(span_danger("[owner] assumes a neutral stance."), "<b><i>Your next attack is cleared.</i></b>")
		H.mind.martial_art.streak = ""
	else
		if(HAS_TRAIT(H, TRAIT_PACIFISM))
			to_chat(H, span_warning("You don't want to harm other people!"))
			return
		owner.visible_message(span_danger("[owner] assumes the Neck Chop stance!"), "<b><i>Your next attack will be a Neck Chop.</i></b>")
		H.mind.martial_art.streak = "neck_chop"

/datum/action/leg_sweep
	name = "Leg Sweep - Trips the victim, knocking them down for a brief moment."
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "legsweep"

/datum/action/leg_sweep/Trigger()
	if(owner.incapacitated())
		to_chat(owner, span_warning("You can't use [name] while you're incapacitated."))
		return
	var/mob/living/carbon/human/H = owner
	if (H.mind.martial_art.streak == "leg_sweep")
		owner.visible_message(span_danger("[owner] assumes a neutral stance."), "<b><i>Your next attack is cleared.</i></b>")
		H.mind.martial_art.streak = ""
	else
		if(HAS_TRAIT(H, TRAIT_PACIFISM))
			to_chat(H, span_warning("You don't want to harm other people!"))
			return
		owner.visible_message(span_danger("[owner] assumes the Leg Sweep stance!"), "<b><i>Your next attack will be a Leg Sweep.</i></b>")
		H.mind.martial_art.streak = "leg_sweep"

/datum/action/lung_punch//referred to internally as 'quick choke'
	name = "Lung Punch - Delivers a strong punch just above the victim's abdomen, constraining the lungs. The victim will be unable to breathe for a short time."
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "lungpunch"

/datum/action/lung_punch/Trigger()
	if(owner.incapacitated())
		to_chat(owner, span_warning("You can't use [name] while you're incapacitated."))
		return
	var/mob/living/carbon/human/H = owner
	if (H.mind.martial_art.streak == "quick_choke")
		owner.visible_message(span_danger("[owner] assumes a neutral stance."), "<b><i>Your next attack is cleared.</i></b>")
		H.mind.martial_art.streak = ""
	else
		if(HAS_TRAIT(H, TRAIT_PACIFISM))
			to_chat(H, span_warning("You don't want to harm other people!"))
			return
		owner.visible_message(span_danger("[owner] assumes the Lung Punch stance!"), "<b><i>Your next attack will be a Lung Punch.</i></b>")
		H.mind.martial_art.streak = "quick_choke"//internal name for lung punch

/datum/martial_art/krav_maga/teach(mob/living/carbon/human/H,make_temporary=0)
	if(..())
		to_chat(H, "<span class = 'userdanger'>You know the arts of [name]!</span>")
		to_chat(H, "<span class = 'danger'>Place your cursor over a move at the top of the screen to see what it does.</span>")
		neckchop.Grant(H)
		legsweep.Grant(H)
		lungpunch.Grant(H)

/datum/martial_art/krav_maga/on_remove(mob/living/carbon/human/H)
	to_chat(H, "<span class = 'userdanger'>You suddenly forget the arts of [name]...</span>")
	neckchop.Remove(H)
	legsweep.Remove(H)
	lungpunch.Remove(H)

/datum/martial_art/krav_maga/proc/check_streak(mob/living/carbon/human/A, mob/living/carbon/human/D)
	switch(streak)
		if("neck_chop")
			streak = ""
			neck_chop(A,D)
			return TRUE
		if("leg_sweep")
			streak = ""
			leg_sweep(A,D)
			return TRUE
		if("quick_choke")//is actually lung punch
			streak = ""
			quick_choke(A,D)
			return TRUE
	return FALSE

/datum/martial_art/krav_maga/proc/leg_sweep(mob/living/carbon/human/A, mob/living/carbon/human/D)
	var/obj/item/bodypart/affecting = D.get_bodypart(BODY_ZONE_CHEST)
	var/armor_block = D.run_armor_check(affecting, "melee")
	var/damage = (damage_roll(A,D)*2 + 25)
	if(!CHECK_MOBILITY(D, MOBILITY_STAND))
		return FALSE
	D.visible_message(span_warning("[A] leg sweeps [D]!"), \
						span_userdanger("[A] leg sweeps you!"))
	playsound(get_turf(A), 'sound/effects/hit_kick.ogg', 50, 1, -1)
	D.apply_damage(damage, STAMINA, affecting, armor_block)
	D.DefaultCombatKnockdown(80, override_hardstun = 1, override_stamdmg = 0)
	log_combat(A, D, "leg sweeped")
	return TRUE

/datum/martial_art/krav_maga/proc/quick_choke(mob/living/carbon/human/A, mob/living/carbon/human/D)//is actually lung punch
	var/damage = damage_roll(A,D)
	D.visible_message(span_warning("[A] pounds [D] on the chest!"), \
					span_userdanger("[A] slams your chest! You can't breathe!"))
	playsound(get_turf(A), 'sound/effects/hit_punch.ogg', 50, 1, -1)
	if(D.losebreath <= 10)
		D.losebreath = clamp(D.losebreath + 5, 0, 10)
	D.adjustOxyLoss(damage + 5)
	log_combat(A, D, "quickchoked")
	return TRUE

/datum/martial_art/krav_maga/proc/neck_chop(mob/living/carbon/human/A, mob/living/carbon/human/D)
	var/damage = (damage_roll(A,D)*0.5)
	D.visible_message(span_warning("[A] karate chops [D]'s neck!"), \
					span_userdanger("[A] karate chops your neck, rendering you unable to speak!"))
	playsound(get_turf(A), 'sound/effects/hit_punch.ogg', 50, 1, -1)
	D.apply_damage(damage, BRUTE)
	if(D.silent <= 10)
		D.silent = clamp(D.silent + 10, 0, 10)
	log_combat(A, D, "neck chopped")
	return TRUE

/datum/martial_art/krav_maga/grab_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(check_streak(A,D))
		return TRUE
	log_combat(A, D, "grabbed (Krav Maga)")
	..()

/datum/martial_art/krav_maga/harm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	var/obj/item/bodypart/affecting = D.get_bodypart(ran_zone(A.zone_selected))
	var/armor_block = D.run_armor_check(affecting, "melee")
	if(check_streak(A,D))
		return TRUE
	log_combat(A, D, "punched")
	var/picked_hit_type = pick("punches", "kicks")
	var/bonus_damage = damage_roll(A,D)
	if(!CHECK_MOBILITY(D, MOBILITY_STAND))
		bonus_damage += 10
		picked_hit_type = "stomps on"
	D.apply_damage(bonus_damage, BRUTE, affecting, armor_block)
	if(picked_hit_type == "kicks" || picked_hit_type == "stomps on")
		A.do_attack_animation(D, ATTACK_EFFECT_KICK)
		playsound(get_turf(D), 'sound/effects/hit_kick.ogg', 50, 1, -1)
	else
		A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)
		playsound(get_turf(D), 'sound/effects/hit_punch.ogg', 50, 1, -1)
	D.visible_message(span_danger("[A] [picked_hit_type] [D]!"), \
					  span_userdanger("[A] [picked_hit_type] you!"))
	log_combat(A, D, "[picked_hit_type] with [name]")
	return TRUE

/datum/martial_art/krav_maga/disarm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(check_streak(A,D))
		return TRUE
	var/obj/item/bodypart/affecting = D.get_bodypart(ran_zone(A.zone_selected))
	var/armor_block = D.run_armor_check(affecting, "melee")
	var/damage = damage_roll(A,D)
	var/stunthreshold = A.dna.species.punchstunthreshold
	if(CHECK_MOBILITY(D, MOBILITY_STAND))
		D.visible_message(span_danger("[A] reprimands [D]!"), \
					span_userdanger("You're slapped by [A]!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, A)
		to_chat(A, span_danger("You jab [D]!"))
		A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)
		playsound(D, 'sound/effects/hit_punch.ogg', 50, TRUE, -1)
		D.apply_damage(damage*2 + 15, STAMINA, affecting, armor_block)
		log_combat(A, D, "punched nonlethally")
	else
		D.visible_message(span_danger("[A] reprimands [D]!"), \
					span_userdanger("You're manhandled by [A]!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, A)
		to_chat(A, span_danger("You stomp [D]!"))
		A.do_attack_animation(D, ATTACK_EFFECT_KICK)
		playsound(D, 'sound/effects/hit_punch.ogg', 50, TRUE, -1)
		D.apply_damage(damage*2 + 20, STAMINA, affecting, armor_block)
		log_combat(A, D, "stomped nonlethally")
	if(damage >= stunthreshold)
		D.visible_message(span_warning("[D] sputters and recoils in pain!"), span_userdanger("You recoil in pain as you are jabbed in a nerve!"))
		D.drop_all_held_items()

	return TRUE

//Krav Maga Gloves

/obj/item/clothing/gloves/krav_maga
	var/datum/martial_art/krav_maga/style = new

/obj/item/clothing/gloves/krav_maga/equipped(mob/user, slot)
	. = ..()
	if(ishuman(user) && slot == SLOT_GLOVES)
		var/mob/living/carbon/human/H = user
		style.teach(H,1)

/obj/item/clothing/gloves/krav_maga/dropped(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.get_item_by_slot(SLOT_GLOVES) == src)
		style.remove(H)

/obj/item/clothing/gloves/krav_maga/sec//more obviously named, given to sec
	name = "krav maga gloves"
	desc = "These gloves can teach you to perform Krav Maga using nanochips."
	icon_state = "fightgloves"
	inhand_icon_state = "fightgloves"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE

/obj/item/clothing/gloves/krav_maga/combatglovesplus
	name = "combat gloves plus"
	desc = "These tactical gloves are fireproof and shock resistant, and using nanochip technology it teaches you the powers of krav maga."
	icon_state = "fightglovesblack"
	inhand_icon_state = "fightglovesblack"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	strip_delay = 80
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	armor = ARMOR_VALUE_LIGHT
