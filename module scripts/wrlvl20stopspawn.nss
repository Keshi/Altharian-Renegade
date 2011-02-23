//::///////////////////////////////////////////////
//:: lvl20stopspawn
//:: Written by Winterknight for Altharia
//:://////////////////////////////////////////////

void main()
{
  string sTag = "EN_OrcWestRoad";
  string sLoop;
  int Loop;
  object oSpawn;
  int nCheck = TRUE;
  object oEnter = GetEnteringObject();
  if (GetIsPC(oEnter) & GetHitDice(oEnter) >= 20) nCheck = FALSE;
  for (Loop = 1; Loop < 7; Loop++)
    {
      sLoop = sTag+IntToString(Loop);
      oSpawn = GetNearestObjectByTag(sLoop,OBJECT_SELF,1);
      SetEncounterActive(nCheck,oSpawn);
    }

}
