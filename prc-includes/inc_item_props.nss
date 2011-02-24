//::///////////////////////////////////////////////
//:: [Item Property Function]
//:: [inc_item_props.nss]
//:://////////////////////////////////////////////
/** @file
    This file defines several functions used to
    manipulate item properties.  In particular,
    It defines functions used in the prc_* files
    to apply passive feat bonuses.

    Take special note of SetCompositeBonus.  This
    function is crucial for allowing bonuses of the
    same type from different PRCs to stack.
*/
//:://////////////////////////////////////////////
//:: Created By: Aaon Graywolf
//:: Created On: Dec 19, 2003
//:://////////////////////////////////////////////
//:: Update: Jan 4 2002
//::    - Extended Composite bonus function to handle pretty much
//::      every property that can possibly be composited.

//////////////////////////////
// Function Prototypes      //
//////////////////////////////


/**
 * Checks oItem for all properties matching iType and iSubType. Removes all
 * these properties and returns their total CostTableVal.
 * This function should only be used for Item Properties that have simple
 * integer CostTableVals, such as AC, Save/Skill Bonuses, etc.
 *
 * @param oItem    The item on which to look for the itemproperties. Usually a
 *                 skin object.
 * @param iType    ITEM_PROPERTY_* constant of the itemproperty to look for.
 * @param iSubType IP_CONST_* constant of itemproperty SubType if applicable.
 * @return         The total CostTableValue of the itemproperties found
 *                 matching iType and iSubType.
 */
int TotalAndRemoveProperty(object oItem, int iType, int iSubType = -1);

/**
 * Used to roll bonuses from multiple sources into a single property.
 * Only supports properties which have simple integer CostTableVals.
 * See the code for a list of supported types.  Some important properties
 * that CANNOT be composited are SpellResistance, DamageBonus, DamageReduction
 * DamageResistance and MassiveCritical, as these use 2da-referencing constants
 * instead of integers for CostTableVals.
 *
 * <DEPRECATED>
 * LocalInts from SetCompositeBonus() when applied to the skin need to be
 * added to DeletePRCLocalInts() in prc_inc_function in order for the system to
 * properly clear the properties when the itemproperties are removed using
 * ScrubPCSkin().
 * When applied to equipment, the LocalInts need to be added to
 * DeletePRCLocalIntsT() in inc_item_props.
 * </DEPRECATED>
 *
 * Use SetCompositeBonus() for the skin, SetCompositeBonusT() for other equipment.
 *
 *
 * @param oPC      Object wearing / using the item
 * @param oItem    Object to apply bonus to
 * @param sBonus   String name of the source for this bonus
 * @param iVal     Integer value to set this bonus to
 * @param iType    ITEM_PROPERTY_* constant of itemproperty to apply
 * @param iSubType IP_CONST_* constant of itemproperty SubType if applicable
 */
void SetCompositeBonus(object oItem, string sBonus, int iVal, int iType, int iSubType = -1);

/**
 * See SetCompositeBonus(). This is an equivalent, except it applies the itemproperties as
 * temporary ones with duration of 9999 seconds.
 */
void SetCompositeBonusT(object oItem, string sBonus, int iVal, int iType, int iSubType = -1);

/**
 * Calculates the total Bonus AC granted by itemproperties on an item.
 *
 * @param oItem The item to calculate AC bonus given by.
 * @return      The total of all AC bonus itemproperties on oItem.
 */
int GetACBonus(object oItem);

/**
 * Calculates the Base AC (i.e. AC without bonuses) of an item
 *
 * @param oItem The item to calculate base AC for.
 * @return      The base AC, as calculated by removing the value returned by
 *              GetACBonus() on the item from the value returned by GetItemACValue().
 */
int GetBaseAC(object oItem);

/**
 * Gets the itemproperty number of a specific SR value
 */
int GetSRByValue(int nValue);

/**
 * Returns the opposite element from iElem or -1 if iElem is not valid
 * Can be useful for determining elemental strengths and weaknesses
 *
 * @param iElem IP_CONST_DAMAGETYPE_* constant.
 * @return      IP_CONST_DAMAGETYPE_* constant of the opposing damage type.
 */
int GetOppositeElement(int iElem);

/**
 * Used to find the damage type done by any given weapon using 2da lookups.
 * Only usable on weapon items.
 *
 * @param oWeapon The weapon whose damage type to examine.
 * @return        One of IP_CONST_DAMAGETYPE_BLUDGEONING,
 *                       IP_CONST_DAMAGETYPE_PIERCING,
 *                       IP_CONST_DAMAGETYPE_SLASHING
 *                if used on a weapon item. Otherwise -1.
 */
int GetItemPropertyDamageType(object oWeapon);

/**
 * Used to find the damage type done by any given weapon using 2da lookups.
 * Only usable on weapon items.
 *
 * @param oWeapon The weapon whose damage type to examine.
 * @return        One of DAMAGE_TYPE_BLUDGEONING,
 *                       DAMAGE_TYPE_PIERCING,
 *                       DAMAGE_TYPE_SLASHING
 *                if used on a weapon item. Otherwise -1.
 */
int GetItemDamageType(object oWeapon);

/**
 * To ensure a damage bonus stacks with any existing enhancement bonus,
 * create a temporary damage bonus on the weapon.  You do not want to do this
 * if the weapon is of the "slashing and piercing" type, because the
 * enhancement bonus is considered "physical", not "slashing" or "piercing".
 *
 * Because of this strange Bioware behavior, you'll want to only call this code as such:
 *
 * if (StringToInt(Get2DACache("baseitems","WeaponType",GetBaseItemType(oWeapon))) != 4)
 * {
 *     IPEnhancementBonusToDamageBonus(oWeapon);
 * }
 *
 *
 * @param oWeap The weapon to perform the operation on.
 */
void IPEnhancementBonusToDamageBonus(object oWeap);

/**
 * Used to roll bonuses from multiple sources into a single property
 * Only supports damage bonuses in a linear fashion - +1 through +20.
 *
 * Note: If you do not define iSubType, the damage applied will most likely not
 * stack with any enhancement bonus.  See IPEnhancementBonusToDamageBonus() above.
 *
 * <DEPRECATED>
 * LocalInts from SetCompositeDamageBonus() need to be added to
 * DeletePRCLocalInts() in prc_inc_function.
 * LocalInts from SetCompositeDamageBonusT() need to be added to
 * DeletePRCLocalIntsT() in inc_item_props.
 * </DEPRECATED>
 *
 *
 * @param oItem    Object to apply bonus to
 * @param sBonus   String name of the source for this bonus
 * @param iVal     Integer value to set this bonus to (damage +1 through +20)
 * @param iSubType IP_CONST_DAMAGETYPE* constant -- leave blank to use the weapon's damage type.
 */
void SetCompositeDamageBonusT(object oItem, string sBonus, int iVal, int iSubType = -1); // for temporary bonuses

/**
 * Removes a number of itemproperties matching the parameters.
 *
 * @param oItem     The item to remove itemproperties from.
 * @param iType     ITEM_PROPERTY_* constant.
 * @param iSubType  IP_CONST_* constant of the itemproperty subtype or -1 to
 *                  match all possible subtypes. Also use -1 if the itemproperty
 *                  has no subtypes.
 * @param iCostVal  CostTableValue of the itemproperty to remove. Again, -1 for
 *                  any.
 * @param iNum      How many matching itemproperties to remove. -1 for all. Defaults
 *                  to 1.
 * @param sFlag     Name of a local integer on the item to set to 0 when this is run.
 *                  If anyone knows why the fuck this is done, please write here - Ornedan
 * @param iParam1   Param1 value of the itemproperty to remove. Again, -1 for any.
 * @param iDuration DURATION_TYPE_* constant. The duration type of the itemproperty.
 *                  Again, -1 for any.
 */
