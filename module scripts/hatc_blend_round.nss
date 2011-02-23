//::///////////////////////////////////////////////
//:: Default: End of Combat Round
//:: NW_C2_DEFAULT3
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Calls the end of combat script every round
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:: modified by Dracwyn
//:: thanks to iceViper
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"
void main()
{
    if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
    {
        DetermineSpecialBehavior();
    }
    else if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
    {
       DetermineCombatRound();
    }
    if(GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1003));
    }
effect eshadowblend = EffectConcealment(20);
effect eshadowshroud = EffectVisualEffect(VFX_DUR_DARKNESS);
effect eshadowcloak1 = EffectVisualEffect(VFX_DUR_ETHEREAL_VISAGE);
effect eshadowcloak2 = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eshadowblend, OBJECT_SELF);
//change eshadowcloak1 below to eshadowcloak2 if you prefer the bluish ghostly visage
//to the purplish ethereal visage
//uncomment the line below to apply the ethereal effect
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eshadowcloak1, OBJECT_SELF);
//comment out line below if you would prefer no darkness visual effect with
//shadowblend
//ApplyEffectToObject(DURATION_TYPE_PERMANENT, eshadowshroud, OBJECT_SELF);
}

