//::///////////////////////////////////////////////
//:: FileName is_40
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 1/2/2005 9:40:37 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Restrict based on the player's class
    int iPassed = 0;
    if(GetHitDice(GetPCSpeaker()) >= 40)
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;

    return TRUE;
}
