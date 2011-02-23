#include "wk_tools"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
    int nYes = 0;
    if (oItem != OBJECT_INVALID)
      {
        int nCanDo = GetCampaignInt("Character","guildarmor",oPC);
        int nLvl = GetEffectiveLevel(oPC);
        if (nLvl > 40)
          {
            nLvl = 40 + ((nLvl - 40) / 10);
          }
        if (nCanDo >=1 & nLvl >= nCanDo)
          {
            string sTag = GetTag(oItem);
            string sLeft = GetStringLeft(sTag,6);
            if (sLeft == "guild_")
              {
                nYes = TRUE;
                SetLocalObject(oPC, "MODIFY_ITEM", oItem);
                SetLocalInt(oPC,"guildarmpts",(nLvl - nCanDo));
              }
            else
              {
                SendMessageToPC(oPC,"You do not have your Guild Armor equipped.");
                nYes = FALSE;
              }
            return nYes;
          }
      }
   return FALSE;
}
