#include "prc_inc_spells"


void DamageSelf (int nDamageCap, int nVfx)
{
	// Now that the spell has gone off we have to take our damage.
	int nDamage = PRCGetCasterLevel(OBJECT_SELF);
	nDamage = nDamage > nDamageCap ? nDamageCap : nDamage;

	// Apply the damage and appropriate visual effect.
	SPApplyEffectToObject(DURATION_TYPE_INSTANT, PRCEffectDamage(OBJECT_SELF, nDamage, DAMAGE_TYPE_MAGICAL), OBJECT_SELF);
	SPApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(nVfx), OBJECT_SELF);
}

// Test main
//void main(){}
