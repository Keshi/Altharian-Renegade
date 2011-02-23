//::///////////////////////////////////////////////
//:: FileName chk_gholnodeston
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2/6/2005 4:54:51 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "nodestone_elderkind"))
        return FALSE;

    return TRUE;
}
