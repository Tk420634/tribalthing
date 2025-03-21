/*
	These defines specificy screen locations.  For more information, see the byond documentation on the screen_loc var.

	The short version:

	Everything is encoded as strings because apparently that's how Byond rolls.

	"1,1" is the bottom left square of the user's screen.  This aligns perfectly with the turf grid.
	"1:2,3:4" is the square (1,3) with pixel offsets (+2, +4); slightly right and slightly above the turf grid.
	Pixel offsets are used so you don't perfectly hide the turf under them, that would be crappy.

	In addition, the keywords NORTH, SOUTH, EAST, WEST and CENTER can be used to represent their respective
	screen borders. NORTH-1, for example, is the row just below the upper edge. Useful if you want your
	UI to scale with screen size.

	The size of the user's screen is defined by client.view (indirectly by world.view), in our case "15x15".
	Therefore, the top right corner (except during admin shenanigans) is at "15,15"
*/

//Lower left, persistent menu
#define ui_inventory "WEST:6,SOUTH:3"

//Pop-up inventory

//top row
#define ui_head "WEST+1:8,SOUTH+3:11"
#define ui_glasses "WEST:6,SOUTH+3:11"
#define ui_ears "WEST+2:10,SOUTH+3:11"

//middle row
#define ui_neck "WEST:6,SOUTH+2:9"
#define ui_mask "WEST+1:8,SOUTH+2:9"
#define ui_gloves "WEST+2:10,SOUTH+2:9"

//bottom row
#define ui_oclothing "WEST+1:8,SOUTH+1:7"
#define ui_iclothing "WEST:6,SOUTH+1:7"
#define ui_shoes "WEST+2:10,SOUTH+1:7"

//Middle left indicators
#define ui_lingchemdisplay "WEST,CENTER-1:15"
#define ui_lingstingdisplay "WEST:6,CENTER-3:11"

#define ui_devilsouldisplay "WEST:6,CENTER-1:15"

//Lower center, persistent menu
#define ui_sstore1 "WEST+1:6,SOUTH:3" 
#define ui_id "WEST+2:3,SOUTH:3"
#define ui_belt "WEST+3:-1,SOUTH:3"
#define ui_back "WEST+6:-13,SOUTH:3" //backpack
#define ui_storage2 "WEST+4:-5,SOUTH:3" //left pocket
#define ui_storage1 "WEST+5:-9,SOUTH:3" //right pocket
#define ui_resistdelay "East-2:-4,SOUTH+0:36" //This is actually resist bar
#define ui_overridden_resist "East-2:-4,SOUTH+0:20" //this is the actual resist button
#define ui_combat_toggle "CENTER+3:4,SOUTH:2"
#define ui_zonesel "EAST-3:-5,SOUTH:3"
#define ui_crafting	"WEST+6:-15,SOUTH+1:1"

#define ui_building "WEST+5:1,SOUTH+1:1"
#define ui_language_menu "WEST+5:1,SOUTH+1:1"


//Right side near hands
#define ui_wield "CENTER+1:17,SOUTH:4"
#define ui_acti "CENTER+2:3,SOUTH:3"
#define ui_pull_resist "East-2:-4,SOUTH+0:4" //THIS IS ACTUALLY THE REST BUTTON?  WHAT THE FUCK? ~TK
#define ui_drop_throw "East-1:-4,SOUTH+0:4"
#define ui_sprintbufferloc "East-0:-4,SOUTH:18" //buffer orbs
#define ui_movi "East-0:-4,SOUTH:4"
//#define ui_zonesel "Center+5:2,SOUTH:3:1"
#define ui_mood 	"Center-1:5,South+1:11"
#define ui_healthdoll 	"EAST-3:-7,SOUTH+1:17"
#define ui_banking "WEST+5:-11,SOUTH+1:-7"
#define ui_health 	"Right-3:28,South+2:-18"
#define ui_stamina "Right-2:27,South+1:+3" // replacing internals button
#define ui_questbook "EAST-3:-4,SOUTH+2:0"
#define ui_questscanner "EAST-3:4,SOUTH+2:13"
#define ui_pull_stop "CENTER+2:-4,SOUTH+1:+1"

