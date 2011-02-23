

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
    int nYes = 0;
    if (oItem != OBJECT_INVALID)
      {
        int nLvl = GetHitDice(oPC);
        string sTag = GetTag(oItem);
        string sLeft = GetStringLeft(sTag,6);
        if (sLeft == "guild_") return FALSE;
        if (nLvl >= 5)
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
        SendMessageToPC(oPC,"You must have armor equipped.");
      }
   return FALSE;
}
