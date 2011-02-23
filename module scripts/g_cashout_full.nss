/////::///////////////////////////////////////////
/////:: g_cashout Script
/////:: Written by Winterknight for Altharia
/////:: Converts remaining old guardian paths to resources
/////::///////////////////////////////////////////

void DoCashout(object oPC, string sGuard, int nLevel)
{
  int nCash,nColl,nMith;

  if (nLevel == 1)
  {
    nCash = 500000;
  }
  if (nLevel == 2)
  {
    nCash = 1000000;
    nColl = 25;
    nMith = 100;
  }
  if (nLevel == 3)
  {
    nCash = 1000000;
    nColl = 75;
    nMith = 300;
  }
  if (nLevel == 4)
  {
    nCash = 1000000;
    nColl = 175;
    nMith = 800;
  }
  if (nLevel == 5)
  {
    nCash = 11000000;
    nColl = 175;
    nMith = 800;
  }
  if (nLevel == 6)
  {
    nCash = 31000000;
    nColl = 175;
    nMith = 800;
  }

  SetCampaignInt("Character",sGuard,0,oPC);
  GiveGoldToCreature(oPC,nCash);
  if (nLevel > 1)
  {
    SendMessageToPC(oPC,"Mithril Count increased by: "+IntToString(nMith));
    SendMessageToPC(oPC,"Collector Count increased by: "+IntToString(nColl));
    int StartColl = GetCampaignInt("Collector","CollectorTally",oPC);
    int StartMith = GetCampaignInt("12Dark2","mithril",oPC);
    nColl = nColl + StartColl;
    nMith = nMith + StartMith;
    SetCampaignInt("Collector","CollectorTally",nColl,oPC);
    SetCampaignInt("12Dark2","mithril",nMith,oPC);
  }
}


void main()
{
  object oPC = GetPCSpeaker();
  string sCurrent;
  int nLevel;

  sCurrent = "fulminate";
  nLevel = GetCampaignInt("Character",sCurrent,oPC);
  if (nLevel > 0) DoCashout(oPC,sCurrent,nLevel);

  sCurrent = "vesperbel";
  nLevel = GetCampaignInt("Character",sCurrent,oPC);
  if (nLevel > 0) DoCashout(oPC,sCurrent,nLevel);

  sCurrent = "harmonics";
  nLevel = GetCampaignInt("Character",sCurrent,oPC);
  if (nLevel > 0) DoCashout(oPC,sCurrent,nLevel);

  sCurrent = "magestaff";
  nLevel = GetCampaignInt("Character",sCurrent,oPC);
  if (nLevel > 0) DoCashout(oPC,sCurrent,nLevel);

  sCurrent = "innerpath";
  nLevel = GetCampaignInt("Character",sCurrent,oPC);
  if (nLevel > 0) DoCashout(oPC,sCurrent,nLevel);

  sCurrent = "stilletto";
  nLevel = GetCampaignInt("Character",sCurrent,oPC);
  if (nLevel > 0) DoCashout(oPC,sCurrent,nLevel);

  sCurrent = "whitegold";
  nLevel = GetCampaignInt("Character",sCurrent,oPC);
  if (nLevel > 0) DoCashout(oPC,sCurrent,nLevel);


}
