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
    GiveGoldToCreature(GetPCSpeaker(), 2000);

    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 2000);

    // Give the speaker the items
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("SaintsQuests3",4,oPC,FALSE,FALSE,FALSE);
    CreateItemOnObject("johansbles_2", GetPCSpeaker(), 1);


    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "larsthanks2");
    if(GetIsObjectValid(oItemToTake) != 0)
        {
        DestroyObject(oItemToTake);
        }
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "johanstok_2");
    if(GetIsObjectValid(oItemToTake) != 0)
        {
        DestroyObject(oItemToTake);
        }
}
