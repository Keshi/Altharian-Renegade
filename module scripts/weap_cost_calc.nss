/////::///////////////////////////////////////////////
/////:: champ_upgrade - Separate into component properties
/////:: Modified by Winterknight on 6/09/06
/////:: Original script written by Asbury
/////:://////////////////////////////////////////////

#include "wk_inc_forge"

void main()
{
  object oPC = GetPCSpeaker();

  string sMast = GetLocalString(oPC,"WEAP_STRING");
  if (sMast == "weap_damage")
  {
    int nDamage = GetLocalInt(oPC,"WEAP_DAMAGE");
    if (nDamage == 20) SetLocalInt(oPC,"WEAP_COLLCOST",75);
    if (nDamage == 25) SetLocalInt(oPC,"WEAP_COLLCOST",150);
    if (nDamage == 30) SetLocalInt(oPC,"WEAP_COLLCOST",200);
  }

  int nNewb = GetCampaignInt("Character","newbieweapon",oPC);
    if (nNewb < 3)
      {
        SetLocalInt(oPC,"WEAP_COST",0);
      }
    else if (nNewb >= 3)
      {
        int nCost = GetWeaponUpgradeCost (oPC);
        SetLocalInt(oPC,"WEAP_COST",nCost);
      }
    nNewb++;
    SetLocalInt(oPC,"Newbie",nNewb);
}
