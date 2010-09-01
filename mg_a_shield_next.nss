#include "mg_items_inc"

void main()
{
    object oPC   = GetLastUsedBy();
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);

    if (GetIsObjectValid(oItem)) {
        int iType = GetBaseItemType(oItem);
        if(iType == BASE_ITEM_TOWERSHIELD || iType == BASE_ITEM_LARGESHIELD || iType == BASE_ITEM_SMALLSHIELD)
        {
            RemakeShield(oPC, oItem, PART_NEXT);
        }
    }
}


