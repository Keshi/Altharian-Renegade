//::///////////////////////////////////////////////
//:: FileName chk_creditchip
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/16/2005 10:45:49 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "jds_creditchip"))
        return FALSE;

    return TRUE;
}
