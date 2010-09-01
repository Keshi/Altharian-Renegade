//::///////////////////////////////////////////////
//:: FileName giv_larannatok_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/30/2005 9:20:34 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("SaintsQuests5",3,oPC,FALSE,FALSE,FALSE);
    CreateItemOnObject("larannastok_2", GetPCSpeaker(), 1);

}
