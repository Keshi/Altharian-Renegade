/////::///////////////////////////////////////////////
/////:: forge_combinecheck script - check to make sure items in combine are correct
/////:: Written by Winterknight on 2/17/06
/////:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    object oForge = GetNearestObjectByTag("forge_combine",OBJECT_SELF,1);
    object oItem = GetFirstItemInInventory(oForge);
    if (!GetIsObjectValid(oItem))
        return TRUE;

    return FALSE;
}
