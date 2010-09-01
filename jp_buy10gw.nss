//::///////////////////////////////////////////////
//:: FileName jp_buy5gw
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 1/11/2006 2:31:00 AM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 10000000);


    // Remove items from the player's inventory
    object oItemToTake;
    int i;
    for (i=0; i<10; i++)
        {
            oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "wish001");
            if(GetIsObjectValid(oItemToTake) != 0)
                DestroyObject(oItemToTake);
        }
}
