//::///////////////////////////////////////////////
//:: FileName chk_daddygift
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/17/2005 12:31:23 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "jds_DaddysGift"))
		return FALSE;

	return TRUE;
}
