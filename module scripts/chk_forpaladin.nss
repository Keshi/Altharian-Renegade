//::///////////////////////////////////////////////
//:: FileName chk_forpaladin
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created Incorrectly By: Script Wizard
//:: Fixed by Winterknight on 10/10/05
//:: Created On: 10/9/2005 2:05:31 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Restrict based on the player's class

    object oPC = GetPCSpeaker();
    int nPallyLevel = GetLevelByClass(CLASS_TYPE_PALADIN, oPC);
    if(nPallyLevel >= 5) return TRUE;

    return FALSE;

}
