#include "xp_inc"

void main()
{
object oPC =GetPCSpeaker();
 if (GetHitDice(oPC) >= 20)
  {
  int DepositXP = 100000/fraction;
  string sDepositXP = IntToString(DepositXP);
  string sCDKey = GetPCPublicCDKey( oPC);
  int fXP = GetCampaignInt( "XP", sCDKey) + DepositXP;
  int XP = GetXP(oPC) - 100000;
   SetCampaignInt( "XP", sCDKey, fXP);
   SetXP(oPC, XP);
   SpeakString ("You have deposited "+ sDepositXP +" XP.");
  }
else
   {
    SpeakString ("Sorry, but you need to be at least level 20 to use this feature.");
   }
}
