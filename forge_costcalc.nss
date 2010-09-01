/////::///////////////////////////////////////////////
/////:: forge_costcheck - determine cost of perfect transferance to new item.
/////:: Modified by Winterknight on 2/18/06
/////:: Original scripts by Asbury
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
    object oPC = GetPCSpeaker();

    object oForge = GetNearestObjectByTag("forge_custom",OBJECT_SELF,1);

    object oCombine = GetNearestObjectByTag("forge_combine",OBJECT_SELF,1);

    string sCraft;
    int nType = GetLocalInt(OBJECT_SELF, "ItemType");   //check for type for crafting
    if (nType == 1) sCraft = "craftingbelt";            // belts and boots
    if (nType == 2) sCraft = "craftingshield";          // armor, helm, shield
    if (nType == 3) sCraft = "craftingdagger";          // melee weapons
    if (nType == 4) sCraft = "craftingcloak";           // cloaks
    if (nType == 5) sCraft = "craftingring";            // rings and ammys
    if (nType == 6) sCraft = "craftingsling";           // bows, x-bows, slings
    if (nType == 7) sCraft = "craftingdart";            // thrown and ammo
    if (nType == 8) sCraft = "craftingtoken";           // miscellaneous, common

    if (!GetIsObjectValid(oForge)) return;              //must have Forge
    if (!GetIsObjectValid(oCombine)) return;            //must have Combining chamber

    object oItem = GetFirstItemInInventory(oForge);     //get the item on Forge
      if (GetIdentified(oItem)==FALSE) SetIdentified (oItem, TRUE);
      if (GetPlotFlag(oItem)==TRUE)
        {
          SetPlotFlag (oItem, FALSE);
          SetLocalInt(OBJECT_SELF,"PlotItem",TRUE);
        }
    object oCraft = GetFirstItemInInventory(oCombine);  //get the first item in the combining chamber
    object oCopy = CopyItem(oItem, OBJECT_SELF, FALSE);

// First - we add the goodies from the combine to the base item

    while (GetIsObjectValid(oCraft))
      {
        ipFItem = GetFirstItemProperty(oCraft);         //Loop for as long as the ipLoop variable is valid
        while (GetIsItemPropertyValid(ipFItem))
          {
            SafeAddItemProperty(DURATION_TYPE_PERMANENT,ipFItem,oCopy); //put property on copy
            ipFItem=GetNextItemProperty(oCraft);
          }
        oCraft = GetNextItemInInventory(oCombine);
      }

// Then we find the actual cost of the new item.  Then we screw them on price.
    int nValue2 = GetGoldPieceValue(oItem);
    int nValue1 = GetGoldPieceValue(oCopy);
    int nDiff = nValue1 - nValue2;
    int nIncrease;
    string sValue = "";
    int nAppraise = GetSkillRank(SKILL_APPRAISE,oPC);
    if (nAppraise > 75) nAppraise = 75;
    if (nDiff > 0)
      {
        (nIncrease = nDiff * (150 - nAppraise)/100);
        sValue = IntToString(nIncrease);
      }
    else
      {
        nIncrease = 0;
        sValue = "nothing in ";
      }

    SetCustomToken(103,sValue);
    SetLocalInt (OBJECT_SELF,"ItemCost",nIncrease);

// Then we remove destroy the copy
    DestroyObject(oCopy,0.5f);

    if (GetLocalInt(OBJECT_SELF,"PlotItem")==TRUE)  // Reset variables and plot
      {
        SetPlotFlag (oItem, TRUE);
        SetLocalInt(OBJECT_SELF,"PlotItem",FALSE);
      }
}
