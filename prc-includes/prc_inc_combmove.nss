//::///////////////////////////////////////////////
//:: Combat Maneuver include: 
//:: prc_inc_combmove
//::///////////////////////////////////////////////
/** @file
    Defines various functions and other stuff that
    do something related to the combat maneuvers

    Things:
    Grapple
    Trip
    Bullrush
    Charge
    Overrun

    @author Stratovarius
    @date   Created - 2008.4.20
*/
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////

//////////////////////////////////////////////////
/*                 Constants                    */
//////////////////////////////////////////////////

const int    GRAPPLE_ATTACK          = 1;
const int    GRAPPLE_OPPONENT_WEAPON = 2;
const int    GRAPPLE_ESCAPE          = 3;
const int    GRAPPLE_TOB_CRUSHING    = 4;

const int    DEBUG_BATTLE_SKILL = FALSE;

//////////////////////////////////////////////////
/*             Function prototypes              */
//////////////////////////////////////////////////

/**
 * Returns the total bonus to ability Checks for chosen ability
 *
 * @param oPC      The PC
 * @param nAbility The ability to check
 * @return         Total bonus
 */
int GetAbilityCheckBonus(object oPC, int nAbility);

/**
 * Marks a PC is charging for a round
 *
 * @param oPC      The PC
 */
void SetIsCharging(object oPC);

/**
 * Get whether a PC is charging for a round
 *
 * @param oPC      The PC
 * @return           TRUE or FALSE
 */
int GetIsCharging(object oPC);

/**
 * This will do a complete PnP charge attack
 * Only call EITHER Attack OR Bull Rush
 *
 * @param oPC           The PC
 * @param oTarget       The Target
 * @param nDoAttack     Do an attack at the end of a charge or not
 * @param nGenerateAoO  Does the movement generate an AoO
 * @param nDamage       A damage bonus on the charge
 * @param nDamageType   Damage type of the bonus.
 * @param nBullRush     Do a Bull Rush at the end of a charge
 * @param nExtraBonus   An extra bonus to grant the PC on the Bull rush
 * @param nBullAoO      Does the bull rush attempt generate an AoO
 * @param nMustFollow   Does the Bull rush require the pushing PC to follow the target
 * @param nAttack       Bonus to the attack roll // I forgot to add it before, I'm an idiot ok?
 * @param nPounce       FALSE for normal behaviour, TRUE to do a full attack at the end of a charge // Same comment as above
 *
 * @return              TRUE if the attack or Bull rush hits, else FALSE
 */
int DoCharge(object oPC, object oTarget, int nDoAttack = TRUE, int nGenerateAoO = TRUE, int nDamage = 0, int nDamageType = -1, int nBullRush = FALSE, int nExtraBonus = 0, int nBullAoO = TRUE, int nMustFollow = TRUE, int nAttack = 0, int nPounce = FALSE);

/**
 * This will do a complete PnP Bull rush
 *
 * @param oPC           The PC
 * @param oTarget       The Target
 * @param nExtraBonus   An extra bonus to grant the PC
 * @param nGenerateAoO  Does the Bull rush attempt generate an AoO
 * @param nMustFollow   Does the Bull rush require the pushing PC to follow the target
 *
 * @return              TRUE if the Bull rush succeeds, else FALSE
 */
int DoBullRush(object oPC, object oTarget, int nExtraBonus, int nGenerateAoO = TRUE, int nMustFollow = TRUE);

/**
 * This will do a complete PnP Trip
 *
 * @param oPC           The PC
 * @param oTarget       The Target
 * @param nExtraBonus   An extra bonus to grant the PC
 * @param nGenerateAoO  Does the Trip attempt generate an AoO
 * @param nCounterTrip  Can the target attempt a counter trip if you fail
 *
 * @return              TRUE if the Trip succeeds, else FALSE
 *                      It sets a local int known as TripDifference that is the amount you succeeded or failed by.
 */
int DoTrip(object oPC, object oTarget, int nExtraBonus, int nGenerateAoO = TRUE, int nCounterTrip = TRUE);

/**
 * Will take an int and transform it into one of the DAMAGE_BONUS constants (From 1 to 20).
 *
 * @param nCheck     Int to convert
 * @return           DAMAGE_BONUS_1 to DAMAGE_BONUS_20
 */
int GetIntToDamage(int nCheck);

/**
 * This will do a complete PnP Grapple
 *
 * @param oPC           The PC
 * @param oTarget       The Target
 * @param nExtraBonus   An extra bonus to grant the PC
 * @param nGenerateAoO  Does the Grapple attempt generate an AoO
 *
 * @return              TRUE if the Trip succeeds, else FALSE
 */
int DoGrapple(object oPC, object oTarget, int nExtraBonus, int nGenerateAoO = TRUE);

/**
 * Marks a target as grappled.
 *
 * @param oTarget           The Target
 */
void SetGrapple(object oTarget);

