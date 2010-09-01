//::///////////////////////////////////////////////
//:: FileName has_noupgrade
//:: This check will return a conditional TRUE if the PC
//:: has no upgrade path.  If they have another upgrade path,
//:: there should be a conversation node to direct them
//:: to the guardian stripper.
//:://////////////////////////////////////////////

#include "nw_i0_tool"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  string sCheck = GetCampaignString("Character","guardianpath",oPC);
  if (sCheck == "")
    return TRUE;

  return FALSE;
}
