//::///////////////////////////////////////////////
//:: Turn undead include
//:: prc_inc_turning
//::///////////////////////////////////////////////
/** @file
    Defines functions that seem to have something
    to do with Turn Undead (and various other
    stuff).
*/
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////

//////////////////////////////////////////////////
/*             Function prototypes              */
//////////////////////////////////////////////////

//gets the number of class levels that count for turning
int GetTurningClassLevel(int bUndeadOnly = FALSE);

//this does the check and adjusts the highest HD of undead turned
int GetTurningCheckResult(int nLevel, int nChaMod);

//this creates the list of targets that are affected
//use the inc_target_list functions
void MakeTurningTargetList(int nTurningMaxHD, int nTurningTotalHD, int nTurnType);

//tests if the target can be turned by self
//includes race, domains, etc.
int GetCanTurn(object oTarget, int nTurnType);

//gets the equivalent HD total for turning purposes
//includes turn resistance and SR for outsiders
int GetHitDiceForTurning(object oTarget);

//the main turning function once targets have been listed
//routs to turn/destroy/rebuke/command as appropaite
void DoTurnAttempt(object oTarget, int nTurningMaxHD, int nLevel, int nTurnType);

int GetCommandedTotalHD();

//various sub-turning effect funcions

void DoTurn(object oTarget);
void DoDestroy(object oTarget);
void DoRebuke(object oTarget);
void DoCommand(object oTarget, int nLevel);

// This uses the turn type to determine whether the target should be turned or rebuked
// Used by Reptile, Air, Earth, Fire, Water, Spider domains
// Called from GetIsTurnNotRebuke
// TRUE = Turn
// FALSE = Rebuke
int GetTurnTargets(object oTarget, int nTurnType);

// What this does is check to see if there is an discrete word
// That matches the input, and if there is returns TRUE
int CheckTargetName(object oTarget, string sName);

//////////////////////////////////////////////////
/*                  Includes                    */
//////////////////////////////////////////////////

#include "prc_class_const"
#include "prc_feat_const"
#include "inc_utility"
#include "prc_inc_racial"

//////////////////////////////////////////////////
/*             Function definitions             */
//////////////////////////////////////////////////

