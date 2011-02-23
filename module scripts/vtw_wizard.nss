//::///////////////////////////////////////////////
//:: FileName vtw_wizard
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/10/2006 9:45:38 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Restrict based on the player's class
    int iPassed = 0;
    if(GetLevelByClass(CLASS_TYPE_WIZARD, GetPCSpeaker()) >= 1)
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;

    // If gold is disallowed, don't give free scrolls either
    if((GetLocalInt(GetModule(), "iAllowGold") != 1)) return FALSE;

    return TRUE;
}
