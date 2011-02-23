//::///////////////////////////////////////////////
//:: FileName giv_johanstok_2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/2/2005 8:36:14 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    object oPC = GetPCSpeaker();
    CreateItemOnObject("johanstok_2", GetPCSpeaker(), 1);
    AddJournalQuestEntry("SaintsQuests3",3,oPC,FALSE,FALSE,FALSE);
}
