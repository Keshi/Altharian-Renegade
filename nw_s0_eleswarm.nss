//::///////////////////////////////////////////////
//:: Elemental Swarm
//:: NW_S0_EleSwarm.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This spell creates a conduit from the caster
    to the elemental planes.  The first elemental
    summoned is a 24 HD Air elemental.  Whenever an
    elemental dies it is replaced by the next
    elemental in the chain Air, Earth, Water, Fire
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 12, 2001
//:://////////////////////////////////////////////
//:: Update Pass By: Preston W, On: July 30, 2001

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "wk_tools"

void ElementalSwarm(int nD8Dice, int nCap, int nDruid, int nMIRV = VFX_IMP_MIRV,
    int nVIS = VFX_IMP_MAGBLUE, int nDAMAGETYPE = DAMAGE_TYPE_MAGICAL, int nONEHIT = FALSE)
{
    object oTarget = OBJECT_INVALID;
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);

    int nDamage = 0;
    int nCnt =1;
    effect eMissile = EffectVisualEffect(nMIRV);
    effect eVis = EffectVisualEffect(nVIS);
    float fDist = 0.0;
    float fDelay = 0.0;
    float fDelay2, fTime;
    location lTarget = GetSpellTargetLocation(); // missile spread centered around caster
    int nMissiles = 6;

    if (nMissiles > nCap)
        {
        nMissiles = nCap;
        }

    if (nDruid >= 3)
        {
        nCasterLvl = GetEffectiveCasterLevel(OBJECT_SELF);
        }
    if (nDruid == 2 || nDruid == 4)
        {
        nMissiles = nCasterLvl/5;
        if (nMissiles < 6) nMissiles = 6;
        }


    int nEnemies = 0;

    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget) )
    {
        // * caster cannot be harmed by this spell
        if ((GetIsEnemy(oTarget)) && (oTarget != OBJECT_SELF))
        {
            nEnemies++;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }

     if (nEnemies == 0) return; // * Exit if no enemies to hit

     // by default the Remainder will be 0 (if more than enough enemies for all the missiles)
     int nRemainder = 0;

     if (nEnemies > nMissiles)
        nEnemies = nMissiles;

     int nExtraMissiles = nMissiles / nEnemies;

     // April 2003
     // * if more enemies than missiles, need to make sure that at least
     // * one missile will hit each of the enemies
     nRemainder = nMissiles % nEnemies;


    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget) && nCnt <= nEnemies)
    {
        // * caster cannot be harmed by this spell
        if ((GetIsEnemy(oTarget)) && (oTarget != OBJECT_SELF))
        {
                // * recalculate appropriate distances

                fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
                fDelay = fDist/(3.0 * log(fDist) + 2.0);

                int i = 0;
                // * first target will get excess missiles
                for (i=1; i <= nExtraMissiles + nRemainder; i++)
                {
                    //Make SR Check and a succesful touch attack
                    int nResult = TouchAttackRanged(oTarget, TRUE);

                    if (nResult > 0)
                    {
                        //Roll damage
                        int nDam = d10(nD8Dice) +2;


                        if (nResult == 2)
                        {
                            nDam = nDam + d10(nD8Dice) +2;
                        }

                        fTime = fDelay;
                        fDelay2 += 0.1;
                        fTime += fDelay2;

                        //Set damage effect
                        effect eDam = EffectDamage(nDam, nDAMAGETYPE);
                        //Apply the MIRV and damage effect
                        DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));
                        DelayCommand(fDelay2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget));

                        DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                        // Play the sound of a dart hitting
                        DelayCommand(fTime, PlaySound("cb_ht_dart1"));

                    }
                    else
                    {  // * apply a dummy visual effect
                     ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget);
                    }
                } // for
                nCnt++;// * increment count of missiles fired
                nRemainder = 0;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }

}

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

    //Declare major variables - Changed content

    int nMax = 1;

    int nDruid = GetWhiteGold(OBJECT_SELF);
    if (nDruid == 2)  // Second Whitegold
        {
          nMax = 3;
        }
    if (nDruid >= 3)    // Third and Higher Whitegold
        {
          nMax = 3;
        }

    ElementalSwarm(nMax, 6, nDruid, VFX_IMP_MIRV_FLAME, VFX_IMP_FLAME_M, DAMAGE_TYPE_FIRE);
    DelayCommand(1.5,ElementalSwarm(nMax,6,nDruid, 245, VFX_IMP_ACID_S, DAMAGE_TYPE_ACID));
    DelayCommand(3.0,ElementalSwarm(nMax,6,nDruid, VFX_IMP_MIRV_ELECTRIC, VFX_IMP_LIGHTNING_M, DAMAGE_TYPE_ELECTRICAL));

// Original content for Elemental Swarm
/*    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    nDuration = 24;
    effect eSummon;
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    //Check for metamagic duration
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2;  //Duration is +100%
    }
    //Set the summoning effect
    eSummon = EffectSwarm(FALSE, "NW_SW_AIRGREAT", "NW_SW_WATERGREAT","NW_SW_EARTHGREAT","NW_SW_FIREGREAT");
    //Apply the summon effect
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSummon, OBJECT_SELF, HoursToSeconds(nDuration));*/


}

