/////::///////////////////////////////////////////////
/////:: champ_upgrade - Separate into component properties
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
  object oForge = GetNearestObjectByTag("hiddenforge",OBJECT_SELF,1);
  object oCombine = GetNearestObjectByTag("hiddencombine",OBJECT_SELF,1);
  object oPC = GetPCSpeaker();
  object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
  if (!GetIsObjectValid(oItem)) return;             //must have something there
  string sCraft = "craftingdagger";  // melee weapons
  string sCount;
  object oCraft;
  int iCheck = 1;
  itemproperty ipFItem = GetFirstItemProperty(oItem);

// First thing: strip the existing properties from the item, store them in the combine.
// Loop for as long as the ipLoop variable is valid

  while (GetIsItemPropertyValid(ipFItem))
    {
       oCraft = CreateItemOnObject(sCraft,oCombine,1);
       if (GetIsObjectValid(oCraft))
            {
              RemoveItemProperty(oItem, ipFItem);   //take the magic away from object
              AddItemProperty(DURATION_TYPE_PERMANENT,ipFItem,oCraft);//put property on gem
            }

      ipFItem=GetNextItemProperty(oItem);       //Next itemproperty on the list...
    }                                           //end of Item strip

// Next, we will create the custom items for the upgrade on the Forge.
// *****************************************************************************
  for (iCheck = 1; iCheck < 4; iCheck++)
    {
      sCraft = "saintupgrade00";
      sCount = IntToString(iCheck);
      CreateItemOnObject(sCraft+sCount,oForge,1);
    }                                           //end of token creation.
// *****************************************************************************
// Finally, we will merge the props from forge and combine into the item in hand.

// Start with the forge.
  oCraft = GetFirstItemInInventory(oForge);

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
      oCraft = GetNextItemInInventory(oForge);
    }

// Then do the Combine.
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


}
