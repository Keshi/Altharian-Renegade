//::///////////////////////////////////////////////
//:: FileName ith_deathsreward
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/23/2005 10:35:47 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "deathskull"))
		return FALSE;

	return TRUE;
}