//private function
//only used by DoTurnAttempt
//TRUE == Turn
//FALSE == Rebuke
int GetIsTurnNotRebuke(object oTarget, int nTurnType)
{
    // Dread Necro always rebukes or commands
    if(PRCGetLastSpellCastClass() == CLASS_TYPE_DREAD_NECROMANCER && nTurnType == SPELL_TURN_UNDEAD)
    {
    	return FALSE;
    }    
    if(MyPRCGetRacialType(oTarget) == RACIAL_TYPE_UNDEAD && nTurnType == SPELL_TURN_UNDEAD)
    {
        // Evil clerics rebuke undead, otherwise turn
        if(GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_EVIL)
        {
            return FALSE;
        }
    
    return TRUE;
    }
   
    else if (GetHasFeat(FEAT_EPIC_PLANAR_TURNING) && nTurnType == SPELL_TURN_UNDEAD && MyPRCGetRacialType(oTarget) == RACIAL_TYPE_OUTSIDER)
    {
        // Evil clerics turn non-evil outsiders, and rebuke evil outsiders
        if(GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_EVIL)
        {
            if(GetAlignmentGoodEvil(oTarget) == ALIGNMENT_EVIL) return FALSE;
            
            return TRUE;
        }  
        // Good clerics turn non-good outsiders, and rebuke good outsiders
    if(GetAlignmentGoodEvil(oTarget) == ALIGNMENT_GOOD) return FALSE;
        
    return TRUE;
    }
    else if(nTurnType == SPELL_TURN_BLIGHTSPAWNED)
    {
        // Rebuke/Command evil animals
        if(MyPRCGetRacialType(oTarget) == RACIAL_TYPE_ANIMAL && GetAlignmentGoodEvil(oTarget) == ALIGNMENT_EVIL)
        {
            return FALSE;
        }
        // Rebuke/Command blightspawned, either by tag from Blight touch
        // Or from having a Blightlord master
        if (GetTag(oTarget) == "prc_blightspawn" || GetLevelByClass(CLASS_TYPE_BLIGHTLORD, GetMaster(oTarget)) > 0)
        {
            return FALSE;
        }       
        // Rebuke/Command evil plants
        /*if(MyPRCGetRacialType(oTarget) == RACIAL_TYPE_PLANT && GetAlignmentGoodEvil(oTarget) == ALIGNMENT_EVIL)
        {
            return FALSE;
        }  */
    // This should never trigger, but oh well
    return TRUE;
    }
    // Slime domain rebukes or commands oozes
    else if(MyPRCGetRacialType(oTarget) == RACIAL_TYPE_OOZE && nTurnType == SPELL_TURN_OOZE)
    {
    	return FALSE;
    } 
    // Plant domain rebukes or commands plants
    /*else if(MyPRCGetRacialType(oTarget) == RACIAL_TYPE_PLANT && nTurnType == SPELL_TURN_PLANT)
    {
    return FALSE;
    }     */
    
    else if (nTurnType == SPELL_TURN_AIR)
    {
        if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_AIR ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_AIR_ELDER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_INVISIBLE_STALKER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_AIR ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_DUST ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_ICE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_AIR ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_WILL_O_WISP ||
            CheckTargetName(oTarget, "Air")) // This last one is to catch anything named with Air that doesnt use the appearances
            {
                return FALSE;
            }
            
        if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_EARTH ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_EARTH_ELDER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_GARGOYLE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_EARTH ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_SALT ||
            CheckTargetName(oTarget, "Earth")) // As above
            {
                return TRUE;
            }
            
        return TRUE;
    }
    else if (nTurnType == SPELL_TURN_EARTH)
    {
        if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_AIR ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_AIR_ELDER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_INVISIBLE_STALKER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_AIR ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_DUST ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_ICE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_WILL_O_WISP ||
            CheckTargetName(oTarget, "Air")) // This last one is to catch anything named with Air that doesnt use the appearances
            {
                return TRUE;
            }
            
        if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_EARTH ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_EARTH_ELDER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_GARGOYLE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_EARTH ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_SALT ||
            CheckTargetName(oTarget, "Earth")) // As above
            {
                return FALSE;
            }
            
        return TRUE;
    }
    else if (nTurnType == SPELL_TURN_FIRE)
    {
        if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_FIRE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_FIRE_ELDER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_AZER_MALE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_AZER_FEMALE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_GIANT_FIRE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_GIANT_FIRE_FEMALE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_FIRE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_MAGMA ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_STEAM ||
            CheckTargetName(oTarget, "Fire")) // This last one is to catch anything named with Fire that doesnt use the appearances
            {
                return FALSE;
            }
            
        if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_WATER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_WATER_ELDER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_WATER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_OOZE ||
            CheckTargetName(oTarget, "Water")) // As above
            {
                return TRUE;
            }
            
        return TRUE;
    }
    else if (nTurnType == SPELL_TURN_WATER)
    {
        if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_FIRE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_FIRE_ELDER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_AZER_MALE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_AZER_FEMALE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_GIANT_FIRE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_GIANT_FIRE_FEMALE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_FIRE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_MAGMA ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_STEAM ||
            CheckTargetName(oTarget, "Fire")) // This last one is to catch anything named with Fire that doesnt use the appearances
            {
                return TRUE;
            }
            
        if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_WATER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_WATER_ELDER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_WATER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_OOZE ||
            CheckTargetName(oTarget, "Water")) // As above
            {
                return FALSE;
            }
            
        return TRUE;
    }    
    else if (nTurnType == SPELL_TURN_REPTILE)
    {
        if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_KOBOLD_A ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_KOBOLD_B ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_KOBOLD_CHIEF_A ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_KOBOLD_CHIEF_B ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_KOBOLD_SHAMAN_A ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_KOBOLD_SHAMAN_B ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_LIZARDFOLK_A ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_LIZARDFOLK_B ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_LIZARDFOLK_WARRIOR_A ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_LIZARDFOLK_WARRIOR_B ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_LIZARDFOLK_SHAMAN_A ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_LIZARDFOLK_SHAMAN_B ||
            GetAppearanceType(oTarget) == 451 || // Trog
            GetAppearanceType(oTarget) == 452 || // Trog Warrior
            GetAppearanceType(oTarget) == 453 || // Trog Cleric
            CheckTargetName(oTarget, "Scale") ||
            CheckTargetName(oTarget, "Snake") ||
            CheckTargetName(oTarget, "Reptile")) // Reptilian names
            {
                return FALSE;
            }
    }
    else if (nTurnType == SPELL_TURN_SPIDER)
    {
        if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_SPIDER_DEMON ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_SPIDER_DIRE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_SPIDER_GIANT ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_SPIDER_SWORD ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_SPIDER_PHASE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_SPIDER_WRAITH ||
            CheckTargetName(oTarget, "Spider")) // Duh
            {
                return FALSE;
            }
    }   

    return TRUE;
}

