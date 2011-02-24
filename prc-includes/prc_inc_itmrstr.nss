/*

    This include governs all the new itemproperties
    Both restrictions and features



*/


//////////////////////////////////////////////////
/*                 Constants                    */
//////////////////////////////////////////////////

const string PLAYER_SPEED_INCREASE = "player_speed_increase";
const string PLAYER_SPEED_DECREASE = "player_speed_decrease";


//////////////////////////////////////////////////
/*             Function prototypes              */
//////////////////////////////////////////////////

int DoUMDCheck(object oItem, object oPC, int nDCMod);

int CheckPRCLimitations(object oItem, object oPC = OBJECT_INVALID);

/**
 * Non-returning wrapper for CheckPRCLimitations.
 */
void VoidCheckPRCLimitations(object oItem, object oPC = OBJECT_INVALID);

void CheckForPnPHolyAvenger(object oItem);


//////////////////////////////////////////////////
/*                  Includes                    */
//////////////////////////////////////////////////

#include "inc_utility"
#include "prc_inc_newip"


//////////////////////////////////////////////////
/*             Internal functions               */
//////////////////////////////////////////////////

void _prc_inc_itmrstr_ApplySpeedModification(object oPC, int nEffectType, int nSpeedMod)
{
    if(DEBUG) DoDebug("_prc_inc_itmrstr_ApplySpeedModification(" + DebugObject2Str(oPC) + ", " + IntToString(nEffectType) + ", " + IntToString(nSpeedMod) + ")");
    // The skin object should be OBJECT_SELF here
    // Clean up existing speed modification
    effect eTest = GetFirstEffect(oPC);
    while(GetIsEffectValid(eTest))
    {
        if(GetEffectCreator(eTest) == OBJECT_SELF         &&
           GetEffectType(eTest)    == nEffectType         &&
           GetEffectSubType(eTest) == SUBTYPE_SUPERNATURAL
           )
            RemoveEffect(oPC, eTest);
        eTest = GetNextEffect(oPC);
    }

    // Apply speed mod if there is any
    if(nSpeedMod > 0)
    {
        effect eSpeedMod = SupernaturalEffect(nEffectType == EFFECT_TYPE_MOVEMENT_SPEED_INCREASE ?
                                               EffectMovementSpeedIncrease(nSpeedMod) :
                                               EffectMovementSpeedDecrease(nSpeedMod)
                                              );
        /// @todo Determine if the delay is actually needed here
        DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpeedMod, oPC));
    }
}

void _prc_inc_itmrstr_ApplySpeedIncrease(object oPC)
{
    // Get target speed modification value. Limit to 99, since that's the effect constructor maximum value
    int nSpeedMod = min(99, GetLocalInt(oPC, PLAYER_SPEED_INCREASE));
    object oSkin = GetPCSkin(oPC);

    AssignCommand(oSkin, _prc_inc_itmrstr_ApplySpeedModification(oPC, EFFECT_TYPE_MOVEMENT_SPEED_INCREASE, nSpeedMod));
}


void _prc_inc_itmrstr_ApplySpeedDecrease(object oPC)
{
    // Get target speed modification value. Limit to 99, since that's the effect constructor maximum value
    int nSpeedMod = GetLocalInt(oPC, PLAYER_SPEED_DECREASE);
    object oSkin = GetPCSkin(oPC);

    AssignCommand(oSkin, _prc_inc_itmrstr_ApplySpeedModification(oPC, EFFECT_TYPE_MOVEMENT_SPEED_DECREASE, nSpeedMod));
}

