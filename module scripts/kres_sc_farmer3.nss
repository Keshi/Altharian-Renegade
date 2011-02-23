//::///////////////////////////////////////////////
//:: FileName kres_sc_farmer3
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 5/19/2007 9:57:30 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "kres_slabobeef"))
		return FALSE;

	return TRUE;
}
