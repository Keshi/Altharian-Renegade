//::///////////////////////////////////////////////
//:: FileName chk_deadhead
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/13/2005 8:35:23 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "deadcaptainshead"))
		return FALSE;

	return TRUE;
}
