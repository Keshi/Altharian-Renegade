//::///////////////////////////////////////////////
//:: FileName chk_demonsclawwe
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/17/2005 7:55:02 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "demonsclawwest"))
		return FALSE;

	return TRUE;
}