void _prc_inc_itmrstr_ApplyAoE(object oPC, object oItem, int nSubType, int nCost)
{
    int nAoEID    = StringToInt(Get2DACache("iprp_aoe", "AoEID", nSubType));
    string sEnter = Get2DACache("iprp_aoe", "EnterScript", nSubType);
    string sExit  = Get2DACache("iprp_aoe", "ExitScript",  nSubType);
    string sHB    = Get2DACache("iprp_aoe", "HBScript",    nSubType);
    effect eAoE   = EffectAreaOfEffect(nAoEID, sEnter, sHB, sExit);

    // The item applies the AoE effect
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAoE, oPC);

    // Get an object reference to the newly created AoE
    location lLoc = GetLocation(oPC);
    object oAoE = GetFirstObjectInShape(SHAPE_SPHERE, 1.0f, lLoc, FALSE, OBJECT_TYPE_AREA_OF_EFFECT);
    while(GetIsObjectValid(oAoE))
    {
        // Test if we found the correct AoE
        if(GetTag(oAoE) == Get2DACache("vfx_persistent", "LABEL", nAoEID) &&
           !GetLocalInt(oAoE, "PRC_AoE_IPRP_Init")
           )
        {
            SetLocalInt(oAoE, "PRC_AoE_IPRP_Init", TRUE);
            break;
        }
        // Didn't find, get next
        oAoE = GetNextObjectInShape(SHAPE_SPHERE, 1.0f, lLoc, FALSE, OBJECT_TYPE_AREA_OF_EFFECT);
    }
    if(!GetIsObjectValid(oAoE)) DoDebug("ERROR: _prc_inc_itmrstr_ApplyAoE: Can't find AoE created by " + DebugObject2Str(oItem));

    // Set caster level override on the AoE
    SetLocalInt(oAoE, PRC_CASTERLEVEL_OVERRIDE, nCost);
    //if(DEBUG) DoDebug("_prc_inc_itmrstr_ApplyAoE: AoE level: " + IntToString(nCost));
}

void _prc_inc_itmrstr_ApplyWizardry(object oPC, object oItem, int nSpellLevel, string sType)
{
    int nClass, nSlots, i;
    for(i = 1; i <= 3; i++)
    {
        nClass = GetClassByPosition(i, oPC);
        if((sType == "A" && GetIsArcaneClass(nClass)) || (sType == "D" && GetIsDivineClass(nClass)))
        {
            if(GetAbilityScoreForClass(nClass, oPC) < nSpellLevel + 10)
                continue;

            int nSpellSlotLevel = GetSpellslotLevel(nClass, oPC);
            string sFile;
            // Bioware casters use their classes.2da-specified tables
            /*if(    nClass == CLASS_TYPE_WIZARD
                || nClass == CLASS_TYPE_SORCERER
                || nClass == CLASS_TYPE_BARD
                || nClass == CLASS_TYPE_CLERIC
                || nClass == CLASS_TYPE_DRUID
                || nClass == CLASS_TYPE_PALADIN
                || nClass == CLASS_TYPE_RANGER)
            {*/
                sFile = Get2DACache("classes", "SpellGainTable", nClass);
            /*}
            // New spellbook casters use the cls_spbk_* tables
            else
            {
                sFile = Get2DACache("classes", "FeatsTable", nClass);
                sFile = "cls_spbk" + GetStringRight(sFile, GetStringLength(sFile) - 8);
            }*/

            string sSlots = Get2DACache(sFile, "SpellLevel" + IntToString(nSpellLevel), nSpellSlotLevel - 1);
            if(sSlots == "")
                nSlots = 0;
            else
                nSlots = StringToInt(sSlots);
            //if(DEBUG) DoDebug("Adding "+IntToString(nSlots)" bonus slots for "+IntToString(nClass)" class.");

            if(nSlots)
            {
                int j = 0;
                while(j < nSlots)
                {
                    //DoDebug(IntToString(j));
                    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(nClass, nSpellLevel), oItem);
                    //nsb compatibility
                    SetLocalInt(oPC, "PRC_IPRPBonSpellSlots_" + IntToString(nClass) + "_" + IntToString(nSpellLevel),
                               (GetLocalInt(oPC, "PRC_IPRPBonSpellSlots_" + IntToString(nClass) + "_" + IntToString(nSpellLevel)) + 1));
                    j++;
                }
            }
        }
    }
    SetPlotFlag(oItem, TRUE);
}

