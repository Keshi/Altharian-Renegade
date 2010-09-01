//::///////////////////////////////////////////////
//:: FileName restring101
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2/9/2004 11:21:38 AM
//:://////////////////////////////////////////////
void main()
{

    // Remove some gold from the player
    TakeGoldFromCreature(200000, GetPCSpeaker(), TRUE);

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "steel_02");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "demongut");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);

     // and give him the key
        CreateItemOnObject("steel_202", GetPCSpeaker(), 1);
}
