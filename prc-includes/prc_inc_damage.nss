//::///////////////////////////////////////////////
//:: Ability Damage application
//:: prc_inc_damage
//:://////////////////////////////////////////////


//////////////////////////////////////////////////
/* Internal constants                           */
//////////////////////////////////////////////////

const string VIRTUAL_ABILITY_SCORE   = "PRC_Virtual_Ability_Score_";
const string ABILITY_DAMAGE_SPECIALS = "PRC_Ability_Damage_Special_Effects_Flags";
const string ABILITY_DAMAGE_MONITOR  = "PRC_Ability_Monitor";
const int ABILITY_DAMAGE_EFFECT_PARALYZE  = 1;
const int ABILITY_DAMAGE_EFFECT_KNOCKDOWN = 2;

//////////////////////////////////////////////////
/* Function prototypes                          */
//////////////////////////////////////////////////

/**
 * Gets the amount of unhealable ability damage suffered by the creature to given ability
 *
 * @param oTarget          The creature whose unhealable ability damage to examine
 * @param nAbility         One of the ABILITY_* constants
 */
int GetUnhealableAbilityDamage(object oTarget, int nAbility);

/**
 * Removes the specified amount of normally unhealable ability damage from the target
 *
 * @param oTarget      The creature to restore
 * @param nAbility     Ability to restore, one of the ABILITY_* constants
 * @param nAmount      Amount to restore the ability by, should be > 0 for the function
 *                     to have any effect
 */
void RecoverUnhealableAbilityDamage(object oTarget, int nAbility, int nAmount);

/**
 * Applies the ability damage to the given target. Handles the virtual loss of
 * ability scores below 3 and the effects of reaching 0 and making the damage
 * unhealable by standard means if requested.
 *
 *
 * @param oTarget          The creature about to take ability damage
 * @param nAbility         One of the ABILITY_* constants
 * @param nAmount          How much to reduce the ability score by
 * @param nDurationType    One of the DURATION_TYPE_* contants
 * @param bHealable        Whether the damage is healable by normal means or not.
 *                         Implemented by applying the damage as an iprop on the hide
 *
 * The following are passed to SPApplyEffectToObject:
 * @param fDuration        If temporary, the duration. If this is -1.0, the damage
 *                         will be applied so that it wears off at the rate of 1 point
 *                         per ingame day.
 * @param bDispellable     Is the effect dispellable? If FALSE, the system will delay
 *                         the application of the effect a short moment (10ms) to break
 *                         spellID association. This will make effects from the same
 *                         source stack with themselves.
 * @param nSpellID         ID of spell causing damage
 * @param nCasterLevel     Casterlevel of the effect being applied
 * @param oSource          Object causing the ability damage
 */
void ApplyAbilityDamage(object oTarget, int nAbility, int nAmount, int nDurationType, int bHealable = TRUE,
                        float fDuration = 0.0f, int bDispellable = FALSE, int nSpellID = -1, int nCasterLevel = -1, object oSource = OBJECT_SELF);

/**
 * Sets the values of ability decrease on target's hide to be the same as the value
 * tracked on the target object itself. This is called with delay from ScrubPCSkin()
 * in order to synchronise the tracked value of unhealable damage with that actually
 * present on the hide.
 * Please call this if you do similar operations on the hide.
 *
 * @param oTarget The creature whose hide and tracked value to synchronise.
 */
void ReApplyUnhealableAbilityDamage(object oTarget);

//////////////////////////////////////////////////
/*                  Includes                    */
//////////////////////////////////////////////////

//#include "prc_inc_racial"
#include "prc_effect_inc"
#include "inc_item_props"
						
//////////////////////////////////////////////////
/* Function defintions                          */
//////////////////////////////////////////////////


