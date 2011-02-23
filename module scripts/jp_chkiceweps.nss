//::///////////////////////////////////////////////
//:: FileName jp_chkiceweps
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 12/24/2005 2:22:53 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "jp_dwiceaxe"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "jp_icescimitar"))
        return FALSE;
    if(!HasItem(GetPCSpeaker(), "jp_ssice"))
        return FALSE;

    return TRUE;
}
