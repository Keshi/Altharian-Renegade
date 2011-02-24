//::///////////////////////////////////////////////
//:: Psionics include: Psionic Core Files
//:: psi_inc_core
//::///////////////////////////////////////////////
/** @file
    Core functions removed from
	
	psi_inc_psifunc
	psi_inc_focus (depreciated)
	
	as they are required by many of the other psi groups

    @author Ornedan/ElgarL
    @date   Created - 2005.11.10/23.07.2010
 */
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////


//////////////////////////////////////////////////
/*                 Constants                    */
//////////////////////////////////////////////////

// Included here to provide the values for the constants below
#include "prc_class_const"

const int POWER_LIST_PSION          = CLASS_TYPE_PSION;
const int POWER_LIST_WILDER         = CLASS_TYPE_WILDER;
const int POWER_LIST_PSYWAR         = CLASS_TYPE_PSYWAR;
const int POWER_LIST_FIST_OF_ZUOKEN = CLASS_TYPE_FIST_OF_ZUOKEN;
const int POWER_LIST_WARMIND        = CLASS_TYPE_WARMIND;

#include "psi_inc_const"

//////////////////////////////////////////////////
/*             Function prototypes              */
//////////////////////////////////////////////////

/**
 * Attempts to use psionic focus. If the creature was focused, it
 * loses the focus. If it has Epic Psionic Focus feats, it will
 * be able to use the focus for a number of times equal to the
 * number of those feats it has during the next 0.5s
 *
 * @param oUser Creature expending it's psionic focus
 * @return      TRUE if the creature was psionically focus or had
 *              Epic Psionic Focus uses remaining. FALSE otherwise.
 */
int UsePsionicFocus(object oUser = OBJECT_SELF);

/**
 * Sets psionic focus active and triggers feats dependant
 * on it.
 *
 * Feats currently keyed to activity of psionic focus:
 *  Psionic Dodge
 *  Speed of Thought
 *
 * @param oGainee Creature gaining psionic focus.
 */
void GainPsionicFocus(object oGainee = OBJECT_SELF);

/**
 * Gets the number of psionic focus uses the creature has available
 * to it at this moment. If the creature is psionically focused,
 * the number equal to GetPsionicFocusUsesPerExpenditure(), otherwise
 * it is however many focus uses the creature still has remaining of
 * that number.
 *
 * @param oCreature Creaute whose psionic focus use count to evaluate
 * @return          The total number of times UsePsionicFocus() will
 *                  return TRUE if called at this moment.
 */
int GetPsionicFocusesAvailable(object oCreature = OBJECT_SELF);

/**
 * Calculates the number of times a creature may use it's psionic focus when expending it.
 * Base is 1.
 * In addition, 1 more use for each Epic Psionic Focus feat the creature has.
 *
 * @param oCreature Creaute whose psionic focus use count to evaluate
 * @return          The total number of times UsePsionicFocus() will return
 *                  TRUE for a single expending of psionic focus.
 */
int GetPsionicFocusUsesPerExpenditure(object oCreature = OBJECT_SELF);

/**
 * Sets the given creature's psionic focus off and deactivates all feats keyed to it.
 *
 * @param oLoser Creature losing it's psionic focus
 */
void LosePsionicFocus(object oLoser = OBJECT_SELF);

/**
 * Checks whether the given creature is psionically focused.
 *
 * @param oCreature Creature whose psionic focus's state to examine
 * @return          TRUE if the creature is psionically focused, FALSE
 *                  otherwise.
 */
int GetIsPsionicallyFocused(object oCreature = OBJECT_SELF);

/**
 * Determines the number of feats that would use psionic focus
 * when triggered the given creature has active.
 *
 * Currently accounts for:
 *  Talented
 *  Power Specialization
 *  Power Penetration
 *  Psionic Endowment
 *  Chain Power
 *  Empower Power
 *  Extend Power
 *  Maximize Power
 *  Split Psionic Ray
 *  Twin Power
 *  Widen Power
 *  Quicken Power
 *
 * @param oCreature Creature whose feats to examine
 * @return          How many of the listed feats are active
 */
int GetPsionicFocusUsingFeatsActive(object oCreature = OBJECT_SELF);

/**
 * Calculates the DC of the power being currently manifested.
 * Base value is 10 + power level + ability modifier in manifesting stat
 *
 * WARNING: Return value is not defined when a power is not being manifested.
 *
 */
int GetManifesterDC(object oManifester = OBJECT_SELF);

/**
 * Determines the spell school matching a discipline according to the
 * standard transparency rules.
 * Disciplines which have no matching spell school are matched with
 * SPELL_SCHOOL_GENERAL.
 *
 * @param nDiscipline Discipline to find matching spell school for
 * @return            SPELL_SCHOOL_* of the match
 */
int DisciplineToSpellSchool(int nDiscipline);

/**
 * Determines the discipline matching a spell school according to the
 * standard transparency rules.
 * Spell schools that have no matching disciplines are matched with
 * DISCIPLINE_NONE.
 *
 * @param nSpellSchool Spell schools to find matching discipline for
 * @return             DISCIPLINE_* of the match
 */
int SpellSchoolToDiscipline(int nSpellSchool);

/**
 * Determines the discipline of a power, using the School column of spells.2da.
 *
 * @param nSpellID The spellID of the power to determine the discipline of
 * @return         DISCIPLINE_* constant. DISCIPLINE_NONE if the power's
 *                 School designation does not match any of the discipline's.
 */
int GetPowerDiscipline(int nSpellID);

/**
 * Determines whether a given power is a power of the Telepahty discipline.
 *
 * @param nSpellID The spells.2da row of the power. If left to default,
 *                 PRCGetSpellId() is used.
 * @return         TRUE if the power's discipline is Telepathy, FALSE otherwise
 */
int GetIsTelepathyPower(int nSpellID = -1);

