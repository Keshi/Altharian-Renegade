/////:://///////////////////////////////////////////////////////////////////////
/////:: Check for 5 million gold
/////:: Written by Winterknight on 10/7/05
/////:://///////////////////////////////////////////////////////////////////////

int StartingConditional()
{
     object oPC = GetPCSpeaker();
     int NetWorth = GetGold(oPC);
     int Cost = GetLocalInt(oPC,"cashout");
     if(NetWorth>Cost)
       {
        object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    int iTyp = GetBaseItemType(oItem);
    if  (iTyp == BASE_ITEM_BASTARDSWORD  ||
        iTyp == BASE_ITEM_BATTLEAXE  ||
        iTyp == BASE_ITEM_CLUB  ||
        iTyp == BASE_ITEM_DAGGER  ||
        iTyp == BASE_ITEM_DIREMACE  ||
        iTyp == BASE_ITEM_DOUBLEAXE  ||
        iTyp == BASE_ITEM_DWARVENWARAXE  ||
        iTyp == BASE_ITEM_GREATAXE  ||
        iTyp == BASE_ITEM_GREATSWORD  ||
        iTyp == BASE_ITEM_HALBERD  ||
        iTyp == BASE_ITEM_HANDAXE  ||
        iTyp == BASE_ITEM_HEAVYFLAIL  ||
        iTyp == BASE_ITEM_KAMA  ||
        iTyp == BASE_ITEM_KATANA  ||
        iTyp == BASE_ITEM_KUKRI  ||
        iTyp == BASE_ITEM_LIGHTFLAIL  ||
        iTyp == BASE_ITEM_LIGHTHAMMER  ||
        iTyp == BASE_ITEM_LIGHTMACE  ||
        iTyp == BASE_ITEM_LONGSWORD  ||
        iTyp == BASE_ITEM_MAGICSTAFF  ||
        iTyp == BASE_ITEM_MORNINGSTAR  ||
        iTyp == BASE_ITEM_QUARTERSTAFF  ||
        iTyp == BASE_ITEM_RAPIER  ||
        iTyp == BASE_ITEM_SCIMITAR  ||
        iTyp == BASE_ITEM_SCYTHE  ||
        iTyp == BASE_ITEM_SHORTSPEAR  ||
        iTyp == BASE_ITEM_SHORTSWORD  ||
        iTyp == BASE_ITEM_SICKLE  ||
        iTyp == BASE_ITEM_SLING  ||
        iTyp == BASE_ITEM_TRIDENT ||
        iTyp == BASE_ITEM_TWOBLADEDSWORD ||
        iTyp == BASE_ITEM_WARHAMMER  ||
        iTyp == BASE_ITEM_WHIP
        ) return TRUE;

       }
     return FALSE;
}