void ApplyAbilityDamage(object oTarget, int nAbility, int nAmount, int nDurationType, int bHealable = TRUE,
                        float fDuration = 0.0f, int bDispellable = FALSE, int nSpellID = -1, int nCasterLevel = -1, object oSource = OBJECT_SELF)
{
    // Immunity check
    if(GetIsImmune(oTarget, IMMUNITY_TYPE_ABILITY_DECREASE, oSource))
        return;

    // Get the value of the stat before anything is done
    int nStartingValue = GetAbilityScore(oTarget, nAbility);

    // First, apply the whole damage as an effect
    //SendMessageToPC(GetFirstPC(), "Applying " + IntToString(nAmount) + " damage to stat " + IntToString(nAbility));
    if(bHealable)
    {
        // Is the damage temporary and specified to heal at the PnP rate
        if(nDurationType == DURATION_TYPE_TEMPORARY && fDuration == -1.0f)
        {
            int i;
            for(i = 1; i <= nAmount; i++)
                DelayCommand(0.01f, SPApplyEffectToObject(nDurationType, bDispellable ?
                                                                          EffectAbilityDecrease(nAbility, 1) :
                                                                          SupernaturalEffect(EffectAbilityDecrease(nAbility, 1)),
                                                          oTarget, HoursToSeconds(24) * i, bDispellable, nSpellID, nCasterLevel, oSource));
        }
        else if(!bDispellable)
        {
            DelayCommand(0.01f, SPApplyEffectToObject(nDurationType, SupernaturalEffect(EffectAbilityDecrease(nAbility, nAmount)),
                                                      oTarget, fDuration, bDispellable, nSpellID, nCasterLevel, oSource));
        }
        else
        {
            SPApplyEffectToObject(nDurationType, EffectAbilityDecrease(nAbility, nAmount),
                                  oTarget, fDuration, bDispellable, nSpellID, nCasterLevel, oSource);
        }
    }
    // Non-healable damage
    else
    {
        int nIPType;
        int nTotalAmount;
        string sVarName = "PRC_UnhealableAbilityDamage_";
        switch(nAbility)
        {
            case ABILITY_STRENGTH:      nIPType = IP_CONST_ABILITY_STR; sVarName += "STR"; break;
            case ABILITY_DEXTERITY:     nIPType = IP_CONST_ABILITY_DEX; sVarName += "DEX"; break;
            case ABILITY_CONSTITUTION:  nIPType = IP_CONST_ABILITY_CON; sVarName += "CON"; break;
            case ABILITY_INTELLIGENCE:  nIPType = IP_CONST_ABILITY_INT; sVarName += "INT"; break;
            case ABILITY_WISDOM:        nIPType = IP_CONST_ABILITY_WIS; sVarName += "WIS"; break;
            case ABILITY_CHARISMA:      nIPType = IP_CONST_ABILITY_CHA; sVarName += "CHA"; break;

            default:
                WriteTimestampedLogEntry("Unknown nAbility passed to ApplyAbilityDamage: " + IntToString(nAbility));
                return;
        }

        // Sum the damage being added with damage that was present previously
        nTotalAmount = GetLocalInt(oTarget, sVarName) + nAmount;

        // Apply the damage
        SetCompositeBonus(GetPCSkin(oTarget), sVarName, nTotalAmount, ITEM_PROPERTY_DECREASED_ABILITY_SCORE, nIPType);

        // Also store the amount of damage on the PC itself so it can be restored at a later date.
        SetLocalInt(oTarget, sVarName, nTotalAmount);

        // Schedule recovering if the damage is temporary
        if(nDurationType == DURATION_TYPE_TEMPORARY)
        {
            // If the damage is specified to heal at the PnP rate, schedule one point to heal per day
            if(fDuration == -1.0f)
            {
                int i;
                for(i = 1; i <= nAmount; i++)
                    DelayCommand(HoursToSeconds(24) * i, RecoverUnhealableAbilityDamage(oTarget, nAbility, 1));
            }
            // Schedule everything to heal at once
            else
                DelayCommand(fDuration, RecoverUnhealableAbilityDamage(oTarget, nAbility, nAmount));
        }
    }

    // The system is off by default
    if(!GetPRCSwitch(PRC_PNP_ABILITY_DAMAGE_EFFECTS))
        return;

    // If the target is at the minimum supported by NWN, check if they have had their ability score reduced below already
    if(nStartingValue == 3)
        nStartingValue = GetLocalInt(oTarget, VIRTUAL_ABILITY_SCORE + IntToString(nAbility)) ?
                          GetLocalInt(oTarget, VIRTUAL_ABILITY_SCORE + IntToString(nAbility)) - 1 :
                          nStartingValue;

    // See if any of the damage goes into the virtual area of score < 3
    if(nStartingValue - nAmount < 3)
    {
        int nVirtual = nStartingValue - nAmount;
        if(nVirtual < 0) nVirtual = 0;

        // Mark the virtual value
        SetLocalInt(oTarget, VIRTUAL_ABILITY_SCORE + IntToString(nAbility), nVirtual + 1);

        // Cause effects for being at 0
        if(nVirtual == 0)
        {
            // Apply the effects
            switch(nAbility)
            {
                // Lying down
                case ABILITY_STRENGTH:
                case ABILITY_INTELLIGENCE:
                case ABILITY_WISDOM:
                case ABILITY_CHARISMA:
                    // Do not apply duplicate effects
                    /*if(!(GetLocalInt(oTarget, ABILITY_DAMAGE_SPECIALS) & ABILITY_DAMAGE_EFFECT_PARALYZE))
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneParalyze(), oTarget);*/
                    if(!(GetLocalInt(oTarget, ABILITY_DAMAGE_SPECIALS) & ABILITY_DAMAGE_EFFECT_KNOCKDOWN))
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oTarget, 9999.0f);
                        SetLocalInt(oTarget, ABILITY_DAMAGE_SPECIALS, GetLocalInt(oTarget, ABILITY_DAMAGE_SPECIALS) | ABILITY_DAMAGE_EFFECT_KNOCKDOWN);
                    }
                    //break;

                // Paralysis
                case ABILITY_DEXTERITY:
                    // Do not apply duplicate effects
                    if(!(GetLocalInt(oTarget, ABILITY_DAMAGE_SPECIALS) & ABILITY_DAMAGE_EFFECT_PARALYZE))
                    {
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneParalyze(), oTarget);
                        SetLocalInt(oTarget, ABILITY_DAMAGE_SPECIALS, GetLocalInt(oTarget, ABILITY_DAMAGE_SPECIALS) | ABILITY_DAMAGE_EFFECT_PARALYZE);
                    }
                    break;

                // Death
                case ABILITY_CONSTITUTION:
                    // Non-constitution score critters avoid this one
                    if(!(MyPRCGetRacialType(oTarget) == RACIAL_TYPE_UNDEAD ||
                         MyPRCGetRacialType(oTarget) == RACIAL_TYPE_CONSTRUCT
                      ) )
                      {
                            DeathlessFrenzyCheck(oTarget);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, SupernaturalEffect(EffectDeath()), oTarget);

                    }
                    break;

                default:
                    WriteTimestampedLogEntry("Unknown nAbility passed to ApplyAbilityDamage: " + IntToString(nAbility));
                    return;
            }

            // Start the monitor HB if it is not active yet
            if(GetThreadState(ABILITY_DAMAGE_MONITOR, oTarget) == THREAD_STATE_DEAD)
                SpawnNewThread(ABILITY_DAMAGE_MONITOR, "prc_abil_monitor", 1.0f, oTarget);

            // Note the ability score for monitoring
            SetLocalInt(oTarget, ABILITY_DAMAGE_MONITOR, GetLocalInt(oTarget, ABILITY_DAMAGE_MONITOR) | (1 << nAbility));
        }
    }
}

