int StartingConditional()
{
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, GetPCSpeaker());

    if(GetIsObjectValid(oItem))
    {
        int iType = GetBaseItemType(oItem);
        if(iType == BASE_ITEM_TOWERSHIELD || iType == BASE_ITEM_LARGESHIELD || iType == BASE_ITEM_SMALLSHIELD)
        {
            return TRUE;
        }
    }
    return FALSE;
}
