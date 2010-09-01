//::///////////////////////////////////////////////
//:: FileName giv_urleckstok_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/2/2005 4:19:07 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    object oPC = GetPCSpeaker();
    CreateItemOnObject("urleckstok_2", oPC, 1);
    AddJournalQuestEntry("SaintsQuests9",3,oPC,FALSE,FALSE,FALSE);

}
