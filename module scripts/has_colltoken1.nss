//::///////////////////////////////////////////////
//:: FileName has_swampcatgem
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 4/30/2006 12:49:49 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "coll_token001"))
        return FALSE;

    return TRUE;
}
