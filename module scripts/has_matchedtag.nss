//::///////////////////////////////////////////////
//:: FileName has_matchedtag
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/7/2006 9:45:36 PM
//:: Modified by Winterknight on 11/30/07 for holysword caveat
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    string sTag = GetTag(OBJECT_SELF);
    int nBool = FALSE;
    if (sTag == "vesperbel")
    {
      if(HasItem(oPC, sTag)) nBool = TRUE;
      sTag = "holysword";
      if(HasItem(oPC, sTag)) nBool = TRUE;
    }
    else if(HasItem(oPC, sTag)) nBool = TRUE;
    return nBool;
}
