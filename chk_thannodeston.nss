//::///////////////////////////////////////////////
//:: FileName chk_thannodeston
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2/6/2005 4:54:14 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory

    if(HasItem(GetPCSpeaker(), "nodestone_thanwa"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "combinednodes"))
        return TRUE;

   return FALSE;
}
