#define BAD_INIT_QDEL_BEFORE 1
#define BAD_INIT_DIDNT_INIT 2
#define BAD_INIT_SLEPT 4
#define BAD_INIT_NO_HINT 8

#define PRINT_ATOM_STATS 1

SUBSYSTEM_DEF(atoms)
	name = "Atoms"
	init_order = INIT_ORDER_ATOMS
	flags = SS_NO_FIRE

	var/old_initialized

	var/list/late_loaders

	var/list/BadInitializeCalls = list()

	/// Ginormous hell tally of all the types of atoms in existence.
	/// FORMAT: list(/type = amount)
	var/list/everything = list()

/datum/controller/subsystem/atoms/Initialize(timeofday)
	GLOB.fire_overlay.appearance_flags = RESET_COLOR
	to_chat(world, span_boldannounce("Initializing Genetics..."))
	setupGenetics()
	initialized = INITIALIZATION_INNEW_MAPLOAD
	to_chat(world, span_boldannounce("Initializing Atoms..."))
	InitializeAtoms()
	return ..()

/datum/controller/subsystem/atoms/proc/InitializeAtoms(list/atoms)
	if(initialized == INITIALIZATION_INSSATOMS)
		return

	initialized = INITIALIZATION_INNEW_MAPLOAD

	LAZYINITLIST(late_loaders)

	var/count
	var/list/mapload_arg = list(TRUE)
	if(atoms)
		count = atoms.len
		for(var/I in atoms)
			var/atom/A = I
			if(!(A.flags_1 & INITIALIZED_1))
				InitAtom(I, mapload_arg)
				CHECK_TICK
	else
		count = 0
#ifdef PRINT_ATOM_STATS
		var/all_atoms = LAZYLEN(world.contents)
		var/portion = 1
		var/portion_amount = 0.1
		var/next_milestone = round(all_atoms * (portion * portion_amount))
		var/batch_start = REALTIMEOFDAY
		var/start_timery = REALTIMEOFDAY
		var/this_batch = 0
		var/atoms_did = 0
		var/list/rates = list()
		var/list/num_of_kinds = list(
			/obj = 0,
			/obj/structure = 0,
			/obj/item = 0,
			/mob = 0,
			/turf = 0,
			/area = 0,
			)
#endif
		for(var/atom/A in world)
#ifdef PRINT_ATOM_STATS
			atoms_did++
#endif
			if(!(A.flags_1 & INITIALIZED_1))
				InitAtom(A, mapload_arg)
				++count
#ifdef PRINT_ATOM_STATS
				this_batch++
				for(var/kind in num_of_kinds)
					if(istype(A, kind))
						num_of_kinds[kind]++
				if(atoms_did % next_milestone == 0)
					all_atoms = LAZYLEN(world.contents)
					var/batch_end = REALTIMEOFDAY
					var/batch_time = ((batch_end - batch_start) * 0.1)
					var/batch_rate = (this_batch / max(batch_time, 0.01))
					var/batch_percent = (atoms_did / max(all_atoms, 0.01)) * 100
					portion++
					next_milestone = round(all_atoms * (portion * portion_amount))
					rates += batch_rate
					batch_start = REALTIMEOFDAY
					this_batch = 0
					var/current_time = REALTIMEOFDAY - start_timery
					var/batch_time_left = (current_time / atoms_did) * (all_atoms - atoms_did)
					to_chat(world, span_boldannounce("Init'd [shorten_number(atoms_did, 2)]/[shorten_number(all_atoms, 2)] ([round(batch_percent,portion_amount*100)]%) atoms in [DisplayTimeText(current_time)]. \nProjected time left at [shorten_number(batch_rate, 1)]/sec: [DisplayTimeText(batch_time_left)]!"))
#endif
				CHECK_TICK
#ifdef PRINT_ATOM_STATS
		var/avrate = 0
		for(var/r in rates)
			avrate += r
		avrate /= rates.len
		var/list/output_kinds = list()
		output_kinds += "[shorten_number(num_of_kinds[/obj], 1)] objects"
		output_kinds += "[shorten_number(num_of_kinds[/obj/item], 1)] items"
		output_kinds += "[shorten_number(num_of_kinds[/obj/structure], 1)] structures"
		output_kinds += "[shorten_number(num_of_kinds[/mob], 1)] mobs"
		output_kinds += "[shorten_number(num_of_kinds[/turf], 1)] turfs"
		output_kinds += "[shorten_number(num_of_kinds[/area], 1)] areas"
		to_chat(world, span_boldannounce("~Initialized [shorten_number(count, 2)] atoms ([shorten_number(atoms_did - count, 2)] didn't need it)! Average rate: [shorten_number(avrate, 1)]/sec.~"))
		to_chat(world, span_notice("Of these atoms, [english_list(output_kinds)] initialized."))
