#include "prc_inc_sp_tch"
#include "prc_add_spell_dc"

void DoOrb(effect eVis, effect eFailSave, int nSaveType, int nDamageType, int nSpellID = -1)
{
     PRCSetSchool(SPELL_SCHOOL_EVOCATION);

     object oTarget = PRCGetSpellTargetObject();
     int nCasterLvl = PRCGetCasterLevel(OBJECT_SELF);
     
     if(PRCDoRangedTouchAttack(oTarget, TRUE, OBJECT_SELF))
     {             
             int nDice = nCasterLvl;
             if (nDice > 15) nDice = 15;
             
             int nPenetr = nCasterLvl + SPGetPenetr();
             
             // Get the spell ID if it was not given.
             if (-1 == nSpellID) nSpellID = PRCGetSpellId();
             
             // Adjust the damage type of necessary.
             nDamageType = PRCGetElementalDamageType(nDamageType, OBJECT_SELF);
             
             effect eMissile = EffectVisualEffect(VFX_IMP_MIRV);
             
             if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
             {
                     //Fire cast spell at event for the specified target
                     PRCSignalSpellEvent(oTarget, TRUE, nSpellID);
                     
                     //Roll damage for each target
                     int nDamage = PRCGetMetaMagicDamage(nDamageType, nDice, 6);
                     //nDamage += ApplySpellBetrayalStrikeDamage(oTarget, OBJECT_SELF);
                     
                     // Apply the damage and the damage visible effect to the target.
                     SPApplyEffectToObject(DURATION_TYPE_INSTANT, PRCEffectDamage(oTarget, nDamage, nDamageType), oTarget);
                     PRCBonusDamage(oTarget);
                     SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                     
                     // If the target failed it's save then apply the failed save effect as well for 1 round.
                     if (!PRCMySavingThrow(nSaveType, oTarget, PRCGetSaveDC(oTarget, OBJECT_SELF)))
                     SPApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFailSave, oTarget, RoundsToSeconds(1),TRUE,-1,nCasterLvl);
             }           
     }
     PRCSetSchool();
}

// Test main
//void main(){}
