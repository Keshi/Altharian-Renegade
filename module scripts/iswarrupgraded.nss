int StartingConditional()
{
  object oPC = GetPCSpeaker();
  string sTag = "fulminate";
  if (GetCampaignInt("Character",sTag,oPC)>=1)
        return TRUE;

    return FALSE;
}
