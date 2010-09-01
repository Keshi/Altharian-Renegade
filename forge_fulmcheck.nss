/////::///////////////////////////////////////////////
/////:: forge_guildcheck script - check to make sure not splitting a guild item
/////:: Written by Winterknight on 2/17/06
/////:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    object oForge = GetNearestObjectByTag("forge_custom",OBJECT_SELF,1);
    object oItem = GetFirstItemInInventory(oForge);
    string sCheck = GetTag(oItem);
    if (sCheck == "fulminate" ||
        sCheck == "magestaff" ||
        sCheck == "innerpath" ||
        sCheck == "harmonics" ||
        sCheck == "whitegold" ||
        sCheck == "vesperbel")
        {
            return TRUE;
        }

    return FALSE;
}
