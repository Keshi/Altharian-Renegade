//::///////////////////////////////////////////////
//:: FileName giv_rechardbls_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/30/2005 11:37:57 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 2000);

    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 2000);

    // Give the speaker the items
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("SaintsQuests8",4,oPC,FALSE,FALSE,FALSE);
    CreateItemOnObject("rechardsbles_2", GetPCSpeaker(), 1);


    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "rechardstok_2");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "guardiantext");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
