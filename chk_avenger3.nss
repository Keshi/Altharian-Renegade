int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nCheck = GetCampaignInt("altharia","avengerblessings",oPC);
    if (nCheck > 3) return TRUE;
    SetLocalInt(oPC,"BlessCost",(nCheck - 3));

    return FALSE;
}
