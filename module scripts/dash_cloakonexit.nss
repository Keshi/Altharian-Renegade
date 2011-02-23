/////::///////////////////////////////////////////
/////:: Dash Cloakroom OnExit Area
/////:: Written by Winterknight for Altharia 5/21/07
/////::///////////////////////////////////////////


void main()
{
  object oChest = GetNearestObjectByTag("dashbootchest");
  object oItem = GetFirstItemInInventory(oChest);
  while (GetIsObjectValid(oItem))
    {
      DestroyObject(oItem,0.1);
      oItem = GetNextItemInInventory(oChest);
    }
  DestroyObject(oChest,0.1);
  oChest = GetNearestObjectByTag("dashbeltrack");
  oItem = GetFirstItemInInventory(oChest);
  while (GetIsObjectValid(oItem))
    {
      DestroyObject(oItem,0.1);
      oItem = GetNextItemInInventory(oChest);
    }
  DestroyObject(oChest,0.1);
  oChest = GetNearestObjectByTag("dashcloakarm");
  oItem = GetFirstItemInInventory(oChest);
  while (GetIsObjectValid(oItem))
    {
      DestroyObject(oItem,0.1);
      oItem = GetNextItemInInventory(oChest);
    }
  DestroyObject(oChest,0.1);
  SetLocalInt(GetObjectByTag("Dela_dashcloakroom",1),"occupants",0);

}
