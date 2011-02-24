
// Use this function to get the adjustments to a spell or SLAs saving throw
// from the various class effects
// Update this function if any new classes change saving throws
int PRCGetSaveDC(object oTarget, object oCaster, int nSpellID = -1);

//called just from above and from inc_epicspells
int GetChangesToSaveDC(object oTarget, object oCaster = OBJECT_SELF, int nSpellID = -1);

#include "prc_add_spl_pen"
//#include "prc_inc_spells"
//#include "prc_class_const"
//#include "prc_feat_const"
//#include "lookup_2da_spell"
//#include "prcsp_archmaginc"
//#include "prc_alterations"
//#include "prc_inc_racial"
#include "inc_newspellbook"


int GetHeartWarderDC(int spell_id, object oCaster = OBJECT_SELF)
{
    // Check the curent school
    if (GetLocalInt(oCaster, "X2_L_LAST_SPELLSCHOOL_VAR") != SPELL_SCHOOL_ENCHANTMENT)
        return 0;

    if (!GetHasFeat(FEAT_VOICE_SIREN, oCaster)) return 0;

    // Bonus Requires Verbal Spells
    string VS = Get2DACache("spells", "VS", PRCGetSpellId());//lookup_spell_vs(PRCGetSpellId());
    if (VS != "v" && VS != "vs")
        return 0;

    // These feats provide greater bonuses or remove the Verbal requirement
    if (PRCGetMetaMagicFeat() & METAMAGIC_SILENT
            || GetHasFeat(FEAT_GREATER_SPELL_FOCUS_ENCHANTMENT, oCaster)
            || GetHasFeat(FEAT_EPIC_SPELL_FOCUS_ENCHANTMENT, oCaster))
        return 0;

    return 2;
}

//Elemental Savant DC boost based on elemental spell type.
int ElementalSavantDC(int spell_id, object oCaster = OBJECT_SELF)
{
    int nDC = 0;
    int nES;

    // All Elemental Savants will have this feat
    // when they first gain a DC bonus.
    if (GetHasFeat(FEAT_ES_FOCUS_1, oCaster)) {
        // get spell elemental type
        string element = ChangedElementalType(spell_id, oCaster);

        // Any value that does not match one of the enumerated feats
        int feat = 0;

        // Specify the elemental type rather than lookup by class?
        if (element == "Fire")
        {
            feat = FEAT_ES_FIRE;
            nES = GetLevelByClass(CLASS_TYPE_ES_FIRE,oCaster);
        }
        else if (element == "Cold")
        {
            feat = FEAT_ES_COLD;
            nES = GetLevelByClass(CLASS_TYPE_ES_COLD,oCaster);
        }
        else if (element == "Electricity")
        {
            feat = FEAT_ES_ELEC;
            nES = GetLevelByClass(CLASS_TYPE_ES_ELEC,oCaster);
        }
        else if (element == "Acid")
        {
            feat = FEAT_ES_ACID;
            nES = GetLevelByClass(CLASS_TYPE_ES_ACID,oCaster);
        }

        // Now determine the bonus
        if (feat && GetHasFeat(feat, oCaster))
        {

            if (nES > 28)       nDC = 10;
            else if (nES > 25)  nDC = 9;
            else if (nES > 22)  nDC = 8;
            else if (nES > 19)  nDC = 7;
            else if (nES > 16)  nDC = 6;
            else if (nES > 13)  nDC = 5;
            else if (nES > 10)  nDC = 4;
            else if (nES > 7)   nDC = 3;
            else if (nES > 4)   nDC = 2;
            else if (nES > 1)   nDC = 1;

        }
    }
//  SendMessageToPC(GetFirstPC(), "Your Elemental Focus modifier is " + IntToString(nDC));
    return nDC;
}

// This does other spell focus feats, starting with Spell Focus: Cold
int SpellFocus(int nSpellId, object oCaster = OBJECT_SELF)
{
    	int nDC = 0;
        string sElement = ChangedElementalType(nSpellId, oCaster);


        // Specify the elemental type 
        if (sElement == "Cold")
        {
		if (GetHasFeat(FEAT_GREATER_SPELL_FOCUS_COLD, oCaster)) nDC += 2;
		else if (GetHasFeat(FEAT_SPELL_FOCUS_COLD, oCaster)) nDC += 1;
        }

    	return nDC;
}



