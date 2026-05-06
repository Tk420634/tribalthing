/datum/emote/living/carbon/airguitar
	key = "airguitar"
	message = "is strumming the air and headbanging like a lunatic."
	restraint_check = TRUE
	sound = 'sound/effects/airguitar.ogg'

/datum/emote/living/carbon/blink
	key = "blink"
	key_third_person = "blinks"
	message = "blinks."
	sound = 'sound/effects/blink.ogg'


/datum/emote/living/carbon/hddspinup
	key = "bootup"
	key_third_person = "whirrs up their on board memory."
	message = "whirrs up their on board memory."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/effects/bootup.ogg'

/datum/emote/living/carbon/beeper7
	key = "beeper7"
	key_third_person = "pings!"
	message = "pings!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/effects/beeper7.ogg'


/datum/emote/living/carbon/rpurr
	key = "rpurr"
	key_third_person = "rpurr"
	message = "purrs like a raptor."
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_splurt/sound/voice/raptor_purr.ogg'

/datum/emote/living/carbon/yippie
	key = "yippie"
	key_third_person = "yippie"
	message = "is incredibly joyous!"
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_splurt/sound/voice/yippee.ogg'

/datum/emote/living/carbon/mewo
	key = "mewo"
	key_third_person = "mewos"
	message = "mewos innocently."
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_splurt/sound/voice/mewo.ogg'

/datum/emote/living/carbon/blink_r
	key = "blink_r"
	message = "blinks rapidly."

/datum/emote/living/carbon/clap
	key = "clap"
	key_third_person = "claps"
	message = "claps."
	muzzle_ignore = TRUE
	restraint_check = TRUE
	emote_type = EMOTE_AUDIBLE
	sound = list('sound/misc/clap1.ogg',
				'sound/misc/clap2.ogg',
				'sound/misc/clap3.ogg',
				'sound/misc/clap4.ogg')


/datum/emote/living/carbon/clap/can_run_emote(mob/living/user, status_check, intentional)
	. = ..()
	// Need hands to clap
	if(!user.get_bodypart(BODY_ZONE_L_ARM) || !user.get_bodypart(BODY_ZONE_R_ARM))
		return

/datum/emote/living/carbon/gnarl
	key = "gnarl"
	key_third_person = "gnarls"
	message = "gnarls and shows their teeth..."
	sound = 'sound/alien/voice/gnarl1.ogg'

/datum/emote/living/carbon/moan
	key = "moan"
	key_third_person = "moans"
	message = "moans!"
	emote_type = EMOTE_AUDIBLE
	stat_allowed = SOFT_CRIT
	
/*
/datum/emote/living/carbon/moan/get_sound(mob/living/M) //need better, ie. more pleasured (because these are mostly when doing drugs) moans
	if(ishuman(M))
		if(M.gender == FEMALE)
			. = list(
				'sound/effects/female_moan1.ogg',
				'sound/effects/female_moan2.ogg',
				'sound/effects/female_moan3.ogg'
			)
		else
			. = list(
				'sound/effects/male_moan1.ogg',
				'sound/effects/male_moan2.ogg',
				'sound/effects/male_moan3.ogg'
			)
		return 
*/
/datum/emote/living/carbon/roll
	key = "roll"
	key_third_person = "rolls"
	message = "rolls."
	restraint_check = TRUE

/datum/emote/living/carbon/oneclap
	key = "oneclap"
	key_third_person = "oneclaps"
	message = "claps, once."
	muzzle_ignore = TRUE
	restraint_check = TRUE
	emote_type = EMOTE_AUDIBLE
	sound = list('honk/sound/emotes/clap1.ogg',
				'honk/sound/emotes/clap2.ogg')


/datum/emote/living/carbon/oneclap/can_run_emote(mob/living/user, status_check, intentional)
	. = ..()
	// Need hands to clap
	if(!user.get_bodypart(BODY_ZONE_L_ARM) || !user.get_bodypart(BODY_ZONE_R_ARM))
		return

/datum/emote/living/carbon/scratch
	key = "scratch"
	key_third_person = "scratches"
	message = "scratches."
	restraint_check = TRUE

/datum/emote/living/carbon/screech
	key = "screech"
	key_third_person = "screeches"
	message = "screeches."

/datum/emote/living/carbon/sign
	key = "sign"
	key_third_person = "signs"
	message_param = "signs the number %t."
	restraint_check = TRUE

