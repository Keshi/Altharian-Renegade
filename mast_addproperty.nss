/////::///////////////////////////////////////////////
/////:: Master Craftsman Property addition
/////:: Modified by Winterknight on 10/27/07
/////:: Gross modification from original property transfer system
/////:://////////////////////////////////////////////

#include "x2_inc_itemprop"

void main()
{
  object oPC = GetPCSpeaker();
  object oItem = GetLocalObject(oPC,"MAST_MODIFY"); // Object set on character choice
  if (!GetIsObjectValid(oItem)) return;             // Must be a valid object

  itemproperty ipAdd;

// Obtain variables, determine if item property is immunity, damage, or cast spell
// then add the property to the item.

  string sMast = GetLocalString(oPC,"MAST_STRING");
  int nValue = GetLocalInt(oPC,"MAST_MOD");
  if (sMast == "mast_immune")
  {
    ipAdd = ItemPropertyImmunityMisc(nValue);
    IPSafeAddItemProperty(oItem, ipAdd,0.0,X2_IP_ADDPROP_POLICY_IGNORE_EXISTING,FALSE,FALSE);
  }
  else if (sMast == "mast_cast")
  {
    int nUses = GetLocalInt(oPC,"MAST_USES");
    ipAdd = ItemPropertyCastSpell(nValue,nUses);
    IPSafeAddItemProperty(oItem, ipAdd,0.0,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,FALSE);
  }
  else if (sMast == "mast_damage")
  {
    ipAdd = ItemPropertyDamageImmunity(nValue,1);
    IPSafeAddItemProperty(oItem, ipAdd,0.0,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,FALSE);
  }

// Visual Effect
  effect eVis = EffectVisualEffect(VFX_IMP_GOOD_HELP);
  ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oPC);


}