void ReApplyUnhealableAbilityDamage(object oTarget)
{
    object oSkin = GetPCSkin(oTarget);
    SetCompositeBonus(oSkin, "PRC_UnhealableAbilityDamage_STR",
                      GetLocalInt(oTarget, "PRC_UnhealableAbilityDamage_STR"),
                      ITEM_PROPERTY_DECREASED_ABILITY_SCORE, IP_CONST_ABILITY_STR);
    SetCompositeBonus(oSkin, "PRC_UnhealableAbilityDamage_DEX",
                      GetLocalInt(oTarget, "PRC_UnhealableAbilityDamage_DEX"),
                      ITEM_PROPERTY_DECREASED_ABILITY_SCORE, IP_CONST_ABILITY_DEX);
    SetCompositeBonus(oSkin, "PRC_UnhealableAbilityDamage_CON",
                      GetLocalInt(oTarget, "PRC_UnhealableAbilityDamage_CON"),
                      ITEM_PROPERTY_DECREASED_ABILITY_SCORE, IP_CONST_ABILITY_CON);
    SetCompositeBonus(oSkin, "PRC_UnhealableAbilityDamage_INT",
                      GetLocalInt(oTarget, "PRC_UnhealableAbilityDamage_INT"),
                      ITEM_PROPERTY_DECREASED_ABILITY_SCORE, IP_CONST_ABILITY_INT);
    SetCompositeBonus(oSkin, "PRC_UnhealableAbilityDamage_WIS",
                      GetLocalInt(oTarget, "PRC_UnhealableAbilityDamage_WIS"),
                      ITEM_PROPERTY_DECREASED_ABILITY_SCORE, IP_CONST_ABILITY_WIS);
    SetCompositeBonus(oSkin, "PRC_UnhealableAbilityDamage_CHA",
                      GetLocalInt(oTarget, "PRC_UnhealableAbilityDamage_CHA"),
                      ITEM_PROPERTY_DECREASED_ABILITY_SCORE, IP_CONST_ABILITY_CHA);
}