/proc/ui_hand_position(i) //values based on old hand ui positions (CENTER:-/+16,SOUTH:5)
	var/x_off = -(!(i % 2))
	var/y_off = round((i-1) / 2)
	return"CENTER+[x_off]:16,SOUTH+[y_off]:3"

/proc/ui_equip_position(mob/M)
	var/y_off = round((M.held_items.len-1) / 2) //values based on old equip ui position (CENTER: +/-16,SOUTH+1:5)
	return "CENTER:-16,SOUTH+[y_off+1]:3"

/proc/ui_swaphand_position(mob/M, which = 1) //values based on old swaphand ui positions (CENTER: +/-16,SOUTH+1:5)
	var/x_off = which == 1 ? -1 : 0
	var/y_off = round((M.held_items.len-1) / 2)
	return "CENTER+[x_off]:16,SOUTH+[y_off+1]:3"


//Totally unused
#define ui_borg_sensor "CENTER-3:15, SOUTH:5"		//borgs
#define ui_borg_lamp "CENTER-4:15, SOUTH:5"			//borgs
#define ui_borg_thrusters "CENTER-5:15, SOUTH:5"	//borgs
#define ui_inv1 "CENTER-2:16,SOUTH:5"				//borgs
#define ui_inv2 "CENTER-1  :16,SOUTH:5"				//borgs
#define ui_inv3 "CENTER  :16,SOUTH:5"				//borgs
#define ui_borg_module "CENTER+1:16,SOUTH:5"		//borgs
#define ui_borg_store "CENTER+2:16,SOUTH:5"			//borgs
#define ui_borg_camera "CENTER+3:21,SOUTH:5"		//borgs
#define ui_borg_album "CENTER+4:21,SOUTH:5"			//borgs
#define ui_borg_language_menu "EAST-1:27,SOUTH+2:8"	//borgs

#define ui_monkey_head "CENTER-5:13,SOUTH:5"	//monkey
#define ui_monkey_mask "CENTER-4:14,SOUTH:5"	//monkey
#define ui_monkey_neck "CENTER-3:15,SOUTH:5"	//monkey
#define ui_monkey_back "CENTER-2:16,SOUTH:5"	//monkey

//#define ui_alien_storage_l "CENTER-2:14,SOUTH:5"//alien
#define ui_alien_storage_r "CENTER+1:18,SOUTH:5"//alien
#define ui_alien_language_menu "EAST-3:26,SOUTH:5" //alien

#define ui_drone_drop "CENTER+1:18,SOUTH:5"     //maintenance drones
#define ui_drone_pull "CENTER+2:2,SOUTH:5"      //maintenance drones
#define ui_drone_storage "CENTER-2:14,SOUTH:5"  //maintenance drones
#define ui_drone_head "CENTER-3:14,SOUTH:5"     //maintenance drones

//Lower right, persistent menu






#define ui_acti_alt "EAST-1:28,SOUTH:5"	//alternative intent switcher for when the interface is hidden (F12)


#define ui_borg_pull "EAST-2:26,SOUTH+1:7"
#define ui_borg_radio "EAST-1:28,SOUTH+1:7"
#define ui_borg_intents "EAST-2:26,SOUTH:5"


//Upper-middle right (alerts)
#define ui_alert1 "EAST-1:28,CENTER+5:27"
#define ui_alert2 "EAST-1:28,CENTER+4:25"
#define ui_alert3 "EAST-1:28,CENTER+3:23"
#define ui_alert4 "EAST-1:28,CENTER+2:21"
#define ui_alert5 "EAST-1:28,CENTER+1:19"


//Middle right (status indicators)
#define ui_internal 			"EAST-1:28,		SOUTH+3:11"//CIT CHANGE - moves internal icon up a little bit to accommodate for the stamina meter

