/////::///////////////////////////////////////////
/////:: Dash Destroy Chest
/////:: Written by Winterknight for Altharia 5/21/07
/////::///////////////////////////////////////////


void main()
{
  int nDist = GetInventoryDisturbType();
  if (nDist == INVENTORY_DISTURB_TYPE_ADDED)
  {
    object oItem = GetInventoryDisturbItem();
    location lDump = GetLocation(GetWaypointByTag("WP_dash_dump"));
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
    object oPC = GetPlaceableLastClickedBy();
    string sTag = GetTag(OBJECT_SELF);
    if (sTag == "dashbootchest") SetCampaignInt("altharia","DasBoot",1,oPC);
    if (sTag == "dashbeltrack") SetCampaignInt("altharia","DasBelt",1,oPC);
    if (sTag == "dashammychest") SetCampaignInt("altharia","DasAmmy",1,oPC);
    if (sTag == "dashbracchest") SetCampaignInt("altharia","DasBracer",1,oPC);
    if (sTag == "dashcloakarm") SetCampaignInt("altharia","DasCloak",1,oPC);
    DestroyObject(OBJECT_SELF,0.2);
  }
}
