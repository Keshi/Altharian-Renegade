//::///////////////////////////////////////////////
//:: Finger of Death
//:: NW_S0_FingDeath
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// You can slay any one living creature within range.
// The victim is entitled to a Fortitude saving throw to
// survive the attack. If he succeeds, he instead
// sustains 3d6 points of damage +1 point per caster
// level.
*/
//:://////////////////////////////////////////////
//:: Created By: Noel Borstad
//:: Created On: Oct 17, 2000
//:://////////////////////////////////////////////
//:: Updated By: Georg Z, On: Aug 21, 2003 - no longer affects placeables

#include "x0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "wk_tools"

void main()
{

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
    object oTarget = GetSpellTargetObject();

    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;

    int nStaff = GetMageStaff(OBJECT_SELF);
    int nDruid = GetWhiteGold(OBJECT_SELF);
    int nDice = 6;
    int nSpellDC = GetSpellSaveDC();
    int nLevel = GetCasterLevel(OBJECT_SELF);
    if (nStaff >= 3 || nDruid >= 3) nLevel = GetEffectiveCasterLevel(OBJECT_SELF);
    if (nStaff >= 3 || nStaff == 1 ||
        nDruid ==2 || nDruid == 4)
    {
        nDice = 8;
        nSpellDC = nSpellDC + (nLevel/5);
    }
    int nCasterLvl = nLevel;
    int nMax = nLevel/8;
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH_L);
    effect eVis2 = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);


    if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE,OBJECT_SELF))
    {
        //GZ: I still signal this event for scripting purposes, even if a placeable
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FINGER_OF_DEATH));
         if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {

            //Make SR check
            if (!MyResistSpell(OBJECT_SELF, oTarget))
               {
                 //Make Forttude save
                 if (!MySavingThrow(SAVING_THROW_FORT, oTarget, nSpellDC, SAVING_THROW_TYPE_DEATH))
                 {
                    //Apply the death effect and VFX impact
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oTarget);
                    //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                 }
                 else
                 {
                    //Roll damage
                    nDamage = d6(nMax) + nCasterLvl;
                    if (nStaff >= 3 || nStaff == 1 ||
                        nDruid == 2 || nDruid == 4) nDamage = d8(nMax) + nCasterLvl;
                    //Make metamagic checks
                    if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    {
                        nDamage = nDice* nMax + nCasterLvl;
                    }
                    if (nMetaMagic == METAMAGIC_EMPOWER)
                    {
                        nDamage = nDamage + (nDamage/2);
                    }
                    //Set damage effect
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                    //Apply damage effect and VFX impact
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
                }
            }
        }
    }
}
