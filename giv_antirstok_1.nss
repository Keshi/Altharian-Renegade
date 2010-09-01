//::///////////////////////////////////////////////
//:: FileName giv_antirstok_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/28/2005 10:55:02 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("SaintsQuests2",1,oPC,FALSE,FALSE,FALSE);
    CreateItemOnObject("antirstok_1", GetPCSpeaker(), 1);

}
