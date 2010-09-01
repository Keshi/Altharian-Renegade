/////::///////////////////////////////////////////////
/////:: forge_itemmerge - Forge properties onto item from components.
/////:: Modified by Winterknight on 2/18/06
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
             nPropType==ITEM_PROPERTY_CAST_SPELL)
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
                IPSafeAddItemProperty(oItem, ipProperty, 0.0f, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, FALSE);
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
    itemproperty ipFItem;
    effect eTel1 = EffectVisualEffect(VFX_IMP_FROST_L,FALSE);
    effect eTel2 = EffectVisualEffect(VFX_IMP_ELEMENTAL_PROTECTION,FALSE);
    effect eUtter = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION,FALSE);

    object oPC = GetPCSpeaker();

    object oForge = GetNearestObjectByTag("forge_custom",OBJECT_SELF,1);
    object oCombine = GetNearestObjectByTag("forge_combine",OBJECT_SELF,1);
    location lTrig1 = GetLocation(oForge);
    location lTrig2 = GetLocation(oCombine);

    if (!GetIsObjectValid(oForge)) return;                      //must have Forge
    if (!GetIsObjectValid(oCombine)) return;                    //must have Combining chamber

    object oArea = GetArea(oForge);
    object oItem = GetFirstItemInInventory(oForge);             //get the first item on Forge

    if (!GetIsObjectValid(oItem))
      {
        SendMessageToPC(oPC,"You must have a valid item in the Forge.");
        return;                                                 //must have something there
      }

    int nLoop = IPGetNumberOfItemProperties(oItem);
    object oCraft = GetFirstItemInInventory(oCombine);          //get the first item in the combining chamber
    int nTally = nLoop;

    while (GetIsObjectValid(oCraft))
      {
        ipFItem = GetFirstItemProperty(oCraft);                 //Loop for as long as the ipLoop variable is valid
        while (GetIsItemPropertyValid(ipFItem))
          {
            nTally++;
            if (nLoop < 7)
              {
                SafeAddItemProperty(DURATION_TYPE_PERMANENT,ipFItem,oItem); //put property on
                nLoop++;
              }
            if (nTally > 6)
              {
                SendMessageToPC(oPC,"You have attempted to add more than 6 properties to the item.  This can cause errors in transfer.  Some item properties have been lost.");
              }
            RemoveItemProperty(oCraft, ipFItem);                //take the magic away from object
            ipFItem=GetNextItemProperty(oCraft);
          }
        DestroyObject(oCraft);                                  //remove the object
        oCraft = GetNextItemInInventory(oCombine);
      }

  ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eTel2,lTrig2,0.0);
  DelayCommand(0.3,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eTel1,lTrig1,0.0));
  RecomputeStaticLighting(oArea);

  int nGold = GetLocalInt (OBJECT_SELF,"ItemCost");
  TakeGoldFromCreature(nGold,oPC,TRUE);

}
