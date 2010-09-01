/////::///////////////////////////////////////////
/////:: LootShare Solo Script
/////:: Written by Winterknight for Altharia 5/21/07
/////::///////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  location lPC = GetLocation(oPC);
  SetLocalInt(oPC,"LootLock",0);
  effect eVis = EffectVisualEffect(VFX_IMP_KNOCK,FALSE);
  ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis,lPC,0.5);
}
