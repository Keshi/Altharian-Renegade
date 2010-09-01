int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC);
    string sTag = GetTag(oItem);
    if (sTag == "harmonics") return TRUE;

    return FALSE;
}
