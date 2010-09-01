/////::///////////////////////////////////////////////
/////:: forge_guildcheck script - check to make sure not splitting a guild item
/////:: Written by Winterknight on 2/17/06
/////:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    object oForge = GetNearestObjectByTag("forge_custom",OBJECT_SELF,1);
    object oItem = GetFirstItemInInventory(oForge);
    if (!GetIsObjectValid(oItem))
        return TRUE;

    return FALSE;
}
