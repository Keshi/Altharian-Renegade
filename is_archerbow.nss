int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    string sTag = GetTag(oItem);
    if (sTag == "archerbow") return TRUE;

    return FALSE;
}