/datum/emote/living/carbon/sign/select_param(mob/user, params)
	. = ..()
	if(!isnum(text2num(params)))
		return message

/datum/emote/living/carbon/sign/signal
	key = "signal"
	key_third_person = "signals"
	message_param = "raises %t fingers."
	restraint_check = TRUE

/datum/emote/living/carbon/tail
	key = "tail"
	message = "waves their tail."

/datum/emote/living/carbon/wink
	key = "wink"
	key_third_person = "winks"
	message = "winks."

/datum/emote/living/carbon/lick
	key = "lick"
	key_third_person = "licks"
	restraint_check = TRUE

/datum/emote/living/carbon/lick/run_emote(mob/user)
	. = ..()
	SShanditems.give_hand_item(user, /obj/item/hand_item/tactile/licker)

/datum/emote/living/carbon/touch
	key = "touch"
	key_third_person = "touches"
	restraint_check = TRUE

/datum/emote/living/carbon/touch/run_emote(mob/user)
	. = ..()
	SShanditems.give_hand_item(user, /obj/item/hand_item/tactile/toucher)

/datum/emote/living/carbon/kiss
	key = "kiss"
	key_third_person = "kisses"
	restraint_check = TRUE

/datum/emote/living/carbon/kiss/run_emote(mob/user)
	. = ..()
	SShanditems.give_hand_item(user, /obj/item/hand_item/tactile/kisser)

/datum/emote/living/carbon/tend
	key = "tend"
	key_third_person = "tends"
	restraint_check = TRUE

/datum/emote/living/carbon/tend/run_emote(mob/user)
	. = ..()
	SShanditems.give_hand_item(user, /obj/item/hand_item/tactile/triage)

//We are not naming this 'beaner' so help me god
/datum/emote/living/carbon/bean
	key = "bean"
	key_third_person = "beans"
	restraint_check = TRUE

/datum/emote/living/carbon/bean/run_emote(mob/user)
	. = ..()
	SShanditems.give_hand_item(user, /obj/item/hand_item/weapon/beans)

/datum/emote/living/carbon/bean_war
	key = "warbean"
	key_third_person = "warbeans"
	restraint_check = TRUE

/datum/emote/living/carbon/bean_war/run_emote(mob/user)
	. = ..()
	SShanditems.give_hand_item(user, /obj/item/hand_item/weapon/beans/war)

/datum/emote/living/carbon/cuphand
	key = "cuphand"
	key_third_person = "uses their hand as a cup."
	restraint_check = TRUE

/datum/emote/living/carbon/cuphand/run_emote(mob/user)
	. = ..()
	SShanditems.give_hand_item(user, /obj/item/hand_item/spawner/cuphand)


/*/datum/emote/living/carbon/human/magic/can_run_emote(mob/user, status_check = FALSE, intentional = TRUE)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_WAND_PROFICIENT)) //Checks if we can even use magic
		return TRUE // If we have the trait, we can use these emotes and they show up
	return FALSE // If we dont, we cant use these emotes, and they dont show up

/datum/emote/living/carbon/human/magic/magicmissile //The spell itself, basically just the key to cast
	key = "mmissle"
	key_third_person = "magic missile!"
	message = "uses their powers!"

/datum/emote/living/carbon/human/magic/magicmissile/run_emote(mob/living/user)
	. = ..()
	if(!can_run_emote(user))
		return FALSE
	if(user.get_active_held_item())
		to_chat(user, span_warning("What you are holding is not a paper you can write on."))
		return
	if(typesof(/obj/item/paper))
		do_after(user, 50)
	var/obj/item/gun/magic/wand/kelpmagic/basiczappies/hand/sparks = new(user)
	if(user.put_in_hands(sparks))
		to_chat(user, span_notice("Sparks form in your hands"))
	else
		qdel(sparks)
*/// Corpse of a project I don't have the time or willpower to finish

//Biter//
/datum/emote/living/carbon/bite
	key = "bite"
	key_third_person = "bites"
	restraint_check = TRUE

/datum/emote/living/carbon/bite/run_emote(mob/living/user)
	. = ..()
	SShanditems.give_hand_item(user, /obj/item/hand_item/weapon/biter)

//Tailer//
/datum/emote/living/carbon/tailer
	key = "tailer"
	key_third_person = "tails"
	restraint_check = TRUE

/datum/emote/living/carbon/tailer/run_emote(mob/living/user)
	. = ..()
	SShanditems.give_hand_item(user, /obj/item/hand_item/weapon/tail)

