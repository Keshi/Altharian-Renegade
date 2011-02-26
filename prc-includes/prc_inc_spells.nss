/*
   ----------------
   prc_inc_spells
   ----------------

   7/25/04 by WodahsEht

   Contains many useful functions for determining caster level, mostly.  The goal
   is to consolidate all caster level functions to this -- existing caster level
   functions will be wrapped around the main function.

   In the future, all new PrC's that add to caster levels should be added to
   the GetArcanePRCLevels and GetDivinePRCLevels functions.  Very little else should
   be necessary, except when new casting feats are created.
*/


//////////////////////////////////////////////////
/*             Function prototypes              */
//////////////////////////////////////////////////

/**
 * A lookup for caster level progression for divine and arcane base classes
 * @return an int that can be used in caster level calculations note: these use int division
 */
int GetCasterLevelModifier(int nClass);

/**
 * Adjusts the base class level (NOT caster level) of the class by any spellcasting PrCs
 * @param nClass a base casting class (divine or arcane)
 * @return The level of the class, adjusted for any appropriate PrC levels
 */
int GetPrCAdjustedClassLevel(int nClass, object oCaster = OBJECT_SELF);

/**
 * Adjusts the base caster level of the class by any spellcasting PrCs plus Practised Spellcasting feats if appropriate
 * @param nClass a base casting class
 * @param bAdjustForPractisedSpellcaster add practiced spellcaster feat to caster level. TRUE by default
 * @return the caster level in the class, adjusted by any PrC levels and practised spellcaster feats as appropriate
 */
int GetPrCAdjustedCasterLevel(int nClassType, object oCaster = OBJECT_SELF, int bAdjustForPractisedSpellcaster = TRUE);

/**
 * finds the highest arcane or divine caster level, adjusting the base caster level of the class by any
 * spellcasting PrCs plus Practised Spellcasting feats if appropriate
 * @param nClassType TYPE_DIVINE or TYPE_ARCANE
 * @param bAdjustForPractisedSpellcaster add practiced spellcaster feat to caster level. TRUE by default
 * @return the highest arcane/divine caster level adjusted by any PrC levels and practised spellcaster feats as appropriate
 */
int GetPrCAdjustedCasterLevelByType(int nClassType, object oCaster = OBJECT_SELF, int bAdjustForPractisedSpellcaster = TRUE);

// Returns the best "natural" arcane levels of the PC in question.  Does not
// consider feats that situationally adjust caster level.
int GetLevelByTypeArcane(object oCaster = OBJECT_SELF);

// Returns the best "natural" divine levels of the PC in question.  Does not
// consider feats that situationally adjust caster level.
int GetLevelByTypeDivine(object oCaster = OBJECT_SELF);

// Returns the best "feat-adjusted" arcane levels of the PC in question.
// Considers feats that situationally adjust caster level.
int GetLevelByTypeArcaneFeats(object oCaster = OBJECT_SELF, int iSpellID = -1);

// Returns the best "feat-adjusted" divine levels of the PC in question.
// Considers feats that situationally adjust caster level.
int GetLevelByTypeDivineFeats(object oCaster = OBJECT_SELF, int iSpellID = -1);

//Returns Reflex Adjusted Damage. Is a wrapper function that allows the
//DC to be adjusted based on conditions that cannot be done using iprops
//such as saves vs spellschools, or other adjustments
int PRCGetReflexAdjustedDamage(int nDamage, object oTarget, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus=OBJECT_SELF);

//Returns 0, 1 or 2 as MySavingThrow does. 0 is a failure, 1 is success, 2 is immune.
//Is a wrapper function that allows the DC to be adjusted based on conditions
//that cannot be done using iprops, such as saves vs spellschool.
int PRCMySavingThrow(int nSavingThrow, object oTarget, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus = OBJECT_SELF, float fDelay = 0.0);

// Finds caster levels by specific types (see the constants below).
int GetCasterLvl(int iTypeSpell, object oCaster = OBJECT_SELF);

// Applies bonus damage to targets from Prestige abilities, like the Diabolist.
//
// oTarget - Target of the spell
void PRCBonusDamage(object oTarget);

//  Calculates bonus damage to a spell for Spell Betrayal Ability
int SpellBetrayalDamage(object oTarget, object oCaster);

//  Calculates damage to a spell for Spellstrike Ability
int SpellStrikeDamage(object oTarget, object oCaster);

// Create a Damage effect
// - oTarget: spell target
// - nDamageAmount: amount of damage to be dealt. This should be applied as an
//   instantaneous effect.
// - nDamageType: DAMAGE_TYPE_*
// - nDamagePower: DAMAGE_POWER_*
// Used to add Warmage's Edge to spells.
effect PRCEffectDamage(object oTarget, int nDamageAmount, int nDamageType=DAMAGE_TYPE_MAGICAL, int nDamagePower=DAMAGE_POWER_NORMAL);

int IsSpellDamageElemental(int nDamageType);

// Get altered damage type for energy sub feats.
//      nDamageType - The DAMAGE_TYPE_xxx constant of the damage. All types other
//          than elemental damage types are ignored.
//      oCaster - caster object.
// moved from spinc_common, possibly somewhat redundant
int PRCGetElementalDamageType(int nDamageType, object oCaster = OBJECT_SELF);

//  Adds the bonus damage from both Spell Betrayal and Spellstrike together
int ApplySpellBetrayalStrikeDamage(object oTarget, object oCaster, int bShowTextString = TRUE);

// wrapper for DecrementRemainingSpellUses, works for newspellbook 'fake' spells too
void PRCDecrementRemainingSpellUses(object oCreature, int nSpell);

/**
 * Determines and applies the alignment shift for using spells/powers with the
 * [Evil] descriptor.  The amount of adjustment is equal to the square root of
 * the caster's distance from pure evil.
 * In other words, the amount of shift is higher the farther the caster is from
 * pure evil, with the extremes being 10 points of shift at pure good and 0
 * points of shift at pure evil.
 *
 * Does nothing if the PRC_SPELL_ALIGNMENT_SHIFT switch is not set.
 *
 * @param oPC The caster whose alignment to adjust
 */
void SPEvilShift(object oPC);

/**
 * Determines and applies the alignment shift for using spells/powers with the
 * [Good] descriptor.  The amount of adjustment is equal to the square root of
 * the caster's distance from pure good.
 * In other words, the amount of shift is higher the farther the caster is from
 * pure good, with the extremes being 10 points of shift at pure evil and 0
 * points of shift at pure good.
 *
 * Does nothing if the PRC_SPELL_ALIGNMENT_SHIFT switch is not set.
 *
 * @param oPC The caster whose alignment to adjust
 */
void SPGoodShift(object oPC);

/**
 * Applies the corruption cost for Corrupt spells.
 *
 * @param oPC      The caster of the Corrupt spell
 * @param oTarget  The target of the spell.
 *                 Not used for anything, should probably remove - Ornedan
 * @param nAbility ABILITY_* of the ability to apply the cost to
 * @param nCost    The amount of stat damage or drain to apply
 * @param bDrain   If this is TRUE, the cost is applied as ability drain.
 *                 If FALSE, as ability damage.
 */
void DoCorruptionCost(object oPC, int nAbility, int nCost, int bDrain);

// This function is used in the spellscripts
// It functions as Evasion for Fortitude and Will partial saves
// This means the "partial" section is ignored
// nSavingThrow takes either SAVING_THROW_WILL or SAVING_THROW_FORT
int GetHasMettle(object oTarget, int nSavingThrow);

/*This function is used to tell whether the target is incorporeal via
 *the persistant local int "IS_INCORPOREAL" or appearance.
 */


// Test for incorporeallity of the target
// useful for targetting loops when incorporeal creatures
// wouldnt be affected
int GetIsIncorporeal(object oTarget);

/** Tests if a creature is living. Should be called on creatures.
 *  Dead and not-alive creatures return FALSE
 *  Returns FALSE for non-creature objects.
 */
int PRCGetIsAliveCreature(object oTarget);


// Gets the total number of HD of controlled undead
// i.e from Animate Dead, Ghoul Gauntlet or similar
// Dominated undead from Turn Undead do not count
int GetControlledUndeadTotalHD(object oPC = OBJECT_SELF);

// Gets the total number of HD of controlled evil outsiders
// i.e from call dretch, call lemure, or similar
// Dominated outsiders from Turn Undead etc do not count
int GetControlledFiendTotalHD(object oPC = OBJECT_SELF);

// Gets the total number of HD of controlled good outsiders
// i.e from call favoured servants
// Dominated outsiders from Turn Undead etc do not count
int GetControlledCelestialTotalHD(object oPC = OBJECT_SELF);

/**
 * Multisummon code, to be run before the summoning effect is applied.
 * Normally, this will only perform the multisummon trick of setting
 * pre-existing summons indestructable if PRC_MULTISUMMON is set.
 *
 * @param oPC          The creature casting the summoning spell
 * @param bOverride    If this is set, ignores the value of PRC_MULTISUMMON switch
 */
void MultisummonPreSummon(object oPC = OBJECT_SELF, int bOverride = FALSE);

/**
 * Sets up all of the AoE's variables, but only if they aren't already set.
 *
 * This sets many things that would have been checked against GetAreaOfEffectCreator()
 * as local ints making it so the AoE can now function entirely independantly of its caster.
 * - The only problem is that this will never be called until the AoE does a heartbeat or
 * something.
 *
 * @param SpellID       Spell ID to store on the AoE.
 * @param oAoE          AoE object to store the variables on
 * @param nBaseSaveDC   save DC to store on the AoE
 * @param SpecDispel    Stored on the AoE (dunno what it's for)
 * @param nCasterLevel  Caster level to store on the AoE. If default used, gets
 *                      caster level from the AoE creator.
 */
void SetAllAoEInts(int SpellID, object oAoE, int nBaseSaveDC ,int SpecDispel = 0 , int nCasterLevel = 0);

// * Applies the effects of FEAT_AUGMENT_SUMMON to summoned creatures.
void AugmentSummonedCreature(object oSelf = OBJECT_SELF);

// -----------------
// BEGIN SPELLSWORD
// -----------------

//This function returns 1 only if the object oTarget is the object
//the weapon hit when it channeled the spell sSpell or if there is no
//channeling at all
int ChannelChecker(string sSpell, object oTarget);

//If a spell is being channeled, we store its target and its name
void StoreSpellVariables(string sString,int nDuration);

//Replacement for The MaximizeOrEmpower function that checks for metamagic feats
//in channeled spells as well
int PRCMaximizeOrEmpower(int nDice, int nNumberOfDice, int nMeta, int nBonus = 0);

//This checks if the spell is channeled and if there are multiple spells
//channeled, which one is it. Then it checks in either case if the spell
//has the metamagic feat the function gets and returns TRUE or FALSE accordingly
//int CheckMetaMagic(int nMeta,int nMMagic);
//not needed now there is PRCGetMetaMagicFeat()

//wrapper for biowares GetMetaMagicFeat()
//used for spellsword and items
//      bClearSuddenFlags - clear sudden metamagic info - set it to FALSE if you're
//                          going to use PRCGetMetaMagicFeat() more than once for a single spell
//                          (ie. in spellhook code)
int PRCGetMetaMagicFeat(object oCaster = OBJECT_SELF, int bClearSuddenFlags = TRUE);

// This function rolls damage and applies metamagic feats to the damage.
//      nDamageType - The DAMAGE_TYPE_xxx constant for the damage, or -1 for no
//          a non-damaging effect.
//      nDice - number of dice to roll.
//      nDieSize - size of dice, i.e. d4, d6, d8, etc.
//      nBonusPerDie - Amount of bonus damage per die.
//      nBonus - Amount of overall bonus damage.
//      nMetaMagic - metamagic constant, if -1 GetMetaMagic() is called.
//      returns - the damage rolled with metamagic applied.
int PRCGetMetaMagicDamage(int nDamageType, int nDice, int nDieSize,
    int nBonusPerDie = 0, int nBonus = 0, int nMetaMagic = -1);

// Function to save the school of the currently cast spell in a variable.  This should be
// called at the beginning of the script to set the spell school (passing the school) and
// once at the end of the script (with no arguments) to delete the variable.
//  nSchool - SPELL_SCHOOL_xxx constant to set, if general then the variable is
//      deleted.
// moved from spinc_common and renamed
void PRCSetSchool(int nSchool = SPELL_SCHOOL_GENERAL);

/**
 * Signals a spell has been cast. Acts as a wrapper to fire EVENT_SPELL_CAST_AT
 * via SignalEvent()
 * @param oTarget   Target of the spell.
 * @param bHostile  TRUE if the spell is a hostile act.
 * @param nSpellID  Spell ID or -1 if PRCGetSpellId() should be used.
 * @param oCaster   Object doing the casting.
 */
void PRCSignalSpellEvent(object oTarget, int bHostile = TRUE, int nSpellID = -1, object oCaster = OBJECT_SELF);

//GetFirstObjectInShape wrapper for changing the AOE of the channeled spells (Spellsword Channel Spell)
object MyFirstObjectInShape(int nShape, float fSize, location lTarget, int bLineOfSight=FALSE, int nObjectFilter=OBJECT_TYPE_CREATURE, vector vOrigin=[0.0,0.0,0.0]);

//GetNextObjectInShape wrapper for changing the AOE of the channeled spells (Spellsword Channel Spell)
object MyNextObjectInShape(int nShape, float fSize, location lTarget, int bLineOfSight=FALSE, int nObjectFilter=OBJECT_TYPE_CREATURE, vector vOrigin=[0.0,0.0,0.0]);

// * Kovi. removes any effects from this type of spell
// * i.e., used in Mage Armor to remove any previous
// * mage armors
void PRCRemoveEffectsFromSpell(object oTarget, int SpellID);

// * Get Scaled Effect
effect PRCGetScaledEffect(effect eStandard, object oTarget);

// * Searchs through a persons effects and removes all those of a specific type.
void PRCRemoveSpecificEffect(int nEffectTypeID, object oTarget);

// * Returns true if Target is a humanoid
int PRCAmIAHumanoid(object oTarget);

// * Get Difficulty Duration
int PRCGetScaledDuration(int nActualDuration, object oTarget);

// * Will pass back a linked effect for all the protection from alignment spells.  The power represents the multiplier of strength.
// * That is instead of +3 AC and +2 Saves a  power of 2 will yield +6 AC and +4 Saves.
effect PRCCreateProtectionFromAlignmentLink(int nAlignment, int nPower = 1);

// * Returns the time in seconds that the effect should be delayed before application.
float PRCGetSpellEffectDelay(location SpellTargetLocation, object oTarget);

// * This is a wrapper for how Petrify will work in Expansion Pack 1
// * Scripts affected: flesh to stone, breath petrification, gaze petrification, touch petrification
// * nPower : This is the Hit Dice of a Monster using Gaze, Breath or Touch OR it is the Caster Spell of
// *   a spellcaster
// * nFortSaveDC: pass in this number from the spell script
void PRCDoPetrification(int nPower, object oSource, object oTarget, int nSpellID, int nFortSaveDC);

int PRCGetDelayedSpellEffectsExpired(int nSpell_ID, object oTarget, object oCaster);

int PRCGetSpellUsesLeft(int nRealSpellID, object oCreature = OBJECT_SELF);
// -----------------
// END SPELLSWORD
// -----------------

// Functions mostly only useful within the scope of this include
int BWSavingThrow(int nSavingThrow, object oTarget, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus = OBJECT_SELF, float fDelay = 0.0);

//////////////////////////////////////////////////
/*                 Constants                    */
//////////////////////////////////////////////////