//Red Wizard DC boost based on spell school specialization
int RedWizardDC(int spell_id, object oCaster = OBJECT_SELF)
{
    int iRedWizard = GetLevelByClass(CLASS_TYPE_RED_WIZARD, oCaster);
    int nDC;

    if (iRedWizard > 0)
    {
        int nSpell = PRCGetSpellId();
        string sSpellSchool = Get2DACache("spells", "School", nSpell);//lookup_spell_school(nSpell);
        int iSpellSchool;
        int iRWSpec;

        if (sSpellSchool == "A") iSpellSchool = SPELL_SCHOOL_ABJURATION;
        else if (sSpellSchool == "C") iSpellSchool = SPELL_SCHOOL_CONJURATION;
        else if (sSpellSchool == "D") iSpellSchool = SPELL_SCHOOL_DIVINATION;
        else if (sSpellSchool == "E") iSpellSchool = SPELL_SCHOOL_ENCHANTMENT;
        else if (sSpellSchool == "V") iSpellSchool = SPELL_SCHOOL_EVOCATION;
        else if (sSpellSchool == "I") iSpellSchool = SPELL_SCHOOL_ILLUSION;
        else if (sSpellSchool == "N") iSpellSchool = SPELL_SCHOOL_NECROMANCY;
        else if (sSpellSchool == "T") iSpellSchool = SPELL_SCHOOL_TRANSMUTATION;

        if (GetHasFeat(FEAT_RW_TF_ABJ, oCaster)) iRWSpec = SPELL_SCHOOL_ABJURATION;
        else if (GetHasFeat(FEAT_RW_TF_CON, oCaster)) iRWSpec = SPELL_SCHOOL_CONJURATION;
        else if (GetHasFeat(FEAT_RW_TF_DIV, oCaster)) iRWSpec = SPELL_SCHOOL_DIVINATION;
        else if (GetHasFeat(FEAT_RW_TF_ENC, oCaster)) iRWSpec = SPELL_SCHOOL_ENCHANTMENT;
        else if (GetHasFeat(FEAT_RW_TF_EVO, oCaster)) iRWSpec = SPELL_SCHOOL_EVOCATION;
        else if (GetHasFeat(FEAT_RW_TF_ILL, oCaster)) iRWSpec = SPELL_SCHOOL_ILLUSION;
        else if (GetHasFeat(FEAT_RW_TF_NEC, oCaster)) iRWSpec = SPELL_SCHOOL_NECROMANCY;
        else if (GetHasFeat(FEAT_RW_TF_TRS, oCaster)) iRWSpec = SPELL_SCHOOL_TRANSMUTATION;

        if (iSpellSchool == iRWSpec)
        {
            if (iRedWizard > 29)        nDC = 15;
            else if (iRedWizard > 27)   nDC = 14;
            else if (iRedWizard > 25)   nDC = 13;
            else if (iRedWizard > 23)   nDC = 12;
            else if (iRedWizard > 21)   nDC = 11;
            else if (iRedWizard > 19)   nDC = 10;
            else if (iRedWizard > 17)   nDC = 9;
            else if (iRedWizard > 15)   nDC = 8;
            else if (iRedWizard > 13)   nDC = 7;
            else if (iRedWizard > 11)   nDC = 6;
            else if (iRedWizard > 9)    nDC = 5;
            else if (iRedWizard > 7)    nDC = 4;
            else if (iRedWizard > 5)    nDC = 3;
            else if (iRedWizard > 3)    nDC = 2;
            else if (iRedWizard > 1)    nDC = 1;
        }


    }
//  SendMessageToPC(GetFirstPC(), "Your Spell Power modifier is " + IntToString(nDC));
    return nDC;
}

