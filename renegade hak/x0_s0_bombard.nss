//::///////////////////////////////////////////////
//:: Bombardment
//:: X0_S0_Bombard
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
// Rocks fall from sky
// 1d8 damage/level to a max of 10d8
// Reflex save for half
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: July 22 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Andrew Nobbs May 01, 2003

//:: altered by mr_bumpkin Dec 4, 2003 for prc stuff
#include "prc_inc_spells"
#include "wk_tools"

#include "prc_add_spell_dc"

void main()
{
DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
SetLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR", SPELL_SCHOOL_CONJURATION);
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
    int CasterLvl = PRCGetCasterLevel(OBJECT_SELF);
     int nDice = 8;
    int nCasterLvl = CasterLvl;
    CasterLvl +=SPGetPenetr();
    int nDruid = GetWhiteGold(oCaster);
    if (nDruid >= 3)
      {
        nCasterLvl = GetEffectiveCasterLevel(oCaster);
      }
    if (nDruid == 2 || nDruid == 4)
      {
        nDice = 10;
      }

    int nMetaMagic = PRCGetMetaMagicFeat();
    int nDamage;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_METEOR_SWARM);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eDam;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    //Limit Caster level for the purposes of damage
    if (nCasterLvl > 20)
    {
        //nCasterLvl = 20;
        nCasterLvl = 20 + ((nCasterLvl - 20)/2);
    }

    //Apply the fireball explosion at the location captured above.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = MyFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF) == TRUE)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            if (!PRCDoResistSpell(OBJECT_SELF, oTarget,CasterLvl, fDelay))
            {
                int nSpellDC = (PRCGetSaveDC(oTarget,OBJECT_SELF)) ;
                //Roll damage for each target
                //nDamage = d8(nCasterLvl);
                nDamage = d4(nCasterLvl) + (4 * nCasterLvl);//half the damage is at max
                if (nDruid == 2 || nDruid == 4) nDamage = d4(nCasterLvl) + (6 * nCasterLvl);
                //Resolve metamagic
                if ((nMetaMagic & METAMAGIC_MAXIMIZE))
                {
                   //nDamage = 8 * nCasterLvl;
                   nDamage = nDice * nCasterLvl;
                }
                if ((nMetaMagic & METAMAGIC_EMPOWER))
                {
                   nDamage = nDamage + nDamage / 2;
                }
                //nDamage += ApplySpellBetrayalStrikeDamage(oTarget, OBJECT_SELF, FALSE);
                //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
                nDamage = PRCGetReflexAdjustedDamage(nDamage, oTarget, nSpellDC, SAVING_THROW_TYPE_ALL);
                //Set the damage effect
                eDam = PRCEffectDamage(oTarget, nDamage, DAMAGE_TYPE_BLUDGEONING);
                if(nDamage > 0)
                {

                    // Apply effects to the currently selected target.
                    DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    //This visual effect is applied to the target object not the location as above.  This visual effect
                    //represents the flame that erupts on the target not on the ground.
                    DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
             }
        }
       //Select the next target within the spell shape.
       oTarget = MyNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }


DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
// Erasing the variable used to store the spell's spell school
}



