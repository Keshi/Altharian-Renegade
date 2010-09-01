//::///////////////////////////////////////////////
//:: FileName giv_immytok_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/15/2005 11:19:42 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("SaintsQuests7",1,oPC,FALSE,FALSE,FALSE);
    CreateItemOnObject("imrahadelstok_1", GetPCSpeaker(), 1);

}
