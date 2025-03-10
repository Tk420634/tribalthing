
#define BEE_IDLE_ROAMING		70 //The value of idle at which a bee in a beebox will try to wander
#define BEE_IDLE_GOHOME			0  //The value of idle at which a bee will try to go home
#define BEE_PROB_GOHOME			35 //Probability to go home when idle is below BEE_IDLE_GOHOME
#define BEE_PROB_GOROAM			5 //Probability to go roaming when idle is above BEE_IDLE_ROAMING
#define BEE_TRAY_RECENT_VISIT	200	//How long in deciseconds until a tray can be visited by a bee again
#define BEE_DEFAULT_COLOUR		"#e5e500" //the colour we make the stripes of the bee if our reagent has no colour (or we have no reagent)

#define BEE_POLLINATE_YIELD_CHANCE		33
#define BEE_POLLINATE_PEST_CHANCE		33
#define BEE_POLLINATE_POTENCY_CHANCE	50

/mob/living/simple_animal/hostile/poison/bees
	name = "radbee"
	desc = "Buzzy buzzy radbee, stingy sti- oh FUCK, I'm vomiting blood!"
	icon_state = ""
	icon_living = ""
	icon = 'icons/mob/bees.dmi'
	gender = FEMALE
	speak_emote = list("buzzes")
	emote_hear = list("buzzes")
	turns_per_move = 0
	melee_damage_lower = 1
	melee_damage_upper = 1
	attack_verb_continuous = "stings"
	attack_verb_simple = "sting"
	response_help_continuous = "shoos"
	response_help_simple = "shoo"
	response_disarm_continuous = "swats away"
	response_disarm_simple = "swat away"
	response_harm_continuous = "squashes"
	response_harm_simple = "squash"
	maxHealth = 10
	health = 10
	spacewalk = TRUE
	faction = list("hostile", "bees-friend")
	dodge_prob = 0
	move_to_delay = 0
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	mouse_opacity = MOUSE_OPACITY_OPAQUE
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	density = FALSE
	mob_size = MOB_SIZE_TINY
	mob_biotypes = MOB_ORGANIC|MOB_BUG
	movement_type = FLYING
	gold_core_spawnable = HOSTILE_SPAWN
	search_objects = 1 //have to find those plant trays!
	ignore_other_mobs = TRUE // we fight
	override_ignore_other_mobs = TRUE

	//Spaceborn beings don't get hurt by space
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	//minbodytemp = 0
	del_on_death = 1

	var/datum/reagent/beegent = null //hehe, beegent
	var/obj/structure/beebox/beehome = null
	var/idle = 0
	var/isqueen = FALSE
	var/icon_base = "bee"
	var/static/beehometypecache = typecacheof(/obj/structure/beebox)
	var/static/hydroponicstypecache = typecacheof(/obj/machinery/hydroponics)

/mob/living/simple_animal/hostile/poison/bees/Initialize()
	. = ..()
	generate_bee_visuals()
	AddComponent(/datum/component/swarming)

/mob/living/simple_animal/hostile/poison/bees/Destroy()
	move_out()
	beegent = null
	return ..()


/mob/living/simple_animal/hostile/poison/bees/death(gibbed)
	move_out()
	beegent = null
	..()


/mob/living/simple_animal/hostile/poison/bees/examine(mob/user)
	. = ..()
	if(!beehome)
		. += span_warning("This bee is homeless!")

/mob/living/simple_animal/hostile/poison/bees/proc/generate_bee_visuals()
	cut_overlays()

	var/col = BEE_DEFAULT_COLOUR
	if(beegent && beegent.color)
		col = beegent.color

	add_overlay("[icon_base]_base")

	var/static/mutable_appearance/greyscale_overlay
	greyscale_overlay = greyscale_overlay || mutable_appearance('icons/mob/bees.dmi')
	greyscale_overlay.icon_state = "[icon_base]_grey"
	greyscale_overlay.color = col
	add_overlay(greyscale_overlay)

	add_overlay("[icon_base]_wings")


//We don't attack beekeepers/people dressed as bees//Todo: bee costume
/mob/living/simple_animal/hostile/poison/bees/CanAttack(atom/the_target)
	. = ..()
	if(!.)
		return FALSE
	if(isliving(the_target))
		var/mob/living/H = the_target
		return !H.bee_friendly()


/mob/living/simple_animal/hostile/poison/bees/Found(atom/A)
	if(isliving(A))
		var/mob/living/H = A
		return !H.bee_friendly()
	if(istype(A, /obj/machinery/hydroponics))
		var/obj/machinery/hydroponics/Hydro = A
		if(Hydro.myseed && !Hydro.dead && !Hydro.recent_bee_visit)
			wanted_objects |= hydroponicstypecache //so we only hunt them while they're alive/seeded/not visisted
			return TRUE
	return FALSE


