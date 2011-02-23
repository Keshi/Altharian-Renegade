//::///////////////////////////////////////////////
//:: FileName jp_trade1uw
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 1/11/2006 2:33:14 AM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    CreateItemOnObject("wish001", GetPCSpeaker(), 1);
    CreateItemOnObject("wish001", GetPCSpeaker(), 1);

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "ultimatewish");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
