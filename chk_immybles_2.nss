//::///////////////////////////////////////////////
//:: FileName chk_immybles_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/15/2005 10:55:24 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "imrahadelsbles_2"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "jehonmalediction"))
        return TRUE;
    return FALSE;
}
