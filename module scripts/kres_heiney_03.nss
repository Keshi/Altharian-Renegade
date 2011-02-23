//::///////////////////////////////////////////////
//:: FileName kres_heiney_03
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 4/8/2007 5:13:15 PM
//:://////////////////////////////////////////////
void main()
{
	// Give the speaker some XP
	GiveXPToCreature(GetPCSpeaker(), 1000);

	// Give the speaker the items
	CreateItemOnObject("kres_boatpass", GetPCSpeaker(), 1);


	// Remove items from the player's inventory
	object oItemToTake;
	oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "kres_odd_egg");
	if(GetIsObjectValid(oItemToTake) != 0)
		DestroyObject(oItemToTake);
}
