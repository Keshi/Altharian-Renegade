/////::///////////////////////////////////////////
/////:: g_convert Script
/////:: Written by Winterknight for Altharia
/////:: Converts current guardian path to new format
/////::///////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  string sCurrent = GetLocalString(oPC,"actitem");
  int nLevel = GetCampaignInt("Character",sCurrent,oPC);

  SetCampaignInt("Character",sCurrent,0,oPC);
  SetCampaignString("Character","guardianpath",sCurrent,oPC);
  SetCampaignInt("Character","guardlevel",nLevel,oPC);

}
