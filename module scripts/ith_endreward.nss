//::///////////////////////////////////////////////
//:: FileName ith_deathreward
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/22/2005 10:49:21 AM
//:://////////////////////////////////////////////
void main()
{

    // Remove items from the player's inventory
    object oItemToTake;
    object oPC = GetPCSpeaker();
    int nHeads = GetCampaignInt("altharia","deathheads",oPC);
    oItemToTake = GetItemPossessedBy(oPC, "deathskull");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);

    // Give the speaker some gold
    GiveGoldToCreature(oPC, 100000);

    // Give the speaker some XP
    GiveXPToCreature(oPC, 5000);

    // Give the speaker the items
    CreateItemOnObject("ultimatewish", oPC, 1);
    SetCampaignInt("altharia","deathheads",nHeads+1,oPC);

}
