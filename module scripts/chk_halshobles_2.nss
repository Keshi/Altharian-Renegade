//::///////////////////////////////////////////////
//:: FileName chk_halshobles_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/28/2005 11:30:37 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "halshorsbles_2"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "jehonbenediction"))
        return TRUE;
    return FALSE;
}
