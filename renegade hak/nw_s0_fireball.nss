//::///////////////////////////////////////////////
//:: Fireball
//:: NW_S0_Fireball
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// A fireball is a burst of flame that detonates with
// a low roar and inflicts 1d6 points of damage per
// caster level (maximum of 10d6) to all creatures
// within the area. Unattended objects also take
// damage. The explosion creates almost no pressure.
*/
//:://////////////////////////////////////////////
//:: Created By: Noel Borstad
//:: Created On: Oct 18 , 2000
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 6, 2001
//:: Last Updated By: AidanScanlan, On: April 11, 2001
//:: Last Updated By: Preston Watamaniuk, On: May 25, 2001

//:: modified by mr_bumpkin Dec 4, 2003 for PRC stuff
#include "prc_inc_spells"
#include "prc_add_spell_dc"
#include "wk_tools"



void main()
{
    if(!X2PreSpellCastCode()) return;

    PRCSetSchool(SPELL_SCHOOL_EVOCATION);

    //Declare major variables
    object oCaster = OBJECT_SELF;
    location lTarget = PRCGetSpellTargetLocation();
    int nStaff = GetMageStaff(OBJECT_SELF);
    int nDice = 6;
    int nLevel = PRCGetCasterLevel(oCaster);
    if (nStaff >= 3) nLevel = GetEffectiveCasterLevel(oCaster);
    if (nStaff == 2 || nStaff == 4) nDice = 8;

    int nCasterLvl = nLevel;

    //int nCasterLvl = PRCGetCasterLevel(oCaster);
    int EleDmg = ChangedElementalDamage(oCaster, DAMAGE_TYPE_FIRE);
    int nMetaMagic = PRCGetMetaMagicFeat();
    int nDamage;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_FIREBALL);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eDam;
    //Limit Caster level for the purposes of damage
    //int nDice = min(10, nCasterLvl);
    if (nCasterLvl > 10)
    {
        nCasterLvl = 10 + (nLevel-10)/5;
    }
    nCasterLvl += SPGetPenetr();

    //Apply the fireball explosion at the location captured above.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = MyFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_FIREBALL));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            if (!PRCDoResistSpell(oCaster, oTarget, nCasterLvl, fDelay))
            {
                //Resolve metamagic
                if ((nMetaMagic & METAMAGIC_MAXIMIZE))
                     {nDamage = nDice * nCasterLvl;}
                else
                    //Roll damage for each target
                    //nDamage = d6(nDice);
                    nDamage = d6(nCasterLvl);
                    if (nStaff == 2 || nStaff == 4) nDamage = d8(nCasterLvl);

                if ((nMetaMagic & METAMAGIC_EMPOWER))
                    nDamage += nDamage / 2;

                //nDamage += ApplySpellBetrayalStrikeDamage(oTarget, OBJECT_SELF, FALSE);
                //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
                nDamage = PRCGetReflexAdjustedDamage(nDamage, oTarget, (PRCGetSaveDC(oTarget, oCaster)), SAVING_THROW_TYPE_FIRE);
                if(nDamage > 0)
                {
                    //Set the damage effect
                    eDam = PRCEffectDamage(oTarget, nDamage, EleDmg);
                    // Apply effects to the currently selected target.
                    DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    PRCBonusDamage(oTarget);
                    //This visual effect is applied to the target object not the location as above.  This visual effect
                    //represents the flame that erupts on the target not on the ground.
                    DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
            }
        }
       //Select the next target within the spell shape.
       oTarget = MyNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }

    PRCSetSchool();
}

