//::///////////////////////////////////////////////
//:: FileName jp_chk1gw
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 1/11/2006 2:26:52 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "wish001"))
        return FALSE;

    return TRUE;
}
