//::///////////////////////////////////////////////
//:: FileName chk_larscomplete
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/25/2005 10:12:10 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "heavyminerals"))
		return FALSE;
	if(!HasItem(GetPCSpeaker(), "millerseeds"))
		return FALSE;
	if(!HasItem(GetPCSpeaker(), "minekey"))
		return FALSE;

	return TRUE;
}
