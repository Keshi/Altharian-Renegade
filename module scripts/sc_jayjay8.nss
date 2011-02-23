//::///////////////////////////////////////////////
//:: FileName sc_jayjay8
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard and Gameskippy
//:: Created On: 9/24/2003
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Check local variable
    if(!(GetLocalInt(GetPCSpeaker(), "jayjayline") == 8))
        return FALSE;

    // Set local variable
    SetLocalInt(GetPCSpeaker(), "jayjayline", 9);
    return TRUE;

}

