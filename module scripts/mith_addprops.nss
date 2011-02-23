/////::///////////////////////////////////////////////
/////:: mith_finalize - create a guardian weapon
/////:: Written by Winterknight 10/29/07
/////:://////////////////////////////////////////////

#include "x2_inc_itemprop"

void main()
{
  object oPC = GetPCSpeaker();
  object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
  if (!GetIsObjectValid(oItem)) return;
  itemproperty ipFItem;

  ipFItem = ItemPropertyCastSpell(335,9);   // Cast spell unique, 2/day.
  AddItemProperty(DURATION_TYPE_PERMANENT,ipFItem,oItem);
  ipFItem = ItemPropertyOnHitCastSpell(125,1);   // On hit unique, level 1.
  AddItemProperty(DURATION_TYPE_PERMANENT,ipFItem,oItem);

   int nMithCost = GetLocalInt(oPC,"mithcount");
   if (nMithCost > 0)
   {
     int nMithril = GetCampaignInt("12Dark2","mithril",oPC);
     nMithril = nMithril-nMithCost;
     SetCampaignInt("12Dark2","mithril",nMithril,oPC);
   }

// Last thing: take the money, vis effect
   int nCash = GetLocalInt(oPC,"cashout");
   TakeGoldFromCreature(nCash,oPC,TRUE);

}