void DoTurnAttempt(object oTarget, int nTurningMaxHD, int nLevel, int nTurnType)
{

    //signal the event
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

    //sun domain
        //destroys instead of turn/rebuke/command
        //useable once per day only
        if(GetLocalInt(OBJECT_SELF, "UsingSunDomain"))
        {
            DoDestroy(oTarget);
        }
        else
        {
            int nTargetHD = GetHitDiceForTurning(oTarget);
            if(GetIsTurnNotRebuke(oTarget, nTurnType))
            {
                //if half of level, destroy
                //otherwise turn
                if(nTargetHD < nLevel/2)    DoDestroy(oTarget);
                else                        DoTurn(oTarget);
            }
            else
            {
                //if half of level, command
                //otherwise rebuke
                if(nTargetHD < nLevel/2)    DoCommand(oTarget, nLevel);
                else                        DoRebuke(oTarget);
                int nCommandLevel = nLevel;
                if(GetHasFeat(FEAT_UNDEAD_MASTERY))
                    nCommandLevel *= 10;
                FloatingTextStringOnCreature("Currently commanding "
                    +IntToString(GetCommandedTotalHD())
                    +"HD out of "+IntToString(nCommandLevel)
                    +"HD.", OBJECT_SELF);
            }
        }

    // Check for Exalted Turning
    // take 3d6 damage if they do
    // Only works on undead
    if (GetHasFeat(FEAT_EXALTED_TURNING) && 
        GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_GOOD &&
        MyPRCGetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
    {
        effect eDamage = EffectDamage(d6(3), DAMAGE_TYPE_DIVINE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
    }
}

void DoTurn(object oTarget)
{
    //create the effect
    effect eTurn = EffectTurned();
    eTurn = EffectLinkEffects(eTurn, EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR));
    eTurn = EffectLinkEffects(eTurn, EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE));
    //apply the effect for 60 seconds
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTurn, oTarget, 60.0);
}

void DoDestroy(object oTarget)
{
    //create the effect
    //supernatural so it penetrates immunity to death
    effect eDestroy = SupernaturalEffect(EffectDeath());
    //apply the effect
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDestroy, oTarget);
}

void DoRebuke(object oTarget)
{
    //rebuke effect
    //The character is frozen in fear and can take no actions.
    //A cowering character takes a -2 penalty to Armor Class and loses
    //her Dexterity bonus (if any).
    //create the effect
    effect eRebuke = EffectEntangle(); //this removes dex bonus
    eRebuke = EffectLinkEffects(eRebuke, EffectACDecrease(2));
    eRebuke = EffectLinkEffects(eRebuke, EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR));
    eRebuke = EffectLinkEffects(eRebuke, EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE));
    //apply the effect for 60 seconds
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRebuke, oTarget, 60.0);
    //handle unable to take actions
    AssignCommand(oTarget, ClearAllActions());
    AssignCommand(oTarget, DelayCommand(60.0, SetCommandable(TRUE)));
    AssignCommand(oTarget, SetCommandable(FALSE));
}

void DoCommand(object oTarget, int nLevel)
{
    //Undead Mastery multiplies total HD by 10
    //non-undead have their HD score multiplied by 10 to compensate
    if(GetHasFeat(FEAT_UNDEAD_MASTERY))
        nLevel *= 10;

    int nCommandedTotalHD = GetCommandedTotalHD();

    int nTargetHD = GetHitDiceForTurning(oTarget);
    //undead mastery only applies to undead
    //so non-undead have thier HD multiplied by 10
    if(MyPRCGetRacialType(oTarget) != RACIAL_TYPE_UNDEAD
        && GetHasFeat(FEAT_UNDEAD_MASTERY))
        nTargetHD *= 10;

    if(nCommandedTotalHD + nTargetHD <= nLevel)
    {
        //create the effect
        //supernatural dominated vs cutscenedominated
        //supernatural will last over resting
        //Why not use both?
        effect eCommand2 = EffectDominated();
        effect eCommand = EffectCutsceneDominated();
        effect eLink = EffectLinkEffects(eCommand, eCommand2);
        eLink = SupernaturalEffect(eLink);
        effect eVFXCom = EffectVisualEffect(VFX_IMP_DOMINATE_S);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFXCom, oTarget);
    }
    //not enough commanding power left
    //rebuke instead
    else
        DoRebuke(oTarget);
}


