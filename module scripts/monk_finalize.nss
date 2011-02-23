/////::///////////////////////////////////////////////
/////:: champ_finalize - Separate into component properties
/////:: Modified by Winterknight on 6/09/06
/////:: Original script written by Asbury
/////:://////////////////////////////////////////////

#include "x2_inc_itemprop"

void SafeAddItemProperty(int nDurationType, itemproperty ipProperty, object oItem, float fDuration=0.0f)
{
    int nPropType = GetItemPropertyType(ipProperty);
    if (!GetItemHasItemProperty(oItem,nPropType)) //already exist
      {
        AddItemProperty(nDurationType, ipProperty, oItem, fDuration);
        return;
      }
    else if (nPropType==ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N ||
             nPropType==ITEM_PROPERTY_CAST_SPELL ||
             nPropType==ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP ||
             nPropType==ITEM_PROPERTY_USE_LIMITATION_CLASS ||
             nPropType==ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE ||
             nPropType==ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT)
      {
        AddItemProperty(nDurationType, ipProperty, oItem, fDuration);
        return;
      }
    else if (nPropType==ITEM_PROPERTY_DAMAGE_BONUS ||
             nPropType==ITEM_PROPERTY_DAMAGE_RESISTANCE ||
             nPropType==ITEM_PROPERTY_ABILITY_BONUS ||
             nPropType==ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE ||
             nPropType==ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS ||
             nPropType==ITEM_PROPERTY_DAMAGE_VULNERABILITY ||
             nPropType==ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE ||
             nPropType==ITEM_PROPERTY_DECREASED_ABILITY_SCORE ||
             nPropType==ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE ||
             nPropType==ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE)
      {
        IPSafeAddItemProperty(oItem, ipProperty, 0.0f, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);
      }

    else if (nPropType==ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP ||
             nPropType==ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE ||
             nPropType==ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP ||
             nPropType==ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP ||
             nPropType==ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT ||
             nPropType==ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP ||
             nPropType==ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP ||
             nPropType==ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT ||
             nPropType==ITEM_PROPERTY_BONUS_FEAT ||
             nPropType==ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP ||
             nPropType==ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP ||
             nPropType==ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT ||
             nPropType==ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP ||
             nPropType==ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP ||
             nPropType==ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT ||
             nPropType==ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP ||
             nPropType==ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP ||
             nPropType==ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT ||
             nPropType==ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL ||
             nPropType==ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL ||
             nPropType==ITEM_PROPERTY_ON_HIT_PROPERTIES ||
             nPropType==ITEM_PROPERTY_ONHITCASTSPELL ||
             nPropType==ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC ||
             nPropType==ITEM_PROPERTY_SKILL_BONUS )
      {
        int nSub1 = GetItemPropertySubType(ipProperty);
        if (nSub1 > -1)
          {
            itemproperty ipCheck = GetFirstItemProperty(oItem);
            while (GetIsItemPropertyValid(ipCheck))
              {
                int nSub2 = GetItemPropertySubType(ipCheck);
                if (nSub2 != nSub1)
                  {
                    AddItemProperty(nDurationType, ipProperty, oItem, fDuration);
                    return;
                  }
                ipCheck = GetNextItemProperty(oItem);
              }
          }
      }
}
//******************************************************************************

void main()
{
  object oCombine = GetNearestObjectByTag("monkcombine",OBJECT_SELF,1);
  object oPC = GetPCSpeaker();
  object oCraft;
  object oItem = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
  if (!GetIsObjectValid(oItem)) return;             //must have something there
  int nCash;
  itemproperty ipFItem;

// Next, we will get the local variables for the price.
// *****************************************************************************
      nCash = GetLocalInt(oPC,"cashout");
                                     //end of variables.
// *****************************************************************************
// Finally, we will merge the props from combine into the item in hand.

// Do the combine.
  oCraft = GetFirstItemInInventory(oCombine);
  while (GetIsObjectValid(oCraft))
    {
      ipFItem = GetFirstItemProperty(oCraft);
      while (GetIsItemPropertyValid(ipFItem))
        {
          SafeAddItemProperty(DURATION_TYPE_PERMANENT,ipFItem,oItem);
          RemoveItemProperty(oCraft, ipFItem);
          ipFItem=GetNextItemProperty(oCraft);
        }
      DestroyObject(oCraft);
      oCraft = GetNextItemInInventory(oCombine);
    }
// Last thing: take the money, vis effect
    TakeGoldFromCreature(nCash,oPC,TRUE);

    effect eTel1 = EffectVisualEffect(VFX_IMP_PULSE_HOLY_SILENT,FALSE);
    effect eTel2 = EffectVisualEffect(VFX_IMP_ELEMENTAL_PROTECTION,FALSE);

    location lTrig1 = GetLocation(oItem);
    location lTrig2 = GetLocation(OBJECT_SELF);

    object oArea = GetArea(oPC);

  ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eTel2,lTrig2,0.0);
  DelayCommand(0.3,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eTel1,lTrig1,0.0));
  RecomputeStaticLighting(oArea);





}
