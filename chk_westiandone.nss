//::///////////////////////////////////////////////
//:: FileName chk_signedretrac
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/2/2005 9:09:21 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "signedretraction"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "larsthanks2"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "johansbles_2"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "johansbles_3"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "jehonsbless_2"))
        return TRUE;

    return FALSE;
}
