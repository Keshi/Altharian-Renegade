//::///////////////////////////////////////////////
//:: Name           PRC Death include
//:: FileName       prc_inc_death
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    When a creature dies, they are returned to 10HP.
    Each round they loose DAMAGE_FROM_BLEEDINGHP from bleeding.
    When they get to zero HP, they are really dead.
    
    Each TIME_BETWEEN_BLEEDING seconds they have a BLEED_TO_STABLE_CHANCE% chance to stabilise.
    Once stabilised, they recover HEAL_FROM_STABLEHP per TIME_BETWEEN_STABLE
    seconds and suffer DAMAGE_FROM_STABLE per TIME_BETWEEN_STABLE seconds
    
    Each round they have a STABLE_TO_BLEED_CHANCE% to start bleeding again.
    Each round they have a STABLE_TO_DISABLED_CHANCE% to become disabled again.
    
    Once disabled, they can only move at half speed.
    TO BE IMPLEMENTED: Strenuous activity puts them back to stable
    
    If they get back above 10HP, they recover.
*/
//:://////////////////////////////////////////////
//:: Created By: Primogenitor
//:: Created On: 20/05/06
//:://////////////////////////////////////////////

#include "inc_persist_loca"
#include "prc_inc_switch"

void DoDeadHB(object oPC, int nIsPC)
{
    if(!GetPRCSwitch(PRC_PNP_DEATH_ENABLE))
        return;
    //if its not valid, retry
    //most likely to be logged off PC
    if(!GetIsObjectValid(oPC))
            DelayCommand(1.0,
                DoDeadHB(oPC, nIsPC));

    int nHP = GetCurrentHitPoints(oPC);
    if(nHP > 10
        || (nHP > 0
            && GetLocalInt(oPC, "DeadDying") == 2))
    {
        //back to life via heal spell or similar
        FloatingTextStringOnCreature("* "+GetName(oPC)+" is no longer dying *", oPC, TRUE);
        //if less than max HP, remove the 10 free HP
        if(nHP < GetMaxHitPoints(oPC))
            ApplyEffectToObject(DURATION_TYPE_INSTANT,
                EffectDamage(10),
                oPC);
        //cleanup
        DeleteLocalInt(oPC, "DeadDying");
        DeleteLocalInt(oPC, "DeadStable");
        if(GetIsPC(oPC) && GetCutsceneMode(oPC))
        {
            SetCutsceneMode(oPC, FALSE);
            SetPlotFlag(oPC, FALSE);
        }
        SetCommandable(TRUE, oPC);
        if(GetPRCSwitch(PRC_PW_DEATH_TRACKING) && nIsPC)
            DeletePersistantLocalInt(oPC, "persist_dead");
        //do not continue pseudoHB
        return;
    }
    if(nHP <= 0)
    {
        //dead
        if(GetLocalInt(oPC, "DeadDying"))
        {
            //really dead at -10
            if(GetLocalInt(oPC, "DeadDying") == 1)
            {
                FloatingTextStringOnCreature("* "+GetName(oPC)+" died *", oPC, TRUE);
                SetLocalInt(oPC, "DeadDying", 2);
            }
            //PCs get an option to reload
            if(GetIsPC(oPC))
            {
                string sMessage;
                //not needed, panel title says "You are Dead."
                //sMessage += "You have died.\n";
                sMessage += "Press Respawn to return to the game, if you are brought back from the dead.\n";
                if(GetPCPublicCDKey(oPC) == "")
                    sMessage += "Alternatively, you may load a saved game.\n";
                PopUpDeathGUIPanel(oPC, TRUE, FALSE, 0, sMessage);
            }
            //do not cleanup
            DelayCommand(IntToFloat(GetPRCSwitch(PRC_DEATH_TIME_BETWEEN_DEATH)),
                DoDeadHB(oPC, nIsPC));
            return;
         }
    }
    //not dead, not alive; so bleed!

    effect ePause;
    ePause = EffectLinkEffects(EffectCutsceneParalyze(),
        EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION));
    ePause = SupernaturalEffect(ePause);

    //test for stability
    int nStable = GetLocalInt(oPC, "DeadStable");
    if(nStable == 2)
    {
        //disabled
        //continue pseudoHB
        effect eDisabled = SupernaturalEffect(EffectSlow());
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
            eDisabled,
            oPC,
            IntToFloat(GetPRCSwitch(PRC_DEATH_TIME_BETWEEN_DISABLED))+0.1);
        DelayCommand(IntToFloat(GetPRCSwitch(PRC_DEATH_TIME_BETWEEN_DISABLED)),
            DoDeadHB(oPC, nIsPC));
        return;
    }


    //play a voicesound
    int nVoice = -1;
    switch(Random(39))
    {
        case 0: nVoice = VOICE_CHAT_HEALME; break;
        case 1: nVoice = VOICE_CHAT_HEALME; break;
        case 2: nVoice = VOICE_CHAT_NEARDEATH; break;
        case 3: nVoice = VOICE_CHAT_HELP; break;
        case 4: nVoice = VOICE_CHAT_PAIN1; break;
        case 5: nVoice = VOICE_CHAT_PAIN2; break;
        case 6: nVoice = VOICE_CHAT_PAIN3; break;
        case 7: nVoice = VOICE_CHAT_PAIN1; break;
        case 8: nVoice = VOICE_CHAT_PAIN2; break;
        case 9: nVoice = VOICE_CHAT_PAIN3; break;
        case 10: nVoice = VOICE_CHAT_PAIN1; break;
        case 11: nVoice = VOICE_CHAT_PAIN2; break;
        case 12: nVoice = VOICE_CHAT_PAIN3; break;
        //rest of them dont play anything
    }
    if(nVoice != -1)
        DelayCommand(IntToFloat(Random(60))/10.0,
            PlayVoiceChat(nVoice, oPC));

    if(nStable == 1)
    {
        //small chance of becomming unstable
        if(Random(100) < GetPRCSwitch(PRC_DEATH_STABLE_TO_BLEED_CHANCE)
            && IntToFloat(GetPRCSwitch(PRC_DEATH_TIME_BETWEEN_BLEEDING)) > 0.0)
        {
            //become unstable
            FloatingTextStringOnCreature("* "+GetName(oPC)+" started bleeding again *", oPC, TRUE);
            DeleteLocalInt(oPC, "DeadStable");
            //continue pseudoHB
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                ePause,
                oPC,
                IntToFloat(GetPRCSwitch(PRC_DEATH_TIME_BETWEEN_BLEEDING))+0.1);
            DelayCommand(IntToFloat(GetPRCSwitch(PRC_DEATH_TIME_BETWEEN_BLEEDING)),
                DoDeadHB(oPC, nIsPC));
            return;
        }
        //small chance of becomming disabled
        if(Random(100) < GetPRCSwitch(PRC_DEATH_STABLE_TO_DISABLED_CHANCE)
            && IntToFloat(GetPRCSwitch(PRC_DEATH_TIME_BETWEEN_DISABLED)) > 0.0)
        {
            FloatingTextStringOnCreature("* "+GetName(oPC)+" regained conciousness *", oPC, TRUE);
            SetLocalInt(oPC, "DeadStable", 2);
            //give PC control back
            if(GetIsPC(oPC) && GetCutsceneMode(oPC))
            {
                SetCutsceneMode(oPC, FALSE);
                SetPlotFlag(oPC, FALSE);
            }
            SetCommandable(TRUE, oPC);
            //continue pseudoHB
            effect eDisabled = SupernaturalEffect(EffectSlow());
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                eDisabled,
                oPC,
                IntToFloat(GetPRCSwitch(PRC_DEATH_TIME_BETWEEN_DISABLED))+0.1);
            DelayCommand(IntToFloat(GetPRCSwitch(PRC_DEATH_TIME_BETWEEN_DISABLED)),
                DoDeadHB(oPC, nIsPC));
            return;
        }

        //is stable, gradually recover HP
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
            EffectHeal(GetPRCSwitch(PRC_DEATH_HEAL_FROM_STABLE)),
            oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
            EffectDamage(GetPRCSwitch(PRC_DEATH_DAMAGE_FROM_STABLE)),
            oPC);
        //continue pseudoHB
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
            ePause,
            oPC,
            IntToFloat(GetPRCSwitch(PRC_DEATH_TIME_BETWEEN_STABLE))+0.1);
        DelayCommand(IntToFloat(GetPRCSwitch(PRC_DEATH_TIME_BETWEEN_STABLE)),
            DoDeadHB(oPC, nIsPC));
        return;
    }

    //mark it as cutscene, nonplot
    //if not already
    if(GetIsPC(oPC) && !GetCutsceneMode(oPC))
    {
        SetCutsceneMode(oPC, TRUE);
        SetPlotFlag(oPC, FALSE);
    }

    if(Random(100) < GetPRCSwitch(PRC_DEATH_BLEED_TO_STABLE_CHANCE)
        && IntToFloat(GetPRCSwitch(PRC_DEATH_TIME_BETWEEN_STABLE)) > 0.0)
    {
        //become stable
        FloatingTextStringOnCreature("* "+GetName(oPC)+" stabilized *", oPC, TRUE);
        SetLocalInt(oPC, "DeadStable", TRUE);
        //continue pseudoHB
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
            ePause,
            oPC,
            IntToFloat(GetPRCSwitch(PRC_DEATH_TIME_BETWEEN_STABLE))+0.1);
        DelayCommand(IntToFloat(GetPRCSwitch(PRC_DEATH_TIME_BETWEEN_STABLE)),
            DoDeadHB(oPC, nIsPC));
        return;
    }
    //bleed a bit
    if(IntToFloat(GetPRCSwitch(PRC_DEATH_TIME_BETWEEN_BLEEDING)) > 0.0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
            EffectDamage(GetPRCSwitch(PRC_DEATH_DAMAGE_FROM_BLEEDING)),
            oPC);
        //continue pseudoHB
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
            ePause,
            oPC,
            IntToFloat(GetPRCSwitch(PRC_DEATH_TIME_BETWEEN_BLEEDING))+0.1);
        DelayCommand(IntToFloat(GetPRCSwitch(PRC_DEATH_TIME_BETWEEN_BLEEDING)),
            DoDeadHB(oPC, nIsPC));
    }
    else
    {
        //no bleed time, just die (again)
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10), oPC);
    }
}

