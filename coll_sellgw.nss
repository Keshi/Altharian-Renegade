/////:://///////////////////////////////////////////////////////////////////////
/////:: Collector scripts - grip and rip
/////:: Written by Winterknight - 5/22/06
/////:://///////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  int nTokens = GetCampaignInt("Collector","CollectorTally",oPC);

  string sItem = "wish001";
  CreateItemOnObject(sItem,oPC,1);
  SetCampaignInt("Collector","CollectorTally",nTokens - 25,oPC);

}
