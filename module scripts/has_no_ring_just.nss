//::///////////////////////////////////////////////
//:: FileName has_no_ring_just
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/2/2005 9:06:48 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "just_ring_01"))
        return FALSE;
    if(HasItem(GetPCSpeaker(), "just_ring_02"))
        return FALSE;
    if(HasItem(GetPCSpeaker(), "just_ring_03"))
        return FALSE;
    if(HasItem(GetPCSpeaker(), "just_ring_04"))
        return FALSE;
    if(HasItem(GetPCSpeaker(), "just_ring_05"))
        return FALSE;

    return TRUE;
}
