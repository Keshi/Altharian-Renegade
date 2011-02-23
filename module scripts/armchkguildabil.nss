


int StartingConditional()
{
   object oPC=GetPCSpeaker();
   int nCheck = GetCampaignInt("Character","guildability",oPC);
   if (nCheck < 1) return TRUE;

   return FALSE;

}
