//::///////////////////////////////////////////////
//:: FileName chk_unsignedretr
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/17/2005 7:52:01 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "unsignedretract"))
		return FALSE;

	return TRUE;
}
