//::///////////////////////////////////////////////
//:: FileName giv_shathantok_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/30/2005 11:48:18 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("SaintsQuests11",1,oPC,FALSE,FALSE,FALSE);
    CreateItemOnObject("sharthanistok_1", GetPCSpeaker(), 1);

}
