//::///////////////////////////////////////////////
//:: x1_s2_seeker
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Seeker Arrow
     - creates an arrow that automatically hits target.
     - normal arrow damage, based on base item type

     - Must have shortbow or longbow in hand.


     APRIL 2003
     - gave it double damage to balance for the fact
       that since its a spell you are losing
       all your other attack actions

     SEPTEMBER 2003 (GZ)
        Added damage penetration
        Added correct enchantment bonus


*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
#include "X0_I0_SPELLS"
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
        int nDamage = ArcaneArcherDamageDoneByBow() *nMod;
        if (nDamage > 0)
        {
            effect ePhysical = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING,IPGetDamagePowerConstantFromNumber(nBonus));
            effect eMagic = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);

          //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 601));

            ApplyEffectToObject(DURATION_TYPE_INSTANT, ePhysical, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eMagic, oTarget);

        }
    }
}
