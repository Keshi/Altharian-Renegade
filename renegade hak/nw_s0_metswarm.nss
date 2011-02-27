                      //::///////////////////////////////////////////////
//:: Meteor Swarm
//:: NW_S0_MetSwarm
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Everyone in a 50ft radius around the caster
    takes 20d6 fire damage.  Those within 6ft of the
    caster will take no damage.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 24 , 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 22, 2001

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

    int CasterLvl = PRCGetCasterLevel(OBJECT_SELF);
    int nStaff = GetMageStaff(OBJECT_SELF);
    int nDiceCap = 20;
    int nDamage = d6(nDiceCap);
    int nDamMax = 6*nDiceCap;
    int nSaveType = SAVING_THROW_TYPE_FIRE;
    if (nStaff >= 3)        // Avanar's or Eternity's boost
    {
        int nLevel = GetEffectiveCasterLevel(OBJECT_SELF);
        if (nLevel > 20) nDiceCap = ((nLevel - 20)/2 + 20);
        CasterLvl = nLevel;
    }


    CasterLvl +=SPGetPenetr();
    int EleDmg = ChangedElementalDamage(OBJECT_SELF, DAMAGE_TYPE_FIRE);


    //Declare major variables
    int nMetaMagic;
    //int nDamage;
    effect eFire;
    effect eMeteor = EffectVisualEffect(VFX_FNF_METEOR_SWARM);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    //Apply the meteor swarm VFX area impact
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eMeteor, GetLocation(OBJECT_SELF));
    //Get first object in the spell area
    float fDelay;
    object oTarget = MyFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
            fDelay = PRCGetRandomDelay();
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_METEOR_SWARM));
            //Make sure the target is outside the 2m safe zone
            if (GetDistanceBetween(oTarget, OBJECT_SELF) > 2.0)
            {
                //Make SR check
                if (!PRCDoResistSpell(OBJECT_SELF, oTarget,CasterLvl, 0.5))
                {
                int nDC = PRCGetSaveDC(oTarget,OBJECT_SELF);
                //Roll damage

                 nDamage = d6(nDiceCap);
                 nDamMax = 6*nDiceCap;

                if (nStaff == 2 || nStaff == 4)        // Staff of Destruction or Avanar boost
                {
                 nDamage = d10(nDiceCap);
                 nDamMax = 10*nDiceCap;
                 EleDmg = DAMAGE_TYPE_POSITIVE;
                 nSaveType = SAVING_THROW_TYPE_POSITIVE;
                 }

                      //Enter Metamagic conditions
                      if ((nMetaMagic & METAMAGIC_MAXIMIZE))
                      {
                         nDamage = nDamMax;//Damage is at max
                         //nDamage = 120;//Damage is at max
                      }
                      if ((nMetaMagic & METAMAGIC_EMPOWER))
                      {
                         nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
                      }
                      //nDamage += ApplySpellBetrayalStrikeDamage(oTarget, OBJECT_SELF, FALSE);
                      nDamage = PRCGetReflexAdjustedDamage(nDamage, oTarget, (nDC),nSaveType);
                      //Set the damage effect
                      eFire = PRCEffectDamage(oTarget, nDamage, EleDmg);
                      if(nDamage > 0)
                      {
                          //Apply damage effect and VFX impact.
                          DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                          PRCBonusDamage(oTarget);
                          DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                      }
                 }
            }
        }
        //Get next target in the spell area
        oTarget = MyNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }




DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
// Getting rid of the local integer storing the spellschool name
}


