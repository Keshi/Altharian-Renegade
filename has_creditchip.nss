//::///////////////////////////////////////////////
//:: FileName has_creditchip
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/17/2005 12:18:51 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "jds_creditchip"))
        return FALSE;

    return TRUE;
}
