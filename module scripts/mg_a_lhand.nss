//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
// Armor and Weapon Customiser - Zero (Andrew Dahms) - 12th July 2005
// * Imported with Drone.zip
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

#include "x2_inc_itemprop"

void main()
{
    object oPC   = GetLastUsedBy();
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);

    oItem = IPGetModifiedArmor(oItem,ITEM_APPR_ARMOR_MODEL_LHAND,X2_IP_ARMORTYPE_NEXT,TRUE);

    AssignCommand(oPC,ActionEquipItem(oItem,INVENTORY_SLOT_CHEST));
}