/**
 * Checks whether the PC possesses the feats the given feat has as it's
 * prerequisites. Possession of a feat is checked using GetHasFeat().
 *
 *
 * @param nFeat The feat for which determine the possession of prerequisites
 * @param oPC   The creature whose feats to check
 * @return      TRUE if the PC possesses the prerequisite feats AND does not
 *              already posses nFeat, FALSE otherwise.
 */
int CheckPowerPrereqs(int nFeat, object oPC);

/**
 * Determines the manifester's level in regards to manifester checks to overcome
 * spell resistance.
 *
 * WARNING: Return value is not defined when a power is not being manifested.
 *
 * @param oManifester A creature manifesting a power at the moment
 * @return            The creature's manifester level, adjusted to account for
 *                    modifiers that affect spell resistance checks.
 */
int GetPsiPenetration(object oManifester = OBJECT_SELF);

/**
 * Determines whether a given creature possesses the Psionic subtype.
 * Ways of possessing the subtype:
 * - Being of a naturally psionic race
 * - Having class levels in a psionic class
 * - Possessing the Wild Talent feat
 *
 * @param oCreature Creature to test
 * @return          TRUE if the creature is psionic, FALSE otherwise.
 */
int GetIsPsionicCharacter(object oCreature);

/**
 * Creates the creature weapon for powers like Bite of the Wolf and Claws of the
 * Beast. If a creature weapon of the correct type is already present, it is
 * used instead of a new one.
 *
 * Preserving existing weapons may cause problems, if so, make the function instead delete the old object - Ornedan
 *
 * @param oCreature     Creatue whose creature weapons to mess with.
 * @param sResRef       Resref of the creature weapon. Assumed to be one of the
 *                      PRC creature weapons, so this considered to is also be
 *                      the tag.
 * @param nIventorySlot Inventory slot where the creature weapon is to be equipped.
 * @param fDuration     If a new weapon is created, it will be destroyed after
 *                      this duration.
 *
 * @return              The newly created creature weapon. Or an existing weapon,
 *                      if there was one.
 */
object GetPsionicCreatureWeapon(object oCreature, string sResRef, int nInventorySlot, float fDuration);

/**
 * Applies modifications to a power's damage that depend on some property
 * of the target.
 * Currently accounts for:
 *  - Mental Resistance
 *  - Greater Power Specialization
 *  - Intellect Fortress
 *
 * @param oTarget     A creature being dealt damage by a power
 * @param oManifester The creature manifesting the damaging power
 * @param nDamage     The amount of damage the creature would be dealt
 *
 * @param bIsHitPointDamage Is the damage HP damage or something else?
 * @param bIsEnergyDamage   Is the damage caused by energy or something else? Only relevant if the damage is HP damage.
 *
 * @return The amount of damage, modified by oTarget's abilities
 */
int GetTargetSpecificChangesToDamage(object oTarget, object oManifester, int nDamage,
                                     int bIsHitPointDamage = TRUE, int bIsEnergyDamage = FALSE);

/**
 * Gets the manifester level adjustment from the Practiced Manifester feats.
 *
 * @param oManifester           The creature to check
 * @param iManifestingClass     The CLASS_TYPE* that the power was cast by.
 * @param iManifestingLevels    The manifester level for the power calculated so far 
 *                              ie. BEFORE Practiced Manifester.
 */
int PracticedManifesting(object oManifester, int iManifestingClass, int iManifestingLevels);

/**
 * Determines the given creature's manifester level. If a class is specified,
 * then returns the manifester level for that class. Otherwise, returns
 * the manifester level for the currently active manifestation.
 *
 * @param oManifester    The creature whose manifester level to determine
 * @param nSpecificClass The class to determine the creature's manifester
 *                       level in.
 *                       DEFAULT: CLASS_TYPE_INVALID, which means the creature's
 *                       manifester level in regards to an ongoing manifestation
 *                       is determined instead.
 * @return               The manifester level
 */
int GetManifesterLevel(object oManifester, int nSpecificClass = CLASS_TYPE_INVALID);

/**
 * Determines the given creature's highest undmodified manifester level among it's
 * manifesting classes.
 *
 * @param oCreature Creature whose highest manifester level to determine
 * @return          The highest unmodified manifester level the creature can have
 */
int GetHighestManifesterLevel(object oCreature);

/**
 * Gets the level of the power being currently manifested.
 * WARNING: Return value is not defined when a power is not being manifested.
 *
 * @param oManifester The creature currently manifesting a power
 * @return            The level of the power being manifested
 */
int GetPowerLevel(object oManifester);

/**
 * Determines a creature's ability score in the manifesting ability of a given
 * class.
 *
 * @param oManifester Creature whose ability score to get
 * @param nClass      CLASS_TYPE_* constant of a manifesting class
 */
int GetAbilityScoreOfClass(object oManifester, int nClass);

/**
 * Determines from what class's power list the currently being manifested
 * power is manifested from.
 *
 * @param oManifester A creature manifesting a power at this moment
 * @return            CLASS_TYPE_* constant of the class
 */
int GetManifestingClass(object oManifester = OBJECT_SELF);

/**
 * Determines the manifesting ability of a class.
 *
 * @param nClass CLASS_TYPE_* constant of the class to determine the manifesting stat of
 * @return       ABILITY_* of the manifesting stat. ABILITY_CHARISMA for non-manifester
 *               classes.
 */
int GetAbilityOfClass(int nClass);

/**
 * Determines which of the character's classes is their highest or first psionic
 * manifesting class, if any. This is the one which gains manifester level raise
 * benefits from prestige classes.
 *
 * @param oCreature Creature whose classes to test
 * @return          CLASS_TYPE_* of the first psionic manifesting class,
 *                  CLASS_TYPE_INVALID if the creature does not posses any.
 */
int GetPrimaryPsionicClass(object oCreature = OBJECT_SELF);

