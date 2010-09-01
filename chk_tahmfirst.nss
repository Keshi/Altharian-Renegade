//::///////////////////////////////////////////////
//:: FileName chk_ahramstok_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/28/2005 10:37:55 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "ahramstok_1") &
       !HasItem(GetPCSpeaker(),"tahmtoken_1"))
        return TRUE;

    return FALSE;
}