/**
 * Returns true or false if the creature is grappled.
 *
 * @param oTarget       Person to check
 *
 * @return              TRUE or FALSE
 */
int GetGrapple(object oTarget);

/**
 * Ends a grapple between the two creatures
 *
 * @param oPC               The PC
 * @param oTarget           The Target
 */
void EndGrapple(object oPC, object oTarget);

/**
 * The options that can be performed during a grapple.
 *
 * @param oPC           The PC
 * @param oTarget       The Target
 * @param nExtraBonus   An extra bonus to grant the PC
 * @param nSwitch       The options to use. One of:  GRAPPLE_ATTACK, GRAPPLE_OPPONENT_WEAPON, GRAPPLE_ESCAPE, GRAPPLE_TOB_CRUSHING
 *
 * @return              TRUE if the Trip succeeds, else FALSE
 */
void DoGrappleOptions(object oPC, object oTarget, int nExtraBonus, int nSwitch = -1);

/**
 * Returns true or false if the creature's right hand weapon is light
 *
 * @param oPC           Person to check
 *
 * @return              TRUE or FALSE
 */
int GetIsLightWeapon(object oPC);

/**
 * This will do a complete PnP Overrun. See tob_stdr_bldrrll for an example of how to use.
 * Overrun is part of a move action.
 *
 * @param oPC           The PC
 * @param oTarget       The Target
 * @param nExtraBonus   An extra bonus to grant the PC
 * @param nGenerateAoO  Does the Overrun attempt generate an AoO
 * @param nAvoid        Can the target avoid you
 * @param nCounterTrip  Can the target attempt a counter if you fail
 *
 * @return              TRUE if the Overrun succeeds, else FALSE
 *                      It sets a local int known as OverrunDifference that is the amount you succeeded or failed by.
 */
int DoOverrun(object oPC, object oTarget, int nGenerateAoO = TRUE, int nExtraBonus = 0, int nAvoid = TRUE, int nCounter = TRUE);

// * returns the size modifier for bullrush in spells
// * Bioware function renamed.
int PRCGetSizeModifier(object oCreature);

//////////////////////////////////////////////////
/*                  Includes                    */
//////////////////////////////////////////////////

#include "prc_inc_combat"

//////////////////////////////////////////////////
/*             Internal functions               */
//////////////////////////////////////////////////

void _DoBullRushKnockBack(object oTarget, object oPC, float fFeet)
{
            // Calculate how far the creature gets pushed
            float fDistance = FeetToMeters(fFeet);
            // Determine if they hit a wall on the way
            location lPC           = GetLocation(oPC);
            location lTargetOrigin = GetLocation(oTarget);
            vector vAngle          = AngleToVector(GetRelativeAngleBetweenLocations(lPC, lTargetOrigin));
            vector vTargetOrigin   = GetPosition(oTarget);
            vector vTarget         = vTargetOrigin + (vAngle * fDistance);

            if(!LineOfSightVector(vTargetOrigin, vTarget))
            {
                // Hit a wall, binary search for the wall
                float fEpsilon    = 1.0f;          // Search precision
                float fLowerBound = 0.0f;          // The lower search bound, initialise to 0
                float fUpperBound = fDistance;     // The upper search bound, initialise to the initial distance
                fDistance         = fDistance / 2; // The search position, set to middle of the range

                do{
                    // Create test vector for this iteration
                    vTarget = vTargetOrigin + (vAngle * fDistance);

                    // Determine which bound to move.
                    if(LineOfSightVector(vTargetOrigin, vTarget))
                        fLowerBound = fDistance;
                    else
                        fUpperBound = fDistance;

                    // Get the new middle point
                    fDistance = (fUpperBound + fLowerBound) / 2;
                }while(fabs(fUpperBound - fLowerBound) > fEpsilon);
            }

            // Create the final target vector
            vTarget = vTargetOrigin + (vAngle * fDistance);

            // Move the target
            location lTargetDestination = Location(GetArea(oTarget), vTarget, GetFacing(oTarget));
            AssignCommand(oTarget, ClearAllActions(TRUE));
            AssignCommand(oTarget, JumpToLocation(lTargetDestination));
}

int _DoGrappleCheck(object oPC, object oTarget, int nExtraBonus)
{
        // The basic modifiers
        int nSucceed = FALSE;
        int nPCStr = GetAbilityModifier(ABILITY_STRENGTH, oPC);
        int nTargetStr = GetAbilityModifier(ABILITY_STRENGTH, oTarget);
        int nPCBonus = PRCGetSizeModifier(oPC);
        int nTargetBonus = PRCGetSizeModifier(oTarget);
        // Other ability bonuses
        nPCBonus += GetAbilityCheckBonus(oPC, ABILITY_STRENGTH);
        // Extra bonus
        nPCBonus += nExtraBonus;

        //cant grapple incorporeal or ethereal things
        if((GetIsEthereal(oTarget) && !GetIsEthereal(oPC))
                || GetIsIncorporeal(oTarget))
        {
                FloatingTextStringOnCreature("You cannot grapple an Ethereal or Incorporeal creature",oPC, FALSE);
                return FALSE;
        }

        int nPCCheck = nPCStr + nPCBonus + d20();
        int nTargetCheck = nTargetStr + nTargetBonus + d20();
        // Now roll the ability check
        if (nPCCheck >= nTargetCheck)
        {
                return TRUE;
        }
        
        // Didn't grapple successfully
        return FALSE;
}

