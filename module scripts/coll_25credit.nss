//::///////////////////////////////////////////////
//:: FileName has_corsscrimsha
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 5/22/2006 12:07:32 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int nTokens = GetCampaignInt("Collector","CollectorTally",oPC);
  if (nTokens>=25) return TRUE;

  return FALSE;
}
