//::///////////////////////////////////////////////
//:: FileName give_sackofdust
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/27/2005 1:03:12 AM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some XP
    SetCampaignInt("Character","sackofdust",1,GetPCSpeaker());
    // Give the speaker the items
    CreateItemOnObject("sackofdust", GetPCSpeaker(), 1);

}
