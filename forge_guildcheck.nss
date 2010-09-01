/////::///////////////////////////////////////////////
/////:: forge_guildcheck script - check to make sure not splitting a guild item
/////:: Written by Winterknight on 2/17/06
/////:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    object oForge = GetNearestObjectByTag("forge_custom",OBJECT_SELF,1);
    object oItem = GetFirstItemInInventory(oForge);
    string sCheck = GetStringLeft(GetTag(oItem), 5);
    if (sCheck == "ulme_" ||
        sCheck == "toaa_" ||
        sCheck == "wyrm_" ||
        sCheck == "drag_" ||
        sCheck == "merc_" ||
        sCheck == "t12d_" ||
        sCheck == "just_" ||
        sCheck == "coto_" ||
        sCheck == "shad_" ||
        sCheck == "dash_" )
        {
            return TRUE;
        }

    return FALSE;
}
