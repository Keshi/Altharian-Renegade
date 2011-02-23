/////:://////////////////////////////////////////////
/////:: Check for newbie eligibility
/////:: Created On: 10/8/2005 by Winterknight
/////:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nLevel = GetCampaignInt("Character","newbieweapon",oPC);

    // Make sure the PC speaker has these items in their inventory
    if(nLevel>2)
        return FALSE;

    return TRUE;
}
