//::///////////////////////////////////////////////
//:: FileName chk_arcaneadept
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 3/6/2006 9:56:21 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Restrict based on the player's class
    object oPC = GetPCSpeaker();
    int nMage1 = GetLevelByClass(CLASS_TYPE_WIZARD, oPC);
    int nMage2 = GetLevelByClass(CLASS_TYPE_SORCERER, oPC);
    int nMage = nMage1 + nMage2;
    if(nMage >= 20) return TRUE;

    return FALSE;
}
