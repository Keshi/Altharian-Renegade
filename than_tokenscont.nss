/////:://///////////////////////////////////////////////////////////////////////
/////:: Collector scripts - token and variables
/////:: Written by Winterknight - 4/29/06
/////:://///////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  int nTokens = GetCampaignInt("12Dark2","ThanwarCollector",oPC);
  string sTokens = IntToString(nTokens);
  SetCustomToken(107,sTokens);

}
