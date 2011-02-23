/////:://///////////////////////////////////////////////////////////////////////
/////:: Collector scripts - grip and rip
/////:: Written by Winterknight - 5/22/06
/////:://///////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  int nTokens = GetCampaignInt("Collector","CollectorTally",oPC);

  string sItem = "ultimatewish";
  CreateItemOnObject(sItem,oPC,1);
  SetCampaignInt("Collector","CollectorTally",nTokens - 50,oPC);

}
