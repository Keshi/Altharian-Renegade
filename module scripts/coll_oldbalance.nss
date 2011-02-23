//::///////////////////////////////////////////////
//:: FileName coll_oldbalance
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 5/22/2006 12:07:32 AM
//:://////////////////////////////////////////////


int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int nTokens = GetCampaignInt("Collector","CollectorTally",oPC);
  if (nTokens>=1) return TRUE;
  nTokens = GetCampaignInt("Rift","RiftCollector",oPC);
  if (nTokens>=1) return TRUE;
  nTokens = GetCampaignInt("Abyss","AbyssCollector",oPC);
  if (nTokens>=1) return TRUE;
  nTokens = GetCampaignInt("Bone","BoneCollector",oPC);
  if (nTokens>=1) return TRUE;

  return FALSE;
}
