//::///////////////////////////////////////////////
//:: wk_holyavenger
//:: Based on X2_S0_HolySwrd
//:: Modified by Winterknight for Altharia
//:://////////////////////////////////////////////

//:: Grants holy avenger properties.
//#include "x2_inc_itemprop"
#include "prc_x2_itemprop"

void AddHolyAvengerEffectToWeapon(object oMyWeapon, float fDuration)
{
  if (IPGetIsMeleeWeapon(oMyWeapon))
  {
    IPSafeAddItemProperty(oMyWeapon,ItemPropertyHolyAvenger(), fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE,TRUE);
    return;
  }
}

void AddGuardianAmmoToBow(object oMyWeapon, float fDuration)
{
  if (IPGetIsRangedWeapon(oMyWeapon))
  {
    itemproperty ipAdd = ItemPropertyUnlimitedAmmo(IP_CONST_UNLIMITEDAMMO_1D6LIGHT);
    IPSafeAddItemProperty(oMyWeapon,ipAdd, fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE,TRUE);
    return;
  }
}

void DoArcherBowUpgrade(object oArcher, float fDuration)
{

//Declare major variables
  effect eVis = EffectVisualEffect(VFX_IMP_EVIL_HELP);
  int nDoIt;

  object oMyWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oArcher);
  if (fDuration>0.0f)
  {
    if (GetTag(oMyWeapon) == "archerbow") AddGuardianAmmoToBow(oMyWeapon, fDuration);
    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oArcher);
    if (GetTag(oMyWeapon) == "archerbow") AddGuardianAmmoToBow(oMyWeapon, fDuration);
    oMyWeapon = GetFirstItemInInventory(oArcher);
    while (GetIsObjectValid(oMyWeapon))
    {
      if (GetTag(oMyWeapon) == "archerbow") AddGuardianAmmoToBow(oMyWeapon, fDuration);
      oMyWeapon = GetNextItemInInventory(oArcher);
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oArcher);
  }
  return;
}

void DoVesperHolyAvenger(object oPaladin, float fDuration)
{

//Declare major variables
  effect eVis = EffectVisualEffect(VFX_IMP_GOOD_HELP);
  int nDoIt;
//***************************************
// Code addition for Paladin level check
//***************************************
  if(GetLevelByClass(CLASS_TYPE_PALADIN, oPaladin) < 5)
  {
    FloatingTextStringOnCreature("You must have at least 5 Paladin levels to gain the Holy Avenger enhancement.", oPaladin, FALSE);
    return;
  }
//***************************************
// End level check code
//***************************************
  object oMyWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPaladin);
  if (fDuration>0.0f)
  {
    if (GetTag(oMyWeapon) == "holysword") AddHolyAvengerEffectToWeapon(oMyWeapon, fDuration);
    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPaladin);
    if (GetTag(oMyWeapon) == "holysword") AddHolyAvengerEffectToWeapon(oMyWeapon, fDuration);
    oMyWeapon = GetFirstItemInInventory(oPaladin);
    while (GetIsObjectValid(oMyWeapon))
    {
      if (GetTag(oMyWeapon) == "holysword") AddHolyAvengerEffectToWeapon(oMyWeapon, fDuration);
      oMyWeapon = GetNextItemInInventory(oPaladin);
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPaladin);
  }
  return;
}
//void main(){}
