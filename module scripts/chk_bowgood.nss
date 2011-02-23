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
       if (iTyp == BASE_ITEM_HEAVYCROSSBOW  ||
           iTyp == BASE_ITEM_LIGHTCROSSBOW  ||
           iTyp == BASE_ITEM_LONGBOW  ||
           iTyp == BASE_ITEM_SHORTBOW  ||
           iTyp == BASE_ITEM_SLING) return TRUE;

     }
     return FALSE;
}
