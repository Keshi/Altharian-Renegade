//::///////////////////////////////////////////////
//:: FileName chk_laranables_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/30/2005 9:36:16 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "urlecksbles_2"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "jehonmalediction"))
        return TRUE;
    return FALSE;
}
