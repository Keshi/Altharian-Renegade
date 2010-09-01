// Created By: Barry
// Created On: 5/12/2006
void main()
{
object oCreature = GetPCSpeaker();
int oGold = GetGold(oCreature);
if(oGold < 1000000)
  {
  ActionSpeakString("You can't afford my services. You must have at least 1,000,000 gold.",TALKVOLUME_TALK);
  }
  else
  {
  effect oEffect =  EffectVisualEffect(VFX_IMP_HEAD_ODD,FALSE);
  ApplyEffectToObject(DURATION_TYPE_INSTANT,oEffect,oCreature,0.0f);
  TakeGoldFromCreature(1000000, GetPCSpeaker(), TRUE);
  AdjustAlignment(oCreature, ALIGNMENT_NEUTRAL, 100);
  AdjustAlignment(oCreature, ALIGNMENT_LAWFUL, 50);
  }
}
