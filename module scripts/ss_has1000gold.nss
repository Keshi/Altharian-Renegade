// Created By: Barry
// Created On: 5/12/2006

object oCreature = GetPCSpeaker();
int oGold = GetGold(oCreature);
int StartingConditional()
{
if(oGold < 1000)
  {
  ActionSpeakString("You can't afford my services. You must have at least 1,000 gold.",TALKVOLUME_TALK);
  return FALSE;
  }
  else
  {
  return TRUE;
  }
}