/**
 * Calculates how many manifester levels are gained by a given creature from
 * it's levels in prestige classes.
 *
 * @param oCreature Creature to calculate added manifester levels for
 * @return          The number of manifester levels gained
 */
int GetPsionicPRCLevels(object oCreature);

/**
 * Determines the position of a creature's first psionic manifesting class, if any.
 *
 * @param oCreature Creature whose classes to test
 * @return          The position of the first psionic class {1, 2, 3} or 0 if
 *                  the creature possesses no levels in psionic classes.
 */
int GetFirstPsionicClassPosition(object oCreature = OBJECT_SELF);

/**
 * Determines whether a given class is a psionic class or not. A psionic
 * class is defined as one that gives base manifesting.
 *
 * @param nClass CLASS_TYPE_* of the class to test
 * @return       TRUE if the class is a psionic class, FALSE otherwise
 */
int GetIsPsionicClass(int nClass);

/**
 * Gets the amount of manifester levels the given creature is Wild Surging by.
 *
 * @param oManifester The creature to test
 * @return            The number of manifester levels added by Wild Surge. 0 if
 *                    Wild Surge is not active.
 */
int GetWildSurge(object oManifester);

//////////////////////////////////////////////////
/*                  Includes                    */
//////////////////////////////////////////////////

#include "prc_inc_unarmed"
						
//////////////////////////////////////////////////
/*          Global Structures                   */
//////////////////////////////////////////////////

// These are used in psi_inc_psifunc and psi_inc_augment

/**
 * A structure that contains common data used during power manifestation.
 */
struct manifestation{
    /* Generic stuff */
    /// The creature manifesting the power
    object oManifester;
    /// Whether the manifestation is successfull or not
    int bCanManifest;
    /// How much Power Points the manifestation costs
    int nPPCost;
    /// How many psionic focus uses the manifester would have remaining at a particular point in the manifestation
    int nPsiFocUsesRemain;
    /// The creature's manifester level in regards to this power
    int nManifesterLevel;
    /// The power's spell ID
    int nSpellID;

    /* Augmentation */
    /// How many times the first augmentation option of the power is used
    int nTimesAugOptUsed_1;
    /// How many times the second augmentation option of the power is used
    int nTimesAugOptUsed_2;
    /// How many times the third augmentation option of the power is used
    int nTimesAugOptUsed_3;
    /// How many times the fourth augmentation option of the power is used
    int nTimesAugOptUsed_4;
    /// How many times the fifth augmentation option of the power is used
    int nTimesAugOptUsed_5;
    /// How many times the PP used for augmentation triggered the generic augmentation of the power
    int nTimesGenericAugUsed;

    /* Metapsionics */
    /// Whether Chain Power was used with this manifestation
    int bChain;
    /// Whether Empower Power was used with this manifestation
    int bEmpower;
    /// Whether Extend Power was used with this manifestation
    int bExtend;
    /// Whether Maximize Power was used with this manifestation
    int bMaximize;
    /// Whether Split Psionic Ray was used with this manifestation
    int bSplit;
    /// Whether Twin Power was used with this manifestation
    int bTwin;
    /// Whether Widen Power was used with this manifestation
    int bWiden;
    /// Whether Quicken Power was used with this manifestation
    int bQuicken;
};

//////////////////////////////////////////////////
/*             Function definitions             */
//////////////////////////////////////////////////



/*					Begin PSI FOCUS					*/
//////////////////////////////////////////////////////

int UsePsionicFocus(object oUser = OBJECT_SELF)
{
    int bToReturn = FALSE;
    // First, check if we have focus on
    if(GetLocalInt(oUser, PSIONIC_FOCUS))
    {
        SetLocalInt(oUser, "PsionicFocusUses", GetPsionicFocusUsesPerExpenditure(oUser) - 1);
        DelayCommand(0.5f, DeleteLocalInt(oUser, "PsionicFocusUses"));
        SendMessageToPCByStrRef(oUser, 16826414); // "You have used your Psionic Focus"

        bToReturn = TRUE;
    }
    // We don't. Check if there are uses remaining
    else if(GetLocalInt(oUser, "PsionicFocusUses"))
    {
        SetLocalInt(oUser, "PsionicFocusUses", GetLocalInt(oUser, "PsionicFocusUses") - 1);

        bToReturn = TRUE;
    }

    // Lose focus if it was used
    if(bToReturn) LosePsionicFocus(oUser);

    return bToReturn;
}

