//::///////////////////////////////////////////////
//:: Destruction
//:: NW_S0_Destruc
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The target creature is destroyed if it fails a
    Fort save, otherwise it takes 10d6 damage.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 13, 2001
//:://////////////////////////////////////////////


//:: modified by mr_bumpkin Dec 4, 2003
#include "prc_inc_spells"
#include "prc_add_spell_dc"
#include "wk_tools"



void main()
{
DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
SetLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR", SPELL_SCHOOL_NECROMANCY);

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
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
    object oTarget = PRCGetSpellTargetObject();
    int nMetaMagic = PRCGetMetaMagicFeat();
    int nDamage;
    effect eDeath = EffectDeath();
    effect eDam;
    effect eVis = EffectVisualEffect(234);
    int nMod = 0;
    int nVesper = GetVesper(OBJECT_SELF);
    int nLevel = PRCGetCasterLevel(OBJECT_SELF);
    if (nVesper == 2 || nVesper == 4)
      {
        nLevel = GetEffectiveCasterLevel(OBJECT_SELF);
        nMod = nLevel/10;
      }

    int CasterLvl = nLevel;//PRCGetCasterLevel(OBJECT_SELF);
    CasterLvl +=SPGetPenetr();

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DESTRUCTION));
        //Make SR check
        if(!PRCDoResistSpell(OBJECT_SELF, oTarget,CasterLvl))
        {
            //Make a saving throw check
            if(!/*Fort Save*/ PRCMySavingThrow(SAVING_THROW_FORT, oTarget, PRCGetSaveDC(oTarget, OBJECT_SELF)+nMod))
            {
                DeathlessFrenzyCheck(oTarget);

                //Apply the VFX impact and effects
                SPApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget);
            }
            else if (GetHasMettle(oTarget, SAVING_THROW_FORT))
            {
        // This script does nothing if it has Mettle, bail
            return;
        }
            else
            {
                nDamage = d6(nLevel);
                //Enter Metamagic conditions
                if ((nMetaMagic & METAMAGIC_MAXIMIZE))
                {
                    //nDamage = 60;//Damage is at max
                    nDamage = 6*nLevel;
                }
                if ((nMetaMagic & METAMAGIC_EMPOWER))
                {
                    nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
                }
                //nDamage += ApplySpellBetrayalStrikeDamage(oTarget, OBJECT_SELF);
                //Set damage effect
                eDam = PRCEffectDamage(oTarget, nDamage, DAMAGE_TYPE_DIVINE);
                SPApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            }
            //Apply VFX impact
            SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }

DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
// Getting rid of the local integer storing the spellschool name
}
