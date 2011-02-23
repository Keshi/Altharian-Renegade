/////:://////////////////////////////////////////////
/////:: Check for paragon level
/////:: Created On: 10/8/2005 by Winterknight
/////:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nLevel = GetHitDice(oPC);

    // Make sure the PC speaker has these items in their inventory
    if(nLevel<30)   // modified by WK on 1/11/2007 as a waiting action until the new system rolls out.

        return FALSE;

    return TRUE;
}
