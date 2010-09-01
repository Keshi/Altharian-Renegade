//::///////////////////////////////////////////////
//:: FileName giv_halshortok_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/28/2005 11:18:06 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("SaintsQuests4",3,oPC,FALSE,FALSE,FALSE);
    CreateItemOnObject("halshorstok_2", GetPCSpeaker(), 1);

}