//////////////////////////////////////////////////
/*             Function definitions             */
//////////////////////////////////////////////////

int GetAbilityCheckBonus(object oPC, int nAbility)
{
        int nBonus = 0;
        if (nAbility == ABILITY_STRENGTH)
        {
                if (GetHasSpellEffect(MOVE_SD_STONEFOOT_STANCE, oPC)) nBonus += 2;
                if (GetHasSpellEffect(MOVE_SS_STEP_WIND,        oPC)) nBonus += 4;
                if (GetHasSpellEffect(MOVE_SD_ROOT_MOUNTAIN,    oPC)) nBonus += 10;
        }
        else if (nAbility == ABILITY_DEXTERITY)
        {
                if (GetHasSpellEffect(MOVE_SS_STEP_WIND,        oPC)) nBonus += 4;
        }
        if(DEBUG) DoDebug("GetAbilityCheckBonus: nBonus " + IntToString(nBonus));
        return nBonus;
}

void SetIsCharging(object oPC)
{
        SetLocalInt(oPC, "PCIsCharging", TRUE);
        // You count as having charged for the entire round
        DelayCommand(6.0, DeleteLocalInt(oPC, "PCIsCharging"));
}

int GetIsCharging(object oPC)
{
        return GetLocalInt(oPC, "PCIsCharging");
}

int DoCharge(object oPC, object oTarget, int nDoAttack = TRUE, int nGenerateAoO = TRUE, int nDamage = 0, int nDamageType = -1, int nBullRush = FALSE, int nExtraBonus = 0, int nBullAoO = TRUE, int nMustFollow = TRUE, int nAttack = 0, int nPounce = FALSE)
{
        if (!nGenerateAoO)
        {
                // Huge bonus to tumble to prevent AoOs from movement
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_TUMBLE, 50), oPC, 6.0);
        }
        // Return value
        int nSucceed = FALSE;
        float fDistance = GetDistanceBetweenLocations(GetLocation(oPC), GetLocation(oTarget));
        // PnP rules use feet, might as well convert it now.
        fDistance = MetersToFeet(fDistance);
        if(fDistance >= 10.0)
        {
                // Mark the PC as charging
                SetIsCharging(oPC);
                // These are the bonuses to attacks/AC on a charge
                effect eNone;
                effect eCharge = EffectLinkEffects(EffectAttackIncrease(2), EffectACDecrease(2));
                eCharge = EffectLinkEffects(eCharge, EffectMovementSpeedIncrease(99));
                eCharge = SupernaturalEffect(eCharge);
                SPApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCharge, oPC, 6.0);
                // Move to the target
                AssignCommand(oPC, ClearAllActions());
                AssignCommand(oPC, ActionMoveToObject(oTarget, TRUE));
                if (nDoAttack) // Perform the Attack
                {
                        int nDamage = 0;
                        // Checks for a White Raven Stance
                        // If it exists, +1 damage/initiator level
                        if (GetLocalInt(oPC, "LeadingTheCharge"))
                        {
                                nDamage += GetLocalInt(oPC, "LeadingTheCharge");
                        }
                        if (nDamageType == -1) // If the damage type isn't set
                        {
                                object oWeap = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
                                nDamageType = GetWeaponDamageType(oWeap);
                        }
                        if (nPounce) // Uses instant attack in order to make sure they all go off in the alloted period of time.
                          DelayCommand(0.0, PerformAttackRound(oTarget, oPC, eNone, 0.0, nAttack, nDamage, nDamageType, FALSE, "Charge Hit", "Charge Miss", FALSE, FALSE, TRUE));

                        //Gorebrute shifter option
                        else if(GetLocalInt(oPC, "ShifterGore"))
                        {
                            string sResRef = "prc_shftr_gore_";
                            int nSize = PRCGetCreatureSize(oPC);
                            if(GetHasFeat(FEAT_SHIFTER_SAVAGERY) && GetHasFeatEffect(FEAT_FRENZY, oTarget))
                                nSize += 2;
                            if(nSize > CREATURE_SIZE_COLOSSAL)
                                nSize = CREATURE_SIZE_COLOSSAL;
                            sResRef += GetAffixForSize(nSize);
                            object oHorns = CreateItemOnObject(sResRef, oPC);
                            DelayCommand(0.0, PerformAttack(oTarget, oPC, eNone, 0.0, nAttack, nDamage + (GetHitDice(oPC) / 4), DAMAGE_TYPE_PIERCING, "Horns Hit", "Horns Miss", FALSE, oHorns));
                            //Gorebrute Elite Knockdown
                            if(GetLocalInt(oTarget, "PRCCombat_StruckByAttack") && GetHasFeat(FEAT_GOREBRUTE_ELITE))
                            {
                                //Knockdown check
                                int nEnemyStr = d20() + GetAbilityModifier(ABILITY_STRENGTH, oTarget);
                                int nYourStr = d20() + GetAbilityModifier(ABILITY_STRENGTH, oPC);
                                SendMessageToPC(oPC, "Opposed Knockdown Check: Rolled " + IntToString(nYourStr) + " vs " + IntToString(nEnemyStr));
                                SendMessageToPC(oTarget, "Opposed Knockdown Check: Rolled " + IntToString(nEnemyStr) + " vs " + IntToString(nYourStr));
                                if(nYourStr > nEnemyStr) 
                                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oTarget, 6.0);
                            }
                            DestroyObject(oHorns);
                        }
                        //Razorclaw Elite shifted option
                        else if(GetLocalInt(oPC, "ShifterClaw"))
                        {
                            object oWeaponL = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oPC);
                            object oWeaponR = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oPC);
                            DelayCommand(0.0, PerformAttack(oTarget, oPC, eNone, 0.0, nAttack, nDamage, DAMAGE_TYPE_SLASHING, "Claw Hit", "Claw Miss", FALSE, oWeaponR, oWeaponL));
                            DelayCommand(0.0, PerformAttack(oTarget, oPC, eNone, 0.0, nAttack, nDamage, DAMAGE_TYPE_SLASHING, "Claw Hit", "Claw Miss", FALSE, oWeaponR, oWeaponL, 1));
                        }
                        else
                          DelayCommand(0.0, PerformAttack(oTarget, oPC, eNone, 0.0, nAttack, nDamage, nDamageType, "Charge Hit", "Charge Miss"));
                        // Local int set when Perform Attack hits
                        nSucceed = GetLocalInt(oTarget, "PRCCombat_StruckByAttack");
                }
                if (nBullRush)
                        nSucceed = DoBullRush(oPC, oTarget, nExtraBonus, nBullAoO, nMustFollow);
        }
        else
        {
                FloatingTextStringOnCreature("You are too close to charge " + GetName(oTarget), oPC);
        }  
        
        return nSucceed;
}

