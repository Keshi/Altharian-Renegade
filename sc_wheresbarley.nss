//::///////////////////////////////////////////////
//:: FileName sc_wheresbarley
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard and Gameskippy
//:: Created On: 9/24/2003
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Check local variable
    if(!(GetLocalInt(GetPCSpeaker(), "wheresbarley") == 0))
        return FALSE;

    // Set local variable
    SetLocalInt(GetPCSpeaker(), "wheresbarley", 1);
    return TRUE;

}

