//::///////////////////////////////////////////////
//:: Ice Storm
//:: NW_S0_IceStorm
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Everyone in the area takes 3d6 Bludgeoning
    and 2d6 Cold damage.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 12, 2001
//:://////////////////////////////////////////////

//:: modified by mr_bumpkin Dec 4, 2003 for PRC stuff
#include "prc_inc_spells"
#include "prc_add_spell_dc"
#include "wk_tools"



void main()
{
DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
SetLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR", SPELL_SCHOOL_EVOCATION);
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
    //int CasterLvl = PRCGetCasterLevel(OBJECT_SELF);
    //altharian stuff
    int nStaff = GetMageStaff(oCaster);
    int nDruid = GetWhiteGold(oCaster);
    int nBard  = GetHarmonic(oCaster);
    int nDice = 6;
    int nLevel = PRCGetCasterLevel(oCaster);
    if (nStaff >= 3 || nDruid >= 3 || nBard == 4) nLevel = GetEffectiveCasterLevel(oCaster);
    if (nStaff == 2 || nStaff == 4 ||
        nDruid == 2 || nDruid == 4 ||
        nBard == 2  || nBard == 4) nDice = 8;

    int EleDmg = ChangedElementalDamage(OBJECT_SELF, DAMAGE_TYPE_COLD);

    int nCasterLvl = nLevel;
    int nMetaMagic = PRCGetMetaMagicFeat();
    int nDamage, nDamage2, nDamage3;
    int nVariable = nCasterLvl/3;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_ICESTORM); //USE THE ICESTORM FNF
    effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);
    effect eDam,eDam2, eDam3;
    // These last for one round. Added as they are in the 3.5 PHB
    effect eLink = EffectLinkEffects(EffectSkillDecrease(SKILL_LISTEN, 4), EffectMovementSpeedDecrease(50));
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    nCasterLvl +=SPGetPenetr();

    //Apply the ice storm VFX at the location captured above.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = MyFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            fDelay = PRCGetRandomDelay(0.75, 2.25);
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ICE_STORM));
            if (!PRCDoResistSpell(OBJECT_SELF, oTarget,nLevel, fDelay))
            {
                //Roll damage for each target
                nDamage = d6(3);
                if (nDice == 8) nDamage = d8(3);
                nDamage2 = d6(2);
                if (nDice == 8) nDamage2 = d8(2);
                nDamage3 = d6(nVariable);
                if (nDice == 8) nDamage3 = d8(nVariable);
                //Resolve metamagic
                if ((nMetaMagic & METAMAGIC_MAXIMIZE))
                {
                    nDamage = 3 * nDice;
                    nDamage2 = 2 * nDice;
                    nDamage3 = nDice * nVariable;
                }
                if ((nMetaMagic & METAMAGIC_EMPOWER))
                {
                   nDamage = nDamage + (nDamage / 2);
                   nDamage2 = nDamage2 + (nDamage2 / 2);
                   nDamage3 = nDamage3 + (nDamage3 / 2);
                }
                nDamage2 = nDamage2 + nDamage3;
                nDamage = nDamage + nDamage3/2;
                //nDamage2 += ApplySpellBetrayalStrikeDamage(oTarget, OBJECT_SELF, FALSE);
                //Set the damage effect
                eDam = PRCEffectDamage(oTarget, nDamage, DAMAGE_TYPE_BLUDGEONING);
                eDam2 = PRCEffectDamage(oTarget, nDamage2, EleDmg);
                // Apply effects to the currently selected target.
                DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                PRCBonusDamage(oTarget);
                DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eDam2, oTarget));
                //This visual effect is applied to the target object not the location as above.  This visual effect
                //represents the impact that erupts on the target not on the ground.
                DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                SPApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, 6.0,TRUE,-1,nLevel);
             }
        }
       //Select the next target within the spell shape.
       oTarget = MyNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }



DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
// Getting rid of the local integer storing the spellschool name
}

