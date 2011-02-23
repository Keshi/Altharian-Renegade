//::///////////////////////////////////////////////
//:: FileName chk_johantoken
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/17/2005 12:59:26 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "johansbles_1"))
        return FALSE;

    return TRUE;
}
