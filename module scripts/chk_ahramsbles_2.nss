//::///////////////////////////////////////////////
//:: FileName chk_ahramsbles_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/29/2005 12:45:02 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "ahramsbles_2"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "jehonbenediction"))
        return TRUE;
    return FALSE;
}
