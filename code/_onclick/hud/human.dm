/atom/movable/screen/human
	icon = 'icons/fallout/UI/screen_fallout2.dmi'

/atom/movable/screen/human/toggle
	name = "toggle"
	icon_state = "toggle"

/atom/movable/screen/human/toggle/Click()

	var/mob/targetmob = usr

	if(isobserver(usr))
		if(ishuman(usr.client.eye) && (usr.client.eye != usr))
			var/mob/M = usr.client.eye
			targetmob = M

	if(usr.hud_used.inventory_shown && targetmob.hud_used)
		usr.hud_used.inventory_shown = FALSE
		usr.client.screen -= targetmob.hud_used.toggleable_inventory
	else
		usr.hud_used.inventory_shown = TRUE
		usr.client.screen += targetmob.hud_used.toggleable_inventory

	targetmob.hud_used.hidden_inventory_update(usr)

/atom/movable/screen/human/equip
	name = "equip"
	icon_state = "act_equip"

/atom/movable/screen/human/equip/Click()
	if(ismecha(usr.loc)) // stops inventory actions in a mech
		return 1
	var/mob/living/carbon/human/H = usr
	H.quick_equip()

/atom/movable/screen/devil
	invisibility = INVISIBILITY_ABSTRACT

/atom/movable/screen/devil/soul_counter
	icon = 'icons/mob/screen_gen.dmi'
	name = "souls owned"
	icon_state = "Devil-6"
	screen_loc = ui_devilsouldisplay

/atom/movable/screen/devil/soul_counter/proc/update_counter(souls = 0)
	invisibility = 0
	maptext = "<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#FF0000'>[souls]</font></div>"
	switch(souls)
		if(0,null)
			icon_state = "Devil-1"
		if(1,2)
			icon_state = "Devil-2"
		if(3 to 5)
			icon_state = "Devil-3"
		if(6 to 8)
			icon_state = "Devil-4"
		if(9 to INFINITY)
			icon_state = "Devil-5"
		else
			icon_state = "Devil-6"

/atom/movable/screen/devil/soul_counter/proc/clear()
	invisibility = INVISIBILITY_ABSTRACT

/atom/movable/screen/ling
	invisibility = INVISIBILITY_ABSTRACT

/atom/movable/screen/ling/sting
	name = "current sting"
	screen_loc = ui_lingstingdisplay

/atom/movable/screen/ling/sting/Click()
	if(isobserver(usr))
		return
	var/mob/living/carbon/U = usr
	U.unset_sting()

/atom/movable/screen/ling/chems
	name = "chemical storage"
	icon_state = "power_display"
	screen_loc = ui_lingchemdisplay

