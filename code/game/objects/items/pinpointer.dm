//Pinpointers are used to track atoms from a distance as long as they're on the same z-level. The captain and nuke ops have ones that track the nuclear authentication disk.
/obj/item/pinpointer
	name = "pinpointer"
	desc = "A handheld tracking device that locks onto certain signals."
	icon = 'icons/obj/device.dmi'
	icon_state = "pinpointer"
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT
	w_class = WEIGHT_CLASS_SMALL
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron = 500, /datum/material/glass = 250)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/active = FALSE
	var/atom/movable/target //The thing we're searching for
	var/minimum_range = 0 //at what range the pinpointer declares you to be at your destination
	var/ignore_suit_sensor_level = FALSE // Do we find people even if their suit sensors are turned off
	var/alert = FALSE // TRUE to display things more seriously

/obj/item/pinpointer/Initialize()
	. = ..()
	GLOB.pinpointer_list += src

/obj/item/pinpointer/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	GLOB.pinpointer_list -= src
	target = null
	return ..()

/obj/item/pinpointer/attack_self(mob/living/user)
	active = !active
	user.visible_message(span_notice("[user] [active ? "" : "de"]activates [user.p_their()] pinpointer."), span_notice("You [active ? "" : "de"]activate your pinpointer."))
	playsound(src, 'sound/items/screwdriver2.ogg', 50, 1)
	if(active)
		START_PROCESSING(SSfastprocess, src)
	else
		target = null
		STOP_PROCESSING(SSfastprocess, src)
	update_icon()

/obj/item/pinpointer/process()
	if(!active)
		return PROCESS_KILL
	scan_for_target()
	update_icon()

/obj/item/pinpointer/proc/scan_for_target()
	return

/obj/item/pinpointer/update_overlays()
	. = ..()
	if(!active)
		return
	if(!target)
		. += "pinon[alert ? "alert" : ""]null"
		return
	var/turf/here = get_turf(src)
	var/turf/there = get_turf(target)
	if(!here || !there || here.z != there.z)
		. += "pinon[alert ? "alert" : ""]null"
		return
	if(GET_DIST_EUCLIDEAN(here,there) <= minimum_range)
		. += "pinon[alert ? "alert" : ""]direct"
	else
		setDir(get_dir(here, there))
		switch(get_dist(here, there))
			if(1 to 8)
				. += "pinon[alert ? "alert" : "close"]"
			if(9 to 16)
				. += "pinon[alert ? "alert" : "medium"]"
			if(16 to INFINITY)
				. += "pinon[alert ? "alert" : "far"]"

/obj/item/pinpointer/crew // A replacement for the old crew monitoring consoles
	name = "crew pinpointer"
	desc = "A handheld tracking device that points to crew suit sensors."
	icon_state = "pinpointer_crew"
	custom_price = PRICE_ABOVE_EXPENSIVE
	var/has_owner = FALSE
	var/pinpointer_owner = null

/obj/item/pinpointer/crew/proc/trackable(mob/living/carbon/human/H)
	var/turf/here = get_turf(src)
	if(H && (H.z == 0 || H.z == here.z) && istype(H.w_uniform, /obj/item/clothing/under))
		var/obj/item/clothing/under/U = H.w_uniform

		// Suit sensors must be on maximum.
		if(!U.has_sensor || U.sensor_mode < SENSOR_COORDS && !ignore_suit_sensor_level)
			return FALSE

		var/turf/there = get_turf(H)
		return (H.z != 0 || (there && there.z == here.z))

	return FALSE

/obj/item/pinpointer/crew/attack_self(mob/living/user)
	if(active)
		active = FALSE
		user.visible_message(span_notice("[user] deactivates [user.p_their()] pinpointer."), span_notice("You deactivate your pinpointer."))
		playsound(src, 'sound/items/screwdriver2.ogg', 50, 1)
		target = null //Restarting the pinpointer forces a target reset
		STOP_PROCESSING(SSfastprocess, src)
		update_icon()
		return
	if (has_owner && !pinpointer_owner)
		pinpointer_owner = user
	if (pinpointer_owner && pinpointer_owner != user)
		to_chat(user, span_notice("The pinpointer doesn't respond. It seems to only recognise its owner."))
		return
	var/list/name_counts = list()
	var/list/names = list()

	for(var/mob/living/carbon/human/H in GLOB.carbon_list)
		if(!trackable(H))
			continue

		var/crewmember_name = "Unknown"
		if(H.wear_id)
			var/obj/item/card/id/I = H.wear_id.GetID()
			if(I && I.registered_name)
				crewmember_name = I.registered_name

		while(crewmember_name in name_counts)
			name_counts[crewmember_name]++
			crewmember_name = text("[] ([])", crewmember_name, name_counts[crewmember_name])
		names[crewmember_name] = H
		name_counts[crewmember_name] = 1

	if(!names.len)
		user.visible_message(span_notice("[user]'s pinpointer fails to detect a signal."), span_notice("Your pinpointer fails to detect a signal."))
		return

	var/A = input(user, "Person to track", "Pinpoint") in names
	if(!A || QDELETED(src) || !user || !user.is_holding(src) || user.incapacitated())
		return

	target = names[A]
	active = TRUE
	user.visible_message(span_notice("[user] activates [user.p_their()] pinpointer."), span_notice("You activate your pinpointer."))
	playsound(src, 'sound/items/screwdriver2.ogg', 50, 1)
	START_PROCESSING(SSfastprocess, src)
	update_icon()

/obj/item/pinpointer/crew/scan_for_target()
	if(target)
		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			if(!trackable(H))
				target = null
	if(!target) //target can be set to null from above code, or elsewhere
		active = FALSE

/obj/item/pinpointer/pair
	name = "pair pinpointer"
	desc = "A handheld tracking device that locks onto its other half of the matching pair."
	var/other_pair

/obj/item/pinpointer/pair/Destroy()
	other_pair = null
	. = ..()

/obj/item/pinpointer/pair/scan_for_target()
	target = other_pair

/obj/item/pinpointer/pair/examine(mob/user)
	. = ..()
	if(!active || !target)
		return
	var/mob/mob_holder = get(target, /mob)
	if(istype(mob_holder))
		to_chat(user, "Its pair is being held by [mob_holder].")
		return

/obj/item/storage/box/pinpointer_pairs
	name = "pinpointer pair box"

/obj/item/storage/box/pinpointer_pairs/PopulateContents()
	var/obj/item/pinpointer/pair/A = new(src)
	var/obj/item/pinpointer/pair/B = new(src)

	A.other_pair = B
	B.other_pair = A

/obj/item/pinpointer/shuttle
	name = "fugitive pinpointer"
	desc = "A handheld tracking device that locates the bounty hunter shuttle for quick escapes."
	icon_state = "pinpointer_hunter"
	var/obj/shuttleport

/obj/item/pinpointer/shuttle/Initialize(mapload)
	. = ..()
	shuttleport = SSshuttle.getShuttle("huntership")

/obj/item/pinpointer/shuttle/scan_for_target()
	target = shuttleport

/obj/item/pinpointer/shuttle/Destroy()
	shuttleport = null
	. = ..()
