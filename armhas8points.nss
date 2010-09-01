int StartingConditional()
{
    int nTest = GetLocalInt(GetPCSpeaker(),"guildarmpts");
    if (nTest >= 8) return TRUE;

    return FALSE;
}