// this could also be put into in prc_inc_switches
const string PRC_SAVEDC_OVERRIDE = "PRC_SAVEDC_OVERRIDE";

const int  TYPE_ARCANE   = -1;
const int  TYPE_DIVINE   = -2;

//Changed to use CLASS_TYPE_* instead
//const int  TYPE_SORCERER = 2;
//const int  TYPE_WIZARD   = 3;
//const int  TYPE_BARD     = 4;
//const int  TYPE_CLERIC   = 11;
//const int  TYPE_DRUID    = 12;
//const int  TYPE_RANGER   = 13;
//const int  TYPE_PALADIN  = 14;

//////////////////////////////////////////////////
/*                  Includes                    */
//////////////////////////////////////////////////

//#include "inc_abil_damage"
//#include "prc_inc_castlvl"
//#include "lookup_2da_spell"

// ** THIS ORDER IS IMPORTANT **

//#include "inc_lookups"	// access via prc_inc_core
#include "inc_newspellbook"

//#include "prc_inc_core"  // Compiler won't allow access via inc_newspellbook

#include "inc_vfx_const"
#include "spinc_necro_cyst"
//#include "psi_power_const"


#include "prc_spellhook"
#include "prc_inc_sneak"
#include "prcsp_engine"
//#include "prc_inc_descrptr"
#include "inc_item_props"


//////////////////////////////////////////////////
/*             Function definitions             */
//////////////////////////////////////////////////


int GetCasterLevelModifier(int nClass)
{
    switch (nClass) // do not change to return zero as this is used as a divisor
    {
        // add in new base half-caster classes here
        case CLASS_TYPE_HEXBLADE:
        case CLASS_TYPE_RANGER:
        case CLASS_TYPE_PALADIN:
        case CLASS_TYPE_ANTI_PALADIN:
            return 2;
        default: // normal progression
            return 1;
    }
    return 1; // stupid compiler
}

int GetPrCAdjustedClassLevel(int nClass, object oCaster = OBJECT_SELF)
{
    int iTemp;
    // is it arcane, divine or neither?
    if(GetIsArcaneClass(nClass, oCaster) && nClass != CLASS_TYPE_SUBLIME_CHORD)
    {
        if (GetPrimaryArcaneClass(oCaster) == nClass) // adjust for any PrCs
            iTemp = GetArcanePRCLevels(oCaster);
    }
    else if(GetIsDivineClass(nClass, oCaster))
    {
        if (GetPrimaryDivineClass(oCaster) == nClass) // adjust for any PrCs
            iTemp = GetDivinePRCLevels(oCaster);
    }
    else // a non-caster class or a PrC
    {
        return 0;
    }
    // add the caster class levels
    return iTemp += GetLevelByClass(nClass, oCaster);
}

int GetPrCAdjustedCasterLevel(int nClass, object oCaster = OBJECT_SELF, int bAdjustForPractisedSpellcaster = TRUE)
{
    int iTemp;
    iTemp = GetPrCAdjustedClassLevel(nClass, oCaster);
    iTemp = iTemp / GetCasterLevelModifier(nClass);
    if (bAdjustForPractisedSpellcaster)
        iTemp += PracticedSpellcasting(oCaster, nClass, iTemp);
    return iTemp;
}

int GetPrCAdjustedCasterLevelByType(int nClassType, object oCaster = OBJECT_SELF, int bAdjustForPractisedSpellcaster = TRUE)
{
    int nHighest;
    int nClass1, nClass2, nClass3;
    int nClass1Lvl, nClass2Lvl, nClass3Lvl;
    nClass1 = GetClassByPosition(1, oCaster);
    nClass2 = GetClassByPosition(2, oCaster);
    nClass3 = GetClassByPosition(3, oCaster);
    if(nClassType == TYPE_ARCANE && (GetFirstArcaneClassPosition(oCaster) > 0))
    {
        if (GetIsArcaneClass(nClass1, oCaster)) nClass1Lvl = GetPrCAdjustedCasterLevel(nClass1, oCaster, bAdjustForPractisedSpellcaster);
        if (GetIsArcaneClass(nClass2, oCaster)) nClass2Lvl = GetPrCAdjustedCasterLevel(nClass2, oCaster, bAdjustForPractisedSpellcaster);
        if (GetIsArcaneClass(nClass3, oCaster)) nClass3Lvl = GetPrCAdjustedCasterLevel(nClass3, oCaster, bAdjustForPractisedSpellcaster);
    }
    else if (nClassType == TYPE_DIVINE && (GetFirstDivineClassPosition(oCaster) > 0))
    {
        if (GetIsDivineClass(nClass1, oCaster)) nClass1Lvl = GetPrCAdjustedCasterLevel(nClass1, oCaster, bAdjustForPractisedSpellcaster);
        if (GetIsDivineClass(nClass2, oCaster)) nClass2Lvl = GetPrCAdjustedCasterLevel(nClass2, oCaster, bAdjustForPractisedSpellcaster);
        if (GetIsDivineClass(nClass3, oCaster)) nClass3Lvl = GetPrCAdjustedCasterLevel(nClass3, oCaster, bAdjustForPractisedSpellcaster);
    }
    nHighest = nClass1Lvl;
    if (nClass2Lvl > nHighest) nHighest = nClass2Lvl;
    if (nClass3Lvl > nHighest) nHighest = nClass3Lvl;
    return nHighest;
}

int GetLevelByTypeArcane(object oCaster = OBJECT_SELF)
{
    int iFirstArcane = GetPrimaryArcaneClass(oCaster);
    int iBest = 0;
    int iClass1 = GetClassByPosition(1, oCaster);
    int iClass2 = GetClassByPosition(2, oCaster);
    int iClass3 = GetClassByPosition(3, oCaster);
    int iClass1Lev = GetLevelByPosition(1, oCaster);
    int iClass2Lev = GetLevelByPosition(2, oCaster);
    int iClass3Lev = GetLevelByPosition(3, oCaster);

    if (iClass1 == CLASS_TYPE_HEXBLADE) iClass1Lev = (iClass1Lev >= 4) ? (iClass1Lev / 2) : 0;
    if (iClass2 == CLASS_TYPE_HEXBLADE) iClass2Lev = (iClass2Lev >= 4) ? (iClass2Lev / 2) : 0;
    if (iClass3 == CLASS_TYPE_HEXBLADE) iClass3Lev = (iClass3Lev >= 4) ? (iClass3Lev / 2) : 0;

    if (iClass1 == iFirstArcane) iClass1Lev += GetArcanePRCLevels(oCaster);
    if (iClass2 == iFirstArcane) iClass2Lev += GetArcanePRCLevels(oCaster);
    if (iClass3 == iFirstArcane) iClass3Lev += GetArcanePRCLevels(oCaster);

    iClass1Lev += PracticedSpellcasting(oCaster, iClass1, iClass1Lev);
    iClass2Lev += PracticedSpellcasting(oCaster, iClass2, iClass2Lev);
    iClass3Lev += PracticedSpellcasting(oCaster, iClass3, iClass3Lev);

    if (!GetIsArcaneClass(iClass1, oCaster)) iClass1Lev = 0;
    if (!GetIsArcaneClass(iClass2, oCaster)) iClass2Lev = 0;
    if (!GetIsArcaneClass(iClass3, oCaster)) iClass3Lev = 0;

    if (iClass1Lev > iBest) iBest = iClass1Lev;
    if (iClass2Lev > iBest) iBest = iClass2Lev;
    if (iClass3Lev > iBest) iBest = iClass3Lev;

    return iBest;
}

int GetLevelByTypeDivine(object oCaster = OBJECT_SELF)
{
    int iFirstDivine = GetPrimaryDivineClass(oCaster);
    int iBest = 0;
    int iClass1 = GetClassByPosition(1, oCaster);
    int iClass2 = GetClassByPosition(2, oCaster);
    int iClass3 = GetClassByPosition(3, oCaster);
    int iClass1Lev = GetLevelByPosition(1, oCaster);
    int iClass2Lev = GetLevelByPosition(2, oCaster);
    int iClass3Lev = GetLevelByPosition(3, oCaster);

    if (iClass1 == CLASS_TYPE_PALADIN || iClass1 == CLASS_TYPE_RANGER) iClass1Lev = (iClass1Lev >= 4) ? (iClass1Lev / 2) : 0;
    if (iClass2 == CLASS_TYPE_PALADIN || iClass2 == CLASS_TYPE_RANGER) iClass2Lev = (iClass2Lev >= 4) ? (iClass2Lev / 2) : 0;
    if (iClass3 == CLASS_TYPE_PALADIN || iClass3 == CLASS_TYPE_RANGER) iClass3Lev = (iClass3Lev >= 4) ? (iClass3Lev / 2) : 0;

    if (iClass1 == iFirstDivine) iClass1Lev += GetDivinePRCLevels(oCaster);
    if (iClass2 == iFirstDivine) iClass2Lev += GetDivinePRCLevels(oCaster);
    if (iClass3 == iFirstDivine) iClass3Lev += GetDivinePRCLevels(oCaster);

    iClass1Lev += PracticedSpellcasting(oCaster, iClass1, iClass1Lev);
    iClass2Lev += PracticedSpellcasting(oCaster, iClass2, iClass2Lev);
    iClass3Lev += PracticedSpellcasting(oCaster, iClass3, iClass3Lev);

    if (!GetIsDivineClass(iClass1, oCaster)) iClass1Lev = 0;
    if (!GetIsDivineClass(iClass2, oCaster)) iClass2Lev = 0;
    if (!GetIsDivineClass(iClass3, oCaster)) iClass3Lev = 0;

    if (iClass1Lev > iBest) iBest = iClass1Lev;
    if (iClass2Lev > iBest) iBest = iClass2Lev;
    if (iClass3Lev > iBest) iBest = iClass3Lev;

    return iBest;
}

int GetLevelByTypeArcaneFeats(object oCaster = OBJECT_SELF, int iSpellID = -1)
{
    int iFirstArcane = GetPrimaryArcaneClass(oCaster);
    int iBest = 0;
    int iClass1 = GetClassByPosition(1, oCaster);
    int iClass2 = GetClassByPosition(2, oCaster);
    int iClass3 = GetClassByPosition(3, oCaster);
    int iClass1Lev = GetLevelByPosition(1, oCaster);
    int iClass2Lev = GetLevelByPosition(2, oCaster);
    int iClass3Lev = GetLevelByPosition(3, oCaster);

    if (iSpellID = -1) iSpellID = PRCGetSpellId(oCaster);

    int iBoost = TrueNecromancy(oCaster, iSpellID, "ARCANE") +
                 ShadowWeave(oCaster, iSpellID) +
                 FireAdept(oCaster, iSpellID) +
                 DomainPower(oCaster, iSpellID) +
                 StormMagic(oCaster) +
                 CormanthyranMoonMagic(oCaster) +
                 DraconicPower(oCaster);

    if (iClass1 == CLASS_TYPE_HEXBLADE) iClass1Lev = (iClass1Lev >= 4) ? (iClass1Lev / 2) : 0;
    if (iClass2 == CLASS_TYPE_HEXBLADE) iClass2Lev = (iClass2Lev >= 4) ? (iClass2Lev / 2) : 0;
    if (iClass3 == CLASS_TYPE_HEXBLADE) iClass3Lev = (iClass3Lev >= 4) ? (iClass3Lev / 2) : 0;

    if (iClass1 == iFirstArcane) iClass1Lev += GetArcanePRCLevels(oCaster);
    if (iClass2 == iFirstArcane) iClass2Lev += GetArcanePRCLevels(oCaster);
    if (iClass3 == iFirstArcane) iClass3Lev += GetArcanePRCLevels(oCaster);

    iClass1Lev += iBoost;
    iClass2Lev += iBoost;
    iClass3Lev += iBoost;

    iClass1Lev += PracticedSpellcasting(oCaster, iClass1, iClass1Lev);
    iClass2Lev += PracticedSpellcasting(oCaster, iClass2, iClass2Lev);
    iClass3Lev += PracticedSpellcasting(oCaster, iClass3, iClass3Lev);

    if (!GetIsArcaneClass(iClass1, oCaster)) iClass1Lev = 0;
    if (!GetIsArcaneClass(iClass2, oCaster)) iClass2Lev = 0;
    if (!GetIsArcaneClass(iClass3, oCaster)) iClass3Lev = 0;

    if (iClass1Lev > iBest) iBest = iClass1Lev;
    if (iClass2Lev > iBest) iBest = iClass2Lev;
    if (iClass3Lev > iBest) iBest = iClass3Lev;

    return iBest;
}

int GetLevelByTypeDivineFeats(object oCaster = OBJECT_SELF, int iSpellID = -1)
{
    int iFirstDivine = GetPrimaryDivineClass(oCaster);
    int iBest = 0;
    int iClass1 = GetClassByPosition(1, oCaster);
    int iClass2 = GetClassByPosition(2, oCaster);
    int iClass3 = GetClassByPosition(3, oCaster);
    int iClass1Lev = GetLevelByPosition(1, oCaster);
    int iClass2Lev = GetLevelByPosition(2, oCaster);
    int iClass3Lev = GetLevelByPosition(3, oCaster);

    if (iSpellID = -1) iSpellID = PRCGetSpellId(oCaster);

    int iBoost = TrueNecromancy(oCaster, iSpellID, "DIVINE") +
                 ShadowWeave(oCaster, iSpellID) +
                 FireAdept(oCaster, iSpellID) +
                 DomainPower(oCaster, iSpellID) +
                 CormanthyranMoonMagic(oCaster) +
                 StormMagic(oCaster);

    if (iClass1 == CLASS_TYPE_PALADIN
        || iClass1 == CLASS_TYPE_RANGER
        || iClass3 == CLASS_TYPE_ANTI_PALADIN)
        iClass1Lev = iClass1Lev / 2;
    if (iClass2 == CLASS_TYPE_PALADIN
        || iClass2 == CLASS_TYPE_RANGER
        || iClass3 == CLASS_TYPE_ANTI_PALADIN)
        iClass2Lev = iClass2Lev / 2;
    if (iClass3 == CLASS_TYPE_PALADIN
        || iClass3 == CLASS_TYPE_RANGER
        || iClass3 == CLASS_TYPE_ANTI_PALADIN)
        iClass3Lev = iClass3Lev / 2;

    if (iClass1 == iFirstDivine) iClass1Lev += GetDivinePRCLevels(oCaster);
    if (iClass2 == iFirstDivine) iClass2Lev += GetDivinePRCLevels(oCaster);
    if (iClass3 == iFirstDivine) iClass3Lev += GetDivinePRCLevels(oCaster);

    iClass1Lev += iBoost;
    iClass2Lev += iBoost;
    iClass3Lev += iBoost;

    iClass1Lev += PracticedSpellcasting(oCaster, iClass1, iClass1Lev);
    iClass2Lev += PracticedSpellcasting(oCaster, iClass2, iClass2Lev);
    iClass3Lev += PracticedSpellcasting(oCaster, iClass3, iClass3Lev);

    if (!GetIsDivineClass(iClass1, oCaster)) iClass1Lev = 0;
    if (!GetIsDivineClass(iClass2, oCaster)) iClass2Lev = 0;
    if (!GetIsDivineClass(iClass3, oCaster)) iClass3Lev = 0;

    if (iClass1Lev > iBest) iBest = iClass1Lev;
    if (iClass2Lev > iBest) iBest = iClass2Lev;
    if (iClass3Lev > iBest) iBest = iClass3Lev;

    return iBest;
}

