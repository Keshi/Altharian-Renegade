//::///////////////////////////////////////////////
//:: FileName has_2ndupgrade
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/7/2006 9:49:39 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  string sCheck = GetCampaignString("Character","guardianpath",oPC);
  string sTag = GetTag(OBJECT_SELF);
  int nGuard = GetCampaignInt("Character","guardlevel",oPC);
  if (sCheck == sTag & nGuard == 2) return TRUE;

  return FALSE;
}
