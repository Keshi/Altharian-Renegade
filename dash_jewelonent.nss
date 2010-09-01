///// Cloak Room On Enter


void main()
{
  object oPC = GetEnteringObject();
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

  // Make da new stuff
  if (GetIsPC(oPC))
  {
    location lSpawn;
    int nTest = GetCampaignInt("altharia","DasAmmy",oPC);
    if (nTest <1)
    {
      lSpawn = GetLocation(GetWaypointByTag("WP_dashammy"));
      CreateObject(OBJECT_TYPE_PLACEABLE,"dashammychest",lSpawn);
    }
    nTest = GetCampaignInt("altharia","DasBracer",oPC);
    if (nTest < 1)
    {
      lSpawn = GetLocation(GetWaypointByTag("WP_dashbrac"));
      CreateObject(OBJECT_TYPE_PLACEABLE,"dashbracchest",lSpawn);
    }

    nTest = GetLocalInt(GetObjectByTag("Dela_dashjewelroom",1),"occupants");
    if (nTest > 0)
    {
      AssignCommand(oPC,JumpToLocation(GetLocation(GetWaypointByTag("WP_JewelOccupied"))));
      SendMessageToPC(oPC,"Jewel room is occupied.");
      return;
    }
    else if (nTest == 0) SetLocalInt(GetObjectByTag("Dela_dashjewelroom",1),"occupants",1);
  }
}
