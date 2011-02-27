//::///////////////////////////////////////////////
//:: Negative Energy Burst
//:: NW_S0_NegBurst
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The caster releases a burst of negative energy
    at a specified point doing 1d8 + 1 / level
    negative energy damage
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 13, 2001
//:://////////////////////////////////////////////

//:: modified by mr_bumpkin Dec 4, 2003 for PRC stuff

//::Added code to maximize for Faith Healing and Blast Infidel
//::Aaon Graywolf - Jan 7, 2004

#include "prc_inc_spells"
#include "prc_add_spell_dc"
#include "prc_inc_function"
#include "wk_tools"

void main()
{
DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
SetLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR", SPELL_SCHOOL_NECROMANCY);
/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oCaster = OBJECT_SELF;
    int CasterLvl = PRCGetCasterLevel(oCaster);
    int nStaff = GetMageStaff(OBJECT_SELF);
    int nLevel;
    if (nStaff >= 3)        // Avanar's or Eternity's boost
    {
        nLevel = GetEffectiveCasterLevel(OBJECT_SELF);
        CasterLvl = nLevel;
        int nDmgDice = CasterLvl / 2;
    }
    int nDmgDice = CasterLvl / 2;

    int nMetaMagic = PRCGetMetaMagicFeat();
    int nDamage;
    int nAdditionalLevelDamage;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_LOS_EVIL_20); //Replace with Negative Pulse
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eVisHeal = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eDam, eHeal;
    int nStr = CasterLvl / 4;
    if (CasterLvl > 20){  nStr = ((nLevel - 20)/2 + 20); }
    if (nStr > 20) { nStr = 20; }
    if (nStr == 0)
    {
        nStr = 1;
    }
    nAdditionalLevelDamage = CasterLvl;
/*    if ( nAdditionalLevelDamage > 20 )
    {
       nAdditionalLevelDamage = 20;
    } */
    effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, nStr);
    //effect eStr_Low = EffectAbilityDecrease(ABILITY_STRENGTH, nStr);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    effect eGood = EffectLinkEffects(eStr, eDur);
    //effect eBad = EffectLinkEffects(eStr_Low, eDur2);

    int nPenetr = CasterLvl + SPGetPenetr();


    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    //Apply the explosion at the location captured above.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = MyFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        int nDC = PRCGetSaveDC(oTarget,OBJECT_SELF);
        //Roll damage for each target
        nDamage = d8(nDmgDice) + nAdditionalLevelDamage;
        //Resolve metamagic
        int iBlastFaith = BlastInfidelOrFaithHeal(OBJECT_SELF, oTarget, DAMAGE_TYPE_NEGATIVE, FALSE);
        if ((nMetaMagic & METAMAGIC_MAXIMIZE) || iBlastFaith)
        {
            nDamage = (8*nDmgDice) + nAdditionalLevelDamage;
        }
        if ((nMetaMagic & METAMAGIC_EMPOWER))
        {
           nDamage = nDamage + (nDamage / 2);
        }
        //Get the distance between the explosion and the target to calculate delay
        fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;

        // * any undead should be healed, not just Friendlies
        if (MyPRCGetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_NEGATIVE_ENERGY_BURST, FALSE));
            //Set the heal effect
            eHeal = EffectHeal(nDamage);
            DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
            //This visual effect is applied to the target object not the location as above.  This visual effect
            //represents the flame that erupts on the target not on the ground.
            DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, oTarget));
            DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_PERMANENT, eGood, oTarget,0.0f,TRUE,-1,CasterLvl));
        }
        else
        if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            if(MyPRCGetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
            {
                if(!PRCDoResistSpell(OBJECT_SELF, oTarget,nPenetr, fDelay))
                {
                    if(PRCMySavingThrow(SAVING_THROW_WILL, oTarget, (nDC), SAVING_THROW_TYPE_NEGATIVE, OBJECT_SELF, fDelay))
                    {
                        nDamage /= 2;
                        if (GetHasMettle(oTarget, SAVING_THROW_WILL)) // Ignores partial effects
                        {
                            nDamage = 0;
                        }
                    }
                    //nDamage += ApplySpellBetrayalStrikeDamage(oTarget, OBJECT_SELF, FALSE);
                    //Fire cast spell at event for the specified target
                    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_NEGATIVE_ENERGY_BURST));
                    //Set the damage effect
                    eDam = PRCEffectDamage(oTarget, nDamage, DAMAGE_TYPE_NEGATIVE);
                    // Apply effects to the currently selected target.
                    SPApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                    PRCBonusDamage(oTarget);
                    //This visual effect is applied to the target object not the location as above.  This visual effect
                    //represents the flame that erupts on the target not on the ground.
                    DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_PERMANENT, eDur2, oTarget,0.0f,TRUE,-1,CasterLvl));
                    DelayCommand(fDelay, ApplyAbilityDamage(oTarget, ABILITY_STRENGTH, nStr, DURATION_TYPE_PERMANENT, TRUE, 0.0f, TRUE, -1, CasterLvl));
                }
            }
        }

       //Select the next target within the spell shape.
       oTarget = MyNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget);
    }



DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
// Getting rid of the integer used to hold the spells spell school
}
