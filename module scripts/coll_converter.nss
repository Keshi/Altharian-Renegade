/////:://///////////////////////////////////////////////////////////////////////
/////:: Collector scripts - Convert
/////:: Written by Winterknight - 5/22/06
/////:://///////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  int nTokens = GetCampaignInt("Collector","CollectorTally",oPC);
  int nRift = GetCampaignInt("Rift","RiftCollector",oPC);
  int nAbyss = GetCampaignInt("Abyss","AbyssCollector",oPC);
  int nBone = GetCampaignInt("Bone","BoneCollector",oPC);
  int nThan = GetCampaignInt("12Dark2","ThanwarCollector",oPC);

  nTokens = nTokens+nRift+nAbyss+nBone+nThan;
  SetCampaignInt("Collector","CollectorTally",nTokens,oPC);
  SetCampaignInt("Rift","RiftCollector",0,oPC);
  SetCampaignInt("Abyss","AbyssCollector",0,oPC);
  SetCampaignInt("Bone","BoneCollector",0,oPC);
  SetCampaignInt("12Dark2","ThanwarCollector",0,oPC);
}
