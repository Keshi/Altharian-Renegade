//::///////////////////////////////////////////////
//:: FileName check_stoneabyss
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/8/2006 7:16:19 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "nodestone_abyss"))
		return FALSE;

	return TRUE;
}
