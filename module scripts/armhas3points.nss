int StartingConditional()
{
    int nTest = GetLocalInt(GetPCSpeaker(),"guildarmpts");
    if (nTest >= 3) return TRUE;

    return FALSE;
}
