#include "mg_items_inc"

void main()
{
    object oPC   = GetLastUsedBy();
    object oItem = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);

    if (GetIsObjectValid(oItem)) {
        int iType = GetBaseItemType(oItem);
        if(iType == BASE_ITEM_HELMET)
        {
            RemakeHelm(oPC, oItem, PART_NEXT);
        }
    }
}

