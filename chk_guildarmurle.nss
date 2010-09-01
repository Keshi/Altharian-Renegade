//::///////////////////////////////////////////////
//:: FileName chk_anvilchip
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/2/2005 4:40:58 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
   object oPC=GetPCSpeaker();
   object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
   string sTag = GetTag(oItem);
   int nValid;
   if (sTag == "guild_hvy" || sTag == "guild_med" || sTag == "guild_lyt") nValid = 1;

     // Make sure the PC speaker has these items in their inventory
   if(HasItem(GetPCSpeaker(), "urleckstok_2") & nValid == 1)
        return TRUE;

    return FALSE;
}
