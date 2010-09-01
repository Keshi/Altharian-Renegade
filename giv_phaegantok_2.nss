//::///////////////////////////////////////////////
//:: FileName giv_phaegantok_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/30/2005 10:46:23 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("SaintsQuests10",3,oPC,FALSE,FALSE,FALSE);
    CreateItemOnObject("phaeganndalst_2", GetPCSpeaker(), 1);

}
