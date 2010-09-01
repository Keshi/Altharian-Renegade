//::///////////////////////////////////////////////
//:: Tailoring - Color Weapon Top
//:: tlr_colorweaptop.nss
//:: Copyright (c) 2006 Stacy L. Ropella
//:://////////////////////////////////////////////
/*
    Changes the color on an equipped weapon
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: Created On: January 29, 2006
//:://////////////////////////////////////////////

#include "mg_items_inc"

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    ColorWeapon(oPC, oItem, ITEM_APPR_WEAPON_MODEL_MIDDLE, COLOR_NEXT);
}
