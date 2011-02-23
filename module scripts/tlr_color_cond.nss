//::///////////////////////////////////////////////
//:: Tailoring - Color Invalid
//:: tlr_colorinv.nss
//:: Copyright (c) 2006 Stacy L. Ropella
//:://////////////////////////////////////////////
/*
    Tests for invalid colors on weapon parts
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: Created On: February 20, 2006
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iTop = GetItemAppearance(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, GetPCSpeaker()), ITEM_APPR_TYPE_WEAPON_COLOR, ITEM_APPR_WEAPON_COLOR_TOP);
    int iMiddle = GetItemAppearance(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, GetPCSpeaker()), ITEM_APPR_TYPE_WEAPON_COLOR, ITEM_APPR_WEAPON_COLOR_MIDDLE);
    int iBottom  = GetItemAppearance(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, GetPCSpeaker()), ITEM_APPR_TYPE_WEAPON_COLOR, ITEM_APPR_WEAPON_COLOR_BOTTOM);

    if (iTop > 4 || iMiddle > 4 || iBottom > 4)
        return TRUE;
    else
        return FALSE;
}
