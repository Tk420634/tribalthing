//These procs handle putting s tuff in your hands
//as they handle all relevant stuff like adding it to the player's screen and updating their overlays.

/mob/proc/deleteWornItem(obj/item/I)
	.= temporarilyRemoveItemFromInventory(I, TRUE)
	qdel(I)

//Returns the thing we're currently holding
/mob/proc/get_active_held_item()
	return get_item_for_held_index(active_hand_index)

//Finds the opposite limb for the active one (eg: upper left arm will find the item in upper right arm)
//So we're treating each "pair" of limbs as a team, so "both" refers to them
/mob/proc/get_inactive_held_item()
	return get_item_for_held_index(get_inactive_hand_index())

//Finds the opposite index for the active one (eg: upper left arm will find the item in upper right arm)
//So we're treating each "pair" of limbs as a team, so "both" refers to them
/mob/proc/get_inactive_hand_index()
	var/other_hand = 0
	if(!(active_hand_index % 2))
		other_hand = active_hand_index-1 //finding the matching "left" limb
	else
		other_hand = active_hand_index+1 //finding the matching "right" limb
	if(other_hand < 0 || other_hand > held_items.len)
		other_hand = 0
	return other_hand

/mob/proc/get_item_for_held_index(i)
	if(i > 0 && i <= held_items.len)
		return held_items[i]

//Odd = left. Even = right
/mob/proc/held_index_to_dir(i)
	if(!(i % 2))
		return "r"
	return "l"

//Check we have an organ for this hand slot (Dismemberment), Only relevant for humans
/mob/proc/has_hand_for_held_index(i)
	return TRUE

//Check we have an organ for our active hand slot (Dismemberment),Only relevant for humans
/mob/proc/has_active_hand()
	return has_hand_for_held_index(active_hand_index)

//Finds the first available (null) index OR all available (null) indexes in held_items based on a side.
//Lefts: 1, 3, 5, 7...
//Rights:2, 4, 6, 8...
/mob/proc/get_empty_held_index_for_side(side = "left", all = FALSE)
	var/start = 0
	var/static/list/lefts = list("l" = TRUE,"L" = TRUE,"LEFT" = TRUE,"left" = TRUE)
	var/static/list/rights = list("r" = TRUE,"R" = TRUE,"RIGHT" = TRUE,"right" = TRUE) //"to remain silent"
	if(lefts[side])
		start = 1
	else if(rights[side])
		start = 2
	if(!start)
		return FALSE
	var/list/empty_indexes
	for(var/i in start to held_items.len step 2)
		if(!held_items[i])
			if(!all)
				return i
			if(!empty_indexes)
				empty_indexes = list()
			empty_indexes += i
	return empty_indexes


//Same as the above, but returns the first or ALL held *ITEMS* for the side
/mob/proc/get_held_items_for_side(side = "left", all = FALSE)
	var/start = 0
	var/static/list/lefts = list("l" = TRUE,"L" = TRUE,"LEFT" = TRUE,"left" = TRUE)
	var/static/list/rights = list("r" = TRUE,"R" = TRUE,"RIGHT" = TRUE,"right" = TRUE) //"to remain silent"
	if(lefts[side])
		start = 1
	else if(rights[side])
		start = 2
	if(!start)
		return FALSE
	var/list/holding_items
	for(var/i in start to held_items.len step 2)
		var/obj/item/I = held_items[i]
		if(I)
			if(!all)
				return I
			if(!holding_items)
				holding_items = list()
			holding_items += I
	return holding_items


/mob/proc/get_empty_held_indexes()
	var/list/L
	for(var/i in 1 to held_items.len)
		if(!held_items[i])
			if(!L)
				L = list()
			L += i
	return L

/mob/proc/get_held_index_of_item(obj/item/I)
	return held_items.Find(I)


//Sad that this will cause some overhead, but the alias seems necessary
//*I* may be happy with a million and one references to "indexes" but others won't be
/mob/proc/is_holding(obj/item/I)
	return get_held_index_of_item(I)


//Checks if we're holding an item of type: typepath
/mob/proc/is_holding_item_of_type(typepath)
	for(var/obj/item/I in held_items)
		if(istype(I, typepath))
			return I
	return FALSE