// looks up the spell level for the arcane caster classes (Wiz_Sorc, Bard) in spells.2da.
// Caveat: some onhitcast spells don't have any spell-levels listed for any class
int GetIsArcaneSpell (int iSpellId)
{
    return  Get2DACache("spells", "Wiz_Sorc", iSpellId) != ""
            || Get2DACache("spells", "Bard", iSpellId) != "";
}

// looks up the spell level for the divine caster classes (Cleric, Druid, Ranger, Paladin) in spells.2da.
// Caveat: some onhitcast spells don't have any spell-levels listed for any class
int GetIsDivineSpell (int iSpellId)
{
    return  Get2DACache("spells", "Cleric", iSpellId) != ""
            || Get2DACache("spells", "Druid", iSpellId) != ""
            || Get2DACache("spells", "Ranger", iSpellId) != ""
            || Get2DACache("spells", "Paladin", iSpellId) != "";
}

int BWSavingThrow(int nSavingThrow, object oTarget, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus = OBJECT_SELF, float fDelay = 0.0)
{
    // -------------------------------------------------------------------------
    // GZ: sanity checks to prevent wrapping around
    // -------------------------------------------------------------------------
    if (nDC<1)
       nDC = 1;
    else if (nDC > 255)
      nDC = 255;

    effect eVis;
    int bValid = FALSE;
    int nSpellID;
    if(nSavingThrow == SAVING_THROW_FORT)
    {
        bValid = FortitudeSave(oTarget, nDC, nSaveType, oSaveVersus);
        if(bValid == 1)
        {
            eVis = EffectVisualEffect(VFX_IMP_FORTITUDE_SAVING_THROW_USE);
        }
    }
    else if(nSavingThrow == SAVING_THROW_REFLEX)
    {
        bValid = ReflexSave(oTarget, nDC, nSaveType, oSaveVersus);
        if(bValid == 1)
        {
            eVis = EffectVisualEffect(VFX_IMP_REFLEX_SAVE_THROW_USE);
        }
    }
    else if(nSavingThrow == SAVING_THROW_WILL)
    {
        bValid = WillSave(oTarget, nDC, nSaveType, oSaveVersus);
        if(bValid == 1)
        {
            eVis = EffectVisualEffect(VFX_IMP_WILL_SAVING_THROW_USE);
        }
    }

    nSpellID = PRCGetSpellId(oSaveVersus);

    /*
        return 0 = FAILED SAVE
        return 1 = SAVE SUCCESSFUL
        return 2 = IMMUNE TO WHAT WAS BEING SAVED AGAINST
    */
    if(bValid == 0)
    {
        if((nSaveType == SAVING_THROW_TYPE_DEATH
         || nSpellID == SPELL_WEIRD
         || nSpellID == SPELL_FINGER_OF_DEATH) &&
         nSpellID != SPELL_HORRID_WILTING)
        {
            eVis = EffectVisualEffect(VFX_IMP_DEATH);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        }
    }
    if(bValid == 2)
    {
        eVis = EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE);
    }
    if(bValid == 1 || bValid == 2)
    {
        if(bValid == 2)
        {
            /*
            If the spell is save immune then the link must be applied in order to get the true immunity
            to be resisted.  That is the reason for returing false and not true.  True blocks the
            application of effects.
            */
            bValid = FALSE;
        }
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
    }
    return bValid;
}


void PRCBonusDamage (object oTarget)
{
    object oCaster = OBJECT_SELF;
    int nDice;
    int nDamage;
    effect eDam;
    effect eVis;

    //FloatingTextStringOnCreature("PRC Bonus Damage is called", oCaster, FALSE);

    int iDiabolistLevel = GetLevelByClass(CLASS_TYPE_DIABOLIST, oCaster);
    if (iDiabolistLevel > 0 && GetLocalInt(oCaster, "Diabolism") == TRUE)
    {

        //FloatingTextStringOnCreature("Diabolism is active", oCaster, FALSE);

        nDice = (iDiabolistLevel + 5) / 5;
        nDamage = d6(nDice);

        eVis = EffectVisualEffect(VFX_FNF_LOS_EVIL_10);
        eDam = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);

        if (GetLocalInt(oCaster, "VileDiabolism") == TRUE)
        {
            //FloatingTextStringOnCreature("Vile Diabolism is active", oCaster, FALSE);
            nDamage /= 2;
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_POSITIVE);
            SetLocalInt(oCaster, "VileDiabolism", FALSE);
        }

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        DelayCommand(3.0, SetLocalInt(oCaster, "Diabolism", FALSE));
    }

    if (GetLevelByClass(CLASS_TYPE_BLOOD_MAGUS, oCaster) > 0 && GetLocalInt(oCaster, "BloodSeeking") == TRUE)
    {
        nDamage = d6();
        eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
        eVis = EffectVisualEffect(VFX_IMP_DEATH_L);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

        effect eSelfDamage = EffectDamage(3, DAMAGE_TYPE_MAGICAL);
        // To make sure it doesn't cause a conc check
        DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSelfDamage, oCaster));
    }
}

//  Bonus damage to a spell for Spell Betrayal Ability
int SpellBetrayalDamage(object oTarget, object oCaster)
{
     int iDam = 0;
     int ThrallLevel = GetLevelByClass(CLASS_TYPE_THRALL_OF_GRAZZT_A, oCaster) + GetLevelByClass(CLASS_TYPE_THRALL_OF_GRAZZT_D, oCaster);
     string sMes = "";

     if(ThrallLevel >= 2)
     {
          if( GetIsDeniedDexBonusToAC(oTarget, oCaster, TRUE) )
          {
               ThrallLevel /= 2;
               iDam = d6(ThrallLevel);
          }
     }

     return iDam;
}

//  Bonus damage to a spell for Spellstrike Ability
int SpellStrikeDamage(object oTarget, object oCaster)
{
     int iDam = 0;
     int ThrallLevel = GetLevelByClass(CLASS_TYPE_THRALL_OF_GRAZZT_A, oCaster) + GetLevelByClass(CLASS_TYPE_THRALL_OF_GRAZZT_D, oCaster);

     if(ThrallLevel >= 6)
     {
          if( GetIsAOEFlanked(oTarget, oCaster) )
          {
               ThrallLevel /= 4;
               iDam = d6(ThrallLevel);
          }
     }

     return iDam;
}

//  Adds the bonus damage from both Spell Betrayal and Spellstrike together
int ApplySpellBetrayalStrikeDamage(object oTarget, object oCaster, int bShowTextString = TRUE)
{
     int iDam = 0;
     int iBetrayalDam = SpellBetrayalDamage(oTarget, oCaster);
     int iStrikeDam = SpellStrikeDamage(oTarget, oCaster);
     string sMes = "";

     if(iStrikeDam > 0 && iBetrayalDam > 0)  sMes ="*Spellstrike Betrayal Sucess*";
     else if(iBetrayalDam > 0)               sMes ="*Spell Betrayal Sucess*";
     else if(iStrikeDam > 0)                 sMes ="*Spellstrike Sucess*";

     if(bShowTextString)      FloatingTextStringOnCreature(sMes, oCaster, TRUE);

     iDam = iBetrayalDam + iStrikeDam;

     // debug code
     //sMes = "Spell Betrayal / Spellstrike Bonus Damage: " + IntToString(iBetrayalDam) + " + " + IntToString(iStrikeDam) + " = " + IntToString(iDam);
     //DelayCommand( 1.0, FloatingTextStringOnCreature(sMes, oCaster, TRUE) );

     return iDam;
}


int PRCMySavingThrow(int nSavingThrow, object oTarget, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus = OBJECT_SELF, float fDelay = 0.0)
{
    int nSpell = PRCGetSpellId(oSaveVersus);

    // Iron Mind's Mind Over Body, allows them to treat other saves as will saves up to 3/day.
    // No point in having it trigger when its a will save.
    if (nSavingThrow != SAVING_THROW_WILL && GetLocalInt(oTarget, "IronMind_MindOverBody"))
    {
        nSavingThrow = SAVING_THROW_WILL;
        DeleteLocalInt(oTarget, "IronMind_MindOverBody");
    }

    // Handle the target having Force of Will and being targeted by a psionic power
    if(nSavingThrow != SAVING_THROW_WILL        &&
       ((nSpell > 14000 && nSpell < 14360) ||
        (nSpell > 15350 && nSpell < 15470)
        )                                       &&
       GetHasFeat(FEAT_FORCE_OF_WILL, oTarget)  &&
       !GetLocalInt(oTarget, "ForceOfWillUsed") &&
       // Only use will save if it's better
       ((nSavingThrow == SAVING_THROW_FORT ? GetFortitudeSavingThrow(oTarget) : GetReflexSavingThrow(oTarget)) > GetWillSavingThrow(oTarget))
       )
    {
        nSavingThrow = SAVING_THROW_WILL;
        SetLocalInt(oTarget, "ForceOfWillUsed", TRUE);
        DelayCommand(6.0f, DeleteLocalInt(oTarget, "ForceOfWillUsed"));
        // "Force of Will used for this round."
        FloatingTextStrRefOnCreature(16826670, oTarget, FALSE);
    }

    //Thayan Knights auto-fail mind spells cast by red wizards
    if( nSaveType == SAVING_THROW_TYPE_MIND_SPELLS
        && GetLevelByClass(CLASS_TYPE_RED_WIZARD, oSaveVersus) > 0
        && GetLevelByClass(CLASS_TYPE_THAYAN_KNIGHT, oTarget) > 0
        )
    {
        return 0;
    }

    // Hexblade gets a bonus against spells equal to his Charisma (Min +1)
    int nHex = GetLevelByClass(CLASS_TYPE_HEXBLADE, oTarget);
    if (nHex > 0)
    {
        int nHexCha = GetAbilityModifier(ABILITY_CHARISMA, oTarget);
        if (nHexCha < 1) nHexCha = 1;
        nDC -= nHexCha;
    }

    //Diamond Defense
    if(GetLocalInt(oTarget, "PRC_TOB_DIAMOND_DEFENSE"))
    {
            int nBonus = GetLocalInt(oTarget, "PRC_TOB_DIAMOND_DEFENSE");
            nDC -= nBonus;
    }

    // Master of Nine
    if (GetLevelByClass(CLASS_TYPE_MASTER_OF_NINE, oSaveVersus) >= 3)
    {
        int nLastClass = GetLastSpellCastClass();
        if (nLastClass == CLASS_TYPE_WARBLADE ||
            nLastClass == CLASS_TYPE_SWORDSAGE ||
            nLastClass == CLASS_TYPE_CRUSADER)
        {
            // Increases maneuver DCs by 1
            nDC += 1;
        }
    }

    // This is done here because it is possible to tell the saving throw type here
    // Tyranny Domain increases the DC of mind spells by +2.
    if(nSaveType == SAVING_THROW_TYPE_MIND_SPELLS && GetHasFeat(FEAT_DOMAIN_POWER_TYRANNY, oSaveVersus))
        nDC += 2;
    // +2 bonus on saves against mind affecting, done here
    if(nSaveType == SAVING_THROW_TYPE_MIND_SPELLS && GetLevelByClass(CLASS_TYPE_FIST_DAL_QUOR, oTarget) >= 2)
        nDC -= 2;
    // +4 bonus on saves against negative energy, done here
    if(nSaveType == SAVING_THROW_TYPE_NEGATIVE && GetLevelByClass(CLASS_TYPE_DREAD_NECROMANCER, oTarget) >= 9)
        nDC -= 4;
    // +2 bonus on saves against poison and disease energy, done here
    if((nSaveType == SAVING_THROW_TYPE_DISEASE || nSaveType == SAVING_THROW_TYPE_POISON)
        && GetLevelByClass(CLASS_TYPE_DREAD_NECROMANCER, oTarget) >= 4)
        nDC -= 2;
    // +2 bonus on saves against poison and disease energy, done here
    // The doubling is correct, the bonus incresae at this level
    if((nSaveType == SAVING_THROW_TYPE_DISEASE || nSaveType == SAVING_THROW_TYPE_POISON)
        && GetLevelByClass(CLASS_TYPE_DREAD_NECROMANCER, oTarget) >= 14)
        nDC -= 2;
    // Scorpion's Resolve gives a +4 bonus on mind affecting saves
    if(nSaveType == SAVING_THROW_TYPE_MIND_SPELLS && GetHasFeat(FEAT_SCORPIONS_RESOLVE, oSaveVersus))
        nDC -= 4;
    // Jergal's Pact gives a +2 bonus on negative energy saves
    if(nSaveType == SAVING_THROW_TYPE_NEGATIVE && GetHasFeat(FEAT_JERGALS_PACT, oSaveVersus))
        nDC -= 2;
    // Bloodline of Fire gives a +4 bonus on fire saves
    if(nSaveType == SAVING_THROW_TYPE_FIRE && GetHasFeat(FEAT_BLOODLINE_OF_FIRE, oSaveVersus))
        nDC -= 4;
    // Plague Resistant gives a +4 bonus on disease saves
    if(nSaveType == SAVING_THROW_TYPE_DISEASE && GetHasFeat(FEAT_PLAGUE_RESISTANT, oSaveVersus))
        nDC -= 4;
    // Piercing Sight gives a +4 bonus on illusion saves
    if(GetSpellSchool(nSpell) == SPELL_SCHOOL_ILLUSION && GetHasFeat(FEAT_PIERCING_SIGHT, oSaveVersus))
        nDC -= 4;

    //racial pack code
    //this works by lowering the DC rather than adding to the save
    //same net effect but slightly different numbers
    if(nSaveType == SAVING_THROW_TYPE_FIRE && GetHasFeat(FEAT_HARD_FIRE, oTarget))
        nDC -= 1 + (GetHitDice(oTarget) / 5);
    else if(nSaveType == SAVING_THROW_TYPE_COLD && GetHasFeat(FEAT_HARD_WATER, oTarget))
        nDC -= 1 + (GetHitDice(oTarget) / 5);
    else if(nSaveType == SAVING_THROW_TYPE_ELECTRICITY)
    {
        if(GetHasFeat(FEAT_HARD_AIR, oTarget))
            nDC -= 1 + (GetHitDice(oTarget) / 5);
        else if(GetHasFeat(FEAT_HARD_ELEC, oTarget))
            nDC -= 2;
    }
    else if(nSaveType == SAVING_THROW_TYPE_POISON && GetHasFeat(FEAT_POISON_3, oTarget))
        nDC -= 3;
    else if(nSaveType == SAVING_THROW_TYPE_ACID && GetHasFeat(FEAT_HARD_EARTH, oTarget))
        nDC -= 1 + (GetHitDice(oTarget) / 5);

    //Psionic race save boosts - +2 vs fire for Halfgiant, +1 vs all spells for Xeph
    if(nSaveType == SAVING_THROW_TYPE_FIRE && GetHasFeat(FEAT_ACCLIMATED_FIRE, oTarget))
        nDC -= 2;
    if(GetHasFeat(FEAT_XEPH_SPELLHARD, oTarget))
        nDC -= 1;

    // Necrotic Cyst penalty on Necromancy spells
    if(GetPersistantLocalInt(oTarget, NECROTIC_CYST_MARKER) && (GetSpellSchool(nSpell) == SPELL_SCHOOL_NECROMANCY))
        nDC += 2;

    // Apostate - 1/2 HD bonus to resist divine spells
    if(GetHasFeat(FEAT_APOSTATE, oTarget))
    {
            //if divine
            if(GetIsDivineClass(PRCGetLastSpellCastClass(), oSaveVersus))
            {
                    //GetHD
                    int nBonus = GetHitDice(oSaveVersus) / 2;
                    nDC -= nBonus;
            }
    }

    // This Maneuver allows people to use a skill check instead of a save on a Will save
    if (nSavingThrow == SAVING_THROW_WILL && GetLocalInt(oTarget, "MomentOfPerfectMind"))
    {
        return GetIsSkillSuccessful(oTarget, SKILL_CONCENTRATION, nDC);
    }

    // This Maneuver allows people to use a skill check instead of a save on a Fort save
    if (nSavingThrow == SAVING_THROW_FORT && GetLocalInt(oTarget, "MindOverBody"))
    {
        return GetIsSkillSuccessful(oTarget, SKILL_CONCENTRATION, nDC);
    }

    // This Maneuver allows people to use a skill check instead of a save on a Reflex save
    if (nSavingThrow == SAVING_THROW_REFLEX && GetLocalInt(oTarget, "ActionBeforeThought"))
    {
        return GetIsSkillSuccessful(oTarget, SKILL_CONCENTRATION, nDC);
    }

    int nSaveRoll = BWSavingThrow(nSavingThrow, oTarget, nDC, nSaveType, oSaveVersus, fDelay);

    // Second Chance power reroll
    if(nSaveRoll == 0                                        &&     // Failed the save
       GetLocalInt(oTarget, "PRC_Power_SecondChance_Active") &&     // Second chance is active
       !GetLocalInt(oTarget, "PRC_Power_SecondChance_UserForRound") // And hasn't yet been used for this round
       )
    {
        // Reroll
        nSaveRoll = BWSavingThrow(nSavingThrow, oTarget, nDC, nSaveType, oSaveVersus, fDelay);

        // Can't use this ability again for a round
        SetLocalInt(oTarget, "PRC_Power_SecondChance_UserForRound", TRUE);
        DelayCommand(6.0f, DeleteLocalInt(oTarget, "PRC_Power_SecondChance_UserForRound"));
    }

    // Zealous Surge Reroll
    if(nSaveRoll == 0 &&     // Failed the save
       GetLocalInt(oTarget, "ZealousSurge"))
    {
        // Reroll
        nSaveRoll = BWSavingThrow(nSavingThrow, oTarget, nDC, nSaveType, oSaveVersus, fDelay);

        // Ability Used
    DeleteLocalInt(oTarget, "ZealousSurge");
    }

    // Call To Battle Reroll
    if(nSaveRoll == 0 &&     // Failed the save
       GetLocalInt(oTarget, "CallToBattle") &&
       nSaveType == SAVING_THROW_TYPE_FEAR)
    {
        // Reroll
        nSaveRoll = BWSavingThrow(nSavingThrow, oTarget, nDC, nSaveType, oSaveVersus, fDelay);

        // Ability Used
    DeleteLocalInt(oTarget, "CallToBattle");
    }

    // Iron Mind Barbed Mind ability
    if(GetLevelByClass(CLASS_TYPE_IRONMIND, oTarget) >= 10)
    {
        // Only works on Mind Spells and in Heavy Armour
        object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oTarget);
        if(nSaveType == SAVING_THROW_TYPE_MIND_SPELLS && GetBaseAC(oItem) >= 6)
        {
            // Spell/Power caster takes 1d6 damage and 1 Wisdom damage
            effect eDam = EffectDamage(d6(), DAMAGE_TYPE_MAGICAL);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oSaveVersus);
            ApplyAbilityDamage(oSaveVersus, ABILITY_WISDOM, 1, DURATION_TYPE_TEMPORARY, TRUE, -1.0);
        }
    }

    // Impetuous Endurance
    if(nSaveRoll == 0 && GetLevelByClass(CLASS_TYPE_KNIGHT, oTarget) >= 17)
    {
    // Reroll
        nSaveRoll = BWSavingThrow(nSavingThrow, oTarget, nDC, nSaveType, oSaveVersus, fDelay);
    }

    // Bond Of Loyalty
    if(GetLocalInt(oTarget, "BondOfLoyalty"))
    {
        // Only works on Mind Spells
        if(nSaveType == SAVING_THROW_TYPE_MIND_SPELLS)
        {
            // Reroll
            nSaveRoll = BWSavingThrow(nSavingThrow, oTarget, nDC, nSaveType, oSaveVersus, fDelay);

            // Ability Used
        DeleteLocalInt(oTarget, "BondOfLoyalty");
        }
    }
    // Dive for Cover reroll
    if(GetHasFeat(FEAT_DIVE_FOR_COVER, oTarget))
    {
            if(nSaveRoll == 0 && nSavingThrow == SAVING_THROW_REFLEX)
            {
                    // Reroll
                    nSaveRoll = BWSavingThrow(nSavingThrow, oTarget, nDC, nSaveType, oSaveVersus, fDelay);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oTarget, 6.0);
            }
    }

    return nSaveRoll;
}


