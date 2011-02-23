#include "mg_items_inc"

void main()
{
    object oPC   = GetLastUsedBy();
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    RemakeArmor(oPC, oItem, ITEM_APPR_ARMOR_MODEL_ROBE, PART_NEXT);
}
