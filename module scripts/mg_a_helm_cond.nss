int StartingConditional()
{
    int iResult;

    iResult = GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_HEAD, GetPCSpeaker()));
    return iResult;
}