//Clawer//
/datum/emote/living/carbon/claw 
	key = "claw" 
	key_third_person = "claws" 
	restraint_check = TRUE 

/datum/emote/living/carbon/claw/run_emote(mob/living/user)
	. = ..()
	SShanditems.give_hand_item(user, /obj/item/hand_item/weapon/clawer)

//shocking grasp//
/datum/emote/living/carbon/shocking
	key = "shocking"
	key_third_person = "casts shocking grasp!"
	restraint_check = TRUE

/datum/emote/living/carbon/shocking/run_emote(mob/living/user)
	. = ..()
	SShanditems.give_hand_item(user, /obj/item/hand_item/cantrip/godhand)

//booming blade//

//datum/emote/living/carbon/booming
	//key = "booming"
	//key_third_person = "casts booming blade!"
	//restraint_check = TRUE

///datum/emote/living/carbon/booming/run_emote(mob/user)
	//. = ..()
	//if(user.get_active_held_item())
		//to_chat(user, span_warning("Your hands are too full to cast!"))
		//return
	//var/which_cantrip_to_spawn
	//if(HAS_TRAIT(user, TRAIT_BOOMING))
		//which_cantrip_to_spawn = /obj/item/gun/magic/staff/spellblade/weak
	//else 
		//to_chat(user, span_notice("You don't know how to cast this spell!"))
	//var/obj/item/gun/magic/staff/spellblade/weak/cantrip = new which_cantrip_to_spawn(user) 
	//if(user.put_in_hands(cantrip))
		//to_chat(user, span_notice("You are ready to smite your foes"))
	//else
		//qdel(cantrip)

//Shover//
/datum/emote/living/carbon/shover
	key = "shove"
	key_third_person = "shoves"
	restraint_check = TRUE

/datum/emote/living/carbon/shover/run_emote(mob/user)
	. = ..()
	SShanditems.give_hand_item(user, /obj/item/hand_item/weapon/shover)

//armblade mutation//
/datum/emote/living/carbon/armblade
	key = "armblade"
	key_third_person = "draws an arm blade!"
	restraint_check = TRUE

/datum/emote/living/carbon/armblade/run_emote(mob/user)
	. = ..()
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your hands are too full to use your blade!"))
		return
	var/which_blade_to_spawn
	if(HAS_TRAIT(user, TRAIT_ARMBLADE))
		which_blade_to_spawn = /obj/item/hand_item/arm_blade/mutation
	else 
		to_chat(user, span_notice("You ain't got no arm blades!"))
	var/obj/item/hand_item/arm_blade/mutation/blade = new which_blade_to_spawn(user) 
	if(user.put_in_hands(blade))
		to_chat(user, span_notice("You get your blades ready to slice!"))
	else
		qdel(blade)

//cybernetic blade placeholder(?)
/datum/emote/living/carbon/cyberarm
	key = "cyber"
	key_third_person = "draws an arm blade!"
	restraint_check = TRUE

/datum/emote/living/carbon/cyberarm/run_emote(mob/user)
	. = ..()
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your hands are too full to use your blade!"))
		return
	var/which_blade_to_spawn
	if(HAS_TRAIT(user, TRAIT_CYBERKNIFE))
		which_blade_to_spawn = /obj/item/hand_item/arm_blade/mutation/cyber
	else 
		to_chat(user, span_notice("You ain't got no arm blades!"))
	var/obj/item/hand_item/arm_blade/mutation/cyber/blade = new which_blade_to_spawn(user) 
	if(user.put_in_hands(blade))
		to_chat(user, span_notice("You get your blades ready to slice!"))
	else
		qdel(blade)

//arm tentacle mutation//
/datum/emote/living/carbon/tentarm
	key = "tentarm"
	key_third_person = "contorts their arm into a tentacle!"
	restraint_check = TRUE

/datum/emote/living/carbon/tentarm/run_emote(mob/user)
	. = ..()
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your hands are too full to use your tentacle arm!"))
		return
	var/which_tentacle_to_spawn
	if(HAS_TRAIT(user, TRAIT_ARMTENT))
		which_tentacle_to_spawn = /obj/item/gun/magic/tentacle
	else 
		to_chat(user, span_notice("You ain't got no arm tentacles, you goof!"))
	var/obj/item/gun/magic/tentacle/tentacle = new which_tentacle_to_spawn(user) 
	if(user.put_in_hands(tentacle))
		to_chat(user, span_notice("You get your arm tentacle ready to grab!"))
	else
		qdel(tentacle)

