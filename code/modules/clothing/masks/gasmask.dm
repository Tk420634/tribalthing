/obj/item/clothing/mask/gas
	name = "gas mask"
	desc = "A face-covering mask that can be connected to an air supply. While good for concealing your identity, it isn't good for blocking gas flow." //More accurate
	icon_state = "gas_alt"
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | ALLOWINTERNALS
	flags_inv = HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	w_class = WEIGHT_CLASS_NORMAL
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)
	inhand_icon_state = "gas_alt"
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	flags_cover = MASKCOVERSEYES | MASKCOVERSMOUTH
	resistance_flags = NONE
	mutantrace_variation = STYLE_MUZZLE

/obj/item/clothing/mask/gas/enclave
	name = "gas mask mk 2"
	desc = "An advanced gas mask with efficient cleanable filters and flash protected lenses."
	icon_state = "gasmask_enclave"
	inhand_icon_state = "gasmask_enclave"
	flash_protect = 2

/obj/item/clothing/mask/gas/glass
	name = "glass gas mask"
	desc = "A face-covering mask that can be connected to an air supply. This one doesn't obscure your face however." //More accurate
	icon_state = "gas_clear"
	flags_inv = HIDEEYES


// **** Welding gas mask ****

/obj/item/clothing/mask/gas/welding
	name = "welding mask"
	desc = "A gas mask with built-in welding goggles and a face shield. Looks like a skull - clearly designed by a nerd."
	icon_state = "weldingmask"
	custom_materials = list(/datum/material/iron=4000, /datum/material/glass=2000)
	flash_protect = 2
	tint = 2
	actions_types = list(/datum/action/item_action/toggle)
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE
	flags_cover = MASKCOVERSEYES
	visor_flags_inv = HIDEEYES
	visor_flags_cover = MASKCOVERSEYES
	resistance_flags = FIRE_PROOF

/obj/item/clothing/mask/gas/welding/attack_self(mob/user)
	weldingvisortoggle(user)

/obj/item/clothing/mask/gas/welding/up

/obj/item/clothing/mask/gas/welding/up/Initialize()
	. = ..()
	visor_toggling()


// ********************************************************************

//Plague Dr suit can be found in clothing/suits/bio.dm
/obj/item/clothing/mask/gas/plaguedoctor
	name = "plague doctor mask"
	desc = "A modernised version of the classic design, this mask will not only filter out toxins but it can also be connected to an air supply."
	icon_state = "plaguedoctor"
	inhand_icon_state = "gas_mask"

/obj/item/clothing/mask/gas/clown_hat
	name = "clown wig and mask"
	desc = "A true prankster's facial attire. A clown is incomplete without his wig and mask."
	clothing_flags = ALLOWINTERNALS
	icon_state = "clown"
	inhand_icon_state = "clown_hat"
	dye_color = "clown"
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE
	actions_types = list(/datum/action/item_action/adjust)
	dog_fashion = /datum/dog_fashion/head/clown
	var/list/clownmask_designs = list()

/obj/item/clothing/mask/gas/clown_hat/Initialize(mapload)
	.=..()
	clownmask_designs = list(
		"True Form" = image(icon = src.icon, icon_state = "clown"),
		"The Feminist" = image(icon = src.icon, icon_state = "sexyclown"),
		"The Jester" = image(icon = src.icon, icon_state = "chaos"),
		"The Madman" = image(icon = src.icon, icon_state = "joker"),
		"The Rainbow Color" = image(icon = src.icon, icon_state = "rainbow")
		)

/obj/item/clothing/mask/gas/clown_hat/ui_action_click(mob/user)
	if(!istype(user) || user.incapacitated(allow_crit = TRUE))
		return

	var/static/list/options = list("True Form" = "clown", "The Feminist" = "sexyclown", "The Madman" = "joker",
								"The Rainbow Color" ="rainbow", "The Jester" = "chaos")

	var/choice = show_radial_menu(user,src, clownmask_designs, custom_check = FALSE, radius = 36, require_near = TRUE)

	if(src && choice && !user.incapacitated(allow_crit = TRUE) && in_range(user,src))
		icon_state = options[choice]
		user.update_inv_wear_mask()
		for(var/X in actions)
			var/datum/action/A = X
			A.UpdateButtonIcon()
		to_chat(user, span_notice("Your Clown Mask has now morphed into [choice], all praise the Honkmother!"))
		return TRUE

/obj/item/clothing/mask/gas/sexyclown
	name = "sexy-clown wig and mask"
	desc = "A feminine clown mask for the dabbling crossdressers or female entertainers."
	clothing_flags = ALLOWINTERNALS
	icon_state = "sexyclown"
	inhand_icon_state = "sexyclown"
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE

/obj/item/clothing/mask/gas/mime
	name = "mime mask"
	desc = "The traditional mime's mask. It has an eerie facial posture."
	clothing_flags = ALLOWINTERNALS
	icon_state = "mime"
	inhand_icon_state = "mime"
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE
	actions_types = list(/datum/action/item_action/adjust)
	var/list/mimemask_designs = list()