//Checks if we're holding a tool that has given quality
//Returns the tool that has the best version of this quality
/mob/proc/is_holding_tool_quality(quality)
	var/obj/item/best_item
	var/best_quality = INFINITY

	for(var/obj/item/I in held_items)
		if(I.tool_behaviour == quality && I.toolspeed < best_quality)
			best_item = I
			best_quality = I.toolspeed

	return best_item


//To appropriately fluff things like "they are holding [I] in their [get_held_index_name(get_held_index_of_item(I))]"
//Can be overridden to pass off the fluff to something else (eg: science allowing people to add extra robotic limbs, and having this proc react to that
// with say "they are holding [I] in their US Government Brand Utility Arm - Right Edition" or w/e
/mob/proc/get_held_index_name(i)
	var/list/hand = list()
	if(i > 2)
		hand += "upper "
	var/num = 0
	if(!(i % 2))
		num = i-2
		hand += "right hand"
	else
		num = i-1
		hand += "left hand"
	num -= (num*0.5)
	if(num > 1) //"upper left hand #1" seems weird, but "upper left hand #2" is A-ok
		hand += " #[num]"
	return hand.Join()



//Returns if a certain item can be equipped to a certain slot.
// Currently invalid for two-handed items - call obj/item/mob_can_equip() instead.
/mob/proc/can_equip(obj/item/I, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, clothing_check = FALSE, list/return_warning)
	return FALSE

/mob/proc/can_put_in_hand(I, hand_index)
	if(hand_index > held_items.len)
		return FALSE
	if(!put_in_hand_check(I))
		return FALSE
	if(!has_hand_for_held_index(hand_index))
		return FALSE
	return !held_items[hand_index]

/mob/proc/put_in_hand(obj/item/I, hand_index, forced = FALSE, ignore_anim = TRUE)
	if(forced || can_put_in_hand(I, hand_index))
		if(isturf(I.loc) && !ignore_anim)
			I.do_pickup_animation(src)
		if(hand_index == null)
			return FALSE
		if(get_item_for_held_index(hand_index) != null)
			dropItemToGround(get_item_for_held_index(hand_index), force = TRUE)
		I.forceMove(src)
		held_items[hand_index] = I
		I.layer = ABOVE_HUD_LAYER
		I.plane = ABOVE_HUD_PLANE
		I.equipped(src, SLOT_HANDS)
		if(I.pulledby)
			I.pulledby.stop_pulling()
		update_inv_hands()
		I.pixel_x = initial(I.pixel_x)
		I.pixel_y = initial(I.pixel_y)
		I.reset_transform()
		return hand_index || TRUE
	return FALSE

//Puts the item into the first available left hand if possible and calls all necessary triggers/updates. returns 1 on success.
/mob/proc/put_in_l_hand(obj/item/I)
	return put_in_hand(I, get_empty_held_index_for_side("l"))


//Puts the item into the first available right hand if possible and calls all necessary triggers/updates. returns 1 on success.
/mob/proc/put_in_r_hand(obj/item/I)
	return put_in_hand(I, get_empty_held_index_for_side("r"))


/mob/proc/put_in_hand_check(obj/item/I)
	if(incapacitated(allow_crit = TRUE) && !(I.item_flags&ABSTRACT)) //Cit change - Changes lying to incapacitated so that it's plausible to pick things up while on the ground
		return FALSE
	if(!istype(I))
		return FALSE
	return TRUE


//Puts the item into our active hand if possible. returns TRUE on success.
/mob/proc/put_in_active_hand(obj/item/I, forced = FALSE, ignore_animation = TRUE)
	return put_in_hand(I, active_hand_index, forced, ignore_animation)


//Puts the item into our inactive hand if possible, returns TRUE on success
/mob/proc/put_in_inactive_hand(obj/item/I)
	return put_in_hand(I, get_inactive_hand_index())


