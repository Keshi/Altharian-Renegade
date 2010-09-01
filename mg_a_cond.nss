int StartingConditional()
{
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, GetPCSpeaker());

    if(GetIsObjectValid(oItem))
    {
        int iType = GetBaseItemType(oItem);
        if(iType == BASE_ITEM_ARMOR)
        {
            return TRUE;
        }
    }
    return FALSE;
}
