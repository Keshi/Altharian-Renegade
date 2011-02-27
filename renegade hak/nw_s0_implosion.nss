//::///////////////////////////////////////////////
//:: Implosion
//:: NW_S0_Implosion.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All persons within a 5ft radius of the spell must
    save at +3 DC or die.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 13, 2001
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
    object oTarget;
    effect eDeath = EffectDeath(TRUE);

     //altharian modifications
     object oCaster = OBJECT_SELF;
     int nMod = 0;
     int nVesper = GetVesper(OBJECT_SELF);
     int nLevel = PRCGetCasterLevel(oCaster);
     if (nVesper == 2 || nVesper == 4)
      {
        nLevel = GetEffectiveCasterLevel(OBJECT_SELF);
        nMod = nLevel / 5;
       //if (nMod > 10) nMod = 10;
      }
//end altharian code


     if(!GetPRCSwitch(PRC_165_DEATH_IMMUNITY))
        eDeath = SupernaturalEffect(eDeath);
    effect eImplode= EffectVisualEffect(VFX_FNF_IMPLOSION);
    float fDelay;

    int CasterLvl = PRCGetCasterLevel(OBJECT_SELF);

    CasterLvl +=SPGetPenetr();



    //Apply the implode effect
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImplode, GetSpellTargetLocation());
    //Get the first target in the shape
    oTarget = MyFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget))
    {
        if (oTarget != OBJECT_SELF
            && spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
           //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_IMPLOSION));
           fDelay = PRCGetRandomDelay(0.4, 1.2);
           //Make SR check
           if (!PRCDoResistSpell(OBJECT_SELF, oTarget,CasterLvl, fDelay))
           {
                int nDC = PRCGetSaveDC(oTarget,OBJECT_SELF);
                //Make Reflex save
                if(!PRCMySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DEATH, OBJECT_SELF, fDelay))
                {
                    DeathlessFrenzyCheck(oTarget);

                    //Apply death effect and the VFX impact
                    DelayCommand(fDelay, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
                    }
                 //Altharia code
                    if(!PRCMySavingThrow(SAVING_THROW_FORT, oTarget, nDC+10, SAVING_THROW_TYPE_CHAOS, OBJECT_SELF, fDelay))
                {
                    int nDamage = d8(nLevel) + (nMod*nLevel);
                    effect eCrush = EffectDamage(nDamage,DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_NORMAL);
                    effect ePower = EffectDamage(nDamage,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL);
                    effect eDmg = EffectLinkEffects(eCrush,ePower);
                    //Apply damage effect and the VFX impact
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oTarget);
                    }
                    //end Altharian code
          }
        }
       //Get next target in the shape
       oTarget = MyNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation());
    }



DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
// Getting rid of the local integer storing the spellschool name
}

