/////////////// Dragon Armor ////////////////////////////////////////////////
/////Written by Winterknigth for Altharia///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetItemActivator();
    int nDamage = 0;
    int nDC = GetHitDice(oPC);
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_HOWL_MIND);

    location lTarget = GetLocation(oPC);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    DelayCommand(1.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget));
    DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget));
    DelayCommand(4.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget));

//  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShake, OBJECT_SELF, 2.0f);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget, oPC))
        {
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            nDamage = d10(nDC);
            effect eFire = EffectDamage(nDamage,DAMAGE_TYPE_FIRE);
            nDamage = d10(nDC);
            effect eFrost= EffectDamage(nDamage,DAMAGE_TYPE_COLD);
            nDamage = d10(nDC);
            effect eAcid = EffectDamage(nDamage,DAMAGE_TYPE_ACID);
            nDamage = d10(nDC);
            effect eLight = EffectDamage(nDamage,DAMAGE_TYPE_ELECTRICAL);

            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
            DelayCommand(fDelay+1.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFrost, oTarget));
            DelayCommand(fDelay+3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eAcid, oTarget));
            DelayCommand(fDelay+4.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLight, oTarget));

        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
}

