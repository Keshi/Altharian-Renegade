//::///////////////////////////////////////////////
//:: FileName sc_jonan002
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2/2/2003 10:00:03 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Inspect local variables
	if(!(GetLocalInt(GetPCSpeaker(), "jonan_riddle") != 1))
		return FALSE;

	return TRUE;
}
