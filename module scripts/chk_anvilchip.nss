//::///////////////////////////////////////////////
//:: FileName chk_anvilchip
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/2/2005 4:40:58 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "dg_craftguide1"))
        return FALSE;

    return TRUE;
}
