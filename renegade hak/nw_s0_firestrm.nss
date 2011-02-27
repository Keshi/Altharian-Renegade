//::///////////////////////////////////////////////
//:: Fire Storm
//:: NW_S0_FireStm
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creates a zone of destruction around the caster
    within which all living creatures are pummeled
    with fire.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 11, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 21, 2001

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
    int nMetaMagic = PRCGetMetaMagicFeat();
    int nDamage;
    int nDamage2;int nDice = 6;
    int nFact = 2;
    int nMod = 0;
    int nMax = 20;
    int nLevel;
    int nStaff = GetMageStaff(OBJECT_SELF);
    int nVesper = GetVesper(OBJECT_SELF);
    int nDruid  = GetWhiteGold(OBJECT_SELF);
    int CasterLevel = PRCGetCasterLevel(OBJECT_SELF);
    if (nStaff >= 3 || nDruid >= 3|| nVesper >= 3){ nLevel = GetEffectiveCasterLevel(OBJECT_SELF);CasterLevel = nLevel;}
    if (nStaff == 2 || nStaff == 4 || nDruid ==1 || nDruid == 4)
      {
        nDice = 8;
        nFact = 1;
        nMod = nLevel/10;
      }
    if (nVesper == 2|| nVesper == 4)
      {
        nLevel = GetEffectiveCasterLevel(OBJECT_SELF);
        nDice = 8;
        nFact = 1;
        nMod = nLevel/10;CasterLevel = nLevel;
      }
    if (nLevel > 20) nMax = (nLevel - 20)/4 + 20;
    int EleDmg = ChangedElementalDamage(OBJECT_SELF, DAMAGE_TYPE_FIRE);

    if(CasterLevel > nMax)
    {
        CasterLevel == nMax;
    }
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eFireStorm = EffectVisualEffect(VFX_FNF_FIRESTORM);
    float fDelay;
    CasterLevel +=SPGetPenetr();

    //Apply Fire and Forget Visual in the area;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm, GetLocation(OBJECT_SELF));
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = MyFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        //This spell smites everyone who is more than 2 meters away from the caster.
        //if (GetDistanceBetween(oTarget, OBJECT_SELF) > 2.0)
        //{
            if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
            {
                fDelay = PRCGetRandomDelay(1.5, 2.5);
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FIRE_STORM));
                //Make SR check, and appropriate saving throw(s).
                if (!PRCDoResistSpell(OBJECT_SELF, oTarget,CasterLevel, fDelay))
                {
                      //Roll Damage
                      nDamage = d6(CasterLevel);
                      if (nStaff == 2 || nStaff == 4 ||
                          nVesper == 2 || nVesper == 4 ||
                          nDruid == 1 || nDruid == 4) nDamage = d8(CasterLevel);
                      //Enter Metamagic conditions
                      if ((nMetaMagic & METAMAGIC_MAXIMIZE))
                      {
                         nDamage = nDice *  CasterLevel;//Damage is at max
                      }
                      if ((nMetaMagic & METAMAGIC_EMPOWER))
                      {
                         nDamage = nDamage + (nDamage/2);//Damage/Healing is +50%
                      }
                       int nDC = PRCGetSaveDC(oTarget,OBJECT_SELF);
                      //Save versus both holy and fire damage
                      //nDamage2 += ApplySpellBetrayalStrikeDamage(oTarget, OBJECT_SELF, FALSE);
                      nDamage2 = PRCGetReflexAdjustedDamage(nDamage/nFact, oTarget, (nDC), SAVING_THROW_TYPE_DIVINE);
                      nDamage = PRCGetReflexAdjustedDamage(nDamage/nFact, oTarget, (nDC), SAVING_THROW_TYPE_FIRE);
                    if(nDamage > 0)
                    {
                          // Apply effects to the currently selected target.  For this spell we have used
                          //both Divine and Fire damage.
                          effect eDivine = PRCEffectDamage(oTarget, nDamage2, DAMAGE_TYPE_DIVINE);
                          effect eFire = PRCEffectDamage(oTarget, nDamage, EleDmg);
                          DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                          DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eDivine, oTarget));
                          DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    }
                }
            //}
        }
        //Select the next target within the spell shape.
        oTarget = MyNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }



DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
// Getting rid of the local integer storing the spellschool name
}
