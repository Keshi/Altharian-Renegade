//::///////////////////////////////////////////////
//:: FileName kres_sc_farmer04
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 5/19/2007 9:59:39 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "kres_jugomilk"))
        return FALSE;

    return TRUE;
}
