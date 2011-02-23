//::///////////////////////////////////////////////
//:: FileName chk_tahmtoken_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/28/2005 10:38:56 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "tahmtoken_2"))
        return FALSE;

    return TRUE;
}
