/// Checks if something is a BYOND object datatype rather than a primitive, or whatever's closest to one.
#define is_object_datatype(object)		(object && !ispath(object) && !istext(object) && !isnum(object))

// simple is_type and similar inline helpers

#define in_range(source, user) (get_dist(source, user) <= 1 && (get_step(source, 0)?:z) == (get_step(user, 0)?:z))

#define isatom(A) (isloc(A))

#define isweakref(D) (istype(D, /datum/weakref))

//Turfs
//#define isturf(A) (istype(A, /turf)) This is actually a byond built-in. Added here for completeness sake.

GLOBAL_LIST_INIT(turfs_without_ground, typecacheof(list(
	/turf/open/space,
	/turf/open/chasm,
	/turf/open/lava,
	/turf/open/water,
	/turf/open/transparent/openspace
	)))

#define isgroundlessturf(A) (is_type_in_typecache(A, GLOB.turfs_without_ground))

#define isopenturf(A) (istype(A, /turf/open))

#define isindestructiblefloor(A) (istype(A, /turf/open/indestructible))

#define isspaceturf(A) (istype(A, /turf/open/space))

#define isfloorturf(A) (istype(A, /turf/open/floor))

#define isgroundturf(A) (istype(A, /turf/open/indestructible/ground))

#define isclosedturf(A) (istype(A, /turf/closed))

#define isindestructiblewall(A) (istype(A, /turf/closed/indestructible))

#define iswallturf(A) (istype(A, /turf/closed/wall))

#define ismineralturf(A) (istype(A, /turf/closed/mineral))

#define islava(A) (istype(A, /turf/open/lava))

#define ischasm(A) (istype(A, /turf/open/chasm))

#define isplatingturf(A) (istype(A, /turf/open/floor/plating))

#define istransparentturf(A) (istype(A, /turf/open/transparent))

//Crayon and spray cannable turfs
#define ispaintableturf(A) (isfloorturf(A) || isindestructiblefloor(A) || iswallturf(A) || isindestructiblewall(A))

//Mobs
#define isliving(A) (istype(A, /mob/living))

#define isbrain(A) (istype(A, /mob/living/brain))

//Carbon mobs
#define iscarbon(A) (istype(A, /mob/living/carbon))

#define ishuman(A) (istype(A, /mob/living/carbon/human))

//Human sub-species
#define isabductor(A) (is_species(A, /datum/species/abductor))
#define isgolem(A) (is_species(A, /datum/species/golem))
#define islizard(A) (is_species(A, /datum/species/lizard))
#define isplasmaman(A) (is_species(A, /datum/species/plasmaman))
#define ispodperson(A) (is_species(A, /datum/species/pod))
#define isflyperson(A) (is_species(A, /datum/species/fly))
#define isjellyperson(A) (is_species(A, /datum/species/jelly) || is_species(A, /datum/species/feral/slime))
#define isslimeperson(A) (is_species(A, /datum/species/jelly/slime))
#define isluminescent(A) (is_species(A, /datum/species/jelly/luminescent))
#define iszombie(A) (is_species(A, /datum/species/zombie))
#define ishumanbasic(A) (is_species(A, /datum/species/human))
#define iscatperson(A) (ishumanbasic(A) && istype(A.dna.species, /datum/species/human/felinid))
#define isdwarf(A) (is_species(A, /datum/species/dwarf))
#define isdullahan(A) (is_species(A, /datum/species/dullahan))
#define isangel(A) (is_species(A, /datum/species/angel))
#define isvampire(A) (is_species(A, /datum/species/vampire))
#define ismush(A) (is_species(A, /datum/species/mush))
#define isshadow(A) (is_species(A, /datum/species/shadow))	
#define isskeleton(A) (is_species(A, /datum/species/skeleton))
#define isrobotic(A) (is_species(A, /datum/species/synthfurry/ipc) || is_species(A, /datum/species/synthfurry) || is_species(A, /datum/species/adapted) || is_species(/datum/species/synth) || is_species(/datum/species/android))
#define isethereal(A) (is_species(A, /datum/species/ethereal))

