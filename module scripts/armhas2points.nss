int StartingConditional()
{
    int nTest = GetLocalInt(GetPCSpeaker(),"guildarmpts");
    if (nTest >= 2) return TRUE;

    return FALSE;
}
