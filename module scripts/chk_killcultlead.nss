//::///////////////////////////////////////////////
//:: FileName chk_killcultlead
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/3/2006 10:20:34 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "cultydead") == 1))
        return FALSE;

    return TRUE;
}