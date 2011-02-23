/////:://///////////////////////////////////////////////////////////////////////
/////:: Collector scripts - token and variables
/////:: Written by Winterknight - 4/29/06
/////:://///////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  int nTokens = GetCampaignInt("Collector","CollectorTally",oPC);

  string sTokens = IntToString(nTokens);
  SetCustomToken(107,sTokens);

}