void _prc_inc_itmrstr_RemoveWizardry(object oPC, object oItem, int nSpellLevel, string sType)
{
    SetPlotFlag(oItem, FALSE);
    itemproperty ipTest = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ipTest))
    {
        if(GetItemPropertyType(ipTest) == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)
        {
            if(GetItemPropertyCostTableValue(ipTest) == nSpellLevel)
            {
                int nClass = GetItemPropertySubType(ipTest);
                if((sType == "A" && GetIsArcaneClass(nClass)) || (sType == "D" && GetIsDivineClass(nClass)))
                {
                    RemoveItemProperty(oItem, ipTest);
                    SetLocalInt(oPC, "PRC_IPRPBonSpellSlots_" + IntToString(nClass) + "_" + IntToString(nSpellLevel),
                               (GetLocalInt(oPC, "PRC_IPRPBonSpellSlots_" + IntToString(nClass) + "_" + IntToString(nSpellLevel)) - 1));
                }
            }
        }
        ipTest = GetNextItemProperty(oItem);
    }
}

//////////////////////////////////////////////////
/*             Function definitions             */
//////////////////////////////////////////////////

int GetUMDForItemCost(object oItem)
{
    string s2DAEntry;
    int nValue = GetGoldPieceValue(oItem);
    int n2DAValue = StringToInt(s2DAEntry);
    int i;
    while(n2DAValue < nValue)
    {
        s2DAEntry = Get2DACache("skillvsitemcost", "DeviceCostMax", i);
        n2DAValue = StringToInt(s2DAEntry);
        i++;
    }
    i--;
    string s2DAReqSkill = Get2DACache("skillvsitemcost", "SkillReq_Class", i);
    if(s2DAReqSkill == "")
        return -1;
    return StringToInt(s2DAReqSkill);
}

//this is a scripted version of the bioware UMD check for using restricted items
//this also applies effects relating to new itemproperties
int DoUMDCheck(object oItem, object oPC, int nDCMod)
{

    //doesnt have UMD
    if(!GetHasSkill(SKILL_USE_MAGIC_DEVICE, oPC))
        return FALSE;

    int nSkill = GetSkillRank(SKILL_USE_MAGIC_DEVICE, oPC);
    int nReqSkill = GetUMDForItemCost(oItem);
    //class is a dc20 test
    nReqSkill = nReqSkill - 20 + nDCMod;
    if(nReqSkill > nSkill)
        return FALSE;
    else
        return TRUE;
}

void VoidCheckPRCLimitations(object oItem, object oPC = OBJECT_INVALID)
{
    CheckPRCLimitations(oItem, oPC);
}

