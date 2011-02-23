//::///////////////////////////////////////////////
//:: FileName sc_shanequa5
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard and Gameskippy
//:: Created On: 9/24/2003
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Check local variable
    if(!(GetLocalInt(GetPCSpeaker(), "shanequaline") == 5))
        return FALSE;

    // Set local variable
    SetLocalInt(GetPCSpeaker(), "shanequaline", 6);
    return TRUE;

}

