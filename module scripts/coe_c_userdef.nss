//:: resurecter_od
//:: this one goes to the OnUserDefined event on your "Resurecter Shade"
#include "nw_i0_generic"
void Restore(object oTarget)
{
  effect eVis = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
  effect eRes = EffectResurrection();
  effect eHeal = EffectHeal(1000);
  effect eResurection = EffectLinkEffects(eRes, eHeal);
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eResurection, oTarget);
  DelayCommand(3.0, AssignCommand(oTarget, DetermineCombatRound()));
}
//Main script
void main()
{
  int nEvent = GetUserDefinedEventNumber();
  if (nEvent == EVENT_HEARTBEAT)
  {
    //Find target
    object oTarget = GetNearestCreature(CREATURE_TYPE_RACIAL_TYPE, RACIAL_TYPE_ALL, OBJECT_SELF, 1, CREATURE_TYPE_IS_ALIVE, FALSE);
    //If target is within range and if the "RESTORING" is set 0 (the resurecter haven't resurrected anyone in 3 rounds)
    if (GetDistanceBetween(OBJECT_SELF, oTarget) <= 15.0 && GetLocalInt(OBJECT_SELF, "RESTORING") == 0)
    {
      SetLocalInt(OBJECT_SELF, "RESTORING", 1);
      //Clear all actions, combat included
      ClearAllActions(TRUE);
      //Move to target
      ActionMoveToObject(oTarget, TRUE);
      //Cast fake spell at target
      ActionCastFakeSpellAtObject(SPELL_RESURRECTION, oTarget);
      //Raise the target from the dead
      ActionDoCommand(Restore(oTarget));
      ActionDoCommand(SetCommandable(TRUE, OBJECT_SELF));
      SetCommandable(FALSE, OBJECT_SELF);
      //Make sure the Resurecter can't resurect in 3 rounds
      DelayCommand(18.0, SetLocalInt(OBJECT_SELF, "RESTORING", 0));
    }
  }
}
