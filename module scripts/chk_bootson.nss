/////:://///////////////////////////////////////////////////////////////////////
/////:: Check for 5 million gold
/////:: Written by Winterknight on 10/7/05
/////:://///////////////////////////////////////////////////////////////////////

int StartingConditional()
{
     object oPC = GetPCSpeaker();
     object oItem = GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC);
     if (oItem != OBJECT_INVALID) return TRUE;

     return FALSE;
}