//Red Wizards recieve a bonus against their specialist schools
// this is done by lowering the DC of spells cast against them
int RedWizardDCPenalty(int spell_id, object oTarget)
{
    int nDC;
    int iRW = GetLevelByClass(CLASS_TYPE_RED_WIZARD, oTarget);
    if(iRW)
    {
        int iRWSpec;
        if (GetHasFeat(FEAT_RW_TF_ABJ, oTarget)) iRWSpec = SPELL_SCHOOL_ABJURATION;
        else if (GetHasFeat(FEAT_RW_TF_CON, oTarget)) iRWSpec = SPELL_SCHOOL_CONJURATION;
        else if (GetHasFeat(FEAT_RW_TF_DIV, oTarget)) iRWSpec = SPELL_SCHOOL_DIVINATION;
        else if (GetHasFeat(FEAT_RW_TF_ENC, oTarget)) iRWSpec = SPELL_SCHOOL_ENCHANTMENT;
        else if (GetHasFeat(FEAT_RW_TF_EVO, oTarget)) iRWSpec = SPELL_SCHOOL_EVOCATION;
        else if (GetHasFeat(FEAT_RW_TF_ILL, oTarget)) iRWSpec = SPELL_SCHOOL_ILLUSION;
        else if (GetHasFeat(FEAT_RW_TF_NEC, oTarget)) iRWSpec = SPELL_SCHOOL_NECROMANCY;
        else if (GetHasFeat(FEAT_RW_TF_TRS, oTarget)) iRWSpec = SPELL_SCHOOL_TRANSMUTATION;

        if (GetSpellSchool(spell_id) == iRWSpec)
        {
           if (iRW > 28)         nDC = nDC - 14;
           else if (iRW > 26)    nDC = nDC - 13;
           else if (iRW > 24)    nDC = nDC - 12;
           else if (iRW > 22)    nDC = nDC - 11;
           else if (iRW > 20)    nDC = nDC - 10;
           else if (iRW > 18)    nDC = nDC - 9;
           else if (iRW > 16)    nDC = nDC - 8;
           else if (iRW > 14)    nDC = nDC - 7;
           else if (iRW > 12)    nDC = nDC - 6;
           else if (iRW > 10)    nDC = nDC - 5;
           else if (iRW > 8)     nDC = nDC - 4;
           else if (iRW > 6)     nDC = nDC - 3;
           else if (iRW > 2)     nDC = nDC - 2;
           else if (iRW > 0)     nDC = nDC - 1;
        }
    }
    return nDC;
}

int ShadowAdeptDCPenalty(int spell_id, object oTarget)
{
    int iShadow = GetLevelByClass(CLASS_TYPE_SHADOW_ADEPT, oTarget);
    int nSpellSchool = GetSpellSchool(spell_id);
    int nDC;
    if (iShadow > 0)
    {
        if (nSpellSchool == SPELL_SCHOOL_ENCHANTMENT
         || nSpellSchool == SPELL_SCHOOL_NECROMANCY
         || nSpellSchool == SPELL_SCHOOL_ILLUSION)
        {

            if      (iShadow > 28)   nDC -= 10;
            else if (iShadow > 25)   nDC -= 9;
            else if (iShadow > 22)   nDC -= 8;
            else if (iShadow > 19)   nDC -= 7;
            else if (iShadow > 16)   nDC -= 6;
            else if (iShadow > 13)   nDC -= 5;
            else if (iShadow > 10)   nDC -= 4;
            else if (iShadow > 7)    nDC -= 3;
            else if (iShadow > 4)    nDC -= 2;
            else if (iShadow > 1)    nDC -= 1;
        }
        //SendMessageToPC(GetFirstPC(), "Your Spell Save modifier is " + IntToString(nDC));
    }
    return nDC;
}

