/////////////// Church Armor ////////////////////////////////////////////////
/////Written by Winterknigth for Altharia///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC = GetItemActivator();
    int iDice = GetHitDice(oPC);
    //Declare major variables
    object oTarget = oPC;
    int nMod = (iDice/10) + 2;

    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eChar = EffectAbilityIncrease(ABILITY_CONSTITUTION, nMod);

    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eChar, eDur);

    int nDuration = iDice*2; // * Duration 1 turn/level

    //Apply VFX impact and bonus effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));

    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    float fDelay = 0.0;
    eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);

    effect eFear = EffectAttackIncrease(nMod, ATTACK_BONUS_MISC);
    effect eHeal = EffectImmunity(IMMUNITY_TYPE_NEGATIVE_LEVEL);
    effect eGank = EffectDamage(nMod*50,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL);
    eLink = EffectLinkEffects(eFear, eHeal);
    eLink = EffectLinkEffects(eLink, eDur);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());

    //Get the first target in the radius around the caster
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsReactionTypeFriendly(oTarget) || GetFactionEqual(oTarget))
        {
            fDelay = 0.4;
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration)));
        }
        else
        {
            fDelay = 0.4;
            eVis = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eGank, oTarget));
        }
        //Get the next target in the specified area around the caster
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}
