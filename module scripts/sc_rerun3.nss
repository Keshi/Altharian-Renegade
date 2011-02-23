//::///////////////////////////////////////////////
//:: FileName sc_rerun3
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/24/2003 7:48:47 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "rerunline") == 3))
        return FALSE;

    // Set local variable
    SetLocalInt(GetPCSpeaker(), "rerunline", 4);
    return TRUE;
}
