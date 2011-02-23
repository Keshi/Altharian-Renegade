#include "xp_inc"

void main()
{
string sPenalty = IntToString(Penalty);
SetCustomToken(698,sPenalty);
object oPC =GetPCSpeaker();
string sCDKey = GetPCPublicCDKey( oPC);
int XP = (GetCampaignInt( "XP", sCDKey));
string sXP = IntToString(XP);
  if  (XP > 1)
        {
          SetCustomToken(699,sXP);
        }
      else
         {
         string zero = IntToString(0);
          SetCustomToken(699,zero);
         }
}
