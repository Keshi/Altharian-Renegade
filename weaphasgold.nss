int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int nCost = GetLocalInt(oPC,"WEAP_COST");
  int nCash = GetGold(oPC);
  if (nCash >= nCost) return FALSE;

  return TRUE;
}
