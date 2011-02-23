//::///////////////////////////////////////////////
//:: FileName sc_shanequa8
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard and Gameskippy
//:: Created On: 9/24/2003
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Check local variable
    if(!(GetLocalInt(GetPCSpeaker(), "shanequaline") == 8))
        return FALSE;

    // Set local variable
    SetLocalInt(GetPCSpeaker(), "shanequaline", 9);
    return TRUE;

}

