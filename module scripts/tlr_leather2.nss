//::///////////////////////////////////////////////
//:: Tailoring - Dye Leather 2
//:: tlr_leather1.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Set the material to be died to Leather 2.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: March 8, 2004
//:://////////////////////////////////////////////

#include "mg_items_inc"

void main()
{
    object oPC = GetPCSpeaker();
    int iMaterialToDye = ITEM_APPR_ARMOR_COLOR_LEATHER2;
    int iEquipmentToDye = GetLocalInt(OBJECT_SELF, "EquipmentToDye");
    object oItem;

    if( iEquipmentToDye == COLOR_ARMOR )
    {
        oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    }
    else
    {
        oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
    }
    SetLocalInt(OBJECT_SELF, "MaterialToDye", iMaterialToDye);

    int iColor = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, iMaterialToDye);

    SendMessageToPC(oPC, "Current Color: " + ClothColor(iColor));
}
