void main()
{
  PlaySound ("sff_summon2");
  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_DISPEL_DISJUNCTION),OBJECT_SELF);
  DestroyObject(OBJECT_SELF);
}
