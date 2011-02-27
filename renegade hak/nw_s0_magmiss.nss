//::///////////////////////////////////////////////
//:: Magic Missile
//:: NW_S0_MagMiss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// A missile of magical energy darts forth from your
// fingertip and unerringly strikes its target. The
// missile deals 1d4+1 points of damage.
//
// For every two extra levels of experience past 1st, you
// gain an additional missile.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 10, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: May 8, 2001

//:: modified by mr_bumpkin Dec 4, 2003 for PRC stuff
#include "prc_inc_spells"
#include "wk_tools"



void main()
{
DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
SetLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR", SPELL_SCHOOL_EVOCATION);

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


    //Declare major variables  ( fDist / (3.0f * log( fDist ) + 2.0f) )
    object oTarget = PRCGetSpellTargetObject();

    int CasterLvl = PRCGetCasterLevel(OBJECT_SELF);
    int nStaff = GetMageStaff(OBJECT_SELF);
    int nCasterLvl = CasterLvl;
    if (nStaff >= 3) nCasterLvl = GetEffectiveCasterLevel(OBJECT_SELF);



    int nDamage = 0;
    int nMetaMagic = PRCGetMetaMagicFeat();
    int nCnt;
    effect eMissile = EffectVisualEffect(VFX_IMP_MIRV);
    effect eVis = EffectVisualEffect(VFX_IMP_MAGBLUE);
    int nMissiles = (nCasterLvl + 1)/2;
    float fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
    float fDelay = fDist/(3.0 * log(fDist) + 2.0);
    float fDelay2, fTime;

    CasterLvl +=SPGetPenetr();

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MAGIC_MISSILE));
        //Limit missiles to five NOT IN ALTHARIA.  MAXIMUM TOTAL MISSILES = 100/2
    /*    if (nMissiles > 5)
        {
            nMissiles = 5;
        }*/
        //Make SR Check
        if (!PRCDoResistSpell(OBJECT_SELF, oTarget,CasterLvl, fDelay))
        {
            //Apply a single damage hit for each missile instead of as a single mass
            for (nCnt = 1; nCnt <= nMissiles; nCnt++)
            {
                //Roll damage
                int nDam = d4(1) + 1;
                if (nStaff == 1 || nStaff == 4) nDam = d6(1) + 1;
                //Enter Metamagic conditions
                if ((nMetaMagic & METAMAGIC_MAXIMIZE))
                {
                      nDam = 5;//Damage is at max
                      if (nStaff == 1 || nStaff == 4) nDam = 7;
                }
                if ((nMetaMagic & METAMAGIC_EMPOWER))
                {
                      nDam = nDam + nDam/2; //Damage/Healing is +50%
                }

                // apply bonus damage to first missle.
                if(nCnt == 1)
                {
                    //nDam += ApplySpellBetrayalStrikeDamage(oTarget, OBJECT_SELF);
                    PRCBonusDamage(oTarget);
                }

                fTime = fDelay;
                fDelay2 += 0.1;
                fTime += fDelay2;

                //Set damage effect
                effect eDam = PRCEffectDamage(oTarget, nDam, DAMAGE_TYPE_MAGICAL);
                //Apply the MIRV and damage effect
                DelayCommand(fTime, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));

                DelayCommand(fTime, SPApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget,0.0f,FALSE));
                DelayCommand(fDelay2, SPApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget));
             }
         }
         else
         {
            for (nCnt = 1; nCnt <= nMissiles; nCnt++)
            {
                SPApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget);
            }
         }
     }



DeleteLocalInt(OBJECT_SELF, "X2_L_LAST_SPELLSCHOOL_VAR");
// Getting rid of the local integer storing the spellschool name
}
