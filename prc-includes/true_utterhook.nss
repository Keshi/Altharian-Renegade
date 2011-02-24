//::///////////////////////////////////////////////
//:: Truenaming Utterance Hook File.
//:: true_utterhook.nss
//:://////////////////////////////////////////////
/*

    This file acts as a hub for all code that
    is hooked into the utterance scripts for Truenaming

*/
//:://////////////////////////////////////////////
//:: Created By: Stratovarius
//:: Created On: 17-7-2006
//:://////////////////////////////////////////////

#include "prc_x2_craft"
#include "x2_inc_spellhook"
#include "prc_inc_spells"
#include "inc_utility"
#include "prc_inc_itmrstr"


// This function holds all functions that are supposed to run before the actual
// spellscript gets run. If this functions returns FALSE, the spell is aborted
// and the spellscript will not run
int TruePreUtterCastCode();


//------------------------------------------------------------------------------
// if FALSE is returned by this function, the spell will not be cast
// the order in which the functions are called here DOES MATTER, changing it
// WILL break the crafting subsystems
//------------------------------------------------------------------------------
int TruePreUtterCastCode()
{
    object oTrueSpeaker = OBJECT_SELF;
    object oTarget = PRCGetSpellTargetObject();
    int nContinue;

    DeleteLocalInt(oTrueSpeaker, "SpellConc");
    nContinue = !ExecuteScriptAndReturnInt("prespellcode",oTrueSpeaker);

    //---------------------------------------------------------------------------
    // This stuff is only interesting for player characters we assume that use
    // magic device always works and NPCs don't use the crafting feats or
    // sequencers anyway. Thus, any NON PC spellcaster always exits this script
    // with TRUE (unless they are DM possessed or in the Wild Magic Area in
    // Chapter 2 of Hordes of the Underdark.
    //---------------------------------------------------------------------------
    if(!GetIsPC(oTrueSpeaker)
    && !GetPRCSwitch(PRC_NPC_HAS_PC_SPELLCASTING))
    {
        if(!GetIsDMPossessed(oTrueSpeaker) && !GetLocalInt(GetArea(oTrueSpeaker), "X2_L_WILD_MAGIC"))
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
    && !CheckPRCLimitations(GetSpellCastItem(), oTrueSpeaker))
    {
        SendMessageToPC(oTrueSpeaker, "You cannot use "+GetName(GetSpellCastItem()));
        nContinue = FALSE;
    }

    //---------------------------------------------------------------------------
    // The following code is only of interest if an item was targeted
    //---------------------------------------------------------------------------
    if (GetIsObjectValid(oTarget) && GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
    {

        //-----------------------------------------------------------------------
        // Check if spell was used to trigger item creation feat
        //-----------------------------------------------------------------------
        if (nContinue) {
            nContinue = !ExecuteScriptAndReturnInt("x2_pc_craft", oTrueSpeaker);
        }

        //-----------------------------------------------------------------------
        // * Execute item OnSpellCast At routing script if activated
        //-----------------------------------------------------------------------
        if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
        {
            SetUserDefinedItemEventNumber(X2_ITEM_EVENT_SPELLCAST_AT);
            int nRet = ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oTarget), oTrueSpeaker);
            if (nRet == X2_EXECUTE_SCRIPT_END)
            {
                return FALSE;
            }
        }

        //-----------------------------------------------------------------------
        // Prevent any spell that has no special coding to handle targetting of items
        // from being cast on items. We do this because we can not predict how
        // all the hundreds spells in NWN will react when cast on items
        //-----------------------------------------------------------------------
        if (nContinue) {
            nContinue = X2CastOnItemWasAllowed(oTarget);
        }
    }

    //Cleaning spell variables used for holding the charge
    if(!GetLocalInt(oTrueSpeaker, "PRC_SPELL_EVENT"))
    {
        DeleteLocalInt(oTrueSpeaker, "PRC_SPELL_CHARGE_COUNT");
        DeleteLocalInt(oTrueSpeaker, "PRC_SPELL_CHARGE_SPELLID");
        DeleteLocalObject(oTrueSpeaker, "PRC_SPELL_CONC_TARGET");
        DeleteLocalInt(oTrueSpeaker, "PRC_SPELL_METAMAGIC");
        DeleteLocalManifestation(oTrueSpeaker, "PRC_POWER_HOLD_MANIFESTATION");
    }
    else if(GetLocalInt(oTrueSpeaker, "PRC_SPELL_CHARGE_SPELLID") != PRCGetSpellId())
    {   //Sanity check, in case something goes wrong with the action queue
        DeleteLocalInt(oTrueSpeaker, "PRC_SPELL_EVENT");
    }
    
    //---------------------------------------------------------------------------
    // Run Dark Discorporation Check
    //---------------------------------------------------------------------------
    if (nContinue)
        nContinue = !GetLocalInt(oTrueSpeaker, "DarkDiscorporation");
        
    return nContinue;
}

