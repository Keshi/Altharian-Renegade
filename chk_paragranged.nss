//::///////////////////////////////////////////////
//:: Check for champion's weapon in hand of PC
//:: Created On: 10/7/2005
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    // Checks for weapon tag in the right hand of the PC
    object oPC = GetPCSpeaker();
    object oWeap = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    string sWeapTag = GetTag(oWeap);
    string sLeftTag = GetStringLeft(sWeapTag,5);
    string sRightTag = GetStringRight(sWeapTag,2);

    if(!GetIsObjectValid(oWeap)) return FALSE;

    if(sLeftTag!="rith_") return FALSE;

    if(sRightTag!="03") return FALSE;

    return TRUE;
}
