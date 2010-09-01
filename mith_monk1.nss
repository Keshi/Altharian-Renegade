/////::///////////////////////////////////////////////
/////:: champ_upgrade - Separate into component properties
/////:: Modified by Winterknight on 6/09/06
/////:: Original script written by Asbury
/////:://////////////////////////////////////////////

#include "x2_inc_itemprop"

void main()
{
  object oPC = GetPCSpeaker();
  object oItem = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
  object oCheck = GetLocalObject(oPC,"mithitem");
  if (!GetIsObjectValid(oItem)) return;
  if (oCheck != oItem) return;
  itemproperty ipFItem = GetFirstItemProperty(oItem);
  int nType;
  int nSub;
  location lTrig1 = GetLocation(oItem);

  while (GetIsItemPropertyValid(ipFItem))
  {
    nType = GetItemPropertyType(ipFItem);
    if (nType == ITEM_PROPERTY_ONHITCASTSPELL)
      {
        nSub = GetItemPropertySubType(ipFItem);
        if (nSub == 125)
        {
          RemoveItemProperty(oItem, ipFItem);
          SendMessageToPC(oPC,"Removed On Hit Cast Spell Unique Power");
        }
      }
    if (nType == ITEM_PROPERTY_CAST_SPELL)
      {
        nSub = GetItemPropertySubType(ipFItem);
        if (nSub == 335)
        {
          RemoveItemProperty(oItem, ipFItem);
          SendMessageToPC(oPC,"Removed Cast Spell Unique Power 2/day");
        }
      }
    ipFItem=GetNextItemProperty(oItem);
  }

}
