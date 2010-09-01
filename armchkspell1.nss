


int StartingConditional()
{
   object oPC=GetPCSpeaker();
   int nCheck = GetCampaignInt("Character","guildspells",oPC);
   if (nCheck < 3) return TRUE;

   return FALSE;

}