void GainPsionicFocus(object oGainee = OBJECT_SELF)
{
    SetLocalInt(oGainee, PSIONIC_FOCUS, TRUE);

    // Speed Of Thought
    if(GetHasFeat(FEAT_SPEED_OF_THOUGHT, oGainee))
    {
        // Check for heavy armor before adding the bonus now
        if(GetBaseAC(GetItemInSlot(INVENTORY_SLOT_CHEST, oGainee)) < 6)
            AssignCommand(oGainee, ActionCastSpellAtObject(SPELL_FEAT_SPEED_OF_THOUGHT_BONUS, oGainee, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

        // Schedule a script to remove the bonus should they equip heavy armor
        AddEventScript(oGainee, EVENT_ONPLAYEREQUIPITEM, "psi_spdfthgt_oeq", TRUE, FALSE);
        // Schedule another script to add the bonus back if the unequip the armor
        AddEventScript(oGainee, EVENT_ONPLAYERUNEQUIPITEM, "psi_spdfthgt_ueq", TRUE, FALSE);
    }
    // Psionic Dodge
    if(GetHasFeat(FEAT_PSIONIC_DODGE, oGainee))
        SetCompositeBonus(GetPCSkin(oGainee), "PsionicDodge", 1, ITEM_PROPERTY_AC_BONUS);
        
    //Strength of Two - Kalashtar racial feat
    if(GetHasFeat(FEAT_STRENGTH_OF_TWO, oGainee))
    {
        SetCompositeBonus(GetPCSkin(oGainee), "StrengthOfTwo", 1, ITEM_PROPERTY_SAVING_THROW_BONUS, SAVING_THROW_WILL);
    }
}

int GetPsionicFocusesAvailable(object oCreature = OBJECT_SELF)
{
    // If the creature has a psionic focus active, return the maximum
    if(GetLocalInt(oCreature, PSIONIC_FOCUS))
        return GetPsionicFocusUsesPerExpenditure(oCreature);
    // Otherwise, return the amount currently remaining
    else
        return GetLocalInt(oCreature, "PsionicFocusUses");
}

int GetPsionicFocusUsesPerExpenditure(object oCreature = OBJECT_SELF)
{
    int nFocusUses = 1;
    int i;
    for(i = FEAT_EPIC_PSIONIC_FOCUS_1; i <= FEAT_EPIC_PSIONIC_FOCUS_10; i++)
        if(GetHasFeat(i, oCreature)) nFocusUses++;

    return nFocusUses;
}

void LosePsionicFocus(object oLoser = OBJECT_SELF)
{
    // Only remove focus if it's present
    if(GetLocalInt(oLoser, PSIONIC_FOCUS))
    {
        SetLocalInt(oLoser, PSIONIC_FOCUS, FALSE);

        // Loss of Speed of Thought effects
        PRCRemoveSpellEffects(SPELL_FEAT_SPEED_OF_THOUGHT_BONUS, oLoser, oLoser);
        RemoveEventScript(oLoser, EVENT_ONPLAYEREQUIPITEM, "psi_spdfthgt_oeq", TRUE);
        RemoveEventScript(oLoser, EVENT_ONPLAYERUNEQUIPITEM, "psi_spdfthgt_ueq", TRUE);
        // Loss of Psionic Dodge effects
        SetCompositeBonus(GetPCSkin(oLoser), "PsionicDodge", 0, ITEM_PROPERTY_AC_BONUS);
        // Loss of Strength of Two effects
        SetCompositeBonus(GetPCSkin(oLoser), "StrengthOfTwo", 0, ITEM_PROPERTY_SAVING_THROW_BONUS, SAVING_THROW_WILL);

        // Inform oLoser about the event
        FloatingTextStrRefOnCreature(16826415, oLoser, FALSE); // "You have lost your Psionic Focus"
    }
}

int GetIsPsionicallyFocused(object oCreature = OBJECT_SELF)
{
    return GetLocalInt(oCreature, PSIONIC_FOCUS);
}

int GetPsionicFocusUsingFeatsActive(object oCreature = OBJECT_SELF)
{
    int nFeats;

    if(GetLocalInt(oCreature, "TalentedActive"))            nFeats++;
    if(GetLocalInt(oCreature, "PowerSpecializationActive")) nFeats++;
    if(GetLocalInt(oCreature, "PowerPenetrationActive"))    nFeats++;
    if(GetLocalInt(oCreature, "PsionicEndowmentActive"))    nFeats++;

    if(GetLocalInt(oCreature, METAPSIONIC_CHAIN_VAR))       nFeats++;
    if(GetLocalInt(oCreature, METAPSIONIC_EMPOWER_VAR))     nFeats++;
    if(GetLocalInt(oCreature, METAPSIONIC_EXTEND_VAR))      nFeats++;
    if(GetLocalInt(oCreature, METAPSIONIC_MAXIMIZE_VAR))    nFeats++;
    if(GetLocalInt(oCreature, METAPSIONIC_SPLIT_VAR))       nFeats++;
    if(GetLocalInt(oCreature, METAPSIONIC_TWIN_VAR))        nFeats++;
    if(GetLocalInt(oCreature, METAPSIONIC_WIDEN_VAR))       nFeats++;
    if(GetLocalInt(oCreature, METAPSIONIC_QUICKEN_VAR))     nFeats++;

    return nFeats;
}

//////////////////////////////////////////////////////
/*					END PSI FOCUS					*/
//////////////////////////////////////////////////////

int GetManifesterDC(object oManifester = OBJECT_SELF)
{
    int nClass = GetManifestingClass(oManifester);
    int nDC = 10;
    nDC += GetPowerLevel(oManifester);
    nDC += GetAbilityModifier(GetAbilityOfClass(nClass), oManifester);//(GetAbilityScoreOfClass(oManifester, nClass) - 10)/2;

    // Stuff that applies only to powers, not psi-like abilities goes inside
    if(!GetLocalInt(oManifester, PRC_IS_PSILIKE))
    {
        if (GetLocalInt(oManifester, "PsionicEndowmentActive") == TRUE && UsePsionicFocus(oManifester))
        {
            nDC += GetHasFeat(FEAT_GREATER_PSIONIC_ENDOWMENT, oManifester) ? 4 : 2;
        }
    }

    // Needed to do some adjustments here.
    object oTarget = PRCGetSpellTargetObject();

    // Other DC adjustments
    nDC += (GetLocalInt(oManifester, "PRC_SoulEater_HasDrained") && GetLevelByClass(CLASS_TYPE_SOUL_EATER, oManifester) >= 10) ? 2 : 0;
    // Closed Mind
    if(GetHasFeat(FEAT_CLOSED_MIND, oTarget)) nDC -= 2;
    // Strong Mind
    if(GetHasFeat(FEAT_STRONG_MIND, oTarget)) nDC -= 3;
    // Fist of Dal Quor
    if(GetLevelByClass(CLASS_TYPE_FIST_DAL_QUOR, oTarget) >= 4) nDC -= 2;


    return nDC;
}

int DisciplineToSpellSchool(int nDiscipline)
{
    int nSpellSchool = SPELL_SCHOOL_GENERAL;

    switch(nDiscipline)
    {
        case DISCIPLINE_CLAIRSENTIENCE:   nSpellSchool = SPELL_SCHOOL_DIVINATION;    break;
        case DISCIPLINE_METACREATIVITY:   nSpellSchool = SPELL_SCHOOL_CONJURATION;   break;
        case DISCIPLINE_PSYCHOKINESIS:    nSpellSchool = SPELL_SCHOOL_EVOCATION;     break;
        case DISCIPLINE_PSYCHOMETABOLISM: nSpellSchool = SPELL_SCHOOL_TRANSMUTATION; break;
        case DISCIPLINE_TELEPATHY:        nSpellSchool = SPELL_SCHOOL_ENCHANTMENT;   break;

        default: nSpellSchool = SPELL_SCHOOL_GENERAL; break;
    }

    return nSpellSchool;
}

int SpellSchoolToDiscipline(int nSpellSchool)
{
    int nDiscipline = DISCIPLINE_NONE;

    switch(nSpellSchool)
    {
        case SPELL_SCHOOL_GENERAL:       nDiscipline = DISCIPLINE_NONE;             break;
        case SPELL_SCHOOL_ABJURATION:    nDiscipline = DISCIPLINE_NONE;             break;
        case SPELL_SCHOOL_CONJURATION:   nDiscipline = DISCIPLINE_METACREATIVITY;   break;
        case SPELL_SCHOOL_DIVINATION:    nDiscipline = DISCIPLINE_CLAIRSENTIENCE;   break;
        case SPELL_SCHOOL_ENCHANTMENT:   nDiscipline = DISCIPLINE_TELEPATHY;        break;
        case SPELL_SCHOOL_EVOCATION:     nDiscipline = DISCIPLINE_PSYCHOKINESIS;    break;
        case SPELL_SCHOOL_ILLUSION:      nDiscipline = DISCIPLINE_NONE;             break;
        case SPELL_SCHOOL_NECROMANCY:    nDiscipline = DISCIPLINE_NONE;             break;
        case SPELL_SCHOOL_TRANSMUTATION: nDiscipline = DISCIPLINE_PSYCHOMETABOLISM; break;

        default: nDiscipline = DISCIPLINE_NONE;
    }

    return nDiscipline;
}

int GetPowerDiscipline(int nSpellID)
{
    string sSpellSchool = Get2DACache("spells", "School", nSpellID);//lookup_spell_school(nSpellID);
    int nDiscipline;

    if      (sSpellSchool == "A") nDiscipline = DISCIPLINE_NONE;
    else if (sSpellSchool == "C") nDiscipline = DISCIPLINE_METACREATIVITY;
    else if (sSpellSchool == "D") nDiscipline = DISCIPLINE_CLAIRSENTIENCE;
    else if (sSpellSchool == "E") nDiscipline = DISCIPLINE_TELEPATHY;
    else if (sSpellSchool == "V") nDiscipline = DISCIPLINE_PSYCHOKINESIS;
    else if (sSpellSchool == "I") nDiscipline = DISCIPLINE_NONE;
    else if (sSpellSchool == "N") nDiscipline = DISCIPLINE_NONE;
    else if (sSpellSchool == "T") nDiscipline = DISCIPLINE_PSYCHOMETABOLISM;
    else if (sSpellSchool == "G") nDiscipline = DISCIPLINE_PSYCHOPORTATION;

    return nDiscipline;
}

int GetIsTelepathyPower(int nSpellID = -1)
{
    if(nSpellID == -1) nSpellID = PRCGetSpellId();

    return GetPowerDiscipline(nSpellID) == DISCIPLINE_TELEPATHY;
}

int CheckPowerPrereqs(int nFeat, object oPC)
{
    // Having the power already automatically disqualifies one from taking it again
    if(GetHasFeat(nFeat, oPC))
    return FALSE;
    // We assume that the 2da is correctly formatted, and as such, a prereq slot only contains
    // data if the previous slots in order also contains data.
    // ie, no PREREQFEAT2 if PREREQFEAT1 is empty
    if(Get2DACache("feat", "PREREQFEAT1", nFeat) != "")
    {
        if(!GetHasFeat(StringToInt(Get2DACache("feat", "PREREQFEAT1", nFeat)), oPC))
        return FALSE;
        if(Get2DACache("feat", "PREREQFEAT2", nFeat) != ""
        && !GetHasFeat(StringToInt(Get2DACache("feat", "PREREQFEAT2", nFeat)), oPC))
        return FALSE;
    }

    if(Get2DACache("feat", "OrReqFeat0", nFeat) != "")
    {
        if(!GetHasFeat(StringToInt(Get2DACache("feat", "OrReqFeat0", nFeat)), oPC))
            return FALSE;
        if(Get2DACache("feat", "OrReqFeat1", nFeat) != "")
        {
            if(!GetHasFeat(StringToInt(Get2DACache("feat", "OrReqFeat1", nFeat)), oPC))
                return FALSE;
            if(Get2DACache("feat", "OrReqFeat2", nFeat) != "")
            {
                if(!GetHasFeat(StringToInt(Get2DACache("feat", "OrReqFeat2", nFeat)), oPC))
                    return FALSE;
                if(Get2DACache("feat", "OrReqFeat3", nFeat) != "")
                {
                    if(!GetHasFeat(StringToInt(Get2DACache("feat", "OrReqFeat3", nFeat)), oPC))
                        return FALSE;
                    if(Get2DACache("feat", "OrReqFeat4", nFeat) != "")
                    {
                        if(!GetHasFeat(StringToInt(Get2DACache("feat", "OrReqFeat4", nFeat)), oPC))
                            return FALSE;
    }   }   }   }   }

    //if youve reached this far then return TRUE
    return TRUE;
}

int GetPsiPenetration(object oManifester = OBJECT_SELF)
{
    int nPen = GetManifesterLevel(oManifester);

    // The stuff inside applies only to normal manifestation, not psi-like abilities
    if(!GetLocalInt(oManifester, PRC_IS_PSILIKE))
    {
        // Check for Power Pen feats being used
        if(GetLocalInt(oManifester, "PowerPenetrationActive") == TRUE && UsePsionicFocus(oManifester))
        {
            nPen += GetHasFeat(FEAT_GREATER_POWER_PENETRATION, oManifester) ? 8 : 4;
        }
    }

    return nPen;
}

int GetIsPsionicCharacter(object oCreature)
{
    return !!(GetLevelByClass(CLASS_TYPE_PSION,          oCreature) ||
              GetLevelByClass(CLASS_TYPE_PSYWAR,         oCreature) ||
              GetLevelByClass(CLASS_TYPE_WILDER,         oCreature) ||
              GetLevelByClass(CLASS_TYPE_FIST_OF_ZUOKEN, oCreature) ||
              GetLevelByClass(CLASS_TYPE_WARMIND,        oCreature) ||
              GetHasFeat(FEAT_WILD_TALENT,               oCreature) ||
              GetHasFeat(FEAT_NATPSIONIC_1,              oCreature) ||
              GetHasFeat(FEAT_NATPSIONIC_2,              oCreature) ||
              GetHasFeat(FEAT_NATPSIONIC_3,              oCreature)
              // Racial psionicity signifying feats go here
             );
}

void LocalCleanExtraFists(object oCreature)
{
    int iIsCWeap, iIsEquip;

    object oClean = GetFirstItemInInventory(oCreature);

    while (GetIsObjectValid(oClean))
    {
        iIsCWeap = GetIsPRCCreatureWeapon(oClean);

        iIsEquip = oClean == GetItemInSlot(INVENTORY_SLOT_CWEAPON_L) ||
                   oClean == GetItemInSlot(INVENTORY_SLOT_CWEAPON_R) ||
                   oClean == GetItemInSlot(INVENTORY_SLOT_CWEAPON_B);

        if (iIsCWeap && !iIsEquip)
        {
            DestroyObject(oClean);
        }

        oClean = GetNextItemInInventory(oCreature);
    }
}
object GetPsionicCreatureWeapon(object oCreature, string sResRef, int nInventorySlot, float fDuration)
{
    int bCreatedWeapon = FALSE;
    object oCWeapon = GetItemInSlot(nInventorySlot, oCreature);

    RemoveUnarmedAttackEffects(oCreature);
    // Make sure they can actually equip them
    UnarmedFeats(oCreature);

    // Determine if a creature weapon of the proper type already exists in the slot
    if(!GetIsObjectValid(oCWeapon)                                       ||
       GetStringUpperCase(GetTag(oCWeapon)) != GetStringUpperCase(sResRef) // Hack: The resref's and tags of the PRC creature weapons are the same
       )
    {
        if (GetHasItem(oCreature, sResRef))
        {
            oCWeapon = GetItemPossessedBy(oCreature, sResRef);
            SetIdentified(oCWeapon, TRUE);
            //AssignCommand(oCreature, ActionEquipItem(oCWeapon, INVENTORY_SLOT_CWEAPON_L));
            ForceEquip(oCreature, oCWeapon, nInventorySlot);
        }
        else
        {
            oCWeapon = CreateItemOnObject(sResRef, oCreature);
            SetIdentified(oCWeapon, TRUE);
            //AssignCommand(oCreature, ActionEquipItem(oCWeapon, INVENTORY_SLOT_CWEAPON_L));
            ForceEquip(oCreature, oCWeapon, nInventorySlot);
            bCreatedWeapon = TRUE;
        }
    }


    // Clean up the mess of extra fists made on taking first level.
    DelayCommand(6.0f, LocalCleanExtraFists(oCreature));

    // Weapon finesse or intuitive attack?
    SetLocalInt(oCreature, "UsingCreature", TRUE);
    ExecuteScript("prc_intuiatk", oCreature);
    DelayCommand(1.0f, DeleteLocalInt(oCreature, "UsingCreature"));

    // Add OnHitCast: Unique if necessary
    if(GetHasFeat(FEAT_REND, oCreature))
        IPSafeAddItemProperty(oCWeapon, ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER, 1), 0.0f, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, FALSE, FALSE);

    // This adds creature weapon finesse
    ApplyUnarmedAttackEffects(oCreature);

    // Destroy the weapon if it was created by this function
    if(bCreatedWeapon)
        DestroyObject(oCWeapon, (fDuration + 6.0));

    return oCWeapon;
}

int GetTargetSpecificChangesToDamage(object oTarget, object oManifester, int nDamage,
                                     int bIsHitPointDamage = TRUE, int bIsEnergyDamage = FALSE)
{
    // Greater Power Specialization - +2 damage on all HP-damaging powers when target is within 30ft
    if(bIsHitPointDamage                                                &&
       GetHasFeat(FEAT_GREATER_POWER_SPECIALIZATION, oManifester)       &&
       GetDistanceBetween(oTarget, oManifester) <= FeetToMeters(30.0f)
       )
            nDamage += 2;
    // Intellect Fortress - Halve damage dealt by powers that allow PR. Goes before DR (-like) reductions
    if(GetLocalInt(oTarget, "PRC_Power_IntellectFortress_Active")    &&
       Get2DACache("spells", "ItemImmunity", PRCGetSpellId()) == "1"
       )
        nDamage /= 2;
    // Mental Resistance - 3 damage less for all non-energy damage and ability damage
    if(GetHasFeat(FEAT_MENTAL_RESISTANCE, oTarget) && !bIsEnergyDamage)
        nDamage -= 3;

    // Reasonable return values only
    if(nDamage < 0) nDamage = 0;

    return nDamage;
}

int PracticedManifesting(object oManifester, int iManifestingClass, int iManifestingLevels)
{
    int nFeat;
    int iAdjustment = GetHitDice(oManifester) - iManifestingLevels;
    iAdjustment = iAdjustment > 4 ? 4 : iAdjustment < 0 ? 0 : iAdjustment;

    switch(iManifestingClass)
    {
        case CLASS_TYPE_PSION:          nFeat = FEAT_PRACTICED_MANIFESTER_PSION;          break;
        case CLASS_TYPE_PSYWAR:         nFeat = FEAT_PRACTICED_MANIFESTER_PSYWAR;         break;
        case CLASS_TYPE_WILDER:         nFeat = FEAT_PRACTICED_MANIFESTER_WILDER;         break;
        case CLASS_TYPE_WARMIND:        nFeat = FEAT_PRACTICED_MANIFESTER_WARMIND;        break;
        case CLASS_TYPE_FIST_OF_ZUOKEN: nFeat = FEAT_PRACTICED_MANIFESTER_FIST_OF_ZUOKEN; break;
        default: nFeat = -1;
    }

    if(GetHasFeat(nFeat, oManifester))
        return iAdjustment;

    return 0;
}

int GetManifesterLevel(object oManifester, int nSpecificClass = CLASS_TYPE_INVALID)
{
    int nLevel;
    int nAdjust = GetLocalInt(oManifester, PRC_CASTERLEVEL_ADJUSTMENT);

    // The function user needs to know the character's manifester level in a specific class
    // instead of whatever the character last manifested a power as
    if(nSpecificClass != CLASS_TYPE_INVALID)
    {
        if(GetIsPsionicClass(nSpecificClass))
        {
            nLevel = GetLevelByClass(nSpecificClass, oManifester);
            // Add levels from +ML PrCs only for the first manifesting class
            if(nSpecificClass == GetPrimaryPsionicClass(oManifester))
                nLevel += GetPsionicPRCLevels(oManifester);

            nLevel += PracticedManifesting(oManifester, nSpecificClass, nLevel); //gotta be the last one

            return nLevel + nAdjust;
        }
        // A character's manifester level gained from non-manifesting classes is always a nice, round zero
        else
            return 0;
    }

    // Item Spells
    if(GetItemPossessor(GetSpellCastItem()) == oManifester)
    {
        if(DEBUG) SendMessageToPC(oManifester, "Item casting at level " + IntToString(GetCasterLevel(oManifester)));

        return GetCasterLevel(oManifester) + nAdjust;
    }

    // For when you want to assign the caster level.
    else if(GetLocalInt(oManifester, PRC_CASTERLEVEL_OVERRIDE) != 0)
    {
        if(DEBUG) SendMessageToPC(oManifester, "Forced-level manifesting at level " + IntToString(GetCasterLevel(oManifester)));

        DelayCommand(1.0, DeleteLocalInt(oManifester, PRC_CASTERLEVEL_OVERRIDE));
        nLevel = GetLocalInt(oManifester, PRC_CASTERLEVEL_OVERRIDE);
    }
    else if(GetManifestingClass(oManifester) != CLASS_TYPE_INVALID)
    {
        //Gets the level of the manifesting class
        int nManifestingClass = GetManifestingClass(oManifester);
//        if(DEBUG) DoDebug("Manifesting class: " + IntToString(nManifestingClass), oManifester);
        nLevel = GetLevelByClass(nManifestingClass, oManifester);
        // Add levels from +ML PrCs only for the first manifesting class
        nLevel += nManifestingClass == GetPrimaryPsionicClass(oManifester) ? GetPsionicPRCLevels(oManifester) : 0;

        nLevel += PracticedManifesting(oManifester, nManifestingClass, nLevel); //gotta be the last one
//        if(DEBUG) DoDebug("Level gotten via GetLevelByClass: " + IntToString(nLevel), oManifester);
    }

    // If everything else fails, use the character's first class position
    if(nLevel == 0)
    {
        if(DEBUG)             DoDebug("Failed to get manifester level for creature " + DebugObject2Str(oManifester) + ", using first class slot");
        else WriteTimestampedLogEntry("Failed to get manifester level for creature " + DebugObject2Str(oManifester) + ", using first class slot");

        nLevel = GetLevelByPosition(1, oManifester);
    }


    // The bonuses inside only apply to normal manifestation
    if(!GetLocalInt(oManifester, PRC_IS_PSILIKE))
    {
        //Adding wild surge
        int nSurge = GetWildSurge(oManifester);
        if (nSurge > 0) nLevel += nSurge;

        // Adding overchannel
        int nOverchannel = GetLocalInt(oManifester, PRC_OVERCHANNEL);
        if(nOverchannel > 0) nLevel += nOverchannel;
    }

    nLevel += nAdjust;

    // This spam is technically no longer necessary once the manifester level getting mechanism has been confirmed to work
//    if(DEBUG) FloatingTextStringOnCreature("Manifester Level: " + IntToString(nLevel), oManifester, FALSE);

    return nLevel;
}

int GetHighestManifesterLevel(object oCreature)
{
    return max(max(GetClassByPosition(1, oCreature) != CLASS_TYPE_INVALID ? GetManifesterLevel(oCreature, GetClassByPosition(1, oCreature)) : 0,
                   GetClassByPosition(2, oCreature) != CLASS_TYPE_INVALID ? GetManifesterLevel(oCreature, GetClassByPosition(2, oCreature)) : 0
                   ),
               GetClassByPosition(3, oCreature) != CLASS_TYPE_INVALID ? GetManifesterLevel(oCreature, GetClassByPosition(3, oCreature)) : 0
               );
}
int GetPowerLevel(object oManifester)
{
    return GetLocalInt(oManifester, PRC_POWER_LEVEL);
}

int GetAbilityScoreOfClass(object oManifester, int nClass)
{
    return GetAbilityScore(oManifester, GetAbilityOfClass(nClass));
}

int GetManifestingClass(object oManifester = OBJECT_SELF)
{
    return GetLocalInt(oManifester, PRC_MANIFESTING_CLASS) - 1;
}

int GetAbilityOfClass(int nClass)
{
    switch(nClass)
    {
        case CLASS_TYPE_DIAMOND_DRAGON:
        case CLASS_TYPE_PSION:
            return ABILITY_INTELLIGENCE;
        case CLASS_TYPE_PSYWAR:
        case CLASS_TYPE_FIST_OF_ZUOKEN:
        case CLASS_TYPE_WARMIND:
            return ABILITY_WISDOM;
        case CLASS_TYPE_WILDER:
            return ABILITY_CHARISMA;
    }

    // Technically, never gets here but the compiler does not realise that
    return -1;
}

int GetPrimaryPsionicClass(object oCreature = OBJECT_SELF)
{
    int nClass;

    if(GetPRCSwitch(PRC_CASTERLEVEL_FIRST_CLASS_RULE))
    {
        int iPsionicPos = GetFirstPsionicClassPosition(oCreature);
        if (!iPsionicPos) return CLASS_TYPE_INVALID; // no Psionic casting class

        nClass = GetClassByPosition(iPsionicPos, oCreature);
    }
    else
    {
        int nClassLvl;
        int nClass1, nClass2, nClass3;
        int nClass1Lvl, nClass2Lvl, nClass3Lvl;

        nClass1 = GetClassByPosition(1, oCreature);
        nClass2 = GetClassByPosition(2, oCreature);
        nClass3 = GetClassByPosition(3, oCreature);
        if(GetIsPsionicClass(nClass1)) nClass1Lvl = GetLevelByClass(nClass1, oCreature);
        if(GetIsPsionicClass(nClass2)) nClass2Lvl = GetLevelByClass(nClass2, oCreature);
        if(GetIsPsionicClass(nClass3)) nClass3Lvl = GetLevelByClass(nClass3, oCreature);

        nClass = nClass1;
        nClassLvl = nClass1Lvl;
        if(nClass2Lvl > nClassLvl)
        {
            nClass = nClass2;
            nClassLvl = nClass2Lvl;
        }
        if(nClass3Lvl > nClassLvl)
        {
            nClass = nClass3;
            nClassLvl = nClass3Lvl;
        }
        if(nClassLvl == 0)
            nClass = CLASS_TYPE_INVALID;
    }

    return nClass;
}

int GetPsionicPRCLevels(object oCreature)
{
    int nLevel = 0;

    // Cerebremancer and Psychic Theurge add manifester levels on each level
    nLevel += GetLevelByClass(CLASS_TYPE_CEREBREMANCER, oCreature);
    nLevel += GetLevelByClass(CLASS_TYPE_PSYCHIC_THEURGE, oCreature);

    // No manifester level boost at level 1 and 10 for Thrallherd
    if(GetLevelByClass(CLASS_TYPE_THRALLHERD, oCreature))
    {
        nLevel += GetLevelByClass(CLASS_TYPE_THRALLHERD, oCreature) - 1;
        if(GetLevelByClass(CLASS_TYPE_THRALLHERD, oCreature) >= 10) nLevel -= 1;
    }
    // No manifester level boost at levels 2, 5 and 8 for Shadow Mind
    if(GetLevelByClass(CLASS_TYPE_SHADOWMIND, oCreature))
    {
        nLevel += GetLevelByClass(CLASS_TYPE_SHADOWMIND, oCreature);
        if(GetLevelByClass(CLASS_TYPE_SHADOWMIND, oCreature) >= 2) nLevel -= 1;
        if(GetLevelByClass(CLASS_TYPE_SHADOWMIND, oCreature) >= 5) nLevel -= 1;
        if(GetLevelByClass(CLASS_TYPE_SHADOWMIND, oCreature) >= 8) nLevel -= 1;
    }
    // No manifester level boost at level 1 and 6 for Iron Mind
    if(GetLevelByClass(CLASS_TYPE_IRONMIND, oCreature))
    {
        nLevel += GetLevelByClass(CLASS_TYPE_IRONMIND, oCreature) - 1;
        if(GetLevelByClass(CLASS_TYPE_IRONMIND, oCreature) >= 6) nLevel -= 1;
    }
    // No manifester level boost at level 1 and 6 for Diamond Dragon
    if(GetLevelByClass(CLASS_TYPE_DIAMOND_DRAGON, oCreature))
    {
        nLevel += GetLevelByClass(CLASS_TYPE_DIAMOND_DRAGON, oCreature) - 1;
        if(GetLevelByClass(CLASS_TYPE_DIAMOND_DRAGON, oCreature) >= 6) nLevel -= 1;
    }
    // No manifester level boost at level 1 for Sanctified Mind
    if(GetLevelByClass(CLASS_TYPE_SANCTIFIED_MIND, oCreature))
    {
        nLevel += GetLevelByClass(CLASS_TYPE_SANCTIFIED_MIND, oCreature) - 1;
    }

    return nLevel;
}

int GetFirstPsionicClassPosition(object oCreature = OBJECT_SELF)
{
    if (GetIsPsionicClass(GetClassByPosition(1, oCreature)))
        return 1;
    if (GetIsPsionicClass(GetClassByPosition(2, oCreature)))
        return 2;
    if (GetIsPsionicClass(GetClassByPosition(3, oCreature)))
        return 3;

    return 0;
}

int GetIsPsionicClass(int nClass)
{
    return (nClass==CLASS_TYPE_PSION
          || nClass==CLASS_TYPE_PSYWAR
          || nClass==CLASS_TYPE_WILDER
          || nClass==CLASS_TYPE_FIST_OF_ZUOKEN
          || nClass==CLASS_TYPE_WARMIND
            );
}

int GetWildSurge(object oManifester)
{
    int nWildSurge = GetLocalInt(oManifester, PRC_IS_PSILIKE) ?
                      0 :                                       // Wild Surge does not apply to psi-like abilities
                      GetLocalInt(oManifester, PRC_WILD_SURGE);

    if(DEBUG) DoDebug("GetWildSurge():\n"
                    + "oManifester = " + DebugObject2Str(oManifester) + "\n"
                    + "nWildSurge = " + IntToString(nWildSurge) + "\n"
                      );

    return nWildSurge;
}