/datum/hud/human/New(mob/living/carbon/human/owner)
	..()
	owner.overlay_fullscreen("see_through_darkness", /atom/movable/screen/fullscreen/see_through_darkness)

	var/widescreenlayout = FALSE //CIT CHANGE - adds support for different hud layouts depending on widescreen pref
	if(owner.client && owner.client.prefs && owner.client.prefs.widescreenpref) //CIT CHANGE - ditto
		widescreenlayout = TRUE // CIT CHANGE - ditto

	var/atom/movable/screen/using
	var/atom/movable/screen/inventory/inv_box

	// using = new/atom/movable/screen/language_menu
	// using.icon = ui_style
	// if(!widescreenlayout) // CIT CHANGE
	// 	using.screen_loc = ui_boxlang // CIT CHANGE
	// using.hud = src
	// static_inventory += using

	using = new /atom/movable/screen/area_creator
	using.icon = ui_style
	if(!widescreenlayout) // CIT CHANGE
		using.screen_loc = ui_boxarea // CIT CHANGE
	using.hud = src
	static_inventory += using

	action_intent = new /atom/movable/screen/act_intent/segmented
	action_intent.icon_state = mymob.a_intent
	action_intent.hud = src
	static_inventory += action_intent

	using = new /atom/movable/screen/mov_intent
	using.icon = tg_ui_icon_to_cit_ui(ui_style) // CIT CHANGE - overrides mov intent icon
	using.icon_state = (mymob.m_intent == MOVE_INTENT_RUN ? "running" : "walking")
	using.screen_loc = ui_movi
	using.hud = src
	static_inventory += using

	//CITADEL CHANGES - sprint button
	using = new /atom/movable/screen/sprintbutton
	using.icon = tg_ui_icon_to_cit_ui(ui_style)
	using.icon_state = ((owner.combat_flags & COMBAT_FLAG_SPRINT_ACTIVE) ? "act_sprint_on" : "act_sprint")
	using.screen_loc = ui_movi
	using.hud = src
	static_inventory += using
	//END OF CITADEL CHANGES

	//same as above but buffer.
	sprint_buffer = new /atom/movable/screen/sprint_buffer
	sprint_buffer.screen_loc = ui_sprintbufferloc
	sprint_buffer.hud = src
	static_inventory += sprint_buffer

	// clickdelay
	clickdelay = new
	clickdelay.hud = src
	clickdelay.screen_loc = ui_clickdelay
	static_inventory += clickdelay

	// wield
	wield_button = new /atom/movable/screen/wield
	wield_button.screen_loc = ui_wield
	wield_button.hud = src
	static_inventory += wield_button

	// resistdelay
	resistdelay = new
	resistdelay.hud = src
	resistdelay.screen_loc = ui_resistdelay
	static_inventory += resistdelay

	using = new /atom/movable/screen/drop()
	using.icon = ui_style
	using.screen_loc = ui_drop_throw
	using.hud = src
	static_inventory += using

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "clothing"
	inv_box.icon = ui_style
	inv_box.slot_id = SLOT_W_UNIFORM
	inv_box.icon_state = "uniform"
	inv_box.screen_loc = ui_iclothing
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "armor"
	inv_box.icon = ui_style
	inv_box.slot_id = SLOT_WEAR_SUIT
	inv_box.icon_state = "suit"
	inv_box.screen_loc = ui_oclothing
	toggleable_inventory += inv_box

	build_hand_slots()

	using = new /atom/movable/screen/swap_hand()
	using.icon = ui_style
	using.icon_state = "swap_1"
	using.screen_loc = ui_swaphand_position(owner,1)
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/swap_hand()
	using.icon = ui_style
	using.icon_state = "swap_2"
	using.screen_loc = ui_swaphand_position(owner,2)
	using.hud = src
	static_inventory += using

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "ID"
	inv_box.icon = ui_style
	inv_box.icon_state = "id"
	inv_box.screen_loc = ui_id
	inv_box.slot_id = SLOT_WEAR_ID
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "mask"
	inv_box.icon = ui_style
	inv_box.icon_state = "mask"
	inv_box.screen_loc = ui_mask
	inv_box.slot_id = SLOT_MASK
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "accessory"
	inv_box.icon = ui_style
	inv_box.icon_state = "neck"
	inv_box.screen_loc = ui_neck
	inv_box.slot_id = SLOT_NECK
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "back"
	inv_box.icon = ui_style
	inv_box.icon_state = "back"
	inv_box.screen_loc = ui_back
	inv_box.slot_id = SLOT_BACK
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "right pocket"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.screen_loc = ui_storage1
	inv_box.slot_id = SLOT_L_STORE
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "left pocket"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.screen_loc = ui_storage2
	inv_box.slot_id = SLOT_R_STORE
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "suit storage"
	inv_box.icon = ui_style
	inv_box.icon_state = "suit_storage"
	inv_box.screen_loc = ui_sstore1
	inv_box.slot_id = SLOT_S_STORE
	static_inventory += inv_box

	using = new /atom/movable/screen/resist()
	using.icon = ui_style
	using.screen_loc = ui_overridden_resist // CIT CHANGE - changes this to overridden resist
	using.hud = src
	hotkeybuttons += using

	using = new /atom/movable/screen/questbook()
	// using.icon = ui_style
	using.screen_loc = ui_questbook
	using.hud = src
	hotkeybuttons += using

	using = new /atom/movable/screen/scannerpls()
	// using.icon = ui_style
	using.screen_loc = ui_questscanner
	using.hud = src
	hotkeybuttons += using

	using = new /atom/movable/screen/rest()
	using.icon = ui_style
	using.screen_loc = ui_pull_resist
	using.hud = src
	static_inventory += using
	//END OF CIT CHANGES

	using = new /atom/movable/screen/human/toggle()
	using.icon = ui_style
	using.screen_loc = ui_inventory
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/human/equip()
	using.icon = ui_style
	using.screen_loc = ui_equip_position(mymob)
	using.hud = src
	static_inventory += using

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "gloves"
	inv_box.icon = ui_style
	inv_box.icon_state = "gloves"
	inv_box.screen_loc = ui_gloves
	inv_box.slot_id = SLOT_GLOVES
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "eyes"
	inv_box.icon = ui_style
	inv_box.icon_state = "glasses"
	inv_box.screen_loc = ui_glasses
	inv_box.slot_id = SLOT_GLASSES
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "ears"
	inv_box.icon = ui_style
	inv_box.icon_state = "ears"
	inv_box.screen_loc = ui_ears
	inv_box.slot_id = SLOT_EARS
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "head"
	inv_box.icon = ui_style
	inv_box.icon_state = "head"
	inv_box.screen_loc = ui_head
	inv_box.slot_id = SLOT_HEAD
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "shoes"
	inv_box.icon = ui_style
	inv_box.icon_state = "shoes"
	inv_box.screen_loc = ui_shoes
	inv_box.slot_id = SLOT_SHOES
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "belt"
	inv_box.icon = ui_style
	inv_box.icon_state = "belt"
