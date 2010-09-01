void main()
{
object oTarget=GetLastUsedBy();
    // Give the speaker the items
    CreateItemOnObject("lifesend",oTarget, 1);
    effect eDam = EffectDamage(10000, DAMAGE_TYPE_NEGATIVE,DAMAGE_POWER_PLUS_TWENTY);
    string sOldBook = "bookoftheabyss08";
    string sNewBook = "bookoftheabyss09";
    object oBook = GetItemPossessedBy(oTarget,sOldBook);
    if (GetIsObjectValid(oBook))
        {
            DestroyObject(oBook);
            CreateItemOnObject(sNewBook,oTarget,1);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_STRIKE_HOLY),oTarget);
        }

    ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetLocation(oTarget));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(487), oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_BLOOD_CRT_RED), oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_CHUNK_BONE_MEDIUM), oTarget);
    DelayCommand(0.5f, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_FIRE), oTarget));
    DelayCommand(0.5f, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_HIT_DIVINE), oTarget));
    DelayCommand(0.75f, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY_FEMALE), oTarget));
    DelayCommand(0.75f,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_BEAM_BLACK), oTarget));


    DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));

    eDam = EffectDamage(10000, DAMAGE_TYPE_PIERCING,DAMAGE_POWER_PLUS_TWENTY);
    DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));

    eDam = EffectDamage(10000,DAMAGE_TYPE_POSITIVE,DAMAGE_POWER_PLUS_TWENTY);
    DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));

    eDam = EffectDamage(10000,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_PLUS_TWENTY);
    DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));

    eDam = EffectDamage(10000,DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_PLUS_TWENTY);
    DelayCommand(1.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));


}
