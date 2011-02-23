//::///////////////////////////////////////////////
//:: FileName chk_allsaintsb_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 12/28/2005 12:23:36 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "ahramsbles_1"))
		return FALSE;
	if(!HasItem(GetPCSpeaker(), "antirsbles_1"))
		return FALSE;
	if(!HasItem(GetPCSpeaker(), "coreksbles_1"))
		return FALSE;
	if(!HasItem(GetPCSpeaker(), "halshorsbles_1"))
		return FALSE;
	if(!HasItem(GetPCSpeaker(), "imrahadelsbles_1"))
		return FALSE;
	if(!HasItem(GetPCSpeaker(), "johansbles_1"))
		return FALSE;
	if(!HasItem(GetPCSpeaker(), "katayamoransb_1"))
		return FALSE;
	if(!HasItem(GetPCSpeaker(), "larannasbles_1"))
		return FALSE;
	if(!HasItem(GetPCSpeaker(), "phaeganndalsb_1"))
		return FALSE;
	if(!HasItem(GetPCSpeaker(), "rechardsbles_1"))
		return FALSE;
	if(!HasItem(GetPCSpeaker(), "sharthanisbles_1"))
		return FALSE;
	if(!HasItem(GetPCSpeaker(), "urlecksbles_1"))
		return FALSE;

	return TRUE;
}
