//::///////////////////////////////////////////////
//:: FileName kres_at_end
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 5/27/2007 10:12:39 AM
//:://////////////////////////////////////////////
void main()
{
	// Give the speaker some gold
	GiveGoldToCreature(GetPCSpeaker(), 1000);

	// Give the speaker some XP
	GiveXPToCreature(GetPCSpeaker(), 250);

	// Give the speaker the items
	CreateItemOnObject("kres_torch", GetPCSpeaker(), 1);

}
