void main()
{
    if (GetLocalInt(OBJECT_SELF, "nTriggered") == 1)
        return;
    object oCreature = GetEnteringObject();

    effect eDamage = EffectDamage(d20(15) + 20);
    effect vEffect = EffectVisualEffect(VFX_DUR_ETHEREAL_VISAGE);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, vEffect, oCreature, 6.0);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oCreature);

    if (GetIsPC(oCreature) == TRUE)
        SetLocalInt(OBJECT_SELF, "nTriggered", 0);
}
