/* Remove XP from player and give them the item, Demon Hair Cloak
   Scripted on 11/19/05 by Ith
*/

// Remove XP from player/party function

void RemoveXPFromParty(int nXP, object oPC, int bAllParty=TRUE)
{

  if (!bAllParty)
  {
      nXP=(GetXP(oPC)-nXP)>=0 ? GetXP(oPC)-nXP : 0;
      SetXP(oPC, nXP);
  }
  else
  {
      object oMember=GetFirstFactionMember(oPC, TRUE);
      while (GetIsObjectValid(oMember))
      {
          nXP=(GetXP(oMember)-nXP)>=0 ? GetXP(oMember)-nXP : 0;
          SetXP(oMember, nXP);
          oMember=GetNextFactionMember(oPC, TRUE);
      }
  }
}

// Main, give item and call function

void main()
{

   object oPC = GetPCSpeaker();
   if (GetXP (oPC)> 50000)
   {
       CreateItemOnObject("demonshaircloa", oPC);
       SendMessageToAllDMs  (GetName(oPC)+": -50000 XP buying Demon Hair Cloak");
       RemoveXPFromParty(50000, oPC, FALSE);
   }
   else
   {
       SendMessageToPC(oPC,"You do not have 50000 XPs");
   }

}
