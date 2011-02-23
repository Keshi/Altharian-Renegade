/////::///////////////////////////////////////////////
/////:: forge_guildcheck script - check to make sure not splitting a guild item
/////:: Written by Winterknight on 2/17/06
/////:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    object oForge = GetNearestObjectByTag("darkmithrilforge",OBJECT_SELF,1);
    object oItem = GetFirstItemInInventory(oForge);
    if (GetIsObjectValid(oItem))
      {
        int nBase = GetBaseItemType(oItem);
        if (nBase == BASE_ITEM_CPIERCWEAPON||
            nBase == BASE_ITEM_CREATUREITEM ||
            nBase == BASE_ITEM_CSLASHWEAPON ||
            nBase == BASE_ITEM_CSLSHPRCWEAP)
        return TRUE;
      }
    else if (!GetIsObjectValid(oItem)) return TRUE;
    return FALSE;
}
