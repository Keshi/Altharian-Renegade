//::///////////////////////////////////////////////
//:: FileName HAS_ring_dash
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/2/2005 9:06:48 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "dash_ring_01"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "dash_ring_02"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "dash_ring_03"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "dash_ring_04"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "dash_ring_05"))
        return TRUE;

    return FALSE;
}
