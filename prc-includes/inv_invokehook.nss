//::///////////////////////////////////////////////
//:: Invocation Hook File.
//:: inv_invokehook.nss
//:://////////////////////////////////////////////
/*

    This file acts as a hub for all code that
    is hooked into the invocation scripts

*/
//:://////////////////////////////////////////////
//:: Created By: Fox
//:: Created On: 25-1-2008
//:://////////////////////////////////////////////

#include "prc_inc_spells"
#include "inc_utility"
#include "x2_inc_spellhook"

// This function holds all functions that are supposed to run before the actual
// spellscript gets run. If this functions returns FALSE, the spell is aborted
// and the spellscript will not run
int PreInvocationCastCode();


//------------------------------------------------------------------------------
// if FALSE is returned by this function, the spell will not be cast
// the order in which the functions are called here DOES MATTER, changing it
// WILL break the crafting subsystems
//------------------------------------------------------------------------------
int PreInvocationCastCode()
{
    object oInvoker = OBJECT_SELF;
    object oTarget = PRCGetSpellTargetObject();
    int nInvokeId = PRCGetSpellId();
    int nContinue;

    DeleteLocalInt(oInvoker, "SpellConc");
    nContinue = !ExecuteScriptAndReturnInt("prespellcode", oInvoker);
    
    //---------------------------------------------------------------------------
    // This stuff is only interesting for player characters we assume that use
    // magic device always works and NPCs don't use the crafting feats or
    // sequencers anyway. Thus, any NON PC spellcaster always exits this script
    // with TRUE (unless they are DM possessed or in the Wild Magic Area in
    // Chapter 2 of Hordes of the Underdark.
    //---------------------------------------------------------------------------
    if(!GetIsPC(oInvoker)
    && !GetPRCSwitch(PRC_NPC_HAS_PC_SPELLCASTING))
    {
        if(!GetIsDMPossessed(oInvoker) && !GetLocalInt(GetArea(oInvoker), "X2_L_WILD_MAGIC"))
        {
            return TRUE;
        }
    }

    //---------------------------------------------------------------------------
    // Run Ectoplasmic Shambler Concentration Check
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = EShamConc();
        
    //---------------------------------------------------------------------------
    // Run Grappling Concentration Check
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = GrappleConc();          

    //---------------------------------------------------------------------------
    // Run NullPsionicsField Check
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = NullPsionicsField();
        
    //---------------------------------------------------------------------------
    // Run Scrying Check
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = Scrying();          

    if (nContinue)
    {
        //---------------------------------------------------------------------------
        // Run use magic device skill check
        //---------------------------------------------------------------------------
        nContinue = X2UseMagicDeviceCheck();
    }

    if (nContinue)
    {
        //-----------------------------------------------------------------------
        // run any user defined spellscript here
        //-----------------------------------------------------------------------
        nContinue = X2RunUserDefinedSpellScript();
    }

    //---------------------------------------------------------------------------
    // Check for the new restricted itemproperties
    //---------------------------------------------------------------------------
    if(nContinue
    && GetIsObjectValid(GetSpellCastItem())
    && !CheckPRCLimitations(GetSpellCastItem(), oInvoker))
    {
        SendMessageToPC(oInvoker, "You cannot use "+GetName(GetSpellCastItem()));
        nContinue = FALSE;
    }
    
    //Cleaning spell variables used for holding the charge
    if(!GetLocalInt(oInvoker, "PRC_SPELL_EVENT"))
    {
        DeleteLocalInt(oInvoker, "PRC_SPELL_CHARGE_COUNT");
        DeleteLocalInt(oInvoker, "PRC_SPELL_CHARGE_SPELLID");
        DeleteLocalObject(oInvoker, "PRC_SPELL_CONC_TARGET");
        DeleteLocalInt(oInvoker, "PRC_SPELL_METAMAGIC");
        DeleteLocalManifestation(oInvoker, "PRC_POWER_HOLD_MANIFESTATION");
    }
    else if(GetLocalInt(oInvoker, "PRC_SPELL_CHARGE_SPELLID") != nInvokeId)
    {   //Sanity check, in case something goes wrong with the action queue
        DeleteLocalInt(oInvoker, "PRC_SPELL_EVENT");
    }
    
    //---------------------------------------------------------------------------
    // Run Dark Discorporation Check
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = !GetLocalInt(oInvoker, "DarkDiscorporation");
        

    return nContinue;
}

