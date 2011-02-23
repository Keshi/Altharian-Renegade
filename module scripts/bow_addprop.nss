/////::///////////////////////////////////////////////
/////:: Weapon Master Craftsman Property addition
/////:: Modified by Winterknight on 10/28/07
/////:: Gross modification from original property transfer system
/////:://////////////////////////////////////////////

#include "x2_inc_itemprop"

void main()
{
  object oPC = GetPCSpeaker();
  object oItem = GetLocalObject(oPC,"WEAP_MODIFY"); // Object set on character choice
  if (!GetIsObjectValid(oItem)) return;             // Must be a valid object

  itemproperty ipAdd;

// Obtain variables, determine item property based on string (selection)
// then add the property to the item.

  string sMast = GetLocalString(oPC,"WEAP_STRING");
  int nValue = GetLocalInt(oPC,"MAST_MOD");
  if (sMast == "weap_vregen")
  {
    ipAdd = ItemPropertyMaxRangeStrengthMod(nValue);
    IPSafeAddItemProperty(oItem, ipAdd,0.0,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,FALSE);
  }
  else if (sMast == "bow_bonus")
  {
    ipAdd = ItemPropertyAttackBonus(nValue);
    IPSafeAddItemProperty(oItem, ipAdd,0.0,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,FALSE);
  }
  else if (sMast == "weap_damage")
  {
    ipAdd = ItemPropertyExtraRangeDamageType(nValue);
    IPSafeAddItemProperty(oItem, ipAdd,0.0,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,FALSE);
  }
  else if (sMast == "weap_mcrit")
  {
    nValue = GetLocalInt(oPC,"WEAP_DAMAGE");
    ipAdd = ItemPropertyMassiveCritical(nValue);
    IPSafeAddItemProperty(oItem, ipAdd,0.0,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,FALSE);
  }


// Visual Effect
  effect eVis = EffectVisualEffect(VFX_IMP_GOOD_HELP);
  ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oPC);

  SetDroppableFlag(oItem, FALSE);
  SetPlotFlag(oItem, FALSE);


}
