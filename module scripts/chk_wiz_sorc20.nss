//:: FileName chk_wiz_sorc20
// Used for Fjorn's Store in Viisfjorg
int StartingConditional()
{

    // Restrict based on the player's class
    int iPassed = 0;
    if(GetLevelByClass(CLASS_TYPE_SORCERER, GetPCSpeaker()) >= 20)
        iPassed = 1;
    if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_WIZARD, GetPCSpeaker()) >= 20))
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;

    return TRUE;
}
