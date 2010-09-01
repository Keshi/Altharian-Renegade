int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    string sTag = GetTag(oItem);
    if (sTag == "stilletto" ||
        sTag == "holysword" ||
        sTag == "innerpath" ||
        sTag == "whitegold" ||
        sTag == "vesperbel" ||
        sTag == "harmonics" ||
        sTag == "fulminate" ||
        sTag == "magestaff") return TRUE;

    return FALSE;
}