int GetUnhealableAbilityDamage(object oTarget, int nAbility)
{
    int nIPType;
    string sVarName = "PRC_UnhealableAbilityDamage_";
    switch(nAbility)
    {
        case ABILITY_STRENGTH:      sVarName += "STR"; break;
        case ABILITY_DEXTERITY:     sVarName += "DEX"; break;
        case ABILITY_CONSTITUTION:  sVarName += "CON"; break;
        case ABILITY_INTELLIGENCE:  sVarName += "INT"; break;
        case ABILITY_WISDOM:        sVarName += "WIS"; break;
        case ABILITY_CHARISMA:      sVarName += "CHA"; break;

        default:
            WriteTimestampedLogEntry("Unknown nAbility passed to GetUnhealableAbilityDamage: " + IntToString(nAbility));
            return FALSE;
    }

    return GetLocalInt(oTarget, sVarName);
}


void RecoverUnhealableAbilityDamage(object oTarget, int nAbility, int nAmount)
{
    // Sanity check, one should not be able to cause more damage via this function, ApplyAbilityDamage() is for that.
    if(nAmount < 0) return;

    int nIPType, nNewVal;
    string sVarName = "PRC_UnhealableAbilityDamage_";
    switch(nAbility)
    {
        case ABILITY_STRENGTH:      nIPType = IP_CONST_ABILITY_STR; sVarName += "STR"; break;
        case ABILITY_DEXTERITY:     nIPType = IP_CONST_ABILITY_DEX; sVarName += "DEX"; break;
        case ABILITY_CONSTITUTION:  nIPType = IP_CONST_ABILITY_CON; sVarName += "CON"; break;
        case ABILITY_INTELLIGENCE:  nIPType = IP_CONST_ABILITY_INT; sVarName += "INT"; break;
        case ABILITY_WISDOM:        nIPType = IP_CONST_ABILITY_WIS; sVarName += "WIS"; break;
        case ABILITY_CHARISMA:      nIPType = IP_CONST_ABILITY_CHA; sVarName += "CHA"; break;

        default:
            WriteTimestampedLogEntry("Unknown nAbility passed to ApplyAbilityDamage: " + IntToString(nAbility));
            return;
    }

    nNewVal = GetLocalInt(oTarget, sVarName) - nAmount;
    if(nNewVal < 0) nNewVal = 0;

    SetCompositeBonus(GetPCSkin(oTarget), sVarName, nNewVal, ITEM_PROPERTY_DECREASED_ABILITY_SCORE, nIPType);
    SetLocalInt(oTarget, sVarName, nNewVal);
}