//Tattoo Focus DC boost based on spell school specialization
int TattooFocus(int spell_id, object oCaster = OBJECT_SELF)
{

        int nDC;
        int nSpell = PRCGetSpellId();
        string sSpellSchool = Get2DACache("spells", "School", nSpell);//lookup_spell_school(nSpell);
        int iSpellSchool;
        int iRWSpec;

        if (sSpellSchool == "A") iSpellSchool = SPELL_SCHOOL_ABJURATION;
        else if (sSpellSchool == "C") iSpellSchool = SPELL_SCHOOL_CONJURATION;
        else if (sSpellSchool == "D") iSpellSchool = SPELL_SCHOOL_DIVINATION;
        else if (sSpellSchool == "E") iSpellSchool = SPELL_SCHOOL_ENCHANTMENT;
        else if (sSpellSchool == "V") iSpellSchool = SPELL_SCHOOL_EVOCATION;
        else if (sSpellSchool == "I") iSpellSchool = SPELL_SCHOOL_ILLUSION;
        else if (sSpellSchool == "N") iSpellSchool = SPELL_SCHOOL_NECROMANCY;
        else if (sSpellSchool == "T") iSpellSchool = SPELL_SCHOOL_TRANSMUTATION;

        if (GetHasFeat(FEAT_RW_TF_ABJ, oCaster)) iRWSpec = SPELL_SCHOOL_ABJURATION;
        else if (GetHasFeat(FEAT_RW_TF_CON, oCaster)) iRWSpec = SPELL_SCHOOL_CONJURATION;
        else if (GetHasFeat(FEAT_RW_TF_DIV, oCaster)) iRWSpec = SPELL_SCHOOL_DIVINATION;
        else if (GetHasFeat(FEAT_RW_TF_ENC, oCaster)) iRWSpec = SPELL_SCHOOL_ENCHANTMENT;
        else if (GetHasFeat(FEAT_RW_TF_EVO, oCaster)) iRWSpec = SPELL_SCHOOL_EVOCATION;
        else if (GetHasFeat(FEAT_RW_TF_ILL, oCaster)) iRWSpec = SPELL_SCHOOL_ILLUSION;
        else if (GetHasFeat(FEAT_RW_TF_NEC, oCaster)) iRWSpec = SPELL_SCHOOL_NECROMANCY;
        else if (GetHasFeat(FEAT_RW_TF_TRS, oCaster)) iRWSpec = SPELL_SCHOOL_TRANSMUTATION;

        if (iSpellSchool == iRWSpec)
        {
            nDC = 1;
        }
    return nDC;
}

int ShadowWeaveDC(int spell_id, object oCaster = OBJECT_SELF)
{
    int nDC = 0;

    // Account for the Shadow Weave feat
    int nShadowWeaveSpell = ShadowWeave(oCaster, spell_id);
    nDC += nShadowWeaveSpell == 1 ? 1 : 0; // The Shadow Weave feat only applies a DC bonus, never a penalty

    // Account for Shadow Adept levels
    int iShadow = GetLevelByClass(CLASS_TYPE_SHADOW_ADEPT, oCaster);
    if(iShadow > 0 && nShadowWeaveSpell == 1)
    {
        // Shadow Spell Power
        if      (iShadow > 29)  nDC += 10;
        else if (iShadow > 26)  nDC += 9;
        else if (iShadow > 23)  nDC += 8;
        else if (iShadow > 20)  nDC += 7;
        else if (iShadow > 17)  nDC += 6;
        else if (iShadow > 14)  nDC += 5;
        else if (iShadow > 11)  nDC += 4;
        else if (iShadow > 8)   nDC += 3;
        else if (iShadow > 5)   nDC += 2;
        else if (iShadow > 2)   nDC += 1;
    }
    //SendMessageToPC(GetFirstPC(), "Your Spell DC modifier is " + IntToString(nDC));

    return nDC;
}

int KOTCSpellFocusVsDemons(object oTarget, object oCaster)
{
    int nDC = 0;
    int iKOTC = GetLevelByClass(CLASS_TYPE_KNIGHT_CHALICE, oCaster);

    if (iKOTC >= 1)
        {
            if (MyPRCGetRacialType(oTarget) == RACIAL_TYPE_OUTSIDER)
            {
                if (GetAlignmentGoodEvil(oTarget) == ALIGNMENT_EVIL)
                {
                nDC = 2;
                }
            }
        }
        return nDC;
}

int BloodMagusBloodComponent(object oCaster)
{
    int nDC = 0;
    if (GetLevelByClass(CLASS_TYPE_BLOOD_MAGUS, oCaster) > 0 && GetLocalInt(oCaster, "BloodComponent") == TRUE)
    {
        nDC = 1;
        effect eSelfDamage = EffectDamage(1, DAMAGE_TYPE_MAGICAL);
        // To make sure it doesn't cause a conc check
            DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSelfDamage, oCaster));
        }
        return nDC;
}

