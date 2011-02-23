//::///////////////////////////////////////////////
//:: FileName restring01
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2/9/2004 11:15:03 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "demongut"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "steel_04"))
        return FALSE;
    if(GetGold(GetPCSpeaker()) < 200000)
         return FALSE;


    return TRUE;
}
