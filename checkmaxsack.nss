//::///////////////////////////////////////////////
//:: FileName checkforsack
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/27/2005 7:41:55 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    int nCheck = GetCampaignInt("Character","sackofdust",GetPCSpeaker());
    if(nCheck >= 4)
        return TRUE;

    return FALSE;
}
