//::///////////////////////////////////////////////
//:: Horrid Wilting
//:: NW_S0_HorrWilt
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All living creatures (not undead or constructs)
    suffer 1d8 damage per caster level to a maximum
    of 25d8 damage.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 12 , 2001
//:://////////////////////////////////////////////

//:: modified by mr_bumpkin Dec 4, 2003 for PRC stuff
#include "prc_inc_spells"
#include "prc_add_spell_dc"
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
    int nCasterLvl = PRCGetCasterLevel(oCaster);
    int CasterLvl = nCasterLvl;
    int nMetaMagic = PRCGetMetaMagicFeat();
    int nDamage;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_HORRID_WILTING);
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eDam;
     //altharia mod
    int iMage=GetMageStaff(oCaster);
        if (iMage >= 3)
           {nCasterLvl = GetEffectiveCasterLevel(oCaster);}

    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    //Limit Caster level for the purposes of damage
    CasterLvl +=SPGetPenetr();

    //Apply the horrid wilting explosion at the location captured above.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = MyFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        // GZ: Not much fun if the caster is always killing himself
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HORRID_WILTING));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = PRCGetRandomDelay(1.5, 2.5);
            if (!PRCDoResistSpell(OBJECT_SELF, oTarget,CasterLvl, fDelay))
            {
                if(MyPRCGetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT && MyPRCGetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
                {
                    int nDC = PRCGetSaveDC(oTarget,OBJECT_SELF);
                    //Roll damage for each target
                    nDamage = d8(nCasterLvl);
                    if(iMage==2 || iMage==4) nDamage = d8(nCasterLvl) + (4*nCasterLvl);
                    //Resolve metamagic
                    if ((nMetaMagic & METAMAGIC_MAXIMIZE))
                    {
                        nDamage = 8 * nCasterLvl;
                        if (iMage == 2 || iMage==4) nDamage = nDamage + (4 * nCasterLvl);
                    }
                    if ((nMetaMagic & METAMAGIC_EMPOWER))
                    {
                       nDamage = nDamage + nDamage / 2;
                    }
                    if(/*Fort Save*/ PRCMySavingThrow(SAVING_THROW_FORT, oTarget, (nDC), SAVING_THROW_TYPE_NONE, OBJECT_SELF, fDelay))
                    {
                        if (GetHasMettle(oTarget, SAVING_THROW_FORT))
                        // This script does nothing if it has Mettle, bail
                            nDamage = 0;
                        nDamage = nDamage/2;
                    }
                    //nDamage += ApplySpellBetrayalStrikeDamage(oTarget, OBJECT_SELF, FALSE);
                    //Set the damage effect
                    eDam = PRCEffectDamage(oTarget, nDamage, DAMAGE_TYPE_MAGICAL);
                    // Apply effects to the currently selected target.
                    SPApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                    PRCBonusDamage(oTarget);
                    //This visual effect is applied to the target object not the location as above.  This visual effect
                    //represents the flame that erupts on the target not on the ground.
                    DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
             }
        }
       //Select the next target within the spell shape.
       oTarget = MyNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget);
    }

DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
// Getting rid of the local integer storing the spellschool name
}