//	inv_box.icon_full = "template_small"
	inv_box.screen_loc = ui_belt
	inv_box.slot_id = SLOT_BELT
	static_inventory += inv_box

	throw_icon = new /atom/movable/screen/throw_catch()
	throw_icon.icon = ui_style
	throw_icon.screen_loc = ui_drop_throw
	throw_icon.hud = src
	hotkeybuttons += throw_icon

	internals = new /atom/movable/screen/internals()
	internals.hud = src
	infodisplay += internals

	healths = new /atom/movable/screen/healths()
	healths.hud = src
	infodisplay += healths

	staminas = new /atom/movable/screen/staminas()
	staminas.hud = src
	infodisplay += staminas

	if(!CONFIG_GET(flag/disable_stambuffer))
		staminabuffer = new /atom/movable/screen/staminabuffer()
		staminabuffer.hud = src
		infodisplay += staminabuffer
	//END OF CIT CHANGES

	healthdoll = new /atom/movable/screen/healthdoll()
	healthdoll.hud = src
	infodisplay += healthdoll

	autowhisper = new /atom/movable/screen/autowhisper()
	autowhisper.hud = src
	infodisplay += autowhisper

	pose = new /atom/movable/screen/pose()
	pose.hud = src
	infodisplay += pose

	up = new /atom/movable/screen/up()
	up.hud = src
	infodisplay += up

	down = new /atom/movable/screen/down()
	down.hud = src
	infodisplay += down

	sleep_hud_button = new /atom/movable/screen/sleep_hud_button()
	sleep_hud_button.hud = src
	infodisplay += sleep_hud_button

	triage = new /atom/movable/screen/triage()
	triage.hud = src
	infodisplay += triage

	aooc_hud_button = new /atom/movable/screen/aooc_hud_button()
	aooc_hud_button.hud = src
	infodisplay += aooc_hud_button

	newbie_hud_button = new /atom/movable/screen/newbie_hud_button()
	newbie_hud_button.hud = src
	infodisplay += newbie_hud_button

	roll_hud_button = new /atom/movable/screen/roll_hud_button()
	roll_hud_button.hud = src
	infodisplay += roll_hud_button

	// chardir_hud_button = new /atom/movable/screen/chardir_hud_button()
	// chardir_hud_button.hud = src
	// infodisplay += chardir_hud_button

	// pvp_focus_toggle = new /atom/movable/screen/pvp_focus_toggle()
	// pvp_focus_toggle.hud = src
	// infodisplay += pvp_focus_toggle

	who = new /atom/movable/screen/who()
	who.hud = src
	infodisplay += who

	bank = new /atom/movable/screen/bank()
	bank.hud = src
	infodisplay += bank

	erp_tools_button = new /atom/movable/screen/erp_tools_button()
	erp_tools_button.hud = src
	infodisplay += erp_tools_button

	hand_items_button = new /atom/movable/screen/hand_items_button()
	hand_items_button.hud = src
	infodisplay += hand_items_button

	// bite_hud_button = new /atom/movable/screen/bite_hud_button()
	// bite_hud_button.hud = src
	// infodisplay += bite_hud_button

	// claw_hud_button = new /atom/movable/screen/claw_hud_button()
	// claw_hud_button.hud = src
	// infodisplay += claw_hud_button

	// tail_hud_button = new /atom/movable/screen/tail_hud_button()
	// tail_hud_button.hud = src
	// infodisplay += tail_hud_button

	// cuphand_hud_button = new /atom/movable/screen/cuphand_hud_button()
	// cuphand_hud_button.hud = src
	// infodisplay += cuphand_hud_button
	
	give_button = new /atom/movable/screen/give_button()
	give_button.hud = src
	infodisplay += give_button	
	
	// reload_button = new /atom/movable/screen/reload_button()
	// reload_button.hud = src
	// infodisplay += reload_button

	// beans_hud_button = new /atom/movable/screen/beans_hud_button()
	// beans_hud_button.hud = src
	// infodisplay += beans_hud_button

	// tend_hud_button = new /atom/movable/screen/tend_hud_button()
	// tend_hud_button.hud = src
	// infodisplay += tend_hud_button

	// butt_hud_button = new /atom/movable/screen/butt_hud_button()
	// butt_hud_button.hud = src
	// infodisplay += butt_hud_button

	pull_icon = new /atom/movable/screen/pull()
	pull_icon.icon = ui_style
	pull_icon.hud = src
	pull_icon.update_icon()
	pull_icon.screen_loc = ui_pull_stop
	static_inventory += pull_icon

	lingchemdisplay = new /atom/movable/screen/ling/chems()
	lingchemdisplay.hud = src
	infodisplay += lingchemdisplay

	lingstingdisplay = new /atom/movable/screen/ling/sting()
	lingstingdisplay.hud = src
	infodisplay += lingstingdisplay

	devilsouldisplay = new /atom/movable/screen/devil/soul_counter
	devilsouldisplay.hud = src
	infodisplay += devilsouldisplay

	blood_display = new /atom/movable/screen/bloodsucker/blood_counter	// Blood Volume
	blood_display.hud = src
	infodisplay += blood_display

	vamprank_display = new /atom/movable/screen/bloodsucker/rank_counter	// Bloodsucker Rank
	vamprank_display.hud = src
	infodisplay += vamprank_display

	sunlight_display = new /atom/movable/screen/bloodsucker/sunlight_counter	// Sunlight
	sunlight_display.hud = src
	infodisplay += sunlight_display

	zone_select =  new /atom/movable/screen/zone_sel()
	zone_select.icon = ui_style
	zone_select.hud = src
	zone_select.update_icon()
	static_inventory += zone_select

	for(var/atom/movable/screen/inventory/inv in (static_inventory + toggleable_inventory))
		if(inv.slot_id)
			inv.hud = src
			inv_slots[inv.slot_id] = inv
			inv.update_icon()

	update_locked_slots()

