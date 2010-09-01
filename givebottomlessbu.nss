//::///////////////////////////////////////////////
//:: FileName donation1000
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/15/02 1:31:30 PM
//:://////////////////////////////////////////////
void main()
{

       if(GetGold(GetPCSpeaker()) < 500000)
    {
        SendMessageToPC(GetPCSpeaker(), "You cannot afford this donation.");
        return;
    }




    // Give the speaker the items
    CreateItemOnObject("bottomlessbulle", GetPCSpeaker(), 1);


    // Remove some gold from the player
    TakeGoldFromCreature(500000, GetPCSpeaker(), TRUE);
}