void MakeTurningTargetList(int nTurningMaxHD, int nTurningTotalHD, int nTurnType)
{
    int nHDCount;
    int i = 1;
    object oTest = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, i);
    while(GetIsObjectValid(oTest)
        && GetDistanceToObject(oTest) < FeetToMeters(60.0)
        && nHDCount <= nTurningTotalHD)
    {
        int nTargetHD = GetHitDiceForTurning(oTest);
        if(GetCanTurn(oTest, nTurnType)
            && nTargetHD <= nTurningMaxHD
            && nHDCount+nTargetHD <= nTurningTotalHD)
        {
            AddToTargetList(oTest, OBJECT_SELF, INSERTION_BIAS_DISTANCE);
            nHDCount += nTargetHD;
        }

        //move to next test
        i++;
        oTest = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, i);
    }
}

int GetCanTurn(object oTarget, int nTurnType)
{
    //is not an enemy
    if(!spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE ,OBJECT_SELF))
        return FALSE;

    //already turned
//NOTE: At the moment this breaks down in "turning conflicts" where clerics try to
//turn each others undead. Fix later.
    if(GetHasSpellEffect(GetSpellId(), oTarget))
        return FALSE;

    if(MyPRCGetRacialType(oTarget) == RACIAL_TYPE_UNDEAD && nTurnType == SPELL_TURN_UNDEAD)
    {
    return TRUE;
    }
    else if (GetHasFeat(FEAT_EPIC_PLANAR_TURNING) && nTurnType == SPELL_TURN_UNDEAD && MyPRCGetRacialType(oTarget) == RACIAL_TYPE_OUTSIDER)
    {
        return TRUE;
    }
    else if(nTurnType == SPELL_TURN_BLIGHTSPAWNED)
    {
        // Rebuke/Command evil animals
        if(MyPRCGetRacialType(oTarget) == RACIAL_TYPE_ANIMAL && GetAlignmentGoodEvil(oTarget) == ALIGNMENT_EVIL)
        {
            return TRUE;
        }
        // Rebuke/Command blightspawned, either by tag from Blight touch
        // Or from having a Blightlord master
        if (GetTag(oTarget) == "prc_blightspawn" || GetLevelByClass(CLASS_TYPE_BLIGHTLORD, GetMaster(oTarget)) > 0)
        {
            return TRUE;
        }       
        // Rebuke/Command evil plants
        /*if(MyPRCGetRacialType(oTarget) == RACIAL_TYPE_PLANT && GetAlignmentGoodEvil(oTarget) == ALIGNMENT_EVIL)
        {
            return TRUE;
        }  */
    }
    // Slime domain rebukes or commands oozes
    else if(MyPRCGetRacialType(oTarget) == RACIAL_TYPE_OOZE && nTurnType == SPELL_TURN_OOZE)
    {
    return TRUE;
    }    
    // Plant domain rebukes or commands plants
    /*else if(MyPRCGetRacialType(oTarget) == RACIAL_TYPE_PLANT && nTurnType == SPELL_TURN_PLANT)
    {
    return TRUE;
    }     */
    
    else if (nTurnType == SPELL_TURN_AIR)
    {
        if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_AIR ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_AIR_ELDER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_INVISIBLE_STALKER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_AIR ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_DUST ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_ICE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_AIR ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_WILL_O_WISP ||
            CheckTargetName(oTarget, "Air")) // This last one is to catch anything named with Air that doesnt use the appearances
            {
                return TRUE;
            }
            
        if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_EARTH ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_EARTH_ELDER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_GARGOYLE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_EARTH ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_SALT ||
            CheckTargetName(oTarget, "Earth")) // As above
            {
                return TRUE;
            }
    }
    else if (nTurnType == SPELL_TURN_EARTH)
    {
        if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_AIR ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_AIR_ELDER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_INVISIBLE_STALKER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_AIR ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_DUST ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_ICE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_WILL_O_WISP ||
            CheckTargetName(oTarget, "Air")) // This last one is to catch anything named with Air that doesnt use the appearances
            {
                return TRUE;
            }
            
        if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_EARTH ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_EARTH_ELDER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_GARGOYLE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_EARTH ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_SALT ||
            CheckTargetName(oTarget, "Earth")) // As above
            {
                return TRUE;
            }
    }
    else if (nTurnType == SPELL_TURN_FIRE)
    {
        if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_FIRE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_FIRE_ELDER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_AZER_MALE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_AZER_FEMALE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_GIANT_FIRE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_GIANT_FIRE_FEMALE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_FIRE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_MAGMA ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_STEAM ||
            CheckTargetName(oTarget, "Fire")) // This last one is to catch anything named with Fire that doesnt use the appearances
            {
                return TRUE;
            }
            
        if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_WATER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_WATER_ELDER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_WATER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_OOZE ||
            CheckTargetName(oTarget, "Water")) // As above
            {
                return TRUE;
            }
    }
    else if (nTurnType == SPELL_TURN_WATER)
    {
        if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_FIRE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_FIRE_ELDER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_AZER_MALE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_AZER_FEMALE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_GIANT_FIRE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_GIANT_FIRE_FEMALE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_FIRE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_MAGMA ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_STEAM ||
            CheckTargetName(oTarget, "Fire")) // This last one is to catch anything named with Fire that doesnt use the appearances
            {
                return TRUE;
            }
            
        if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_WATER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_ELEMENTAL_WATER_ELDER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_WATER ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_MEPHIT_OOZE ||
            CheckTargetName(oTarget, "Water")) // As above
            {
                return TRUE;
            }
    }    
    else if (nTurnType == SPELL_TURN_REPTILE)
    {
        if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_KOBOLD_A ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_KOBOLD_B ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_KOBOLD_CHIEF_A ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_KOBOLD_CHIEF_B ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_KOBOLD_SHAMAN_A ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_KOBOLD_SHAMAN_B ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_LIZARDFOLK_A ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_LIZARDFOLK_B ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_LIZARDFOLK_WARRIOR_A ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_LIZARDFOLK_WARRIOR_B ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_LIZARDFOLK_SHAMAN_A ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_LIZARDFOLK_SHAMAN_B ||
            GetAppearanceType(oTarget) == 451 || // Trog
            GetAppearanceType(oTarget) == 452 || // Trog Warrior
            GetAppearanceType(oTarget) == 453 || // Trog Cleric
            CheckTargetName(oTarget, "Scale") ||
            CheckTargetName(oTarget, "Snake") ||
            CheckTargetName(oTarget, "Reptile")) // Reptilian names
            {
                return TRUE;
            }
    }
    else if (nTurnType == SPELL_TURN_SPIDER)
    {
        if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_SPIDER_DEMON ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_SPIDER_DIRE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_SPIDER_GIANT ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_SPIDER_SWORD ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_SPIDER_PHASE ||
            GetAppearanceType(oTarget) == APPEARANCE_TYPE_SPIDER_WRAITH ||
            CheckTargetName(oTarget, "Spider")) // Duh
            {
                return TRUE;
            }
    }

    return FALSE;
}