void RemoveSpecificProperty(object oItem, int iType, int iSubType = -1, int iCostVal = -1, int iNum = 1,
                            string sFlag = "", int iParam1 = -1, int iDuration = DURATION_TYPE_PERMANENT);

/**
 * Finds the first itemproperty matching the parameters.
 *   Use GetIsItemPropertyValid() to check if an itemproperty exists.
 *
 * @param oItem     The item to remove itemproperties from.
 * @param iType     ITEM_PROPERTY_* constant.
 * @param iSubType  IP_CONST_* constant of the itemproperty subtype or -1 to
 *                  match all possible subtypes. Also use -1 if the itemproperty
 *                  has no subtypes.
 * @param iCostVal  CostTableValue of the itemproperty to remove. Again, -1 for
 *                  any.
 * @param iParam1   Param1 value of the itemproperty to remove. Again, -1 for any.
 * @param iDuration DURATION_TYPE_* constant. The duration type of the itemproperty.
 *                  Again, -1 for any.
 */
itemproperty GetSpecificProperty(object oItem, int iType, int iSubType = -1, int iCostVal = -1,
                            int iParam1 = -1, int iDuration = DURATION_TYPE_PERMANENT);

/**
 * Keeps track of Attack Bonus effects and stacks them appropriately... you cannot set up
 * "special" attack bonuses against races or alignments, but it will keep seperate tabs on
 * on-hand attack bonuses and off-hand attack bonuses.
 *
 * NOTE: This attack bonus is an effect on the creature, not an item property.  Item Property
 * attacks have the downside that they pierce DR, whereas effects do not.
 *
 * NOTE: DO *NOT* USE THIS FUNCTION WITH SPELL/SLA EFFECTS.  They stack fine on their own.
 *
 * <DEPRECATED>
 * LocalInts in and finally SetCompositeAttackBonus() need to be added to
 * DeletePRCLocalInts() in prc_inc_function.
 * </DEPRECATED>
 *
 *
 * @param oPC      PC/NPC you wish to apply an attack bonus effect to
 * @param sBonus   The unique name you wish to give this attack bonus
 * @param iVal     The amount the attack bonus should be (there is a hardcoded limit of 20)
 * @param iSubType ATTACK_BONUS_MISC applies to both hands, ATTACK_BONUS_ONHAND applies to the right (main)
 *                 hand, and ATTACK_BONUS_OFFHAND applies to the left (off) hand
 */
void SetCompositeAttackBonus(object oPC, string sBonus, int iVal, int iSubType = ATTACK_BONUS_MISC);

/**
 * Internal function.
 * Handles maintaining a list of composite itemproperty names for
 * use when clearing the itemproperties away.
 *
 * @param oItem      The item a composite bonus is being set on.
 * @param sBase      The base name for the local variables used. For differentiating between
 *                   permanent and temporary lists.
 * @param sComposite The name of a composite property being set.
 */
void UpdateUsedCompositeNamesList(object oItem, string sBase, string sComposite);

/**
 * Internal function.
 * Deletes all the composite itemproperty names listed and deletes the list.
 *
 * @param oItem The item being cleaned of composite properties.
 * @param sBase The base name for the local variables used. For differentiating between
 *              permanent and temporary lists.
 */
void DeleteNamedComposites(object oItem, string sBase);

/**
 * Determines if any of the given item's itemproperties would make it a
 * magical item.
 *
 * @param oItem The item to test
 * @return      TRUE if the item is a magical item, FALSE otherwise
 */
int GetIsMagicItem(object oItem);

//////////////////////////////////////////////////
/* Include section                              */
//////////////////////////////////////////////////

#include "inc_2dacache"
#include "inc_persist_loca"
#include "inc_prc_npc"
//#include "inc_utility"
#include "prc_ipfeat_const"
#include "inc_array"

//////////////////////////////
// Function Definitions     //
//////////////////////////////

int TotalAndRemoveProperty(object oItem, int iType, int iSubType = -1)
{
    itemproperty ip = GetFirstItemProperty(oItem);
    int total = 0;

    while(GetIsItemPropertyValid(ip)){
        if(GetItemPropertyType(ip) == iType && (GetItemPropertySubType(ip) == iSubType || iSubType == -1)){
            total += GetItemPropertyCostTableValue(ip);
            RemoveItemProperty(oItem, ip);
        }
        ip = GetNextItemProperty(oItem);
    }
    return total;
}

itemproperty GetSpecificProperty(object oItem, int iType, int iSubType = -1, int iCostVal = -1,
                            int iParam1 = -1, int iDuration = DURATION_TYPE_PERMANENT)
{
    itemproperty ip = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ip)){
        if(GetItemPropertyType(ip)            == iType                          &&
           (GetItemPropertyDurationType(ip)   == iDuration || iDuration == -1)  &&
           (GetItemPropertySubType(ip)        == iSubType  || iSubType  == -1)  &&
           (GetItemPropertyCostTableValue(ip) == iCostVal  || iCostVal  == -1)  &&
           (GetItemPropertyParam1Value(ip)    == iParam1   || iParam1   == -1)
          )
        {
            return ip;
        }
        ip = GetNextItemProperty(oItem);
    }
    return ip;
}

void RemoveSpecificProperty(object oItem, int iType, int iSubType = -1, int iCostVal = -1, int iNum = 1,
                            string sFlag = "", int iParam1 = -1, int iDuration = DURATION_TYPE_PERMANENT)
{
    int iRemoved = 0;
    itemproperty ip = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ip) && (iRemoved < iNum || iNum == -1)){
        if(GetItemPropertyType(ip)            == iType                          &&
           (GetItemPropertyDurationType(ip)   == iDuration || iDuration == -1)  &&
           (GetItemPropertySubType(ip)        == iSubType  || iSubType  == -1)  &&
           (GetItemPropertyCostTableValue(ip) == iCostVal  || iCostVal  == -1)  &&
           (GetItemPropertyParam1Value(ip)    == iParam1   || iParam1   == -1)
          )
        {
            RemoveItemProperty(oItem, ip);
            iRemoved++;
        }
        ip = GetNextItemProperty(oItem);
    }
    SetLocalInt(oItem, sFlag, 0);
}

