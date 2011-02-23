//::///////////////////////////////////////////////
//:: FileName chk_phaeganbls_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/30/2005 11:16:07 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "phaeganndalsb_2"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "jehonbenediction"))
        return TRUE;

    return FALSE;
}
