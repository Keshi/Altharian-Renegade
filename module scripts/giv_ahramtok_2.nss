//::///////////////////////////////////////////////
//:: FileName giv_ahramtok_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/28/2005 10:30:23 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("SaintsQuests6",3,oPC,FALSE,FALSE,FALSE);
    CreateItemOnObject("ahramstok_2", GetPCSpeaker(), 1);

}
