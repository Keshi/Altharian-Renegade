//::///////////////////////////////////////////////
//:: FileName sc_rerun5
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/24/2003 7:48:47 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "rerunline") == 5))
        return FALSE;

    // Set local variable
    SetLocalInt(GetPCSpeaker(), "rerunline", 6);
    return TRUE;
}
