//Space bears!
/mob/living/simple_animal/hostile/bear
	name = "space bear"
	desc = "You don't need to be faster than a space bear, you just need to outrun your crewmates."
	icon_state = "bear"
	icon_living = "bear"
	icon_dead = "bear_dead"
	icon_gib = "bear_gib"
	mob_armor = ARMOR_VALUE_BEAR
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	//speak = list("RAWR!","Rawr!","GRR!","Growl!")
	speak_emote = list("growls", "roars")
	emote_hear = list("rawrs.","grumbles.","grawls.")
	emote_taunt = list("stares ferociously", "stomps")
	speak_chance = 1
	taunt_chance = 25
	turns_per_move = 5
	see_in_dark = 6
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/bear = 5, /obj/item/clothing/head/bearpelt = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	maxHealth = 60
	health = 60
	spacewalk = TRUE
	var/armored = FALSE
	bounty = 30

	obj_damage = 60
	melee_damage_lower = 15 // i know it's like half what it used to be, but bears cause bleeding like crazy now so it works out
	melee_damage_upper = 15
	wound_bonus = -5
	bare_wound_bonus = 10 // BEAR wound bonus am i right
	sharpness = SHARP_EDGED
	attack_verb_continuous = "claws"
	attack_verb_simple = "claw"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	friendly_verb_continuous = "bear hugs"
	friendly_verb_simple = "bear hug"

	//Space bears aren't affected by cold.
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	//minbodytemp = 0
	//maxbodytemp = 1500

	faction = list("russian")
	gold_core_spawnable = HOSTILE_SPAWN

	footstep_type = FOOTSTEP_MOB_CLAW

//SPACE BEARS! SQUEEEEEEEE~     OW! FUCK! IT BIT MY HAND OFF!!
/mob/living/simple_animal/hostile/bear/Hudson
	name = "Hudson"
	gender = MALE
	desc = "Feared outlaw, this guy is one bad news bear." //I'm sorry...

/mob/living/simple_animal/hostile/bear/snow
	name = "space polar bear"
	icon_state = "snowbear"
	icon_living = "snowbear"
	icon_dead = "snowbear_dead"
	desc = "It's a polar bear, in space, but not actually in space."
	weather_immunities = list("snow")

/mob/living/simple_animal/hostile/bear/russian
	name = "combat bear"
	desc = "A ferocious brown bear decked out in armor plating, a red star with yellow outlining details the shoulder plating."
	icon_state = "combatbear"
	icon_living = "combatbear"
	icon_dead = "combatbear_dead"
	mob_armor = ARMOR_VALUE_BEAR_ARMOR
	faction = list("russian")
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/bear = 5, /obj/item/clothing/head/bearpelt = 1, /obj/item/bear_armor = 1)
	melee_damage_lower = 18
	melee_damage_upper = 20
	wound_bonus = 0
	health = 120
	maxHealth = 120
	armored = TRUE

/mob/living/simple_animal/hostile/bear/update_icons()
	..()
	if(armored)
		add_overlay("armor_bear")

/obj/item/bear_armor
	name = "pile of bear armor"
	desc = "A scattered pile of various shaped armor pieces fitted for a bear, some duct tape, and a nail filer. Crude instructions \
		are written on the back of one of the plates in russian. This seems like an awful idea."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "bear_armor_upgrade"

/obj/item/bear_armor/afterattack(atom/target, mob/user, proximity_flag)
	. = ..()
	if(istype(target, /mob/living/simple_animal/hostile/bear) && proximity_flag)
		var/mob/living/simple_animal/hostile/bear/A = target
		if(A.armored)
			to_chat(user, span_warning("[A] has already been armored up!"))
			return
		A.armored = TRUE
		A.maxHealth += 60
		A.health += 60
		A.armour_penetration += 0.4
		A.melee_damage_lower += 3
		A.melee_damage_upper += 5
		A.wound_bonus += 5
		A.update_icons()
		to_chat(user, span_info("You strap the armor plating to [A] and sharpen [A.p_their()] claws with the nail filer. This was a great idea."))
		qdel(src)

