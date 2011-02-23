#include "xp_inc"

void main()
{
object oPC =GetPCSpeaker();
  if (WithdrawCap == TRUE)
   {
    if (GetXP(oPC) >= (XPcap - 49999))
     {
     SpeakString(slvlcap);
     return;
     }
   }
string sCDKey = GetPCPublicCDKey( oPC);;
int fXP = GetCampaignInt( "XP", sCDKey) -50000;

 SetCampaignInt( "XP", sCDKey, fXP);
 GiveXPToCreature(oPC, 50000);
 SpeakString ("You have withdrawn 50,000 XP.");
}
