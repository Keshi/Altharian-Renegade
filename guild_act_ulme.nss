/////////////// Ulme Armor ////////////////////////////////////////////////
/////Written by Winterknigth for Altharia///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void HealingCircle(object oPC)
{
  int nDamagen, nModify, nHurt, nHP;
  object oTarget;
  location lPC = GetLocation(oPC);
  effect eHeal;
  effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_M);
  effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_20);
  float fDelay;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lPC);
    //Get first target in shape
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lPC);
    while (GetIsObjectValid(oTarget))
    {
        fDelay = 0.4;
            if(!GetIsReactionTypeHostile(oTarget) || GetFactionEqual(oTarget, oPC))
            {
                //Fire cast spell at event for the specified target
                eHeal = EffectHeal(1500);
                //Apply heal effect and VFX impact
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
            }
    //Get next target in the shape
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    }

}

void main()
{
    object oPC = GetItemActivator();
    int nLevel = GetHitDice(oPC);
    int nBonus = 2+(nLevel/5);
    float fDuration = 300.0;
    effect eVis = EffectVisualEffect(VFX_DUR_PROT_BARKSKIN);
    effect eHead = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eAC;

    //Make sure the Armor Bonus is of type Natural
    eAC = EffectACIncrease(nBonus, AC_NATURAL_BONUS);
    effect eLink = EffectLinkEffects(eVis, eAC);
    eLink = EffectLinkEffects(eLink, eDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHead, oPC);
    HealingCircle(oPC);
// Added loop to summon the Will o' Wisp Woodland Sprite
    effect eSummon;
    eSummon = EffectSummonCreature("woodlandsprite",VFX_FNF_SUMMON_UNDEAD,0.5f);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSummon, oPC, 1800.0f);

    AddHenchman (oPC, GetObjectByTag("woodlandsprite"));

}
