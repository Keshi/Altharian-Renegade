//::///////////////////////////////////////////////
//:: FileName giv_minekey
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/16/2005 10:44:45 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 500);

    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 500);

    // Give the speaker the items
    CreateItemOnObject("minekey", GetPCSpeaker(), 1);


    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "jds_creditchip");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