/mob/living/simple_animal/hostile/poison/bees/AttackingTarget()
	//Pollinate
	var/atom/my_target = get_target()
	if(istype(my_target, /obj/machinery/hydroponics))
		var/obj/machinery/hydroponics/Hydro = my_target
		pollinate(Hydro)
	else if(istype(my_target, /obj/structure/beebox))
		if(my_target == beehome)
			var/obj/structure/beebox/BB = my_target
			forceMove(BB)
			toggle_ai(AI_IDLE)
			LoseTarget()
			wanted_objects -= beehometypecache //so we don't attack beeboxes when not going home
		return //no don't attack the goddamm box
	else
		. = ..()
		if(. && beegent && isliving(my_target))
			var/mob/living/L = my_target
			if(L.reagents)
				beegent.reaction_mob(L, INJECT)
				L.reagents.add_reagent(beegent.type, rand(1,5))


/mob/living/simple_animal/hostile/poison/bees/proc/assign_reagent(datum/reagent/R)
	if(istype(R))
		beegent = R
		name = "[initial(name)] ([R.name])"
		generate_bee_visuals()


/mob/living/simple_animal/hostile/poison/bees/proc/pollinate(obj/machinery/hydroponics/Hydro)
	if(!istype(Hydro) || !Hydro.myseed || Hydro.dead || Hydro.recent_bee_visit)
		LoseTarget()
		return

	LoseTarget() //so we pick a new hydro tray next FindTarget(), instead of loving the same plant for eternity
	wanted_objects -= hydroponicstypecache //so we only hunt them while they're alive/seeded/not visisted
	Hydro.recent_bee_visit = TRUE
	spawn(BEE_TRAY_RECENT_VISIT)
		if(Hydro)
			Hydro.recent_bee_visit = FALSE

	var/growth = health //Health also means how many bees are in the swarm, roughly.
	//better healtheir plants!
	Hydro.adjustHealth(growth*0.5)
	if(prob(BEE_POLLINATE_PEST_CHANCE))
		Hydro.adjustPests(-10)
	if(prob(BEE_POLLINATE_YIELD_CHANCE))
		Hydro.myseed.adjust_yield(1)
		Hydro.yieldmod = 2
	if(prob(BEE_POLLINATE_POTENCY_CHANCE))
		Hydro.myseed.adjust_potency(1)

	if(beehome)
		beehome.bee_resources = min(beehome.bee_resources + growth, 100)


/mob/living/simple_animal/hostile/poison/bees/handle_automated_action()
	. = ..()
	if(!.)
		return

	if(!isqueen)
		if(loc == beehome)
			idle = min(100, ++idle)
			if(idle >= BEE_IDLE_ROAMING && prob(BEE_PROB_GOROAM))
				toggle_ai(AI_ON)
				forceMove(beehome.drop_location())
		else
			idle = max(0, --idle)
			if(idle <= BEE_IDLE_GOHOME && prob(BEE_PROB_GOHOME))
				if(!FindTarget())
					wanted_objects |= beehometypecache //so we don't attack beeboxes when not going home
					GiveTarget(beehome)
	if(!beehome) //add outselves to a beebox (of the same reagent) if we have no home
		for(var/obj/structure/beebox/BB in view(vision_range, src))
			if(reagent_incompatible(BB.queen_bee) || BB.bees.len >= BB.get_max_bees())
				continue
			move_in(BB)
			break // End loop after the first compatible find.

/mob/living/simple_animal/hostile/poison/bees/proc/move_in(obj/structure/beebox/BB)
	if(!BB)
		return
	beehome = BB
	BB.bees |= src
	RegisterSignal(BB, COMSIG_PARENT_QDELETING,PROC_REF(move_out))

/mob/living/simple_animal/hostile/poison/bees/proc/move_out()
	if(!beehome)
		return
	beehome.bees -= src
	beehome = null
	UnregisterSignal(src, COMSIG_PARENT_QDELETING)

/mob/living/simple_animal/hostile/poison/bees/toxin/Initialize()
	. = ..()
	var/datum/reagent/R = pick(typesof(/datum/reagent/toxin))
	assign_reagent(GLOB.chemical_reagents_list[R])

/mob/living/simple_animal/hostile/poison/bees/queen
	name = "queen radbee"
	desc = "She's the queen of radbees, BZZ BZZ!"
	icon_base = "queen"
	isqueen = TRUE

