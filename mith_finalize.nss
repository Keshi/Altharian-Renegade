/////::///////////////////////////////////////////////
/////:: champ_upgrade - Separate into component properties
/////:: Modified by Winterknight on 6/09/06
/////:: Original script written by Asbury
/////:://////////////////////////////////////////////

#include "x2_inc_itemprop"

void main()
{
  object oPC = GetPCSpeaker();
  object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
  if (!GetIsObjectValid(oItem)) return;
  itemproperty ipFItem;
  location lTrig1 = GetLocation(oItem);

  ipFItem = ItemPropertyCastSpell(335,9);   // Cast spell unique, 2/day.
  AddItemProperty(DURATION_TYPE_PERMANENT,ipFItem,oItem);
  ipFItem = ItemPropertyOnHitCastSpell(125,1);   // On hit unique, level 1.
  AddItemProperty(DURATION_TYPE_PERMANENT,ipFItem,oItem);

// Now we'll need to create a copy of the item, and re-tag it.
   string sNewTag = GetLocalString(oPC,"mithtag");
   object oNewItem = CopyObject(oItem,lTrig1,oPC,sNewTag);
   DestroyObject(oItem,0.1);
   DelayCommand(0.2,ActionEquipItem(oNewItem,INVENTORY_SLOT_RIGHTHAND));
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

    effect eTel1 = EffectVisualEffect(VFX_FNF_SUNBEAM,TRUE);
    object oArea = GetArea(oPC);

  ApplyEffectToObject(DURATION_TYPE_INSTANT,eTel1,oPC,0.3);
  RecomputeStaticLighting(oArea);


}