int GetTurningCheckResult(int nLevel, int nChaMod)
{
    int nScore = d20()+nChaMod;
    switch(nScore)
    {
        case  0:
            return nLevel-4;
        case  1:
        case  2:
        case  3:
            return nLevel-3;
        case  4:
        case  5:
        case  6:
            return nLevel-2;
        case  7:
        case  8:
        case  9:
            return nLevel-1;
        case 10:
        case 11:
        case 12:
            return nLevel;
        case 13:
        case 14:
        case 15:
            return nLevel+1;
        case 16:
        case 17:
        case 18:
            return nLevel+2;
        case 19:
        case 20:
        case 21:
            return nLevel+3;
        default:
            if(nScore < 0)
                return nLevel-4;
            else
                return nLevel+4;
    }
    //somethings gone wrong here
    return 0;
}

int GetTurningClassLevel(int bUndeadOnly = FALSE)
{
    int nLevel;
    //full classes
    nLevel += GetLevelByClass(CLASS_TYPE_CLERIC);
    nLevel += GetLevelByClass(CLASS_TYPE_TRUENECRO);
    nLevel += GetLevelByClass(CLASS_TYPE_SOLDIER_OF_LIGHT);
    nLevel += GetLevelByClass(CLASS_TYPE_MASTER_OF_SHROUDS);
    nLevel += GetLevelByClass(CLASS_TYPE_MORNINGLORD);

    //offset classes
    if(GetLevelByClass(CLASS_TYPE_PALADIN)-2>0)
        nLevel += GetLevelByClass(CLASS_TYPE_PALADIN)-2;
    if(GetLevelByClass(CLASS_TYPE_BLACKGUARD)-2>0)
        nLevel += GetLevelByClass(CLASS_TYPE_BLACKGUARD)-2;
    if(GetLevelByClass(CLASS_TYPE_HOSPITALER)-2>0)
        nLevel += GetLevelByClass(CLASS_TYPE_HOSPITALER)-2;
    if(GetLevelByClass(CLASS_TYPE_TEMPLAR)-3>0)
        nLevel += GetLevelByClass(CLASS_TYPE_TEMPLAR)-3;
    //not undead turning classes
    if(!bUndeadOnly)
    {
        nLevel += GetLevelByClass(CLASS_TYPE_JUDICATOR);
        nLevel += GetLevelByClass(CLASS_TYPE_DREAD_NECROMANCER);
        nLevel += GetLevelByClass(CLASS_TYPE_BLIGHTLORD);
        if(GetLevelByClass(CLASS_TYPE_ANTI_PALADIN)-3>0)
            nLevel += GetLevelByClass(CLASS_TYPE_ANTI_PALADIN)-3;
    }
    
    //Baelnorn adds all class levels.  Careful not to count double.
    if(GetLevelByClass(CLASS_TYPE_BAELNORN))
    {
        nLevel = GetHitDice(OBJECT_SELF);
    }    
    
    return nLevel;
}