//Mage grab spell
/datum/emote/living/carbon/magegrab
	key = "magegrab"
	key_third_person = "grabbing you"
	restraint_check = TRUE

/datum/emote/living/carbon/magegrab/run_emote(mob/user)
	. = ..()
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your hands are too full to preform magic!"))
		return
	var/which_tentacle_to_spawn
	if(HAS_TRAIT(user, TRAIT_MAGEGRAB))
		which_tentacle_to_spawn = /obj/item/gun/magic/magegrab
	else 
		to_chat(user, span_notice("You ain't got this magic!"))
	var/obj/item/gun/magic/magegrab/tentacle = new which_tentacle_to_spawn(user) 
	if(user.put_in_hands(tentacle))
		to_chat(user, span_notice("You get your spell ready to cast."))
	else
		qdel(tentacle)

//Mage grab spell
/datum/emote/living/carbon/butt
	key = "butt"
	key_third_person = "butting you"
	restraint_check = TRUE

/datum/emote/living/carbon/butt/run_emote(mob/user)
	. = ..()
	SShanditems.give_hand_item(user, /obj/item/hand_item/weapon/butt)

//Rock throw//
/datum/emote/living/carbon/rocker
	key = "rocks"
	key_third_person = "rocks"
	restraint_check = TRUE

/datum/emote/living/carbon/rocker/run_emote(mob/user)
	. = ..()
	SShanditems.give_hand_item(user, /obj/item/hand_item/spawner/rock)

//brick//
/datum/emote/living/carbon/bricker
	key = "brick"
	key_third_person = "bricks"
	restraint_check = TRUE


/datum/emote/living/carbon/bricker/run_emote(mob/user)
	. = ..()
	SShanditems.give_hand_item(user, /obj/item/hand_item/spawner/brick)

//snowball//
/datum/emote/living/carbon/snowballer
	key = "snowball"
	key_third_person = "snowball"
	restraint_check = TRUE


/datum/emote/living/carbon/snowballer/run_emote(mob/user)
	. = ..()
	SShanditems.give_hand_item(user, /obj/item/hand_item/spawner/snowball)
// 	var/MM = text2num(time2text(world.timeofday, "MM"))
// 	if(MM == 12 || MM == 1 || MM == 2)
// 		if(!COOLDOWN_FINISHED(src, snowball_cooldown) && !HAS_TRAIT(user, TRAIT_MONKEYLIKE))
// 			to_chat(user, span_warning("You cant find any snowballs yet!"))
// 			return
// 		if(user.get_active_held_item())
// 			to_chat(user, span_warning("Your hands are too full to go looking for snowballs!"))
// 			return
// 		var/obj/item/toy/snowball/snowball = new(user)

// 		if(hasPickedUp)
// 			snowball.throwforce = damageMult / damageNerf

// 		if(user.put_in_hands(snowball))
// 			hasPickedUp = TRUE
// 			damageMult = snowball.throwforce
// 			if(!timerEnabled)
// 				addtimer(CALLBACK(src,PROC_REF(reset_damage)), 2.5 SECONDS)
// 				timerEnabled = TRUE
// 			COOLDOWN_START(src, snowball_cooldown, 2.5 SECONDS)
// 			to_chat(user, span_notice("You pack together a nice round snowball!"))
// 		else
// 			qdel(snowball)
// 	else
// 		to_chat(user, span_notice("It's the wrong season for snow..."))

// /datum/emote/living/carbon/snowballer/proc/reset_damage()
// 	hasPickedUp = FALSE
// 	timerEnabled = FALSE
// 	damageMult = initial(damageMult)

//snowblock//
// /datum/emote/living/carbon/snower
// 	key = "snow"
// 	key_third_person = "snow"
// 	restraint_check = TRUE


// /datum/emote/living/carbon/snower/run_emote(mob/user)
// 	. = ..()
// 	var/MM = text2num(time2text(world.timeofday, "MM"))
// 	if(MM == 12 || MM == 1 || MM == 2)
// 		if(user.get_active_held_item())
// 			to_chat(user, span_warning("Your hands are too full to gather up snow!"))
// 			return
// 		var/obj/item/stack/sheet/mineral/snow/snow = new(user)

