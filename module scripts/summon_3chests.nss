/////::///////////////////////////////////////////
/////:: summon_3chests
/////:: Written by Winterknight for Altharia 8/5/07
/////::///////////////////////////////////////////


void main()
{
  object oSpot = GetWaypointByTag("WP_EnterChest_1");
  location lSpot = GetLocation(oSpot);
  CreateObject(OBJECT_TYPE_PLACEABLE,"enterchest_1",lSpot,FALSE);

  oSpot = GetWaypointByTag("WP_EnterChest_2");
  lSpot = GetLocation(oSpot);
  CreateObject(OBJECT_TYPE_PLACEABLE,"enterchest_2",lSpot,FALSE);

  oSpot = GetWaypointByTag("WP_EnterChest_3");
  lSpot = GetLocation(oSpot);
  CreateObject(OBJECT_TYPE_PLACEABLE,"enterchest_3",lSpot,FALSE);
  SetLocalInt(OBJECT_SELF,"startchests",3);

}
