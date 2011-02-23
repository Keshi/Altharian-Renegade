//::///////////////////////////////////////////////
//:: FileName chk_johanbles_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/25/2005 9:34:16 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "johansbles_1"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "jehonbless_1"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "jehonbless_1_1"))
        return TRUE;
    return FALSE;
}
