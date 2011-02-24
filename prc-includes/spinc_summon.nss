#include "prc_inc_spells"


void sp_summon(string creature, int impactVfx)
{
    PRCSetSchool(SPELL_SCHOOL_CONJURATION);

    // Check to see if the spell hook cancels the spell.
    if (!X2PreSpellCastCode()) return;

    // Get the duration, base of 24 hours, modified by metamagic
    float fDuration = PRCGetMetaMagicDuration(HoursToSeconds(24));

    // Apply impact VFX and summon effects.
    MultisummonPreSummon();
    if(GetPRCSwitch(PRC_SUMMON_ROUND_PER_LEVEL))
        fDuration = PRCGetMetaMagicDuration(RoundsToSeconds(PRCGetCasterLevel()*GetPRCSwitch(PRC_SUMMON_ROUND_PER_LEVEL)));
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(impactVfx),
                          PRCGetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectSummonCreature(creature),
                          PRCGetSpellTargetLocation(), fDuration);

    if (GetHasFeat(FEAT_AUGMENT_SUMMON, OBJECT_SELF))
    {
        DelayCommand(0.5, AugmentSummonedCreature());
    }

    PRCSetSchool();
}

// Test main
//void main(){}