#endif
	testing("Initialized [count] atoms")
	pass(count)

	initialized = INITIALIZATION_INNEW_REGULAR

	if(late_loaders.len)
		for(var/I in late_loaders)
			var/atom/A = I
			A.LateInitialize()
		testing("Late initialized [late_loaders.len] atoms")
		late_loaders.Cut()

/datum/controller/subsystem/atoms/proc/InitAtom(atom/A, list/arguments)
	var/the_type = A.type
	if(QDELING(A))
		BadInitializeCalls[the_type] |= BAD_INIT_QDEL_BEFORE
		return TRUE

	var/start_tick = world.time

	var/result = A.Initialize(arglist(arguments))

	if(start_tick != world.time)
		BadInitializeCalls[the_type] |= BAD_INIT_SLEPT

	var/qdeleted = FALSE

	if(result != INITIALIZE_HINT_NORMAL)
		switch(result)
			if(INITIALIZE_HINT_LATELOAD)
				if(arguments[1])	//mapload
					late_loaders += A
				else
					A.LateInitialize()
			if(INITIALIZE_HINT_QDEL)
				qdel(A)
			if(INITIALIZE_HINT_QDEL_FORCE)
				qdel(A, force = TRUE)
				qdeleted = TRUE
			else
				BadInitializeCalls[the_type] |= BAD_INIT_NO_HINT

	if(!A)	//possible harddel
		qdeleted = TRUE
	else if(!(A.flags_1 & INITIALIZED_1))
		BadInitializeCalls[the_type] |= BAD_INIT_DIDNT_INIT
	else
		SEND_SIGNAL(A,COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZE)

	return qdeleted || QDELING(A)

/datum/controller/subsystem/atoms/proc/map_loader_begin()
	old_initialized = initialized
	initialized = INITIALIZATION_INSSATOMS

/datum/controller/subsystem/atoms/proc/map_loader_stop()
	initialized = old_initialized

/datum/controller/subsystem/atoms/Recover()
	initialized = SSatoms.initialized
	if(initialized == INITIALIZATION_INNEW_MAPLOAD)
		InitializeAtoms()
	old_initialized = SSatoms.old_initialized
	BadInitializeCalls = SSatoms.BadInitializeCalls

/datum/controller/subsystem/atoms/proc/GetExistingAtomsOfPath(atom/A)
	if(isatom(A)) // HEY VSAUCE, DANNY HERE, I AM STANDING IN FRONT OF THE WORST PROC IVE EVER MADE
		A = A.type // OR IS IT?
	var/list/atoms = list()
	for(var/B in everything)
		if(LAZYACCESS(everything, B) < 1)
			continue
		if(ispath(B, A)) // NAH ITS PRETTY BAD
			atoms |= B
	return atoms

/datum/controller/subsystem/atoms/proc/setupGenetics()
	var/list/mutations = subtypesof(/datum/mutation/human)
	shuffle_inplace(mutations)
	for(var/A in subtypesof(/datum/generecipe))
		var/datum/generecipe/GR = A
		GLOB.mutation_recipes[initial(GR.required)] = initial(GR.result)
	for(var/i in 1 to LAZYLEN(mutations))
		var/path = mutations[i] //byond gets pissy when we do it in one line
		var/datum/mutation/human/B = new path ()
		B.alias = "Mutation [i]"
		GLOB.all_mutations[B.type] = B
		GLOB.full_sequences[B.type] = generate_gene_sequence(B.blocks)
		GLOB.alias_mutations[B.alias] = B.type
		if(B.locked)
			continue
		if(B.quality == POSITIVE)
			GLOB.good_mutations |= B
		else if(B.quality == NEGATIVE)
			GLOB.bad_mutations |= B
		else if(B.quality == MINOR_NEGATIVE)
			GLOB.not_good_mutations |= B
		CHECK_TICK

/datum/controller/subsystem/atoms/proc/InitLog()
	. = ""
	for(var/path in BadInitializeCalls)
		. += "Path : [path] \n"
		var/fails = BadInitializeCalls[path]
		if(fails & BAD_INIT_DIDNT_INIT)
			. += "- Didn't call atom/Initialize()\n"
		if(fails & BAD_INIT_NO_HINT)
			. += "- Didn't return an Initialize hint\n"
		if(fails & BAD_INIT_QDEL_BEFORE)
			. += "- Qdel'd in New()\n"
		if(fails & BAD_INIT_SLEPT)
			. += "- Slept during Initialize()\n"

/datum/controller/subsystem/atoms/Shutdown()
	var/initlog = InitLog()
	if(initlog)
		text2file(initlog, "[GLOB.log_directory]/initialize.log")
