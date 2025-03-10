/obj/item/gun/energy/taser
	name = "taser gun"
	desc = "A low-capacity, energy-based stun gun used by security teams to subdue targets at range."
	icon_state = "taser"
	inhand_icon_state = null	//so the human update icon uses the icon_state instead.
	cell_type = /obj/item/stock_parts/cell/ammo/ecp
	ammo_type = list(/obj/item/ammo_casing/energy/electrode)
	ammo_x_offset = 3
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/tesla_revolver
	name = "tesla gun"
	desc = "An experimental gun based on an experimental engine, it's about as likely to kill its operator as it is the target."
	icon_state = "tesla"
	inhand_icon_state = "tesla"
	ammo_type = list(/obj/item/ammo_casing/energy/tesla_revolver)
	can_flashlight = 0
	pin = null
	shaded_charge = 1
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/e_gun/advtaser
	name = "disabler"
	desc = "The long arm of the Murrines."
	icon_state = "advtaser"
	ammo_type = list(/obj/item/ammo_casing/energy/disabler)
	ammo_x_offset = 2
	// Not enough guns have altfire systems like this yet for this to be a universal framework.
	var/last_altfire = 0
	var/altfire_delay = CLICK_CD_RANGE
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/e_gun/advtaser/altafterattack(atom/target, mob/user, proximity_flag, params)
	. = TRUE
	if(last_altfire + altfire_delay > world.time)
		return
	var/current_index = current_firemode_index
	set_firemode_to_type(/obj/item/ammo_casing/energy/electrode)
	process_afterattack(target, user, proximity_flag, params)
	set_firemode_index(current_index)
	last_altfire = world.time

/obj/item/gun/energy/e_gun/advtaser/cyborg
	name = "cyborg taser"
	desc = "An integrated hybrid taser that draws directly from a cyborg's power cell. The one contains a limiter to prevent the cyborg's power cell from overheating."
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "taser"
	can_flashlight = FALSE
	can_charge = FALSE
	selfcharge = EGUN_SELFCHARGE_BORG
	cell_type = /obj/item/stock_parts/cell/secborg
	charge_delay = 5
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/e_gun/advtaser/cyborg/mean
	desc = "An integrated hybrid taser that draws directly from a cyborg's power cell."
	use_cyborg_cell = TRUE
	selfcharge = EGUN_NO_SELFCHARGE



/obj/item/gun/energy/disabler/debug
	name = "debug disabler"
	icon = 'icons/fallout/objects/guns/energy.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "wattz1000"
	inhand_icon_state = "laser-pistol"
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/debug)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/disabler/cyborg
	name = "cyborg disabler"
	desc = "An integrated disabler that draws from a cyborg's power cell. This one contains a limiter to prevent the cyborg's power cell from overheating."
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "taser"
	can_charge = FALSE
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/secborg)
	selfcharge = EGUN_SELFCHARGE_BORG
	cell_type = /obj/item/stock_parts/cell/secborg
	charge_delay = 5
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/disabler/cyborg/mean
	desc = "An integrated disabler that draws from a cyborg's power cell."
	use_cyborg_cell = TRUE
	selfcharge = EGUN_NO_SELFCHARGE
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
