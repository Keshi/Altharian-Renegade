/////:://///////////////////////////////////////////////////////////////////////
/////:: Everything's Dark
/////:: Written by Winterknight on 2/9/06
/////:://///////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  effect eBlind = EffectBlindness();
  effect eMove = EffectCutsceneImmobilize();
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oPC, 120.0);
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMove, oPC, 120.0);

}