//Puts the item our active hand if possible. Failing that it tries other hands. Returns TRUE on success.
//If both fail it drops it on the floor and returns FALSE.
//This is probably the main one you need to know :)
/mob/proc/put_in_hands(obj/item/I, del_on_fail = FALSE, merge_stacks = TRUE, forced = FALSE)
	if(!I)
		return FALSE

	// If the item is a stack and we're already holding a stack then merge
	if (istype(I, /obj/item/stack))
		var/obj/item/stack/I_stack = I
		var/obj/item/stack/active_stack = get_active_held_item()

		if (I_stack.zero_amount())
			return FALSE

		if (merge_stacks)
			if (istype(active_stack) && I_stack.can_merge(active_stack.merge_type, TRUE))
				if (I_stack.merge(active_stack))
					to_chat(usr, span_notice("Your [active_stack.name] stack now contains [active_stack.get_amount()] [active_stack.singular_name]\s."))
					return TRUE
			else
				var/obj/item/stack/inactive_stack = get_inactive_held_item()
				if (istype(inactive_stack) && I_stack.can_merge(inactive_stack.merge_type, TRUE))
					if (I_stack.merge(inactive_stack))
						to_chat(usr, span_notice("Your [inactive_stack.name] stack now contains [inactive_stack.get_amount()] [inactive_stack.singular_name]\s."))
						return TRUE

	if(put_in_active_hand(I, forced))
		return TRUE

	var/hand = get_empty_held_index_for_side("l")
	if(!hand)
		hand =  get_empty_held_index_for_side("r")
	if(hand)
		if(put_in_hand(I, hand, forced))
			return TRUE
	if(del_on_fail)
		qdel(I)
		return FALSE
	I.forceMove(drop_location())
	I.layer = initial(I.layer)
	I.plane = initial(I.plane)
	I.dropped(src)
	return FALSE

/mob/proc/drop_all_held_items()
	. = FALSE
	for(var/obj/item/I in held_items)
		. |= dropItemToGround(I)

//Here lie drop_from_inventory and before_item_take, already forgotten and not missed.

/mob/proc/canUnEquip(obj/item/I, force)
	if(!I)
		return TRUE
	if(HAS_TRAIT(I, TRAIT_NODROP) && !force)
		return FALSE
	return TRUE

/mob/proc/putItemFromInventoryInHandIfPossible(obj/item/I, hand_index, force_removal = FALSE)
	if(!can_put_in_hand(I, hand_index))
		return FALSE
	if(!temporarilyRemoveItemFromInventory(I, force_removal))
		return FALSE
	I.remove_item_from_storage(src)
	if(!put_in_hand(I, hand_index))
		qdel(I)
		CRASH("Assertion failure: putItemFromInventoryInHandIfPossible") //should never be possible
	return TRUE

//The following functions are the same save for one small difference

//for when you want the item to end up on the ground
//will force move the item to the ground and call the turf's Entered
/mob/proc/dropItemToGround(obj/item/I, force = FALSE, drop_inv = TRUE)
	return doUnEquip(I, force, drop_location(), FALSE, invdrop = drop_inv)

//for when the item will be immediately placed in a loc other than the ground
/mob/proc/transferItemToLoc(obj/item/I, newloc = null, force = FALSE)
	return doUnEquip(I, force, newloc, FALSE)

//visibly unequips I but it is NOT MOVED AND REMAINS IN SRC
//item MUST BE FORCEMOVE'D OR QDEL'D
/mob/proc/temporarilyRemoveItemFromInventory(obj/item/I, force = FALSE, idrop = TRUE)
	return doUnEquip(I, force, null, TRUE, idrop)

//DO NOT CALL THIS PROC
//use one of the above 3 helper procs
//you may override it, but do not modify the args
/mob/proc/doUnEquip(obj/item/I, force, newloc, no_move, invdrop = TRUE) //Force overrides TRAIT_NODROP for things like wizarditis and admin undress.
													//Use no_move if the item is just gonna be immediately moved afterward
													//Invdrop is used to prevent stuff in pockets dropping. only set to false if it's going to immediately be replaced
	if(!I) //If there's nothing to drop, the drop is automatically succesfull. If(unEquip) should generally be used to check for TRAIT_NODROP.
		return TRUE

	if(HAS_TRAIT(I, TRAIT_NODROP) && !force)
		return FALSE

	var/hand_index = get_held_index_of_item(I)
	if(hand_index)
		held_items[hand_index] = null
		update_inv_hands()
	if(I)
		if(client)
			client.screen -= I
		I.layer = initial(I.layer)
		I.plane = initial(I.plane)
		I.appearance_flags &= ~NO_CLIENT_COLOR
		if(I.wielded)
			I.unwield(src)
		if(!no_move && !(I.item_flags & DROPDEL))	//item may be moved/qdel'd immedietely, don't bother moving it
			if (isnull(newloc))
				I.moveToNullspace()
			else
				I.forceMove(newloc)
		on_item_dropped(I)
		if(I.dropped(src) == ITEM_RELOCATED_BY_DROPPED)
			return FALSE
	return TRUE