int PRCGetReflexAdjustedDamage(int nDamage, object oTarget, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus=OBJECT_SELF)
{
    int nSpell = PRCGetSpellId(oSaveVersus);
    int nOriginalDamage = nDamage;

     // Iron Mind's Mind Over Body, allows them to treat other saves as will saves up to 3/day.
     // For this, it lowers the DC by the difference between the Iron Mind's will save and its reflex save.
     if (GetLocalInt(oTarget, "IronMind_MindOverBody"))
     {
        int nWill = GetWillSavingThrow(oTarget);
        int nRef = GetReflexSavingThrow(oTarget);
        int nSaveBoost = nWill - nRef;
        // Makes sure it does nothing if bonus would be less than 0
        if (nSaveBoost < 0) nSaveBoost = 0;
        // Lower the save the appropriate amount.
        nDC -= nSaveBoost;
        DeleteLocalInt(oTarget, "IronMind_MindOverBody");
     }

       //check if Unsettling Enchantment applies
       if(GetHasFeat(FEAT_UNSETTLING_ENCHANTMENT, oSaveVersus) && GetSpellSchool(PRCGetSpellId()) == SPELL_SCHOOL_ENCHANTMENT && !GetIsImmune(oTarget, IMMUNITY_TYPE_MIND_SPELLS))
       {
                effect eLink = EffectLinkEffects(EffectACDecrease(2), EffectAttackDecrease(2));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, 6.0);
       }

    // Bloodline of Fire gives a +4 bonus on fire saves
    if(nSaveType == SAVING_THROW_TYPE_FIRE && GetHasFeat(FEAT_BLOODLINE_OF_FIRE, oSaveVersus))
        nDC -= 4;

    // Racial ability adjustments
    if(nSaveType == SAVING_THROW_TYPE_FIRE && GetHasFeat(FEAT_HARD_FIRE, oTarget))
        nDC -= 1 + (GetHitDice(oTarget) / 5);
    else if(nSaveType == SAVING_THROW_TYPE_COLD && GetHasFeat(FEAT_HARD_WATER, oTarget))
        nDC -= 1 + (GetHitDice(oTarget) / 5);
    else if(nSaveType == SAVING_THROW_TYPE_SONIC && GetHasFeat(FEAT_HARD_AIR, oTarget))
        nDC -= 1 + (GetHitDice(oTarget) / 5);
    else if(nSaveType == SAVING_THROW_TYPE_ELECTRICITY)
    {
        if(GetHasFeat(FEAT_HARD_AIR, oTarget))
            nDC -= 1 + (GetHitDice(oTarget) / 5);
        else if(GetHasFeat(FEAT_HARD_ELEC, oTarget))
            nDC -= 2;
    }
    else if(nSaveType == SAVING_THROW_TYPE_POISON && GetHasFeat(FEAT_POISON_4, oTarget))
        nDC -= 4;
    else if(nSaveType == SAVING_THROW_TYPE_POISON && GetHasFeat(FEAT_POISON_3, oTarget))
        nDC -= 3;
    else if(nSaveType == SAVING_THROW_TYPE_ACID && GetHasFeat(FEAT_HARD_EARTH, oTarget))
        nDC -= 1+(GetHitDice(oTarget)/5);

    //Diamond Defense
    if(GetLocalInt(oTarget, "PRC_TOB_DIAMOND_DEFENSE"))
    {
            int nBonus = GetLocalInt(oTarget, "PRC_TOB_DIAMOND_DEFENSE");
            nDC -= nBonus;
    }

    //Insightful Divination
    if(GetLocalInt(oTarget, "Insightful Divination"))
    {
            int nBonus = GetLocalInt(oTarget, "Insightful Divination");
            DeleteLocalInt(oTarget, "Insightful Divination");
            nDC -= nBonus;
    }

    // Apostate - 1/2 HD bonus to resist divine spells
        if(GetHasFeat(FEAT_APOSTATE, oTarget))
        {
                //if divine
                if(GetIsDivineClass(PRCGetLastSpellCastClass(), oSaveVersus))
                {
                        //GetHD
                        int nBonus = GetHitDice(oSaveVersus) / 2;
                        nDC -= nBonus;
                }
    }

    // This ability removes evasion from the target
    if (GetLocalInt(oTarget, "TrueConfoundingResistance"))
    {
        // return the damage cut in half
        if (PRCMySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC, nSaveType, oSaveVersus))
        {
            return nDamage / 2;
        }

        return nDamage;
    }
    // This Maneuver allows people to use a skill check instead of a save on a Reflex save
    if (GetLocalInt(oTarget, "ActionBeforeThought"))
    {
        // return the damage cut in half
        if (GetIsSkillSuccessful(oTarget, SKILL_CONCENTRATION, nDC))
        {
            return nDamage / 2;
        }

        return nDamage;
    }

    // Do save
    nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, nSaveType, oSaveVersus);

    // Second Chance power reroll
    if(nDamage == nOriginalDamage                            &&     // Failed the save
       GetLocalInt(oTarget, "PRC_Power_SecondChance_Active") &&     // Second chance is active
       !GetLocalInt(oTarget, "PRC_Power_SecondChance_UserForRound") // And hasn't yet been used for this round
       )
    {
        // Reroll
        nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, nSaveType, oSaveVersus);

        // Can't use this ability again for a round
        SetLocalInt(oTarget, "PRC_Power_SecondChance_UserForRound", TRUE);
        DelayCommand(6.0f, DeleteLocalInt(oTarget, "PRC_Power_SecondChance_UserForRound"));
    }
    // Zealous Surge Reroll
    if(nDamage == nOriginalDamage  &&     // Failed the save
       GetLocalInt(oTarget, "ZealousSurge"))
    {
        // Reroll
        nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, nSaveType, oSaveVersus);

        // Ability Used
    DeleteLocalInt(oTarget, "ZealousSurge");
    }
    // Dive for Cover reroll
    if(GetHasFeat(FEAT_DIVE_FOR_COVER, oTarget))
    {
            if(nDamage == nOriginalDamage)
            {
                    // Reroll
                    nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, nSaveType, oSaveVersus);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oTarget, 6.0);
            }
    }

    return nDamage;
}

// function for internal use in GetCasterLvl

// caster level for divine base classes (with practiced spellcaster feats)
int GetCasterLvlDivine(int iClassType, object oCaster)
{
    if (GetPrimaryDivineClass(oCaster) == iClassType)
        return GetLevelByTypeDivine(oCaster);

    int iTemp = GetLevelByClass(iClassType, oCaster);
    iTemp += PracticedSpellcasting(oCaster, iClassType, iTemp);
    return iTemp;
}

// caster level for arcane base classes (with practiced spellcaster feats)
int GetCasterLvlArcane(int iClassType, object oCaster)
{
    if (GetPrimaryArcaneClass(oCaster) == iClassType)
        return GetLevelByTypeArcane(oCaster);

    int iTemp = GetLevelByClass(iClassType, oCaster);
    iTemp += PracticedSpellcasting(oCaster, iClassType, iTemp);
    return iTemp;
}

// caster level for classes with half progression
int GetCasterLvlDivineSemi(int iClassType, object oCaster)
{
    if (GetPrimaryDivineClass(oCaster) == iClassType)
        return GetLevelByTypeDivine(oCaster);
    else
        return GetLevelByClass(iClassType, oCaster) / 2;
}

// caster level for classes with half progression
int GetCasterLvlArcaneSemi(int iClassType, object oCaster)
{
    if (GetPrimaryArcaneClass(oCaster) == iClassType)
        return GetLevelByTypeArcane(oCaster);
    else
        return GetLevelByClass(iClassType, oCaster) / 2;
}

// caster level for classes with full progression
int GetCasterLvlArcaneFull(int iClassType, object oCaster)
{
    if (GetPrimaryArcaneClass(oCaster) == iClassType)
        return GetLevelByTypeArcane(oCaster);
    else
        return GetLevelByClass(iClassType, oCaster);
}

// caster level for classes with full progression
int GetCasterLvlDivineFull(int iClassType, object oCaster)
{
    if (GetPrimaryDivineClass(oCaster) == iClassType)
        return GetLevelByTypeDivine(oCaster);
    else
        return GetLevelByClass(iClassType, oCaster);
}

