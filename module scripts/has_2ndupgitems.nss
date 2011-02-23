//::///////////////////////////////////////////////
//:: FileName has_2ndupgitems
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/7/2006 10:52:03 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

  object oPC = GetPCSpeaker();
  int nColl = GetCampaignInt("Collector","CollectorTally",oPC);
  int nMith = GetCampaignInt("12Dark2","mithril",oPC);
  if (nColl < 25) return FALSE;
  if (nMith < 100) return FALSE;

    return TRUE;
}
