//::///////////////////////////////////////////////
//:: FileName sc_onmafirst
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/16/2003 8:29:23 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Inspect local variables
	if(!(GetLocalInt(GetPCSpeaker(), "onmafirst") == 1))
		return FALSE;

	return TRUE;
}
