int StartingConditional()
{
    int nTest = GetLocalInt(GetPCSpeaker(),"guildarmpts");
    if (nTest >= 4) return TRUE;

    return FALSE;
}