int GetCasterLvl(int iTypeSpell, object oCaster = OBJECT_SELF)
{
/*
    int iWiz = GetLevelByClass(CLASS_TYPE_WIZARD, oCaster);
    int iBrd = GetLevelByClass(CLASS_TYPE_BARD, oCaster);
    int iCle = GetLevelByClass(CLASS_TYPE_CLERIC, oCaster);
    int iDru = GetLevelByClass(CLASS_TYPE_DRUID, oCaster);
    int iPal = GetLevelByClass(CLASS_TYPE_PALADIN, oCaster);
    int iRan = GetLevelByClass(CLASS_TYPE_RANGER, oCaster);
    int iAss = GetLevelByClass(CLASS_TYPE_ASSASSIN, oCaster);
    int iFav = GetLevelByClass(CLASS_TYPE_FAVOURED_SOUL, oCaster);
    int iSue = GetLevelByClass(CLASS_TYPE_SUEL_ARCHANAMACH, oCaster);
    int iHex = GetLevelByClass(CLASS_TYPE_HEXBLADE, oCaster);
    int iDsk = GetLevelByClass(CLASS_TYPE_DUSKBLADE, oCaster);
    int iSoh = GetLevelByClass(CLASS_TYPE_SOHEI, oCaster);
    int iHlr = GetLevelByClass(CLASS_TYPE_HEALER, oCaster);
    int iSod = GetLevelByClass(CLASS_TYPE_SLAYER_OF_DOMIEL, oCaster);
    int iSha = GetLevelByClass(CLASS_TYPE_SHADOWLORD, oCaster);
    int iBlk = GetLevelByClass(CLASS_TYPE_BLACKGUARD, oCaster);
    int iVob = GetLevelByClass(CLASS_TYPE_VASSAL, oCaster);
    int iSol = GetLevelByClass(CLASS_TYPE_SOLDIER_OF_LIGHT, oCaster);
    int iKMc = GetLevelByClass(CLASS_TYPE_KNIGHT_MIDDLECIRCLE, oCaster);
    int iKCh = GetLevelByClass(CLASS_TYPE_KNIGHT_CHALICE, oCaster);
    int iVig = GetLevelByClass(CLASS_TYPE_VIGILANT, oCaster);
    int iAPl = GetLevelByClass(CLASS_TYPE_ANTI_PALADIN, oCaster);
    int iOcu = GetLevelByClass(CLASS_TYPE_OCULAR, oCaster);
    int iArc = GetLevelByTypeArcane(oCaster);
    int iDiv = GetLevelByTypeDivine(oCaster);
    int iSor = GetLevelByClass(CLASS_TYPE_SORCERER, oCaster);

    //Rakshasa include outsider HD as sorc
    if(!iSor && GetRacialType(oCaster) == RACIAL_TYPE_RAKSHASA)
        iSor = GetLevelByClass(CLASS_TYPE_OUTSIDER, oCaster);
*/

    int iTemp;
    switch (iTypeSpell)
    {
        case TYPE_ARCANE:
            return GetLevelByTypeArcane(oCaster);

        case TYPE_DIVINE:
            return GetLevelByTypeDivine(oCaster);

        case CLASS_TYPE_SORCERER:
        {
            if (GetPrimaryArcaneClass(oCaster) == CLASS_TYPE_SORCERER)
                return GetLevelByTypeArcane(oCaster);

            iTemp = GetLevelByClass(CLASS_TYPE_SORCERER, oCaster);

            //Rakshasa include outsider HD as sorc
            // motu99: shouldn't we add this to the sorc levels? Not sure, so left it the way it was
            if(!iTemp && GetRacialType(oCaster) == RACIAL_TYPE_RAKSHASA)
                iTemp = GetLevelByClass(CLASS_TYPE_OUTSIDER, oCaster);

            //Drider include aberration HD as sorc
            // fox: handled same way as rak, if rak needs changing this does too
            if(!iTemp && GetRacialType(oCaster) == RACIAL_TYPE_DRIDER)
                iTemp = GetLevelByClass(CLASS_TYPE_ABERRATION, oCaster);

            //Bozak include dragon HD as sorc
            // fox: handled same way as rak, if rak needs changing this does too
            if(!iTemp && GetRacialType(oCaster) == RACIAL_TYPE_BOZAK)
                iTemp = GetLevelByClass(CLASS_TYPE_DRAGON, oCaster);

            iTemp += PracticedSpellcasting(oCaster, CLASS_TYPE_SORCERER, iTemp);
            iTemp += DraconicPower(oCaster);
            return iTemp;
        }

        case CLASS_TYPE_WIZARD:
            return GetCasterLvlArcane(CLASS_TYPE_WIZARD, oCaster);

        case CLASS_TYPE_BARD:
            return GetCasterLvlArcane(CLASS_TYPE_BARD, oCaster);

        case CLASS_TYPE_CLERIC:
            return GetCasterLvlDivine(CLASS_TYPE_CLERIC, oCaster);

        case CLASS_TYPE_DRUID:
            return GetCasterLvlDivine(CLASS_TYPE_DRUID, oCaster);

        case CLASS_TYPE_RANGER:
            return GetCasterLvlDivineSemi(CLASS_TYPE_RANGER, oCaster);

        case CLASS_TYPE_PALADIN:
            return GetCasterLvlDivineSemi(CLASS_TYPE_PALADIN, oCaster);

        //new spellbook classes
        case CLASS_TYPE_SHADOWLORD:
            return GetCasterLvlArcaneFull(CLASS_TYPE_SHADOWLORD, oCaster);

        case CLASS_TYPE_ASSASSIN:
            return GetCasterLvlArcaneFull(CLASS_TYPE_ASSASSIN, oCaster);

        case CLASS_TYPE_SUEL_ARCHANAMACH:
            return GetCasterLvlArcaneFull(CLASS_TYPE_SUEL_ARCHANAMACH, oCaster);

        case CLASS_TYPE_HEXBLADE:
            return GetCasterLvlArcaneSemi(CLASS_TYPE_HEXBLADE, oCaster);

        case CLASS_TYPE_DUSKBLADE:
            return GetCasterLvlArcaneFull(CLASS_TYPE_DUSKBLADE, oCaster);

        case CLASS_TYPE_WARMAGE:
            return GetCasterLvlArcaneFull(CLASS_TYPE_WARMAGE, oCaster);

        case CLASS_TYPE_DREAD_NECROMANCER:
            return GetCasterLvlArcaneFull(CLASS_TYPE_DREAD_NECROMANCER, oCaster);

        case CLASS_TYPE_FAVOURED_SOUL:
            return GetCasterLvlDivineFull(CLASS_TYPE_FAVOURED_SOUL, oCaster);

        case CLASS_TYPE_SOHEI:
            return GetCasterLvlDivineSemi(CLASS_TYPE_SOHEI, oCaster);

        case CLASS_TYPE_MYSTIC:
            return GetCasterLvlDivineFull(CLASS_TYPE_MYSTIC, oCaster);

        case CLASS_TYPE_HEALER:
            return GetCasterLvlDivineFull(CLASS_TYPE_HEALER, oCaster);

        case CLASS_TYPE_SHAMAN:
            return GetCasterLvlDivineFull(CLASS_TYPE_SHAMAN, oCaster);

        case CLASS_TYPE_SLAYER_OF_DOMIEL:
            return GetCasterLvlDivineFull(CLASS_TYPE_SLAYER_OF_DOMIEL, oCaster);

        case CLASS_TYPE_BLACKGUARD:
            return GetCasterLvlDivineFull(CLASS_TYPE_BLACKGUARD, oCaster);

        case CLASS_TYPE_VASSAL:
            return GetCasterLvlDivineFull(CLASS_TYPE_VASSAL, oCaster);

        case CLASS_TYPE_SOLDIER_OF_LIGHT:
            return GetCasterLvlDivineFull(CLASS_TYPE_SOLDIER_OF_LIGHT, oCaster);

        case CLASS_TYPE_KNIGHT_MIDDLECIRCLE:
            return GetCasterLvlDivineFull(CLASS_TYPE_KNIGHT_MIDDLECIRCLE, oCaster);

        case CLASS_TYPE_KNIGHT_CHALICE:
            return GetCasterLvlDivineFull(CLASS_TYPE_KNIGHT_CHALICE, oCaster);

        case CLASS_TYPE_VIGILANT:
            return GetCasterLvlDivineFull(CLASS_TYPE_VIGILANT, oCaster);

        case CLASS_TYPE_ANTI_PALADIN:
            return GetCasterLvlDivineSemi(CLASS_TYPE_ANTI_PALADIN, oCaster);

        case CLASS_TYPE_OCULAR:
            return GetCasterLvlDivineFull(CLASS_TYPE_OCULAR, oCaster);

        case CLASS_TYPE_WITCH:
            return GetCasterLvlArcaneFull(CLASS_TYPE_WITCH, oCaster);

        case CLASS_TYPE_BEGUILER:
            return GetCasterLvlArcaneFull(CLASS_TYPE_BEGUILER, oCaster);


        case CLASS_TYPE_ARCHIVIST:
            return GetCasterLvlDivineFull(CLASS_TYPE_ARCHIVIST, oCaster);

        case CLASS_TYPE_TEMPLAR:
            return GetCasterLvlDivineFull(CLASS_TYPE_TEMPLAR, oCaster);

        default:
            break;
    }
    return 0;
}






////////////////Begin Spellsword//////////////////

void SetAllAoEInts(int SpellID, object oAoE, int nBaseSaveDC ,int SpecDispel = 0 , int nCasterLevel = 0)
{
    if(GetLocalInt(oAoE, "X2_AoE_Is_Modified") != 1)
    {

       // I keep making calls to GetAreaOfEffectCreator()
       // I'm not sure if it would be better to just set it one time as an object variable
       // It would certainly be better in terms of number of operations, but I'm not sure
       // if it's as accurate.
       // It's a total of 7 calls, so I figure it doesn't matter that much.  Still, 1 would be better than 7.
       // Also: the 7 calls only happen once per casting of the AoE.
       if ( !nCasterLevel) nCasterLevel = PRCGetCasterLevel(GetAreaOfEffectCreator());

       SetLocalInt(oAoE, "X2_AoE_Caster_Level", nCasterLevel);
       SetLocalInt(oAoE, "X2_AoE_SpellID", SpellID);
       SetLocalInt(oAoE, "X2_AoE_Weave", GetHasFeat(FEAT_SHADOWWEAVE, GetAreaOfEffectCreator()));
       if (SpecDispel) SetLocalInt(oAoE, "X2_AoE_SpecDispel", SpecDispel);
       SetLocalInt(oAoE, "X2_AoE_Is_Modified", 1);
       SetLocalInt(oAoE, "X2_AoE_BaseSaveDC", nBaseSaveDC);
    }

}

//GetNextObjectInShape wrapper for changing the AOE of the channeled spells
object MyNextObjectInShape(int nShape,
                           float fSize, location lTarget,
                           int bLineOfSight = FALSE,
                           int nObjectFilter = OBJECT_TYPE_CREATURE,
                           vector vOrigin=[0.0, 0.0, 0.0])
{
    // War Wizard of Cormyr's Widen Spell ability
    if (DEBUG) DoDebug("Value for WarWizardOfCormyr_Widen: " + IntToString(GetLocalInt(OBJECT_SELF, "WarWizardOfCormyr_Widen")));
    if (DEBUG) DoDebug("Original Spell Size: " + FloatToString(fSize));
    if (GetLocalInt(OBJECT_SELF, "WarWizardOfCormyr_Widen"))
    {
        // At level 5 its 100% area increase
        if (GetLevelByClass(CLASS_TYPE_WAR_WIZARD_OF_CORMYR, OBJECT_SELF) >= 5) fSize *= 2;
        // At level 3 its 50% area increase
        else if (GetLevelByClass(CLASS_TYPE_WAR_WIZARD_OF_CORMYR, OBJECT_SELF) >= 3) fSize *= 1.5;
        if (DEBUG) DoDebug("Widened Spell Size: " + FloatToString(fSize));
        // This allows it to affect the entire casting
        DelayCommand(1.0, DeleteLocalInt(OBJECT_SELF, "WarWizardOfCormyr_Widen"));
    }
    else if (GetLocalInt(OBJECT_SELF, "SuddenMetaWiden"))
    {
        fSize *= 2;
        if (DEBUG) DoDebug("Sudden Widened Spell Size: " + FloatToString(fSize));
        // This allows it to affect the entire casting
        DelayCommand(1.0, DeleteLocalInt(OBJECT_SELF, "SuddenMetaWiden"));
    }

    int nChannel = GetLocalInt(OBJECT_SELF,"spellswd_aoe");
    if(nChannel != 1)
    {
        return GetNextObjectInShape(nShape,fSize,lTarget,bLineOfSight,nObjectFilter,vOrigin);
    }
    else
    {
        return OBJECT_INVALID;
    }
}


//GetFirstObjectInShape wrapper for changing the AOE of the channeled spells
object MyFirstObjectInShape(int nShape,
                            float fSize,
                            location lTarget,
                            int bLineOfSight = FALSE,
                            int nObjectFilter = OBJECT_TYPE_CREATURE,
                            vector vOrigin=[0.0, 0.0, 0.0])
{
    object oCaster = OBJECT_SELF;

    //int on caster for the benefit of spellfire wielder resistance
    // string sName = "IsAOE_" + IntToString(GetSpellId());
    string sName = "IsAOE_" + IntToString(PRCGetSpellId(oCaster));

    SetLocalInt(oCaster, sName, 1);
    DelayCommand(0.1, DeleteLocalInt(oCaster, sName));

    // War Wizard of Cormyr's Widen Spell ability
    if (DEBUG) DoDebug("Value for WarWizardOfCormyr_Widen: " + IntToString(GetLocalInt(oCaster, "WarWizardOfCormyr_Widen")));
    if (DEBUG) DoDebug("Original Spell Size: " + FloatToString(fSize));
    if (GetLocalInt(oCaster, "WarWizardOfCormyr_Widen"))
    {
        // At level 5 its 100% area increase
        if (GetLevelByClass(CLASS_TYPE_WAR_WIZARD_OF_CORMYR, oCaster) >= 5) fSize *= 2;
        // At level 3 its 50% area increase
        else if (GetLevelByClass(CLASS_TYPE_WAR_WIZARD_OF_CORMYR, oCaster) >= 3) fSize *= 1.5;
        if (DEBUG) DoDebug("Widened Spell Size: " + FloatToString(fSize));
        // This allows it to affect the entire casting
        DelayCommand(1.0, DeleteLocalInt(oCaster, "WarWizardOfCormyr_Widen"));
    }
    else if (GetLocalInt(OBJECT_SELF, "SuddenMetaWiden"))
    {
        fSize *= 2;
        if (DEBUG) DoDebug("Sudden Widened Spell Size: " + FloatToString(fSize));
        // This allows it to affect the entire casting
        DelayCommand(1.0, DeleteLocalInt(OBJECT_SELF, "SuddenMetaWiden"));
    }

    int nChannel = GetLocalInt(oCaster,"spellswd_aoe");
    if(nChannel != 1)
    {
        return GetFirstObjectInShape(nShape,fSize,lTarget,bLineOfSight,nObjectFilter,vOrigin);
    }
    else
    {
        return PRCGetSpellTargetObject(oCaster);
    }
}


//This checks if the spell is channeled and if there are multiple spells
//channeled, which one is it. Then it checks in either case if the spell
//has the metamagic feat the function gets and returns TRUE or FALSE accordingly
//Also used by the new spellbooks for the same purpose
/* replaced by wrapper for GetMetaMagicFeat instead
   Not necessarily. This may still be a usefule level of abstraction - Ornedan
   */
int CheckMetaMagic(int nMeta,int nMMagic)
{
    return nMeta & nMMagic;
}

