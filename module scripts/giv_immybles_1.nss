//::///////////////////////////////////////////////
//:: FileName giv_immybles_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/15/2005 11:26:53 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 1000);

    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 1000);

    // Give the speaker the items
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("SaintsQuests7",2,oPC,FALSE,FALSE,FALSE);
    CreateItemOnObject("imrahadelsbles_1", GetPCSpeaker(), 1);


    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "imrahadelstok_1");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);

}
