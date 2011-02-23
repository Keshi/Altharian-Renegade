#include "xp_inc"

void main()
{
 object oPC = GetPCSpeaker();
if (GetHitDice(oPC) >= lvl)
 {
 string sCDKey = GetPCPublicCDKey( oPC);
 int XP = GetCampaignInt( "XP", sCDKey) + (GetXP( oPC) /fraction);
 SetCampaignInt( "XP", sCDKey, XP);
 string sXP = IntToString((GetXP( oPC) /fraction));
 SpeakString ("You have deposited " + sXP + " XP");
 SetXP (oPC, 1);
 }
  else
   {
   SpeakString(sNO);
   }
}
