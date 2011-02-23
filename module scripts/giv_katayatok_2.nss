//::///////////////////////////////////////////////
//:: FileName giv_katayatok_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/30/2005 9:57:12 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("SaintsQuests12",3,oPC,FALSE,FALSE,FALSE);
    CreateItemOnObject("katayamoranst_2", GetPCSpeaker(), 1);

}
