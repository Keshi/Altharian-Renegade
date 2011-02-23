//::///////////////////////////////////////////////
//:: FileName giv_urleckbles_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/2/2005 4:45:20 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 1000);

    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 1000);

    // Give the speaker the items
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("SaintsQuests9",2,oPC,FALSE,FALSE,FALSE);
    CreateItemOnObject("urlecksbles_1", GetPCSpeaker(), 1);


    // Remove items from the player's inventory
    object oItemToTake2;
    oItemToTake2 = GetItemPossessedBy(GetPCSpeaker(), "urleckstok_1");
    if(GetIsObjectValid(oItemToTake2) != 0)
        DestroyObject(oItemToTake2);
}