//This is a SAFE proc. Use this instead of equip_to_slot()!
//set qdel_on_fail to have it delete W if it fails to equip
//set disable_warning to disable the 'you are unable to equip that' warning.
//unset redraw_mob to prevent the mob from being redrawn at the end.
/mob/proc/equip_to_slot_if_possible(obj/item/W, slot, qdel_on_fail = FALSE, disable_warning = FALSE, redraw_mob = TRUE, bypass_equip_delay_self = FALSE, clothing_check = FALSE, displace_worn = FALSE)
	if(!istype(W))
		return FALSE
	var/list/warning = list(span_warning("You are unable to equip that!"))
	if(!W.mob_can_equip(src, src, slot, disable_warning, bypass_equip_delay_self, clothing_check, warning))
		var/failedequip = TRUE
		if(displace_worn) // Loadouts will replace what's in that slot with what should be in there
			var/atom/wornthing = get_item_by_slot(slot)
			if(wornthing) // Something's in this slot, destroy it
				dropItemToGround(wornthing, TRUE, FALSE)
				if(LAZYLEN(wornthing.contents)) // If anything's in here, put it in the thing
					for(var/atom/heldinside in wornthing.contents)
						if(!SEND_SIGNAL(wornthing, COMSIG_TRY_STORAGE_INSERT, heldinside, null, TRUE, TRUE)) // Try and transfer whats in the thing to the new thing that'll be there
							dropItemToGround(heldinside, TRUE, FALSE)
				qdel(wornthing)
				failedequip = FALSE
		if(failedequip)
			if(qdel_on_fail)
				qdel(W)
			else if(!disable_warning)
				to_chat(src, warning[1])
			return FALSE
	equip_to_slot(W, slot, redraw_mob) //This proc should not ever fail.
	return TRUE

//This is an UNSAFE proc. It merely handles the actual job of equipping. All the checks on whether you can or can't equip need to be done before! Use mob_can_equip() for that task.
//In most cases you will want to use equip_to_slot_if_possible()
/mob/proc/equip_to_slot(obj/item/W, slot)
	return

//This is just a commonly used configuration for the equip_to_slot_if_possible() proc, used to equip people when the round starts and when events happen and such.
//Also bypasses equip delay checks, since the mob isn't actually putting it on.
/mob/proc/equip_to_slot_or_del(obj/item/W, slot)
	return equip_to_slot_if_possible(W, slot, TRUE, TRUE, FALSE, TRUE)

//puts the item "W" into an appropriate slot in a human's inventory
//returns 0 if it cannot, 1 if successful
/mob/proc/equip_to_appropriate_slot(obj/item/W, clothing_check = FALSE)
	if(!istype(W))
		return 0
	var/slot_priority = W.slot_equipment_priority

	if(!slot_priority)
		slot_priority = list( \
			SLOT_BACK, SLOT_WEAR_ID,\
			SLOT_W_UNIFORM, SLOT_WEAR_SUIT,\
			SLOT_MASK, SLOT_HEAD, SLOT_NECK,\
			SLOT_SHOES, SLOT_GLOVES,\
			SLOT_EARS, SLOT_GLASSES,\
			SLOT_BELT, SLOT_S_STORE,\
			SLOT_L_STORE, SLOT_R_STORE,\
			SLOT_GENERIC_DEXTROUS_STORAGE\
		)

	for(var/slot in slot_priority)
		if(equip_to_slot_if_possible(W, slot, FALSE, TRUE, TRUE, FALSE, clothing_check)) //qdel_on_fail = 0; disable_warning = 1; redraw_mob = 1
			return 1

	return 0

/**
 * Used to return a list of equipped items on a mob; does not include held items (use get_all_gear)
 *
 * Argument(s):
 * * Optional - include_pockets (TRUE/FALSE), whether or not to include the pockets and suit storage in the returned list
 */

/mob/living/proc/get_equipped_items(include_pockets = FALSE)
	var/list/items = list()
	for(var/obj/item/I in contents)
		if(I.item_flags & IN_INVENTORY)
			items += I
	items -= held_items
	return items

