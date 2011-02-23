//::///////////////////////////////////////////////
//:: FileName has_firstupgrade
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/7/2006 9:49:39 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  string sTag = GetLocalString(oPC,"actitem");
  string sTag1 = sTag;
  int nLevel;
  if (sTag == "sackofdust")
  {
    nLevel = GetCampaignInt("Character",sTag,oPC);
    if (nLevel >=3) return TRUE;
  }
  if (sTag == "holysword") sTag1 = "vesperbel";
  string sGuard = GetCampaignString("Character","guardianpath",oPC);
  nLevel = GetCampaignInt("Character","guardlevel",oPC);
  if (sGuard == sTag1 & nLevel >= 3) return TRUE;

    return FALSE;
}