// Citadel specific species
#define isipcperson(A) (is_species(A, /datum/species/synthfurry/ipc))
#define issynthliz(A) (is_species(A, /datum/species/synthfurry))
#define ismammal(A) (is_species(A, /datum/species/mammal))
#define isinsect(A) (is_species(A, /datum/species/insect))
#define isxenoperson(A) (is_species(A, /datum/species/xeno))
#define isstartjelly(A) (is_species(A, /datum/species/jelly/roundstartslime))

// Fallout specific species
#define isghoul(A) (is_species(A, /datum/species/ghoul))
//#define isghoul(A) (is_species(A, /datum/species/ghoul/glowing))
//#definte issmutant(A) (is_pecies(A, /datum/species/smutant))

//more carbon mobs
#define ismonkey(A) (istype(A, /mob/living/carbon/monkey))

#define isalien(A) (istype(A, /mob/living/carbon/alien))

#define islarva(A) (istype(A, /mob/living/carbon/alien/larva))

#define isalienadult(A) (istype(A, /mob/living/carbon/alien/humanoid) || istype(A, /mob/living/simple_animal/hostile/alien))

#define isalienhunter(A) (istype(A, /mob/living/carbon/alien/humanoid/hunter))

#define isaliensentinel(A) (istype(A, /mob/living/carbon/alien/humanoid/sentinel))

#define isalienroyal(A) (istype(A, /mob/living/carbon/alien/humanoid/royal))

#define isalienqueen(A) (istype(A, /mob/living/carbon/alien/humanoid/royal/queen))

#define isdevil(A) (istype(A, /mob/living/carbon/true_devil))

//Silicon mobs
#define issilicon(A) (istype(A, /mob/living/silicon))

#define issiliconoradminghost(A) (istype(A, /mob/living/silicon) || IsAdminGhost(A))

#define iscyborg(A) (istype(A, /mob/living/silicon/robot))

#define isAI(A) (istype(A, /mob/living/silicon/ai))

#define ispAI(A) (istype(A, /mob/living/silicon/pai))

//Simple animals
#define isanimal(A) (istype(A, /mob/living/simple_animal))

#define isrevenant(A) (istype(A, /mob/living/simple_animal/revenant))

#define isbot(A) (istype(A, /mob/living/simple_animal/bot))

#define isshade(A) (istype(A, /mob/living/simple_animal/shade))

#define ismouse(A) (istype(A, /mob/living/simple_animal/mouse))

#define iscow(A) (istype(A, /mob/living/simple_animal/cow))

#define isslime(A) (istype(A, /mob/living/simple_animal/slime))

#define isdrone(A) (istype(A, /mob/living/simple_animal/drone))

#define iscat(A) (istype(A, /mob/living/simple_animal/pet/cat))

#define isdog(A) (istype(A, /mob/living/simple_animal/pet/dog))

#define iscorgi(A) (istype(A, /mob/living/simple_animal/pet/dog/corgi))

#define ishostile(A) (istype(A, /mob/living/simple_animal/hostile))

#define isswarmer(A) (istype(A, /mob/living/simple_animal/hostile/swarmer))

#define isguardian(A) (istype(A, /mob/living/simple_animal/hostile/guardian))

#define isclockmob(A) (istype(A, /mob/living/simple_animal/hostile/clockwork))

#define isconstruct(A) (istype(A, /mob/living/simple_animal/hostile/construct))

#define ismegafauna(A) (istype(A, /mob/living/simple_animal/hostile/megafauna))
#define isdummy(A) (istype(A, /mob/living/carbon/human/dummy))

//Misc mobs
#define isobserver(A) (istype(A, /mob/dead/observer))

#define isdead(A) (istype(A, /mob/dead))

#define isnewplayer(A) (istype(A, /mob/dead/new_player))

#define isovermind(A) (istype(A, /mob/camera/blob))

#define iscameramob(A) (istype(A, /mob/camera))

