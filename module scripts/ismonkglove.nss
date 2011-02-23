int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
    string sTag = GetTag(oItem);
    if (sTag == "innerpath") return TRUE;

    return FALSE;
}
