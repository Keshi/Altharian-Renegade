void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
if ((GetAbilityScore(oPC, ABILITY_DEXTERITY))<= 100)
    {
    FloatingTextStringOnCreature("You tripped", oPC, TRUE);
    object oTarget = oPC;
    effect eEffect = EffectKnockdown();
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 5.0);
    return;
    }
    else
        {
        FloatingTextStringOnCreature("You manage not to trip", oPC, TRUE);
        return;
        }
}

