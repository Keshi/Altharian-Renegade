//::///////////////////////////////////////////////
//:: Default: On Rested
//:: NW_C2_DEFAULTA
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    after having just rested.
*/
//:://////////////////////////////////////////////
//:: Created By: Don Moar
//:: Created On: April 28, 2002
//:: modified by Dracwyn
//:: thanks to iceViper
//:://////////////////////////////////////////////
void main()
{
    // enter desired behaviour here

    return;
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
