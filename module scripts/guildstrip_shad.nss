/////:://///////////////////////////////////////////////////////////////////////
/////:: Guild Item stripper script
/////:: Written by Winterknight for Altharia 11/2/05
/////:: As written, must be called from a conversation - standard script will strip all guilds.
/////:://///////////////////////////////////////////////////////////////////////

void StripGuildItem (object oGuildItem)
{
    string sItemTag = GetTag(oGuildItem);
    string sLeftFour = GetStringLeft(sItemTag, 5);
    if (sLeftFour == "just_" ||
        sLeftFour == "ulme_" ||
        sLeftFour == "t12d_" ||
        sLeftFour == "wyrm_" ||
        sLeftFour == "merc_" ||
        sLeftFour == "dash_" ||
        sLeftFour == "coto_" ||
        sLeftFour == "drag_" ||
//        sLeftFour == "shad_" ||
        sLeftFour == "toaa_")
        {
            DestroyObject(oGuildItem);
        }
}

void main()
{
    object oPC=GetPCSpeaker();
    object oGuildItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oGuildItem))
        {
            StripGuildItem (oGuildItem);
            oGuildItem = GetNextItemInInventory(oPC);
        }

    oGuildItem = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
    if (GetIsObjectValid(oGuildItem))
        {
            StripGuildItem (oGuildItem);
        }

    oGuildItem = GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC);
    if (GetIsObjectValid(oGuildItem))
        {
            StripGuildItem (oGuildItem);
        }

    oGuildItem = GetItemInSlot(INVENTORY_SLOT_BELT, oPC);
    if (GetIsObjectValid(oGuildItem))
        {
            StripGuildItem (oGuildItem);
        }

    oGuildItem = GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC);
    if (GetIsObjectValid(oGuildItem))
        {
            StripGuildItem (oGuildItem);
        }

    oGuildItem = GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC);
    if (GetIsObjectValid(oGuildItem))
        {
            StripGuildItem (oGuildItem);
        }

    oGuildItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    if (GetIsObjectValid(oGuildItem))
        {
            StripGuildItem (oGuildItem);
        }

    oGuildItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);
    if (GetIsObjectValid(oGuildItem))
        {
            StripGuildItem (oGuildItem);
        }

    oGuildItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
    if (GetIsObjectValid(oGuildItem))
        {
            StripGuildItem (oGuildItem);
        }

    oGuildItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    if (GetIsObjectValid(oGuildItem))
        {
            StripGuildItem (oGuildItem);
        }

    oGuildItem = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC);
    if (GetIsObjectValid(oGuildItem))
        {
            StripGuildItem (oGuildItem);
        }

    oGuildItem = GetItemInSlot(INVENTORY_SLOT_NECK, oPC);
    if (GetIsObjectValid(oGuildItem))
        {
            StripGuildItem (oGuildItem);
        }

    oGuildItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    if (GetIsObjectValid(oGuildItem))
        {
            StripGuildItem (oGuildItem);
        }

    oGuildItem = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC);
    if (GetIsObjectValid(oGuildItem))
        {
            StripGuildItem (oGuildItem);
        }

}
