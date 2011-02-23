//::///////////////////////////////////////////////
//:: FileName giv_johansbles_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/25/2005 9:39:47 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 500);

    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 1000);

    // Give the speaker the items
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("SaintsQuests3",2,oPC,FALSE,FALSE,FALSE);
    CreateItemOnObject("johansbles_1", GetPCSpeaker(), 1);


    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "larsthanks");
    if(GetIsObjectValid(oItemToTake) != 0)
        {
        DestroyObject(oItemToTake);
        }
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "johanstok_1");
    if(GetIsObjectValid(oItemToTake) != 0)
        {
        DestroyObject(oItemToTake);
        }
}
