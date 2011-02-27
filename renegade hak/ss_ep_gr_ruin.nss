//::///////////////////////////////////////////////
//:: Greater Ruin
//:: X2_S2_Ruin
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
// The caster deals 35d6 damage to a single target
   fort save for half damage
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 18, 2002
//:://////////////////////////////////////////////

/*
    Altered by Boneshank, for purposes of the Epic Spellcasting project.
*/

#include "prc_alterations"
//#include "inc_dispel"
#include "inc_epicspells"
//altharian mods
#include "wk_tools"

void main()
{
    DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
    SetLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR", SPELL_SCHOOL_TRANSMUTATION);

    if (!X2PreSpellCastCode())
    {
        DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
        return;
    }
    if (GetCanCastSpell(OBJECT_SELF, SPELL_EPIC_GR_RUIN))
    {
        //Declare major variables
        object oTarget = PRCGetSpellTargetObject();
        int nStaff = GetMageStaff(OBJECT_SELF);
        int nDice = GetSkillRank(SKILL_SPELLCRAFT,OBJECT_SELF);
        int nSpellDC = GetEpicSpellSaveDC(OBJECT_SELF);
        int nLevel = GetCasterLevel(OBJECT_SELF);
        if (nStaff >= 3)
    {
        nLevel = GetEffectiveCasterLevel(OBJECT_SELF);
        nSpellDC = nSpellDC + (nLevel - 20)/5;
        nDice = nDice + (nLevel - 40) /4;
    }
        if (nDice < 35) nDice = 35;
    //end altharian mods

        float fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
        float fDelay = fDist/(3.0 * log(fDist) + 2.0);

        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, PRCGetSpellId()));
        //Roll damage
        int nDam = d6(nDice);
        //Set damage effect

        if (PRCMySavingThrow(SAVING_THROW_FORT,oTarget,GetEpicSpellSaveDC(OBJECT_SELF, oTarget),SAVING_THROW_TYPE_SPELL,OBJECT_SELF) != 0 )
        {
            nDam /=2;
                if (GetHasMettle(oTarget, SAVING_THROW_FORT))
                // This script does nothing if it has Mettle, bail
                    nDam = 0;
        }

        effect eDam = EffectDamage(nDam, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_PLUS_TWENTY);
        ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetLocation(oTarget));
        SPApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(487), oTarget);
        SPApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_BLOOD_CRT_RED), oTarget);
        SPApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_CHUNK_BONE_MEDIUM), oTarget);
        DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
    }
    DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
}