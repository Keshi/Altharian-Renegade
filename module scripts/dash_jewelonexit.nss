/////::///////////////////////////////////////////
/////:: Dash Cloakroom OnExit Area
/////:: Written by Winterknight for Altharia 5/21/07
/////::///////////////////////////////////////////


void main()
{
  object oChest;
  object oItem;
  // Amulet chest
  oChest = GetNearestObjectByTag("dashammychest");
  oItem = GetFirstItemInInventory(oChest);
  while (GetIsObjectValid(oItem))
    {
      DestroyObject(oItem,0.1);
      oItem = GetNextItemInInventory(oChest);
    }
  DestroyObject(oChest,0.1);
  // Bracer chest
  oChest = GetNearestObjectByTag("dashbracchest");
  oItem = GetFirstItemInInventory(oChest);
  while (GetIsObjectValid(oItem))
    {
      DestroyObject(oItem,0.1);
      oItem = GetNextItemInInventory(oChest);
    }
  DestroyObject(oChest,0.1);
  SetLocalInt(GetObjectByTag("Dela_dashjewelroom",1),"occupants",0);;

}
