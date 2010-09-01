void main()
{
    object oPC = GetLastUsedBy();
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    object oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_ROBE, 0, TRUE);
    if (GetIsObjectValid(oNew))
    {
        DestroyObject(oItem);
        AssignCommand(oPC, ClearAllActions(TRUE));
        AssignCommand(oPC, ActionEquipItem(oNew, INVENTORY_SLOT_CHEST));
        SendMessageToPC(oPC, "Robe Romoved.");
    }
}
