/////////////// Mercenary Armor ////////////////////////////////////////////////
/////Written by Winterknight for Altharia///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetItemActivator();
  effect reciprocate = EffectDamageShield (GetHitDice(oPC)/2, DAMAGE_BONUS_5,DAMAGE_TYPE_NEGATIVE);
  effect abyssshield = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE,50);
  effect demonshield = EffectLinkEffects(reciprocate,abyssshield);

  demonshield = SupernaturalEffect(demonshield);

  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,demonshield,oPC,500.0f);
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect (VFX_DUR_PROTECTION_EVIL_MAJOR),oPC,500.0f);
  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_HOWL_WAR_CRY),oPC);

}