/mob/living/simple_animal/hostile/bear/butter //The mighty companion to Cak. Several functions used from it.
	name = "Terrygold"
	icon_state = "brownbear"
	icon_living = "brownbear"
	icon_dead = "brownbear_dead"
	desc = "I can't believe its not a bear!"
	faction = list("neutral", "russian")
	obj_damage = 11
	melee_damage_lower = 1
	melee_damage_upper = 1
	response_harm_continuous = "takes a bite out of"
	response_harm_simple = "take a bite out of"
	attacked_sound = 'sound/items/eatfood.ogg'
	deathmessage = "loses its false life and collapses!"
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/butter = 6, /obj/item/reagent_containers/food/snacks/meat/slab = 3, /obj/item/organ/brain = 1, /obj/item/organ/heart = 1)
	attack_sound = 'sound/weapons/slap.ogg'
	attack_verb_continuous = "slaps"
	attack_verb_simple = "slap"

/mob/living/simple_animal/hostile/bear/butter/BiologicalLife(seconds, times_fired) //Heals butter bear really fast when he takes damage.
	if(stat)
		return
	if(health < maxHealth)
		heal_overall_damage(10) //Fast life regen, makes it hard for you to get eaten to death.

/mob/living/simple_animal/hostile/bear/butter/on_attack_hand(mob/living/L) //Borrowed code from Cak, feeds people if they hit you. More nutriment but less vitamin to represent BUTTER.
	..()
	if(L.a_intent == INTENT_HARM && L.reagents && !stat)
		L.reagents.add_reagent(/datum/reagent/consumable/nutriment, 1)
		L.reagents.add_reagent(/datum/reagent/consumable/nutriment/vitamin, 0.1)

/mob/living/simple_animal/hostile/bear/butter/CheckParts(list/parts) //Borrowed code from Cak, allows the brain used to actually control the bear.
	..()
	var/obj/item/organ/brain/B = locate(/obj/item/organ/brain) in contents
	if(!B || !B.brainmob || !B.brainmob.mind)
		return
	B.brainmob.mind.transfer_to(src)
	to_chat(src, "<span class='big bold'>You are a butter bear!</span><b> You're a mostly harmless bear/butter hybrid that everyone loves. People can take bites out of you if they're hungry, but you regenerate health \
	so quickly that it generally doesn't matter. You're remarkably resilient to any damage besides this and it's hard for you to really die at all. You should go around and bring happiness and \
	free butter to the station!</b>")
	var/new_name = stripped_input(src, "Enter your name, or press \"Cancel\" to stick with Terrygold.", "Name Change")
	if(new_name)
		to_chat(src, span_notice("Your name is now <b>\"new_name\"</b>!"))
		name = new_name

/mob/living/simple_animal/hostile/bear/butter/AttackingTarget() //Makes some attacks by the butter bear slip those who dare cross its path.
	var/atom/my_target = get_target()
	if(!isliving(my_target))
		return
	var/mob/living/L = my_target
	if(!(L.mobility_flags & MOBILITY_STAND))
		return
	L.Knockdown(20)
	playsound(loc, 'sound/misc/slip.ogg', 15)
	L.visible_message(span_danger("[L] slips on butter!"))

/mob/living/simple_animal/hostile/bear/yaoguai
	name = "yao guai"
	desc = "A mutated American black bear, sporting razor sharp teeth, claws, and a nasty temper."
	icon = 'icons/fallout/mobs/animals/yaoguai.dmi'
	icon_state = "yaoguai"
	icon_living = "yaoguai"
	icon_dead = "yaoguai_dead"
	maxHealth = 300
	health = 300
	melee_damage_lower = 45 //Don't fuck with these, they're god damn BEARS
	melee_damage_upper = 45
	wound_bonus = 5
	bare_wound_bonus = 25
	faction = list("yaoguai")

/mob/living/simple_animal/hostile/bear/yaoguai/Initialize()
	. = ..()
	recenter_wide_sprite()

/*mob/living/simple_animal/hostile/bear/yaoguai/frozen
	name = "frozen yao guai"
	desc = "A mutated American black bear, sporting razor sharp teeth, claws, and a nasty temper. This one seems to have acclimatized to a harsh, snowy environment."
	icon_state = "polar_yao_guai"
	icon_living = "polar_yao_guai"
	icon_dead = "polar_yao_guai_dead"*/


















