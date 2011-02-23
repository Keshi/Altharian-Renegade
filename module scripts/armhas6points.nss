int StartingConditional()
{
    int nTest = GetLocalInt(GetPCSpeaker(),"guildarmpts");
    if (nTest >= 6) return TRUE;

    return FALSE;
}
