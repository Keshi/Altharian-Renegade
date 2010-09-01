//::///////////////////////////////////////////////
//:: FileName giv_rechardtok_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/30/2005 11:31:50 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("SaintsQuests8",3,oPC,FALSE,FALSE,FALSE);
    CreateItemOnObject("rechardstok_2", GetPCSpeaker(), 1);

}
