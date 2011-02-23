/////:://///////////////////////////////////////////////////////////////////////
/////:: Check whether item in right hand of character is a melee weapon
/////:: Modified by Winterknight on 4/5/05
/////:://///////////////////////////////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    int iTyp = GetBaseItemType(oItem);
    if (iTyp == BASE_ITEM_LONGBOW) return TRUE;
    if (iTyp == BASE_ITEM_LIGHTCROSSBOW) return TRUE;
    if (iTyp == BASE_ITEM_HEAVYCROSSBOW) return TRUE;
    if (iTyp == BASE_ITEM_SHORTBOW) return TRUE;
    if (iTyp == BASE_ITEM_SLING) return TRUE;
    return FALSE;
}