//SetCompositeBonus is a special case that doesn't need to use DelayAddItemProperty because
//the property that is added is always different from the one that was deleted by TotalAndRemoveProperty.
void SetCompositeBonus(object oItem, string sBonus, int iVal, int iType, int iSubType = -1)
{
    int iOldVal = GetLocalInt(oItem, sBonus);
    int iChange = iVal - iOldVal;
    int iCurVal = 0;

    if(iChange == 0) return;

    // Store the bonus name for use during cleanup
    UpdateUsedCompositeNamesList(oItem, "PRC_CBon", sBonus);

    //Moved TotalAndRemoveProperty into switch to prevent
    //accidental deletion of unsupported property types
    switch(iType)
    {
        case ITEM_PROPERTY_ABILITY_BONUS:
            iCurVal = TotalAndRemoveProperty(oItem, iType, iSubType);
            iCurVal -= GetPersistantLocalInt(GetItemPossessor(oItem), "LetoAbility_"+IntToString(iSubType));
            if ((iCurVal + iChange)  > 12)
            {
                iVal -= iCurVal + iChange - 12;
                iCurVal = 12;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAbilityBonus(iSubType, iCurVal + iChange), oItem);
            else if(iCurVal+iChange < 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDecreaseAbility(iSubType, -1*(iCurVal + iChange)), oItem);
            break;
        case ITEM_PROPERTY_AC_BONUS:
            iCurVal = TotalAndRemoveProperty(oItem, iType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonus(iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP:
            iCurVal = TotalAndRemoveProperty(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsAlign(iSubType, iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE:
            iCurVal = TotalAndRemoveProperty(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsDmgType(iSubType, iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP:
            iCurVal = TotalAndRemoveProperty(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(iSubType, iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT:
            iCurVal = TotalAndRemoveProperty(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsSAlign(iSubType, iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_ATTACK_BONUS:
            iCurVal = TotalAndRemoveProperty(oItem, iType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAttackBonus(iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP:
            iCurVal = TotalAndRemoveProperty(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAttackBonusVsAlign(iSubType, iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP:
            iCurVal = TotalAndRemoveProperty(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAttackBonusVsRace(iSubType, iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT:
            iCurVal = TotalAndRemoveProperty(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAttackBonusVsSAlign(iSubType, iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_DECREASED_ABILITY_SCORE:
            iCurVal = TotalAndRemoveProperty(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 10)
            {
                iVal -= iCurVal + iChange - 10;
                iCurVal = 10;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDecreaseAbility(iSubType, iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_DECREASED_AC:
            iCurVal = TotalAndRemoveProperty(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 5)
            {
                iVal -= iCurVal + iChange - 5;
                iCurVal = 5;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDecreaseAC(iSubType, iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER:
            iCurVal = TotalAndRemoveProperty(oItem, iType);
            if ((iCurVal + iChange)  > 5)
            {
                iVal -= iCurVal + iChange - 5;
                iCurVal = 5;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAttackPenalty(iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER:
            iCurVal = TotalAndRemoveProperty(oItem, iType);
            if ((iCurVal + iChange)  > 5)
            {
                iVal -= iCurVal + iChange - 5;
                iCurVal = 5;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementPenalty(iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_DECREASED_SAVING_THROWS:
            iCurVal = TotalAndRemoveProperty(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyReducedSavingThrowVsX(iSubType, iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC:
            iCurVal = TotalAndRemoveProperty(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyReducedSavingThrow(iSubType, iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_DECREASED_SKILL_MODIFIER:
            iCurVal = TotalAndRemoveProperty(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 10)
            {
                iVal -= iCurVal + iChange - 10;
                iCurVal = 10;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDecreaseSkill(iSubType, iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_ENHANCEMENT_BONUS:
            iCurVal = TotalAndRemoveProperty(oItem, iType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonus(iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP:
            iCurVal = TotalAndRemoveProperty(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonusVsAlign(iSubType, iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP:
            iCurVal = TotalAndRemoveProperty(oItem, iType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonusVsRace(iSubType, iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT:
            iCurVal = TotalAndRemoveProperty(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonusVsSAlign(iSubType, iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_MIGHTY:
            iCurVal = TotalAndRemoveProperty(oItem, iType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMaxRangeStrengthMod(iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_REGENERATION:
            iCurVal = TotalAndRemoveProperty(oItem, iType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyRegeneration(iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_REGENERATION_VAMPIRIC:
            iCurVal = TotalAndRemoveProperty(oItem, iType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyVampiricRegeneration(iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_SAVING_THROW_BONUS:
            iCurVal = TotalAndRemoveProperty(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusSavingThrowVsX(iSubType, iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC:
            iCurVal = TotalAndRemoveProperty(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusSavingThrow(iSubType, iCurVal + iChange), oItem);
            break;
        case ITEM_PROPERTY_SKILL_BONUS:
            iCurVal = TotalAndRemoveProperty(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 50)
            {
                iVal -= iCurVal + iChange - 50;
                iCurVal = 50;
                iChange = 0;
            }
            if(iCurVal+iChange > 0)
                AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySkillBonus(iSubType, iCurVal + iChange), oItem);
            break;
    }
    SetLocalInt(oItem, sBonus, iVal);
}

int GetACBonus(object oItem)
{
    if(!GetIsObjectValid(oItem)) return 0;

    itemproperty ip = GetFirstItemProperty(oItem);
    int iTotal = 0;

    while(GetIsItemPropertyValid(ip)){
        if(GetItemPropertyType(ip) == ITEM_PROPERTY_AC_BONUS)
            iTotal += GetItemPropertyCostTableValue(ip);
        ip = GetNextItemProperty(oItem);
    }
    return iTotal;
}

int GetBaseAC(object oItem){ return GetItemACValue(oItem) - GetACBonus(oItem); }

int GetOppositeElement(int iElem)
{
    switch(iElem){
        case IP_CONST_DAMAGETYPE_ACID:
            return DAMAGE_TYPE_ELECTRICAL;
        case IP_CONST_DAMAGETYPE_COLD:
            return IP_CONST_DAMAGETYPE_FIRE;
        case IP_CONST_DAMAGETYPE_DIVINE:
            return IP_CONST_DAMAGETYPE_NEGATIVE;
        case IP_CONST_DAMAGETYPE_ELECTRICAL:
            return IP_CONST_DAMAGETYPE_ACID;
        case IP_CONST_DAMAGETYPE_FIRE:
            return IP_CONST_DAMAGETYPE_COLD;
        case IP_CONST_DAMAGETYPE_NEGATIVE:
            return IP_CONST_DAMAGETYPE_POSITIVE;
     }
     return -1;
}

int TotalAndRemovePropertyT(object oItem, int iType, int iSubType = -1)
{
    itemproperty ip = GetFirstItemProperty(oItem);
    int total = 0;
    int iTemp;

    while(GetIsItemPropertyValid(ip)){
        if(GetItemPropertyType(ip) == iType && (GetItemPropertySubType(ip) == iSubType || iSubType == -1)){
             iTemp = GetItemPropertyCostTableValue(ip);
            total = iTemp > total ? iTemp : total;
            if (GetItemPropertyDurationType(ip)== DURATION_TYPE_TEMPORARY) RemoveItemProperty(oItem, ip);
        }
        ip = GetNextItemProperty(oItem);
    }
    return total;
}

//SetCompositeBonusT is a special case that doesn't need to use DelayAddItemProperty because
//the property that is added is always different from the one that was deleted by TotalAndRemovePropertyT.
void SetCompositeBonusT(object oItem, string sBonus, int iVal, int iType, int iSubType = -1)
{
    int iOldVal = GetLocalInt(oItem, sBonus);
    if (GetLocalInt(GetItemPossessor(oItem),"ONREST")) iOldVal =0;
    int iChange = iVal - iOldVal;
    int iCurVal = 0;

    if(iChange == 0) return;

    // Store the bonus name for use during cleanup
    UpdateUsedCompositeNamesList(oItem, "PRC_CBonT", sBonus);

    //Moved TotalAndRemoveProperty into switch to prevent
    //accidental deletion of unsupported property types
    switch(iType)
    {
        case ITEM_PROPERTY_ABILITY_BONUS:
            iCurVal = TotalAndRemovePropertyT(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 12)
            {
                iVal -= iCurVal + iChange - 12;
                iCurVal = 12;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyAbilityBonus(iSubType, iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_AC_BONUS:
            iCurVal = TotalAndRemovePropertyT(oItem, iType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyACBonus(iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP:
            iCurVal = TotalAndRemovePropertyT(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyACBonusVsAlign(iSubType, iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE:
            iCurVal = TotalAndRemovePropertyT(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyACBonusVsDmgType(iSubType, iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP:
            iCurVal = TotalAndRemovePropertyT(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyACBonusVsRace(iSubType, iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT:
            iCurVal = TotalAndRemovePropertyT(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyACBonusVsSAlign(iSubType, iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_ATTACK_BONUS:
            iCurVal = TotalAndRemovePropertyT(oItem, iType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyAttackBonus(iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP:
            iCurVal = TotalAndRemovePropertyT(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyAttackBonusVsAlign(iSubType, iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP:
            iCurVal = TotalAndRemovePropertyT(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyAttackBonusVsRace(iSubType, iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT:
            iCurVal = TotalAndRemovePropertyT(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyAttackBonusVsSAlign(iSubType, iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_DECREASED_ABILITY_SCORE:
            iCurVal = TotalAndRemovePropertyT(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyDecreaseAbility(iSubType, iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_DECREASED_AC:
            iCurVal = TotalAndRemovePropertyT(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 5)
            {
                iVal -= iCurVal + iChange - 5;
                iCurVal = 5;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyDecreaseAC(iSubType, iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER:
            iCurVal = TotalAndRemovePropertyT(oItem, iType);
            if ((iCurVal + iChange)  > 5)
            {
                iVal -= iCurVal + iChange - 5;
                iCurVal = 5;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyAttackPenalty(iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER:
            iCurVal = TotalAndRemovePropertyT(oItem, iType);
            if ((iCurVal + iChange)  > 5)
            {
                iVal -= iCurVal + iChange - 5;
                iCurVal = 5;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyEnhancementPenalty(iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_DECREASED_SAVING_THROWS:
            iCurVal = TotalAndRemovePropertyT(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyReducedSavingThrowVsX(iSubType, iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC:
            iCurVal = TotalAndRemovePropertyT(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyReducedSavingThrow(iSubType, iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_DECREASED_SKILL_MODIFIER:
            iCurVal = TotalAndRemovePropertyT(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 10)
            {
                iVal -= iCurVal + iChange - 10;
                iCurVal = 10;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyDecreaseSkill(iSubType, iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_ENHANCEMENT_BONUS:
            iCurVal = TotalAndRemovePropertyT(oItem, iType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyEnhancementBonus(iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP:
            iCurVal = TotalAndRemovePropertyT(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyEnhancementBonusVsAlign(iSubType, iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP:
            iCurVal = TotalAndRemovePropertyT(oItem, iType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyEnhancementBonusVsRace(iSubType, iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT:
            iCurVal = TotalAndRemovePropertyT(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyEnhancementBonusVsSAlign(iSubType, iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_MIGHTY:
            iCurVal = TotalAndRemovePropertyT(oItem, iType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyMaxRangeStrengthMod(iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_REGENERATION:
            iCurVal = TotalAndRemovePropertyT(oItem, iType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyRegeneration(iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_REGENERATION_VAMPIRIC:
            iCurVal = TotalAndRemovePropertyT(oItem, iType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyVampiricRegeneration(iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_SAVING_THROW_BONUS:
            iCurVal = TotalAndRemovePropertyT(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyBonusSavingThrowVsX(iSubType, iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC:
            iCurVal = TotalAndRemovePropertyT(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 20)
            {
                iVal -= iCurVal + iChange - 20;
                iCurVal = 20;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyBonusSavingThrow(iSubType, iCurVal + iChange), oItem,9999.0);
            break;
        case ITEM_PROPERTY_SKILL_BONUS:
            iCurVal = TotalAndRemovePropertyT(oItem, iType, iSubType);
            if ((iCurVal + iChange)  > 50)
            {
                iVal -= iCurVal + iChange - 50;
                iCurVal = 50;
                iChange = 0;
            }
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertySkillBonus(iSubType, iCurVal + iChange), oItem,9999.0);
            break;
    }
    SetLocalInt(oItem, sBonus, iVal);
}

int GetItemPropertyDamageType(object oWeapon)
{
    if(GetObjectType(oWeapon) != OBJECT_TYPE_ITEM)
        return -1;

    int iWeaponType = GetBaseItemType(oWeapon);
    int iDamageType = StringToInt(Get2DACache("baseitems","WeaponType",iWeaponType));
    switch(iDamageType)
    {
        case 1: return IP_CONST_DAMAGETYPE_PIERCING;    break;
        case 2: return IP_CONST_DAMAGETYPE_BLUDGEONING; break;
        case 3: return IP_CONST_DAMAGETYPE_SLASHING;    break;
        case 4: return IP_CONST_DAMAGETYPE_SLASHING;    break; // slashing & piercing... slashing bonus.

        default: return -1;
    }
    return -1;
}

int GetItemDamageType(object oWeapon)
{
    if(GetObjectType(oWeapon) != OBJECT_TYPE_ITEM)
        return -1;

    int iWeaponType = GetBaseItemType(oWeapon);
    int iDamageType = StringToInt( Get2DACache("baseitems","WeaponType",iWeaponType) );
    switch(iDamageType)
    {
        case 1: return DAMAGE_TYPE_PIERCING;    break;
        case 2: return DAMAGE_TYPE_BLUDGEONING; break;
        case 3: return DAMAGE_TYPE_SLASHING;    break;
        case 4: return DAMAGE_TYPE_SLASHING;    break; // slashing & piercing... slashing bonus.

        default: return -1;
    }
    return -1;
}

// To ensure the damage bonus stacks with any existing enhancement bonus,
// we create a temporary damage bonus on the weapon.  We do not want to do this
// if the weapon is of the "slashing and piercing" type, because the
// enhancement bonus is considered "physical", not "slashing" or "piercing".
// If you borrow this code, make sure to keep the "IPEnh" and realize that
// "slashing and piercing" weapons need a special case.
void IPEnhancementBonusToDamageBonus(object oWeap)
{
    int iBonus = 0;
    int iTemp;

    if (GetLocalInt(oWeap, "IPEnh") || !GetIsObjectValid(oWeap)) return;

    itemproperty ip = GetFirstItemProperty(oWeap);
    while(GetIsItemPropertyValid(ip))
    {
        if(GetItemPropertyType(ip) == ITEM_PROPERTY_ENHANCEMENT_BONUS)
            iTemp = GetItemPropertyCostTableValue(ip);
            iBonus = iTemp > iBonus ? iTemp : iBonus;
        ip = GetNextItemProperty(oWeap);
    }

    SetCompositeDamageBonusT(oWeap,"IPEnh",iBonus);
}

int TotalAndRemoveDamagePropertyT(object oItem, int iSubType)
{
    itemproperty ip = GetFirstItemProperty(oItem);
    int iPropertyValue;
    int total = 0;
    int iTemp;

    while(GetIsItemPropertyValid(ip))
    {
        iPropertyValue = GetItemPropertyCostTableValue(ip);

        if((GetItemPropertyType(ip) == ITEM_PROPERTY_DAMAGE_BONUS) &&
           (GetItemPropertySubType(ip) == iSubType) &&
           ((iPropertyValue < 6) || (iPropertyValue > 15)))
        {
            total = iPropertyValue > total ? iPropertyValue : total;
            if (GetItemPropertyDurationType(ip)== DURATION_TYPE_TEMPORARY) RemoveItemProperty(oItem, ip);
       }
        ip = GetNextItemProperty(oItem);

    }
    return total;
}

void SetCompositeDamageBonusT(object oItem, string sBonus, int iVal, int iSubType = -1)
{
    int iOldVal = GetLocalInt(oItem, sBonus);
    int iChange = iVal - iOldVal;
    int iLinearDamage = 0;
    int iCurVal = 0;

    if(iChange == 0) return;

    // Store the bonus name for use during cleanup
    UpdateUsedCompositeNamesList(oItem, "PRC_CBonT", sBonus);

    if (iSubType == -1) iSubType = GetItemPropertyDamageType(oItem);
    if (iSubType == -1) return;  // if it's still -1 we're not dealing with a weapon.

    iCurVal = TotalAndRemoveDamagePropertyT(oItem, iSubType);

    if (iCurVal > 15) iCurVal -= 10; // values 6-20 are in the 2da as lines 16-30
    iLinearDamage = iCurVal + iChange;
    if (iLinearDamage > 20)
    {
        iVal = iLinearDamage - 20; // Change the stored value to reflect the fact that we overflowed
        iLinearDamage = 20; // This is prior to adjustment due to non-linear values
    }
    if (iLinearDamage > 5) iLinearDamage += 10; // values 6-20 are in the 2da as lines 16-30
    AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyDamageBonus(iSubType, iLinearDamage), oItem,9999.0);

    SetLocalInt(oItem, sBonus, iVal);
}

void TotalRemovePropertyT(object oItem)
{
    itemproperty ip = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ip)){
            if (GetItemPropertyDurationType(ip)== DURATION_TYPE_TEMPORARY) RemoveItemProperty(oItem, ip);
          ip = GetNextItemProperty(oItem);
        }
}

void DeletePRCLocalIntsT(object oPC, object oItem = OBJECT_INVALID)
{
    // See if we were given a valid item as parameter. If we were, we
    // will be removing ints from it.
    // Otherwise, we will take the item in each slot and removing the
    // ints that should be on it.
    int bGivenObject = GetIsObjectValid(oItem);

    // RIGHT HAND
    if(!bGivenObject)
        oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);

    if(bGivenObject || GetIsObjectValid(oItem))
    {
        // Clear composite bonuses
        TotalRemovePropertyT(oItem);
        DeleteNamedComposites(oItem, "PRC_CBonT");

        /* Clear other stuff
         *
         * All the commented out values are the ones that didn't seem to be used anywhere anymore - Ornedan
         */
        //Stormlord
        DeleteLocalInt(oItem,"STShock"); /// @todo Rewrite the Stormlord not to directly manipulate values
        DeleteLocalInt(oItem,"STThund");
        DeleteLocalInt(oItem,"ManArmsCore");
        //Vile/Sanctify & Un/Holy Martial Strike
        DeleteLocalInt(oItem,"SanctMar");
        DeleteLocalInt(oItem,"MartialStrik");
        DeleteLocalInt(oItem,"UnholyStrik");
        DeleteLocalInt(oItem,"USanctMar");
        //Duelist Precise Strike
        DeleteLocalInt(oItem,"DuelistPreciseSlash");
        //DeleteLocalInt(oItem,"DuelistPreciseSmash");
        // Black Flame Zealot
        DeleteLocalInt(oItem,"BFZFlame");
        // Dispater
        DeleteLocalInt(oItem,"DispIronPowerA");
        DeleteLocalInt(oItem,"DispIronPowerD");
        // Dragonwrack
        DeleteLocalInt(oItem,"DWright");
    }

    // LEFT HAND
    if(!bGivenObject)
        oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);

    if(bGivenObject || GetIsObjectValid(oItem))
    {
        if(!bGivenObject)
        {
            // Clear composite bonuses
            TotalRemovePropertyT(oItem);
            DeleteNamedComposites(oItem, "PRC_CBonT");
        }

        //Vile/Sanctify & Un/Holy Martial Strike
        DeleteLocalInt(oItem,"SanctMar");
        DeleteLocalInt(oItem,"MartialStrik");
        DeleteLocalInt(oItem,"UnholyStrik");
        DeleteLocalInt(oItem,"USanctMar");
        // Dragonwrack
        DeleteLocalInt(oItem,"DWleft");
        // Dispater
        DeleteLocalInt(oItem,"DispIronPowerA");
        DeleteLocalInt(oItem,"DispIronPowerD");
    }

    // CHEST
    if(!bGivenObject)
        oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);

    if(bGivenObject || GetIsObjectValid(oItem))
    {
        if(!bGivenObject)
        {
            // Clear composite bonuses
            TotalRemovePropertyT(oItem);
            DeleteNamedComposites(oItem, "PRC_CBonT");
        }

        // Bladesinger
        DeleteLocalInt(oItem,"BladeASF");
        // Frenzied Berzerker
        DeleteLocalInt(oItem,"AFrenzy");
        // Shadowlord
        DeleteLocalInt(oItem,"ShaDiscorp");
        // Dragonwrack
        DeleteLocalInt(oItem,"Dragonwrack");
    }

    // LEFT RING
    if(!bGivenObject)
        oItem = GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC);

    if(bGivenObject || GetIsObjectValid(oItem))
    {
        if(!bGivenObject)
        {
            // Clear composite bonuses
            TotalRemovePropertyT(oItem);
            DeleteNamedComposites(oItem, "PRC_CBonT");
        }
    }

    // ARMS
    if(!bGivenObject)
        oItem = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);

    if(bGivenObject || GetIsObjectValid(oItem))
    {
        if(!bGivenObject)
        {
            // Clear composite bonuses
            TotalRemovePropertyT(oItem);
            DeleteNamedComposites(oItem, "PRC_CBonT");
        }

        // Disciple of Mephistopheles
        DeleteLocalInt(oItem,"DiscMephGlove");
    }
}

void SetCompositeAttackBonus(object oPC, string sBonus, int iVal, int iSubType = ATTACK_BONUS_MISC)
{
    object oCastingObject = CreateObject(OBJECT_TYPE_PLACEABLE, "x0_rodwonder", GetLocation(oPC));

    int iSpl = 2732; //SPELL_SET_COMPOSITE_ATTACK_BONUS;

    SetLocalString(oCastingObject, "SET_COMPOSITE_STRING", sBonus);
    SetLocalInt(oCastingObject, "SET_COMPOSITE_VALUE", iVal);
    SetLocalInt(oCastingObject, "SET_COMPOSITE_SUBTYPE", iSubType);

    DelayCommand(0.1, AssignCommand(oCastingObject, ActionCastSpellAtObject(iSpl, oPC, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));

    DestroyObject(oCastingObject, 6.0);
}

int GetSRByValue(int nValue)
{
    switch(nValue)
    {
        case  1: return 52;
        case  2: return 53;
        case  3: return 54;
        case  4: return 55;
        case  5: return 56;
        case  6: return 57;
        case  7: return 58;
        case  8: return 59;
        case  9: return 60;
        case 10: return  0;
        case 12: return  1;
        case 14: return  2;
        case 16: return  3;
        case 18: return  4;
        case 20: return  5;
        case 22: return  6;
        case 24: return  7;
        case 26: return  8;
        case 28: return  9;
        case 30: return 10;
        case 32: return 11;
        case 34: return 12;
        case 36: return 13;
        case 38: return 14;
        case 40: return 15;
        case 42: return 16;
        case 44: return 17;
        case 46: return 18;
        case 48: return 19;
        case 50: return 20;
        case 52: return 21;
        case 54: return 22;
        case 56: return 23;
        case 58: return 24;
        case 60: return 25;
        case 11: return 26;
        case 13: return 27;
        case 15: return 28;
        case 17: return 29;
        case 19: return 30;
        case 21: return 31;
        case 23: return 32;
        case 25: return 33;
        case 27: return 34;
        case 29: return 35;
        case 31: return 36;
        case 33: return 37;
        case 35: return 38;
        case 37: return 39;
        case 39: return 40;
        case 41: return 41;
        case 43: return 42;
        case 45: return 43;
        case 47: return 44;
        case 49: return 45;
        case 51: return 46;
        case 53: return 47;
        case 55: return 48;
        case 57: return 49;
        case 59: return 50;
        case 61: return 51;
    }
    if(nValue < 1)
        return -1;
    if(nValue > 98)
        return 61;//99 max
    if(nValue > 61)
        return 51;//61 flat cap
    return -1;
}

void UpdateUsedCompositeNamesList(object oItem, string sBase, string sComposite)
{
    // Add the bonus name to the list if it isn't there already
    if(!GetLocalInt(oItem, sBase + "_Exist_" + sComposite))
    {
        if(DEBUG) DoDebug("Storing the composite name '" + sComposite + "' for later deletion");

        string sArrayName = sBase + "_Names";
        // Create the array if it doesn't exist already
        if(!array_exists(oItem, sArrayName))
            array_create(oItem, sArrayName);

        // Store the bonus name in a list
        array_set_string(oItem, sArrayName, array_get_size(oItem, sArrayName), sComposite);

        // Store a marker so we don't need to loop over the list to find out if the name has been stored already
        SetLocalInt(oItem, sBase + "_Exist_" + sComposite, TRUE);
    }
}

void DeleteNamedComposites(object oItem, string sBase)
{
    if(DEBUG) DoDebug("Deleting composite bonus list '" + sBase + "' on " + DebugObject2Str(oItem));

    string sArrayName = sBase + "_Names";
    string sComposite;
    int nMax = array_get_size(oItem, sArrayName);
    int i = 0;

    // Delete all composite values and markers
    for(; i < nMax; i++)
    {
        sComposite = array_get_string(oItem, sArrayName, i);
        if(DEBUG) DoDebug("Deleting bonus marker '" + sComposite + "'");
        DeleteLocalInt(oItem, sComposite);
        DeleteLocalInt(oItem, sBase + "_Exist_" + sComposite);
    }

    // Delete the array
    array_delete(oItem, sArrayName);
}

int GetIsMagicItem(object oItem)
{
    itemproperty ip = GetFirstItemProperty(oItem);
    int nType;
    int nSubtype;
    while(GetIsItemPropertyValid(ip))   //loop through item properties looking for a magical one
    {
        if(GetItemPropertyDurationType(ip) == DURATION_TYPE_PERMANENT)
        {   //ignore temporary properties
            nType = GetItemPropertyType(ip);
            if((nType >= 0 && nType <= 9) ||    //read from itempropdef.2da
                (nType >= 13 && nType <= 20) ||
                (nType == 26) ||
                (nType >= 32 && nType <= 44) ||
                (nType == 46) ||
                (nType >= 51 && nType <= 59) ||
                (nType == 61) ||
                (nType >= 67 && nType <= 69) ||
                (nType >= 71 && nType <= 80) ||
                (nType == 82) ||
                (nType == 84) ||
                (nType >= 100 && nType <= 101) ||
                (nType >= 133 && nType <= 134))
            {
                return 1;   //magical property
            }
            nSubtype = GetItemPropertySubType(ip);

            if(nType == ITEM_PROPERTY_BONUS_FEAT)
            {
                if(GetBaseItemType(oItem) == BASE_ITEM_WHIP)
                {
                    if(nSubtype != IP_CONST_FEAT_DISARM_WHIP)
                        return 1;
                }
                else
                    return 1;
            }
            ip = GetNextItemProperty(oItem);
        }
    }
    return 0;
}

int FeatToIprop(int nFeat)
{
            switch(nFeat)
            {
            case FEAT_WEAPON_FOCUS_BASTARD_SWORD: return IP_CONST_FEAT_WEAPON_FOCUS_BASTARD_SWORD;
            case FEAT_WEAPON_FOCUS_BATTLE_AXE: return IP_CONST_FEAT_WEAPON_FOCUS_BATTLE_AXE;
            case FEAT_WEAPON_FOCUS_CLUB: return IP_CONST_FEAT_WEAPON_FOCUS_CLUB;
            case FEAT_WEAPON_FOCUS_DAGGER: return IP_CONST_FEAT_WEAPON_FOCUS_DAGGER;
            case FEAT_WEAPON_FOCUS_DART: return IP_CONST_FEAT_WEAPON_FOCUS_DART;
            case FEAT_WEAPON_FOCUS_DIRE_MACE: return IP_CONST_FEAT_WEAPON_FOCUS_DIRE_MACE;
            case FEAT_WEAPON_FOCUS_DOUBLE_AXE: return IP_CONST_FEAT_WEAPON_FOCUS_DOUBLE_AXE;
            case FEAT_WEAPON_FOCUS_DWAXE: return IP_CONST_FEAT_WEAPON_FOCUS_DWAXE;
            case FEAT_WEAPON_FOCUS_GREAT_AXE: return IP_CONST_FEAT_WEAPON_FOCUS_GREAT_AXE;
            case FEAT_WEAPON_FOCUS_GREAT_SWORD: return IP_CONST_FEAT_WEAPON_FOCUS_GREAT_SWORD;
            case FEAT_WEAPON_FOCUS_HALBERD: return IP_CONST_FEAT_WEAPON_FOCUS_HALBERD;
            case FEAT_WEAPON_FOCUS_HAND_AXE: return IP_CONST_FEAT_WEAPON_FOCUS_HAND_AXE;
            case FEAT_WEAPON_FOCUS_HEAVY_CROSSBOW: return IP_CONST_FEAT_WEAPON_FOCUS_HEAVY_CROSSBOW;
            case FEAT_WEAPON_FOCUS_HEAVY_FLAIL: return IP_CONST_FEAT_WEAPON_FOCUS_HEAVY_FLAIL;
            case FEAT_WEAPON_FOCUS_KAMA: return IP_CONST_FEAT_WEAPON_FOCUS_KAMA;
            case FEAT_WEAPON_FOCUS_KATANA: return IP_CONST_FEAT_WEAPON_FOCUS_KATANA;
            case FEAT_WEAPON_FOCUS_KUKRI: return IP_CONST_FEAT_WEAPON_FOCUS_KUKRI;
            case FEAT_WEAPON_FOCUS_LIGHT_CROSSBOW: return IP_CONST_FEAT_WEAPON_FOCUS_LIGHT_CROSSBOW;
            case FEAT_WEAPON_FOCUS_LIGHT_FLAIL: return IP_CONST_FEAT_WEAPON_FOCUS_LIGHT_FLAIL;
            case FEAT_WEAPON_FOCUS_LIGHT_HAMMER: return IP_CONST_FEAT_WEAPON_FOCUS_LIGHT_HAMMER;
            case FEAT_WEAPON_FOCUS_LIGHT_MACE: return IP_CONST_FEAT_WEAPON_FOCUS_LIGHT_MACE;
            case FEAT_WEAPON_FOCUS_LONG_SWORD: return IP_CONST_FEAT_WEAPON_FOCUS_LONG_SWORD;
            case FEAT_WEAPON_FOCUS_LONGBOW: return IP_CONST_FEAT_WEAPON_FOCUS_LONGBOW;
            case FEAT_WEAPON_FOCUS_MORNING_STAR: return IP_CONST_FEAT_WEAPON_FOCUS_MORNING_STAR;
            case FEAT_WEAPON_FOCUS_STAFF: return IP_CONST_FEAT_WEAPON_FOCUS_STAFF;
            case FEAT_WEAPON_FOCUS_RAPIER: return IP_CONST_FEAT_WEAPON_FOCUS_RAPIER;
            case FEAT_WEAPON_FOCUS_SCIMITAR: return IP_CONST_FEAT_WEAPON_FOCUS_SCIMITAR;
            case FEAT_WEAPON_FOCUS_SCYTHE: return IP_CONST_FEAT_WEAPON_FOCUS_SCYTHE;
            case FEAT_WEAPON_FOCUS_SHORTBOW: return IP_CONST_FEAT_WEAPON_FOCUS_SHORTBOW;
            case FEAT_WEAPON_FOCUS_SPEAR: return IP_CONST_FEAT_WEAPON_FOCUS_SPEAR;
            case FEAT_WEAPON_FOCUS_SHORT_SWORD: return IP_CONST_FEAT_WEAPON_FOCUS_SHORT_SWORD;
            case FEAT_WEAPON_FOCUS_SHURIKEN: return IP_CONST_FEAT_WEAPON_FOCUS_SHURIKEN;
            case FEAT_WEAPON_FOCUS_SICKLE: return IP_CONST_FEAT_WEAPON_FOCUS_SICKLE;
            case FEAT_WEAPON_FOCUS_SLING: return IP_CONST_FEAT_WEAPON_FOCUS_SLING;
            case FEAT_WEAPON_FOCUS_THROWING_AXE: return IP_CONST_FEAT_WEAPON_FOCUS_THROWING_AXE;
            case FEAT_WEAPON_FOCUS_TWO_BLADED_SWORD: return IP_CONST_FEAT_WEAPON_FOCUS_TWO_BLADED_SWORD;
            case FEAT_WEAPON_FOCUS_WAR_HAMMER: return IP_CONST_FEAT_WEAPON_FOCUS_WAR_HAMMER;
            case FEAT_WEAPON_FOCUS_WHIP: return IP_CONST_FEAT_WEAPON_FOCUS_WHIP;

        case FEAT_WEAPON_SPECIALIZATION_CLUB: return              IP_CONST_FEAT_WEAPON_SPECIALIZATION_CLUB              ;
        case FEAT_WEAPON_SPECIALIZATION_DAGGER: return            IP_CONST_FEAT_WEAPON_SPECIALIZATION_DAGGER            ;
        case FEAT_WEAPON_SPECIALIZATION_DART: return              IP_CONST_FEAT_WEAPON_SPECIALIZATION_DART              ;
        case FEAT_WEAPON_SPECIALIZATION_HEAVY_CROSSBOW: return    IP_CONST_FEAT_WEAPON_SPECIALIZATION_HEAVY_CROSSBOW    ;
        case FEAT_WEAPON_SPECIALIZATION_LIGHT_CROSSBOW: return    IP_CONST_FEAT_WEAPON_SPECIALIZATION_LIGHT_CROSSBOW    ;
        case FEAT_WEAPON_SPECIALIZATION_LIGHT_MACE: return        IP_CONST_FEAT_WEAPON_SPECIALIZATION_LIGHT_MACE        ;
        case FEAT_WEAPON_SPECIALIZATION_MORNING_STAR: return      IP_CONST_FEAT_WEAPON_SPECIALIZATION_MORNING_STAR      ;
        case FEAT_WEAPON_SPECIALIZATION_STAFF: return             IP_CONST_FEAT_WEAPON_SPECIALIZATION_STAFF             ;
        case FEAT_WEAPON_SPECIALIZATION_SPEAR: return             IP_CONST_FEAT_WEAPON_SPECIALIZATION_SPEAR             ;
        case FEAT_WEAPON_SPECIALIZATION_SICKLE: return            IP_CONST_FEAT_WEAPON_SPECIALIZATION_SICKLE            ;
        case FEAT_WEAPON_SPECIALIZATION_SLING: return             IP_CONST_FEAT_WEAPON_SPECIALIZATION_SLING             ;
        case FEAT_WEAPON_SPECIALIZATION_UNARMED_STRIKE: return    IP_CONST_FEAT_WEAPON_SPECIALIZATION_UNARMED_STRIKE    ;
        case FEAT_WEAPON_SPECIALIZATION_LONGBOW: return           IP_CONST_FEAT_WEAPON_SPECIALIZATION_LONGBOW           ;
        case FEAT_WEAPON_SPECIALIZATION_SHORTBOW: return          IP_CONST_FEAT_WEAPON_SPECIALIZATION_SHORTBOW          ;
        case FEAT_WEAPON_SPECIALIZATION_SHORT_SWORD: return       IP_CONST_FEAT_WEAPON_SPECIALIZATION_SHORT_SWORD       ;
        case FEAT_WEAPON_SPECIALIZATION_RAPIER: return            IP_CONST_FEAT_WEAPON_SPECIALIZATION_RAPIER            ;
        case FEAT_WEAPON_SPECIALIZATION_SCIMITAR: return          IP_CONST_FEAT_WEAPON_SPECIALIZATION_SCIMITAR          ;
        case FEAT_WEAPON_SPECIALIZATION_LONG_SWORD: return        IP_CONST_FEAT_WEAPON_SPECIALIZATION_LONG_SWORD        ;
        case FEAT_WEAPON_SPECIALIZATION_GREAT_SWORD: return       IP_CONST_FEAT_WEAPON_SPECIALIZATION_GREAT_SWORD       ;
        case FEAT_WEAPON_SPECIALIZATION_HAND_AXE: return          IP_CONST_FEAT_WEAPON_SPECIALIZATION_HAND_AXE          ;
        case FEAT_WEAPON_SPECIALIZATION_THROWING_AXE: return      IP_CONST_FEAT_WEAPON_SPECIALIZATION_THROWING_AXE      ;
        case FEAT_WEAPON_SPECIALIZATION_BATTLE_AXE: return        IP_CONST_FEAT_WEAPON_SPECIALIZATION_BATTLE_AXE        ;
        case FEAT_WEAPON_SPECIALIZATION_GREAT_AXE: return         IP_CONST_FEAT_WEAPON_SPECIALIZATION_GREAT_AXE         ;
        case FEAT_WEAPON_SPECIALIZATION_HALBERD: return           IP_CONST_FEAT_WEAPON_SPECIALIZATION_HALBERD           ;
        case FEAT_WEAPON_SPECIALIZATION_LIGHT_HAMMER: return      IP_CONST_FEAT_WEAPON_SPECIALIZATION_LIGHT_HAMMER      ;
        case FEAT_WEAPON_SPECIALIZATION_LIGHT_FLAIL: return       IP_CONST_FEAT_WEAPON_SPECIALIZATION_LIGHT_FLAIL       ;
        case FEAT_WEAPON_SPECIALIZATION_WAR_HAMMER: return        IP_CONST_FEAT_WEAPON_SPECIALIZATION_WAR_HAMMER        ;
        case FEAT_WEAPON_SPECIALIZATION_HEAVY_FLAIL: return       IP_CONST_FEAT_WEAPON_SPECIALIZATION_HEAVY_FLAIL       ;
        case FEAT_WEAPON_SPECIALIZATION_KAMA: return              IP_CONST_FEAT_WEAPON_SPECIALIZATION_KAMA              ;
        case FEAT_WEAPON_SPECIALIZATION_KUKRI: return             IP_CONST_FEAT_WEAPON_SPECIALIZATION_KUKRI             ;
        case FEAT_WEAPON_SPECIALIZATION_SHURIKEN: return          IP_CONST_FEAT_WEAPON_SPECIALIZATION_SHURIKEN          ;
        case FEAT_WEAPON_SPECIALIZATION_SCYTHE: return            IP_CONST_FEAT_WEAPON_SPECIALIZATION_SCYTHE            ;
        case FEAT_WEAPON_SPECIALIZATION_KATANA: return            IP_CONST_FEAT_WEAPON_SPECIALIZATION_KATANA            ;
        case FEAT_WEAPON_SPECIALIZATION_BASTARD_SWORD: return     IP_CONST_FEAT_WEAPON_SPECIALIZATION_BASTARD_SWORD     ;
        case FEAT_WEAPON_SPECIALIZATION_DIRE_MACE: return         IP_CONST_FEAT_WEAPON_SPECIALIZATION_DIRE_MACE         ;
        case FEAT_WEAPON_SPECIALIZATION_DOUBLE_AXE: return        IP_CONST_FEAT_WEAPON_SPECIALIZATION_DOUBLE_AXE        ;
        case FEAT_WEAPON_SPECIALIZATION_TWO_BLADED_SWORD: return  IP_CONST_FEAT_WEAPON_SPECIALIZATION_TWO_BLADED_SWORD  ;
        case FEAT_WEAPON_SPECIALIZATION_DWAXE: return             IP_CONST_FEAT_WEAPON_SPECIALIZATION_DWAXE             ;
        case FEAT_WEAPON_SPECIALIZATION_WHIP: return              IP_CONST_FEAT_WEAPON_SPECIALIZATION_WHIP              ;
            }
    return - 1;
}

int FocusToWeapProf(int nFeat)
{
            switch(nFeat)
            {
            case FEAT_WEAPON_FOCUS_CLUB: return              BASE_ITEM_CLUB              ;
            case FEAT_WEAPON_FOCUS_DAGGER: return            BASE_ITEM_DAGGER            ;
            case FEAT_WEAPON_FOCUS_DART: return              BASE_ITEM_DART              ;
            case FEAT_WEAPON_FOCUS_HEAVY_CROSSBOW: return    BASE_ITEM_HEAVYCROSSBOW    ;
            case FEAT_WEAPON_FOCUS_LIGHT_CROSSBOW: return    BASE_ITEM_LIGHTCROSSBOW    ;
            case FEAT_WEAPON_FOCUS_LIGHT_MACE: return        BASE_ITEM_LIGHTMACE        ;
            case FEAT_WEAPON_FOCUS_MORNING_STAR: return      BASE_ITEM_MORNINGSTAR      ;
            case FEAT_WEAPON_FOCUS_STAFF: return             BASE_ITEM_QUARTERSTAFF             ;
            case FEAT_WEAPON_FOCUS_SPEAR: return             BASE_ITEM_SHORTSPEAR             ;
            case FEAT_WEAPON_FOCUS_SICKLE: return            BASE_ITEM_SICKLE            ;
            case FEAT_WEAPON_FOCUS_SLING: return             BASE_ITEM_SLING             ;
            case FEAT_WEAPON_FOCUS_LONGBOW: return           BASE_ITEM_LONGBOW           ;
            case FEAT_WEAPON_FOCUS_SHORTBOW: return          BASE_ITEM_SHORTBOW          ;
            case FEAT_WEAPON_FOCUS_SHORT_SWORD: return       BASE_ITEM_SHORTSWORD       ;
            case FEAT_WEAPON_FOCUS_RAPIER: return            BASE_ITEM_RAPIER            ;
            case FEAT_WEAPON_FOCUS_SCIMITAR: return          BASE_ITEM_SCIMITAR          ;
        case FEAT_WEAPON_FOCUS_LONG_SWORD: return        BASE_ITEM_LONGSWORD        ;
            case FEAT_WEAPON_FOCUS_GREAT_SWORD: return       BASE_ITEM_GREATSWORD       ;
            case FEAT_WEAPON_FOCUS_HAND_AXE: return          BASE_ITEM_HANDAXE          ;
            case FEAT_WEAPON_FOCUS_THROWING_AXE: return      BASE_ITEM_THROWINGAXE      ;
            case FEAT_WEAPON_FOCUS_BATTLE_AXE: return        BASE_ITEM_BATTLEAXE        ;
            case FEAT_WEAPON_FOCUS_GREAT_AXE: return         BASE_ITEM_GREATAXE         ;
            case FEAT_WEAPON_FOCUS_HALBERD: return           BASE_ITEM_HALBERD           ;
            case FEAT_WEAPON_FOCUS_LIGHT_HAMMER: return      BASE_ITEM_LIGHTHAMMER      ;
            case FEAT_WEAPON_FOCUS_LIGHT_FLAIL: return       BASE_ITEM_LIGHTFLAIL       ;
        case FEAT_WEAPON_FOCUS_WAR_HAMMER: return        BASE_ITEM_WARHAMMER        ;
            case FEAT_WEAPON_FOCUS_HEAVY_FLAIL: return       BASE_ITEM_HEAVYFLAIL       ;
            case FEAT_WEAPON_FOCUS_KAMA: return              BASE_ITEM_KAMA              ;
            case FEAT_WEAPON_FOCUS_KUKRI: return             BASE_ITEM_KUKRI             ;
            case FEAT_WEAPON_FOCUS_SHURIKEN: return          BASE_ITEM_SHURIKEN          ;
            case FEAT_WEAPON_FOCUS_SCYTHE: return            BASE_ITEM_SCYTHE            ;
            case FEAT_WEAPON_FOCUS_KATANA: return            BASE_ITEM_KATANA            ;
            case FEAT_WEAPON_FOCUS_BASTARD_SWORD: return     BASE_ITEM_BASTARDSWORD     ;
            case FEAT_WEAPON_FOCUS_DIRE_MACE: return         BASE_ITEM_DIREMACE         ;
            case FEAT_WEAPON_FOCUS_DOUBLE_AXE: return        BASE_ITEM_DOUBLEAXE        ;
            case FEAT_WEAPON_FOCUS_TWO_BLADED_SWORD: return  BASE_ITEM_TWOBLADEDSWORD  ;
            case FEAT_WEAPON_FOCUS_DWAXE: return             BASE_ITEM_DWARVENWARAXE             ;
            case FEAT_WEAPON_FOCUS_WHIP: return              BASE_ITEM_WHIP              ;
            }
    return - 1;
}


