/////////////// Shadow Armor ////////////////////////////////////////////////
/////Written by Winterknigth for Altharia///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "wk_tools"

void main()
{

   //Declare major variables
   object oTarget = GetItemActivator();
   effect eVis = EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR);
   int nSneak = GetSneaky(oTarget);
   if (nSneak < 1) nSneak = 1;

   effect eCover = EffectConcealment(24+ (nSneak * 3 / 2));
   effect eLink = EffectLinkEffects(eCover, eVis);

   eLink = ExtraordinaryEffect(eLink);

   //Apply the VFX impact and effects
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(50 + (nSneak*2)));

}