int DoBullRush(object oPC, object oTarget, int nExtraBonus, int nGenerateAoO = TRUE, int nMustFollow = TRUE)
{
        // The basic modifiers
        int nSucceed = FALSE;
        int nPCStr = GetAbilityModifier(ABILITY_STRENGTH, oPC);
        int nTargetStr = GetAbilityModifier(ABILITY_STRENGTH, oTarget);
        int nPCBonus = PRCGetSizeModifier(oPC);
        int nTargetBonus = PRCGetSizeModifier(oTarget);
        //Warblade Battle Skill bonus
        if (GetLevelByClass(CLASS_TYPE_WARBLADE, oPC) >= 11) 
        {
            nPCBonus += GetAbilityModifier(ABILITY_INTELLIGENCE, oPC);
            if (DEBUG_BATTLE_SKILL) DoDebug("Warblade Battle Skill Bull Rush bonus (attacker)");
        }
        if (GetLevelByClass(CLASS_TYPE_WARBLADE, oTarget) >= 11)
        {
            nTargetBonus += GetAbilityModifier(ABILITY_INTELLIGENCE, oTarget);
            if (DEBUG_BATTLE_SKILL) DoDebug("Warblade Battle Skill Bull Rush bonus (defender)");
        }
        effect eNone;
        // Get a +2 bonus for charging during a bullrush
        if (GetIsCharging(oPC)) nPCBonus += 2;
        // Other ability bonuses
        nPCBonus += GetAbilityCheckBonus(oPC, ABILITY_STRENGTH);
        // Extra bonus
        nPCBonus += nExtraBonus;
        // Do the AoO for moving into the enemy square
        if (nGenerateAoO)
        {
                location lTarget = GetLocation(oPC);
                // Use the function to get the closest creature as a target
                object oAreaTarget = MyFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_SMALL, lTarget, TRUE, OBJECT_TYPE_CREATURE);
                while(GetIsObjectValid(oAreaTarget))
                {
                    // All enemies in range get a free AoO shot
                    if(oAreaTarget != oPC && // Don't hit yourself
                       GetIsInMeleeRange(oPC, oAreaTarget) && // They must be in melee range
                       GetIsEnemy(oAreaTarget, oPC)) // Only enemies are going to take AoOs
                    {
                        // Perform the Attack
                        DelayCommand(0.0, PerformAttack(oAreaTarget, oPC, eNone, 0.0, 0, 0, 0, "Attack of Opportunity Hit", "Attack of Opportunity Miss"));
                    }

                //Select the next target within the spell shape.
                oAreaTarget = MyNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_SMALL, lTarget, TRUE, OBJECT_TYPE_CREATURE);
                }
        }
        int nPCCheck = nPCStr + nPCBonus + d20();
        int nTargetCheck = nTargetStr + nTargetBonus + d20();
        // Now roll the ability check
        if (nPCCheck >= nTargetCheck)
        {
                // Knock them back 5 feet
                float fFeet = 5.0;
                // For every 5 points greater, knock back an additional 5 feet.
                fFeet += 5.0 * ((nPCCheck - nTargetCheck) / 5);
                nSucceed = TRUE;
                _DoBullRushKnockBack(oTarget, oPC, fFeet);
                // If the PC has to keep pushing to knock back, move the PC along, 5 feet less
                if (nMustFollow) _DoBullRushKnockBack(oPC, oTarget, (fFeet - 5.0));
        }
        else
                FloatingTextStringOnCreature("You have failed your Bull Rush Attempt",oPC, FALSE);

        // Let people know if we made the hit or not
        return nSucceed;
}

