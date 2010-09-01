/////////////// Mercenary Armor ////////////////////////////////////////////////
/////Written by Winterknigth for Altharia///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetItemActivator();
  int iDice = GetSpellResistance(oPC);
  iDice = iDice * 2;
  effect eBuff = EffectSpellResistanceIncrease(iDice);
  effect eVis = EffectVisualEffect(VFX_DUR_AURA_BLUE,FALSE);
  effect eLink = EffectLinkEffects(eVis,eBuff);
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, 180.0);

}
