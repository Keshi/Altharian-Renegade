//::///////////////////////////////////////////////
//:: FileName giv_larsthanks
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/25/2005 10:13:32 PM
//:://////////////////////////////////////////////
void main()
{
	// Give the speaker some XP
	GiveXPToCreature(GetPCSpeaker(), 250);

	// Give the speaker the items
	CreateItemOnObject("larsthanks", GetPCSpeaker(), 1);


	// Remove items from the player's inventory
	object oItemToTake;
	oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "heavyminerals");
	if(GetIsObjectValid(oItemToTake) != 0)
		DestroyObject(oItemToTake);
	oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "millerseeds");
	if(GetIsObjectValid(oItemToTake) != 0)
		DestroyObject(oItemToTake);
}