int DoTrip(object oPC, object oTarget, int nExtraBonus, int nGenerateAoO = TRUE, int nCounterTrip = TRUE)
{
        // The basic modifiers
        int nSucceed = FALSE;
        int nPCStat, nTargetStat;
        // Use the higher of the two mods
        if (GetAbilityModifier(ABILITY_STRENGTH, oPC) > GetAbilityModifier(ABILITY_DEXTERITY, oPC))
                nPCStat = GetAbilityModifier(ABILITY_STRENGTH, oPC) + GetAbilityCheckBonus(oPC, ABILITY_STRENGTH);
        else
                nPCStat = GetAbilityModifier(ABILITY_DEXTERITY, oPC) + GetAbilityCheckBonus(oPC, ABILITY_DEXTERITY);
        // Use the higher of the two mods       
        if (GetAbilityModifier(ABILITY_STRENGTH, oTarget) > GetAbilityModifier(ABILITY_DEXTERITY, oTarget))
                nTargetStat = GetAbilityModifier(ABILITY_STRENGTH, oTarget) + GetAbilityCheckBonus(oTarget, ABILITY_STRENGTH);
        else
                nTargetStat = GetAbilityModifier(ABILITY_DEXTERITY, oTarget) + GetAbilityCheckBonus(oTarget, ABILITY_DEXTERITY);
        // Get mods for size
        int nPCBonus = PRCGetSizeModifier(oPC);
        int nTargetBonus = PRCGetSizeModifier(oTarget);
        //Warblade Battle Skill bonus
        if (GetLevelByClass(CLASS_TYPE_WARBLADE, oPC) >= 11) 
        {
            nPCBonus += GetAbilityModifier(ABILITY_INTELLIGENCE, oPC);
            if (DEBUG_BATTLE_SKILL) DoDebug("Warblade Battle Skill Trip bonus (attacker)");
        }
        if (GetLevelByClass(CLASS_TYPE_WARBLADE, oTarget) >= 11)
        {
            nTargetBonus += GetAbilityModifier(ABILITY_INTELLIGENCE, oTarget);
            if (DEBUG_BATTLE_SKILL) DoDebug("Warblade Battle Skill Trip bonus (defender)");
        }
        
        // Do the AoO for a trip attempt
        if (nGenerateAoO)
        {
                // Perform the Attack
                effect eNone;
                DelayCommand(0.0, PerformAttack(oTarget, oPC, eNone, 0.0, 0, 0, 0, "Attack of Opportunity Hit", "Attack of Opportunity Miss"));     
        }
        int nPCCheck = nPCStat + nPCBonus + nExtraBonus + d20();
        int nTargetCheck = nTargetStat + nTargetBonus + d20();
        // Now roll the ability check
        if (nPCCheck >= nTargetCheck)
        {
                FloatingTextStringOnCreature("You have succeeded on your Trip attempt",oPC, FALSE);
                // Knock em down
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(EffectKnockdown()), oTarget, 6.0);
                nSucceed = TRUE;
                SetLocalInt(oPC, "TripDifference", nPCCheck - nTargetCheck);
                DelayCommand(2.0, DeleteLocalInt(oPC, "TripDifference"));
        }
        else // If you fail, enemy gets a counter trip attempt, using Strength
        {
                nTargetStat = GetAbilityModifier(ABILITY_STRENGTH, oTarget) + GetAbilityCheckBonus(oTarget, ABILITY_STRENGTH);
                FloatingTextStringOnCreature("You have failed on your Trip attempt",oPC, FALSE);
                // Roll counter trip attempt
                nTargetCheck = nTargetStat + nTargetBonus + d20();
                nPCCheck = nPCStat + nPCBonus + d20();
                // If counters aren't allowed, don't knock em down
                // Its down here to allow the text message to go through
                if (nTargetCheck >= nPCCheck && nCounterTrip)
                {
                        // Knock em down
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(EffectKnockdown()), oPC, 6.0);
                }
                SetLocalInt(oPC, "TripDifference", nTargetCheck - nPCCheck);
                DelayCommand(2.0, DeleteLocalInt(oPC, "TripDifference"));
        }

        // Let people know if we made the hit or not
        return nSucceed;
}

