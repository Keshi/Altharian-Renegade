


int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int nCost;
  int nGet;
  string sColl = GetLocalString(oPC,"MAST_COLLECT");
  nGet = GetCampaignInt("Collector","CollectorTally",oPC);
  nCost = GetLocalInt(oPC,"MAST_COLLCOST");
  if (nCost == 0)
    {
      string sItem = GetLocalString(oPC,"MAST_STRING");
      string sMod = GetLocalString(oPC,"MAST_MOD");
      SendMessageToAllDMs("Collector is still broken.  Giving stuff away for free.");
      SendMessageToAllDMs("Debug: Item string is: "+sItem+sMod);
      SendMessageToAllDMs("Debug: Collector is: "+sColl);
      SendMessageToAllDMs("Debug: Cost is: "+IntToString(nCost));
      SendMessageToAllDMs("Debug: Points Available: "+IntToString(nGet));
      SendMessageToPC(oPC,"Something is wrong. Collector cost is set to zero. Process aborted.");
      return TRUE;
    }
  if (nGet >= nCost) return FALSE;
  return TRUE;
}
