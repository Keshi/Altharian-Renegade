//::///////////////////////////////////////////////
//:: FileName kres_at2_jero
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 4/8/2007 8:27:59 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 1000000);

    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 8000);

    // Give the speaker the items
    CreateItemOnObject("wish002", GetPCSpeaker(), 1);


    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "kres_dragonhead");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    // Set the variables
    SetLocalInt(GetPCSpeaker(), "nFirstTimeTalked", 0);

}