int GetHitDiceForTurning(object oTarget)
{

    //Hit Dice
    int nHD = GetHitDice(oTarget);

    //Turn Resistance
    nHD += GetTurnResistanceHD(oTarget);

    //Outsiders get SR (halved if turner has planar turning)
    if(MyPRCGetRacialType(oTarget) == RACIAL_TYPE_OUTSIDER)
    {
        int nSR = PRCGetSpellResistance(oTarget, OBJECT_SELF);
        if(GetHasFeat(FEAT_EPIC_PLANAR_TURNING))
            nSR /= 2;
        nHD += nSR;
    }

    //return the total
    return nHD;
}

int GetCommandedTotalHD()
{
    int i = 1; // Changed variable declaration since GetAssociate starts indexing at 1.
    int nCommandedTotalHD;
    object oTest = GetAssociate(ASSOCIATE_TYPE_DOMINATED, OBJECT_SELF, i);
    object oOldTest = OBJECT_INVALID;
    while(GetIsObjectValid(oTest) && oTest != oOldTest)
    {
        if(PRCGetHasEffect(EFFECT_TYPE_DOMINATED, oTest)) 
        // Changed from GetHasSpellEffect because it was looking for Turn Undead spell attached to creature
        // instead of looking for the dominated effect.
        {
            int nTestHD = GetHitDiceForTurning(oTest);
            if(MyPRCGetRacialType(oTest) != RACIAL_TYPE_UNDEAD
                && GetHasFeat(FEAT_UNDEAD_MASTERY))
                nTestHD *= 10;
            nCommandedTotalHD += nTestHD;
        }
        i++;
        oOldTest = oTest;
        oTest = GetAssociate(ASSOCIATE_TYPE_DOMINATED, OBJECT_SELF, i);
    }
    return nCommandedTotalHD;
}

// TRUE = Turn
// FALSE = Rebuke
int GetTurnTargets(object oTarget, int nTurnType)
{
    return TRUE;
}

int CheckTargetName(object oTarget, string sName)
{
    // Make them both lowercase
    sName = GetStringLowerCase(sName);
    string sTargetName = GetStringLowerCase(GetName(oTarget));
    // Get the position first
    int nPos = FindSubString(sTargetName, sName);
    string sTest = GetSubString(GetName(oTarget), nPos, GetStringLength(sName));
    // If this all worked, sTest should equal sName
    if (sTest == sName) return TRUE;
    
    return FALSE;
}

// Test main
//void main(){}

