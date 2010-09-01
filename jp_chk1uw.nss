//::///////////////////////////////////////////////
//:: FileName jp_chk1uw
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 1/11/2006 2:26:08 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "ultimatewish"))
        return FALSE;

    return TRUE;
}
