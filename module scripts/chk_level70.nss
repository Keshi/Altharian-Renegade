/////:://////////////////////////////////////////////
/////:: Check for paragon level
/////:: Created On: 10/8/2005 by Winterknight
/////:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "wk_tools"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nLevel = GetEffectiveLevel(oPC);

    // Make sure the PC speaker has these items in their inventory
    if(nLevel<70)
        return FALSE;

    return TRUE;
}
