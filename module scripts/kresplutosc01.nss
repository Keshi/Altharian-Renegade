//::///////////////////////////////////////////////
//:: FileName kresplutosc01
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 4/22/2007 4:09:20 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Inspect local variables
	if(!(GetLocalInt(GetPCSpeaker(), "nFirstTimeTalked") == 1))
		return FALSE;

	return TRUE;
}