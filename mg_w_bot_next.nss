//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
// Armor and Weapon Customiser - Zero (Andrew Dahms) - 12th July 2005
// * Imported with Drone.zip
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

#include "x2_inc_itemprop"

void main()
{
    object oPC   = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);

    oItem = IPGetModifiedWeapon(oItem,ITEM_APPR_WEAPON_MODEL_BOTTOM,X2_IP_WEAPONTYPE_NEXT,TRUE);

    AssignCommand(oPC,ActionEquipItem(oItem,INVENTORY_SLOT_RIGHTHAND));
}