int RunecasterRunePowerDC(object oCaster)
{
    int nDC = 0;
    int nClass = GetLevelByClass(CLASS_TYPE_RUNECASTER, oCaster);
    object oItem = GetSpellCastItem();
    string sResRef = GetResRef(oItem);
    // If the caster is runechanting or casting from a rune, add bonus
    // Known Bug: This does not give the proper bonus to anyone aside from the caster
    // I am uncertain as to how to do that
    // Now fixed by adding DC itemproperty
    if (nClass >= 2 && GetLocalInt(oCaster, "RuneChant") || sResRef == "prc_rune_1")
    {
            if (nClass >= 30)        nDC = 10;
            else if (nClass >= 27)   nDC = 9;
            else if (nClass >= 24)   nDC = 8;
            else if (nClass >= 21)   nDC = 7;
            else if (nClass >= 18)   nDC = 6;
            else if (nClass >= 15)   nDC = 5;
            else if (nClass >= 12)   nDC = 4;
            else if (nClass >= 9)    nDC = 3;
            else if (nClass >= 5)    nDC = 2;
            else if (nClass >= 2)    nDC = 1;
        }
        return nDC;
}

 //Unheavened spell
int UnheavenedAdjustment(object oTarget, object oCaster)
{
    int nAdjust = 0;

    if(GetHasSpellEffect(SPELL_UNHEAVENED, oTarget))
    {
        if((MyPRCGetRacialType(oCaster) == RACIAL_TYPE_OUTSIDER) && (GetAlignmentGoodEvil(oCaster) == ALIGNMENT_GOOD))
        {
            nAdjust = -4;
        }
    }
    return nAdjust;
}

// Soul Eater's 10th level Soul Power ability. If they've drained in the last 24h, they get +2 to DCs
int SoulEaterSoulPower(object oCaster)
{
    return (GetLocalInt(oCaster, "PRC_SoulEater_HasDrained") && GetLevelByClass(CLASS_TYPE_SOUL_EATER, oCaster) >= 10) ? 2 : 0;
}

//Draconic Power's elemental boost to spell DCs
int DraconicPowerDC(int spell_id, object oCaster = OBJECT_SELF)
{
    int nDC = 0;

    if (GetHasFeat(FEAT_DRACONIC_POWER, oCaster)) {
        // get spell elemental type
        string element = ChangedElementalType(spell_id, oCaster);
        //if(DEBUG) FloatingTextStringOnCreature("Elemental type: " + element, oCaster, FALSE);

        // Compare heritage type and elemental type
        if (element == "Fire" && (GetHasFeat(FEAT_DRACONIC_HERITAGE_BS, oCaster)
               || GetHasFeat(FEAT_DRACONIC_HERITAGE_GD, oCaster)
               || GetHasFeat(FEAT_DRACONIC_HERITAGE_RD, oCaster)))
        {
            return 1;
        }
        else if (element == "Cold" && (GetHasFeat(FEAT_DRACONIC_HERITAGE_CR, oCaster)
               || GetHasFeat(FEAT_DRACONIC_HERITAGE_SR, oCaster)
               || GetHasFeat(FEAT_DRACONIC_HERITAGE_TP, oCaster)
               || GetHasFeat(FEAT_DRACONIC_HERITAGE_WH, oCaster)))
        {
            return 1;
        }
        else if (element == "Electricity" && (GetHasFeat(FEAT_DRACONIC_HERITAGE_BL, oCaster)
               || GetHasFeat(FEAT_DRACONIC_HERITAGE_BZ, oCaster)
               || GetHasFeat(FEAT_DRACONIC_HERITAGE_SA, oCaster)))
        {
            return 1;
        }
        else if (element == "Acid" && (GetHasFeat(FEAT_DRACONIC_HERITAGE_BK, oCaster)
               || GetHasFeat(FEAT_DRACONIC_HERITAGE_CP, oCaster)
               || GetHasFeat(FEAT_DRACONIC_HERITAGE_GR, oCaster)))
        {
            return 1;
        }
        else if (element == "Sonic" && GetHasFeat(FEAT_DRACONIC_HERITAGE_EM, oCaster))
        {
            return 1;
        }
    }

    //if it gets here, the caster does not have the feat, or is a heritage type without a NWN element (e.g. Amethyst)
    return nDC;
}

