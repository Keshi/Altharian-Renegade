/////////////// Tower Armor ////////////////////////////////////////////////
/////Written by Winterknigth for Altharia///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "inc_utility"  // for prc_inc_util
#include "prc_inc_util" // for PRCForceRest()

void main()
{
  object oPC = GetItemActivator();
  effect eVis = EffectVisualEffect(VFX_DUR_SANCTUARY);
  effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
  effect eSanc = EffectSanctuary(1);

  effect eLink = EffectLinkEffects(eVis, eSanc);
  eLink = EffectLinkEffects(eLink, eDur);

  int nDuration = 2;
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, RoundsToSeconds(nDuration));
  PRCForceRest(oPC);

}
