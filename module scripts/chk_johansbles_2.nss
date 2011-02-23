//::///////////////////////////////////////////////
//:: FileName chk_johansbles_2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/2/2005 9:07:07 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "johansbles_2"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "jehonbenediction"))
        return FALSE;
    return TRUE;
}
