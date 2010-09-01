/////::///////////////////////////////////////////
/////:: LootShare Script
/////:: Written by Winterknight for Altharia 5/21/07
/////::///////////////////////////////////////////

void DivvyUpLoot (object oKiller, int nShare, int nCheck)
{
  location lKiller = GetLocation(oKiller);
  int nValid;
  object oPartner = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, lKiller, TRUE);
  while (GetIsObjectValid(oPartner))
  {
    if (GetIsPC(oPartner))
    {
      nValid = GetLocalInt(oPartner,"LootShare");
      if (nValid > 1 && nValid == nCheck)
      {
        GiveGoldToCreature(oPartner,nShare);
        SendMessageToPC(oPartner,"Lootshare: "+IntToString(nShare));
      }
    }
    oPartner = GetNextObjectInShape(SHAPE_SPHERE, 20.0, lKiller, TRUE);
  }

}

int GetLootShare (object oKiller, int nGold, int nCheck)
{
  location lKiller = GetLocation(oKiller);
  int nValid;
  int nShare;
  int nCount = 0;
  object oPartner = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, lKiller, TRUE);
  while (GetIsObjectValid(oPartner))
  {
    if (GetIsPC(oPartner))
    {
      nValid = GetLocalInt(oPartner,"LootShare");
      if (nValid > 1 && nValid == nCheck)
      {
        nCount++;
      }
    }
    oPartner = GetNextObjectInShape(SHAPE_SPHERE, 20.0, lKiller, TRUE);
  }
  if (nCount < 1) nCount = 1;
  nShare = nGold / nCount;
  return nShare;
}

void main()
{
  object oPC = GetLastKiller();
  int nBounty = GetLocalInt(oPC,"Bounty");
  int nLootVar = GetLocalInt(oPC,"LootShare");
  if (nLootVar > 1)
  {
    int nCut = GetLootShare(oPC,nBounty,nLootVar);
    if (nCut < nBounty)
    {
      DivvyUpLoot(oPC,nCut,nLootVar);
    }
  }
  else if (nLootVar == 1)
  {
    GiveGoldToCreature(oPC,nBounty);
    SendMessageToPC(oPC,"Lootshare: "+IntToString(nBounty));
  }
  SetLocalInt(oPC,"Bounty",0);
}
