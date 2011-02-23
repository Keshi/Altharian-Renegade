//::///////////////////////////////////////////////
//:: FileName sc_jayjay1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard and Gameskippy
//:: Created On: 9/24/2003
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Check local variable
    if(!(GetLocalInt(GetPCSpeaker(), "jayjayline") == 1))
        return FALSE;

    // Set local variable
    SetLocalInt(GetPCSpeaker(), "jayjayline", 2);
    return TRUE;

}

