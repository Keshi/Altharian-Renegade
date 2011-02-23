/////::///////////////////////////////////////////////
/////:: forge_guildcheck script - check to make sure not splitting a guild item
/////:: Written by Winterknight on 2/17/06
/////:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    object oForge = GetNearestObjectByTag("forge_custom",OBJECT_SELF,1);
    object oItem = GetFirstItemInInventory(oForge);
    int nBase = GetBaseItemType (oItem);
    int nType = GetLocalInt(OBJECT_SELF, "ItemType");

    if (nType == 1) // Belts and Boots
        {
            if (nBase == BASE_ITEM_BOOTS ||
                nBase == BASE_ITEM_MISCLARGE ||
                nBase == BASE_ITEM_MISCMEDIUM||
                nBase == BASE_ITEM_MISCSMALL ||
                nBase == BASE_ITEM_MISCTALL  ||
                nBase == BASE_ITEM_MISCTHIN  ||
                nBase == BASE_ITEM_MISCWIDE  ||
                nBase == BASE_ITEM_BELT)
                return FALSE;
        }

     if (nType == 2) // Armor, Helms, Shields
        {
            if (nBase == BASE_ITEM_TOWERSHIELD ||
                nBase == BASE_ITEM_MISCLARGE ||
                nBase == BASE_ITEM_MISCMEDIUM||
                nBase == BASE_ITEM_MISCSMALL ||
                nBase == BASE_ITEM_MISCTALL  ||
                nBase == BASE_ITEM_MISCTHIN  ||
                nBase == BASE_ITEM_MISCWIDE  ||
                nBase == BASE_ITEM_SMALLSHIELD ||
                nBase == BASE_ITEM_HELMET      ||
                nBase == BASE_ITEM_ARMOR       ||
                nBase == BASE_ITEM_BRACER      ||
                nBase == BASE_ITEM_LARGESHIELD)
                return FALSE;
        }

    if (nType == 3)  // Melee Weapons
        {
            if (nBase == BASE_ITEM_GLOVES ||
                nBase == BASE_ITEM_MISCLARGE ||
                nBase == BASE_ITEM_MISCMEDIUM||
                nBase == BASE_ITEM_MISCSMALL ||
                nBase == BASE_ITEM_MISCTALL  ||
                nBase == BASE_ITEM_MISCTHIN  ||
                nBase == BASE_ITEM_MISCWIDE  ||
                nBase == BASE_ITEM_BASTARDSWORD ||
                nBase == BASE_ITEM_BATTLEAXE||
                nBase == BASE_ITEM_DAGGER ||
                nBase == BASE_ITEM_CLUB  ||
                nBase == BASE_ITEM_DIREMACE  ||
                nBase == BASE_ITEM_DOUBLEAXE  ||
                nBase == BASE_ITEM_DWARVENWARAXE ||
                nBase == BASE_ITEM_GREATAXE||
                nBase == BASE_ITEM_GREATSWORD ||
                nBase == BASE_ITEM_HALBERD  ||
                nBase == BASE_ITEM_HANDAXE  ||
                nBase == BASE_ITEM_HEAVYFLAIL  ||
                nBase == BASE_ITEM_KAMA ||
                nBase == BASE_ITEM_KATANA||
                nBase == BASE_ITEM_KUKRI ||
                nBase == BASE_ITEM_LIGHTFLAIL  ||
                nBase == BASE_ITEM_LIGHTHAMMER  ||
                nBase == BASE_ITEM_LIGHTMACE  ||
                nBase == BASE_ITEM_LONGSWORD  ||
                nBase == BASE_ITEM_MORNINGSTAR  ||
                nBase == BASE_ITEM_QUARTERSTAFF  ||
                nBase == BASE_ITEM_RAPIER  ||
                nBase == BASE_ITEM_SCIMITAR  ||
                nBase == BASE_ITEM_SCYTHE  ||
                nBase == BASE_ITEM_SHORTSPEAR  ||
                nBase == BASE_ITEM_SHORTSWORD  ||
                nBase == BASE_ITEM_SICKLE  ||
                nBase == BASE_ITEM_TWOBLADEDSWORD  ||
                nBase == BASE_ITEM_WARHAMMER  ||
                nBase == BASE_ITEM_WHIP)
                return FALSE;
        }

    if (nType == 4)  // Cloaks
        {
            if (nBase == BASE_ITEM_CLOAK ||
                nBase == BASE_ITEM_MISCLARGE ||
                nBase == BASE_ITEM_MISCMEDIUM||
                nBase == BASE_ITEM_MISCSMALL ||
                nBase == BASE_ITEM_MISCTALL  ||
                nBase == BASE_ITEM_MISCTHIN  ||
                nBase == BASE_ITEM_MISCWIDE )
                return FALSE;
        }

    if (nType == 5)  // Rings and Amulets
        {
            if (nBase == BASE_ITEM_RING ||
                nBase == BASE_ITEM_MISCLARGE ||
                nBase == BASE_ITEM_MISCMEDIUM||
                nBase == BASE_ITEM_MISCSMALL ||
                nBase == BASE_ITEM_MISCTALL  ||
                nBase == BASE_ITEM_MISCTHIN  ||
                nBase == BASE_ITEM_MISCWIDE  ||
                nBase == BASE_ITEM_AMULET)
                return FALSE;
        }

    if (nType == 6)  // Bows and Crossbows/slings
        {
            if (nBase == BASE_ITEM_LONGBOW ||
                nBase == BASE_ITEM_MISCLARGE ||
                nBase == BASE_ITEM_MISCMEDIUM||
                nBase == BASE_ITEM_MISCSMALL ||
                nBase == BASE_ITEM_MISCTALL  ||
                nBase == BASE_ITEM_MISCTHIN  ||
                nBase == BASE_ITEM_MISCWIDE  ||
                nBase == BASE_ITEM_LIGHTCROSSBOW ||
                nBase == BASE_ITEM_HEAVYCROSSBOW||
                nBase == BASE_ITEM_SHORTBOW ||
                nBase == BASE_ITEM_SLING )
                return FALSE;
        }

    if (nType == 7)  // Thrown weapons and ammunition
        {
            if (nBase == BASE_ITEM_ARROW ||
                nBase == BASE_ITEM_MISCLARGE ||
                nBase == BASE_ITEM_MISCMEDIUM||
                nBase == BASE_ITEM_MISCSMALL ||
                nBase == BASE_ITEM_MISCTALL  ||
                nBase == BASE_ITEM_MISCTHIN  ||
                nBase == BASE_ITEM_MISCWIDE  ||
                nBase == BASE_ITEM_BOLT ||
                nBase == BASE_ITEM_BULLET||
                nBase == BASE_ITEM_DART ||
                nBase == BASE_ITEM_GRENADE  ||
                nBase == BASE_ITEM_SHURIKEN  ||
                nBase == BASE_ITEM_THROWINGAXE )
                return FALSE;
        }

    if (nType == 8)  // Common items (miscellaneous or not already covered)
        {
            if (nBase == BASE_ITEM_BOOK ||
                nBase == BASE_ITEM_MISCLARGE ||
                nBase == BASE_ITEM_MISCMEDIUM||
                nBase == BASE_ITEM_MISCSMALL ||
                nBase == BASE_ITEM_MISCTALL  ||
                nBase == BASE_ITEM_MISCTHIN  ||
                nBase == BASE_ITEM_MISCWIDE  ||
                nBase == BASE_ITEM_MAGICROD||
                nBase == BASE_ITEM_LARGEBOX ||
                nBase == BASE_ITEM_MAGICSTAFF  ||
                nBase == BASE_ITEM_MAGICWAND )
                return FALSE;
        }

    return TRUE;
}
