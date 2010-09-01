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
    else if (nPropType==ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)
      {
        AddItemProperty(nDurationType, ipProperty, oItem, fDuration);
        return;
      }
    else if (nPropType==ITEM_PROPERTY_CAST_SPELL)
      {
        int nSub1 = GetItemPropertySubType(ipProperty);
        if (nSub1 != 329 &
            nSub1 != 335 &
            nSub1 != 359 &
            nSub1 != 537 &
            nSub1 != 513)
          {
            AddItemProperty(nDurationType, ipProperty, oItem, fDuration);
            return;
          }
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
    int nFailure = 0;
    int nSkill1 = GetSkillRank(SKILL_CRAFT_ARMOR, OBJECT_SELF);
    int nSkill2 = GetSkillRank(SKILL_CRAFT_WEAPON, OBJECT_SELF);
    int nUtter = ((nSkill1 + nSkill2)/10) + 10;
    if (nUtter > 20) nUtter = 20;
    int UtterDestruction = 0;
    int nBones;
    object oCraft = GetFirstItemInInventory(oCombine);          //get the first item in the combining chamber

    while (GetIsObjectValid(oCraft))
      {
        if (nLoop > 7)                                          //number of properties added before the 25% bonus failure chance
          {
            nFailure = 5;
          }
        ipFItem = GetFirstItemProperty(oCraft);                 //Loop for as long as the ipLoop variable is valid
        while (GetIsItemPropertyValid(ipFItem))
          {
            nBones = Random(20);
            int nValue = GetGoldPieceValue(oItem);
            int nFactor = nValue/6000000;
            nUtter = nUtter - (nFactor + nFailure);
            if (nUtter < 5) nUtter = 5;
            if (nBones == 19 || nBones >= (nLoop + nFailure + nFactor))    //chance of failure
                                                                //1 in 20 chance of always working.
              {
                SafeAddItemProperty(DURATION_TYPE_PERMANENT,ipFItem,oItem); //put property on
                nLoop++;
              }
            else if (Random(nUtter) <1)                         // Chance of Super failure
              {
                UtterDestruction = 1234;
              }
            else {SendMessageToPC(oPC,"A property failed to transfer and was lost.");}
            RemoveItemProperty(oCraft, ipFItem);                //take the magic away from object
            ipFItem=GetNextItemProperty(oCraft);
          }
        DestroyObject(oCraft);                                  //remove the object
        oCraft = GetNextItemInInventory(oCombine);
      }

  ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eTel2,lTrig2,0.0);
  DelayCommand(0.3,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eTel1,lTrig1,0.0));
  RecomputeStaticLighting(oArea);

    if (UtterDestruction == 1234)                               // Effect of super failure
      {
        DestroyObject(oItem);
        DelayCommand(0.9,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eUtter,lTrig1,0.0));
        SendMessageToPC(oPC,"The unstable energies of the forge have destroyed your item.");
      }

  int nGold = GetLocalInt (OBJECT_SELF,"ItemCost");
  TakeGoldFromCreature(nGold,oPC,TRUE);

}
