//::///////////////////////////////////////////////
//:: FileName check_delnodesto
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2/6/2005 4:51:37 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "nodestone_abyss"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "combinednodes"))
        return TRUE;

   return FALSE;
}
