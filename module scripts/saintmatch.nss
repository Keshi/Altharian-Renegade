
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int nAsk = GetLocalInt(oPC,"saintask");
  int nAnswer = GetLocalInt(oPC,"saintanswer");
  if (nAsk == nAnswer) return TRUE;

  return FALSE;
}


