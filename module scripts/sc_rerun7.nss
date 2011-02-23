//::///////////////////////////////////////////////
//:: FileName sc_rerun7
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/24/2003 7:48:47 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "rerunline") == 7))
        return FALSE;

    // Set local variable
    SetLocalInt(GetPCSpeaker(), "rerunline", 8);
    return TRUE;
}