//Energy Draconc Aura's elemental boost to spell DCs
int EnergyAuraDC(int spell_id, object oCaster = OBJECT_SELF)
{
    int nDC = 0;

    // get spell elemental type
    string element = ChangedElementalType(spell_id, oCaster);
    //if(DEBUG) FloatingTextStringOnCreature("Elemental type: " + element, oCaster, FALSE);

    // Compare aura type and elemental type
    if (element == "Fire" && (GetLocalInt(oCaster, "FireEnergyAura") > 0))
    {
            return GetLocalInt(oCaster, "FireEnergyAura");
    }
    else if (element == "Cold" && (GetLocalInt(oCaster, "ColdEnergyAura") > 0))
    {
            return GetLocalInt(oCaster, "ColdEnergyAura");
    }
    else if (element == "Electricity" && (GetLocalInt(oCaster, "ElecEnergyAura") > 0))
    {
            return GetLocalInt(oCaster, "ElecEnergyAura");
    }
    else if (element == "Acid" && (GetLocalInt(oCaster, "AcidEnergyAura") > 0))
    {
            return GetLocalInt(oCaster, "AcidEnergyAura");
    }

    //if it gets here, the caster is not in this type of Draconic Aura
    return nDC;
}

//Spirit Folk get a better save vs elemental stuff
int SpiritFolkAdjustment(int spell_id, object oCaster, object oTarget)
{
    int nDC = 0;

    // get spell elemental type
    string element = ChangedElementalType(spell_id, oCaster);
    //if(DEBUG) FloatingTextStringOnCreature("Elemental type: " + element, oCaster, FALSE);

    // Compare aura type and elemental type
    if (element == "Fire" && GetHasFeat(FEAT_BONUS_SEA, oTarget))
    {
            return -2;
    }
    else if (element == "Cold" && GetHasFeat(FEAT_BONUS_RIVER, oTarget))
    {
            return -2;
    }
    else if (element == "Acid" && GetHasFeat(FEAT_BONUS_BAMBOO, oTarget))
    {
            return -2;
    }

    //if it gets here, the target is not a Spirit Folk
    return nDC;
}

//Angry Spell for Rage Mage class
int AngrySpell(int spell_id, object oCaster = OBJECT_SELF)
{
    int nDC = 0;

    int nSpellSchool = GetSpellSchool(spell_id);
    if(GetHasSpellEffect(SPELL_SPELL_RAGE, oCaster) &&
    (nSpellSchool == SPELL_SCHOOL_ABJURATION ||
     nSpellSchool == SPELL_SCHOOL_CONJURATION ||
     nSpellSchool == SPELL_SCHOOL_EVOCATION ||
     nSpellSchool == SPELL_SCHOOL_NECROMANCY ||
     nSpellSchool == SPELL_SCHOOL_TRANSMUTATION))
    {
        if(GetLevelByClass(CLASS_TYPE_RAGE_MAGE, oCaster) >= 10)
            nDC = 4;
        else if(GetLevelByClass(CLASS_TYPE_RAGE_MAGE, oCaster) >= 5)
            nDC = 2;
    }

    return nDC;
}

int CloakedCastingDC(int spell_id, object oTarget, object oCaster = OBJECT_SELF)
{
    int nDC = 0;
    if(GetIsDeniedDexBonusToAC(oTarget, oCaster, TRUE))
    {
        if(GetLevelByClass(CLASS_TYPE_BEGUILER, oCaster) >= 14)
            nDC = 2;
        else if(GetLevelByClass(CLASS_TYPE_BEGUILER, oCaster) >= 2)
            nDC = 1;
    }

    return nDC;
}

