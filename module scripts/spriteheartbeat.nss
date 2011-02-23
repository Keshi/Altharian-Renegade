// Woodland Sprite Heartbeat script
// Written by Winterknight for Altharia
// Script heals allies in area every 20 seconds

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
        }
        //Get next target in the shape
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    }

void main()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetMaster(oSelf);
    int nBeat = GetLocalInt(oSelf,"healcounter");
    nBeat++;
    if (nBeat%5 == 0)
      {
        HealingCircle(oPC);
      }

}
