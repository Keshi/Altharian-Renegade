#include "x2_inc_itemprop"

int StartingConditional()
{
    object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, GetPCSpeaker());

    if(GetIsObjectValid(oItem))
    {
        if(IPGetIsMeleeWeapon(oItem) || IPGetIsRangedWeapon(oItem))
        {
            return TRUE;
        }
    }
    return FALSE;
}
