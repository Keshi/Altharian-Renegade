//::///////////////////////////////////////////////
//:: FileName giv_millseeds
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/24/2005 11:07:12 PM
//:://////////////////////////////////////////////
void main()
{
	// Give the speaker some XP
	GiveXPToCreature(GetPCSpeaker(), 250);

	// Give the speaker the items
	CreateItemOnObject("millerseeds", GetPCSpeaker(), 1);


	// Remove items from the player's inventory
	object oItemToTake;
	oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "millerkey");
	if(GetIsObjectValid(oItemToTake) != 0)
		DestroyObject(oItemToTake);
	oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "montyponytail");
	if(GetIsObjectValid(oItemToTake) != 0)
		DestroyObject(oItemToTake);
}
