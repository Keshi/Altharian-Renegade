/////::///////////////////////////////////////////
/////:: Recycling Lottery Script
/////:: Written by Winterknight for Altharia 10/21/07
/////::///////////////////////////////////////////

int GetGoldReturn(object oItem)
{
  int nMult = 10;
  int nGold = GetGoldPieceValue(oItem);
  if (GetStolenFlag(oItem) == TRUE) nMult = 1;
  nGold = (nGold * 1 * nMult / 100);
  return nGold;
}

void DoCollChips(object oPC, int nGold)
{
  int nColl = nGold / 200000;
  if (nColl < 0) nColl = 1;
  while (nColl > 5)
  {
    CreateItemOnObject("coll_token005",oPC,1);
    nColl = nColl - 5;
  }
  if (nColl > 0)
  {
    CreateItemOnObject("coll_token00"+IntToString(nColl), oPC, 1);
  }
}

void DoMithrilChips(object oPC, int nGold)
{
  int nMith = nGold / 10000;
  if (nMith < 0) nMith = 1;
  while (nMith > 5)
  {
    CreateItemOnObject("mithrilchip",oPC,1);
    nMith = nMith - 5;
  }
  if (nMith > 0 & nMith < 5)
  {
    CreateItemOnObject("mithrildust",oPC,nMith);
    nMith = 0;
  }
}

void TrashObject(object oObject)
{
    //debug(GetTag(oObject) + " is in trashobject");
    if (GetObjectType(oObject) == OBJECT_TYPE_PLACEABLE)
    {
      object oItem = GetFirstItemInInventory(oObject);
      while (GetIsObjectValid(oItem))
      {
        //debug(GetTag(oItem) + " is in trashobject");
        TrashObject(oItem);
        oItem = GetNextItemInInventory(oObject);
      }
    }
    //debug(GetTag(oObject) + " failed to pass as inventory type placeable is getting destroyed");
    AssignCommand(oObject, SetIsDestroyable(TRUE, FALSE, FALSE));
    DestroyObject(oObject);
}

void main()
{
  object oPC = GetLastUsedBy();
  object oBox = GetNearestObjectByTag("recyclelottery",OBJECT_SELF,1);
  object oItem = GetFirstItemInInventory(oBox);
  int nGold;
  int nDice;
  while (GetIsObjectValid(oItem))
  {
    nGold = GetGoldReturn(oItem);
    nDice = d20();
    if (nDice == 20)
    {
      nDice = d6();
      nGold = (nDice + 4) * nGold;
      nDice = d3();
      switch(nDice)
      {
        case 1: DoCollChips(oPC, nGold); TrashObject(oItem); break;
        case 2: GiveGoldToCreature(oPC, nGold); TrashObject(oItem); break;
        case 3: GiveGoldToCreature(oPC, nGold); TrashObject(oItem); break;
      }
    }
    else
    {
      nDice = d3();
      switch(nDice)
      {
        case 1: DoCollChips(oPC, nGold); TrashObject(oItem); break;
        case 2: GiveGoldToCreature(oPC, nGold); TrashObject(oItem); break;
        case 3: GiveGoldToCreature(oPC, nGold); TrashObject(oItem); break;
      }
    }
    oItem = GetNextItemInInventory(oBox);
  }
}