#define isaicamera(A) (istype(A, /mob/camera/aiEye))

#define iseminence(A) (istype(A, /mob/camera/eminence))

//Footstep helpers
#define isshoefoot(A) (is_type_in_typecache(A, GLOB.shoefootmob))

#define isclawfoot(A) (is_type_in_typecache(A, GLOB.clawfootmob))

#define isbarefoot(A) (is_type_in_typecache(A, GLOB.barefootmob))

#define isheavyfoot(A) (is_type_in_typecache(A, GLOB.heavyfootmob))

//Objects
#define isobj(A) istype(A, /obj) //override the byond proc because it returns true on children of /atom/movable that aren't objs

#define ismovableatom(A) istype(A, /atom/movable)

#define isitem(A) (istype(A, /obj/item))

#define isgrenade(A) (istype(A, /obj/item/grenade))

#define islandmine(A) (istype(A, /obj/item/mine))

#define isammocasing(A) (istype(A, /obj/item/ammo_casing))

#define isidcard(I) (istype(I, /obj/item/card/id))

#define isstructure(A) (istype(A, /obj/structure))

#define ismachinery(A) (istype(A, /obj/machinery))

#define ismecha(A) (istype(A, /obj/mecha))

#define is_cleanable(A) (istype(A, /obj/effect/decal/cleanable) || istype(A, /obj/effect/rune)) //if something is cleanable

#define isorgan(A) (istype(A, /obj/item/organ))

#define isclothing(A) (istype(A, /obj/item/clothing))

#define isbodypart(A) (istype(A, /obj/item/bodypart))

#define isprojectile(A) (istype(A, /obj/item/projectile))

#define isgun(A) (istype(A, /obj/item/gun))

#define isballistic(A) (istype(A, /obj/item/gun/ballistic))

#define isammobox(A) (istype(A, /obj/item/ammo_box))

#define isfood(A) (istype(A, /obj/item/reagent_containers/food/snacks))

//Assemblies
#define isassembly(O) (istype(O, /obj/item/assembly))

#define isigniter(O) (istype(O, /obj/item/assembly/igniter))

#define isprox(O) (istype(O, /obj/item/assembly/prox_sensor))

#define issignaler(O) (istype(O, /obj/item/assembly/signaler))

GLOBAL_LIST_INIT(glass_sheet_types, typecacheof(list(
	/obj/item/stack/sheet/glass,
	/obj/item/stack/sheet/rglass,
	/obj/item/stack/sheet/plasmaglass,
	/obj/item/stack/sheet/plasmarglass,
	/obj/item/stack/sheet/titaniumglass,
	/obj/item/stack/sheet/plastitaniumglass)))

#define is_glass_sheet(O) (is_type_in_typecache(O, GLOB.glass_sheet_types))

#define iseffect(O) (istype(O, /obj/effect))

#define isblobmonster(O) (istype(O, /mob/living/simple_animal/hostile/blob))

#define isshuttleturf(T) (length(T.baseturfs) && (/turf/baseturf_skipover/shuttle in T.baseturfs))


#define isfinite(n) (isnum(n) && n == n)

#define isclient(A) istype(A, /client)

//F13 EDIT
#define iskey(A) istype(A, /obj/item/key)

#define isProbablyWallMounted(O) (O.pixel_x > 20 || O.pixel_x < -20 || O.pixel_y > 20 || O.pixel_y < -20)

#define isbook(O) (is_type_in_typecache(O, GLOB.book_types))

#define islock(A) istype(A, /obj/item/lock_construct)

#define isnottriggermine(A) istype(A, /obj/effect/abstract)	// Affects obj/effect/mine, add anything needed

