


int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int nCanDo;
  int nXP = GetLocalInt(oPC,"startchests");
  if (nXP < 1) nCanDo = 1;
  nXP = GetLocalInt(OBJECT_SELF,"startchests");
  if (nXP == 0) nCanDo = 1;

  if (nCanDo == 1) return TRUE;

  return FALSE;
}
