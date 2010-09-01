//::///////////////////////////////////////////////
//:: FileName chk_antirtok_2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2/8/2006 9:01:07 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "antirstok_2"))
        return FALSE;
    if(HasItem(GetPCSpeaker(), "antirssextant"))
        return FALSE;

    return TRUE;
}
