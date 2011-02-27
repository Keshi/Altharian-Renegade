//::///////////////////////////////////////////////
//:: Storm of Vengeance: Heartbeat
//:: NW_S0_StormVenC.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creates an AOE that decimates the enemies of
    the cleric over a 30ft radius around the caster
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 8, 2001
//:://////////////////////////////////////////////

//:: modified by mr_bumpkin  Dec 4, 2003
//:: Elemental Damage note:  Only made the lightning aspect variable,  the acid aspect is always acid.
//:: the Lightning part seemed like the better of the 2 to go with because it accounts for more
//:: of the total damage than the acid does.

#include "prc_inc_spells"
#include "prc_add_spell_dc"
#include "wk_tools"


void main()
{
DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
SetLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR", SPELL_SCHOOL_CONJURATION);

    SetAllAoEInts(SPELL_STORM_OF_VENGEANCE,OBJECT_SELF, GetSpellSaveDC());

    //Declare major variables
    effect eStun = EffectStunned();
    effect eVisAcid = EffectVisualEffect(VFX_IMP_ACID_S);
    effect eVisElec = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    effect eVisStun = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eStun, eVisStun);
    eLink = EffectLinkEffects(eLink, eDur);
    float fDelay;
    object oCaster = GetAreaOfEffectCreator();
    int nMod = 3;
    int nVesper = GetVesper(oCaster);
    int nLevel = PRCGetCasterLevel(oCaster);
    if (nVesper >= 3)
      {
        nLevel = GetEffectiveCasterLevel(oCaster);
        if (nLevel > 10) nMod = nLevel/3;
      }
    int CasterLvl = nLevel;//PRCGetCasterLevel(GetAreaOfEffectCreator());
    int nPenetr = SPGetPenetrAOE(oCaster,CasterLvl);



    //Get first target in spell area
    object oTarget = GetFirstInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oTarget))
    {
        int nDamage  = d10(nMod*2) + ApplySpellBetrayalStrikeDamage(oTarget, OBJECT_SELF, FALSE);

    effect eElec = PRCEffectDamage(oTarget, nDamage, ChangedElementalDamage(GetAreaOfEffectCreator(), DAMAGE_TYPE_ELECTRICAL));

        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, GetAreaOfEffectCreator()))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), SPELL_STORM_OF_VENGEANCE));
            //Make an SR Check
            fDelay = PRCGetRandomDelay(0.5, 2.0);
            if(PRCDoResistSpell(GetAreaOfEffectCreator(), oTarget,nPenetr, fDelay) == 0)
            {
                int nDC = PRCGetSaveDC(oTarget,GetAreaOfEffectCreator());
                effect eAcid = PRCEffectDamage(oTarget, d10(nMod), DAMAGE_TYPE_ACID);

                //Make a saving throw check
                // * if the saving throw is made they still suffer acid damage.
                // * if they fail the saving throw, they suffer Electrical damage too
                if(PRCMySavingThrow(SAVING_THROW_REFLEX, oTarget, (nDC), SAVING_THROW_TYPE_ELECTRICITY, GetAreaOfEffectCreator(), fDelay))
                {
                    //Apply the VFX impact and effects
                    DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVisAcid, oTarget));
                    DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eAcid, oTarget));
                    if (d2()==1)
                    {
                        DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVisElec, oTarget));
                    }
                }
                else
                {
                    //Apply the VFX impact and effects
                    DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVisAcid, oTarget));
                    DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eAcid, oTarget));
                    //Apply the VFX impact and effects
                    DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVisElec, oTarget));
                    DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eElec, oTarget));
                    DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(2)));
                }
            }
         }
        //Get next target in spell area
        oTarget = GetNextInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE);
    }



DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
// Getting rid of the integer used to hold the spells spell school
}