int PRCGetMetaMagicFeat(object oCaster = OBJECT_SELF, int bClearSuddenFlags = TRUE)
{

    int nOverride = GetLocalInt(oCaster, PRC_METAMAGIC_OVERRIDE);
    if(nOverride)
    {
        if (DEBUG) DoDebug("PRCGetMetaMagicFeat: found override metamagic = "+IntToString(nOverride)+", original = "+IntToString(GetMetaMagicFeat()));
        return nOverride;
    }

    int nFeat = GetMetaMagicFeat();

    // object oItem = GetSpellCastItem();
    object oItem = PRCGetSpellCastItem(oCaster);
    if(GetIsObjectValid(oItem))
        nFeat = 0;//biobug, this isn't reset to zero by casting from an item

    int nSSFeat = GetLocalInt(oCaster, PRC_METAMAGIC_ADJUSTMENT);
    int nNewSpellMetamagic = GetLocalInt(oCaster, "NewSpellMetamagic");
    if(nNewSpellMetamagic)
        nFeat = nNewSpellMetamagic-1;
    if(nSSFeat)
        nFeat = nSSFeat;

    int nClass = PRCGetLastSpellCastClass(oCaster);

    // Suel Archanamach's Extend spells they cast on themselves.
    // Only works for Suel Spells, and not any other caster type they might have
    // Since this is a spellscript, it assumes OBJECT_SELF is the caster
    if (nClass == CLASS_TYPE_SUEL_ARCHANAMACH && GetLevelByClass(CLASS_TYPE_SUEL_ARCHANAMACH) >= 3)
    {
        // Check that they cast on themselves
        // if (oCaster == PRCGetSpellTargetObject())
        if (oCaster == PRCGetSpellTargetObject(oCaster))
        {
            // Add extend to the metamagic feat using bitwise math
            nFeat |= METAMAGIC_EXTEND;
        }
    }
    // Magical Contraction, Truenaming Utterance
    if (GetLocalInt(oCaster, "TrueMagicalContraction"))
    {
        nFeat |= METAMAGIC_EXTEND;
    }
    // Sudden Metamagic: Empower
    if (GetLocalInt(oCaster, "SuddenMetaEmpower"))
    {
        nFeat |= METAMAGIC_EMPOWER;
        if (bClearSuddenFlags)
            DeleteLocalInt(oCaster, "SuddenMetaEmpower");
    }
    // Sudden Metamagic: Extend
    if (GetLocalInt(oCaster, "SuddenMetaExtend"))
    {
        nFeat |= METAMAGIC_EXTEND;
        if (bClearSuddenFlags)
            DeleteLocalInt(oCaster, "SuddenMetaExtend");
    }
    // Sudden Metamagic: Maximize
    if (GetLocalInt(oCaster, "SuddenMetaMax"))
    {
        nFeat |= METAMAGIC_MAXIMIZE;
        if (bClearSuddenFlags)
            DeleteLocalInt(oCaster, "SuddenMetaMax");
    }

    // we assume that we are casting from an item, if the item is valid and the item belongs to oCaster
    // however, we cannot be sure because of Bioware's inadequate implementation of GetSpellCastItem
    if(GetIsObjectValid(oItem) && GetItemPossessor(oItem) == oCaster)
    {
        // int nSpellId = PRCGetSpellId();
        int nSpellID = PRCGetSpellId(oCaster);

        //check item for metamagic
        int nItemMetaMagic;
        itemproperty ipTest = GetFirstItemProperty(oItem);
        while(GetIsItemPropertyValid(ipTest))
        {
            if(GetItemPropertyType(ipTest) == ITEM_PROPERTY_CAST_SPELL_METAMAGIC)
            {
                int nSubType = GetItemPropertySubType(ipTest);
                nSubType = StringToInt(Get2DACache("iprp_spells", "SpellIndex", nSubType));
                if(nSubType == nSpellID)
                {
                    int nCostValue = GetItemPropertyCostTableValue(ipTest);
                    if(nCostValue == -1 && DEBUG)
                        DoDebug("Problem examining itemproperty");
                    switch(nCostValue)
                    {
                        //bitwise "addition" equivalent to nFeat = (nFeat | nSSFeat)
                        case 0:
                            nItemMetaMagic |= METAMAGIC_NONE;
                            break;
                        case 1:
                            nItemMetaMagic |= METAMAGIC_QUICKEN;
                            break;
                        case 2:
                            nItemMetaMagic |= METAMAGIC_EMPOWER;
                            break;
                        case 3:
                            nItemMetaMagic |= METAMAGIC_EXTEND;
                            break;
                        case 4:
                            nItemMetaMagic |= METAMAGIC_MAXIMIZE;
                            break;
                        case 5:
                            nItemMetaMagic |= METAMAGIC_SILENT;
                            break;
                        case 6:
                            nItemMetaMagic |= METAMAGIC_STILL;
                            break;
                    }
                }
            }
            ipTest = GetNextItemProperty(oItem);
        }
        if (DEBUG) DoDebug("PRCGetMetaMagicFeat: item casting with item = "+GetName(oItem)+", found metamagic = "+IntToString(nItemMetaMagic));
        // we only replace nFeat, if we found something on the item
        if (nItemMetaMagic) nFeat = nItemMetaMagic;
    }
    // if (DEBUG) DoDebug("PRCGetMetaMagicFeat: returning " +IntToString(nFeat));
    return nFeat;
}


//Wrapper for The MaximizeOrEmpower function that checks for metamagic feats
//in channeled spells as well
int PRCMaximizeOrEmpower(int nDice, int nNumberOfDice, int nMeta, int nBonus = 0)
{
    int i = 0;
    int nDamage = 0;
    int nFeat = GetLocalInt(OBJECT_SELF,"PRC_SPELL_METAMAGIC");
    int nDiceDamage;
    for (i=1; i<=nNumberOfDice; i++)
    {
        nDiceDamage = nDiceDamage + Random(nDice) + 1;
    }
    nDamage = nDiceDamage;
    //Resolve metamagic
    if (nMeta & METAMAGIC_MAXIMIZE || nFeat & METAMAGIC_MAXIMIZE)
//    if ((nMeta & METAMAGIC_MAXIMIZE))
    {
        nDamage = nDice * nNumberOfDice;
    }
    if (nMeta & METAMAGIC_EMPOWER || nFeat & METAMAGIC_EMPOWER)
//    else if ((nMeta & METAMAGIC_EMPOWER))
    {
       nDamage = nDamage + nDamage / 2;
    }
    return nDamage + nBonus;
}

float PRCGetMetaMagicDuration(float fDuration, int nMeta = -1)
{
    if (nMeta == -1) // no metamagic value was passed, so get it here
    {
        nMeta = PRCGetMetaMagicFeat();
    }
    int nFeat = GetLocalInt(OBJECT_SELF,"PRC_SPELL_METAMAGIC");

    if (nMeta & METAMAGIC_EXTEND || nFeat & METAMAGIC_EXTEND)
    {
        fDuration *= 2;
    }

    return fDuration;
}

int PRCGetMetaMagicDamage(int nDamageType, int nDice, int nDieSize,
    int nBonusPerDie = 0, int nBonus = 0, int nMetaMagic = -1)
{
    // If the metamagic argument wasn't given get it.
    if (-1 == nMetaMagic) nMetaMagic = PRCGetMetaMagicFeat();

    // Roll the damage, applying metamagic.
    int nDamage = PRCMaximizeOrEmpower(nDieSize, nDice, nMetaMagic, (nBonusPerDie * nDice) + nBonus);
    return nDamage;
}

void PRCSetSchool(int nSchool = SPELL_SCHOOL_GENERAL)
{
    // Remove the last value in case it is there and set the new value if it is NOT general.
    DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
    if (SPELL_SCHOOL_GENERAL != nSchool)
        SetLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR", nSchool);
}


void PRCSignalSpellEvent(object oTarget, int bHostile = TRUE, int nSpellID = -1, object oCaster = OBJECT_SELF)
{
    if (-1 == nSpellID) nSpellID = PRCGetSpellId();

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(oCaster, nSpellID, bHostile));
}

void SPEvilShift(object oPC)
{
    // Check for alignment shift switch being active
    if(GetPRCSwitch(PRC_SPELL_ALIGNMENT_SHIFT))
    {
        // Amount of adjustment is equal to the square root of your distance from pure evil.
        // In other words, the amount of shift is higher the farther you are from pure evil, with the
        // extremes being 10 points of shift at pure good and 0 points of shift at pure evil.
        AdjustAlignment(oPC, ALIGNMENT_EVIL,  FloatToInt(sqrt(IntToFloat(GetGoodEvilValue(oPC)))), FALSE);
    }
}

void SPGoodShift(object oPC)
{
    // Check for alignment shift switch being active
    if(GetPRCSwitch(PRC_SPELL_ALIGNMENT_SHIFT))
    {
        // Amount of adjustment is equal to the square root of your distance from pure good.
        // In other words, the amount of shift is higher the farther you are from pure good, with the
        // extremes being 10 points of shift at pure evil and 0 points of shift at pure good.
        AdjustAlignment(oPC, ALIGNMENT_GOOD, FloatToInt(sqrt(IntToFloat(100 - GetGoodEvilValue(oPC)))), FALSE);
    }
}

void DoCorruptionCost(object oPC, int nAbility, int nCost, int bDrain)
{
    // Undead redirect all damage & drain to Charisma, sez http://www.wizards.com/dnd/files/BookVileFAQ12102002.zip
    if(MyPRCGetRacialType(oPC) == RACIAL_TYPE_UNDEAD)
        nAbility = ABILITY_CHARISMA;

    //Exalted Raiment
    if(GetHasSpellEffect(SPELL_EXALTED_RAIMENT, GetItemInSlot(INVENTORY_SLOT_CHEST, oPC)))
    {
        nCost -= 1;

        if(nCost < 1)
            nCost = 1;
    }

    // Is it ability drain?
    if(bDrain)
        ApplyAbilityDamage(oPC, nAbility, nCost, DURATION_TYPE_PERMANENT, TRUE);
    // Or damage
    else
        ApplyAbilityDamage(oPC, nAbility, nCost, DURATION_TYPE_TEMPORARY, TRUE, -1.0f);
}

void MultisummonPreSummon(object oPC = OBJECT_SELF, int bOverride = FALSE)
{
    if(!GetPRCSwitch(PRC_MULTISUMMON) && !bOverride)
        return;
    int i=1;
    int nCount = GetPRCSwitch(PRC_MULTISUMMON);
    if(bOverride)
        nCount = bOverride;
    if(nCount < 0
        || nCount == 1)
        nCount = 99;
    if(nCount > 99)
        nCount = 99;
    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, i);
    while(GetIsObjectValid(oSummon) && i < nCount)
    {
        AssignCommand(oSummon, SetIsDestroyable(FALSE, FALSE, FALSE));
        AssignCommand(oSummon, DelayCommand(0.3, SetIsDestroyable(TRUE, FALSE, FALSE)));
        i++;
        oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, i);
    }
}


//This function returns 1 only if the object oTarget is the object
//the weapon hit when it channeled the spell sSpell or if there is no
//channeling at all
int ChannelChecker(string sSpell, object oTarget)
{
    int nSpell = GetLocalInt(GetAreaOfEffectCreator(), sSpell+"channeled");
    int nTarget = GetLocalInt(oTarget, sSpell+"target");
    if(nSpell == 1 && nTarget == 1)
    {
        return 1;
    }
    else if(nSpell != 1 && nTarget != 1)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

//If a spell is being channeled, we store its target and its name
void StoreSpellVariables(string sString,int nDuration)
{
    object oCaster = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();     //using prc version could cause problems

    if(GetLocalInt(oCaster,"spellswd_aoe") == 1)
    {
        SetLocalInt(oCaster, sString+"channeled",1);
        SetLocalInt(oTarget, sString+"target",1);
    }
    DelayCommand(RoundsToSeconds(nDuration),DeleteLocalInt(oTarget, sString+"target"));
    DelayCommand(RoundsToSeconds(nDuration),DeleteLocalInt(oCaster, sString+"channeled"));
}

effect ChannelingVisual()
{
    return EffectVisualEffect(VFX_DUR_SPELLTURNING);
}

////////////////End Spellsword//////////////////


int GetHasMettle(object oTarget, int nSavingThrow)
{
    int nMettle = FALSE;
    object oArmour = GetItemInSlot(INVENTORY_SLOT_CHEST);

    if (nSavingThrow = SAVING_THROW_WILL)
    {
        // Iron Mind's ability only functions in Heavy Armour
        if (GetLevelByClass(CLASS_TYPE_IRONMIND, oTarget) >= 5 && GetBaseAC(oArmour) >= 6) nMettle = TRUE;
        else if (GetLevelByClass(CLASS_TYPE_HEXBLADE, oTarget) >= 3) nMettle = TRUE;
        else if (GetLevelByClass(CLASS_TYPE_SOHEI, oTarget) >= 9) nMettle = TRUE;
        else if (GetLevelByClass(CLASS_TYPE_CRUSADER, oTarget) >= 13) nMettle = TRUE;
        // Fill out the line below to add another class with Will mettle
        // else if (GetLevelByClass(CLASS_TYPE_X, oTarget) >= X) nMettle = TRUE;
    }
    if (nSavingThrow = SAVING_THROW_FORT)
    {
        // Add Classes with Fort mettle here
        if (GetLevelByClass(CLASS_TYPE_HEXBLADE, oTarget) >= 3) nMettle = TRUE;
        else if (GetLevelByClass(CLASS_TYPE_SOHEI, oTarget) >= 9) nMettle = TRUE;
        else if (GetLevelByClass(CLASS_TYPE_CRUSADER, oTarget) >= 13) nMettle = TRUE;
    }

    return nMettle;
}

void DoCommandSpell(object oCaster, object oTarget, int nSpellId, int nDuration, int nCaster)
{

    if(DEBUG) DoDebug("DoCommandSpell: SpellId: " + IntToString(nSpellId));
    if(DEBUG) DoDebug("Command Spell: Begin");
    if (nSpellId == SPELL_COMMAND_APPROACH || nSpellId == SPELL_GREATER_COMMAND_APPROACH ||
        nSpellId == SPELL_DOA_COMMAND_APPROACH || nSpellId == SPELL_DOA_GREATER_COMMAND_APPROACH)
    {
        // Force the target to approach the caster
        if(DEBUG) DoDebug("Command Spell: Approach");
        AssignCommand(oTarget, ClearAllActions(TRUE));
        AssignCommand(oTarget, ActionForceMoveToObject(oCaster, TRUE));
    }
    // Creatures that can't be disarmed ignore this
    else if ((nSpellId == SPELL_COMMAND_DROP && GetIsCreatureDisarmable(oTarget)) ||
             (nSpellId == SPELL_GREATER_COMMAND_DROP && GetIsCreatureDisarmable(oTarget)) ||
             (nSpellId == SPELL_DOA_COMMAND_DROP && GetIsCreatureDisarmable(oTarget)) ||
             (nSpellId == SPELL_DOA_GREATER_COMMAND_DROP && GetIsCreatureDisarmable(oTarget)))
    {
        // Force the target to drop what its holding
        if(DEBUG) DoDebug("Command Spell: Drop");
        AssignCommand(oTarget, ClearAllActions(TRUE));
        AssignCommand(oTarget, ActionPutDownItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget)));
        AssignCommand(oTarget, ActionPutDownItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget)));
    }
    else if (nSpellId == SPELL_COMMAND_FALL || nSpellId == SPELL_GREATER_COMMAND_FALL ||
             nSpellId == SPELL_DOA_COMMAND_FALL || nSpellId == SPELL_DOA_GREATER_COMMAND_FALL)
    {
        // Force the target to fall down
        if(DEBUG) DoDebug("Command Spell: Fall");
        AssignCommand(oTarget, ClearAllActions(TRUE));
        SPApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oTarget, RoundsToSeconds(nDuration),TRUE,-1,nCaster);
    }
    else if (nSpellId == SPELL_COMMAND_FLEE || nSpellId == SPELL_GREATER_COMMAND_FLEE ||
             nSpellId == SPELL_DOA_COMMAND_FLEE || nSpellId == SPELL_DOA_GREATER_COMMAND_FLEE)
    {
        // Force the target to flee the caster
        if(DEBUG) DoDebug("Command Spell: Flee");
        AssignCommand(oTarget, ClearAllActions(TRUE));
        AssignCommand(oTarget, ActionMoveAwayFromObject(oCaster, TRUE));
    }
    else if (nSpellId == SPELL_COMMAND_HALT || nSpellId == SPELL_GREATER_COMMAND_HALT ||
             nSpellId == SPELL_DOA_COMMAND_HALT || nSpellId == SPELL_DOA_GREATER_COMMAND_HALT)
    {
        // Force the target to stand still
        if(DEBUG) DoDebug("Command Spell: Stand");
        AssignCommand(oTarget, ClearAllActions(TRUE));
        SPApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneParalyze(), oTarget, RoundsToSeconds(nDuration),TRUE,-1,nCaster);
    }
    else // Catch errors here
    {
        if (!GetIsCreatureDisarmable(oTarget))
        {
            FloatingTextStringOnCreature(GetName(oTarget) + " is not disarmable.", oCaster, FALSE);
        }
        else
        {
            FloatingTextStringOnCreature("sp_command/sp_greatcommand: Error, Unknown SpellId", oCaster, FALSE);
        }
    }
    if(DEBUG) DoDebug("Command Spell: End");
}

int GetIsIncorporeal(object oTarget)
{
    int bIncorporeal = FALSE;

    //base it on appearance
    int nAppear = GetAppearanceType(oTarget);
    if(nAppear == APPEARANCE_TYPE_ALLIP
        || nAppear == APPEARANCE_TYPE_SHADOW
        ||nAppear == APPEARANCE_TYPE_SHADOW_FIEND
        ||nAppear == APPEARANCE_TYPE_SPECTRE
        ||nAppear == APPEARANCE_TYPE_WRAITH)
    {
        bIncorporeal = TRUE;
    }

    //Check for local int
    if(GetPersistantLocalInt(oTarget, "Is_Incorporeal"))
        bIncorporeal = TRUE;

    //check for feat
    if(GetHasFeat(FEAT_INCORPOREAL, oTarget))
        bIncorporeal = TRUE;

    //Return value
    return bIncorporeal;
}