/datum/hud/human/update_locked_slots()
	if(!mymob)
		return
	var/mob/living/carbon/human/H = mymob
	if(!istype(H) || !H.dna.species)
		return
	var/datum/species/S = H.dna.species
	for(var/atom/movable/screen/inventory/inv in (static_inventory + toggleable_inventory))
		if(inv.slot_id)
			if(inv.slot_id in S.no_equip)
				inv.alpha = 128
			else
				inv.alpha = initial(inv.alpha)

/datum/hud/human/hidden_inventory_update(mob/viewer)
	if(!mymob)
		return
	var/mob/living/carbon/human/H = mymob

	var/mob/screenmob = viewer || H

	if(screenmob.hud_used.inventory_shown && screenmob.hud_used.hud_shown)
		if(H.shoes)
			H.shoes.screen_loc = ui_shoes
			screenmob.client.screen += H.shoes
		if(H.gloves)
			H.gloves.screen_loc = ui_gloves
			screenmob.client.screen += H.gloves
		if(H.ears)
			H.ears.screen_loc = ui_ears
			screenmob.client.screen += H.ears
		if(H.glasses)
			H.glasses.screen_loc = ui_glasses
			screenmob.client.screen += H.glasses
		if(H.w_uniform)
			H.w_uniform.screen_loc = ui_iclothing
			screenmob.client.screen += H.w_uniform
		if(H.wear_suit)
			H.wear_suit.screen_loc = ui_oclothing
			screenmob.client.screen += H.wear_suit
		if(H.wear_mask)
			H.wear_mask.screen_loc = ui_mask
			screenmob.client.screen += H.wear_mask
		if(H.wear_neck)
			H.wear_neck.screen_loc = ui_neck
			screenmob.client.screen += H.wear_neck
		if(H.head)
			H.head.screen_loc = ui_head
			screenmob.client.screen += H.head
	else
		if(H.shoes)		screenmob.client.screen -= H.shoes
		if(H.gloves)	screenmob.client.screen -= H.gloves
		if(H.ears)		screenmob.client.screen -= H.ears
		if(H.glasses)	screenmob.client.screen -= H.glasses
		if(H.w_uniform)	screenmob.client.screen -= H.w_uniform
		if(H.wear_suit)	screenmob.client.screen -= H.wear_suit
		if(H.wear_mask)	screenmob.client.screen -= H.wear_mask
		if(H.wear_neck)	screenmob.client.screen -= H.wear_neck
		if(H.head)		screenmob.client.screen -= H.head