int PRCGetSaveDC(object oTarget, object oCaster, int nSpellID = -1)
{
    object oItem = GetSpellCastItem();
    if(nSpellID == -1)
        nSpellID = PRCGetSpellId();
    int nDC;
    // at this point, if it's still -1 then this is running on an AoE
    if (nSpellID == -1)
    {
        // get the needed values off the AoE
        nSpellID = GetLocalInt(OBJECT_SELF, "X2_AoE_SpellID");
        nDC = GetLocalInt(OBJECT_SELF, "X2_AoE_BaseSaveDC");
    }
    else // not persistent AoE script
    {
        //10+spelllevel+stat(cha default)
        nDC = GetSpellSaveDC();
    }
    // For when you want to assign the caster DC
    //this does not take feat/race/class into account, it is an absolute override
    if (GetLocalInt(oCaster, PRC_DC_TOTAL_OVERRIDE) != 0)
    {
        nDC = GetLocalInt(oCaster, PRC_DC_TOTAL_OVERRIDE);
        if(DEBUG) DoDebug("Forced-DC PRC_DC_TOTAL_OVERRIDE casting at DC " + IntToString(nDC));
    }
    // For when you want to assign the caster DC
    //this does take feat/race/class into account, it only overrides the baseDC
    else if (GetLocalInt(oCaster, PRC_DC_BASE_OVERRIDE) != 0)
    {
        nDC = GetLocalInt(oCaster, PRC_DC_BASE_OVERRIDE);
        if(nDC == -1)
        {
            int nClass = PRCGetLastSpellCastClass();
            nDC = 10;
            if(nClass == CLASS_TYPE_BARD)
                nDC += StringToInt(Get2DACache("Spells", "Bard", nSpellID));
            else if(nClass == CLASS_TYPE_CLERIC)
                nDC += StringToInt(Get2DACache("Spells", "Cleric", nSpellID));
            else if(nClass == CLASS_TYPE_DRUID)
                nDC += StringToInt(Get2DACache("Spells", "Druid", nSpellID));
            else if(nClass == CLASS_TYPE_RANGER)
                nDC += StringToInt(Get2DACache("Spells", "Ranger", nSpellID));
            else if(nClass == CLASS_TYPE_PALADIN)
                nDC += StringToInt(Get2DACache("Spells", "Paladin", nSpellID));
            else if(nClass == CLASS_TYPE_WIZARD
                || nClass == CLASS_TYPE_SORCERER)
                nDC += StringToInt(Get2DACache("Spells", "Wiz_Sorc", nSpellID));
            else if(nClass != CLASS_TYPE_INVALID)
            {
                int nSpellbookID = RealSpellToSpellbookID(nClass, nSpellID);
                string sFile = GetFileForClass(nClass);
                nDC += StringToInt(Get2DACache(sFile, "Level", nSpellbookID));
            }
            else
                nDC += StringToInt(Get2DACache("Spells", "Innate", nSpellID));

            nDC += GetDCAbilityModForClass(nClass, oCaster);
        }

        if(DEBUG) DoDebug("Forced Base-DC casting at DC " + IntToString(nDC));
        if(!GetIsObjectValid(oItem)
            || (GetBaseItemType(oItem) == BASE_ITEM_MAGICSTAFF
                && GetPRCSwitch(PRC_STAFF_CASTER_LEVEL)))
        {
            string sSchool = Get2DACache("spells", "School", nSpellID);
            if(sSchool == "V")
            {
                if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_EVOCATION, oCaster))
                    nDC+=6;
                else if(GetHasFeat(FEAT_GREATER_SPELL_FOCUS_EVOCATION, oCaster))
                    nDC+=4;
                else if(GetHasFeat(FEAT_SPELL_FOCUS_EVOCATION, oCaster))
                    nDC+=2;
            }
            else if(sSchool == "T")
            {
                if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_TRANSMUTATION, oCaster))
                    nDC+=6;
                else if(GetHasFeat(FEAT_GREATER_SPELL_FOCUS_TRANSMUTATION, oCaster))
                    nDC+=4;
                else if(GetHasFeat(FEAT_SPELL_FOCUS_TRANSMUTATION, oCaster))
                    nDC+=2;
            }
            else if(sSchool == "N")
            {
                if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_NECROMANCY, oCaster))
                    nDC+=6;
                else if(GetHasFeat(FEAT_GREATER_SPELL_FOCUS_NECROMANCY, oCaster))
                    nDC+=4;
                else if(GetHasFeat(FEAT_SPELL_FOCUS_NECROMANCY, oCaster))
                    nDC+=2;
            }
            else if(sSchool == "I")
            {
                if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_ILLUSION, oCaster))
                    nDC+=6;
                else if(GetHasFeat(FEAT_GREATER_SPELL_FOCUS_ILLUSION, oCaster))
                    nDC+=4;
                else if(GetHasFeat(FEAT_SPELL_FOCUS_ILLUSION, oCaster))
                    nDC+=2;
            }
            else if(sSchool == "A")
            {
                if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_ABJURATION, oCaster))
                    nDC+=6;
                else if(GetHasFeat(FEAT_GREATER_SPELL_FOCUS_ABJURATION, oCaster))
                    nDC+=4;
                else if(GetHasFeat(FEAT_SPELL_FOCUS_ABJURATION, oCaster))
                    nDC+=2;
            }
            else if(sSchool == "C")
            {
                if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_CONJURATION, oCaster))
                    nDC+=6;
                else if(GetHasFeat(FEAT_GREATER_SPELL_FOCUS_CONJURATION, oCaster))
                    nDC+=4;
                else if(GetHasFeat(FEAT_SPELL_FOCUS_CONJURATION, oCaster))
                    nDC+=2;
            }
            else if(sSchool == "D")
            {
                if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_DIVINATION, oCaster))
                    nDC+=6;
                else if(GetHasFeat(FEAT_GREATER_SPELL_FOCUS_DIVINATION, oCaster))
                    nDC+=4;
                else if(GetHasFeat(FEAT_SPELL_FOCUS_DIVINATION, oCaster))
                    nDC+=2;
            }
            else if(sSchool == "E")
            {
                if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_ENCHANTMENT, oCaster))
                    nDC+=6;
                else if(GetHasFeat(FEAT_GREATER_SPELL_FOCUS_ENCHANTMENT, oCaster))
                    nDC+=4;
                else if(GetHasFeat(FEAT_SPELL_FOCUS_ENCHANTMENT, oCaster))
                    nDC+=2;
            }
        }
        nDC += GetChangesToSaveDC(oTarget, oCaster, nSpellID);
    }
    else if(GetIsObjectValid(oItem)
        && !(GetBaseItemType(oItem) == BASE_ITEM_MAGICSTAFF
                && GetPRCSwitch(PRC_STAFF_CASTER_LEVEL)))
    {
        //code for getting new ip type
        itemproperty ipTest = GetFirstItemProperty(oItem);
        while(GetIsItemPropertyValid(ipTest))
        {
            if(GetItemPropertyType(ipTest) == ITEM_PROPERTY_CAST_SPELL_DC)
            {
                int nSubType = GetItemPropertySubType(ipTest);
                nSubType = StringToInt(Get2DACache("iprp_spells", "SpellIndex", nSubType));
                if(nSubType == nSpellID)
                {
                    nDC = GetItemPropertyCostTableValue (ipTest);
                    break;//end while
                }
            }
            ipTest = GetNextItemProperty(oItem);
        }
    }
    else
        nDC += GetChangesToSaveDC(oTarget, oCaster, nSpellID);
    //target-based adjustments go here
    nDC += RedWizardDCPenalty(nSpellID, oTarget);
    nDC += ShadowAdeptDCPenalty(nSpellID, oTarget);
    return nDC;

}

