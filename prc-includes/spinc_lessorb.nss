
#include "prc_inc_sp_tch"
//#include "prc_inc_combat"
//#include "prc_inc_spells"

void DoLesserOrb(effect eVis, int nDamageType, int nSpellID = -1)
{
     PRCSetSchool(SPELL_SCHOOL_CONJURATION);

     object oTarget = PRCGetSpellTargetObject();
     int nCasterLvl = PRCGetCasterLevel(OBJECT_SELF);
     int nMetaMagic = PRCGetMetaMagicFeat();

     int nDice = (nCasterLvl + 1)/2;
     if (nDice > 5) nDice = 5;

     // Get the spell ID if it was not given.
     if (-1 == nSpellID) nSpellID = GetSpellId();

     // Adjust the damage type of necessary.
     nDamageType = PRCGetElementalDamageType(nDamageType, OBJECT_SELF);

     if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
     {
          // Fire cast spell at event for the specified target
          PRCSignalSpellEvent(oTarget, TRUE, nSpellID);

          // Note that this spell has no spell resistance intentionally in the WotC Miniatures
          // Handbook, bit powerful but that's how it is in the PnP book.

          // Make touch attack, saving result for possible critical
          int nTouchAttack = PRCDoRangedTouchAttack(oTarget);;
          if (nTouchAttack > 0)
          {
               // Roll the damage, doing double damage on a crit.
               int nDamage = PRCGetMetaMagicDamage(nDamageType, 1 == nTouchAttack ? nDice : (nDice * 2), 8);
               nDamage += SpellSneakAttackDamage(OBJECT_SELF, oTarget);
               //nDamage += ApplySpellBetrayalStrikeDamage(oTarget, OBJECT_SELF);

               // Apply the damage and the damage visible effect to the target.
               SPApplyEffectToObject(DURATION_TYPE_INSTANT, PRCEffectDamage(oTarget, nDamage, nDamageType), oTarget);
               PRCBonusDamage(oTarget);
               SPApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
          }
     }

     PRCSetSchool();
}

// Test main
//void main(){}
