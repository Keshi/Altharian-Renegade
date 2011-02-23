//::///////////////////////////////////////////////
//:: FileName chk_hasabysbook2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 12/4/2005 12:20:25 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "bookoftheabyss05"))
        return FALSE;

    return TRUE;
}
