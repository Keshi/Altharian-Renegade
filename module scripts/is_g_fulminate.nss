//::///////////////////////////////////////////////
//:: is_g_** guardian scripts
//:: Check for presence of old guardian variables
//:: For use in conversion to new system.
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    int nCheck = GetCampaignInt("Character","fulminate",oPC);
    if (nCheck >= 1) return TRUE;

    return FALSE;
}
