/////::///////////////////////////////////////////////
/////:: Master Craftsman Finalize - take cost of doing business
/////:: Modified by Winterknight on 10/27/07
/////:: Gross modification from original property transfer system
/////:://////////////////////////////////////////////

#include "wk_inc_forge"

void main()
{
  object oPC = GetPCSpeaker();
  TakeMastCollectorCost(oPC);

}
