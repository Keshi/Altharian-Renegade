//::///////////////////////////////////////////////
//:: FileName sc_rerun1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/24/2003 7:48:47 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "rerunline") == 1))
        return FALSE;
    SetLocalInt(GetPCSpeaker(), "rerunline", 2);
    return TRUE;
}