#define ui_character_actions	"EAST-1:28, SOUTH+1:2"
#define ui_bayou				"EAST-1:28, SOUTH+0:2" //Character directory
#define ui_pvpbuttons			"EAST-1:28, SOUTH+1:18" //slut directory
#define ui_flirt			"EAST-1:28, SOUTH+2:0" //slut directory
#define ui_merp			"EAST-1:4, SOUTH+2:0" //slut directory
#define ui_vore			"EAST-1:-11, SOUTH+2:12" //slut directory
// #define ui_vore_b1		"EAST-1:4, SOUTH+2:7" //slut directory
// #define ui_vore_b2		"EAST-1:4, SOUTH+2:18" //slut directory
// #define ui_vore_b3		"EAST-1:4, SOUTH+2:29" //slut directory
#define ui_touch			"EAST-1:28, SOUTH+2:-4" //slut directory
#define ui_lick			"EAST-1:28, SOUTH+3:-10" //slut directory
#define ui_kiss			"EAST-1:28, SOUTH+3:-14" //slut directory

//living
#define ui_living_pull "EAST-1:28,CENTER-2:15"
#define ui_living_health "Right-3:28,South+2:-18"

//borgs
#define ui_borg_health "EAST-1:28,CENTER-1:15"		//borgs have the health display where humans have the pressure damage indicator.

//aliens
#define ui_alien_health "EAST,CENTER-1:15"	//aliens have the health display where humans have the pressure damage indicator.
#define ui_alienplasmadisplay "EAST,CENTER-2:15"
#define ui_alien_queen_finder "EAST,CENTER-3:15"

//constructs
#define ui_construct_pull "EAST,CENTER-2:15"
#define ui_construct_health "EAST,CENTER:15"  //same as borgs and humans

// AI

#define ui_ai_core "SOUTH:6,WEST"
#define ui_ai_camera_list "SOUTH:6,WEST+1"
#define ui_ai_track_with_camera "SOUTH:6,WEST+2"
#define ui_ai_camera_light "SOUTH:6,WEST+3"
#define ui_ai_crew_monitor "SOUTH:6,WEST+4"
#define ui_ai_crew_manifest "SOUTH:6,WEST+5"
#define ui_ai_alerts "SOUTH:6,WEST+6"
#define ui_ai_announcement "SOUTH:6,WEST+7"
#define ui_ai_shuttle "SOUTH:6,WEST+8"
#define ui_ai_state_laws "SOUTH:6,WEST+9"
#define ui_ai_pda_send "SOUTH:6,WEST+10"
#define ui_ai_pda_log "SOUTH:6,WEST+11"
#define ui_ai_take_picture "SOUTH:6,WEST+12"
#define ui_ai_view_images "SOUTH:6,WEST+13"
#define ui_ai_sensor "SOUTH:6,WEST+14"
#define ui_ai_multicam "SOUTH+1:6,WEST+13"
#define ui_ai_add_multicam "SOUTH+1:6,WEST+14"


//Ghosts

#define ui_ghost_jumptomob      "SOUTH:6,CENTER-3.25:24"		//Yes, I placed an offset of -0.25 on every define so everything is symmetrical, 
#define ui_ghost_orbit          "SOUTH:6,CENTER-2.25:24"		//you are free to remove it completely next time you need to add some new button.
#define ui_ghost_reenter_corpse "SOUTH:6,CENTER-1.25:24"		//Don't send me a pipebomb to my house, thank you.
#define ui_ghost_teleport       "SOUTH:6,CENTER-0.25:24"
#define ui_ghost_spawners       "SOUTH:6,CENTER+0.75:24"
#define ui_ghost_second_wind    "SOUTH:38,CENTER-1.25:24"
#define ui_ghost_char_dir    "SOUTH:38,CENTER-2.25:24"
#define ui_ghost_move_up       	"SOUTH:6,CENTER+1.75:24"
#define ui_ghost_move_down      "SOUTH:6,CENTER+1.75:24"


#define ui_questbook_overridden "EAST-3:24,SOUTH+1:7"
#define ui_clickdelay "CENTER,SOUTH+1:-31"



#define ui_boxcraft "EAST-4:24,SOUTH+1:6"
#define ui_boxarea "EAST-4:6,SOUTH+1:6"
#define ui_boxlang "EAST-5:22,SOUTH+1:6"