void DoDied(object oPC, int nIsPC)
{
    if(!GetPRCSwitch(PRC_PNP_DEATH_ENABLE))
        return;
    //check it wasnt a real death
    if(!GetLocalInt(oPC, "DeadDying")
        && !GetLocalInt(oPC, "PRC_PNP_EfectDeathApplied"))
    {
        SetLocalInt(oPC, "DeadDying", 1);
        DelayCommand(0.01,
            ApplyEffectToObject(DURATION_TYPE_INSTANT,
                EffectResurrection(),
                oPC));
        DelayCommand(0.02,
            ApplyEffectToObject(DURATION_TYPE_INSTANT,
                EffectHeal(9),
                oPC));
        //play the dead animation
        AssignCommand(oPC,
            DelayCommand(0.03,
                PlayAnimation(ANIMATION_LOOPING_DEAD_BACK,
                    1.0,
                    4.0)));
        //mark it as cutscene, nonplot
        //if not already
        if(GetIsPC(oPC) && !GetCutsceneMode(oPC))
        {
            SetCutsceneMode(oPC, TRUE);
            SetPlotFlag(oPC, FALSE);
        }
        //start the pseudoHB
        float fDelay = IntToFloat(GetPRCSwitch(PRC_DEATH_TIME_BETWEEN_BLEEDING));
        if(fDelay < 4.0)
            fDelay = 4.0;
        AssignCommand(GetModule(),
            DelayCommand(fDelay,
                DoDeadHB(oPC, nIsPC)));
        //prevent any other commands
        SetCommandable(FALSE, oPC);
    }
}

