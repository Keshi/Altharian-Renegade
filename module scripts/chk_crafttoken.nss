//::///////////////////////////////////////////////
//:: FileName chk_crafttoken
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/4/2007 9:57:22 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "grcrafttoken"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "mcrafttoken"))
        return TRUE;

    return FALSE;
}