/mob/living/proc/unequip_everything()
	var/list/items = list()
	items |= get_equipped_items(TRUE)
	for(var/I in items)
		dropItemToGround(I)
	drop_all_held_items()

/obj/item/proc/equip_to_best_slot(mob/M)
	if(src != M.get_active_held_item())
		to_chat(M, span_warning("You are not holding anything to equip!"))
		return FALSE

	if(M.equip_to_appropriate_slot(src, TRUE))
		M.update_inv_hands()
		return TRUE
	else
		if(equip_delay_self)
			return

	if(M.active_storage && M.active_storage.parent && SEND_SIGNAL(M.active_storage.parent, COMSIG_TRY_STORAGE_INSERT, src,M))
		return TRUE

	var/list/obj/item/possible = list(M.get_inactive_held_item(), M.get_item_by_slot(SLOT_BELT), M.get_item_by_slot(SLOT_GENERIC_DEXTROUS_STORAGE), M.get_item_by_slot(SLOT_BACK))
	for(var/i in possible)
		if(!i)
			continue
		var/obj/item/I = i
		if(SEND_SIGNAL(I, COMSIG_TRY_STORAGE_INSERT, src, M))
			return TRUE

	to_chat(M, span_warning("You are unable to equip that!"))
	usr.playsound_local(usr.loc, 'sound/weapons/bite.ogg', 100, 0)
	return FALSE

//-->
// Stupidly complicated smart equip/unequip, what is this supposed to do:
// If the user is empty handed and triggers this function, then unholster an item with priority and with exceptions
// in the following order:
// 1-Back slot;
// 2-Armor slot;
// 3-Belt slot;
// 4-Holster contents, return ONLY firearms, all other items will be ignored;
// 5-Boot contents.

// There's one more twist to this, for example, if the user had previously unsheathed a revolver from a shoulder holster,
// we clearly want the revolver to be re-sheathed in the previous location.
// If anything is broken, or not working properly, contact me or fix it -leonzrygin
//<--
/mob/verb/quick_equip(obj/item/I)
	set name = "quick-equip"
	set hidden = 1

	if(incapacitated(allow_crit = TRUE))
		return

	var/obj/item/storage
	if(!isitem(I))
		I = get_active_held_item()

	//obj/item/melee/onehanded

	if(I)  //are we holding something in our hands?
		storage = get_item_by_slot(SLOT_S_STORE)
		if(storage)  //if it's empty, put the revolver there (if I'm carrying a pouch there for example)
			if(istype(I, /obj/item/gun) && I.w_class <= WEIGHT_CLASS_NORMAL)
				storage = get_item_by_slot(SLOT_NECK)
				if(storage)
					if(SEND_SIGNAL(storage, COMSIG_CONTAINS_STORAGE))
						if(SEND_SIGNAL(storage, COMSIG_TRY_STORAGE_INSERT, I, src))
							return

		storage = get_item_by_slot(SLOT_SHOES)
		if(istype(I, /obj/item/melee) && I.w_class <= WEIGHT_CLASS_SMALL)
			if(storage)
				if(SEND_SIGNAL(storage, COMSIG_CONTAINS_STORAGE))
					if(SEND_SIGNAL(storage, COMSIG_TRY_STORAGE_INSERT, I, src))
						return

		I.equip_to_best_slot(src)

	else  //Are we empty handed?
		storage = get_item_by_slot(SLOT_BACK)
		if(storage)  //Are we carrying something in this storage slot?
			if(!istype(storage, /obj/item/flashlight))  //this is my personal preference, basically it ignores returning flashlights on your hands, why? because it's silly otherwise!
				if(!SEND_SIGNAL(storage, COMSIG_CONTAINS_STORAGE))  //Is this NOT a storage item? (we don't want to return a pouch or something in our hands, only items that have no storage)
					storage.attack_hand(src)  //Slap my hands with the contents of this storage, which is allegedly only one item.
					return

		storage = get_item_by_slot(SLOT_S_STORE)
		if(storage)  //Are we carrying something in this storage slot?
			if(!istype(storage, /obj/item/flashlight))  //this is my personal preference, basically it ignores returning flashlights on your hands, why? because it's silly otherwise!
				if(!SEND_SIGNAL(storage, COMSIG_CONTAINS_STORAGE))  //Is this NOT a storage item? (we don't want to return a pouch or something in our hands, only items that have no storage)
					storage.attack_hand(src)  //Slap my hands with the contents of this storage, which is allegedly only one item.
					return

		storage = get_item_by_slot(SLOT_BELT)
		if(storage)  //We basically repeat the same checks but for belts
			if(!istype(storage, /obj/item/flashlight))  //this is my personal preference, basically it ignores returning flashlights on your hands, why? because it's silly otherwise!
				if(!SEND_SIGNAL(storage, COMSIG_CONTAINS_STORAGE))
					storage.attack_hand(src)
					return

		storage = get_item_by_slot(SLOT_NECK)  //Are we wearing a holster? If yes, we want to prioritize the unholstering of the gun.
		if(storage)  //Are we carrying something in this storage slot?
			if(SEND_SIGNAL(storage, COMSIG_CONTAINS_STORAGE))  //Is this a storage item?
				if(storage.contents.len)  //there's something to take out.
					var/obj/item/gun/firearm
					for(var/obj/item/gun/F in storage.contents)  //First thing, we want to obviously prioritize the unholstering of the gun.
						firearm = F
						break
					if(firearm && !firearm.on_found(src))
						firearm.allow_quickdraw = TRUE
						firearm.attack_hand(src)  //Slap my hands with the contents of this storage, which is allegedly only one item.
						return

		storage = get_item_by_slot(SLOT_SHOES)  //Shoes are a little different, we don't want to return the item itself, but rather its contents.
		if(storage)  //Are we carrying something in this storage slot?
			if(SEND_SIGNAL(storage, COMSIG_CONTAINS_STORAGE))  //Is this a storage item?
				if(storage.contents.len)  //there's something to take out.
					I = storage.contents[storage.contents.len]  //take the item out
					if(I && !I.on_found(src))
						I.attack_hand(src)  //Slap my hands with the contents of this storage, which is allegedly only one item.
					return

