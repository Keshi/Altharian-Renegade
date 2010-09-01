/////::///////////////////////////////////////////
/////:: Start Destroy Chest
/////:: Written by Winterknight for Altharia 5/21/07
/////::///////////////////////////////////////////


void main()
{
  int nDist = GetInventoryDisturbType();
  if (nDist == INVENTORY_DISTURB_TYPE_ADDED)
  {
    object oItem = GetInventoryDisturbItem();
    location lDump = GetLocation(GetWaypointByTag("WP_start_dump"));
    AssignCommand(oItem,ActionMoveToLocation(lDump));
  }
  else if (nDist == INVENTORY_DISTURB_TYPE_REMOVED)
  {
    object oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
      DestroyObject(oItem,0.1);
      oItem = GetNextItemInInventory();
    }
    object oPC = GetObjectByTag("wk_startarms");
    int nChest = GetLocalInt(oPC,"startchests");
    SetLocalInt(oPC,"startchests",nChest-1);
    oPC = GetPlaceableLastClickedBy();
    SetLocalInt(oPC,"startchests",nChest+1);
    DestroyObject(OBJECT_SELF,0.2);
  }
}
