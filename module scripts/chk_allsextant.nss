//::///////////////////////////////////////////////
//:: FileName chk_allsextant
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2/8/2006 9:51:44 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "antirspenant"))
		return FALSE;
	if(!HasItem(GetPCSpeaker(), "corsairsscrimsha"))
		return FALSE;
	if(!HasItem(GetPCSpeaker(), "timekeeperamulet"))
		return FALSE;

	return TRUE;
}