int PRCGetIsAliveCreature(object oTarget)
{
        int bAlive = TRUE;
        // non-creatures aren't alive
        if (GetObjectType(oTarget) != OBJECT_TYPE_CREATURE)
            return FALSE; // night of the living waypoints :p

        int nType = MyPRCGetRacialType(oTarget);

        //Non-living races
        if(nType == RACIAL_TYPE_UNDEAD ||
           nType == RACIAL_TYPE_CONSTRUCT) bAlive = FALSE;

        //If they're dead :P
        if(GetIsDead(oTarget)) bAlive = FALSE;

        //return
        return bAlive;
}


int GetIsEthereal(object oTarget)
{
    int bEthereal = FALSE;

    //Check for local int
    if(GetPersistantLocalInt(oTarget, "Is_Ethereal"))
        bEthereal = TRUE;

    //check for feat
    if(GetHasFeat(FEAT_ETHEREAL, oTarget))
        bEthereal = TRUE;

    //Return value
    return bEthereal;
}


int GetControlledUndeadTotalHD(object oPC = OBJECT_SELF)
{
    int nTotalHD;
    int i = 1;
    object oSummonTest = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, i);
    while(GetIsObjectValid(oSummonTest))
    {
        if(MyPRCGetRacialType(oSummonTest) == RACIAL_TYPE_UNDEAD)
            nTotalHD += GetHitDice(oSummonTest);
        if(DEBUG)FloatingTextStringOnCreature(GetName(oSummonTest)+" is summon number "+IntToString(i), oPC);
        i++;
        oSummonTest = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, i);
    }
    return nTotalHD;
}


int GetControlledFiendTotalHD(object oPC = OBJECT_SELF)
{
    int nTotalHD;
    int i = 1;
    object oSummonTest = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, i);
    while(GetIsObjectValid(oSummonTest))
    {
        if(MyPRCGetRacialType(oSummonTest) == RACIAL_TYPE_OUTSIDER
             && GetAlignmentGoodEvil(oSummonTest) == ALIGNMENT_EVIL)
            nTotalHD += GetHitDice(oSummonTest);
        if(DEBUG)FloatingTextStringOnCreature(GetName(oSummonTest)+" is summon number "+IntToString(i), oPC);
        i++;
        oSummonTest = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, i);
    }
    return nTotalHD;
}

int GetControlledCelestialTotalHD(object oPC = OBJECT_SELF)
{
    int nTotalHD;
    int i = 1;
    object oSummonTest = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, i);
    while(GetIsObjectValid(oSummonTest))
    {
        if(MyPRCGetRacialType(oSummonTest) == RACIAL_TYPE_OUTSIDER
             && GetAlignmentGoodEvil(oSummonTest) == ALIGNMENT_GOOD)
            nTotalHD += GetHitDice(oSummonTest);
        if(DEBUG)FloatingTextStringOnCreature(GetName(oSummonTest)+" is summon number "+IntToString(i), oPC);
        i++;
        oSummonTest = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, i);
    }
    return nTotalHD;
}



// wrapper for DecrementRemainingSpellUses, works for newspellbook 'fake' spells too
// should also find and decrement metamagics for newspellbooks
void PRCDecrementRemainingSpellUses(object oCreature, int nSpell)
{
    if (!UseNewSpellBook(oCreature) && GetHasSpell(nSpell, oCreature))
    {
        DecrementRemainingSpellUses(oCreature, nSpell);
        return;
    }

    int nClass, nSpellbookID, nCount, nMeta, i, j;
    int nSpellbookType, nSpellLevel;
    string sFile, sFeat;
    for(i = 1; i <= 3; i++)
    {
        nClass = GetClassByPosition(i, oCreature);
        sFile = GetFileForClass(nClass);
        nSpellbookType = GetSpellbookTypeForClass(nClass);
        nSpellbookID = RealSpellToSpellbookID(nClass, nSpell);
        nMeta = RealSpellToSpellbookIDCount(nClass, nSpell);
        if (nSpellbookID != -1)
        {   //non-spellbook classes should return -1
            for(j = nSpellbookID; j <= nSpellbookID + nMeta; j++)
            {
                sFeat = Get2DACache(sFile, "ReqFeat", j);
                if(sFeat != "")
                {
                    if(!GetHasFeat(StringToInt(sFeat), oCreature))
                        continue;
                }
                nSpellLevel = StringToInt(Get2DACache(sFile, "Level", j));

                if(nSpellbookType == SPELLBOOK_TYPE_PREPARED)
                {
                    nCount = persistant_array_get_int(oCreature, "NewSpellbookMem_" + IntToString(nClass), j);
                    if(DEBUG) DoDebug("PRCDecrementRemainingSpellUses: NewSpellbookMem_" + IntToString(nClass) + "[" + IntToString(j) + "] = " + IntToString(nCount));
                    if(nCount > 0)
                    {
                        persistant_array_set_int(oCreature, "NewSpellbookMem_" + IntToString(nClass), j, nCount - 1);
                        return;
                    }
                }
                else  if(nSpellbookType == SPELLBOOK_TYPE_SPONTANEOUS)
                {
                    nCount = persistant_array_get_int(oCreature, "NewSpellbookMem_" + IntToString(nClass), nSpellLevel);
                    if(DEBUG) DoDebug("PRCDecrementRemainingSpellUses: NewSpellbookMem_" + IntToString(nClass) + "[" + IntToString(j) + "] = " + IntToString(nCount));
                    if(nCount > 0)
                    {
                        persistant_array_set_int(oCreature, "NewSpellbookMem_" + IntToString(nClass), nSpellLevel, nCount - 1);
                        return;
                    }
                }
            }
        }
    }
    if(DEBUG) DoDebug("PRCDecrementRemainingSpellUses: Spell " + IntToString(nSpell) + " not found");
}

//
//  This function determines if spell damage is elemental
//
int IsSpellDamageElemental(int nDamageType)
{
    return nDamageType == DAMAGE_TYPE_ACID
        || nDamageType == DAMAGE_TYPE_COLD
        || nDamageType == DAMAGE_TYPE_ELECTRICAL
        || nDamageType == DAMAGE_TYPE_FIRE
        || nDamageType == DAMAGE_TYPE_SONIC;
}

//
//  This function converts spell damage into the correct type
//  TODO: Change the name to consistent (large churn project).
//
int ChangedElementalDamage(object oCaster, int nDamageType){
    // Check if an override is set
    int nNewType = GetLocalInt(oCaster, "archmage_mastery_elements");

    // If so, check if the spell qualifies for a change
    if (!nNewType || !IsSpellDamageElemental(nDamageType))
        nNewType = nDamageType;

    return nNewType;
}

//used in scripts after ChangedElementalDamage() to determine saving throw type
int ChangedSaveType(int nDamageType)
{
    switch(nDamageType)
    {
        case DAMAGE_TYPE_ACID:       return SAVING_THROW_TYPE_ACID;
        case DAMAGE_TYPE_COLD:       return SAVING_THROW_TYPE_COLD;
        case DAMAGE_TYPE_ELECTRICAL: return SAVING_THROW_TYPE_ELECTRICITY;
        case DAMAGE_TYPE_FIRE:       return SAVING_THROW_TYPE_FIRE;
        case DAMAGE_TYPE_SONIC:      return SAVING_THROW_TYPE_SONIC;
        case DAMAGE_TYPE_DIVINE:     return SAVING_THROW_TYPE_DIVINE;
        case DAMAGE_TYPE_NEGATIVE:   return SAVING_THROW_TYPE_NEGATIVE;
        case DAMAGE_TYPE_POSITIVE:   return SAVING_THROW_TYPE_POSITIVE;
    }
    return SAVING_THROW_TYPE_NONE;//if it ever gets here, than the function was used incorrectly
}

// this is possibly used in variations elsewhere
int PRCGetElementalDamageType(int nDamageType, object oCaster = OBJECT_SELF)
{
    switch(nDamageType)
    {
        case DAMAGE_TYPE_ACID:
        case DAMAGE_TYPE_COLD:
        case DAMAGE_TYPE_ELECTRICAL:
        case DAMAGE_TYPE_FIRE:
        case DAMAGE_TYPE_SONIC:
            nDamageType = ChangedElementalDamage(oCaster, nDamageType);
    }
    return nDamageType;
}

effect PRCEffectDamage(object oTarget, int nDamageAmount, int nDamageType=DAMAGE_TYPE_MAGICAL, int nDamagePower=DAMAGE_POWER_NORMAL)
{
    if (PRCGetLastSpellCastClass(OBJECT_SELF) == CLASS_TYPE_WARMAGE)
    {
        // Warmage Edge
        nDamageAmount += GetAbilityModifier(ABILITY_INTELLIGENCE, OBJECT_SELF);
        if (GetHasFeat(FEAT_TYPE_EXTRA_EDGE, OBJECT_SELF))
        {
            // Extra Edge feat.
            nDamageAmount += (GetLevelByClass(CLASS_TYPE_WARMAGE, OBJECT_SELF) / 4) + 1;
        }
    }

    // Thrall of Grazzt damage
    nDamageAmount += SpellBetrayalDamage(oTarget, OBJECT_SELF);

    // Piercing Evocation
    if (GetHasFeat(FEAT_PIERCING_EVOCATION, OBJECT_SELF) && GetSpellSchool(PRCGetSpellId()) == SPELL_SCHOOL_EVOCATION)
    {
        // Elemental damage only
        if (nDamageType == DAMAGE_TYPE_FIRE || nDamageType == DAMAGE_TYPE_ACID || nDamageType == DAMAGE_TYPE_COLD ||
            nDamageType == DAMAGE_TYPE_ELECTRICAL || nDamageType == DAMAGE_TYPE_SONIC)
        {
                // Damage magical, max 10 to magical
                if (nDamageAmount > 10)
                {
                        nDamageAmount -= 10;
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10), oTarget);
                }
                else
                {
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDamageAmount), oTarget);
                        effect eEffect;
                        return eEffect; // Null return
                }
        }
    }

    //Bane Magic
    int nRace = MyPRCGetRacialType(oTarget);
    int nFeat = -1;

    switch(nRace)
    {
        case RACIAL_TYPE_ABERRATION:         nFeat = FEAT_BANE_MAGIC_ABERRATION;         break;
        case RACIAL_TYPE_ANIMAL:             nFeat = FEAT_BANE_MAGIC_ANIMAL;             break;
        case RACIAL_TYPE_BEAST:              nFeat = FEAT_BANE_MAGIC_BEAST;              break;
        case RACIAL_TYPE_CONSTRUCT:          nFeat = FEAT_BANE_MAGIC_CONSTRUCT;          break;
        case RACIAL_TYPE_DRAGON:             nFeat = FEAT_BANE_MAGIC_DRAGON;             break;
        case RACIAL_TYPE_DWARF:              nFeat = FEAT_BANE_MAGIC_DWARF;              break;
        case RACIAL_TYPE_ELEMENTAL:          nFeat = FEAT_BANE_MAGIC_ELEMENTAL;          break;
        case RACIAL_TYPE_ELF:                nFeat = FEAT_BANE_MAGIC_ELF;                break;
        case RACIAL_TYPE_FEY:                nFeat = FEAT_BANE_MAGIC_FEY;                break;
        case RACIAL_TYPE_GIANT:              nFeat = FEAT_BANE_MAGIC_GIANT;              break;
        case RACIAL_TYPE_GNOME:              nFeat = FEAT_BANE_MAGIC_GNOME;              break;
        case RACIAL_TYPE_HALFELF:            nFeat = FEAT_BANE_MAGIC_HALFELF;            break;
        case RACIAL_TYPE_HALFLING:           nFeat = FEAT_BANE_MAGIC_HALFLING;           break;
        case RACIAL_TYPE_HALFORC:            nFeat = FEAT_BANE_MAGIC_HALFORC;            break;
        case RACIAL_TYPE_HUMAN:              nFeat = FEAT_BANE_MAGIC_HUMAN;              break;
        case RACIAL_TYPE_HUMANOID_GOBLINOID: nFeat = FEAT_BANE_MAGIC_HUMANOID_GOBLINOID; break;
        case RACIAL_TYPE_HUMANOID_MONSTROUS: nFeat = FEAT_BANE_MAGIC_HUMANOID_MONSTROUS; break;
        case RACIAL_TYPE_HUMANOID_ORC:       nFeat = FEAT_BANE_MAGIC_HUMANOID_ORC;       break;
        case RACIAL_TYPE_HUMANOID_REPTILIAN: nFeat = FEAT_BANE_MAGIC_HUMANOID_REPTILIAN; break;
        case RACIAL_TYPE_MAGICAL_BEAST:      nFeat = FEAT_BANE_MAGIC_MAGICAL_BEAST;      break;
        case RACIAL_TYPE_OUTSIDER:           nFeat = FEAT_BANE_MAGIC_OUTSIDER;           break;
        case RACIAL_TYPE_SHAPECHANGER:       nFeat = FEAT_BANE_MAGIC_SHAPECHANGER;       break;
        case RACIAL_TYPE_UNDEAD:             nFeat = FEAT_BANE_MAGIC_UNDEAD;             break;
        case RACIAL_TYPE_VERMIN:             nFeat = FEAT_BANE_MAGIC_VERMIN;             break;
        default: nFeat = -1;
    }

    if(nFeat != -1 && GetHasFeat(nFeat, OBJECT_SELF))
        nDamageAmount += d6(2);

    return EffectDamage(nDamageAmount, nDamageType, nDamagePower);
}



// * Kovi. removes any effects from this type of spell
// * i.e., used in Mage Armor to remove any previous
// * mage armors
void PRCRemoveEffectsFromSpell(object oTarget, int SpellID)
{
  effect eLook = GetFirstEffect(oTarget);
  while (GetIsEffectValid(eLook)) {
    if (GetEffectSpellId(eLook) == SpellID)
      RemoveEffect(oTarget, eLook);
    eLook = GetNextEffect(oTarget);
  }
}

void PRCRemoveSpecificEffect(int nEffectTypeID, object oTarget)
{
    //Search through the valid effects on the target.
    effect eAOE = GetFirstEffect(oTarget);
    while (GetIsEffectValid(eAOE))
    {
        if (GetEffectType(eAOE) == nEffectTypeID)
        {
            //If the effect was created by the spell then remove it
            RemoveEffect(oTarget, eAOE);
        }
        //Get next effect on the target
        eAOE = GetNextEffect(oTarget);
    }
}

effect PRCGetScaledEffect(effect eStandard, object oTarget)
{
    int nDiff = GetGameDifficulty();
    effect eNew = eStandard;
    object oMaster = GetMaster(oTarget);
    if(GetIsPC(oTarget) || (GetIsObjectValid(oMaster) && GetIsPC(oMaster)))
    {
        if(GetEffectType(eStandard) == EFFECT_TYPE_FRIGHTENED && nDiff == GAME_DIFFICULTY_VERY_EASY)
        {
            eNew = EffectAttackDecrease(-2);
            return eNew;
        }
        if(GetEffectType(eStandard) == EFFECT_TYPE_FRIGHTENED && nDiff == GAME_DIFFICULTY_EASY)
        {
            eNew = EffectAttackDecrease(-4);
            return eNew;
        }
        if(nDiff == GAME_DIFFICULTY_VERY_EASY &&
            (GetEffectType(eStandard) == EFFECT_TYPE_PARALYZE ||
             GetEffectType(eStandard) == EFFECT_TYPE_STUNNED ||
             GetEffectType(eStandard) == EFFECT_TYPE_CONFUSED))
        {
            eNew = EffectDazed();
            return eNew;
        }
        else if(GetEffectType(eStandard) == EFFECT_TYPE_CHARMED || GetEffectType(eStandard) == EFFECT_TYPE_DOMINATED)
        {
            eNew = EffectDazed();
            return eNew;
        }
    }
    return eNew;
}

