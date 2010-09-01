//::///////////////////////////////////////////////
//:: FileName giv_corekstok_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/28/2005 10:45:24 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("SaintsQuests1",1,oPC,FALSE,FALSE,FALSE);
    CreateItemOnObject("corekstok_1", GetPCSpeaker(), 1);

}
