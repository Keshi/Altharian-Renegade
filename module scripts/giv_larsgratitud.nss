//::///////////////////////////////////////////////
//:: FileName giv_larsgratitud
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/7/2005 10:43:47 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 250);

    // Give the speaker the items
    CreateItemOnObject("larsthanks2", GetPCSpeaker(), 1);


    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "signedretraction");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