int DoDeadHealingAI()
{
    if(!GetPRCSwitch(PRC_PNP_DEATH_ENABLE))
        return FALSE;
    object oDead;
    //test if you can heal stuff
    talent tHeal = GetCreatureTalentRandom(TALENT_CATEGORY_BENEFICIAL_HEALING_TOUCH);
    if(!GetIsTalentValid(tHeal))
        tHeal = GetCreatureTalentRandom(TALENT_CATEGORY_BENEFICIAL_HEALING_AREAEFFECT);
    if(GetIsTalentValid(tHeal))
    {
        //look for dying ones
        int i = 1;
        oDead = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE,
            OBJECT_SELF, i,
            CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND,
            CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
        while(GetIsObjectValid(oDead))
        {
            if(GetCurrentHitPoints(oDead) < 10
                && GetLocalInt(oDead, "DeadDying"))
            {
                break;
            }
            i++;
            oDead = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE,
                OBJECT_SELF, i,
                CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND,
                CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
        }
        if(GetIsObjectValid(oDead))
        {
            ClearAllActions();
            ActionUseTalentOnObject(tHeal, oDead);
            return TRUE;
        }
    }
    //now look for dead things
    oDead = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, FALSE,
        OBJECT_SELF, 1,
        CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND,
        CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    if(GetIsObjectValid(oDead))
    {
        if(GetHasSpell(SPELL_RESURRECTION))
        {
            ClearAllActions();
            ActionCastSpellAtObject(SPELL_RESURRECTION, oDead);
            return TRUE;
        }
        else if(GetHasSpell(SPELL_RAISE_DEAD))
        {
            ClearAllActions();
            ActionCastSpellAtObject(SPELL_RAISE_DEAD, oDead);
            return TRUE;
        }
    }
    return FALSE;
}