// 		if(user.put_in_hands(snow))
// 			to_chat(user, span_notice("You gather up some snow!"))
// 		else
// 			qdel(snow)
// 	else
// 		to_chat(user, span_notice("It's the wrong season for snow..."))

/datum/emote/living/carbon/tsk
	key = "tsk"
	message = "tsks audibly."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/braidpull
	key = "braidpull"
	message = "pulls their braid fitfully."

/datum/emote/living/carbon/hairfix
	key = "hairfix"
	message = "is trying to fix their hair."

/datum/emote/living/carbon/handclasp
	key = "clasp"
	message = "clasps their hands in front of them."

/datum/emote/living/carbon/eyeroll
	key = "eyeroll"
	message = "rolls their eyes."

/datum/emote/living/carbon/tongueclick
	key = "tongueclick"
	message = "clicks their tongue as if annoyed."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/kneel
	key = "kneel"
	message = "slowly drops to the ground, kneeling with their legs underneath them."

/datum/emote/living/carbon/snicker
	key = "snicker"
	message = "snickers quietly to themself."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/huff
	key = "huff"
	message = "huffs loudly, exhausted or exasperated. Who knows."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/wait
	key = "wait"
	message = "holds up one finger, giving the universal sign for 'wait a moment'."

/datum/emote/living/carbon/waveon
	key = "waveon"
	message = "waves a hand motioning someone, or something, onward."

/datum/emote/living/carbon/halt
	key = "halt"
	message = "raises a hand palm out, motioning for someone or something to halt."

/datum/emote/living/carbon/daydream
	key = "daydream"
	message = "seems lost in a daydream, their eyes slightly glazed over and giving a thousand yard stare."

/datum/emote/living/carbon/drool
	key = "drool"
	message = "looks like they're drooling a little."

/datum/emote/living/carbon/blank
	key = "blank"
	message = "looks like they have no thoughts in their head."


/datum/emote/living/carbon/snunch
	key = "snunch"
	message = "is lunching like a snake."
//hahadorks


/datum/emote/living/carbon/powerpose
	key = "powerpose"
	message = "puts their hands on their hips and takes a steady pose."
	message_param = "power poses like a super hero at %t."
	restraint_check = TRUE

/datum/emote/living/carbon/snaplook
	key = "snaplook"
	message = "snaps their gaze around!"
	message_param = "snaps their gaze around, locking onto %t!"

/datum/emote/living/carbon/peace
	key = "peace"
	message = "throws up a peace sign!"
	message_param = "throws up a peace sign at %t!"

/datum/emote/living/carbon/thebird
	key = "thebird"
	message = "fires off the bird!"
	message_param = "full sends the bird at %t!"

/datum/emote/living/carbon/thebirds
	key = "thebirds"
	message = "gives both barrels of the bird!"
	message_param = "double barrels the birds at %t!"

/datum/emote/living/carbon/vlick
	key = "vlick"
	message = "pretends to lick between their spread pointer and middle finger!"

/datum/emote/living/carbon/cheekpoke
	key = "cheekpoke"
	message = "pushes their tongue into their cheek."

/datum/emote/living/carbon/headbob
	key = "headbob"
	message = "is bobbing their head to something."

/datum/emote/living/carbon/hairflick
	key = "hairflick"
	message = "flicks their hair back out of their face."

/datum/emote/living/carbon/hairchew
	key = "hairchew"
	message = "chews on their bangs a little bit."

/datum/emote/living/carbon/lewdintent
	key = "lewdintent"
	restraint_check = TRUE

/datum/emote/living/carbon/lewdintent/run_emote(mob/user)
	. = ..()
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your active hand is full, you can't wear your sleeve on your shoulder! Don't ask why!"))
		return
	var/obj/item/clothing/accessory/heart/dtf = new(user)
	if(user.put_in_hands(dtf))
		to_chat(user, span_notice("You're ready to make it clear to others what it is you REALLY want!"))
	else
		qdel(dtf)

/datum/emote/living/carbon/intentlfg
	key = "intentlfg"
	restraint_check = TRUE

/datum/emote/living/carbon/intentlfg/run_emote(mob/user)
	. = ..()
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your active hand is full, you can't do this! Don't ask why!"))
		return
	var/obj/item/clothing/accessory/looking/dtf = new(user)
	if(user.put_in_hands(dtf))
		to_chat(user, span_notice("Place this on your uniform to show your intent!"))
	else
		qdel(dtf)

