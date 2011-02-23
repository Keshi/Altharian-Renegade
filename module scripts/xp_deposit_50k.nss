#include "xp_inc"

void main()
{
object oPC =GetPCSpeaker();
 if (GetHitDice(oPC) >= 16)
  {
  int DepositXP = 50000/fraction;
  string sDepositXP = IntToString(DepositXP);
  string sCDKey = GetPCPublicCDKey( oPC);;
  int fXP = GetCampaignInt( "XP", sCDKey) + DepositXP;
  int XP = GetXP(oPC) - 50000;
   SetCampaignInt( "XP", sCDKey, fXP);
   SetXP(oPC, XP);
   SpeakString ("You have deposited "+ sDepositXP +" XP.");
  }
else
   {
    SpeakString ("Sorry, but you need to be at least level 16 to use this feature.");
   }
}
