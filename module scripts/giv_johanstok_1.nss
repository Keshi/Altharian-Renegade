//::///////////////////////////////////////////////
//:: FileName giv_johanstok_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/25/2005 9:30:47 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("SaintsQuests3",1,oPC,FALSE,FALSE,FALSE);
    CreateItemOnObject("johanstok_1", GetPCSpeaker(), 1);

}
