//::///////////////////////////////////////////////
//:: Tome of Battle Maneuver Hook File.
//:: tob_movehook.nss
//:://////////////////////////////////////////////
/*

    This file acts as a hub for all code that
    is hooked into the maneuver scripts for Tome of Battle

*/
//:://////////////////////////////////////////////
//:: Created By: Stratovarius
//:: Created On: 19-3-2007
//:://////////////////////////////////////////////

#include "prc_inc_spells"
#include "inc_utility"
#include "x2_inc_spellhook"

// This function holds all functions that are supposed to run before the actual
// spellscript gets run. If this functions returns FALSE, the spell is aborted
// and the spellscript will not run
int PreManeuverCastCode();


//------------------------------------------------------------------------------
// if FALSE is returned by this function, the spell will not be cast
// the order in which the functions are called here DOES MATTER, changing it
// WILL break the crafting subsystems
//------------------------------------------------------------------------------
int PreManeuverCastCode()
{
    object oInitiator = OBJECT_SELF;
    object oTarget = PRCGetSpellTargetObject();
    int nMoveId = PRCGetSpellId();
    int nContinue;

    DeleteLocalInt(oInitiator, "SpellConc");
    nContinue = !ExecuteScriptAndReturnInt("premovecode", oInitiator);

    //---------------------------------------------------------------------------
    // Run NullPsionicsField Check 
    //---------------------------------------------------------------------------
    if (nContinue && GetIsManeuverSupernatural(nMoveId))
        nContinue = NullPsionicsField();
    
    //---------------------------------------------------------------------------    
    // Swordsage Insightful Strike, grants wisdom to damage on maneuvers
    // Test and local to avoid spaghetti monster
    //---------------------------------------------------------------------------
    if (GetLevelByClass(CLASS_TYPE_SWORDSAGE, oInitiator) >= 4) 
    {
	if (GetHasInsightfulStrike(oInitiator)) SetLocalInt(oInitiator, "InsightfulStrike", TRUE);
	DelayCommand(2.0, DeleteLocalInt(oInitiator, "InsightfulStrike"));
    }        
    
    //---------------------------------------------------------------------------
    // Run Dark Discorporation Check
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = !GetLocalInt(oInitiator, "DarkDiscorporation");
        
    return nContinue;
}

