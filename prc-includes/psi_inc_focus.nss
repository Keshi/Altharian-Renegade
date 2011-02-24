//::///////////////////////////////////////////////
//:: Psionics include: Psionic Focus
//:: psi_inc_focus
//::///////////////////////////////////////////////
/** @file
    Defines functions for manipulating psionic
    focus.


    @author Ornedan
    @date   Created - 2005.11.10
 */
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////

//////////////////////////////////////////////////
/*                 Constants                    */
//////////////////////////////////////////////////

/// Internal constant
const string PSIONIC_FOCUS = "PRC_PsionicFocus";

//////////////////////////////////////////////////
/*             Function prototypes              */
//////////////////////////////////////////////////

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


//////////////////////////////////////////////////
/*                  Includes                    */
//////////////////////////////////////////////////

#include "psi_inc_psifunc"


//////////////////////////////////////////////////
/*             Function definitions             */
//////////////////////////////////////////////////


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

// Test main
//void main(){}
