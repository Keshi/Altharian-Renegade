/*   Script generated by
Lilac Soul's NWN Script Generator, v. 2.3

For download info, please visit:
http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625    */

//Put this script OnEnter
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//the VFX will be applied to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION), GetLocation(oTarget));

effect eEffect;
int nEffect, nSwitch;
eEffect = GetFirstEffect(oTarget);
while (GetIsEffectValid(eEffect))
{
  nEffect = GetEffectType(eEffect);
  if (nEffect == EFFECT_TYPE_DAMAGE_IMMUNITY_INCREASE)
  {
    nEffect = GetEffectSubType(eEffect);
    if (nEffect == DAMAGE_TYPE_SONIC) nSwitch = 1;
  }
  eEffect = GetNextEffect(oTarget);
}

eEffect = EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC, 50);

if (nSwitch == 0) ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 300.0f);

eEffect = EffectDamage(500, DAMAGE_TYPE_ELECTRICAL, DAMAGE_POWER_ENERGY);

ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC);

}
