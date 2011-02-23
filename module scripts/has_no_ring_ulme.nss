//::///////////////////////////////////////////////
//:: FileName has_no_ring_ulme
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/2/2005 9:06:48 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "ulme_ring_01"))
        return FALSE;
    if(HasItem(GetPCSpeaker(), "ulme_ring_02"))
        return FALSE;
    if(HasItem(GetPCSpeaker(), "ulme_ring_03"))
        return FALSE;
    if(HasItem(GetPCSpeaker(), "ulme_ring_04"))
        return FALSE;
    if(HasItem(GetPCSpeaker(), "ulme_ring_05"))
        return FALSE;

    return TRUE;
}
