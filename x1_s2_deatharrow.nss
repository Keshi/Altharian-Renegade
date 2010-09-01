//::///////////////////////////////////////////////
//:: x1_s2_deatharrow
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Seeker Arrow
     - creates an arrow that automatically hits target.
     - At level 4 the arrow does +2 magic damage
     - at level 5 the arrow does +3 magic damage

     - normal arrow damage, based on base item type

     - Must have shortbow or longbow in hand.
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
#include "X0_I0_SPELLS"
#include "x2_inc_itemprop"
#include "wk_tools"

void main()
{
    int nLevel = GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER, OBJECT_SELF);
    int nExtend = GetEffectiveLevel(OBJECT_SELF);
    if (nExtend > 40) nLevel = (nLevel * nExtend / 40);
    int nBonus = ((nLevel+1)/2);
    int nMod = (nLevel / 5) + 2;
    object oTarget = GetSpellTargetObject();

    if (GetIsObjectValid(oTarget) == TRUE)
    {
        // * Roll Touch Attack
        int nTouch = TouchAttackRanged(oTarget, TRUE);
        if (nTouch > 0)
        {
            int nDamage = ArcaneArcherDamageDoneByBow((nTouch ==2));
            nDamage = nDamage * nMod;
            if (nDamage > 0)
            {
                effect ePhysical = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING,IPGetDamagePowerConstantFromNumber(nBonus));
                effect eMagic = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, ePhysical, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eMagic, oTarget);

                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

                // * if target fails a save DC20 they die
                if (MySavingThrow(SAVING_THROW_FORT, oTarget, (20+nMod)) == 0)
                {
                    effect eDeath = EffectDeath();
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget);
                }
            }
        }
    }
}

