//::///////////////////////////////////////////////
//:: FileName has_magestaff
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/7/2006 9:45:36 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    string sTag = "fulminate";
    if (HasItem(oPC,sTag)) return TRUE;

    return FALSE;
}
