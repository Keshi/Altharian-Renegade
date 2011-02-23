//::///////////////////////////////////////////////
//:: FileName chk_antirpenant
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2/8/2006 10:48:38 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "antirspenant"))
        return TRUE;

    return FALSE;
}
