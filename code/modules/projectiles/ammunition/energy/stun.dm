/obj/item/ammo_casing/energy/electrode
	projectile_type = /obj/item/projectile/energy/electrode
	select_name = "stun"
	fire_sound = 'sound/weapons/taser.ogg'
	e_cost = 2000
	harmful = FALSE

/obj/item/ammo_casing/energy/electrode/security
	projectile_type = /obj/item/projectile/energy/electrode/security
	e_cost = 100

/obj/item/ammo_casing/energy/electrode/spec
	e_cost = 100

/obj/item/ammo_casing/energy/electrode/gun
	fire_sound = 'sound/weapons/gunshot.ogg'
	e_cost = 100


/obj/item/ammo_casing/energy/electrode/old
	e_cost = 1000

/obj/item/ammo_casing/energy/disabler
	projectile_type = /obj/item/projectile/beam/disabler
	select_name  = "disable"
	e_cost = 7000
	fire_sound = 'sound/weapons/taser2.ogg'
	harmful = FALSE
	click_cooldown_override = 3.5

/obj/item/ammo_casing/energy/disabler/debug
	projectile_type = /obj/item/projectile/beam/disabler/debug
	e_cost = 1

/obj/item/ammo_casing/energy/disabler/secborg
	e_cost = 50
