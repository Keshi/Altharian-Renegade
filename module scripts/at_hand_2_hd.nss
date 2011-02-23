void main()
{
object oUser=GetLastUsedBy();
 PlaySound ("as_mg_telepout1");
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_STRIKE_HOLY),oUser);
        DelayCommand(1.0, AssignCommand(oUser, JumpToObject(GetObjectByTag("wp_hand"))));

}
