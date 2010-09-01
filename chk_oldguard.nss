//::///////////////////////////////////////////////
//:: chk_oldguard guardian scripts
//:: Check for presence of old guardian variables
//:: For use in conversion to new system.
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    int nCheck = GetCampaignInt("Character","stilletto",oPC);
    if (nCheck >= 1) return TRUE;

    nCheck = GetCampaignInt("Character","vesperbel",oPC);
    if (nCheck >= 1) return TRUE;

    nCheck = GetCampaignInt("Character","fulminate",oPC);
    if (nCheck >= 1) return TRUE;

    nCheck = GetCampaignInt("Character","magestaff",oPC);
    if (nCheck >= 1) return TRUE;

    nCheck = GetCampaignInt("Character","innerpath",oPC);
    if (nCheck >= 1) return TRUE;

    nCheck = GetCampaignInt("Character","harmonics",oPC);
    if (nCheck >= 1) return TRUE;

    nCheck = GetCampaignInt("Character","whitegold",oPC);
    if (nCheck >= 1) return TRUE;

    return FALSE;
}
