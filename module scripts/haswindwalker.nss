//::///////////////////////////////////////////////
//:: FileName haswindwalker
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 3/14/2003 2:19:28 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    int nCount;
    object oPC=GetPCSpeaker();
    int nCheck = GetCampaignInt("altharia","DasBoot",oPC);
    if(nCheck == 1) nCount++;

    nCheck = GetCampaignInt("altharia","DasCloak",oPC);
    if(nCheck == 1) nCount++;

    nCheck = GetCampaignInt("altharia","DasBelt",oPC);
    if(nCheck == 1) nCount++;

    nCheck = GetCampaignInt("altharia","DasBracer",oPC);
    if(nCheck == 1) nCount++;

    nCheck = GetCampaignInt("altharia","DasAmmy",oPC);
    if(nCheck == 1) nCount++;


    if(nCount >= 3) return TRUE;

    else if (nCount < 3)
    {
      SendMessageToPC(oPC,"You are missing "+IntToString(3-nCount)+" items.");
      return FALSE;
    }
    return FALSE;
}
