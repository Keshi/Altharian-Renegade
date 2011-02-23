//::///////////////////////////////////////////////
//:: FileName sc_jayjay3
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard and Gameskippy
//:: Created On: 9/24/2003
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Check local variable
    if(!(GetLocalInt(GetPCSpeaker(), "jayjayline") == 3))
        return FALSE;

    // Set local variable
    SetLocalInt(GetPCSpeaker(), "jayjayline", 4);
    return TRUE;

}

