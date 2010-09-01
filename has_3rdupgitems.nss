//::///////////////////////////////////////////////
//:: FileName has_3rdupgitems
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/7/2006 10:38:40 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int nColl = GetCampaignInt("Collector","CollectorTally",oPC);
  int nMith = GetCampaignInt("12Dark2","mithril",oPC);
  if (nColl < 50) return FALSE;
  if (nMith < 200) return FALSE;
    return TRUE;
}
