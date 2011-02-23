//::///////////////////////////////////////////////
//:: FileName check_delnodesto
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2/6/2005 4:51:37 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "nodestone_abyss"))
        return FALSE;
    if(HasItem(GetPCSpeaker(), "combinednodes"))
        return FALSE;
    if(HasItem(GetPCSpeaker(), "bookoftheabyss01"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "bookoftheabyss02"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "bookoftheabyss03"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "bookoftheabyss04"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "bookoftheabyss05"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "bookoftheabyss06"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "bookoftheabyss07"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "bookoftheabyss08"))
        return TRUE;
    if(HasItem(GetPCSpeaker(), "bookoftheabyss09"))
        return TRUE;

    return FALSE;
}
