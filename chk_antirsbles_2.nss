//::///////////////////////////////////////////////
//:: FileName chk_antirsbles_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/29/2005 12:45:39 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "antirsbles_2"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "jehonmalediction"))
        return TRUE;
    return FALSE;
}
