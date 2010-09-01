void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
    SetLocalObject(oPC,"WEAP_MODIFY",oItem);

}
