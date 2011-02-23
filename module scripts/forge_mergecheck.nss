/////::///////////////////////////////////////////////
/////:: forge_guildcheck script - check to make sure not splitting a guild item
/////:: Written by Winterknight on 2/17/06
/////:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    object oCombine = GetNearestObjectByTag("forge_combine",OBJECT_SELF,1);
    object oItem = GetFirstItemInInventory(oCombine);
    string sMerge = GetTag(oItem);
    int nType = GetLocalInt(OBJECT_SELF, "ItemType");
  while (GetIsObjectValid(oItem))
    {
    if (nType == 1) // Belts and Boots
        {
            if (sMerge == "craftingbelt" ||
                sMerge == "craftingtoken" )
                return FALSE;
        }

     if (nType == 2) // Armor, Helms, Shields
        {
            if (sMerge == "craftingshield" ||
                sMerge == "craftingtoken" )
                return FALSE;
        }

    if (nType == 3)  // Melee Weapons
        {
            if (sMerge == "craftingdagger" ||
                sMerge == "craftingtoken" )
                return FALSE;
        }

    if (nType == 4)  // Cloaks
        {
            if (sMerge == "craftingcloak" ||
                sMerge == "craftingtoken" )
                return FALSE;
        }

    if (nType == 5)  // Rings and Amulets
        {
            if (sMerge == "craftingring" ||
                sMerge == "craftingtoken" )
                return FALSE;
        }

    if (nType == 6)  // Bows and Crossbows/slings
        {
            if (sMerge == "craftingsling" ||
                sMerge == "craftingtoken" )
                return FALSE;
        }

    if (nType == 7)  // Thrown weapons and ammunition
        {
            if (sMerge == "craftingdirk" ||
                sMerge == "craftingtoken" )
                return FALSE;
        }

    if (nType == 8)  // Common items (miscellaneous or not already covered)
        {
            if (sMerge == "craftingtoken" )
                return FALSE;
        }
  oItem = GetNextItemInInventory(oCombine);
  }
    return TRUE;
}
