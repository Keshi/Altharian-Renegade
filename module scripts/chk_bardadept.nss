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
    int nMage1 = GetLevelByClass(CLASS_TYPE_BARD, oPC);
    int nMage2 = GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE, oPC);
    int nMage3 = GetLevelByClass(CLASS_TYPE_HARPER, oPC);
    int nMage = nMage1 + nMage2 + nMage3;
    if(nMage >= 21) return TRUE;

    return FALSE;
}