/datum/hud/human/persistent_inventory_update(mob/viewer)
	if(!mymob)
		return
	..()
	var/mob/living/carbon/human/H = mymob

	var/mob/screenmob = viewer || H

	if(screenmob.hud_used)
		if(screenmob.hud_used.hud_shown)
			if(H.s_store)
				H.s_store.screen_loc = ui_sstore1
				screenmob.client.screen += H.s_store
			if(H.wear_id)
				H.wear_id.screen_loc = ui_id
				screenmob.client.screen += H.wear_id
			if(H.belt)
				H.belt.screen_loc = ui_belt
				screenmob.client.screen += H.belt
			if(H.back)
				H.back.screen_loc = ui_back
				screenmob.client.screen += H.back
			if(H.l_store)
				H.l_store.screen_loc = ui_storage1
				screenmob.client.screen += H.l_store
			if(H.r_store)
				H.r_store.screen_loc = ui_storage2
				screenmob.client.screen += H.r_store
		else
			if(H.s_store)
				screenmob.client.screen -= H.s_store
			if(H.wear_id)
				screenmob.client.screen -= H.wear_id
			if(H.belt)
				screenmob.client.screen -= H.belt
			if(H.back)
				screenmob.client.screen -= H.back
			if(H.l_store)
				screenmob.client.screen -= H.l_store
			if(H.r_store)
				screenmob.client.screen -= H.r_store

	if(hud_version != HUD_STYLE_NOHUD)
		for(var/obj/item/I in H.held_items)
			I.screen_loc = ui_hand_position(H.get_held_index_of_item(I))
			screenmob.client.screen += I
	else
		for(var/obj/item/I in H.held_items)
			I.screen_loc = null
			screenmob.client.screen -= I


/mob/living/carbon/human/verb/toggle_hotkey_verbs()
	set category = "OOC"
	set name = "Toggle hotkey buttons"
	set desc = "This disables or enables the user interface buttons which can be used with hotkeys."

	if(hud_used.hotkey_ui_hidden)
		client.screen += hud_used.hotkeybuttons
		hud_used.hotkey_ui_hidden = FALSE
	else
		client.screen -= hud_used.hotkeybuttons
		hud_used.hotkey_ui_hidden = TRUE


/mob/living/carbon/human/verb/change_hairstyle()
	set category = "IC"
	set name = "Change Hairstyle"
	set desc = "This allows to change the hairstyle of your character."

	var/new_style = input(src, "Select a hair style", "Grooming")  as null|anything in GLOB.hair_styles_list

	if(new_style)  //if we selected a new hairstyle then make the player wait some time and in the meantime play a cool combing sound.
		playsound(src, 'sound/effects/combing_hair.ogg', 30, 1)
		if(do_after(src, 3 SECONDS, target = src))
			src.hair_style = new_style
			src.update_hair()
	
	new_style = input(src, "Select the second hair style", "Grooming")  as null|anything in GLOB.hair_styles_list

	if(new_style)  //if we selected a new hairstyle then make the player wait some time and in the meantime play a cool combing sound.
		playsound(src, 'sound/effects/combing_hair.ogg', 30, 1)
		if(do_after(src, 3 SECONDS, target = src))
			src.dna.features["hair_style_2"] = new_style
			src.update_hair()