int PRCAmIAHumanoid(object oTarget)
{
   int nRacial = MyPRCGetRacialType(oTarget);

   if((nRacial == RACIAL_TYPE_DWARF) ||
      (nRacial == RACIAL_TYPE_HALFELF) ||
      (nRacial == RACIAL_TYPE_HALFORC) ||
      (nRacial == RACIAL_TYPE_ELF) ||
      (nRacial == RACIAL_TYPE_GNOME) ||
      (nRacial == RACIAL_TYPE_HUMANOID_GOBLINOID) ||
      (nRacial == RACIAL_TYPE_HALFLING) ||
      (nRacial == RACIAL_TYPE_HUMAN) ||
      (nRacial == RACIAL_TYPE_HUMANOID_MONSTROUS) ||
      (nRacial == RACIAL_TYPE_HUMANOID_ORC) ||
      (nRacial == RACIAL_TYPE_HUMANOID_REPTILIAN))
   {
    return TRUE;
   }
   return FALSE;
}

int PRCGetScaledDuration(int nActualDuration, object oTarget)
{

    int nDiff = GetGameDifficulty();
    int nNew = nActualDuration;
    if(GetIsPC(oTarget) && nActualDuration > 3)
    {
        if(nDiff == GAME_DIFFICULTY_VERY_EASY || nDiff == GAME_DIFFICULTY_EASY)
        {
            nNew = nActualDuration / 4;
        }
        else if(nDiff == GAME_DIFFICULTY_NORMAL)
        {
            nNew = nActualDuration / 2;
        }
        if(nNew == 0)
        {
            nNew = 1;
        }
    }
    return nNew;
}

effect PRCCreateProtectionFromAlignmentLink(int nAlignment, int nPower = 1)
{
    int nAlignmentLC;
    int nAlignmentGE;
    effect eDur;
    if(nAlignment == ALIGNMENT_LAWFUL)
    {
        nAlignmentLC = ALIGNMENT_LAWFUL;
        nAlignmentGE = ALIGNMENT_ALL;
        eDur = EffectVisualEffect(VFX_DUR_PROTECTION_EVIL_MINOR);
    }
    else if(nAlignment == ALIGNMENT_CHAOTIC)
    {
        nAlignmentLC = ALIGNMENT_CHAOTIC;
        nAlignmentGE = ALIGNMENT_ALL;
        eDur = EffectVisualEffect(VFX_DUR_PROTECTION_GOOD_MINOR);
    }
    else if(nAlignment == ALIGNMENT_GOOD)
    {
        nAlignmentLC = ALIGNMENT_ALL;
        nAlignmentGE = ALIGNMENT_GOOD;
        eDur = EffectVisualEffect(VFX_DUR_PROTECTION_EVIL_MINOR);
    }
    else if(nAlignment == ALIGNMENT_EVIL)
    {
        nAlignmentLC = ALIGNMENT_ALL;
        nAlignmentGE = ALIGNMENT_EVIL;
        eDur = EffectVisualEffect(VFX_DUR_PROTECTION_GOOD_MINOR);
    }

    int nFinal = nPower * 2;
    effect eAC = EffectACIncrease(nFinal, AC_DEFLECTION_BONUS);
           eAC = VersusAlignmentEffect(eAC, nAlignmentLC, nAlignmentGE);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, nFinal);
           eSave = VersusAlignmentEffect(eSave, nAlignmentLC, nAlignmentGE);
    effect eImmune = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
           eImmune = VersusAlignmentEffect(eImmune, nAlignmentLC, nAlignmentGE);

    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eImmune, eSave);
    eLink = EffectLinkEffects(eLink, eAC);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);
    return eLink;
}

float PRCGetSpellEffectDelay(location SpellTargetLocation, object oTarget)
{
    float fDelay;
    return fDelay = GetDistanceBetweenLocations(SpellTargetLocation, GetLocation(oTarget))/20;
}

// * returns true if the creature has flesh
int PRCIsImmuneToPetrification(object oCreature)
{
    int nAppearance = GetAppearanceType(oCreature);
    int bImmune = FALSE;
    switch (nAppearance)
    {
        case APPEARANCE_TYPE_BASILISK:
        case APPEARANCE_TYPE_COCKATRICE:
        case APPEARANCE_TYPE_MEDUSA:
        case APPEARANCE_TYPE_ALLIP:
        case APPEARANCE_TYPE_ELEMENTAL_AIR:
        case APPEARANCE_TYPE_ELEMENTAL_AIR_ELDER:
        case APPEARANCE_TYPE_ELEMENTAL_EARTH:
        case APPEARANCE_TYPE_ELEMENTAL_EARTH_ELDER:
        case APPEARANCE_TYPE_ELEMENTAL_FIRE:
        case APPEARANCE_TYPE_ELEMENTAL_FIRE_ELDER:
        case APPEARANCE_TYPE_ELEMENTAL_WATER:
        case APPEARANCE_TYPE_ELEMENTAL_WATER_ELDER:
        case APPEARANCE_TYPE_GOLEM_STONE:
        case APPEARANCE_TYPE_GOLEM_IRON:
        case APPEARANCE_TYPE_GOLEM_CLAY:
        case APPEARANCE_TYPE_GOLEM_BONE:
        case APPEARANCE_TYPE_GORGON:
        case APPEARANCE_TYPE_HEURODIS_LICH:
        case APPEARANCE_TYPE_LANTERN_ARCHON:
        case APPEARANCE_TYPE_SHADOW:
        case APPEARANCE_TYPE_SHADOW_FIEND:
        case APPEARANCE_TYPE_SHIELD_GUARDIAN:
        case APPEARANCE_TYPE_SKELETAL_DEVOURER:
        case APPEARANCE_TYPE_SKELETON_CHIEFTAIN:
        case APPEARANCE_TYPE_SKELETON_COMMON:
        case APPEARANCE_TYPE_SKELETON_MAGE:
        case APPEARANCE_TYPE_SKELETON_PRIEST:
        case APPEARANCE_TYPE_SKELETON_WARRIOR:
        case APPEARANCE_TYPE_SKELETON_WARRIOR_1:
        case APPEARANCE_TYPE_SPECTRE:
        case APPEARANCE_TYPE_WILL_O_WISP:
        case APPEARANCE_TYPE_WRAITH:
        case APPEARANCE_TYPE_BAT_HORROR:
        case 405: // Dracolich:
        case 415: // Alhoon
        case 418: // shadow dragon
        case 420: // mithral golem
        case 421: // admantium golem
        case 430: // Demi Lich
        case 469: // animated chest
        case 474: // golems
        case 475: // golems
        bImmune = TRUE;
    }

    int nRacialType = MyPRCGetRacialType(oCreature);
    switch(nRacialType)
    {
        case RACIAL_TYPE_ELEMENTAL:
        case RACIAL_TYPE_CONSTRUCT:
        case RACIAL_TYPE_OOZE:
        case RACIAL_TYPE_UNDEAD:
        bImmune = TRUE;
    }

    // 01/08/07 Racial feat for petrification immunity
    if(GetHasFeat(FEAT_IMMUNE_PETRIFICATION)) bImmune = TRUE;

    // 03/07/2005 CraigW - Petrification immunity can also be granted as an item property.
    if ( ResistSpell(OBJECT_SELF,oCreature) == 2 )
    {
        bImmune = TRUE;
    }

    // * GZ: Sept 2003 - Prevent people from petrifying DM, resulting in GUI even when
    //                   effect is not successful.
    if (!GetPlotFlag(oCreature) && GetIsDM(oCreature))
    {
       bImmune = FALSE;
    }
    return bImmune;
}

// *  This is a wrapper for how Petrify will work in Expansion Pack 1
// * Scripts affected: flesh to stone, breath petrification, gaze petrification, touch petrification
// * nPower : This is the Hit Dice of a Monster using Gaze, Breath or Touch OR it is the Caster Spell of
// *   a spellcaster
// * nFortSaveDC: pass in this number from the spell script
void PRCDoPetrification(int nPower, object oSource, object oTarget, int nSpellID, int nFortSaveDC)
{

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        // * exit if creature is immune to petrification
        if (PRCIsImmuneToPetrification(oTarget) == TRUE)
        {
            return;
        }
        float fDifficulty = 0.0;
        int bIsPC = GetIsPC(oTarget);
        int bShowPopup = FALSE;

        // * calculate Duration based on difficulty settings
        int nGameDiff = GetGameDifficulty();
        switch (nGameDiff)
        {
            case GAME_DIFFICULTY_VERY_EASY:
            case GAME_DIFFICULTY_EASY:
            case GAME_DIFFICULTY_NORMAL:
                    fDifficulty = RoundsToSeconds(nPower); // One Round per hit-die or caster level
                break;
            case GAME_DIFFICULTY_CORE_RULES:
            case GAME_DIFFICULTY_DIFFICULT:
                bShowPopup = TRUE;
            break;
        }

        int nSaveDC = nFortSaveDC;
        effect ePetrify = EffectPetrify();

        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

        effect eLink = EffectLinkEffects(eDur, ePetrify);

            // Let target know the negative spell has been cast
            SignalEvent(oTarget,
                        EventSpellCastAt(OBJECT_SELF, nSpellID));
                        //SpeakString(IntToString(nSpellID));

            // Do a fortitude save check
            if (!PRCMySavingThrow(SAVING_THROW_FORT, oTarget, nSaveDC))
            {
                // Save failed; apply paralyze effect and VFX impact

                /// * The duration is permanent against NPCs but only temporary against PCs
                if (bIsPC == TRUE)
                {
                    if (bShowPopup == TRUE)
                    {
                        // * under hardcore rules or higher, this is an instant death
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
                        //only pop up death panel if switch is not set
                        if(!GetPRCSwitch(PRC_NO_PETRIFY_GUI))
                        DelayCommand(2.75, PopUpDeathGUIPanel(oTarget, FALSE , TRUE, 40579));
                        //run the PRC Ondeath code
                        //no way to run the normal module ondeath code too
                        //so a execute script has been added for builders to take advantage of
                        DelayCommand(2.75, ExecuteScript("prc_ondeath", oTarget));
                        DelayCommand(2.75, ExecuteScript("prc_pw_petrific", oTarget));
                        // if in hardcore, treat the player as an NPC
                        bIsPC = FALSE;
                        //fDifficulty = TurnsToSeconds(nPower); // One turn per hit-die
                    }
                    else
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDifficulty);
                }
                else
                {
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
                }
                // April 2003: Clearing actions to kick them out of conversation when petrified
                AssignCommand(oTarget, ClearAllActions(TRUE));
            }
    }

}

//------------------------------------------------------------------------------
// GZ: 2003-Oct-15
// A different approach for timing these spells that has the positive side
// effects of making the spell dispellable as well.
// I am using the VFX applied by the spell to track the remaining duration
// instead of adding the remaining runtime on the stack
//
// This function returns FALSE if a delayed Spell effect from nSpell_ID has
// expired. See x2_s0_bigby4.nss for details
//------------------------------------------------------------------------------
int PRCGetDelayedSpellEffectsExpired(int nSpell_ID, object oTarget, object oCaster)
{

    if (!GetHasSpellEffect(nSpell_ID,oTarget) )
    {
        DeleteLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (nSpell_ID));
        return TRUE;
    }

    //--------------------------------------------------------------------------
    // GZ: 2003-Oct-15
    // If the caster is dead or no longer there, cancel the spell, as it is
    // directed
    //--------------------------------------------------------------------------
    if( !GetIsObjectValid(oCaster))
    {
        GZPRCRemoveSpellEffects(nSpell_ID, oTarget);
        DeleteLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (nSpell_ID));
        return TRUE;
    }

    if (GetIsDead(oCaster))
    {
        DeleteLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (nSpell_ID));
        GZPRCRemoveSpellEffects(nSpell_ID, oTarget);
        return TRUE;
    }

    return FALSE;

}

// Much similar to PRCGetHasSpell, but used for JPM to get spells left not counting metamagic
int PRCGetSpellUsesLeft(int nRealSpellID, object oCreature = OBJECT_SELF)
{
    if(!PRCGetIsRealSpellKnown(nRealSpellID, oCreature))
        return 0;
    int nUses = GetHasSpell(nRealSpellID, oCreature);

    int nClass, nSpellbookID, nCount, i, j;
    int nSpellbookType, nSpellLevel;
    string sFile, sFeat;
    for(i = 1; i <= 3; i++)
    {
        nClass = GetClassByPosition(i, oCreature);
        sFile = GetFileForClass(nClass);
        nSpellbookType = GetSpellbookTypeForClass(nClass);
        nSpellbookID = RealSpellToSpellbookID(nClass, nRealSpellID);
        if (nSpellbookID != -1)
        {   //non-spellbook classes should return -1
                sFeat = Get2DACache(sFile, "ReqFeat", j);
                if(sFeat != "")
                {
                    if(!GetHasFeat(StringToInt(sFeat), oCreature))
                        continue;
                }
                if(nSpellbookType == SPELLBOOK_TYPE_PREPARED)
                {
                    nCount = persistant_array_get_int(oCreature, "NewSpellbookMem_" + IntToString(nClass), j);
                    if(DEBUG) DoDebug("PRCGetHasSpell(Prepared Caster): NewSpellbookMem_" + IntToString(nClass) + "[" + IntToString(j) + "] = " + IntToString(nCount));
                    if(nCount > 0)
                    {
                        nUses += nCount;
                    }
                }
                else if(nSpellbookType == SPELLBOOK_TYPE_SPONTANEOUS)
                {
                    nSpellLevel = StringToInt(Get2DACache(sFile, "Level", j));
                    nCount = persistant_array_get_int(oCreature, "NewSpellbookMem_" + IntToString(nClass), nSpellLevel);
                    if(DEBUG) DoDebug("PRCGetHasSpell(Spontaneous Caster): NewSpellbookMem_" + IntToString(nClass) + "[" + IntToString(j) + "] = " + IntToString(nCount));
                    if(nCount > 0)
                    {
                        nUses += nCount;
                    }
                }
        }
    }

    if(DEBUG) DoDebug("PRCGetHasSpell: RealSpellID = " + IntToString(nRealSpellID) + ", Uses = " + IntToString(nUses));
    return nUses;
}

// * Applies the effects of FEAT_AUGMENT_SUMMON to summoned creatures.
void AugmentSummonedCreature(object oSelf = OBJECT_SELF)
{
    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oSelf);
    int i=1;

    effect eAttack = EffectAttackIncrease(1);
    effect eDamage = EffectDamageIncrease(DAMAGE_BONUS_1, DAMAGE_TYPE_SLASHING);
    effect eHP = EffectTemporaryHitpoints(d8(1));
    effect eLink = EffectLinkEffects(eAttack, eDamage);
    eLink = EffectLinkEffects(eLink, eHP);
    eLink = SupernaturalEffect(eLink);

    while(GetIsObjectValid(oSummon))
    {
        if(GetLocalInt(oSummon, "Augmented"))
        {
            //Already has effect, check other summon
            i++;
            oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oSelf, i);
        }
        else
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oSummon);
            SetLocalInt(oSummon, "Augmented", 1);
            i++;
            oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oSelf, i);
        }
    }
}
