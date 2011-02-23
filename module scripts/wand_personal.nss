/////Stat script for wand.
/////Done by WK, for Altharia
#include "wk_tools"

void main()
{
  object oPC = GetPCSpeaker();
  string sGuild = GetCurrentGuildName(oPC);
  int nMith = GetMithrilCount(oPC);
  string sRank = GetServerRank(oPC);
  int nLevel = GetEffectiveLevel(oPC);
  string sMith = IntToString(nMith);
  string sLevel = IntToString(nLevel);
  int nCollect = GetCampaignInt("Collector","CollectorTally",oPC);
  string sCollect = IntToString(nCollect);
  string sGuardian = GetCampaignString("Character","guardianpath",oPC);
  int nGuardRank = GetCampaignInt("Character","guardlevel",oPC);
  string sGuardRank = IntToString(nGuardRank);
  int nShare = GetLocalInt(oPC,"LootShare");
  string sShare = IntToString(nShare);
  int nLootLock = GetLocalInt(oPC,"LootLock");
  string sLock;
  if (nLootLock == 1) sLock = "Lootshare Locked";
  if (nLootLock < 1) sLock = "Lootshare unLocked";
  SendMessageToPC(oPC,"Current Guild: "+sGuild);
  SendMessageToPC(oPC,"Level: "+sLevel);
  SendMessageToPC(oPC,"Rank: "+sRank);
  SendMessageToPC(oPC,"Guardian Path: "+sGuardian);
  SendMessageToPC(oPC,"Guardian Rank: "+sGuardRank);
  SendMessageToPC(oPC,"Mithril Count: "+sMith);
  SendMessageToPC(oPC,"Collector Count: "+sCollect);
  SendMessageToPC(oPC,"Lootshare Var: "+sShare);
  SendMessageToPC(oPC,sLock);
}