/mob/living/simple_animal/hostile/poison/bees/queen/Destroy()
	if (beehome && beehome.queen_bee == src)
		beehome.queen_bee = null
	return ..()

//the Queen doesn't leave the box on her own, and she CERTAINLY doesn't pollinate by herself
/mob/living/simple_animal/hostile/poison/bees/queen/Found(atom/A)
	return FALSE


//leave pollination for the peasent bees
/mob/living/simple_animal/hostile/poison/bees/queen/AttackingTarget()
	. = ..()
	var/atom/my_target = get_target()
	if(!. || !beegent || !isliving(my_target))
		return
	var/mob/living/L = my_target
	beegent.reaction_mob(L, TOUCH)
	L.reagents.add_reagent(beegent.type, rand(1,5))


//PEASENT BEES
/mob/living/simple_animal/hostile/poison/bees/queen/pollinate()
	return


/mob/living/simple_animal/hostile/poison/bees/proc/reagent_incompatible(mob/living/simple_animal/hostile/poison/bees/B)
	if(!B)
		return FALSE
	if(B.beegent && beegent && B.beegent.type != beegent.type || B.beegent && !beegent || !B.beegent && beegent)
		return TRUE
	return FALSE


/obj/item/queen_bee
	name = "queen radbee"
	desc = "She's the queen of radbees, BZZ BZZ!"
	icon_state = "queen_item"
	inhand_icon_state = ""
	icon = 'icons/mob/bees.dmi'
	var/mob/living/simple_animal/hostile/poison/bees/queen/queen


/obj/item/queen_bee/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers/syringe))
		var/obj/item/reagent_containers/syringe/S = I
		var/jelly_amount = S.reagents.get_reagent_amount(/datum/reagent/royal_bee_jelly)
		if(jelly_amount)
			if(jelly_amount >= 5)
				S.reagents.remove_reagent(/datum/reagent/royal_bee_jelly, 5)
				var/obj/item/queen_bee/qb = new(user.drop_location())
				qb.queen = new(qb)
				if(queen && queen.beegent)
					qb.queen.assign_reagent(queen.beegent) //Bees use the global singleton instances of reagents, so we don't need to worry about one bee being deleted and her copies losing their reagents.
				user.put_in_active_hand(qb)
				user.visible_message(span_notice("[user] injects [src] with royal bee jelly, causing it to split into two bees, MORE BEES!"),"<span class ='warning'>You inject [src] with royal bee jelly, causing it to split into two bees, MORE BEES!</span>")
			else
				to_chat(user, span_warning("You don't have enough royal bee jelly to split a bee in two!"))
		else
			var/datum/reagent/R = GLOB.chemical_reagents_list[S.reagents.get_master_reagent_id()]
			if(R && S.reagents.has_reagent(R.type, 5))
				S.reagents.remove_reagent(R.type,5)
				if(R.can_synth)
					queen.assign_reagent(R)
					user.visible_message(span_warning("[user] injects [src]'s genome with [R.name], mutating it's DNA!"),span_warning("You inject [src]'s genome with [R.name], mutating it's DNA!"))
					name = queen.name
				else
					user.visible_message(span_warning("[user] injects [src]'s genome with [R.name]... but nothing happens."),span_warning("You inject [src]'s genome with [R.name]... but nothing happens."))
			else
				to_chat(user, span_warning("You don't have enough units of that chemical to modify the bee's DNA!"))
	..()


/obj/item/queen_bee/bought/Initialize()
	. = ..()
	queen = new(src)


/obj/item/queen_bee/Destroy()
	QDEL_NULL(queen)
	return ..()

/mob/living/simple_animal/hostile/poison/bees/consider_wakeup()
	if (beehome && loc == beehome) // If bees are chilling in their nest, they're not actively looking for targets
		idle = min(100, ++idle)
		if(idle >= BEE_IDLE_ROAMING && prob(BEE_PROB_GOROAM))
			toggle_ai(AI_ON)
			forceMove(beehome.drop_location())
	else
		..()

/mob/living/simple_animal/hostile/poison/bees/short
	desc = "These bees seem unstable and won't survive for long."

/mob/living/simple_animal/hostile/poison/bees/short/Initialize()
	. = ..()
	addtimer(CALLBACK(src,PROC_REF(death)), 50 SECONDS)

/mob/living/simple_animal/hostile/poison/bees/short/frenly //these bees need to be frenly or they'd murder everyone
	faction = list("neutral")
	melee_damage_lower = 1 //they'll be fighting simplemobs, so they need to be robeest
	melee_damage_upper = 10
