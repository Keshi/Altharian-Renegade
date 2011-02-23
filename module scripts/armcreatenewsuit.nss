//::///////////////////////////////////////////////
//:: armcreatenewsuit
//:: Written for Altharia by Winterknight
//:://////////////////////////////////////////////
void DestroyGuildArmors (object oPC)
{
  object oArmor = GetFirstItemInInventory(oPC);
  string sTag;
  string sLeft;
  while (oArmor != OBJECT_INVALID)
    {
      sTag = GetTag(oArmor);
      sLeft = GetStringLeft(sTag,6);
      if (sLeft == "guild_")
        {
          DestroyObject(oArmor);
        }
      oArmor = GetNextItemInInventory(oPC);
    }
}

string GetArmorString (int nValue)
{
  string sType;
  if (nValue < 3) sType = "lyt";
  if (nValue > 2 & nValue < 6) sType = "med";
  if (nValue > 5) sType = "hvy";
  return sType;
}

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetLocalObject(oPC,"MODIFY_ITEM");
    if (oItem != OBJECT_INVALID)
      {
        string sStart = "guild_";
        DestroyGuildArmors(oPC);
        int nAC = GetItemACValue(oItem);
        string sAC = GetArmorString (nAC);
        string sNewTag = sStart+sAC;

        location lCopy = GetLocation(oItem);

        // Do the copy and destroy
        object oCopy = CopyObject(oItem,lCopy,oPC,sNewTag);
        SetDroppableFlag(oCopy,FALSE);
        SetIdentified(oCopy,TRUE);
        SetPlotFlag(oCopy,TRUE);
        DestroyObject(oItem,0.1);
        DelayCommand(0.2, AssignCommand(oPC,ActionEquipItem(oCopy,INVENTORY_SLOT_CHEST)));

        SetCampaignInt("Character","guildarmor",4,oPC);
        SetCampaignInt("Character","guildspells",0,oPC);
        SetCampaignInt("Character","guildability",0,oPC);
      }
}
