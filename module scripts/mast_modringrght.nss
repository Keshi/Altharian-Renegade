void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC);
    SetLocalObject(oPC,"MAST_MODIFY",oItem);
    SetLocalInt(oPC,"MAST_TYPE", 5);
    //check for type for crafting
    //if (nType == 1) sCraft = "craftingbelt";    // belts and boots
    //if (nType == 2) sCraft = "craftingshield";  // armor, helm, shield
    //if (nType == 4) sCraft = "craftingcloak";   // cloaks
    //if (nType == 5) sCraft = "craftingring";    // rings and ammys
}