int GetIntToDamage(int nCheck)
{
    int IntToDam = -1;

    if (nCheck == 1)
    {
        IntToDam = DAMAGE_BONUS_1;
    }
    else if (nCheck == 2)
    {
        IntToDam = DAMAGE_BONUS_2;
    }
    else if (nCheck == 3)
    {
        IntToDam = DAMAGE_BONUS_3;
    }
    else if (nCheck == 4)
    {
        IntToDam = DAMAGE_BONUS_4;
    }
    else if (nCheck == 5)
    {
        IntToDam = DAMAGE_BONUS_5;
    }
    else if (nCheck == 6)
    {
        IntToDam = DAMAGE_BONUS_6;
    }
    else if (nCheck == 7)
    {
        IntToDam = DAMAGE_BONUS_7;
    }
    else if (nCheck == 8)
    {
        IntToDam = DAMAGE_BONUS_8;
    }
    else if (nCheck == 9)
    {
        IntToDam = DAMAGE_BONUS_9;
    }
    else if (nCheck == 10)
    {
        IntToDam = DAMAGE_BONUS_10;
    }
    else if (nCheck == 11)
    {
        IntToDam = DAMAGE_BONUS_11;
    }
    else if (nCheck == 12)
    {
        IntToDam = DAMAGE_BONUS_12;
    }
    else if (nCheck == 13)
    {
        IntToDam = DAMAGE_BONUS_13;
    }
    else if (nCheck == 14)
    {
        IntToDam = DAMAGE_BONUS_14;
    }
    else if (nCheck == 15)
    {
        IntToDam = DAMAGE_BONUS_15;
    }
    else if (nCheck == 16)
    {
        IntToDam = DAMAGE_BONUS_16;
    }
    else if (nCheck == 17)
    {
        IntToDam = DAMAGE_BONUS_17;
    }
    else if (nCheck == 18)
    {
        IntToDam = DAMAGE_BONUS_18;
    }
    else if (nCheck == 19)
    {
        IntToDam = DAMAGE_BONUS_19;
    }
    else if (nCheck >= 20)
    {
        IntToDam = DAMAGE_BONUS_20;
    }

    return IntToDam;
}

int DoGrapple(object oPC, object oTarget, int nExtraBonus, int nGenerateAoO = TRUE)
{
        int nSucceed = FALSE;
        effect eNone;
        // Do the AoO for trying a grapple
        if (nGenerateAoO)
        {
                // Perform the Attack
                DelayCommand(0.0, PerformAttack(oTarget, oPC, eNone, 0.0, 0, 0, 0, "Attack of Opportunity Hit", "Attack of Opportunity Miss"));     

                if (GetLocalInt(oPC, "PRCCombat_StruckByAttack"))
                {
                        FloatingTextStringOnCreature("You have failed at your Grapple Attempt.",oPC, FALSE);
                        return FALSE;
                }
        }

        // Now roll the ability check
        if (_DoGrappleCheck(oPC, oTarget, nExtraBonus))
        {
                FloatingTextStringOnCreature("You have successfully grappled " + GetName(oTarget), oPC, FALSE);
                SetGrapple(oTarget);
                effect eHold = EffectCutsceneImmobilize();
                effect eEntangle = EffectVisualEffect(VFX_DUR_SPELLTURNING_R);
                effect eLink = EffectLinkEffects(eHold, eEntangle);
                //apply the effect
                SPApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, 9999.0);
                SPApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, 9999.0);
                nSucceed = TRUE;
        }
        else
                FloatingTextStringOnCreature("You have failed your Grapple Attempt",oPC, FALSE);

        // Let people know if we made the hit or not
        return nSucceed;
}

void SetGrapple(object oTarget)
{
        SetLocalInt(oTarget, "IsGrappled", TRUE);
}

int GetGrapple(object oTarget)
{
        return GetLocalInt(oTarget, "IsGrappled");
}

void EndGrapple(object oPC, object oTarget)
{
        DeleteLocalInt(oPC, "IsGrappled");
        DeleteLocalInt(oTarget, "IsGrappled");
        effect eBad = GetFirstEffect(oTarget);
        //Search for negative effects
        while(GetIsEffectValid(eBad))
        {
                int nInt = GetEffectSpellId(eBad);
                if (GetEffectType(eBad) == EFFECT_TYPE_CUTSCENEIMMOBILIZE)
                {
                        RemoveEffect(oTarget, eBad);
                }
                eBad = GetNextEffect(oTarget);
        }
        eBad = GetFirstEffect(oPC);
        //Search for negative effects
        while(GetIsEffectValid(eBad))
        {
                int nInt = GetEffectSpellId(eBad);
                if (GetEffectType(eBad) == EFFECT_TYPE_CUTSCENEIMMOBILIZE)
                {
                        RemoveEffect(oPC, eBad);
                }
                eBad = GetNextEffect(oPC);
        }
}

