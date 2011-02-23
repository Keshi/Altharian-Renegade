//::///////////////////////////////////////////////
//:: FileName sc_shanequa3
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard and Gameskippy
//:: Created On: 9/24/2003
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Check local variable
    if(!(GetLocalInt(GetPCSpeaker(), "shanequaline") == 3))
        return FALSE;

    // Set local variable
    SetLocalInt(GetPCSpeaker(), "shanequaline", 4);
    return TRUE;

}

