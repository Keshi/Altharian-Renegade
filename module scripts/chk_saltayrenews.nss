//::///////////////////////////////////////////////
//:: FileName chk_saltayrenews
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/28/2005 11:08:05 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "saltayrenews"))
		return FALSE;

	return TRUE;
}