/obj/item/clothing/mask/gas/mime/Initialize(mapload)
	.=..()
	mimemask_designs = list(
		"Blanc" = image(icon = src.icon, icon_state = "mime"),
		"Excité" = image(icon = src.icon, icon_state = "sexymime"),
		"Triste" = image(icon = src.icon, icon_state = "sadmime"),
		"Effrayé" = image(icon = src.icon, icon_state = "scaredmime")
		)

/obj/item/clothing/mask/gas/mime/ui_action_click(mob/user)
	if(!istype(user) || user.incapacitated(allow_crit = TRUE))
		return

	var/static/list/options = list("Blanc" = "mime", "Triste" = "sadmime", "Effrayé" = "scaredmime", "Excité" ="sexymime")

	var/choice = show_radial_menu(user,src, mimemask_designs, custom_check = FALSE, radius = 36, require_near = TRUE)

	if(src && choice && !user.incapacitated(allow_crit = TRUE) && in_range(user,src))
		icon_state = options[choice]
		user.update_inv_wear_mask()
		for(var/X in actions)
			var/datum/action/A = X
			A.UpdateButtonIcon()
		to_chat(user, span_notice("Your Mime Mask has now morphed into [choice]!"))
		return TRUE

/obj/item/clothing/mask/gas/syndicate
	name = "syndicate mask"
	desc = "A close-fitting tactical mask that can be connected to an air supply."
	icon_state = "syndicate"
	strip_delay = 60

/obj/item/clothing/mask/gas/monkeymask
	name = "monkey mask"
	desc = "A mask used when acting as a monkey."
	clothing_flags = ALLOWINTERNALS
	icon_state = "monkeymask"
	inhand_icon_state = "monkeymask"
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE

/obj/item/clothing/mask/gas/sexymime
	name = "sexy mime mask"
	desc = "A traditional female mime's mask."
	clothing_flags = ALLOWINTERNALS
	icon_state = "sexymime"
	inhand_icon_state = "sexymime"
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE

/obj/item/clothing/mask/gas/death_commando
	name = "Death Commando Mask"
	icon_state = "death_commando_mask"
	inhand_icon_state = "death_commando_mask"

/obj/item/clothing/mask/gas/cyborg
	name = "cyborg visor"
	desc = "Beep boop."
	icon_state = "death"
	resistance_flags = FLAMMABLE

/obj/item/clothing/mask/gas/owl_mask
	name = "owl mask"
	desc = "Twoooo!"
	icon_state = "owl"
	clothing_flags = ALLOWINTERNALS
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE

/obj/item/clothing/mask/gas/carp
	name = "carp mask"
	desc = "Gnash gnash."
	icon_state = "carp_mask"

/obj/item/clothing/mask/gas/tiki_mask
	name = "tiki mask"
	desc = "A creepy wooden mask. Surprisingly expressive for a poorly carved bit of wood."
	icon_state = "tiki_eyebrow"
	inhand_icon_state = "tiki_eyebrow"
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT * 1.25)
	resistance_flags = FLAMMABLE
	max_integrity = 100
	clothing_flags = null
	actions_types = list(/datum/action/item_action/adjust)
	dog_fashion = null
	var/list/tikimask_designs = list()

/obj/item/clothing/mask/gas/tiki_mask/Initialize(mapload)
	.=..()
	tikimask_designs = list(
		"Original Tiki" = image(icon = src.icon, icon_state = "tiki_eyebrow"),
		"Happy Tiki" = image(icon = src.icon, icon_state = "tiki_happy"),
		"Confused Tiki" = image(icon = src.icon, icon_state = "tiki_confused"),
		"Angry Tiki" = image(icon = src.icon, icon_state = "tiki_angry")
		)

/obj/item/clothing/mask/gas/tiki_mask/ui_action_click(mob/user)

	var/mob/M = usr
	var/static/list/options = list("Original Tiki" = "tiki_eyebrow", "Happy Tiki" = "tiki_happy", "Confused Tiki" = "tiki_confused",
							"Angry Tiki" = "tiki_angry")

	var/choice = show_radial_menu(user,src, tikimask_designs, custom_check = FALSE, radius = 36, require_near = TRUE)

	if(src && choice && !M.stat && in_range(M,src))
		icon_state = options[choice]
		user.update_inv_wear_mask()
		for(var/X in actions)
			var/datum/action/A = X
			A.UpdateButtonIcon()
		to_chat(M, "The Tiki Mask has now changed into the [choice] Mask!")
		return TRUE

/obj/item/clothing/mask/gas/tiki_mask/yalp_elor
	icon_state = "tiki_yalp"
	inhand_icon_state = "tiki_yalp"
	actions_types = list()

/obj/item/clothing/mask/gas/hunter
	name = "bounty hunting mask"
	desc = "A custom tactical mask with decals added."
	icon_state = "hunter"
	inhand_icon_state = "hunter"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	flags_inv = HIDEFACIALHAIR|HIDEFACE|HIDEEYES|HIDEEARS|HIDEHAIR

/obj/item/clothing/mask/gas/ranger
	name = "ranger gas mask"
	desc = "A close-fitting tactical mask issued to all NCR Rangers."
	icon_state = "rangermask"
	inhand_icon_state = "rangermask"
	flags_inv = HIDEFACIALHAIR|HIDEFACE|HIDEEYES|HIDEEARS|HIDEHAIR
	visor_flags_inv = 0
