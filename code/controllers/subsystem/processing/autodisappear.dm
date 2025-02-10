SUBSYSTEM_DEF(autodisappear)
	name = "autodisappear"
	priority = FIRE_PRIORITY_OBJ
	flags = SS_NO_INIT
	wait = 5 SECONDS
	var/list/vanishing = list()

/datum/controller/subsystem/autodisappear/fire(resumed = 0)
	for(var/datum/auto_disappear/AD in vanishing)
		AD.heartbeat()

/datum/controller/subsystem/autodisappear/proc/register_thing(atom/movable/thingy, timetime)
	var/datum/auto_disappear/AD = new /datum/auto_disappear(thingy, timetime)
	vanishing |= AD

/datum/controller/subsystem/autodisappear/proc/unregister_thing(atom/movable/thingy)
	var/datum/auto_disappear/AD = get_AD_for_thing(thingy)
	unregister_AD(AD)

/datum/controller/subsystem/autodisappear/proc/unregister_AD(datum/auto_disappear/DAD)
	DAD.thingref = null
	vanishing -= DAD
	qdel(DAD)
	return

/datum/controller/subsystem/autodisappear/proc/get_AD_for_thing(atom/movable/thingy)
	for(var/datum/auto_disappear/AD in vanishing)
		if(AD.get_thing() == thingy)
			return AD

/datum/controller/subsystem/autodisappear/proc/disappearify(datum/auto_disappear/DAD)
	var/atom/thingy = DAD.get_thing()
	new /obj/effect/temp_visual/decoy/fading/fivesecond(get_turf(thingy), thingy)
	qdel(thingy) // clood disappear
	unregister_AD(DAD)

/datum/auto_disappear
	var/datum/weakref/thingref
	var/key
	var/maxtime = 30 SECONDS
	var/timeleft
	var/lasttick
	var/vanishing // cloood disappear

/datum/auto_disappear/New(atom/thingy, cooltime)
	. = ..()
	thingref = WEAKREF(thingy)
	maxtime = cooltime
	timeleft = maxtime
	lasttick = world.time

/datum/auto_disappear/proc/get_thing()
	return GET_WEAKREF(thingref)

/datum/auto_disappear/proc/heartbeat()
	if(vanishing)
		return
	var/atom/movable/thing = get_thing()
	if(!thing)
		SSautodisappear.unregister_AD(src)
		return
	if(!isturf(thing.loc) || (locate(/obj/structure/table) in get_turf(thing))) // things in containers
		timeleft = maxtime
	else
		var/delta = world.time - lasttick
		timeleft -= delta
	lasttick = world.time
	if(timeleft <= 0)
		vanishing = TRUE // clood vanish
		SSautodisappear.disappearify(src)



