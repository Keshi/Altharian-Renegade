/////:://///////////////////////////////////////////////////////////////////////
/////:: Collector scripts - grip and rip
/////:: Written by Winterknight - 5/22/06
/////:://///////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  object oItem = GetFirstItemInInventory(oPC);
  int nToTake = GetLocalInt(oPC,"TakeCount");
  int nMult = GetLocalInt(oPC,"CollectValue");
  int nToGive = 0;
  int nTokens = GetCampaignInt("Collector","CollectorTally",oPC);

  string sItem = GetLocalString(oPC,"CurrentItem");
  while (GetIsObjectValid(oItem))
    {
      if (GetTag(oItem)==sItem &&
          nToGive < nToTake)
      {
        DestroyObject(oItem,0.1);
        nToGive++;
      }
    oItem = GetNextItemInInventory(oPC);
    }
  SetCampaignInt("Collector","CollectorTally",nTokens + (nToGive * nMult),oPC);

}
