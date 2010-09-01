//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
// Armor and Weapon Customiser - Zero (Andrew Dahms) - 12th July 2005
// * Imported with Drone.zip
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

void main()
{
    effect eFlash = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);

    ApplyEffectToObject(DURATION_TYPE_INSTANT,eFlash,OBJECT_SELF);
}
