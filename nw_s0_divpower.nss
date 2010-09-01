//::///////////////////////////////////////////////
//:: Divine Power
//:: NW_S0_DivPower.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Improves the Clerics attack to be the
    equivalent of a Fighter's BAB of the same level,
    +1 HP per level and raises their strength to
    18 if is not already there.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 21, 2001
//:://////////////////////////////////////////////

/*
bugfix by Kovi 2002.07.22
- temporary hp was stacked
- loosing temporary hp resulted in loosing the other bonuses
- number of attacks was not increased (should have been a BAB increase)
still problem:
~ attacks are better still approximation (the additional attack is at full BAB)
~ attack/ability bonuses count against the limits
*/

#include "nw_i0_spells"
#include "wk_tools"

#include "x2_inc_spellhook"

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

    RemoveEffectsFromSpell(oTarget, GetSpellId());
    RemoveTempHitPoints();

    int nVesper = GetVesper(OBJECT_SELF);
    int nMod = 1;
    int nLevel = GetCasterLevel(OBJECT_SELF);
    int nTotalLevel = GetHitDice(OBJECT_SELF);
    if (nVesper == 1 || nVesper == 4)
      {
        nLevel = GetEffectiveCasterLevel(OBJECT_SELF);
        nTotalLevel = GetEffectiveLevel(OBJECT_SELF);
        nMod = ((nLevel - 10) / 10) + 1;
      }

    int nCasterLevel = nLevel;
    int nTotalCharacterLevel = nTotalLevel;
    int nBAB = GetBaseAttackBonus(OBJECT_SELF);
    int nEpicPortionOfBAB = ( nTotalCharacterLevel - 19 ) / 2;

    if ( nEpicPortionOfBAB < 0 )
    {
        nEpicPortionOfBAB = 0;
    }
    if ( nEpicPortionOfBAB > 10 )
    {
        nEpicPortionOfBAB = 10;
    }


    int nExtraAttacks = 0;
    int nAttackIncrease = 0;

    if ( nTotalCharacterLevel > 20 )
    {
        nAttackIncrease = 20 + nEpicPortionOfBAB;
        if( nBAB - nEpicPortionOfBAB < 1 ) nExtraAttacks = 3;


        if( nBAB - nEpicPortionOfBAB > 1 && nBAB - nEpicPortionOfBAB < 11 )
        {
            nExtraAttacks = 2;
        }
        else if( nBAB - nEpicPortionOfBAB > 10 && nBAB - nEpicPortionOfBAB < 16)
        {
            nExtraAttacks = 1;
        }
    }
    else
    {
        nAttackIncrease = nTotalCharacterLevel;
        nExtraAttacks = ( ( nTotalCharacterLevel - 1 ) / 5 ) - ( ( nBAB - 1 ) / 5 );
    }
    nAttackIncrease -= nBAB;

    if ( nAttackIncrease < 0 )
    {
        nAttackIncrease = 0;
    }

    int nStr = GetAbilityScore(oTarget, ABILITY_STRENGTH);
    int nTop = 50;
    if (nLevel < nTop) nTop = nLevel;
    if (nTop < 18) nTop = 18;
    int nStrengthIncrease = (nTop - nStr);
    if( nStrengthIncrease < 0 )
    {
        nStrengthIncrease = 0;
    }

    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eStrength = EffectAbilityIncrease(ABILITY_STRENGTH, nStrengthIncrease);
    effect eHP = EffectTemporaryHitpoints(nCasterLevel * 2);
    effect eAttack = EffectAttackIncrease(nAttackIncrease);
    effect eAttackMod = EffectModifyAttacks(nExtraAttacks);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eAttack, eAttackMod);
    eLink = EffectLinkEffects(eLink, eDur);

    //Make sure that the strength modifier is a bonus
    if( nStrengthIncrease > 0 )
    {
        eLink = EffectLinkEffects(eLink, eStrength);
    }

    //Meta-Magic
    int nMetaMagic = GetMetaMagicFeat();
    if( nMetaMagic == METAMAGIC_EXTEND )
    {
        nCasterLevel *= 2;
    }

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DIVINE_POWER, FALSE));

    //Apply Link and VFX effects to the target
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nCasterLevel));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, RoundsToSeconds(nCasterLevel));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}

