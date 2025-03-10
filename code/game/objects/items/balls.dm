/*		BALLS - GLORIOUS BALLS
//
//	Includes:-
//		1) Tennis balls, lines 10 - 92
//
//
//
*/

/obj/item/toy/tennis
	name = "tennis ball"
	desc = "A classical tennis ball. It appears to have faint bite marks scattered all over its surface."
	icon = 'modular_citadel/icons/obj/balls.dmi'
	icon_state = "tennis_classic"
	lefthand_file = 'modular_citadel/icons/mob/inhands/balls_left.dmi'
	righthand_file = 'modular_citadel/icons/mob/inhands/balls_right.dmi'
	inhand_icon_state = "tennis_classic"
	mob_overlay_icon = 'modular_citadel/icons/mob/mouthball.dmi'
	slot_flags = INV_SLOTBIT_HEAD | INV_SLOTBIT_NECK | INV_SLOTBIT_EARS	//Fluff item, put it wherever you want!
	throw_range = 14
	w_class = WEIGHT_CLASS_SMALL

/obj/item/toy/tennis/alt_pre_attack(atom/A, mob/living/user, params)	//checks if it can do right click memes
	altafterattack(A, user, TRUE, params)
	return TRUE

/obj/item/toy/tennis/altafterattack(atom/target, mob/living/carbon/user, proximity_flag, click_parameters)	//does right click memes
	if(istype(user))
		user.visible_message(span_notice("[user] waggles [src] at [target]."), span_notice("You waggle [src] at [target]."))
	return TRUE

///Special throw_impact for hats to frisbee hats at people to place them on their heads.
/obj/item/toy/tennis/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	. = ..()
	///if the thrown object's target zone isn't the head
	if(thrownthing.target_zone != BODY_ZONE_HEAD)
		return
	if(!iscarbon(hit_atom))
		return
	var/mob/living/carbon/H = hit_atom
	if(H.equip_to_slot_if_possible(src, SLOT_HEAD, FALSE, TRUE))
		H.visible_message(span_notice("[src] lands neatly on [H]'s head!"), span_notice("[src] lands perfectly onto your head!"))
	else if(H.equip_to_slot_if_possible(src, SLOT_NECK, FALSE, TRUE))
		H.visible_message(span_notice("[src] lands neatly on [H]'s neck!"), span_notice("[src] lands perfectly onto your neck!"))
	else if(H.equip_to_slot_if_possible(src, SLOT_EARS, FALSE, TRUE))
		H.visible_message(span_notice("[src] lands neatly on [H]'s ears!"), span_notice("[src] lands perfectly onto your ears!"))
	else if(prob(1))
		H.visible_message(span_alert("[src] bounces off of [H]'s maldspot!"), span_alert("[src] bounces off of your maldspot!"))
	else
		H.visible_message(span_alert("[src] bounces off of [H]'s forehead!"), span_alert("[src] bounces off of your forehead!"))
	return // I miss the days of else if chains


/obj/item/toy/tennis/rainbow
	name = "pseudo-euclidean interdimensional tennis sphere"
	desc = "A tennis ball from another plane of existance. Really groovy."
	icon_state = "tennis_rainbow"
	inhand_icon_state = "tennis_rainbow"
	actions_types = list(/datum/action/item_action/squeeze)		//Giving the masses easy access to unilimted honks would be annoying

/obj/item/toy/tennis/rainbow/izzy	//izzyinbox's donator item
	name = "Katlin's Ball"
	desc = "A tennis ball that's seen a good bit of love, being covered in a few black and white hairs and slobber."
	icon_state = "tennis_izzy"
	inhand_icon_state = "tennis_izzy"

/obj/item/toy/tennis/red	//da red wuns go fasta
	name = "red tennis ball"
	desc = "A red tennis ball. It goes three times faster!"
	icon_state = "tennis_red"
	inhand_icon_state = "tennis_red"
	throw_speed = 9

/obj/item/toy/tennis/yellow	//because yellow is hot I guess
	name = "yellow tennis ball"
	desc = "A yellow tennis ball. It seems to have a flame-retardant coating."
	icon_state = "tennis_yellow"
	inhand_icon_state = "tennis_yellow"
	resistance_flags = FIRE_PROOF

/obj/item/toy/tennis/green	//pestilence
	name = "green tennis ball"
	desc = "A green tennis ball. It seems to have an impermeable coating."
	icon_state = "tennis_green"
	inhand_icon_state = "tennis_green"
	permeability_coefficient = 0.9

/obj/item/toy/tennis/cyan	//electric
	name = "cyan tennis ball"
	desc = "A cyan tennis ball. It seems to have odd electrical properties."
	icon_state = "tennis_cyan"
	inhand_icon_state = "tennis_cyan"
	siemens_coefficient = 0.9

/obj/item/toy/tennis/blue	//reliability
	name = "blue tennis ball"
	desc = "A blue tennis ball. It seems ever so slightly more robust than normal."
	icon_state = "tennis_blue"
	inhand_icon_state = "tennis_blue"
	max_integrity = 300

/obj/item/toy/tennis/purple	//because purple dyes have high pH and would neutralize acids I guess
	name = "purple tennis ball"
	desc = "A purple tennis ball. It seems to have an acid-resistant coating."
	icon_state = "tennis_purple"
	inhand_icon_state = "tennis_purple"
	resistance_flags = ACID_PROOF

/datum/action/item_action/squeeze
	name = "Squeak!"
