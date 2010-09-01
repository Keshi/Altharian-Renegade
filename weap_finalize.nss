/////::///////////////////////////////////////////////
/////:: Master Weapon Craftsman Finalize - take cost of doing business
/////:: Modified by Winterknight on 10/28/07
/////:: Gross modification from original property transfer system
/////:://////////////////////////////////////////////

#include "wk_inc_forge"

void main()
{
  object oPC = GetPCSpeaker();

  TakeWeaponCollectorCost(oPC);
  int nNewb = GetLocalInt(oPC,"Newbie");
  if (nNewb <=3 )
  {
    SetCampaignInt("Character","newbieweapon",nNewb,oPC);
  }
  int nTake = GetLocalInt (oPC,"WEAP_COST");
  TakeGoldFromCreature (nTake,oPC,TRUE);

}