void DoGrappleOptions(object oPC, object oTarget, int nExtraBonus, int nSwitch = -1)
{
        effect eNone;

        if (nSwitch == -1 || GetGrapple(oPC) || GetGrapple(oTarget))
        {
                FloatingTextStringOnCreature("DoGrappleOptions: Error, invalid option passed to function",oPC, FALSE);
                return;
        }
        else if (nSwitch == GRAPPLE_ATTACK)
        {
                // Must be a light weapon, and succeed at the grapple check
                if (_DoGrappleCheck(oPC, oTarget, nExtraBonus) && GetIsLightWeapon(oPC))
                {
                        // Bonuses to attack in a grapple from stance
                        if (GetHasSpellEffect(MOVE_TC_WOLVERINE_STANCE, oPC))
                        {
                                int nDam = 0;
                                if (PRCGetCreatureSize(oTarget) > PRCGetCreatureSize(oPC)) nDam = 4;
                                DelayCommand(0.0, PerformAttack(oTarget, oPC, eNone, 0.0, 0, nDam, 0, "Wolverine Stance Hit", "Wolverine Stance Miss"));    
                        }
                        else
                        {
                                // Attack with a -4 penalty
                                DelayCommand(0.0, PerformAttack(oTarget, oPC, eNone, 0.0, -4, 0, 0, "Grapple Attack Hit", "Grapple Attack Miss"));  
                        }
                }
                else
                        FloatingTextStringOnCreature("You have failed your Grapple Attempt",oPC, FALSE);
        }
        else if (nSwitch == GRAPPLE_OPPONENT_WEAPON)
        {
                // Must be a light weapon, and succeed at the grapple check
                if (_DoGrappleCheck(oPC, oTarget, nExtraBonus) && GetIsLightWeapon(oTarget))
                {
                        // Attack with a -4 penalty
                        object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
                        DelayCommand(0.0, PerformAttack(oTarget, oPC, eNone, 0.0, -4, 0, 0, "Grapple Attack Hit", "Grapple Attack Miss", FALSE, oWeapon));  
                }
                else
                        FloatingTextStringOnCreature("You have failed your Grapple Attempt",oPC, FALSE);
        }
        else if (nSwitch == GRAPPLE_ESCAPE)
        {
                // Must be a light weapon, and succeed at the grapple check
                if (_DoGrappleCheck(oPC, oTarget, nExtraBonus))
                {
                        EndGrapple(oPC, oTarget);
                }
                else
                        FloatingTextStringOnCreature("You have failed your Grapple Attempt",oPC, FALSE);
        }
        else if (nSwitch == GRAPPLE_TOB_CRUSHING && GetHasSpellEffect(MOVE_SD_CRUSHING_WEIGHT, oPC))
        {
                // Constrict for 2d6 + 1.5 Strength
                if (_DoGrappleCheck(oPC, oTarget, nExtraBonus))
                {
                        int nDam = FloatToInt(d6(2) + (GetAbilityModifier(ABILITY_STRENGTH, oPC) * 1.5));
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDam), oTarget);
                }
                else
                        FloatingTextStringOnCreature("You have failed your Grapple Attempt",oPC, FALSE);
        }
}

int GetIsLightWeapon(object oPC)
{
        // You may use any weapon in a grapple with this stance.
        if (GetHasSpellEffect(MOVE_TC_WOLVERINE_STANCE, oPC)) return TRUE;
        int nSize   = PRCGetCreatureSize(oPC);
        object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
        int nWeaponSize = GetWeaponSize(oItem);
        // is the size appropriate for a light weapon?
        return (nWeaponSize < nSize);  
}

