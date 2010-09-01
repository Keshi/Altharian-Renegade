//::///////////////////////////////////////////////
//:: FileName has_corsscrimsha
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 5/22/2006 12:07:32 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "corsairsscrimsha"))
		return FALSE;

	return TRUE;
}
