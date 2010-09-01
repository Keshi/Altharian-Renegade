/* Remove XP from player and give them the item, Divine Demon Gauntlets
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
   if (GetXP (oPC)> 100000)
   {
       CreateItemOnObject("divinecasters", oPC);
       SendMessageToAllDMs  (GetName(oPC)+": -100000 XP buying Divine Demon Gauntlets");
       RemoveXPFromParty(100000, oPC, FALSE);
   }
   else
   {
       SendMessageToPC(oPC,"You do not have 100000 XPs");
   }

}
