//::///////////////////////////////////////////////
//:: FileName sc_haseldernode
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/11/2005 11:45:07 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "nodestone_elderkind"))
		return FALSE;

	return TRUE;
}