//used in code for items usable by both carbon and drones, this gives the proper back slot for each mob.(defibrillator, backpack watertank, ...)
/mob/proc/getBackSlot()
	return SLOT_BACK

/mob/proc/getBeltSlot()
	return SLOT_BELT



//Inventory.dm is -kind of- an ok place for this I guess

//This is NOT for dismemberment, as the user still technically has 2 "hands"
//This is for multi-handed mobs, such as a human with a third limb installed
//This is a very rare proc to call (besides admin fuckery) so
//any cost it has isn't a worry
/mob/proc/change_number_of_hands(amt)
	if(amt < held_items.len)
		for(var/i in held_items.len to amt step -1)
			dropItemToGround(held_items[i])
	held_items.len = amt

	if(hud_used)
		hud_used.build_hand_slots()


/mob/living/carbon/human/change_number_of_hands(amt)
	var/old_limbs = held_items.len
	if(amt < old_limbs)
		for(var/i in hand_bodyparts.len to amt step -1)
			var/obj/item/bodypart/BP = hand_bodyparts[i]
			BP.dismember()
			hand_bodyparts[i] = null
		hand_bodyparts.len = amt
	else if(amt > old_limbs)
		hand_bodyparts.len = amt
		for(var/i in old_limbs+1 to amt)
			var/path = /obj/item/bodypart/l_arm
			if(!(i % 2))
				path = /obj/item/bodypart/r_arm

			var/obj/item/bodypart/BP = new path ()
			BP.owner = src
			BP.held_index = i
			bodyparts += BP
			hand_bodyparts[i] = BP
	..() //Don't redraw hands until we have organs for them


//GetAllContents that is reasonable and not stupid
/mob/living/carbon/proc/get_all_gear()
	var/list/processing_list = get_equipped_items(include_pockets = TRUE) + held_items
	listclearnulls(processing_list) // handles empty hands
	var/i = 0
	while(i < length(processing_list) )
		var/atom/A = processing_list[++i]
		if(SEND_SIGNAL(A, COMSIG_CONTAINS_STORAGE))
			var/list/item_stuff = list()
			SEND_SIGNAL(A, COMSIG_TRY_STORAGE_RETURN_INVENTORY, item_stuff)
			processing_list += item_stuff
	return processing_list
