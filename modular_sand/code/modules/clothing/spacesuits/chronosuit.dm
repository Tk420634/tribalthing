/obj/item/clothing/head/helmet/space/chronos //Gandalf was here!
	name = "Chronosuit Helmet"
	desc = "A white helmet with an opaque blue visor."
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/head.dmi'
	anthro_mob_worn_overlay = 'modular_sand/icons/mob/clothing/head_muzzled.dmi'
	icon_state = "chronohelmet"
	inhand_icon_state = "chronohelmet"
	slowdown = 0
	armor = list("melee" = 60, "bullet" = 60, "laser" = 60, "energy" = 60, "bomb" = 30, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	var/obj/item/clothing/suit/space/chronos/suit = null

/obj/item/clothing/head/helmet/space/chronos/dropped(mob/user)
	if(suit)
		suit.deactivate(1, 1)
	..()

/obj/item/clothing/head/helmet/space/chronos/helmet/Destroy()
	suit = null
	return ..()

/obj/item/clothing/suit/space/chronos
	name = "Chronosuit"
	desc = "An advanced spacesuit equipped with time-bluespace teleportation and anti-compression technology."
	mob_overlay_icon = 'modular_sand/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_sand/icons/mob/clothing/suit_digi.dmi'
	icon_state = "chronosuit"
	inhand_icon_state = "chronosuit"
	actions_types = list(/datum/action/item_action/toggle)
	armor = list("melee" = 60, "bullet" = 60, "laser" = 60, "energy" = 60, "bomb" = 30, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 1000)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	mutantrace_variation = STYLE_DIGITIGRADE
	slowdown = 0
	var/list/chronosafe_items = list(/obj/item/chrono_eraser, /obj/item/gun/energy/chrono_gun)
	var/obj/item/clothing/head/helmet/space/chronos/helmet = null
	var/obj/effect/chronos_cam/camera = null
	var/datum/action/innate/chrono_teleport/teleport_now = new
	var/activating = 0
	var/activated = 0
	var/cooldowntime = 50 //deciseconds
	var/teleporting = 0
	var/phase_timer_id

/obj/item/clothing/suit/space/chronos/New()
	..()
	teleport_now.chronosuit = src
	teleport_now.target = src

/obj/item/clothing/suit/space/chronos/Destroy()
	teleport_now.chronosuit = null
	teleport_now.target = null
	QDEL_NULL(teleport_now)
	helmet = null
	return ..()

/obj/item/clothing/suit/space/chronos/proc/new_camera(mob/user)
	if(camera)
		qdel(camera)
	camera = new /obj/effect/chronos_cam(user)
	camera.holder = user
	camera.chronosuit = src
	user.remote_control = camera

/obj/item/clothing/suit/space/chronos/ui_action_click()
	if((cooldown <= world.time) && !teleporting && !activating)
		if(!activated)
			activate()
		else
			deactivate()

/obj/item/clothing/suit/space/chronos/dropped(mob/user)
	if(activated)
		deactivate()
	..()

/obj/item/clothing/suit/space/chronos/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	var/mob/living/carbon/human/user = src.loc
	switch(severity)
		if(1)
			if(activated && user && ishuman(user) && (user.wear_suit == src))
				to_chat(user, span_danger("E:FATAL:RAM_READ_FAIL\nE:FATAL:STACK_EMPTY\nE:FATAL:READ_NULL_POINT\nE:FATAL:PWR_BUS_OVERLOAD"))
				to_chat(user, span_userdanger("An electromagnetic pulse disrupts your [name] and violently tears you out of time-bluespace!"))
				user.emote("scream")
			deactivate(1, 1)

/obj/item/clothing/suit/space/chronos/proc/finish_chronowalk(mob/living/carbon/human/user, turf/to_turf)
	if(!user)
		user = src.loc
	if(phase_timer_id)
		deltimer(phase_timer_id)
		phase_timer_id = 0
	if(istype(user))
		if(to_turf)
			user.forceMove(to_turf)
		user.SetStun(0)
		user.next_action = 1
		user.alpha = 255
		user.update_atom_colour()
		user.animate_movement = FORWARD_STEPS
		user.mob_transforming = 0
		user.anchored = FALSE
		teleporting = 0
		for(var/obj/item/I in user.held_items)
			REMOVE_TRAIT(I, TRAIT_NODROP, CHRONOSUIT_TRAIT)
		if(camera)
			camera.remove_target_ui()
			camera.forceMove(user)
		teleport_now.UpdateButtonIcon()

/obj/item/clothing/suit/space/chronos/proc/chronowalk(atom/location)
	var/mob/living/carbon/human/user = src.loc
	if(activated && !teleporting && user && istype(user) && location && user.loc && location.loc && user.wear_suit == src && user.stat == CONSCIOUS)
		teleporting = 1
		var/turf/from_turf = get_turf(user)
		var/turf/to_turf = get_turf(location)
		var/distance = cheap_hypotenuse(from_turf.x, from_turf.y, to_turf.x, to_turf.y)
		var/phase_in_ds = distance*2

		if(camera)
			camera.remove_target_ui()

		teleport_now.UpdateButtonIcon()

		user.ExtinguishMob()

		for(var/obj/item/I in user.held_items)
			ADD_TRAIT(I, TRAIT_NODROP, CHRONOSUIT_TRAIT)
		user.animate_movement = NO_STEPS
		user.DelayNextAction(8 + phase_in_ds)
		user.mob_transforming = 1
		user.anchored = TRUE
		user.Stun(INFINITY)

		animate(user, color = "#00ccee", time = 3)
		phase_timer_id = addtimer(CALLBACK(src,PROC_REF(phase_2), user, to_turf, phase_in_ds), 3, TIMER_STOPPABLE)

/obj/item/clothing/suit/space/chronos/proc/phase_2(mob/living/carbon/human/user, turf/to_turf, phase_in_ds)
	if(teleporting && activated && user)
		animate(user, alpha = 0, time = 2)
		phase_timer_id = addtimer(CALLBACK(src,PROC_REF(phase_3), user, to_turf, phase_in_ds), 2, TIMER_STOPPABLE)
	else
		finish_chronowalk(user, to_turf)

/obj/item/clothing/suit/space/chronos/proc/phase_3(mob/living/carbon/human/user, turf/to_turf, phase_in_ds)
	if(teleporting && activated && user)
		user.forceMove(to_turf)
		animate(user, alpha = 255, time = phase_in_ds)
		phase_timer_id = addtimer(CALLBACK(src,PROC_REF(phase_4), user, to_turf), phase_in_ds, TIMER_STOPPABLE)
	else
		finish_chronowalk(user, to_turf)

/obj/item/clothing/suit/space/chronos/proc/phase_4(mob/living/carbon/human/user, turf/to_turf)
	if(teleporting && activated && user)
		animate(user, color = "#ffffff", time = 3)
		phase_timer_id = addtimer(CALLBACK(src,PROC_REF(finish_chronowalk), user, to_turf), 3, TIMER_STOPPABLE)
	else
		finish_chronowalk(user, to_turf)

/obj/item/clothing/suit/space/chronos/process()
	if(activated)
		var/mob/living/carbon/human/user = src.loc
		if(user && ishuman(user) && (user.wear_suit == src))
			if(camera && (user.remote_control == camera))
				if(!teleporting)
					if(camera.loc != user && ((camera.x != user.x) || (camera.y != user.y) || (camera.z != user.z)))
						if(camera.phase_time <= world.time)
							chronowalk(camera)
					else
						camera.remove_target_ui()
			else
				new_camera(user)
	else
		STOP_PROCESSING(SSobj, src)

/obj/item/clothing/suit/space/chronos/proc/activate()
	if(!activating && !activated && !teleporting)
		activating = 1
		var/mob/living/carbon/human/user = src.loc
		if(user && ishuman(user) && user.wear_suit == src)
			to_chat(user, "\nChronosuitMK4 login: root")
			to_chat(user, "Password:\n")
			to_chat(user, "root@ChronosuitMK4# chronowalk4 --start\n")
			if(user.head && istype(user.head, /obj/item/clothing/head/helmet/space/chronos))
				to_chat(user, "\[ <span style='color: #00ff00;'>ok</span> \] Mounting /dev/helm")
				helmet = user.head
				ADD_TRAIT(helmet, TRAIT_NODROP, CHRONOSUIT_TRAIT)
				helmet.suit = src
				ADD_TRAIT(src, TRAIT_NODROP, CHRONOSUIT_TRAIT)
				to_chat(user, "\[ <span style='color: #00ff00;'>ok</span> \] Starting brainwave scanner")
				to_chat(user, "\[ <span style='color: #00ff00;'>ok</span> \] Starting ui display driver")
				to_chat(user, "\[ <span style='color: #00ff00;'>ok</span> \] Initializing chronowalk4-view")
				new_camera(user)
				START_PROCESSING(SSobj, src)
				activated = 1
			else
				to_chat(user, "\[ <span style='color: #ff0000;'>fail</span> \] Mounting /dev/helm")
				to_chat(user, "<span style='color: #ff0000;'><b>FATAL: </b>Unable to locate /dev/helm. <b>Aborting...</b></span>")
			teleport_now.Grant(user)
		cooldown = world.time + cooldowntime
		activating = 0

/obj/item/clothing/suit/space/chronos/proc/deactivate(force = 0, silent = FALSE)
	if(activated && (!teleporting || force))
		activating = 1
		var/mob/living/carbon/human/user = src.loc
		var/hard_landing = teleporting && force
		REMOVE_TRAIT(src, TRAIT_NODROP, CHRONOSUIT_TRAIT)
		cooldown = world.time + cooldowntime * 1.5
		activated = 0
		activating = 0
		finish_chronowalk()
		if(user && ishuman(user))
			teleport_now.Remove(user)
			if(user.wear_suit == src)
				if(hard_landing)
					user.electrocute_act(35, src, flags = SHOCK_NOGLOVES)
					user.DefaultCombatKnockdown(200)
				if(!silent)
					to_chat(user, "\nroot@ChronosuitMK4# chronowalk4 --stop\n")
					if(camera)
						to_chat(user, "\[ <span style='color: #ff5500;'>ok</span> \] Sending TERM signal to chronowalk4-view")
					if(helmet)
						to_chat(user, "\[ <span style='color: #ff5500;'>ok</span> \] Stopping ui display driver")
						to_chat(user, "\[ <span style='color: #ff5500;'>ok</span> \] Stopping brainwave scanner")
						to_chat(user, "\[ <span style='color: #ff5500;'>ok</span> \] Unmounting /dev/helmet")
					to_chat(user, "logout")
		if(helmet)
			REMOVE_TRAIT(helmet, TRAIT_NODROP, CHRONOSUIT_TRAIT)
			helmet.suit = null
			helmet = null
		if(camera)
			qdel(camera)

/obj/effect/chronos_cam
	name = "Chronosuit View"
	density = FALSE
	anchored = TRUE
	invisibility = INVISIBILITY_ABSTRACT
	opacity = 0
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/mob/holder = null
	var/phase_time = 0
	var/phase_time_length = 3
	var/atom/movable/screen/chronos_target/target_ui = null
	var/obj/item/clothing/suit/space/chronos/chronosuit

/obj/effect/chronos_cam/singularity_act()
	return

/obj/effect/chronos_cam/singularity_pull()
	return

/obj/effect/chronos_cam/proc/create_target_ui()
	if(holder && holder.client && chronosuit)
		if(target_ui)
			remove_target_ui()
		target_ui = new(null, holder)
		holder.client.screen += target_ui

/obj/effect/chronos_cam/proc/remove_target_ui()
	if(target_ui)
		qdel(target_ui)
		target_ui = null

/obj/effect/chronos_cam/relaymove(var/mob/user, direction)
	if(!holder)
		qdel(src)
		return
	if(user == holder)
		if(loc == user)
			forceMove(get_turf(user))
		if(user.client && user.client.eye != src)
			src.forceMove(user.drop_location())
			user.reset_perspective(src)
			user.set_machine(src)
		var/atom/step = get_step(src, direction)
		if(step)
			if((step.x <= TRANSITIONEDGE) || (step.x >= (world.maxx - TRANSITIONEDGE - 1)) || (step.y <= TRANSITIONEDGE) || (step.y >= (world.maxy - TRANSITIONEDGE - 1)))
				if(!src.Move(step))
					src.forceMove(step)
			else
				src.forceMove(step)
			if((x == holder.x) && (y == holder.y) && (z == holder.z))
				remove_target_ui()
				forceMove(user)
			else if(!target_ui)
				create_target_ui()
			phase_time = world.time + phase_time_length

/obj/effect/chronos_cam/check_eye(mob/user)
	if(user != holder)
		user.unset_machine()

/obj/effect/chronos_cam/on_unset_machine(mob/user)
	user.reset_perspective(null)

/obj/effect/chronos_cam/Destroy()
	if(holder)
		if(holder.remote_control == src)
			holder.remote_control = null
		if(holder.client && (holder.client.eye == src))
			holder.unset_machine()
	return ..()

/atom/movable/screen/chronos_target
	name = "target display"
	screen_loc = "CENTER,CENTER"
	color = "#ff3311"
	blend_mode = BLEND_SUBTRACT

/atom/movable/screen/chronos_target/New(loc, var/mob/living/carbon/human/user)
	if(user)
		var/icon/user_icon = getFlatIcon(user)
		icon = user_icon
		transform = user.transform
	else
		qdel(src)

/datum/action/innate/chrono_teleport
	name = "Teleport Now"
	icon_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "chrono_phase"
	check_flags = AB_CHECK_CONSCIOUS //|AB_CHECK_INSIDE
	var/obj/item/clothing/suit/space/chronos/chronosuit = null

/datum/action/innate/chrono_teleport/IsAvailable(silent = FALSE)
	return (chronosuit && chronosuit.activated && chronosuit.camera && !chronosuit.teleporting)

/datum/action/innate/chrono_teleport/Activate()
	if(IsAvailable())
		if(chronosuit.camera)
			chronosuit.chronowalk(chronosuit.camera)