//tests for use restrictions
//also appies effects for those IPs tat need them
/// @todo Rename. It's not just limitations anymore
int CheckPRCLimitations(object oItem, object oPC = OBJECT_INVALID)
{
    // Sanity check - the item needs to be valid
    if(!GetIsObjectValid(oItem))
        return FALSE; /// @todo Might be better to auto-pass the limitation aspect in case of invalid item

    // In case no item owner was given, find it out
    if(!GetIsObjectValid(oPC))
        oPC = GetItemPossessor(oItem);

    // Sanity check - the item needs to be in some creature's possession for this function to make sense
    if(!GetIsObjectValid(oPC))
        return FALSE;

    // Equip and Unequip events need some special handling
    int bUnequip = GetItemLastUnequipped() == oItem && GetLocalInt(oPC, "ONEQUIP") == 1;
    int bEquip   = GetItemLastEquipped()   == oItem && GetLocalInt(oPC, "ONEQUIP") == 2;

    // Use restriction and UMD use
    int bPass  = TRUE;
    int nUMDDC = 0;

    // Speed modification. Used to determine if effects need to be applied
    int nSpeedIncrease = GetLocalInt(oPC, PLAYER_SPEED_INCREASE);
    int nSpeedDecrease = GetLocalInt(oPC, PLAYER_SPEED_DECREASE);

    // Loop over all itemproperties on the item
    itemproperty ipTest = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ipTest))
    {
        /* Use restrictions. All of these can be skipped when unequipping */
        if     (!bUnequip && GetItemPropertyType(ipTest) == ITEM_PROPERTY_USE_LIMITATION_ABILITY_SCORE)
        {
            int nValue = GetItemPropertyCostTableValue(ipTest);
            int nAbility = GetItemPropertySubType(ipTest);
            if(GetAbilityScore(oPC, nAbility, TRUE) < nValue)
                bPass = FALSE;
            nUMDDC += nValue - 15;
        }
        else if(!bUnequip && GetItemPropertyType(ipTest) == ITEM_PROPERTY_USE_LIMITATION_SKILL_RANKS)
        {
            int nValue = GetItemPropertyCostTableValue(ipTest);
            int nSkill = GetItemPropertySubType(ipTest);
            int nTrueValue = GetSkillRank(nSkill, oPC);
            if(nTrueValue < nValue)
                bPass = FALSE;
            nUMDDC += nValue - 10;
        }
        else if(!bUnequip && GetItemPropertyType(ipTest) == ITEM_PROPERTY_USE_LIMITATION_SPELL_LEVEL)
        {
            int nLevel = GetItemPropertyCostTableValue(ipTest);
            int nValid = GetLocalInt(oPC, "PRC_AllSpell" + IntToString(nLevel));
            if(nValid)
                bPass = FALSE;
            nUMDDC += (nLevel * 2) - 20;
        }
        else if(!bUnequip && GetItemPropertyType(ipTest) == ITEM_PROPERTY_USE_LIMITATION_ARCANE_SPELL_LEVEL)
        {
            int nLevel = GetItemPropertyCostTableValue(ipTest);
            int nValid = GetLocalInt(oPC, "PRC_ArcSpell" + IntToString(nLevel));
            if(nValid)
                bPass = FALSE;
            nUMDDC += (nLevel * 2) - 20;
        }
        else if(!bUnequip && GetItemPropertyType(ipTest) == ITEM_PROPERTY_USE_LIMITATION_DIVINE_SPELL_LEVEL)
        {
            int nLevel = GetItemPropertyCostTableValue(ipTest);
            int nValid = GetLocalInt(oPC, "PRC_DivSpell" + IntToString(nLevel));
            if(nValid)
                bPass = FALSE;
            nUMDDC += (nLevel * 2) - 20;
        }
        else if(!bUnequip && GetItemPropertyType(ipTest) == ITEM_PROPERTY_USE_LIMITATION_SNEAK_ATTACK)
        {
            int nLevel = GetItemPropertyCostTableValue(ipTest);
            int nValid = GetLocalInt(oPC, "PRC_SneakLevel" + IntToString(nLevel));
            if(nValid)
                bPass = FALSE;
            nUMDDC += (nLevel * 2) - 20;
        }
        else if(!bUnequip && GetItemPropertyType(ipTest) == ITEM_PROPERTY_USE_LIMITATION_GENDER)
        {
            int nIPGender = GetItemPropertySubType(ipTest);
            int nRealGender = GetGender(oPC);
            if(nRealGender != nIPGender)
                bPass = FALSE;
            nUMDDC += 5;
        }

        /* Properties that apply effects. Unequip should cause cleanup here */
        else if(GetItemPropertyType(ipTest) == ITEM_PROPERTY_SPEED_INCREASE)
        {
            int iItemAdjust = 0;
            int nCost = GetItemPropertyCostTableValue(ipTest);
            switch(nCost)
            {
                case 0: iItemAdjust = 10;  break;
                case 1: iItemAdjust = 20;  break;
                case 2: iItemAdjust = 30;  break;
                case 3: iItemAdjust = 40;  break;
                case 4: iItemAdjust = 50;  break;
                case 5: iItemAdjust = 60;  break;
                case 6: iItemAdjust = 70;  break;
                case 7: iItemAdjust = 80;  break;
                case 8: iItemAdjust = 90;  break;
                case 9: iItemAdjust = 100; break;
            }
            if(bUnequip)
                nSpeedIncrease -= iItemAdjust;
            else if(bEquip)
                nSpeedIncrease += iItemAdjust;
        }
        else if(GetItemPropertyType(ipTest) == ITEM_PROPERTY_SPEED_DECREASE)
        {
            int iItemAdjust = 0;
            int nCost = GetItemPropertyCostTableValue(ipTest);
            switch(nCost)
            {
                case 0: iItemAdjust = 10; break;
                case 1: iItemAdjust = 20; break;
                case 2: iItemAdjust = 30; break;
                case 3: iItemAdjust = 40; break;
                case 4: iItemAdjust = 50; break;
                case 5: iItemAdjust = 60; break;
                case 6: iItemAdjust = 70; break;
                case 7: iItemAdjust = 80; break;
                case 8: iItemAdjust = 90; break;
                case 9: iItemAdjust = 99; break;
            }
            if(bUnequip)
                nSpeedDecrease -= iItemAdjust;
            else if(bEquip)
                nSpeedDecrease += iItemAdjust;
        }
        else if(GetItemPropertyType(ipTest) == ITEM_PROPERTY_PNP_HOLY_AVENGER)
        {
            if(bEquip)
            {
                int nPaladinLevels = GetLevelByClass(CLASS_TYPE_PALADIN, oPC);
                if(!nPaladinLevels)
                {
                    //not a paladin? fake it
                    //not really a true PnP test
                    //instead it sets the paladin level
                    //to the UMD ranks minus the amount required
                    //to use a class restricted item of that value
                    int nSkill = GetSkillRank(SKILL_USE_MAGIC_DEVICE, oPC);
                    if(nSkill)
                    {
                        int nReqSkill = GetUMDForItemCost(oItem);
                        nSkill -= nReqSkill;
                        if(nSkill > 0)
                            nPaladinLevels = nSkill;
                    }
                }

                // Add Holy Avenger specials for Paladins (or successfull fake-Paladins)
                if(nPaladinLevels)
                {
                    DelayCommand(0.1, IPSafeAddItemProperty(oItem,
                        ItemPropertyEnhancementBonus(5), 99999.9));
                    DelayCommand(0.1, IPSafeAddItemProperty(oItem,
                        ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,
                            IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d6), 99999.9));
                    //this is a normal dispel magic useage, should be specific
                    DelayCommand(0.1, IPSafeAddItemProperty(oItem,
                        ItemPropertyCastSpell(IP_CONST_CASTSPELL_DISPEL_MAGIC_5,
                            IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE), 99999.9));
                    DelayCommand(0.1, IPSafeAddItemProperty(oItem,
                        ItemPropertyCastSpellCasterLevel(SPELL_DISPEL_MAGIC,
                            nPaladinLevels), 99999.9));
                }
                // Non-Paladin's get +2 enhancement bonus
                else
                {
                    DelayCommand(0.1, IPSafeAddItemProperty(oItem,
                        ItemPropertyEnhancementBonus(2), 99999.9));

                    // Remove Paladin specials
                    IPRemoveMatchingItemProperties(oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS, DURATION_TYPE_TEMPORARY, -1);
                    IPRemoveMatchingItemProperties(oItem, ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP, DURATION_TYPE_TEMPORARY, IP_CONST_ALIGNMENTGROUP_EVIL);
                    IPRemoveMatchingItemProperties(oItem, ITEM_PROPERTY_CAST_SPELL, DURATION_TYPE_TEMPORARY);
                    IPRemoveMatchingItemProperties(oItem, ITEM_PROPERTY_CAST_SPELL_CASTER_LEVEL, DURATION_TYPE_TEMPORARY);
                }
            }
            else if(bUnequip)
            {
                IPRemoveMatchingItemProperties(oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS,
                    DURATION_TYPE_TEMPORARY, -1);
                IPRemoveMatchingItemProperties(oItem, ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP,
                    DURATION_TYPE_TEMPORARY, IP_CONST_ALIGNMENTGROUP_EVIL);
                IPRemoveMatchingItemProperties(oItem, ITEM_PROPERTY_CAST_SPELL,
                    DURATION_TYPE_TEMPORARY);
                IPRemoveMatchingItemProperties(oItem, ITEM_PROPERTY_CAST_SPELL_CASTER_LEVEL,
                    DURATION_TYPE_TEMPORARY);
            }
        }
        else if(GetItemPropertyType(ipTest) == ITEM_PROPERTY_AREA_OF_EFFECT)
        {
            int nSubType  = GetItemPropertySubType(ipTest);
            int nCost     = GetItemPropertyCostTable(ipTest);

            // This should only happen on equip or unequip
            if(bEquip || bUnequip)
            {
                // Remove existing AoE
                effect eTest = GetFirstEffect(oPC);
                while(GetIsEffectValid(eTest))
                {
                    if(GetEffectCreator(eTest) == oItem
                       && GetEffectType(eTest) == EFFECT_TYPE_AREA_OF_EFFECT)
                    {
                        RemoveEffect(oPC, eTest);
                        if(DEBUG) DoDebug("CheckPRCLimitations: Removing old AoE effect");
                    }
                    eTest = GetNextEffect(oPC);
                }

                // Create new AoE - Only when equipping
                if(bEquip)
                {
                    AssignCommand(oItem, _prc_inc_itmrstr_ApplyAoE(oPC, oItem, nSubType, nCost));
                }// end if - Equip event
            }// end if - Equip or Unequip event
        }// end if - AoE iprp
        else if(GetItemPropertyType(ipTest) == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)
        {
            // Only equippable items can provide bonus spell slots
            if(bEquip || bUnequip)
            {
                int nSubType  = GetItemPropertySubType(ipTest);
                int nCost     = GetItemPropertyCostTable(ipTest);
                SetLocalInt(oPC,
                            "PRC_IPRPBonSpellSlots_" + IntToString(nSubType) + "_" + IntToString(nCost),
                            GetLocalInt(oPC,
                                        "PRC_IPRPBonSpellSlots_" + IntToString(nSubType) + "_" + IntToString(nCost)
                                        )
                             + (bEquip ? 1 : -1)
                            );
            }
        }
        else if(GetItemPropertyType(ipTest) == ITEM_PROPERTY_WIZARDRY)
        {
            int nCost = GetItemPropertyCostTableValue(ipTest);
            if(bEquip)
                AssignCommand(oItem, _prc_inc_itmrstr_ApplyWizardry(oPC, oItem, nCost, "A"));
            else if(bUnequip)
                AssignCommand(oItem, _prc_inc_itmrstr_RemoveWizardry(oPC, oItem, nCost, "A"));
        }
        else if(GetItemPropertyType(ipTest) == ITEM_PROPERTY_DIVANITY)
        {
            int nCost = GetItemPropertyCostTableValue(ipTest);
            if(bEquip)
                AssignCommand(oItem, _prc_inc_itmrstr_ApplyWizardry(oPC, oItem, nCost, "D"));
            else if(bUnequip)
                AssignCommand(oItem, _prc_inc_itmrstr_RemoveWizardry(oPC, oItem, nCost, "D"));
        }

        ipTest = GetNextItemProperty(oItem);
    }// end while - Loop over all itemproperties

    // Determine if speed modification totals had changed
    if(nSpeedDecrease != GetLocalInt(oPC, PLAYER_SPEED_DECREASE))
    {
        SetLocalInt(oPC, PLAYER_SPEED_DECREASE, nSpeedDecrease);
        _prc_inc_itmrstr_ApplySpeedDecrease(oPC);
    }
    if(nSpeedIncrease != GetLocalInt(oPC, PLAYER_SPEED_INCREASE))
    {
        SetLocalInt(oPC, PLAYER_SPEED_INCREASE, nSpeedIncrease);
        _prc_inc_itmrstr_ApplySpeedIncrease(oPC);
    }

    // If some restriction would prevent item use, perform UMD skill check
    // Skip in case of unequip
    if(!bUnequip && !bPass)
        bPass = DoUMDCheck(oItem, oPC, nUMDDC);

    return bPass;
}

void CheckForPnPHolyAvenger(object oItem)
{
    if(!GetPRCSwitch(PRC_PNP_HOLY_AVENGER_IPROP))
        return;
    itemproperty ipTest = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ipTest))
    {
        if(GetItemPropertyType(ipTest) == ITEM_PROPERTY_HOLY_AVENGER)
        {
            DelayCommand(0.1, RemoveItemProperty(oItem, ipTest));
            DelayCommand(0.1, IPSafeAddItemProperty(oItem, ItemPropertyPnPHolyAvenger()));
        }
        ipTest = GetNextItemProperty(oItem);
    }
}