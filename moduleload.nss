/////:://///////////////////////////////////////////////////////////////////////
/////:: Module Load script, set campaign variables.
/////:: Written by Winterknight 10/29/05
/////:://///////////////////////////////////////////////////////////////////////

#include "x2_inc_switches"

void main()
{
    SetCampaignInt("Altharia","clock",0);
    int nRand = d6(1);
    string sTag = "WP_refractedlight"+IntToString(nRand);
    location lSpawn = GetLocation(GetWaypointByTag(sTag));
    CreateObject(OBJECT_TYPE_PLACEABLE,"refractedlight",lSpawn,FALSE);
    SetModuleSwitch(MODULE_SWITCH_NO_RANDOM_MONSTER_LOOT,TRUE);
}
