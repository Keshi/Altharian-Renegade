/////:://///////////////////////////////////////////////////////////////////////
/////:: Check whether item in right hand of character is a melee weapon
/////:: Modified from Nigel Kearney's Forge of Wonder script
/////:: Modified by Winterknight on 10/07/05
/////:://///////////////////////////////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
    int iTyp = GetBaseItemType(oItem);
    if (iTyp == BASE_ITEM_GLOVES ) return TRUE;

    return FALSE;
}


