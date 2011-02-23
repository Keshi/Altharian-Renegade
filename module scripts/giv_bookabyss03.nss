/* Remove XP from player and give them the item, Rabid Maggots
   Scripted on 11/19/05 by Ith
*/

// Remove XP function

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

// Main

void main()
{

   object oPC = GetPCSpeaker();
   if (GetXP (oPC)> 3000)
   {
       object oBook = GetItemPossessedBy(oPC,"bookoftheabyss02");
       DestroyObject(oBook);
       CreateItemOnObject("bookoftheabyss03", oPC);
       ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect (VFX_FNF_STRIKE_HOLY),oPC);
       RemoveXPFromParty(3000, oPC, FALSE);
   }
   else
   {
       SendMessageToPC(oPC,"You do not have 3000 XPs");
   }

}
