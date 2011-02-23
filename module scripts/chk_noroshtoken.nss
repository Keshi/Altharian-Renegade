//::///////////////////////////////////////////////
//:: FileName chk_roshantoken
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/12/2005 8:39:38 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "dg_craftguide2"))
        return FALSE;

    return TRUE;
}
