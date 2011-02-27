//::///////////////////////////////////////////////
//:: Scintillating Sphere
//:: X2_S0_ScntSphere
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// A scintillating sphere is a burst of electricity
// that detonates with a low roar and inflicts 1d6
// points of damage per caster level (maximum of 10d6)
// to all creatures within the area. Unattended objects
// also take damage. The explosion creates almost no pressure.
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 25 , 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Andrew Nobbs, 02/06/2003

//:: altered by mr_bumpkin Dec 4, 2003 for prc stuff
#include "prc_inc_spells"
#include "wk_tools"


#include "prc_add_spell_dc"

void main()
{
DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
SetLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR", SPELL_SCHOOL_EVOCATION);

/*
  Spellcast Hook Code
  Added 2003-07-07 by Georg Zoeller
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

    int nCasterLvl = CasterLvl;
    CasterLvl +=SPGetPenetr();
     int nMaxDam = 6;
    int EleDmg = ChangedElementalDamage(OBJECT_SELF, DAMAGE_TYPE_ELECTRICAL);
     int nStaff = GetMageStaff(OBJECT_SELF);
    int nMetaMagic = PRCGetMetaMagicFeat();
    int nDamage;
    float fDelay;
    effect eExplode = EffectVisualEffect(459);
    effect eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
    effect eDam;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    //Limit Caster level for the purposes of damage
    //if (nCasterLvl > 10)
   // {
   //     nCasterLvl = 10;
   // }
   if (nCasterLvl > 15)    // standard is 10 per Bioware
    {
        nCasterLvl = 15;    // standard is 10 per Bioware
    }

    if (nStaff == 4)
      {
        int nLevel = GetEffectiveCasterLevel(OBJECT_SELF);
        if (nLevel > 15) nCasterLvl = 15 + ((nLevel - 15)/3);
        else nCasterLvl = nLevel;
      }


    //Apply the fireball explosion at the location captured above.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = MyFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, PRCGetSpellId()));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            if (!PRCDoResistSpell(OBJECT_SELF, oTarget,CasterLvl, fDelay))
            {
                int nDC = PRCGetSaveDC(oTarget,OBJECT_SELF);
                //Roll damage for each target
                nDamage = d6(nCasterLvl);
                if (nStaff == 2 || nStaff == 4)
                  {
                    nDamage = d10(nCasterLvl);
                    nMaxDam = 10;
                  }
                //Resolve metamagic
                if ((nMetaMagic & METAMAGIC_MAXIMIZE))
                {
                    //nDamage = 6 * nCasterLvl;
                    nDamage = nMaxDam * nCasterLvl;
                }
                if ((nMetaMagic & METAMAGIC_EMPOWER))
                {
                    nDamage = nDamage + nDamage / 2;
                }
                //nDamage += ApplySpellBetrayalStrikeDamage(oTarget, OBJECT_SELF, FALSE);
                //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
                nDamage = PRCGetReflexAdjustedDamage(nDamage, oTarget, (nDC), SAVING_THROW_TYPE_ELECTRICITY);
                //Set the damage effect
                eDam = PRCEffectDamage(oTarget, nDamage, EleDmg);
                if (nStaff == 2) eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
               if(nDamage > 0)
                {
                    // Apply effects to the currently selected target.
                    DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    //This visual effect is applied to the target object not the location as above.  This visual effect
                    //represents the flame that erupts on the target not on the ground.
                    DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    PRCBonusDamage(oTarget);
                }
             }
        }
       //Select the next target within the spell shape.
       oTarget = MyNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }


DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
// Erasing the variable used to store the spell's spell school
}

