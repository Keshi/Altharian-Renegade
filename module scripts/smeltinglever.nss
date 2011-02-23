/////::///////////////////////////////////////////
/////:: Recycling Lever Script
/////:: Written by Winterknight for Altharia 10/21/07
/////::///////////////////////////////////////////

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
  object oBox = GetNearestObjectByTag("smeltingfurnace",OBJECT_SELF,1);
  object oItem = GetFirstItemInInventory(oBox);
  int nGold;
  int nMult = 10;
  while (GetIsObjectValid(oItem))
  {
    nGold = GetGoldPieceValue(oItem);
    if (GetStolenFlag(oItem) == TRUE) nMult = 1;
    TrashObject(oItem);
    nGold = (nGold * 2 * nMult / 100);
    GiveGoldToCreature(oPC, nGold);
    oItem = GetNextItemInInventory(oBox);
  }

}
