//::///////////////////////////////////////////////
//:: FileName chk_urleckbles_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/2/2005 4:45:20 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "urlecksbles_1"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "jehonbless_1"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "jehonbless_1_1"))
        return TRUE;



    return FALSE;
}