/datum/emote/living/carbon/intentmelee
	key = "intentmelee"
	restraint_check = TRUE

/datum/emote/living/carbon/intentmelee/run_emote(mob/user)
	. = ..()
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your active hand is full, you can't do this! Don't ask why!"))
		return
	var/obj/item/clothing/accessory/melee/dtf = new(user)
	if(user.put_in_hands(dtf))
		to_chat(user, span_notice("Place this on your uniform to show your intent!"))
	else
		qdel(dtf)

/datum/emote/living/carbon/intentranged
	key = "intentranged"
	restraint_check = TRUE

/datum/emote/living/carbon/intentranged/run_emote(mob/user)
	. = ..()
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your active hand is full, you can't do this! Don't ask why!"))
		return
	var/obj/item/clothing/accessory/ranged/dtf = new(user)
	if(user.put_in_hands(dtf))
		to_chat(user, span_notice("Place this on your uniform to show your intent!"))
	else
		qdel(dtf)

/datum/emote/living/carbon/intentnewplayer
	key = "intentnewbie"
	restraint_check = TRUE

/datum/emote/living/carbon/intentnewplayer/run_emote(mob/user)
	. = ..()
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your active hand is full, you can't do this! Don't ask why!"))
		return
	var/obj/item/clothing/accessory/newbsprout/dtf = new(user)
	if(user.put_in_hands(dtf))
		to_chat(user, span_notice("Place this on your uniform to show your intent!"))
	else
		qdel(dtf)

/datum/emote/living/carbon/intentmentor
	key = "intentmentor"
	restraint_check = TRUE

/datum/emote/living/carbon/intentmentor/run_emote(mob/user)
	. = ..()
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your active hand is full, you can't do this! Don't ask why!"))
		return
	var/obj/item/clothing/accessory/mentorcrown/dtf = new(user)
	if(user.put_in_hands(dtf))
		to_chat(user, span_notice("Place this on your uniform to show your intent!"))
	else
		qdel(dtf)

/datum/emote/living/carbon/intentsupport
	key = "intentsupport"
	restraint_check = TRUE

/datum/emote/living/carbon/intentsupport/run_emote(mob/user)
	. = ..()
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your active hand is full, you can't do this! Don't ask why!"))
		return
	var/obj/item/clothing/accessory/healer/dtf = new(user)
	if(user.put_in_hands(dtf))
		to_chat(user, span_notice("Place this on your uniform to show your intent!"))
	else
		qdel(dtf)

/datum/emote/living/carbon/intentpvp
	key = "intentpvp"
	restraint_check = TRUE
	
/datum/emote/living/carbon/intentpvp/run_emote(mob/user)
	. = ..()
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your active hand is full, you can't do this! Don't ask why!"))
		return
	var/obj/item/clothing/accessory/pvpindicator/dtf = new(user)
	if(user.put_in_hands(dtf))
		to_chat(user, span_notice("Place this on your uniform to show your intent!"))
	else
		qdel(dtf)

/datum/emote/living/carbon/intenttank
	key = "intenttank"
	restraint_check = TRUE
	
/datum/emote/living/carbon/intenttank/run_emote(mob/user)
	. = ..()
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your active hand is full, you can't do this! Don't ask why!"))
		return
	var/obj/item/clothing/accessory/tank/dtf = new(user)
	if(user.put_in_hands(dtf))
		to_chat(user, span_notice("Place this on your uniform to show your intent!"))
	else
		qdel(dtf)
	
/datum/emote/living/carbon/pvp_opt_out
	key = "nopvp"
	restraint_check = FALSE

/datum/emote/living/carbon/pvp_opt_out/run_emote(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_PVEFOC))
		REMOVE_TRAIT(user, TRAIT_PVEFOC, ROUNDSTART_TRAIT)
	else
		ADD_TRAIT(user, TRAIT_PVEFOC, ROUNDSTART_TRAIT)

	SSpornhud.update_visibility(user, PHUD_PVP_FLAG, HAS_TRAIT(user, TRAIT_PVEFOC))
	if(HAS_TRAIT(user, TRAIT_PVEFOC))
		log_consent("[user] ([user.ckey]) has opted OPTED OUT of PVP!")
		to_chat(user, span_notice("You have opted out of PVP."))
	else
		log_consent("[user] ([user.ckey]) has OPTED BACK INTO PVP!")
		to_chat(user, span_notice("You have opted back into PVP."))

