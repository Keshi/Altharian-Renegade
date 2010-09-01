//::///////////////////////////////////////////////
//:: FileName chk_guildregistr
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/22/2005 12:08:55 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "guildregistry001"))
        return FALSE;
    if(HasItem(GetPCSpeaker(), "halshorsbles_1"))
        return FALSE;
    if(HasItem(GetPCSpeaker(), "halshorsbles_2"))
        return FALSE;
    if(HasItem(GetPCSpeaker(), "halshorsbles_3"))
        return FALSE;
    if(HasItem(GetPCSpeaker(), "jehonbless_1"))
        return FALSE;
    if(HasItem(GetPCSpeaker(), "jehonbless_2"))
        return FALSE;



    return TRUE;
}
