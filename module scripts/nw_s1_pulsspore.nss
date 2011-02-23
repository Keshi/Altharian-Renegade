//::///////////////////////////////////////////////
//:: Vrock Spores
//:: NW_S1_PulsSpore
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    A wave of disease spreads out from the creature
    and infects all those within 10ft
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 8, 2002
//:://////////////////////////////////////////////

void main()
{
    //Declare major variables
    float fDelay;
    effect eDisease;
    effect eImpact = EffectVisualEffect(VFX_FNF_HOWL_MIND);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, OBJECT_SELF);
    //Get first target in spell area
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if(oTarget != OBJECT_SELF)
        {
            if(!GetIsReactionTypeFriendly(oTarget))
            {
              int iDam=150;
              if (GetTag(OBJECT_SELF)=="thedamned") iDam=250;
              if (GetTag(OBJECT_SELF)=="seahag") iDam=500;
               if (GetTag(OBJECT_SELF)=="thegrimrazer") iDam=350;



              effect mdamage= EffectDamage(iDam, DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL);
              ApplyEffectToObject(DURATION_TYPE_INSTANT, mdamage,oTarget);
              ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_IMP_PULSE_NATURE),oTarget);



            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(OBJECT_SELF));
    }
}
