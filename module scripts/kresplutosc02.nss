//::///////////////////////////////////////////////
//:: FileName kresplutosc02
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 4/22/2007 4:12:19 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "kres_boatpass"))
        return FALSE;

    return TRUE;
}
