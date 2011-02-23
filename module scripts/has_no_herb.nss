//::///////////////////////////////////////////////
//:: FileName has_rat_skin
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 3/18/2003 2:05:05 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "whiteherb"))
        return FALSE;

    return TRUE;
}
