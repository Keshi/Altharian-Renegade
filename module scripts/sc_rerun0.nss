//::///////////////////////////////////////////////
//:: FileName sc_rerun0
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 9/24/2003 7:47:43 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "rerunline") == 0))
        return FALSE;
    SetLocalInt(GetPCSpeaker(), "rerunline", 1);
    return TRUE;

}