int DoOverrun(object oPC, object oTarget, int nGenerateAoO = TRUE, int nExtraBonus = 0, int nAvoid = TRUE, int nCounter = TRUE)
{
        if (!nGenerateAoO)
        {
                // Huge bonus to tumble to prevent AoOs from movement
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_TUMBLE, 50), oPC, 6.0);
        }
        // The basic modifiers
        int nSucceed = FALSE;
        int nPCStat, nTargetStat;
        // Use the higher of the two mods
        if (GetAbilityModifier(ABILITY_STRENGTH, oPC) > GetAbilityModifier(ABILITY_DEXTERITY, oPC))
                nPCStat = GetAbilityModifier(ABILITY_STRENGTH, oPC) + GetAbilityCheckBonus(oPC, ABILITY_STRENGTH);
        else
                nPCStat = GetAbilityModifier(ABILITY_DEXTERITY, oPC) + GetAbilityCheckBonus(oPC, ABILITY_DEXTERITY);
        // Use the higher of the two mods       
        if (GetAbilityModifier(ABILITY_STRENGTH, oTarget) > GetAbilityModifier(ABILITY_DEXTERITY, oTarget))
                nTargetStat = GetAbilityModifier(ABILITY_STRENGTH, oTarget) + GetAbilityCheckBonus(oTarget, ABILITY_STRENGTH);
        else
                nTargetStat = GetAbilityModifier(ABILITY_DEXTERITY, oTarget) + GetAbilityCheckBonus(oTarget, ABILITY_DEXTERITY);
        // Get mods for size
        int nPCBonus = PRCGetSizeModifier(oPC);
        int nTargetBonus = PRCGetSizeModifier(oTarget);
        //Warblade Battle Skill bonus
        if (GetLevelByClass(CLASS_TYPE_WARBLADE, oPC) >= 11) 
        {
            nPCBonus += GetAbilityModifier(ABILITY_INTELLIGENCE, oPC);
            if (DEBUG_BATTLE_SKILL) DoDebug("Warblade Battle Skill Overrun bonus (attacker)");
        }
        if (GetLevelByClass(CLASS_TYPE_WARBLADE, oTarget) >= 11)
        {
            nTargetBonus += GetAbilityModifier(ABILITY_INTELLIGENCE, oTarget);
            if (DEBUG_BATTLE_SKILL) DoDebug("Warblade Battle Skill Overrun bonus (defender)");
        }

        // Do the AoO for a trip attempt
        if (nGenerateAoO)
        {
                // Perform the Attack
                effect eNone;
                DelayCommand(0.0, PerformAttack(oTarget, oPC, eNone, 0.0, 0, 0, 0, "Attack of Opportunity Hit", "Attack of Opportunity Miss"));     
        }
        int nPCCheck = nPCStat + nPCBonus + nExtraBonus + d20();
        int nTargetCheck = nTargetStat + nTargetBonus + d20();

        // The target has the option to avoid. Smaller targets will avoid if allowed.
        if (nPCBonus > nTargetBonus && nAvoid)
        {
                FloatingTextStringOnCreature(GetName(oTarget) + " has successfully avoided you", oPC, FALSE);
                // You didn't knock down the target, but neither did it stop you. Keep on chugging.
                return TRUE;
        }
        // Now roll the ability check
        if (nPCCheck >= nTargetCheck)
        {
                FloatingTextStringOnCreature("You have succeeded on your Overrun attempt",oPC, FALSE);
                // Knock em down
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(EffectKnockdown()), oTarget, 6.0);
                nSucceed = TRUE;
                SetLocalInt(oPC, "OverrunDifference", nPCCheck - nTargetCheck);
                DeleteLocalInt(oPC, "OverrunDifference");
        }
        else // If you fail, enemy gets a counter Overrun attempt, using Strength
        {
                nTargetStat = GetAbilityModifier(ABILITY_STRENGTH, oTarget) + GetAbilityCheckBonus(oTarget, ABILITY_STRENGTH);
                FloatingTextStringOnCreature("You have failed on your Overrun attempt",oPC, FALSE);
                // Roll counter Overrun attempt
                nTargetCheck = nTargetStat + nTargetBonus + d20();
                nPCCheck = nPCStat + nPCBonus + d20();
                // If counters aren't allowed, don't knock em down
                // Its down here to allow the text message to go through
                if (nTargetCheck >= nPCCheck && nCounter)
                {
                        // Knock em down
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ExtraordinaryEffect(EffectKnockdown()), oPC, 6.0);
                }
                SetLocalInt(oPC, "OverrunDifference", nTargetCheck - nPCCheck);
                DelayCommand(2.0, DeleteLocalInt(oPC, "OverrunDifference"));
        }

        return nSucceed;
}

int PRCGetSizeModifier(object oCreature)
{
    int nSize = PRCGetCreatureSize(oCreature);

    //Powerful Build bonus
    if(GetHasFeat(FEAT_RACE_POWERFUL_BUILD, oCreature))
        nSize++;
    //Make sure it doesn't overflow
    if(nSize > CREATURE_SIZE_COLOSSAL) nSize = CREATURE_SIZE_COLOSSAL;
    int nModifier = 0;

    switch (nSize)
    {
    case CREATURE_SIZE_TINY: nModifier = -8;  break;
    case CREATURE_SIZE_SMALL: nModifier = -4; break;
    case CREATURE_SIZE_MEDIUM: nModifier = 0; break;
    case CREATURE_SIZE_LARGE: nModifier = 4;  break;
    case CREATURE_SIZE_HUGE: nModifier = 8;   break;
    case CREATURE_SIZE_GARGANTUAN: nModifier = 12;   break;
    case CREATURE_SIZE_COLOSSAL: nModifier = 16;   break;
    }
    return nModifier;
}
// Test main
//void main(){}