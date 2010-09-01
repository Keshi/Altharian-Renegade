

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
    string sTag = GetTag(oItem);
    string sLeft = GetStringLeft(sTag,6);
    int nYes = 0;
    if (sLeft == "guild_")
      {
        int nCanDo = GetCampaignInt("Character","guildarmor",oPC);
        int nLvl = GetHitDice(oPC);
        if (nCanDo >= 4 & nLvl >= 5)
          {
            string sGuild = GetCampaignString("Character","guild",oPC);
            if (sGuild != "")
              {
                nYes = TRUE;
              }
            else
              {
                SendMessageToPC(oPC,"You are not a member of an acknowledged guild.");
                nYes = FALSE;
              }
          }
        SetLocalObject(oPC, "MODIFY_ITEM", oItem);
        return nYes;
      }
    else
      {
        SendMessageToPC(oPC,"You must have guild armor equipped.");
      }
   return FALSE;
}