GLOBAL_LIST_INIT(simplemobs_wildlife, typecacheof(list(
	/mob/living/simple_animal/hostile/gecko,
	/mob/living/simple_animal/hostile/stalker,
	/mob/living/simple_animal/hostile/stalkeryoung,
	/mob/living/simple_animal/hostile/molerat,
	/mob/living/simple_animal/hostile/centaur,
	/mob/living/simple_animal/hostile/abomination,
	/mob/living/simple_animal/hostile/aethergiest,
	/mob/living/simple_animal/hostile/ghoul,
	/mob/living/simple_animal/hostile/giantant,
	/mob/living/simple_animal/hostile/fireant,
	/mob/living/simple_animal/hostile/giantantqueen,
	/mob/living/simple_animal/hostile/radscorpion,
	/mob/living/simple_animal/hostile/rat,
	/mob/living/simple_animal/hostile/regalrat,
	/mob/living/simple_animal/hostile/carp,
	/mob/living/simple_animal/hostile/cazador,
	/mob/living/simple_animal/hostile/bloatfly,
	/mob/living/simple_animal/hostile/pillbug,
	/mob/living/simple_animal/hostile/mirelurk,
	/mob/living/simple_animal/hostile/bear/yaoguai,
	/mob/living/simple_animal/hostile/trog,
	/mob/living/simple_animal/hostile/wolf
	)))

GLOBAL_LIST_INIT(simplemobs_animals, typecacheof(list(
	/mob/living/simple_animal/hostile/gecko,
	/mob/living/simple_animal/hostile/stalker,
	/mob/living/simple_animal/hostile/stalkeryoung,
	/mob/living/simple_animal/hostile/molerat,
	/mob/living/simple_animal/hostile/centaur,
	/mob/living/simple_animal/hostile/abomination,
	/mob/living/simple_animal/hostile/aethergiest,
	/mob/living/simple_animal/hostile/rat,
	/mob/living/simple_animal/hostile/regalrat,
	/mob/living/simple_animal/hostile/carp,
	/mob/living/simple_animal/hostile/mirelurk,
	/mob/living/simple_animal/hostile/bear/yaoguai,
	/mob/living/simple_animal/hostile/trog,
	/mob/living/simple_animal/hostile/wolf
	)))


GLOBAL_LIST_INIT(simplemobs_insects, typecacheof(list(
	/mob/living/simple_animal/hostile/giantant,
	/mob/living/simple_animal/hostile/fireant,
	/mob/living/simple_animal/hostile/giantantqueen,
	/mob/living/simple_animal/hostile/radscorpion,
	/mob/living/simple_animal/hostile/cazador,
	/mob/living/simple_animal/hostile/bloatfly,
	/mob/living/simple_animal/hostile/pillbug,
	)))


GLOBAL_LIST_INIT(simplemobs_humanlike, typecacheof(list(
	/mob/living/simple_animal/hostile/chinese,
	/mob/living/simple_animal/hostile/vault,
	/mob/living/simple_animal/hostile/enclave,
	/mob/living/simple_animal/hostile/bs,
	/mob/living/simple_animal/hostile/ncr,
	/mob/living/simple_animal/hostile/legion,
	/mob/living/simple_animal/hostile/tribe,
	/mob/living/simple_animal/hostile/raider,
	/mob/living/simple_animal/hostile/supermutant,
	/mob/living/simple_animal/hostile/renegade,
	/mob/living/simple_animal/hostile/ghoul,
	)))

GLOBAL_LIST_INIT(simplemobs_robots, typecacheof(list(
	/mob/living/simple_animal/hostile/eyebot,
	/mob/living/simple_animal/hostile/securitron,
	/mob/living/simple_animal/hostile/handy,
	/mob/living/simple_animal/bot
	)))

#define issimplewildlife(A) (A.type in GLOB.simplemobs_wildlife)

#define issimpleanimalmob(A) (A.type in GLOB.simplemobs_animals)

#define issimpleinsect(A) (A.type in GLOB.simplemobs_insects)

#define issimplehumanlike(A) (A.type in GLOB.simplemobs_humanlike)

#define issimplerobot(A) (A.type in GLOB.simplemobs_robots)

#define isadvancedmob(A) istype(A, /mob/living/simple_animal/advanced)

#define isnest(A) SEND_SIGNAL(A, COMSIG_IS_IT_A_NEST)
