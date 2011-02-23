///// Cloak Room On Enter


void main()
{
  object oPC = GetEnteringObject();
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
  if (GetIsPC(oPC))
  {
    location lSpawn;
    int nTest = GetCampaignInt("altharia","DasBelt",oPC);
    if (nTest <1)
    {
      lSpawn = GetLocation(GetWaypointByTag("WP_dashbelt"));
      CreateObject(OBJECT_TYPE_PLACEABLE,"dashbeltrack",lSpawn);
    }
    nTest = GetCampaignInt("altharia","DasCloak",oPC);
    if (nTest < 1)
    {
      lSpawn = GetLocation(GetWaypointByTag("WP_dashcloak"));
      CreateObject(OBJECT_TYPE_PLACEABLE,"dashcloakarm",lSpawn);
    }
    nTest = GetCampaignInt("altharia","DasBoot",oPC);
    if (nTest < 1)
    {
      lSpawn = GetLocation(GetWaypointByTag("WP_dashboot"));
      CreateObject(OBJECT_TYPE_PLACEABLE,"dashbootchest",lSpawn);
    }
    nTest = GetLocalInt(GetObjectByTag("Dela_dashcloakroom",1),"occupants");
    if (nTest > 0)
    {
      AssignCommand(oPC,JumpToLocation(GetLocation(GetWaypointByTag("WP_CloakOccupied"))));
      SendMessageToPC(oPC,"Cloakroom is occupied.");
      return;
    }
    else if (nTest == 0) SetLocalInt(GetObjectByTag("Dela_dashcloakroom",1),"occupants",1);
  }
}
