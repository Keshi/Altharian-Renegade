//::///////////////////////////////////////////////
//:: FileName sc_checkwellhelp
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/10/2003 9:36:26 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Inspect local variables
	if(!(GetLocalInt(GetPCSpeaker(), "wellhelp") == 1))
		return FALSE;

	return TRUE;
}
