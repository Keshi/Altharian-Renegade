void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC);
    SetLocalObject(oPC,"MAST_MODIFY",oItem);
    SetLocalInt(oPC,"MAST_TYPE",1);


}
