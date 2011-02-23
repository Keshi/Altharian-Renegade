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
    if(!HasItem(GetPCSpeaker(), "ahramsbles_2"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "antirsbles_2"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "coreksbles_2"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "halshorsbles_2"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "imrahadelsbles_2"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "johansbles_2"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "katayamoransb_2"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "larannasbles_2"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "phaeganndalsb_2"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "rechardsbles_2"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "sharthanisbles_2"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "urlecksbles_2"))
        return FALSE;

    return TRUE;
}
