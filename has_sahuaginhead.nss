//::///////////////////////////////////////////////
//:: FileName has_sahuaginhead
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/29/2005 12:03:06 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "sahuaginhead"))
		return FALSE;

	return TRUE;
}