//called just from above and from inc_epicspells
int GetChangesToSaveDC(object oTarget, object oCaster = OBJECT_SELF, int nSpellID = -1)
{
    if(nSpellID == -1)
        nSpellID = PRCGetSpellId();
    int nDC;
    nDC += ElementalSavantDC(nSpellID, oCaster);
    nDC += GetHeartWarderDC(nSpellID, oCaster);
    nDC += GetSpellPowerBonus(oCaster);
    nDC += ShadowWeaveDC(nSpellID, oCaster);
    nDC += RedWizardDC(nSpellID, oCaster);
    nDC += TattooFocus(nSpellID, oCaster);
    nDC += SpellFocus(nSpellID, oCaster);
    nDC += KOTCSpellFocusVsDemons(oTarget, oCaster);
    nDC += BloodMagusBloodComponent(oCaster);
    nDC += RunecasterRunePowerDC(oCaster);
    nDC += UnheavenedAdjustment(oTarget, oCaster);
    nDC += SoulEaterSoulPower(oCaster);
    nDC += DraconicPowerDC(nSpellID, oCaster);
    nDC += EnergyAuraDC(nSpellID, oCaster);
    nDC += SpiritFolkAdjustment(nSpellID, oCaster, oTarget);
    nDC += AngrySpell(nSpellID, oCaster);
    nDC += CloakedCastingDC(nSpellID, oTarget);
    nDC += GetLocalInt(oCaster, PRC_DC_ADJUSTMENT);//this is for builder use
    return nDC;

}

// Test main
//void main(){}
