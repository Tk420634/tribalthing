/obj/item/ammo_casing/caseless/foam_dart
	name = "foam dart"
	desc = "It's nerf or nothing! Ages 8 and up."
	projectile_type = /obj/item/projectile/bullet/reusable/foam_dart
	caliber = CALIBER_FOAM
	icon = 'icons/obj/guns/toy.dmi'
	icon_state = "foamdart"
	custom_materials = list(/datum/material/iron = 11.25)
	harmful = FALSE
	var/modified = FALSE
	sound_properties = CSP_DART

/obj/item/ammo_casing/caseless/foam_dart/update_icon_state()
	if (modified)
		icon_state = "foamdart_empty"
		desc = "It's nerf or nothing! ... Although, this one doesn't look too safe."
		if(BB)
			BB.icon_state = "foamdart_empty"
	else
		icon_state = initial(icon_state)
		desc = "It's nerf or nothing! Ages 8 and up."
		if(BB)
			BB.icon_state = initial(BB.icon_state)


/obj/item/ammo_casing/caseless/foam_dart/attackby(obj/item/A, mob/user, params)
	var/obj/item/projectile/bullet/reusable/foam_dart/FD = BB
	if (istype(A, /obj/item/screwdriver) && !modified)
		modified = TRUE
		FD.modified = TRUE
		FD.damage_type = BRUTE
		to_chat(user, span_notice("You pop the safety cap off [src]."))
		update_icon()
	else if (istype(A, /obj/item/pen))
		if(modified)
			if(!FD.pen)
				harmful = TRUE
				if(!user.transferItemToLoc(A, FD))
					return
				FD.pen = A
				FD.damage = 5
				FD.nodamage = FALSE
				to_chat(user, span_notice("You insert [A] into [src]."))
			else
				to_chat(user, span_warning("There's already something in [src]."))
		else
			to_chat(user, span_warning("The safety cap prevents you from inserting [A] into [src]."))
	else
		return ..()

/obj/item/ammo_casing/caseless/foam_dart/attack_self(mob/living/user)
	var/obj/item/projectile/bullet/reusable/foam_dart/FD = BB
	if(FD.pen)
		FD.damage = initial(FD.damage)
		// FD.nodamage = initial(FD.nodamage)
		user.put_in_hands(FD.pen)
		to_chat(user, span_notice("You remove [FD.pen] from [src]."))
		FD.pen = null

/obj/item/ammo_casing/caseless/foam_dart/riot
	name = "riot foam dart"
	desc = "Whose smart idea was it to use toys as crowd control? Ages 18 and up."
	projectile_type = /obj/item/projectile/bullet/reusable/foam_dart/riot
	icon_state = "foamdart_riot"
	custom_materials = list(/datum/material/iron = 1125)
	berryable = TRUE

/obj/item/ammo_casing/caseless/foam_dart/mag
	name = "magfoam dart"
	desc = "A foam dart with fun light-up projectiles powered by magnets!"
	projectile_type = /obj/item/projectile/bullet/reusable/foam_dart/mag
